
pci.o64:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <io_wait>:
								return "generic 8254 system timer";
						else if (progIf == 1)
								return "ISA system timer";
						else if (progIf == 2)
								return "EISA system timer";
						else
       0:	55                   	push   rbp
       1:	48 89 e5             	mov    rbp,rsp
								return "other system timer";
       4:	b8 00 00 00 00       	mov    eax,0x0
       9:	e6 80                	out    0x80,al
				else if (scls == 3)
       b:	90                   	nop
       c:	5d                   	pop    rbp
       d:	c3                   	ret

000000000000000e <outl>:
				else if (scls == 4)
						if (progIf == 0)
								return "Gameport controller (generic)";
						else if (progIf == 0x10)
								return "Gameport controller (legacy)";
						else
       e:	55                   	push   rbp
       f:	48 89 e5             	mov    rbp,rsp
      12:	48 83 ec 08          	sub    rsp,0x8
      16:	89 f8                	mov    eax,edi
      18:	89 75 f8             	mov    DWORD PTR [rbp-0x8],esi
      1b:	66 89 45 fc          	mov    WORD PTR [rbp-0x4],ax
								return "other Gameport controller";
      1f:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
      22:	0f b7 55 fc          	movzx  edx,WORD PTR [rbp-0x4]
      26:	ef                   	out    dx,eax
				else if (scls == 0x80)
      27:	90                   	nop
      28:	c9                   	leave
      29:	c3                   	ret

000000000000002a <inl>:
						return "other input controller";
				else
						return "unrecognized input controller";
      2a:	55                   	push   rbp
      2b:	48 89 e5             	mov    rbp,rsp
      2e:	48 83 ec 18          	sub    rsp,0x18
      32:	89 f8                	mov    eax,edi
      34:	66 89 45 ec          	mov    WORD PTR [rbp-0x14],ax
		else if (cls == 10)
				if (scls == 0)
      38:	0f b7 45 ec          	movzx  eax,WORD PTR [rbp-0x14]
      3c:	89 c2                	mov    edx,eax
      3e:	ed                   	in     eax,dx
      3f:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
						return "generic docking station";
      42:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
				else if (scls == 0x80)
      45:	c9                   	leave
      46:	c3                   	ret

0000000000000047 <__list_add>:
								//else if ((dat >> 24) == 1)
								//		mdelay(1000);
								pca.reg_no = 12;
								dat = pci_read(pca);
								dat = (dat >> 16) & 0xff;
								le->dev.device_type = dat;
      47:	55                   	push   rbp
      48:	48 89 e5             	mov    rbp,rsp
      4b:	48 83 ec 18          	sub    rsp,0x18
      4f:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
      53:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
      57:	48 89 55 e8          	mov    QWORD PTR [rbp-0x18],rdx
								mf = dat & 0x80;
      5b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
      5f:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
      63:	48 89 10             	mov    QWORD PTR [rax],rdx
								printf("\tfunction: %s\n",
      66:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      6a:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
      6e:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
									(dat & 0x80) ? "multi" : "single");
      72:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      76:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
      7a:	48 89 10             	mov    QWORD PTR [rax],rdx
								printf("\ttype:     %s\n",
      7d:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
      81:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
      85:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
									((dat & 0x7f) == 0) ? "general" : (((dat & 0x7f) == 1)
      89:	90                   	nop
      8a:	c9                   	leave
      8b:	c3                   	ret

000000000000008c <list_add_tail>:
								pci_add_caps(&le->dev);
								list_add_tail(&le->devices, &device_list.devices);
								if (mf && fno < 8)
										goto multifun;
						} else if (fno && fno < 8)
								goto multifun; /* non-consecuitive layouts */
      8c:	55                   	push   rbp
      8d:	48 89 e5             	mov    rbp,rsp
      90:	48 83 ec 10          	sub    rsp,0x10
      94:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
      98:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
				}
      9c:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
      a0:	48 83 c0 10          	add    rax,0x10
      a4:	48 89 c7             	mov    rdi,rax
      a7:	e8 00 00 00 00       	call   ac <list_add_tail+0x20>
}
      ac:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
      b0:	48 8b 08             	mov    rcx,QWORD PTR [rax]
      b3:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
      b7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      bb:	48 89 ce             	mov    rsi,rcx
      be:	48 89 c7             	mov    rdi,rax
      c1:	e8 81 ff ff ff       	call   47 <__list_add>

      c6:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
      ca:	48 83 c0 10          	add    rax,0x10
      ce:	48 89 c7             	mov    rdi,rax
      d1:	e8 00 00 00 00       	call   d6 <list_add_tail+0x4a>
int MODENTRY module_init()
      d6:	90                   	nop
      d7:	c9                   	leave
      d8:	c3                   	ret

00000000000000d9 <pci_read>:
#define PCI_BAR_64_BIT (1 << 2)
#define PCI_BAR_16_BIT (1 << 1)
#define PCI_BAR_PREFETCHABLE (1 << 3) /* MMIO+PREF */

static inline uint32_t pci_read(union pca a)
{
      d9:	55                   	push   rbp
      da:	48 89 e5             	mov    rbp,rsp
      dd:	48 83 ec 08          	sub    rsp,0x8
      e1:	89 7d fc             	mov    DWORD PTR [rbp-0x4],edi
		outl(PCI_CONFIG_ADDRESS, a.val);
      e4:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
      e7:	89 c6                	mov    esi,eax
      e9:	bf f8 0c 00 00       	mov    edi,0xcf8
      ee:	e8 1b ff ff ff       	call   e <outl>
		io_wait();
      f3:	b8 00 00 00 00       	mov    eax,0x0
      f8:	e8 03 ff ff ff       	call   0 <io_wait>
		return inl(PCI_CONFIG_DATA);
      fd:	bf fc 0c 00 00       	mov    edi,0xcfc
     102:	e8 23 ff ff ff       	call   2a <inl>
}
     107:	c9                   	leave
     108:	c3                   	ret

0000000000000109 <pci_read_word>:

/* PCI is little endian (status==06h --> high bits) */
static inline uint16_t pci_read_word(union pca a)
{
     109:	55                   	push   rbp
     10a:	48 89 e5             	mov    rbp,rsp
     10d:	48 83 ec 18          	sub    rsp,0x18
     111:	89 7d ec             	mov    DWORD PTR [rbp-0x14],edi
		uint16_t of = a.reg_no % 4;
     114:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
     118:	0f b6 c0             	movzx  eax,al
     11b:	83 e0 03             	and    eax,0x3
     11e:	66 89 45 fa          	mov    WORD PTR [rbp-0x6],ax
		union pca a2 = a;
     122:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     125:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
		uint32_t v1, v2 = 0;
     128:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		a2.reg_no -= of;
     12f:	0f b6 45 f0          	movzx  eax,BYTE PTR [rbp-0x10]
     133:	0f b7 55 fa          	movzx  edx,WORD PTR [rbp-0x6]
     137:	29 d0                	sub    eax,edx
     139:	88 45 f0             	mov    BYTE PTR [rbp-0x10],al
		v1 = pci_read(a2);
     13c:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     13f:	89 c7                	mov    edi,eax
     141:	e8 93 ff ff ff       	call   d9 <pci_read>
     146:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
		if (of == 3) { /* very unaligned access */
     149:	66 83 7d fa 03       	cmp    WORD PTR [rbp-0x6],0x3
     14e:	75 25                	jne    175 <pci_read_word+0x6c>
				a2.reg_no += 4;
     150:	0f b6 45 f0          	movzx  eax,BYTE PTR [rbp-0x10]
     154:	83 c0 04             	add    eax,0x4
     157:	88 45 f0             	mov    BYTE PTR [rbp-0x10],al
				v2 = pci_read(a2);
     15a:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     15d:	89 c7                	mov    edi,eax
     15f:	e8 75 ff ff ff       	call   d9 <pci_read>
     164:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
				v2 = (v2 << 8) & 0xff00;
     167:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     16a:	c1 e0 08             	shl    eax,0x8
     16d:	25 ff ff 00 00       	and    eax,0xffff
     172:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		}
		v1 = (v1 >> 8 * of) & 0xffff;
     175:	0f b7 45 fa          	movzx  eax,WORD PTR [rbp-0x6]
     179:	c1 e0 03             	shl    eax,0x3
     17c:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
     17f:	89 c1                	mov    ecx,eax
     181:	d3 ea                	shr    edx,cl
     183:	89 d0                	mov    eax,edx
     185:	25 ff ff 00 00       	and    eax,0xffff
     18a:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
		return (v1 | v2);
     18d:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
     190:	89 c2                	mov    edx,eax
     192:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     195:	09 d0                	or     eax,edx
}
     197:	c9                   	leave
     198:	c3                   	ret

0000000000000199 <pci_read_byte>:

static inline uint8_t pci_read_byte(union pca a)
{
     199:	55                   	push   rbp
     19a:	48 89 e5             	mov    rbp,rsp
     19d:	48 83 ec 18          	sub    rsp,0x18
     1a1:	89 7d ec             	mov    DWORD PTR [rbp-0x14],edi
		uint8_t of = a.reg_no % 4;
     1a4:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
     1a8:	83 e0 03             	and    eax,0x3
     1ab:	88 45 ff             	mov    BYTE PTR [rbp-0x1],al
		union pca a2 = a;
     1ae:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     1b1:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
		a2.reg_no -= of;
     1b4:	0f b6 45 f8          	movzx  eax,BYTE PTR [rbp-0x8]
     1b8:	2a 45 ff             	sub    al,BYTE PTR [rbp-0x1]
     1bb:	88 45 f8             	mov    BYTE PTR [rbp-0x8],al
		return (pci_read(a2) >> 8 * of) & 0xff;
     1be:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
     1c1:	89 c7                	mov    edi,eax
     1c3:	e8 11 ff ff ff       	call   d9 <pci_read>
     1c8:	0f b6 55 ff          	movzx  edx,BYTE PTR [rbp-0x1]
     1cc:	c1 e2 03             	shl    edx,0x3
     1cf:	89 d1                	mov    ecx,edx
     1d1:	d3 e8                	shr    eax,cl
}
     1d3:	c9                   	leave
     1d4:	c3                   	ret

00000000000001d5 <pci_write>:

static inline void pci_write(union pca a, uint32_t v)
{
     1d5:	55                   	push   rbp
     1d6:	48 89 e5             	mov    rbp,rsp
     1d9:	48 83 ec 08          	sub    rsp,0x8
     1dd:	89 7d fc             	mov    DWORD PTR [rbp-0x4],edi
     1e0:	89 75 f8             	mov    DWORD PTR [rbp-0x8],esi
		outl(PCI_CONFIG_ADDRESS, a.val);
     1e3:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     1e6:	89 c6                	mov    esi,eax
     1e8:	bf f8 0c 00 00       	mov    edi,0xcf8
     1ed:	e8 1c fe ff ff       	call   e <outl>
		io_wait();
     1f2:	b8 00 00 00 00       	mov    eax,0x0
     1f7:	e8 04 fe ff ff       	call   0 <io_wait>
		outl(PCI_CONFIG_DATA, v);
     1fc:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
     1ff:	89 c6                	mov    esi,eax
     201:	bf fc 0c 00 00       	mov    edi,0xcfc
     206:	e8 03 fe ff ff       	call   e <outl>
}
     20b:	90                   	nop
     20c:	c9                   	leave
     20d:	c3                   	ret

