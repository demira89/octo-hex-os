
ata_drive.o64:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <memcpy>:
   0:	55                   	push   rbp
   1:	48 89 e5             	mov    rbp,rsp
   4:	48 83 ec 28          	sub    rsp,0x28
   8:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
   c:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
  10:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
  14:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
  18:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
  1c:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
  20:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
  24:	eb 1d                	jmp    43 <memcpy+0x43>
  26:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
  2a:	48 8d 42 01          	lea    rax,[rdx+0x1]
  2e:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
  32:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
  36:	48 8d 48 01          	lea    rcx,[rax+0x1]
  3a:	48 89 4d f8          	mov    QWORD PTR [rbp-0x8],rcx
  3e:	0f b6 12             	movzx  edx,BYTE PTR [rdx]
  41:	88 10                	mov    BYTE PTR [rax],dl
  43:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
  47:	48 8d 50 ff          	lea    rdx,[rax-0x1]
  4b:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
  4f:	48 85 c0             	test   rax,rax
  52:	75 d2                	jne    26 <memcpy+0x26>
  54:	90                   	nop
  55:	90                   	nop
  56:	c9                   	leave
  57:	c3                   	ret

0000000000000058 <__list_add>:
  58:	55                   	push   rbp
  59:	48 89 e5             	mov    rbp,rsp
  5c:	48 83 ec 18          	sub    rsp,0x18
  60:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
  64:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
  68:	48 89 55 e8          	mov    QWORD PTR [rbp-0x18],rdx
  6c:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
  70:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
  74:	48 89 10             	mov    QWORD PTR [rax],rdx
  77:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
  7b:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
  7f:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
  83:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
  87:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
  8b:	48 89 10             	mov    QWORD PTR [rax],rdx
  8e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
  92:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
  96:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
  9a:	90                   	nop
  9b:	c9                   	leave
  9c:	c3                   	ret

000000000000009d <list_add_tail>:
  9d:	55                   	push   rbp
  9e:	48 89 e5             	mov    rbp,rsp
  a1:	48 83 ec 10          	sub    rsp,0x10
  a5:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
  a9:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
  ad:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
  b1:	48 83 c0 10          	add    rax,0x10
  b5:	48 89 c7             	mov    rdi,rax
  b8:	e8 00 00 00 00       	call   bd <list_add_tail+0x20>
  bd:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
  c1:	48 8b 08             	mov    rcx,QWORD PTR [rax]
  c4:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
  c8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
  cc:	48 89 ce             	mov    rsi,rcx
  cf:	48 89 c7             	mov    rdi,rax
  d2:	e8 81 ff ff ff       	call   58 <__list_add>
  d7:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
  db:	48 83 c0 10          	add    rax,0x10
  df:	48 89 c7             	mov    rdi,rax
  e2:	e8 00 00 00 00       	call   e7 <list_add_tail+0x4a>
  e7:	90                   	nop
  e8:	c9                   	leave
  e9:	c3                   	ret

00000000000000ea <sd_format_disk_name>:
{
  ea:	55                   	push   rbp
  eb:	48 89 e5             	mov    rbp,rsp
  ee:	48 83 ec 50          	sub    rsp,0x50
  f2:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
  f6:	89 75 c4             	mov    DWORD PTR [rbp-0x3c],esi
  f9:	48 89 55 b8          	mov    QWORD PTR [rbp-0x48],rdx
  fd:	89 4d c0             	mov    DWORD PTR [rbp-0x40],ecx
		const int base = 'z' - 'a' + 1;
 100:	c7 45 f4 1a 00 00 00 	mov    DWORD PTR [rbp-0xc],0x1a
		char *begin = buf + strlen(prefix);
 107:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
 10b:	48 89 c7             	mov    rdi,rax
 10e:	e8 00 00 00 00       	call   113 <sd_format_disk_name+0x29>
 113:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
 117:	48 01 d0             	add    rax,rdx
 11a:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		char *end = buf + buflen;
 11e:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
 121:	48 63 d0             	movsxd rdx,eax
 124:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
 128:	48 01 d0             	add    rax,rdx
 12b:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
		p = end - 1;
 12f:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 133:	48 83 e8 01          	sub    rax,0x1
 137:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		*p = '\0';
 13b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 13f:	c6 00 00             	mov    BYTE PTR [rax],0x0
		unit = base;
 142:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
 145:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
				if (p == begin)
 148:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 14c:	48 3b 45 e8          	cmp    rax,QWORD PTR [rbp-0x18]
 150:	75 07                	jne    159 <sd_format_disk_name+0x6f>
						return -EINVAL;
 152:	b8 ea ff ff ff       	mov    eax,0xffffffea
 157:	eb 71                	jmp    1ca <sd_format_disk_name+0xe0>
				*--p = 'a' + (index % unit);
 159:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
 15c:	99                   	cdq
 15d:	f7 7d dc             	idiv   DWORD PTR [rbp-0x24]
 160:	89 d0                	mov    eax,edx
 162:	83 c0 61             	add    eax,0x61
 165:	48 83 6d f8 01       	sub    QWORD PTR [rbp-0x8],0x1
 16a:	89 c2                	mov    edx,eax
 16c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 170:	88 10                	mov    BYTE PTR [rax],dl
				index = (index / unit) - 1;
 172:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
 175:	99                   	cdq
 176:	f7 7d dc             	idiv   DWORD PTR [rbp-0x24]
 179:	83 e8 01             	sub    eax,0x1
 17c:	89 45 c4             	mov    DWORD PTR [rbp-0x3c],eax
		} while (index >= 0);
 17f:	83 7d c4 00          	cmp    DWORD PTR [rbp-0x3c],0x0
 183:	79 c3                	jns    148 <sd_format_disk_name+0x5e>
		memmove(begin, p, end - p);
 185:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 189:	48 2b 45 f8          	sub    rax,QWORD PTR [rbp-0x8]
 18d:	48 89 c2             	mov    rdx,rax
 190:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
 194:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 198:	48 89 ce             	mov    rsi,rcx
 19b:	48 89 c7             	mov    rdi,rax
 19e:	e8 00 00 00 00       	call   1a3 <sd_format_disk_name+0xb9>
		memcpy(buf, prefix, strlen(prefix));
 1a3:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
 1a7:	48 89 c7             	mov    rdi,rax
 1aa:	e8 00 00 00 00       	call   1af <sd_format_disk_name+0xc5>
 1af:	48 89 c2             	mov    rdx,rax
 1b2:	48 8b 4d c8          	mov    rcx,QWORD PTR [rbp-0x38]
 1b6:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
 1ba:	48 89 ce             	mov    rsi,rcx
 1bd:	48 89 c7             	mov    rdi,rax
 1c0:	e8 3b fe ff ff       	call   0 <memcpy>
		return 0;
 1c5:	b8 00 00 00 00       	mov    eax,0x0
}
 1ca:	c9                   	leave
 1cb:	c3                   	ret

