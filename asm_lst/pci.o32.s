
pci.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <io_wait>:
						else
								return "other system timer";
				else if (scls == 3)
						if (progIf == 0)
								return "generic RTC controller";
						else if (progIf == 1)
       0:	55                   	push   ebp
       1:	89 e5                	mov    ebp,esp
								return "ISA RTC controller";
       3:	b8 00 00 00 00       	mov    eax,0x0
       8:	e6 80                	out    0x80,al
						else
       a:	90                   	nop
       b:	5d                   	pop    ebp
       c:	c3                   	ret

0000000d <outl>:
						else
								return "other Gameport controller";
				else if (scls == 0x80)
						return "other input controller";
				else
						return "unrecognized input controller";
       d:	55                   	push   ebp
       e:	89 e5                	mov    ebp,esp
      10:	83 ec 04             	sub    esp,0x4
      13:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      16:	66 89 45 fc          	mov    WORD PTR [ebp-0x4],ax
		else if (cls == 10)
      1a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      1d:	0f b7 55 fc          	movzx  edx,WORD PTR [ebp-0x4]
      21:	ef                   	out    dx,eax
				if (scls == 0)
      22:	90                   	nop
      23:	c9                   	leave
      24:	c3                   	ret

00000025 <inl>:
						return "generic docking station";
				else if (scls == 0x80)
						return "other docking station";
      25:	55                   	push   ebp
      26:	89 e5                	mov    ebp,esp
      28:	83 ec 14             	sub    esp,0x14
      2b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      2e:	66 89 45 ec          	mov    WORD PTR [ebp-0x14],ax
				else
						return "unrecognized docking station";
      32:	0f b7 45 ec          	movzx  eax,WORD PTR [ebp-0x14]
      36:	89 c2                	mov    edx,eax
      38:	ed                   	in     eax,dx
      39:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		else if (cls == 11)
      3c:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
				if (scls == 0)
      3f:	c9                   	leave
      40:	c3                   	ret

00000041 <__list_add>:
								le->dev.device_type = dat;
								mf = dat & 0x80;
								printf("\tfunction: %s\n",
									(dat & 0x80) ? "multi" : "single");
								printf("\ttype:     %s\n",
									((dat & 0x7f) == 0) ? "general" : (((dat & 0x7f) == 1)
      41:	55                   	push   ebp
      42:	89 e5                	mov    ebp,esp
									? ("PCI-to-PCI bridge") : ("CardBus bridge")));
      44:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
      47:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
      4a:	89 10                	mov    DWORD PTR [eax],edx
								pca.reg_no = PCI_INTERRUPT_LINE;
      4c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      4f:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
      52:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
								dat = pci_read(pca);
      55:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      58:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
      5b:	89 10                	mov    DWORD PTR [eax],edx
								le->dev.intr_pin = (dat >> 8) & 0xff;
      5d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      60:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
      63:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
								le->dev.intr_line = dat & 0xff;
      66:	90                   	nop
      67:	5d                   	pop    ebp
      68:	c3                   	ret

00000069 <list_add_tail>:
								goto multifun; /* non-consecuitive layouts */
				}
}

int MODENTRY module_init()
{
      69:	55                   	push   ebp
      6a:	89 e5                	mov    ebp,esp
      6c:	83 ec 18             	sub    esp,0x18
		pci_enumerate_devices();
      6f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      72:	83 c0 08             	add    eax,0x8
      75:	89 04 24             	mov    DWORD PTR [esp],eax
      78:	e8 fc ff ff ff       	call   79 <list_add_tail+0x10>
		return 0;
      7d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      80:	8b 00                	mov    eax,DWORD PTR [eax]
      82:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
      85:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
      89:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
      8d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      90:	89 04 24             	mov    DWORD PTR [esp],eax
      93:	e8 a9 ff ff ff       	call   41 <__list_add>
}
      98:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
      9b:	83 c0 08             	add    eax,0x8
      9e:	89 04 24             	mov    DWORD PTR [esp],eax
      a1:	e8 fc ff ff ff       	call   a2 <list_add_tail+0x39>

      a6:	90                   	nop
      a7:	c9                   	leave
      a8:	c3                   	ret

000000a9 <pci_read>:
#define PCI_BAR_64_BIT (1 << 2)
#define PCI_BAR_16_BIT (1 << 1)
#define PCI_BAR_PREFETCHABLE (1 << 3) /* MMIO+PREF */

static inline uint32_t pci_read(union pca a)
{
      a9:	55                   	push   ebp
      aa:	89 e5                	mov    ebp,esp
      ac:	83 ec 08             	sub    esp,0x8
		outl(PCI_CONFIG_ADDRESS, a.val);
      af:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      b2:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
      b6:	c7 04 24 f8 0c 00 00 	mov    DWORD PTR [esp],0xcf8
      bd:	e8 4b ff ff ff       	call   d <outl>
		io_wait();
      c2:	e8 39 ff ff ff       	call   0 <io_wait>
		return inl(PCI_CONFIG_DATA);
      c7:	c7 04 24 fc 0c 00 00 	mov    DWORD PTR [esp],0xcfc
      ce:	e8 52 ff ff ff       	call   25 <inl>
}
      d3:	c9                   	leave
      d4:	c3                   	ret

000000d5 <pci_read_word>:

/* PCI is little endian (status==06h --> high bits) */
static inline uint16_t pci_read_word(union pca a)
{
      d5:	55                   	push   ebp
      d6:	89 e5                	mov    ebp,esp
      d8:	83 ec 14             	sub    esp,0x14
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
     103:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     106:	89 04 24             	mov    DWORD PTR [esp],eax
     109:	e8 9b ff ff ff       	call   a9 <pci_read>
     10e:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (of == 3) { /* very unaligned access */
     111:	66 83 7d fa 03       	cmp    WORD PTR [ebp-0x6],0x3
     116:	75 26                	jne    13e <pci_read_word+0x69>
				a2.reg_no += 4;
     118:	0f b6 45 f0          	movzx  eax,BYTE PTR [ebp-0x10]
     11c:	83 c0 04             	add    eax,0x4
     11f:	88 45 f0             	mov    BYTE PTR [ebp-0x10],al
				v2 = pci_read(a2);
     122:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     125:	89 04 24             	mov    DWORD PTR [esp],eax
     128:	e8 7c ff ff ff       	call   a9 <pci_read>
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
     165:	83 ec 14             	sub    esp,0x14
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
     182:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     185:	89 04 24             	mov    DWORD PTR [esp],eax
     188:	e8 1c ff ff ff       	call   a9 <pci_read>
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
     19d:	83 ec 08             	sub    esp,0x8
		outl(PCI_CONFIG_ADDRESS, a.val);
     1a0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1a3:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     1a7:	c7 04 24 f8 0c 00 00 	mov    DWORD PTR [esp],0xcf8
     1ae:	e8 5a fe ff ff       	call   d <outl>
		io_wait();
     1b3:	e8 48 fe ff ff       	call   0 <io_wait>
		outl(PCI_CONFIG_DATA, v);
     1b8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     1bb:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     1bf:	c7 04 24 fc 0c 00 00 	mov    DWORD PTR [esp],0xcfc
     1c6:	e8 42 fe ff ff       	call   d <outl>
}
     1cb:	90                   	nop
     1cc:	c9                   	leave
     1cd:	c3                   	ret

000001ce <pci_get_class_string>:
{
     1ce:	55                   	push   ebp
     1cf:	89 e5                	mov    ebp,esp
     1d1:	83 ec 04             	sub    esp,0x4
     1d4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1d7:	88 45 fc             	mov    BYTE PTR [ebp-0x4],al
		switch (cls) {
     1da:	0f b6 45 fc          	movzx  eax,BYTE PTR [ebp-0x4]
     1de:	83 f8 11             	cmp    eax,0x11
     1e1:	7f 1a                	jg     1fd <pci_get_class_string+0x2f>
     1e3:	85 c0                	test   eax,eax
     1e5:	0f 88 aa 00 00 00    	js     295 <pci_get_class_string+0xc7>
     1eb:	83 f8 11             	cmp    eax,0x11
     1ee:	0f 87 a1 00 00 00    	ja     295 <pci_get_class_string+0xc7>
     1f4:	8b 04 85 c8 01 00 00 	mov    eax,DWORD PTR [eax*4+0x1c8]
     1fb:	ff e0                	jmp    eax
     1fd:	3d ff 00 00 00       	cmp    eax,0xff
     202:	0f 84 86 00 00 00    	je     28e <pci_get_class_string+0xc0>
     208:	e9 88 00 00 00       	jmp    295 <pci_get_class_string+0xc7>
				return "(old device)";
     20d:	b8 00 00 00 00       	mov    eax,0x0
     212:	e9 83 00 00 00       	jmp    29a <pci_get_class_string+0xcc>
				return "mass storage controller";
     217:	b8 0d 00 00 00       	mov    eax,0xd
     21c:	eb 7c                	jmp    29a <pci_get_class_string+0xcc>
				return "network controller";
     21e:	b8 25 00 00 00       	mov    eax,0x25
     223:	eb 75                	jmp    29a <pci_get_class_string+0xcc>
				return "display controller";
     225:	b8 38 00 00 00       	mov    eax,0x38
     22a:	eb 6e                	jmp    29a <pci_get_class_string+0xcc>
				return "multimedia controller";
     22c:	b8 4b 00 00 00       	mov    eax,0x4b
     231:	eb 67                	jmp    29a <pci_get_class_string+0xcc>
				return "memory controller";
     233:	b8 61 00 00 00       	mov    eax,0x61
     238:	eb 60                	jmp    29a <pci_get_class_string+0xcc>
				return "bridge device";
     23a:	b8 73 00 00 00       	mov    eax,0x73
     23f:	eb 59                	jmp    29a <pci_get_class_string+0xcc>
				return "simple communication controllers";
     241:	b8 84 00 00 00       	mov    eax,0x84
     246:	eb 52                	jmp    29a <pci_get_class_string+0xcc>
				return "base system peripherials";
     248:	b8 a5 00 00 00       	mov    eax,0xa5
     24d:	eb 4b                	jmp    29a <pci_get_class_string+0xcc>
				return "input devices";
     24f:	b8 be 00 00 00       	mov    eax,0xbe
     254:	eb 44                	jmp    29a <pci_get_class_string+0xcc>
				return "docking stations";
     256:	b8 cc 00 00 00       	mov    eax,0xcc
     25b:	eb 3d                	jmp    29a <pci_get_class_string+0xcc>
				return "processors";
     25d:	b8 dd 00 00 00       	mov    eax,0xdd
     262:	eb 36                	jmp    29a <pci_get_class_string+0xcc>
				return "serial bus controllers";
     264:	b8 e8 00 00 00       	mov    eax,0xe8
     269:	eb 2f                	jmp    29a <pci_get_class_string+0xcc>
				return "wireless controllers";
     26b:	b8 ff 00 00 00       	mov    eax,0xff
     270:	eb 28                	jmp    29a <pci_get_class_string+0xcc>
				return "intelligent I/O controllers";
     272:	b8 14 01 00 00       	mov    eax,0x114
     277:	eb 21                	jmp    29a <pci_get_class_string+0xcc>
				return "satellite communication controllers";
     279:	b8 30 01 00 00       	mov    eax,0x130
     27e:	eb 1a                	jmp    29a <pci_get_class_string+0xcc>
				return "encryption/decryption controllers";
     280:	b8 54 01 00 00       	mov    eax,0x154
     285:	eb 13                	jmp    29a <pci_get_class_string+0xcc>
				return "data acquisiton and signal processing controllers";
     287:	b8 78 01 00 00       	mov    eax,0x178
     28c:	eb 0c                	jmp    29a <pci_get_class_string+0xcc>
				return "no fitting class";
     28e:	b8 aa 01 00 00       	mov    eax,0x1aa
     293:	eb 05                	jmp    29a <pci_get_class_string+0xcc>
				return "(reserved)";
     295:	b8 bb 01 00 00       	mov    eax,0x1bb
}
     29a:	c9                   	leave
     29b:	c3                   	ret

0000029c <pci_get_subclass_string>:
{
     29c:	55                   	push   ebp
     29d:	89 e5                	mov    ebp,esp
     29f:	83 ec 0c             	sub    esp,0xc
     2a2:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
     2a5:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     2a8:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     2ab:	88 4d fc             	mov    BYTE PTR [ebp-0x4],cl
     2ae:	88 55 f8             	mov    BYTE PTR [ebp-0x8],dl
     2b1:	88 45 f4             	mov    BYTE PTR [ebp-0xc],al
		if (cls == 0)
     2b4:	80 7d fc 00          	cmp    BYTE PTR [ebp-0x4],0x0
     2b8:	75 2a                	jne    2e4 <pci_get_subclass_string+0x48>
				if (scls == 0)
     2ba:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     2be:	75 0a                	jne    2ca <pci_get_subclass_string+0x2e>
						return "any device (not VGA compatible)";
     2c0:	b8 10 02 00 00       	mov    eax,0x210
     2c5:	e9 91 0a 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 1)
     2ca:	80 7d f8 01          	cmp    BYTE PTR [ebp-0x8],0x1
     2ce:	75 0a                	jne    2da <pci_get_subclass_string+0x3e>
						return "VGA compatible";
     2d0:	b8 30 02 00 00       	mov    eax,0x230
     2d5:	e9 81 0a 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						return "(invalid)";
     2da:	b8 3f 02 00 00       	mov    eax,0x23f
     2df:	e9 77 0a 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
		else if (cls == 1)
     2e4:	80 7d fc 01          	cmp    BYTE PTR [ebp-0x4],0x1
     2e8:	0f 85 ca 00 00 00    	jne    3b8 <pci_get_subclass_string+0x11c>
				if (scls == 0)
     2ee:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     2f2:	75 0a                	jne    2fe <pci_get_subclass_string+0x62>
						return "SCSI bus controller";
     2f4:	b8 49 02 00 00       	mov    eax,0x249
     2f9:	e9 5d 0a 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 1)
     2fe:	80 7d f8 01          	cmp    BYTE PTR [ebp-0x8],0x1
     302:	75 0a                	jne    30e <pci_get_subclass_string+0x72>
						return "IDE controller";
     304:	b8 5d 02 00 00       	mov    eax,0x25d
     309:	e9 4d 0a 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 3)
     30e:	80 7d f8 03          	cmp    BYTE PTR [ebp-0x8],0x3
     312:	75 0a                	jne    31e <pci_get_subclass_string+0x82>
						return "IPI bus controller";
     314:	b8 6c 02 00 00       	mov    eax,0x26c
     319:	e9 3d 0a 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 4)
     31e:	80 7d f8 04          	cmp    BYTE PTR [ebp-0x8],0x4
     322:	75 0a                	jne    32e <pci_get_subclass_string+0x92>
						return "RAID controller";
     324:	b8 7f 02 00 00       	mov    eax,0x27f
     329:	e9 2d 0a 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 5)
     32e:	80 7d f8 05          	cmp    BYTE PTR [ebp-0x8],0x5
     332:	75 2a                	jne    35e <pci_get_subclass_string+0xc2>
						if (progIf == 0x20)
     334:	80 7d f4 20          	cmp    BYTE PTR [ebp-0xc],0x20
     338:	75 0a                	jne    344 <pci_get_subclass_string+0xa8>
								return "ATA controller (single DMA)";
     33a:	b8 8f 02 00 00       	mov    eax,0x28f
     33f:	e9 17 0a 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 0x30)
     344:	80 7d f4 30          	cmp    BYTE PTR [ebp-0xc],0x30
     348:	75 0a                	jne    354 <pci_get_subclass_string+0xb8>
								return "ATA controller (chained DMA)";
     34a:	b8 ab 02 00 00       	mov    eax,0x2ab
     34f:	e9 07 0a 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
								return "ATA controller (unknown interface)";
     354:	b8 c8 02 00 00       	mov    eax,0x2c8
     359:	e9 fd 09 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 6)
     35e:	80 7d f8 06          	cmp    BYTE PTR [ebp-0x8],0x6
     362:	75 2a                	jne    38e <pci_get_subclass_string+0xf2>
						if (progIf == 0)
     364:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
     368:	75 0a                	jne    374 <pci_get_subclass_string+0xd8>
								return "SATA (vendor interface)";
     36a:	b8 eb 02 00 00       	mov    eax,0x2eb
     36f:	e9 e7 09 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 1)
     374:	80 7d f4 01          	cmp    BYTE PTR [ebp-0xc],0x1
     378:	75 0a                	jne    384 <pci_get_subclass_string+0xe8>
								return "SATA (AHCI 1.0)";
     37a:	b8 03 03 00 00       	mov    eax,0x303
     37f:	e9 d7 09 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
								return "SATA (unknown interface)";
     384:	b8 13 03 00 00       	mov    eax,0x313
     389:	e9 cd 09 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 7)
     38e:	80 7d f8 07          	cmp    BYTE PTR [ebp-0x8],0x7
     392:	75 0a                	jne    39e <pci_get_subclass_string+0x102>
						return "Serial Attached SCSI (SAS)";
     394:	b8 2c 03 00 00       	mov    eax,0x32c
     399:	e9 bd 09 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 0x80)
     39e:	80 7d f8 80          	cmp    BYTE PTR [ebp-0x8],0x80
     3a2:	75 0a                	jne    3ae <pci_get_subclass_string+0x112>
						return "other mass storage controller";
     3a4:	b8 47 03 00 00       	mov    eax,0x347
     3a9:	e9 ad 09 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						return "unrecognized mass storage controller";
     3ae:	b8 68 03 00 00       	mov    eax,0x368
     3b3:	e9 a3 09 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
		else if (cls == 2)
     3b8:	80 7d fc 02          	cmp    BYTE PTR [ebp-0x4],0x2
     3bc:	0f 85 8a 00 00 00    	jne    44c <pci_get_subclass_string+0x1b0>
				if (scls == 0)
     3c2:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     3c6:	75 0a                	jne    3d2 <pci_get_subclass_string+0x136>
						return "Ethernet controller";
     3c8:	b8 8d 03 00 00       	mov    eax,0x38d
     3cd:	e9 89 09 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 1)
     3d2:	80 7d f8 01          	cmp    BYTE PTR [ebp-0x8],0x1
     3d6:	75 0a                	jne    3e2 <pci_get_subclass_string+0x146>
						return "Token ring controller";
     3d8:	b8 a1 03 00 00       	mov    eax,0x3a1
     3dd:	e9 79 09 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 2)
     3e2:	80 7d f8 02          	cmp    BYTE PTR [ebp-0x8],0x2
     3e6:	75 0a                	jne    3f2 <pci_get_subclass_string+0x156>
						return "FDDI controller";
     3e8:	b8 b7 03 00 00       	mov    eax,0x3b7
     3ed:	e9 69 09 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 3)
     3f2:	80 7d f8 03          	cmp    BYTE PTR [ebp-0x8],0x3
     3f6:	75 0a                	jne    402 <pci_get_subclass_string+0x166>
						return "ATM controller";
     3f8:	b8 c7 03 00 00       	mov    eax,0x3c7
     3fd:	e9 59 09 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 4)
     402:	80 7d f8 04          	cmp    BYTE PTR [ebp-0x8],0x4
     406:	75 0a                	jne    412 <pci_get_subclass_string+0x176>
						return "ISDN controller";
     408:	b8 d6 03 00 00       	mov    eax,0x3d6
     40d:	e9 49 09 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 5)
     412:	80 7d f8 05          	cmp    BYTE PTR [ebp-0x8],0x5
     416:	75 0a                	jne    422 <pci_get_subclass_string+0x186>
						return "WorldFip controller";
     418:	b8 e6 03 00 00       	mov    eax,0x3e6
     41d:	e9 39 09 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 6)
     422:	80 7d f8 06          	cmp    BYTE PTR [ebp-0x8],0x6
     426:	75 0a                	jne    432 <pci_get_subclass_string+0x196>
						return "PICMG 2.14 Multi Computing";
     428:	b8 fa 03 00 00       	mov    eax,0x3fa
     42d:	e9 29 09 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 0x80)
     432:	80 7d f8 80          	cmp    BYTE PTR [ebp-0x8],0x80
     436:	75 0a                	jne    442 <pci_get_subclass_string+0x1a6>
						return "other network controller";
     438:	b8 15 04 00 00       	mov    eax,0x415
     43d:	e9 19 09 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						return "unrecognized network controller";
     442:	b8 30 04 00 00       	mov    eax,0x430
     447:	e9 0f 09 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
		else if (cls == 3)
     44c:	80 7d fc 03          	cmp    BYTE PTR [ebp-0x4],0x3
     450:	75 6a                	jne    4bc <pci_get_subclass_string+0x220>
				if (scls == 0)
     452:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     456:	75 2a                	jne    482 <pci_get_subclass_string+0x1e6>
						if (progIf == 0)
     458:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
     45c:	75 0a                	jne    468 <pci_get_subclass_string+0x1cc>
								return "VGA-compatible controller";
     45e:	b8 50 04 00 00       	mov    eax,0x450
     463:	e9 f3 08 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 1)
     468:	80 7d f4 01          	cmp    BYTE PTR [ebp-0xc],0x1
     46c:	75 0a                	jne    478 <pci_get_subclass_string+0x1dc>
								return "8512-compatible controller";
     46e:	b8 6a 04 00 00       	mov    eax,0x46a
     473:	e9 e3 08 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
								return "unkown sc0 display controller";
     478:	b8 85 04 00 00       	mov    eax,0x485
     47d:	e9 d9 08 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 1)
     482:	80 7d f8 01          	cmp    BYTE PTR [ebp-0x8],0x1
     486:	75 0a                	jne    492 <pci_get_subclass_string+0x1f6>
						return "XGA controller";
     488:	b8 a3 04 00 00       	mov    eax,0x4a3
     48d:	e9 c9 08 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 2)
     492:	80 7d f8 02          	cmp    BYTE PTR [ebp-0x8],0x2
     496:	75 0a                	jne    4a2 <pci_get_subclass_string+0x206>
						return "3D controller (no VGA)";
     498:	b8 b2 04 00 00       	mov    eax,0x4b2
     49d:	e9 b9 08 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 0x80)
     4a2:	80 7d f8 80          	cmp    BYTE PTR [ebp-0x8],0x80
     4a6:	75 0a                	jne    4b2 <pci_get_subclass_string+0x216>
						return "other video controller";
     4a8:	b8 c9 04 00 00       	mov    eax,0x4c9
     4ad:	e9 a9 08 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						return "unrecognized video controller";
     4b2:	b8 e0 04 00 00       	mov    eax,0x4e0
     4b7:	e9 9f 08 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
		else if (cls == 4)
     4bc:	80 7d fc 04          	cmp    BYTE PTR [ebp-0x4],0x4
     4c0:	75 4a                	jne    50c <pci_get_subclass_string+0x270>
				if (scls == 0)
     4c2:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     4c6:	75 0a                	jne    4d2 <pci_get_subclass_string+0x236>
						return "video device";
     4c8:	b8 fe 04 00 00       	mov    eax,0x4fe
     4cd:	e9 89 08 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 1)
     4d2:	80 7d f8 01          	cmp    BYTE PTR [ebp-0x8],0x1
     4d6:	75 0a                	jne    4e2 <pci_get_subclass_string+0x246>
						return "audio device";
     4d8:	b8 0b 05 00 00       	mov    eax,0x50b
     4dd:	e9 79 08 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 2)
     4e2:	80 7d f8 02          	cmp    BYTE PTR [ebp-0x8],0x2
     4e6:	75 0a                	jne    4f2 <pci_get_subclass_string+0x256>
						return "Computer telephony device";
     4e8:	b8 18 05 00 00       	mov    eax,0x518
     4ed:	e9 69 08 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 0x80)
     4f2:	80 7d f8 80          	cmp    BYTE PTR [ebp-0x8],0x80
     4f6:	75 0a                	jne    502 <pci_get_subclass_string+0x266>
						return "other media device";
     4f8:	b8 32 05 00 00       	mov    eax,0x532
     4fd:	e9 59 08 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						return "unrecongnized media device";
     502:	b8 45 05 00 00       	mov    eax,0x545
     507:	e9 4f 08 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
		else if (cls == 5)
     50c:	80 7d fc 05          	cmp    BYTE PTR [ebp-0x4],0x5
     510:	75 3a                	jne    54c <pci_get_subclass_string+0x2b0>
				if (scls == 0)
     512:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     516:	75 0a                	jne    522 <pci_get_subclass_string+0x286>
						return "RAM controller";
     518:	b8 60 05 00 00       	mov    eax,0x560
     51d:	e9 39 08 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 1)
     522:	80 7d f8 01          	cmp    BYTE PTR [ebp-0x8],0x1
     526:	75 0a                	jne    532 <pci_get_subclass_string+0x296>
						return "flash controller";
     528:	b8 6f 05 00 00       	mov    eax,0x56f
     52d:	e9 29 08 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 0x80)
     532:	80 7d f8 80          	cmp    BYTE PTR [ebp-0x8],0x80
     536:	75 0a                	jne    542 <pci_get_subclass_string+0x2a6>
						return "other memory controller";
     538:	b8 80 05 00 00       	mov    eax,0x580
     53d:	e9 19 08 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						return "unrecognized memory controller";
     542:	b8 98 05 00 00       	mov    eax,0x598
     547:	e9 0f 08 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
		else if (cls == 6)
     54c:	80 7d fc 06          	cmp    BYTE PTR [ebp-0x4],0x6
     550:	0f 85 0a 01 00 00    	jne    660 <pci_get_subclass_string+0x3c4>
				if (scls == 0)
     556:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     55a:	75 0a                	jne    566 <pci_get_subclass_string+0x2ca>
						return "Host bridge";
     55c:	b8 b7 05 00 00       	mov    eax,0x5b7
     561:	e9 f5 07 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 1)
     566:	80 7d f8 01          	cmp    BYTE PTR [ebp-0x8],0x1
     56a:	75 0a                	jne    576 <pci_get_subclass_string+0x2da>
						return "ISA bridge";
     56c:	b8 c3 05 00 00       	mov    eax,0x5c3
     571:	e9 e5 07 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 2)
     576:	80 7d f8 02          	cmp    BYTE PTR [ebp-0x8],0x2
     57a:	75 0a                	jne    586 <pci_get_subclass_string+0x2ea>
						return "EISA bridge";
     57c:	b8 ce 05 00 00       	mov    eax,0x5ce
     581:	e9 d5 07 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 3)
     586:	80 7d f8 03          	cmp    BYTE PTR [ebp-0x8],0x3
     58a:	75 0a                	jne    596 <pci_get_subclass_string+0x2fa>
						return "MCA bridge";
     58c:	b8 da 05 00 00       	mov    eax,0x5da
     591:	e9 c5 07 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 4)
     596:	80 7d f8 04          	cmp    BYTE PTR [ebp-0x8],0x4
     59a:	75 2a                	jne    5c6 <pci_get_subclass_string+0x32a>
						if (progIf == 0)
     59c:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
     5a0:	75 0a                	jne    5ac <pci_get_subclass_string+0x310>
								return "PCI-to-PCI bridge";
     5a2:	b8 e5 05 00 00       	mov    eax,0x5e5
     5a7:	e9 af 07 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 1)
     5ac:	80 7d f4 01          	cmp    BYTE PTR [ebp-0xc],0x1
     5b0:	75 0a                	jne    5bc <pci_get_subclass_string+0x320>
								return "PCI-to-PCI bridge (subtractive decode)";
     5b2:	b8 f8 05 00 00       	mov    eax,0x5f8
     5b7:	e9 9f 07 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
								return "possibly PCI-to-PCI bridge";
     5bc:	b8 1f 06 00 00       	mov    eax,0x61f
     5c1:	e9 95 07 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 5)
     5c6:	80 7d f8 05          	cmp    BYTE PTR [ebp-0x8],0x5
     5ca:	75 0a                	jne    5d6 <pci_get_subclass_string+0x33a>
						return "PCMCIA bridge";
     5cc:	b8 3a 06 00 00       	mov    eax,0x63a
     5d1:	e9 85 07 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 6)
     5d6:	80 7d f8 06          	cmp    BYTE PTR [ebp-0x8],0x6
     5da:	75 0a                	jne    5e6 <pci_get_subclass_string+0x34a>
						return "NuBus bridge";
     5dc:	b8 48 06 00 00       	mov    eax,0x648
     5e1:	e9 75 07 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 7)
     5e6:	80 7d f8 07          	cmp    BYTE PTR [ebp-0x8],0x7
     5ea:	75 0a                	jne    5f6 <pci_get_subclass_string+0x35a>
						return "CardBus bridge";
     5ec:	b8 55 06 00 00       	mov    eax,0x655
     5f1:	e9 65 07 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 8)
     5f6:	80 7d f8 08          	cmp    BYTE PTR [ebp-0x8],0x8
     5fa:	75 0a                	jne    606 <pci_get_subclass_string+0x36a>
						return "RACEway bridge";
     5fc:	b8 64 06 00 00       	mov    eax,0x664
     601:	e9 55 07 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 9)
     606:	80 7d f8 09          	cmp    BYTE PTR [ebp-0x8],0x9
     60a:	75 2a                	jne    636 <pci_get_subclass_string+0x39a>
						if (progIf == 0x40)
     60c:	80 7d f4 40          	cmp    BYTE PTR [ebp-0xc],0x40
     610:	75 0a                	jne    61c <pci_get_subclass_string+0x380>
								return "PCI-to-PCI bridge (ST, pri)";
     612:	b8 73 06 00 00       	mov    eax,0x673
     617:	e9 3f 07 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 0x80)
     61c:	80 7d f4 80          	cmp    BYTE PTR [ebp-0xc],0x80
     620:	75 0a                	jne    62c <pci_get_subclass_string+0x390>
								return "PCI-to-PCI bridge (ST, sec)";
     622:	b8 8f 06 00 00       	mov    eax,0x68f
     627:	e9 2f 07 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
								return "possibly PCI-to-PCI bridge (ST)";
     62c:	b8 ac 06 00 00       	mov    eax,0x6ac
     631:	e9 25 07 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 10)
     636:	80 7d f8 0a          	cmp    BYTE PTR [ebp-0x8],0xa
     63a:	75 0a                	jne    646 <pci_get_subclass_string+0x3aa>
						return "InfiniBand-to-PCI host bridge";
     63c:	b8 cc 06 00 00       	mov    eax,0x6cc
     641:	e9 15 07 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 0x80)
     646:	80 7d f8 80          	cmp    BYTE PTR [ebp-0x8],0x80
     64a:	75 0a                	jne    656 <pci_get_subclass_string+0x3ba>
						return "other bridge device";
     64c:	b8 ea 06 00 00       	mov    eax,0x6ea
     651:	e9 05 07 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						return "unrecognized bridge device";
     656:	b8 fe 06 00 00       	mov    eax,0x6fe
     65b:	e9 fb 06 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
		else if (cls == 7)
     660:	80 7d fc 07          	cmp    BYTE PTR [ebp-0x4],0x7
     664:	0f 85 5a 01 00 00    	jne    7c4 <pci_get_subclass_string+0x528>
				if (scls == 0)
     66a:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     66e:	75 7a                	jne    6ea <pci_get_subclass_string+0x44e>
						if (progIf == 0)
     670:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
     674:	75 0a                	jne    680 <pci_get_subclass_string+0x3e4>
								return "generic XT-compatible serial controller";
     676:	b8 1c 07 00 00       	mov    eax,0x71c
     67b:	e9 db 06 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 1)
     680:	80 7d f4 01          	cmp    BYTE PTR [ebp-0xc],0x1
     684:	75 0a                	jne    690 <pci_get_subclass_string+0x3f4>
								return "16450-compatible serial controller";
     686:	b8 44 07 00 00       	mov    eax,0x744
     68b:	e9 cb 06 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 2)
     690:	80 7d f4 02          	cmp    BYTE PTR [ebp-0xc],0x2
     694:	75 0a                	jne    6a0 <pci_get_subclass_string+0x404>
								return "16550-compatible serial controller";
     696:	b8 68 07 00 00       	mov    eax,0x768
     69b:	e9 bb 06 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 3)
     6a0:	80 7d f4 03          	cmp    BYTE PTR [ebp-0xc],0x3
     6a4:	75 0a                	jne    6b0 <pci_get_subclass_string+0x414>
								return "16650-compatible serial controller";
     6a6:	b8 8c 07 00 00       	mov    eax,0x78c
     6ab:	e9 ab 06 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 4)
     6b0:	80 7d f4 04          	cmp    BYTE PTR [ebp-0xc],0x4
     6b4:	75 0a                	jne    6c0 <pci_get_subclass_string+0x424>
								return "16750-compatible serial controller";
     6b6:	b8 b0 07 00 00       	mov    eax,0x7b0
     6bb:	e9 9b 06 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 5)
     6c0:	80 7d f4 05          	cmp    BYTE PTR [ebp-0xc],0x5
     6c4:	75 0a                	jne    6d0 <pci_get_subclass_string+0x434>
								return "16850-compatible serial controller";
     6c6:	b8 d4 07 00 00       	mov    eax,0x7d4
     6cb:	e9 8b 06 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 6)
     6d0:	80 7d f4 06          	cmp    BYTE PTR [ebp-0xc],0x6
     6d4:	75 0a                	jne    6e0 <pci_get_subclass_string+0x444>
								return "16950-compatible serial controller";
     6d6:	b8 f8 07 00 00       	mov    eax,0x7f8
     6db:	e9 7b 06 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
								return "other serial controller";
     6e0:	b8 1b 08 00 00       	mov    eax,0x81b
     6e5:	e9 71 06 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 1)
     6ea:	80 7d f8 01          	cmp    BYTE PTR [ebp-0x8],0x1
     6ee:	75 5a                	jne    74a <pci_get_subclass_string+0x4ae>
						if (progIf == 0)
     6f0:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
     6f4:	75 0a                	jne    700 <pci_get_subclass_string+0x464>
								return "parallel port";
     6f6:	b8 33 08 00 00       	mov    eax,0x833
     6fb:	e9 5b 06 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 1)
     700:	80 7d f4 01          	cmp    BYTE PTR [ebp-0xc],0x1
     704:	75 0a                	jne    710 <pci_get_subclass_string+0x474>
								return "bidirectional parallel port";
     706:	b8 41 08 00 00       	mov    eax,0x841
     70b:	e9 4b 06 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 2)
     710:	80 7d f4 02          	cmp    BYTE PTR [ebp-0xc],0x2
     714:	75 0a                	jne    720 <pci_get_subclass_string+0x484>
								return "ECP 1.x compliant parallel port";
     716:	b8 60 08 00 00       	mov    eax,0x860
     71b:	e9 3b 06 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 3)
     720:	80 7d f4 03          	cmp    BYTE PTR [ebp-0xc],0x3
     724:	75 0a                	jne    730 <pci_get_subclass_string+0x494>
								return "IEEE 1284 controller";
     726:	b8 80 08 00 00       	mov    eax,0x880
     72b:	e9 2b 06 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 0xfe)
     730:	80 7d f4 fe          	cmp    BYTE PTR [ebp-0xc],0xfe
     734:	75 0a                	jne    740 <pci_get_subclass_string+0x4a4>
								return "IEEE 1284 target device";
     736:	b8 95 08 00 00       	mov    eax,0x895
     73b:	e9 1b 06 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
								return "other parallel device";
     740:	b8 ad 08 00 00       	mov    eax,0x8ad
     745:	e9 11 06 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 2)
     74a:	80 7d f8 02          	cmp    BYTE PTR [ebp-0x8],0x2
     74e:	75 0a                	jne    75a <pci_get_subclass_string+0x4be>
						return "multiport serial controller";
     750:	b8 c3 08 00 00       	mov    eax,0x8c3
     755:	e9 01 06 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 3)
     75a:	80 7d f8 03          	cmp    BYTE PTR [ebp-0x8],0x3
     75e:	75 2a                	jne    78a <pci_get_subclass_string+0x4ee>
						if (progIf == 0)
     760:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
     764:	75 0a                	jne    770 <pci_get_subclass_string+0x4d4>
								return "generic modem";
     766:	b8 df 08 00 00       	mov    eax,0x8df
     76b:	e9 eb 05 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf <= 4)
     770:	80 7d f4 04          	cmp    BYTE PTR [ebp-0xc],0x4
     774:	77 0a                	ja     780 <pci_get_subclass_string+0x4e4>
								return "Hayes compatible modem (see progIf for details)";
     776:	b8 f0 08 00 00       	mov    eax,0x8f0
     77b:	e9 db 05 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
								return "other modem";
     780:	b8 20 09 00 00       	mov    eax,0x920
     785:	e9 d1 05 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 4)
     78a:	80 7d f8 04          	cmp    BYTE PTR [ebp-0x8],0x4
     78e:	75 0a                	jne    79a <pci_get_subclass_string+0x4fe>
						return "IEEE 488.1/2 (GPIB) controller";
     790:	b8 2c 09 00 00       	mov    eax,0x92c
     795:	e9 c1 05 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 5)
     79a:	80 7d f8 05          	cmp    BYTE PTR [ebp-0x8],0x5
     79e:	75 0a                	jne    7aa <pci_get_subclass_string+0x50e>
						return "SmartCard";
     7a0:	b8 4b 09 00 00       	mov    eax,0x94b
     7a5:	e9 b1 05 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 0x80)
     7aa:	80 7d f8 80          	cmp    BYTE PTR [ebp-0x8],0x80
     7ae:	75 0a                	jne    7ba <pci_get_subclass_string+0x51e>
						return "other communications device";
     7b0:	b8 55 09 00 00       	mov    eax,0x955
     7b5:	e9 a1 05 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						return "unrecognized communications device";
     7ba:	b8 74 09 00 00       	mov    eax,0x974
     7bf:	e9 97 05 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
		else if (cls == 8)
     7c4:	80 7d fc 08          	cmp    BYTE PTR [ebp-0x4],0x8
     7c8:	0f 85 3a 01 00 00    	jne    908 <pci_get_subclass_string+0x66c>
				if (scls == 0)
     7ce:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     7d2:	75 5a                	jne    82e <pci_get_subclass_string+0x592>
						if (progIf == 0)
     7d4:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
     7d8:	75 0a                	jne    7e4 <pci_get_subclass_string+0x548>
								return "generic 8259 PIC";
     7da:	b8 97 09 00 00       	mov    eax,0x997
     7df:	e9 77 05 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 1)
     7e4:	80 7d f4 01          	cmp    BYTE PTR [ebp-0xc],0x1
     7e8:	75 0a                	jne    7f4 <pci_get_subclass_string+0x558>
								return "ISA PIC";
     7ea:	b8 a8 09 00 00       	mov    eax,0x9a8
     7ef:	e9 67 05 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 2)
     7f4:	80 7d f4 02          	cmp    BYTE PTR [ebp-0xc],0x2
     7f8:	75 0a                	jne    804 <pci_get_subclass_string+0x568>
								return "EISA PIC";
     7fa:	b8 b0 09 00 00       	mov    eax,0x9b0
     7ff:	e9 57 05 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 0x10)
     804:	80 7d f4 10          	cmp    BYTE PTR [ebp-0xc],0x10
     808:	75 0a                	jne    814 <pci_get_subclass_string+0x578>
								return "I/O APIC";
     80a:	b8 b9 09 00 00       	mov    eax,0x9b9
     80f:	e9 47 05 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 0x20)
     814:	80 7d f4 20          	cmp    BYTE PTR [ebp-0xc],0x20
     818:	75 0a                	jne    824 <pci_get_subclass_string+0x588>
								return "I/O(x) APIC";
     81a:	b8 c2 09 00 00       	mov    eax,0x9c2
     81f:	e9 37 05 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
								return "other interrupt controller";
     824:	b8 ce 09 00 00       	mov    eax,0x9ce
     829:	e9 2d 05 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 1)
     82e:	80 7d f8 01          	cmp    BYTE PTR [ebp-0x8],0x1
     832:	75 3a                	jne    86e <pci_get_subclass_string+0x5d2>
						if (progIf == 0)
     834:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
     838:	75 0a                	jne    844 <pci_get_subclass_string+0x5a8>
								return "generic 8237 DMA controller";
     83a:	b8 e9 09 00 00       	mov    eax,0x9e9
     83f:	e9 17 05 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 1)
     844:	80 7d f4 01          	cmp    BYTE PTR [ebp-0xc],0x1
     848:	75 0a                	jne    854 <pci_get_subclass_string+0x5b8>
								return "ISA DMA controller";
     84a:	b8 05 0a 00 00       	mov    eax,0xa05
     84f:	e9 07 05 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 2)
     854:	80 7d f4 02          	cmp    BYTE PTR [ebp-0xc],0x2
     858:	75 0a                	jne    864 <pci_get_subclass_string+0x5c8>
								return "EISA DMA controller";
     85a:	b8 18 0a 00 00       	mov    eax,0xa18
     85f:	e9 f7 04 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
								return "other DMA controller";
     864:	b8 2c 0a 00 00       	mov    eax,0xa2c
     869:	e9 ed 04 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 2)
     86e:	80 7d f8 02          	cmp    BYTE PTR [ebp-0x8],0x2
     872:	75 3a                	jne    8ae <pci_get_subclass_string+0x612>
						if (progIf == 0)
     874:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
     878:	75 0a                	jne    884 <pci_get_subclass_string+0x5e8>
								return "generic 8254 system timer";
     87a:	b8 41 0a 00 00       	mov    eax,0xa41
     87f:	e9 d7 04 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 1)
     884:	80 7d f4 01          	cmp    BYTE PTR [ebp-0xc],0x1
     888:	75 0a                	jne    894 <pci_get_subclass_string+0x5f8>
								return "ISA system timer";
     88a:	b8 5b 0a 00 00       	mov    eax,0xa5b
     88f:	e9 c7 04 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 2)
     894:	80 7d f4 02          	cmp    BYTE PTR [ebp-0xc],0x2
     898:	75 0a                	jne    8a4 <pci_get_subclass_string+0x608>
								return "EISA system timer";
     89a:	b8 6c 0a 00 00       	mov    eax,0xa6c
     89f:	e9 b7 04 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
								return "other system timer";
     8a4:	b8 7e 0a 00 00       	mov    eax,0xa7e
     8a9:	e9 ad 04 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 3)
     8ae:	80 7d f8 03          	cmp    BYTE PTR [ebp-0x8],0x3
     8b2:	75 2a                	jne    8de <pci_get_subclass_string+0x642>
						if (progIf == 0)
     8b4:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
     8b8:	75 0a                	jne    8c4 <pci_get_subclass_string+0x628>
								return "generic RTC controller";
     8ba:	b8 91 0a 00 00       	mov    eax,0xa91
     8bf:	e9 97 04 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 1)
     8c4:	80 7d f4 01          	cmp    BYTE PTR [ebp-0xc],0x1
     8c8:	75 0a                	jne    8d4 <pci_get_subclass_string+0x638>
								return "ISA RTC controller";
     8ca:	b8 a8 0a 00 00       	mov    eax,0xaa8
     8cf:	e9 87 04 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
								return "other RTC controller";
     8d4:	b8 bb 0a 00 00       	mov    eax,0xabb
     8d9:	e9 7d 04 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 4)
     8de:	80 7d f8 04          	cmp    BYTE PTR [ebp-0x8],0x4
     8e2:	75 0a                	jne    8ee <pci_get_subclass_string+0x652>
						return "generic PCI Hot-Plug controller";
     8e4:	b8 d0 0a 00 00       	mov    eax,0xad0
     8e9:	e9 6d 04 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 0x80)
     8ee:	80 7d f8 80          	cmp    BYTE PTR [ebp-0x8],0x80
     8f2:	75 0a                	jne    8fe <pci_get_subclass_string+0x662>
						return "other system peripheral";
     8f4:	b8 f0 0a 00 00       	mov    eax,0xaf0
     8f9:	e9 5d 04 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						return "unrecognized system peripheral";
     8fe:	b8 08 0b 00 00       	mov    eax,0xb08
     903:	e9 53 04 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
		else if (cls == 9)
     908:	80 7d fc 09          	cmp    BYTE PTR [ebp-0x4],0x9
     90c:	0f 85 8a 00 00 00    	jne    99c <pci_get_subclass_string+0x700>
				if (scls == 0)
     912:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     916:	75 0a                	jne    922 <pci_get_subclass_string+0x686>
						return "keyboard controller";
     918:	b8 27 0b 00 00       	mov    eax,0xb27
     91d:	e9 39 04 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 1)
     922:	80 7d f8 01          	cmp    BYTE PTR [ebp-0x8],0x1
     926:	75 0a                	jne    932 <pci_get_subclass_string+0x696>
						return "digitizer";
     928:	b8 3b 0b 00 00       	mov    eax,0xb3b
     92d:	e9 29 04 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 2)
     932:	80 7d f8 02          	cmp    BYTE PTR [ebp-0x8],0x2
     936:	75 0a                	jne    942 <pci_get_subclass_string+0x6a6>
						return "mouse controller";
     938:	b8 45 0b 00 00       	mov    eax,0xb45
     93d:	e9 19 04 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 3)
     942:	80 7d f8 03          	cmp    BYTE PTR [ebp-0x8],0x3
     946:	75 0a                	jne    952 <pci_get_subclass_string+0x6b6>
						return "scanner controller";
     948:	b8 56 0b 00 00       	mov    eax,0xb56
     94d:	e9 09 04 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 4)
     952:	80 7d f8 04          	cmp    BYTE PTR [ebp-0x8],0x4
     956:	75 2a                	jne    982 <pci_get_subclass_string+0x6e6>
						if (progIf == 0)
     958:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
     95c:	75 0a                	jne    968 <pci_get_subclass_string+0x6cc>
								return "Gameport controller (generic)";
     95e:	b8 69 0b 00 00       	mov    eax,0xb69
     963:	e9 f3 03 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 0x10)
     968:	80 7d f4 10          	cmp    BYTE PTR [ebp-0xc],0x10
     96c:	75 0a                	jne    978 <pci_get_subclass_string+0x6dc>
								return "Gameport controller (legacy)";
     96e:	b8 87 0b 00 00       	mov    eax,0xb87
     973:	e9 e3 03 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
								return "other Gameport controller";
     978:	b8 a4 0b 00 00       	mov    eax,0xba4
     97d:	e9 d9 03 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 0x80)
     982:	80 7d f8 80          	cmp    BYTE PTR [ebp-0x8],0x80
     986:	75 0a                	jne    992 <pci_get_subclass_string+0x6f6>
						return "other input controller";
     988:	b8 be 0b 00 00       	mov    eax,0xbbe
     98d:	e9 c9 03 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						return "unrecognized input controller";
     992:	b8 d5 0b 00 00       	mov    eax,0xbd5
     997:	e9 bf 03 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
		else if (cls == 10)
     99c:	80 7d fc 0a          	cmp    BYTE PTR [ebp-0x4],0xa
     9a0:	75 2a                	jne    9cc <pci_get_subclass_string+0x730>
				if (scls == 0)
     9a2:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     9a6:	75 0a                	jne    9b2 <pci_get_subclass_string+0x716>
						return "generic docking station";
     9a8:	b8 f3 0b 00 00       	mov    eax,0xbf3
     9ad:	e9 a9 03 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 0x80)
     9b2:	80 7d f8 80          	cmp    BYTE PTR [ebp-0x8],0x80
     9b6:	75 0a                	jne    9c2 <pci_get_subclass_string+0x726>
						return "other docking station";
     9b8:	b8 0b 0c 00 00       	mov    eax,0xc0b
     9bd:	e9 99 03 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						return "unrecognized docking station";
     9c2:	b8 21 0c 00 00       	mov    eax,0xc21
     9c7:	e9 8f 03 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
		else if (cls == 11)
     9cc:	80 7d fc 0b          	cmp    BYTE PTR [ebp-0x4],0xb
     9d0:	75 7a                	jne    a4c <pci_get_subclass_string+0x7b0>
				if (scls == 0)
     9d2:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     9d6:	75 0a                	jne    9e2 <pci_get_subclass_string+0x746>
						return "386 processor";
     9d8:	b8 3e 0c 00 00       	mov    eax,0xc3e
     9dd:	e9 79 03 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 1)
     9e2:	80 7d f8 01          	cmp    BYTE PTR [ebp-0x8],0x1
     9e6:	75 0a                	jne    9f2 <pci_get_subclass_string+0x756>
						return "486 processor";
     9e8:	b8 4c 0c 00 00       	mov    eax,0xc4c
     9ed:	e9 69 03 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 2)
     9f2:	80 7d f8 02          	cmp    BYTE PTR [ebp-0x8],0x2
     9f6:	75 0a                	jne    a02 <pci_get_subclass_string+0x766>
						return "Pentiu processor";
     9f8:	b8 5a 0c 00 00       	mov    eax,0xc5a
     9fd:	e9 59 03 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 0x10)
     a02:	80 7d f8 10          	cmp    BYTE PTR [ebp-0x8],0x10
     a06:	75 0a                	jne    a12 <pci_get_subclass_string+0x776>
						return "Alpha processor";
     a08:	b8 6b 0c 00 00       	mov    eax,0xc6b
     a0d:	e9 49 03 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 0x20)
     a12:	80 7d f8 20          	cmp    BYTE PTR [ebp-0x8],0x20
     a16:	75 0a                	jne    a22 <pci_get_subclass_string+0x786>
						return "PowerPC processor";
     a18:	b8 7b 0c 00 00       	mov    eax,0xc7b
     a1d:	e9 39 03 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 0x30)
     a22:	80 7d f8 30          	cmp    BYTE PTR [ebp-0x8],0x30
     a26:	75 0a                	jne    a32 <pci_get_subclass_string+0x796>
						return "MIPS processor";
     a28:	b8 8d 0c 00 00       	mov    eax,0xc8d
     a2d:	e9 29 03 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 0x40)
     a32:	80 7d f8 40          	cmp    BYTE PTR [ebp-0x8],0x40
     a36:	75 0a                	jne    a42 <pci_get_subclass_string+0x7a6>
						return "coprocessor";
     a38:	b8 9c 0c 00 00       	mov    eax,0xc9c
     a3d:	e9 19 03 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						return "unrecognized processor";
     a42:	b8 a8 0c 00 00       	mov    eax,0xca8
     a47:	e9 0f 03 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
		else if (cls == 12)
     a4c:	80 7d fc 0c          	cmp    BYTE PTR [ebp-0x4],0xc
     a50:	0f 85 5a 01 00 00    	jne    bb0 <pci_get_subclass_string+0x914>
				if (scls == 0)
     a56:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     a5a:	75 2a                	jne    a86 <pci_get_subclass_string+0x7ea>
						if (progIf == 0)
     a5c:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
     a60:	75 0a                	jne    a6c <pci_get_subclass_string+0x7d0>
								return "IEEE 1394 controller (FireWire)";
     a62:	b8 c0 0c 00 00       	mov    eax,0xcc0
     a67:	e9 ef 02 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 0x10)
     a6c:	80 7d f4 10          	cmp    BYTE PTR [ebp-0xc],0x10
     a70:	75 0a                	jne    a7c <pci_get_subclass_string+0x7e0>
								return "IEEE 1394 controller (OpenHCI)";
     a72:	b8 e0 0c 00 00       	mov    eax,0xce0
     a77:	e9 df 02 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
								return "unrecognized FireWire-compatible controller";
     a7c:	b8 00 0d 00 00       	mov    eax,0xd00
     a81:	e9 d5 02 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 1)
     a86:	80 7d f8 01          	cmp    BYTE PTR [ebp-0x8],0x1
     a8a:	75 0a                	jne    a96 <pci_get_subclass_string+0x7fa>
						return "ACCESS bus";
     a8c:	b8 2c 0d 00 00       	mov    eax,0xd2c
     a91:	e9 c5 02 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 2)
     a96:	80 7d f8 02          	cmp    BYTE PTR [ebp-0x8],0x2
     a9a:	75 0a                	jne    aa6 <pci_get_subclass_string+0x80a>
						return "SSA";
     a9c:	b8 37 0d 00 00       	mov    eax,0xd37
     aa1:	e9 b5 02 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 3)
     aa6:	80 7d f8 03          	cmp    BYTE PTR [ebp-0x8],0x3
     aaa:	75 6a                	jne    b16 <pci_get_subclass_string+0x87a>
						if (progIf == 0)
     aac:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
     ab0:	75 0a                	jne    abc <pci_get_subclass_string+0x820>
								return "USB (universal host controller)";
     ab2:	b8 3c 0d 00 00       	mov    eax,0xd3c
     ab7:	e9 9f 02 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 0x10)
     abc:	80 7d f4 10          	cmp    BYTE PTR [ebp-0xc],0x10
     ac0:	75 0a                	jne    acc <pci_get_subclass_string+0x830>
								return "USB (open host controller)";
     ac2:	b8 5c 0d 00 00       	mov    eax,0xd5c
     ac7:	e9 8f 02 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 0x20)
     acc:	80 7d f4 20          	cmp    BYTE PTR [ebp-0xc],0x20
     ad0:	75 0a                	jne    adc <pci_get_subclass_string+0x840>
								return "USB2 host controller (EHCI)";
     ad2:	b8 77 0d 00 00       	mov    eax,0xd77
     ad7:	e9 7f 02 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 0x30)
     adc:	80 7d f4 30          	cmp    BYTE PTR [ebp-0xc],0x30
     ae0:	75 0a                	jne    aec <pci_get_subclass_string+0x850>
								return "USB3 host controller (xHCI)";
     ae2:	b8 93 0d 00 00       	mov    eax,0xd93
     ae7:	e9 6f 02 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 0x80)
     aec:	80 7d f4 80          	cmp    BYTE PTR [ebp-0xc],0x80
     af0:	75 0a                	jne    afc <pci_get_subclass_string+0x860>
								return "USB";
     af2:	b8 af 0d 00 00       	mov    eax,0xdaf
     af7:	e9 5f 02 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 0xfe)
     afc:	80 7d f4 fe          	cmp    BYTE PTR [ebp-0xc],0xfe
     b00:	75 0a                	jne    b0c <pci_get_subclass_string+0x870>
								return "USB (not host controller)";
     b02:	b8 b3 0d 00 00       	mov    eax,0xdb3
     b07:	e9 4f 02 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
								return "unrecognized USB controller";
     b0c:	b8 cd 0d 00 00       	mov    eax,0xdcd
     b11:	e9 45 02 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 4)
     b16:	80 7d f8 04          	cmp    BYTE PTR [ebp-0x8],0x4
     b1a:	75 0a                	jne    b26 <pci_get_subclass_string+0x88a>
						return "Fibre channel";
     b1c:	b8 e9 0d 00 00       	mov    eax,0xde9
     b21:	e9 35 02 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 5)
     b26:	80 7d f8 05          	cmp    BYTE PTR [ebp-0x8],0x5
     b2a:	75 0a                	jne    b36 <pci_get_subclass_string+0x89a>
						return "SMBus";
     b2c:	b8 f7 0d 00 00       	mov    eax,0xdf7
     b31:	e9 25 02 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 6)
     b36:	80 7d f8 06          	cmp    BYTE PTR [ebp-0x8],0x6
     b3a:	75 0a                	jne    b46 <pci_get_subclass_string+0x8aa>
						return "InfiniBand";
     b3c:	b8 fd 0d 00 00       	mov    eax,0xdfd
     b41:	e9 15 02 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 7)
     b46:	80 7d f8 07          	cmp    BYTE PTR [ebp-0x8],0x7
     b4a:	75 3a                	jne    b86 <pci_get_subclass_string+0x8ea>
						if (progIf == 0)
     b4c:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
     b50:	75 0a                	jne    b5c <pci_get_subclass_string+0x8c0>
								return "IPMI SMIC interface";
     b52:	b8 08 0e 00 00       	mov    eax,0xe08
     b57:	e9 ff 01 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 1)
     b5c:	80 7d f4 01          	cmp    BYTE PTR [ebp-0xc],0x1
     b60:	75 0a                	jne    b6c <pci_get_subclass_string+0x8d0>
								return "IPMI kbd controller style interface";
     b62:	b8 1c 0e 00 00       	mov    eax,0xe1c
     b67:	e9 ef 01 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						else if (progIf == 2)
     b6c:	80 7d f4 02          	cmp    BYTE PTR [ebp-0xc],0x2
     b70:	75 0a                	jne    b7c <pci_get_subclass_string+0x8e0>
								return "IPMI block transfer interface";
     b72:	b8 40 0e 00 00       	mov    eax,0xe40
     b77:	e9 df 01 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
								return "unrecognized IMPI interface";
     b7c:	b8 5e 0e 00 00       	mov    eax,0xe5e
     b81:	e9 d5 01 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 8)
     b86:	80 7d f8 08          	cmp    BYTE PTR [ebp-0x8],0x8
     b8a:	75 0a                	jne    b96 <pci_get_subclass_string+0x8fa>
						return "SERCOS interface (IEC61491)";
     b8c:	b8 7a 0e 00 00       	mov    eax,0xe7a
     b91:	e9 c5 01 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 9)
     b96:	80 7d f8 09          	cmp    BYTE PTR [ebp-0x8],0x9
     b9a:	75 0a                	jne    ba6 <pci_get_subclass_string+0x90a>
						return "CANbus";
     b9c:	b8 96 0e 00 00       	mov    eax,0xe96
     ba1:	e9 b5 01 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						return "other bus interface";
     ba6:	b8 9d 0e 00 00       	mov    eax,0xe9d
     bab:	e9 ab 01 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
		else if (cls == 13)
     bb0:	80 7d fc 0d          	cmp    BYTE PTR [ebp-0x4],0xd
     bb4:	0f 85 8a 00 00 00    	jne    c44 <pci_get_subclass_string+0x9a8>
				if (scls == 0)
     bba:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     bbe:	75 0a                	jne    bca <pci_get_subclass_string+0x92e>
						return "iRDA compatible controller";
     bc0:	b8 b1 0e 00 00       	mov    eax,0xeb1
     bc5:	e9 91 01 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 1)
     bca:	80 7d f8 01          	cmp    BYTE PTR [ebp-0x8],0x1
     bce:	75 0a                	jne    bda <pci_get_subclass_string+0x93e>
						return "consumer IR controller";
     bd0:	b8 cc 0e 00 00       	mov    eax,0xecc
     bd5:	e9 81 01 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 0x10)
     bda:	80 7d f8 10          	cmp    BYTE PTR [ebp-0x8],0x10
     bde:	75 0a                	jne    bea <pci_get_subclass_string+0x94e>
						return "RF controller";
     be0:	b8 e3 0e 00 00       	mov    eax,0xee3
     be5:	e9 71 01 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 0x11)
     bea:	80 7d f8 11          	cmp    BYTE PTR [ebp-0x8],0x11
     bee:	75 0a                	jne    bfa <pci_get_subclass_string+0x95e>
						return "Bluetooth controller";
     bf0:	b8 f1 0e 00 00       	mov    eax,0xef1
     bf5:	e9 61 01 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 0x12)
     bfa:	80 7d f8 12          	cmp    BYTE PTR [ebp-0x8],0x12
     bfe:	75 0a                	jne    c0a <pci_get_subclass_string+0x96e>
						return "Broadband controller";
     c00:	b8 06 0f 00 00       	mov    eax,0xf06
     c05:	e9 51 01 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 0x20)
     c0a:	80 7d f8 20          	cmp    BYTE PTR [ebp-0x8],0x20
     c0e:	75 0a                	jne    c1a <pci_get_subclass_string+0x97e>
						return "Ethernet controller (802.11a)";
     c10:	b8 1b 0f 00 00       	mov    eax,0xf1b
     c15:	e9 41 01 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 0x21)
     c1a:	80 7d f8 21          	cmp    BYTE PTR [ebp-0x8],0x21
     c1e:	75 0a                	jne    c2a <pci_get_subclass_string+0x98e>
						return "Ethernet controller (802.11b)";
     c20:	b8 39 0f 00 00       	mov    eax,0xf39
     c25:	e9 31 01 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 0x80)
     c2a:	80 7d f8 80          	cmp    BYTE PTR [ebp-0x8],0x80
     c2e:	75 0a                	jne    c3a <pci_get_subclass_string+0x99e>
						return "other wireless controller";
     c30:	b8 57 0f 00 00       	mov    eax,0xf57
     c35:	e9 21 01 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						return "unrecognized wireless controller";
     c3a:	b8 74 0f 00 00       	mov    eax,0xf74
     c3f:	e9 17 01 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
		else if (cls == 14)
     c44:	80 7d fc 0e          	cmp    BYTE PTR [ebp-0x4],0xe
     c48:	75 2a                	jne    c74 <pci_get_subclass_string+0x9d8>
				if (scls == 0)
     c4a:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     c4e:	75 1a                	jne    c6a <pci_get_subclass_string+0x9ce>
						if (progIf == 0)
     c50:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
     c54:	75 0a                	jne    c60 <pci_get_subclass_string+0x9c4>
								return "Message FIFO";
     c56:	b8 95 0f 00 00       	mov    eax,0xf95
     c5b:	e9 fb 00 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
								return "I20 architecture";
     c60:	b8 a2 0f 00 00       	mov    eax,0xfa2
     c65:	e9 f1 00 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						return "other intelligent I/O controller";
     c6a:	b8 b4 0f 00 00       	mov    eax,0xfb4
     c6f:	e9 e7 00 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
		else if (cls == 15)
     c74:	80 7d fc 0f          	cmp    BYTE PTR [ebp-0x4],0xf
     c78:	75 4a                	jne    cc4 <pci_get_subclass_string+0xa28>
				if (scls == 1)
     c7a:	80 7d f8 01          	cmp    BYTE PTR [ebp-0x8],0x1
     c7e:	75 0a                	jne    c8a <pci_get_subclass_string+0x9ee>
						return "TV controller";
     c80:	b8 d5 0f 00 00       	mov    eax,0xfd5
     c85:	e9 d1 00 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 2)
     c8a:	80 7d f8 02          	cmp    BYTE PTR [ebp-0x8],0x2
     c8e:	75 0a                	jne    c9a <pci_get_subclass_string+0x9fe>
						return "audio controller";
     c90:	b8 e3 0f 00 00       	mov    eax,0xfe3
     c95:	e9 c1 00 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 3)
     c9a:	80 7d f8 03          	cmp    BYTE PTR [ebp-0x8],0x3
     c9e:	75 0a                	jne    caa <pci_get_subclass_string+0xa0e>
						return "voice controller";
     ca0:	b8 f4 0f 00 00       	mov    eax,0xff4
     ca5:	e9 b1 00 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 4)
     caa:	80 7d f8 04          	cmp    BYTE PTR [ebp-0x8],0x4
     cae:	75 0a                	jne    cba <pci_get_subclass_string+0xa1e>
						return "data controller";
     cb0:	b8 05 10 00 00       	mov    eax,0x1005
     cb5:	e9 a1 00 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
						return "other satellite controller";
     cba:	b8 15 10 00 00       	mov    eax,0x1015
     cbf:	e9 97 00 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
		else if (cls == 16)
     cc4:	80 7d fc 10          	cmp    BYTE PTR [ebp-0x4],0x10
     cc8:	75 31                	jne    cfb <pci_get_subclass_string+0xa5f>
				if (scls == 0)
     cca:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     cce:	75 0a                	jne    cda <pci_get_subclass_string+0xa3e>
						return "network and computing de/en-cryption";
     cd0:	b8 30 10 00 00       	mov    eax,0x1030
     cd5:	e9 81 00 00 00       	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 0x10)
     cda:	80 7d f8 10          	cmp    BYTE PTR [ebp-0x8],0x10
     cde:	75 07                	jne    ce7 <pci_get_subclass_string+0xa4b>
						return "entertainent de/en-cryption";
     ce0:	b8 55 10 00 00       	mov    eax,0x1055
     ce5:	eb 74                	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 0x80)
     ce7:	80 7d f8 80          	cmp    BYTE PTR [ebp-0x8],0x80
     ceb:	75 07                	jne    cf4 <pci_get_subclass_string+0xa58>
						return "other de/en-cryption";
     ced:	b8 71 10 00 00       	mov    eax,0x1071
     cf2:	eb 67                	jmp    d5b <pci_get_subclass_string+0xabf>
						return "unrecognized de/en-cryption";
     cf4:	b8 86 10 00 00       	mov    eax,0x1086
     cf9:	eb 60                	jmp    d5b <pci_get_subclass_string+0xabf>
		else if (cls == 17)
     cfb:	80 7d fc 11          	cmp    BYTE PTR [ebp-0x4],0x11
     cff:	75 48                	jne    d49 <pci_get_subclass_string+0xaad>
				if (scls == 0)
     d01:	80 7d f8 00          	cmp    BYTE PTR [ebp-0x8],0x0
     d05:	75 07                	jne    d0e <pci_get_subclass_string+0xa72>
						return "DPIO modules";
     d07:	b8 a2 10 00 00       	mov    eax,0x10a2
     d0c:	eb 4d                	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 1)
     d0e:	80 7d f8 01          	cmp    BYTE PTR [ebp-0x8],0x1
     d12:	75 07                	jne    d1b <pci_get_subclass_string+0xa7f>
						return "performance conters";
     d14:	b8 af 10 00 00       	mov    eax,0x10af
     d19:	eb 40                	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 0x10)
     d1b:	80 7d f8 10          	cmp    BYTE PTR [ebp-0x8],0x10
     d1f:	75 07                	jne    d28 <pci_get_subclass_string+0xa8c>
						return "communications synch plus time and freq test/measurement";
     d21:	b8 c4 10 00 00       	mov    eax,0x10c4
     d26:	eb 33                	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 0x20)
     d28:	80 7d f8 20          	cmp    BYTE PTR [ebp-0x8],0x20
     d2c:	75 07                	jne    d35 <pci_get_subclass_string+0xa99>
						return "management card";
     d2e:	b8 fd 10 00 00       	mov    eax,0x10fd
     d33:	eb 26                	jmp    d5b <pci_get_subclass_string+0xabf>
				else if (scls == 0x80)
     d35:	80 7d f8 80          	cmp    BYTE PTR [ebp-0x8],0x80
     d39:	75 07                	jne    d42 <pci_get_subclass_string+0xaa6>
						return "other data acquisition/signal processing controller";
     d3b:	b8 10 11 00 00       	mov    eax,0x1110
     d40:	eb 19                	jmp    d5b <pci_get_subclass_string+0xabf>
						return "unrecognized data acquisition/signal processing controller";
     d42:	b8 44 11 00 00       	mov    eax,0x1144
     d47:	eb 12                	jmp    d5b <pci_get_subclass_string+0xabf>
		else if (cls == 0xff)
     d49:	80 7d fc ff          	cmp    BYTE PTR [ebp-0x4],0xff
     d4d:	75 07                	jne    d56 <pci_get_subclass_string+0xaba>
				return "device not fitting defined class";
     d4f:	b8 80 11 00 00       	mov    eax,0x1180
     d54:	eb 05                	jmp    d5b <pci_get_subclass_string+0xabf>
				return "unrecognized device class";
     d56:	b8 a1 11 00 00       	mov    eax,0x11a1
}
     d5b:	c9                   	leave
     d5c:	c3                   	ret