000000000000020e <pci_get_class_string>:
{
     20e:	55                   	push   rbp
     20f:	48 89 e5             	mov    rbp,rsp
     212:	48 83 ec 08          	sub    rsp,0x8
     216:	89 f8                	mov    eax,edi
     218:	88 45 fc             	mov    BYTE PTR [rbp-0x4],al
		switch (cls) {
     21b:	0f b6 45 fc          	movzx  eax,BYTE PTR [rbp-0x4]
     21f:	83 f8 11             	cmp    eax,0x11
     222:	7f 1d                	jg     241 <pci_get_class_string+0x33>
     224:	85 c0                	test   eax,eax
     226:	0f 88 df 00 00 00    	js     30b <pci_get_class_string+0xfd>
     22c:	83 f8 11             	cmp    eax,0x11
     22f:	0f 87 d6 00 00 00    	ja     30b <pci_get_class_string+0xfd>
     235:	89 c0                	mov    eax,eax
     237:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
     23f:	ff e0                	jmp    rax
     241:	3d ff 00 00 00       	cmp    eax,0xff
     246:	0f 84 b6 00 00 00    	je     302 <pci_get_class_string+0xf4>
     24c:	e9 ba 00 00 00       	jmp    30b <pci_get_class_string+0xfd>
				return "(old device)";
     251:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     258:	e9 b5 00 00 00       	jmp    312 <pci_get_class_string+0x104>
				return "mass storage controller";
     25d:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     264:	e9 a9 00 00 00       	jmp    312 <pci_get_class_string+0x104>
				return "network controller";
     269:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     270:	e9 9d 00 00 00       	jmp    312 <pci_get_class_string+0x104>
				return "display controller";
     275:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     27c:	e9 91 00 00 00       	jmp    312 <pci_get_class_string+0x104>
				return "multimedia controller";
     281:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     288:	e9 85 00 00 00       	jmp    312 <pci_get_class_string+0x104>
				return "memory controller";
     28d:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     294:	eb 7c                	jmp    312 <pci_get_class_string+0x104>
				return "bridge device";
     296:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     29d:	eb 73                	jmp    312 <pci_get_class_string+0x104>
				return "simple communication controllers";
     29f:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     2a6:	eb 6a                	jmp    312 <pci_get_class_string+0x104>
				return "base system peripherials";
     2a8:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     2af:	eb 61                	jmp    312 <pci_get_class_string+0x104>
				return "input devices";
     2b1:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     2b8:	eb 58                	jmp    312 <pci_get_class_string+0x104>
				return "docking stations";
     2ba:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     2c1:	eb 4f                	jmp    312 <pci_get_class_string+0x104>
				return "processors";
     2c3:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     2ca:	eb 46                	jmp    312 <pci_get_class_string+0x104>
				return "serial bus controllers";
     2cc:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     2d3:	eb 3d                	jmp    312 <pci_get_class_string+0x104>
				return "wireless controllers";
     2d5:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     2dc:	eb 34                	jmp    312 <pci_get_class_string+0x104>
				return "intelligent I/O controllers";
     2de:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     2e5:	eb 2b                	jmp    312 <pci_get_class_string+0x104>
				return "satellite communication controllers";
     2e7:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     2ee:	eb 22                	jmp    312 <pci_get_class_string+0x104>
				return "encryption/decryption controllers";
     2f0:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     2f7:	eb 19                	jmp    312 <pci_get_class_string+0x104>
				return "data acquisiton and signal processing controllers";
     2f9:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     300:	eb 10                	jmp    312 <pci_get_class_string+0x104>
				return "no fitting class";
     302:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     309:	eb 07                	jmp    312 <pci_get_class_string+0x104>
				return "(reserved)";
     30b:	48 c7 c0 00 00 00 00 	mov    rax,0x0
}
     312:	c9                   	leave
     313:	c3                   	ret

0000000000000314 <pci_get_subclass_string>:
{
     314:	55                   	push   rbp
     315:	48 89 e5             	mov    rbp,rsp
     318:	48 83 ec 10          	sub    rsp,0x10
     31c:	89 f1                	mov    ecx,esi
     31e:	89 d0                	mov    eax,edx
     320:	89 fa                	mov    edx,edi
     322:	88 55 fc             	mov    BYTE PTR [rbp-0x4],dl
     325:	89 ca                	mov    edx,ecx
     327:	88 55 f8             	mov    BYTE PTR [rbp-0x8],dl
     32a:	88 45 f4             	mov    BYTE PTR [rbp-0xc],al
		if (cls == 0)
     32d:	80 7d fc 00          	cmp    BYTE PTR [rbp-0x4],0x0
     331:	75 30                	jne    363 <pci_get_subclass_string+0x4f>
				if (scls == 0)
     333:	80 7d f8 00          	cmp    BYTE PTR [rbp-0x8],0x0
     337:	75 0c                	jne    345 <pci_get_subclass_string+0x31>
						return "any device (not VGA compatible)";
     339:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     340:	e9 f0 0b 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 1)
     345:	80 7d f8 01          	cmp    BYTE PTR [rbp-0x8],0x1
     349:	75 0c                	jne    357 <pci_get_subclass_string+0x43>
						return "VGA compatible";
     34b:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     352:	e9 de 0b 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						return "(invalid)";
     357:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     35e:	e9 d2 0b 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
		else if (cls == 1)
     363:	80 7d fc 01          	cmp    BYTE PTR [rbp-0x4],0x1
     367:	0f 85 e4 00 00 00    	jne    451 <pci_get_subclass_string+0x13d>
				if (scls == 0)
     36d:	80 7d f8 00          	cmp    BYTE PTR [rbp-0x8],0x0
     371:	75 0c                	jne    37f <pci_get_subclass_string+0x6b>
						return "SCSI bus controller";
     373:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     37a:	e9 b6 0b 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 1)
     37f:	80 7d f8 01          	cmp    BYTE PTR [rbp-0x8],0x1
     383:	75 0c                	jne    391 <pci_get_subclass_string+0x7d>
						return "IDE controller";
     385:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     38c:	e9 a4 0b 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 3)
     391:	80 7d f8 03          	cmp    BYTE PTR [rbp-0x8],0x3
     395:	75 0c                	jne    3a3 <pci_get_subclass_string+0x8f>
						return "IPI bus controller";
     397:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     39e:	e9 92 0b 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 4)
     3a3:	80 7d f8 04          	cmp    BYTE PTR [rbp-0x8],0x4
     3a7:	75 0c                	jne    3b5 <pci_get_subclass_string+0xa1>
						return "RAID controller";
     3a9:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     3b0:	e9 80 0b 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 5)
     3b5:	80 7d f8 05          	cmp    BYTE PTR [rbp-0x8],0x5
     3b9:	75 30                	jne    3eb <pci_get_subclass_string+0xd7>
						if (progIf == 0x20)
     3bb:	80 7d f4 20          	cmp    BYTE PTR [rbp-0xc],0x20
     3bf:	75 0c                	jne    3cd <pci_get_subclass_string+0xb9>
								return "ATA controller (single DMA)";
     3c1:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     3c8:	e9 68 0b 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 0x30)
     3cd:	80 7d f4 30          	cmp    BYTE PTR [rbp-0xc],0x30
     3d1:	75 0c                	jne    3df <pci_get_subclass_string+0xcb>
								return "ATA controller (chained DMA)";
     3d3:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     3da:	e9 56 0b 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
								return "ATA controller (unknown interface)";
     3df:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     3e6:	e9 4a 0b 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 6)
     3eb:	80 7d f8 06          	cmp    BYTE PTR [rbp-0x8],0x6
     3ef:	75 30                	jne    421 <pci_get_subclass_string+0x10d>
						if (progIf == 0)
     3f1:	80 7d f4 00          	cmp    BYTE PTR [rbp-0xc],0x0
     3f5:	75 0c                	jne    403 <pci_get_subclass_string+0xef>
								return "SATA (vendor interface)";
     3f7:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     3fe:	e9 32 0b 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 1)
     403:	80 7d f4 01          	cmp    BYTE PTR [rbp-0xc],0x1
     407:	75 0c                	jne    415 <pci_get_subclass_string+0x101>
								return "SATA (AHCI 1.0)";
     409:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     410:	e9 20 0b 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
								return "SATA (unknown interface)";
     415:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     41c:	e9 14 0b 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 7)
     421:	80 7d f8 07          	cmp    BYTE PTR [rbp-0x8],0x7
     425:	75 0c                	jne    433 <pci_get_subclass_string+0x11f>
						return "Serial Attached SCSI (SAS)";
     427:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     42e:	e9 02 0b 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 0x80)
     433:	80 7d f8 80          	cmp    BYTE PTR [rbp-0x8],0x80
     437:	75 0c                	jne    445 <pci_get_subclass_string+0x131>
						return "other mass storage controller";
     439:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     440:	e9 f0 0a 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						return "unrecognized mass storage controller";
     445:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     44c:	e9 e4 0a 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
		else if (cls == 2)
     451:	80 7d fc 02          	cmp    BYTE PTR [rbp-0x4],0x2
     455:	0f 85 9c 00 00 00    	jne    4f7 <pci_get_subclass_string+0x1e3>
				if (scls == 0)
     45b:	80 7d f8 00          	cmp    BYTE PTR [rbp-0x8],0x0
     45f:	75 0c                	jne    46d <pci_get_subclass_string+0x159>
						return "Ethernet controller";
     461:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     468:	e9 c8 0a 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 1)
     46d:	80 7d f8 01          	cmp    BYTE PTR [rbp-0x8],0x1
     471:	75 0c                	jne    47f <pci_get_subclass_string+0x16b>
						return "Token ring controller";
     473:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     47a:	e9 b6 0a 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 2)
     47f:	80 7d f8 02          	cmp    BYTE PTR [rbp-0x8],0x2
     483:	75 0c                	jne    491 <pci_get_subclass_string+0x17d>
						return "FDDI controller";
     485:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     48c:	e9 a4 0a 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 3)
     491:	80 7d f8 03          	cmp    BYTE PTR [rbp-0x8],0x3
     495:	75 0c                	jne    4a3 <pci_get_subclass_string+0x18f>
						return "ATM controller";
     497:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     49e:	e9 92 0a 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 4)
     4a3:	80 7d f8 04          	cmp    BYTE PTR [rbp-0x8],0x4
     4a7:	75 0c                	jne    4b5 <pci_get_subclass_string+0x1a1>
						return "ISDN controller";
     4a9:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     4b0:	e9 80 0a 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 5)
     4b5:	80 7d f8 05          	cmp    BYTE PTR [rbp-0x8],0x5
     4b9:	75 0c                	jne    4c7 <pci_get_subclass_string+0x1b3>
						return "WorldFip controller";
     4bb:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     4c2:	e9 6e 0a 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 6)
     4c7:	80 7d f8 06          	cmp    BYTE PTR [rbp-0x8],0x6
     4cb:	75 0c                	jne    4d9 <pci_get_subclass_string+0x1c5>
						return "PICMG 2.14 Multi Computing";
     4cd:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     4d4:	e9 5c 0a 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 0x80)
     4d9:	80 7d f8 80          	cmp    BYTE PTR [rbp-0x8],0x80
     4dd:	75 0c                	jne    4eb <pci_get_subclass_string+0x1d7>
						return "other network controller";
     4df:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     4e6:	e9 4a 0a 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						return "unrecognized network controller";
     4eb:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     4f2:	e9 3e 0a 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
		else if (cls == 3)
     4f7:	80 7d fc 03          	cmp    BYTE PTR [rbp-0x4],0x3
     4fb:	75 78                	jne    575 <pci_get_subclass_string+0x261>
				if (scls == 0)
     4fd:	80 7d f8 00          	cmp    BYTE PTR [rbp-0x8],0x0
     501:	75 30                	jne    533 <pci_get_subclass_string+0x21f>
						if (progIf == 0)
     503:	80 7d f4 00          	cmp    BYTE PTR [rbp-0xc],0x0
     507:	75 0c                	jne    515 <pci_get_subclass_string+0x201>
								return "VGA-compatible controller";
     509:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     510:	e9 20 0a 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 1)
     515:	80 7d f4 01          	cmp    BYTE PTR [rbp-0xc],0x1
     519:	75 0c                	jne    527 <pci_get_subclass_string+0x213>
								return "8512-compatible controller";
     51b:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     522:	e9 0e 0a 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
								return "unkown sc0 display controller";
     527:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     52e:	e9 02 0a 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 1)
     533:	80 7d f8 01          	cmp    BYTE PTR [rbp-0x8],0x1
     537:	75 0c                	jne    545 <pci_get_subclass_string+0x231>
						return "XGA controller";
     539:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     540:	e9 f0 09 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 2)
     545:	80 7d f8 02          	cmp    BYTE PTR [rbp-0x8],0x2
     549:	75 0c                	jne    557 <pci_get_subclass_string+0x243>
						return "3D controller (no VGA)";
     54b:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     552:	e9 de 09 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 0x80)
     557:	80 7d f8 80          	cmp    BYTE PTR [rbp-0x8],0x80
     55b:	75 0c                	jne    569 <pci_get_subclass_string+0x255>
						return "other video controller";
     55d:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     564:	e9 cc 09 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						return "unrecognized video controller";
     569:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     570:	e9 c0 09 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
		else if (cls == 4)
     575:	80 7d fc 04          	cmp    BYTE PTR [rbp-0x4],0x4
     579:	75 54                	jne    5cf <pci_get_subclass_string+0x2bb>
				if (scls == 0)
     57b:	80 7d f8 00          	cmp    BYTE PTR [rbp-0x8],0x0
     57f:	75 0c                	jne    58d <pci_get_subclass_string+0x279>
						return "video device";
     581:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     588:	e9 a8 09 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 1)
     58d:	80 7d f8 01          	cmp    BYTE PTR [rbp-0x8],0x1
     591:	75 0c                	jne    59f <pci_get_subclass_string+0x28b>
						return "audio device";
     593:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     59a:	e9 96 09 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 2)
     59f:	80 7d f8 02          	cmp    BYTE PTR [rbp-0x8],0x2
     5a3:	75 0c                	jne    5b1 <pci_get_subclass_string+0x29d>
						return "Computer telephony device";
     5a5:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     5ac:	e9 84 09 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 0x80)
     5b1:	80 7d f8 80          	cmp    BYTE PTR [rbp-0x8],0x80
     5b5:	75 0c                	jne    5c3 <pci_get_subclass_string+0x2af>
						return "other media device";
     5b7:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     5be:	e9 72 09 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						return "unrecongnized media device";
     5c3:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     5ca:	e9 66 09 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
		else if (cls == 5)
     5cf:	80 7d fc 05          	cmp    BYTE PTR [rbp-0x4],0x5
     5d3:	75 42                	jne    617 <pci_get_subclass_string+0x303>
				if (scls == 0)
     5d5:	80 7d f8 00          	cmp    BYTE PTR [rbp-0x8],0x0
     5d9:	75 0c                	jne    5e7 <pci_get_subclass_string+0x2d3>
						return "RAM controller";
     5db:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     5e2:	e9 4e 09 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 1)
     5e7:	80 7d f8 01          	cmp    BYTE PTR [rbp-0x8],0x1
     5eb:	75 0c                	jne    5f9 <pci_get_subclass_string+0x2e5>
						return "flash controller";
     5ed:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     5f4:	e9 3c 09 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 0x80)
     5f9:	80 7d f8 80          	cmp    BYTE PTR [rbp-0x8],0x80
     5fd:	75 0c                	jne    60b <pci_get_subclass_string+0x2f7>
						return "other memory controller";
     5ff:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     606:	e9 2a 09 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						return "unrecognized memory controller";
     60b:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     612:	e9 1e 09 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
		else if (cls == 6)
     617:	80 7d fc 06          	cmp    BYTE PTR [rbp-0x4],0x6
     61b:	0f 85 2c 01 00 00    	jne    74d <pci_get_subclass_string+0x439>
				if (scls == 0)
     621:	80 7d f8 00          	cmp    BYTE PTR [rbp-0x8],0x0
     625:	75 0c                	jne    633 <pci_get_subclass_string+0x31f>
						return "Host bridge";
     627:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     62e:	e9 02 09 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 1)
     633:	80 7d f8 01          	cmp    BYTE PTR [rbp-0x8],0x1
     637:	75 0c                	jne    645 <pci_get_subclass_string+0x331>
						return "ISA bridge";
     639:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     640:	e9 f0 08 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 2)
     645:	80 7d f8 02          	cmp    BYTE PTR [rbp-0x8],0x2
     649:	75 0c                	jne    657 <pci_get_subclass_string+0x343>
						return "EISA bridge";
     64b:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     652:	e9 de 08 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 3)
     657:	80 7d f8 03          	cmp    BYTE PTR [rbp-0x8],0x3
     65b:	75 0c                	jne    669 <pci_get_subclass_string+0x355>
						return "MCA bridge";
     65d:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     664:	e9 cc 08 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 4)
     669:	80 7d f8 04          	cmp    BYTE PTR [rbp-0x8],0x4
     66d:	75 30                	jne    69f <pci_get_subclass_string+0x38b>
						if (progIf == 0)
     66f:	80 7d f4 00          	cmp    BYTE PTR [rbp-0xc],0x0
     673:	75 0c                	jne    681 <pci_get_subclass_string+0x36d>
								return "PCI-to-PCI bridge";
     675:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     67c:	e9 b4 08 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 1)
     681:	80 7d f4 01          	cmp    BYTE PTR [rbp-0xc],0x1
     685:	75 0c                	jne    693 <pci_get_subclass_string+0x37f>
								return "PCI-to-PCI bridge (subtractive decode)";
     687:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     68e:	e9 a2 08 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
								return "possibly PCI-to-PCI bridge";
     693:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     69a:	e9 96 08 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 5)
     69f:	80 7d f8 05          	cmp    BYTE PTR [rbp-0x8],0x5
     6a3:	75 0c                	jne    6b1 <pci_get_subclass_string+0x39d>
						return "PCMCIA bridge";
     6a5:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     6ac:	e9 84 08 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 6)
     6b1:	80 7d f8 06          	cmp    BYTE PTR [rbp-0x8],0x6
     6b5:	75 0c                	jne    6c3 <pci_get_subclass_string+0x3af>
						return "NuBus bridge";
     6b7:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     6be:	e9 72 08 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 7)
     6c3:	80 7d f8 07          	cmp    BYTE PTR [rbp-0x8],0x7
     6c7:	75 0c                	jne    6d5 <pci_get_subclass_string+0x3c1>
						return "CardBus bridge";
     6c9:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     6d0:	e9 60 08 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 8)
     6d5:	80 7d f8 08          	cmp    BYTE PTR [rbp-0x8],0x8
     6d9:	75 0c                	jne    6e7 <pci_get_subclass_string+0x3d3>
						return "RACEway bridge";
     6db:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     6e2:	e9 4e 08 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 9)
     6e7:	80 7d f8 09          	cmp    BYTE PTR [rbp-0x8],0x9
     6eb:	75 30                	jne    71d <pci_get_subclass_string+0x409>
						if (progIf == 0x40)
     6ed:	80 7d f4 40          	cmp    BYTE PTR [rbp-0xc],0x40
     6f1:	75 0c                	jne    6ff <pci_get_subclass_string+0x3eb>
								return "PCI-to-PCI bridge (ST, pri)";
     6f3:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     6fa:	e9 36 08 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 0x80)
     6ff:	80 7d f4 80          	cmp    BYTE PTR [rbp-0xc],0x80
     703:	75 0c                	jne    711 <pci_get_subclass_string+0x3fd>
								return "PCI-to-PCI bridge (ST, sec)";
     705:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     70c:	e9 24 08 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
								return "possibly PCI-to-PCI bridge (ST)";
     711:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     718:	e9 18 08 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 10)
     71d:	80 7d f8 0a          	cmp    BYTE PTR [rbp-0x8],0xa
     721:	75 0c                	jne    72f <pci_get_subclass_string+0x41b>
						return "InfiniBand-to-PCI host bridge";
     723:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     72a:	e9 06 08 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 0x80)
     72f:	80 7d f8 80          	cmp    BYTE PTR [rbp-0x8],0x80
     733:	75 0c                	jne    741 <pci_get_subclass_string+0x42d>
						return "other bridge device";
     735:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     73c:	e9 f4 07 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						return "unrecognized bridge device";
     741:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     748:	e9 e8 07 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
		else if (cls == 7)
     74d:	80 7d fc 07          	cmp    BYTE PTR [rbp-0x4],0x7
     751:	0f 85 8a 01 00 00    	jne    8e1 <pci_get_subclass_string+0x5cd>
				if (scls == 0)
     757:	80 7d f8 00          	cmp    BYTE PTR [rbp-0x8],0x0
     75b:	0f 85 8a 00 00 00    	jne    7eb <pci_get_subclass_string+0x4d7>
						if (progIf == 0)
     761:	80 7d f4 00          	cmp    BYTE PTR [rbp-0xc],0x0
     765:	75 0c                	jne    773 <pci_get_subclass_string+0x45f>
								return "generic XT-compatible serial controller";
     767:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     76e:	e9 c2 07 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 1)
     773:	80 7d f4 01          	cmp    BYTE PTR [rbp-0xc],0x1
     777:	75 0c                	jne    785 <pci_get_subclass_string+0x471>
								return "16450-compatible serial controller";
     779:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     780:	e9 b0 07 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 2)
     785:	80 7d f4 02          	cmp    BYTE PTR [rbp-0xc],0x2
     789:	75 0c                	jne    797 <pci_get_subclass_string+0x483>
								return "16550-compatible serial controller";
     78b:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     792:	e9 9e 07 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 3)
     797:	80 7d f4 03          	cmp    BYTE PTR [rbp-0xc],0x3
     79b:	75 0c                	jne    7a9 <pci_get_subclass_string+0x495>
								return "16650-compatible serial controller";
     79d:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     7a4:	e9 8c 07 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 4)
     7a9:	80 7d f4 04          	cmp    BYTE PTR [rbp-0xc],0x4
     7ad:	75 0c                	jne    7bb <pci_get_subclass_string+0x4a7>
								return "16750-compatible serial controller";
     7af:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     7b6:	e9 7a 07 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 5)
     7bb:	80 7d f4 05          	cmp    BYTE PTR [rbp-0xc],0x5
     7bf:	75 0c                	jne    7cd <pci_get_subclass_string+0x4b9>
								return "16850-compatible serial controller";
     7c1:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     7c8:	e9 68 07 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 6)
     7cd:	80 7d f4 06          	cmp    BYTE PTR [rbp-0xc],0x6
     7d1:	75 0c                	jne    7df <pci_get_subclass_string+0x4cb>
								return "16950-compatible serial controller";
     7d3:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     7da:	e9 56 07 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
								return "other serial controller";
     7df:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     7e6:	e9 4a 07 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 1)
     7eb:	80 7d f8 01          	cmp    BYTE PTR [rbp-0x8],0x1
     7ef:	75 66                	jne    857 <pci_get_subclass_string+0x543>
						if (progIf == 0)
     7f1:	80 7d f4 00          	cmp    BYTE PTR [rbp-0xc],0x0
     7f5:	75 0c                	jne    803 <pci_get_subclass_string+0x4ef>
								return "parallel port";
     7f7:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     7fe:	e9 32 07 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 1)
     803:	80 7d f4 01          	cmp    BYTE PTR [rbp-0xc],0x1
     807:	75 0c                	jne    815 <pci_get_subclass_string+0x501>
								return "bidirectional parallel port";
     809:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     810:	e9 20 07 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 2)
     815:	80 7d f4 02          	cmp    BYTE PTR [rbp-0xc],0x2
     819:	75 0c                	jne    827 <pci_get_subclass_string+0x513>
								return "ECP 1.x compliant parallel port";
     81b:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     822:	e9 0e 07 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 3)
     827:	80 7d f4 03          	cmp    BYTE PTR [rbp-0xc],0x3
     82b:	75 0c                	jne    839 <pci_get_subclass_string+0x525>
								return "IEEE 1284 controller";
     82d:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     834:	e9 fc 06 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 0xfe)
     839:	80 7d f4 fe          	cmp    BYTE PTR [rbp-0xc],0xfe
     83d:	75 0c                	jne    84b <pci_get_subclass_string+0x537>
								return "IEEE 1284 target device";
     83f:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     846:	e9 ea 06 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
								return "other parallel device";
     84b:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     852:	e9 de 06 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 2)
     857:	80 7d f8 02          	cmp    BYTE PTR [rbp-0x8],0x2
     85b:	75 0c                	jne    869 <pci_get_subclass_string+0x555>
						return "multiport serial controller";
     85d:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     864:	e9 cc 06 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 3)
     869:	80 7d f8 03          	cmp    BYTE PTR [rbp-0x8],0x3
     86d:	75 30                	jne    89f <pci_get_subclass_string+0x58b>
						if (progIf == 0)
     86f:	80 7d f4 00          	cmp    BYTE PTR [rbp-0xc],0x0
     873:	75 0c                	jne    881 <pci_get_subclass_string+0x56d>
								return "generic modem";
     875:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     87c:	e9 b4 06 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf <= 4)
     881:	80 7d f4 04          	cmp    BYTE PTR [rbp-0xc],0x4
     885:	77 0c                	ja     893 <pci_get_subclass_string+0x57f>
								return "Hayes compatible modem (see progIf for details)";
     887:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     88e:	e9 a2 06 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
								return "other modem";
     893:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     89a:	e9 96 06 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 4)
     89f:	80 7d f8 04          	cmp    BYTE PTR [rbp-0x8],0x4
     8a3:	75 0c                	jne    8b1 <pci_get_subclass_string+0x59d>
						return "IEEE 488.1/2 (GPIB) controller";
     8a5:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     8ac:	e9 84 06 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 5)
     8b1:	80 7d f8 05          	cmp    BYTE PTR [rbp-0x8],0x5
     8b5:	75 0c                	jne    8c3 <pci_get_subclass_string+0x5af>
						return "SmartCard";
     8b7:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     8be:	e9 72 06 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 0x80)
     8c3:	80 7d f8 80          	cmp    BYTE PTR [rbp-0x8],0x80
     8c7:	75 0c                	jne    8d5 <pci_get_subclass_string+0x5c1>
						return "other communications device";
     8c9:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     8d0:	e9 60 06 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						return "unrecognized communications device";
     8d5:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     8dc:	e9 54 06 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
		else if (cls == 8)
     8e1:	80 7d fc 08          	cmp    BYTE PTR [rbp-0x4],0x8
     8e5:	0f 85 62 01 00 00    	jne    a4d <pci_get_subclass_string+0x739>
				if (scls == 0)
     8eb:	80 7d f8 00          	cmp    BYTE PTR [rbp-0x8],0x0
     8ef:	75 66                	jne    957 <pci_get_subclass_string+0x643>
						if (progIf == 0)
     8f1:	80 7d f4 00          	cmp    BYTE PTR [rbp-0xc],0x0
     8f5:	75 0c                	jne    903 <pci_get_subclass_string+0x5ef>
								return "generic 8259 PIC";
     8f7:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     8fe:	e9 32 06 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 1)
     903:	80 7d f4 01          	cmp    BYTE PTR [rbp-0xc],0x1
     907:	75 0c                	jne    915 <pci_get_subclass_string+0x601>
								return "ISA PIC";
     909:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     910:	e9 20 06 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 2)
     915:	80 7d f4 02          	cmp    BYTE PTR [rbp-0xc],0x2
     919:	75 0c                	jne    927 <pci_get_subclass_string+0x613>
								return "EISA PIC";
     91b:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     922:	e9 0e 06 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 0x10)
     927:	80 7d f4 10          	cmp    BYTE PTR [rbp-0xc],0x10
     92b:	75 0c                	jne    939 <pci_get_subclass_string+0x625>
								return "I/O APIC";
     92d:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     934:	e9 fc 05 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 0x20)
     939:	80 7d f4 20          	cmp    BYTE PTR [rbp-0xc],0x20
     93d:	75 0c                	jne    94b <pci_get_subclass_string+0x637>
								return "I/O(x) APIC";
     93f:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     946:	e9 ea 05 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
								return "other interrupt controller";
     94b:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     952:	e9 de 05 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 1)
     957:	80 7d f8 01          	cmp    BYTE PTR [rbp-0x8],0x1
     95b:	75 42                	jne    99f <pci_get_subclass_string+0x68b>
						if (progIf == 0)
     95d:	80 7d f4 00          	cmp    BYTE PTR [rbp-0xc],0x0
     961:	75 0c                	jne    96f <pci_get_subclass_string+0x65b>
								return "generic 8237 DMA controller";
     963:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     96a:	e9 c6 05 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 1)
     96f:	80 7d f4 01          	cmp    BYTE PTR [rbp-0xc],0x1
     973:	75 0c                	jne    981 <pci_get_subclass_string+0x66d>
								return "ISA DMA controller";
     975:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     97c:	e9 b4 05 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 2)
     981:	80 7d f4 02          	cmp    BYTE PTR [rbp-0xc],0x2
     985:	75 0c                	jne    993 <pci_get_subclass_string+0x67f>
								return "EISA DMA controller";
     987:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     98e:	e9 a2 05 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
								return "other DMA controller";
     993:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     99a:	e9 96 05 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 2)
     99f:	80 7d f8 02          	cmp    BYTE PTR [rbp-0x8],0x2
     9a3:	75 42                	jne    9e7 <pci_get_subclass_string+0x6d3>
						if (progIf == 0)
     9a5:	80 7d f4 00          	cmp    BYTE PTR [rbp-0xc],0x0
     9a9:	75 0c                	jne    9b7 <pci_get_subclass_string+0x6a3>
								return "generic 8254 system timer";
     9ab:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     9b2:	e9 7e 05 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 1)
     9b7:	80 7d f4 01          	cmp    BYTE PTR [rbp-0xc],0x1
     9bb:	75 0c                	jne    9c9 <pci_get_subclass_string+0x6b5>
								return "ISA system timer";
     9bd:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     9c4:	e9 6c 05 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 2)
     9c9:	80 7d f4 02          	cmp    BYTE PTR [rbp-0xc],0x2
     9cd:	75 0c                	jne    9db <pci_get_subclass_string+0x6c7>
								return "EISA system timer";
     9cf:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     9d6:	e9 5a 05 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
								return "other system timer";
     9db:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     9e2:	e9 4e 05 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 3)
     9e7:	80 7d f8 03          	cmp    BYTE PTR [rbp-0x8],0x3
     9eb:	75 30                	jne    a1d <pci_get_subclass_string+0x709>
						if (progIf == 0)
     9ed:	80 7d f4 00          	cmp    BYTE PTR [rbp-0xc],0x0
     9f1:	75 0c                	jne    9ff <pci_get_subclass_string+0x6eb>
								return "generic RTC controller";
     9f3:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     9fa:	e9 36 05 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 1)
     9ff:	80 7d f4 01          	cmp    BYTE PTR [rbp-0xc],0x1
     a03:	75 0c                	jne    a11 <pci_get_subclass_string+0x6fd>
								return "ISA RTC controller";
     a05:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     a0c:	e9 24 05 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
								return "other RTC controller";
     a11:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     a18:	e9 18 05 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 4)
     a1d:	80 7d f8 04          	cmp    BYTE PTR [rbp-0x8],0x4
     a21:	75 0c                	jne    a2f <pci_get_subclass_string+0x71b>
						return "generic PCI Hot-Plug controller";
     a23:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     a2a:	e9 06 05 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 0x80)
     a2f:	80 7d f8 80          	cmp    BYTE PTR [rbp-0x8],0x80
     a33:	75 0c                	jne    a41 <pci_get_subclass_string+0x72d>
						return "other system peripheral";
     a35:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     a3c:	e9 f4 04 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						return "unrecognized system peripheral";
     a41:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     a48:	e9 e8 04 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
		else if (cls == 9)
     a4d:	80 7d fc 09          	cmp    BYTE PTR [rbp-0x4],0x9
     a51:	0f 85 9c 00 00 00    	jne    af3 <pci_get_subclass_string+0x7df>
				if (scls == 0)
     a57:	80 7d f8 00          	cmp    BYTE PTR [rbp-0x8],0x0
     a5b:	75 0c                	jne    a69 <pci_get_subclass_string+0x755>
						return "keyboard controller";
     a5d:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     a64:	e9 cc 04 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 1)
     a69:	80 7d f8 01          	cmp    BYTE PTR [rbp-0x8],0x1
     a6d:	75 0c                	jne    a7b <pci_get_subclass_string+0x767>
						return "digitizer";
     a6f:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     a76:	e9 ba 04 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 2)
     a7b:	80 7d f8 02          	cmp    BYTE PTR [rbp-0x8],0x2
     a7f:	75 0c                	jne    a8d <pci_get_subclass_string+0x779>
						return "mouse controller";
     a81:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     a88:	e9 a8 04 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 3)
     a8d:	80 7d f8 03          	cmp    BYTE PTR [rbp-0x8],0x3
     a91:	75 0c                	jne    a9f <pci_get_subclass_string+0x78b>
						return "scanner controller";
     a93:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     a9a:	e9 96 04 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 4)
     a9f:	80 7d f8 04          	cmp    BYTE PTR [rbp-0x8],0x4
     aa3:	75 30                	jne    ad5 <pci_get_subclass_string+0x7c1>
						if (progIf == 0)
     aa5:	80 7d f4 00          	cmp    BYTE PTR [rbp-0xc],0x0
     aa9:	75 0c                	jne    ab7 <pci_get_subclass_string+0x7a3>
								return "Gameport controller (generic)";
     aab:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     ab2:	e9 7e 04 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 0x10)
     ab7:	80 7d f4 10          	cmp    BYTE PTR [rbp-0xc],0x10
     abb:	75 0c                	jne    ac9 <pci_get_subclass_string+0x7b5>
								return "Gameport controller (legacy)";
     abd:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     ac4:	e9 6c 04 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
								return "other Gameport controller";
     ac9:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     ad0:	e9 60 04 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 0x80)
     ad5:	80 7d f8 80          	cmp    BYTE PTR [rbp-0x8],0x80
     ad9:	75 0c                	jne    ae7 <pci_get_subclass_string+0x7d3>
						return "other input controller";
     adb:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     ae2:	e9 4e 04 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						return "unrecognized input controller";
     ae7:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     aee:	e9 42 04 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
		else if (cls == 10)
     af3:	80 7d fc 0a          	cmp    BYTE PTR [rbp-0x4],0xa
     af7:	75 30                	jne    b29 <pci_get_subclass_string+0x815>
				if (scls == 0)
     af9:	80 7d f8 00          	cmp    BYTE PTR [rbp-0x8],0x0
     afd:	75 0c                	jne    b0b <pci_get_subclass_string+0x7f7>
						return "generic docking station";
     aff:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     b06:	e9 2a 04 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 0x80)
     b0b:	80 7d f8 80          	cmp    BYTE PTR [rbp-0x8],0x80
     b0f:	75 0c                	jne    b1d <pci_get_subclass_string+0x809>
						return "other docking station";
     b11:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     b18:	e9 18 04 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						return "unrecognized docking station";
     b1d:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     b24:	e9 0c 04 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
		else if (cls == 11)
     b29:	80 7d fc 0b          	cmp    BYTE PTR [rbp-0x4],0xb
     b2d:	0f 85 8a 00 00 00    	jne    bbd <pci_get_subclass_string+0x8a9>
				if (scls == 0)
     b33:	80 7d f8 00          	cmp    BYTE PTR [rbp-0x8],0x0
     b37:	75 0c                	jne    b45 <pci_get_subclass_string+0x831>
						return "386 processor";
     b39:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     b40:	e9 f0 03 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 1)
     b45:	80 7d f8 01          	cmp    BYTE PTR [rbp-0x8],0x1
     b49:	75 0c                	jne    b57 <pci_get_subclass_string+0x843>
						return "486 processor";
     b4b:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     b52:	e9 de 03 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 2)
     b57:	80 7d f8 02          	cmp    BYTE PTR [rbp-0x8],0x2
     b5b:	75 0c                	jne    b69 <pci_get_subclass_string+0x855>
						return "Pentiu processor";
     b5d:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     b64:	e9 cc 03 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 0x10)
     b69:	80 7d f8 10          	cmp    BYTE PTR [rbp-0x8],0x10
     b6d:	75 0c                	jne    b7b <pci_get_subclass_string+0x867>
						return "Alpha processor";
     b6f:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     b76:	e9 ba 03 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 0x20)
     b7b:	80 7d f8 20          	cmp    BYTE PTR [rbp-0x8],0x20
     b7f:	75 0c                	jne    b8d <pci_get_subclass_string+0x879>
						return "PowerPC processor";
     b81:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     b88:	e9 a8 03 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 0x30)
     b8d:	80 7d f8 30          	cmp    BYTE PTR [rbp-0x8],0x30
     b91:	75 0c                	jne    b9f <pci_get_subclass_string+0x88b>
						return "MIPS processor";
     b93:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     b9a:	e9 96 03 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 0x40)
     b9f:	80 7d f8 40          	cmp    BYTE PTR [rbp-0x8],0x40
     ba3:	75 0c                	jne    bb1 <pci_get_subclass_string+0x89d>
						return "coprocessor";
     ba5:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     bac:	e9 84 03 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						return "unrecognized processor";
     bb1:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     bb8:	e9 78 03 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
		else if (cls == 12)
     bbd:	80 7d fc 0c          	cmp    BYTE PTR [rbp-0x4],0xc
     bc1:	0f 85 86 01 00 00    	jne    d4d <pci_get_subclass_string+0xa39>
				if (scls == 0)
     bc7:	80 7d f8 00          	cmp    BYTE PTR [rbp-0x8],0x0
     bcb:	75 30                	jne    bfd <pci_get_subclass_string+0x8e9>
						if (progIf == 0)
     bcd:	80 7d f4 00          	cmp    BYTE PTR [rbp-0xc],0x0
     bd1:	75 0c                	jne    bdf <pci_get_subclass_string+0x8cb>
								return "IEEE 1394 controller (FireWire)";
     bd3:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     bda:	e9 56 03 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 0x10)
     bdf:	80 7d f4 10          	cmp    BYTE PTR [rbp-0xc],0x10
     be3:	75 0c                	jne    bf1 <pci_get_subclass_string+0x8dd>
								return "IEEE 1394 controller (OpenHCI)";
     be5:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     bec:	e9 44 03 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
								return "unrecognized FireWire-compatible controller";
     bf1:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     bf8:	e9 38 03 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 1)
     bfd:	80 7d f8 01          	cmp    BYTE PTR [rbp-0x8],0x1
     c01:	75 0c                	jne    c0f <pci_get_subclass_string+0x8fb>
						return "ACCESS bus";
     c03:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     c0a:	e9 26 03 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 2)
     c0f:	80 7d f8 02          	cmp    BYTE PTR [rbp-0x8],0x2
     c13:	75 0c                	jne    c21 <pci_get_subclass_string+0x90d>
						return "SSA";
     c15:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     c1c:	e9 14 03 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 3)
     c21:	80 7d f8 03          	cmp    BYTE PTR [rbp-0x8],0x3
     c25:	75 78                	jne    c9f <pci_get_subclass_string+0x98b>
						if (progIf == 0)
     c27:	80 7d f4 00          	cmp    BYTE PTR [rbp-0xc],0x0
     c2b:	75 0c                	jne    c39 <pci_get_subclass_string+0x925>
								return "USB (universal host controller)";
     c2d:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     c34:	e9 fc 02 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 0x10)
     c39:	80 7d f4 10          	cmp    BYTE PTR [rbp-0xc],0x10
     c3d:	75 0c                	jne    c4b <pci_get_subclass_string+0x937>
								return "USB (open host controller)";
     c3f:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     c46:	e9 ea 02 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 0x20)
     c4b:	80 7d f4 20          	cmp    BYTE PTR [rbp-0xc],0x20
     c4f:	75 0c                	jne    c5d <pci_get_subclass_string+0x949>
								return "USB2 host controller (EHCI)";
     c51:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     c58:	e9 d8 02 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 0x30)
     c5d:	80 7d f4 30          	cmp    BYTE PTR [rbp-0xc],0x30
     c61:	75 0c                	jne    c6f <pci_get_subclass_string+0x95b>
								return "USB3 host controller (xHCI)";
     c63:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     c6a:	e9 c6 02 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 0x80)
     c6f:	80 7d f4 80          	cmp    BYTE PTR [rbp-0xc],0x80
     c73:	75 0c                	jne    c81 <pci_get_subclass_string+0x96d>
								return "USB";
     c75:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     c7c:	e9 b4 02 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 0xfe)
     c81:	80 7d f4 fe          	cmp    BYTE PTR [rbp-0xc],0xfe
     c85:	75 0c                	jne    c93 <pci_get_subclass_string+0x97f>
								return "USB (not host controller)";
     c87:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     c8e:	e9 a2 02 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
								return "unrecognized USB controller";
     c93:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     c9a:	e9 96 02 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 4)
     c9f:	80 7d f8 04          	cmp    BYTE PTR [rbp-0x8],0x4
     ca3:	75 0c                	jne    cb1 <pci_get_subclass_string+0x99d>
						return "Fibre channel";
     ca5:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     cac:	e9 84 02 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 5)
     cb1:	80 7d f8 05          	cmp    BYTE PTR [rbp-0x8],0x5
     cb5:	75 0c                	jne    cc3 <pci_get_subclass_string+0x9af>
						return "SMBus";
     cb7:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     cbe:	e9 72 02 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 6)
     cc3:	80 7d f8 06          	cmp    BYTE PTR [rbp-0x8],0x6
     cc7:	75 0c                	jne    cd5 <pci_get_subclass_string+0x9c1>
						return "InfiniBand";
     cc9:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     cd0:	e9 60 02 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 7)
     cd5:	80 7d f8 07          	cmp    BYTE PTR [rbp-0x8],0x7
     cd9:	75 42                	jne    d1d <pci_get_subclass_string+0xa09>
						if (progIf == 0)
     cdb:	80 7d f4 00          	cmp    BYTE PTR [rbp-0xc],0x0
     cdf:	75 0c                	jne    ced <pci_get_subclass_string+0x9d9>
								return "IPMI SMIC interface";
     ce1:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     ce8:	e9 48 02 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 1)
     ced:	80 7d f4 01          	cmp    BYTE PTR [rbp-0xc],0x1
     cf1:	75 0c                	jne    cff <pci_get_subclass_string+0x9eb>
								return "IPMI kbd controller style interface";
     cf3:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     cfa:	e9 36 02 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						else if (progIf == 2)
     cff:	80 7d f4 02          	cmp    BYTE PTR [rbp-0xc],0x2
     d03:	75 0c                	jne    d11 <pci_get_subclass_string+0x9fd>
								return "IPMI block transfer interface";
     d05:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     d0c:	e9 24 02 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
								return "unrecognized IMPI interface";
     d11:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     d18:	e9 18 02 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 8)
     d1d:	80 7d f8 08          	cmp    BYTE PTR [rbp-0x8],0x8
     d21:	75 0c                	jne    d2f <pci_get_subclass_string+0xa1b>
						return "SERCOS interface (IEC61491)";
     d23:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     d2a:	e9 06 02 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 9)
     d2f:	80 7d f8 09          	cmp    BYTE PTR [rbp-0x8],0x9
     d33:	75 0c                	jne    d41 <pci_get_subclass_string+0xa2d>
						return "CANbus";
     d35:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     d3c:	e9 f4 01 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						return "other bus interface";
     d41:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     d48:	e9 e8 01 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
		else if (cls == 13)
     d4d:	80 7d fc 0d          	cmp    BYTE PTR [rbp-0x4],0xd
     d51:	0f 85 9c 00 00 00    	jne    df3 <pci_get_subclass_string+0xadf>
				if (scls == 0)
     d57:	80 7d f8 00          	cmp    BYTE PTR [rbp-0x8],0x0
     d5b:	75 0c                	jne    d69 <pci_get_subclass_string+0xa55>
						return "iRDA compatible controller";
     d5d:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     d64:	e9 cc 01 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 1)
     d69:	80 7d f8 01          	cmp    BYTE PTR [rbp-0x8],0x1
     d6d:	75 0c                	jne    d7b <pci_get_subclass_string+0xa67>
						return "consumer IR controller";
     d6f:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     d76:	e9 ba 01 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 0x10)
     d7b:	80 7d f8 10          	cmp    BYTE PTR [rbp-0x8],0x10
     d7f:	75 0c                	jne    d8d <pci_get_subclass_string+0xa79>
						return "RF controller";
     d81:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     d88:	e9 a8 01 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 0x11)
     d8d:	80 7d f8 11          	cmp    BYTE PTR [rbp-0x8],0x11
     d91:	75 0c                	jne    d9f <pci_get_subclass_string+0xa8b>
						return "Bluetooth controller";
     d93:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     d9a:	e9 96 01 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 0x12)
     d9f:	80 7d f8 12          	cmp    BYTE PTR [rbp-0x8],0x12
     da3:	75 0c                	jne    db1 <pci_get_subclass_string+0xa9d>
						return "Broadband controller";
     da5:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     dac:	e9 84 01 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 0x20)
     db1:	80 7d f8 20          	cmp    BYTE PTR [rbp-0x8],0x20
     db5:	75 0c                	jne    dc3 <pci_get_subclass_string+0xaaf>
						return "Ethernet controller (802.11a)";
     db7:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     dbe:	e9 72 01 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 0x21)
     dc3:	80 7d f8 21          	cmp    BYTE PTR [rbp-0x8],0x21
     dc7:	75 0c                	jne    dd5 <pci_get_subclass_string+0xac1>
						return "Ethernet controller (802.11b)";
     dc9:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     dd0:	e9 60 01 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 0x80)
     dd5:	80 7d f8 80          	cmp    BYTE PTR [rbp-0x8],0x80
     dd9:	75 0c                	jne    de7 <pci_get_subclass_string+0xad3>
						return "other wireless controller";
     ddb:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     de2:	e9 4e 01 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						return "unrecognized wireless controller";
     de7:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     dee:	e9 42 01 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
		else if (cls == 14)
     df3:	80 7d fc 0e          	cmp    BYTE PTR [rbp-0x4],0xe
     df7:	75 30                	jne    e29 <pci_get_subclass_string+0xb15>
				if (scls == 0)
     df9:	80 7d f8 00          	cmp    BYTE PTR [rbp-0x8],0x0
     dfd:	75 1e                	jne    e1d <pci_get_subclass_string+0xb09>
						if (progIf == 0)
     dff:	80 7d f4 00          	cmp    BYTE PTR [rbp-0xc],0x0
     e03:	75 0c                	jne    e11 <pci_get_subclass_string+0xafd>
								return "Message FIFO";
     e05:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     e0c:	e9 24 01 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
								return "I20 architecture";
     e11:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     e18:	e9 18 01 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						return "other intelligent I/O controller";
     e1d:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     e24:	e9 0c 01 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
		else if (cls == 15)
     e29:	80 7d fc 0f          	cmp    BYTE PTR [rbp-0x4],0xf
     e2d:	75 54                	jne    e83 <pci_get_subclass_string+0xb6f>
				if (scls == 1)
     e2f:	80 7d f8 01          	cmp    BYTE PTR [rbp-0x8],0x1
     e33:	75 0c                	jne    e41 <pci_get_subclass_string+0xb2d>
						return "TV controller";
     e35:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     e3c:	e9 f4 00 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 2)
     e41:	80 7d f8 02          	cmp    BYTE PTR [rbp-0x8],0x2
     e45:	75 0c                	jne    e53 <pci_get_subclass_string+0xb3f>
						return "audio controller";
     e47:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     e4e:	e9 e2 00 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 3)
     e53:	80 7d f8 03          	cmp    BYTE PTR [rbp-0x8],0x3
     e57:	75 0c                	jne    e65 <pci_get_subclass_string+0xb51>
						return "voice controller";
     e59:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     e60:	e9 d0 00 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 4)
     e65:	80 7d f8 04          	cmp    BYTE PTR [rbp-0x8],0x4
     e69:	75 0c                	jne    e77 <pci_get_subclass_string+0xb63>
						return "data controller";
     e6b:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     e72:	e9 be 00 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
						return "other satellite controller";
     e77:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     e7e:	e9 b2 00 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
		else if (cls == 16)
     e83:	80 7d fc 10          	cmp    BYTE PTR [rbp-0x4],0x10
     e87:	75 3c                	jne    ec5 <pci_get_subclass_string+0xbb1>
				if (scls == 0)
     e89:	80 7d f8 00          	cmp    BYTE PTR [rbp-0x8],0x0
     e8d:	75 0c                	jne    e9b <pci_get_subclass_string+0xb87>
						return "network and computing de/en-cryption";
     e8f:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     e96:	e9 9a 00 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 0x10)
     e9b:	80 7d f8 10          	cmp    BYTE PTR [rbp-0x8],0x10
     e9f:	75 0c                	jne    ead <pci_get_subclass_string+0xb99>
						return "entertainent de/en-cryption";
     ea1:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     ea8:	e9 88 00 00 00       	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 0x80)
     ead:	80 7d f8 80          	cmp    BYTE PTR [rbp-0x8],0x80
     eb1:	75 09                	jne    ebc <pci_get_subclass_string+0xba8>
						return "other de/en-cryption";
     eb3:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     eba:	eb 79                	jmp    f35 <pci_get_subclass_string+0xc21>
						return "unrecognized de/en-cryption";
     ebc:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     ec3:	eb 70                	jmp    f35 <pci_get_subclass_string+0xc21>
		else if (cls == 17)
     ec5:	80 7d fc 11          	cmp    BYTE PTR [rbp-0x4],0x11
     ec9:	75 54                	jne    f1f <pci_get_subclass_string+0xc0b>
				if (scls == 0)
     ecb:	80 7d f8 00          	cmp    BYTE PTR [rbp-0x8],0x0
     ecf:	75 09                	jne    eda <pci_get_subclass_string+0xbc6>
						return "DPIO modules";
     ed1:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     ed8:	eb 5b                	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 1)
     eda:	80 7d f8 01          	cmp    BYTE PTR [rbp-0x8],0x1
     ede:	75 09                	jne    ee9 <pci_get_subclass_string+0xbd5>
						return "performance conters";
     ee0:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     ee7:	eb 4c                	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 0x10)
     ee9:	80 7d f8 10          	cmp    BYTE PTR [rbp-0x8],0x10
     eed:	75 09                	jne    ef8 <pci_get_subclass_string+0xbe4>
						return "communications synch plus time and freq test/measurement";
     eef:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     ef6:	eb 3d                	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 0x20)
     ef8:	80 7d f8 20          	cmp    BYTE PTR [rbp-0x8],0x20
     efc:	75 09                	jne    f07 <pci_get_subclass_string+0xbf3>
						return "management card";
     efe:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     f05:	eb 2e                	jmp    f35 <pci_get_subclass_string+0xc21>
				else if (scls == 0x80)
     f07:	80 7d f8 80          	cmp    BYTE PTR [rbp-0x8],0x80
     f0b:	75 09                	jne    f16 <pci_get_subclass_string+0xc02>
						return "other data acquisition/signal processing controller";
     f0d:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     f14:	eb 1f                	jmp    f35 <pci_get_subclass_string+0xc21>
						return "unrecognized data acquisition/signal processing controller";
     f16:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     f1d:	eb 16                	jmp    f35 <pci_get_subclass_string+0xc21>
		else if (cls == 0xff)
     f1f:	80 7d fc ff          	cmp    BYTE PTR [rbp-0x4],0xff
     f23:	75 09                	jne    f2e <pci_get_subclass_string+0xc1a>
				return "device not fitting defined class";
     f25:	48 c7 c0 00 00 00 00 	mov    rax,0x0
     f2c:	eb 07                	jmp    f35 <pci_get_subclass_string+0xc21>
				return "unrecognized device class";
     f2e:	48 c7 c0 00 00 00 00 	mov    rax,0x0
}
     f35:	c9                   	leave
     f36:	c3                   	ret

