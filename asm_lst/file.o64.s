
file.o64:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <memcpy>:
				h_destroy(ptr);
				kfree(memdev_data);
				return -1;
		}
		bzero(memdev_data->nodes, 4096 * sizeof(struct memdev_node*));
		return 0;
       0:	55                   	push   rbp
       1:	48 89 e5             	mov    rbp,rsp
       4:	48 83 ec 28          	sub    rsp,0x28
       8:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
       c:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
      10:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
}
      14:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
      18:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax

      1c:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
      20:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
int memdev_unregister()
      24:	eb 1d                	jmp    43 <memcpy+0x43>
{
      26:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
      2a:	48 8d 42 01          	lea    rax,[rdx+0x1]
      2e:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
      32:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      36:	48 8d 48 01          	lea    rcx,[rax+0x1]
      3a:	48 89 4d f8          	mov    QWORD PTR [rbp-0x8],rcx
      3e:	0f b6 12             	movzx  edx,BYTE PTR [rdx]
      41:	88 10                	mov    BYTE PTR [rax],dl
int memdev_unregister()
      43:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
      47:	48 8d 50 ff          	lea    rdx,[rax-0x1]
      4b:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
      4f:	48 85 c0             	test   rax,rax
      52:	75 d2                	jne    26 <memcpy+0x26>
		errno = ENOSYS;
      54:	90                   	nop
      55:	90                   	nop
      56:	c9                   	leave
      57:	c3                   	ret

0000000000000058 <register_device>:
{
      58:	55                   	push   rbp
      59:	48 89 e5             	mov    rbp,rsp
      5c:	48 83 ec 30          	sub    rsp,0x30
      60:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		dev_t rv = 0; size_t i = 0;
      64:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
      6c:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		struct dd_drs* dr = &dr0;
      74:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
				if (__sync_bool_compare_and_swap(&dr->descs[i].type, 0, dd->type))
      7c:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
      80:	0f b6 00             	movzx  eax,BYTE PTR [rax]
      83:	0f b6 c8             	movzx  ecx,al
      86:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
      8a:	48 89 d0             	mov    rax,rdx
      8d:	48 c1 e0 03          	shl    rax,0x3
      91:	48 29 d0             	sub    rax,rdx
      94:	48 c1 e0 04          	shl    rax,0x4
      98:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
      9c:	48 01 c2             	add    rdx,rax
      9f:	b8 00 00 00 00       	mov    eax,0x0
      a4:	f0 0f b0 0a          	lock cmpxchg BYTE PTR [rdx],cl
      a8:	0f 94 c0             	sete   al
      ab:	84 c0                	test   al,al
      ad:	0f 85 dc 00 00 00    	jne    18f <register_device+0x137>
				i++; rv++;
      b3:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
      b8:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
				if (i == 8) {
      bd:	48 83 7d f0 08       	cmp    QWORD PTR [rbp-0x10],0x8
      c2:	75 b8                	jne    7c <register_device+0x24>
						if (!dr->next) {
      c4:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
      c8:	48 8b 80 80 03 00 00 	mov    rax,QWORD PTR [rax+0x380]
      cf:	48 85 c0             	test   rax,rax
      d2:	0f 85 9b 00 00 00    	jne    173 <register_device+0x11b>
								struct dd_drs* dr2 = kmalloc(sizeof(struct dd_drs));
      d8:	bf 88 03 00 00       	mov    edi,0x388
      dd:	e8 00 00 00 00       	call   e2 <register_device+0x8a>
      e2:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
								if (!dr2) {
      e6:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
      eb:	75 16                	jne    103 <register_device+0xab>
										errno = ENOMEM;
      ed:	c7 05 00 00 00 00 0c 00 00 00 	mov    DWORD PTR [rip+0x0],0xc        # f7 <register_device+0x9f>
										return INVALID_DEVICE;
      f7:	48 c7 c0 ff ff ff ff 	mov    rax,0xffffffffffffffff
      fe:	e9 57 01 00 00       	jmp    25a <register_device+0x202>
								dr2->next = NULL;
     103:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     107:	48 c7 80 80 03 00 00 00 00 00 00 	mov    QWORD PTR [rax+0x380],0x0
								for (i = 0; i < 8; i++)
     112:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
     11a:	eb 21                	jmp    13d <register_device+0xe5>
										dr2->descs[i].type = 0;
     11c:	48 8b 4d e0          	mov    rcx,QWORD PTR [rbp-0x20]
     120:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     124:	48 89 d0             	mov    rax,rdx
     127:	48 c1 e0 03          	shl    rax,0x3
     12b:	48 29 d0             	sub    rax,rdx
     12e:	48 c1 e0 04          	shl    rax,0x4
     132:	48 01 c8             	add    rax,rcx
     135:	c6 00 00             	mov    BYTE PTR [rax],0x0
								for (i = 0; i < 8; i++)
     138:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
     13d:	48 83 7d f0 07       	cmp    QWORD PTR [rbp-0x10],0x7
     142:	76 d8                	jbe    11c <register_device+0xc4>
								if (!__sync_bool_compare_and_swap(&dr->next, NULL, dr2))
     144:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     148:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     14c:	48 8d 88 80 03 00 00 	lea    rcx,[rax+0x380]
     153:	b8 00 00 00 00       	mov    eax,0x0
     158:	f0 48 0f b1 11       	lock cmpxchg QWORD PTR [rcx],rdx
     15d:	0f 94 c0             	sete   al
     160:	83 f0 01             	xor    eax,0x1
     163:	84 c0                	test   al,al
     165:	74 0c                	je     173 <register_device+0x11b>
										kfree(dr2); /* someone was faster */
     167:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     16b:	48 89 c7             	mov    rdi,rax
     16e:	e8 00 00 00 00       	call   173 <register_device+0x11b>
						i = 0;
     173:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
						dr = dr->next;
     17b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     17f:	48 8b 80 80 03 00 00 	mov    rax,QWORD PTR [rax+0x380]
     186:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				if (__sync_bool_compare_and_swap(&dr->descs[i].type, 0, dd->type))
     18a:	e9 ed fe ff ff       	jmp    7c <register_device+0x24>
						break;
     18f:	90                   	nop
		dr->descs[i] = *dd;
     190:	48 8b 4d e8          	mov    rcx,QWORD PTR [rbp-0x18]
     194:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     198:	48 89 d0             	mov    rax,rdx
     19b:	48 c1 e0 03          	shl    rax,0x3
     19f:	48 29 d0             	sub    rax,rdx
     1a2:	48 c1 e0 04          	shl    rax,0x4
     1a6:	48 8d 14 01          	lea    rdx,[rcx+rax*1]
     1aa:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     1ae:	48 8b 08             	mov    rcx,QWORD PTR [rax]
     1b1:	48 89 0a             	mov    QWORD PTR [rdx],rcx
     1b4:	48 8b 48 08          	mov    rcx,QWORD PTR [rax+0x8]
     1b8:	48 89 4a 08          	mov    QWORD PTR [rdx+0x8],rcx
     1bc:	48 8b 48 10          	mov    rcx,QWORD PTR [rax+0x10]
     1c0:	48 89 4a 10          	mov    QWORD PTR [rdx+0x10],rcx
     1c4:	48 8b 48 18          	mov    rcx,QWORD PTR [rax+0x18]
     1c8:	48 89 4a 18          	mov    QWORD PTR [rdx+0x18],rcx
     1cc:	48 8b 48 20          	mov    rcx,QWORD PTR [rax+0x20]
     1d0:	48 89 4a 20          	mov    QWORD PTR [rdx+0x20],rcx
     1d4:	48 8b 48 28          	mov    rcx,QWORD PTR [rax+0x28]
     1d8:	48 89 4a 28          	mov    QWORD PTR [rdx+0x28],rcx
     1dc:	48 8b 48 30          	mov    rcx,QWORD PTR [rax+0x30]
     1e0:	48 89 4a 30          	mov    QWORD PTR [rdx+0x30],rcx
     1e4:	48 8b 48 38          	mov    rcx,QWORD PTR [rax+0x38]
     1e8:	48 89 4a 38          	mov    QWORD PTR [rdx+0x38],rcx
     1ec:	48 8b 48 40          	mov    rcx,QWORD PTR [rax+0x40]
     1f0:	48 89 4a 40          	mov    QWORD PTR [rdx+0x40],rcx
     1f4:	48 8b 48 48          	mov    rcx,QWORD PTR [rax+0x48]
     1f8:	48 89 4a 48          	mov    QWORD PTR [rdx+0x48],rcx
     1fc:	48 8b 48 50          	mov    rcx,QWORD PTR [rax+0x50]
     200:	48 89 4a 50          	mov    QWORD PTR [rdx+0x50],rcx
     204:	48 8b 48 58          	mov    rcx,QWORD PTR [rax+0x58]
     208:	48 89 4a 58          	mov    QWORD PTR [rdx+0x58],rcx
     20c:	48 8b 48 60          	mov    rcx,QWORD PTR [rax+0x60]
     210:	48 89 4a 60          	mov    QWORD PTR [rdx+0x60],rcx
     214:	48 8b 40 68          	mov    rax,QWORD PTR [rax+0x68]
     218:	48 89 42 68          	mov    QWORD PTR [rdx+0x68],rax
		if(dd->fn_reg_dev(rv)) {
     21c:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     220:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
     224:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     228:	48 89 c7             	mov    rdi,rax
     22b:	ff d2                	call   rdx
     22d:	85 c0                	test   eax,eax
     22f:	74 25                	je     256 <register_device+0x1fe>
				dr->descs[i].type = 0;
     231:	48 8b 4d e8          	mov    rcx,QWORD PTR [rbp-0x18]
     235:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     239:	48 89 d0             	mov    rax,rdx
     23c:	48 c1 e0 03          	shl    rax,0x3
     240:	48 29 d0             	sub    rax,rdx
     243:	48 c1 e0 04          	shl    rax,0x4
     247:	48 01 c8             	add    rax,rcx
     24a:	c6 00 00             	mov    BYTE PTR [rax],0x0
				return INVALID_DEVICE;
     24d:	48 c7 c0 ff ff ff ff 	mov    rax,0xffffffffffffffff
     254:	eb 04                	jmp    25a <register_device+0x202>
		return rv;
     256:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
}
     25a:	c9                   	leave
     25b:	c3                   	ret

000000000000025c <unregister_device>:
{
     25c:	55                   	push   rbp
     25d:	48 89 e5             	mov    rbp,rsp
     260:	48 83 ec 20          	sub    rsp,0x20
     264:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		struct dd_drs* dr = &dr0;
     268:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
				if (dev >= 8) {
     270:	48 83 7d e8 07       	cmp    QWORD PTR [rbp-0x18],0x7
     275:	76 32                	jbe    2a9 <unregister_device+0x4d>
						dr = dr->next;
     277:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     27b:	48 8b 80 80 03 00 00 	mov    rax,QWORD PTR [rax+0x380]
     282:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						dr -= 8;
     286:	48 81 6d f8 40 1c 00 00 	sub    QWORD PTR [rbp-0x8],0x1c40
						if (!dr) {
     28e:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     293:	75 db                	jne    270 <unregister_device+0x14>
								errno = EINVAL;
     295:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # 29f <unregister_device+0x43>
								return -1;
     29f:	b8 ff ff ff ff       	mov    eax,0xffffffff
     2a4:	e9 87 00 00 00       	jmp    330 <unregister_device+0xd4>
						if (!dr->descs[dev].type) {
     2a9:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
     2ad:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     2b1:	48 89 d0             	mov    rax,rdx
     2b4:	48 c1 e0 03          	shl    rax,0x3
     2b8:	48 29 d0             	sub    rax,rdx
     2bb:	48 c1 e0 04          	shl    rax,0x4
     2bf:	48 01 c8             	add    rax,rcx
     2c2:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     2c5:	84 c0                	test   al,al
     2c7:	75 11                	jne    2da <unregister_device+0x7e>
								errno = EINVAL;
     2c9:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # 2d3 <unregister_device+0x77>
								return -1;
     2d3:	b8 ff ff ff ff       	mov    eax,0xffffffff
     2d8:	eb 56                	jmp    330 <unregister_device+0xd4>
						rv = dr->descs[dev].fn_unreg_dev();
     2da:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
     2de:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     2e2:	48 89 d0             	mov    rax,rdx
     2e5:	48 c1 e0 03          	shl    rax,0x3
     2e9:	48 29 d0             	sub    rax,rdx
     2ec:	48 c1 e0 04          	shl    rax,0x4
     2f0:	48 01 c8             	add    rax,rcx
     2f3:	48 83 c0 10          	add    rax,0x10
     2f7:	48 8b 10             	mov    rdx,QWORD PTR [rax]
     2fa:	b8 00 00 00 00       	mov    eax,0x0
     2ff:	ff d2                	call   rdx
     301:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
						if (!rv) {
     304:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
     308:	75 23                	jne    32d <unregister_device+0xd1>
								dr->descs[dev].type = 0;
     30a:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
     30e:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     312:	48 89 d0             	mov    rax,rdx
     315:	48 c1 e0 03          	shl    rax,0x3
     319:	48 29 d0             	sub    rax,rdx
     31c:	48 c1 e0 04          	shl    rax,0x4
     320:	48 01 c8             	add    rax,rcx
     323:	c6 00 00             	mov    BYTE PTR [rax],0x0
								return 0;
     326:	b8 00 00 00 00       	mov    eax,0x0
     32b:	eb 03                	jmp    330 <unregister_device+0xd4>
								return rv;
     32d:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
}
     330:	c9                   	leave
     331:	c3                   	ret

0000000000000332 <get_device>:
{
     332:	55                   	push   rbp
     333:	48 89 e5             	mov    rbp,rsp
     336:	48 83 ec 18          	sub    rsp,0x18
     33a:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		struct dd_drs* dr = &dr0;
     33e:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
				if (dev >= 8) {
     346:	48 83 7d e8 07       	cmp    QWORD PTR [rbp-0x18],0x7
     34b:	76 2f                	jbe    37c <get_device+0x4a>
						dr = dr->next;
     34d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     351:	48 8b 80 80 03 00 00 	mov    rax,QWORD PTR [rax+0x380]
     358:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						dr -= 8;
     35c:	48 81 6d f8 40 1c 00 00 	sub    QWORD PTR [rbp-0x8],0x1c40
						if (!dr) {
     364:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     369:	75 db                	jne    346 <get_device+0x14>
								errno = EINVAL;
     36b:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # 375 <get_device+0x43>
								return NULL;
     375:	b8 00 00 00 00       	mov    eax,0x0
     37a:	eb 40                	jmp    3bc <get_device+0x8a>
						if (!dr->descs[dev].type)
     37c:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
     380:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     384:	48 89 d0             	mov    rax,rdx
     387:	48 c1 e0 03          	shl    rax,0x3
     38b:	48 29 d0             	sub    rax,rdx
     38e:	48 c1 e0 04          	shl    rax,0x4
     392:	48 01 c8             	add    rax,rcx
     395:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     398:	84 c0                	test   al,al
     39a:	75 07                	jne    3a3 <get_device+0x71>
								return NULL;
     39c:	b8 00 00 00 00       	mov    eax,0x0
     3a1:	eb 19                	jmp    3bc <get_device+0x8a>
						return dr->descs + dev;
     3a3:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
     3a7:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     3ab:	48 89 d0             	mov    rax,rdx
     3ae:	48 c1 e0 03          	shl    rax,0x3
     3b2:	48 29 d0             	sub    rax,rdx
     3b5:	48 c1 e0 04          	shl    rax,0x4
     3b9:	48 01 c8             	add    rax,rcx
}
     3bc:	c9                   	leave
     3bd:	c3                   	ret

00000000000003be <fil_fd_get>:
{
     3be:	55                   	push   rbp
     3bf:	48 89 e5             	mov    rbp,rsp
     3c2:	48 83 ec 18          	sub    rsp,0x18
     3c6:	89 7d ec             	mov    DWORD PTR [rbp-0x14],edi
		struct fil_fdc* f = &fdc0;
     3c9:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		while (fd >= 64) {
     3d1:	eb 21                	jmp    3f4 <fil_fd_get+0x36>
				fd -= 64;
     3d3:	83 6d ec 40          	sub    DWORD PTR [rbp-0x14],0x40
				f = f->next;
     3d7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     3db:	48 8b 80 00 0a 00 00 	mov    rax,QWORD PTR [rax+0xa00]
     3e2:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				if (!f)
     3e6:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     3eb:	75 07                	jne    3f4 <fil_fd_get+0x36>
						return NULL;
     3ed:	b8 00 00 00 00       	mov    eax,0x0
     3f2:	eb 21                	jmp    415 <fil_fd_get+0x57>
		while (fd >= 64) {
     3f4:	83 7d ec 3f          	cmp    DWORD PTR [rbp-0x14],0x3f
     3f8:	7f d9                	jg     3d3 <fil_fd_get+0x15>
		return &f->fds[fd];
     3fa:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     3fd:	48 63 d0             	movsxd rdx,eax
     400:	48 89 d0             	mov    rax,rdx
     403:	48 c1 e0 02          	shl    rax,0x2
     407:	48 01 d0             	add    rax,rdx
     40a:	48 c1 e0 03          	shl    rax,0x3
     40e:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     412:	48 01 d0             	add    rax,rdx
}
     415:	c9                   	leave
     416:	c3                   	ret

0000000000000417 <fil_fd_allocate>:
{
     417:	55                   	push   rbp
     418:	48 89 e5             	mov    rbp,rsp
     41b:	48 83 ec 30          	sub    rsp,0x30
     41f:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
     423:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi
		struct fil_fdc* fdc = &fdc0;
     427:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		int rv = 0; size_t i;
     42f:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
				for (i = 0; i < 64; i++) {
     436:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
     43e:	eb 64                	jmp    4a4 <fil_fd_allocate+0x8d>
						if (__sync_bool_compare_and_swap(&fdc->fds[i].in, NULL, in)) {
     440:	48 8b 4d d8          	mov    rcx,QWORD PTR [rbp-0x28]
     444:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     448:	48 89 d0             	mov    rax,rdx
     44b:	48 c1 e0 02          	shl    rax,0x2
     44f:	48 01 d0             	add    rax,rdx
     452:	48 c1 e0 03          	shl    rax,0x3
     456:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     45a:	48 01 c2             	add    rdx,rax
     45d:	b8 00 00 00 00       	mov    eax,0x0
     462:	f0 48 0f b1 0a       	lock cmpxchg QWORD PTR [rdx],rcx
     467:	0f 94 c0             	sete   al
     46a:	84 c0                	test   al,al
     46c:	74 31                	je     49f <fil_fd_allocate+0x88>
								*pfd = rv + i;
     46e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     472:	89 c2                	mov    edx,eax
     474:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
     477:	01 d0                	add    eax,edx
     479:	89 c2                	mov    edx,eax
     47b:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     47f:	89 10                	mov    DWORD PTR [rax],edx
								return &fdc->fds[i];
     481:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     485:	48 89 d0             	mov    rax,rdx
     488:	48 c1 e0 02          	shl    rax,0x2
     48c:	48 01 d0             	add    rax,rdx
     48f:	48 c1 e0 03          	shl    rax,0x3
     493:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     497:	48 01 d0             	add    rax,rdx
     49a:	e9 eb 00 00 00       	jmp    58a <fil_fd_allocate+0x173>
				for (i = 0; i < 64; i++) {
     49f:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
     4a4:	48 83 7d e8 3f       	cmp    QWORD PTR [rbp-0x18],0x3f
     4a9:	76 95                	jbe    440 <fil_fd_allocate+0x29>
				rv += 64;
     4ab:	83 45 f4 40          	add    DWORD PTR [rbp-0xc],0x40
				if (!fdc->next) {
     4af:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     4b3:	48 8b 80 00 0a 00 00 	mov    rax,QWORD PTR [rax+0xa00]
     4ba:	48 85 c0             	test   rax,rax
     4bd:	0f 85 b3 00 00 00    	jne    576 <fil_fd_allocate+0x15f>
						struct fil_fdc* f2 = fdc->next = (struct fil_fdc*)kmalloc(sizeof(struct fil_fdc));
     4c3:	bf 08 0a 00 00       	mov    edi,0xa08
     4c8:	e8 00 00 00 00       	call   4cd <fil_fd_allocate+0xb6>
     4cd:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     4d1:	48 89 82 00 0a 00 00 	mov    QWORD PTR [rdx+0xa00],rax
     4d8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     4dc:	48 8b 80 00 0a 00 00 	mov    rax,QWORD PTR [rax+0xa00]
     4e3:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
						if (!f2) {
     4e7:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
     4ec:	75 14                	jne    502 <fil_fd_allocate+0xeb>
								errno = ENOMEM;
     4ee:	c7 05 00 00 00 00 0c 00 00 00 	mov    DWORD PTR [rip+0x0],0xc        # 4f8 <fil_fd_allocate+0xe1>
								return NULL;
     4f8:	b8 00 00 00 00       	mov    eax,0x0
     4fd:	e9 88 00 00 00       	jmp    58a <fil_fd_allocate+0x173>
						f2->next = NULL;
     502:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     506:	48 c7 80 00 0a 00 00 00 00 00 00 	mov    QWORD PTR [rax+0xa00],0x0
						for (i = 0; i < 64; i++)
     511:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
     519:	eb 25                	jmp    540 <fil_fd_allocate+0x129>
								f2->fds[i].in = NULL;
     51b:	48 8b 4d e0          	mov    rcx,QWORD PTR [rbp-0x20]
     51f:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     523:	48 89 d0             	mov    rax,rdx
     526:	48 c1 e0 02          	shl    rax,0x2
     52a:	48 01 d0             	add    rax,rdx
     52d:	48 c1 e0 03          	shl    rax,0x3
     531:	48 01 c8             	add    rax,rcx
     534:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
						for (i = 0; i < 64; i++)
     53b:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
     540:	48 83 7d e8 3f       	cmp    QWORD PTR [rbp-0x18],0x3f
     545:	76 d4                	jbe    51b <fil_fd_allocate+0x104>
						if (!__sync_bool_compare_and_swap(&fdc->next, NULL, f2))
     547:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     54b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     54f:	48 8d 88 00 0a 00 00 	lea    rcx,[rax+0xa00]
     556:	b8 00 00 00 00       	mov    eax,0x0
     55b:	f0 48 0f b1 11       	lock cmpxchg QWORD PTR [rcx],rdx
     560:	0f 94 c0             	sete   al
     563:	83 f0 01             	xor    eax,0x1
     566:	84 c0                	test   al,al
     568:	74 0c                	je     576 <fil_fd_allocate+0x15f>
								kfree(f2); /* someone was faster */
     56a:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     56e:	48 89 c7             	mov    rdi,rax
     571:	e8 00 00 00 00       	call   576 <fil_fd_allocate+0x15f>
				fdc = fdc->next;
     576:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     57a:	48 8b 80 00 0a 00 00 	mov    rax,QWORD PTR [rax+0xa00]
     581:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				for (i = 0; i < 64; i++) {
     585:	e9 ac fe ff ff       	jmp    436 <fil_fd_allocate+0x1f>
}
     58a:	c9                   	leave
     58b:	c3                   	ret

000000000000058c <fil_fd_free>:
{
     58c:	55                   	push   rbp
     58d:	48 89 e5             	mov    rbp,rsp
     590:	48 83 ec 18          	sub    rsp,0x18
     594:	89 7d ec             	mov    DWORD PTR [rbp-0x14],edi
		struct fil_fdc* fdc = &fdc0;
     597:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
				if (fd >= 64) {
     59f:	83 7d ec 3f          	cmp    DWORD PTR [rbp-0x14],0x3f
     5a3:	7e 1c                	jle    5c1 <fil_fd_free+0x35>
						fdc = fdc->next;
     5a5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     5a9:	48 8b 80 00 0a 00 00 	mov    rax,QWORD PTR [rax+0xa00]
     5b0:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						fd -= 64;
     5b4:	83 6d ec 40          	sub    DWORD PTR [rbp-0x14],0x40
						if (!fdc)
     5b8:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     5bd:	75 e0                	jne    59f <fil_fd_free+0x13>
								return;
     5bf:	eb 48                	jmp    609 <fil_fd_free+0x7d>
						if (fdc->fds[fd].in) {
     5c1:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
     5c5:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     5c8:	48 63 d0             	movsxd rdx,eax
     5cb:	48 89 d0             	mov    rax,rdx
     5ce:	48 c1 e0 02          	shl    rax,0x2
     5d2:	48 01 d0             	add    rax,rdx
     5d5:	48 c1 e0 03          	shl    rax,0x3
     5d9:	48 01 c8             	add    rax,rcx
     5dc:	48 8b 00             	mov    rax,QWORD PTR [rax]
     5df:	48 85 c0             	test   rax,rax
     5e2:	74 24                	je     608 <fil_fd_free+0x7c>
								fdc->fds[fd].in = NULL;
     5e4:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
     5e8:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     5eb:	48 63 d0             	movsxd rdx,eax
     5ee:	48 89 d0             	mov    rax,rdx
     5f1:	48 c1 e0 02          	shl    rax,0x2
     5f5:	48 01 d0             	add    rax,rdx
     5f8:	48 c1 e0 03          	shl    rax,0x3
     5fc:	48 01 c8             	add    rax,rcx
     5ff:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
								return;
     606:	eb 01                	jmp    609 <fil_fd_free+0x7d>
								return;
     608:	90                   	nop
}
     609:	c9                   	leave
     60a:	c3                   	ret

000000000000060b <ino_allocate>:
{
     60b:	55                   	push   rbp
     60c:	48 89 e5             	mov    rbp,rsp
     60f:	48 83 ec 30          	sub    rsp,0x30
     613:	89 7d dc             	mov    DWORD PTR [rbp-0x24],edi
		struct fil_inc* fi = &inc0; ino_t val = 1;
     616:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
     61e:	48 c7 45 f8 01 00 00 00 	mov    QWORD PTR [rbp-0x8],0x1
				struct inode* in = fi->inodes;
     626:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     62a:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
						if (__sync_bool_compare_and_swap(&in->in_stat.st_ino, 0, val)) {
     62e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     632:	48 8d 48 08          	lea    rcx,[rax+0x8]
     636:	b8 00 00 00 00       	mov    eax,0x0
     63b:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     63f:	f0 48 0f b1 11       	lock cmpxchg QWORD PTR [rcx],rdx
     644:	0f 94 c0             	sete   al
     647:	84 c0                	test   al,al
     649:	0f 84 c0 00 00 00    	je     70f <ino_allocate+0x104>
								in->in_stat.st_nlink = 0;
     64f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     653:	48 c7 40 18 00 00 00 00 	mov    QWORD PTR [rax+0x18],0x0
								in->in_lock = (rwlock_t)RW_LOCK_UNLOCKED;
     65b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     65f:	c7 80 88 00 00 00 00 00 00 00 	mov    DWORD PTR [rax+0x88],0x0
     669:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     66d:	66 c7 80 8c 00 00 00 00 00 	mov    WORD PTR [rax+0x8c],0x0
								bzero(in->in_ddat, sizeof(in->in_ddat));
     676:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     67a:	48 83 c0 78          	add    rax,0x78
     67e:	be 08 00 00 00       	mov    esi,0x8
     683:	48 89 c7             	mov    rdi,rax
     686:	e8 00 00 00 00       	call   68b <ino_allocate+0x80>
								if (init) {
     68b:	83 7d dc 00          	cmp    DWORD PTR [rbp-0x24],0x0
     68f:	74 6c                	je     6fd <ino_allocate+0xf2>
										in->in_stat.st_uid = 0;
     691:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     695:	c7 40 20 00 00 00 00 	mov    DWORD PTR [rax+0x20],0x0
										in->in_stat.st_gid = 0;
     69c:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     6a0:	c7 40 24 00 00 00 00 	mov    DWORD PTR [rax+0x24],0x0
										in->in_stat.st_mode = init | S_IRWXU | S_IRGRP | S_IXGRP | S_IROTH | S_IXOTH;
     6a7:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
     6aa:	0d ed 01 00 00       	or     eax,0x1ed
     6af:	89 c2                	mov    edx,eax
     6b1:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     6b5:	89 50 10             	mov    DWORD PTR [rax+0x10],edx
										clock_gettime(CLOCK_REALTIME, &in->in_stat.st_ctim);
     6b8:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     6bc:	48 83 c0 68          	add    rax,0x68
     6c0:	48 89 c6             	mov    rsi,rax
     6c3:	bf 00 00 00 00       	mov    edi,0x0
     6c8:	e8 00 00 00 00       	call   6cd <ino_allocate+0xc2>
												= in->in_stat.st_ctim;
     6cd:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
     6d1:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     6d5:	48 8b 50 70          	mov    rdx,QWORD PTR [rax+0x70]
     6d9:	48 8b 40 68          	mov    rax,QWORD PTR [rax+0x68]
     6dd:	48 89 41 48          	mov    QWORD PTR [rcx+0x48],rax
     6e1:	48 89 51 50          	mov    QWORD PTR [rcx+0x50],rdx
										in->in_stat.st_mtim = in->in_stat.st_atim
     6e5:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
     6e9:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     6ed:	48 8b 50 50          	mov    rdx,QWORD PTR [rax+0x50]
     6f1:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
     6f5:	48 89 41 58          	mov    QWORD PTR [rcx+0x58],rax
     6f9:	48 89 51 60          	mov    QWORD PTR [rcx+0x60],rdx
								__sync_fetch_and_add(&ino_ct, 1);
     6fd:	f0 48 83 05 00 00 00 00 01 	lock add QWORD PTR [rip+0x0],0x1        # 706 <ino_allocate+0xfb>
								return in;
     706:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     70a:	e9 ab 00 00 00       	jmp    7ba <ino_allocate+0x1af>
						val++;
     70f:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
				} while ((void*)(in++) != (void*)(&fi->next));
     714:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     718:	48 8d 90 90 00 00 00 	lea    rdx,[rax+0x90]
     71f:	48 89 55 f0          	mov    QWORD PTR [rbp-0x10],rdx
     723:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     727:	48 81 c2 00 24 00 00 	add    rdx,0x2400
     72e:	48 39 d0             	cmp    rax,rdx
     731:	0f 85 f7 fe ff ff    	jne    62e <ino_allocate+0x23>
				if (!fi->next) {
     737:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     73b:	48 8b 80 00 24 00 00 	mov    rax,QWORD PTR [rax+0x2400]
     742:	48 85 c0             	test   rax,rax
     745:	0f 85 db fe ff ff    	jne    626 <ino_allocate+0x1b>
						struct fil_inc* fi2 = kmalloc(sizeof(struct fil_inc));
     74b:	bf 08 24 00 00       	mov    edi,0x2408
     750:	e8 00 00 00 00       	call   755 <ino_allocate+0x14a>
     755:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
						if (!fi2) {
     759:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
     75e:	75 11                	jne    771 <ino_allocate+0x166>
								errno = ENOMEM;
     760:	c7 05 00 00 00 00 0c 00 00 00 	mov    DWORD PTR [rip+0x0],0xc        # 76a <ino_allocate+0x15f>
								return NULL;
     76a:	b8 00 00 00 00       	mov    eax,0x0
     76f:	eb 49                	jmp    7ba <ino_allocate+0x1af>
						bzero(fi2, sizeof(*fi2));
     771:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     775:	be 08 24 00 00       	mov    esi,0x2408
     77a:	48 89 c7             	mov    rdi,rax
     77d:	e8 00 00 00 00       	call   782 <ino_allocate+0x177>
						if (!__sync_bool_compare_and_swap(&fi->next, NULL, fi2)) {
     782:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     786:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     78a:	48 8d 88 00 24 00 00 	lea    rcx,[rax+0x2400]
     791:	b8 00 00 00 00       	mov    eax,0x0
     796:	f0 48 0f b1 11       	lock cmpxchg QWORD PTR [rcx],rdx
     79b:	0f 94 c0             	sete   al
     79e:	83 f0 01             	xor    eax,0x1
     7a1:	84 c0                	test   al,al
     7a3:	0f 84 7d fe ff ff    	je     626 <ino_allocate+0x1b>
								kfree(fi2);
     7a9:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     7ad:	48 89 c7             	mov    rdi,rax
     7b0:	e8 00 00 00 00       	call   7b5 <ino_allocate+0x1aa>
		while (1) {
     7b5:	e9 6c fe ff ff       	jmp    626 <ino_allocate+0x1b>
}
     7ba:	c9                   	leave
     7bb:	c3                   	ret

00000000000007bc <ino_release>:
{
     7bc:	55                   	push   rbp
     7bd:	48 89 e5             	mov    rbp,rsp
     7c0:	48 83 ec 08          	sub    rsp,0x8
     7c4:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		ino->in_stat.st_ino = 0;
     7c8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     7cc:	48 c7 40 08 00 00 00 00 	mov    QWORD PTR [rax+0x8],0x0
		return __sync_fetch_and_sub(&ino_ct, 1);
     7d4:	b8 01 00 00 00       	mov    eax,0x1
     7d9:	48 f7 d8             	neg    rax
     7dc:	f0 48 0f c1 05 00 00 00 00 	lock xadd QWORD PTR [rip+0x0],rax        # 7e5 <ino_release+0x29>
}
     7e5:	c9                   	leave
     7e6:	c3                   	ret

00000000000007e7 <memdev_store_node>:
{
     7e7:	55                   	push   rbp
     7e8:	48 89 e5             	mov    rbp,rsp
     7eb:	48 83 ec 30          	sub    rsp,0x30
     7ef:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		struct memdev_node** ns = memdev_data->nodes;
     7f3:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 7fa <memdev_store_node+0x13>
     7fa:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     7fe:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		for (i = 0; i < memdev_data->node_cap_bts; i++) {
     802:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
     80a:	e9 6e 01 00 00       	jmp    97d <memdev_store_node+0x196>
				if (__sync_bool_compare_and_swap(&ns[i], NULL, n))
     80f:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
     813:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     817:	48 8d 0c c5 00 00 00 00 	lea    rcx,[rax*8+0x0]
     81f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     823:	48 01 c1             	add    rcx,rax
     826:	b8 00 00 00 00       	mov    eax,0x0
     82b:	f0 48 0f b1 11       	lock cmpxchg QWORD PTR [rcx],rdx
     830:	0f 94 c0             	sete   al
     833:	84 c0                	test   al,al
     835:	74 18                	je     84f <memdev_store_node+0x68>
						return &ns[i]; /* stored */
     837:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     83b:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     843:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     847:	48 01 d0             	add    rax,rdx
     84a:	e9 48 01 00 00       	jmp    997 <memdev_store_node+0x1b0>
				if (i == memdev_data->node_cap_bts - 2) { /* next is ptr */
     84f:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 856 <memdev_store_node+0x6f>
     856:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
     85a:	48 83 e8 02          	sub    rax,0x2
     85e:	48 39 45 f0          	cmp    QWORD PTR [rbp-0x10],rax
     862:	0f 85 10 01 00 00    	jne    978 <memdev_store_node+0x191>
						if (ns[++i])
     868:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
     86d:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     871:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     879:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     87d:	48 01 d0             	add    rax,rdx
     880:	48 8b 00             	mov    rax,QWORD PTR [rax]
     883:	48 85 c0             	test   rax,rax
     886:	74 1f                	je     8a7 <memdev_store_node+0xc0>
								ns = (struct memdev_node**)ns[i];
     888:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     88c:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     894:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     898:	48 01 d0             	add    rax,rdx
     89b:	48 8b 00             	mov    rax,QWORD PTR [rax]
     89e:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
     8a2:	e9 c9 00 00 00       	jmp    970 <memdev_store_node+0x189>
									memdev_data->node_cap_bts * sizeof(struct memdev_node*));
     8a7:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 8ae <memdev_store_node+0xc7>
     8ae:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
								ns2 = h_malloc(memdev_data->heap,
     8b2:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     8ba:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 8c1 <memdev_store_node+0xda>
     8c1:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
     8c5:	48 89 d6             	mov    rsi,rdx
     8c8:	48 89 c7             	mov    rdi,rax
     8cb:	e8 00 00 00 00       	call   8d0 <memdev_store_node+0xe9>
     8d0:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
								if (!ns2) /* OOM */
     8d4:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
     8d9:	75 0a                	jne    8e5 <memdev_store_node+0xfe>
										return NULL;
     8db:	b8 00 00 00 00       	mov    eax,0x0
     8e0:	e9 b2 00 00 00       	jmp    997 <memdev_store_node+0x1b0>
								bzero(ns2, memdev_data->node_cap_bts * sizeof(struct memdev_node*));
     8e5:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 8ec <memdev_store_node+0x105>
     8ec:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
     8f0:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     8f8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     8fc:	48 89 d6             	mov    rsi,rdx
     8ff:	48 89 c7             	mov    rdi,rax
     902:	e8 00 00 00 00       	call   907 <memdev_store_node+0x120>
								if (!__sync_bool_compare_and_swap(&ns[i], NULL, ns2)) {
     907:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     90b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     90f:	48 8d 0c c5 00 00 00 00 	lea    rcx,[rax*8+0x0]
     917:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     91b:	48 01 c1             	add    rcx,rax
     91e:	b8 00 00 00 00       	mov    eax,0x0
     923:	f0 48 0f b1 11       	lock cmpxchg QWORD PTR [rcx],rdx
     928:	0f 94 c0             	sete   al
     92b:	83 f0 01             	xor    eax,0x1
     92e:	84 c0                	test   al,al
     930:	74 36                	je     968 <memdev_store_node+0x181>
										h_free(memdev_data->heap, ns2);
     932:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 939 <memdev_store_node+0x152>
     939:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
     93d:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     941:	48 89 d6             	mov    rsi,rdx
     944:	48 89 c7             	mov    rdi,rax
     947:	e8 00 00 00 00       	call   94c <memdev_store_node+0x165>
										ns = (struct memdev_node**)ns[i];
     94c:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     950:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     958:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     95c:	48 01 d0             	add    rax,rdx
     95f:	48 8b 00             	mov    rax,QWORD PTR [rax]
     962:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
     966:	eb 08                	jmp    970 <memdev_store_node+0x189>
										ns = ns2;
     968:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     96c:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						i = 0;
     970:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		for (i = 0; i < memdev_data->node_cap_bts; i++) {
     978:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
     97d:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 984 <memdev_store_node+0x19d>
     984:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
     988:	48 39 45 f0          	cmp    QWORD PTR [rbp-0x10],rax
     98c:	0f 82 7d fe ff ff    	jb     80f <memdev_store_node+0x28>
		return NULL;
     992:	b8 00 00 00 00       	mov    eax,0x0
}
     997:	c9                   	leave
     998:	c3                   	ret

0000000000000999 <memdev_register>:
{
     999:	55                   	push   rbp
     99a:	48 89 e5             	mov    rbp,rsp
     99d:	53                   	push   rbx
     99e:	48 83 ec 28          	sub    rsp,0x28
     9a2:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		memdev_data = (struct memdev_data*)kmalloc(sizeof(struct memdev_data));
     9a6:	bf 28 00 00 00       	mov    edi,0x28
     9ab:	e8 00 00 00 00       	call   9b0 <memdev_register+0x17>
     9b0:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 9b7 <memdev_register+0x1e>
		if (!memdev_data)
     9b7:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 9be <memdev_register+0x25>
     9be:	48 85 c0             	test   rax,rax
     9c1:	75 0a                	jne    9cd <memdev_register+0x34>
				return -1;
     9c3:	b8 ff ff ff ff       	mov    eax,0xffffffff
     9c8:	e9 5b 01 00 00       	jmp    b28 <memdev_register+0x18f>
		memdev_data->id = d;
     9cd:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 9d4 <memdev_register+0x3b>
     9d4:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
     9d8:	48 89 10             	mov    QWORD PTR [rax],rdx
		memdev_data->node_ct = 0;
     9db:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 9e2 <memdev_register+0x49>
     9e2:	48 c7 40 10 00 00 00 00 	mov    QWORD PTR [rax+0x10],0x0
		memdev_data->node_cap_bts = 4096;
     9ea:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 9f1 <memdev_register+0x58>
     9f1:	48 c7 40 18 00 10 00 00 	mov    QWORD PTR [rax+0x18],0x1000
		memdev_data->heap = mm_alloc_vmem(&mm_kernel, NULL, 25,
     9f9:	48 8b 1d 00 00 00 00 	mov    rbx,QWORD PTR [rip+0x0]        # a00 <memdev_register+0x67>
     a00:	b9 0c 00 00 00       	mov    ecx,0xc
     a05:	ba 19 00 00 00       	mov    edx,0x19
     a0a:	be 00 00 00 00       	mov    esi,0x0
     a0f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     a16:	e8 00 00 00 00       	call   a1b <memdev_register+0x82>
     a1b:	48 89 43 20          	mov    QWORD PTR [rbx+0x20],rax
		if (!memdev_data->heap) {
     a1f:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # a26 <memdev_register+0x8d>
     a26:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
     a2a:	48 85 c0             	test   rax,rax
     a2d:	75 19                	jne    a48 <memdev_register+0xaf>
				kfree(memdev_data);
     a2f:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # a36 <memdev_register+0x9d>
     a36:	48 89 c7             	mov    rdi,rax
     a39:	e8 00 00 00 00       	call   a3e <memdev_register+0xa5>
				return -1;
     a3e:	b8 ff ff ff ff       	mov    eax,0xffffffff
     a43:	e9 e0 00 00 00       	jmp    b28 <memdev_register+0x18f>
		ptr = h_create_heap(memdev_data->heap, 25 * 4096, h_generic_oom_handler, h_generic_decommit);
     a48:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # a4f <memdev_register+0xb6>
     a4f:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
     a53:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
     a5a:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
     a61:	be 00 90 01 00       	mov    esi,0x19000
     a66:	48 89 c7             	mov    rdi,rax
     a69:	e8 00 00 00 00       	call   a6e <memdev_register+0xd5>
     a6e:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		if (!ptr) {
     a72:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
     a77:	75 35                	jne    aae <memdev_register+0x115>
				mm_free_vmem(&mm_kernel, memdev_data->heap, 25);
     a79:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # a80 <memdev_register+0xe7>
     a80:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
     a84:	ba 19 00 00 00       	mov    edx,0x19
     a89:	48 89 c6             	mov    rsi,rax
     a8c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     a93:	e8 00 00 00 00       	call   a98 <memdev_register+0xff>
				kfree(memdev_data);
     a98:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # a9f <memdev_register+0x106>
     a9f:	48 89 c7             	mov    rdi,rax
     aa2:	e8 00 00 00 00       	call   aa7 <memdev_register+0x10e>
				return -1;
     aa7:	b8 ff ff ff ff       	mov    eax,0xffffffff
     aac:	eb 7a                	jmp    b28 <memdev_register+0x18f>
		memdev_data->heap = ptr;
     aae:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # ab5 <memdev_register+0x11c>
     ab5:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     ab9:	48 89 50 20          	mov    QWORD PTR [rax+0x20],rdx
		memdev_data->nodes = h_malloc(ptr, 4096 * sizeof(struct memdev_node*));
     abd:	48 8b 1d 00 00 00 00 	mov    rbx,QWORD PTR [rip+0x0]        # ac4 <memdev_register+0x12b>
     ac4:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     ac8:	be 00 80 00 00       	mov    esi,0x8000
     acd:	48 89 c7             	mov    rdi,rax
     ad0:	e8 00 00 00 00       	call   ad5 <memdev_register+0x13c>
     ad5:	48 89 43 08          	mov    QWORD PTR [rbx+0x8],rax
		if (!memdev_data->nodes) {
     ad9:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # ae0 <memdev_register+0x147>
     ae0:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     ae4:	48 85 c0             	test   rax,rax
     ae7:	75 22                	jne    b0b <memdev_register+0x172>
				h_destroy(ptr);
     ae9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     aed:	48 89 c7             	mov    rdi,rax
     af0:	e8 00 00 00 00       	call   af5 <memdev_register+0x15c>
				kfree(memdev_data);
     af5:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # afc <memdev_register+0x163>
     afc:	48 89 c7             	mov    rdi,rax
     aff:	e8 00 00 00 00       	call   b04 <memdev_register+0x16b>
				return -1;
     b04:	b8 ff ff ff ff       	mov    eax,0xffffffff
     b09:	eb 1d                	jmp    b28 <memdev_register+0x18f>
		bzero(memdev_data->nodes, 4096 * sizeof(struct memdev_node*));
     b0b:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # b12 <memdev_register+0x179>
     b12:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     b16:	be 00 80 00 00       	mov    esi,0x8000
     b1b:	48 89 c7             	mov    rdi,rax
     b1e:	e8 00 00 00 00       	call   b23 <memdev_register+0x18a>
		return 0;
     b23:	b8 00 00 00 00       	mov    eax,0x0
}
     b28:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
     b2c:	c9                   	leave
     b2d:	c3                   	ret

0000000000000b2e <memdev_unregister>:
{
     b2e:	55                   	push   rbp
     b2f:	48 89 e5             	mov    rbp,rsp
		errno = ENOSYS;
     b32:	c7 05 00 00 00 00 26 00 00 00 	mov    DWORD PTR [rip+0x0],0x26        # b3c <memdev_unregister+0xe>
		return -1;
     b3c:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
     b41:	5d                   	pop    rbp
     b42:	c3                   	ret

0000000000000b43 <memdev_open>:

/* mode only on O_CREAT which is done externally */
int memdev_open(struct inode* in, int flags/*, mode_t mod*/)
{
     b43:	55                   	push   rbp
     b44:	48 89 e5             	mov    rbp,rsp
     b47:	48 83 ec 20          	sub    rsp,0x20
     b4b:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
     b4f:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
		struct fil_fd* fd; int rv;
		if (!in || in->in_stat.st_dev != memdev_data->id) {
     b52:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
     b57:	74 16                	je     b6f <memdev_open+0x2c>
     b59:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     b5d:	48 8b 10             	mov    rdx,QWORD PTR [rax]
     b60:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # b67 <memdev_open+0x24>
     b67:	48 8b 00             	mov    rax,QWORD PTR [rax]
     b6a:	48 39 c2             	cmp    rdx,rax
     b6d:	74 11                	je     b80 <memdev_open+0x3d>
				errno = EINVAL;
     b6f:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # b79 <memdev_open+0x36>
				return -1;
     b79:	b8 ff ff ff ff       	mov    eax,0xffffffff
     b7e:	eb 54                	jmp    bd4 <memdev_open+0x91>
		}

		/* access checks are done on the level above */
		fd = fil_fd_allocate(in, &rv);
     b80:	48 8d 55 f4          	lea    rdx,[rbp-0xc]
     b84:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     b88:	48 89 d6             	mov    rsi,rdx
     b8b:	48 89 c7             	mov    rdi,rax
     b8e:	e8 00 00 00 00       	call   b93 <memdev_open+0x50>
     b93:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (!fd) {
     b97:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     b9c:	75 11                	jne    baf <memdev_open+0x6c>
				errno = ENOMEM;
     b9e:	c7 05 00 00 00 00 0c 00 00 00 	mov    DWORD PTR [rip+0x0],0xc        # ba8 <memdev_open+0x65>
				return -1;
     ba8:	b8 ff ff ff ff       	mov    eax,0xffffffff
     bad:	eb 25                	jmp    bd4 <memdev_open+0x91>
		}

		fd->flags = flags;
     baf:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     bb3:	8b 55 e4             	mov    edx,DWORD PTR [rbp-0x1c]
     bb6:	89 50 10             	mov    DWORD PTR [rax+0x10],edx
		fd->seek_offset = 0;
     bb9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     bbd:	48 c7 40 08 00 00 00 00 	mov    QWORD PTR [rax+0x8],0x0
		__sync_fetch_and_add((int*)in->in_ddat, 1);
     bc5:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     bc9:	48 83 c0 78          	add    rax,0x78
     bcd:	f0 83 00 01          	lock add DWORD PTR [rax],0x1
		return rv;
     bd1:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
}
     bd4:	c9                   	leave
     bd5:	c3                   	ret

0000000000000bd6 <memdev_read>:

ssize_t memdev_read(struct inode* in, int fd, void* buf, size_t noct)
{
     bd6:	55                   	push   rbp
     bd7:	48 89 e5             	mov    rbp,rsp
     bda:	48 83 ec 40          	sub    rsp,0x40
     bde:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
     be2:	89 75 d4             	mov    DWORD PTR [rbp-0x2c],esi
     be5:	48 89 55 c8          	mov    QWORD PTR [rbp-0x38],rdx
     be9:	48 89 4d c0          	mov    QWORD PTR [rbp-0x40],rcx
		struct fil_fd* f; ssize_t rv = 0;
     bed:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		struct memdev_node* n;
		if (!in || !buf || in->in_stat.st_dev != memdev_data->id) {
     bf4:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
     bf9:	74 1d                	je     c18 <memdev_read+0x42>
     bfb:	48 83 7d c8 00       	cmp    QWORD PTR [rbp-0x38],0x0
     c00:	74 16                	je     c18 <memdev_read+0x42>
     c02:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     c06:	48 8b 10             	mov    rdx,QWORD PTR [rax]
     c09:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # c10 <memdev_read+0x3a>
     c10:	48 8b 00             	mov    rax,QWORD PTR [rax]
     c13:	48 39 c2             	cmp    rdx,rax
     c16:	74 14                	je     c2c <memdev_read+0x56>
				errno = EINVAL;
     c18:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # c22 <memdev_read+0x4c>
				return -1;
     c22:	b8 ff ff ff ff       	mov    eax,0xffffffff
     c27:	e9 27 01 00 00       	jmp    d53 <memdev_read+0x17d>
		}

		f = fil_fd_get(fd);
     c2c:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
     c2f:	89 c7                	mov    edi,eax
     c31:	e8 00 00 00 00       	call   c36 <memdev_read+0x60>
     c36:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		if (!f || (f->flags & O_WRONLY)
     c3a:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
     c3f:	74 0e                	je     c4f <memdev_read+0x79>
     c41:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     c45:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     c48:	83 e0 01             	and    eax,0x1
     c4b:	85 c0                	test   eax,eax
     c4d:	74 14                	je     c63 <memdev_read+0x8d>
			/*|| ((f->flags & O_SEARCH) && !S_ISDIR(in->in_stat.st_mode))*/
			/*|| (f->flags & O_EXEC)*/) { /* O_EXEC->mmap with exec */
				errno = EBADF;
     c4f:	c7 05 00 00 00 00 09 00 00 00 	mov    DWORD PTR [rip+0x0],0x9        # c59 <memdev_read+0x83>
				return -1;
     c59:	b8 ff ff ff ff       	mov    eax,0xffffffff
     c5e:	e9 f0 00 00 00       	jmp    d53 <memdev_read+0x17d>
		}

		/* now lock for read access */
		read_lock(&in->in_lock);
     c63:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     c67:	48 05 88 00 00 00    	add    rax,0x88
     c6d:	48 89 c7             	mov    rdi,rax
     c70:	e8 00 00 00 00       	call   c75 <memdev_read+0x9f>
		n = *(struct memdev_node**)in->in_pddat;
     c75:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     c79:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
     c80:	48 8b 00             	mov    rax,QWORD PTR [rax]
     c83:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		if (f->seek_offset < (n->size - sizeof(struct memdev_node))) {
     c87:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     c8b:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     c8f:	48 89 c2             	mov    rdx,rax
     c92:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     c96:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     c9a:	48 83 e8 20          	sub    rax,0x20
     c9e:	48 39 c2             	cmp    rdx,rax
     ca1:	73 70                	jae    d13 <memdev_read+0x13d>
				/* read up to noct bytes */
				rv = n->size - sizeof(struct memdev_node) - f->seek_offset;
     ca3:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     ca7:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     cab:	89 c1                	mov    ecx,eax
     cad:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     cb1:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     cb5:	89 c2                	mov    edx,eax
     cb7:	89 c8                	mov    eax,ecx
     cb9:	29 d0                	sub    eax,edx
     cbb:	83 e8 20             	sub    eax,0x20
     cbe:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
				if ((size_t)rv > noct)
     cc1:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     cc4:	48 98                	cdqe
     cc6:	48 39 45 c0          	cmp    QWORD PTR [rbp-0x40],rax
     cca:	73 07                	jae    cd3 <memdev_read+0xfd>
						rv = noct;
     ccc:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     cd0:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
				memcpy(buf, n->data + f->seek_offset, rv);
     cd3:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     cd6:	48 63 d0             	movsxd rdx,eax
     cd9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     cdd:	48 8d 48 20          	lea    rcx,[rax+0x20]
     ce1:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     ce5:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     ce9:	48 01 c1             	add    rcx,rax
     cec:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     cf0:	48 89 ce             	mov    rsi,rcx
     cf3:	48 89 c7             	mov    rdi,rax
     cf6:	e8 05 f3 ff ff       	call   0 <memcpy>
				f->seek_offset += rv;
     cfb:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     cff:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
     d03:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     d06:	48 98                	cdqe
     d08:	48 01 c2             	add    rdx,rax
     d0b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     d0f:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
		}
		if (rv > 0 && !(f->flags & O_NOATIME)) {/* set atime */
     d13:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
     d17:	7e 25                	jle    d3e <memdev_read+0x168>
     d19:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     d1d:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     d20:	25 00 00 04 00       	and    eax,0x40000
     d25:	85 c0                	test   eax,eax
     d27:	75 15                	jne    d3e <memdev_read+0x168>
				clock_gettime(CLOCK_REALTIME, &in->in_stat.st_atim);
     d29:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     d2d:	48 83 c0 48          	add    rax,0x48
     d31:	48 89 c6             	mov    rsi,rax
     d34:	bf 00 00 00 00       	mov    edi,0x0
     d39:	e8 00 00 00 00       	call   d3e <memdev_read+0x168>
		}
		read_unlock(&in->in_lock);
     d3e:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     d42:	48 05 88 00 00 00    	add    rax,0x88
     d48:	48 89 c7             	mov    rdi,rax
     d4b:	e8 00 00 00 00       	call   d50 <memdev_read+0x17a>
		return rv;
     d50:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
     d53:	c9                   	leave
     d54:	c3                   	ret

0000000000000d55 <memdev_write>:

ssize_t memdev_write(struct inode* in, int fd, const void* buf, size_t noct)
{
     d55:	55                   	push   rbp
     d56:	48 89 e5             	mov    rbp,rsp
     d59:	48 83 ec 50          	sub    rsp,0x50
     d5d:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
     d61:	89 75 c4             	mov    DWORD PTR [rbp-0x3c],esi
     d64:	48 89 55 b8          	mov    QWORD PTR [rbp-0x48],rdx
     d68:	48 89 4d b0          	mov    QWORD PTR [rbp-0x50],rcx
		struct fil_fd* f; struct memdev_node* n; size_t s_ext = 0;
     d6c:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		if (!in || !buf || in->in_stat.st_dev != memdev_data->id) {
     d74:	48 83 7d c8 00       	cmp    QWORD PTR [rbp-0x38],0x0
     d79:	74 1d                	je     d98 <memdev_write+0x43>
     d7b:	48 83 7d b8 00       	cmp    QWORD PTR [rbp-0x48],0x0
     d80:	74 16                	je     d98 <memdev_write+0x43>
     d82:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     d86:	48 8b 10             	mov    rdx,QWORD PTR [rax]
     d89:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # d90 <memdev_write+0x3b>
     d90:	48 8b 00             	mov    rax,QWORD PTR [rax]
     d93:	48 39 c2             	cmp    rdx,rax
     d96:	74 14                	je     dac <memdev_write+0x57>
				errno = EINVAL;
     d98:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # da2 <memdev_write+0x4d>
				return -1;
     da2:	b8 ff ff ff ff       	mov    eax,0xffffffff
     da7:	e9 a1 03 00 00       	jmp    114d <memdev_write+0x3f8>
		}
		if (!(f = fil_fd_get(fd))) {
     dac:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
     daf:	89 c7                	mov    edi,eax
     db1:	e8 00 00 00 00       	call   db6 <memdev_write+0x61>
     db6:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
     dba:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
     dbf:	75 14                	jne    dd5 <memdev_write+0x80>
				errno = EBADF;
     dc1:	c7 05 00 00 00 00 09 00 00 00 	mov    DWORD PTR [rip+0x0],0x9        # dcb <memdev_write+0x76>
				return -1;
     dcb:	b8 ff ff ff ff       	mov    eax,0xffffffff
     dd0:	e9 78 03 00 00       	jmp    114d <memdev_write+0x3f8>
		}

		/* acquire the lock */
		write_lock(&in->in_lock);
     dd5:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     dd9:	48 05 88 00 00 00    	add    rax,0x88
     ddf:	48 89 c7             	mov    rdi,rax
     de2:	e8 00 00 00 00       	call   de7 <memdev_write+0x92>
		n = *(struct memdev_node**)in->in_pddat;
     de7:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     deb:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
     df2:	48 8b 00             	mov    rax,QWORD PTR [rax]
     df5:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (f->flags & O_APPEND) /* atomic append */
     df9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     dfd:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     e00:	25 00 04 00 00       	and    eax,0x400
     e05:	85 c0                	test   eax,eax
     e07:	74 17                	je     e20 <memdev_write+0xcb>
				f->seek_offset = n->size - sizeof(struct memdev_node);
     e09:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     e0d:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     e11:	48 83 e8 20          	sub    rax,0x20
     e15:	48 89 c2             	mov    rdx,rax
     e18:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     e1c:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
		if (f->seek_offset + noct > n->size) {
     e20:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     e24:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     e28:	48 89 c2             	mov    rdx,rax
     e2b:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     e2f:	48 01 c2             	add    rdx,rax
     e32:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     e36:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     e3a:	48 39 d0             	cmp    rax,rdx
     e3d:	0f 83 69 02 00 00    	jae    10ac <memdev_write+0x357>
				/* we have to extend */
				s_ext = f->seek_offset + noct + sizeof(struct memdev_node);
     e43:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     e47:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     e4b:	48 89 c2             	mov    rdx,rax
     e4e:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     e52:	48 01 d0             	add    rax,rdx
     e55:	48 83 c0 20          	add    rax,0x20
     e59:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				if (s_ext > n->cap) { /* really */
     e5d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     e61:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
     e65:	48 3b 45 f0          	cmp    rax,QWORD PTR [rbp-0x10]
     e69:	0f 83 dc 01 00 00    	jae    104b <memdev_write+0x2f6>
						size_t new_cap; void* mem;
						if (S_ISREG(in->in_stat.st_mode)) {
     e6f:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     e73:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     e76:	25 00 f0 00 00       	and    eax,0xf000
     e7b:	3d 00 80 00 00       	cmp    eax,0x8000
     e80:	0f 85 e6 00 00 00    	jne    f6c <memdev_write+0x217>
								/* work on pages */
								new_cap = s_ext / 4096 + (s_ext % 4096 ? 1 : 0) * 4096;
     e86:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     e8a:	48 c1 e8 0c          	shr    rax,0xc
     e8e:	48 89 c2             	mov    rdx,rax
     e91:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     e95:	25 ff 0f 00 00       	and    eax,0xfff
     e9a:	48 85 c0             	test   rax,rax
     e9d:	74 07                	je     ea6 <memdev_write+0x151>
     e9f:	b8 00 10 00 00       	mov    eax,0x1000
     ea4:	eb 05                	jmp    eab <memdev_write+0x156>
     ea6:	b8 00 00 00 00       	mov    eax,0x0
     eab:	48 01 d0             	add    rax,rdx
     eae:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
								mem = mm_extend_vmem(&mm_kernel, n, n->cap / 4096,
     eb2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     eb6:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
     eba:	48 c1 e8 0c          	shr    rax,0xc
     ebe:	48 89 c6             	mov    rsi,rax
     ec1:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     ec5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     ec9:	41 b8 0c 00 00 00    	mov    r8d,0xc
     ecf:	48 89 d1             	mov    rcx,rdx
     ed2:	48 89 f2             	mov    rdx,rsi
     ed5:	48 89 c6             	mov    rsi,rax
     ed8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     edf:	e8 00 00 00 00       	call   ee4 <memdev_write+0x18f>
     ee4:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
												new_cap, MMGR_MAP_WRITE | MMGR_MAP_KERNEL);
								if (mem) {
     ee8:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
     eed:	74 3e                	je     f2d <memdev_write+0x1d8>
										n = (struct memdev_node*)mem;
     eef:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     ef3:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
										*(struct memdev_node**)in->in_pddat = n;
     ef7:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     efb:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
     f02:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     f06:	48 89 10             	mov    QWORD PTR [rax],rdx
										n->cap = new_cap * 4096;
     f09:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     f0d:	48 c1 e0 0c          	shl    rax,0xc
     f11:	48 89 c2             	mov    rdx,rax
     f14:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     f18:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
										n->size = s_ext;
     f1c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     f20:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     f24:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
     f28:	e9 2d 01 00 00       	jmp    105a <memdev_write+0x305>
								} else { /* write partially */
										noct = n->cap - n->size;
     f2d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     f31:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
     f35:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     f39:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     f3d:	48 29 c2             	sub    rdx,rax
     f40:	48 89 55 b0          	mov    QWORD PTR [rbp-0x50],rdx
										n->size = n->cap;
     f44:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     f48:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
     f4c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     f50:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
										if (!noct)
     f54:	48 83 7d b0 00       	cmp    QWORD PTR [rbp-0x50],0x0
     f59:	0f 85 fb 00 00 00    	jne    105a <memdev_write+0x305>
												noct = -1;
     f5f:	48 c7 45 b0 ff ff ff ff 	mov    QWORD PTR [rbp-0x50],0xffffffffffffffff
     f67:	e9 ee 00 00 00       	jmp    105a <memdev_write+0x305>
								}
						} else if (S_ISDIR(in->in_stat.st_mode) || S_ISLNK(in->in_stat.st_mode)) {
     f6c:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     f70:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     f73:	25 00 f0 00 00       	and    eax,0xf000
     f78:	3d 00 40 00 00       	cmp    eax,0x4000
     f7d:	74 17                	je     f96 <memdev_write+0x241>
     f7f:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     f83:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     f86:	25 00 f0 00 00       	and    eax,0xf000
     f8b:	3d 00 a0 00 00       	cmp    eax,0xa000
     f90:	0f 85 a1 00 00 00    	jne    1037 <memdev_write+0x2e2>
								/* heap memory */
								new_cap = s_ext + 32; /* prevent many resizes */
     f96:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     f9a:	48 83 c0 20          	add    rax,0x20
     f9e:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
								mem = h_realloc(memdev_data->heap, n, new_cap);
     fa2:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # fa9 <memdev_write+0x254>
     fa9:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
     fad:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     fb1:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
     fb5:	48 89 ce             	mov    rsi,rcx
     fb8:	48 89 c7             	mov    rdi,rax
     fbb:	e8 00 00 00 00       	call   fc0 <memdev_write+0x26b>
     fc0:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
								if (!mem) { /* write partially */
     fc4:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
     fc9:	75 38                	jne    1003 <memdev_write+0x2ae>
										noct = n->cap - n->size;
     fcb:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     fcf:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
     fd3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     fd7:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     fdb:	48 29 c2             	sub    rdx,rax
     fde:	48 89 55 b0          	mov    QWORD PTR [rbp-0x50],rdx
										n->size = n->cap;
     fe2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     fe6:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
     fea:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     fee:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
										if (!noct)
     ff2:	48 83 7d b0 00       	cmp    QWORD PTR [rbp-0x50],0x0
     ff7:	75 60                	jne    1059 <memdev_write+0x304>
												noct = -1;
     ff9:	48 c7 45 b0 ff ff ff ff 	mov    QWORD PTR [rbp-0x50],0xffffffffffffffff
								if (!mem) { /* write partially */
    1001:	eb 56                	jmp    1059 <memdev_write+0x304>
								} else {
										n = (struct memdev_node*)mem;
    1003:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1007:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
										*(struct memdev_node**)in->in_pddat = n;
    100b:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    100f:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
    1016:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    101a:	48 89 10             	mov    QWORD PTR [rax],rdx
										n->cap = new_cap;
    101d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1021:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    1025:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
										n->size = s_ext;
    1029:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    102d:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1031:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
								if (!mem) { /* write partially */
    1035:	eb 22                	jmp    1059 <memdev_write+0x304>
								}
						} else {
								/* wat do? */
								errno = ENOSYS;
    1037:	c7 05 00 00 00 00 26 00 00 00 	mov    DWORD PTR [rip+0x0],0x26        # 1041 <memdev_write+0x2ec>
								noct = -1;
    1041:	48 c7 45 b0 ff ff ff ff 	mov    QWORD PTR [rbp-0x50],0xffffffffffffffff
    1049:	eb 0f                	jmp    105a <memdev_write+0x305>
						}
				} else
						n->size = s_ext;
    104b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    104f:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1053:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
    1057:	eb 01                	jmp    105a <memdev_write+0x305>
								if (!mem) { /* write partially */
    1059:	90                   	nop
				in->in_stat.st_size = n->size - sizeof(struct memdev_node);
    105a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    105e:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1062:	48 83 e8 20          	sub    rax,0x20
    1066:	48 89 c2             	mov    rdx,rax
    1069:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    106d:	48 89 50 30          	mov    QWORD PTR [rax+0x30],rdx
				in->in_stat.st_size = n->cap / 512 + (n->cap % 512 ? 1 : 0);
    1071:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1075:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    1079:	48 c1 e8 09          	shr    rax,0x9
    107d:	48 89 c2             	mov    rdx,rax
    1080:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1084:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    1088:	25 ff 01 00 00       	and    eax,0x1ff
    108d:	48 85 c0             	test   rax,rax
    1090:	74 07                	je     1099 <memdev_write+0x344>
    1092:	b8 01 00 00 00       	mov    eax,0x1
    1097:	eb 05                	jmp    109e <memdev_write+0x349>
    1099:	b8 00 00 00 00       	mov    eax,0x0
    109e:	48 01 d0             	add    rax,rdx
    10a1:	48 89 c2             	mov    rdx,rax
    10a4:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    10a8:	48 89 50 30          	mov    QWORD PTR [rax+0x30],rdx
		}
		/* now copy the data */
		memcpy(n->data + f->seek_offset, buf, noct);
    10ac:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    10b0:	48 8d 50 20          	lea    rdx,[rax+0x20]
    10b4:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    10b8:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    10bc:	48 8d 0c 02          	lea    rcx,[rdx+rax*1]
    10c0:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
    10c4:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    10c8:	48 89 c6             	mov    rsi,rax
    10cb:	48 89 cf             	mov    rdi,rcx
    10ce:	e8 2d ef ff ff       	call   0 <memcpy>
		/* and update the times */
		if (noct > 0) {
    10d3:	48 83 7d b0 00       	cmp    QWORD PTR [rbp-0x50],0x0
    10d8:	74 5d                	je     1137 <memdev_write+0x3e2>
				clock_gettime(CLOCK_REALTIME, &in->in_stat.st_mtim);
    10da:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    10de:	48 83 c0 58          	add    rax,0x58
    10e2:	48 89 c6             	mov    rsi,rax
    10e5:	bf 00 00 00 00       	mov    edi,0x0
    10ea:	e8 00 00 00 00       	call   10ef <memdev_write+0x39a>
				in->in_stat.st_ctim = in->in_stat.st_mtim;
    10ef:	48 8b 4d c8          	mov    rcx,QWORD PTR [rbp-0x38]
    10f3:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    10f7:	48 8b 50 60          	mov    rdx,QWORD PTR [rax+0x60]
    10fb:	48 8b 40 58          	mov    rax,QWORD PTR [rax+0x58]
    10ff:	48 89 41 68          	mov    QWORD PTR [rcx+0x68],rax
    1103:	48 89 51 70          	mov    QWORD PTR [rcx+0x70],rdx
				f->seek_offset += noct; /* only forward (-1 for errno) */
    1107:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    110b:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    110f:	48 89 c2             	mov    rdx,rax
    1112:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1116:	48 01 d0             	add    rax,rdx
    1119:	48 89 c2             	mov    rdx,rax
    111c:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1120:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
				/* clear SUID,SGID */
				in->in_stat.st_mode &= (~(mode_t)S_ISUID) & (~(mode_t)S_ISGID);
    1124:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1128:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    112b:	80 e4 f3             	and    ah,0xf3
    112e:	89 c2                	mov    edx,eax
    1130:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1134:	89 50 10             	mov    DWORD PTR [rax+0x10],edx
		}
		write_unlock(&in->in_lock);
    1137:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    113b:	48 05 88 00 00 00    	add    rax,0x88
    1141:	48 89 c7             	mov    rdi,rax
    1144:	e8 00 00 00 00       	call   1149 <memdev_write+0x3f4>
		return noct;
    1149:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
}
    114d:	c9                   	leave
    114e:	c3                   	ret

000000000000114f <memdev_close>:

int memdev_close(struct inode* in, int fd)
{
    114f:	55                   	push   rbp
    1150:	48 89 e5             	mov    rbp,rsp
    1153:	48 83 ec 20          	sub    rsp,0x20
    1157:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    115b:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
		struct fil_fd* f;
		if (!in || !(f = fil_fd_get(fd))) {
    115e:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    1163:	74 15                	je     117a <memdev_close+0x2b>
    1165:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    1168:	89 c7                	mov    edi,eax
    116a:	e8 00 00 00 00       	call   116f <memdev_close+0x20>
    116f:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1173:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    1178:	75 23                	jne    119d <memdev_close+0x4e>
				errno = in ? EBADF : EINVAL;
    117a:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    117f:	74 07                	je     1188 <memdev_close+0x39>
    1181:	b8 09 00 00 00       	mov    eax,0x9
    1186:	eb 05                	jmp    118d <memdev_close+0x3e>
    1188:	b8 16 00 00 00       	mov    eax,0x16
    118d:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 1193 <memdev_close+0x44>
				return -1;
    1193:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1198:	e9 c8 00 00 00       	jmp    1265 <memdev_close+0x116>
		}
		/* TODO: file locks */
		fil_fd_free(fd);
    119d:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    11a0:	89 c7                	mov    edi,eax
    11a2:	e8 00 00 00 00       	call   11a7 <memdev_close+0x58>
		if (__sync_sub_and_fetch((int*)in->in_ddat, 1) == 0) {
    11a7:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    11ab:	48 8d 50 78          	lea    rdx,[rax+0x78]
    11af:	b8 01 00 00 00       	mov    eax,0x1
    11b4:	f7 d8                	neg    eax
    11b6:	89 c1                	mov    ecx,eax
    11b8:	89 c8                	mov    eax,ecx
    11ba:	f0 0f c1 02          	lock xadd DWORD PTR [rdx],eax
    11be:	01 c8                	add    eax,ecx
    11c0:	85 c0                	test   eax,eax
    11c2:	0f 85 98 00 00 00    	jne    1260 <memdev_close+0x111>
				struct memdev_node* n;
				if (in->in_stat.st_nlink)
    11c8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    11cc:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    11d0:	48 85 c0             	test   rax,rax
    11d3:	74 0a                	je     11df <memdev_close+0x90>
						return 0;
    11d5:	b8 00 00 00 00       	mov    eax,0x0
    11da:	e9 86 00 00 00       	jmp    1265 <memdev_close+0x116>
				/* nlink==0 && nref==0 */
				n = *(struct memdev_node**)in->in_pddat;
    11df:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    11e3:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
    11ea:	48 8b 00             	mov    rax,QWORD PTR [rax]
    11ed:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				*(struct memdev_node**)in->in_pddat = NULL; /* free slot */
    11f1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    11f5:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
    11fc:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
				if (S_ISREG(in->in_stat.st_mode))
    1203:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1207:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    120a:	25 00 f0 00 00       	and    eax,0xf000
    120f:	3d 00 80 00 00       	cmp    eax,0x8000
    1214:	75 24                	jne    123a <memdev_close+0xeb>
						mm_free_vmem(&mm_kernel, n, n->cap / 4096);
    1216:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    121a:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    121e:	48 c1 e8 0c          	shr    rax,0xc
    1222:	48 89 c2             	mov    rdx,rax
    1225:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1229:	48 89 c6             	mov    rsi,rax
    122c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1233:	e8 00 00 00 00       	call   1238 <memdev_close+0xe9>
    1238:	eb 1a                	jmp    1254 <memdev_close+0x105>
				else
						h_free(memdev_data->heap, n);
    123a:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1241 <memdev_close+0xf2>
    1241:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    1245:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1249:	48 89 d6             	mov    rsi,rdx
    124c:	48 89 c7             	mov    rdi,rax
    124f:	e8 00 00 00 00       	call   1254 <memdev_close+0x105>
				ino_release(in);
    1254:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1258:	48 89 c7             	mov    rdi,rax
    125b:	e8 00 00 00 00       	call   1260 <memdev_close+0x111>
		}
		return 0;
    1260:	b8 00 00 00 00       	mov    eax,0x0
}
    1265:	c9                   	leave
    1266:	c3                   	ret

0000000000001267 <memdev_lseek>:

off_t memdev_lseek(struct inode* in, int fd, off_t offset, int ref)
{
    1267:	55                   	push   rbp
    1268:	48 89 e5             	mov    rbp,rsp
    126b:	48 83 ec 28          	sub    rsp,0x28
    126f:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    1273:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
    1276:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
    127a:	89 4d e0             	mov    DWORD PTR [rbp-0x20],ecx
		struct fil_fd* f;
		if (!in || in->in_stat.st_dev != memdev_data->id) {
    127d:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    1282:	74 16                	je     129a <memdev_lseek+0x33>
    1284:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1288:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    128b:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1292 <memdev_lseek+0x2b>
    1292:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1295:	48 39 c2             	cmp    rdx,rax
    1298:	74 16                	je     12b0 <memdev_lseek+0x49>
				errno = EINVAL;
    129a:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # 12a4 <memdev_lseek+0x3d>
				return -1;
    12a4:	48 c7 c0 ff ff ff ff 	mov    rax,0xffffffffffffffff
    12ab:	e9 95 00 00 00       	jmp    1345 <memdev_lseek+0xde>
		}
		if (!(f = fil_fd_get(fd))) {
    12b0:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    12b3:	89 c7                	mov    edi,eax
    12b5:	e8 00 00 00 00       	call   12ba <memdev_lseek+0x53>
    12ba:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    12be:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    12c3:	75 13                	jne    12d8 <memdev_lseek+0x71>
				errno = EBADF;
    12c5:	c7 05 00 00 00 00 09 00 00 00 	mov    DWORD PTR [rip+0x0],0x9        # 12cf <memdev_lseek+0x68>
				return -1;
    12cf:	48 c7 c0 ff ff ff ff 	mov    rax,0xffffffffffffffff
    12d6:	eb 6d                	jmp    1345 <memdev_lseek+0xde>
		}
		/* not thread-safe as sharing FDs is not thread-safe */
		if (ref == SEEK_SET)
    12d8:	83 7d e0 00          	cmp    DWORD PTR [rbp-0x20],0x0
    12dc:	75 0e                	jne    12ec <memdev_lseek+0x85>
				f->seek_offset = offset;
    12de:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    12e2:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    12e6:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
    12ea:	eb 51                	jmp    133d <memdev_lseek+0xd6>
		else if (ref == SEEK_CUR)
    12ec:	83 7d e0 01          	cmp    DWORD PTR [rbp-0x20],0x1
    12f0:	75 19                	jne    130b <memdev_lseek+0xa4>
				f->seek_offset += offset;
    12f2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    12f6:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    12fa:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    12fe:	48 01 c2             	add    rdx,rax
    1301:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1305:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
    1309:	eb 32                	jmp    133d <memdev_lseek+0xd6>
		else if (ref == SEEK_END) {
    130b:	83 7d e0 02          	cmp    DWORD PTR [rbp-0x20],0x2
    130f:	75 19                	jne    132a <memdev_lseek+0xc3>
				f->seek_offset = in->in_stat.st_size + offset;
    1311:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1315:	48 8b 50 30          	mov    rdx,QWORD PTR [rax+0x30]
    1319:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    131d:	48 01 c2             	add    rdx,rax
    1320:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1324:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
    1328:	eb 13                	jmp    133d <memdev_lseek+0xd6>
		} else {
				errno = EINVAL;
    132a:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # 1334 <memdev_lseek+0xcd>
				return -1;
    1334:	48 c7 c0 ff ff ff ff 	mov    rax,0xffffffffffffffff
    133b:	eb 08                	jmp    1345 <memdev_lseek+0xde>
		}
		return f->seek_offset;
    133d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1341:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
}
    1345:	c9                   	leave
    1346:	c3                   	ret

0000000000001347 <memdev_truncate>:

int memdev_truncate(struct inode* in, off_t length)
{
    1347:	55                   	push   rbp
    1348:	48 89 e5             	mov    rbp,rsp
    134b:	48 83 ec 40          	sub    rsp,0x40
    134f:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
    1353:	48 89 75 c0          	mov    QWORD PTR [rbp-0x40],rsi
		struct memdev_node* n; off_t len;
		if (!in || in->in_stat.st_dev != memdev_data->id) {
    1357:	48 83 7d c8 00       	cmp    QWORD PTR [rbp-0x38],0x0
    135c:	74 16                	je     1374 <memdev_truncate+0x2d>
    135e:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1362:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    1365:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 136c <memdev_truncate+0x25>
    136c:	48 8b 00             	mov    rax,QWORD PTR [rax]
    136f:	48 39 c2             	cmp    rdx,rax
    1372:	74 14                	je     1388 <memdev_truncate+0x41>
				errno = EINVAL;
    1374:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # 137e <memdev_truncate+0x37>
				return -1;
    137e:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1383:	e9 5a 02 00 00       	jmp    15e2 <memdev_truncate+0x29b>
		}

		/* only work on regular files (i.e. memory pages) */
		if (!S_ISREG(in->in_stat.st_mode)) {
    1388:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    138c:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    138f:	25 00 f0 00 00       	and    eax,0xf000
    1394:	3d 00 80 00 00       	cmp    eax,0x8000
    1399:	74 14                	je     13af <memdev_truncate+0x68>
				errno = EINVAL;
    139b:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # 13a5 <memdev_truncate+0x5e>
				return -1;
    13a5:	b8 ff ff ff ff       	mov    eax,0xffffffff
    13aa:	e9 33 02 00 00       	jmp    15e2 <memdev_truncate+0x29b>
		}

		/* modify the file */
		write_lock(&in->in_lock);
    13af:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    13b3:	48 05 88 00 00 00    	add    rax,0x88
    13b9:	48 89 c7             	mov    rdi,rax
    13bc:	e8 00 00 00 00       	call   13c1 <memdev_truncate+0x7a>
		n = *(struct memdev_node**)in->in_pddat;
    13c1:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    13c5:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
    13cc:	48 8b 00             	mov    rax,QWORD PTR [rax]
    13cf:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		len = n->size - sizeof(struct memdev_node);
    13d3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    13d7:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    13db:	48 83 e8 20          	sub    rax,0x20
    13df:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		if (len > length) { /* shrink */
    13e3:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    13e7:	48 3b 45 c0          	cmp    rax,QWORD PTR [rbp-0x40]
    13eb:	7e 6f                	jle    145c <memdev_truncate+0x115>
				size_t num_p;
				n->size = length + sizeof(struct memdev_node);
    13ed:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    13f1:	48 8d 50 20          	lea    rdx,[rax+0x20]
    13f5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    13f9:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
				num_p = (n->cap - n->size) / 4096;
    13fd:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1401:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1405:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1409:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    140d:	48 29 c2             	sub    rdx,rax
    1410:	48 89 d0             	mov    rax,rdx
    1413:	48 c1 e8 0c          	shr    rax,0xc
    1417:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
				if (num_p)
    141b:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
    1420:	0f 84 42 01 00 00    	je     1568 <memdev_truncate+0x221>
						mm_free_vmem(&mm_kernel, (char*)n + n->cap - num_p * 4096, num_p);
    1426:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    142a:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    142e:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1432:	48 c1 e0 0c          	shl    rax,0xc
    1436:	48 29 c2             	sub    rdx,rax
    1439:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    143d:	48 8d 0c 02          	lea    rcx,[rdx+rax*1]
    1441:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1445:	48 89 c2             	mov    rdx,rax
    1448:	48 89 ce             	mov    rsi,rcx
    144b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1452:	e8 00 00 00 00       	call   1457 <memdev_truncate+0x110>
    1457:	e9 0c 01 00 00       	jmp    1568 <memdev_truncate+0x221>
		} else if (len < length) { /* grow */
    145c:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1460:	48 3b 45 c0          	cmp    rax,QWORD PTR [rbp-0x40]
    1464:	0f 8d fe 00 00 00    	jge    1568 <memdev_truncate+0x221>
				if ((n->cap - n->size) >= (length - len))
    146a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    146e:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1472:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1476:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    147a:	48 29 c2             	sub    rdx,rax
    147d:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1481:	48 2b 45 f0          	sub    rax,QWORD PTR [rbp-0x10]
    1485:	48 39 c2             	cmp    rdx,rax
    1488:	72 15                	jb     149f <memdev_truncate+0x158>
						n->size = length + sizeof(struct memdev_node);
    148a:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    148e:	48 8d 50 20          	lea    rdx,[rax+0x20]
    1492:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1496:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
    149a:	e9 c9 00 00 00       	jmp    1568 <memdev_truncate+0x221>
				else { /* allocate new pages */
						size_t num_p; void* mem;
						num_p = n->size + (length - len);
    149f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    14a3:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    14a7:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    14ab:	48 2b 45 f0          	sub    rax,QWORD PTR [rbp-0x10]
    14af:	48 01 d0             	add    rax,rdx
    14b2:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
						num_p = num_p / 4096 + ((num_p % 4096) ? 1 : 0);
    14b6:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    14ba:	48 c1 e8 0c          	shr    rax,0xc
    14be:	48 89 c2             	mov    rdx,rax
    14c1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    14c5:	25 ff 0f 00 00       	and    eax,0xfff
    14ca:	48 85 c0             	test   rax,rax
    14cd:	74 07                	je     14d6 <memdev_truncate+0x18f>
    14cf:	b8 01 00 00 00       	mov    eax,0x1
    14d4:	eb 05                	jmp    14db <memdev_truncate+0x194>
    14d6:	b8 00 00 00 00       	mov    eax,0x0
    14db:	48 01 d0             	add    rax,rdx
    14de:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
						mem = mm_extend_vmem(&mm_kernel, n, n->cap / 4096, num_p,
    14e2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    14e6:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    14ea:	48 c1 e8 0c          	shr    rax,0xc
    14ee:	48 89 c6             	mov    rsi,rax
    14f1:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    14f5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    14f9:	41 b8 0c 00 00 00    	mov    r8d,0xc
    14ff:	48 89 d1             	mov    rcx,rdx
    1502:	48 89 f2             	mov    rdx,rsi
    1505:	48 89 c6             	mov    rsi,rax
    1508:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    150f:	e8 00 00 00 00       	call   1514 <memdev_truncate+0x1cd>
    1514:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
										MMGR_MAP_WRITE | MMGR_MAP_KERNEL);
						/* everything above size is still scrubbed -> no bzero */
						if (!mem) {
    1518:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
    151d:	75 26                	jne    1545 <memdev_truncate+0x1fe>
								/* failed to extend */
								errno = EFBIG;
    151f:	c7 05 00 00 00 00 1b 00 00 00 	mov    DWORD PTR [rip+0x0],0x1b        # 1529 <memdev_truncate+0x1e2>
								write_unlock(&in->in_lock);
    1529:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    152d:	48 05 88 00 00 00    	add    rax,0x88
    1533:	48 89 c7             	mov    rdi,rax
    1536:	e8 00 00 00 00       	call   153b <memdev_truncate+0x1f4>
								return -1;
    153b:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1540:	e9 9d 00 00 00       	jmp    15e2 <memdev_truncate+0x29b>
						}
						n->cap = num_p * 4096;
    1545:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1549:	48 c1 e0 0c          	shl    rax,0xc
    154d:	48 89 c2             	mov    rdx,rax
    1550:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1554:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
						n->size = length + sizeof(struct memdev_node);
    1558:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    155c:	48 8d 50 20          	lea    rdx,[rax+0x20]
    1560:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1564:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
				}
		} else { } /* do nothing */

		/* clear SUID,SGID */
		in->in_stat.st_mode &= (~(mode_t)S_ISUID) & (~(mode_t)S_ISGID);
    1568:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    156c:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    156f:	80 e4 f3             	and    ah,0xf3
    1572:	89 c2                	mov    edx,eax
    1574:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1578:	89 50 10             	mov    DWORD PTR [rax+0x10],edx
		in->in_stat.st_size = length;
    157b:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    157f:	48 8b 55 c0          	mov    rdx,QWORD PTR [rbp-0x40]
    1583:	48 89 50 30          	mov    QWORD PTR [rax+0x30],rdx
		in->in_stat.st_blocks = n->cap / 512;
    1587:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    158b:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    158f:	48 c1 e8 09          	shr    rax,0x9
    1593:	48 89 c2             	mov    rdx,rax
    1596:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    159a:	48 89 50 40          	mov    QWORD PTR [rax+0x40],rdx
		/* always update c&mtim (as in ftruncate) */
		clock_gettime(CLOCK_REALTIME, &in->in_stat.st_mtim);
    159e:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    15a2:	48 83 c0 58          	add    rax,0x58
    15a6:	48 89 c6             	mov    rsi,rax
    15a9:	bf 00 00 00 00       	mov    edi,0x0
    15ae:	e8 00 00 00 00       	call   15b3 <memdev_truncate+0x26c>
		in->in_stat.st_ctim = in->in_stat.st_mtim;
    15b3:	48 8b 4d c8          	mov    rcx,QWORD PTR [rbp-0x38]
    15b7:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    15bb:	48 8b 50 60          	mov    rdx,QWORD PTR [rax+0x60]
    15bf:	48 8b 40 58          	mov    rax,QWORD PTR [rax+0x58]
    15c3:	48 89 41 68          	mov    QWORD PTR [rcx+0x68],rax
    15c7:	48 89 51 70          	mov    QWORD PTR [rcx+0x70],rdx
		write_unlock(&in->in_lock);
    15cb:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    15cf:	48 05 88 00 00 00    	add    rax,0x88
    15d5:	48 89 c7             	mov    rdi,rax
    15d8:	e8 00 00 00 00       	call   15dd <memdev_truncate+0x296>
		return 0;
    15dd:	b8 00 00 00 00       	mov    eax,0x0
}
    15e2:	c9                   	leave
    15e3:	c3                   	ret

00000000000015e4 <memdev_search_fn>:

char* memdev_search_fn(struct memdev_node* n, const char* fn)
{
    15e4:	55                   	push   rbp
    15e5:	48 89 e5             	mov    rbp,rsp
    15e8:	48 83 ec 20          	sub    rsp,0x20
    15ec:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    15f0:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
		char *str, *end;
		str = n->data;
    15f4:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    15f8:	48 83 c0 20          	add    rax,0x20
    15fc:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		end = (char*)n + n->size;
    1600:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1604:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    1608:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    160c:	48 01 d0             	add    rax,rdx
    160f:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		while (str < end) {
    1613:	eb 31                	jmp    1646 <memdev_search_fn+0x62>
				if (strcmp(str, fn) == 0) {
    1615:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    1619:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    161d:	48 89 d6             	mov    rsi,rdx
    1620:	48 89 c7             	mov    rdi,rax
    1623:	e8 00 00 00 00       	call   1628 <memdev_search_fn+0x44>
    1628:	85 c0                	test   eax,eax
    162a:	75 06                	jne    1632 <memdev_search_fn+0x4e>
						return str;
    162c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1630:	eb 23                	jmp    1655 <memdev_search_fn+0x71>
				}
				str += strlen(str) + sizeof(void*) + 1;
    1632:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1636:	48 89 c7             	mov    rdi,rax
    1639:	e8 00 00 00 00       	call   163e <memdev_search_fn+0x5a>
    163e:	48 83 c0 09          	add    rax,0x9
    1642:	48 01 45 f8          	add    QWORD PTR [rbp-0x8],rax
		while (str < end) {
    1646:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    164a:	48 3b 45 f0          	cmp    rax,QWORD PTR [rbp-0x10]
    164e:	72 c5                	jb     1615 <memdev_search_fn+0x31>
		}
		return NULL;
    1650:	b8 00 00 00 00       	mov    eax,0x0
}
    1655:	c9                   	leave
    1656:	c3                   	ret

0000000000001657 <memdev_get_subnode>:

struct inode* memdev_get_subnode(struct inode* in, const char* fn)
{
    1657:	55                   	push   rbp
    1658:	48 89 e5             	mov    rbp,rsp
    165b:	48 83 ec 40          	sub    rsp,0x40
    165f:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
    1663:	48 89 75 c0          	mov    QWORD PTR [rbp-0x40],rsi
		struct inode* rv = NULL;
    1667:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		if (!fn || (!in && strlen(fn) > 0)) {
    166f:	48 83 7d c0 00       	cmp    QWORD PTR [rbp-0x40],0x0
    1674:	74 18                	je     168e <memdev_get_subnode+0x37>
    1676:	48 83 7d c8 00       	cmp    QWORD PTR [rbp-0x38],0x0
    167b:	75 25                	jne    16a2 <memdev_get_subnode+0x4b>
    167d:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1681:	48 89 c7             	mov    rdi,rax
    1684:	e8 00 00 00 00       	call   1689 <memdev_get_subnode+0x32>
    1689:	48 85 c0             	test   rax,rax
    168c:	74 14                	je     16a2 <memdev_get_subnode+0x4b>
				errno = EINVAL;
    168e:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # 1698 <memdev_get_subnode+0x41>
				return NULL;
    1698:	b8 00 00 00 00       	mov    eax,0x0
    169d:	e9 44 02 00 00       	jmp    18e6 <memdev_get_subnode+0x28f>
		}

		if (in) {
    16a2:	48 83 7d c8 00       	cmp    QWORD PTR [rbp-0x38],0x0
    16a7:	0f 84 d4 00 00 00    	je     1781 <memdev_get_subnode+0x12a>
				struct memdev_node* n; char *str;
				/* we don't handle links here. The OS should only ask
				 * for files we actually have stored on this device */
				if (in->in_stat.st_dev != 0) {
    16ad:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    16b1:	48 8b 00             	mov    rax,QWORD PTR [rax]
    16b4:	48 85 c0             	test   rax,rax
    16b7:	74 14                	je     16cd <memdev_get_subnode+0x76>
						errno = EINVAL;
    16b9:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # 16c3 <memdev_get_subnode+0x6c>
						return NULL;
    16c3:	b8 00 00 00 00       	mov    eax,0x0
    16c8:	e9 19 02 00 00       	jmp    18e6 <memdev_get_subnode+0x28f>
				}
				/* check for directory */
				if (!S_ISDIR(in->in_stat.st_mode)) {
    16cd:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    16d1:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    16d4:	25 00 f0 00 00       	and    eax,0xf000
    16d9:	3d 00 40 00 00       	cmp    eax,0x4000
    16de:	74 14                	je     16f4 <memdev_get_subnode+0x9d>
						errno = ENOTDIR;
    16e0:	c7 05 00 00 00 00 14 00 00 00 	mov    DWORD PTR [rip+0x0],0x14        # 16ea <memdev_get_subnode+0x93>
						return NULL;
    16ea:	b8 00 00 00 00       	mov    eax,0x0
    16ef:	e9 f2 01 00 00       	jmp    18e6 <memdev_get_subnode+0x28f>
				}

				/* now search for fn with read lock */
				n = *(struct memdev_node**)in->in_pddat;
    16f4:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    16f8:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
    16ff:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1702:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
				read_lock(&in->in_lock);
    1706:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    170a:	48 05 88 00 00 00    	add    rax,0x88
    1710:	48 89 c7             	mov    rdi,rax
    1713:	e8 00 00 00 00       	call   1718 <memdev_get_subnode+0xc1>
				str = memdev_search_fn(n, fn);
    1718:	48 8b 55 c0          	mov    rdx,QWORD PTR [rbp-0x40]
    171c:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1720:	48 89 d6             	mov    rsi,rdx
    1723:	48 89 c7             	mov    rdi,rax
    1726:	e8 00 00 00 00       	call   172b <memdev_get_subnode+0xd4>
    172b:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
				if (str) {
    172f:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
    1734:	74 1f                	je     1755 <memdev_get_subnode+0xfe>
						str += strlen(str) + 1;
    1736:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    173a:	48 89 c7             	mov    rdi,rax
    173d:	e8 00 00 00 00       	call   1742 <memdev_get_subnode+0xeb>
    1742:	48 83 c0 01          	add    rax,0x1
    1746:	48 01 45 d8          	add    QWORD PTR [rbp-0x28],rax
						rv = *(void**)str;
    174a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    174e:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1751:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				}
				/* update access time <- NO only if opening the dir */
				/*clock_gettime(CLOCK_REALTIME, &in->in_stat.st_atim);*/
				read_unlock(&in->in_lock);
    1755:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1759:	48 05 88 00 00 00    	add    rax,0x88
    175f:	48 89 c7             	mov    rdi,rax
    1762:	e8 00 00 00 00       	call   1767 <memdev_get_subnode+0x110>
				if (!rv)
    1767:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    176c:	75 0a                	jne    1778 <memdev_get_subnode+0x121>
						errno = ENOENT;
    176e:	c7 05 00 00 00 00 02 00 00 00 	mov    DWORD PTR [rip+0x0],0x2        # 1778 <memdev_get_subnode+0x121>
				return rv;
    1778:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    177c:	e9 65 01 00 00       	jmp    18e6 <memdev_get_subnode+0x28f>
		}

		/* return root node */
		if (memdev_data->node_ct == 0) {
    1781:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1788 <memdev_get_subnode+0x131>
    1788:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    178c:	48 85 c0             	test   rax,rax
    178f:	0f 85 3f 01 00 00    	jne    18d4 <memdev_get_subnode+0x27d>
				/* create root directory first */
				void* mem = h_malloc(memdev_data->heap, 128 + sizeof(struct memdev_node));
    1795:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 179c <memdev_get_subnode+0x145>
    179c:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    17a0:	be a0 00 00 00       	mov    esi,0xa0
    17a5:	48 89 c7             	mov    rdi,rax
    17a8:	e8 00 00 00 00       	call   17ad <memdev_get_subnode+0x156>
    17ad:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				struct memdev_node* n = (struct memdev_node*)mem;
    17b1:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    17b5:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				if (!mem)
    17b9:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
    17be:	75 0a                	jne    17ca <memdev_get_subnode+0x173>
						return NULL;
    17c0:	b8 00 00 00 00       	mov    eax,0x0
    17c5:	e9 1c 01 00 00       	jmp    18e6 <memdev_get_subnode+0x28f>
				n->cap = 128 + sizeof(struct memdev_node);
    17ca:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    17ce:	48 c7 40 10 a0 00 00 00 	mov    QWORD PTR [rax+0x10],0xa0
				n->size = sizeof(struct memdev_node);
    17d6:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    17da:	48 c7 40 08 20 00 00 00 	mov    QWORD PTR [rax+0x8],0x20
				n->file = S_IFDIR;
    17e2:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    17e6:	c7 00 00 40 00 00    	mov    DWORD PTR [rax],0x4000
				rv = n->ino = ino_allocate(S_IFDIR);
    17ec:	bf 00 40 00 00       	mov    edi,0x4000
    17f1:	e8 00 00 00 00       	call   17f6 <memdev_get_subnode+0x19f>
    17f6:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    17fa:	48 89 42 18          	mov    QWORD PTR [rdx+0x18],rax
    17fe:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1802:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    1806:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				if (!rv) {
    180a:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    180f:	75 24                	jne    1835 <memdev_get_subnode+0x1de>
						h_free(memdev_data->heap, mem);
    1811:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1818 <memdev_get_subnode+0x1c1>
    1818:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    181c:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1820:	48 89 d6             	mov    rsi,rdx
    1823:	48 89 c7             	mov    rdi,rax
    1826:	e8 00 00 00 00       	call   182b <memdev_get_subnode+0x1d4>
						return NULL;
    182b:	b8 00 00 00 00       	mov    eax,0x0
    1830:	e9 b1 00 00 00       	jmp    18e6 <memdev_get_subnode+0x28f>
				}
				rv->in_stat.st_dev = memdev_data->id;
    1835:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 183c <memdev_get_subnode+0x1e5>
    183c:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    183f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1843:	48 89 10             	mov    QWORD PTR [rax],rdx
				rv->in_stat.st_blksize = 4096; /* 4096/512 */
    1846:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    184a:	48 c7 40 38 00 10 00 00 	mov    QWORD PTR [rax+0x38],0x1000
				rv->in_stat.st_blocks = 8;
    1852:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1856:	48 c7 40 40 08 00 00 00 	mov    QWORD PTR [rax+0x40],0x8
				rv->in_stat.st_size = 0; /* actual size */
    185e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1862:	48 c7 40 30 00 00 00 00 	mov    QWORD PTR [rax+0x30],0x0
				rv->in_pddat = memdev_store_node(n);
    186a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    186e:	48 89 c7             	mov    rdi,rax
    1871:	e8 00 00 00 00       	call   1876 <memdev_get_subnode+0x21f>
    1876:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    187a:	48 89 82 80 00 00 00 	mov    QWORD PTR [rdx+0x80],rax
				if (!rv->in_pddat) {
    1881:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1885:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
    188c:	48 85 c0             	test   rax,rax
    188f:	75 31                	jne    18c2 <memdev_get_subnode+0x26b>
						ino_release(n->ino);
    1891:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1895:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    1899:	48 89 c7             	mov    rdi,rax
    189c:	e8 00 00 00 00       	call   18a1 <memdev_get_subnode+0x24a>
						h_free(memdev_data->heap, mem);
    18a1:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 18a8 <memdev_get_subnode+0x251>
    18a8:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    18ac:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    18b0:	48 89 d6             	mov    rsi,rdx
    18b3:	48 89 c7             	mov    rdi,rax
    18b6:	e8 00 00 00 00       	call   18bb <memdev_get_subnode+0x264>
						return NULL;
    18bb:	b8 00 00 00 00       	mov    eax,0x0
    18c0:	eb 24                	jmp    18e6 <memdev_get_subnode+0x28f>
				}
				rv->in_stat.st_nlink = 1; /* NEVER free / on close() */
    18c2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    18c6:	48 c7 40 18 01 00 00 00 	mov    QWORD PTR [rax+0x18],0x1
				return rv;
    18ce:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    18d2:	eb 12                	jmp    18e6 <memdev_get_subnode+0x28f>
		} else
				return memdev_data->nodes[0]->ino;
    18d4:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 18db <memdev_get_subnode+0x284>
    18db:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    18df:	48 8b 00             	mov    rax,QWORD PTR [rax]
    18e2:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
}
    18e6:	c9                   	leave
    18e7:	c3                   	ret

00000000000018e8 <memdev_unlink>:

int memdev_unlink(struct inode* in0, struct inode* in1)
{
    18e8:	55                   	push   rbp
    18e9:	48 89 e5             	mov    rbp,rsp
    18ec:	48 83 ec 50          	sub    rsp,0x50
    18f0:	48 89 7d b8          	mov    QWORD PTR [rbp-0x48],rdi
    18f4:	48 89 75 b0          	mov    QWORD PTR [rbp-0x50],rsi
		struct timespec t;
		if (!in1 || (in0 && in0->in_stat.st_dev != memdev_data->id)) {
    18f8:	48 83 7d b0 00       	cmp    QWORD PTR [rbp-0x50],0x0
    18fd:	74 1d                	je     191c <memdev_unlink+0x34>
    18ff:	48 83 7d b8 00       	cmp    QWORD PTR [rbp-0x48],0x0
    1904:	74 2a                	je     1930 <memdev_unlink+0x48>
    1906:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    190a:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    190d:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1914 <memdev_unlink+0x2c>
    1914:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1917:	48 39 c2             	cmp    rdx,rax
    191a:	74 14                	je     1930 <memdev_unlink+0x48>
				errno = EINVAL;
    191c:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # 1926 <memdev_unlink+0x3e>
				return -1;
    1926:	b8 ff ff ff ff       	mov    eax,0xffffffff
    192b:	e9 ce 03 00 00       	jmp    1cfe <memdev_unlink+0x416>
		}

		if (in0) { /* remove link from source dir(!)  */
    1930:	48 83 7d b8 00       	cmp    QWORD PTR [rbp-0x48],0x0
    1935:	0f 84 f1 01 00 00    	je     1b2c <memdev_unlink+0x244>
				struct memdev_node* n; char* fn;
				if (!(in0->in_stat.st_mode & S_IFDIR)) {
    193b:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    193f:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1942:	25 00 40 00 00       	and    eax,0x4000
    1947:	85 c0                	test   eax,eax
    1949:	75 14                	jne    195f <memdev_unlink+0x77>
						errno = ENOTDIR;
    194b:	c7 05 00 00 00 00 14 00 00 00 	mov    DWORD PTR [rip+0x0],0x14        # 1955 <memdev_unlink+0x6d>
						return -1;
    1955:	b8 ff ff ff ff       	mov    eax,0xffffffff
    195a:	e9 9f 03 00 00       	jmp    1cfe <memdev_unlink+0x416>
				}

				n = *(struct memdev_node**)in0->in_pddat;
    195f:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1963:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
    196a:	48 8b 00             	mov    rax,QWORD PTR [rax]
    196d:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				/* now modify the directory */
				write_lock(&in0->in_lock);
    1971:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1975:	48 05 88 00 00 00    	add    rax,0x88
    197b:	48 89 c7             	mov    rdi,rax
    197e:	e8 00 00 00 00       	call   1983 <memdev_unlink+0x9b>
				fn = n->data;
    1983:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1987:	48 83 c0 20          	add    rax,0x20
    198b:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				while (fn < (char*)n + n->size) {
    198f:	e9 52 01 00 00       	jmp    1ae6 <memdev_unlink+0x1fe>
						char* fn2 = fn + strlen(fn) + 1;
    1994:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1998:	48 89 c7             	mov    rdi,rax
    199b:	e8 00 00 00 00       	call   19a0 <memdev_unlink+0xb8>
    19a0:	48 8d 50 01          	lea    rdx,[rax+0x1]
    19a4:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    19a8:	48 01 d0             	add    rax,rdx
    19ab:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
						if (*(struct inode**)fn2 == in1) {
    19af:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    19b3:	48 8b 00             	mov    rax,QWORD PTR [rax]
    19b6:	48 39 45 b0          	cmp    QWORD PTR [rbp-0x50],rax
    19ba:	0f 85 1a 01 00 00    	jne    1ada <memdev_unlink+0x1f2>
								/* found the entry */
								fn2 += sizeof(struct inode*);
    19c0:	48 83 45 e8 08       	add    QWORD PTR [rbp-0x18],0x8
								memmove(fn, fn2, (char*)n + n->size - fn2);
    19c5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    19c9:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    19cd:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    19d1:	48 01 d0             	add    rax,rdx
    19d4:	48 2b 45 e8          	sub    rax,QWORD PTR [rbp-0x18]
    19d8:	48 89 c2             	mov    rdx,rax
    19db:	48 8b 4d e8          	mov    rcx,QWORD PTR [rbp-0x18]
    19df:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    19e3:	48 89 ce             	mov    rsi,rcx
    19e6:	48 89 c7             	mov    rdi,rax
    19e9:	e8 00 00 00 00       	call   19ee <memdev_unlink+0x106>
								n->size -= fn2 - fn;
    19ee:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    19f2:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    19f6:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    19fa:	48 2b 45 f0          	sub    rax,QWORD PTR [rbp-0x10]
    19fe:	48 29 c2             	sub    rdx,rax
    1a01:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1a05:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
								if (n->size > 128 + sizeof(struct memdev_node)) {
    1a09:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1a0d:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1a11:	48 3d a0 00 00 00    	cmp    rax,0xa0
    1a17:	76 65                	jbe    1a7e <memdev_unlink+0x196>
										/* shrink a bit */
										if (n->cap - n->size > 64) {
    1a19:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1a1d:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1a21:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1a25:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1a29:	48 29 c2             	sub    rdx,rax
    1a2c:	48 83 fa 40          	cmp    rdx,0x40
    1a30:	76 4c                	jbe    1a7e <memdev_unlink+0x196>
												n->cap = n->size + 64;
    1a32:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1a36:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1a3a:	48 8d 50 40          	lea    rdx,[rax+0x40]
    1a3e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1a42:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
												*(struct memdev_node**)in0->in_pddat
													   	= n = h_realloc(memdev_data->heap,
    1a46:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1a4a:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1a4e:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1a55 <memdev_unlink+0x16d>
    1a55:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    1a59:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    1a5d:	48 89 ce             	mov    rsi,rcx
    1a60:	48 89 c7             	mov    rdi,rax
    1a63:	e8 00 00 00 00       	call   1a68 <memdev_unlink+0x180>
    1a68:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
												*(struct memdev_node**)in0->in_pddat
    1a6c:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1a70:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
													   	= n = h_realloc(memdev_data->heap,
    1a77:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    1a7b:	48 89 10             	mov    QWORD PTR [rax],rdx
																		n, n->cap);
												/* will never happen as shrink works in-place */
										}
								}
								n = NULL; /* signify found */
    1a7e:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
								in0->in_stat.st_size = n->size - sizeof(struct memdev_node);
    1a86:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1a8a:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1a8e:	48 83 e8 20          	sub    rax,0x20
    1a92:	48 89 c2             	mov    rdx,rax
    1a95:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1a99:	48 89 50 30          	mov    QWORD PTR [rax+0x30],rdx
								in0->in_stat.st_blocks = n->cap / 512 + (n->cap % 512 ? 1 : 0);
    1a9d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1aa1:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    1aa5:	48 c1 e8 09          	shr    rax,0x9
    1aa9:	48 89 c2             	mov    rdx,rax
    1aac:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1ab0:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    1ab4:	25 ff 01 00 00       	and    eax,0x1ff
    1ab9:	48 85 c0             	test   rax,rax
    1abc:	74 07                	je     1ac5 <memdev_unlink+0x1dd>
    1abe:	b8 01 00 00 00       	mov    eax,0x1
    1ac3:	eb 05                	jmp    1aca <memdev_unlink+0x1e2>
    1ac5:	b8 00 00 00 00       	mov    eax,0x0
    1aca:	48 01 d0             	add    rax,rdx
    1acd:	48 89 c2             	mov    rdx,rax
    1ad0:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1ad4:	48 89 50 40          	mov    QWORD PTR [rax+0x40],rdx
								break;
    1ad8:	eb 25                	jmp    1aff <memdev_unlink+0x217>
						} else
								fn = fn2 + sizeof(struct inode*);
    1ada:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1ade:	48 83 c0 08          	add    rax,0x8
    1ae2:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				while (fn < (char*)n + n->size) {
    1ae6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1aea:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    1aee:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1af2:	48 01 d0             	add    rax,rdx
    1af5:	48 39 45 f0          	cmp    QWORD PTR [rbp-0x10],rax
    1af9:	0f 82 95 fe ff ff    	jb     1994 <memdev_unlink+0xac>
				}
				write_unlock(&in0->in_lock);
    1aff:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1b03:	48 05 88 00 00 00    	add    rax,0x88
    1b09:	48 89 c7             	mov    rdi,rax
    1b0c:	e8 00 00 00 00       	call   1b11 <memdev_unlink+0x229>
				if (!n) {
    1b11:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    1b16:	75 14                	jne    1b2c <memdev_unlink+0x244>
						errno = ENOENT;
    1b18:	c7 05 00 00 00 00 02 00 00 00 	mov    DWORD PTR [rip+0x0],0x2        # 1b22 <memdev_unlink+0x23a>
						return -1;
    1b22:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1b27:	e9 d2 01 00 00       	jmp    1cfe <memdev_unlink+0x416>
				}
		}

		/* get current time */
		clock_gettime(CLOCK_REALTIME, &t);
    1b2c:	48 8d 45 c8          	lea    rax,[rbp-0x38]
    1b30:	48 89 c6             	mov    rsi,rax
    1b33:	bf 00 00 00 00       	mov    edi,0x0
    1b38:	e8 00 00 00 00       	call   1b3d <memdev_unlink+0x255>
		if (in0)
    1b3d:	48 83 7d b8 00       	cmp    QWORD PTR [rbp-0x48],0x0
    1b42:	74 2c                	je     1b70 <memdev_unlink+0x288>
				in0->in_stat.st_mtim = in0->in_stat.st_ctim = t;
    1b44:	48 8b 4d b8          	mov    rcx,QWORD PTR [rbp-0x48]
    1b48:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1b4c:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    1b50:	48 89 41 68          	mov    QWORD PTR [rcx+0x68],rax
    1b54:	48 89 51 70          	mov    QWORD PTR [rcx+0x70],rdx
    1b58:	48 8b 4d b8          	mov    rcx,QWORD PTR [rbp-0x48]
    1b5c:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1b60:	48 8b 50 70          	mov    rdx,QWORD PTR [rax+0x70]
    1b64:	48 8b 40 68          	mov    rax,QWORD PTR [rax+0x68]
    1b68:	48 89 41 58          	mov    QWORD PTR [rcx+0x58],rax
    1b6c:	48 89 51 60          	mov    QWORD PTR [rcx+0x60],rdx

		/* now unlink the node */
		if (in1->in_stat.st_dev != memdev_data->id) {
    1b70:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1b74:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    1b77:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1b7e <memdev_unlink+0x296>
    1b7e:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1b81:	48 39 c2             	cmp    rdx,rax
    1b84:	0f 84 9a 00 00 00    	je     1c24 <memdev_unlink+0x33c>
				const struct device_desc* dd = get_device(in1->in_stat.st_dev);
    1b8a:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1b8e:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1b91:	48 89 c7             	mov    rdi,rax
    1b94:	e8 00 00 00 00       	call   1b99 <memdev_unlink+0x2b1>
    1b99:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
				if (!dd) {
    1b9d:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
    1ba2:	75 65                	jne    1c09 <memdev_unlink+0x321>
						cprintf(KFMT_WARN, "unable to locate device %u"
										" for unlinking inode at %p\n",
										(uint32_t)in1->in_stat.st_dev, in1);
    1ba4:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1ba8:	48 8b 00             	mov    rax,QWORD PTR [rax]
						cprintf(KFMT_WARN, "unable to locate device %u"
    1bab:	89 c2                	mov    edx,eax
    1bad:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1bb1:	48 89 c1             	mov    rcx,rax
    1bb4:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1bbb:	bf 0e 00 00 00       	mov    edi,0xe
    1bc0:	b8 00 00 00 00       	mov    eax,0x0
    1bc5:	e8 00 00 00 00       	call   1bca <memdev_unlink+0x2e2>
						if (__sync_sub_and_fetch(&in1->in_stat.st_dev, 1) == 0)
    1bca:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
    1bce:	b8 01 00 00 00       	mov    eax,0x1
    1bd3:	48 f7 d8             	neg    rax
    1bd6:	48 89 c1             	mov    rcx,rax
    1bd9:	48 89 c8             	mov    rax,rcx
    1bdc:	f0 48 0f c1 02       	lock xadd QWORD PTR [rdx],rax
    1be1:	48 01 c8             	add    rax,rcx
    1be4:	48 85 c0             	test   rax,rax
    1be7:	75 0c                	jne    1bf5 <memdev_unlink+0x30d>
								ino_release(in1); /* clean up partially */
    1be9:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1bed:	48 89 c7             	mov    rdi,rax
    1bf0:	e8 00 00 00 00       	call   1bf5 <memdev_unlink+0x30d>
						errno = ENODEV;
    1bf5:	c7 05 00 00 00 00 13 00 00 00 	mov    DWORD PTR [rip+0x0],0x13        # 1bff <memdev_unlink+0x317>
						return 0; /* only warn */
    1bff:	b8 00 00 00 00       	mov    eax,0x0
    1c04:	e9 f5 00 00 00       	jmp    1cfe <memdev_unlink+0x416>
				} else {
						return dd->fn_unlink(NULL, in1);
    1c09:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1c0d:	48 8b 50 58          	mov    rdx,QWORD PTR [rax+0x58]
    1c11:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1c15:	48 89 c6             	mov    rsi,rax
    1c18:	bf 00 00 00 00       	mov    edi,0x0
    1c1d:	ff d2                	call   rdx
    1c1f:	e9 da 00 00 00       	jmp    1cfe <memdev_unlink+0x416>
				}
		} else {
				if ((__sync_sub_and_fetch(&in1->in_stat.st_nlink, 1) == 0) &&
    1c24:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1c28:	48 8d 50 18          	lea    rdx,[rax+0x18]
    1c2c:	b8 01 00 00 00       	mov    eax,0x1
    1c31:	48 f7 d8             	neg    rax
    1c34:	48 89 c1             	mov    rcx,rax
    1c37:	48 89 c8             	mov    rax,rcx
    1c3a:	f0 48 0f c1 02       	lock xadd QWORD PTR [rdx],rax
    1c3f:	48 01 c8             	add    rax,rcx
    1c42:	48 85 c0             	test   rax,rax
    1c45:	0f 85 9a 00 00 00    	jne    1ce5 <memdev_unlink+0x3fd>
					(*(int*)in1->in_ddat == 0)) {
    1c4b:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1c4f:	48 83 c0 78          	add    rax,0x78
    1c53:	8b 00                	mov    eax,DWORD PTR [rax]
				if ((__sync_sub_and_fetch(&in1->in_stat.st_nlink, 1) == 0) &&
    1c55:	85 c0                	test   eax,eax
    1c57:	0f 85 88 00 00 00    	jne    1ce5 <memdev_unlink+0x3fd>
						struct memdev_node* n;
						/* this was the last link & no open FDs so remove the node */
						n = *(struct memdev_node**)in1->in_pddat;
    1c5d:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1c61:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
    1c68:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1c6b:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
						*(struct memdev_node**)in1->in_pddat = NULL; /* free slot */
    1c6f:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1c73:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
    1c7a:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
						if (S_ISREG(in1->in_stat.st_mode))
    1c81:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1c85:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1c88:	25 00 f0 00 00       	and    eax,0xf000
    1c8d:	3d 00 80 00 00       	cmp    eax,0x8000
    1c92:	75 24                	jne    1cb8 <memdev_unlink+0x3d0>
								mm_free_vmem(&mm_kernel, n, n->cap / 4096);
    1c94:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1c98:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    1c9c:	48 c1 e8 0c          	shr    rax,0xc
    1ca0:	48 89 c2             	mov    rdx,rax
    1ca3:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1ca7:	48 89 c6             	mov    rsi,rax
    1caa:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1cb1:	e8 00 00 00 00       	call   1cb6 <memdev_unlink+0x3ce>
    1cb6:	eb 1a                	jmp    1cd2 <memdev_unlink+0x3ea>
						else
								h_free(memdev_data->heap, n);
    1cb8:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1cbf <memdev_unlink+0x3d7>
    1cbf:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    1cc3:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    1cc7:	48 89 d6             	mov    rsi,rdx
    1cca:	48 89 c7             	mov    rdi,rax
    1ccd:	e8 00 00 00 00       	call   1cd2 <memdev_unlink+0x3ea>
						ino_release(in1);
    1cd2:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1cd6:	48 89 c7             	mov    rdi,rax
    1cd9:	e8 00 00 00 00       	call   1cde <memdev_unlink+0x3f6>
						return 0;
    1cde:	b8 00 00 00 00       	mov    eax,0x0
    1ce3:	eb 19                	jmp    1cfe <memdev_unlink+0x416>
				}
				in1->in_stat.st_ctim = t;
    1ce5:	48 8b 4d b0          	mov    rcx,QWORD PTR [rbp-0x50]
    1ce9:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1ced:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    1cf1:	48 89 41 68          	mov    QWORD PTR [rcx+0x68],rax
    1cf5:	48 89 51 70          	mov    QWORD PTR [rcx+0x70],rdx
				return 0;
    1cf9:	b8 00 00 00 00       	mov    eax,0x0
		}
}
    1cfe:	c9                   	leave
    1cff:	c3                   	ret

0000000000001d00 <memdev_set_subnode>:

int memdev_set_subnode(struct inode* in0, struct inode* in1, const char* fn)
{
    1d00:	55                   	push   rbp
    1d01:	48 89 e5             	mov    rbp,rsp
    1d04:	53                   	push   rbx
    1d05:	48 83 ec 78          	sub    rsp,0x78
    1d09:	48 89 7d 98          	mov    QWORD PTR [rbp-0x68],rdi
    1d0d:	48 89 75 90          	mov    QWORD PTR [rbp-0x70],rsi
    1d11:	48 89 55 88          	mov    QWORD PTR [rbp-0x78],rdx
		struct memdev_node *n0, *n1 = NULL;
    1d15:	48 c7 45 c8 00 00 00 00 	mov    QWORD PTR [rbp-0x38],0x0
		if (!in0 || !fn || in0->in_stat.st_dev != memdev_data->id) {
    1d1d:	48 83 7d 98 00       	cmp    QWORD PTR [rbp-0x68],0x0
    1d22:	74 1d                	je     1d41 <memdev_set_subnode+0x41>
    1d24:	48 83 7d 88 00       	cmp    QWORD PTR [rbp-0x78],0x0
    1d29:	74 16                	je     1d41 <memdev_set_subnode+0x41>
    1d2b:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1d2f:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    1d32:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1d39 <memdev_set_subnode+0x39>
    1d39:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1d3c:	48 39 c2             	cmp    rdx,rax
    1d3f:	74 14                	je     1d55 <memdev_set_subnode+0x55>
				errno = EINVAL;
    1d41:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # 1d4b <memdev_set_subnode+0x4b>
				return -1;
    1d4b:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1d50:	e9 95 06 00 00       	jmp    23ea <memdev_set_subnode+0x6ea>
		}

		/* inode in0 on this device and directory */
		if (!(in0->in_stat.st_mode & S_IFDIR)) {
    1d55:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1d59:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1d5c:	25 00 40 00 00       	and    eax,0x4000
    1d61:	85 c0                	test   eax,eax
    1d63:	75 14                	jne    1d79 <memdev_set_subnode+0x79>
				errno = ENOTDIR;
    1d65:	c7 05 00 00 00 00 14 00 00 00 	mov    DWORD PTR [rip+0x0],0x14        # 1d6f <memdev_set_subnode+0x6f>
				return -1;
    1d6f:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1d74:	e9 71 06 00 00       	jmp    23ea <memdev_set_subnode+0x6ea>
		}
		n0 = *(struct memdev_node**)in0->in_pddat;
    1d79:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1d7d:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
    1d84:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1d87:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax

		/* create REAL in1 if dummy for creation */
		if (!in1) { /* unlink */
    1d8b:	48 83 7d 90 00       	cmp    QWORD PTR [rbp-0x70],0x0
    1d90:	75 40                	jne    1dd2 <memdev_set_subnode+0xd2>
				/* convenience function */
				in1 = memdev_get_subnode(in0, fn);
    1d92:	48 8b 55 88          	mov    rdx,QWORD PTR [rbp-0x78]
    1d96:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1d9a:	48 89 d6             	mov    rsi,rdx
    1d9d:	48 89 c7             	mov    rdi,rax
    1da0:	e8 00 00 00 00       	call   1da5 <memdev_set_subnode+0xa5>
    1da5:	48 89 45 90          	mov    QWORD PTR [rbp-0x70],rax
				if (!in1)
    1da9:	48 83 7d 90 00       	cmp    QWORD PTR [rbp-0x70],0x0
    1dae:	75 0a                	jne    1dba <memdev_set_subnode+0xba>
						return -1;
    1db0:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1db5:	e9 30 06 00 00       	jmp    23ea <memdev_set_subnode+0x6ea>
				return memdev_unlink(in0, in1);
    1dba:	48 8b 55 90          	mov    rdx,QWORD PTR [rbp-0x70]
    1dbe:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1dc2:	48 89 d6             	mov    rsi,rdx
    1dc5:	48 89 c7             	mov    rdi,rax
    1dc8:	e8 00 00 00 00       	call   1dcd <memdev_set_subnode+0xcd>
    1dcd:	e9 18 06 00 00       	jmp    23ea <memdev_set_subnode+0x6ea>
		} else if (in1->in_stat.st_dev == INVALID_DEVICE) {
    1dd2:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1dd6:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1dd9:	48 83 f8 ff          	cmp    rax,0xffffffffffffffff
    1ddd:	0f 85 c5 02 00 00    	jne    20a8 <memdev_set_subnode+0x3a8>
				void* mem = NULL; size_t s;
    1de3:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
				/* only allow dirs, files and links */
				if (!S_ISDIR(in1->in_stat.st_mode) &&
    1deb:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1def:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1df2:	25 00 f0 00 00       	and    eax,0xf000
    1df7:	3d 00 40 00 00       	cmp    eax,0x4000
    1dfc:	74 3a                	je     1e38 <memdev_set_subnode+0x138>
					!S_ISREG(in1->in_stat.st_mode) &&
    1dfe:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1e02:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1e05:	25 00 f0 00 00       	and    eax,0xf000
				if (!S_ISDIR(in1->in_stat.st_mode) &&
    1e0a:	3d 00 80 00 00       	cmp    eax,0x8000
    1e0f:	74 27                	je     1e38 <memdev_set_subnode+0x138>
					!S_ISLNK(in1->in_stat.st_mode)) {
    1e11:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1e15:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1e18:	25 00 f0 00 00       	and    eax,0xf000
					!S_ISREG(in1->in_stat.st_mode) &&
    1e1d:	3d 00 a0 00 00       	cmp    eax,0xa000
    1e22:	74 14                	je     1e38 <memdev_set_subnode+0x138>
						errno = ENOTSUP;
    1e24:	c7 05 00 00 00 00 5f 00 00 00 	mov    DWORD PTR [rip+0x0],0x5f        # 1e2e <memdev_set_subnode+0x12e>
						return -1;
    1e2e:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1e33:	e9 b2 05 00 00       	jmp    23ea <memdev_set_subnode+0x6ea>
				}
				/* calculate the size of the memory */
				if (in1->in_stat.st_size)
    1e38:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1e3c:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
    1e40:	48 85 c0             	test   rax,rax
    1e43:	74 31                	je     1e76 <memdev_set_subnode+0x176>
						s = in1->in_stat.st_size + sizeof(struct memdev_node)
    1e45:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1e49:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
    1e4d:	48 89 c2             	mov    rdx,rax
								+ (S_ISREG(in1->in_stat.st_mode) ? 0 : 1);
    1e50:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1e54:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1e57:	25 00 f0 00 00       	and    eax,0xf000
    1e5c:	3d 00 80 00 00       	cmp    eax,0x8000
    1e61:	0f 95 c0             	setne  al
    1e64:	0f b6 c0             	movzx  eax,al
    1e67:	48 98                	cdqe
    1e69:	48 01 d0             	add    rax,rdx
						s = in1->in_stat.st_size + sizeof(struct memdev_node)
    1e6c:	48 83 c0 20          	add    rax,0x20
    1e70:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
    1e74:	eb 42                	jmp    1eb8 <memdev_set_subnode+0x1b8>
				else if (S_ISDIR(in1->in_stat.st_mode))
    1e76:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1e7a:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1e7d:	25 00 f0 00 00       	and    eax,0xf000
    1e82:	3d 00 40 00 00       	cmp    eax,0x4000
    1e87:	75 0a                	jne    1e93 <memdev_set_subnode+0x193>
						s = 128 + sizeof(struct memdev_node); /* default dir capacity */
    1e89:	48 c7 45 d8 a0 00 00 00 	mov    QWORD PTR [rbp-0x28],0xa0
    1e91:	eb 25                	jmp    1eb8 <memdev_set_subnode+0x1b8>
				else if (S_ISLNK(in1->in_stat.st_mode))
    1e93:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1e97:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1e9a:	25 00 f0 00 00       	and    eax,0xf000
    1e9f:	3d 00 a0 00 00       	cmp    eax,0xa000
    1ea4:	75 0a                	jne    1eb0 <memdev_set_subnode+0x1b0>
						s = 32 + sizeof(struct memdev_node); /* default link length */
    1ea6:	48 c7 45 d8 40 00 00 00 	mov    QWORD PTR [rbp-0x28],0x40
    1eae:	eb 08                	jmp    1eb8 <memdev_set_subnode+0x1b8>
				else
						s = 4096; /* default file size */
    1eb0:	48 c7 45 d8 00 10 00 00 	mov    QWORD PTR [rbp-0x28],0x1000

				/* get some memory for the memfile */
				if (S_ISREG(in1->in_stat.st_mode)) {
    1eb8:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1ebc:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1ebf:	25 00 f0 00 00       	and    eax,0xf000
    1ec4:	3d 00 80 00 00       	cmp    eax,0x8000
    1ec9:	75 49                	jne    1f14 <memdev_set_subnode+0x214>
						if (s % 4096)
    1ecb:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1ecf:	25 ff 0f 00 00       	and    eax,0xfff
    1ed4:	48 85 c0             	test   rax,rax
    1ed7:	74 14                	je     1eed <memdev_set_subnode+0x1ed>
								s += 4096 - (s % 4096);
    1ed9:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1edd:	48 25 00 f0 ff ff    	and    rax,0xfffffffffffff000
    1ee3:	48 05 00 10 00 00    	add    rax,0x1000
    1ee9:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
						mem = mm_alloc_vmem(&mm_kernel, NULL, s / 4096,
    1eed:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1ef1:	48 c1 e8 0c          	shr    rax,0xc
    1ef5:	b9 0c 00 00 00       	mov    ecx,0xc
    1efa:	48 89 c2             	mov    rdx,rax
    1efd:	be 00 00 00 00       	mov    esi,0x0
    1f02:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1f09:	e8 00 00 00 00       	call   1f0e <memdev_set_subnode+0x20e>
    1f0e:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    1f12:	eb 1e                	jmp    1f32 <memdev_set_subnode+0x232>
										MMGR_MAP_KERNEL | MMGR_MAP_WRITE);
				} else
						mem = h_malloc(memdev_data->heap, s);
    1f14:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1f1b <memdev_set_subnode+0x21b>
    1f1b:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    1f1f:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    1f23:	48 89 d6             	mov    rsi,rdx
    1f26:	48 89 c7             	mov    rdi,rax
    1f29:	e8 00 00 00 00       	call   1f2e <memdev_set_subnode+0x22e>
    1f2e:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
				if (!mem)
    1f32:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
    1f37:	75 0a                	jne    1f43 <memdev_set_subnode+0x243>
						return -1;
    1f39:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1f3e:	e9 a7 04 00 00       	jmp    23ea <memdev_set_subnode+0x6ea>
				/* now we have clean pages or heap memory */
				n1 = (struct memdev_node*)mem;
    1f43:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1f47:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
				n1->cap = s;
    1f4b:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1f4f:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    1f53:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
				n1->size = sizeof(struct memdev_node);
    1f57:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1f5b:	48 c7 40 08 20 00 00 00 	mov    QWORD PTR [rax+0x8],0x20
				n1->file = in1->in_stat.st_mode;
    1f63:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1f67:	8b 50 10             	mov    edx,DWORD PTR [rax+0x10]
    1f6a:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1f6e:	89 10                	mov    DWORD PTR [rax],edx
				n1->ino = ino_allocate(in1->in_stat.st_mode & S_IFMT);
    1f70:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1f74:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1f77:	25 00 f0 00 00       	and    eax,0xf000
    1f7c:	89 c7                	mov    edi,eax
    1f7e:	e8 00 00 00 00       	call   1f83 <memdev_set_subnode+0x283>
    1f83:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    1f87:	48 89 42 18          	mov    QWORD PTR [rdx+0x18],rax
				if (!n1->ino) { /* undo much */
    1f8b:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1f8f:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    1f93:	48 85 c0             	test   rax,rax
    1f96:	75 57                	jne    1fef <memdev_set_subnode+0x2ef>
free_mem:
    1f98:	90                   	nop
						if (S_ISREG(n1->file))
    1f99:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1f9d:	8b 00                	mov    eax,DWORD PTR [rax]
    1f9f:	25 00 f0 00 00       	and    eax,0xf000
    1fa4:	3d 00 80 00 00       	cmp    eax,0x8000
    1fa9:	75 20                	jne    1fcb <memdev_set_subnode+0x2cb>
								mm_free_vmem(&mm_kernel, n1, s / 4096);
    1fab:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1faf:	48 c1 e8 0c          	shr    rax,0xc
    1fb3:	48 89 c2             	mov    rdx,rax
    1fb6:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1fba:	48 89 c6             	mov    rsi,rax
    1fbd:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1fc4:	e8 00 00 00 00       	call   1fc9 <memdev_set_subnode+0x2c9>
    1fc9:	eb 1a                	jmp    1fe5 <memdev_set_subnode+0x2e5>
						else
								h_free(memdev_data->heap, n1);
    1fcb:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1fd2 <memdev_set_subnode+0x2d2>
    1fd2:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    1fd6:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    1fda:	48 89 d6             	mov    rsi,rdx
    1fdd:	48 89 c7             	mov    rdi,rax
    1fe0:	e8 00 00 00 00       	call   1fe5 <memdev_set_subnode+0x2e5>
						return -1;
    1fe5:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1fea:	e9 fb 03 00 00       	jmp    23ea <memdev_set_subnode+0x6ea>
				}
				/* and the inode */
				n1->ino->in_stat.st_blksize = 4096;
    1fef:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1ff3:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    1ff7:	48 c7 40 38 00 10 00 00 	mov    QWORD PTR [rax+0x38],0x1000
				n1->ino->in_stat.st_blocks = s / 512 + ((s % 512) ? 1 : 0);
    1fff:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2003:	48 c1 e8 09          	shr    rax,0x9
    2007:	48 89 c2             	mov    rdx,rax
    200a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    200e:	25 ff 01 00 00       	and    eax,0x1ff
    2013:	48 85 c0             	test   rax,rax
    2016:	74 07                	je     201f <memdev_set_subnode+0x31f>
    2018:	b8 01 00 00 00       	mov    eax,0x1
    201d:	eb 05                	jmp    2024 <memdev_set_subnode+0x324>
    201f:	b8 00 00 00 00       	mov    eax,0x0
    2024:	48 01 c2             	add    rdx,rax
    2027:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    202b:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    202f:	48 89 50 40          	mov    QWORD PTR [rax+0x40],rdx
				n1->ino->in_stat.st_dev = memdev_data->id;
    2033:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 203a <memdev_set_subnode+0x33a>
    203a:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    203e:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    2042:	48 8b 12             	mov    rdx,QWORD PTR [rdx]
    2045:	48 89 10             	mov    QWORD PTR [rax],rdx
				n1->ino->in_stat.st_size = 1;
    2048:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    204c:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    2050:	48 c7 40 30 01 00 00 00 	mov    QWORD PTR [rax+0x30],0x1
				n1->ino->in_pddat = memdev_store_node(n1);
    2058:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    205c:	48 8b 58 18          	mov    rbx,QWORD PTR [rax+0x18]
    2060:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    2064:	48 89 c7             	mov    rdi,rax
    2067:	e8 00 00 00 00       	call   206c <memdev_set_subnode+0x36c>
    206c:	48 89 83 80 00 00 00 	mov    QWORD PTR [rbx+0x80],rax
				if (!n1->ino->in_pddat) {
    2073:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    2077:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    207b:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
    2082:	48 85 c0             	test   rax,rax
    2085:	75 15                	jne    209c <memdev_set_subnode+0x39c>
						/* sth. went wrong! */
						ino_release(n1->ino);
    2087:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    208b:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    208f:	48 89 c7             	mov    rdi,rax
    2092:	e8 00 00 00 00       	call   2097 <memdev_set_subnode+0x397>
						goto free_mem;
    2097:	e9 fd fe ff ff       	jmp    1f99 <memdev_set_subnode+0x299>
				}
				in1 = n1->ino;
    209c:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    20a0:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    20a4:	48 89 45 90          	mov    QWORD PTR [rbp-0x70],rax
		}

		/* acquire the write lock */
		write_lock(&in0->in_lock);
    20a8:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    20ac:	48 05 88 00 00 00    	add    rax,0x88
    20b2:	48 89 c7             	mov    rdi,rax
    20b5:	e8 00 00 00 00       	call   20ba <memdev_set_subnode+0x3ba>
		/* find possible old/conflicting inode */
		char* dt = memdev_search_fn(n0, fn), need_entry = 1;
    20ba:	48 8b 55 88          	mov    rdx,QWORD PTR [rbp-0x78]
    20be:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    20c2:	48 89 d6             	mov    rsi,rdx
    20c5:	48 89 c7             	mov    rdi,rax
    20c8:	e8 00 00 00 00       	call   20cd <memdev_set_subnode+0x3cd>
    20cd:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
    20d1:	c6 45 d7 01          	mov    BYTE PTR [rbp-0x29],0x1
		if (dt) {
    20d5:	48 83 7d c0 00       	cmp    QWORD PTR [rbp-0x40],0x0
    20da:	0f 84 1e 01 00 00    	je     21fe <memdev_set_subnode+0x4fe>
				struct inode* in2;
				/* already existing, get inode */
				dt += strlen(dt) + 1;
    20e0:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    20e4:	48 89 c7             	mov    rdi,rax
    20e7:	e8 00 00 00 00       	call   20ec <memdev_set_subnode+0x3ec>
    20ec:	48 83 c0 01          	add    rax,0x1
    20f0:	48 01 45 c0          	add    QWORD PTR [rbp-0x40],rax
				in2 = *(struct inode**)dt;
    20f4:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    20f8:	48 8b 00             	mov    rax,QWORD PTR [rax]
    20fb:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
				if (in1 == in2) {
    20ff:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    2103:	48 3b 45 b8          	cmp    rax,QWORD PTR [rbp-0x48]
    2107:	75 26                	jne    212f <memdev_set_subnode+0x42f>
						/* do nothing */
						errno = EEXIST;
    2109:	c7 05 00 00 00 00 11 00 00 00 	mov    DWORD PTR [rip+0x0],0x11        # 2113 <memdev_set_subnode+0x413>
						write_unlock(&in0->in_lock);
    2113:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2117:	48 05 88 00 00 00    	add    rax,0x88
    211d:	48 89 c7             	mov    rdi,rax
    2120:	e8 00 00 00 00       	call   2125 <memdev_set_subnode+0x425>
						return -1;
    2125:	b8 ff ff ff ff       	mov    eax,0xffffffff
    212a:	e9 bb 02 00 00       	jmp    23ea <memdev_set_subnode+0x6ea>
				}
				/* unlink old node if neccessary */
				if (in2->in_stat.st_dev == memdev_data->id)
    212f:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2133:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    2136:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 213d <memdev_set_subnode+0x43d>
    213d:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2140:	48 39 c2             	cmp    rdx,rax
    2143:	75 16                	jne    215b <memdev_set_subnode+0x45b>
						memdev_unlink(NULL, in2);
    2145:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2149:	48 89 c6             	mov    rsi,rax
    214c:	bf 00 00 00 00       	mov    edi,0x0
    2151:	e8 00 00 00 00       	call   2156 <memdev_set_subnode+0x456>
    2156:	e9 83 00 00 00       	jmp    21de <memdev_set_subnode+0x4de>
				else {
						const struct device_desc* dd;
						dd = get_device(in2->in_stat.st_dev);
    215b:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    215f:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2162:	48 89 c7             	mov    rdi,rax
    2165:	e8 00 00 00 00       	call   216a <memdev_set_subnode+0x46a>
    216a:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
						if (!dd) {
    216e:	48 83 7d b0 00       	cmp    QWORD PTR [rbp-0x50],0x0
    2173:	75 53                	jne    21c8 <memdev_set_subnode+0x4c8>
								cprintf(KFMT_WARN, "unable to locate device %u"
												" for unlinking inode referenced by %s\n",
												(uint32_t)in2->in_stat.st_dev, fn);
    2175:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2179:	48 8b 00             	mov    rax,QWORD PTR [rax]
								cprintf(KFMT_WARN, "unable to locate device %u"
    217c:	89 c2                	mov    edx,eax
    217e:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2182:	48 89 c1             	mov    rcx,rax
    2185:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    218c:	bf 0e 00 00 00       	mov    edi,0xe
    2191:	b8 00 00 00 00       	mov    eax,0x0
    2196:	e8 00 00 00 00       	call   219b <memdev_set_subnode+0x49b>
								if (__sync_sub_and_fetch(&in2->in_stat.st_dev, 1) == 0)
    219b:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
    219f:	b8 01 00 00 00       	mov    eax,0x1
    21a4:	48 f7 d8             	neg    rax
    21a7:	48 89 c1             	mov    rcx,rax
    21aa:	48 89 c8             	mov    rax,rcx
    21ad:	f0 48 0f c1 02       	lock xadd QWORD PTR [rdx],rax
    21b2:	48 01 c8             	add    rax,rcx
    21b5:	48 85 c0             	test   rax,rax
    21b8:	75 24                	jne    21de <memdev_set_subnode+0x4de>
										ino_release(in2); /* clean up partially */
    21ba:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    21be:	48 89 c7             	mov    rdi,rax
    21c1:	e8 00 00 00 00       	call   21c6 <memdev_set_subnode+0x4c6>
    21c6:	eb 16                	jmp    21de <memdev_set_subnode+0x4de>
						} else {
								dd->fn_unlink(NULL, in2);
    21c8:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    21cc:	48 8b 50 58          	mov    rdx,QWORD PTR [rax+0x58]
    21d0:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    21d4:	48 89 c6             	mov    rsi,rax
    21d7:	bf 00 00 00 00       	mov    edi,0x0
    21dc:	ff d2                	call   rdx
						}
				}
				/* set new link */
				*(struct inode**)dt = in1;
    21de:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    21e2:	48 8b 55 90          	mov    rdx,QWORD PTR [rbp-0x70]
    21e6:	48 89 10             	mov    QWORD PTR [rax],rdx
				need_entry = 0;
    21e9:	c6 45 d7 00          	mov    BYTE PTR [rbp-0x29],0x0
				printf("fn matches prev\n");
    21ed:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    21f4:	b8 00 00 00 00       	mov    eax,0x0
    21f9:	e8 00 00 00 00       	call   21fe <memdev_set_subnode+0x4fe>
		}

		/* assume valid inode in1 */
		__sync_fetch_and_add(&in1->in_stat.st_nlink, 1);
    21fe:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    2202:	48 83 c0 18          	add    rax,0x18
    2206:	f0 48 83 00 01       	lock add QWORD PTR [rax],0x1
		if (need_entry) {
    220b:	80 7d d7 00          	cmp    BYTE PTR [rbp-0x29],0x0
    220f:	0f 84 79 01 00 00    	je     238e <memdev_set_subnode+0x68e>
				/* modify data */
				size_t s = strlen(fn) + 1 + sizeof(void*);
    2215:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2219:	48 89 c7             	mov    rdi,rax
    221c:	e8 00 00 00 00       	call   2221 <memdev_set_subnode+0x521>
    2221:	48 83 c0 09          	add    rax,0x9
    2225:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
				dt = (char*)n0 + n0->size;
    2229:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    222d:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    2231:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2235:	48 01 d0             	add    rax,rdx
    2238:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
				if ((n0->cap - n0->size) < s) {
    223c:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2240:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    2244:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2248:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    224c:	48 29 c2             	sub    rdx,rax
    224f:	48 3b 55 a8          	cmp    rdx,QWORD PTR [rbp-0x58]
    2253:	0f 83 83 00 00 00    	jae    22dc <memdev_set_subnode+0x5dc>
						/* use realloc */
						size_t nc = 2 * n0->cap + s;
    2259:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    225d:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    2261:	48 8d 14 00          	lea    rdx,[rax+rax*1]
    2265:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2269:	48 01 d0             	add    rax,rdx
    226c:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
						n0 = h_realloc(memdev_data->heap, n0, nc);
    2270:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2277 <memdev_set_subnode+0x577>
    2277:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    227b:	48 8b 55 a0          	mov    rdx,QWORD PTR [rbp-0x60]
    227f:	48 8b 4d e8          	mov    rcx,QWORD PTR [rbp-0x18]
    2283:	48 89 ce             	mov    rsi,rcx
    2286:	48 89 c7             	mov    rdi,rax
    2289:	e8 00 00 00 00       	call   228e <memdev_set_subnode+0x58e>
    228e:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
						if (!n0) { /* real OOM */
    2292:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    2297:	75 21                	jne    22ba <memdev_set_subnode+0x5ba>
								cprintf(KFMT_ERROR, "failed to realloc on memdev heap: errno=%d\n", errno);
    2299:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 229f <memdev_set_subnode+0x59f>
    229f:	89 c2                	mov    edx,eax
    22a1:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    22a8:	bf 0c 00 00 00       	mov    edi,0xc
    22ad:	b8 00 00 00 00       	mov    eax,0x0
    22b2:	e8 00 00 00 00       	call   22b7 <memdev_set_subnode+0x5b7>
								while (1);
    22b7:	90                   	nop
    22b8:	eb fd                	jmp    22b7 <memdev_set_subnode+0x5b7>
						}
						/* no cmpxchg neccessary */
						*(struct memdev_node**)n0->ino->in_pddat = n0;
    22ba:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    22be:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    22c2:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
    22c9:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    22cd:	48 89 10             	mov    QWORD PTR [rax],rdx
						n0->cap = nc;
    22d0:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    22d4:	48 8b 55 a0          	mov    rdx,QWORD PTR [rbp-0x60]
    22d8:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
				}
				/* we now have enough space */
				strncpy(dt, fn, s - 1 - sizeof(void*));
    22dc:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    22e0:	48 8d 50 f7          	lea    rdx,[rax-0x9]
    22e4:	48 8b 4d 88          	mov    rcx,QWORD PTR [rbp-0x78]
    22e8:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    22ec:	48 89 ce             	mov    rsi,rcx
    22ef:	48 89 c7             	mov    rdi,rax
    22f2:	e8 00 00 00 00       	call   22f7 <memdev_set_subnode+0x5f7>
				dt += s - 1 - sizeof(void*);
    22f7:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    22fb:	48 83 e8 09          	sub    rax,0x9
    22ff:	48 01 45 c0          	add    QWORD PTR [rbp-0x40],rax
				*dt = '\0';
    2303:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2307:	c6 00 00             	mov    BYTE PTR [rax],0x0
				*(struct inode**)(++dt) = in1;
    230a:	48 83 45 c0 01       	add    QWORD PTR [rbp-0x40],0x1
    230f:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2313:	48 8b 55 90          	mov    rdx,QWORD PTR [rbp-0x70]
    2317:	48 89 10             	mov    QWORD PTR [rax],rdx
				n0->size += s;
    231a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    231e:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    2322:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2326:	48 01 c2             	add    rdx,rax
    2329:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    232d:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
				in0->in_stat.st_size = n0->size - sizeof(struct memdev_node);
    2331:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2335:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2339:	48 83 e8 20          	sub    rax,0x20
    233d:	48 89 c2             	mov    rdx,rax
    2340:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2344:	48 89 50 30          	mov    QWORD PTR [rax+0x30],rdx
				in0->in_stat.st_blocks = in0->in_stat.st_size / 512
    2348:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    234c:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
    2350:	48 8d 90 ff 01 00 00 	lea    rdx,[rax+0x1ff]
    2357:	48 85 c0             	test   rax,rax
    235a:	48 0f 48 c2          	cmovs  rax,rdx
    235e:	48 c1 f8 09          	sar    rax,0x9
    2362:	48 89 c2             	mov    rdx,rax
					   	+ ((in0->in_stat.st_size % 512) ? 1 : 0);
    2365:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2369:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
    236d:	25 ff 01 00 00       	and    eax,0x1ff
    2372:	48 85 c0             	test   rax,rax
    2375:	74 07                	je     237e <memdev_set_subnode+0x67e>
    2377:	b8 01 00 00 00       	mov    eax,0x1
    237c:	eb 05                	jmp    2383 <memdev_set_subnode+0x683>
    237e:	b8 00 00 00 00       	mov    eax,0x0
    2383:	48 01 c2             	add    rdx,rax
				in0->in_stat.st_blocks = in0->in_stat.st_size / 512
    2386:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    238a:	48 89 50 40          	mov    QWORD PTR [rax+0x40],rdx
		}
		/* update times (only c&m on dir & c on fil) */
		clock_gettime(CLOCK_REALTIME, &in0->in_stat.st_mtim);
    238e:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2392:	48 83 c0 58          	add    rax,0x58
    2396:	48 89 c6             	mov    rsi,rax
    2399:	bf 00 00 00 00       	mov    edi,0x0
    239e:	e8 00 00 00 00       	call   23a3 <memdev_set_subnode+0x6a3>
		in0->in_stat.st_ctim = in0->in_stat.st_mtim;
    23a3:	48 8b 4d 98          	mov    rcx,QWORD PTR [rbp-0x68]
    23a7:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    23ab:	48 8b 50 60          	mov    rdx,QWORD PTR [rax+0x60]
    23af:	48 8b 40 58          	mov    rax,QWORD PTR [rax+0x58]
    23b3:	48 89 41 68          	mov    QWORD PTR [rcx+0x68],rax
    23b7:	48 89 51 70          	mov    QWORD PTR [rcx+0x70],rdx
		/* due to change in link count */
		in1->in_stat.st_ctim = in0->in_stat.st_mtim;
    23bb:	48 8b 4d 90          	mov    rcx,QWORD PTR [rbp-0x70]
    23bf:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    23c3:	48 8b 50 60          	mov    rdx,QWORD PTR [rax+0x60]
    23c7:	48 8b 40 58          	mov    rax,QWORD PTR [rax+0x58]
    23cb:	48 89 41 68          	mov    QWORD PTR [rcx+0x68],rax
    23cf:	48 89 51 70          	mov    QWORD PTR [rcx+0x70],rdx
		write_unlock(&in0->in_lock);
    23d3:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    23d7:	48 05 88 00 00 00    	add    rax,0x88
    23dd:	48 89 c7             	mov    rdi,rax
    23e0:	e8 00 00 00 00       	call   23e5 <memdev_set_subnode+0x6e5>
		return 0;
    23e5:	b8 00 00 00 00       	mov    eax,0x0
}
    23ea:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
    23ee:	c9                   	leave
    23ef:	c3                   	ret

00000000000023f0 <get_special_inode>:
/**********************************************************/
static struct inode *in_root, *in_dev;
struct inode* get_special_inode(enum spec_ino what)
{
    23f0:	55                   	push   rbp
    23f1:	48 89 e5             	mov    rbp,rsp
    23f4:	48 83 ec 08          	sub    rsp,0x8
    23f8:	89 7d fc             	mov    DWORD PTR [rbp-0x4],edi
		switch (what) {
    23fb:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
    23ff:	74 08                	je     2409 <get_special_inode+0x19>
    2401:	83 7d fc 01          	cmp    DWORD PTR [rbp-0x4],0x1
    2405:	74 0b                	je     2412 <get_special_inode+0x22>
    2407:	eb 12                	jmp    241b <get_special_inode+0x2b>
				case INO_ROOT:
						return in_root;
    2409:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2410 <get_special_inode+0x20>
    2410:	eb 0e                	jmp    2420 <get_special_inode+0x30>
				case INO_DEV:
						return in_dev;
    2412:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2419 <get_special_inode+0x29>
    2419:	eb 05                	jmp    2420 <get_special_inode+0x30>
				default:
						return NULL;
    241b:	b8 00 00 00 00       	mov    eax,0x0
		}
}
    2420:	c9                   	leave
    2421:	c3                   	ret

0000000000002422 <module_init>:
/**********************************************************/
int MODENTRY module_init()
{
    2422:	55                   	push   rbp
    2423:	48 89 e5             	mov    rbp,rsp
    2426:	48 81 ec 10 01 00 00 	sub    rsp,0x110
		struct device_desc dd = {0}; dev_t d;
    242d:	48 8d 55 88          	lea    rdx,[rbp-0x78]
    2431:	b8 00 00 00 00       	mov    eax,0x0
    2436:	b9 0e 00 00 00       	mov    ecx,0xe
    243b:	48 89 d7             	mov    rdi,rdx
    243e:	f3 48 ab             	rep stos QWORD PTR es:[rdi],rax
		printf("registering the basic file devices\n");
    2441:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2448:	b8 00 00 00 00       	mov    eax,0x0
    244d:	e8 00 00 00 00       	call   2452 <module_init+0x30>
		dd.type = DEVTYPE_NONE;
    2452:	c6 45 88 01          	mov    BYTE PTR [rbp-0x78],0x1
		dd.fn_reg_dev = memdev_register;
    2456:	48 c7 45 90 00 00 00 00 	mov    QWORD PTR [rbp-0x70],0x0
		dd.fn_unreg_dev = memdev_unregister;
    245e:	48 c7 45 98 00 00 00 00 	mov    QWORD PTR [rbp-0x68],0x0
		dd.fn_open = memdev_open;
    2466:	48 c7 45 a0 00 00 00 00 	mov    QWORD PTR [rbp-0x60],0x0
		dd.fn_read = memdev_read;
    246e:	48 c7 45 a8 00 00 00 00 	mov    QWORD PTR [rbp-0x58],0x0
		dd.fn_write = memdev_write;
    2476:	48 c7 45 b0 00 00 00 00 	mov    QWORD PTR [rbp-0x50],0x0
		dd.fn_close = memdev_close;
    247e:	48 c7 45 b8 00 00 00 00 	mov    QWORD PTR [rbp-0x48],0x0
		dd.fn_lseek = memdev_lseek;
    2486:	48 c7 45 c0 00 00 00 00 	mov    QWORD PTR [rbp-0x40],0x0
		dd.fn_truncate = memdev_truncate;
    248e:	48 c7 45 c8 00 00 00 00 	mov    QWORD PTR [rbp-0x38],0x0
		dd.fn_get_subnode = memdev_get_subnode;
    2496:	48 c7 45 d0 00 00 00 00 	mov    QWORD PTR [rbp-0x30],0x0
		dd.fn_set_subnode = memdev_set_subnode;
    249e:	48 c7 45 d8 00 00 00 00 	mov    QWORD PTR [rbp-0x28],0x0
		dd.fn_unlink = memdev_unlink;
    24a6:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
		d = register_device(&dd);
    24ae:	48 8d 45 88          	lea    rax,[rbp-0x78]
    24b2:	48 89 c7             	mov    rdi,rax
    24b5:	e8 00 00 00 00       	call   24ba <module_init+0x98>
    24ba:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (d != INVALID_DEVICE)
    24be:	48 83 7d f8 ff       	cmp    QWORD PTR [rbp-0x8],0xffffffffffffffff
    24c3:	74 4f                	je     2514 <module_init+0xf2>
				printf("\tregistered memdev as device %u\n", (uint32_t)d);
    24c5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    24c9:	89 c6                	mov    esi,eax
    24cb:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    24d2:	b8 00 00 00 00       	mov    eax,0x0
    24d7:	e8 00 00 00 00       	call   24dc <module_init+0xba>
		else {
				printf("\tfailed to register memdev: errno=%d\n", errno);
				return -1;
		}

		printf("\ncreating the root file system\n");
    24dc:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    24e3:	b8 00 00 00 00       	mov    eax,0x0
    24e8:	e8 00 00 00 00       	call   24ed <module_init+0xcb>
		/* create the / & /dev folders */
		in_root = dd.fn_get_subnode(NULL, "");
    24ed:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    24f1:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    24f8:	bf 00 00 00 00       	mov    edi,0x0
    24fd:	ff d0                	call   rax
    24ff:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2506 <module_init+0xe4>
		if (!in_root) {
    2506:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 250d <module_init+0xeb>
    250d:	48 85 c0             	test   rax,rax
    2510:	75 4d                	jne    255f <module_init+0x13d>
    2512:	eb 23                	jmp    2537 <module_init+0x115>
				printf("\tfailed to register memdev: errno=%d\n", errno);
    2514:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 251a <module_init+0xf8>
    251a:	89 c6                	mov    esi,eax
    251c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2523:	b8 00 00 00 00       	mov    eax,0x0
    2528:	e8 00 00 00 00       	call   252d <module_init+0x10b>
				return -1;
    252d:	b8 ff ff ff ff       	mov    eax,0xffffffff
    2532:	e9 15 01 00 00       	jmp    264c <module_init+0x22a>
				cprintf(KFMT_ERROR, "\tfailed to create root in memdev: errno=%d\n", errno);
    2537:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 253d <module_init+0x11b>
    253d:	89 c2                	mov    edx,eax
    253f:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2546:	bf 0c 00 00 00       	mov    edi,0xc
    254b:	b8 00 00 00 00       	mov    eax,0x0
    2550:	e8 00 00 00 00       	call   2555 <module_init+0x133>
				return -1;
    2555:	b8 ff ff ff ff       	mov    eax,0xffffffff
    255a:	e9 ed 00 00 00       	jmp    264c <module_init+0x22a>
		}
		printf("adding /dev\n");
    255f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2566:	b8 00 00 00 00       	mov    eax,0x0
    256b:	e8 00 00 00 00       	call   2570 <module_init+0x14e>
		if (dd.fn_set_subnode(in_root, &INO_TMPL_DIR, "dev") != 0) {
    2570:	4c 8b 45 d8          	mov    r8,QWORD PTR [rbp-0x28]
    2574:	48 8d 95 f8 fe ff ff 	lea    rdx,[rbp-0x108]
    257b:	b8 00 00 00 00       	mov    eax,0x0
    2580:	b9 12 00 00 00       	mov    ecx,0x12
    2585:	48 89 d7             	mov    rdi,rdx
    2588:	f3 48 ab             	rep stos QWORD PTR es:[rdi],rax
    258b:	48 c7 85 f8 fe ff ff ff ff ff ff 	mov    QWORD PTR [rbp-0x108],0xffffffffffffffff
    2596:	c7 85 08 ff ff ff 00 40 00 00 	mov    DWORD PTR [rbp-0xf8],0x4000
    25a0:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 25a7 <module_init+0x185>
    25a7:	48 8d 8d f8 fe ff ff 	lea    rcx,[rbp-0x108]
    25ae:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    25b5:	48 89 ce             	mov    rsi,rcx
    25b8:	48 89 c7             	mov    rdi,rax
    25bb:	41 ff d0             	call   r8
    25be:	85 c0                	test   eax,eax
    25c0:	74 25                	je     25e7 <module_init+0x1c5>
				cprintf(KFMT_ERROR, "\tfailed to create folder /dev in root: errno=%d\n", errno);
    25c2:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 25c8 <module_init+0x1a6>
    25c8:	89 c2                	mov    edx,eax
    25ca:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    25d1:	bf 0c 00 00 00       	mov    edi,0xc
    25d6:	b8 00 00 00 00       	mov    eax,0x0
    25db:	e8 00 00 00 00       	call   25e0 <module_init+0x1be>
				return -1;
    25e0:	b8 ff ff ff ff       	mov    eax,0xffffffff
    25e5:	eb 65                	jmp    264c <module_init+0x22a>
		}
		printf("retrieving /dev\n");
    25e7:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    25ee:	b8 00 00 00 00       	mov    eax,0x0
    25f3:	e8 00 00 00 00       	call   25f8 <module_init+0x1d6>
		in_dev = dd.fn_get_subnode(in_root, "dev");
    25f8:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    25fc:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2603 <module_init+0x1e1>
    2603:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    260a:	48 89 c7             	mov    rdi,rax
    260d:	ff d2                	call   rdx
    260f:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2616 <module_init+0x1f4>
		if (!in_dev) {
    2616:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 261d <module_init+0x1fb>
    261d:	48 85 c0             	test   rax,rax
    2620:	75 25                	jne    2647 <module_init+0x225>
				cprintf(KFMT_ERROR, "\tfailed to access folder /dev: errno=%d\n", errno);
    2622:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2628 <module_init+0x206>
    2628:	89 c2                	mov    edx,eax
    262a:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2631:	bf 0c 00 00 00       	mov    edi,0xc
    2636:	b8 00 00 00 00       	mov    eax,0x0
    263b:	e8 00 00 00 00       	call   2640 <module_init+0x21e>
				return -1;
    2640:	b8 ff ff ff ff       	mov    eax,0xffffffff
    2645:	eb 05                	jmp    264c <module_init+0x22a>
		}

		return 0;
    2647:	b8 00 00 00 00       	mov    eax,0x0
}
    264c:	c9                   	leave
    264d:	c3                   	ret

000000000000264e <print_stat>:

void print_stat(struct inode* in, const char* fn, int cb, int cu, int cg, int cs)
{
    264e:	55                   	push   rbp
    264f:	48 89 e5             	mov    rbp,rsp
    2652:	41 57                	push   r15
    2654:	41 56                	push   r14
    2656:	41 55                	push   r13
    2658:	41 54                	push   r12
    265a:	53                   	push   rbx
    265b:	48 81 ec f8 00 00 00 	sub    rsp,0xf8
    2662:	48 89 bd 78 ff ff ff 	mov    QWORD PTR [rbp-0x88],rdi
    2669:	48 89 b5 70 ff ff ff 	mov    QWORD PTR [rbp-0x90],rsi
    2670:	89 95 6c ff ff ff    	mov    DWORD PTR [rbp-0x94],edx
    2676:	89 8d 68 ff ff ff    	mov    DWORD PTR [rbp-0x98],ecx
    267c:	44 89 85 64 ff ff ff 	mov    DWORD PTR [rbp-0x9c],r8d
    2683:	44 89 8d 60 ff ff ff 	mov    DWORD PTR [rbp-0xa0],r9d
		char fmt = KFMT_NORMAL, c_tp = '-', c_ur = '-', c_uw = '-',
    268a:	c6 45 cf 0f          	mov    BYTE PTR [rbp-0x31],0xf
    268e:	c6 45 ce 2d          	mov    BYTE PTR [rbp-0x32],0x2d
    2692:	c6 45 cd 2d          	mov    BYTE PTR [rbp-0x33],0x2d
    2696:	c6 45 cc 2d          	mov    BYTE PTR [rbp-0x34],0x2d
			 c_ux = '-', c_gr = '-', c_gw = '-', c_gx = '-', c_or = '-',
    269a:	c6 45 cb 2d          	mov    BYTE PTR [rbp-0x35],0x2d
    269e:	c6 45 ca 2d          	mov    BYTE PTR [rbp-0x36],0x2d
    26a2:	c6 45 c9 2d          	mov    BYTE PTR [rbp-0x37],0x2d
    26a6:	c6 45 c8 2d          	mov    BYTE PTR [rbp-0x38],0x2d
    26aa:	c6 45 c7 2d          	mov    BYTE PTR [rbp-0x39],0x2d
			 c_ow = '-', c_ox = '-';
    26ae:	c6 45 c6 2d          	mov    BYTE PTR [rbp-0x3a],0x2d
    26b2:	c6 45 c5 2d          	mov    BYTE PTR [rbp-0x3b],0x2d
		mode_t m = in->in_stat.st_mode;
    26b6:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    26bd:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    26c0:	89 45 c0             	mov    DWORD PTR [rbp-0x40],eax

		if (m & S_IRUSR)
    26c3:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    26c6:	25 00 01 00 00       	and    eax,0x100
    26cb:	85 c0                	test   eax,eax
    26cd:	74 04                	je     26d3 <print_stat+0x85>
				c_ur = 'r';
    26cf:	c6 45 cd 72          	mov    BYTE PTR [rbp-0x33],0x72
		if (m & S_IWUSR)
    26d3:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    26d6:	25 80 00 00 00       	and    eax,0x80
    26db:	85 c0                	test   eax,eax
    26dd:	74 04                	je     26e3 <print_stat+0x95>
				c_uw = 'w';
    26df:	c6 45 cc 77          	mov    BYTE PTR [rbp-0x34],0x77
		if (m & S_IXUSR)
    26e3:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    26e6:	83 e0 40             	and    eax,0x40
    26e9:	85 c0                	test   eax,eax
    26eb:	74 04                	je     26f1 <print_stat+0xa3>
				c_ux = 'x';
    26ed:	c6 45 cb 78          	mov    BYTE PTR [rbp-0x35],0x78
		if (m & S_ISUID) /* setuid */
    26f1:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    26f4:	25 00 08 00 00       	and    eax,0x800
    26f9:	85 c0                	test   eax,eax
    26fb:	74 15                	je     2712 <print_stat+0xc4>
				c_ux = ((c_ux == 'x') ? 's' : 'S');
    26fd:	80 7d cb 78          	cmp    BYTE PTR [rbp-0x35],0x78
    2701:	75 07                	jne    270a <print_stat+0xbc>
    2703:	b8 73 00 00 00       	mov    eax,0x73
    2708:	eb 05                	jmp    270f <print_stat+0xc1>
    270a:	b8 53 00 00 00       	mov    eax,0x53
    270f:	88 45 cb             	mov    BYTE PTR [rbp-0x35],al
		if (m & S_IRGRP)
    2712:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    2715:	83 e0 20             	and    eax,0x20
    2718:	85 c0                	test   eax,eax
    271a:	74 04                	je     2720 <print_stat+0xd2>
				c_gr = 'r';
    271c:	c6 45 ca 72          	mov    BYTE PTR [rbp-0x36],0x72
		if (m & S_IWGRP)
    2720:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    2723:	83 e0 10             	and    eax,0x10
    2726:	85 c0                	test   eax,eax
    2728:	74 04                	je     272e <print_stat+0xe0>
				c_gw = 'w';
    272a:	c6 45 c9 77          	mov    BYTE PTR [rbp-0x37],0x77
		if (m & S_IXGRP)
    272e:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    2731:	83 e0 08             	and    eax,0x8
    2734:	85 c0                	test   eax,eax
    2736:	74 04                	je     273c <print_stat+0xee>
				c_gx = 'x';
    2738:	c6 45 c8 78          	mov    BYTE PTR [rbp-0x38],0x78
		if (m & S_ISGID) /* setgid */
    273c:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    273f:	25 00 04 00 00       	and    eax,0x400
    2744:	85 c0                	test   eax,eax
    2746:	74 15                	je     275d <print_stat+0x10f>
				c_gx = ((c_gx == 'x') ? 's' : 'S');
    2748:	80 7d c8 78          	cmp    BYTE PTR [rbp-0x38],0x78
    274c:	75 07                	jne    2755 <print_stat+0x107>
    274e:	b8 73 00 00 00       	mov    eax,0x73
    2753:	eb 05                	jmp    275a <print_stat+0x10c>
    2755:	b8 53 00 00 00       	mov    eax,0x53
    275a:	88 45 c8             	mov    BYTE PTR [rbp-0x38],al
		if (m & S_IROTH)
    275d:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    2760:	83 e0 04             	and    eax,0x4
    2763:	85 c0                	test   eax,eax
    2765:	74 04                	je     276b <print_stat+0x11d>
				c_or = 'r';
    2767:	c6 45 c7 72          	mov    BYTE PTR [rbp-0x39],0x72
		if (m & S_IWOTH)
    276b:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    276e:	83 e0 02             	and    eax,0x2
    2771:	85 c0                	test   eax,eax
    2773:	74 04                	je     2779 <print_stat+0x12b>
				c_ow = 'w';
    2775:	c6 45 c6 77          	mov    BYTE PTR [rbp-0x3a],0x77
		if (m & S_IXOTH)
    2779:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    277c:	83 e0 01             	and    eax,0x1
    277f:	85 c0                	test   eax,eax
    2781:	74 04                	je     2787 <print_stat+0x139>
				c_ox = 'x';
    2783:	c6 45 c5 78          	mov    BYTE PTR [rbp-0x3b],0x78
		if (m & S_ISVTX) /* sticky bit */
    2787:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    278a:	25 00 02 00 00       	and    eax,0x200
    278f:	85 c0                	test   eax,eax
    2791:	74 15                	je     27a8 <print_stat+0x15a>
				c_ox = ((c_ox == 'x') ? 't' : 'T');
    2793:	80 7d c5 78          	cmp    BYTE PTR [rbp-0x3b],0x78
    2797:	75 07                	jne    27a0 <print_stat+0x152>
    2799:	b8 74 00 00 00       	mov    eax,0x74
    279e:	eb 05                	jmp    27a5 <print_stat+0x157>
    27a0:	b8 54 00 00 00       	mov    eax,0x54
    27a5:	88 45 c5             	mov    BYTE PTR [rbp-0x3b],al
		if (S_ISDIR(m))
    27a8:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    27ab:	25 00 f0 00 00       	and    eax,0xf000
    27b0:	3d 00 40 00 00       	cmp    eax,0x4000
    27b5:	75 09                	jne    27c0 <print_stat+0x172>
				c_tp = 'd';
    27b7:	c6 45 ce 64          	mov    BYTE PTR [rbp-0x32],0x64
    27bb:	e9 82 00 00 00       	jmp    2842 <print_stat+0x1f4>
		else if (S_ISLNK(m))
    27c0:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    27c3:	25 00 f0 00 00       	and    eax,0xf000
    27c8:	3d 00 a0 00 00       	cmp    eax,0xa000
    27cd:	75 06                	jne    27d5 <print_stat+0x187>
				c_tp = 'l';
    27cf:	c6 45 ce 6c          	mov    BYTE PTR [rbp-0x32],0x6c
    27d3:	eb 6d                	jmp    2842 <print_stat+0x1f4>
		else if (S_ISFIFO(m))
    27d5:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    27d8:	25 00 f0 00 00       	and    eax,0xf000
    27dd:	3d 00 10 00 00       	cmp    eax,0x1000
    27e2:	75 06                	jne    27ea <print_stat+0x19c>
				c_tp = 'p';
    27e4:	c6 45 ce 70          	mov    BYTE PTR [rbp-0x32],0x70
    27e8:	eb 58                	jmp    2842 <print_stat+0x1f4>
		else if (S_ISCHR(m))
    27ea:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    27ed:	25 00 f0 00 00       	and    eax,0xf000
    27f2:	3d 00 20 00 00       	cmp    eax,0x2000
    27f7:	75 06                	jne    27ff <print_stat+0x1b1>
				c_tp = 'c';
    27f9:	c6 45 ce 63          	mov    BYTE PTR [rbp-0x32],0x63
    27fd:	eb 43                	jmp    2842 <print_stat+0x1f4>
		else if (S_ISBLK(m))
    27ff:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    2802:	25 00 f0 00 00       	and    eax,0xf000
    2807:	3d 00 60 00 00       	cmp    eax,0x6000
    280c:	75 06                	jne    2814 <print_stat+0x1c6>
				c_tp = 'b';
    280e:	c6 45 ce 62          	mov    BYTE PTR [rbp-0x32],0x62
    2812:	eb 2e                	jmp    2842 <print_stat+0x1f4>
		else if (S_ISSOCK(m))
    2814:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    2817:	25 00 f0 00 00       	and    eax,0xf000
    281c:	3d 00 c0 00 00       	cmp    eax,0xc000
    2821:	75 06                	jne    2829 <print_stat+0x1db>
				c_tp = 's';
    2823:	c6 45 ce 73          	mov    BYTE PTR [rbp-0x32],0x73
    2827:	eb 19                	jmp    2842 <print_stat+0x1f4>
		else if (S_ISREG(m))
    2829:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    282c:	25 00 f0 00 00       	and    eax,0xf000
    2831:	3d 00 80 00 00       	cmp    eax,0x8000
    2836:	75 06                	jne    283e <print_stat+0x1f0>
				c_tp = '-';
    2838:	c6 45 ce 2d          	mov    BYTE PTR [rbp-0x32],0x2d
    283c:	eb 04                	jmp    2842 <print_stat+0x1f4>
		else
				c_tp = '?';
    283e:	c6 45 ce 3f          	mov    BYTE PTR [rbp-0x32],0x3f
		/* -rw-r--r-- 1 dennis users 6728 Aug 29 19:32 prog.o */
		struct tm atime; char datstr[26];
		localtime_r(&in->in_stat.st_atim.tv_sec, &atime);
    2842:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    2849:	48 8d 50 48          	lea    rdx,[rax+0x48]
    284d:	48 8d 45 9c          	lea    rax,[rbp-0x64]
    2851:	48 89 c6             	mov    rsi,rax
    2854:	48 89 d7             	mov    rdi,rdx
    2857:	e8 00 00 00 00       	call   285c <print_stat+0x20e>
		asctime_r(&atime, datstr);
    285c:	48 8d 55 82          	lea    rdx,[rbp-0x7e]
    2860:	48 8d 45 9c          	lea    rax,[rbp-0x64]
    2864:	48 89 d6             	mov    rsi,rdx
    2867:	48 89 c7             	mov    rdi,rax
    286a:	e8 00 00 00 00       	call   286f <print_stat+0x221>
		/* reformat datstr TODO: strftime */
		/* old format: "Mon Aug 29 19:32:xy 2134 */
		strcpy(datstr, datstr + 4);
    286f:	48 8d 45 82          	lea    rax,[rbp-0x7e]
    2873:	48 83 c0 04          	add    rax,0x4
    2877:	48 8d 55 82          	lea    rdx,[rbp-0x7e]
    287b:	48 89 c6             	mov    rsi,rax
    287e:	48 89 d7             	mov    rdi,rdx
    2881:	e8 00 00 00 00       	call   2886 <print_stat+0x238>
		if (atime.tm_year != 115/*today.tm_year*/)
    2886:	8b 45 b0             	mov    eax,DWORD PTR [rbp-0x50]
    2889:	83 f8 73             	cmp    eax,0x73
    288c:	74 1b                	je     28a9 <print_stat+0x25b>
				strcpy(datstr + 7, datstr + 15);
    288e:	48 8d 55 82          	lea    rdx,[rbp-0x7e]
    2892:	48 83 c2 0f          	add    rdx,0xf
    2896:	48 8d 45 82          	lea    rax,[rbp-0x7e]
    289a:	48 83 c0 07          	add    rax,0x7
    289e:	48 89 d6             	mov    rsi,rdx
    28a1:	48 89 c7             	mov    rdi,rax
    28a4:	e8 00 00 00 00       	call   28a9 <print_stat+0x25b>
		datstr[12] = '\0';
    28a9:	c6 45 8e 00          	mov    BYTE PTR [rbp-0x72],0x0
		printf("%c%c%c%c%c%c%c%c%c%c %*u %*u %*u %*u %s ", c_tp, c_ur,
						c_uw, c_ux, c_gr, c_gw, c_gx, c_or, c_ow, c_ox,
						cb, (uint32_t)in->in_stat.st_nlink, cu, (uint32_t)in->in_stat.st_uid,
						cg, (uint32_t)in->in_stat.st_gid, cs, (uint32_t)in->in_stat.st_size,
    28ad:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    28b4:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
		printf("%c%c%c%c%c%c%c%c%c%c %*u %*u %*u %*u %s ", c_tp, c_ur,
    28b8:	89 85 5c ff ff ff    	mov    DWORD PTR [rbp-0xa4],eax
						cg, (uint32_t)in->in_stat.st_gid, cs, (uint32_t)in->in_stat.st_size,
    28be:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    28c5:	44 8b 60 24          	mov    r12d,DWORD PTR [rax+0x24]
						cb, (uint32_t)in->in_stat.st_nlink, cu, (uint32_t)in->in_stat.st_uid,
    28c9:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    28d0:	8b 58 20             	mov    ebx,DWORD PTR [rax+0x20]
    28d3:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    28da:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
		printf("%c%c%c%c%c%c%c%c%c%c %*u %*u %*u %*u %s ", c_tp, c_ur,
    28de:	41 89 c7             	mov    r15d,eax
    28e1:	44 0f be 5d c5       	movsx  r11d,BYTE PTR [rbp-0x3b]
    28e6:	44 0f be 55 c6       	movsx  r10d,BYTE PTR [rbp-0x3a]
    28eb:	44 0f be 4d c7       	movsx  r9d,BYTE PTR [rbp-0x39]
    28f0:	44 0f be 45 c8       	movsx  r8d,BYTE PTR [rbp-0x38]
    28f5:	0f be 7d c9          	movsx  edi,BYTE PTR [rbp-0x37]
    28f9:	44 0f be 75 ca       	movsx  r14d,BYTE PTR [rbp-0x36]
    28fe:	44 0f be 6d cb       	movsx  r13d,BYTE PTR [rbp-0x35]
    2903:	0f be 4d cc          	movsx  ecx,BYTE PTR [rbp-0x34]
    2907:	0f be 55 cd          	movsx  edx,BYTE PTR [rbp-0x33]
    290b:	0f be 75 ce          	movsx  esi,BYTE PTR [rbp-0x32]
    290f:	48 8d 45 82          	lea    rax,[rbp-0x7e]
    2913:	48 89 44 24 68       	mov    QWORD PTR [rsp+0x68],rax
    2918:	8b 85 5c ff ff ff    	mov    eax,DWORD PTR [rbp-0xa4]
    291e:	89 44 24 60          	mov    DWORD PTR [rsp+0x60],eax
    2922:	8b 85 60 ff ff ff    	mov    eax,DWORD PTR [rbp-0xa0]
    2928:	89 44 24 58          	mov    DWORD PTR [rsp+0x58],eax
    292c:	44 89 64 24 50       	mov    DWORD PTR [rsp+0x50],r12d
    2931:	8b 85 64 ff ff ff    	mov    eax,DWORD PTR [rbp-0x9c]
    2937:	89 44 24 48          	mov    DWORD PTR [rsp+0x48],eax
    293b:	89 5c 24 40          	mov    DWORD PTR [rsp+0x40],ebx
    293f:	8b 85 68 ff ff ff    	mov    eax,DWORD PTR [rbp-0x98]
    2945:	89 44 24 38          	mov    DWORD PTR [rsp+0x38],eax
    2949:	44 89 7c 24 30       	mov    DWORD PTR [rsp+0x30],r15d
    294e:	8b 85 6c ff ff ff    	mov    eax,DWORD PTR [rbp-0x94]
    2954:	89 44 24 28          	mov    DWORD PTR [rsp+0x28],eax
    2958:	44 89 5c 24 20       	mov    DWORD PTR [rsp+0x20],r11d
    295d:	44 89 54 24 18       	mov    DWORD PTR [rsp+0x18],r10d
    2962:	44 89 4c 24 10       	mov    DWORD PTR [rsp+0x10],r9d
    2967:	44 89 44 24 08       	mov    DWORD PTR [rsp+0x8],r8d
    296c:	89 3c 24             	mov    DWORD PTR [rsp],edi
    296f:	45 89 f1             	mov    r9d,r14d
    2972:	45 89 e8             	mov    r8d,r13d
    2975:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    297c:	b8 00 00 00 00       	mov    eax,0x0
    2981:	e8 00 00 00 00       	call   2986 <print_stat+0x338>
						datstr);
		if (S_ISDIR(m)) {
    2986:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    2989:	25 00 f0 00 00       	and    eax,0xf000
    298e:	3d 00 40 00 00       	cmp    eax,0x4000
    2993:	75 4f                	jne    29e4 <print_stat+0x396>
				fmt = LFMT_DIR;
    2995:	c6 45 cf 09          	mov    BYTE PTR [rbp-0x31],0x9
				if ((m & S_ISVTX) && (m & S_IWOTH))
    2999:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    299c:	25 00 02 00 00       	and    eax,0x200
    29a1:	85 c0                	test   eax,eax
    29a3:	74 13                	je     29b8 <print_stat+0x36a>
    29a5:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    29a8:	83 e0 02             	and    eax,0x2
    29ab:	85 c0                	test   eax,eax
    29ad:	74 09                	je     29b8 <print_stat+0x36a>
						fmt = LFMT_SWRT;
    29af:	c6 45 cf 20          	mov    BYTE PTR [rbp-0x31],0x20
    29b3:	e9 fc 00 00 00       	jmp    2ab4 <print_stat+0x466>
				else if (m & S_IWOTH)
    29b8:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    29bb:	83 e0 02             	and    eax,0x2
    29be:	85 c0                	test   eax,eax
    29c0:	74 09                	je     29cb <print_stat+0x37d>
						fmt = LFMT_OWRT;
    29c2:	c6 45 cf 21          	mov    BYTE PTR [rbp-0x31],0x21
    29c6:	e9 e9 00 00 00       	jmp    2ab4 <print_stat+0x466>
				else if (m & S_ISVTX)
    29cb:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    29ce:	25 00 02 00 00       	and    eax,0x200
    29d3:	85 c0                	test   eax,eax
    29d5:	0f 84 d9 00 00 00    	je     2ab4 <print_stat+0x466>
						fmt = LFMT_STCK;
    29db:	c6 45 cf 10          	mov    BYTE PTR [rbp-0x31],0x10
    29df:	e9 d0 00 00 00       	jmp    2ab4 <print_stat+0x466>
		} else if (S_ISREG(m)) {
    29e4:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    29e7:	25 00 f0 00 00       	and    eax,0xf000
    29ec:	3d 00 80 00 00       	cmp    eax,0x8000
    29f1:	75 54                	jne    2a47 <print_stat+0x3f9>
				if (m & S_ISUID)
    29f3:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    29f6:	25 00 08 00 00       	and    eax,0x800
    29fb:	85 c0                	test   eax,eax
    29fd:	74 09                	je     2a08 <print_stat+0x3ba>
						fmt = LFMT_SUID;
    29ff:	c6 45 cf 4f          	mov    BYTE PTR [rbp-0x31],0x4f
    2a03:	e9 ac 00 00 00       	jmp    2ab4 <print_stat+0x466>
				else if (m & S_ISGID)
    2a08:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    2a0b:	25 00 04 00 00       	and    eax,0x400
    2a10:	85 c0                	test   eax,eax
    2a12:	74 09                	je     2a1d <print_stat+0x3cf>
						fmt = LFMT_SGID;
    2a14:	c6 45 cf e0          	mov    BYTE PTR [rbp-0x31],0xe0
    2a18:	e9 97 00 00 00       	jmp    2ab4 <print_stat+0x466>
				else if (m & S_IXUGO)
    2a1d:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    2a20:	83 e0 49             	and    eax,0x49
    2a23:	85 c0                	test   eax,eax
    2a25:	74 09                	je     2a30 <print_stat+0x3e2>
						fmt = LFMT_EXEC;
    2a27:	c6 45 cf 0a          	mov    BYTE PTR [rbp-0x31],0xa
    2a2b:	e9 84 00 00 00       	jmp    2ab4 <print_stat+0x466>
				else if (in->in_stat.st_nlink > 1)
    2a30:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
    2a37:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    2a3b:	48 83 f8 01          	cmp    rax,0x1
    2a3f:	76 73                	jbe    2ab4 <print_stat+0x466>
						fmt = LFMT_MH;
    2a41:	c6 45 cf 0f          	mov    BYTE PTR [rbp-0x31],0xf
    2a45:	eb 6d                	jmp    2ab4 <print_stat+0x466>
		} else if (S_ISLNK(m))
    2a47:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    2a4a:	25 00 f0 00 00       	and    eax,0xf000
    2a4f:	3d 00 a0 00 00       	cmp    eax,0xa000
    2a54:	75 06                	jne    2a5c <print_stat+0x40e>
				fmt = LFMT_LNK;
    2a56:	c6 45 cf 0b          	mov    BYTE PTR [rbp-0x31],0xb
    2a5a:	eb 58                	jmp    2ab4 <print_stat+0x466>
		else if (S_ISFIFO(m))
    2a5c:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    2a5f:	25 00 f0 00 00       	and    eax,0xf000
    2a64:	3d 00 10 00 00       	cmp    eax,0x1000
    2a69:	75 06                	jne    2a71 <print_stat+0x423>
				fmt = LFMT_PIPE;
    2a6b:	c6 45 cf 06          	mov    BYTE PTR [rbp-0x31],0x6
    2a6f:	eb 43                	jmp    2ab4 <print_stat+0x466>
		else if (S_ISSOCK(m))
    2a71:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    2a74:	25 00 f0 00 00       	and    eax,0xf000
    2a79:	3d 00 c0 00 00       	cmp    eax,0xc000
    2a7e:	75 06                	jne    2a86 <print_stat+0x438>
				fmt = LFMT_SOCK;
    2a80:	c6 45 cf 0d          	mov    BYTE PTR [rbp-0x31],0xd
    2a84:	eb 2e                	jmp    2ab4 <print_stat+0x466>
		else if (S_ISBLK(m))
    2a86:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    2a89:	25 00 f0 00 00       	and    eax,0xf000
    2a8e:	3d 00 60 00 00       	cmp    eax,0x6000
    2a93:	75 06                	jne    2a9b <print_stat+0x44d>
				fmt = LFMT_BDEV;
    2a95:	c6 45 cf 0e          	mov    BYTE PTR [rbp-0x31],0xe
    2a99:	eb 19                	jmp    2ab4 <print_stat+0x466>
		else if (S_ISCHR(m))
    2a9b:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    2a9e:	25 00 f0 00 00       	and    eax,0xf000
    2aa3:	3d 00 20 00 00       	cmp    eax,0x2000
    2aa8:	75 06                	jne    2ab0 <print_stat+0x462>
				fmt = LFMT_CDEV;
    2aaa:	c6 45 cf 0e          	mov    BYTE PTR [rbp-0x31],0xe
    2aae:	eb 04                	jmp    2ab4 <print_stat+0x466>
		/*else if (S_ISDOOR(m))
				fmt = LFMT_DOOR;*/
		else
				fmt = LFMT_ORPH;
    2ab0:	c6 45 cf 0f          	mov    BYTE PTR [rbp-0x31],0xf
		cprintf(fmt, "%s\n", fn);
    2ab4:	0f be 45 cf          	movsx  eax,BYTE PTR [rbp-0x31]
    2ab8:	48 8b 95 70 ff ff ff 	mov    rdx,QWORD PTR [rbp-0x90]
    2abf:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2ac6:	89 c7                	mov    edi,eax
    2ac8:	b8 00 00 00 00       	mov    eax,0x0
    2acd:	e8 00 00 00 00       	call   2ad2 <print_stat+0x484>
}
    2ad2:	90                   	nop
    2ad3:	48 81 c4 f8 00 00 00 	add    rsp,0xf8
    2ada:	5b                   	pop    rbx
    2adb:	41 5c                	pop    r12
    2add:	41 5d                	pop    r13
    2adf:	41 5e                	pop    r14
    2ae1:	41 5f                	pop    r15
    2ae3:	5d                   	pop    rbp
    2ae4:	c3                   	ret

0000000000002ae5 <path_lookup>:

struct inode* path_lookup(const char* str, char* tk, size_t ntk, int allow_partial)
{
    2ae5:	55                   	push   rbp
    2ae6:	48 89 e5             	mov    rbp,rsp
    2ae9:	48 81 ec 50 01 00 00 	sub    rsp,0x150
    2af0:	48 89 bd c8 fe ff ff 	mov    QWORD PTR [rbp-0x138],rdi
    2af7:	48 89 b5 c0 fe ff ff 	mov    QWORD PTR [rbp-0x140],rsi
    2afe:	48 89 95 b8 fe ff ff 	mov    QWORD PTR [rbp-0x148],rdx
    2b05:	89 8d b4 fe ff ff    	mov    DWORD PTR [rbp-0x14c],ecx
		static char pwd[260] = "/";
		static struct inode* in_pwd = NULL, *in = NULL, *in_prev = NULL;
		char buf[260], *ltk = "", *ctx, *tok;
    2b0b:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		if (!in_pwd)
    2b13:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2b1a <path_lookup+0x35>
    2b1a:	48 85 c0             	test   rax,rax
    2b1d:	75 0e                	jne    2b2d <path_lookup+0x48>
				in_pwd = in_root;
    2b1f:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2b26 <path_lookup+0x41>
    2b26:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2b2d <path_lookup+0x48>
		/* navigate to path */
		strncpy(buf, str, 260);
    2b2d:	48 8b 8d c8 fe ff ff 	mov    rcx,QWORD PTR [rbp-0x138]
    2b34:	48 8d 85 e4 fe ff ff 	lea    rax,[rbp-0x11c]
    2b3b:	ba 04 01 00 00       	mov    edx,0x104
    2b40:	48 89 ce             	mov    rsi,rcx
    2b43:	48 89 c7             	mov    rdi,rax
    2b46:	e8 00 00 00 00       	call   2b4b <path_lookup+0x66>
		buf[260] = '\0';
    2b4b:	c6 45 e8 00          	mov    BYTE PTR [rbp-0x18],0x0
		ltk = tok = strtok_r(buf, "/", &ctx);
    2b4f:	48 8d 95 d8 fe ff ff 	lea    rdx,[rbp-0x128]
    2b56:	48 8d 85 e4 fe ff ff 	lea    rax,[rbp-0x11c]
    2b5d:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2b64:	48 89 c7             	mov    rdi,rax
    2b67:	e8 00 00 00 00       	call   2b6c <path_lookup+0x87>
    2b6c:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
    2b70:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2b74:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		in = ((*str == '/') ? in_root : in_pwd); /* abs or rel */
    2b78:	48 8b 85 c8 fe ff ff 	mov    rax,QWORD PTR [rbp-0x138]
    2b7f:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    2b82:	3c 2f                	cmp    al,0x2f
    2b84:	75 09                	jne    2b8f <path_lookup+0xaa>
    2b86:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2b8d <path_lookup+0xa8>
    2b8d:	eb 07                	jmp    2b96 <path_lookup+0xb1>
    2b8f:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2b96 <path_lookup+0xb1>
    2b96:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2b9d <path_lookup+0xb8>
		in_prev = in;
    2b9d:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2ba4 <path_lookup+0xbf>
    2ba4:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2bab <path_lookup+0xc6>
		while (tok) {
    2bab:	e9 4b 01 00 00       	jmp    2cfb <path_lookup+0x216>
				const struct device_desc* dd;
				dd = get_device(in->in_stat.st_dev);
    2bb0:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2bb7 <path_lookup+0xd2>
    2bb7:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2bba:	48 89 c7             	mov    rdi,rax
    2bbd:	e8 00 00 00 00       	call   2bc2 <path_lookup+0xdd>
    2bc2:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				if (!dd) {
    2bc6:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    2bcb:	75 3c                	jne    2c09 <path_lookup+0x124>
						cprintf(KFMT_WARN, "unable to explore node "
    2bcd:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 2bd3 <path_lookup+0xee>
							"%s at associated device %u is not registered. errno=%d\n",
							tok, (uint32_t)in->in_stat.st_dev, errno);
    2bd3:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2bda <path_lookup+0xf5>
    2bda:	48 8b 00             	mov    rax,QWORD PTR [rax]
						cprintf(KFMT_WARN, "unable to explore node "
    2bdd:	89 c1                	mov    ecx,eax
    2bdf:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2be3:	41 89 d0             	mov    r8d,edx
    2be6:	48 89 c2             	mov    rdx,rax
    2be9:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2bf0:	bf 0e 00 00 00       	mov    edi,0xe
    2bf5:	b8 00 00 00 00       	mov    eax,0x0
    2bfa:	e8 00 00 00 00       	call   2bff <path_lookup+0x11a>
						return NULL;
    2bff:	b8 00 00 00 00       	mov    eax,0x0
    2c04:	e9 43 01 00 00       	jmp    2d4c <path_lookup+0x267>
				}
				ltk = tok;
    2c09:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2c0d:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				in = dd->fn_get_subnode(in, tok);
    2c11:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2c15:	48 8b 48 48          	mov    rcx,QWORD PTR [rax+0x48]
    2c19:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2c20 <path_lookup+0x13b>
    2c20:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    2c24:	48 89 d6             	mov    rsi,rdx
    2c27:	48 89 c7             	mov    rdi,rax
    2c2a:	ff d1                	call   rcx
    2c2c:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2c33 <path_lookup+0x14e>
				if (!in) {
    2c33:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2c3a <path_lookup+0x155>
    2c3a:	48 85 c0             	test   rax,rax
    2c3d:	0f 85 8b 00 00 00    	jne    2cce <path_lookup+0x1e9>
						if (!allow_partial)
    2c43:	83 bd b4 fe ff ff 00 	cmp    DWORD PTR [rbp-0x14c],0x0
    2c4a:	75 3a                	jne    2c86 <path_lookup+0x1a1>
								cprintf(KFMT_WARN, "Failed to locate subnode %s"
    2c4c:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR [rip+0x0]        # 2c52 <path_lookup+0x16d>
    2c52:	48 8b 95 c8 fe ff ff 	mov    rdx,QWORD PTR [rbp-0x138]
    2c59:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2c5d:	41 89 c8             	mov    r8d,ecx
    2c60:	48 89 d1             	mov    rcx,rdx
    2c63:	48 89 c2             	mov    rdx,rax
    2c66:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2c6d:	bf 0e 00 00 00       	mov    edi,0xe
    2c72:	b8 00 00 00 00       	mov    eax,0x0
    2c77:	e8 00 00 00 00       	call   2c7c <path_lookup+0x197>
										strncpy(tk, ltk, ntk);
										tk[ntk - 1] = '\0';
								}
								return in_prev;
						}
						return NULL;
    2c7c:	b8 00 00 00 00       	mov    eax,0x0
    2c81:	e9 c6 00 00 00       	jmp    2d4c <path_lookup+0x267>
								if (tk) {
    2c86:	48 83 bd c0 fe ff ff 00 	cmp    QWORD PTR [rbp-0x140],0x0
    2c8e:	74 35                	je     2cc5 <path_lookup+0x1e0>
										strncpy(tk, ltk, ntk);
    2c90:	48 8b 95 b8 fe ff ff 	mov    rdx,QWORD PTR [rbp-0x148]
    2c97:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    2c9b:	48 8b 85 c0 fe ff ff 	mov    rax,QWORD PTR [rbp-0x140]
    2ca2:	48 89 ce             	mov    rsi,rcx
    2ca5:	48 89 c7             	mov    rdi,rax
    2ca8:	e8 00 00 00 00       	call   2cad <path_lookup+0x1c8>
										tk[ntk - 1] = '\0';
    2cad:	48 8b 85 b8 fe ff ff 	mov    rax,QWORD PTR [rbp-0x148]
    2cb4:	48 8d 50 ff          	lea    rdx,[rax-0x1]
    2cb8:	48 8b 85 c0 fe ff ff 	mov    rax,QWORD PTR [rbp-0x140]
    2cbf:	48 01 d0             	add    rax,rdx
    2cc2:	c6 00 00             	mov    BYTE PTR [rax],0x0
								return in_prev;
    2cc5:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2ccc <path_lookup+0x1e7>
    2ccc:	eb 7e                	jmp    2d4c <path_lookup+0x267>
				} else {
						in_prev = in;
    2cce:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2cd5 <path_lookup+0x1f0>
    2cd5:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2cdc <path_lookup+0x1f7>
				}
				tok = strtok_r(NULL, "/", &ctx);
    2cdc:	48 8d 85 d8 fe ff ff 	lea    rax,[rbp-0x128]
    2ce3:	48 89 c2             	mov    rdx,rax
    2ce6:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2ced:	bf 00 00 00 00       	mov    edi,0x0
    2cf2:	e8 00 00 00 00       	call   2cf7 <path_lookup+0x212>
    2cf7:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		while (tok) {
    2cfb:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
    2d00:	0f 85 aa fe ff ff    	jne    2bb0 <path_lookup+0xcb>
		}
		if (tk) {
    2d06:	48 83 bd c0 fe ff ff 00 	cmp    QWORD PTR [rbp-0x140],0x0
    2d0e:	74 35                	je     2d45 <path_lookup+0x260>
				strncpy(tk, ltk, ntk);
    2d10:	48 8b 95 b8 fe ff ff 	mov    rdx,QWORD PTR [rbp-0x148]
    2d17:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    2d1b:	48 8b 85 c0 fe ff ff 	mov    rax,QWORD PTR [rbp-0x140]
    2d22:	48 89 ce             	mov    rsi,rcx
    2d25:	48 89 c7             	mov    rdi,rax
    2d28:	e8 00 00 00 00       	call   2d2d <path_lookup+0x248>
				tk[ntk - 1] = '\0';
    2d2d:	48 8b 85 b8 fe ff ff 	mov    rax,QWORD PTR [rbp-0x148]
    2d34:	48 8d 50 ff          	lea    rdx,[rax-0x1]
    2d38:	48 8b 85 c0 fe ff ff 	mov    rax,QWORD PTR [rbp-0x140]
    2d3f:	48 01 d0             	add    rax,rdx
    2d42:	c6 00 00             	mov    BYTE PTR [rax],0x0
		}
		return in;
    2d45:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2d4c <path_lookup+0x267>
}
    2d4c:	c9                   	leave
    2d4d:	c3                   	ret

0000000000002d4e <fcli_ls>:

int fcli_ls(const char* str)
{
    2d4e:	55                   	push   rbp
    2d4f:	48 89 e5             	mov    rbp,rsp
    2d52:	48 81 ec 70 01 00 00 	sub    rsp,0x170
    2d59:	48 89 bd 98 fe ff ff 	mov    QWORD PTR [rbp-0x168],rdi
		struct inode* in = NULL; char ltk[40];
    2d60:	48 c7 45 c0 00 00 00 00 	mov    QWORD PTR [rbp-0x40],0x0
		/* ls-like commands */
		str += 3;
    2d68:	48 83 85 98 fe ff ff 03 	add    QWORD PTR [rbp-0x168],0x3
		/* navigate to path */
		in = path_lookup(str, ltk, sizeof(ltk), 0);
    2d70:	48 8d b5 68 ff ff ff 	lea    rsi,[rbp-0x98]
    2d77:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    2d7e:	b9 00 00 00 00       	mov    ecx,0x0
    2d83:	ba 28 00 00 00       	mov    edx,0x28
    2d88:	48 89 c7             	mov    rdi,rax
    2d8b:	e8 00 00 00 00       	call   2d90 <fcli_ls+0x42>
    2d90:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
		if (!in)
    2d94:	48 83 7d c0 00       	cmp    QWORD PTR [rbp-0x40],0x0
    2d99:	75 0a                	jne    2da5 <fcli_ls+0x57>
				return 1;
    2d9b:	b8 01 00 00 00       	mov    eax,0x1
    2da0:	e9 f5 04 00 00       	jmp    329a <fcli_ls+0x54c>
		/* now do the lookup (default to ls -l) */
		if (S_ISDIR(in->in_stat.st_mode)) {
    2da5:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2da9:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    2dac:	25 00 f0 00 00       	and    eax,0xf000
    2db1:	3d 00 40 00 00       	cmp    eax,0x4000
    2db6:	0f 85 b0 04 00 00    	jne    326c <fcli_ls+0x51e>
				const struct device_desc* dd; int fd;
				/* max and sum of blocks, size, user, gid */
				size_t mb = 0, ms = 0, mu = 0, mg = 0, sb = 0, ss = 0;
    2dbc:	48 c7 85 60 ff ff ff 00 00 00 00 	mov    QWORD PTR [rbp-0xa0],0x0
    2dc7:	48 c7 85 58 ff ff ff 00 00 00 00 	mov    QWORD PTR [rbp-0xa8],0x0
    2dd2:	48 c7 85 50 ff ff ff 00 00 00 00 	mov    QWORD PTR [rbp-0xb0],0x0
    2ddd:	48 c7 85 48 ff ff ff 00 00 00 00 	mov    QWORD PTR [rbp-0xb8],0x0
    2de8:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
    2df0:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
				char buf[128]; size_t nr; int frst = 1;
    2df8:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [rbp-0x14],0x1

				/* open directory for reading */
				dd = get_device(in->in_stat.st_dev);
    2dff:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2e03:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2e06:	48 89 c7             	mov    rdi,rax
    2e09:	e8 00 00 00 00       	call   2e0e <fcli_ls+0xc0>
    2e0e:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
				if (!dd) {
    2e12:	48 83 7d b8 00       	cmp    QWORD PTR [rbp-0x48],0x0
    2e17:	75 24                	jne    2e3d <fcli_ls+0xef>
						printf("unable to obtain device %u associated"
							" with the directory\n", (uint32_t)in->in_stat.st_dev);
    2e19:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2e1d:	48 8b 00             	mov    rax,QWORD PTR [rax]
						printf("unable to obtain device %u associated"
    2e20:	89 c6                	mov    esi,eax
    2e22:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2e29:	b8 00 00 00 00       	mov    eax,0x0
    2e2e:	e8 00 00 00 00       	call   2e33 <fcli_ls+0xe5>
						return 1;
    2e33:	b8 01 00 00 00       	mov    eax,0x1
    2e38:	e9 5d 04 00 00       	jmp    329a <fcli_ls+0x54c>
				}
				fd = dd->fn_open(in, O_RDONLY);
    2e3d:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2e41:	48 8b 50 18          	mov    rdx,QWORD PTR [rax+0x18]
    2e45:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2e49:	be 00 00 00 00       	mov    esi,0x0
    2e4e:	48 89 c7             	mov    rdi,rax
    2e51:	ff d2                	call   rdx
    2e53:	89 45 b4             	mov    DWORD PTR [rbp-0x4c],eax
				if (fd == -1) {
    2e56:	83 7d b4 ff          	cmp    DWORD PTR [rbp-0x4c],0xffffffff
    2e5a:	74 03                	je     2e5f <fcli_ls+0x111>
						printf("unable to access directory for reading: errno=%d\n", errno);
						return 1;
				}
				/* now read the data */
Pos0:
    2e5c:	90                   	nop
    2e5d:	eb 23                	jmp    2e82 <fcli_ls+0x134>
						printf("unable to access directory for reading: errno=%d\n", errno);
    2e5f:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2e65 <fcli_ls+0x117>
    2e65:	89 c6                	mov    esi,eax
    2e67:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2e6e:	b8 00 00 00 00       	mov    eax,0x0
    2e73:	e8 00 00 00 00       	call   2e78 <fcli_ls+0x12a>
						return 1;
    2e78:	b8 01 00 00 00       	mov    eax,0x1
    2e7d:	e9 18 04 00 00       	jmp    329a <fcli_ls+0x54c>
				if (!frst) {
    2e82:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
    2e86:	0f 85 f7 00 00 00    	jne    2f83 <fcli_ls+0x235>
						size_t im; size_t* arr[] = { &mb, &ms, &mu, &mg };
    2e8c:	48 8d 85 60 ff ff ff 	lea    rax,[rbp-0xa0]
    2e93:	48 89 85 a8 fe ff ff 	mov    QWORD PTR [rbp-0x158],rax
    2e9a:	48 8d 85 58 ff ff ff 	lea    rax,[rbp-0xa8]
    2ea1:	48 89 85 b0 fe ff ff 	mov    QWORD PTR [rbp-0x150],rax
    2ea8:	48 8d 85 50 ff ff ff 	lea    rax,[rbp-0xb0]
    2eaf:	48 89 85 b8 fe ff ff 	mov    QWORD PTR [rbp-0x148],rax
    2eb6:	48 8d 85 48 ff ff ff 	lea    rax,[rbp-0xb8]
    2ebd:	48 89 85 c0 fe ff ff 	mov    QWORD PTR [rbp-0x140],rax
						/* calculate the capacites */
						for (size_t** p = &arr[0]; p <= &arr[3]; p++) {
    2ec4:	48 8d 85 a8 fe ff ff 	lea    rax,[rbp-0x158]
    2ecb:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
    2ecf:	eb 55                	jmp    2f26 <fcli_ls+0x1d8>
								im = 1;
    2ed1:	48 c7 45 e0 01 00 00 00 	mov    QWORD PTR [rbp-0x20],0x1
								while ((**p /= 10))
    2ed9:	eb 05                	jmp    2ee0 <fcli_ls+0x192>
										im++;
    2edb:	48 83 45 e0 01       	add    QWORD PTR [rbp-0x20],0x1
								while ((**p /= 10))
    2ee0:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2ee4:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2ee7:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    2eea:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2eee:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    2ef1:	48 be cd cc cc cc cc cc cc cc 	movabs rsi,0xcccccccccccccccd
    2efb:	48 89 d0             	mov    rax,rdx
    2efe:	48 f7 e6             	mul    rsi
    2f01:	48 89 d0             	mov    rax,rdx
    2f04:	48 c1 e8 03          	shr    rax,0x3
    2f08:	48 89 01             	mov    QWORD PTR [rcx],rax
    2f0b:	48 8b 01             	mov    rax,QWORD PTR [rcx]
    2f0e:	48 85 c0             	test   rax,rax
    2f11:	75 c8                	jne    2edb <fcli_ls+0x18d>
								**p = im;
    2f13:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2f17:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2f1a:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    2f1e:	48 89 10             	mov    QWORD PTR [rax],rdx
						for (size_t** p = &arr[0]; p <= &arr[3]; p++) {
    2f21:	48 83 45 d8 08       	add    QWORD PTR [rbp-0x28],0x8
    2f26:	48 8d 85 a8 fe ff ff 	lea    rax,[rbp-0x158]
    2f2d:	48 83 c0 18          	add    rax,0x18
    2f31:	48 3b 45 d8          	cmp    rax,QWORD PTR [rbp-0x28]
    2f35:	73 9a                	jae    2ed1 <fcli_ls+0x183>
						}
						if (dd->fn_lseek(in, fd, 0, SEEK_SET) != 0) {
    2f37:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2f3b:	4c 8b 40 38          	mov    r8,QWORD PTR [rax+0x38]
    2f3f:	8b 75 b4             	mov    esi,DWORD PTR [rbp-0x4c]
    2f42:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2f46:	b9 00 00 00 00       	mov    ecx,0x0
    2f4b:	ba 00 00 00 00       	mov    edx,0x0
    2f50:	48 89 c7             	mov    rdi,rax
    2f53:	41 ff d0             	call   r8
    2f56:	48 85 c0             	test   rax,rax
    2f59:	74 28                	je     2f83 <fcli_ls+0x235>
								cprintf(KFMT_ERROR, "failed to seek to start"
    2f5b:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2f61 <fcli_ls+0x213>
    2f61:	89 c2                	mov    edx,eax
    2f63:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2f6a:	bf 0c 00 00 00       	mov    edi,0xc
    2f6f:	b8 00 00 00 00       	mov    eax,0x0
    2f74:	e8 00 00 00 00       	call   2f79 <fcli_ls+0x22b>
									" of directory file. errno=%d\n", errno);
								return 1;
    2f79:	b8 01 00 00 00       	mov    eax,0x1
						return 1;
    2f7e:	e9 17 03 00 00       	jmp    329a <fcli_ls+0x54c>
						}
				}
				do {
						char* fn = buf, *fn_prev; size_t s;
    2f83:	48 8d 85 c8 fe ff ff 	lea    rax,[rbp-0x138]
    2f8a:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
						nr = dd->fn_read(in, fd, buf, sizeof(buf) - 1);
    2f8e:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2f92:	4c 8b 40 20          	mov    r8,QWORD PTR [rax+0x20]
    2f96:	48 8d 95 c8 fe ff ff 	lea    rdx,[rbp-0x138]
    2f9d:	8b 75 b4             	mov    esi,DWORD PTR [rbp-0x4c]
    2fa0:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2fa4:	b9 7f 00 00 00       	mov    ecx,0x7f
    2fa9:	48 89 c7             	mov    rdi,rax
    2fac:	41 ff d0             	call   r8
    2faf:	48 98                	cdqe
    2fb1:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
						buf[nr] = '\0';
    2fb5:	48 8d 95 c8 fe ff ff 	lea    rdx,[rbp-0x138]
    2fbc:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2fc0:	48 01 d0             	add    rax,rdx
    2fc3:	c6 00 00             	mov    BYTE PTR [rax],0x0
						while ((s = strlen(fn))) {
    2fc6:	e9 0f 02 00 00       	jmp    31da <fcli_ls+0x48c>
								struct inode* in1;
Pos1:
								if (fn + s + 1 + sizeof(struct inode*) > buf + sizeof(buf)) {
    2fcb:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    2fcf:	48 8d 50 09          	lea    rdx,[rax+0x9]
    2fd3:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    2fd7:	48 01 c2             	add    rdx,rax
    2fda:	48 8d 85 c8 fe ff ff 	lea    rax,[rbp-0x138]
    2fe1:	48 83 e8 80          	sub    rax,0xffffffffffffff80
    2fe5:	48 39 d0             	cmp    rax,rdx
    2fe8:	0f 83 ad 00 00 00    	jae    309b <fcli_ls+0x34d>
										/* data spans, try lseek */
										off_t sk = sizeof(buf) - (fn - buf);
    2fee:	48 8d 85 c8 fe ff ff 	lea    rax,[rbp-0x138]
    2ff5:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    2ff9:	48 29 c2             	sub    rdx,rax
    2ffc:	b8 80 00 00 00       	mov    eax,0x80
    3001:	48 29 d0             	sub    rax,rdx
    3004:	48 89 45 90          	mov    QWORD PTR [rbp-0x70],rax
										if (sk == -sizeof(buf)) {
    3008:	48 83 7d 90 80       	cmp    QWORD PTR [rbp-0x70],0xffffffffffffff80
    300d:	75 20                	jne    302f <fcli_ls+0x2e1>
												cprintf(KFMT_ERROR, "fn too long for intermediate buffer\n");
    300f:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3016:	bf 0c 00 00 00       	mov    edi,0xc
    301b:	b8 00 00 00 00       	mov    eax,0x0
    3020:	e8 00 00 00 00       	call   3025 <fcli_ls+0x2d7>
												return 1;
    3025:	b8 01 00 00 00       	mov    eax,0x1
    302a:	e9 6b 02 00 00       	jmp    329a <fcli_ls+0x54c>
										}
										if (-1 == dd->fn_lseek(in, fd, sk, SEEK_CUR)) {
    302f:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    3033:	4c 8b 40 38          	mov    r8,QWORD PTR [rax+0x38]
    3037:	48 8b 55 90          	mov    rdx,QWORD PTR [rbp-0x70]
    303b:	8b 75 b4             	mov    esi,DWORD PTR [rbp-0x4c]
    303e:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    3042:	b9 01 00 00 00       	mov    ecx,0x1
    3047:	48 89 c7             	mov    rdi,rax
    304a:	41 ff d0             	call   r8
    304d:	48 83 f8 ff          	cmp    rax,0xffffffffffffffff
    3051:	75 28                	jne    307b <fcli_ls+0x32d>
												cprintf(KFMT_WARN, "unable to seek on directory file for ls. errno=%d\n", errno);
    3053:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3059 <fcli_ls+0x30b>
    3059:	89 c2                	mov    edx,eax
    305b:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3062:	bf 0e 00 00 00       	mov    edi,0xe
    3067:	b8 00 00 00 00       	mov    eax,0x0
    306c:	e8 00 00 00 00       	call   3071 <fcli_ls+0x323>
												return 1;
    3071:	b8 01 00 00 00       	mov    eax,0x1
    3076:	e9 1f 02 00 00       	jmp    329a <fcli_ls+0x54c>
										}
										fn = buf;
    307b:	48 8d 85 c8 fe ff ff 	lea    rax,[rbp-0x138]
    3082:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
										s = strlen(fn);
    3086:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    308a:	48 89 c7             	mov    rdi,rax
    308d:	e8 00 00 00 00       	call   3092 <fcli_ls+0x344>
    3092:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
										goto Pos1;
    3096:	e9 30 ff ff ff       	jmp    2fcb <fcli_ls+0x27d>
								}
								fn_prev = fn;
    309b:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    309f:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
								fn += s + 1;
    30a3:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    30a7:	48 83 c0 01          	add    rax,0x1
    30ab:	48 01 45 d0          	add    QWORD PTR [rbp-0x30],rax
								in1 = *(struct inode**)fn;
    30af:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    30b3:	48 8b 00             	mov    rax,QWORD PTR [rax]
    30b6:	48 89 45 98          	mov    QWORD PTR [rbp-0x68],rax
								fn += sizeof(struct inode*);
    30ba:	48 83 45 d0 08       	add    QWORD PTR [rbp-0x30],0x8
								if (!in1) {
    30bf:	48 83 7d 98 00       	cmp    QWORD PTR [rbp-0x68],0x0
    30c4:	75 22                	jne    30e8 <fcli_ls+0x39a>
										cprintf(KFMT_WARN, "inode of %s missing\n", fn_prev);
    30c6:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    30ca:	48 89 c2             	mov    rdx,rax
    30cd:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    30d4:	bf 0e 00 00 00       	mov    edi,0xe
    30d9:	b8 00 00 00 00       	mov    eax,0x0
    30de:	e8 00 00 00 00       	call   30e3 <fcli_ls+0x395>
    30e3:	e9 f2 00 00 00       	jmp    31da <fcli_ls+0x48c>
								} else if (frst) {
    30e8:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
    30ec:	0f 84 ad 00 00 00    	je     319f <fcli_ls+0x451>
										if (in1->in_stat.st_nlink > mb)
    30f2:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    30f6:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    30fa:	48 8b 95 60 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xa0]
    3101:	48 39 c2             	cmp    rdx,rax
    3104:	73 0f                	jae    3115 <fcli_ls+0x3c7>
												mb = in1->in_stat.st_nlink;
    3106:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    310a:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    310e:	48 89 85 60 ff ff ff 	mov    QWORD PTR [rbp-0xa0],rax
										if (in1->in_stat.st_size > ms)
    3115:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    3119:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
    311d:	48 89 c2             	mov    rdx,rax
    3120:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    3127:	48 39 d0             	cmp    rax,rdx
    312a:	73 0f                	jae    313b <fcli_ls+0x3ed>
												ms = in1->in_stat.st_size;
    312c:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    3130:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
    3134:	48 89 85 58 ff ff ff 	mov    QWORD PTR [rbp-0xa8],rax
										if (in1->in_stat.st_uid > mu)
    313b:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    313f:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    3142:	89 c2                	mov    edx,eax
    3144:	48 8b 85 50 ff ff ff 	mov    rax,QWORD PTR [rbp-0xb0]
    314b:	48 39 d0             	cmp    rax,rdx
    314e:	73 10                	jae    3160 <fcli_ls+0x412>
												mu = in1->in_stat.st_uid;
    3150:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    3154:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    3157:	89 c0                	mov    eax,eax
    3159:	48 89 85 50 ff ff ff 	mov    QWORD PTR [rbp-0xb0],rax
										if (in1->in_stat.st_gid > mg)
    3160:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    3164:	8b 40 24             	mov    eax,DWORD PTR [rax+0x24]
    3167:	89 c2                	mov    edx,eax
    3169:	48 8b 85 48 ff ff ff 	mov    rax,QWORD PTR [rbp-0xb8]
    3170:	48 39 d0             	cmp    rax,rdx
    3173:	73 10                	jae    3185 <fcli_ls+0x437>
												mg = in1->in_stat.st_gid;
    3175:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    3179:	8b 40 24             	mov    eax,DWORD PTR [rax+0x24]
    317c:	89 c0                	mov    eax,eax
    317e:	48 89 85 48 ff ff ff 	mov    QWORD PTR [rbp-0xb8],rax
										sb += in1->in_stat.st_blocks;
    3185:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    3189:	48 8b 40 40          	mov    rax,QWORD PTR [rax+0x40]
    318d:	48 01 45 f8          	add    QWORD PTR [rbp-0x8],rax
										ss += in1->in_stat.st_size;
    3191:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    3195:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
    3199:	48 01 45 f0          	add    QWORD PTR [rbp-0x10],rax
    319d:	eb 3b                	jmp    31da <fcli_ls+0x48c>
								} else {
										/* do the printing */
										print_stat(in1, fn_prev, mb, mu, mg, ms);
    319f:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    31a6:	41 89 c0             	mov    r8d,eax
    31a9:	48 8b 85 48 ff ff ff 	mov    rax,QWORD PTR [rbp-0xb8]
    31b0:	89 c7                	mov    edi,eax
    31b2:	48 8b 85 50 ff ff ff 	mov    rax,QWORD PTR [rbp-0xb0]
    31b9:	89 c1                	mov    ecx,eax
    31bb:	48 8b 85 60 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa0]
    31c2:	89 c2                	mov    edx,eax
    31c4:	48 8b 75 a0          	mov    rsi,QWORD PTR [rbp-0x60]
    31c8:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    31cc:	45 89 c1             	mov    r9d,r8d
    31cf:	41 89 f8             	mov    r8d,edi
    31d2:	48 89 c7             	mov    rdi,rax
    31d5:	e8 00 00 00 00       	call   31da <fcli_ls+0x48c>
						while ((s = strlen(fn))) {
    31da:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    31de:	48 89 c7             	mov    rdi,rax
    31e1:	e8 00 00 00 00       	call   31e6 <fcli_ls+0x498>
    31e6:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
    31ea:	48 83 7d c8 00       	cmp    QWORD PTR [rbp-0x38],0x0
    31ef:	74 06                	je     31f7 <fcli_ls+0x4a9>
Pos1:
    31f1:	90                   	nop
    31f2:	e9 d4 fd ff ff       	jmp    2fcb <fcli_ls+0x27d>
								}
						}
				} while (nr);
    31f7:	48 83 7d a8 00       	cmp    QWORD PTR [rbp-0x58],0x0
    31fc:	0f 85 81 fd ff ff    	jne    2f83 <fcli_ls+0x235>
				if (frst) {
    3202:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
    3206:	74 24                	je     322c <fcli_ls+0x4de>
						printf("total %lu\n", sb);
    3208:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    320c:	48 89 c6             	mov    rsi,rax
    320f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3216:	b8 00 00 00 00       	mov    eax,0x0
    321b:	e8 00 00 00 00       	call   3220 <fcli_ls+0x4d2>
						frst = 0;
    3220:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [rbp-0x14],0x0
						goto Pos0;
    3227:	e9 56 fc ff ff       	jmp    2e82 <fcli_ls+0x134>
				}
				/* TODO: use dirent to not pollute space */
				if (-1 == dd->fn_close(in, fd)) {
    322c:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    3230:	48 8b 48 30          	mov    rcx,QWORD PTR [rax+0x30]
    3234:	8b 55 b4             	mov    edx,DWORD PTR [rbp-0x4c]
    3237:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    323b:	89 d6                	mov    esi,edx
    323d:	48 89 c7             	mov    rdi,rax
    3240:	ff d1                	call   rcx
    3242:	83 f8 ff             	cmp    eax,0xffffffff
    3245:	75 4e                	jne    3295 <fcli_ls+0x547>
						cprintf(KFMT_WARN, "failed to close fd %d to"
    3247:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 324d <fcli_ls+0x4ff>
    324d:	8b 45 b4             	mov    eax,DWORD PTR [rbp-0x4c]
    3250:	89 d1                	mov    ecx,edx
    3252:	89 c2                	mov    edx,eax
    3254:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    325b:	bf 0e 00 00 00       	mov    edi,0xe
    3260:	b8 00 00 00 00       	mov    eax,0x0
    3265:	e8 00 00 00 00       	call   326a <fcli_ls+0x51c>
    326a:	eb 29                	jmp    3295 <fcli_ls+0x547>
							" directory file open for reading. errno=%d\n", fd, errno);
				}
		} else
			   print_stat(in, ltk, 0, 0, 0, 0);
    326c:	48 8d b5 68 ff ff ff 	lea    rsi,[rbp-0x98]
    3273:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    3277:	41 b9 00 00 00 00    	mov    r9d,0x0
    327d:	41 b8 00 00 00 00    	mov    r8d,0x0
    3283:	b9 00 00 00 00       	mov    ecx,0x0
    3288:	ba 00 00 00 00       	mov    edx,0x0
    328d:	48 89 c7             	mov    rdi,rax
    3290:	e8 00 00 00 00       	call   3295 <fcli_ls+0x547>
		return 1;
    3295:	b8 01 00 00 00       	mov    eax,0x1
}
    329a:	c9                   	leave
    329b:	c3                   	ret

000000000000329c <fcli_cat>:

int fcli_cat(const char* str)
{
    329c:	55                   	push   rbp
    329d:	48 89 e5             	mov    rbp,rsp
    32a0:	48 81 ec a0 00 00 00 	sub    rsp,0xa0
    32a7:	48 89 bd 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rdi
		struct inode* in = NULL; char ltk[40];
    32ae:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		/* cat-like commands */
		str += 4;
    32b6:	48 83 85 68 ff ff ff 04 	add    QWORD PTR [rbp-0x98],0x4
		/* navigate to path */
		in = path_lookup(str, ltk, sizeof(ltk), 0);
    32be:	48 8d 75 b0          	lea    rsi,[rbp-0x50]
    32c2:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
    32c9:	b9 00 00 00 00       	mov    ecx,0x0
    32ce:	ba 28 00 00 00       	mov    edx,0x28
    32d3:	48 89 c7             	mov    rdi,rax
    32d6:	e8 00 00 00 00       	call   32db <fcli_cat+0x3f>
    32db:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		if (!in)
    32df:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
    32e4:	75 0a                	jne    32f0 <fcli_cat+0x54>
				return 1;
    32e6:	b8 01 00 00 00       	mov    eax,0x1
    32eb:	e9 7f 01 00 00       	jmp    346f <fcli_cat+0x1d3>

		/* read the file */
		const struct device_desc* dd; int fd; size_t nr;
		dd = get_device(in->in_stat.st_dev);
    32f0:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    32f4:	48 8b 00             	mov    rax,QWORD PTR [rax]
    32f7:	48 89 c7             	mov    rdi,rax
    32fa:	e8 00 00 00 00       	call   32ff <fcli_cat+0x63>
    32ff:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		if (!dd) {
    3303:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    3308:	75 23                	jne    332d <fcli_cat+0x91>
				printf("device error: errno=%d\n", errno);
    330a:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3310 <fcli_cat+0x74>
    3310:	89 c6                	mov    esi,eax
    3312:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3319:	b8 00 00 00 00       	mov    eax,0x0
    331e:	e8 00 00 00 00       	call   3323 <fcli_cat+0x87>
				return 1;
    3323:	b8 01 00 00 00       	mov    eax,0x1
    3328:	e9 42 01 00 00       	jmp    346f <fcli_cat+0x1d3>
		}
		fd = dd->fn_open(in, O_RDONLY);
    332d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    3331:	48 8b 50 18          	mov    rdx,QWORD PTR [rax+0x18]
    3335:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3339:	be 00 00 00 00       	mov    esi,0x0
    333e:	48 89 c7             	mov    rdi,rax
    3341:	ff d2                	call   rdx
    3343:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
		if (fd == -1) {
    3346:	83 7d e4 ff          	cmp    DWORD PTR [rbp-0x1c],0xffffffff
    334a:	75 25                	jne    3371 <fcli_cat+0xd5>
				printf("cannot open file %s\n", str);
    334c:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
    3353:	48 89 c6             	mov    rsi,rax
    3356:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    335d:	b8 00 00 00 00       	mov    eax,0x0
    3362:	e8 00 00 00 00       	call   3367 <fcli_cat+0xcb>
				return 1;
    3367:	b8 01 00 00 00       	mov    eax,0x1
    336c:	e9 fe 00 00 00       	jmp    346f <fcli_cat+0x1d3>
		}
		printf("cat: size=%lld\n", in->in_stat.st_size);
    3371:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3375:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
    3379:	48 89 c6             	mov    rsi,rax
    337c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3383:	b8 00 00 00 00       	mov    eax,0x0
    3388:	e8 00 00 00 00       	call   338d <fcli_cat+0xf1>
		do {
				char buf[61];
				nr = dd->fn_read(in, fd, buf, sizeof(buf) - 1);
    338d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    3391:	4c 8b 40 20          	mov    r8,QWORD PTR [rax+0x20]
    3395:	48 8d 95 73 ff ff ff 	lea    rdx,[rbp-0x8d]
    339c:	8b 75 e4             	mov    esi,DWORD PTR [rbp-0x1c]
    339f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    33a3:	b9 3c 00 00 00       	mov    ecx,0x3c
    33a8:	48 89 c7             	mov    rdi,rax
    33ab:	41 ff d0             	call   r8
    33ae:	48 98                	cdqe
    33b0:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
				buf[nr] = '\0';
    33b4:	48 8d 95 73 ff ff ff 	lea    rdx,[rbp-0x8d]
    33bb:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    33bf:	48 01 d0             	add    rax,rdx
    33c2:	c6 00 00             	mov    BYTE PTR [rax],0x0
				if (nr) {
    33c5:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
    33ca:	74 60                	je     342c <fcli_cat+0x190>
						char* c = buf;
    33cc:	48 8d 85 73 ff ff ff 	lea    rax,[rbp-0x8d]
    33d3:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						while (c < buf + nr)
    33d7:	eb 3f                	jmp    3418 <fcli_cat+0x17c>
								if (isprint(*c))
    33d9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    33dd:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    33e0:	0f be c0             	movsx  eax,al
    33e3:	89 c7                	mov    edi,eax
    33e5:	e8 00 00 00 00       	call   33ea <fcli_cat+0x14e>
    33ea:	85 c0                	test   eax,eax
    33ec:	74 1b                	je     3409 <fcli_cat+0x16d>
										putchar(*c++);
    33ee:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    33f2:	48 8d 50 01          	lea    rdx,[rax+0x1]
    33f6:	48 89 55 f8          	mov    QWORD PTR [rbp-0x8],rdx
    33fa:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    33fd:	0f be c0             	movsx  eax,al
    3400:	89 c7                	mov    edi,eax
    3402:	e8 00 00 00 00       	call   3407 <fcli_cat+0x16b>
    3407:	eb 0f                	jmp    3418 <fcli_cat+0x17c>
								else {
										putchar('.');
    3409:	bf 2e 00 00 00       	mov    edi,0x2e
    340e:	e8 00 00 00 00       	call   3413 <fcli_cat+0x177>
										c++;
    3413:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
						while (c < buf + nr)
    3418:	48 8d 95 73 ff ff ff 	lea    rdx,[rbp-0x8d]
    341f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3423:	48 01 d0             	add    rax,rdx
    3426:	48 39 45 f8          	cmp    QWORD PTR [rbp-0x8],rax
    342a:	72 ad                	jb     33d9 <fcli_cat+0x13d>
								}
				}
		} while (nr);
    342c:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
    3431:	0f 85 56 ff ff ff    	jne    338d <fcli_cat+0xf1>
		if (-1 == dd->fn_close(in, fd))
    3437:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    343b:	48 8b 48 30          	mov    rcx,QWORD PTR [rax+0x30]
    343f:	8b 55 e4             	mov    edx,DWORD PTR [rbp-0x1c]
    3442:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3446:	89 d6                	mov    esi,edx
    3448:	48 89 c7             	mov    rdi,rax
    344b:	ff d1                	call   rcx
    344d:	83 f8 ff             	cmp    eax,0xffffffff
    3450:	75 07                	jne    3459 <fcli_cat+0x1bd>
				return 1;
    3452:	b8 01 00 00 00       	mov    eax,0x1
    3457:	eb 16                	jmp    346f <fcli_cat+0x1d3>
		printf("\n");
    3459:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3460:	b8 00 00 00 00       	mov    eax,0x0
    3465:	e8 00 00 00 00       	call   346a <fcli_cat+0x1ce>
		return 1;
    346a:	b8 01 00 00 00       	mov    eax,0x1
}
    346f:	c9                   	leave
    3470:	c3                   	ret

0000000000003471 <fcli_mkdir>:

int fcli_mkdir(const char* str)
{
    3471:	55                   	push   rbp
    3472:	48 89 e5             	mov    rbp,rsp
    3475:	48 81 ec e0 00 00 00 	sub    rsp,0xe0
    347c:	48 89 bd 28 ff ff ff 	mov    QWORD PTR [rbp-0xd8],rdi
		struct inode* in; char ltk[40];
		const char* oc;
		if (str[2] == ' ')
    3483:	48 8b 85 28 ff ff ff 	mov    rax,QWORD PTR [rbp-0xd8]
    348a:	48 83 c0 02          	add    rax,0x2
    348e:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    3491:	3c 20                	cmp    al,0x20
    3493:	75 0a                	jne    349f <fcli_mkdir+0x2e>
				str += 3;
    3495:	48 83 85 28 ff ff ff 03 	add    QWORD PTR [rbp-0xd8],0x3
    349d:	eb 08                	jmp    34a7 <fcli_mkdir+0x36>
		else
				str += 6;
    349f:	48 83 85 28 ff ff ff 06 	add    QWORD PTR [rbp-0xd8],0x6
		in = path_lookup(str, ltk, sizeof(ltk), 1);
    34a7:	48 8d 75 c0          	lea    rsi,[rbp-0x40]
    34ab:	48 8b 85 28 ff ff ff 	mov    rax,QWORD PTR [rbp-0xd8]
    34b2:	b9 01 00 00 00       	mov    ecx,0x1
    34b7:	ba 28 00 00 00       	mov    edx,0x28
    34bc:	48 89 c7             	mov    rdi,rax
    34bf:	e8 00 00 00 00       	call   34c4 <fcli_mkdir+0x53>
    34c4:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (!in)
    34c8:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    34cd:	75 0a                	jne    34d9 <fcli_mkdir+0x68>
				return 0;
    34cf:	b8 00 00 00 00       	mov    eax,0x0
    34d4:	e9 67 01 00 00       	jmp    3640 <fcli_mkdir+0x1cf>
		oc = strstr(str, ltk);
    34d9:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
    34dd:	48 8b 85 28 ff ff ff 	mov    rax,QWORD PTR [rbp-0xd8]
    34e4:	48 89 d6             	mov    rsi,rdx
    34e7:	48 89 c7             	mov    rdi,rax
    34ea:	e8 00 00 00 00       	call   34ef <fcli_mkdir+0x7e>
    34ef:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		if (strchr(oc, '/'))
    34f3:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    34f7:	be 2f 00 00 00       	mov    esi,0x2f
    34fc:	48 89 c7             	mov    rdi,rax
    34ff:	e8 00 00 00 00       	call   3504 <fcli_mkdir+0x93>
    3504:	48 85 c0             	test   rax,rax
    3507:	74 29                	je     3532 <fcli_mkdir+0xc1>
				printf("mkdir: cannot create directory '%s': no such file or directory (%s missing)\n", str, ltk);
    3509:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
    350d:	48 8b 85 28 ff ff ff 	mov    rax,QWORD PTR [rbp-0xd8]
    3514:	48 89 c6             	mov    rsi,rax
    3517:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    351e:	b8 00 00 00 00       	mov    eax,0x0
    3523:	e8 00 00 00 00       	call   3528 <fcli_mkdir+0xb7>
						return 1;
				} else
						printf("created '%s' at '%*s'\n", ltk, (int)(oc - str), str);
				return 1;
		}
		return 1;
    3528:	b8 01 00 00 00       	mov    eax,0x1
    352d:	e9 0e 01 00 00       	jmp    3640 <fcli_mkdir+0x1cf>
				dd = get_device(in->in_stat.st_dev);
    3532:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3536:	48 8b 00             	mov    rax,QWORD PTR [rax]
    3539:	48 89 c7             	mov    rdi,rax
    353c:	e8 00 00 00 00       	call   3541 <fcli_mkdir+0xd0>
    3541:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				if (!dd) {
    3545:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    354a:	75 2d                	jne    3579 <fcli_mkdir+0x108>
								"with node '%s'\n", (uint32_t)in->in_stat.st_dev, ltk);
    354c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3550:	48 8b 00             	mov    rax,QWORD PTR [rax]
						printf("unable to obtain device %u associated"
    3553:	89 c1                	mov    ecx,eax
    3555:	48 8d 45 c0          	lea    rax,[rbp-0x40]
    3559:	48 89 c2             	mov    rdx,rax
    355c:	89 ce                	mov    esi,ecx
    355e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3565:	b8 00 00 00 00       	mov    eax,0x0
    356a:	e8 00 00 00 00       	call   356f <fcli_mkdir+0xfe>
						return 1;
    356f:	b8 01 00 00 00       	mov    eax,0x1
    3574:	e9 c7 00 00 00       	jmp    3640 <fcli_mkdir+0x1cf>
				if (dd->fn_set_subnode(in, &INO_TMPL_DIR, ltk) != 0) {
    3579:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    357d:	4c 8b 40 50          	mov    r8,QWORD PTR [rax+0x50]
    3581:	48 8d 95 30 ff ff ff 	lea    rdx,[rbp-0xd0]
    3588:	b8 00 00 00 00       	mov    eax,0x0
    358d:	b9 12 00 00 00       	mov    ecx,0x12
    3592:	48 89 d7             	mov    rdi,rdx
    3595:	f3 48 ab             	rep stos QWORD PTR es:[rdi],rax
    3598:	48 c7 85 30 ff ff ff ff ff ff ff 	mov    QWORD PTR [rbp-0xd0],0xffffffffffffffff
    35a3:	c7 85 40 ff ff ff 00 40 00 00 	mov    DWORD PTR [rbp-0xc0],0x4000
    35ad:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
    35b1:	48 8d 8d 30 ff ff ff 	lea    rcx,[rbp-0xd0]
    35b8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    35bc:	48 89 ce             	mov    rsi,rcx
    35bf:	48 89 c7             	mov    rdi,rax
    35c2:	41 ff d0             	call   r8
    35c5:	85 c0                	test   eax,eax
    35c7:	74 41                	je     360a <fcli_mkdir+0x199>
						printf("unable to add directory '%s' to node '%*s': errno=%d\n",
    35c9:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR [rip+0x0]        # 35cf <fcli_mkdir+0x15e>
										ltk, (int)(oc - str), str, errno);
    35cf:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    35d3:	48 2b 85 28 ff ff ff 	sub    rax,QWORD PTR [rbp-0xd8]
						printf("unable to add directory '%s' to node '%*s': errno=%d\n",
    35da:	89 c6                	mov    esi,eax
    35dc:	48 8b 95 28 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xd8]
    35e3:	48 8d 45 c0          	lea    rax,[rbp-0x40]
    35e7:	41 89 c8             	mov    r8d,ecx
    35ea:	48 89 d1             	mov    rcx,rdx
    35ed:	89 f2                	mov    edx,esi
    35ef:	48 89 c6             	mov    rsi,rax
    35f2:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    35f9:	b8 00 00 00 00       	mov    eax,0x0
    35fe:	e8 00 00 00 00       	call   3603 <fcli_mkdir+0x192>
						return 1;
    3603:	b8 01 00 00 00       	mov    eax,0x1
    3608:	eb 36                	jmp    3640 <fcli_mkdir+0x1cf>
						printf("created '%s' at '%*s'\n", ltk, (int)(oc - str), str);
    360a:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    360e:	48 2b 85 28 ff ff ff 	sub    rax,QWORD PTR [rbp-0xd8]
    3615:	89 c6                	mov    esi,eax
    3617:	48 8b 95 28 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xd8]
    361e:	48 8d 45 c0          	lea    rax,[rbp-0x40]
    3622:	48 89 d1             	mov    rcx,rdx
    3625:	89 f2                	mov    edx,esi
    3627:	48 89 c6             	mov    rsi,rax
    362a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3631:	b8 00 00 00 00       	mov    eax,0x0
    3636:	e8 00 00 00 00       	call   363b <fcli_mkdir+0x1ca>
				return 1;
    363b:	b8 01 00 00 00       	mov    eax,0x1
}
    3640:	c9                   	leave
    3641:	c3                   	ret

0000000000003642 <file_cli>:

extern int file_cli(const char* str)
{
    3642:	55                   	push   rbp
    3643:	48 89 e5             	mov    rbp,rsp
    3646:	48 83 ec 10          	sub    rsp,0x10
    364a:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		if (strncmp(str, "ls", 2) == 0 && (!str[2] || str[2] == ' '))
    364e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3652:	ba 02 00 00 00       	mov    edx,0x2
    3657:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    365e:	48 89 c7             	mov    rdi,rax
    3661:	e8 00 00 00 00       	call   3666 <file_cli+0x24>
    3666:	85 c0                	test   eax,eax
    3668:	75 2f                	jne    3699 <file_cli+0x57>
    366a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    366e:	48 83 c0 02          	add    rax,0x2
    3672:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    3675:	84 c0                	test   al,al
    3677:	74 0f                	je     3688 <file_cli+0x46>
    3679:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    367d:	48 83 c0 02          	add    rax,0x2
    3681:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    3684:	3c 20                	cmp    al,0x20
    3686:	75 11                	jne    3699 <file_cli+0x57>
				return fcli_ls(str);
    3688:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    368c:	48 89 c7             	mov    rdi,rax
    368f:	e8 00 00 00 00       	call   3694 <file_cli+0x52>
    3694:	e9 a9 00 00 00       	jmp    3742 <file_cli+0x100>
		else if (strncmp(str, "cat", 3) == 0 && (!str[3] || str[3] == ' '))
    3699:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    369d:	ba 03 00 00 00       	mov    edx,0x3
    36a2:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    36a9:	48 89 c7             	mov    rdi,rax
    36ac:	e8 00 00 00 00       	call   36b1 <file_cli+0x6f>
    36b1:	85 c0                	test   eax,eax
    36b3:	75 42                	jne    36f7 <file_cli+0xb5>
    36b5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    36b9:	48 83 c0 03          	add    rax,0x3
    36bd:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    36c0:	84 c0                	test   al,al
    36c2:	74 0f                	je     36d3 <file_cli+0x91>
    36c4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    36c8:	48 83 c0 03          	add    rax,0x3
    36cc:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    36cf:	3c 20                	cmp    al,0x20
    36d1:	75 24                	jne    36f7 <file_cli+0xb5>
				if (!str[3]) /* stdin */
    36d3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    36d7:	48 83 c0 03          	add    rax,0x3
    36db:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    36de:	84 c0                	test   al,al
    36e0:	75 07                	jne    36e9 <file_cli+0xa7>
						return 0;
    36e2:	b8 00 00 00 00       	mov    eax,0x0
    36e7:	eb 59                	jmp    3742 <file_cli+0x100>
				else
						return fcli_cat(str);
    36e9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    36ed:	48 89 c7             	mov    rdi,rax
    36f0:	e8 00 00 00 00       	call   36f5 <file_cli+0xb3>
    36f5:	eb 4b                	jmp    3742 <file_cli+0x100>
		else if (strncmp(str, "mkdir ", 6) == 0 || strncmp(str, "md ", 3) == 0) {
    36f7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    36fb:	ba 06 00 00 00       	mov    edx,0x6
    3700:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3707:	48 89 c7             	mov    rdi,rax
    370a:	e8 00 00 00 00       	call   370f <file_cli+0xcd>
    370f:	85 c0                	test   eax,eax
    3711:	74 1c                	je     372f <file_cli+0xed>
    3713:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3717:	ba 03 00 00 00       	mov    edx,0x3
    371c:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3723:	48 89 c7             	mov    rdi,rax
    3726:	e8 00 00 00 00       	call   372b <file_cli+0xe9>
    372b:	85 c0                	test   eax,eax
    372d:	75 0e                	jne    373d <file_cli+0xfb>
				return fcli_mkdir(str);
    372f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3733:	48 89 c7             	mov    rdi,rax
    3736:	e8 00 00 00 00       	call   373b <file_cli+0xf9>
    373b:	eb 05                	jmp    3742 <file_cli+0x100>
		} else
				return 0; /* we have not handled the command */
    373d:	b8 00 00 00 00       	mov    eax,0x0
}
    3742:	c9                   	leave
    3743:	c3                   	ret

0000000000003744 <module_cleanup>:

void MODENTRY module_cleanup()
{
    3744:	55                   	push   rbp
    3745:	48 89 e5             	mov    rbp,rsp
		printf("goodbye file.ko\n");
    3748:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    374f:	b8 00 00 00 00       	mov    eax,0x0
    3754:	e8 00 00 00 00       	call   3759 <module_cleanup+0x15>
}
    3759:	90                   	nop
    375a:	5d                   	pop    rbp
    375b:	c3                   	ret