00000000000001cc <init_ata_dd>:
{
 1cc:	55                   	push   rbp
 1cd:	48 89 e5             	mov    rbp,rsp
		if (!spin_trylock(&ata_lock)) {
 1d0:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 1d7:	e8 00 00 00 00       	call   1dc <init_ata_dd+0x10>
 1dc:	85 c0                	test   eax,eax
 1de:	75 18                	jne    1f8 <init_ata_dd+0x2c>
				while (!ata_init)
 1e0:	eb 0a                	jmp    1ec <init_ata_dd+0x20>
						task_yield();
 1e2:	b8 00 00 00 00       	mov    eax,0x0
 1e7:	e8 00 00 00 00       	call   1ec <init_ata_dd+0x20>
				while (!ata_init)
 1ec:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 1f2 <init_ata_dd+0x26>
 1f2:	85 c0                	test   eax,eax
 1f4:	74 ec                	je     1e2 <init_ata_dd+0x16>
				return;
 1f6:	eb 4c                	jmp    244 <init_ata_dd+0x78>
		if (register_device(&dd_ata) == INVALID_DEVICE) {
 1f8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 1ff:	e8 00 00 00 00       	call   204 <init_ata_dd+0x38>
 204:	48 83 f8 ff          	cmp    rax,0xffffffffffffffff
 208:	75 24                	jne    22e <init_ata_dd+0x62>
				cprintf(KFMT_ERROR, "unable to register ATA device object.\n");
 20a:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
 211:	bf 0c 00 00 00       	mov    edi,0xc
 216:	b8 00 00 00 00       	mov    eax,0x0
 21b:	e8 00 00 00 00       	call   220 <init_ata_dd+0x54>
				spin_unlock(&ata_lock);
 220:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 227:	e8 00 00 00 00       	call   22c <init_ata_dd+0x60>
				return;
 22c:	eb 16                	jmp    244 <init_ata_dd+0x78>
		ata_init = 1;
 22e:	c7 05 00 00 00 00 01 00 00 00 	mov    DWORD PTR [rip+0x0],0x1        # 238 <init_ata_dd+0x6c>
		spin_unlock(&ata_lock);
 238:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 23f:	e8 00 00 00 00       	call   244 <init_ata_dd+0x78>
}
 244:	5d                   	pop    rbp
 245:	c3                   	ret

0000000000000246 <register_ata_device>:
{
 246:	55                   	push   rbp
 247:	48 89 e5             	mov    rbp,rsp
 24a:	48 83 ec 40          	sub    rsp,0x40
 24e:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
 252:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi
 256:	89 d0                	mov    eax,edx
 258:	48 89 4d c0          	mov    QWORD PTR [rbp-0x40],rcx
 25c:	66 89 45 cc          	mov    WORD PTR [rbp-0x34],ax
		if (!ata_init)
 260:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 266 <register_ata_device+0x20>
 266:	85 c0                	test   eax,eax
 268:	75 0a                	jne    274 <register_ata_device+0x2e>
				init_ata_dd();
 26a:	b8 00 00 00 00       	mov    eax,0x0
 26f:	e8 00 00 00 00       	call   274 <register_ata_device+0x2e>
		struct ata_node* n = kzalloc(sizeof(*n));
 274:	bf 80 00 00 00       	mov    edi,0x80
 279:	e8 00 00 00 00       	call   27e <register_ata_device+0x38>
 27e:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (!n)
 282:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
 287:	75 0a                	jne    293 <register_ata_device+0x4d>
				return -ENOMEM;
 289:	b8 f4 ff ff ff       	mov    eax,0xfffffff4
 28e:	e9 42 03 00 00       	jmp    5d5 <register_ata_device+0x38f>
		n->ad = ad;
 293:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 297:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
 29b:	48 89 50 20          	mov    QWORD PTR [rax+0x20],rdx
		n->id = id;
 29f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 2a3:	48 8b 55 c0          	mov    rdx,QWORD PTR [rbp-0x40]
 2a7:	48 89 50 30          	mov    QWORD PTR [rax+0x30],rdx
		n->pt = p - ad->ptr->port;
 2ab:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 2af:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 2b3:	48 05 00 01 00 00    	add    rax,0x100
 2b9:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
 2bd:	48 29 c2             	sub    rdx,rax
 2c0:	48 89 d0             	mov    rax,rdx
 2c3:	48 c1 f8 07          	sar    rax,0x7
 2c7:	89 c2                	mov    edx,eax
 2c9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 2cd:	66 89 50 40          	mov    WORD PTR [rax+0x40],dx
		n->pmprt = pmprt;
 2d1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 2d5:	0f b7 55 cc          	movzx  edx,WORD PTR [rbp-0x34]
 2d9:	66 89 50 42          	mov    WORD PTR [rax+0x42],dx
		n->index = __sync_fetch_and_add(&ata_device.cur_idx, 1);
 2dd:	ba 01 00 00 00       	mov    edx,0x1
 2e2:	f0 0f c1 15 00 00 00 00 	lock xadd DWORD PTR [rip+0x0],edx        # 2ea <register_ata_device+0xa4>
 2ea:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 2ee:	89 10                	mov    DWORD PTR [rax],edx
		if (!id->lba_supp) {
 2f0:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
 2f4:	0f b6 40 63          	movzx  eax,BYTE PTR [rax+0x63]
 2f8:	83 e0 02             	and    eax,0x2
 2fb:	84 c0                	test   al,al
 2fd:	75 30                	jne    32f <register_ata_device+0xe9>
				die("LBA needed\n");
 2ff:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
 306:	bf 0c 00 00 00       	mov    edi,0xc
 30b:	b8 00 00 00 00       	mov    eax,0x0
 310:	e8 00 00 00 00       	call   315 <register_ata_device+0xcf>
 315:	b8 00 00 00 00       	mov    eax,0x0
 31a:	e8 00 00 00 00       	call   31f <register_ata_device+0xd9>
 31f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 326:	e8 00 00 00 00       	call   32b <register_ata_device+0xe5>
 32b:	fa                   	cli
 32c:	f4                   	hlt
 32d:	eb fd                	jmp    32c <register_ata_device+0xe6>
		} else if (id->has_lba48 || id->has_lba48_alt)
 32f:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
 333:	0f b6 80 a7 00 00 00 	movzx  eax,BYTE PTR [rax+0xa7]
 33a:	83 e0 04             	and    eax,0x4
 33d:	84 c0                	test   al,al
 33f:	75 12                	jne    353 <register_ata_device+0x10d>
 341:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
 345:	0f b6 80 ad 00 00 00 	movzx  eax,BYTE PTR [rax+0xad]
 34c:	83 e0 04             	and    eax,0x4
 34f:	84 c0                	test   al,al
 351:	74 15                	je     368 <register_ata_device+0x122>
				n->gm.max_lba = id->num_logical_sectors;
 353:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
 357:	48 8b 90 c8 00 00 00 	mov    rdx,QWORD PTR [rax+0xc8]
 35e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 362:	48 89 50 58          	mov    QWORD PTR [rax+0x58],rdx
 366:	eb 11                	jmp    379 <register_ata_device+0x133>
				n->gm.max_lba = id->max_lba28;
 368:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
 36c:	8b 40 78             	mov    eax,DWORD PTR [rax+0x78]
 36f:	89 c2                	mov    edx,eax
 371:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 375:	48 89 50 58          	mov    QWORD PTR [rax+0x58],rdx
		if (id->has_multiple_logical_per_physical_sectors) {
 379:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
 37d:	0f b6 80 d5 00 00 00 	movzx  eax,BYTE PTR [rax+0xd5]
 384:	83 e0 20             	and    eax,0x20
 387:	84 c0                	test   al,al
 389:	74 28                	je     3b3 <register_ata_device+0x16d>
				n->gm.lpp = 1 << id->num_pwr2_logical_per_phys;
 38b:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
 38f:	0f b6 80 d4 00 00 00 	movzx  eax,BYTE PTR [rax+0xd4]
 396:	83 e0 0f             	and    eax,0xf
 399:	0f b6 c0             	movzx  eax,al
 39c:	ba 01 00 00 00       	mov    edx,0x1
 3a1:	89 c1                	mov    ecx,eax
 3a3:	d3 e2                	shl    edx,cl
 3a5:	89 d0                	mov    eax,edx
 3a7:	89 c2                	mov    edx,eax
 3a9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 3ad:	66 89 50 48          	mov    WORD PTR [rax+0x48],dx
 3b1:	eb 0a                	jmp    3bd <register_ata_device+0x177>
				n->gm.lpp = 1;
 3b3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 3b7:	66 c7 40 48 01 00    	mov    WORD PTR [rax+0x48],0x1
		if (id->logical_sector_longer_than_512bt) {
 3bd:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
 3c1:	0f b6 80 d5 00 00 00 	movzx  eax,BYTE PTR [rax+0xd5]
 3c8:	83 e0 10             	and    eax,0x10
 3cb:	84 c0                	test   al,al
 3cd:	74 16                	je     3e5 <register_ata_device+0x19f>
				n->gm.lss = 2 * id->logical_sector_size;
 3cf:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
 3d3:	8b 80 ea 00 00 00    	mov    eax,DWORD PTR [rax+0xea]
 3d9:	8d 14 00             	lea    edx,[rax+rax*1]
 3dc:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 3e0:	89 50 4c             	mov    DWORD PTR [rax+0x4c],edx
 3e3:	eb 0b                	jmp    3f0 <register_ata_device+0x1aa>
				n->gm.lss = 512;
 3e5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 3e9:	c7 40 4c 00 02 00 00 	mov    DWORD PTR [rax+0x4c],0x200
		n->gm.lof = id->logical_sector_offset;
 3f0:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
 3f4:	0f b6 90 a2 01 00 00 	movzx  edx,BYTE PTR [rax+0x1a2]
 3fb:	0f b6 80 a3 01 00 00 	movzx  eax,BYTE PTR [rax+0x1a3]
 402:	83 e0 3f             	and    eax,0x3f
 405:	48 c1 e0 08          	shl    rax,0x8
 409:	48 09 d0             	or     rax,rdx
 40c:	89 c2                	mov    edx,eax
 40e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 412:	66 89 50 4a          	mov    WORD PTR [rax+0x4a],dx
		n->cache = create_disk_cache(&n->gm);
 416:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 41a:	48 83 c0 48          	add    rax,0x48
 41e:	48 89 c7             	mov    rdi,rax
 421:	b8 00 00 00 00       	mov    eax,0x0
 426:	e8 00 00 00 00       	call   42b <register_ata_device+0x1e5>
 42b:	48 98                	cdqe
 42d:	48 89 c2             	mov    rdx,rax
 430:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 434:	48 89 50 38          	mov    QWORD PTR [rax+0x38],rdx
		list_add_tail(&n->lst, &ata_device.nodes);
 438:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 43c:	48 83 c0 08          	add    rax,0x8
 440:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
 447:	48 89 c7             	mov    rdi,rax
 44a:	e8 4e fc ff ff       	call   9d <list_add_tail>
		struct inode *in_dev = get_special_inode(INO_DEV), *in;
 44f:	bf 01 00 00 00       	mov    edi,0x1
 454:	e8 00 00 00 00       	call   459 <register_ata_device+0x213>
 459:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		in = ino_allocate(S_IFBLK); /* times have been set */
 45d:	bf 00 60 00 00       	mov    edi,0x6000
 462:	e8 00 00 00 00       	call   467 <register_ata_device+0x221>
 467:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		if (!in_dev || !in) {
 46b:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
 470:	74 07                	je     479 <register_ata_device+0x233>
 472:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
 477:	75 30                	jne    4a9 <register_ata_device+0x263>
				die("/dev is not present or inode allocation failed\n");
 479:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
 480:	bf 0c 00 00 00       	mov    edi,0xc
 485:	b8 00 00 00 00       	mov    eax,0x0
 48a:	e8 00 00 00 00       	call   48f <register_ata_device+0x249>
 48f:	b8 00 00 00 00       	mov    eax,0x0
 494:	e8 00 00 00 00       	call   499 <register_ata_device+0x253>
 499:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 4a0:	e8 00 00 00 00       	call   4a5 <register_ata_device+0x25f>
 4a5:	fa                   	cli
 4a6:	f4                   	hlt
 4a7:	eb fd                	jmp    4a6 <register_ata_device+0x260>
		in->in_pddat = n;
 4a9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 4ad:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
 4b1:	48 89 90 80 00 00 00 	mov    QWORD PTR [rax+0x80],rdx
		in->in_stat.st_dev = ata_device.id;
 4b8:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 4bf <register_ata_device+0x279>
 4bf:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 4c3:	48 89 10             	mov    QWORD PTR [rax],rdx
		in->in_stat.st_blksize = n->gm.pss; /* preferred blocksize */
 4c6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 4ca:	8b 40 50             	mov    eax,DWORD PTR [rax+0x50]
 4cd:	89 c2                	mov    edx,eax
 4cf:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 4d3:	48 89 50 38          	mov    QWORD PTR [rax+0x38],rdx
		in->in_stat.st_blocks = n->gm.max_lba * n->gm.lss / 512; /* LBA48 no overflow */
 4d7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 4db:	48 8b 40 58          	mov    rax,QWORD PTR [rax+0x58]
 4df:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
 4e3:	8b 52 4c             	mov    edx,DWORD PTR [rdx+0x4c]
 4e6:	89 d2                	mov    edx,edx
 4e8:	48 0f af c2          	imul   rax,rdx
 4ec:	48 c1 e8 09          	shr    rax,0x9
 4f0:	48 89 c2             	mov    rdx,rax
 4f3:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 4f7:	48 89 50 40          	mov    QWORD PTR [rax+0x40],rdx
		in->in_stat.st_size = n->gm.max_lba * n->gm.lss;
 4fb:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 4ff:	48 8b 40 58          	mov    rax,QWORD PTR [rax+0x58]
 503:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
 507:	8b 52 4c             	mov    edx,DWORD PTR [rdx+0x4c]
 50a:	89 d2                	mov    edx,edx
 50c:	48 0f af c2          	imul   rax,rdx
 510:	48 89 c2             	mov    rdx,rax
 513:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 517:	48 89 50 30          	mov    QWORD PTR [rax+0x30],rdx
		dd_d = get_device(in_dev->in_stat.st_dev);
 51b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 51f:	48 8b 00             	mov    rax,QWORD PTR [rax]
 522:	48 89 c7             	mov    rdi,rax
 525:	e8 00 00 00 00       	call   52a <register_ata_device+0x2e4>
 52a:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
		if (sd_format_disk_name("sd", n->index, n->name, sizeof(n->name)))
 52e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 532:	48 83 c0 68          	add    rax,0x68
 536:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
 53a:	8b 12                	mov    edx,DWORD PTR [rdx]
 53c:	89 d6                	mov    esi,edx
 53e:	b9 14 00 00 00       	mov    ecx,0x14
 543:	48 89 c2             	mov    rdx,rax
 546:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 54d:	e8 00 00 00 00       	call   552 <register_ata_device+0x30c>
 552:	85 c0                	test   eax,eax
 554:	74 16                	je     56c <register_ata_device+0x326>
				cprintf(KFMT_WARN, "too many sdX devices\n");
 556:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
 55d:	bf 0e 00 00 00       	mov    edi,0xe
 562:	b8 00 00 00 00       	mov    eax,0x0
 567:	e8 00 00 00 00       	call   56c <register_ata_device+0x326>
		if (dd_d->fn_set_subnode(in_dev, in, n->name) == 0)
 56c:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 570:	4c 8b 40 50          	mov    r8,QWORD PTR [rax+0x50]
 574:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 578:	48 8d 50 68          	lea    rdx,[rax+0x68]
 57c:	48 8b 4d e8          	mov    rcx,QWORD PTR [rbp-0x18]
 580:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 584:	48 89 ce             	mov    rsi,rcx
 587:	48 89 c7             	mov    rdi,rax
 58a:	41 ff d0             	call   r8
 58d:	85 c0                	test   eax,eax
 58f:	75 23                	jne    5b4 <register_ata_device+0x36e>
				cprintf(KFMT_OK, "registered ATA device at dev/%s\n", n->name);
 591:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 595:	48 83 c0 68          	add    rax,0x68
 599:	48 89 c2             	mov    rdx,rax
 59c:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
 5a3:	bf 0a 00 00 00       	mov    edi,0xa
 5a8:	b8 00 00 00 00       	mov    eax,0x0
 5ad:	e8 00 00 00 00       	call   5b2 <register_ata_device+0x36c>
 5b2:	eb 21                	jmp    5d5 <register_ata_device+0x38f>
				cprintf(KFMT_WARN, "unable to register ATA device at dev/%s\n", n->name);
 5b4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 5b8:	48 83 c0 68          	add    rax,0x68
 5bc:	48 89 c2             	mov    rdx,rax
 5bf:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
 5c6:	bf 0e 00 00 00       	mov    edi,0xe
 5cb:	b8 00 00 00 00       	mov    eax,0x0
 5d0:	e8 00 00 00 00       	call   5d5 <register_ata_device+0x38f>
}
 5d5:	c9                   	leave
 5d6:	c3                   	ret

00000000000005d7 <ata_register_device>:
{
 5d7:	55                   	push   rbp
 5d8:	48 89 e5             	mov    rbp,rsp
 5db:	48 83 ec 28          	sub    rsp,0x28
 5df:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		ata_device.id = d;
 5e3:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
 5e7:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 5ee <ata_register_device+0x17>
		ata_device.cur_idx = 0;
 5ee:	c7 05 00 00 00 00 00 00 00 00 	mov    DWORD PTR [rip+0x0],0x0        # 5f8 <ata_register_device+0x21>
		ata_device.nodes = LIST_HEAD_INIT(ata_device.nodes);
 5f8:	48 c7 05 00 00 00 00 00 00 00 00 	mov    QWORD PTR [rip+0x0],0x0        # 603 <ata_register_device+0x2c>
 603:	48 c7 05 00 00 00 00 00 00 00 00 	mov    QWORD PTR [rip+0x0],0x0        # 60e <ata_register_device+0x37>
 60e:	66 c7 05 00 00 00 00 00 00 	mov    WORD PTR [rip+0x0],0x0        # 617 <ata_register_device+0x40>
		return 0;
 617:	b8 00 00 00 00       	mov    eax,0x0
}
 61c:	c9                   	leave
 61d:	c3                   	ret

000000000000061e <ata_unregister_device>:
{
 61e:	55                   	push   rbp
 61f:	48 89 e5             	mov    rbp,rsp
		return -1;
 622:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
 627:	5d                   	pop    rbp
 628:	c3                   	ret

0000000000000629 <ata_open>:
{
 629:	55                   	push   rbp
 62a:	48 89 e5             	mov    rbp,rsp
 62d:	48 83 ec 20          	sub    rsp,0x20
 631:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
 635:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
		if (!in || in->in_stat.st_dev != ata_device.id) {
 638:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
 63d:	74 13                	je     652 <ata_open+0x29>
 63f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 643:	48 8b 10             	mov    rdx,QWORD PTR [rax]
 646:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 64d <ata_open+0x24>
 64d:	48 39 c2             	cmp    rdx,rax
 650:	74 11                	je     663 <ata_open+0x3a>
				errno = EINVAL;
 652:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # 65c <ata_open+0x33>
				return -1;
 65c:	b8 ff ff ff ff       	mov    eax,0xffffffff
 661:	eb 54                	jmp    6b7 <ata_open+0x8e>
		fd = fil_fd_allocate(in, &rv);
 663:	48 8d 55 f4          	lea    rdx,[rbp-0xc]
 667:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 66b:	48 89 d6             	mov    rsi,rdx
 66e:	48 89 c7             	mov    rdi,rax
 671:	e8 00 00 00 00       	call   676 <ata_open+0x4d>
 676:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (!fd) {
 67a:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
 67f:	75 11                	jne    692 <ata_open+0x69>
				errno = ENOMEM;
 681:	c7 05 00 00 00 00 0c 00 00 00 	mov    DWORD PTR [rip+0x0],0xc        # 68b <ata_open+0x62>
				return -1;
 68b:	b8 ff ff ff ff       	mov    eax,0xffffffff
 690:	eb 25                	jmp    6b7 <ata_open+0x8e>
		fd->flags = flags;
 692:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 696:	8b 55 e4             	mov    edx,DWORD PTR [rbp-0x1c]
 699:	89 50 10             	mov    DWORD PTR [rax+0x10],edx
		fd->seek_offset = 0;
 69c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 6a0:	48 c7 40 08 00 00 00 00 	mov    QWORD PTR [rax+0x8],0x0
		__sync_fetch_and_add((int*)in->in_ddat, 1);
 6a8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 6ac:	48 83 c0 78          	add    rax,0x78
 6b0:	f0 83 00 01          	lock add DWORD PTR [rax],0x1
		return rv;
 6b4:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
}
 6b7:	c9                   	leave
 6b8:	c3                   	ret

00000000000006b9 <ata_read>:
{
 6b9:	55                   	push   rbp
 6ba:	48 89 e5             	mov    rbp,rsp
 6bd:	48 81 ec b0 00 00 00 	sub    rsp,0xb0
 6c4:	48 89 7d 88          	mov    QWORD PTR [rbp-0x78],rdi
 6c8:	89 75 84             	mov    DWORD PTR [rbp-0x7c],esi
 6cb:	48 89 95 78 ff ff ff 	mov    QWORD PTR [rbp-0x88],rdx
 6d2:	48 89 8d 70 ff ff ff 	mov    QWORD PTR [rbp-0x90],rcx
		struct fil_fd* f; ssize_t rv = 0;
 6d9:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		if (!in || !buf || in->in_stat.st_dev != ata_device.id) {
 6e0:	48 83 7d 88 00       	cmp    QWORD PTR [rbp-0x78],0x0
 6e5:	74 1d                	je     704 <ata_read+0x4b>
 6e7:	48 83 bd 78 ff ff ff 00 	cmp    QWORD PTR [rbp-0x88],0x0
 6ef:	74 13                	je     704 <ata_read+0x4b>
 6f1:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
 6f5:	48 8b 10             	mov    rdx,QWORD PTR [rax]
 6f8:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 6ff <ata_read+0x46>
 6ff:	48 39 c2             	cmp    rdx,rax
 702:	74 14                	je     718 <ata_read+0x5f>
				errno = EINVAL;
 704:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # 70e <ata_read+0x55>
				return -1;
 70e:	b8 ff ff ff ff       	mov    eax,0xffffffff
 713:	e9 65 01 00 00       	jmp    87d <ata_read+0x1c4>
		f = fil_fd_get(fd);
 718:	8b 45 84             	mov    eax,DWORD PTR [rbp-0x7c]
 71b:	89 c7                	mov    edi,eax
 71d:	e8 00 00 00 00       	call   722 <ata_read+0x69>
 722:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		n = in->in_pddat;
 726:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
 72a:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
 731:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		if (!f || (f->flags & O_WRONLY)
 735:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
 73a:	74 0e                	je     74a <ata_read+0x91>
 73c:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 740:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
 743:	83 e0 01             	and    eax,0x1
 746:	85 c0                	test   eax,eax
 748:	74 14                	je     75e <ata_read+0xa5>
				errno = EBADF;
 74a:	c7 05 00 00 00 00 09 00 00 00 	mov    DWORD PTR [rip+0x0],0x9        # 754 <ata_read+0x9b>
				return -1;
 754:	b8 ff ff ff ff       	mov    eax,0xffffffff
 759:	e9 1f 01 00 00       	jmp    87d <ata_read+0x1c4>
		lba = f->seek_offset / n->gm.lss;
 75e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 762:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 766:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
 76a:	8b 52 4c             	mov    edx,DWORD PTR [rdx+0x4c]
 76d:	89 d6                	mov    esi,edx
 76f:	48 99                	cqo
 771:	48 f7 fe             	idiv   rsi
 774:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
		if (f->seek_offset % n->gm.lss) {
 778:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
 77c:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
 780:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
 784:	8b 52 4c             	mov    edx,DWORD PTR [rdx+0x4c]
 787:	89 d1                	mov    ecx,edx
 789:	48 99                	cqo
 78b:	48 f7 f9             	idiv   rcx
 78e:	48 89 d0             	mov    rax,rdx
 791:	48 85 c0             	test   rax,rax
 794:	74 30                	je     7c6 <ata_read+0x10d>
				die("not sector aligned\n");
 796:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
 79d:	bf 0c 00 00 00       	mov    edi,0xc
 7a2:	b8 00 00 00 00       	mov    eax,0x0
 7a7:	e8 00 00 00 00       	call   7ac <ata_read+0xf3>
 7ac:	b8 00 00 00 00       	mov    eax,0x0
 7b1:	e8 00 00 00 00       	call   7b6 <ata_read+0xfd>
 7b6:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 7bd:	e8 00 00 00 00       	call   7c2 <ata_read+0x109>
 7c2:	fa                   	cli
 7c3:	f4                   	hlt
 7c4:	eb fd                	jmp    7c3 <ata_read+0x10a>
		if (noct > n->gm.lss)
 7c6:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 7ca:	8b 40 4c             	mov    eax,DWORD PTR [rax+0x4c]
 7cd:	89 c0                	mov    eax,eax
 7cf:	48 3b 85 70 ff ff ff 	cmp    rax,QWORD PTR [rbp-0x90]
 7d6:	73 10                	jae    7e8 <ata_read+0x12f>
				noct = n->gm.lss;
 7d8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 7dc:	8b 40 4c             	mov    eax,DWORD PTR [rax+0x4c]
 7df:	89 c0                	mov    eax,eax
 7e1:	48 89 85 70 ff ff ff 	mov    QWORD PTR [rbp-0x90],rax
		struct wait_queue_head wh = WAIT_QUEUE_HEAD(wh);
 7e8:	48 8d 45 c8          	lea    rax,[rbp-0x38]
 7ec:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
 7f0:	48 8d 45 c8          	lea    rax,[rbp-0x38]
 7f4:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
 7f8:	66 c7 45 d8 00 00    	mov    WORD PTR [rbp-0x28],0x0
 7fe:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [rbp-0x24],0x0
		ahci_issue_command(n->ad, n->pt, n->pmprt, disk_cmd_read, lba, noct, buf, &wh, &st);
 805:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 809:	0f b7 40 42          	movzx  eax,WORD PTR [rax+0x42]
 80d:	0f b7 d0             	movzx  edx,ax
 810:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 814:	0f b7 40 40          	movzx  eax,WORD PTR [rax+0x40]
 818:	0f b7 f0             	movzx  esi,ax
 81b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 81f:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
 823:	4c 8b 85 70 ff ff ff 	mov    r8,QWORD PTR [rbp-0x90]
 82a:	48 8b 7d e0          	mov    rdi,QWORD PTR [rbp-0x20]
 82e:	48 8d 4d 98          	lea    rcx,[rbp-0x68]
 832:	48 89 4c 24 10       	mov    QWORD PTR [rsp+0x10],rcx
 837:	48 8d 4d c8          	lea    rcx,[rbp-0x38]
 83b:	48 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],rcx
 840:	48 8b 8d 78 ff ff ff 	mov    rcx,QWORD PTR [rbp-0x88]
 847:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
 84b:	4d 89 c1             	mov    r9,r8
 84e:	49 89 f8             	mov    r8,rdi
 851:	b9 01 00 00 00       	mov    ecx,0x1
 856:	48 89 c7             	mov    rdi,rax
 859:	e8 00 00 00 00       	call   85e <ata_read+0x1a5>
		wait_on_event(&wh);
 85e:	48 8d 45 c8          	lea    rax,[rbp-0x38]
 862:	48 89 c7             	mov    rdi,rax
 865:	e8 00 00 00 00       	call   86a <ata_read+0x1b1>
		if (st.state == cmd_state_completed) {
 86a:	8b 45 98             	mov    eax,DWORD PTR [rbp-0x68]
 86d:	83 f8 03             	cmp    eax,0x3
 870:	75 06                	jne    878 <ata_read+0x1bf>
				return (ssize_t)st.bts_cur;
 872:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
 876:	eb 05                	jmp    87d <ata_read+0x1c4>
				return -1;
 878:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
 87d:	c9                   	leave
 87e:	c3                   	ret

000000000000087f <ata_write>:
{
 87f:	55                   	push   rbp
 880:	48 89 e5             	mov    rbp,rsp
 883:	48 83 ec 20          	sub    rsp,0x20
 887:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
 88b:	89 75 f4             	mov    DWORD PTR [rbp-0xc],esi
 88e:	48 89 55 e8          	mov    QWORD PTR [rbp-0x18],rdx
 892:	48 89 4d e0          	mov    QWORD PTR [rbp-0x20],rcx
		return -1;
 896:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
 89b:	c9                   	leave
 89c:	c3                   	ret

000000000000089d <ata_close>:
{
 89d:	55                   	push   rbp
 89e:	48 89 e5             	mov    rbp,rsp
 8a1:	48 83 ec 10          	sub    rsp,0x10
 8a5:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
 8a9:	89 75 f4             	mov    DWORD PTR [rbp-0xc],esi
		return -1;
 8ac:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
 8b1:	c9                   	leave
 8b2:	c3                   	ret

00000000000008b3 <ata_lseek>:
{
 8b3:	55                   	push   rbp
 8b4:	48 89 e5             	mov    rbp,rsp
 8b7:	48 83 ec 18          	sub    rsp,0x18
 8bb:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
 8bf:	89 75 f4             	mov    DWORD PTR [rbp-0xc],esi
 8c2:	48 89 55 e8          	mov    QWORD PTR [rbp-0x18],rdx
 8c6:	89 4d f0             	mov    DWORD PTR [rbp-0x10],ecx
		return -1;
 8c9:	48 c7 c0 ff ff ff ff 	mov    rax,0xffffffffffffffff
}
 8d0:	c9                   	leave
 8d1:	c3                   	ret

00000000000008d2 <ata_unlink>:
{
 8d2:	55                   	push   rbp
 8d3:	48 89 e5             	mov    rbp,rsp
 8d6:	48 83 ec 20          	sub    rsp,0x20
 8da:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
 8de:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
		if (in0 || !in1)
 8e2:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
 8e7:	75 07                	jne    8f0 <ata_unlink+0x1e>
 8e9:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
 8ee:	75 07                	jne    8f7 <ata_unlink+0x25>
				return -EINVAL;
 8f0:	b8 ea ff ff ff       	mov    eax,0xffffffea
 8f5:	eb 53                	jmp    94a <ata_unlink+0x78>
		if (__sync_sub_and_fetch(&in1->in_stat.st_nlink, 1) == 0) {
 8f7:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 8fb:	48 8d 50 18          	lea    rdx,[rax+0x18]
 8ff:	b8 01 00 00 00       	mov    eax,0x1
 904:	48 f7 d8             	neg    rax
 907:	48 89 c1             	mov    rcx,rax
 90a:	48 89 c8             	mov    rax,rcx
 90d:	f0 48 0f c1 02       	lock xadd QWORD PTR [rdx],rax
 912:	48 01 c8             	add    rax,rcx
 915:	48 85 c0             	test   rax,rax
 918:	75 30                	jne    94a <ata_unlink+0x78>
				struct ata_node* n = in1->in_pddat;
 91a:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
 91e:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
 925:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				cprintf(KFMT_INFO, "ATA device at dev/%s reached link count zero.\n", n->name);
 929:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
 92d:	48 83 c0 68          	add    rax,0x68
 931:	48 89 c2             	mov    rdx,rax
 934:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
 93b:	bf 0b 00 00 00       	mov    edi,0xb
 940:	b8 00 00 00 00       	mov    eax,0x0
 945:	e8 00 00 00 00       	call   94a <ata_unlink+0x78>
}
 94a:	c9                   	leave
 94b:	c3                   	ret
