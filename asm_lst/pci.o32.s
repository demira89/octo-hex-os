
pci.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <io_wait>:
								return "generic 8254 system timer";
						else if (progIf == 1)
								return "ISA system timer";
						else if (progIf == 2)
								return "EISA system timer";
						else
       0:	55                   	push   ebp
       1:	89 e5                	mov    ebp,esp
								return "other system timer";
       3:	b8 00 00 00 00       	mov    eax,0x0
       8:	e6 80                	out    0x80,al
				else if (scls == 3)
       a:	90                   	nop
       b:	5d                   	pop    ebp
       c:	c3                   	ret

0000000d <outl>:
				else if (scls == 4)
						if (progIf == 0)
								return "Gameport controller (generic)";
						else if (progIf == 0x10)
								return "Gameport controller (legacy)";
						else
       d:	55                   	push   ebp
       e:	89 e5                	mov    ebp,esp
      10:	83 ec 04             	sub    esp,0x4
      13:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      16:	66 89 45 fc          	mov    WORD PTR [ebp-0x4],ax
								return "other Gameport controller";
      1a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      1d:	0f b7 55 fc          	movzx  edx,WORD PTR [ebp-0x4]
      21:	ef                   	out    dx,eax
				else if (scls == 0x80)
      22:	90                   	nop
      23:	c9                   	leave
      24:	c3                   	ret

00000025 <inl>:
						return "other input controller";
				else
						return "unrecognized input controller";
      25:	55                   	push   ebp
      26:	89 e5                	mov    ebp,esp
      28:	83 ec 14             	sub    esp,0x14
      2b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      2e:	66 89 45 ec          	mov    WORD PTR [ebp-0x14],ax
		else if (cls == 10)
				if (scls == 0)
      32:	0f b7 45 ec          	movzx  eax,WORD PTR [ebp-0x14]
      36:	89 c2                	mov    edx,eax
      38:	ed                   	in     eax,dx
      39:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
						return "generic docking station";
      3c:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
				else if (scls == 0x80)
      3f:	c9                   	leave
      40:	c3                   	ret

00000041 <__list_add>:
								//else if ((dat >> 24) == 1)
								//		mdelay(1000);
								pca.reg_no = 12;
								dat = pci_read(pca);
								dat = (dat >> 16) & 0xff;
								le->dev.device_type = dat;
      41:	55                   	push   ebp
      42:	89 e5                	mov    ebp,esp
								mf = dat & 0x80;
      44:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
      47:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
      4a:	89 10                	mov    DWORD PTR [eax],edx
								printf("\tfunction: %s\n",
      4c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      4f:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
      52:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
									(dat & 0x80) ? "multi" : "single");
      55:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      58:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
      5b:	89 10                	mov    DWORD PTR [eax],edx
								printf("\ttype:     %s\n",
      5d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      60:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
      63:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
									((dat & 0x7f) == 0) ? "general" : (((dat & 0x7f) == 1)
      66:	90                   	nop
      67:	5d                   	pop    ebp
      68:	c3                   	ret

00000069 <list_add_tail>:
								pci_add_caps(&le->dev);
								list_add_tail(&le->devices, &device_list.devices);
								if (mf && fno < 8)
										goto multifun;
						} else if (fno && fno < 8)
								goto multifun; /* non-consecuitive layouts */
      69:	55                   	push   ebp
      6a:	89 e5                	mov    ebp,esp
      6c:	83 ec 08             	sub    esp,0x8
				}
      6f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      72:	83 c0 08             	add    eax,0x8
      75:	83 ec 0c             	sub    esp,0xc
      78:	50                   	push   eax
      79:	e8 fc ff ff ff       	call   7a <list_add_tail+0x11>
      7e:	83 c4 10             	add    esp,0x10
}
      81:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      84:	8b 00                	mov    eax,DWORD PTR [eax]
      86:	83 ec 04             	sub    esp,0x4
      89:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
      8c:	50                   	push   eax
      8d:	ff 75 08             	push   DWORD PTR [ebp+0x8]
      90:	e8 ac ff ff ff       	call   41 <__list_add>
      95:	83 c4 10             	add    esp,0x10

      98:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      9b:	83 c0 08             	add    eax,0x8
      9e:	83 ec 0c             	sub    esp,0xc
      a1:	50                   	push   eax
      a2:	e8 fc ff ff ff       	call   a3 <list_add_tail+0x3a>
      a7:	83 c4 10             	add    esp,0x10
int MODENTRY module_init()
      aa:	90                   	nop
      ab:	c9                   	leave
      ac:	c3                   	ret

000000ad <pci_read>:
#define PCI_BAR_64_BIT (1 << 2)
#define PCI_BAR_16_BIT (1 << 1)
#define PCI_BAR_PREFETCHABLE (1 << 3) /* MMIO+PREF */

static inline uint32_t pci_read(union pca a)
{
      ad:	55                   	push   ebp
      ae:	89 e5                	mov    ebp,esp
		outl(PCI_CONFIG_ADDRESS, a.val);
      b0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      b3:	50                   	push   eax
      b4:	68 f8 0c 00 00       	push   0xcf8
      b9:	e8 4f ff ff ff       	call   d <outl>
      be:	83 c4 08             	add    esp,0x8
		io_wait();
      c1:	e8 3a ff ff ff       	call   0 <io_wait>
		return inl(PCI_CONFIG_DATA);
      c6:	68 fc 0c 00 00       	push   0xcfc
      cb:	e8 55 ff ff ff       	call   25 <inl>
      d0:	83 c4 04             	add    esp,0x4
}
      d3:	c9                   	leave
      d4:	c3                   	ret

000000d5 <pci_read_word>:

/* PCI is little endian (status==06h --> high bits) */
static inline uint16_t pci_read_word(union pca a)
{
      d5:	55                   	push   ebp
      d6:	89 e5                	mov    ebp,esp
      d8:	83 ec 10             	sub    esp,0x10
		uint16_t of = a.reg_no % 4;
      db:	0f b6 45 08          	movzx  eax,BYTE PTR [ebp+0x8]
      df:	0f b6 c0             	movzx  eax,al
      e2:	83 e0 03             	and    eax,0x3
      e5:	66 89 45 fa          	mov    WORD PTR [ebp-0x6],ax
		union pca a2 = a;
      e9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      ec:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		uint32_t v1, v2 = 0;
      ef:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
		a2.reg_no -= of;
      f6:	0f b6 45 f0          	movzx  eax,BYTE PTR [ebp-0x10]
      fa:	0f b7 55 fa          	movzx  edx,WORD PTR [ebp-0x6]
      fe:	29 d0                	sub    eax,edx
     100:	88 45 f0             	mov    BYTE PTR [ebp-0x10],al
		v1 = pci_read(a2);
     103:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
     106:	e8 a2 ff ff ff       	call   ad <pci_read>
     10b:	83 c4 04             	add    esp,0x4
     10e:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (of == 3) { /* very unaligned access */
     111:	66 83 7d fa 03       	cmp    WORD PTR [ebp-0x6],0x3
     116:	75 26                	jne    13e <pci_read_word+0x69>
				a2.reg_no += 4;
     118:	0f b6 45 f0          	movzx  eax,BYTE PTR [ebp-0x10]
     11c:	83 c0 04             	add    eax,0x4
     11f:	88 45 f0             	mov    BYTE PTR [ebp-0x10],al
				v2 = pci_read(a2);
     122:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
     125:	e8 83 ff ff ff       	call   ad <pci_read>
     12a:	83 c4 04             	add    esp,0x4
     12d:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
				v2 = (v2 << 8) & 0xff00;
     130:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     133:	c1 e0 08             	shl    eax,0x8
     136:	25 ff ff 00 00       	and    eax,0xffff
     13b:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		}
		v1 = (v1 >> 8 * of) & 0xffff;
     13e:	0f b7 45 fa          	movzx  eax,WORD PTR [ebp-0x6]
     142:	c1 e0 03             	shl    eax,0x3
     145:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     148:	89 c1                	mov    ecx,eax
     14a:	d3 ea                	shr    edx,cl
     14c:	89 d0                	mov    eax,edx
     14e:	25 ff ff 00 00       	and    eax,0xffff
     153:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		return (v1 | v2);
     156:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     159:	89 c2                	mov    edx,eax
     15b:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     15e:	09 d0                	or     eax,edx
}
     160:	c9                   	leave
     161:	c3                   	ret

00000162 <pci_read_byte>:

static inline uint8_t pci_read_byte(union pca a)
{
     162:	55                   	push   ebp
     163:	89 e5                	mov    ebp,esp
     165:	83 ec 10             	sub    esp,0x10
		uint8_t of = a.reg_no % 4;
     168:	0f b6 45 08          	movzx  eax,BYTE PTR [ebp+0x8]
     16c:	83 e0 03             	and    eax,0x3
     16f:	88 45 ff             	mov    BYTE PTR [ebp-0x1],al
		union pca a2 = a;
     172:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     175:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
		a2.reg_no -= of;
     178:	0f b6 45 f8          	movzx  eax,BYTE PTR [ebp-0x8]
     17c:	2a 45 ff             	sub    al,BYTE PTR [ebp-0x1]
     17f:	88 45 f8             	mov    BYTE PTR [ebp-0x8],al
		return (pci_read(a2) >> 8 * of) & 0xff;
     182:	ff 75 f8             	push   DWORD PTR [ebp-0x8]
     185:	e8 23 ff ff ff       	call   ad <pci_read>
     18a:	83 c4 04             	add    esp,0x4
     18d:	0f b6 55 ff          	movzx  edx,BYTE PTR [ebp-0x1]
     191:	c1 e2 03             	shl    edx,0x3
     194:	89 d1                	mov    ecx,edx
     196:	d3 e8                	shr    eax,cl
}
     198:	c9                   	leave
     199:	c3                   	ret

0000019a <pci_write>:

static inline void pci_write(union pca a, uint32_t v)
{
     19a:	55                   	push   ebp
     19b:	89 e5                	mov    ebp,esp
		outl(PCI_CONFIG_ADDRESS, a.val);
     19d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1a0:	50                   	push   eax
     1a1:	68 f8 0c 00 00       	push   0xcf8
     1a6:	e8 62 fe ff ff       	call   d <outl>
     1ab:	83 c4 08             	add    esp,0x8
		io_wait();
     1ae:	e8 4d fe ff ff       	call   0 <io_wait>
		outl(PCI_CONFIG_DATA, v);
     1b3:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
     1b6:	68 fc 0c 00 00       	push   0xcfc
     1bb:	e8 4d fe ff ff       	call   d <outl>
     1c0:	83 c4 08             	add    esp,0x8
}
     1c3:	90                   	nop
     1c4:	c9                   	leave
     1c5:	c3                   	ret

