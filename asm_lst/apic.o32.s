
apic.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <per_cpu_ptr>:
						uint32_t st;
						st = ioapic_read(i, 0x10 + 2 * j);
						if (st & (1 << 12)) /* DS=pending */
								pin |= (1 << j);
				}
				printf("IOAPIC%u: %08x\n", i, pin);
   0:	55                   	push   ebp
   1:	89 e5                	mov    ebp,esp
   3:	83 ec 10             	sub    esp,0x10
		}
}

/**********  Local APIC configuration including IPIs  ********************/
void ap_apic_init()
   6:	64 a1 00 00 00 00    	mov    eax,fs:0x0
   c:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
{
		/* TODO use regular init as APIC MMIO memory is global */
   f:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
		/* we're using iprintf to avoid needless waiting */
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
 162:	83 ec 70             	sub    esp,0x70
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
 198:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
 19c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 19f:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 1a3:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 1aa:	e8 fc ff ff ff       	call   1ab <init_ioapic+0x4e>
		for (size_t i = 0; i < 16; i++)
 1af:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
 1b6:	eb 34                	jmp    1ec <init_ioapic+0x8f>
				if (ioapic_mappings[i].page == page) {
 1b8:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 1bb:	c1 e0 04             	shl    eax,0x4
 1be:	05 00 00 00 00       	add    eax,0x0
 1c3:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
 1c6:	8b 00                	mov    eax,DWORD PTR [eax]
 1c8:	89 c1                	mov    ecx,eax
 1ca:	89 c8                	mov    eax,ecx
 1cc:	33 45 d8             	xor    eax,DWORD PTR [ebp-0x28]
 1cf:	33 55 dc             	xor    edx,DWORD PTR [ebp-0x24]
 1d2:	09 d0                	or     eax,edx
 1d4:	75 12                	jne    1e8 <init_ioapic+0x8b>
						vmem = ioapic_mappings[i].ptr_base;
 1d6:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 1d9:	c1 e0 04             	shl    eax,0x4
 1dc:	05 08 00 00 00       	add    eax,0x8
 1e1:	8b 00                	mov    eax,DWORD PTR [eax]
 1e3:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						break;
 1e6:	eb 0a                	jmp    1f2 <init_ioapic+0x95>
		for (size_t i = 0; i < 16; i++)
 1e8:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
 1ec:	83 7d f0 0f          	cmp    DWORD PTR [ebp-0x10],0xf
 1f0:	76 c6                	jbe    1b8 <init_ioapic+0x5b>
		if (!vmem) {
 1f2:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
 1f6:	0f 85 a2 00 00 00    	jne    29e <init_ioapic+0x141>
				vmem = bp_apic_base - 4096;
 1fc:	a1 00 00 00 00       	mov    eax,ds:0x0
 201:	2d 00 10 00 00       	sub    eax,0x1000
 206:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				pr.base = page; pr.count = 1;
 209:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 20c:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
 20f:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
 212:	89 55 c8             	mov    DWORD PTR [ebp-0x38],edx
 215:	c7 45 cc 01 00 00 00 	mov    DWORD PTR [ebp-0x34],0x1
				vmem = mm_map(&mm_kernel, bp_apic_base - 4096, &pr, 1,
 21c:	a1 00 00 00 00       	mov    eax,ds:0x0
 221:	8d 90 00 f0 ff ff    	lea    edx,[eax-0x1000]
 227:	c7 44 24 10 2d 00 00 00 	mov    DWORD PTR [esp+0x10],0x2d
 22f:	c7 44 24 0c 01 00 00 00 	mov    DWORD PTR [esp+0xc],0x1
 237:	8d 45 c4             	lea    eax,[ebp-0x3c]
 23a:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
 23e:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
 242:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 249:	e8 fc ff ff ff       	call   24a <init_ioapic+0xed>
 24e:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				if (!vmem) {
 251:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
 255:	75 29                	jne    280 <init_ioapic+0x123>
						die("unable to map I/O APIC.\n");
 257:	c7 44 24 04 07 00 00 00 	mov    DWORD PTR [esp+0x4],0x7
 25f:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
 266:	e8 fc ff ff ff       	call   267 <init_ioapic+0x10a>
 26b:	e8 fc ff ff ff       	call   26c <init_ioapic+0x10f>
 270:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 277:	e8 fc ff ff ff       	call   278 <init_ioapic+0x11b>
 27c:	fa                   	cli
 27d:	f4                   	hlt
 27e:	eb fd                	jmp    27d <init_ioapic+0x120>
				} else if (vmem == bp_apic_base - 4096)
 280:	a1 00 00 00 00       	mov    eax,ds:0x0
 285:	2d 00 10 00 00       	sub    eax,0x1000
 28a:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
 28d:	75 0f                	jne    29e <init_ioapic+0x141>
						bp_apic_base -= 4096;
 28f:	a1 00 00 00 00       	mov    eax,ds:0x0
 294:	2d 00 10 00 00       	sub    eax,0x1000
 299:	a3 00 00 00 00       	mov    ds:0x0,eax
		if (id < 16) {
 29e:	80 7d b4 0f          	cmp    BYTE PTR [ebp-0x4c],0xf
 2a2:	0f 87 0b 01 00 00    	ja     3b3 <init_ioapic+0x256>
				ioapic_mappings[id].page = page;
 2a8:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 2ac:	c1 e0 04             	shl    eax,0x4
 2af:	8d 88 00 00 00 00    	lea    ecx,[eax+0x0]
 2b5:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 2b8:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
 2bb:	89 01                	mov    DWORD PTR [ecx],eax
 2bd:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
				ioapic_mappings[id].ptr_base = vmem;
 2c0:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 2c4:	c1 e0 04             	shl    eax,0x4
 2c7:	8d 90 08 00 00 00    	lea    edx,[eax+0x8]
 2cd:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 2d0:	89 02                	mov    DWORD PTR [edx],eax
				ioapic_mappings[id].ptr_ofs = ofs;
 2d2:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 2d6:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
 2d9:	c1 e0 04             	shl    eax,0x4
 2dc:	05 0c 00 00 00       	add    eax,0xc
 2e1:	66 89 10             	mov    WORD PTR [eax],dx
				vmem += ofs;
 2e4:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 2e7:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
		printf("reg1: %08x\n", ioapic_read(id, 0));
 2ea:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 2ee:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
 2f6:	89 04 24             	mov    DWORD PTR [esp],eax
 2f9:	e8 fc ff ff ff       	call   2fa <init_ioapic+0x19d>
 2fe:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 302:	c7 04 24 43 00 00 00 	mov    DWORD PTR [esp],0x43
 309:	e8 fc ff ff ff       	call   30a <init_ioapic+0x1ad>
		printf("reg2: %08x\n", ioapic_read(id, 1));
 30e:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 312:	c7 44 24 04 01 00 00 00 	mov    DWORD PTR [esp+0x4],0x1
 31a:	89 04 24             	mov    DWORD PTR [esp],eax
 31d:	e8 fc ff ff ff       	call   31e <init_ioapic+0x1c1>
 322:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 326:	c7 04 24 4f 00 00 00 	mov    DWORD PTR [esp],0x4f
 32d:	e8 fc ff ff ff       	call   32e <init_ioapic+0x1d1>
		printf("reg3: %08x\n", ioapic_read(id, 2));
 332:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 336:	c7 44 24 04 02 00 00 00 	mov    DWORD PTR [esp+0x4],0x2
 33e:	89 04 24             	mov    DWORD PTR [esp],eax
 341:	e8 fc ff ff ff       	call   342 <init_ioapic+0x1e5>
 346:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 34a:	c7 04 24 5b 00 00 00 	mov    DWORD PTR [esp],0x5b
 351:	e8 fc ff ff ff       	call   352 <init_ioapic+0x1f5>
		ioapic_mappings[id].max_pin = (ioapic_read(id, 1) >> 16) & 0xff;
 356:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 35a:	c7 44 24 04 01 00 00 00 	mov    DWORD PTR [esp+0x4],0x1
 362:	89 04 24             	mov    DWORD PTR [esp],eax
 365:	e8 fc ff ff ff       	call   366 <init_ioapic+0x209>
 36a:	c1 e8 10             	shr    eax,0x10
 36d:	89 c2                	mov    edx,eax
 36f:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 373:	c1 e0 04             	shl    eax,0x4
 376:	05 0e 00 00 00       	add    eax,0xe
 37b:	88 10                	mov    BYTE PTR [eax],dl
		ioapic_mappings[id].real_id = (ioapic_read(id, 0) >> 24) & 0x0f;
 37d:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 381:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
 389:	89 04 24             	mov    DWORD PTR [esp],eax
 38c:	e8 fc ff ff ff       	call   38d <init_ioapic+0x230>
 391:	c1 e8 18             	shr    eax,0x18
 394:	89 c2                	mov    edx,eax
 396:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 39a:	83 e2 0f             	and    edx,0xf
 39d:	c1 e0 04             	shl    eax,0x4
 3a0:	05 0f 00 00 00       	add    eax,0xf
 3a5:	88 10                	mov    BYTE PTR [eax],dl
		for (int i = 16; i < ioapic_mappings[id].max_pin + 1; i++) {
 3a7:	c7 45 ec 10 00 00 00 	mov    DWORD PTR [ebp-0x14],0x10
 3ae:	e9 8e 00 00 00       	jmp    441 <init_ioapic+0x2e4>
				die("I/O APIC ID larger than 15 found!\n");
 3b3:	c7 44 24 04 20 00 00 00 	mov    DWORD PTR [esp+0x4],0x20
 3bb:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
 3c2:	e8 fc ff ff ff       	call   3c3 <init_ioapic+0x266>
 3c7:	e8 fc ff ff ff       	call   3c8 <init_ioapic+0x26b>
 3cc:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 3d3:	e8 fc ff ff ff       	call   3d4 <init_ioapic+0x277>
 3d8:	fa                   	cli
 3d9:	f4                   	hlt
 3da:	eb fd                	jmp    3d9 <init_ioapic+0x27c>
				ioapic_write(id, 0x11 + i * 2, 0x00000000);
 3dc:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 3df:	01 c0                	add    eax,eax
 3e1:	83 c0 11             	add    eax,0x11
 3e4:	0f b6 d0             	movzx  edx,al
 3e7:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 3eb:	c7 44 24 08 00 00 00 00 	mov    DWORD PTR [esp+0x8],0x0
 3f3:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
 3f7:	89 04 24             	mov    DWORD PTR [esp],eax
 3fa:	e8 fc ff ff ff       	call   3fb <init_ioapic+0x29e>
						| (40 + (i - 16) % 8)); /* 40-47 (round-robin if more) */
 3ff:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 402:	8d 50 f0             	lea    edx,[eax-0x10]
 405:	89 d0                	mov    eax,edx
 407:	c1 f8 1f             	sar    eax,0x1f
 40a:	c1 e8 1d             	shr    eax,0x1d
 40d:	01 c2                	add    edx,eax
 40f:	83 e2 07             	and    edx,0x7
 412:	29 c2                	sub    edx,eax
 414:	89 d0                	mov    eax,edx
 416:	83 c0 28             	add    eax,0x28
 419:	80 cc a0             	or     ah,0xa0
				ioapic_write(id, 0x10 + i * 2, 0x0000a000 /* a=lvl low; 0=phys,fixed */
 41c:	89 c1                	mov    ecx,eax
 41e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 421:	83 c0 08             	add    eax,0x8
 424:	01 c0                	add    eax,eax
 426:	0f b6 d0             	movzx  edx,al
 429:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 42d:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
 431:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
 435:	89 04 24             	mov    DWORD PTR [esp],eax
 438:	e8 fc ff ff ff       	call   439 <init_ioapic+0x2dc>
		for (int i = 16; i < ioapic_mappings[id].max_pin + 1; i++) {
 43d:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
 441:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 445:	c1 e0 04             	shl    eax,0x4
 448:	05 0e 00 00 00       	add    eax,0xe
 44d:	0f b6 00             	movzx  eax,BYTE PTR [eax]
 450:	0f b6 c0             	movzx  eax,al
 453:	39 45 ec             	cmp    DWORD PTR [ebp-0x14],eax
 456:	7e 84                	jle    3dc <init_ioapic+0x27f>
				ioapic_mappings[id].max_pin + 1);
 458:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 45c:	c1 e0 04             	shl    eax,0x4
 45f:	05 0e 00 00 00       	add    eax,0xe
 464:	0f b6 00             	movzx  eax,BYTE PTR [eax]
 467:	0f b6 c0             	movzx  eax,al
		printf("I/O APIC with ID %x (%d pins):\n", ioapic_mappings[id].real_id,
 46a:	8d 50 01             	lea    edx,[eax+0x1]
 46d:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 471:	c1 e0 04             	shl    eax,0x4
 474:	05 0f 00 00 00       	add    eax,0xf
 479:	0f b6 00             	movzx  eax,BYTE PTR [eax]
 47c:	0f b6 c0             	movzx  eax,al
 47f:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
 483:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 487:	c7 04 24 68 00 00 00 	mov    DWORD PTR [esp],0x68
 48e:	e8 fc ff ff ff       	call   48f <init_ioapic+0x332>
		for (int i = 0; i < ioapic_mappings[id].max_pin + 1; i++) {
 493:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
 49a:	eb 75                	jmp    511 <init_ioapic+0x3b4>
				uint64_t dat = ioapic_read(id, 0x10 + i * 2) | ((uint64_t)
 49c:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 49f:	83 c0 08             	add    eax,0x8
 4a2:	01 c0                	add    eax,eax
 4a4:	0f b6 d0             	movzx  edx,al
 4a7:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 4ab:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
 4af:	89 04 24             	mov    DWORD PTR [esp],eax
 4b2:	e8 fc ff ff ff       	call   4b3 <init_ioapic+0x356>
 4b7:	89 c6                	mov    esi,eax
 4b9:	bf 00 00 00 00       	mov    edi,0x0
						ioapic_read(id, 0x11 + i * 2) << 32);
 4be:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 4c1:	01 c0                	add    eax,eax
 4c3:	83 c0 11             	add    eax,0x11
 4c6:	0f b6 d0             	movzx  edx,al
 4c9:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 4cd:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
 4d1:	89 04 24             	mov    DWORD PTR [esp],eax
 4d4:	e8 fc ff ff ff       	call   4d5 <init_ioapic+0x378>
				uint64_t dat = ioapic_read(id, 0x10 + i * 2) | ((uint64_t)
 4d9:	ba 00 00 00 00       	mov    edx,0x0
						ioapic_read(id, 0x11 + i * 2) << 32);
 4de:	89 c2                	mov    edx,eax
 4e0:	31 c0                	xor    eax,eax
				uint64_t dat = ioapic_read(id, 0x10 + i * 2) | ((uint64_t)
 4e2:	09 f0                	or     eax,esi
 4e4:	09 fa                	or     edx,edi
 4e6:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
 4e9:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
				printf("REDTBL%-3d %016llx\n", i, dat);
 4ec:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 4ef:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
 4f2:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
 4f6:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
 4fa:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 4fd:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 501:	c7 04 24 88 00 00 00 	mov    DWORD PTR [esp],0x88
 508:	e8 fc ff ff ff       	call   509 <init_ioapic+0x3ac>
		for (int i = 0; i < ioapic_mappings[id].max_pin + 1; i++) {
 50d:	83 45 e8 01          	add    DWORD PTR [ebp-0x18],0x1
 511:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
 515:	c1 e0 04             	shl    eax,0x4
 518:	05 0e 00 00 00       	add    eax,0xe
 51d:	0f b6 00             	movzx  eax,BYTE PTR [eax]
 520:	0f b6 c0             	movzx  eax,al
 523:	39 45 e8             	cmp    DWORD PTR [ebp-0x18],eax
 526:	0f 8e 70 ff ff ff    	jle    49c <init_ioapic+0x33f>
		printf("\n");
 52c:	c7 04 24 9c 00 00 00 	mov    DWORD PTR [esp],0x9c
 533:	e8 fc ff ff ff       	call   534 <init_ioapic+0x3d7>
}
 538:	90                   	nop
 539:	83 c4 70             	add    esp,0x70
 53c:	5e                   	pop    esi
 53d:	5f                   	pop    edi
 53e:	5d                   	pop    ebp
 53f:	c3                   	ret

00000540 <ioapic_print_is>:
{
 540:	55                   	push   ebp
 541:	89 e5                	mov    ebp,esp
 543:	83 ec 28             	sub    esp,0x28
		for (int i = 0; i < 16; i++) {
 546:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
 54d:	e9 99 00 00 00       	jmp    5eb <ioapic_print_is+0xab>
				uint32_t pin = 0;
 552:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
				if (!ioapic_mappings[i].ptr_base)
 559:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 55c:	c1 e0 04             	shl    eax,0x4
 55f:	05 08 00 00 00       	add    eax,0x8
 564:	8b 00                	mov    eax,DWORD PTR [eax]
 566:	85 c0                	test   eax,eax
 568:	74 7c                	je     5e6 <ioapic_print_is+0xa6>
				for (int j = 0; j < ioapic_mappings[i].max_pin + 1; j++) {
 56a:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
 571:	eb 41                	jmp    5b4 <ioapic_print_is+0x74>
						st = ioapic_read(i, 0x10 + 2 * j);
 573:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 576:	83 c0 08             	add    eax,0x8
 579:	01 c0                	add    eax,eax
 57b:	0f b6 d0             	movzx  edx,al
 57e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 581:	0f b6 c0             	movzx  eax,al
 584:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
 588:	89 04 24             	mov    DWORD PTR [esp],eax
 58b:	e8 fc ff ff ff       	call   58c <ioapic_print_is+0x4c>
 590:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
						if (st & (1 << 12)) /* DS=pending */
 593:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 596:	25 00 10 00 00       	and    eax,0x1000
 59b:	85 c0                	test   eax,eax
 59d:	74 11                	je     5b0 <ioapic_print_is+0x70>
								pin |= (1 << j);
 59f:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 5a2:	ba 01 00 00 00       	mov    edx,0x1
 5a7:	89 c1                	mov    ecx,eax
 5a9:	d3 e2                	shl    edx,cl
 5ab:	89 d0                	mov    eax,edx
 5ad:	09 45 f0             	or     DWORD PTR [ebp-0x10],eax
				for (int j = 0; j < ioapic_mappings[i].max_pin + 1; j++) {
 5b0:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
 5b4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 5b7:	c1 e0 04             	shl    eax,0x4
 5ba:	05 0e 00 00 00       	add    eax,0xe
 5bf:	0f b6 00             	movzx  eax,BYTE PTR [eax]
 5c2:	0f b6 c0             	movzx  eax,al
 5c5:	39 45 ec             	cmp    DWORD PTR [ebp-0x14],eax
 5c8:	7e a9                	jle    573 <ioapic_print_is+0x33>
				printf("IOAPIC%u: %08x\n", i, pin);
 5ca:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
 5cd:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
 5d1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 5d4:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 5d8:	c7 04 24 9e 00 00 00 	mov    DWORD PTR [esp],0x9e
 5df:	e8 fc ff ff ff       	call   5e0 <ioapic_print_is+0xa0>
 5e4:	eb 01                	jmp    5e7 <ioapic_print_is+0xa7>
						continue;
 5e6:	90                   	nop
		for (int i = 0; i < 16; i++) {
 5e7:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
 5eb:	83 7d f4 0f          	cmp    DWORD PTR [ebp-0xc],0xf
 5ef:	0f 8e 5d ff ff ff    	jle    552 <ioapic_print_is+0x12>
}
 5f5:	90                   	nop
 5f6:	90                   	nop
 5f7:	c9                   	leave
 5f8:	c3                   	ret

000005f9 <ap_apic_init>:
{
 5f9:	55                   	push   ebp
 5fa:	89 e5                	mov    ebp,esp
 5fc:	56                   	push   esi
 5fd:	53                   	push   ebx
 5fe:	83 ec 40             	sub    esp,0x40
		struct page_range pr = {0,1};
 601:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
 608:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
 60f:	c7 45 f4 01 00 00 00 	mov    DWORD PTR [ebp-0xc],0x1
		uint32_t eax, edx;
		cpu_get_msr(APIC_BASE_MSR, &eax, &edx);
 616:	8d 45 e4             	lea    eax,[ebp-0x1c]
 619:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
 61d:	8d 45 e8             	lea    eax,[ebp-0x18]
 620:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 624:	c7 04 24 1b 00 00 00 	mov    DWORD PTR [esp],0x1b
 62b:	e8 fc ff ff ff       	call   62c <ap_apic_init+0x33>
		pr.base = ((uint64_t)(edx & 0x0f)) << 32 | (eax & 0xfffff000);
 630:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 633:	ba 00 00 00 00       	mov    edx,0x0
 638:	89 c2                	mov    edx,eax
 63a:	31 c0                	xor    eax,eax
 63c:	b8 00 00 00 00       	mov    eax,0x0
 641:	83 e2 0f             	and    edx,0xf
 644:	89 c1                	mov    ecx,eax
 646:	89 d3                	mov    ebx,edx
 648:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 64b:	ba 00 00 00 00       	mov    edx,0x0
 650:	25 00 f0 ff ff       	and    eax,0xfffff000
 655:	ba 00 00 00 00       	mov    edx,0x0
 65a:	09 c8                	or     eax,ecx
 65c:	09 da                	or     edx,ebx
 65e:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
 661:	89 55 f0             	mov    DWORD PTR [ebp-0x10],edx
		iprintf("msr: %08x%08x\n", edx, eax);
 664:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
 667:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 66a:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
 66e:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 672:	c7 04 24 ae 00 00 00 	mov    DWORD PTR [esp],0xae
 679:	e8 fc ff ff ff       	call   67a <ap_apic_init+0x81>
		/* ensure PM location */
		if (!pr.base)
 67e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 681:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
 684:	89 c1                	mov    ecx,eax
 686:	89 c8                	mov    eax,ecx
 688:	09 d0                	or     eax,edx
 68a:	75 29                	jne    6b5 <ap_apic_init+0xbc>
				die("APIC has no PM location assigned. TODO: write PM MMIO address allocator.\n");
 68c:	c7 44 24 04 c0 00 00 00 	mov    DWORD PTR [esp+0x4],0xc0
 694:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
 69b:	e8 fc ff ff ff       	call   69c <ap_apic_init+0xa3>
 6a0:	e8 fc ff ff ff       	call   6a1 <ap_apic_init+0xa8>
 6a5:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 6ac:	e8 fc ff ff ff       	call   6ad <ap_apic_init+0xb4>
 6b1:	fa                   	cli
 6b2:	f4                   	hlt
 6b3:	eb fd                	jmp    6b2 <ap_apic_init+0xb9>
		iprintf("AP APIC base: %016llx\n", pr.base);
 6b5:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 6b8:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
 6bb:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 6bf:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
 6c3:	c7 04 24 0a 01 00 00 	mov    DWORD PTR [esp],0x10a
 6ca:	e8 fc ff ff ff       	call   6cb <ap_apic_init+0xd2>
		if (!(eax & APIC_BASE_MSR_ENABLE)) {
 6cf:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 6d2:	25 00 08 00 00       	and    eax,0x800
 6d7:	85 c0                	test   eax,eax
 6d9:	75 31                	jne    70c <ap_apic_init+0x113>
				cpu_set_msr(APIC_BASE_MSR, (pr.base & 0xfffff000) |
					APIC_BASE_MSR_ENABLE, (pr.base >> 32) & 0x0f);
 6db:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 6de:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
 6e1:	89 d0                	mov    eax,edx
 6e3:	31 d2                	xor    edx,edx
				cpu_set_msr(APIC_BASE_MSR, (pr.base & 0xfffff000) |
 6e5:	83 e0 0f             	and    eax,0xf
 6e8:	89 c1                	mov    ecx,eax
 6ea:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 6ed:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
 6f0:	25 00 f0 ff ff       	and    eax,0xfffff000
 6f5:	80 cc 08             	or     ah,0x8
 6f8:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
 6fc:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 700:	c7 04 24 1b 00 00 00 	mov    DWORD PTR [esp],0x1b
 707:	e8 fc ff ff ff       	call   708 <ap_apic_init+0x10f>
		}
		/* keep track of the memory & map it */
		per_cpu_ptr()->apic_phys = pr.base;
 70c:	e8 ef f8 ff ff       	call   0 <per_cpu_ptr>
 711:	89 c1                	mov    ecx,eax
 713:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 716:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
 719:	89 41 0c             	mov    DWORD PTR [ecx+0xc],eax
 71c:	89 51 10             	mov    DWORD PTR [ecx+0x10],edx
		per_cpu_ptr()->apic_addr = mm_map(&mm_kernel, per_cpu_ptr()->apic_addr,
 71f:	e8 dc f8 ff ff       	call   0 <per_cpu_ptr>
 724:	8b 70 08             	mov    esi,DWORD PTR [eax+0x8]
 727:	e8 d4 f8 ff ff       	call   0 <per_cpu_ptr>
 72c:	89 c3                	mov    ebx,eax
 72e:	c7 44 24 10 2d 00 00 00 	mov    DWORD PTR [esp+0x10],0x2d
 736:	c7 44 24 0c 01 00 00 00 	mov    DWORD PTR [esp+0xc],0x1
 73e:	8d 45 ec             	lea    eax,[ebp-0x14]
 741:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
 745:	89 74 24 04          	mov    DWORD PTR [esp+0x4],esi
 749:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 750:	e8 fc ff ff ff       	call   751 <ap_apic_init+0x158>
 755:	89 43 08             	mov    DWORD PTR [ebx+0x8],eax
				&pr, 1, MMGR_MAP_MMIO | MMGR_MAP_WRITE
				| MMGR_MAP_NO_CACHING | MMGR_MAP_KERNEL);
		/* set logical dest and mode */
		apic_set_dfr(0xf); /* flat mode */
 758:	c7 04 24 0f 00 00 00 	mov    DWORD PTR [esp],0xf
 75f:	e8 fc ff ff ff       	call   760 <ap_apic_init+0x167>
		apic_set_ldr(apic_cur_log);
 764:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
 76b:	0f b6 c0             	movzx  eax,al
 76e:	89 04 24             	mov    DWORD PTR [esp],eax
 771:	e8 fc ff ff ff       	call   772 <ap_apic_init+0x179>
		apic_set_tpr(0); /* receive any intr */
 776:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 77d:	e8 fc ff ff ff       	call   77e <ap_apic_init+0x185>
		if (!(apic_cur_log <<= 1)) /* x86 rol */
 782:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
 789:	01 c0                	add    eax,eax
 78b:	a2 00 00 00 00       	mov    ds:0x0,al
 790:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
 797:	84 c0                	test   al,al
 799:	75 07                	jne    7a2 <ap_apic_init+0x1a9>
				apic_cur_log = 1;
 79b:	c6 05 00 00 00 00 01 	mov    BYTE PTR ds:0x0,0x1
		/* TODO: possibly cause TLB shootdown */
		/* now APIC_BASE points to the xAPIC memory */
		iprintf("The registers are configured as follows:\n");
 7a2:	c7 04 24 24 01 00 00 	mov    DWORD PTR [esp],0x124
 7a9:	e8 fc ff ff ff       	call   7aa <ap_apic_init+0x1b1>
		iprintf("spurious:  %08x\n", apic_reg(APIC_REG_SPURIOUS));
 7ae:	e8 4d f8 ff ff       	call   0 <per_cpu_ptr>
 7b3:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 7b6:	05 f0 00 00 00       	add    eax,0xf0
 7bb:	8b 00                	mov    eax,DWORD PTR [eax]
 7bd:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 7c1:	c7 04 24 4e 01 00 00 	mov    DWORD PTR [esp],0x14e
 7c8:	e8 fc ff ff ff       	call   7c9 <ap_apic_init+0x1d0>
		iprintf("error:     %08x\n", apic_reg(APIC_REG_ESR));
 7cd:	e8 2e f8 ff ff       	call   0 <per_cpu_ptr>
 7d2:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 7d5:	05 80 02 00 00       	add    eax,0x280
 7da:	8b 00                	mov    eax,DWORD PTR [eax]
 7dc:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 7e0:	c7 04 24 5f 01 00 00 	mov    DWORD PTR [esp],0x15f
 7e7:	e8 fc ff ff ff       	call   7e8 <ap_apic_init+0x1ef>
		iprintf("LVT timer: %08x\n", apic_reg(APIC_REG_LVT_TMR));
 7ec:	e8 0f f8 ff ff       	call   0 <per_cpu_ptr>
 7f1:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 7f4:	05 20 03 00 00       	add    eax,0x320
 7f9:	8b 00                	mov    eax,DWORD PTR [eax]
 7fb:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 7ff:	c7 04 24 70 01 00 00 	mov    DWORD PTR [esp],0x170
 806:	e8 fc ff ff ff       	call   807 <ap_apic_init+0x20e>
		iprintf("LVT therm: %08x\n", apic_reg(APIC_REG_LVT_THERM));
 80b:	e8 f0 f7 ff ff       	call   0 <per_cpu_ptr>
 810:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 813:	05 30 03 00 00       	add    eax,0x330
 818:	8b 00                	mov    eax,DWORD PTR [eax]
 81a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 81e:	c7 04 24 81 01 00 00 	mov    DWORD PTR [esp],0x181
 825:	e8 fc ff ff ff       	call   826 <ap_apic_init+0x22d>
		iprintf("LVT perf:  %08x\n", apic_reg(APIC_REG_LVT_PERF));
 82a:	e8 d1 f7 ff ff       	call   0 <per_cpu_ptr>
 82f:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 832:	05 40 03 00 00       	add    eax,0x340
 837:	8b 00                	mov    eax,DWORD PTR [eax]
 839:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 83d:	c7 04 24 92 01 00 00 	mov    DWORD PTR [esp],0x192
 844:	e8 fc ff ff ff       	call   845 <ap_apic_init+0x24c>
		iprintf("LVT LINT0: %08x\n", apic_reg(APIC_REG_LVT_LINT0));
 849:	e8 b2 f7 ff ff       	call   0 <per_cpu_ptr>
 84e:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 851:	05 50 03 00 00       	add    eax,0x350
 856:	8b 00                	mov    eax,DWORD PTR [eax]
 858:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 85c:	c7 04 24 a3 01 00 00 	mov    DWORD PTR [esp],0x1a3
 863:	e8 fc ff ff ff       	call   864 <ap_apic_init+0x26b>
		iprintf("LVT LINT1: %08x\n", apic_reg(APIC_REG_LVT_LINT1));
 868:	e8 93 f7 ff ff       	call   0 <per_cpu_ptr>
 86d:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 870:	05 60 03 00 00       	add    eax,0x360
 875:	8b 00                	mov    eax,DWORD PTR [eax]
 877:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 87b:	c7 04 24 b4 01 00 00 	mov    DWORD PTR [esp],0x1b4
 882:	e8 fc ff ff ff       	call   883 <ap_apic_init+0x28a>
		iprintf("LVT error: %08x\n", apic_reg(APIC_REG_LVT_ERR));
 887:	e8 74 f7 ff ff       	call   0 <per_cpu_ptr>
 88c:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 88f:	05 70 03 00 00       	add    eax,0x370
 894:	8b 00                	mov    eax,DWORD PTR [eax]
 896:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 89a:	c7 04 24 c5 01 00 00 	mov    DWORD PTR [esp],0x1c5
 8a1:	e8 fc ff ff ff       	call   8a2 <ap_apic_init+0x2a9>
		apic_reg(APIC_REG_SPURIOUS) = 0x00000100 | 0x3f;
 8a6:	e8 55 f7 ff ff       	call   0 <per_cpu_ptr>
 8ab:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 8ae:	05 f0 00 00 00       	add    eax,0xf0
 8b3:	c7 00 3f 01 00 00    	mov    DWORD PTR [eax],0x13f
		iprintf("spurious:  %08x\n", apic_reg(APIC_REG_SPURIOUS));
 8b9:	e8 42 f7 ff ff       	call   0 <per_cpu_ptr>
 8be:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 8c1:	05 f0 00 00 00       	add    eax,0xf0
 8c6:	8b 00                	mov    eax,DWORD PTR [eax]
 8c8:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 8cc:	c7 04 24 4e 01 00 00 	mov    DWORD PTR [esp],0x14e
 8d3:	e8 fc ff ff ff       	call   8d4 <ap_apic_init+0x2db>
		apic_reg(APIC_REG_LVT_ERR) = 0x3c; /* 0 | 3c */
 8d8:	e8 23 f7 ff ff       	call   0 <per_cpu_ptr>
 8dd:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 8e0:	05 70 03 00 00       	add    eax,0x370
 8e5:	c7 00 3c 00 00 00    	mov    DWORD PTR [eax],0x3c
		/* (val << 16): R00M=one-shot, R01M per, R11M tsc, R=res, M=mask */
		apic_reg(APIC_REG_LVT_TMR) = 0x00000000 | 0x3d; /* one-shot */
 8eb:	e8 10 f7 ff ff       	call   0 <per_cpu_ptr>
 8f0:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 8f3:	05 20 03 00 00       	add    eax,0x320
 8f8:	c7 00 3d 00 00 00    	mov    DWORD PTR [eax],0x3d
		/* mask the LINTS */
		apic_reg(APIC_REG_LVT_LINT0) = 0x00010700; /* masked extInt */
 8fe:	e8 fd f6 ff ff       	call   0 <per_cpu_ptr>
 903:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 906:	05 50 03 00 00       	add    eax,0x350
 90b:	c7 00 00 07 01 00    	mov    DWORD PTR [eax],0x10700
		apic_reg(APIC_REG_LVT_LINT1) = 0x00010400; /* masked NMI */
 911:	e8 ea f6 ff ff       	call   0 <per_cpu_ptr>
 916:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 919:	05 60 03 00 00       	add    eax,0x360
 91e:	c7 00 00 04 01 00    	mov    DWORD PTR [eax],0x10400
		/* arm the error register */
		apic_reg(APIC_REG_ESR) = 0;
 924:	e8 d7 f6 ff ff       	call   0 <per_cpu_ptr>
 929:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 92c:	05 80 02 00 00       	add    eax,0x280
 931:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
		apic_reg(APIC_REG_TMRDIV) = 0x0b; /* div=1 ; 111 */
 937:	e8 c4 f6 ff ff       	call   0 <per_cpu_ptr>
 93c:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 93f:	05 e0 03 00 00       	add    eax,0x3e0
 944:	c7 00 0b 00 00 00    	mov    DWORD PTR [eax],0xb
		apic_reg(APIC_REG_TMRINITCNT) = 0x0fffffff; /* 1.5s at 3GHz */
 94a:	e8 b1 f6 ff ff       	call   0 <per_cpu_ptr>
 94f:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
 952:	05 80 03 00 00       	add    eax,0x380
 957:	c7 00 ff ff ff 0f    	mov    DWORD PTR [eax],0xfffffff
}
 95d:	90                   	nop
 95e:	83 c4 40             	add    esp,0x40
 961:	5b                   	pop    ebx
 962:	5e                   	pop    esi
 963:	5d                   	pop    ebp
 964:	c3                   	ret

00000965 <apic_init>:

void apic_init()
{
 965:	55                   	push   ebp
 966:	89 e5                	mov    ebp,esp
 968:	53                   	push   ebx
 969:	83 ec 44             	sub    esp,0x44
		struct page_range pr = {0,1};
 96c:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
 973:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
 97a:	c7 45 f4 01 00 00 00 	mov    DWORD PTR [ebp-0xc],0x1
		uint32_t eax, edx;
		if (cpu.has_x2APIC)
 981:	0f b6 05 56 00 00 00 	movzx  eax,BYTE PTR ds:0x56
 988:	83 e0 20             	and    eax,0x20
 98b:	84 c0                	test   al,al
 98d:	74 14                	je     9a3 <apic_init+0x3e>
				cprintf(KFMT_INFO, "This CPU supports the x2APIC mode, but for "
 98f:	c7 44 24 04 d8 01 00 00 	mov    DWORD PTR [esp+0x4],0x1d8
 997:	c7 04 24 0b 00 00 00 	mov    DWORD PTR [esp],0xb
 99e:	e8 fc ff ff ff       	call   99f <apic_init+0x3a>
						"simplicity it is run in xAPIC mode.\n");
		/* find and map the APIC registers */
		cpu_get_msr(APIC_BASE_MSR, &eax, &edx);
 9a3:	8d 45 e4             	lea    eax,[ebp-0x1c]
 9a6:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
 9aa:	8d 45 e8             	lea    eax,[ebp-0x18]
 9ad:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 9b1:	c7 04 24 1b 00 00 00 	mov    DWORD PTR [esp],0x1b
 9b8:	e8 fc ff ff ff       	call   9b9 <apic_init+0x54>
		pr.base = ((uint64_t)(edx & 0x0f)) << 32 | (eax & 0xfffff000);
 9bd:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 9c0:	ba 00 00 00 00       	mov    edx,0x0
 9c5:	89 c2                	mov    edx,eax
 9c7:	31 c0                	xor    eax,eax
 9c9:	b8 00 00 00 00       	mov    eax,0x0
 9ce:	83 e2 0f             	and    edx,0xf
 9d1:	89 c1                	mov    ecx,eax
 9d3:	89 d3                	mov    ebx,edx
 9d5:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 9d8:	ba 00 00 00 00       	mov    edx,0x0
 9dd:	25 00 f0 ff ff       	and    eax,0xfffff000
 9e2:	ba 00 00 00 00       	mov    edx,0x0
 9e7:	09 c8                	or     eax,ecx
 9e9:	09 da                	or     edx,ebx
 9eb:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
 9ee:	89 55 f0             	mov    DWORD PTR [ebp-0x10],edx
		if (!pr.base) {
 9f1:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 9f4:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
 9f7:	89 c1                	mov    ecx,eax
 9f9:	89 c8                	mov    eax,ecx
 9fb:	09 d0                	or     eax,edx
 9fd:	75 13                	jne    a12 <apic_init+0xad>
				// TODO: mmgr_get_mmio_pmem();
				pr.base = apic_pm_base;
 9ff:	a1 00 00 00 00       	mov    eax,ds:0x0
 a04:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
 a0a:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
 a0d:	89 55 f0             	mov    DWORD PTR [ebp-0x10],edx
 a10:	eb 11                	jmp    a23 <apic_init+0xbe>
		} else
				apic_pm_base = pr.base;
 a12:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 a15:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
 a18:	a3 00 00 00 00       	mov    ds:0x0,eax
 a1d:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
		if (!(eax & APIC_BASE_MSR_ENABLE)) {
 a23:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 a26:	25 00 08 00 00       	and    eax,0x800
 a2b:	85 c0                	test   eax,eax
 a2d:	75 31                	jne    a60 <apic_init+0xfb>
				cpu_set_msr(APIC_BASE_MSR, (pr.base & 0xfffff000) |
					APIC_BASE_MSR_ENABLE, (pr.base >> 32) & 0x0f);
 a2f:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 a32:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
 a35:	89 d0                	mov    eax,edx
 a37:	31 d2                	xor    edx,edx
				cpu_set_msr(APIC_BASE_MSR, (pr.base & 0xfffff000) |
 a39:	83 e0 0f             	and    eax,0xf
 a3c:	89 c1                	mov    ecx,eax
 a3e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 a41:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
 a44:	25 00 f0 ff ff       	and    eax,0xfffff000
 a49:	80 cc 08             	or     ah,0x8
 a4c:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
 a50:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 a54:	c7 04 24 1b 00 00 00 	mov    DWORD PTR [esp],0x1b
 a5b:	e8 fc ff ff ff       	call   a5c <apic_init+0xf7>
		}
		mm_map(&mm_kernel, bp_apic_base, &pr, 1, MMGR_MAP_MMIO | MMGR_MAP_WRITE
 a60:	a1 00 00 00 00       	mov    eax,ds:0x0
 a65:	c7 44 24 10 2d 00 00 00 	mov    DWORD PTR [esp+0x10],0x2d
 a6d:	c7 44 24 0c 01 00 00 00 	mov    DWORD PTR [esp+0xc],0x1
 a75:	8d 55 ec             	lea    edx,[ebp-0x14]
 a78:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
 a7c:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 a80:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 a87:	e8 fc ff ff ff       	call   a88 <apic_init+0x123>
			| MMGR_MAP_NO_CACHING | MMGR_MAP_KERNEL);
		/* now access them */
		edx = apic_bp_reg(APIC_REG_APICID);
 a8c:	b8 20 00 ff ef       	mov    eax,0xefff0020
 a91:	8b 00                	mov    eax,DWORD PTR [eax]
 a93:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		printf("The APIC of the %s with ID %x is located at 0x%016llx\n",
 a96:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 a99:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
 a9c:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
 a9f:	c1 e9 18             	shr    ecx,0x18
			(eax & APIC_BASE_MSR_BSP) ? "BSP" : "AP", edx >> 24, pr.base);
 aa2:	8b 5d e8             	mov    ebx,DWORD PTR [ebp-0x18]
 aa5:	81 e3 00 01 00 00    	and    ebx,0x100
		printf("The APIC of the %s with ID %x is located at 0x%016llx\n",
 aab:	85 db                	test   ebx,ebx
 aad:	74 07                	je     ab6 <apic_init+0x151>
 aaf:	bb 28 02 00 00       	mov    ebx,0x228
 ab4:	eb 05                	jmp    abb <apic_init+0x156>
 ab6:	bb 2c 02 00 00       	mov    ebx,0x22c
 abb:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
 abf:	89 54 24 10          	mov    DWORD PTR [esp+0x10],edx
 ac3:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
 ac7:	89 5c 24 04          	mov    DWORD PTR [esp+0x4],ebx
 acb:	c7 04 24 30 02 00 00 	mov    DWORD PTR [esp],0x230
 ad2:	e8 fc ff ff ff       	call   ad3 <apic_init+0x16e>
		/* set the destination format and logical address */
		apic_bp_reg(APIC_REG_DFR) = 0xffffffff; /* flat */
 ad7:	b8 e0 00 ff ef       	mov    eax,0xefff00e0
 adc:	c7 00 ff ff ff ff    	mov    DWORD PTR [eax],0xffffffff
		apic_bp_reg(APIC_REG_LDR) = 0x01000000; /* we'll do round-robin like */
 ae2:	b8 d0 00 ff ef       	mov    eax,0xefff00d0
 ae7:	c7 00 00 00 00 01    	mov    DWORD PTR [eax],0x1000000
		apic_bp_reg(APIC_REG_TASKPRIOR) = 0x00000000; /* receive any */
 aed:	b8 80 00 ff ef       	mov    eax,0xefff0080
 af2:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
		/* post version info */
		eax = apic_bp_reg(APIC_REG_APICVER);
 af8:	b8 30 00 ff ef       	mov    eax,0xefff0030
 afd:	8b 00                	mov    eax,DWORD PTR [eax]
 aff:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		printf("This processors APIC's version is %02xh (%s) which has "
			   "support for %u LVT entries%s.", eax & 0xff, ((eax & 0xff) < 0x10)
			   ? "external 82489DX APIC" : "integrated APIC", 1 + ((eax >> 16) & 0xff),
               (eax & 0x01000000) ? " and for EOI-broadcast suppression" : "");
 b02:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 b05:	25 00 00 00 01       	and    eax,0x1000000
		printf("This processors APIC's version is %02xh (%s) which has "
 b0a:	85 c0                	test   eax,eax
 b0c:	74 07                	je     b15 <apic_init+0x1b0>
 b0e:	bb 68 02 00 00       	mov    ebx,0x268
 b13:	eb 05                	jmp    b1a <apic_init+0x1b5>
 b15:	bb 8b 02 00 00       	mov    ebx,0x28b
			   ? "external 82489DX APIC" : "integrated APIC", 1 + ((eax >> 16) & 0xff),
 b1a:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 b1d:	c1 e8 10             	shr    eax,0x10
 b20:	0f b6 c0             	movzx  eax,al
		printf("This processors APIC's version is %02xh (%s) which has "
 b23:	8d 50 01             	lea    edx,[eax+0x1]
			   "support for %u LVT entries%s.", eax & 0xff, ((eax & 0xff) < 0x10)
 b26:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 b29:	25 f0 00 00 00       	and    eax,0xf0
		printf("This processors APIC's version is %02xh (%s) which has "
 b2e:	85 c0                	test   eax,eax
 b30:	75 07                	jne    b39 <apic_init+0x1d4>
 b32:	b9 8c 02 00 00       	mov    ecx,0x28c
 b37:	eb 05                	jmp    b3e <apic_init+0x1d9>
 b39:	b9 a2 02 00 00       	mov    ecx,0x2a2
 b3e:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 b41:	0f b6 c0             	movzx  eax,al
 b44:	89 5c 24 10          	mov    DWORD PTR [esp+0x10],ebx
 b48:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
 b4c:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
 b50:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 b54:	c7 04 24 b4 02 00 00 	mov    DWORD PTR [esp],0x2b4
 b5b:	e8 fc ff ff ff       	call   b5c <apic_init+0x1f7>
		/* and the initial configuration */
		printf("The registers are configured as follows:\n");
 b60:	c7 04 24 24 01 00 00 	mov    DWORD PTR [esp],0x124
 b67:	e8 fc ff ff ff       	call   b68 <apic_init+0x203>
		printf("spurious:  %08x\n", apic_bp_reg(APIC_REG_SPURIOUS));
 b6c:	b8 f0 00 ff ef       	mov    eax,0xefff00f0
 b71:	8b 00                	mov    eax,DWORD PTR [eax]
 b73:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 b77:	c7 04 24 4e 01 00 00 	mov    DWORD PTR [esp],0x14e
 b7e:	e8 fc ff ff ff       	call   b7f <apic_init+0x21a>
		printf("error:     %08x\n", apic_bp_reg(APIC_REG_ESR));
 b83:	b8 80 02 ff ef       	mov    eax,0xefff0280
 b88:	8b 00                	mov    eax,DWORD PTR [eax]
 b8a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 b8e:	c7 04 24 5f 01 00 00 	mov    DWORD PTR [esp],0x15f
 b95:	e8 fc ff ff ff       	call   b96 <apic_init+0x231>
		printf("LVT timer: %08x\n", apic_bp_reg(APIC_REG_LVT_TMR));
 b9a:	b8 20 03 ff ef       	mov    eax,0xefff0320
 b9f:	8b 00                	mov    eax,DWORD PTR [eax]
 ba1:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 ba5:	c7 04 24 70 01 00 00 	mov    DWORD PTR [esp],0x170
 bac:	e8 fc ff ff ff       	call   bad <apic_init+0x248>
		printf("LVT therm: %08x\n", apic_bp_reg(APIC_REG_LVT_THERM));
 bb1:	b8 30 03 ff ef       	mov    eax,0xefff0330
 bb6:	8b 00                	mov    eax,DWORD PTR [eax]
 bb8:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 bbc:	c7 04 24 81 01 00 00 	mov    DWORD PTR [esp],0x181
 bc3:	e8 fc ff ff ff       	call   bc4 <apic_init+0x25f>
		printf("LVT perf:  %08x\n", apic_bp_reg(APIC_REG_LVT_PERF));
 bc8:	b8 40 03 ff ef       	mov    eax,0xefff0340
 bcd:	8b 00                	mov    eax,DWORD PTR [eax]
 bcf:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 bd3:	c7 04 24 92 01 00 00 	mov    DWORD PTR [esp],0x192
 bda:	e8 fc ff ff ff       	call   bdb <apic_init+0x276>
		printf("LVT LINT0: %08x\n", apic_bp_reg(APIC_REG_LVT_LINT0));
 bdf:	b8 50 03 ff ef       	mov    eax,0xefff0350
 be4:	8b 00                	mov    eax,DWORD PTR [eax]
 be6:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 bea:	c7 04 24 a3 01 00 00 	mov    DWORD PTR [esp],0x1a3
 bf1:	e8 fc ff ff ff       	call   bf2 <apic_init+0x28d>
		printf("LVT LINT1: %08x\n", apic_bp_reg(APIC_REG_LVT_LINT1));
 bf6:	b8 60 03 ff ef       	mov    eax,0xefff0360
 bfb:	8b 00                	mov    eax,DWORD PTR [eax]
 bfd:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 c01:	c7 04 24 b4 01 00 00 	mov    DWORD PTR [esp],0x1b4
 c08:	e8 fc ff ff ff       	call   c09 <apic_init+0x2a4>
		printf("LVT error: %08x\n", apic_bp_reg(APIC_REG_LVT_ERR));
 c0d:	b8 70 03 ff ef       	mov    eax,0xefff0370
 c12:	8b 00                	mov    eax,DWORD PTR [eax]
 c14:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 c18:	c7 04 24 c5 01 00 00 	mov    DWORD PTR [esp],0x1c5
 c1f:	e8 fc ff ff ff       	call   c20 <apic_init+0x2bb>
		/* now install the handlers */
		apic_bp_reg(APIC_REG_SPURIOUS) = (apic_bp_reg(APIC_REG_SPURIOUS) & 0xffffff00) + 0x3f;
 c24:	b8 f0 00 ff ef       	mov    eax,0xefff00f0
 c29:	8b 00                	mov    eax,DWORD PTR [eax]
 c2b:	b0 00                	mov    al,0x0
 c2d:	ba f0 00 ff ef       	mov    edx,0xefff00f0
 c32:	83 c0 3f             	add    eax,0x3f
 c35:	89 02                	mov    DWORD PTR [edx],eax
		apic_bp_reg(APIC_REG_LVT_ERR) = 0x3c; /* 0 | 3c */
 c37:	b8 70 03 ff ef       	mov    eax,0xefff0370
 c3c:	c7 00 3c 00 00 00    	mov    DWORD PTR [eax],0x3c
		/* arm the error register */
		apic_bp_reg(APIC_REG_ESR) = 0;
 c42:	b8 80 02 ff ef       	mov    eax,0xefff0280
 c47:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0

		/* do the apic timer init */
		extern void apic_timer_setup();
		apic_timer_setup();
 c4d:	e8 fc ff ff ff       	call   c4e <apic_init+0x2e9>
		apic_initialized = 1;
 c52:	c7 05 00 00 00 00 01 00 00 00 	mov    DWORD PTR ds:0x0,0x1

		/* (always) do MP init */
		void mp_entry();
		mp_entry();
 c5c:	e8 fc ff ff ff       	call   c5d <apic_init+0x2f8>
		/* send self-IPI (only shorthand, i.e. lower reg) */
//		do { /*4c*/
//				apic_reg(APIC_REG_ICRL) = 0x00044000 | 50; /* level, edge */
//				for (size_t i = 0; i < 0x0f000000; i++);
//		} while (0);
}
 c61:	90                   	nop
 c62:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
 c65:	c9                   	leave
 c66:	c3                   	ret
