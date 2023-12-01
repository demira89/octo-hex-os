
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
      5c:	53                   	push   rbx
      5d:	48 83 ec 38          	sub    rsp,0x38
      61:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
		dev_t rv = 0; size_t i = 0;
      65:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
      6d:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
		struct dd_drs* dr = &dr0;
      75:	48 c7 45 d8 00 00 00 00 	mov    QWORD PTR [rbp-0x28],0x0
				if (__sync_bool_compare_and_swap(&dr->descs[i].type, 0, dd->type))
      7d:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
      81:	0f b6 00             	movzx  eax,BYTE PTR [rax]
      84:	0f b6 c8             	movzx  ecx,al
      87:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
      8b:	48 89 d0             	mov    rax,rdx
      8e:	48 c1 e0 03          	shl    rax,0x3
      92:	48 29 d0             	sub    rax,rdx
      95:	48 c1 e0 04          	shl    rax,0x4
      99:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
      9d:	48 01 c2             	add    rdx,rax
      a0:	b8 00 00 00 00       	mov    eax,0x0
      a5:	f0 0f b0 0a          	lock cmpxchg BYTE PTR [rdx],cl
      a9:	0f 94 c0             	sete   al
      ac:	84 c0                	test   al,al
      ae:	0f 85 dc 00 00 00    	jne    190 <register_device+0x138>
				i++; rv++;
      b4:	48 83 45 e0 01       	add    QWORD PTR [rbp-0x20],0x1
      b9:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
				if (i == 8) {
      be:	48 83 7d e0 08       	cmp    QWORD PTR [rbp-0x20],0x8
      c3:	75 b8                	jne    7d <register_device+0x25>
						if (!dr->next) {
      c5:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
      c9:	48 8b 80 80 03 00 00 	mov    rax,QWORD PTR [rax+0x380]
      d0:	48 85 c0             	test   rax,rax
      d3:	0f 85 9b 00 00 00    	jne    174 <register_device+0x11c>
								struct dd_drs* dr2 = kmalloc(sizeof(struct dd_drs));
      d9:	bf 88 03 00 00       	mov    edi,0x388
      de:	e8 00 00 00 00       	call   e3 <register_device+0x8b>
      e3:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
								if (!dr2) {
      e7:	48 83 7d d0 00       	cmp    QWORD PTR [rbp-0x30],0x0
      ec:	75 16                	jne    104 <register_device+0xac>
										errno = ENOMEM;
      ee:	c7 05 00 00 00 00 0c 00 00 00 	mov    DWORD PTR [rip+0x0],0xc        # f8 <register_device+0xa0>
										return INVALID_DEVICE;
      f8:	48 c7 c0 ff ff ff ff 	mov    rax,0xffffffffffffffff
      ff:	e9 57 01 00 00       	jmp    25b <register_device+0x203>
								dr2->next = NULL;
     104:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     108:	48 c7 80 80 03 00 00 00 00 00 00 	mov    QWORD PTR [rax+0x380],0x0
								for (i = 0; i < 8; i++)
     113:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
     11b:	eb 21                	jmp    13e <register_device+0xe6>
										dr2->descs[i].type = 0;
     11d:	48 8b 4d d0          	mov    rcx,QWORD PTR [rbp-0x30]
     121:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     125:	48 89 d0             	mov    rax,rdx
     128:	48 c1 e0 03          	shl    rax,0x3
     12c:	48 29 d0             	sub    rax,rdx
     12f:	48 c1 e0 04          	shl    rax,0x4
     133:	48 01 c8             	add    rax,rcx
     136:	c6 00 00             	mov    BYTE PTR [rax],0x0
								for (i = 0; i < 8; i++)
     139:	48 83 45 e0 01       	add    QWORD PTR [rbp-0x20],0x1
     13e:	48 83 7d e0 07       	cmp    QWORD PTR [rbp-0x20],0x7
     143:	76 d8                	jbe    11d <register_device+0xc5>
								if (!__sync_bool_compare_and_swap(&dr->next, NULL, dr2))
     145:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
     149:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     14d:	48 8d 88 80 03 00 00 	lea    rcx,[rax+0x380]
     154:	b8 00 00 00 00       	mov    eax,0x0
     159:	f0 48 0f b1 11       	lock cmpxchg QWORD PTR [rcx],rdx
     15e:	0f 94 c0             	sete   al
     161:	83 f0 01             	xor    eax,0x1
     164:	84 c0                	test   al,al
     166:	74 0c                	je     174 <register_device+0x11c>
										kfree(dr2); /* someone was faster */
     168:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     16c:	48 89 c7             	mov    rdi,rax
     16f:	e8 00 00 00 00       	call   174 <register_device+0x11c>
						i = 0;
     174:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
						dr = dr->next;
     17c:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     180:	48 8b 80 80 03 00 00 	mov    rax,QWORD PTR [rax+0x380]
     187:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
				if (__sync_bool_compare_and_swap(&dr->descs[i].type, 0, dd->type))
     18b:	e9 ed fe ff ff       	jmp    7d <register_device+0x25>
						break;
     190:	90                   	nop
		dr->descs[i] = *dd;
     191:	48 8b 4d d8          	mov    rcx,QWORD PTR [rbp-0x28]
     195:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     199:	48 89 d0             	mov    rax,rdx
     19c:	48 c1 e0 03          	shl    rax,0x3
     1a0:	48 29 d0             	sub    rax,rdx
     1a3:	48 c1 e0 04          	shl    rax,0x4
     1a7:	48 8d 14 01          	lea    rdx,[rcx+rax*1]
     1ab:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     1af:	48 8b 08             	mov    rcx,QWORD PTR [rax]
     1b2:	48 8b 58 08          	mov    rbx,QWORD PTR [rax+0x8]
     1b6:	48 89 0a             	mov    QWORD PTR [rdx],rcx
     1b9:	48 89 5a 08          	mov    QWORD PTR [rdx+0x8],rbx
     1bd:	48 8b 48 10          	mov    rcx,QWORD PTR [rax+0x10]
     1c1:	48 8b 58 18          	mov    rbx,QWORD PTR [rax+0x18]
     1c5:	48 89 4a 10          	mov    QWORD PTR [rdx+0x10],rcx
     1c9:	48 89 5a 18          	mov    QWORD PTR [rdx+0x18],rbx
     1cd:	48 8b 48 20          	mov    rcx,QWORD PTR [rax+0x20]
     1d1:	48 8b 58 28          	mov    rbx,QWORD PTR [rax+0x28]
     1d5:	48 89 4a 20          	mov    QWORD PTR [rdx+0x20],rcx
     1d9:	48 89 5a 28          	mov    QWORD PTR [rdx+0x28],rbx
     1dd:	48 8b 48 30          	mov    rcx,QWORD PTR [rax+0x30]
     1e1:	48 8b 58 38          	mov    rbx,QWORD PTR [rax+0x38]
     1e5:	48 89 4a 30          	mov    QWORD PTR [rdx+0x30],rcx
     1e9:	48 89 5a 38          	mov    QWORD PTR [rdx+0x38],rbx
     1ed:	48 8b 48 40          	mov    rcx,QWORD PTR [rax+0x40]
     1f1:	48 8b 58 48          	mov    rbx,QWORD PTR [rax+0x48]
     1f5:	48 89 4a 40          	mov    QWORD PTR [rdx+0x40],rcx
     1f9:	48 89 5a 48          	mov    QWORD PTR [rdx+0x48],rbx
     1fd:	48 8b 48 50          	mov    rcx,QWORD PTR [rax+0x50]
     201:	48 8b 58 58          	mov    rbx,QWORD PTR [rax+0x58]
     205:	48 89 4a 50          	mov    QWORD PTR [rdx+0x50],rcx
     209:	48 89 5a 58          	mov    QWORD PTR [rdx+0x58],rbx
     20d:	48 8b 48 60          	mov    rcx,QWORD PTR [rax+0x60]
     211:	48 8b 58 68          	mov    rbx,QWORD PTR [rax+0x68]
     215:	48 89 4a 60          	mov    QWORD PTR [rdx+0x60],rcx
     219:	48 89 5a 68          	mov    QWORD PTR [rdx+0x68],rbx
		if(dd->fn_reg_dev(rv)) {
     21d:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     221:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
     225:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     229:	48 89 c7             	mov    rdi,rax
     22c:	ff d2                	call   rdx
     22e:	85 c0                	test   eax,eax
     230:	74 25                	je     257 <register_device+0x1ff>
				dr->descs[i].type = 0;
     232:	48 8b 4d d8          	mov    rcx,QWORD PTR [rbp-0x28]
     236:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     23a:	48 89 d0             	mov    rax,rdx
     23d:	48 c1 e0 03          	shl    rax,0x3
     241:	48 29 d0             	sub    rax,rdx
     244:	48 c1 e0 04          	shl    rax,0x4
     248:	48 01 c8             	add    rax,rcx
     24b:	c6 00 00             	mov    BYTE PTR [rax],0x0
				return INVALID_DEVICE;
     24e:	48 c7 c0 ff ff ff ff 	mov    rax,0xffffffffffffffff
     255:	eb 04                	jmp    25b <register_device+0x203>
		return rv;
     257:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
}
     25b:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
     25f:	c9                   	leave
     260:	c3                   	ret

0000000000000261 <unregister_device>:
{
     261:	55                   	push   rbp
     262:	48 89 e5             	mov    rbp,rsp
     265:	48 83 ec 20          	sub    rsp,0x20
     269:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		struct dd_drs* dr = &dr0;
     26d:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
				if (dev >= 8) {
     275:	48 83 7d e8 07       	cmp    QWORD PTR [rbp-0x18],0x7
     27a:	76 32                	jbe    2ae <unregister_device+0x4d>
						dr = dr->next;
     27c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     280:	48 8b 80 80 03 00 00 	mov    rax,QWORD PTR [rax+0x380]
     287:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						dr -= 8;
     28b:	48 81 6d f8 40 1c 00 00 	sub    QWORD PTR [rbp-0x8],0x1c40
						if (!dr) {
     293:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     298:	75 db                	jne    275 <unregister_device+0x14>
								errno = EINVAL;
     29a:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # 2a4 <unregister_device+0x43>
								return -1;
     2a4:	b8 ff ff ff ff       	mov    eax,0xffffffff
     2a9:	e9 87 00 00 00       	jmp    335 <unregister_device+0xd4>
						if (!dr->descs[dev].type) {
     2ae:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
     2b2:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     2b6:	48 89 d0             	mov    rax,rdx
     2b9:	48 c1 e0 03          	shl    rax,0x3
     2bd:	48 29 d0             	sub    rax,rdx
     2c0:	48 c1 e0 04          	shl    rax,0x4
     2c4:	48 01 c8             	add    rax,rcx
     2c7:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     2ca:	84 c0                	test   al,al
     2cc:	75 11                	jne    2df <unregister_device+0x7e>
								errno = EINVAL;
     2ce:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # 2d8 <unregister_device+0x77>
								return -1;
     2d8:	b8 ff ff ff ff       	mov    eax,0xffffffff
     2dd:	eb 56                	jmp    335 <unregister_device+0xd4>
						rv = dr->descs[dev].fn_unreg_dev();
     2df:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
     2e3:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     2e7:	48 89 d0             	mov    rax,rdx
     2ea:	48 c1 e0 03          	shl    rax,0x3
     2ee:	48 29 d0             	sub    rax,rdx
     2f1:	48 c1 e0 04          	shl    rax,0x4
     2f5:	48 01 c8             	add    rax,rcx
     2f8:	48 83 c0 10          	add    rax,0x10
     2fc:	48 8b 10             	mov    rdx,QWORD PTR [rax]
     2ff:	b8 00 00 00 00       	mov    eax,0x0
     304:	ff d2                	call   rdx
     306:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
						if (!rv) {
     309:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
     30d:	75 23                	jne    332 <unregister_device+0xd1>
								dr->descs[dev].type = 0;
     30f:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
     313:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     317:	48 89 d0             	mov    rax,rdx
     31a:	48 c1 e0 03          	shl    rax,0x3
     31e:	48 29 d0             	sub    rax,rdx
     321:	48 c1 e0 04          	shl    rax,0x4
     325:	48 01 c8             	add    rax,rcx
     328:	c6 00 00             	mov    BYTE PTR [rax],0x0
								return 0;
     32b:	b8 00 00 00 00       	mov    eax,0x0
     330:	eb 03                	jmp    335 <unregister_device+0xd4>
								return rv;
     332:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
}
     335:	c9                   	leave
     336:	c3                   	ret

0000000000000337 <get_device>:
{
     337:	55                   	push   rbp
     338:	48 89 e5             	mov    rbp,rsp
     33b:	48 83 ec 18          	sub    rsp,0x18
     33f:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		struct dd_drs* dr = &dr0;
     343:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
				if (dev >= 8) {
     34b:	48 83 7d e8 07       	cmp    QWORD PTR [rbp-0x18],0x7
     350:	76 2f                	jbe    381 <get_device+0x4a>
						dr = dr->next;
     352:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     356:	48 8b 80 80 03 00 00 	mov    rax,QWORD PTR [rax+0x380]
     35d:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						dr -= 8;
     361:	48 81 6d f8 40 1c 00 00 	sub    QWORD PTR [rbp-0x8],0x1c40
						if (!dr) {
     369:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     36e:	75 db                	jne    34b <get_device+0x14>
								errno = EINVAL;
     370:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # 37a <get_device+0x43>
								return NULL;
     37a:	b8 00 00 00 00       	mov    eax,0x0
     37f:	eb 40                	jmp    3c1 <get_device+0x8a>
						if (!dr->descs[dev].type)
     381:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
     385:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     389:	48 89 d0             	mov    rax,rdx
     38c:	48 c1 e0 03          	shl    rax,0x3
     390:	48 29 d0             	sub    rax,rdx
     393:	48 c1 e0 04          	shl    rax,0x4
     397:	48 01 c8             	add    rax,rcx
     39a:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     39d:	84 c0                	test   al,al
     39f:	75 07                	jne    3a8 <get_device+0x71>
								return NULL;
     3a1:	b8 00 00 00 00       	mov    eax,0x0
     3a6:	eb 19                	jmp    3c1 <get_device+0x8a>
						return dr->descs + dev;
     3a8:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
     3ac:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     3b0:	48 89 d0             	mov    rax,rdx
     3b3:	48 c1 e0 03          	shl    rax,0x3
     3b7:	48 29 d0             	sub    rax,rdx
     3ba:	48 c1 e0 04          	shl    rax,0x4
     3be:	48 01 c8             	add    rax,rcx
}
     3c1:	c9                   	leave
     3c2:	c3                   	ret

00000000000003c3 <fil_fd_get>:
{
     3c3:	55                   	push   rbp
     3c4:	48 89 e5             	mov    rbp,rsp
     3c7:	48 83 ec 18          	sub    rsp,0x18
     3cb:	89 7d ec             	mov    DWORD PTR [rbp-0x14],edi
		struct fil_fdc* f = &fdc0;
     3ce:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		while (fd >= 64) {
     3d6:	eb 21                	jmp    3f9 <fil_fd_get+0x36>
				fd -= 64;
     3d8:	83 6d ec 40          	sub    DWORD PTR [rbp-0x14],0x40
				f = f->next;
     3dc:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     3e0:	48 8b 80 00 0a 00 00 	mov    rax,QWORD PTR [rax+0xa00]
     3e7:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				if (!f)
     3eb:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     3f0:	75 07                	jne    3f9 <fil_fd_get+0x36>
						return NULL;
     3f2:	b8 00 00 00 00       	mov    eax,0x0
     3f7:	eb 21                	jmp    41a <fil_fd_get+0x57>
		while (fd >= 64) {
     3f9:	83 7d ec 3f          	cmp    DWORD PTR [rbp-0x14],0x3f
     3fd:	7f d9                	jg     3d8 <fil_fd_get+0x15>
		return &f->fds[fd];
     3ff:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     402:	48 63 d0             	movsxd rdx,eax
     405:	48 89 d0             	mov    rax,rdx
     408:	48 c1 e0 02          	shl    rax,0x2
     40c:	48 01 d0             	add    rax,rdx
     40f:	48 c1 e0 03          	shl    rax,0x3
     413:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     417:	48 01 d0             	add    rax,rdx
}
     41a:	c9                   	leave
     41b:	c3                   	ret

000000000000041c <fil_fd_allocate>:
{
     41c:	55                   	push   rbp
     41d:	48 89 e5             	mov    rbp,rsp
     420:	48 83 ec 30          	sub    rsp,0x30
     424:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
     428:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi
		struct fil_fdc* fdc = &fdc0;
     42c:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		int rv = 0; size_t i;
     434:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
				for (i = 0; i < 64; i++) {
     43b:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
     443:	eb 64                	jmp    4a9 <fil_fd_allocate+0x8d>
						if (__sync_bool_compare_and_swap(&fdc->fds[i].in, NULL, in)) {
     445:	48 8b 4d d8          	mov    rcx,QWORD PTR [rbp-0x28]
     449:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     44d:	48 89 d0             	mov    rax,rdx
     450:	48 c1 e0 02          	shl    rax,0x2
     454:	48 01 d0             	add    rax,rdx
     457:	48 c1 e0 03          	shl    rax,0x3
     45b:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     45f:	48 01 c2             	add    rdx,rax
     462:	b8 00 00 00 00       	mov    eax,0x0
     467:	f0 48 0f b1 0a       	lock cmpxchg QWORD PTR [rdx],rcx
     46c:	0f 94 c0             	sete   al
     46f:	84 c0                	test   al,al
     471:	74 31                	je     4a4 <fil_fd_allocate+0x88>
								*pfd = rv + i;
     473:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     477:	89 c2                	mov    edx,eax
     479:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
     47c:	01 d0                	add    eax,edx
     47e:	89 c2                	mov    edx,eax
     480:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     484:	89 10                	mov    DWORD PTR [rax],edx
								return &fdc->fds[i];
     486:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     48a:	48 89 d0             	mov    rax,rdx
     48d:	48 c1 e0 02          	shl    rax,0x2
     491:	48 01 d0             	add    rax,rdx
     494:	48 c1 e0 03          	shl    rax,0x3
     498:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     49c:	48 01 d0             	add    rax,rdx
     49f:	e9 eb 00 00 00       	jmp    58f <fil_fd_allocate+0x173>
				for (i = 0; i < 64; i++) {
     4a4:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
     4a9:	48 83 7d e8 3f       	cmp    QWORD PTR [rbp-0x18],0x3f
     4ae:	76 95                	jbe    445 <fil_fd_allocate+0x29>
				rv += 64;
     4b0:	83 45 f4 40          	add    DWORD PTR [rbp-0xc],0x40
				if (!fdc->next) {
     4b4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     4b8:	48 8b 80 00 0a 00 00 	mov    rax,QWORD PTR [rax+0xa00]
     4bf:	48 85 c0             	test   rax,rax
     4c2:	0f 85 b3 00 00 00    	jne    57b <fil_fd_allocate+0x15f>
						struct fil_fdc* f2 = fdc->next = (struct fil_fdc*)kmalloc(sizeof(struct fil_fdc));
     4c8:	bf 08 0a 00 00       	mov    edi,0xa08
     4cd:	e8 00 00 00 00       	call   4d2 <fil_fd_allocate+0xb6>
     4d2:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     4d6:	48 89 82 00 0a 00 00 	mov    QWORD PTR [rdx+0xa00],rax
     4dd:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     4e1:	48 8b 80 00 0a 00 00 	mov    rax,QWORD PTR [rax+0xa00]
     4e8:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
						if (!f2) {
     4ec:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
     4f1:	75 14                	jne    507 <fil_fd_allocate+0xeb>
								errno = ENOMEM;
     4f3:	c7 05 00 00 00 00 0c 00 00 00 	mov    DWORD PTR [rip+0x0],0xc        # 4fd <fil_fd_allocate+0xe1>
								return NULL;
     4fd:	b8 00 00 00 00       	mov    eax,0x0
     502:	e9 88 00 00 00       	jmp    58f <fil_fd_allocate+0x173>
						f2->next = NULL;
     507:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     50b:	48 c7 80 00 0a 00 00 00 00 00 00 	mov    QWORD PTR [rax+0xa00],0x0
						for (i = 0; i < 64; i++)
     516:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
     51e:	eb 25                	jmp    545 <fil_fd_allocate+0x129>
								f2->fds[i].in = NULL;
     520:	48 8b 4d e0          	mov    rcx,QWORD PTR [rbp-0x20]
     524:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     528:	48 89 d0             	mov    rax,rdx
     52b:	48 c1 e0 02          	shl    rax,0x2
     52f:	48 01 d0             	add    rax,rdx
     532:	48 c1 e0 03          	shl    rax,0x3
     536:	48 01 c8             	add    rax,rcx
     539:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
						for (i = 0; i < 64; i++)
     540:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
     545:	48 83 7d e8 3f       	cmp    QWORD PTR [rbp-0x18],0x3f
     54a:	76 d4                	jbe    520 <fil_fd_allocate+0x104>
						if (!__sync_bool_compare_and_swap(&fdc->next, NULL, f2))
     54c:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     550:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     554:	48 8d 88 00 0a 00 00 	lea    rcx,[rax+0xa00]
     55b:	b8 00 00 00 00       	mov    eax,0x0
     560:	f0 48 0f b1 11       	lock cmpxchg QWORD PTR [rcx],rdx
     565:	0f 94 c0             	sete   al
     568:	83 f0 01             	xor    eax,0x1
     56b:	84 c0                	test   al,al
     56d:	74 0c                	je     57b <fil_fd_allocate+0x15f>
								kfree(f2); /* someone was faster */
     56f:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     573:	48 89 c7             	mov    rdi,rax
     576:	e8 00 00 00 00       	call   57b <fil_fd_allocate+0x15f>
				fdc = fdc->next;
     57b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     57f:	48 8b 80 00 0a 00 00 	mov    rax,QWORD PTR [rax+0xa00]
     586:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				for (i = 0; i < 64; i++) {
     58a:	e9 ac fe ff ff       	jmp    43b <fil_fd_allocate+0x1f>
}
     58f:	c9                   	leave
     590:	c3                   	ret

0000000000000591 <fil_fd_free>:
{
     591:	55                   	push   rbp
     592:	48 89 e5             	mov    rbp,rsp
     595:	48 83 ec 18          	sub    rsp,0x18
     599:	89 7d ec             	mov    DWORD PTR [rbp-0x14],edi
		struct fil_fdc* fdc = &fdc0;
     59c:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
				if (fd >= 64) {
     5a4:	83 7d ec 3f          	cmp    DWORD PTR [rbp-0x14],0x3f
     5a8:	7e 1c                	jle    5c6 <fil_fd_free+0x35>
						fdc = fdc->next;
     5aa:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     5ae:	48 8b 80 00 0a 00 00 	mov    rax,QWORD PTR [rax+0xa00]
     5b5:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						fd -= 64;
     5b9:	83 6d ec 40          	sub    DWORD PTR [rbp-0x14],0x40
						if (!fdc)
     5bd:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     5c2:	75 e0                	jne    5a4 <fil_fd_free+0x13>
								return;
     5c4:	eb 48                	jmp    60e <fil_fd_free+0x7d>
						if (fdc->fds[fd].in) {
     5c6:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
     5ca:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     5cd:	48 63 d0             	movsxd rdx,eax
     5d0:	48 89 d0             	mov    rax,rdx
     5d3:	48 c1 e0 02          	shl    rax,0x2
     5d7:	48 01 d0             	add    rax,rdx
     5da:	48 c1 e0 03          	shl    rax,0x3
     5de:	48 01 c8             	add    rax,rcx
     5e1:	48 8b 00             	mov    rax,QWORD PTR [rax]
     5e4:	48 85 c0             	test   rax,rax
     5e7:	74 24                	je     60d <fil_fd_free+0x7c>
								fdc->fds[fd].in = NULL;
     5e9:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
     5ed:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     5f0:	48 63 d0             	movsxd rdx,eax
     5f3:	48 89 d0             	mov    rax,rdx
     5f6:	48 c1 e0 02          	shl    rax,0x2
     5fa:	48 01 d0             	add    rax,rdx
     5fd:	48 c1 e0 03          	shl    rax,0x3
     601:	48 01 c8             	add    rax,rcx
     604:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
								return;
     60b:	eb 01                	jmp    60e <fil_fd_free+0x7d>
								return;
     60d:	90                   	nop
}
     60e:	c9                   	leave
     60f:	c3                   	ret

0000000000000610 <ino_allocate>:
{
     610:	55                   	push   rbp
     611:	48 89 e5             	mov    rbp,rsp
     614:	48 83 ec 30          	sub    rsp,0x30
     618:	89 7d dc             	mov    DWORD PTR [rbp-0x24],edi
		struct fil_inc* fi = &inc0; ino_t val = 1;
     61b:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
     623:	48 c7 45 f8 01 00 00 00 	mov    QWORD PTR [rbp-0x8],0x1
				struct inode* in = fi->inodes;
     62b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     62f:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
						if (__sync_bool_compare_and_swap(&in->in_stat.st_ino, 0, val)) {
     633:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     637:	48 8d 48 08          	lea    rcx,[rax+0x8]
     63b:	b8 00 00 00 00       	mov    eax,0x0
     640:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     644:	f0 48 0f b1 11       	lock cmpxchg QWORD PTR [rcx],rdx
     649:	0f 94 c0             	sete   al
     64c:	84 c0                	test   al,al
     64e:	0f 84 c0 00 00 00    	je     714 <ino_allocate+0x104>
								in->in_stat.st_nlink = 0;
     654:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     658:	48 c7 40 18 00 00 00 00 	mov    QWORD PTR [rax+0x18],0x0
								in->in_lock = (rwlock_t)RW_LOCK_UNLOCKED;
     660:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     664:	c7 80 88 00 00 00 00 00 00 00 	mov    DWORD PTR [rax+0x88],0x0
     66e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     672:	66 c7 80 8c 00 00 00 00 00 	mov    WORD PTR [rax+0x8c],0x0
								bzero(in->in_ddat, sizeof(in->in_ddat));
     67b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     67f:	48 83 c0 78          	add    rax,0x78
     683:	be 08 00 00 00       	mov    esi,0x8
     688:	48 89 c7             	mov    rdi,rax
     68b:	e8 00 00 00 00       	call   690 <ino_allocate+0x80>
								if (init) {
     690:	83 7d dc 00          	cmp    DWORD PTR [rbp-0x24],0x0
     694:	74 6c                	je     702 <ino_allocate+0xf2>
										in->in_stat.st_uid = 0;
     696:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     69a:	c7 40 20 00 00 00 00 	mov    DWORD PTR [rax+0x20],0x0
										in->in_stat.st_gid = 0;
     6a1:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     6a5:	c7 40 24 00 00 00 00 	mov    DWORD PTR [rax+0x24],0x0
										in->in_stat.st_mode = init | S_IRWXU | S_IRGRP | S_IXGRP | S_IROTH | S_IXOTH;
     6ac:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
     6af:	0d ed 01 00 00       	or     eax,0x1ed
     6b4:	89 c2                	mov    edx,eax
     6b6:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     6ba:	89 50 10             	mov    DWORD PTR [rax+0x10],edx
										clock_gettime(CLOCK_REALTIME, &in->in_stat.st_ctim);
     6bd:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     6c1:	48 83 c0 68          	add    rax,0x68
     6c5:	48 89 c6             	mov    rsi,rax
     6c8:	bf 00 00 00 00       	mov    edi,0x0
     6cd:	e8 00 00 00 00       	call   6d2 <ino_allocate+0xc2>
												= in->in_stat.st_ctim;
     6d2:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
     6d6:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     6da:	48 8b 50 70          	mov    rdx,QWORD PTR [rax+0x70]
     6de:	48 8b 40 68          	mov    rax,QWORD PTR [rax+0x68]
     6e2:	48 89 41 48          	mov    QWORD PTR [rcx+0x48],rax
     6e6:	48 89 51 50          	mov    QWORD PTR [rcx+0x50],rdx
										in->in_stat.st_mtim = in->in_stat.st_atim
     6ea:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
     6ee:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     6f2:	48 8b 50 50          	mov    rdx,QWORD PTR [rax+0x50]
     6f6:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
     6fa:	48 89 41 58          	mov    QWORD PTR [rcx+0x58],rax
     6fe:	48 89 51 60          	mov    QWORD PTR [rcx+0x60],rdx
								__sync_fetch_and_add(&ino_ct, 1);
     702:	f0 48 83 05 00 00 00 00 01 	lock add QWORD PTR [rip+0x0],0x1        # 70b <ino_allocate+0xfb>
								return in;
     70b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     70f:	e9 ab 00 00 00       	jmp    7bf <ino_allocate+0x1af>
						val++;
     714:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
				} while ((void*)(in++) != (void*)(&fi->next));
     719:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     71d:	48 8d 90 90 00 00 00 	lea    rdx,[rax+0x90]
     724:	48 89 55 f0          	mov    QWORD PTR [rbp-0x10],rdx
     728:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     72c:	48 81 c2 00 24 00 00 	add    rdx,0x2400
     733:	48 39 d0             	cmp    rax,rdx
     736:	0f 85 f7 fe ff ff    	jne    633 <ino_allocate+0x23>
				if (!fi->next) {
     73c:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     740:	48 8b 80 00 24 00 00 	mov    rax,QWORD PTR [rax+0x2400]
     747:	48 85 c0             	test   rax,rax
     74a:	0f 85 db fe ff ff    	jne    62b <ino_allocate+0x1b>
						struct fil_inc* fi2 = kmalloc(sizeof(struct fil_inc));
     750:	bf 08 24 00 00       	mov    edi,0x2408
     755:	e8 00 00 00 00       	call   75a <ino_allocate+0x14a>
     75a:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
						if (!fi2) {
     75e:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
     763:	75 11                	jne    776 <ino_allocate+0x166>
								errno = ENOMEM;
     765:	c7 05 00 00 00 00 0c 00 00 00 	mov    DWORD PTR [rip+0x0],0xc        # 76f <ino_allocate+0x15f>
								return NULL;
     76f:	b8 00 00 00 00       	mov    eax,0x0
     774:	eb 49                	jmp    7bf <ino_allocate+0x1af>
						bzero(fi2, sizeof(*fi2));
     776:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     77a:	be 08 24 00 00       	mov    esi,0x2408
     77f:	48 89 c7             	mov    rdi,rax
     782:	e8 00 00 00 00       	call   787 <ino_allocate+0x177>
						if (!__sync_bool_compare_and_swap(&fi->next, NULL, fi2)) {
     787:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     78b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     78f:	48 8d 88 00 24 00 00 	lea    rcx,[rax+0x2400]
     796:	b8 00 00 00 00       	mov    eax,0x0
     79b:	f0 48 0f b1 11       	lock cmpxchg QWORD PTR [rcx],rdx
     7a0:	0f 94 c0             	sete   al
     7a3:	83 f0 01             	xor    eax,0x1
     7a6:	84 c0                	test   al,al
     7a8:	0f 84 7d fe ff ff    	je     62b <ino_allocate+0x1b>
								kfree(fi2);
     7ae:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     7b2:	48 89 c7             	mov    rdi,rax
     7b5:	e8 00 00 00 00       	call   7ba <ino_allocate+0x1aa>
		while (1) {
     7ba:	e9 6c fe ff ff       	jmp    62b <ino_allocate+0x1b>
}
     7bf:	c9                   	leave
     7c0:	c3                   	ret

00000000000007c1 <ino_release>:
{
     7c1:	55                   	push   rbp
     7c2:	48 89 e5             	mov    rbp,rsp
     7c5:	48 83 ec 08          	sub    rsp,0x8
     7c9:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		ino->in_stat.st_ino = 0;
     7cd:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     7d1:	48 c7 40 08 00 00 00 00 	mov    QWORD PTR [rax+0x8],0x0
		return __sync_fetch_and_sub(&ino_ct, 1);
     7d9:	b8 01 00 00 00       	mov    eax,0x1
     7de:	48 f7 d8             	neg    rax
     7e1:	f0 48 0f c1 05 00 00 00 00 	lock xadd QWORD PTR [rip+0x0],rax        # 7ea <ino_release+0x29>
}
     7ea:	c9                   	leave
     7eb:	c3                   	ret

00000000000007ec <memdev_store_node>:
{
     7ec:	55                   	push   rbp
     7ed:	48 89 e5             	mov    rbp,rsp
     7f0:	48 83 ec 30          	sub    rsp,0x30
     7f4:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		struct memdev_node** ns = memdev_data->nodes;
     7f8:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 7ff <memdev_store_node+0x13>
     7ff:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     803:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		for (i = 0; i < memdev_data->node_cap_bts; i++) {
     807:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
     80f:	e9 6e 01 00 00       	jmp    982 <memdev_store_node+0x196>
				if (__sync_bool_compare_and_swap(&ns[i], NULL, n))
     814:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
     818:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     81c:	48 8d 0c c5 00 00 00 00 	lea    rcx,[rax*8+0x0]
     824:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     828:	48 01 c1             	add    rcx,rax
     82b:	b8 00 00 00 00       	mov    eax,0x0
     830:	f0 48 0f b1 11       	lock cmpxchg QWORD PTR [rcx],rdx
     835:	0f 94 c0             	sete   al
     838:	84 c0                	test   al,al
     83a:	74 18                	je     854 <memdev_store_node+0x68>
						return &ns[i]; /* stored */
     83c:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     840:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     848:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     84c:	48 01 d0             	add    rax,rdx
     84f:	e9 48 01 00 00       	jmp    99c <memdev_store_node+0x1b0>
				if (i == memdev_data->node_cap_bts - 2) { /* next is ptr */
     854:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 85b <memdev_store_node+0x6f>
     85b:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
     85f:	48 83 e8 02          	sub    rax,0x2
     863:	48 39 45 f0          	cmp    QWORD PTR [rbp-0x10],rax
     867:	0f 85 10 01 00 00    	jne    97d <memdev_store_node+0x191>
						if (ns[++i])
     86d:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
     872:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     876:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     87e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     882:	48 01 d0             	add    rax,rdx
     885:	48 8b 00             	mov    rax,QWORD PTR [rax]
     888:	48 85 c0             	test   rax,rax
     88b:	74 1f                	je     8ac <memdev_store_node+0xc0>
								ns = (struct memdev_node**)ns[i];
     88d:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     891:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     899:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     89d:	48 01 d0             	add    rax,rdx
     8a0:	48 8b 00             	mov    rax,QWORD PTR [rax]
     8a3:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
     8a7:	e9 c9 00 00 00       	jmp    975 <memdev_store_node+0x189>
									memdev_data->node_cap_bts * sizeof(struct memdev_node*));
     8ac:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 8b3 <memdev_store_node+0xc7>
     8b3:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
								ns2 = h_malloc(memdev_data->heap,
     8b7:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     8bf:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 8c6 <memdev_store_node+0xda>
     8c6:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
     8ca:	48 89 d6             	mov    rsi,rdx
     8cd:	48 89 c7             	mov    rdi,rax
     8d0:	e8 00 00 00 00       	call   8d5 <memdev_store_node+0xe9>
     8d5:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
								if (!ns2) /* OOM */
     8d9:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
     8de:	75 0a                	jne    8ea <memdev_store_node+0xfe>
										return NULL;
     8e0:	b8 00 00 00 00       	mov    eax,0x0
     8e5:	e9 b2 00 00 00       	jmp    99c <memdev_store_node+0x1b0>
								bzero(ns2, memdev_data->node_cap_bts * sizeof(struct memdev_node*));
     8ea:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 8f1 <memdev_store_node+0x105>
     8f1:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
     8f5:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     8fd:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     901:	48 89 d6             	mov    rsi,rdx
     904:	48 89 c7             	mov    rdi,rax
     907:	e8 00 00 00 00       	call   90c <memdev_store_node+0x120>
								if (!__sync_bool_compare_and_swap(&ns[i], NULL, ns2)) {
     90c:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     910:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     914:	48 8d 0c c5 00 00 00 00 	lea    rcx,[rax*8+0x0]
     91c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     920:	48 01 c1             	add    rcx,rax
     923:	b8 00 00 00 00       	mov    eax,0x0
     928:	f0 48 0f b1 11       	lock cmpxchg QWORD PTR [rcx],rdx
     92d:	0f 94 c0             	sete   al
     930:	83 f0 01             	xor    eax,0x1
     933:	84 c0                	test   al,al
     935:	74 36                	je     96d <memdev_store_node+0x181>
										h_free(memdev_data->heap, ns2);
     937:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 93e <memdev_store_node+0x152>
     93e:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
     942:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     946:	48 89 d6             	mov    rsi,rdx
     949:	48 89 c7             	mov    rdi,rax
     94c:	e8 00 00 00 00       	call   951 <memdev_store_node+0x165>
										ns = (struct memdev_node**)ns[i];
     951:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     955:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
     95d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     961:	48 01 d0             	add    rax,rdx
     964:	48 8b 00             	mov    rax,QWORD PTR [rax]
     967:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
     96b:	eb 08                	jmp    975 <memdev_store_node+0x189>
										ns = ns2;
     96d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     971:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						i = 0;
     975:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		for (i = 0; i < memdev_data->node_cap_bts; i++) {
     97d:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
     982:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 989 <memdev_store_node+0x19d>
     989:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
     98d:	48 39 45 f0          	cmp    QWORD PTR [rbp-0x10],rax
     991:	0f 82 7d fe ff ff    	jb     814 <memdev_store_node+0x28>
		return NULL;
     997:	b8 00 00 00 00       	mov    eax,0x0
}
     99c:	c9                   	leave
     99d:	c3                   	ret

000000000000099e <memdev_register>:
{
     99e:	55                   	push   rbp
     99f:	48 89 e5             	mov    rbp,rsp
     9a2:	53                   	push   rbx
     9a3:	48 83 ec 28          	sub    rsp,0x28
     9a7:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		memdev_data = (struct memdev_data*)kmalloc(sizeof(struct memdev_data));
     9ab:	bf 28 00 00 00       	mov    edi,0x28
     9b0:	e8 00 00 00 00       	call   9b5 <memdev_register+0x17>
     9b5:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 9bc <memdev_register+0x1e>
		if (!memdev_data)
     9bc:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 9c3 <memdev_register+0x25>
     9c3:	48 85 c0             	test   rax,rax
     9c6:	75 0a                	jne    9d2 <memdev_register+0x34>
				return -1;
     9c8:	b8 ff ff ff ff       	mov    eax,0xffffffff
     9cd:	e9 5b 01 00 00       	jmp    b2d <memdev_register+0x18f>
		memdev_data->id = d;
     9d2:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 9d9 <memdev_register+0x3b>
     9d9:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
     9dd:	48 89 10             	mov    QWORD PTR [rax],rdx
		memdev_data->node_ct = 0;
     9e0:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 9e7 <memdev_register+0x49>
     9e7:	48 c7 40 10 00 00 00 00 	mov    QWORD PTR [rax+0x10],0x0
		memdev_data->node_cap_bts = 4096;
     9ef:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 9f6 <memdev_register+0x58>
     9f6:	48 c7 40 18 00 10 00 00 	mov    QWORD PTR [rax+0x18],0x1000
		memdev_data->heap = mm_alloc_vmem(&mm_kernel, NULL, 25,
     9fe:	48 8b 1d 00 00 00 00 	mov    rbx,QWORD PTR [rip+0x0]        # a05 <memdev_register+0x67>
     a05:	b9 0c 00 00 00       	mov    ecx,0xc
     a0a:	ba 19 00 00 00       	mov    edx,0x19
     a0f:	be 00 00 00 00       	mov    esi,0x0
     a14:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     a1b:	e8 00 00 00 00       	call   a20 <memdev_register+0x82>
     a20:	48 89 43 20          	mov    QWORD PTR [rbx+0x20],rax
		if (!memdev_data->heap) {
     a24:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # a2b <memdev_register+0x8d>
     a2b:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
     a2f:	48 85 c0             	test   rax,rax
     a32:	75 19                	jne    a4d <memdev_register+0xaf>
				kfree(memdev_data);
     a34:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # a3b <memdev_register+0x9d>
     a3b:	48 89 c7             	mov    rdi,rax
     a3e:	e8 00 00 00 00       	call   a43 <memdev_register+0xa5>
				return -1;
     a43:	b8 ff ff ff ff       	mov    eax,0xffffffff
     a48:	e9 e0 00 00 00       	jmp    b2d <memdev_register+0x18f>
		ptr = h_create_heap(memdev_data->heap, 25 * 4096, h_generic_oom_handler, h_generic_decommit);
     a4d:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # a54 <memdev_register+0xb6>
     a54:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
     a58:	48 c7 c1 00 00 00 00 	mov    rcx,0x0
     a5f:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
     a66:	be 00 90 01 00       	mov    esi,0x19000
     a6b:	48 89 c7             	mov    rdi,rax
     a6e:	e8 00 00 00 00       	call   a73 <memdev_register+0xd5>
     a73:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		if (!ptr) {
     a77:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
     a7c:	75 35                	jne    ab3 <memdev_register+0x115>
				mm_free_vmem(&mm_kernel, memdev_data->heap, 25);
     a7e:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # a85 <memdev_register+0xe7>
     a85:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
     a89:	ba 19 00 00 00       	mov    edx,0x19
     a8e:	48 89 c6             	mov    rsi,rax
     a91:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     a98:	e8 00 00 00 00       	call   a9d <memdev_register+0xff>
				kfree(memdev_data);
     a9d:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # aa4 <memdev_register+0x106>
     aa4:	48 89 c7             	mov    rdi,rax
     aa7:	e8 00 00 00 00       	call   aac <memdev_register+0x10e>
				return -1;
     aac:	b8 ff ff ff ff       	mov    eax,0xffffffff
     ab1:	eb 7a                	jmp    b2d <memdev_register+0x18f>
		memdev_data->heap = ptr;
     ab3:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # aba <memdev_register+0x11c>
     aba:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     abe:	48 89 50 20          	mov    QWORD PTR [rax+0x20],rdx
		memdev_data->nodes = h_malloc(ptr, 4096 * sizeof(struct memdev_node*));
     ac2:	48 8b 1d 00 00 00 00 	mov    rbx,QWORD PTR [rip+0x0]        # ac9 <memdev_register+0x12b>
     ac9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     acd:	be 00 80 00 00       	mov    esi,0x8000
     ad2:	48 89 c7             	mov    rdi,rax
     ad5:	e8 00 00 00 00       	call   ada <memdev_register+0x13c>
     ada:	48 89 43 08          	mov    QWORD PTR [rbx+0x8],rax
		if (!memdev_data->nodes) {
     ade:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # ae5 <memdev_register+0x147>
     ae5:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     ae9:	48 85 c0             	test   rax,rax
     aec:	75 22                	jne    b10 <memdev_register+0x172>
				h_destroy(ptr);
     aee:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     af2:	48 89 c7             	mov    rdi,rax
     af5:	e8 00 00 00 00       	call   afa <memdev_register+0x15c>
				kfree(memdev_data);
     afa:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # b01 <memdev_register+0x163>
     b01:	48 89 c7             	mov    rdi,rax
     b04:	e8 00 00 00 00       	call   b09 <memdev_register+0x16b>
				return -1;
     b09:	b8 ff ff ff ff       	mov    eax,0xffffffff
     b0e:	eb 1d                	jmp    b2d <memdev_register+0x18f>
		bzero(memdev_data->nodes, 4096 * sizeof(struct memdev_node*));
     b10:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # b17 <memdev_register+0x179>
     b17:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     b1b:	be 00 80 00 00       	mov    esi,0x8000
     b20:	48 89 c7             	mov    rdi,rax
     b23:	e8 00 00 00 00       	call   b28 <memdev_register+0x18a>
		return 0;
     b28:	b8 00 00 00 00       	mov    eax,0x0
}
     b2d:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
     b31:	c9                   	leave
     b32:	c3                   	ret

0000000000000b33 <memdev_unregister>:
{
     b33:	55                   	push   rbp
     b34:	48 89 e5             	mov    rbp,rsp
		errno = ENOSYS;
     b37:	c7 05 00 00 00 00 26 00 00 00 	mov    DWORD PTR [rip+0x0],0x26        # b41 <memdev_unregister+0xe>
		return -1;
     b41:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
     b46:	5d                   	pop    rbp
     b47:	c3                   	ret

0000000000000b48 <memdev_open>:

/* mode only on O_CREAT which is done externally */
int memdev_open(struct inode* in, int flags/*, mode_t mod*/)
{
     b48:	55                   	push   rbp
     b49:	48 89 e5             	mov    rbp,rsp
     b4c:	48 83 ec 20          	sub    rsp,0x20
     b50:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
     b54:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
		struct fil_fd* fd; int rv;
		if (!in || in->in_stat.st_dev != memdev_data->id) {
     b57:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
     b5c:	74 16                	je     b74 <memdev_open+0x2c>
     b5e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     b62:	48 8b 10             	mov    rdx,QWORD PTR [rax]
     b65:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # b6c <memdev_open+0x24>
     b6c:	48 8b 00             	mov    rax,QWORD PTR [rax]
     b6f:	48 39 c2             	cmp    rdx,rax
     b72:	74 11                	je     b85 <memdev_open+0x3d>
				errno = EINVAL;
     b74:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # b7e <memdev_open+0x36>
				return -1;
     b7e:	b8 ff ff ff ff       	mov    eax,0xffffffff
     b83:	eb 54                	jmp    bd9 <memdev_open+0x91>
		}

		/* access checks are done on the level above */
		fd = fil_fd_allocate(in, &rv);
     b85:	48 8d 55 f4          	lea    rdx,[rbp-0xc]
     b89:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     b8d:	48 89 d6             	mov    rsi,rdx
     b90:	48 89 c7             	mov    rdi,rax
     b93:	e8 00 00 00 00       	call   b98 <memdev_open+0x50>
     b98:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (!fd) {
     b9c:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     ba1:	75 11                	jne    bb4 <memdev_open+0x6c>
				errno = ENOMEM;
     ba3:	c7 05 00 00 00 00 0c 00 00 00 	mov    DWORD PTR [rip+0x0],0xc        # bad <memdev_open+0x65>
				return -1;
     bad:	b8 ff ff ff ff       	mov    eax,0xffffffff
     bb2:	eb 25                	jmp    bd9 <memdev_open+0x91>
		}

		fd->flags = flags;
     bb4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     bb8:	8b 55 e4             	mov    edx,DWORD PTR [rbp-0x1c]
     bbb:	89 50 10             	mov    DWORD PTR [rax+0x10],edx
		fd->seek_offset = 0;
     bbe:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     bc2:	48 c7 40 08 00 00 00 00 	mov    QWORD PTR [rax+0x8],0x0
		__sync_fetch_and_add((int*)in->in_ddat, 1);
     bca:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     bce:	48 83 c0 78          	add    rax,0x78
     bd2:	f0 83 00 01          	lock add DWORD PTR [rax],0x1
		return rv;
     bd6:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
}
     bd9:	c9                   	leave
     bda:	c3                   	ret

0000000000000bdb <memdev_read>:

ssize_t memdev_read(struct inode* in, int fd, void* buf, size_t noct)
{
     bdb:	55                   	push   rbp
     bdc:	48 89 e5             	mov    rbp,rsp
     bdf:	48 83 ec 40          	sub    rsp,0x40
     be3:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
     be7:	89 75 d4             	mov    DWORD PTR [rbp-0x2c],esi
     bea:	48 89 55 c8          	mov    QWORD PTR [rbp-0x38],rdx
     bee:	48 89 4d c0          	mov    QWORD PTR [rbp-0x40],rcx
		struct fil_fd* f; ssize_t rv = 0;
     bf2:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		struct memdev_node* n;
		if (!in || !buf || in->in_stat.st_dev != memdev_data->id) {
     bf9:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
     bfe:	74 1d                	je     c1d <memdev_read+0x42>
     c00:	48 83 7d c8 00       	cmp    QWORD PTR [rbp-0x38],0x0
     c05:	74 16                	je     c1d <memdev_read+0x42>
     c07:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     c0b:	48 8b 10             	mov    rdx,QWORD PTR [rax]
     c0e:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # c15 <memdev_read+0x3a>
     c15:	48 8b 00             	mov    rax,QWORD PTR [rax]
     c18:	48 39 c2             	cmp    rdx,rax
     c1b:	74 14                	je     c31 <memdev_read+0x56>
				errno = EINVAL;
     c1d:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # c27 <memdev_read+0x4c>
				return -1;
     c27:	b8 ff ff ff ff       	mov    eax,0xffffffff
     c2c:	e9 27 01 00 00       	jmp    d58 <memdev_read+0x17d>
		}

		f = fil_fd_get(fd);
     c31:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
     c34:	89 c7                	mov    edi,eax
     c36:	e8 00 00 00 00       	call   c3b <memdev_read+0x60>
     c3b:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		if (!f || (f->flags & O_WRONLY)
     c3f:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
     c44:	74 0e                	je     c54 <memdev_read+0x79>
     c46:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     c4a:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     c4d:	83 e0 01             	and    eax,0x1
     c50:	85 c0                	test   eax,eax
     c52:	74 14                	je     c68 <memdev_read+0x8d>
			/*|| ((f->flags & O_SEARCH) && !S_ISDIR(in->in_stat.st_mode))*/
			/*|| (f->flags & O_EXEC)*/) { /* O_EXEC->mmap with exec */
				errno = EBADF;
     c54:	c7 05 00 00 00 00 09 00 00 00 	mov    DWORD PTR [rip+0x0],0x9        # c5e <memdev_read+0x83>
				return -1;
     c5e:	b8 ff ff ff ff       	mov    eax,0xffffffff
     c63:	e9 f0 00 00 00       	jmp    d58 <memdev_read+0x17d>
		}

		/* now lock for read access */
		read_lock(&in->in_lock);
     c68:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     c6c:	48 05 88 00 00 00    	add    rax,0x88
     c72:	48 89 c7             	mov    rdi,rax
     c75:	e8 00 00 00 00       	call   c7a <memdev_read+0x9f>
		n = *(struct memdev_node**)in->in_pddat;
     c7a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     c7e:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
     c85:	48 8b 00             	mov    rax,QWORD PTR [rax]
     c88:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		if (f->seek_offset < (n->size - sizeof(struct memdev_node))) {
     c8c:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     c90:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     c94:	48 89 c2             	mov    rdx,rax
     c97:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     c9b:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     c9f:	48 83 e8 20          	sub    rax,0x20
     ca3:	48 39 c2             	cmp    rdx,rax
     ca6:	73 70                	jae    d18 <memdev_read+0x13d>
				/* read up to noct bytes */
				rv = n->size - sizeof(struct memdev_node) - f->seek_offset;
     ca8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     cac:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     cb0:	89 c1                	mov    ecx,eax
     cb2:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     cb6:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     cba:	89 c2                	mov    edx,eax
     cbc:	89 c8                	mov    eax,ecx
     cbe:	29 d0                	sub    eax,edx
     cc0:	83 e8 20             	sub    eax,0x20
     cc3:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
				if ((size_t)rv > noct)
     cc6:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     cc9:	48 98                	cdqe
     ccb:	48 39 45 c0          	cmp    QWORD PTR [rbp-0x40],rax
     ccf:	73 07                	jae    cd8 <memdev_read+0xfd>
						rv = noct;
     cd1:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     cd5:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
				memcpy(buf, n->data + f->seek_offset, rv);
     cd8:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     cdb:	48 63 d0             	movsxd rdx,eax
     cde:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     ce2:	48 8d 48 20          	lea    rcx,[rax+0x20]
     ce6:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     cea:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     cee:	48 01 c1             	add    rcx,rax
     cf1:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     cf5:	48 89 ce             	mov    rsi,rcx
     cf8:	48 89 c7             	mov    rdi,rax
     cfb:	e8 00 f3 ff ff       	call   0 <memcpy>
				f->seek_offset += rv;
     d00:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     d04:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
     d08:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     d0b:	48 98                	cdqe
     d0d:	48 01 c2             	add    rdx,rax
     d10:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     d14:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
		}
		if (rv > 0 && !(f->flags & O_NOATIME)) {/* set atime */
     d18:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
     d1c:	7e 25                	jle    d43 <memdev_read+0x168>
     d1e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     d22:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     d25:	25 00 00 04 00       	and    eax,0x40000
     d2a:	85 c0                	test   eax,eax
     d2c:	75 15                	jne    d43 <memdev_read+0x168>
				clock_gettime(CLOCK_REALTIME, &in->in_stat.st_atim);
     d2e:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     d32:	48 83 c0 48          	add    rax,0x48
     d36:	48 89 c6             	mov    rsi,rax
     d39:	bf 00 00 00 00       	mov    edi,0x0
     d3e:	e8 00 00 00 00       	call   d43 <memdev_read+0x168>
		}
		read_unlock(&in->in_lock);
     d43:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     d47:	48 05 88 00 00 00    	add    rax,0x88
     d4d:	48 89 c7             	mov    rdi,rax
     d50:	e8 00 00 00 00       	call   d55 <memdev_read+0x17a>
		return rv;
     d55:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
     d58:	c9                   	leave
     d59:	c3                   	ret

0000000000000d5a <memdev_write>:

ssize_t memdev_write(struct inode* in, int fd, const void* buf, size_t noct)
{
     d5a:	55                   	push   rbp
     d5b:	48 89 e5             	mov    rbp,rsp
     d5e:	48 83 ec 50          	sub    rsp,0x50
     d62:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
     d66:	89 75 c4             	mov    DWORD PTR [rbp-0x3c],esi
     d69:	48 89 55 b8          	mov    QWORD PTR [rbp-0x48],rdx
     d6d:	48 89 4d b0          	mov    QWORD PTR [rbp-0x50],rcx
		struct fil_fd* f; struct memdev_node* n; size_t s_ext = 0;
     d71:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		if (!in || !buf || in->in_stat.st_dev != memdev_data->id) {
     d79:	48 83 7d c8 00       	cmp    QWORD PTR [rbp-0x38],0x0
     d7e:	74 1d                	je     d9d <memdev_write+0x43>
     d80:	48 83 7d b8 00       	cmp    QWORD PTR [rbp-0x48],0x0
     d85:	74 16                	je     d9d <memdev_write+0x43>
     d87:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     d8b:	48 8b 10             	mov    rdx,QWORD PTR [rax]
     d8e:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # d95 <memdev_write+0x3b>
     d95:	48 8b 00             	mov    rax,QWORD PTR [rax]
     d98:	48 39 c2             	cmp    rdx,rax
     d9b:	74 14                	je     db1 <memdev_write+0x57>
				errno = EINVAL;
     d9d:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # da7 <memdev_write+0x4d>
				return -1;
     da7:	b8 ff ff ff ff       	mov    eax,0xffffffff
     dac:	e9 a1 03 00 00       	jmp    1152 <memdev_write+0x3f8>
		}
		if (!(f = fil_fd_get(fd))) {
     db1:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
     db4:	89 c7                	mov    edi,eax
     db6:	e8 00 00 00 00       	call   dbb <memdev_write+0x61>
     dbb:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
     dbf:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
     dc4:	75 14                	jne    dda <memdev_write+0x80>
				errno = EBADF;
     dc6:	c7 05 00 00 00 00 09 00 00 00 	mov    DWORD PTR [rip+0x0],0x9        # dd0 <memdev_write+0x76>
				return -1;
     dd0:	b8 ff ff ff ff       	mov    eax,0xffffffff
     dd5:	e9 78 03 00 00       	jmp    1152 <memdev_write+0x3f8>
		}

		/* acquire the lock */
		write_lock(&in->in_lock);
     dda:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     dde:	48 05 88 00 00 00    	add    rax,0x88
     de4:	48 89 c7             	mov    rdi,rax
     de7:	e8 00 00 00 00       	call   dec <memdev_write+0x92>
		n = *(struct memdev_node**)in->in_pddat;
     dec:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     df0:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
     df7:	48 8b 00             	mov    rax,QWORD PTR [rax]
     dfa:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (f->flags & O_APPEND) /* atomic append */
     dfe:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     e02:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     e05:	25 00 04 00 00       	and    eax,0x400
     e0a:	85 c0                	test   eax,eax
     e0c:	74 17                	je     e25 <memdev_write+0xcb>
				f->seek_offset = n->size - sizeof(struct memdev_node);
     e0e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     e12:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     e16:	48 83 e8 20          	sub    rax,0x20
     e1a:	48 89 c2             	mov    rdx,rax
     e1d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     e21:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
		if (f->seek_offset + noct > n->size) {
     e25:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     e29:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     e2d:	48 89 c2             	mov    rdx,rax
     e30:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     e34:	48 01 c2             	add    rdx,rax
     e37:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     e3b:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     e3f:	48 39 d0             	cmp    rax,rdx
     e42:	0f 83 69 02 00 00    	jae    10b1 <memdev_write+0x357>
				/* we have to extend */
				s_ext = f->seek_offset + noct + sizeof(struct memdev_node);
     e48:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     e4c:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     e50:	48 89 c2             	mov    rdx,rax
     e53:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
     e57:	48 01 d0             	add    rax,rdx
     e5a:	48 83 c0 20          	add    rax,0x20
     e5e:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				if (s_ext > n->cap) { /* really */
     e62:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     e66:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
     e6a:	48 3b 45 f0          	cmp    rax,QWORD PTR [rbp-0x10]
     e6e:	0f 83 dc 01 00 00    	jae    1050 <memdev_write+0x2f6>
						size_t new_cap; void* mem;
						if (S_ISREG(in->in_stat.st_mode)) {
     e74:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     e78:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     e7b:	25 00 f0 00 00       	and    eax,0xf000
     e80:	3d 00 80 00 00       	cmp    eax,0x8000
     e85:	0f 85 e6 00 00 00    	jne    f71 <memdev_write+0x217>
								/* work on pages */
								new_cap = s_ext / 4096 + (s_ext % 4096 ? 1 : 0) * 4096;
     e8b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     e8f:	48 c1 e8 0c          	shr    rax,0xc
     e93:	48 89 c2             	mov    rdx,rax
     e96:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     e9a:	25 ff 0f 00 00       	and    eax,0xfff
     e9f:	48 85 c0             	test   rax,rax
     ea2:	74 07                	je     eab <memdev_write+0x151>
     ea4:	b8 00 10 00 00       	mov    eax,0x1000
     ea9:	eb 05                	jmp    eb0 <memdev_write+0x156>
     eab:	b8 00 00 00 00       	mov    eax,0x0
     eb0:	48 01 d0             	add    rax,rdx
     eb3:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
								mem = mm_extend_vmem(&mm_kernel, n, n->cap / 4096,
     eb7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     ebb:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
     ebf:	48 c1 e8 0c          	shr    rax,0xc
     ec3:	48 89 c6             	mov    rsi,rax
     ec6:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     eca:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     ece:	41 b8 0c 00 00 00    	mov    r8d,0xc
     ed4:	48 89 d1             	mov    rcx,rdx
     ed7:	48 89 f2             	mov    rdx,rsi
     eda:	48 89 c6             	mov    rsi,rax
     edd:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     ee4:	e8 00 00 00 00       	call   ee9 <memdev_write+0x18f>
     ee9:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
												new_cap, MMGR_MAP_WRITE | MMGR_MAP_KERNEL);
								if (mem) {
     eed:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
     ef2:	74 3e                	je     f32 <memdev_write+0x1d8>
										n = (struct memdev_node*)mem;
     ef4:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     ef8:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
										*(struct memdev_node**)in->in_pddat = n;
     efc:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     f00:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
     f07:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     f0b:	48 89 10             	mov    QWORD PTR [rax],rdx
										n->cap = new_cap * 4096;
     f0e:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     f12:	48 c1 e0 0c          	shl    rax,0xc
     f16:	48 89 c2             	mov    rdx,rax
     f19:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     f1d:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
										n->size = s_ext;
     f21:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     f25:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     f29:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
     f2d:	e9 2d 01 00 00       	jmp    105f <memdev_write+0x305>
								} else { /* write partially */
										noct = n->cap - n->size;
     f32:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     f36:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
     f3a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     f3e:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     f42:	48 29 c2             	sub    rdx,rax
     f45:	48 89 55 b0          	mov    QWORD PTR [rbp-0x50],rdx
										n->size = n->cap;
     f49:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     f4d:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
     f51:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     f55:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
										if (!noct)
     f59:	48 83 7d b0 00       	cmp    QWORD PTR [rbp-0x50],0x0
     f5e:	0f 85 fb 00 00 00    	jne    105f <memdev_write+0x305>
												noct = -1;
     f64:	48 c7 45 b0 ff ff ff ff 	mov    QWORD PTR [rbp-0x50],0xffffffffffffffff
     f6c:	e9 ee 00 00 00       	jmp    105f <memdev_write+0x305>
								}
						} else if (S_ISDIR(in->in_stat.st_mode) || S_ISLNK(in->in_stat.st_mode)) {
     f71:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     f75:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     f78:	25 00 f0 00 00       	and    eax,0xf000
     f7d:	3d 00 40 00 00       	cmp    eax,0x4000
     f82:	74 17                	je     f9b <memdev_write+0x241>
     f84:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     f88:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
     f8b:	25 00 f0 00 00       	and    eax,0xf000
     f90:	3d 00 a0 00 00       	cmp    eax,0xa000
     f95:	0f 85 a1 00 00 00    	jne    103c <memdev_write+0x2e2>
								/* heap memory */
								new_cap = s_ext + 32; /* prevent many resizes */
     f9b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     f9f:	48 83 c0 20          	add    rax,0x20
     fa3:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
								mem = h_realloc(memdev_data->heap, n, new_cap);
     fa7:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # fae <memdev_write+0x254>
     fae:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
     fb2:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
     fb6:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
     fba:	48 89 ce             	mov    rsi,rcx
     fbd:	48 89 c7             	mov    rdi,rax
     fc0:	e8 00 00 00 00       	call   fc5 <memdev_write+0x26b>
     fc5:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
								if (!mem) { /* write partially */
     fc9:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
     fce:	75 38                	jne    1008 <memdev_write+0x2ae>
										noct = n->cap - n->size;
     fd0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     fd4:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
     fd8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     fdc:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
     fe0:	48 29 c2             	sub    rdx,rax
     fe3:	48 89 55 b0          	mov    QWORD PTR [rbp-0x50],rdx
										n->size = n->cap;
     fe7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     feb:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
     fef:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     ff3:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
										if (!noct)
     ff7:	48 83 7d b0 00       	cmp    QWORD PTR [rbp-0x50],0x0
     ffc:	75 60                	jne    105e <memdev_write+0x304>
												noct = -1;
     ffe:	48 c7 45 b0 ff ff ff ff 	mov    QWORD PTR [rbp-0x50],0xffffffffffffffff
								if (!mem) { /* write partially */
    1006:	eb 56                	jmp    105e <memdev_write+0x304>
								} else {
										n = (struct memdev_node*)mem;
    1008:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    100c:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
										*(struct memdev_node**)in->in_pddat = n;
    1010:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1014:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
    101b:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    101f:	48 89 10             	mov    QWORD PTR [rax],rdx
										n->cap = new_cap;
    1022:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1026:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    102a:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
										n->size = s_ext;
    102e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1032:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1036:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
								if (!mem) { /* write partially */
    103a:	eb 22                	jmp    105e <memdev_write+0x304>
								}
						} else {
								/* wat do? */
								errno = ENOSYS;
    103c:	c7 05 00 00 00 00 26 00 00 00 	mov    DWORD PTR [rip+0x0],0x26        # 1046 <memdev_write+0x2ec>
								noct = -1;
    1046:	48 c7 45 b0 ff ff ff ff 	mov    QWORD PTR [rbp-0x50],0xffffffffffffffff
    104e:	eb 0f                	jmp    105f <memdev_write+0x305>
						}
				} else
						n->size = s_ext;
    1050:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1054:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1058:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
    105c:	eb 01                	jmp    105f <memdev_write+0x305>
								if (!mem) { /* write partially */
    105e:	90                   	nop
				in->in_stat.st_size = n->size - sizeof(struct memdev_node);
    105f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1063:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1067:	48 83 e8 20          	sub    rax,0x20
    106b:	48 89 c2             	mov    rdx,rax
    106e:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1072:	48 89 50 30          	mov    QWORD PTR [rax+0x30],rdx
				in->in_stat.st_size = n->cap / 512 + (n->cap % 512 ? 1 : 0);
    1076:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    107a:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    107e:	48 c1 e8 09          	shr    rax,0x9
    1082:	48 89 c2             	mov    rdx,rax
    1085:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1089:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    108d:	25 ff 01 00 00       	and    eax,0x1ff
    1092:	48 85 c0             	test   rax,rax
    1095:	74 07                	je     109e <memdev_write+0x344>
    1097:	b8 01 00 00 00       	mov    eax,0x1
    109c:	eb 05                	jmp    10a3 <memdev_write+0x349>
    109e:	b8 00 00 00 00       	mov    eax,0x0
    10a3:	48 01 d0             	add    rax,rdx
    10a6:	48 89 c2             	mov    rdx,rax
    10a9:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    10ad:	48 89 50 30          	mov    QWORD PTR [rax+0x30],rdx
		}
		/* now copy the data */
		memcpy(n->data + f->seek_offset, buf, noct);
    10b1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    10b5:	48 8d 50 20          	lea    rdx,[rax+0x20]
    10b9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    10bd:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    10c1:	48 8d 0c 02          	lea    rcx,[rdx+rax*1]
    10c5:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
    10c9:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    10cd:	48 89 c6             	mov    rsi,rax
    10d0:	48 89 cf             	mov    rdi,rcx
    10d3:	e8 28 ef ff ff       	call   0 <memcpy>
		/* and update the times */
		if (noct > 0) {
    10d8:	48 83 7d b0 00       	cmp    QWORD PTR [rbp-0x50],0x0
    10dd:	74 5d                	je     113c <memdev_write+0x3e2>
				clock_gettime(CLOCK_REALTIME, &in->in_stat.st_mtim);
    10df:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    10e3:	48 83 c0 58          	add    rax,0x58
    10e7:	48 89 c6             	mov    rsi,rax
    10ea:	bf 00 00 00 00       	mov    edi,0x0
    10ef:	e8 00 00 00 00       	call   10f4 <memdev_write+0x39a>
				in->in_stat.st_ctim = in->in_stat.st_mtim;
    10f4:	48 8b 4d c8          	mov    rcx,QWORD PTR [rbp-0x38]
    10f8:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    10fc:	48 8b 50 60          	mov    rdx,QWORD PTR [rax+0x60]
    1100:	48 8b 40 58          	mov    rax,QWORD PTR [rax+0x58]
    1104:	48 89 41 68          	mov    QWORD PTR [rcx+0x68],rax
    1108:	48 89 51 70          	mov    QWORD PTR [rcx+0x70],rdx
				f->seek_offset += noct; /* only forward (-1 for errno) */
    110c:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1110:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1114:	48 89 c2             	mov    rdx,rax
    1117:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    111b:	48 01 d0             	add    rax,rdx
    111e:	48 89 c2             	mov    rdx,rax
    1121:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1125:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
				/* clear SUID,SGID */
				in->in_stat.st_mode &= (~(mode_t)S_ISUID) & (~(mode_t)S_ISGID);
    1129:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    112d:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1130:	80 e4 f3             	and    ah,0xf3
    1133:	89 c2                	mov    edx,eax
    1135:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1139:	89 50 10             	mov    DWORD PTR [rax+0x10],edx
		}
		write_unlock(&in->in_lock);
    113c:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1140:	48 05 88 00 00 00    	add    rax,0x88
    1146:	48 89 c7             	mov    rdi,rax
    1149:	e8 00 00 00 00       	call   114e <memdev_write+0x3f4>
		return noct;
    114e:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
}
    1152:	c9                   	leave
    1153:	c3                   	ret

0000000000001154 <memdev_close>:

int memdev_close(struct inode* in, int fd)
{
    1154:	55                   	push   rbp
    1155:	48 89 e5             	mov    rbp,rsp
    1158:	48 83 ec 20          	sub    rsp,0x20
    115c:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    1160:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
		struct fil_fd* f;
		if (!in || !(f = fil_fd_get(fd))) {
    1163:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    1168:	74 15                	je     117f <memdev_close+0x2b>
    116a:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    116d:	89 c7                	mov    edi,eax
    116f:	e8 00 00 00 00       	call   1174 <memdev_close+0x20>
    1174:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1178:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    117d:	75 23                	jne    11a2 <memdev_close+0x4e>
				errno = in ? EBADF : EINVAL;
    117f:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    1184:	74 07                	je     118d <memdev_close+0x39>
    1186:	b8 09 00 00 00       	mov    eax,0x9
    118b:	eb 05                	jmp    1192 <memdev_close+0x3e>
    118d:	b8 16 00 00 00       	mov    eax,0x16
    1192:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 1198 <memdev_close+0x44>
				return -1;
    1198:	b8 ff ff ff ff       	mov    eax,0xffffffff
    119d:	e9 c8 00 00 00       	jmp    126a <memdev_close+0x116>
		}
		/* TODO: file locks */
		fil_fd_free(fd);
    11a2:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    11a5:	89 c7                	mov    edi,eax
    11a7:	e8 00 00 00 00       	call   11ac <memdev_close+0x58>
		if (__sync_sub_and_fetch((int*)in->in_ddat, 1) == 0) {
    11ac:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    11b0:	48 8d 50 78          	lea    rdx,[rax+0x78]
    11b4:	b8 01 00 00 00       	mov    eax,0x1
    11b9:	f7 d8                	neg    eax
    11bb:	89 c1                	mov    ecx,eax
    11bd:	89 c8                	mov    eax,ecx
    11bf:	f0 0f c1 02          	lock xadd DWORD PTR [rdx],eax
    11c3:	01 c8                	add    eax,ecx
    11c5:	85 c0                	test   eax,eax
    11c7:	0f 85 98 00 00 00    	jne    1265 <memdev_close+0x111>
				struct memdev_node* n;
				if (in->in_stat.st_nlink)
    11cd:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    11d1:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    11d5:	48 85 c0             	test   rax,rax
    11d8:	74 0a                	je     11e4 <memdev_close+0x90>
						return 0;
    11da:	b8 00 00 00 00       	mov    eax,0x0
    11df:	e9 86 00 00 00       	jmp    126a <memdev_close+0x116>
				/* nlink==0 && nref==0 */
				n = *(struct memdev_node**)in->in_pddat;
    11e4:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    11e8:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
    11ef:	48 8b 00             	mov    rax,QWORD PTR [rax]
    11f2:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				*(struct memdev_node**)in->in_pddat = NULL; /* free slot */
    11f6:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    11fa:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
    1201:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
				if (S_ISREG(in->in_stat.st_mode))
    1208:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    120c:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    120f:	25 00 f0 00 00       	and    eax,0xf000
    1214:	3d 00 80 00 00       	cmp    eax,0x8000
    1219:	75 24                	jne    123f <memdev_close+0xeb>
						mm_free_vmem(&mm_kernel, n, n->cap / 4096);
    121b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    121f:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    1223:	48 c1 e8 0c          	shr    rax,0xc
    1227:	48 89 c2             	mov    rdx,rax
    122a:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    122e:	48 89 c6             	mov    rsi,rax
    1231:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1238:	e8 00 00 00 00       	call   123d <memdev_close+0xe9>
    123d:	eb 1a                	jmp    1259 <memdev_close+0x105>
				else
						h_free(memdev_data->heap, n);
    123f:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1246 <memdev_close+0xf2>
    1246:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    124a:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    124e:	48 89 d6             	mov    rsi,rdx
    1251:	48 89 c7             	mov    rdi,rax
    1254:	e8 00 00 00 00       	call   1259 <memdev_close+0x105>
				ino_release(in);
    1259:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    125d:	48 89 c7             	mov    rdi,rax
    1260:	e8 00 00 00 00       	call   1265 <memdev_close+0x111>
		}
		return 0;
    1265:	b8 00 00 00 00       	mov    eax,0x0
}
    126a:	c9                   	leave
    126b:	c3                   	ret

000000000000126c <memdev_lseek>:

off_t memdev_lseek(struct inode* in, int fd, off_t offset, int ref)
{
    126c:	55                   	push   rbp
    126d:	48 89 e5             	mov    rbp,rsp
    1270:	48 83 ec 28          	sub    rsp,0x28
    1274:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    1278:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
    127b:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
    127f:	89 4d e0             	mov    DWORD PTR [rbp-0x20],ecx
		struct fil_fd* f;
		if (!in || in->in_stat.st_dev != memdev_data->id) {
    1282:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    1287:	74 16                	je     129f <memdev_lseek+0x33>
    1289:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    128d:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    1290:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1297 <memdev_lseek+0x2b>
    1297:	48 8b 00             	mov    rax,QWORD PTR [rax]
    129a:	48 39 c2             	cmp    rdx,rax
    129d:	74 16                	je     12b5 <memdev_lseek+0x49>
				errno = EINVAL;
    129f:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # 12a9 <memdev_lseek+0x3d>
				return -1;
    12a9:	48 c7 c0 ff ff ff ff 	mov    rax,0xffffffffffffffff
    12b0:	e9 95 00 00 00       	jmp    134a <memdev_lseek+0xde>
		}
		if (!(f = fil_fd_get(fd))) {
    12b5:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    12b8:	89 c7                	mov    edi,eax
    12ba:	e8 00 00 00 00       	call   12bf <memdev_lseek+0x53>
    12bf:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    12c3:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    12c8:	75 13                	jne    12dd <memdev_lseek+0x71>
				errno = EBADF;
    12ca:	c7 05 00 00 00 00 09 00 00 00 	mov    DWORD PTR [rip+0x0],0x9        # 12d4 <memdev_lseek+0x68>
				return -1;
    12d4:	48 c7 c0 ff ff ff ff 	mov    rax,0xffffffffffffffff
    12db:	eb 6d                	jmp    134a <memdev_lseek+0xde>
		}
		/* not thread-safe as sharing FDs is not thread-safe */
		if (ref == SEEK_SET)
    12dd:	83 7d e0 00          	cmp    DWORD PTR [rbp-0x20],0x0
    12e1:	75 0e                	jne    12f1 <memdev_lseek+0x85>
				f->seek_offset = offset;
    12e3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    12e7:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    12eb:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
    12ef:	eb 51                	jmp    1342 <memdev_lseek+0xd6>
		else if (ref == SEEK_CUR)
    12f1:	83 7d e0 01          	cmp    DWORD PTR [rbp-0x20],0x1
    12f5:	75 19                	jne    1310 <memdev_lseek+0xa4>
				f->seek_offset += offset;
    12f7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    12fb:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    12ff:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1303:	48 01 c2             	add    rdx,rax
    1306:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    130a:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
    130e:	eb 32                	jmp    1342 <memdev_lseek+0xd6>
		else if (ref == SEEK_END) {
    1310:	83 7d e0 02          	cmp    DWORD PTR [rbp-0x20],0x2
    1314:	75 19                	jne    132f <memdev_lseek+0xc3>
				f->seek_offset = in->in_stat.st_size + offset;
    1316:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    131a:	48 8b 50 30          	mov    rdx,QWORD PTR [rax+0x30]
    131e:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1322:	48 01 c2             	add    rdx,rax
    1325:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1329:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
    132d:	eb 13                	jmp    1342 <memdev_lseek+0xd6>
		} else {
				errno = EINVAL;
    132f:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # 1339 <memdev_lseek+0xcd>
				return -1;
    1339:	48 c7 c0 ff ff ff ff 	mov    rax,0xffffffffffffffff
    1340:	eb 08                	jmp    134a <memdev_lseek+0xde>
		}
		return f->seek_offset;
    1342:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1346:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
}
    134a:	c9                   	leave
    134b:	c3                   	ret

000000000000134c <memdev_truncate>:

int memdev_truncate(struct inode* in, off_t length)
{
    134c:	55                   	push   rbp
    134d:	48 89 e5             	mov    rbp,rsp
    1350:	48 83 ec 40          	sub    rsp,0x40
    1354:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
    1358:	48 89 75 c0          	mov    QWORD PTR [rbp-0x40],rsi
		struct memdev_node* n; off_t len;
		if (!in || in->in_stat.st_dev != memdev_data->id) {
    135c:	48 83 7d c8 00       	cmp    QWORD PTR [rbp-0x38],0x0
    1361:	74 16                	je     1379 <memdev_truncate+0x2d>
    1363:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1367:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    136a:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1371 <memdev_truncate+0x25>
    1371:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1374:	48 39 c2             	cmp    rdx,rax
    1377:	74 14                	je     138d <memdev_truncate+0x41>
				errno = EINVAL;
    1379:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # 1383 <memdev_truncate+0x37>
				return -1;
    1383:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1388:	e9 5a 02 00 00       	jmp    15e7 <memdev_truncate+0x29b>
		}

		/* only work on regular files (i.e. memory pages) */
		if (!S_ISREG(in->in_stat.st_mode)) {
    138d:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1391:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1394:	25 00 f0 00 00       	and    eax,0xf000
    1399:	3d 00 80 00 00       	cmp    eax,0x8000
    139e:	74 14                	je     13b4 <memdev_truncate+0x68>
				errno = EINVAL;
    13a0:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # 13aa <memdev_truncate+0x5e>
				return -1;
    13aa:	b8 ff ff ff ff       	mov    eax,0xffffffff
    13af:	e9 33 02 00 00       	jmp    15e7 <memdev_truncate+0x29b>
		}

		/* modify the file */
		write_lock(&in->in_lock);
    13b4:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    13b8:	48 05 88 00 00 00    	add    rax,0x88
    13be:	48 89 c7             	mov    rdi,rax
    13c1:	e8 00 00 00 00       	call   13c6 <memdev_truncate+0x7a>
		n = *(struct memdev_node**)in->in_pddat;
    13c6:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    13ca:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
    13d1:	48 8b 00             	mov    rax,QWORD PTR [rax]
    13d4:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		len = n->size - sizeof(struct memdev_node);
    13d8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    13dc:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    13e0:	48 83 e8 20          	sub    rax,0x20
    13e4:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		if (len > length) { /* shrink */
    13e8:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    13ec:	48 3b 45 c0          	cmp    rax,QWORD PTR [rbp-0x40]
    13f0:	7e 6f                	jle    1461 <memdev_truncate+0x115>
				size_t num_p;
				n->size = length + sizeof(struct memdev_node);
    13f2:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    13f6:	48 8d 50 20          	lea    rdx,[rax+0x20]
    13fa:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    13fe:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
				num_p = (n->cap - n->size) / 4096;
    1402:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1406:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    140a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    140e:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1412:	48 29 c2             	sub    rdx,rax
    1415:	48 89 d0             	mov    rax,rdx
    1418:	48 c1 e8 0c          	shr    rax,0xc
    141c:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
				if (num_p)
    1420:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
    1425:	0f 84 42 01 00 00    	je     156d <memdev_truncate+0x221>
						mm_free_vmem(&mm_kernel, (char*)n + n->cap - num_p * 4096, num_p);
    142b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    142f:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1433:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1437:	48 c1 e0 0c          	shl    rax,0xc
    143b:	48 29 c2             	sub    rdx,rax
    143e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1442:	48 8d 0c 02          	lea    rcx,[rdx+rax*1]
    1446:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    144a:	48 89 c2             	mov    rdx,rax
    144d:	48 89 ce             	mov    rsi,rcx
    1450:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1457:	e8 00 00 00 00       	call   145c <memdev_truncate+0x110>
    145c:	e9 0c 01 00 00       	jmp    156d <memdev_truncate+0x221>
		} else if (len < length) { /* grow */
    1461:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1465:	48 3b 45 c0          	cmp    rax,QWORD PTR [rbp-0x40]
    1469:	0f 8d fe 00 00 00    	jge    156d <memdev_truncate+0x221>
				if ((n->cap - n->size) >= (length - len))
    146f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1473:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1477:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    147b:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    147f:	48 29 c2             	sub    rdx,rax
    1482:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1486:	48 2b 45 f0          	sub    rax,QWORD PTR [rbp-0x10]
    148a:	48 39 c2             	cmp    rdx,rax
    148d:	72 15                	jb     14a4 <memdev_truncate+0x158>
						n->size = length + sizeof(struct memdev_node);
    148f:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1493:	48 8d 50 20          	lea    rdx,[rax+0x20]
    1497:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    149b:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
    149f:	e9 c9 00 00 00       	jmp    156d <memdev_truncate+0x221>
				else { /* allocate new pages */
						size_t num_p; void* mem;
						num_p = n->size + (length - len);
    14a4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    14a8:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    14ac:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    14b0:	48 2b 45 f0          	sub    rax,QWORD PTR [rbp-0x10]
    14b4:	48 01 d0             	add    rax,rdx
    14b7:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
						num_p = num_p / 4096 + ((num_p % 4096) ? 1 : 0);
    14bb:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    14bf:	48 c1 e8 0c          	shr    rax,0xc
    14c3:	48 89 c2             	mov    rdx,rax
    14c6:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    14ca:	25 ff 0f 00 00       	and    eax,0xfff
    14cf:	48 85 c0             	test   rax,rax
    14d2:	74 07                	je     14db <memdev_truncate+0x18f>
    14d4:	b8 01 00 00 00       	mov    eax,0x1
    14d9:	eb 05                	jmp    14e0 <memdev_truncate+0x194>
    14db:	b8 00 00 00 00       	mov    eax,0x0
    14e0:	48 01 d0             	add    rax,rdx
    14e3:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
						mem = mm_extend_vmem(&mm_kernel, n, n->cap / 4096, num_p,
    14e7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    14eb:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    14ef:	48 c1 e8 0c          	shr    rax,0xc
    14f3:	48 89 c6             	mov    rsi,rax
    14f6:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    14fa:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    14fe:	41 b8 0c 00 00 00    	mov    r8d,0xc
    1504:	48 89 d1             	mov    rcx,rdx
    1507:	48 89 f2             	mov    rdx,rsi
    150a:	48 89 c6             	mov    rsi,rax
    150d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1514:	e8 00 00 00 00       	call   1519 <memdev_truncate+0x1cd>
    1519:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
										MMGR_MAP_WRITE | MMGR_MAP_KERNEL);
						/* everything above size is still scrubbed -> no bzero */
						if (!mem) {
    151d:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
    1522:	75 26                	jne    154a <memdev_truncate+0x1fe>
								/* failed to extend */
								errno = EFBIG;
    1524:	c7 05 00 00 00 00 1b 00 00 00 	mov    DWORD PTR [rip+0x0],0x1b        # 152e <memdev_truncate+0x1e2>
								write_unlock(&in->in_lock);
    152e:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1532:	48 05 88 00 00 00    	add    rax,0x88
    1538:	48 89 c7             	mov    rdi,rax
    153b:	e8 00 00 00 00       	call   1540 <memdev_truncate+0x1f4>
								return -1;
    1540:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1545:	e9 9d 00 00 00       	jmp    15e7 <memdev_truncate+0x29b>
						}
						n->cap = num_p * 4096;
    154a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    154e:	48 c1 e0 0c          	shl    rax,0xc
    1552:	48 89 c2             	mov    rdx,rax
    1555:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1559:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
						n->size = length + sizeof(struct memdev_node);
    155d:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1561:	48 8d 50 20          	lea    rdx,[rax+0x20]
    1565:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1569:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
				}
		} else { } /* do nothing */

		/* clear SUID,SGID */
		in->in_stat.st_mode &= (~(mode_t)S_ISUID) & (~(mode_t)S_ISGID);
    156d:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1571:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1574:	80 e4 f3             	and    ah,0xf3
    1577:	89 c2                	mov    edx,eax
    1579:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    157d:	89 50 10             	mov    DWORD PTR [rax+0x10],edx
		in->in_stat.st_size = length;
    1580:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1584:	48 8b 55 c0          	mov    rdx,QWORD PTR [rbp-0x40]
    1588:	48 89 50 30          	mov    QWORD PTR [rax+0x30],rdx
		in->in_stat.st_blocks = n->cap / 512;
    158c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1590:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    1594:	48 c1 e8 09          	shr    rax,0x9
    1598:	48 89 c2             	mov    rdx,rax
    159b:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    159f:	48 89 50 40          	mov    QWORD PTR [rax+0x40],rdx
		/* always update c&mtim (as in ftruncate) */
		clock_gettime(CLOCK_REALTIME, &in->in_stat.st_mtim);
    15a3:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    15a7:	48 83 c0 58          	add    rax,0x58
    15ab:	48 89 c6             	mov    rsi,rax
    15ae:	bf 00 00 00 00       	mov    edi,0x0
    15b3:	e8 00 00 00 00       	call   15b8 <memdev_truncate+0x26c>
		in->in_stat.st_ctim = in->in_stat.st_mtim;
    15b8:	48 8b 4d c8          	mov    rcx,QWORD PTR [rbp-0x38]
    15bc:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    15c0:	48 8b 50 60          	mov    rdx,QWORD PTR [rax+0x60]
    15c4:	48 8b 40 58          	mov    rax,QWORD PTR [rax+0x58]
    15c8:	48 89 41 68          	mov    QWORD PTR [rcx+0x68],rax
    15cc:	48 89 51 70          	mov    QWORD PTR [rcx+0x70],rdx
		write_unlock(&in->in_lock);
    15d0:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    15d4:	48 05 88 00 00 00    	add    rax,0x88
    15da:	48 89 c7             	mov    rdi,rax
    15dd:	e8 00 00 00 00       	call   15e2 <memdev_truncate+0x296>
		return 0;
    15e2:	b8 00 00 00 00       	mov    eax,0x0
}
    15e7:	c9                   	leave
    15e8:	c3                   	ret

00000000000015e9 <memdev_search_fn>:

char* memdev_search_fn(struct memdev_node* n, const char* fn)
{
    15e9:	55                   	push   rbp
    15ea:	48 89 e5             	mov    rbp,rsp
    15ed:	48 83 ec 20          	sub    rsp,0x20
    15f1:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    15f5:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
		char *str, *end;
		str = n->data;
    15f9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    15fd:	48 83 c0 20          	add    rax,0x20
    1601:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		end = (char*)n + n->size;
    1605:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1609:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    160d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1611:	48 01 d0             	add    rax,rdx
    1614:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		while (str < end) {
    1618:	eb 31                	jmp    164b <memdev_search_fn+0x62>
				if (strcmp(str, fn) == 0) {
    161a:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    161e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1622:	48 89 d6             	mov    rsi,rdx
    1625:	48 89 c7             	mov    rdi,rax
    1628:	e8 00 00 00 00       	call   162d <memdev_search_fn+0x44>
    162d:	85 c0                	test   eax,eax
    162f:	75 06                	jne    1637 <memdev_search_fn+0x4e>
						return str;
    1631:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1635:	eb 23                	jmp    165a <memdev_search_fn+0x71>
				}
				str += strlen(str) + sizeof(void*) + 1;
    1637:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    163b:	48 89 c7             	mov    rdi,rax
    163e:	e8 00 00 00 00       	call   1643 <memdev_search_fn+0x5a>
    1643:	48 83 c0 09          	add    rax,0x9
    1647:	48 01 45 f8          	add    QWORD PTR [rbp-0x8],rax
		while (str < end) {
    164b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    164f:	48 3b 45 f0          	cmp    rax,QWORD PTR [rbp-0x10]
    1653:	72 c5                	jb     161a <memdev_search_fn+0x31>
		}
		return NULL;
    1655:	b8 00 00 00 00       	mov    eax,0x0
}
    165a:	c9                   	leave
    165b:	c3                   	ret

000000000000165c <memdev_get_subnode>:

struct inode* memdev_get_subnode(struct inode* in, const char* fn)
{
    165c:	55                   	push   rbp
    165d:	48 89 e5             	mov    rbp,rsp
    1660:	48 83 ec 40          	sub    rsp,0x40
    1664:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
    1668:	48 89 75 c0          	mov    QWORD PTR [rbp-0x40],rsi
		struct inode* rv = NULL;
    166c:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		if (!fn || (!in && strlen(fn) > 0)) {
    1674:	48 83 7d c0 00       	cmp    QWORD PTR [rbp-0x40],0x0
    1679:	74 18                	je     1693 <memdev_get_subnode+0x37>
    167b:	48 83 7d c8 00       	cmp    QWORD PTR [rbp-0x38],0x0
    1680:	75 25                	jne    16a7 <memdev_get_subnode+0x4b>
    1682:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1686:	48 89 c7             	mov    rdi,rax
    1689:	e8 00 00 00 00       	call   168e <memdev_get_subnode+0x32>
    168e:	48 85 c0             	test   rax,rax
    1691:	74 14                	je     16a7 <memdev_get_subnode+0x4b>
				errno = EINVAL;
    1693:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # 169d <memdev_get_subnode+0x41>
				return NULL;
    169d:	b8 00 00 00 00       	mov    eax,0x0
    16a2:	e9 44 02 00 00       	jmp    18eb <memdev_get_subnode+0x28f>
		}

		if (in) {
    16a7:	48 83 7d c8 00       	cmp    QWORD PTR [rbp-0x38],0x0
    16ac:	0f 84 d4 00 00 00    	je     1786 <memdev_get_subnode+0x12a>
				struct memdev_node* n; char *str;
				/* we don't handle links here. The OS should only ask
				 * for files we actually have stored on this device */
				if (in->in_stat.st_dev != 0) {
    16b2:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    16b6:	48 8b 00             	mov    rax,QWORD PTR [rax]
    16b9:	48 85 c0             	test   rax,rax
    16bc:	74 14                	je     16d2 <memdev_get_subnode+0x76>
						errno = EINVAL;
    16be:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # 16c8 <memdev_get_subnode+0x6c>
						return NULL;
    16c8:	b8 00 00 00 00       	mov    eax,0x0
    16cd:	e9 19 02 00 00       	jmp    18eb <memdev_get_subnode+0x28f>
				}
				/* check for directory */
				if (!S_ISDIR(in->in_stat.st_mode)) {
    16d2:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    16d6:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    16d9:	25 00 f0 00 00       	and    eax,0xf000
    16de:	3d 00 40 00 00       	cmp    eax,0x4000
    16e3:	74 14                	je     16f9 <memdev_get_subnode+0x9d>
						errno = ENOTDIR;
    16e5:	c7 05 00 00 00 00 14 00 00 00 	mov    DWORD PTR [rip+0x0],0x14        # 16ef <memdev_get_subnode+0x93>
						return NULL;
    16ef:	b8 00 00 00 00       	mov    eax,0x0
    16f4:	e9 f2 01 00 00       	jmp    18eb <memdev_get_subnode+0x28f>
				}

				/* now search for fn with read lock */
				n = *(struct memdev_node**)in->in_pddat;
    16f9:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    16fd:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
    1704:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1707:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
				read_lock(&in->in_lock);
    170b:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    170f:	48 05 88 00 00 00    	add    rax,0x88
    1715:	48 89 c7             	mov    rdi,rax
    1718:	e8 00 00 00 00       	call   171d <memdev_get_subnode+0xc1>
				str = memdev_search_fn(n, fn);
    171d:	48 8b 55 c0          	mov    rdx,QWORD PTR [rbp-0x40]
    1721:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1725:	48 89 d6             	mov    rsi,rdx
    1728:	48 89 c7             	mov    rdi,rax
    172b:	e8 00 00 00 00       	call   1730 <memdev_get_subnode+0xd4>
    1730:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
				if (str) {
    1734:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
    1739:	74 1f                	je     175a <memdev_get_subnode+0xfe>
						str += strlen(str) + 1;
    173b:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    173f:	48 89 c7             	mov    rdi,rax
    1742:	e8 00 00 00 00       	call   1747 <memdev_get_subnode+0xeb>
    1747:	48 83 c0 01          	add    rax,0x1
    174b:	48 01 45 d8          	add    QWORD PTR [rbp-0x28],rax
						rv = *(void**)str;
    174f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1753:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1756:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				}
				/* update access time <- NO only if opening the dir */
				/*clock_gettime(CLOCK_REALTIME, &in->in_stat.st_atim);*/
				read_unlock(&in->in_lock);
    175a:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    175e:	48 05 88 00 00 00    	add    rax,0x88
    1764:	48 89 c7             	mov    rdi,rax
    1767:	e8 00 00 00 00       	call   176c <memdev_get_subnode+0x110>
				if (!rv)
    176c:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    1771:	75 0a                	jne    177d <memdev_get_subnode+0x121>
						errno = ENOENT;
    1773:	c7 05 00 00 00 00 02 00 00 00 	mov    DWORD PTR [rip+0x0],0x2        # 177d <memdev_get_subnode+0x121>
				return rv;
    177d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1781:	e9 65 01 00 00       	jmp    18eb <memdev_get_subnode+0x28f>
		}

		/* return root node */
		if (memdev_data->node_ct == 0) {
    1786:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 178d <memdev_get_subnode+0x131>
    178d:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    1791:	48 85 c0             	test   rax,rax
    1794:	0f 85 3f 01 00 00    	jne    18d9 <memdev_get_subnode+0x27d>
				/* create root directory first */
				void* mem = h_malloc(memdev_data->heap, 128 + sizeof(struct memdev_node));
    179a:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 17a1 <memdev_get_subnode+0x145>
    17a1:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    17a5:	be a0 00 00 00       	mov    esi,0xa0
    17aa:	48 89 c7             	mov    rdi,rax
    17ad:	e8 00 00 00 00       	call   17b2 <memdev_get_subnode+0x156>
    17b2:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				struct memdev_node* n = (struct memdev_node*)mem;
    17b6:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    17ba:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				if (!mem)
    17be:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
    17c3:	75 0a                	jne    17cf <memdev_get_subnode+0x173>
						return NULL;
    17c5:	b8 00 00 00 00       	mov    eax,0x0
    17ca:	e9 1c 01 00 00       	jmp    18eb <memdev_get_subnode+0x28f>
				n->cap = 128 + sizeof(struct memdev_node);
    17cf:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    17d3:	48 c7 40 10 a0 00 00 00 	mov    QWORD PTR [rax+0x10],0xa0
				n->size = sizeof(struct memdev_node);
    17db:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    17df:	48 c7 40 08 20 00 00 00 	mov    QWORD PTR [rax+0x8],0x20
				n->file = S_IFDIR;
    17e7:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    17eb:	c7 00 00 40 00 00    	mov    DWORD PTR [rax],0x4000
				rv = n->ino = ino_allocate(S_IFDIR);
    17f1:	bf 00 40 00 00       	mov    edi,0x4000
    17f6:	e8 00 00 00 00       	call   17fb <memdev_get_subnode+0x19f>
    17fb:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    17ff:	48 89 42 18          	mov    QWORD PTR [rdx+0x18],rax
    1803:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1807:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    180b:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				if (!rv) {
    180f:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    1814:	75 24                	jne    183a <memdev_get_subnode+0x1de>
						h_free(memdev_data->heap, mem);
    1816:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 181d <memdev_get_subnode+0x1c1>
    181d:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    1821:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1825:	48 89 d6             	mov    rsi,rdx
    1828:	48 89 c7             	mov    rdi,rax
    182b:	e8 00 00 00 00       	call   1830 <memdev_get_subnode+0x1d4>
						return NULL;
    1830:	b8 00 00 00 00       	mov    eax,0x0
    1835:	e9 b1 00 00 00       	jmp    18eb <memdev_get_subnode+0x28f>
				}
				rv->in_stat.st_dev = memdev_data->id;
    183a:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1841 <memdev_get_subnode+0x1e5>
    1841:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    1844:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1848:	48 89 10             	mov    QWORD PTR [rax],rdx
				rv->in_stat.st_blksize = 4096; /* 4096/512 */
    184b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    184f:	48 c7 40 38 00 10 00 00 	mov    QWORD PTR [rax+0x38],0x1000
				rv->in_stat.st_blocks = 8;
    1857:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    185b:	48 c7 40 40 08 00 00 00 	mov    QWORD PTR [rax+0x40],0x8
				rv->in_stat.st_size = 0; /* actual size */
    1863:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1867:	48 c7 40 30 00 00 00 00 	mov    QWORD PTR [rax+0x30],0x0
				rv->in_pddat = memdev_store_node(n);
    186f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1873:	48 89 c7             	mov    rdi,rax
    1876:	e8 00 00 00 00       	call   187b <memdev_get_subnode+0x21f>
    187b:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    187f:	48 89 82 80 00 00 00 	mov    QWORD PTR [rdx+0x80],rax
				if (!rv->in_pddat) {
    1886:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    188a:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
    1891:	48 85 c0             	test   rax,rax
    1894:	75 31                	jne    18c7 <memdev_get_subnode+0x26b>
						ino_release(n->ino);
    1896:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    189a:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    189e:	48 89 c7             	mov    rdi,rax
    18a1:	e8 00 00 00 00       	call   18a6 <memdev_get_subnode+0x24a>
						h_free(memdev_data->heap, mem);
    18a6:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 18ad <memdev_get_subnode+0x251>
    18ad:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    18b1:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    18b5:	48 89 d6             	mov    rsi,rdx
    18b8:	48 89 c7             	mov    rdi,rax
    18bb:	e8 00 00 00 00       	call   18c0 <memdev_get_subnode+0x264>
						return NULL;
    18c0:	b8 00 00 00 00       	mov    eax,0x0
    18c5:	eb 24                	jmp    18eb <memdev_get_subnode+0x28f>
				}
				rv->in_stat.st_nlink = 1; /* NEVER free / on close() */
    18c7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    18cb:	48 c7 40 18 01 00 00 00 	mov    QWORD PTR [rax+0x18],0x1
				return rv;
    18d3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    18d7:	eb 12                	jmp    18eb <memdev_get_subnode+0x28f>
		} else
				return memdev_data->nodes[0]->ino;
    18d9:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 18e0 <memdev_get_subnode+0x284>
    18e0:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    18e4:	48 8b 00             	mov    rax,QWORD PTR [rax]
    18e7:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
}
    18eb:	c9                   	leave
    18ec:	c3                   	ret

00000000000018ed <memdev_unlink>:

int memdev_unlink(struct inode* in0, struct inode* in1)
{
    18ed:	55                   	push   rbp
    18ee:	48 89 e5             	mov    rbp,rsp
    18f1:	48 83 ec 50          	sub    rsp,0x50
    18f5:	48 89 7d b8          	mov    QWORD PTR [rbp-0x48],rdi
    18f9:	48 89 75 b0          	mov    QWORD PTR [rbp-0x50],rsi
		struct timespec t;
		if (!in1 || (in0 && in0->in_stat.st_dev != memdev_data->id)) {
    18fd:	48 83 7d b0 00       	cmp    QWORD PTR [rbp-0x50],0x0
    1902:	74 1d                	je     1921 <memdev_unlink+0x34>
    1904:	48 83 7d b8 00       	cmp    QWORD PTR [rbp-0x48],0x0
    1909:	74 2a                	je     1935 <memdev_unlink+0x48>
    190b:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    190f:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    1912:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1919 <memdev_unlink+0x2c>
    1919:	48 8b 00             	mov    rax,QWORD PTR [rax]
    191c:	48 39 c2             	cmp    rdx,rax
    191f:	74 14                	je     1935 <memdev_unlink+0x48>
				errno = EINVAL;
    1921:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # 192b <memdev_unlink+0x3e>
				return -1;
    192b:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1930:	e9 ce 03 00 00       	jmp    1d03 <memdev_unlink+0x416>
		}

		if (in0) { /* remove link from source dir(!)  */
    1935:	48 83 7d b8 00       	cmp    QWORD PTR [rbp-0x48],0x0
    193a:	0f 84 f1 01 00 00    	je     1b31 <memdev_unlink+0x244>
				struct memdev_node* n; char* fn;
				if (!(in0->in_stat.st_mode & S_IFDIR)) {
    1940:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1944:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1947:	25 00 40 00 00       	and    eax,0x4000
    194c:	85 c0                	test   eax,eax
    194e:	75 14                	jne    1964 <memdev_unlink+0x77>
						errno = ENOTDIR;
    1950:	c7 05 00 00 00 00 14 00 00 00 	mov    DWORD PTR [rip+0x0],0x14        # 195a <memdev_unlink+0x6d>
						return -1;
    195a:	b8 ff ff ff ff       	mov    eax,0xffffffff
    195f:	e9 9f 03 00 00       	jmp    1d03 <memdev_unlink+0x416>
				}

				n = *(struct memdev_node**)in0->in_pddat;
    1964:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1968:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
    196f:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1972:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				/* now modify the directory */
				write_lock(&in0->in_lock);
    1976:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    197a:	48 05 88 00 00 00    	add    rax,0x88
    1980:	48 89 c7             	mov    rdi,rax
    1983:	e8 00 00 00 00       	call   1988 <memdev_unlink+0x9b>
				fn = n->data;
    1988:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    198c:	48 83 c0 20          	add    rax,0x20
    1990:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				while (fn < (char*)n + n->size) {
    1994:	e9 52 01 00 00       	jmp    1aeb <memdev_unlink+0x1fe>
						char* fn2 = fn + strlen(fn) + 1;
    1999:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    199d:	48 89 c7             	mov    rdi,rax
    19a0:	e8 00 00 00 00       	call   19a5 <memdev_unlink+0xb8>
    19a5:	48 8d 50 01          	lea    rdx,[rax+0x1]
    19a9:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    19ad:	48 01 d0             	add    rax,rdx
    19b0:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
						if (*(struct inode**)fn2 == in1) {
    19b4:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    19b8:	48 8b 00             	mov    rax,QWORD PTR [rax]
    19bb:	48 39 45 b0          	cmp    QWORD PTR [rbp-0x50],rax
    19bf:	0f 85 1a 01 00 00    	jne    1adf <memdev_unlink+0x1f2>
								/* found the entry */
								fn2 += sizeof(struct inode*);
    19c5:	48 83 45 e8 08       	add    QWORD PTR [rbp-0x18],0x8
								memmove(fn, fn2, (char*)n + n->size - fn2);
    19ca:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    19ce:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    19d2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    19d6:	48 01 d0             	add    rax,rdx
    19d9:	48 2b 45 e8          	sub    rax,QWORD PTR [rbp-0x18]
    19dd:	48 89 c2             	mov    rdx,rax
    19e0:	48 8b 4d e8          	mov    rcx,QWORD PTR [rbp-0x18]
    19e4:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    19e8:	48 89 ce             	mov    rsi,rcx
    19eb:	48 89 c7             	mov    rdi,rax
    19ee:	e8 00 00 00 00       	call   19f3 <memdev_unlink+0x106>
								n->size -= fn2 - fn;
    19f3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    19f7:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    19fb:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    19ff:	48 2b 45 f0          	sub    rax,QWORD PTR [rbp-0x10]
    1a03:	48 29 c2             	sub    rdx,rax
    1a06:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1a0a:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
								if (n->size > 128 + sizeof(struct memdev_node)) {
    1a0e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1a12:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1a16:	48 3d a0 00 00 00    	cmp    rax,0xa0
    1a1c:	76 65                	jbe    1a83 <memdev_unlink+0x196>
										/* shrink a bit */
										if (n->cap - n->size > 64) {
    1a1e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1a22:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1a26:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1a2a:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1a2e:	48 29 c2             	sub    rdx,rax
    1a31:	48 83 fa 40          	cmp    rdx,0x40
    1a35:	76 4c                	jbe    1a83 <memdev_unlink+0x196>
												n->cap = n->size + 64;
    1a37:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1a3b:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1a3f:	48 8d 50 40          	lea    rdx,[rax+0x40]
    1a43:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1a47:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
												*(struct memdev_node**)in0->in_pddat
													   	= n = h_realloc(memdev_data->heap,
    1a4b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1a4f:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1a53:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1a5a <memdev_unlink+0x16d>
    1a5a:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    1a5e:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    1a62:	48 89 ce             	mov    rsi,rcx
    1a65:	48 89 c7             	mov    rdi,rax
    1a68:	e8 00 00 00 00       	call   1a6d <memdev_unlink+0x180>
    1a6d:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
												*(struct memdev_node**)in0->in_pddat
    1a71:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1a75:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
													   	= n = h_realloc(memdev_data->heap,
    1a7c:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    1a80:	48 89 10             	mov    QWORD PTR [rax],rdx
																		n, n->cap);
												/* will never happen as shrink works in-place */
										}
								}
								n = NULL; /* signify found */
    1a83:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
								in0->in_stat.st_size = n->size - sizeof(struct memdev_node);
    1a8b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1a8f:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1a93:	48 83 e8 20          	sub    rax,0x20
    1a97:	48 89 c2             	mov    rdx,rax
    1a9a:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1a9e:	48 89 50 30          	mov    QWORD PTR [rax+0x30],rdx
								in0->in_stat.st_blocks = n->cap / 512 + (n->cap % 512 ? 1 : 0);
    1aa2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1aa6:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    1aaa:	48 c1 e8 09          	shr    rax,0x9
    1aae:	48 89 c2             	mov    rdx,rax
    1ab1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1ab5:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    1ab9:	25 ff 01 00 00       	and    eax,0x1ff
    1abe:	48 85 c0             	test   rax,rax
    1ac1:	74 07                	je     1aca <memdev_unlink+0x1dd>
    1ac3:	b8 01 00 00 00       	mov    eax,0x1
    1ac8:	eb 05                	jmp    1acf <memdev_unlink+0x1e2>
    1aca:	b8 00 00 00 00       	mov    eax,0x0
    1acf:	48 01 d0             	add    rax,rdx
    1ad2:	48 89 c2             	mov    rdx,rax
    1ad5:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1ad9:	48 89 50 40          	mov    QWORD PTR [rax+0x40],rdx
								break;
    1add:	eb 25                	jmp    1b04 <memdev_unlink+0x217>
						} else
								fn = fn2 + sizeof(struct inode*);
    1adf:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1ae3:	48 83 c0 08          	add    rax,0x8
    1ae7:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				while (fn < (char*)n + n->size) {
    1aeb:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1aef:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    1af3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1af7:	48 01 d0             	add    rax,rdx
    1afa:	48 39 45 f0          	cmp    QWORD PTR [rbp-0x10],rax
    1afe:	0f 82 95 fe ff ff    	jb     1999 <memdev_unlink+0xac>
				}
				write_unlock(&in0->in_lock);
    1b04:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1b08:	48 05 88 00 00 00    	add    rax,0x88
    1b0e:	48 89 c7             	mov    rdi,rax
    1b11:	e8 00 00 00 00       	call   1b16 <memdev_unlink+0x229>
				if (!n) {
    1b16:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    1b1b:	75 14                	jne    1b31 <memdev_unlink+0x244>
						errno = ENOENT;
    1b1d:	c7 05 00 00 00 00 02 00 00 00 	mov    DWORD PTR [rip+0x0],0x2        # 1b27 <memdev_unlink+0x23a>
						return -1;
    1b27:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1b2c:	e9 d2 01 00 00       	jmp    1d03 <memdev_unlink+0x416>
				}
		}

		/* get current time */
		clock_gettime(CLOCK_REALTIME, &t);
    1b31:	48 8d 45 c0          	lea    rax,[rbp-0x40]
    1b35:	48 89 c6             	mov    rsi,rax
    1b38:	bf 00 00 00 00       	mov    edi,0x0
    1b3d:	e8 00 00 00 00       	call   1b42 <memdev_unlink+0x255>
		if (in0)
    1b42:	48 83 7d b8 00       	cmp    QWORD PTR [rbp-0x48],0x0
    1b47:	74 2c                	je     1b75 <memdev_unlink+0x288>
				in0->in_stat.st_mtim = in0->in_stat.st_ctim = t;
    1b49:	48 8b 4d b8          	mov    rcx,QWORD PTR [rbp-0x48]
    1b4d:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1b51:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    1b55:	48 89 41 68          	mov    QWORD PTR [rcx+0x68],rax
    1b59:	48 89 51 70          	mov    QWORD PTR [rcx+0x70],rdx
    1b5d:	48 8b 4d b8          	mov    rcx,QWORD PTR [rbp-0x48]
    1b61:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1b65:	48 8b 50 70          	mov    rdx,QWORD PTR [rax+0x70]
    1b69:	48 8b 40 68          	mov    rax,QWORD PTR [rax+0x68]
    1b6d:	48 89 41 58          	mov    QWORD PTR [rcx+0x58],rax
    1b71:	48 89 51 60          	mov    QWORD PTR [rcx+0x60],rdx

		/* now unlink the node */
		if (in1->in_stat.st_dev != memdev_data->id) {
    1b75:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1b79:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    1b7c:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1b83 <memdev_unlink+0x296>
    1b83:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1b86:	48 39 c2             	cmp    rdx,rax
    1b89:	0f 84 9a 00 00 00    	je     1c29 <memdev_unlink+0x33c>
				const struct device_desc* dd = get_device(in1->in_stat.st_dev);
    1b8f:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1b93:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1b96:	48 89 c7             	mov    rdi,rax
    1b99:	e8 00 00 00 00       	call   1b9e <memdev_unlink+0x2b1>
    1b9e:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
				if (!dd) {
    1ba2:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
    1ba7:	75 65                	jne    1c0e <memdev_unlink+0x321>
						cprintf(KFMT_WARN, "unable to locate device %u"
										" for unlinking inode at %p\n",
										(uint32_t)in1->in_stat.st_dev, in1);
    1ba9:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1bad:	48 8b 00             	mov    rax,QWORD PTR [rax]
						cprintf(KFMT_WARN, "unable to locate device %u"
    1bb0:	89 c2                	mov    edx,eax
    1bb2:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1bb6:	48 89 c1             	mov    rcx,rax
    1bb9:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1bc0:	bf 0e 00 00 00       	mov    edi,0xe
    1bc5:	b8 00 00 00 00       	mov    eax,0x0
    1bca:	e8 00 00 00 00       	call   1bcf <memdev_unlink+0x2e2>
						if (__sync_sub_and_fetch(&in1->in_stat.st_dev, 1) == 0)
    1bcf:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
    1bd3:	b8 01 00 00 00       	mov    eax,0x1
    1bd8:	48 f7 d8             	neg    rax
    1bdb:	48 89 c1             	mov    rcx,rax
    1bde:	48 89 c8             	mov    rax,rcx
    1be1:	f0 48 0f c1 02       	lock xadd QWORD PTR [rdx],rax
    1be6:	48 01 c8             	add    rax,rcx
    1be9:	48 85 c0             	test   rax,rax
    1bec:	75 0c                	jne    1bfa <memdev_unlink+0x30d>
								ino_release(in1); /* clean up partially */
    1bee:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1bf2:	48 89 c7             	mov    rdi,rax
    1bf5:	e8 00 00 00 00       	call   1bfa <memdev_unlink+0x30d>
						errno = ENODEV;
    1bfa:	c7 05 00 00 00 00 13 00 00 00 	mov    DWORD PTR [rip+0x0],0x13        # 1c04 <memdev_unlink+0x317>
						return 0; /* only warn */
    1c04:	b8 00 00 00 00       	mov    eax,0x0
    1c09:	e9 f5 00 00 00       	jmp    1d03 <memdev_unlink+0x416>
				} else {
						return dd->fn_unlink(NULL, in1);
    1c0e:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1c12:	48 8b 50 58          	mov    rdx,QWORD PTR [rax+0x58]
    1c16:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1c1a:	48 89 c6             	mov    rsi,rax
    1c1d:	bf 00 00 00 00       	mov    edi,0x0
    1c22:	ff d2                	call   rdx
    1c24:	e9 da 00 00 00       	jmp    1d03 <memdev_unlink+0x416>
				}
		} else {
				if ((__sync_sub_and_fetch(&in1->in_stat.st_nlink, 1) == 0) &&
    1c29:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1c2d:	48 8d 50 18          	lea    rdx,[rax+0x18]
    1c31:	b8 01 00 00 00       	mov    eax,0x1
    1c36:	48 f7 d8             	neg    rax
    1c39:	48 89 c1             	mov    rcx,rax
    1c3c:	48 89 c8             	mov    rax,rcx
    1c3f:	f0 48 0f c1 02       	lock xadd QWORD PTR [rdx],rax
    1c44:	48 01 c8             	add    rax,rcx
    1c47:	48 85 c0             	test   rax,rax
    1c4a:	0f 85 9a 00 00 00    	jne    1cea <memdev_unlink+0x3fd>
					(*(int*)in1->in_ddat == 0)) {
    1c50:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1c54:	48 83 c0 78          	add    rax,0x78
    1c58:	8b 00                	mov    eax,DWORD PTR [rax]
				if ((__sync_sub_and_fetch(&in1->in_stat.st_nlink, 1) == 0) &&
    1c5a:	85 c0                	test   eax,eax
    1c5c:	0f 85 88 00 00 00    	jne    1cea <memdev_unlink+0x3fd>
						struct memdev_node* n;
						/* this was the last link & no open FDs so remove the node */
						n = *(struct memdev_node**)in1->in_pddat;
    1c62:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1c66:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
    1c6d:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1c70:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
						*(struct memdev_node**)in1->in_pddat = NULL; /* free slot */
    1c74:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1c78:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
    1c7f:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
						if (S_ISREG(in1->in_stat.st_mode))
    1c86:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1c8a:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1c8d:	25 00 f0 00 00       	and    eax,0xf000
    1c92:	3d 00 80 00 00       	cmp    eax,0x8000
    1c97:	75 24                	jne    1cbd <memdev_unlink+0x3d0>
								mm_free_vmem(&mm_kernel, n, n->cap / 4096);
    1c99:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1c9d:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    1ca1:	48 c1 e8 0c          	shr    rax,0xc
    1ca5:	48 89 c2             	mov    rdx,rax
    1ca8:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1cac:	48 89 c6             	mov    rsi,rax
    1caf:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1cb6:	e8 00 00 00 00       	call   1cbb <memdev_unlink+0x3ce>
    1cbb:	eb 1a                	jmp    1cd7 <memdev_unlink+0x3ea>
						else
								h_free(memdev_data->heap, n);
    1cbd:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1cc4 <memdev_unlink+0x3d7>
    1cc4:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    1cc8:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    1ccc:	48 89 d6             	mov    rsi,rdx
    1ccf:	48 89 c7             	mov    rdi,rax
    1cd2:	e8 00 00 00 00       	call   1cd7 <memdev_unlink+0x3ea>
						ino_release(in1);
    1cd7:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1cdb:	48 89 c7             	mov    rdi,rax
    1cde:	e8 00 00 00 00       	call   1ce3 <memdev_unlink+0x3f6>
						return 0;
    1ce3:	b8 00 00 00 00       	mov    eax,0x0
    1ce8:	eb 19                	jmp    1d03 <memdev_unlink+0x416>
				}
				in1->in_stat.st_ctim = t;
    1cea:	48 8b 4d b0          	mov    rcx,QWORD PTR [rbp-0x50]
    1cee:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1cf2:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    1cf6:	48 89 41 68          	mov    QWORD PTR [rcx+0x68],rax
    1cfa:	48 89 51 70          	mov    QWORD PTR [rcx+0x70],rdx
				return 0;
    1cfe:	b8 00 00 00 00       	mov    eax,0x0
		}
}
    1d03:	c9                   	leave
    1d04:	c3                   	ret

0000000000001d05 <memdev_set_subnode>:

int memdev_set_subnode(struct inode* in0, struct inode* in1, const char* fn)
{
    1d05:	55                   	push   rbp
    1d06:	48 89 e5             	mov    rbp,rsp
    1d09:	53                   	push   rbx
    1d0a:	48 83 ec 78          	sub    rsp,0x78
    1d0e:	48 89 7d 98          	mov    QWORD PTR [rbp-0x68],rdi
    1d12:	48 89 75 90          	mov    QWORD PTR [rbp-0x70],rsi
    1d16:	48 89 55 88          	mov    QWORD PTR [rbp-0x78],rdx
		struct memdev_node *n0, *n1 = NULL;
    1d1a:	48 c7 45 c8 00 00 00 00 	mov    QWORD PTR [rbp-0x38],0x0
		if (!in0 || !fn || in0->in_stat.st_dev != memdev_data->id) {
    1d22:	48 83 7d 98 00       	cmp    QWORD PTR [rbp-0x68],0x0
    1d27:	74 1d                	je     1d46 <memdev_set_subnode+0x41>
    1d29:	48 83 7d 88 00       	cmp    QWORD PTR [rbp-0x78],0x0
    1d2e:	74 16                	je     1d46 <memdev_set_subnode+0x41>
    1d30:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1d34:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    1d37:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1d3e <memdev_set_subnode+0x39>
    1d3e:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1d41:	48 39 c2             	cmp    rdx,rax
    1d44:	74 14                	je     1d5a <memdev_set_subnode+0x55>
				errno = EINVAL;
    1d46:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # 1d50 <memdev_set_subnode+0x4b>
				return -1;
    1d50:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1d55:	e9 95 06 00 00       	jmp    23ef <memdev_set_subnode+0x6ea>
		}

		/* inode in0 on this device and directory */
		if (!(in0->in_stat.st_mode & S_IFDIR)) {
    1d5a:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1d5e:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1d61:	25 00 40 00 00       	and    eax,0x4000
    1d66:	85 c0                	test   eax,eax
    1d68:	75 14                	jne    1d7e <memdev_set_subnode+0x79>
				errno = ENOTDIR;
    1d6a:	c7 05 00 00 00 00 14 00 00 00 	mov    DWORD PTR [rip+0x0],0x14        # 1d74 <memdev_set_subnode+0x6f>
				return -1;
    1d74:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1d79:	e9 71 06 00 00       	jmp    23ef <memdev_set_subnode+0x6ea>
		}
		n0 = *(struct memdev_node**)in0->in_pddat;
    1d7e:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1d82:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
    1d89:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1d8c:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax

		/* create REAL in1 if dummy for creation */
		if (!in1) { /* unlink */
    1d90:	48 83 7d 90 00       	cmp    QWORD PTR [rbp-0x70],0x0
    1d95:	75 40                	jne    1dd7 <memdev_set_subnode+0xd2>
				/* convenience function */
				in1 = memdev_get_subnode(in0, fn);
    1d97:	48 8b 55 88          	mov    rdx,QWORD PTR [rbp-0x78]
    1d9b:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1d9f:	48 89 d6             	mov    rsi,rdx
    1da2:	48 89 c7             	mov    rdi,rax
    1da5:	e8 00 00 00 00       	call   1daa <memdev_set_subnode+0xa5>
    1daa:	48 89 45 90          	mov    QWORD PTR [rbp-0x70],rax
				if (!in1)
    1dae:	48 83 7d 90 00       	cmp    QWORD PTR [rbp-0x70],0x0
    1db3:	75 0a                	jne    1dbf <memdev_set_subnode+0xba>
						return -1;
    1db5:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1dba:	e9 30 06 00 00       	jmp    23ef <memdev_set_subnode+0x6ea>
				return memdev_unlink(in0, in1);
    1dbf:	48 8b 55 90          	mov    rdx,QWORD PTR [rbp-0x70]
    1dc3:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1dc7:	48 89 d6             	mov    rsi,rdx
    1dca:	48 89 c7             	mov    rdi,rax
    1dcd:	e8 00 00 00 00       	call   1dd2 <memdev_set_subnode+0xcd>
    1dd2:	e9 18 06 00 00       	jmp    23ef <memdev_set_subnode+0x6ea>
		} else if (in1->in_stat.st_dev == INVALID_DEVICE) {
    1dd7:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1ddb:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1dde:	48 83 f8 ff          	cmp    rax,0xffffffffffffffff
    1de2:	0f 85 c5 02 00 00    	jne    20ad <memdev_set_subnode+0x3a8>
				void* mem = NULL; size_t s;
    1de8:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
				/* only allow dirs, files and links */
				if (!S_ISDIR(in1->in_stat.st_mode) &&
    1df0:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1df4:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1df7:	25 00 f0 00 00       	and    eax,0xf000
    1dfc:	3d 00 40 00 00       	cmp    eax,0x4000
    1e01:	74 3a                	je     1e3d <memdev_set_subnode+0x138>
					!S_ISREG(in1->in_stat.st_mode) &&
    1e03:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1e07:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1e0a:	25 00 f0 00 00       	and    eax,0xf000
				if (!S_ISDIR(in1->in_stat.st_mode) &&
    1e0f:	3d 00 80 00 00       	cmp    eax,0x8000
    1e14:	74 27                	je     1e3d <memdev_set_subnode+0x138>
					!S_ISLNK(in1->in_stat.st_mode)) {
    1e16:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1e1a:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1e1d:	25 00 f0 00 00       	and    eax,0xf000
					!S_ISREG(in1->in_stat.st_mode) &&
    1e22:	3d 00 a0 00 00       	cmp    eax,0xa000
    1e27:	74 14                	je     1e3d <memdev_set_subnode+0x138>
						errno = ENOTSUP;
    1e29:	c7 05 00 00 00 00 5f 00 00 00 	mov    DWORD PTR [rip+0x0],0x5f        # 1e33 <memdev_set_subnode+0x12e>
						return -1;
    1e33:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1e38:	e9 b2 05 00 00       	jmp    23ef <memdev_set_subnode+0x6ea>
				}
				/* calculate the size of the memory */
				if (in1->in_stat.st_size)
    1e3d:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1e41:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
    1e45:	48 85 c0             	test   rax,rax
    1e48:	74 31                	je     1e7b <memdev_set_subnode+0x176>
						s = in1->in_stat.st_size + sizeof(struct memdev_node)
    1e4a:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1e4e:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
    1e52:	48 89 c2             	mov    rdx,rax
								+ (S_ISREG(in1->in_stat.st_mode) ? 0 : 1);
    1e55:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1e59:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1e5c:	25 00 f0 00 00       	and    eax,0xf000
    1e61:	3d 00 80 00 00       	cmp    eax,0x8000
    1e66:	0f 95 c0             	setne  al
    1e69:	0f b6 c0             	movzx  eax,al
    1e6c:	48 98                	cdqe
    1e6e:	48 01 d0             	add    rax,rdx
						s = in1->in_stat.st_size + sizeof(struct memdev_node)
    1e71:	48 83 c0 20          	add    rax,0x20
    1e75:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
    1e79:	eb 42                	jmp    1ebd <memdev_set_subnode+0x1b8>
				else if (S_ISDIR(in1->in_stat.st_mode))
    1e7b:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1e7f:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1e82:	25 00 f0 00 00       	and    eax,0xf000
    1e87:	3d 00 40 00 00       	cmp    eax,0x4000
    1e8c:	75 0a                	jne    1e98 <memdev_set_subnode+0x193>
						s = 128 + sizeof(struct memdev_node); /* default dir capacity */
    1e8e:	48 c7 45 d8 a0 00 00 00 	mov    QWORD PTR [rbp-0x28],0xa0
    1e96:	eb 25                	jmp    1ebd <memdev_set_subnode+0x1b8>
				else if (S_ISLNK(in1->in_stat.st_mode))
    1e98:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1e9c:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1e9f:	25 00 f0 00 00       	and    eax,0xf000
    1ea4:	3d 00 a0 00 00       	cmp    eax,0xa000
    1ea9:	75 0a                	jne    1eb5 <memdev_set_subnode+0x1b0>
						s = 32 + sizeof(struct memdev_node); /* default link length */
    1eab:	48 c7 45 d8 40 00 00 00 	mov    QWORD PTR [rbp-0x28],0x40
    1eb3:	eb 08                	jmp    1ebd <memdev_set_subnode+0x1b8>
				else
						s = 4096; /* default file size */
    1eb5:	48 c7 45 d8 00 10 00 00 	mov    QWORD PTR [rbp-0x28],0x1000

				/* get some memory for the memfile */
				if (S_ISREG(in1->in_stat.st_mode)) {
    1ebd:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1ec1:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1ec4:	25 00 f0 00 00       	and    eax,0xf000
    1ec9:	3d 00 80 00 00       	cmp    eax,0x8000
    1ece:	75 49                	jne    1f19 <memdev_set_subnode+0x214>
						if (s % 4096)
    1ed0:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1ed4:	25 ff 0f 00 00       	and    eax,0xfff
    1ed9:	48 85 c0             	test   rax,rax
    1edc:	74 14                	je     1ef2 <memdev_set_subnode+0x1ed>
								s += 4096 - (s % 4096);
    1ede:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1ee2:	48 25 00 f0 ff ff    	and    rax,0xfffffffffffff000
    1ee8:	48 05 00 10 00 00    	add    rax,0x1000
    1eee:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
						mem = mm_alloc_vmem(&mm_kernel, NULL, s / 4096,
    1ef2:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1ef6:	48 c1 e8 0c          	shr    rax,0xc
    1efa:	b9 0c 00 00 00       	mov    ecx,0xc
    1eff:	48 89 c2             	mov    rdx,rax
    1f02:	be 00 00 00 00       	mov    esi,0x0
    1f07:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1f0e:	e8 00 00 00 00       	call   1f13 <memdev_set_subnode+0x20e>
    1f13:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    1f17:	eb 1e                	jmp    1f37 <memdev_set_subnode+0x232>
										MMGR_MAP_KERNEL | MMGR_MAP_WRITE);
				} else
						mem = h_malloc(memdev_data->heap, s);
    1f19:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1f20 <memdev_set_subnode+0x21b>
    1f20:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    1f24:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    1f28:	48 89 d6             	mov    rsi,rdx
    1f2b:	48 89 c7             	mov    rdi,rax
    1f2e:	e8 00 00 00 00       	call   1f33 <memdev_set_subnode+0x22e>
    1f33:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
				if (!mem)
    1f37:	48 83 7d e0 00       	cmp    QWORD PTR [rbp-0x20],0x0
    1f3c:	75 0a                	jne    1f48 <memdev_set_subnode+0x243>
						return -1;
    1f3e:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1f43:	e9 a7 04 00 00       	jmp    23ef <memdev_set_subnode+0x6ea>
				/* now we have clean pages or heap memory */
				n1 = (struct memdev_node*)mem;
    1f48:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1f4c:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
				n1->cap = s;
    1f50:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1f54:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    1f58:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
				n1->size = sizeof(struct memdev_node);
    1f5c:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1f60:	48 c7 40 08 20 00 00 00 	mov    QWORD PTR [rax+0x8],0x20
				n1->file = in1->in_stat.st_mode;
    1f68:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1f6c:	8b 50 10             	mov    edx,DWORD PTR [rax+0x10]
    1f6f:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1f73:	89 10                	mov    DWORD PTR [rax],edx
				n1->ino = ino_allocate(in1->in_stat.st_mode & S_IFMT);
    1f75:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1f79:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    1f7c:	25 00 f0 00 00       	and    eax,0xf000
    1f81:	89 c7                	mov    edi,eax
    1f83:	e8 00 00 00 00       	call   1f88 <memdev_set_subnode+0x283>
    1f88:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    1f8c:	48 89 42 18          	mov    QWORD PTR [rdx+0x18],rax
				if (!n1->ino) { /* undo much */
    1f90:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1f94:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    1f98:	48 85 c0             	test   rax,rax
    1f9b:	75 57                	jne    1ff4 <memdev_set_subnode+0x2ef>
free_mem:
    1f9d:	90                   	nop
						if (S_ISREG(n1->file))
    1f9e:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1fa2:	8b 00                	mov    eax,DWORD PTR [rax]
    1fa4:	25 00 f0 00 00       	and    eax,0xf000
    1fa9:	3d 00 80 00 00       	cmp    eax,0x8000
    1fae:	75 20                	jne    1fd0 <memdev_set_subnode+0x2cb>
								mm_free_vmem(&mm_kernel, n1, s / 4096);
    1fb0:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1fb4:	48 c1 e8 0c          	shr    rax,0xc
    1fb8:	48 89 c2             	mov    rdx,rax
    1fbb:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1fbf:	48 89 c6             	mov    rsi,rax
    1fc2:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1fc9:	e8 00 00 00 00       	call   1fce <memdev_set_subnode+0x2c9>
    1fce:	eb 1a                	jmp    1fea <memdev_set_subnode+0x2e5>
						else
								h_free(memdev_data->heap, n1);
    1fd0:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 1fd7 <memdev_set_subnode+0x2d2>
    1fd7:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    1fdb:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    1fdf:	48 89 d6             	mov    rsi,rdx
    1fe2:	48 89 c7             	mov    rdi,rax
    1fe5:	e8 00 00 00 00       	call   1fea <memdev_set_subnode+0x2e5>
						return -1;
    1fea:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1fef:	e9 fb 03 00 00       	jmp    23ef <memdev_set_subnode+0x6ea>
				}
				/* and the inode */
				n1->ino->in_stat.st_blksize = 4096;
    1ff4:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1ff8:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    1ffc:	48 c7 40 38 00 10 00 00 	mov    QWORD PTR [rax+0x38],0x1000
				n1->ino->in_stat.st_blocks = s / 512 + ((s % 512) ? 1 : 0);
    2004:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2008:	48 c1 e8 09          	shr    rax,0x9
    200c:	48 89 c2             	mov    rdx,rax
    200f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2013:	25 ff 01 00 00       	and    eax,0x1ff
    2018:	48 85 c0             	test   rax,rax
    201b:	74 07                	je     2024 <memdev_set_subnode+0x31f>
    201d:	b8 01 00 00 00       	mov    eax,0x1
    2022:	eb 05                	jmp    2029 <memdev_set_subnode+0x324>
    2024:	b8 00 00 00 00       	mov    eax,0x0
    2029:	48 01 c2             	add    rdx,rax
    202c:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    2030:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    2034:	48 89 50 40          	mov    QWORD PTR [rax+0x40],rdx
				n1->ino->in_stat.st_dev = memdev_data->id;
    2038:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 203f <memdev_set_subnode+0x33a>
    203f:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    2043:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    2047:	48 8b 12             	mov    rdx,QWORD PTR [rdx]
    204a:	48 89 10             	mov    QWORD PTR [rax],rdx
				n1->ino->in_stat.st_size = 1;
    204d:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    2051:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    2055:	48 c7 40 30 01 00 00 00 	mov    QWORD PTR [rax+0x30],0x1
				n1->ino->in_pddat = memdev_store_node(n1);
    205d:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    2061:	48 8b 58 18          	mov    rbx,QWORD PTR [rax+0x18]
    2065:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    2069:	48 89 c7             	mov    rdi,rax
    206c:	e8 00 00 00 00       	call   2071 <memdev_set_subnode+0x36c>
    2071:	48 89 83 80 00 00 00 	mov    QWORD PTR [rbx+0x80],rax
				if (!n1->ino->in_pddat) {
    2078:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    207c:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    2080:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
    2087:	48 85 c0             	test   rax,rax
    208a:	75 15                	jne    20a1 <memdev_set_subnode+0x39c>
						/* sth. went wrong! */
						ino_release(n1->ino);
    208c:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    2090:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    2094:	48 89 c7             	mov    rdi,rax
    2097:	e8 00 00 00 00       	call   209c <memdev_set_subnode+0x397>
						goto free_mem;
    209c:	e9 fd fe ff ff       	jmp    1f9e <memdev_set_subnode+0x299>
				}
				in1 = n1->ino;
    20a1:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    20a5:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    20a9:	48 89 45 90          	mov    QWORD PTR [rbp-0x70],rax
		}

		/* acquire the write lock */
		write_lock(&in0->in_lock);
    20ad:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    20b1:	48 05 88 00 00 00    	add    rax,0x88
    20b7:	48 89 c7             	mov    rdi,rax
    20ba:	e8 00 00 00 00       	call   20bf <memdev_set_subnode+0x3ba>
		/* find possible old/conflicting inode */
		char* dt = memdev_search_fn(n0, fn), need_entry = 1;
    20bf:	48 8b 55 88          	mov    rdx,QWORD PTR [rbp-0x78]
    20c3:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    20c7:	48 89 d6             	mov    rsi,rdx
    20ca:	48 89 c7             	mov    rdi,rax
    20cd:	e8 00 00 00 00       	call   20d2 <memdev_set_subnode+0x3cd>
    20d2:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
    20d6:	c6 45 d7 01          	mov    BYTE PTR [rbp-0x29],0x1
		if (dt) {
    20da:	48 83 7d c0 00       	cmp    QWORD PTR [rbp-0x40],0x0
    20df:	0f 84 1e 01 00 00    	je     2203 <memdev_set_subnode+0x4fe>
				struct inode* in2;
				/* already existing, get inode */
				dt += strlen(dt) + 1;
    20e5:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    20e9:	48 89 c7             	mov    rdi,rax
    20ec:	e8 00 00 00 00       	call   20f1 <memdev_set_subnode+0x3ec>
    20f1:	48 83 c0 01          	add    rax,0x1
    20f5:	48 01 45 c0          	add    QWORD PTR [rbp-0x40],rax
				in2 = *(struct inode**)dt;
    20f9:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    20fd:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2100:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
				if (in1 == in2) {
    2104:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    2108:	48 3b 45 b8          	cmp    rax,QWORD PTR [rbp-0x48]
    210c:	75 26                	jne    2134 <memdev_set_subnode+0x42f>
						/* do nothing */
						errno = EEXIST;
    210e:	c7 05 00 00 00 00 11 00 00 00 	mov    DWORD PTR [rip+0x0],0x11        # 2118 <memdev_set_subnode+0x413>
						write_unlock(&in0->in_lock);
    2118:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    211c:	48 05 88 00 00 00    	add    rax,0x88
    2122:	48 89 c7             	mov    rdi,rax
    2125:	e8 00 00 00 00       	call   212a <memdev_set_subnode+0x425>
						return -1;
    212a:	b8 ff ff ff ff       	mov    eax,0xffffffff
    212f:	e9 bb 02 00 00       	jmp    23ef <memdev_set_subnode+0x6ea>
				}
				/* unlink old node if neccessary */
				if (in2->in_stat.st_dev == memdev_data->id)
    2134:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2138:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    213b:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2142 <memdev_set_subnode+0x43d>
    2142:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2145:	48 39 c2             	cmp    rdx,rax
    2148:	75 16                	jne    2160 <memdev_set_subnode+0x45b>
						memdev_unlink(NULL, in2);
    214a:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    214e:	48 89 c6             	mov    rsi,rax
    2151:	bf 00 00 00 00       	mov    edi,0x0
    2156:	e8 00 00 00 00       	call   215b <memdev_set_subnode+0x456>
    215b:	e9 83 00 00 00       	jmp    21e3 <memdev_set_subnode+0x4de>
				else {
						const struct device_desc* dd;
						dd = get_device(in2->in_stat.st_dev);
    2160:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2164:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2167:	48 89 c7             	mov    rdi,rax
    216a:	e8 00 00 00 00       	call   216f <memdev_set_subnode+0x46a>
    216f:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
						if (!dd) {
    2173:	48 83 7d b0 00       	cmp    QWORD PTR [rbp-0x50],0x0
    2178:	75 53                	jne    21cd <memdev_set_subnode+0x4c8>
								cprintf(KFMT_WARN, "unable to locate device %u"
												" for unlinking inode referenced by %s\n",
												(uint32_t)in2->in_stat.st_dev, fn);
    217a:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    217e:	48 8b 00             	mov    rax,QWORD PTR [rax]
								cprintf(KFMT_WARN, "unable to locate device %u"
    2181:	89 c2                	mov    edx,eax
    2183:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2187:	48 89 c1             	mov    rcx,rax
    218a:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2191:	bf 0e 00 00 00       	mov    edi,0xe
    2196:	b8 00 00 00 00       	mov    eax,0x0
    219b:	e8 00 00 00 00       	call   21a0 <memdev_set_subnode+0x49b>
								if (__sync_sub_and_fetch(&in2->in_stat.st_dev, 1) == 0)
    21a0:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
    21a4:	b8 01 00 00 00       	mov    eax,0x1
    21a9:	48 f7 d8             	neg    rax
    21ac:	48 89 c1             	mov    rcx,rax
    21af:	48 89 c8             	mov    rax,rcx
    21b2:	f0 48 0f c1 02       	lock xadd QWORD PTR [rdx],rax
    21b7:	48 01 c8             	add    rax,rcx
    21ba:	48 85 c0             	test   rax,rax
    21bd:	75 24                	jne    21e3 <memdev_set_subnode+0x4de>
										ino_release(in2); /* clean up partially */
    21bf:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    21c3:	48 89 c7             	mov    rdi,rax
    21c6:	e8 00 00 00 00       	call   21cb <memdev_set_subnode+0x4c6>
    21cb:	eb 16                	jmp    21e3 <memdev_set_subnode+0x4de>
						} else {
								dd->fn_unlink(NULL, in2);
    21cd:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    21d1:	48 8b 50 58          	mov    rdx,QWORD PTR [rax+0x58]
    21d5:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    21d9:	48 89 c6             	mov    rsi,rax
    21dc:	bf 00 00 00 00       	mov    edi,0x0
    21e1:	ff d2                	call   rdx
						}
				}
				/* set new link */
				*(struct inode**)dt = in1;
    21e3:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    21e7:	48 8b 55 90          	mov    rdx,QWORD PTR [rbp-0x70]
    21eb:	48 89 10             	mov    QWORD PTR [rax],rdx
				need_entry = 0;
    21ee:	c6 45 d7 00          	mov    BYTE PTR [rbp-0x29],0x0
				printf("fn matches prev\n");
    21f2:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    21f9:	b8 00 00 00 00       	mov    eax,0x0
    21fe:	e8 00 00 00 00       	call   2203 <memdev_set_subnode+0x4fe>
		}

		/* assume valid inode in1 */
		__sync_fetch_and_add(&in1->in_stat.st_nlink, 1);
    2203:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    2207:	48 83 c0 18          	add    rax,0x18
    220b:	f0 48 83 00 01       	lock add QWORD PTR [rax],0x1
		if (need_entry) {
    2210:	80 7d d7 00          	cmp    BYTE PTR [rbp-0x29],0x0
    2214:	0f 84 79 01 00 00    	je     2393 <memdev_set_subnode+0x68e>
				/* modify data */
				size_t s = strlen(fn) + 1 + sizeof(void*);
    221a:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    221e:	48 89 c7             	mov    rdi,rax
    2221:	e8 00 00 00 00       	call   2226 <memdev_set_subnode+0x521>
    2226:	48 83 c0 09          	add    rax,0x9
    222a:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
				dt = (char*)n0 + n0->size;
    222e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2232:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    2236:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    223a:	48 01 d0             	add    rax,rdx
    223d:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
				if ((n0->cap - n0->size) < s) {
    2241:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2245:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    2249:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    224d:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2251:	48 29 c2             	sub    rdx,rax
    2254:	48 3b 55 a8          	cmp    rdx,QWORD PTR [rbp-0x58]
    2258:	0f 83 83 00 00 00    	jae    22e1 <memdev_set_subnode+0x5dc>
						/* use realloc */
						size_t nc = 2 * n0->cap + s;
    225e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2262:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    2266:	48 8d 14 00          	lea    rdx,[rax+rax*1]
    226a:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    226e:	48 01 d0             	add    rax,rdx
    2271:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
						n0 = h_realloc(memdev_data->heap, n0, nc);
    2275:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 227c <memdev_set_subnode+0x577>
    227c:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
    2280:	48 8b 55 a0          	mov    rdx,QWORD PTR [rbp-0x60]
    2284:	48 8b 4d e8          	mov    rcx,QWORD PTR [rbp-0x18]
    2288:	48 89 ce             	mov    rsi,rcx
    228b:	48 89 c7             	mov    rdi,rax
    228e:	e8 00 00 00 00       	call   2293 <memdev_set_subnode+0x58e>
    2293:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
						if (!n0) { /* real OOM */
    2297:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    229c:	75 21                	jne    22bf <memdev_set_subnode+0x5ba>
								cprintf(KFMT_ERROR, "failed to realloc on memdev heap: errno=%d\n", errno);
    229e:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 22a4 <memdev_set_subnode+0x59f>
    22a4:	89 c2                	mov    edx,eax
    22a6:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    22ad:	bf 0c 00 00 00       	mov    edi,0xc
    22b2:	b8 00 00 00 00       	mov    eax,0x0
    22b7:	e8 00 00 00 00       	call   22bc <memdev_set_subnode+0x5b7>
								while (1);
    22bc:	90                   	nop
    22bd:	eb fd                	jmp    22bc <memdev_set_subnode+0x5b7>
						}
						/* no cmpxchg neccessary */
						*(struct memdev_node**)n0->ino->in_pddat = n0;
    22bf:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    22c3:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    22c7:	48 8b 80 80 00 00 00 	mov    rax,QWORD PTR [rax+0x80]
    22ce:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    22d2:	48 89 10             	mov    QWORD PTR [rax],rdx
						n0->cap = nc;
    22d5:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    22d9:	48 8b 55 a0          	mov    rdx,QWORD PTR [rbp-0x60]
    22dd:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
				}
				/* we now have enough space */
				strncpy(dt, fn, s - 1 - sizeof(void*));
    22e1:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    22e5:	48 8d 50 f7          	lea    rdx,[rax-0x9]
    22e9:	48 8b 4d 88          	mov    rcx,QWORD PTR [rbp-0x78]
    22ed:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    22f1:	48 89 ce             	mov    rsi,rcx
    22f4:	48 89 c7             	mov    rdi,rax
    22f7:	e8 00 00 00 00       	call   22fc <memdev_set_subnode+0x5f7>
				dt += s - 1 - sizeof(void*);
    22fc:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2300:	48 83 e8 09          	sub    rax,0x9
    2304:	48 01 45 c0          	add    QWORD PTR [rbp-0x40],rax
				*dt = '\0';
    2308:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    230c:	c6 00 00             	mov    BYTE PTR [rax],0x0
				*(struct inode**)(++dt) = in1;
    230f:	48 83 45 c0 01       	add    QWORD PTR [rbp-0x40],0x1
    2314:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2318:	48 8b 55 90          	mov    rdx,QWORD PTR [rbp-0x70]
    231c:	48 89 10             	mov    QWORD PTR [rax],rdx
				n0->size += s;
    231f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2323:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    2327:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    232b:	48 01 c2             	add    rdx,rax
    232e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2332:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
				in0->in_stat.st_size = n0->size - sizeof(struct memdev_node);
    2336:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    233a:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    233e:	48 83 e8 20          	sub    rax,0x20
    2342:	48 89 c2             	mov    rdx,rax
    2345:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2349:	48 89 50 30          	mov    QWORD PTR [rax+0x30],rdx
				in0->in_stat.st_blocks = in0->in_stat.st_size / 512
    234d:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2351:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
    2355:	48 8d 90 ff 01 00 00 	lea    rdx,[rax+0x1ff]
    235c:	48 85 c0             	test   rax,rax
    235f:	48 0f 48 c2          	cmovs  rax,rdx
    2363:	48 c1 f8 09          	sar    rax,0x9
    2367:	48 89 c2             	mov    rdx,rax
					   	+ ((in0->in_stat.st_size % 512) ? 1 : 0);
    236a:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    236e:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
    2372:	25 ff 01 00 00       	and    eax,0x1ff
    2377:	48 85 c0             	test   rax,rax
    237a:	74 07                	je     2383 <memdev_set_subnode+0x67e>
    237c:	b8 01 00 00 00       	mov    eax,0x1
    2381:	eb 05                	jmp    2388 <memdev_set_subnode+0x683>
    2383:	b8 00 00 00 00       	mov    eax,0x0
    2388:	48 01 c2             	add    rdx,rax
				in0->in_stat.st_blocks = in0->in_stat.st_size / 512
    238b:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    238f:	48 89 50 40          	mov    QWORD PTR [rax+0x40],rdx
		}
		/* update times (only c&m on dir & c on fil) */
		clock_gettime(CLOCK_REALTIME, &in0->in_stat.st_mtim);
    2393:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    2397:	48 83 c0 58          	add    rax,0x58
    239b:	48 89 c6             	mov    rsi,rax
    239e:	bf 00 00 00 00       	mov    edi,0x0
    23a3:	e8 00 00 00 00       	call   23a8 <memdev_set_subnode+0x6a3>
		in0->in_stat.st_ctim = in0->in_stat.st_mtim;
    23a8:	48 8b 4d 98          	mov    rcx,QWORD PTR [rbp-0x68]
    23ac:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    23b0:	48 8b 50 60          	mov    rdx,QWORD PTR [rax+0x60]
    23b4:	48 8b 40 58          	mov    rax,QWORD PTR [rax+0x58]
    23b8:	48 89 41 68          	mov    QWORD PTR [rcx+0x68],rax
    23bc:	48 89 51 70          	mov    QWORD PTR [rcx+0x70],rdx
		/* due to change in link count */
		in1->in_stat.st_ctim = in0->in_stat.st_mtim;
    23c0:	48 8b 4d 90          	mov    rcx,QWORD PTR [rbp-0x70]
    23c4:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    23c8:	48 8b 50 60          	mov    rdx,QWORD PTR [rax+0x60]
    23cc:	48 8b 40 58          	mov    rax,QWORD PTR [rax+0x58]
    23d0:	48 89 41 68          	mov    QWORD PTR [rcx+0x68],rax
    23d4:	48 89 51 70          	mov    QWORD PTR [rcx+0x70],rdx
		write_unlock(&in0->in_lock);
    23d8:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    23dc:	48 05 88 00 00 00    	add    rax,0x88
    23e2:	48 89 c7             	mov    rdi,rax
    23e5:	e8 00 00 00 00       	call   23ea <memdev_set_subnode+0x6e5>
		return 0;
    23ea:	b8 00 00 00 00       	mov    eax,0x0
}
    23ef:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
    23f3:	c9                   	leave
    23f4:	c3                   	ret

00000000000023f5 <get_special_inode>:
/**********************************************************/
static struct inode *in_root, *in_dev;
struct inode* get_special_inode(enum spec_ino what)
{
    23f5:	55                   	push   rbp
    23f6:	48 89 e5             	mov    rbp,rsp
    23f9:	48 83 ec 08          	sub    rsp,0x8
    23fd:	89 7d fc             	mov    DWORD PTR [rbp-0x4],edi
		switch (what) {
    2400:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
    2404:	74 08                	je     240e <get_special_inode+0x19>
    2406:	83 7d fc 01          	cmp    DWORD PTR [rbp-0x4],0x1
    240a:	74 0b                	je     2417 <get_special_inode+0x22>
    240c:	eb 12                	jmp    2420 <get_special_inode+0x2b>
				case INO_ROOT:
						return in_root;
    240e:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2415 <get_special_inode+0x20>
    2415:	eb 0e                	jmp    2425 <get_special_inode+0x30>
				case INO_DEV:
						return in_dev;
    2417:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 241e <get_special_inode+0x29>
    241e:	eb 05                	jmp    2425 <get_special_inode+0x30>
				default:
						return NULL;
    2420:	b8 00 00 00 00       	mov    eax,0x0
		}
}
    2425:	c9                   	leave
    2426:	c3                   	ret

0000000000002427 <module_init>:
/**********************************************************/
int MODENTRY module_init()
{
    2427:	55                   	push   rbp
    2428:	48 89 e5             	mov    rbp,rsp
    242b:	48 81 ec 10 01 00 00 	sub    rsp,0x110
		struct device_desc dd = {0}; dev_t d;
    2432:	48 8d 55 80          	lea    rdx,[rbp-0x80]
    2436:	b8 00 00 00 00       	mov    eax,0x0
    243b:	b9 0e 00 00 00       	mov    ecx,0xe
    2440:	48 89 d7             	mov    rdi,rdx
    2443:	f3 48 ab             	rep stos QWORD PTR es:[rdi],rax
		printf("registering the basic file devices\n");
    2446:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    244d:	b8 00 00 00 00       	mov    eax,0x0
    2452:	e8 00 00 00 00       	call   2457 <module_init+0x30>
		dd.type = DEVTYPE_NONE;
    2457:	c6 45 80 01          	mov    BYTE PTR [rbp-0x80],0x1
		dd.fn_reg_dev = memdev_register;
    245b:	48 c7 45 88 00 00 00 00 	mov    QWORD PTR [rbp-0x78],0x0
		dd.fn_unreg_dev = memdev_unregister;
    2463:	48 c7 45 90 00 00 00 00 	mov    QWORD PTR [rbp-0x70],0x0
		dd.fn_open = memdev_open;
    246b:	48 c7 45 98 00 00 00 00 	mov    QWORD PTR [rbp-0x68],0x0
		dd.fn_read = memdev_read;
    2473:	48 c7 45 a0 00 00 00 00 	mov    QWORD PTR [rbp-0x60],0x0
		dd.fn_write = memdev_write;
    247b:	48 c7 45 a8 00 00 00 00 	mov    QWORD PTR [rbp-0x58],0x0
		dd.fn_close = memdev_close;
    2483:	48 c7 45 b0 00 00 00 00 	mov    QWORD PTR [rbp-0x50],0x0
		dd.fn_lseek = memdev_lseek;
    248b:	48 c7 45 b8 00 00 00 00 	mov    QWORD PTR [rbp-0x48],0x0
		dd.fn_truncate = memdev_truncate;
    2493:	48 c7 45 c0 00 00 00 00 	mov    QWORD PTR [rbp-0x40],0x0
		dd.fn_get_subnode = memdev_get_subnode;
    249b:	48 c7 45 c8 00 00 00 00 	mov    QWORD PTR [rbp-0x38],0x0
		dd.fn_set_subnode = memdev_set_subnode;
    24a3:	48 c7 45 d0 00 00 00 00 	mov    QWORD PTR [rbp-0x30],0x0
		dd.fn_unlink = memdev_unlink;
    24ab:	48 c7 45 d8 00 00 00 00 	mov    QWORD PTR [rbp-0x28],0x0
		d = register_device(&dd);
    24b3:	48 8d 45 80          	lea    rax,[rbp-0x80]
    24b7:	48 89 c7             	mov    rdi,rax
    24ba:	e8 00 00 00 00       	call   24bf <module_init+0x98>
    24bf:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (d != INVALID_DEVICE)
    24c3:	48 83 7d f8 ff       	cmp    QWORD PTR [rbp-0x8],0xffffffffffffffff
    24c8:	74 4f                	je     2519 <module_init+0xf2>
				printf("\tregistered memdev as device %u\n", (uint32_t)d);
    24ca:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    24ce:	89 c6                	mov    esi,eax
    24d0:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    24d7:	b8 00 00 00 00       	mov    eax,0x0
    24dc:	e8 00 00 00 00       	call   24e1 <module_init+0xba>
		else {
				printf("\tfailed to register memdev: errno=%d\n", errno);
				return -1;
		}

		printf("\ncreating the root file system\n");
    24e1:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    24e8:	b8 00 00 00 00       	mov    eax,0x0
    24ed:	e8 00 00 00 00       	call   24f2 <module_init+0xcb>
		/* create the / & /dev folders */
		in_root = dd.fn_get_subnode(NULL, "");
    24f2:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    24f6:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    24fd:	bf 00 00 00 00       	mov    edi,0x0
    2502:	ff d0                	call   rax
    2504:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 250b <module_init+0xe4>
		if (!in_root) {
    250b:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2512 <module_init+0xeb>
    2512:	48 85 c0             	test   rax,rax
    2515:	75 4d                	jne    2564 <module_init+0x13d>
    2517:	eb 23                	jmp    253c <module_init+0x115>
				printf("\tfailed to register memdev: errno=%d\n", errno);
    2519:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 251f <module_init+0xf8>
    251f:	89 c6                	mov    esi,eax
    2521:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2528:	b8 00 00 00 00       	mov    eax,0x0
    252d:	e8 00 00 00 00       	call   2532 <module_init+0x10b>
				return -1;
    2532:	b8 ff ff ff ff       	mov    eax,0xffffffff
    2537:	e9 15 01 00 00       	jmp    2651 <module_init+0x22a>
				cprintf(KFMT_ERROR, "\tfailed to create root in memdev: errno=%d\n", errno);
    253c:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2542 <module_init+0x11b>
    2542:	89 c2                	mov    edx,eax
    2544:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    254b:	bf 0c 00 00 00       	mov    edi,0xc
    2550:	b8 00 00 00 00       	mov    eax,0x0
    2555:	e8 00 00 00 00       	call   255a <module_init+0x133>
				return -1;
    255a:	b8 ff ff ff ff       	mov    eax,0xffffffff
    255f:	e9 ed 00 00 00       	jmp    2651 <module_init+0x22a>
		}
		printf("adding /dev\n");
    2564:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    256b:	b8 00 00 00 00       	mov    eax,0x0
    2570:	e8 00 00 00 00       	call   2575 <module_init+0x14e>
		if (dd.fn_set_subnode(in_root, &INO_TMPL_DIR, "dev") != 0) {
    2575:	4c 8b 45 d0          	mov    r8,QWORD PTR [rbp-0x30]
    2579:	48 8d 95 f0 fe ff ff 	lea    rdx,[rbp-0x110]
    2580:	b8 00 00 00 00       	mov    eax,0x0
    2585:	b9 12 00 00 00       	mov    ecx,0x12
    258a:	48 89 d7             	mov    rdi,rdx
    258d:	f3 48 ab             	rep stos QWORD PTR es:[rdi],rax
    2590:	48 c7 85 f0 fe ff ff ff ff ff ff 	mov    QWORD PTR [rbp-0x110],0xffffffffffffffff
    259b:	c7 85 00 ff ff ff 00 40 00 00 	mov    DWORD PTR [rbp-0x100],0x4000
    25a5:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 25ac <module_init+0x185>
    25ac:	48 8d 8d f0 fe ff ff 	lea    rcx,[rbp-0x110]
    25b3:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
    25ba:	48 89 ce             	mov    rsi,rcx
    25bd:	48 89 c7             	mov    rdi,rax
    25c0:	41 ff d0             	call   r8
    25c3:	85 c0                	test   eax,eax
    25c5:	74 25                	je     25ec <module_init+0x1c5>
				cprintf(KFMT_ERROR, "\tfailed to create folder /dev in root: errno=%d\n", errno);
    25c7:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 25cd <module_init+0x1a6>
    25cd:	89 c2                	mov    edx,eax
    25cf:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    25d6:	bf 0c 00 00 00       	mov    edi,0xc
    25db:	b8 00 00 00 00       	mov    eax,0x0
    25e0:	e8 00 00 00 00       	call   25e5 <module_init+0x1be>
				return -1;
    25e5:	b8 ff ff ff ff       	mov    eax,0xffffffff
    25ea:	eb 65                	jmp    2651 <module_init+0x22a>
		}
		printf("retrieving /dev\n");
    25ec:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    25f3:	b8 00 00 00 00       	mov    eax,0x0
    25f8:	e8 00 00 00 00       	call   25fd <module_init+0x1d6>
		in_dev = dd.fn_get_subnode(in_root, "dev");
    25fd:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    2601:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2608 <module_init+0x1e1>
    2608:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    260f:	48 89 c7             	mov    rdi,rax
    2612:	ff d2                	call   rdx
    2614:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 261b <module_init+0x1f4>
		if (!in_dev) {
    261b:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2622 <module_init+0x1fb>
    2622:	48 85 c0             	test   rax,rax
    2625:	75 25                	jne    264c <module_init+0x225>
				cprintf(KFMT_ERROR, "\tfailed to access folder /dev: errno=%d\n", errno);
    2627:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 262d <module_init+0x206>
    262d:	89 c2                	mov    edx,eax
    262f:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2636:	bf 0c 00 00 00       	mov    edi,0xc
    263b:	b8 00 00 00 00       	mov    eax,0x0
    2640:	e8 00 00 00 00       	call   2645 <module_init+0x21e>
				return -1;
    2645:	b8 ff ff ff ff       	mov    eax,0xffffffff
    264a:	eb 05                	jmp    2651 <module_init+0x22a>
		}

		return 0;
    264c:	b8 00 00 00 00       	mov    eax,0x0
}
    2651:	c9                   	leave
    2652:	c3                   	ret

0000000000002653 <print_stat>:

void print_stat(struct inode* in, const char* fn, int cb, int cu, int cg, int cs)
{
    2653:	55                   	push   rbp
    2654:	48 89 e5             	mov    rbp,rsp
    2657:	41 57                	push   r15
    2659:	41 56                	push   r14
    265b:	41 55                	push   r13
    265d:	41 54                	push   r12
    265f:	53                   	push   rbx
    2660:	48 81 ec 98 00 00 00 	sub    rsp,0x98
    2667:	48 89 bd 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rdi
    266e:	48 89 b5 60 ff ff ff 	mov    QWORD PTR [rbp-0xa0],rsi
    2675:	89 95 5c ff ff ff    	mov    DWORD PTR [rbp-0xa4],edx
    267b:	89 8d 58 ff ff ff    	mov    DWORD PTR [rbp-0xa8],ecx
    2681:	44 89 85 54 ff ff ff 	mov    DWORD PTR [rbp-0xac],r8d
    2688:	44 89 8d 50 ff ff ff 	mov    DWORD PTR [rbp-0xb0],r9d
		char fmt = KFMT_NORMAL, c_tp = '-', c_ur = '-', c_uw = '-',
    268f:	c6 45 cf 0f          	mov    BYTE PTR [rbp-0x31],0xf
    2693:	c6 45 ce 2d          	mov    BYTE PTR [rbp-0x32],0x2d
    2697:	c6 45 cd 2d          	mov    BYTE PTR [rbp-0x33],0x2d
    269b:	c6 45 cc 2d          	mov    BYTE PTR [rbp-0x34],0x2d
			 c_ux = '-', c_gr = '-', c_gw = '-', c_gx = '-', c_or = '-',
    269f:	c6 45 cb 2d          	mov    BYTE PTR [rbp-0x35],0x2d
    26a3:	c6 45 ca 2d          	mov    BYTE PTR [rbp-0x36],0x2d
    26a7:	c6 45 c9 2d          	mov    BYTE PTR [rbp-0x37],0x2d
    26ab:	c6 45 c8 2d          	mov    BYTE PTR [rbp-0x38],0x2d
    26af:	c6 45 c7 2d          	mov    BYTE PTR [rbp-0x39],0x2d
			 c_ow = '-', c_ox = '-';
    26b3:	c6 45 c6 2d          	mov    BYTE PTR [rbp-0x3a],0x2d
    26b7:	c6 45 c5 2d          	mov    BYTE PTR [rbp-0x3b],0x2d
		mode_t m = in->in_stat.st_mode;
    26bb:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
    26c2:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    26c5:	89 45 c0             	mov    DWORD PTR [rbp-0x40],eax

		if (m & S_IRUSR)
    26c8:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    26cb:	25 00 01 00 00       	and    eax,0x100
    26d0:	85 c0                	test   eax,eax
    26d2:	74 04                	je     26d8 <print_stat+0x85>
				c_ur = 'r';
    26d4:	c6 45 cd 72          	mov    BYTE PTR [rbp-0x33],0x72
		if (m & S_IWUSR)
    26d8:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    26db:	25 80 00 00 00       	and    eax,0x80
    26e0:	85 c0                	test   eax,eax
    26e2:	74 04                	je     26e8 <print_stat+0x95>
				c_uw = 'w';
    26e4:	c6 45 cc 77          	mov    BYTE PTR [rbp-0x34],0x77
		if (m & S_IXUSR)
    26e8:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    26eb:	83 e0 40             	and    eax,0x40
    26ee:	85 c0                	test   eax,eax
    26f0:	74 04                	je     26f6 <print_stat+0xa3>
				c_ux = 'x';
    26f2:	c6 45 cb 78          	mov    BYTE PTR [rbp-0x35],0x78
		if (m & S_ISUID) /* setuid */
    26f6:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    26f9:	25 00 08 00 00       	and    eax,0x800
    26fe:	85 c0                	test   eax,eax
    2700:	74 15                	je     2717 <print_stat+0xc4>
				c_ux = ((c_ux == 'x') ? 's' : 'S');
    2702:	80 7d cb 78          	cmp    BYTE PTR [rbp-0x35],0x78
    2706:	75 07                	jne    270f <print_stat+0xbc>
    2708:	b8 73 00 00 00       	mov    eax,0x73
    270d:	eb 05                	jmp    2714 <print_stat+0xc1>
    270f:	b8 53 00 00 00       	mov    eax,0x53
    2714:	88 45 cb             	mov    BYTE PTR [rbp-0x35],al
		if (m & S_IRGRP)
    2717:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    271a:	83 e0 20             	and    eax,0x20
    271d:	85 c0                	test   eax,eax
    271f:	74 04                	je     2725 <print_stat+0xd2>
				c_gr = 'r';
    2721:	c6 45 ca 72          	mov    BYTE PTR [rbp-0x36],0x72
		if (m & S_IWGRP)
    2725:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    2728:	83 e0 10             	and    eax,0x10
    272b:	85 c0                	test   eax,eax
    272d:	74 04                	je     2733 <print_stat+0xe0>
				c_gw = 'w';
    272f:	c6 45 c9 77          	mov    BYTE PTR [rbp-0x37],0x77
		if (m & S_IXGRP)
    2733:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    2736:	83 e0 08             	and    eax,0x8
    2739:	85 c0                	test   eax,eax
    273b:	74 04                	je     2741 <print_stat+0xee>
				c_gx = 'x';
    273d:	c6 45 c8 78          	mov    BYTE PTR [rbp-0x38],0x78
		if (m & S_ISGID) /* setgid */
    2741:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    2744:	25 00 04 00 00       	and    eax,0x400
    2749:	85 c0                	test   eax,eax
    274b:	74 15                	je     2762 <print_stat+0x10f>
				c_gx = ((c_gx == 'x') ? 's' : 'S');
    274d:	80 7d c8 78          	cmp    BYTE PTR [rbp-0x38],0x78
    2751:	75 07                	jne    275a <print_stat+0x107>
    2753:	b8 73 00 00 00       	mov    eax,0x73
    2758:	eb 05                	jmp    275f <print_stat+0x10c>
    275a:	b8 53 00 00 00       	mov    eax,0x53
    275f:	88 45 c8             	mov    BYTE PTR [rbp-0x38],al
		if (m & S_IROTH)
    2762:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    2765:	83 e0 04             	and    eax,0x4
    2768:	85 c0                	test   eax,eax
    276a:	74 04                	je     2770 <print_stat+0x11d>
				c_or = 'r';
    276c:	c6 45 c7 72          	mov    BYTE PTR [rbp-0x39],0x72
		if (m & S_IWOTH)
    2770:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    2773:	83 e0 02             	and    eax,0x2
    2776:	85 c0                	test   eax,eax
    2778:	74 04                	je     277e <print_stat+0x12b>
				c_ow = 'w';
    277a:	c6 45 c6 77          	mov    BYTE PTR [rbp-0x3a],0x77
		if (m & S_IXOTH)
    277e:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    2781:	83 e0 01             	and    eax,0x1
    2784:	85 c0                	test   eax,eax
    2786:	74 04                	je     278c <print_stat+0x139>
				c_ox = 'x';
    2788:	c6 45 c5 78          	mov    BYTE PTR [rbp-0x3b],0x78
		if (m & S_ISVTX) /* sticky bit */
    278c:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    278f:	25 00 02 00 00       	and    eax,0x200
    2794:	85 c0                	test   eax,eax
    2796:	74 15                	je     27ad <print_stat+0x15a>
				c_ox = ((c_ox == 'x') ? 't' : 'T');
    2798:	80 7d c5 78          	cmp    BYTE PTR [rbp-0x3b],0x78
    279c:	75 07                	jne    27a5 <print_stat+0x152>
    279e:	b8 74 00 00 00       	mov    eax,0x74
    27a3:	eb 05                	jmp    27aa <print_stat+0x157>
    27a5:	b8 54 00 00 00       	mov    eax,0x54
    27aa:	88 45 c5             	mov    BYTE PTR [rbp-0x3b],al
		if (S_ISDIR(m))
    27ad:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    27b0:	25 00 f0 00 00       	and    eax,0xf000
    27b5:	3d 00 40 00 00       	cmp    eax,0x4000
    27ba:	75 09                	jne    27c5 <print_stat+0x172>
				c_tp = 'd';
    27bc:	c6 45 ce 64          	mov    BYTE PTR [rbp-0x32],0x64
    27c0:	e9 82 00 00 00       	jmp    2847 <print_stat+0x1f4>
		else if (S_ISLNK(m))
    27c5:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    27c8:	25 00 f0 00 00       	and    eax,0xf000
    27cd:	3d 00 a0 00 00       	cmp    eax,0xa000
    27d2:	75 06                	jne    27da <print_stat+0x187>
				c_tp = 'l';
    27d4:	c6 45 ce 6c          	mov    BYTE PTR [rbp-0x32],0x6c
    27d8:	eb 6d                	jmp    2847 <print_stat+0x1f4>
		else if (S_ISFIFO(m))
    27da:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    27dd:	25 00 f0 00 00       	and    eax,0xf000
    27e2:	3d 00 10 00 00       	cmp    eax,0x1000
    27e7:	75 06                	jne    27ef <print_stat+0x19c>
				c_tp = 'p';
    27e9:	c6 45 ce 70          	mov    BYTE PTR [rbp-0x32],0x70
    27ed:	eb 58                	jmp    2847 <print_stat+0x1f4>
		else if (S_ISCHR(m))
    27ef:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    27f2:	25 00 f0 00 00       	and    eax,0xf000
    27f7:	3d 00 20 00 00       	cmp    eax,0x2000
    27fc:	75 06                	jne    2804 <print_stat+0x1b1>
				c_tp = 'c';
    27fe:	c6 45 ce 63          	mov    BYTE PTR [rbp-0x32],0x63
    2802:	eb 43                	jmp    2847 <print_stat+0x1f4>
		else if (S_ISBLK(m))
    2804:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    2807:	25 00 f0 00 00       	and    eax,0xf000
    280c:	3d 00 60 00 00       	cmp    eax,0x6000
    2811:	75 06                	jne    2819 <print_stat+0x1c6>
				c_tp = 'b';
    2813:	c6 45 ce 62          	mov    BYTE PTR [rbp-0x32],0x62
    2817:	eb 2e                	jmp    2847 <print_stat+0x1f4>
		else if (S_ISSOCK(m))
    2819:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    281c:	25 00 f0 00 00       	and    eax,0xf000
    2821:	3d 00 c0 00 00       	cmp    eax,0xc000
    2826:	75 06                	jne    282e <print_stat+0x1db>
				c_tp = 's';
    2828:	c6 45 ce 73          	mov    BYTE PTR [rbp-0x32],0x73
    282c:	eb 19                	jmp    2847 <print_stat+0x1f4>
		else if (S_ISREG(m))
    282e:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    2831:	25 00 f0 00 00       	and    eax,0xf000
    2836:	3d 00 80 00 00       	cmp    eax,0x8000
    283b:	75 06                	jne    2843 <print_stat+0x1f0>
				c_tp = '-';
    283d:	c6 45 ce 2d          	mov    BYTE PTR [rbp-0x32],0x2d
    2841:	eb 04                	jmp    2847 <print_stat+0x1f4>
		else
				c_tp = '?';
    2843:	c6 45 ce 3f          	mov    BYTE PTR [rbp-0x32],0x3f
		/* -rw-r--r-- 1 dennis users 6728 Aug 29 19:32 prog.o */
		struct tm atime; char datstr[26];
		localtime_r(&in->in_stat.st_atim.tv_sec, &atime);
    2847:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
    284e:	48 8d 50 48          	lea    rdx,[rax+0x48]
    2852:	48 8d 45 90          	lea    rax,[rbp-0x70]
    2856:	48 89 c6             	mov    rsi,rax
    2859:	48 89 d7             	mov    rdi,rdx
    285c:	e8 00 00 00 00       	call   2861 <print_stat+0x20e>
		asctime_r(&atime, datstr);
    2861:	48 8d 95 70 ff ff ff 	lea    rdx,[rbp-0x90]
    2868:	48 8d 45 90          	lea    rax,[rbp-0x70]
    286c:	48 89 d6             	mov    rsi,rdx
    286f:	48 89 c7             	mov    rdi,rax
    2872:	e8 00 00 00 00       	call   2877 <print_stat+0x224>
		/* reformat datstr TODO: strftime */
		/* old format: "Mon Aug 29 19:32:xy 2134 */
		strcpy(datstr, datstr + 4);
    2877:	48 8d 85 70 ff ff ff 	lea    rax,[rbp-0x90]
    287e:	48 83 c0 04          	add    rax,0x4
    2882:	48 8d 95 70 ff ff ff 	lea    rdx,[rbp-0x90]
    2889:	48 89 c6             	mov    rsi,rax
    288c:	48 89 d7             	mov    rdi,rdx
    288f:	e8 00 00 00 00       	call   2894 <print_stat+0x241>
		if (atime.tm_year != 115/*today.tm_year*/)
    2894:	8b 45 a4             	mov    eax,DWORD PTR [rbp-0x5c]
    2897:	83 f8 73             	cmp    eax,0x73
    289a:	74 21                	je     28bd <print_stat+0x26a>
				strcpy(datstr + 7, datstr + 15);
    289c:	48 8d 95 70 ff ff ff 	lea    rdx,[rbp-0x90]
    28a3:	48 83 c2 0f          	add    rdx,0xf
    28a7:	48 8d 85 70 ff ff ff 	lea    rax,[rbp-0x90]
    28ae:	48 83 c0 07          	add    rax,0x7
    28b2:	48 89 d6             	mov    rsi,rdx
    28b5:	48 89 c7             	mov    rdi,rax
    28b8:	e8 00 00 00 00       	call   28bd <print_stat+0x26a>
		datstr[12] = '\0';
    28bd:	c6 85 7c ff ff ff 00 	mov    BYTE PTR [rbp-0x84],0x0
		printf("%c%c%c%c%c%c%c%c%c%c %*u %*u %*u %*u %s ", c_tp, c_ur,
						c_uw, c_ux, c_gr, c_gw, c_gx, c_or, c_ow, c_ox,
						cb, (uint32_t)in->in_stat.st_nlink, cu, (uint32_t)in->in_stat.st_uid,
						cg, (uint32_t)in->in_stat.st_gid, cs, (uint32_t)in->in_stat.st_size,
    28c4:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
    28cb:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
		printf("%c%c%c%c%c%c%c%c%c%c %*u %*u %*u %*u %s ", c_tp, c_ur,
    28cf:	89 85 4c ff ff ff    	mov    DWORD PTR [rbp-0xb4],eax
						cg, (uint32_t)in->in_stat.st_gid, cs, (uint32_t)in->in_stat.st_size,
    28d5:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
    28dc:	44 8b 60 24          	mov    r12d,DWORD PTR [rax+0x24]
						cb, (uint32_t)in->in_stat.st_nlink, cu, (uint32_t)in->in_stat.st_uid,
    28e0:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
    28e7:	8b 58 20             	mov    ebx,DWORD PTR [rax+0x20]
    28ea:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
    28f1:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
		printf("%c%c%c%c%c%c%c%c%c%c %*u %*u %*u %*u %s ", c_tp, c_ur,
    28f5:	41 89 c7             	mov    r15d,eax
    28f8:	44 0f be 5d c5       	movsx  r11d,BYTE PTR [rbp-0x3b]
    28fd:	44 0f be 55 c6       	movsx  r10d,BYTE PTR [rbp-0x3a]
    2902:	44 0f be 4d c7       	movsx  r9d,BYTE PTR [rbp-0x39]
    2907:	44 0f be 45 c8       	movsx  r8d,BYTE PTR [rbp-0x38]
    290c:	0f be 7d c9          	movsx  edi,BYTE PTR [rbp-0x37]
    2910:	44 0f be 75 ca       	movsx  r14d,BYTE PTR [rbp-0x36]
    2915:	44 0f be 6d cb       	movsx  r13d,BYTE PTR [rbp-0x35]
    291a:	0f be 4d cc          	movsx  ecx,BYTE PTR [rbp-0x34]
    291e:	0f be 55 cd          	movsx  edx,BYTE PTR [rbp-0x33]
    2922:	0f be 75 ce          	movsx  esi,BYTE PTR [rbp-0x32]
    2926:	48 8d 85 70 ff ff ff 	lea    rax,[rbp-0x90]
    292d:	50                   	push   rax
    292e:	8b 85 4c ff ff ff    	mov    eax,DWORD PTR [rbp-0xb4]
    2934:	50                   	push   rax
    2935:	8b 85 50 ff ff ff    	mov    eax,DWORD PTR [rbp-0xb0]
    293b:	50                   	push   rax
    293c:	41 54                	push   r12
    293e:	8b 85 54 ff ff ff    	mov    eax,DWORD PTR [rbp-0xac]
    2944:	50                   	push   rax
    2945:	53                   	push   rbx
    2946:	8b 85 58 ff ff ff    	mov    eax,DWORD PTR [rbp-0xa8]
    294c:	50                   	push   rax
    294d:	41 57                	push   r15
    294f:	8b 85 5c ff ff ff    	mov    eax,DWORD PTR [rbp-0xa4]
    2955:	50                   	push   rax
    2956:	41 53                	push   r11
    2958:	41 52                	push   r10
    295a:	41 51                	push   r9
    295c:	41 50                	push   r8
    295e:	57                   	push   rdi
    295f:	45 89 f1             	mov    r9d,r14d
    2962:	45 89 e8             	mov    r8d,r13d
    2965:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    296c:	b8 00 00 00 00       	mov    eax,0x0
    2971:	e8 00 00 00 00       	call   2976 <print_stat+0x323>
    2976:	48 83 c4 70          	add    rsp,0x70
						datstr);
		if (S_ISDIR(m)) {
    297a:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    297d:	25 00 f0 00 00       	and    eax,0xf000
    2982:	3d 00 40 00 00       	cmp    eax,0x4000
    2987:	75 4f                	jne    29d8 <print_stat+0x385>
				fmt = LFMT_DIR;
    2989:	c6 45 cf 09          	mov    BYTE PTR [rbp-0x31],0x9
				if ((m & S_ISVTX) && (m & S_IWOTH))
    298d:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    2990:	25 00 02 00 00       	and    eax,0x200
    2995:	85 c0                	test   eax,eax
    2997:	74 13                	je     29ac <print_stat+0x359>
    2999:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    299c:	83 e0 02             	and    eax,0x2
    299f:	85 c0                	test   eax,eax
    29a1:	74 09                	je     29ac <print_stat+0x359>
						fmt = LFMT_SWRT;
    29a3:	c6 45 cf 20          	mov    BYTE PTR [rbp-0x31],0x20
    29a7:	e9 fc 00 00 00       	jmp    2aa8 <print_stat+0x455>
				else if (m & S_IWOTH)
    29ac:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    29af:	83 e0 02             	and    eax,0x2
    29b2:	85 c0                	test   eax,eax
    29b4:	74 09                	je     29bf <print_stat+0x36c>
						fmt = LFMT_OWRT;
    29b6:	c6 45 cf 21          	mov    BYTE PTR [rbp-0x31],0x21
    29ba:	e9 e9 00 00 00       	jmp    2aa8 <print_stat+0x455>
				else if (m & S_ISVTX)
    29bf:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    29c2:	25 00 02 00 00       	and    eax,0x200
    29c7:	85 c0                	test   eax,eax
    29c9:	0f 84 d9 00 00 00    	je     2aa8 <print_stat+0x455>
						fmt = LFMT_STCK;
    29cf:	c6 45 cf 10          	mov    BYTE PTR [rbp-0x31],0x10
    29d3:	e9 d0 00 00 00       	jmp    2aa8 <print_stat+0x455>
		} else if (S_ISREG(m)) {
    29d8:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    29db:	25 00 f0 00 00       	and    eax,0xf000
    29e0:	3d 00 80 00 00       	cmp    eax,0x8000
    29e5:	75 54                	jne    2a3b <print_stat+0x3e8>
				if (m & S_ISUID)
    29e7:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    29ea:	25 00 08 00 00       	and    eax,0x800
    29ef:	85 c0                	test   eax,eax
    29f1:	74 09                	je     29fc <print_stat+0x3a9>
						fmt = LFMT_SUID;
    29f3:	c6 45 cf 4f          	mov    BYTE PTR [rbp-0x31],0x4f
    29f7:	e9 ac 00 00 00       	jmp    2aa8 <print_stat+0x455>
				else if (m & S_ISGID)
    29fc:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    29ff:	25 00 04 00 00       	and    eax,0x400
    2a04:	85 c0                	test   eax,eax
    2a06:	74 09                	je     2a11 <print_stat+0x3be>
						fmt = LFMT_SGID;
    2a08:	c6 45 cf e0          	mov    BYTE PTR [rbp-0x31],0xe0
    2a0c:	e9 97 00 00 00       	jmp    2aa8 <print_stat+0x455>
				else if (m & S_IXUGO)
    2a11:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    2a14:	83 e0 49             	and    eax,0x49
    2a17:	85 c0                	test   eax,eax
    2a19:	74 09                	je     2a24 <print_stat+0x3d1>
						fmt = LFMT_EXEC;
    2a1b:	c6 45 cf 0a          	mov    BYTE PTR [rbp-0x31],0xa
    2a1f:	e9 84 00 00 00       	jmp    2aa8 <print_stat+0x455>
				else if (in->in_stat.st_nlink > 1)
    2a24:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
    2a2b:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    2a2f:	48 83 f8 01          	cmp    rax,0x1
    2a33:	76 73                	jbe    2aa8 <print_stat+0x455>
						fmt = LFMT_MH;
    2a35:	c6 45 cf 0f          	mov    BYTE PTR [rbp-0x31],0xf
    2a39:	eb 6d                	jmp    2aa8 <print_stat+0x455>
		} else if (S_ISLNK(m))
    2a3b:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    2a3e:	25 00 f0 00 00       	and    eax,0xf000
    2a43:	3d 00 a0 00 00       	cmp    eax,0xa000
    2a48:	75 06                	jne    2a50 <print_stat+0x3fd>
				fmt = LFMT_LNK;
    2a4a:	c6 45 cf 0b          	mov    BYTE PTR [rbp-0x31],0xb
    2a4e:	eb 58                	jmp    2aa8 <print_stat+0x455>
		else if (S_ISFIFO(m))
    2a50:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    2a53:	25 00 f0 00 00       	and    eax,0xf000
    2a58:	3d 00 10 00 00       	cmp    eax,0x1000
    2a5d:	75 06                	jne    2a65 <print_stat+0x412>
				fmt = LFMT_PIPE;
    2a5f:	c6 45 cf 06          	mov    BYTE PTR [rbp-0x31],0x6
    2a63:	eb 43                	jmp    2aa8 <print_stat+0x455>
		else if (S_ISSOCK(m))
    2a65:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    2a68:	25 00 f0 00 00       	and    eax,0xf000
    2a6d:	3d 00 c0 00 00       	cmp    eax,0xc000
    2a72:	75 06                	jne    2a7a <print_stat+0x427>
				fmt = LFMT_SOCK;
    2a74:	c6 45 cf 0d          	mov    BYTE PTR [rbp-0x31],0xd
    2a78:	eb 2e                	jmp    2aa8 <print_stat+0x455>
		else if (S_ISBLK(m))
    2a7a:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    2a7d:	25 00 f0 00 00       	and    eax,0xf000
    2a82:	3d 00 60 00 00       	cmp    eax,0x6000
    2a87:	75 06                	jne    2a8f <print_stat+0x43c>
				fmt = LFMT_BDEV;
    2a89:	c6 45 cf 0e          	mov    BYTE PTR [rbp-0x31],0xe
    2a8d:	eb 19                	jmp    2aa8 <print_stat+0x455>
		else if (S_ISCHR(m))
    2a8f:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    2a92:	25 00 f0 00 00       	and    eax,0xf000
    2a97:	3d 00 20 00 00       	cmp    eax,0x2000
    2a9c:	75 06                	jne    2aa4 <print_stat+0x451>
				fmt = LFMT_CDEV;
    2a9e:	c6 45 cf 0e          	mov    BYTE PTR [rbp-0x31],0xe
    2aa2:	eb 04                	jmp    2aa8 <print_stat+0x455>
		/*else if (S_ISDOOR(m))
				fmt = LFMT_DOOR;*/
		else
				fmt = LFMT_ORPH;
    2aa4:	c6 45 cf 0f          	mov    BYTE PTR [rbp-0x31],0xf
		cprintf(fmt, "%s\n", fn);
    2aa8:	0f be 45 cf          	movsx  eax,BYTE PTR [rbp-0x31]
    2aac:	48 8b 95 60 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xa0]
    2ab3:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2aba:	89 c7                	mov    edi,eax
    2abc:	b8 00 00 00 00       	mov    eax,0x0
    2ac1:	e8 00 00 00 00       	call   2ac6 <print_stat+0x473>
}
    2ac6:	90                   	nop
    2ac7:	48 8d 65 d8          	lea    rsp,[rbp-0x28]
    2acb:	5b                   	pop    rbx
    2acc:	41 5c                	pop    r12
    2ace:	41 5d                	pop    r13
    2ad0:	41 5e                	pop    r14
    2ad2:	41 5f                	pop    r15
    2ad4:	5d                   	pop    rbp
    2ad5:	c3                   	ret

0000000000002ad6 <path_lookup>:

struct inode* path_lookup(const char* str, char* tk, size_t ntk, int allow_partial)
{
    2ad6:	55                   	push   rbp
    2ad7:	48 89 e5             	mov    rbp,rsp
    2ada:	48 81 ec 50 01 00 00 	sub    rsp,0x150
    2ae1:	48 89 bd c8 fe ff ff 	mov    QWORD PTR [rbp-0x138],rdi
    2ae8:	48 89 b5 c0 fe ff ff 	mov    QWORD PTR [rbp-0x140],rsi
    2aef:	48 89 95 b8 fe ff ff 	mov    QWORD PTR [rbp-0x148],rdx
    2af6:	89 8d b4 fe ff ff    	mov    DWORD PTR [rbp-0x14c],ecx
		static char pwd[260] = "/";
		static struct inode* in_pwd = NULL, *in = NULL, *in_prev = NULL;
		char buf[260], *ltk = "", *ctx, *tok;
    2afc:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		if (!in_pwd)
    2b04:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2b0b <path_lookup+0x35>
    2b0b:	48 85 c0             	test   rax,rax
    2b0e:	75 0e                	jne    2b1e <path_lookup+0x48>
				in_pwd = in_root;
    2b10:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2b17 <path_lookup+0x41>
    2b17:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2b1e <path_lookup+0x48>
		/* navigate to path */
		strncpy(buf, str, 260);
    2b1e:	48 8b 8d c8 fe ff ff 	mov    rcx,QWORD PTR [rbp-0x138]
    2b25:	48 8d 85 e0 fe ff ff 	lea    rax,[rbp-0x120]
    2b2c:	ba 04 01 00 00       	mov    edx,0x104
    2b31:	48 89 ce             	mov    rsi,rcx
    2b34:	48 89 c7             	mov    rdi,rax
    2b37:	e8 00 00 00 00       	call   2b3c <path_lookup+0x66>
		buf[260] = '\0';
    2b3c:	c6 45 e4 00          	mov    BYTE PTR [rbp-0x1c],0x0
		ltk = tok = strtok_r(buf, "/", &ctx);
    2b40:	48 8d 95 d8 fe ff ff 	lea    rdx,[rbp-0x128]
    2b47:	48 8d 85 e0 fe ff ff 	lea    rax,[rbp-0x120]
    2b4e:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2b55:	48 89 c7             	mov    rdi,rax
    2b58:	e8 00 00 00 00       	call   2b5d <path_lookup+0x87>
    2b5d:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
    2b61:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2b65:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		in = ((*str == '/') ? in_root : in_pwd); /* abs or rel */
    2b69:	48 8b 85 c8 fe ff ff 	mov    rax,QWORD PTR [rbp-0x138]
    2b70:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    2b73:	3c 2f                	cmp    al,0x2f
    2b75:	75 09                	jne    2b80 <path_lookup+0xaa>
    2b77:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2b7e <path_lookup+0xa8>
    2b7e:	eb 07                	jmp    2b87 <path_lookup+0xb1>
    2b80:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2b87 <path_lookup+0xb1>
    2b87:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2b8e <path_lookup+0xb8>
		in_prev = in;
    2b8e:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2b95 <path_lookup+0xbf>
    2b95:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2b9c <path_lookup+0xc6>
		while (tok) {
    2b9c:	e9 4b 01 00 00       	jmp    2cec <path_lookup+0x216>
				const struct device_desc* dd;
				dd = get_device(in->in_stat.st_dev);
    2ba1:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2ba8 <path_lookup+0xd2>
    2ba8:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2bab:	48 89 c7             	mov    rdi,rax
    2bae:	e8 00 00 00 00       	call   2bb3 <path_lookup+0xdd>
    2bb3:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				if (!dd) {
    2bb7:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    2bbc:	75 3c                	jne    2bfa <path_lookup+0x124>
						cprintf(KFMT_WARN, "unable to explore node "
    2bbe:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 2bc4 <path_lookup+0xee>
							"%s at associated device %u is not registered. errno=%d\n",
							tok, (uint32_t)in->in_stat.st_dev, errno);
    2bc4:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2bcb <path_lookup+0xf5>
    2bcb:	48 8b 00             	mov    rax,QWORD PTR [rax]
						cprintf(KFMT_WARN, "unable to explore node "
    2bce:	89 c1                	mov    ecx,eax
    2bd0:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2bd4:	41 89 d0             	mov    r8d,edx
    2bd7:	48 89 c2             	mov    rdx,rax
    2bda:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2be1:	bf 0e 00 00 00       	mov    edi,0xe
    2be6:	b8 00 00 00 00       	mov    eax,0x0
    2beb:	e8 00 00 00 00       	call   2bf0 <path_lookup+0x11a>
						return NULL;
    2bf0:	b8 00 00 00 00       	mov    eax,0x0
    2bf5:	e9 43 01 00 00       	jmp    2d3d <path_lookup+0x267>
				}
				ltk = tok;
    2bfa:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2bfe:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				in = dd->fn_get_subnode(in, tok);
    2c02:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2c06:	48 8b 48 48          	mov    rcx,QWORD PTR [rax+0x48]
    2c0a:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2c11 <path_lookup+0x13b>
    2c11:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    2c15:	48 89 d6             	mov    rsi,rdx
    2c18:	48 89 c7             	mov    rdi,rax
    2c1b:	ff d1                	call   rcx
    2c1d:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2c24 <path_lookup+0x14e>
				if (!in) {
    2c24:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2c2b <path_lookup+0x155>
    2c2b:	48 85 c0             	test   rax,rax
    2c2e:	0f 85 8b 00 00 00    	jne    2cbf <path_lookup+0x1e9>
						if (!allow_partial)
    2c34:	83 bd b4 fe ff ff 00 	cmp    DWORD PTR [rbp-0x14c],0x0
    2c3b:	75 3a                	jne    2c77 <path_lookup+0x1a1>
								cprintf(KFMT_WARN, "Failed to locate subnode %s"
    2c3d:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR [rip+0x0]        # 2c43 <path_lookup+0x16d>
    2c43:	48 8b 95 c8 fe ff ff 	mov    rdx,QWORD PTR [rbp-0x138]
    2c4a:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2c4e:	41 89 c8             	mov    r8d,ecx
    2c51:	48 89 d1             	mov    rcx,rdx
    2c54:	48 89 c2             	mov    rdx,rax
    2c57:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2c5e:	bf 0e 00 00 00       	mov    edi,0xe
    2c63:	b8 00 00 00 00       	mov    eax,0x0
    2c68:	e8 00 00 00 00       	call   2c6d <path_lookup+0x197>
										strncpy(tk, ltk, ntk);
										tk[ntk - 1] = '\0';
								}
								return in_prev;
						}
						return NULL;
    2c6d:	b8 00 00 00 00       	mov    eax,0x0
    2c72:	e9 c6 00 00 00       	jmp    2d3d <path_lookup+0x267>
								if (tk) {
    2c77:	48 83 bd c0 fe ff ff 00 	cmp    QWORD PTR [rbp-0x140],0x0
    2c7f:	74 35                	je     2cb6 <path_lookup+0x1e0>
										strncpy(tk, ltk, ntk);
    2c81:	48 8b 95 b8 fe ff ff 	mov    rdx,QWORD PTR [rbp-0x148]
    2c88:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    2c8c:	48 8b 85 c0 fe ff ff 	mov    rax,QWORD PTR [rbp-0x140]
    2c93:	48 89 ce             	mov    rsi,rcx
    2c96:	48 89 c7             	mov    rdi,rax
    2c99:	e8 00 00 00 00       	call   2c9e <path_lookup+0x1c8>
										tk[ntk - 1] = '\0';
    2c9e:	48 8b 85 b8 fe ff ff 	mov    rax,QWORD PTR [rbp-0x148]
    2ca5:	48 8d 50 ff          	lea    rdx,[rax-0x1]
    2ca9:	48 8b 85 c0 fe ff ff 	mov    rax,QWORD PTR [rbp-0x140]
    2cb0:	48 01 d0             	add    rax,rdx
    2cb3:	c6 00 00             	mov    BYTE PTR [rax],0x0
								return in_prev;
    2cb6:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2cbd <path_lookup+0x1e7>
    2cbd:	eb 7e                	jmp    2d3d <path_lookup+0x267>
				} else {
						in_prev = in;
    2cbf:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2cc6 <path_lookup+0x1f0>
    2cc6:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 2ccd <path_lookup+0x1f7>
				}
				tok = strtok_r(NULL, "/", &ctx);
    2ccd:	48 8d 85 d8 fe ff ff 	lea    rax,[rbp-0x128]
    2cd4:	48 89 c2             	mov    rdx,rax
    2cd7:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2cde:	bf 00 00 00 00       	mov    edi,0x0
    2ce3:	e8 00 00 00 00       	call   2ce8 <path_lookup+0x212>
    2ce8:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		while (tok) {
    2cec:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
    2cf1:	0f 85 aa fe ff ff    	jne    2ba1 <path_lookup+0xcb>
		}
		if (tk) {
    2cf7:	48 83 bd c0 fe ff ff 00 	cmp    QWORD PTR [rbp-0x140],0x0
    2cff:	74 35                	je     2d36 <path_lookup+0x260>
				strncpy(tk, ltk, ntk);
    2d01:	48 8b 95 b8 fe ff ff 	mov    rdx,QWORD PTR [rbp-0x148]
    2d08:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    2d0c:	48 8b 85 c0 fe ff ff 	mov    rax,QWORD PTR [rbp-0x140]
    2d13:	48 89 ce             	mov    rsi,rcx
    2d16:	48 89 c7             	mov    rdi,rax
    2d19:	e8 00 00 00 00       	call   2d1e <path_lookup+0x248>
				tk[ntk - 1] = '\0';
    2d1e:	48 8b 85 b8 fe ff ff 	mov    rax,QWORD PTR [rbp-0x148]
    2d25:	48 8d 50 ff          	lea    rdx,[rax-0x1]
    2d29:	48 8b 85 c0 fe ff ff 	mov    rax,QWORD PTR [rbp-0x140]
    2d30:	48 01 d0             	add    rax,rdx
    2d33:	c6 00 00             	mov    BYTE PTR [rax],0x0
		}
		return in;
    2d36:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2d3d <path_lookup+0x267>
}
    2d3d:	c9                   	leave
    2d3e:	c3                   	ret

0000000000002d3f <fcli_ls>:

int fcli_ls(const char* str)
{
    2d3f:	55                   	push   rbp
    2d40:	48 89 e5             	mov    rbp,rsp
    2d43:	48 81 ec 70 01 00 00 	sub    rsp,0x170
    2d4a:	48 89 bd 98 fe ff ff 	mov    QWORD PTR [rbp-0x168],rdi
		struct inode* in = NULL; char ltk[40];
    2d51:	48 c7 45 c0 00 00 00 00 	mov    QWORD PTR [rbp-0x40],0x0
		/* ls-like commands */
		str += 3;
    2d59:	48 83 85 98 fe ff ff 03 	add    QWORD PTR [rbp-0x168],0x3
		/* navigate to path */
		in = path_lookup(str, ltk, sizeof(ltk), 0);
    2d61:	48 8d b5 60 ff ff ff 	lea    rsi,[rbp-0xa0]
    2d68:	48 8b 85 98 fe ff ff 	mov    rax,QWORD PTR [rbp-0x168]
    2d6f:	b9 00 00 00 00       	mov    ecx,0x0
    2d74:	ba 28 00 00 00       	mov    edx,0x28
    2d79:	48 89 c7             	mov    rdi,rax
    2d7c:	e8 00 00 00 00       	call   2d81 <fcli_ls+0x42>
    2d81:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
		if (!in)
    2d85:	48 83 7d c0 00       	cmp    QWORD PTR [rbp-0x40],0x0
    2d8a:	75 0a                	jne    2d96 <fcli_ls+0x57>
				return 1;
    2d8c:	b8 01 00 00 00       	mov    eax,0x1
    2d91:	e9 f5 04 00 00       	jmp    328b <fcli_ls+0x54c>
		/* now do the lookup (default to ls -l) */
		if (S_ISDIR(in->in_stat.st_mode)) {
    2d96:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2d9a:	8b 40 10             	mov    eax,DWORD PTR [rax+0x10]
    2d9d:	25 00 f0 00 00       	and    eax,0xf000
    2da2:	3d 00 40 00 00       	cmp    eax,0x4000
    2da7:	0f 85 b0 04 00 00    	jne    325d <fcli_ls+0x51e>
				const struct device_desc* dd; int fd;
				/* max and sum of blocks, size, user, gid */
				size_t mb = 0, ms = 0, mu = 0, mg = 0, sb = 0, ss = 0;
    2dad:	48 c7 85 58 ff ff ff 00 00 00 00 	mov    QWORD PTR [rbp-0xa8],0x0
    2db8:	48 c7 85 50 ff ff ff 00 00 00 00 	mov    QWORD PTR [rbp-0xb0],0x0
    2dc3:	48 c7 85 48 ff ff ff 00 00 00 00 	mov    QWORD PTR [rbp-0xb8],0x0
    2dce:	48 c7 85 40 ff ff ff 00 00 00 00 	mov    QWORD PTR [rbp-0xc0],0x0
    2dd9:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
    2de1:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
				char buf[128]; size_t nr; int frst = 1;
    2de9:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [rbp-0x14],0x1

				/* open directory for reading */
				dd = get_device(in->in_stat.st_dev);
    2df0:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2df4:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2df7:	48 89 c7             	mov    rdi,rax
    2dfa:	e8 00 00 00 00       	call   2dff <fcli_ls+0xc0>
    2dff:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
				if (!dd) {
    2e03:	48 83 7d b8 00       	cmp    QWORD PTR [rbp-0x48],0x0
    2e08:	75 24                	jne    2e2e <fcli_ls+0xef>
						printf("unable to obtain device %u associated"
							" with the directory\n", (uint32_t)in->in_stat.st_dev);
    2e0a:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2e0e:	48 8b 00             	mov    rax,QWORD PTR [rax]
						printf("unable to obtain device %u associated"
    2e11:	89 c6                	mov    esi,eax
    2e13:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2e1a:	b8 00 00 00 00       	mov    eax,0x0
    2e1f:	e8 00 00 00 00       	call   2e24 <fcli_ls+0xe5>
						return 1;
    2e24:	b8 01 00 00 00       	mov    eax,0x1
    2e29:	e9 5d 04 00 00       	jmp    328b <fcli_ls+0x54c>
				}
				fd = dd->fn_open(in, O_RDONLY);
    2e2e:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2e32:	48 8b 50 18          	mov    rdx,QWORD PTR [rax+0x18]
    2e36:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2e3a:	be 00 00 00 00       	mov    esi,0x0
    2e3f:	48 89 c7             	mov    rdi,rax
    2e42:	ff d2                	call   rdx
    2e44:	89 45 b4             	mov    DWORD PTR [rbp-0x4c],eax
				if (fd == -1) {
    2e47:	83 7d b4 ff          	cmp    DWORD PTR [rbp-0x4c],0xffffffff
    2e4b:	74 03                	je     2e50 <fcli_ls+0x111>
						printf("unable to access directory for reading: errno=%d\n", errno);
						return 1;
				}
				/* now read the data */
Pos0:
    2e4d:	90                   	nop
    2e4e:	eb 23                	jmp    2e73 <fcli_ls+0x134>
						printf("unable to access directory for reading: errno=%d\n", errno);
    2e50:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2e56 <fcli_ls+0x117>
    2e56:	89 c6                	mov    esi,eax
    2e58:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2e5f:	b8 00 00 00 00       	mov    eax,0x0
    2e64:	e8 00 00 00 00       	call   2e69 <fcli_ls+0x12a>
						return 1;
    2e69:	b8 01 00 00 00       	mov    eax,0x1
    2e6e:	e9 18 04 00 00       	jmp    328b <fcli_ls+0x54c>
				if (!frst) {
    2e73:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
    2e77:	0f 85 f7 00 00 00    	jne    2f74 <fcli_ls+0x235>
						size_t im; size_t* arr[] = { &mb, &ms, &mu, &mg };
    2e7d:	48 8d 85 58 ff ff ff 	lea    rax,[rbp-0xa8]
    2e84:	48 89 85 a0 fe ff ff 	mov    QWORD PTR [rbp-0x160],rax
    2e8b:	48 8d 85 50 ff ff ff 	lea    rax,[rbp-0xb0]
    2e92:	48 89 85 a8 fe ff ff 	mov    QWORD PTR [rbp-0x158],rax
    2e99:	48 8d 85 48 ff ff ff 	lea    rax,[rbp-0xb8]
    2ea0:	48 89 85 b0 fe ff ff 	mov    QWORD PTR [rbp-0x150],rax
    2ea7:	48 8d 85 40 ff ff ff 	lea    rax,[rbp-0xc0]
    2eae:	48 89 85 b8 fe ff ff 	mov    QWORD PTR [rbp-0x148],rax
						/* calculate the capacites */
						for (size_t** p = &arr[0]; p <= &arr[3]; p++) {
    2eb5:	48 8d 85 a0 fe ff ff 	lea    rax,[rbp-0x160]
    2ebc:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
    2ec0:	eb 55                	jmp    2f17 <fcli_ls+0x1d8>
								im = 1;
    2ec2:	48 c7 45 e0 01 00 00 00 	mov    QWORD PTR [rbp-0x20],0x1
								while ((**p /= 10))
    2eca:	eb 05                	jmp    2ed1 <fcli_ls+0x192>
										im++;
    2ecc:	48 83 45 e0 01       	add    QWORD PTR [rbp-0x20],0x1
								while ((**p /= 10))
    2ed1:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2ed5:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2ed8:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    2edb:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2edf:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    2ee2:	48 be cd cc cc cc cc cc cc cc 	movabs rsi,0xcccccccccccccccd
    2eec:	48 89 d0             	mov    rax,rdx
    2eef:	48 f7 e6             	mul    rsi
    2ef2:	48 89 d0             	mov    rax,rdx
    2ef5:	48 c1 e8 03          	shr    rax,0x3
    2ef9:	48 89 01             	mov    QWORD PTR [rcx],rax
    2efc:	48 8b 01             	mov    rax,QWORD PTR [rcx]
    2eff:	48 85 c0             	test   rax,rax
    2f02:	75 c8                	jne    2ecc <fcli_ls+0x18d>
								**p = im;
    2f04:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2f08:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2f0b:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    2f0f:	48 89 10             	mov    QWORD PTR [rax],rdx
						for (size_t** p = &arr[0]; p <= &arr[3]; p++) {
    2f12:	48 83 45 d8 08       	add    QWORD PTR [rbp-0x28],0x8
    2f17:	48 8d 85 a0 fe ff ff 	lea    rax,[rbp-0x160]
    2f1e:	48 83 c0 18          	add    rax,0x18
    2f22:	48 3b 45 d8          	cmp    rax,QWORD PTR [rbp-0x28]
    2f26:	73 9a                	jae    2ec2 <fcli_ls+0x183>
						}
						if (dd->fn_lseek(in, fd, 0, SEEK_SET) != 0) {
    2f28:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2f2c:	4c 8b 40 38          	mov    r8,QWORD PTR [rax+0x38]
    2f30:	8b 75 b4             	mov    esi,DWORD PTR [rbp-0x4c]
    2f33:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2f37:	b9 00 00 00 00       	mov    ecx,0x0
    2f3c:	ba 00 00 00 00       	mov    edx,0x0
    2f41:	48 89 c7             	mov    rdi,rax
    2f44:	41 ff d0             	call   r8
    2f47:	48 85 c0             	test   rax,rax
    2f4a:	74 28                	je     2f74 <fcli_ls+0x235>
								cprintf(KFMT_ERROR, "failed to seek to start"
    2f4c:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2f52 <fcli_ls+0x213>
    2f52:	89 c2                	mov    edx,eax
    2f54:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2f5b:	bf 0c 00 00 00       	mov    edi,0xc
    2f60:	b8 00 00 00 00       	mov    eax,0x0
    2f65:	e8 00 00 00 00       	call   2f6a <fcli_ls+0x22b>
									" of directory file. errno=%d\n", errno);
								return 1;
    2f6a:	b8 01 00 00 00       	mov    eax,0x1
						return 1;
    2f6f:	e9 17 03 00 00       	jmp    328b <fcli_ls+0x54c>
						}
				}
				do {
						char* fn = buf, *fn_prev; size_t s;
    2f74:	48 8d 85 c0 fe ff ff 	lea    rax,[rbp-0x140]
    2f7b:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
						nr = dd->fn_read(in, fd, buf, sizeof(buf) - 1);
    2f7f:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2f83:	4c 8b 40 20          	mov    r8,QWORD PTR [rax+0x20]
    2f87:	48 8d 95 c0 fe ff ff 	lea    rdx,[rbp-0x140]
    2f8e:	8b 75 b4             	mov    esi,DWORD PTR [rbp-0x4c]
    2f91:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2f95:	b9 7f 00 00 00       	mov    ecx,0x7f
    2f9a:	48 89 c7             	mov    rdi,rax
    2f9d:	41 ff d0             	call   r8
    2fa0:	48 98                	cdqe
    2fa2:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
						buf[nr] = '\0';
    2fa6:	48 8d 95 c0 fe ff ff 	lea    rdx,[rbp-0x140]
    2fad:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2fb1:	48 01 d0             	add    rax,rdx
    2fb4:	c6 00 00             	mov    BYTE PTR [rax],0x0
						while ((s = strlen(fn))) {
    2fb7:	e9 0f 02 00 00       	jmp    31cb <fcli_ls+0x48c>
								struct inode* in1;
Pos1:
								if (fn + s + 1 + sizeof(struct inode*) > buf + sizeof(buf)) {
    2fbc:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    2fc0:	48 8d 50 09          	lea    rdx,[rax+0x9]
    2fc4:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    2fc8:	48 01 c2             	add    rdx,rax
    2fcb:	48 8d 85 c0 fe ff ff 	lea    rax,[rbp-0x140]
    2fd2:	48 83 e8 80          	sub    rax,0xffffffffffffff80
    2fd6:	48 39 d0             	cmp    rax,rdx
    2fd9:	0f 83 ad 00 00 00    	jae    308c <fcli_ls+0x34d>
										/* data spans, try lseek */
										off_t sk = sizeof(buf) - (fn - buf);
    2fdf:	48 8d 85 c0 fe ff ff 	lea    rax,[rbp-0x140]
    2fe6:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    2fea:	48 29 c2             	sub    rdx,rax
    2fed:	b8 80 00 00 00       	mov    eax,0x80
    2ff2:	48 29 d0             	sub    rax,rdx
    2ff5:	48 89 45 90          	mov    QWORD PTR [rbp-0x70],rax
										if (sk == -sizeof(buf)) {
    2ff9:	48 83 7d 90 80       	cmp    QWORD PTR [rbp-0x70],0xffffffffffffff80
    2ffe:	75 20                	jne    3020 <fcli_ls+0x2e1>
												cprintf(KFMT_ERROR, "fn too long for intermediate buffer\n");
    3000:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3007:	bf 0c 00 00 00       	mov    edi,0xc
    300c:	b8 00 00 00 00       	mov    eax,0x0
    3011:	e8 00 00 00 00       	call   3016 <fcli_ls+0x2d7>
												return 1;
    3016:	b8 01 00 00 00       	mov    eax,0x1
    301b:	e9 6b 02 00 00       	jmp    328b <fcli_ls+0x54c>
										}
										if (-1 == dd->fn_lseek(in, fd, sk, SEEK_CUR)) {
    3020:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    3024:	4c 8b 40 38          	mov    r8,QWORD PTR [rax+0x38]
    3028:	48 8b 55 90          	mov    rdx,QWORD PTR [rbp-0x70]
    302c:	8b 75 b4             	mov    esi,DWORD PTR [rbp-0x4c]
    302f:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    3033:	b9 01 00 00 00       	mov    ecx,0x1
    3038:	48 89 c7             	mov    rdi,rax
    303b:	41 ff d0             	call   r8
    303e:	48 83 f8 ff          	cmp    rax,0xffffffffffffffff
    3042:	75 28                	jne    306c <fcli_ls+0x32d>
												cprintf(KFMT_WARN, "unable to seek on directory file for ls. errno=%d\n", errno);
    3044:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 304a <fcli_ls+0x30b>
    304a:	89 c2                	mov    edx,eax
    304c:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3053:	bf 0e 00 00 00       	mov    edi,0xe
    3058:	b8 00 00 00 00       	mov    eax,0x0
    305d:	e8 00 00 00 00       	call   3062 <fcli_ls+0x323>
												return 1;
    3062:	b8 01 00 00 00       	mov    eax,0x1
    3067:	e9 1f 02 00 00       	jmp    328b <fcli_ls+0x54c>
										}
										fn = buf;
    306c:	48 8d 85 c0 fe ff ff 	lea    rax,[rbp-0x140]
    3073:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
										s = strlen(fn);
    3077:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    307b:	48 89 c7             	mov    rdi,rax
    307e:	e8 00 00 00 00       	call   3083 <fcli_ls+0x344>
    3083:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
										goto Pos1;
    3087:	e9 30 ff ff ff       	jmp    2fbc <fcli_ls+0x27d>
								}
								fn_prev = fn;
    308c:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    3090:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
								fn += s + 1;
    3094:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    3098:	48 83 c0 01          	add    rax,0x1
    309c:	48 01 45 d0          	add    QWORD PTR [rbp-0x30],rax
								in1 = *(struct inode**)fn;
    30a0:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    30a4:	48 8b 00             	mov    rax,QWORD PTR [rax]
    30a7:	48 89 45 98          	mov    QWORD PTR [rbp-0x68],rax
								fn += sizeof(struct inode*);
    30ab:	48 83 45 d0 08       	add    QWORD PTR [rbp-0x30],0x8
								if (!in1) {
    30b0:	48 83 7d 98 00       	cmp    QWORD PTR [rbp-0x68],0x0
    30b5:	75 22                	jne    30d9 <fcli_ls+0x39a>
										cprintf(KFMT_WARN, "inode of %s missing\n", fn_prev);
    30b7:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    30bb:	48 89 c2             	mov    rdx,rax
    30be:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    30c5:	bf 0e 00 00 00       	mov    edi,0xe
    30ca:	b8 00 00 00 00       	mov    eax,0x0
    30cf:	e8 00 00 00 00       	call   30d4 <fcli_ls+0x395>
    30d4:	e9 f2 00 00 00       	jmp    31cb <fcli_ls+0x48c>
								} else if (frst) {
    30d9:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
    30dd:	0f 84 ad 00 00 00    	je     3190 <fcli_ls+0x451>
										if (in1->in_stat.st_nlink > mb)
    30e3:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    30e7:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    30eb:	48 8b 95 58 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xa8]
    30f2:	48 39 c2             	cmp    rdx,rax
    30f5:	73 0f                	jae    3106 <fcli_ls+0x3c7>
												mb = in1->in_stat.st_nlink;
    30f7:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    30fb:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
    30ff:	48 89 85 58 ff ff ff 	mov    QWORD PTR [rbp-0xa8],rax
										if (in1->in_stat.st_size > ms)
    3106:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    310a:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
    310e:	48 89 c2             	mov    rdx,rax
    3111:	48 8b 85 50 ff ff ff 	mov    rax,QWORD PTR [rbp-0xb0]
    3118:	48 39 d0             	cmp    rax,rdx
    311b:	73 0f                	jae    312c <fcli_ls+0x3ed>
												ms = in1->in_stat.st_size;
    311d:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    3121:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
    3125:	48 89 85 50 ff ff ff 	mov    QWORD PTR [rbp-0xb0],rax
										if (in1->in_stat.st_uid > mu)
    312c:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    3130:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    3133:	89 c2                	mov    edx,eax
    3135:	48 8b 85 48 ff ff ff 	mov    rax,QWORD PTR [rbp-0xb8]
    313c:	48 39 d0             	cmp    rax,rdx
    313f:	73 10                	jae    3151 <fcli_ls+0x412>
												mu = in1->in_stat.st_uid;
    3141:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    3145:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    3148:	89 c0                	mov    eax,eax
    314a:	48 89 85 48 ff ff ff 	mov    QWORD PTR [rbp-0xb8],rax
										if (in1->in_stat.st_gid > mg)
    3151:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    3155:	8b 40 24             	mov    eax,DWORD PTR [rax+0x24]
    3158:	89 c2                	mov    edx,eax
    315a:	48 8b 85 40 ff ff ff 	mov    rax,QWORD PTR [rbp-0xc0]
    3161:	48 39 d0             	cmp    rax,rdx
    3164:	73 10                	jae    3176 <fcli_ls+0x437>
												mg = in1->in_stat.st_gid;
    3166:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    316a:	8b 40 24             	mov    eax,DWORD PTR [rax+0x24]
    316d:	89 c0                	mov    eax,eax
    316f:	48 89 85 40 ff ff ff 	mov    QWORD PTR [rbp-0xc0],rax
										sb += in1->in_stat.st_blocks;
    3176:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    317a:	48 8b 40 40          	mov    rax,QWORD PTR [rax+0x40]
    317e:	48 01 45 f8          	add    QWORD PTR [rbp-0x8],rax
										ss += in1->in_stat.st_size;
    3182:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    3186:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
    318a:	48 01 45 f0          	add    QWORD PTR [rbp-0x10],rax
    318e:	eb 3b                	jmp    31cb <fcli_ls+0x48c>
								} else {
										/* do the printing */
										print_stat(in1, fn_prev, mb, mu, mg, ms);
    3190:	48 8b 85 50 ff ff ff 	mov    rax,QWORD PTR [rbp-0xb0]
    3197:	41 89 c0             	mov    r8d,eax
    319a:	48 8b 85 40 ff ff ff 	mov    rax,QWORD PTR [rbp-0xc0]
    31a1:	89 c7                	mov    edi,eax
    31a3:	48 8b 85 48 ff ff ff 	mov    rax,QWORD PTR [rbp-0xb8]
    31aa:	89 c1                	mov    ecx,eax
    31ac:	48 8b 85 58 ff ff ff 	mov    rax,QWORD PTR [rbp-0xa8]
    31b3:	89 c2                	mov    edx,eax
    31b5:	48 8b 75 a0          	mov    rsi,QWORD PTR [rbp-0x60]
    31b9:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    31bd:	45 89 c1             	mov    r9d,r8d
    31c0:	41 89 f8             	mov    r8d,edi
    31c3:	48 89 c7             	mov    rdi,rax
    31c6:	e8 00 00 00 00       	call   31cb <fcli_ls+0x48c>
						while ((s = strlen(fn))) {
    31cb:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    31cf:	48 89 c7             	mov    rdi,rax
    31d2:	e8 00 00 00 00       	call   31d7 <fcli_ls+0x498>
    31d7:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
    31db:	48 83 7d c8 00       	cmp    QWORD PTR [rbp-0x38],0x0
    31e0:	74 06                	je     31e8 <fcli_ls+0x4a9>
Pos1:
    31e2:	90                   	nop
    31e3:	e9 d4 fd ff ff       	jmp    2fbc <fcli_ls+0x27d>
								}
						}
				} while (nr);
    31e8:	48 83 7d a8 00       	cmp    QWORD PTR [rbp-0x58],0x0
    31ed:	0f 85 81 fd ff ff    	jne    2f74 <fcli_ls+0x235>
				if (frst) {
    31f3:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
    31f7:	74 24                	je     321d <fcli_ls+0x4de>
						printf("total %lu\n", sb);
    31f9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    31fd:	48 89 c6             	mov    rsi,rax
    3200:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3207:	b8 00 00 00 00       	mov    eax,0x0
    320c:	e8 00 00 00 00       	call   3211 <fcli_ls+0x4d2>
						frst = 0;
    3211:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [rbp-0x14],0x0
						goto Pos0;
    3218:	e9 56 fc ff ff       	jmp    2e73 <fcli_ls+0x134>
				}
				/* TODO: use dirent to not pollute space */
				if (-1 == dd->fn_close(in, fd)) {
    321d:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    3221:	48 8b 48 30          	mov    rcx,QWORD PTR [rax+0x30]
    3225:	8b 55 b4             	mov    edx,DWORD PTR [rbp-0x4c]
    3228:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    322c:	89 d6                	mov    esi,edx
    322e:	48 89 c7             	mov    rdi,rax
    3231:	ff d1                	call   rcx
    3233:	83 f8 ff             	cmp    eax,0xffffffff
    3236:	75 4e                	jne    3286 <fcli_ls+0x547>
						cprintf(KFMT_WARN, "failed to close fd %d to"
    3238:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 323e <fcli_ls+0x4ff>
    323e:	8b 45 b4             	mov    eax,DWORD PTR [rbp-0x4c]
    3241:	89 d1                	mov    ecx,edx
    3243:	89 c2                	mov    edx,eax
    3245:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    324c:	bf 0e 00 00 00       	mov    edi,0xe
    3251:	b8 00 00 00 00       	mov    eax,0x0
    3256:	e8 00 00 00 00       	call   325b <fcli_ls+0x51c>
    325b:	eb 29                	jmp    3286 <fcli_ls+0x547>
							" directory file open for reading. errno=%d\n", fd, errno);
				}
		} else
			   print_stat(in, ltk, 0, 0, 0, 0);
    325d:	48 8d b5 60 ff ff ff 	lea    rsi,[rbp-0xa0]
    3264:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    3268:	41 b9 00 00 00 00    	mov    r9d,0x0
    326e:	41 b8 00 00 00 00    	mov    r8d,0x0
    3274:	b9 00 00 00 00       	mov    ecx,0x0
    3279:	ba 00 00 00 00       	mov    edx,0x0
    327e:	48 89 c7             	mov    rdi,rax
    3281:	e8 00 00 00 00       	call   3286 <fcli_ls+0x547>
		return 1;
    3286:	b8 01 00 00 00       	mov    eax,0x1
}
    328b:	c9                   	leave
    328c:	c3                   	ret

000000000000328d <fcli_cat>:

int fcli_cat(const char* str)
{
    328d:	55                   	push   rbp
    328e:	48 89 e5             	mov    rbp,rsp
    3291:	48 81 ec a0 00 00 00 	sub    rsp,0xa0
    3298:	48 89 bd 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rdi
		struct inode* in = NULL; char ltk[40];
    329f:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		/* cat-like commands */
		str += 4;
    32a7:	48 83 85 68 ff ff ff 04 	add    QWORD PTR [rbp-0x98],0x4
		/* navigate to path */
		in = path_lookup(str, ltk, sizeof(ltk), 0);
    32af:	48 8d 75 b0          	lea    rsi,[rbp-0x50]
    32b3:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
    32ba:	b9 00 00 00 00       	mov    ecx,0x0
    32bf:	ba 28 00 00 00       	mov    edx,0x28
    32c4:	48 89 c7             	mov    rdi,rax
    32c7:	e8 00 00 00 00       	call   32cc <fcli_cat+0x3f>
    32cc:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		if (!in)
    32d0:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
    32d5:	75 0a                	jne    32e1 <fcli_cat+0x54>
				return 1;
    32d7:	b8 01 00 00 00       	mov    eax,0x1
    32dc:	e9 7f 01 00 00       	jmp    3460 <fcli_cat+0x1d3>

		/* read the file */
		const struct device_desc* dd; int fd; size_t nr;
		dd = get_device(in->in_stat.st_dev);
    32e1:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    32e5:	48 8b 00             	mov    rax,QWORD PTR [rax]
    32e8:	48 89 c7             	mov    rdi,rax
    32eb:	e8 00 00 00 00       	call   32f0 <fcli_cat+0x63>
    32f0:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		if (!dd) {
    32f4:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    32f9:	75 23                	jne    331e <fcli_cat+0x91>
				printf("device error: errno=%d\n", errno);
    32fb:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3301 <fcli_cat+0x74>
    3301:	89 c6                	mov    esi,eax
    3303:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    330a:	b8 00 00 00 00       	mov    eax,0x0
    330f:	e8 00 00 00 00       	call   3314 <fcli_cat+0x87>
				return 1;
    3314:	b8 01 00 00 00       	mov    eax,0x1
    3319:	e9 42 01 00 00       	jmp    3460 <fcli_cat+0x1d3>
		}
		fd = dd->fn_open(in, O_RDONLY);
    331e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    3322:	48 8b 50 18          	mov    rdx,QWORD PTR [rax+0x18]
    3326:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    332a:	be 00 00 00 00       	mov    esi,0x0
    332f:	48 89 c7             	mov    rdi,rax
    3332:	ff d2                	call   rdx
    3334:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
		if (fd == -1) {
    3337:	83 7d e4 ff          	cmp    DWORD PTR [rbp-0x1c],0xffffffff
    333b:	75 25                	jne    3362 <fcli_cat+0xd5>
				printf("cannot open file %s\n", str);
    333d:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
    3344:	48 89 c6             	mov    rsi,rax
    3347:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    334e:	b8 00 00 00 00       	mov    eax,0x0
    3353:	e8 00 00 00 00       	call   3358 <fcli_cat+0xcb>
				return 1;
    3358:	b8 01 00 00 00       	mov    eax,0x1
    335d:	e9 fe 00 00 00       	jmp    3460 <fcli_cat+0x1d3>
		}
		printf("cat: size=%lld\n", in->in_stat.st_size);
    3362:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3366:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
    336a:	48 89 c6             	mov    rsi,rax
    336d:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3374:	b8 00 00 00 00       	mov    eax,0x0
    3379:	e8 00 00 00 00       	call   337e <fcli_cat+0xf1>
		do {
				char buf[61];
				nr = dd->fn_read(in, fd, buf, sizeof(buf) - 1);
    337e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    3382:	4c 8b 40 20          	mov    r8,QWORD PTR [rax+0x20]
    3386:	48 8d 95 70 ff ff ff 	lea    rdx,[rbp-0x90]
    338d:	8b 75 e4             	mov    esi,DWORD PTR [rbp-0x1c]
    3390:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3394:	b9 3c 00 00 00       	mov    ecx,0x3c
    3399:	48 89 c7             	mov    rdi,rax
    339c:	41 ff d0             	call   r8
    339f:	48 98                	cdqe
    33a1:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
				buf[nr] = '\0';
    33a5:	48 8d 95 70 ff ff ff 	lea    rdx,[rbp-0x90]
    33ac:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    33b0:	48 01 d0             	add    rax,rdx
    33b3:	c6 00 00             	mov    BYTE PTR [rax],0x0
				if (nr) {
    33b6:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
    33bb:	74 60                	je     341d <fcli_cat+0x190>
						char* c = buf;
    33bd:	48 8d 85 70 ff ff ff 	lea    rax,[rbp-0x90]
    33c4:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						while (c < buf + nr)
    33c8:	eb 3f                	jmp    3409 <fcli_cat+0x17c>
								if (isprint(*c))
    33ca:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    33ce:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    33d1:	0f be c0             	movsx  eax,al
    33d4:	89 c7                	mov    edi,eax
    33d6:	e8 00 00 00 00       	call   33db <fcli_cat+0x14e>
    33db:	85 c0                	test   eax,eax
    33dd:	74 1b                	je     33fa <fcli_cat+0x16d>
										putchar(*c++);
    33df:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    33e3:	48 8d 50 01          	lea    rdx,[rax+0x1]
    33e7:	48 89 55 f8          	mov    QWORD PTR [rbp-0x8],rdx
    33eb:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    33ee:	0f be c0             	movsx  eax,al
    33f1:	89 c7                	mov    edi,eax
    33f3:	e8 00 00 00 00       	call   33f8 <fcli_cat+0x16b>
    33f8:	eb 0f                	jmp    3409 <fcli_cat+0x17c>
								else {
										putchar('.');
    33fa:	bf 2e 00 00 00       	mov    edi,0x2e
    33ff:	e8 00 00 00 00       	call   3404 <fcli_cat+0x177>
										c++;
    3404:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
						while (c < buf + nr)
    3409:	48 8d 95 70 ff ff ff 	lea    rdx,[rbp-0x90]
    3410:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3414:	48 01 d0             	add    rax,rdx
    3417:	48 39 45 f8          	cmp    QWORD PTR [rbp-0x8],rax
    341b:	72 ad                	jb     33ca <fcli_cat+0x13d>
								}
				}
		} while (nr);
    341d:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
    3422:	0f 85 56 ff ff ff    	jne    337e <fcli_cat+0xf1>
		if (-1 == dd->fn_close(in, fd))
    3428:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    342c:	48 8b 48 30          	mov    rcx,QWORD PTR [rax+0x30]
    3430:	8b 55 e4             	mov    edx,DWORD PTR [rbp-0x1c]
    3433:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3437:	89 d6                	mov    esi,edx
    3439:	48 89 c7             	mov    rdi,rax
    343c:	ff d1                	call   rcx
    343e:	83 f8 ff             	cmp    eax,0xffffffff
    3441:	75 07                	jne    344a <fcli_cat+0x1bd>
				return 1;
    3443:	b8 01 00 00 00       	mov    eax,0x1
    3448:	eb 16                	jmp    3460 <fcli_cat+0x1d3>
		printf("\n");
    344a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3451:	b8 00 00 00 00       	mov    eax,0x0
    3456:	e8 00 00 00 00       	call   345b <fcli_cat+0x1ce>
		return 1;
    345b:	b8 01 00 00 00       	mov    eax,0x1
}
    3460:	c9                   	leave
    3461:	c3                   	ret

0000000000003462 <fcli_mkdir>:

int fcli_mkdir(const char* str)
{
    3462:	55                   	push   rbp
    3463:	48 89 e5             	mov    rbp,rsp
    3466:	48 81 ec e0 00 00 00 	sub    rsp,0xe0
    346d:	48 89 bd 28 ff ff ff 	mov    QWORD PTR [rbp-0xd8],rdi
		struct inode* in; char ltk[40];
		const char* oc;
		if (str[2] == ' ')
    3474:	48 8b 85 28 ff ff ff 	mov    rax,QWORD PTR [rbp-0xd8]
    347b:	48 83 c0 02          	add    rax,0x2
    347f:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    3482:	3c 20                	cmp    al,0x20
    3484:	75 0a                	jne    3490 <fcli_mkdir+0x2e>
				str += 3;
    3486:	48 83 85 28 ff ff ff 03 	add    QWORD PTR [rbp-0xd8],0x3
    348e:	eb 08                	jmp    3498 <fcli_mkdir+0x36>
		else
				str += 6;
    3490:	48 83 85 28 ff ff ff 06 	add    QWORD PTR [rbp-0xd8],0x6
		in = path_lookup(str, ltk, sizeof(ltk), 1);
    3498:	48 8d 75 c0          	lea    rsi,[rbp-0x40]
    349c:	48 8b 85 28 ff ff ff 	mov    rax,QWORD PTR [rbp-0xd8]
    34a3:	b9 01 00 00 00       	mov    ecx,0x1
    34a8:	ba 28 00 00 00       	mov    edx,0x28
    34ad:	48 89 c7             	mov    rdi,rax
    34b0:	e8 00 00 00 00       	call   34b5 <fcli_mkdir+0x53>
    34b5:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		if (!in)
    34b9:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    34be:	75 0a                	jne    34ca <fcli_mkdir+0x68>
				return 0;
    34c0:	b8 00 00 00 00       	mov    eax,0x0
    34c5:	e9 67 01 00 00       	jmp    3631 <fcli_mkdir+0x1cf>
		oc = strstr(str, ltk);
    34ca:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
    34ce:	48 8b 85 28 ff ff ff 	mov    rax,QWORD PTR [rbp-0xd8]
    34d5:	48 89 d6             	mov    rsi,rdx
    34d8:	48 89 c7             	mov    rdi,rax
    34db:	e8 00 00 00 00       	call   34e0 <fcli_mkdir+0x7e>
    34e0:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		if (strchr(oc, '/'))
    34e4:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    34e8:	be 2f 00 00 00       	mov    esi,0x2f
    34ed:	48 89 c7             	mov    rdi,rax
    34f0:	e8 00 00 00 00       	call   34f5 <fcli_mkdir+0x93>
    34f5:	48 85 c0             	test   rax,rax
    34f8:	74 29                	je     3523 <fcli_mkdir+0xc1>
				printf("mkdir: cannot create directory '%s': no such file or directory (%s missing)\n", str, ltk);
    34fa:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
    34fe:	48 8b 85 28 ff ff ff 	mov    rax,QWORD PTR [rbp-0xd8]
    3505:	48 89 c6             	mov    rsi,rax
    3508:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    350f:	b8 00 00 00 00       	mov    eax,0x0
    3514:	e8 00 00 00 00       	call   3519 <fcli_mkdir+0xb7>
						return 1;
				} else
						printf("created '%s' at '%*s'\n", ltk, (int)(oc - str), str);
				return 1;
		}
		return 1;
    3519:	b8 01 00 00 00       	mov    eax,0x1
    351e:	e9 0e 01 00 00       	jmp    3631 <fcli_mkdir+0x1cf>
				dd = get_device(in->in_stat.st_dev);
    3523:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3527:	48 8b 00             	mov    rax,QWORD PTR [rax]
    352a:	48 89 c7             	mov    rdi,rax
    352d:	e8 00 00 00 00       	call   3532 <fcli_mkdir+0xd0>
    3532:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				if (!dd) {
    3536:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    353b:	75 2d                	jne    356a <fcli_mkdir+0x108>
								"with node '%s'\n", (uint32_t)in->in_stat.st_dev, ltk);
    353d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3541:	48 8b 00             	mov    rax,QWORD PTR [rax]
						printf("unable to obtain device %u associated"
    3544:	89 c1                	mov    ecx,eax
    3546:	48 8d 45 c0          	lea    rax,[rbp-0x40]
    354a:	48 89 c2             	mov    rdx,rax
    354d:	89 ce                	mov    esi,ecx
    354f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3556:	b8 00 00 00 00       	mov    eax,0x0
    355b:	e8 00 00 00 00       	call   3560 <fcli_mkdir+0xfe>
						return 1;
    3560:	b8 01 00 00 00       	mov    eax,0x1
    3565:	e9 c7 00 00 00       	jmp    3631 <fcli_mkdir+0x1cf>
				if (dd->fn_set_subnode(in, &INO_TMPL_DIR, ltk) != 0) {
    356a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    356e:	4c 8b 40 50          	mov    r8,QWORD PTR [rax+0x50]
    3572:	48 8d 95 30 ff ff ff 	lea    rdx,[rbp-0xd0]
    3579:	b8 00 00 00 00       	mov    eax,0x0
    357e:	b9 12 00 00 00       	mov    ecx,0x12
    3583:	48 89 d7             	mov    rdi,rdx
    3586:	f3 48 ab             	rep stos QWORD PTR es:[rdi],rax
    3589:	48 c7 85 30 ff ff ff ff ff ff ff 	mov    QWORD PTR [rbp-0xd0],0xffffffffffffffff
    3594:	c7 85 40 ff ff ff 00 40 00 00 	mov    DWORD PTR [rbp-0xc0],0x4000
    359e:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
    35a2:	48 8d 8d 30 ff ff ff 	lea    rcx,[rbp-0xd0]
    35a9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    35ad:	48 89 ce             	mov    rsi,rcx
    35b0:	48 89 c7             	mov    rdi,rax
    35b3:	41 ff d0             	call   r8
    35b6:	85 c0                	test   eax,eax
    35b8:	74 41                	je     35fb <fcli_mkdir+0x199>
						printf("unable to add directory '%s' to node '%*s': errno=%d\n",
    35ba:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR [rip+0x0]        # 35c0 <fcli_mkdir+0x15e>
										ltk, (int)(oc - str), str, errno);
    35c0:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    35c4:	48 2b 85 28 ff ff ff 	sub    rax,QWORD PTR [rbp-0xd8]
						printf("unable to add directory '%s' to node '%*s': errno=%d\n",
    35cb:	89 c6                	mov    esi,eax
    35cd:	48 8b 95 28 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xd8]
    35d4:	48 8d 45 c0          	lea    rax,[rbp-0x40]
    35d8:	41 89 c8             	mov    r8d,ecx
    35db:	48 89 d1             	mov    rcx,rdx
    35de:	89 f2                	mov    edx,esi
    35e0:	48 89 c6             	mov    rsi,rax
    35e3:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    35ea:	b8 00 00 00 00       	mov    eax,0x0
    35ef:	e8 00 00 00 00       	call   35f4 <fcli_mkdir+0x192>
						return 1;
    35f4:	b8 01 00 00 00       	mov    eax,0x1
    35f9:	eb 36                	jmp    3631 <fcli_mkdir+0x1cf>
						printf("created '%s' at '%*s'\n", ltk, (int)(oc - str), str);
    35fb:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    35ff:	48 2b 85 28 ff ff ff 	sub    rax,QWORD PTR [rbp-0xd8]
    3606:	89 c6                	mov    esi,eax
    3608:	48 8b 95 28 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xd8]
    360f:	48 8d 45 c0          	lea    rax,[rbp-0x40]
    3613:	48 89 d1             	mov    rcx,rdx
    3616:	89 f2                	mov    edx,esi
    3618:	48 89 c6             	mov    rsi,rax
    361b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3622:	b8 00 00 00 00       	mov    eax,0x0
    3627:	e8 00 00 00 00       	call   362c <fcli_mkdir+0x1ca>
				return 1;
    362c:	b8 01 00 00 00       	mov    eax,0x1
}
    3631:	c9                   	leave
    3632:	c3                   	ret

0000000000003633 <file_cli>:

extern int file_cli(const char* str)
{
    3633:	55                   	push   rbp
    3634:	48 89 e5             	mov    rbp,rsp
    3637:	48 83 ec 10          	sub    rsp,0x10
    363b:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		if (strncmp(str, "ls", 2) == 0 && (!str[2] || str[2] == ' '))
    363f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3643:	ba 02 00 00 00       	mov    edx,0x2
    3648:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    364f:	48 89 c7             	mov    rdi,rax
    3652:	e8 00 00 00 00       	call   3657 <file_cli+0x24>
    3657:	85 c0                	test   eax,eax
    3659:	75 2f                	jne    368a <file_cli+0x57>
    365b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    365f:	48 83 c0 02          	add    rax,0x2
    3663:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    3666:	84 c0                	test   al,al
    3668:	74 0f                	je     3679 <file_cli+0x46>
    366a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    366e:	48 83 c0 02          	add    rax,0x2
    3672:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    3675:	3c 20                	cmp    al,0x20
    3677:	75 11                	jne    368a <file_cli+0x57>
				return fcli_ls(str);
    3679:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    367d:	48 89 c7             	mov    rdi,rax
    3680:	e8 00 00 00 00       	call   3685 <file_cli+0x52>
    3685:	e9 a9 00 00 00       	jmp    3733 <file_cli+0x100>
		else if (strncmp(str, "cat", 3) == 0 && (!str[3] || str[3] == ' '))
    368a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    368e:	ba 03 00 00 00       	mov    edx,0x3
    3693:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    369a:	48 89 c7             	mov    rdi,rax
    369d:	e8 00 00 00 00       	call   36a2 <file_cli+0x6f>
    36a2:	85 c0                	test   eax,eax
    36a4:	75 42                	jne    36e8 <file_cli+0xb5>
    36a6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    36aa:	48 83 c0 03          	add    rax,0x3
    36ae:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    36b1:	84 c0                	test   al,al
    36b3:	74 0f                	je     36c4 <file_cli+0x91>
    36b5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    36b9:	48 83 c0 03          	add    rax,0x3
    36bd:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    36c0:	3c 20                	cmp    al,0x20
    36c2:	75 24                	jne    36e8 <file_cli+0xb5>
				if (!str[3]) /* stdin */
    36c4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    36c8:	48 83 c0 03          	add    rax,0x3
    36cc:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    36cf:	84 c0                	test   al,al
    36d1:	75 07                	jne    36da <file_cli+0xa7>
						return 0;
    36d3:	b8 00 00 00 00       	mov    eax,0x0
    36d8:	eb 59                	jmp    3733 <file_cli+0x100>
				else
						return fcli_cat(str);
    36da:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    36de:	48 89 c7             	mov    rdi,rax
    36e1:	e8 00 00 00 00       	call   36e6 <file_cli+0xb3>
    36e6:	eb 4b                	jmp    3733 <file_cli+0x100>
		else if (strncmp(str, "mkdir ", 6) == 0 || strncmp(str, "md ", 3) == 0) {
    36e8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    36ec:	ba 06 00 00 00       	mov    edx,0x6
    36f1:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    36f8:	48 89 c7             	mov    rdi,rax
    36fb:	e8 00 00 00 00       	call   3700 <file_cli+0xcd>
    3700:	85 c0                	test   eax,eax
    3702:	74 1c                	je     3720 <file_cli+0xed>
    3704:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3708:	ba 03 00 00 00       	mov    edx,0x3
    370d:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    3714:	48 89 c7             	mov    rdi,rax
    3717:	e8 00 00 00 00       	call   371c <file_cli+0xe9>
    371c:	85 c0                	test   eax,eax
    371e:	75 0e                	jne    372e <file_cli+0xfb>
				return fcli_mkdir(str);
    3720:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3724:	48 89 c7             	mov    rdi,rax
    3727:	e8 00 00 00 00       	call   372c <file_cli+0xf9>
    372c:	eb 05                	jmp    3733 <file_cli+0x100>
		} else
				return 0; /* we have not handled the command */
    372e:	b8 00 00 00 00       	mov    eax,0x0
}
    3733:	c9                   	leave
    3734:	c3                   	ret

0000000000003735 <module_cleanup>:

void MODENTRY module_cleanup()
{
    3735:	55                   	push   rbp
    3736:	48 89 e5             	mov    rbp,rsp
		printf("goodbye file.ko\n");
    3739:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    3740:	b8 00 00 00 00       	mov    eax,0x0
    3745:	e8 00 00 00 00       	call   374a <module_cleanup+0x15>
}
    374a:	90                   	nop
    374b:	5d                   	pop    rbp
    374c:	c3                   	ret