000001c6 <pci_get_class_string>:
{
     1c6:	55                   	push   ebp
     1c7:	89 e5                	mov    ebp,esp
     1c9:	83 ec 04             	sub    esp,0x4
     1cc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1cf:	88 45 fc             	mov    BYTE PTR [ebp-0x4],al
		switch (cls) {
     1d2:	0f b6 45 fc          	movzx  eax,BYTE PTR [ebp-0x4]
     1d6:	83 f8 11             	cmp    eax,0x11
     1d9:	7f 1a                	jg     1f5 <pci_get_class_string+0x2f>
     1db:	85 c0                	test   eax,eax
     1dd:	0f 88 aa 00 00 00    	js     28d <pci_get_class_string+0xc7>
     1e3:	83 f8 11             	cmp    eax,0x11
     1e6:	0f 87 a1 00 00 00    	ja     28d <pci_get_class_string+0xc7>
     1ec:	8b 04 85 c8 01 00 00 	mov    eax,DWORD PTR [eax*4+0x1c8]
     1f3:	ff e0                	jmp    eax
     1f5:	3d ff 00 00 00       	cmp    eax,0xff
     1fa:	0f 84 86 00 00 00    	je     286 <pci_get_class_string+0xc0>
     200:	e9 88 00 00 00       	jmp    28d <pci_get_class_string+0xc7>
				return "(old device)";
     205:	b8 00 00 00 00       	mov    eax,0x0
     20a:	e9 83 00 00 00       	jmp    292 <pci_get_class_string+0xcc>
				return "mass storage controller";
     20f:	b8 0d 00 00 00       	mov    eax,0xd
     214:	eb 7c                	jmp    292 <pci_get_class_string+0xcc>
				return "network controller";
     216:	b8 25 00 00 00       	mov    eax,0x25
     21b:	eb 75                	jmp    292 <pci_get_class_string+0xcc>
				return "display controller";
     21d:	b8 38 00 00 00       	mov    eax,0x38
     222:	eb 6e                	jmp    292 <pci_get_class_string+0xcc>
				return "multimedia controller";
     224:	b8 4b 00 00 00       	mov    eax,0x4b
     229:	eb 67                	jmp    292 <pci_get_class_string+0xcc>
				return "memory controller";
     22b:	b8 61 00 00 00       	mov    eax,0x61
     230:	eb 60                	jmp    292 <pci_get_class_string+0xcc>
				return "bridge device";
     232:	b8 73 00 00 00       	mov    eax,0x73
     237:	eb 59                	jmp    292 <pci_get_class_string+0xcc>
				return "simple communication controllers";
     239:	b8 84 00 00 00       	mov    eax,0x84
     23e:	eb 52                	jmp    292 <pci_get_class_string+0xcc>
				return "base system peripherials";
     240:	b8 a5 00 00 00       	mov    eax,0xa5
     245:	eb 4b                	jmp    292 <pci_get_class_string+0xcc>
				return "input devices";
     247:	b8 be 00 00 00       	mov    eax,0xbe
     24c:	eb 44                	jmp    292 <pci_get_class_string+0xcc>
				return "docking stations";
     24e:	b8 cc 00 00 00       	mov    eax,0xcc
     253:	eb 3d                	jmp    292 <pci_get_class_string+0xcc>
				return "processors";
     255:	b8 dd 00 00 00       	mov    eax,0xdd
     25a:	eb 36                	jmp    292 <pci_get_class_string+0xcc>
				return "serial bus controllers";
     25c:	b8 e8 00 00 00       	mov    eax,0xe8
     261:	eb 2f                	jmp    292 <pci_get_class_string+0xcc>
				return "wireless controllers";
     263:	b8 ff 00 00 00       	mov    eax,0xff
     268:	eb 28                	jmp    292 <pci_get_class_string+0xcc>
				return "intelligent I/O controllers";
     26a:	b8 14 01 00 00       	mov    eax,0x114
     26f:	eb 21                	jmp    292 <pci_get_class_string+0xcc>
				return "satellite communication controllers";
     271:	b8 30 01 00 00       	mov    eax,0x130
     276:	eb 1a                	jmp    292 <pci_get_class_string+0xcc>
				return "encryption/decryption controllers";
     278:	b8 54 01 00 00       	mov    eax,0x154
     27d:	eb 13                	jmp    292 <pci_get_class_string+0xcc>
				return "data acquisiton and signal processing controllers";
     27f:	b8 78 01 00 00       	mov    eax,0x178
     284:	eb 0c                	jmp    292 <pci_get_class_string+0xcc>
				return "no fitting class";
     286:	b8 aa 01 00 00       	mov    eax,0x1aa
     28b:	eb 05                	jmp    292 <pci_get_class_string+0xcc>
				return "(reserved)";
     28d:	b8 bb 01 00 00       	mov    eax,0x1bb
}
     292:	c9                   	leave
     293:	c3                   	ret

00000294 <pci_get_subclass_string>:
{
     294:	55                   	push   ebp
     295:	89 e5                	mov    ebp,esp
     297:	83 ec 0c             	sub    esp,0xc
     29a:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
     29d:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     2a0:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     2a3:	88 4d fc             	mov    BYTE PTR [ebp-0x4],cl
     2a6:	88 55 f8             	mov    BYTE PTR [ebp-0x8],dl
     2a9:	88 45 f4             	mov    BYTE PTR [ebp-0xc],al
		if (cls == 0)
     2ac:	80 7d fc 00          	cmp    BYTE PTR [ebp-0x4],0x0
     2b0:	75 2a                	jne    2dc <pci_get_subclass_string+0x48>
				if (scls == 0)
     2b2:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     2b6:	75 0a                	jne    2c2 <pci_get_subclass_string+0x2e>
						return "any device (not VGA compatible)";
     2b8:	b8 10 02 00 00       	mov    eax,0x210
     2bd:	e9 91 0a 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 1)
     2c2:	80 7d f8 01          	cmp    BYTE PTR [ebp-0x8],0x1
     2c6:	75 0a                	jne    2d2 <pci_get_subclass_string+0x3e>
						return "VGA compatible";
     2c8:	b8 30 02 00 00       	mov    eax,0x230
     2cd:	e9 81 0a 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						return "(invalid)";
     2d2:	b8 3f 02 00 00       	mov    eax,0x23f
     2d7:	e9 77 0a 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
		else if (cls == 1)
     2dc:	80 7d fc 01          	cmp    BYTE PTR [ebp-0x4],0x1
     2e0:	0f 85 ca 00 00 00    	jne    3b0 <pci_get_subclass_string+0x11c>
				if (scls == 0)
     2e6:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     2ea:	75 0a                	jne    2f6 <pci_get_subclass_string+0x62>
						return "SCSI bus controller";
     2ec:	b8 49 02 00 00       	mov    eax,0x249
     2f1:	e9 5d 0a 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 1)
     2f6:	80 7d f8 01          	cmp    BYTE PTR [ebp-0x8],0x1
     2fa:	75 0a                	jne    306 <pci_get_subclass_string+0x72>
						return "IDE controller";
     2fc:	b8 5d 02 00 00       	mov    eax,0x25d
     301:	e9 4d 0a 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 3)
     306:	80 7d f8 03          	cmp    BYTE PTR [ebp-0x8],0x3
     30a:	75 0a                	jne    316 <pci_get_subclass_string+0x82>
						return "IPI bus controller";
     30c:	b8 6c 02 00 00       	mov    eax,0x26c
     311:	e9 3d 0a 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 4)
     316:	80 7d f8 04          	cmp    BYTE PTR [ebp-0x8],0x4
     31a:	75 0a                	jne    326 <pci_get_subclass_string+0x92>
						return "RAID controller";
     31c:	b8 7f 02 00 00       	mov    eax,0x27f
     321:	e9 2d 0a 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 5)
     326:	80 7d f8 05          	cmp    BYTE PTR [ebp-0x8],0x5
     32a:	75 2a                	jne    356 <pci_get_subclass_string+0xc2>
						if (progIf == 0x20)
     32c:	80 7d f4 20          	cmp    BYTE PTR [ebp-0xc],0x20
     330:	75 0a                	jne    33c <pci_get_subclass_string+0xa8>
								return "ATA controller (single DMA)";
     332:	b8 8f 02 00 00       	mov    eax,0x28f
     337:	e9 17 0a 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 0x30)
     33c:	80 7d f4 30          	cmp    BYTE PTR [ebp-0xc],0x30
     340:	75 0a                	jne    34c <pci_get_subclass_string+0xb8>
								return "ATA controller (chained DMA)";
     342:	b8 ab 02 00 00       	mov    eax,0x2ab
     347:	e9 07 0a 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
								return "ATA controller (unknown interface)";
     34c:	b8 c8 02 00 00       	mov    eax,0x2c8
     351:	e9 fd 09 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 6)
     356:	80 7d f8 06          	cmp    BYTE PTR [ebp-0x8],0x6
     35a:	75 2a                	jne    386 <pci_get_subclass_string+0xf2>
						if (progIf == 0)
     35c:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
     360:	75 0a                	jne    36c <pci_get_subclass_string+0xd8>
								return "SATA (vendor interface)";
     362:	b8 eb 02 00 00       	mov    eax,0x2eb
     367:	e9 e7 09 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 1)
     36c:	80 7d f4 01          	cmp    BYTE PTR [ebp-0xc],0x1
     370:	75 0a                	jne    37c <pci_get_subclass_string+0xe8>
								return "SATA (AHCI 1.0)";
     372:	b8 03 03 00 00       	mov    eax,0x303
     377:	e9 d7 09 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
								return "SATA (unknown interface)";
     37c:	b8 13 03 00 00       	mov    eax,0x313
     381:	e9 cd 09 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 7)
     386:	80 7d f8 07          	cmp    BYTE PTR [ebp-0x8],0x7
     38a:	75 0a                	jne    396 <pci_get_subclass_string+0x102>
						return "Serial Attached SCSI (SAS)";
     38c:	b8 2c 03 00 00       	mov    eax,0x32c
     391:	e9 bd 09 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 0x80)
     396:	80 7d f8 80          	cmp    BYTE PTR [ebp-0x8],0x80
     39a:	75 0a                	jne    3a6 <pci_get_subclass_string+0x112>
						return "other mass storage controller";
     39c:	b8 47 03 00 00       	mov    eax,0x347
     3a1:	e9 ad 09 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						return "unrecognized mass storage controller";
     3a6:	b8 68 03 00 00       	mov    eax,0x368
     3ab:	e9 a3 09 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
		else if (cls == 2)
     3b0:	80 7d fc 02          	cmp    BYTE PTR [ebp-0x4],0x2
     3b4:	0f 85 8a 00 00 00    	jne    444 <pci_get_subclass_string+0x1b0>
				if (scls == 0)
     3ba:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     3be:	75 0a                	jne    3ca <pci_get_subclass_string+0x136>
						return "Ethernet controller";
     3c0:	b8 8d 03 00 00       	mov    eax,0x38d
     3c5:	e9 89 09 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 1)
     3ca:	80 7d f8 01          	cmp    BYTE PTR [ebp-0x8],0x1
     3ce:	75 0a                	jne    3da <pci_get_subclass_string+0x146>
						return "Token ring controller";
     3d0:	b8 a1 03 00 00       	mov    eax,0x3a1
     3d5:	e9 79 09 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 2)
     3da:	80 7d f8 02          	cmp    BYTE PTR [ebp-0x8],0x2
     3de:	75 0a                	jne    3ea <pci_get_subclass_string+0x156>
						return "FDDI controller";
     3e0:	b8 b7 03 00 00       	mov    eax,0x3b7
     3e5:	e9 69 09 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 3)
     3ea:	80 7d f8 03          	cmp    BYTE PTR [ebp-0x8],0x3
     3ee:	75 0a                	jne    3fa <pci_get_subclass_string+0x166>
						return "ATM controller";
     3f0:	b8 c7 03 00 00       	mov    eax,0x3c7
     3f5:	e9 59 09 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 4)
     3fa:	80 7d f8 04          	cmp    BYTE PTR [ebp-0x8],0x4
     3fe:	75 0a                	jne    40a <pci_get_subclass_string+0x176>
						return "ISDN controller";
     400:	b8 d6 03 00 00       	mov    eax,0x3d6
     405:	e9 49 09 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 5)
     40a:	80 7d f8 05          	cmp    BYTE PTR [ebp-0x8],0x5
     40e:	75 0a                	jne    41a <pci_get_subclass_string+0x186>
						return "WorldFip controller";
     410:	b8 e6 03 00 00       	mov    eax,0x3e6
     415:	e9 39 09 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 6)
     41a:	80 7d f8 06          	cmp    BYTE PTR [ebp-0x8],0x6
     41e:	75 0a                	jne    42a <pci_get_subclass_string+0x196>
						return "PICMG 2.14 Multi Computing";
     420:	b8 fa 03 00 00       	mov    eax,0x3fa
     425:	e9 29 09 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 0x80)
     42a:	80 7d f8 80          	cmp    BYTE PTR [ebp-0x8],0x80
     42e:	75 0a                	jne    43a <pci_get_subclass_string+0x1a6>
						return "other network controller";
     430:	b8 15 04 00 00       	mov    eax,0x415
     435:	e9 19 09 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						return "unrecognized network controller";
     43a:	b8 30 04 00 00       	mov    eax,0x430
     43f:	e9 0f 09 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
		else if (cls == 3)
     444:	80 7d fc 03          	cmp    BYTE PTR [ebp-0x4],0x3
     448:	75 6a                	jne    4b4 <pci_get_subclass_string+0x220>
				if (scls == 0)
     44a:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     44e:	75 2a                	jne    47a <pci_get_subclass_string+0x1e6>
						if (progIf == 0)
     450:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
     454:	75 0a                	jne    460 <pci_get_subclass_string+0x1cc>
								return "VGA-compatible controller";
     456:	b8 50 04 00 00       	mov    eax,0x450
     45b:	e9 f3 08 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 1)
     460:	80 7d f4 01          	cmp    BYTE PTR [ebp-0xc],0x1
     464:	75 0a                	jne    470 <pci_get_subclass_string+0x1dc>
								return "8512-compatible controller";
     466:	b8 6a 04 00 00       	mov    eax,0x46a
     46b:	e9 e3 08 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
								return "unkown sc0 display controller";
     470:	b8 85 04 00 00       	mov    eax,0x485
     475:	e9 d9 08 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 1)
     47a:	80 7d f8 01          	cmp    BYTE PTR [ebp-0x8],0x1
     47e:	75 0a                	jne    48a <pci_get_subclass_string+0x1f6>
						return "XGA controller";
     480:	b8 a3 04 00 00       	mov    eax,0x4a3
     485:	e9 c9 08 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 2)
     48a:	80 7d f8 02          	cmp    BYTE PTR [ebp-0x8],0x2
     48e:	75 0a                	jne    49a <pci_get_subclass_string+0x206>
						return "3D controller (no VGA)";
     490:	b8 b2 04 00 00       	mov    eax,0x4b2
     495:	e9 b9 08 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 0x80)
     49a:	80 7d f8 80          	cmp    BYTE PTR [ebp-0x8],0x80
     49e:	75 0a                	jne    4aa <pci_get_subclass_string+0x216>
						return "other video controller";
     4a0:	b8 c9 04 00 00       	mov    eax,0x4c9
     4a5:	e9 a9 08 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						return "unrecognized video controller";
     4aa:	b8 e0 04 00 00       	mov    eax,0x4e0
     4af:	e9 9f 08 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
		else if (cls == 4)
     4b4:	80 7d fc 04          	cmp    BYTE PTR [ebp-0x4],0x4
     4b8:	75 4a                	jne    504 <pci_get_subclass_string+0x270>
				if (scls == 0)
     4ba:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     4be:	75 0a                	jne    4ca <pci_get_subclass_string+0x236>
						return "video device";
     4c0:	b8 fe 04 00 00       	mov    eax,0x4fe
     4c5:	e9 89 08 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 1)
     4ca:	80 7d f8 01          	cmp    BYTE PTR [ebp-0x8],0x1
     4ce:	75 0a                	jne    4da <pci_get_subclass_string+0x246>
						return "audio device";
     4d0:	b8 0b 05 00 00       	mov    eax,0x50b
     4d5:	e9 79 08 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 2)
     4da:	80 7d f8 02          	cmp    BYTE PTR [ebp-0x8],0x2
     4de:	75 0a                	jne    4ea <pci_get_subclass_string+0x256>
						return "Computer telephony device";
     4e0:	b8 18 05 00 00       	mov    eax,0x518
     4e5:	e9 69 08 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 0x80)
     4ea:	80 7d f8 80          	cmp    BYTE PTR [ebp-0x8],0x80
     4ee:	75 0a                	jne    4fa <pci_get_subclass_string+0x266>
						return "other media device";
     4f0:	b8 32 05 00 00       	mov    eax,0x532
     4f5:	e9 59 08 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						return "unrecongnized media device";
     4fa:	b8 45 05 00 00       	mov    eax,0x545
     4ff:	e9 4f 08 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
		else if (cls == 5)
     504:	80 7d fc 05          	cmp    BYTE PTR [ebp-0x4],0x5
     508:	75 3a                	jne    544 <pci_get_subclass_string+0x2b0>
				if (scls == 0)
     50a:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     50e:	75 0a                	jne    51a <pci_get_subclass_string+0x286>
						return "RAM controller";
     510:	b8 60 05 00 00       	mov    eax,0x560
     515:	e9 39 08 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 1)
     51a:	80 7d f8 01          	cmp    BYTE PTR [ebp-0x8],0x1
     51e:	75 0a                	jne    52a <pci_get_subclass_string+0x296>
						return "flash controller";
     520:	b8 6f 05 00 00       	mov    eax,0x56f
     525:	e9 29 08 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 0x80)
     52a:	80 7d f8 80          	cmp    BYTE PTR [ebp-0x8],0x80
     52e:	75 0a                	jne    53a <pci_get_subclass_string+0x2a6>
						return "other memory controller";
     530:	b8 80 05 00 00       	mov    eax,0x580
     535:	e9 19 08 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						return "unrecognized memory controller";
     53a:	b8 98 05 00 00       	mov    eax,0x598
     53f:	e9 0f 08 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
		else if (cls == 6)
     544:	80 7d fc 06          	cmp    BYTE PTR [ebp-0x4],0x6
     548:	0f 85 0a 01 00 00    	jne    658 <pci_get_subclass_string+0x3c4>
				if (scls == 0)
     54e:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     552:	75 0a                	jne    55e <pci_get_subclass_string+0x2ca>
						return "Host bridge";
     554:	b8 b7 05 00 00       	mov    eax,0x5b7
     559:	e9 f5 07 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 1)
     55e:	80 7d f8 01          	cmp    BYTE PTR [ebp-0x8],0x1
     562:	75 0a                	jne    56e <pci_get_subclass_string+0x2da>
						return "ISA bridge";
     564:	b8 c3 05 00 00       	mov    eax,0x5c3
     569:	e9 e5 07 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 2)
     56e:	80 7d f8 02          	cmp    BYTE PTR [ebp-0x8],0x2
     572:	75 0a                	jne    57e <pci_get_subclass_string+0x2ea>
						return "EISA bridge";
     574:	b8 ce 05 00 00       	mov    eax,0x5ce
     579:	e9 d5 07 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 3)
     57e:	80 7d f8 03          	cmp    BYTE PTR [ebp-0x8],0x3
     582:	75 0a                	jne    58e <pci_get_subclass_string+0x2fa>
						return "MCA bridge";
     584:	b8 da 05 00 00       	mov    eax,0x5da
     589:	e9 c5 07 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 4)
     58e:	80 7d f8 04          	cmp    BYTE PTR [ebp-0x8],0x4
     592:	75 2a                	jne    5be <pci_get_subclass_string+0x32a>
						if (progIf == 0)
     594:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
     598:	75 0a                	jne    5a4 <pci_get_subclass_string+0x310>
								return "PCI-to-PCI bridge";
     59a:	b8 e5 05 00 00       	mov    eax,0x5e5
     59f:	e9 af 07 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 1)
     5a4:	80 7d f4 01          	cmp    BYTE PTR [ebp-0xc],0x1
     5a8:	75 0a                	jne    5b4 <pci_get_subclass_string+0x320>
								return "PCI-to-PCI bridge (subtractive decode)";
     5aa:	b8 f8 05 00 00       	mov    eax,0x5f8
     5af:	e9 9f 07 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
								return "possibly PCI-to-PCI bridge";
     5b4:	b8 1f 06 00 00       	mov    eax,0x61f
     5b9:	e9 95 07 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 5)
     5be:	80 7d f8 05          	cmp    BYTE PTR [ebp-0x8],0x5
     5c2:	75 0a                	jne    5ce <pci_get_subclass_string+0x33a>
						return "PCMCIA bridge";
     5c4:	b8 3a 06 00 00       	mov    eax,0x63a
     5c9:	e9 85 07 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 6)
     5ce:	80 7d f8 06          	cmp    BYTE PTR [ebp-0x8],0x6
     5d2:	75 0a                	jne    5de <pci_get_subclass_string+0x34a>
						return "NuBus bridge";
     5d4:	b8 48 06 00 00       	mov    eax,0x648
     5d9:	e9 75 07 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 7)
     5de:	80 7d f8 07          	cmp    BYTE PTR [ebp-0x8],0x7
     5e2:	75 0a                	jne    5ee <pci_get_subclass_string+0x35a>
						return "CardBus bridge";
     5e4:	b8 55 06 00 00       	mov    eax,0x655
     5e9:	e9 65 07 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 8)
     5ee:	80 7d f8 08          	cmp    BYTE PTR [ebp-0x8],0x8
     5f2:	75 0a                	jne    5fe <pci_get_subclass_string+0x36a>
						return "RACEway bridge";
     5f4:	b8 64 06 00 00       	mov    eax,0x664
     5f9:	e9 55 07 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 9)
     5fe:	80 7d f8 09          	cmp    BYTE PTR [ebp-0x8],0x9
     602:	75 2a                	jne    62e <pci_get_subclass_string+0x39a>
						if (progIf == 0x40)
     604:	80 7d f4 40          	cmp    BYTE PTR [ebp-0xc],0x40
     608:	75 0a                	jne    614 <pci_get_subclass_string+0x380>
								return "PCI-to-PCI bridge (ST, pri)";
     60a:	b8 73 06 00 00       	mov    eax,0x673
     60f:	e9 3f 07 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 0x80)
     614:	80 7d f4 80          	cmp    BYTE PTR [ebp-0xc],0x80
     618:	75 0a                	jne    624 <pci_get_subclass_string+0x390>
								return "PCI-to-PCI bridge (ST, sec)";
     61a:	b8 8f 06 00 00       	mov    eax,0x68f
     61f:	e9 2f 07 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
								return "possibly PCI-to-PCI bridge (ST)";
     624:	b8 ac 06 00 00       	mov    eax,0x6ac
     629:	e9 25 07 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 10)
     62e:	80 7d f8 0a          	cmp    BYTE PTR [ebp-0x8],0xa
     632:	75 0a                	jne    63e <pci_get_subclass_string+0x3aa>
						return "InfiniBand-to-PCI host bridge";
     634:	b8 cc 06 00 00       	mov    eax,0x6cc
     639:	e9 15 07 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 0x80)
     63e:	80 7d f8 80          	cmp    BYTE PTR [ebp-0x8],0x80
     642:	75 0a                	jne    64e <pci_get_subclass_string+0x3ba>
						return "other bridge device";
     644:	b8 ea 06 00 00       	mov    eax,0x6ea
     649:	e9 05 07 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						return "unrecognized bridge device";
     64e:	b8 fe 06 00 00       	mov    eax,0x6fe
     653:	e9 fb 06 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
		else if (cls == 7)
     658:	80 7d fc 07          	cmp    BYTE PTR [ebp-0x4],0x7
     65c:	0f 85 5a 01 00 00    	jne    7bc <pci_get_subclass_string+0x528>
				if (scls == 0)
     662:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     666:	75 7a                	jne    6e2 <pci_get_subclass_string+0x44e>
						if (progIf == 0)
     668:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
     66c:	75 0a                	jne    678 <pci_get_subclass_string+0x3e4>
								return "generic XT-compatible serial controller";
     66e:	b8 1c 07 00 00       	mov    eax,0x71c
     673:	e9 db 06 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 1)
     678:	80 7d f4 01          	cmp    BYTE PTR [ebp-0xc],0x1
     67c:	75 0a                	jne    688 <pci_get_subclass_string+0x3f4>
								return "16450-compatible serial controller";
     67e:	b8 44 07 00 00       	mov    eax,0x744
     683:	e9 cb 06 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 2)
     688:	80 7d f4 02          	cmp    BYTE PTR [ebp-0xc],0x2
     68c:	75 0a                	jne    698 <pci_get_subclass_string+0x404>
								return "16550-compatible serial controller";
     68e:	b8 68 07 00 00       	mov    eax,0x768
     693:	e9 bb 06 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 3)
     698:	80 7d f4 03          	cmp    BYTE PTR [ebp-0xc],0x3
     69c:	75 0a                	jne    6a8 <pci_get_subclass_string+0x414>
								return "16650-compatible serial controller";
     69e:	b8 8c 07 00 00       	mov    eax,0x78c
     6a3:	e9 ab 06 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 4)
     6a8:	80 7d f4 04          	cmp    BYTE PTR [ebp-0xc],0x4
     6ac:	75 0a                	jne    6b8 <pci_get_subclass_string+0x424>
								return "16750-compatible serial controller";
     6ae:	b8 b0 07 00 00       	mov    eax,0x7b0
     6b3:	e9 9b 06 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 5)
     6b8:	80 7d f4 05          	cmp    BYTE PTR [ebp-0xc],0x5
     6bc:	75 0a                	jne    6c8 <pci_get_subclass_string+0x434>
								return "16850-compatible serial controller";
     6be:	b8 d4 07 00 00       	mov    eax,0x7d4
     6c3:	e9 8b 06 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 6)
     6c8:	80 7d f4 06          	cmp    BYTE PTR [ebp-0xc],0x6
     6cc:	75 0a                	jne    6d8 <pci_get_subclass_string+0x444>
								return "16950-compatible serial controller";
     6ce:	b8 f8 07 00 00       	mov    eax,0x7f8
     6d3:	e9 7b 06 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
								return "other serial controller";
     6d8:	b8 1b 08 00 00       	mov    eax,0x81b
     6dd:	e9 71 06 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 1)
     6e2:	80 7d f8 01          	cmp    BYTE PTR [ebp-0x8],0x1
     6e6:	75 5a                	jne    742 <pci_get_subclass_string+0x4ae>
						if (progIf == 0)
     6e8:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
     6ec:	75 0a                	jne    6f8 <pci_get_subclass_string+0x464>
								return "parallel port";
     6ee:	b8 33 08 00 00       	mov    eax,0x833
     6f3:	e9 5b 06 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 1)
     6f8:	80 7d f4 01          	cmp    BYTE PTR [ebp-0xc],0x1
     6fc:	75 0a                	jne    708 <pci_get_subclass_string+0x474>
								return "bidirectional parallel port";
     6fe:	b8 41 08 00 00       	mov    eax,0x841
     703:	e9 4b 06 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 2)
     708:	80 7d f4 02          	cmp    BYTE PTR [ebp-0xc],0x2
     70c:	75 0a                	jne    718 <pci_get_subclass_string+0x484>
								return "ECP 1.x compliant parallel port";
     70e:	b8 60 08 00 00       	mov    eax,0x860
     713:	e9 3b 06 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 3)
     718:	80 7d f4 03          	cmp    BYTE PTR [ebp-0xc],0x3
     71c:	75 0a                	jne    728 <pci_get_subclass_string+0x494>
								return "IEEE 1284 controller";
     71e:	b8 80 08 00 00       	mov    eax,0x880
     723:	e9 2b 06 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 0xfe)
     728:	80 7d f4 fe          	cmp    BYTE PTR [ebp-0xc],0xfe
     72c:	75 0a                	jne    738 <pci_get_subclass_string+0x4a4>
								return "IEEE 1284 target device";
     72e:	b8 95 08 00 00       	mov    eax,0x895
     733:	e9 1b 06 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
								return "other parallel device";
     738:	b8 ad 08 00 00       	mov    eax,0x8ad
     73d:	e9 11 06 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 2)
     742:	80 7d f8 02          	cmp    BYTE PTR [ebp-0x8],0x2
     746:	75 0a                	jne    752 <pci_get_subclass_string+0x4be>
						return "multiport serial controller";
     748:	b8 c3 08 00 00       	mov    eax,0x8c3
     74d:	e9 01 06 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 3)
     752:	80 7d f8 03          	cmp    BYTE PTR [ebp-0x8],0x3
     756:	75 2a                	jne    782 <pci_get_subclass_string+0x4ee>
						if (progIf == 0)
     758:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
     75c:	75 0a                	jne    768 <pci_get_subclass_string+0x4d4>
								return "generic modem";
     75e:	b8 df 08 00 00       	mov    eax,0x8df
     763:	e9 eb 05 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf <= 4)
     768:	80 7d f4 04          	cmp    BYTE PTR [ebp-0xc],0x4
     76c:	77 0a                	ja     778 <pci_get_subclass_string+0x4e4>
								return "Hayes compatible modem (see progIf for details)";
     76e:	b8 f0 08 00 00       	mov    eax,0x8f0
     773:	e9 db 05 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
								return "other modem";
     778:	b8 20 09 00 00       	mov    eax,0x920
     77d:	e9 d1 05 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 4)
     782:	80 7d f8 04          	cmp    BYTE PTR [ebp-0x8],0x4
     786:	75 0a                	jne    792 <pci_get_subclass_string+0x4fe>
						return "IEEE 488.1/2 (GPIB) controller";
     788:	b8 2c 09 00 00       	mov    eax,0x92c
     78d:	e9 c1 05 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 5)
     792:	80 7d f8 05          	cmp    BYTE PTR [ebp-0x8],0x5
     796:	75 0a                	jne    7a2 <pci_get_subclass_string+0x50e>
						return "SmartCard";
     798:	b8 4b 09 00 00       	mov    eax,0x94b
     79d:	e9 b1 05 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 0x80)
     7a2:	80 7d f8 80          	cmp    BYTE PTR [ebp-0x8],0x80
     7a6:	75 0a                	jne    7b2 <pci_get_subclass_string+0x51e>
						return "other communications device";
     7a8:	b8 55 09 00 00       	mov    eax,0x955
     7ad:	e9 a1 05 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						return "unrecognized communications device";
     7b2:	b8 74 09 00 00       	mov    eax,0x974
     7b7:	e9 97 05 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
		else if (cls == 8)
     7bc:	80 7d fc 08          	cmp    BYTE PTR [ebp-0x4],0x8
     7c0:	0f 85 3a 01 00 00    	jne    900 <pci_get_subclass_string+0x66c>
				if (scls == 0)
     7c6:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     7ca:	75 5a                	jne    826 <pci_get_subclass_string+0x592>
						if (progIf == 0)
     7cc:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
     7d0:	75 0a                	jne    7dc <pci_get_subclass_string+0x548>
								return "generic 8259 PIC";
     7d2:	b8 97 09 00 00       	mov    eax,0x997
     7d7:	e9 77 05 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 1)
     7dc:	80 7d f4 01          	cmp    BYTE PTR [ebp-0xc],0x1
     7e0:	75 0a                	jne    7ec <pci_get_subclass_string+0x558>
								return "ISA PIC";
     7e2:	b8 a8 09 00 00       	mov    eax,0x9a8
     7e7:	e9 67 05 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 2)
     7ec:	80 7d f4 02          	cmp    BYTE PTR [ebp-0xc],0x2
     7f0:	75 0a                	jne    7fc <pci_get_subclass_string+0x568>
								return "EISA PIC";
     7f2:	b8 b0 09 00 00       	mov    eax,0x9b0
     7f7:	e9 57 05 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 0x10)
     7fc:	80 7d f4 10          	cmp    BYTE PTR [ebp-0xc],0x10
     800:	75 0a                	jne    80c <pci_get_subclass_string+0x578>
								return "I/O APIC";
     802:	b8 b9 09 00 00       	mov    eax,0x9b9
     807:	e9 47 05 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 0x20)
     80c:	80 7d f4 20          	cmp    BYTE PTR [ebp-0xc],0x20
     810:	75 0a                	jne    81c <pci_get_subclass_string+0x588>
								return "I/O(x) APIC";
     812:	b8 c2 09 00 00       	mov    eax,0x9c2
     817:	e9 37 05 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
								return "other interrupt controller";
     81c:	b8 ce 09 00 00       	mov    eax,0x9ce
     821:	e9 2d 05 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 1)
     826:	80 7d f8 01          	cmp    BYTE PTR [ebp-0x8],0x1
     82a:	75 3a                	jne    866 <pci_get_subclass_string+0x5d2>
						if (progIf == 0)
     82c:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
     830:	75 0a                	jne    83c <pci_get_subclass_string+0x5a8>
								return "generic 8237 DMA controller";
     832:	b8 e9 09 00 00       	mov    eax,0x9e9
     837:	e9 17 05 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 1)
     83c:	80 7d f4 01          	cmp    BYTE PTR [ebp-0xc],0x1
     840:	75 0a                	jne    84c <pci_get_subclass_string+0x5b8>
								return "ISA DMA controller";
     842:	b8 05 0a 00 00       	mov    eax,0xa05
     847:	e9 07 05 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 2)
     84c:	80 7d f4 02          	cmp    BYTE PTR [ebp-0xc],0x2
     850:	75 0a                	jne    85c <pci_get_subclass_string+0x5c8>
								return "EISA DMA controller";
     852:	b8 18 0a 00 00       	mov    eax,0xa18
     857:	e9 f7 04 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
								return "other DMA controller";
     85c:	b8 2c 0a 00 00       	mov    eax,0xa2c
     861:	e9 ed 04 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 2)
     866:	80 7d f8 02          	cmp    BYTE PTR [ebp-0x8],0x2
     86a:	75 3a                	jne    8a6 <pci_get_subclass_string+0x612>
						if (progIf == 0)
     86c:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
     870:	75 0a                	jne    87c <pci_get_subclass_string+0x5e8>
								return "generic 8254 system timer";
     872:	b8 41 0a 00 00       	mov    eax,0xa41
     877:	e9 d7 04 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 1)
     87c:	80 7d f4 01          	cmp    BYTE PTR [ebp-0xc],0x1
     880:	75 0a                	jne    88c <pci_get_subclass_string+0x5f8>
								return "ISA system timer";
     882:	b8 5b 0a 00 00       	mov    eax,0xa5b
     887:	e9 c7 04 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 2)
     88c:	80 7d f4 02          	cmp    BYTE PTR [ebp-0xc],0x2
     890:	75 0a                	jne    89c <pci_get_subclass_string+0x608>
								return "EISA system timer";
     892:	b8 6c 0a 00 00       	mov    eax,0xa6c
     897:	e9 b7 04 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
								return "other system timer";
     89c:	b8 7e 0a 00 00       	mov    eax,0xa7e
     8a1:	e9 ad 04 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 3)
     8a6:	80 7d f8 03          	cmp    BYTE PTR [ebp-0x8],0x3
     8aa:	75 2a                	jne    8d6 <pci_get_subclass_string+0x642>
						if (progIf == 0)
     8ac:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
     8b0:	75 0a                	jne    8bc <pci_get_subclass_string+0x628>
								return "generic RTC controller";
     8b2:	b8 91 0a 00 00       	mov    eax,0xa91
     8b7:	e9 97 04 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 1)
     8bc:	80 7d f4 01          	cmp    BYTE PTR [ebp-0xc],0x1
     8c0:	75 0a                	jne    8cc <pci_get_subclass_string+0x638>
								return "ISA RTC controller";
     8c2:	b8 a8 0a 00 00       	mov    eax,0xaa8
     8c7:	e9 87 04 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
								return "other RTC controller";
     8cc:	b8 bb 0a 00 00       	mov    eax,0xabb
     8d1:	e9 7d 04 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 4)
     8d6:	80 7d f8 04          	cmp    BYTE PTR [ebp-0x8],0x4
     8da:	75 0a                	jne    8e6 <pci_get_subclass_string+0x652>
						return "generic PCI Hot-Plug controller";
     8dc:	b8 d0 0a 00 00       	mov    eax,0xad0
     8e1:	e9 6d 04 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 0x80)
     8e6:	80 7d f8 80          	cmp    BYTE PTR [ebp-0x8],0x80
     8ea:	75 0a                	jne    8f6 <pci_get_subclass_string+0x662>
						return "other system peripheral";
     8ec:	b8 f0 0a 00 00       	mov    eax,0xaf0
     8f1:	e9 5d 04 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						return "unrecognized system peripheral";
     8f6:	b8 08 0b 00 00       	mov    eax,0xb08
     8fb:	e9 53 04 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
		else if (cls == 9)
     900:	80 7d fc 09          	cmp    BYTE PTR [ebp-0x4],0x9
     904:	0f 85 8a 00 00 00    	jne    994 <pci_get_subclass_string+0x700>
				if (scls == 0)
     90a:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     90e:	75 0a                	jne    91a <pci_get_subclass_string+0x686>
						return "keyboard controller";
     910:	b8 27 0b 00 00       	mov    eax,0xb27
     915:	e9 39 04 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 1)
     91a:	80 7d f8 01          	cmp    BYTE PTR [ebp-0x8],0x1
     91e:	75 0a                	jne    92a <pci_get_subclass_string+0x696>
						return "digitizer";
     920:	b8 3b 0b 00 00       	mov    eax,0xb3b
     925:	e9 29 04 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 2)
     92a:	80 7d f8 02          	cmp    BYTE PTR [ebp-0x8],0x2
     92e:	75 0a                	jne    93a <pci_get_subclass_string+0x6a6>
						return "mouse controller";
     930:	b8 45 0b 00 00       	mov    eax,0xb45
     935:	e9 19 04 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 3)
     93a:	80 7d f8 03          	cmp    BYTE PTR [ebp-0x8],0x3
     93e:	75 0a                	jne    94a <pci_get_subclass_string+0x6b6>
						return "scanner controller";
     940:	b8 56 0b 00 00       	mov    eax,0xb56
     945:	e9 09 04 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 4)
     94a:	80 7d f8 04          	cmp    BYTE PTR [ebp-0x8],0x4
     94e:	75 2a                	jne    97a <pci_get_subclass_string+0x6e6>
						if (progIf == 0)
     950:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
     954:	75 0a                	jne    960 <pci_get_subclass_string+0x6cc>
								return "Gameport controller (generic)";
     956:	b8 69 0b 00 00       	mov    eax,0xb69
     95b:	e9 f3 03 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 0x10)
     960:	80 7d f4 10          	cmp    BYTE PTR [ebp-0xc],0x10
     964:	75 0a                	jne    970 <pci_get_subclass_string+0x6dc>
								return "Gameport controller (legacy)";
     966:	b8 87 0b 00 00       	mov    eax,0xb87
     96b:	e9 e3 03 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
								return "other Gameport controller";
     970:	b8 a4 0b 00 00       	mov    eax,0xba4
     975:	e9 d9 03 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 0x80)
     97a:	80 7d f8 80          	cmp    BYTE PTR [ebp-0x8],0x80
     97e:	75 0a                	jne    98a <pci_get_subclass_string+0x6f6>
						return "other input controller";
     980:	b8 be 0b 00 00       	mov    eax,0xbbe
     985:	e9 c9 03 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						return "unrecognized input controller";
     98a:	b8 d5 0b 00 00       	mov    eax,0xbd5
     98f:	e9 bf 03 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
		else if (cls == 10)
     994:	80 7d fc 0a          	cmp    BYTE PTR [ebp-0x4],0xa
     998:	75 2a                	jne    9c4 <pci_get_subclass_string+0x730>
				if (scls == 0)
     99a:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     99e:	75 0a                	jne    9aa <pci_get_subclass_string+0x716>
						return "generic docking station";
     9a0:	b8 f3 0b 00 00       	mov    eax,0xbf3
     9a5:	e9 a9 03 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 0x80)
     9aa:	80 7d f8 80          	cmp    BYTE PTR [ebp-0x8],0x80
     9ae:	75 0a                	jne    9ba <pci_get_subclass_string+0x726>
						return "other docking station";
     9b0:	b8 0b 0c 00 00       	mov    eax,0xc0b
     9b5:	e9 99 03 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						return "unrecognized docking station";
     9ba:	b8 21 0c 00 00       	mov    eax,0xc21
     9bf:	e9 8f 03 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
		else if (cls == 11)
     9c4:	80 7d fc 0b          	cmp    BYTE PTR [ebp-0x4],0xb
     9c8:	75 7a                	jne    a44 <pci_get_subclass_string+0x7b0>
				if (scls == 0)
     9ca:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     9ce:	75 0a                	jne    9da <pci_get_subclass_string+0x746>
						return "386 processor";
     9d0:	b8 3e 0c 00 00       	mov    eax,0xc3e
     9d5:	e9 79 03 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 1)
     9da:	80 7d f8 01          	cmp    BYTE PTR [ebp-0x8],0x1
     9de:	75 0a                	jne    9ea <pci_get_subclass_string+0x756>
						return "486 processor";
     9e0:	b8 4c 0c 00 00       	mov    eax,0xc4c
     9e5:	e9 69 03 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 2)
     9ea:	80 7d f8 02          	cmp    BYTE PTR [ebp-0x8],0x2
     9ee:	75 0a                	jne    9fa <pci_get_subclass_string+0x766>
						return "Pentiu processor";
     9f0:	b8 5a 0c 00 00       	mov    eax,0xc5a
     9f5:	e9 59 03 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 0x10)
     9fa:	80 7d f8 10          	cmp    BYTE PTR [ebp-0x8],0x10
     9fe:	75 0a                	jne    a0a <pci_get_subclass_string+0x776>
						return "Alpha processor";
     a00:	b8 6b 0c 00 00       	mov    eax,0xc6b
     a05:	e9 49 03 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 0x20)
     a0a:	80 7d f8 20          	cmp    BYTE PTR [ebp-0x8],0x20
     a0e:	75 0a                	jne    a1a <pci_get_subclass_string+0x786>
						return "PowerPC processor";
     a10:	b8 7b 0c 00 00       	mov    eax,0xc7b
     a15:	e9 39 03 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 0x30)
     a1a:	80 7d f8 30          	cmp    BYTE PTR [ebp-0x8],0x30
     a1e:	75 0a                	jne    a2a <pci_get_subclass_string+0x796>
						return "MIPS processor";
     a20:	b8 8d 0c 00 00       	mov    eax,0xc8d
     a25:	e9 29 03 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 0x40)
     a2a:	80 7d f8 40          	cmp    BYTE PTR [ebp-0x8],0x40
     a2e:	75 0a                	jne    a3a <pci_get_subclass_string+0x7a6>
						return "coprocessor";
     a30:	b8 9c 0c 00 00       	mov    eax,0xc9c
     a35:	e9 19 03 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						return "unrecognized processor";
     a3a:	b8 a8 0c 00 00       	mov    eax,0xca8
     a3f:	e9 0f 03 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
		else if (cls == 12)
     a44:	80 7d fc 0c          	cmp    BYTE PTR [ebp-0x4],0xc
     a48:	0f 85 5a 01 00 00    	jne    ba8 <pci_get_subclass_string+0x914>
				if (scls == 0)
     a4e:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     a52:	75 2a                	jne    a7e <pci_get_subclass_string+0x7ea>
						if (progIf == 0)
     a54:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
     a58:	75 0a                	jne    a64 <pci_get_subclass_string+0x7d0>
								return "IEEE 1394 controller (FireWire)";
     a5a:	b8 c0 0c 00 00       	mov    eax,0xcc0
     a5f:	e9 ef 02 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 0x10)
     a64:	80 7d f4 10          	cmp    BYTE PTR [ebp-0xc],0x10
     a68:	75 0a                	jne    a74 <pci_get_subclass_string+0x7e0>
								return "IEEE 1394 controller (OpenHCI)";
     a6a:	b8 e0 0c 00 00       	mov    eax,0xce0
     a6f:	e9 df 02 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
								return "unrecognized FireWire-compatible controller";
     a74:	b8 00 0d 00 00       	mov    eax,0xd00
     a79:	e9 d5 02 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 1)
     a7e:	80 7d f8 01          	cmp    BYTE PTR [ebp-0x8],0x1
     a82:	75 0a                	jne    a8e <pci_get_subclass_string+0x7fa>
						return "ACCESS bus";
     a84:	b8 2c 0d 00 00       	mov    eax,0xd2c
     a89:	e9 c5 02 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 2)
     a8e:	80 7d f8 02          	cmp    BYTE PTR [ebp-0x8],0x2
     a92:	75 0a                	jne    a9e <pci_get_subclass_string+0x80a>
						return "SSA";
     a94:	b8 37 0d 00 00       	mov    eax,0xd37
     a99:	e9 b5 02 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 3)
     a9e:	80 7d f8 03          	cmp    BYTE PTR [ebp-0x8],0x3
     aa2:	75 6a                	jne    b0e <pci_get_subclass_string+0x87a>
						if (progIf == 0)
     aa4:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
     aa8:	75 0a                	jne    ab4 <pci_get_subclass_string+0x820>
								return "USB (universal host controller)";
     aaa:	b8 3c 0d 00 00       	mov    eax,0xd3c
     aaf:	e9 9f 02 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 0x10)
     ab4:	80 7d f4 10          	cmp    BYTE PTR [ebp-0xc],0x10
     ab8:	75 0a                	jne    ac4 <pci_get_subclass_string+0x830>
								return "USB (open host controller)";
     aba:	b8 5c 0d 00 00       	mov    eax,0xd5c
     abf:	e9 8f 02 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 0x20)
     ac4:	80 7d f4 20          	cmp    BYTE PTR [ebp-0xc],0x20
     ac8:	75 0a                	jne    ad4 <pci_get_subclass_string+0x840>
								return "USB2 host controller (EHCI)";
     aca:	b8 77 0d 00 00       	mov    eax,0xd77
     acf:	e9 7f 02 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 0x30)
     ad4:	80 7d f4 30          	cmp    BYTE PTR [ebp-0xc],0x30
     ad8:	75 0a                	jne    ae4 <pci_get_subclass_string+0x850>
								return "USB3 host controller (xHCI)";
     ada:	b8 93 0d 00 00       	mov    eax,0xd93
     adf:	e9 6f 02 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 0x80)
     ae4:	80 7d f4 80          	cmp    BYTE PTR [ebp-0xc],0x80
     ae8:	75 0a                	jne    af4 <pci_get_subclass_string+0x860>
								return "USB";
     aea:	b8 af 0d 00 00       	mov    eax,0xdaf
     aef:	e9 5f 02 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 0xfe)
     af4:	80 7d f4 fe          	cmp    BYTE PTR [ebp-0xc],0xfe
     af8:	75 0a                	jne    b04 <pci_get_subclass_string+0x870>
								return "USB (not host controller)";
     afa:	b8 b3 0d 00 00       	mov    eax,0xdb3
     aff:	e9 4f 02 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
								return "unrecognized USB controller";
     b04:	b8 cd 0d 00 00       	mov    eax,0xdcd
     b09:	e9 45 02 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 4)
     b0e:	80 7d f8 04          	cmp    BYTE PTR [ebp-0x8],0x4
     b12:	75 0a                	jne    b1e <pci_get_subclass_string+0x88a>
						return "Fibre channel";
     b14:	b8 e9 0d 00 00       	mov    eax,0xde9
     b19:	e9 35 02 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 5)
     b1e:	80 7d f8 05          	cmp    BYTE PTR [ebp-0x8],0x5
     b22:	75 0a                	jne    b2e <pci_get_subclass_string+0x89a>
						return "SMBus";
     b24:	b8 f7 0d 00 00       	mov    eax,0xdf7
     b29:	e9 25 02 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 6)
     b2e:	80 7d f8 06          	cmp    BYTE PTR [ebp-0x8],0x6
     b32:	75 0a                	jne    b3e <pci_get_subclass_string+0x8aa>
						return "InfiniBand";
     b34:	b8 fd 0d 00 00       	mov    eax,0xdfd
     b39:	e9 15 02 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 7)
     b3e:	80 7d f8 07          	cmp    BYTE PTR [ebp-0x8],0x7
     b42:	75 3a                	jne    b7e <pci_get_subclass_string+0x8ea>
						if (progIf == 0)
     b44:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
     b48:	75 0a                	jne    b54 <pci_get_subclass_string+0x8c0>
								return "IPMI SMIC interface";
     b4a:	b8 08 0e 00 00       	mov    eax,0xe08
     b4f:	e9 ff 01 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 1)
     b54:	80 7d f4 01          	cmp    BYTE PTR [ebp-0xc],0x1
     b58:	75 0a                	jne    b64 <pci_get_subclass_string+0x8d0>
								return "IPMI kbd controller style interface";
     b5a:	b8 1c 0e 00 00       	mov    eax,0xe1c
     b5f:	e9 ef 01 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						else if (progIf == 2)
     b64:	80 7d f4 02          	cmp    BYTE PTR [ebp-0xc],0x2
     b68:	75 0a                	jne    b74 <pci_get_subclass_string+0x8e0>
								return "IPMI block transfer interface";
     b6a:	b8 40 0e 00 00       	mov    eax,0xe40
     b6f:	e9 df 01 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
								return "unrecognized IMPI interface";
     b74:	b8 5e 0e 00 00       	mov    eax,0xe5e
     b79:	e9 d5 01 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 8)
     b7e:	80 7d f8 08          	cmp    BYTE PTR [ebp-0x8],0x8
     b82:	75 0a                	jne    b8e <pci_get_subclass_string+0x8fa>
						return "SERCOS interface (IEC61491)";
     b84:	b8 7a 0e 00 00       	mov    eax,0xe7a
     b89:	e9 c5 01 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 9)
     b8e:	80 7d f8 09          	cmp    BYTE PTR [ebp-0x8],0x9
     b92:	75 0a                	jne    b9e <pci_get_subclass_string+0x90a>
						return "CANbus";
     b94:	b8 96 0e 00 00       	mov    eax,0xe96
     b99:	e9 b5 01 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						return "other bus interface";
     b9e:	b8 9d 0e 00 00       	mov    eax,0xe9d
     ba3:	e9 ab 01 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
		else if (cls == 13)
     ba8:	80 7d fc 0d          	cmp    BYTE PTR [ebp-0x4],0xd
     bac:	0f 85 8a 00 00 00    	jne    c3c <pci_get_subclass_string+0x9a8>
				if (scls == 0)
     bb2:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     bb6:	75 0a                	jne    bc2 <pci_get_subclass_string+0x92e>
						return "iRDA compatible controller";
     bb8:	b8 b1 0e 00 00       	mov    eax,0xeb1
     bbd:	e9 91 01 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 1)
     bc2:	80 7d f8 01          	cmp    BYTE PTR [ebp-0x8],0x1
     bc6:	75 0a                	jne    bd2 <pci_get_subclass_string+0x93e>
						return "consumer IR controller";
     bc8:	b8 cc 0e 00 00       	mov    eax,0xecc
     bcd:	e9 81 01 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 0x10)
     bd2:	80 7d f8 10          	cmp    BYTE PTR [ebp-0x8],0x10
     bd6:	75 0a                	jne    be2 <pci_get_subclass_string+0x94e>
						return "RF controller";
     bd8:	b8 e3 0e 00 00       	mov    eax,0xee3
     bdd:	e9 71 01 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 0x11)
     be2:	80 7d f8 11          	cmp    BYTE PTR [ebp-0x8],0x11
     be6:	75 0a                	jne    bf2 <pci_get_subclass_string+0x95e>
						return "Bluetooth controller";
     be8:	b8 f1 0e 00 00       	mov    eax,0xef1
     bed:	e9 61 01 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 0x12)
     bf2:	80 7d f8 12          	cmp    BYTE PTR [ebp-0x8],0x12
     bf6:	75 0a                	jne    c02 <pci_get_subclass_string+0x96e>
						return "Broadband controller";
     bf8:	b8 06 0f 00 00       	mov    eax,0xf06
     bfd:	e9 51 01 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 0x20)
     c02:	80 7d f8 20          	cmp    BYTE PTR [ebp-0x8],0x20
     c06:	75 0a                	jne    c12 <pci_get_subclass_string+0x97e>
						return "Ethernet controller (802.11a)";
     c08:	b8 1b 0f 00 00       	mov    eax,0xf1b
     c0d:	e9 41 01 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 0x21)
     c12:	80 7d f8 21          	cmp    BYTE PTR [ebp-0x8],0x21
     c16:	75 0a                	jne    c22 <pci_get_subclass_string+0x98e>
						return "Ethernet controller (802.11b)";
     c18:	b8 39 0f 00 00       	mov    eax,0xf39
     c1d:	e9 31 01 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 0x80)
     c22:	80 7d f8 80          	cmp    BYTE PTR [ebp-0x8],0x80
     c26:	75 0a                	jne    c32 <pci_get_subclass_string+0x99e>
						return "other wireless controller";
     c28:	b8 57 0f 00 00       	mov    eax,0xf57
     c2d:	e9 21 01 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						return "unrecognized wireless controller";
     c32:	b8 74 0f 00 00       	mov    eax,0xf74
     c37:	e9 17 01 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
		else if (cls == 14)
     c3c:	80 7d fc 0e          	cmp    BYTE PTR [ebp-0x4],0xe
     c40:	75 2a                	jne    c6c <pci_get_subclass_string+0x9d8>
				if (scls == 0)
     c42:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     c46:	75 1a                	jne    c62 <pci_get_subclass_string+0x9ce>
						if (progIf == 0)
     c48:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
     c4c:	75 0a                	jne    c58 <pci_get_subclass_string+0x9c4>
								return "Message FIFO";
     c4e:	b8 95 0f 00 00       	mov    eax,0xf95
     c53:	e9 fb 00 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
								return "I20 architecture";
     c58:	b8 a2 0f 00 00       	mov    eax,0xfa2
     c5d:	e9 f1 00 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						return "other intelligent I/O controller";
     c62:	b8 b4 0f 00 00       	mov    eax,0xfb4
     c67:	e9 e7 00 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
		else if (cls == 15)
     c6c:	80 7d fc 0f          	cmp    BYTE PTR [ebp-0x4],0xf
     c70:	75 4a                	jne    cbc <pci_get_subclass_string+0xa28>
				if (scls == 1)
     c72:	80 7d f8 01          	cmp    BYTE PTR [ebp-0x8],0x1
     c76:	75 0a                	jne    c82 <pci_get_subclass_string+0x9ee>
						return "TV controller";
     c78:	b8 d5 0f 00 00       	mov    eax,0xfd5
     c7d:	e9 d1 00 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 2)
     c82:	80 7d f8 02          	cmp    BYTE PTR [ebp-0x8],0x2
     c86:	75 0a                	jne    c92 <pci_get_subclass_string+0x9fe>
						return "audio controller";
     c88:	b8 e3 0f 00 00       	mov    eax,0xfe3
     c8d:	e9 c1 00 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 3)
     c92:	80 7d f8 03          	cmp    BYTE PTR [ebp-0x8],0x3
     c96:	75 0a                	jne    ca2 <pci_get_subclass_string+0xa0e>
						return "voice controller";
     c98:	b8 f4 0f 00 00       	mov    eax,0xff4
     c9d:	e9 b1 00 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 4)
     ca2:	80 7d f8 04          	cmp    BYTE PTR [ebp-0x8],0x4
     ca6:	75 0a                	jne    cb2 <pci_get_subclass_string+0xa1e>
						return "data controller";
     ca8:	b8 05 10 00 00       	mov    eax,0x1005
     cad:	e9 a1 00 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
						return "other satellite controller";
     cb2:	b8 15 10 00 00       	mov    eax,0x1015
     cb7:	e9 97 00 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
		else if (cls == 16)
     cbc:	80 7d fc 10          	cmp    BYTE PTR [ebp-0x4],0x10
     cc0:	75 31                	jne    cf3 <pci_get_subclass_string+0xa5f>
				if (scls == 0)
     cc2:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     cc6:	75 0a                	jne    cd2 <pci_get_subclass_string+0xa3e>
						return "network and computing de/en-cryption";
     cc8:	b8 30 10 00 00       	mov    eax,0x1030
     ccd:	e9 81 00 00 00       	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 0x10)
     cd2:	80 7d f8 10          	cmp    BYTE PTR [ebp-0x8],0x10
     cd6:	75 07                	jne    cdf <pci_get_subclass_string+0xa4b>
						return "entertainent de/en-cryption";
     cd8:	b8 55 10 00 00       	mov    eax,0x1055
     cdd:	eb 74                	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 0x80)
     cdf:	80 7d f8 80          	cmp    BYTE PTR [ebp-0x8],0x80
     ce3:	75 07                	jne    cec <pci_get_subclass_string+0xa58>
						return "other de/en-cryption";
     ce5:	b8 71 10 00 00       	mov    eax,0x1071
     cea:	eb 67                	jmp    d53 <pci_get_subclass_string+0xabf>
						return "unrecognized de/en-cryption";
     cec:	b8 86 10 00 00       	mov    eax,0x1086
     cf1:	eb 60                	jmp    d53 <pci_get_subclass_string+0xabf>
		else if (cls == 17)
     cf3:	80 7d fc 11          	cmp    BYTE PTR [ebp-0x4],0x11
     cf7:	75 48                	jne    d41 <pci_get_subclass_string+0xaad>
				if (scls == 0)
     cf9:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     cfd:	75 07                	jne    d06 <pci_get_subclass_string+0xa72>
						return "DPIO modules";
     cff:	b8 a2 10 00 00       	mov    eax,0x10a2
     d04:	eb 4d                	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 1)
     d06:	80 7d f8 01          	cmp    BYTE PTR [ebp-0x8],0x1
     d0a:	75 07                	jne    d13 <pci_get_subclass_string+0xa7f>
						return "performance conters";
     d0c:	b8 af 10 00 00       	mov    eax,0x10af
     d11:	eb 40                	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 0x10)
     d13:	80 7d f8 10          	cmp    BYTE PTR [ebp-0x8],0x10
     d17:	75 07                	jne    d20 <pci_get_subclass_string+0xa8c>
						return "communications synch plus time and freq test/measurement";
     d19:	b8 c4 10 00 00       	mov    eax,0x10c4
     d1e:	eb 33                	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 0x20)
     d20:	80 7d f8 20          	cmp    BYTE PTR [ebp-0x8],0x20
     d24:	75 07                	jne    d2d <pci_get_subclass_string+0xa99>
						return "management card";
     d26:	b8 fd 10 00 00       	mov    eax,0x10fd
     d2b:	eb 26                	jmp    d53 <pci_get_subclass_string+0xabf>
				else if (scls == 0x80)
     d2d:	80 7d f8 80          	cmp    BYTE PTR [ebp-0x8],0x80
     d31:	75 07                	jne    d3a <pci_get_subclass_string+0xaa6>
						return "other data acquisition/signal processing controller";
     d33:	b8 10 11 00 00       	mov    eax,0x1110
     d38:	eb 19                	jmp    d53 <pci_get_subclass_string+0xabf>
						return "unrecognized data acquisition/signal processing controller";
     d3a:	b8 44 11 00 00       	mov    eax,0x1144
     d3f:	eb 12                	jmp    d53 <pci_get_subclass_string+0xabf>
		else if (cls == 0xff)
     d41:	80 7d fc ff          	cmp    BYTE PTR [ebp-0x4],0xff
     d45:	75 07                	jne    d4e <pci_get_subclass_string+0xaba>
				return "device not fitting defined class";
     d47:	b8 80 11 00 00       	mov    eax,0x1180
     d4c:	eb 05                	jmp    d53 <pci_get_subclass_string+0xabf>
				return "unrecognized device class";
     d4e:	b8 a1 11 00 00       	mov    eax,0x11a1
}
     d53:	c9                   	leave
     d54:	c3                   	ret

