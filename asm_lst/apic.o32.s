
apic.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <per_cpu_ptr>:
		for (int i = 0; i < 16; i++) {
				uint32_t pin = 0;
				if (!ioapic_mappings[i].ptr_base)
						continue;
				for (int j = 0; j < ioapic_mappings[i].max_pin + 1; j++) {
						uint32_t st;
   0:	55                   	push   ebp
   1:	89 e5                	mov    ebp,esp
   3:	83 ec 10             	sub    esp,0x10
						st = ioapic_read(i, 0x10 + 2 * j);
						if (st & (1 << 12)) /* DS=pending */
								pin |= (1 << j);
				}
				printf("IOAPIC%u: %08x\n", i, pin);
   6:	64 a1 00 00 00 00    	mov    eax,fs:0x0
   c:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		}
}
   f:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]

  12:	c9                   	leave
  13:	c3                   	ret

00000014 <cpu_get_msr>:
{
  14:	55                   	push   ebp
  15:	89 e5                	mov    ebp,esp
		__asm__("rdmsr" : "=a" (*eax), "=d" (*edx) : "c" (msr) : );
  17:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
  1a:	89 c1                	mov    ecx,eax
  1c:	0f 32                	rdmsr
  1e:	89 c1                	mov    ecx,eax
  20:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
  23:	89 08                	mov    DWORD PTR [eax],ecx
  25:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
  28:	89 10                	mov    DWORD PTR [eax],edx
}
  2a:	90                   	nop
  2b:	5d                   	pop    ebp
  2c:	c3                   	ret

0000002d <cpu_set_msr>:
{
  2d:	55                   	push   ebp
  2e:	89 e5                	mov    ebp,esp
		__asm__("wrmsr" : : "a" (eax), "d" (edx), "c" (msr) : );
  30:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
  33:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
  36:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
  39:	0f 30                	wrmsr
}
  3b:	90                   	nop
  3c:	5d                   	pop    ebp
  3d:	c3                   	ret

0000003e <apic_set_tpr>:
{
  3e:	55                   	push   ebp
  3f:	89 e5                	mov    ebp,esp
  41:	53                   	push   ebx
  42:	83 ec 04             	sub    esp,0x4
  45:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
  48:	88 45 f8             	mov    BYTE PTR [ebp-0x8],al
		apic_reg(APIC_REG_TASKPRIOR) = (tpr << 4);
  4b:	0f b6 5d f8          	movzx  ebx,BYTE PTR [ebp-0x8]
  4f:	e8 ac ff ff ff       	call   0 <per_cpu_ptr>
  54:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
  57:	83 e8 80             	sub    eax,0xffffff80
  5a:	89 da                	mov    edx,ebx
  5c:	c1 e2 04             	shl    edx,0x4
  5f:	89 10                	mov    DWORD PTR [eax],edx
}
  61:	90                   	nop
  62:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
  65:	c9                   	leave
  66:	c3                   	ret

00000067 <apic_set_ldr>:
{
  67:	55                   	push   ebp
  68:	89 e5                	mov    ebp,esp
  6a:	53                   	push   ebx
  6b:	83 ec 04             	sub    esp,0x4
  6e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
  71:	88 45 f8             	mov    BYTE PTR [ebp-0x8],al
		apic_reg(APIC_REG_LDR) = (uint32_t)ld << 24;
  74:	0f b6 5d f8          	movzx  ebx,BYTE PTR [ebp-0x8]
  78:	e8 83 ff ff ff       	call   0 <per_cpu_ptr>
  7d:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
  80:	05 d0 00 00 00       	add    eax,0xd0
  85:	89 da                	mov    edx,ebx
  87:	c1 e2 18             	shl    edx,0x18
  8a:	89 10                	mov    DWORD PTR [eax],edx
}
  8c:	90                   	nop
  8d:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
  90:	c9                   	leave
  91:	c3                   	ret

00000092 <apic_set_dfr>:
{
  92:	55                   	push   ebp
  93:	89 e5                	mov    ebp,esp
  95:	53                   	push   ebx
  96:	83 ec 04             	sub    esp,0x4
  99:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
  9c:	88 45 f8             	mov    BYTE PTR [ebp-0x8],al
		apic_reg(APIC_REG_DFR) = ((uint32_t)mod << 28) | 0x0fffffff;
  9f:	0f b6 45 f8          	movzx  eax,BYTE PTR [ebp-0x8]
  a3:	c1 e0 1c             	shl    eax,0x1c
  a6:	89 c3                	mov    ebx,eax
  a8:	e8 53 ff ff ff       	call   0 <per_cpu_ptr>
  ad:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
  b0:	05 e0 00 00 00       	add    eax,0xe0
  b5:	89 da                	mov    edx,ebx
  b7:	81 ca ff ff ff 0f    	or     edx,0xfffffff
  bd:	89 10                	mov    DWORD PTR [eax],edx
}
  bf:	90                   	nop
  c0:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
  c3:	c9                   	leave
  c4:	c3                   	ret

000000c5 <ioapic_read>:
{
  c5:	55                   	push   ebp
  c6:	89 e5                	mov    ebp,esp
  c8:	83 ec 18             	sub    esp,0x18
  cb:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
  ce:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
  d1:	88 55 ec             	mov    BYTE PTR [ebp-0x14],dl
  d4:	88 45 e8             	mov    BYTE PTR [ebp-0x18],al
		void* ptr = ioapic_mappings[id].ptr_base + ioapic_mappings[id].ptr_ofs;
  d7:	0f b6 45 ec          	movzx  eax,BYTE PTR [ebp-0x14]
  db:	c1 e0 04             	shl    eax,0x4
  de:	05 08 00 00 00       	add    eax,0x8
  e3:	8b 10                	mov    edx,DWORD PTR [eax]
  e5:	0f b6 45 ec          	movzx  eax,BYTE PTR [ebp-0x14]
  e9:	c1 e0 04             	shl    eax,0x4
  ec:	05 0c 00 00 00       	add    eax,0xc
  f1:	0f b7 00             	movzx  eax,WORD PTR [eax]
  f4:	0f b7 c0             	movzx  eax,ax
  f7:	01 d0                	add    eax,edx
  f9:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		*(volatile uint8_t*)ptr = reg;
  fc:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
  ff:	0f b6 55 e8          	movzx  edx,BYTE PTR [ebp-0x18]
 103:	88 10                	mov    BYTE PTR [eax],dl
		return *(volatile uint32_t*)(ptr + 0x10);
 105:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
 108:	83 c0 10             	add    eax,0x10
 10b:	8b 00                	mov    eax,DWORD PTR [eax]
}
 10d:	c9                   	leave
 10e:	c3                   	ret

0000010f <ioapic_write>:
{
 10f:	55                   	push   ebp
 110:	89 e5                	mov    ebp,esp
 112:	83 ec 18             	sub    esp,0x18
 115:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
 118:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 11b:	88 55 ec             	mov    BYTE PTR [ebp-0x14],dl
 11e:	88 45 e8             	mov    BYTE PTR [ebp-0x18],al
		void* ptr = ioapic_mappings[id].ptr_base + ioapic_mappings[id].ptr_ofs;
 121:	0f b6 45 ec          	movzx  eax,BYTE PTR [ebp-0x14]
 125:	c1 e0 04             	shl    eax,0x4
 128:	05 08 00 00 00       	add    eax,0x8
 12d:	8b 10                	mov    edx,DWORD PTR [eax]
 12f:	0f b6 45 ec          	movzx  eax,BYTE PTR [ebp-0x14]
 133:	c1 e0 04             	shl    eax,0x4
 136:	05 0c 00 00 00       	add    eax,0xc
 13b:	0f b7 00             	movzx  eax,WORD PTR [eax]
 13e:	0f b7 c0             	movzx  eax,ax
 141:	01 d0                	add    eax,edx
 143:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		*(volatile uint8_t*)ptr = reg;
 146:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
 149:	0f b6 55 e8          	movzx  edx,BYTE PTR [ebp-0x18]
 14d:	88 10                	mov    BYTE PTR [eax],dl
		*(volatile uint32_t*)(ptr + 0x10) = val;
 14f:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
 152:	8d 50 10             	lea    edx,[eax+0x10]
 155:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 158:	89 02                	mov    DWORD PTR [edx],eax
}
 15a:	90                   	nop
 15b:	c9                   	leave
 15c:	c3                   	ret

