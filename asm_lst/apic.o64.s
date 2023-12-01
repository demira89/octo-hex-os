
apic.o64:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <per_cpu_ptr>:
		for (int i = 0; i < 16; i++) {
				uint32_t pin = 0;
				if (!ioapic_mappings[i].ptr_base)
						continue;
				for (int j = 0; j < ioapic_mappings[i].max_pin + 1; j++) {
						uint32_t st;
   0:	55                   	push   rbp
   1:	48 89 e5             	mov    rbp,rsp
   4:	48 83 ec 10          	sub    rsp,0x10
						st = ioapic_read(i, 0x10 + 2 * j);
						if (st & (1 << 12)) /* DS=pending */
								pin |= (1 << j);
   8:	65 48 8b 04 25 00 00 00 00 	mov    rax,QWORD PTR gs:0x0
  11:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				}
				printf("IOAPIC%u: %08x\n", i, pin);
		}
}
  15:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]

  19:	c9                   	leave
  1a:	c3                   	ret

000000000000001b <cpu_get_msr>:
{
  1b:	55                   	push   rbp
  1c:	48 89 e5             	mov    rbp,rsp
  1f:	48 83 ec 18          	sub    rsp,0x18
  23:	89 7d fc             	mov    DWORD PTR [rbp-0x4],edi
  26:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
  2a:	48 89 55 e8          	mov    QWORD PTR [rbp-0x18],rdx
		__asm__("rdmsr" : "=a" (*eax), "=d" (*edx) : "c" (msr) : );
  2e:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
  31:	89 c1                	mov    ecx,eax
  33:	0f 32                	rdmsr
  35:	89 c1                	mov    ecx,eax
  37:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
  3b:	89 08                	mov    DWORD PTR [rax],ecx
  3d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
  41:	89 10                	mov    DWORD PTR [rax],edx
}
  43:	90                   	nop
  44:	c9                   	leave
  45:	c3                   	ret

0000000000000046 <cpu_set_msr>:
{
  46:	55                   	push   rbp
  47:	48 89 e5             	mov    rbp,rsp
  4a:	48 83 ec 10          	sub    rsp,0x10
  4e:	89 7d fc             	mov    DWORD PTR [rbp-0x4],edi
  51:	89 75 f8             	mov    DWORD PTR [rbp-0x8],esi
  54:	89 55 f4             	mov    DWORD PTR [rbp-0xc],edx
		__asm__("wrmsr" : : "a" (eax), "d" (edx), "c" (msr) : );
  57:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
  5a:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
  5d:	8b 4d fc             	mov    ecx,DWORD PTR [rbp-0x4]
  60:	0f 30                	wrmsr
}
  62:	90                   	nop
  63:	c9                   	leave
  64:	c3                   	ret

0000000000000065 <apic_set_tpr>:
{
  65:	55                   	push   rbp
  66:	48 89 e5             	mov    rbp,rsp
  69:	53                   	push   rbx
  6a:	48 83 ec 08          	sub    rsp,0x8
  6e:	89 f8                	mov    eax,edi
  70:	88 45 f4             	mov    BYTE PTR [rbp-0xc],al
		apic_reg(APIC_REG_TASKPRIOR) = (tpr << 4);
  73:	0f b6 5d f4          	movzx  ebx,BYTE PTR [rbp-0xc]
  77:	b8 00 00 00 00       	mov    eax,0x0
  7c:	e8 7f ff ff ff       	call   0 <per_cpu_ptr>
  81:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
  85:	48 83 e8 80          	sub    rax,0xffffffffffffff80
  89:	89 da                	mov    edx,ebx
  8b:	c1 e2 04             	shl    edx,0x4
  8e:	89 10                	mov    DWORD PTR [rax],edx
}
  90:	90                   	nop
  91:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
  95:	c9                   	leave
  96:	c3                   	ret

0000000000000097 <apic_set_ldr>:
{
  97:	55                   	push   rbp
  98:	48 89 e5             	mov    rbp,rsp
  9b:	53                   	push   rbx
  9c:	48 83 ec 08          	sub    rsp,0x8
  a0:	89 f8                	mov    eax,edi
  a2:	88 45 f4             	mov    BYTE PTR [rbp-0xc],al
		apic_reg(APIC_REG_LDR) = (uint32_t)ld << 24;
  a5:	0f b6 5d f4          	movzx  ebx,BYTE PTR [rbp-0xc]
  a9:	b8 00 00 00 00       	mov    eax,0x0
  ae:	e8 4d ff ff ff       	call   0 <per_cpu_ptr>
  b3:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
  b7:	48 05 d0 00 00 00    	add    rax,0xd0
  bd:	89 da                	mov    edx,ebx
  bf:	c1 e2 18             	shl    edx,0x18
  c2:	89 10                	mov    DWORD PTR [rax],edx
}
  c4:	90                   	nop
  c5:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
  c9:	c9                   	leave
  ca:	c3                   	ret

00000000000000cb <apic_set_dfr>:
{
  cb:	55                   	push   rbp
  cc:	48 89 e5             	mov    rbp,rsp
  cf:	53                   	push   rbx
  d0:	48 83 ec 08          	sub    rsp,0x8
  d4:	89 f8                	mov    eax,edi
  d6:	88 45 f4             	mov    BYTE PTR [rbp-0xc],al
		apic_reg(APIC_REG_DFR) = ((uint32_t)mod << 28) | 0x0fffffff;
  d9:	0f b6 45 f4          	movzx  eax,BYTE PTR [rbp-0xc]
  dd:	c1 e0 1c             	shl    eax,0x1c
  e0:	89 c3                	mov    ebx,eax
  e2:	b8 00 00 00 00       	mov    eax,0x0
  e7:	e8 14 ff ff ff       	call   0 <per_cpu_ptr>
  ec:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
  f0:	48 05 e0 00 00 00    	add    rax,0xe0
  f6:	89 da                	mov    edx,ebx
  f8:	81 ca ff ff ff 0f    	or     edx,0xfffffff
  fe:	89 10                	mov    DWORD PTR [rax],edx
}
 100:	90                   	nop
 101:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
 105:	c9                   	leave
 106:	c3                   	ret

0000000000000107 <ioapic_read>:
{
 107:	55                   	push   rbp
 108:	48 89 e5             	mov    rbp,rsp
 10b:	48 83 ec 18          	sub    rsp,0x18
 10f:	89 fa                	mov    edx,edi
 111:	89 f0                	mov    eax,esi
 113:	88 55 ec             	mov    BYTE PTR [rbp-0x14],dl
 116:	88 45 e8             	mov    BYTE PTR [rbp-0x18],al
		void* ptr = ioapic_mappings[id].ptr_base + ioapic_mappings[id].ptr_ofs;
 119:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
 11d:	48 63 d0             	movsxd rdx,eax
 120:	48 89 d0             	mov    rax,rdx
 123:	48 01 c0             	add    rax,rax
 126:	48 01 d0             	add    rax,rdx
 129:	48 c1 e0 03          	shl    rax,0x3
 12d:	48 05 00 00 00 00    	add    rax,0x0
 133:	48 8b 08             	mov    rcx,QWORD PTR [rax]
 136:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
 13a:	48 63 d0             	movsxd rdx,eax
 13d:	48 89 d0             	mov    rax,rdx
 140:	48 01 c0             	add    rax,rax
 143:	48 01 d0             	add    rax,rdx
 146:	48 c1 e0 03          	shl    rax,0x3
 14a:	48 05 00 00 00 00    	add    rax,0x0
 150:	0f b7 00             	movzx  eax,WORD PTR [rax]
 153:	0f b7 c0             	movzx  eax,ax
 156:	48 01 c8             	add    rax,rcx
 159:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		*(volatile uint8_t*)ptr = reg;
 15d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 161:	0f b6 55 e8          	movzx  edx,BYTE PTR [rbp-0x18]
 165:	88 10                	mov    BYTE PTR [rax],dl
		return *(volatile uint32_t*)(ptr + 0x10);
 167:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 16b:	48 83 c0 10          	add    rax,0x10
 16f:	8b 00                	mov    eax,DWORD PTR [rax]
}
 171:	c9                   	leave
 172:	c3                   	ret

