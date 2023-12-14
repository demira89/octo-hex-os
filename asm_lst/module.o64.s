
module.o64:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <memcpy>:
const char* get_section_type_string(Elf32_Word tp)
{
		if (tp == SHT_PROGBITS)
				return "PROGBITS";
		else if (tp == SHT_SYMTAB)
				return "SYMTAB";
       0:	55                   	push   rbp
       1:	48 89 e5             	mov    rbp,rsp
       4:	48 83 ec 28          	sub    rsp,0x28
       8:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
       c:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
      10:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
		else if (tp == SHT_DYNSYM)
      14:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
      18:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				return "DYNSYM";
      1c:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
      20:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		else if (tp == SHT_STRTAB)
      24:	eb 1d                	jmp    43 <memcpy+0x43>
				return "STRTAB";
      26:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
      2a:	48 8d 42 01          	lea    rax,[rdx+0x1]
      2e:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
      32:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      36:	48 8d 48 01          	lea    rcx,[rax+0x1]
      3a:	48 89 4d f8          	mov    QWORD PTR [rbp-0x8],rcx
      3e:	0f b6 12             	movzx  edx,BYTE PTR [rdx]
      41:	88 10                	mov    BYTE PTR [rax],dl
		else if (tp == SHT_STRTAB)
      43:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
      47:	48 8d 50 ff          	lea    rdx,[rax-0x1]
      4b:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
      4f:	48 85 c0             	test   rax,rax
      52:	75 d2                	jne    26 <memcpy+0x26>
		else if (tp == SHT_RELA)
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
     12e:	48 83 ec 70          	sub    rsp,0x70
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
     1be:	0f 86 d0 02 00 00    	jbe    494 <elf_dump_symtab+0x36a>
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
     1f5:	e9 8a 02 00 00       	jmp    484 <elf_dump_symtab+0x35a>
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
     448:	4c 8b 45 d8          	mov    r8,QWORD PTR [rbp-0x28]
     44c:	48 8b 7d e0          	mov    rdi,QWORD PTR [rbp-0x20]
     450:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     454:	48 8b 75 f0          	mov    rsi,QWORD PTR [rbp-0x10]
     458:	48 89 74 24 08       	mov    QWORD PTR [rsp+0x8],rsi
     45d:	48 8b 75 e8          	mov    rsi,QWORD PTR [rbp-0x18]
     461:	48 89 34 24          	mov    QWORD PTR [rsp],rsi
     465:	4d 89 c1             	mov    r9,r8
     468:	49 89 f8             	mov    r8,rdi
     46b:	48 89 c6             	mov    rsi,rax
     46e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     475:	b8 00 00 00 00       	mov    eax,0x0
     47a:	e8 00 00 00 00       	call   47f <elf_dump_symtab+0x355>
		for (i = 1; i < ct; i++) {
     47f:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
     484:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     488:	48 3b 45 c8          	cmp    rax,QWORD PTR [rbp-0x38]
     48c:	0f 82 68 fd ff ff    	jb     1fa <elf_dump_symtab+0xd0>
     492:	eb 01                	jmp    495 <elf_dump_symtab+0x36b>
				return;
     494:	90                   	nop
}
     495:	c9                   	leave
     496:	c3                   	ret

0000000000000497 <elf_rel_type_string>:
{
     497:	55                   	push   rbp
     498:	48 89 e5             	mov    rbp,rsp
     49b:	48 83 ec 08          	sub    rsp,0x8
     49f:	89 7d fc             	mov    DWORD PTR [rbp-0x4],edi
		switch (t) {
     4a2:	83 7d fc 0a          	cmp    DWORD PTR [rbp-0x4],0xa
     4a6:	77 70                	ja     518 <elf_rel_type_string+0x81>
     4a8:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     4ab:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
     4b3:	ff e0                	jmp    rax
				return "R_386_NONE";
     4b5:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     4bc:	eb 61                	jmp    51f <elf_rel_type_string+0x88>
				return "R_386_32";
     4be:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     4c5:	eb 58                	jmp    51f <elf_rel_type_string+0x88>
				return "R_386_PC32";
     4c7:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     4ce:	eb 4f                	jmp    51f <elf_rel_type_string+0x88>
				return "R_386_GOT32";
     4d0:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     4d7:	eb 46                	jmp    51f <elf_rel_type_string+0x88>
				return "R_386_PLT32";
     4d9:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     4e0:	eb 3d                	jmp    51f <elf_rel_type_string+0x88>
				return "R_386_COPY";
     4e2:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     4e9:	eb 34                	jmp    51f <elf_rel_type_string+0x88>
				return "R_386_GLOB_DAT";
     4eb:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     4f2:	eb 2b                	jmp    51f <elf_rel_type_string+0x88>
				return "R_386_JMP_SLOT";
     4f4:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     4fb:	eb 22                	jmp    51f <elf_rel_type_string+0x88>
				return "R_386_RELATIVE";
     4fd:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     504:	eb 19                	jmp    51f <elf_rel_type_string+0x88>
				return "R_386_GOTOFF";
     506:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     50d:	eb 10                	jmp    51f <elf_rel_type_string+0x88>
				return "R_386_GOTPC";
     50f:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     516:	eb 07                	jmp    51f <elf_rel_type_string+0x88>
				return "UNKNOWN";
     518:	48 c7 c0 00 00 00 00 	mov    rax,0x0
}
     51f:	c9                   	leave
     520:	c3                   	ret

0000000000000521 <elf_dump_rel>:
{
     521:	55                   	push   rbp
     522:	48 89 e5             	mov    rbp,rsp
     525:	41 54                	push   r12
     527:	53                   	push   rbx
     528:	48 81 ec a0 00 00 00 	sub    rsp,0xa0
     52f:	48 89 bd 78 ff ff ff 	mov    QWORD PTR [rbp-0x88],rdi
     536:	48 89 b5 70 ff ff ff 	mov    QWORD PTR [rbp-0x90],rsi
     53d:	89 d0                	mov    eax,edx
     53f:	66 89 85 6c ff ff ff 	mov    WORD PTR [rbp-0x94],ax
		void* ptr = ((void*)hdr + shdr[rel].sh_offset), *sptr, *stptr;
     546:	0f b7 95 6c ff ff ff 	movzx  edx,WORD PTR [rbp-0x94]
     54d:	48 89 d0             	mov    rax,rdx
     550:	48 c1 e0 02          	shl    rax,0x2
     554:	48 01 d0             	add    rax,rdx
     557:	48 c1 e0 03          	shl    rax,0x3
     55b:	48 89 c2             	mov    rdx,rax
     55e:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     565:	48 01 d0             	add    rax,rdx
     568:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     56b:	89 c2                	mov    edx,eax
     56d:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     574:	48 01 d0             	add    rax,rdx
     577:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
		size_t i, ct = shdr[rel].sh_size / shdr[rel].sh_entsize;
     57b:	0f b7 95 6c ff ff ff 	movzx  edx,WORD PTR [rbp-0x94]
     582:	48 89 d0             	mov    rax,rdx
     585:	48 c1 e0 02          	shl    rax,0x2
     589:	48 01 d0             	add    rax,rdx
     58c:	48 c1 e0 03          	shl    rax,0x3
     590:	48 89 c2             	mov    rdx,rax
     593:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     59a:	48 01 d0             	add    rax,rdx
     59d:	8b 48 14             	mov    ecx,DWORD PTR [rax+0x14]
     5a0:	0f b7 95 6c ff ff ff 	movzx  edx,WORD PTR [rbp-0x94]
     5a7:	48 89 d0             	mov    rax,rdx
     5aa:	48 c1 e0 02          	shl    rax,0x2
     5ae:	48 01 d0             	add    rax,rdx
     5b1:	48 c1 e0 03          	shl    rax,0x3
     5b5:	48 89 c2             	mov    rdx,rax
     5b8:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     5bf:	48 01 d0             	add    rax,rdx
     5c2:	8b 58 24             	mov    ebx,DWORD PTR [rax+0x24]
     5c5:	89 c8                	mov    eax,ecx
     5c7:	ba 00 00 00 00       	mov    edx,0x0
     5cc:	f7 f3                	div    ebx
     5ce:	89 c0                	mov    eax,eax
     5d0:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
		if (!ct)
     5d4:	48 83 7d c8 00       	cmp    QWORD PTR [rbp-0x38],0x0
     5d9:	0f 84 71 04 00 00    	je     a50 <elf_dump_rel+0x52f>
		sptr = (void*)hdr + shdr[shdr[rel].sh_info].sh_offset;
     5df:	0f b7 95 6c ff ff ff 	movzx  edx,WORD PTR [rbp-0x94]
     5e6:	48 89 d0             	mov    rax,rdx
     5e9:	48 c1 e0 02          	shl    rax,0x2
     5ed:	48 01 d0             	add    rax,rdx
     5f0:	48 c1 e0 03          	shl    rax,0x3
     5f4:	48 89 c2             	mov    rdx,rax
     5f7:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     5fe:	48 01 d0             	add    rax,rdx
     601:	8b 40 1c             	mov    eax,DWORD PTR [rax+0x1c]
     604:	89 c2                	mov    edx,eax
     606:	48 89 d0             	mov    rax,rdx
     609:	48 c1 e0 02          	shl    rax,0x2
     60d:	48 01 d0             	add    rax,rdx
     610:	48 c1 e0 03          	shl    rax,0x3
     614:	48 89 c2             	mov    rdx,rax
     617:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     61e:	48 01 d0             	add    rax,rdx
     621:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     624:	89 c2                	mov    edx,eax
     626:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     62d:	48 01 d0             	add    rax,rdx
     630:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
		stptr = (void*)hdr + shdr[shdr[rel].sh_link].sh_offset;
     634:	0f b7 95 6c ff ff ff 	movzx  edx,WORD PTR [rbp-0x94]
     63b:	48 89 d0             	mov    rax,rdx
     63e:	48 c1 e0 02          	shl    rax,0x2
     642:	48 01 d0             	add    rax,rdx
     645:	48 c1 e0 03          	shl    rax,0x3
     649:	48 89 c2             	mov    rdx,rax
     64c:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     653:	48 01 d0             	add    rax,rdx
     656:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
     659:	89 c2                	mov    edx,eax
     65b:	48 89 d0             	mov    rax,rdx
     65e:	48 c1 e0 02          	shl    rax,0x2
     662:	48 01 d0             	add    rax,rdx
     665:	48 c1 e0 03          	shl    rax,0x3
     669:	48 89 c2             	mov    rdx,rax
     66c:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     673:	48 01 d0             	add    rax,rdx
     676:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     679:	89 c2                	mov    edx,eax
     67b:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     682:	48 01 d0             	add    rax,rdx
     685:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
		stb = shdr + shdr[rel].sh_link;
     689:	0f b7 95 6c ff ff ff 	movzx  edx,WORD PTR [rbp-0x94]
     690:	48 89 d0             	mov    rax,rdx
     693:	48 c1 e0 02          	shl    rax,0x2
     697:	48 01 d0             	add    rax,rdx
     69a:	48 c1 e0 03          	shl    rax,0x3
     69e:	48 89 c2             	mov    rdx,rax
     6a1:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     6a8:	48 01 d0             	add    rax,rdx
     6ab:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
     6ae:	89 c2                	mov    edx,eax
     6b0:	48 89 d0             	mov    rax,rdx
     6b3:	48 c1 e0 02          	shl    rax,0x2
     6b7:	48 01 d0             	add    rax,rdx
     6ba:	48 c1 e0 03          	shl    rax,0x3
     6be:	48 89 c2             	mov    rdx,rax
     6c1:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     6c8:	48 01 d0             	add    rax,rdx
     6cb:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
		printf("dumping relocations with %lu entries\n", ct);
     6cf:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     6d3:	48 89 c6             	mov    rsi,rax
     6d6:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     6dd:	b8 00 00 00 00       	mov    eax,0x0
     6e2:	e8 00 00 00 00       	call   6e7 <elf_dump_rel+0x1c6>
			shdr, hdr->e_shstrndx, shdr[shdr[rel].sh_info].sh_name));
     6e7:	0f b7 95 6c ff ff ff 	movzx  edx,WORD PTR [rbp-0x94]
     6ee:	48 89 d0             	mov    rax,rdx
     6f1:	48 c1 e0 02          	shl    rax,0x2
     6f5:	48 01 d0             	add    rax,rdx
     6f8:	48 c1 e0 03          	shl    rax,0x3
     6fc:	48 89 c2             	mov    rdx,rax
     6ff:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     706:	48 01 d0             	add    rax,rdx
     709:	8b 40 1c             	mov    eax,DWORD PTR [rax+0x1c]
     70c:	89 c2                	mov    edx,eax
     70e:	48 89 d0             	mov    rax,rdx
     711:	48 c1 e0 02          	shl    rax,0x2
     715:	48 01 d0             	add    rax,rdx
     718:	48 c1 e0 03          	shl    rax,0x3
     71c:	48 89 c2             	mov    rdx,rax
     71f:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     726:	48 01 d0             	add    rax,rdx
		printf("relocations apply to section %s\n", elf_fetch_string(hdr,
     729:	8b 08                	mov    ecx,DWORD PTR [rax]
			shdr, hdr->e_shstrndx, shdr[shdr[rel].sh_info].sh_name));
     72b:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     732:	0f b7 40 32          	movzx  eax,WORD PTR [rax+0x32]
		printf("relocations apply to section %s\n", elf_fetch_string(hdr,
     736:	0f b7 d0             	movzx  edx,ax
     739:	48 8b b5 70 ff ff ff 	mov    rsi,QWORD PTR [rbp-0x90]
     740:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     747:	48 89 c7             	mov    rdi,rax
     74a:	e8 00 00 00 00       	call   74f <elf_dump_rel+0x22e>
     74f:	48 89 c6             	mov    rsi,rax
     752:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     759:	b8 00 00 00 00       	mov    eax,0x0
     75e:	e8 00 00 00 00       	call   763 <elf_dump_rel+0x242>
		printf("   Num:   Offset Type              Field SyNdx SymbolName\n");
     763:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     76a:	b8 00 00 00 00       	mov    eax,0x0
     76f:	e8 00 00 00 00       	call   774 <elf_dump_rel+0x253>
		for (i = 0; i < ct; i++) {
     774:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
     77c:	e9 bf 02 00 00       	jmp    a40 <elf_dump_rel+0x51f>
				Elf32_Rela* r = (ptr + i * shdr[rel].sh_entsize);
     781:	0f b7 95 6c ff ff ff 	movzx  edx,WORD PTR [rbp-0x94]
     788:	48 89 d0             	mov    rax,rdx
     78b:	48 c1 e0 02          	shl    rax,0x2
     78f:	48 01 d0             	add    rax,rdx
     792:	48 c1 e0 03          	shl    rax,0x3
     796:	48 89 c2             	mov    rdx,rax
     799:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     7a0:	48 01 d0             	add    rax,rdx
     7a3:	8b 40 24             	mov    eax,DWORD PTR [rax+0x24]
     7a6:	89 c0                	mov    eax,eax
     7a8:	48 0f af 45 e8       	imul   rax,QWORD PTR [rbp-0x18]
     7ad:	48 89 c2             	mov    rdx,rax
     7b0:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     7b4:	48 01 d0             	add    rax,rdx
     7b7:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
				Elf32_Sym* s = (stptr + ELF32_R_SYM(r->r_info) * stb->sh_entsize);
     7bb:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     7bf:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
     7c2:	c1 e8 08             	shr    eax,0x8
     7c5:	89 c2                	mov    edx,eax
     7c7:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     7cb:	8b 40 24             	mov    eax,DWORD PTR [rax+0x24]
     7ce:	0f af c2             	imul   eax,edx
     7d1:	89 c2                	mov    edx,eax
     7d3:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     7d7:	48 01 d0             	add    rax,rdx
     7da:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
				const char* sn; char dat[] = "DAT: ........";
     7de:	48 b8 44 41 54 3a 20 2e 2e 2e 	movabs rax,0x2e2e2e203a544144
     7e8:	48 89 45 86          	mov    QWORD PTR [rbp-0x7a],rax
     7ec:	48 b8 2e 2e 2e 2e 2e 2e 2e 00 	movabs rax,0x2e2e2e2e2e2e2e
     7f6:	48 89 45 8c          	mov    QWORD PTR [rbp-0x74],rax
				if (s->st_name)
     7fa:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     7fe:	8b 00                	mov    eax,DWORD PTR [rax]
     800:	85 c0                	test   eax,eax
     802:	74 2f                	je     833 <elf_dump_rel+0x312>
						sn = elf_fetch_string(hdr, shdr, stb->sh_link, s->st_name);
     804:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     808:	8b 08                	mov    ecx,DWORD PTR [rax]
     80a:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     80e:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
     811:	0f b7 d0             	movzx  edx,ax
     814:	48 8b b5 70 ff ff ff 	mov    rsi,QWORD PTR [rbp-0x90]
     81b:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     822:	48 89 c7             	mov    rdi,rax
     825:	e8 00 00 00 00       	call   82a <elf_dump_rel+0x309>
     82a:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
     82e:	e9 a7 01 00 00       	jmp    9da <elf_dump_rel+0x4b9>
				else if ((shdr[s->st_shndx].sh_flags & SHF_WRITE) == 0
     833:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     837:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     83b:	0f b7 d0             	movzx  edx,ax
     83e:	48 89 d0             	mov    rax,rdx
     841:	48 c1 e0 02          	shl    rax,0x2
     845:	48 01 d0             	add    rax,rdx
     848:	48 c1 e0 03          	shl    rax,0x3
     84c:	48 89 c2             	mov    rdx,rax
     84f:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     856:	48 01 d0             	add    rax,rdx
     859:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
     85c:	83 e0 01             	and    eax,0x1
     85f:	85 c0                	test   eax,eax
     861:	0f 85 23 01 00 00    	jne    98a <elf_dump_rel+0x469>
						&& shdr[s->st_shndx].sh_flags & SHF_ALLOC
     867:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     86b:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     86f:	0f b7 d0             	movzx  edx,ax
     872:	48 89 d0             	mov    rax,rdx
     875:	48 c1 e0 02          	shl    rax,0x2
     879:	48 01 d0             	add    rax,rdx
     87c:	48 c1 e0 03          	shl    rax,0x3
     880:	48 89 c2             	mov    rdx,rax
     883:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     88a:	48 01 d0             	add    rax,rdx
     88d:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
     890:	83 e0 02             	and    eax,0x2
     893:	85 c0                	test   eax,eax
     895:	0f 84 ef 00 00 00    	je     98a <elf_dump_rel+0x469>
						&& (shdr[s->st_shndx].sh_flags & SHF_EXECINSTR) == 0) {
     89b:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     89f:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     8a3:	0f b7 d0             	movzx  edx,ax
     8a6:	48 89 d0             	mov    rax,rdx
     8a9:	48 c1 e0 02          	shl    rax,0x2
     8ad:	48 01 d0             	add    rax,rdx
     8b0:	48 c1 e0 03          	shl    rax,0x3
     8b4:	48 89 c2             	mov    rdx,rax
     8b7:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     8be:	48 01 d0             	add    rax,rdx
     8c1:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
     8c4:	83 e0 04             	and    eax,0x4
     8c7:	85 c0                	test   eax,eax
     8c9:	0f 85 bb 00 00 00    	jne    98a <elf_dump_rel+0x469>
						const char* c = (void*)hdr + shdr[s->st_shndx].sh_offset;
     8cf:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     8d3:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     8d7:	0f b7 d0             	movzx  edx,ax
     8da:	48 89 d0             	mov    rax,rdx
     8dd:	48 c1 e0 02          	shl    rax,0x2
     8e1:	48 01 d0             	add    rax,rdx
     8e4:	48 c1 e0 03          	shl    rax,0x3
     8e8:	48 89 c2             	mov    rdx,rax
     8eb:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     8f2:	48 01 d0             	add    rax,rdx
     8f5:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     8f8:	89 c2                	mov    edx,eax
     8fa:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     901:	48 01 d0             	add    rax,rdx
     904:	48 89 45 98          	mov    QWORD PTR [rbp-0x68],rax
						uint32_t of = *(uint32_t*)(sptr + r->r_offset), j;
     908:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     90c:	8b 00                	mov    eax,DWORD PTR [rax]
     90e:	89 c2                	mov    edx,eax
     910:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     914:	48 01 d0             	add    rax,rdx
     917:	8b 00                	mov    eax,DWORD PTR [rax]
     919:	89 45 94             	mov    DWORD PTR [rbp-0x6c],eax
						for (j = 0; j < 8; j++)
     91c:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [rbp-0x24],0x0
     923:	eb 55                	jmp    97a <elf_dump_rel+0x459>
								if (isprint(c[of + j]))
     925:	8b 55 94             	mov    edx,DWORD PTR [rbp-0x6c]
     928:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
     92b:	01 d0                	add    eax,edx
     92d:	89 c2                	mov    edx,eax
     92f:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
     933:	48 01 d0             	add    rax,rdx
     936:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     939:	0f be c0             	movsx  eax,al
     93c:	89 c7                	mov    edi,eax
     93e:	e8 00 00 00 00       	call   943 <elf_dump_rel+0x422>
     943:	85 c0                	test   eax,eax
     945:	74 22                	je     969 <elf_dump_rel+0x448>
										dat[j + 5] = c[of + j];
     947:	8b 55 94             	mov    edx,DWORD PTR [rbp-0x6c]
     94a:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
     94d:	01 d0                	add    eax,edx
     94f:	89 c2                	mov    edx,eax
     951:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
     955:	48 01 d0             	add    rax,rdx
     958:	8b 55 dc             	mov    edx,DWORD PTR [rbp-0x24]
     95b:	83 c2 05             	add    edx,0x5
     95e:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     961:	89 d2                	mov    edx,edx
     963:	88 44 15 86          	mov    BYTE PTR [rbp+rdx*1-0x7a],al
     967:	eb 0d                	jmp    976 <elf_dump_rel+0x455>
										dat[j + 5] = '.';
     969:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
     96c:	83 c0 05             	add    eax,0x5
     96f:	89 c0                	mov    eax,eax
     971:	c6 44 05 86 2e       	mov    BYTE PTR [rbp+rax*1-0x7a],0x2e
						for (j = 0; j < 8; j++)
     976:	83 45 dc 01          	add    DWORD PTR [rbp-0x24],0x1
     97a:	83 7d dc 07          	cmp    DWORD PTR [rbp-0x24],0x7
     97e:	76 a5                	jbe    925 <elf_dump_rel+0x404>
						sn = dat;
     980:	48 8d 45 86          	lea    rax,[rbp-0x7a]
     984:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
						&& (shdr[s->st_shndx].sh_flags & SHF_EXECINSTR) == 0) {
     988:	eb 50                	jmp    9da <elf_dump_rel+0x4b9>
						sn = elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[s->st_shndx].sh_name);
     98a:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     98e:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     992:	0f b7 d0             	movzx  edx,ax
     995:	48 89 d0             	mov    rax,rdx
     998:	48 c1 e0 02          	shl    rax,0x2
     99c:	48 01 d0             	add    rax,rdx
     99f:	48 c1 e0 03          	shl    rax,0x3
     9a3:	48 89 c2             	mov    rdx,rax
     9a6:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     9ad:	48 01 d0             	add    rax,rdx
     9b0:	8b 08                	mov    ecx,DWORD PTR [rax]
     9b2:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     9b9:	0f b7 40 32          	movzx  eax,WORD PTR [rax+0x32]
     9bd:	0f b7 d0             	movzx  edx,ax
     9c0:	48 8b b5 70 ff ff ff 	mov    rsi,QWORD PTR [rbp-0x90]
     9c7:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     9ce:	48 89 c7             	mov    rdi,rax
     9d1:	e8 00 00 00 00       	call   9d6 <elf_dump_rel+0x4b5>
     9d6:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
					*(uint32_t*)(sptr + r->r_offset), ELF32_R_SYM(r->r_info), sn);
     9da:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     9de:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
				printf("%6lu: %8x %14s %8x %5u %.13s\n", i, r->r_offset,
     9e1:	c1 e8 08             	shr    eax,0x8
     9e4:	41 89 c4             	mov    r12d,eax
					*(uint32_t*)(sptr + r->r_offset), ELF32_R_SYM(r->r_info), sn);
     9e7:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     9eb:	8b 00                	mov    eax,DWORD PTR [rax]
     9ed:	89 c2                	mov    edx,eax
     9ef:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     9f3:	48 01 d0             	add    rax,rdx
				printf("%6lu: %8x %14s %8x %5u %.13s\n", i, r->r_offset,
     9f6:	8b 18                	mov    ebx,DWORD PTR [rax]
					elf_rel_type_string(ELF32_R_TYPE(r->r_info)),
     9f8:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     9fc:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
				printf("%6lu: %8x %14s %8x %5u %.13s\n", i, r->r_offset,
     9ff:	0f b6 c0             	movzx  eax,al
     a02:	89 c7                	mov    edi,eax
     a04:	e8 00 00 00 00       	call   a09 <elf_dump_rel+0x4e8>
     a09:	48 89 c6             	mov    rsi,rax
     a0c:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     a10:	8b 10                	mov    edx,DWORD PTR [rax]
     a12:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     a16:	48 8b 4d e0          	mov    rcx,QWORD PTR [rbp-0x20]
     a1a:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
     a1e:	45 89 e1             	mov    r9d,r12d
     a21:	41 89 d8             	mov    r8d,ebx
     a24:	48 89 f1             	mov    rcx,rsi
     a27:	48 89 c6             	mov    rsi,rax
     a2a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     a31:	b8 00 00 00 00       	mov    eax,0x0
     a36:	e8 00 00 00 00       	call   a3b <elf_dump_rel+0x51a>
		for (i = 0; i < ct; i++) {
     a3b:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
     a40:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     a44:	48 3b 45 c8          	cmp    rax,QWORD PTR [rbp-0x38]
     a48:	0f 82 33 fd ff ff    	jb     781 <elf_dump_rel+0x260>
     a4e:	eb 01                	jmp    a51 <elf_dump_rel+0x530>
				return;
     a50:	90                   	nop
}
     a51:	48 81 c4 a0 00 00 00 	add    rsp,0xa0
     a58:	5b                   	pop    rbx
     a59:	41 5c                	pop    r12
     a5b:	5d                   	pop    rbp
     a5c:	c3                   	ret

0000000000000a5d <elf_relocate_section>:
{
     a5d:	55                   	push   rbp
     a5e:	48 89 e5             	mov    rbp,rsp
     a61:	48 83 ec 70          	sub    rsp,0x70
     a65:	48 89 7d a8          	mov    QWORD PTR [rbp-0x58],rdi
     a69:	48 89 75 a0          	mov    QWORD PTR [rbp-0x60],rsi
     a6d:	89 d0                	mov    eax,edx
     a6f:	66 89 45 9c          	mov    WORD PTR [rbp-0x64],ax
		void* ptr = ((void*)hdr + shdr[rel].sh_offset), *sptr, *stptr;
     a73:	0f b7 55 9c          	movzx  edx,WORD PTR [rbp-0x64]
     a77:	48 89 d0             	mov    rax,rdx
     a7a:	48 c1 e0 02          	shl    rax,0x2
     a7e:	48 01 d0             	add    rax,rdx
     a81:	48 c1 e0 03          	shl    rax,0x3
     a85:	48 89 c2             	mov    rdx,rax
     a88:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     a8c:	48 01 d0             	add    rax,rdx
     a8f:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     a92:	89 c2                	mov    edx,eax
     a94:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     a98:	48 01 d0             	add    rax,rdx
     a9b:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		size_t i, ct = shdr[rel].sh_size / shdr[rel].sh_entsize;
     a9f:	0f b7 55 9c          	movzx  edx,WORD PTR [rbp-0x64]
     aa3:	48 89 d0             	mov    rax,rdx
     aa6:	48 c1 e0 02          	shl    rax,0x2
     aaa:	48 01 d0             	add    rax,rdx
     aad:	48 c1 e0 03          	shl    rax,0x3
     ab1:	48 89 c2             	mov    rdx,rax
     ab4:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     ab8:	48 01 d0             	add    rax,rdx
     abb:	8b 48 14             	mov    ecx,DWORD PTR [rax+0x14]
     abe:	0f b7 55 9c          	movzx  edx,WORD PTR [rbp-0x64]
     ac2:	48 89 d0             	mov    rax,rdx
     ac5:	48 c1 e0 02          	shl    rax,0x2
     ac9:	48 01 d0             	add    rax,rdx
     acc:	48 c1 e0 03          	shl    rax,0x3
     ad0:	48 89 c2             	mov    rdx,rax
     ad3:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     ad7:	48 01 d0             	add    rax,rdx
     ada:	8b 78 24             	mov    edi,DWORD PTR [rax+0x24]
     add:	89 c8                	mov    eax,ecx
     adf:	ba 00 00 00 00       	mov    edx,0x0
     ae4:	f7 f7                	div    edi
     ae6:	89 c0                	mov    eax,eax
     ae8:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
		if (!ct)
     aec:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
     af1:	0f 84 cb 02 00 00    	je     dc2 <elf_relocate_section+0x365>
		sptr = (void*)shdr[shdr[rel].sh_info].sh_addr; /* vma */
     af7:	0f b7 55 9c          	movzx  edx,WORD PTR [rbp-0x64]
     afb:	48 89 d0             	mov    rax,rdx
     afe:	48 c1 e0 02          	shl    rax,0x2
     b02:	48 01 d0             	add    rax,rdx
     b05:	48 c1 e0 03          	shl    rax,0x3
     b09:	48 89 c2             	mov    rdx,rax
     b0c:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     b10:	48 01 d0             	add    rax,rdx
     b13:	8b 40 1c             	mov    eax,DWORD PTR [rax+0x1c]
     b16:	89 c2                	mov    edx,eax
     b18:	48 89 d0             	mov    rax,rdx
     b1b:	48 c1 e0 02          	shl    rax,0x2
     b1f:	48 01 d0             	add    rax,rdx
     b22:	48 c1 e0 03          	shl    rax,0x3
     b26:	48 89 c2             	mov    rdx,rax
     b29:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     b2d:	48 01 d0             	add    rax,rdx
     b30:	8b 40 0c             	mov    eax,DWORD PTR [rax+0xc]
     b33:	89 c0                	mov    eax,eax
     b35:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
		stptr = (void*)hdr + shdr[shdr[rel].sh_link].sh_offset;
     b39:	0f b7 55 9c          	movzx  edx,WORD PTR [rbp-0x64]
     b3d:	48 89 d0             	mov    rax,rdx
     b40:	48 c1 e0 02          	shl    rax,0x2
     b44:	48 01 d0             	add    rax,rdx
     b47:	48 c1 e0 03          	shl    rax,0x3
     b4b:	48 89 c2             	mov    rdx,rax
     b4e:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     b52:	48 01 d0             	add    rax,rdx
     b55:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
     b58:	89 c2                	mov    edx,eax
     b5a:	48 89 d0             	mov    rax,rdx
     b5d:	48 c1 e0 02          	shl    rax,0x2
     b61:	48 01 d0             	add    rax,rdx
     b64:	48 c1 e0 03          	shl    rax,0x3
     b68:	48 89 c2             	mov    rdx,rax
     b6b:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     b6f:	48 01 d0             	add    rax,rdx
     b72:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     b75:	89 c2                	mov    edx,eax
     b77:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     b7b:	48 01 d0             	add    rax,rdx
     b7e:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
		stb = shdr + shdr[rel].sh_link;
     b82:	0f b7 55 9c          	movzx  edx,WORD PTR [rbp-0x64]
     b86:	48 89 d0             	mov    rax,rdx
     b89:	48 c1 e0 02          	shl    rax,0x2
     b8d:	48 01 d0             	add    rax,rdx
     b90:	48 c1 e0 03          	shl    rax,0x3
     b94:	48 89 c2             	mov    rdx,rax
     b97:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     b9b:	48 01 d0             	add    rax,rdx
     b9e:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
     ba1:	89 c2                	mov    edx,eax
     ba3:	48 89 d0             	mov    rax,rdx
     ba6:	48 c1 e0 02          	shl    rax,0x2
     baa:	48 01 d0             	add    rax,rdx
     bad:	48 c1 e0 03          	shl    rax,0x3
     bb1:	48 89 c2             	mov    rdx,rax
     bb4:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     bb8:	48 01 d0             	add    rax,rdx
     bbb:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
			shdr, hdr->e_shstrndx, shdr[shdr[rel].sh_info].sh_name));
     bbf:	0f b7 55 9c          	movzx  edx,WORD PTR [rbp-0x64]
     bc3:	48 89 d0             	mov    rax,rdx
     bc6:	48 c1 e0 02          	shl    rax,0x2
     bca:	48 01 d0             	add    rax,rdx
     bcd:	48 c1 e0 03          	shl    rax,0x3
     bd1:	48 89 c2             	mov    rdx,rax
     bd4:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     bd8:	48 01 d0             	add    rax,rdx
     bdb:	8b 40 1c             	mov    eax,DWORD PTR [rax+0x1c]
     bde:	89 c2                	mov    edx,eax
     be0:	48 89 d0             	mov    rax,rdx
     be3:	48 c1 e0 02          	shl    rax,0x2
     be7:	48 01 d0             	add    rax,rdx
     bea:	48 c1 e0 03          	shl    rax,0x3
     bee:	48 89 c2             	mov    rdx,rax
     bf1:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     bf5:	48 01 d0             	add    rax,rdx
		sbprintf("%lu relocations apply to section %s\n", ct, elf_fetch_string(hdr,
     bf8:	8b 08                	mov    ecx,DWORD PTR [rax]
			shdr, hdr->e_shstrndx, shdr[shdr[rel].sh_info].sh_name));
     bfa:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     bfe:	0f b7 40 32          	movzx  eax,WORD PTR [rax+0x32]
		sbprintf("%lu relocations apply to section %s\n", ct, elf_fetch_string(hdr,
     c02:	0f b7 d0             	movzx  edx,ax
     c05:	48 8b 75 a0          	mov    rsi,QWORD PTR [rbp-0x60]
     c09:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     c0d:	48 89 c7             	mov    rdi,rax
     c10:	e8 00 00 00 00       	call   c15 <elf_relocate_section+0x1b8>
     c15:	48 89 c2             	mov    rdx,rax
     c18:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     c1c:	48 89 c6             	mov    rsi,rax
     c1f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     c26:	b8 00 00 00 00       	mov    eax,0x0
     c2b:	e8 00 00 00 00       	call   c30 <elf_relocate_section+0x1d3>
		for (i = 0; i < ct; i++) {
     c30:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
     c38:	e9 75 01 00 00       	jmp    db2 <elf_relocate_section+0x355>
				Elf32_Addr val = 0;
     c3d:	c7 45 c4 00 00 00 00 	mov    DWORD PTR [rbp-0x3c],0x0
				Elf32_Rela* r = (ptr + i * shdr[rel].sh_entsize);
     c44:	0f b7 55 9c          	movzx  edx,WORD PTR [rbp-0x64]
     c48:	48 89 d0             	mov    rax,rdx
     c4b:	48 c1 e0 02          	shl    rax,0x2
     c4f:	48 01 d0             	add    rax,rdx
     c52:	48 c1 e0 03          	shl    rax,0x3
     c56:	48 89 c2             	mov    rdx,rax
     c59:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     c5d:	48 01 d0             	add    rax,rdx
     c60:	8b 40 24             	mov    eax,DWORD PTR [rax+0x24]
     c63:	89 c0                	mov    eax,eax
     c65:	48 0f af 45 f8       	imul   rax,QWORD PTR [rbp-0x8]
     c6a:	48 89 c2             	mov    rdx,rax
     c6d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     c71:	48 01 d0             	add    rax,rdx
     c74:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
				void** pptr = (void**)(sptr + r->r_offset);
     c78:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     c7c:	8b 00                	mov    eax,DWORD PTR [rax]
     c7e:	89 c2                	mov    edx,eax
     c80:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     c84:	48 01 d0             	add    rax,rdx
     c87:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
				Elf32_Sym* s = (stptr + ELF32_R_SYM(r->r_info) * stb->sh_entsize);
     c8b:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     c8f:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
     c92:	c1 e8 08             	shr    eax,0x8
     c95:	89 c2                	mov    edx,eax
     c97:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     c9b:	8b 40 24             	mov    eax,DWORD PTR [rax+0x24]
     c9e:	0f af c2             	imul   eax,edx
     ca1:	89 c2                	mov    edx,eax
     ca3:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     ca7:	48 01 d0             	add    rax,rdx
     caa:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				if (ELF32_R_SYM(r->r_info) == 0/*STN_UNDEF*/)
     cae:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     cb2:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
     cb5:	c1 e8 08             	shr    eax,0x8
     cb8:	85 c0                	test   eax,eax
     cba:	75 08                	jne    cc4 <elf_relocate_section+0x267>
						s = NULL;
     cbc:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
				if (s && !s->st_value) {
     cc4:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
     cc9:	74 24                	je     cef <elf_relocate_section+0x292>
     ccb:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     ccf:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
     cd2:	85 c0                	test   eax,eax
     cd4:	75 19                	jne    cef <elf_relocate_section+0x292>
						cprintf(KFMT_ERROR, "tried to relocate reference to undefined symbol\n");
     cd6:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     cdd:	bf 0c 00 00 00       	mov    edi,0xc
     ce2:	b8 00 00 00 00       	mov    eax,0x0
     ce7:	e8 00 00 00 00       	call   cec <elf_relocate_section+0x28f>
						while (1);
     cec:	90                   	nop
     ced:	eb fd                	jmp    cec <elf_relocate_section+0x28f>
						val = s->st_value;
     cef:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     cf3:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
     cf6:	89 45 c4             	mov    DWORD PTR [rbp-0x3c],eax
				if (shdr[rel].sh_type == SHT_RELA) {
     cf9:	0f b7 55 9c          	movzx  edx,WORD PTR [rbp-0x64]
     cfd:	48 89 d0             	mov    rax,rdx
     d00:	48 c1 e0 02          	shl    rax,0x2
     d04:	48 01 d0             	add    rax,rdx
     d07:	48 c1 e0 03          	shl    rax,0x3
     d0b:	48 89 c2             	mov    rdx,rax
     d0e:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     d12:	48 01 d0             	add    rax,rdx
     d15:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
     d18:	83 f8 04             	cmp    eax,0x4
     d1b:	75 19                	jne    d36 <elf_relocate_section+0x2d9>
						cprintf(KFMT_ERROR, "RELA relocations not implemented\n");
     d1d:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     d24:	bf 0c 00 00 00       	mov    edi,0xc
     d29:	b8 00 00 00 00       	mov    eax,0x0
     d2e:	e8 00 00 00 00       	call   d33 <elf_relocate_section+0x2d6>
						while (1);
     d33:	90                   	nop
     d34:	eb fd                	jmp    d33 <elf_relocate_section+0x2d6>
						switch (ELF32_R_TYPE(r->r_info)) {
     d36:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     d3a:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
     d3d:	0f b6 c0             	movzx  eax,al
     d40:	83 f8 06             	cmp    eax,0x6
     d43:	77 4e                	ja     d93 <elf_relocate_section+0x336>
     d45:	89 c0                	mov    eax,eax
     d47:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
     d4f:	ff e0                	jmp    rax
								*pptr = (size_t)val + *pptr;
     d51:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     d55:	48 8b 10             	mov    rdx,QWORD PTR [rax]
     d58:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
     d5b:	48 01 c2             	add    rdx,rax
     d5e:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     d62:	48 89 10             	mov    QWORD PTR [rax],rdx
								break;
     d65:	eb 46                	jmp    dad <elf_relocate_section+0x350>
								*pptr = (size_t)val + *pptr - (size_t)pptr;
     d67:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     d6b:	48 8b 10             	mov    rdx,QWORD PTR [rax]
     d6e:	8b 4d c4             	mov    ecx,DWORD PTR [rbp-0x3c]
     d71:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     d75:	48 29 c1             	sub    rcx,rax
     d78:	48 01 ca             	add    rdx,rcx
     d7b:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     d7f:	48 89 10             	mov    QWORD PTR [rax],rdx
								break;
     d82:	eb 29                	jmp    dad <elf_relocate_section+0x350>
								*pptr = (void*)val;
     d84:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
     d87:	48 89 c2             	mov    rdx,rax
     d8a:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     d8e:	48 89 10             	mov    QWORD PTR [rax],rdx
								break;
     d91:	eb 1a                	jmp    dad <elf_relocate_section+0x350>
								cprintf(KFMT_ERROR, "relocation type not implemented\n");
     d93:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     d9a:	bf 0c 00 00 00       	mov    edi,0xc
     d9f:	b8 00 00 00 00       	mov    eax,0x0
     da4:	e8 00 00 00 00       	call   da9 <elf_relocate_section+0x34c>
								while (1);
     da9:	90                   	nop
     daa:	eb fd                	jmp    da9 <elf_relocate_section+0x34c>
								break;
     dac:	90                   	nop
		for (i = 0; i < ct; i++) {
     dad:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
     db2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     db6:	48 3b 45 e0          	cmp    rax,QWORD PTR [rbp-0x20]
     dba:	0f 82 7d fe ff ff    	jb     c3d <elf_relocate_section+0x1e0>
     dc0:	eb 01                	jmp    dc3 <elf_relocate_section+0x366>
				return;
     dc2:	90                   	nop
}
     dc3:	c9                   	leave
     dc4:	c3                   	ret

0000000000000dc5 <get_section_type_string>:
{
     dc5:	55                   	push   rbp
     dc6:	48 89 e5             	mov    rbp,rsp
     dc9:	48 83 ec 08          	sub    rsp,0x8
     dcd:	89 7d fc             	mov    DWORD PTR [rbp-0x4],edi
		if (tp == SHT_PROGBITS)
     dd0:	83 7d fc 01          	cmp    DWORD PTR [rbp-0x4],0x1
     dd4:	75 0c                	jne    de2 <get_section_type_string+0x1d>
				return "PROGBITS";
     dd6:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     ddd:	e9 d2 00 00 00       	jmp    eb4 <get_section_type_string+0xef>
		else if (tp == SHT_SYMTAB)
     de2:	83 7d fc 02          	cmp    DWORD PTR [rbp-0x4],0x2
     de6:	75 0c                	jne    df4 <get_section_type_string+0x2f>
				return "SYMTAB";
     de8:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     def:	e9 c0 00 00 00       	jmp    eb4 <get_section_type_string+0xef>
		else if (tp == SHT_DYNSYM)
     df4:	83 7d fc 0b          	cmp    DWORD PTR [rbp-0x4],0xb
     df8:	75 0c                	jne    e06 <get_section_type_string+0x41>
				return "DYNSYM";
     dfa:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     e01:	e9 ae 00 00 00       	jmp    eb4 <get_section_type_string+0xef>
		else if (tp == SHT_STRTAB)
     e06:	83 7d fc 03          	cmp    DWORD PTR [rbp-0x4],0x3
     e0a:	75 0c                	jne    e18 <get_section_type_string+0x53>
				return "STRTAB";
     e0c:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     e13:	e9 9c 00 00 00       	jmp    eb4 <get_section_type_string+0xef>
		else if (tp == SHT_RELA)
     e18:	83 7d fc 04          	cmp    DWORD PTR [rbp-0x4],0x4
     e1c:	75 0c                	jne    e2a <get_section_type_string+0x65>
				return "RELA";
     e1e:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     e25:	e9 8a 00 00 00       	jmp    eb4 <get_section_type_string+0xef>
		else if (tp == SHT_HASH)
     e2a:	83 7d fc 05          	cmp    DWORD PTR [rbp-0x4],0x5
     e2e:	75 09                	jne    e39 <get_section_type_string+0x74>
				return "HASH";
     e30:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     e37:	eb 7b                	jmp    eb4 <get_section_type_string+0xef>
		else if (tp == SHT_DYNAMIC)
     e39:	83 7d fc 06          	cmp    DWORD PTR [rbp-0x4],0x6
     e3d:	75 09                	jne    e48 <get_section_type_string+0x83>
				return "DYNAMIC";
     e3f:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     e46:	eb 6c                	jmp    eb4 <get_section_type_string+0xef>
		else if (tp == SHT_NOTE)
     e48:	83 7d fc 07          	cmp    DWORD PTR [rbp-0x4],0x7
     e4c:	75 09                	jne    e57 <get_section_type_string+0x92>
				return "NOTE";
     e4e:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     e55:	eb 5d                	jmp    eb4 <get_section_type_string+0xef>
		else if (tp == SHT_NOBITS)
     e57:	83 7d fc 08          	cmp    DWORD PTR [rbp-0x4],0x8
     e5b:	75 09                	jne    e66 <get_section_type_string+0xa1>
				return "NOBITS";
     e5d:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     e64:	eb 4e                	jmp    eb4 <get_section_type_string+0xef>
		else if (tp == SHT_REL)
     e66:	83 7d fc 09          	cmp    DWORD PTR [rbp-0x4],0x9
     e6a:	75 09                	jne    e75 <get_section_type_string+0xb0>
				return "REL";
     e6c:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     e73:	eb 3f                	jmp    eb4 <get_section_type_string+0xef>
		else if (tp == SHT_SHLIB)
     e75:	83 7d fc 0a          	cmp    DWORD PTR [rbp-0x4],0xa
     e79:	75 09                	jne    e84 <get_section_type_string+0xbf>
				return "SHLIB";
     e7b:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     e82:	eb 30                	jmp    eb4 <get_section_type_string+0xef>
		else if (tp >= SHT_LOPROC && tp <= SHT_HIPROC)
     e84:	81 7d fc ff ff ff 6f 	cmp    DWORD PTR [rbp-0x4],0x6fffffff
     e8b:	76 10                	jbe    e9d <get_section_type_string+0xd8>
     e8d:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     e90:	85 c0                	test   eax,eax
     e92:	78 09                	js     e9d <get_section_type_string+0xd8>
				return "PROC";
     e94:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     e9b:	eb 17                	jmp    eb4 <get_section_type_string+0xef>
		else if (tp >= SHT_LOUSER && tp <= SHT_HIUSER)
     e9d:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     ea0:	85 c0                	test   eax,eax
     ea2:	79 09                	jns    ead <get_section_type_string+0xe8>
				return "USER";
     ea4:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     eab:	eb 07                	jmp    eb4 <get_section_type_string+0xef>
		else
				return "RESERVED";
     ead:	48 c7 c0 00 00 00 00 	mov    rax,0x0
}
     eb4:	c9                   	leave
     eb5:	c3                   	ret

0000000000000eb6 <elf_store_global_symbol>:

void elf_store_global_symbol(const char* name, void* vma, char type, int is_weak)
{
     eb6:	55                   	push   rbp
     eb7:	48 89 e5             	mov    rbp,rsp
     eba:	48 83 ec 40          	sub    rsp,0x40
     ebe:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
     ec2:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi
     ec6:	89 d0                	mov    eax,edx
     ec8:	89 4d c8             	mov    DWORD PTR [rbp-0x38],ecx
     ecb:	88 45 cc             	mov    BYTE PTR [rbp-0x34],al
		struct symbol_list* sl = gs_lst;
     ece:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # ed5 <elf_store_global_symbol+0x1f>
     ed5:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		size_t i = 0; int wrt = 0;
     ed9:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
     ee1:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [rbp-0x14],0x0
		if (!sl)
     ee8:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     eed:	0f 84 a1 02 00 00    	je     1194 <elf_store_global_symbol+0x2de>
				return;

		if (!name) {
     ef3:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
     ef8:	0f 85 c2 01 00 00    	jne    10c0 <elf_store_global_symbol+0x20a>
				cprintf(KFMT_WARN, "elf_store_global_symbol called for symbol "
     efe:	0f be 45 cc          	movsx  eax,BYTE PTR [rbp-0x34]
     f02:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
     f06:	48 89 d1             	mov    rcx,rdx
     f09:	89 c2                	mov    edx,eax
     f0b:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     f12:	bf 0e 00 00 00       	mov    edi,0xe
     f17:	b8 00 00 00 00       	mov    eax,0x0
     f1c:	e8 00 00 00 00       	call   f21 <elf_store_global_symbol+0x6b>
								"of type %c with name \"\" at %p\n", type, vma);
		}

		/* search for existng definition and give an offset to which to write to */
		while (sl) {
     f21:	e9 9a 01 00 00       	jmp    10c0 <elf_store_global_symbol+0x20a>
				if (!sl->entries[i].name)
     f26:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
     f2a:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     f2e:	48 89 d0             	mov    rax,rdx
     f31:	48 01 c0             	add    rax,rax
     f34:	48 01 d0             	add    rax,rdx
     f37:	48 c1 e0 03          	shl    rax,0x3
     f3b:	48 01 c8             	add    rax,rcx
     f3e:	48 83 c0 08          	add    rax,0x8
     f42:	48 8b 00             	mov    rax,QWORD PTR [rax]
     f45:	48 85 c0             	test   rax,rax
     f48:	0f 84 7f 01 00 00    	je     10cd <elf_store_global_symbol+0x217>
						break;
				if (strcmp(name, sl->entries[i].name) == 0) {
     f4e:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
     f52:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     f56:	48 89 d0             	mov    rax,rdx
     f59:	48 01 c0             	add    rax,rax
     f5c:	48 01 d0             	add    rax,rdx
     f5f:	48 c1 e0 03          	shl    rax,0x3
     f63:	48 01 c8             	add    rax,rcx
     f66:	48 83 c0 08          	add    rax,0x8
     f6a:	48 8b 10             	mov    rdx,QWORD PTR [rax]
     f6d:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     f71:	48 89 d6             	mov    rsi,rdx
     f74:	48 89 c7             	mov    rdi,rax
     f77:	e8 00 00 00 00       	call   f7c <elf_store_global_symbol+0xc6>
     f7c:	85 c0                	test   eax,eax
     f7e:	0f 85 bf 00 00 00    	jne    1043 <elf_store_global_symbol+0x18d>
						/* found a first match */
						if (sl->entries[i].type == type) {
     f84:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
     f88:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     f8c:	48 89 d0             	mov    rax,rdx
     f8f:	48 01 c0             	add    rax,rax
     f92:	48 01 d0             	add    rax,rdx
     f95:	48 c1 e0 03          	shl    rax,0x3
     f99:	48 01 c8             	add    rax,rcx
     f9c:	48 83 c0 10          	add    rax,0x10
     fa0:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     fa3:	38 45 cc             	cmp    BYTE PTR [rbp-0x34],al
     fa6:	0f 85 97 00 00 00    	jne    1043 <elf_store_global_symbol+0x18d>
								if (is_weak) /* use existing symbol definition */
     fac:	83 7d c8 00          	cmp    DWORD PTR [rbp-0x38],0x0
     fb0:	0f 85 e1 01 00 00    	jne    1197 <elf_store_global_symbol+0x2e1>
										return;
								cprintf(KFMT_WARN, "overwriting symbol %s defined at %p with "
     fb6:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
     fba:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     fbe:	48 89 d0             	mov    rax,rdx
     fc1:	48 01 c0             	add    rax,rax
     fc4:	48 01 d0             	add    rax,rdx
     fc7:	48 c1 e0 03          	shl    rax,0x3
     fcb:	48 01 c8             	add    rax,rcx
     fce:	48 8b 08             	mov    rcx,QWORD PTR [rax]
     fd1:	48 8b 75 f8          	mov    rsi,QWORD PTR [rbp-0x8]
     fd5:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     fd9:	48 89 d0             	mov    rax,rdx
     fdc:	48 01 c0             	add    rax,rax
     fdf:	48 01 d0             	add    rax,rdx
     fe2:	48 c1 e0 03          	shl    rax,0x3
     fe6:	48 01 f0             	add    rax,rsi
     fe9:	48 83 c0 08          	add    rax,0x8
     fed:	48 8b 00             	mov    rax,QWORD PTR [rax]
     ff0:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
     ff4:	49 89 d0             	mov    r8,rdx
     ff7:	48 89 c2             	mov    rdx,rax
     ffa:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1001:	bf 0e 00 00 00       	mov    edi,0xe
    1006:	b8 00 00 00 00       	mov    eax,0x0
    100b:	e8 00 00 00 00       	call   1010 <elf_store_global_symbol+0x15a>
									"symbol at %p\n", sl->entries[i].name, sl->entries[i].vma, vma);
								kfree(sl->entries[i].name); /* just in case */
    1010:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    1014:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1018:	48 89 d0             	mov    rax,rdx
    101b:	48 01 c0             	add    rax,rax
    101e:	48 01 d0             	add    rax,rdx
    1021:	48 c1 e0 03          	shl    rax,0x3
    1025:	48 01 c8             	add    rax,rcx
    1028:	48 83 c0 08          	add    rax,0x8
    102c:	48 8b 00             	mov    rax,QWORD PTR [rax]
    102f:	48 89 c7             	mov    rdi,rax
    1032:	e8 00 00 00 00       	call   1037 <elf_store_global_symbol+0x181>
								wrt = 1;
    1037:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [rbp-0x14],0x1
								break; /* only overwrite full matches */
    103e:	e9 8b 00 00 00       	jmp    10ce <elf_store_global_symbol+0x218>
						}
				}
				if (++i == 64) {
    1043:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
    1048:	48 83 7d f0 40       	cmp    QWORD PTR [rbp-0x10],0x40
    104d:	75 71                	jne    10c0 <elf_store_global_symbol+0x20a>
						if (sl->next) {
    104f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1053:	48 8b 80 00 06 00 00 	mov    rax,QWORD PTR [rax+0x600]
    105a:	48 85 c0             	test   rax,rax
    105d:	74 19                	je     1078 <elf_store_global_symbol+0x1c2>
								sl = sl->next;
    105f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1063:	48 8b 80 00 06 00 00 	mov    rax,QWORD PTR [rax+0x600]
    106a:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
								i = 0;
    106e:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
    1076:	eb 48                	jmp    10c0 <elf_store_global_symbol+0x20a>
						} else {
								/* allocate space for the next one and quit the loop */
								i = 0;
    1078:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
								sl = sl->next = kmalloc(sizeof(struct symbol_list));
    1080:	bf 08 06 00 00       	mov    edi,0x608
    1085:	e8 00 00 00 00       	call   108a <elf_store_global_symbol+0x1d4>
    108a:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    108e:	48 89 82 00 06 00 00 	mov    QWORD PTR [rdx+0x600],rax
    1095:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1099:	48 8b 80 00 06 00 00 	mov    rax,QWORD PTR [rax+0x600]
    10a0:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
								if (!sl)
    10a4:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    10a9:	0f 84 eb 00 00 00    	je     119a <elf_store_global_symbol+0x2e4>
										return;
								sl->next = NULL; /* IMPORTANT! as kmalloc != cmalloc */
    10af:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    10b3:	48 c7 80 00 06 00 00 00 00 00 00 	mov    QWORD PTR [rax+0x600],0x0
								break;
    10be:	eb 0e                	jmp    10ce <elf_store_global_symbol+0x218>
		while (sl) {
    10c0:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    10c5:	0f 85 5b fe ff ff    	jne    f26 <elf_store_global_symbol+0x70>
    10cb:	eb 01                	jmp    10ce <elf_store_global_symbol+0x218>
						break;
    10cd:	90                   	nop
						}
				}
		}

		/* now write the new definition */
		sl->entries[i].name = strdup(name);
    10ce:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    10d2:	48 89 c7             	mov    rdi,rax
    10d5:	e8 00 00 00 00       	call   10da <elf_store_global_symbol+0x224>
    10da:	48 89 c1             	mov    rcx,rax
    10dd:	48 8b 75 f8          	mov    rsi,QWORD PTR [rbp-0x8]
    10e1:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    10e5:	48 89 d0             	mov    rax,rdx
    10e8:	48 01 c0             	add    rax,rax
    10eb:	48 01 d0             	add    rax,rdx
    10ee:	48 c1 e0 03          	shl    rax,0x3
    10f2:	48 01 f0             	add    rax,rsi
    10f5:	48 83 c0 08          	add    rax,0x8
    10f9:	48 89 08             	mov    QWORD PTR [rax],rcx
		sl->entries[i].type = type;
    10fc:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    1100:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1104:	48 89 d0             	mov    rax,rdx
    1107:	48 01 c0             	add    rax,rax
    110a:	48 01 d0             	add    rax,rdx
    110d:	48 c1 e0 03          	shl    rax,0x3
    1111:	48 01 c8             	add    rax,rcx
    1114:	48 8d 50 10          	lea    rdx,[rax+0x10]
    1118:	0f b6 45 cc          	movzx  eax,BYTE PTR [rbp-0x34]
    111c:	88 02                	mov    BYTE PTR [rdx],al
		sl->entries[i].vma = vma;
    111e:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    1122:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1126:	48 89 d0             	mov    rax,rdx
    1129:	48 01 c0             	add    rax,rax
    112c:	48 01 d0             	add    rax,rdx
    112f:	48 c1 e0 03          	shl    rax,0x3
    1133:	48 8d 14 01          	lea    rdx,[rcx+rax*1]
    1137:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    113b:	48 89 02             	mov    QWORD PTR [rdx],rax
		/* and null-terminate if last */
		if (++i < 64 && !wrt) {
    113e:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
    1143:	48 83 7d f0 3f       	cmp    QWORD PTR [rbp-0x10],0x3f
    1148:	77 51                	ja     119b <elf_store_global_symbol+0x2e5>
    114a:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
    114e:	75 4b                	jne    119b <elf_store_global_symbol+0x2e5>
				sl->entries[i].name = NULL;
    1150:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    1154:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1158:	48 89 d0             	mov    rax,rdx
    115b:	48 01 c0             	add    rax,rax
    115e:	48 01 d0             	add    rax,rdx
    1161:	48 c1 e0 03          	shl    rax,0x3
    1165:	48 01 c8             	add    rax,rcx
    1168:	48 83 c0 08          	add    rax,0x8
    116c:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
				sl->entries[i].vma = NULL;
    1173:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    1177:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    117b:	48 89 d0             	mov    rax,rdx
    117e:	48 01 c0             	add    rax,rax
    1181:	48 01 d0             	add    rax,rdx
    1184:	48 c1 e0 03          	shl    rax,0x3
    1188:	48 01 c8             	add    rax,rcx
    118b:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
    1192:	eb 07                	jmp    119b <elf_store_global_symbol+0x2e5>
				return;
    1194:	90                   	nop
    1195:	eb 04                	jmp    119b <elf_store_global_symbol+0x2e5>
										return;
    1197:	90                   	nop
    1198:	eb 01                	jmp    119b <elf_store_global_symbol+0x2e5>
										return;
    119a:	90                   	nop
		}
}
    119b:	c9                   	leave
    119c:	c3                   	ret

000000000000119d <elf_locate_global_symbol>:

Elf32_Addr elf_locate_global_symbol(const char* name, char type)
{
    119d:	55                   	push   rbp
    119e:	48 89 e5             	mov    rbp,rsp
    11a1:	48 83 ec 20          	sub    rsp,0x20
    11a5:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    11a9:	89 f0                	mov    eax,esi
    11ab:	88 45 e4             	mov    BYTE PTR [rbp-0x1c],al
		struct symbol_list* sl = gs_lst;
    11ae:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 11b5 <elf_locate_global_symbol+0x18>
    11b5:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		size_t i = 0;
    11b9:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		if (!sl)
    11c1:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    11c6:	0f 85 12 01 00 00    	jne    12de <elf_locate_global_symbol+0x141>
				return (Elf32_Addr)NULL;
    11cc:	b8 00 00 00 00       	mov    eax,0x0
    11d1:	e9 1b 01 00 00       	jmp    12f1 <elf_locate_global_symbol+0x154>

		while (sl) {
				if (!sl->entries[i].name)
    11d6:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    11da:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    11de:	48 89 d0             	mov    rax,rdx
    11e1:	48 01 c0             	add    rax,rax
    11e4:	48 01 d0             	add    rax,rdx
    11e7:	48 c1 e0 03          	shl    rax,0x3
    11eb:	48 01 c8             	add    rax,rcx
    11ee:	48 83 c0 08          	add    rax,0x8
    11f2:	48 8b 00             	mov    rax,QWORD PTR [rax]
    11f5:	48 85 c0             	test   rax,rax
    11f8:	0f 84 ed 00 00 00    	je     12eb <elf_locate_global_symbol+0x14e>
						break; /* end of list */
				if (strcmp(sl->entries[i].name, name) == 0) {
    11fe:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    1202:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1206:	48 89 d0             	mov    rax,rdx
    1209:	48 01 c0             	add    rax,rax
    120c:	48 01 d0             	add    rax,rdx
    120f:	48 c1 e0 03          	shl    rax,0x3
    1213:	48 01 c8             	add    rax,rcx
    1216:	48 83 c0 08          	add    rax,0x8
    121a:	48 8b 00             	mov    rax,QWORD PTR [rax]
    121d:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    1221:	48 89 d6             	mov    rsi,rdx
    1224:	48 89 c7             	mov    rdi,rax
    1227:	e8 00 00 00 00       	call   122c <elf_locate_global_symbol+0x8f>
    122c:	85 c0                	test   eax,eax
    122e:	0f 85 87 00 00 00    	jne    12bb <elf_locate_global_symbol+0x11e>
						/* found a match candidate */
						if (sl->entries[i].type == type) /* exact match */
    1234:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    1238:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    123c:	48 89 d0             	mov    rax,rdx
    123f:	48 01 c0             	add    rax,rax
    1242:	48 01 d0             	add    rax,rdx
    1245:	48 c1 e0 03          	shl    rax,0x3
    1249:	48 01 c8             	add    rax,rcx
    124c:	48 83 c0 10          	add    rax,0x10
    1250:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1253:	38 45 e4             	cmp    BYTE PTR [rbp-0x1c],al
    1256:	75 1d                	jne    1275 <elf_locate_global_symbol+0xd8>
								return (Elf32_Addr)sl->entries[i].vma;
    1258:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    125c:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1260:	48 89 d0             	mov    rax,rdx
    1263:	48 01 c0             	add    rax,rax
    1266:	48 01 d0             	add    rax,rdx
    1269:	48 c1 e0 03          	shl    rax,0x3
    126d:	48 01 c8             	add    rax,rcx
    1270:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1273:	eb 7c                	jmp    12f1 <elf_locate_global_symbol+0x154>
						else if (sl->entries[i].type == 'B' && type == 'D')
    1275:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    1279:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    127d:	48 89 d0             	mov    rax,rdx
    1280:	48 01 c0             	add    rax,rax
    1283:	48 01 d0             	add    rax,rdx
    1286:	48 c1 e0 03          	shl    rax,0x3
    128a:	48 01 c8             	add    rax,rcx
    128d:	48 83 c0 10          	add    rax,0x10
    1291:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1294:	3c 42                	cmp    al,0x42
    1296:	75 23                	jne    12bb <elf_locate_global_symbol+0x11e>
    1298:	80 7d e4 44          	cmp    BYTE PTR [rbp-0x1c],0x44
    129c:	75 1d                	jne    12bb <elf_locate_global_symbol+0x11e>
								return (Elf32_Addr)sl->entries[i].vma; /* compatible */
    129e:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    12a2:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    12a6:	48 89 d0             	mov    rax,rdx
    12a9:	48 01 c0             	add    rax,rax
    12ac:	48 01 d0             	add    rax,rdx
    12af:	48 c1 e0 03          	shl    rax,0x3
    12b3:	48 01 c8             	add    rax,rcx
    12b6:	48 8b 00             	mov    rax,QWORD PTR [rax]
    12b9:	eb 36                	jmp    12f1 <elf_locate_global_symbol+0x154>
				}

				if (++i == 64) {
    12bb:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
    12c0:	48 83 7d f0 40       	cmp    QWORD PTR [rbp-0x10],0x40
    12c5:	75 17                	jne    12de <elf_locate_global_symbol+0x141>
						sl = sl->next;
    12c7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    12cb:	48 8b 80 00 06 00 00 	mov    rax,QWORD PTR [rax+0x600]
    12d2:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						i = 0;
    12d6:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		while (sl) {
    12de:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    12e3:	0f 85 ed fe ff ff    	jne    11d6 <elf_locate_global_symbol+0x39>
    12e9:	eb 01                	jmp    12ec <elf_locate_global_symbol+0x14f>
						break; /* end of list */
    12eb:	90                   	nop
				}
		}

		/* no match found */
		return (Elf32_Addr)NULL;
    12ec:	b8 00 00 00 00       	mov    eax,0x0
}
    12f1:	c9                   	leave
    12f2:	c3                   	ret

00000000000012f3 <locate_module_function>:

void* locate_module_function(char* name)
{
    12f3:	55                   	push   rbp
    12f4:	48 89 e5             	mov    rbp,rsp
    12f7:	48 83 ec 30          	sub    rsp,0x30
    12fb:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		Elf32_Addr rv;
		rv = elf_locate_global_symbol(name, 'T');
    12ff:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1303:	be 54 00 00 00       	mov    esi,0x54
    1308:	48 89 c7             	mov    rdi,rax
    130b:	e8 00 00 00 00       	call   1310 <locate_module_function+0x1d>
    1310:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		if (!rv)
    1313:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
    1317:	75 14                	jne    132d <locate_module_function+0x3a>
				rv = elf_locate_global_symbol(name, 'D');
    1319:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    131d:	be 44 00 00 00       	mov    esi,0x44
    1322:	48 89 c7             	mov    rdi,rax
    1325:	e8 00 00 00 00       	call   132a <locate_module_function+0x37>
    132a:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		if (!rv) {
    132d:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
    1331:	0f 85 9a 00 00 00    	jne    13d1 <locate_module_function+0xde>
				struct symbol_list* sl = gs_lst;
    1337:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 133e <locate_module_function+0x4b>
    133e:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				size_t i = 0;
    1342:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
				while (sl) {
    134a:	eb 7a                	jmp    13c6 <locate_module_function+0xd3>
						printf("%s %c\n", sl->entries[i].name, sl->entries[i].type);
    134c:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
    1350:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    1354:	48 89 d0             	mov    rax,rdx
    1357:	48 01 c0             	add    rax,rax
    135a:	48 01 d0             	add    rax,rdx
    135d:	48 c1 e0 03          	shl    rax,0x3
    1361:	48 01 c8             	add    rax,rcx
    1364:	48 83 c0 10          	add    rax,0x10
    1368:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    136b:	0f be c8             	movsx  ecx,al
    136e:	48 8b 75 f0          	mov    rsi,QWORD PTR [rbp-0x10]
    1372:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    1376:	48 89 d0             	mov    rax,rdx
    1379:	48 01 c0             	add    rax,rax
    137c:	48 01 d0             	add    rax,rdx
    137f:	48 c1 e0 03          	shl    rax,0x3
    1383:	48 01 f0             	add    rax,rsi
    1386:	48 83 c0 08          	add    rax,0x8
    138a:	48 8b 00             	mov    rax,QWORD PTR [rax]
    138d:	89 ca                	mov    edx,ecx
    138f:	48 89 c6             	mov    rsi,rax
    1392:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1399:	b8 00 00 00 00       	mov    eax,0x0
    139e:	e8 00 00 00 00       	call   13a3 <locate_module_function+0xb0>
						if (++i == 64) {
    13a3:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
    13a8:	48 83 7d e8 40       	cmp    QWORD PTR [rbp-0x18],0x40
    13ad:	75 17                	jne    13c6 <locate_module_function+0xd3>
								sl = sl->next;
    13af:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    13b3:	48 8b 80 00 06 00 00 	mov    rax,QWORD PTR [rax+0x600]
    13ba:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
								i = 0;
    13be:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
				while (sl) {
    13c6:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
    13cb:	0f 85 7b ff ff ff    	jne    134c <locate_module_function+0x59>
						}
				}
		}
		return (void*)rv;
    13d1:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
    13d4:	c9                   	leave
    13d5:	c3                   	ret

00000000000013d6 <store_module_info>:

void store_module_info(struct module_info* mi)
{
    13d6:	55                   	push   rbp
    13d7:	48 89 e5             	mov    rbp,rsp
    13da:	48 83 ec 20          	sub    rsp,0x20
    13de:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		struct module_info_container* mc;
		mc = mod_tbl.mt_mic;
    13e2:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 13e9 <store_module_info+0x13>
    13e9:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		do {
				for (int i = 0; i < 7; i++)
    13ed:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
    13f4:	e9 b9 00 00 00       	jmp    14b2 <store_module_info+0xdc>
						if (!mc->ptrs[i]) {
    13f9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    13fd:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    1400:	48 63 d2             	movsxd rdx,edx
    1403:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
    1407:	48 85 c0             	test   rax,rax
    140a:	0f 85 9e 00 00 00    	jne    14ae <store_module_info+0xd8>
								mc->ptrs[i] = kmalloc(sizeof(struct module_info));
    1410:	bf 68 00 00 00       	mov    edi,0x68
    1415:	e8 00 00 00 00       	call   141a <store_module_info+0x44>
    141a:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    141e:	8b 4d f4             	mov    ecx,DWORD PTR [rbp-0xc]
    1421:	48 63 c9             	movsxd rcx,ecx
    1424:	48 89 04 ca          	mov    QWORD PTR [rdx+rcx*8],rax
								if (!mc->ptrs[i])
    1428:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    142c:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    142f:	48 63 d2             	movsxd rdx,edx
    1432:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
    1436:	48 85 c0             	test   rax,rax
    1439:	0f 84 d7 00 00 00    	je     1516 <store_module_info+0x140>
										return;
								memcpy(mc->ptrs[i], mi, sizeof(struct module_info));
    143f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1443:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    1446:	48 63 d2             	movsxd rdx,edx
    1449:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
    144d:	48 8b 4d e8          	mov    rcx,QWORD PTR [rbp-0x18]
    1451:	ba 68 00 00 00       	mov    edx,0x68
    1456:	48 89 ce             	mov    rsi,rcx
    1459:	48 89 c7             	mov    rdi,rax
    145c:	e8 9f eb ff ff       	call   0 <memcpy>
								for (int j = 0; j < 4; j++)
    1461:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [rbp-0x10],0x0
    1468:	eb 3c                	jmp    14a6 <store_module_info+0xd0>
										mod_tbl.sz_secs[j] += mi->sz_secs[j];
    146a:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
    146d:	48 98                	cdqe
    146f:	48 83 c0 04          	add    rax,0x4
    1473:	48 8b 14 c5 00 00 00 00 	mov    rdx,QWORD PTR [rax*8+0x0]
    147b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    147f:	8b 4d f0             	mov    ecx,DWORD PTR [rbp-0x10]
    1482:	48 63 c9             	movsxd rcx,ecx
    1485:	48 83 c1 08          	add    rcx,0x8
    1489:	48 8b 44 c8 08       	mov    rax,QWORD PTR [rax+rcx*8+0x8]
    148e:	48 01 c2             	add    rdx,rax
    1491:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
    1494:	48 98                	cdqe
    1496:	48 83 c0 04          	add    rax,0x4
    149a:	48 89 14 c5 00 00 00 00 	mov    QWORD PTR [rax*8+0x0],rdx
								for (int j = 0; j < 4; j++)
    14a2:	83 45 f0 01          	add    DWORD PTR [rbp-0x10],0x1
    14a6:	83 7d f0 03          	cmp    DWORD PTR [rbp-0x10],0x3
    14aa:	7e be                	jle    146a <store_module_info+0x94>
								return;
    14ac:	eb 69                	jmp    1517 <store_module_info+0x141>
				for (int i = 0; i < 7; i++)
    14ae:	83 45 f4 01          	add    DWORD PTR [rbp-0xc],0x1
    14b2:	83 7d f4 06          	cmp    DWORD PTR [rbp-0xc],0x6
    14b6:	0f 8e 3d ff ff ff    	jle    13f9 <store_module_info+0x23>
						}
				if (!mc->next) {
    14bc:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    14c0:	48 8b 40 38          	mov    rax,QWORD PTR [rax+0x38]
    14c4:	48 85 c0             	test   rax,rax
    14c7:	75 34                	jne    14fd <store_module_info+0x127>
						mc->next = kmalloc(sizeof(struct module_info_container));
    14c9:	bf 40 00 00 00       	mov    edi,0x40
    14ce:	e8 00 00 00 00       	call   14d3 <store_module_info+0xfd>
    14d3:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    14d7:	48 89 42 38          	mov    QWORD PTR [rdx+0x38],rax
						if (mc->next)
    14db:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    14df:	48 8b 40 38          	mov    rax,QWORD PTR [rax+0x38]
    14e3:	48 85 c0             	test   rax,rax
    14e6:	74 15                	je     14fd <store_module_info+0x127>
								bzero(mc->next, sizeof(struct module_info_container));
    14e8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    14ec:	48 8b 40 38          	mov    rax,QWORD PTR [rax+0x38]
    14f0:	be 40 00 00 00       	mov    esi,0x40
    14f5:	48 89 c7             	mov    rdi,rax
    14f8:	e8 00 00 00 00       	call   14fd <store_module_info+0x127>
				}
		} while ((mc = mc->next));
    14fd:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1501:	48 8b 40 38          	mov    rax,QWORD PTR [rax+0x38]
    1505:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1509:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    150e:	0f 85 d9 fe ff ff    	jne    13ed <store_module_info+0x17>
    1514:	eb 01                	jmp    1517 <store_module_info+0x141>
										return;
    1516:	90                   	nop
}
    1517:	c9                   	leave
    1518:	c3                   	ret

0000000000001519 <list_modules>:

void list_modules()
{
    1519:	55                   	push   rbp
    151a:	48 89 e5             	mov    rbp,rsp
    151d:	48 83 ec 20          	sub    rsp,0x20
		struct module_info_container* mc;
		mc = mod_tbl.mt_mic;
    1521:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1528 <list_modules+0xf>
    1528:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		printf("Module                     Size\n");
    152c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1533:	b8 00 00 00 00       	mov    eax,0x0
    1538:	e8 00 00 00 00       	call   153d <list_modules+0x24>
		do {
				for (int i = 0; i < 7; i++)
    153d:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
    1544:	eb 6a                	jmp    15b0 <list_modules+0x97>
						if (mc->ptrs[i]) {
    1546:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    154a:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    154d:	48 63 d2             	movsxd rdx,edx
    1550:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
    1554:	48 85 c0             	test   rax,rax
    1557:	74 5f                	je     15b8 <list_modules+0x9f>
								struct module_info* mi = mc->ptrs[i];
    1559:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    155d:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    1560:	48 63 d2             	movsxd rdx,edx
    1563:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
    1567:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
								printf("%20s %10lu\n", mi->mi_name, mi->sz_secs[0] +
    156b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    156f:	48 8b 50 48          	mov    rdx,QWORD PTR [rax+0x48]
											mi->sz_secs[1] + mi->sz_secs[2] + mi->sz_secs[3]);
    1573:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1577:	48 8b 40 50          	mov    rax,QWORD PTR [rax+0x50]
								printf("%20s %10lu\n", mi->mi_name, mi->sz_secs[0] +
    157b:	48 01 c2             	add    rdx,rax
											mi->sz_secs[1] + mi->sz_secs[2] + mi->sz_secs[3]);
    157e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1582:	48 8b 40 58          	mov    rax,QWORD PTR [rax+0x58]
    1586:	48 01 c2             	add    rdx,rax
    1589:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    158d:	48 8b 40 60          	mov    rax,QWORD PTR [rax+0x60]
								printf("%20s %10lu\n", mi->mi_name, mi->sz_secs[0] +
    1591:	48 01 c2             	add    rdx,rax
    1594:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1598:	48 89 c6             	mov    rsi,rax
    159b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    15a2:	b8 00 00 00 00       	mov    eax,0x0
    15a7:	e8 00 00 00 00       	call   15ac <list_modules+0x93>
				for (int i = 0; i < 7; i++)
    15ac:	83 45 f4 01          	add    DWORD PTR [rbp-0xc],0x1
    15b0:	83 7d f4 06          	cmp    DWORD PTR [rbp-0xc],0x6
    15b4:	7e 90                	jle    1546 <list_modules+0x2d>
    15b6:	eb 01                	jmp    15b9 <list_modules+0xa0>
						} else
								break;
    15b8:	90                   	nop
		} while ((mc = mc->next));
    15b9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    15bd:	48 8b 40 38          	mov    rax,QWORD PTR [rax+0x38]
    15c1:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    15c5:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    15ca:	0f 85 6d ff ff ff    	jne    153d <list_modules+0x24>
		printf("TOTAL                %10lu\n", mod_tbl.sz_secs[0] +
    15d0:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 15d7 <list_modules+0xbe>
						mod_tbl.sz_secs[1] + mod_tbl.sz_secs[2] + mod_tbl.sz_secs[3]);
    15d7:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 15de <list_modules+0xc5>
		printf("TOTAL                %10lu\n", mod_tbl.sz_secs[0] +
    15de:	48 01 c2             	add    rdx,rax
						mod_tbl.sz_secs[1] + mod_tbl.sz_secs[2] + mod_tbl.sz_secs[3]);
    15e1:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 15e8 <list_modules+0xcf>
    15e8:	48 01 c2             	add    rdx,rax
    15eb:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 15f2 <list_modules+0xd9>
		printf("TOTAL                %10lu\n", mod_tbl.sz_secs[0] +
    15f2:	48 01 d0             	add    rax,rdx
    15f5:	48 89 c6             	mov    rsi,rax
    15f8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    15ff:	b8 00 00 00 00       	mov    eax,0x0
    1604:	e8 00 00 00 00       	call   1609 <list_modules+0xf0>
}
    1609:	90                   	nop
    160a:	c9                   	leave
    160b:	c3                   	ret

000000000000160c <list_module_info>:

void list_module_info(const char* name)
{
    160c:	55                   	push   rbp
    160d:	48 89 e5             	mov    rbp,rsp
    1610:	48 83 ec 30          	sub    rsp,0x30
    1614:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		struct module_info_container* mc;
		mc = mod_tbl.mt_mic;
    1618:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 161f <list_module_info+0x13>
    161f:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		do {
				for (int i = 0; i < 7; i++)
    1623:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
    162a:	e9 2a 01 00 00       	jmp    1759 <list_module_info+0x14d>
						if (mc->ptrs[i]) {
    162f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1633:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    1636:	48 63 d2             	movsxd rdx,edx
    1639:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
    163d:	48 85 c0             	test   rax,rax
    1640:	0f 84 1f 01 00 00    	je     1765 <list_module_info+0x159>
								struct module_info* mi = mc->ptrs[i];
    1646:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    164a:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    164d:	48 63 d2             	movsxd rdx,edx
    1650:	48 8b 04 d0          	mov    rax,QWORD PTR [rax+rdx*8]
    1654:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
								if (strcmp(mi->mi_name, name) == 0) {
    1658:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    165c:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    1660:	48 89 d6             	mov    rsi,rdx
    1663:	48 89 c7             	mov    rdi,rax
    1666:	e8 00 00 00 00       	call   166b <list_module_info+0x5f>
    166b:	85 c0                	test   eax,eax
    166d:	0f 85 e2 00 00 00    	jne    1755 <list_module_info+0x149>
										printf("module %s resides at:\n", name);
    1673:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1677:	48 89 c6             	mov    rsi,rax
    167a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1681:	b8 00 00 00 00       	mov    eax,0x0
    1686:	e8 00 00 00 00       	call   168b <list_module_info+0x7f>
										printf("SECTION     .text    .data  .rodata     .bss\n");
    168b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1692:	b8 00 00 00 00       	mov    eax,0x0
    1697:	e8 00 00 00 00       	call   169c <list_module_info+0x90>
										printf("OFFSET   %p %p %p %p\n", mi->vm_ofs[0],
    169c:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    16a0:	48 8b 70 40          	mov    rsi,QWORD PTR [rax+0x40]
    16a4:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    16a8:	48 8b 48 38          	mov    rcx,QWORD PTR [rax+0x38]
    16ac:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    16b0:	48 8b 50 30          	mov    rdx,QWORD PTR [rax+0x30]
    16b4:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    16b8:	48 8b 40 28          	mov    rax,QWORD PTR [rax+0x28]
    16bc:	49 89 f0             	mov    r8,rsi
    16bf:	48 89 c6             	mov    rsi,rax
    16c2:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    16c9:	b8 00 00 00 00       	mov    eax,0x0
    16ce:	e8 00 00 00 00       	call   16d3 <list_module_info+0xc7>
												mi->vm_ofs[1], mi->vm_ofs[2], mi->vm_ofs[3]);
										printf("SIZE     %8lu %8lu %8lu %8lu\n", mi->sz_secs[0],
    16d3:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    16d7:	48 8b 70 60          	mov    rsi,QWORD PTR [rax+0x60]
    16db:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    16df:	48 8b 48 58          	mov    rcx,QWORD PTR [rax+0x58]
    16e3:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    16e7:	48 8b 50 50          	mov    rdx,QWORD PTR [rax+0x50]
    16eb:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    16ef:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    16f3:	49 89 f0             	mov    r8,rsi
    16f6:	48 89 c6             	mov    rsi,rax
    16f9:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1700:	b8 00 00 00 00       	mov    eax,0x0
    1705:	e8 00 00 00 00       	call   170a <list_module_info+0xfe>
												mi->sz_secs[1], mi->sz_secs[2], mi->sz_secs[3]);
										printf("with the two functions\n");
    170a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1711:	b8 00 00 00 00       	mov    eax,0x0
    1716:	e8 00 00 00 00       	call   171b <list_module_info+0x10f>
										printf("module_init     at %p and\n", mi->mi_init);
    171b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    171f:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    1723:	48 89 c6             	mov    rsi,rax
    1726:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    172d:	b8 00 00 00 00       	mov    eax,0x0
    1732:	e8 00 00 00 00       	call   1737 <list_module_info+0x12b>
										printf("module_cleanup  at %p\n", mi->mi_cleanup);
    1737:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    173b:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    173f:	48 89 c6             	mov    rsi,rax
    1742:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1749:	b8 00 00 00 00       	mov    eax,0x0
    174e:	e8 00 00 00 00       	call   1753 <list_module_info+0x147>
										return;
    1753:	eb 40                	jmp    1795 <list_module_info+0x189>
				for (int i = 0; i < 7; i++)
    1755:	83 45 f4 01          	add    DWORD PTR [rbp-0xc],0x1
    1759:	83 7d f4 06          	cmp    DWORD PTR [rbp-0xc],0x6
    175d:	0f 8e cc fe ff ff    	jle    162f <list_module_info+0x23>
    1763:	eb 01                	jmp    1766 <list_module_info+0x15a>
								}
						} else
								break;
    1765:	90                   	nop
		} while ((mc = mc->next));
    1766:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    176a:	48 8b 40 38          	mov    rax,QWORD PTR [rax+0x38]
    176e:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1772:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    1777:	0f 85 a6 fe ff ff    	jne    1623 <list_module_info+0x17>
		printf("modinfo: ERROR: Module %s not found.\n", name);
    177d:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1781:	48 89 c6             	mov    rsi,rax
    1784:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    178b:	b8 00 00 00 00       	mov    eax,0x0
    1790:	e8 00 00 00 00       	call   1795 <list_module_info+0x189>
}
    1795:	c9                   	leave
    1796:	c3                   	ret

0000000000001797 <elf_get_closest_symbol>:

const char* elf_get_closest_symbol(void* ptr, size_t* offset)
{
    1797:	55                   	push   rbp
    1798:	48 89 e5             	mov    rbp,rsp
    179b:	48 83 ec 30          	sub    rsp,0x30
    179f:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
    17a3:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi
		struct symbol_list* sl = gs_lst;
    17a7:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 17ae <elf_get_closest_symbol+0x17>
    17ae:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		size_t i = 0; const char* rv = ""; void* base = NULL;
    17b2:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
    17ba:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
    17c2:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
		if (!sl) {
    17ca:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    17cf:	0f 85 c8 00 00 00    	jne    189d <elf_get_closest_symbol+0x106>
				*offset = (size_t)ptr;
    17d5:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    17d9:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    17dd:	48 89 10             	mov    QWORD PTR [rax],rdx
				return "";
    17e0:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    17e7:	e9 d5 00 00 00       	jmp    18c1 <elf_get_closest_symbol+0x12a>
		}

		while (sl) {
				if (sl->entries[i].vma <= ptr && sl->entries[i].vma > base) {
    17ec:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    17f0:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    17f4:	48 89 d0             	mov    rax,rdx
    17f7:	48 01 c0             	add    rax,rax
    17fa:	48 01 d0             	add    rax,rdx
    17fd:	48 c1 e0 03          	shl    rax,0x3
    1801:	48 01 c8             	add    rax,rcx
    1804:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1807:	48 39 45 d8          	cmp    QWORD PTR [rbp-0x28],rax
    180b:	72 6d                	jb     187a <elf_get_closest_symbol+0xe3>
    180d:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    1811:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1815:	48 89 d0             	mov    rax,rdx
    1818:	48 01 c0             	add    rax,rax
    181b:	48 01 d0             	add    rax,rdx
    181e:	48 c1 e0 03          	shl    rax,0x3
    1822:	48 01 c8             	add    rax,rcx
    1825:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1828:	48 39 45 e0          	cmp    QWORD PTR [rbp-0x20],rax
    182c:	73 4c                	jae    187a <elf_get_closest_symbol+0xe3>
						/* found a new one */
						rv = sl->entries[i].name;
    182e:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    1832:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1836:	48 89 d0             	mov    rax,rdx
    1839:	48 01 c0             	add    rax,rax
    183c:	48 01 d0             	add    rax,rdx
    183f:	48 c1 e0 03          	shl    rax,0x3
    1843:	48 01 c8             	add    rax,rcx
    1846:	48 83 c0 08          	add    rax,0x8
    184a:	48 8b 00             	mov    rax,QWORD PTR [rax]
    184d:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
						base = sl->entries[i].vma;
    1851:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    1855:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1859:	48 89 d0             	mov    rax,rdx
    185c:	48 01 c0             	add    rax,rax
    185f:	48 01 d0             	add    rax,rdx
    1862:	48 c1 e0 03          	shl    rax,0x3
    1866:	48 01 c8             	add    rax,rcx
    1869:	48 8b 00             	mov    rax,QWORD PTR [rax]
    186c:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
						if (base == ptr) /* abort on first exact match */
    1870:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1874:	48 3b 45 d8          	cmp    rax,QWORD PTR [rbp-0x28]
    1878:	74 30                	je     18aa <elf_get_closest_symbol+0x113>
								break;
				}
				if (++i == 64) {
    187a:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
    187f:	48 83 7d f0 40       	cmp    QWORD PTR [rbp-0x10],0x40
    1884:	75 17                	jne    189d <elf_get_closest_symbol+0x106>
						sl = sl->next;
    1886:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    188a:	48 8b 80 00 06 00 00 	mov    rax,QWORD PTR [rax+0x600]
    1891:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						i = 0;
    1895:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		while (sl) {
    189d:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    18a2:	0f 85 44 ff ff ff    	jne    17ec <elf_get_closest_symbol+0x55>
    18a8:	eb 01                	jmp    18ab <elf_get_closest_symbol+0x114>
								break;
    18aa:	90                   	nop
				}
		}

		*offset = ptr - base;
    18ab:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    18af:	48 2b 45 e0          	sub    rax,QWORD PTR [rbp-0x20]
    18b3:	48 89 c2             	mov    rdx,rax
    18b6:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    18ba:	48 89 10             	mov    QWORD PTR [rax],rdx
		return rv;
    18bd:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
}
    18c1:	c9                   	leave
    18c2:	c3                   	ret

00000000000018c3 <elf_resolve_symbols>:

/* bss_vmem is in/out parameter which points to the top of bss after call */
void elf_resolve_symbols(Elf32_Ehdr* hdr, Elf32_Shdr* shdr, Elf32_Half symtab, void** bss_vmem, struct module_info* mi)
{
    18c3:	55                   	push   rbp
    18c4:	48 89 e5             	mov    rbp,rsp
    18c7:	41 54                	push   r12
    18c9:	53                   	push   rbx
    18ca:	48 81 ec 90 00 00 00 	sub    rsp,0x90
    18d1:	48 89 7d 88          	mov    QWORD PTR [rbp-0x78],rdi
    18d5:	48 89 75 80          	mov    QWORD PTR [rbp-0x80],rsi
    18d9:	89 d0                	mov    eax,edx
    18db:	48 89 8d 70 ff ff ff 	mov    QWORD PTR [rbp-0x90],rcx
    18e2:	4c 89 85 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],r8
    18e9:	66 89 85 7c ff ff ff 	mov    WORD PTR [rbp-0x84],ax
		void* ptr = ((void*)hdr + shdr[symtab].sh_offset);
    18f0:	0f b7 95 7c ff ff ff 	movzx  edx,WORD PTR [rbp-0x84]
    18f7:	48 89 d0             	mov    rax,rdx
    18fa:	48 c1 e0 02          	shl    rax,0x2
    18fe:	48 01 d0             	add    rax,rdx
    1901:	48 c1 e0 03          	shl    rax,0x3
    1905:	48 89 c2             	mov    rdx,rax
    1908:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    190c:	48 01 d0             	add    rax,rdx
    190f:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1912:	89 c2                	mov    edx,eax
    1914:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1918:	48 01 d0             	add    rax,rdx
    191b:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
		size_t i, ct = shdr[symtab].sh_size / shdr[symtab].sh_entsize;
    191f:	0f b7 95 7c ff ff ff 	movzx  edx,WORD PTR [rbp-0x84]
    1926:	48 89 d0             	mov    rax,rdx
    1929:	48 c1 e0 02          	shl    rax,0x2
    192d:	48 01 d0             	add    rax,rdx
    1930:	48 c1 e0 03          	shl    rax,0x3
    1934:	48 89 c2             	mov    rdx,rax
    1937:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    193b:	48 01 d0             	add    rax,rdx
    193e:	8b 48 14             	mov    ecx,DWORD PTR [rax+0x14]
    1941:	0f b7 95 7c ff ff ff 	movzx  edx,WORD PTR [rbp-0x84]
    1948:	48 89 d0             	mov    rax,rdx
    194b:	48 c1 e0 02          	shl    rax,0x2
    194f:	48 01 d0             	add    rax,rdx
    1952:	48 c1 e0 03          	shl    rax,0x3
    1956:	48 89 c2             	mov    rdx,rax
    1959:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    195d:	48 01 d0             	add    rax,rdx
    1960:	8b 58 24             	mov    ebx,DWORD PTR [rax+0x24]
    1963:	89 c8                	mov    eax,ecx
    1965:	ba 00 00 00 00       	mov    edx,0x0
    196a:	f7 f3                	div    ebx
    196c:	89 c0                	mov    eax,eax
    196e:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
		if (ct <= 1)
    1972:	48 83 7d c8 01       	cmp    QWORD PTR [rbp-0x38],0x1
    1977:	0f 86 6f 07 00 00    	jbe    20ec <elf_resolve_symbols+0x829>
				return;
		sbprintf("Resolving symbols in symtab with %lu entries\n", ct);
    197d:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1981:	48 89 c6             	mov    rsi,rax
    1984:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    198b:	b8 00 00 00 00       	mov    eax,0x0
    1990:	e8 00 00 00 00       	call   1995 <elf_resolve_symbols+0xd2>
		for (i = 1; i < ct; i++) {
    1995:	48 c7 45 e8 01 00 00 00 	mov    QWORD PTR [rbp-0x18],0x1
    199d:	e9 3a 07 00 00       	jmp    20dc <elf_resolve_symbols+0x819>
				Elf32_Sym* s = (ptr + i * shdr[symtab].sh_entsize);
    19a2:	0f b7 95 7c ff ff ff 	movzx  edx,WORD PTR [rbp-0x84]
    19a9:	48 89 d0             	mov    rax,rdx
    19ac:	48 c1 e0 02          	shl    rax,0x2
    19b0:	48 01 d0             	add    rax,rdx
    19b3:	48 c1 e0 03          	shl    rax,0x3
    19b7:	48 89 c2             	mov    rdx,rax
    19ba:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    19be:	48 01 d0             	add    rax,rdx
    19c1:	8b 40 24             	mov    eax,DWORD PTR [rax+0x24]
    19c4:	89 c0                	mov    eax,eax
    19c6:	48 0f af 45 e8       	imul   rax,QWORD PTR [rbp-0x18]
    19cb:	48 89 c2             	mov    rdx,rax
    19ce:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    19d2:	48 01 d0             	add    rax,rdx
    19d5:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
				if (s->st_shndx == SHN_UNDEF) {
    19d9:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    19dd:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
    19e1:	66 85 c0             	test   ax,ax
    19e4:	0f 85 de 00 00 00    	jne    1ac8 <elf_resolve_symbols+0x205>
						char* sn, tp = 'T';
    19ea:	c6 45 e7 54          	mov    BYTE PTR [rbp-0x19],0x54
						/* unresolved symbol -> find in map */
						sbprintf("using external symbol with name %s\n",
										(sn = elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name)));
    19ee:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    19f2:	8b 08                	mov    ecx,DWORD PTR [rax]
    19f4:	0f b7 95 7c ff ff ff 	movzx  edx,WORD PTR [rbp-0x84]
    19fb:	48 89 d0             	mov    rax,rdx
    19fe:	48 c1 e0 02          	shl    rax,0x2
    1a02:	48 01 d0             	add    rax,rdx
    1a05:	48 c1 e0 03          	shl    rax,0x3
    1a09:	48 89 c2             	mov    rdx,rax
    1a0c:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    1a10:	48 01 d0             	add    rax,rdx
    1a13:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    1a16:	0f b7 d0             	movzx  edx,ax
    1a19:	48 8b 75 80          	mov    rsi,QWORD PTR [rbp-0x80]
    1a1d:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1a21:	48 89 c7             	mov    rdi,rax
    1a24:	e8 00 00 00 00       	call   1a29 <elf_resolve_symbols+0x166>
    1a29:	48 89 45 98          	mov    QWORD PTR [rbp-0x68],rax
						sbprintf("using external symbol with name %s\n",
    1a2d:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1a31:	48 89 c6             	mov    rsi,rax
    1a34:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1a3b:	b8 00 00 00 00       	mov    eax,0x0
    1a40:	e8 00 00 00 00       	call   1a45 <elf_resolve_symbols+0x182>
						if (ELF32_ST_TYPE(s->st_info) == STT_OBJECT)
    1a45:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1a49:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    1a4d:	0f b6 c0             	movzx  eax,al
    1a50:	83 e0 0f             	and    eax,0xf
    1a53:	83 f8 01             	cmp    eax,0x1
    1a56:	75 04                	jne    1a5c <elf_resolve_symbols+0x199>
								tp = 'D';
    1a58:	c6 45 e7 44          	mov    BYTE PTR [rbp-0x19],0x44
						s->st_value = elf_locate_global_symbol(sn, tp);
    1a5c:	0f be 55 e7          	movsx  edx,BYTE PTR [rbp-0x19]
    1a60:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1a64:	89 d6                	mov    esi,edx
    1a66:	48 89 c7             	mov    rdi,rax
    1a69:	e8 00 00 00 00       	call   1a6e <elf_resolve_symbols+0x1ab>
    1a6e:	48 8b 55 c0          	mov    rdx,QWORD PTR [rbp-0x40]
    1a72:	89 42 04             	mov    DWORD PTR [rdx+0x4],eax
						if (!s->st_value) {
    1a75:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1a79:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1a7c:	85 c0                	test   eax,eax
    1a7e:	75 26                	jne    1aa6 <elf_resolve_symbols+0x1e3>
								cprintf(KFMT_ERROR, "unresolved external symbol %c \"%s\"\n", tp, sn);
    1a80:	0f be 45 e7          	movsx  eax,BYTE PTR [rbp-0x19]
    1a84:	48 8b 55 98          	mov    rdx,QWORD PTR [rbp-0x68]
    1a88:	48 89 d1             	mov    rcx,rdx
    1a8b:	89 c2                	mov    edx,eax
    1a8d:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1a94:	bf 0c 00 00 00       	mov    edi,0xc
    1a99:	b8 00 00 00 00       	mov    eax,0x0
    1a9e:	e8 00 00 00 00       	call   1aa3 <elf_resolve_symbols+0x1e0>
								while (1);
    1aa3:	90                   	nop
    1aa4:	eb fd                	jmp    1aa3 <elf_resolve_symbols+0x1e0>
						} else
								sbprintf("\twhich was resolved to %p\n", (void*)s->st_value);
    1aa6:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1aaa:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1aad:	89 c0                	mov    eax,eax
    1aaf:	48 89 c6             	mov    rsi,rax
    1ab2:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1ab9:	b8 00 00 00 00       	mov    eax,0x0
    1abe:	e8 00 00 00 00       	call   1ac3 <elf_resolve_symbols+0x200>
    1ac3:	e9 0f 06 00 00       	jmp    20d7 <elf_resolve_symbols+0x814>
				} else if (s->st_shndx == SHN_COMMON) {
    1ac8:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1acc:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
    1ad0:	66 83 f8 f2          	cmp    ax,0xfff2
    1ad4:	0f 85 04 02 00 00    	jne    1cde <elf_resolve_symbols+0x41b>
						char* sn, tp = 'D'; Elf32_Addr ad = (Elf32_Addr)NULL;
    1ada:	c6 45 af 44          	mov    BYTE PTR [rbp-0x51],0x44
    1ade:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [rbp-0x20],0x0
						sbprintf("Common symbol with size %u and alignment %u with name %s\n",
										s->st_size, s->st_value,
										(sn = elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name)));
    1ae5:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1ae9:	8b 08                	mov    ecx,DWORD PTR [rax]
    1aeb:	0f b7 95 7c ff ff ff 	movzx  edx,WORD PTR [rbp-0x84]
    1af2:	48 89 d0             	mov    rax,rdx
    1af5:	48 c1 e0 02          	shl    rax,0x2
    1af9:	48 01 d0             	add    rax,rdx
    1afc:	48 c1 e0 03          	shl    rax,0x3
    1b00:	48 89 c2             	mov    rdx,rax
    1b03:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    1b07:	48 01 d0             	add    rax,rdx
    1b0a:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    1b0d:	0f b7 d0             	movzx  edx,ax
    1b10:	48 8b 75 80          	mov    rsi,QWORD PTR [rbp-0x80]
    1b14:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1b18:	48 89 c7             	mov    rdi,rax
    1b1b:	e8 00 00 00 00       	call   1b20 <elf_resolve_symbols+0x25d>
    1b20:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
						sbprintf("Common symbol with size %u and alignment %u with name %s\n",
    1b24:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1b28:	8b 50 04             	mov    edx,DWORD PTR [rax+0x4]
    1b2b:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1b2f:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    1b32:	48 8b 4d a0          	mov    rcx,QWORD PTR [rbp-0x60]
    1b36:	89 c6                	mov    esi,eax
    1b38:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1b3f:	b8 00 00 00 00       	mov    eax,0x0
    1b44:	e8 00 00 00 00       	call   1b49 <elf_resolve_symbols+0x286>
						if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    1b49:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1b4d:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    1b51:	c0 e8 04             	shr    al,0x4
    1b54:	3c 01                	cmp    al,0x1
    1b56:	74 0f                	je     1b67 <elf_resolve_symbols+0x2a4>
										ELF32_ST_BIND(s->st_info) == STB_WEAK) {
    1b58:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1b5c:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    1b60:	c0 e8 04             	shr    al,0x4
						if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    1b63:	3c 02                	cmp    al,0x2
    1b65:	75 32                	jne    1b99 <elf_resolve_symbols+0x2d6>
								/* lookup on global symtab */
								ad = elf_locate_global_symbol(sn, tp);
    1b67:	0f be 55 af          	movsx  edx,BYTE PTR [rbp-0x51]
    1b6b:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    1b6f:	89 d6                	mov    esi,edx
    1b71:	48 89 c7             	mov    rdi,rax
    1b74:	e8 00 00 00 00       	call   1b79 <elf_resolve_symbols+0x2b6>
    1b79:	89 45 e0             	mov    DWORD PTR [rbp-0x20],eax
								if (ad)
    1b7c:	83 7d e0 00          	cmp    DWORD PTR [rbp-0x20],0x0
    1b80:	74 17                	je     1b99 <elf_resolve_symbols+0x2d6>
										sbprintf("global definition found at %p\n", (void*)ad);
    1b82:	8b 45 e0             	mov    eax,DWORD PTR [rbp-0x20]
    1b85:	48 89 c6             	mov    rsi,rax
    1b88:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1b8f:	b8 00 00 00 00       	mov    eax,0x0
    1b94:	e8 00 00 00 00       	call   1b99 <elf_resolve_symbols+0x2d6>
						}
						/* lookup on symtab or else allocate */
						if (!ad) {
    1b99:	83 7d e0 00          	cmp    DWORD PTR [rbp-0x20],0x0
    1b9d:	0f 85 2c 01 00 00    	jne    1ccf <elf_resolve_symbols+0x40c>
								/* allocate rw bss (dumb align) */
								if ((size_t)*bss_vmem % (size_t)s->st_value) {
    1ba3:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
    1baa:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1bad:	48 89 c2             	mov    rdx,rax
    1bb0:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1bb4:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1bb7:	89 c1                	mov    ecx,eax
    1bb9:	48 89 d0             	mov    rax,rdx
    1bbc:	ba 00 00 00 00       	mov    edx,0x0
    1bc1:	48 f7 f1             	div    rcx
    1bc4:	48 89 d0             	mov    rax,rdx
    1bc7:	48 85 c0             	test   rax,rax
    1bca:	0f 84 98 00 00 00    	je     1c68 <elf_resolve_symbols+0x3a5>
										*bss_vmem += s->st_value - ((size_t)*bss_vmem % s->st_value);
    1bd0:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
    1bd7:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    1bda:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1bde:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1be1:	89 c6                	mov    esi,eax
    1be3:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
    1bea:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1bed:	48 89 c2             	mov    rdx,rax
    1bf0:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1bf4:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1bf7:	89 c7                	mov    edi,eax
    1bf9:	48 89 d0             	mov    rax,rdx
    1bfc:	ba 00 00 00 00       	mov    edx,0x0
    1c01:	48 f7 f7             	div    rdi
    1c04:	48 89 f0             	mov    rax,rsi
    1c07:	48 29 d0             	sub    rax,rdx
    1c0a:	48 8d 14 01          	lea    rdx,[rcx+rax*1]
    1c0e:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
    1c15:	48 89 10             	mov    QWORD PTR [rax],rdx
										s->st_value = (Elf32_Addr)*bss_vmem;
    1c18:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
    1c1f:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1c22:	89 c2                	mov    edx,eax
    1c24:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1c28:	89 50 04             	mov    DWORD PTR [rax+0x4],edx
										*bss_vmem += s->st_size;
    1c2b:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
    1c32:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    1c35:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1c39:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    1c3c:	89 c0                	mov    eax,eax
    1c3e:	48 01 c2             	add    rdx,rax
    1c41:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
    1c48:	48 89 10             	mov    QWORD PTR [rax],rdx
										sbprintf("will be allocated at %p\n", (void*)s->st_value);
    1c4b:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1c4f:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1c52:	89 c0                	mov    eax,eax
    1c54:	48 89 c6             	mov    rsi,rax
    1c57:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1c5e:	b8 00 00 00 00       	mov    eax,0x0
    1c63:	e8 00 00 00 00       	call   1c68 <elf_resolve_symbols+0x3a5>
								}
								/* publish the location if applicable */
								if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    1c68:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1c6c:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    1c70:	c0 e8 04             	shr    al,0x4
    1c73:	3c 01                	cmp    al,0x1
    1c75:	74 13                	je     1c8a <elf_resolve_symbols+0x3c7>
												ELF32_ST_BIND(s->st_info) == STB_WEAK) {
    1c77:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1c7b:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    1c7f:	c0 e8 04             	shr    al,0x4
								if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    1c82:	3c 02                	cmp    al,0x2
    1c84:	0f 85 4d 04 00 00    	jne    20d7 <elf_resolve_symbols+0x814>
										elf_store_global_symbol(sn, (void*)s->st_value, tp,
													   	(ELF32_ST_BIND(s->st_info) == STB_WEAK));
    1c8a:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1c8e:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
										elf_store_global_symbol(sn, (void*)s->st_value, tp,
    1c92:	c0 e8 04             	shr    al,0x4
    1c95:	3c 02                	cmp    al,0x2
    1c97:	0f 94 c0             	sete   al
    1c9a:	0f b6 c8             	movzx  ecx,al
    1c9d:	0f be 55 af          	movsx  edx,BYTE PTR [rbp-0x51]
    1ca1:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1ca5:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1ca8:	89 c0                	mov    eax,eax
    1caa:	48 89 c6             	mov    rsi,rax
    1cad:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    1cb1:	48 89 c7             	mov    rdi,rax
    1cb4:	e8 00 00 00 00       	call   1cb9 <elf_resolve_symbols+0x3f6>
										sbprintf("and is global\n");
    1cb9:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1cc0:	b8 00 00 00 00       	mov    eax,0x0
    1cc5:	e8 00 00 00 00       	call   1cca <elf_resolve_symbols+0x407>
    1cca:	e9 08 04 00 00       	jmp    20d7 <elf_resolve_symbols+0x814>
								}
						} else
								s->st_value = ad;
    1ccf:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1cd3:	8b 55 e0             	mov    edx,DWORD PTR [rbp-0x20]
    1cd6:	89 50 04             	mov    DWORD PTR [rax+0x4],edx
    1cd9:	e9 f9 03 00 00       	jmp    20d7 <elf_resolve_symbols+0x814>
				} else if (s->st_shndx < SHN_LORESERVE) {
    1cde:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1ce2:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
    1ce6:	66 3d ff fe          	cmp    ax,0xfeff
    1cea:	0f 87 c9 02 00 00    	ja     1fb9 <elf_resolve_symbols+0x6f6>
						/* local symbol so get virtual address for relocations */
						if (!(shdr[s->st_shndx].sh_flags & SHF_ALLOC))
    1cf0:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1cf4:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
    1cf8:	0f b7 d0             	movzx  edx,ax
    1cfb:	48 89 d0             	mov    rax,rdx
    1cfe:	48 c1 e0 02          	shl    rax,0x2
    1d02:	48 01 d0             	add    rax,rdx
    1d05:	48 c1 e0 03          	shl    rax,0x3
    1d09:	48 89 c2             	mov    rdx,rax
    1d0c:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    1d10:	48 01 d0             	add    rax,rdx
    1d13:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    1d16:	83 e0 02             	and    eax,0x2
    1d19:	85 c0                	test   eax,eax
    1d1b:	0f 84 b5 03 00 00    	je     20d6 <elf_resolve_symbols+0x813>
								continue; /* skip symbols in unused sections */
						s->st_value += shdr[s->st_shndx].sh_addr;
    1d21:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1d25:	8b 48 04             	mov    ecx,DWORD PTR [rax+0x4]
    1d28:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1d2c:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
    1d30:	0f b7 d0             	movzx  edx,ax
    1d33:	48 89 d0             	mov    rax,rdx
    1d36:	48 c1 e0 02          	shl    rax,0x2
    1d3a:	48 01 d0             	add    rax,rdx
    1d3d:	48 c1 e0 03          	shl    rax,0x3
    1d41:	48 89 c2             	mov    rdx,rax
    1d44:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    1d48:	48 01 d0             	add    rax,rdx
    1d4b:	8b 40 0c             	mov    eax,DWORD PTR [rax+0xc]
    1d4e:	8d 14 01             	lea    edx,[rcx+rax*1]
    1d51:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1d55:	89 50 04             	mov    DWORD PTR [rax+0x4],edx
						sbprintf("symbol %s from %s defined at vmem=%p\n",
										elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name),
										elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[s->st_shndx].sh_name),
							  			(void*)s->st_value);
    1d58:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1d5c:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1d5f:	89 c0                	mov    eax,eax
						sbprintf("symbol %s from %s defined at vmem=%p\n",
    1d61:	49 89 c4             	mov    r12,rax
										elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[s->st_shndx].sh_name),
    1d64:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1d68:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
    1d6c:	0f b7 d0             	movzx  edx,ax
    1d6f:	48 89 d0             	mov    rax,rdx
    1d72:	48 c1 e0 02          	shl    rax,0x2
    1d76:	48 01 d0             	add    rax,rdx
    1d79:	48 c1 e0 03          	shl    rax,0x3
    1d7d:	48 89 c2             	mov    rdx,rax
    1d80:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    1d84:	48 01 d0             	add    rax,rdx
						sbprintf("symbol %s from %s defined at vmem=%p\n",
    1d87:	8b 08                	mov    ecx,DWORD PTR [rax]
										elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[s->st_shndx].sh_name),
    1d89:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1d8d:	0f b7 40 32          	movzx  eax,WORD PTR [rax+0x32]
						sbprintf("symbol %s from %s defined at vmem=%p\n",
    1d91:	0f b7 d0             	movzx  edx,ax
    1d94:	48 8b 75 80          	mov    rsi,QWORD PTR [rbp-0x80]
    1d98:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1d9c:	48 89 c7             	mov    rdi,rax
    1d9f:	e8 00 00 00 00       	call   1da4 <elf_resolve_symbols+0x4e1>
    1da4:	48 89 c3             	mov    rbx,rax
    1da7:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1dab:	8b 08                	mov    ecx,DWORD PTR [rax]
										elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name),
    1dad:	0f b7 95 7c ff ff ff 	movzx  edx,WORD PTR [rbp-0x84]
    1db4:	48 89 d0             	mov    rax,rdx
    1db7:	48 c1 e0 02          	shl    rax,0x2
    1dbb:	48 01 d0             	add    rax,rdx
    1dbe:	48 c1 e0 03          	shl    rax,0x3
    1dc2:	48 89 c2             	mov    rdx,rax
    1dc5:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    1dc9:	48 01 d0             	add    rax,rdx
    1dcc:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
						sbprintf("symbol %s from %s defined at vmem=%p\n",
    1dcf:	0f b7 d0             	movzx  edx,ax
    1dd2:	48 8b 75 80          	mov    rsi,QWORD PTR [rbp-0x80]
    1dd6:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1dda:	48 89 c7             	mov    rdi,rax
    1ddd:	e8 00 00 00 00       	call   1de2 <elf_resolve_symbols+0x51f>
    1de2:	4c 89 e1             	mov    rcx,r12
    1de5:	48 89 da             	mov    rdx,rbx
    1de8:	48 89 c6             	mov    rsi,rax
    1deb:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1df2:	b8 00 00 00 00       	mov    eax,0x0
    1df7:	e8 00 00 00 00       	call   1dfc <elf_resolve_symbols+0x539>
						if (strcmp(elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name), "module_init") == 0) {
    1dfc:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1e00:	8b 08                	mov    ecx,DWORD PTR [rax]
    1e02:	0f b7 95 7c ff ff ff 	movzx  edx,WORD PTR [rbp-0x84]
    1e09:	48 89 d0             	mov    rax,rdx
    1e0c:	48 c1 e0 02          	shl    rax,0x2
    1e10:	48 01 d0             	add    rax,rdx
    1e13:	48 c1 e0 03          	shl    rax,0x3
    1e17:	48 89 c2             	mov    rdx,rax
    1e1a:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    1e1e:	48 01 d0             	add    rax,rdx
    1e21:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    1e24:	0f b7 d0             	movzx  edx,ax
    1e27:	48 8b 75 80          	mov    rsi,QWORD PTR [rbp-0x80]
    1e2b:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1e2f:	48 89 c7             	mov    rdi,rax
    1e32:	e8 00 00 00 00       	call   1e37 <elf_resolve_symbols+0x574>
    1e37:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1e3e:	48 89 c7             	mov    rdi,rax
    1e41:	e8 00 00 00 00       	call   1e46 <elf_resolve_symbols+0x583>
    1e46:	85 c0                	test   eax,eax
    1e48:	75 3b                	jne    1e85 <elf_resolve_symbols+0x5c2>
								mi->mi_init = (mod_init)s->st_value;
    1e4a:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1e4e:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1e51:	89 c0                	mov    eax,eax
    1e53:	48 89 c2             	mov    rdx,rax
    1e56:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
    1e5d:	48 89 50 18          	mov    QWORD PTR [rax+0x18],rdx
								sbprintf("found global entry module_init at %p\n", mi->mi_init);
    1e61:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
    1e68:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    1e6c:	48 89 c6             	mov    rsi,rax
    1e6f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1e76:	b8 00 00 00 00       	mov    eax,0x0
    1e7b:	e8 00 00 00 00       	call   1e80 <elf_resolve_symbols+0x5bd>
    1e80:	e9 84 00 00 00       	jmp    1f09 <elf_resolve_symbols+0x646>
						} else if (strcmp(elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name), "module_cleanup") == 0) {
    1e85:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1e89:	8b 08                	mov    ecx,DWORD PTR [rax]
    1e8b:	0f b7 95 7c ff ff ff 	movzx  edx,WORD PTR [rbp-0x84]
    1e92:	48 89 d0             	mov    rax,rdx
    1e95:	48 c1 e0 02          	shl    rax,0x2
    1e99:	48 01 d0             	add    rax,rdx
    1e9c:	48 c1 e0 03          	shl    rax,0x3
    1ea0:	48 89 c2             	mov    rdx,rax
    1ea3:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    1ea7:	48 01 d0             	add    rax,rdx
    1eaa:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    1ead:	0f b7 d0             	movzx  edx,ax
    1eb0:	48 8b 75 80          	mov    rsi,QWORD PTR [rbp-0x80]
    1eb4:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1eb8:	48 89 c7             	mov    rdi,rax
    1ebb:	e8 00 00 00 00       	call   1ec0 <elf_resolve_symbols+0x5fd>
    1ec0:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1ec7:	48 89 c7             	mov    rdi,rax
    1eca:	e8 00 00 00 00       	call   1ecf <elf_resolve_symbols+0x60c>
    1ecf:	85 c0                	test   eax,eax
    1ed1:	75 36                	jne    1f09 <elf_resolve_symbols+0x646>
								mi->mi_cleanup = (mod_cleanup)s->st_value;
    1ed3:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1ed7:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1eda:	89 c0                	mov    eax,eax
    1edc:	48 89 c2             	mov    rdx,rax
    1edf:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
    1ee6:	48 89 50 20          	mov    QWORD PTR [rax+0x20],rdx
								sbprintf("found global exit module_cleanup at %p\n", mi->mi_cleanup);
    1eea:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
    1ef1:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    1ef5:	48 89 c6             	mov    rsi,rax
    1ef8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1eff:	b8 00 00 00 00       	mov    eax,0x0
    1f04:	e8 00 00 00 00       	call   1f09 <elf_resolve_symbols+0x646>
						}
						if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    1f09:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1f0d:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    1f11:	c0 e8 04             	shr    al,0x4
    1f14:	3c 01                	cmp    al,0x1
    1f16:	74 13                	je     1f2b <elf_resolve_symbols+0x668>
										ELF32_ST_BIND(s->st_info) == STB_WEAK) {
    1f18:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1f1c:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    1f20:	c0 e8 04             	shr    al,0x4
						if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    1f23:	3c 02                	cmp    al,0x2
    1f25:	0f 85 ac 01 00 00    	jne    20d7 <elf_resolve_symbols+0x814>
								/* exported symbol -> to global symtab */
								char tp = 'T', *sn;
    1f2b:	c6 45 df 54          	mov    BYTE PTR [rbp-0x21],0x54
								if (ELF32_ST_TYPE(s->st_info) == STT_OBJECT)
    1f2f:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1f33:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    1f37:	0f b6 c0             	movzx  eax,al
    1f3a:	83 e0 0f             	and    eax,0xf
    1f3d:	83 f8 01             	cmp    eax,0x1
    1f40:	75 04                	jne    1f46 <elf_resolve_symbols+0x683>
										tp = 'D';
    1f42:	c6 45 df 44          	mov    BYTE PTR [rbp-0x21],0x44
								sn = elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name);
    1f46:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1f4a:	8b 08                	mov    ecx,DWORD PTR [rax]
    1f4c:	0f b7 95 7c ff ff ff 	movzx  edx,WORD PTR [rbp-0x84]
    1f53:	48 89 d0             	mov    rax,rdx
    1f56:	48 c1 e0 02          	shl    rax,0x2
    1f5a:	48 01 d0             	add    rax,rdx
    1f5d:	48 c1 e0 03          	shl    rax,0x3
    1f61:	48 89 c2             	mov    rdx,rax
    1f64:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    1f68:	48 01 d0             	add    rax,rdx
    1f6b:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    1f6e:	0f b7 d0             	movzx  edx,ax
    1f71:	48 8b 75 80          	mov    rsi,QWORD PTR [rbp-0x80]
    1f75:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1f79:	48 89 c7             	mov    rdi,rax
    1f7c:	e8 00 00 00 00       	call   1f81 <elf_resolve_symbols+0x6be>
    1f81:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
								elf_store_global_symbol(sn, (void*)s->st_value, tp, ELF32_ST_BIND(s->st_info) == STB_WEAK);
    1f85:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1f89:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    1f8d:	c0 e8 04             	shr    al,0x4
    1f90:	3c 02                	cmp    al,0x2
    1f92:	0f 94 c0             	sete   al
    1f95:	0f b6 c8             	movzx  ecx,al
    1f98:	0f be 55 df          	movsx  edx,BYTE PTR [rbp-0x21]
    1f9c:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1fa0:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1fa3:	89 c0                	mov    eax,eax
    1fa5:	48 89 c6             	mov    rsi,rax
    1fa8:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1fac:	48 89 c7             	mov    rdi,rax
    1faf:	e8 00 00 00 00       	call   1fb4 <elf_resolve_symbols+0x6f1>
    1fb4:	e9 1e 01 00 00       	jmp    20d7 <elf_resolve_symbols+0x814>
						}
				} else if (s->st_shndx == SHN_ABS) {
    1fb9:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1fbd:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
    1fc1:	66 83 f8 f1          	cmp    ax,0xfff1
    1fc5:	0f 85 0c 01 00 00    	jne    20d7 <elf_resolve_symbols+0x814>
						sbprintf("absolute symbol with name %s and value %p\n",
										elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name),
							  			(void*)s->st_value);
    1fcb:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1fcf:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1fd2:	89 c0                	mov    eax,eax
						sbprintf("absolute symbol with name %s and value %p\n",
    1fd4:	48 89 c3             	mov    rbx,rax
    1fd7:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1fdb:	8b 08                	mov    ecx,DWORD PTR [rax]
										elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name),
    1fdd:	0f b7 95 7c ff ff ff 	movzx  edx,WORD PTR [rbp-0x84]
    1fe4:	48 89 d0             	mov    rax,rdx
    1fe7:	48 c1 e0 02          	shl    rax,0x2
    1feb:	48 01 d0             	add    rax,rdx
    1fee:	48 c1 e0 03          	shl    rax,0x3
    1ff2:	48 89 c2             	mov    rdx,rax
    1ff5:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    1ff9:	48 01 d0             	add    rax,rdx
    1ffc:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
						sbprintf("absolute symbol with name %s and value %p\n",
    1fff:	0f b7 d0             	movzx  edx,ax
    2002:	48 8b 75 80          	mov    rsi,QWORD PTR [rbp-0x80]
    2006:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    200a:	48 89 c7             	mov    rdi,rax
    200d:	e8 00 00 00 00       	call   2012 <elf_resolve_symbols+0x74f>
    2012:	48 89 da             	mov    rdx,rbx
    2015:	48 89 c6             	mov    rsi,rax
    2018:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    201f:	b8 00 00 00 00       	mov    eax,0x0
    2024:	e8 00 00 00 00       	call   2029 <elf_resolve_symbols+0x766>
						if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    2029:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    202d:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    2031:	c0 e8 04             	shr    al,0x4
    2034:	3c 01                	cmp    al,0x1
    2036:	74 13                	je     204b <elf_resolve_symbols+0x788>
										ELF32_ST_BIND(s->st_info) == STB_WEAK) {
    2038:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    203c:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    2040:	c0 e8 04             	shr    al,0x4
						if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
    2043:	3c 02                	cmp    al,0x2
    2045:	0f 85 8c 00 00 00    	jne    20d7 <elf_resolve_symbols+0x814>
								char tp = 'T', *sn;
    204b:	c6 45 de 54          	mov    BYTE PTR [rbp-0x22],0x54
								if (ELF32_ST_TYPE(s->st_info) == STT_OBJECT)
    204f:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2053:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    2057:	0f b6 c0             	movzx  eax,al
    205a:	83 e0 0f             	and    eax,0xf
    205d:	83 f8 01             	cmp    eax,0x1
    2060:	75 04                	jne    2066 <elf_resolve_symbols+0x7a3>
										tp = 'D';
    2062:	c6 45 de 44          	mov    BYTE PTR [rbp-0x22],0x44
								sn = elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name);
    2066:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    206a:	8b 08                	mov    ecx,DWORD PTR [rax]
    206c:	0f b7 95 7c ff ff ff 	movzx  edx,WORD PTR [rbp-0x84]
    2073:	48 89 d0             	mov    rax,rdx
    2076:	48 c1 e0 02          	shl    rax,0x2
    207a:	48 01 d0             	add    rax,rdx
    207d:	48 c1 e0 03          	shl    rax,0x3
    2081:	48 89 c2             	mov    rdx,rax
    2084:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    2088:	48 01 d0             	add    rax,rdx
    208b:	8b 40 18             	mov    eax,DWORD PTR [rax+0x18]
    208e:	0f b7 d0             	movzx  edx,ax
    2091:	48 8b 75 80          	mov    rsi,QWORD PTR [rbp-0x80]
    2095:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2099:	48 89 c7             	mov    rdi,rax
    209c:	e8 00 00 00 00       	call   20a1 <elf_resolve_symbols+0x7de>
    20a1:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
								elf_store_global_symbol(sn, (void*)s->st_value, tp, ELF32_ST_BIND(s->st_info) == STB_WEAK);
    20a5:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    20a9:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    20ad:	c0 e8 04             	shr    al,0x4
    20b0:	3c 02                	cmp    al,0x2
    20b2:	0f 94 c0             	sete   al
    20b5:	0f b6 c8             	movzx  ecx,al
    20b8:	0f be 55 de          	movsx  edx,BYTE PTR [rbp-0x22]
    20bc:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    20c0:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    20c3:	89 c0                	mov    eax,eax
    20c5:	48 89 c6             	mov    rsi,rax
    20c8:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    20cc:	48 89 c7             	mov    rdi,rax
    20cf:	e8 00 00 00 00       	call   20d4 <elf_resolve_symbols+0x811>
    20d4:	eb 01                	jmp    20d7 <elf_resolve_symbols+0x814>
								continue; /* skip symbols in unused sections */
    20d6:	90                   	nop
		for (i = 1; i < ct; i++) {
    20d7:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
    20dc:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    20e0:	48 3b 45 c8          	cmp    rax,QWORD PTR [rbp-0x38]
    20e4:	0f 82 b8 f8 ff ff    	jb     19a2 <elf_resolve_symbols+0xdf>
    20ea:	eb 01                	jmp    20ed <elf_resolve_symbols+0x82a>
				return;
    20ec:	90                   	nop
						}
				}
		}
}
    20ed:	48 81 c4 90 00 00 00 	add    rsp,0x90
    20f4:	5b                   	pop    rbx
    20f5:	41 5c                	pop    r12
    20f7:	5d                   	pop    rbp
    20f8:	c3                   	ret

00000000000020f9 <load_elf>:

/*#define ELF_DIAG*/

enum elferr load_elf(void* mem, uint32_t sz, struct module_info* mi)
{
    20f9:	55                   	push   rbp
    20fa:	48 89 e5             	mov    rbp,rsp
    20fd:	53                   	push   rbx
    20fe:	48 81 ec 68 01 00 00 	sub    rsp,0x168
    2105:	48 89 bd a8 fe ff ff 	mov    QWORD PTR [rbp-0x158],rdi
    210c:	89 b5 a4 fe ff ff    	mov    DWORD PTR [rbp-0x15c],esi
    2112:	48 89 95 98 fe ff ff 	mov    QWORD PTR [rbp-0x168],rdx
		Elf32_Ehdr* hdr = (Elf32_Ehdr*)mem;
    2119:	48 8b 85 a8 fe ff ff 	mov    rax,QWORD PTR [rbp-0x158]
    2120:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
		Elf32_Shdr* shdr; size_t i;

		/* perform basic checks */
		if (strncmp((const char*)hdr->e_ident, ELFMAG, 4) != 0)
    2124:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2128:	ba 04 00 00 00       	mov    edx,0x4
    212d:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2134:	48 89 c7             	mov    rdi,rax
    2137:	e8 00 00 00 00       	call   213c <load_elf+0x43>
    213c:	85 c0                	test   eax,eax
    213e:	74 0a                	je     214a <load_elf+0x51>
				return ELF_WRONG_MAGIC;
    2140:	b8 01 00 00 00       	mov    eax,0x1
    2145:	e9 78 0e 00 00       	jmp    2fc2 <load_elf+0xec9>
		if (hdr->e_ident[EI_CLASS] != ELFCLASS32)
    214a:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    214e:	0f b6 40 04          	movzx  eax,BYTE PTR [rax+0x4]
    2152:	3c 01                	cmp    al,0x1
    2154:	74 0a                	je     2160 <load_elf+0x67>
				return ELF_NOT_CLASS32;
    2156:	b8 02 00 00 00       	mov    eax,0x2
    215b:	e9 62 0e 00 00       	jmp    2fc2 <load_elf+0xec9>
		if (hdr->e_ident[EI_DATA] != ELFDATA2LSB)
    2160:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2164:	0f b6 40 05          	movzx  eax,BYTE PTR [rax+0x5]
    2168:	3c 01                	cmp    al,0x1
    216a:	74 0a                	je     2176 <load_elf+0x7d>
				return ELF_NOT_LE;
    216c:	b8 03 00 00 00       	mov    eax,0x3
    2171:	e9 4c 0e 00 00       	jmp    2fc2 <load_elf+0xec9>
		if (hdr->e_ident[EI_VERSION] != EV_CURRENT)
    2176:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    217a:	0f b6 40 06          	movzx  eax,BYTE PTR [rax+0x6]
    217e:	3c 01                	cmp    al,0x1
    2180:	74 0a                	je     218c <load_elf+0x93>
				return ELF_VERSION_NOT_SUPPORTED;
    2182:	b8 05 00 00 00       	mov    eax,0x5
    2187:	e9 36 0e 00 00       	jmp    2fc2 <load_elf+0xec9>
		if (hdr->e_ident[EI_OSABI] != ELFOSABI_NONE)
    218c:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2190:	0f b6 40 07          	movzx  eax,BYTE PTR [rax+0x7]
    2194:	84 c0                	test   al,al
    2196:	74 0a                	je     21a2 <load_elf+0xa9>
				return ELF_WRONG_OSABI;
    2198:	b8 06 00 00 00       	mov    eax,0x6
    219d:	e9 20 0e 00 00       	jmp    2fc2 <load_elf+0xec9>

		/* matching ELF32 found -> check for object file */
		if (hdr->e_type != ET_REL)
    21a2:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    21a6:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
    21aa:	66 83 f8 01          	cmp    ax,0x1
    21ae:	74 0a                	je     21ba <load_elf+0xc1>
				return ELF_NOT_REL;
    21b0:	b8 07 00 00 00       	mov    eax,0x7
    21b5:	e9 08 0e 00 00       	jmp    2fc2 <load_elf+0xec9>
		if (hdr->e_machine != EM_386)
    21ba:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    21be:	0f b7 40 12          	movzx  eax,WORD PTR [rax+0x12]
    21c2:	66 83 f8 03          	cmp    ax,0x3
    21c6:	74 0a                	je     21d2 <load_elf+0xd9>
				return ELF_NOT_386;
    21c8:	b8 08 00 00 00       	mov    eax,0x8
    21cd:	e9 f0 0d 00 00       	jmp    2fc2 <load_elf+0xec9>
		if (hdr->e_ehsize != sizeof(*hdr))
    21d2:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    21d6:	0f b7 40 28          	movzx  eax,WORD PTR [rax+0x28]
    21da:	66 83 f8 34          	cmp    ax,0x34
    21de:	74 0a                	je     21ea <load_elf+0xf1>
				return ELF_INCOMPATIBLE_HEADER;
    21e0:	b8 09 00 00 00       	mov    eax,0x9
    21e5:	e9 d8 0d 00 00       	jmp    2fc2 <load_elf+0xec9>
		if (hdr->e_phnum)
    21ea:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    21ee:	0f b7 40 2c          	movzx  eax,WORD PTR [rax+0x2c]
    21f2:	66 85 c0             	test   ax,ax
    21f5:	74 0a                	je     2201 <load_elf+0x108>
				return ELF_CONTAINS_PROG_HEADERS;
    21f7:	b8 0a 00 00 00       	mov    eax,0xa
    21fc:	e9 c1 0d 00 00       	jmp    2fc2 <load_elf+0xec9>
		if (!hdr->e_shnum)
    2201:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2205:	0f b7 40 30          	movzx  eax,WORD PTR [rax+0x30]
    2209:	66 85 c0             	test   ax,ax
    220c:	75 0a                	jne    2218 <load_elf+0x11f>
				return ELF_NO_SECTIONS_DEFINED;
    220e:	b8 0b 00 00 00       	mov    eax,0xb
    2213:	e9 aa 0d 00 00       	jmp    2fc2 <load_elf+0xec9>
		if (hdr->e_shentsize != sizeof(Elf32_Shdr))
    2218:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    221c:	0f b7 40 2e          	movzx  eax,WORD PTR [rax+0x2e]
    2220:	66 83 f8 28          	cmp    ax,0x28
    2224:	74 0a                	je     2230 <load_elf+0x137>
				return ELF_WRONG_SHDR_SIZE;
    2226:	b8 0c 00 00 00       	mov    eax,0xc
    222b:	e9 92 0d 00 00       	jmp    2fc2 <load_elf+0xec9>
		if (hdr->e_shstrndx == SHN_UNDEF)
    2230:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2234:	0f b7 40 32          	movzx  eax,WORD PTR [rax+0x32]
    2238:	66 85 c0             	test   ax,ax
    223b:	75 0a                	jne    2247 <load_elf+0x14e>
				return ELF_NO_SECTION_STRTAB;
    223d:	b8 0d 00 00 00       	mov    eax,0xd
    2242:	e9 7b 0d 00 00       	jmp    2fc2 <load_elf+0xec9>

		/* set the initial offsets */
		for (i = 0; i < 4; i++)
    2247:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
    224f:	eb 25                	jmp    2276 <load_elf+0x17d>
				mi->vm_ofs[i] = mod_tbl.vm_ofs[i];
    2251:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2255:	48 8b 14 c5 00 00 00 00 	mov    rdx,QWORD PTR [rax*8+0x0]
    225d:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    2264:	48 8b 4d e8          	mov    rcx,QWORD PTR [rbp-0x18]
    2268:	48 83 c1 04          	add    rcx,0x4
    226c:	48 89 54 c8 08       	mov    QWORD PTR [rax+rcx*8+0x8],rdx
		for (i = 0; i < 4; i++)
    2271:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
    2276:	48 83 7d e8 03       	cmp    QWORD PTR [rbp-0x18],0x3
    227b:	76 d4                	jbe    2251 <load_elf+0x158>

		/* now first allocate the sections in memory */
		shdr = mem + hdr->e_shoff;
    227d:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2281:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    2284:	89 c2                	mov    edx,eax
    2286:	48 8b 85 a8 fe ff ff 	mov    rax,QWORD PTR [rbp-0x158]
    228d:	48 01 d0             	add    rax,rdx
    2290:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
		for (i = 0; i < hdr->e_shnum; i++) {
    2294:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
    229c:	e9 a6 07 00 00       	jmp    2a47 <load_elf+0x94e>
				if (shdr[i].sh_type == SHT_NULL)
    22a1:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    22a5:	48 89 d0             	mov    rax,rdx
    22a8:	48 c1 e0 02          	shl    rax,0x2
    22ac:	48 01 d0             	add    rax,rdx
    22af:	48 c1 e0 03          	shl    rax,0x3
    22b3:	48 89 c2             	mov    rdx,rax
    22b6:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    22ba:	48 01 d0             	add    rax,rdx
    22bd:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    22c0:	85 c0                	test   eax,eax
    22c2:	0f 84 79 07 00 00    	je     2a41 <load_elf+0x948>
						continue;

				/* only allocate alloc section */
				if (shdr[i].sh_flags & SHF_ALLOC) {
    22c8:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    22cc:	48 89 d0             	mov    rax,rdx
    22cf:	48 c1 e0 02          	shl    rax,0x2
    22d3:	48 01 d0             	add    rax,rdx
    22d6:	48 c1 e0 03          	shl    rax,0x3
    22da:	48 89 c2             	mov    rdx,rax
    22dd:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    22e1:	48 01 d0             	add    rax,rdx
    22e4:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    22e7:	83 e0 02             	and    eax,0x2
    22ea:	85 c0                	test   eax,eax
    22ec:	0f 84 50 07 00 00    	je     2a42 <load_elf+0x949>
						size_t pg_ct; struct page_range pr[10];
						Elf32_Word algn = shdr[i].sh_addralign;
    22f2:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    22f6:	48 89 d0             	mov    rax,rdx
    22f9:	48 c1 e0 02          	shl    rax,0x2
    22fd:	48 01 d0             	add    rax,rdx
    2300:	48 c1 e0 03          	shl    rax,0x3
    2304:	48 89 c2             	mov    rdx,rax
    2307:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    230b:	48 01 d0             	add    rax,rdx
    230e:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    2311:	89 45 84             	mov    DWORD PTR [rbp-0x7c],eax
						Elf32_Addr addr; void* mapaddr; int reuse = 0;
    2314:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [rbp-0x34],0x0
						Elf32_Off ofs = shdr[i].sh_offset;
    231b:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    231f:	48 89 d0             	mov    rax,rdx
    2322:	48 c1 e0 02          	shl    rax,0x2
    2326:	48 01 d0             	add    rax,rdx
    2329:	48 c1 e0 03          	shl    rax,0x3
    232d:	48 89 c2             	mov    rdx,rax
    2330:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2334:	48 01 d0             	add    rax,rdx
    2337:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    233a:	89 45 c8             	mov    DWORD PTR [rbp-0x38],eax
						enum mt_sec sct;

						pg_ct = shdr[i].sh_size / 4096 + ((shdr[i].sh_size % 4096) ? 1 : 0);
    233d:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2341:	48 89 d0             	mov    rax,rdx
    2344:	48 c1 e0 02          	shl    rax,0x2
    2348:	48 01 d0             	add    rax,rdx
    234b:	48 c1 e0 03          	shl    rax,0x3
    234f:	48 89 c2             	mov    rdx,rax
    2352:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2356:	48 01 d0             	add    rax,rdx
    2359:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    235c:	c1 e8 0c             	shr    eax,0xc
    235f:	89 c1                	mov    ecx,eax
    2361:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2365:	48 89 d0             	mov    rax,rdx
    2368:	48 c1 e0 02          	shl    rax,0x2
    236c:	48 01 d0             	add    rax,rdx
    236f:	48 c1 e0 03          	shl    rax,0x3
    2373:	48 89 c2             	mov    rdx,rax
    2376:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    237a:	48 01 d0             	add    rax,rdx
    237d:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    2380:	25 ff 0f 00 00       	and    eax,0xfff
    2385:	85 c0                	test   eax,eax
    2387:	74 07                	je     2390 <load_elf+0x297>
    2389:	b8 01 00 00 00       	mov    eax,0x1
    238e:	eb 05                	jmp    2395 <load_elf+0x29c>
    2390:	b8 00 00 00 00       	mov    eax,0x0
    2395:	01 c8                	add    eax,ecx
    2397:	89 c0                	mov    eax,eax
    2399:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
						/* get the section type */
						if (shdr[i].sh_flags & SHF_WRITE) {
    239d:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    23a1:	48 89 d0             	mov    rax,rdx
    23a4:	48 c1 e0 02          	shl    rax,0x2
    23a8:	48 01 d0             	add    rax,rdx
    23ab:	48 c1 e0 03          	shl    rax,0x3
    23af:	48 89 c2             	mov    rdx,rax
    23b2:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    23b6:	48 01 d0             	add    rax,rdx
    23b9:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    23bc:	83 e0 01             	and    eax,0x1
    23bf:	85 c0                	test   eax,eax
    23c1:	74 66                	je     2429 <load_elf+0x330>
								/* TODO: C-o-w bss */
								if (shdr[i].sh_flags & SHF_EXECINSTR)
    23c3:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    23c7:	48 89 d0             	mov    rax,rdx
    23ca:	48 c1 e0 02          	shl    rax,0x2
    23ce:	48 01 d0             	add    rax,rdx
    23d1:	48 c1 e0 03          	shl    rax,0x3
    23d5:	48 89 c2             	mov    rdx,rax
    23d8:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    23dc:	48 01 d0             	add    rax,rdx
    23df:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    23e2:	83 e0 04             	and    eax,0x4
    23e5:	85 c0                	test   eax,eax
    23e7:	74 0a                	je     23f3 <load_elf+0x2fa>
										return ELF_SECTION_RWX;
    23e9:	b8 0e 00 00 00       	mov    eax,0xe
    23ee:	e9 cf 0b 00 00       	jmp    2fc2 <load_elf+0xec9>
								if (shdr[i].sh_type == SHT_NOBITS)
    23f3:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    23f7:	48 89 d0             	mov    rax,rdx
    23fa:	48 c1 e0 02          	shl    rax,0x2
    23fe:	48 01 d0             	add    rax,rdx
    2401:	48 c1 e0 03          	shl    rax,0x3
    2405:	48 89 c2             	mov    rdx,rax
    2408:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    240c:	48 01 d0             	add    rax,rdx
    240f:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    2412:	83 f8 08             	cmp    eax,0x8
    2415:	75 09                	jne    2420 <load_elf+0x327>
										sct = MT_SEC_BSS;
    2417:	c7 45 c4 03 00 00 00 	mov    DWORD PTR [rbp-0x3c],0x3
    241e:	eb 77                	jmp    2497 <load_elf+0x39e>
								else
										sct = MT_SEC_DATA;
    2420:	c7 45 c4 01 00 00 00 	mov    DWORD PTR [rbp-0x3c],0x1
    2427:	eb 6e                	jmp    2497 <load_elf+0x39e>
						} else if (shdr[i].sh_flags & SHF_EXECINSTR)
    2429:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    242d:	48 89 d0             	mov    rax,rdx
    2430:	48 c1 e0 02          	shl    rax,0x2
    2434:	48 01 d0             	add    rax,rdx
    2437:	48 c1 e0 03          	shl    rax,0x3
    243b:	48 89 c2             	mov    rdx,rax
    243e:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2442:	48 01 d0             	add    rax,rdx
    2445:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    2448:	83 e0 04             	and    eax,0x4
    244b:	85 c0                	test   eax,eax
    244d:	74 09                	je     2458 <load_elf+0x35f>
								sct = MT_SEC_TEXT;
    244f:	c7 45 c4 00 00 00 00 	mov    DWORD PTR [rbp-0x3c],0x0
    2456:	eb 3f                	jmp    2497 <load_elf+0x39e>
						else {
								/* rodata, robss? */
								if (shdr[i].sh_type == SHT_NOBITS) {
    2458:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    245c:	48 89 d0             	mov    rax,rdx
    245f:	48 c1 e0 02          	shl    rax,0x2
    2463:	48 01 d0             	add    rax,rdx
    2466:	48 c1 e0 03          	shl    rax,0x3
    246a:	48 89 c2             	mov    rdx,rax
    246d:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2471:	48 01 d0             	add    rax,rdx
    2474:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    2477:	83 f8 08             	cmp    eax,0x8
    247a:	75 14                	jne    2490 <load_elf+0x397>
										printf("Implement zero page!\n");
    247c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2483:	b8 00 00 00 00       	mov    eax,0x0
    2488:	e8 00 00 00 00       	call   248d <load_elf+0x394>
										while (1); /* c-o-w? nope! */
    248d:	90                   	nop
    248e:	eb fd                	jmp    248d <load_elf+0x394>
								}
								sct = MT_SEC_RODATA;
    2490:	c7 45 c4 02 00 00 00 	mov    DWORD PTR [rbp-0x3c],0x2
						}
						/* get the raw (unaligned) address */
						addr = (Elf32_Addr)mod_tbl.vm_ofs[sct] + mi->sz_secs[sct];
    2497:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    249a:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
    24a2:	89 c1                	mov    ecx,eax
    24a4:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    24ab:	8b 55 c4             	mov    edx,DWORD PTR [rbp-0x3c]
    24ae:	48 83 c2 08          	add    rdx,0x8
    24b2:	48 8b 44 d0 08       	mov    rax,QWORD PTR [rax+rdx*8+0x8]
    24b7:	01 c8                	add    eax,ecx
    24b9:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
						mbprintf("unaligned address for %s: %p\n", elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[i].sh_name), (void*)addr);
    24bc:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    24bf:	48 89 c3             	mov    rbx,rax
    24c2:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    24c6:	48 89 d0             	mov    rax,rdx
    24c9:	48 c1 e0 02          	shl    rax,0x2
    24cd:	48 01 d0             	add    rax,rdx
    24d0:	48 c1 e0 03          	shl    rax,0x3
    24d4:	48 89 c2             	mov    rdx,rax
    24d7:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    24db:	48 01 d0             	add    rax,rdx
    24de:	8b 08                	mov    ecx,DWORD PTR [rax]
    24e0:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    24e4:	0f b7 40 32          	movzx  eax,WORD PTR [rax+0x32]
    24e8:	0f b7 d0             	movzx  edx,ax
    24eb:	48 8b 75 a8          	mov    rsi,QWORD PTR [rbp-0x58]
    24ef:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    24f3:	48 89 c7             	mov    rdi,rax
    24f6:	e8 00 00 00 00       	call   24fb <load_elf+0x402>
    24fb:	48 89 da             	mov    rdx,rbx
    24fe:	48 89 c6             	mov    rsi,rax
    2501:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2508:	b8 00 00 00 00       	mov    eax,0x0
    250d:	e8 00 00 00 00       	call   2512 <load_elf+0x419>

						/* now do the alignment calculations */
						if (addr % algn)
    2512:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    2515:	ba 00 00 00 00       	mov    edx,0x0
    251a:	f7 75 84             	div    DWORD PTR [rbp-0x7c]
    251d:	89 d0                	mov    eax,edx
    251f:	85 c0                	test   eax,eax
    2521:	74 13                	je     2536 <load_elf+0x43d>
								addr += algn - addr % algn;
    2523:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    2526:	ba 00 00 00 00       	mov    edx,0x0
    252b:	f7 75 84             	div    DWORD PTR [rbp-0x7c]
    252e:	8b 45 84             	mov    eax,DWORD PTR [rbp-0x7c]
    2531:	29 d0                	sub    eax,edx
    2533:	01 45 dc             	add    DWORD PTR [rbp-0x24],eax
						if (algn < 0x1000 && (addr % 4096)) {
    2536:	81 7d 84 ff 0f 00 00 	cmp    DWORD PTR [rbp-0x7c],0xfff
    253d:	77 7a                	ja     25b9 <load_elf+0x4c0>
    253f:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    2542:	25 ff 0f 00 00       	and    eax,0xfff
    2547:	85 c0                	test   eax,eax
    2549:	74 6e                	je     25b9 <load_elf+0x4c0>
								/* maybe save up to a single page by reusing an existing one of the same module */
								size_t ovs = shdr[i].sh_size % 4096; /* "oversize" */
    254b:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    254f:	48 89 d0             	mov    rax,rdx
    2552:	48 c1 e0 02          	shl    rax,0x2
    2556:	48 01 d0             	add    rax,rdx
    2559:	48 c1 e0 03          	shl    rax,0x3
    255d:	48 89 c2             	mov    rdx,rax
    2560:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2564:	48 01 d0             	add    rax,rdx
    2567:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    256a:	89 c0                	mov    eax,eax
    256c:	25 ff 0f 00 00       	and    eax,0xfff
    2571:	48 89 85 78 ff ff ff 	mov    QWORD PTR [rbp-0x88],rax
								if (ovs && ovs < (4096 - (addr % 4096))) {
    2578:	48 83 bd 78 ff ff ff 00 	cmp    QWORD PTR [rbp-0x88],0x0
    2580:	74 37                	je     25b9 <load_elf+0x4c0>
    2582:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    2585:	25 ff 0f 00 00       	and    eax,0xfff
    258a:	ba 00 10 00 00       	mov    edx,0x1000
    258f:	29 c2                	sub    edx,eax
    2591:	89 d0                	mov    eax,edx
    2593:	48 39 85 78 ff ff ff 	cmp    QWORD PTR [rbp-0x88],rax
    259a:	73 1d                	jae    25b9 <load_elf+0x4c0>
										/* oversize fits into existing page */
										mbprintf("reuse\n");
    259c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    25a3:	b8 00 00 00 00       	mov    eax,0x0
    25a8:	e8 00 00 00 00       	call   25ad <load_elf+0x4b4>
										pg_ct--;
    25ad:	48 83 6d e0 01       	sub    QWORD PTR [rbp-0x20],0x1
										reuse = 1;
    25b2:	c7 45 cc 01 00 00 00 	mov    DWORD PTR [rbp-0x34],0x1
								}
						}
						if (addr % 4096)
    25b9:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    25bc:	25 ff 0f 00 00       	and    eax,0xfff
    25c1:	85 c0                	test   eax,eax
    25c3:	74 6a                	je     262f <load_elf+0x536>
								if (reuse) /* first use partially present page */
    25c5:	83 7d cc 00          	cmp    DWORD PTR [rbp-0x34],0x0
    25c9:	74 15                	je     25e0 <load_elf+0x4e7>
										mapaddr = (void*)(addr + 4096 - addr % 4096);
    25cb:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    25ce:	25 00 f0 ff ff       	and    eax,0xfffff000
    25d3:	05 00 10 00 00       	add    eax,0x1000
    25d8:	89 c0                	mov    eax,eax
    25da:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
    25de:	eb 56                	jmp    2636 <load_elf+0x53d>
								else { /* alignment leaves page partially unused */
										mapaddr = (void*)(addr - addr % 4096);
    25e0:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    25e3:	25 00 f0 ff ff       	and    eax,0xfffff000
    25e8:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
										if (pg_ct * 4096 < shdr[i].sh_size + addr % 4096)
    25ec:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    25f0:	48 c1 e0 0c          	shl    rax,0xc
    25f4:	48 89 c1             	mov    rcx,rax
    25f7:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    25fb:	48 89 d0             	mov    rax,rdx
    25fe:	48 c1 e0 02          	shl    rax,0x2
    2602:	48 01 d0             	add    rax,rdx
    2605:	48 c1 e0 03          	shl    rax,0x3
    2609:	48 89 c2             	mov    rdx,rax
    260c:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2610:	48 01 d0             	add    rax,rdx
    2613:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    2616:	8b 55 dc             	mov    edx,DWORD PTR [rbp-0x24]
    2619:	81 e2 ff 0f 00 00    	and    edx,0xfff
    261f:	01 d0                	add    eax,edx
    2621:	89 c0                	mov    eax,eax
    2623:	48 39 c1             	cmp    rcx,rax
    2626:	73 0e                	jae    2636 <load_elf+0x53d>
												pg_ct++; /* adjust space accordingly */
    2628:	48 83 45 e0 01       	add    QWORD PTR [rbp-0x20],0x1
    262d:	eb 07                	jmp    2636 <load_elf+0x53d>
								}
						else
								mapaddr = (void*)addr;
    262f:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    2632:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax

						shdr[i].sh_addr = addr;
    2636:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    263a:	48 89 d0             	mov    rax,rdx
    263d:	48 c1 e0 02          	shl    rax,0x2
    2641:	48 01 d0             	add    rax,rdx
    2644:	48 c1 e0 03          	shl    rax,0x3
    2648:	48 89 c2             	mov    rdx,rax
    264b:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    264f:	48 01 c2             	add    rdx,rax
    2652:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    2655:	89 42 0c             	mov    DWORD PTR [rdx+0xc],eax
						mbprintf("aligned address: %p\n", (void*)addr);
    2658:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    265b:	48 89 c6             	mov    rsi,rax
    265e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2665:	b8 00 00 00 00       	mov    eax,0x0
    266a:	e8 00 00 00 00       	call   266f <load_elf+0x576>
						if (!mi->vm_ofs[sct])
    266f:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    2676:	8b 55 c4             	mov    edx,DWORD PTR [rbp-0x3c]
    2679:	48 83 c2 04          	add    rdx,0x4
    267d:	48 8b 44 d0 08       	mov    rax,QWORD PTR [rax+rdx*8+0x8]
    2682:	48 85 c0             	test   rax,rax
    2685:	75 19                	jne    26a0 <load_elf+0x5a7>
								mi->vm_ofs[sct] = (void*)addr;
    2687:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    268a:	48 89 c1             	mov    rcx,rax
    268d:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    2694:	8b 55 c4             	mov    edx,DWORD PTR [rbp-0x3c]
    2697:	48 83 c2 04          	add    rdx,0x4
    269b:	48 89 4c d0 08       	mov    QWORD PTR [rax+rdx*8+0x8],rcx
						mi->sz_secs[sct] += shdr[i].sh_size;
    26a0:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    26a7:	8b 55 c4             	mov    edx,DWORD PTR [rbp-0x3c]
    26aa:	48 83 c2 08          	add    rdx,0x8
    26ae:	48 8b 4c d0 08       	mov    rcx,QWORD PTR [rax+rdx*8+0x8]
    26b3:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    26b7:	48 89 d0             	mov    rax,rdx
    26ba:	48 c1 e0 02          	shl    rax,0x2
    26be:	48 01 d0             	add    rax,rdx
    26c1:	48 c1 e0 03          	shl    rax,0x3
    26c5:	48 89 c2             	mov    rdx,rax
    26c8:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    26cc:	48 01 d0             	add    rax,rdx
    26cf:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    26d2:	89 c0                	mov    eax,eax
    26d4:	48 01 c1             	add    rcx,rax
    26d7:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    26de:	8b 55 c4             	mov    edx,DWORD PTR [rbp-0x3c]
    26e1:	48 83 c2 08          	add    rdx,0x8
    26e5:	48 89 4c d0 08       	mov    QWORD PTR [rax+rdx*8+0x8],rcx

						/* fill the half-used page (if PROGBITS) */
						if (((void*)addr < mapaddr) && (shdr[i].sh_type != SHT_NOBITS)) {
    26ea:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    26ed:	48 3b 45 d0          	cmp    rax,QWORD PTR [rbp-0x30]
    26f1:	0f 83 a2 00 00 00    	jae    2799 <load_elf+0x6a0>
    26f7:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    26fb:	48 89 d0             	mov    rax,rdx
    26fe:	48 c1 e0 02          	shl    rax,0x2
    2702:	48 01 d0             	add    rax,rdx
    2705:	48 c1 e0 03          	shl    rax,0x3
    2709:	48 89 c2             	mov    rdx,rax
    270c:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2710:	48 01 d0             	add    rax,rdx
    2713:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    2716:	83 f8 08             	cmp    eax,0x8
    2719:	74 7e                	je     2799 <load_elf+0x6a0>
								size_t n = (size_t)mapaddr - (size_t)addr;
    271b:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    271f:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    2722:	48 29 c2             	sub    rdx,rax
    2725:	48 89 95 70 ff ff ff 	mov    QWORD PTR [rbp-0x90],rdx
								n = min(n, shdr[i].sh_size);
    272c:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2730:	48 89 d0             	mov    rax,rdx
    2733:	48 c1 e0 02          	shl    rax,0x2
    2737:	48 01 d0             	add    rax,rdx
    273a:	48 c1 e0 03          	shl    rax,0x3
    273e:	48 89 c2             	mov    rdx,rax
    2741:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2745:	48 01 d0             	add    rax,rdx
    2748:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    274b:	89 c2                	mov    edx,eax
    274d:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
    2754:	48 39 d0             	cmp    rax,rdx
    2757:	48 0f 47 c2          	cmova  rax,rdx
    275b:	48 89 85 70 ff ff ff 	mov    QWORD PTR [rbp-0x90],rax
								memcpy((void*)addr, (void*)hdr + ofs, n);
    2762:	8b 55 c8             	mov    edx,DWORD PTR [rbp-0x38]
    2765:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2769:	48 8d 0c 02          	lea    rcx,[rdx+rax*1]
    276d:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    2770:	48 89 c7             	mov    rdi,rax
    2773:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
    277a:	48 89 c2             	mov    rdx,rax
    277d:	48 89 ce             	mov    rsi,rcx
    2780:	e8 7b d8 ff ff       	call   0 <memcpy>
								ofs += n;
    2785:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
    278c:	01 45 c8             	add    DWORD PTR [rbp-0x38],eax
								addr += n;
    278f:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
    2796:	01 45 dc             	add    DWORD PTR [rbp-0x24],eax
						}
						/* allocate the physical memory and map it to virtual memory */
						mbprintf("allocating %lu pages for size=%u\n", pg_ct, shdr[i].sh_size);
    2799:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    279d:	48 89 d0             	mov    rax,rdx
    27a0:	48 c1 e0 02          	shl    rax,0x2
    27a4:	48 01 d0             	add    rax,rdx
    27a7:	48 c1 e0 03          	shl    rax,0x3
    27ab:	48 89 c2             	mov    rdx,rax
    27ae:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    27b2:	48 01 d0             	add    rax,rdx
    27b5:	8b 50 14             	mov    edx,DWORD PTR [rax+0x14]
    27b8:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    27bc:	48 89 c6             	mov    rsi,rax
    27bf:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    27c6:	b8 00 00 00 00       	mov    eax,0x0
    27cb:	e8 00 00 00 00       	call   27d0 <load_elf+0x6d7>
						while (pg_ct) {
    27d0:	e9 5f 02 00 00       	jmp    2a34 <load_elf+0x93b>
								int flags = MMGR_MAP_KERNEL, remap = 0;
    27d5:	c7 45 c0 08 00 00 00 	mov    DWORD PTR [rbp-0x40],0x8
    27dc:	c7 85 6c ff ff ff 00 00 00 00 	mov    DWORD PTR [rbp-0x94],0x0
								size_t np = mm_alloc_pm(pg_ct, pr, countof(pr));
    27e6:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    27ea:	89 c1                	mov    ecx,eax
    27ec:	48 8d 85 b0 fe ff ff 	lea    rax,[rbp-0x150]
    27f3:	ba 0a 00 00 00       	mov    edx,0xa
    27f8:	48 89 c6             	mov    rsi,rax
    27fb:	89 cf                	mov    edi,ecx
    27fd:	e8 00 00 00 00       	call   2802 <load_elf+0x709>
    2802:	89 c0                	mov    eax,eax
    2804:	48 89 85 60 ff ff ff 	mov    QWORD PTR [rbp-0xa0],rax
								if (shdr[i].sh_flags & SHF_EXECINSTR)
    280b:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    280f:	48 89 d0             	mov    rax,rdx
    2812:	48 c1 e0 02          	shl    rax,0x2
    2816:	48 01 d0             	add    rax,rdx
    2819:	48 c1 e0 03          	shl    rax,0x3
    281d:	48 89 c2             	mov    rdx,rax
    2820:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2824:	48 01 d0             	add    rax,rdx
    2827:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    282a:	83 e0 04             	and    eax,0x4
    282d:	85 c0                	test   eax,eax
    282f:	74 04                	je     2835 <load_elf+0x73c>
										flags |= MMGR_MAP_EXECUTE;
    2831:	83 4d c0 02          	or     DWORD PTR [rbp-0x40],0x2
								if (shdr[i].sh_flags & SHF_WRITE)
    2835:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2839:	48 89 d0             	mov    rax,rdx
    283c:	48 c1 e0 02          	shl    rax,0x2
    2840:	48 01 d0             	add    rax,rdx
    2843:	48 c1 e0 03          	shl    rax,0x3
    2847:	48 89 c2             	mov    rdx,rax
    284a:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    284e:	48 01 d0             	add    rax,rdx
    2851:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    2854:	83 e0 01             	and    eax,0x1
    2857:	85 c0                	test   eax,eax
    2859:	74 06                	je     2861 <load_elf+0x768>
										flags |= MMGR_MAP_WRITE;
    285b:	83 4d c0 04          	or     DWORD PTR [rbp-0x40],0x4
    285f:	eb 28                	jmp    2889 <load_elf+0x790>
								else if (shdr[i].sh_type != SHT_NOBITS) {
    2861:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2865:	48 89 d0             	mov    rax,rdx
    2868:	48 c1 e0 02          	shl    rax,0x2
    286c:	48 01 d0             	add    rax,rdx
    286f:	48 c1 e0 03          	shl    rax,0x3
    2873:	48 89 c2             	mov    rdx,rax
    2876:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    287a:	48 01 d0             	add    rax,rdx
    287d:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    2880:	83 f8 08             	cmp    eax,0x8
    2883:	74 04                	je     2889 <load_elf+0x790>
										flags |= MMGR_MAP_WRITE;
    2885:	83 4d c0 04          	or     DWORD PTR [rbp-0x40],0x4
								}

								mbprintf("mapping %lu pages to %p\n", np, mapaddr);
    2889:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    288d:	48 8b 85 60 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa0]
    2894:	48 89 c6             	mov    rsi,rax
    2897:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    289e:	b8 00 00 00 00       	mov    eax,0x0
    28a3:	e8 00 00 00 00       	call   28a8 <load_elf+0x7af>
								if (mm_map(&mm_kernel, mapaddr, pr, countof(pr), flags) != mapaddr) {
    28a8:	8b 4d c0             	mov    ecx,DWORD PTR [rbp-0x40]
    28ab:	48 8d 95 b0 fe ff ff 	lea    rdx,[rbp-0x150]
    28b2:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    28b6:	41 89 c8             	mov    r8d,ecx
    28b9:	b9 0a 00 00 00       	mov    ecx,0xa
    28be:	48 89 c6             	mov    rsi,rax
    28c1:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    28c8:	e8 00 00 00 00       	call   28cd <load_elf+0x7d4>
    28cd:	48 39 45 d0          	cmp    QWORD PTR [rbp-0x30],rax
    28d1:	74 14                	je     28e7 <load_elf+0x7ee>
										printf("unexpected error mapping pmem to vmem\n");
    28d3:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    28da:	b8 00 00 00 00       	mov    eax,0x0
    28df:	e8 00 00 00 00       	call   28e4 <load_elf+0x7eb>
										while (1);
    28e4:	90                   	nop
    28e5:	eb fd                	jmp    28e4 <load_elf+0x7eb>
								}
								/* copy data if present */
								if (shdr[i].sh_type != SHT_NOBITS) {
    28e7:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    28eb:	48 89 d0             	mov    rax,rdx
    28ee:	48 c1 e0 02          	shl    rax,0x2
    28f2:	48 01 d0             	add    rax,rdx
    28f5:	48 c1 e0 03          	shl    rax,0x3
    28f9:	48 89 c2             	mov    rdx,rax
    28fc:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2900:	48 01 d0             	add    rax,rdx
    2903:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    2906:	83 f8 08             	cmp    eax,0x8
    2909:	0f 84 0b 01 00 00    	je     2a1a <load_elf+0x921>
										size_t n = min(np * 4096, shdr[i].sh_size - (ofs - shdr[i].sh_offset));
    290f:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2913:	48 89 d0             	mov    rax,rdx
    2916:	48 c1 e0 02          	shl    rax,0x2
    291a:	48 01 d0             	add    rax,rdx
    291d:	48 c1 e0 03          	shl    rax,0x3
    2921:	48 89 c2             	mov    rdx,rax
    2924:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2928:	48 01 d0             	add    rax,rdx
    292b:	8b 48 14             	mov    ecx,DWORD PTR [rax+0x14]
    292e:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2932:	48 89 d0             	mov    rax,rdx
    2935:	48 c1 e0 02          	shl    rax,0x2
    2939:	48 01 d0             	add    rax,rdx
    293c:	48 c1 e0 03          	shl    rax,0x3
    2940:	48 89 c2             	mov    rdx,rax
    2943:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2947:	48 01 d0             	add    rax,rdx
    294a:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    294d:	2b 45 c8             	sub    eax,DWORD PTR [rbp-0x38]
    2950:	01 c8                	add    eax,ecx
    2952:	89 c2                	mov    edx,eax
    2954:	48 8b 85 60 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa0]
    295b:	48 c1 e0 0c          	shl    rax,0xc
    295f:	48 39 c2             	cmp    rdx,rax
    2962:	48 0f 46 c2          	cmovbe rax,rdx
    2966:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
										mbprintf("n=%lu, ofs=%u\n", n, ofs);
    296a:	8b 55 c8             	mov    edx,DWORD PTR [rbp-0x38]
    296d:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2971:	48 89 c6             	mov    rsi,rax
    2974:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    297b:	b8 00 00 00 00       	mov    eax,0x0
    2980:	e8 00 00 00 00       	call   2985 <load_elf+0x88c>
										if ((void*)addr > mapaddr)
    2985:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    2988:	48 39 45 d0          	cmp    QWORD PTR [rbp-0x30],rax
    298c:	73 0e                	jae    299c <load_elf+0x8a3>
												n -= (size_t)addr - (size_t)mapaddr;
    298e:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    2992:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    2995:	48 29 c2             	sub    rdx,rax
    2998:	48 01 55 b8          	add    QWORD PTR [rbp-0x48],rdx
										memcpy((void*)addr, (void*)hdr + ofs, n);
    299c:	8b 55 c8             	mov    edx,DWORD PTR [rbp-0x38]
    299f:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    29a3:	48 8d 0c 02          	lea    rcx,[rdx+rax*1]
    29a7:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    29aa:	48 89 c7             	mov    rdi,rax
    29ad:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    29b1:	48 89 c2             	mov    rdx,rax
    29b4:	48 89 ce             	mov    rsi,rcx
    29b7:	e8 44 d6 ff ff       	call   0 <memcpy>
										mbprintf("copying %lu bytes to %p\n", n, (void*)addr);
    29bc:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    29bf:	48 89 c2             	mov    rdx,rax
    29c2:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    29c6:	48 89 c6             	mov    rsi,rax
    29c9:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    29d0:	b8 00 00 00 00       	mov    eax,0x0
    29d5:	e8 00 00 00 00       	call   29da <load_elf+0x8e1>
										ofs += n;
    29da:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    29de:	01 45 c8             	add    DWORD PTR [rbp-0x38],eax
										addr += n;
    29e1:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    29e5:	01 45 dc             	add    DWORD PTR [rbp-0x24],eax
										if (remap) {
    29e8:	83 bd 6c ff ff ff 00 	cmp    DWORD PTR [rbp-0x94],0x0
    29ef:	74 29                	je     2a1a <load_elf+0x921>
												flags &= ~MMGR_MAP_WRITE;
    29f1:	83 65 c0 fb          	and    DWORD PTR [rbp-0x40],0xfffffffb
												mm_map(&mm_kernel, mapaddr, pr, countof(pr), flags);
    29f5:	8b 4d c0             	mov    ecx,DWORD PTR [rbp-0x40]
    29f8:	48 8d 95 b0 fe ff ff 	lea    rdx,[rbp-0x150]
    29ff:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    2a03:	41 89 c8             	mov    r8d,ecx
    2a06:	b9 0a 00 00 00       	mov    ecx,0xa
    2a0b:	48 89 c6             	mov    rsi,rax
    2a0e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2a15:	e8 00 00 00 00       	call   2a1a <load_elf+0x921>
										}
								}
								mapaddr += np * 4096;
    2a1a:	48 8b 85 60 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa0]
    2a21:	48 c1 e0 0c          	shl    rax,0xc
    2a25:	48 01 45 d0          	add    QWORD PTR [rbp-0x30],rax
								pg_ct -= np;
    2a29:	48 8b 85 60 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa0]
    2a30:	48 29 45 e0          	sub    QWORD PTR [rbp-0x20],rax
						while (pg_ct) {
    2a34:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
    2a39:	0f 85 96 fd ff ff    	jne    27d5 <load_elf+0x6dc>
    2a3f:	eb 01                	jmp    2a42 <load_elf+0x949>
						continue;
    2a41:	90                   	nop
		for (i = 0; i < hdr->e_shnum; i++) {
    2a42:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
    2a47:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2a4b:	0f b7 40 30          	movzx  eax,WORD PTR [rax+0x30]
    2a4f:	0f b7 c0             	movzx  eax,ax
    2a52:	48 39 45 e8          	cmp    QWORD PTR [rbp-0x18],rax
    2a56:	0f 82 45 f8 ff ff    	jb     22a1 <load_elf+0x1a8>
				}
#endif
		}

		/* Now determine the symbol values*/
		for (i = 0; i < hdr->e_shnum; i++)
    2a5c:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
    2a64:	e9 9d 01 00 00       	jmp    2c06 <load_elf+0xb0d>
				if (shdr[i].sh_type == SHT_SYMTAB) {
    2a69:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2a6d:	48 89 d0             	mov    rax,rdx
    2a70:	48 c1 e0 02          	shl    rax,0x2
    2a74:	48 01 d0             	add    rax,rdx
    2a77:	48 c1 e0 03          	shl    rax,0x3
    2a7b:	48 89 c2             	mov    rdx,rax
    2a7e:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2a82:	48 01 d0             	add    rax,rdx
    2a85:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    2a88:	83 f8 02             	cmp    eax,0x2
    2a8b:	0f 85 70 01 00 00    	jne    2c01 <load_elf+0xb08>
						void* vm_bss = mi->vm_ofs[MT_SEC_BSS] + mi->sz_secs[MT_SEC_BSS];
    2a91:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    2a98:	48 8b 50 40          	mov    rdx,QWORD PTR [rax+0x40]
    2a9c:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    2aa3:	48 8b 40 60          	mov    rax,QWORD PTR [rax+0x60]
    2aa7:	48 01 d0             	add    rax,rdx
    2aaa:	48 89 85 58 ff ff ff 	mov    QWORD PTR [rbp-0xa8],rax
						void* vm_aold = vm_bss + (((size_t)vm_bss % 4096) ? (4096 - ((size_t)vm_bss % 4096)) : 0);
    2ab1:	48 8b 95 58 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xa8]
    2ab8:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    2abf:	25 ff 0f 00 00       	and    eax,0xfff
    2ac4:	48 85 c0             	test   rax,rax
    2ac7:	74 19                	je     2ae2 <load_elf+0x9e9>
    2ac9:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    2ad0:	25 ff 0f 00 00       	and    eax,0xfff
    2ad5:	48 89 c1             	mov    rcx,rax
    2ad8:	b8 00 10 00 00       	mov    eax,0x1000
    2add:	48 29 c8             	sub    rax,rcx
    2ae0:	eb 05                	jmp    2ae7 <load_elf+0x9ee>
    2ae2:	b8 00 00 00 00       	mov    eax,0x0
    2ae7:	48 01 d0             	add    rax,rdx
    2aea:	48 89 45 90          	mov    QWORD PTR [rbp-0x70],rax
						elf_resolve_symbols(hdr, shdr, i, &vm_bss, mi);
    2aee:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2af2:	0f b7 d0             	movzx  edx,ax
    2af5:	48 8b bd 98 fe ff ff 	mov    rdi,QWORD PTR [rbp-0x168]
    2afc:	48 8d 8d 58 ff ff ff 	lea    rcx,[rbp-0xa8]
    2b03:	48 8b 75 a8          	mov    rsi,QWORD PTR [rbp-0x58]
    2b07:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2b0b:	49 89 f8             	mov    r8,rdi
    2b0e:	48 89 c7             	mov    rdi,rax
    2b11:	e8 00 00 00 00       	call   2b16 <load_elf+0xa1d>
						if (vm_bss > vm_aold) {
    2b16:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    2b1d:	48 39 45 90          	cmp    QWORD PTR [rbp-0x70],rax
    2b21:	0f 83 da 00 00 00    	jae    2c01 <load_elf+0xb08>
								size_t pgc = 0; struct page_range pr[10];
    2b27:	48 c7 45 88 00 00 00 00 	mov    QWORD PTR [rbp-0x78],0x0
								/* allocate new bss sections */
								pgc = vm_bss - vm_aold;
    2b2f:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    2b36:	48 2b 45 90          	sub    rax,QWORD PTR [rbp-0x70]
    2b3a:	48 89 45 88          	mov    QWORD PTR [rbp-0x78],rax
								pgc = pgc / 4096 + (pgc % 4096) ? 1 : 0;
    2b3e:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2b42:	48 c1 e8 0c          	shr    rax,0xc
    2b46:	48 89 c2             	mov    rdx,rax
    2b49:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2b4d:	25 ff 0f 00 00       	and    eax,0xfff
    2b52:	48 01 d0             	add    rax,rdx
    2b55:	48 85 c0             	test   rax,rax
    2b58:	0f 95 c0             	setne  al
    2b5b:	0f b6 c0             	movzx  eax,al
    2b5e:	48 89 45 88          	mov    QWORD PTR [rbp-0x78],rax
								if (mm_alloc_pm(pgc, pr, 10) == pgc) {
    2b62:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2b66:	89 c1                	mov    ecx,eax
    2b68:	48 8d 85 b0 fe ff ff 	lea    rax,[rbp-0x150]
    2b6f:	ba 0a 00 00 00       	mov    edx,0xa
    2b74:	48 89 c6             	mov    rsi,rax
    2b77:	89 cf                	mov    edi,ecx
    2b79:	e8 00 00 00 00       	call   2b7e <load_elf+0xa85>
    2b7e:	89 c0                	mov    eax,eax
    2b80:	48 39 45 88          	cmp    QWORD PTR [rbp-0x78],rax
    2b84:	75 67                	jne    2bed <load_elf+0xaf4>
										/* success */
										if (!mm_map(&mm_kernel, vm_aold, pr, 10, MMGR_MAP_WRITE | MMGR_MAP_KERNEL)) {
    2b86:	48 8d 95 b0 fe ff ff 	lea    rdx,[rbp-0x150]
    2b8d:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    2b91:	41 b8 0c 00 00 00    	mov    r8d,0xc
    2b97:	b9 0a 00 00 00       	mov    ecx,0xa
    2b9c:	48 89 c6             	mov    rsi,rax
    2b9f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2ba6:	e8 00 00 00 00       	call   2bab <load_elf+0xab2>
    2bab:	48 85 c0             	test   rax,rax
    2bae:	75 1b                	jne    2bcb <load_elf+0xad2>
												printf("unable to map new bss pages to %p\n", vm_aold);
    2bb0:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    2bb4:	48 89 c6             	mov    rsi,rax
    2bb7:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2bbe:	b8 00 00 00 00       	mov    eax,0x0
    2bc3:	e8 00 00 00 00       	call   2bc8 <load_elf+0xacf>
												while (1);
    2bc8:	90                   	nop
    2bc9:	eb fd                	jmp    2bc8 <load_elf+0xacf>
										}
										mi->sz_secs[MT_SEC_BSS] = vm_bss - mi->vm_ofs[MT_SEC_BSS];
    2bcb:	48 8b 95 58 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xa8]
    2bd2:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    2bd9:	48 8b 40 40          	mov    rax,QWORD PTR [rax+0x40]
    2bdd:	48 29 c2             	sub    rdx,rax
    2be0:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    2be7:	48 89 50 60          	mov    QWORD PTR [rax+0x60],rdx
    2beb:	eb 14                	jmp    2c01 <load_elf+0xb08>
								} else {
										printf("failed to extend bss section\n");
    2bed:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2bf4:	b8 00 00 00 00       	mov    eax,0x0
    2bf9:	e8 00 00 00 00       	call   2bfe <load_elf+0xb05>
										while (1);
    2bfe:	90                   	nop
    2bff:	eb fd                	jmp    2bfe <load_elf+0xb05>
		for (i = 0; i < hdr->e_shnum; i++)
    2c01:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
    2c06:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2c0a:	0f b7 40 30          	movzx  eax,WORD PTR [rax+0x30]
    2c0e:	0f b7 c0             	movzx  eax,ax
    2c11:	48 39 45 e8          	cmp    QWORD PTR [rbp-0x18],rax
    2c15:	0f 82 4e fe ff ff    	jb     2a69 <load_elf+0x970>
								}
						}
				}

		/* and perform the relocations */
		for (i = 0; i < hdr->e_shnum; i++)
    2c1b:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
    2c23:	e9 a6 02 00 00       	jmp    2ece <load_elf+0xdd5>
				if (shdr[i].sh_type == SHT_REL || shdr[i].sh_type == SHT_RELA) {
    2c28:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2c2c:	48 89 d0             	mov    rax,rdx
    2c2f:	48 c1 e0 02          	shl    rax,0x2
    2c33:	48 01 d0             	add    rax,rdx
    2c36:	48 c1 e0 03          	shl    rax,0x3
    2c3a:	48 89 c2             	mov    rdx,rax
    2c3d:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2c41:	48 01 d0             	add    rax,rdx
    2c44:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    2c47:	83 f8 09             	cmp    eax,0x9
    2c4a:	74 28                	je     2c74 <load_elf+0xb7b>
    2c4c:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2c50:	48 89 d0             	mov    rax,rdx
    2c53:	48 c1 e0 02          	shl    rax,0x2
    2c57:	48 01 d0             	add    rax,rdx
    2c5a:	48 c1 e0 03          	shl    rax,0x3
    2c5e:	48 89 c2             	mov    rdx,rax
    2c61:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2c65:	48 01 d0             	add    rax,rdx
    2c68:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    2c6b:	83 f8 04             	cmp    eax,0x4
    2c6e:	0f 85 55 02 00 00    	jne    2ec9 <load_elf+0xdd0>
						if (shdr[shdr[i].sh_info].sh_flags & SHF_ALLOC) {
    2c74:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2c78:	48 89 d0             	mov    rax,rdx
    2c7b:	48 c1 e0 02          	shl    rax,0x2
    2c7f:	48 01 d0             	add    rax,rdx
    2c82:	48 c1 e0 03          	shl    rax,0x3
    2c86:	48 89 c2             	mov    rdx,rax
    2c89:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2c8d:	48 01 d0             	add    rax,rdx
    2c90:	8b 40 1c             	mov    eax,DWORD PTR [rax+0x1c]
    2c93:	89 c2                	mov    edx,eax
    2c95:	48 89 d0             	mov    rax,rdx
    2c98:	48 c1 e0 02          	shl    rax,0x2
    2c9c:	48 01 d0             	add    rax,rdx
    2c9f:	48 c1 e0 03          	shl    rax,0x3
    2ca3:	48 89 c2             	mov    rdx,rax
    2ca6:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2caa:	48 01 d0             	add    rax,rdx
    2cad:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    2cb0:	83 e0 02             	and    eax,0x2
    2cb3:	85 c0                	test   eax,eax
    2cb5:	0f 84 0e 02 00 00    	je     2ec9 <load_elf+0xdd0>
								void* vm_begin = (void*)shdr[shdr[i].sh_info].sh_addr;
    2cbb:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2cbf:	48 89 d0             	mov    rax,rdx
    2cc2:	48 c1 e0 02          	shl    rax,0x2
    2cc6:	48 01 d0             	add    rax,rdx
    2cc9:	48 c1 e0 03          	shl    rax,0x3
    2ccd:	48 89 c2             	mov    rdx,rax
    2cd0:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2cd4:	48 01 d0             	add    rax,rdx
    2cd7:	8b 40 1c             	mov    eax,DWORD PTR [rax+0x1c]
    2cda:	89 c2                	mov    edx,eax
    2cdc:	48 89 d0             	mov    rax,rdx
    2cdf:	48 c1 e0 02          	shl    rax,0x2
    2ce3:	48 01 d0             	add    rax,rdx
    2ce6:	48 c1 e0 03          	shl    rax,0x3
    2cea:	48 89 c2             	mov    rdx,rax
    2ced:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2cf1:	48 01 d0             	add    rax,rdx
    2cf4:	8b 40 0c             	mov    eax,DWORD PTR [rax+0xc]
    2cf7:	89 c0                	mov    eax,eax
    2cf9:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
								size_t pgc = shdr[shdr[i].sh_info].sh_size;
    2cfd:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2d01:	48 89 d0             	mov    rax,rdx
    2d04:	48 c1 e0 02          	shl    rax,0x2
    2d08:	48 01 d0             	add    rax,rdx
    2d0b:	48 c1 e0 03          	shl    rax,0x3
    2d0f:	48 89 c2             	mov    rdx,rax
    2d12:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2d16:	48 01 d0             	add    rax,rdx
    2d19:	8b 40 1c             	mov    eax,DWORD PTR [rax+0x1c]
    2d1c:	89 c2                	mov    edx,eax
    2d1e:	48 89 d0             	mov    rax,rdx
    2d21:	48 c1 e0 02          	shl    rax,0x2
    2d25:	48 01 d0             	add    rax,rdx
    2d28:	48 c1 e0 03          	shl    rax,0x3
    2d2c:	48 89 c2             	mov    rdx,rax
    2d2f:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2d33:	48 01 d0             	add    rax,rdx
    2d36:	8b 40 14             	mov    eax,DWORD PTR [rax+0x14]
    2d39:	89 c0                	mov    eax,eax
    2d3b:	48 89 45 98          	mov    QWORD PTR [rbp-0x68],rax
								pgc = pgc / 4096 + ((pgc % 4096) ? 1 : 0);
    2d3f:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2d43:	48 c1 e8 0c          	shr    rax,0xc
    2d47:	48 89 c2             	mov    rdx,rax
    2d4a:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2d4e:	25 ff 0f 00 00       	and    eax,0xfff
    2d53:	48 85 c0             	test   rax,rax
    2d56:	74 07                	je     2d5f <load_elf+0xc66>
    2d58:	b8 01 00 00 00       	mov    eax,0x1
    2d5d:	eb 05                	jmp    2d64 <load_elf+0xc6b>
    2d5f:	b8 00 00 00 00       	mov    eax,0x0
    2d64:	48 01 d0             	add    rax,rdx
    2d67:	48 89 45 98          	mov    QWORD PTR [rbp-0x68],rax
								printf("performing relocations on section %s:\n",
										elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[shdr[i].sh_info].sh_name));
    2d6b:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2d6f:	48 89 d0             	mov    rax,rdx
    2d72:	48 c1 e0 02          	shl    rax,0x2
    2d76:	48 01 d0             	add    rax,rdx
    2d79:	48 c1 e0 03          	shl    rax,0x3
    2d7d:	48 89 c2             	mov    rdx,rax
    2d80:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2d84:	48 01 d0             	add    rax,rdx
    2d87:	8b 40 1c             	mov    eax,DWORD PTR [rax+0x1c]
    2d8a:	89 c2                	mov    edx,eax
    2d8c:	48 89 d0             	mov    rax,rdx
    2d8f:	48 c1 e0 02          	shl    rax,0x2
    2d93:	48 01 d0             	add    rax,rdx
    2d96:	48 c1 e0 03          	shl    rax,0x3
    2d9a:	48 89 c2             	mov    rdx,rax
    2d9d:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2da1:	48 01 d0             	add    rax,rdx
								printf("performing relocations on section %s:\n",
    2da4:	8b 08                	mov    ecx,DWORD PTR [rax]
										elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[shdr[i].sh_info].sh_name));
    2da6:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2daa:	0f b7 40 32          	movzx  eax,WORD PTR [rax+0x32]
								printf("performing relocations on section %s:\n",
    2dae:	0f b7 d0             	movzx  edx,ax
    2db1:	48 8b 75 a8          	mov    rsi,QWORD PTR [rbp-0x58]
    2db5:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2db9:	48 89 c7             	mov    rdi,rax
    2dbc:	e8 00 00 00 00       	call   2dc1 <load_elf+0xcc8>
    2dc1:	48 89 c6             	mov    rsi,rax
    2dc4:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2dcb:	b8 00 00 00 00       	mov    eax,0x0
    2dd0:	e8 00 00 00 00       	call   2dd5 <load_elf+0xcdc>
								/* unguard the section */
								printf("modifying %lu pages at %p\n", pgc, vm_begin);
    2dd5:	48 8b 55 a0          	mov    rdx,QWORD PTR [rbp-0x60]
    2dd9:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2ddd:	48 89 c6             	mov    rsi,rax
    2de0:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2de7:	b8 00 00 00 00       	mov    eax,0x0
    2dec:	e8 00 00 00 00       	call   2df1 <load_elf+0xcf8>
								if (!(shdr[shdr[i].sh_info].sh_flags & SHF_WRITE))
    2df1:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2df5:	48 89 d0             	mov    rax,rdx
    2df8:	48 c1 e0 02          	shl    rax,0x2
    2dfc:	48 01 d0             	add    rax,rdx
    2dff:	48 c1 e0 03          	shl    rax,0x3
    2e03:	48 89 c2             	mov    rdx,rax
    2e06:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2e0a:	48 01 d0             	add    rax,rdx
    2e0d:	8b 40 1c             	mov    eax,DWORD PTR [rax+0x1c]
    2e10:	89 c2                	mov    edx,eax
    2e12:	48 89 d0             	mov    rax,rdx
    2e15:	48 c1 e0 02          	shl    rax,0x2
    2e19:	48 01 d0             	add    rax,rdx
    2e1c:	48 c1 e0 03          	shl    rax,0x3
    2e20:	48 89 c2             	mov    rdx,rax
    2e23:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2e27:	48 01 d0             	add    rax,rdx
    2e2a:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    2e2d:	83 e0 01             	and    eax,0x1
    2e30:	85 c0                	test   eax,eax
    2e32:	75 1c                	jne    2e50 <load_elf+0xd57>
										mm_protect(&mm_kernel, vm_begin, pgc, MMGR_MAP_WRITE | MMGR_MAP_SET);
    2e34:	48 8b 55 98          	mov    rdx,QWORD PTR [rbp-0x68]
    2e38:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    2e3c:	b9 04 10 00 00       	mov    ecx,0x1004
    2e41:	48 89 c6             	mov    rsi,rax
    2e44:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2e4b:	e8 00 00 00 00       	call   2e50 <load_elf+0xd57>
								/* relocate */
								elf_relocate_section(hdr, shdr, i);
    2e50:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2e54:	0f b7 d0             	movzx  edx,ax
    2e57:	48 8b 4d a8          	mov    rcx,QWORD PTR [rbp-0x58]
    2e5b:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2e5f:	48 89 ce             	mov    rsi,rcx
    2e62:	48 89 c7             	mov    rdi,rax
    2e65:	e8 00 00 00 00       	call   2e6a <load_elf+0xd71>
								/* reguard the section */
								if (!(shdr[shdr[i].sh_info].sh_flags & SHF_WRITE))
    2e6a:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2e6e:	48 89 d0             	mov    rax,rdx
    2e71:	48 c1 e0 02          	shl    rax,0x2
    2e75:	48 01 d0             	add    rax,rdx
    2e78:	48 c1 e0 03          	shl    rax,0x3
    2e7c:	48 89 c2             	mov    rdx,rax
    2e7f:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2e83:	48 01 d0             	add    rax,rdx
    2e86:	8b 40 1c             	mov    eax,DWORD PTR [rax+0x1c]
    2e89:	89 c2                	mov    edx,eax
    2e8b:	48 89 d0             	mov    rax,rdx
    2e8e:	48 c1 e0 02          	shl    rax,0x2
    2e92:	48 01 d0             	add    rax,rdx
    2e95:	48 c1 e0 03          	shl    rax,0x3
    2e99:	48 89 c2             	mov    rdx,rax
    2e9c:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2ea0:	48 01 d0             	add    rax,rdx
    2ea3:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    2ea6:	83 e0 01             	and    eax,0x1
    2ea9:	85 c0                	test   eax,eax
    2eab:	75 1c                	jne    2ec9 <load_elf+0xdd0>
										mm_protect(&mm_kernel, vm_begin, pgc, MMGR_MAP_WRITE | MMGR_MAP_UNSET);
    2ead:	48 8b 55 98          	mov    rdx,QWORD PTR [rbp-0x68]
    2eb1:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    2eb5:	b9 04 20 00 00       	mov    ecx,0x2004
    2eba:	48 89 c6             	mov    rsi,rax
    2ebd:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2ec4:	e8 00 00 00 00       	call   2ec9 <load_elf+0xdd0>
		for (i = 0; i < hdr->e_shnum; i++)
    2ec9:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
    2ece:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2ed2:	0f b7 40 30          	movzx  eax,WORD PTR [rax+0x30]
    2ed6:	0f b7 c0             	movzx  eax,ax
    2ed9:	48 39 45 e8          	cmp    QWORD PTR [rbp-0x18],rax
    2edd:	0f 82 45 fd ff ff    	jb     2c28 <load_elf+0xb2f>
						}
				}

		/* page-align for the next module */
		/* DBG: and insert a guard-page */
		for (i = 0; i < 4; i++) {
    2ee3:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
    2eeb:	e9 c2 00 00 00       	jmp    2fb2 <load_elf+0xeb9>
				if (mi->sz_secs[i]) {
    2ef0:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    2ef7:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2efb:	48 83 c2 08          	add    rdx,0x8
    2eff:	48 8b 44 d0 08       	mov    rax,QWORD PTR [rax+rdx*8+0x8]
    2f04:	48 85 c0             	test   rax,rax
    2f07:	0f 84 a0 00 00 00    	je     2fad <load_elf+0xeb4>
						mod_tbl.vm_ofs[i] = mi->vm_ofs[i] + mi->sz_secs[i];
    2f0d:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    2f14:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    2f18:	48 83 c2 04          	add    rdx,0x4
    2f1c:	48 8b 54 d0 08       	mov    rdx,QWORD PTR [rax+rdx*8+0x8]
    2f21:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    2f28:	48 8b 4d e8          	mov    rcx,QWORD PTR [rbp-0x18]
    2f2c:	48 83 c1 08          	add    rcx,0x8
    2f30:	48 8b 44 c8 08       	mov    rax,QWORD PTR [rax+rcx*8+0x8]
    2f35:	48 01 c2             	add    rdx,rax
    2f38:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2f3c:	48 89 14 c5 00 00 00 00 	mov    QWORD PTR [rax*8+0x0],rdx
						if ((size_t)mod_tbl.vm_ofs[i] % 4096) {
    2f44:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2f48:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
    2f50:	25 ff 0f 00 00       	and    eax,0xfff
    2f55:	48 85 c0             	test   rax,rax
    2f58:	74 34                	je     2f8e <load_elf+0xe95>
								/* section align */
								mod_tbl.vm_ofs[i] += 4096 - (size_t)mod_tbl.vm_ofs[i] % 4096;
    2f5a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2f5e:	48 8b 14 c5 00 00 00 00 	mov    rdx,QWORD PTR [rax*8+0x0]
    2f66:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2f6a:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
    2f72:	25 ff 0f 00 00       	and    eax,0xfff
    2f77:	b9 00 10 00 00       	mov    ecx,0x1000
    2f7c:	48 29 c1             	sub    rcx,rax
    2f7f:	48 01 ca             	add    rdx,rcx
    2f82:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2f86:	48 89 14 c5 00 00 00 00 	mov    QWORD PTR [rax*8+0x0],rdx
						}
						/* add guard page */
						mod_tbl.vm_ofs[i] += 4096;
    2f8e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2f92:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
    2f9a:	48 8d 90 00 10 00 00 	lea    rdx,[rax+0x1000]
    2fa1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2fa5:	48 89 14 c5 00 00 00 00 	mov    QWORD PTR [rax*8+0x0],rdx
		for (i = 0; i < 4; i++) {
    2fad:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
    2fb2:	48 83 7d e8 03       	cmp    QWORD PTR [rbp-0x18],0x3
    2fb7:	0f 86 33 ff ff ff    	jbe    2ef0 <load_elf+0xdf7>
				}
		}

		return ELF_OK;
    2fbd:	b8 00 00 00 00       	mov    eax,0x0
}
    2fc2:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
    2fc6:	c9                   	leave
    2fc7:	c3                   	ret

0000000000002fc8 <get_elferr_string>:

const char* get_elferr_string(enum elferr e)
{
    2fc8:	55                   	push   rbp
    2fc9:	48 89 e5             	mov    rbp,rsp
    2fcc:	48 83 ec 08          	sub    rsp,0x8
    2fd0:	89 7d fc             	mov    DWORD PTR [rbp-0x4],edi
		switch (e) {
    2fd3:	83 7d fc 11          	cmp    DWORD PTR [rbp-0x4],0x11
    2fd7:	0f 87 af 00 00 00    	ja     308c <get_elferr_string+0xc4>
    2fdd:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    2fe0:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
    2fe8:	ff e0                	jmp    rax
		case ELF_WRONG_MAGIC:
				return "not ELF file";
    2fea:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    2ff1:	e9 9d 00 00 00       	jmp    3093 <get_elferr_string+0xcb>
		case ELF_NOT_CLASS32:
				return "not a 32-bit ELF file";
    2ff6:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    2ffd:	e9 91 00 00 00       	jmp    3093 <get_elferr_string+0xcb>
		case ELF_NOMEM:
				return "out of memory";
    3002:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    3009:	e9 85 00 00 00       	jmp    3093 <get_elferr_string+0xcb>
		case ELF_NOT_LE:
				return "not a little-endian file";
    300e:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    3015:	eb 7c                	jmp    3093 <get_elferr_string+0xcb>
		case ELF_VERSION_NOT_SUPPORTED:
				return "unsupported ELF version";
    3017:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    301e:	eb 73                	jmp    3093 <get_elferr_string+0xcb>
		case ELF_WRONG_OSABI:
				return "unsupported OS ABI";
    3020:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    3027:	eb 6a                	jmp    3093 <get_elferr_string+0xcb>
		case ELF_NOT_REL:
				return "modules have to be relocatable object files";
    3029:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    3030:	eb 61                	jmp    3093 <get_elferr_string+0xcb>
		case ELF_NOT_386:
				return "only i386 modules can be loaded";
    3032:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    3039:	eb 58                	jmp    3093 <get_elferr_string+0xcb>
		case ELF_INCOMPATIBLE_HEADER:
				return "unexpected size of ELF header";
    303b:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    3042:	eb 4f                	jmp    3093 <get_elferr_string+0xcb>
		case ELF_CONTAINS_PROG_HEADERS:
				return "ELF contains program heades (no object file)";
    3044:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    304b:	eb 46                	jmp    3093 <get_elferr_string+0xcb>
		case ELF_NO_SECTIONS_DEFINED:
				return "ELF contains no defined sections";
    304d:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    3054:	eb 3d                	jmp    3093 <get_elferr_string+0xcb>
		case ELF_WRONG_SHDR_SIZE:
				return "no matching ELF section header size";
    3056:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    305d:	eb 34                	jmp    3093 <get_elferr_string+0xcb>
		case ELF_NO_SECTION_STRTAB:
				return "no ELF STRTAB for section names";
    305f:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    3066:	eb 2b                	jmp    3093 <get_elferr_string+0xcb>
		case ELF_SECTION_RWX:
				return "module contains rwx secton";
    3068:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    306f:	eb 22                	jmp    3093 <get_elferr_string+0xcb>
		case ELF_GSTAB_ALREADY_PRESENT:
				return "the global symbol table has already been loaded";
    3071:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    3078:	eb 19                	jmp    3093 <get_elferr_string+0xcb>
		case ELF_STRING_PARSE_NUMBER:
				return "the string parser expected a number but found none";
    307a:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    3081:	eb 10                	jmp    3093 <get_elferr_string+0xcb>
		case ELF_PARSE_FORMAT_NOT_NM:
				return "the provided symbol mapping file is not in the nm format";
    3083:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    308a:	eb 07                	jmp    3093 <get_elferr_string+0xcb>
		default:
				return "unknown";
    308c:	48 c7 c0 00 00 00 00 	mov    rax,0x0
		}
}
    3093:	c9                   	leave
    3094:	c3                   	ret

0000000000003095 <elf_parse_global_symtab>:

enum elferr elf_parse_global_symtab(void* addr, size_t sz)
{
    3095:	55                   	push   rbp
    3096:	48 89 e5             	mov    rbp,rsp
    3099:	48 83 ec 50          	sub    rsp,0x50
    309d:	48 89 7d b8          	mov    QWORD PTR [rbp-0x48],rdi
    30a1:	48 89 75 b0          	mov    QWORD PTR [rbp-0x50],rsi
		const char* str = (const char*)addr; size_t cap = 64;
    30a5:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    30a9:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
    30ad:	48 c7 45 f8 40 00 00 00 	mov    QWORD PTR [rbp-0x8],0x40
		struct symbol_list* sl;
		if (gs_lst)
    30b5:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 30bc <elf_parse_global_symtab+0x27>
    30bc:	48 85 c0             	test   rax,rax
    30bf:	74 0a                	je     30cb <elf_parse_global_symtab+0x36>
				return ELF_GSTAB_ALREADY_PRESENT;
    30c1:	b8 0f 00 00 00       	mov    eax,0xf
    30c6:	e9 eb 02 00 00       	jmp    33b6 <elf_parse_global_symtab+0x321>

		/* allocate the initial capacity */
		sl = gs_lst = kmalloc(sizeof(struct symbol_list));
    30cb:	bf 08 06 00 00       	mov    edi,0x608
    30d0:	e8 00 00 00 00       	call   30d5 <elf_parse_global_symtab+0x40>
    30d5:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 30dc <elf_parse_global_symtab+0x47>
    30dc:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 30e3 <elf_parse_global_symtab+0x4e>
    30e3:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		if (!sl)
    30e7:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
    30ec:	75 0a                	jne    30f8 <elf_parse_global_symtab+0x63>
				return ELF_NOMEM;
    30ee:	b8 04 00 00 00       	mov    eax,0x4
    30f3:	e9 be 02 00 00       	jmp    33b6 <elf_parse_global_symtab+0x321>
		sl->next = NULL;
    30f8:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    30fc:	48 c7 80 00 06 00 00 00 00 00 00 	mov    QWORD PTR [rax+0x600],0x0

		while ((size_t)((void*)str - addr) < sz) {
    3107:	e9 3a 02 00 00       	jmp    3346 <elf_parse_global_symtab+0x2b1>
				const char* s1 = str; char *s2; char tp = ' ';
    310c:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    3110:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    3114:	c6 45 e7 20          	mov    BYTE PTR [rbp-0x19],0x20
				long val = strtol(str, (char**)&str, 16);
    3118:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    311c:	48 8d 4d c8          	lea    rcx,[rbp-0x38]
    3120:	ba 10 00 00 00       	mov    edx,0x10
    3125:	48 89 ce             	mov    rsi,rcx
    3128:	48 89 c7             	mov    rdi,rax
    312b:	e8 00 00 00 00       	call   3130 <elf_parse_global_symtab+0x9b>
    3130:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
				
				if (s1 == str)
    3134:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    3138:	48 39 45 e8          	cmp    QWORD PTR [rbp-0x18],rax
    313c:	75 0a                	jne    3148 <elf_parse_global_symtab+0xb3>
						return ELF_STRING_PARSE_NUMBER;
    313e:	b8 10 00 00 00       	mov    eax,0x10
    3143:	e9 6e 02 00 00       	jmp    33b6 <elf_parse_global_symtab+0x321>
				if (*str++ != ' ')
    3148:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    314c:	48 8d 50 01          	lea    rdx,[rax+0x1]
    3150:	48 89 55 c8          	mov    QWORD PTR [rbp-0x38],rdx
    3154:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    3157:	3c 20                	cmp    al,0x20
    3159:	74 0a                	je     3165 <elf_parse_global_symtab+0xd0>
						return ELF_PARSE_FORMAT_NOT_NM;
    315b:	b8 11 00 00 00       	mov    eax,0x11
    3160:	e9 51 02 00 00       	jmp    33b6 <elf_parse_global_symtab+0x321>
				tp = *str++;
    3165:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    3169:	48 8d 50 01          	lea    rdx,[rax+0x1]
    316d:	48 89 55 c8          	mov    QWORD PTR [rbp-0x38],rdx
    3171:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    3174:	88 45 e7             	mov    BYTE PTR [rbp-0x19],al
				if (*str++ != ' ')
    3177:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    317b:	48 8d 50 01          	lea    rdx,[rax+0x1]
    317f:	48 89 55 c8          	mov    QWORD PTR [rbp-0x38],rdx
    3183:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    3186:	3c 20                	cmp    al,0x20
    3188:	74 0a                	je     3194 <elf_parse_global_symtab+0xff>
						return ELF_PARSE_FORMAT_NOT_NM;
    318a:	b8 11 00 00 00       	mov    eax,0x11
    318f:	e9 22 02 00 00       	jmp    33b6 <elf_parse_global_symtab+0x321>
				s1 = strchr(str, '\n');
    3194:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    3198:	be 0a 00 00 00       	mov    esi,0xa
    319d:	48 89 c7             	mov    rdi,rax
    31a0:	e8 00 00 00 00       	call   31a5 <elf_parse_global_symtab+0x110>
    31a5:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				if (!s1) {
    31a9:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    31ae:	75 20                	jne    31d0 <elf_parse_global_symtab+0x13b>
						printf("strchr!\n");
    31b0:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    31b7:	b8 00 00 00 00       	mov    eax,0x0
    31bc:	e8 00 00 00 00       	call   31c1 <elf_parse_global_symtab+0x12c>
						s1 = (const char*)(addr + sz);
    31c1:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
    31c5:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    31c9:	48 01 d0             	add    rax,rdx
    31cc:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				}
				s2 = strndup(str, s1 - str);
    31d0:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    31d4:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    31d8:	48 29 c2             	sub    rdx,rax
    31db:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    31df:	48 89 d6             	mov    rsi,rdx
    31e2:	48 89 c7             	mov    rdi,rax
    31e5:	e8 00 00 00 00       	call   31ea <elf_parse_global_symtab+0x155>
    31ea:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax

				/*printf("symbol at %p: \"%s\" type %c\n", (void*)val, s2, tp);------------------*/
				if (strcmp(s2, "printf") == 0)
    31ee:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    31f2:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    31f9:	48 89 c7             	mov    rdi,rax
    31fc:	e8 00 00 00 00       	call   3201 <elf_parse_global_symtab+0x16c>
    3201:	85 c0                	test   eax,eax
    3203:	75 52                	jne    3257 <elf_parse_global_symtab+0x1c2>
						if (&printf != (void*)val) {
    3205:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3209:	48 3d 00 00 00 00    	cmp    rax,0x0
    320f:	74 46                	je     3257 <elf_parse_global_symtab+0x1c2>
								cprintf(KFMT_WARN, "WARNING! Loaded outdated symtab!\n");
    3211:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3218:	bf 0e 00 00 00       	mov    edi,0xe
    321d:	b8 00 00 00 00       	mov    eax,0x0
    3222:	e8 00 00 00 00       	call   3227 <elf_parse_global_symtab+0x192>
								printf("printf is located at %p but symtab says it's at %p\n",
    3227:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    322b:	48 89 c2             	mov    rdx,rax
    322e:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3235:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    323c:	b8 00 00 00 00       	mov    eax,0x0
    3241:	e8 00 00 00 00       	call   3246 <elf_parse_global_symtab+0x1b1>
												&printf, (void*)val);
								printf("expect modules to fail randomly as the\n"
    3246:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    324d:	b8 00 00 00 00       	mov    eax,0x0
    3252:	e8 00 00 00 00       	call   3257 <elf_parse_global_symtab+0x1c2>
									   "symbols used therein will not be resolved correctly\n");
						}

				/* expand the capacity if needed */
				if (!cap) {
    3257:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    325c:	75 5b                	jne    32b9 <elf_parse_global_symtab+0x224>
						sl->next = kmalloc(sizeof(struct symbol_list));
    325e:	bf 08 06 00 00       	mov    edi,0x608
    3263:	e8 00 00 00 00       	call   3268 <elf_parse_global_symtab+0x1d3>
    3268:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    326c:	48 89 82 00 06 00 00 	mov    QWORD PTR [rdx+0x600],rax
						if (!sl) {
    3273:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
    3278:	75 19                	jne    3293 <elf_parse_global_symtab+0x1fe>
								cprintf(KFMT_ERROR, "Out of memory for parsing global symbol table\n");
    327a:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3281:	bf 0c 00 00 00       	mov    edi,0xc
    3286:	b8 00 00 00 00       	mov    eax,0x0
    328b:	e8 00 00 00 00       	call   3290 <elf_parse_global_symtab+0x1fb>
								while (1);
    3290:	90                   	nop
    3291:	eb fd                	jmp    3290 <elf_parse_global_symtab+0x1fb>
						}
						sl = sl->next;
    3293:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3297:	48 8b 80 00 06 00 00 	mov    rax,QWORD PTR [rax+0x600]
    329e:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
						sl->next = NULL;
    32a2:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    32a6:	48 c7 80 00 06 00 00 00 00 00 00 	mov    QWORD PTR [rax+0x600],0x0
						cap = 64;
    32b1:	48 c7 45 f8 40 00 00 00 	mov    QWORD PTR [rbp-0x8],0x40
				}

				/* store the two values */
				sl->entries[64 - cap].name = s2;
    32b9:	b8 40 00 00 00       	mov    eax,0x40
    32be:	48 2b 45 f8          	sub    rax,QWORD PTR [rbp-0x8]
    32c2:	48 89 c2             	mov    rdx,rax
    32c5:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
    32c9:	48 89 d0             	mov    rax,rdx
    32cc:	48 01 c0             	add    rax,rax
    32cf:	48 01 d0             	add    rax,rdx
    32d2:	48 c1 e0 03          	shl    rax,0x3
    32d6:	48 01 c8             	add    rax,rcx
    32d9:	48 8d 50 08          	lea    rdx,[rax+0x8]
    32dd:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    32e1:	48 89 02             	mov    QWORD PTR [rdx],rax
				sl->entries[64 - cap].vma = (void*)val;
    32e4:	b8 40 00 00 00       	mov    eax,0x40
    32e9:	48 2b 45 f8          	sub    rax,QWORD PTR [rbp-0x8]
    32ed:	48 89 c2             	mov    rdx,rax
    32f0:	48 8b 4d d8          	mov    rcx,QWORD PTR [rbp-0x28]
    32f4:	48 8b 75 f0          	mov    rsi,QWORD PTR [rbp-0x10]
    32f8:	48 89 d0             	mov    rax,rdx
    32fb:	48 01 c0             	add    rax,rax
    32fe:	48 01 d0             	add    rax,rdx
    3301:	48 c1 e0 03          	shl    rax,0x3
    3305:	48 01 f0             	add    rax,rsi
    3308:	48 89 08             	mov    QWORD PTR [rax],rcx
				sl->entries[64 - cap].type = tp;
    330b:	b8 40 00 00 00       	mov    eax,0x40
    3310:	48 2b 45 f8          	sub    rax,QWORD PTR [rbp-0x8]
    3314:	48 89 c2             	mov    rdx,rax
    3317:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
    331b:	48 89 d0             	mov    rax,rdx
    331e:	48 01 c0             	add    rax,rax
    3321:	48 01 d0             	add    rax,rdx
    3324:	48 c1 e0 03          	shl    rax,0x3
    3328:	48 01 c8             	add    rax,rcx
    332b:	48 8d 50 10          	lea    rdx,[rax+0x10]
    332f:	0f b6 45 e7          	movzx  eax,BYTE PTR [rbp-0x19]
    3333:	88 02                	mov    BYTE PTR [rdx],al
				cap--;
    3335:	48 83 6d f8 01       	sub    QWORD PTR [rbp-0x8],0x1
				/* and advance */
				str = s1 + 1;
    333a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    333e:	48 83 c0 01          	add    rax,0x1
    3342:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
		while ((size_t)((void*)str - addr) < sz) {
    3346:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    334a:	48 2b 45 b8          	sub    rax,QWORD PTR [rbp-0x48]
    334e:	48 3b 45 b0          	cmp    rax,QWORD PTR [rbp-0x50]
    3352:	0f 82 b4 fd ff ff    	jb     310c <elf_parse_global_symtab+0x77>
		}

		/* zero-terminate not fully used lists */
		if (cap) {
    3358:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    335d:	74 52                	je     33b1 <elf_parse_global_symtab+0x31c>
				sl->entries[64 - cap].name = NULL;
    335f:	b8 40 00 00 00       	mov    eax,0x40
    3364:	48 2b 45 f8          	sub    rax,QWORD PTR [rbp-0x8]
    3368:	48 89 c2             	mov    rdx,rax
    336b:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
    336f:	48 89 d0             	mov    rax,rdx
    3372:	48 01 c0             	add    rax,rax
    3375:	48 01 d0             	add    rax,rdx
    3378:	48 c1 e0 03          	shl    rax,0x3
    337c:	48 01 c8             	add    rax,rcx
    337f:	48 83 c0 08          	add    rax,0x8
    3383:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
				sl->entries[64 - cap].vma = NULL;
    338a:	b8 40 00 00 00       	mov    eax,0x40
    338f:	48 2b 45 f8          	sub    rax,QWORD PTR [rbp-0x8]
    3393:	48 89 c2             	mov    rdx,rax
    3396:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
    339a:	48 89 d0             	mov    rax,rdx
    339d:	48 01 c0             	add    rax,rax
    33a0:	48 01 d0             	add    rax,rdx
    33a3:	48 c1 e0 03          	shl    rax,0x3
    33a7:	48 01 c8             	add    rax,rcx
    33aa:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
		}
		return ELF_OK;
    33b1:	b8 00 00 00 00       	mov    eax,0x0
}
    33b6:	c9                   	leave
    33b7:	c3                   	ret

00000000000033b8 <load_modules>:

void load_modules()
{
    33b8:	55                   	push   rbp
    33b9:	48 89 e5             	mov    rbp,rsp
    33bc:	48 81 ec 90 00 00 00 	sub    rsp,0x90
		void* mem = (void*)0x200000;
    33c3:	48 c7 45 f8 00 00 20 00 	mov    QWORD PTR [rbp-0x8],0x200000
		uint32_t mct = *(uint32_t*)mem;
    33cb:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    33cf:	8b 00                	mov    eax,DWORD PTR [rax]
    33d1:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
		enum elferr ee;
		mem += sizeof(uint32_t);
    33d4:	48 83 45 f8 04       	add    QWORD PTR [rbp-0x8],0x4

		if (strcmp(mem, "LD.MAP") != 0) {
    33d9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    33dd:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    33e4:	48 89 c7             	mov    rdi,rax
    33e7:	e8 00 00 00 00       	call   33ec <load_modules+0x34>
    33ec:	85 c0                	test   eax,eax
    33ee:	74 19                	je     3409 <load_modules+0x51>
				cprintf(KFMT_ERROR, "first file has to be global symbol map\n");
    33f0:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    33f7:	bf 0c 00 00 00       	mov    edi,0xc
    33fc:	b8 00 00 00 00       	mov    eax,0x0
    3401:	e8 00 00 00 00       	call   3406 <load_modules+0x4e>
				while (1);
    3406:	90                   	nop
    3407:	eb fd                	jmp    3406 <load_modules+0x4e>
		} else
				mem += 7;
    3409:	48 83 45 f8 07       	add    QWORD PTR [rbp-0x8],0x7
		/* parse the kernel symbol table supplied in nm format */
		if ((ee = elf_parse_global_symtab(mem + sizeof(uint32_t), *(uint32_t*)mem))) {
    340e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3412:	8b 00                	mov    eax,DWORD PTR [rax]
    3414:	89 c2                	mov    edx,eax
    3416:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    341a:	48 83 c0 04          	add    rax,0x4
    341e:	48 89 d6             	mov    rsi,rdx
    3421:	48 89 c7             	mov    rdi,rax
    3424:	e8 00 00 00 00       	call   3429 <load_modules+0x71>
    3429:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
    342c:	83 7d f0 00          	cmp    DWORD PTR [rbp-0x10],0x0
    3430:	74 57                	je     3489 <load_modules+0xd1>
				cprintf(KFMT_ERROR, "Failed to parse global kernel symbol table ("
    3432:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3439:	bf 0c 00 00 00       	mov    edi,0xc
    343e:	b8 00 00 00 00       	mov    eax,0x0
    3443:	e8 00 00 00 00       	call   3448 <load_modules+0x90>
					   "file ld.map in root directory)\n");
				cprintf(KFMT_ERROR, "reason: %s\n", get_elferr_string(ee));
    3448:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
    344b:	89 c7                	mov    edi,eax
    344d:	e8 00 00 00 00       	call   3452 <load_modules+0x9a>
    3452:	48 89 c2             	mov    rdx,rax
    3455:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    345c:	bf 0c 00 00 00       	mov    edi,0xc
    3461:	b8 00 00 00 00       	mov    eax,0x0
    3466:	e8 00 00 00 00       	call   346b <load_modules+0xb3>
				memdump(mem + sizeof(uint32_t), *(uint32_t*)mem);
    346b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    346f:	8b 00                	mov    eax,DWORD PTR [rax]
    3471:	89 c2                	mov    edx,eax
    3473:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3477:	48 83 c0 04          	add    rax,0x4
    347b:	48 89 d6             	mov    rsi,rdx
    347e:	48 89 c7             	mov    rdi,rax
    3481:	e8 00 00 00 00       	call   3486 <load_modules+0xce>
				while (1);
    3486:	90                   	nop
    3487:	eb fd                	jmp    3486 <load_modules+0xce>
		}
		mem += sizeof(uint32_t) + *(uint32_t*)mem;
    3489:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    348d:	8b 00                	mov    eax,DWORD PTR [rax]
    348f:	89 c0                	mov    eax,eax
    3491:	48 83 c0 04          	add    rax,0x4
    3495:	48 01 45 f8          	add    QWORD PTR [rbp-0x8],rax
		mct--;
    3499:	83 6d f4 01          	sub    DWORD PTR [rbp-0xc],0x1

		/* try to load each module */
		while (mct--) {
    349d:	e9 ff 01 00 00       	jmp    36a1 <load_modules+0x2e9>
				const char* name = (const char*)mem;
    34a2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    34a6:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				uint32_t sz;
				struct module_info mi = {0};
    34aa:	48 8d 95 78 ff ff ff 	lea    rdx,[rbp-0x88]
    34b1:	b8 00 00 00 00       	mov    eax,0x0
    34b6:	b9 0d 00 00 00       	mov    ecx,0xd
    34bb:	48 89 d7             	mov    rdi,rdx
    34be:	f3 48 ab             	rep stos QWORD PTR es:[rdi],rax
				mem += strlen(name) + 1;
    34c1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    34c5:	48 89 c7             	mov    rdi,rax
    34c8:	e8 00 00 00 00       	call   34cd <load_modules+0x115>
    34cd:	48 83 c0 01          	add    rax,0x1
    34d1:	48 01 45 f8          	add    QWORD PTR [rbp-0x8],rax
				sz = *(uint32_t*)mem;
    34d5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    34d9:	8b 00                	mov    eax,DWORD PTR [rax]
    34db:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
				mem += sizeof(uint32_t);
    34de:	48 83 45 f8 04       	add    QWORD PTR [rbp-0x8],0x4
				strncpy(mi.mi_name, name, 20);
    34e3:	48 8b 4d e8          	mov    rcx,QWORD PTR [rbp-0x18]
    34e7:	48 8d 85 78 ff ff ff 	lea    rax,[rbp-0x88]
    34ee:	ba 14 00 00 00       	mov    edx,0x14
    34f3:	48 89 ce             	mov    rsi,rcx
    34f6:	48 89 c7             	mov    rdi,rax
    34f9:	e8 00 00 00 00       	call   34fe <load_modules+0x146>
				printf("loading module %.20s...\n", mi.mi_name);
    34fe:	48 8d 85 78 ff ff ff 	lea    rax,[rbp-0x88]
    3505:	48 89 c6             	mov    rsi,rax
    3508:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    350f:	b8 00 00 00 00       	mov    eax,0x0
    3514:	e8 00 00 00 00       	call   3519 <load_modules+0x161>
				if ((ee = load_elf(mem, sz, &mi))) {
    3519:	48 8d 95 78 ff ff ff 	lea    rdx,[rbp-0x88]
    3520:	8b 4d e4             	mov    ecx,DWORD PTR [rbp-0x1c]
    3523:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3527:	89 ce                	mov    esi,ecx
    3529:	48 89 c7             	mov    rdi,rax
    352c:	e8 00 00 00 00       	call   3531 <load_modules+0x179>
    3531:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
    3534:	83 7d f0 00          	cmp    DWORD PTR [rbp-0x10],0x0
    3538:	74 43                	je     357d <load_modules+0x1c5>
						cprintf(KFMT_ERROR, "Failed to load ELF module at %p\n", mem);
    353a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    353e:	48 89 c2             	mov    rdx,rax
    3541:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3548:	bf 0c 00 00 00       	mov    edi,0xc
    354d:	b8 00 00 00 00       	mov    eax,0x0
    3552:	e8 00 00 00 00       	call   3557 <load_modules+0x19f>
						cprintf(KFMT_ERROR, "reason: %s\n", get_elferr_string(ee));
    3557:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
    355a:	89 c7                	mov    edi,eax
    355c:	e8 00 00 00 00       	call   3561 <load_modules+0x1a9>
    3561:	48 89 c2             	mov    rdx,rax
    3564:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    356b:	bf 0c 00 00 00       	mov    edi,0xc
    3570:	b8 00 00 00 00       	mov    eax,0x0
    3575:	e8 00 00 00 00       	call   357a <load_modules+0x1c2>
						while (1);
    357a:	90                   	nop
    357b:	eb fd                	jmp    357a <load_modules+0x1c2>
				} else {
						int errc;
						cprintf(KFMT_INFO, "loaded module at the following offsets and sizes:\n");
    357d:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3584:	bf 0b 00 00 00       	mov    edi,0xb
    3589:	b8 00 00 00 00       	mov    eax,0x0
    358e:	e8 00 00 00 00       	call   3593 <load_modules+0x1db>
						cprintf(KFMT_INFO, ".text    %p %11lu\n", mi.vm_ofs[0], mi.sz_secs[0]);
    3593:	48 8b 55 c0          	mov    rdx,QWORD PTR [rbp-0x40]
    3597:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    359b:	48 89 d1             	mov    rcx,rdx
    359e:	48 89 c2             	mov    rdx,rax
    35a1:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    35a8:	bf 0b 00 00 00       	mov    edi,0xb
    35ad:	b8 00 00 00 00       	mov    eax,0x0
    35b2:	e8 00 00 00 00       	call   35b7 <load_modules+0x1ff>
						cprintf(KFMT_INFO, ".data    %p %11lu\n", mi.vm_ofs[1], mi.sz_secs[1]);
    35b7:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    35bb:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    35bf:	48 89 d1             	mov    rcx,rdx
    35c2:	48 89 c2             	mov    rdx,rax
    35c5:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    35cc:	bf 0b 00 00 00       	mov    edi,0xb
    35d1:	b8 00 00 00 00       	mov    eax,0x0
    35d6:	e8 00 00 00 00       	call   35db <load_modules+0x223>
						cprintf(KFMT_INFO, ".rodata  %p %11lu\n", mi.vm_ofs[2], mi.sz_secs[2]);
    35db:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    35df:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    35e3:	48 89 d1             	mov    rcx,rdx
    35e6:	48 89 c2             	mov    rdx,rax
    35e9:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    35f0:	bf 0b 00 00 00       	mov    edi,0xb
    35f5:	b8 00 00 00 00       	mov    eax,0x0
    35fa:	e8 00 00 00 00       	call   35ff <load_modules+0x247>
						cprintf(KFMT_INFO, ".bss     %p %11lu\n", mi.vm_ofs[3], mi.sz_secs[3]);
    35ff:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    3603:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    3607:	48 89 d1             	mov    rcx,rdx
    360a:	48 89 c2             	mov    rdx,rax
    360d:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3614:	bf 0b 00 00 00       	mov    edi,0xb
    3619:	b8 00 00 00 00       	mov    eax,0x0
    361e:	e8 00 00 00 00       	call   3623 <load_modules+0x26b>
						cprintf(KFMT_INFO, "calling module_init()...\n");
    3623:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    362a:	bf 0b 00 00 00       	mov    edi,0xb
    362f:	b8 00 00 00 00       	mov    eax,0x0
    3634:	e8 00 00 00 00       	call   3639 <load_modules+0x281>
						errc = mi.mi_init();
    3639:	48 8b 55 90          	mov    rdx,QWORD PTR [rbp-0x70]
    363d:	b8 00 00 00 00       	mov    eax,0x0
    3642:	ff d2                	call   rdx
    3644:	89 45 e0             	mov    DWORD PTR [rbp-0x20],eax
						if (errc) {
    3647:	83 7d e0 00          	cmp    DWORD PTR [rbp-0x20],0x0
    364b:	74 1e                	je     366b <load_modules+0x2b3>
								cprintf(KFMT_ERROR, "init failed with error %d\n", errc);
    364d:	8b 45 e0             	mov    eax,DWORD PTR [rbp-0x20]
    3650:	89 c2                	mov    edx,eax
    3652:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3659:	bf 0c 00 00 00       	mov    edi,0xc
    365e:	b8 00 00 00 00       	mov    eax,0x0
    3663:	e8 00 00 00 00       	call   3668 <load_modules+0x2b0>
								while (1);
    3668:	90                   	nop
    3669:	eb fd                	jmp    3668 <load_modules+0x2b0>
						} else {
								cprintf(KFMT_OK, "successfully initialized module \"%s\"\n", mi.mi_name);
    366b:	48 8d 85 78 ff ff ff 	lea    rax,[rbp-0x88]
    3672:	48 89 c2             	mov    rdx,rax
    3675:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    367c:	bf 0a 00 00 00       	mov    edi,0xa
    3681:	b8 00 00 00 00       	mov    eax,0x0
    3686:	e8 00 00 00 00       	call   368b <load_modules+0x2d3>
								store_module_info(&mi);
    368b:	48 8d 85 78 ff ff ff 	lea    rax,[rbp-0x88]
    3692:	48 89 c7             	mov    rdi,rax
    3695:	e8 00 00 00 00       	call   369a <load_modules+0x2e2>
						}
				}

				mem += sz;
    369a:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    369d:	48 01 45 f8          	add    QWORD PTR [rbp-0x8],rax
		while (mct--) {
    36a1:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    36a4:	8d 50 ff             	lea    edx,[rax-0x1]
    36a7:	89 55 f4             	mov    DWORD PTR [rbp-0xc],edx
    36aa:	85 c0                	test   eax,eax
    36ac:	0f 85 f0 fd ff ff    	jne    34a2 <load_modules+0xea>
		}

		printf("done loading kernel modules\n");
    36b2:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    36b9:	b8 00 00 00 00       	mov    eax,0x0
    36be:	e8 00 00 00 00       	call   36c3 <load_modules+0x30b>
}
    36c3:	90                   	nop
    36c4:	c9                   	leave
    36c5:	c3                   	ret
