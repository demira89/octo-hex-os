
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
  67:	83 ec 08             	sub    esp,0x8
  6a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
  6d:	83 c0 08             	add    eax,0x8
  70:	83 ec 0c             	sub    esp,0xc
  73:	50                   	push   eax
  74:	e8 fc ff ff ff       	call   75 <list_add_tail+0x11>
  79:	83 c4 10             	add    esp,0x10
  7c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
  7f:	8b 00                	mov    eax,DWORD PTR [eax]
  81:	83 ec 04             	sub    esp,0x4
  84:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
  87:	50                   	push   eax
  88:	ff 75 08             	push   DWORD PTR [ebp+0x8]
  8b:	e8 ac ff ff ff       	call   3c <__list_add>
  90:	83 c4 10             	add    esp,0x10
  93:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
  96:	83 c0 08             	add    eax,0x8
  99:	83 ec 0c             	sub    esp,0xc
  9c:	50                   	push   eax
  9d:	e8 fc ff ff ff       	call   9e <list_add_tail+0x3a>
  a2:	83 c4 10             	add    esp,0x10
  a5:	90                   	nop
  a6:	c9                   	leave
  a7:	c3                   	ret

000000a8 <sd_format_disk_name>:
{
  a8:	55                   	push   ebp
  a9:	89 e5                	mov    ebp,esp
  ab:	83 ec 28             	sub    esp,0x28
		const int base = 'z' - 'a' + 1;
  ae:	c7 45 f0 1a 00 00 00 	mov    DWORD PTR [ebp-0x10],0x1a
		char *begin = buf + strlen(prefix);
  b5:	83 ec 0c             	sub    esp,0xc
  b8:	ff 75 08             	push   DWORD PTR [ebp+0x8]
  bb:	e8 fc ff ff ff       	call   bc <sd_format_disk_name+0x14>
  c0:	83 c4 10             	add    esp,0x10
  c3:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
  c6:	01 d0                	add    eax,edx
  c8:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		char *end = buf + buflen;
  cb:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
  ce:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
  d1:	01 d0                	add    eax,edx
  d3:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		p = end - 1;
  d6:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
  d9:	83 e8 01             	sub    eax,0x1
  dc:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		*p = '\0';
  df:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
  e2:	c6 00 00             	mov    BYTE PTR [eax],0x0
		unit = base;
  e5:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
  e8:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				if (p == begin)
  eb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
  ee:	3b 45 ec             	cmp    eax,DWORD PTR [ebp-0x14]
  f1:	75 07                	jne    fa <sd_format_disk_name+0x52>
						return -EINVAL;
  f3:	b8 ea ff ff ff       	mov    eax,0xffffffea
  f8:	eb 67                	jmp    161 <sd_format_disk_name+0xb9>
				*--p = 'a' + (index % unit);
  fa:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
  fd:	99                   	cdq
  fe:	f7 7d e4             	idiv   DWORD PTR [ebp-0x1c]
 101:	89 d0                	mov    eax,edx
 103:	83 c0 61             	add    eax,0x61
 106:	83 6d f4 01          	sub    DWORD PTR [ebp-0xc],0x1
 10a:	89 c2                	mov    edx,eax
 10c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 10f:	88 10                	mov    BYTE PTR [eax],dl
				index = (index / unit) - 1;
 111:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 114:	99                   	cdq
 115:	f7 7d e4             	idiv   DWORD PTR [ebp-0x1c]
 118:	83 e8 01             	sub    eax,0x1
 11b:	89 45 0c             	mov    DWORD PTR [ebp+0xc],eax
		} while (index >= 0);
 11e:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
 122:	79 c7                	jns    eb <sd_format_disk_name+0x43>
		memmove(begin, p, end - p);
 124:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 127:	2b 45 f4             	sub    eax,DWORD PTR [ebp-0xc]
 12a:	83 ec 04             	sub    esp,0x4
 12d:	50                   	push   eax
 12e:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
 131:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
 134:	e8 fc ff ff ff       	call   135 <sd_format_disk_name+0x8d>
 139:	83 c4 10             	add    esp,0x10
		memcpy(buf, prefix, strlen(prefix));
 13c:	83 ec 0c             	sub    esp,0xc
 13f:	ff 75 08             	push   DWORD PTR [ebp+0x8]
 142:	e8 fc ff ff ff       	call   143 <sd_format_disk_name+0x9b>
 147:	83 c4 10             	add    esp,0x10
 14a:	83 ec 04             	sub    esp,0x4
 14d:	50                   	push   eax
 14e:	ff 75 08             	push   DWORD PTR [ebp+0x8]
 151:	ff 75 10             	push   DWORD PTR [ebp+0x10]
 154:	e8 a7 fe ff ff       	call   0 <memcpy>
 159:	83 c4 10             	add    esp,0x10
		return 0;
 15c:	b8 00 00 00 00       	mov    eax,0x0
}
 161:	c9                   	leave
 162:	c3                   	ret