0000000000000173 <ioapic_write>:
{
 173:	55                   	push   rbp
 174:	48 89 e5             	mov    rbp,rsp
 177:	48 83 ec 20          	sub    rsp,0x20
 17b:	89 f9                	mov    ecx,edi
 17d:	89 f0                	mov    eax,esi
 17f:	89 55 e4             	mov    DWORD PTR [rbp-0x1c],edx
 182:	89 ca                	mov    edx,ecx
 184:	88 55 ec             	mov    BYTE PTR [rbp-0x14],dl
 187:	88 45 e8             	mov    BYTE PTR [rbp-0x18],al
		void* ptr = ioapic_mappings[id].ptr_base + ioapic_mappings[id].ptr_ofs;
 18a:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
 18e:	48 63 d0             	movsxd rdx,eax
 191:	48 89 d0             	mov    rax,rdx
 194:	48 01 c0             	add    rax,rax
 197:	48 01 d0             	add    rax,rdx
 19a:	48 c1 e0 03          	shl    rax,0x3
 19e:	48 05 00 00 00 00    	add    rax,0x0
 1a4:	48 8b 08             	mov    rcx,QWORD PTR [rax]
 1a7:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
 1ab:	48 63 d0             	movsxd rdx,eax
 1ae:	48 89 d0             	mov    rax,rdx
 1b1:	48 01 c0             	add    rax,rax
 1b4:	48 01 d0             	add    rax,rdx
 1b7:	48 c1 e0 03          	shl    rax,0x3
 1bb:	48 05 00 00 00 00    	add    rax,0x0
 1c1:	0f b7 00             	movzx  eax,WORD PTR [rax]
 1c4:	0f b7 c0             	movzx  eax,ax
 1c7:	48 01 c8             	add    rax,rcx
 1ca:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		*(volatile uint8_t*)ptr = reg;
 1ce:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 1d2:	0f b6 55 e8          	movzx  edx,BYTE PTR [rbp-0x18]
 1d6:	88 10                	mov    BYTE PTR [rax],dl
		*(volatile uint32_t*)(ptr + 0x10) = val;
 1d8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 1dc:	48 8d 50 10          	lea    rdx,[rax+0x10]
 1e0:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
 1e3:	89 02                	mov    DWORD PTR [rdx],eax
}
 1e5:	90                   	nop
 1e6:	c9                   	leave
 1e7:	c3                   	ret