00000d5d <pci_disable_interrupts>:
{
     d5d:	55                   	push   ebp
     d5e:	89 e5                	mov    ebp,esp
     d60:	83 ec 18             	sub    esp,0x18
		union pca a = d->addr; uint32_t dat;
     d63:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     d66:	8b 00                	mov    eax,DWORD PTR [eax]
     d68:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
		a.reg_no = PCI_COMMAND;
     d6b:	c6 45 f8 04          	mov    BYTE PTR [ebp-0x8],0x4
		dat = pci_read(a);
     d6f:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     d72:	89 04 24             	mov    DWORD PTR [esp],eax
     d75:	e8 2f f3 ff ff       	call   a9 <pci_read>
     d7a:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		if (dat & PCI_COMMAND_INTX_DISABLE)
     d7d:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     d80:	25 00 04 00 00       	and    eax,0x400
     d85:	85 c0                	test   eax,eax
     d87:	74 07                	je     d90 <pci_disable_interrupts+0x33>
				return 0;
     d89:	b8 00 00 00 00       	mov    eax,0x0
     d8e:	eb 37                	jmp    dc7 <pci_disable_interrupts+0x6a>
		dat |= PCI_COMMAND_INTX_DISABLE;
     d90:	81 4d fc 00 04 00 00 	or     DWORD PTR [ebp-0x4],0x400
		pci_write(a, dat);
     d97:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     d9a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     d9e:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     da1:	89 04 24             	mov    DWORD PTR [esp],eax
     da4:	e8 f1 f3 ff ff       	call   19a <pci_write>
		dat = pci_read(a);
     da9:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     dac:	89 04 24             	mov    DWORD PTR [esp],eax
     daf:	e8 f5 f2 ff ff       	call   a9 <pci_read>
     db4:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		return !(dat & PCI_COMMAND_INTX_DISABLE);
     db7:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     dba:	25 00 04 00 00       	and    eax,0x400
     dbf:	85 c0                	test   eax,eax
     dc1:	0f 94 c0             	sete   al
     dc4:	0f b6 c0             	movzx  eax,al
}
     dc7:	c9                   	leave
     dc8:	c3                   	ret