00000163 <init_ata_dd>:
{
 163:	55                   	push   ebp
 164:	89 e5                	mov    ebp,esp
 166:	83 ec 08             	sub    esp,0x8
		if (!spin_trylock(&ata_lock)) {
 169:	83 ec 0c             	sub    esp,0xc
 16c:	68 00 00 00 00       	push   0x0
 171:	e8 fc ff ff ff       	call   172 <init_ata_dd+0xf>
 176:	83 c4 10             	add    esp,0x10
 179:	85 c0                	test   eax,eax
 17b:	75 12                	jne    18f <init_ata_dd+0x2c>
				while (!ata_init)
 17d:	eb 05                	jmp    184 <init_ata_dd+0x21>
						task_yield();
 17f:	e8 fc ff ff ff       	call   180 <init_ata_dd+0x1d>
				while (!ata_init)
 184:	a1 00 00 00 00       	mov    eax,ds:0x0
 189:	85 c0                	test   eax,eax
 18b:	74 f2                	je     17f <init_ata_dd+0x1c>
				return;
 18d:	eb 58                	jmp    1e7 <init_ata_dd+0x84>
		if (register_device(&dd_ata) == INVALID_DEVICE) {
 18f:	83 ec 0c             	sub    esp,0xc
 192:	68 00 00 00 00       	push   0x0
 197:	e8 fc ff ff ff       	call   198 <init_ata_dd+0x35>
 19c:	83 c4 10             	add    esp,0x10
 19f:	89 c1                	mov    ecx,eax
 1a1:	89 c8                	mov    eax,ecx
 1a3:	f7 d0                	not    eax
 1a5:	09 d0                	or     eax,edx
 1a7:	75 24                	jne    1cd <init_ata_dd+0x6a>
				cprintf(KFMT_ERROR, "unable to register ATA device object.\n");
 1a9:	83 ec 08             	sub    esp,0x8
 1ac:	68 00 00 00 00       	push   0x0
 1b1:	6a 0c                	push   0xc
 1b3:	e8 fc ff ff ff       	call   1b4 <init_ata_dd+0x51>
 1b8:	83 c4 10             	add    esp,0x10
				spin_unlock(&ata_lock);
 1bb:	83 ec 0c             	sub    esp,0xc
 1be:	68 00 00 00 00       	push   0x0
 1c3:	e8 fc ff ff ff       	call   1c4 <init_ata_dd+0x61>
 1c8:	83 c4 10             	add    esp,0x10
				return;
 1cb:	eb 1a                	jmp    1e7 <init_ata_dd+0x84>
		ata_init = 1;
 1cd:	c7 05 00 00 00 00 01 00 00 00 	mov    DWORD PTR ds:0x0,0x1
		spin_unlock(&ata_lock);
 1d7:	83 ec 0c             	sub    esp,0xc
 1da:	68 00 00 00 00       	push   0x0
 1df:	e8 fc ff ff ff       	call   1e0 <init_ata_dd+0x7d>
 1e4:	83 c4 10             	add    esp,0x10
}
 1e7:	c9                   	leave
 1e8:	c3                   	ret

000001e9 <register_ata_device>:
{
 1e9:	55                   	push   ebp
 1ea:	89 e5                	mov    ebp,esp
 1ec:	57                   	push   edi
 1ed:	56                   	push   esi
 1ee:	53                   	push   ebx
 1ef:	83 ec 2c             	sub    esp,0x2c
 1f2:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 1f5:	66 89 45 d4          	mov    WORD PTR [ebp-0x2c],ax
		if (!ata_init)
 1f9:	a1 00 00 00 00       	mov    eax,ds:0x0
 1fe:	85 c0                	test   eax,eax
 200:	75 05                	jne    207 <register_ata_device+0x1e>
				init_ata_dd();
 202:	e8 fc ff ff ff       	call   203 <register_ata_device+0x1a>
		struct ata_node* n = kzalloc(sizeof(*n));
 207:	83 ec 0c             	sub    esp,0xc
 20a:	6a 54                	push   0x54
 20c:	e8 fc ff ff ff       	call   20d <register_ata_device+0x24>
 211:	83 c4 10             	add    esp,0x10
 214:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		if (!n)
 217:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
 21b:	75 0a                	jne    227 <register_ata_device+0x3e>
				return -ENOMEM;
 21d:	b8 f4 ff ff ff       	mov    eax,0xfffffff4
 222:	e9 26 03 00 00       	jmp    54d <register_ata_device+0x364>
		n->ad = ad;
 227:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 22a:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
 22d:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
		n->id = id;
 230:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 233:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
 236:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
		n->pt = p - ad->ptr->port;
 239:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 23c:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 23f:	05 00 01 00 00       	add    eax,0x100
 244:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
 247:	29 c2                	sub    edx,eax
 249:	89 d0                	mov    eax,edx
 24b:	c1 f8 07             	sar    eax,0x7
 24e:	89 c2                	mov    edx,eax
 250:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 253:	66 89 50 20          	mov    WORD PTR [eax+0x20],dx
		n->pmprt = pmprt;
 257:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 25a:	0f b7 55 d4          	movzx  edx,WORD PTR [ebp-0x2c]
 25e:	66 89 50 22          	mov    WORD PTR [eax+0x22],dx
		n->index = __sync_fetch_and_add(&ata_device.cur_idx, 1);
 262:	ba 01 00 00 00       	mov    edx,0x1
 267:	f0 0f c1 15 08 00 00 00 	lock xadd DWORD PTR ds:0x8,edx
 26f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 272:	89 10                	mov    DWORD PTR [eax],edx
		if (!id->lba_supp) {
 274:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 277:	0f b6 40 63          	movzx  eax,BYTE PTR [eax+0x63]
 27b:	83 e0 02             	and    eax,0x2
 27e:	84 c0                	test   al,al
 280:	75 2b                	jne    2ad <register_ata_device+0xc4>
				die("LBA needed\n");
 282:	83 ec 08             	sub    esp,0x8
 285:	68 27 00 00 00       	push   0x27
 28a:	6a 0c                	push   0xc
 28c:	e8 fc ff ff ff       	call   28d <register_ata_device+0xa4>
 291:	83 c4 10             	add    esp,0x10
 294:	e8 fc ff ff ff       	call   295 <register_ata_device+0xac>
 299:	83 ec 0c             	sub    esp,0xc
 29c:	68 00 00 00 00       	push   0x0
 2a1:	e8 fc ff ff ff       	call   2a2 <register_ata_device+0xb9>
 2a6:	83 c4 10             	add    esp,0x10
 2a9:	fa                   	cli
 2aa:	f4                   	hlt
 2ab:	eb fd                	jmp    2aa <register_ata_device+0xc1>
		} else if (id->has_lba48 || id->has_lba48_alt)
 2ad:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 2b0:	0f b6 80 a7 00 00 00 	movzx  eax,BYTE PTR [eax+0xa7]
 2b7:	83 e0 04             	and    eax,0x4
 2ba:	84 c0                	test   al,al
 2bc:	75 11                	jne    2cf <register_ata_device+0xe6>
 2be:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 2c1:	0f b6 80 ad 00 00 00 	movzx  eax,BYTE PTR [eax+0xad]
 2c8:	83 e0 04             	and    eax,0x4
 2cb:	84 c0                	test   al,al
 2cd:	74 1a                	je     2e9 <register_ata_device+0x100>
				n->gm.max_lba = id->num_logical_sectors;
 2cf:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 2d2:	8b 90 cc 00 00 00    	mov    edx,DWORD PTR [eax+0xcc]
 2d8:	8b 80 c8 00 00 00    	mov    eax,DWORD PTR [eax+0xc8]
 2de:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
 2e1:	89 41 30             	mov    DWORD PTR [ecx+0x30],eax
 2e4:	89 51 34             	mov    DWORD PTR [ecx+0x34],edx
 2e7:	eb 14                	jmp    2fd <register_ata_device+0x114>
				n->gm.max_lba = id->max_lba28;
 2e9:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 2ec:	8b 40 78             	mov    eax,DWORD PTR [eax+0x78]
 2ef:	ba 00 00 00 00       	mov    edx,0x0
 2f4:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
 2f7:	89 41 30             	mov    DWORD PTR [ecx+0x30],eax
 2fa:	89 51 34             	mov    DWORD PTR [ecx+0x34],edx
		if (id->has_multiple_logical_per_physical_sectors) {
 2fd:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 300:	0f b6 80 d5 00 00 00 	movzx  eax,BYTE PTR [eax+0xd5]
 307:	83 e0 20             	and    eax,0x20
 30a:	84 c0                	test   al,al
 30c:	74 26                	je     334 <register_ata_device+0x14b>
				n->gm.lpp = 1 << id->num_pwr2_logical_per_phys;
 30e:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 311:	0f b6 80 d4 00 00 00 	movzx  eax,BYTE PTR [eax+0xd4]
 318:	83 e0 0f             	and    eax,0xf
 31b:	0f b6 c0             	movzx  eax,al
 31e:	ba 01 00 00 00       	mov    edx,0x1
 323:	89 c1                	mov    ecx,eax
 325:	d3 e2                	shl    edx,cl
 327:	89 d0                	mov    eax,edx
 329:	89 c2                	mov    edx,eax
 32b:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 32e:	66 89 50 24          	mov    WORD PTR [eax+0x24],dx
 332:	eb 09                	jmp    33d <register_ata_device+0x154>
				n->gm.lpp = 1;
 334:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 337:	66 c7 40 24 01 00    	mov    WORD PTR [eax+0x24],0x1
		if (id->logical_sector_longer_than_512bt) {
 33d:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 340:	0f b6 80 d5 00 00 00 	movzx  eax,BYTE PTR [eax+0xd5]
 347:	83 e0 10             	and    eax,0x10
 34a:	84 c0                	test   al,al
 34c:	74 14                	je     362 <register_ata_device+0x179>
				n->gm.lss = 2 * id->logical_sector_size;
 34e:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 351:	8b 80 ea 00 00 00    	mov    eax,DWORD PTR [eax+0xea]
 357:	8d 14 00             	lea    edx,[eax+eax*1]
 35a:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 35d:	89 50 28             	mov    DWORD PTR [eax+0x28],edx
 360:	eb 0a                	jmp    36c <register_ata_device+0x183>
				n->gm.lss = 512;
 362:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 365:	c7 40 28 00 02 00 00 	mov    DWORD PTR [eax+0x28],0x200
		n->gm.lof = id->logical_sector_offset;
 36c:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 36f:	0f b6 90 a2 01 00 00 	movzx  edx,BYTE PTR [eax+0x1a2]
 376:	0f b6 80 a3 01 00 00 	movzx  eax,BYTE PTR [eax+0x1a3]
 37d:	83 e0 3f             	and    eax,0x3f
 380:	c1 e0 08             	shl    eax,0x8
 383:	09 d0                	or     eax,edx
 385:	89 c2                	mov    edx,eax
 387:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 38a:	66 89 50 26          	mov    WORD PTR [eax+0x26],dx
		n->cache = create_disk_cache(&n->gm);
 38e:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 391:	83 c0 24             	add    eax,0x24
 394:	83 ec 0c             	sub    esp,0xc
 397:	50                   	push   eax
 398:	e8 fc ff ff ff       	call   399 <register_ata_device+0x1b0>
 39d:	83 c4 10             	add    esp,0x10
 3a0:	89 c2                	mov    edx,eax
 3a2:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 3a5:	89 50 1c             	mov    DWORD PTR [eax+0x1c],edx
		list_add_tail(&n->lst, &ata_device.nodes);
 3a8:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 3ab:	83 c0 04             	add    eax,0x4
 3ae:	83 ec 08             	sub    esp,0x8
 3b1:	68 0c 00 00 00       	push   0xc
 3b6:	50                   	push   eax
 3b7:	e8 a8 fc ff ff       	call   64 <list_add_tail>
 3bc:	83 c4 10             	add    esp,0x10
		struct inode *in_dev = get_special_inode(INO_DEV), *in;
 3bf:	83 ec 0c             	sub    esp,0xc
 3c2:	6a 01                	push   0x1
 3c4:	e8 fc ff ff ff       	call   3c5 <register_ata_device+0x1dc>
 3c9:	83 c4 10             	add    esp,0x10
 3cc:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		in = ino_allocate(S_IFBLK); /* times have been set */
 3cf:	83 ec 0c             	sub    esp,0xc
 3d2:	68 00 60 00 00       	push   0x6000
 3d7:	e8 fc ff ff ff       	call   3d8 <register_ata_device+0x1ef>
 3dc:	83 c4 10             	add    esp,0x10
 3df:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		if (!in_dev || !in) {
 3e2:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
 3e6:	74 06                	je     3ee <register_ata_device+0x205>
 3e8:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
 3ec:	75 2b                	jne    419 <register_ata_device+0x230>
				die("/dev is not present or inode allocation failed\n");
 3ee:	83 ec 08             	sub    esp,0x8
 3f1:	68 34 00 00 00       	push   0x34
 3f6:	6a 0c                	push   0xc
 3f8:	e8 fc ff ff ff       	call   3f9 <register_ata_device+0x210>
 3fd:	83 c4 10             	add    esp,0x10
 400:	e8 fc ff ff ff       	call   401 <register_ata_device+0x218>
 405:	83 ec 0c             	sub    esp,0xc
 408:	68 00 00 00 00       	push   0x0
 40d:	e8 fc ff ff ff       	call   40e <register_ata_device+0x225>
 412:	83 c4 10             	add    esp,0x10
 415:	fa                   	cli
 416:	f4                   	hlt
 417:	eb fd                	jmp    416 <register_ata_device+0x22d>
		in->in_pddat = n;
 419:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
 41c:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
 41f:	89 50 70             	mov    DWORD PTR [eax+0x70],edx
		in->in_stat.st_dev = ata_device.id;
 422:	a1 00 00 00 00       	mov    eax,ds:0x0
 427:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
 42d:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
 430:	89 01                	mov    DWORD PTR [ecx],eax
 432:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		in->in_stat.st_blksize = n->gm.pss; /* preferred blocksize */
 435:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 438:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
 43b:	ba 00 00 00 00       	mov    edx,0x0
 440:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
 443:	89 41 34             	mov    DWORD PTR [ecx+0x34],eax
 446:	89 51 38             	mov    DWORD PTR [ecx+0x38],edx
		in->in_stat.st_blocks = n->gm.max_lba * n->gm.lss / 512; /* LBA48 no overflow */
 449:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 44c:	8b 50 34             	mov    edx,DWORD PTR [eax+0x34]
 44f:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
 452:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
 455:	8b 49 28             	mov    ecx,DWORD PTR [ecx+0x28]
 458:	bb 00 00 00 00       	mov    ebx,0x0
 45d:	89 d7                	mov    edi,edx
 45f:	0f af f9             	imul   edi,ecx
 462:	89 de                	mov    esi,ebx
 464:	0f af f0             	imul   esi,eax
 467:	01 fe                	add    esi,edi
 469:	f7 e1                	mul    ecx
 46b:	8d 0c 16             	lea    ecx,[esi+edx*1]
 46e:	89 ca                	mov    edx,ecx
 470:	0f ac d0 09          	shrd   eax,edx,0x9
 474:	c1 ea 09             	shr    edx,0x9
 477:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
 47a:	89 41 3c             	mov    DWORD PTR [ecx+0x3c],eax
 47d:	89 51 40             	mov    DWORD PTR [ecx+0x40],edx
		in->in_stat.st_size = n->gm.max_lba * n->gm.lss;
 480:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 483:	8b 50 34             	mov    edx,DWORD PTR [eax+0x34]
 486:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
 489:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
 48c:	8b 49 28             	mov    ecx,DWORD PTR [ecx+0x28]
 48f:	bb 00 00 00 00       	mov    ebx,0x0
 494:	89 d7                	mov    edi,edx
 496:	0f af f9             	imul   edi,ecx
 499:	89 de                	mov    esi,ebx
 49b:	0f af f0             	imul   esi,eax
 49e:	01 fe                	add    esi,edi
 4a0:	f7 e1                	mul    ecx
 4a2:	8d 0c 16             	lea    ecx,[esi+edx*1]
 4a5:	89 ca                	mov    edx,ecx
 4a7:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
 4aa:	89 41 2c             	mov    DWORD PTR [ecx+0x2c],eax
 4ad:	89 51 30             	mov    DWORD PTR [ecx+0x30],edx
		dd_d = get_device(in_dev->in_stat.st_dev);
 4b0:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 4b3:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
 4b6:	8b 00                	mov    eax,DWORD PTR [eax]
 4b8:	83 ec 08             	sub    esp,0x8
 4bb:	52                   	push   edx
 4bc:	50                   	push   eax
 4bd:	e8 fc ff ff ff       	call   4be <register_ata_device+0x2d5>
 4c2:	83 c4 10             	add    esp,0x10
 4c5:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
		if (sd_format_disk_name("sd", n->index, n->name, sizeof(n->name)))
 4c8:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 4cb:	8d 50 40             	lea    edx,[eax+0x40]
 4ce:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 4d1:	8b 00                	mov    eax,DWORD PTR [eax]
 4d3:	6a 14                	push   0x14
 4d5:	52                   	push   edx
 4d6:	50                   	push   eax
 4d7:	68 64 00 00 00       	push   0x64
 4dc:	e8 fc ff ff ff       	call   4dd <register_ata_device+0x2f4>
 4e1:	83 c4 10             	add    esp,0x10
 4e4:	85 c0                	test   eax,eax
 4e6:	74 12                	je     4fa <register_ata_device+0x311>
				cprintf(KFMT_WARN, "too many sdX devices\n");
 4e8:	83 ec 08             	sub    esp,0x8
 4eb:	68 67 00 00 00       	push   0x67
 4f0:	6a 0e                	push   0xe
 4f2:	e8 fc ff ff ff       	call   4f3 <register_ata_device+0x30a>
 4f7:	83 c4 10             	add    esp,0x10
		if (dd_d->fn_set_subnode(in_dev, in, n->name) == 0)
 4fa:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
 4fd:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
 500:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
 503:	83 c2 40             	add    edx,0x40
 506:	83 ec 04             	sub    esp,0x4
 509:	52                   	push   edx
 50a:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
 50d:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
 510:	ff d0                	call   eax
 512:	83 c4 10             	add    esp,0x10
 515:	85 c0                	test   eax,eax
 517:	75 1b                	jne    534 <register_ata_device+0x34b>
				cprintf(KFMT_OK, "registered ATA device at dev/%s\n", n->name);
 519:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 51c:	83 c0 40             	add    eax,0x40
 51f:	83 ec 04             	sub    esp,0x4
 522:	50                   	push   eax
 523:	68 80 00 00 00       	push   0x80
 528:	6a 0a                	push   0xa
 52a:	e8 fc ff ff ff       	call   52b <register_ata_device+0x342>
 52f:	83 c4 10             	add    esp,0x10
 532:	eb 19                	jmp    54d <register_ata_device+0x364>
				cprintf(KFMT_WARN, "unable to register ATA device at dev/%s\n", n->name);
 534:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 537:	83 c0 40             	add    eax,0x40
 53a:	83 ec 04             	sub    esp,0x4
 53d:	50                   	push   eax
 53e:	68 a4 00 00 00       	push   0xa4
 543:	6a 0e                	push   0xe
 545:	e8 fc ff ff ff       	call   546 <register_ata_device+0x35d>
 54a:	83 c4 10             	add    esp,0x10
}
 54d:	8d 65 f4             	lea    esp,[ebp-0xc]
 550:	5b                   	pop    ebx
 551:	5e                   	pop    esi
 552:	5f                   	pop    edi
 553:	5d                   	pop    ebp
 554:	c3                   	ret

00000555 <ata_register_device>:
{
 555:	55                   	push   ebp
 556:	89 e5                	mov    ebp,esp
 558:	83 ec 18             	sub    esp,0x18
 55b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 55e:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
 561:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 564:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		ata_device.id = d;
 567:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
 56a:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
 56d:	a3 00 00 00 00       	mov    ds:0x0,eax
 572:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
		ata_device.cur_idx = 0;
 578:	c7 05 08 00 00 00 00 00 00 00 	mov    DWORD PTR ds:0x8,0x0
		ata_device.nodes = LIST_HEAD_INIT(ata_device.nodes);
 582:	c7 05 0c 00 00 00 0c 00 00 00 	mov    DWORD PTR ds:0xc,0xc
 58c:	c7 05 10 00 00 00 0c 00 00 00 	mov    DWORD PTR ds:0x10,0xc
 596:	66 c7 05 14 00 00 00 00 00 	mov    WORD PTR ds:0x14,0x0
		return 0;
 59f:	b8 00 00 00 00       	mov    eax,0x0
}
 5a4:	c9                   	leave
 5a5:	c3                   	ret

000005a6 <ata_unregister_device>:
{
 5a6:	55                   	push   ebp
 5a7:	89 e5                	mov    ebp,esp
		return -1;
 5a9:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
 5ae:	5d                   	pop    ebp
 5af:	c3                   	ret

000005b0 <ata_open>:
{
 5b0:	55                   	push   ebp
 5b1:	89 e5                	mov    ebp,esp
 5b3:	57                   	push   edi
 5b4:	56                   	push   esi
 5b5:	53                   	push   ebx
 5b6:	83 ec 1c             	sub    esp,0x1c
		if (!in || in->in_stat.st_dev != ata_device.id) {
 5b9:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
 5bd:	74 23                	je     5e2 <ata_open+0x32>
 5bf:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 5c2:	8b 08                	mov    ecx,DWORD PTR [eax]
 5c4:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
 5c7:	a1 00 00 00 00       	mov    eax,ds:0x0
 5cc:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
 5d2:	89 cf                	mov    edi,ecx
 5d4:	89 c6                	mov    esi,eax
 5d6:	89 d9                	mov    ecx,ebx
 5d8:	89 f8                	mov    eax,edi
 5da:	31 f0                	xor    eax,esi
 5dc:	31 ca                	xor    edx,ecx
 5de:	09 d0                	or     eax,edx
 5e0:	74 11                	je     5f3 <ata_open+0x43>
				errno = EINVAL;
 5e2:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
				return -1;
 5ec:	b8 ff ff ff ff       	mov    eax,0xffffffff
 5f1:	eb 53                	jmp    646 <ata_open+0x96>
		fd = fil_fd_allocate(in, &rv);
 5f3:	83 ec 08             	sub    esp,0x8
 5f6:	8d 45 e0             	lea    eax,[ebp-0x20]
 5f9:	50                   	push   eax
 5fa:	ff 75 08             	push   DWORD PTR [ebp+0x8]
 5fd:	e8 fc ff ff ff       	call   5fe <ata_open+0x4e>
 602:	83 c4 10             	add    esp,0x10
 605:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		if (!fd) {
 608:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
 60c:	75 11                	jne    61f <ata_open+0x6f>
				errno = ENOMEM;
 60e:	c7 05 00 00 00 00 0c 00 00 00 	mov    DWORD PTR ds:0x0,0xc
				return -1;
 618:	b8 ff ff ff ff       	mov    eax,0xffffffff
 61d:	eb 27                	jmp    646 <ata_open+0x96>
		fd->flags = flags;
 61f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 622:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
 625:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
		fd->seek_offset = 0;
 628:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
 62b:	c7 40 04 00 00 00 00 	mov    DWORD PTR [eax+0x4],0x0
 632:	c7 40 08 00 00 00 00 	mov    DWORD PTR [eax+0x8],0x0
		__sync_fetch_and_add((int*)in->in_ddat, 1);
 639:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 63c:	83 c0 68             	add    eax,0x68
 63f:	f0 83 00 01          	lock add DWORD PTR [eax],0x1
		return rv;
 643:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
}
 646:	8d 65 f4             	lea    esp,[ebp-0xc]
 649:	5b                   	pop    ebx
 64a:	5e                   	pop    esi
 64b:	5f                   	pop    edi
 64c:	5d                   	pop    ebp
 64d:	c3                   	ret

0000064e <ata_read>:
{
 64e:	55                   	push   ebp
 64f:	89 e5                	mov    ebp,esp
 651:	57                   	push   edi
 652:	56                   	push   esi
 653:	53                   	push   ebx
 654:	83 ec 5c             	sub    esp,0x5c
		struct fil_fd* f; ssize_t rv = 0;
 657:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
		if (!in || !buf || in->in_stat.st_dev != ata_device.id) {
 65e:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
 662:	74 29                	je     68d <ata_read+0x3f>
 664:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
 668:	74 23                	je     68d <ata_read+0x3f>
 66a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 66d:	8b 08                	mov    ecx,DWORD PTR [eax]
 66f:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
 672:	a1 00 00 00 00       	mov    eax,ds:0x0
 677:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
 67d:	89 cf                	mov    edi,ecx
 67f:	89 c6                	mov    esi,eax
 681:	89 d9                	mov    ecx,ebx
 683:	89 f8                	mov    eax,edi
 685:	31 f0                	xor    eax,esi
 687:	31 ca                	xor    edx,ecx
 689:	09 d0                	or     eax,edx
 68b:	74 14                	je     6a1 <ata_read+0x53>
				errno = EINVAL;
 68d:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
				return -1;
 697:	b8 ff ff ff ff       	mov    eax,0xffffffff
 69c:	e9 50 01 00 00       	jmp    7f1 <ata_read+0x1a3>
		f = fil_fd_get(fd);
 6a1:	83 ec 0c             	sub    esp,0xc
 6a4:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
 6a7:	e8 fc ff ff ff       	call   6a8 <ata_read+0x5a>
 6ac:	83 c4 10             	add    esp,0x10
 6af:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		n = in->in_pddat;
 6b2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 6b5:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
 6b8:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		if (!f || (f->flags & O_WRONLY)
 6bb:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
 6bf:	74 0d                	je     6ce <ata_read+0x80>
 6c1:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 6c4:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
 6c7:	83 e0 01             	and    eax,0x1
 6ca:	85 c0                	test   eax,eax
 6cc:	74 14                	je     6e2 <ata_read+0x94>
				errno = EBADF;
 6ce:	c7 05 00 00 00 00 09 00 00 00 	mov    DWORD PTR ds:0x0,0x9
				return -1;
 6d8:	b8 ff ff ff ff       	mov    eax,0xffffffff
 6dd:	e9 0f 01 00 00       	jmp    7f1 <ata_read+0x1a3>
		lba = f->seek_offset / n->gm.lss;
 6e2:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 6e5:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
 6e8:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 6eb:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
 6ee:	8b 49 28             	mov    ecx,DWORD PTR [ecx+0x28]
 6f1:	bb 00 00 00 00       	mov    ebx,0x0
 6f6:	53                   	push   ebx
 6f7:	51                   	push   ecx
 6f8:	52                   	push   edx
 6f9:	50                   	push   eax
 6fa:	e8 fc ff ff ff       	call   6fb <ata_read+0xad>
 6ff:	83 c4 10             	add    esp,0x10
 702:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
 705:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
		if (f->seek_offset % n->gm.lss) {
 708:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
 70b:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
 70e:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
 711:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
 714:	8b 49 28             	mov    ecx,DWORD PTR [ecx+0x28]
 717:	bb 00 00 00 00       	mov    ebx,0x0
 71c:	53                   	push   ebx
 71d:	51                   	push   ecx
 71e:	52                   	push   edx
 71f:	50                   	push   eax
 720:	e8 fc ff ff ff       	call   721 <ata_read+0xd3>
 725:	83 c4 10             	add    esp,0x10
 728:	89 c1                	mov    ecx,eax
 72a:	89 c8                	mov    eax,ecx
 72c:	09 d0                	or     eax,edx
 72e:	74 2b                	je     75b <ata_read+0x10d>
				die("not sector aligned\n");
 730:	83 ec 08             	sub    esp,0x8
 733:	68 cd 00 00 00       	push   0xcd
 738:	6a 0c                	push   0xc
 73a:	e8 fc ff ff ff       	call   73b <ata_read+0xed>
 73f:	83 c4 10             	add    esp,0x10
 742:	e8 fc ff ff ff       	call   743 <ata_read+0xf5>
 747:	83 ec 0c             	sub    esp,0xc
 74a:	68 00 00 00 00       	push   0x0
 74f:	e8 fc ff ff ff       	call   750 <ata_read+0x102>
 754:	83 c4 10             	add    esp,0x10
 757:	fa                   	cli
 758:	f4                   	hlt
 759:	eb fd                	jmp    758 <ata_read+0x10a>
		if (noct > n->gm.lss)
 75b:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
 75e:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
 761:	3b 45 14             	cmp    eax,DWORD PTR [ebp+0x14]
 764:	73 09                	jae    76f <ata_read+0x121>
				noct = n->gm.lss;
 766:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
 769:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
 76c:	89 45 14             	mov    DWORD PTR [ebp+0x14],eax
		struct wait_queue_head wh = WAIT_QUEUE_HEAD(wh);
 76f:	8d 45 c0             	lea    eax,[ebp-0x40]
 772:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
 775:	8d 45 c0             	lea    eax,[ebp-0x40]
 778:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
 77b:	66 c7 45 c8 00 00    	mov    WORD PTR [ebp-0x38],0x0
 781:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
		ahci_issue_command(n->ad, n->pt, n->pmprt, disk_cmd_read, lba, noct, buf, &wh, &st);
 788:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 78b:	ba 00 00 00 00       	mov    edx,0x0
 790:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
 793:	0f b7 49 22          	movzx  ecx,WORD PTR [ecx+0x22]
 797:	0f b7 f1             	movzx  esi,cx
 79a:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
 79d:	0f b7 49 20          	movzx  ecx,WORD PTR [ecx+0x20]
 7a1:	0f b7 d9             	movzx  ebx,cx
 7a4:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
 7a7:	8b 49 10             	mov    ecx,DWORD PTR [ecx+0x10]
 7aa:	83 ec 04             	sub    esp,0x4
 7ad:	8d 7d 98             	lea    edi,[ebp-0x68]
 7b0:	57                   	push   edi
 7b1:	8d 7d c0             	lea    edi,[ebp-0x40]
 7b4:	57                   	push   edi
 7b5:	ff 75 10             	push   DWORD PTR [ebp+0x10]
 7b8:	52                   	push   edx
 7b9:	50                   	push   eax
 7ba:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
 7bd:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
 7c0:	6a 01                	push   0x1
 7c2:	56                   	push   esi
 7c3:	53                   	push   ebx
 7c4:	51                   	push   ecx
 7c5:	e8 fc ff ff ff       	call   7c6 <ata_read+0x178>
 7ca:	83 c4 30             	add    esp,0x30
		wait_on_event(&wh);
 7cd:	83 ec 0c             	sub    esp,0xc
 7d0:	8d 45 c0             	lea    eax,[ebp-0x40]
 7d3:	50                   	push   eax
 7d4:	e8 fc ff ff ff       	call   7d5 <ata_read+0x187>
 7d9:	83 c4 10             	add    esp,0x10
		if (st.state == cmd_state_completed) {
 7dc:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
 7df:	83 f8 03             	cmp    eax,0x3
 7e2:	75 08                	jne    7ec <ata_read+0x19e>
				return (ssize_t)st.bts_cur;
 7e4:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
 7e7:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
 7ea:	eb 05                	jmp    7f1 <ata_read+0x1a3>
				return -1;
 7ec:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
 7f1:	8d 65 f4             	lea    esp,[ebp-0xc]
 7f4:	5b                   	pop    ebx
 7f5:	5e                   	pop    esi
 7f6:	5f                   	pop    edi
 7f7:	5d                   	pop    ebp
 7f8:	c3                   	ret

000007f9 <ata_write>:
{
 7f9:	55                   	push   ebp
 7fa:	89 e5                	mov    ebp,esp
		return -1;
 7fc:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
 801:	5d                   	pop    ebp
 802:	c3                   	ret

00000803 <ata_close>:
{
 803:	55                   	push   ebp
 804:	89 e5                	mov    ebp,esp
		return -1;
 806:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
 80b:	5d                   	pop    ebp
 80c:	c3                   	ret

0000080d <ata_lseek>:
{
 80d:	55                   	push   ebp
 80e:	89 e5                	mov    ebp,esp
 810:	83 ec 08             	sub    esp,0x8
 813:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 816:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
 819:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
 81c:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		return -1;
 81f:	b8 ff ff ff ff       	mov    eax,0xffffffff
 824:	ba ff ff ff ff       	mov    edx,0xffffffff
}
 829:	c9                   	leave
 82a:	c3                   	ret

0000082b <ata_unlink>:
{
 82b:	55                   	push   ebp
 82c:	89 e5                	mov    ebp,esp
 82e:	56                   	push   esi
 82f:	53                   	push   ebx
 830:	83 ec 20             	sub    esp,0x20
		if (in0 || !in1)
 833:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
 837:	75 06                	jne    83f <ata_unlink+0x14>
 839:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
 83d:	75 07                	jne    846 <ata_unlink+0x1b>
				return -EINVAL;
 83f:	b8 ea ff ff ff       	mov    eax,0xffffffea
 844:	eb 61                	jmp    8a7 <ata_unlink+0x7c>
		if (__sync_sub_and_fetch(&in1->in_stat.st_nlink, 1) == 0) {
 846:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 849:	8d 70 14             	lea    esi,[eax+0x14]
 84c:	8b 06                	mov    eax,DWORD PTR [esi]
 84e:	8b 56 04             	mov    edx,DWORD PTR [esi+0x4]
 851:	89 c1                	mov    ecx,eax
 853:	89 d3                	mov    ebx,edx
 855:	83 c1 ff             	add    ecx,0xffffffff
 858:	83 d3 ff             	adc    ebx,0xffffffff
 85b:	89 4d e0             	mov    DWORD PTR [ebp-0x20],ecx
 85e:	89 5d e4             	mov    DWORD PTR [ebp-0x1c],ebx
 861:	89 4d d8             	mov    DWORD PTR [ebp-0x28],ecx
 864:	89 5d dc             	mov    DWORD PTR [ebp-0x24],ebx
 867:	89 cb                	mov    ebx,ecx
 869:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
 86c:	f0 0f c7 0e          	lock cmpxchg8b QWORD PTR [esi]
 870:	0f 94 c1             	sete   cl
 873:	84 c9                	test   cl,cl
 875:	74 da                	je     851 <ata_unlink+0x26>
 877:	8b 5d e0             	mov    ebx,DWORD PTR [ebp-0x20]
 87a:	8b 75 e4             	mov    esi,DWORD PTR [ebp-0x1c]
 87d:	89 d8                	mov    eax,ebx
 87f:	89 f2                	mov    edx,esi
 881:	09 d0                	or     eax,edx
 883:	75 22                	jne    8a7 <ata_unlink+0x7c>
				struct ata_node* n = in1->in_pddat;
 885:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 888:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
 88b:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				cprintf(KFMT_INFO, "ATA device at dev/%s reached link count zero.\n", n->name);
 88e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 891:	83 c0 40             	add    eax,0x40
 894:	83 ec 04             	sub    esp,0x4
 897:	50                   	push   eax
 898:	68 e4 00 00 00       	push   0xe4
 89d:	6a 0b                	push   0xb
 89f:	e8 fc ff ff ff       	call   8a0 <ata_unlink+0x75>
 8a4:	83 c4 10             	add    esp,0x10
}
 8a7:	8d 65 f8             	lea    esp,[ebp-0x8]
 8aa:	5b                   	pop    ebx
 8ab:	5e                   	pop    esi
 8ac:	5d                   	pop    ebp
 8ad:	c3                   	ret