0000000000000f37 <pci_disable_interrupts>:
{
     f37:	55                   	push   rbp
     f38:	48 89 e5             	mov    rbp,rsp
     f3b:	48 83 ec 18          	sub    rsp,0x18
     f3f:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		union pca a = d->addr; uint32_t dat;
     f43:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     f47:	8b 00                	mov    eax,DWORD PTR [rax]
     f49:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
		a.reg_no = PCI_COMMAND;
     f4c:	c6 45 f8 04          	mov    BYTE PTR [rbp-0x8],0x4
		dat = pci_read(a);
     f50:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
     f53:	89 c7                	mov    edi,eax
     f55:	e8 7f f1 ff ff       	call   d9 <pci_read>
     f5a:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		if (dat & PCI_COMMAND_INTX_DISABLE)
     f5d:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     f60:	25 00 04 00 00       	and    eax,0x400
     f65:	85 c0                	test   eax,eax
     f67:	74 07                	je     f70 <pci_disable_interrupts+0x39>
				return 0;
     f69:	b8 00 00 00 00       	mov    eax,0x0
     f6e:	eb 33                	jmp    fa3 <pci_disable_interrupts+0x6c>
		dat |= PCI_COMMAND_INTX_DISABLE;
     f70:	81 4d fc 00 04 00 00 	or     DWORD PTR [rbp-0x4],0x400
		pci_write(a, dat);
     f77:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
     f7a:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
     f7d:	89 d6                	mov    esi,edx
     f7f:	89 c7                	mov    edi,eax
     f81:	e8 4f f2 ff ff       	call   1d5 <pci_write>
		dat = pci_read(a);
     f86:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
     f89:	89 c7                	mov    edi,eax
     f8b:	e8 49 f1 ff ff       	call   d9 <pci_read>
     f90:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		return !(dat & PCI_COMMAND_INTX_DISABLE);
     f93:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     f96:	25 00 04 00 00       	and    eax,0x400
     f9b:	85 c0                	test   eax,eax
     f9d:	0f 94 c0             	sete   al
     fa0:	0f b6 c0             	movzx  eax,al
}
     fa3:	c9                   	leave
     fa4:	c3                   	ret