00000d55 <pci_disable_interrupts>:
{
     d55:	55                   	push   ebp
     d56:	89 e5                	mov    ebp,esp
     d58:	83 ec 10             	sub    esp,0x10
		union pca a = d->addr; uint32_t dat;
     d5b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     d5e:	8b 00                	mov    eax,DWORD PTR [eax]
     d60:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
		a.reg_no = PCI_COMMAND;
     d63:	c6 45 f8 04          	mov    BYTE PTR [ebp-0x8],0x4
		dat = pci_read(a);
     d67:	ff 75 f8             	push   DWORD PTR [ebp-0x8]
     d6a:	e8 3e f3 ff ff       	call   ad <pci_read>
     d6f:	83 c4 04             	add    esp,0x4
     d72:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		if (dat & PCI_COMMAND_INTX_DISABLE)
     d75:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     d78:	25 00 04 00 00       	and    eax,0x400
     d7d:	85 c0                	test   eax,eax
     d7f:	74 07                	je     d88 <pci_disable_interrupts+0x33>
				return 0;
     d81:	b8 00 00 00 00       	mov    eax,0x0
     d86:	eb 33                	jmp    dbb <pci_disable_interrupts+0x66>
		dat |= PCI_COMMAND_INTX_DISABLE;
     d88:	81 4d fc 00 04 00 00 	or     DWORD PTR [ebp-0x4],0x400
		pci_write(a, dat);
     d8f:	ff 75 fc             	push   DWORD PTR [ebp-0x4]
     d92:	ff 75 f8             	push   DWORD PTR [ebp-0x8]
     d95:	e8 00 f4 ff ff       	call   19a <pci_write>
     d9a:	83 c4 08             	add    esp,0x8
		dat = pci_read(a);
     d9d:	ff 75 f8             	push   DWORD PTR [ebp-0x8]
     da0:	e8 08 f3 ff ff       	call   ad <pci_read>
     da5:	83 c4 04             	add    esp,0x4
     da8:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		return !(dat & PCI_COMMAND_INTX_DISABLE);
     dab:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     dae:	25 00 04 00 00       	and    eax,0x400
     db3:	85 c0                	test   eax,eax
     db5:	0f 94 c0             	sete   al
     db8:	0f b6 c0             	movzx  eax,al
}
     dbb:	c9                   	leave
     dbc:	c3                   	ret