0000015d <init_ioapic>:
{
 15d:	55                   	push   ebp
 15e:	89 e5                	mov    ebp,esp
 160:	57                   	push   edi
 161:	56                   	push   esi
 162:	83 ec 50             	sub    esp,0x50
 165:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 168:	88 45 b4             	mov    BYTE PTR [ebp-0x4c],al
		void* vmem = NULL; size_t ofs = (size_t)addr % 4096;
 16b:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
 172:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 175:	25 ff 0f 00 00       	and    eax,0xfff
 17a:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		uint64_t page = (size_t)addr - (size_t)addr % 4096;
 17d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 180:	ba 00 00 00 00       	mov    edx,0x0
 185:	25 00 f0 ff ff       	and    eax,0xfffff000
 18a:	ba 00 00 00 00       	mov    edx,0x0
 18f:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
 192:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
		printf("%p %x\n", addr, (uint32_t)page);
 195:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 198:	83 ec 04             	sub    esp,0x4
 19b:	50                   	push   eax
 19c:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
 19f:	68 00 00 00 00       	push   0x0
 1a4:	e8 fc ff ff ff       	call   1a5 <init_ioapic+0x48>
 1a9:	83 c4 10             	add    esp,0x10
		for (size_t i = 0; i < 16; i++)
 1ac:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
 1b3:	eb 34                	jmp    1e9 <init_ioapic+0x8c>
				if (ioapic_mappings[i].page == page) {
 1b5:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 1b8:	c1 e0 04             	shl    eax,0x4
 1bb:	05 00 00 00 00       	add    eax,0x0
 1c0:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
 1c3:	8b 00                	mov    eax,DWORD PTR [eax]
 1c5:	89 c1                	mov    ecx,eax
 1c7:	89 c8                	mov    eax,ecx
 1c9:	33 45 d8             	xor    eax,DWORD PTR [ebp-0x28]
 1cc:	33 55 dc             	xor    edx,DWORD PTR [ebp-0x24]
 1cf:	09 d0                	or     eax,edx
 1d1:	75 12                	jne    1e5 <init_ioapic+0x88>
						vmem = ioapic_mappings[i].ptr_base;
 1d3:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 1d6:	c1 e0 04             	shl    eax,0x4
 1d9:	05 08 00 00 00       	add    eax,0x8
 1de:	8b 00                	mov    eax,DWORD PTR [eax]
 1e0:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
 1e3:	eb 0a                	jmp    1ef <init_ioapic+0x92>
		for (size_t i = 0; i < 16; i++)
 1e5:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
 1e9:	83 7d f0 0f          	cmp    DWORD PTR [ebp-0x10],0xf
 1ed:	76 c6                	jbe    1b5 <init_ioapic+0x58>
		if (!vmem) {
 1ef:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
 1f3:	0f 85 96 00 00 00    	jne    28f <init_ioapic+0x132>
				vmem = bp_apic_base - 4096;
 1f9:	a1 00 00 00 00       	mov    eax,ds:0x0
 1fe:	2d 00 10 00 00       	sub    eax,0x1000
 203:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				pr.base = page; pr.count = 1;
 206:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 209:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
 20c:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
 20f:	89 55 c8             	mov    DWORD PTR [ebp-0x38],edx
 212:	c7 45 cc 01 00 00 00 	mov    DWORD PTR [ebp-0x34],0x1
				vmem = mm_map(&mm_kernel, bp_apic_base - 4096, &pr, 1,
 219:	a1 00 00 00 00       	mov    eax,ds:0x0
 21e:	8d 90 00 f0 ff ff    	lea    edx,[eax-0x1000]
 224:	83 ec 0c             	sub    esp,0xc
 227:	6a 2d                	push   0x2d
 229:	6a 01                	push   0x1
 22b:	8d 45 c4             	lea    eax,[ebp-0x3c]
 22e:	50                   	push   eax
 22f:	52                   	push   edx
 230:	68 00 00 00 00       	push   0x0
 235:	e8 fc ff ff ff       	call   236 <init_ioapic+0xd9>
 23a:	83 c4 20             	add    esp,0x20
 23d:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				if (!vmem) {
 240:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
 244:	75 2b                	jne    271 <init_ioapic+0x114>
						die("unable to map I/O APIC.\n");
 246:	83 ec 08             	sub    esp,0x8
 249:	68 07 00 00 00       	push   0x7
 24e:	6a 0c                	push   0xc
 250:	e8 fc ff ff ff       	call   251 <init_ioapic+0xf4>
 255:	83 c4 10             	add    esp,0x10
 258:	e8 fc ff ff ff       	call   259 <init_ioapic+0xfc>
 25d:	83 ec 0c             	sub    esp,0xc
 260:	68 00 00 00 00       	push   0x0
 265:	e8 fc ff ff ff       	call   266 <init_ioapic+0x109>
 26a:	83 c4 10             	add    esp,0x10
 26d:	fa                   	cli
 26e:	f4                   	hlt
 26f:	eb fd                	jmp    26e <init_ioapic+0x111>
				} else if (vmem == bp_apic_base - 4096)
 271:	a1 00 00 00 00       	mov    eax,ds:0x0
 276:	2d 00 10 00 00       	sub    eax,0x1000
 27b:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
 27e:	75 0f                	jne    28f <init_ioapic+0x132>
						bp_apic_base -= 4096;
 280:	a1 00 00 00 00       	mov    eax,ds:0x0
 285:	2d 00 10 00 00       	sub    eax,0x1000
 28a:	a3 00 00 00 00       	mov    ds:0x0,eax
		if (id < 16) {
 28f:	80 7d b4 0f          	cmp    BYTE PTR [ebp-0x4c],0xf
 293:	0f 87 04 01 00 00    	ja     39d <init_ioapic+0x240>
				ioapic_mappings[id].page = page;
 299:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 29d:	c1 e0 04             	shl    eax,0x4
 2a0:	8d 88 00 00 00 00    	lea    ecx,[eax+0x0]
 2a6:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 2a9:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
 2ac:	89 01                	mov    DWORD PTR [ecx],eax
 2ae:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
				ioapic_mappings[id].ptr_base = vmem;
 2b1:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 2b5:	c1 e0 04             	shl    eax,0x4
 2b8:	8d 90 08 00 00 00    	lea    edx,[eax+0x8]
 2be:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 2c1:	89 02                	mov    DWORD PTR [edx],eax
				ioapic_mappings[id].ptr_ofs = ofs;
 2c3:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 2c7:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
 2ca:	c1 e0 04             	shl    eax,0x4
 2cd:	05 0c 00 00 00       	add    eax,0xc
 2d2:	66 89 10             	mov    WORD PTR [eax],dx
				vmem += ofs;
 2d5:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 2d8:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
		printf("reg1: %08x\n", ioapic_read(id, 0));
 2db:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 2df:	83 ec 08             	sub    esp,0x8
 2e2:	6a 00                	push   0x0
 2e4:	50                   	push   eax
 2e5:	e8 fc ff ff ff       	call   2e6 <init_ioapic+0x189>
 2ea:	83 c4 10             	add    esp,0x10
 2ed:	83 ec 08             	sub    esp,0x8
 2f0:	50                   	push   eax
 2f1:	68 43 00 00 00       	push   0x43
 2f6:	e8 fc ff ff ff       	call   2f7 <init_ioapic+0x19a>
 2fb:	83 c4 10             	add    esp,0x10
		printf("reg2: %08x\n", ioapic_read(id, 1));
 2fe:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 302:	83 ec 08             	sub    esp,0x8
 305:	6a 01                	push   0x1
 307:	50                   	push   eax
 308:	e8 fc ff ff ff       	call   309 <init_ioapic+0x1ac>
 30d:	83 c4 10             	add    esp,0x10
 310:	83 ec 08             	sub    esp,0x8
 313:	50                   	push   eax
 314:	68 4f 00 00 00       	push   0x4f
 319:	e8 fc ff ff ff       	call   31a <init_ioapic+0x1bd>
 31e:	83 c4 10             	add    esp,0x10
		printf("reg3: %08x\n", ioapic_read(id, 2));
 321:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 325:	83 ec 08             	sub    esp,0x8
 328:	6a 02                	push   0x2
 32a:	50                   	push   eax
 32b:	e8 fc ff ff ff       	call   32c <init_ioapic+0x1cf>
 330:	83 c4 10             	add    esp,0x10
 333:	83 ec 08             	sub    esp,0x8
 336:	50                   	push   eax
 337:	68 5b 00 00 00       	push   0x5b
 33c:	e8 fc ff ff ff       	call   33d <init_ioapic+0x1e0>
 341:	83 c4 10             	add    esp,0x10
		ioapic_mappings[id].max_pin = (ioapic_read(id, 1) >> 16) & 0xff;
 344:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 348:	83 ec 08             	sub    esp,0x8
 34b:	6a 01                	push   0x1
 34d:	50                   	push   eax
 34e:	e8 fc ff ff ff       	call   34f <init_ioapic+0x1f2>
 353:	83 c4 10             	add    esp,0x10
 356:	c1 e8 10             	shr    eax,0x10
 359:	89 c2                	mov    edx,eax
 35b:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 35f:	c1 e0 04             	shl    eax,0x4
 362:	05 0e 00 00 00       	add    eax,0xe
 367:	88 10                	mov    BYTE PTR [eax],dl
		ioapic_mappings[id].real_id = (ioapic_read(id, 0) >> 24) & 0x0f;
 369:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 36d:	83 ec 08             	sub    esp,0x8
 370:	6a 00                	push   0x0
 372:	50                   	push   eax
 373:	e8 fc ff ff ff       	call   374 <init_ioapic+0x217>
 378:	83 c4 10             	add    esp,0x10
 37b:	c1 e8 18             	shr    eax,0x18
 37e:	89 c2                	mov    edx,eax
 380:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 384:	83 e2 0f             	and    edx,0xf
 387:	c1 e0 04             	shl    eax,0x4
 38a:	05 0f 00 00 00       	add    eax,0xf
 38f:	88 10                	mov    BYTE PTR [eax],dl
		for (int i = 16; i < ioapic_mappings[id].max_pin + 1; i++) {
 391:	c7 45 ec 10 00 00 00 	mov    DWORD PTR [ebp-0x14],0x10
 398:	e9 89 00 00 00       	jmp    426 <init_ioapic+0x2c9>
				die("I/O APIC ID larger than 15 found!\n");
 39d:	83 ec 08             	sub    esp,0x8
 3a0:	68 20 00 00 00       	push   0x20
 3a5:	6a 0c                	push   0xc
 3a7:	e8 fc ff ff ff       	call   3a8 <init_ioapic+0x24b>
 3ac:	83 c4 10             	add    esp,0x10
 3af:	e8 fc ff ff ff       	call   3b0 <init_ioapic+0x253>
 3b4:	83 ec 0c             	sub    esp,0xc
 3b7:	68 00 00 00 00       	push   0x0
 3bc:	e8 fc ff ff ff       	call   3bd <init_ioapic+0x260>
 3c1:	83 c4 10             	add    esp,0x10
 3c4:	fa                   	cli
 3c5:	f4                   	hlt
 3c6:	eb fd                	jmp    3c5 <init_ioapic+0x268>
				ioapic_write(id, 0x11 + i * 2, 0x00000000);
 3c8:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 3cb:	01 c0                	add    eax,eax
 3cd:	83 c0 11             	add    eax,0x11
 3d0:	0f b6 d0             	movzx  edx,al
 3d3:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 3d7:	83 ec 04             	sub    esp,0x4
 3da:	6a 00                	push   0x0
 3dc:	52                   	push   edx
 3dd:	50                   	push   eax
 3de:	e8 fc ff ff ff       	call   3df <init_ioapic+0x282>
 3e3:	83 c4 10             	add    esp,0x10
						| (40 + (i - 16) % 8)); /* 40-47 (round-robin if more) */
 3e6:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 3e9:	8d 50 f0             	lea    edx,[eax-0x10]
 3ec:	89 d0                	mov    eax,edx
 3ee:	c1 f8 1f             	sar    eax,0x1f
 3f1:	c1 e8 1d             	shr    eax,0x1d
 3f4:	01 c2                	add    edx,eax
 3f6:	83 e2 07             	and    edx,0x7
 3f9:	29 c2                	sub    edx,eax
 3fb:	89 d0                	mov    eax,edx
 3fd:	83 c0 28             	add    eax,0x28
 400:	80 cc a0             	or     ah,0xa0
				ioapic_write(id, 0x10 + i * 2, 0x0000a000 /* a=lvl low; 0=phys,fixed */
 403:	89 c1                	mov    ecx,eax
 405:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 408:	83 c0 08             	add    eax,0x8
 40b:	01 c0                	add    eax,eax
 40d:	0f b6 d0             	movzx  edx,al
 410:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 414:	83 ec 04             	sub    esp,0x4
 417:	51                   	push   ecx
 418:	52                   	push   edx
 419:	50                   	push   eax
 41a:	e8 fc ff ff ff       	call   41b <init_ioapic+0x2be>
 41f:	83 c4 10             	add    esp,0x10
		for (int i = 16; i < ioapic_mappings[id].max_pin + 1; i++) {
 422:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
 426:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 42a:	c1 e0 04             	shl    eax,0x4
 42d:	05 0e 00 00 00       	add    eax,0xe
 432:	0f b6 00             	movzx  eax,BYTE PTR [eax]
 435:	0f b6 c0             	movzx  eax,al
 438:	39 45 ec             	cmp    DWORD PTR [ebp-0x14],eax
 43b:	7e 8b                	jle    3c8 <init_ioapic+0x26b>
				ioapic_mappings[id].max_pin + 1);
 43d:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 441:	c1 e0 04             	shl    eax,0x4
 444:	05 0e 00 00 00       	add    eax,0xe
 449:	0f b6 00             	movzx  eax,BYTE PTR [eax]
 44c:	0f b6 c0             	movzx  eax,al
		printf("I/O APIC with ID %x (%d pins):\n", ioapic_mappings[id].real_id,
 44f:	8d 50 01             	lea    edx,[eax+0x1]
 452:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 456:	c1 e0 04             	shl    eax,0x4
 459:	05 0f 00 00 00       	add    eax,0xf
 45e:	0f b6 00             	movzx  eax,BYTE PTR [eax]
 461:	0f b6 c0             	movzx  eax,al
 464:	83 ec 04             	sub    esp,0x4
 467:	52                   	push   edx
 468:	50                   	push   eax
 469:	68 68 00 00 00       	push   0x68
 46e:	e8 fc ff ff ff       	call   46f <init_ioapic+0x312>
 473:	83 c4 10             	add    esp,0x10
		for (int i = 0; i < ioapic_mappings[id].max_pin + 1; i++) {
 476:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
 47d:	eb 6c                	jmp    4eb <init_ioapic+0x38e>
				uint64_t dat = ioapic_read(id, 0x10 + i * 2) | ((uint64_t)
 47f:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 482:	83 c0 08             	add    eax,0x8
 485:	01 c0                	add    eax,eax
 487:	0f b6 d0             	movzx  edx,al
 48a:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 48e:	83 ec 08             	sub    esp,0x8
 491:	52                   	push   edx
 492:	50                   	push   eax
 493:	e8 fc ff ff ff       	call   494 <init_ioapic+0x337>
 498:	83 c4 10             	add    esp,0x10
 49b:	89 c6                	mov    esi,eax
 49d:	bf 00 00 00 00       	mov    edi,0x0
						ioapic_read(id, 0x11 + i * 2) << 32);
 4a2:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 4a5:	01 c0                	add    eax,eax
 4a7:	83 c0 11             	add    eax,0x11
 4aa:	0f b6 d0             	movzx  edx,al
 4ad:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 4b1:	83 ec 08             	sub    esp,0x8
 4b4:	52                   	push   edx
 4b5:	50                   	push   eax
 4b6:	e8 fc ff ff ff       	call   4b7 <init_ioapic+0x35a>
 4bb:	83 c4 10             	add    esp,0x10
				uint64_t dat = ioapic_read(id, 0x10 + i * 2) | ((uint64_t)
 4be:	ba 00 00 00 00       	mov    edx,0x0
						ioapic_read(id, 0x11 + i * 2) << 32);
 4c3:	89 c2                	mov    edx,eax
 4c5:	31 c0                	xor    eax,eax
				uint64_t dat = ioapic_read(id, 0x10 + i * 2) | ((uint64_t)
 4c7:	09 f0                	or     eax,esi
 4c9:	09 fa                	or     edx,edi
 4cb:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
 4ce:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
				printf("REDTBL%-3d %016llx\n", i, dat);
 4d1:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
 4d4:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
 4d7:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
 4da:	68 88 00 00 00       	push   0x88
 4df:	e8 fc ff ff ff       	call   4e0 <init_ioapic+0x383>
 4e4:	83 c4 10             	add    esp,0x10
		for (int i = 0; i < ioapic_mappings[id].max_pin + 1; i++) {
 4e7:	83 45 e8 01          	add    DWORD PTR [ebp-0x18],0x1
 4eb:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 4ef:	c1 e0 04             	shl    eax,0x4
 4f2:	05 0e 00 00 00       	add    eax,0xe
 4f7:	0f b6 00             	movzx  eax,BYTE PTR [eax]
 4fa:	0f b6 c0             	movzx  eax,al
 4fd:	39 45 e8             	cmp    DWORD PTR [ebp-0x18],eax
 500:	0f 8e 79 ff ff ff    	jle    47f <init_ioapic+0x322>
		printf("\n");
 506:	83 ec 0c             	sub    esp,0xc
 509:	68 9c 00 00 00       	push   0x9c
 50e:	e8 fc ff ff ff       	call   50f <init_ioapic+0x3b2>
 513:	83 c4 10             	add    esp,0x10
}
 516:	90                   	nop
 517:	8d 65 f8             	lea    esp,[ebp-0x8]
 51a:	5e                   	pop    esi
 51b:	5f                   	pop    edi
 51c:	5d                   	pop    ebp
 51d:	c3                   	ret

0000051e <ioapic_print_is>:
{
 51e:	55                   	push   ebp
 51f:	89 e5                	mov    ebp,esp
 521:	83 ec 18             	sub    esp,0x18
		for (int i = 0; i < 16; i++) {
 524:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
 52b:	e9 93 00 00 00       	jmp    5c3 <ioapic_print_is+0xa5>
				uint32_t pin = 0;
 530:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
				if (!ioapic_mappings[i].ptr_base)
 537:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 53a:	c1 e0 04             	shl    eax,0x4
 53d:	05 08 00 00 00       	add    eax,0x8
 542:	8b 00                	mov    eax,DWORD PTR [eax]
 544:	85 c0                	test   eax,eax
 546:	74 76                	je     5be <ioapic_print_is+0xa0>
				for (int j = 0; j < ioapic_mappings[i].max_pin + 1; j++) {
 548:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
 54f:	eb 3f                	jmp    590 <ioapic_print_is+0x72>
						st = ioapic_read(i, 0x10 + 2 * j);
 551:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 554:	83 c0 08             	add    eax,0x8
 557:	01 c0                	add    eax,eax
 559:	0f b6 d0             	movzx  edx,al
 55c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 55f:	0f b6 c0             	movzx  eax,al
 562:	52                   	push   edx
 563:	50                   	push   eax
 564:	e8 fc ff ff ff       	call   565 <ioapic_print_is+0x47>
 569:	83 c4 08             	add    esp,0x8
 56c:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
						if (st & (1 << 12)) /* DS=pending */
 56f:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 572:	25 00 10 00 00       	and    eax,0x1000
 577:	85 c0                	test   eax,eax
 579:	74 11                	je     58c <ioapic_print_is+0x6e>
								pin |= (1 << j);
 57b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 57e:	ba 01 00 00 00       	mov    edx,0x1
 583:	89 c1                	mov    ecx,eax
 585:	d3 e2                	shl    edx,cl
 587:	89 d0                	mov    eax,edx
 589:	09 45 f0             	or     DWORD PTR [ebp-0x10],eax
				for (int j = 0; j < ioapic_mappings[i].max_pin + 1; j++) {
 58c:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
 590:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 593:	c1 e0 04             	shl    eax,0x4
 596:	05 0e 00 00 00       	add    eax,0xe
 59b:	0f b6 00             	movzx  eax,BYTE PTR [eax]
 59e:	0f b6 c0             	movzx  eax,al
 5a1:	39 45 ec             	cmp    DWORD PTR [ebp-0x14],eax
 5a4:	7e ab                	jle    551 <ioapic_print_is+0x33>
				printf("IOAPIC%u: %08x\n", i, pin);
 5a6:	83 ec 04             	sub    esp,0x4
 5a9:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
 5ac:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
 5af:	68 9e 00 00 00       	push   0x9e
 5b4:	e8 fc ff ff ff       	call   5b5 <ioapic_print_is+0x97>
 5b9:	83 c4 10             	add    esp,0x10
 5bc:	eb 01                	jmp    5bf <ioapic_print_is+0xa1>
						continue;
 5be:	90                   	nop
		for (int i = 0; i < 16; i++) {
 5bf:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
 5c3:	83 7d f4 0f          	cmp    DWORD PTR [ebp-0xc],0xf
 5c7:	0f 8e 63 ff ff ff    	jle    530 <ioapic_print_is+0x12>
}
 5cd:	90                   	nop
 5ce:	90                   	nop
 5cf:	c9                   	leave
 5d0:	c3                   	ret

000005d1 <ap_apic_init>:
/**********  Local APIC configuration including IPIs  ********************/
void ap_apic_init()
{
 5d1:	55                   	push   ebp
 5d2:	89 e5                	mov    ebp,esp
 5d4:	56                   	push   esi
 5d5:	53                   	push   ebx
 5d6:	83 ec 20             	sub    esp,0x20
		/* TODO use regular init as APIC MMIO memory is global */
		/* we're using iprintf to avoid needless waiting */
		struct page_range pr = {0,1};
 5d9:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
 5e0:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
 5e7:	c7 45 f4 01 00 00 00 	mov    DWORD PTR [ebp-0xc],0x1
		uint32_t eax, edx;
		cpu_get_msr(APIC_BASE_MSR, &eax, &edx);
 5ee:	8d 45 e4             	lea    eax,[ebp-0x1c]
 5f1:	50                   	push   eax
 5f2:	8d 45 e8             	lea    eax,[ebp-0x18]
 5f5:	50                   	push   eax
 5f6:	6a 1b                	push   0x1b
 5f8:	e8 fc ff ff ff       	call   5f9 <ap_apic_init+0x28>
 5fd:	83 c4 0c             	add    esp,0xc
		pr.base = ((uint64_t)(edx & 0x0f)) << 32 | (eax & 0xfffff000);
 600:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 603:	ba 00 00 00 00       	mov    edx,0x0
 608:	89 c2                	mov    edx,eax
 60a:	31 c0                	xor    eax,eax
 60c:	b8 00 00 00 00       	mov    eax,0x0
 611:	83 e2 0f             	and    edx,0xf
 614:	89 c1                	mov    ecx,eax
 616:	89 d3                	mov    ebx,edx
 618:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 61b:	ba 00 00 00 00       	mov    edx,0x0
 620:	25 00 f0 ff ff       	and    eax,0xfffff000
 625:	ba 00 00 00 00       	mov    edx,0x0
 62a:	09 c8                	or     eax,ecx
 62c:	09 da                	or     edx,ebx
 62e:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
 631:	89 55 f0             	mov    DWORD PTR [ebp-0x10],edx
		iprintf("msr: %08x%08x\n", edx, eax);
 634:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
 637:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 63a:	83 ec 04             	sub    esp,0x4
 63d:	52                   	push   edx
 63e:	50                   	push   eax
 63f:	68 ae 00 00 00       	push   0xae
 644:	e8 fc ff ff ff       	call   645 <ap_apic_init+0x74>
 649:	83 c4 10             	add    esp,0x10
		/* ensure PM location */
		if (!pr.base)
 64c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 64f:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
 652:	89 c1                	mov    ecx,eax
 654:	89 c8                	mov    eax,ecx
 656:	09 d0                	or     eax,edx
 658:	75 2b                	jne    685 <ap_apic_init+0xb4>
				die("APIC has no PM location assigned. TODO: write PM MMIO address allocator.\n");
 65a:	83 ec 08             	sub    esp,0x8
 65d:	68 c0 00 00 00       	push   0xc0
 662:	6a 0c                	push   0xc
 664:	e8 fc ff ff ff       	call   665 <ap_apic_init+0x94>
 669:	83 c4 10             	add    esp,0x10
 66c:	e8 fc ff ff ff       	call   66d <ap_apic_init+0x9c>
 671:	83 ec 0c             	sub    esp,0xc
 674:	68 00 00 00 00       	push   0x0
 679:	e8 fc ff ff ff       	call   67a <ap_apic_init+0xa9>
 67e:	83 c4 10             	add    esp,0x10
 681:	fa                   	cli
 682:	f4                   	hlt
 683:	eb fd                	jmp    682 <ap_apic_init+0xb1>
		iprintf("AP APIC base: %016llx\n", pr.base);
 685:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 688:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
 68b:	83 ec 04             	sub    esp,0x4
 68e:	52                   	push   edx
 68f:	50                   	push   eax
 690:	68 0a 01 00 00       	push   0x10a
 695:	e8 fc ff ff ff       	call   696 <ap_apic_init+0xc5>
 69a:	83 c4 10             	add    esp,0x10
		if (!(eax & APIC_BASE_MSR_ENABLE)) {
 69d:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 6a0:	25 00 08 00 00       	and    eax,0x800
 6a5:	85 c0                	test   eax,eax
 6a7:	75 2c                	jne    6d5 <ap_apic_init+0x104>
				cpu_set_msr(APIC_BASE_MSR, (pr.base & 0xfffff000) |
					APIC_BASE_MSR_ENABLE, (pr.base >> 32) & 0x0f);
 6a9:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 6ac:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
 6af:	89 d0                	mov    eax,edx
 6b1:	31 d2                	xor    edx,edx
				cpu_set_msr(APIC_BASE_MSR, (pr.base & 0xfffff000) |
 6b3:	83 e0 0f             	and    eax,0xf
 6b6:	89 c1                	mov    ecx,eax
 6b8:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 6bb:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
 6be:	25 00 f0 ff ff       	and    eax,0xfffff000
 6c3:	80 cc 08             	or     ah,0x8
 6c6:	83 ec 04             	sub    esp,0x4
 6c9:	51                   	push   ecx
 6ca:	50                   	push   eax
 6cb:	6a 1b                	push   0x1b
 6cd:	e8 fc ff ff ff       	call   6ce <ap_apic_init+0xfd>
 6d2:	83 c4 10             	add    esp,0x10
		}
		/* keep track of the memory & map it */
		per_cpu_ptr()->apic_phys = pr.base;
 6d5:	e8 26 f9 ff ff       	call   0 <per_cpu_ptr>
 6da:	89 c1                	mov    ecx,eax
 6dc:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 6df:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
 6e2:	89 41 0c             	mov    DWORD PTR [ecx+0xc],eax
 6e5:	89 51 10             	mov    DWORD PTR [ecx+0x10],edx
		per_cpu_ptr()->apic_addr = mm_map(&mm_kernel, per_cpu_ptr()->apic_addr,
 6e8:	e8 13 f9 ff ff       	call   0 <per_cpu_ptr>
 6ed:	8b 70 08             	mov    esi,DWORD PTR [eax+0x8]
 6f0:	e8 0b f9 ff ff       	call   0 <per_cpu_ptr>
 6f5:	89 c3                	mov    ebx,eax
 6f7:	83 ec 0c             	sub    esp,0xc
 6fa:	6a 2d                	push   0x2d
 6fc:	6a 01                	push   0x1
 6fe:	8d 45 ec             	lea    eax,[ebp-0x14]
 701:	50                   	push   eax
 702:	56                   	push   esi
 703:	68 00 00 00 00       	push   0x0
 708:	e8 fc ff ff ff       	call   709 <ap_apic_init+0x138>
 70d:	83 c4 20             	add    esp,0x20
 710:	89 43 08             	mov    DWORD PTR [ebx+0x8],eax
				&pr, 1, MMGR_MAP_MMIO | MMGR_MAP_WRITE
				| MMGR_MAP_NO_CACHING | MMGR_MAP_KERNEL);
		/* set logical dest and mode */
		apic_set_dfr(0xf); /* flat mode */
 713:	83 ec 0c             	sub    esp,0xc
 716:	6a 0f                	push   0xf
 718:	e8 fc ff ff ff       	call   719 <ap_apic_init+0x148>
 71d:	83 c4 10             	add    esp,0x10
		apic_set_ldr(apic_cur_log);
 720:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
 727:	0f b6 c0             	movzx  eax,al
 72a:	83 ec 0c             	sub    esp,0xc
 72d:	50                   	push   eax
 72e:	e8 fc ff ff ff       	call   72f <ap_apic_init+0x15e>
 733:	83 c4 10             	add    esp,0x10
		apic_set_tpr(0); /* receive any intr */
 736:	83 ec 0c             	sub    esp,0xc
 739:	6a 00                	push   0x0
 73b:	e8 fc ff ff ff       	call   73c <ap_apic_init+0x16b>
 740:	83 c4 10             	add    esp,0x10
		if (!(apic_cur_log <<= 1)) /* x86 rol */
 743:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
 74a:	01 c0                	add    eax,eax
 74c:	a2 00 00 00 00       	mov    ds:0x0,al
 751:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
 758:	84 c0                	test   al,al
 75a:	75 07                	jne    763 <ap_apic_init+0x192>
				apic_cur_log = 1;
 75c:	c6 05 00 00 00 00 01 	mov    BYTE PTR ds:0x0,0x1
		/* TODO: possibly cause TLB shootdown */
		/* now APIC_BASE points to the xAPIC memory */
		iprintf("The registers are configured as follows:\n");
 763:	83 ec 0c             	sub    esp,0xc
 766:	68 24 01 00 00       	push   0x124
 76b:	e8 fc ff ff ff       	call   76c <ap_apic_init+0x19b>
 770:	83 c4 10             	add    esp,0x10
		iprintf("spurious:  %08x\n", apic_reg(APIC_REG_SPURIOUS));
 773:	e8 88 f8 ff ff       	call   0 <per_cpu_ptr>
 778:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 77b:	05 f0 00 00 00       	add    eax,0xf0
 780:	8b 00                	mov    eax,DWORD PTR [eax]
 782:	83 ec 08             	sub    esp,0x8
 785:	50                   	push   eax
 786:	68 4e 01 00 00       	push   0x14e
 78b:	e8 fc ff ff ff       	call   78c <ap_apic_init+0x1bb>
 790:	83 c4 10             	add    esp,0x10
		iprintf("error:     %08x\n", apic_reg(APIC_REG_ESR));
 793:	e8 68 f8 ff ff       	call   0 <per_cpu_ptr>
 798:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 79b:	05 80 02 00 00       	add    eax,0x280
 7a0:	8b 00                	mov    eax,DWORD PTR [eax]
 7a2:	83 ec 08             	sub    esp,0x8
 7a5:	50                   	push   eax
 7a6:	68 5f 01 00 00       	push   0x15f
 7ab:	e8 fc ff ff ff       	call   7ac <ap_apic_init+0x1db>
 7b0:	83 c4 10             	add    esp,0x10
		iprintf("LVT timer: %08x\n", apic_reg(APIC_REG_LVT_TMR));
 7b3:	e8 48 f8 ff ff       	call   0 <per_cpu_ptr>
 7b8:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 7bb:	05 20 03 00 00       	add    eax,0x320
 7c0:	8b 00                	mov    eax,DWORD PTR [eax]
 7c2:	83 ec 08             	sub    esp,0x8
 7c5:	50                   	push   eax
 7c6:	68 70 01 00 00       	push   0x170
 7cb:	e8 fc ff ff ff       	call   7cc <ap_apic_init+0x1fb>
 7d0:	83 c4 10             	add    esp,0x10
		iprintf("LVT therm: %08x\n", apic_reg(APIC_REG_LVT_THERM));
 7d3:	e8 28 f8 ff ff       	call   0 <per_cpu_ptr>
 7d8:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 7db:	05 30 03 00 00       	add    eax,0x330
 7e0:	8b 00                	mov    eax,DWORD PTR [eax]
 7e2:	83 ec 08             	sub    esp,0x8
 7e5:	50                   	push   eax
 7e6:	68 81 01 00 00       	push   0x181
 7eb:	e8 fc ff ff ff       	call   7ec <ap_apic_init+0x21b>
 7f0:	83 c4 10             	add    esp,0x10
		iprintf("LVT perf:  %08x\n", apic_reg(APIC_REG_LVT_PERF));
 7f3:	e8 08 f8 ff ff       	call   0 <per_cpu_ptr>
 7f8:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 7fb:	05 40 03 00 00       	add    eax,0x340
 800:	8b 00                	mov    eax,DWORD PTR [eax]
 802:	83 ec 08             	sub    esp,0x8
 805:	50                   	push   eax
 806:	68 92 01 00 00       	push   0x192
 80b:	e8 fc ff ff ff       	call   80c <ap_apic_init+0x23b>
 810:	83 c4 10             	add    esp,0x10
		iprintf("LVT LINT0: %08x\n", apic_reg(APIC_REG_LVT_LINT0));
 813:	e8 e8 f7 ff ff       	call   0 <per_cpu_ptr>
 818:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 81b:	05 50 03 00 00       	add    eax,0x350
 820:	8b 00                	mov    eax,DWORD PTR [eax]
 822:	83 ec 08             	sub    esp,0x8
 825:	50                   	push   eax
 826:	68 a3 01 00 00       	push   0x1a3
 82b:	e8 fc ff ff ff       	call   82c <ap_apic_init+0x25b>
 830:	83 c4 10             	add    esp,0x10
		iprintf("LVT LINT1: %08x\n", apic_reg(APIC_REG_LVT_LINT1));
 833:	e8 c8 f7 ff ff       	call   0 <per_cpu_ptr>
 838:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 83b:	05 60 03 00 00       	add    eax,0x360
 840:	8b 00                	mov    eax,DWORD PTR [eax]
 842:	83 ec 08             	sub    esp,0x8
 845:	50                   	push   eax
 846:	68 b4 01 00 00       	push   0x1b4
 84b:	e8 fc ff ff ff       	call   84c <ap_apic_init+0x27b>
 850:	83 c4 10             	add    esp,0x10
		iprintf("LVT error: %08x\n", apic_reg(APIC_REG_LVT_ERR));
 853:	e8 a8 f7 ff ff       	call   0 <per_cpu_ptr>
 858:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 85b:	05 70 03 00 00       	add    eax,0x370
 860:	8b 00                	mov    eax,DWORD PTR [eax]
 862:	83 ec 08             	sub    esp,0x8
 865:	50                   	push   eax
 866:	68 c5 01 00 00       	push   0x1c5
 86b:	e8 fc ff ff ff       	call   86c <ap_apic_init+0x29b>
 870:	83 c4 10             	add    esp,0x10
		apic_reg(APIC_REG_SPURIOUS) = 0x00000100 | 0x3f;
 873:	e8 88 f7 ff ff       	call   0 <per_cpu_ptr>
 878:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 87b:	05 f0 00 00 00       	add    eax,0xf0
 880:	c7 00 3f 01 00 00    	mov    DWORD PTR [eax],0x13f
		iprintf("spurious:  %08x\n", apic_reg(APIC_REG_SPURIOUS));
 886:	e8 75 f7 ff ff       	call   0 <per_cpu_ptr>
 88b:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 88e:	05 f0 00 00 00       	add    eax,0xf0
 893:	8b 00                	mov    eax,DWORD PTR [eax]
 895:	83 ec 08             	sub    esp,0x8
 898:	50                   	push   eax
 899:	68 4e 01 00 00       	push   0x14e
 89e:	e8 fc ff ff ff       	call   89f <ap_apic_init+0x2ce>
 8a3:	83 c4 10             	add    esp,0x10
		apic_reg(APIC_REG_LVT_ERR) = 0x3c; /* 0 | 3c */
 8a6:	e8 55 f7 ff ff       	call   0 <per_cpu_ptr>
 8ab:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 8ae:	05 70 03 00 00       	add    eax,0x370
 8b3:	c7 00 3c 00 00 00    	mov    DWORD PTR [eax],0x3c
		/* (val << 16): R00M=one-shot, R01M per, R11M tsc, R=res, M=mask */
		apic_reg(APIC_REG_LVT_TMR) = 0x00000000 | 0x3d; /* one-shot */
 8b9:	e8 42 f7 ff ff       	call   0 <per_cpu_ptr>
 8be:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 8c1:	05 20 03 00 00       	add    eax,0x320
 8c6:	c7 00 3d 00 00 00    	mov    DWORD PTR [eax],0x3d
		/* mask the LINTS */
		apic_reg(APIC_REG_LVT_LINT0) = 0x00010700; /* masked extInt */
 8cc:	e8 2f f7 ff ff       	call   0 <per_cpu_ptr>
 8d1:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 8d4:	05 50 03 00 00       	add    eax,0x350
 8d9:	c7 00 00 07 01 00    	mov    DWORD PTR [eax],0x10700
		apic_reg(APIC_REG_LVT_LINT1) = 0x00010400; /* masked NMI */
 8df:	e8 1c f7 ff ff       	call   0 <per_cpu_ptr>
 8e4:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 8e7:	05 60 03 00 00       	add    eax,0x360
 8ec:	c7 00 00 04 01 00    	mov    DWORD PTR [eax],0x10400
		/* arm the error register */
		apic_reg(APIC_REG_ESR) = 0;
 8f2:	e8 09 f7 ff ff       	call   0 <per_cpu_ptr>
 8f7:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 8fa:	05 80 02 00 00       	add    eax,0x280
 8ff:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
		apic_reg(APIC_REG_TMRDIV) = 0x0b; /* div=1 ; 111 */
 905:	e8 f6 f6 ff ff       	call   0 <per_cpu_ptr>
 90a:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 90d:	05 e0 03 00 00       	add    eax,0x3e0
 912:	c7 00 0b 00 00 00    	mov    DWORD PTR [eax],0xb
		apic_reg(APIC_REG_TMRINITCNT) = 0x0fffffff; /* 1.5s at 3GHz */
 918:	e8 e3 f6 ff ff       	call   0 <per_cpu_ptr>
 91d:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 920:	05 80 03 00 00       	add    eax,0x380
 925:	c7 00 ff ff ff 0f    	mov    DWORD PTR [eax],0xfffffff
}
 92b:	90                   	nop
 92c:	8d 65 f8             	lea    esp,[ebp-0x8]
 92f:	5b                   	pop    ebx
 930:	5e                   	pop    esi
 931:	5d                   	pop    ebp
 932:	c3                   	ret

00000933 <apic_init>:

void apic_init()
{
 933:	55                   	push   ebp
 934:	89 e5                	mov    ebp,esp
 936:	53                   	push   ebx
 937:	83 ec 24             	sub    esp,0x24
		struct page_range pr = {0,1};
 93a:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
 941:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
 948:	c7 45 f4 01 00 00 00 	mov    DWORD PTR [ebp-0xc],0x1
		uint32_t eax, edx;
		if (cpu.has_x2APIC)
 94f:	0f b6 05 56 00 00 00 	movzx  eax,BYTE PTR ds:0x56
 956:	83 e0 20             	and    eax,0x20
 959:	84 c0                	test   al,al
 95b:	74 12                	je     96f <apic_init+0x3c>
				cprintf(KFMT_INFO, "This CPU supports the x2APIC mode, but for "
 95d:	83 ec 08             	sub    esp,0x8
 960:	68 d8 01 00 00       	push   0x1d8
 965:	6a 0b                	push   0xb
 967:	e8 fc ff ff ff       	call   968 <apic_init+0x35>
 96c:	83 c4 10             	add    esp,0x10
						"simplicity it is run in xAPIC mode.\n");
		/* find and map the APIC registers */
		cpu_get_msr(APIC_BASE_MSR, &eax, &edx);
 96f:	83 ec 04             	sub    esp,0x4
 972:	8d 45 e4             	lea    eax,[ebp-0x1c]
 975:	50                   	push   eax
 976:	8d 45 e8             	lea    eax,[ebp-0x18]
 979:	50                   	push   eax
 97a:	6a 1b                	push   0x1b
 97c:	e8 fc ff ff ff       	call   97d <apic_init+0x4a>
 981:	83 c4 10             	add    esp,0x10
		pr.base = ((uint64_t)(edx & 0x0f)) << 32 | (eax & 0xfffff000);
 984:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 987:	ba 00 00 00 00       	mov    edx,0x0
 98c:	89 c2                	mov    edx,eax
 98e:	31 c0                	xor    eax,eax
 990:	b8 00 00 00 00       	mov    eax,0x0
 995:	83 e2 0f             	and    edx,0xf
 998:	89 c1                	mov    ecx,eax
 99a:	89 d3                	mov    ebx,edx
 99c:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 99f:	ba 00 00 00 00       	mov    edx,0x0
 9a4:	25 00 f0 ff ff       	and    eax,0xfffff000
 9a9:	ba 00 00 00 00       	mov    edx,0x0
 9ae:	09 c8                	or     eax,ecx
 9b0:	09 da                	or     edx,ebx
 9b2:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
 9b5:	89 55 f0             	mov    DWORD PTR [ebp-0x10],edx
		if (!pr.base) {
 9b8:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 9bb:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
 9be:	89 c1                	mov    ecx,eax
 9c0:	89 c8                	mov    eax,ecx
 9c2:	09 d0                	or     eax,edx
 9c4:	75 13                	jne    9d9 <apic_init+0xa6>
				// TODO: mmgr_get_mmio_pmem();
				pr.base = apic_pm_base;
 9c6:	a1 00 00 00 00       	mov    eax,ds:0x0
 9cb:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
 9d1:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
 9d4:	89 55 f0             	mov    DWORD PTR [ebp-0x10],edx
 9d7:	eb 11                	jmp    9ea <apic_init+0xb7>
		} else
				apic_pm_base = pr.base;
 9d9:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 9dc:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
 9df:	a3 00 00 00 00       	mov    ds:0x0,eax
 9e4:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
		if (!(eax & APIC_BASE_MSR_ENABLE)) {
 9ea:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 9ed:	25 00 08 00 00       	and    eax,0x800
 9f2:	85 c0                	test   eax,eax
 9f4:	75 2c                	jne    a22 <apic_init+0xef>
				cpu_set_msr(APIC_BASE_MSR, (pr.base & 0xfffff000) |
					APIC_BASE_MSR_ENABLE, (pr.base >> 32) & 0x0f);
 9f6:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 9f9:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
 9fc:	89 d0                	mov    eax,edx
 9fe:	31 d2                	xor    edx,edx
				cpu_set_msr(APIC_BASE_MSR, (pr.base & 0xfffff000) |
 a00:	83 e0 0f             	and    eax,0xf
 a03:	89 c1                	mov    ecx,eax
 a05:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 a08:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
 a0b:	25 00 f0 ff ff       	and    eax,0xfffff000
 a10:	80 cc 08             	or     ah,0x8
 a13:	83 ec 04             	sub    esp,0x4
 a16:	51                   	push   ecx
 a17:	50                   	push   eax
 a18:	6a 1b                	push   0x1b
 a1a:	e8 fc ff ff ff       	call   a1b <apic_init+0xe8>
 a1f:	83 c4 10             	add    esp,0x10
		}
		mm_map(&mm_kernel, bp_apic_base, &pr, 1, MMGR_MAP_MMIO | MMGR_MAP_WRITE
 a22:	a1 00 00 00 00       	mov    eax,ds:0x0
 a27:	83 ec 0c             	sub    esp,0xc
 a2a:	6a 2d                	push   0x2d
 a2c:	6a 01                	push   0x1
 a2e:	8d 55 ec             	lea    edx,[ebp-0x14]
 a31:	52                   	push   edx
 a32:	50                   	push   eax
 a33:	68 00 00 00 00       	push   0x0
 a38:	e8 fc ff ff ff       	call   a39 <apic_init+0x106>
 a3d:	83 c4 20             	add    esp,0x20
			| MMGR_MAP_NO_CACHING | MMGR_MAP_KERNEL);
		/* now access them */
		edx = apic_bp_reg(APIC_REG_APICID);
 a40:	b8 20 00 ff ef       	mov    eax,0xefff0020
 a45:	8b 00                	mov    eax,DWORD PTR [eax]
 a47:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		printf("The APIC of the %s with ID %x is located at 0x%016llx\n",
 a4a:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 a4d:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
 a50:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
 a53:	c1 e9 18             	shr    ecx,0x18
			(eax & APIC_BASE_MSR_BSP) ? "BSP" : "AP", edx >> 24, pr.base);
 a56:	8b 5d e8             	mov    ebx,DWORD PTR [ebp-0x18]
 a59:	81 e3 00 01 00 00    	and    ebx,0x100
		printf("The APIC of the %s with ID %x is located at 0x%016llx\n",
 a5f:	85 db                	test   ebx,ebx
 a61:	74 07                	je     a6a <apic_init+0x137>
 a63:	bb 28 02 00 00       	mov    ebx,0x228
 a68:	eb 05                	jmp    a6f <apic_init+0x13c>
 a6a:	bb 2c 02 00 00       	mov    ebx,0x22c
 a6f:	83 ec 0c             	sub    esp,0xc
 a72:	52                   	push   edx
 a73:	50                   	push   eax
 a74:	51                   	push   ecx
 a75:	53                   	push   ebx
 a76:	68 30 02 00 00       	push   0x230
 a7b:	e8 fc ff ff ff       	call   a7c <apic_init+0x149>
 a80:	83 c4 20             	add    esp,0x20
		/* set the destination format and logical address */
		apic_bp_reg(APIC_REG_DFR) = 0xffffffff; /* flat */
 a83:	b8 e0 00 ff ef       	mov    eax,0xefff00e0
 a88:	c7 00 ff ff ff ff    	mov    DWORD PTR [eax],0xffffffff
		apic_bp_reg(APIC_REG_LDR) = 0x01000000; /* we'll do round-robin like */
 a8e:	b8 d0 00 ff ef       	mov    eax,0xefff00d0
 a93:	c7 00 00 00 00 01    	mov    DWORD PTR [eax],0x1000000
		apic_bp_reg(APIC_REG_TASKPRIOR) = 0x00000000; /* receive any */
 a99:	b8 80 00 ff ef       	mov    eax,0xefff0080
 a9e:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
		/* post version info */
		eax = apic_bp_reg(APIC_REG_APICVER);
 aa4:	b8 30 00 ff ef       	mov    eax,0xefff0030
 aa9:	8b 00                	mov    eax,DWORD PTR [eax]
 aab:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		printf("This processors APIC's version is %02xh (%s) which has "
			   "support for %u LVT entries%s.", eax & 0xff, ((eax & 0xff) < 0x10)
			   ? "external 82489DX APIC" : "integrated APIC", 1 + ((eax >> 16) & 0xff),
               (eax & 0x01000000) ? " and for EOI-broadcast suppression" : "");
 aae:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 ab1:	25 00 00 00 01       	and    eax,0x1000000
		printf("This processors APIC's version is %02xh (%s) which has "
 ab6:	85 c0                	test   eax,eax
 ab8:	74 07                	je     ac1 <apic_init+0x18e>
 aba:	bb 68 02 00 00       	mov    ebx,0x268
 abf:	eb 05                	jmp    ac6 <apic_init+0x193>
 ac1:	bb 8b 02 00 00       	mov    ebx,0x28b
			   ? "external 82489DX APIC" : "integrated APIC", 1 + ((eax >> 16) & 0xff),
 ac6:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 ac9:	c1 e8 10             	shr    eax,0x10
 acc:	0f b6 c0             	movzx  eax,al
		printf("This processors APIC's version is %02xh (%s) which has "
 acf:	8d 50 01             	lea    edx,[eax+0x1]
			   "support for %u LVT entries%s.", eax & 0xff, ((eax & 0xff) < 0x10)
 ad2:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 ad5:	25 f0 00 00 00       	and    eax,0xf0
		printf("This processors APIC's version is %02xh (%s) which has "
 ada:	85 c0                	test   eax,eax
 adc:	75 07                	jne    ae5 <apic_init+0x1b2>
 ade:	b9 8c 02 00 00       	mov    ecx,0x28c
 ae3:	eb 05                	jmp    aea <apic_init+0x1b7>
 ae5:	b9 a2 02 00 00       	mov    ecx,0x2a2
 aea:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 aed:	0f b6 c0             	movzx  eax,al
 af0:	83 ec 0c             	sub    esp,0xc
 af3:	53                   	push   ebx
 af4:	52                   	push   edx
 af5:	51                   	push   ecx
 af6:	50                   	push   eax
 af7:	68 b4 02 00 00       	push   0x2b4
 afc:	e8 fc ff ff ff       	call   afd <apic_init+0x1ca>
 b01:	83 c4 20             	add    esp,0x20
		/* and the initial configuration */
		printf("The registers are configured as follows:\n");
 b04:	83 ec 0c             	sub    esp,0xc
 b07:	68 24 01 00 00       	push   0x124
 b0c:	e8 fc ff ff ff       	call   b0d <apic_init+0x1da>
 b11:	83 c4 10             	add    esp,0x10
		printf("spurious:  %08x\n", apic_bp_reg(APIC_REG_SPURIOUS));
 b14:	b8 f0 00 ff ef       	mov    eax,0xefff00f0
 b19:	8b 00                	mov    eax,DWORD PTR [eax]
 b1b:	83 ec 08             	sub    esp,0x8
 b1e:	50                   	push   eax
 b1f:	68 4e 01 00 00       	push   0x14e
 b24:	e8 fc ff ff ff       	call   b25 <apic_init+0x1f2>
 b29:	83 c4 10             	add    esp,0x10
		printf("error:     %08x\n", apic_bp_reg(APIC_REG_ESR));
 b2c:	b8 80 02 ff ef       	mov    eax,0xefff0280
 b31:	8b 00                	mov    eax,DWORD PTR [eax]
 b33:	83 ec 08             	sub    esp,0x8
 b36:	50                   	push   eax
 b37:	68 5f 01 00 00       	push   0x15f
 b3c:	e8 fc ff ff ff       	call   b3d <apic_init+0x20a>
 b41:	83 c4 10             	add    esp,0x10
		printf("LVT timer: %08x\n", apic_bp_reg(APIC_REG_LVT_TMR));
 b44:	b8 20 03 ff ef       	mov    eax,0xefff0320
 b49:	8b 00                	mov    eax,DWORD PTR [eax]
 b4b:	83 ec 08             	sub    esp,0x8
 b4e:	50                   	push   eax
 b4f:	68 70 01 00 00       	push   0x170
 b54:	e8 fc ff ff ff       	call   b55 <apic_init+0x222>
 b59:	83 c4 10             	add    esp,0x10
		printf("LVT therm: %08x\n", apic_bp_reg(APIC_REG_LVT_THERM));
 b5c:	b8 30 03 ff ef       	mov    eax,0xefff0330
 b61:	8b 00                	mov    eax,DWORD PTR [eax]
 b63:	83 ec 08             	sub    esp,0x8
 b66:	50                   	push   eax
 b67:	68 81 01 00 00       	push   0x181
 b6c:	e8 fc ff ff ff       	call   b6d <apic_init+0x23a>
 b71:	83 c4 10             	add    esp,0x10
		printf("LVT perf:  %08x\n", apic_bp_reg(APIC_REG_LVT_PERF));
 b74:	b8 40 03 ff ef       	mov    eax,0xefff0340
 b79:	8b 00                	mov    eax,DWORD PTR [eax]
 b7b:	83 ec 08             	sub    esp,0x8
 b7e:	50                   	push   eax
 b7f:	68 92 01 00 00       	push   0x192
 b84:	e8 fc ff ff ff       	call   b85 <apic_init+0x252>
 b89:	83 c4 10             	add    esp,0x10
		printf("LVT LINT0: %08x\n", apic_bp_reg(APIC_REG_LVT_LINT0));
 b8c:	b8 50 03 ff ef       	mov    eax,0xefff0350
 b91:	8b 00                	mov    eax,DWORD PTR [eax]
 b93:	83 ec 08             	sub    esp,0x8
 b96:	50                   	push   eax
 b97:	68 a3 01 00 00       	push   0x1a3
 b9c:	e8 fc ff ff ff       	call   b9d <apic_init+0x26a>
 ba1:	83 c4 10             	add    esp,0x10
		printf("LVT LINT1: %08x\n", apic_bp_reg(APIC_REG_LVT_LINT1));
 ba4:	b8 60 03 ff ef       	mov    eax,0xefff0360
 ba9:	8b 00                	mov    eax,DWORD PTR [eax]
 bab:	83 ec 08             	sub    esp,0x8
 bae:	50                   	push   eax
 baf:	68 b4 01 00 00       	push   0x1b4
 bb4:	e8 fc ff ff ff       	call   bb5 <apic_init+0x282>
 bb9:	83 c4 10             	add    esp,0x10
		printf("LVT error: %08x\n", apic_bp_reg(APIC_REG_LVT_ERR));
 bbc:	b8 70 03 ff ef       	mov    eax,0xefff0370
 bc1:	8b 00                	mov    eax,DWORD PTR [eax]
 bc3:	83 ec 08             	sub    esp,0x8
 bc6:	50                   	push   eax
 bc7:	68 c5 01 00 00       	push   0x1c5
 bcc:	e8 fc ff ff ff       	call   bcd <apic_init+0x29a>
 bd1:	83 c4 10             	add    esp,0x10
		/* now install the handlers */
		apic_bp_reg(APIC_REG_SPURIOUS) = (apic_bp_reg(APIC_REG_SPURIOUS) & 0xffffff00) + 0x3f;
 bd4:	b8 f0 00 ff ef       	mov    eax,0xefff00f0
 bd9:	8b 00                	mov    eax,DWORD PTR [eax]
 bdb:	b0 00                	mov    al,0x0
 bdd:	ba f0 00 ff ef       	mov    edx,0xefff00f0
 be2:	83 c0 3f             	add    eax,0x3f
 be5:	89 02                	mov    DWORD PTR [edx],eax
		apic_bp_reg(APIC_REG_LVT_ERR) = 0x3c; /* 0 | 3c */
 be7:	b8 70 03 ff ef       	mov    eax,0xefff0370
 bec:	c7 00 3c 00 00 00    	mov    DWORD PTR [eax],0x3c
		/* arm the error register */
		apic_bp_reg(APIC_REG_ESR) = 0;
 bf2:	b8 80 02 ff ef       	mov    eax,0xefff0280
 bf7:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0

		/* do the apic timer init */
		extern void apic_timer_setup();
		apic_timer_setup();
 bfd:	e8 fc ff ff ff       	call   bfe <apic_init+0x2cb>
		apic_initialized = 1;
 c02:	c7 05 00 00 00 00 01 00 00 00 	mov    DWORD PTR ds:0x0,0x1

		/* (always) do MP init */
		void mp_entry();
		mp_entry();
 c0c:	e8 fc ff ff ff       	call   c0d <apic_init+0x2da>
		/* send self-IPI (only shorthand, i.e. lower reg) */
//		do { /*4c*/
//				apic_reg(APIC_REG_ICRL) = 0x00044000 | 50; /* level, edge */
//				for (size_t i = 0; i < 0x0f000000; i++);
//		} while (0);
}
 c11:	90                   	nop
 c12:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
 c15:	c9                   	leave
 c16:	c3                   	ret
