
ata_drive.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <memcpy>:
   0:	55                   	push   ebp
   1:	89 e5                	mov    ebp,esp
   3:	83 ec 10             	sub    esp,0x10
   6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   9:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
   c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
   f:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
  12:	eb 17                	jmp    2b <memcpy+0x2b>
  14:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
  17:	8d 42 01             	lea    eax,[edx+0x1]
  1a:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
  1d:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
  20:	8d 48 01             	lea    ecx,[eax+0x1]
  23:	89 4d fc             	mov    DWORD PTR [ebp-0x4],ecx
  26:	0f b6 12             	movzx  edx,BYTE PTR [edx]
  29:	88 10                	mov    BYTE PTR [eax],dl
  2b:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
  2e:	8d 50 ff             	lea    edx,[eax-0x1]
  31:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
  34:	85 c0                	test   eax,eax
  36:	75 dc                	jne    14 <memcpy+0x14>
  38:	90                   	nop
  39:	90                   	nop
  3a:	c9                   	leave
  3b:	c3                   	ret

0000003c <__list_add>:
  3c:	55                   	push   ebp
  3d:	89 e5                	mov    ebp,esp
  3f:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
  42:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
  45:	89 10                	mov    DWORD PTR [eax],edx
  47:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
  4a:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
  4d:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
  50:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
  53:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
  56:	89 10                	mov    DWORD PTR [eax],edx
  58:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
  5b:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
  5e:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
  61:	90                   	nop
  62:	5d                   	pop    ebp
  63:	c3                   	ret

00000064 <list_add_tail>:
  64:	55                   	push   ebp
  65:	89 e5                	mov    ebp,esp
  67:	83 ec 18             	sub    esp,0x18
  6a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
  6d:	83 c0 08             	add    eax,0x8
  70:	89 04 24             	mov    DWORD PTR [esp],eax
  73:	e8 fc ff ff ff       	call   74 <list_add_tail+0x10>
  78:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
  7b:	8b 00                	mov    eax,DWORD PTR [eax]
  7d:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
  80:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
  84:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
  88:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
  8b:	89 04 24             	mov    DWORD PTR [esp],eax
  8e:	e8 a9 ff ff ff       	call   3c <__list_add>
  93:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
  96:	83 c0 08             	add    eax,0x8
  99:	89 04 24             	mov    DWORD PTR [esp],eax
  9c:	e8 fc ff ff ff       	call   9d <list_add_tail+0x39>
  a1:	90                   	nop
  a2:	c9                   	leave
  a3:	c3                   	ret

000000a4 <sd_format_disk_name>:
{
  a4:	55                   	push   ebp
  a5:	89 e5                	mov    ebp,esp
  a7:	83 ec 38             	sub    esp,0x38
		const int base = 'z' - 'a' + 1;
  aa:	c7 45 f0 1a 00 00 00 	mov    DWORD PTR [ebp-0x10],0x1a
		char *begin = buf + strlen(prefix);
  b1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
  b4:	89 04 24             	mov    DWORD PTR [esp],eax
  b7:	e8 fc ff ff ff       	call   b8 <sd_format_disk_name+0x14>
  bc:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
  bf:	01 d0                	add    eax,edx
  c1:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		char *end = buf + buflen;
  c4:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
  c7:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
  ca:	01 d0                	add    eax,edx
  cc:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		p = end - 1;
  cf:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
  d2:	83 e8 01             	sub    eax,0x1
  d5:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		*p = '\0';
  d8:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
  db:	c6 00 00             	mov    BYTE PTR [eax],0x0
		unit = base;
  de:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
  e1:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				if (p == begin)
  e4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
  e7:	3b 45 ec             	cmp    eax,DWORD PTR [ebp-0x14]
  ea:	75 07                	jne    f3 <sd_format_disk_name+0x4f>
						return -EINVAL;
  ec:	b8 ea ff ff ff       	mov    eax,0xffffffea
  f1:	eb 6c                	jmp    15f <sd_format_disk_name+0xbb>
				*--p = 'a' + (index % unit);
  f3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
  f6:	99                   	cdq
  f7:	f7 7d e4             	idiv   DWORD PTR [ebp-0x1c]
  fa:	89 d0                	mov    eax,edx
  fc:	83 c0 61             	add    eax,0x61
  ff:	83 6d f4 01          	sub    DWORD PTR [ebp-0xc],0x1
 103:	89 c2                	mov    edx,eax
 105:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 108:	88 10                	mov    BYTE PTR [eax],dl
				index = (index / unit) - 1;
 10a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 10d:	99                   	cdq
 10e:	f7 7d e4             	idiv   DWORD PTR [ebp-0x1c]
 111:	83 e8 01             	sub    eax,0x1
 114:	89 45 0c             	mov    DWORD PTR [ebp+0xc],eax
		} while (index >= 0);
 117:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
 11b:	79 c7                	jns    e4 <sd_format_disk_name+0x40>
		memmove(begin, p, end - p);
 11d:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 120:	2b 45 f4             	sub    eax,DWORD PTR [ebp-0xc]
 123:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
 127:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 12a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 12e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
 131:	89 04 24             	mov    DWORD PTR [esp],eax
 134:	e8 fc ff ff ff       	call   135 <sd_format_disk_name+0x91>
		memcpy(buf, prefix, strlen(prefix));
 139:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 13c:	89 04 24             	mov    DWORD PTR [esp],eax
 13f:	e8 fc ff ff ff       	call   140 <sd_format_disk_name+0x9c>
 144:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
 148:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 14b:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 14f:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 152:	89 04 24             	mov    DWORD PTR [esp],eax
 155:	e8 a6 fe ff ff       	call   0 <memcpy>
		return 0;
 15a:	b8 00 00 00 00       	mov    eax,0x0
}
 15f:	c9                   	leave
 160:	c3                   	ret