00000dbd <pci_enable_interrupts>:
{
     dbd:	55                   	push   ebp
     dbe:	89 e5                	mov    ebp,esp
     dc0:	83 ec 10             	sub    esp,0x10
		union pca a = d->addr; uint32_t dat;
     dc3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     dc6:	8b 00                	mov    eax,DWORD PTR [eax]
     dc8:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
		a.reg_no = PCI_COMMAND;
     dcb:	c6 45 f8 04          	mov    BYTE PTR [ebp-0x8],0x4
		dat = pci_read(a);
     dcf:	ff 75 f8             	push   DWORD PTR [ebp-0x8]
     dd2:	e8 d6 f2 ff ff       	call   ad <pci_read>
     dd7:	83 c4 04             	add    esp,0x4
     dda:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		if (!(dat & PCI_COMMAND_INTX_DISABLE))
     ddd:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     de0:	25 00 04 00 00       	and    eax,0x400
     de5:	85 c0                	test   eax,eax
     de7:	75 07                	jne    df0 <pci_enable_interrupts+0x33>
				return 0;
     de9:	b8 00 00 00 00       	mov    eax,0x0
     dee:	eb 33                	jmp    e23 <pci_enable_interrupts+0x66>
		dat &= 0xffff0000 | ~(PCI_COMMAND_INTX_DISABLE);
     df0:	81 65 fc ff fb ff ff 	and    DWORD PTR [ebp-0x4],0xfffffbff
		pci_write(a, dat);
     df7:	ff 75 fc             	push   DWORD PTR [ebp-0x4]
     dfa:	ff 75 f8             	push   DWORD PTR [ebp-0x8]
     dfd:	e8 98 f3 ff ff       	call   19a <pci_write>
     e02:	83 c4 08             	add    esp,0x8
		dat = pci_read(a);
     e05:	ff 75 f8             	push   DWORD PTR [ebp-0x8]
     e08:	e8 a0 f2 ff ff       	call   ad <pci_read>
     e0d:	83 c4 04             	add    esp,0x4
     e10:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		return !!(dat & PCI_COMMAND_INTX_DISABLE);
     e13:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     e16:	25 00 04 00 00       	and    eax,0x400
     e1b:	85 c0                	test   eax,eax
     e1d:	0f 95 c0             	setne  al
     e20:	0f b6 c0             	movzx  eax,al
}
     e23:	c9                   	leave
     e24:	c3                   	ret

00000e25 <pci_print_is>:
{
     e25:	55                   	push   ebp
     e26:	89 e5                	mov    ebp,esp
     e28:	83 ec 18             	sub    esp,0x18
		ad.reg_no = PCI_STATUS;
     e2b:	c6 45 08 06          	mov    BYTE PTR [ebp+0x8],0x6
		rv = !!(pci_read_word(ad) & PCI_STATUS_INTERRUPT);
     e2f:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     e32:	e8 9e f2 ff ff       	call   d5 <pci_read_word>
     e37:	83 c4 04             	add    esp,0x4
     e3a:	0f b7 c0             	movzx  eax,ax
     e3d:	83 e0 08             	and    eax,0x8
     e40:	85 c0                	test   eax,eax
     e42:	0f 95 c0             	setne  al
     e45:	0f b6 c0             	movzx  eax,al
     e48:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		printf("PCI IS: %d\n", rv);
     e4b:	83 ec 08             	sub    esp,0x8
     e4e:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
     e51:	68 bb 11 00 00       	push   0x11bb
     e56:	e8 fc ff ff ff       	call   e57 <pci_print_is+0x32>
     e5b:	83 c4 10             	add    esp,0x10
}
     e5e:	90                   	nop
     e5f:	c9                   	leave
     e60:	c3                   	ret

