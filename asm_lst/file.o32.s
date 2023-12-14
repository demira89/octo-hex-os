
file.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <memcpy>:
				h_destroy(ptr);
				kfree(memdev_data);
				return -1;
		}
		bzero(memdev_data->nodes, 4096 * sizeof(struct memdev_node*));
		return 0;
       0:	55                   	push   ebp
       1:	89 e5                	mov    ebp,esp
       3:	83 ec 10             	sub    esp,0x10
}
       6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
       9:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax

       c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
       f:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
int memdev_unregister()
      12:	eb 17                	jmp    2b <memcpy+0x2b>
{
      14:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
      17:	8d 42 01             	lea    eax,[edx+0x1]
      1a:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
      1d:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
      20:	8d 48 01             	lea    ecx,[eax+0x1]
      23:	89 4d fc             	mov    DWORD PTR [ebp-0x4],ecx
      26:	0f b6 12             	movzx  edx,BYTE PTR [edx]
      29:	88 10                	mov    BYTE PTR [eax],dl
int memdev_unregister()
      2b:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
      2e:	8d 50 ff             	lea    edx,[eax-0x1]
      31:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
      34:	85 c0                	test   eax,eax
      36:	75 dc                	jne    14 <memcpy+0x14>
		errno = ENOSYS;
      38:	90                   	nop
      39:	90                   	nop
      3a:	c9                   	leave
      3b:	c3                   	ret

0000003c <register_device>:
{
      3c:	55                   	push   ebp
      3d:	89 e5                	mov    ebp,esp
      3f:	83 ec 38             	sub    esp,0x38
		dev_t rv = 0; size_t i = 0;
      42:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
      49:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
      50:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		struct dd_drs* dr = &dr0;
      57:	c7 45 e8 20 00 00 00 	mov    DWORD PTR [ebp-0x18],0x20
				if (__sync_bool_compare_and_swap(&dr->descs[i].type, 0, dd->type))
      5e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      61:	0f b6 00             	movzx  eax,BYTE PTR [eax]
      64:	0f b6 d0             	movzx  edx,al
      67:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
      6a:	6b c8 38             	imul   ecx,eax,0x38
      6d:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
      70:	01 c1                	add    ecx,eax
      72:	b8 00 00 00 00       	mov    eax,0x0
      77:	f0 0f b0 11          	lock cmpxchg BYTE PTR [ecx],dl
      7b:	0f 94 c0             	sete   al
      7e:	84 c0                	test   al,al
      80:	0f 85 c1 00 00 00    	jne    147 <register_device+0x10b>
				i++; rv++;
      86:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
      8a:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
      8e:	83 55 f4 00          	adc    DWORD PTR [ebp-0xc],0x0
				if (i == 8) {
      92:	83 7d ec 08          	cmp    DWORD PTR [ebp-0x14],0x8
      96:	75 c6                	jne    5e <register_device+0x22>
						if (!dr->next) {
      98:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
      9b:	8b 80 c0 01 00 00    	mov    eax,DWORD PTR [eax+0x1c0]
      a1:	85 c0                	test   eax,eax
      a3:	0f 85 86 00 00 00    	jne    12f <register_device+0xf3>
								struct dd_drs* dr2 = kmalloc(sizeof(struct dd_drs));
      a9:	c7 04 24 c4 01 00 00 	mov    DWORD PTR [esp],0x1c4
      b0:	e8 fc ff ff ff       	call   b1 <register_device+0x75>
      b5:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
								if (!dr2) {
      b8:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
      bc:	75 19                	jne    d7 <register_device+0x9b>
										errno = ENOMEM;
      be:	c7 05 00 00 00 00 0c 00 00 00 	mov    DWORD PTR ds:0x0,0xc
										return INVALID_DEVICE;
      c8:	b8 ff ff ff ff       	mov    eax,0xffffffff
      cd:	ba 00 00 00 00       	mov    edx,0x0
      d2:	e9 0a 01 00 00       	jmp    1e1 <register_device+0x1a5>
								dr2->next = NULL;
      d7:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
      da:	c7 80 c0 01 00 00 00 00 00 00 	mov    DWORD PTR [eax+0x1c0],0x0
								for (i = 0; i < 8; i++)
      e4:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
      eb:	eb 12                	jmp    ff <register_device+0xc3>
										dr2->descs[i].type = 0;
      ed:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
      f0:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
      f3:	6b c0 38             	imul   eax,eax,0x38
      f6:	01 d0                	add    eax,edx
      f8:	c6 00 00             	mov    BYTE PTR [eax],0x0
								for (i = 0; i < 8; i++)
      fb:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
      ff:	83 7d ec 07          	cmp    DWORD PTR [ebp-0x14],0x7
     103:	76 e8                	jbe    ed <register_device+0xb1>
								if (!__sync_bool_compare_and_swap(&dr->next, NULL, dr2))
     105:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
     108:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     10b:	8d 88 c0 01 00 00    	lea    ecx,[eax+0x1c0]
     111:	b8 00 00 00 00       	mov    eax,0x0
     116:	f0 0f b1 11          	lock cmpxchg DWORD PTR [ecx],edx
     11a:	0f 94 c0             	sete   al
     11d:	83 f0 01             	xor    eax,0x1
     120:	84 c0                	test   al,al
     122:	74 0b                	je     12f <register_device+0xf3>
										kfree(dr2); /* someone was faster */
     124:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     127:	89 04 24             	mov    DWORD PTR [esp],eax
     12a:	e8 fc ff ff ff       	call   12b <register_device+0xef>
						i = 0;
     12f:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
						dr = dr->next;
     136:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     139:	8b 80 c0 01 00 00    	mov    eax,DWORD PTR [eax+0x1c0]
     13f:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				if (__sync_bool_compare_and_swap(&dr->descs[i].type, 0, dd->type))
     142:	e9 17 ff ff ff       	jmp    5e <register_device+0x22>
						break;
     147:	90                   	nop
		dr->descs[i] = *dd;
     148:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
     14b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     14e:	6b c0 38             	imul   eax,eax,0x38
     151:	01 c2                	add    edx,eax
     153:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     156:	8b 08                	mov    ecx,DWORD PTR [eax]
     158:	89 0a                	mov    DWORD PTR [edx],ecx
     15a:	8b 48 04             	mov    ecx,DWORD PTR [eax+0x4]
     15d:	89 4a 04             	mov    DWORD PTR [edx+0x4],ecx
     160:	8b 48 08             	mov    ecx,DWORD PTR [eax+0x8]
     163:	89 4a 08             	mov    DWORD PTR [edx+0x8],ecx
     166:	8b 48 0c             	mov    ecx,DWORD PTR [eax+0xc]
     169:	89 4a 0c             	mov    DWORD PTR [edx+0xc],ecx
     16c:	8b 48 10             	mov    ecx,DWORD PTR [eax+0x10]
     16f:	89 4a 10             	mov    DWORD PTR [edx+0x10],ecx
     172:	8b 48 14             	mov    ecx,DWORD PTR [eax+0x14]
     175:	89 4a 14             	mov    DWORD PTR [edx+0x14],ecx
     178:	8b 48 18             	mov    ecx,DWORD PTR [eax+0x18]
     17b:	89 4a 18             	mov    DWORD PTR [edx+0x18],ecx
     17e:	8b 48 1c             	mov    ecx,DWORD PTR [eax+0x1c]
     181:	89 4a 1c             	mov    DWORD PTR [edx+0x1c],ecx
     184:	8b 48 20             	mov    ecx,DWORD PTR [eax+0x20]
     187:	89 4a 20             	mov    DWORD PTR [edx+0x20],ecx
     18a:	8b 48 24             	mov    ecx,DWORD PTR [eax+0x24]
     18d:	89 4a 24             	mov    DWORD PTR [edx+0x24],ecx
     190:	8b 48 28             	mov    ecx,DWORD PTR [eax+0x28]
     193:	89 4a 28             	mov    DWORD PTR [edx+0x28],ecx
     196:	8b 48 2c             	mov    ecx,DWORD PTR [eax+0x2c]
     199:	89 4a 2c             	mov    DWORD PTR [edx+0x2c],ecx
     19c:	8b 48 30             	mov    ecx,DWORD PTR [eax+0x30]
     19f:	89 4a 30             	mov    DWORD PTR [edx+0x30],ecx
     1a2:	8b 40 34             	mov    eax,DWORD PTR [eax+0x34]
     1a5:	89 42 34             	mov    DWORD PTR [edx+0x34],eax
		if(dd->fn_reg_dev(rv)) {
     1a8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1ab:	8b 48 04             	mov    ecx,DWORD PTR [eax+0x4]
     1ae:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     1b1:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     1b4:	89 04 24             	mov    DWORD PTR [esp],eax
     1b7:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     1bb:	ff d1                	call   ecx
     1bd:	85 c0                	test   eax,eax
     1bf:	74 1a                	je     1db <register_device+0x19f>
				dr->descs[i].type = 0;
     1c1:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
     1c4:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     1c7:	6b c0 38             	imul   eax,eax,0x38
     1ca:	01 d0                	add    eax,edx
     1cc:	c6 00 00             	mov    BYTE PTR [eax],0x0
				return INVALID_DEVICE;
     1cf:	b8 ff ff ff ff       	mov    eax,0xffffffff
     1d4:	ba 00 00 00 00       	mov    edx,0x0
     1d9:	eb 06                	jmp    1e1 <register_device+0x1a5>
		return rv;
     1db:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     1de:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
}
     1e1:	c9                   	leave
     1e2:	c3                   	ret

000001e3 <unregister_device>:
{
     1e3:	55                   	push   ebp
     1e4:	89 e5                	mov    ebp,esp
     1e6:	83 ec 28             	sub    esp,0x28
     1e9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1ec:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
     1ef:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     1f2:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		struct dd_drs* dr = &dr0;
     1f5:	c7 45 f4 20 00 00 00 	mov    DWORD PTR [ebp-0xc],0x20
				if (dev >= 8) {
     1fc:	ba 07 00 00 00       	mov    edx,0x7
     201:	b8 00 00 00 00       	mov    eax,0x0
     206:	3b 55 e0             	cmp    edx,DWORD PTR [ebp-0x20]
     209:	1b 45 e4             	sbb    eax,DWORD PTR [ebp-0x1c]
     20c:	73 2a                	jae    238 <unregister_device+0x55>
						dr = dr->next;
     20e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     211:	8b 80 c0 01 00 00    	mov    eax,DWORD PTR [eax+0x1c0]
     217:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						dr -= 8;
     21a:	81 6d f4 20 0e 00 00 	sub    DWORD PTR [ebp-0xc],0xe20
						if (!dr) {
     221:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     225:	75 d5                	jne    1fc <unregister_device+0x19>
								errno = EINVAL;
     227:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
								return -1;
     231:	b8 ff ff ff ff       	mov    eax,0xffffffff
     236:	eb 56                	jmp    28e <unregister_device+0xab>
						if (!dr->descs[dev].type) {
     238:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     23b:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     23e:	6b c0 38             	imul   eax,eax,0x38
     241:	01 d0                	add    eax,edx
     243:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     246:	84 c0                	test   al,al
     248:	75 11                	jne    25b <unregister_device+0x78>
								errno = EINVAL;
     24a:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
								return -1;
     254:	b8 ff ff ff ff       	mov    eax,0xffffffff
     259:	eb 33                	jmp    28e <unregister_device+0xab>
						rv = dr->descs[dev].fn_unreg_dev();
     25b:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     25e:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     261:	6b c0 38             	imul   eax,eax,0x38
     264:	01 d0                	add    eax,edx
     266:	83 c0 08             	add    eax,0x8
     269:	8b 00                	mov    eax,DWORD PTR [eax]
     26b:	ff d0                	call   eax
     26d:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
						if (!rv) {
     270:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     274:	75 15                	jne    28b <unregister_device+0xa8>
								dr->descs[dev].type = 0;
     276:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     279:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     27c:	6b c0 38             	imul   eax,eax,0x38
     27f:	01 d0                	add    eax,edx
     281:	c6 00 00             	mov    BYTE PTR [eax],0x0
								return 0;
     284:	b8 00 00 00 00       	mov    eax,0x0
     289:	eb 03                	jmp    28e <unregister_device+0xab>
								return rv;
     28b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
}
     28e:	c9                   	leave
     28f:	c3                   	ret

00000290 <get_device>:
{
     290:	55                   	push   ebp
     291:	89 e5                	mov    ebp,esp
     293:	83 ec 18             	sub    esp,0x18
     296:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     299:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
     29c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     29f:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		struct dd_drs* dr = &dr0;
     2a2:	c7 45 fc 20 00 00 00 	mov    DWORD PTR [ebp-0x4],0x20
				if (dev >= 8) {
     2a9:	ba 07 00 00 00       	mov    edx,0x7
     2ae:	b8 00 00 00 00       	mov    eax,0x0
     2b3:	3b 55 e8             	cmp    edx,DWORD PTR [ebp-0x18]
     2b6:	1b 45 ec             	sbb    eax,DWORD PTR [ebp-0x14]
     2b9:	73 2a                	jae    2e5 <get_device+0x55>
						dr = dr->next;
     2bb:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     2be:	8b 80 c0 01 00 00    	mov    eax,DWORD PTR [eax+0x1c0]
     2c4:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
						dr -= 8;
     2c7:	81 6d fc 20 0e 00 00 	sub    DWORD PTR [ebp-0x4],0xe20
						if (!dr) {
     2ce:	83 7d fc 00          	cmp    DWORD PTR [ebp-0x4],0x0
     2d2:	75 d5                	jne    2a9 <get_device+0x19>
								errno = EINVAL;
     2d4:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
								return NULL;
     2de:	b8 00 00 00 00       	mov    eax,0x0
     2e3:	eb 24                	jmp    309 <get_device+0x79>
						if (!dr->descs[dev].type)
     2e5:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     2e8:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     2eb:	6b c0 38             	imul   eax,eax,0x38
     2ee:	01 d0                	add    eax,edx
     2f0:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     2f3:	84 c0                	test   al,al
     2f5:	75 07                	jne    2fe <get_device+0x6e>
								return NULL;
     2f7:	b8 00 00 00 00       	mov    eax,0x0
     2fc:	eb 0b                	jmp    309 <get_device+0x79>
						return dr->descs + dev;
     2fe:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     301:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     304:	6b c0 38             	imul   eax,eax,0x38
     307:	01 d0                	add    eax,edx
}
     309:	c9                   	leave
     30a:	c3                   	ret

0000030b <fil_fd_get>:
{
     30b:	55                   	push   ebp
     30c:	89 e5                	mov    ebp,esp
     30e:	83 ec 10             	sub    esp,0x10
		struct fil_fdc* f = &fdc0;
     311:	c7 45 fc 00 02 00 00 	mov    DWORD PTR [ebp-0x4],0x200
		while (fd >= 64) {
     318:	eb 1d                	jmp    337 <fil_fd_get+0x2c>
				fd -= 64;
     31a:	83 6d 08 40          	sub    DWORD PTR [ebp+0x8],0x40
				f = f->next;
     31e:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     321:	8b 80 00 07 00 00    	mov    eax,DWORD PTR [eax+0x700]
     327:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
				if (!f)
     32a:	83 7d fc 00          	cmp    DWORD PTR [ebp-0x4],0x0
     32e:	75 07                	jne    337 <fil_fd_get+0x2c>
						return NULL;
     330:	b8 00 00 00 00       	mov    eax,0x0
     335:	eb 11                	jmp    348 <fil_fd_get+0x3d>
		while (fd >= 64) {
     337:	83 7d 08 3f          	cmp    DWORD PTR [ebp+0x8],0x3f
     33b:	7f dd                	jg     31a <fil_fd_get+0xf>
		return &f->fds[fd];
     33d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     340:	6b d0 1c             	imul   edx,eax,0x1c
     343:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     346:	01 d0                	add    eax,edx
}
     348:	c9                   	leave
     349:	c3                   	ret

0000034a <fil_fd_allocate>:
{
     34a:	55                   	push   ebp
     34b:	89 e5                	mov    ebp,esp
     34d:	83 ec 28             	sub    esp,0x28
		struct fil_fdc* fdc = &fdc0;
     350:	c7 45 f4 00 02 00 00 	mov    DWORD PTR [ebp-0xc],0x200
		int rv = 0; size_t i;
     357:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
				for (i = 0; i < 64; i++) {
     35e:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
     365:	eb 41                	jmp    3a8 <fil_fd_allocate+0x5e>
						if (__sync_bool_compare_and_swap(&fdc->fds[i].in, NULL, in)) {
     367:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     36a:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     36d:	6b c8 1c             	imul   ecx,eax,0x1c
     370:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     373:	01 c1                	add    ecx,eax
     375:	b8 00 00 00 00       	mov    eax,0x0
     37a:	f0 0f b1 11          	lock cmpxchg DWORD PTR [ecx],edx
     37e:	0f 94 c0             	sete   al
     381:	84 c0                	test   al,al
     383:	74 1f                	je     3a4 <fil_fd_allocate+0x5a>
								*pfd = rv + i;
     385:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     388:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     38b:	01 d0                	add    eax,edx
     38d:	89 c2                	mov    edx,eax
     38f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     392:	89 10                	mov    DWORD PTR [eax],edx
								return &fdc->fds[i];
     394:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     397:	6b d0 1c             	imul   edx,eax,0x1c
     39a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     39d:	01 d0                	add    eax,edx
     39f:	e9 c3 00 00 00       	jmp    467 <fil_fd_allocate+0x11d>
				for (i = 0; i < 64; i++) {
     3a4:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
     3a8:	83 7d ec 3f          	cmp    DWORD PTR [ebp-0x14],0x3f
     3ac:	76 b9                	jbe    367 <fil_fd_allocate+0x1d>
				rv += 64;
     3ae:	83 45 f0 40          	add    DWORD PTR [ebp-0x10],0x40
				if (!fdc->next) {
     3b2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3b5:	8b 80 00 07 00 00    	mov    eax,DWORD PTR [eax+0x700]
     3bb:	85 c0                	test   eax,eax
     3bd:	0f 85 93 00 00 00    	jne    456 <fil_fd_allocate+0x10c>
						struct fil_fdc* f2 = fdc->next = (struct fil_fdc*)kmalloc(sizeof(struct fil_fdc));
     3c3:	c7 04 24 04 07 00 00 	mov    DWORD PTR [esp],0x704
     3ca:	e8 fc ff ff ff       	call   3cb <fil_fd_allocate+0x81>
     3cf:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     3d2:	89 82 00 07 00 00    	mov    DWORD PTR [edx+0x700],eax
     3d8:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3db:	8b 80 00 07 00 00    	mov    eax,DWORD PTR [eax+0x700]
     3e1:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
						if (!f2) {
     3e4:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
     3e8:	75 11                	jne    3fb <fil_fd_allocate+0xb1>
								errno = ENOMEM;
     3ea:	c7 05 00 00 00 00 0c 00 00 00 	mov    DWORD PTR ds:0x0,0xc
								return NULL;
     3f4:	b8 00 00 00 00       	mov    eax,0x0
     3f9:	eb 6c                	jmp    467 <fil_fd_allocate+0x11d>
						f2->next = NULL;
     3fb:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     3fe:	c7 80 00 07 00 00 00 00 00 00 	mov    DWORD PTR [eax+0x700],0x0
						for (i = 0; i < 64; i++)
     408:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
     40f:	eb 15                	jmp    426 <fil_fd_allocate+0xdc>
								f2->fds[i].in = NULL;
     411:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
     414:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     417:	6b c0 1c             	imul   eax,eax,0x1c
     41a:	01 d0                	add    eax,edx
     41c:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
						for (i = 0; i < 64; i++)
     422:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
     426:	83 7d ec 3f          	cmp    DWORD PTR [ebp-0x14],0x3f
     42a:	76 e5                	jbe    411 <fil_fd_allocate+0xc7>
						if (!__sync_bool_compare_and_swap(&fdc->next, NULL, f2))
     42c:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
     42f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     432:	8d 88 00 07 00 00    	lea    ecx,[eax+0x700]
     438:	b8 00 00 00 00       	mov    eax,0x0
     43d:	f0 0f b1 11          	lock cmpxchg DWORD PTR [ecx],edx
     441:	0f 94 c0             	sete   al
     444:	83 f0 01             	xor    eax,0x1
     447:	84 c0                	test   al,al
     449:	74 0b                	je     456 <fil_fd_allocate+0x10c>
								kfree(f2); /* someone was faster */
     44b:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     44e:	89 04 24             	mov    DWORD PTR [esp],eax
     451:	e8 fc ff ff ff       	call   452 <fil_fd_allocate+0x108>
				fdc = fdc->next;
     456:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     459:	8b 80 00 07 00 00    	mov    eax,DWORD PTR [eax+0x700]
     45f:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				for (i = 0; i < 64; i++) {
     462:	e9 f7 fe ff ff       	jmp    35e <fil_fd_allocate+0x14>
}
     467:	c9                   	leave
     468:	c3                   	ret

00000469 <fil_fd_free>:
{
     469:	55                   	push   ebp
     46a:	89 e5                	mov    ebp,esp
     46c:	83 ec 10             	sub    esp,0x10
		struct fil_fdc* fdc = &fdc0;
     46f:	c7 45 fc 00 02 00 00 	mov    DWORD PTR [ebp-0x4],0x200
				if (fd >= 64) {
     476:	83 7d 08 3f          	cmp    DWORD PTR [ebp+0x8],0x3f
     47a:	7e 18                	jle    494 <fil_fd_free+0x2b>
						fdc = fdc->next;
     47c:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     47f:	8b 80 00 07 00 00    	mov    eax,DWORD PTR [eax+0x700]
     485:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
						fd -= 64;
     488:	83 6d 08 40          	sub    DWORD PTR [ebp+0x8],0x40
						if (!fdc)
     48c:	83 7d fc 00          	cmp    DWORD PTR [ebp-0x4],0x0
     490:	75 e4                	jne    476 <fil_fd_free+0xd>
								return;
     492:	eb 25                	jmp    4b9 <fil_fd_free+0x50>
						if (fdc->fds[fd].in) {
     494:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     497:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     49a:	6b c0 1c             	imul   eax,eax,0x1c
     49d:	01 d0                	add    eax,edx
     49f:	8b 00                	mov    eax,DWORD PTR [eax]
     4a1:	85 c0                	test   eax,eax
     4a3:	74 13                	je     4b8 <fil_fd_free+0x4f>
								fdc->fds[fd].in = NULL;
     4a5:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     4a8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     4ab:	6b c0 1c             	imul   eax,eax,0x1c
     4ae:	01 d0                	add    eax,edx
     4b0:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
								return;
     4b6:	eb 01                	jmp    4b9 <fil_fd_free+0x50>
								return;
     4b8:	90                   	nop
}
     4b9:	c9                   	leave
     4ba:	c3                   	ret

000004bb <ino_allocate>:
{
     4bb:	55                   	push   ebp
     4bc:	89 e5                	mov    ebp,esp
     4be:	57                   	push   edi
     4bf:	56                   	push   esi
     4c0:	53                   	push   ebx
     4c1:	83 ec 4c             	sub    esp,0x4c
		struct fil_inc* fi = &inc0; ino_t val = 1;
     4c4:	c7 45 d8 20 09 00 00 	mov    DWORD PTR [ebp-0x28],0x920
     4cb:	c7 45 e0 01 00 00 00 	mov    DWORD PTR [ebp-0x20],0x1
     4d2:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
				struct inode* in = fi->inodes;
     4d9:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     4dc:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
						if (__sync_bool_compare_and_swap(&in->in_stat.st_ino, 0, val)) {
     4df:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     4e2:	8d 70 08             	lea    esi,[eax+0x8]
     4e5:	b8 00 00 00 00       	mov    eax,0x0
     4ea:	ba 00 00 00 00       	mov    edx,0x0
     4ef:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
     4f2:	8b 5d e4             	mov    ebx,DWORD PTR [ebp-0x1c]
     4f5:	89 4d c0             	mov    DWORD PTR [ebp-0x40],ecx
     4f8:	89 5d c4             	mov    DWORD PTR [ebp-0x3c],ebx
     4fb:	89 cb                	mov    ebx,ecx
     4fd:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
     500:	f0 0f c7 0e          	lock cmpxchg8b QWORD PTR [esi]
     504:	0f 94 c0             	sete   al
     507:	84 c0                	test   al,al
     509:	0f 84 de 00 00 00    	je     5ed <ino_allocate+0x132>
								in->in_stat.st_nlink = 0;
     50f:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     512:	c7 40 14 00 00 00 00 	mov    DWORD PTR [eax+0x14],0x0
     519:	c7 40 18 00 00 00 00 	mov    DWORD PTR [eax+0x18],0x0
								in->in_lock = (rwlock_t)RW_LOCK_UNLOCKED;
     520:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     523:	c7 40 74 00 00 00 00 	mov    DWORD PTR [eax+0x74],0x0
     52a:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     52d:	66 c7 40 78 00 00    	mov    WORD PTR [eax+0x78],0x0
								bzero(in->in_ddat, sizeof(in->in_ddat));
     533:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     536:	83 c0 68             	add    eax,0x68
     539:	c7 44 24 04 08 00 00 00 	mov    DWORD PTR [esp+0x4],0x8
     541:	89 04 24             	mov    DWORD PTR [esp],eax
     544:	e8 fc ff ff ff       	call   545 <ino_allocate+0x8a>
								if (init) {
     549:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     54d:	74 6a                	je     5b9 <ino_allocate+0xfe>
										in->in_stat.st_uid = 0;
     54f:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     552:	c7 40 1c 00 00 00 00 	mov    DWORD PTR [eax+0x1c],0x0
										in->in_stat.st_gid = 0;
     559:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     55c:	c7 40 20 00 00 00 00 	mov    DWORD PTR [eax+0x20],0x0
										in->in_stat.st_mode = init | S_IRWXU | S_IRGRP | S_IXGRP | S_IROTH | S_IXOTH;
     563:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     566:	0d ed 01 00 00       	or     eax,0x1ed
     56b:	89 c2                	mov    edx,eax
     56d:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     570:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
										clock_gettime(CLOCK_REALTIME, &in->in_stat.st_ctim);
     573:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     576:	83 c0 5c             	add    eax,0x5c
     579:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     57d:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     584:	e8 fc ff ff ff       	call   585 <ino_allocate+0xca>
												= in->in_stat.st_ctim;
     589:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     58c:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     58f:	8b 4a 5c             	mov    ecx,DWORD PTR [edx+0x5c]
     592:	89 48 44             	mov    DWORD PTR [eax+0x44],ecx
     595:	8b 4a 60             	mov    ecx,DWORD PTR [edx+0x60]
     598:	89 48 48             	mov    DWORD PTR [eax+0x48],ecx
     59b:	8b 52 64             	mov    edx,DWORD PTR [edx+0x64]
     59e:	89 50 4c             	mov    DWORD PTR [eax+0x4c],edx
										in->in_stat.st_mtim = in->in_stat.st_atim
     5a1:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     5a4:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     5a7:	8b 4a 44             	mov    ecx,DWORD PTR [edx+0x44]
     5aa:	89 48 50             	mov    DWORD PTR [eax+0x50],ecx
     5ad:	8b 4a 48             	mov    ecx,DWORD PTR [edx+0x48]
     5b0:	89 48 54             	mov    DWORD PTR [eax+0x54],ecx
     5b3:	8b 52 4c             	mov    edx,DWORD PTR [edx+0x4c]
     5b6:	89 50 58             	mov    DWORD PTR [eax+0x58],edx
								__sync_fetch_and_add(&ino_ct, 1);
     5b9:	a1 28 28 00 00       	mov    eax,ds:0x2828
     5be:	8b 15 2c 28 00 00    	mov    edx,DWORD PTR ds:0x282c
     5c4:	89 c1                	mov    ecx,eax
     5c6:	89 d3                	mov    ebx,edx
     5c8:	83 c1 01             	add    ecx,0x1
     5cb:	83 d3 00             	adc    ebx,0x0
     5ce:	89 ce                	mov    esi,ecx
     5d0:	89 df                	mov    edi,ebx
     5d2:	89 f3                	mov    ebx,esi
     5d4:	89 f9                	mov    ecx,edi
     5d6:	f0 0f c7 0d 28 28 00 00 	lock cmpxchg8b QWORD PTR ds:0x2828
     5de:	0f 94 c1             	sete   cl
     5e1:	84 c9                	test   cl,cl
     5e3:	74 df                	je     5c4 <ino_allocate+0x109>
								return in;
     5e5:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     5e8:	e9 9f 00 00 00       	jmp    68c <ino_allocate+0x1d1>
						val++;
     5ed:	83 45 e0 01          	add    DWORD PTR [ebp-0x20],0x1
     5f1:	83 55 e4 00          	adc    DWORD PTR [ebp-0x1c],0x0
				} while ((void*)(in++) != (void*)(&fi->next));
     5f5:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     5f8:	8d 50 7c             	lea    edx,[eax+0x7c]
     5fb:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
     5fe:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
     601:	81 c2 00 1f 00 00    	add    edx,0x1f00
     607:	39 d0                	cmp    eax,edx
     609:	0f 85 d0 fe ff ff    	jne    4df <ino_allocate+0x24>
				if (!fi->next) {
     60f:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     612:	8b 80 00 1f 00 00    	mov    eax,DWORD PTR [eax+0x1f00]
     618:	85 c0                	test   eax,eax
     61a:	0f 85 b9 fe ff ff    	jne    4d9 <ino_allocate+0x1e>
						struct fil_inc* fi2 = kmalloc(sizeof(struct fil_inc));
     620:	c7 04 24 04 1f 00 00 	mov    DWORD PTR [esp],0x1f04
     627:	e8 fc ff ff ff       	call   628 <ino_allocate+0x16d>
     62c:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
						if (!fi2) {
     62f:	83 7d d4 00          	cmp    DWORD PTR [ebp-0x2c],0x0
     633:	75 11                	jne    646 <ino_allocate+0x18b>
								errno = ENOMEM;
     635:	c7 05 00 00 00 00 0c 00 00 00 	mov    DWORD PTR ds:0x0,0xc
								return NULL;
     63f:	b8 00 00 00 00       	mov    eax,0x0
     644:	eb 46                	jmp    68c <ino_allocate+0x1d1>
						bzero(fi2, sizeof(*fi2));
     646:	c7 44 24 04 04 1f 00 00 	mov    DWORD PTR [esp+0x4],0x1f04
     64e:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     651:	89 04 24             	mov    DWORD PTR [esp],eax
     654:	e8 fc ff ff ff       	call   655 <ino_allocate+0x19a>
						if (!__sync_bool_compare_and_swap(&fi->next, NULL, fi2)) {
     659:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     65c:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     65f:	8d 88 00 1f 00 00    	lea    ecx,[eax+0x1f00]
     665:	b8 00 00 00 00       	mov    eax,0x0
     66a:	f0 0f b1 11          	lock cmpxchg DWORD PTR [ecx],edx
     66e:	0f 94 c0             	sete   al
     671:	83 f0 01             	xor    eax,0x1
     674:	84 c0                	test   al,al
     676:	0f 84 5d fe ff ff    	je     4d9 <ino_allocate+0x1e>
								kfree(fi2);
     67c:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     67f:	89 04 24             	mov    DWORD PTR [esp],eax
     682:	e8 fc ff ff ff       	call   683 <ino_allocate+0x1c8>
		while (1) {
     687:	e9 4d fe ff ff       	jmp    4d9 <ino_allocate+0x1e>
}
     68c:	83 c4 4c             	add    esp,0x4c
     68f:	5b                   	pop    ebx
     690:	5e                   	pop    esi
     691:	5f                   	pop    edi
     692:	5d                   	pop    ebp
     693:	c3                   	ret

00000694 <ino_release>:
{
     694:	55                   	push   ebp
     695:	89 e5                	mov    ebp,esp
     697:	57                   	push   edi
     698:	56                   	push   esi
     699:	53                   	push   ebx
     69a:	83 ec 0c             	sub    esp,0xc
		ino->in_stat.st_ino = 0;
     69d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     6a0:	c7 40 08 00 00 00 00 	mov    DWORD PTR [eax+0x8],0x0
     6a7:	c7 40 0c 00 00 00 00 	mov    DWORD PTR [eax+0xc],0x0
		return __sync_fetch_and_sub(&ino_ct, 1);
     6ae:	a1 28 28 00 00       	mov    eax,ds:0x2828
     6b3:	8b 15 2c 28 00 00    	mov    edx,DWORD PTR ds:0x282c
     6b9:	89 c6                	mov    esi,eax
     6bb:	89 d7                	mov    edi,edx
     6bd:	89 c1                	mov    ecx,eax
     6bf:	89 d3                	mov    ebx,edx
     6c1:	83 c1 ff             	add    ecx,0xffffffff
     6c4:	83 d3 ff             	adc    ebx,0xffffffff
     6c7:	89 4d e8             	mov    DWORD PTR [ebp-0x18],ecx
     6ca:	89 5d ec             	mov    DWORD PTR [ebp-0x14],ebx
     6cd:	8b 5d e8             	mov    ebx,DWORD PTR [ebp-0x18]
     6d0:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
     6d3:	f0 0f c7 0d 28 28 00 00 	lock cmpxchg8b QWORD PTR ds:0x2828
     6db:	0f 94 c1             	sete   cl
     6de:	84 c9                	test   cl,cl
     6e0:	74 d7                	je     6b9 <ino_release+0x25>
     6e2:	89 f0                	mov    eax,esi
}
     6e4:	83 c4 0c             	add    esp,0xc
     6e7:	5b                   	pop    ebx
     6e8:	5e                   	pop    esi
     6e9:	5f                   	pop    edi
     6ea:	5d                   	pop    ebp
     6eb:	c3                   	ret

000006ec <memdev_store_node>:
{
     6ec:	55                   	push   ebp
     6ed:	89 e5                	mov    ebp,esp
     6ef:	83 ec 28             	sub    esp,0x28
		struct memdev_node** ns = memdev_data->nodes;
     6f2:	a1 00 00 00 00       	mov    eax,ds:0x0
     6f7:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     6fa:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		for (i = 0; i < memdev_data->node_cap_bts; i++) {
     6fd:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
     704:	e9 2f 01 00 00       	jmp    838 <memdev_store_node+0x14c>
				if (__sync_bool_compare_and_swap(&ns[i], NULL, n))
     709:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     70c:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     70f:	8d 0c 85 00 00 00 00 	lea    ecx,[eax*4+0x0]
     716:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     719:	01 c1                	add    ecx,eax
     71b:	b8 00 00 00 00       	mov    eax,0x0
     720:	f0 0f b1 11          	lock cmpxchg DWORD PTR [ecx],edx
     724:	0f 94 c0             	sete   al
     727:	84 c0                	test   al,al
     729:	74 14                	je     73f <memdev_store_node+0x53>
						return &ns[i]; /* stored */
     72b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     72e:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     735:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     738:	01 d0                	add    eax,edx
     73a:	e9 0f 01 00 00       	jmp    84e <memdev_store_node+0x162>
				if (i == memdev_data->node_cap_bts - 2) { /* next is ptr */
     73f:	a1 00 00 00 00       	mov    eax,ds:0x0
     744:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     747:	83 e8 02             	sub    eax,0x2
     74a:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
     74d:	0f 85 e1 00 00 00    	jne    834 <memdev_store_node+0x148>
						if (ns[++i])
     753:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
     757:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     75a:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     761:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     764:	01 d0                	add    eax,edx
     766:	8b 00                	mov    eax,DWORD PTR [eax]
     768:	85 c0                	test   eax,eax
     76a:	74 19                	je     785 <memdev_store_node+0x99>
								ns = (struct memdev_node**)ns[i];
     76c:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     76f:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     776:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     779:	01 d0                	add    eax,edx
     77b:	8b 00                	mov    eax,DWORD PTR [eax]
     77d:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     780:	e9 a8 00 00 00       	jmp    82d <memdev_store_node+0x141>
									memdev_data->node_cap_bts * sizeof(struct memdev_node*));
     785:	a1 00 00 00 00       	mov    eax,ds:0x0
     78a:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
								ns2 = h_malloc(memdev_data->heap,
     78d:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     794:	a1 00 00 00 00       	mov    eax,ds:0x0
     799:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     79c:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     7a0:	89 04 24             	mov    DWORD PTR [esp],eax
     7a3:	e8 fc ff ff ff       	call   7a4 <memdev_store_node+0xb8>
     7a8:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
								if (!ns2) /* OOM */
     7ab:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     7af:	75 0a                	jne    7bb <memdev_store_node+0xcf>
										return NULL;
     7b1:	b8 00 00 00 00       	mov    eax,0x0
     7b6:	e9 93 00 00 00       	jmp    84e <memdev_store_node+0x162>
								bzero(ns2, memdev_data->node_cap_bts * sizeof(struct memdev_node*));
     7bb:	a1 00 00 00 00       	mov    eax,ds:0x0
     7c0:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     7c3:	c1 e0 02             	shl    eax,0x2
     7c6:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     7ca:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     7cd:	89 04 24             	mov    DWORD PTR [esp],eax
     7d0:	e8 fc ff ff ff       	call   7d1 <memdev_store_node+0xe5>
								if (!__sync_bool_compare_and_swap(&ns[i], NULL, ns2)) {
     7d5:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     7d8:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     7db:	8d 0c 85 00 00 00 00 	lea    ecx,[eax*4+0x0]
     7e2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     7e5:	01 c1                	add    ecx,eax
     7e7:	b8 00 00 00 00       	mov    eax,0x0
     7ec:	f0 0f b1 11          	lock cmpxchg DWORD PTR [ecx],edx
     7f0:	0f 94 c0             	sete   al
     7f3:	83 f0 01             	xor    eax,0x1
     7f6:	84 c0                	test   al,al
     7f8:	74 2d                	je     827 <memdev_store_node+0x13b>
										h_free(memdev_data->heap, ns2);
     7fa:	a1 00 00 00 00       	mov    eax,ds:0x0
     7ff:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     802:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     805:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     809:	89 04 24             	mov    DWORD PTR [esp],eax
     80c:	e8 fc ff ff ff       	call   80d <memdev_store_node+0x121>
										ns = (struct memdev_node**)ns[i];
     811:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     814:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     81b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     81e:	01 d0                	add    eax,edx
     820:	8b 00                	mov    eax,DWORD PTR [eax]
     822:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     825:	eb 06                	jmp    82d <memdev_store_node+0x141>
										ns = ns2;
     827:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     82a:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						i = 0;
     82d:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
		for (i = 0; i < memdev_data->node_cap_bts; i++) {
     834:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
     838:	a1 00 00 00 00       	mov    eax,ds:0x0
     83d:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     840:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
     843:	0f 82 c0 fe ff ff    	jb     709 <memdev_store_node+0x1d>
		return NULL;
     849:	b8 00 00 00 00       	mov    eax,0x0
}
     84e:	c9                   	leave
     84f:	c3                   	ret

00000850 <memdev_register>:
{
     850:	55                   	push   ebp
     851:	89 e5                	mov    ebp,esp
     853:	53                   	push   ebx
     854:	83 ec 34             	sub    esp,0x34
     857:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     85a:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
     85d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     860:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		memdev_data = (struct memdev_data*)kmalloc(sizeof(struct memdev_data));
     863:	c7 04 24 18 00 00 00 	mov    DWORD PTR [esp],0x18
     86a:	e8 fc ff ff ff       	call   86b <memdev_register+0x1b>
     86f:	a3 00 00 00 00       	mov    ds:0x0,eax
		if (!memdev_data)
     874:	a1 00 00 00 00       	mov    eax,ds:0x0
     879:	85 c0                	test   eax,eax
     87b:	75 0a                	jne    887 <memdev_register+0x37>
				return -1;
     87d:	b8 ff ff ff ff       	mov    eax,0xffffffff
     882:	e9 4d 01 00 00       	jmp    9d4 <memdev_register+0x184>
		memdev_data->id = d;
     887:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
     88d:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     890:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
     893:	89 01                	mov    DWORD PTR [ecx],eax
     895:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		memdev_data->node_ct = 0;
     898:	a1 00 00 00 00       	mov    eax,ds:0x0
     89d:	c7 40 0c 00 00 00 00 	mov    DWORD PTR [eax+0xc],0x0
		memdev_data->node_cap_bts = 4096;
     8a4:	a1 00 00 00 00       	mov    eax,ds:0x0
     8a9:	c7 40 10 00 10 00 00 	mov    DWORD PTR [eax+0x10],0x1000
		memdev_data->heap = mm_alloc_vmem(&mm_kernel, NULL, 25,
     8b0:	8b 1d 00 00 00 00    	mov    ebx,DWORD PTR ds:0x0
     8b6:	c7 44 24 0c 0c 00 00 00 	mov    DWORD PTR [esp+0xc],0xc
     8be:	c7 44 24 08 19 00 00 00 	mov    DWORD PTR [esp+0x8],0x19
     8c6:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
     8ce:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     8d5:	e8 fc ff ff ff       	call   8d6 <memdev_register+0x86>
     8da:	89 43 14             	mov    DWORD PTR [ebx+0x14],eax
		if (!memdev_data->heap) {
     8dd:	a1 00 00 00 00       	mov    eax,ds:0x0
     8e2:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     8e5:	85 c0                	test   eax,eax
     8e7:	75 17                	jne    900 <memdev_register+0xb0>
				kfree(memdev_data);
     8e9:	a1 00 00 00 00       	mov    eax,ds:0x0
     8ee:	89 04 24             	mov    DWORD PTR [esp],eax
     8f1:	e8 fc ff ff ff       	call   8f2 <memdev_register+0xa2>
				return -1;
     8f6:	b8 ff ff ff ff       	mov    eax,0xffffffff
     8fb:	e9 d4 00 00 00       	jmp    9d4 <memdev_register+0x184>
		ptr = h_create_heap(memdev_data->heap, 25 * 4096, h_generic_oom_handler, h_generic_decommit);
     900:	a1 00 00 00 00       	mov    eax,ds:0x0
     905:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     908:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
     910:	c7 44 24 08 00 00 00 00 	mov    DWORD PTR [esp+0x8],0x0
     918:	c7 44 24 04 00 90 01 00 	mov    DWORD PTR [esp+0x4],0x19000
     920:	89 04 24             	mov    DWORD PTR [esp],eax
     923:	e8 fc ff ff ff       	call   924 <memdev_register+0xd4>
     928:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!ptr) {
     92b:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     92f:	75 34                	jne    965 <memdev_register+0x115>
				mm_free_vmem(&mm_kernel, memdev_data->heap, 25);
     931:	a1 00 00 00 00       	mov    eax,ds:0x0
     936:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     939:	c7 44 24 08 19 00 00 00 	mov    DWORD PTR [esp+0x8],0x19
     941:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     945:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     94c:	e8 fc ff ff ff       	call   94d <memdev_register+0xfd>
				kfree(memdev_data);
     951:	a1 00 00 00 00       	mov    eax,ds:0x0
     956:	89 04 24             	mov    DWORD PTR [esp],eax
     959:	e8 fc ff ff ff       	call   95a <memdev_register+0x10a>
				return -1;
     95e:	b8 ff ff ff ff       	mov    eax,0xffffffff
     963:	eb 6f                	jmp    9d4 <memdev_register+0x184>
		memdev_data->heap = ptr;
     965:	a1 00 00 00 00       	mov    eax,ds:0x0
     96a:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     96d:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
		memdev_data->nodes = h_malloc(ptr, 4096 * sizeof(struct memdev_node*));
     970:	8b 1d 00 00 00 00    	mov    ebx,DWORD PTR ds:0x0
     976:	c7 44 24 04 00 40 00 00 	mov    DWORD PTR [esp+0x4],0x4000
     97e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     981:	89 04 24             	mov    DWORD PTR [esp],eax
     984:	e8 fc ff ff ff       	call   985 <memdev_register+0x135>
     989:	89 43 08             	mov    DWORD PTR [ebx+0x8],eax
		if (!memdev_data->nodes) {
     98c:	a1 00 00 00 00       	mov    eax,ds:0x0
     991:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     994:	85 c0                	test   eax,eax
     996:	75 1f                	jne    9b7 <memdev_register+0x167>
				h_destroy(ptr);
     998:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     99b:	89 04 24             	mov    DWORD PTR [esp],eax
     99e:	e8 fc ff ff ff       	call   99f <memdev_register+0x14f>
				kfree(memdev_data);
     9a3:	a1 00 00 00 00       	mov    eax,ds:0x0
     9a8:	89 04 24             	mov    DWORD PTR [esp],eax
     9ab:	e8 fc ff ff ff       	call   9ac <memdev_register+0x15c>
				return -1;
     9b0:	b8 ff ff ff ff       	mov    eax,0xffffffff
     9b5:	eb 1d                	jmp    9d4 <memdev_register+0x184>
		bzero(memdev_data->nodes, 4096 * sizeof(struct memdev_node*));
     9b7:	a1 00 00 00 00       	mov    eax,ds:0x0
     9bc:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     9bf:	c7 44 24 04 00 40 00 00 	mov    DWORD PTR [esp+0x4],0x4000
     9c7:	89 04 24             	mov    DWORD PTR [esp],eax
     9ca:	e8 fc ff ff ff       	call   9cb <memdev_register+0x17b>
		return 0;
     9cf:	b8 00 00 00 00       	mov    eax,0x0
}
     9d4:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     9d7:	c9                   	leave
     9d8:	c3                   	ret

000009d9 <memdev_unregister>:
{
     9d9:	55                   	push   ebp
     9da:	89 e5                	mov    ebp,esp
		errno = ENOSYS;
     9dc:	c7 05 00 00 00 00 26 00 00 00 	mov    DWORD PTR ds:0x0,0x26
		return -1;
     9e6:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
     9eb:	5d                   	pop    ebp
     9ec:	c3                   	ret

000009ed <memdev_open>:

/* mode only on O_CREAT which is done externally */
int memdev_open(struct inode* in, int flags/*, mode_t mod*/)
{
     9ed:	55                   	push   ebp
     9ee:	89 e5                	mov    ebp,esp
     9f0:	57                   	push   edi
     9f1:	56                   	push   esi
     9f2:	53                   	push   ebx
     9f3:	83 ec 2c             	sub    esp,0x2c
		struct fil_fd* fd; int rv;
		if (!in || in->in_stat.st_dev != memdev_data->id) {
     9f6:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     9fa:	74 22                	je     a1e <memdev_open+0x31>
     9fc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     9ff:	8b 08                	mov    ecx,DWORD PTR [eax]
     a01:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
     a04:	a1 00 00 00 00       	mov    eax,ds:0x0
     a09:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     a0c:	8b 00                	mov    eax,DWORD PTR [eax]
     a0e:	89 cf                	mov    edi,ecx
     a10:	89 c6                	mov    esi,eax
     a12:	89 d9                	mov    ecx,ebx
     a14:	89 f8                	mov    eax,edi
     a16:	31 f0                	xor    eax,esi
     a18:	31 ca                	xor    edx,ecx
     a1a:	09 d0                	or     eax,edx
     a1c:	74 11                	je     a2f <memdev_open+0x42>
				errno = EINVAL;
     a1e:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
				return -1;
     a28:	b8 ff ff ff ff       	mov    eax,0xffffffff
     a2d:	eb 53                	jmp    a82 <memdev_open+0x95>
		}

		/* access checks are done on the level above */
		fd = fil_fd_allocate(in, &rv);
     a2f:	8d 45 e0             	lea    eax,[ebp-0x20]
     a32:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     a36:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a39:	89 04 24             	mov    DWORD PTR [esp],eax
     a3c:	e8 fc ff ff ff       	call   a3d <memdev_open+0x50>
     a41:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		if (!fd) {
     a44:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
     a48:	75 11                	jne    a5b <memdev_open+0x6e>
				errno = ENOMEM;
     a4a:	c7 05 00 00 00 00 0c 00 00 00 	mov    DWORD PTR ds:0x0,0xc
				return -1;
     a54:	b8 ff ff ff ff       	mov    eax,0xffffffff
     a59:	eb 27                	jmp    a82 <memdev_open+0x95>
		}

		fd->flags = flags;
     a5b:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     a5e:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     a61:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
		fd->seek_offset = 0;
     a64:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     a67:	c7 40 04 00 00 00 00 	mov    DWORD PTR [eax+0x4],0x0
     a6e:	c7 40 08 00 00 00 00 	mov    DWORD PTR [eax+0x8],0x0
		__sync_fetch_and_add((int*)in->in_ddat, 1);
     a75:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a78:	83 c0 68             	add    eax,0x68
     a7b:	f0 83 00 01          	lock add DWORD PTR [eax],0x1
		return rv;
     a7f:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
}
     a82:	83 c4 2c             	add    esp,0x2c
     a85:	5b                   	pop    ebx
     a86:	5e                   	pop    esi
     a87:	5f                   	pop    edi
     a88:	5d                   	pop    ebp
     a89:	c3                   	ret

00000a8a <memdev_read>:

ssize_t memdev_read(struct inode* in, int fd, void* buf, size_t noct)
{
     a8a:	55                   	push   ebp
     a8b:	89 e5                	mov    ebp,esp
     a8d:	57                   	push   edi
     a8e:	56                   	push   esi
     a8f:	53                   	push   ebx
     a90:	83 ec 2c             	sub    esp,0x2c
		struct fil_fd* f; ssize_t rv = 0;
     a93:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
		struct memdev_node* n;
		if (!in || !buf || in->in_stat.st_dev != memdev_data->id) {
     a9a:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     a9e:	74 28                	je     ac8 <memdev_read+0x3e>
     aa0:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
     aa4:	74 22                	je     ac8 <memdev_read+0x3e>
     aa6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     aa9:	8b 08                	mov    ecx,DWORD PTR [eax]
     aab:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
     aae:	a1 00 00 00 00       	mov    eax,ds:0x0
     ab3:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     ab6:	8b 00                	mov    eax,DWORD PTR [eax]
     ab8:	89 cf                	mov    edi,ecx
     aba:	89 c6                	mov    esi,eax
     abc:	89 d9                	mov    ecx,ebx
     abe:	89 f8                	mov    eax,edi
     ac0:	31 f0                	xor    eax,esi
     ac2:	31 ca                	xor    edx,ecx
     ac4:	09 d0                	or     eax,edx
     ac6:	74 14                	je     adc <memdev_read+0x52>
				errno = EINVAL;
     ac8:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
				return -1;
     ad2:	b8 ff ff ff ff       	mov    eax,0xffffffff
     ad7:	e9 13 01 00 00       	jmp    bef <memdev_read+0x165>
		}

		f = fil_fd_get(fd);
     adc:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     adf:	89 04 24             	mov    DWORD PTR [esp],eax
     ae2:	e8 fc ff ff ff       	call   ae3 <memdev_read+0x59>
     ae7:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		if (!f || (f->flags & O_WRONLY)
     aea:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
     aee:	74 0d                	je     afd <memdev_read+0x73>
     af0:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     af3:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
     af6:	83 e0 01             	and    eax,0x1
     af9:	85 c0                	test   eax,eax
     afb:	74 14                	je     b11 <memdev_read+0x87>
			/*|| ((f->flags & O_SEARCH) && !S_ISDIR(in->in_stat.st_mode))*/
			/*|| (f->flags & O_EXEC)*/) { /* O_EXEC->mmap with exec */
				errno = EBADF;
     afd:	c7 05 00 00 00 00 09 00 00 00 	mov    DWORD PTR ds:0x0,0x9
				return -1;
     b07:	b8 ff ff ff ff       	mov    eax,0xffffffff
     b0c:	e9 de 00 00 00       	jmp    bef <memdev_read+0x165>
		}

		/* now lock for read access */
		read_lock(&in->in_lock);
     b11:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     b14:	83 c0 74             	add    eax,0x74
     b17:	89 04 24             	mov    DWORD PTR [esp],eax
     b1a:	e8 fc ff ff ff       	call   b1b <memdev_read+0x91>
		n = *(struct memdev_node**)in->in_pddat;
     b1f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     b22:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
     b25:	8b 00                	mov    eax,DWORD PTR [eax]
     b27:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		if (f->seek_offset < (n->size - sizeof(struct memdev_node))) {
     b2a:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     b2d:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
     b30:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     b33:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
     b36:	8b 49 04             	mov    ecx,DWORD PTR [ecx+0x4]
     b39:	83 e9 10             	sub    ecx,0x10
     b3c:	bb 00 00 00 00       	mov    ebx,0x0
     b41:	39 c8                	cmp    eax,ecx
     b43:	89 d0                	mov    eax,edx
     b45:	19 d8                	sbb    eax,ebx
     b47:	7d 6a                	jge    bb3 <memdev_read+0x129>
				/* read up to noct bytes */
				rv = n->size - sizeof(struct memdev_node) - f->seek_offset;
     b49:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     b4c:	8b 48 04             	mov    ecx,DWORD PTR [eax+0x4]
     b4f:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     b52:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
     b55:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     b58:	89 c2                	mov    edx,eax
     b5a:	89 c8                	mov    eax,ecx
     b5c:	29 d0                	sub    eax,edx
     b5e:	83 e8 10             	sub    eax,0x10
     b61:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				if ((size_t)rv > noct)
     b64:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     b67:	39 45 14             	cmp    DWORD PTR [ebp+0x14],eax
     b6a:	73 06                	jae    b72 <memdev_read+0xe8>
						rv = noct;
     b6c:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     b6f:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				memcpy(buf, n->data + f->seek_offset, rv);
     b72:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
     b75:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     b78:	8d 58 10             	lea    ebx,[eax+0x10]
     b7b:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     b7e:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
     b81:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     b84:	01 d8                	add    eax,ebx
     b86:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
     b8a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     b8e:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     b91:	89 04 24             	mov    DWORD PTR [esp],eax
     b94:	e8 67 f4 ff ff       	call   0 <memcpy>
				f->seek_offset += rv;
     b99:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     b9c:	8b 48 04             	mov    ecx,DWORD PTR [eax+0x4]
     b9f:	8b 58 08             	mov    ebx,DWORD PTR [eax+0x8]
     ba2:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     ba5:	99                   	cdq
     ba6:	01 c8                	add    eax,ecx
     ba8:	11 da                	adc    edx,ebx
     baa:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
     bad:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
     bb0:	89 51 08             	mov    DWORD PTR [ecx+0x8],edx
		}
		if (rv > 0 && !(f->flags & O_NOATIME)) {/* set atime */
     bb3:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
     bb7:	7e 25                	jle    bde <memdev_read+0x154>
     bb9:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     bbc:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
     bbf:	25 00 00 04 00       	and    eax,0x40000
     bc4:	85 c0                	test   eax,eax
     bc6:	75 16                	jne    bde <memdev_read+0x154>
				clock_gettime(CLOCK_REALTIME, &in->in_stat.st_atim);
     bc8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     bcb:	83 c0 44             	add    eax,0x44
     bce:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     bd2:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     bd9:	e8 fc ff ff ff       	call   bda <memdev_read+0x150>
		}
		read_unlock(&in->in_lock);
     bde:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     be1:	83 c0 74             	add    eax,0x74
     be4:	89 04 24             	mov    DWORD PTR [esp],eax
     be7:	e8 fc ff ff ff       	call   be8 <memdev_read+0x15e>
		return rv;
     bec:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
}
     bef:	83 c4 2c             	add    esp,0x2c
     bf2:	5b                   	pop    ebx
     bf3:	5e                   	pop    esi
     bf4:	5f                   	pop    edi
     bf5:	5d                   	pop    ebp
     bf6:	c3                   	ret

00000bf7 <memdev_write>:

ssize_t memdev_write(struct inode* in, int fd, const void* buf, size_t noct)
{
     bf7:	55                   	push   ebp
     bf8:	89 e5                	mov    ebp,esp
     bfa:	57                   	push   edi
     bfb:	56                   	push   esi
     bfc:	53                   	push   ebx
     bfd:	83 ec 4c             	sub    esp,0x4c
		struct fil_fd* f; struct memdev_node* n; size_t s_ext = 0;
     c00:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
		if (!in || !buf || in->in_stat.st_dev != memdev_data->id) {
     c07:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     c0b:	74 28                	je     c35 <memdev_write+0x3e>
     c0d:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
     c11:	74 22                	je     c35 <memdev_write+0x3e>
     c13:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c16:	8b 08                	mov    ecx,DWORD PTR [eax]
     c18:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
     c1b:	a1 00 00 00 00       	mov    eax,ds:0x0
     c20:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     c23:	8b 00                	mov    eax,DWORD PTR [eax]
     c25:	89 cf                	mov    edi,ecx
     c27:	89 c6                	mov    esi,eax
     c29:	89 d9                	mov    ecx,ebx
     c2b:	89 f8                	mov    eax,edi
     c2d:	31 f0                	xor    eax,esi
     c2f:	31 ca                	xor    edx,ecx
     c31:	09 d0                	or     eax,edx
     c33:	74 14                	je     c49 <memdev_write+0x52>
				errno = EINVAL;
     c35:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
				return -1;
     c3f:	b8 ff ff ff ff       	mov    eax,0xffffffff
     c44:	e9 3c 03 00 00       	jmp    f85 <memdev_write+0x38e>
		}
		if (!(f = fil_fd_get(fd))) {
     c49:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     c4c:	89 04 24             	mov    DWORD PTR [esp],eax
     c4f:	e8 fc ff ff ff       	call   c50 <memdev_write+0x59>
     c54:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
     c57:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
     c5b:	75 14                	jne    c71 <memdev_write+0x7a>
				errno = EBADF;
     c5d:	c7 05 00 00 00 00 09 00 00 00 	mov    DWORD PTR ds:0x0,0x9
				return -1;
     c67:	b8 ff ff ff ff       	mov    eax,0xffffffff
     c6c:	e9 14 03 00 00       	jmp    f85 <memdev_write+0x38e>
		}

		/* acquire the lock */
		write_lock(&in->in_lock);
     c71:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c74:	83 c0 74             	add    eax,0x74
     c77:	89 04 24             	mov    DWORD PTR [esp],eax
     c7a:	e8 fc ff ff ff       	call   c7b <memdev_write+0x84>
		n = *(struct memdev_node**)in->in_pddat;
     c7f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c82:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
     c85:	8b 00                	mov    eax,DWORD PTR [eax]
     c87:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		if (f->flags & O_APPEND) /* atomic append */
     c8a:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     c8d:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
     c90:	25 00 04 00 00       	and    eax,0x400
     c95:	85 c0                	test   eax,eax
     c97:	74 17                	je     cb0 <memdev_write+0xb9>
				f->seek_offset = n->size - sizeof(struct memdev_node);
     c99:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     c9c:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     c9f:	83 e8 10             	sub    eax,0x10
     ca2:	ba 00 00 00 00       	mov    edx,0x0
     ca7:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
     caa:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
     cad:	89 51 08             	mov    DWORD PTR [ecx+0x8],edx
		if (f->seek_offset + noct > n->size) {
     cb0:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     cb3:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
     cb6:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     cb9:	8b 4d 14             	mov    ecx,DWORD PTR [ebp+0x14]
     cbc:	bb 00 00 00 00       	mov    ebx,0x0
     cc1:	01 c8                	add    eax,ecx
     cc3:	11 da                	adc    edx,ebx
     cc5:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
     cc8:	8b 49 04             	mov    ecx,DWORD PTR [ecx+0x4]
     ccb:	bb 00 00 00 00       	mov    ebx,0x0
     cd0:	39 c1                	cmp    ecx,eax
     cd2:	19 d3                	sbb    ebx,edx
     cd4:	0f 8d 0f 02 00 00    	jge    ee9 <memdev_write+0x2f2>
				/* we have to extend */
				s_ext = f->seek_offset + noct + sizeof(struct memdev_node);
     cda:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     cdd:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
     ce0:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     ce3:	89 c2                	mov    edx,eax
     ce5:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     ce8:	01 d0                	add    eax,edx
     cea:	83 c0 10             	add    eax,0x10
     ced:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
				if (s_ext > n->cap) { /* really */
     cf0:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     cf3:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     cf6:	3b 45 e0             	cmp    eax,DWORD PTR [ebp-0x20]
     cf9:	0f 83 91 01 00 00    	jae    e90 <memdev_write+0x299>
						size_t new_cap; void* mem;
						if (S_ISREG(in->in_stat.st_mode)) {
     cff:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     d02:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     d05:	25 00 f0 00 00       	and    eax,0xf000
     d0a:	3d 00 80 00 00       	cmp    eax,0x8000
     d0f:	0f 85 bf 00 00 00    	jne    dd4 <memdev_write+0x1dd>
								/* work on pages */
								new_cap = s_ext / 4096 + (s_ext % 4096 ? 1 : 0) * 4096;
     d15:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     d18:	c1 e8 0c             	shr    eax,0xc
     d1b:	89 c2                	mov    edx,eax
     d1d:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     d20:	25 ff 0f 00 00       	and    eax,0xfff
     d25:	85 c0                	test   eax,eax
     d27:	74 07                	je     d30 <memdev_write+0x139>
     d29:	b8 00 10 00 00       	mov    eax,0x1000
     d2e:	eb 05                	jmp    d35 <memdev_write+0x13e>
     d30:	b8 00 00 00 00       	mov    eax,0x0
     d35:	01 d0                	add    eax,edx
     d37:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
								mem = mm_extend_vmem(&mm_kernel, n, n->cap / 4096,
     d3a:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     d3d:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     d40:	c1 e8 0c             	shr    eax,0xc
     d43:	89 c2                	mov    edx,eax
     d45:	c7 44 24 10 0c 00 00 00 	mov    DWORD PTR [esp+0x10],0xc
     d4d:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     d50:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
     d54:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     d58:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     d5b:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     d5f:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     d66:	e8 fc ff ff ff       	call   d67 <memdev_write+0x170>
     d6b:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
												new_cap, MMGR_MAP_WRITE | MMGR_MAP_KERNEL);
								if (mem) {
     d6e:	83 7d d4 00          	cmp    DWORD PTR [ebp-0x2c],0x0
     d72:	74 2d                	je     da1 <memdev_write+0x1aa>
										n = (struct memdev_node*)mem;
     d74:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     d77:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
										*(struct memdev_node**)in->in_pddat = n;
     d7a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     d7d:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
     d80:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
     d83:	89 10                	mov    DWORD PTR [eax],edx
										n->cap = new_cap * 4096;
     d85:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     d88:	c1 e0 0c             	shl    eax,0xc
     d8b:	89 c2                	mov    edx,eax
     d8d:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     d90:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
										n->size = s_ext;
     d93:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     d96:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
     d99:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
     d9c:	e9 fb 00 00 00       	jmp    e9c <memdev_write+0x2a5>
								} else { /* write partially */
										noct = n->cap - n->size;
     da1:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     da4:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
     da7:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     daa:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     dad:	29 c2                	sub    edx,eax
     daf:	89 55 14             	mov    DWORD PTR [ebp+0x14],edx
										n->size = n->cap;
     db2:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     db5:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
     db8:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     dbb:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
										if (!noct)
     dbe:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     dc2:	0f 85 d4 00 00 00    	jne    e9c <memdev_write+0x2a5>
												noct = -1;
     dc8:	c7 45 14 ff ff ff ff 	mov    DWORD PTR [ebp+0x14],0xffffffff
     dcf:	e9 c8 00 00 00       	jmp    e9c <memdev_write+0x2a5>
								}
						} else if (S_ISDIR(in->in_stat.st_mode) || S_ISLNK(in->in_stat.st_mode)) {
     dd4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     dd7:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     dda:	25 00 f0 00 00       	and    eax,0xf000
     ddf:	3d 00 40 00 00       	cmp    eax,0x4000
     de4:	74 16                	je     dfc <memdev_write+0x205>
     de6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     de9:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     dec:	25 00 f0 00 00       	and    eax,0xf000
     df1:	3d 00 a0 00 00       	cmp    eax,0xa000
     df6:	0f 85 81 00 00 00    	jne    e7d <memdev_write+0x286>
								/* heap memory */
								new_cap = s_ext + 32; /* prevent many resizes */
     dfc:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     dff:	83 c0 20             	add    eax,0x20
     e02:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
								mem = h_realloc(memdev_data->heap, n, new_cap);
     e05:	a1 00 00 00 00       	mov    eax,ds:0x0
     e0a:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     e0d:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
     e10:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     e14:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
     e17:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     e1b:	89 04 24             	mov    DWORD PTR [esp],eax
     e1e:	e8 fc ff ff ff       	call   e1f <memdev_write+0x228>
     e23:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
								if (!mem) { /* write partially */
     e26:	83 7d d4 00          	cmp    DWORD PTR [ebp-0x2c],0x0
     e2a:	75 2c                	jne    e58 <memdev_write+0x261>
										noct = n->cap - n->size;
     e2c:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     e2f:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
     e32:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     e35:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     e38:	29 c2                	sub    edx,eax
     e3a:	89 55 14             	mov    DWORD PTR [ebp+0x14],edx
										n->size = n->cap;
     e3d:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     e40:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
     e43:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     e46:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
										if (!noct)
     e49:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     e4d:	75 4c                	jne    e9b <memdev_write+0x2a4>
												noct = -1;
     e4f:	c7 45 14 ff ff ff ff 	mov    DWORD PTR [ebp+0x14],0xffffffff
								if (!mem) { /* write partially */
     e56:	eb 43                	jmp    e9b <memdev_write+0x2a4>
								} else {
										n = (struct memdev_node*)mem;
     e58:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     e5b:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
										*(struct memdev_node**)in->in_pddat = n;
     e5e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     e61:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
     e64:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
     e67:	89 10                	mov    DWORD PTR [eax],edx
										n->cap = new_cap;
     e69:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     e6c:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
     e6f:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
										n->size = s_ext;
     e72:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     e75:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
     e78:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
								if (!mem) { /* write partially */
     e7b:	eb 1e                	jmp    e9b <memdev_write+0x2a4>
								}
						} else {
								/* wat do? */
								errno = ENOSYS;
     e7d:	c7 05 00 00 00 00 26 00 00 00 	mov    DWORD PTR ds:0x0,0x26
								noct = -1;
     e87:	c7 45 14 ff ff ff ff 	mov    DWORD PTR [ebp+0x14],0xffffffff
     e8e:	eb 0c                	jmp    e9c <memdev_write+0x2a5>
						}
				} else
						n->size = s_ext;
     e90:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     e93:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
     e96:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
     e99:	eb 01                	jmp    e9c <memdev_write+0x2a5>
								if (!mem) { /* write partially */
     e9b:	90                   	nop
				in->in_stat.st_size = n->size - sizeof(struct memdev_node);
     e9c:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     e9f:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     ea2:	83 e8 10             	sub    eax,0x10
     ea5:	ba 00 00 00 00       	mov    edx,0x0
     eaa:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
     ead:	89 41 2c             	mov    DWORD PTR [ecx+0x2c],eax
     eb0:	89 51 30             	mov    DWORD PTR [ecx+0x30],edx
				in->in_stat.st_size = n->cap / 512 + (n->cap % 512 ? 1 : 0);
     eb3:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     eb6:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     eb9:	c1 e8 09             	shr    eax,0x9
     ebc:	89 c2                	mov    edx,eax
     ebe:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     ec1:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     ec4:	25 ff 01 00 00       	and    eax,0x1ff
     ec9:	85 c0                	test   eax,eax
     ecb:	74 07                	je     ed4 <memdev_write+0x2dd>
     ecd:	b8 01 00 00 00       	mov    eax,0x1
     ed2:	eb 05                	jmp    ed9 <memdev_write+0x2e2>
     ed4:	b8 00 00 00 00       	mov    eax,0x0
     ed9:	01 d0                	add    eax,edx
     edb:	ba 00 00 00 00       	mov    edx,0x0
     ee0:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
     ee3:	89 41 2c             	mov    DWORD PTR [ecx+0x2c],eax
     ee6:	89 51 30             	mov    DWORD PTR [ecx+0x30],edx
		}
		/* now copy the data */
		memcpy(n->data + f->seek_offset, buf, noct);
     ee9:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     eec:	8d 48 10             	lea    ecx,[eax+0x10]
     eef:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     ef2:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
     ef5:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     ef8:	8d 14 01             	lea    edx,[ecx+eax*1]
     efb:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     efe:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     f02:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     f05:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     f09:	89 14 24             	mov    DWORD PTR [esp],edx
     f0c:	e8 ef f0 ff ff       	call   0 <memcpy>
		/* and update the times */
		if (noct > 0) {
     f11:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     f15:	74 5d                	je     f74 <memdev_write+0x37d>
				clock_gettime(CLOCK_REALTIME, &in->in_stat.st_mtim);
     f17:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     f1a:	83 c0 50             	add    eax,0x50
     f1d:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     f21:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     f28:	e8 fc ff ff ff       	call   f29 <memdev_write+0x332>
				in->in_stat.st_ctim = in->in_stat.st_mtim;
     f2d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     f30:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     f33:	8b 4a 50             	mov    ecx,DWORD PTR [edx+0x50]
     f36:	89 48 5c             	mov    DWORD PTR [eax+0x5c],ecx
     f39:	8b 4a 54             	mov    ecx,DWORD PTR [edx+0x54]
     f3c:	89 48 60             	mov    DWORD PTR [eax+0x60],ecx
     f3f:	8b 52 58             	mov    edx,DWORD PTR [edx+0x58]
     f42:	89 50 64             	mov    DWORD PTR [eax+0x64],edx
				f->seek_offset += noct; /* only forward (-1 for errno) */
     f45:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     f48:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
     f4b:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     f4e:	8b 4d 14             	mov    ecx,DWORD PTR [ebp+0x14]
     f51:	bb 00 00 00 00       	mov    ebx,0x0
     f56:	01 c8                	add    eax,ecx
     f58:	11 da                	adc    edx,ebx
     f5a:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
     f5d:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
     f60:	89 51 08             	mov    DWORD PTR [ecx+0x8],edx
				/* clear SUID,SGID */
				in->in_stat.st_mode &= (~(mode_t)S_ISUID) & (~(mode_t)S_ISGID);
     f63:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     f66:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     f69:	80 e4 f3             	and    ah,0xf3
     f6c:	89 c2                	mov    edx,eax
     f6e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     f71:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
		}
		write_unlock(&in->in_lock);
     f74:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     f77:	83 c0 74             	add    eax,0x74
     f7a:	89 04 24             	mov    DWORD PTR [esp],eax
     f7d:	e8 fc ff ff ff       	call   f7e <memdev_write+0x387>
		return noct;
     f82:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
}
     f85:	83 c4 4c             	add    esp,0x4c
     f88:	5b                   	pop    ebx
     f89:	5e                   	pop    esi
     f8a:	5f                   	pop    edi
     f8b:	5d                   	pop    ebp
     f8c:	c3                   	ret

00000f8d <memdev_close>:

int memdev_close(struct inode* in, int fd)
{
     f8d:	55                   	push   ebp
     f8e:	89 e5                	mov    ebp,esp
     f90:	83 ec 28             	sub    esp,0x28
		struct fil_fd* f;
		if (!in || !(f = fil_fd_get(fd))) {
     f93:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     f97:	74 14                	je     fad <memdev_close+0x20>
     f99:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     f9c:	89 04 24             	mov    DWORD PTR [esp],eax
     f9f:	e8 fc ff ff ff       	call   fa0 <memdev_close+0x13>
     fa4:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     fa7:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     fab:	75 21                	jne    fce <memdev_close+0x41>
				errno = in ? EBADF : EINVAL;
     fad:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     fb1:	74 07                	je     fba <memdev_close+0x2d>
     fb3:	b8 09 00 00 00       	mov    eax,0x9
     fb8:	eb 05                	jmp    fbf <memdev_close+0x32>
     fba:	b8 16 00 00 00       	mov    eax,0x16
     fbf:	a3 00 00 00 00       	mov    ds:0x0,eax
				return -1;
     fc4:	b8 ff ff ff ff       	mov    eax,0xffffffff
     fc9:	e9 b4 00 00 00       	jmp    1082 <memdev_close+0xf5>
		}
		/* TODO: file locks */
		fil_fd_free(fd);
     fce:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     fd1:	89 04 24             	mov    DWORD PTR [esp],eax
     fd4:	e8 fc ff ff ff       	call   fd5 <memdev_close+0x48>
		if (__sync_sub_and_fetch((int*)in->in_ddat, 1) == 0) {
     fd9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     fdc:	8d 50 68             	lea    edx,[eax+0x68]
     fdf:	b8 01 00 00 00       	mov    eax,0x1
     fe4:	f7 d8                	neg    eax
     fe6:	89 c1                	mov    ecx,eax
     fe8:	89 c8                	mov    eax,ecx
     fea:	f0 0f c1 02          	lock xadd DWORD PTR [edx],eax
     fee:	01 c8                	add    eax,ecx
     ff0:	85 c0                	test   eax,eax
     ff2:	0f 85 85 00 00 00    	jne    107d <memdev_close+0xf0>
				struct memdev_node* n;
				if (in->in_stat.st_nlink)
     ff8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     ffb:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
     ffe:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    1001:	89 c1                	mov    ecx,eax
    1003:	89 c8                	mov    eax,ecx
    1005:	09 d0                	or     eax,edx
    1007:	74 07                	je     1010 <memdev_close+0x83>
						return 0;
    1009:	b8 00 00 00 00       	mov    eax,0x0
    100e:	eb 72                	jmp    1082 <memdev_close+0xf5>
				/* nlink==0 && nref==0 */
				n = *(struct memdev_node**)in->in_pddat;
    1010:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1013:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
    1016:	8b 00                	mov    eax,DWORD PTR [eax]
    1018:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				*(struct memdev_node**)in->in_pddat = NULL; /* free slot */
    101b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    101e:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
    1021:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
				if (S_ISREG(in->in_stat.st_mode))
    1027:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    102a:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    102d:	25 00 f0 00 00       	and    eax,0xf000
    1032:	3d 00 80 00 00       	cmp    eax,0x8000
    1037:	75 22                	jne    105b <memdev_close+0xce>
						mm_free_vmem(&mm_kernel, n, n->cap / 4096);
    1039:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    103c:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    103f:	c1 e8 0c             	shr    eax,0xc
    1042:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1046:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1049:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    104d:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1054:	e8 fc ff ff ff       	call   1055 <memdev_close+0xc8>
    1059:	eb 17                	jmp    1072 <memdev_close+0xe5>
				else
						h_free(memdev_data->heap, n);
    105b:	a1 00 00 00 00       	mov    eax,ds:0x0
    1060:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    1063:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1066:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    106a:	89 04 24             	mov    DWORD PTR [esp],eax
    106d:	e8 fc ff ff ff       	call   106e <memdev_close+0xe1>
				ino_release(in);
    1072:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1075:	89 04 24             	mov    DWORD PTR [esp],eax
    1078:	e8 fc ff ff ff       	call   1079 <memdev_close+0xec>
		}
		return 0;
    107d:	b8 00 00 00 00       	mov    eax,0x0
}
    1082:	c9                   	leave
    1083:	c3                   	ret

00001084 <memdev_lseek>:

off_t memdev_lseek(struct inode* in, int fd, off_t offset, int ref)
{
    1084:	55                   	push   ebp
    1085:	89 e5                	mov    ebp,esp
    1087:	57                   	push   edi
    1088:	56                   	push   esi
    1089:	53                   	push   ebx
    108a:	83 ec 20             	sub    esp,0x20
    108d:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1090:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    1093:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1096:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		struct fil_fd* f;
		if (!in || in->in_stat.st_dev != memdev_data->id) {
    1099:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    109d:	74 22                	je     10c1 <memdev_lseek+0x3d>
    109f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    10a2:	8b 08                	mov    ecx,DWORD PTR [eax]
    10a4:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    10a7:	a1 00 00 00 00       	mov    eax,ds:0x0
    10ac:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    10af:	8b 00                	mov    eax,DWORD PTR [eax]
    10b1:	89 cf                	mov    edi,ecx
    10b3:	89 c6                	mov    esi,eax
    10b5:	89 d9                	mov    ecx,ebx
    10b7:	89 f8                	mov    eax,edi
    10b9:	31 f0                	xor    eax,esi
    10bb:	31 ca                	xor    edx,ecx
    10bd:	09 d0                	or     eax,edx
    10bf:	74 19                	je     10da <memdev_lseek+0x56>
				errno = EINVAL;
    10c1:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
				return -1;
    10cb:	b8 ff ff ff ff       	mov    eax,0xffffffff
    10d0:	ba ff ff ff ff       	mov    edx,0xffffffff
    10d5:	e9 a8 00 00 00       	jmp    1182 <memdev_lseek+0xfe>
		}
		if (!(f = fil_fd_get(fd))) {
    10da:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    10dd:	89 04 24             	mov    DWORD PTR [esp],eax
    10e0:	e8 fc ff ff ff       	call   10e1 <memdev_lseek+0x5d>
    10e5:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    10e8:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    10ec:	75 16                	jne    1104 <memdev_lseek+0x80>
				errno = EBADF;
    10ee:	c7 05 00 00 00 00 09 00 00 00 	mov    DWORD PTR ds:0x0,0x9
				return -1;
    10f8:	b8 ff ff ff ff       	mov    eax,0xffffffff
    10fd:	ba ff ff ff ff       	mov    edx,0xffffffff
    1102:	eb 7e                	jmp    1182 <memdev_lseek+0xfe>
		}
		/* not thread-safe as sharing FDs is not thread-safe */
		if (ref == SEEK_SET)
    1104:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
    1108:	75 11                	jne    111b <memdev_lseek+0x97>
				f->seek_offset = offset;
    110a:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
    110d:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1110:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1113:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
    1116:	89 51 08             	mov    DWORD PTR [ecx+0x8],edx
    1119:	eb 5e                	jmp    1179 <memdev_lseek+0xf5>
		else if (ref == SEEK_CUR)
    111b:	83 7d 18 01          	cmp    DWORD PTR [ebp+0x18],0x1
    111f:	75 1e                	jne    113f <memdev_lseek+0xbb>
				f->seek_offset += offset;
    1121:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1124:	8b 48 04             	mov    ecx,DWORD PTR [eax+0x4]
    1127:	8b 58 08             	mov    ebx,DWORD PTR [eax+0x8]
    112a:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    112d:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1130:	01 c8                	add    eax,ecx
    1132:	11 da                	adc    edx,ebx
    1134:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
    1137:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
    113a:	89 51 08             	mov    DWORD PTR [ecx+0x8],edx
    113d:	eb 3a                	jmp    1179 <memdev_lseek+0xf5>
		else if (ref == SEEK_END) {
    113f:	83 7d 18 02          	cmp    DWORD PTR [ebp+0x18],0x2
    1143:	75 1e                	jne    1163 <memdev_lseek+0xdf>
				f->seek_offset = in->in_stat.st_size + offset;
    1145:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1148:	8b 48 2c             	mov    ecx,DWORD PTR [eax+0x2c]
    114b:	8b 58 30             	mov    ebx,DWORD PTR [eax+0x30]
    114e:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1151:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1154:	01 c8                	add    eax,ecx
    1156:	11 da                	adc    edx,ebx
    1158:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
    115b:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
    115e:	89 51 08             	mov    DWORD PTR [ecx+0x8],edx
    1161:	eb 16                	jmp    1179 <memdev_lseek+0xf5>
		} else {
				errno = EINVAL;
    1163:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
				return -1;
    116d:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1172:	ba ff ff ff ff       	mov    edx,0xffffffff
    1177:	eb 09                	jmp    1182 <memdev_lseek+0xfe>
		}
		return f->seek_offset;
    1179:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    117c:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    117f:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
}
    1182:	83 c4 20             	add    esp,0x20
    1185:	5b                   	pop    ebx
    1186:	5e                   	pop    esi
    1187:	5f                   	pop    edi
    1188:	5d                   	pop    ebp
    1189:	c3                   	ret

0000118a <memdev_truncate>:

int memdev_truncate(struct inode* in, off_t length)
{
    118a:	55                   	push   ebp
    118b:	89 e5                	mov    ebp,esp
    118d:	57                   	push   edi
    118e:	56                   	push   esi
    118f:	53                   	push   ebx
    1190:	83 ec 5c             	sub    esp,0x5c
    1193:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1196:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
    1199:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    119c:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
		struct memdev_node* n; off_t len;
		if (!in || in->in_stat.st_dev != memdev_data->id) {
    119f:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    11a3:	74 22                	je     11c7 <memdev_truncate+0x3d>
    11a5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    11a8:	8b 08                	mov    ecx,DWORD PTR [eax]
    11aa:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    11ad:	a1 00 00 00 00       	mov    eax,ds:0x0
    11b2:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    11b5:	8b 00                	mov    eax,DWORD PTR [eax]
    11b7:	89 cf                	mov    edi,ecx
    11b9:	89 c6                	mov    esi,eax
    11bb:	89 d9                	mov    ecx,ebx
    11bd:	89 f8                	mov    eax,edi
    11bf:	31 f0                	xor    eax,esi
    11c1:	31 ca                	xor    edx,ecx
    11c3:	09 d0                	or     eax,edx
    11c5:	74 14                	je     11db <memdev_truncate+0x51>
				errno = EINVAL;
    11c7:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
				return -1;
    11d1:	b8 ff ff ff ff       	mov    eax,0xffffffff
    11d6:	e9 30 02 00 00       	jmp    140b <memdev_truncate+0x281>
		}

		/* only work on regular files (i.e. memory pages) */
		if (!S_ISREG(in->in_stat.st_mode)) {
    11db:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    11de:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    11e1:	25 00 f0 00 00       	and    eax,0xf000
    11e6:	3d 00 80 00 00       	cmp    eax,0x8000
    11eb:	74 14                	je     1201 <memdev_truncate+0x77>
				errno = EINVAL;
    11ed:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
				return -1;
    11f7:	b8 ff ff ff ff       	mov    eax,0xffffffff
    11fc:	e9 0a 02 00 00       	jmp    140b <memdev_truncate+0x281>
		}

		/* modify the file */
		write_lock(&in->in_lock);
    1201:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1204:	83 c0 74             	add    eax,0x74
    1207:	89 04 24             	mov    DWORD PTR [esp],eax
    120a:	e8 fc ff ff ff       	call   120b <memdev_truncate+0x81>
		n = *(struct memdev_node**)in->in_pddat;
    120f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1212:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
    1215:	8b 00                	mov    eax,DWORD PTR [eax]
    1217:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		len = n->size - sizeof(struct memdev_node);
    121a:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    121d:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1220:	83 e8 10             	sub    eax,0x10
    1223:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    1226:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
		if (len > length) { /* shrink */
    122d:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1230:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1233:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
    1236:	39 45 c0             	cmp    DWORD PTR [ebp-0x40],eax
    1239:	19 d1                	sbb    ecx,edx
    123b:	7d 5b                	jge    1298 <memdev_truncate+0x10e>
				size_t num_p;
				n->size = length + sizeof(struct memdev_node);
    123d:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    1240:	8d 50 10             	lea    edx,[eax+0x10]
    1243:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1246:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
				num_p = (n->cap - n->size) / 4096;
    1249:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    124c:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    124f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1252:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1255:	29 c2                	sub    edx,eax
    1257:	89 d0                	mov    eax,edx
    1259:	c1 e8 0c             	shr    eax,0xc
    125c:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
				if (num_p)
    125f:	83 7d cc 00          	cmp    DWORD PTR [ebp-0x34],0x0
    1263:	0f 84 2a 01 00 00    	je     1393 <memdev_truncate+0x209>
						mm_free_vmem(&mm_kernel, (char*)n + n->cap - num_p * 4096, num_p);
    1269:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    126c:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    126f:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1272:	c1 e0 0c             	shl    eax,0xc
    1275:	29 c2                	sub    edx,eax
    1277:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    127a:	01 c2                	add    edx,eax
    127c:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    127f:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1283:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1287:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    128e:	e8 fc ff ff ff       	call   128f <memdev_truncate+0x105>
    1293:	e9 fb 00 00 00       	jmp    1393 <memdev_truncate+0x209>
		} else if (len < length) { /* grow */
    1298:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    129b:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    129e:	3b 45 c0             	cmp    eax,DWORD PTR [ebp-0x40]
    12a1:	89 d0                	mov    eax,edx
    12a3:	1b 45 c4             	sbb    eax,DWORD PTR [ebp-0x3c]
    12a6:	0f 8d e7 00 00 00    	jge    1393 <memdev_truncate+0x209>
				if ((n->cap - n->size) >= (length - len))
    12ac:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    12af:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    12b2:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    12b5:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    12b8:	29 c2                	sub    edx,eax
    12ba:	89 d1                	mov    ecx,edx
    12bc:	bb 00 00 00 00       	mov    ebx,0x0
    12c1:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    12c4:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    12c7:	2b 45 d8             	sub    eax,DWORD PTR [ebp-0x28]
    12ca:	1b 55 dc             	sbb    edx,DWORD PTR [ebp-0x24]
    12cd:	39 c1                	cmp    ecx,eax
    12cf:	19 d3                	sbb    ebx,edx
    12d1:	7c 11                	jl     12e4 <memdev_truncate+0x15a>
						n->size = length + sizeof(struct memdev_node);
    12d3:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    12d6:	8d 50 10             	lea    edx,[eax+0x10]
    12d9:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    12dc:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
    12df:	e9 af 00 00 00       	jmp    1393 <memdev_truncate+0x209>
				else { /* allocate new pages */
						size_t num_p; void* mem;
						num_p = n->size + (length - len);
    12e4:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    12e7:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    12ea:	8b 4d c0             	mov    ecx,DWORD PTR [ebp-0x40]
    12ed:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    12f0:	29 c1                	sub    ecx,eax
    12f2:	8d 04 0a             	lea    eax,[edx+ecx*1]
    12f5:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
						num_p = num_p / 4096 + ((num_p % 4096) ? 1 : 0);
    12f8:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    12fb:	c1 e8 0c             	shr    eax,0xc
    12fe:	89 c2                	mov    edx,eax
    1300:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1303:	25 ff 0f 00 00       	and    eax,0xfff
    1308:	85 c0                	test   eax,eax
    130a:	74 07                	je     1313 <memdev_truncate+0x189>
    130c:	b8 01 00 00 00       	mov    eax,0x1
    1311:	eb 05                	jmp    1318 <memdev_truncate+0x18e>
    1313:	b8 00 00 00 00       	mov    eax,0x0
    1318:	01 d0                	add    eax,edx
    131a:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
						mem = mm_extend_vmem(&mm_kernel, n, n->cap / 4096, num_p,
    131d:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1320:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1323:	c1 e8 0c             	shr    eax,0xc
    1326:	89 c2                	mov    edx,eax
    1328:	c7 44 24 10 0c 00 00 00 	mov    DWORD PTR [esp+0x10],0xc
    1330:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1333:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    1337:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    133b:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    133e:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1342:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1349:	e8 fc ff ff ff       	call   134a <memdev_truncate+0x1c0>
    134e:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
										MMGR_MAP_WRITE | MMGR_MAP_KERNEL);
						/* everything above size is still scrubbed -> no bzero */
						if (!mem) {
    1351:	83 7d d0 00          	cmp    DWORD PTR [ebp-0x30],0x0
    1355:	75 22                	jne    1379 <memdev_truncate+0x1ef>
								/* failed to extend */
								errno = EFBIG;
    1357:	c7 05 00 00 00 00 1b 00 00 00 	mov    DWORD PTR ds:0x0,0x1b
								write_unlock(&in->in_lock);
    1361:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1364:	83 c0 74             	add    eax,0x74
    1367:	89 04 24             	mov    DWORD PTR [esp],eax
    136a:	e8 fc ff ff ff       	call   136b <memdev_truncate+0x1e1>
								return -1;
    136f:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1374:	e9 92 00 00 00       	jmp    140b <memdev_truncate+0x281>
						}
						n->cap = num_p * 4096;
    1379:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    137c:	c1 e0 0c             	shl    eax,0xc
    137f:	89 c2                	mov    edx,eax
    1381:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1384:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
						n->size = length + sizeof(struct memdev_node);
    1387:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    138a:	8d 50 10             	lea    edx,[eax+0x10]
    138d:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1390:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
				}
		} else { } /* do nothing */

		/* clear SUID,SGID */
		in->in_stat.st_mode &= (~(mode_t)S_ISUID) & (~(mode_t)S_ISGID);
    1393:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1396:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1399:	80 e4 f3             	and    ah,0xf3
    139c:	89 c2                	mov    edx,eax
    139e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    13a1:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
		in->in_stat.st_size = length;
    13a4:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    13a7:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    13aa:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    13ad:	89 41 2c             	mov    DWORD PTR [ecx+0x2c],eax
    13b0:	89 51 30             	mov    DWORD PTR [ecx+0x30],edx
		in->in_stat.st_blocks = n->cap / 512;
    13b3:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    13b6:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    13b9:	c1 e8 09             	shr    eax,0x9
    13bc:	ba 00 00 00 00       	mov    edx,0x0
    13c1:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    13c4:	89 41 3c             	mov    DWORD PTR [ecx+0x3c],eax
    13c7:	89 51 40             	mov    DWORD PTR [ecx+0x40],edx
		/* always update c&mtim (as in ftruncate) */
		clock_gettime(CLOCK_REALTIME, &in->in_stat.st_mtim);
    13ca:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    13cd:	83 c0 50             	add    eax,0x50
    13d0:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    13d4:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    13db:	e8 fc ff ff ff       	call   13dc <memdev_truncate+0x252>
		in->in_stat.st_ctim = in->in_stat.st_mtim;
    13e0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    13e3:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    13e6:	8b 4a 50             	mov    ecx,DWORD PTR [edx+0x50]
    13e9:	89 48 5c             	mov    DWORD PTR [eax+0x5c],ecx
    13ec:	8b 4a 54             	mov    ecx,DWORD PTR [edx+0x54]
    13ef:	89 48 60             	mov    DWORD PTR [eax+0x60],ecx
    13f2:	8b 52 58             	mov    edx,DWORD PTR [edx+0x58]
    13f5:	89 50 64             	mov    DWORD PTR [eax+0x64],edx
		write_unlock(&in->in_lock);
    13f8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    13fb:	83 c0 74             	add    eax,0x74
    13fe:	89 04 24             	mov    DWORD PTR [esp],eax
    1401:	e8 fc ff ff ff       	call   1402 <memdev_truncate+0x278>
		return 0;
    1406:	b8 00 00 00 00       	mov    eax,0x0
}
    140b:	83 c4 5c             	add    esp,0x5c
    140e:	5b                   	pop    ebx
    140f:	5e                   	pop    esi
    1410:	5f                   	pop    edi
    1411:	5d                   	pop    ebp
    1412:	c3                   	ret

00001413 <memdev_search_fn>:

char* memdev_search_fn(struct memdev_node* n, const char* fn)
{
    1413:	55                   	push   ebp
    1414:	89 e5                	mov    ebp,esp
    1416:	83 ec 28             	sub    esp,0x28
		char *str, *end;
		str = n->data;
    1419:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    141c:	83 c0 10             	add    eax,0x10
    141f:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		end = (char*)n + n->size;
    1422:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1425:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1428:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    142b:	01 d0                	add    eax,edx
    142d:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		while (str < end) {
    1430:	eb 2c                	jmp    145e <memdev_search_fn+0x4b>
				if (strcmp(str, fn) == 0) {
    1432:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1435:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1439:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    143c:	89 04 24             	mov    DWORD PTR [esp],eax
    143f:	e8 fc ff ff ff       	call   1440 <memdev_search_fn+0x2d>
    1444:	85 c0                	test   eax,eax
    1446:	75 05                	jne    144d <memdev_search_fn+0x3a>
						return str;
    1448:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    144b:	eb 1e                	jmp    146b <memdev_search_fn+0x58>
				}
				str += strlen(str) + sizeof(void*) + 1;
    144d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1450:	89 04 24             	mov    DWORD PTR [esp],eax
    1453:	e8 fc ff ff ff       	call   1454 <memdev_search_fn+0x41>
    1458:	83 c0 05             	add    eax,0x5
    145b:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
		while (str < end) {
    145e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1461:	3b 45 f0             	cmp    eax,DWORD PTR [ebp-0x10]
    1464:	72 cc                	jb     1432 <memdev_search_fn+0x1f>
		}
		return NULL;
    1466:	b8 00 00 00 00       	mov    eax,0x0
}
    146b:	c9                   	leave
    146c:	c3                   	ret

0000146d <memdev_get_subnode>:

struct inode* memdev_get_subnode(struct inode* in, const char* fn)
{
    146d:	55                   	push   ebp
    146e:	89 e5                	mov    ebp,esp
    1470:	83 ec 38             	sub    esp,0x38
		struct inode* rv = NULL;
    1473:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		if (!fn || (!in && strlen(fn) > 0)) {
    147a:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
    147e:	74 15                	je     1495 <memdev_get_subnode+0x28>
    1480:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    1484:	75 23                	jne    14a9 <memdev_get_subnode+0x3c>
    1486:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1489:	89 04 24             	mov    DWORD PTR [esp],eax
    148c:	e8 fc ff ff ff       	call   148d <memdev_get_subnode+0x20>
    1491:	85 c0                	test   eax,eax
    1493:	74 14                	je     14a9 <memdev_get_subnode+0x3c>
				errno = EINVAL;
    1495:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
				return NULL;
    149f:	b8 00 00 00 00       	mov    eax,0x0
    14a4:	e9 16 02 00 00       	jmp    16bf <memdev_get_subnode+0x252>
		}

		if (in) {
    14a9:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    14ad:	0f 84 bd 00 00 00    	je     1570 <memdev_get_subnode+0x103>
				struct memdev_node* n; char *str;
				/* we don't handle links here. The OS should only ask
				 * for files we actually have stored on this device */
				if (in->in_stat.st_dev != 0) {
    14b3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    14b6:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    14b9:	8b 00                	mov    eax,DWORD PTR [eax]
    14bb:	89 c1                	mov    ecx,eax
    14bd:	89 c8                	mov    eax,ecx
    14bf:	09 d0                	or     eax,edx
    14c1:	74 14                	je     14d7 <memdev_get_subnode+0x6a>
						errno = EINVAL;
    14c3:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
						return NULL;
    14cd:	b8 00 00 00 00       	mov    eax,0x0
    14d2:	e9 e8 01 00 00       	jmp    16bf <memdev_get_subnode+0x252>
				}
				/* check for directory */
				if (!S_ISDIR(in->in_stat.st_mode)) {
    14d7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    14da:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    14dd:	25 00 f0 00 00       	and    eax,0xf000
    14e2:	3d 00 40 00 00       	cmp    eax,0x4000
    14e7:	74 14                	je     14fd <memdev_get_subnode+0x90>
						errno = ENOTDIR;
    14e9:	c7 05 00 00 00 00 14 00 00 00 	mov    DWORD PTR ds:0x0,0x14
						return NULL;
    14f3:	b8 00 00 00 00       	mov    eax,0x0
    14f8:	e9 c2 01 00 00       	jmp    16bf <memdev_get_subnode+0x252>
				}

				/* now search for fn with read lock */
				n = *(struct memdev_node**)in->in_pddat;
    14fd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1500:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
    1503:	8b 00                	mov    eax,DWORD PTR [eax]
    1505:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				read_lock(&in->in_lock);
    1508:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    150b:	83 c0 74             	add    eax,0x74
    150e:	89 04 24             	mov    DWORD PTR [esp],eax
    1511:	e8 fc ff ff ff       	call   1512 <memdev_get_subnode+0xa5>
				str = memdev_search_fn(n, fn);
    1516:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1519:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    151d:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1520:	89 04 24             	mov    DWORD PTR [esp],eax
    1523:	e8 fc ff ff ff       	call   1524 <memdev_get_subnode+0xb7>
    1528:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				if (str) {
    152b:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    152f:	74 19                	je     154a <memdev_get_subnode+0xdd>
						str += strlen(str) + 1;
    1531:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1534:	89 04 24             	mov    DWORD PTR [esp],eax
    1537:	e8 fc ff ff ff       	call   1538 <memdev_get_subnode+0xcb>
    153c:	83 c0 01             	add    eax,0x1
    153f:	01 45 e4             	add    DWORD PTR [ebp-0x1c],eax
						rv = *(void**)str;
    1542:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1545:	8b 00                	mov    eax,DWORD PTR [eax]
    1547:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				}
				/* update access time <- NO only if opening the dir */
				/*clock_gettime(CLOCK_REALTIME, &in->in_stat.st_atim);*/
				read_unlock(&in->in_lock);
    154a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    154d:	83 c0 74             	add    eax,0x74
    1550:	89 04 24             	mov    DWORD PTR [esp],eax
    1553:	e8 fc ff ff ff       	call   1554 <memdev_get_subnode+0xe7>
				if (!rv)
    1558:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    155c:	75 0a                	jne    1568 <memdev_get_subnode+0xfb>
						errno = ENOENT;
    155e:	c7 05 00 00 00 00 02 00 00 00 	mov    DWORD PTR ds:0x0,0x2
				return rv;
    1568:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    156b:	e9 4f 01 00 00       	jmp    16bf <memdev_get_subnode+0x252>
		}

		/* return root node */
		if (memdev_data->node_ct == 0) {
    1570:	a1 00 00 00 00       	mov    eax,ds:0x0
    1575:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1578:	85 c0                	test   eax,eax
    157a:	0f 85 32 01 00 00    	jne    16b2 <memdev_get_subnode+0x245>
				/* create root directory first */
				void* mem = h_malloc(memdev_data->heap, 128 + sizeof(struct memdev_node));
    1580:	a1 00 00 00 00       	mov    eax,ds:0x0
    1585:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    1588:	c7 44 24 04 90 00 00 00 	mov    DWORD PTR [esp+0x4],0x90
    1590:	89 04 24             	mov    DWORD PTR [esp],eax
    1593:	e8 fc ff ff ff       	call   1594 <memdev_get_subnode+0x127>
    1598:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				struct memdev_node* n = (struct memdev_node*)mem;
    159b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    159e:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				if (!mem)
    15a1:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    15a5:	75 0a                	jne    15b1 <memdev_get_subnode+0x144>
						return NULL;
    15a7:	b8 00 00 00 00       	mov    eax,0x0
    15ac:	e9 0e 01 00 00       	jmp    16bf <memdev_get_subnode+0x252>
				n->cap = 128 + sizeof(struct memdev_node);
    15b1:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    15b4:	c7 40 08 90 00 00 00 	mov    DWORD PTR [eax+0x8],0x90
				n->size = sizeof(struct memdev_node);
    15bb:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    15be:	c7 40 04 10 00 00 00 	mov    DWORD PTR [eax+0x4],0x10
				n->file = S_IFDIR;
    15c5:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    15c8:	c7 00 00 40 00 00    	mov    DWORD PTR [eax],0x4000
				rv = n->ino = ino_allocate(S_IFDIR);
    15ce:	c7 04 24 00 40 00 00 	mov    DWORD PTR [esp],0x4000
    15d5:	e8 fc ff ff ff       	call   15d6 <memdev_get_subnode+0x169>
    15da:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    15dd:	89 42 0c             	mov    DWORD PTR [edx+0xc],eax
    15e0:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    15e3:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    15e6:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				if (!rv) {
    15e9:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    15ed:	75 21                	jne    1610 <memdev_get_subnode+0x1a3>
						h_free(memdev_data->heap, mem);
    15ef:	a1 00 00 00 00       	mov    eax,ds:0x0
    15f4:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    15f7:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    15fa:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    15fe:	89 04 24             	mov    DWORD PTR [esp],eax
    1601:	e8 fc ff ff ff       	call   1602 <memdev_get_subnode+0x195>
						return NULL;
    1606:	b8 00 00 00 00       	mov    eax,0x0
    160b:	e9 af 00 00 00       	jmp    16bf <memdev_get_subnode+0x252>
				}
				rv->in_stat.st_dev = memdev_data->id;
    1610:	a1 00 00 00 00       	mov    eax,ds:0x0
    1615:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1618:	8b 00                	mov    eax,DWORD PTR [eax]
    161a:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    161d:	89 01                	mov    DWORD PTR [ecx],eax
    161f:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
				rv->in_stat.st_blksize = 4096; /* 4096/512 */
    1622:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1625:	c7 40 34 00 10 00 00 	mov    DWORD PTR [eax+0x34],0x1000
    162c:	c7 40 38 00 00 00 00 	mov    DWORD PTR [eax+0x38],0x0
				rv->in_stat.st_blocks = 8;
    1633:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1636:	c7 40 3c 08 00 00 00 	mov    DWORD PTR [eax+0x3c],0x8
    163d:	c7 40 40 00 00 00 00 	mov    DWORD PTR [eax+0x40],0x0
				rv->in_stat.st_size = 0; /* actual size */
    1644:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1647:	c7 40 2c 00 00 00 00 	mov    DWORD PTR [eax+0x2c],0x0
    164e:	c7 40 30 00 00 00 00 	mov    DWORD PTR [eax+0x30],0x0
				rv->in_pddat = memdev_store_node(n);
    1655:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1658:	89 04 24             	mov    DWORD PTR [esp],eax
    165b:	e8 fc ff ff ff       	call   165c <memdev_get_subnode+0x1ef>
    1660:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1663:	89 42 70             	mov    DWORD PTR [edx+0x70],eax
				if (!rv->in_pddat) {
    1666:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1669:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
    166c:	85 c0                	test   eax,eax
    166e:	75 2c                	jne    169c <memdev_get_subnode+0x22f>
						ino_release(n->ino);
    1670:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1673:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1676:	89 04 24             	mov    DWORD PTR [esp],eax
    1679:	e8 fc ff ff ff       	call   167a <memdev_get_subnode+0x20d>
						h_free(memdev_data->heap, mem);
    167e:	a1 00 00 00 00       	mov    eax,ds:0x0
    1683:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    1686:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1689:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    168d:	89 04 24             	mov    DWORD PTR [esp],eax
    1690:	e8 fc ff ff ff       	call   1691 <memdev_get_subnode+0x224>
						return NULL;
    1695:	b8 00 00 00 00       	mov    eax,0x0
    169a:	eb 23                	jmp    16bf <memdev_get_subnode+0x252>
				}
				rv->in_stat.st_nlink = 1; /* NEVER free / on close() */
    169c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    169f:	c7 40 14 01 00 00 00 	mov    DWORD PTR [eax+0x14],0x1
    16a6:	c7 40 18 00 00 00 00 	mov    DWORD PTR [eax+0x18],0x0
				return rv;
    16ad:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    16b0:	eb 0d                	jmp    16bf <memdev_get_subnode+0x252>
		} else
				return memdev_data->nodes[0]->ino;
    16b2:	a1 00 00 00 00       	mov    eax,ds:0x0
    16b7:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    16ba:	8b 00                	mov    eax,DWORD PTR [eax]
    16bc:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
}
    16bf:	c9                   	leave
    16c0:	c3                   	ret

000016c1 <memdev_unlink>:

int memdev_unlink(struct inode* in0, struct inode* in1)
{
    16c1:	55                   	push   ebp
    16c2:	89 e5                	mov    ebp,esp
    16c4:	57                   	push   edi
    16c5:	56                   	push   esi
    16c6:	53                   	push   ebx
    16c7:	83 ec 4c             	sub    esp,0x4c
		struct timespec t;
		if (!in1 || (in0 && in0->in_stat.st_dev != memdev_data->id)) {
    16ca:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
    16ce:	74 28                	je     16f8 <memdev_unlink+0x37>
    16d0:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    16d4:	74 36                	je     170c <memdev_unlink+0x4b>
    16d6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    16d9:	8b 08                	mov    ecx,DWORD PTR [eax]
    16db:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    16de:	a1 00 00 00 00       	mov    eax,ds:0x0
    16e3:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    16e6:	8b 00                	mov    eax,DWORD PTR [eax]
    16e8:	89 cf                	mov    edi,ecx
    16ea:	89 c6                	mov    esi,eax
    16ec:	89 d9                	mov    ecx,ebx
    16ee:	89 f8                	mov    eax,edi
    16f0:	31 f0                	xor    eax,esi
    16f2:	31 ca                	xor    edx,ecx
    16f4:	09 d0                	or     eax,edx
    16f6:	74 14                	je     170c <memdev_unlink+0x4b>
				errno = EINVAL;
    16f8:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
				return -1;
    1702:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1707:	e9 b6 03 00 00       	jmp    1ac2 <memdev_unlink+0x401>
		}

		if (in0) { /* remove link from source dir(!)  */
    170c:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    1710:	0f 84 a3 01 00 00    	je     18b9 <memdev_unlink+0x1f8>
				struct memdev_node* n; char* fn;
				if (!(in0->in_stat.st_mode & S_IFDIR)) {
    1716:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1719:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    171c:	25 00 40 00 00       	and    eax,0x4000
    1721:	85 c0                	test   eax,eax
    1723:	75 14                	jne    1739 <memdev_unlink+0x78>
						errno = ENOTDIR;
    1725:	c7 05 00 00 00 00 14 00 00 00 	mov    DWORD PTR ds:0x0,0x14
						return -1;
    172f:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1734:	e9 89 03 00 00       	jmp    1ac2 <memdev_unlink+0x401>
				}

				n = *(struct memdev_node**)in0->in_pddat;
    1739:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    173c:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
    173f:	8b 00                	mov    eax,DWORD PTR [eax]
    1741:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				/* now modify the directory */
				write_lock(&in0->in_lock);
    1744:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1747:	83 c0 74             	add    eax,0x74
    174a:	89 04 24             	mov    DWORD PTR [esp],eax
    174d:	e8 fc ff ff ff       	call   174e <memdev_unlink+0x8d>
				fn = n->data;
    1752:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1755:	83 c0 10             	add    eax,0x10
    1758:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
				while (fn < (char*)n + n->size) {
    175b:	e9 1d 01 00 00       	jmp    187d <memdev_unlink+0x1bc>
						char* fn2 = fn + strlen(fn) + 1;
    1760:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1763:	89 04 24             	mov    DWORD PTR [esp],eax
    1766:	e8 fc ff ff ff       	call   1767 <memdev_unlink+0xa6>
    176b:	8d 50 01             	lea    edx,[eax+0x1]
    176e:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1771:	01 d0                	add    eax,edx
    1773:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
						if (*(struct inode**)fn2 == in1) {
    1776:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1779:	8b 00                	mov    eax,DWORD PTR [eax]
    177b:	39 45 0c             	cmp    DWORD PTR [ebp+0xc],eax
    177e:	0f 85 f0 00 00 00    	jne    1874 <memdev_unlink+0x1b3>
								/* found the entry */
								fn2 += sizeof(struct inode*);
    1784:	83 45 dc 04          	add    DWORD PTR [ebp-0x24],0x4
								memmove(fn, fn2, (char*)n + n->size - fn2);
    1788:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    178b:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    178e:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1791:	01 d0                	add    eax,edx
    1793:	2b 45 dc             	sub    eax,DWORD PTR [ebp-0x24]
    1796:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    179a:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    179d:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    17a1:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    17a4:	89 04 24             	mov    DWORD PTR [esp],eax
    17a7:	e8 fc ff ff ff       	call   17a8 <memdev_unlink+0xe7>
								n->size -= fn2 - fn;
    17ac:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    17af:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    17b2:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    17b5:	2b 45 e0             	sub    eax,DWORD PTR [ebp-0x20]
    17b8:	29 c2                	sub    edx,eax
    17ba:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    17bd:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
								if (n->size > 128 + sizeof(struct memdev_node)) {
    17c0:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    17c3:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    17c6:	3d 90 00 00 00       	cmp    eax,0x90
    17cb:	76 51                	jbe    181e <memdev_unlink+0x15d>
										/* shrink a bit */
										if (n->cap - n->size > 64) {
    17cd:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    17d0:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    17d3:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    17d6:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    17d9:	29 c2                	sub    edx,eax
    17db:	83 fa 40             	cmp    edx,0x40
    17de:	76 3e                	jbe    181e <memdev_unlink+0x15d>
												n->cap = n->size + 64;
    17e0:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    17e3:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    17e6:	8d 50 40             	lea    edx,[eax+0x40]
    17e9:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    17ec:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
												*(struct memdev_node**)in0->in_pddat
													   	= n = h_realloc(memdev_data->heap,
    17ef:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    17f2:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    17f5:	a1 00 00 00 00       	mov    eax,ds:0x0
    17fa:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    17fd:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    1801:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    1804:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1808:	89 04 24             	mov    DWORD PTR [esp],eax
    180b:	e8 fc ff ff ff       	call   180c <memdev_unlink+0x14b>
    1810:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
												*(struct memdev_node**)in0->in_pddat
    1813:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1816:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
													   	= n = h_realloc(memdev_data->heap,
    1819:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    181c:	89 10                	mov    DWORD PTR [eax],edx
																		n, n->cap);
												/* will never happen as shrink works in-place */
										}
								}
								n = NULL; /* signify found */
    181e:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
								in0->in_stat.st_size = n->size - sizeof(struct memdev_node);
    1825:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1828:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    182b:	83 e8 10             	sub    eax,0x10
    182e:	ba 00 00 00 00       	mov    edx,0x0
    1833:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    1836:	89 41 2c             	mov    DWORD PTR [ecx+0x2c],eax
    1839:	89 51 30             	mov    DWORD PTR [ecx+0x30],edx
								in0->in_stat.st_blocks = n->cap / 512 + (n->cap % 512 ? 1 : 0);
    183c:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    183f:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1842:	c1 e8 09             	shr    eax,0x9
    1845:	89 c2                	mov    edx,eax
    1847:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    184a:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    184d:	25 ff 01 00 00       	and    eax,0x1ff
    1852:	85 c0                	test   eax,eax
    1854:	74 07                	je     185d <memdev_unlink+0x19c>
    1856:	b8 01 00 00 00       	mov    eax,0x1
    185b:	eb 05                	jmp    1862 <memdev_unlink+0x1a1>
    185d:	b8 00 00 00 00       	mov    eax,0x0
    1862:	01 d0                	add    eax,edx
    1864:	ba 00 00 00 00       	mov    edx,0x0
    1869:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    186c:	89 41 3c             	mov    DWORD PTR [ecx+0x3c],eax
    186f:	89 51 40             	mov    DWORD PTR [ecx+0x40],edx
								break;
    1872:	eb 1d                	jmp    1891 <memdev_unlink+0x1d0>
						} else
								fn = fn2 + sizeof(struct inode*);
    1874:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1877:	83 c0 04             	add    eax,0x4
    187a:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
				while (fn < (char*)n + n->size) {
    187d:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1880:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1883:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1886:	01 d0                	add    eax,edx
    1888:	39 45 e0             	cmp    DWORD PTR [ebp-0x20],eax
    188b:	0f 82 cf fe ff ff    	jb     1760 <memdev_unlink+0x9f>
				}
				write_unlock(&in0->in_lock);
    1891:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1894:	83 c0 74             	add    eax,0x74
    1897:	89 04 24             	mov    DWORD PTR [esp],eax
    189a:	e8 fc ff ff ff       	call   189b <memdev_unlink+0x1da>
				if (!n) {
    189f:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    18a3:	75 14                	jne    18b9 <memdev_unlink+0x1f8>
						errno = ENOENT;
    18a5:	c7 05 00 00 00 00 02 00 00 00 	mov    DWORD PTR ds:0x0,0x2
						return -1;
    18af:	b8 ff ff ff ff       	mov    eax,0xffffffff
    18b4:	e9 09 02 00 00       	jmp    1ac2 <memdev_unlink+0x401>
				}
		}

		/* get current time */
		clock_gettime(CLOCK_REALTIME, &t);
    18b9:	8d 45 c8             	lea    eax,[ebp-0x38]
    18bc:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    18c0:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    18c7:	e8 fc ff ff ff       	call   18c8 <memdev_unlink+0x207>
		if (in0)
    18cc:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    18d0:	74 2d                	je     18ff <memdev_unlink+0x23e>
				in0->in_stat.st_mtim = in0->in_stat.st_ctim = t;
    18d2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    18d5:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
    18d8:	89 50 5c             	mov    DWORD PTR [eax+0x5c],edx
    18db:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    18de:	89 50 60             	mov    DWORD PTR [eax+0x60],edx
    18e1:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    18e4:	89 50 64             	mov    DWORD PTR [eax+0x64],edx
    18e7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    18ea:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    18ed:	8b 4a 5c             	mov    ecx,DWORD PTR [edx+0x5c]
    18f0:	89 48 50             	mov    DWORD PTR [eax+0x50],ecx
    18f3:	8b 4a 60             	mov    ecx,DWORD PTR [edx+0x60]
    18f6:	89 48 54             	mov    DWORD PTR [eax+0x54],ecx
    18f9:	8b 52 64             	mov    edx,DWORD PTR [edx+0x64]
    18fc:	89 50 58             	mov    DWORD PTR [eax+0x58],edx

		/* now unlink the node */
		if (in1->in_stat.st_dev != memdev_data->id) {
    18ff:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1902:	8b 08                	mov    ecx,DWORD PTR [eax]
    1904:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    1907:	a1 00 00 00 00       	mov    eax,ds:0x0
    190c:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    190f:	8b 00                	mov    eax,DWORD PTR [eax]
    1911:	89 cf                	mov    edi,ecx
    1913:	89 c6                	mov    esi,eax
    1915:	89 d9                	mov    ecx,ebx
    1917:	89 f8                	mov    eax,edi
    1919:	31 f0                	xor    eax,esi
    191b:	31 ca                	xor    edx,ecx
    191d:	09 d0                	or     eax,edx
    191f:	0f 84 c0 00 00 00    	je     19e5 <memdev_unlink+0x324>
				const struct device_desc* dd = get_device(in1->in_stat.st_dev);
    1925:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1928:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    192b:	8b 00                	mov    eax,DWORD PTR [eax]
    192d:	89 04 24             	mov    DWORD PTR [esp],eax
    1930:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1934:	e8 fc ff ff ff       	call   1935 <memdev_unlink+0x274>
    1939:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				if (!dd) {
    193c:	83 7d d4 00          	cmp    DWORD PTR [ebp-0x2c],0x0
    1940:	0f 85 84 00 00 00    	jne    19ca <memdev_unlink+0x309>
						cprintf(KFMT_WARN, "unable to locate device %u"
										" for unlinking inode at %p\n",
										(uint32_t)in1->in_stat.st_dev, in1);
    1946:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1949:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    194c:	8b 00                	mov    eax,DWORD PTR [eax]
						cprintf(KFMT_WARN, "unable to locate device %u"
    194e:	89 c2                	mov    edx,eax
    1950:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1953:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    1957:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    195b:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    1963:	c7 04 24 0e 00 00 00 	mov    DWORD PTR [esp],0xe
    196a:	e8 fc ff ff ff       	call   196b <memdev_unlink+0x2aa>
						if (__sync_sub_and_fetch(&in1->in_stat.st_dev, 1) == 0)
    196f:	8b 75 0c             	mov    esi,DWORD PTR [ebp+0xc]
    1972:	8b 06                	mov    eax,DWORD PTR [esi]
    1974:	8b 56 04             	mov    edx,DWORD PTR [esi+0x4]
    1977:	89 c1                	mov    ecx,eax
    1979:	89 d3                	mov    ebx,edx
    197b:	83 c1 ff             	add    ecx,0xffffffff
    197e:	83 d3 ff             	adc    ebx,0xffffffff
    1981:	89 4d c0             	mov    DWORD PTR [ebp-0x40],ecx
    1984:	89 5d c4             	mov    DWORD PTR [ebp-0x3c],ebx
    1987:	89 4d b8             	mov    DWORD PTR [ebp-0x48],ecx
    198a:	89 5d bc             	mov    DWORD PTR [ebp-0x44],ebx
    198d:	89 cb                	mov    ebx,ecx
    198f:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    1992:	f0 0f c7 0e          	lock cmpxchg8b QWORD PTR [esi]
    1996:	0f 94 c1             	sete   cl
    1999:	84 c9                	test   cl,cl
    199b:	74 da                	je     1977 <memdev_unlink+0x2b6>
    199d:	8b 5d c0             	mov    ebx,DWORD PTR [ebp-0x40]
    19a0:	8b 75 c4             	mov    esi,DWORD PTR [ebp-0x3c]
    19a3:	89 d8                	mov    eax,ebx
    19a5:	89 f2                	mov    edx,esi
    19a7:	09 d0                	or     eax,edx
    19a9:	75 0b                	jne    19b6 <memdev_unlink+0x2f5>
								ino_release(in1); /* clean up partially */
    19ab:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    19ae:	89 04 24             	mov    DWORD PTR [esp],eax
    19b1:	e8 fc ff ff ff       	call   19b2 <memdev_unlink+0x2f1>
						errno = ENODEV;
    19b6:	c7 05 00 00 00 00 13 00 00 00 	mov    DWORD PTR ds:0x0,0x13
						return 0; /* only warn */
    19c0:	b8 00 00 00 00       	mov    eax,0x0
    19c5:	e9 f8 00 00 00       	jmp    1ac2 <memdev_unlink+0x401>
				} else {
						return dd->fn_unlink(NULL, in1);
    19ca:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    19cd:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    19d0:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    19d3:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    19d7:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    19de:	ff d0                	call   eax
    19e0:	e9 dd 00 00 00       	jmp    1ac2 <memdev_unlink+0x401>
				}
		} else {
				if ((__sync_sub_and_fetch(&in1->in_stat.st_nlink, 1) == 0) &&
    19e5:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    19e8:	8d 70 14             	lea    esi,[eax+0x14]
    19eb:	8b 06                	mov    eax,DWORD PTR [esi]
    19ed:	8b 56 04             	mov    edx,DWORD PTR [esi+0x4]
    19f0:	89 c1                	mov    ecx,eax
    19f2:	89 d3                	mov    ebx,edx
    19f4:	83 c1 ff             	add    ecx,0xffffffff
    19f7:	83 d3 ff             	adc    ebx,0xffffffff
    19fa:	89 4d c0             	mov    DWORD PTR [ebp-0x40],ecx
    19fd:	89 5d c4             	mov    DWORD PTR [ebp-0x3c],ebx
    1a00:	89 4d b8             	mov    DWORD PTR [ebp-0x48],ecx
    1a03:	89 5d bc             	mov    DWORD PTR [ebp-0x44],ebx
    1a06:	89 cb                	mov    ebx,ecx
    1a08:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    1a0b:	f0 0f c7 0e          	lock cmpxchg8b QWORD PTR [esi]
    1a0f:	0f 94 c1             	sete   cl
    1a12:	84 c9                	test   cl,cl
    1a14:	74 da                	je     19f0 <memdev_unlink+0x32f>
    1a16:	8b 5d c0             	mov    ebx,DWORD PTR [ebp-0x40]
    1a19:	8b 75 c4             	mov    esi,DWORD PTR [ebp-0x3c]
    1a1c:	89 d8                	mov    eax,ebx
    1a1e:	89 f2                	mov    edx,esi
    1a20:	09 d0                	or     eax,edx
    1a22:	0f 85 80 00 00 00    	jne    1aa8 <memdev_unlink+0x3e7>
					(*(int*)in1->in_ddat == 0)) {
    1a28:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1a2b:	83 c0 68             	add    eax,0x68
    1a2e:	8b 00                	mov    eax,DWORD PTR [eax]
				if ((__sync_sub_and_fetch(&in1->in_stat.st_nlink, 1) == 0) &&
    1a30:	85 c0                	test   eax,eax
    1a32:	75 74                	jne    1aa8 <memdev_unlink+0x3e7>
						struct memdev_node* n;
						/* this was the last link & no open FDs so remove the node */
						n = *(struct memdev_node**)in1->in_pddat;
    1a34:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1a37:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
    1a3a:	8b 00                	mov    eax,DWORD PTR [eax]
    1a3c:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
						*(struct memdev_node**)in1->in_pddat = NULL; /* free slot */
    1a3f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1a42:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
    1a45:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
						if (S_ISREG(in1->in_stat.st_mode))
    1a4b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1a4e:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1a51:	25 00 f0 00 00       	and    eax,0xf000
    1a56:	3d 00 80 00 00       	cmp    eax,0x8000
    1a5b:	75 22                	jne    1a7f <memdev_unlink+0x3be>
								mm_free_vmem(&mm_kernel, n, n->cap / 4096);
    1a5d:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1a60:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1a63:	c1 e8 0c             	shr    eax,0xc
    1a66:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1a6a:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1a6d:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1a71:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1a78:	e8 fc ff ff ff       	call   1a79 <memdev_unlink+0x3b8>
    1a7d:	eb 17                	jmp    1a96 <memdev_unlink+0x3d5>
						else
								h_free(memdev_data->heap, n);
    1a7f:	a1 00 00 00 00       	mov    eax,ds:0x0
    1a84:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    1a87:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    1a8a:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1a8e:	89 04 24             	mov    DWORD PTR [esp],eax
    1a91:	e8 fc ff ff ff       	call   1a92 <memdev_unlink+0x3d1>
						ino_release(in1);
    1a96:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1a99:	89 04 24             	mov    DWORD PTR [esp],eax
    1a9c:	e8 fc ff ff ff       	call   1a9d <memdev_unlink+0x3dc>
						return 0;
    1aa1:	b8 00 00 00 00       	mov    eax,0x0
    1aa6:	eb 1a                	jmp    1ac2 <memdev_unlink+0x401>
				}
				in1->in_stat.st_ctim = t;
    1aa8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1aab:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
    1aae:	89 50 5c             	mov    DWORD PTR [eax+0x5c],edx
    1ab1:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    1ab4:	89 50 60             	mov    DWORD PTR [eax+0x60],edx
    1ab7:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    1aba:	89 50 64             	mov    DWORD PTR [eax+0x64],edx
				return 0;
    1abd:	b8 00 00 00 00       	mov    eax,0x0
		}
}
    1ac2:	83 c4 4c             	add    esp,0x4c
    1ac5:	5b                   	pop    ebx
    1ac6:	5e                   	pop    esi
    1ac7:	5f                   	pop    edi
    1ac8:	5d                   	pop    ebp
    1ac9:	c3                   	ret

00001aca <memdev_set_subnode>:

int memdev_set_subnode(struct inode* in0, struct inode* in1, const char* fn)
{
    1aca:	55                   	push   ebp
    1acb:	89 e5                	mov    ebp,esp
    1acd:	57                   	push   edi
    1ace:	56                   	push   esi
    1acf:	53                   	push   ebx
    1ad0:	83 ec 5c             	sub    esp,0x5c
		struct memdev_node *n0, *n1 = NULL;
    1ad3:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x0
		if (!in0 || !fn || in0->in_stat.st_dev != memdev_data->id) {
    1ada:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    1ade:	74 28                	je     1b08 <memdev_set_subnode+0x3e>
    1ae0:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    1ae4:	74 22                	je     1b08 <memdev_set_subnode+0x3e>
    1ae6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ae9:	8b 08                	mov    ecx,DWORD PTR [eax]
    1aeb:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    1aee:	a1 00 00 00 00       	mov    eax,ds:0x0
    1af3:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1af6:	8b 00                	mov    eax,DWORD PTR [eax]
    1af8:	89 cf                	mov    edi,ecx
    1afa:	89 c6                	mov    esi,eax
    1afc:	89 d9                	mov    ecx,ebx
    1afe:	89 f8                	mov    eax,edi
    1b00:	31 f0                	xor    eax,esi
    1b02:	31 ca                	xor    edx,ecx
    1b04:	09 d0                	or     eax,edx
    1b06:	74 14                	je     1b1c <memdev_set_subnode+0x52>
				errno = EINVAL;
    1b08:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
				return -1;
    1b12:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1b17:	e9 80 06 00 00       	jmp    219c <memdev_set_subnode+0x6d2>
		}

		/* inode in0 on this device and directory */
		if (!(in0->in_stat.st_mode & S_IFDIR)) {
    1b1c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b1f:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1b22:	25 00 40 00 00       	and    eax,0x4000
    1b27:	85 c0                	test   eax,eax
    1b29:	75 14                	jne    1b3f <memdev_set_subnode+0x75>
				errno = ENOTDIR;
    1b2b:	c7 05 00 00 00 00 14 00 00 00 	mov    DWORD PTR ds:0x0,0x14
				return -1;
    1b35:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1b3a:	e9 5d 06 00 00       	jmp    219c <memdev_set_subnode+0x6d2>
		}
		n0 = *(struct memdev_node**)in0->in_pddat;
    1b3f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b42:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
    1b45:	8b 00                	mov    eax,DWORD PTR [eax]
    1b47:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax

		/* create REAL in1 if dummy for creation */
		if (!in1) { /* unlink */
    1b4a:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
    1b4e:	75 3c                	jne    1b8c <memdev_set_subnode+0xc2>
				/* convenience function */
				in1 = memdev_get_subnode(in0, fn);
    1b50:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1b53:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1b57:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b5a:	89 04 24             	mov    DWORD PTR [esp],eax
    1b5d:	e8 fc ff ff ff       	call   1b5e <memdev_set_subnode+0x94>
    1b62:	89 45 0c             	mov    DWORD PTR [ebp+0xc],eax
				if (!in1)
    1b65:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
    1b69:	75 0a                	jne    1b75 <memdev_set_subnode+0xab>
						return -1;
    1b6b:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1b70:	e9 27 06 00 00       	jmp    219c <memdev_set_subnode+0x6d2>
				return memdev_unlink(in0, in1);
    1b75:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1b78:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1b7c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b7f:	89 04 24             	mov    DWORD PTR [esp],eax
    1b82:	e8 fc ff ff ff       	call   1b83 <memdev_set_subnode+0xb9>
    1b87:	e9 10 06 00 00       	jmp    219c <memdev_set_subnode+0x6d2>
		} else if (in1->in_stat.st_dev == INVALID_DEVICE) {
    1b8c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1b8f:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1b92:	8b 00                	mov    eax,DWORD PTR [eax]
    1b94:	89 c1                	mov    ecx,eax
    1b96:	89 c8                	mov    eax,ecx
    1b98:	f7 d0                	not    eax
    1b9a:	09 d0                	or     eax,edx
    1b9c:	0f 85 95 02 00 00    	jne    1e37 <memdev_set_subnode+0x36d>
				void* mem = NULL; size_t s;
    1ba2:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
				/* only allow dirs, files and links */
				if (!S_ISDIR(in1->in_stat.st_mode) &&
    1ba9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1bac:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1baf:	25 00 f0 00 00       	and    eax,0xf000
    1bb4:	3d 00 40 00 00       	cmp    eax,0x4000
    1bb9:	74 38                	je     1bf3 <memdev_set_subnode+0x129>
					!S_ISREG(in1->in_stat.st_mode) &&
    1bbb:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1bbe:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1bc1:	25 00 f0 00 00       	and    eax,0xf000
				if (!S_ISDIR(in1->in_stat.st_mode) &&
    1bc6:	3d 00 80 00 00       	cmp    eax,0x8000
    1bcb:	74 26                	je     1bf3 <memdev_set_subnode+0x129>
					!S_ISLNK(in1->in_stat.st_mode)) {
    1bcd:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1bd0:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1bd3:	25 00 f0 00 00       	and    eax,0xf000
					!S_ISREG(in1->in_stat.st_mode) &&
    1bd8:	3d 00 a0 00 00       	cmp    eax,0xa000
    1bdd:	74 14                	je     1bf3 <memdev_set_subnode+0x129>
						errno = ENOTSUP;
    1bdf:	c7 05 00 00 00 00 5f 00 00 00 	mov    DWORD PTR ds:0x0,0x5f
						return -1;
    1be9:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1bee:	e9 a9 05 00 00       	jmp    219c <memdev_set_subnode+0x6d2>
				}
				/* calculate the size of the memory */
				if (in1->in_stat.st_size)
    1bf3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1bf6:	8b 50 30             	mov    edx,DWORD PTR [eax+0x30]
    1bf9:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    1bfc:	89 c1                	mov    ecx,eax
    1bfe:	89 c8                	mov    eax,ecx
    1c00:	09 d0                	or     eax,edx
    1c02:	74 2b                	je     1c2f <memdev_set_subnode+0x165>
						s = in1->in_stat.st_size + sizeof(struct memdev_node)
    1c04:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1c07:	8b 50 30             	mov    edx,DWORD PTR [eax+0x30]
    1c0a:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
								+ (S_ISREG(in1->in_stat.st_mode) ? 0 : 1);
    1c0d:	89 c2                	mov    edx,eax
    1c0f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1c12:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1c15:	25 00 f0 00 00       	and    eax,0xf000
    1c1a:	3d 00 80 00 00       	cmp    eax,0x8000
    1c1f:	0f 95 c0             	setne  al
    1c22:	0f b6 c0             	movzx  eax,al
    1c25:	01 d0                	add    eax,edx
						s = in1->in_stat.st_size + sizeof(struct memdev_node)
    1c27:	83 c0 10             	add    eax,0x10
    1c2a:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    1c2d:	eb 3d                	jmp    1c6c <memdev_set_subnode+0x1a2>
				else if (S_ISDIR(in1->in_stat.st_mode))
    1c2f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1c32:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1c35:	25 00 f0 00 00       	and    eax,0xf000
    1c3a:	3d 00 40 00 00       	cmp    eax,0x4000
    1c3f:	75 09                	jne    1c4a <memdev_set_subnode+0x180>
						s = 128 + sizeof(struct memdev_node); /* default dir capacity */
    1c41:	c7 45 dc 90 00 00 00 	mov    DWORD PTR [ebp-0x24],0x90
    1c48:	eb 22                	jmp    1c6c <memdev_set_subnode+0x1a2>
				else if (S_ISLNK(in1->in_stat.st_mode))
    1c4a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1c4d:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1c50:	25 00 f0 00 00       	and    eax,0xf000
    1c55:	3d 00 a0 00 00       	cmp    eax,0xa000
    1c5a:	75 09                	jne    1c65 <memdev_set_subnode+0x19b>
						s = 32 + sizeof(struct memdev_node); /* default link length */
    1c5c:	c7 45 dc 30 00 00 00 	mov    DWORD PTR [ebp-0x24],0x30
    1c63:	eb 07                	jmp    1c6c <memdev_set_subnode+0x1a2>
				else
						s = 4096; /* default file size */
    1c65:	c7 45 dc 00 10 00 00 	mov    DWORD PTR [ebp-0x24],0x1000

				/* get some memory for the memfile */
				if (S_ISREG(in1->in_stat.st_mode)) {
    1c6c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1c6f:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1c72:	25 00 f0 00 00       	and    eax,0xf000
    1c77:	3d 00 80 00 00       	cmp    eax,0x8000
    1c7c:	75 47                	jne    1cc5 <memdev_set_subnode+0x1fb>
						if (s % 4096)
    1c7e:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1c81:	25 ff 0f 00 00       	and    eax,0xfff
    1c86:	85 c0                	test   eax,eax
    1c88:	74 10                	je     1c9a <memdev_set_subnode+0x1d0>
								s += 4096 - (s % 4096);
    1c8a:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1c8d:	25 00 f0 ff ff       	and    eax,0xfffff000
    1c92:	05 00 10 00 00       	add    eax,0x1000
    1c97:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
						mem = mm_alloc_vmem(&mm_kernel, NULL, s / 4096,
    1c9a:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1c9d:	c1 e8 0c             	shr    eax,0xc
    1ca0:	c7 44 24 0c 0c 00 00 00 	mov    DWORD PTR [esp+0xc],0xc
    1ca8:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1cac:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    1cb4:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1cbb:	e8 fc ff ff ff       	call   1cbc <memdev_set_subnode+0x1f2>
    1cc0:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1cc3:	eb 1a                	jmp    1cdf <memdev_set_subnode+0x215>
										MMGR_MAP_KERNEL | MMGR_MAP_WRITE);
				} else
						mem = h_malloc(memdev_data->heap, s);
    1cc5:	a1 00 00 00 00       	mov    eax,ds:0x0
    1cca:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    1ccd:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1cd0:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1cd4:	89 04 24             	mov    DWORD PTR [esp],eax
    1cd7:	e8 fc ff ff ff       	call   1cd8 <memdev_set_subnode+0x20e>
    1cdc:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
				if (!mem)
    1cdf:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    1ce3:	75 0a                	jne    1cef <memdev_set_subnode+0x225>
						return -1;
    1ce5:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1cea:	e9 ad 04 00 00       	jmp    219c <memdev_set_subnode+0x6d2>
				/* now we have clean pages or heap memory */
				n1 = (struct memdev_node*)mem;
    1cef:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1cf2:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				n1->cap = s;
    1cf5:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1cf8:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1cfb:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
				n1->size = sizeof(struct memdev_node);
    1cfe:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1d01:	c7 40 04 10 00 00 00 	mov    DWORD PTR [eax+0x4],0x10
				n1->file = in1->in_stat.st_mode;
    1d08:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1d0b:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
    1d0e:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1d11:	89 10                	mov    DWORD PTR [eax],edx
				n1->ino = ino_allocate(in1->in_stat.st_mode & S_IFMT);
    1d13:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1d16:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1d19:	25 00 f0 00 00       	and    eax,0xf000
    1d1e:	89 04 24             	mov    DWORD PTR [esp],eax
    1d21:	e8 fc ff ff ff       	call   1d22 <memdev_set_subnode+0x258>
    1d26:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    1d29:	89 42 0c             	mov    DWORD PTR [edx+0xc],eax
				if (!n1->ino) { /* undo much */
    1d2c:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1d2f:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1d32:	85 c0                	test   eax,eax
    1d34:	75 52                	jne    1d88 <memdev_set_subnode+0x2be>
free_mem:
    1d36:	90                   	nop
						if (S_ISREG(n1->file))
    1d37:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1d3a:	8b 00                	mov    eax,DWORD PTR [eax]
    1d3c:	25 00 f0 00 00       	and    eax,0xf000
    1d41:	3d 00 80 00 00       	cmp    eax,0x8000
    1d46:	75 1f                	jne    1d67 <memdev_set_subnode+0x29d>
								mm_free_vmem(&mm_kernel, n1, s / 4096);
    1d48:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1d4b:	c1 e8 0c             	shr    eax,0xc
    1d4e:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1d52:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1d55:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1d59:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1d60:	e8 fc ff ff ff       	call   1d61 <memdev_set_subnode+0x297>
    1d65:	eb 17                	jmp    1d7e <memdev_set_subnode+0x2b4>
						else
								h_free(memdev_data->heap, n1);
    1d67:	a1 00 00 00 00       	mov    eax,ds:0x0
    1d6c:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    1d6f:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    1d72:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1d76:	89 04 24             	mov    DWORD PTR [esp],eax
    1d79:	e8 fc ff ff ff       	call   1d7a <memdev_set_subnode+0x2b0>
						return -1;
    1d7e:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1d83:	e9 14 04 00 00       	jmp    219c <memdev_set_subnode+0x6d2>
				}
				/* and the inode */
				n1->ino->in_stat.st_blksize = 4096;
    1d88:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1d8b:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1d8e:	c7 40 34 00 10 00 00 	mov    DWORD PTR [eax+0x34],0x1000
    1d95:	c7 40 38 00 00 00 00 	mov    DWORD PTR [eax+0x38],0x0
				n1->ino->in_stat.st_blocks = s / 512 + ((s % 512) ? 1 : 0);
    1d9c:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1d9f:	c1 e8 09             	shr    eax,0x9
    1da2:	89 c2                	mov    edx,eax
    1da4:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1da7:	25 ff 01 00 00       	and    eax,0x1ff
    1dac:	85 c0                	test   eax,eax
    1dae:	74 07                	je     1db7 <memdev_set_subnode+0x2ed>
    1db0:	b8 01 00 00 00       	mov    eax,0x1
    1db5:	eb 05                	jmp    1dbc <memdev_set_subnode+0x2f2>
    1db7:	b8 00 00 00 00       	mov    eax,0x0
    1dbc:	01 c2                	add    edx,eax
    1dbe:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1dc1:	8b 48 0c             	mov    ecx,DWORD PTR [eax+0xc]
    1dc4:	89 d0                	mov    eax,edx
    1dc6:	ba 00 00 00 00       	mov    edx,0x0
    1dcb:	89 41 3c             	mov    DWORD PTR [ecx+0x3c],eax
    1dce:	89 51 40             	mov    DWORD PTR [ecx+0x40],edx
				n1->ino->in_stat.st_dev = memdev_data->id;
    1dd1:	a1 00 00 00 00       	mov    eax,ds:0x0
    1dd6:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    1dd9:	8b 4a 0c             	mov    ecx,DWORD PTR [edx+0xc]
    1ddc:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1ddf:	8b 00                	mov    eax,DWORD PTR [eax]
    1de1:	89 01                	mov    DWORD PTR [ecx],eax
    1de3:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
				n1->ino->in_stat.st_size = 1;
    1de6:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1de9:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1dec:	c7 40 2c 01 00 00 00 	mov    DWORD PTR [eax+0x2c],0x1
    1df3:	c7 40 30 00 00 00 00 	mov    DWORD PTR [eax+0x30],0x0
				n1->ino->in_pddat = memdev_store_node(n1);
    1dfa:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1dfd:	8b 58 0c             	mov    ebx,DWORD PTR [eax+0xc]
    1e00:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1e03:	89 04 24             	mov    DWORD PTR [esp],eax
    1e06:	e8 fc ff ff ff       	call   1e07 <memdev_set_subnode+0x33d>
    1e0b:	89 43 70             	mov    DWORD PTR [ebx+0x70],eax
				if (!n1->ino->in_pddat) {
    1e0e:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1e11:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1e14:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
    1e17:	85 c0                	test   eax,eax
    1e19:	75 13                	jne    1e2e <memdev_set_subnode+0x364>
						/* sth. went wrong! */
						ino_release(n1->ino);
    1e1b:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1e1e:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1e21:	89 04 24             	mov    DWORD PTR [esp],eax
    1e24:	e8 fc ff ff ff       	call   1e25 <memdev_set_subnode+0x35b>
						goto free_mem;
    1e29:	e9 09 ff ff ff       	jmp    1d37 <memdev_set_subnode+0x26d>
				}
				in1 = n1->ino;
    1e2e:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1e31:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1e34:	89 45 0c             	mov    DWORD PTR [ebp+0xc],eax
		}

		/* acquire the write lock */
		write_lock(&in0->in_lock);
    1e37:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1e3a:	83 c0 74             	add    eax,0x74
    1e3d:	89 04 24             	mov    DWORD PTR [esp],eax
    1e40:	e8 fc ff ff ff       	call   1e41 <memdev_set_subnode+0x377>
		/* find possible old/conflicting inode */
		char* dt = memdev_search_fn(n0, fn), need_entry = 1;
    1e45:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1e48:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1e4c:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1e4f:	89 04 24             	mov    DWORD PTR [esp],eax
    1e52:	e8 fc ff ff ff       	call   1e53 <memdev_set_subnode+0x389>
    1e57:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
    1e5a:	c6 45 db 01          	mov    BYTE PTR [ebp-0x25],0x1
		if (dt) {
    1e5e:	83 7d d0 00          	cmp    DWORD PTR [ebp-0x30],0x0
    1e62:	0f 84 3a 01 00 00    	je     1fa2 <memdev_set_subnode+0x4d8>
				struct inode* in2;
				/* already existing, get inode */
				dt += strlen(dt) + 1;
    1e68:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1e6b:	89 04 24             	mov    DWORD PTR [esp],eax
    1e6e:	e8 fc ff ff ff       	call   1e6f <memdev_set_subnode+0x3a5>
    1e73:	83 c0 01             	add    eax,0x1
    1e76:	01 45 d0             	add    DWORD PTR [ebp-0x30],eax
				in2 = *(struct inode**)dt;
    1e79:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1e7c:	8b 00                	mov    eax,DWORD PTR [eax]
    1e7e:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
				if (in1 == in2) {
    1e81:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1e84:	3b 45 cc             	cmp    eax,DWORD PTR [ebp-0x34]
    1e87:	75 22                	jne    1eab <memdev_set_subnode+0x3e1>
						/* do nothing */
						errno = EEXIST;
    1e89:	c7 05 00 00 00 00 11 00 00 00 	mov    DWORD PTR ds:0x0,0x11
						write_unlock(&in0->in_lock);
    1e93:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1e96:	83 c0 74             	add    eax,0x74
    1e99:	89 04 24             	mov    DWORD PTR [esp],eax
    1e9c:	e8 fc ff ff ff       	call   1e9d <memdev_set_subnode+0x3d3>
						return -1;
    1ea1:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1ea6:	e9 f1 02 00 00       	jmp    219c <memdev_set_subnode+0x6d2>
				}
				/* unlink old node if neccessary */
				if (in2->in_stat.st_dev == memdev_data->id)
    1eab:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1eae:	8b 08                	mov    ecx,DWORD PTR [eax]
    1eb0:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    1eb3:	a1 00 00 00 00       	mov    eax,ds:0x0
    1eb8:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1ebb:	8b 00                	mov    eax,DWORD PTR [eax]
    1ebd:	89 cf                	mov    edi,ecx
    1ebf:	89 c6                	mov    esi,eax
    1ec1:	89 d9                	mov    ecx,ebx
    1ec3:	89 f8                	mov    eax,edi
    1ec5:	31 f0                	xor    eax,esi
    1ec7:	31 ca                	xor    edx,ecx
    1ec9:	09 d0                	or     eax,edx
    1ecb:	75 18                	jne    1ee5 <memdev_set_subnode+0x41b>
						memdev_unlink(NULL, in2);
    1ecd:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1ed0:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1ed4:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1edb:	e8 fc ff ff ff       	call   1edc <memdev_set_subnode+0x412>
    1ee0:	e9 a5 00 00 00       	jmp    1f8a <memdev_set_subnode+0x4c0>
				else {
						const struct device_desc* dd;
						dd = get_device(in2->in_stat.st_dev);
    1ee5:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1ee8:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1eeb:	8b 00                	mov    eax,DWORD PTR [eax]
    1eed:	89 04 24             	mov    DWORD PTR [esp],eax
    1ef0:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1ef4:	e8 fc ff ff ff       	call   1ef5 <memdev_set_subnode+0x42b>
    1ef9:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
						if (!dd) {
    1efc:	83 7d c8 00          	cmp    DWORD PTR [ebp-0x38],0x0
    1f00:	75 72                	jne    1f74 <memdev_set_subnode+0x4aa>
								cprintf(KFMT_WARN, "unable to locate device %u"
												" for unlinking inode referenced by %s\n",
												(uint32_t)in2->in_stat.st_dev, fn);
    1f02:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1f05:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1f08:	8b 00                	mov    eax,DWORD PTR [eax]
								cprintf(KFMT_WARN, "unable to locate device %u"
    1f0a:	89 c2                	mov    edx,eax
    1f0c:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1f0f:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    1f13:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    1f17:	c7 44 24 04 38 00 00 00 	mov    DWORD PTR [esp+0x4],0x38
    1f1f:	c7 04 24 0e 00 00 00 	mov    DWORD PTR [esp],0xe
    1f26:	e8 fc ff ff ff       	call   1f27 <memdev_set_subnode+0x45d>
								if (__sync_sub_and_fetch(&in2->in_stat.st_dev, 1) == 0)
    1f2b:	8b 75 cc             	mov    esi,DWORD PTR [ebp-0x34]
    1f2e:	8b 06                	mov    eax,DWORD PTR [esi]
    1f30:	8b 56 04             	mov    edx,DWORD PTR [esi+0x4]
    1f33:	89 c1                	mov    ecx,eax
    1f35:	89 d3                	mov    ebx,edx
    1f37:	83 c1 ff             	add    ecx,0xffffffff
    1f3a:	83 d3 ff             	adc    ebx,0xffffffff
    1f3d:	89 4d b0             	mov    DWORD PTR [ebp-0x50],ecx
    1f40:	89 5d b4             	mov    DWORD PTR [ebp-0x4c],ebx
    1f43:	89 4d a8             	mov    DWORD PTR [ebp-0x58],ecx
    1f46:	89 5d ac             	mov    DWORD PTR [ebp-0x54],ebx
    1f49:	89 cb                	mov    ebx,ecx
    1f4b:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    1f4e:	f0 0f c7 0e          	lock cmpxchg8b QWORD PTR [esi]
    1f52:	0f 94 c1             	sete   cl
    1f55:	84 c9                	test   cl,cl
    1f57:	74 da                	je     1f33 <memdev_set_subnode+0x469>
    1f59:	8b 5d b0             	mov    ebx,DWORD PTR [ebp-0x50]
    1f5c:	8b 75 b4             	mov    esi,DWORD PTR [ebp-0x4c]
    1f5f:	89 d8                	mov    eax,ebx
    1f61:	89 f2                	mov    edx,esi
    1f63:	09 d0                	or     eax,edx
    1f65:	75 23                	jne    1f8a <memdev_set_subnode+0x4c0>
										ino_release(in2); /* clean up partially */
    1f67:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1f6a:	89 04 24             	mov    DWORD PTR [esp],eax
    1f6d:	e8 fc ff ff ff       	call   1f6e <memdev_set_subnode+0x4a4>
    1f72:	eb 16                	jmp    1f8a <memdev_set_subnode+0x4c0>
						} else {
								dd->fn_unlink(NULL, in2);
    1f74:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1f77:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    1f7a:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    1f7d:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1f81:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1f88:	ff d0                	call   eax
						}
				}
				/* set new link */
				*(struct inode**)dt = in1;
    1f8a:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1f8d:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    1f90:	89 10                	mov    DWORD PTR [eax],edx
				need_entry = 0;
    1f92:	c6 45 db 00          	mov    BYTE PTR [ebp-0x25],0x0
				printf("fn matches prev\n");
    1f96:	c7 04 24 79 00 00 00 	mov    DWORD PTR [esp],0x79
    1f9d:	e8 fc ff ff ff       	call   1f9e <memdev_set_subnode+0x4d4>
		}

		/* assume valid inode in1 */
		__sync_fetch_and_add(&in1->in_stat.st_nlink, 1);
    1fa2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1fa5:	8d 70 14             	lea    esi,[eax+0x14]
    1fa8:	8b 06                	mov    eax,DWORD PTR [esi]
    1faa:	8b 56 04             	mov    edx,DWORD PTR [esi+0x4]
    1fad:	89 c1                	mov    ecx,eax
    1faf:	89 d3                	mov    ebx,edx
    1fb1:	83 c1 01             	add    ecx,0x1
    1fb4:	83 d3 00             	adc    ebx,0x0
    1fb7:	89 4d b0             	mov    DWORD PTR [ebp-0x50],ecx
    1fba:	89 5d b4             	mov    DWORD PTR [ebp-0x4c],ebx
    1fbd:	89 cb                	mov    ebx,ecx
    1fbf:	8b 4d b4             	mov    ecx,DWORD PTR [ebp-0x4c]
    1fc2:	f0 0f c7 0e          	lock cmpxchg8b QWORD PTR [esi]
    1fc6:	0f 94 c1             	sete   cl
    1fc9:	84 c9                	test   cl,cl
    1fcb:	74 e0                	je     1fad <memdev_set_subnode+0x4e3>
		if (need_entry) {
    1fcd:	80 7d db 00          	cmp    BYTE PTR [ebp-0x25],0x0
    1fd1:	0f 84 6c 01 00 00    	je     2143 <memdev_set_subnode+0x679>
				/* modify data */
				size_t s = strlen(fn) + 1 + sizeof(void*);
    1fd7:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1fda:	89 04 24             	mov    DWORD PTR [esp],eax
    1fdd:	e8 fc ff ff ff       	call   1fde <memdev_set_subnode+0x514>
    1fe2:	83 c0 05             	add    eax,0x5
    1fe5:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
				dt = (char*)n0 + n0->size;
    1fe8:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1feb:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1fee:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1ff1:	01 d0                	add    eax,edx
    1ff3:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
				if ((n0->cap - n0->size) < s) {
    1ff6:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1ff9:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    1ffc:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1fff:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2002:	29 c2                	sub    edx,eax
    2004:	3b 55 c4             	cmp    edx,DWORD PTR [ebp-0x3c]
    2007:	73 6f                	jae    2078 <memdev_set_subnode+0x5ae>
						/* use realloc */
						size_t nc = 2 * n0->cap + s;
    2009:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    200c:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    200f:	8d 14 00             	lea    edx,[eax+eax*1]
    2012:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2015:	01 d0                	add    eax,edx
    2017:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
						n0 = h_realloc(memdev_data->heap, n0, nc);
    201a:	a1 00 00 00 00       	mov    eax,ds:0x0
    201f:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    2022:	8b 55 c0             	mov    edx,DWORD PTR [ebp-0x40]
    2025:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    2029:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    202c:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    2030:	89 04 24             	mov    DWORD PTR [esp],eax
    2033:	e8 fc ff ff ff       	call   2034 <memdev_set_subnode+0x56a>
    2038:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
						if (!n0) { /* real OOM */
    203b:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    203f:	75 20                	jne    2061 <memdev_set_subnode+0x597>
								cprintf(KFMT_ERROR, "failed to realloc on memdev heap: errno=%d\n", errno);
    2041:	a1 00 00 00 00       	mov    eax,ds:0x0
    2046:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    204a:	c7 44 24 04 8c 00 00 00 	mov    DWORD PTR [esp+0x4],0x8c
    2052:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    2059:	e8 fc ff ff ff       	call   205a <memdev_set_subnode+0x590>
								while (1);
    205e:	90                   	nop
    205f:	eb fd                	jmp    205e <memdev_set_subnode+0x594>
						}
						/* no cmpxchg neccessary */
						*(struct memdev_node**)n0->ino->in_pddat = n0;
    2061:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2064:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    2067:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
    206a:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    206d:	89 10                	mov    DWORD PTR [eax],edx
						n0->cap = nc;
    206f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2072:	8b 55 c0             	mov    edx,DWORD PTR [ebp-0x40]
    2075:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
				}
				/* we now have enough space */
				strncpy(dt, fn, s - 1 - sizeof(void*));
    2078:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    207b:	83 e8 05             	sub    eax,0x5
    207e:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2082:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    2085:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2089:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    208c:	89 04 24             	mov    DWORD PTR [esp],eax
    208f:	e8 fc ff ff ff       	call   2090 <memdev_set_subnode+0x5c6>
				dt += s - 1 - sizeof(void*);
    2094:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2097:	83 e8 05             	sub    eax,0x5
    209a:	01 45 d0             	add    DWORD PTR [ebp-0x30],eax
				*dt = '\0';
    209d:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    20a0:	c6 00 00             	mov    BYTE PTR [eax],0x0
				*(struct inode**)(++dt) = in1;
    20a3:	83 45 d0 01          	add    DWORD PTR [ebp-0x30],0x1
    20a7:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    20aa:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    20ad:	89 10                	mov    DWORD PTR [eax],edx
				n0->size += s;
    20af:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    20b2:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    20b5:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    20b8:	01 c2                	add    edx,eax
    20ba:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    20bd:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
				in0->in_stat.st_size = n0->size - sizeof(struct memdev_node);
    20c0:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    20c3:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    20c6:	83 e8 10             	sub    eax,0x10
    20c9:	ba 00 00 00 00       	mov    edx,0x0
    20ce:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    20d1:	89 41 2c             	mov    DWORD PTR [ecx+0x2c],eax
    20d4:	89 51 30             	mov    DWORD PTR [ecx+0x30],edx
				in0->in_stat.st_blocks = in0->in_stat.st_size / 512
    20d7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    20da:	8b 50 30             	mov    edx,DWORD PTR [eax+0x30]
    20dd:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    20e0:	89 c1                	mov    ecx,eax
    20e2:	89 d3                	mov    ebx,edx
    20e4:	89 db                	mov    ebx,ebx
    20e6:	c1 fb 1f             	sar    ebx,0x1f
    20e9:	89 d9                	mov    ecx,ebx
    20eb:	81 e1 ff 01 00 00    	and    ecx,0x1ff
    20f1:	bb 00 00 00 00       	mov    ebx,0x0
    20f6:	01 c8                	add    eax,ecx
    20f8:	11 da                	adc    edx,ebx
    20fa:	0f ac d0 09          	shrd   eax,edx,0x9
    20fe:	c1 fa 09             	sar    edx,0x9
    2101:	89 c6                	mov    esi,eax
    2103:	89 d7                	mov    edi,edx
					   	+ ((in0->in_stat.st_size % 512) ? 1 : 0);
    2105:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2108:	8b 50 30             	mov    edx,DWORD PTR [eax+0x30]
    210b:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    210e:	25 ff 01 00 00       	and    eax,0x1ff
    2113:	ba 00 00 00 00       	mov    edx,0x0
    2118:	89 c1                	mov    ecx,eax
    211a:	89 c8                	mov    eax,ecx
    211c:	09 d0                	or     eax,edx
    211e:	74 0c                	je     212c <memdev_set_subnode+0x662>
    2120:	b8 01 00 00 00       	mov    eax,0x1
    2125:	ba 00 00 00 00       	mov    edx,0x0
    212a:	eb 0a                	jmp    2136 <memdev_set_subnode+0x66c>
    212c:	b8 00 00 00 00       	mov    eax,0x0
    2131:	ba 00 00 00 00       	mov    edx,0x0
    2136:	01 f0                	add    eax,esi
    2138:	11 fa                	adc    edx,edi
				in0->in_stat.st_blocks = in0->in_stat.st_size / 512
    213a:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    213d:	89 41 3c             	mov    DWORD PTR [ecx+0x3c],eax
    2140:	89 51 40             	mov    DWORD PTR [ecx+0x40],edx
		}
		/* update times (only c&m on dir & c on fil) */
		clock_gettime(CLOCK_REALTIME, &in0->in_stat.st_mtim);
    2143:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2146:	83 c0 50             	add    eax,0x50
    2149:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    214d:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    2154:	e8 fc ff ff ff       	call   2155 <memdev_set_subnode+0x68b>
		in0->in_stat.st_ctim = in0->in_stat.st_mtim;
    2159:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    215c:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    215f:	8b 4a 50             	mov    ecx,DWORD PTR [edx+0x50]
    2162:	89 48 5c             	mov    DWORD PTR [eax+0x5c],ecx
    2165:	8b 4a 54             	mov    ecx,DWORD PTR [edx+0x54]
    2168:	89 48 60             	mov    DWORD PTR [eax+0x60],ecx
    216b:	8b 52 58             	mov    edx,DWORD PTR [edx+0x58]
    216e:	89 50 64             	mov    DWORD PTR [eax+0x64],edx
		/* due to change in link count */
		in1->in_stat.st_ctim = in0->in_stat.st_mtim;
    2171:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2174:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    2177:	8b 4a 50             	mov    ecx,DWORD PTR [edx+0x50]
    217a:	89 48 5c             	mov    DWORD PTR [eax+0x5c],ecx
    217d:	8b 4a 54             	mov    ecx,DWORD PTR [edx+0x54]
    2180:	89 48 60             	mov    DWORD PTR [eax+0x60],ecx
    2183:	8b 52 58             	mov    edx,DWORD PTR [edx+0x58]
    2186:	89 50 64             	mov    DWORD PTR [eax+0x64],edx
		write_unlock(&in0->in_lock);
    2189:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    218c:	83 c0 74             	add    eax,0x74
    218f:	89 04 24             	mov    DWORD PTR [esp],eax
    2192:	e8 fc ff ff ff       	call   2193 <memdev_set_subnode+0x6c9>
		return 0;
    2197:	b8 00 00 00 00       	mov    eax,0x0
}
    219c:	83 c4 5c             	add    esp,0x5c
    219f:	5b                   	pop    ebx
    21a0:	5e                   	pop    esi
    21a1:	5f                   	pop    edi
    21a2:	5d                   	pop    ebp
    21a3:	c3                   	ret

000021a4 <get_special_inode>:
/**********************************************************/
static struct inode *in_root, *in_dev;
struct inode* get_special_inode(enum spec_ino what)
{
    21a4:	55                   	push   ebp
    21a5:	89 e5                	mov    ebp,esp
		switch (what) {
    21a7:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    21ab:	74 08                	je     21b5 <get_special_inode+0x11>
    21ad:	83 7d 08 01          	cmp    DWORD PTR [ebp+0x8],0x1
    21b1:	74 09                	je     21bc <get_special_inode+0x18>
    21b3:	eb 0e                	jmp    21c3 <get_special_inode+0x1f>
				case INO_ROOT:
						return in_root;
    21b5:	a1 30 28 00 00       	mov    eax,ds:0x2830
    21ba:	eb 0c                	jmp    21c8 <get_special_inode+0x24>
				case INO_DEV:
						return in_dev;
    21bc:	a1 34 28 00 00       	mov    eax,ds:0x2834
    21c1:	eb 05                	jmp    21c8 <get_special_inode+0x24>
				default:
						return NULL;
    21c3:	b8 00 00 00 00       	mov    eax,0x0
		}
}
    21c8:	5d                   	pop    ebp
    21c9:	c3                   	ret

000021ca <module_init>:
/**********************************************************/
int MODENTRY module_init()
{
    21ca:	55                   	push   ebp
    21cb:	89 e5                	mov    ebp,esp
    21cd:	57                   	push   edi
    21ce:	53                   	push   ebx
    21cf:	81 ec d0 00 00 00    	sub    esp,0xd0
		struct device_desc dd = {0}; dev_t d;
    21d5:	8d 55 b8             	lea    edx,[ebp-0x48]
    21d8:	b8 00 00 00 00       	mov    eax,0x0
    21dd:	b9 0e 00 00 00       	mov    ecx,0xe
    21e2:	89 d7                	mov    edi,edx
    21e4:	f3 ab                	rep stos DWORD PTR es:[edi],eax
		printf("registering the basic file devices\n");
    21e6:	c7 04 24 b8 00 00 00 	mov    DWORD PTR [esp],0xb8
    21ed:	e8 fc ff ff ff       	call   21ee <module_init+0x24>
		dd.type = DEVTYPE_NONE;
    21f2:	c6 45 b8 01          	mov    BYTE PTR [ebp-0x48],0x1
		dd.fn_reg_dev = memdev_register;
    21f6:	c7 45 bc 00 00 00 00 	mov    DWORD PTR [ebp-0x44],0x0
		dd.fn_unreg_dev = memdev_unregister;
    21fd:	c7 45 c0 00 00 00 00 	mov    DWORD PTR [ebp-0x40],0x0
		dd.fn_open = memdev_open;
    2204:	c7 45 c4 00 00 00 00 	mov    DWORD PTR [ebp-0x3c],0x0
		dd.fn_read = memdev_read;
    220b:	c7 45 c8 00 00 00 00 	mov    DWORD PTR [ebp-0x38],0x0
		dd.fn_write = memdev_write;
    2212:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
		dd.fn_close = memdev_close;
    2219:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [ebp-0x30],0x0
		dd.fn_lseek = memdev_lseek;
    2220:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x0
		dd.fn_truncate = memdev_truncate;
    2227:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [ebp-0x28],0x0
		dd.fn_get_subnode = memdev_get_subnode;
    222e:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
		dd.fn_set_subnode = memdev_set_subnode;
    2235:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
		dd.fn_unlink = memdev_unlink;
    223c:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
		d = register_device(&dd);
    2243:	8d 45 b8             	lea    eax,[ebp-0x48]
    2246:	89 04 24             	mov    DWORD PTR [esp],eax
    2249:	e8 fc ff ff ff       	call   224a <module_init+0x80>
    224e:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    2251:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
		if (d != INVALID_DEVICE)
    2254:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2257:	f7 d0                	not    eax
    2259:	0b 45 f4             	or     eax,DWORD PTR [ebp-0xc]
    225c:	74 43                	je     22a1 <module_init+0xd7>
				printf("\tregistered memdev as device %u\n", (uint32_t)d);
    225e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2261:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2265:	c7 04 24 dc 00 00 00 	mov    DWORD PTR [esp],0xdc
    226c:	e8 fc ff ff ff       	call   226d <module_init+0xa3>
		else {
				printf("\tfailed to register memdev: errno=%d\n", errno);
				return -1;
		}

		printf("\ncreating the root file system\n");
    2271:	c7 04 24 28 01 00 00 	mov    DWORD PTR [esp],0x128
    2278:	e8 fc ff ff ff       	call   2279 <module_init+0xaf>
		/* create the / & /dev folders */
		in_root = dd.fn_get_subnode(NULL, "");
    227d:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2280:	c7 44 24 04 48 01 00 00 	mov    DWORD PTR [esp+0x4],0x148
    2288:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    228f:	ff d0                	call   eax
    2291:	a3 30 28 00 00       	mov    ds:0x2830,eax
		if (!in_root) {
    2296:	a1 30 28 00 00       	mov    eax,ds:0x2830
    229b:	85 c0                	test   eax,eax
    229d:	75 48                	jne    22e7 <module_init+0x11d>
    229f:	eb 1f                	jmp    22c0 <module_init+0xf6>
				printf("\tfailed to register memdev: errno=%d\n", errno);
    22a1:	a1 00 00 00 00       	mov    eax,ds:0x0
    22a6:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    22aa:	c7 04 24 00 01 00 00 	mov    DWORD PTR [esp],0x100
    22b1:	e8 fc ff ff ff       	call   22b2 <module_init+0xe8>
				return -1;
    22b6:	b8 ff ff ff ff       	mov    eax,0xffffffff
    22bb:	e9 05 01 00 00       	jmp    23c5 <module_init+0x1fb>
				cprintf(KFMT_ERROR, "\tfailed to create root in memdev: errno=%d\n", errno);
    22c0:	a1 00 00 00 00       	mov    eax,ds:0x0
    22c5:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    22c9:	c7 44 24 04 4c 01 00 00 	mov    DWORD PTR [esp+0x4],0x14c
    22d1:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    22d8:	e8 fc ff ff ff       	call   22d9 <module_init+0x10f>
				return -1;
    22dd:	b8 ff ff ff ff       	mov    eax,0xffffffff
    22e2:	e9 de 00 00 00       	jmp    23c5 <module_init+0x1fb>
		}
		printf("adding /dev\n");
    22e7:	c7 04 24 78 01 00 00 	mov    DWORD PTR [esp],0x178
    22ee:	e8 fc ff ff ff       	call   22ef <module_init+0x125>
		if (dd.fn_set_subnode(in_root, &INO_TMPL_DIR, "dev") != 0) {
    22f3:	8b 5d e0             	mov    ebx,DWORD PTR [ebp-0x20]
    22f6:	8d 95 3c ff ff ff    	lea    edx,[ebp-0xc4]
    22fc:	b8 00 00 00 00       	mov    eax,0x0
    2301:	b9 1f 00 00 00       	mov    ecx,0x1f
    2306:	89 d7                	mov    edi,edx
    2308:	f3 ab                	rep stos DWORD PTR es:[edi],eax
    230a:	c7 85 3c ff ff ff ff ff ff ff 	mov    DWORD PTR [ebp-0xc4],0xffffffff
    2314:	c7 85 40 ff ff ff 00 00 00 00 	mov    DWORD PTR [ebp-0xc0],0x0
    231e:	c7 85 4c ff ff ff 00 40 00 00 	mov    DWORD PTR [ebp-0xb4],0x4000
    2328:	a1 30 28 00 00       	mov    eax,ds:0x2830
    232d:	c7 44 24 08 85 01 00 00 	mov    DWORD PTR [esp+0x8],0x185
    2335:	8d 95 3c ff ff ff    	lea    edx,[ebp-0xc4]
    233b:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    233f:	89 04 24             	mov    DWORD PTR [esp],eax
    2342:	ff d3                	call   ebx
    2344:	85 c0                	test   eax,eax
    2346:	74 24                	je     236c <module_init+0x1a2>
				cprintf(KFMT_ERROR, "\tfailed to create folder /dev in root: errno=%d\n", errno);
    2348:	a1 00 00 00 00       	mov    eax,ds:0x0
    234d:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2351:	c7 44 24 04 8c 01 00 00 	mov    DWORD PTR [esp+0x4],0x18c
    2359:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    2360:	e8 fc ff ff ff       	call   2361 <module_init+0x197>
				return -1;
    2365:	b8 ff ff ff ff       	mov    eax,0xffffffff
    236a:	eb 59                	jmp    23c5 <module_init+0x1fb>
		}
		printf("retrieving /dev\n");
    236c:	c7 04 24 bd 01 00 00 	mov    DWORD PTR [esp],0x1bd
    2373:	e8 fc ff ff ff       	call   2374 <module_init+0x1aa>
		in_dev = dd.fn_get_subnode(in_root, "dev");
    2378:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    237b:	8b 15 30 28 00 00    	mov    edx,DWORD PTR ds:0x2830
    2381:	c7 44 24 04 85 01 00 00 	mov    DWORD PTR [esp+0x4],0x185
    2389:	89 14 24             	mov    DWORD PTR [esp],edx
    238c:	ff d0                	call   eax
    238e:	a3 34 28 00 00       	mov    ds:0x2834,eax
		if (!in_dev) {
    2393:	a1 34 28 00 00       	mov    eax,ds:0x2834
    2398:	85 c0                	test   eax,eax
    239a:	75 24                	jne    23c0 <module_init+0x1f6>
				cprintf(KFMT_ERROR, "\tfailed to access folder /dev: errno=%d\n", errno);
    239c:	a1 00 00 00 00       	mov    eax,ds:0x0
    23a1:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    23a5:	c7 44 24 04 d0 01 00 00 	mov    DWORD PTR [esp+0x4],0x1d0
    23ad:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    23b4:	e8 fc ff ff ff       	call   23b5 <module_init+0x1eb>
				return -1;
    23b9:	b8 ff ff ff ff       	mov    eax,0xffffffff
    23be:	eb 05                	jmp    23c5 <module_init+0x1fb>
		}

		return 0;
    23c0:	b8 00 00 00 00       	mov    eax,0x0
}
    23c5:	81 c4 d0 00 00 00    	add    esp,0xd0
    23cb:	5b                   	pop    ebx
    23cc:	5f                   	pop    edi
    23cd:	5d                   	pop    ebp
    23ce:	c3                   	ret

000023cf <print_stat>:

void print_stat(struct inode* in, const char* fn, int cb, int cu, int cg, int cs)
{
    23cf:	55                   	push   ebp
    23d0:	89 e5                	mov    ebp,esp
    23d2:	57                   	push   edi
    23d3:	56                   	push   esi
    23d4:	53                   	push   ebx
    23d5:	81 ec dc 00 00 00    	sub    esp,0xdc
		char fmt = KFMT_NORMAL, c_tp = '-', c_ur = '-', c_uw = '-',
    23db:	c6 45 e7 0f          	mov    BYTE PTR [ebp-0x19],0xf
    23df:	c6 45 e6 2d          	mov    BYTE PTR [ebp-0x1a],0x2d
    23e3:	c6 45 e5 2d          	mov    BYTE PTR [ebp-0x1b],0x2d
    23e7:	c6 45 e4 2d          	mov    BYTE PTR [ebp-0x1c],0x2d
			 c_ux = '-', c_gr = '-', c_gw = '-', c_gx = '-', c_or = '-',
    23eb:	c6 45 e3 2d          	mov    BYTE PTR [ebp-0x1d],0x2d
    23ef:	c6 45 e2 2d          	mov    BYTE PTR [ebp-0x1e],0x2d
    23f3:	c6 45 e1 2d          	mov    BYTE PTR [ebp-0x1f],0x2d
    23f7:	c6 45 e0 2d          	mov    BYTE PTR [ebp-0x20],0x2d
    23fb:	c6 45 df 2d          	mov    BYTE PTR [ebp-0x21],0x2d
			 c_ow = '-', c_ox = '-';
    23ff:	c6 45 de 2d          	mov    BYTE PTR [ebp-0x22],0x2d
    2403:	c6 45 dd 2d          	mov    BYTE PTR [ebp-0x23],0x2d
		mode_t m = in->in_stat.st_mode;
    2407:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    240a:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    240d:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax

		if (m & S_IRUSR)
    2410:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2413:	25 00 01 00 00       	and    eax,0x100
    2418:	85 c0                	test   eax,eax
    241a:	74 04                	je     2420 <print_stat+0x51>
				c_ur = 'r';
    241c:	c6 45 e5 72          	mov    BYTE PTR [ebp-0x1b],0x72
		if (m & S_IWUSR)
    2420:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2423:	25 80 00 00 00       	and    eax,0x80
    2428:	85 c0                	test   eax,eax
    242a:	74 04                	je     2430 <print_stat+0x61>
				c_uw = 'w';
    242c:	c6 45 e4 77          	mov    BYTE PTR [ebp-0x1c],0x77
		if (m & S_IXUSR)
    2430:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2433:	83 e0 40             	and    eax,0x40
    2436:	85 c0                	test   eax,eax
    2438:	74 04                	je     243e <print_stat+0x6f>
				c_ux = 'x';
    243a:	c6 45 e3 78          	mov    BYTE PTR [ebp-0x1d],0x78
		if (m & S_ISUID) /* setuid */
    243e:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2441:	25 00 08 00 00       	and    eax,0x800
    2446:	85 c0                	test   eax,eax
    2448:	74 15                	je     245f <print_stat+0x90>
				c_ux = ((c_ux == 'x') ? 's' : 'S');
    244a:	80 7d e3 78          	cmp    BYTE PTR [ebp-0x1d],0x78
    244e:	75 07                	jne    2457 <print_stat+0x88>
    2450:	b8 73 00 00 00       	mov    eax,0x73
    2455:	eb 05                	jmp    245c <print_stat+0x8d>
    2457:	b8 53 00 00 00       	mov    eax,0x53
    245c:	88 45 e3             	mov    BYTE PTR [ebp-0x1d],al
		if (m & S_IRGRP)
    245f:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2462:	83 e0 20             	and    eax,0x20
    2465:	85 c0                	test   eax,eax
    2467:	74 04                	je     246d <print_stat+0x9e>
				c_gr = 'r';
    2469:	c6 45 e2 72          	mov    BYTE PTR [ebp-0x1e],0x72
		if (m & S_IWGRP)
    246d:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2470:	83 e0 10             	and    eax,0x10
    2473:	85 c0                	test   eax,eax
    2475:	74 04                	je     247b <print_stat+0xac>
				c_gw = 'w';
    2477:	c6 45 e1 77          	mov    BYTE PTR [ebp-0x1f],0x77
		if (m & S_IXGRP)
    247b:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    247e:	83 e0 08             	and    eax,0x8
    2481:	85 c0                	test   eax,eax
    2483:	74 04                	je     2489 <print_stat+0xba>
				c_gx = 'x';
    2485:	c6 45 e0 78          	mov    BYTE PTR [ebp-0x20],0x78
		if (m & S_ISGID) /* setgid */
    2489:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    248c:	25 00 04 00 00       	and    eax,0x400
    2491:	85 c0                	test   eax,eax
    2493:	74 15                	je     24aa <print_stat+0xdb>
				c_gx = ((c_gx == 'x') ? 's' : 'S');
    2495:	80 7d e0 78          	cmp    BYTE PTR [ebp-0x20],0x78
    2499:	75 07                	jne    24a2 <print_stat+0xd3>
    249b:	b8 73 00 00 00       	mov    eax,0x73
    24a0:	eb 05                	jmp    24a7 <print_stat+0xd8>
    24a2:	b8 53 00 00 00       	mov    eax,0x53
    24a7:	88 45 e0             	mov    BYTE PTR [ebp-0x20],al
		if (m & S_IROTH)
    24aa:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    24ad:	83 e0 04             	and    eax,0x4
    24b0:	85 c0                	test   eax,eax
    24b2:	74 04                	je     24b8 <print_stat+0xe9>
				c_or = 'r';
    24b4:	c6 45 df 72          	mov    BYTE PTR [ebp-0x21],0x72
		if (m & S_IWOTH)
    24b8:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    24bb:	83 e0 02             	and    eax,0x2
    24be:	85 c0                	test   eax,eax
    24c0:	74 04                	je     24c6 <print_stat+0xf7>
				c_ow = 'w';
    24c2:	c6 45 de 77          	mov    BYTE PTR [ebp-0x22],0x77
		if (m & S_IXOTH)
    24c6:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    24c9:	83 e0 01             	and    eax,0x1
    24cc:	85 c0                	test   eax,eax
    24ce:	74 04                	je     24d4 <print_stat+0x105>
				c_ox = 'x';
    24d0:	c6 45 dd 78          	mov    BYTE PTR [ebp-0x23],0x78
		if (m & S_ISVTX) /* sticky bit */
    24d4:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    24d7:	25 00 02 00 00       	and    eax,0x200
    24dc:	85 c0                	test   eax,eax
    24de:	74 15                	je     24f5 <print_stat+0x126>
				c_ox = ((c_ox == 'x') ? 't' : 'T');
    24e0:	80 7d dd 78          	cmp    BYTE PTR [ebp-0x23],0x78
    24e4:	75 07                	jne    24ed <print_stat+0x11e>
    24e6:	b8 74 00 00 00       	mov    eax,0x74
    24eb:	eb 05                	jmp    24f2 <print_stat+0x123>
    24ed:	b8 54 00 00 00       	mov    eax,0x54
    24f2:	88 45 dd             	mov    BYTE PTR [ebp-0x23],al
		if (S_ISDIR(m))
    24f5:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    24f8:	25 00 f0 00 00       	and    eax,0xf000
    24fd:	3d 00 40 00 00       	cmp    eax,0x4000
    2502:	75 09                	jne    250d <print_stat+0x13e>
				c_tp = 'd';
    2504:	c6 45 e6 64          	mov    BYTE PTR [ebp-0x1a],0x64
    2508:	e9 82 00 00 00       	jmp    258f <print_stat+0x1c0>
		else if (S_ISLNK(m))
    250d:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2510:	25 00 f0 00 00       	and    eax,0xf000
    2515:	3d 00 a0 00 00       	cmp    eax,0xa000
    251a:	75 06                	jne    2522 <print_stat+0x153>
				c_tp = 'l';
    251c:	c6 45 e6 6c          	mov    BYTE PTR [ebp-0x1a],0x6c
    2520:	eb 6d                	jmp    258f <print_stat+0x1c0>
		else if (S_ISFIFO(m))
    2522:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2525:	25 00 f0 00 00       	and    eax,0xf000
    252a:	3d 00 10 00 00       	cmp    eax,0x1000
    252f:	75 06                	jne    2537 <print_stat+0x168>
				c_tp = 'p';
    2531:	c6 45 e6 70          	mov    BYTE PTR [ebp-0x1a],0x70
    2535:	eb 58                	jmp    258f <print_stat+0x1c0>
		else if (S_ISCHR(m))
    2537:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    253a:	25 00 f0 00 00       	and    eax,0xf000
    253f:	3d 00 20 00 00       	cmp    eax,0x2000
    2544:	75 06                	jne    254c <print_stat+0x17d>
				c_tp = 'c';
    2546:	c6 45 e6 63          	mov    BYTE PTR [ebp-0x1a],0x63
    254a:	eb 43                	jmp    258f <print_stat+0x1c0>
		else if (S_ISBLK(m))
    254c:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    254f:	25 00 f0 00 00       	and    eax,0xf000
    2554:	3d 00 60 00 00       	cmp    eax,0x6000
    2559:	75 06                	jne    2561 <print_stat+0x192>
				c_tp = 'b';
    255b:	c6 45 e6 62          	mov    BYTE PTR [ebp-0x1a],0x62
    255f:	eb 2e                	jmp    258f <print_stat+0x1c0>
		else if (S_ISSOCK(m))
    2561:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2564:	25 00 f0 00 00       	and    eax,0xf000
    2569:	3d 00 c0 00 00       	cmp    eax,0xc000
    256e:	75 06                	jne    2576 <print_stat+0x1a7>
				c_tp = 's';
    2570:	c6 45 e6 73          	mov    BYTE PTR [ebp-0x1a],0x73
    2574:	eb 19                	jmp    258f <print_stat+0x1c0>
		else if (S_ISREG(m))
    2576:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2579:	25 00 f0 00 00       	and    eax,0xf000
    257e:	3d 00 80 00 00       	cmp    eax,0x8000
    2583:	75 06                	jne    258b <print_stat+0x1bc>
				c_tp = '-';
    2585:	c6 45 e6 2d          	mov    BYTE PTR [ebp-0x1a],0x2d
    2589:	eb 04                	jmp    258f <print_stat+0x1c0>
		else
				c_tp = '?';
    258b:	c6 45 e6 3f          	mov    BYTE PTR [ebp-0x1a],0x3f
		/* -rw-r--r-- 1 dennis users 6728 Aug 29 19:32 prog.o */
		struct tm atime; char datstr[26];
		localtime_r(&in->in_stat.st_atim.tv_sec, &atime);
    258f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2592:	8d 50 44             	lea    edx,[eax+0x44]
    2595:	8d 45 b4             	lea    eax,[ebp-0x4c]
    2598:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    259c:	89 14 24             	mov    DWORD PTR [esp],edx
    259f:	e8 fc ff ff ff       	call   25a0 <print_stat+0x1d1>
		asctime_r(&atime, datstr);
    25a4:	8d 45 9a             	lea    eax,[ebp-0x66]
    25a7:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    25ab:	8d 45 b4             	lea    eax,[ebp-0x4c]
    25ae:	89 04 24             	mov    DWORD PTR [esp],eax
    25b1:	e8 fc ff ff ff       	call   25b2 <print_stat+0x1e3>
		/* reformat datstr TODO: strftime */
		/* old format: "Mon Aug 29 19:32:xy 2134 */
		strcpy(datstr, datstr + 4);
    25b6:	8d 45 9a             	lea    eax,[ebp-0x66]
    25b9:	83 c0 04             	add    eax,0x4
    25bc:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    25c0:	8d 45 9a             	lea    eax,[ebp-0x66]
    25c3:	89 04 24             	mov    DWORD PTR [esp],eax
    25c6:	e8 fc ff ff ff       	call   25c7 <print_stat+0x1f8>
		if (atime.tm_year != 115/*today.tm_year*/)
    25cb:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    25ce:	83 f8 73             	cmp    eax,0x73
    25d1:	74 18                	je     25eb <print_stat+0x21c>
				strcpy(datstr + 7, datstr + 15);
    25d3:	8d 55 9a             	lea    edx,[ebp-0x66]
    25d6:	83 c2 0f             	add    edx,0xf
    25d9:	8d 45 9a             	lea    eax,[ebp-0x66]
    25dc:	83 c0 07             	add    eax,0x7
    25df:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    25e3:	89 04 24             	mov    DWORD PTR [esp],eax
    25e6:	e8 fc ff ff ff       	call   25e7 <print_stat+0x218>
		datstr[12] = '\0';
    25eb:	c6 45 a6 00          	mov    BYTE PTR [ebp-0x5a],0x0
		printf("%c%c%c%c%c%c%c%c%c%c %*u %*u %*u %*u %s ", c_tp, c_ur,
						c_uw, c_ux, c_gr, c_gw, c_gx, c_or, c_ow, c_ox,
						cb, (uint32_t)in->in_stat.st_nlink, cu, (uint32_t)in->in_stat.st_uid,
						cg, (uint32_t)in->in_stat.st_gid, cs, (uint32_t)in->in_stat.st_size,
    25ef:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    25f2:	8b 50 30             	mov    edx,DWORD PTR [eax+0x30]
    25f5:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
		printf("%c%c%c%c%c%c%c%c%c%c %*u %*u %*u %*u %s ", c_tp, c_ur,
    25f8:	89 c6                	mov    esi,eax
						cg, (uint32_t)in->in_stat.st_gid, cs, (uint32_t)in->in_stat.st_size,
    25fa:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    25fd:	8b 48 20             	mov    ecx,DWORD PTR [eax+0x20]
						cb, (uint32_t)in->in_stat.st_nlink, cu, (uint32_t)in->in_stat.st_uid,
    2600:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2603:	8b 58 1c             	mov    ebx,DWORD PTR [eax+0x1c]
    2606:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2609:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    260c:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
		printf("%c%c%c%c%c%c%c%c%c%c %*u %*u %*u %*u %s ", c_tp, c_ur,
    260f:	89 45 94             	mov    DWORD PTR [ebp-0x6c],eax
    2612:	0f be 45 dd          	movsx  eax,BYTE PTR [ebp-0x23]
    2616:	89 45 90             	mov    DWORD PTR [ebp-0x70],eax
    2619:	0f be 7d de          	movsx  edi,BYTE PTR [ebp-0x22]
    261d:	89 7d 8c             	mov    DWORD PTR [ebp-0x74],edi
    2620:	0f be 55 df          	movsx  edx,BYTE PTR [ebp-0x21]
    2624:	89 55 88             	mov    DWORD PTR [ebp-0x78],edx
    2627:	0f be 7d e0          	movsx  edi,BYTE PTR [ebp-0x20]
    262b:	89 7d 84             	mov    DWORD PTR [ebp-0x7c],edi
    262e:	0f be 55 e1          	movsx  edx,BYTE PTR [ebp-0x1f]
    2632:	89 55 80             	mov    DWORD PTR [ebp-0x80],edx
    2635:	0f be 7d e2          	movsx  edi,BYTE PTR [ebp-0x1e]
    2639:	89 bd 7c ff ff ff    	mov    DWORD PTR [ebp-0x84],edi
    263f:	0f be 55 e3          	movsx  edx,BYTE PTR [ebp-0x1d]
    2643:	89 95 78 ff ff ff    	mov    DWORD PTR [ebp-0x88],edx
    2649:	0f be 7d e4          	movsx  edi,BYTE PTR [ebp-0x1c]
    264d:	89 bd 74 ff ff ff    	mov    DWORD PTR [ebp-0x8c],edi
    2653:	0f be 7d e5          	movsx  edi,BYTE PTR [ebp-0x1b]
    2657:	0f be 55 e6          	movsx  edx,BYTE PTR [ebp-0x1a]
    265b:	8d 45 9a             	lea    eax,[ebp-0x66]
    265e:	89 44 24 4c          	mov    DWORD PTR [esp+0x4c],eax
    2662:	89 74 24 48          	mov    DWORD PTR [esp+0x48],esi
    2666:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
    2669:	89 44 24 44          	mov    DWORD PTR [esp+0x44],eax
    266d:	89 4c 24 40          	mov    DWORD PTR [esp+0x40],ecx
    2671:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
    2674:	89 44 24 3c          	mov    DWORD PTR [esp+0x3c],eax
    2678:	89 5c 24 38          	mov    DWORD PTR [esp+0x38],ebx
    267c:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    267f:	89 44 24 34          	mov    DWORD PTR [esp+0x34],eax
    2683:	8b 75 94             	mov    esi,DWORD PTR [ebp-0x6c]
    2686:	89 74 24 30          	mov    DWORD PTR [esp+0x30],esi
    268a:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    268d:	89 44 24 2c          	mov    DWORD PTR [esp+0x2c],eax
    2691:	8b 45 90             	mov    eax,DWORD PTR [ebp-0x70]
    2694:	89 44 24 28          	mov    DWORD PTR [esp+0x28],eax
    2698:	8b 45 8c             	mov    eax,DWORD PTR [ebp-0x74]
    269b:	89 44 24 24          	mov    DWORD PTR [esp+0x24],eax
    269f:	8b 45 88             	mov    eax,DWORD PTR [ebp-0x78]
    26a2:	89 44 24 20          	mov    DWORD PTR [esp+0x20],eax
    26a6:	8b 45 84             	mov    eax,DWORD PTR [ebp-0x7c]
    26a9:	89 44 24 1c          	mov    DWORD PTR [esp+0x1c],eax
    26ad:	8b 45 80             	mov    eax,DWORD PTR [ebp-0x80]
    26b0:	89 44 24 18          	mov    DWORD PTR [esp+0x18],eax
    26b4:	8b 85 7c ff ff ff    	mov    eax,DWORD PTR [ebp-0x84]
    26ba:	89 44 24 14          	mov    DWORD PTR [esp+0x14],eax
    26be:	8b 85 78 ff ff ff    	mov    eax,DWORD PTR [ebp-0x88]
    26c4:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
    26c8:	8b 85 74 ff ff ff    	mov    eax,DWORD PTR [ebp-0x8c]
    26ce:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    26d2:	89 7c 24 08          	mov    DWORD PTR [esp+0x8],edi
    26d6:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    26da:	c7 04 24 fc 01 00 00 	mov    DWORD PTR [esp],0x1fc
    26e1:	e8 fc ff ff ff       	call   26e2 <print_stat+0x313>
						datstr);
		if (S_ISDIR(m)) {
    26e6:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    26e9:	25 00 f0 00 00       	and    eax,0xf000
    26ee:	3d 00 40 00 00       	cmp    eax,0x4000
    26f3:	75 4f                	jne    2744 <print_stat+0x375>
				fmt = LFMT_DIR;
    26f5:	c6 45 e7 09          	mov    BYTE PTR [ebp-0x19],0x9
				if ((m & S_ISVTX) && (m & S_IWOTH))
    26f9:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    26fc:	25 00 02 00 00       	and    eax,0x200
    2701:	85 c0                	test   eax,eax
    2703:	74 13                	je     2718 <print_stat+0x349>
    2705:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2708:	83 e0 02             	and    eax,0x2
    270b:	85 c0                	test   eax,eax
    270d:	74 09                	je     2718 <print_stat+0x349>
						fmt = LFMT_SWRT;
    270f:	c6 45 e7 20          	mov    BYTE PTR [ebp-0x19],0x20
    2713:	e9 04 01 00 00       	jmp    281c <print_stat+0x44d>
				else if (m & S_IWOTH)
    2718:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    271b:	83 e0 02             	and    eax,0x2
    271e:	85 c0                	test   eax,eax
    2720:	74 09                	je     272b <print_stat+0x35c>
						fmt = LFMT_OWRT;
    2722:	c6 45 e7 21          	mov    BYTE PTR [ebp-0x19],0x21
    2726:	e9 f1 00 00 00       	jmp    281c <print_stat+0x44d>
				else if (m & S_ISVTX)
    272b:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    272e:	25 00 02 00 00       	and    eax,0x200
    2733:	85 c0                	test   eax,eax
    2735:	0f 84 e1 00 00 00    	je     281c <print_stat+0x44d>
						fmt = LFMT_STCK;
    273b:	c6 45 e7 10          	mov    BYTE PTR [ebp-0x19],0x10
    273f:	e9 d8 00 00 00       	jmp    281c <print_stat+0x44d>
		} else if (S_ISREG(m)) {
    2744:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2747:	25 00 f0 00 00       	and    eax,0xf000
    274c:	3d 00 80 00 00       	cmp    eax,0x8000
    2751:	75 5c                	jne    27af <print_stat+0x3e0>
				if (m & S_ISUID)
    2753:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2756:	25 00 08 00 00       	and    eax,0x800
    275b:	85 c0                	test   eax,eax
    275d:	74 09                	je     2768 <print_stat+0x399>
						fmt = LFMT_SUID;
    275f:	c6 45 e7 4f          	mov    BYTE PTR [ebp-0x19],0x4f
    2763:	e9 b4 00 00 00       	jmp    281c <print_stat+0x44d>
				else if (m & S_ISGID)
    2768:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    276b:	25 00 04 00 00       	and    eax,0x400
    2770:	85 c0                	test   eax,eax
    2772:	74 09                	je     277d <print_stat+0x3ae>
						fmt = LFMT_SGID;
    2774:	c6 45 e7 e0          	mov    BYTE PTR [ebp-0x19],0xe0
    2778:	e9 9f 00 00 00       	jmp    281c <print_stat+0x44d>
				else if (m & S_IXUGO)
    277d:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2780:	83 e0 49             	and    eax,0x49
    2783:	85 c0                	test   eax,eax
    2785:	74 09                	je     2790 <print_stat+0x3c1>
						fmt = LFMT_EXEC;
    2787:	c6 45 e7 0a          	mov    BYTE PTR [ebp-0x19],0xa
    278b:	e9 8c 00 00 00       	jmp    281c <print_stat+0x44d>
				else if (in->in_stat.st_nlink > 1)
    2790:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2793:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    2796:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    2799:	bb 01 00 00 00       	mov    ebx,0x1
    279e:	b9 00 00 00 00       	mov    ecx,0x0
    27a3:	39 c3                	cmp    ebx,eax
    27a5:	19 d1                	sbb    ecx,edx
    27a7:	73 73                	jae    281c <print_stat+0x44d>
						fmt = LFMT_MH;
    27a9:	c6 45 e7 0f          	mov    BYTE PTR [ebp-0x19],0xf
    27ad:	eb 6d                	jmp    281c <print_stat+0x44d>
		} else if (S_ISLNK(m))
    27af:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    27b2:	25 00 f0 00 00       	and    eax,0xf000
    27b7:	3d 00 a0 00 00       	cmp    eax,0xa000
    27bc:	75 06                	jne    27c4 <print_stat+0x3f5>
				fmt = LFMT_LNK;
    27be:	c6 45 e7 0b          	mov    BYTE PTR [ebp-0x19],0xb
    27c2:	eb 58                	jmp    281c <print_stat+0x44d>
		else if (S_ISFIFO(m))
    27c4:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    27c7:	25 00 f0 00 00       	and    eax,0xf000
    27cc:	3d 00 10 00 00       	cmp    eax,0x1000
    27d1:	75 06                	jne    27d9 <print_stat+0x40a>
				fmt = LFMT_PIPE;
    27d3:	c6 45 e7 06          	mov    BYTE PTR [ebp-0x19],0x6
    27d7:	eb 43                	jmp    281c <print_stat+0x44d>
		else if (S_ISSOCK(m))
    27d9:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    27dc:	25 00 f0 00 00       	and    eax,0xf000
    27e1:	3d 00 c0 00 00       	cmp    eax,0xc000
    27e6:	75 06                	jne    27ee <print_stat+0x41f>
				fmt = LFMT_SOCK;
    27e8:	c6 45 e7 0d          	mov    BYTE PTR [ebp-0x19],0xd
    27ec:	eb 2e                	jmp    281c <print_stat+0x44d>
		else if (S_ISBLK(m))
    27ee:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    27f1:	25 00 f0 00 00       	and    eax,0xf000
    27f6:	3d 00 60 00 00       	cmp    eax,0x6000
    27fb:	75 06                	jne    2803 <print_stat+0x434>
				fmt = LFMT_BDEV;
    27fd:	c6 45 e7 0e          	mov    BYTE PTR [ebp-0x19],0xe
    2801:	eb 19                	jmp    281c <print_stat+0x44d>
		else if (S_ISCHR(m))
    2803:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2806:	25 00 f0 00 00       	and    eax,0xf000
    280b:	3d 00 20 00 00       	cmp    eax,0x2000
    2810:	75 06                	jne    2818 <print_stat+0x449>
				fmt = LFMT_CDEV;
    2812:	c6 45 e7 0e          	mov    BYTE PTR [ebp-0x19],0xe
    2816:	eb 04                	jmp    281c <print_stat+0x44d>
		/*else if (S_ISDOOR(m))
				fmt = LFMT_DOOR;*/
		else
				fmt = LFMT_ORPH;
    2818:	c6 45 e7 0f          	mov    BYTE PTR [ebp-0x19],0xf
		cprintf(fmt, "%s\n", fn);
    281c:	0f be 45 e7          	movsx  eax,BYTE PTR [ebp-0x19]
    2820:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2823:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    2827:	c7 44 24 04 25 02 00 00 	mov    DWORD PTR [esp+0x4],0x225
    282f:	89 04 24             	mov    DWORD PTR [esp],eax
    2832:	e8 fc ff ff ff       	call   2833 <print_stat+0x464>
}
    2837:	90                   	nop
    2838:	81 c4 dc 00 00 00    	add    esp,0xdc
    283e:	5b                   	pop    ebx
    283f:	5e                   	pop    esi
    2840:	5f                   	pop    edi
    2841:	5d                   	pop    ebp
    2842:	c3                   	ret

00002843 <path_lookup>:

struct inode* path_lookup(const char* str, char* tk, size_t ntk, int allow_partial)
{
    2843:	55                   	push   ebp
    2844:	89 e5                	mov    ebp,esp
    2846:	81 ec 48 01 00 00    	sub    esp,0x148
		static char pwd[260] = "/";
		static struct inode* in_pwd = NULL, *in = NULL, *in_prev = NULL;
		char buf[260], *ltk = "", *ctx, *tok;
    284c:	c7 45 f4 48 01 00 00 	mov    DWORD PTR [ebp-0xc],0x148
		if (!in_pwd)
    2853:	a1 38 28 00 00       	mov    eax,ds:0x2838
    2858:	85 c0                	test   eax,eax
    285a:	75 0a                	jne    2866 <path_lookup+0x23>
				in_pwd = in_root;
    285c:	a1 30 28 00 00       	mov    eax,ds:0x2830
    2861:	a3 38 28 00 00       	mov    ds:0x2838,eax
		/* navigate to path */
		strncpy(buf, str, 260);
    2866:	c7 44 24 08 04 01 00 00 	mov    DWORD PTR [esp+0x8],0x104
    286e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2871:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2875:	8d 85 e8 fe ff ff    	lea    eax,[ebp-0x118]
    287b:	89 04 24             	mov    DWORD PTR [esp],eax
    287e:	e8 fc ff ff ff       	call   287f <path_lookup+0x3c>
		buf[260] = '\0';
    2883:	c6 45 ec 00          	mov    BYTE PTR [ebp-0x14],0x0
		ltk = tok = strtok_r(buf, "/", &ctx);
    2887:	8d 85 e4 fe ff ff    	lea    eax,[ebp-0x11c]
    288d:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2891:	c7 44 24 04 29 02 00 00 	mov    DWORD PTR [esp+0x4],0x229
    2899:	8d 85 e8 fe ff ff    	lea    eax,[ebp-0x118]
    289f:	89 04 24             	mov    DWORD PTR [esp],eax
    28a2:	e8 fc ff ff ff       	call   28a3 <path_lookup+0x60>
    28a7:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    28aa:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    28ad:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		in = ((*str == '/') ? in_root : in_pwd); /* abs or rel */
    28b0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    28b3:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    28b6:	3c 2f                	cmp    al,0x2f
    28b8:	75 07                	jne    28c1 <path_lookup+0x7e>
    28ba:	a1 30 28 00 00       	mov    eax,ds:0x2830
    28bf:	eb 05                	jmp    28c6 <path_lookup+0x83>
    28c1:	a1 38 28 00 00       	mov    eax,ds:0x2838
    28c6:	a3 3c 28 00 00       	mov    ds:0x283c,eax
		in_prev = in;
    28cb:	a1 3c 28 00 00       	mov    eax,ds:0x283c
    28d0:	a3 40 28 00 00       	mov    ds:0x2840,eax
		while (tok) {
    28d5:	e9 22 01 00 00       	jmp    29fc <path_lookup+0x1b9>
				const struct device_desc* dd;
				dd = get_device(in->in_stat.st_dev);
    28da:	a1 3c 28 00 00       	mov    eax,ds:0x283c
    28df:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    28e2:	8b 00                	mov    eax,DWORD PTR [eax]
    28e4:	89 04 24             	mov    DWORD PTR [esp],eax
    28e7:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    28eb:	e8 fc ff ff ff       	call   28ec <path_lookup+0xa9>
    28f0:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				if (!dd) {
    28f3:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    28f7:	75 3d                	jne    2936 <path_lookup+0xf3>
						cprintf(KFMT_WARN, "unable to explore node "
    28f9:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
							"%s at associated device %u is not registered. errno=%d\n",
							tok, (uint32_t)in->in_stat.st_dev, errno);
    28ff:	a1 3c 28 00 00       	mov    eax,ds:0x283c
    2904:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    2907:	8b 00                	mov    eax,DWORD PTR [eax]
						cprintf(KFMT_WARN, "unable to explore node "
    2909:	89 4c 24 10          	mov    DWORD PTR [esp+0x10],ecx
    290d:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    2911:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2914:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2918:	c7 44 24 04 2c 02 00 00 	mov    DWORD PTR [esp+0x4],0x22c
    2920:	c7 04 24 0e 00 00 00 	mov    DWORD PTR [esp],0xe
    2927:	e8 fc ff ff ff       	call   2928 <path_lookup+0xe5>
						return NULL;
    292c:	b8 00 00 00 00       	mov    eax,0x0
    2931:	e9 02 01 00 00       	jmp    2a38 <path_lookup+0x1f5>
				}
				ltk = tok;
    2936:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2939:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				in = dd->fn_get_subnode(in, tok);
    293c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    293f:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
    2942:	8b 15 3c 28 00 00    	mov    edx,DWORD PTR ds:0x283c
    2948:	8b 4d f0             	mov    ecx,DWORD PTR [ebp-0x10]
    294b:	89 4c 24 04          	mov    DWORD PTR [esp+0x4],ecx
    294f:	89 14 24             	mov    DWORD PTR [esp],edx
    2952:	ff d0                	call   eax
    2954:	a3 3c 28 00 00       	mov    ds:0x283c,eax
				if (!in) {
    2959:	a1 3c 28 00 00       	mov    eax,ds:0x283c
    295e:	85 c0                	test   eax,eax
    2960:	75 6f                	jne    29d1 <path_lookup+0x18e>
						if (!allow_partial)
    2962:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
    2966:	75 35                	jne    299d <path_lookup+0x15a>
								cprintf(KFMT_WARN, "Failed to locate subnode %s"
    2968:	a1 00 00 00 00       	mov    eax,ds:0x0
    296d:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
    2971:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2974:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    2978:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    297b:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    297f:	c7 44 24 04 7c 02 00 00 	mov    DWORD PTR [esp+0x4],0x27c
    2987:	c7 04 24 0e 00 00 00 	mov    DWORD PTR [esp],0xe
    298e:	e8 fc ff ff ff       	call   298f <path_lookup+0x14c>
										strncpy(tk, ltk, ntk);
										tk[ntk - 1] = '\0';
								}
								return in_prev;
						}
						return NULL;
    2993:	b8 00 00 00 00       	mov    eax,0x0
    2998:	e9 9b 00 00 00       	jmp    2a38 <path_lookup+0x1f5>
								if (tk) {
    299d:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
    29a1:	74 27                	je     29ca <path_lookup+0x187>
										strncpy(tk, ltk, ntk);
    29a3:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    29a6:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    29aa:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    29ad:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    29b1:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    29b4:	89 04 24             	mov    DWORD PTR [esp],eax
    29b7:	e8 fc ff ff ff       	call   29b8 <path_lookup+0x175>
										tk[ntk - 1] = '\0';
    29bc:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    29bf:	8d 50 ff             	lea    edx,[eax-0x1]
    29c2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    29c5:	01 d0                	add    eax,edx
    29c7:	c6 00 00             	mov    BYTE PTR [eax],0x0
								return in_prev;
    29ca:	a1 40 28 00 00       	mov    eax,ds:0x2840
    29cf:	eb 67                	jmp    2a38 <path_lookup+0x1f5>
				} else {
						in_prev = in;
    29d1:	a1 3c 28 00 00       	mov    eax,ds:0x283c
    29d6:	a3 40 28 00 00       	mov    ds:0x2840,eax
				}
				tok = strtok_r(NULL, "/", &ctx);
    29db:	8d 85 e4 fe ff ff    	lea    eax,[ebp-0x11c]
    29e1:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    29e5:	c7 44 24 04 29 02 00 00 	mov    DWORD PTR [esp+0x4],0x229
    29ed:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    29f4:	e8 fc ff ff ff       	call   29f5 <path_lookup+0x1b2>
    29f9:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		while (tok) {
    29fc:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    2a00:	0f 85 d4 fe ff ff    	jne    28da <path_lookup+0x97>
		}
		if (tk) {
    2a06:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
    2a0a:	74 27                	je     2a33 <path_lookup+0x1f0>
				strncpy(tk, ltk, ntk);
    2a0c:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    2a0f:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2a13:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2a16:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2a1a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2a1d:	89 04 24             	mov    DWORD PTR [esp],eax
    2a20:	e8 fc ff ff ff       	call   2a21 <path_lookup+0x1de>
				tk[ntk - 1] = '\0';
    2a25:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    2a28:	8d 50 ff             	lea    edx,[eax-0x1]
    2a2b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2a2e:	01 d0                	add    eax,edx
    2a30:	c6 00 00             	mov    BYTE PTR [eax],0x0
		}
		return in;
    2a33:	a1 3c 28 00 00       	mov    eax,ds:0x283c
}
    2a38:	c9                   	leave
    2a39:	c3                   	ret

00002a3a <fcli_ls>:

int fcli_ls(const char* str)
{
    2a3a:	55                   	push   ebp
    2a3b:	89 e5                	mov    ebp,esp
    2a3d:	53                   	push   ebx
    2a3e:	81 ec 34 01 00 00    	sub    esp,0x134
		struct inode* in = NULL; char ltk[40];
    2a44:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [ebp-0x28],0x0
		/* ls-like commands */
		str += 3;
    2a4b:	83 45 08 03          	add    DWORD PTR [ebp+0x8],0x3
		/* navigate to path */
		in = path_lookup(str, ltk, sizeof(ltk), 0);
    2a4f:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    2a57:	c7 44 24 08 28 00 00 00 	mov    DWORD PTR [esp+0x8],0x28
    2a5f:	8d 45 90             	lea    eax,[ebp-0x70]
    2a62:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2a66:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2a69:	89 04 24             	mov    DWORD PTR [esp],eax
    2a6c:	e8 fc ff ff ff       	call   2a6d <fcli_ls+0x33>
    2a71:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
		if (!in)
    2a74:	83 7d d8 00          	cmp    DWORD PTR [ebp-0x28],0x0
    2a78:	75 0a                	jne    2a84 <fcli_ls+0x4a>
				return 1;
    2a7a:	b8 01 00 00 00       	mov    eax,0x1
    2a7f:	e9 92 04 00 00       	jmp    2f16 <fcli_ls+0x4dc>
		/* now do the lookup (default to ls -l) */
		if (S_ISDIR(in->in_stat.st_mode)) {
    2a84:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2a87:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    2a8a:	25 00 f0 00 00       	and    eax,0xf000
    2a8f:	3d 00 40 00 00       	cmp    eax,0x4000
    2a94:	0f 85 45 04 00 00    	jne    2edf <fcli_ls+0x4a5>
				const struct device_desc* dd; int fd;
				/* max and sum of blocks, size, user, gid */
				size_t mb = 0, ms = 0, mu = 0, mg = 0, sb = 0, ss = 0;
    2a9a:	c7 45 8c 00 00 00 00 	mov    DWORD PTR [ebp-0x74],0x0
    2aa1:	c7 45 88 00 00 00 00 	mov    DWORD PTR [ebp-0x78],0x0
    2aa8:	c7 45 84 00 00 00 00 	mov    DWORD PTR [ebp-0x7c],0x0
    2aaf:	c7 45 80 00 00 00 00 	mov    DWORD PTR [ebp-0x80],0x0
    2ab6:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    2abd:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
				char buf[128]; size_t nr; int frst = 1;
    2ac4:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [ebp-0x14],0x1

				/* open directory for reading */
				dd = get_device(in->in_stat.st_dev);
    2acb:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2ace:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    2ad1:	8b 00                	mov    eax,DWORD PTR [eax]
    2ad3:	89 04 24             	mov    DWORD PTR [esp],eax
    2ad6:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    2ada:	e8 fc ff ff ff       	call   2adb <fcli_ls+0xa1>
    2adf:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				if (!dd) {
    2ae2:	83 7d d4 00          	cmp    DWORD PTR [ebp-0x2c],0x0
    2ae6:	75 22                	jne    2b0a <fcli_ls+0xd0>
						printf("unable to obtain device %u associated"
							" with the directory\n", (uint32_t)in->in_stat.st_dev);
    2ae8:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2aeb:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    2aee:	8b 00                	mov    eax,DWORD PTR [eax]
						printf("unable to obtain device %u associated"
    2af0:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2af4:	c7 04 24 b0 02 00 00 	mov    DWORD PTR [esp],0x2b0
    2afb:	e8 fc ff ff ff       	call   2afc <fcli_ls+0xc2>
						return 1;
    2b00:	b8 01 00 00 00       	mov    eax,0x1
    2b05:	e9 0c 04 00 00       	jmp    2f16 <fcli_ls+0x4dc>
				}
				fd = dd->fn_open(in, O_RDONLY);
    2b0a:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    2b0d:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    2b10:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    2b18:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    2b1b:	89 14 24             	mov    DWORD PTR [esp],edx
    2b1e:	ff d0                	call   eax
    2b20:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
				if (fd == -1) {
    2b23:	83 7d d0 ff          	cmp    DWORD PTR [ebp-0x30],0xffffffff
    2b27:	74 03                	je     2b2c <fcli_ls+0xf2>
						printf("unable to access directory for reading: errno=%d\n", errno);
						return 1;
				}
				/* now read the data */
Pos0:
    2b29:	90                   	nop
    2b2a:	eb 1f                	jmp    2b4b <fcli_ls+0x111>
						printf("unable to access directory for reading: errno=%d\n", errno);
    2b2c:	a1 00 00 00 00       	mov    eax,ds:0x0
    2b31:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2b35:	c7 04 24 ec 02 00 00 	mov    DWORD PTR [esp],0x2ec
    2b3c:	e8 fc ff ff ff       	call   2b3d <fcli_ls+0x103>
						return 1;
    2b41:	b8 01 00 00 00       	mov    eax,0x1
    2b46:	e9 cb 03 00 00       	jmp    2f16 <fcli_ls+0x4dc>
				if (!frst) {
    2b4b:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    2b4f:	0f 85 d6 00 00 00    	jne    2c2b <fcli_ls+0x1f1>
						size_t im; size_t* arr[] = { &mb, &ms, &mu, &mg };
    2b55:	8d 45 8c             	lea    eax,[ebp-0x74]
    2b58:	89 85 70 ff ff ff    	mov    DWORD PTR [ebp-0x90],eax
    2b5e:	8d 45 88             	lea    eax,[ebp-0x78]
    2b61:	89 85 74 ff ff ff    	mov    DWORD PTR [ebp-0x8c],eax
    2b67:	8d 45 84             	lea    eax,[ebp-0x7c]
    2b6a:	89 85 78 ff ff ff    	mov    DWORD PTR [ebp-0x88],eax
    2b70:	8d 45 80             	lea    eax,[ebp-0x80]
    2b73:	89 85 7c ff ff ff    	mov    DWORD PTR [ebp-0x84],eax
						/* calculate the capacites */
						for (size_t** p = &arr[0]; p <= &arr[3]; p++) {
    2b79:	8d 85 70 ff ff ff    	lea    eax,[ebp-0x90]
    2b7f:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    2b82:	eb 3d                	jmp    2bc1 <fcli_ls+0x187>
								im = 1;
    2b84:	c7 45 e8 01 00 00 00 	mov    DWORD PTR [ebp-0x18],0x1
								while ((**p /= 10))
    2b8b:	eb 04                	jmp    2b91 <fcli_ls+0x157>
										im++;
    2b8d:	83 45 e8 01          	add    DWORD PTR [ebp-0x18],0x1
								while ((**p /= 10))
    2b91:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2b94:	8b 00                	mov    eax,DWORD PTR [eax]
    2b96:	8b 10                	mov    edx,DWORD PTR [eax]
    2b98:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2b9b:	8b 08                	mov    ecx,DWORD PTR [eax]
    2b9d:	bb cd cc cc cc       	mov    ebx,0xcccccccd
    2ba2:	89 d0                	mov    eax,edx
    2ba4:	f7 e3                	mul    ebx
    2ba6:	89 d0                	mov    eax,edx
    2ba8:	c1 e8 03             	shr    eax,0x3
    2bab:	89 01                	mov    DWORD PTR [ecx],eax
    2bad:	8b 01                	mov    eax,DWORD PTR [ecx]
    2baf:	85 c0                	test   eax,eax
    2bb1:	75 da                	jne    2b8d <fcli_ls+0x153>
								**p = im;
    2bb3:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2bb6:	8b 00                	mov    eax,DWORD PTR [eax]
    2bb8:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    2bbb:	89 10                	mov    DWORD PTR [eax],edx
						for (size_t** p = &arr[0]; p <= &arr[3]; p++) {
    2bbd:	83 45 e4 04          	add    DWORD PTR [ebp-0x1c],0x4
    2bc1:	8d 85 70 ff ff ff    	lea    eax,[ebp-0x90]
    2bc7:	83 c0 0c             	add    eax,0xc
    2bca:	3b 45 e4             	cmp    eax,DWORD PTR [ebp-0x1c]
    2bcd:	73 b5                	jae    2b84 <fcli_ls+0x14a>
						}
						if (dd->fn_lseek(in, fd, 0, SEEK_SET) != 0) {
    2bcf:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    2bd2:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    2bd5:	c7 44 24 10 00 00 00 00 	mov    DWORD PTR [esp+0x10],0x0
    2bdd:	c7 44 24 08 00 00 00 00 	mov    DWORD PTR [esp+0x8],0x0
    2be5:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    2bed:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    2bf0:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    2bf4:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    2bf7:	89 14 24             	mov    DWORD PTR [esp],edx
    2bfa:	ff d0                	call   eax
    2bfc:	89 c1                	mov    ecx,eax
    2bfe:	89 c8                	mov    eax,ecx
    2c00:	09 d0                	or     eax,edx
    2c02:	74 27                	je     2c2b <fcli_ls+0x1f1>
								cprintf(KFMT_ERROR, "failed to seek to start"
    2c04:	a1 00 00 00 00       	mov    eax,ds:0x0
    2c09:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2c0d:	c7 44 24 04 20 03 00 00 	mov    DWORD PTR [esp+0x4],0x320
    2c15:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    2c1c:	e8 fc ff ff ff       	call   2c1d <fcli_ls+0x1e3>
									" of directory file. errno=%d\n", errno);
								return 1;
    2c21:	b8 01 00 00 00       	mov    eax,0x1
						return 1;
    2c26:	e9 eb 02 00 00       	jmp    2f16 <fcli_ls+0x4dc>
						}
				}
				do {
						char* fn = buf, *fn_prev; size_t s;
    2c2b:	8d 85 f0 fe ff ff    	lea    eax,[ebp-0x110]
    2c31:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
						nr = dd->fn_read(in, fd, buf, sizeof(buf) - 1);
    2c34:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    2c37:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    2c3a:	c7 44 24 0c 7f 00 00 00 	mov    DWORD PTR [esp+0xc],0x7f
    2c42:	8d 95 f0 fe ff ff    	lea    edx,[ebp-0x110]
    2c48:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    2c4c:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    2c4f:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    2c53:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    2c56:	89 14 24             	mov    DWORD PTR [esp],edx
    2c59:	ff d0                	call   eax
    2c5b:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
						buf[nr] = '\0';
    2c5e:	8d 95 f0 fe ff ff    	lea    edx,[ebp-0x110]
    2c64:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    2c67:	01 d0                	add    eax,edx
    2c69:	c6 00 00             	mov    BYTE PTR [eax],0x0
						while ((s = strlen(fn))) {
    2c6c:	e9 e5 01 00 00       	jmp    2e56 <fcli_ls+0x41c>
								struct inode* in1;
Pos1:
								if (fn + s + 1 + sizeof(struct inode*) > buf + sizeof(buf)) {
    2c71:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2c74:	8d 50 05             	lea    edx,[eax+0x5]
    2c77:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    2c7a:	01 c2                	add    edx,eax
    2c7c:	8d 85 f0 fe ff ff    	lea    eax,[ebp-0x110]
    2c82:	83 e8 80             	sub    eax,0xffffff80
    2c85:	39 d0                	cmp    eax,edx
    2c87:	0f 83 be 00 00 00    	jae    2d4b <fcli_ls+0x311>
										/* data spans, try lseek */
										off_t sk = sizeof(buf) - (fn - buf);
    2c8d:	8d 85 f0 fe ff ff    	lea    eax,[ebp-0x110]
    2c93:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    2c96:	29 c2                	sub    edx,eax
    2c98:	b8 80 00 00 00       	mov    eax,0x80
    2c9d:	29 d0                	sub    eax,edx
    2c9f:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
    2ca2:	c7 45 bc 00 00 00 00 	mov    DWORD PTR [ebp-0x44],0x0
										if (sk == -sizeof(buf)) {
    2ca9:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    2cac:	83 f0 80             	xor    eax,0xffffff80
    2caf:	0b 45 bc             	or     eax,DWORD PTR [ebp-0x44]
    2cb2:	75 1e                	jne    2cd2 <fcli_ls+0x298>
												cprintf(KFMT_ERROR, "fn too long for intermediate buffer\n");
    2cb4:	c7 44 24 04 58 03 00 00 	mov    DWORD PTR [esp+0x4],0x358
    2cbc:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    2cc3:	e8 fc ff ff ff       	call   2cc4 <fcli_ls+0x28a>
												return 1;
    2cc8:	b8 01 00 00 00       	mov    eax,0x1
    2ccd:	e9 44 02 00 00       	jmp    2f16 <fcli_ls+0x4dc>
										}
										if (-1 == dd->fn_lseek(in, fd, sk, SEEK_CUR)) {
    2cd2:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    2cd5:	8b 48 1c             	mov    ecx,DWORD PTR [eax+0x1c]
    2cd8:	c7 44 24 10 01 00 00 00 	mov    DWORD PTR [esp+0x10],0x1
    2ce0:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    2ce3:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
    2ce6:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2cea:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    2cee:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    2cf1:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2cf5:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2cf8:	89 04 24             	mov    DWORD PTR [esp],eax
    2cfb:	ff d1                	call   ecx
    2cfd:	89 c1                	mov    ecx,eax
    2cff:	89 d0                	mov    eax,edx
    2d01:	21 c8                	and    eax,ecx
    2d03:	83 f8 ff             	cmp    eax,0xffffffff
    2d06:	75 27                	jne    2d2f <fcli_ls+0x2f5>
												cprintf(KFMT_WARN, "unable to seek on directory file for ls. errno=%d\n", errno);
    2d08:	a1 00 00 00 00       	mov    eax,ds:0x0
    2d0d:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2d11:	c7 44 24 04 80 03 00 00 	mov    DWORD PTR [esp+0x4],0x380
    2d19:	c7 04 24 0e 00 00 00 	mov    DWORD PTR [esp],0xe
    2d20:	e8 fc ff ff ff       	call   2d21 <fcli_ls+0x2e7>
												return 1;
    2d25:	b8 01 00 00 00       	mov    eax,0x1
    2d2a:	e9 e7 01 00 00       	jmp    2f16 <fcli_ls+0x4dc>
										}
										fn = buf;
    2d2f:	8d 85 f0 fe ff ff    	lea    eax,[ebp-0x110]
    2d35:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
										s = strlen(fn);
    2d38:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    2d3b:	89 04 24             	mov    DWORD PTR [esp],eax
    2d3e:	e8 fc ff ff ff       	call   2d3f <fcli_ls+0x305>
    2d43:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
										goto Pos1;
    2d46:	e9 26 ff ff ff       	jmp    2c71 <fcli_ls+0x237>
								}
								fn_prev = fn;
    2d4b:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    2d4e:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
								fn += s + 1;
    2d51:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2d54:	83 c0 01             	add    eax,0x1
    2d57:	01 45 e0             	add    DWORD PTR [ebp-0x20],eax
								in1 = *(struct inode**)fn;
    2d5a:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    2d5d:	8b 00                	mov    eax,DWORD PTR [eax]
    2d5f:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
								fn += sizeof(struct inode*);
    2d62:	83 45 e0 04          	add    DWORD PTR [ebp-0x20],0x4
								if (!in1) {
    2d66:	83 7d c4 00          	cmp    DWORD PTR [ebp-0x3c],0x0
    2d6a:	75 20                	jne    2d8c <fcli_ls+0x352>
										cprintf(KFMT_WARN, "inode of %s missing\n", fn_prev);
    2d6c:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2d6f:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2d73:	c7 44 24 04 b3 03 00 00 	mov    DWORD PTR [esp+0x4],0x3b3
    2d7b:	c7 04 24 0e 00 00 00 	mov    DWORD PTR [esp],0xe
    2d82:	e8 fc ff ff ff       	call   2d83 <fcli_ls+0x349>
    2d87:	e9 ca 00 00 00       	jmp    2e56 <fcli_ls+0x41c>
								} else if (frst) {
    2d8c:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    2d90:	0f 84 8c 00 00 00    	je     2e22 <fcli_ls+0x3e8>
										if (in1->in_stat.st_nlink > mb)
    2d96:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2d99:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    2d9c:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    2d9f:	8b 4d 8c             	mov    ecx,DWORD PTR [ebp-0x74]
    2da2:	bb 00 00 00 00       	mov    ebx,0x0
    2da7:	39 c1                	cmp    ecx,eax
    2da9:	19 d3                	sbb    ebx,edx
    2dab:	73 0c                	jae    2db9 <fcli_ls+0x37f>
												mb = in1->in_stat.st_nlink;
    2dad:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2db0:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    2db3:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    2db6:	89 45 8c             	mov    DWORD PTR [ebp-0x74],eax
										if (in1->in_stat.st_size > ms)
    2db9:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2dbc:	8b 50 30             	mov    edx,DWORD PTR [eax+0x30]
    2dbf:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    2dc2:	8b 4d 88             	mov    ecx,DWORD PTR [ebp-0x78]
    2dc5:	bb 00 00 00 00       	mov    ebx,0x0
    2dca:	39 c1                	cmp    ecx,eax
    2dcc:	19 d3                	sbb    ebx,edx
    2dce:	7d 0c                	jge    2ddc <fcli_ls+0x3a2>
												ms = in1->in_stat.st_size;
    2dd0:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2dd3:	8b 50 30             	mov    edx,DWORD PTR [eax+0x30]
    2dd6:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    2dd9:	89 45 88             	mov    DWORD PTR [ebp-0x78],eax
										if (in1->in_stat.st_uid > mu)
    2ddc:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2ddf:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    2de2:	8b 55 84             	mov    edx,DWORD PTR [ebp-0x7c]
    2de5:	39 c2                	cmp    edx,eax
    2de7:	73 09                	jae    2df2 <fcli_ls+0x3b8>
												mu = in1->in_stat.st_uid;
    2de9:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2dec:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    2def:	89 45 84             	mov    DWORD PTR [ebp-0x7c],eax
										if (in1->in_stat.st_gid > mg)
    2df2:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2df5:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    2df8:	8b 55 80             	mov    edx,DWORD PTR [ebp-0x80]
    2dfb:	39 c2                	cmp    edx,eax
    2dfd:	73 09                	jae    2e08 <fcli_ls+0x3ce>
												mg = in1->in_stat.st_gid;
    2dff:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2e02:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    2e05:	89 45 80             	mov    DWORD PTR [ebp-0x80],eax
										sb += in1->in_stat.st_blocks;
    2e08:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2e0b:	8b 50 40             	mov    edx,DWORD PTR [eax+0x40]
    2e0e:	8b 40 3c             	mov    eax,DWORD PTR [eax+0x3c]
    2e11:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
										ss += in1->in_stat.st_size;
    2e14:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2e17:	8b 50 30             	mov    edx,DWORD PTR [eax+0x30]
    2e1a:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    2e1d:	01 45 f0             	add    DWORD PTR [ebp-0x10],eax
    2e20:	eb 34                	jmp    2e56 <fcli_ls+0x41c>
								} else {
										/* do the printing */
										print_stat(in1, fn_prev, mb, mu, mg, ms);
    2e22:	8b 45 88             	mov    eax,DWORD PTR [ebp-0x78]
    2e25:	89 c3                	mov    ebx,eax
    2e27:	8b 45 80             	mov    eax,DWORD PTR [ebp-0x80]
    2e2a:	89 c1                	mov    ecx,eax
    2e2c:	8b 45 84             	mov    eax,DWORD PTR [ebp-0x7c]
    2e2f:	89 c2                	mov    edx,eax
    2e31:	8b 45 8c             	mov    eax,DWORD PTR [ebp-0x74]
    2e34:	89 5c 24 14          	mov    DWORD PTR [esp+0x14],ebx
    2e38:	89 4c 24 10          	mov    DWORD PTR [esp+0x10],ecx
    2e3c:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    2e40:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2e44:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2e47:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2e4b:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2e4e:	89 04 24             	mov    DWORD PTR [esp],eax
    2e51:	e8 fc ff ff ff       	call   2e52 <fcli_ls+0x418>
						while ((s = strlen(fn))) {
    2e56:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    2e59:	89 04 24             	mov    DWORD PTR [esp],eax
    2e5c:	e8 fc ff ff ff       	call   2e5d <fcli_ls+0x423>
    2e61:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    2e64:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
    2e68:	74 06                	je     2e70 <fcli_ls+0x436>
Pos1:
    2e6a:	90                   	nop
    2e6b:	e9 01 fe ff ff       	jmp    2c71 <fcli_ls+0x237>
								}
						}
				} while (nr);
    2e70:	83 7d cc 00          	cmp    DWORD PTR [ebp-0x34],0x0
    2e74:	0f 85 b1 fd ff ff    	jne    2c2b <fcli_ls+0x1f1>
				if (frst) {
    2e7a:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    2e7e:	74 1f                	je     2e9f <fcli_ls+0x465>
						printf("total %lu\n", sb);
    2e80:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2e83:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2e87:	c7 04 24 c8 03 00 00 	mov    DWORD PTR [esp],0x3c8
    2e8e:	e8 fc ff ff ff       	call   2e8f <fcli_ls+0x455>
						frst = 0;
    2e93:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
						goto Pos0;
    2e9a:	e9 ac fc ff ff       	jmp    2b4b <fcli_ls+0x111>
				}
				/* TODO: use dirent to not pollute space */
				if (-1 == dd->fn_close(in, fd)) {
    2e9f:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    2ea2:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    2ea5:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    2ea8:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    2eac:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    2eaf:	89 14 24             	mov    DWORD PTR [esp],edx
    2eb2:	ff d0                	call   eax
    2eb4:	83 f8 ff             	cmp    eax,0xffffffff
    2eb7:	75 58                	jne    2f11 <fcli_ls+0x4d7>
						cprintf(KFMT_WARN, "failed to close fd %d to"
    2eb9:	a1 00 00 00 00       	mov    eax,ds:0x0
    2ebe:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    2ec2:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    2ec5:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2ec9:	c7 44 24 04 d4 03 00 00 	mov    DWORD PTR [esp+0x4],0x3d4
    2ed1:	c7 04 24 0e 00 00 00 	mov    DWORD PTR [esp],0xe
    2ed8:	e8 fc ff ff ff       	call   2ed9 <fcli_ls+0x49f>
    2edd:	eb 32                	jmp    2f11 <fcli_ls+0x4d7>
							" directory file open for reading. errno=%d\n", fd, errno);
				}
		} else
			   print_stat(in, ltk, 0, 0, 0, 0);
    2edf:	c7 44 24 14 00 00 00 00 	mov    DWORD PTR [esp+0x14],0x0
    2ee7:	c7 44 24 10 00 00 00 00 	mov    DWORD PTR [esp+0x10],0x0
    2eef:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    2ef7:	c7 44 24 08 00 00 00 00 	mov    DWORD PTR [esp+0x8],0x0
    2eff:	8d 45 90             	lea    eax,[ebp-0x70]
    2f02:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2f06:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2f09:	89 04 24             	mov    DWORD PTR [esp],eax
    2f0c:	e8 fc ff ff ff       	call   2f0d <fcli_ls+0x4d3>
		return 1;
    2f11:	b8 01 00 00 00       	mov    eax,0x1
}
    2f16:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    2f19:	c9                   	leave
    2f1a:	c3                   	ret

00002f1b <fcli_cat>:

int fcli_cat(const char* str)
{
    2f1b:	55                   	push   ebp
    2f1c:	89 e5                	mov    ebp,esp
    2f1e:	81 ec 98 00 00 00    	sub    esp,0x98
		struct inode* in = NULL; char ltk[40];
    2f24:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
		/* cat-like commands */
		str += 4;
    2f2b:	83 45 08 04          	add    DWORD PTR [ebp+0x8],0x4
		/* navigate to path */
		in = path_lookup(str, ltk, sizeof(ltk), 0);
    2f2f:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    2f37:	c7 44 24 08 28 00 00 00 	mov    DWORD PTR [esp+0x8],0x28
    2f3f:	8d 45 bc             	lea    eax,[ebp-0x44]
    2f42:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2f46:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2f49:	89 04 24             	mov    DWORD PTR [esp],eax
    2f4c:	e8 fc ff ff ff       	call   2f4d <fcli_cat+0x32>
    2f51:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		if (!in)
    2f54:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    2f58:	75 0a                	jne    2f64 <fcli_cat+0x49>
				return 1;
    2f5a:	b8 01 00 00 00       	mov    eax,0x1
    2f5f:	e9 68 01 00 00       	jmp    30cc <fcli_cat+0x1b1>

		/* read the file */
		const struct device_desc* dd; int fd; size_t nr;
		dd = get_device(in->in_stat.st_dev);
    2f64:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2f67:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    2f6a:	8b 00                	mov    eax,DWORD PTR [eax]
    2f6c:	89 04 24             	mov    DWORD PTR [esp],eax
    2f6f:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    2f73:	e8 fc ff ff ff       	call   2f74 <fcli_cat+0x59>
    2f78:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		if (!dd) {
    2f7b:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    2f7f:	75 1f                	jne    2fa0 <fcli_cat+0x85>
				printf("device error: errno=%d\n", errno);
    2f81:	a1 00 00 00 00       	mov    eax,ds:0x0
    2f86:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2f8a:	c7 04 24 18 04 00 00 	mov    DWORD PTR [esp],0x418
    2f91:	e8 fc ff ff ff       	call   2f92 <fcli_cat+0x77>
				return 1;
    2f96:	b8 01 00 00 00       	mov    eax,0x1
    2f9b:	e9 2c 01 00 00       	jmp    30cc <fcli_cat+0x1b1>
		}
		fd = dd->fn_open(in, O_RDONLY);
    2fa0:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2fa3:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    2fa6:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    2fae:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    2fb1:	89 14 24             	mov    DWORD PTR [esp],edx
    2fb4:	ff d0                	call   eax
    2fb6:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		if (fd == -1) {
    2fb9:	83 7d e8 ff          	cmp    DWORD PTR [ebp-0x18],0xffffffff
    2fbd:	75 1d                	jne    2fdc <fcli_cat+0xc1>
				printf("cannot open file %s\n", str);
    2fbf:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2fc2:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2fc6:	c7 04 24 30 04 00 00 	mov    DWORD PTR [esp],0x430
    2fcd:	e8 fc ff ff ff       	call   2fce <fcli_cat+0xb3>
				return 1;
    2fd2:	b8 01 00 00 00       	mov    eax,0x1
    2fd7:	e9 f0 00 00 00       	jmp    30cc <fcli_cat+0x1b1>
		}
		printf("cat: size=%lld\n", in->in_stat.st_size);
    2fdc:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2fdf:	8b 50 30             	mov    edx,DWORD PTR [eax+0x30]
    2fe2:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    2fe5:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2fe9:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    2fed:	c7 04 24 45 04 00 00 	mov    DWORD PTR [esp],0x445
    2ff4:	e8 fc ff ff ff       	call   2ff5 <fcli_cat+0xda>
		do {
				char buf[61];
				nr = dd->fn_read(in, fd, buf, sizeof(buf) - 1);
    2ff9:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2ffc:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    2fff:	c7 44 24 0c 3c 00 00 00 	mov    DWORD PTR [esp+0xc],0x3c
    3007:	8d 95 7f ff ff ff    	lea    edx,[ebp-0x81]
    300d:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    3011:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    3014:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    3018:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    301b:	89 14 24             	mov    DWORD PTR [esp],edx
    301e:	ff d0                	call   eax
    3020:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				buf[nr] = '\0';
    3023:	8d 95 7f ff ff ff    	lea    edx,[ebp-0x81]
    3029:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    302c:	01 d0                	add    eax,edx
    302e:	c6 00 00             	mov    BYTE PTR [eax],0x0
				if (nr) {
    3031:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    3035:	74 59                	je     3090 <fcli_cat+0x175>
						char* c = buf;
    3037:	8d 85 7f ff ff ff    	lea    eax,[ebp-0x81]
    303d:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						while (c < buf + nr)
    3040:	eb 3e                	jmp    3080 <fcli_cat+0x165>
								if (isprint(*c))
    3042:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3045:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    3048:	0f be c0             	movsx  eax,al
    304b:	89 04 24             	mov    DWORD PTR [esp],eax
    304e:	e8 fc ff ff ff       	call   304f <fcli_cat+0x134>
    3053:	85 c0                	test   eax,eax
    3055:	74 19                	je     3070 <fcli_cat+0x155>
										putchar(*c++);
    3057:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    305a:	8d 50 01             	lea    edx,[eax+0x1]
    305d:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    3060:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    3063:	0f be c0             	movsx  eax,al
    3066:	89 04 24             	mov    DWORD PTR [esp],eax
    3069:	e8 fc ff ff ff       	call   306a <fcli_cat+0x14f>
    306e:	eb 10                	jmp    3080 <fcli_cat+0x165>
								else {
										putchar('.');
    3070:	c7 04 24 2e 00 00 00 	mov    DWORD PTR [esp],0x2e
    3077:	e8 fc ff ff ff       	call   3078 <fcli_cat+0x15d>
										c++;
    307c:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
						while (c < buf + nr)
    3080:	8d 95 7f ff ff ff    	lea    edx,[ebp-0x81]
    3086:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    3089:	01 d0                	add    eax,edx
    308b:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
    308e:	72 b2                	jb     3042 <fcli_cat+0x127>
								}
				}
		} while (nr);
    3090:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    3094:	0f 85 5f ff ff ff    	jne    2ff9 <fcli_cat+0xde>
		if (-1 == dd->fn_close(in, fd))
    309a:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    309d:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    30a0:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    30a3:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    30a7:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    30aa:	89 14 24             	mov    DWORD PTR [esp],edx
    30ad:	ff d0                	call   eax
    30af:	83 f8 ff             	cmp    eax,0xffffffff
    30b2:	75 07                	jne    30bb <fcli_cat+0x1a0>
				return 1;
    30b4:	b8 01 00 00 00       	mov    eax,0x1
    30b9:	eb 11                	jmp    30cc <fcli_cat+0x1b1>
		printf("\n");
    30bb:	c7 04 24 55 04 00 00 	mov    DWORD PTR [esp],0x455
    30c2:	e8 fc ff ff ff       	call   30c3 <fcli_cat+0x1a8>
		return 1;
    30c7:	b8 01 00 00 00       	mov    eax,0x1
}
    30cc:	c9                   	leave
    30cd:	c3                   	ret

000030ce <fcli_mkdir>:

int fcli_mkdir(const char* str)
{
    30ce:	55                   	push   ebp
    30cf:	89 e5                	mov    ebp,esp
    30d1:	57                   	push   edi
    30d2:	53                   	push   ebx
    30d3:	81 ec d0 00 00 00    	sub    esp,0xd0
		struct inode* in; char ltk[40];
		const char* oc;
		if (str[2] == ' ')
    30d9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    30dc:	83 c0 02             	add    eax,0x2
    30df:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    30e2:	3c 20                	cmp    al,0x20
    30e4:	75 06                	jne    30ec <fcli_mkdir+0x1e>
				str += 3;
    30e6:	83 45 08 03          	add    DWORD PTR [ebp+0x8],0x3
    30ea:	eb 04                	jmp    30f0 <fcli_mkdir+0x22>
		else
				str += 6;
    30ec:	83 45 08 06          	add    DWORD PTR [ebp+0x8],0x6
		in = path_lookup(str, ltk, sizeof(ltk), 1);
    30f0:	c7 44 24 0c 01 00 00 00 	mov    DWORD PTR [esp+0xc],0x1
    30f8:	c7 44 24 08 28 00 00 00 	mov    DWORD PTR [esp+0x8],0x28
    3100:	8d 45 c4             	lea    eax,[ebp-0x3c]
    3103:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3107:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    310a:	89 04 24             	mov    DWORD PTR [esp],eax
    310d:	e8 fc ff ff ff       	call   310e <fcli_mkdir+0x40>
    3112:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!in)
    3115:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    3119:	75 0a                	jne    3125 <fcli_mkdir+0x57>
				return 0;
    311b:	b8 00 00 00 00       	mov    eax,0x0
    3120:	e9 4b 01 00 00       	jmp    3270 <fcli_mkdir+0x1a2>
		oc = strstr(str, ltk);
    3125:	8d 45 c4             	lea    eax,[ebp-0x3c]
    3128:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    312c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    312f:	89 04 24             	mov    DWORD PTR [esp],eax
    3132:	e8 fc ff ff ff       	call   3133 <fcli_mkdir+0x65>
    3137:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		if (strchr(oc, '/'))
    313a:	c7 44 24 04 2f 00 00 00 	mov    DWORD PTR [esp+0x4],0x2f
    3142:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3145:	89 04 24             	mov    DWORD PTR [esp],eax
    3148:	e8 fc ff ff ff       	call   3149 <fcli_mkdir+0x7b>
    314d:	85 c0                	test   eax,eax
    314f:	74 24                	je     3175 <fcli_mkdir+0xa7>
				printf("mkdir: cannot create directory '%s': no such file or directory (%s missing)\n", str, ltk);
    3151:	8d 45 c4             	lea    eax,[ebp-0x3c]
    3154:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    3158:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    315b:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    315f:	c7 04 24 58 04 00 00 	mov    DWORD PTR [esp],0x458
    3166:	e8 fc ff ff ff       	call   3167 <fcli_mkdir+0x99>
						return 1;
				} else
						printf("created '%s' at '%*s'\n", ltk, (int)(oc - str), str);
				return 1;
		}
		return 1;
    316b:	b8 01 00 00 00       	mov    eax,0x1
    3170:	e9 fb 00 00 00       	jmp    3270 <fcli_mkdir+0x1a2>
				dd = get_device(in->in_stat.st_dev);
    3175:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3178:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    317b:	8b 00                	mov    eax,DWORD PTR [eax]
    317d:	89 04 24             	mov    DWORD PTR [esp],eax
    3180:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    3184:	e8 fc ff ff ff       	call   3185 <fcli_mkdir+0xb7>
    3189:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				if (!dd) {
    318c:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    3190:	75 2b                	jne    31bd <fcli_mkdir+0xef>
								"with node '%s'\n", (uint32_t)in->in_stat.st_dev, ltk);
    3192:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3195:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3198:	8b 00                	mov    eax,DWORD PTR [eax]
						printf("unable to obtain device %u associated"
    319a:	89 c2                	mov    edx,eax
    319c:	8d 45 c4             	lea    eax,[ebp-0x3c]
    319f:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    31a3:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    31a7:	c7 04 24 a8 04 00 00 	mov    DWORD PTR [esp],0x4a8
    31ae:	e8 fc ff ff ff       	call   31af <fcli_mkdir+0xe1>
						return 1;
    31b3:	b8 01 00 00 00       	mov    eax,0x1
    31b8:	e9 b3 00 00 00       	jmp    3270 <fcli_mkdir+0x1a2>
				if (dd->fn_set_subnode(in, &INO_TMPL_DIR, ltk) != 0) {
    31bd:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    31c0:	8b 58 28             	mov    ebx,DWORD PTR [eax+0x28]
    31c3:	8d 95 48 ff ff ff    	lea    edx,[ebp-0xb8]
    31c9:	b8 00 00 00 00       	mov    eax,0x0
    31ce:	b9 1f 00 00 00       	mov    ecx,0x1f
    31d3:	89 d7                	mov    edi,edx
    31d5:	f3 ab                	rep stos DWORD PTR es:[edi],eax
    31d7:	c7 85 48 ff ff ff ff ff ff ff 	mov    DWORD PTR [ebp-0xb8],0xffffffff
    31e1:	c7 85 4c ff ff ff 00 00 00 00 	mov    DWORD PTR [ebp-0xb4],0x0
    31eb:	c7 85 58 ff ff ff 00 40 00 00 	mov    DWORD PTR [ebp-0xa8],0x4000
    31f5:	8d 45 c4             	lea    eax,[ebp-0x3c]
    31f8:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    31fc:	8d 85 48 ff ff ff    	lea    eax,[ebp-0xb8]
    3202:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3206:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3209:	89 04 24             	mov    DWORD PTR [esp],eax
    320c:	ff d3                	call   ebx
    320e:	85 c0                	test   eax,eax
    3210:	74 35                	je     3247 <fcli_mkdir+0x179>
						printf("unable to add directory '%s' to node '%*s': errno=%d\n",
    3212:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
										ltk, (int)(oc - str), str, errno);
    3218:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    321b:	2b 45 08             	sub    eax,DWORD PTR [ebp+0x8]
						printf("unable to add directory '%s' to node '%*s': errno=%d\n",
    321e:	89 54 24 10          	mov    DWORD PTR [esp+0x10],edx
    3222:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    3225:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    3229:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    322d:	8d 45 c4             	lea    eax,[ebp-0x3c]
    3230:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3234:	c7 04 24 e0 04 00 00 	mov    DWORD PTR [esp],0x4e0
    323b:	e8 fc ff ff ff       	call   323c <fcli_mkdir+0x16e>
						return 1;
    3240:	b8 01 00 00 00       	mov    eax,0x1
    3245:	eb 29                	jmp    3270 <fcli_mkdir+0x1a2>
						printf("created '%s' at '%*s'\n", ltk, (int)(oc - str), str);
    3247:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    324a:	2b 45 08             	sub    eax,DWORD PTR [ebp+0x8]
    324d:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    3250:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    3254:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    3258:	8d 45 c4             	lea    eax,[ebp-0x3c]
    325b:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    325f:	c7 04 24 16 05 00 00 	mov    DWORD PTR [esp],0x516
    3266:	e8 fc ff ff ff       	call   3267 <fcli_mkdir+0x199>
				return 1;
    326b:	b8 01 00 00 00       	mov    eax,0x1
}
    3270:	81 c4 d0 00 00 00    	add    esp,0xd0
    3276:	5b                   	pop    ebx
    3277:	5f                   	pop    edi
    3278:	5d                   	pop    ebp
    3279:	c3                   	ret

0000327a <file_cli>:

extern int file_cli(const char* str)
{
    327a:	55                   	push   ebp
    327b:	89 e5                	mov    ebp,esp
    327d:	83 ec 18             	sub    esp,0x18
		if (strncmp(str, "ls", 2) == 0 && (!str[2] || str[2] == ' '))
    3280:	c7 44 24 08 02 00 00 00 	mov    DWORD PTR [esp+0x8],0x2
    3288:	c7 44 24 04 2d 05 00 00 	mov    DWORD PTR [esp+0x4],0x52d
    3290:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3293:	89 04 24             	mov    DWORD PTR [esp],eax
    3296:	e8 fc ff ff ff       	call   3297 <file_cli+0x1d>
    329b:	85 c0                	test   eax,eax
    329d:	75 2a                	jne    32c9 <file_cli+0x4f>
    329f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    32a2:	83 c0 02             	add    eax,0x2
    32a5:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    32a8:	84 c0                	test   al,al
    32aa:	74 0d                	je     32b9 <file_cli+0x3f>
    32ac:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    32af:	83 c0 02             	add    eax,0x2
    32b2:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    32b5:	3c 20                	cmp    al,0x20
    32b7:	75 10                	jne    32c9 <file_cli+0x4f>
				return fcli_ls(str);
    32b9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    32bc:	89 04 24             	mov    DWORD PTR [esp],eax
    32bf:	e8 fc ff ff ff       	call   32c0 <file_cli+0x46>
    32c4:	e9 aa 00 00 00       	jmp    3373 <file_cli+0xf9>
		else if (strncmp(str, "cat", 3) == 0 && (!str[3] || str[3] == ' '))
    32c9:	c7 44 24 08 03 00 00 00 	mov    DWORD PTR [esp+0x8],0x3
    32d1:	c7 44 24 04 30 05 00 00 	mov    DWORD PTR [esp+0x4],0x530
    32d9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    32dc:	89 04 24             	mov    DWORD PTR [esp],eax
    32df:	e8 fc ff ff ff       	call   32e0 <file_cli+0x66>
    32e4:	85 c0                	test   eax,eax
    32e6:	75 3b                	jne    3323 <file_cli+0xa9>
    32e8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    32eb:	83 c0 03             	add    eax,0x3
    32ee:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    32f1:	84 c0                	test   al,al
    32f3:	74 0d                	je     3302 <file_cli+0x88>
    32f5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    32f8:	83 c0 03             	add    eax,0x3
    32fb:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    32fe:	3c 20                	cmp    al,0x20
    3300:	75 21                	jne    3323 <file_cli+0xa9>
				if (!str[3]) /* stdin */
    3302:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3305:	83 c0 03             	add    eax,0x3
    3308:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    330b:	84 c0                	test   al,al
    330d:	75 07                	jne    3316 <file_cli+0x9c>
						return 0;
    330f:	b8 00 00 00 00       	mov    eax,0x0
    3314:	eb 5d                	jmp    3373 <file_cli+0xf9>
				else
						return fcli_cat(str);
    3316:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3319:	89 04 24             	mov    DWORD PTR [esp],eax
    331c:	e8 fc ff ff ff       	call   331d <file_cli+0xa3>
    3321:	eb 50                	jmp    3373 <file_cli+0xf9>
		else if (strncmp(str, "mkdir ", 6) == 0 || strncmp(str, "md ", 3) == 0) {
    3323:	c7 44 24 08 06 00 00 00 	mov    DWORD PTR [esp+0x8],0x6
    332b:	c7 44 24 04 34 05 00 00 	mov    DWORD PTR [esp+0x4],0x534
    3333:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3336:	89 04 24             	mov    DWORD PTR [esp],eax
    3339:	e8 fc ff ff ff       	call   333a <file_cli+0xc0>
    333e:	85 c0                	test   eax,eax
    3340:	74 1f                	je     3361 <file_cli+0xe7>
    3342:	c7 44 24 08 03 00 00 00 	mov    DWORD PTR [esp+0x8],0x3
    334a:	c7 44 24 04 3b 05 00 00 	mov    DWORD PTR [esp+0x4],0x53b
    3352:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3355:	89 04 24             	mov    DWORD PTR [esp],eax
    3358:	e8 fc ff ff ff       	call   3359 <file_cli+0xdf>
    335d:	85 c0                	test   eax,eax
    335f:	75 0d                	jne    336e <file_cli+0xf4>
				return fcli_mkdir(str);
    3361:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3364:	89 04 24             	mov    DWORD PTR [esp],eax
    3367:	e8 fc ff ff ff       	call   3368 <file_cli+0xee>
    336c:	eb 05                	jmp    3373 <file_cli+0xf9>
		} else
				return 0; /* we have not handled the command */
    336e:	b8 00 00 00 00       	mov    eax,0x0
}
    3373:	c9                   	leave
    3374:	c3                   	ret

00003375 <module_cleanup>:

void MODENTRY module_cleanup()
{
    3375:	55                   	push   ebp
    3376:	89 e5                	mov    ebp,esp
    3378:	83 ec 18             	sub    esp,0x18
		printf("goodbye file.ko\n");
    337b:	c7 04 24 3f 05 00 00 	mov    DWORD PTR [esp],0x53f
    3382:	e8 fc ff ff ff       	call   3383 <module_cleanup+0xe>
}
    3387:	90                   	nop
    3388:	c9                   	leave
    3389:	c3                   	ret