00000161 <init_ata_dd>:
{
 161:	55                   	push   ebp
 162:	89 e5                	mov    ebp,esp
 164:	83 ec 18             	sub    esp,0x18
		if (!spin_trylock(&ata_lock)) {
 167:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 16e:	e8 fc ff ff ff       	call   16f <init_ata_dd+0xe>
 173:	85 c0                	test   eax,eax
 175:	75 12                	jne    189 <init_ata_dd+0x28>
				while (!ata_init)
 177:	eb 05                	jmp    17e <init_ata_dd+0x1d>
						task_yield();
 179:	e8 fc ff ff ff       	call   17a <init_ata_dd+0x19>
				while (!ata_init)
 17e:	a1 00 00 00 00       	mov    eax,ds:0x0
 183:	85 c0                	test   eax,eax
 185:	74 f2                	je     179 <init_ata_dd+0x18>
				return;
 187:	eb 4e                	jmp    1d7 <init_ata_dd+0x76>
		if (register_device(&dd_ata) == INVALID_DEVICE) {
 189:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 190:	e8 fc ff ff ff       	call   191 <init_ata_dd+0x30>
 195:	89 c1                	mov    ecx,eax
 197:	89 c8                	mov    eax,ecx
 199:	f7 d0                	not    eax
 19b:	09 d0                	or     eax,edx
 19d:	75 22                	jne    1c1 <init_ata_dd+0x60>
				cprintf(KFMT_ERROR, "unable to register ATA device object.\n");
 19f:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
 1a7:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
 1ae:	e8 fc ff ff ff       	call   1af <init_ata_dd+0x4e>
				spin_unlock(&ata_lock);
 1b3:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 1ba:	e8 fc ff ff ff       	call   1bb <init_ata_dd+0x5a>
				return;
 1bf:	eb 16                	jmp    1d7 <init_ata_dd+0x76>
		ata_init = 1;
 1c1:	c7 05 00 00 00 00 01 00 00 00 	mov    DWORD PTR ds:0x0,0x1
		spin_unlock(&ata_lock);
 1cb:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 1d2:	e8 fc ff ff ff       	call   1d3 <init_ata_dd+0x72>
}
 1d7:	c9                   	leave
 1d8:	c3                   	ret

000001d9 <register_ata_device>:
{
 1d9:	55                   	push   ebp
 1da:	89 e5                	mov    ebp,esp
 1dc:	57                   	push   edi
 1dd:	56                   	push   esi
 1de:	53                   	push   ebx
 1df:	83 ec 3c             	sub    esp,0x3c
 1e2:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 1e5:	66 89 45 d4          	mov    WORD PTR [ebp-0x2c],ax
		if (!ata_init)
 1e9:	a1 00 00 00 00       	mov    eax,ds:0x0
 1ee:	85 c0                	test   eax,eax
 1f0:	75 05                	jne    1f7 <register_ata_device+0x1e>
				init_ata_dd();
 1f2:	e8 fc ff ff ff       	call   1f3 <register_ata_device+0x1a>
		struct ata_node* n = kzalloc(sizeof(*n));
 1f7:	c7 04 24 54 00 00 00 	mov    DWORD PTR [esp],0x54
 1fe:	e8 fc ff ff ff       	call   1ff <register_ata_device+0x26>
 203:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		if (!n)
 206:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
 20a:	75 0a                	jne    216 <register_ata_device+0x3d>
				return -ENOMEM;
 20c:	b8 f4 ff ff ff       	mov    eax,0xfffffff4
 211:	e9 32 03 00 00       	jmp    548 <register_ata_device+0x36f>
		n->ad = ad;
 216:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 219:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
 21c:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
		n->id = id;
 21f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 222:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
 225:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
		n->pt = p - ad->ptr->port;
 228:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 22b:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 22e:	05 00 01 00 00       	add    eax,0x100
 233:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
 236:	29 c2                	sub    edx,eax
 238:	89 d0                	mov    eax,edx
 23a:	c1 f8 07             	sar    eax,0x7
 23d:	89 c2                	mov    edx,eax
 23f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 242:	66 89 50 20          	mov    WORD PTR [eax+0x20],dx
		n->pmprt = pmprt;
 246:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 249:	0f b7 55 d4          	movzx  edx,WORD PTR [ebp-0x2c]
 24d:	66 89 50 22          	mov    WORD PTR [eax+0x22],dx
		n->index = __sync_fetch_and_add(&ata_device.cur_idx, 1);
 251:	ba 01 00 00 00       	mov    edx,0x1
 256:	f0 0f c1 15 08 00 00 00 	lock xadd DWORD PTR ds:0x8,edx
 25e:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 261:	89 10                	mov    DWORD PTR [eax],edx
		if (!id->lba_supp) {
 263:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 266:	0f b6 40 63          	movzx  eax,BYTE PTR [eax+0x63]
 26a:	83 e0 02             	and    eax,0x2
 26d:	84 c0                	test   al,al
 26f:	75 29                	jne    29a <register_ata_device+0xc1>
				die("LBA needed\n");
 271:	c7 44 24 04 27 00 00 00 	mov    DWORD PTR [esp+0x4],0x27
 279:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
 280:	e8 fc ff ff ff       	call   281 <register_ata_device+0xa8>
 285:	e8 fc ff ff ff       	call   286 <register_ata_device+0xad>
 28a:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 291:	e8 fc ff ff ff       	call   292 <register_ata_device+0xb9>
 296:	fa                   	cli
 297:	f4                   	hlt
 298:	eb fd                	jmp    297 <register_ata_device+0xbe>
		} else if (id->has_lba48 || id->has_lba48_alt)
 29a:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 29d:	0f b6 80 a7 00 00 00 	movzx  eax,BYTE PTR [eax+0xa7]
 2a4:	83 e0 04             	and    eax,0x4
 2a7:	84 c0                	test   al,al
 2a9:	75 11                	jne    2bc <register_ata_device+0xe3>
 2ab:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 2ae:	0f b6 80 ad 00 00 00 	movzx  eax,BYTE PTR [eax+0xad]
 2b5:	83 e0 04             	and    eax,0x4
 2b8:	84 c0                	test   al,al
 2ba:	74 1a                	je     2d6 <register_ata_device+0xfd>
				n->gm.max_lba = id->num_logical_sectors;
 2bc:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 2bf:	8b 90 cc 00 00 00    	mov    edx,DWORD PTR [eax+0xcc]
 2c5:	8b 80 c8 00 00 00    	mov    eax,DWORD PTR [eax+0xc8]
 2cb:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
 2ce:	89 41 30             	mov    DWORD PTR [ecx+0x30],eax
 2d1:	89 51 34             	mov    DWORD PTR [ecx+0x34],edx
 2d4:	eb 14                	jmp    2ea <register_ata_device+0x111>
				n->gm.max_lba = id->max_lba28;
 2d6:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 2d9:	8b 40 78             	mov    eax,DWORD PTR [eax+0x78]
 2dc:	ba 00 00 00 00       	mov    edx,0x0
 2e1:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
 2e4:	89 41 30             	mov    DWORD PTR [ecx+0x30],eax
 2e7:	89 51 34             	mov    DWORD PTR [ecx+0x34],edx
		if (id->has_multiple_logical_per_physical_sectors) {
 2ea:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 2ed:	0f b6 80 d5 00 00 00 	movzx  eax,BYTE PTR [eax+0xd5]
 2f4:	83 e0 20             	and    eax,0x20
 2f7:	84 c0                	test   al,al
 2f9:	74 26                	je     321 <register_ata_device+0x148>
				n->gm.lpp = 1 << id->num_pwr2_logical_per_phys;
 2fb:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 2fe:	0f b6 80 d4 00 00 00 	movzx  eax,BYTE PTR [eax+0xd4]
 305:	83 e0 0f             	and    eax,0xf
 308:	0f b6 c0             	movzx  eax,al
 30b:	ba 01 00 00 00       	mov    edx,0x1
 310:	89 c1                	mov    ecx,eax
 312:	d3 e2                	shl    edx,cl
 314:	89 d0                	mov    eax,edx
 316:	89 c2                	mov    edx,eax
 318:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 31b:	66 89 50 24          	mov    WORD PTR [eax+0x24],dx
 31f:	eb 09                	jmp    32a <register_ata_device+0x151>
				n->gm.lpp = 1;
 321:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 324:	66 c7 40 24 01 00    	mov    WORD PTR [eax+0x24],0x1
		if (id->logical_sector_longer_than_512bt) {
 32a:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 32d:	0f b6 80 d5 00 00 00 	movzx  eax,BYTE PTR [eax+0xd5]
 334:	83 e0 10             	and    eax,0x10
 337:	84 c0                	test   al,al
 339:	74 14                	je     34f <register_ata_device+0x176>
				n->gm.lss = 2 * id->logical_sector_size;
 33b:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 33e:	8b 80 ea 00 00 00    	mov    eax,DWORD PTR [eax+0xea]
 344:	8d 14 00             	lea    edx,[eax+eax*1]
 347:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 34a:	89 50 28             	mov    DWORD PTR [eax+0x28],edx
 34d:	eb 0a                	jmp    359 <register_ata_device+0x180>
				n->gm.lss = 512;
 34f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 352:	c7 40 28 00 02 00 00 	mov    DWORD PTR [eax+0x28],0x200
		n->gm.lof = id->logical_sector_offset;
 359:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 35c:	0f b6 90 a2 01 00 00 	movzx  edx,BYTE PTR [eax+0x1a2]
 363:	0f b6 80 a3 01 00 00 	movzx  eax,BYTE PTR [eax+0x1a3]
 36a:	83 e0 3f             	and    eax,0x3f
 36d:	c1 e0 08             	shl    eax,0x8
 370:	09 d0                	or     eax,edx
 372:	89 c2                	mov    edx,eax
 374:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 377:	66 89 50 26          	mov    WORD PTR [eax+0x26],dx
		n->cache = create_disk_cache(&n->gm);
 37b:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 37e:	83 c0 24             	add    eax,0x24
 381:	89 04 24             	mov    DWORD PTR [esp],eax
 384:	e8 fc ff ff ff       	call   385 <register_ata_device+0x1ac>
 389:	89 c2                	mov    edx,eax
 38b:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 38e:	89 50 1c             	mov    DWORD PTR [eax+0x1c],edx
		list_add_tail(&n->lst, &ata_device.nodes);
 391:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 394:	83 c0 04             	add    eax,0x4
 397:	c7 44 24 04 0c 00 00 00 	mov    DWORD PTR [esp+0x4],0xc
 39f:	89 04 24             	mov    DWORD PTR [esp],eax
 3a2:	e8 bd fc ff ff       	call   64 <list_add_tail>
		struct inode *in_dev = get_special_inode(INO_DEV), *in;
 3a7:	c7 04 24 01 00 00 00 	mov    DWORD PTR [esp],0x1
 3ae:	e8 fc ff ff ff       	call   3af <register_ata_device+0x1d6>
 3b3:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		in = ino_allocate(S_IFBLK); /* times have been set */
 3b6:	c7 04 24 00 60 00 00 	mov    DWORD PTR [esp],0x6000
 3bd:	e8 fc ff ff ff       	call   3be <register_ata_device+0x1e5>
 3c2:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		if (!in_dev || !in) {
 3c5:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
 3c9:	74 06                	je     3d1 <register_ata_device+0x1f8>
 3cb:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
 3cf:	75 29                	jne    3fa <register_ata_device+0x221>
				die("/dev is not present or inode allocation failed\n");
 3d1:	c7 44 24 04 34 00 00 00 	mov    DWORD PTR [esp+0x4],0x34
 3d9:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
 3e0:	e8 fc ff ff ff       	call   3e1 <register_ata_device+0x208>
 3e5:	e8 fc ff ff ff       	call   3e6 <register_ata_device+0x20d>
 3ea:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 3f1:	e8 fc ff ff ff       	call   3f2 <register_ata_device+0x219>
 3f6:	fa                   	cli
 3f7:	f4                   	hlt
 3f8:	eb fd                	jmp    3f7 <register_ata_device+0x21e>
		in->in_pddat = n;
 3fa:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
 3fd:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
 400:	89 50 70             	mov    DWORD PTR [eax+0x70],edx
		in->in_stat.st_dev = ata_device.id;
 403:	a1 00 00 00 00       	mov    eax,ds:0x0
 408:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
 40e:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
 411:	89 01                	mov    DWORD PTR [ecx],eax
 413:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		in->in_stat.st_blksize = n->gm.pss; /* preferred blocksize */
 416:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 419:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
 41c:	ba 00 00 00 00       	mov    edx,0x0
 421:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
 424:	89 41 34             	mov    DWORD PTR [ecx+0x34],eax
 427:	89 51 38             	mov    DWORD PTR [ecx+0x38],edx
		in->in_stat.st_blocks = n->gm.max_lba * n->gm.lss / 512; /* LBA48 no overflow */
 42a:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 42d:	8b 50 34             	mov    edx,DWORD PTR [eax+0x34]
 430:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
 433:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
 436:	8b 49 28             	mov    ecx,DWORD PTR [ecx+0x28]
 439:	bb 00 00 00 00       	mov    ebx,0x0
 43e:	89 d7                	mov    edi,edx
 440:	0f af f9             	imul   edi,ecx
 443:	89 de                	mov    esi,ebx
 445:	0f af f0             	imul   esi,eax
 448:	01 fe                	add    esi,edi
 44a:	f7 e1                	mul    ecx
 44c:	8d 0c 16             	lea    ecx,[esi+edx*1]
 44f:	89 ca                	mov    edx,ecx
 451:	0f ac d0 09          	shrd   eax,edx,0x9
 455:	c1 ea 09             	shr    edx,0x9
 458:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
 45b:	89 41 3c             	mov    DWORD PTR [ecx+0x3c],eax
 45e:	89 51 40             	mov    DWORD PTR [ecx+0x40],edx
		in->in_stat.st_size = n->gm.max_lba * n->gm.lss;
 461:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 464:	8b 50 34             	mov    edx,DWORD PTR [eax+0x34]
 467:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
 46a:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
 46d:	8b 49 28             	mov    ecx,DWORD PTR [ecx+0x28]
 470:	bb 00 00 00 00       	mov    ebx,0x0
 475:	89 d7                	mov    edi,edx
 477:	0f af f9             	imul   edi,ecx
 47a:	89 de                	mov    esi,ebx
 47c:	0f af f0             	imul   esi,eax
 47f:	01 fe                	add    esi,edi
 481:	f7 e1                	mul    ecx
 483:	8d 0c 16             	lea    ecx,[esi+edx*1]
 486:	89 ca                	mov    edx,ecx
 488:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
 48b:	89 41 2c             	mov    DWORD PTR [ecx+0x2c],eax
 48e:	89 51 30             	mov    DWORD PTR [ecx+0x30],edx
		dd_d = get_device(in_dev->in_stat.st_dev);
 491:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 494:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
 497:	8b 00                	mov    eax,DWORD PTR [eax]
 499:	89 04 24             	mov    DWORD PTR [esp],eax
 49c:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
 4a0:	e8 fc ff ff ff       	call   4a1 <register_ata_device+0x2c8>
 4a5:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
		if (sd_format_disk_name("sd", n->index, n->name, sizeof(n->name)))
 4a8:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 4ab:	8d 50 40             	lea    edx,[eax+0x40]
 4ae:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 4b1:	8b 00                	mov    eax,DWORD PTR [eax]
 4b3:	c7 44 24 0c 14 00 00 00 	mov    DWORD PTR [esp+0xc],0x14
 4bb:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
 4bf:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 4c3:	c7 04 24 64 00 00 00 	mov    DWORD PTR [esp],0x64
 4ca:	e8 fc ff ff ff       	call   4cb <register_ata_device+0x2f2>
 4cf:	85 c0                	test   eax,eax
 4d1:	74 14                	je     4e7 <register_ata_device+0x30e>
				cprintf(KFMT_WARN, "too many sdX devices\n");
 4d3:	c7 44 24 04 67 00 00 00 	mov    DWORD PTR [esp+0x4],0x67
 4db:	c7 04 24 0e 00 00 00 	mov    DWORD PTR [esp],0xe
 4e2:	e8 fc ff ff ff       	call   4e3 <register_ata_device+0x30a>
		if (dd_d->fn_set_subnode(in_dev, in, n->name) == 0)
 4e7:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 4ea:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
 4ed:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
 4f0:	83 c2 40             	add    edx,0x40
 4f3:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
 4f7:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
 4fa:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
 4fe:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
 501:	89 14 24             	mov    DWORD PTR [esp],edx
 504:	ff d0                	call   eax
 506:	85 c0                	test   eax,eax
 508:	75 20                	jne    52a <register_ata_device+0x351>
				cprintf(KFMT_OK, "registered ATA device at dev/%s\n", n->name);
 50a:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 50d:	83 c0 40             	add    eax,0x40
 510:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
 514:	c7 44 24 04 80 00 00 00 	mov    DWORD PTR [esp+0x4],0x80
 51c:	c7 04 24 0a 00 00 00 	mov    DWORD PTR [esp],0xa
 523:	e8 fc ff ff ff       	call   524 <register_ata_device+0x34b>
 528:	eb 1e                	jmp    548 <register_ata_device+0x36f>
				cprintf(KFMT_WARN, "unable to register ATA device at dev/%s\n", n->name);
 52a:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 52d:	83 c0 40             	add    eax,0x40
 530:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
 534:	c7 44 24 04 a4 00 00 00 	mov    DWORD PTR [esp+0x4],0xa4
 53c:	c7 04 24 0e 00 00 00 	mov    DWORD PTR [esp],0xe
 543:	e8 fc ff ff ff       	call   544 <register_ata_device+0x36b>
}
 548:	83 c4 3c             	add    esp,0x3c
 54b:	5b                   	pop    ebx
 54c:	5e                   	pop    esi
 54d:	5f                   	pop    edi
 54e:	5d                   	pop    ebp
 54f:	c3                   	ret

00000550 <ata_register_device>:
{
 550:	55                   	push   ebp
 551:	89 e5                	mov    ebp,esp
 553:	83 ec 18             	sub    esp,0x18
 556:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 559:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
 55c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 55f:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		ata_device.id = d;
 562:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 565:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
 568:	a3 00 00 00 00       	mov    ds:0x0,eax
 56d:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
		ata_device.cur_idx = 0;
 573:	c7 05 08 00 00 00 00 00 00 00 	mov    DWORD PTR ds:0x8,0x0
		ata_device.nodes = LIST_HEAD_INIT(ata_device.nodes);
 57d:	c7 05 0c 00 00 00 0c 00 00 00 	mov    DWORD PTR ds:0xc,0xc
 587:	c7 05 10 00 00 00 0c 00 00 00 	mov    DWORD PTR ds:0x10,0xc
 591:	66 c7 05 14 00 00 00 00 00 	mov    WORD PTR ds:0x14,0x0
		return 0;
 59a:	b8 00 00 00 00       	mov    eax,0x0
}
 59f:	c9                   	leave
 5a0:	c3                   	ret

000005a1 <ata_unregister_device>:
{
 5a1:	55                   	push   ebp
 5a2:	89 e5                	mov    ebp,esp
		return -1;
 5a4:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
 5a9:	5d                   	pop    ebp
 5aa:	c3                   	ret

000005ab <ata_open>:
{
 5ab:	55                   	push   ebp
 5ac:	89 e5                	mov    ebp,esp
 5ae:	57                   	push   edi
 5af:	56                   	push   esi
 5b0:	53                   	push   ebx
 5b1:	83 ec 2c             	sub    esp,0x2c
		if (!in || in->in_stat.st_dev != ata_device.id) {
 5b4:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
 5b8:	74 23                	je     5dd <ata_open+0x32>
 5ba:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 5bd:	8b 08                	mov    ecx,DWORD PTR [eax]
 5bf:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
 5c2:	a1 00 00 00 00       	mov    eax,ds:0x0
 5c7:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
 5cd:	89 cf                	mov    edi,ecx
 5cf:	89 c6                	mov    esi,eax
 5d1:	89 d9                	mov    ecx,ebx
 5d3:	89 f8                	mov    eax,edi
 5d5:	31 f0                	xor    eax,esi
 5d7:	31 ca                	xor    edx,ecx
 5d9:	09 d0                	or     eax,edx
 5db:	74 11                	je     5ee <ata_open+0x43>
				errno = EINVAL;
 5dd:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
				return -1;
 5e7:	b8 ff ff ff ff       	mov    eax,0xffffffff
 5ec:	eb 53                	jmp    641 <ata_open+0x96>
		fd = fil_fd_allocate(in, &rv);
 5ee:	8d 45 e0             	lea    eax,[ebp-0x20]
 5f1:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 5f5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 5f8:	89 04 24             	mov    DWORD PTR [esp],eax
 5fb:	e8 fc ff ff ff       	call   5fc <ata_open+0x51>
 600:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		if (!fd) {
 603:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
 607:	75 11                	jne    61a <ata_open+0x6f>
				errno = ENOMEM;
 609:	c7 05 00 00 00 00 0c 00 00 00 	mov    DWORD PTR ds:0x0,0xc
				return -1;
 613:	b8 ff ff ff ff       	mov    eax,0xffffffff
 618:	eb 27                	jmp    641 <ata_open+0x96>
		fd->flags = flags;
 61a:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 61d:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
 620:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
		fd->seek_offset = 0;
 623:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 626:	c7 40 04 00 00 00 00 	mov    DWORD PTR [eax+0x4],0x0
 62d:	c7 40 08 00 00 00 00 	mov    DWORD PTR [eax+0x8],0x0
		__sync_fetch_and_add((int*)in->in_ddat, 1);
 634:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 637:	83 c0 68             	add    eax,0x68
 63a:	f0 83 00 01          	lock add DWORD PTR [eax],0x1
		return rv;
 63e:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
}
 641:	83 c4 2c             	add    esp,0x2c
 644:	5b                   	pop    ebx
 645:	5e                   	pop    esi
 646:	5f                   	pop    edi
 647:	5d                   	pop    ebp
 648:	c3                   	ret

00000649 <ata_read>:
{
 649:	55                   	push   ebp
 64a:	89 e5                	mov    ebp,esp
 64c:	57                   	push   edi
 64d:	56                   	push   esi
 64e:	53                   	push   ebx
 64f:	81 ec 8c 00 00 00    	sub    esp,0x8c
		struct fil_fd* f; ssize_t rv = 0;
 655:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
		if (!in || !buf || in->in_stat.st_dev != ata_device.id) {
 65c:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
 660:	74 29                	je     68b <ata_read+0x42>
 662:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
 666:	74 23                	je     68b <ata_read+0x42>
 668:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 66b:	8b 08                	mov    ecx,DWORD PTR [eax]
 66d:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
 670:	a1 00 00 00 00       	mov    eax,ds:0x0
 675:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
 67b:	89 cf                	mov    edi,ecx
 67d:	89 c6                	mov    esi,eax
 67f:	89 d9                	mov    ecx,ebx
 681:	89 f8                	mov    eax,edi
 683:	31 f0                	xor    eax,esi
 685:	31 ca                	xor    edx,ecx
 687:	09 d0                	or     eax,edx
 689:	74 14                	je     69f <ata_read+0x56>
				errno = EINVAL;
 68b:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
				return -1;
 695:	b8 ff ff ff ff       	mov    eax,0xffffffff
 69a:	e9 77 01 00 00       	jmp    816 <ata_read+0x1cd>
		f = fil_fd_get(fd);
 69f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 6a2:	89 04 24             	mov    DWORD PTR [esp],eax
 6a5:	e8 fc ff ff ff       	call   6a6 <ata_read+0x5d>
 6aa:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		n = in->in_pddat;
 6ad:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 6b0:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
 6b3:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		if (!f || (f->flags & O_WRONLY)
 6b6:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
 6ba:	74 0d                	je     6c9 <ata_read+0x80>
 6bc:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 6bf:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
 6c2:	83 e0 01             	and    eax,0x1
 6c5:	85 c0                	test   eax,eax
 6c7:	74 14                	je     6dd <ata_read+0x94>
				errno = EBADF;
 6c9:	c7 05 00 00 00 00 09 00 00 00 	mov    DWORD PTR ds:0x0,0x9
				return -1;
 6d3:	b8 ff ff ff ff       	mov    eax,0xffffffff
 6d8:	e9 39 01 00 00       	jmp    816 <ata_read+0x1cd>
		lba = f->seek_offset / n->gm.lss;
 6dd:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 6e0:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
 6e3:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 6e6:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
 6e9:	8b 49 28             	mov    ecx,DWORD PTR [ecx+0x28]
 6ec:	bb 00 00 00 00       	mov    ebx,0x0
 6f1:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
 6f5:	89 5c 24 0c          	mov    DWORD PTR [esp+0xc],ebx
 6f9:	89 04 24             	mov    DWORD PTR [esp],eax
 6fc:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
 700:	e8 fc ff ff ff       	call   701 <ata_read+0xb8>
 705:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
 708:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
		if (f->seek_offset % n->gm.lss) {
 70b:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 70e:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
 711:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 714:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
 717:	8b 49 28             	mov    ecx,DWORD PTR [ecx+0x28]
 71a:	bb 00 00 00 00       	mov    ebx,0x0
 71f:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
 723:	89 5c 24 0c          	mov    DWORD PTR [esp+0xc],ebx
 727:	89 04 24             	mov    DWORD PTR [esp],eax
 72a:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
 72e:	e8 fc ff ff ff       	call   72f <ata_read+0xe6>
 733:	89 c1                	mov    ecx,eax
 735:	89 c8                	mov    eax,ecx
 737:	09 d0                	or     eax,edx
 739:	74 29                	je     764 <ata_read+0x11b>
				die("not sector aligned\n");
 73b:	c7 44 24 04 cd 00 00 00 	mov    DWORD PTR [esp+0x4],0xcd
 743:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
 74a:	e8 fc ff ff ff       	call   74b <ata_read+0x102>
 74f:	e8 fc ff ff ff       	call   750 <ata_read+0x107>
 754:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 75b:	e8 fc ff ff ff       	call   75c <ata_read+0x113>
 760:	fa                   	cli
 761:	f4                   	hlt
 762:	eb fd                	jmp    761 <ata_read+0x118>
		if (noct > n->gm.lss)
 764:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
 767:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
 76a:	3b 45 14             	cmp    eax,DWORD PTR [ebp+0x14]
 76d:	73 09                	jae    778 <ata_read+0x12f>
				noct = n->gm.lss;
 76f:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
 772:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
 775:	89 45 14             	mov    DWORD PTR [ebp+0x14],eax
		struct wait_queue_head wh = WAIT_QUEUE_HEAD(wh);
 778:	8d 45 c0             	lea    eax,[ebp-0x40]
 77b:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
 77e:	8d 45 c0             	lea    eax,[ebp-0x40]
 781:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
 784:	66 c7 45 c8 00 00    	mov    WORD PTR [ebp-0x38],0x0
 78a:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
		ahci_issue_command(n->ad, n->pt, n->pmprt, disk_cmd_read, lba, noct, buf, &wh, &st);
 791:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 794:	ba 00 00 00 00       	mov    edx,0x0
 799:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
 79c:	0f b7 49 22          	movzx  ecx,WORD PTR [ecx+0x22]
 7a0:	0f b7 f1             	movzx  esi,cx
 7a3:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
 7a6:	0f b7 49 20          	movzx  ecx,WORD PTR [ecx+0x20]
 7aa:	0f b7 d9             	movzx  ebx,cx
 7ad:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
 7b0:	8b 49 10             	mov    ecx,DWORD PTR [ecx+0x10]
 7b3:	8d 7d 98             	lea    edi,[ebp-0x68]
 7b6:	89 7c 24 28          	mov    DWORD PTR [esp+0x28],edi
 7ba:	8d 7d c0             	lea    edi,[ebp-0x40]
 7bd:	89 7c 24 24          	mov    DWORD PTR [esp+0x24],edi
 7c1:	8b 7d 10             	mov    edi,DWORD PTR [ebp+0x10]
 7c4:	89 7c 24 20          	mov    DWORD PTR [esp+0x20],edi
 7c8:	89 44 24 18          	mov    DWORD PTR [esp+0x18],eax
 7cc:	89 54 24 1c          	mov    DWORD PTR [esp+0x1c],edx
 7d0:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
 7d3:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
 7d6:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
 7da:	89 54 24 14          	mov    DWORD PTR [esp+0x14],edx
 7de:	c7 44 24 0c 01 00 00 00 	mov    DWORD PTR [esp+0xc],0x1
 7e6:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
 7ea:	89 5c 24 04          	mov    DWORD PTR [esp+0x4],ebx
 7ee:	89 0c 24             	mov    DWORD PTR [esp],ecx
 7f1:	e8 fc ff ff ff       	call   7f2 <ata_read+0x1a9>
		wait_on_event(&wh);
 7f6:	8d 45 c0             	lea    eax,[ebp-0x40]
 7f9:	89 04 24             	mov    DWORD PTR [esp],eax
 7fc:	e8 fc ff ff ff       	call   7fd <ata_read+0x1b4>
		if (st.state == cmd_state_completed) {
 801:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
 804:	83 f8 03             	cmp    eax,0x3
 807:	75 08                	jne    811 <ata_read+0x1c8>
				return (ssize_t)st.bts_cur;
 809:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
 80c:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
 80f:	eb 05                	jmp    816 <ata_read+0x1cd>
				return -1;
 811:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
 816:	81 c4 8c 00 00 00    	add    esp,0x8c
 81c:	5b                   	pop    ebx
 81d:	5e                   	pop    esi
 81e:	5f                   	pop    edi
 81f:	5d                   	pop    ebp
 820:	c3                   	ret

00000821 <ata_write>:
{
 821:	55                   	push   ebp
 822:	89 e5                	mov    ebp,esp
		return -1;
 824:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
 829:	5d                   	pop    ebp
 82a:	c3                   	ret

0000082b <ata_close>:
{
 82b:	55                   	push   ebp
 82c:	89 e5                	mov    ebp,esp
		return -1;
 82e:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
 833:	5d                   	pop    ebp
 834:	c3                   	ret

00000835 <ata_lseek>:
{
 835:	55                   	push   ebp
 836:	89 e5                	mov    ebp,esp
 838:	83 ec 08             	sub    esp,0x8
 83b:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 83e:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
 841:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 844:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		return -1;
 847:	b8 ff ff ff ff       	mov    eax,0xffffffff
 84c:	ba ff ff ff ff       	mov    edx,0xffffffff
}
 851:	c9                   	leave
 852:	c3                   	ret

00000853 <ata_unlink>:
{
 853:	55                   	push   ebp
 854:	89 e5                	mov    ebp,esp
 856:	56                   	push   esi
 857:	53                   	push   ebx
 858:	83 ec 30             	sub    esp,0x30
		if (in0 || !in1)
 85b:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
 85f:	75 06                	jne    867 <ata_unlink+0x14>
 861:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
 865:	75 07                	jne    86e <ata_unlink+0x1b>
				return -EINVAL;
 867:	b8 ea ff ff ff       	mov    eax,0xffffffea
 86c:	eb 66                	jmp    8d4 <ata_unlink+0x81>
		if (__sync_sub_and_fetch(&in1->in_stat.st_nlink, 1) == 0) {
 86e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 871:	8d 70 14             	lea    esi,[eax+0x14]
 874:	8b 06                	mov    eax,DWORD PTR [esi]
 876:	8b 56 04             	mov    edx,DWORD PTR [esi+0x4]
 879:	89 c1                	mov    ecx,eax
 87b:	89 d3                	mov    ebx,edx
 87d:	83 c1 ff             	add    ecx,0xffffffff
 880:	83 d3 ff             	adc    ebx,0xffffffff
 883:	89 4d e0             	mov    DWORD PTR [ebp-0x20],ecx
 886:	89 5d e4             	mov    DWORD PTR [ebp-0x1c],ebx
 889:	89 4d d8             	mov    DWORD PTR [ebp-0x28],ecx
 88c:	89 5d dc             	mov    DWORD PTR [ebp-0x24],ebx
 88f:	89 cb                	mov    ebx,ecx
 891:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
 894:	f0 0f c7 0e          	lock cmpxchg8b QWORD PTR [esi]
 898:	0f 94 c1             	sete   cl
 89b:	84 c9                	test   cl,cl
 89d:	74 da                	je     879 <ata_unlink+0x26>
 89f:	8b 5d e0             	mov    ebx,DWORD PTR [ebp-0x20]
 8a2:	8b 75 e4             	mov    esi,DWORD PTR [ebp-0x1c]
 8a5:	89 d8                	mov    eax,ebx
 8a7:	89 f2                	mov    edx,esi
 8a9:	09 d0                	or     eax,edx
 8ab:	75 27                	jne    8d4 <ata_unlink+0x81>
				struct ata_node* n = in1->in_pddat;
 8ad:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 8b0:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
 8b3:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				cprintf(KFMT_INFO, "ATA device at dev/%s reached link count zero.\n", n->name);
 8b6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 8b9:	83 c0 40             	add    eax,0x40
 8bc:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
 8c0:	c7 44 24 04 e4 00 00 00 	mov    DWORD PTR [esp+0x4],0xe4
 8c8:	c7 04 24 0b 00 00 00 	mov    DWORD PTR [esp],0xb
 8cf:	e8 fc ff ff ff       	call   8d0 <ata_unlink+0x7d>
}
 8d4:	83 c4 30             	add    esp,0x30
 8d7:	5b                   	pop    ebx
 8d8:	5e                   	pop    esi
 8d9:	5d                   	pop    ebp
 8da:	c3                   	ret