00000e61 <pci_set_master>:
{
     e61:	55                   	push   ebp
     e62:	89 e5                	mov    ebp,esp
     e64:	83 ec 10             	sub    esp,0x10
		union pca a = d->addr; uint32_t dat;
     e67:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     e6a:	8b 00                	mov    eax,DWORD PTR [eax]
     e6c:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
		a.reg_no = PCI_COMMAND;
     e6f:	c6 45 f8 04          	mov    BYTE PTR [ebp-0x8],0x4
		dat = pci_read(a);
     e73:	ff 75 f8             	push   DWORD PTR [ebp-0x8]
     e76:	e8 32 f2 ff ff       	call   ad <pci_read>
     e7b:	83 c4 04             	add    esp,0x4
     e7e:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		if (dat & PCI_COMMAND_MASTER)
     e81:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     e84:	83 e0 04             	and    eax,0x4
     e87:	85 c0                	test   eax,eax
     e89:	74 07                	je     e92 <pci_set_master+0x31>
				return 0;
     e8b:	b8 00 00 00 00       	mov    eax,0x0
     e90:	eb 2e                	jmp    ec0 <pci_set_master+0x5f>
		dat &= 0xffff0000 | ~(PCI_COMMAND_MASTER);
     e92:	83 65 fc fb          	and    DWORD PTR [ebp-0x4],0xfffffffb
		pci_write(a, dat);
     e96:	ff 75 fc             	push   DWORD PTR [ebp-0x4]
     e99:	ff 75 f8             	push   DWORD PTR [ebp-0x8]
     e9c:	e8 f9 f2 ff ff       	call   19a <pci_write>
     ea1:	83 c4 08             	add    esp,0x8
		dat = pci_read(a);
     ea4:	ff 75 f8             	push   DWORD PTR [ebp-0x8]
     ea7:	e8 01 f2 ff ff       	call   ad <pci_read>
     eac:	83 c4 04             	add    esp,0x4
     eaf:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		return !(dat & PCI_COMMAND_MASTER);
     eb2:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     eb5:	83 e0 04             	and    eax,0x4
     eb8:	85 c0                	test   eax,eax
     eba:	0f 94 c0             	sete   al
     ebd:	0f b6 c0             	movzx  eax,al
}
     ec0:	c9                   	leave
     ec1:	c3                   	ret

00000ec2 <pci_check_interrupt>:
{
     ec2:	55                   	push   ebp
     ec3:	89 e5                	mov    ebp,esp
     ec5:	83 ec 10             	sub    esp,0x10
		union pca a = d->addr;
     ec8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     ecb:	8b 00                	mov    eax,DWORD PTR [eax]
     ecd:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		a.reg_no = PCI_STATUS;
     ed0:	c6 45 fc 06          	mov    BYTE PTR [ebp-0x4],0x6
		if (pci_read_word(a) & PCI_STATUS_INTERRUPT)
     ed4:	ff 75 fc             	push   DWORD PTR [ebp-0x4]
     ed7:	e8 f9 f1 ff ff       	call   d5 <pci_read_word>
     edc:	83 c4 04             	add    esp,0x4
     edf:	0f b7 c0             	movzx  eax,ax
     ee2:	83 e0 08             	and    eax,0x8
     ee5:	85 c0                	test   eax,eax
     ee7:	74 07                	je     ef0 <pci_check_interrupt+0x2e>
				return 1;
     ee9:	b8 01 00 00 00       	mov    eax,0x1
     eee:	eb 05                	jmp    ef5 <pci_check_interrupt+0x33>
		return 0;
     ef0:	b8 00 00 00 00       	mov    eax,0x0
}
     ef5:	c9                   	leave
     ef6:	c3                   	ret