00000000000001e8 <init_ioapic>:
{
 1e8:	55                   	push   rbp
 1e9:	48 89 e5             	mov    rbp,rsp
 1ec:	53                   	push   rbx
 1ed:	48 83 ec 58          	sub    rsp,0x58
 1f1:	89 f8                	mov    eax,edi
 1f3:	48 89 75 a0          	mov    QWORD PTR [rbp-0x60],rsi
 1f7:	88 45 ac             	mov    BYTE PTR [rbp-0x54],al
		void* vmem = NULL; size_t ofs = (size_t)addr % 4096;
 1fa:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
 202:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
 206:	25 ff 0f 00 00       	and    eax,0xfff
 20b:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
		uint64_t page = (size_t)addr - (size_t)addr % 4096;
 20f:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
 213:	48 25 00 f0 ff ff    	and    rax,0xfffffffffffff000
 219:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
		printf("%p %x\n", addr, (uint32_t)page);
 21d:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
 221:	89 c2                	mov    edx,eax
 223:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
 227:	48 89 c6             	mov    rsi,rax
 22a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 231:	b8 00 00 00 00       	mov    eax,0x0
 236:	e8 00 00 00 00       	call   23b <init_ioapic+0x53>
		for (size_t i = 0; i < 16; i++)
 23b:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
 243:	eb 45                	jmp    28a <init_ioapic+0xa2>
				if (ioapic_mappings[i].page == page) {
 245:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
 249:	48 89 d0             	mov    rax,rdx
 24c:	48 01 c0             	add    rax,rax
 24f:	48 01 d0             	add    rax,rdx
 252:	48 c1 e0 03          	shl    rax,0x3
 256:	48 05 00 00 00 00    	add    rax,0x0
 25c:	48 8b 00             	mov    rax,QWORD PTR [rax]
 25f:	48 39 45 c8          	cmp    QWORD PTR [rbp-0x38],rax
 263:	75 20                	jne    285 <init_ioapic+0x9d>
						vmem = ioapic_mappings[i].ptr_base;
 265:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
 269:	48 89 d0             	mov    rax,rdx
 26c:	48 01 c0             	add    rax,rax
 26f:	48 01 d0             	add    rax,rdx
 272:	48 c1 e0 03          	shl    rax,0x3
 276:	48 05 00 00 00 00    	add    rax,0x0
 27c:	48 8b 00             	mov    rax,QWORD PTR [rax]
 27f:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
						break;
 283:	eb 0c                	jmp    291 <init_ioapic+0xa9>
		for (size_t i = 0; i < 16; i++)
 285:	48 83 45 e0 01       	add    QWORD PTR [rbp-0x20],0x1
 28a:	48 83 7d e0 0f       	cmp    QWORD PTR [rbp-0x20],0xf
 28f:	76 b4                	jbe    245 <init_ioapic+0x5d>
		if (!vmem) {
 291:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
 296:	0f 85 af 00 00 00    	jne    34b <init_ioapic+0x163>
				vmem = bp_apic_base - 4096;
 29c:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2a3 <init_ioapic+0xbb>
 2a3:	48 2d 00 10 00 00    	sub    rax,0x1000
 2a9:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				pr.base = page; pr.count = 1;
 2ad:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
 2b1:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
 2b5:	48 c7 45 b8 01 00 00 00 	mov    QWORD PTR [rbp-0x48],0x1
				vmem = mm_map(&mm_kernel, bp_apic_base - 4096, &pr, 1,
 2bd:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2c4 <init_ioapic+0xdc>
 2c4:	48 8d b0 00 f0 ff ff 	lea    rsi,[rax-0x1000]
 2cb:	48 8d 45 b0          	lea    rax,[rbp-0x50]
 2cf:	41 b8 2d 00 00 00    	mov    r8d,0x2d
 2d5:	b9 01 00 00 00       	mov    ecx,0x1
 2da:	48 89 c2             	mov    rdx,rax
 2dd:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 2e4:	e8 00 00 00 00       	call   2e9 <init_ioapic+0x101>
 2e9:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				if (!vmem) {
 2ed:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
 2f2:	75 30                	jne    324 <init_ioapic+0x13c>
						die("unable to map I/O APIC.\n");
 2f4:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
 2fb:	bf 0c 00 00 00       	mov    edi,0xc
 300:	b8 00 00 00 00       	mov    eax,0x0
 305:	e8 00 00 00 00       	call   30a <init_ioapic+0x122>
 30a:	b8 00 00 00 00       	mov    eax,0x0
 30f:	e8 00 00 00 00       	call   314 <init_ioapic+0x12c>
 314:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 31b:	e8 00 00 00 00       	call   320 <init_ioapic+0x138>
 320:	fa                   	cli
 321:	f4                   	hlt
 322:	eb fd                	jmp    321 <init_ioapic+0x139>
				} else if (vmem == bp_apic_base - 4096)
 324:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 32b <init_ioapic+0x143>
 32b:	48 2d 00 10 00 00    	sub    rax,0x1000
 331:	48 39 45 e8          	cmp    QWORD PTR [rbp-0x18],rax
 335:	75 14                	jne    34b <init_ioapic+0x163>
						bp_apic_base -= 4096;
 337:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 33e <init_ioapic+0x156>
 33e:	48 2d 00 10 00 00    	sub    rax,0x1000
 344:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 34b <init_ioapic+0x163>
		if (id < 16) {
 34b:	80 7d ac 0f          	cmp    BYTE PTR [rbp-0x54],0xf
 34f:	0f 87 4d 01 00 00    	ja     4a2 <init_ioapic+0x2ba>
				ioapic_mappings[id].page = page;
 355:	0f b6 45 ac          	movzx  eax,BYTE PTR [rbp-0x54]
 359:	48 63 d0             	movsxd rdx,eax
 35c:	48 89 d0             	mov    rax,rdx
 35f:	48 01 c0             	add    rax,rax
 362:	48 01 d0             	add    rax,rdx
 365:	48 c1 e0 03          	shl    rax,0x3
 369:	48 8d 90 00 00 00 00 	lea    rdx,[rax+0x0]
 370:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
 374:	48 89 02             	mov    QWORD PTR [rdx],rax
				ioapic_mappings[id].ptr_base = vmem;
 377:	0f b6 45 ac          	movzx  eax,BYTE PTR [rbp-0x54]
 37b:	48 63 d0             	movsxd rdx,eax
 37e:	48 89 d0             	mov    rax,rdx
 381:	48 01 c0             	add    rax,rax
 384:	48 01 d0             	add    rax,rdx
 387:	48 c1 e0 03          	shl    rax,0x3
 38b:	48 8d 90 00 00 00 00 	lea    rdx,[rax+0x0]
 392:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 396:	48 89 02             	mov    QWORD PTR [rdx],rax
				ioapic_mappings[id].ptr_ofs = ofs;
 399:	0f b6 45 ac          	movzx  eax,BYTE PTR [rbp-0x54]
 39d:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
 3a1:	89 d1                	mov    ecx,edx
 3a3:	48 63 d0             	movsxd rdx,eax
 3a6:	48 89 d0             	mov    rax,rdx
 3a9:	48 01 c0             	add    rax,rax
 3ac:	48 01 d0             	add    rax,rdx
 3af:	48 c1 e0 03          	shl    rax,0x3
 3b3:	48 05 00 00 00 00    	add    rax,0x0
 3b9:	66 89 08             	mov    WORD PTR [rax],cx
				vmem += ofs;
 3bc:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
 3c0:	48 01 45 e8          	add    QWORD PTR [rbp-0x18],rax
		printf("reg1: %08x\n", ioapic_read(id, 0));
 3c4:	0f b6 45 ac          	movzx  eax,BYTE PTR [rbp-0x54]
 3c8:	be 00 00 00 00       	mov    esi,0x0
 3cd:	89 c7                	mov    edi,eax
 3cf:	e8 00 00 00 00       	call   3d4 <init_ioapic+0x1ec>
 3d4:	89 c6                	mov    esi,eax
 3d6:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 3dd:	b8 00 00 00 00       	mov    eax,0x0
 3e2:	e8 00 00 00 00       	call   3e7 <init_ioapic+0x1ff>
		printf("reg2: %08x\n", ioapic_read(id, 1));
 3e7:	0f b6 45 ac          	movzx  eax,BYTE PTR [rbp-0x54]
 3eb:	be 01 00 00 00       	mov    esi,0x1
 3f0:	89 c7                	mov    edi,eax
 3f2:	e8 00 00 00 00       	call   3f7 <init_ioapic+0x20f>
 3f7:	89 c6                	mov    esi,eax
 3f9:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 400:	b8 00 00 00 00       	mov    eax,0x0
 405:	e8 00 00 00 00       	call   40a <init_ioapic+0x222>
		printf("reg3: %08x\n", ioapic_read(id, 2));
 40a:	0f b6 45 ac          	movzx  eax,BYTE PTR [rbp-0x54]
 40e:	be 02 00 00 00       	mov    esi,0x2
 413:	89 c7                	mov    edi,eax
 415:	e8 00 00 00 00       	call   41a <init_ioapic+0x232>
 41a:	89 c6                	mov    esi,eax
 41c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 423:	b8 00 00 00 00       	mov    eax,0x0
 428:	e8 00 00 00 00       	call   42d <init_ioapic+0x245>
		ioapic_mappings[id].max_pin = (ioapic_read(id, 1) >> 16) & 0xff;
 42d:	0f b6 45 ac          	movzx  eax,BYTE PTR [rbp-0x54]
 431:	be 01 00 00 00       	mov    esi,0x1
 436:	89 c7                	mov    edi,eax
 438:	e8 00 00 00 00       	call   43d <init_ioapic+0x255>
 43d:	c1 e8 10             	shr    eax,0x10
 440:	89 c2                	mov    edx,eax
 442:	0f b6 45 ac          	movzx  eax,BYTE PTR [rbp-0x54]
 446:	89 d1                	mov    ecx,edx
 448:	48 63 d0             	movsxd rdx,eax
 44b:	48 89 d0             	mov    rax,rdx
 44e:	48 01 c0             	add    rax,rax
 451:	48 01 d0             	add    rax,rdx
 454:	48 c1 e0 03          	shl    rax,0x3
 458:	48 05 00 00 00 00    	add    rax,0x0
 45e:	88 08                	mov    BYTE PTR [rax],cl
		ioapic_mappings[id].real_id = (ioapic_read(id, 0) >> 24) & 0x0f;
 460:	0f b6 45 ac          	movzx  eax,BYTE PTR [rbp-0x54]
 464:	be 00 00 00 00       	mov    esi,0x0
 469:	89 c7                	mov    edi,eax
 46b:	e8 00 00 00 00       	call   470 <init_ioapic+0x288>
 470:	c1 e8 18             	shr    eax,0x18
 473:	89 c2                	mov    edx,eax
 475:	0f b6 45 ac          	movzx  eax,BYTE PTR [rbp-0x54]
 479:	89 d1                	mov    ecx,edx
 47b:	83 e1 0f             	and    ecx,0xf
 47e:	48 63 d0             	movsxd rdx,eax
 481:	48 89 d0             	mov    rax,rdx
 484:	48 01 c0             	add    rax,rax
 487:	48 01 d0             	add    rax,rdx
 48a:	48 c1 e0 03          	shl    rax,0x3
 48e:	48 05 00 00 00 00    	add    rax,0x0
 494:	88 08                	mov    BYTE PTR [rax],cl
		for (int i = 16; i < ioapic_mappings[id].max_pin + 1; i++) {
 496:	c7 45 dc 10 00 00 00 	mov    DWORD PTR [rbp-0x24],0x10
 49d:	e9 88 00 00 00       	jmp    52a <init_ioapic+0x342>
				die("I/O APIC ID larger than 15 found!\n");
 4a2:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
 4a9:	bf 0c 00 00 00       	mov    edi,0xc
 4ae:	b8 00 00 00 00       	mov    eax,0x0
 4b3:	e8 00 00 00 00       	call   4b8 <init_ioapic+0x2d0>
 4b8:	b8 00 00 00 00       	mov    eax,0x0
 4bd:	e8 00 00 00 00       	call   4c2 <init_ioapic+0x2da>
 4c2:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 4c9:	e8 00 00 00 00       	call   4ce <init_ioapic+0x2e6>
 4ce:	fa                   	cli
 4cf:	f4                   	hlt
 4d0:	eb fd                	jmp    4cf <init_ioapic+0x2e7>
				ioapic_write(id, 0x11 + i * 2, 0x00000000);
 4d2:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
 4d5:	01 c0                	add    eax,eax
 4d7:	83 c0 11             	add    eax,0x11
 4da:	0f b6 c8             	movzx  ecx,al
 4dd:	0f b6 45 ac          	movzx  eax,BYTE PTR [rbp-0x54]
 4e1:	ba 00 00 00 00       	mov    edx,0x0
 4e6:	89 ce                	mov    esi,ecx
 4e8:	89 c7                	mov    edi,eax
 4ea:	e8 00 00 00 00       	call   4ef <init_ioapic+0x307>
						| (40 + (i - 16) % 8)); /* 40-47 (round-robin if more) */
 4ef:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
 4f2:	8d 50 f0             	lea    edx,[rax-0x10]
 4f5:	89 d0                	mov    eax,edx
 4f7:	c1 f8 1f             	sar    eax,0x1f
 4fa:	c1 e8 1d             	shr    eax,0x1d
 4fd:	01 c2                	add    edx,eax
 4ff:	83 e2 07             	and    edx,0x7
 502:	29 c2                	sub    edx,eax
 504:	89 d0                	mov    eax,edx
 506:	83 c0 28             	add    eax,0x28
 509:	80 cc a0             	or     ah,0xa0
				ioapic_write(id, 0x10 + i * 2, 0x0000a000 /* a=lvl low; 0=phys,fixed */
 50c:	89 c2                	mov    edx,eax
 50e:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
 511:	83 c0 08             	add    eax,0x8
 514:	01 c0                	add    eax,eax
 516:	0f b6 c8             	movzx  ecx,al
 519:	0f b6 45 ac          	movzx  eax,BYTE PTR [rbp-0x54]
 51d:	89 ce                	mov    esi,ecx
 51f:	89 c7                	mov    edi,eax
 521:	e8 00 00 00 00       	call   526 <init_ioapic+0x33e>
		for (int i = 16; i < ioapic_mappings[id].max_pin + 1; i++) {
 526:	83 45 dc 01          	add    DWORD PTR [rbp-0x24],0x1
 52a:	0f b6 45 ac          	movzx  eax,BYTE PTR [rbp-0x54]
 52e:	48 63 d0             	movsxd rdx,eax
 531:	48 89 d0             	mov    rax,rdx
 534:	48 01 c0             	add    rax,rax
 537:	48 01 d0             	add    rax,rdx
 53a:	48 c1 e0 03          	shl    rax,0x3
 53e:	48 05 00 00 00 00    	add    rax,0x0
 544:	0f b6 00             	movzx  eax,BYTE PTR [rax]
 547:	0f b6 c0             	movzx  eax,al
 54a:	39 45 dc             	cmp    DWORD PTR [rbp-0x24],eax
 54d:	7e 83                	jle    4d2 <init_ioapic+0x2ea>
				ioapic_mappings[id].max_pin + 1);
 54f:	0f b6 45 ac          	movzx  eax,BYTE PTR [rbp-0x54]
 553:	48 63 d0             	movsxd rdx,eax
 556:	48 89 d0             	mov    rax,rdx
 559:	48 01 c0             	add    rax,rax
 55c:	48 01 d0             	add    rax,rdx
 55f:	48 c1 e0 03          	shl    rax,0x3
 563:	48 05 00 00 00 00    	add    rax,0x0
 569:	0f b6 00             	movzx  eax,BYTE PTR [rax]
 56c:	0f b6 c0             	movzx  eax,al
		printf("I/O APIC with ID %x (%d pins):\n", ioapic_mappings[id].real_id,
 56f:	8d 48 01             	lea    ecx,[rax+0x1]
 572:	0f b6 45 ac          	movzx  eax,BYTE PTR [rbp-0x54]
 576:	48 63 d0             	movsxd rdx,eax
 579:	48 89 d0             	mov    rax,rdx
 57c:	48 01 c0             	add    rax,rax
 57f:	48 01 d0             	add    rax,rdx
 582:	48 c1 e0 03          	shl    rax,0x3
 586:	48 05 00 00 00 00    	add    rax,0x0
 58c:	0f b6 00             	movzx  eax,BYTE PTR [rax]
 58f:	0f b6 c0             	movzx  eax,al
 592:	89 ca                	mov    edx,ecx
 594:	89 c6                	mov    esi,eax
 596:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 59d:	b8 00 00 00 00       	mov    eax,0x0
 5a2:	e8 00 00 00 00       	call   5a7 <init_ioapic+0x3bf>
		for (int i = 0; i < ioapic_mappings[id].max_pin + 1; i++) {
 5a7:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [rbp-0x28],0x0
 5ae:	eb 5d                	jmp    60d <init_ioapic+0x425>
				uint64_t dat = ioapic_read(id, 0x10 + i * 2) | ((uint64_t)
 5b0:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
 5b3:	83 c0 08             	add    eax,0x8
 5b6:	01 c0                	add    eax,eax
 5b8:	0f b6 d0             	movzx  edx,al
 5bb:	0f b6 45 ac          	movzx  eax,BYTE PTR [rbp-0x54]
 5bf:	89 d6                	mov    esi,edx
 5c1:	89 c7                	mov    edi,eax
 5c3:	e8 00 00 00 00       	call   5c8 <init_ioapic+0x3e0>
 5c8:	89 c3                	mov    ebx,eax
						ioapic_read(id, 0x11 + i * 2) << 32);
 5ca:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
 5cd:	01 c0                	add    eax,eax
 5cf:	83 c0 11             	add    eax,0x11
 5d2:	0f b6 d0             	movzx  edx,al
 5d5:	0f b6 45 ac          	movzx  eax,BYTE PTR [rbp-0x54]
 5d9:	89 d6                	mov    esi,edx
 5db:	89 c7                	mov    edi,eax
 5dd:	e8 00 00 00 00       	call   5e2 <init_ioapic+0x3fa>
				uint64_t dat = ioapic_read(id, 0x10 + i * 2) | ((uint64_t)
 5e2:	89 c0                	mov    eax,eax
						ioapic_read(id, 0x11 + i * 2) << 32);
 5e4:	48 c1 e0 20          	shl    rax,0x20
				uint64_t dat = ioapic_read(id, 0x10 + i * 2) | ((uint64_t)
 5e8:	48 09 d8             	or     rax,rbx
 5eb:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
				printf("REDTBL%-3d %016llx\n", i, dat);
 5ef:	48 8b 55 c0          	mov    rdx,QWORD PTR [rbp-0x40]
 5f3:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
 5f6:	89 c6                	mov    esi,eax
 5f8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 5ff:	b8 00 00 00 00       	mov    eax,0x0
 604:	e8 00 00 00 00       	call   609 <init_ioapic+0x421>
		for (int i = 0; i < ioapic_mappings[id].max_pin + 1; i++) {
 609:	83 45 d8 01          	add    DWORD PTR [rbp-0x28],0x1
 60d:	0f b6 45 ac          	movzx  eax,BYTE PTR [rbp-0x54]
 611:	48 63 d0             	movsxd rdx,eax
 614:	48 89 d0             	mov    rax,rdx
 617:	48 01 c0             	add    rax,rax
 61a:	48 01 d0             	add    rax,rdx
 61d:	48 c1 e0 03          	shl    rax,0x3
 621:	48 05 00 00 00 00    	add    rax,0x0
 627:	0f b6 00             	movzx  eax,BYTE PTR [rax]
 62a:	0f b6 c0             	movzx  eax,al
 62d:	39 45 d8             	cmp    DWORD PTR [rbp-0x28],eax
 630:	0f 8e 7a ff ff ff    	jle    5b0 <init_ioapic+0x3c8>
		printf("\n");
 636:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 63d:	b8 00 00 00 00       	mov    eax,0x0
 642:	e8 00 00 00 00       	call   647 <init_ioapic+0x45f>
}
 647:	90                   	nop
 648:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
 64c:	c9                   	leave
 64d:	c3                   	ret

000000000000064e <ioapic_print_is>:
{
 64e:	55                   	push   rbp
 64f:	48 89 e5             	mov    rbp,rsp
 652:	48 83 ec 10          	sub    rsp,0x10
		for (int i = 0; i < 16; i++) {
 656:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
 65d:	e9 b7 00 00 00       	jmp    719 <ioapic_print_is+0xcb>
				uint32_t pin = 0;
 662:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0
				if (!ioapic_mappings[i].ptr_base)
 669:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
 66c:	48 63 d0             	movsxd rdx,eax
 66f:	48 89 d0             	mov    rax,rdx
 672:	48 01 c0             	add    rax,rax
 675:	48 01 d0             	add    rax,rdx
 678:	48 c1 e0 03          	shl    rax,0x3
 67c:	48 05 00 00 00 00    	add    rax,0x0
 682:	48 8b 00             	mov    rax,QWORD PTR [rax]
 685:	48 85 c0             	test   rax,rax
 688:	0f 84 86 00 00 00    	je     714 <ioapic_print_is+0xc6>
				for (int j = 0; j < ioapic_mappings[i].max_pin + 1; j++) {
 68e:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
 695:	eb 3e                	jmp    6d5 <ioapic_print_is+0x87>
						st = ioapic_read(i, 0x10 + 2 * j);
 697:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
 69a:	83 c0 08             	add    eax,0x8
 69d:	01 c0                	add    eax,eax
 69f:	0f b6 d0             	movzx  edx,al
 6a2:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
 6a5:	0f b6 c0             	movzx  eax,al
 6a8:	89 d6                	mov    esi,edx
 6aa:	89 c7                	mov    edi,eax
 6ac:	e8 00 00 00 00       	call   6b1 <ioapic_print_is+0x63>
 6b1:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
						if (st & (1 << 12)) /* DS=pending */
 6b4:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
 6b7:	25 00 10 00 00       	and    eax,0x1000
 6bc:	85 c0                	test   eax,eax
 6be:	74 11                	je     6d1 <ioapic_print_is+0x83>
								pin |= (1 << j);
 6c0:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
 6c3:	ba 01 00 00 00       	mov    edx,0x1
 6c8:	89 c1                	mov    ecx,eax
 6ca:	d3 e2                	shl    edx,cl
 6cc:	89 d0                	mov    eax,edx
 6ce:	09 45 f8             	or     DWORD PTR [rbp-0x8],eax
				for (int j = 0; j < ioapic_mappings[i].max_pin + 1; j++) {
 6d1:	83 45 f4 01          	add    DWORD PTR [rbp-0xc],0x1
 6d5:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
 6d8:	48 63 d0             	movsxd rdx,eax
 6db:	48 89 d0             	mov    rax,rdx
 6de:	48 01 c0             	add    rax,rax
 6e1:	48 01 d0             	add    rax,rdx
 6e4:	48 c1 e0 03          	shl    rax,0x3
 6e8:	48 05 00 00 00 00    	add    rax,0x0
 6ee:	0f b6 00             	movzx  eax,BYTE PTR [rax]
 6f1:	0f b6 c0             	movzx  eax,al
 6f4:	39 45 f4             	cmp    DWORD PTR [rbp-0xc],eax
 6f7:	7e 9e                	jle    697 <ioapic_print_is+0x49>
				printf("IOAPIC%u: %08x\n", i, pin);
 6f9:	8b 55 f8             	mov    edx,DWORD PTR [rbp-0x8]
 6fc:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
 6ff:	89 c6                	mov    esi,eax
 701:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 708:	b8 00 00 00 00       	mov    eax,0x0
 70d:	e8 00 00 00 00       	call   712 <ioapic_print_is+0xc4>
 712:	eb 01                	jmp    715 <ioapic_print_is+0xc7>
						continue;
 714:	90                   	nop
		for (int i = 0; i < 16; i++) {
 715:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
 719:	83 7d fc 0f          	cmp    DWORD PTR [rbp-0x4],0xf
 71d:	0f 8e 3f ff ff ff    	jle    662 <ioapic_print_is+0x14>
}
 723:	90                   	nop
 724:	90                   	nop
 725:	c9                   	leave
 726:	c3                   	ret

0000000000000727 <ap_apic_init>:
/**********  Local APIC configuration including IPIs  ********************/
void ap_apic_init()
{
 727:	55                   	push   rbp
 728:	48 89 e5             	mov    rbp,rsp
 72b:	41 54                	push   r12
 72d:	53                   	push   rbx
 72e:	48 83 ec 20          	sub    rsp,0x20
		/* TODO use regular init as APIC MMIO memory is global */
		/* we're using iprintf to avoid needless waiting */
		struct page_range pr = {0,1};
 732:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
 73a:	48 c7 45 e8 01 00 00 00 	mov    QWORD PTR [rbp-0x18],0x1
		uint32_t eax, edx;
		cpu_get_msr(APIC_BASE_MSR, &eax, &edx);
 742:	48 8d 55 d8          	lea    rdx,[rbp-0x28]
 746:	48 8d 45 dc          	lea    rax,[rbp-0x24]
 74a:	48 89 c6             	mov    rsi,rax
 74d:	bf 1b 00 00 00       	mov    edi,0x1b
 752:	e8 00 00 00 00       	call   757 <ap_apic_init+0x30>
		pr.base = ((uint64_t)(edx & 0x0f)) << 32 | (eax & 0xfffff000);
 757:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
 75a:	89 c0                	mov    eax,eax
 75c:	48 c1 e0 20          	shl    rax,0x20
 760:	48 89 c2             	mov    rdx,rax
 763:	48 b8 00 00 00 00 0f 00 00 00 	movabs rax,0xf00000000
 76d:	48 21 c2             	and    rdx,rax
 770:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
 773:	89 c0                	mov    eax,eax
 775:	25 00 f0 ff ff       	and    eax,0xfffff000
 77a:	48 09 d0             	or     rax,rdx
 77d:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
		iprintf("msr: %08x%08x\n", edx, eax);
 781:	8b 55 dc             	mov    edx,DWORD PTR [rbp-0x24]
 784:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
 787:	89 c6                	mov    esi,eax
 789:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 790:	b8 00 00 00 00       	mov    eax,0x0
 795:	e8 00 00 00 00       	call   79a <ap_apic_init+0x73>
		/* ensure PM location */
		if (!pr.base)
 79a:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 79e:	48 85 c0             	test   rax,rax
 7a1:	75 30                	jne    7d3 <ap_apic_init+0xac>
				die("APIC has no PM location assigned. TODO: write PM MMIO address allocator.\n");
 7a3:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
 7aa:	bf 0c 00 00 00       	mov    edi,0xc
 7af:	b8 00 00 00 00       	mov    eax,0x0
 7b4:	e8 00 00 00 00       	call   7b9 <ap_apic_init+0x92>
 7b9:	b8 00 00 00 00       	mov    eax,0x0
 7be:	e8 00 00 00 00       	call   7c3 <ap_apic_init+0x9c>
 7c3:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 7ca:	e8 00 00 00 00       	call   7cf <ap_apic_init+0xa8>
 7cf:	fa                   	cli
 7d0:	f4                   	hlt
 7d1:	eb fd                	jmp    7d0 <ap_apic_init+0xa9>
		iprintf("AP APIC base: %016llx\n", pr.base);
 7d3:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 7d7:	48 89 c6             	mov    rsi,rax
 7da:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 7e1:	b8 00 00 00 00       	mov    eax,0x0
 7e6:	e8 00 00 00 00       	call   7eb <ap_apic_init+0xc4>
		if (!(eax & APIC_BASE_MSR_ENABLE)) {
 7eb:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
 7ee:	25 00 08 00 00       	and    eax,0x800
 7f3:	85 c0                	test   eax,eax
 7f5:	75 25                	jne    81c <ap_apic_init+0xf5>
				cpu_set_msr(APIC_BASE_MSR, (pr.base & 0xfffff000) |
					APIC_BASE_MSR_ENABLE, (pr.base >> 32) & 0x0f);
 7f7:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 7fb:	48 c1 e8 20          	shr    rax,0x20
				cpu_set_msr(APIC_BASE_MSR, (pr.base & 0xfffff000) |
 7ff:	83 e0 0f             	and    eax,0xf
 802:	89 c2                	mov    edx,eax
 804:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 808:	25 00 f0 ff ff       	and    eax,0xfffff000
 80d:	80 cc 08             	or     ah,0x8
 810:	89 c6                	mov    esi,eax
 812:	bf 1b 00 00 00       	mov    edi,0x1b
 817:	e8 00 00 00 00       	call   81c <ap_apic_init+0xf5>
		}
		/* keep track of the memory & map it */
		per_cpu_ptr()->apic_phys = pr.base;
 81c:	b8 00 00 00 00       	mov    eax,0x0
 821:	e8 da f7 ff ff       	call   0 <per_cpu_ptr>
 826:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
 82a:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
		per_cpu_ptr()->apic_addr = mm_map(&mm_kernel, per_cpu_ptr()->apic_addr,
 82e:	b8 00 00 00 00       	mov    eax,0x0
 833:	e8 c8 f7 ff ff       	call   0 <per_cpu_ptr>
 838:	4c 8b 60 08          	mov    r12,QWORD PTR [rax+0x8]
 83c:	b8 00 00 00 00       	mov    eax,0x0
 841:	e8 ba f7 ff ff       	call   0 <per_cpu_ptr>
 846:	48 89 c3             	mov    rbx,rax
 849:	48 8d 45 e0          	lea    rax,[rbp-0x20]
 84d:	41 b8 2d 00 00 00    	mov    r8d,0x2d
 853:	b9 01 00 00 00       	mov    ecx,0x1
 858:	48 89 c2             	mov    rdx,rax
 85b:	4c 89 e6             	mov    rsi,r12
 85e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 865:	e8 00 00 00 00       	call   86a <ap_apic_init+0x143>
 86a:	48 89 43 08          	mov    QWORD PTR [rbx+0x8],rax
				&pr, 1, MMGR_MAP_MMIO | MMGR_MAP_WRITE
				| MMGR_MAP_NO_CACHING | MMGR_MAP_KERNEL);
		/* set logical dest and mode */
		apic_set_dfr(0xf); /* flat mode */
 86e:	bf 0f 00 00 00       	mov    edi,0xf
 873:	e8 00 00 00 00       	call   878 <ap_apic_init+0x151>
		apic_set_ldr(apic_cur_log);
 878:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 87f <ap_apic_init+0x158>
 87f:	0f b6 c0             	movzx  eax,al
 882:	89 c7                	mov    edi,eax
 884:	e8 00 00 00 00       	call   889 <ap_apic_init+0x162>
		apic_set_tpr(0); /* receive any intr */
 889:	bf 00 00 00 00       	mov    edi,0x0
 88e:	e8 00 00 00 00       	call   893 <ap_apic_init+0x16c>
		if (!(apic_cur_log <<= 1)) /* x86 rol */
 893:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 89a <ap_apic_init+0x173>
 89a:	01 c0                	add    eax,eax
 89c:	88 05 00 00 00 00    	mov    BYTE PTR [rip+0x0],al        # 8a2 <ap_apic_init+0x17b>
 8a2:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 8a9 <ap_apic_init+0x182>
 8a9:	84 c0                	test   al,al
 8ab:	75 07                	jne    8b4 <ap_apic_init+0x18d>
				apic_cur_log = 1;
 8ad:	c6 05 00 00 00 00 01 	mov    BYTE PTR [rip+0x0],0x1        # 8b4 <ap_apic_init+0x18d>
		/* TODO: possibly cause TLB shootdown */
		/* now APIC_BASE points to the xAPIC memory */
		iprintf("The registers are configured as follows:\n");
 8b4:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 8bb:	b8 00 00 00 00       	mov    eax,0x0
 8c0:	e8 00 00 00 00       	call   8c5 <ap_apic_init+0x19e>
		iprintf("spurious:  %08x\n", apic_reg(APIC_REG_SPURIOUS));
 8c5:	b8 00 00 00 00       	mov    eax,0x0
 8ca:	e8 31 f7 ff ff       	call   0 <per_cpu_ptr>
 8cf:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 8d3:	48 05 f0 00 00 00    	add    rax,0xf0
 8d9:	8b 00                	mov    eax,DWORD PTR [rax]
 8db:	89 c6                	mov    esi,eax
 8dd:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 8e4:	b8 00 00 00 00       	mov    eax,0x0
 8e9:	e8 00 00 00 00       	call   8ee <ap_apic_init+0x1c7>
		iprintf("error:     %08x\n", apic_reg(APIC_REG_ESR));
 8ee:	b8 00 00 00 00       	mov    eax,0x0
 8f3:	e8 08 f7 ff ff       	call   0 <per_cpu_ptr>
 8f8:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 8fc:	48 05 80 02 00 00    	add    rax,0x280
 902:	8b 00                	mov    eax,DWORD PTR [rax]
 904:	89 c6                	mov    esi,eax
 906:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 90d:	b8 00 00 00 00       	mov    eax,0x0
 912:	e8 00 00 00 00       	call   917 <ap_apic_init+0x1f0>
		iprintf("LVT timer: %08x\n", apic_reg(APIC_REG_LVT_TMR));
 917:	b8 00 00 00 00       	mov    eax,0x0
 91c:	e8 df f6 ff ff       	call   0 <per_cpu_ptr>
 921:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 925:	48 05 20 03 00 00    	add    rax,0x320
 92b:	8b 00                	mov    eax,DWORD PTR [rax]
 92d:	89 c6                	mov    esi,eax
 92f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 936:	b8 00 00 00 00       	mov    eax,0x0
 93b:	e8 00 00 00 00       	call   940 <ap_apic_init+0x219>
		iprintf("LVT therm: %08x\n", apic_reg(APIC_REG_LVT_THERM));
 940:	b8 00 00 00 00       	mov    eax,0x0
 945:	e8 b6 f6 ff ff       	call   0 <per_cpu_ptr>
 94a:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 94e:	48 05 30 03 00 00    	add    rax,0x330
 954:	8b 00                	mov    eax,DWORD PTR [rax]
 956:	89 c6                	mov    esi,eax
 958:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 95f:	b8 00 00 00 00       	mov    eax,0x0
 964:	e8 00 00 00 00       	call   969 <ap_apic_init+0x242>
		iprintf("LVT perf:  %08x\n", apic_reg(APIC_REG_LVT_PERF));
 969:	b8 00 00 00 00       	mov    eax,0x0
 96e:	e8 8d f6 ff ff       	call   0 <per_cpu_ptr>
 973:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 977:	48 05 40 03 00 00    	add    rax,0x340
 97d:	8b 00                	mov    eax,DWORD PTR [rax]
 97f:	89 c6                	mov    esi,eax
 981:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 988:	b8 00 00 00 00       	mov    eax,0x0
 98d:	e8 00 00 00 00       	call   992 <ap_apic_init+0x26b>
		iprintf("LVT LINT0: %08x\n", apic_reg(APIC_REG_LVT_LINT0));
 992:	b8 00 00 00 00       	mov    eax,0x0
 997:	e8 64 f6 ff ff       	call   0 <per_cpu_ptr>
 99c:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 9a0:	48 05 50 03 00 00    	add    rax,0x350
 9a6:	8b 00                	mov    eax,DWORD PTR [rax]
 9a8:	89 c6                	mov    esi,eax
 9aa:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 9b1:	b8 00 00 00 00       	mov    eax,0x0
 9b6:	e8 00 00 00 00       	call   9bb <ap_apic_init+0x294>
		iprintf("LVT LINT1: %08x\n", apic_reg(APIC_REG_LVT_LINT1));
 9bb:	b8 00 00 00 00       	mov    eax,0x0
 9c0:	e8 3b f6 ff ff       	call   0 <per_cpu_ptr>
 9c5:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 9c9:	48 05 60 03 00 00    	add    rax,0x360
 9cf:	8b 00                	mov    eax,DWORD PTR [rax]
 9d1:	89 c6                	mov    esi,eax
 9d3:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 9da:	b8 00 00 00 00       	mov    eax,0x0
 9df:	e8 00 00 00 00       	call   9e4 <ap_apic_init+0x2bd>
		iprintf("LVT error: %08x\n", apic_reg(APIC_REG_LVT_ERR));
 9e4:	b8 00 00 00 00       	mov    eax,0x0
 9e9:	e8 12 f6 ff ff       	call   0 <per_cpu_ptr>
 9ee:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 9f2:	48 05 70 03 00 00    	add    rax,0x370
 9f8:	8b 00                	mov    eax,DWORD PTR [rax]
 9fa:	89 c6                	mov    esi,eax
 9fc:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 a03:	b8 00 00 00 00       	mov    eax,0x0
 a08:	e8 00 00 00 00       	call   a0d <ap_apic_init+0x2e6>
		apic_reg(APIC_REG_SPURIOUS) = 0x00000100 | 0x3f;
 a0d:	b8 00 00 00 00       	mov    eax,0x0
 a12:	e8 e9 f5 ff ff       	call   0 <per_cpu_ptr>
 a17:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 a1b:	48 05 f0 00 00 00    	add    rax,0xf0
 a21:	c7 00 3f 01 00 00    	mov    DWORD PTR [rax],0x13f
		iprintf("spurious:  %08x\n", apic_reg(APIC_REG_SPURIOUS));
 a27:	b8 00 00 00 00       	mov    eax,0x0
 a2c:	e8 cf f5 ff ff       	call   0 <per_cpu_ptr>
 a31:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 a35:	48 05 f0 00 00 00    	add    rax,0xf0
 a3b:	8b 00                	mov    eax,DWORD PTR [rax]
 a3d:	89 c6                	mov    esi,eax
 a3f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 a46:	b8 00 00 00 00       	mov    eax,0x0
 a4b:	e8 00 00 00 00       	call   a50 <ap_apic_init+0x329>
		apic_reg(APIC_REG_LVT_ERR) = 0x3c; /* 0 | 3c */
 a50:	b8 00 00 00 00       	mov    eax,0x0
 a55:	e8 a6 f5 ff ff       	call   0 <per_cpu_ptr>
 a5a:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 a5e:	48 05 70 03 00 00    	add    rax,0x370
 a64:	c7 00 3c 00 00 00    	mov    DWORD PTR [rax],0x3c
		/* (val << 16): R00M=one-shot, R01M per, R11M tsc, R=res, M=mask */
		apic_reg(APIC_REG_LVT_TMR) = 0x00000000 | 0x3d; /* one-shot */
 a6a:	b8 00 00 00 00       	mov    eax,0x0
 a6f:	e8 8c f5 ff ff       	call   0 <per_cpu_ptr>
 a74:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 a78:	48 05 20 03 00 00    	add    rax,0x320
 a7e:	c7 00 3d 00 00 00    	mov    DWORD PTR [rax],0x3d
		/* mask the LINTS */
		apic_reg(APIC_REG_LVT_LINT0) = 0x00010700; /* masked extInt */
 a84:	b8 00 00 00 00       	mov    eax,0x0
 a89:	e8 72 f5 ff ff       	call   0 <per_cpu_ptr>
 a8e:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 a92:	48 05 50 03 00 00    	add    rax,0x350
 a98:	c7 00 00 07 01 00    	mov    DWORD PTR [rax],0x10700
		apic_reg(APIC_REG_LVT_LINT1) = 0x00010400; /* masked NMI */
 a9e:	b8 00 00 00 00       	mov    eax,0x0
 aa3:	e8 58 f5 ff ff       	call   0 <per_cpu_ptr>
 aa8:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 aac:	48 05 60 03 00 00    	add    rax,0x360
 ab2:	c7 00 00 04 01 00    	mov    DWORD PTR [rax],0x10400
		/* arm the error register */
		apic_reg(APIC_REG_ESR) = 0;
 ab8:	b8 00 00 00 00       	mov    eax,0x0
 abd:	e8 3e f5 ff ff       	call   0 <per_cpu_ptr>
 ac2:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 ac6:	48 05 80 02 00 00    	add    rax,0x280
 acc:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0
		apic_reg(APIC_REG_TMRDIV) = 0x0b; /* div=1 ; 111 */
 ad2:	b8 00 00 00 00       	mov    eax,0x0
 ad7:	e8 24 f5 ff ff       	call   0 <per_cpu_ptr>
 adc:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 ae0:	48 05 e0 03 00 00    	add    rax,0x3e0
 ae6:	c7 00 0b 00 00 00    	mov    DWORD PTR [rax],0xb
		apic_reg(APIC_REG_TMRINITCNT) = 0x0fffffff; /* 1.5s at 3GHz */
 aec:	b8 00 00 00 00       	mov    eax,0x0
 af1:	e8 0a f5 ff ff       	call   0 <per_cpu_ptr>
 af6:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 afa:	48 05 80 03 00 00    	add    rax,0x380
 b00:	c7 00 ff ff ff 0f    	mov    DWORD PTR [rax],0xfffffff
}
 b06:	90                   	nop
 b07:	48 83 c4 20          	add    rsp,0x20
 b0b:	5b                   	pop    rbx
 b0c:	41 5c                	pop    r12
 b0e:	5d                   	pop    rbp
 b0f:	c3                   	ret

0000000000000b10 <apic_init>:

void apic_init()
{
 b10:	55                   	push   rbp
 b11:	48 89 e5             	mov    rbp,rsp
 b14:	48 83 ec 20          	sub    rsp,0x20
		struct page_range pr = {0,1};
 b18:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
 b20:	48 c7 45 f8 01 00 00 00 	mov    QWORD PTR [rbp-0x8],0x1
		uint32_t eax, edx;
		if (cpu.has_x2APIC)
 b28:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # b2f <apic_init+0x1f>
 b2f:	83 e0 20             	and    eax,0x20
 b32:	84 c0                	test   al,al
 b34:	74 16                	je     b4c <apic_init+0x3c>
				cprintf(KFMT_INFO, "This CPU supports the x2APIC mode, but for "
 b36:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
 b3d:	bf 0b 00 00 00       	mov    edi,0xb
 b42:	b8 00 00 00 00       	mov    eax,0x0
 b47:	e8 00 00 00 00       	call   b4c <apic_init+0x3c>
						"simplicity it is run in xAPIC mode.\n");
		/* find and map the APIC registers */
		cpu_get_msr(APIC_BASE_MSR, &eax, &edx);
 b4c:	48 8d 55 e8          	lea    rdx,[rbp-0x18]
 b50:	48 8d 45 ec          	lea    rax,[rbp-0x14]
 b54:	48 89 c6             	mov    rsi,rax
 b57:	bf 1b 00 00 00       	mov    edi,0x1b
 b5c:	e8 00 00 00 00       	call   b61 <apic_init+0x51>
		pr.base = ((uint64_t)(edx & 0x0f)) << 32 | (eax & 0xfffff000);
 b61:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
 b64:	89 c0                	mov    eax,eax
 b66:	48 c1 e0 20          	shl    rax,0x20
 b6a:	48 89 c2             	mov    rdx,rax
 b6d:	48 b8 00 00 00 00 0f 00 00 00 	movabs rax,0xf00000000
 b77:	48 21 c2             	and    rdx,rax
 b7a:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
 b7d:	89 c0                	mov    eax,eax
 b7f:	25 00 f0 ff ff       	and    eax,0xfffff000
 b84:	48 09 d0             	or     rax,rdx
 b87:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		if (!pr.base) {
 b8b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 b8f:	48 85 c0             	test   rax,rax
 b92:	75 0d                	jne    ba1 <apic_init+0x91>
				// TODO: mmgr_get_mmio_pmem();
				pr.base = apic_pm_base;
 b94:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # b9b <apic_init+0x8b>
 b9b:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
 b9f:	eb 0b                	jmp    bac <apic_init+0x9c>
		} else
				apic_pm_base = pr.base;
 ba1:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 ba5:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # bac <apic_init+0x9c>
		if (!(eax & APIC_BASE_MSR_ENABLE)) {
 bac:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
 baf:	25 00 08 00 00       	and    eax,0x800
 bb4:	85 c0                	test   eax,eax
 bb6:	75 25                	jne    bdd <apic_init+0xcd>
				cpu_set_msr(APIC_BASE_MSR, (pr.base & 0xfffff000) |
					APIC_BASE_MSR_ENABLE, (pr.base >> 32) & 0x0f);
 bb8:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 bbc:	48 c1 e8 20          	shr    rax,0x20
				cpu_set_msr(APIC_BASE_MSR, (pr.base & 0xfffff000) |
 bc0:	83 e0 0f             	and    eax,0xf
 bc3:	89 c2                	mov    edx,eax
 bc5:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 bc9:	25 00 f0 ff ff       	and    eax,0xfffff000
 bce:	80 cc 08             	or     ah,0x8
 bd1:	89 c6                	mov    esi,eax
 bd3:	bf 1b 00 00 00       	mov    edi,0x1b
 bd8:	e8 00 00 00 00       	call   bdd <apic_init+0xcd>
		}
		mm_map(&mm_kernel, bp_apic_base, &pr, 1, MMGR_MAP_MMIO | MMGR_MAP_WRITE
 bdd:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # be4 <apic_init+0xd4>
 be4:	48 8d 55 f0          	lea    rdx,[rbp-0x10]
 be8:	41 b8 2d 00 00 00    	mov    r8d,0x2d
 bee:	b9 01 00 00 00       	mov    ecx,0x1
 bf3:	48 89 c6             	mov    rsi,rax
 bf6:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 bfd:	e8 00 00 00 00       	call   c02 <apic_init+0xf2>
			| MMGR_MAP_NO_CACHING | MMGR_MAP_KERNEL);
		/* now access them */
		edx = apic_bp_reg(APIC_REG_APICID);
 c02:	b8 20 00 ff ef       	mov    eax,0xefff0020
 c07:	8b 00                	mov    eax,DWORD PTR [rax]
 c09:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
		printf("The APIC of the %s with ID %x is located at 0x%016llx\n",
 c0c:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 c10:	8b 55 e8             	mov    edx,DWORD PTR [rbp-0x18]
 c13:	c1 ea 18             	shr    edx,0x18
			(eax & APIC_BASE_MSR_BSP) ? "BSP" : "AP", edx >> 24, pr.base);
 c16:	8b 4d ec             	mov    ecx,DWORD PTR [rbp-0x14]
 c19:	81 e1 00 01 00 00    	and    ecx,0x100
		printf("The APIC of the %s with ID %x is located at 0x%016llx\n",
 c1f:	85 c9                	test   ecx,ecx
 c21:	74 09                	je     c2c <apic_init+0x11c>
 c23:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
 c2a:	eb 07                	jmp    c33 <apic_init+0x123>
 c2c:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
 c33:	48 89 c1             	mov    rcx,rax
 c36:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 c3d:	b8 00 00 00 00       	mov    eax,0x0
 c42:	e8 00 00 00 00       	call   c47 <apic_init+0x137>
		/* set the destination format and logical address */
		apic_bp_reg(APIC_REG_DFR) = 0xffffffff; /* flat */
 c47:	b8 e0 00 ff ef       	mov    eax,0xefff00e0
 c4c:	c7 00 ff ff ff ff    	mov    DWORD PTR [rax],0xffffffff
		apic_bp_reg(APIC_REG_LDR) = 0x01000000; /* we'll do round-robin like */
 c52:	b8 d0 00 ff ef       	mov    eax,0xefff00d0
 c57:	c7 00 00 00 00 01    	mov    DWORD PTR [rax],0x1000000
		apic_bp_reg(APIC_REG_TASKPRIOR) = 0x00000000; /* receive any */
 c5d:	b8 80 00 ff ef       	mov    eax,0xefff0080
 c62:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0
		/* post version info */
		eax = apic_bp_reg(APIC_REG_APICVER);
 c68:	b8 30 00 ff ef       	mov    eax,0xefff0030
 c6d:	8b 00                	mov    eax,DWORD PTR [rax]
 c6f:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
		printf("This processors APIC's version is %02xh (%s) which has "
			   "support for %u LVT entries%s.", eax & 0xff, ((eax & 0xff) < 0x10)
			   ? "external 82489DX APIC" : "integrated APIC", 1 + ((eax >> 16) & 0xff),
               (eax & 0x01000000) ? " and for EOI-broadcast suppression" : "");
 c72:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
 c75:	25 00 00 00 01       	and    eax,0x1000000
		printf("This processors APIC's version is %02xh (%s) which has "
 c7a:	85 c0                	test   eax,eax
 c7c:	74 09                	je     c87 <apic_init+0x177>
 c7e:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
 c85:	eb 07                	jmp    c8e <apic_init+0x17e>
 c87:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
			   ? "external 82489DX APIC" : "integrated APIC", 1 + ((eax >> 16) & 0xff),
 c8e:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
 c91:	c1 e8 10             	shr    eax,0x10
 c94:	0f b6 c0             	movzx  eax,al
		printf("This processors APIC's version is %02xh (%s) which has "
 c97:	8d 50 01             	lea    edx,[rax+0x1]
			   "support for %u LVT entries%s.", eax & 0xff, ((eax & 0xff) < 0x10)
 c9a:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
 c9d:	25 f0 00 00 00       	and    eax,0xf0
		printf("This processors APIC's version is %02xh (%s) which has "
 ca2:	85 c0                	test   eax,eax
 ca4:	75 09                	jne    caf <apic_init+0x19f>
 ca6:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
 cad:	eb 07                	jmp    cb6 <apic_init+0x1a6>
 caf:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
 cb6:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
 cb9:	0f b6 c0             	movzx  eax,al
 cbc:	49 89 c8             	mov    r8,rcx
 cbf:	89 d1                	mov    ecx,edx
 cc1:	48 89 f2             	mov    rdx,rsi
 cc4:	89 c6                	mov    esi,eax
 cc6:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 ccd:	b8 00 00 00 00       	mov    eax,0x0
 cd2:	e8 00 00 00 00       	call   cd7 <apic_init+0x1c7>
		/* and the initial configuration */
		printf("The registers are configured as follows:\n");
 cd7:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 cde:	b8 00 00 00 00       	mov    eax,0x0
 ce3:	e8 00 00 00 00       	call   ce8 <apic_init+0x1d8>
		printf("spurious:  %08x\n", apic_bp_reg(APIC_REG_SPURIOUS));
 ce8:	b8 f0 00 ff ef       	mov    eax,0xefff00f0
 ced:	8b 00                	mov    eax,DWORD PTR [rax]
 cef:	89 c6                	mov    esi,eax
 cf1:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 cf8:	b8 00 00 00 00       	mov    eax,0x0
 cfd:	e8 00 00 00 00       	call   d02 <apic_init+0x1f2>
		printf("error:     %08x\n", apic_bp_reg(APIC_REG_ESR));
 d02:	b8 80 02 ff ef       	mov    eax,0xefff0280
 d07:	8b 00                	mov    eax,DWORD PTR [rax]
 d09:	89 c6                	mov    esi,eax
 d0b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 d12:	b8 00 00 00 00       	mov    eax,0x0
 d17:	e8 00 00 00 00       	call   d1c <apic_init+0x20c>
		printf("LVT timer: %08x\n", apic_bp_reg(APIC_REG_LVT_TMR));
 d1c:	b8 20 03 ff ef       	mov    eax,0xefff0320
 d21:	8b 00                	mov    eax,DWORD PTR [rax]
 d23:	89 c6                	mov    esi,eax
 d25:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 d2c:	b8 00 00 00 00       	mov    eax,0x0
 d31:	e8 00 00 00 00       	call   d36 <apic_init+0x226>
		printf("LVT therm: %08x\n", apic_bp_reg(APIC_REG_LVT_THERM));
 d36:	b8 30 03 ff ef       	mov    eax,0xefff0330
 d3b:	8b 00                	mov    eax,DWORD PTR [rax]
 d3d:	89 c6                	mov    esi,eax
 d3f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 d46:	b8 00 00 00 00       	mov    eax,0x0
 d4b:	e8 00 00 00 00       	call   d50 <apic_init+0x240>
		printf("LVT perf:  %08x\n", apic_bp_reg(APIC_REG_LVT_PERF));
 d50:	b8 40 03 ff ef       	mov    eax,0xefff0340
 d55:	8b 00                	mov    eax,DWORD PTR [rax]
 d57:	89 c6                	mov    esi,eax
 d59:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 d60:	b8 00 00 00 00       	mov    eax,0x0
 d65:	e8 00 00 00 00       	call   d6a <apic_init+0x25a>
		printf("LVT LINT0: %08x\n", apic_bp_reg(APIC_REG_LVT_LINT0));
 d6a:	b8 50 03 ff ef       	mov    eax,0xefff0350
 d6f:	8b 00                	mov    eax,DWORD PTR [rax]
 d71:	89 c6                	mov    esi,eax
 d73:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 d7a:	b8 00 00 00 00       	mov    eax,0x0
 d7f:	e8 00 00 00 00       	call   d84 <apic_init+0x274>
		printf("LVT LINT1: %08x\n", apic_bp_reg(APIC_REG_LVT_LINT1));
 d84:	b8 60 03 ff ef       	mov    eax,0xefff0360
 d89:	8b 00                	mov    eax,DWORD PTR [rax]
 d8b:	89 c6                	mov    esi,eax
 d8d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 d94:	b8 00 00 00 00       	mov    eax,0x0
 d99:	e8 00 00 00 00       	call   d9e <apic_init+0x28e>
		printf("LVT error: %08x\n", apic_bp_reg(APIC_REG_LVT_ERR));
 d9e:	b8 70 03 ff ef       	mov    eax,0xefff0370
 da3:	8b 00                	mov    eax,DWORD PTR [rax]
 da5:	89 c6                	mov    esi,eax
 da7:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 dae:	b8 00 00 00 00       	mov    eax,0x0
 db3:	e8 00 00 00 00       	call   db8 <apic_init+0x2a8>
		/* now install the handlers */
		apic_bp_reg(APIC_REG_SPURIOUS) = (apic_bp_reg(APIC_REG_SPURIOUS) & 0xffffff00) + 0x3f;
 db8:	b8 f0 00 ff ef       	mov    eax,0xefff00f0
 dbd:	8b 00                	mov    eax,DWORD PTR [rax]
 dbf:	b0 00                	mov    al,0x0
 dc1:	89 c2                	mov    edx,eax
 dc3:	b8 f0 00 ff ef       	mov    eax,0xefff00f0
 dc8:	83 c2 3f             	add    edx,0x3f
 dcb:	89 10                	mov    DWORD PTR [rax],edx
		apic_bp_reg(APIC_REG_LVT_ERR) = 0x3c; /* 0 | 3c */
 dcd:	b8 70 03 ff ef       	mov    eax,0xefff0370
 dd2:	c7 00 3c 00 00 00    	mov    DWORD PTR [rax],0x3c
		/* arm the error register */
		apic_bp_reg(APIC_REG_ESR) = 0;
 dd8:	b8 80 02 ff ef       	mov    eax,0xefff0280
 ddd:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0

		/* do the apic timer init */
		extern void apic_timer_setup();
		apic_timer_setup();
 de3:	b8 00 00 00 00       	mov    eax,0x0
 de8:	e8 00 00 00 00       	call   ded <apic_init+0x2dd>
		apic_initialized = 1;
 ded:	c7 05 00 00 00 00 01 00 00 00 	mov    DWORD PTR [rip+0x0],0x1        # df7 <apic_init+0x2e7>

		/* (always) do MP init */
		void mp_entry();
		mp_entry();
 df7:	b8 00 00 00 00       	mov    eax,0x0
 dfc:	e8 00 00 00 00       	call   e01 <apic_init+0x2f1>
		/* send self-IPI (only shorthand, i.e. lower reg) */
//		do { /*4c*/
//				apic_reg(APIC_REG_ICRL) = 0x00044000 | 50; /* level, edge */
//				for (size_t i = 0; i < 0x0f000000; i++);
//		} while (0);
}
 e01:	90                   	nop
 e02:	c9                   	leave
 e03:	c3                   	ret