0000000000000fa5 <pci_enable_interrupts>:
{
     fa5:	55                   	push   rbp
     fa6:	48 89 e5             	mov    rbp,rsp
     fa9:	48 83 ec 18          	sub    rsp,0x18
     fad:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		union pca a = d->addr; uint32_t dat;
     fb1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     fb5:	8b 00                	mov    eax,DWORD PTR [rax]
     fb7:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
		a.reg_no = PCI_COMMAND;
     fba:	c6 45 f8 04          	mov    BYTE PTR [rbp-0x8],0x4
		dat = pci_read(a);
     fbe:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
     fc1:	89 c7                	mov    edi,eax
     fc3:	e8 11 f1 ff ff       	call   d9 <pci_read>
     fc8:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		if (!(dat & PCI_COMMAND_INTX_DISABLE))
     fcb:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     fce:	25 00 04 00 00       	and    eax,0x400
     fd3:	85 c0                	test   eax,eax
     fd5:	75 07                	jne    fde <pci_enable_interrupts+0x39>
				return 0;
     fd7:	b8 00 00 00 00       	mov    eax,0x0
     fdc:	eb 33                	jmp    1011 <pci_enable_interrupts+0x6c>
		dat &= 0xffff0000 | ~(PCI_COMMAND_INTX_DISABLE);
     fde:	81 65 fc ff fb ff ff 	and    DWORD PTR [rbp-0x4],0xfffffbff
		pci_write(a, dat);
     fe5:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
     fe8:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
     feb:	89 d6                	mov    esi,edx
     fed:	89 c7                	mov    edi,eax
     fef:	e8 e1 f1 ff ff       	call   1d5 <pci_write>
		dat = pci_read(a);
     ff4:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
     ff7:	89 c7                	mov    edi,eax
     ff9:	e8 db f0 ff ff       	call   d9 <pci_read>
     ffe:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		return !!(dat & PCI_COMMAND_INTX_DISABLE);
    1001:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1004:	25 00 04 00 00       	and    eax,0x400
    1009:	85 c0                	test   eax,eax
    100b:	0f 95 c0             	setne  al
    100e:	0f b6 c0             	movzx  eax,al
}
    1011:	c9                   	leave
    1012:	c3                   	ret

0000000000001013 <pci_print_is>:
{
    1013:	55                   	push   rbp
    1014:	48 89 e5             	mov    rbp,rsp
    1017:	48 83 ec 20          	sub    rsp,0x20
    101b:	89 7d ec             	mov    DWORD PTR [rbp-0x14],edi
		ad.reg_no = PCI_STATUS;
    101e:	c6 45 ec 06          	mov    BYTE PTR [rbp-0x14],0x6
		rv = !!(pci_read_word(ad) & PCI_STATUS_INTERRUPT);
    1022:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    1025:	89 c7                	mov    edi,eax
    1027:	e8 dd f0 ff ff       	call   109 <pci_read_word>
    102c:	0f b7 c0             	movzx  eax,ax
    102f:	83 e0 08             	and    eax,0x8
    1032:	85 c0                	test   eax,eax
    1034:	0f 95 c0             	setne  al
    1037:	0f b6 c0             	movzx  eax,al
    103a:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		printf("PCI IS: %d\n", rv);
    103d:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1040:	89 c6                	mov    esi,eax
    1042:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1049:	b8 00 00 00 00       	mov    eax,0x0
    104e:	e8 00 00 00 00       	call   1053 <pci_print_is+0x40>
}
    1053:	90                   	nop
    1054:	c9                   	leave
    1055:	c3                   	ret

0000000000001056 <pci_set_master>:
{
    1056:	55                   	push   rbp
    1057:	48 89 e5             	mov    rbp,rsp
    105a:	48 83 ec 18          	sub    rsp,0x18
    105e:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		union pca a = d->addr; uint32_t dat;
    1062:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1066:	8b 00                	mov    eax,DWORD PTR [rax]
    1068:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
		a.reg_no = PCI_COMMAND;
    106b:	c6 45 f8 04          	mov    BYTE PTR [rbp-0x8],0x4
		dat = pci_read(a);
    106f:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    1072:	89 c7                	mov    edi,eax
    1074:	e8 60 f0 ff ff       	call   d9 <pci_read>
    1079:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		if (dat & PCI_COMMAND_MASTER)
    107c:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    107f:	83 e0 04             	and    eax,0x4
    1082:	85 c0                	test   eax,eax
    1084:	74 07                	je     108d <pci_set_master+0x37>
				return 0;
    1086:	b8 00 00 00 00       	mov    eax,0x0
    108b:	eb 2e                	jmp    10bb <pci_set_master+0x65>
		dat &= 0xffff0000 | ~(PCI_COMMAND_MASTER);
    108d:	83 65 fc fb          	and    DWORD PTR [rbp-0x4],0xfffffffb
		pci_write(a, dat);
    1091:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    1094:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    1097:	89 d6                	mov    esi,edx
    1099:	89 c7                	mov    edi,eax
    109b:	e8 35 f1 ff ff       	call   1d5 <pci_write>
		dat = pci_read(a);
    10a0:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    10a3:	89 c7                	mov    edi,eax
    10a5:	e8 2f f0 ff ff       	call   d9 <pci_read>
    10aa:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		return !(dat & PCI_COMMAND_MASTER);
    10ad:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    10b0:	83 e0 04             	and    eax,0x4
    10b3:	85 c0                	test   eax,eax
    10b5:	0f 94 c0             	sete   al
    10b8:	0f b6 c0             	movzx  eax,al
}
    10bb:	c9                   	leave
    10bc:	c3                   	ret