00000ef7 <pci_find_device>:
{
     ef7:	55                   	push   ebp
     ef8:	89 e5                	mov    ebp,esp
     efa:	83 ec 28             	sub    esp,0x28
     efd:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
     f00:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     f03:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     f06:	88 4d e4             	mov    BYTE PTR [ebp-0x1c],cl
     f09:	88 55 e0             	mov    BYTE PTR [ebp-0x20],dl
     f0c:	88 45 dc             	mov    BYTE PTR [ebp-0x24],al
		struct dle* d; struct pci_device* rv = NULL;
     f0f:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
		lock_list(device_list.devices);
     f16:	83 ec 0c             	sub    esp,0xc
     f19:	68 08 00 00 00       	push   0x8
     f1e:	e8 fc ff ff ff       	call   f1f <pci_find_device+0x28>
     f23:	83 c4 10             	add    esp,0x10
		list_for_each_entry(d, &device_list.devices, devices) {
     f26:	a1 04 00 00 00       	mov    eax,ds:0x4
     f2b:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
     f2e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     f31:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     f34:	eb 51                	jmp    f87 <pci_find_device+0x90>
				if (d->dev.device_class == cls && d->dev.device_subclass == subcls) {
     f36:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     f39:	0f b6 40 10          	movzx  eax,BYTE PTR [eax+0x10]
     f3d:	38 45 e4             	cmp    BYTE PTR [ebp-0x1c],al
     f40:	75 36                	jne    f78 <pci_find_device+0x81>
     f42:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     f45:	0f b6 40 11          	movzx  eax,BYTE PTR [eax+0x11]
     f49:	38 45 e0             	cmp    BYTE PTR [ebp-0x20],al
     f4c:	75 2a                	jne    f78 <pci_find_device+0x81>
						if (d->dev.device_interface == ifc || ifc == 0xff) {
     f4e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     f51:	0f b6 40 12          	movzx  eax,BYTE PTR [eax+0x12]
     f55:	38 45 dc             	cmp    BYTE PTR [ebp-0x24],al
     f58:	74 06                	je     f60 <pci_find_device+0x69>
     f5a:	80 7d dc ff          	cmp    BYTE PTR [ebp-0x24],0xff
     f5e:	75 18                	jne    f78 <pci_find_device+0x81>
								if (!ct--) {
     f60:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     f63:	8d 50 ff             	lea    edx,[eax-0x1]
     f66:	89 55 14             	mov    DWORD PTR [ebp+0x14],edx
     f69:	85 c0                	test   eax,eax
     f6b:	75 0b                	jne    f78 <pci_find_device+0x81>
										rv = &d->dev;
     f6d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     f70:	83 c0 0c             	add    eax,0xc
     f73:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
										goto exit;
     f76:	eb 19                	jmp    f91 <pci_find_device+0x9a>
		list_for_each_entry(d, &device_list.devices, devices) {
     f78:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     f7b:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     f7e:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
     f81:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     f84:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     f87:	81 7d f4 00 00 00 00 	cmp    DWORD PTR [ebp-0xc],0x0
     f8e:	75 a6                	jne    f36 <pci_find_device+0x3f>
exit:
     f90:	90                   	nop
		unlock_list(device_list.devices);
     f91:	83 ec 0c             	sub    esp,0xc
     f94:	68 08 00 00 00       	push   0x8
     f99:	e8 fc ff ff ff       	call   f9a <pci_find_device+0xa3>
     f9e:	83 c4 10             	add    esp,0x10
		return rv;
     fa1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
}
     fa4:	c9                   	leave
     fa5:	c3                   	ret

00000fa6 <pci_set_bar>:
{
     fa6:	55                   	push   ebp
     fa7:	89 e5                	mov    ebp,esp
     fa9:	56                   	push   esi
     faa:	53                   	push   ebx
     fab:	83 ec 18             	sub    esp,0x18
     fae:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     fb1:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
     fb4:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     fb7:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		union pca addr = dev->addr;
     fba:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     fbd:	8b 00                	mov    eax,DWORD PTR [eax]
     fbf:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		if (i > 5)
     fc2:	83 7d 0c 05          	cmp    DWORD PTR [ebp+0xc],0x5
     fc6:	0f 87 63 02 00 00    	ja     122f <pci_set_bar+0x289>
		addr.reg_no = PCI_BASE_ADDRESS_0 + i * 4;
     fcc:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     fcf:	83 c0 04             	add    eax,0x4
     fd2:	c1 e0 02             	shl    eax,0x2
     fd5:	88 45 f0             	mov    BYTE PTR [ebp-0x10],al
		dat = pci_read(addr);
     fd8:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
     fdb:	e8 cd f0 ff ff       	call   ad <pci_read>
     fe0:	83 c4 04             	add    esp,0x4
     fe3:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if ((dat & 0xf) != tp) /* only I/O space for those */
     fe6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     fe9:	83 e0 0f             	and    eax,0xf
     fec:	39 45 10             	cmp    DWORD PTR [ebp+0x10],eax
     fef:	0f 85 3d 02 00 00    	jne    1232 <pci_set_bar+0x28c>
		if (i > 5 || ((tp & PCI_BAR_64_BIT) && i == 5))
     ff5:	83 7d 0c 05          	cmp    DWORD PTR [ebp+0xc],0x5
     ff9:	0f 87 36 02 00 00    	ja     1235 <pci_set_bar+0x28f>
     fff:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1002:	83 e0 04             	and    eax,0x4
    1005:	85 c0                	test   eax,eax
    1007:	74 0a                	je     1013 <pci_set_bar+0x6d>
    1009:	83 7d 0c 05          	cmp    DWORD PTR [ebp+0xc],0x5
    100d:	0f 84 22 02 00 00    	je     1235 <pci_set_bar+0x28f>
		if (tp & PCI_BAR_PIO) {
    1013:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1016:	83 e0 01             	and    eax,0x1
    1019:	85 c0                	test   eax,eax
    101b:	74 55                	je     1072 <pci_set_bar+0xcc>
				dat = (dat & 0x3) | ((uint32_t)ofs & 0xfffc);
    101d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1020:	83 e0 03             	and    eax,0x3
    1023:	89 c2                	mov    edx,eax
    1025:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1028:	25 fc ff 00 00       	and    eax,0xfffc
    102d:	09 d0                	or     eax,edx
    102f:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				pci_write(addr, dat);
    1032:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    1035:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    1038:	e8 5d f1 ff ff       	call   19a <pci_write>
    103d:	83 c4 08             	add    esp,0x8
				dat = pci_read(addr);
    1040:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    1043:	e8 65 f0 ff ff       	call   ad <pci_read>
    1048:	83 c4 04             	add    esp,0x4
    104b:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				dev->ressources[i].pio.base = (dat & 0xfffc);
    104e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1051:	83 e0 fc             	and    eax,0xfffffffc
    1054:	89 c1                	mov    ecx,eax
    1056:	8b 5d 08             	mov    ebx,DWORD PTR [ebp+0x8]
    1059:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    105c:	89 d0                	mov    eax,edx
    105e:	01 c0                	add    eax,eax
    1060:	01 d0                	add    eax,edx
    1062:	c1 e0 03             	shl    eax,0x3
    1065:	01 d8                	add    eax,ebx
    1067:	83 c0 28             	add    eax,0x28
    106a:	66 89 08             	mov    WORD PTR [eax],cx
    106d:	e9 c4 01 00 00       	jmp    1236 <pci_set_bar+0x290>
		} else if (tp & PCI_BAR_16_BIT) {
    1072:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1075:	83 e0 02             	and    eax,0x2
    1078:	85 c0                	test   eax,eax
    107a:	74 66                	je     10e2 <pci_set_bar+0x13c>
				dat = (dat & 0xf) | ((uint32_t)ofs & 0x0000fff0);
    107c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    107f:	83 e0 0f             	and    eax,0xf
    1082:	89 c2                	mov    edx,eax
    1084:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1087:	25 f0 ff 00 00       	and    eax,0xfff0
    108c:	09 d0                	or     eax,edx
    108e:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				pci_write(addr, dat);
    1091:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    1094:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    1097:	e8 fe f0 ff ff       	call   19a <pci_write>
    109c:	83 c4 08             	add    esp,0x8
				dat = pci_read(addr);
    109f:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    10a2:	e8 06 f0 ff ff       	call   ad <pci_read>
    10a7:	83 c4 04             	add    esp,0x4
    10aa:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				dev->ressources[i].mmio.base = (dat & 0xfff0);
    10ad:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    10b0:	ba 00 00 00 00       	mov    edx,0x0
    10b5:	25 f0 ff 00 00       	and    eax,0xfff0
    10ba:	ba 00 00 00 00       	mov    edx,0x0
    10bf:	89 c1                	mov    ecx,eax
    10c1:	89 d3                	mov    ebx,edx
    10c3:	8b 75 08             	mov    esi,DWORD PTR [ebp+0x8]
    10c6:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    10c9:	89 d0                	mov    eax,edx
    10cb:	01 c0                	add    eax,eax
    10cd:	01 d0                	add    eax,edx
    10cf:	c1 e0 03             	shl    eax,0x3
    10d2:	01 f0                	add    eax,esi
    10d4:	83 c0 20             	add    eax,0x20
    10d7:	89 48 08             	mov    DWORD PTR [eax+0x8],ecx
    10da:	89 58 0c             	mov    DWORD PTR [eax+0xc],ebx
    10dd:	e9 54 01 00 00       	jmp    1236 <pci_set_bar+0x290>
		} else if (tp & PCI_BAR_64_BIT) {
    10e2:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    10e5:	83 e0 04             	and    eax,0x4
    10e8:	85 c0                	test   eax,eax
    10ea:	0f 84 e0 00 00 00    	je     11d0 <pci_set_bar+0x22a>
				dat = (dat & 0xf) | ((uint32_t)ofs & 0xfffffff0);
    10f0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    10f3:	83 e0 0f             	and    eax,0xf
    10f6:	89 c2                	mov    edx,eax
    10f8:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    10fb:	83 e0 f0             	and    eax,0xfffffff0
    10fe:	09 d0                	or     eax,edx
    1100:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				pci_write(addr, dat);
    1103:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    1106:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    1109:	e8 8c f0 ff ff       	call   19a <pci_write>
    110e:	83 c4 08             	add    esp,0x8
				addr.reg_no += 4;
    1111:	0f b6 45 f0          	movzx  eax,BYTE PTR [ebp-0x10]
    1115:	83 c0 04             	add    eax,0x4
    1118:	88 45 f0             	mov    BYTE PTR [ebp-0x10],al
				dat = (uint32_t)(ofs >> 32);
    111b:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    111e:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    1121:	89 d0                	mov    eax,edx
    1123:	31 d2                	xor    edx,edx
    1125:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				pci_write(addr, dat);
    1128:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    112b:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    112e:	e8 67 f0 ff ff       	call   19a <pci_write>
    1133:	83 c4 08             	add    esp,0x8
				dat = pci_read(addr);
    1136:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    1139:	e8 6f ef ff ff       	call   ad <pci_read>
    113e:	83 c4 04             	add    esp,0x4
    1141:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				dev->ressources[i].mmio.base = (uint64_t)dat << 32;
    1144:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1147:	ba 00 00 00 00       	mov    edx,0x0
    114c:	89 c2                	mov    edx,eax
    114e:	31 c0                	xor    eax,eax
    1150:	89 c1                	mov    ecx,eax
    1152:	89 d3                	mov    ebx,edx
    1154:	8b 75 08             	mov    esi,DWORD PTR [ebp+0x8]
    1157:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    115a:	89 d0                	mov    eax,edx
    115c:	01 c0                	add    eax,eax
    115e:	01 d0                	add    eax,edx
    1160:	c1 e0 03             	shl    eax,0x3
    1163:	01 f0                	add    eax,esi
    1165:	83 c0 20             	add    eax,0x20
    1168:	89 48 08             	mov    DWORD PTR [eax+0x8],ecx
    116b:	89 58 0c             	mov    DWORD PTR [eax+0xc],ebx
				addr.reg_no -= 4;
    116e:	0f b6 45 f0          	movzx  eax,BYTE PTR [ebp-0x10]
    1172:	83 e8 04             	sub    eax,0x4
    1175:	88 45 f0             	mov    BYTE PTR [ebp-0x10],al
				dat = pci_read(addr);
    1178:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    117b:	e8 2d ef ff ff       	call   ad <pci_read>
    1180:	83 c4 04             	add    esp,0x4
    1183:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				dev->ressources[i].mmio.base |= (dat & 0xfffffff0);
    1186:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    1189:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    118c:	89 d0                	mov    eax,edx
    118e:	01 c0                	add    eax,eax
    1190:	01 d0                	add    eax,edx
    1192:	c1 e0 03             	shl    eax,0x3
    1195:	01 c8                	add    eax,ecx
    1197:	83 c0 20             	add    eax,0x20
    119a:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    119d:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    11a0:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    11a3:	bb 00 00 00 00       	mov    ebx,0x0
    11a8:	83 e1 f0             	and    ecx,0xfffffff0
    11ab:	bb 00 00 00 00       	mov    ebx,0x0
    11b0:	09 c1                	or     ecx,eax
    11b2:	09 d3                	or     ebx,edx
    11b4:	8b 75 08             	mov    esi,DWORD PTR [ebp+0x8]
    11b7:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    11ba:	89 d0                	mov    eax,edx
    11bc:	01 c0                	add    eax,eax
    11be:	01 d0                	add    eax,edx
    11c0:	c1 e0 03             	shl    eax,0x3
    11c3:	01 f0                	add    eax,esi
    11c5:	83 c0 20             	add    eax,0x20
    11c8:	89 48 08             	mov    DWORD PTR [eax+0x8],ecx
    11cb:	89 58 0c             	mov    DWORD PTR [eax+0xc],ebx
    11ce:	eb 66                	jmp    1236 <pci_set_bar+0x290>
				dat = (dat & 0xf) | ((uint32_t)ofs & 0xfffffff0);
    11d0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    11d3:	83 e0 0f             	and    eax,0xf
    11d6:	89 c2                	mov    edx,eax
    11d8:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    11db:	83 e0 f0             	and    eax,0xfffffff0
    11de:	09 d0                	or     eax,edx
    11e0:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				pci_write(addr, dat);
    11e3:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    11e6:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    11e9:	e8 ac ef ff ff       	call   19a <pci_write>
    11ee:	83 c4 08             	add    esp,0x8
				dat = pci_read(addr);
    11f1:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    11f4:	e8 b4 ee ff ff       	call   ad <pci_read>
    11f9:	83 c4 04             	add    esp,0x4
    11fc:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				dev->ressources[i].mmio.base = (dat & 0xfffffff0);
    11ff:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1202:	ba 00 00 00 00       	mov    edx,0x0
    1207:	83 e0 f0             	and    eax,0xfffffff0
    120a:	ba 00 00 00 00       	mov    edx,0x0
    120f:	89 c1                	mov    ecx,eax
    1211:	89 d3                	mov    ebx,edx
    1213:	8b 75 08             	mov    esi,DWORD PTR [ebp+0x8]
    1216:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    1219:	89 d0                	mov    eax,edx
    121b:	01 c0                	add    eax,eax
    121d:	01 d0                	add    eax,edx
    121f:	c1 e0 03             	shl    eax,0x3
    1222:	01 f0                	add    eax,esi
    1224:	83 c0 20             	add    eax,0x20
    1227:	89 48 08             	mov    DWORD PTR [eax+0x8],ecx
    122a:	89 58 0c             	mov    DWORD PTR [eax+0xc],ebx
    122d:	eb 07                	jmp    1236 <pci_set_bar+0x290>
				return;
    122f:	90                   	nop
    1230:	eb 04                	jmp    1236 <pci_set_bar+0x290>
				return;
    1232:	90                   	nop
    1233:	eb 01                	jmp    1236 <pci_set_bar+0x290>
				return;
    1235:	90                   	nop
}
    1236:	8d 65 f8             	lea    esp,[ebp-0x8]
    1239:	5b                   	pop    ebx
    123a:	5e                   	pop    esi
    123b:	5d                   	pop    ebp
    123c:	c3                   	ret

0000123d <pci_bar_get_size>:
{
    123d:	55                   	push   ebp
    123e:	89 e5                	mov    ebp,esp
    1240:	83 ec 20             	sub    esp,0x20
		union pca a = d->addr; uint32_t dat, datH;
    1243:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1246:	8b 00                	mov    eax,DWORD PTR [eax]
    1248:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		uint64_t rv = 0;
    124b:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [ebp-0x8],0x0
    1252:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
		if (i > 5)
    1259:	83 7d 0c 05          	cmp    DWORD PTR [ebp+0xc],0x5
    125d:	76 0f                	jbe    126e <pci_bar_get_size+0x31>
				return 0;
    125f:	b8 00 00 00 00       	mov    eax,0x0
    1264:	ba 00 00 00 00       	mov    edx,0x0
    1269:	e9 5a 01 00 00       	jmp    13c8 <pci_bar_get_size+0x18b>
		a.reg_no = PCI_BASE_ADDRESS_0 + i * 4;
    126e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1271:	83 c0 04             	add    eax,0x4
    1274:	c1 e0 02             	shl    eax,0x2
    1277:	88 45 e8             	mov    BYTE PTR [ebp-0x18],al
		dat = pci_read(a);
    127a:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    127d:	e8 2b ee ff ff       	call   ad <pci_read>
    1282:	83 c4 04             	add    esp,0x4
    1285:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (dat & 1) { /* PIO */
    1288:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    128b:	83 e0 01             	and    eax,0x1
    128e:	85 c0                	test   eax,eax
    1290:	74 52                	je     12e4 <pci_bar_get_size+0xa7>
				pci_write(a, 0xffff);
    1292:	68 ff ff 00 00       	push   0xffff
    1297:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    129a:	e8 fb ee ff ff       	call   19a <pci_write>
    129f:	83 c4 08             	add    esp,0x8
				rv = pci_read(a) & 0xfffc;
    12a2:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    12a5:	e8 03 ee ff ff       	call   ad <pci_read>
    12aa:	83 c4 04             	add    esp,0x4
    12ad:	ba 00 00 00 00       	mov    edx,0x0
    12b2:	25 fc ff 00 00       	and    eax,0xfffc
    12b7:	ba 00 00 00 00       	mov    edx,0x0
    12bc:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
    12bf:	89 55 fc             	mov    DWORD PTR [ebp-0x4],edx
				pci_write(a, dat);
    12c2:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    12c5:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    12c8:	e8 cd ee ff ff       	call   19a <pci_write>
    12cd:	83 c4 08             	add    esp,0x8
				rv = (uint64_t)(~(uint16_t)rv + 1);
    12d0:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    12d3:	0f b7 c0             	movzx  eax,ax
    12d6:	f7 d8                	neg    eax
    12d8:	99                   	cdq
    12d9:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
    12dc:	89 55 fc             	mov    DWORD PTR [ebp-0x4],edx
    12df:	e9 de 00 00 00       	jmp    13c2 <pci_bar_get_size+0x185>
				uint32_t tp = (dat >> 1) & 0x3;
    12e4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    12e7:	d1 e8                	shr    eax,1
    12e9:	83 e0 03             	and    eax,0x3
    12ec:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				if (tp == 2) {
    12ef:	83 7d f0 02          	cmp    DWORD PTR [ebp-0x10],0x2
    12f3:	75 61                	jne    1356 <pci_bar_get_size+0x119>
						a.reg_no += 4;
    12f5:	0f b6 45 e8          	movzx  eax,BYTE PTR [ebp-0x18]
    12f9:	83 c0 04             	add    eax,0x4
    12fc:	88 45 e8             	mov    BYTE PTR [ebp-0x18],al
						datH = pci_read(a);
    12ff:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    1302:	e8 a6 ed ff ff       	call   ad <pci_read>
    1307:	83 c4 04             	add    esp,0x4
    130a:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
						pci_write(a, 0xffffffff);
    130d:	6a ff                	push   0xffffffff
    130f:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    1312:	e8 83 ee ff ff       	call   19a <pci_write>
    1317:	83 c4 08             	add    esp,0x8
						a.reg_no -= 4;
    131a:	0f b6 45 e8          	movzx  eax,BYTE PTR [ebp-0x18]
    131e:	83 e8 04             	sub    eax,0x4
    1321:	88 45 e8             	mov    BYTE PTR [ebp-0x18],al
						rv = (uint64_t)pci_read(a) << 32;
    1324:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    1327:	e8 81 ed ff ff       	call   ad <pci_read>
    132c:	83 c4 04             	add    esp,0x4
    132f:	ba 00 00 00 00       	mov    edx,0x0
    1334:	89 c2                	mov    edx,eax
    1336:	31 c0                	xor    eax,eax
    1338:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
    133b:	89 55 fc             	mov    DWORD PTR [ebp-0x4],edx
						pci_write(a, datH);
    133e:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
    1341:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    1344:	e8 51 ee ff ff       	call   19a <pci_write>
    1349:	83 c4 08             	add    esp,0x8
						a.reg_no -= 4;
    134c:	0f b6 45 e8          	movzx  eax,BYTE PTR [ebp-0x18]
    1350:	83 e8 04             	sub    eax,0x4
    1353:	88 45 e8             	mov    BYTE PTR [ebp-0x18],al
				pci_write(a, 0xffffffff);
    1356:	6a ff                	push   0xffffffff
    1358:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    135b:	e8 3a ee ff ff       	call   19a <pci_write>
    1360:	83 c4 08             	add    esp,0x8
				rv |= (pci_read(a) & 0xfffffff0);
    1363:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    1366:	e8 42 ed ff ff       	call   ad <pci_read>
    136b:	83 c4 04             	add    esp,0x4
    136e:	83 e0 f0             	and    eax,0xfffffff0
    1371:	ba 00 00 00 00       	mov    edx,0x0
    1376:	09 45 f8             	or     DWORD PTR [ebp-0x8],eax
    1379:	09 55 fc             	or     DWORD PTR [ebp-0x4],edx
				pci_write(a, dat);
    137c:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    137f:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    1382:	e8 13 ee ff ff       	call   19a <pci_write>
    1387:	83 c4 08             	add    esp,0x8
				if (tp == 2) {
    138a:	83 7d f0 02          	cmp    DWORD PTR [ebp-0x10],0x2
    138e:	75 0c                	jne    139c <pci_bar_get_size+0x15f>
						rv = ~rv + 1;
    1390:	f7 5d f8             	neg    DWORD PTR [ebp-0x8]
    1393:	83 55 fc 00          	adc    DWORD PTR [ebp-0x4],0x0
    1397:	f7 5d fc             	neg    DWORD PTR [ebp-0x4]
    139a:	eb 26                	jmp    13c2 <pci_bar_get_size+0x185>
				} else if (tp == 1) {
    139c:	83 7d f0 01          	cmp    DWORD PTR [ebp-0x10],0x1
    13a0:	75 11                	jne    13b3 <pci_bar_get_size+0x176>
						rv = (uint64_t)(~(uint16_t)rv + 1);
    13a2:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    13a5:	0f b7 c0             	movzx  eax,ax
    13a8:	f7 d8                	neg    eax
    13aa:	99                   	cdq
    13ab:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
    13ae:	89 55 fc             	mov    DWORD PTR [ebp-0x4],edx
    13b1:	eb 0f                	jmp    13c2 <pci_bar_get_size+0x185>
						rv = (uint64_t)(~(uint32_t)rv + 1);
    13b3:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    13b6:	f7 d8                	neg    eax
    13b8:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
    13bb:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
		return rv;
    13c2:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    13c5:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
}
    13c8:	c9                   	leave
    13c9:	c3                   	ret

000013ca <pci_init_msi>:
{
    13ca:	55                   	push   ebp
    13cb:	89 e5                	mov    ebp,esp
    13cd:	83 ec 18             	sub    esp,0x18
		uint32_t dat; union pca a = d->addr;
    13d0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    13d3:	8b 00                	mov    eax,DWORD PTR [eax]
    13d5:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		if (!(a.reg_no = d->cap_ptrs[PCI_CAP_ID_MSI]))
    13d8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    13db:	0f b6 40 13          	movzx  eax,BYTE PTR [eax+0x13]
    13df:	88 45 e8             	mov    BYTE PTR [ebp-0x18],al
    13e2:	0f b6 45 e8          	movzx  eax,BYTE PTR [ebp-0x18]
    13e6:	84 c0                	test   al,al
    13e8:	0f 84 d2 00 00 00    	je     14c0 <pci_init_msi+0xf6>
		dat = pci_read(a);
    13ee:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    13f1:	e8 b7 ec ff ff       	call   ad <pci_read>
    13f6:	83 c4 04             	add    esp,0x4
    13f9:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		n_c = (dat >> 1) & 0x7;
    13fc:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    13ff:	d1 e8                	shr    eax,1
    1401:	83 e0 07             	and    eax,0x7
    1404:	88 45 ef             	mov    BYTE PTR [ebp-0x11],al
		n_e = (dat >> 4) & 0x7;
    1407:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    140a:	c1 e8 04             	shr    eax,0x4
    140d:	83 e0 07             	and    eax,0x7
    1410:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
		cprintf(KFMT_INFO, "MSI cap: %u capable %u enable and status %u\n",
    1413:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1416:	83 e0 01             	and    eax,0x1
    1419:	89 c1                	mov    ecx,eax
    141b:	0f b6 55 f7          	movzx  edx,BYTE PTR [ebp-0x9]
    141f:	0f b6 45 ef          	movzx  eax,BYTE PTR [ebp-0x11]
    1423:	83 ec 0c             	sub    esp,0xc
    1426:	51                   	push   ecx
    1427:	52                   	push   edx
    1428:	50                   	push   eax
    1429:	68 c8 11 00 00       	push   0x11c8
    142e:	6a 0b                	push   0xb
    1430:	e8 fc ff ff ff       	call   1431 <pci_init_msi+0x67>
    1435:	83 c4 20             	add    esp,0x20
		if (n_e > 3) /* >8 */
    1438:	80 7d f7 03          	cmp    BYTE PTR [ebp-0x9],0x3
    143c:	76 04                	jbe    1442 <pci_init_msi+0x78>
				n_e = 3;
    143e:	c6 45 f7 03          	mov    BYTE PTR [ebp-0x9],0x3
		dat = (dat & 0xffffff8e) | (n_e << 4);
    1442:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1445:	83 e0 8e             	and    eax,0xffffff8e
    1448:	89 c2                	mov    edx,eax
    144a:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
    144e:	c1 e0 04             	shl    eax,0x4
    1451:	09 d0                	or     eax,edx
    1453:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		pci_write(a, dat);
    1456:	83 ec 08             	sub    esp,0x8
    1459:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    145c:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    145f:	e8 36 ed ff ff       	call   19a <pci_write>
    1464:	83 c4 10             	add    esp,0x10
		if (pci_read(a) != dat) {
    1467:	83 ec 0c             	sub    esp,0xc
    146a:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    146d:	e8 3b ec ff ff       	call   ad <pci_read>
    1472:	83 c4 10             	add    esp,0x10
    1475:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
    1478:	74 47                	je     14c1 <pci_init_msi+0xf7>
				cprintf(KFMT_WARN, "Failed to configure PCI MSI data.\n");
    147a:	83 ec 08             	sub    esp,0x8
    147d:	68 f8 11 00 00       	push   0x11f8
    1482:	6a 0e                	push   0xe
    1484:	e8 fc ff ff ff       	call   1485 <pci_init_msi+0xbb>
    1489:	83 c4 10             	add    esp,0x10
				printf("%08x vs %08x\n", dat, pci_read(a));
    148c:	83 ec 0c             	sub    esp,0xc
    148f:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    1492:	e8 16 ec ff ff       	call   ad <pci_read>
    1497:	83 c4 10             	add    esp,0x10
    149a:	83 ec 04             	sub    esp,0x4
    149d:	50                   	push   eax
    149e:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    14a1:	68 1b 12 00 00       	push   0x121b
    14a6:	e8 fc ff ff ff       	call   14a7 <pci_init_msi+0xdd>
    14ab:	83 c4 10             	add    esp,0x10
				mdelay(1000);
    14ae:	83 ec 0c             	sub    esp,0xc
    14b1:	68 e8 03 00 00       	push   0x3e8
    14b6:	e8 fc ff ff ff       	call   14b7 <pci_init_msi+0xed>
    14bb:	83 c4 10             	add    esp,0x10
    14be:	eb 01                	jmp    14c1 <pci_init_msi+0xf7>
				return; /* no MSI */
    14c0:	90                   	nop
}
    14c1:	c9                   	leave
    14c2:	c3                   	ret

000014c3 <pci_add_caps>:
{
    14c3:	55                   	push   ebp
    14c4:	89 e5                	mov    ebp,esp
    14c6:	83 ec 18             	sub    esp,0x18
		union pca a = d->addr; /* 5h MSI, 10h PCIe, 14h MSI-X */
    14c9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    14cc:	8b 00                	mov    eax,DWORD PTR [eax]
    14ce:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		a.reg_no = PCI_STATUS;
    14d1:	c6 45 f0 06          	mov    BYTE PTR [ebp-0x10],0x6
		dat = pci_read_word(a);
    14d5:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    14d8:	e8 f8 eb ff ff       	call   d5 <pci_read_word>
    14dd:	83 c4 04             	add    esp,0x4
    14e0:	0f b7 c0             	movzx  eax,ax
    14e3:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!(dat & PCI_STATUS_CAP_LIST))
    14e6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    14e9:	83 e0 10             	and    eax,0x10
    14ec:	85 c0                	test   eax,eax
    14ee:	0f 84 b4 00 00 00    	je     15a8 <pci_add_caps+0xe5>
		a.reg_no = ((d->device_type & 0x7f) == 2) ? PCI_CB_CAPABILITY_LIST
    14f4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    14f7:	0f b6 40 07          	movzx  eax,BYTE PTR [eax+0x7]
    14fb:	0f b6 c0             	movzx  eax,al
    14fe:	83 e0 7f             	and    eax,0x7f
    1501:	83 f8 02             	cmp    eax,0x2
    1504:	75 07                	jne    150d <pci_add_caps+0x4a>
    1506:	b8 14 00 00 00       	mov    eax,0x14
    150b:	eb 05                	jmp    1512 <pci_add_caps+0x4f>
    150d:	b8 34 00 00 00       	mov    eax,0x34
    1512:	88 45 f0             	mov    BYTE PTR [ebp-0x10],al
		a.reg_no = pci_read_byte(a) & 0xfc; /* dword alignment */
    1515:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    1518:	e8 45 ec ff ff       	call   162 <pci_read_byte>
    151d:	83 c4 04             	add    esp,0x4
    1520:	83 e0 fc             	and    eax,0xfffffffc
    1523:	88 45 f0             	mov    BYTE PTR [ebp-0x10],al
		while (a.reg_no <= 192 - 4) { /* valid capability ranges */
    1526:	eb 76                	jmp    159e <pci_add_caps+0xdb>
				cap.val = pci_read(a);
    1528:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    152b:	e8 7d eb ff ff       	call   ad <pci_read>
    1530:	83 c4 04             	add    esp,0x4
    1533:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				if (!(cap.cap > PCI_CAP_ID_MAX))
    1536:	0f b6 45 ec          	movzx  eax,BYTE PTR [ebp-0x14]
    153a:	3c 13                	cmp    al,0x13
    153c:	77 12                	ja     1550 <pci_add_caps+0x8d>
						d->cap_ptrs[cap.cap] = a.reg_no;
    153e:	0f b6 45 ec          	movzx  eax,BYTE PTR [ebp-0x14]
    1542:	0f b6 c0             	movzx  eax,al
    1545:	0f b6 4d f0          	movzx  ecx,BYTE PTR [ebp-0x10]
    1549:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    154c:	88 4c 02 0e          	mov    BYTE PTR [edx+eax*1+0xe],cl
				switch (cap.cap) {
    1550:	0f b6 45 ec          	movzx  eax,BYTE PTR [ebp-0x14]
    1554:	0f b6 c0             	movzx  eax,al
    1557:	83 f8 11             	cmp    eax,0x11
    155a:	74 29                	je     1585 <pci_add_caps+0xc2>
    155c:	83 f8 11             	cmp    eax,0x11
    155f:	7f 2b                	jg     158c <pci_add_caps+0xc9>
    1561:	83 f8 07             	cmp    eax,0x7
    1564:	74 22                	je     1588 <pci_add_caps+0xc5>
    1566:	83 f8 07             	cmp    eax,0x7
    1569:	7f 21                	jg     158c <pci_add_caps+0xc9>
    156b:	83 f8 01             	cmp    eax,0x1
    156e:	74 1b                	je     158b <pci_add_caps+0xc8>
    1570:	83 f8 05             	cmp    eax,0x5
    1573:	75 17                	jne    158c <pci_add_caps+0xc9>
								pci_init_msi(d);
    1575:	83 ec 0c             	sub    esp,0xc
    1578:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    157b:	e8 fc ff ff ff       	call   157c <pci_add_caps+0xb9>
    1580:	83 c4 10             	add    esp,0x10
								break;
    1583:	eb 07                	jmp    158c <pci_add_caps+0xc9>
								break;
    1585:	90                   	nop
    1586:	eb 04                	jmp    158c <pci_add_caps+0xc9>
								break;
    1588:	90                   	nop
    1589:	eb 01                	jmp    158c <pci_add_caps+0xc9>
								break;
    158b:	90                   	nop
				if (!(a.reg_no = (cap.next & 0xfc))) /* end of list */
    158c:	0f b6 45 ed          	movzx  eax,BYTE PTR [ebp-0x13]
    1590:	83 e0 fc             	and    eax,0xfffffffc
    1593:	88 45 f0             	mov    BYTE PTR [ebp-0x10],al
    1596:	0f b6 45 f0          	movzx  eax,BYTE PTR [ebp-0x10]
    159a:	84 c0                	test   al,al
    159c:	74 0d                	je     15ab <pci_add_caps+0xe8>
		while (a.reg_no <= 192 - 4) { /* valid capability ranges */
    159e:	0f b6 45 f0          	movzx  eax,BYTE PTR [ebp-0x10]
    15a2:	3c bc                	cmp    al,0xbc
    15a4:	76 82                	jbe    1528 <pci_add_caps+0x65>
    15a6:	eb 04                	jmp    15ac <pci_add_caps+0xe9>
				return; /* we don't have to look for it */
    15a8:	90                   	nop
    15a9:	eb 01                	jmp    15ac <pci_add_caps+0xe9>
						break;
    15ab:	90                   	nop
}
    15ac:	c9                   	leave
    15ad:	c3                   	ret

000015ae <pci_add_bars>:
{
    15ae:	55                   	push   ebp
    15af:	89 e5                	mov    ebp,esp
    15b1:	56                   	push   esi
    15b2:	53                   	push   ebx
    15b3:	83 ec 30             	sub    esp,0x30
		union pca a = d->addr;
    15b6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    15b9:	8b 00                	mov    eax,DWORD PTR [eax]
    15bb:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
		uint8_t t = d->device_type & 0x7f;
    15be:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    15c1:	0f b6 40 07          	movzx  eax,BYTE PTR [eax+0x7]
    15c5:	83 e0 7f             	and    eax,0x7f
    15c8:	88 45 ef             	mov    BYTE PTR [ebp-0x11],al
		if (t == 0 || t == 1) { /* the regular 6/2 BARs */
    15cb:	80 7d ef 00          	cmp    BYTE PTR [ebp-0x11],0x0
    15cf:	74 0a                	je     15db <pci_add_bars+0x2d>
    15d1:	80 7d ef 01          	cmp    BYTE PTR [ebp-0x11],0x1
    15d5:	0f 85 77 02 00 00    	jne    1852 <pci_add_bars+0x2a4>
				int limit = d->device_type ? 2 : 6;
    15db:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    15de:	0f b6 40 07          	movzx  eax,BYTE PTR [eax+0x7]
    15e2:	84 c0                	test   al,al
    15e4:	74 07                	je     15ed <pci_add_bars+0x3f>
    15e6:	b8 02 00 00 00       	mov    eax,0x2
    15eb:	eb 05                	jmp    15f2 <pci_add_bars+0x44>
    15ed:	b8 06 00 00 00       	mov    eax,0x6
    15f2:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
				a.reg_no = PCI_BASE_ADDRESS_0;
    15f5:	c6 45 d4 10          	mov    BYTE PTR [ebp-0x2c],0x10
				for (int i = 0; i < limit; i++) {
    15f9:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    1600:	e9 3c 02 00 00       	jmp    1841 <pci_add_bars+0x293>
						uint32_t dat = pci_read(a);
    1605:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    1608:	e8 a0 ea ff ff       	call   ad <pci_read>
    160d:	83 c4 04             	add    esp,0x4
    1610:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
						if (dat & 1) { /* I/O space */
    1613:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1616:	83 e0 01             	and    eax,0x1
    1619:	85 c0                	test   eax,eax
    161b:	74 7f                	je     169c <pci_add_bars+0xee>
								d->ressources[i].type = PCI_BAR_PIO;
    161d:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    1620:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1623:	89 d0                	mov    eax,edx
    1625:	01 c0                	add    eax,eax
    1627:	01 d0                	add    eax,edx
    1629:	c1 e0 03             	shl    eax,0x3
    162c:	01 c8                	add    eax,ecx
    162e:	83 c0 24             	add    eax,0x24
    1631:	c7 00 01 00 00 00    	mov    DWORD PTR [eax],0x1
								d->ressources[i].pio.base = dat & 0xfffc;
    1637:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    163a:	83 e0 fc             	and    eax,0xfffffffc
    163d:	89 c1                	mov    ecx,eax
    163f:	8b 5d 08             	mov    ebx,DWORD PTR [ebp+0x8]
    1642:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1645:	89 d0                	mov    eax,edx
    1647:	01 c0                	add    eax,eax
    1649:	01 d0                	add    eax,edx
    164b:	c1 e0 03             	shl    eax,0x3
    164e:	01 d8                	add    eax,ebx
    1650:	83 c0 28             	add    eax,0x28
    1653:	66 89 08             	mov    WORD PTR [eax],cx
								d->ressources[i].pio.count = 0;
    1656:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    1659:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    165c:	89 d0                	mov    eax,edx
    165e:	01 c0                	add    eax,eax
    1660:	01 d0                	add    eax,edx
    1662:	c1 e0 03             	shl    eax,0x3
    1665:	01 c8                	add    eax,ecx
    1667:	83 c0 2a             	add    eax,0x2a
    166a:	66 c7 00 00 00       	mov    WORD PTR [eax],0x0
										d->ressources[i].pio.count = pci_bar_get_size(d, i);
    166f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1672:	50                   	push   eax
    1673:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1676:	e8 fc ff ff ff       	call   1677 <pci_add_bars+0xc9>
    167b:	83 c4 08             	add    esp,0x8
    167e:	89 c3                	mov    ebx,eax
    1680:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    1683:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1686:	89 d0                	mov    eax,edx
    1688:	01 c0                	add    eax,eax
    168a:	01 d0                	add    eax,edx
    168c:	c1 e0 03             	shl    eax,0x3
    168f:	01 c8                	add    eax,ecx
    1691:	83 c0 2a             	add    eax,0x2a
    1694:	66 89 18             	mov    WORD PTR [eax],bx
    1697:	e9 97 01 00 00       	jmp    1833 <pci_add_bars+0x285>
								uint8_t tp = (dat >> 1) & 0x3;
    169c:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    169f:	d1 e8                	shr    eax,1
    16a1:	83 e0 03             	and    eax,0x3
    16a4:	88 45 db             	mov    BYTE PTR [ebp-0x25],al
								d->ressources[i].type = dat & 0xf;
    16a7:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    16aa:	83 e0 0f             	and    eax,0xf
    16ad:	89 c1                	mov    ecx,eax
    16af:	8b 5d 08             	mov    ebx,DWORD PTR [ebp+0x8]
    16b2:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    16b5:	89 d0                	mov    eax,edx
    16b7:	01 c0                	add    eax,eax
    16b9:	01 d0                	add    eax,edx
    16bb:	c1 e0 03             	shl    eax,0x3
    16be:	01 d8                	add    eax,ebx
    16c0:	83 c0 24             	add    eax,0x24
    16c3:	89 08                	mov    DWORD PTR [eax],ecx
								if (tp == 2) { /* 64-bit */
    16c5:	80 7d db 02          	cmp    BYTE PTR [ebp-0x25],0x2
    16c9:	0f 85 cd 00 00 00    	jne    179c <pci_add_bars+0x1ee>
										d->ressources[i].mmio.base = dat & 0xfffffff0;
    16cf:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    16d2:	ba 00 00 00 00       	mov    edx,0x0
    16d7:	83 e0 f0             	and    eax,0xfffffff0
    16da:	ba 00 00 00 00       	mov    edx,0x0
    16df:	89 c1                	mov    ecx,eax
    16e1:	89 d3                	mov    ebx,edx
    16e3:	8b 75 08             	mov    esi,DWORD PTR [ebp+0x8]
    16e6:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    16e9:	89 d0                	mov    eax,edx
    16eb:	01 c0                	add    eax,eax
    16ed:	01 d0                	add    eax,edx
    16ef:	c1 e0 03             	shl    eax,0x3
    16f2:	01 f0                	add    eax,esi
    16f4:	83 c0 20             	add    eax,0x20
    16f7:	89 48 08             	mov    DWORD PTR [eax+0x8],ecx
    16fa:	89 58 0c             	mov    DWORD PTR [eax+0xc],ebx
										d->ressources[i].mmio.size = 0;
    16fd:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    1700:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1703:	89 d0                	mov    eax,edx
    1705:	01 c0                	add    eax,eax
    1707:	01 d0                	add    eax,edx
    1709:	c1 e0 03             	shl    eax,0x3
    170c:	01 c8                	add    eax,ecx
    170e:	83 c0 20             	add    eax,0x20
    1711:	c7 40 10 00 00 00 00 	mov    DWORD PTR [eax+0x10],0x0
    1718:	c7 40 14 00 00 00 00 	mov    DWORD PTR [eax+0x14],0x0
										d->ressources[i].mmio.mapping = NULL;
    171f:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    1722:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1725:	89 d0                	mov    eax,edx
    1727:	01 c0                	add    eax,eax
    1729:	01 d0                	add    eax,edx
    172b:	c1 e0 03             	shl    eax,0x3
    172e:	01 c8                	add    eax,ecx
    1730:	83 c0 38             	add    eax,0x38
    1733:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
										a.reg_no += 4; i++;
    1739:	0f b6 45 d4          	movzx  eax,BYTE PTR [ebp-0x2c]
    173d:	83 c0 04             	add    eax,0x4
    1740:	88 45 d4             	mov    BYTE PTR [ebp-0x2c],al
    1743:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
												((uint64_t)pci_read(a) << 32);
    1747:	83 ec 04             	sub    esp,0x4
    174a:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    174d:	e8 5b e9 ff ff       	call   ad <pci_read>
    1752:	83 c4 08             	add    esp,0x8
    1755:	ba 00 00 00 00       	mov    edx,0x0
    175a:	89 c2                	mov    edx,eax
    175c:	31 c0                	xor    eax,eax
    175e:	89 c1                	mov    ecx,eax
    1760:	89 d3                	mov    ebx,edx
										d->ressources[i].mmio.base |=
    1762:	8b 75 08             	mov    esi,DWORD PTR [ebp+0x8]
    1765:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1768:	89 d0                	mov    eax,edx
    176a:	01 c0                	add    eax,eax
    176c:	01 d0                	add    eax,edx
    176e:	c1 e0 03             	shl    eax,0x3
    1771:	01 f0                	add    eax,esi
    1773:	83 c0 20             	add    eax,0x20
    1776:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    1779:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    177c:	09 c1                	or     ecx,eax
    177e:	09 d3                	or     ebx,edx
    1780:	8b 75 08             	mov    esi,DWORD PTR [ebp+0x8]
    1783:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1786:	89 d0                	mov    eax,edx
    1788:	01 c0                	add    eax,eax
    178a:	01 d0                	add    eax,edx
    178c:	c1 e0 03             	shl    eax,0x3
    178f:	01 f0                	add    eax,esi
    1791:	83 c0 20             	add    eax,0x20
    1794:	89 48 08             	mov    DWORD PTR [eax+0x8],ecx
    1797:	89 58 0c             	mov    DWORD PTR [eax+0xc],ebx
    179a:	eb 6a                	jmp    1806 <pci_add_bars+0x258>
										d->ressources[i].mmio.base = dat & 0xfffffff0;
    179c:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    179f:	ba 00 00 00 00       	mov    edx,0x0
    17a4:	83 e0 f0             	and    eax,0xfffffff0
    17a7:	ba 00 00 00 00       	mov    edx,0x0
    17ac:	89 c1                	mov    ecx,eax
    17ae:	89 d3                	mov    ebx,edx
    17b0:	8b 75 08             	mov    esi,DWORD PTR [ebp+0x8]
    17b3:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    17b6:	89 d0                	mov    eax,edx
    17b8:	01 c0                	add    eax,eax
    17ba:	01 d0                	add    eax,edx
    17bc:	c1 e0 03             	shl    eax,0x3
    17bf:	01 f0                	add    eax,esi
    17c1:	83 c0 20             	add    eax,0x20
    17c4:	89 48 08             	mov    DWORD PTR [eax+0x8],ecx
    17c7:	89 58 0c             	mov    DWORD PTR [eax+0xc],ebx
										d->ressources[i].mmio.size = 0;
    17ca:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    17cd:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    17d0:	89 d0                	mov    eax,edx
    17d2:	01 c0                	add    eax,eax
    17d4:	01 d0                	add    eax,edx
    17d6:	c1 e0 03             	shl    eax,0x3
    17d9:	01 c8                	add    eax,ecx
    17db:	83 c0 20             	add    eax,0x20
    17de:	c7 40 10 00 00 00 00 	mov    DWORD PTR [eax+0x10],0x0
    17e5:	c7 40 14 00 00 00 00 	mov    DWORD PTR [eax+0x14],0x0
										d->ressources[i].mmio.mapping = NULL;
    17ec:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    17ef:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    17f2:	89 d0                	mov    eax,edx
    17f4:	01 c0                	add    eax,eax
    17f6:	01 d0                	add    eax,edx
    17f8:	c1 e0 03             	shl    eax,0x3
    17fb:	01 c8                	add    eax,ecx
    17fd:	83 c0 38             	add    eax,0x38
    1800:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
										d->ressources[i].mmio.size = pci_bar_get_size(d, i);
    1806:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1809:	50                   	push   eax
    180a:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    180d:	e8 fc ff ff ff       	call   180e <pci_add_bars+0x260>
    1812:	83 c4 08             	add    esp,0x8
    1815:	89 c1                	mov    ecx,eax
    1817:	89 d3                	mov    ebx,edx
    1819:	8b 75 08             	mov    esi,DWORD PTR [ebp+0x8]
    181c:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    181f:	89 d0                	mov    eax,edx
    1821:	01 c0                	add    eax,eax
    1823:	01 d0                	add    eax,edx
    1825:	c1 e0 03             	shl    eax,0x3
    1828:	01 f0                	add    eax,esi
    182a:	83 c0 20             	add    eax,0x20
    182d:	89 48 10             	mov    DWORD PTR [eax+0x10],ecx
    1830:	89 58 14             	mov    DWORD PTR [eax+0x14],ebx
						a.reg_no += 4;
    1833:	0f b6 45 d4          	movzx  eax,BYTE PTR [ebp-0x2c]
    1837:	83 c0 04             	add    eax,0x4
    183a:	88 45 d4             	mov    BYTE PTR [ebp-0x2c],al
				for (int i = 0; i < limit; i++) {
    183d:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    1841:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1844:	3b 45 e0             	cmp    eax,DWORD PTR [ebp-0x20]
    1847:	0f 8c b8 fd ff ff    	jl     1605 <pci_add_bars+0x57>
		if (t == 0 || t == 1) { /* the regular 6/2 BARs */
    184d:	e9 1a 01 00 00       	jmp    196c <pci_add_bars+0x3be>
		} else if (t == 2) { /* PCI-to-CardBus bridge */
    1852:	80 7d ef 02          	cmp    BYTE PTR [ebp-0x11],0x2
    1856:	0f 85 10 01 00 00    	jne    196c <pci_add_bars+0x3be>
				a.reg_no = 0x1c;
    185c:	c6 45 d4 1c          	mov    BYTE PTR [ebp-0x2c],0x1c
				for (int i = 0; i < 4; i++) {
    1860:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    1867:	e9 f4 00 00 00       	jmp    1960 <pci_add_bars+0x3b2>
						uint32_t base = pci_read(a), limit;
    186c:	83 ec 04             	sub    esp,0x4
    186f:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    1872:	e8 36 e8 ff ff       	call   ad <pci_read>
    1877:	83 c4 08             	add    esp,0x8
    187a:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
						a.reg_no += 4;
    187d:	0f b6 45 d4          	movzx  eax,BYTE PTR [ebp-0x2c]
    1881:	83 c0 04             	add    eax,0x4
    1884:	88 45 d4             	mov    BYTE PTR [ebp-0x2c],al
						limit = pci_read(a);
    1887:	83 ec 04             	sub    esp,0x4
    188a:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    188d:	e8 1b e8 ff ff       	call   ad <pci_read>
    1892:	83 c4 08             	add    esp,0x8
    1895:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
						if (i < 2) { /* memory */
    1898:	83 7d f0 01          	cmp    DWORD PTR [ebp-0x10],0x1
    189c:	7f 65                	jg     1903 <pci_add_bars+0x355>
								d->ressources[i].type = PCI_BAR_MMIO;
    189e:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    18a1:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    18a4:	89 d0                	mov    eax,edx
    18a6:	01 c0                	add    eax,eax
    18a8:	01 d0                	add    eax,edx
    18aa:	c1 e0 03             	shl    eax,0x3
    18ad:	01 c8                	add    eax,ecx
    18af:	83 c0 24             	add    eax,0x24
    18b2:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
								d->ressources[i].mmio.base = base;
    18b8:	8b 4d e8             	mov    ecx,DWORD PTR [ebp-0x18]
    18bb:	bb 00 00 00 00       	mov    ebx,0x0
    18c0:	8b 75 08             	mov    esi,DWORD PTR [ebp+0x8]
    18c3:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    18c6:	89 d0                	mov    eax,edx
    18c8:	01 c0                	add    eax,eax
    18ca:	01 d0                	add    eax,edx
    18cc:	c1 e0 03             	shl    eax,0x3
    18cf:	01 f0                	add    eax,esi
    18d1:	83 c0 20             	add    eax,0x20
    18d4:	89 48 08             	mov    DWORD PTR [eax+0x8],ecx
    18d7:	89 58 0c             	mov    DWORD PTR [eax+0xc],ebx
								d->ressources[i].mmio.size = limit - base;
    18da:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    18dd:	2b 45 e8             	sub    eax,DWORD PTR [ebp-0x18]
    18e0:	89 c1                	mov    ecx,eax
    18e2:	bb 00 00 00 00       	mov    ebx,0x0
    18e7:	8b 75 08             	mov    esi,DWORD PTR [ebp+0x8]
    18ea:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    18ed:	89 d0                	mov    eax,edx
    18ef:	01 c0                	add    eax,eax
    18f1:	01 d0                	add    eax,edx
    18f3:	c1 e0 03             	shl    eax,0x3
    18f6:	01 f0                	add    eax,esi
    18f8:	83 c0 20             	add    eax,0x20
    18fb:	89 48 10             	mov    DWORD PTR [eax+0x10],ecx
    18fe:	89 58 14             	mov    DWORD PTR [eax+0x14],ebx
    1901:	eb 59                	jmp    195c <pci_add_bars+0x3ae>
								d->ressources[i].type = PCI_BAR_PIO;
    1903:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    1906:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1909:	89 d0                	mov    eax,edx
    190b:	01 c0                	add    eax,eax
    190d:	01 d0                	add    eax,edx
    190f:	c1 e0 03             	shl    eax,0x3
    1912:	01 c8                	add    eax,ecx
    1914:	83 c0 24             	add    eax,0x24
    1917:	c7 00 01 00 00 00    	mov    DWORD PTR [eax],0x1
								d->ressources[i].pio.base = base;
    191d:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1920:	89 c3                	mov    ebx,eax
    1922:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    1925:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1928:	89 d0                	mov    eax,edx
    192a:	01 c0                	add    eax,eax
    192c:	01 d0                	add    eax,edx
    192e:	c1 e0 03             	shl    eax,0x3
    1931:	01 c8                	add    eax,ecx
    1933:	83 c0 28             	add    eax,0x28
    1936:	66 89 18             	mov    WORD PTR [eax],bx
								d->ressources[i].pio.count = limit - base;
    1939:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    193c:	89 c2                	mov    edx,eax
    193e:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1941:	89 d1                	mov    ecx,edx
    1943:	29 c1                	sub    ecx,eax
    1945:	8b 5d 08             	mov    ebx,DWORD PTR [ebp+0x8]
    1948:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    194b:	89 d0                	mov    eax,edx
    194d:	01 c0                	add    eax,eax
    194f:	01 d0                	add    eax,edx
    1951:	c1 e0 03             	shl    eax,0x3
    1954:	01 d8                	add    eax,ebx
    1956:	83 c0 2a             	add    eax,0x2a
    1959:	66 89 08             	mov    WORD PTR [eax],cx
				for (int i = 0; i < 4; i++) {
    195c:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
    1960:	83 7d f0 03          	cmp    DWORD PTR [ebp-0x10],0x3
    1964:	0f 8e 02 ff ff ff    	jle    186c <pci_add_bars+0x2be>
}
    196a:	eb 00                	jmp    196c <pci_add_bars+0x3be>
    196c:	90                   	nop
    196d:	8d 65 f8             	lea    esp,[ebp-0x8]
    1970:	5b                   	pop    ebx
    1971:	5e                   	pop    esi
    1972:	5d                   	pop    ebp
    1973:	c3                   	ret

00001974 <pci_enumerate_devices>:
{
    1974:	55                   	push   ebp
    1975:	89 e5                	mov    ebp,esp
    1977:	83 ec 28             	sub    esp,0x28
		union pca pca = {0};
    197a:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
		printf("Enumerating PCI devices:\n");
    1981:	83 ec 0c             	sub    esp,0xc
    1984:	68 29 12 00 00       	push   0x1229
    1989:	e8 fc ff ff ff       	call   198a <pci_enumerate_devices+0x16>
    198e:	83 c4 10             	add    esp,0x10
		for (bus = 0; bus < 256; bus++)
    1991:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    1998:	e9 57 03 00 00       	jmp    1cf4 <pci_enumerate_devices+0x380>
				for (dev = 0; dev < 32; dev++) {
    199d:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    19a4:	e9 3d 03 00 00       	jmp    1ce6 <pci_enumerate_devices+0x372>
						uint32_t dat, fno = 0;
    19a9:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
						pca.bus_no = bus;
    19b0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    19b3:	88 45 de             	mov    BYTE PTR [ebp-0x22],al
						pca.device_no = dev;
    19b6:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    19b9:	83 e0 1f             	and    eax,0x1f
    19bc:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    19c3:	0f b6 45 dd          	movzx  eax,BYTE PTR [ebp-0x23]
    19c7:	83 e0 07             	and    eax,0x7
    19ca:	09 d0                	or     eax,edx
    19cc:	88 45 dd             	mov    BYTE PTR [ebp-0x23],al
						pca.enabled = 1;
    19cf:	0f b6 45 df          	movzx  eax,BYTE PTR [ebp-0x21]
    19d3:	83 c8 80             	or     eax,0xffffff80
    19d6:	88 45 df             	mov    BYTE PTR [ebp-0x21],al
    19d9:	eb 01                	jmp    19dc <pci_enumerate_devices+0x68>
								goto multifun; /* non-consecuitive layouts */
    19db:	90                   	nop
						pca.func_no = fno++;
    19dc:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    19df:	8d 50 01             	lea    edx,[eax+0x1]
    19e2:	89 55 e8             	mov    DWORD PTR [ebp-0x18],edx
    19e5:	83 e0 07             	and    eax,0x7
    19e8:	83 e0 07             	and    eax,0x7
    19eb:	89 c2                	mov    edx,eax
    19ed:	0f b6 45 dd          	movzx  eax,BYTE PTR [ebp-0x23]
    19f1:	83 e0 f8             	and    eax,0xfffffff8
    19f4:	09 d0                	or     eax,edx
    19f6:	88 45 dd             	mov    BYTE PTR [ebp-0x23],al
						pca.reg_no = 0;
    19f9:	c6 45 dc 00          	mov    BYTE PTR [ebp-0x24],0x0
						pca.reserved =/* pca.zero =*/ 0;
    19fd:	0f b6 45 df          	movzx  eax,BYTE PTR [ebp-0x21]
    1a01:	83 e0 80             	and    eax,0xffffff80
    1a04:	88 45 df             	mov    BYTE PTR [ebp-0x21],al
						dat = pci_read(pca);
    1a07:	83 ec 0c             	sub    esp,0xc
    1a0a:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
    1a0d:	e8 9b e6 ff ff       	call   ad <pci_read>
    1a12:	83 c4 10             	add    esp,0x10
    1a15:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
						if ((dat & 0xffff) != 0xffff) {
    1a18:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1a1b:	0f b7 c0             	movzx  eax,ax
    1a1e:	3d ff ff 00 00       	cmp    eax,0xffff
    1a23:	0f 84 a9 02 00 00    	je     1cd2 <pci_enumerate_devices+0x35e>
								int mf = 0; struct dle* le;
    1a29:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
								le = kzalloc(sizeof(*le));
    1a30:	83 ec 0c             	sub    esp,0xc
    1a33:	68 c0 00 00 00       	push   0xc0
    1a38:	e8 fc ff ff ff       	call   1a39 <pci_enumerate_devices+0xc5>
    1a3d:	83 c4 10             	add    esp,0x10
    1a40:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
								le->dev.addr = pca;
    1a43:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1a46:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1a49:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
								le->dev.identification = dat >> 16;
    1a4c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1a4f:	c1 e8 10             	shr    eax,0x10
    1a52:	89 c2                	mov    edx,eax
    1a54:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1a57:	66 89 50 18          	mov    WORD PTR [eax+0x18],dx
								le->dev.vendor = (dat & 0xffff);
    1a5b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1a5e:	89 c2                	mov    edx,eax
    1a60:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1a63:	66 89 50 16          	mov    WORD PTR [eax+0x16],dx
										pca.bus_no, pca.device_no, pca.func_no);
    1a67:	0f b6 45 dd          	movzx  eax,BYTE PTR [ebp-0x23]
    1a6b:	83 e0 07             	and    eax,0x7
								printf("devie at %02x:%02x.%x\n",
    1a6e:	0f b6 c8             	movzx  ecx,al
										pca.bus_no, pca.device_no, pca.func_no);
    1a71:	0f b6 45 dd          	movzx  eax,BYTE PTR [ebp-0x23]
    1a75:	c0 e8 03             	shr    al,0x3
								printf("devie at %02x:%02x.%x\n",
    1a78:	0f b6 d0             	movzx  edx,al
										pca.bus_no, pca.device_no, pca.func_no);
    1a7b:	0f b6 45 de          	movzx  eax,BYTE PTR [ebp-0x22]
								printf("devie at %02x:%02x.%x\n",
    1a7f:	0f b6 c0             	movzx  eax,al
    1a82:	51                   	push   ecx
    1a83:	52                   	push   edx
    1a84:	50                   	push   eax
    1a85:	68 43 12 00 00       	push   0x1243
    1a8a:	e8 fc ff ff ff       	call   1a8b <pci_enumerate_devices+0x117>
    1a8f:	83 c4 10             	add    esp,0x10
								printf("\tid:       %04x\n", (dat >> 16));
    1a92:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1a95:	c1 e8 10             	shr    eax,0x10
    1a98:	83 ec 08             	sub    esp,0x8
    1a9b:	50                   	push   eax
    1a9c:	68 5a 12 00 00       	push   0x125a
    1aa1:	e8 fc ff ff ff       	call   1aa2 <pci_enumerate_devices+0x12e>
    1aa6:	83 c4 10             	add    esp,0x10
								printf("\tvendor:   %04x\n", (dat & 0xffff));
    1aa9:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1aac:	0f b7 c0             	movzx  eax,ax
    1aaf:	83 ec 08             	sub    esp,0x8
    1ab2:	50                   	push   eax
    1ab3:	68 6b 12 00 00       	push   0x126b
    1ab8:	e8 fc ff ff ff       	call   1ab9 <pci_enumerate_devices+0x145>
    1abd:	83 c4 10             	add    esp,0x10
								pca.reg_no = 8;
    1ac0:	c6 45 dc 08          	mov    BYTE PTR [ebp-0x24],0x8
								dat = pci_read(pca);
    1ac4:	83 ec 0c             	sub    esp,0xc
    1ac7:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
    1aca:	e8 de e5 ff ff       	call   ad <pci_read>
    1acf:	83 c4 10             	add    esp,0x10
    1ad2:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
								le->dev.device_class = dat >> 24;
    1ad5:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1ad8:	c1 e8 18             	shr    eax,0x18
    1adb:	89 c2                	mov    edx,eax
    1add:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1ae0:	88 50 10             	mov    BYTE PTR [eax+0x10],dl
								le->dev.device_subclass = (dat >> 16) & 0xff;
    1ae3:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1ae6:	c1 e8 10             	shr    eax,0x10
    1ae9:	89 c2                	mov    edx,eax
    1aeb:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1aee:	88 50 11             	mov    BYTE PTR [eax+0x11],dl
								le->dev.device_interface = (dat >> 8) & 0xff;
    1af1:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1af4:	c1 e8 08             	shr    eax,0x8
    1af7:	89 c2                	mov    edx,eax
    1af9:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1afc:	88 50 12             	mov    BYTE PTR [eax+0x12],dl
									pci_get_class_string(dat >> 24));
    1aff:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1b02:	c1 e8 18             	shr    eax,0x18
								printf("\tclass:    %s\n",
    1b05:	0f b6 c0             	movzx  eax,al
    1b08:	83 ec 0c             	sub    esp,0xc
    1b0b:	50                   	push   eax
    1b0c:	e8 fc ff ff ff       	call   1b0d <pci_enumerate_devices+0x199>
    1b11:	83 c4 10             	add    esp,0x10
    1b14:	83 ec 08             	sub    esp,0x8
    1b17:	50                   	push   eax
    1b18:	68 7c 12 00 00       	push   0x127c
    1b1d:	e8 fc ff ff ff       	call   1b1e <pci_enumerate_devices+0x1aa>
    1b22:	83 c4 10             	add    esp,0x10
									(dat >> 16) & 0xff, (dat >> 8) & 0xff));
    1b25:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1b28:	c1 e8 08             	shr    eax,0x8
								printf("\tsubclass: %s\n",
    1b2b:	0f b6 c8             	movzx  ecx,al
									(dat >> 16) & 0xff, (dat >> 8) & 0xff));
    1b2e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1b31:	c1 e8 10             	shr    eax,0x10
								printf("\tsubclass: %s\n",
    1b34:	0f b6 d0             	movzx  edx,al
									pci_get_subclass_string(dat >> 24,
    1b37:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1b3a:	c1 e8 18             	shr    eax,0x18
								printf("\tsubclass: %s\n",
    1b3d:	0f b6 c0             	movzx  eax,al
    1b40:	83 ec 04             	sub    esp,0x4
    1b43:	51                   	push   ecx
    1b44:	52                   	push   edx
    1b45:	50                   	push   eax
    1b46:	e8 fc ff ff ff       	call   1b47 <pci_enumerate_devices+0x1d3>
    1b4b:	83 c4 10             	add    esp,0x10
    1b4e:	83 ec 08             	sub    esp,0x8
    1b51:	50                   	push   eax
    1b52:	68 8b 12 00 00       	push   0x128b
    1b57:	e8 fc ff ff ff       	call   1b58 <pci_enumerate_devices+0x1e4>
    1b5c:	83 c4 10             	add    esp,0x10
								pca.reg_no = 12;
    1b5f:	c6 45 dc 0c          	mov    BYTE PTR [ebp-0x24],0xc
								dat = pci_read(pca);
    1b63:	83 ec 0c             	sub    esp,0xc
    1b66:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
    1b69:	e8 3f e5 ff ff       	call   ad <pci_read>
    1b6e:	83 c4 10             	add    esp,0x10
    1b71:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
								dat = (dat >> 16) & 0xff;
    1b74:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1b77:	c1 e8 10             	shr    eax,0x10
    1b7a:	25 ff 00 00 00       	and    eax,0xff
    1b7f:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
								le->dev.device_type = dat;
    1b82:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1b85:	89 c2                	mov    edx,eax
    1b87:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1b8a:	88 50 13             	mov    BYTE PTR [eax+0x13],dl
								mf = dat & 0x80;
    1b8d:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1b90:	25 80 00 00 00       	and    eax,0x80
    1b95:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
									(dat & 0x80) ? "multi" : "single");
    1b98:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1b9b:	25 80 00 00 00       	and    eax,0x80
								printf("\tfunction: %s\n",
    1ba0:	85 c0                	test   eax,eax
    1ba2:	74 07                	je     1bab <pci_enumerate_devices+0x237>
    1ba4:	b8 9a 12 00 00       	mov    eax,0x129a
    1ba9:	eb 05                	jmp    1bb0 <pci_enumerate_devices+0x23c>
    1bab:	b8 a0 12 00 00       	mov    eax,0x12a0
    1bb0:	83 ec 08             	sub    esp,0x8
    1bb3:	50                   	push   eax
    1bb4:	68 a7 12 00 00       	push   0x12a7
    1bb9:	e8 fc ff ff ff       	call   1bba <pci_enumerate_devices+0x246>
    1bbe:	83 c4 10             	add    esp,0x10
									((dat & 0x7f) == 0) ? "general" : (((dat & 0x7f) == 1)
    1bc1:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1bc4:	83 e0 7f             	and    eax,0x7f
								printf("\ttype:     %s\n",
    1bc7:	85 c0                	test   eax,eax
    1bc9:	74 19                	je     1be4 <pci_enumerate_devices+0x270>
									((dat & 0x7f) == 0) ? "general" : (((dat & 0x7f) == 1)
    1bcb:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1bce:	83 e0 7f             	and    eax,0x7f
									? ("PCI-to-PCI bridge") : ("CardBus bridge")));
    1bd1:	83 f8 01             	cmp    eax,0x1
    1bd4:	75 07                	jne    1bdd <pci_enumerate_devices+0x269>
    1bd6:	b8 e5 05 00 00       	mov    eax,0x5e5
    1bdb:	eb 0c                	jmp    1be9 <pci_enumerate_devices+0x275>
    1bdd:	b8 55 06 00 00       	mov    eax,0x655
    1be2:	eb 05                	jmp    1be9 <pci_enumerate_devices+0x275>
								printf("\ttype:     %s\n",
    1be4:	b8 b6 12 00 00       	mov    eax,0x12b6
    1be9:	83 ec 08             	sub    esp,0x8
    1bec:	50                   	push   eax
    1bed:	68 be 12 00 00       	push   0x12be
    1bf2:	e8 fc ff ff ff       	call   1bf3 <pci_enumerate_devices+0x27f>
    1bf7:	83 c4 10             	add    esp,0x10
								pca.reg_no = PCI_INTERRUPT_LINE;
    1bfa:	c6 45 dc 3c          	mov    BYTE PTR [ebp-0x24],0x3c
								dat = pci_read(pca);
    1bfe:	83 ec 0c             	sub    esp,0xc
    1c01:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
    1c04:	e8 a4 e4 ff ff       	call   ad <pci_read>
    1c09:	83 c4 10             	add    esp,0x10
    1c0c:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
								le->dev.intr_pin = (dat >> 8) & 0xff;
    1c0f:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1c12:	c1 e8 08             	shr    eax,0x8
    1c15:	89 c2                	mov    edx,eax
    1c17:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1c1a:	88 50 14             	mov    BYTE PTR [eax+0x14],dl
								le->dev.intr_line = dat & 0xff;
    1c1d:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1c20:	89 c2                	mov    edx,eax
    1c22:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1c25:	88 50 15             	mov    BYTE PTR [eax+0x15],dl
								if (!le->dev.intr_pin || le->dev.intr_pin > 4)
    1c28:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1c2b:	0f b6 40 14          	movzx  eax,BYTE PTR [eax+0x14]
    1c2f:	84 c0                	test   al,al
    1c31:	74 0b                	je     1c3e <pci_enumerate_devices+0x2ca>
    1c33:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1c36:	0f b6 40 14          	movzx  eax,BYTE PTR [eax+0x14]
    1c3a:	3c 04                	cmp    al,0x4
    1c3c:	76 09                	jbe    1c47 <pci_enumerate_devices+0x2d3>
										dat = ' ';
    1c3e:	c7 45 ec 20 00 00 00 	mov    DWORD PTR [ebp-0x14],0x20
    1c45:	eb 10                	jmp    1c57 <pci_enumerate_devices+0x2e3>
										dat = 'A' + (le->dev.intr_pin - 1);
    1c47:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1c4a:	0f b6 40 14          	movzx  eax,BYTE PTR [eax+0x14]
    1c4e:	0f b6 c0             	movzx  eax,al
    1c51:	83 c0 40             	add    eax,0x40
    1c54:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
								printf("\tinterrupt: INT%c#  line: %u\n", (char)dat, le->dev.intr_line);
    1c57:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1c5a:	0f b6 40 15          	movzx  eax,BYTE PTR [eax+0x15]
    1c5e:	0f b6 d0             	movzx  edx,al
    1c61:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1c64:	0f be c0             	movsx  eax,al
    1c67:	83 ec 04             	sub    esp,0x4
    1c6a:	52                   	push   edx
    1c6b:	50                   	push   eax
    1c6c:	68 cd 12 00 00       	push   0x12cd
    1c71:	e8 fc ff ff ff       	call   1c72 <pci_enumerate_devices+0x2fe>
    1c76:	83 c4 10             	add    esp,0x10
								printf("\n");
    1c79:	83 ec 0c             	sub    esp,0xc
    1c7c:	68 eb 12 00 00       	push   0x12eb
    1c81:	e8 fc ff ff ff       	call   1c82 <pci_enumerate_devices+0x30e>
    1c86:	83 c4 10             	add    esp,0x10
								pci_add_bars(&le->dev);
    1c89:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1c8c:	83 c0 0c             	add    eax,0xc
    1c8f:	83 ec 0c             	sub    esp,0xc
    1c92:	50                   	push   eax
    1c93:	e8 fc ff ff ff       	call   1c94 <pci_enumerate_devices+0x320>
    1c98:	83 c4 10             	add    esp,0x10
								pci_add_caps(&le->dev);
    1c9b:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1c9e:	83 c0 0c             	add    eax,0xc
    1ca1:	83 ec 0c             	sub    esp,0xc
    1ca4:	50                   	push   eax
    1ca5:	e8 fc ff ff ff       	call   1ca6 <pci_enumerate_devices+0x332>
    1caa:	83 c4 10             	add    esp,0x10
								list_add_tail(&le->devices, &device_list.devices);
    1cad:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1cb0:	83 ec 08             	sub    esp,0x8
    1cb3:	68 00 00 00 00       	push   0x0
    1cb8:	50                   	push   eax
    1cb9:	e8 ab e3 ff ff       	call   69 <list_add_tail>
    1cbe:	83 c4 10             	add    esp,0x10
								if (mf && fno < 8)
    1cc1:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    1cc5:	74 1b                	je     1ce2 <pci_enumerate_devices+0x36e>
    1cc7:	83 7d e8 07          	cmp    DWORD PTR [ebp-0x18],0x7
    1ccb:	77 15                	ja     1ce2 <pci_enumerate_devices+0x36e>
										goto multifun;
    1ccd:	e9 0a fd ff ff       	jmp    19dc <pci_enumerate_devices+0x68>
						} else if (fno && fno < 8)
    1cd2:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    1cd6:	74 0a                	je     1ce2 <pci_enumerate_devices+0x36e>
    1cd8:	83 7d e8 07          	cmp    DWORD PTR [ebp-0x18],0x7
    1cdc:	0f 86 f9 fc ff ff    	jbe    19db <pci_enumerate_devices+0x67>
				for (dev = 0; dev < 32; dev++) {
    1ce2:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
    1ce6:	83 7d f0 1f          	cmp    DWORD PTR [ebp-0x10],0x1f
    1cea:	0f 86 b9 fc ff ff    	jbe    19a9 <pci_enumerate_devices+0x35>
		for (bus = 0; bus < 256; bus++)
    1cf0:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    1cf4:	81 7d f4 ff 00 00 00 	cmp    DWORD PTR [ebp-0xc],0xff
    1cfb:	0f 86 9c fc ff ff    	jbe    199d <pci_enumerate_devices+0x29>
}
    1d01:	90                   	nop
    1d02:	90                   	nop
    1d03:	c9                   	leave
    1d04:	c3                   	ret

00001d05 <module_init>:
{
    1d05:	55                   	push   ebp
    1d06:	89 e5                	mov    ebp,esp
    1d08:	83 ec 08             	sub    esp,0x8
		pci_enumerate_devices();
    1d0b:	e8 fc ff ff ff       	call   1d0c <module_init+0x7>
		return 0;
    1d10:	b8 00 00 00 00       	mov    eax,0x0
}
    1d15:	c9                   	leave
    1d16:	c3                   	ret

00001d17 <module_cleanup>:

void MODENTRY module_cleanup()
{
    1d17:	55                   	push   ebp
    1d18:	89 e5                	mov    ebp,esp
    1d1a:	83 ec 08             	sub    esp,0x8
		printf("goodbye pci.ko\n");
    1d1d:	83 ec 0c             	sub    esp,0xc
    1d20:	68 ed 12 00 00       	push   0x12ed
    1d25:	e8 fc ff ff ff       	call   1d26 <module_cleanup+0xf>
    1d2a:	83 c4 10             	add    esp,0x10
}
    1d2d:	90                   	nop
    1d2e:	c9                   	leave
    1d2f:	c3                   	ret
