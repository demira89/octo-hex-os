
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
      3f:	83 ec 28             	sub    esp,0x28
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
      80:	0f 85 c8 00 00 00    	jne    14e <register_device+0x112>
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
      a3:	0f 85 8d 00 00 00    	jne    136 <register_device+0xfa>
								struct dd_drs* dr2 = kmalloc(sizeof(struct dd_drs));
      a9:	83 ec 0c             	sub    esp,0xc
      ac:	68 c4 01 00 00       	push   0x1c4
      b1:	e8 fc ff ff ff       	call   b2 <register_device+0x76>
      b6:	83 c4 10             	add    esp,0x10
      b9:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
								if (!dr2) {
      bc:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
      c0:	75 19                	jne    db <register_device+0x9f>
										errno = ENOMEM;
      c2:	c7 05 00 00 00 00 0c 00 00 00 	mov    DWORD PTR ds:0x0,0xc
										return INVALID_DEVICE;
      cc:	b8 ff ff ff ff       	mov    eax,0xffffffff
      d1:	ba 00 00 00 00       	mov    edx,0x0
      d6:	e9 0c 01 00 00       	jmp    1e7 <register_device+0x1ab>
								dr2->next = NULL;
      db:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
      de:	c7 80 c0 01 00 00 00 00 00 00 	mov    DWORD PTR [eax+0x1c0],0x0
								for (i = 0; i < 8; i++)
      e8:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
      ef:	eb 12                	jmp    103 <register_device+0xc7>
										dr2->descs[i].type = 0;
      f1:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
      f4:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
      f7:	6b c0 38             	imul   eax,eax,0x38
      fa:	01 d0                	add    eax,edx
      fc:	c6 00 00             	mov    BYTE PTR [eax],0x0
								for (i = 0; i < 8; i++)
      ff:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
     103:	83 7d ec 07          	cmp    DWORD PTR [ebp-0x14],0x7
     107:	76 e8                	jbe    f1 <register_device+0xb5>
								if (!__sync_bool_compare_and_swap(&dr->next, NULL, dr2))
     109:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
     10c:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     10f:	8d 88 c0 01 00 00    	lea    ecx,[eax+0x1c0]
     115:	b8 00 00 00 00       	mov    eax,0x0
     11a:	f0 0f b1 11          	lock cmpxchg DWORD PTR [ecx],edx
     11e:	0f 94 c0             	sete   al
     121:	83 f0 01             	xor    eax,0x1
     124:	84 c0                	test   al,al
     126:	74 0e                	je     136 <register_device+0xfa>
										kfree(dr2); /* someone was faster */
     128:	83 ec 0c             	sub    esp,0xc
     12b:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
     12e:	e8 fc ff ff ff       	call   12f <register_device+0xf3>
     133:	83 c4 10             	add    esp,0x10
						i = 0;
     136:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
						dr = dr->next;
     13d:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     140:	8b 80 c0 01 00 00    	mov    eax,DWORD PTR [eax+0x1c0]
     146:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				if (__sync_bool_compare_and_swap(&dr->descs[i].type, 0, dd->type))
     149:	e9 10 ff ff ff       	jmp    5e <register_device+0x22>
						break;
     14e:	90                   	nop
		dr->descs[i] = *dd;
     14f:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
     152:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     155:	6b c0 38             	imul   eax,eax,0x38
     158:	01 c2                	add    edx,eax
     15a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     15d:	8b 08                	mov    ecx,DWORD PTR [eax]
     15f:	89 0a                	mov    DWORD PTR [edx],ecx
     161:	8b 48 04             	mov    ecx,DWORD PTR [eax+0x4]
     164:	89 4a 04             	mov    DWORD PTR [edx+0x4],ecx
     167:	8b 48 08             	mov    ecx,DWORD PTR [eax+0x8]
     16a:	89 4a 08             	mov    DWORD PTR [edx+0x8],ecx
     16d:	8b 48 0c             	mov    ecx,DWORD PTR [eax+0xc]
     170:	89 4a 0c             	mov    DWORD PTR [edx+0xc],ecx
     173:	8b 48 10             	mov    ecx,DWORD PTR [eax+0x10]
     176:	89 4a 10             	mov    DWORD PTR [edx+0x10],ecx
     179:	8b 48 14             	mov    ecx,DWORD PTR [eax+0x14]
     17c:	89 4a 14             	mov    DWORD PTR [edx+0x14],ecx
     17f:	8b 48 18             	mov    ecx,DWORD PTR [eax+0x18]
     182:	89 4a 18             	mov    DWORD PTR [edx+0x18],ecx
     185:	8b 48 1c             	mov    ecx,DWORD PTR [eax+0x1c]
     188:	89 4a 1c             	mov    DWORD PTR [edx+0x1c],ecx
     18b:	8b 48 20             	mov    ecx,DWORD PTR [eax+0x20]
     18e:	89 4a 20             	mov    DWORD PTR [edx+0x20],ecx
     191:	8b 48 24             	mov    ecx,DWORD PTR [eax+0x24]
     194:	89 4a 24             	mov    DWORD PTR [edx+0x24],ecx
     197:	8b 48 28             	mov    ecx,DWORD PTR [eax+0x28]
     19a:	89 4a 28             	mov    DWORD PTR [edx+0x28],ecx
     19d:	8b 48 2c             	mov    ecx,DWORD PTR [eax+0x2c]
     1a0:	89 4a 2c             	mov    DWORD PTR [edx+0x2c],ecx
     1a3:	8b 48 30             	mov    ecx,DWORD PTR [eax+0x30]
     1a6:	89 4a 30             	mov    DWORD PTR [edx+0x30],ecx
     1a9:	8b 40 34             	mov    eax,DWORD PTR [eax+0x34]
     1ac:	89 42 34             	mov    DWORD PTR [edx+0x34],eax
		if(dd->fn_reg_dev(rv)) {
     1af:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1b2:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     1b5:	83 ec 08             	sub    esp,0x8
     1b8:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
     1bb:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
     1be:	ff d0                	call   eax
     1c0:	83 c4 10             	add    esp,0x10
     1c3:	85 c0                	test   eax,eax
     1c5:	74 1a                	je     1e1 <register_device+0x1a5>
				dr->descs[i].type = 0;
     1c7:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
     1ca:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     1cd:	6b c0 38             	imul   eax,eax,0x38
     1d0:	01 d0                	add    eax,edx
     1d2:	c6 00 00             	mov    BYTE PTR [eax],0x0
				return INVALID_DEVICE;
     1d5:	b8 ff ff ff ff       	mov    eax,0xffffffff
     1da:	ba 00 00 00 00       	mov    edx,0x0
     1df:	eb 06                	jmp    1e7 <register_device+0x1ab>
		return rv;
     1e1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     1e4:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
}
     1e7:	c9                   	leave
     1e8:	c3                   	ret

000001e9 <unregister_device>:
{
     1e9:	55                   	push   ebp
     1ea:	89 e5                	mov    ebp,esp
     1ec:	83 ec 28             	sub    esp,0x28
     1ef:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1f2:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
     1f5:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     1f8:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		struct dd_drs* dr = &dr0;
     1fb:	c7 45 f4 20 00 00 00 	mov    DWORD PTR [ebp-0xc],0x20
				if (dev >= 8) {
     202:	ba 07 00 00 00       	mov    edx,0x7
     207:	b8 00 00 00 00       	mov    eax,0x0
     20c:	3b 55 e0             	cmp    edx,DWORD PTR [ebp-0x20]
     20f:	1b 45 e4             	sbb    eax,DWORD PTR [ebp-0x1c]
     212:	73 2a                	jae    23e <unregister_device+0x55>
						dr = dr->next;
     214:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     217:	8b 80 c0 01 00 00    	mov    eax,DWORD PTR [eax+0x1c0]
     21d:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						dr -= 8;
     220:	81 6d f4 20 0e 00 00 	sub    DWORD PTR [ebp-0xc],0xe20
						if (!dr) {
     227:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     22b:	75 d5                	jne    202 <unregister_device+0x19>
								errno = EINVAL;
     22d:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
								return -1;
     237:	b8 ff ff ff ff       	mov    eax,0xffffffff
     23c:	eb 56                	jmp    294 <unregister_device+0xab>
						if (!dr->descs[dev].type) {
     23e:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     241:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     244:	6b c0 38             	imul   eax,eax,0x38
     247:	01 d0                	add    eax,edx
     249:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     24c:	84 c0                	test   al,al
     24e:	75 11                	jne    261 <unregister_device+0x78>
								errno = EINVAL;
     250:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
								return -1;
     25a:	b8 ff ff ff ff       	mov    eax,0xffffffff
     25f:	eb 33                	jmp    294 <unregister_device+0xab>
						rv = dr->descs[dev].fn_unreg_dev();
     261:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     264:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     267:	6b c0 38             	imul   eax,eax,0x38
     26a:	01 d0                	add    eax,edx
     26c:	83 c0 08             	add    eax,0x8
     26f:	8b 00                	mov    eax,DWORD PTR [eax]
     271:	ff d0                	call   eax
     273:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
						if (!rv) {
     276:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     27a:	75 15                	jne    291 <unregister_device+0xa8>
								dr->descs[dev].type = 0;
     27c:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     27f:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     282:	6b c0 38             	imul   eax,eax,0x38
     285:	01 d0                	add    eax,edx
     287:	c6 00 00             	mov    BYTE PTR [eax],0x0
								return 0;
     28a:	b8 00 00 00 00       	mov    eax,0x0
     28f:	eb 03                	jmp    294 <unregister_device+0xab>
								return rv;
     291:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
}
     294:	c9                   	leave
     295:	c3                   	ret

00000296 <get_device>:
{
     296:	55                   	push   ebp
     297:	89 e5                	mov    ebp,esp
     299:	83 ec 18             	sub    esp,0x18
     29c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     29f:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
     2a2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     2a5:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		struct dd_drs* dr = &dr0;
     2a8:	c7 45 fc 20 00 00 00 	mov    DWORD PTR [ebp-0x4],0x20
				if (dev >= 8) {
     2af:	ba 07 00 00 00       	mov    edx,0x7
     2b4:	b8 00 00 00 00       	mov    eax,0x0
     2b9:	3b 55 e8             	cmp    edx,DWORD PTR [ebp-0x18]
     2bc:	1b 45 ec             	sbb    eax,DWORD PTR [ebp-0x14]
     2bf:	73 2a                	jae    2eb <get_device+0x55>
						dr = dr->next;
     2c1:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     2c4:	8b 80 c0 01 00 00    	mov    eax,DWORD PTR [eax+0x1c0]
     2ca:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
						dr -= 8;
     2cd:	81 6d fc 20 0e 00 00 	sub    DWORD PTR [ebp-0x4],0xe20
						if (!dr) {
     2d4:	83 7d fc 00          	cmp    DWORD PTR [ebp-0x4],0x0
     2d8:	75 d5                	jne    2af <get_device+0x19>
								errno = EINVAL;
     2da:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
								return NULL;
     2e4:	b8 00 00 00 00       	mov    eax,0x0
     2e9:	eb 24                	jmp    30f <get_device+0x79>
						if (!dr->descs[dev].type)
     2eb:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     2ee:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     2f1:	6b c0 38             	imul   eax,eax,0x38
     2f4:	01 d0                	add    eax,edx
     2f6:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     2f9:	84 c0                	test   al,al
     2fb:	75 07                	jne    304 <get_device+0x6e>
								return NULL;
     2fd:	b8 00 00 00 00       	mov    eax,0x0
     302:	eb 0b                	jmp    30f <get_device+0x79>
						return dr->descs + dev;
     304:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     307:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     30a:	6b c0 38             	imul   eax,eax,0x38
     30d:	01 d0                	add    eax,edx
}
     30f:	c9                   	leave
     310:	c3                   	ret

00000311 <fil_fd_get>:
{
     311:	55                   	push   ebp
     312:	89 e5                	mov    ebp,esp
     314:	83 ec 10             	sub    esp,0x10
		struct fil_fdc* f = &fdc0;
     317:	c7 45 fc 00 02 00 00 	mov    DWORD PTR [ebp-0x4],0x200
		while (fd >= 64) {
     31e:	eb 1d                	jmp    33d <fil_fd_get+0x2c>
				fd -= 64;
     320:	83 6d 08 40          	sub    DWORD PTR [ebp+0x8],0x40
				f = f->next;
     324:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     327:	8b 80 00 07 00 00    	mov    eax,DWORD PTR [eax+0x700]
     32d:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
				if (!f)
     330:	83 7d fc 00          	cmp    DWORD PTR [ebp-0x4],0x0
     334:	75 07                	jne    33d <fil_fd_get+0x2c>
						return NULL;
     336:	b8 00 00 00 00       	mov    eax,0x0
     33b:	eb 11                	jmp    34e <fil_fd_get+0x3d>
		while (fd >= 64) {
     33d:	83 7d 08 3f          	cmp    DWORD PTR [ebp+0x8],0x3f
     341:	7f dd                	jg     320 <fil_fd_get+0xf>
		return &f->fds[fd];
     343:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     346:	6b d0 1c             	imul   edx,eax,0x1c
     349:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     34c:	01 d0                	add    eax,edx
}
     34e:	c9                   	leave
     34f:	c3                   	ret

00000350 <fil_fd_allocate>:
{
     350:	55                   	push   ebp
     351:	89 e5                	mov    ebp,esp
     353:	83 ec 18             	sub    esp,0x18
		struct fil_fdc* fdc = &fdc0;
     356:	c7 45 f4 00 02 00 00 	mov    DWORD PTR [ebp-0xc],0x200
		int rv = 0; size_t i;
     35d:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
				for (i = 0; i < 64; i++) {
     364:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
     36b:	eb 41                	jmp    3ae <fil_fd_allocate+0x5e>
						if (__sync_bool_compare_and_swap(&fdc->fds[i].in, NULL, in)) {
     36d:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     370:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     373:	6b c8 1c             	imul   ecx,eax,0x1c
     376:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     379:	01 c1                	add    ecx,eax
     37b:	b8 00 00 00 00       	mov    eax,0x0
     380:	f0 0f b1 11          	lock cmpxchg DWORD PTR [ecx],edx
     384:	0f 94 c0             	sete   al
     387:	84 c0                	test   al,al
     389:	74 1f                	je     3aa <fil_fd_allocate+0x5a>
								*pfd = rv + i;
     38b:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     38e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     391:	01 d0                	add    eax,edx
     393:	89 c2                	mov    edx,eax
     395:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     398:	89 10                	mov    DWORD PTR [eax],edx
								return &fdc->fds[i];
     39a:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     39d:	6b d0 1c             	imul   edx,eax,0x1c
     3a0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3a3:	01 d0                	add    eax,edx
     3a5:	e9 ca 00 00 00       	jmp    474 <fil_fd_allocate+0x124>
				for (i = 0; i < 64; i++) {
     3aa:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
     3ae:	83 7d ec 3f          	cmp    DWORD PTR [ebp-0x14],0x3f
     3b2:	76 b9                	jbe    36d <fil_fd_allocate+0x1d>
				rv += 64;
     3b4:	83 45 f0 40          	add    DWORD PTR [ebp-0x10],0x40
				if (!fdc->next) {
     3b8:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3bb:	8b 80 00 07 00 00    	mov    eax,DWORD PTR [eax+0x700]
     3c1:	85 c0                	test   eax,eax
     3c3:	0f 85 9a 00 00 00    	jne    463 <fil_fd_allocate+0x113>
						struct fil_fdc* f2 = fdc->next = (struct fil_fdc*)kmalloc(sizeof(struct fil_fdc));
     3c9:	83 ec 0c             	sub    esp,0xc
     3cc:	68 04 07 00 00       	push   0x704
     3d1:	e8 fc ff ff ff       	call   3d2 <fil_fd_allocate+0x82>
     3d6:	83 c4 10             	add    esp,0x10
     3d9:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     3dc:	89 82 00 07 00 00    	mov    DWORD PTR [edx+0x700],eax
     3e2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     3e5:	8b 80 00 07 00 00    	mov    eax,DWORD PTR [eax+0x700]
     3eb:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
						if (!f2) {
     3ee:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
     3f2:	75 11                	jne    405 <fil_fd_allocate+0xb5>
								errno = ENOMEM;
     3f4:	c7 05 00 00 00 00 0c 00 00 00 	mov    DWORD PTR ds:0x0,0xc
								return NULL;
     3fe:	b8 00 00 00 00       	mov    eax,0x0
     403:	eb 6f                	jmp    474 <fil_fd_allocate+0x124>
						f2->next = NULL;
     405:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     408:	c7 80 00 07 00 00 00 00 00 00 	mov    DWORD PTR [eax+0x700],0x0
						for (i = 0; i < 64; i++)
     412:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
     419:	eb 15                	jmp    430 <fil_fd_allocate+0xe0>
								f2->fds[i].in = NULL;
     41b:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
     41e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     421:	6b c0 1c             	imul   eax,eax,0x1c
     424:	01 d0                	add    eax,edx
     426:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
						for (i = 0; i < 64; i++)
     42c:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
     430:	83 7d ec 3f          	cmp    DWORD PTR [ebp-0x14],0x3f
     434:	76 e5                	jbe    41b <fil_fd_allocate+0xcb>
						if (!__sync_bool_compare_and_swap(&fdc->next, NULL, f2))
     436:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
     439:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     43c:	8d 88 00 07 00 00    	lea    ecx,[eax+0x700]
     442:	b8 00 00 00 00       	mov    eax,0x0
     447:	f0 0f b1 11          	lock cmpxchg DWORD PTR [ecx],edx
     44b:	0f 94 c0             	sete   al
     44e:	83 f0 01             	xor    eax,0x1
     451:	84 c0                	test   al,al
     453:	74 0e                	je     463 <fil_fd_allocate+0x113>
								kfree(f2); /* someone was faster */
     455:	83 ec 0c             	sub    esp,0xc
     458:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
     45b:	e8 fc ff ff ff       	call   45c <fil_fd_allocate+0x10c>
     460:	83 c4 10             	add    esp,0x10
				fdc = fdc->next;
     463:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     466:	8b 80 00 07 00 00    	mov    eax,DWORD PTR [eax+0x700]
     46c:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				for (i = 0; i < 64; i++) {
     46f:	e9 f0 fe ff ff       	jmp    364 <fil_fd_allocate+0x14>
}
     474:	c9                   	leave
     475:	c3                   	ret

00000476 <fil_fd_free>:
{
     476:	55                   	push   ebp
     477:	89 e5                	mov    ebp,esp
     479:	83 ec 10             	sub    esp,0x10
		struct fil_fdc* fdc = &fdc0;
     47c:	c7 45 fc 00 02 00 00 	mov    DWORD PTR [ebp-0x4],0x200
				if (fd >= 64) {
     483:	83 7d 08 3f          	cmp    DWORD PTR [ebp+0x8],0x3f
     487:	7e 18                	jle    4a1 <fil_fd_free+0x2b>
						fdc = fdc->next;
     489:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     48c:	8b 80 00 07 00 00    	mov    eax,DWORD PTR [eax+0x700]
     492:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
						fd -= 64;
     495:	83 6d 08 40          	sub    DWORD PTR [ebp+0x8],0x40
						if (!fdc)
     499:	83 7d fc 00          	cmp    DWORD PTR [ebp-0x4],0x0
     49d:	75 e4                	jne    483 <fil_fd_free+0xd>
								return;
     49f:	eb 25                	jmp    4c6 <fil_fd_free+0x50>
						if (fdc->fds[fd].in) {
     4a1:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     4a4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     4a7:	6b c0 1c             	imul   eax,eax,0x1c
     4aa:	01 d0                	add    eax,edx
     4ac:	8b 00                	mov    eax,DWORD PTR [eax]
     4ae:	85 c0                	test   eax,eax
     4b0:	74 13                	je     4c5 <fil_fd_free+0x4f>
								fdc->fds[fd].in = NULL;
     4b2:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     4b5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     4b8:	6b c0 1c             	imul   eax,eax,0x1c
     4bb:	01 d0                	add    eax,edx
     4bd:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
								return;
     4c3:	eb 01                	jmp    4c6 <fil_fd_free+0x50>
								return;
     4c5:	90                   	nop
}
     4c6:	c9                   	leave
     4c7:	c3                   	ret

000004c8 <ino_allocate>:
{
     4c8:	55                   	push   ebp
     4c9:	89 e5                	mov    ebp,esp
     4cb:	57                   	push   edi
     4cc:	56                   	push   esi
     4cd:	53                   	push   ebx
     4ce:	83 ec 3c             	sub    esp,0x3c
		struct fil_inc* fi = &inc0; ino_t val = 1;
     4d1:	c7 45 d8 20 09 00 00 	mov    DWORD PTR [ebp-0x28],0x920
     4d8:	c7 45 e0 01 00 00 00 	mov    DWORD PTR [ebp-0x20],0x1
     4df:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
				struct inode* in = fi->inodes;
     4e6:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     4e9:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
						if (__sync_bool_compare_and_swap(&in->in_stat.st_ino, 0, val)) {
     4ec:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     4ef:	8d 70 08             	lea    esi,[eax+0x8]
     4f2:	b8 00 00 00 00       	mov    eax,0x0
     4f7:	ba 00 00 00 00       	mov    edx,0x0
     4fc:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
     4ff:	8b 5d e4             	mov    ebx,DWORD PTR [ebp-0x1c]
     502:	89 4d c0             	mov    DWORD PTR [ebp-0x40],ecx
     505:	89 5d c4             	mov    DWORD PTR [ebp-0x3c],ebx
     508:	89 cb                	mov    ebx,ecx
     50a:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
     50d:	f0 0f c7 0e          	lock cmpxchg8b QWORD PTR [esi]
     511:	0f 94 c0             	sete   al
     514:	84 c0                	test   al,al
     516:	0f 84 da 00 00 00    	je     5f6 <ino_allocate+0x12e>
								in->in_stat.st_nlink = 0;
     51c:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     51f:	c7 40 14 00 00 00 00 	mov    DWORD PTR [eax+0x14],0x0
     526:	c7 40 18 00 00 00 00 	mov    DWORD PTR [eax+0x18],0x0
								in->in_lock = (rwlock_t)RW_LOCK_UNLOCKED;
     52d:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     530:	c7 40 74 00 00 00 00 	mov    DWORD PTR [eax+0x74],0x0
     537:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     53a:	66 c7 40 78 00 00    	mov    WORD PTR [eax+0x78],0x0
								bzero(in->in_ddat, sizeof(in->in_ddat));
     540:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     543:	83 c0 68             	add    eax,0x68
     546:	83 ec 08             	sub    esp,0x8
     549:	6a 08                	push   0x8
     54b:	50                   	push   eax
     54c:	e8 fc ff ff ff       	call   54d <ino_allocate+0x85>
     551:	83 c4 10             	add    esp,0x10
								if (init) {
     554:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     558:	74 68                	je     5c2 <ino_allocate+0xfa>
										in->in_stat.st_uid = 0;
     55a:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     55d:	c7 40 1c 00 00 00 00 	mov    DWORD PTR [eax+0x1c],0x0
										in->in_stat.st_gid = 0;
     564:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     567:	c7 40 20 00 00 00 00 	mov    DWORD PTR [eax+0x20],0x0
										in->in_stat.st_mode = init | S_IRWXU | S_IRGRP | S_IXGRP | S_IROTH | S_IXOTH;
     56e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     571:	0d ed 01 00 00       	or     eax,0x1ed
     576:	89 c2                	mov    edx,eax
     578:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     57b:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
										clock_gettime(CLOCK_REALTIME, &in->in_stat.st_ctim);
     57e:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     581:	83 c0 5c             	add    eax,0x5c
     584:	83 ec 08             	sub    esp,0x8
     587:	50                   	push   eax
     588:	6a 00                	push   0x0
     58a:	e8 fc ff ff ff       	call   58b <ino_allocate+0xc3>
     58f:	83 c4 10             	add    esp,0x10
												= in->in_stat.st_ctim;
     592:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     595:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     598:	8b 4a 5c             	mov    ecx,DWORD PTR [edx+0x5c]
     59b:	89 48 44             	mov    DWORD PTR [eax+0x44],ecx
     59e:	8b 4a 60             	mov    ecx,DWORD PTR [edx+0x60]
     5a1:	89 48 48             	mov    DWORD PTR [eax+0x48],ecx
     5a4:	8b 52 64             	mov    edx,DWORD PTR [edx+0x64]
     5a7:	89 50 4c             	mov    DWORD PTR [eax+0x4c],edx
										in->in_stat.st_mtim = in->in_stat.st_atim
     5aa:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     5ad:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
     5b0:	8b 4a 44             	mov    ecx,DWORD PTR [edx+0x44]
     5b3:	89 48 50             	mov    DWORD PTR [eax+0x50],ecx
     5b6:	8b 4a 48             	mov    ecx,DWORD PTR [edx+0x48]
     5b9:	89 48 54             	mov    DWORD PTR [eax+0x54],ecx
     5bc:	8b 52 4c             	mov    edx,DWORD PTR [edx+0x4c]
     5bf:	89 50 58             	mov    DWORD PTR [eax+0x58],edx
								__sync_fetch_and_add(&ino_ct, 1);
     5c2:	a1 28 28 00 00       	mov    eax,ds:0x2828
     5c7:	8b 15 2c 28 00 00    	mov    edx,DWORD PTR ds:0x282c
     5cd:	89 c1                	mov    ecx,eax
     5cf:	89 d3                	mov    ebx,edx
     5d1:	83 c1 01             	add    ecx,0x1
     5d4:	83 d3 00             	adc    ebx,0x0
     5d7:	89 ce                	mov    esi,ecx
     5d9:	89 df                	mov    edi,ebx
     5db:	89 f3                	mov    ebx,esi
     5dd:	89 f9                	mov    ecx,edi
     5df:	f0 0f c7 0d 28 28 00 00 	lock cmpxchg8b QWORD PTR ds:0x2828
     5e7:	0f 94 c1             	sete   cl
     5ea:	84 c9                	test   cl,cl
     5ec:	74 df                	je     5cd <ino_allocate+0x105>
								return in;
     5ee:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     5f1:	e9 a6 00 00 00       	jmp    69c <ino_allocate+0x1d4>
						val++;
     5f6:	83 45 e0 01          	add    DWORD PTR [ebp-0x20],0x1
     5fa:	83 55 e4 00          	adc    DWORD PTR [ebp-0x1c],0x0
				} while ((void*)(in++) != (void*)(&fi->next));
     5fe:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     601:	8d 50 7c             	lea    edx,[eax+0x7c]
     604:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
     607:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
     60a:	81 c2 00 1f 00 00    	add    edx,0x1f00
     610:	39 d0                	cmp    eax,edx
     612:	0f 85 d4 fe ff ff    	jne    4ec <ino_allocate+0x24>
				if (!fi->next) {
     618:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     61b:	8b 80 00 1f 00 00    	mov    eax,DWORD PTR [eax+0x1f00]
     621:	85 c0                	test   eax,eax
     623:	0f 85 bd fe ff ff    	jne    4e6 <ino_allocate+0x1e>
						struct fil_inc* fi2 = kmalloc(sizeof(struct fil_inc));
     629:	83 ec 0c             	sub    esp,0xc
     62c:	68 04 1f 00 00       	push   0x1f04
     631:	e8 fc ff ff ff       	call   632 <ino_allocate+0x16a>
     636:	83 c4 10             	add    esp,0x10
     639:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
						if (!fi2) {
     63c:	83 7d d4 00          	cmp    DWORD PTR [ebp-0x2c],0x0
     640:	75 11                	jne    653 <ino_allocate+0x18b>
								errno = ENOMEM;
     642:	c7 05 00 00 00 00 0c 00 00 00 	mov    DWORD PTR ds:0x0,0xc
								return NULL;
     64c:	b8 00 00 00 00       	mov    eax,0x0
     651:	eb 49                	jmp    69c <ino_allocate+0x1d4>
						bzero(fi2, sizeof(*fi2));
     653:	83 ec 08             	sub    esp,0x8
     656:	68 04 1f 00 00       	push   0x1f04
     65b:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
     65e:	e8 fc ff ff ff       	call   65f <ino_allocate+0x197>
     663:	83 c4 10             	add    esp,0x10
						if (!__sync_bool_compare_and_swap(&fi->next, NULL, fi2)) {
     666:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
     669:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     66c:	8d 88 00 1f 00 00    	lea    ecx,[eax+0x1f00]
     672:	b8 00 00 00 00       	mov    eax,0x0
     677:	f0 0f b1 11          	lock cmpxchg DWORD PTR [ecx],edx
     67b:	0f 94 c0             	sete   al
     67e:	83 f0 01             	xor    eax,0x1
     681:	84 c0                	test   al,al
     683:	0f 84 5d fe ff ff    	je     4e6 <ino_allocate+0x1e>
								kfree(fi2);
     689:	83 ec 0c             	sub    esp,0xc
     68c:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
     68f:	e8 fc ff ff ff       	call   690 <ino_allocate+0x1c8>
     694:	83 c4 10             	add    esp,0x10
		while (1) {
     697:	e9 4a fe ff ff       	jmp    4e6 <ino_allocate+0x1e>
}
     69c:	8d 65 f4             	lea    esp,[ebp-0xc]
     69f:	5b                   	pop    ebx
     6a0:	5e                   	pop    esi
     6a1:	5f                   	pop    edi
     6a2:	5d                   	pop    ebp
     6a3:	c3                   	ret

000006a4 <ino_release>:
{
     6a4:	55                   	push   ebp
     6a5:	89 e5                	mov    ebp,esp
     6a7:	57                   	push   edi
     6a8:	56                   	push   esi
     6a9:	53                   	push   ebx
     6aa:	83 ec 0c             	sub    esp,0xc
		ino->in_stat.st_ino = 0;
     6ad:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     6b0:	c7 40 08 00 00 00 00 	mov    DWORD PTR [eax+0x8],0x0
     6b7:	c7 40 0c 00 00 00 00 	mov    DWORD PTR [eax+0xc],0x0
		return __sync_fetch_and_sub(&ino_ct, 1);
     6be:	a1 28 28 00 00       	mov    eax,ds:0x2828
     6c3:	8b 15 2c 28 00 00    	mov    edx,DWORD PTR ds:0x282c
     6c9:	89 c6                	mov    esi,eax
     6cb:	89 d7                	mov    edi,edx
     6cd:	89 c1                	mov    ecx,eax
     6cf:	89 d3                	mov    ebx,edx
     6d1:	83 c1 ff             	add    ecx,0xffffffff
     6d4:	83 d3 ff             	adc    ebx,0xffffffff
     6d7:	89 4d e8             	mov    DWORD PTR [ebp-0x18],ecx
     6da:	89 5d ec             	mov    DWORD PTR [ebp-0x14],ebx
     6dd:	8b 5d e8             	mov    ebx,DWORD PTR [ebp-0x18]
     6e0:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
     6e3:	f0 0f c7 0d 28 28 00 00 	lock cmpxchg8b QWORD PTR ds:0x2828
     6eb:	0f 94 c1             	sete   cl
     6ee:	84 c9                	test   cl,cl
     6f0:	74 d7                	je     6c9 <ino_release+0x25>
     6f2:	89 f0                	mov    eax,esi
}
     6f4:	83 c4 0c             	add    esp,0xc
     6f7:	5b                   	pop    ebx
     6f8:	5e                   	pop    esi
     6f9:	5f                   	pop    edi
     6fa:	5d                   	pop    ebp
     6fb:	c3                   	ret

000006fc <memdev_store_node>:
{
     6fc:	55                   	push   ebp
     6fd:	89 e5                	mov    ebp,esp
     6ff:	83 ec 18             	sub    esp,0x18
		struct memdev_node** ns = memdev_data->nodes;
     702:	a1 00 00 00 00       	mov    eax,ds:0x0
     707:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     70a:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		for (i = 0; i < memdev_data->node_cap_bts; i++) {
     70d:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
     714:	e9 30 01 00 00       	jmp    849 <memdev_store_node+0x14d>
				if (__sync_bool_compare_and_swap(&ns[i], NULL, n))
     719:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     71c:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     71f:	8d 0c 85 00 00 00 00 	lea    ecx,[eax*4+0x0]
     726:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     729:	01 c1                	add    ecx,eax
     72b:	b8 00 00 00 00       	mov    eax,0x0
     730:	f0 0f b1 11          	lock cmpxchg DWORD PTR [ecx],edx
     734:	0f 94 c0             	sete   al
     737:	84 c0                	test   al,al
     739:	74 14                	je     74f <memdev_store_node+0x53>
						return &ns[i]; /* stored */
     73b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     73e:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     745:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     748:	01 d0                	add    eax,edx
     74a:	e9 10 01 00 00       	jmp    85f <memdev_store_node+0x163>
				if (i == memdev_data->node_cap_bts - 2) { /* next is ptr */
     74f:	a1 00 00 00 00       	mov    eax,ds:0x0
     754:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     757:	83 e8 02             	sub    eax,0x2
     75a:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
     75d:	0f 85 e2 00 00 00    	jne    845 <memdev_store_node+0x149>
						if (ns[++i])
     763:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
     767:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     76a:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     771:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     774:	01 d0                	add    eax,edx
     776:	8b 00                	mov    eax,DWORD PTR [eax]
     778:	85 c0                	test   eax,eax
     77a:	74 19                	je     795 <memdev_store_node+0x99>
								ns = (struct memdev_node**)ns[i];
     77c:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     77f:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     786:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     789:	01 d0                	add    eax,edx
     78b:	8b 00                	mov    eax,DWORD PTR [eax]
     78d:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     790:	e9 a9 00 00 00       	jmp    83e <memdev_store_node+0x142>
									memdev_data->node_cap_bts * sizeof(struct memdev_node*));
     795:	a1 00 00 00 00       	mov    eax,ds:0x0
     79a:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
								ns2 = h_malloc(memdev_data->heap,
     79d:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     7a4:	a1 00 00 00 00       	mov    eax,ds:0x0
     7a9:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     7ac:	83 ec 08             	sub    esp,0x8
     7af:	52                   	push   edx
     7b0:	50                   	push   eax
     7b1:	e8 fc ff ff ff       	call   7b2 <memdev_store_node+0xb6>
     7b6:	83 c4 10             	add    esp,0x10
     7b9:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
								if (!ns2) /* OOM */
     7bc:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     7c0:	75 0a                	jne    7cc <memdev_store_node+0xd0>
										return NULL;
     7c2:	b8 00 00 00 00       	mov    eax,0x0
     7c7:	e9 93 00 00 00       	jmp    85f <memdev_store_node+0x163>
								bzero(ns2, memdev_data->node_cap_bts * sizeof(struct memdev_node*));
     7cc:	a1 00 00 00 00       	mov    eax,ds:0x0
     7d1:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     7d4:	c1 e0 02             	shl    eax,0x2
     7d7:	83 ec 08             	sub    esp,0x8
     7da:	50                   	push   eax
     7db:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
     7de:	e8 fc ff ff ff       	call   7df <memdev_store_node+0xe3>
     7e3:	83 c4 10             	add    esp,0x10
								if (!__sync_bool_compare_and_swap(&ns[i], NULL, ns2)) {
     7e6:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     7e9:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     7ec:	8d 0c 85 00 00 00 00 	lea    ecx,[eax*4+0x0]
     7f3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     7f6:	01 c1                	add    ecx,eax
     7f8:	b8 00 00 00 00       	mov    eax,0x0
     7fd:	f0 0f b1 11          	lock cmpxchg DWORD PTR [ecx],edx
     801:	0f 94 c0             	sete   al
     804:	83 f0 01             	xor    eax,0x1
     807:	84 c0                	test   al,al
     809:	74 2d                	je     838 <memdev_store_node+0x13c>
										h_free(memdev_data->heap, ns2);
     80b:	a1 00 00 00 00       	mov    eax,ds:0x0
     810:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     813:	83 ec 08             	sub    esp,0x8
     816:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
     819:	50                   	push   eax
     81a:	e8 fc ff ff ff       	call   81b <memdev_store_node+0x11f>
     81f:	83 c4 10             	add    esp,0x10
										ns = (struct memdev_node**)ns[i];
     822:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     825:	8d 14 85 00 00 00 00 	lea    edx,[eax*4+0x0]
     82c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     82f:	01 d0                	add    eax,edx
     831:	8b 00                	mov    eax,DWORD PTR [eax]
     833:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     836:	eb 06                	jmp    83e <memdev_store_node+0x142>
										ns = ns2;
     838:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     83b:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						i = 0;
     83e:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
		for (i = 0; i < memdev_data->node_cap_bts; i++) {
     845:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
     849:	a1 00 00 00 00       	mov    eax,ds:0x0
     84e:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     851:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
     854:	0f 82 bf fe ff ff    	jb     719 <memdev_store_node+0x1d>
		return NULL;
     85a:	b8 00 00 00 00       	mov    eax,0x0
}
     85f:	c9                   	leave
     860:	c3                   	ret

00000861 <memdev_register>:
{
     861:	55                   	push   ebp
     862:	89 e5                	mov    ebp,esp
     864:	53                   	push   ebx
     865:	83 ec 24             	sub    esp,0x24
     868:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     86b:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
     86e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     871:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		memdev_data = (struct memdev_data*)kmalloc(sizeof(struct memdev_data));
     874:	83 ec 0c             	sub    esp,0xc
     877:	6a 18                	push   0x18
     879:	e8 fc ff ff ff       	call   87a <memdev_register+0x19>
     87e:	83 c4 10             	add    esp,0x10
     881:	a3 00 00 00 00       	mov    ds:0x0,eax
		if (!memdev_data)
     886:	a1 00 00 00 00       	mov    eax,ds:0x0
     88b:	85 c0                	test   eax,eax
     88d:	75 0a                	jne    899 <memdev_register+0x38>
				return -1;
     88f:	b8 ff ff ff ff       	mov    eax,0xffffffff
     894:	e9 3f 01 00 00       	jmp    9d8 <memdev_register+0x177>
		memdev_data->id = d;
     899:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
     89f:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     8a2:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
     8a5:	89 01                	mov    DWORD PTR [ecx],eax
     8a7:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		memdev_data->node_ct = 0;
     8aa:	a1 00 00 00 00       	mov    eax,ds:0x0
     8af:	c7 40 0c 00 00 00 00 	mov    DWORD PTR [eax+0xc],0x0
		memdev_data->node_cap_bts = 4096;
     8b6:	a1 00 00 00 00       	mov    eax,ds:0x0
     8bb:	c7 40 10 00 10 00 00 	mov    DWORD PTR [eax+0x10],0x1000
		memdev_data->heap = mm_alloc_vmem(&mm_kernel, NULL, 25,
     8c2:	8b 1d 00 00 00 00    	mov    ebx,DWORD PTR ds:0x0
     8c8:	6a 0c                	push   0xc
     8ca:	6a 19                	push   0x19
     8cc:	6a 00                	push   0x0
     8ce:	68 00 00 00 00       	push   0x0
     8d3:	e8 fc ff ff ff       	call   8d4 <memdev_register+0x73>
     8d8:	83 c4 10             	add    esp,0x10
     8db:	89 43 14             	mov    DWORD PTR [ebx+0x14],eax
		if (!memdev_data->heap) {
     8de:	a1 00 00 00 00       	mov    eax,ds:0x0
     8e3:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     8e6:	85 c0                	test   eax,eax
     8e8:	75 1b                	jne    905 <memdev_register+0xa4>
				kfree(memdev_data);
     8ea:	a1 00 00 00 00       	mov    eax,ds:0x0
     8ef:	83 ec 0c             	sub    esp,0xc
     8f2:	50                   	push   eax
     8f3:	e8 fc ff ff ff       	call   8f4 <memdev_register+0x93>
     8f8:	83 c4 10             	add    esp,0x10
				return -1;
     8fb:	b8 ff ff ff ff       	mov    eax,0xffffffff
     900:	e9 d3 00 00 00       	jmp    9d8 <memdev_register+0x177>
		ptr = h_create_heap(memdev_data->heap, 25 * 4096, h_generic_oom_handler, h_generic_decommit);
     905:	a1 00 00 00 00       	mov    eax,ds:0x0
     90a:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     90d:	68 00 00 00 00       	push   0x0
     912:	68 00 00 00 00       	push   0x0
     917:	68 00 90 01 00       	push   0x19000
     91c:	50                   	push   eax
     91d:	e8 fc ff ff ff       	call   91e <memdev_register+0xbd>
     922:	83 c4 10             	add    esp,0x10
     925:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!ptr) {
     928:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     92c:	75 33                	jne    961 <memdev_register+0x100>
				mm_free_vmem(&mm_kernel, memdev_data->heap, 25);
     92e:	a1 00 00 00 00       	mov    eax,ds:0x0
     933:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     936:	83 ec 04             	sub    esp,0x4
     939:	6a 19                	push   0x19
     93b:	50                   	push   eax
     93c:	68 00 00 00 00       	push   0x0
     941:	e8 fc ff ff ff       	call   942 <memdev_register+0xe1>
     946:	83 c4 10             	add    esp,0x10
				kfree(memdev_data);
     949:	a1 00 00 00 00       	mov    eax,ds:0x0
     94e:	83 ec 0c             	sub    esp,0xc
     951:	50                   	push   eax
     952:	e8 fc ff ff ff       	call   953 <memdev_register+0xf2>
     957:	83 c4 10             	add    esp,0x10
				return -1;
     95a:	b8 ff ff ff ff       	mov    eax,0xffffffff
     95f:	eb 77                	jmp    9d8 <memdev_register+0x177>
		memdev_data->heap = ptr;
     961:	a1 00 00 00 00       	mov    eax,ds:0x0
     966:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     969:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
		memdev_data->nodes = h_malloc(ptr, 4096 * sizeof(struct memdev_node*));
     96c:	8b 1d 00 00 00 00    	mov    ebx,DWORD PTR ds:0x0
     972:	83 ec 08             	sub    esp,0x8
     975:	68 00 40 00 00       	push   0x4000
     97a:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
     97d:	e8 fc ff ff ff       	call   97e <memdev_register+0x11d>
     982:	83 c4 10             	add    esp,0x10
     985:	89 43 08             	mov    DWORD PTR [ebx+0x8],eax
		if (!memdev_data->nodes) {
     988:	a1 00 00 00 00       	mov    eax,ds:0x0
     98d:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     990:	85 c0                	test   eax,eax
     992:	75 26                	jne    9ba <memdev_register+0x159>
				h_destroy(ptr);
     994:	83 ec 0c             	sub    esp,0xc
     997:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
     99a:	e8 fc ff ff ff       	call   99b <memdev_register+0x13a>
     99f:	83 c4 10             	add    esp,0x10
				kfree(memdev_data);
     9a2:	a1 00 00 00 00       	mov    eax,ds:0x0
     9a7:	83 ec 0c             	sub    esp,0xc
     9aa:	50                   	push   eax
     9ab:	e8 fc ff ff ff       	call   9ac <memdev_register+0x14b>
     9b0:	83 c4 10             	add    esp,0x10
				return -1;
     9b3:	b8 ff ff ff ff       	mov    eax,0xffffffff
     9b8:	eb 1e                	jmp    9d8 <memdev_register+0x177>
		bzero(memdev_data->nodes, 4096 * sizeof(struct memdev_node*));
     9ba:	a1 00 00 00 00       	mov    eax,ds:0x0
     9bf:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     9c2:	83 ec 08             	sub    esp,0x8
     9c5:	68 00 40 00 00       	push   0x4000
     9ca:	50                   	push   eax
     9cb:	e8 fc ff ff ff       	call   9cc <memdev_register+0x16b>
     9d0:	83 c4 10             	add    esp,0x10
		return 0;
     9d3:	b8 00 00 00 00       	mov    eax,0x0
}
     9d8:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     9db:	c9                   	leave
     9dc:	c3                   	ret

000009dd <memdev_unregister>:
{
     9dd:	55                   	push   ebp
     9de:	89 e5                	mov    ebp,esp
		errno = ENOSYS;
     9e0:	c7 05 00 00 00 00 26 00 00 00 	mov    DWORD PTR ds:0x0,0x26
		return -1;
     9ea:	b8 ff ff ff ff       	mov    eax,0xffffffff
}
     9ef:	5d                   	pop    ebp
     9f0:	c3                   	ret

000009f1 <memdev_open>:

/* mode only on O_CREAT which is done externally */
int memdev_open(struct inode* in, int flags/*, mode_t mod*/)
{
     9f1:	55                   	push   ebp
     9f2:	89 e5                	mov    ebp,esp
     9f4:	57                   	push   edi
     9f5:	56                   	push   esi
     9f6:	53                   	push   ebx
     9f7:	83 ec 1c             	sub    esp,0x1c
		struct fil_fd* fd; int rv;
		if (!in || in->in_stat.st_dev != memdev_data->id) {
     9fa:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     9fe:	74 22                	je     a22 <memdev_open+0x31>
     a00:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a03:	8b 08                	mov    ecx,DWORD PTR [eax]
     a05:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
     a08:	a1 00 00 00 00       	mov    eax,ds:0x0
     a0d:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     a10:	8b 00                	mov    eax,DWORD PTR [eax]
     a12:	89 cf                	mov    edi,ecx
     a14:	89 c6                	mov    esi,eax
     a16:	89 d9                	mov    ecx,ebx
     a18:	89 f8                	mov    eax,edi
     a1a:	31 f0                	xor    eax,esi
     a1c:	31 ca                	xor    edx,ecx
     a1e:	09 d0                	or     eax,edx
     a20:	74 11                	je     a33 <memdev_open+0x42>
				errno = EINVAL;
     a22:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
				return -1;
     a2c:	b8 ff ff ff ff       	mov    eax,0xffffffff
     a31:	eb 53                	jmp    a86 <memdev_open+0x95>
		}

		/* access checks are done on the level above */
		fd = fil_fd_allocate(in, &rv);
     a33:	83 ec 08             	sub    esp,0x8
     a36:	8d 45 e0             	lea    eax,[ebp-0x20]
     a39:	50                   	push   eax
     a3a:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     a3d:	e8 fc ff ff ff       	call   a3e <memdev_open+0x4d>
     a42:	83 c4 10             	add    esp,0x10
     a45:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		if (!fd) {
     a48:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
     a4c:	75 11                	jne    a5f <memdev_open+0x6e>
				errno = ENOMEM;
     a4e:	c7 05 00 00 00 00 0c 00 00 00 	mov    DWORD PTR ds:0x0,0xc
				return -1;
     a58:	b8 ff ff ff ff       	mov    eax,0xffffffff
     a5d:	eb 27                	jmp    a86 <memdev_open+0x95>
		}

		fd->flags = flags;
     a5f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     a62:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     a65:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
		fd->seek_offset = 0;
     a68:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     a6b:	c7 40 04 00 00 00 00 	mov    DWORD PTR [eax+0x4],0x0
     a72:	c7 40 08 00 00 00 00 	mov    DWORD PTR [eax+0x8],0x0
		__sync_fetch_and_add((int*)in->in_ddat, 1);
     a79:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a7c:	83 c0 68             	add    eax,0x68
     a7f:	f0 83 00 01          	lock add DWORD PTR [eax],0x1
		return rv;
     a83:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
}
     a86:	8d 65 f4             	lea    esp,[ebp-0xc]
     a89:	5b                   	pop    ebx
     a8a:	5e                   	pop    esi
     a8b:	5f                   	pop    edi
     a8c:	5d                   	pop    ebp
     a8d:	c3                   	ret

00000a8e <memdev_read>:

ssize_t memdev_read(struct inode* in, int fd, void* buf, size_t noct)
{
     a8e:	55                   	push   ebp
     a8f:	89 e5                	mov    ebp,esp
     a91:	57                   	push   edi
     a92:	56                   	push   esi
     a93:	53                   	push   ebx
     a94:	83 ec 1c             	sub    esp,0x1c
		struct fil_fd* f; ssize_t rv = 0;
     a97:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
		struct memdev_node* n;
		if (!in || !buf || in->in_stat.st_dev != memdev_data->id) {
     a9e:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     aa2:	74 28                	je     acc <memdev_read+0x3e>
     aa4:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
     aa8:	74 22                	je     acc <memdev_read+0x3e>
     aaa:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     aad:	8b 08                	mov    ecx,DWORD PTR [eax]
     aaf:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
     ab2:	a1 00 00 00 00       	mov    eax,ds:0x0
     ab7:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     aba:	8b 00                	mov    eax,DWORD PTR [eax]
     abc:	89 cf                	mov    edi,ecx
     abe:	89 c6                	mov    esi,eax
     ac0:	89 d9                	mov    ecx,ebx
     ac2:	89 f8                	mov    eax,edi
     ac4:	31 f0                	xor    eax,esi
     ac6:	31 ca                	xor    edx,ecx
     ac8:	09 d0                	or     eax,edx
     aca:	74 14                	je     ae0 <memdev_read+0x52>
				errno = EINVAL;
     acc:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
				return -1;
     ad6:	b8 ff ff ff ff       	mov    eax,0xffffffff
     adb:	e9 16 01 00 00       	jmp    bf6 <memdev_read+0x168>
		}

		f = fil_fd_get(fd);
     ae0:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
     ae3:	e8 fc ff ff ff       	call   ae4 <memdev_read+0x56>
     ae8:	83 c4 04             	add    esp,0x4
     aeb:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		if (!f || (f->flags & O_WRONLY)
     aee:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
     af2:	74 0d                	je     b01 <memdev_read+0x73>
     af4:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     af7:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
     afa:	83 e0 01             	and    eax,0x1
     afd:	85 c0                	test   eax,eax
     aff:	74 14                	je     b15 <memdev_read+0x87>
			/*|| ((f->flags & O_SEARCH) && !S_ISDIR(in->in_stat.st_mode))*/
			/*|| (f->flags & O_EXEC)*/) { /* O_EXEC->mmap with exec */
				errno = EBADF;
     b01:	c7 05 00 00 00 00 09 00 00 00 	mov    DWORD PTR ds:0x0,0x9
				return -1;
     b0b:	b8 ff ff ff ff       	mov    eax,0xffffffff
     b10:	e9 e1 00 00 00       	jmp    bf6 <memdev_read+0x168>
		}

		/* now lock for read access */
		read_lock(&in->in_lock);
     b15:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     b18:	83 c0 74             	add    eax,0x74
     b1b:	83 ec 0c             	sub    esp,0xc
     b1e:	50                   	push   eax
     b1f:	e8 fc ff ff ff       	call   b20 <memdev_read+0x92>
     b24:	83 c4 10             	add    esp,0x10
		n = *(struct memdev_node**)in->in_pddat;
     b27:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     b2a:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
     b2d:	8b 00                	mov    eax,DWORD PTR [eax]
     b2f:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		if (f->seek_offset < (n->size - sizeof(struct memdev_node))) {
     b32:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     b35:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
     b38:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     b3b:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
     b3e:	8b 49 04             	mov    ecx,DWORD PTR [ecx+0x4]
     b41:	83 e9 10             	sub    ecx,0x10
     b44:	bb 00 00 00 00       	mov    ebx,0x0
     b49:	39 c8                	cmp    eax,ecx
     b4b:	89 d0                	mov    eax,edx
     b4d:	19 d8                	sbb    eax,ebx
     b4f:	7d 67                	jge    bb8 <memdev_read+0x12a>
				/* read up to noct bytes */
				rv = n->size - sizeof(struct memdev_node) - f->seek_offset;
     b51:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     b54:	8b 48 04             	mov    ecx,DWORD PTR [eax+0x4]
     b57:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     b5a:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
     b5d:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     b60:	89 c2                	mov    edx,eax
     b62:	89 c8                	mov    eax,ecx
     b64:	29 d0                	sub    eax,edx
     b66:	83 e8 10             	sub    eax,0x10
     b69:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				if ((size_t)rv > noct)
     b6c:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     b6f:	39 45 14             	cmp    DWORD PTR [ebp+0x14],eax
     b72:	73 06                	jae    b7a <memdev_read+0xec>
						rv = noct;
     b74:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     b77:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				memcpy(buf, n->data + f->seek_offset, rv);
     b7a:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
     b7d:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     b80:	8d 58 10             	lea    ebx,[eax+0x10]
     b83:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     b86:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
     b89:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     b8c:	01 d8                	add    eax,ebx
     b8e:	83 ec 04             	sub    esp,0x4
     b91:	51                   	push   ecx
     b92:	50                   	push   eax
     b93:	ff 75 10             	push   DWORD PTR [ebp+0x10]
     b96:	e8 65 f4 ff ff       	call   0 <memcpy>
     b9b:	83 c4 10             	add    esp,0x10
				f->seek_offset += rv;
     b9e:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     ba1:	8b 48 04             	mov    ecx,DWORD PTR [eax+0x4]
     ba4:	8b 58 08             	mov    ebx,DWORD PTR [eax+0x8]
     ba7:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     baa:	99                   	cdq
     bab:	01 c8                	add    eax,ecx
     bad:	11 da                	adc    edx,ebx
     baf:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
     bb2:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
     bb5:	89 51 08             	mov    DWORD PTR [ecx+0x8],edx
		}
		if (rv > 0 && !(f->flags & O_NOATIME)) {/* set atime */
     bb8:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
     bbc:	7e 23                	jle    be1 <memdev_read+0x153>
     bbe:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     bc1:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
     bc4:	25 00 00 04 00       	and    eax,0x40000
     bc9:	85 c0                	test   eax,eax
     bcb:	75 14                	jne    be1 <memdev_read+0x153>
				clock_gettime(CLOCK_REALTIME, &in->in_stat.st_atim);
     bcd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     bd0:	83 c0 44             	add    eax,0x44
     bd3:	83 ec 08             	sub    esp,0x8
     bd6:	50                   	push   eax
     bd7:	6a 00                	push   0x0
     bd9:	e8 fc ff ff ff       	call   bda <memdev_read+0x14c>
     bde:	83 c4 10             	add    esp,0x10
		}
		read_unlock(&in->in_lock);
     be1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     be4:	83 c0 74             	add    eax,0x74
     be7:	83 ec 0c             	sub    esp,0xc
     bea:	50                   	push   eax
     beb:	e8 fc ff ff ff       	call   bec <memdev_read+0x15e>
     bf0:	83 c4 10             	add    esp,0x10
		return rv;
     bf3:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
}
     bf6:	8d 65 f4             	lea    esp,[ebp-0xc]
     bf9:	5b                   	pop    ebx
     bfa:	5e                   	pop    esi
     bfb:	5f                   	pop    edi
     bfc:	5d                   	pop    ebp
     bfd:	c3                   	ret

00000bfe <memdev_write>:

ssize_t memdev_write(struct inode* in, int fd, const void* buf, size_t noct)
{
     bfe:	55                   	push   ebp
     bff:	89 e5                	mov    ebp,esp
     c01:	57                   	push   edi
     c02:	56                   	push   esi
     c03:	53                   	push   ebx
     c04:	83 ec 2c             	sub    esp,0x2c
		struct fil_fd* f; struct memdev_node* n; size_t s_ext = 0;
     c07:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
		if (!in || !buf || in->in_stat.st_dev != memdev_data->id) {
     c0e:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     c12:	74 28                	je     c3c <memdev_write+0x3e>
     c14:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
     c18:	74 22                	je     c3c <memdev_write+0x3e>
     c1a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c1d:	8b 08                	mov    ecx,DWORD PTR [eax]
     c1f:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
     c22:	a1 00 00 00 00       	mov    eax,ds:0x0
     c27:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
     c2a:	8b 00                	mov    eax,DWORD PTR [eax]
     c2c:	89 cf                	mov    edi,ecx
     c2e:	89 c6                	mov    esi,eax
     c30:	89 d9                	mov    ecx,ebx
     c32:	89 f8                	mov    eax,edi
     c34:	31 f0                	xor    eax,esi
     c36:	31 ca                	xor    edx,ecx
     c38:	09 d0                	or     eax,edx
     c3a:	74 14                	je     c50 <memdev_write+0x52>
				errno = EINVAL;
     c3c:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
				return -1;
     c46:	b8 ff ff ff ff       	mov    eax,0xffffffff
     c4b:	e9 26 03 00 00       	jmp    f76 <memdev_write+0x378>
		}
		if (!(f = fil_fd_get(fd))) {
     c50:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
     c53:	e8 fc ff ff ff       	call   c54 <memdev_write+0x56>
     c58:	83 c4 04             	add    esp,0x4
     c5b:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
     c5e:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
     c62:	75 14                	jne    c78 <memdev_write+0x7a>
				errno = EBADF;
     c64:	c7 05 00 00 00 00 09 00 00 00 	mov    DWORD PTR ds:0x0,0x9
				return -1;
     c6e:	b8 ff ff ff ff       	mov    eax,0xffffffff
     c73:	e9 fe 02 00 00       	jmp    f76 <memdev_write+0x378>
		}

		/* acquire the lock */
		write_lock(&in->in_lock);
     c78:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c7b:	83 c0 74             	add    eax,0x74
     c7e:	83 ec 0c             	sub    esp,0xc
     c81:	50                   	push   eax
     c82:	e8 fc ff ff ff       	call   c83 <memdev_write+0x85>
     c87:	83 c4 10             	add    esp,0x10
		n = *(struct memdev_node**)in->in_pddat;
     c8a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c8d:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
     c90:	8b 00                	mov    eax,DWORD PTR [eax]
     c92:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		if (f->flags & O_APPEND) /* atomic append */
     c95:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     c98:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
     c9b:	25 00 04 00 00       	and    eax,0x400
     ca0:	85 c0                	test   eax,eax
     ca2:	74 17                	je     cbb <memdev_write+0xbd>
				f->seek_offset = n->size - sizeof(struct memdev_node);
     ca4:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     ca7:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     caa:	83 e8 10             	sub    eax,0x10
     cad:	ba 00 00 00 00       	mov    edx,0x0
     cb2:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
     cb5:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
     cb8:	89 51 08             	mov    DWORD PTR [ecx+0x8],edx
		if (f->seek_offset + noct > n->size) {
     cbb:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     cbe:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
     cc1:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     cc4:	8b 4d 14             	mov    ecx,DWORD PTR [ebp+0x14]
     cc7:	bb 00 00 00 00       	mov    ebx,0x0
     ccc:	01 c8                	add    eax,ecx
     cce:	11 da                	adc    edx,ebx
     cd0:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
     cd3:	8b 49 04             	mov    ecx,DWORD PTR [ecx+0x4]
     cd6:	bb 00 00 00 00       	mov    ebx,0x0
     cdb:	39 c1                	cmp    ecx,eax
     cdd:	19 d3                	sbb    ebx,edx
     cdf:	0f 8d f8 01 00 00    	jge    edd <memdev_write+0x2df>
				/* we have to extend */
				s_ext = f->seek_offset + noct + sizeof(struct memdev_node);
     ce5:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     ce8:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
     ceb:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     cee:	89 c2                	mov    edx,eax
     cf0:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     cf3:	01 d0                	add    eax,edx
     cf5:	83 c0 10             	add    eax,0x10
     cf8:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
				if (s_ext > n->cap) { /* really */
     cfb:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     cfe:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     d01:	3b 45 e0             	cmp    eax,DWORD PTR [ebp-0x20]
     d04:	0f 83 7a 01 00 00    	jae    e84 <memdev_write+0x286>
						size_t new_cap; void* mem;
						if (S_ISREG(in->in_stat.st_mode)) {
     d0a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     d0d:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     d10:	25 00 f0 00 00       	and    eax,0xf000
     d15:	3d 00 80 00 00       	cmp    eax,0x8000
     d1a:	0f 85 b0 00 00 00    	jne    dd0 <memdev_write+0x1d2>
								/* work on pages */
								new_cap = s_ext / 4096 + (s_ext % 4096 ? 1 : 0) * 4096;
     d20:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     d23:	c1 e8 0c             	shr    eax,0xc
     d26:	89 c2                	mov    edx,eax
     d28:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     d2b:	25 ff 0f 00 00       	and    eax,0xfff
     d30:	85 c0                	test   eax,eax
     d32:	74 07                	je     d3b <memdev_write+0x13d>
     d34:	b8 00 10 00 00       	mov    eax,0x1000
     d39:	eb 05                	jmp    d40 <memdev_write+0x142>
     d3b:	b8 00 00 00 00       	mov    eax,0x0
     d40:	01 d0                	add    eax,edx
     d42:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
								mem = mm_extend_vmem(&mm_kernel, n, n->cap / 4096,
     d45:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     d48:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     d4b:	c1 e8 0c             	shr    eax,0xc
     d4e:	83 ec 0c             	sub    esp,0xc
     d51:	6a 0c                	push   0xc
     d53:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
     d56:	50                   	push   eax
     d57:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
     d5a:	68 00 00 00 00       	push   0x0
     d5f:	e8 fc ff ff ff       	call   d60 <memdev_write+0x162>
     d64:	83 c4 20             	add    esp,0x20
     d67:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
												new_cap, MMGR_MAP_WRITE | MMGR_MAP_KERNEL);
								if (mem) {
     d6a:	83 7d d4 00          	cmp    DWORD PTR [ebp-0x2c],0x0
     d6e:	74 2d                	je     d9d <memdev_write+0x19f>
										n = (struct memdev_node*)mem;
     d70:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     d73:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
										*(struct memdev_node**)in->in_pddat = n;
     d76:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     d79:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
     d7c:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
     d7f:	89 10                	mov    DWORD PTR [eax],edx
										n->cap = new_cap * 4096;
     d81:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     d84:	c1 e0 0c             	shl    eax,0xc
     d87:	89 c2                	mov    edx,eax
     d89:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     d8c:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
										n->size = s_ext;
     d8f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     d92:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
     d95:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
     d98:	e9 f3 00 00 00       	jmp    e90 <memdev_write+0x292>
								} else { /* write partially */
										noct = n->cap - n->size;
     d9d:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     da0:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
     da3:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     da6:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     da9:	29 c2                	sub    edx,eax
     dab:	89 55 14             	mov    DWORD PTR [ebp+0x14],edx
										n->size = n->cap;
     dae:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     db1:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
     db4:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     db7:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
										if (!noct)
     dba:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     dbe:	0f 85 cc 00 00 00    	jne    e90 <memdev_write+0x292>
												noct = -1;
     dc4:	c7 45 14 ff ff ff ff 	mov    DWORD PTR [ebp+0x14],0xffffffff
     dcb:	e9 c0 00 00 00       	jmp    e90 <memdev_write+0x292>
								}
						} else if (S_ISDIR(in->in_stat.st_mode) || S_ISLNK(in->in_stat.st_mode)) {
     dd0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     dd3:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     dd6:	25 00 f0 00 00       	and    eax,0xf000
     ddb:	3d 00 40 00 00       	cmp    eax,0x4000
     de0:	74 12                	je     df4 <memdev_write+0x1f6>
     de2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     de5:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     de8:	25 00 f0 00 00       	and    eax,0xf000
     ded:	3d 00 a0 00 00       	cmp    eax,0xa000
     df2:	75 7d                	jne    e71 <memdev_write+0x273>
								/* heap memory */
								new_cap = s_ext + 32; /* prevent many resizes */
     df4:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     df7:	83 c0 20             	add    eax,0x20
     dfa:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
								mem = h_realloc(memdev_data->heap, n, new_cap);
     dfd:	a1 00 00 00 00       	mov    eax,ds:0x0
     e02:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     e05:	83 ec 04             	sub    esp,0x4
     e08:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
     e0b:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
     e0e:	50                   	push   eax
     e0f:	e8 fc ff ff ff       	call   e10 <memdev_write+0x212>
     e14:	83 c4 10             	add    esp,0x10
     e17:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
								if (!mem) { /* write partially */
     e1a:	83 7d d4 00          	cmp    DWORD PTR [ebp-0x2c],0x0
     e1e:	75 2c                	jne    e4c <memdev_write+0x24e>
										noct = n->cap - n->size;
     e20:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     e23:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
     e26:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     e29:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     e2c:	29 c2                	sub    edx,eax
     e2e:	89 55 14             	mov    DWORD PTR [ebp+0x14],edx
										n->size = n->cap;
     e31:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     e34:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
     e37:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     e3a:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
										if (!noct)
     e3d:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     e41:	75 4c                	jne    e8f <memdev_write+0x291>
												noct = -1;
     e43:	c7 45 14 ff ff ff ff 	mov    DWORD PTR [ebp+0x14],0xffffffff
								if (!mem) { /* write partially */
     e4a:	eb 43                	jmp    e8f <memdev_write+0x291>
								} else {
										n = (struct memdev_node*)mem;
     e4c:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     e4f:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
										*(struct memdev_node**)in->in_pddat = n;
     e52:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     e55:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
     e58:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
     e5b:	89 10                	mov    DWORD PTR [eax],edx
										n->cap = new_cap;
     e5d:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     e60:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
     e63:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
										n->size = s_ext;
     e66:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     e69:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
     e6c:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
								if (!mem) { /* write partially */
     e6f:	eb 1e                	jmp    e8f <memdev_write+0x291>
								}
						} else {
								/* wat do? */
								errno = ENOSYS;
     e71:	c7 05 00 00 00 00 26 00 00 00 	mov    DWORD PTR ds:0x0,0x26
								noct = -1;
     e7b:	c7 45 14 ff ff ff ff 	mov    DWORD PTR [ebp+0x14],0xffffffff
     e82:	eb 0c                	jmp    e90 <memdev_write+0x292>
						}
				} else
						n->size = s_ext;
     e84:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     e87:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
     e8a:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
     e8d:	eb 01                	jmp    e90 <memdev_write+0x292>
								if (!mem) { /* write partially */
     e8f:	90                   	nop
				in->in_stat.st_size = n->size - sizeof(struct memdev_node);
     e90:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     e93:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     e96:	83 e8 10             	sub    eax,0x10
     e99:	ba 00 00 00 00       	mov    edx,0x0
     e9e:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
     ea1:	89 41 2c             	mov    DWORD PTR [ecx+0x2c],eax
     ea4:	89 51 30             	mov    DWORD PTR [ecx+0x30],edx
				in->in_stat.st_size = n->cap / 512 + (n->cap % 512 ? 1 : 0);
     ea7:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     eaa:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     ead:	c1 e8 09             	shr    eax,0x9
     eb0:	89 c2                	mov    edx,eax
     eb2:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     eb5:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     eb8:	25 ff 01 00 00       	and    eax,0x1ff
     ebd:	85 c0                	test   eax,eax
     ebf:	74 07                	je     ec8 <memdev_write+0x2ca>
     ec1:	b8 01 00 00 00       	mov    eax,0x1
     ec6:	eb 05                	jmp    ecd <memdev_write+0x2cf>
     ec8:	b8 00 00 00 00       	mov    eax,0x0
     ecd:	01 d0                	add    eax,edx
     ecf:	ba 00 00 00 00       	mov    edx,0x0
     ed4:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
     ed7:	89 41 2c             	mov    DWORD PTR [ecx+0x2c],eax
     eda:	89 51 30             	mov    DWORD PTR [ecx+0x30],edx
		}
		/* now copy the data */
		memcpy(n->data + f->seek_offset, buf, noct);
     edd:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     ee0:	8d 48 10             	lea    ecx,[eax+0x10]
     ee3:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     ee6:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
     ee9:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     eec:	01 c8                	add    eax,ecx
     eee:	83 ec 04             	sub    esp,0x4
     ef1:	ff 75 14             	push   DWORD PTR [ebp+0x14]
     ef4:	ff 75 10             	push   DWORD PTR [ebp+0x10]
     ef7:	50                   	push   eax
     ef8:	e8 03 f1 ff ff       	call   0 <memcpy>
     efd:	83 c4 10             	add    esp,0x10
		/* and update the times */
		if (noct > 0) {
     f00:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     f04:	74 5b                	je     f61 <memdev_write+0x363>
				clock_gettime(CLOCK_REALTIME, &in->in_stat.st_mtim);
     f06:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     f09:	83 c0 50             	add    eax,0x50
     f0c:	83 ec 08             	sub    esp,0x8
     f0f:	50                   	push   eax
     f10:	6a 00                	push   0x0
     f12:	e8 fc ff ff ff       	call   f13 <memdev_write+0x315>
     f17:	83 c4 10             	add    esp,0x10
				in->in_stat.st_ctim = in->in_stat.st_mtim;
     f1a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     f1d:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     f20:	8b 4a 50             	mov    ecx,DWORD PTR [edx+0x50]
     f23:	89 48 5c             	mov    DWORD PTR [eax+0x5c],ecx
     f26:	8b 4a 54             	mov    ecx,DWORD PTR [edx+0x54]
     f29:	89 48 60             	mov    DWORD PTR [eax+0x60],ecx
     f2c:	8b 52 58             	mov    edx,DWORD PTR [edx+0x58]
     f2f:	89 50 64             	mov    DWORD PTR [eax+0x64],edx
				f->seek_offset += noct; /* only forward (-1 for errno) */
     f32:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     f35:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
     f38:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
     f3b:	8b 4d 14             	mov    ecx,DWORD PTR [ebp+0x14]
     f3e:	bb 00 00 00 00       	mov    ebx,0x0
     f43:	01 c8                	add    eax,ecx
     f45:	11 da                	adc    edx,ebx
     f47:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
     f4a:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
     f4d:	89 51 08             	mov    DWORD PTR [ecx+0x8],edx
				/* clear SUID,SGID */
				in->in_stat.st_mode &= (~(mode_t)S_ISUID) & (~(mode_t)S_ISGID);
     f50:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     f53:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     f56:	80 e4 f3             	and    ah,0xf3
     f59:	89 c2                	mov    edx,eax
     f5b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     f5e:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
		}
		write_unlock(&in->in_lock);
     f61:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     f64:	83 c0 74             	add    eax,0x74
     f67:	83 ec 0c             	sub    esp,0xc
     f6a:	50                   	push   eax
     f6b:	e8 fc ff ff ff       	call   f6c <memdev_write+0x36e>
     f70:	83 c4 10             	add    esp,0x10
		return noct;
     f73:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
}
     f76:	8d 65 f4             	lea    esp,[ebp-0xc]
     f79:	5b                   	pop    ebx
     f7a:	5e                   	pop    esi
     f7b:	5f                   	pop    edi
     f7c:	5d                   	pop    ebp
     f7d:	c3                   	ret

00000f7e <memdev_close>:

int memdev_close(struct inode* in, int fd)
{
     f7e:	55                   	push   ebp
     f7f:	89 e5                	mov    ebp,esp
     f81:	83 ec 18             	sub    esp,0x18
		struct fil_fd* f;
		if (!in || !(f = fil_fd_get(fd))) {
     f84:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     f88:	74 14                	je     f9e <memdev_close+0x20>
     f8a:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
     f8d:	e8 fc ff ff ff       	call   f8e <memdev_close+0x10>
     f92:	83 c4 04             	add    esp,0x4
     f95:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
     f98:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     f9c:	75 21                	jne    fbf <memdev_close+0x41>
				errno = in ? EBADF : EINVAL;
     f9e:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     fa2:	74 07                	je     fab <memdev_close+0x2d>
     fa4:	b8 09 00 00 00       	mov    eax,0x9
     fa9:	eb 05                	jmp    fb0 <memdev_close+0x32>
     fab:	b8 16 00 00 00       	mov    eax,0x16
     fb0:	a3 00 00 00 00       	mov    ds:0x0,eax
				return -1;
     fb5:	b8 ff ff ff ff       	mov    eax,0xffffffff
     fba:	e9 b4 00 00 00       	jmp    1073 <memdev_close+0xf5>
		}
		/* TODO: file locks */
		fil_fd_free(fd);
     fbf:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
     fc2:	e8 fc ff ff ff       	call   fc3 <memdev_close+0x45>
     fc7:	83 c4 04             	add    esp,0x4
		if (__sync_sub_and_fetch((int*)in->in_ddat, 1) == 0) {
     fca:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     fcd:	8d 50 68             	lea    edx,[eax+0x68]
     fd0:	b8 01 00 00 00       	mov    eax,0x1
     fd5:	f7 d8                	neg    eax
     fd7:	89 c1                	mov    ecx,eax
     fd9:	89 c8                	mov    eax,ecx
     fdb:	f0 0f c1 02          	lock xadd DWORD PTR [edx],eax
     fdf:	01 c8                	add    eax,ecx
     fe1:	85 c0                	test   eax,eax
     fe3:	0f 85 85 00 00 00    	jne    106e <memdev_close+0xf0>
				struct memdev_node* n;
				if (in->in_stat.st_nlink)
     fe9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     fec:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
     fef:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
     ff2:	89 c1                	mov    ecx,eax
     ff4:	89 c8                	mov    eax,ecx
     ff6:	09 d0                	or     eax,edx
     ff8:	74 07                	je     1001 <memdev_close+0x83>
						return 0;
     ffa:	b8 00 00 00 00       	mov    eax,0x0
     fff:	eb 72                	jmp    1073 <memdev_close+0xf5>
				/* nlink==0 && nref==0 */
				n = *(struct memdev_node**)in->in_pddat;
    1001:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1004:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
    1007:	8b 00                	mov    eax,DWORD PTR [eax]
    1009:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				*(struct memdev_node**)in->in_pddat = NULL; /* free slot */
    100c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    100f:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
    1012:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
				if (S_ISREG(in->in_stat.st_mode))
    1018:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    101b:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    101e:	25 00 f0 00 00       	and    eax,0xf000
    1023:	3d 00 80 00 00       	cmp    eax,0x8000
    1028:	75 1f                	jne    1049 <memdev_close+0xcb>
						mm_free_vmem(&mm_kernel, n, n->cap / 4096);
    102a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    102d:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1030:	c1 e8 0c             	shr    eax,0xc
    1033:	83 ec 04             	sub    esp,0x4
    1036:	50                   	push   eax
    1037:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    103a:	68 00 00 00 00       	push   0x0
    103f:	e8 fc ff ff ff       	call   1040 <memdev_close+0xc2>
    1044:	83 c4 10             	add    esp,0x10
    1047:	eb 17                	jmp    1060 <memdev_close+0xe2>
				else
						h_free(memdev_data->heap, n);
    1049:	a1 00 00 00 00       	mov    eax,ds:0x0
    104e:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    1051:	83 ec 08             	sub    esp,0x8
    1054:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    1057:	50                   	push   eax
    1058:	e8 fc ff ff ff       	call   1059 <memdev_close+0xdb>
    105d:	83 c4 10             	add    esp,0x10
				ino_release(in);
    1060:	83 ec 0c             	sub    esp,0xc
    1063:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1066:	e8 fc ff ff ff       	call   1067 <memdev_close+0xe9>
    106b:	83 c4 10             	add    esp,0x10
		}
		return 0;
    106e:	b8 00 00 00 00       	mov    eax,0x0
}
    1073:	c9                   	leave
    1074:	c3                   	ret

00001075 <memdev_lseek>:

off_t memdev_lseek(struct inode* in, int fd, off_t offset, int ref)
{
    1075:	55                   	push   ebp
    1076:	89 e5                	mov    ebp,esp
    1078:	57                   	push   edi
    1079:	56                   	push   esi
    107a:	53                   	push   ebx
    107b:	83 ec 1c             	sub    esp,0x1c
    107e:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1081:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    1084:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1087:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
		struct fil_fd* f;
		if (!in || in->in_stat.st_dev != memdev_data->id) {
    108a:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    108e:	74 22                	je     10b2 <memdev_lseek+0x3d>
    1090:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1093:	8b 08                	mov    ecx,DWORD PTR [eax]
    1095:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    1098:	a1 00 00 00 00       	mov    eax,ds:0x0
    109d:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    10a0:	8b 00                	mov    eax,DWORD PTR [eax]
    10a2:	89 cf                	mov    edi,ecx
    10a4:	89 c6                	mov    esi,eax
    10a6:	89 d9                	mov    ecx,ebx
    10a8:	89 f8                	mov    eax,edi
    10aa:	31 f0                	xor    eax,esi
    10ac:	31 ca                	xor    edx,ecx
    10ae:	09 d0                	or     eax,edx
    10b0:	74 19                	je     10cb <memdev_lseek+0x56>
				errno = EINVAL;
    10b2:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
				return -1;
    10bc:	b8 ff ff ff ff       	mov    eax,0xffffffff
    10c1:	ba ff ff ff ff       	mov    edx,0xffffffff
    10c6:	e9 a8 00 00 00       	jmp    1173 <memdev_lseek+0xfe>
		}
		if (!(f = fil_fd_get(fd))) {
    10cb:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    10ce:	e8 fc ff ff ff       	call   10cf <memdev_lseek+0x5a>
    10d3:	83 c4 04             	add    esp,0x4
    10d6:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    10d9:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    10dd:	75 16                	jne    10f5 <memdev_lseek+0x80>
				errno = EBADF;
    10df:	c7 05 00 00 00 00 09 00 00 00 	mov    DWORD PTR ds:0x0,0x9
				return -1;
    10e9:	b8 ff ff ff ff       	mov    eax,0xffffffff
    10ee:	ba ff ff ff ff       	mov    edx,0xffffffff
    10f3:	eb 7e                	jmp    1173 <memdev_lseek+0xfe>
		}
		/* not thread-safe as sharing FDs is not thread-safe */
		if (ref == SEEK_SET)
    10f5:	83 7d 18 00          	cmp    DWORD PTR [ebp+0x18],0x0
    10f9:	75 11                	jne    110c <memdev_lseek+0x97>
				f->seek_offset = offset;
    10fb:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
    10fe:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1101:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1104:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
    1107:	89 51 08             	mov    DWORD PTR [ecx+0x8],edx
    110a:	eb 5e                	jmp    116a <memdev_lseek+0xf5>
		else if (ref == SEEK_CUR)
    110c:	83 7d 18 01          	cmp    DWORD PTR [ebp+0x18],0x1
    1110:	75 1e                	jne    1130 <memdev_lseek+0xbb>
				f->seek_offset += offset;
    1112:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1115:	8b 48 04             	mov    ecx,DWORD PTR [eax+0x4]
    1118:	8b 58 08             	mov    ebx,DWORD PTR [eax+0x8]
    111b:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    111e:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1121:	01 c8                	add    eax,ecx
    1123:	11 da                	adc    edx,ebx
    1125:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
    1128:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
    112b:	89 51 08             	mov    DWORD PTR [ecx+0x8],edx
    112e:	eb 3a                	jmp    116a <memdev_lseek+0xf5>
		else if (ref == SEEK_END) {
    1130:	83 7d 18 02          	cmp    DWORD PTR [ebp+0x18],0x2
    1134:	75 1e                	jne    1154 <memdev_lseek+0xdf>
				f->seek_offset = in->in_stat.st_size + offset;
    1136:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1139:	8b 48 2c             	mov    ecx,DWORD PTR [eax+0x2c]
    113c:	8b 58 30             	mov    ebx,DWORD PTR [eax+0x30]
    113f:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1142:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1145:	01 c8                	add    eax,ecx
    1147:	11 da                	adc    edx,ebx
    1149:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
    114c:	89 41 04             	mov    DWORD PTR [ecx+0x4],eax
    114f:	89 51 08             	mov    DWORD PTR [ecx+0x8],edx
    1152:	eb 16                	jmp    116a <memdev_lseek+0xf5>
		} else {
				errno = EINVAL;
    1154:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
				return -1;
    115e:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1163:	ba ff ff ff ff       	mov    edx,0xffffffff
    1168:	eb 09                	jmp    1173 <memdev_lseek+0xfe>
		}
		return f->seek_offset;
    116a:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    116d:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    1170:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
}
    1173:	8d 65 f4             	lea    esp,[ebp-0xc]
    1176:	5b                   	pop    ebx
    1177:	5e                   	pop    esi
    1178:	5f                   	pop    edi
    1179:	5d                   	pop    ebp
    117a:	c3                   	ret

0000117b <memdev_truncate>:

int memdev_truncate(struct inode* in, off_t length)
{
    117b:	55                   	push   ebp
    117c:	89 e5                	mov    ebp,esp
    117e:	57                   	push   edi
    117f:	56                   	push   esi
    1180:	53                   	push   ebx
    1181:	83 ec 3c             	sub    esp,0x3c
    1184:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1187:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
    118a:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    118d:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
		struct memdev_node* n; off_t len;
		if (!in || in->in_stat.st_dev != memdev_data->id) {
    1190:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    1194:	74 22                	je     11b8 <memdev_truncate+0x3d>
    1196:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1199:	8b 08                	mov    ecx,DWORD PTR [eax]
    119b:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    119e:	a1 00 00 00 00       	mov    eax,ds:0x0
    11a3:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    11a6:	8b 00                	mov    eax,DWORD PTR [eax]
    11a8:	89 cf                	mov    edi,ecx
    11aa:	89 c6                	mov    esi,eax
    11ac:	89 d9                	mov    ecx,ebx
    11ae:	89 f8                	mov    eax,edi
    11b0:	31 f0                	xor    eax,esi
    11b2:	31 ca                	xor    edx,ecx
    11b4:	09 d0                	or     eax,edx
    11b6:	74 14                	je     11cc <memdev_truncate+0x51>
				errno = EINVAL;
    11b8:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
				return -1;
    11c2:	b8 ff ff ff ff       	mov    eax,0xffffffff
    11c7:	e9 28 02 00 00       	jmp    13f4 <memdev_truncate+0x279>
		}

		/* only work on regular files (i.e. memory pages) */
		if (!S_ISREG(in->in_stat.st_mode)) {
    11cc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    11cf:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    11d2:	25 00 f0 00 00       	and    eax,0xf000
    11d7:	3d 00 80 00 00       	cmp    eax,0x8000
    11dc:	74 14                	je     11f2 <memdev_truncate+0x77>
				errno = EINVAL;
    11de:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
				return -1;
    11e8:	b8 ff ff ff ff       	mov    eax,0xffffffff
    11ed:	e9 02 02 00 00       	jmp    13f4 <memdev_truncate+0x279>
		}

		/* modify the file */
		write_lock(&in->in_lock);
    11f2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    11f5:	83 c0 74             	add    eax,0x74
    11f8:	83 ec 0c             	sub    esp,0xc
    11fb:	50                   	push   eax
    11fc:	e8 fc ff ff ff       	call   11fd <memdev_truncate+0x82>
    1201:	83 c4 10             	add    esp,0x10
		n = *(struct memdev_node**)in->in_pddat;
    1204:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1207:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
    120a:	8b 00                	mov    eax,DWORD PTR [eax]
    120c:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		len = n->size - sizeof(struct memdev_node);
    120f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1212:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1215:	83 e8 10             	sub    eax,0x10
    1218:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    121b:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
		if (len > length) { /* shrink */
    1222:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1225:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1228:	8b 4d c4             	mov    ecx,DWORD PTR [ebp-0x3c]
    122b:	39 45 c0             	cmp    DWORD PTR [ebp-0x40],eax
    122e:	19 d1                	sbb    ecx,edx
    1230:	7d 58                	jge    128a <memdev_truncate+0x10f>
				size_t num_p;
				n->size = length + sizeof(struct memdev_node);
    1232:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    1235:	8d 50 10             	lea    edx,[eax+0x10]
    1238:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    123b:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
				num_p = (n->cap - n->size) / 4096;
    123e:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1241:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    1244:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1247:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    124a:	29 c2                	sub    edx,eax
    124c:	89 d0                	mov    eax,edx
    124e:	c1 e8 0c             	shr    eax,0xc
    1251:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
				if (num_p)
    1254:	83 7d cc 00          	cmp    DWORD PTR [ebp-0x34],0x0
    1258:	0f 84 1c 01 00 00    	je     137a <memdev_truncate+0x1ff>
						mm_free_vmem(&mm_kernel, (char*)n + n->cap - num_p * 4096, num_p);
    125e:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1261:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    1264:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1267:	c1 e0 0c             	shl    eax,0xc
    126a:	29 c2                	sub    edx,eax
    126c:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    126f:	01 d0                	add    eax,edx
    1271:	83 ec 04             	sub    esp,0x4
    1274:	ff 75 cc             	push   DWORD PTR [ebp-0x34]
    1277:	50                   	push   eax
    1278:	68 00 00 00 00       	push   0x0
    127d:	e8 fc ff ff ff       	call   127e <memdev_truncate+0x103>
    1282:	83 c4 10             	add    esp,0x10
    1285:	e9 f0 00 00 00       	jmp    137a <memdev_truncate+0x1ff>
		} else if (len < length) { /* grow */
    128a:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    128d:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1290:	3b 45 c0             	cmp    eax,DWORD PTR [ebp-0x40]
    1293:	89 d0                	mov    eax,edx
    1295:	1b 45 c4             	sbb    eax,DWORD PTR [ebp-0x3c]
    1298:	0f 8d dc 00 00 00    	jge    137a <memdev_truncate+0x1ff>
				if ((n->cap - n->size) >= (length - len))
    129e:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    12a1:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    12a4:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    12a7:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    12aa:	29 c2                	sub    edx,eax
    12ac:	89 d1                	mov    ecx,edx
    12ae:	bb 00 00 00 00       	mov    ebx,0x0
    12b3:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    12b6:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    12b9:	2b 45 d8             	sub    eax,DWORD PTR [ebp-0x28]
    12bc:	1b 55 dc             	sbb    edx,DWORD PTR [ebp-0x24]
    12bf:	39 c1                	cmp    ecx,eax
    12c1:	19 d3                	sbb    ebx,edx
    12c3:	7c 11                	jl     12d6 <memdev_truncate+0x15b>
						n->size = length + sizeof(struct memdev_node);
    12c5:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    12c8:	8d 50 10             	lea    edx,[eax+0x10]
    12cb:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    12ce:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
    12d1:	e9 a4 00 00 00       	jmp    137a <memdev_truncate+0x1ff>
				else { /* allocate new pages */
						size_t num_p; void* mem;
						num_p = n->size + (length - len);
    12d6:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    12d9:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    12dc:	8b 4d c0             	mov    ecx,DWORD PTR [ebp-0x40]
    12df:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    12e2:	29 c1                	sub    ecx,eax
    12e4:	8d 04 0a             	lea    eax,[edx+ecx*1]
    12e7:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
						num_p = num_p / 4096 + ((num_p % 4096) ? 1 : 0);
    12ea:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    12ed:	c1 e8 0c             	shr    eax,0xc
    12f0:	89 c2                	mov    edx,eax
    12f2:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    12f5:	25 ff 0f 00 00       	and    eax,0xfff
    12fa:	85 c0                	test   eax,eax
    12fc:	74 07                	je     1305 <memdev_truncate+0x18a>
    12fe:	b8 01 00 00 00       	mov    eax,0x1
    1303:	eb 05                	jmp    130a <memdev_truncate+0x18f>
    1305:	b8 00 00 00 00       	mov    eax,0x0
    130a:	01 d0                	add    eax,edx
    130c:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
						mem = mm_extend_vmem(&mm_kernel, n, n->cap / 4096, num_p,
    130f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1312:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1315:	c1 e8 0c             	shr    eax,0xc
    1318:	83 ec 0c             	sub    esp,0xc
    131b:	6a 0c                	push   0xc
    131d:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    1320:	50                   	push   eax
    1321:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
    1324:	68 00 00 00 00       	push   0x0
    1329:	e8 fc ff ff ff       	call   132a <memdev_truncate+0x1af>
    132e:	83 c4 20             	add    esp,0x20
    1331:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
										MMGR_MAP_WRITE | MMGR_MAP_KERNEL);
						/* everything above size is still scrubbed -> no bzero */
						if (!mem) {
    1334:	83 7d d0 00          	cmp    DWORD PTR [ebp-0x30],0x0
    1338:	75 26                	jne    1360 <memdev_truncate+0x1e5>
								/* failed to extend */
								errno = EFBIG;
    133a:	c7 05 00 00 00 00 1b 00 00 00 	mov    DWORD PTR ds:0x0,0x1b
								write_unlock(&in->in_lock);
    1344:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1347:	83 c0 74             	add    eax,0x74
    134a:	83 ec 0c             	sub    esp,0xc
    134d:	50                   	push   eax
    134e:	e8 fc ff ff ff       	call   134f <memdev_truncate+0x1d4>
    1353:	83 c4 10             	add    esp,0x10
								return -1;
    1356:	b8 ff ff ff ff       	mov    eax,0xffffffff
    135b:	e9 94 00 00 00       	jmp    13f4 <memdev_truncate+0x279>
						}
						n->cap = num_p * 4096;
    1360:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1363:	c1 e0 0c             	shl    eax,0xc
    1366:	89 c2                	mov    edx,eax
    1368:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    136b:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
						n->size = length + sizeof(struct memdev_node);
    136e:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    1371:	8d 50 10             	lea    edx,[eax+0x10]
    1374:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1377:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
				}
		} else { } /* do nothing */

		/* clear SUID,SGID */
		in->in_stat.st_mode &= (~(mode_t)S_ISUID) & (~(mode_t)S_ISGID);
    137a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    137d:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1380:	80 e4 f3             	and    ah,0xf3
    1383:	89 c2                	mov    edx,eax
    1385:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1388:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
		in->in_stat.st_size = length;
    138b:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    138e:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    1391:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    1394:	89 41 2c             	mov    DWORD PTR [ecx+0x2c],eax
    1397:	89 51 30             	mov    DWORD PTR [ecx+0x30],edx
		in->in_stat.st_blocks = n->cap / 512;
    139a:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    139d:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    13a0:	c1 e8 09             	shr    eax,0x9
    13a3:	ba 00 00 00 00       	mov    edx,0x0
    13a8:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    13ab:	89 41 3c             	mov    DWORD PTR [ecx+0x3c],eax
    13ae:	89 51 40             	mov    DWORD PTR [ecx+0x40],edx
		/* always update c&mtim (as in ftruncate) */
		clock_gettime(CLOCK_REALTIME, &in->in_stat.st_mtim);
    13b1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    13b4:	83 c0 50             	add    eax,0x50
    13b7:	83 ec 08             	sub    esp,0x8
    13ba:	50                   	push   eax
    13bb:	6a 00                	push   0x0
    13bd:	e8 fc ff ff ff       	call   13be <memdev_truncate+0x243>
    13c2:	83 c4 10             	add    esp,0x10
		in->in_stat.st_ctim = in->in_stat.st_mtim;
    13c5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    13c8:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    13cb:	8b 4a 50             	mov    ecx,DWORD PTR [edx+0x50]
    13ce:	89 48 5c             	mov    DWORD PTR [eax+0x5c],ecx
    13d1:	8b 4a 54             	mov    ecx,DWORD PTR [edx+0x54]
    13d4:	89 48 60             	mov    DWORD PTR [eax+0x60],ecx
    13d7:	8b 52 58             	mov    edx,DWORD PTR [edx+0x58]
    13da:	89 50 64             	mov    DWORD PTR [eax+0x64],edx
		write_unlock(&in->in_lock);
    13dd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    13e0:	83 c0 74             	add    eax,0x74
    13e3:	83 ec 0c             	sub    esp,0xc
    13e6:	50                   	push   eax
    13e7:	e8 fc ff ff ff       	call   13e8 <memdev_truncate+0x26d>
    13ec:	83 c4 10             	add    esp,0x10
		return 0;
    13ef:	b8 00 00 00 00       	mov    eax,0x0
}
    13f4:	8d 65 f4             	lea    esp,[ebp-0xc]
    13f7:	5b                   	pop    ebx
    13f8:	5e                   	pop    esi
    13f9:	5f                   	pop    edi
    13fa:	5d                   	pop    ebp
    13fb:	c3                   	ret

000013fc <memdev_search_fn>:

char* memdev_search_fn(struct memdev_node* n, const char* fn)
{
    13fc:	55                   	push   ebp
    13fd:	89 e5                	mov    ebp,esp
    13ff:	83 ec 18             	sub    esp,0x18
		char *str, *end;
		str = n->data;
    1402:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1405:	83 c0 10             	add    eax,0x10
    1408:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		end = (char*)n + n->size;
    140b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    140e:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1411:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1414:	01 d0                	add    eax,edx
    1416:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		while (str < end) {
    1419:	eb 2e                	jmp    1449 <memdev_search_fn+0x4d>
				if (strcmp(str, fn) == 0) {
    141b:	83 ec 08             	sub    esp,0x8
    141e:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    1421:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    1424:	e8 fc ff ff ff       	call   1425 <memdev_search_fn+0x29>
    1429:	83 c4 10             	add    esp,0x10
    142c:	85 c0                	test   eax,eax
    142e:	75 05                	jne    1435 <memdev_search_fn+0x39>
						return str;
    1430:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1433:	eb 21                	jmp    1456 <memdev_search_fn+0x5a>
				}
				str += strlen(str) + sizeof(void*) + 1;
    1435:	83 ec 0c             	sub    esp,0xc
    1438:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    143b:	e8 fc ff ff ff       	call   143c <memdev_search_fn+0x40>
    1440:	83 c4 10             	add    esp,0x10
    1443:	83 c0 05             	add    eax,0x5
    1446:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
		while (str < end) {
    1449:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    144c:	3b 45 f0             	cmp    eax,DWORD PTR [ebp-0x10]
    144f:	72 ca                	jb     141b <memdev_search_fn+0x1f>
		}
		return NULL;
    1451:	b8 00 00 00 00       	mov    eax,0x0
}
    1456:	c9                   	leave
    1457:	c3                   	ret

00001458 <memdev_get_subnode>:

struct inode* memdev_get_subnode(struct inode* in, const char* fn)
{
    1458:	55                   	push   ebp
    1459:	89 e5                	mov    ebp,esp
    145b:	83 ec 28             	sub    esp,0x28
		struct inode* rv = NULL;
    145e:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		if (!fn || (!in && strlen(fn) > 0)) {
    1465:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
    1469:	74 18                	je     1483 <memdev_get_subnode+0x2b>
    146b:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    146f:	75 26                	jne    1497 <memdev_get_subnode+0x3f>
    1471:	83 ec 0c             	sub    esp,0xc
    1474:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    1477:	e8 fc ff ff ff       	call   1478 <memdev_get_subnode+0x20>
    147c:	83 c4 10             	add    esp,0x10
    147f:	85 c0                	test   eax,eax
    1481:	74 14                	je     1497 <memdev_get_subnode+0x3f>
				errno = EINVAL;
    1483:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
				return NULL;
    148d:	b8 00 00 00 00       	mov    eax,0x0
    1492:	e9 2c 02 00 00       	jmp    16c3 <memdev_get_subnode+0x26b>
		}

		if (in) {
    1497:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    149b:	0f 84 c7 00 00 00    	je     1568 <memdev_get_subnode+0x110>
				struct memdev_node* n; char *str;
				/* we don't handle links here. The OS should only ask
				 * for files we actually have stored on this device */
				if (in->in_stat.st_dev != 0) {
    14a1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    14a4:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    14a7:	8b 00                	mov    eax,DWORD PTR [eax]
    14a9:	89 c1                	mov    ecx,eax
    14ab:	89 c8                	mov    eax,ecx
    14ad:	09 d0                	or     eax,edx
    14af:	74 14                	je     14c5 <memdev_get_subnode+0x6d>
						errno = EINVAL;
    14b1:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
						return NULL;
    14bb:	b8 00 00 00 00       	mov    eax,0x0
    14c0:	e9 fe 01 00 00       	jmp    16c3 <memdev_get_subnode+0x26b>
				}
				/* check for directory */
				if (!S_ISDIR(in->in_stat.st_mode)) {
    14c5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    14c8:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    14cb:	25 00 f0 00 00       	and    eax,0xf000
    14d0:	3d 00 40 00 00       	cmp    eax,0x4000
    14d5:	74 14                	je     14eb <memdev_get_subnode+0x93>
						errno = ENOTDIR;
    14d7:	c7 05 00 00 00 00 14 00 00 00 	mov    DWORD PTR ds:0x0,0x14
						return NULL;
    14e1:	b8 00 00 00 00       	mov    eax,0x0
    14e6:	e9 d8 01 00 00       	jmp    16c3 <memdev_get_subnode+0x26b>
				}

				/* now search for fn with read lock */
				n = *(struct memdev_node**)in->in_pddat;
    14eb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    14ee:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
    14f1:	8b 00                	mov    eax,DWORD PTR [eax]
    14f3:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				read_lock(&in->in_lock);
    14f6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    14f9:	83 c0 74             	add    eax,0x74
    14fc:	83 ec 0c             	sub    esp,0xc
    14ff:	50                   	push   eax
    1500:	e8 fc ff ff ff       	call   1501 <memdev_get_subnode+0xa9>
    1505:	83 c4 10             	add    esp,0x10
				str = memdev_search_fn(n, fn);
    1508:	83 ec 08             	sub    esp,0x8
    150b:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    150e:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    1511:	e8 fc ff ff ff       	call   1512 <memdev_get_subnode+0xba>
    1516:	83 c4 10             	add    esp,0x10
    1519:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				if (str) {
    151c:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    1520:	74 1c                	je     153e <memdev_get_subnode+0xe6>
						str += strlen(str) + 1;
    1522:	83 ec 0c             	sub    esp,0xc
    1525:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
    1528:	e8 fc ff ff ff       	call   1529 <memdev_get_subnode+0xd1>
    152d:	83 c4 10             	add    esp,0x10
    1530:	83 c0 01             	add    eax,0x1
    1533:	01 45 e4             	add    DWORD PTR [ebp-0x1c],eax
						rv = *(void**)str;
    1536:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1539:	8b 00                	mov    eax,DWORD PTR [eax]
    153b:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				}
				/* update access time <- NO only if opening the dir */
				/*clock_gettime(CLOCK_REALTIME, &in->in_stat.st_atim);*/
				read_unlock(&in->in_lock);
    153e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1541:	83 c0 74             	add    eax,0x74
    1544:	83 ec 0c             	sub    esp,0xc
    1547:	50                   	push   eax
    1548:	e8 fc ff ff ff       	call   1549 <memdev_get_subnode+0xf1>
    154d:	83 c4 10             	add    esp,0x10
				if (!rv)
    1550:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1554:	75 0a                	jne    1560 <memdev_get_subnode+0x108>
						errno = ENOENT;
    1556:	c7 05 00 00 00 00 02 00 00 00 	mov    DWORD PTR ds:0x0,0x2
				return rv;
    1560:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1563:	e9 5b 01 00 00       	jmp    16c3 <memdev_get_subnode+0x26b>
		}

		/* return root node */
		if (memdev_data->node_ct == 0) {
    1568:	a1 00 00 00 00       	mov    eax,ds:0x0
    156d:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1570:	85 c0                	test   eax,eax
    1572:	0f 85 3e 01 00 00    	jne    16b6 <memdev_get_subnode+0x25e>
				/* create root directory first */
				void* mem = h_malloc(memdev_data->heap, 128 + sizeof(struct memdev_node));
    1578:	a1 00 00 00 00       	mov    eax,ds:0x0
    157d:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    1580:	83 ec 08             	sub    esp,0x8
    1583:	68 90 00 00 00       	push   0x90
    1588:	50                   	push   eax
    1589:	e8 fc ff ff ff       	call   158a <memdev_get_subnode+0x132>
    158e:	83 c4 10             	add    esp,0x10
    1591:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				struct memdev_node* n = (struct memdev_node*)mem;
    1594:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1597:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				if (!mem)
    159a:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    159e:	75 0a                	jne    15aa <memdev_get_subnode+0x152>
						return NULL;
    15a0:	b8 00 00 00 00       	mov    eax,0x0
    15a5:	e9 19 01 00 00       	jmp    16c3 <memdev_get_subnode+0x26b>
				n->cap = 128 + sizeof(struct memdev_node);
    15aa:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    15ad:	c7 40 08 90 00 00 00 	mov    DWORD PTR [eax+0x8],0x90
				n->size = sizeof(struct memdev_node);
    15b4:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    15b7:	c7 40 04 10 00 00 00 	mov    DWORD PTR [eax+0x4],0x10
				n->file = S_IFDIR;
    15be:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    15c1:	c7 00 00 40 00 00    	mov    DWORD PTR [eax],0x4000
				rv = n->ino = ino_allocate(S_IFDIR);
    15c7:	83 ec 0c             	sub    esp,0xc
    15ca:	68 00 40 00 00       	push   0x4000
    15cf:	e8 fc ff ff ff       	call   15d0 <memdev_get_subnode+0x178>
    15d4:	83 c4 10             	add    esp,0x10
    15d7:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    15da:	89 42 0c             	mov    DWORD PTR [edx+0xc],eax
    15dd:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    15e0:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    15e3:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				if (!rv) {
    15e6:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    15ea:	75 21                	jne    160d <memdev_get_subnode+0x1b5>
						h_free(memdev_data->heap, mem);
    15ec:	a1 00 00 00 00       	mov    eax,ds:0x0
    15f1:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    15f4:	83 ec 08             	sub    esp,0x8
    15f7:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    15fa:	50                   	push   eax
    15fb:	e8 fc ff ff ff       	call   15fc <memdev_get_subnode+0x1a4>
    1600:	83 c4 10             	add    esp,0x10
						return NULL;
    1603:	b8 00 00 00 00       	mov    eax,0x0
    1608:	e9 b6 00 00 00       	jmp    16c3 <memdev_get_subnode+0x26b>
				}
				rv->in_stat.st_dev = memdev_data->id;
    160d:	a1 00 00 00 00       	mov    eax,ds:0x0
    1612:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1615:	8b 00                	mov    eax,DWORD PTR [eax]
    1617:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    161a:	89 01                	mov    DWORD PTR [ecx],eax
    161c:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
				rv->in_stat.st_blksize = 4096; /* 4096/512 */
    161f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1622:	c7 40 34 00 10 00 00 	mov    DWORD PTR [eax+0x34],0x1000
    1629:	c7 40 38 00 00 00 00 	mov    DWORD PTR [eax+0x38],0x0
				rv->in_stat.st_blocks = 8;
    1630:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1633:	c7 40 3c 08 00 00 00 	mov    DWORD PTR [eax+0x3c],0x8
    163a:	c7 40 40 00 00 00 00 	mov    DWORD PTR [eax+0x40],0x0
				rv->in_stat.st_size = 0; /* actual size */
    1641:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1644:	c7 40 2c 00 00 00 00 	mov    DWORD PTR [eax+0x2c],0x0
    164b:	c7 40 30 00 00 00 00 	mov    DWORD PTR [eax+0x30],0x0
				rv->in_pddat = memdev_store_node(n);
    1652:	83 ec 0c             	sub    esp,0xc
    1655:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
    1658:	e8 fc ff ff ff       	call   1659 <memdev_get_subnode+0x201>
    165d:	83 c4 10             	add    esp,0x10
    1660:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1663:	89 42 70             	mov    DWORD PTR [edx+0x70],eax
				if (!rv->in_pddat) {
    1666:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1669:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
    166c:	85 c0                	test   eax,eax
    166e:	75 30                	jne    16a0 <memdev_get_subnode+0x248>
						ino_release(n->ino);
    1670:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1673:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1676:	83 ec 0c             	sub    esp,0xc
    1679:	50                   	push   eax
    167a:	e8 fc ff ff ff       	call   167b <memdev_get_subnode+0x223>
    167f:	83 c4 10             	add    esp,0x10
						h_free(memdev_data->heap, mem);
    1682:	a1 00 00 00 00       	mov    eax,ds:0x0
    1687:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    168a:	83 ec 08             	sub    esp,0x8
    168d:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    1690:	50                   	push   eax
    1691:	e8 fc ff ff ff       	call   1692 <memdev_get_subnode+0x23a>
    1696:	83 c4 10             	add    esp,0x10
						return NULL;
    1699:	b8 00 00 00 00       	mov    eax,0x0
    169e:	eb 23                	jmp    16c3 <memdev_get_subnode+0x26b>
				}
				rv->in_stat.st_nlink = 1; /* NEVER free / on close() */
    16a0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    16a3:	c7 40 14 01 00 00 00 	mov    DWORD PTR [eax+0x14],0x1
    16aa:	c7 40 18 00 00 00 00 	mov    DWORD PTR [eax+0x18],0x0
				return rv;
    16b1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    16b4:	eb 0d                	jmp    16c3 <memdev_get_subnode+0x26b>
		} else
				return memdev_data->nodes[0]->ino;
    16b6:	a1 00 00 00 00       	mov    eax,ds:0x0
    16bb:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    16be:	8b 00                	mov    eax,DWORD PTR [eax]
    16c0:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
}
    16c3:	c9                   	leave
    16c4:	c3                   	ret

000016c5 <memdev_unlink>:

int memdev_unlink(struct inode* in0, struct inode* in1)
{
    16c5:	55                   	push   ebp
    16c6:	89 e5                	mov    ebp,esp
    16c8:	57                   	push   edi
    16c9:	56                   	push   esi
    16ca:	53                   	push   ebx
    16cb:	83 ec 3c             	sub    esp,0x3c
		struct timespec t;
		if (!in1 || (in0 && in0->in_stat.st_dev != memdev_data->id)) {
    16ce:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
    16d2:	74 28                	je     16fc <memdev_unlink+0x37>
    16d4:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    16d8:	74 36                	je     1710 <memdev_unlink+0x4b>
    16da:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    16dd:	8b 08                	mov    ecx,DWORD PTR [eax]
    16df:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    16e2:	a1 00 00 00 00       	mov    eax,ds:0x0
    16e7:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    16ea:	8b 00                	mov    eax,DWORD PTR [eax]
    16ec:	89 cf                	mov    edi,ecx
    16ee:	89 c6                	mov    esi,eax
    16f0:	89 d9                	mov    ecx,ebx
    16f2:	89 f8                	mov    eax,edi
    16f4:	31 f0                	xor    eax,esi
    16f6:	31 ca                	xor    edx,ecx
    16f8:	09 d0                	or     eax,edx
    16fa:	74 14                	je     1710 <memdev_unlink+0x4b>
				errno = EINVAL;
    16fc:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
				return -1;
    1706:	b8 ff ff ff ff       	mov    eax,0xffffffff
    170b:	e9 a7 03 00 00       	jmp    1ab7 <memdev_unlink+0x3f2>
		}

		if (in0) { /* remove link from source dir(!)  */
    1710:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    1714:	0f 84 a7 01 00 00    	je     18c1 <memdev_unlink+0x1fc>
				struct memdev_node* n; char* fn;
				if (!(in0->in_stat.st_mode & S_IFDIR)) {
    171a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    171d:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1720:	25 00 40 00 00       	and    eax,0x4000
    1725:	85 c0                	test   eax,eax
    1727:	75 14                	jne    173d <memdev_unlink+0x78>
						errno = ENOTDIR;
    1729:	c7 05 00 00 00 00 14 00 00 00 	mov    DWORD PTR ds:0x0,0x14
						return -1;
    1733:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1738:	e9 7a 03 00 00       	jmp    1ab7 <memdev_unlink+0x3f2>
				}

				n = *(struct memdev_node**)in0->in_pddat;
    173d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1740:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
    1743:	8b 00                	mov    eax,DWORD PTR [eax]
    1745:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				/* now modify the directory */
				write_lock(&in0->in_lock);
    1748:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    174b:	83 c0 74             	add    eax,0x74
    174e:	83 ec 0c             	sub    esp,0xc
    1751:	50                   	push   eax
    1752:	e8 fc ff ff ff       	call   1753 <memdev_unlink+0x8e>
    1757:	83 c4 10             	add    esp,0x10
				fn = n->data;
    175a:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    175d:	83 c0 10             	add    eax,0x10
    1760:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
				while (fn < (char*)n + n->size) {
    1763:	e9 19 01 00 00       	jmp    1881 <memdev_unlink+0x1bc>
						char* fn2 = fn + strlen(fn) + 1;
    1768:	83 ec 0c             	sub    esp,0xc
    176b:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
    176e:	e8 fc ff ff ff       	call   176f <memdev_unlink+0xaa>
    1773:	83 c4 10             	add    esp,0x10
    1776:	8d 50 01             	lea    edx,[eax+0x1]
    1779:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    177c:	01 d0                	add    eax,edx
    177e:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
						if (*(struct inode**)fn2 == in1) {
    1781:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1784:	8b 00                	mov    eax,DWORD PTR [eax]
    1786:	39 45 0c             	cmp    DWORD PTR [ebp+0xc],eax
    1789:	0f 85 e9 00 00 00    	jne    1878 <memdev_unlink+0x1b3>
								/* found the entry */
								fn2 += sizeof(struct inode*);
    178f:	83 45 dc 04          	add    DWORD PTR [ebp-0x24],0x4
								memmove(fn, fn2, (char*)n + n->size - fn2);
    1793:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1796:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1799:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    179c:	01 d0                	add    eax,edx
    179e:	2b 45 dc             	sub    eax,DWORD PTR [ebp-0x24]
    17a1:	83 ec 04             	sub    esp,0x4
    17a4:	50                   	push   eax
    17a5:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
    17a8:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
    17ab:	e8 fc ff ff ff       	call   17ac <memdev_unlink+0xe7>
    17b0:	83 c4 10             	add    esp,0x10
								n->size -= fn2 - fn;
    17b3:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    17b6:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    17b9:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    17bc:	2b 45 e0             	sub    eax,DWORD PTR [ebp-0x20]
    17bf:	29 c2                	sub    edx,eax
    17c1:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    17c4:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
								if (n->size > 128 + sizeof(struct memdev_node)) {
    17c7:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    17ca:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    17cd:	3d 90 00 00 00       	cmp    eax,0x90
    17d2:	76 4e                	jbe    1822 <memdev_unlink+0x15d>
										/* shrink a bit */
										if (n->cap - n->size > 64) {
    17d4:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    17d7:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    17da:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    17dd:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    17e0:	29 c2                	sub    edx,eax
    17e2:	83 fa 40             	cmp    edx,0x40
    17e5:	76 3b                	jbe    1822 <memdev_unlink+0x15d>
												n->cap = n->size + 64;
    17e7:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    17ea:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    17ed:	8d 50 40             	lea    edx,[eax+0x40]
    17f0:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    17f3:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
												*(struct memdev_node**)in0->in_pddat
													   	= n = h_realloc(memdev_data->heap,
    17f6:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    17f9:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    17fc:	a1 00 00 00 00       	mov    eax,ds:0x0
    1801:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    1804:	83 ec 04             	sub    esp,0x4
    1807:	52                   	push   edx
    1808:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
    180b:	50                   	push   eax
    180c:	e8 fc ff ff ff       	call   180d <memdev_unlink+0x148>
    1811:	83 c4 10             	add    esp,0x10
    1814:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
												*(struct memdev_node**)in0->in_pddat
    1817:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    181a:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
													   	= n = h_realloc(memdev_data->heap,
    181d:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    1820:	89 10                	mov    DWORD PTR [eax],edx
																		n, n->cap);
												/* will never happen as shrink works in-place */
										}
								}
								n = NULL; /* signify found */
    1822:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
								in0->in_stat.st_size = n->size - sizeof(struct memdev_node);
    1829:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    182c:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    182f:	83 e8 10             	sub    eax,0x10
    1832:	ba 00 00 00 00       	mov    edx,0x0
    1837:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    183a:	89 41 2c             	mov    DWORD PTR [ecx+0x2c],eax
    183d:	89 51 30             	mov    DWORD PTR [ecx+0x30],edx
								in0->in_stat.st_blocks = n->cap / 512 + (n->cap % 512 ? 1 : 0);
    1840:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1843:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1846:	c1 e8 09             	shr    eax,0x9
    1849:	89 c2                	mov    edx,eax
    184b:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    184e:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1851:	25 ff 01 00 00       	and    eax,0x1ff
    1856:	85 c0                	test   eax,eax
    1858:	74 07                	je     1861 <memdev_unlink+0x19c>
    185a:	b8 01 00 00 00       	mov    eax,0x1
    185f:	eb 05                	jmp    1866 <memdev_unlink+0x1a1>
    1861:	b8 00 00 00 00       	mov    eax,0x0
    1866:	01 d0                	add    eax,edx
    1868:	ba 00 00 00 00       	mov    edx,0x0
    186d:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    1870:	89 41 3c             	mov    DWORD PTR [ecx+0x3c],eax
    1873:	89 51 40             	mov    DWORD PTR [ecx+0x40],edx
								break;
    1876:	eb 1d                	jmp    1895 <memdev_unlink+0x1d0>
						} else
								fn = fn2 + sizeof(struct inode*);
    1878:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    187b:	83 c0 04             	add    eax,0x4
    187e:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
				while (fn < (char*)n + n->size) {
    1881:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1884:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1887:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    188a:	01 d0                	add    eax,edx
    188c:	39 45 e0             	cmp    DWORD PTR [ebp-0x20],eax
    188f:	0f 82 d3 fe ff ff    	jb     1768 <memdev_unlink+0xa3>
				}
				write_unlock(&in0->in_lock);
    1895:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1898:	83 c0 74             	add    eax,0x74
    189b:	83 ec 0c             	sub    esp,0xc
    189e:	50                   	push   eax
    189f:	e8 fc ff ff ff       	call   18a0 <memdev_unlink+0x1db>
    18a4:	83 c4 10             	add    esp,0x10
				if (!n) {
    18a7:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    18ab:	75 14                	jne    18c1 <memdev_unlink+0x1fc>
						errno = ENOENT;
    18ad:	c7 05 00 00 00 00 02 00 00 00 	mov    DWORD PTR ds:0x0,0x2
						return -1;
    18b7:	b8 ff ff ff ff       	mov    eax,0xffffffff
    18bc:	e9 f6 01 00 00       	jmp    1ab7 <memdev_unlink+0x3f2>
				}
		}

		/* get current time */
		clock_gettime(CLOCK_REALTIME, &t);
    18c1:	83 ec 08             	sub    esp,0x8
    18c4:	8d 45 c8             	lea    eax,[ebp-0x38]
    18c7:	50                   	push   eax
    18c8:	6a 00                	push   0x0
    18ca:	e8 fc ff ff ff       	call   18cb <memdev_unlink+0x206>
    18cf:	83 c4 10             	add    esp,0x10
		if (in0)
    18d2:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    18d6:	74 2d                	je     1905 <memdev_unlink+0x240>
				in0->in_stat.st_mtim = in0->in_stat.st_ctim = t;
    18d8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    18db:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
    18de:	89 50 5c             	mov    DWORD PTR [eax+0x5c],edx
    18e1:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    18e4:	89 50 60             	mov    DWORD PTR [eax+0x60],edx
    18e7:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    18ea:	89 50 64             	mov    DWORD PTR [eax+0x64],edx
    18ed:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    18f0:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    18f3:	8b 4a 5c             	mov    ecx,DWORD PTR [edx+0x5c]
    18f6:	89 48 50             	mov    DWORD PTR [eax+0x50],ecx
    18f9:	8b 4a 60             	mov    ecx,DWORD PTR [edx+0x60]
    18fc:	89 48 54             	mov    DWORD PTR [eax+0x54],ecx
    18ff:	8b 52 64             	mov    edx,DWORD PTR [edx+0x64]
    1902:	89 50 58             	mov    DWORD PTR [eax+0x58],edx

		/* now unlink the node */
		if (in1->in_stat.st_dev != memdev_data->id) {
    1905:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1908:	8b 08                	mov    ecx,DWORD PTR [eax]
    190a:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    190d:	a1 00 00 00 00       	mov    eax,ds:0x0
    1912:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1915:	8b 00                	mov    eax,DWORD PTR [eax]
    1917:	89 cf                	mov    edi,ecx
    1919:	89 c6                	mov    esi,eax
    191b:	89 d9                	mov    ecx,ebx
    191d:	89 f8                	mov    eax,edi
    191f:	31 f0                	xor    eax,esi
    1921:	31 ca                	xor    edx,ecx
    1923:	09 d0                	or     eax,edx
    1925:	0f 84 af 00 00 00    	je     19da <memdev_unlink+0x315>
				const struct device_desc* dd = get_device(in1->in_stat.st_dev);
    192b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    192e:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1931:	8b 00                	mov    eax,DWORD PTR [eax]
    1933:	83 ec 08             	sub    esp,0x8
    1936:	52                   	push   edx
    1937:	50                   	push   eax
    1938:	e8 fc ff ff ff       	call   1939 <memdev_unlink+0x274>
    193d:	83 c4 10             	add    esp,0x10
    1940:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				if (!dd) {
    1943:	83 7d d4 00          	cmp    DWORD PTR [ebp-0x2c],0x0
    1947:	75 79                	jne    19c2 <memdev_unlink+0x2fd>
						cprintf(KFMT_WARN, "unable to locate device %u"
										" for unlinking inode at %p\n",
										(uint32_t)in1->in_stat.st_dev, in1);
    1949:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    194c:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    194f:	8b 00                	mov    eax,DWORD PTR [eax]
						cprintf(KFMT_WARN, "unable to locate device %u"
    1951:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    1954:	50                   	push   eax
    1955:	68 00 00 00 00       	push   0x0
    195a:	6a 0e                	push   0xe
    195c:	e8 fc ff ff ff       	call   195d <memdev_unlink+0x298>
    1961:	83 c4 10             	add    esp,0x10
						if (__sync_sub_and_fetch(&in1->in_stat.st_dev, 1) == 0)
    1964:	8b 75 0c             	mov    esi,DWORD PTR [ebp+0xc]
    1967:	8b 06                	mov    eax,DWORD PTR [esi]
    1969:	8b 56 04             	mov    edx,DWORD PTR [esi+0x4]
    196c:	89 c1                	mov    ecx,eax
    196e:	89 d3                	mov    ebx,edx
    1970:	83 c1 ff             	add    ecx,0xffffffff
    1973:	83 d3 ff             	adc    ebx,0xffffffff
    1976:	89 4d c0             	mov    DWORD PTR [ebp-0x40],ecx
    1979:	89 5d c4             	mov    DWORD PTR [ebp-0x3c],ebx
    197c:	89 4d b8             	mov    DWORD PTR [ebp-0x48],ecx
    197f:	89 5d bc             	mov    DWORD PTR [ebp-0x44],ebx
    1982:	89 cb                	mov    ebx,ecx
    1984:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    1987:	f0 0f c7 0e          	lock cmpxchg8b QWORD PTR [esi]
    198b:	0f 94 c1             	sete   cl
    198e:	84 c9                	test   cl,cl
    1990:	74 da                	je     196c <memdev_unlink+0x2a7>
    1992:	8b 5d c0             	mov    ebx,DWORD PTR [ebp-0x40]
    1995:	8b 75 c4             	mov    esi,DWORD PTR [ebp-0x3c]
    1998:	89 d8                	mov    eax,ebx
    199a:	89 f2                	mov    edx,esi
    199c:	09 d0                	or     eax,edx
    199e:	75 0e                	jne    19ae <memdev_unlink+0x2e9>
								ino_release(in1); /* clean up partially */
    19a0:	83 ec 0c             	sub    esp,0xc
    19a3:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    19a6:	e8 fc ff ff ff       	call   19a7 <memdev_unlink+0x2e2>
    19ab:	83 c4 10             	add    esp,0x10
						errno = ENODEV;
    19ae:	c7 05 00 00 00 00 13 00 00 00 	mov    DWORD PTR ds:0x0,0x13
						return 0; /* only warn */
    19b8:	b8 00 00 00 00       	mov    eax,0x0
    19bd:	e9 f5 00 00 00       	jmp    1ab7 <memdev_unlink+0x3f2>
				} else {
						return dd->fn_unlink(NULL, in1);
    19c2:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    19c5:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    19c8:	83 ec 08             	sub    esp,0x8
    19cb:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    19ce:	6a 00                	push   0x0
    19d0:	ff d0                	call   eax
    19d2:	83 c4 10             	add    esp,0x10
    19d5:	e9 dd 00 00 00       	jmp    1ab7 <memdev_unlink+0x3f2>
				}
		} else {
				if ((__sync_sub_and_fetch(&in1->in_stat.st_nlink, 1) == 0) &&
    19da:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    19dd:	8d 70 14             	lea    esi,[eax+0x14]
    19e0:	8b 06                	mov    eax,DWORD PTR [esi]
    19e2:	8b 56 04             	mov    edx,DWORD PTR [esi+0x4]
    19e5:	89 c1                	mov    ecx,eax
    19e7:	89 d3                	mov    ebx,edx
    19e9:	83 c1 ff             	add    ecx,0xffffffff
    19ec:	83 d3 ff             	adc    ebx,0xffffffff
    19ef:	89 4d c0             	mov    DWORD PTR [ebp-0x40],ecx
    19f2:	89 5d c4             	mov    DWORD PTR [ebp-0x3c],ebx
    19f5:	89 4d b8             	mov    DWORD PTR [ebp-0x48],ecx
    19f8:	89 5d bc             	mov    DWORD PTR [ebp-0x44],ebx
    19fb:	89 cb                	mov    ebx,ecx
    19fd:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
    1a00:	f0 0f c7 0e          	lock cmpxchg8b QWORD PTR [esi]
    1a04:	0f 94 c1             	sete   cl
    1a07:	84 c9                	test   cl,cl
    1a09:	74 da                	je     19e5 <memdev_unlink+0x320>
    1a0b:	8b 5d c0             	mov    ebx,DWORD PTR [ebp-0x40]
    1a0e:	8b 75 c4             	mov    esi,DWORD PTR [ebp-0x3c]
    1a11:	89 d8                	mov    eax,ebx
    1a13:	89 f2                	mov    edx,esi
    1a15:	09 d0                	or     eax,edx
    1a17:	0f 85 80 00 00 00    	jne    1a9d <memdev_unlink+0x3d8>
					(*(int*)in1->in_ddat == 0)) {
    1a1d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1a20:	83 c0 68             	add    eax,0x68
    1a23:	8b 00                	mov    eax,DWORD PTR [eax]
				if ((__sync_sub_and_fetch(&in1->in_stat.st_nlink, 1) == 0) &&
    1a25:	85 c0                	test   eax,eax
    1a27:	75 74                	jne    1a9d <memdev_unlink+0x3d8>
						struct memdev_node* n;
						/* this was the last link & no open FDs so remove the node */
						n = *(struct memdev_node**)in1->in_pddat;
    1a29:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1a2c:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
    1a2f:	8b 00                	mov    eax,DWORD PTR [eax]
    1a31:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
						*(struct memdev_node**)in1->in_pddat = NULL; /* free slot */
    1a34:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1a37:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
    1a3a:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
						if (S_ISREG(in1->in_stat.st_mode))
    1a40:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1a43:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1a46:	25 00 f0 00 00       	and    eax,0xf000
    1a4b:	3d 00 80 00 00       	cmp    eax,0x8000
    1a50:	75 1f                	jne    1a71 <memdev_unlink+0x3ac>
								mm_free_vmem(&mm_kernel, n, n->cap / 4096);
    1a52:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1a55:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1a58:	c1 e8 0c             	shr    eax,0xc
    1a5b:	83 ec 04             	sub    esp,0x4
    1a5e:	50                   	push   eax
    1a5f:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
    1a62:	68 00 00 00 00       	push   0x0
    1a67:	e8 fc ff ff ff       	call   1a68 <memdev_unlink+0x3a3>
    1a6c:	83 c4 10             	add    esp,0x10
    1a6f:	eb 17                	jmp    1a88 <memdev_unlink+0x3c3>
						else
								h_free(memdev_data->heap, n);
    1a71:	a1 00 00 00 00       	mov    eax,ds:0x0
    1a76:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    1a79:	83 ec 08             	sub    esp,0x8
    1a7c:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
    1a7f:	50                   	push   eax
    1a80:	e8 fc ff ff ff       	call   1a81 <memdev_unlink+0x3bc>
    1a85:	83 c4 10             	add    esp,0x10
						ino_release(in1);
    1a88:	83 ec 0c             	sub    esp,0xc
    1a8b:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    1a8e:	e8 fc ff ff ff       	call   1a8f <memdev_unlink+0x3ca>
    1a93:	83 c4 10             	add    esp,0x10
						return 0;
    1a96:	b8 00 00 00 00       	mov    eax,0x0
    1a9b:	eb 1a                	jmp    1ab7 <memdev_unlink+0x3f2>
				}
				in1->in_stat.st_ctim = t;
    1a9d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1aa0:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
    1aa3:	89 50 5c             	mov    DWORD PTR [eax+0x5c],edx
    1aa6:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    1aa9:	89 50 60             	mov    DWORD PTR [eax+0x60],edx
    1aac:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    1aaf:	89 50 64             	mov    DWORD PTR [eax+0x64],edx
				return 0;
    1ab2:	b8 00 00 00 00       	mov    eax,0x0
		}
}
    1ab7:	8d 65 f4             	lea    esp,[ebp-0xc]
    1aba:	5b                   	pop    ebx
    1abb:	5e                   	pop    esi
    1abc:	5f                   	pop    edi
    1abd:	5d                   	pop    ebp
    1abe:	c3                   	ret

00001abf <memdev_set_subnode>:

int memdev_set_subnode(struct inode* in0, struct inode* in1, const char* fn)
{
    1abf:	55                   	push   ebp
    1ac0:	89 e5                	mov    ebp,esp
    1ac2:	57                   	push   edi
    1ac3:	56                   	push   esi
    1ac4:	53                   	push   ebx
    1ac5:	83 ec 4c             	sub    esp,0x4c
		struct memdev_node *n0, *n1 = NULL;
    1ac8:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x0
		if (!in0 || !fn || in0->in_stat.st_dev != memdev_data->id) {
    1acf:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    1ad3:	74 28                	je     1afd <memdev_set_subnode+0x3e>
    1ad5:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    1ad9:	74 22                	je     1afd <memdev_set_subnode+0x3e>
    1adb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ade:	8b 08                	mov    ecx,DWORD PTR [eax]
    1ae0:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    1ae3:	a1 00 00 00 00       	mov    eax,ds:0x0
    1ae8:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1aeb:	8b 00                	mov    eax,DWORD PTR [eax]
    1aed:	89 cf                	mov    edi,ecx
    1aef:	89 c6                	mov    esi,eax
    1af1:	89 d9                	mov    ecx,ebx
    1af3:	89 f8                	mov    eax,edi
    1af5:	31 f0                	xor    eax,esi
    1af7:	31 ca                	xor    edx,ecx
    1af9:	09 d0                	or     eax,edx
    1afb:	74 14                	je     1b11 <memdev_set_subnode+0x52>
				errno = EINVAL;
    1afd:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
				return -1;
    1b07:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1b0c:	e9 6e 06 00 00       	jmp    217f <memdev_set_subnode+0x6c0>
		}

		/* inode in0 on this device and directory */
		if (!(in0->in_stat.st_mode & S_IFDIR)) {
    1b11:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b14:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1b17:	25 00 40 00 00       	and    eax,0x4000
    1b1c:	85 c0                	test   eax,eax
    1b1e:	75 14                	jne    1b34 <memdev_set_subnode+0x75>
				errno = ENOTDIR;
    1b20:	c7 05 00 00 00 00 14 00 00 00 	mov    DWORD PTR ds:0x0,0x14
				return -1;
    1b2a:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1b2f:	e9 4b 06 00 00       	jmp    217f <memdev_set_subnode+0x6c0>
		}
		n0 = *(struct memdev_node**)in0->in_pddat;
    1b34:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b37:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
    1b3a:	8b 00                	mov    eax,DWORD PTR [eax]
    1b3c:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax

		/* create REAL in1 if dummy for creation */
		if (!in1) { /* unlink */
    1b3f:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
    1b43:	75 3a                	jne    1b7f <memdev_set_subnode+0xc0>
				/* convenience function */
				in1 = memdev_get_subnode(in0, fn);
    1b45:	83 ec 08             	sub    esp,0x8
    1b48:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    1b4b:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1b4e:	e8 fc ff ff ff       	call   1b4f <memdev_set_subnode+0x90>
    1b53:	83 c4 10             	add    esp,0x10
    1b56:	89 45 0c             	mov    DWORD PTR [ebp+0xc],eax
				if (!in1)
    1b59:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
    1b5d:	75 0a                	jne    1b69 <memdev_set_subnode+0xaa>
						return -1;
    1b5f:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1b64:	e9 16 06 00 00       	jmp    217f <memdev_set_subnode+0x6c0>
				return memdev_unlink(in0, in1);
    1b69:	83 ec 08             	sub    esp,0x8
    1b6c:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    1b6f:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1b72:	e8 fc ff ff ff       	call   1b73 <memdev_set_subnode+0xb4>
    1b77:	83 c4 10             	add    esp,0x10
    1b7a:	e9 00 06 00 00       	jmp    217f <memdev_set_subnode+0x6c0>
		} else if (in1->in_stat.st_dev == INVALID_DEVICE) {
    1b7f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1b82:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1b85:	8b 00                	mov    eax,DWORD PTR [eax]
    1b87:	89 c1                	mov    ecx,eax
    1b89:	89 c8                	mov    eax,ecx
    1b8b:	f7 d0                	not    eax
    1b8d:	09 d0                	or     eax,edx
    1b8f:	0f 85 8f 02 00 00    	jne    1e24 <memdev_set_subnode+0x365>
				void* mem = NULL; size_t s;
    1b95:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
				/* only allow dirs, files and links */
				if (!S_ISDIR(in1->in_stat.st_mode) &&
    1b9c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1b9f:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1ba2:	25 00 f0 00 00       	and    eax,0xf000
    1ba7:	3d 00 40 00 00       	cmp    eax,0x4000
    1bac:	74 38                	je     1be6 <memdev_set_subnode+0x127>
					!S_ISREG(in1->in_stat.st_mode) &&
    1bae:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1bb1:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1bb4:	25 00 f0 00 00       	and    eax,0xf000
				if (!S_ISDIR(in1->in_stat.st_mode) &&
    1bb9:	3d 00 80 00 00       	cmp    eax,0x8000
    1bbe:	74 26                	je     1be6 <memdev_set_subnode+0x127>
					!S_ISLNK(in1->in_stat.st_mode)) {
    1bc0:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1bc3:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1bc6:	25 00 f0 00 00       	and    eax,0xf000
					!S_ISREG(in1->in_stat.st_mode) &&
    1bcb:	3d 00 a0 00 00       	cmp    eax,0xa000
    1bd0:	74 14                	je     1be6 <memdev_set_subnode+0x127>
						errno = ENOTSUP;
    1bd2:	c7 05 00 00 00 00 5f 00 00 00 	mov    DWORD PTR ds:0x0,0x5f
						return -1;
    1bdc:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1be1:	e9 99 05 00 00       	jmp    217f <memdev_set_subnode+0x6c0>
				}
				/* calculate the size of the memory */
				if (in1->in_stat.st_size)
    1be6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1be9:	8b 50 30             	mov    edx,DWORD PTR [eax+0x30]
    1bec:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    1bef:	89 c1                	mov    ecx,eax
    1bf1:	89 c8                	mov    eax,ecx
    1bf3:	09 d0                	or     eax,edx
    1bf5:	74 2b                	je     1c22 <memdev_set_subnode+0x163>
						s = in1->in_stat.st_size + sizeof(struct memdev_node)
    1bf7:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1bfa:	8b 50 30             	mov    edx,DWORD PTR [eax+0x30]
    1bfd:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
								+ (S_ISREG(in1->in_stat.st_mode) ? 0 : 1);
    1c00:	89 c2                	mov    edx,eax
    1c02:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1c05:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1c08:	25 00 f0 00 00       	and    eax,0xf000
    1c0d:	3d 00 80 00 00       	cmp    eax,0x8000
    1c12:	0f 95 c0             	setne  al
    1c15:	0f b6 c0             	movzx  eax,al
    1c18:	01 d0                	add    eax,edx
						s = in1->in_stat.st_size + sizeof(struct memdev_node)
    1c1a:	83 c0 10             	add    eax,0x10
    1c1d:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    1c20:	eb 3d                	jmp    1c5f <memdev_set_subnode+0x1a0>
				else if (S_ISDIR(in1->in_stat.st_mode))
    1c22:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1c25:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1c28:	25 00 f0 00 00       	and    eax,0xf000
    1c2d:	3d 00 40 00 00       	cmp    eax,0x4000
    1c32:	75 09                	jne    1c3d <memdev_set_subnode+0x17e>
						s = 128 + sizeof(struct memdev_node); /* default dir capacity */
    1c34:	c7 45 dc 90 00 00 00 	mov    DWORD PTR [ebp-0x24],0x90
    1c3b:	eb 22                	jmp    1c5f <memdev_set_subnode+0x1a0>
				else if (S_ISLNK(in1->in_stat.st_mode))
    1c3d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1c40:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1c43:	25 00 f0 00 00       	and    eax,0xf000
    1c48:	3d 00 a0 00 00       	cmp    eax,0xa000
    1c4d:	75 09                	jne    1c58 <memdev_set_subnode+0x199>
						s = 32 + sizeof(struct memdev_node); /* default link length */
    1c4f:	c7 45 dc 30 00 00 00 	mov    DWORD PTR [ebp-0x24],0x30
    1c56:	eb 07                	jmp    1c5f <memdev_set_subnode+0x1a0>
				else
						s = 4096; /* default file size */
    1c58:	c7 45 dc 00 10 00 00 	mov    DWORD PTR [ebp-0x24],0x1000

				/* get some memory for the memfile */
				if (S_ISREG(in1->in_stat.st_mode)) {
    1c5f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1c62:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1c65:	25 00 f0 00 00       	and    eax,0xf000
    1c6a:	3d 00 80 00 00       	cmp    eax,0x8000
    1c6f:	75 39                	jne    1caa <memdev_set_subnode+0x1eb>
						if (s % 4096)
    1c71:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1c74:	25 ff 0f 00 00       	and    eax,0xfff
    1c79:	85 c0                	test   eax,eax
    1c7b:	74 10                	je     1c8d <memdev_set_subnode+0x1ce>
								s += 4096 - (s % 4096);
    1c7d:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1c80:	25 00 f0 ff ff       	and    eax,0xfffff000
    1c85:	05 00 10 00 00       	add    eax,0x1000
    1c8a:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
						mem = mm_alloc_vmem(&mm_kernel, NULL, s / 4096,
    1c8d:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1c90:	c1 e8 0c             	shr    eax,0xc
    1c93:	6a 0c                	push   0xc
    1c95:	50                   	push   eax
    1c96:	6a 00                	push   0x0
    1c98:	68 00 00 00 00       	push   0x0
    1c9d:	e8 fc ff ff ff       	call   1c9e <memdev_set_subnode+0x1df>
    1ca2:	83 c4 10             	add    esp,0x10
    1ca5:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1ca8:	eb 1a                	jmp    1cc4 <memdev_set_subnode+0x205>
										MMGR_MAP_KERNEL | MMGR_MAP_WRITE);
				} else
						mem = h_malloc(memdev_data->heap, s);
    1caa:	a1 00 00 00 00       	mov    eax,ds:0x0
    1caf:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    1cb2:	83 ec 08             	sub    esp,0x8
    1cb5:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
    1cb8:	50                   	push   eax
    1cb9:	e8 fc ff ff ff       	call   1cba <memdev_set_subnode+0x1fb>
    1cbe:	83 c4 10             	add    esp,0x10
    1cc1:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
				if (!mem)
    1cc4:	83 7d e0 00          	cmp    DWORD PTR [ebp-0x20],0x0
    1cc8:	75 0a                	jne    1cd4 <memdev_set_subnode+0x215>
						return -1;
    1cca:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1ccf:	e9 ab 04 00 00       	jmp    217f <memdev_set_subnode+0x6c0>
				/* now we have clean pages or heap memory */
				n1 = (struct memdev_node*)mem;
    1cd4:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1cd7:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				n1->cap = s;
    1cda:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1cdd:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1ce0:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
				n1->size = sizeof(struct memdev_node);
    1ce3:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1ce6:	c7 40 04 10 00 00 00 	mov    DWORD PTR [eax+0x4],0x10
				n1->file = in1->in_stat.st_mode;
    1ced:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1cf0:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
    1cf3:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1cf6:	89 10                	mov    DWORD PTR [eax],edx
				n1->ino = ino_allocate(in1->in_stat.st_mode & S_IFMT);
    1cf8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1cfb:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    1cfe:	25 00 f0 00 00       	and    eax,0xf000
    1d03:	83 ec 0c             	sub    esp,0xc
    1d06:	50                   	push   eax
    1d07:	e8 fc ff ff ff       	call   1d08 <memdev_set_subnode+0x249>
    1d0c:	83 c4 10             	add    esp,0x10
    1d0f:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    1d12:	89 42 0c             	mov    DWORD PTR [edx+0xc],eax
				if (!n1->ino) { /* undo much */
    1d15:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1d18:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1d1b:	85 c0                	test   eax,eax
    1d1d:	75 4f                	jne    1d6e <memdev_set_subnode+0x2af>
free_mem:
    1d1f:	90                   	nop
						if (S_ISREG(n1->file))
    1d20:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1d23:	8b 00                	mov    eax,DWORD PTR [eax]
    1d25:	25 00 f0 00 00       	and    eax,0xf000
    1d2a:	3d 00 80 00 00       	cmp    eax,0x8000
    1d2f:	75 1c                	jne    1d4d <memdev_set_subnode+0x28e>
								mm_free_vmem(&mm_kernel, n1, s / 4096);
    1d31:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1d34:	c1 e8 0c             	shr    eax,0xc
    1d37:	83 ec 04             	sub    esp,0x4
    1d3a:	50                   	push   eax
    1d3b:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    1d3e:	68 00 00 00 00       	push   0x0
    1d43:	e8 fc ff ff ff       	call   1d44 <memdev_set_subnode+0x285>
    1d48:	83 c4 10             	add    esp,0x10
    1d4b:	eb 17                	jmp    1d64 <memdev_set_subnode+0x2a5>
						else
								h_free(memdev_data->heap, n1);
    1d4d:	a1 00 00 00 00       	mov    eax,ds:0x0
    1d52:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    1d55:	83 ec 08             	sub    esp,0x8
    1d58:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    1d5b:	50                   	push   eax
    1d5c:	e8 fc ff ff ff       	call   1d5d <memdev_set_subnode+0x29e>
    1d61:	83 c4 10             	add    esp,0x10
						return -1;
    1d64:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1d69:	e9 11 04 00 00       	jmp    217f <memdev_set_subnode+0x6c0>
				}
				/* and the inode */
				n1->ino->in_stat.st_blksize = 4096;
    1d6e:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1d71:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1d74:	c7 40 34 00 10 00 00 	mov    DWORD PTR [eax+0x34],0x1000
    1d7b:	c7 40 38 00 00 00 00 	mov    DWORD PTR [eax+0x38],0x0
				n1->ino->in_stat.st_blocks = s / 512 + ((s % 512) ? 1 : 0);
    1d82:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1d85:	c1 e8 09             	shr    eax,0x9
    1d88:	89 c2                	mov    edx,eax
    1d8a:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1d8d:	25 ff 01 00 00       	and    eax,0x1ff
    1d92:	85 c0                	test   eax,eax
    1d94:	74 07                	je     1d9d <memdev_set_subnode+0x2de>
    1d96:	b8 01 00 00 00       	mov    eax,0x1
    1d9b:	eb 05                	jmp    1da2 <memdev_set_subnode+0x2e3>
    1d9d:	b8 00 00 00 00       	mov    eax,0x0
    1da2:	01 c2                	add    edx,eax
    1da4:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1da7:	8b 48 0c             	mov    ecx,DWORD PTR [eax+0xc]
    1daa:	89 d0                	mov    eax,edx
    1dac:	ba 00 00 00 00       	mov    edx,0x0
    1db1:	89 41 3c             	mov    DWORD PTR [ecx+0x3c],eax
    1db4:	89 51 40             	mov    DWORD PTR [ecx+0x40],edx
				n1->ino->in_stat.st_dev = memdev_data->id;
    1db7:	a1 00 00 00 00       	mov    eax,ds:0x0
    1dbc:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    1dbf:	8b 4a 0c             	mov    ecx,DWORD PTR [edx+0xc]
    1dc2:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1dc5:	8b 00                	mov    eax,DWORD PTR [eax]
    1dc7:	89 01                	mov    DWORD PTR [ecx],eax
    1dc9:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
				n1->ino->in_stat.st_size = 1;
    1dcc:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1dcf:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1dd2:	c7 40 2c 01 00 00 00 	mov    DWORD PTR [eax+0x2c],0x1
    1dd9:	c7 40 30 00 00 00 00 	mov    DWORD PTR [eax+0x30],0x0
				n1->ino->in_pddat = memdev_store_node(n1);
    1de0:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1de3:	8b 58 0c             	mov    ebx,DWORD PTR [eax+0xc]
    1de6:	83 ec 0c             	sub    esp,0xc
    1de9:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    1dec:	e8 fc ff ff ff       	call   1ded <memdev_set_subnode+0x32e>
    1df1:	83 c4 10             	add    esp,0x10
    1df4:	89 43 70             	mov    DWORD PTR [ebx+0x70],eax
				if (!n1->ino->in_pddat) {
    1df7:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1dfa:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1dfd:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
    1e00:	85 c0                	test   eax,eax
    1e02:	75 17                	jne    1e1b <memdev_set_subnode+0x35c>
						/* sth. went wrong! */
						ino_release(n1->ino);
    1e04:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1e07:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1e0a:	83 ec 0c             	sub    esp,0xc
    1e0d:	50                   	push   eax
    1e0e:	e8 fc ff ff ff       	call   1e0f <memdev_set_subnode+0x350>
    1e13:	83 c4 10             	add    esp,0x10
						goto free_mem;
    1e16:	e9 05 ff ff ff       	jmp    1d20 <memdev_set_subnode+0x261>
				}
				in1 = n1->ino;
    1e1b:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1e1e:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    1e21:	89 45 0c             	mov    DWORD PTR [ebp+0xc],eax
		}

		/* acquire the write lock */
		write_lock(&in0->in_lock);
    1e24:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1e27:	83 c0 74             	add    eax,0x74
    1e2a:	83 ec 0c             	sub    esp,0xc
    1e2d:	50                   	push   eax
    1e2e:	e8 fc ff ff ff       	call   1e2f <memdev_set_subnode+0x370>
    1e33:	83 c4 10             	add    esp,0x10
		/* find possible old/conflicting inode */
		char* dt = memdev_search_fn(n0, fn), need_entry = 1;
    1e36:	83 ec 08             	sub    esp,0x8
    1e39:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    1e3c:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
    1e3f:	e8 fc ff ff ff       	call   1e40 <memdev_set_subnode+0x381>
    1e44:	83 c4 10             	add    esp,0x10
    1e47:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
    1e4a:	c6 45 db 01          	mov    BYTE PTR [ebp-0x25],0x1
		if (dt) {
    1e4e:	83 7d d0 00          	cmp    DWORD PTR [ebp-0x30],0x0
    1e52:	0f 84 35 01 00 00    	je     1f8d <memdev_set_subnode+0x4ce>
				struct inode* in2;
				/* already existing, get inode */
				dt += strlen(dt) + 1;
    1e58:	83 ec 0c             	sub    esp,0xc
    1e5b:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
    1e5e:	e8 fc ff ff ff       	call   1e5f <memdev_set_subnode+0x3a0>
    1e63:	83 c4 10             	add    esp,0x10
    1e66:	83 c0 01             	add    eax,0x1
    1e69:	01 45 d0             	add    DWORD PTR [ebp-0x30],eax
				in2 = *(struct inode**)dt;
    1e6c:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1e6f:	8b 00                	mov    eax,DWORD PTR [eax]
    1e71:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
				if (in1 == in2) {
    1e74:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1e77:	3b 45 cc             	cmp    eax,DWORD PTR [ebp-0x34]
    1e7a:	75 26                	jne    1ea2 <memdev_set_subnode+0x3e3>
						/* do nothing */
						errno = EEXIST;
    1e7c:	c7 05 00 00 00 00 11 00 00 00 	mov    DWORD PTR ds:0x0,0x11
						write_unlock(&in0->in_lock);
    1e86:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1e89:	83 c0 74             	add    eax,0x74
    1e8c:	83 ec 0c             	sub    esp,0xc
    1e8f:	50                   	push   eax
    1e90:	e8 fc ff ff ff       	call   1e91 <memdev_set_subnode+0x3d2>
    1e95:	83 c4 10             	add    esp,0x10
						return -1;
    1e98:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1e9d:	e9 dd 02 00 00       	jmp    217f <memdev_set_subnode+0x6c0>
				}
				/* unlink old node if neccessary */
				if (in2->in_stat.st_dev == memdev_data->id)
    1ea2:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1ea5:	8b 08                	mov    ecx,DWORD PTR [eax]
    1ea7:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    1eaa:	a1 00 00 00 00       	mov    eax,ds:0x0
    1eaf:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1eb2:	8b 00                	mov    eax,DWORD PTR [eax]
    1eb4:	89 cf                	mov    edi,ecx
    1eb6:	89 c6                	mov    esi,eax
    1eb8:	89 d9                	mov    ecx,ebx
    1eba:	89 f8                	mov    eax,edi
    1ebc:	31 f0                	xor    eax,esi
    1ebe:	31 ca                	xor    edx,ecx
    1ec0:	09 d0                	or     eax,edx
    1ec2:	75 15                	jne    1ed9 <memdev_set_subnode+0x41a>
						memdev_unlink(NULL, in2);
    1ec4:	83 ec 08             	sub    esp,0x8
    1ec7:	ff 75 cc             	push   DWORD PTR [ebp-0x34]
    1eca:	6a 00                	push   0x0
    1ecc:	e8 fc ff ff ff       	call   1ecd <memdev_set_subnode+0x40e>
    1ed1:	83 c4 10             	add    esp,0x10
    1ed4:	e9 98 00 00 00       	jmp    1f71 <memdev_set_subnode+0x4b2>
				else {
						const struct device_desc* dd;
						dd = get_device(in2->in_stat.st_dev);
    1ed9:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1edc:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1edf:	8b 00                	mov    eax,DWORD PTR [eax]
    1ee1:	83 ec 08             	sub    esp,0x8
    1ee4:	52                   	push   edx
    1ee5:	50                   	push   eax
    1ee6:	e8 fc ff ff ff       	call   1ee7 <memdev_set_subnode+0x428>
    1eeb:	83 c4 10             	add    esp,0x10
    1eee:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
						if (!dd) {
    1ef1:	83 7d c8 00          	cmp    DWORD PTR [ebp-0x38],0x0
    1ef5:	75 67                	jne    1f5e <memdev_set_subnode+0x49f>
								cprintf(KFMT_WARN, "unable to locate device %u"
												" for unlinking inode referenced by %s\n",
												(uint32_t)in2->in_stat.st_dev, fn);
    1ef7:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1efa:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1efd:	8b 00                	mov    eax,DWORD PTR [eax]
								cprintf(KFMT_WARN, "unable to locate device %u"
    1eff:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    1f02:	50                   	push   eax
    1f03:	68 38 00 00 00       	push   0x38
    1f08:	6a 0e                	push   0xe
    1f0a:	e8 fc ff ff ff       	call   1f0b <memdev_set_subnode+0x44c>
    1f0f:	83 c4 10             	add    esp,0x10
								if (__sync_sub_and_fetch(&in2->in_stat.st_dev, 1) == 0)
    1f12:	8b 75 cc             	mov    esi,DWORD PTR [ebp-0x34]
    1f15:	8b 06                	mov    eax,DWORD PTR [esi]
    1f17:	8b 56 04             	mov    edx,DWORD PTR [esi+0x4]
    1f1a:	89 c1                	mov    ecx,eax
    1f1c:	89 d3                	mov    ebx,edx
    1f1e:	83 c1 ff             	add    ecx,0xffffffff
    1f21:	83 d3 ff             	adc    ebx,0xffffffff
    1f24:	89 4d b0             	mov    DWORD PTR [ebp-0x50],ecx
    1f27:	89 5d b4             	mov    DWORD PTR [ebp-0x4c],ebx
    1f2a:	89 4d a8             	mov    DWORD PTR [ebp-0x58],ecx
    1f2d:	89 5d ac             	mov    DWORD PTR [ebp-0x54],ebx
    1f30:	89 cb                	mov    ebx,ecx
    1f32:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    1f35:	f0 0f c7 0e          	lock cmpxchg8b QWORD PTR [esi]
    1f39:	0f 94 c1             	sete   cl
    1f3c:	84 c9                	test   cl,cl
    1f3e:	74 da                	je     1f1a <memdev_set_subnode+0x45b>
    1f40:	8b 5d b0             	mov    ebx,DWORD PTR [ebp-0x50]
    1f43:	8b 75 b4             	mov    esi,DWORD PTR [ebp-0x4c]
    1f46:	89 d8                	mov    eax,ebx
    1f48:	89 f2                	mov    edx,esi
    1f4a:	09 d0                	or     eax,edx
    1f4c:	75 23                	jne    1f71 <memdev_set_subnode+0x4b2>
										ino_release(in2); /* clean up partially */
    1f4e:	83 ec 0c             	sub    esp,0xc
    1f51:	ff 75 cc             	push   DWORD PTR [ebp-0x34]
    1f54:	e8 fc ff ff ff       	call   1f55 <memdev_set_subnode+0x496>
    1f59:	83 c4 10             	add    esp,0x10
    1f5c:	eb 13                	jmp    1f71 <memdev_set_subnode+0x4b2>
						} else {
								dd->fn_unlink(NULL, in2);
    1f5e:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1f61:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    1f64:	83 ec 08             	sub    esp,0x8
    1f67:	ff 75 cc             	push   DWORD PTR [ebp-0x34]
    1f6a:	6a 00                	push   0x0
    1f6c:	ff d0                	call   eax
    1f6e:	83 c4 10             	add    esp,0x10
						}
				}
				/* set new link */
				*(struct inode**)dt = in1;
    1f71:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1f74:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    1f77:	89 10                	mov    DWORD PTR [eax],edx
				need_entry = 0;
    1f79:	c6 45 db 00          	mov    BYTE PTR [ebp-0x25],0x0
				printf("fn matches prev\n");
    1f7d:	83 ec 0c             	sub    esp,0xc
    1f80:	68 79 00 00 00       	push   0x79
    1f85:	e8 fc ff ff ff       	call   1f86 <memdev_set_subnode+0x4c7>
    1f8a:	83 c4 10             	add    esp,0x10
		}

		/* assume valid inode in1 */
		__sync_fetch_and_add(&in1->in_stat.st_nlink, 1);
    1f8d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1f90:	8d 70 14             	lea    esi,[eax+0x14]
    1f93:	8b 06                	mov    eax,DWORD PTR [esi]
    1f95:	8b 56 04             	mov    edx,DWORD PTR [esi+0x4]
    1f98:	89 c1                	mov    ecx,eax
    1f9a:	89 d3                	mov    ebx,edx
    1f9c:	83 c1 01             	add    ecx,0x1
    1f9f:	83 d3 00             	adc    ebx,0x0
    1fa2:	89 4d b0             	mov    DWORD PTR [ebp-0x50],ecx
    1fa5:	89 5d b4             	mov    DWORD PTR [ebp-0x4c],ebx
    1fa8:	89 cb                	mov    ebx,ecx
    1faa:	8b 4d b4             	mov    ecx,DWORD PTR [ebp-0x4c]
    1fad:	f0 0f c7 0e          	lock cmpxchg8b QWORD PTR [esi]
    1fb1:	0f 94 c1             	sete   cl
    1fb4:	84 c9                	test   cl,cl
    1fb6:	74 e0                	je     1f98 <memdev_set_subnode+0x4d9>
		if (need_entry) {
    1fb8:	80 7d db 00          	cmp    BYTE PTR [ebp-0x25],0x0
    1fbc:	0f 84 62 01 00 00    	je     2124 <memdev_set_subnode+0x665>
				/* modify data */
				size_t s = strlen(fn) + 1 + sizeof(void*);
    1fc2:	83 ec 0c             	sub    esp,0xc
    1fc5:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    1fc8:	e8 fc ff ff ff       	call   1fc9 <memdev_set_subnode+0x50a>
    1fcd:	83 c4 10             	add    esp,0x10
    1fd0:	83 c0 05             	add    eax,0x5
    1fd3:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
				dt = (char*)n0 + n0->size;
    1fd6:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1fd9:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1fdc:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1fdf:	01 d0                	add    eax,edx
    1fe1:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
				if ((n0->cap - n0->size) < s) {
    1fe4:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1fe7:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    1fea:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1fed:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1ff0:	29 c2                	sub    edx,eax
    1ff2:	3b 55 c4             	cmp    edx,DWORD PTR [ebp-0x3c]
    1ff5:	73 66                	jae    205d <memdev_set_subnode+0x59e>
						/* use realloc */
						size_t nc = 2 * n0->cap + s;
    1ff7:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1ffa:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1ffd:	8d 14 00             	lea    edx,[eax+eax*1]
    2000:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2003:	01 d0                	add    eax,edx
    2005:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
						n0 = h_realloc(memdev_data->heap, n0, nc);
    2008:	a1 00 00 00 00       	mov    eax,ds:0x0
    200d:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    2010:	83 ec 04             	sub    esp,0x4
    2013:	ff 75 c0             	push   DWORD PTR [ebp-0x40]
    2016:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
    2019:	50                   	push   eax
    201a:	e8 fc ff ff ff       	call   201b <memdev_set_subnode+0x55c>
    201f:	83 c4 10             	add    esp,0x10
    2022:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
						if (!n0) { /* real OOM */
    2025:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    2029:	75 1b                	jne    2046 <memdev_set_subnode+0x587>
								cprintf(KFMT_ERROR, "failed to realloc on memdev heap: errno=%d\n", errno);
    202b:	a1 00 00 00 00       	mov    eax,ds:0x0
    2030:	83 ec 04             	sub    esp,0x4
    2033:	50                   	push   eax
    2034:	68 8c 00 00 00       	push   0x8c
    2039:	6a 0c                	push   0xc
    203b:	e8 fc ff ff ff       	call   203c <memdev_set_subnode+0x57d>
    2040:	83 c4 10             	add    esp,0x10
								while (1);
    2043:	90                   	nop
    2044:	eb fd                	jmp    2043 <memdev_set_subnode+0x584>
						}
						/* no cmpxchg neccessary */
						*(struct memdev_node**)n0->ino->in_pddat = n0;
    2046:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2049:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    204c:	8b 40 70             	mov    eax,DWORD PTR [eax+0x70]
    204f:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    2052:	89 10                	mov    DWORD PTR [eax],edx
						n0->cap = nc;
    2054:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2057:	8b 55 c0             	mov    edx,DWORD PTR [ebp-0x40]
    205a:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
				}
				/* we now have enough space */
				strncpy(dt, fn, s - 1 - sizeof(void*));
    205d:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2060:	83 e8 05             	sub    eax,0x5
    2063:	83 ec 04             	sub    esp,0x4
    2066:	50                   	push   eax
    2067:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    206a:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
    206d:	e8 fc ff ff ff       	call   206e <memdev_set_subnode+0x5af>
    2072:	83 c4 10             	add    esp,0x10
				dt += s - 1 - sizeof(void*);
    2075:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2078:	83 e8 05             	sub    eax,0x5
    207b:	01 45 d0             	add    DWORD PTR [ebp-0x30],eax
				*dt = '\0';
    207e:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    2081:	c6 00 00             	mov    BYTE PTR [eax],0x0
				*(struct inode**)(++dt) = in1;
    2084:	83 45 d0 01          	add    DWORD PTR [ebp-0x30],0x1
    2088:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    208b:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    208e:	89 10                	mov    DWORD PTR [eax],edx
				n0->size += s;
    2090:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2093:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    2096:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2099:	01 c2                	add    edx,eax
    209b:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    209e:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
				in0->in_stat.st_size = n0->size - sizeof(struct memdev_node);
    20a1:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    20a4:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    20a7:	83 e8 10             	sub    eax,0x10
    20aa:	ba 00 00 00 00       	mov    edx,0x0
    20af:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    20b2:	89 41 2c             	mov    DWORD PTR [ecx+0x2c],eax
    20b5:	89 51 30             	mov    DWORD PTR [ecx+0x30],edx
				in0->in_stat.st_blocks = in0->in_stat.st_size / 512
    20b8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    20bb:	8b 50 30             	mov    edx,DWORD PTR [eax+0x30]
    20be:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    20c1:	89 c1                	mov    ecx,eax
    20c3:	89 d3                	mov    ebx,edx
    20c5:	89 db                	mov    ebx,ebx
    20c7:	c1 fb 1f             	sar    ebx,0x1f
    20ca:	89 d9                	mov    ecx,ebx
    20cc:	81 e1 ff 01 00 00    	and    ecx,0x1ff
    20d2:	bb 00 00 00 00       	mov    ebx,0x0
    20d7:	01 c8                	add    eax,ecx
    20d9:	11 da                	adc    edx,ebx
    20db:	0f ac d0 09          	shrd   eax,edx,0x9
    20df:	c1 fa 09             	sar    edx,0x9
    20e2:	89 c6                	mov    esi,eax
    20e4:	89 d7                	mov    edi,edx
					   	+ ((in0->in_stat.st_size % 512) ? 1 : 0);
    20e6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    20e9:	8b 50 30             	mov    edx,DWORD PTR [eax+0x30]
    20ec:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    20ef:	25 ff 01 00 00       	and    eax,0x1ff
    20f4:	ba 00 00 00 00       	mov    edx,0x0
    20f9:	89 c1                	mov    ecx,eax
    20fb:	89 c8                	mov    eax,ecx
    20fd:	09 d0                	or     eax,edx
    20ff:	74 0c                	je     210d <memdev_set_subnode+0x64e>
    2101:	b8 01 00 00 00       	mov    eax,0x1
    2106:	ba 00 00 00 00       	mov    edx,0x0
    210b:	eb 0a                	jmp    2117 <memdev_set_subnode+0x658>
    210d:	b8 00 00 00 00       	mov    eax,0x0
    2112:	ba 00 00 00 00       	mov    edx,0x0
    2117:	01 f0                	add    eax,esi
    2119:	11 fa                	adc    edx,edi
				in0->in_stat.st_blocks = in0->in_stat.st_size / 512
    211b:	8b 4d 08             	mov    ecx,DWORD PTR [ebp+0x8]
    211e:	89 41 3c             	mov    DWORD PTR [ecx+0x3c],eax
    2121:	89 51 40             	mov    DWORD PTR [ecx+0x40],edx
		}
		/* update times (only c&m on dir & c on fil) */
		clock_gettime(CLOCK_REALTIME, &in0->in_stat.st_mtim);
    2124:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2127:	83 c0 50             	add    eax,0x50
    212a:	83 ec 08             	sub    esp,0x8
    212d:	50                   	push   eax
    212e:	6a 00                	push   0x0
    2130:	e8 fc ff ff ff       	call   2131 <memdev_set_subnode+0x672>
    2135:	83 c4 10             	add    esp,0x10
		in0->in_stat.st_ctim = in0->in_stat.st_mtim;
    2138:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    213b:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    213e:	8b 4a 50             	mov    ecx,DWORD PTR [edx+0x50]
    2141:	89 48 5c             	mov    DWORD PTR [eax+0x5c],ecx
    2144:	8b 4a 54             	mov    ecx,DWORD PTR [edx+0x54]
    2147:	89 48 60             	mov    DWORD PTR [eax+0x60],ecx
    214a:	8b 52 58             	mov    edx,DWORD PTR [edx+0x58]
    214d:	89 50 64             	mov    DWORD PTR [eax+0x64],edx
		/* due to change in link count */
		in1->in_stat.st_ctim = in0->in_stat.st_mtim;
    2150:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2153:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    2156:	8b 4a 50             	mov    ecx,DWORD PTR [edx+0x50]
    2159:	89 48 5c             	mov    DWORD PTR [eax+0x5c],ecx
    215c:	8b 4a 54             	mov    ecx,DWORD PTR [edx+0x54]
    215f:	89 48 60             	mov    DWORD PTR [eax+0x60],ecx
    2162:	8b 52 58             	mov    edx,DWORD PTR [edx+0x58]
    2165:	89 50 64             	mov    DWORD PTR [eax+0x64],edx
		write_unlock(&in0->in_lock);
    2168:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    216b:	83 c0 74             	add    eax,0x74
    216e:	83 ec 0c             	sub    esp,0xc
    2171:	50                   	push   eax
    2172:	e8 fc ff ff ff       	call   2173 <memdev_set_subnode+0x6b4>
    2177:	83 c4 10             	add    esp,0x10
		return 0;
    217a:	b8 00 00 00 00       	mov    eax,0x0
}
    217f:	8d 65 f4             	lea    esp,[ebp-0xc]
    2182:	5b                   	pop    ebx
    2183:	5e                   	pop    esi
    2184:	5f                   	pop    edi
    2185:	5d                   	pop    ebp
    2186:	c3                   	ret

00002187 <get_special_inode>:
/**********************************************************/
static struct inode *in_root, *in_dev;
struct inode* get_special_inode(enum spec_ino what)
{
    2187:	55                   	push   ebp
    2188:	89 e5                	mov    ebp,esp
		switch (what) {
    218a:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    218e:	74 08                	je     2198 <get_special_inode+0x11>
    2190:	83 7d 08 01          	cmp    DWORD PTR [ebp+0x8],0x1
    2194:	74 09                	je     219f <get_special_inode+0x18>
    2196:	eb 0e                	jmp    21a6 <get_special_inode+0x1f>
				case INO_ROOT:
						return in_root;
    2198:	a1 30 28 00 00       	mov    eax,ds:0x2830
    219d:	eb 0c                	jmp    21ab <get_special_inode+0x24>
				case INO_DEV:
						return in_dev;
    219f:	a1 34 28 00 00       	mov    eax,ds:0x2834
    21a4:	eb 05                	jmp    21ab <get_special_inode+0x24>
				default:
						return NULL;
    21a6:	b8 00 00 00 00       	mov    eax,0x0
		}
}
    21ab:	5d                   	pop    ebp
    21ac:	c3                   	ret

000021ad <module_init>:
/**********************************************************/
int MODENTRY module_init()
{
    21ad:	55                   	push   ebp
    21ae:	89 e5                	mov    ebp,esp
    21b0:	57                   	push   edi
    21b1:	53                   	push   ebx
    21b2:	81 ec c0 00 00 00    	sub    esp,0xc0
		struct device_desc dd = {0}; dev_t d;
    21b8:	8d 55 b8             	lea    edx,[ebp-0x48]
    21bb:	b8 00 00 00 00       	mov    eax,0x0
    21c0:	b9 0e 00 00 00       	mov    ecx,0xe
    21c5:	89 d7                	mov    edi,edx
    21c7:	f3 ab                	rep stos DWORD PTR es:[edi],eax
		printf("registering the basic file devices\n");
    21c9:	83 ec 0c             	sub    esp,0xc
    21cc:	68 b8 00 00 00       	push   0xb8
    21d1:	e8 fc ff ff ff       	call   21d2 <module_init+0x25>
    21d6:	83 c4 10             	add    esp,0x10
		dd.type = DEVTYPE_NONE;
    21d9:	c6 45 b8 01          	mov    BYTE PTR [ebp-0x48],0x1
		dd.fn_reg_dev = memdev_register;
    21dd:	c7 45 bc 00 00 00 00 	mov    DWORD PTR [ebp-0x44],0x0
		dd.fn_unreg_dev = memdev_unregister;
    21e4:	c7 45 c0 00 00 00 00 	mov    DWORD PTR [ebp-0x40],0x0
		dd.fn_open = memdev_open;
    21eb:	c7 45 c4 00 00 00 00 	mov    DWORD PTR [ebp-0x3c],0x0
		dd.fn_read = memdev_read;
    21f2:	c7 45 c8 00 00 00 00 	mov    DWORD PTR [ebp-0x38],0x0
		dd.fn_write = memdev_write;
    21f9:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
		dd.fn_close = memdev_close;
    2200:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [ebp-0x30],0x0
		dd.fn_lseek = memdev_lseek;
    2207:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x0
		dd.fn_truncate = memdev_truncate;
    220e:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [ebp-0x28],0x0
		dd.fn_get_subnode = memdev_get_subnode;
    2215:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
		dd.fn_set_subnode = memdev_set_subnode;
    221c:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
		dd.fn_unlink = memdev_unlink;
    2223:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
		d = register_device(&dd);
    222a:	83 ec 0c             	sub    esp,0xc
    222d:	8d 45 b8             	lea    eax,[ebp-0x48]
    2230:	50                   	push   eax
    2231:	e8 fc ff ff ff       	call   2232 <module_init+0x85>
    2236:	83 c4 10             	add    esp,0x10
    2239:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    223c:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
		if (d != INVALID_DEVICE)
    223f:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2242:	f7 d0                	not    eax
    2244:	0b 45 f4             	or     eax,DWORD PTR [ebp-0xc]
    2247:	74 46                	je     228f <module_init+0xe2>
				printf("\tregistered memdev as device %u\n", (uint32_t)d);
    2249:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    224c:	83 ec 08             	sub    esp,0x8
    224f:	50                   	push   eax
    2250:	68 dc 00 00 00       	push   0xdc
    2255:	e8 fc ff ff ff       	call   2256 <module_init+0xa9>
    225a:	83 c4 10             	add    esp,0x10
		else {
				printf("\tfailed to register memdev: errno=%d\n", errno);
				return -1;
		}

		printf("\ncreating the root file system\n");
    225d:	83 ec 0c             	sub    esp,0xc
    2260:	68 28 01 00 00       	push   0x128
    2265:	e8 fc ff ff ff       	call   2266 <module_init+0xb9>
    226a:	83 c4 10             	add    esp,0x10
		/* create the / & /dev folders */
		in_root = dd.fn_get_subnode(NULL, "");
    226d:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2270:	83 ec 08             	sub    esp,0x8
    2273:	68 48 01 00 00       	push   0x148
    2278:	6a 00                	push   0x0
    227a:	ff d0                	call   eax
    227c:	83 c4 10             	add    esp,0x10
    227f:	a3 30 28 00 00       	mov    ds:0x2830,eax
		if (!in_root) {
    2284:	a1 30 28 00 00       	mov    eax,ds:0x2830
    2289:	85 c0                	test   eax,eax
    228b:	75 44                	jne    22d1 <module_init+0x124>
    228d:	eb 20                	jmp    22af <module_init+0x102>
				printf("\tfailed to register memdev: errno=%d\n", errno);
    228f:	a1 00 00 00 00       	mov    eax,ds:0x0
    2294:	83 ec 08             	sub    esp,0x8
    2297:	50                   	push   eax
    2298:	68 00 01 00 00       	push   0x100
    229d:	e8 fc ff ff ff       	call   229e <module_init+0xf1>
    22a2:	83 c4 10             	add    esp,0x10
				return -1;
    22a5:	b8 ff ff ff ff       	mov    eax,0xffffffff
    22aa:	e9 fd 00 00 00       	jmp    23ac <module_init+0x1ff>
				cprintf(KFMT_ERROR, "\tfailed to create root in memdev: errno=%d\n", errno);
    22af:	a1 00 00 00 00       	mov    eax,ds:0x0
    22b4:	83 ec 04             	sub    esp,0x4
    22b7:	50                   	push   eax
    22b8:	68 4c 01 00 00       	push   0x14c
    22bd:	6a 0c                	push   0xc
    22bf:	e8 fc ff ff ff       	call   22c0 <module_init+0x113>
    22c4:	83 c4 10             	add    esp,0x10
				return -1;
    22c7:	b8 ff ff ff ff       	mov    eax,0xffffffff
    22cc:	e9 db 00 00 00       	jmp    23ac <module_init+0x1ff>
		}
		printf("adding /dev\n");
    22d1:	83 ec 0c             	sub    esp,0xc
    22d4:	68 78 01 00 00       	push   0x178
    22d9:	e8 fc ff ff ff       	call   22da <module_init+0x12d>
    22de:	83 c4 10             	add    esp,0x10
		if (dd.fn_set_subnode(in_root, &INO_TMPL_DIR, "dev") != 0) {
    22e1:	8b 5d e0             	mov    ebx,DWORD PTR [ebp-0x20]
    22e4:	8d 95 3c ff ff ff    	lea    edx,[ebp-0xc4]
    22ea:	b8 00 00 00 00       	mov    eax,0x0
    22ef:	b9 1f 00 00 00       	mov    ecx,0x1f
    22f4:	89 d7                	mov    edi,edx
    22f6:	f3 ab                	rep stos DWORD PTR es:[edi],eax
    22f8:	c7 85 3c ff ff ff ff ff ff ff 	mov    DWORD PTR [ebp-0xc4],0xffffffff
    2302:	c7 85 40 ff ff ff 00 00 00 00 	mov    DWORD PTR [ebp-0xc0],0x0
    230c:	c7 85 4c ff ff ff 00 40 00 00 	mov    DWORD PTR [ebp-0xb4],0x4000
    2316:	a1 30 28 00 00       	mov    eax,ds:0x2830
    231b:	83 ec 04             	sub    esp,0x4
    231e:	68 85 01 00 00       	push   0x185
    2323:	8d 95 3c ff ff ff    	lea    edx,[ebp-0xc4]
    2329:	52                   	push   edx
    232a:	50                   	push   eax
    232b:	ff d3                	call   ebx
    232d:	83 c4 10             	add    esp,0x10
    2330:	85 c0                	test   eax,eax
    2332:	74 1f                	je     2353 <module_init+0x1a6>
				cprintf(KFMT_ERROR, "\tfailed to create folder /dev in root: errno=%d\n", errno);
    2334:	a1 00 00 00 00       	mov    eax,ds:0x0
    2339:	83 ec 04             	sub    esp,0x4
    233c:	50                   	push   eax
    233d:	68 8c 01 00 00       	push   0x18c
    2342:	6a 0c                	push   0xc
    2344:	e8 fc ff ff ff       	call   2345 <module_init+0x198>
    2349:	83 c4 10             	add    esp,0x10
				return -1;
    234c:	b8 ff ff ff ff       	mov    eax,0xffffffff
    2351:	eb 59                	jmp    23ac <module_init+0x1ff>
		}
		printf("retrieving /dev\n");
    2353:	83 ec 0c             	sub    esp,0xc
    2356:	68 bd 01 00 00       	push   0x1bd
    235b:	e8 fc ff ff ff       	call   235c <module_init+0x1af>
    2360:	83 c4 10             	add    esp,0x10
		in_dev = dd.fn_get_subnode(in_root, "dev");
    2363:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2366:	8b 15 30 28 00 00    	mov    edx,DWORD PTR ds:0x2830
    236c:	83 ec 08             	sub    esp,0x8
    236f:	68 85 01 00 00       	push   0x185
    2374:	52                   	push   edx
    2375:	ff d0                	call   eax
    2377:	83 c4 10             	add    esp,0x10
    237a:	a3 34 28 00 00       	mov    ds:0x2834,eax
		if (!in_dev) {
    237f:	a1 34 28 00 00       	mov    eax,ds:0x2834
    2384:	85 c0                	test   eax,eax
    2386:	75 1f                	jne    23a7 <module_init+0x1fa>
				cprintf(KFMT_ERROR, "\tfailed to access folder /dev: errno=%d\n", errno);
    2388:	a1 00 00 00 00       	mov    eax,ds:0x0
    238d:	83 ec 04             	sub    esp,0x4
    2390:	50                   	push   eax
    2391:	68 d0 01 00 00       	push   0x1d0
    2396:	6a 0c                	push   0xc
    2398:	e8 fc ff ff ff       	call   2399 <module_init+0x1ec>
    239d:	83 c4 10             	add    esp,0x10
				return -1;
    23a0:	b8 ff ff ff ff       	mov    eax,0xffffffff
    23a5:	eb 05                	jmp    23ac <module_init+0x1ff>
		}

		return 0;
    23a7:	b8 00 00 00 00       	mov    eax,0x0
}
    23ac:	8d 65 f8             	lea    esp,[ebp-0x8]
    23af:	5b                   	pop    ebx
    23b0:	5f                   	pop    edi
    23b1:	5d                   	pop    ebp
    23b2:	c3                   	ret

000023b3 <print_stat>:

void print_stat(struct inode* in, const char* fn, int cb, int cu, int cg, int cs)
{
    23b3:	55                   	push   ebp
    23b4:	89 e5                	mov    ebp,esp
    23b6:	57                   	push   edi
    23b7:	56                   	push   esi
    23b8:	53                   	push   ebx
    23b9:	81 ec 8c 00 00 00    	sub    esp,0x8c
		char fmt = KFMT_NORMAL, c_tp = '-', c_ur = '-', c_uw = '-',
    23bf:	c6 45 e7 0f          	mov    BYTE PTR [ebp-0x19],0xf
    23c3:	c6 45 e6 2d          	mov    BYTE PTR [ebp-0x1a],0x2d
    23c7:	c6 45 e5 2d          	mov    BYTE PTR [ebp-0x1b],0x2d
    23cb:	c6 45 e4 2d          	mov    BYTE PTR [ebp-0x1c],0x2d
			 c_ux = '-', c_gr = '-', c_gw = '-', c_gx = '-', c_or = '-',
    23cf:	c6 45 e3 2d          	mov    BYTE PTR [ebp-0x1d],0x2d
    23d3:	c6 45 e2 2d          	mov    BYTE PTR [ebp-0x1e],0x2d
    23d7:	c6 45 e1 2d          	mov    BYTE PTR [ebp-0x1f],0x2d
    23db:	c6 45 e0 2d          	mov    BYTE PTR [ebp-0x20],0x2d
    23df:	c6 45 df 2d          	mov    BYTE PTR [ebp-0x21],0x2d
			 c_ow = '-', c_ox = '-';
    23e3:	c6 45 de 2d          	mov    BYTE PTR [ebp-0x22],0x2d
    23e7:	c6 45 dd 2d          	mov    BYTE PTR [ebp-0x23],0x2d
		mode_t m = in->in_stat.st_mode;
    23eb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    23ee:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    23f1:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax

		if (m & S_IRUSR)
    23f4:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    23f7:	25 00 01 00 00       	and    eax,0x100
    23fc:	85 c0                	test   eax,eax
    23fe:	74 04                	je     2404 <print_stat+0x51>
				c_ur = 'r';
    2400:	c6 45 e5 72          	mov    BYTE PTR [ebp-0x1b],0x72
		if (m & S_IWUSR)
    2404:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2407:	25 80 00 00 00       	and    eax,0x80
    240c:	85 c0                	test   eax,eax
    240e:	74 04                	je     2414 <print_stat+0x61>
				c_uw = 'w';
    2410:	c6 45 e4 77          	mov    BYTE PTR [ebp-0x1c],0x77
		if (m & S_IXUSR)
    2414:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2417:	83 e0 40             	and    eax,0x40
    241a:	85 c0                	test   eax,eax
    241c:	74 04                	je     2422 <print_stat+0x6f>
				c_ux = 'x';
    241e:	c6 45 e3 78          	mov    BYTE PTR [ebp-0x1d],0x78
		if (m & S_ISUID) /* setuid */
    2422:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2425:	25 00 08 00 00       	and    eax,0x800
    242a:	85 c0                	test   eax,eax
    242c:	74 15                	je     2443 <print_stat+0x90>
				c_ux = ((c_ux == 'x') ? 's' : 'S');
    242e:	80 7d e3 78          	cmp    BYTE PTR [ebp-0x1d],0x78
    2432:	75 07                	jne    243b <print_stat+0x88>
    2434:	b8 73 00 00 00       	mov    eax,0x73
    2439:	eb 05                	jmp    2440 <print_stat+0x8d>
    243b:	b8 53 00 00 00       	mov    eax,0x53
    2440:	88 45 e3             	mov    BYTE PTR [ebp-0x1d],al
		if (m & S_IRGRP)
    2443:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2446:	83 e0 20             	and    eax,0x20
    2449:	85 c0                	test   eax,eax
    244b:	74 04                	je     2451 <print_stat+0x9e>
				c_gr = 'r';
    244d:	c6 45 e2 72          	mov    BYTE PTR [ebp-0x1e],0x72
		if (m & S_IWGRP)
    2451:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2454:	83 e0 10             	and    eax,0x10
    2457:	85 c0                	test   eax,eax
    2459:	74 04                	je     245f <print_stat+0xac>
				c_gw = 'w';
    245b:	c6 45 e1 77          	mov    BYTE PTR [ebp-0x1f],0x77
		if (m & S_IXGRP)
    245f:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2462:	83 e0 08             	and    eax,0x8
    2465:	85 c0                	test   eax,eax
    2467:	74 04                	je     246d <print_stat+0xba>
				c_gx = 'x';
    2469:	c6 45 e0 78          	mov    BYTE PTR [ebp-0x20],0x78
		if (m & S_ISGID) /* setgid */
    246d:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2470:	25 00 04 00 00       	and    eax,0x400
    2475:	85 c0                	test   eax,eax
    2477:	74 15                	je     248e <print_stat+0xdb>
				c_gx = ((c_gx == 'x') ? 's' : 'S');
    2479:	80 7d e0 78          	cmp    BYTE PTR [ebp-0x20],0x78
    247d:	75 07                	jne    2486 <print_stat+0xd3>
    247f:	b8 73 00 00 00       	mov    eax,0x73
    2484:	eb 05                	jmp    248b <print_stat+0xd8>
    2486:	b8 53 00 00 00       	mov    eax,0x53
    248b:	88 45 e0             	mov    BYTE PTR [ebp-0x20],al
		if (m & S_IROTH)
    248e:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2491:	83 e0 04             	and    eax,0x4
    2494:	85 c0                	test   eax,eax
    2496:	74 04                	je     249c <print_stat+0xe9>
				c_or = 'r';
    2498:	c6 45 df 72          	mov    BYTE PTR [ebp-0x21],0x72
		if (m & S_IWOTH)
    249c:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    249f:	83 e0 02             	and    eax,0x2
    24a2:	85 c0                	test   eax,eax
    24a4:	74 04                	je     24aa <print_stat+0xf7>
				c_ow = 'w';
    24a6:	c6 45 de 77          	mov    BYTE PTR [ebp-0x22],0x77
		if (m & S_IXOTH)
    24aa:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    24ad:	83 e0 01             	and    eax,0x1
    24b0:	85 c0                	test   eax,eax
    24b2:	74 04                	je     24b8 <print_stat+0x105>
				c_ox = 'x';
    24b4:	c6 45 dd 78          	mov    BYTE PTR [ebp-0x23],0x78
		if (m & S_ISVTX) /* sticky bit */
    24b8:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    24bb:	25 00 02 00 00       	and    eax,0x200
    24c0:	85 c0                	test   eax,eax
    24c2:	74 15                	je     24d9 <print_stat+0x126>
				c_ox = ((c_ox == 'x') ? 't' : 'T');
    24c4:	80 7d dd 78          	cmp    BYTE PTR [ebp-0x23],0x78
    24c8:	75 07                	jne    24d1 <print_stat+0x11e>
    24ca:	b8 74 00 00 00       	mov    eax,0x74
    24cf:	eb 05                	jmp    24d6 <print_stat+0x123>
    24d1:	b8 54 00 00 00       	mov    eax,0x54
    24d6:	88 45 dd             	mov    BYTE PTR [ebp-0x23],al
		if (S_ISDIR(m))
    24d9:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    24dc:	25 00 f0 00 00       	and    eax,0xf000
    24e1:	3d 00 40 00 00       	cmp    eax,0x4000
    24e6:	75 09                	jne    24f1 <print_stat+0x13e>
				c_tp = 'd';
    24e8:	c6 45 e6 64          	mov    BYTE PTR [ebp-0x1a],0x64
    24ec:	e9 82 00 00 00       	jmp    2573 <print_stat+0x1c0>
		else if (S_ISLNK(m))
    24f1:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    24f4:	25 00 f0 00 00       	and    eax,0xf000
    24f9:	3d 00 a0 00 00       	cmp    eax,0xa000
    24fe:	75 06                	jne    2506 <print_stat+0x153>
				c_tp = 'l';
    2500:	c6 45 e6 6c          	mov    BYTE PTR [ebp-0x1a],0x6c
    2504:	eb 6d                	jmp    2573 <print_stat+0x1c0>
		else if (S_ISFIFO(m))
    2506:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2509:	25 00 f0 00 00       	and    eax,0xf000
    250e:	3d 00 10 00 00       	cmp    eax,0x1000
    2513:	75 06                	jne    251b <print_stat+0x168>
				c_tp = 'p';
    2515:	c6 45 e6 70          	mov    BYTE PTR [ebp-0x1a],0x70
    2519:	eb 58                	jmp    2573 <print_stat+0x1c0>
		else if (S_ISCHR(m))
    251b:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    251e:	25 00 f0 00 00       	and    eax,0xf000
    2523:	3d 00 20 00 00       	cmp    eax,0x2000
    2528:	75 06                	jne    2530 <print_stat+0x17d>
				c_tp = 'c';
    252a:	c6 45 e6 63          	mov    BYTE PTR [ebp-0x1a],0x63
    252e:	eb 43                	jmp    2573 <print_stat+0x1c0>
		else if (S_ISBLK(m))
    2530:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2533:	25 00 f0 00 00       	and    eax,0xf000
    2538:	3d 00 60 00 00       	cmp    eax,0x6000
    253d:	75 06                	jne    2545 <print_stat+0x192>
				c_tp = 'b';
    253f:	c6 45 e6 62          	mov    BYTE PTR [ebp-0x1a],0x62
    2543:	eb 2e                	jmp    2573 <print_stat+0x1c0>
		else if (S_ISSOCK(m))
    2545:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2548:	25 00 f0 00 00       	and    eax,0xf000
    254d:	3d 00 c0 00 00       	cmp    eax,0xc000
    2552:	75 06                	jne    255a <print_stat+0x1a7>
				c_tp = 's';
    2554:	c6 45 e6 73          	mov    BYTE PTR [ebp-0x1a],0x73
    2558:	eb 19                	jmp    2573 <print_stat+0x1c0>
		else if (S_ISREG(m))
    255a:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    255d:	25 00 f0 00 00       	and    eax,0xf000
    2562:	3d 00 80 00 00       	cmp    eax,0x8000
    2567:	75 06                	jne    256f <print_stat+0x1bc>
				c_tp = '-';
    2569:	c6 45 e6 2d          	mov    BYTE PTR [ebp-0x1a],0x2d
    256d:	eb 04                	jmp    2573 <print_stat+0x1c0>
		else
				c_tp = '?';
    256f:	c6 45 e6 3f          	mov    BYTE PTR [ebp-0x1a],0x3f
		/* -rw-r--r-- 1 dennis users 6728 Aug 29 19:32 prog.o */
		struct tm atime; char datstr[26];
		localtime_r(&in->in_stat.st_atim.tv_sec, &atime);
    2573:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2576:	8d 50 44             	lea    edx,[eax+0x44]
    2579:	83 ec 08             	sub    esp,0x8
    257c:	8d 45 b4             	lea    eax,[ebp-0x4c]
    257f:	50                   	push   eax
    2580:	52                   	push   edx
    2581:	e8 fc ff ff ff       	call   2582 <print_stat+0x1cf>
    2586:	83 c4 10             	add    esp,0x10
		asctime_r(&atime, datstr);
    2589:	83 ec 08             	sub    esp,0x8
    258c:	8d 45 9a             	lea    eax,[ebp-0x66]
    258f:	50                   	push   eax
    2590:	8d 45 b4             	lea    eax,[ebp-0x4c]
    2593:	50                   	push   eax
    2594:	e8 fc ff ff ff       	call   2595 <print_stat+0x1e2>
    2599:	83 c4 10             	add    esp,0x10
		/* reformat datstr TODO: strftime */
		/* old format: "Mon Aug 29 19:32:xy 2134 */
		strcpy(datstr, datstr + 4);
    259c:	8d 45 9a             	lea    eax,[ebp-0x66]
    259f:	83 c0 04             	add    eax,0x4
    25a2:	83 ec 08             	sub    esp,0x8
    25a5:	50                   	push   eax
    25a6:	8d 45 9a             	lea    eax,[ebp-0x66]
    25a9:	50                   	push   eax
    25aa:	e8 fc ff ff ff       	call   25ab <print_stat+0x1f8>
    25af:	83 c4 10             	add    esp,0x10
		if (atime.tm_year != 115/*today.tm_year*/)
    25b2:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    25b5:	83 f8 73             	cmp    eax,0x73
    25b8:	74 19                	je     25d3 <print_stat+0x220>
				strcpy(datstr + 7, datstr + 15);
    25ba:	8d 55 9a             	lea    edx,[ebp-0x66]
    25bd:	83 c2 0f             	add    edx,0xf
    25c0:	8d 45 9a             	lea    eax,[ebp-0x66]
    25c3:	83 c0 07             	add    eax,0x7
    25c6:	83 ec 08             	sub    esp,0x8
    25c9:	52                   	push   edx
    25ca:	50                   	push   eax
    25cb:	e8 fc ff ff ff       	call   25cc <print_stat+0x219>
    25d0:	83 c4 10             	add    esp,0x10
		datstr[12] = '\0';
    25d3:	c6 45 a6 00          	mov    BYTE PTR [ebp-0x5a],0x0
		printf("%c%c%c%c%c%c%c%c%c%c %*u %*u %*u %*u %s ", c_tp, c_ur,
						c_uw, c_ux, c_gr, c_gw, c_gx, c_or, c_ow, c_ox,
						cb, (uint32_t)in->in_stat.st_nlink, cu, (uint32_t)in->in_stat.st_uid,
						cg, (uint32_t)in->in_stat.st_gid, cs, (uint32_t)in->in_stat.st_size,
    25d7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    25da:	8b 50 30             	mov    edx,DWORD PTR [eax+0x30]
    25dd:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
		printf("%c%c%c%c%c%c%c%c%c%c %*u %*u %*u %*u %s ", c_tp, c_ur,
    25e0:	89 45 94             	mov    DWORD PTR [ebp-0x6c],eax
						cg, (uint32_t)in->in_stat.st_gid, cs, (uint32_t)in->in_stat.st_size,
    25e3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    25e6:	8b 48 20             	mov    ecx,DWORD PTR [eax+0x20]
						cb, (uint32_t)in->in_stat.st_nlink, cu, (uint32_t)in->in_stat.st_uid,
    25e9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    25ec:	8b 58 1c             	mov    ebx,DWORD PTR [eax+0x1c]
    25ef:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    25f2:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    25f5:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
		printf("%c%c%c%c%c%c%c%c%c%c %*u %*u %*u %*u %s ", c_tp, c_ur,
    25f8:	89 45 90             	mov    DWORD PTR [ebp-0x70],eax
    25fb:	0f be 45 dd          	movsx  eax,BYTE PTR [ebp-0x23]
    25ff:	89 45 8c             	mov    DWORD PTR [ebp-0x74],eax
    2602:	0f be 75 de          	movsx  esi,BYTE PTR [ebp-0x22]
    2606:	89 75 88             	mov    DWORD PTR [ebp-0x78],esi
    2609:	0f be 7d df          	movsx  edi,BYTE PTR [ebp-0x21]
    260d:	89 7d 84             	mov    DWORD PTR [ebp-0x7c],edi
    2610:	0f be 55 e0          	movsx  edx,BYTE PTR [ebp-0x20]
    2614:	89 55 80             	mov    DWORD PTR [ebp-0x80],edx
    2617:	0f be 45 e1          	movsx  eax,BYTE PTR [ebp-0x1f]
    261b:	89 85 7c ff ff ff    	mov    DWORD PTR [ebp-0x84],eax
    2621:	0f be 75 e2          	movsx  esi,BYTE PTR [ebp-0x1e]
    2625:	89 b5 78 ff ff ff    	mov    DWORD PTR [ebp-0x88],esi
    262b:	0f be 7d e3          	movsx  edi,BYTE PTR [ebp-0x1d]
    262f:	89 bd 74 ff ff ff    	mov    DWORD PTR [ebp-0x8c],edi
    2635:	0f be 7d e4          	movsx  edi,BYTE PTR [ebp-0x1c]
    2639:	0f be 75 e5          	movsx  esi,BYTE PTR [ebp-0x1b]
    263d:	0f be 55 e6          	movsx  edx,BYTE PTR [ebp-0x1a]
    2641:	8d 45 9a             	lea    eax,[ebp-0x66]
    2644:	50                   	push   eax
    2645:	ff 75 94             	push   DWORD PTR [ebp-0x6c]
    2648:	ff 75 1c             	push   DWORD PTR [ebp+0x1c]
    264b:	51                   	push   ecx
    264c:	ff 75 18             	push   DWORD PTR [ebp+0x18]
    264f:	53                   	push   ebx
    2650:	ff 75 14             	push   DWORD PTR [ebp+0x14]
    2653:	ff 75 90             	push   DWORD PTR [ebp-0x70]
    2656:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    2659:	ff 75 8c             	push   DWORD PTR [ebp-0x74]
    265c:	ff 75 88             	push   DWORD PTR [ebp-0x78]
    265f:	ff 75 84             	push   DWORD PTR [ebp-0x7c]
    2662:	ff 75 80             	push   DWORD PTR [ebp-0x80]
    2665:	ff b5 7c ff ff ff    	push   DWORD PTR [ebp-0x84]
    266b:	ff b5 78 ff ff ff    	push   DWORD PTR [ebp-0x88]
    2671:	ff b5 74 ff ff ff    	push   DWORD PTR [ebp-0x8c]
    2677:	57                   	push   edi
    2678:	56                   	push   esi
    2679:	52                   	push   edx
    267a:	68 fc 01 00 00       	push   0x1fc
    267f:	e8 fc ff ff ff       	call   2680 <print_stat+0x2cd>
    2684:	83 c4 50             	add    esp,0x50
						datstr);
		if (S_ISDIR(m)) {
    2687:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    268a:	25 00 f0 00 00       	and    eax,0xf000
    268f:	3d 00 40 00 00       	cmp    eax,0x4000
    2694:	75 4f                	jne    26e5 <print_stat+0x332>
				fmt = LFMT_DIR;
    2696:	c6 45 e7 09          	mov    BYTE PTR [ebp-0x19],0x9
				if ((m & S_ISVTX) && (m & S_IWOTH))
    269a:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    269d:	25 00 02 00 00       	and    eax,0x200
    26a2:	85 c0                	test   eax,eax
    26a4:	74 13                	je     26b9 <print_stat+0x306>
    26a6:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    26a9:	83 e0 02             	and    eax,0x2
    26ac:	85 c0                	test   eax,eax
    26ae:	74 09                	je     26b9 <print_stat+0x306>
						fmt = LFMT_SWRT;
    26b0:	c6 45 e7 20          	mov    BYTE PTR [ebp-0x19],0x20
    26b4:	e9 04 01 00 00       	jmp    27bd <print_stat+0x40a>
				else if (m & S_IWOTH)
    26b9:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    26bc:	83 e0 02             	and    eax,0x2
    26bf:	85 c0                	test   eax,eax
    26c1:	74 09                	je     26cc <print_stat+0x319>
						fmt = LFMT_OWRT;
    26c3:	c6 45 e7 21          	mov    BYTE PTR [ebp-0x19],0x21
    26c7:	e9 f1 00 00 00       	jmp    27bd <print_stat+0x40a>
				else if (m & S_ISVTX)
    26cc:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    26cf:	25 00 02 00 00       	and    eax,0x200
    26d4:	85 c0                	test   eax,eax
    26d6:	0f 84 e1 00 00 00    	je     27bd <print_stat+0x40a>
						fmt = LFMT_STCK;
    26dc:	c6 45 e7 10          	mov    BYTE PTR [ebp-0x19],0x10
    26e0:	e9 d8 00 00 00       	jmp    27bd <print_stat+0x40a>
		} else if (S_ISREG(m)) {
    26e5:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    26e8:	25 00 f0 00 00       	and    eax,0xf000
    26ed:	3d 00 80 00 00       	cmp    eax,0x8000
    26f2:	75 5c                	jne    2750 <print_stat+0x39d>
				if (m & S_ISUID)
    26f4:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    26f7:	25 00 08 00 00       	and    eax,0x800
    26fc:	85 c0                	test   eax,eax
    26fe:	74 09                	je     2709 <print_stat+0x356>
						fmt = LFMT_SUID;
    2700:	c6 45 e7 4f          	mov    BYTE PTR [ebp-0x19],0x4f
    2704:	e9 b4 00 00 00       	jmp    27bd <print_stat+0x40a>
				else if (m & S_ISGID)
    2709:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    270c:	25 00 04 00 00       	and    eax,0x400
    2711:	85 c0                	test   eax,eax
    2713:	74 09                	je     271e <print_stat+0x36b>
						fmt = LFMT_SGID;
    2715:	c6 45 e7 e0          	mov    BYTE PTR [ebp-0x19],0xe0
    2719:	e9 9f 00 00 00       	jmp    27bd <print_stat+0x40a>
				else if (m & S_IXUGO)
    271e:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2721:	83 e0 49             	and    eax,0x49
    2724:	85 c0                	test   eax,eax
    2726:	74 09                	je     2731 <print_stat+0x37e>
						fmt = LFMT_EXEC;
    2728:	c6 45 e7 0a          	mov    BYTE PTR [ebp-0x19],0xa
    272c:	e9 8c 00 00 00       	jmp    27bd <print_stat+0x40a>
				else if (in->in_stat.st_nlink > 1)
    2731:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2734:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    2737:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    273a:	bb 01 00 00 00       	mov    ebx,0x1
    273f:	b9 00 00 00 00       	mov    ecx,0x0
    2744:	39 c3                	cmp    ebx,eax
    2746:	19 d1                	sbb    ecx,edx
    2748:	73 73                	jae    27bd <print_stat+0x40a>
						fmt = LFMT_MH;
    274a:	c6 45 e7 0f          	mov    BYTE PTR [ebp-0x19],0xf
    274e:	eb 6d                	jmp    27bd <print_stat+0x40a>
		} else if (S_ISLNK(m))
    2750:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2753:	25 00 f0 00 00       	and    eax,0xf000
    2758:	3d 00 a0 00 00       	cmp    eax,0xa000
    275d:	75 06                	jne    2765 <print_stat+0x3b2>
				fmt = LFMT_LNK;
    275f:	c6 45 e7 0b          	mov    BYTE PTR [ebp-0x19],0xb
    2763:	eb 58                	jmp    27bd <print_stat+0x40a>
		else if (S_ISFIFO(m))
    2765:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2768:	25 00 f0 00 00       	and    eax,0xf000
    276d:	3d 00 10 00 00       	cmp    eax,0x1000
    2772:	75 06                	jne    277a <print_stat+0x3c7>
				fmt = LFMT_PIPE;
    2774:	c6 45 e7 06          	mov    BYTE PTR [ebp-0x19],0x6
    2778:	eb 43                	jmp    27bd <print_stat+0x40a>
		else if (S_ISSOCK(m))
    277a:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    277d:	25 00 f0 00 00       	and    eax,0xf000
    2782:	3d 00 c0 00 00       	cmp    eax,0xc000
    2787:	75 06                	jne    278f <print_stat+0x3dc>
				fmt = LFMT_SOCK;
    2789:	c6 45 e7 0d          	mov    BYTE PTR [ebp-0x19],0xd
    278d:	eb 2e                	jmp    27bd <print_stat+0x40a>
		else if (S_ISBLK(m))
    278f:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2792:	25 00 f0 00 00       	and    eax,0xf000
    2797:	3d 00 60 00 00       	cmp    eax,0x6000
    279c:	75 06                	jne    27a4 <print_stat+0x3f1>
				fmt = LFMT_BDEV;
    279e:	c6 45 e7 0e          	mov    BYTE PTR [ebp-0x19],0xe
    27a2:	eb 19                	jmp    27bd <print_stat+0x40a>
		else if (S_ISCHR(m))
    27a4:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    27a7:	25 00 f0 00 00       	and    eax,0xf000
    27ac:	3d 00 20 00 00       	cmp    eax,0x2000
    27b1:	75 06                	jne    27b9 <print_stat+0x406>
				fmt = LFMT_CDEV;
    27b3:	c6 45 e7 0e          	mov    BYTE PTR [ebp-0x19],0xe
    27b7:	eb 04                	jmp    27bd <print_stat+0x40a>
		/*else if (S_ISDOOR(m))
				fmt = LFMT_DOOR;*/
		else
				fmt = LFMT_ORPH;
    27b9:	c6 45 e7 0f          	mov    BYTE PTR [ebp-0x19],0xf
		cprintf(fmt, "%s\n", fn);
    27bd:	0f be 45 e7          	movsx  eax,BYTE PTR [ebp-0x19]
    27c1:	83 ec 04             	sub    esp,0x4
    27c4:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    27c7:	68 25 02 00 00       	push   0x225
    27cc:	50                   	push   eax
    27cd:	e8 fc ff ff ff       	call   27ce <print_stat+0x41b>
    27d2:	83 c4 10             	add    esp,0x10
}
    27d5:	90                   	nop
    27d6:	8d 65 f4             	lea    esp,[ebp-0xc]
    27d9:	5b                   	pop    ebx
    27da:	5e                   	pop    esi
    27db:	5f                   	pop    edi
    27dc:	5d                   	pop    ebp
    27dd:	c3                   	ret

000027de <path_lookup>:

struct inode* path_lookup(const char* str, char* tk, size_t ntk, int allow_partial)
{
    27de:	55                   	push   ebp
    27df:	89 e5                	mov    ebp,esp
    27e1:	81 ec 28 01 00 00    	sub    esp,0x128
		static char pwd[260] = "/";
		static struct inode* in_pwd = NULL, *in = NULL, *in_prev = NULL;
		char buf[260], *ltk = "", *ctx, *tok;
    27e7:	c7 45 f4 48 01 00 00 	mov    DWORD PTR [ebp-0xc],0x148
		if (!in_pwd)
    27ee:	a1 38 28 00 00       	mov    eax,ds:0x2838
    27f3:	85 c0                	test   eax,eax
    27f5:	75 0a                	jne    2801 <path_lookup+0x23>
				in_pwd = in_root;
    27f7:	a1 30 28 00 00       	mov    eax,ds:0x2830
    27fc:	a3 38 28 00 00       	mov    ds:0x2838,eax
		/* navigate to path */
		strncpy(buf, str, 260);
    2801:	83 ec 04             	sub    esp,0x4
    2804:	68 04 01 00 00       	push   0x104
    2809:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    280c:	8d 85 e8 fe ff ff    	lea    eax,[ebp-0x118]
    2812:	50                   	push   eax
    2813:	e8 fc ff ff ff       	call   2814 <path_lookup+0x36>
    2818:	83 c4 10             	add    esp,0x10
		buf[260] = '\0';
    281b:	c6 45 ec 00          	mov    BYTE PTR [ebp-0x14],0x0
		ltk = tok = strtok_r(buf, "/", &ctx);
    281f:	83 ec 04             	sub    esp,0x4
    2822:	8d 85 e4 fe ff ff    	lea    eax,[ebp-0x11c]
    2828:	50                   	push   eax
    2829:	68 29 02 00 00       	push   0x229
    282e:	8d 85 e8 fe ff ff    	lea    eax,[ebp-0x118]
    2834:	50                   	push   eax
    2835:	e8 fc ff ff ff       	call   2836 <path_lookup+0x58>
    283a:	83 c4 10             	add    esp,0x10
    283d:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    2840:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2843:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		in = ((*str == '/') ? in_root : in_pwd); /* abs or rel */
    2846:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2849:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    284c:	3c 2f                	cmp    al,0x2f
    284e:	75 07                	jne    2857 <path_lookup+0x79>
    2850:	a1 30 28 00 00       	mov    eax,ds:0x2830
    2855:	eb 05                	jmp    285c <path_lookup+0x7e>
    2857:	a1 38 28 00 00       	mov    eax,ds:0x2838
    285c:	a3 3c 28 00 00       	mov    ds:0x283c,eax
		in_prev = in;
    2861:	a1 3c 28 00 00       	mov    eax,ds:0x283c
    2866:	a3 40 28 00 00       	mov    ds:0x2840,eax
		while (tok) {
    286b:	e9 00 01 00 00       	jmp    2970 <path_lookup+0x192>
				const struct device_desc* dd;
				dd = get_device(in->in_stat.st_dev);
    2870:	a1 3c 28 00 00       	mov    eax,ds:0x283c
    2875:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    2878:	8b 00                	mov    eax,DWORD PTR [eax]
    287a:	83 ec 08             	sub    esp,0x8
    287d:	52                   	push   edx
    287e:	50                   	push   eax
    287f:	e8 fc ff ff ff       	call   2880 <path_lookup+0xa2>
    2884:	83 c4 10             	add    esp,0x10
    2887:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				if (!dd) {
    288a:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    288e:	75 31                	jne    28c1 <path_lookup+0xe3>
						cprintf(KFMT_WARN, "unable to explore node "
    2890:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
							"%s at associated device %u is not registered. errno=%d\n",
							tok, (uint32_t)in->in_stat.st_dev, errno);
    2896:	a1 3c 28 00 00       	mov    eax,ds:0x283c
    289b:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    289e:	8b 00                	mov    eax,DWORD PTR [eax]
						cprintf(KFMT_WARN, "unable to explore node "
    28a0:	83 ec 0c             	sub    esp,0xc
    28a3:	51                   	push   ecx
    28a4:	50                   	push   eax
    28a5:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    28a8:	68 2c 02 00 00       	push   0x22c
    28ad:	6a 0e                	push   0xe
    28af:	e8 fc ff ff ff       	call   28b0 <path_lookup+0xd2>
    28b4:	83 c4 20             	add    esp,0x20
						return NULL;
    28b7:	b8 00 00 00 00       	mov    eax,0x0
    28bc:	e9 e6 00 00 00       	jmp    29a7 <path_lookup+0x1c9>
				}
				ltk = tok;
    28c1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    28c4:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				in = dd->fn_get_subnode(in, tok);
    28c7:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    28ca:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
    28cd:	8b 15 3c 28 00 00    	mov    edx,DWORD PTR ds:0x283c
    28d3:	83 ec 08             	sub    esp,0x8
    28d6:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    28d9:	52                   	push   edx
    28da:	ff d0                	call   eax
    28dc:	83 c4 10             	add    esp,0x10
    28df:	a3 3c 28 00 00       	mov    ds:0x283c,eax
				if (!in) {
    28e4:	a1 3c 28 00 00       	mov    eax,ds:0x283c
    28e9:	85 c0                	test   eax,eax
    28eb:	75 5d                	jne    294a <path_lookup+0x16c>
						if (!allow_partial)
    28ed:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
    28f1:	75 28                	jne    291b <path_lookup+0x13d>
								cprintf(KFMT_WARN, "Failed to locate subnode %s"
    28f3:	a1 00 00 00 00       	mov    eax,ds:0x0
    28f8:	83 ec 0c             	sub    esp,0xc
    28fb:	50                   	push   eax
    28fc:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    28ff:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    2902:	68 7c 02 00 00       	push   0x27c
    2907:	6a 0e                	push   0xe
    2909:	e8 fc ff ff ff       	call   290a <path_lookup+0x12c>
    290e:	83 c4 20             	add    esp,0x20
										strncpy(tk, ltk, ntk);
										tk[ntk - 1] = '\0';
								}
								return in_prev;
						}
						return NULL;
    2911:	b8 00 00 00 00       	mov    eax,0x0
    2916:	e9 8c 00 00 00       	jmp    29a7 <path_lookup+0x1c9>
								if (tk) {
    291b:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
    291f:	74 22                	je     2943 <path_lookup+0x165>
										strncpy(tk, ltk, ntk);
    2921:	83 ec 04             	sub    esp,0x4
    2924:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    2927:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    292a:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    292d:	e8 fc ff ff ff       	call   292e <path_lookup+0x150>
    2932:	83 c4 10             	add    esp,0x10
										tk[ntk - 1] = '\0';
    2935:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    2938:	8d 50 ff             	lea    edx,[eax-0x1]
    293b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    293e:	01 d0                	add    eax,edx
    2940:	c6 00 00             	mov    BYTE PTR [eax],0x0
								return in_prev;
    2943:	a1 40 28 00 00       	mov    eax,ds:0x2840
    2948:	eb 5d                	jmp    29a7 <path_lookup+0x1c9>
				} else {
						in_prev = in;
    294a:	a1 3c 28 00 00       	mov    eax,ds:0x283c
    294f:	a3 40 28 00 00       	mov    ds:0x2840,eax
				}
				tok = strtok_r(NULL, "/", &ctx);
    2954:	83 ec 04             	sub    esp,0x4
    2957:	8d 85 e4 fe ff ff    	lea    eax,[ebp-0x11c]
    295d:	50                   	push   eax
    295e:	68 29 02 00 00       	push   0x229
    2963:	6a 00                	push   0x0
    2965:	e8 fc ff ff ff       	call   2966 <path_lookup+0x188>
    296a:	83 c4 10             	add    esp,0x10
    296d:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		while (tok) {
    2970:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    2974:	0f 85 f6 fe ff ff    	jne    2870 <path_lookup+0x92>
		}
		if (tk) {
    297a:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
    297e:	74 22                	je     29a2 <path_lookup+0x1c4>
				strncpy(tk, ltk, ntk);
    2980:	83 ec 04             	sub    esp,0x4
    2983:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    2986:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    2989:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    298c:	e8 fc ff ff ff       	call   298d <path_lookup+0x1af>
    2991:	83 c4 10             	add    esp,0x10
				tk[ntk - 1] = '\0';
    2994:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    2997:	8d 50 ff             	lea    edx,[eax-0x1]
    299a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    299d:	01 d0                	add    eax,edx
    299f:	c6 00 00             	mov    BYTE PTR [eax],0x0
		}
		return in;
    29a2:	a1 3c 28 00 00       	mov    eax,ds:0x283c
}
    29a7:	c9                   	leave
    29a8:	c3                   	ret

000029a9 <fcli_ls>:

int fcli_ls(const char* str)
{
    29a9:	55                   	push   ebp
    29aa:	89 e5                	mov    ebp,esp
    29ac:	53                   	push   ebx
    29ad:	81 ec 14 01 00 00    	sub    esp,0x114
		struct inode* in = NULL; char ltk[40];
    29b3:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [ebp-0x28],0x0
		/* ls-like commands */
		str += 3;
    29ba:	83 45 08 03          	add    DWORD PTR [ebp+0x8],0x3
		/* navigate to path */
		in = path_lookup(str, ltk, sizeof(ltk), 0);
    29be:	6a 00                	push   0x0
    29c0:	6a 28                	push   0x28
    29c2:	8d 45 90             	lea    eax,[ebp-0x70]
    29c5:	50                   	push   eax
    29c6:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    29c9:	e8 fc ff ff ff       	call   29ca <fcli_ls+0x21>
    29ce:	83 c4 10             	add    esp,0x10
    29d1:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
		if (!in)
    29d4:	83 7d d8 00          	cmp    DWORD PTR [ebp-0x28],0x0
    29d8:	75 0a                	jne    29e4 <fcli_ls+0x3b>
				return 1;
    29da:	b8 01 00 00 00       	mov    eax,0x1
    29df:	e9 25 04 00 00       	jmp    2e09 <fcli_ls+0x460>
		/* now do the lookup (default to ls -l) */
		if (S_ISDIR(in->in_stat.st_mode)) {
    29e4:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    29e7:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    29ea:	25 00 f0 00 00       	and    eax,0xf000
    29ef:	3d 00 40 00 00       	cmp    eax,0x4000
    29f4:	0f 85 f0 03 00 00    	jne    2dea <fcli_ls+0x441>
				const struct device_desc* dd; int fd;
				/* max and sum of blocks, size, user, gid */
				size_t mb = 0, ms = 0, mu = 0, mg = 0, sb = 0, ss = 0;
    29fa:	c7 45 8c 00 00 00 00 	mov    DWORD PTR [ebp-0x74],0x0
    2a01:	c7 45 88 00 00 00 00 	mov    DWORD PTR [ebp-0x78],0x0
    2a08:	c7 45 84 00 00 00 00 	mov    DWORD PTR [ebp-0x7c],0x0
    2a0f:	c7 45 80 00 00 00 00 	mov    DWORD PTR [ebp-0x80],0x0
    2a16:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    2a1d:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
				char buf[128]; size_t nr; int frst = 1;
    2a24:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [ebp-0x14],0x1

				/* open directory for reading */
				dd = get_device(in->in_stat.st_dev);
    2a2b:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2a2e:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    2a31:	8b 00                	mov    eax,DWORD PTR [eax]
    2a33:	83 ec 08             	sub    esp,0x8
    2a36:	52                   	push   edx
    2a37:	50                   	push   eax
    2a38:	e8 fc ff ff ff       	call   2a39 <fcli_ls+0x90>
    2a3d:	83 c4 10             	add    esp,0x10
    2a40:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				if (!dd) {
    2a43:	83 7d d4 00          	cmp    DWORD PTR [ebp-0x2c],0x0
    2a47:	75 23                	jne    2a6c <fcli_ls+0xc3>
						printf("unable to obtain device %u associated"
							" with the directory\n", (uint32_t)in->in_stat.st_dev);
    2a49:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2a4c:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    2a4f:	8b 00                	mov    eax,DWORD PTR [eax]
						printf("unable to obtain device %u associated"
    2a51:	83 ec 08             	sub    esp,0x8
    2a54:	50                   	push   eax
    2a55:	68 b0 02 00 00       	push   0x2b0
    2a5a:	e8 fc ff ff ff       	call   2a5b <fcli_ls+0xb2>
    2a5f:	83 c4 10             	add    esp,0x10
						return 1;
    2a62:	b8 01 00 00 00       	mov    eax,0x1
    2a67:	e9 9d 03 00 00       	jmp    2e09 <fcli_ls+0x460>
				}
				fd = dd->fn_open(in, O_RDONLY);
    2a6c:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    2a6f:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    2a72:	83 ec 08             	sub    esp,0x8
    2a75:	6a 00                	push   0x0
    2a77:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
    2a7a:	ff d0                	call   eax
    2a7c:	83 c4 10             	add    esp,0x10
    2a7f:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
				if (fd == -1) {
    2a82:	83 7d d0 ff          	cmp    DWORD PTR [ebp-0x30],0xffffffff
    2a86:	74 03                	je     2a8b <fcli_ls+0xe2>
						printf("unable to access directory for reading: errno=%d\n", errno);
						return 1;
				}
				/* now read the data */
Pos0:
    2a88:	90                   	nop
    2a89:	eb 20                	jmp    2aab <fcli_ls+0x102>
						printf("unable to access directory for reading: errno=%d\n", errno);
    2a8b:	a1 00 00 00 00       	mov    eax,ds:0x0
    2a90:	83 ec 08             	sub    esp,0x8
    2a93:	50                   	push   eax
    2a94:	68 ec 02 00 00       	push   0x2ec
    2a99:	e8 fc ff ff ff       	call   2a9a <fcli_ls+0xf1>
    2a9e:	83 c4 10             	add    esp,0x10
						return 1;
    2aa1:	b8 01 00 00 00       	mov    eax,0x1
    2aa6:	e9 5e 03 00 00       	jmp    2e09 <fcli_ls+0x460>
				if (!frst) {
    2aab:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    2aaf:	0f 85 be 00 00 00    	jne    2b73 <fcli_ls+0x1ca>
						size_t im; size_t* arr[] = { &mb, &ms, &mu, &mg };
    2ab5:	8d 45 8c             	lea    eax,[ebp-0x74]
    2ab8:	89 85 70 ff ff ff    	mov    DWORD PTR [ebp-0x90],eax
    2abe:	8d 45 88             	lea    eax,[ebp-0x78]
    2ac1:	89 85 74 ff ff ff    	mov    DWORD PTR [ebp-0x8c],eax
    2ac7:	8d 45 84             	lea    eax,[ebp-0x7c]
    2aca:	89 85 78 ff ff ff    	mov    DWORD PTR [ebp-0x88],eax
    2ad0:	8d 45 80             	lea    eax,[ebp-0x80]
    2ad3:	89 85 7c ff ff ff    	mov    DWORD PTR [ebp-0x84],eax
						/* calculate the capacites */
						for (size_t** p = &arr[0]; p <= &arr[3]; p++) {
    2ad9:	8d 85 70 ff ff ff    	lea    eax,[ebp-0x90]
    2adf:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    2ae2:	eb 3d                	jmp    2b21 <fcli_ls+0x178>
								im = 1;
    2ae4:	c7 45 e8 01 00 00 00 	mov    DWORD PTR [ebp-0x18],0x1
								while ((**p /= 10))
    2aeb:	eb 04                	jmp    2af1 <fcli_ls+0x148>
										im++;
    2aed:	83 45 e8 01          	add    DWORD PTR [ebp-0x18],0x1
								while ((**p /= 10))
    2af1:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2af4:	8b 00                	mov    eax,DWORD PTR [eax]
    2af6:	8b 10                	mov    edx,DWORD PTR [eax]
    2af8:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2afb:	8b 08                	mov    ecx,DWORD PTR [eax]
    2afd:	bb cd cc cc cc       	mov    ebx,0xcccccccd
    2b02:	89 d0                	mov    eax,edx
    2b04:	f7 e3                	mul    ebx
    2b06:	89 d0                	mov    eax,edx
    2b08:	c1 e8 03             	shr    eax,0x3
    2b0b:	89 01                	mov    DWORD PTR [ecx],eax
    2b0d:	8b 01                	mov    eax,DWORD PTR [ecx]
    2b0f:	85 c0                	test   eax,eax
    2b11:	75 da                	jne    2aed <fcli_ls+0x144>
								**p = im;
    2b13:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2b16:	8b 00                	mov    eax,DWORD PTR [eax]
    2b18:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    2b1b:	89 10                	mov    DWORD PTR [eax],edx
						for (size_t** p = &arr[0]; p <= &arr[3]; p++) {
    2b1d:	83 45 e4 04          	add    DWORD PTR [ebp-0x1c],0x4
    2b21:	8d 85 70 ff ff ff    	lea    eax,[ebp-0x90]
    2b27:	83 c0 0c             	add    eax,0xc
    2b2a:	3b 45 e4             	cmp    eax,DWORD PTR [ebp-0x1c]
    2b2d:	73 b5                	jae    2ae4 <fcli_ls+0x13b>
						}
						if (dd->fn_lseek(in, fd, 0, SEEK_SET) != 0) {
    2b2f:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    2b32:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    2b35:	83 ec 0c             	sub    esp,0xc
    2b38:	6a 00                	push   0x0
    2b3a:	6a 00                	push   0x0
    2b3c:	6a 00                	push   0x0
    2b3e:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
    2b41:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
    2b44:	ff d0                	call   eax
    2b46:	83 c4 20             	add    esp,0x20
    2b49:	89 c1                	mov    ecx,eax
    2b4b:	89 c8                	mov    eax,ecx
    2b4d:	09 d0                	or     eax,edx
    2b4f:	74 22                	je     2b73 <fcli_ls+0x1ca>
								cprintf(KFMT_ERROR, "failed to seek to start"
    2b51:	a1 00 00 00 00       	mov    eax,ds:0x0
    2b56:	83 ec 04             	sub    esp,0x4
    2b59:	50                   	push   eax
    2b5a:	68 20 03 00 00       	push   0x320
    2b5f:	6a 0c                	push   0xc
    2b61:	e8 fc ff ff ff       	call   2b62 <fcli_ls+0x1b9>
    2b66:	83 c4 10             	add    esp,0x10
									" of directory file. errno=%d\n", errno);
								return 1;
    2b69:	b8 01 00 00 00       	mov    eax,0x1
						return 1;
    2b6e:	e9 96 02 00 00       	jmp    2e09 <fcli_ls+0x460>
						}
				}
				do {
						char* fn = buf, *fn_prev; size_t s;
    2b73:	8d 85 f0 fe ff ff    	lea    eax,[ebp-0x110]
    2b79:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
						nr = dd->fn_read(in, fd, buf, sizeof(buf) - 1);
    2b7c:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    2b7f:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    2b82:	6a 7f                	push   0x7f
    2b84:	8d 95 f0 fe ff ff    	lea    edx,[ebp-0x110]
    2b8a:	52                   	push   edx
    2b8b:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
    2b8e:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
    2b91:	ff d0                	call   eax
    2b93:	83 c4 10             	add    esp,0x10
    2b96:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
						buf[nr] = '\0';
    2b99:	8d 95 f0 fe ff ff    	lea    edx,[ebp-0x110]
    2b9f:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    2ba2:	01 d0                	add    eax,edx
    2ba4:	c6 00 00             	mov    BYTE PTR [eax],0x0
						while ((s = strlen(fn))) {
    2ba7:	e9 bf 01 00 00       	jmp    2d6b <fcli_ls+0x3c2>
								struct inode* in1;
Pos1:
								if (fn + s + 1 + sizeof(struct inode*) > buf + sizeof(buf)) {
    2bac:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2baf:	8d 50 05             	lea    edx,[eax+0x5]
    2bb2:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    2bb5:	01 c2                	add    edx,eax
    2bb7:	8d 85 f0 fe ff ff    	lea    eax,[ebp-0x110]
    2bbd:	83 e8 80             	sub    eax,0xffffff80
    2bc0:	39 d0                	cmp    eax,edx
    2bc2:	0f 83 ab 00 00 00    	jae    2c73 <fcli_ls+0x2ca>
										/* data spans, try lseek */
										off_t sk = sizeof(buf) - (fn - buf);
    2bc8:	8d 85 f0 fe ff ff    	lea    eax,[ebp-0x110]
    2bce:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    2bd1:	29 c2                	sub    edx,eax
    2bd3:	b8 80 00 00 00       	mov    eax,0x80
    2bd8:	29 d0                	sub    eax,edx
    2bda:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
    2bdd:	c7 45 bc 00 00 00 00 	mov    DWORD PTR [ebp-0x44],0x0
										if (sk == -sizeof(buf)) {
    2be4:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    2be7:	83 f0 80             	xor    eax,0xffffff80
    2bea:	0b 45 bc             	or     eax,DWORD PTR [ebp-0x44]
    2bed:	75 1c                	jne    2c0b <fcli_ls+0x262>
												cprintf(KFMT_ERROR, "fn too long for intermediate buffer\n");
    2bef:	83 ec 08             	sub    esp,0x8
    2bf2:	68 58 03 00 00       	push   0x358
    2bf7:	6a 0c                	push   0xc
    2bf9:	e8 fc ff ff ff       	call   2bfa <fcli_ls+0x251>
    2bfe:	83 c4 10             	add    esp,0x10
												return 1;
    2c01:	b8 01 00 00 00       	mov    eax,0x1
    2c06:	e9 fe 01 00 00       	jmp    2e09 <fcli_ls+0x460>
										}
										if (-1 == dd->fn_lseek(in, fd, sk, SEEK_CUR)) {
    2c0b:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    2c0e:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    2c11:	83 ec 0c             	sub    esp,0xc
    2c14:	6a 01                	push   0x1
    2c16:	ff 75 bc             	push   DWORD PTR [ebp-0x44]
    2c19:	ff 75 b8             	push   DWORD PTR [ebp-0x48]
    2c1c:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
    2c1f:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
    2c22:	ff d0                	call   eax
    2c24:	83 c4 20             	add    esp,0x20
    2c27:	89 c1                	mov    ecx,eax
    2c29:	89 d0                	mov    eax,edx
    2c2b:	21 c8                	and    eax,ecx
    2c2d:	83 f8 ff             	cmp    eax,0xffffffff
    2c30:	75 22                	jne    2c54 <fcli_ls+0x2ab>
												cprintf(KFMT_WARN, "unable to seek on directory file for ls. errno=%d\n", errno);
    2c32:	a1 00 00 00 00       	mov    eax,ds:0x0
    2c37:	83 ec 04             	sub    esp,0x4
    2c3a:	50                   	push   eax
    2c3b:	68 80 03 00 00       	push   0x380
    2c40:	6a 0e                	push   0xe
    2c42:	e8 fc ff ff ff       	call   2c43 <fcli_ls+0x29a>
    2c47:	83 c4 10             	add    esp,0x10
												return 1;
    2c4a:	b8 01 00 00 00       	mov    eax,0x1
    2c4f:	e9 b5 01 00 00       	jmp    2e09 <fcli_ls+0x460>
										}
										fn = buf;
    2c54:	8d 85 f0 fe ff ff    	lea    eax,[ebp-0x110]
    2c5a:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
										s = strlen(fn);
    2c5d:	83 ec 0c             	sub    esp,0xc
    2c60:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
    2c63:	e8 fc ff ff ff       	call   2c64 <fcli_ls+0x2bb>
    2c68:	83 c4 10             	add    esp,0x10
    2c6b:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
										goto Pos1;
    2c6e:	e9 39 ff ff ff       	jmp    2bac <fcli_ls+0x203>
								}
								fn_prev = fn;
    2c73:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    2c76:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
								fn += s + 1;
    2c79:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2c7c:	83 c0 01             	add    eax,0x1
    2c7f:	01 45 e0             	add    DWORD PTR [ebp-0x20],eax
								in1 = *(struct inode**)fn;
    2c82:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    2c85:	8b 00                	mov    eax,DWORD PTR [eax]
    2c87:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
								fn += sizeof(struct inode*);
    2c8a:	83 45 e0 04          	add    DWORD PTR [ebp-0x20],0x4
								if (!in1) {
    2c8e:	83 7d c4 00          	cmp    DWORD PTR [ebp-0x3c],0x0
    2c92:	75 1a                	jne    2cae <fcli_ls+0x305>
										cprintf(KFMT_WARN, "inode of %s missing\n", fn_prev);
    2c94:	83 ec 04             	sub    esp,0x4
    2c97:	ff 75 c8             	push   DWORD PTR [ebp-0x38]
    2c9a:	68 b3 03 00 00       	push   0x3b3
    2c9f:	6a 0e                	push   0xe
    2ca1:	e8 fc ff ff ff       	call   2ca2 <fcli_ls+0x2f9>
    2ca6:	83 c4 10             	add    esp,0x10
    2ca9:	e9 bd 00 00 00       	jmp    2d6b <fcli_ls+0x3c2>
								} else if (frst) {
    2cae:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    2cb2:	0f 84 8c 00 00 00    	je     2d44 <fcli_ls+0x39b>
										if (in1->in_stat.st_nlink > mb)
    2cb8:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2cbb:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    2cbe:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    2cc1:	8b 4d 8c             	mov    ecx,DWORD PTR [ebp-0x74]
    2cc4:	bb 00 00 00 00       	mov    ebx,0x0
    2cc9:	39 c1                	cmp    ecx,eax
    2ccb:	19 d3                	sbb    ebx,edx
    2ccd:	73 0c                	jae    2cdb <fcli_ls+0x332>
												mb = in1->in_stat.st_nlink;
    2ccf:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2cd2:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    2cd5:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    2cd8:	89 45 8c             	mov    DWORD PTR [ebp-0x74],eax
										if (in1->in_stat.st_size > ms)
    2cdb:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2cde:	8b 50 30             	mov    edx,DWORD PTR [eax+0x30]
    2ce1:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    2ce4:	8b 4d 88             	mov    ecx,DWORD PTR [ebp-0x78]
    2ce7:	bb 00 00 00 00       	mov    ebx,0x0
    2cec:	39 c1                	cmp    ecx,eax
    2cee:	19 d3                	sbb    ebx,edx
    2cf0:	7d 0c                	jge    2cfe <fcli_ls+0x355>
												ms = in1->in_stat.st_size;
    2cf2:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2cf5:	8b 50 30             	mov    edx,DWORD PTR [eax+0x30]
    2cf8:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    2cfb:	89 45 88             	mov    DWORD PTR [ebp-0x78],eax
										if (in1->in_stat.st_uid > mu)
    2cfe:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2d01:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    2d04:	8b 55 84             	mov    edx,DWORD PTR [ebp-0x7c]
    2d07:	39 c2                	cmp    edx,eax
    2d09:	73 09                	jae    2d14 <fcli_ls+0x36b>
												mu = in1->in_stat.st_uid;
    2d0b:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2d0e:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    2d11:	89 45 84             	mov    DWORD PTR [ebp-0x7c],eax
										if (in1->in_stat.st_gid > mg)
    2d14:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2d17:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    2d1a:	8b 55 80             	mov    edx,DWORD PTR [ebp-0x80]
    2d1d:	39 c2                	cmp    edx,eax
    2d1f:	73 09                	jae    2d2a <fcli_ls+0x381>
												mg = in1->in_stat.st_gid;
    2d21:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2d24:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    2d27:	89 45 80             	mov    DWORD PTR [ebp-0x80],eax
										sb += in1->in_stat.st_blocks;
    2d2a:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2d2d:	8b 50 40             	mov    edx,DWORD PTR [eax+0x40]
    2d30:	8b 40 3c             	mov    eax,DWORD PTR [eax+0x3c]
    2d33:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
										ss += in1->in_stat.st_size;
    2d36:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2d39:	8b 50 30             	mov    edx,DWORD PTR [eax+0x30]
    2d3c:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    2d3f:	01 45 f0             	add    DWORD PTR [ebp-0x10],eax
    2d42:	eb 27                	jmp    2d6b <fcli_ls+0x3c2>
								} else {
										/* do the printing */
										print_stat(in1, fn_prev, mb, mu, mg, ms);
    2d44:	8b 45 88             	mov    eax,DWORD PTR [ebp-0x78]
    2d47:	89 c3                	mov    ebx,eax
    2d49:	8b 45 80             	mov    eax,DWORD PTR [ebp-0x80]
    2d4c:	89 c1                	mov    ecx,eax
    2d4e:	8b 45 84             	mov    eax,DWORD PTR [ebp-0x7c]
    2d51:	89 c2                	mov    edx,eax
    2d53:	8b 45 8c             	mov    eax,DWORD PTR [ebp-0x74]
    2d56:	83 ec 08             	sub    esp,0x8
    2d59:	53                   	push   ebx
    2d5a:	51                   	push   ecx
    2d5b:	52                   	push   edx
    2d5c:	50                   	push   eax
    2d5d:	ff 75 c8             	push   DWORD PTR [ebp-0x38]
    2d60:	ff 75 c4             	push   DWORD PTR [ebp-0x3c]
    2d63:	e8 fc ff ff ff       	call   2d64 <fcli_ls+0x3bb>
    2d68:	83 c4 20             	add    esp,0x20
						while ((s = strlen(fn))) {
    2d6b:	83 ec 0c             	sub    esp,0xc
    2d6e:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
    2d71:	e8 fc ff ff ff       	call   2d72 <fcli_ls+0x3c9>
    2d76:	83 c4 10             	add    esp,0x10
    2d79:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
    2d7c:	83 7d dc 00          	cmp    DWORD PTR [ebp-0x24],0x0
    2d80:	74 06                	je     2d88 <fcli_ls+0x3df>
Pos1:
    2d82:	90                   	nop
    2d83:	e9 24 fe ff ff       	jmp    2bac <fcli_ls+0x203>
								}
						}
				} while (nr);
    2d88:	83 7d cc 00          	cmp    DWORD PTR [ebp-0x34],0x0
    2d8c:	0f 85 e1 fd ff ff    	jne    2b73 <fcli_ls+0x1ca>
				if (frst) {
    2d92:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    2d96:	74 1f                	je     2db7 <fcli_ls+0x40e>
						printf("total %lu\n", sb);
    2d98:	83 ec 08             	sub    esp,0x8
    2d9b:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    2d9e:	68 c8 03 00 00       	push   0x3c8
    2da3:	e8 fc ff ff ff       	call   2da4 <fcli_ls+0x3fb>
    2da8:	83 c4 10             	add    esp,0x10
						frst = 0;
    2dab:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
						goto Pos0;
    2db2:	e9 f4 fc ff ff       	jmp    2aab <fcli_ls+0x102>
				}
				/* TODO: use dirent to not pollute space */
				if (-1 == dd->fn_close(in, fd)) {
    2db7:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    2dba:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    2dbd:	83 ec 08             	sub    esp,0x8
    2dc0:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
    2dc3:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
    2dc6:	ff d0                	call   eax
    2dc8:	83 c4 10             	add    esp,0x10
    2dcb:	83 f8 ff             	cmp    eax,0xffffffff
    2dce:	75 34                	jne    2e04 <fcli_ls+0x45b>
						cprintf(KFMT_WARN, "failed to close fd %d to"
    2dd0:	a1 00 00 00 00       	mov    eax,ds:0x0
    2dd5:	50                   	push   eax
    2dd6:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
    2dd9:	68 d4 03 00 00       	push   0x3d4
    2dde:	6a 0e                	push   0xe
    2de0:	e8 fc ff ff ff       	call   2de1 <fcli_ls+0x438>
    2de5:	83 c4 10             	add    esp,0x10
    2de8:	eb 1a                	jmp    2e04 <fcli_ls+0x45b>
							" directory file open for reading. errno=%d\n", fd, errno);
				}
		} else
			   print_stat(in, ltk, 0, 0, 0, 0);
    2dea:	83 ec 08             	sub    esp,0x8
    2ded:	6a 00                	push   0x0
    2def:	6a 00                	push   0x0
    2df1:	6a 00                	push   0x0
    2df3:	6a 00                	push   0x0
    2df5:	8d 45 90             	lea    eax,[ebp-0x70]
    2df8:	50                   	push   eax
    2df9:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
    2dfc:	e8 fc ff ff ff       	call   2dfd <fcli_ls+0x454>
    2e01:	83 c4 20             	add    esp,0x20
		return 1;
    2e04:	b8 01 00 00 00       	mov    eax,0x1
}
    2e09:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    2e0c:	c9                   	leave
    2e0d:	c3                   	ret

00002e0e <fcli_cat>:

int fcli_cat(const char* str)
{
    2e0e:	55                   	push   ebp
    2e0f:	89 e5                	mov    ebp,esp
    2e11:	81 ec 88 00 00 00    	sub    esp,0x88
		struct inode* in = NULL; char ltk[40];
    2e17:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
		/* cat-like commands */
		str += 4;
    2e1e:	83 45 08 04          	add    DWORD PTR [ebp+0x8],0x4
		/* navigate to path */
		in = path_lookup(str, ltk, sizeof(ltk), 0);
    2e22:	6a 00                	push   0x0
    2e24:	6a 28                	push   0x28
    2e26:	8d 45 bc             	lea    eax,[ebp-0x44]
    2e29:	50                   	push   eax
    2e2a:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    2e2d:	e8 fc ff ff ff       	call   2e2e <fcli_cat+0x20>
    2e32:	83 c4 10             	add    esp,0x10
    2e35:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		if (!in)
    2e38:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    2e3c:	75 0a                	jne    2e48 <fcli_cat+0x3a>
				return 1;
    2e3e:	b8 01 00 00 00       	mov    eax,0x1
    2e43:	e9 64 01 00 00       	jmp    2fac <fcli_cat+0x19e>

		/* read the file */
		const struct device_desc* dd; int fd; size_t nr;
		dd = get_device(in->in_stat.st_dev);
    2e48:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2e4b:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    2e4e:	8b 00                	mov    eax,DWORD PTR [eax]
    2e50:	83 ec 08             	sub    esp,0x8
    2e53:	52                   	push   edx
    2e54:	50                   	push   eax
    2e55:	e8 fc ff ff ff       	call   2e56 <fcli_cat+0x48>
    2e5a:	83 c4 10             	add    esp,0x10
    2e5d:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		if (!dd) {
    2e60:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    2e64:	75 20                	jne    2e86 <fcli_cat+0x78>
				printf("device error: errno=%d\n", errno);
    2e66:	a1 00 00 00 00       	mov    eax,ds:0x0
    2e6b:	83 ec 08             	sub    esp,0x8
    2e6e:	50                   	push   eax
    2e6f:	68 18 04 00 00       	push   0x418
    2e74:	e8 fc ff ff ff       	call   2e75 <fcli_cat+0x67>
    2e79:	83 c4 10             	add    esp,0x10
				return 1;
    2e7c:	b8 01 00 00 00       	mov    eax,0x1
    2e81:	e9 26 01 00 00       	jmp    2fac <fcli_cat+0x19e>
		}
		fd = dd->fn_open(in, O_RDONLY);
    2e86:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2e89:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    2e8c:	83 ec 08             	sub    esp,0x8
    2e8f:	6a 00                	push   0x0
    2e91:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    2e94:	ff d0                	call   eax
    2e96:	83 c4 10             	add    esp,0x10
    2e99:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		if (fd == -1) {
    2e9c:	83 7d e8 ff          	cmp    DWORD PTR [ebp-0x18],0xffffffff
    2ea0:	75 1d                	jne    2ebf <fcli_cat+0xb1>
				printf("cannot open file %s\n", str);
    2ea2:	83 ec 08             	sub    esp,0x8
    2ea5:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    2ea8:	68 30 04 00 00       	push   0x430
    2ead:	e8 fc ff ff ff       	call   2eae <fcli_cat+0xa0>
    2eb2:	83 c4 10             	add    esp,0x10
				return 1;
    2eb5:	b8 01 00 00 00       	mov    eax,0x1
    2eba:	e9 ed 00 00 00       	jmp    2fac <fcli_cat+0x19e>
		}
		printf("cat: size=%lld\n", in->in_stat.st_size);
    2ebf:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2ec2:	8b 50 30             	mov    edx,DWORD PTR [eax+0x30]
    2ec5:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    2ec8:	83 ec 04             	sub    esp,0x4
    2ecb:	52                   	push   edx
    2ecc:	50                   	push   eax
    2ecd:	68 45 04 00 00       	push   0x445
    2ed2:	e8 fc ff ff ff       	call   2ed3 <fcli_cat+0xc5>
    2ed7:	83 c4 10             	add    esp,0x10
		do {
				char buf[61];
				nr = dd->fn_read(in, fd, buf, sizeof(buf) - 1);
    2eda:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2edd:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    2ee0:	6a 3c                	push   0x3c
    2ee2:	8d 95 7f ff ff ff    	lea    edx,[ebp-0x81]
    2ee8:	52                   	push   edx
    2ee9:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    2eec:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    2eef:	ff d0                	call   eax
    2ef1:	83 c4 10             	add    esp,0x10
    2ef4:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				buf[nr] = '\0';
    2ef7:	8d 95 7f ff ff ff    	lea    edx,[ebp-0x81]
    2efd:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2f00:	01 d0                	add    eax,edx
    2f02:	c6 00 00             	mov    BYTE PTR [eax],0x0
				if (nr) {
    2f05:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    2f09:	74 62                	je     2f6d <fcli_cat+0x15f>
						char* c = buf;
    2f0b:	8d 85 7f ff ff ff    	lea    eax,[ebp-0x81]
    2f11:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						while (c < buf + nr)
    2f14:	eb 47                	jmp    2f5d <fcli_cat+0x14f>
								if (isprint(*c))
    2f16:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2f19:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    2f1c:	0f be c0             	movsx  eax,al
    2f1f:	83 ec 0c             	sub    esp,0xc
    2f22:	50                   	push   eax
    2f23:	e8 fc ff ff ff       	call   2f24 <fcli_cat+0x116>
    2f28:	83 c4 10             	add    esp,0x10
    2f2b:	85 c0                	test   eax,eax
    2f2d:	74 1d                	je     2f4c <fcli_cat+0x13e>
										putchar(*c++);
    2f2f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2f32:	8d 50 01             	lea    edx,[eax+0x1]
    2f35:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
    2f38:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    2f3b:	0f be c0             	movsx  eax,al
    2f3e:	83 ec 0c             	sub    esp,0xc
    2f41:	50                   	push   eax
    2f42:	e8 fc ff ff ff       	call   2f43 <fcli_cat+0x135>
    2f47:	83 c4 10             	add    esp,0x10
    2f4a:	eb 11                	jmp    2f5d <fcli_cat+0x14f>
								else {
										putchar('.');
    2f4c:	83 ec 0c             	sub    esp,0xc
    2f4f:	6a 2e                	push   0x2e
    2f51:	e8 fc ff ff ff       	call   2f52 <fcli_cat+0x144>
    2f56:	83 c4 10             	add    esp,0x10
										c++;
    2f59:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
						while (c < buf + nr)
    2f5d:	8d 95 7f ff ff ff    	lea    edx,[ebp-0x81]
    2f63:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2f66:	01 d0                	add    eax,edx
    2f68:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
    2f6b:	72 a9                	jb     2f16 <fcli_cat+0x108>
								}
				}
		} while (nr);
    2f6d:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    2f71:	0f 85 63 ff ff ff    	jne    2eda <fcli_cat+0xcc>
		if (-1 == dd->fn_close(in, fd))
    2f77:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2f7a:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    2f7d:	83 ec 08             	sub    esp,0x8
    2f80:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    2f83:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    2f86:	ff d0                	call   eax
    2f88:	83 c4 10             	add    esp,0x10
    2f8b:	83 f8 ff             	cmp    eax,0xffffffff
    2f8e:	75 07                	jne    2f97 <fcli_cat+0x189>
				return 1;
    2f90:	b8 01 00 00 00       	mov    eax,0x1
    2f95:	eb 15                	jmp    2fac <fcli_cat+0x19e>
		printf("\n");
    2f97:	83 ec 0c             	sub    esp,0xc
    2f9a:	68 55 04 00 00       	push   0x455
    2f9f:	e8 fc ff ff ff       	call   2fa0 <fcli_cat+0x192>
    2fa4:	83 c4 10             	add    esp,0x10
		return 1;
    2fa7:	b8 01 00 00 00       	mov    eax,0x1
}
    2fac:	c9                   	leave
    2fad:	c3                   	ret

00002fae <fcli_mkdir>:

int fcli_mkdir(const char* str)
{
    2fae:	55                   	push   ebp
    2faf:	89 e5                	mov    ebp,esp
    2fb1:	57                   	push   edi
    2fb2:	53                   	push   ebx
    2fb3:	81 ec b0 00 00 00    	sub    esp,0xb0
		struct inode* in; char ltk[40];
		const char* oc;
		if (str[2] == ' ')
    2fb9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2fbc:	83 c0 02             	add    eax,0x2
    2fbf:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    2fc2:	3c 20                	cmp    al,0x20
    2fc4:	75 06                	jne    2fcc <fcli_mkdir+0x1e>
				str += 3;
    2fc6:	83 45 08 03          	add    DWORD PTR [ebp+0x8],0x3
    2fca:	eb 04                	jmp    2fd0 <fcli_mkdir+0x22>
		else
				str += 6;
    2fcc:	83 45 08 06          	add    DWORD PTR [ebp+0x8],0x6
		in = path_lookup(str, ltk, sizeof(ltk), 1);
    2fd0:	6a 01                	push   0x1
    2fd2:	6a 28                	push   0x28
    2fd4:	8d 45 c4             	lea    eax,[ebp-0x3c]
    2fd7:	50                   	push   eax
    2fd8:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    2fdb:	e8 fc ff ff ff       	call   2fdc <fcli_mkdir+0x2e>
    2fe0:	83 c4 10             	add    esp,0x10
    2fe3:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (!in)
    2fe6:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    2fea:	75 0a                	jne    2ff6 <fcli_mkdir+0x48>
				return 0;
    2fec:	b8 00 00 00 00       	mov    eax,0x0
    2ff1:	e9 2f 01 00 00       	jmp    3125 <fcli_mkdir+0x177>
		oc = strstr(str, ltk);
    2ff6:	83 ec 08             	sub    esp,0x8
    2ff9:	8d 45 c4             	lea    eax,[ebp-0x3c]
    2ffc:	50                   	push   eax
    2ffd:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    3000:	e8 fc ff ff ff       	call   3001 <fcli_mkdir+0x53>
    3005:	83 c4 10             	add    esp,0x10
    3008:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		if (strchr(oc, '/'))
    300b:	83 ec 08             	sub    esp,0x8
    300e:	6a 2f                	push   0x2f
    3010:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    3013:	e8 fc ff ff ff       	call   3014 <fcli_mkdir+0x66>
    3018:	83 c4 10             	add    esp,0x10
    301b:	85 c0                	test   eax,eax
    301d:	74 21                	je     3040 <fcli_mkdir+0x92>
				printf("mkdir: cannot create directory '%s': no such file or directory (%s missing)\n", str, ltk);
    301f:	83 ec 04             	sub    esp,0x4
    3022:	8d 45 c4             	lea    eax,[ebp-0x3c]
    3025:	50                   	push   eax
    3026:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    3029:	68 58 04 00 00       	push   0x458
    302e:	e8 fc ff ff ff       	call   302f <fcli_mkdir+0x81>
    3033:	83 c4 10             	add    esp,0x10
						return 1;
				} else
						printf("created '%s' at '%*s'\n", ltk, (int)(oc - str), str);
				return 1;
		}
		return 1;
    3036:	b8 01 00 00 00       	mov    eax,0x1
    303b:	e9 e5 00 00 00       	jmp    3125 <fcli_mkdir+0x177>
				dd = get_device(in->in_stat.st_dev);
    3040:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3043:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3046:	8b 00                	mov    eax,DWORD PTR [eax]
    3048:	83 ec 08             	sub    esp,0x8
    304b:	52                   	push   edx
    304c:	50                   	push   eax
    304d:	e8 fc ff ff ff       	call   304e <fcli_mkdir+0xa0>
    3052:	83 c4 10             	add    esp,0x10
    3055:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				if (!dd) {
    3058:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    305c:	75 29                	jne    3087 <fcli_mkdir+0xd9>
								"with node '%s'\n", (uint32_t)in->in_stat.st_dev, ltk);
    305e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    3061:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    3064:	8b 00                	mov    eax,DWORD PTR [eax]
						printf("unable to obtain device %u associated"
    3066:	89 c2                	mov    edx,eax
    3068:	83 ec 04             	sub    esp,0x4
    306b:	8d 45 c4             	lea    eax,[ebp-0x3c]
    306e:	50                   	push   eax
    306f:	52                   	push   edx
    3070:	68 a8 04 00 00       	push   0x4a8
    3075:	e8 fc ff ff ff       	call   3076 <fcli_mkdir+0xc8>
    307a:	83 c4 10             	add    esp,0x10
						return 1;
    307d:	b8 01 00 00 00       	mov    eax,0x1
    3082:	e9 9e 00 00 00       	jmp    3125 <fcli_mkdir+0x177>
				if (dd->fn_set_subnode(in, &INO_TMPL_DIR, ltk) != 0) {
    3087:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    308a:	8b 58 28             	mov    ebx,DWORD PTR [eax+0x28]
    308d:	8d 95 48 ff ff ff    	lea    edx,[ebp-0xb8]
    3093:	b8 00 00 00 00       	mov    eax,0x0
    3098:	b9 1f 00 00 00       	mov    ecx,0x1f
    309d:	89 d7                	mov    edi,edx
    309f:	f3 ab                	rep stos DWORD PTR es:[edi],eax
    30a1:	c7 85 48 ff ff ff ff ff ff ff 	mov    DWORD PTR [ebp-0xb8],0xffffffff
    30ab:	c7 85 4c ff ff ff 00 00 00 00 	mov    DWORD PTR [ebp-0xb4],0x0
    30b5:	c7 85 58 ff ff ff 00 40 00 00 	mov    DWORD PTR [ebp-0xa8],0x4000
    30bf:	83 ec 04             	sub    esp,0x4
    30c2:	8d 45 c4             	lea    eax,[ebp-0x3c]
    30c5:	50                   	push   eax
    30c6:	8d 85 48 ff ff ff    	lea    eax,[ebp-0xb8]
    30cc:	50                   	push   eax
    30cd:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    30d0:	ff d3                	call   ebx
    30d2:	83 c4 10             	add    esp,0x10
    30d5:	85 c0                	test   eax,eax
    30d7:	74 2c                	je     3105 <fcli_mkdir+0x157>
						printf("unable to add directory '%s' to node '%*s': errno=%d\n",
    30d9:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
										ltk, (int)(oc - str), str, errno);
    30df:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    30e2:	2b 45 08             	sub    eax,DWORD PTR [ebp+0x8]
						printf("unable to add directory '%s' to node '%*s': errno=%d\n",
    30e5:	83 ec 0c             	sub    esp,0xc
    30e8:	52                   	push   edx
    30e9:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    30ec:	50                   	push   eax
    30ed:	8d 45 c4             	lea    eax,[ebp-0x3c]
    30f0:	50                   	push   eax
    30f1:	68 e0 04 00 00       	push   0x4e0
    30f6:	e8 fc ff ff ff       	call   30f7 <fcli_mkdir+0x149>
    30fb:	83 c4 20             	add    esp,0x20
						return 1;
    30fe:	b8 01 00 00 00       	mov    eax,0x1
    3103:	eb 20                	jmp    3125 <fcli_mkdir+0x177>
						printf("created '%s' at '%*s'\n", ltk, (int)(oc - str), str);
    3105:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3108:	2b 45 08             	sub    eax,DWORD PTR [ebp+0x8]
    310b:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    310e:	50                   	push   eax
    310f:	8d 45 c4             	lea    eax,[ebp-0x3c]
    3112:	50                   	push   eax
    3113:	68 16 05 00 00       	push   0x516
    3118:	e8 fc ff ff ff       	call   3119 <fcli_mkdir+0x16b>
    311d:	83 c4 10             	add    esp,0x10
				return 1;
    3120:	b8 01 00 00 00       	mov    eax,0x1
}
    3125:	8d 65 f8             	lea    esp,[ebp-0x8]
    3128:	5b                   	pop    ebx
    3129:	5f                   	pop    edi
    312a:	5d                   	pop    ebp
    312b:	c3                   	ret

0000312c <file_cli>:

extern int file_cli(const char* str)
{
    312c:	55                   	push   ebp
    312d:	89 e5                	mov    ebp,esp
    312f:	83 ec 08             	sub    esp,0x8
		if (strncmp(str, "ls", 2) == 0 && (!str[2] || str[2] == ' '))
    3132:	83 ec 04             	sub    esp,0x4
    3135:	6a 02                	push   0x2
    3137:	68 2d 05 00 00       	push   0x52d
    313c:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    313f:	e8 fc ff ff ff       	call   3140 <file_cli+0x14>
    3144:	83 c4 10             	add    esp,0x10
    3147:	85 c0                	test   eax,eax
    3149:	75 2d                	jne    3178 <file_cli+0x4c>
    314b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    314e:	83 c0 02             	add    eax,0x2
    3151:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    3154:	84 c0                	test   al,al
    3156:	74 0d                	je     3165 <file_cli+0x39>
    3158:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    315b:	83 c0 02             	add    eax,0x2
    315e:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    3161:	3c 20                	cmp    al,0x20
    3163:	75 13                	jne    3178 <file_cli+0x4c>
				return fcli_ls(str);
    3165:	83 ec 0c             	sub    esp,0xc
    3168:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    316b:	e8 fc ff ff ff       	call   316c <file_cli+0x40>
    3170:	83 c4 10             	add    esp,0x10
    3173:	e9 9e 00 00 00       	jmp    3216 <file_cli+0xea>
		else if (strncmp(str, "cat", 3) == 0 && (!str[3] || str[3] == ' '))
    3178:	83 ec 04             	sub    esp,0x4
    317b:	6a 03                	push   0x3
    317d:	68 30 05 00 00       	push   0x530
    3182:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    3185:	e8 fc ff ff ff       	call   3186 <file_cli+0x5a>
    318a:	83 c4 10             	add    esp,0x10
    318d:	85 c0                	test   eax,eax
    318f:	75 3e                	jne    31cf <file_cli+0xa3>
    3191:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3194:	83 c0 03             	add    eax,0x3
    3197:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    319a:	84 c0                	test   al,al
    319c:	74 0d                	je     31ab <file_cli+0x7f>
    319e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    31a1:	83 c0 03             	add    eax,0x3
    31a4:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    31a7:	3c 20                	cmp    al,0x20
    31a9:	75 24                	jne    31cf <file_cli+0xa3>
				if (!str[3]) /* stdin */
    31ab:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    31ae:	83 c0 03             	add    eax,0x3
    31b1:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    31b4:	84 c0                	test   al,al
    31b6:	75 07                	jne    31bf <file_cli+0x93>
						return 0;
    31b8:	b8 00 00 00 00       	mov    eax,0x0
    31bd:	eb 57                	jmp    3216 <file_cli+0xea>
				else
						return fcli_cat(str);
    31bf:	83 ec 0c             	sub    esp,0xc
    31c2:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    31c5:	e8 fc ff ff ff       	call   31c6 <file_cli+0x9a>
    31ca:	83 c4 10             	add    esp,0x10
    31cd:	eb 47                	jmp    3216 <file_cli+0xea>
		else if (strncmp(str, "mkdir ", 6) == 0 || strncmp(str, "md ", 3) == 0) {
    31cf:	83 ec 04             	sub    esp,0x4
    31d2:	6a 06                	push   0x6
    31d4:	68 34 05 00 00       	push   0x534
    31d9:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    31dc:	e8 fc ff ff ff       	call   31dd <file_cli+0xb1>
    31e1:	83 c4 10             	add    esp,0x10
    31e4:	85 c0                	test   eax,eax
    31e6:	74 19                	je     3201 <file_cli+0xd5>
    31e8:	83 ec 04             	sub    esp,0x4
    31eb:	6a 03                	push   0x3
    31ed:	68 3b 05 00 00       	push   0x53b
    31f2:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    31f5:	e8 fc ff ff ff       	call   31f6 <file_cli+0xca>
    31fa:	83 c4 10             	add    esp,0x10
    31fd:	85 c0                	test   eax,eax
    31ff:	75 10                	jne    3211 <file_cli+0xe5>
				return fcli_mkdir(str);
    3201:	83 ec 0c             	sub    esp,0xc
    3204:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    3207:	e8 fc ff ff ff       	call   3208 <file_cli+0xdc>
    320c:	83 c4 10             	add    esp,0x10
    320f:	eb 05                	jmp    3216 <file_cli+0xea>
		} else
				return 0; /* we have not handled the command */
    3211:	b8 00 00 00 00       	mov    eax,0x0
}
    3216:	c9                   	leave
    3217:	c3                   	ret

00003218 <module_cleanup>:

void MODENTRY module_cleanup()
{
    3218:	55                   	push   ebp
    3219:	89 e5                	mov    ebp,esp
    321b:	83 ec 08             	sub    esp,0x8
		printf("goodbye file.ko\n");
    321e:	83 ec 0c             	sub    esp,0xc
    3221:	68 3f 05 00 00       	push   0x53f
    3226:	e8 fc ff ff ff       	call   3227 <module_cleanup+0xf>
    322b:	83 c4 10             	add    esp,0x10
}
    322e:	90                   	nop
    322f:	c9                   	leave
    3230:	c3                   	ret