00000dc9 <pci_enable_interrupts>:
{
     dc9:	55                   	push   ebp
     dca:	89 e5                	mov    ebp,esp
     dcc:	83 ec 18             	sub    esp,0x18
		union pca a = d->addr; uint32_t dat;
     dcf:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     dd2:	8b 00                	mov    eax,DWORD PTR [eax]
     dd4:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
		a.reg_no = PCI_COMMAND;
     dd7:	c6 45 f8 04          	mov    BYTE PTR [ebp-0x8],0x4
		dat = pci_read(a);
     ddb:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     dde:	89 04 24             	mov    DWORD PTR [esp],eax
     de1:	e8 c3 f2 ff ff       	call   a9 <pci_read>
     de6:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		if (!(dat & PCI_COMMAND_INTX_DISABLE))
     de9:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     dec:	25 00 04 00 00       	and    eax,0x400
     df1:	85 c0                	test   eax,eax
     df3:	75 07                	jne    dfc <pci_enable_interrupts+0x33>
				return 0;
     df5:	b8 00 00 00 00       	mov    eax,0x0
     dfa:	eb 37                	jmp    e33 <pci_enable_interrupts+0x6a>
		dat &= 0xffff0000 | ~(PCI_COMMAND_INTX_DISABLE);
     dfc:	81 65 fc ff fb ff ff 	and    DWORD PTR [ebp-0x4],0xfffffbff
		pci_write(a, dat);
     e03:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     e06:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     e0a:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     e0d:	89 04 24             	mov    DWORD PTR [esp],eax
     e10:	e8 85 f3 ff ff       	call   19a <pci_write>
		dat = pci_read(a);
     e15:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     e18:	89 04 24             	mov    DWORD PTR [esp],eax
     e1b:	e8 89 f2 ff ff       	call   a9 <pci_read>
     e20:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		return !!(dat & PCI_COMMAND_INTX_DISABLE);
     e23:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     e26:	25 00 04 00 00       	and    eax,0x400
     e2b:	85 c0                	test   eax,eax
     e2d:	0f 95 c0             	setne  al
     e30:	0f b6 c0             	movzx  eax,al
}
     e33:	c9                   	leave
     e34:	c3                   	ret

00000e35 <pci_print_is>:
{
     e35:	55                   	push   ebp
     e36:	89 e5                	mov    ebp,esp
     e38:	83 ec 28             	sub    esp,0x28
		ad.reg_no = PCI_STATUS;
     e3b:	c6 45 08 06          	mov    BYTE PTR [ebp+0x8],0x6
		rv = !!(pci_read_word(ad) & PCI_STATUS_INTERRUPT);
     e3f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     e42:	89 04 24             	mov    DWORD PTR [esp],eax
     e45:	e8 8b f2 ff ff       	call   d5 <pci_read_word>
     e4a:	0f b7 c0             	movzx  eax,ax
     e4d:	83 e0 08             	and    eax,0x8
     e50:	85 c0                	test   eax,eax
     e52:	0f 95 c0             	setne  al
     e55:	0f b6 c0             	movzx  eax,al
     e58:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		printf("PCI IS: %d\n", rv);
     e5b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     e5e:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     e62:	c7 04 24 bb 11 00 00 	mov    DWORD PTR [esp],0x11bb
     e69:	e8 fc ff ff ff       	call   e6a <pci_print_is+0x35>
}
     e6e:	90                   	nop
     e6f:	c9                   	leave
     e70:	c3                   	ret

00000e71 <pci_set_master>:
{
     e71:	55                   	push   ebp
     e72:	89 e5                	mov    ebp,esp
     e74:	83 ec 18             	sub    esp,0x18
		union pca a = d->addr; uint32_t dat;
     e77:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     e7a:	8b 00                	mov    eax,DWORD PTR [eax]
     e7c:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
		a.reg_no = PCI_COMMAND;
     e7f:	c6 45 f8 04          	mov    BYTE PTR [ebp-0x8],0x4
		dat = pci_read(a);
     e83:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     e86:	89 04 24             	mov    DWORD PTR [esp],eax
     e89:	e8 1b f2 ff ff       	call   a9 <pci_read>
     e8e:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		if (dat & PCI_COMMAND_MASTER)
     e91:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     e94:	83 e0 04             	and    eax,0x4
     e97:	85 c0                	test   eax,eax
     e99:	74 07                	je     ea2 <pci_set_master+0x31>
				return 0;
     e9b:	b8 00 00 00 00       	mov    eax,0x0
     ea0:	eb 32                	jmp    ed4 <pci_set_master+0x63>
		dat &= 0xffff0000 | ~(PCI_COMMAND_MASTER);
     ea2:	83 65 fc fb          	and    DWORD PTR [ebp-0x4],0xfffffffb
		pci_write(a, dat);
     ea6:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     ea9:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     ead:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     eb0:	89 04 24             	mov    DWORD PTR [esp],eax
     eb3:	e8 e2 f2 ff ff       	call   19a <pci_write>
		dat = pci_read(a);
     eb8:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     ebb:	89 04 24             	mov    DWORD PTR [esp],eax
     ebe:	e8 e6 f1 ff ff       	call   a9 <pci_read>
     ec3:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		return !(dat & PCI_COMMAND_MASTER);
     ec6:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     ec9:	83 e0 04             	and    eax,0x4
     ecc:	85 c0                	test   eax,eax
     ece:	0f 94 c0             	sete   al
     ed1:	0f b6 c0             	movzx  eax,al
}
     ed4:	c9                   	leave
     ed5:	c3                   	ret