00000000000010bd <pci_check_interrupt>:
{
    10bd:	55                   	push   rbp
    10be:	48 89 e5             	mov    rbp,rsp
    10c1:	48 83 ec 18          	sub    rsp,0x18
    10c5:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		union pca a = d->addr;
    10c9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    10cd:	8b 00                	mov    eax,DWORD PTR [rax]
    10cf:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		a.reg_no = PCI_STATUS;
    10d2:	c6 45 fc 06          	mov    BYTE PTR [rbp-0x4],0x6
		if (pci_read_word(a) & PCI_STATUS_INTERRUPT)
    10d6:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    10d9:	89 c7                	mov    edi,eax
    10db:	e8 29 f0 ff ff       	call   109 <pci_read_word>
    10e0:	0f b7 c0             	movzx  eax,ax
    10e3:	83 e0 08             	and    eax,0x8
    10e6:	85 c0                	test   eax,eax
    10e8:	74 07                	je     10f1 <pci_check_interrupt+0x34>
				return 1;
    10ea:	b8 01 00 00 00       	mov    eax,0x1
    10ef:	eb 05                	jmp    10f6 <pci_check_interrupt+0x39>
		return 0;
    10f1:	b8 00 00 00 00       	mov    eax,0x0
}
    10f6:	c9                   	leave
    10f7:	c3                   	ret