00000ed6 <pci_check_interrupt>:
{
     ed6:	55                   	push   ebp
     ed7:	89 e5                	mov    ebp,esp
     ed9:	83 ec 14             	sub    esp,0x14
		union pca a = d->addr;
     edc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     edf:	8b 00                	mov    eax,DWORD PTR [eax]
     ee1:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		a.reg_no = PCI_STATUS;
     ee4:	c6 45 fc 06          	mov    BYTE PTR [ebp-0x4],0x6
		if (pci_read_word(a) & PCI_STATUS_INTERRUPT)
     ee8:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     eeb:	89 04 24             	mov    DWORD PTR [esp],eax
     eee:	e8 e2 f1 ff ff       	call   d5 <pci_read_word>
     ef3:	0f b7 c0             	movzx  eax,ax
     ef6:	83 e0 08             	and    eax,0x8
     ef9:	85 c0                	test   eax,eax
     efb:	74 07                	je     f04 <pci_check_interrupt+0x2e>
				return 1;
     efd:	b8 01 00 00 00       	mov    eax,0x1
     f02:	eb 05                	jmp    f09 <pci_check_interrupt+0x33>
		return 0;
     f04:	b8 00 00 00 00       	mov    eax,0x0
}
     f09:	c9                   	leave
     f0a:	c3                   	ret

00000f0b <pci_find_device>:
{
     f0b:	55                   	push   ebp
     f0c:	89 e5                	mov    ebp,esp
     f0e:	83 ec 38             	sub    esp,0x38
     f11:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
     f14:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     f17:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     f1a:	88 4d e4             	mov    BYTE PTR [ebp-0x1c],cl
     f1d:	88 55 e0             	mov    BYTE PTR [ebp-0x20],dl
     f20:	88 45 dc             	mov    BYTE PTR [ebp-0x24],al
		struct dle* d; struct pci_device* rv = NULL;
     f23:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
		lock_list(device_list.devices);
     f2a:	c7 04 24 08 00 00 00 	mov    DWORD PTR [esp],0x8
     f31:	e8 fc ff ff ff       	call   f32 <pci_find_device+0x27>
		list_for_each_entry(d, &device_list.devices, devices) {
     f36:	a1 04 00 00 00       	mov    eax,ds:0x4
     f3b:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
     f3e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     f41:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     f44:	eb 51                	jmp    f97 <pci_find_device+0x8c>
				if (d->dev.device_class == cls && d->dev.device_subclass == subcls) {
     f46:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     f49:	0f b6 40 10          	movzx  eax,BYTE PTR [eax+0x10]
     f4d:	38 45 e4             	cmp    BYTE PTR [ebp-0x1c],al
     f50:	75 36                	jne    f88 <pci_find_device+0x7d>
     f52:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     f55:	0f b6 40 11          	movzx  eax,BYTE PTR [eax+0x11]
     f59:	38 45 e0             	cmp    BYTE PTR [ebp-0x20],al
     f5c:	75 2a                	jne    f88 <pci_find_device+0x7d>
						if (d->dev.device_interface == ifc || ifc == 0xff) {
     f5e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     f61:	0f b6 40 12          	movzx  eax,BYTE PTR [eax+0x12]
     f65:	38 45 dc             	cmp    BYTE PTR [ebp-0x24],al
     f68:	74 06                	je     f70 <pci_find_device+0x65>
     f6a:	80 7d dc ff          	cmp    BYTE PTR [ebp-0x24],0xff
     f6e:	75 18                	jne    f88 <pci_find_device+0x7d>
								if (!ct--) {
     f70:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     f73:	8d 50 ff             	lea    edx,[eax-0x1]
     f76:	89 55 14             	mov    DWORD PTR [ebp+0x14],edx
     f79:	85 c0                	test   eax,eax
     f7b:	75 0b                	jne    f88 <pci_find_device+0x7d>
										rv = &d->dev;
     f7d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     f80:	83 c0 0c             	add    eax,0xc
     f83:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
										goto exit;
     f86:	eb 19                	jmp    fa1 <pci_find_device+0x96>
		list_for_each_entry(d, &device_list.devices, devices) {
     f88:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     f8b:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     f8e:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
     f91:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     f94:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     f97:	81 7d f4 00 00 00 00 	cmp    DWORD PTR [ebp-0xc],0x0
     f9e:	75 a6                	jne    f46 <pci_find_device+0x3b>
exit:
     fa0:	90                   	nop
		unlock_list(device_list.devices);
     fa1:	c7 04 24 08 00 00 00 	mov    DWORD PTR [esp],0x8
     fa8:	e8 fc ff ff ff       	call   fa9 <pci_find_device+0x9e>
		return rv;
     fad:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
}
     fb0:	c9                   	leave
     fb1:	c3                   	ret

00000fb2 <pci_set_bar>:
{
     fb2:	55                   	push   ebp
     fb3:	89 e5                	mov    ebp,esp
     fb5:	56                   	push   esi
     fb6:	53                   	push   ebx
     fb7:	83 ec 20             	sub    esp,0x20
     fba:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     fbd:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
     fc0:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     fc3:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		union pca addr = dev->addr;
     fc6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     fc9:	8b 00                	mov    eax,DWORD PTR [eax]
     fcb:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		if (i > 5)
     fce:	83 7d 0c 05          	cmp    DWORD PTR [ebp+0xc],0x5
     fd2:	0f 87 77 02 00 00    	ja     124f <pci_set_bar+0x29d>
		addr.reg_no = PCI_BASE_ADDRESS_0 + i * 4;
     fd8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     fdb:	83 c0 04             	add    eax,0x4
     fde:	c1 e0 02             	shl    eax,0x2
     fe1:	88 45 f0             	mov    BYTE PTR [ebp-0x10],al
		dat = pci_read(addr);
     fe4:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     fe7:	89 04 24             	mov    DWORD PTR [esp],eax
     fea:	e8 ba f0 ff ff       	call   a9 <pci_read>
     fef:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if ((dat & 0xf) != tp) /* only I/O space for those */
     ff2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     ff5:	83 e0 0f             	and    eax,0xf
     ff8:	39 45 10             	cmp    DWORD PTR [ebp+0x10],eax
     ffb:	0f 85 51 02 00 00    	jne    1252 <pci_set_bar+0x2a0>
		if (i > 5 || ((tp & PCI_BAR_64_BIT) && i == 5))
    1001:	83 7d 0c 05          	cmp    DWORD PTR [ebp+0xc],0x5
    1005:	0f 87 4a 02 00 00    	ja     1255 <pci_set_bar+0x2a3>
    100b:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    100e:	83 e0 04             	and    eax,0x4
    1011:	85 c0                	test   eax,eax
    1013:	74 0a                	je     101f <pci_set_bar+0x6d>
    1015:	83 7d 0c 05          	cmp    DWORD PTR [ebp+0xc],0x5
    1019:	0f 84 36 02 00 00    	je     1255 <pci_set_bar+0x2a3>
		if (tp & PCI_BAR_PIO) {
    101f:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1022:	83 e0 01             	and    eax,0x1
    1025:	85 c0                	test   eax,eax
    1027:	74 59                	je     1082 <pci_set_bar+0xd0>
				dat = (dat & 0x3) | ((uint32_t)ofs & 0xfffc);
    1029:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    102c:	83 e0 03             	and    eax,0x3
    102f:	89 c2                	mov    edx,eax
    1031:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1034:	25 fc ff 00 00       	and    eax,0xfffc
    1039:	09 d0                	or     eax,edx
    103b:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				pci_write(addr, dat);
    103e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1041:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1045:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1048:	89 04 24             	mov    DWORD PTR [esp],eax
    104b:	e8 4a f1 ff ff       	call   19a <pci_write>
				dat = pci_read(addr);
    1050:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1053:	89 04 24             	mov    DWORD PTR [esp],eax
    1056:	e8 4e f0 ff ff       	call   a9 <pci_read>
    105b:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				dev->ressources[i].pio.base = (dat & 0xfffc);
    105e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1061:	83 e0 fc             	and    eax,0xfffffffc
    1064:	89 c1                	mov    ecx,eax
    1066:	8b 5d 08             	mov    ebx,DWORD PTR [ebp+0x8]
    1069:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    106c:	89 d0                	mov    eax,edx
    106e:	01 c0                	add    eax,eax
    1070:	01 d0                	add    eax,edx
    1072:	c1 e0 03             	shl    eax,0x3
    1075:	01 d8                	add    eax,ebx
    1077:	83 c0 28             	add    eax,0x28
    107a:	66 89 08             	mov    WORD PTR [eax],cx
    107d:	e9 d4 01 00 00       	jmp    1256 <pci_set_bar+0x2a4>
		} else if (tp & PCI_BAR_16_BIT) {
    1082:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1085:	83 e0 02             	and    eax,0x2
    1088:	85 c0                	test   eax,eax
    108a:	74 6a                	je     10f6 <pci_set_bar+0x144>
				dat = (dat & 0xf) | ((uint32_t)ofs & 0x0000fff0);
    108c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    108f:	83 e0 0f             	and    eax,0xf
    1092:	89 c2                	mov    edx,eax
    1094:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1097:	25 f0 ff 00 00       	and    eax,0xfff0
    109c:	09 d0                	or     eax,edx
    109e:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				pci_write(addr, dat);
    10a1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    10a4:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    10a8:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    10ab:	89 04 24             	mov    DWORD PTR [esp],eax
    10ae:	e8 e7 f0 ff ff       	call   19a <pci_write>
				dat = pci_read(addr);
    10b3:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    10b6:	89 04 24             	mov    DWORD PTR [esp],eax
    10b9:	e8 eb ef ff ff       	call   a9 <pci_read>
    10be:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				dev->ressources[i].mmio.base = (dat & 0xfff0);
    10c1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    10c4:	ba 00 00 00 00       	mov    edx,0x0
    10c9:	25 f0 ff 00 00       	and    eax,0xfff0
    10ce:	ba 00 00 00 00       	mov    edx,0x0
    10d3:	89 c1                	mov    ecx,eax
    10d5:	89 d3                	mov    ebx,edx
    10d7:	8b 75 08             	mov    esi,DWORD PTR [ebp+0x8]
    10da:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    10dd:	89 d0                	mov    eax,edx
    10df:	01 c0                	add    eax,eax
    10e1:	01 d0                	add    eax,edx
    10e3:	c1 e0 03             	shl    eax,0x3
    10e6:	01 f0                	add    eax,esi
    10e8:	83 c0 20             	add    eax,0x20
    10eb:	89 48 08             	mov    DWORD PTR [eax+0x8],ecx
    10ee:	89 58 0c             	mov    DWORD PTR [eax+0xc],ebx
    10f1:	e9 60 01 00 00       	jmp    1256 <pci_set_bar+0x2a4>
		} else if (tp & PCI_BAR_64_BIT) {
    10f6:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    10f9:	83 e0 04             	and    eax,0x4
    10fc:	85 c0                	test   eax,eax
    10fe:	0f 84 e8 00 00 00    	je     11ec <pci_set_bar+0x23a>
				dat = (dat & 0xf) | ((uint32_t)ofs & 0xfffffff0);
    1104:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1107:	83 e0 0f             	and    eax,0xf
    110a:	89 c2                	mov    edx,eax
    110c:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    110f:	83 e0 f0             	and    eax,0xfffffff0
    1112:	09 d0                	or     eax,edx
    1114:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				pci_write(addr, dat);
    1117:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    111a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    111e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1121:	89 04 24             	mov    DWORD PTR [esp],eax
    1124:	e8 71 f0 ff ff       	call   19a <pci_write>
				addr.reg_no += 4;
    1129:	0f b6 45 f0          	movzx  eax,BYTE PTR [ebp-0x10]
    112d:	83 c0 04             	add    eax,0x4
    1130:	88 45 f0             	mov    BYTE PTR [ebp-0x10],al
				dat = (uint32_t)(ofs >> 32);
    1133:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1136:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    1139:	89 d0                	mov    eax,edx
    113b:	31 d2                	xor    edx,edx
    113d:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				pci_write(addr, dat);
    1140:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1143:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1147:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    114a:	89 04 24             	mov    DWORD PTR [esp],eax
    114d:	e8 48 f0 ff ff       	call   19a <pci_write>
				dat = pci_read(addr);
    1152:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1155:	89 04 24             	mov    DWORD PTR [esp],eax
    1158:	e8 4c ef ff ff       	call   a9 <pci_read>
    115d:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				dev->ressources[i].mmio.base = (uint64_t)dat << 32;
    1160:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1163:	ba 00 00 00 00       	mov    edx,0x0
    1168:	89 c2                	mov    edx,eax
    116a:	31 c0                	xor    eax,eax
    116c:	89 c1                	mov    ecx,eax
    116e:	89 d3                	mov    ebx,edx
    1170:	8b 75 08             	mov    esi,DWORD PTR [ebp+0x8]
    1173:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    1176:	89 d0                	mov    eax,edx
    1178:	01 c0                	add    eax,eax
    117a:	01 d0                	add    eax,edx
    117c:	c1 e0 03             	shl    eax,0x3
    117f:	01 f0                	add    eax,esi
    1181:	83 c0 20             	add    eax,0x20
    1184:	89 48 08             	mov    DWORD PTR [eax+0x8],ecx
    1187:	89 58 0c             	mov    DWORD PTR [eax+0xc],ebx
				addr.reg_no -= 4;
    118a:	0f b6 45 f0          	movzx  eax,BYTE PTR [ebp-0x10]
    118e:	83 e8 04             	sub    eax,0x4
    1191:	88 45 f0             	mov    BYTE PTR [ebp-0x10],al
				dat = pci_read(addr);
    1194:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1197:	89 04 24             	mov    DWORD PTR [esp],eax
    119a:	e8 0a ef ff ff       	call   a9 <pci_read>
    119f:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				dev->ressources[i].mmio.base |= (dat & 0xfffffff0);
    11a2:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    11a5:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    11a8:	89 d0                	mov    eax,edx
    11aa:	01 c0                	add    eax,eax
    11ac:	01 d0                	add    eax,edx
    11ae:	c1 e0 03             	shl    eax,0x3
    11b1:	01 c8                	add    eax,ecx
    11b3:	83 c0 20             	add    eax,0x20
    11b6:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    11b9:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    11bc:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    11bf:	bb 00 00 00 00       	mov    ebx,0x0
    11c4:	83 e1 f0             	and    ecx,0xfffffff0
    11c7:	bb 00 00 00 00       	mov    ebx,0x0
    11cc:	09 c1                	or     ecx,eax
    11ce:	09 d3                	or     ebx,edx
    11d0:	8b 75 08             	mov    esi,DWORD PTR [ebp+0x8]
    11d3:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    11d6:	89 d0                	mov    eax,edx
    11d8:	01 c0                	add    eax,eax
    11da:	01 d0                	add    eax,edx
    11dc:	c1 e0 03             	shl    eax,0x3
    11df:	01 f0                	add    eax,esi
    11e1:	83 c0 20             	add    eax,0x20
    11e4:	89 48 08             	mov    DWORD PTR [eax+0x8],ecx
    11e7:	89 58 0c             	mov    DWORD PTR [eax+0xc],ebx
    11ea:	eb 6a                	jmp    1256 <pci_set_bar+0x2a4>
				dat = (dat & 0xf) | ((uint32_t)ofs & 0xfffffff0);
    11ec:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    11ef:	83 e0 0f             	and    eax,0xf
    11f2:	89 c2                	mov    edx,eax
    11f4:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    11f7:	83 e0 f0             	and    eax,0xfffffff0
    11fa:	09 d0                	or     eax,edx
    11fc:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				pci_write(addr, dat);
    11ff:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1202:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1206:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1209:	89 04 24             	mov    DWORD PTR [esp],eax
    120c:	e8 89 ef ff ff       	call   19a <pci_write>
				dat = pci_read(addr);
    1211:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1214:	89 04 24             	mov    DWORD PTR [esp],eax
    1217:	e8 8d ee ff ff       	call   a9 <pci_read>
    121c:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				dev->ressources[i].mmio.base = (dat & 0xfffffff0);
    121f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1222:	ba 00 00 00 00       	mov    edx,0x0
    1227:	83 e0 f0             	and    eax,0xfffffff0
    122a:	ba 00 00 00 00       	mov    edx,0x0
    122f:	89 c1                	mov    ecx,eax
    1231:	89 d3                	mov    ebx,edx
    1233:	8b 75 08             	mov    esi,DWORD PTR [ebp+0x8]
    1236:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    1239:	89 d0                	mov    eax,edx
    123b:	01 c0                	add    eax,eax
    123d:	01 d0                	add    eax,edx
    123f:	c1 e0 03             	shl    eax,0x3
    1242:	01 f0                	add    eax,esi
    1244:	83 c0 20             	add    eax,0x20
    1247:	89 48 08             	mov    DWORD PTR [eax+0x8],ecx
    124a:	89 58 0c             	mov    DWORD PTR [eax+0xc],ebx
    124d:	eb 07                	jmp    1256 <pci_set_bar+0x2a4>
				return;
    124f:	90                   	nop
    1250:	eb 04                	jmp    1256 <pci_set_bar+0x2a4>
				return;
    1252:	90                   	nop
    1253:	eb 01                	jmp    1256 <pci_set_bar+0x2a4>
				return;
    1255:	90                   	nop
}
    1256:	83 c4 20             	add    esp,0x20
    1259:	5b                   	pop    ebx
    125a:	5e                   	pop    esi
    125b:	5d                   	pop    ebp
    125c:	c3                   	ret

0000125d <pci_bar_get_size>:
{
    125d:	55                   	push   ebp
    125e:	89 e5                	mov    ebp,esp
    1260:	83 ec 28             	sub    esp,0x28
		union pca a = d->addr; uint32_t dat, datH;
    1263:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1266:	8b 00                	mov    eax,DWORD PTR [eax]
    1268:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		uint64_t rv = 0;
    126b:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [ebp-0x8],0x0
    1272:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
		if (i > 5)
    1279:	83 7d 0c 05          	cmp    DWORD PTR [ebp+0xc],0x5
    127d:	76 0f                	jbe    128e <pci_bar_get_size+0x31>
				return 0;
    127f:	b8 00 00 00 00       	mov    eax,0x0
    1284:	ba 00 00 00 00       	mov    edx,0x0
    1289:	e9 75 01 00 00       	jmp    1403 <pci_bar_get_size+0x1a6>
		a.reg_no = PCI_BASE_ADDRESS_0 + i * 4;
    128e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1291:	83 c0 04             	add    eax,0x4
    1294:	c1 e0 02             	shl    eax,0x2
    1297:	88 45 e8             	mov    BYTE PTR [ebp-0x18],al
		dat = pci_read(a);
    129a:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    129d:	89 04 24             	mov    DWORD PTR [esp],eax
    12a0:	e8 04 ee ff ff       	call   a9 <pci_read>
    12a5:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (dat & 1) { /* PIO */
    12a8:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    12ab:	83 e0 01             	and    eax,0x1
    12ae:	85 c0                	test   eax,eax
    12b0:	74 59                	je     130b <pci_bar_get_size+0xae>
				pci_write(a, 0xffff);
    12b2:	c7 44 24 04 ff ff 00 00 	mov    DWORD PTR [esp+0x4],0xffff
    12ba:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    12bd:	89 04 24             	mov    DWORD PTR [esp],eax
    12c0:	e8 d5 ee ff ff       	call   19a <pci_write>
				rv = pci_read(a) & 0xfffc;
    12c5:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    12c8:	89 04 24             	mov    DWORD PTR [esp],eax
    12cb:	e8 d9 ed ff ff       	call   a9 <pci_read>
    12d0:	ba 00 00 00 00       	mov    edx,0x0
    12d5:	25 fc ff 00 00       	and    eax,0xfffc
    12da:	ba 00 00 00 00       	mov    edx,0x0
    12df:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
    12e2:	89 55 fc             	mov    DWORD PTR [ebp-0x4],edx
				pci_write(a, dat);
    12e5:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    12e8:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    12ec:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    12ef:	89 04 24             	mov    DWORD PTR [esp],eax
    12f2:	e8 a3 ee ff ff       	call   19a <pci_write>
				rv = (uint64_t)(~(uint16_t)rv + 1);
    12f7:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    12fa:	0f b7 c0             	movzx  eax,ax
    12fd:	f7 d8                	neg    eax
    12ff:	99                   	cdq
    1300:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
    1303:	89 55 fc             	mov    DWORD PTR [ebp-0x4],edx
    1306:	e9 f2 00 00 00       	jmp    13fd <pci_bar_get_size+0x1a0>
				uint32_t tp = (dat >> 1) & 0x3;
    130b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    130e:	d1 e8                	shr    eax,1
    1310:	83 e0 03             	and    eax,0x3
    1313:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				if (tp == 2) {
    1316:	83 7d f0 02          	cmp    DWORD PTR [ebp-0x10],0x2
    131a:	75 6b                	jne    1387 <pci_bar_get_size+0x12a>
						a.reg_no += 4;
    131c:	0f b6 45 e8          	movzx  eax,BYTE PTR [ebp-0x18]
    1320:	83 c0 04             	add    eax,0x4
    1323:	88 45 e8             	mov    BYTE PTR [ebp-0x18],al
						datH = pci_read(a);
    1326:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1329:	89 04 24             	mov    DWORD PTR [esp],eax
    132c:	e8 78 ed ff ff       	call   a9 <pci_read>
    1331:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
						pci_write(a, 0xffffffff);
    1334:	c7 44 24 04 ff ff ff ff 	mov    DWORD PTR [esp+0x4],0xffffffff
    133c:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    133f:	89 04 24             	mov    DWORD PTR [esp],eax
    1342:	e8 53 ee ff ff       	call   19a <pci_write>
						a.reg_no -= 4;
    1347:	0f b6 45 e8          	movzx  eax,BYTE PTR [ebp-0x18]
    134b:	83 e8 04             	sub    eax,0x4
    134e:	88 45 e8             	mov    BYTE PTR [ebp-0x18],al
						rv = (uint64_t)pci_read(a) << 32;
    1351:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1354:	89 04 24             	mov    DWORD PTR [esp],eax
    1357:	e8 4d ed ff ff       	call   a9 <pci_read>
    135c:	ba 00 00 00 00       	mov    edx,0x0
    1361:	89 c2                	mov    edx,eax
    1363:	31 c0                	xor    eax,eax
    1365:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
    1368:	89 55 fc             	mov    DWORD PTR [ebp-0x4],edx
						pci_write(a, datH);
    136b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    136e:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1372:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1375:	89 04 24             	mov    DWORD PTR [esp],eax
    1378:	e8 1d ee ff ff       	call   19a <pci_write>
						a.reg_no -= 4;
    137d:	0f b6 45 e8          	movzx  eax,BYTE PTR [ebp-0x18]
    1381:	83 e8 04             	sub    eax,0x4
    1384:	88 45 e8             	mov    BYTE PTR [ebp-0x18],al
				pci_write(a, 0xffffffff);
    1387:	c7 44 24 04 ff ff ff ff 	mov    DWORD PTR [esp+0x4],0xffffffff
    138f:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1392:	89 04 24             	mov    DWORD PTR [esp],eax
    1395:	e8 00 ee ff ff       	call   19a <pci_write>
				rv |= (pci_read(a) & 0xfffffff0);
    139a:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    139d:	89 04 24             	mov    DWORD PTR [esp],eax
    13a0:	e8 04 ed ff ff       	call   a9 <pci_read>
    13a5:	83 e0 f0             	and    eax,0xfffffff0
    13a8:	ba 00 00 00 00       	mov    edx,0x0
    13ad:	09 45 f8             	or     DWORD PTR [ebp-0x8],eax
    13b0:	09 55 fc             	or     DWORD PTR [ebp-0x4],edx
				pci_write(a, dat);
    13b3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    13b6:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    13ba:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    13bd:	89 04 24             	mov    DWORD PTR [esp],eax
    13c0:	e8 d5 ed ff ff       	call   19a <pci_write>
				if (tp == 2) {
    13c5:	83 7d f0 02          	cmp    DWORD PTR [ebp-0x10],0x2
    13c9:	75 0c                	jne    13d7 <pci_bar_get_size+0x17a>
						rv = ~rv + 1;
    13cb:	f7 5d f8             	neg    DWORD PTR [ebp-0x8]
    13ce:	83 55 fc 00          	adc    DWORD PTR [ebp-0x4],0x0
    13d2:	f7 5d fc             	neg    DWORD PTR [ebp-0x4]
    13d5:	eb 26                	jmp    13fd <pci_bar_get_size+0x1a0>
				} else if (tp == 1) {
    13d7:	83 7d f0 01          	cmp    DWORD PTR [ebp-0x10],0x1
    13db:	75 11                	jne    13ee <pci_bar_get_size+0x191>
						rv = (uint64_t)(~(uint16_t)rv + 1);
    13dd:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    13e0:	0f b7 c0             	movzx  eax,ax
    13e3:	f7 d8                	neg    eax
    13e5:	99                   	cdq
    13e6:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
    13e9:	89 55 fc             	mov    DWORD PTR [ebp-0x4],edx
    13ec:	eb 0f                	jmp    13fd <pci_bar_get_size+0x1a0>
						rv = (uint64_t)(~(uint32_t)rv + 1);
    13ee:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    13f1:	f7 d8                	neg    eax
    13f3:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
    13f6:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
		return rv;
    13fd:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
    1400:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
}
    1403:	c9                   	leave
    1404:	c3                   	ret

00001405 <pci_init_msi>:
{
    1405:	55                   	push   ebp
    1406:	89 e5                	mov    ebp,esp
    1408:	83 ec 38             	sub    esp,0x38
		uint32_t dat; union pca a = d->addr;
    140b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    140e:	8b 00                	mov    eax,DWORD PTR [eax]
    1410:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		if (!(a.reg_no = d->cap_ptrs[PCI_CAP_ID_MSI]))
    1413:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1416:	0f b6 40 13          	movzx  eax,BYTE PTR [eax+0x13]
    141a:	88 45 e8             	mov    BYTE PTR [ebp-0x18],al
    141d:	0f b6 45 e8          	movzx  eax,BYTE PTR [ebp-0x18]
    1421:	84 c0                	test   al,al
    1423:	0f 84 d9 00 00 00    	je     1502 <pci_init_msi+0xfd>
		dat = pci_read(a);
    1429:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    142c:	89 04 24             	mov    DWORD PTR [esp],eax
    142f:	e8 75 ec ff ff       	call   a9 <pci_read>
    1434:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		n_c = (dat >> 1) & 0x7;
    1437:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    143a:	d1 e8                	shr    eax,1
    143c:	83 e0 07             	and    eax,0x7
    143f:	88 45 ef             	mov    BYTE PTR [ebp-0x11],al
		n_e = (dat >> 4) & 0x7;
    1442:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1445:	c1 e8 04             	shr    eax,0x4
    1448:	83 e0 07             	and    eax,0x7
    144b:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
		cprintf(KFMT_INFO, "MSI cap: %u capable %u enable and status %u\n",
    144e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1451:	83 e0 01             	and    eax,0x1
    1454:	89 c1                	mov    ecx,eax
    1456:	0f b6 55 f7          	movzx  edx,BYTE PTR [ebp-0x9]
    145a:	0f b6 45 ef          	movzx  eax,BYTE PTR [ebp-0x11]
    145e:	89 4c 24 10          	mov    DWORD PTR [esp+0x10],ecx
    1462:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    1466:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    146a:	c7 44 24 04 c8 11 00 00 	mov    DWORD PTR [esp+0x4],0x11c8
    1472:	c7 04 24 0b 00 00 00 	mov    DWORD PTR [esp],0xb
    1479:	e8 fc ff ff ff       	call   147a <pci_init_msi+0x75>
		if (n_e > 3) /* >8 */
    147e:	80 7d f7 03          	cmp    BYTE PTR [ebp-0x9],0x3
    1482:	76 04                	jbe    1488 <pci_init_msi+0x83>
				n_e = 3;
    1484:	c6 45 f7 03          	mov    BYTE PTR [ebp-0x9],0x3
		dat = (dat & 0xffffff8e) | (n_e << 4);
    1488:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    148b:	83 e0 8e             	and    eax,0xffffff8e
    148e:	89 c2                	mov    edx,eax
    1490:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
    1494:	c1 e0 04             	shl    eax,0x4
    1497:	09 d0                	or     eax,edx
    1499:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		pci_write(a, dat);
    149c:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    149f:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    14a3:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    14a6:	89 04 24             	mov    DWORD PTR [esp],eax
    14a9:	e8 ec ec ff ff       	call   19a <pci_write>
		if (pci_read(a) != dat) {
    14ae:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    14b1:	89 04 24             	mov    DWORD PTR [esp],eax
    14b4:	e8 f0 eb ff ff       	call   a9 <pci_read>
    14b9:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
    14bc:	74 45                	je     1503 <pci_init_msi+0xfe>
				cprintf(KFMT_WARN, "Failed to configure PCI MSI data.\n");
    14be:	c7 44 24 04 f8 11 00 00 	mov    DWORD PTR [esp+0x4],0x11f8
    14c6:	c7 04 24 0e 00 00 00 	mov    DWORD PTR [esp],0xe
    14cd:	e8 fc ff ff ff       	call   14ce <pci_init_msi+0xc9>
				printf("%08x vs %08x\n", dat, pci_read(a));
    14d2:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    14d5:	89 04 24             	mov    DWORD PTR [esp],eax
    14d8:	e8 cc eb ff ff       	call   a9 <pci_read>
    14dd:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    14e1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    14e4:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    14e8:	c7 04 24 1b 12 00 00 	mov    DWORD PTR [esp],0x121b
    14ef:	e8 fc ff ff ff       	call   14f0 <pci_init_msi+0xeb>
				mdelay(1000);
    14f4:	c7 04 24 e8 03 00 00 	mov    DWORD PTR [esp],0x3e8
    14fb:	e8 fc ff ff ff       	call   14fc <pci_init_msi+0xf7>
    1500:	eb 01                	jmp    1503 <pci_init_msi+0xfe>
				return; /* no MSI */
    1502:	90                   	nop
}
    1503:	c9                   	leave
    1504:	c3                   	ret

00001505 <pci_add_caps>:
{
    1505:	55                   	push   ebp
    1506:	89 e5                	mov    ebp,esp
    1508:	83 ec 28             	sub    esp,0x28
		union pca a = d->addr; /* 5h MSI, 10h PCIe, 14h MSI-X */
    150b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    150e:	8b 00                	mov    eax,DWORD PTR [eax]
    1510:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		a.reg_no = PCI_STATUS;
    1513:	c6 45 f0 06          	mov    BYTE PTR [ebp-0x10],0x6
		dat = pci_read_word(a);
    1517:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    151a:	89 04 24             	mov    DWORD PTR [esp],eax
    151d:	e8 b3 eb ff ff       	call   d5 <pci_read_word>
    1522:	0f b7 c0             	movzx  eax,ax
    1525:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!(dat & PCI_STATUS_CAP_LIST))
    1528:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    152b:	83 e0 10             	and    eax,0x10
    152e:	85 c0                	test   eax,eax
    1530:	0f 84 b1 00 00 00    	je     15e7 <pci_add_caps+0xe2>
		a.reg_no = ((d->device_type & 0x7f) == 2) ? PCI_CB_CAPABILITY_LIST
    1536:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1539:	0f b6 40 07          	movzx  eax,BYTE PTR [eax+0x7]
    153d:	0f b6 c0             	movzx  eax,al
    1540:	83 e0 7f             	and    eax,0x7f
    1543:	83 f8 02             	cmp    eax,0x2
    1546:	75 07                	jne    154f <pci_add_caps+0x4a>
    1548:	b8 14 00 00 00       	mov    eax,0x14
    154d:	eb 05                	jmp    1554 <pci_add_caps+0x4f>
    154f:	b8 34 00 00 00       	mov    eax,0x34
    1554:	88 45 f0             	mov    BYTE PTR [ebp-0x10],al
		a.reg_no = pci_read_byte(a) & 0xfc; /* dword alignment */
    1557:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    155a:	89 04 24             	mov    DWORD PTR [esp],eax
    155d:	e8 00 ec ff ff       	call   162 <pci_read_byte>
    1562:	83 e0 fc             	and    eax,0xfffffffc
    1565:	88 45 f0             	mov    BYTE PTR [ebp-0x10],al
		while (a.reg_no <= 192 - 4) { /* valid capability ranges */
    1568:	eb 73                	jmp    15dd <pci_add_caps+0xd8>
				cap.val = pci_read(a);
    156a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    156d:	89 04 24             	mov    DWORD PTR [esp],eax
    1570:	e8 34 eb ff ff       	call   a9 <pci_read>
    1575:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				if (!(cap.cap > PCI_CAP_ID_MAX))
    1578:	0f b6 45 ec          	movzx  eax,BYTE PTR [ebp-0x14]
    157c:	3c 13                	cmp    al,0x13
    157e:	77 12                	ja     1592 <pci_add_caps+0x8d>
						d->cap_ptrs[cap.cap] = a.reg_no;
    1580:	0f b6 45 ec          	movzx  eax,BYTE PTR [ebp-0x14]
    1584:	0f b6 c0             	movzx  eax,al
    1587:	0f b6 4d f0          	movzx  ecx,BYTE PTR [ebp-0x10]
    158b:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    158e:	88 4c 02 0e          	mov    BYTE PTR [edx+eax*1+0xe],cl
				switch (cap.cap) {
    1592:	0f b6 45 ec          	movzx  eax,BYTE PTR [ebp-0x14]
    1596:	0f b6 c0             	movzx  eax,al
    1599:	83 f8 11             	cmp    eax,0x11
    159c:	74 26                	je     15c4 <pci_add_caps+0xbf>
    159e:	83 f8 11             	cmp    eax,0x11
    15a1:	7f 28                	jg     15cb <pci_add_caps+0xc6>
    15a3:	83 f8 07             	cmp    eax,0x7
    15a6:	74 1f                	je     15c7 <pci_add_caps+0xc2>
    15a8:	83 f8 07             	cmp    eax,0x7
    15ab:	7f 1e                	jg     15cb <pci_add_caps+0xc6>
    15ad:	83 f8 01             	cmp    eax,0x1
    15b0:	74 18                	je     15ca <pci_add_caps+0xc5>
    15b2:	83 f8 05             	cmp    eax,0x5
    15b5:	75 14                	jne    15cb <pci_add_caps+0xc6>
								pci_init_msi(d);
    15b7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    15ba:	89 04 24             	mov    DWORD PTR [esp],eax
    15bd:	e8 fc ff ff ff       	call   15be <pci_add_caps+0xb9>
								break;
    15c2:	eb 07                	jmp    15cb <pci_add_caps+0xc6>
								break;
    15c4:	90                   	nop
    15c5:	eb 04                	jmp    15cb <pci_add_caps+0xc6>
								break;
    15c7:	90                   	nop
    15c8:	eb 01                	jmp    15cb <pci_add_caps+0xc6>
								break;
    15ca:	90                   	nop
				if (!(a.reg_no = (cap.next & 0xfc))) /* end of list */
    15cb:	0f b6 45 ed          	movzx  eax,BYTE PTR [ebp-0x13]
    15cf:	83 e0 fc             	and    eax,0xfffffffc
    15d2:	88 45 f0             	mov    BYTE PTR [ebp-0x10],al
    15d5:	0f b6 45 f0          	movzx  eax,BYTE PTR [ebp-0x10]
    15d9:	84 c0                	test   al,al
    15db:	74 0d                	je     15ea <pci_add_caps+0xe5>
		while (a.reg_no <= 192 - 4) { /* valid capability ranges */
    15dd:	0f b6 45 f0          	movzx  eax,BYTE PTR [ebp-0x10]
    15e1:	3c bc                	cmp    al,0xbc
    15e3:	76 85                	jbe    156a <pci_add_caps+0x65>
    15e5:	eb 04                	jmp    15eb <pci_add_caps+0xe6>
				return; /* we don't have to look for it */
    15e7:	90                   	nop
    15e8:	eb 01                	jmp    15eb <pci_add_caps+0xe6>
						break;
    15ea:	90                   	nop
}
    15eb:	c9                   	leave
    15ec:	c3                   	ret

000015ed <pci_add_bars>:
{
    15ed:	55                   	push   ebp
    15ee:	89 e5                	mov    ebp,esp
    15f0:	56                   	push   esi
    15f1:	53                   	push   ebx
    15f2:	83 ec 38             	sub    esp,0x38
		union pca a = d->addr;
    15f5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    15f8:	8b 00                	mov    eax,DWORD PTR [eax]
    15fa:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
		uint8_t t = d->device_type & 0x7f;
    15fd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1600:	0f b6 40 07          	movzx  eax,BYTE PTR [eax+0x7]
    1604:	83 e0 7f             	and    eax,0x7f
    1607:	88 45 ef             	mov    BYTE PTR [ebp-0x11],al
		if (t == 0 || t == 1) { /* the regular 6/2 BARs */
    160a:	80 7d ef 00          	cmp    BYTE PTR [ebp-0x11],0x0
    160e:	74 0a                	je     161a <pci_add_bars+0x2d>
    1610:	80 7d ef 01          	cmp    BYTE PTR [ebp-0x11],0x1
    1614:	0f 85 7e 02 00 00    	jne    1898 <pci_add_bars+0x2ab>
				int limit = d->device_type ? 2 : 6;
    161a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    161d:	0f b6 40 07          	movzx  eax,BYTE PTR [eax+0x7]
    1621:	84 c0                	test   al,al
    1623:	74 07                	je     162c <pci_add_bars+0x3f>
    1625:	b8 02 00 00 00       	mov    eax,0x2
    162a:	eb 05                	jmp    1631 <pci_add_bars+0x44>
    162c:	b8 06 00 00 00       	mov    eax,0x6
    1631:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
				a.reg_no = PCI_BASE_ADDRESS_0;
    1634:	c6 45 d4 10          	mov    BYTE PTR [ebp-0x2c],0x10
				for (int i = 0; i < limit; i++) {
    1638:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    163f:	e9 43 02 00 00       	jmp    1887 <pci_add_bars+0x29a>
						uint32_t dat = pci_read(a);
    1644:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1647:	89 04 24             	mov    DWORD PTR [esp],eax
    164a:	e8 5a ea ff ff       	call   a9 <pci_read>
    164f:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
						if (dat & 1) { /* I/O space */
    1652:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1655:	83 e0 01             	and    eax,0x1
    1658:	85 c0                	test   eax,eax
    165a:	0f 84 82 00 00 00    	je     16e2 <pci_add_bars+0xf5>
								d->ressources[i].type = PCI_BAR_PIO;
    1660:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    1663:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1666:	89 d0                	mov    eax,edx
    1668:	01 c0                	add    eax,eax
    166a:	01 d0                	add    eax,edx
    166c:	c1 e0 03             	shl    eax,0x3
    166f:	01 c8                	add    eax,ecx
    1671:	83 c0 24             	add    eax,0x24
    1674:	c7 00 01 00 00 00    	mov    DWORD PTR [eax],0x1
								d->ressources[i].pio.base = dat & 0xfffc;
    167a:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    167d:	83 e0 fc             	and    eax,0xfffffffc
    1680:	89 c1                	mov    ecx,eax
    1682:	8b 5d 08             	mov    ebx,DWORD PTR [ebp+0x8]
    1685:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1688:	89 d0                	mov    eax,edx
    168a:	01 c0                	add    eax,eax
    168c:	01 d0                	add    eax,edx
    168e:	c1 e0 03             	shl    eax,0x3
    1691:	01 d8                	add    eax,ebx
    1693:	83 c0 28             	add    eax,0x28
    1696:	66 89 08             	mov    WORD PTR [eax],cx
								d->ressources[i].pio.count = 0;
    1699:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    169c:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    169f:	89 d0                	mov    eax,edx
    16a1:	01 c0                	add    eax,eax
    16a3:	01 d0                	add    eax,edx
    16a5:	c1 e0 03             	shl    eax,0x3
    16a8:	01 c8                	add    eax,ecx
    16aa:	83 c0 2a             	add    eax,0x2a
    16ad:	66 c7 00 00 00       	mov    WORD PTR [eax],0x0
										d->ressources[i].pio.count = pci_bar_get_size(d, i);
    16b2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    16b5:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    16b9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    16bc:	89 04 24             	mov    DWORD PTR [esp],eax
    16bf:	e8 fc ff ff ff       	call   16c0 <pci_add_bars+0xd3>
    16c4:	89 c3                	mov    ebx,eax
    16c6:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    16c9:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    16cc:	89 d0                	mov    eax,edx
    16ce:	01 c0                	add    eax,eax
    16d0:	01 d0                	add    eax,edx
    16d2:	c1 e0 03             	shl    eax,0x3
    16d5:	01 c8                	add    eax,ecx
    16d7:	83 c0 2a             	add    eax,0x2a
    16da:	66 89 18             	mov    WORD PTR [eax],bx
    16dd:	e9 97 01 00 00       	jmp    1879 <pci_add_bars+0x28c>
								uint8_t tp = (dat >> 1) & 0x3;
    16e2:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    16e5:	d1 e8                	shr    eax,1
    16e7:	83 e0 03             	and    eax,0x3
    16ea:	88 45 db             	mov    BYTE PTR [ebp-0x25],al
								d->ressources[i].type = dat & 0xf;
    16ed:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    16f0:	83 e0 0f             	and    eax,0xf
    16f3:	89 c1                	mov    ecx,eax
    16f5:	8b 5d 08             	mov    ebx,DWORD PTR [ebp+0x8]
    16f8:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    16fb:	89 d0                	mov    eax,edx
    16fd:	01 c0                	add    eax,eax
    16ff:	01 d0                	add    eax,edx
    1701:	c1 e0 03             	shl    eax,0x3
    1704:	01 d8                	add    eax,ebx
    1706:	83 c0 24             	add    eax,0x24
    1709:	89 08                	mov    DWORD PTR [eax],ecx
								if (tp == 2) { /* 64-bit */
    170b:	80 7d db 02          	cmp    BYTE PTR [ebp-0x25],0x2
    170f:	0f 85 ca 00 00 00    	jne    17df <pci_add_bars+0x1f2>
										d->ressources[i].mmio.base = dat & 0xfffffff0;
    1715:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1718:	ba 00 00 00 00       	mov    edx,0x0
    171d:	83 e0 f0             	and    eax,0xfffffff0
    1720:	ba 00 00 00 00       	mov    edx,0x0
    1725:	89 c1                	mov    ecx,eax
    1727:	89 d3                	mov    ebx,edx
    1729:	8b 75 08             	mov    esi,DWORD PTR [ebp+0x8]
    172c:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    172f:	89 d0                	mov    eax,edx
    1731:	01 c0                	add    eax,eax
    1733:	01 d0                	add    eax,edx
    1735:	c1 e0 03             	shl    eax,0x3
    1738:	01 f0                	add    eax,esi
    173a:	83 c0 20             	add    eax,0x20
    173d:	89 48 08             	mov    DWORD PTR [eax+0x8],ecx
    1740:	89 58 0c             	mov    DWORD PTR [eax+0xc],ebx
										d->ressources[i].mmio.size = 0;
    1743:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    1746:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1749:	89 d0                	mov    eax,edx
    174b:	01 c0                	add    eax,eax
    174d:	01 d0                	add    eax,edx
    174f:	c1 e0 03             	shl    eax,0x3
    1752:	01 c8                	add    eax,ecx
    1754:	83 c0 20             	add    eax,0x20
    1757:	c7 40 10 00 00 00 00 	mov    DWORD PTR [eax+0x10],0x0
    175e:	c7 40 14 00 00 00 00 	mov    DWORD PTR [eax+0x14],0x0
										d->ressources[i].mmio.mapping = NULL;
    1765:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    1768:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    176b:	89 d0                	mov    eax,edx
    176d:	01 c0                	add    eax,eax
    176f:	01 d0                	add    eax,edx
    1771:	c1 e0 03             	shl    eax,0x3
    1774:	01 c8                	add    eax,ecx
    1776:	83 c0 38             	add    eax,0x38
    1779:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
										a.reg_no += 4; i++;
    177f:	0f b6 45 d4          	movzx  eax,BYTE PTR [ebp-0x2c]
    1783:	83 c0 04             	add    eax,0x4
    1786:	88 45 d4             	mov    BYTE PTR [ebp-0x2c],al
    1789:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
												((uint64_t)pci_read(a) << 32);
    178d:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1790:	89 04 24             	mov    DWORD PTR [esp],eax
    1793:	e8 11 e9 ff ff       	call   a9 <pci_read>
    1798:	ba 00 00 00 00       	mov    edx,0x0
    179d:	89 c2                	mov    edx,eax
    179f:	31 c0                	xor    eax,eax
    17a1:	89 c1                	mov    ecx,eax
    17a3:	89 d3                	mov    ebx,edx
										d->ressources[i].mmio.base |=
    17a5:	8b 75 08             	mov    esi,DWORD PTR [ebp+0x8]
    17a8:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    17ab:	89 d0                	mov    eax,edx
    17ad:	01 c0                	add    eax,eax
    17af:	01 d0                	add    eax,edx
    17b1:	c1 e0 03             	shl    eax,0x3
    17b4:	01 f0                	add    eax,esi
    17b6:	83 c0 20             	add    eax,0x20
    17b9:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    17bc:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    17bf:	09 c1                	or     ecx,eax
    17c1:	09 d3                	or     ebx,edx
    17c3:	8b 75 08             	mov    esi,DWORD PTR [ebp+0x8]
    17c6:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    17c9:	89 d0                	mov    eax,edx
    17cb:	01 c0                	add    eax,eax
    17cd:	01 d0                	add    eax,edx
    17cf:	c1 e0 03             	shl    eax,0x3
    17d2:	01 f0                	add    eax,esi
    17d4:	83 c0 20             	add    eax,0x20
    17d7:	89 48 08             	mov    DWORD PTR [eax+0x8],ecx
    17da:	89 58 0c             	mov    DWORD PTR [eax+0xc],ebx
    17dd:	eb 6a                	jmp    1849 <pci_add_bars+0x25c>
										d->ressources[i].mmio.base = dat & 0xfffffff0;
    17df:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    17e2:	ba 00 00 00 00       	mov    edx,0x0
    17e7:	83 e0 f0             	and    eax,0xfffffff0
    17ea:	ba 00 00 00 00       	mov    edx,0x0
    17ef:	89 c1                	mov    ecx,eax
    17f1:	89 d3                	mov    ebx,edx
    17f3:	8b 75 08             	mov    esi,DWORD PTR [ebp+0x8]
    17f6:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    17f9:	89 d0                	mov    eax,edx
    17fb:	01 c0                	add    eax,eax
    17fd:	01 d0                	add    eax,edx
    17ff:	c1 e0 03             	shl    eax,0x3
    1802:	01 f0                	add    eax,esi
    1804:	83 c0 20             	add    eax,0x20
    1807:	89 48 08             	mov    DWORD PTR [eax+0x8],ecx
    180a:	89 58 0c             	mov    DWORD PTR [eax+0xc],ebx
										d->ressources[i].mmio.size = 0;
    180d:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    1810:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1813:	89 d0                	mov    eax,edx
    1815:	01 c0                	add    eax,eax
    1817:	01 d0                	add    eax,edx
    1819:	c1 e0 03             	shl    eax,0x3
    181c:	01 c8                	add    eax,ecx
    181e:	83 c0 20             	add    eax,0x20
    1821:	c7 40 10 00 00 00 00 	mov    DWORD PTR [eax+0x10],0x0
    1828:	c7 40 14 00 00 00 00 	mov    DWORD PTR [eax+0x14],0x0
										d->ressources[i].mmio.mapping = NULL;
    182f:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    1832:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1835:	89 d0                	mov    eax,edx
    1837:	01 c0                	add    eax,eax
    1839:	01 d0                	add    eax,edx
    183b:	c1 e0 03             	shl    eax,0x3
    183e:	01 c8                	add    eax,ecx
    1840:	83 c0 38             	add    eax,0x38
    1843:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
										d->ressources[i].mmio.size = pci_bar_get_size(d, i);
    1849:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    184c:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1850:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1853:	89 04 24             	mov    DWORD PTR [esp],eax
    1856:	e8 fc ff ff ff       	call   1857 <pci_add_bars+0x26a>
    185b:	89 c1                	mov    ecx,eax
    185d:	89 d3                	mov    ebx,edx
    185f:	8b 75 08             	mov    esi,DWORD PTR [ebp+0x8]
    1862:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1865:	89 d0                	mov    eax,edx
    1867:	01 c0                	add    eax,eax
    1869:	01 d0                	add    eax,edx
    186b:	c1 e0 03             	shl    eax,0x3
    186e:	01 f0                	add    eax,esi
    1870:	83 c0 20             	add    eax,0x20
    1873:	89 48 10             	mov    DWORD PTR [eax+0x10],ecx
    1876:	89 58 14             	mov    DWORD PTR [eax+0x14],ebx
						a.reg_no += 4;
    1879:	0f b6 45 d4          	movzx  eax,BYTE PTR [ebp-0x2c]
    187d:	83 c0 04             	add    eax,0x4
    1880:	88 45 d4             	mov    BYTE PTR [ebp-0x2c],al
				for (int i = 0; i < limit; i++) {
    1883:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    1887:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    188a:	3b 45 e0             	cmp    eax,DWORD PTR [ebp-0x20]
    188d:	0f 8c b1 fd ff ff    	jl     1644 <pci_add_bars+0x57>
		if (t == 0 || t == 1) { /* the regular 6/2 BARs */
    1893:	e9 14 01 00 00       	jmp    19ac <pci_add_bars+0x3bf>
		} else if (t == 2) { /* PCI-to-CardBus bridge */
    1898:	80 7d ef 02          	cmp    BYTE PTR [ebp-0x11],0x2
    189c:	0f 85 0a 01 00 00    	jne    19ac <pci_add_bars+0x3bf>
				a.reg_no = 0x1c;
    18a2:	c6 45 d4 1c          	mov    BYTE PTR [ebp-0x2c],0x1c
				for (int i = 0; i < 4; i++) {
    18a6:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    18ad:	e9 ee 00 00 00       	jmp    19a0 <pci_add_bars+0x3b3>
						uint32_t base = pci_read(a), limit;
    18b2:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    18b5:	89 04 24             	mov    DWORD PTR [esp],eax
    18b8:	e8 ec e7 ff ff       	call   a9 <pci_read>
    18bd:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
						a.reg_no += 4;
    18c0:	0f b6 45 d4          	movzx  eax,BYTE PTR [ebp-0x2c]
    18c4:	83 c0 04             	add    eax,0x4
    18c7:	88 45 d4             	mov    BYTE PTR [ebp-0x2c],al
						limit = pci_read(a);
    18ca:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    18cd:	89 04 24             	mov    DWORD PTR [esp],eax
    18d0:	e8 d4 e7 ff ff       	call   a9 <pci_read>
    18d5:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
						if (i < 2) { /* memory */
    18d8:	83 7d f0 01          	cmp    DWORD PTR [ebp-0x10],0x1
    18dc:	7f 65                	jg     1943 <pci_add_bars+0x356>
								d->ressources[i].type = PCI_BAR_MMIO;
    18de:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    18e1:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    18e4:	89 d0                	mov    eax,edx
    18e6:	01 c0                	add    eax,eax
    18e8:	01 d0                	add    eax,edx
    18ea:	c1 e0 03             	shl    eax,0x3
    18ed:	01 c8                	add    eax,ecx
    18ef:	83 c0 24             	add    eax,0x24
    18f2:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
								d->ressources[i].mmio.base = base;
    18f8:	8b 4d e8             	mov    ecx,DWORD PTR [ebp-0x18]
    18fb:	bb 00 00 00 00       	mov    ebx,0x0
    1900:	8b 75 08             	mov    esi,DWORD PTR [ebp+0x8]
    1903:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1906:	89 d0                	mov    eax,edx
    1908:	01 c0                	add    eax,eax
    190a:	01 d0                	add    eax,edx
    190c:	c1 e0 03             	shl    eax,0x3
    190f:	01 f0                	add    eax,esi
    1911:	83 c0 20             	add    eax,0x20
    1914:	89 48 08             	mov    DWORD PTR [eax+0x8],ecx
    1917:	89 58 0c             	mov    DWORD PTR [eax+0xc],ebx
								d->ressources[i].mmio.size = limit - base;
    191a:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    191d:	2b 45 e8             	sub    eax,DWORD PTR [ebp-0x18]
    1920:	89 c1                	mov    ecx,eax
    1922:	bb 00 00 00 00       	mov    ebx,0x0
    1927:	8b 75 08             	mov    esi,DWORD PTR [ebp+0x8]
    192a:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    192d:	89 d0                	mov    eax,edx
    192f:	01 c0                	add    eax,eax
    1931:	01 d0                	add    eax,edx
    1933:	c1 e0 03             	shl    eax,0x3
    1936:	01 f0                	add    eax,esi
    1938:	83 c0 20             	add    eax,0x20
    193b:	89 48 10             	mov    DWORD PTR [eax+0x10],ecx
    193e:	89 58 14             	mov    DWORD PTR [eax+0x14],ebx
    1941:	eb 59                	jmp    199c <pci_add_bars+0x3af>
								d->ressources[i].type = PCI_BAR_PIO;
    1943:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    1946:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1949:	89 d0                	mov    eax,edx
    194b:	01 c0                	add    eax,eax
    194d:	01 d0                	add    eax,edx
    194f:	c1 e0 03             	shl    eax,0x3
    1952:	01 c8                	add    eax,ecx
    1954:	83 c0 24             	add    eax,0x24
    1957:	c7 00 01 00 00 00    	mov    DWORD PTR [eax],0x1
								d->ressources[i].pio.base = base;
    195d:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1960:	89 c3                	mov    ebx,eax
    1962:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    1965:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1968:	89 d0                	mov    eax,edx
    196a:	01 c0                	add    eax,eax
    196c:	01 d0                	add    eax,edx
    196e:	c1 e0 03             	shl    eax,0x3
    1971:	01 c8                	add    eax,ecx
    1973:	83 c0 28             	add    eax,0x28
    1976:	66 89 18             	mov    WORD PTR [eax],bx
								d->ressources[i].pio.count = limit - base;
    1979:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    197c:	89 c2                	mov    edx,eax
    197e:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1981:	89 d1                	mov    ecx,edx
    1983:	29 c1                	sub    ecx,eax
    1985:	8b 5d 08             	mov    ebx,DWORD PTR [ebp+0x8]
    1988:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    198b:	89 d0                	mov    eax,edx
    198d:	01 c0                	add    eax,eax
    198f:	01 d0                	add    eax,edx
    1991:	c1 e0 03             	shl    eax,0x3
    1994:	01 d8                	add    eax,ebx
    1996:	83 c0 2a             	add    eax,0x2a
    1999:	66 89 08             	mov    WORD PTR [eax],cx
				for (int i = 0; i < 4; i++) {
    199c:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
    19a0:	83 7d f0 03          	cmp    DWORD PTR [ebp-0x10],0x3
    19a4:	0f 8e 08 ff ff ff    	jle    18b2 <pci_add_bars+0x2c5>
}
    19aa:	eb 00                	jmp    19ac <pci_add_bars+0x3bf>
    19ac:	90                   	nop
    19ad:	83 c4 38             	add    esp,0x38
    19b0:	5b                   	pop    ebx
    19b1:	5e                   	pop    esi
    19b2:	5d                   	pop    ebp
    19b3:	c3                   	ret

000019b4 <pci_enumerate_devices>:
{
    19b4:	55                   	push   ebp
    19b5:	89 e5                	mov    ebp,esp
    19b7:	83 ec 38             	sub    esp,0x38
		union pca pca = {0};
    19ba:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
		printf("Enumerating PCI devices:\n");
    19c1:	c7 04 24 29 12 00 00 	mov    DWORD PTR [esp],0x1229
    19c8:	e8 fc ff ff ff       	call   19c9 <pci_enumerate_devices+0x15>
		for (bus = 0; bus < 256; bus++)
    19cd:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    19d4:	e9 3c 03 00 00       	jmp    1d15 <pci_enumerate_devices+0x361>
				for (dev = 0; dev < 32; dev++) {
    19d9:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    19e0:	e9 22 03 00 00       	jmp    1d07 <pci_enumerate_devices+0x353>
						uint32_t dat, fno = 0;
    19e5:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
						pca.bus_no = bus;
    19ec:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    19ef:	88 45 de             	mov    BYTE PTR [ebp-0x22],al
						pca.device_no = dev;
    19f2:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    19f5:	83 e0 1f             	and    eax,0x1f
    19f8:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    19ff:	0f b6 45 dd          	movzx  eax,BYTE PTR [ebp-0x23]
    1a03:	83 e0 07             	and    eax,0x7
    1a06:	09 d0                	or     eax,edx
    1a08:	88 45 dd             	mov    BYTE PTR [ebp-0x23],al
						pca.enabled = 1;
    1a0b:	0f b6 45 df          	movzx  eax,BYTE PTR [ebp-0x21]
    1a0f:	83 c8 80             	or     eax,0xffffff80
    1a12:	88 45 df             	mov    BYTE PTR [ebp-0x21],al
    1a15:	eb 01                	jmp    1a18 <pci_enumerate_devices+0x64>
								goto multifun; /* non-consecuitive layouts */
    1a17:	90                   	nop
						pca.func_no = fno++;
    1a18:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1a1b:	8d 50 01             	lea    edx,[eax+0x1]
    1a1e:	89 55 e8             	mov    DWORD PTR [ebp-0x18],edx
    1a21:	83 e0 07             	and    eax,0x7
    1a24:	83 e0 07             	and    eax,0x7
    1a27:	89 c2                	mov    edx,eax
    1a29:	0f b6 45 dd          	movzx  eax,BYTE PTR [ebp-0x23]
    1a2d:	83 e0 f8             	and    eax,0xfffffff8
    1a30:	09 d0                	or     eax,edx
    1a32:	88 45 dd             	mov    BYTE PTR [ebp-0x23],al
						pca.reg_no = 0;
    1a35:	c6 45 dc 00          	mov    BYTE PTR [ebp-0x24],0x0
						pca.reserved =/* pca.zero =*/ 0;
    1a39:	0f b6 45 df          	movzx  eax,BYTE PTR [ebp-0x21]
    1a3d:	83 e0 80             	and    eax,0xffffff80
    1a40:	88 45 df             	mov    BYTE PTR [ebp-0x21],al
						dat = pci_read(pca);
    1a43:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1a46:	89 04 24             	mov    DWORD PTR [esp],eax
    1a49:	e8 5b e6 ff ff       	call   a9 <pci_read>
    1a4e:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
						if ((dat & 0xffff) != 0xffff) {
    1a51:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1a54:	0f b7 c0             	movzx  eax,ax
    1a57:	3d ff ff 00 00       	cmp    eax,0xffff
    1a5c:	0f 84 91 02 00 00    	je     1cf3 <pci_enumerate_devices+0x33f>
								int mf = 0; struct dle* le;
    1a62:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
								le = kzalloc(sizeof(*le));
    1a69:	c7 04 24 c0 00 00 00 	mov    DWORD PTR [esp],0xc0
    1a70:	e8 fc ff ff ff       	call   1a71 <pci_enumerate_devices+0xbd>
    1a75:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
								le->dev.addr = pca;
    1a78:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1a7b:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1a7e:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
								le->dev.identification = dat >> 16;
    1a81:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1a84:	c1 e8 10             	shr    eax,0x10
    1a87:	89 c2                	mov    edx,eax
    1a89:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1a8c:	66 89 50 18          	mov    WORD PTR [eax+0x18],dx
								le->dev.vendor = (dat & 0xffff);
    1a90:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1a93:	89 c2                	mov    edx,eax
    1a95:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1a98:	66 89 50 16          	mov    WORD PTR [eax+0x16],dx
										pca.bus_no, pca.device_no, pca.func_no);
    1a9c:	0f b6 45 dd          	movzx  eax,BYTE PTR [ebp-0x23]
    1aa0:	83 e0 07             	and    eax,0x7
								printf("devie at %02x:%02x.%x\n",
    1aa3:	0f b6 c8             	movzx  ecx,al
										pca.bus_no, pca.device_no, pca.func_no);
    1aa6:	0f b6 45 dd          	movzx  eax,BYTE PTR [ebp-0x23]
    1aaa:	c0 e8 03             	shr    al,0x3
								printf("devie at %02x:%02x.%x\n",
    1aad:	0f b6 d0             	movzx  edx,al
										pca.bus_no, pca.device_no, pca.func_no);
    1ab0:	0f b6 45 de          	movzx  eax,BYTE PTR [ebp-0x22]
								printf("devie at %02x:%02x.%x\n",
    1ab4:	0f b6 c0             	movzx  eax,al
    1ab7:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    1abb:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    1abf:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1ac3:	c7 04 24 43 12 00 00 	mov    DWORD PTR [esp],0x1243
    1aca:	e8 fc ff ff ff       	call   1acb <pci_enumerate_devices+0x117>
								printf("\tid:       %04x\n", (dat >> 16));
    1acf:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1ad2:	c1 e8 10             	shr    eax,0x10
    1ad5:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1ad9:	c7 04 24 5a 12 00 00 	mov    DWORD PTR [esp],0x125a
    1ae0:	e8 fc ff ff ff       	call   1ae1 <pci_enumerate_devices+0x12d>
								printf("\tvendor:   %04x\n", (dat & 0xffff));
    1ae5:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1ae8:	0f b7 c0             	movzx  eax,ax
    1aeb:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1aef:	c7 04 24 6b 12 00 00 	mov    DWORD PTR [esp],0x126b
    1af6:	e8 fc ff ff ff       	call   1af7 <pci_enumerate_devices+0x143>
								pca.reg_no = 8;
    1afb:	c6 45 dc 08          	mov    BYTE PTR [ebp-0x24],0x8
								dat = pci_read(pca);
    1aff:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1b02:	89 04 24             	mov    DWORD PTR [esp],eax
    1b05:	e8 9f e5 ff ff       	call   a9 <pci_read>
    1b0a:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
								le->dev.device_class = dat >> 24;
    1b0d:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1b10:	c1 e8 18             	shr    eax,0x18
    1b13:	89 c2                	mov    edx,eax
    1b15:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1b18:	88 50 10             	mov    BYTE PTR [eax+0x10],dl
								le->dev.device_subclass = (dat >> 16) & 0xff;
    1b1b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1b1e:	c1 e8 10             	shr    eax,0x10
    1b21:	89 c2                	mov    edx,eax
    1b23:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1b26:	88 50 11             	mov    BYTE PTR [eax+0x11],dl
								le->dev.device_interface = (dat >> 8) & 0xff;
    1b29:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1b2c:	c1 e8 08             	shr    eax,0x8
    1b2f:	89 c2                	mov    edx,eax
    1b31:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1b34:	88 50 12             	mov    BYTE PTR [eax+0x12],dl
									pci_get_class_string(dat >> 24));
    1b37:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1b3a:	c1 e8 18             	shr    eax,0x18
								printf("\tclass:    %s\n",
    1b3d:	0f b6 c0             	movzx  eax,al
    1b40:	89 04 24             	mov    DWORD PTR [esp],eax
    1b43:	e8 fc ff ff ff       	call   1b44 <pci_enumerate_devices+0x190>
    1b48:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1b4c:	c7 04 24 7c 12 00 00 	mov    DWORD PTR [esp],0x127c
    1b53:	e8 fc ff ff ff       	call   1b54 <pci_enumerate_devices+0x1a0>
									(dat >> 16) & 0xff, (dat >> 8) & 0xff));
    1b58:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1b5b:	c1 e8 08             	shr    eax,0x8
								printf("\tsubclass: %s\n",
    1b5e:	0f b6 c8             	movzx  ecx,al
									(dat >> 16) & 0xff, (dat >> 8) & 0xff));
    1b61:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1b64:	c1 e8 10             	shr    eax,0x10
								printf("\tsubclass: %s\n",
    1b67:	0f b6 d0             	movzx  edx,al
									pci_get_subclass_string(dat >> 24,
    1b6a:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1b6d:	c1 e8 18             	shr    eax,0x18
								printf("\tsubclass: %s\n",
    1b70:	0f b6 c0             	movzx  eax,al
    1b73:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
    1b77:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1b7b:	89 04 24             	mov    DWORD PTR [esp],eax
    1b7e:	e8 fc ff ff ff       	call   1b7f <pci_enumerate_devices+0x1cb>
    1b83:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1b87:	c7 04 24 8b 12 00 00 	mov    DWORD PTR [esp],0x128b
    1b8e:	e8 fc ff ff ff       	call   1b8f <pci_enumerate_devices+0x1db>
								pca.reg_no = 12;
    1b93:	c6 45 dc 0c          	mov    BYTE PTR [ebp-0x24],0xc
								dat = pci_read(pca);
    1b97:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1b9a:	89 04 24             	mov    DWORD PTR [esp],eax
    1b9d:	e8 07 e5 ff ff       	call   a9 <pci_read>
    1ba2:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
								dat = (dat >> 16) & 0xff;
    1ba5:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1ba8:	c1 e8 10             	shr    eax,0x10
    1bab:	25 ff 00 00 00       	and    eax,0xff
    1bb0:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
								le->dev.device_type = dat;
    1bb3:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1bb6:	89 c2                	mov    edx,eax
    1bb8:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1bbb:	88 50 13             	mov    BYTE PTR [eax+0x13],dl
								mf = dat & 0x80;
    1bbe:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1bc1:	25 80 00 00 00       	and    eax,0x80
    1bc6:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
									(dat & 0x80) ? "multi" : "single");
    1bc9:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1bcc:	25 80 00 00 00       	and    eax,0x80
								printf("\tfunction: %s\n",
    1bd1:	85 c0                	test   eax,eax
    1bd3:	74 07                	je     1bdc <pci_enumerate_devices+0x228>
    1bd5:	b8 9a 12 00 00       	mov    eax,0x129a
    1bda:	eb 05                	jmp    1be1 <pci_enumerate_devices+0x22d>
    1bdc:	b8 a0 12 00 00       	mov    eax,0x12a0
    1be1:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1be5:	c7 04 24 a7 12 00 00 	mov    DWORD PTR [esp],0x12a7
    1bec:	e8 fc ff ff ff       	call   1bed <pci_enumerate_devices+0x239>
									((dat & 0x7f) == 0) ? "general" : (((dat & 0x7f) == 1)
    1bf1:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1bf4:	83 e0 7f             	and    eax,0x7f
								printf("\ttype:     %s\n",
    1bf7:	85 c0                	test   eax,eax
    1bf9:	74 19                	je     1c14 <pci_enumerate_devices+0x260>
									((dat & 0x7f) == 0) ? "general" : (((dat & 0x7f) == 1)
    1bfb:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1bfe:	83 e0 7f             	and    eax,0x7f
									? ("PCI-to-PCI bridge") : ("CardBus bridge")));
    1c01:	83 f8 01             	cmp    eax,0x1
    1c04:	75 07                	jne    1c0d <pci_enumerate_devices+0x259>
    1c06:	b8 e5 05 00 00       	mov    eax,0x5e5
    1c0b:	eb 0c                	jmp    1c19 <pci_enumerate_devices+0x265>
    1c0d:	b8 55 06 00 00       	mov    eax,0x655
    1c12:	eb 05                	jmp    1c19 <pci_enumerate_devices+0x265>
								printf("\ttype:     %s\n",
    1c14:	b8 b6 12 00 00       	mov    eax,0x12b6
    1c19:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1c1d:	c7 04 24 be 12 00 00 	mov    DWORD PTR [esp],0x12be
    1c24:	e8 fc ff ff ff       	call   1c25 <pci_enumerate_devices+0x271>
								pca.reg_no = PCI_INTERRUPT_LINE;
    1c29:	c6 45 dc 3c          	mov    BYTE PTR [ebp-0x24],0x3c
								dat = pci_read(pca);
    1c2d:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1c30:	89 04 24             	mov    DWORD PTR [esp],eax
    1c33:	e8 71 e4 ff ff       	call   a9 <pci_read>
    1c38:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
								le->dev.intr_pin = (dat >> 8) & 0xff;
    1c3b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1c3e:	c1 e8 08             	shr    eax,0x8
    1c41:	89 c2                	mov    edx,eax
    1c43:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1c46:	88 50 14             	mov    BYTE PTR [eax+0x14],dl
								le->dev.intr_line = dat & 0xff;
    1c49:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1c4c:	89 c2                	mov    edx,eax
    1c4e:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1c51:	88 50 15             	mov    BYTE PTR [eax+0x15],dl
								if (!le->dev.intr_pin || le->dev.intr_pin > 4)
    1c54:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1c57:	0f b6 40 14          	movzx  eax,BYTE PTR [eax+0x14]
    1c5b:	84 c0                	test   al,al
    1c5d:	74 0b                	je     1c6a <pci_enumerate_devices+0x2b6>
    1c5f:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1c62:	0f b6 40 14          	movzx  eax,BYTE PTR [eax+0x14]
    1c66:	3c 04                	cmp    al,0x4
    1c68:	76 09                	jbe    1c73 <pci_enumerate_devices+0x2bf>
										dat = ' ';
    1c6a:	c7 45 ec 20 00 00 00 	mov    DWORD PTR [ebp-0x14],0x20
    1c71:	eb 10                	jmp    1c83 <pci_enumerate_devices+0x2cf>
										dat = 'A' + (le->dev.intr_pin - 1);
    1c73:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1c76:	0f b6 40 14          	movzx  eax,BYTE PTR [eax+0x14]
    1c7a:	0f b6 c0             	movzx  eax,al
    1c7d:	83 c0 40             	add    eax,0x40
    1c80:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
								printf("\tinterrupt: INT%c#  line: %u\n", (char)dat, le->dev.intr_line);
    1c83:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1c86:	0f b6 40 15          	movzx  eax,BYTE PTR [eax+0x15]
    1c8a:	0f b6 d0             	movzx  edx,al
    1c8d:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1c90:	0f be c0             	movsx  eax,al
    1c93:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    1c97:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1c9b:	c7 04 24 cd 12 00 00 	mov    DWORD PTR [esp],0x12cd
    1ca2:	e8 fc ff ff ff       	call   1ca3 <pci_enumerate_devices+0x2ef>
								printf("\n");
    1ca7:	c7 04 24 eb 12 00 00 	mov    DWORD PTR [esp],0x12eb
    1cae:	e8 fc ff ff ff       	call   1caf <pci_enumerate_devices+0x2fb>
								pci_add_bars(&le->dev);
    1cb3:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1cb6:	83 c0 0c             	add    eax,0xc
    1cb9:	89 04 24             	mov    DWORD PTR [esp],eax
    1cbc:	e8 fc ff ff ff       	call   1cbd <pci_enumerate_devices+0x309>
								pci_add_caps(&le->dev);
    1cc1:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1cc4:	83 c0 0c             	add    eax,0xc
    1cc7:	89 04 24             	mov    DWORD PTR [esp],eax
    1cca:	e8 fc ff ff ff       	call   1ccb <pci_enumerate_devices+0x317>
								list_add_tail(&le->devices, &device_list.devices);
    1ccf:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1cd2:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    1cda:	89 04 24             	mov    DWORD PTR [esp],eax
    1cdd:	e8 87 e3 ff ff       	call   69 <list_add_tail>
								if (mf && fno < 8)
    1ce2:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    1ce6:	74 1b                	je     1d03 <pci_enumerate_devices+0x34f>
    1ce8:	83 7d e8 07          	cmp    DWORD PTR [ebp-0x18],0x7
    1cec:	77 15                	ja     1d03 <pci_enumerate_devices+0x34f>
										goto multifun;
    1cee:	e9 25 fd ff ff       	jmp    1a18 <pci_enumerate_devices+0x64>
						} else if (fno && fno < 8)
    1cf3:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    1cf7:	74 0a                	je     1d03 <pci_enumerate_devices+0x34f>
    1cf9:	83 7d e8 07          	cmp    DWORD PTR [ebp-0x18],0x7
    1cfd:	0f 86 14 fd ff ff    	jbe    1a17 <pci_enumerate_devices+0x63>
				for (dev = 0; dev < 32; dev++) {
    1d03:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
    1d07:	83 7d f0 1f          	cmp    DWORD PTR [ebp-0x10],0x1f
    1d0b:	0f 86 d4 fc ff ff    	jbe    19e5 <pci_enumerate_devices+0x31>
		for (bus = 0; bus < 256; bus++)
    1d11:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    1d15:	81 7d f4 ff 00 00 00 	cmp    DWORD PTR [ebp-0xc],0xff
    1d1c:	0f 86 b7 fc ff ff    	jbe    19d9 <pci_enumerate_devices+0x25>
}
    1d22:	90                   	nop
    1d23:	90                   	nop
    1d24:	c9                   	leave
    1d25:	c3                   	ret

00001d26 <module_init>:
{
    1d26:	55                   	push   ebp
    1d27:	89 e5                	mov    ebp,esp
    1d29:	83 ec 08             	sub    esp,0x8
		pci_enumerate_devices();
    1d2c:	e8 fc ff ff ff       	call   1d2d <module_init+0x7>
		return 0;
    1d31:	b8 00 00 00 00       	mov    eax,0x0
}
    1d36:	c9                   	leave
    1d37:	c3                   	ret

00001d38 <module_cleanup>:
void MODENTRY module_cleanup()
{
    1d38:	55                   	push   ebp
    1d39:	89 e5                	mov    ebp,esp
    1d3b:	83 ec 18             	sub    esp,0x18
		printf("goodbye pci.ko\n");
    1d3e:	c7 04 24 ed 12 00 00 	mov    DWORD PTR [esp],0x12ed
    1d45:	e8 fc ff ff ff       	call   1d46 <module_cleanup+0xe>
}
    1d4a:	90                   	nop
    1d4b:	c9                   	leave
    1d4c:	c3                   	ret