00000000000010f8 <pci_find_device>:
{
    10f8:	55                   	push   rbp
    10f9:	48 89 e5             	mov    rbp,rsp
    10fc:	48 83 ec 30          	sub    rsp,0x30
    1100:	89 d0                	mov    eax,edx
    1102:	89 4d d0             	mov    DWORD PTR [rbp-0x30],ecx
    1105:	89 fa                	mov    edx,edi
    1107:	88 55 dc             	mov    BYTE PTR [rbp-0x24],dl
    110a:	89 f2                	mov    edx,esi
    110c:	88 55 d8             	mov    BYTE PTR [rbp-0x28],dl
    110f:	88 45 d4             	mov    BYTE PTR [rbp-0x2c],al
		struct dle* d; struct pci_device* rv = NULL;
    1112:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		lock_list(device_list.devices);
    111a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1121:	e8 00 00 00 00       	call   1126 <pci_find_device+0x2e>
		list_for_each_entry(d, &device_list.devices, devices) {
    1126:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 112d <pci_find_device+0x35>
    112d:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1131:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1135:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1139:	eb 5c                	jmp    1197 <pci_find_device+0x9f>
				if (d->dev.device_class == cls && d->dev.device_subclass == subcls) {
    113b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    113f:	0f b6 40 1c          	movzx  eax,BYTE PTR [rax+0x1c]
    1143:	38 45 dc             	cmp    BYTE PTR [rbp-0x24],al
    1146:	75 3b                	jne    1183 <pci_find_device+0x8b>
    1148:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    114c:	0f b6 40 1d          	movzx  eax,BYTE PTR [rax+0x1d]
    1150:	38 45 d8             	cmp    BYTE PTR [rbp-0x28],al
    1153:	75 2e                	jne    1183 <pci_find_device+0x8b>
						if (d->dev.device_interface == ifc || ifc == 0xff) {
    1155:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1159:	0f b6 40 1e          	movzx  eax,BYTE PTR [rax+0x1e]
    115d:	38 45 d4             	cmp    BYTE PTR [rbp-0x2c],al
    1160:	74 06                	je     1168 <pci_find_device+0x70>
    1162:	80 7d d4 ff          	cmp    BYTE PTR [rbp-0x2c],0xff
    1166:	75 1b                	jne    1183 <pci_find_device+0x8b>
								if (!ct--) {
    1168:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
    116b:	8d 50 ff             	lea    edx,[rax-0x1]
    116e:	89 55 d0             	mov    DWORD PTR [rbp-0x30],edx
    1171:	85 c0                	test   eax,eax
    1173:	75 0e                	jne    1183 <pci_find_device+0x8b>
										rv = &d->dev;
    1175:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1179:	48 83 c0 18          	add    rax,0x18
    117d:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
										goto exit;
    1181:	eb 1f                	jmp    11a2 <pci_find_device+0xaa>
		list_for_each_entry(d, &device_list.devices, devices) {
    1183:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1187:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    118b:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    118f:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1193:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1197:	48 81 7d f8 00 00 00 00 	cmp    QWORD PTR [rbp-0x8],0x0
    119f:	75 9a                	jne    113b <pci_find_device+0x43>
exit:
    11a1:	90                   	nop
		unlock_list(device_list.devices);
    11a2:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    11a9:	e8 00 00 00 00       	call   11ae <pci_find_device+0xb6>
		return rv;
    11ae:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
}
    11b2:	c9                   	leave
    11b3:	c3                   	ret

00000000000011b4 <pci_set_bar>:
{
    11b4:	55                   	push   rbp
    11b5:	48 89 e5             	mov    rbp,rsp
    11b8:	48 83 ec 28          	sub    rsp,0x28
    11bc:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    11c0:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
    11c3:	89 55 e0             	mov    DWORD PTR [rbp-0x20],edx
    11c6:	48 89 4d d8          	mov    QWORD PTR [rbp-0x28],rcx
		union pca addr = dev->addr;
    11ca:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    11ce:	8b 00                	mov    eax,DWORD PTR [rax]
    11d0:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
		if (i > 5)
    11d3:	83 7d e4 05          	cmp    DWORD PTR [rbp-0x1c],0x5
    11d7:	0f 87 37 02 00 00    	ja     1414 <pci_set_bar+0x260>
		addr.reg_no = PCI_BASE_ADDRESS_0 + i * 4;
    11dd:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    11e0:	83 c0 04             	add    eax,0x4
    11e3:	c1 e0 02             	shl    eax,0x2
    11e6:	88 45 f8             	mov    BYTE PTR [rbp-0x8],al
		dat = pci_read(addr);
    11e9:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    11ec:	89 c7                	mov    edi,eax
    11ee:	e8 e6 ee ff ff       	call   d9 <pci_read>
    11f3:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		if ((dat & 0xf) != tp) /* only I/O space for those */
    11f6:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    11f9:	83 e0 0f             	and    eax,0xf
    11fc:	39 45 e0             	cmp    DWORD PTR [rbp-0x20],eax
    11ff:	0f 85 12 02 00 00    	jne    1417 <pci_set_bar+0x263>
		if (i > 5 || ((tp & PCI_BAR_64_BIT) && i == 5))
    1205:	83 7d e4 05          	cmp    DWORD PTR [rbp-0x1c],0x5
    1209:	0f 87 0b 02 00 00    	ja     141a <pci_set_bar+0x266>
    120f:	8b 45 e0             	mov    eax,DWORD PTR [rbp-0x20]
    1212:	83 e0 04             	and    eax,0x4
    1215:	85 c0                	test   eax,eax
    1217:	74 0a                	je     1223 <pci_set_bar+0x6f>
    1219:	83 7d e4 05          	cmp    DWORD PTR [rbp-0x1c],0x5
    121d:	0f 84 f7 01 00 00    	je     141a <pci_set_bar+0x266>
		if (tp & PCI_BAR_PIO) {
    1223:	8b 45 e0             	mov    eax,DWORD PTR [rbp-0x20]
    1226:	83 e0 01             	and    eax,0x1
    1229:	85 c0                	test   eax,eax
    122b:	74 58                	je     1285 <pci_set_bar+0xd1>
				dat = (dat & 0x3) | ((uint32_t)ofs & 0xfffc);
    122d:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1230:	83 e0 03             	and    eax,0x3
    1233:	89 c2                	mov    edx,eax
    1235:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1239:	25 fc ff 00 00       	and    eax,0xfffc
    123e:	09 d0                	or     eax,edx
    1240:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
				pci_write(addr, dat);
    1243:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    1246:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    1249:	89 d6                	mov    esi,edx
    124b:	89 c7                	mov    edi,eax
    124d:	e8 83 ef ff ff       	call   1d5 <pci_write>
				dat = pci_read(addr);
    1252:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    1255:	89 c7                	mov    edi,eax
    1257:	e8 7d ee ff ff       	call   d9 <pci_read>
    125c:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
				dev->ressources[i].pio.base = (dat & 0xfffc);
    125f:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1262:	83 e0 fc             	and    eax,0xfffffffc
    1265:	89 c2                	mov    edx,eax
    1267:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    126b:	8b 4d e4             	mov    ecx,DWORD PTR [rbp-0x1c]
    126e:	48 83 c1 01          	add    rcx,0x1
    1272:	48 c1 e1 05          	shl    rcx,0x5
    1276:	48 01 c8             	add    rax,rcx
    1279:	48 83 c0 10          	add    rax,0x10
    127d:	66 89 10             	mov    WORD PTR [rax],dx
    1280:	e9 96 01 00 00       	jmp    141b <pci_set_bar+0x267>
		} else if (tp & PCI_BAR_16_BIT) {
    1285:	8b 45 e0             	mov    eax,DWORD PTR [rbp-0x20]
    1288:	83 e0 02             	and    eax,0x2
    128b:	85 c0                	test   eax,eax
    128d:	74 5b                	je     12ea <pci_set_bar+0x136>
				dat = (dat & 0xf) | ((uint32_t)ofs & 0x0000fff0);
    128f:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1292:	83 e0 0f             	and    eax,0xf
    1295:	89 c2                	mov    edx,eax
    1297:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    129b:	25 f0 ff 00 00       	and    eax,0xfff0
    12a0:	09 d0                	or     eax,edx
    12a2:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
				pci_write(addr, dat);
    12a5:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    12a8:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    12ab:	89 d6                	mov    esi,edx
    12ad:	89 c7                	mov    edi,eax
    12af:	e8 21 ef ff ff       	call   1d5 <pci_write>
				dat = pci_read(addr);
    12b4:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    12b7:	89 c7                	mov    edi,eax
    12b9:	e8 1b ee ff ff       	call   d9 <pci_read>
    12be:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
				dev->ressources[i].mmio.base = (dat & 0xfff0);
    12c1:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    12c4:	25 f0 ff 00 00       	and    eax,0xfff0
    12c9:	48 89 c2             	mov    rdx,rax
    12cc:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    12d0:	8b 4d e4             	mov    ecx,DWORD PTR [rbp-0x1c]
    12d3:	48 83 c1 01          	add    rcx,0x1
    12d7:	48 c1 e1 05          	shl    rcx,0x5
    12db:	48 01 c8             	add    rax,rcx
    12de:	48 83 c0 10          	add    rax,0x10
    12e2:	48 89 10             	mov    QWORD PTR [rax],rdx
    12e5:	e9 31 01 00 00       	jmp    141b <pci_set_bar+0x267>
		} else if (tp & PCI_BAR_64_BIT) {
    12ea:	8b 45 e0             	mov    eax,DWORD PTR [rbp-0x20]
    12ed:	83 e0 04             	and    eax,0x4
    12f0:	85 c0                	test   eax,eax
    12f2:	0f 84 cb 00 00 00    	je     13c3 <pci_set_bar+0x20f>
				dat = (dat & 0xf) | ((uint32_t)ofs & 0xfffffff0);
    12f8:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    12fb:	83 e0 0f             	and    eax,0xf
    12fe:	89 c2                	mov    edx,eax
    1300:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1304:	83 e0 f0             	and    eax,0xfffffff0
    1307:	09 d0                	or     eax,edx
    1309:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
				pci_write(addr, dat);
    130c:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    130f:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    1312:	89 d6                	mov    esi,edx
    1314:	89 c7                	mov    edi,eax
    1316:	e8 ba ee ff ff       	call   1d5 <pci_write>
				addr.reg_no += 4;
    131b:	0f b6 45 f8          	movzx  eax,BYTE PTR [rbp-0x8]
    131f:	83 c0 04             	add    eax,0x4
    1322:	88 45 f8             	mov    BYTE PTR [rbp-0x8],al
				dat = (uint32_t)(ofs >> 32);
    1325:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1329:	48 c1 e8 20          	shr    rax,0x20
    132d:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
				pci_write(addr, dat);
    1330:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    1333:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    1336:	89 d6                	mov    esi,edx
    1338:	89 c7                	mov    edi,eax
    133a:	e8 96 ee ff ff       	call   1d5 <pci_write>
				dat = pci_read(addr);
    133f:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    1342:	89 c7                	mov    edi,eax
    1344:	e8 90 ed ff ff       	call   d9 <pci_read>
    1349:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
				dev->ressources[i].mmio.base = (uint64_t)dat << 32;
    134c:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    134f:	48 c1 e0 20          	shl    rax,0x20
    1353:	48 89 c2             	mov    rdx,rax
    1356:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    135a:	8b 4d e4             	mov    ecx,DWORD PTR [rbp-0x1c]
    135d:	48 83 c1 01          	add    rcx,0x1
    1361:	48 c1 e1 05          	shl    rcx,0x5
    1365:	48 01 c8             	add    rax,rcx
    1368:	48 83 c0 10          	add    rax,0x10
    136c:	48 89 10             	mov    QWORD PTR [rax],rdx
				addr.reg_no -= 4;
    136f:	0f b6 45 f8          	movzx  eax,BYTE PTR [rbp-0x8]
    1373:	83 e8 04             	sub    eax,0x4
    1376:	88 45 f8             	mov    BYTE PTR [rbp-0x8],al
				dat = pci_read(addr);
    1379:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    137c:	89 c7                	mov    edi,eax
    137e:	e8 56 ed ff ff       	call   d9 <pci_read>
    1383:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
				dev->ressources[i].mmio.base |= (dat & 0xfffffff0);
    1386:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    138a:	8b 55 e4             	mov    edx,DWORD PTR [rbp-0x1c]
    138d:	48 83 c2 01          	add    rdx,0x1
    1391:	48 c1 e2 05          	shl    rdx,0x5
    1395:	48 01 d0             	add    rax,rdx
    1398:	48 83 c0 10          	add    rax,0x10
    139c:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    139f:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    13a2:	83 e0 f0             	and    eax,0xfffffff0
    13a5:	48 09 c2             	or     rdx,rax
    13a8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13ac:	8b 4d e4             	mov    ecx,DWORD PTR [rbp-0x1c]
    13af:	48 83 c1 01          	add    rcx,0x1
    13b3:	48 c1 e1 05          	shl    rcx,0x5
    13b7:	48 01 c8             	add    rax,rcx
    13ba:	48 83 c0 10          	add    rax,0x10
    13be:	48 89 10             	mov    QWORD PTR [rax],rdx
    13c1:	eb 58                	jmp    141b <pci_set_bar+0x267>
				dat = (dat & 0xf) | ((uint32_t)ofs & 0xfffffff0);
    13c3:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    13c6:	83 e0 0f             	and    eax,0xf
    13c9:	89 c2                	mov    edx,eax
    13cb:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    13cf:	83 e0 f0             	and    eax,0xfffffff0
    13d2:	09 d0                	or     eax,edx
    13d4:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
				pci_write(addr, dat);
    13d7:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    13da:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    13dd:	89 d6                	mov    esi,edx
    13df:	89 c7                	mov    edi,eax
    13e1:	e8 ef ed ff ff       	call   1d5 <pci_write>
				dat = pci_read(addr);
    13e6:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    13e9:	89 c7                	mov    edi,eax
    13eb:	e8 e9 ec ff ff       	call   d9 <pci_read>
    13f0:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
				dev->ressources[i].mmio.base = (dat & 0xfffffff0);
    13f3:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    13f6:	83 e0 f0             	and    eax,0xfffffff0
    13f9:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    13fd:	8b 4d e4             	mov    ecx,DWORD PTR [rbp-0x1c]
    1400:	48 83 c1 01          	add    rcx,0x1
    1404:	48 c1 e1 05          	shl    rcx,0x5
    1408:	48 01 ca             	add    rdx,rcx
    140b:	48 83 c2 10          	add    rdx,0x10
    140f:	48 89 02             	mov    QWORD PTR [rdx],rax
    1412:	eb 07                	jmp    141b <pci_set_bar+0x267>
				return;
    1414:	90                   	nop
    1415:	eb 04                	jmp    141b <pci_set_bar+0x267>
				return;
    1417:	90                   	nop
    1418:	eb 01                	jmp    141b <pci_set_bar+0x267>
				return;
    141a:	90                   	nop
}
    141b:	c9                   	leave
    141c:	c3                   	ret

000000000000141d <pci_bar_get_size>:
{
    141d:	55                   	push   rbp
    141e:	48 89 e5             	mov    rbp,rsp
    1421:	48 83 ec 30          	sub    rsp,0x30
    1425:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
    1429:	89 75 d4             	mov    DWORD PTR [rbp-0x2c],esi
		union pca a = d->addr; uint32_t dat, datH;
    142c:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1430:	8b 00                	mov    eax,DWORD PTR [rax]
    1432:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
		uint64_t rv = 0;
    1435:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		if (i > 5)
    143d:	83 7d d4 05          	cmp    DWORD PTR [rbp-0x2c],0x5
    1441:	76 0a                	jbe    144d <pci_bar_get_size+0x30>
				return 0;
    1443:	b8 00 00 00 00       	mov    eax,0x0
    1448:	e9 3c 01 00 00       	jmp    1589 <pci_bar_get_size+0x16c>
		a.reg_no = PCI_BASE_ADDRESS_0 + i * 4;
    144d:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
    1450:	83 c0 04             	add    eax,0x4
    1453:	c1 e0 02             	shl    eax,0x2
    1456:	88 45 e8             	mov    BYTE PTR [rbp-0x18],al
		dat = pci_read(a);
    1459:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    145c:	89 c7                	mov    edi,eax
    145e:	e8 76 ec ff ff       	call   d9 <pci_read>
    1463:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
		if (dat & 1) { /* PIO */
    1466:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1469:	83 e0 01             	and    eax,0x1
    146c:	85 c0                	test   eax,eax
    146e:	74 47                	je     14b7 <pci_bar_get_size+0x9a>
				pci_write(a, 0xffff);
    1470:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    1473:	be ff ff 00 00       	mov    esi,0xffff
    1478:	89 c7                	mov    edi,eax
    147a:	e8 56 ed ff ff       	call   1d5 <pci_write>
				rv = pci_read(a) & 0xfffc;
    147f:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    1482:	89 c7                	mov    edi,eax
    1484:	e8 50 ec ff ff       	call   d9 <pci_read>
    1489:	89 c0                	mov    eax,eax
    148b:	25 fc ff 00 00       	and    eax,0xfffc
    1490:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				pci_write(a, dat);
    1494:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    1497:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    149a:	89 d6                	mov    esi,edx
    149c:	89 c7                	mov    edi,eax
    149e:	e8 32 ed ff ff       	call   1d5 <pci_write>
				rv = (uint64_t)(~(uint16_t)rv + 1);
    14a3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    14a7:	0f b7 c0             	movzx  eax,ax
    14aa:	f7 d8                	neg    eax
    14ac:	48 98                	cdqe
    14ae:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    14b2:	e9 ce 00 00 00       	jmp    1585 <pci_bar_get_size+0x168>
				uint32_t tp = (dat >> 1) & 0x3;
    14b7:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    14ba:	d1 e8                	shr    eax,1
    14bc:	83 e0 03             	and    eax,0x3
    14bf:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
				if (tp == 2) {
    14c2:	83 7d f0 02          	cmp    DWORD PTR [rbp-0x10],0x2
    14c6:	75 5d                	jne    1525 <pci_bar_get_size+0x108>
						a.reg_no += 4;
    14c8:	0f b6 45 e8          	movzx  eax,BYTE PTR [rbp-0x18]
    14cc:	83 c0 04             	add    eax,0x4
    14cf:	88 45 e8             	mov    BYTE PTR [rbp-0x18],al
						datH = pci_read(a);
    14d2:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    14d5:	89 c7                	mov    edi,eax
    14d7:	e8 fd eb ff ff       	call   d9 <pci_read>
    14dc:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
						pci_write(a, 0xffffffff);
    14df:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    14e2:	be ff ff ff ff       	mov    esi,0xffffffff
    14e7:	89 c7                	mov    edi,eax
    14e9:	e8 e7 ec ff ff       	call   1d5 <pci_write>
						a.reg_no -= 4;
    14ee:	0f b6 45 e8          	movzx  eax,BYTE PTR [rbp-0x18]
    14f2:	83 e8 04             	sub    eax,0x4
    14f5:	88 45 e8             	mov    BYTE PTR [rbp-0x18],al
						rv = (uint64_t)pci_read(a) << 32;
    14f8:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    14fb:	89 c7                	mov    edi,eax
    14fd:	e8 d7 eb ff ff       	call   d9 <pci_read>
    1502:	89 c0                	mov    eax,eax
    1504:	48 c1 e0 20          	shl    rax,0x20
    1508:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						pci_write(a, datH);
    150c:	8b 55 ec             	mov    edx,DWORD PTR [rbp-0x14]
    150f:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    1512:	89 d6                	mov    esi,edx
    1514:	89 c7                	mov    edi,eax
    1516:	e8 ba ec ff ff       	call   1d5 <pci_write>
						a.reg_no -= 4;
    151b:	0f b6 45 e8          	movzx  eax,BYTE PTR [rbp-0x18]
    151f:	83 e8 04             	sub    eax,0x4
    1522:	88 45 e8             	mov    BYTE PTR [rbp-0x18],al
				pci_write(a, 0xffffffff);
    1525:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    1528:	be ff ff ff ff       	mov    esi,0xffffffff
    152d:	89 c7                	mov    edi,eax
    152f:	e8 a1 ec ff ff       	call   1d5 <pci_write>
				rv |= (pci_read(a) & 0xfffffff0);
    1534:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    1537:	89 c7                	mov    edi,eax
    1539:	e8 9b eb ff ff       	call   d9 <pci_read>
    153e:	83 e0 f0             	and    eax,0xfffffff0
    1541:	89 c0                	mov    eax,eax
    1543:	48 09 45 f8          	or     QWORD PTR [rbp-0x8],rax
				pci_write(a, dat);
    1547:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    154a:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    154d:	89 d6                	mov    esi,edx
    154f:	89 c7                	mov    edi,eax
    1551:	e8 7f ec ff ff       	call   1d5 <pci_write>
				if (tp == 2) {
    1556:	83 7d f0 02          	cmp    DWORD PTR [rbp-0x10],0x2
    155a:	75 06                	jne    1562 <pci_bar_get_size+0x145>
						rv = ~rv + 1;
    155c:	48 f7 5d f8          	neg    QWORD PTR [rbp-0x8]
    1560:	eb 23                	jmp    1585 <pci_bar_get_size+0x168>
				} else if (tp == 1) {
    1562:	83 7d f0 01          	cmp    DWORD PTR [rbp-0x10],0x1
    1566:	75 11                	jne    1579 <pci_bar_get_size+0x15c>
						rv = (uint64_t)(~(uint16_t)rv + 1);
    1568:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    156c:	0f b7 c0             	movzx  eax,ax
    156f:	f7 d8                	neg    eax
    1571:	48 98                	cdqe
    1573:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1577:	eb 0c                	jmp    1585 <pci_bar_get_size+0x168>
						rv = (uint64_t)(~(uint32_t)rv + 1);
    1579:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    157d:	f7 d8                	neg    eax
    157f:	89 c0                	mov    eax,eax
    1581:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		return rv;
    1585:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
}
    1589:	c9                   	leave
    158a:	c3                   	ret

000000000000158b <pci_init_msi>:
{
    158b:	55                   	push   rbp
    158c:	48 89 e5             	mov    rbp,rsp
    158f:	48 83 ec 20          	sub    rsp,0x20
    1593:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		uint32_t dat; union pca a = d->addr;
    1597:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    159b:	8b 00                	mov    eax,DWORD PTR [rax]
    159d:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
		if (!(a.reg_no = d->cap_ptrs[PCI_CAP_ID_MSI]))
    15a0:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    15a4:	0f b6 40 13          	movzx  eax,BYTE PTR [rax+0x13]
    15a8:	88 45 f0             	mov    BYTE PTR [rbp-0x10],al
    15ab:	0f b6 45 f0          	movzx  eax,BYTE PTR [rbp-0x10]
    15af:	84 c0                	test   al,al
    15b1:	0f 84 d1 00 00 00    	je     1688 <pci_init_msi+0xfd>
		dat = pci_read(a);
    15b7:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
    15ba:	89 c7                	mov    edi,eax
    15bc:	e8 18 eb ff ff       	call   d9 <pci_read>
    15c1:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
		n_c = (dat >> 1) & 0x7;
    15c4:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    15c7:	d1 e8                	shr    eax,1
    15c9:	83 e0 07             	and    eax,0x7
    15cc:	88 45 f7             	mov    BYTE PTR [rbp-0x9],al
		n_e = (dat >> 4) & 0x7;
    15cf:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    15d2:	c1 e8 04             	shr    eax,0x4
    15d5:	83 e0 07             	and    eax,0x7
    15d8:	88 45 ff             	mov    BYTE PTR [rbp-0x1],al
		cprintf(KFMT_INFO, "MSI cap: %u capable %u enable and status %u\n",
    15db:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    15de:	83 e0 01             	and    eax,0x1
    15e1:	89 c1                	mov    ecx,eax
    15e3:	0f b6 55 ff          	movzx  edx,BYTE PTR [rbp-0x1]
    15e7:	0f b6 45 f7          	movzx  eax,BYTE PTR [rbp-0x9]
    15eb:	41 89 c8             	mov    r8d,ecx
    15ee:	89 d1                	mov    ecx,edx
    15f0:	89 c2                	mov    edx,eax
    15f2:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    15f9:	bf 0b 00 00 00       	mov    edi,0xb
    15fe:	b8 00 00 00 00       	mov    eax,0x0
    1603:	e8 00 00 00 00       	call   1608 <pci_init_msi+0x7d>
		if (n_e > 3) /* >8 */
    1608:	80 7d ff 03          	cmp    BYTE PTR [rbp-0x1],0x3
    160c:	76 04                	jbe    1612 <pci_init_msi+0x87>
				n_e = 3;
    160e:	c6 45 ff 03          	mov    BYTE PTR [rbp-0x1],0x3
		dat = (dat & 0xffffff8e) | (n_e << 4);
    1612:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    1615:	83 e0 8e             	and    eax,0xffffff8e
    1618:	89 c2                	mov    edx,eax
    161a:	0f b6 45 ff          	movzx  eax,BYTE PTR [rbp-0x1]
    161e:	c1 e0 04             	shl    eax,0x4
    1621:	09 d0                	or     eax,edx
    1623:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
		pci_write(a, dat);
    1626:	8b 55 f8             	mov    edx,DWORD PTR [rbp-0x8]
    1629:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
    162c:	89 d6                	mov    esi,edx
    162e:	89 c7                	mov    edi,eax
    1630:	e8 a0 eb ff ff       	call   1d5 <pci_write>
		if (pci_read(a) != dat) {
    1635:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
    1638:	89 c7                	mov    edi,eax
    163a:	e8 9a ea ff ff       	call   d9 <pci_read>
    163f:	39 45 f8             	cmp    DWORD PTR [rbp-0x8],eax
    1642:	74 45                	je     1689 <pci_init_msi+0xfe>
				cprintf(KFMT_WARN, "Failed to configure PCI MSI data.\n");
    1644:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    164b:	bf 0e 00 00 00       	mov    edi,0xe
    1650:	b8 00 00 00 00       	mov    eax,0x0
    1655:	e8 00 00 00 00       	call   165a <pci_init_msi+0xcf>
				printf("%08x vs %08x\n", dat, pci_read(a));
    165a:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
    165d:	89 c7                	mov    edi,eax
    165f:	e8 75 ea ff ff       	call   d9 <pci_read>
    1664:	89 c2                	mov    edx,eax
    1666:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    1669:	89 c6                	mov    esi,eax
    166b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1672:	b8 00 00 00 00       	mov    eax,0x0
    1677:	e8 00 00 00 00       	call   167c <pci_init_msi+0xf1>
				mdelay(1000);
    167c:	bf e8 03 00 00       	mov    edi,0x3e8
    1681:	e8 00 00 00 00       	call   1686 <pci_init_msi+0xfb>
    1686:	eb 01                	jmp    1689 <pci_init_msi+0xfe>
				return; /* no MSI */
    1688:	90                   	nop
}
    1689:	c9                   	leave
    168a:	c3                   	ret

000000000000168b <pci_add_caps>:
{
    168b:	55                   	push   rbp
    168c:	48 89 e5             	mov    rbp,rsp
    168f:	48 83 ec 20          	sub    rsp,0x20
    1693:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		union pca a = d->addr; /* 5h MSI, 10h PCIe, 14h MSI-X */
    1697:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    169b:	8b 00                	mov    eax,DWORD PTR [rax]
    169d:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
		a.reg_no = PCI_STATUS;
    16a0:	c6 45 f8 06          	mov    BYTE PTR [rbp-0x8],0x6
		dat = pci_read_word(a);
    16a4:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    16a7:	89 c7                	mov    edi,eax
    16a9:	e8 5b ea ff ff       	call   109 <pci_read_word>
    16ae:	0f b7 c0             	movzx  eax,ax
    16b1:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		if (!(dat & PCI_STATUS_CAP_LIST))
    16b4:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    16b7:	83 e0 10             	and    eax,0x10
    16ba:	85 c0                	test   eax,eax
    16bc:	0f 84 b4 00 00 00    	je     1776 <pci_add_caps+0xeb>
		a.reg_no = ((d->device_type & 0x7f) == 2) ? PCI_CB_CAPABILITY_LIST
    16c2:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    16c6:	0f b6 40 07          	movzx  eax,BYTE PTR [rax+0x7]
    16ca:	0f b6 c0             	movzx  eax,al
    16cd:	83 e0 7f             	and    eax,0x7f
    16d0:	83 f8 02             	cmp    eax,0x2
    16d3:	75 07                	jne    16dc <pci_add_caps+0x51>
    16d5:	b8 14 00 00 00       	mov    eax,0x14
    16da:	eb 05                	jmp    16e1 <pci_add_caps+0x56>
    16dc:	b8 34 00 00 00       	mov    eax,0x34
    16e1:	88 45 f8             	mov    BYTE PTR [rbp-0x8],al
		a.reg_no = pci_read_byte(a) & 0xfc; /* dword alignment */
    16e4:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    16e7:	89 c7                	mov    edi,eax
    16e9:	e8 ab ea ff ff       	call   199 <pci_read_byte>
    16ee:	83 e0 fc             	and    eax,0xfffffffc
    16f1:	88 45 f8             	mov    BYTE PTR [rbp-0x8],al
		while (a.reg_no <= 192 - 4) { /* valid capability ranges */
    16f4:	eb 76                	jmp    176c <pci_add_caps+0xe1>
				cap.val = pci_read(a);
    16f6:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    16f9:	89 c7                	mov    edi,eax
    16fb:	e8 d9 e9 ff ff       	call   d9 <pci_read>
    1700:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
				if (!(cap.cap > PCI_CAP_ID_MAX))
    1703:	0f b6 45 f4          	movzx  eax,BYTE PTR [rbp-0xc]
    1707:	3c 13                	cmp    al,0x13
    1709:	77 15                	ja     1720 <pci_add_caps+0x95>
						d->cap_ptrs[cap.cap] = a.reg_no;
    170b:	0f b6 45 f4          	movzx  eax,BYTE PTR [rbp-0xc]
    170f:	0f b6 c0             	movzx  eax,al
    1712:	0f b6 4d f8          	movzx  ecx,BYTE PTR [rbp-0x8]
    1716:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    171a:	48 98                	cdqe
    171c:	88 4c 02 0e          	mov    BYTE PTR [rdx+rax*1+0xe],cl
				switch (cap.cap) {
    1720:	0f b6 45 f4          	movzx  eax,BYTE PTR [rbp-0xc]
    1724:	0f b6 c0             	movzx  eax,al
    1727:	83 f8 11             	cmp    eax,0x11
    172a:	74 27                	je     1753 <pci_add_caps+0xc8>
    172c:	83 f8 11             	cmp    eax,0x11
    172f:	7f 29                	jg     175a <pci_add_caps+0xcf>
    1731:	83 f8 07             	cmp    eax,0x7
    1734:	74 20                	je     1756 <pci_add_caps+0xcb>
    1736:	83 f8 07             	cmp    eax,0x7
    1739:	7f 1f                	jg     175a <pci_add_caps+0xcf>
    173b:	83 f8 01             	cmp    eax,0x1
    173e:	74 19                	je     1759 <pci_add_caps+0xce>
    1740:	83 f8 05             	cmp    eax,0x5
    1743:	75 15                	jne    175a <pci_add_caps+0xcf>
								pci_init_msi(d);
    1745:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1749:	48 89 c7             	mov    rdi,rax
    174c:	e8 00 00 00 00       	call   1751 <pci_add_caps+0xc6>
								break;
    1751:	eb 07                	jmp    175a <pci_add_caps+0xcf>
								break;
    1753:	90                   	nop
    1754:	eb 04                	jmp    175a <pci_add_caps+0xcf>
								break;
    1756:	90                   	nop
    1757:	eb 01                	jmp    175a <pci_add_caps+0xcf>
								break;
    1759:	90                   	nop
				if (!(a.reg_no = (cap.next & 0xfc))) /* end of list */
    175a:	0f b6 45 f5          	movzx  eax,BYTE PTR [rbp-0xb]
    175e:	83 e0 fc             	and    eax,0xfffffffc
    1761:	88 45 f8             	mov    BYTE PTR [rbp-0x8],al
    1764:	0f b6 45 f8          	movzx  eax,BYTE PTR [rbp-0x8]
    1768:	84 c0                	test   al,al
    176a:	74 0d                	je     1779 <pci_add_caps+0xee>
		while (a.reg_no <= 192 - 4) { /* valid capability ranges */
    176c:	0f b6 45 f8          	movzx  eax,BYTE PTR [rbp-0x8]
    1770:	3c bc                	cmp    al,0xbc
    1772:	76 82                	jbe    16f6 <pci_add_caps+0x6b>
    1774:	eb 04                	jmp    177a <pci_add_caps+0xef>
				return; /* we don't have to look for it */
    1776:	90                   	nop
    1777:	eb 01                	jmp    177a <pci_add_caps+0xef>
						break;
    1779:	90                   	nop
}
    177a:	c9                   	leave
    177b:	c3                   	ret

000000000000177c <pci_add_bars>:
{
    177c:	55                   	push   rbp
    177d:	48 89 e5             	mov    rbp,rsp
    1780:	48 83 ec 38          	sub    rsp,0x38
    1784:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
		union pca a = d->addr;
    1788:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    178c:	8b 00                	mov    eax,DWORD PTR [rax]
    178e:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
		uint8_t t = d->device_type & 0x7f;
    1791:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1795:	0f b6 40 07          	movzx  eax,BYTE PTR [rax+0x7]
    1799:	83 e0 7f             	and    eax,0x7f
    179c:	88 45 f7             	mov    BYTE PTR [rbp-0x9],al
		if (t == 0 || t == 1) { /* the regular 6/2 BARs */
    179f:	80 7d f7 00          	cmp    BYTE PTR [rbp-0x9],0x0
    17a3:	74 0a                	je     17af <pci_add_bars+0x33>
    17a5:	80 7d f7 01          	cmp    BYTE PTR [rbp-0x9],0x1
    17a9:	0f 85 7c 02 00 00    	jne    1a2b <pci_add_bars+0x2af>
				int limit = d->device_type ? 2 : 6;
    17af:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    17b3:	0f b6 40 07          	movzx  eax,BYTE PTR [rax+0x7]
    17b7:	84 c0                	test   al,al
    17b9:	74 07                	je     17c2 <pci_add_bars+0x46>
    17bb:	b8 02 00 00 00       	mov    eax,0x2
    17c0:	eb 05                	jmp    17c7 <pci_add_bars+0x4b>
    17c2:	b8 06 00 00 00       	mov    eax,0x6
    17c7:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
				a.reg_no = PCI_BASE_ADDRESS_0;
    17ca:	c6 45 dc 10          	mov    BYTE PTR [rbp-0x24],0x10
				for (int i = 0; i < limit; i++) {
    17ce:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
    17d5:	e9 40 02 00 00       	jmp    1a1a <pci_add_bars+0x29e>
						uint32_t dat = pci_read(a);
    17da:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    17dd:	89 c7                	mov    edi,eax
    17df:	e8 f5 e8 ff ff       	call   d9 <pci_read>
    17e4:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
						if (dat & 1) { /* I/O space */
    17e7:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    17ea:	83 e0 01             	and    eax,0x1
    17ed:	85 c0                	test   eax,eax
    17ef:	0f 84 95 00 00 00    	je     188a <pci_add_bars+0x10e>
								d->ressources[i].type = PCI_BAR_PIO;
    17f5:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    17f9:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    17fc:	48 63 d2             	movsxd rdx,edx
    17ff:	48 83 c2 01          	add    rdx,0x1
    1803:	48 c1 e2 05          	shl    rdx,0x5
    1807:	48 01 d0             	add    rax,rdx
    180a:	48 83 c0 08          	add    rax,0x8
    180e:	c7 00 01 00 00 00    	mov    DWORD PTR [rax],0x1
								d->ressources[i].pio.base = dat & 0xfffc;
    1814:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    1817:	83 e0 fc             	and    eax,0xfffffffc
    181a:	89 c2                	mov    edx,eax
    181c:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1820:	8b 4d fc             	mov    ecx,DWORD PTR [rbp-0x4]
    1823:	48 63 c9             	movsxd rcx,ecx
    1826:	48 83 c1 01          	add    rcx,0x1
    182a:	48 c1 e1 05          	shl    rcx,0x5
    182e:	48 01 c8             	add    rax,rcx
    1831:	48 83 c0 10          	add    rax,0x10
    1835:	66 89 10             	mov    WORD PTR [rax],dx
								d->ressources[i].pio.count = 0;
    1838:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    183c:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    183f:	48 63 d2             	movsxd rdx,edx
    1842:	48 83 c2 01          	add    rdx,0x1
    1846:	48 c1 e2 05          	shl    rdx,0x5
    184a:	48 01 d0             	add    rax,rdx
    184d:	48 83 c0 12          	add    rax,0x12
    1851:	66 c7 00 00 00       	mov    WORD PTR [rax],0x0
										d->ressources[i].pio.count = pci_bar_get_size(d, i);
    1856:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    1859:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    185d:	89 d6                	mov    esi,edx
    185f:	48 89 c7             	mov    rdi,rax
    1862:	e8 00 00 00 00       	call   1867 <pci_add_bars+0xeb>
    1867:	89 c1                	mov    ecx,eax
    1869:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    186d:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    1870:	48 63 d2             	movsxd rdx,edx
    1873:	48 83 c2 01          	add    rdx,0x1
    1877:	48 c1 e2 05          	shl    rdx,0x5
    187b:	48 01 d0             	add    rax,rdx
    187e:	48 83 c0 12          	add    rax,0x12
    1882:	66 89 08             	mov    WORD PTR [rax],cx
    1885:	e9 82 01 00 00       	jmp    1a0c <pci_add_bars+0x290>
								uint8_t tp = (dat >> 1) & 0x3;
    188a:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    188d:	d1 e8                	shr    eax,1
    188f:	83 e0 03             	and    eax,0x3
    1892:	88 45 e3             	mov    BYTE PTR [rbp-0x1d],al
								d->ressources[i].type = dat & 0xf;
    1895:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    1898:	83 e0 0f             	and    eax,0xf
    189b:	89 c2                	mov    edx,eax
    189d:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    18a1:	8b 4d fc             	mov    ecx,DWORD PTR [rbp-0x4]
    18a4:	48 63 c9             	movsxd rcx,ecx
    18a7:	48 83 c1 01          	add    rcx,0x1
    18ab:	48 c1 e1 05          	shl    rcx,0x5
    18af:	48 01 c8             	add    rax,rcx
    18b2:	48 83 c0 08          	add    rax,0x8
    18b6:	89 10                	mov    DWORD PTR [rax],edx
								if (tp == 2) { /* 64-bit */
    18b8:	80 7d e3 02          	cmp    BYTE PTR [rbp-0x1d],0x2
    18bc:	0f 85 bf 00 00 00    	jne    1981 <pci_add_bars+0x205>
										d->ressources[i].mmio.base = dat & 0xfffffff0;
    18c2:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    18c5:	83 e0 f0             	and    eax,0xfffffff0
    18c8:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    18cc:	8b 4d fc             	mov    ecx,DWORD PTR [rbp-0x4]
    18cf:	48 63 c9             	movsxd rcx,ecx
    18d2:	48 83 c1 01          	add    rcx,0x1
    18d6:	48 c1 e1 05          	shl    rcx,0x5
    18da:	48 01 ca             	add    rdx,rcx
    18dd:	48 83 c2 10          	add    rdx,0x10
    18e1:	48 89 02             	mov    QWORD PTR [rdx],rax
										d->ressources[i].mmio.size = 0;
    18e4:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    18e8:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    18eb:	48 63 d2             	movsxd rdx,edx
    18ee:	48 83 c2 01          	add    rdx,0x1
    18f2:	48 c1 e2 05          	shl    rdx,0x5
    18f6:	48 01 d0             	add    rax,rdx
    18f9:	48 83 c0 18          	add    rax,0x18
    18fd:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
										d->ressources[i].mmio.mapping = NULL;
    1904:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1908:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    190b:	48 63 d2             	movsxd rdx,edx
    190e:	48 c1 e2 05          	shl    rdx,0x5
    1912:	48 01 d0             	add    rax,rdx
    1915:	48 83 c0 40          	add    rax,0x40
    1919:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
										a.reg_no += 4; i++;
    1920:	0f b6 45 dc          	movzx  eax,BYTE PTR [rbp-0x24]
    1924:	83 c0 04             	add    eax,0x4
    1927:	88 45 dc             	mov    BYTE PTR [rbp-0x24],al
    192a:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
												((uint64_t)pci_read(a) << 32);
    192e:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    1931:	89 c7                	mov    edi,eax
    1933:	e8 a1 e7 ff ff       	call   d9 <pci_read>
    1938:	89 c0                	mov    eax,eax
    193a:	48 c1 e0 20          	shl    rax,0x20
    193e:	48 89 c1             	mov    rcx,rax
										d->ressources[i].mmio.base |=
    1941:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1945:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    1948:	48 63 d2             	movsxd rdx,edx
    194b:	48 83 c2 01          	add    rdx,0x1
    194f:	48 c1 e2 05          	shl    rdx,0x5
    1953:	48 01 d0             	add    rax,rdx
    1956:	48 83 c0 10          	add    rax,0x10
    195a:	48 8b 00             	mov    rax,QWORD PTR [rax]
    195d:	48 09 c1             	or     rcx,rax
    1960:	48 89 ca             	mov    rdx,rcx
    1963:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1967:	8b 4d fc             	mov    ecx,DWORD PTR [rbp-0x4]
    196a:	48 63 c9             	movsxd rcx,ecx
    196d:	48 83 c1 01          	add    rcx,0x1
    1971:	48 c1 e1 05          	shl    rcx,0x5
    1975:	48 01 c8             	add    rax,rcx
    1978:	48 83 c0 10          	add    rax,0x10
    197c:	48 89 10             	mov    QWORD PTR [rax],rdx
    197f:	eb 5e                	jmp    19df <pci_add_bars+0x263>
										d->ressources[i].mmio.base = dat & 0xfffffff0;
    1981:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    1984:	83 e0 f0             	and    eax,0xfffffff0
    1987:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    198b:	8b 4d fc             	mov    ecx,DWORD PTR [rbp-0x4]
    198e:	48 63 c9             	movsxd rcx,ecx
    1991:	48 83 c1 01          	add    rcx,0x1
    1995:	48 c1 e1 05          	shl    rcx,0x5
    1999:	48 01 ca             	add    rdx,rcx
    199c:	48 83 c2 10          	add    rdx,0x10
    19a0:	48 89 02             	mov    QWORD PTR [rdx],rax
										d->ressources[i].mmio.size = 0;
    19a3:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    19a7:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    19aa:	48 63 d2             	movsxd rdx,edx
    19ad:	48 83 c2 01          	add    rdx,0x1
    19b1:	48 c1 e2 05          	shl    rdx,0x5
    19b5:	48 01 d0             	add    rax,rdx
    19b8:	48 83 c0 18          	add    rax,0x18
    19bc:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
										d->ressources[i].mmio.mapping = NULL;
    19c3:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    19c7:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    19ca:	48 63 d2             	movsxd rdx,edx
    19cd:	48 c1 e2 05          	shl    rdx,0x5
    19d1:	48 01 d0             	add    rax,rdx
    19d4:	48 83 c0 40          	add    rax,0x40
    19d8:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
										d->ressources[i].mmio.size = pci_bar_get_size(d, i);
    19df:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    19e2:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    19e6:	89 d6                	mov    esi,edx
    19e8:	48 89 c7             	mov    rdi,rax
    19eb:	e8 00 00 00 00       	call   19f0 <pci_add_bars+0x274>
    19f0:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    19f4:	8b 4d fc             	mov    ecx,DWORD PTR [rbp-0x4]
    19f7:	48 63 c9             	movsxd rcx,ecx
    19fa:	48 83 c1 01          	add    rcx,0x1
    19fe:	48 c1 e1 05          	shl    rcx,0x5
    1a02:	48 01 ca             	add    rdx,rcx
    1a05:	48 83 c2 18          	add    rdx,0x18
    1a09:	48 89 02             	mov    QWORD PTR [rdx],rax
						a.reg_no += 4;
    1a0c:	0f b6 45 dc          	movzx  eax,BYTE PTR [rbp-0x24]
    1a10:	83 c0 04             	add    eax,0x4
    1a13:	88 45 dc             	mov    BYTE PTR [rbp-0x24],al
				for (int i = 0; i < limit; i++) {
    1a16:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
    1a1a:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1a1d:	3b 45 e8             	cmp    eax,DWORD PTR [rbp-0x18]
    1a20:	0f 8c b4 fd ff ff    	jl     17da <pci_add_bars+0x5e>
		if (t == 0 || t == 1) { /* the regular 6/2 BARs */
    1a26:	e9 1e 01 00 00       	jmp    1b49 <pci_add_bars+0x3cd>
		} else if (t == 2) { /* PCI-to-CardBus bridge */
    1a2b:	80 7d f7 02          	cmp    BYTE PTR [rbp-0x9],0x2
    1a2f:	0f 85 14 01 00 00    	jne    1b49 <pci_add_bars+0x3cd>
				a.reg_no = 0x1c;
    1a35:	c6 45 dc 1c          	mov    BYTE PTR [rbp-0x24],0x1c
				for (int i = 0; i < 4; i++) {
    1a39:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0
    1a40:	e9 f8 00 00 00       	jmp    1b3d <pci_add_bars+0x3c1>
						uint32_t base = pci_read(a), limit;
    1a45:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    1a48:	89 c7                	mov    edi,eax
    1a4a:	e8 8a e6 ff ff       	call   d9 <pci_read>
    1a4f:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
						a.reg_no += 4;
    1a52:	0f b6 45 dc          	movzx  eax,BYTE PTR [rbp-0x24]
    1a56:	83 c0 04             	add    eax,0x4
    1a59:	88 45 dc             	mov    BYTE PTR [rbp-0x24],al
						limit = pci_read(a);
    1a5c:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    1a5f:	89 c7                	mov    edi,eax
    1a61:	e8 73 e6 ff ff       	call   d9 <pci_read>
    1a66:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
						if (i < 2) { /* memory */
    1a69:	83 7d f8 01          	cmp    DWORD PTR [rbp-0x8],0x1
    1a6d:	7f 64                	jg     1ad3 <pci_add_bars+0x357>
								d->ressources[i].type = PCI_BAR_MMIO;
    1a6f:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1a73:	8b 55 f8             	mov    edx,DWORD PTR [rbp-0x8]
    1a76:	48 63 d2             	movsxd rdx,edx
    1a79:	48 83 c2 01          	add    rdx,0x1
    1a7d:	48 c1 e2 05          	shl    rdx,0x5
    1a81:	48 01 d0             	add    rax,rdx
    1a84:	48 83 c0 08          	add    rax,0x8
    1a88:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0
								d->ressources[i].mmio.base = base;
    1a8e:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
    1a91:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    1a95:	8b 4d f8             	mov    ecx,DWORD PTR [rbp-0x8]
    1a98:	48 63 c9             	movsxd rcx,ecx
    1a9b:	48 83 c1 01          	add    rcx,0x1
    1a9f:	48 c1 e1 05          	shl    rcx,0x5
    1aa3:	48 01 ca             	add    rdx,rcx
    1aa6:	48 83 c2 10          	add    rdx,0x10
    1aaa:	48 89 02             	mov    QWORD PTR [rdx],rax
								d->ressources[i].mmio.size = limit - base;
    1aad:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    1ab0:	2b 45 f0             	sub    eax,DWORD PTR [rbp-0x10]
    1ab3:	89 c1                	mov    ecx,eax
    1ab5:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1ab9:	8b 55 f8             	mov    edx,DWORD PTR [rbp-0x8]
    1abc:	48 63 d2             	movsxd rdx,edx
    1abf:	48 83 c2 01          	add    rdx,0x1
    1ac3:	48 c1 e2 05          	shl    rdx,0x5
    1ac7:	48 01 d0             	add    rax,rdx
    1aca:	48 83 c0 18          	add    rax,0x18
    1ace:	48 89 08             	mov    QWORD PTR [rax],rcx
    1ad1:	eb 66                	jmp    1b39 <pci_add_bars+0x3bd>
								d->ressources[i].type = PCI_BAR_PIO;
    1ad3:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1ad7:	8b 55 f8             	mov    edx,DWORD PTR [rbp-0x8]
    1ada:	48 63 d2             	movsxd rdx,edx
    1add:	48 83 c2 01          	add    rdx,0x1
    1ae1:	48 c1 e2 05          	shl    rdx,0x5
    1ae5:	48 01 d0             	add    rax,rdx
    1ae8:	48 83 c0 08          	add    rax,0x8
    1aec:	c7 00 01 00 00 00    	mov    DWORD PTR [rax],0x1
								d->ressources[i].pio.base = base;
    1af2:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
    1af5:	89 c1                	mov    ecx,eax
    1af7:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1afb:	8b 55 f8             	mov    edx,DWORD PTR [rbp-0x8]
    1afe:	48 63 d2             	movsxd rdx,edx
    1b01:	48 83 c2 01          	add    rdx,0x1
    1b05:	48 c1 e2 05          	shl    rdx,0x5
    1b09:	48 01 d0             	add    rax,rdx
    1b0c:	48 83 c0 10          	add    rax,0x10
    1b10:	66 89 08             	mov    WORD PTR [rax],cx
								d->ressources[i].pio.count = limit - base;
    1b13:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    1b16:	89 c2                	mov    edx,eax
    1b18:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
    1b1b:	29 c2                	sub    edx,eax
    1b1d:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1b21:	8b 4d f8             	mov    ecx,DWORD PTR [rbp-0x8]
    1b24:	48 63 c9             	movsxd rcx,ecx
    1b27:	48 83 c1 01          	add    rcx,0x1
    1b2b:	48 c1 e1 05          	shl    rcx,0x5
    1b2f:	48 01 c8             	add    rax,rcx
    1b32:	48 83 c0 12          	add    rax,0x12
    1b36:	66 89 10             	mov    WORD PTR [rax],dx
				for (int i = 0; i < 4; i++) {
    1b39:	83 45 f8 01          	add    DWORD PTR [rbp-0x8],0x1
    1b3d:	83 7d f8 03          	cmp    DWORD PTR [rbp-0x8],0x3
    1b41:	0f 8e fe fe ff ff    	jle    1a45 <pci_add_bars+0x2c9>
}
    1b47:	eb 00                	jmp    1b49 <pci_add_bars+0x3cd>
    1b49:	90                   	nop
    1b4a:	c9                   	leave
    1b4b:	c3                   	ret

0000000000001b4c <pci_enumerate_devices>:
{
    1b4c:	55                   	push   rbp
    1b4d:	48 89 e5             	mov    rbp,rsp
    1b50:	48 83 ec 30          	sub    rsp,0x30
		union pca pca = {0};
    1b54:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [rbp-0x24],0x0
		printf("Enumerating PCI devices:\n");
    1b5b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1b62:	b8 00 00 00 00       	mov    eax,0x0
    1b67:	e8 00 00 00 00       	call   1b6c <pci_enumerate_devices+0x20>
		for (bus = 0; bus < 256; bus++)
    1b6c:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
    1b73:	e9 5f 03 00 00       	jmp    1ed7 <pci_enumerate_devices+0x38b>
				for (dev = 0; dev < 32; dev++) {
    1b78:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0
    1b7f:	e9 45 03 00 00       	jmp    1ec9 <pci_enumerate_devices+0x37d>
						uint32_t dat, fno = 0;
    1b84:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [rbp-0x10],0x0
						pca.bus_no = bus;
    1b8b:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1b8e:	88 45 de             	mov    BYTE PTR [rbp-0x22],al
						pca.device_no = dev;
    1b91:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    1b94:	83 e0 1f             	and    eax,0x1f
    1b97:	8d 14 c5 00 00 00 00 	lea    edx,[rax*8+0x0]
    1b9e:	0f b6 45 dd          	movzx  eax,BYTE PTR [rbp-0x23]
    1ba2:	83 e0 07             	and    eax,0x7
    1ba5:	09 d0                	or     eax,edx
    1ba7:	88 45 dd             	mov    BYTE PTR [rbp-0x23],al
						pca.enabled = 1;
    1baa:	0f b6 45 df          	movzx  eax,BYTE PTR [rbp-0x21]
    1bae:	83 c8 80             	or     eax,0xffffff80
    1bb1:	88 45 df             	mov    BYTE PTR [rbp-0x21],al
    1bb4:	eb 01                	jmp    1bb7 <pci_enumerate_devices+0x6b>
								goto multifun; /* non-consecuitive layouts */
    1bb6:	90                   	nop
						pca.func_no = fno++;
    1bb7:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
    1bba:	8d 50 01             	lea    edx,[rax+0x1]
    1bbd:	89 55 f0             	mov    DWORD PTR [rbp-0x10],edx
    1bc0:	83 e0 07             	and    eax,0x7
    1bc3:	83 e0 07             	and    eax,0x7
    1bc6:	89 c2                	mov    edx,eax
    1bc8:	0f b6 45 dd          	movzx  eax,BYTE PTR [rbp-0x23]
    1bcc:	83 e0 f8             	and    eax,0xfffffff8
    1bcf:	09 d0                	or     eax,edx
    1bd1:	88 45 dd             	mov    BYTE PTR [rbp-0x23],al
						pca.reg_no = 0;
    1bd4:	c6 45 dc 00          	mov    BYTE PTR [rbp-0x24],0x0
						pca.reserved =/* pca.zero =*/ 0;
    1bd8:	0f b6 45 df          	movzx  eax,BYTE PTR [rbp-0x21]
    1bdc:	83 e0 80             	and    eax,0xffffff80
    1bdf:	88 45 df             	mov    BYTE PTR [rbp-0x21],al
						dat = pci_read(pca);
    1be2:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    1be5:	89 c7                	mov    edi,eax
    1be7:	e8 ed e4 ff ff       	call   d9 <pci_read>
    1bec:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
						if ((dat & 0xffff) != 0xffff) {
    1bef:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1bf2:	0f b7 c0             	movzx  eax,ax
    1bf5:	3d ff ff 00 00       	cmp    eax,0xffff
    1bfa:	0f 84 b5 02 00 00    	je     1eb5 <pci_enumerate_devices+0x369>
								int mf = 0; struct dle* le;
    1c00:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [rbp-0x14],0x0
								le = kzalloc(sizeof(*le));
    1c07:	bf 00 01 00 00       	mov    edi,0x100
    1c0c:	e8 00 00 00 00       	call   1c11 <pci_enumerate_devices+0xc5>
    1c11:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
								le->dev.addr = pca;
    1c15:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1c19:	8b 55 dc             	mov    edx,DWORD PTR [rbp-0x24]
    1c1c:	89 50 18             	mov    DWORD PTR [rax+0x18],edx
								le->dev.identification = dat >> 16;
    1c1f:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1c22:	c1 e8 10             	shr    eax,0x10
    1c25:	89 c2                	mov    edx,eax
    1c27:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1c2b:	66 89 50 24          	mov    WORD PTR [rax+0x24],dx
								le->dev.vendor = (dat & 0xffff);
    1c2f:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1c32:	89 c2                	mov    edx,eax
    1c34:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1c38:	66 89 50 22          	mov    WORD PTR [rax+0x22],dx
										pca.bus_no, pca.device_no, pca.func_no);
    1c3c:	0f b6 45 dd          	movzx  eax,BYTE PTR [rbp-0x23]
    1c40:	83 e0 07             	and    eax,0x7
								printf("devie at %02x:%02x.%x\n",
    1c43:	0f b6 c8             	movzx  ecx,al
										pca.bus_no, pca.device_no, pca.func_no);
    1c46:	0f b6 45 dd          	movzx  eax,BYTE PTR [rbp-0x23]
    1c4a:	c0 e8 03             	shr    al,0x3
								printf("devie at %02x:%02x.%x\n",
    1c4d:	0f b6 d0             	movzx  edx,al
										pca.bus_no, pca.device_no, pca.func_no);
    1c50:	0f b6 45 de          	movzx  eax,BYTE PTR [rbp-0x22]
								printf("devie at %02x:%02x.%x\n",
    1c54:	0f b6 c0             	movzx  eax,al
    1c57:	89 c6                	mov    esi,eax
    1c59:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1c60:	b8 00 00 00 00       	mov    eax,0x0
    1c65:	e8 00 00 00 00       	call   1c6a <pci_enumerate_devices+0x11e>
								printf("\tid:       %04x\n", (dat >> 16));
    1c6a:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1c6d:	c1 e8 10             	shr    eax,0x10
    1c70:	89 c6                	mov    esi,eax
    1c72:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1c79:	b8 00 00 00 00       	mov    eax,0x0
    1c7e:	e8 00 00 00 00       	call   1c83 <pci_enumerate_devices+0x137>
								printf("\tvendor:   %04x\n", (dat & 0xffff));
    1c83:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1c86:	0f b7 c0             	movzx  eax,ax
    1c89:	89 c6                	mov    esi,eax
    1c8b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1c92:	b8 00 00 00 00       	mov    eax,0x0
    1c97:	e8 00 00 00 00       	call   1c9c <pci_enumerate_devices+0x150>
								pca.reg_no = 8;
    1c9c:	c6 45 dc 08          	mov    BYTE PTR [rbp-0x24],0x8
								dat = pci_read(pca);
    1ca0:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    1ca3:	89 c7                	mov    edi,eax
    1ca5:	e8 2f e4 ff ff       	call   d9 <pci_read>
    1caa:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
								le->dev.device_class = dat >> 24;
    1cad:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1cb0:	c1 e8 18             	shr    eax,0x18
    1cb3:	89 c2                	mov    edx,eax
    1cb5:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1cb9:	88 50 1c             	mov    BYTE PTR [rax+0x1c],dl
								le->dev.device_subclass = (dat >> 16) & 0xff;
    1cbc:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1cbf:	c1 e8 10             	shr    eax,0x10
    1cc2:	89 c2                	mov    edx,eax
    1cc4:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1cc8:	88 50 1d             	mov    BYTE PTR [rax+0x1d],dl
								le->dev.device_interface = (dat >> 8) & 0xff;
    1ccb:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1cce:	c1 e8 08             	shr    eax,0x8
    1cd1:	89 c2                	mov    edx,eax
    1cd3:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1cd7:	88 50 1e             	mov    BYTE PTR [rax+0x1e],dl
									pci_get_class_string(dat >> 24));
    1cda:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1cdd:	c1 e8 18             	shr    eax,0x18
								printf("\tclass:    %s\n",
    1ce0:	0f b6 c0             	movzx  eax,al
    1ce3:	89 c7                	mov    edi,eax
    1ce5:	e8 00 00 00 00       	call   1cea <pci_enumerate_devices+0x19e>
    1cea:	48 89 c6             	mov    rsi,rax
    1ced:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1cf4:	b8 00 00 00 00       	mov    eax,0x0
    1cf9:	e8 00 00 00 00       	call   1cfe <pci_enumerate_devices+0x1b2>
									(dat >> 16) & 0xff, (dat >> 8) & 0xff));
    1cfe:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1d01:	c1 e8 08             	shr    eax,0x8
								printf("\tsubclass: %s\n",
    1d04:	0f b6 d0             	movzx  edx,al
									(dat >> 16) & 0xff, (dat >> 8) & 0xff));
    1d07:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1d0a:	c1 e8 10             	shr    eax,0x10
								printf("\tsubclass: %s\n",
    1d0d:	0f b6 c8             	movzx  ecx,al
									pci_get_subclass_string(dat >> 24,
    1d10:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1d13:	c1 e8 18             	shr    eax,0x18
								printf("\tsubclass: %s\n",
    1d16:	0f b6 c0             	movzx  eax,al
    1d19:	89 ce                	mov    esi,ecx
    1d1b:	89 c7                	mov    edi,eax
    1d1d:	e8 00 00 00 00       	call   1d22 <pci_enumerate_devices+0x1d6>
    1d22:	48 89 c6             	mov    rsi,rax
    1d25:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1d2c:	b8 00 00 00 00       	mov    eax,0x0
    1d31:	e8 00 00 00 00       	call   1d36 <pci_enumerate_devices+0x1ea>
								pca.reg_no = 12;
    1d36:	c6 45 dc 0c          	mov    BYTE PTR [rbp-0x24],0xc
								dat = pci_read(pca);
    1d3a:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    1d3d:	89 c7                	mov    edi,eax
    1d3f:	e8 95 e3 ff ff       	call   d9 <pci_read>
    1d44:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
								dat = (dat >> 16) & 0xff;
    1d47:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1d4a:	c1 e8 10             	shr    eax,0x10
    1d4d:	25 ff 00 00 00       	and    eax,0xff
    1d52:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
								le->dev.device_type = dat;
    1d55:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1d58:	89 c2                	mov    edx,eax
    1d5a:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1d5e:	88 50 1f             	mov    BYTE PTR [rax+0x1f],dl
								mf = dat & 0x80;
    1d61:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1d64:	25 80 00 00 00       	and    eax,0x80
    1d69:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
									(dat & 0x80) ? "multi" : "single");
    1d6c:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1d6f:	25 80 00 00 00       	and    eax,0x80
								printf("\tfunction: %s\n",
    1d74:	85 c0                	test   eax,eax
    1d76:	74 09                	je     1d81 <pci_enumerate_devices+0x235>
    1d78:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    1d7f:	eb 07                	jmp    1d88 <pci_enumerate_devices+0x23c>
    1d81:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    1d88:	48 89 c6             	mov    rsi,rax
    1d8b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1d92:	b8 00 00 00 00       	mov    eax,0x0
    1d97:	e8 00 00 00 00       	call   1d9c <pci_enumerate_devices+0x250>
									((dat & 0x7f) == 0) ? "general" : (((dat & 0x7f) == 1)
    1d9c:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1d9f:	83 e0 7f             	and    eax,0x7f
								printf("\ttype:     %s\n",
    1da2:	85 c0                	test   eax,eax
    1da4:	74 1d                	je     1dc3 <pci_enumerate_devices+0x277>
									((dat & 0x7f) == 0) ? "general" : (((dat & 0x7f) == 1)
    1da6:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1da9:	83 e0 7f             	and    eax,0x7f
									? ("PCI-to-PCI bridge") : ("CardBus bridge")));
    1dac:	83 f8 01             	cmp    eax,0x1
    1daf:	75 09                	jne    1dba <pci_enumerate_devices+0x26e>
    1db1:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    1db8:	eb 10                	jmp    1dca <pci_enumerate_devices+0x27e>
    1dba:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    1dc1:	eb 07                	jmp    1dca <pci_enumerate_devices+0x27e>
								printf("\ttype:     %s\n",
    1dc3:	48 c7 c0 00 00 00 00 	mov    rax,0x0
    1dca:	48 89 c6             	mov    rsi,rax
    1dcd:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1dd4:	b8 00 00 00 00       	mov    eax,0x0
    1dd9:	e8 00 00 00 00       	call   1dde <pci_enumerate_devices+0x292>
								pca.reg_no = PCI_INTERRUPT_LINE;
    1dde:	c6 45 dc 3c          	mov    BYTE PTR [rbp-0x24],0x3c
								dat = pci_read(pca);
    1de2:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    1de5:	89 c7                	mov    edi,eax
    1de7:	e8 ed e2 ff ff       	call   d9 <pci_read>
    1dec:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
								le->dev.intr_pin = (dat >> 8) & 0xff;
    1def:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1df2:	c1 e8 08             	shr    eax,0x8
    1df5:	89 c2                	mov    edx,eax
    1df7:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1dfb:	88 50 20             	mov    BYTE PTR [rax+0x20],dl
								le->dev.intr_line = dat & 0xff;
    1dfe:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1e01:	89 c2                	mov    edx,eax
    1e03:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1e07:	88 50 21             	mov    BYTE PTR [rax+0x21],dl
								if (!le->dev.intr_pin || le->dev.intr_pin > 4)
    1e0a:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1e0e:	0f b6 40 20          	movzx  eax,BYTE PTR [rax+0x20]
    1e12:	84 c0                	test   al,al
    1e14:	74 0c                	je     1e22 <pci_enumerate_devices+0x2d6>
    1e16:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1e1a:	0f b6 40 20          	movzx  eax,BYTE PTR [rax+0x20]
    1e1e:	3c 04                	cmp    al,0x4
    1e20:	76 09                	jbe    1e2b <pci_enumerate_devices+0x2df>
										dat = ' ';
    1e22:	c7 45 f4 20 00 00 00 	mov    DWORD PTR [rbp-0xc],0x20
    1e29:	eb 11                	jmp    1e3c <pci_enumerate_devices+0x2f0>
										dat = 'A' + (le->dev.intr_pin - 1);
    1e2b:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1e2f:	0f b6 40 20          	movzx  eax,BYTE PTR [rax+0x20]
    1e33:	0f b6 c0             	movzx  eax,al
    1e36:	83 c0 40             	add    eax,0x40
    1e39:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
								printf("\tinterrupt: INT%c#  line: %u\n", (char)dat, le->dev.intr_line);
    1e3c:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1e40:	0f b6 40 21          	movzx  eax,BYTE PTR [rax+0x21]
    1e44:	0f b6 d0             	movzx  edx,al
    1e47:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1e4a:	0f be c0             	movsx  eax,al
    1e4d:	89 c6                	mov    esi,eax
    1e4f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1e56:	b8 00 00 00 00       	mov    eax,0x0
    1e5b:	e8 00 00 00 00       	call   1e60 <pci_enumerate_devices+0x314>
								printf("\n");
    1e60:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1e67:	b8 00 00 00 00       	mov    eax,0x0
    1e6c:	e8 00 00 00 00       	call   1e71 <pci_enumerate_devices+0x325>
								pci_add_bars(&le->dev);
    1e71:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1e75:	48 83 c0 18          	add    rax,0x18
    1e79:	48 89 c7             	mov    rdi,rax
    1e7c:	e8 00 00 00 00       	call   1e81 <pci_enumerate_devices+0x335>
								pci_add_caps(&le->dev);
    1e81:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1e85:	48 83 c0 18          	add    rax,0x18
    1e89:	48 89 c7             	mov    rdi,rax
    1e8c:	e8 00 00 00 00       	call   1e91 <pci_enumerate_devices+0x345>
								list_add_tail(&le->devices, &device_list.devices);
    1e91:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1e95:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1e9c:	48 89 c7             	mov    rdi,rax
    1e9f:	e8 e8 e1 ff ff       	call   8c <list_add_tail>
								if (mf && fno < 8)
    1ea4:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
    1ea8:	74 1b                	je     1ec5 <pci_enumerate_devices+0x379>
    1eaa:	83 7d f0 07          	cmp    DWORD PTR [rbp-0x10],0x7
    1eae:	77 15                	ja     1ec5 <pci_enumerate_devices+0x379>
										goto multifun;
    1eb0:	e9 02 fd ff ff       	jmp    1bb7 <pci_enumerate_devices+0x6b>
						} else if (fno && fno < 8)
    1eb5:	83 7d f0 00          	cmp    DWORD PTR [rbp-0x10],0x0
    1eb9:	74 0a                	je     1ec5 <pci_enumerate_devices+0x379>
    1ebb:	83 7d f0 07          	cmp    DWORD PTR [rbp-0x10],0x7
    1ebf:	0f 86 f1 fc ff ff    	jbe    1bb6 <pci_enumerate_devices+0x6a>
				for (dev = 0; dev < 32; dev++) {
    1ec5:	83 45 f8 01          	add    DWORD PTR [rbp-0x8],0x1
    1ec9:	83 7d f8 1f          	cmp    DWORD PTR [rbp-0x8],0x1f
    1ecd:	0f 86 b1 fc ff ff    	jbe    1b84 <pci_enumerate_devices+0x38>
		for (bus = 0; bus < 256; bus++)
    1ed3:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
    1ed7:	81 7d fc ff 00 00 00 	cmp    DWORD PTR [rbp-0x4],0xff
    1ede:	0f 86 94 fc ff ff    	jbe    1b78 <pci_enumerate_devices+0x2c>
}
    1ee4:	90                   	nop
    1ee5:	90                   	nop
    1ee6:	c9                   	leave
    1ee7:	c3                   	ret

0000000000001ee8 <module_init>:
{
    1ee8:	55                   	push   rbp
    1ee9:	48 89 e5             	mov    rbp,rsp
		pci_enumerate_devices();
    1eec:	b8 00 00 00 00       	mov    eax,0x0
    1ef1:	e8 00 00 00 00       	call   1ef6 <module_init+0xe>
		return 0;
    1ef6:	b8 00 00 00 00       	mov    eax,0x0
}
    1efb:	5d                   	pop    rbp
    1efc:	c3                   	ret

0000000000001efd <module_cleanup>:

void MODENTRY module_cleanup()
{
    1efd:	55                   	push   rbp
    1efe:	48 89 e5             	mov    rbp,rsp
		printf("goodbye pci.ko\n");
    1f01:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1f08:	b8 00 00 00 00       	mov    eax,0x0
    1f0d:	e8 00 00 00 00       	call   1f12 <module_cleanup+0x15>
}
    1f12:	90                   	nop
    1f13:	5d                   	pop    rbp
    1f14:	c3                   	ret
