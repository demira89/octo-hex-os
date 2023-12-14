
framebuffer.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <memcpy>:
						break;
				}

				/* and don't advance as r = 0 is already handled (sth. remains) */
				if (px_x) {
						px_x -= bitc / 32;
       0:	55                   	push   ebp
       1:	89 e5                	mov    ebp,esp
       3:	83 ec 10             	sub    esp,0x10
						p0_x += bitc / 32; /* unneccessary as r does not change anymore */
       6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
       9:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
				} else
       c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
       f:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
						break;
      12:	eb 17                	jmp    2b <memcpy+0x2b>
		}
      14:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
      17:	8d 42 01             	lea    eax,[edx+0x1]
      1a:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
      1d:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
      20:	8d 48 01             	lea    ecx,[eax+0x1]
      23:	89 4d fc             	mov    DWORD PTR [ebp-0x4],ecx
      26:	0f b6 12             	movzx  edx,BYTE PTR [edx]
      29:	88 10                	mov    BYTE PTR [eax],dl
						break;
      2b:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
      2e:	8d 50 ff             	lea    edx,[eax-0x1]
      31:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
      34:	85 c0                	test   eax,eax
      36:	75 dc                	jne    14 <memcpy+0x14>
}
      38:	90                   	nop
      39:	90                   	nop
      3a:	c9                   	leave
      3b:	c3                   	ret

0000003c <fb_video_setup>:
{
      3c:	55                   	push   ebp
      3d:	89 e5                	mov    ebp,esp
      3f:	57                   	push   edi
      40:	56                   	push   esi
      41:	53                   	push   ebx
      42:	83 ec 4c             	sub    esp,0x4c
		memcpy(&video_mode, FM_VIDEO_MODE, sizeof(video_mode));
      45:	c7 44 24 08 1c 00 00 00 	mov    DWORD PTR [esp+0x8],0x1c
      4d:	c7 44 24 04 00 f0 04 00 	mov    DWORD PTR [esp+0x4],0x4f000
      55:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
      5c:	e8 9f ff ff ff       	call   0 <memcpy>
		vga_font = (const char*)video_mode.fnt;
      61:	a1 10 00 00 00       	mov    eax,ds:0x10
      66:	a3 00 00 00 00       	mov    ds:0x0,eax
		vmd = (void*)video_mode.ptr;
      6b:	a1 18 00 00 00       	mov    eax,ds:0x18
      70:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		vga_mem_ptr = (void*)vmd->vga_virt;
      73:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
      76:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
      79:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
      7c:	a3 00 00 00 00       	mov    ds:0x0,eax
		vga_pmem = (void*)vmd->vga_base;
      81:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
      84:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
      87:	8b 00                	mov    eax,DWORD PTR [eax]
      89:	a3 00 00 00 00       	mov    ds:0x0,eax
		vga_pmem_size = (size_t)vmd->vga_size;
      8e:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
      91:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
      94:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
      97:	a3 00 00 00 00       	mov    ds:0x0,eax
						video_mode.height / 16 /* char_width_xy*/);
      9c:	a1 08 00 00 00       	mov    eax,ds:0x8
		framebuffer_initialize(&fb_initial, (void*)video_mode.fnt,
      a1:	8d 50 0f             	lea    edx,[eax+0xf]
      a4:	85 c0                	test   eax,eax
      a6:	0f 48 c2             	cmovs  eax,edx
      a9:	c1 f8 04             	sar    eax,0x4
      ac:	89 c7                	mov    edi,eax
						0, 0, /* char_ofs_xy*/ video_mode.width / 8,
      ae:	a1 04 00 00 00       	mov    eax,ds:0x4
		framebuffer_initialize(&fb_initial, (void*)video_mode.fnt,
      b3:	8d 50 07             	lea    edx,[eax+0x7]
      b6:	85 c0                	test   eax,eax
      b8:	0f 48 c2             	cmovs  eax,edx
      bb:	c1 f8 03             	sar    eax,0x3
      be:	89 c6                	mov    esi,eax
						video_mode.height / 16, 0, 0, /* pxl_ofs_xy*/
      c0:	a1 08 00 00 00       	mov    eax,ds:0x8
		framebuffer_initialize(&fb_initial, (void*)video_mode.fnt,
      c5:	8d 50 0f             	lea    edx,[eax+0xf]
      c8:	85 c0                	test   eax,eax
      ca:	0f 48 c2             	cmovs  eax,edx
      cd:	c1 f8 04             	sar    eax,0x4
      d0:	89 c3                	mov    ebx,eax
						(void*)video_mode.txt,video_mode.width / 8,
      d2:	a1 04 00 00 00       	mov    eax,ds:0x4
		framebuffer_initialize(&fb_initial, (void*)video_mode.fnt,
      d7:	8d 50 07             	lea    edx,[eax+0x7]
      da:	85 c0                	test   eax,eax
      dc:	0f 48 c2             	cmovs  eax,edx
      df:	c1 f8 03             	sar    eax,0x3
      e2:	89 c1                	mov    ecx,eax
						(void*)video_mode.txt,video_mode.width / 8,
      e4:	a1 14 00 00 00       	mov    eax,ds:0x14
		framebuffer_initialize(&fb_initial, (void*)video_mode.fnt,
      e9:	89 c2                	mov    edx,eax
      eb:	a1 10 00 00 00       	mov    eax,ds:0x10
      f0:	89 7c 24 28          	mov    DWORD PTR [esp+0x28],edi
      f4:	89 74 24 24          	mov    DWORD PTR [esp+0x24],esi
      f8:	c7 44 24 20 00 00 00 00 	mov    DWORD PTR [esp+0x20],0x0
     100:	c7 44 24 1c 00 00 00 00 	mov    DWORD PTR [esp+0x1c],0x0
     108:	c7 44 24 18 00 00 00 00 	mov    DWORD PTR [esp+0x18],0x0
     110:	c7 44 24 14 00 00 00 00 	mov    DWORD PTR [esp+0x14],0x0
     118:	89 5c 24 10          	mov    DWORD PTR [esp+0x10],ebx
     11c:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
     120:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     124:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     128:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     12f:	e8 fc ff ff ff       	call   130 <fb_video_setup+0xf4>
		kio_fb_resize();
     134:	e8 fc ff ff ff       	call   135 <fb_video_setup+0xf9>
		puts("done setting up the framebuffer");
     139:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     140:	e8 fc ff ff ff       	call   141 <fb_video_setup+0x105>
		framebuffer_redraw(&fb_initial);
     145:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     14c:	e8 fc ff ff ff       	call   14d <fb_video_setup+0x111>
}
     151:	90                   	nop
     152:	83 c4 4c             	add    esp,0x4c
     155:	5b                   	pop    ebx
     156:	5e                   	pop    esi
     157:	5f                   	pop    edi
     158:	5d                   	pop    ebp
     159:	c3                   	ret

0000015a <framebuffer_initialize>:
{
     15a:	55                   	push   ebp
     15b:	89 e5                	mov    ebp,esp
		fb->text_mem = textmem;
     15d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     160:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     163:	89 10                	mov    DWORD PTR [eax],edx
		fb->font = font;
     165:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     168:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     16b:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
		fb->width = width;
     16e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     171:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
     174:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		fb->height = height;
     177:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     17a:	8b 55 18             	mov    edx,DWORD PTR [ebp+0x18]
     17d:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
		fb->is_visible = 1;
     180:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     183:	c7 40 10 01 00 00 00 	mov    DWORD PTR [eax+0x10],0x1
		fb->cur_x = fb->cur_y = 0;
     18a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     18d:	c7 40 18 00 00 00 00 	mov    DWORD PTR [eax+0x18],0x0
     194:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     197:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
     19a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     19d:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
		fb->pix_x = pxl_ofs_x;
     1a0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1a3:	8b 55 1c             	mov    edx,DWORD PTR [ebp+0x1c]
     1a6:	89 50 1c             	mov    DWORD PTR [eax+0x1c],edx
		fb->pix_y = pxl_ofs_y;
     1a9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1ac:	8b 55 20             	mov    edx,DWORD PTR [ebp+0x20]
     1af:	89 50 20             	mov    DWORD PTR [eax+0x20],edx
		fb->cho_x = char_ofs_x;
     1b2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1b5:	8b 55 24             	mov    edx,DWORD PTR [ebp+0x24]
     1b8:	89 50 24             	mov    DWORD PTR [eax+0x24],edx
		fb->cho_y = char_ofs_y;
     1bb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1be:	8b 55 28             	mov    edx,DWORD PTR [ebp+0x28]
     1c1:	89 50 28             	mov    DWORD PTR [eax+0x28],edx
		fb->chw_x = char_width_x;
     1c4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1c7:	8b 55 2c             	mov    edx,DWORD PTR [ebp+0x2c]
     1ca:	89 50 2c             	mov    DWORD PTR [eax+0x2c],edx
		fb->chw_y = char_width_y;
     1cd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1d0:	8b 55 30             	mov    edx,DWORD PTR [ebp+0x30]
     1d3:	89 50 30             	mov    DWORD PTR [eax+0x30],edx
		fb->r_ud = NULL;
     1d6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1d9:	c7 40 34 00 00 00 00 	mov    DWORD PTR [eax+0x34],0x0
		fb->r_excl = NULL;
     1e0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1e3:	c7 40 38 00 00 00 00 	mov    DWORD PTR [eax+0x38],0x0
}
     1ea:	90                   	nop
     1eb:	5d                   	pop    ebp
     1ec:	c3                   	ret

000001ed <framebuffer_add_exclude_rect>:
{
     1ed:	55                   	push   ebp
     1ee:	89 e5                	mov    ebp,esp
     1f0:	53                   	push   ebx
		if (!r)
     1f1:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
     1f5:	74 2f                	je     226 <framebuffer_add_exclude_rect+0x39>
				r->next = fb->r_excl;
     1f7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1fa:	8b 50 38             	mov    edx,DWORD PTR [eax+0x38]
     1fd:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     200:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
		} while (!__sync_bool_compare_and_swap(&fb->r_excl, r->next, r));
     203:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     206:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     209:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     20c:	89 c3                	mov    ebx,eax
     20e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     211:	8d 48 38             	lea    ecx,[eax+0x38]
     214:	89 d8                	mov    eax,ebx
     216:	f0 0f b1 11          	lock cmpxchg DWORD PTR [ecx],edx
     21a:	0f 94 c0             	sete   al
     21d:	83 f0 01             	xor    eax,0x1
     220:	84 c0                	test   al,al
     222:	75 d3                	jne    1f7 <framebuffer_add_exclude_rect+0xa>
     224:	eb 01                	jmp    227 <framebuffer_add_exclude_rect+0x3a>
				return;
     226:	90                   	nop
}
     227:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     22a:	c9                   	leave
     22b:	c3                   	ret

0000022c <framebuffer_remove_exclude_rect>:
{
     22c:	55                   	push   ebp
     22d:	89 e5                	mov    ebp,esp
     22f:	83 ec 10             	sub    esp,0x10
		er = &fb->r_excl;
     232:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     235:	83 c0 38             	add    eax,0x38
     238:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		while ((r2 = *er)) {
     23b:	eb 2c                	jmp    269 <framebuffer_remove_exclude_rect+0x3d>
				if (r2 == r) {
     23d:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     240:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
     243:	75 1b                	jne    260 <framebuffer_remove_exclude_rect+0x34>
						if (__sync_bool_compare_and_swap(er, r, r->next))
     245:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     248:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     24b:	89 c1                	mov    ecx,eax
     24d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     250:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     253:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [edx],ecx
     257:	0f 94 c0             	sete   al
     25a:	84 c0                	test   al,al
     25c:	75 1b                	jne    279 <framebuffer_remove_exclude_rect+0x4d>
								goto Pos1;
     25e:	eb d2                	jmp    232 <framebuffer_remove_exclude_rect+0x6>
				er = &r2->next;
     260:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     263:	83 c0 10             	add    eax,0x10
     266:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		while ((r2 = *er)) {
     269:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     26c:	8b 00                	mov    eax,DWORD PTR [eax]
     26e:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
     271:	83 7d f8 00          	cmp    DWORD PTR [ebp-0x8],0x0
     275:	75 c6                	jne    23d <framebuffer_remove_exclude_rect+0x11>
     277:	eb 01                	jmp    27a <framebuffer_remove_exclude_rect+0x4e>
								return;
     279:	90                   	nop
}
     27a:	c9                   	leave
     27b:	c3                   	ret

0000027c <get_tm_color>:
{
     27c:	55                   	push   ebp
     27d:	89 e5                	mov    ebp,esp
     27f:	83 ec 18             	sub    esp,0x18
     282:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     285:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     288:	88 55 ec             	mov    BYTE PTR [ebp-0x14],dl
     28b:	88 45 e8             	mov    BYTE PTR [ebp-0x18],al
		switch (btpp) {
     28e:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     291:	83 e8 04             	sub    eax,0x4
     294:	83 f8 1c             	cmp    eax,0x1c
     297:	0f 87 10 01 00 00    	ja     3ad <get_tm_color+0x131>
     29d:	8b 04 85 20 00 00 00 	mov    eax,DWORD PTR [eax*4+0x20]
     2a4:	ff e0                	jmp    eax
						if (is_set)
     2a6:	80 7d e8 00          	cmp    BYTE PTR [ebp-0x18],0x0
     2aa:	74 0c                	je     2b8 <get_tm_color+0x3c>
								return col & 0x0f;
     2ac:	0f be 45 ec          	movsx  eax,BYTE PTR [ebp-0x14]
     2b0:	83 e0 0f             	and    eax,0xf
     2b3:	e9 fa 00 00 00       	jmp    3b2 <get_tm_color+0x136>
								return (col >> 4) & 0x0f;
     2b8:	0f b6 45 ec          	movzx  eax,BYTE PTR [ebp-0x14]
     2bc:	c0 f8 04             	sar    al,0x4
     2bf:	0f be c0             	movsx  eax,al
     2c2:	83 e0 0f             	and    eax,0xf
     2c5:	e9 e8 00 00 00       	jmp    3b2 <get_tm_color+0x136>
						if (is_set)
     2ca:	80 7d e8 00          	cmp    BYTE PTR [ebp-0x18],0x0
     2ce:	74 0c                	je     2dc <get_tm_color+0x60>
								return col & 0x0f;
     2d0:	0f be 45 ec          	movsx  eax,BYTE PTR [ebp-0x14]
     2d4:	83 e0 0f             	and    eax,0xf
     2d7:	e9 d6 00 00 00       	jmp    3b2 <get_tm_color+0x136>
								return (col >> 4) & 0x0f;
     2dc:	0f b6 45 ec          	movzx  eax,BYTE PTR [ebp-0x14]
     2e0:	c0 f8 04             	sar    al,0x4
     2e3:	0f be c0             	movsx  eax,al
     2e6:	83 e0 0f             	and    eax,0xf
     2e9:	e9 c4 00 00 00       	jmp    3b2 <get_tm_color+0x136>
						if (is_set)
     2ee:	80 7d e8 00          	cmp    BYTE PTR [ebp-0x18],0x0
     2f2:	74 13                	je     307 <get_tm_color+0x8b>
								iv = palette_32[col & 0x0f];
     2f4:	0f be 45 ec          	movsx  eax,BYTE PTR [ebp-0x14]
     2f8:	83 e0 0f             	and    eax,0xf
     2fb:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
     302:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
     305:	eb 17                	jmp    31e <get_tm_color+0xa2>
								iv = palette_32[(col >> 4) & 0x0f];
     307:	0f b6 45 ec          	movzx  eax,BYTE PTR [ebp-0x14]
     30b:	c0 f8 04             	sar    al,0x4
     30e:	0f be c0             	movsx  eax,al
     311:	83 e0 0f             	and    eax,0xf
     314:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
     31b:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
						if (btpp == 15)
     31e:	83 7d 10 0f          	cmp    DWORD PTR [ebp+0x10],0xf
     322:	75 2d                	jne    351 <get_tm_color+0xd5>
								rv = (iv.b >> 3) | ((iv.g >> 3) << 5) | ((iv.r >> 3) << 10);
     324:	0f b6 45 f8          	movzx  eax,BYTE PTR [ebp-0x8]
     328:	c0 e8 03             	shr    al,0x3
     32b:	0f b6 c0             	movzx  eax,al
     32e:	0f b6 55 f9          	movzx  edx,BYTE PTR [ebp-0x7]
     332:	c0 ea 03             	shr    dl,0x3
     335:	0f b6 d2             	movzx  edx,dl
     338:	c1 e2 05             	shl    edx,0x5
     33b:	09 c2                	or     edx,eax
     33d:	0f b6 45 fa          	movzx  eax,BYTE PTR [ebp-0x6]
     341:	c0 e8 03             	shr    al,0x3
     344:	0f b6 c0             	movzx  eax,al
     347:	c1 e0 0a             	shl    eax,0xa
     34a:	09 d0                	or     eax,edx
     34c:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
     34f:	eb 2b                	jmp    37c <get_tm_color+0x100>
								rv = (iv.b >> 3) | ((iv.g >> 2) << 5) | ((iv.r >> 3) << 11);
     351:	0f b6 45 f8          	movzx  eax,BYTE PTR [ebp-0x8]
     355:	c0 e8 03             	shr    al,0x3
     358:	0f b6 c0             	movzx  eax,al
     35b:	0f b6 55 f9          	movzx  edx,BYTE PTR [ebp-0x7]
     35f:	c0 ea 02             	shr    dl,0x2
     362:	0f b6 d2             	movzx  edx,dl
     365:	c1 e2 05             	shl    edx,0x5
     368:	09 c2                	or     edx,eax
     36a:	0f b6 45 fa          	movzx  eax,BYTE PTR [ebp-0x6]
     36e:	c0 e8 03             	shr    al,0x3
     371:	0f b6 c0             	movzx  eax,al
     374:	c1 e0 0b             	shl    eax,0xb
     377:	09 d0                	or     eax,edx
     379:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
						return rv;
     37c:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     37f:	eb 31                	jmp    3b2 <get_tm_color+0x136>
						if (is_set)
     381:	80 7d e8 00          	cmp    BYTE PTR [ebp-0x18],0x0
     385:	74 10                	je     397 <get_tm_color+0x11b>
								return palette_32[col & 0x0f].val;
     387:	0f be 45 ec          	movsx  eax,BYTE PTR [ebp-0x14]
     38b:	83 e0 0f             	and    eax,0xf
     38e:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
     395:	eb 1b                	jmp    3b2 <get_tm_color+0x136>
								return palette_32[(col >> 4) & 0x0f].val;
     397:	0f b6 45 ec          	movzx  eax,BYTE PTR [ebp-0x14]
     39b:	c0 f8 04             	sar    al,0x4
     39e:	0f be c0             	movsx  eax,al
     3a1:	83 e0 0f             	and    eax,0xf
     3a4:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
     3ab:	eb 05                	jmp    3b2 <get_tm_color+0x136>
		return 0x2f0c0c2f; /* canary */
     3ad:	b8 2f 0c 0c 2f       	mov    eax,0x2f0c0c2f
}
     3b2:	c9                   	leave
     3b3:	c3                   	ret

000003b4 <generate_char_colors>:
{
     3b4:	55                   	push   ebp
     3b5:	89 e5                	mov    ebp,esp
     3b7:	53                   	push   ebx
     3b8:	83 ec 34             	sub    esp,0x34
     3bb:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     3be:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     3c1:	88 55 e4             	mov    BYTE PTR [ebp-0x1c],dl
     3c4:	88 45 e0             	mov    BYTE PTR [ebp-0x20],al
		int rv = 0;
     3c7:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		uint8_t f = (uint8_t)font[c * 16];
     3ce:	0f be 45 e4          	movsx  eax,BYTE PTR [ebp-0x1c]
     3d2:	c1 e0 04             	shl    eax,0x4
     3d5:	89 c2                	mov    edx,eax
     3d7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3da:	01 d0                	add    eax,edx
     3dc:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     3df:	88 45 ef             	mov    BYTE PTR [ebp-0x11],al
		for (; r < rmax; r++) {
     3e2:	e9 00 01 00 00       	jmp    4e7 <generate_char_colors+0x133>
				int is_set = f & (1 << (7 - r));
     3e7:	0f b6 55 ef          	movzx  edx,BYTE PTR [ebp-0x11]
     3eb:	b8 07 00 00 00       	mov    eax,0x7
     3f0:	2b 45 18             	sub    eax,DWORD PTR [ebp+0x18]
     3f3:	bb 01 00 00 00       	mov    ebx,0x1
     3f8:	89 c1                	mov    ecx,eax
     3fa:	d3 e3                	shl    ebx,cl
     3fc:	89 d8                	mov    eax,ebx
     3fe:	21 d0                	and    eax,edx
     400:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				if (inv)
     403:	83 7d 24 00          	cmp    DWORD PTR [ebp+0x24],0x0
     407:	74 0d                	je     416 <generate_char_colors+0x62>
						is_set = !is_set;
     409:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     40d:	0f 94 c0             	sete   al
     410:	0f b6 c0             	movzx  eax,al
     413:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				cv = get_tm_color(fmt, is_set, btpp);
     416:	8b 4d 14             	mov    ecx,DWORD PTR [ebp+0x14]
     419:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     41c:	0f be d0             	movsx  edx,al
     41f:	0f be 45 e0          	movsx  eax,BYTE PTR [ebp-0x20]
     423:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
     427:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     42b:	89 04 24             	mov    DWORD PTR [esp],eax
     42e:	e8 fc ff ff ff       	call   42f <generate_char_colors+0x7b>
     433:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				switch (btpp) {
     436:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     439:	83 e8 04             	sub    eax,0x4
     43c:	83 f8 1c             	cmp    eax,0x1c
     43f:	0f 87 9e 00 00 00    	ja     4e3 <generate_char_colors+0x12f>
     445:	8b 04 85 a8 00 00 00 	mov    eax,DWORD PTR [eax*4+0xa8]
     44c:	ff e0                	jmp    eax
								*(uint32_t*)cvs = (uint32_t)cv;
     44e:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     451:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
     454:	89 10                	mov    DWORD PTR [eax],edx
								cvs += 4; rv += 32;
     456:	83 45 20 04          	add    DWORD PTR [ebp+0x20],0x4
     45a:	83 45 f4 20          	add    DWORD PTR [ebp-0xc],0x20
								break;
     45e:	e9 80 00 00 00       	jmp    4e3 <generate_char_colors+0x12f>
								*(uint16_t*)cvs = (uint16_t)(cv & 0xffff);
     463:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     466:	89 c2                	mov    edx,eax
     468:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     46b:	66 89 10             	mov    WORD PTR [eax],dx
								cvs += 2;
     46e:	83 45 20 02          	add    DWORD PTR [ebp+0x20],0x2
								*(uint8_t*)cvs++ = (uint8_t)(cv >> 16);
     472:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     475:	c1 e8 10             	shr    eax,0x10
     478:	89 c1                	mov    ecx,eax
     47a:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     47d:	8d 50 01             	lea    edx,[eax+0x1]
     480:	89 55 20             	mov    DWORD PTR [ebp+0x20],edx
     483:	89 ca                	mov    edx,ecx
     485:	88 10                	mov    BYTE PTR [eax],dl
								rv += 24;
     487:	83 45 f4 18          	add    DWORD PTR [ebp-0xc],0x18
								break;
     48b:	eb 56                	jmp    4e3 <generate_char_colors+0x12f>
								*(uint16_t*)cvs = (uint16_t)cv;
     48d:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     490:	89 c2                	mov    edx,eax
     492:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     495:	66 89 10             	mov    WORD PTR [eax],dx
								cvs += 2; rv += 16; /* even for 15 */
     498:	83 45 20 02          	add    DWORD PTR [ebp+0x20],0x2
     49c:	83 45 f4 10          	add    DWORD PTR [ebp-0xc],0x10
								break;
     4a0:	eb 41                	jmp    4e3 <generate_char_colors+0x12f>
								*cvs++ = (uint8_t)cv; rv += 8;
     4a2:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     4a5:	8d 50 01             	lea    edx,[eax+0x1]
     4a8:	89 55 20             	mov    DWORD PTR [ebp+0x20],edx
     4ab:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
     4ae:	88 10                	mov    BYTE PTR [eax],dl
     4b0:	83 45 f4 08          	add    DWORD PTR [ebp-0xc],0x8
								break;
     4b4:	eb 2d                	jmp    4e3 <generate_char_colors+0x12f>
								rv += 4;
     4b6:	83 45 f4 04          	add    DWORD PTR [ebp-0xc],0x4
								die("also complicated!\n");
     4ba:	c7 44 24 04 94 00 00 00 	mov    DWORD PTR [esp+0x4],0x94
     4c2:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
     4c9:	e8 fc ff ff ff       	call   4ca <generate_char_colors+0x116>
     4ce:	e8 fc ff ff ff       	call   4cf <generate_char_colors+0x11b>
     4d3:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     4da:	e8 fc ff ff ff       	call   4db <generate_char_colors+0x127>
     4df:	fa                   	cli
     4e0:	f4                   	hlt
     4e1:	eb fd                	jmp    4e0 <generate_char_colors+0x12c>
		for (; r < rmax; r++) {
     4e3:	83 45 18 01          	add    DWORD PTR [ebp+0x18],0x1
     4e7:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     4ea:	3b 45 1c             	cmp    eax,DWORD PTR [ebp+0x1c]
     4ed:	0f 8c f4 fe ff ff    	jl     3e7 <generate_char_colors+0x33>
		return rv;
     4f3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
     4f6:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     4f9:	c9                   	leave
     4fa:	c3                   	ret

000004fb <render_text_scanline_32btpp_sse>:
{
     4fb:	55                   	push   ebp
     4fc:	89 e5                	mov    ebp,esp
     4fe:	56                   	push   esi
     4ff:	53                   	push   ebx
     500:	83 c4 80             	add    esp,0xffffff80
		ssize_t misalign = ((size_t)mem % 16) ? (16 - (size_t)mem % 16) : 0;
     503:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     506:	83 e0 0f             	and    eax,0xf
     509:	85 c0                	test   eax,eax
     50b:	74 11                	je     51e <render_text_scanline_32btpp_sse+0x23>
     50d:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     510:	83 e0 0f             	and    eax,0xf
     513:	ba 10 00 00 00       	mov    edx,0x10
     518:	29 c2                	sub    edx,eax
     51a:	89 d0                	mov    eax,edx
     51c:	eb 05                	jmp    523 <render_text_scanline_32btpp_sse+0x28>
     51e:	b8 00 00 00 00       	mov    eax,0x0
     523:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		ssize_t r = p0_x % 8;
     526:	8b 55 1c             	mov    edx,DWORD PTR [ebp+0x1c]
     529:	89 d0                	mov    eax,edx
     52b:	c1 f8 1f             	sar    eax,0x1f
     52e:	c1 e8 1d             	shr    eax,0x1d
     531:	01 c2                	add    edx,eax
     533:	83 e2 07             	and    edx,0x7
     536:	29 c2                	sub    edx,eax
     538:	89 55 e8             	mov    DWORD PTR [ebp-0x18],edx
		uint8_t* pixbuf = pxb + (((size_t)pxb % 16) ? (16 - ((size_t)pxb % 16)) : 0);
     53b:	8d 45 9d             	lea    eax,[ebp-0x63]
     53e:	83 e0 0f             	and    eax,0xf
     541:	85 c0                	test   eax,eax
     543:	74 11                	je     556 <render_text_scanline_32btpp_sse+0x5b>
     545:	8d 45 9d             	lea    eax,[ebp-0x63]
     548:	83 e0 0f             	and    eax,0xf
     54b:	89 c2                	mov    edx,eax
     54d:	b8 10 00 00 00       	mov    eax,0x10
     552:	29 d0                	sub    eax,edx
     554:	eb 05                	jmp    55b <render_text_scanline_32btpp_sse+0x60>
     556:	b8 00 00 00 00       	mov    eax,0x0
     55b:	8d 55 9d             	lea    edx,[ebp-0x63]
     55e:	01 d0                	add    eax,edx
     560:	89 45 98             	mov    DWORD PTR [ebp-0x68],eax
		if (misalign) { /* LFB is dword aligned, we want (dq/o)word access */
     563:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     567:	0f 84 8d 03 00 00    	je     8fa <render_text_scanline_32btpp_sse+0x3ff>
				int col = p0_x / 8, inv = (col == cur_x);
     56d:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     570:	8d 50 07             	lea    edx,[eax+0x7]
     573:	85 c0                	test   eax,eax
     575:	0f 48 c2             	cmovs  eax,edx
     578:	c1 f8 03             	sar    eax,0x3
     57b:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
     57e:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     581:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
     584:	0f 94 c0             	sete   al
     587:	0f b6 c0             	movzx  eax,al
     58a:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
				ssize_t bc = min(misalign, 4 * px_x);
     58d:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     590:	c1 e0 02             	shl    eax,0x2
     593:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     596:	39 c2                	cmp    edx,eax
     598:	0f 4e c2             	cmovle eax,edx
     59b:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
				ssize_t cc = rdiv(misalign, 4);
     59e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     5a1:	8d 50 03             	lea    edx,[eax+0x3]
     5a4:	85 c0                	test   eax,eax
     5a6:	0f 48 c2             	cmovs  eax,edx
     5a9:	c1 f8 02             	sar    eax,0x2
     5ac:	89 c2                	mov    edx,eax
     5ae:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     5b1:	83 e0 03             	and    eax,0x3
     5b4:	85 c0                	test   eax,eax
     5b6:	0f 95 c0             	setne  al
     5b9:	0f b6 c0             	movzx  eax,al
     5bc:	01 d0                	add    eax,edx
     5be:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
				ssize_t rmax = min(8, r + cc), cc1 = rmax - r;
     5c1:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
     5c4:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     5c7:	01 d0                	add    eax,edx
     5c9:	ba 08 00 00 00       	mov    edx,0x8
     5ce:	39 d0                	cmp    eax,edx
     5d0:	0f 4f c2             	cmovg  eax,edx
     5d3:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
     5d6:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     5d9:	2b 45 e8             	sub    eax,DWORD PTR [ebp-0x18]
     5dc:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
				generate_char_colors(font, str[0], str[1], 32,
     5df:	8b 4d 98             	mov    ecx,DWORD PTR [ebp-0x68]
     5e2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     5e5:	83 c0 01             	add    eax,0x1
     5e8:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     5eb:	0f be d0             	movsx  edx,al
     5ee:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     5f1:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     5f4:	0f be c0             	movsx  eax,al
     5f7:	8b 5d e0             	mov    ebx,DWORD PTR [ebp-0x20]
     5fa:	89 5c 24 1c          	mov    DWORD PTR [esp+0x1c],ebx
     5fe:	89 4c 24 18          	mov    DWORD PTR [esp+0x18],ecx
     602:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
     605:	89 4c 24 14          	mov    DWORD PTR [esp+0x14],ecx
     609:	8b 4d e8             	mov    ecx,DWORD PTR [ebp-0x18]
     60c:	89 4c 24 10          	mov    DWORD PTR [esp+0x10],ecx
     610:	c7 44 24 0c 20 00 00 00 	mov    DWORD PTR [esp+0xc],0x20
     618:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     61c:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     620:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     623:	89 04 24             	mov    DWORD PTR [esp],eax
     626:	e8 fc ff ff ff       	call   627 <render_text_scanline_32btpp_sse+0x12c>
				if (rmax == 8)
     62b:	83 7d d4 08          	cmp    DWORD PTR [ebp-0x2c],0x8
     62f:	75 04                	jne    635 <render_text_scanline_32btpp_sse+0x13a>
						str += 2;
     631:	83 45 0c 02          	add    DWORD PTR [ebp+0xc],0x2
				if (cc > cc1) { /* generate the new char */
     635:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     638:	3b 45 d0             	cmp    eax,DWORD PTR [ebp-0x30]
     63b:	7e 6e                	jle    6ab <render_text_scanline_32btpp_sse+0x1b0>
						col++; inv = (col == cur_x);
     63d:	83 45 e4 01          	add    DWORD PTR [ebp-0x1c],0x1
     641:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     644:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
     647:	0f 94 c0             	sete   al
     64a:	0f b6 c0             	movzx  eax,al
     64d:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
						generate_char_colors(font, str[0], str[1], 32,
     650:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
										0, cc - cc1, pixbuf + cc1 * 4, inv);
     653:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
     656:	c1 e2 02             	shl    edx,0x2
						generate_char_colors(font, str[0], str[1], 32,
     659:	8d 34 10             	lea    esi,[eax+edx*1]
     65c:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     65f:	2b 45 d0             	sub    eax,DWORD PTR [ebp-0x30]
     662:	89 c1                	mov    ecx,eax
     664:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     667:	83 c0 01             	add    eax,0x1
     66a:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     66d:	0f be d0             	movsx  edx,al
     670:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     673:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     676:	0f be c0             	movsx  eax,al
     679:	8b 5d e0             	mov    ebx,DWORD PTR [ebp-0x20]
     67c:	89 5c 24 1c          	mov    DWORD PTR [esp+0x1c],ebx
     680:	89 74 24 18          	mov    DWORD PTR [esp+0x18],esi
     684:	89 4c 24 14          	mov    DWORD PTR [esp+0x14],ecx
     688:	c7 44 24 10 00 00 00 00 	mov    DWORD PTR [esp+0x10],0x0
     690:	c7 44 24 0c 20 00 00 00 	mov    DWORD PTR [esp+0xc],0x20
     698:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     69c:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     6a0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     6a3:	89 04 24             	mov    DWORD PTR [esp],eax
     6a6:	e8 fc ff ff ff       	call   6a7 <render_text_scanline_32btpp_sse+0x1ac>
				memcpy(mem, pixbuf, bc);
     6ab:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
     6ae:	8b 55 98             	mov    edx,DWORD PTR [ebp-0x68]
     6b1:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     6b4:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
     6b8:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     6bc:	89 04 24             	mov    DWORD PTR [esp],eax
     6bf:	e8 3c f9 ff ff       	call   0 <memcpy>
				px_x -= cc;
     6c4:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     6c7:	29 45 14             	sub    DWORD PTR [ebp+0x14],eax
				p0_x += cc;
     6ca:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     6cd:	01 45 1c             	add    DWORD PTR [ebp+0x1c],eax
				mem += bc;
     6d0:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     6d3:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     6d6:	01 d0                	add    eax,edx
     6d8:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
		while (px_x) {
     6db:	e9 1a 02 00 00       	jmp    8fa <render_text_scanline_32btpp_sse+0x3ff>
				int col = p0_x / 8, inv = (col == cur_x);
     6e0:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     6e3:	8d 50 07             	lea    edx,[eax+0x7]
     6e6:	85 c0                	test   eax,eax
     6e8:	0f 48 c2             	cmovs  eax,edx
     6eb:	c1 f8 03             	sar    eax,0x3
     6ee:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
     6f1:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     6f4:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
     6f7:	0f 94 c0             	sete   al
     6fa:	0f b6 c0             	movzx  eax,al
     6fd:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
				ssize_t rmax, bitc, btt = min(128, 32 * px_x);
     700:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     703:	c1 e0 05             	shl    eax,0x5
     706:	ba 80 00 00 00       	mov    edx,0x80
     70b:	39 d0                	cmp    eax,edx
     70d:	0f 4f c2             	cmovg  eax,edx
     710:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
				r = p0_x % 8;
     713:	8b 55 1c             	mov    edx,DWORD PTR [ebp+0x1c]
     716:	89 d0                	mov    eax,edx
     718:	c1 f8 1f             	sar    eax,0x1f
     71b:	c1 e8 1d             	shr    eax,0x1d
     71e:	01 c2                	add    edx,eax
     720:	83 e2 07             	and    edx,0x7
     723:	29 c2                	sub    edx,eax
     725:	89 55 e8             	mov    DWORD PTR [ebp-0x18],edx
				rmax = min(8, r + min(4, px_x)); /* only 4 pixels */
     728:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     72b:	ba 04 00 00 00       	mov    edx,0x4
     730:	39 d0                	cmp    eax,edx
     732:	0f 4e d0             	cmovle edx,eax
     735:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     738:	01 d0                	add    eax,edx
     73a:	ba 08 00 00 00       	mov    edx,0x8
     73f:	39 d0                	cmp    eax,edx
     741:	0f 4f c2             	cmovg  eax,edx
     744:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
				bitc = generate_char_colors(font, str[0], str[1], 32,
     747:	8b 4d 98             	mov    ecx,DWORD PTR [ebp-0x68]
     74a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     74d:	83 c0 01             	add    eax,0x1
     750:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     753:	0f be d0             	movsx  edx,al
     756:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     759:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     75c:	0f be c0             	movsx  eax,al
     75f:	8b 5d c8             	mov    ebx,DWORD PTR [ebp-0x38]
     762:	89 5c 24 1c          	mov    DWORD PTR [esp+0x1c],ebx
     766:	89 4c 24 18          	mov    DWORD PTR [esp+0x18],ecx
     76a:	8b 4d c0             	mov    ecx,DWORD PTR [ebp-0x40]
     76d:	89 4c 24 14          	mov    DWORD PTR [esp+0x14],ecx
     771:	8b 4d e8             	mov    ecx,DWORD PTR [ebp-0x18]
     774:	89 4c 24 10          	mov    DWORD PTR [esp+0x10],ecx
     778:	c7 44 24 0c 20 00 00 00 	mov    DWORD PTR [esp+0xc],0x20
     780:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     784:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     788:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     78b:	89 04 24             	mov    DWORD PTR [esp],eax
     78e:	e8 fc ff ff ff       	call   78f <render_text_scanline_32btpp_sse+0x294>
     793:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				if (rmax == 8)
     796:	83 7d c0 08          	cmp    DWORD PTR [ebp-0x40],0x8
     79a:	75 04                	jne    7a0 <render_text_scanline_32btpp_sse+0x2a5>
						str += 2;
     79c:	83 45 0c 02          	add    DWORD PTR [ebp+0xc],0x2
				if (bitc < btt) {
     7a0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     7a3:	3b 45 c4             	cmp    eax,DWORD PTR [ebp-0x3c]
     7a6:	0f 8d 88 00 00 00    	jge    834 <render_text_scanline_32btpp_sse+0x339>
						col++; int pc = (btt - bitc) / 32;
     7ac:	83 45 cc 01          	add    DWORD PTR [ebp-0x34],0x1
     7b0:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
     7b3:	2b 45 f4             	sub    eax,DWORD PTR [ebp-0xc]
     7b6:	8d 50 1f             	lea    edx,[eax+0x1f]
     7b9:	85 c0                	test   eax,eax
     7bb:	0f 48 c2             	cmovs  eax,edx
     7be:	c1 f8 05             	sar    eax,0x5
     7c1:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
						inv = (col == cur_x);
     7c4:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     7c7:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
     7ca:	0f 94 c0             	sete   al
     7cd:	0f b6 c0             	movzx  eax,al
     7d0:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
						bitc += generate_char_colors(font, str[0], str[1], 32,
     7d3:	8b 55 98             	mov    edx,DWORD PTR [ebp-0x68]
										0, pc, pixbuf + bitc / 32, inv);
     7d6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     7d9:	8d 48 1f             	lea    ecx,[eax+0x1f]
     7dc:	85 c0                	test   eax,eax
     7de:	0f 48 c1             	cmovs  eax,ecx
     7e1:	c1 f8 05             	sar    eax,0x5
						bitc += generate_char_colors(font, str[0], str[1], 32,
     7e4:	8d 1c 02             	lea    ebx,[edx+eax*1]
     7e7:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     7ea:	83 c0 01             	add    eax,0x1
     7ed:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     7f0:	0f be d0             	movsx  edx,al
     7f3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     7f6:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     7f9:	0f be c0             	movsx  eax,al
     7fc:	8b 4d c8             	mov    ecx,DWORD PTR [ebp-0x38]
     7ff:	89 4c 24 1c          	mov    DWORD PTR [esp+0x1c],ecx
     803:	89 5c 24 18          	mov    DWORD PTR [esp+0x18],ebx
     807:	8b 4d bc             	mov    ecx,DWORD PTR [ebp-0x44]
     80a:	89 4c 24 14          	mov    DWORD PTR [esp+0x14],ecx
     80e:	c7 44 24 10 00 00 00 00 	mov    DWORD PTR [esp+0x10],0x0
     816:	c7 44 24 0c 20 00 00 00 	mov    DWORD PTR [esp+0xc],0x20
     81e:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     822:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     826:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     829:	89 04 24             	mov    DWORD PTR [esp],eax
     82c:	e8 fc ff ff ff       	call   82d <render_text_scanline_32btpp_sse+0x332>
     831:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
				if (bitc >= 128) {
     834:	83 7d f4 7f          	cmp    DWORD PTR [ebp-0xc],0x7f
     838:	7e 21                	jle    85b <render_text_scanline_32btpp_sse+0x360>
						move_128(pixbuf, mem);
     83a:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
     83d:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     840:	0f 28 00             	movaps xmm0,XMMWORD PTR [eax]
     843:	0f 29 02             	movaps XMMWORD PTR [edx],xmm0
						mem += 16; /* intentionally no bitc subtract */
     846:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     849:	83 c0 10             	add    eax,0x10
     84c:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
				if (px_x) {
     84f:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     853:	0f 84 ad 00 00 00    	je     906 <render_text_scanline_32btpp_sse+0x40b>
     859:	eb 7b                	jmp    8d6 <render_text_scanline_32btpp_sse+0x3db>
						uint8_t* pt = pixbuf;
     85b:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
     85e:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
						if (bitc >= 64) {
     861:	83 7d f4 3f          	cmp    DWORD PTR [ebp-0xc],0x3f
     865:	7e 1d                	jle    884 <render_text_scanline_32btpp_sse+0x389>
								move_64(pixbuf, mem);
     867:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
     86a:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     86d:	0f 6f 00             	movq   mm0,QWORD PTR [eax]
     870:	0f 7f 02             	movq   QWORD PTR [edx],mm0
								pt += 8;
     873:	83 45 f0 08          	add    DWORD PTR [ebp-0x10],0x8
								mem += 8;
     877:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     87a:	83 c0 08             	add    eax,0x8
     87d:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
								bitc -= 64;
     880:	83 6d f4 40          	sub    DWORD PTR [ebp-0xc],0x40
						if (bitc >= 32) {
     884:	83 7d f4 1f          	cmp    DWORD PTR [ebp-0xc],0x1f
     888:	7e 1d                	jle    8a7 <render_text_scanline_32btpp_sse+0x3ac>
								*(uint32_t*)mem = *(uint32_t*)pt;
     88a:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     88d:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     890:	8b 12                	mov    edx,DWORD PTR [edx]
     892:	89 10                	mov    DWORD PTR [eax],edx
								pt += 4;
     894:	83 45 f0 04          	add    DWORD PTR [ebp-0x10],0x4
								mem += 4;
     898:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     89b:	83 c0 04             	add    eax,0x4
     89e:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
								bitc -= 32;
     8a1:	83 6d f4 20          	sub    DWORD PTR [ebp-0xc],0x20
						break;
     8a5:	eb 62                	jmp    909 <render_text_scanline_32btpp_sse+0x40e>
						} else if (bitc) {
     8a7:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     8ab:	74 5c                	je     909 <render_text_scanline_32btpp_sse+0x40e>
								die("cant happen with dword sized pixels!\n");
     8ad:	c7 44 24 04 1c 01 00 00 	mov    DWORD PTR [esp+0x4],0x11c
     8b5:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
     8bc:	e8 fc ff ff ff       	call   8bd <render_text_scanline_32btpp_sse+0x3c2>
     8c1:	e8 fc ff ff ff       	call   8c2 <render_text_scanline_32btpp_sse+0x3c7>
     8c6:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     8cd:	e8 fc ff ff ff       	call   8ce <render_text_scanline_32btpp_sse+0x3d3>
     8d2:	fa                   	cli
     8d3:	f4                   	hlt
     8d4:	eb fd                	jmp    8d3 <render_text_scanline_32btpp_sse+0x3d8>
						px_x -= bitc / 32;
     8d6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     8d9:	8d 50 1f             	lea    edx,[eax+0x1f]
     8dc:	85 c0                	test   eax,eax
     8de:	0f 48 c2             	cmovs  eax,edx
     8e1:	c1 f8 05             	sar    eax,0x5
     8e4:	f7 d8                	neg    eax
     8e6:	01 45 14             	add    DWORD PTR [ebp+0x14],eax
						p0_x += bitc / 32; /* unneccessary as r does not change anymore */
     8e9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     8ec:	8d 50 1f             	lea    edx,[eax+0x1f]
     8ef:	85 c0                	test   eax,eax
     8f1:	0f 48 c2             	cmovs  eax,edx
     8f4:	c1 f8 05             	sar    eax,0x5
     8f7:	01 45 1c             	add    DWORD PTR [ebp+0x1c],eax
		while (px_x) {
     8fa:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     8fe:	0f 85 dc fd ff ff    	jne    6e0 <render_text_scanline_32btpp_sse+0x1e5>
}
     904:	eb 04                	jmp    90a <render_text_scanline_32btpp_sse+0x40f>
						break;
     906:	90                   	nop
     907:	eb 01                	jmp    90a <render_text_scanline_32btpp_sse+0x40f>
						break;
     909:	90                   	nop
}
     90a:	90                   	nop
     90b:	83 ec 80             	sub    esp,0xffffff80
     90e:	5b                   	pop    ebx
     90f:	5e                   	pop    esi
     910:	5d                   	pop    ebp
     911:	c3                   	ret

00000912 <render_text_scanline_24btpp_sse>:

/* we're generating 3byte colorvalues /w unknown alignment. To enable
 * 16 byte transfers, 6 pixels /w 18 bytes have to be generated. */
void render_text_scanline_24btpp_sse(const char* font, char* str, void* mem,
				ssize_t px_x, ssize_t cur_x, ssize_t p0_x)
{
     912:	55                   	push   ebp
     913:	89 e5                	mov    ebp,esp
     915:	56                   	push   esi
     916:	53                   	push   ebx
     917:	81 ec 90 00 00 00    	sub    esp,0x90
		uint8_t pxb[18 + 2 + 15]; /* 15 for stack alignment, 2 for bt_ofs */
		ssize_t misalign = ((size_t)mem % 16) ? (16 - (size_t)mem % 16) : 0;
     91d:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     920:	83 e0 0f             	and    eax,0xf
     923:	85 c0                	test   eax,eax
     925:	74 11                	je     938 <render_text_scanline_24btpp_sse+0x26>
     927:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     92a:	83 e0 0f             	and    eax,0xf
     92d:	ba 10 00 00 00       	mov    edx,0x10
     932:	29 c2                	sub    edx,eax
     934:	89 d0                	mov    eax,edx
     936:	eb 05                	jmp    93d <render_text_scanline_24btpp_sse+0x2b>
     938:	b8 00 00 00 00       	mov    eax,0x0
     93d:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		ssize_t r = p0_x % 8;
     940:	8b 55 1c             	mov    edx,DWORD PTR [ebp+0x1c]
     943:	89 d0                	mov    eax,edx
     945:	c1 f8 1f             	sar    eax,0x1f
     948:	c1 e8 1d             	shr    eax,0x1d
     94b:	01 c2                	add    edx,eax
     94d:	83 e2 07             	and    edx,0x7
     950:	29 c2                	sub    edx,eax
     952:	89 55 e0             	mov    DWORD PTR [ebp-0x20],edx
		uint8_t* pixbuf = pxb + (((size_t)pxb % 16) ? (16 - ((size_t)pxb % 16)) : 0);
     955:	8d 45 91             	lea    eax,[ebp-0x6f]
     958:	83 e0 0f             	and    eax,0xf
     95b:	85 c0                	test   eax,eax
     95d:	74 11                	je     970 <render_text_scanline_24btpp_sse+0x5e>
     95f:	8d 45 91             	lea    eax,[ebp-0x6f]
     962:	83 e0 0f             	and    eax,0xf
     965:	89 c2                	mov    edx,eax
     967:	b8 10 00 00 00       	mov    eax,0x10
     96c:	29 d0                	sub    eax,edx
     96e:	eb 05                	jmp    975 <render_text_scanline_24btpp_sse+0x63>
     970:	b8 00 00 00 00       	mov    eax,0x0
     975:	8d 55 91             	lea    edx,[ebp-0x6f]
     978:	01 d0                	add    eax,edx
     97a:	89 45 8c             	mov    DWORD PTR [ebp-0x74],eax
		ssize_t bt_ofs = 0; /* used to control writing into pixbuf (1/3 pixels)*/
     97d:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		/* 64-bit aligned moves are enough */

		if (misalign) { /* LFB is dword aligned, we want (dq/o)word access */
     984:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
     988:	0f 84 83 04 00 00    	je     e11 <render_text_scanline_24btpp_sse+0x4ff>
				int col = p0_x / 8, inv = (col == cur_x);
     98e:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     991:	8d 50 07             	lea    edx,[eax+0x7]
     994:	85 c0                	test   eax,eax
     996:	0f 48 c2             	cmovs  eax,edx
     999:	c1 f8 03             	sar    eax,0x3
     99c:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
     99f:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     9a2:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
     9a5:	0f 94 c0             	sete   al
     9a8:	0f b6 c0             	movzx  eax,al
     9ab:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
				ssize_t bc = min(misalign, 3 * px_x);
     9ae:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
     9b1:	89 d0                	mov    eax,edx
     9b3:	01 c0                	add    eax,eax
     9b5:	01 d0                	add    eax,edx
     9b7:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
     9ba:	39 c2                	cmp    edx,eax
     9bc:	0f 4e c2             	cmovle eax,edx
     9bf:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				ssize_t cc = rdiv(bc, 3);
     9c2:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
     9c5:	ba 56 55 55 55       	mov    edx,0x55555556
     9ca:	89 c8                	mov    eax,ecx
     9cc:	f7 ea                	imul   edx
     9ce:	89 c8                	mov    eax,ecx
     9d0:	c1 f8 1f             	sar    eax,0x1f
     9d3:	89 d3                	mov    ebx,edx
     9d5:	29 c3                	sub    ebx,eax
     9d7:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
     9da:	ba 56 55 55 55       	mov    edx,0x55555556
     9df:	89 c8                	mov    eax,ecx
     9e1:	f7 ea                	imul   edx
     9e3:	89 c8                	mov    eax,ecx
     9e5:	c1 f8 1f             	sar    eax,0x1f
     9e8:	29 c2                	sub    edx,eax
     9ea:	89 d0                	mov    eax,edx
     9ec:	01 c0                	add    eax,eax
     9ee:	01 d0                	add    eax,edx
     9f0:	29 c1                	sub    ecx,eax
     9f2:	89 ca                	mov    edx,ecx
     9f4:	85 d2                	test   edx,edx
     9f6:	0f 95 c0             	setne  al
     9f9:	0f b6 c0             	movzx  eax,al
     9fc:	01 d8                	add    eax,ebx
     9fe:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
				ssize_t rmax = min(8, r + cc), cc1 = rmax - r;
     a01:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
     a04:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     a07:	01 d0                	add    eax,edx
     a09:	ba 08 00 00 00       	mov    edx,0x8
     a0e:	39 d0                	cmp    eax,edx
     a10:	0f 4f c2             	cmovg  eax,edx
     a13:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
     a16:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     a19:	2b 45 e0             	sub    eax,DWORD PTR [ebp-0x20]
     a1c:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax

				generate_char_colors(font, str[0], str[1], 24,
     a1f:	8b 4d 8c             	mov    ecx,DWORD PTR [ebp-0x74]
     a22:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a25:	83 c0 01             	add    eax,0x1
     a28:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     a2b:	0f be d0             	movsx  edx,al
     a2e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     a31:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     a34:	0f be c0             	movsx  eax,al
     a37:	8b 5d d8             	mov    ebx,DWORD PTR [ebp-0x28]
     a3a:	89 5c 24 1c          	mov    DWORD PTR [esp+0x1c],ebx
     a3e:	89 4c 24 18          	mov    DWORD PTR [esp+0x18],ecx
     a42:	8b 4d cc             	mov    ecx,DWORD PTR [ebp-0x34]
     a45:	89 4c 24 14          	mov    DWORD PTR [esp+0x14],ecx
     a49:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
     a4c:	89 4c 24 10          	mov    DWORD PTR [esp+0x10],ecx
     a50:	c7 44 24 0c 18 00 00 00 	mov    DWORD PTR [esp+0xc],0x18
     a58:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     a5c:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     a60:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a63:	89 04 24             	mov    DWORD PTR [esp],eax
     a66:	e8 fc ff ff ff       	call   a67 <render_text_scanline_24btpp_sse+0x155>
								r, rmax, pixbuf, inv);
				if (rmax == 8)
     a6b:	83 7d cc 08          	cmp    DWORD PTR [ebp-0x34],0x8
     a6f:	75 04                	jne    a75 <render_text_scanline_24btpp_sse+0x163>
						str += 2;
     a71:	83 45 0c 02          	add    DWORD PTR [ebp+0xc],0x2
				if (cc > cc1) { /* generate the new char */
     a75:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     a78:	3b 45 c8             	cmp    eax,DWORD PTR [ebp-0x38]
     a7b:	7e 71                	jle    aee <render_text_scanline_24btpp_sse+0x1dc>
						col++; inv = (col == cur_x);
     a7d:	83 45 dc 01          	add    DWORD PTR [ebp-0x24],0x1
     a81:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     a84:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
     a87:	0f 94 c0             	sete   al
     a8a:	0f b6 c0             	movzx  eax,al
     a8d:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
						generate_char_colors(font, str[0], str[1], 24,
     a90:	8b 4d 8c             	mov    ecx,DWORD PTR [ebp-0x74]
										0, cc - cc1, pixbuf + cc1 * 3, inv);
     a93:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
     a96:	89 d0                	mov    eax,edx
     a98:	01 c0                	add    eax,eax
     a9a:	01 d0                	add    eax,edx
						generate_char_colors(font, str[0], str[1], 24,
     a9c:	8d 34 01             	lea    esi,[ecx+eax*1]
     a9f:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     aa2:	2b 45 c8             	sub    eax,DWORD PTR [ebp-0x38]
     aa5:	89 c1                	mov    ecx,eax
     aa7:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     aaa:	83 c0 01             	add    eax,0x1
     aad:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     ab0:	0f be d0             	movsx  edx,al
     ab3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     ab6:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     ab9:	0f be c0             	movsx  eax,al
     abc:	8b 5d d8             	mov    ebx,DWORD PTR [ebp-0x28]
     abf:	89 5c 24 1c          	mov    DWORD PTR [esp+0x1c],ebx
     ac3:	89 74 24 18          	mov    DWORD PTR [esp+0x18],esi
     ac7:	89 4c 24 14          	mov    DWORD PTR [esp+0x14],ecx
     acb:	c7 44 24 10 00 00 00 00 	mov    DWORD PTR [esp+0x10],0x0
     ad3:	c7 44 24 0c 18 00 00 00 	mov    DWORD PTR [esp+0xc],0x18
     adb:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     adf:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     ae3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     ae6:	89 04 24             	mov    DWORD PTR [esp],eax
     ae9:	e8 fc ff ff ff       	call   aea <render_text_scanline_24btpp_sse+0x1d8>
				}
				memcpy(mem, pixbuf, bc);
     aee:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
     af1:	8b 55 8c             	mov    edx,DWORD PTR [ebp-0x74]
     af4:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     af7:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
     afb:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     aff:	89 04 24             	mov    DWORD PTR [esp],eax
     b02:	e8 f9 f4 ff ff       	call   0 <memcpy>
				/* now indicate the remaining pixel part if there and
				 * copy the data to the front for the later transfer */
				if (bc % 3) {
     b07:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
     b0a:	ba 56 55 55 55       	mov    edx,0x55555556
     b0f:	89 c8                	mov    eax,ecx
     b11:	f7 ea                	imul   edx
     b13:	89 c8                	mov    eax,ecx
     b15:	c1 f8 1f             	sar    eax,0x1f
     b18:	29 c2                	sub    edx,eax
     b1a:	89 d0                	mov    eax,edx
     b1c:	01 c0                	add    eax,eax
     b1e:	01 d0                	add    eax,edx
     b20:	29 c1                	sub    ecx,eax
     b22:	89 ca                	mov    edx,ecx
     b24:	85 d2                	test   edx,edx
     b26:	74 2d                	je     b55 <render_text_scanline_24btpp_sse+0x243>
						bt_ofs = 3 * cc - bc;
     b28:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
     b2b:	89 d0                	mov    eax,edx
     b2d:	01 c0                	add    eax,eax
     b2f:	01 d0                	add    eax,edx
     b31:	2b 45 d4             	sub    eax,DWORD PTR [ebp-0x2c]
     b34:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						memcpy(pixbuf, pixbuf + bc, bt_ofs);
     b37:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     b3a:	8b 4d 8c             	mov    ecx,DWORD PTR [ebp-0x74]
     b3d:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     b40:	01 c1                	add    ecx,eax
     b42:	8b 45 8c             	mov    eax,DWORD PTR [ebp-0x74]
     b45:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     b49:	89 4c 24 04          	mov    DWORD PTR [esp+0x4],ecx
     b4d:	89 04 24             	mov    DWORD PTR [esp],eax
     b50:	e8 ab f4 ff ff       	call   0 <memcpy>
						/* no bt_ofs pixels from this pixel are left in pixbuf */
				}
				px_x -= cc;
     b55:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     b58:	29 45 14             	sub    DWORD PTR [ebp+0x14],eax
				p0_x += cc;
     b5b:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     b5e:	01 45 1c             	add    DWORD PTR [ebp+0x1c],eax
				mem += misalign; /* safer than bc */
     b61:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     b64:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     b67:	01 d0                	add    eax,edx
     b69:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
		}

		/* draw 5 2/3 pixels each (6,5,5) */
		while (px_x) { /* 144 bit vs. 128 16bt remain (2/3) */
     b6c:	e9 a0 02 00 00       	jmp    e11 <render_text_scanline_24btpp_sse+0x4ff>
				int col = p0_x / 8, inv = (col == cur_x);
     b71:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     b74:	8d 50 07             	lea    edx,[eax+0x7]
     b77:	85 c0                	test   eax,eax
     b79:	0f 48 c2             	cmovs  eax,edx
     b7c:	c1 f8 03             	sar    eax,0x3
     b7f:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
     b82:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
     b85:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
     b88:	0f 94 c0             	sete   al
     b8b:	0f b6 c0             	movzx  eax,al
     b8e:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
				ssize_t cc = min(bt_ofs ? 5 : 6, px_x), cc1; /* 655 */
     b91:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     b95:	74 07                	je     b9e <render_text_scanline_24btpp_sse+0x28c>
     b97:	b8 05 00 00 00       	mov    eax,0x5
     b9c:	eb 05                	jmp    ba3 <render_text_scanline_24btpp_sse+0x291>
     b9e:	b8 06 00 00 00       	mov    eax,0x6
     ba3:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
     ba6:	39 d0                	cmp    eax,edx
     ba8:	0f 4f c2             	cmovg  eax,edx
     bab:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
				ssize_t rmax, bitc, btt = min(128, 24 * px_x + 8 * bt_ofs);
     bae:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
     bb1:	89 d0                	mov    eax,edx
     bb3:	01 c0                	add    eax,eax
     bb5:	01 c2                	add    edx,eax
     bb7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     bba:	01 d0                	add    eax,edx
     bbc:	c1 e0 03             	shl    eax,0x3
     bbf:	ba 80 00 00 00       	mov    edx,0x80
     bc4:	39 d0                	cmp    eax,edx
     bc6:	0f 4f c2             	cmovg  eax,edx
     bc9:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				r = p0_x % 8;
     bcc:	8b 55 1c             	mov    edx,DWORD PTR [ebp+0x1c]
     bcf:	89 d0                	mov    eax,edx
     bd1:	c1 f8 1f             	sar    eax,0x1f
     bd4:	c1 e8 1d             	shr    eax,0x1d
     bd7:	01 c2                	add    edx,eax
     bd9:	83 e2 07             	and    edx,0x7
     bdc:	29 c2                	sub    edx,eax
     bde:	89 55 e0             	mov    DWORD PTR [ebp-0x20],edx
				rmax = min(8, r + cc); /* only up to 6 pixels */
     be1:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
     be4:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
     be7:	01 d0                	add    eax,edx
     be9:	ba 08 00 00 00       	mov    edx,0x8
     bee:	39 d0                	cmp    eax,edx
     bf0:	0f 4f c2             	cmovg  eax,edx
     bf3:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
				/* get the remaining character pixels */
				bitc = generate_char_colors(font, str[0], str[1], 24,
     bf6:	8b 55 8c             	mov    edx,DWORD PTR [ebp-0x74]
     bf9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     bfc:	8d 1c 02             	lea    ebx,[edx+eax*1]
     bff:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     c02:	83 c0 01             	add    eax,0x1
     c05:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     c08:	0f be d0             	movsx  edx,al
     c0b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     c0e:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     c11:	0f be c0             	movsx  eax,al
     c14:	8b 4d c0             	mov    ecx,DWORD PTR [ebp-0x40]
     c17:	89 4c 24 1c          	mov    DWORD PTR [esp+0x1c],ecx
     c1b:	89 5c 24 18          	mov    DWORD PTR [esp+0x18],ebx
     c1f:	8b 4d b8             	mov    ecx,DWORD PTR [ebp-0x48]
     c22:	89 4c 24 14          	mov    DWORD PTR [esp+0x14],ecx
     c26:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
     c29:	89 4c 24 10          	mov    DWORD PTR [esp+0x10],ecx
     c2d:	c7 44 24 0c 18 00 00 00 	mov    DWORD PTR [esp+0xc],0x18
     c35:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     c39:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     c3d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c40:	89 04 24             	mov    DWORD PTR [esp],eax
     c43:	e8 fc ff ff ff       	call   c44 <render_text_scanline_24btpp_sse+0x332>
     c48:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
								r, rmax, pixbuf + bt_ofs, inv);
				cc1 = rmax - r;
     c4b:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
     c4e:	2b 45 e0             	sub    eax,DWORD PTR [ebp-0x20]
     c51:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
				/* now advance if neccessary */
				if (rmax == 8)
     c54:	83 7d b8 08          	cmp    DWORD PTR [ebp-0x48],0x8
     c58:	75 04                	jne    c5e <render_text_scanline_24btpp_sse+0x34c>
						str += 2;
     c5a:	83 45 0c 02          	add    DWORD PTR [ebp+0xc],0x2
				/* and fetch up to five more pixels if needed (r=0) */
				if (cc > cc1) {
     c5e:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
     c61:	3b 45 b4             	cmp    eax,DWORD PTR [ebp-0x4c]
     c64:	7e 7b                	jle    ce1 <render_text_scanline_24btpp_sse+0x3cf>
						col++; inv = (col == cur_x);
     c66:	83 45 c4 01          	add    DWORD PTR [ebp-0x3c],0x1
     c6a:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
     c6d:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
     c70:	0f 94 c0             	sete   al
     c73:	0f b6 c0             	movzx  eax,al
     c76:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
						bitc += generate_char_colors(font, str[0], str[1], 24,
     c79:	8b 4d 8c             	mov    ecx,DWORD PTR [ebp-0x74]
										0, cc - cc1, pixbuf + bt_ofs + cc1 * 3, inv);
     c7c:	8b 55 b4             	mov    edx,DWORD PTR [ebp-0x4c]
     c7f:	89 d0                	mov    eax,edx
     c81:	01 c0                	add    eax,eax
     c83:	01 d0                	add    eax,edx
     c85:	89 c2                	mov    edx,eax
     c87:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     c8a:	01 d0                	add    eax,edx
						bitc += generate_char_colors(font, str[0], str[1], 24,
     c8c:	8d 34 01             	lea    esi,[ecx+eax*1]
     c8f:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
     c92:	2b 45 b4             	sub    eax,DWORD PTR [ebp-0x4c]
     c95:	89 c1                	mov    ecx,eax
     c97:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     c9a:	83 c0 01             	add    eax,0x1
     c9d:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     ca0:	0f be d0             	movsx  edx,al
     ca3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     ca6:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     ca9:	0f be c0             	movsx  eax,al
     cac:	8b 5d c0             	mov    ebx,DWORD PTR [ebp-0x40]
     caf:	89 5c 24 1c          	mov    DWORD PTR [esp+0x1c],ebx
     cb3:	89 74 24 18          	mov    DWORD PTR [esp+0x18],esi
     cb7:	89 4c 24 14          	mov    DWORD PTR [esp+0x14],ecx
     cbb:	c7 44 24 10 00 00 00 00 	mov    DWORD PTR [esp+0x10],0x0
     cc3:	c7 44 24 0c 18 00 00 00 	mov    DWORD PTR [esp+0xc],0x18
     ccb:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     ccf:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     cd3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     cd6:	89 04 24             	mov    DWORD PTR [esp],eax
     cd9:	e8 fc ff ff ff       	call   cda <render_text_scanline_24btpp_sse+0x3c8>
     cde:	01 45 f0             	add    DWORD PTR [ebp-0x10],eax
				}
				/* now transfer */
				if (btt >= 128) {
     ce1:	83 7d ec 7f          	cmp    DWORD PTR [ebp-0x14],0x7f
     ce5:	7e 24                	jle    d0b <render_text_scanline_24btpp_sse+0x3f9>
						move_128(pixbuf, mem);
     ce7:	8b 45 8c             	mov    eax,DWORD PTR [ebp-0x74]
     cea:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     ced:	0f 28 00             	movaps xmm0,XMMWORD PTR [eax]
     cf0:	0f 29 02             	movaps XMMWORD PTR [edx],xmm0
						mem += 16;
     cf3:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     cf6:	83 c0 10             	add    eax,0x10
     cf9:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
						}
						break;
				}

				/* and don't advance as r = 0 is already handled (sth. remains) */
				if (px_x) {
     cfc:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     d00:	0f 84 17 01 00 00    	je     e1d <render_text_scanline_24btpp_sse+0x50b>
     d06:	e9 ca 00 00 00       	jmp    dd5 <render_text_scanline_24btpp_sse+0x4c3>
						uint8_t* pt = pixbuf;
     d0b:	8b 45 8c             	mov    eax,DWORD PTR [ebp-0x74]
     d0e:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
						if (btt >= 64) {
     d11:	83 7d ec 3f          	cmp    DWORD PTR [ebp-0x14],0x3f
     d15:	7e 1d                	jle    d34 <render_text_scanline_24btpp_sse+0x422>
								move_64(pixbuf, mem);
     d17:	8b 45 8c             	mov    eax,DWORD PTR [ebp-0x74]
     d1a:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     d1d:	0f 6f 00             	movq   mm0,QWORD PTR [eax]
     d20:	0f 7f 02             	movq   QWORD PTR [edx],mm0
								pt += 8;
     d23:	83 45 e8 08          	add    DWORD PTR [ebp-0x18],0x8
								mem += 8;
     d27:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     d2a:	83 c0 08             	add    eax,0x8
     d2d:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
								btt -= 64;
     d30:	83 6d ec 40          	sub    DWORD PTR [ebp-0x14],0x40
						if (btt >= 32) {
     d34:	83 7d ec 1f          	cmp    DWORD PTR [ebp-0x14],0x1f
     d38:	7e 20                	jle    d5a <render_text_scanline_24btpp_sse+0x448>
								*(uint32_t*)mem = *(uint32_t*)pt;
     d3a:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     d3d:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
     d40:	8b 12                	mov    edx,DWORD PTR [edx]
     d42:	89 10                	mov    DWORD PTR [eax],edx
								pt += 4;
     d44:	83 45 e8 04          	add    DWORD PTR [ebp-0x18],0x4
								mem += 4;
     d48:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     d4b:	83 c0 04             	add    eax,0x4
     d4e:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
								btt -= 32;
     d51:	83 6d ec 20          	sub    DWORD PTR [ebp-0x14],0x20
						break;
     d55:	e9 c6 00 00 00       	jmp    e20 <render_text_scanline_24btpp_sse+0x50e>
						} else if (btt >= 16) {
     d5a:	83 7d ec 0f          	cmp    DWORD PTR [ebp-0x14],0xf
     d5e:	7e 22                	jle    d82 <render_text_scanline_24btpp_sse+0x470>
								*(uint16_t*)mem = *(uint16_t*)pt;
     d60:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     d63:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
     d66:	0f b7 12             	movzx  edx,WORD PTR [edx]
     d69:	66 89 10             	mov    WORD PTR [eax],dx
								pt += 2;
     d6c:	83 45 e8 02          	add    DWORD PTR [ebp-0x18],0x2
								mem += 2;
     d70:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     d73:	83 c0 02             	add    eax,0x2
     d76:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
								btt -= 16;
     d79:	83 6d ec 10          	sub    DWORD PTR [ebp-0x14],0x10
						break;
     d7d:	e9 9e 00 00 00       	jmp    e20 <render_text_scanline_24btpp_sse+0x50e>
						} else if (bitc >= 8) {
     d82:	83 7d f0 07          	cmp    DWORD PTR [ebp-0x10],0x7
     d86:	7e 1e                	jle    da6 <render_text_scanline_24btpp_sse+0x494>
								*(uint8_t*)mem = *(uint8_t*)pt;
     d88:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     d8b:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
     d8e:	0f b6 12             	movzx  edx,BYTE PTR [edx]
     d91:	88 10                	mov    BYTE PTR [eax],dl
								pt += 1;
     d93:	83 45 e8 01          	add    DWORD PTR [ebp-0x18],0x1
								mem += 1;
     d97:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     d9a:	83 c0 01             	add    eax,0x1
     d9d:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
								btt -= 8;
     da0:	83 6d ec 08          	sub    DWORD PTR [ebp-0x14],0x8
						break;
     da4:	eb 7a                	jmp    e20 <render_text_scanline_24btpp_sse+0x50e>
						} else if (bitc) {
     da6:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     daa:	74 74                	je     e20 <render_text_scanline_24btpp_sse+0x50e>
								die("can't happen with 3byte sized pixels\n");
     dac:	c7 44 24 04 44 01 00 00 	mov    DWORD PTR [esp+0x4],0x144
     db4:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
     dbb:	e8 fc ff ff ff       	call   dbc <render_text_scanline_24btpp_sse+0x4aa>
     dc0:	e8 fc ff ff ff       	call   dc1 <render_text_scanline_24btpp_sse+0x4af>
     dc5:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     dcc:	e8 fc ff ff ff       	call   dcd <render_text_scanline_24btpp_sse+0x4bb>
     dd1:	fa                   	cli
     dd2:	f4                   	hlt
     dd3:	eb fd                	jmp    dd2 <render_text_scanline_24btpp_sse+0x4c0>
						px_x -= cc; /* bitc is 24-divisible */
     dd5:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
     dd8:	29 45 14             	sub    DWORD PTR [ebp+0x14],eax
						p0_x += cc; /* unneccessary as r does not change anymore */
     ddb:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
     dde:	01 45 1c             	add    DWORD PTR [ebp+0x1c],eax
						/* copy remaining data */
						/* |bt_ofs*8-bitc| */
						if (!bt_ofs--)
     de1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     de4:	8d 50 ff             	lea    edx,[eax-0x1]
     de7:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
     dea:	85 c0                	test   eax,eax
     dec:	75 07                	jne    df5 <render_text_scanline_24btpp_sse+0x4e3>
								bt_ofs = 2;
     dee:	c7 45 f4 02 00 00 00 	mov    DWORD PTR [ebp-0xc],0x2
						memcpy(pixbuf, pixbuf + 16, bt_ofs);
     df5:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     df8:	8b 45 8c             	mov    eax,DWORD PTR [ebp-0x74]
     dfb:	8d 48 10             	lea    ecx,[eax+0x10]
     dfe:	8b 45 8c             	mov    eax,DWORD PTR [ebp-0x74]
     e01:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     e05:	89 4c 24 04          	mov    DWORD PTR [esp+0x4],ecx
     e09:	89 04 24             	mov    DWORD PTR [esp],eax
     e0c:	e8 ef f1 ff ff       	call   0 <memcpy>
		while (px_x) { /* 144 bit vs. 128 16bt remain (2/3) */
     e11:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     e15:	0f 85 56 fd ff ff    	jne    b71 <render_text_scanline_24btpp_sse+0x25f>
     e1b:	eb 04                	jmp    e21 <render_text_scanline_24btpp_sse+0x50f>
				} else
						break;
     e1d:	90                   	nop
     e1e:	eb 01                	jmp    e21 <render_text_scanline_24btpp_sse+0x50f>
						break;
     e20:	90                   	nop
		}

		/* transfer the leftover pixel data */
		if (bt_ofs)
     e21:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     e25:	74 19                	je     e40 <render_text_scanline_24btpp_sse+0x52e>
				memcpy(pixbuf, mem, bt_ofs);
     e27:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     e2a:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     e2d:	8b 45 8c             	mov    eax,DWORD PTR [ebp-0x74]
     e30:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
     e34:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     e38:	89 04 24             	mov    DWORD PTR [esp],eax
     e3b:	e8 c0 f1 ff ff       	call   0 <memcpy>
}
     e40:	90                   	nop
     e41:	81 c4 90 00 00 00    	add    esp,0x90
     e47:	5b                   	pop    ebx
     e48:	5e                   	pop    esi
     e49:	5d                   	pop    ebp
     e4a:	c3                   	ret

00000e4b <render_text_scanline_16btpp>:

/* we're generating 2byte colorvalues /w unknown alignment. To enable
 * 8 byte transfer, four pixels have to be generated. */
void render_text_scanline_16btpp(const char* font, char* str, void* mem,
				ssize_t px_x, ssize_t cur_x, ssize_t p0_x, size_t btpp)
{
     e4b:	55                   	push   ebp
     e4c:	89 e5                	mov    ebp,esp
     e4e:	56                   	push   esi
     e4f:	53                   	push   ebx
     e50:	83 ec 70             	sub    esp,0x70
		uint8_t pxb[8 + 7]; /* 7 for stack alignment */
		ssize_t misalign = ((size_t)mem % 8) ? (8 - (size_t)mem % 8) : 0;
     e53:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     e56:	83 e0 07             	and    eax,0x7
     e59:	85 c0                	test   eax,eax
     e5b:	74 11                	je     e6e <render_text_scanline_16btpp+0x23>
     e5d:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     e60:	83 e0 07             	and    eax,0x7
     e63:	ba 08 00 00 00       	mov    edx,0x8
     e68:	29 c2                	sub    edx,eax
     e6a:	89 d0                	mov    eax,edx
     e6c:	eb 05                	jmp    e73 <render_text_scanline_16btpp+0x28>
     e6e:	b8 00 00 00 00       	mov    eax,0x0
     e73:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		ssize_t r = p0_x % 8;
     e76:	8b 55 1c             	mov    edx,DWORD PTR [ebp+0x1c]
     e79:	89 d0                	mov    eax,edx
     e7b:	c1 f8 1f             	sar    eax,0x1f
     e7e:	c1 e8 1d             	shr    eax,0x1d
     e81:	01 c2                	add    edx,eax
     e83:	83 e2 07             	and    edx,0x7
     e86:	29 c2                	sub    edx,eax
     e88:	89 55 e8             	mov    DWORD PTR [ebp-0x18],edx
		uint8_t* pixbuf = pxb + (((size_t)pxb % 8) ? (8 - ((size_t)pxb % 8)) : 0);
     e8b:	8d 45 b1             	lea    eax,[ebp-0x4f]
     e8e:	83 e0 07             	and    eax,0x7
     e91:	85 c0                	test   eax,eax
     e93:	74 11                	je     ea6 <render_text_scanline_16btpp+0x5b>
     e95:	8d 45 b1             	lea    eax,[ebp-0x4f]
     e98:	83 e0 07             	and    eax,0x7
     e9b:	89 c2                	mov    edx,eax
     e9d:	b8 08 00 00 00       	mov    eax,0x8
     ea2:	29 d0                	sub    eax,edx
     ea4:	eb 05                	jmp    eab <render_text_scanline_16btpp+0x60>
     ea6:	b8 00 00 00 00       	mov    eax,0x0
     eab:	8d 55 b1             	lea    edx,[ebp-0x4f]
     eae:	01 d0                	add    eax,edx
     eb0:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
		/* 64-bit aligned moves are enough */

		if (misalign) { /* LFB is dword aligned, we want qword access */
     eb3:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     eb7:	0f 84 78 03 00 00    	je     1235 <render_text_scanline_16btpp+0x3ea>
				int col = p0_x / 8, inv = (col == cur_x);
     ebd:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     ec0:	8d 50 07             	lea    edx,[eax+0x7]
     ec3:	85 c0                	test   eax,eax
     ec5:	0f 48 c2             	cmovs  eax,edx
     ec8:	c1 f8 03             	sar    eax,0x3
     ecb:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
     ece:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     ed1:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
     ed4:	0f 94 c0             	sete   al
     ed7:	0f b6 c0             	movzx  eax,al
     eda:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
				ssize_t bc = min(misalign, 2 * px_x);
     edd:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     ee0:	01 c0                	add    eax,eax
     ee2:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     ee5:	39 c2                	cmp    edx,eax
     ee7:	0f 4e c2             	cmovle eax,edx
     eea:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
				ssize_t cc = rdiv(misalign, 2);
     eed:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     ef0:	89 c2                	mov    edx,eax
     ef2:	c1 ea 1f             	shr    edx,0x1f
     ef5:	01 d0                	add    eax,edx
     ef7:	d1 f8                	sar    eax,1
     ef9:	89 c2                	mov    edx,eax
     efb:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     efe:	83 e0 01             	and    eax,0x1
     f01:	01 d0                	add    eax,edx
     f03:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
				ssize_t rmax = min(8, r + cc), cc1 = rmax - r;
     f06:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
     f09:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     f0c:	01 d0                	add    eax,edx
     f0e:	ba 08 00 00 00       	mov    edx,0x8
     f13:	39 d0                	cmp    eax,edx
     f15:	0f 4f c2             	cmovg  eax,edx
     f18:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
     f1b:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     f1e:	2b 45 e8             	sub    eax,DWORD PTR [ebp-0x18]
     f21:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax

				generate_char_colors(font, str[0], str[1], btpp,
     f24:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
     f27:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     f2a:	83 c0 01             	add    eax,0x1
     f2d:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     f30:	0f be d0             	movsx  edx,al
     f33:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     f36:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     f39:	0f be c0             	movsx  eax,al
     f3c:	8b 5d e0             	mov    ebx,DWORD PTR [ebp-0x20]
     f3f:	89 5c 24 1c          	mov    DWORD PTR [esp+0x1c],ebx
     f43:	89 4c 24 18          	mov    DWORD PTR [esp+0x18],ecx
     f47:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
     f4a:	89 4c 24 14          	mov    DWORD PTR [esp+0x14],ecx
     f4e:	8b 4d e8             	mov    ecx,DWORD PTR [ebp-0x18]
     f51:	89 4c 24 10          	mov    DWORD PTR [esp+0x10],ecx
     f55:	8b 4d 20             	mov    ecx,DWORD PTR [ebp+0x20]
     f58:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
     f5c:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     f60:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     f64:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     f67:	89 04 24             	mov    DWORD PTR [esp],eax
     f6a:	e8 fc ff ff ff       	call   f6b <render_text_scanline_16btpp+0x120>
								r, rmax, pixbuf, inv);
				if (rmax == 8)
     f6f:	83 7d d4 08          	cmp    DWORD PTR [ebp-0x2c],0x8
     f73:	75 04                	jne    f79 <render_text_scanline_16btpp+0x12e>
						str += 2;
     f75:	83 45 0c 02          	add    DWORD PTR [ebp+0xc],0x2
				if (cc > cc1) {
     f79:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     f7c:	3b 45 d0             	cmp    eax,DWORD PTR [ebp-0x30]
     f7f:	7e 6a                	jle    feb <render_text_scanline_16btpp+0x1a0>
						col++; inv = (col == cur_x);
     f81:	83 45 e4 01          	add    DWORD PTR [ebp-0x1c],0x1
     f85:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     f88:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
     f8b:	0f 94 c0             	sete   al
     f8e:	0f b6 c0             	movzx  eax,al
     f91:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
						generate_char_colors(font, str[0], str[1], btpp,
     f94:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
     f97:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     f9a:	8d 34 02             	lea    esi,[edx+eax*1]
     f9d:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     fa0:	2b 45 d0             	sub    eax,DWORD PTR [ebp-0x30]
     fa3:	89 c1                	mov    ecx,eax
     fa5:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     fa8:	83 c0 01             	add    eax,0x1
     fab:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     fae:	0f be d0             	movsx  edx,al
     fb1:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     fb4:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     fb7:	0f be c0             	movsx  eax,al
     fba:	8b 5d e0             	mov    ebx,DWORD PTR [ebp-0x20]
     fbd:	89 5c 24 1c          	mov    DWORD PTR [esp+0x1c],ebx
     fc1:	89 74 24 18          	mov    DWORD PTR [esp+0x18],esi
     fc5:	89 4c 24 14          	mov    DWORD PTR [esp+0x14],ecx
     fc9:	c7 44 24 10 00 00 00 00 	mov    DWORD PTR [esp+0x10],0x0
     fd1:	8b 4d 20             	mov    ecx,DWORD PTR [ebp+0x20]
     fd4:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
     fd8:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     fdc:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     fe0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     fe3:	89 04 24             	mov    DWORD PTR [esp],eax
     fe6:	e8 fc ff ff ff       	call   fe7 <render_text_scanline_16btpp+0x19c>
										0, cc - cc1, pixbuf + cc1, inv);
				}
				memcpy(mem, pixbuf, bc);
     feb:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
     fee:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
     ff1:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     ff4:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
     ff8:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     ffc:	89 04 24             	mov    DWORD PTR [esp],eax
     fff:	e8 fc ef ff ff       	call   0 <memcpy>
				px_x -= cc;
    1004:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1007:	29 45 14             	sub    DWORD PTR [ebp+0x14],eax
				p0_x += cc;
    100a:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    100d:	01 45 1c             	add    DWORD PTR [ebp+0x1c],eax
				mem += bc;
    1010:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
    1013:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1016:	01 d0                	add    eax,edx
    1018:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
		}

		/* draw 4 pixels each */
		while (px_x) {
    101b:	e9 15 02 00 00       	jmp    1235 <render_text_scanline_16btpp+0x3ea>
				int col = p0_x / 8, inv = (col == cur_x);
    1020:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
    1023:	8d 50 07             	lea    edx,[eax+0x7]
    1026:	85 c0                	test   eax,eax
    1028:	0f 48 c2             	cmovs  eax,edx
    102b:	c1 f8 03             	sar    eax,0x3
    102e:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
    1031:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1034:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
    1037:	0f 94 c0             	sete   al
    103a:	0f b6 c0             	movzx  eax,al
    103d:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
				ssize_t rmax, bitc, btt = min(64, 16 * px_x);
    1040:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1043:	c1 e0 04             	shl    eax,0x4
    1046:	ba 40 00 00 00       	mov    edx,0x40
    104b:	39 d0                	cmp    eax,edx
    104d:	0f 4f c2             	cmovg  eax,edx
    1050:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
				r = p0_x % 8;
    1053:	8b 55 1c             	mov    edx,DWORD PTR [ebp+0x1c]
    1056:	89 d0                	mov    eax,edx
    1058:	c1 f8 1f             	sar    eax,0x1f
    105b:	c1 e8 1d             	shr    eax,0x1d
    105e:	01 c2                	add    edx,eax
    1060:	83 e2 07             	and    edx,0x7
    1063:	29 c2                	sub    edx,eax
    1065:	89 55 e8             	mov    DWORD PTR [ebp-0x18],edx
				rmax = min(8, r + min(4, px_x)); /* only 2 pixels */
    1068:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    106b:	ba 04 00 00 00       	mov    edx,0x4
    1070:	39 d0                	cmp    eax,edx
    1072:	0f 4e d0             	cmovle edx,eax
    1075:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1078:	01 d0                	add    eax,edx
    107a:	ba 08 00 00 00       	mov    edx,0x8
    107f:	39 d0                	cmp    eax,edx
    1081:	0f 4f c2             	cmovg  eax,edx
    1084:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
				/* get the remaining character pixels */
				bitc = generate_char_colors(font, str[0], str[1], btpp,
    1087:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    108a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    108d:	83 c0 01             	add    eax,0x1
    1090:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1093:	0f be d0             	movsx  edx,al
    1096:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1099:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    109c:	0f be c0             	movsx  eax,al
    109f:	8b 5d c8             	mov    ebx,DWORD PTR [ebp-0x38]
    10a2:	89 5c 24 1c          	mov    DWORD PTR [esp+0x1c],ebx
    10a6:	89 4c 24 18          	mov    DWORD PTR [esp+0x18],ecx
    10aa:	8b 4d c0             	mov    ecx,DWORD PTR [ebp-0x40]
    10ad:	89 4c 24 14          	mov    DWORD PTR [esp+0x14],ecx
    10b1:	8b 4d e8             	mov    ecx,DWORD PTR [ebp-0x18]
    10b4:	89 4c 24 10          	mov    DWORD PTR [esp+0x10],ecx
    10b8:	8b 4d 20             	mov    ecx,DWORD PTR [ebp+0x20]
    10bb:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    10bf:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    10c3:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    10c7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    10ca:	89 04 24             	mov    DWORD PTR [esp],eax
    10cd:	e8 fc ff ff ff       	call   10ce <render_text_scanline_16btpp+0x283>
    10d2:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
								r, rmax, pixbuf, inv);
				/* now advance if neccessary */
				if (rmax == 8)
    10d5:	83 7d c0 08          	cmp    DWORD PTR [ebp-0x40],0x8
    10d9:	75 04                	jne    10df <render_text_scanline_16btpp+0x294>
						str += 2;
    10db:	83 45 0c 02          	add    DWORD PTR [ebp+0xc],0x2
				/* and fetch up to three more pixels if needed (r=0) */
				if (bitc < btt) {
    10df:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    10e2:	3b 45 c4             	cmp    eax,DWORD PTR [ebp-0x3c]
    10e5:	0f 8d 83 00 00 00    	jge    116e <render_text_scanline_16btpp+0x323>
						col++;
    10eb:	83 45 cc 01          	add    DWORD PTR [ebp-0x34],0x1
						inv = (col == cur_x);
    10ef:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    10f2:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
    10f5:	0f 94 c0             	sete   al
    10f8:	0f b6 c0             	movzx  eax,al
    10fb:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
						bitc += generate_char_colors(font, str[0], str[1], btpp,
    10fe:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
										0, (btt - bitc) / 16, pixbuf + bitc / 16, inv);
    1101:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1104:	8d 48 0f             	lea    ecx,[eax+0xf]
    1107:	85 c0                	test   eax,eax
    1109:	0f 48 c1             	cmovs  eax,ecx
    110c:	c1 f8 04             	sar    eax,0x4
						bitc += generate_char_colors(font, str[0], str[1], btpp,
    110f:	8d 1c 02             	lea    ebx,[edx+eax*1]
										0, (btt - bitc) / 16, pixbuf + bitc / 16, inv);
    1112:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    1115:	2b 45 f4             	sub    eax,DWORD PTR [ebp-0xc]
						bitc += generate_char_colors(font, str[0], str[1], btpp,
    1118:	8d 50 0f             	lea    edx,[eax+0xf]
    111b:	85 c0                	test   eax,eax
    111d:	0f 48 c2             	cmovs  eax,edx
    1120:	c1 f8 04             	sar    eax,0x4
    1123:	89 c6                	mov    esi,eax
    1125:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1128:	83 c0 01             	add    eax,0x1
    112b:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    112e:	0f be d0             	movsx  edx,al
    1131:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1134:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1137:	0f be c0             	movsx  eax,al
    113a:	8b 4d c8             	mov    ecx,DWORD PTR [ebp-0x38]
    113d:	89 4c 24 1c          	mov    DWORD PTR [esp+0x1c],ecx
    1141:	89 5c 24 18          	mov    DWORD PTR [esp+0x18],ebx
    1145:	89 74 24 14          	mov    DWORD PTR [esp+0x14],esi
    1149:	c7 44 24 10 00 00 00 00 	mov    DWORD PTR [esp+0x10],0x0
    1151:	8b 4d 20             	mov    ecx,DWORD PTR [ebp+0x20]
    1154:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    1158:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    115c:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1160:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1163:	89 04 24             	mov    DWORD PTR [esp],eax
    1166:	e8 fc ff ff ff       	call   1167 <render_text_scanline_16btpp+0x31c>
    116b:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
				}
				/* now transfer */
				if (bitc >= 64) {
    116e:	83 7d f4 3f          	cmp    DWORD PTR [ebp-0xc],0x3f
    1172:	7e 21                	jle    1195 <render_text_scanline_16btpp+0x34a>
						move_64(pixbuf, mem);
    1174:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    1177:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
    117a:	0f 6f 00             	movq   mm0,QWORD PTR [eax]
    117d:	0f 7f 02             	movq   QWORD PTR [edx],mm0
						mem += 8; /* intentionally no bitc subtract */
    1180:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1183:	83 c0 08             	add    eax,0x8
    1186:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
						}
						break;
				}

				/* and don't advance as r = 0 is already handled (sth. remains) */
				if (px_x) {
    1189:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
    118d:	0f 84 ae 00 00 00    	je     1241 <render_text_scanline_16btpp+0x3f6>
    1193:	eb 7c                	jmp    1211 <render_text_scanline_16btpp+0x3c6>
						void* pt = pixbuf;
    1195:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    1198:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
						if (bitc >= 32) {
    119b:	83 7d f4 1f          	cmp    DWORD PTR [ebp-0xc],0x1f
    119f:	7e 1b                	jle    11bc <render_text_scanline_16btpp+0x371>
								*(uint32_t*)mem = *(uint32_t*)pixbuf;
    11a1:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
    11a4:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    11a7:	8b 12                	mov    edx,DWORD PTR [edx]
    11a9:	89 10                	mov    DWORD PTR [eax],edx
								mem += 4;
    11ab:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    11ae:	83 c0 04             	add    eax,0x4
    11b1:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
								pt += 4;
    11b4:	83 45 f0 04          	add    DWORD PTR [ebp-0x10],0x4
								bitc -= 32;
    11b8:	83 6d f4 20          	sub    DWORD PTR [ebp-0xc],0x20
						if (bitc >= 16) {
    11bc:	83 7d f4 0f          	cmp    DWORD PTR [ebp-0xc],0xf
    11c0:	7e 19                	jle    11db <render_text_scanline_16btpp+0x390>
								*(uint32_t*)mem = *(uint32_t*)pt;
    11c2:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    11c5:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    11c8:	8b 12                	mov    edx,DWORD PTR [edx]
    11ca:	89 10                	mov    DWORD PTR [eax],edx
								mem += 2;
    11cc:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    11cf:	83 c0 02             	add    eax,0x2
    11d2:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
								bitc -= 16;
    11d5:	83 6d f4 10          	sub    DWORD PTR [ebp-0xc],0x10
						break;
    11d9:	eb 69                	jmp    1244 <render_text_scanline_16btpp+0x3f9>
						} else if (bitc) {
    11db:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    11df:	74 63                	je     1244 <render_text_scanline_16btpp+0x3f9>
								die("cant happen with word sized pixels! %d\n", px_x);
    11e1:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    11e4:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    11e8:	c7 44 24 04 6c 01 00 00 	mov    DWORD PTR [esp+0x4],0x16c
    11f0:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    11f7:	e8 fc ff ff ff       	call   11f8 <render_text_scanline_16btpp+0x3ad>
    11fc:	e8 fc ff ff ff       	call   11fd <render_text_scanline_16btpp+0x3b2>
    1201:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1208:	e8 fc ff ff ff       	call   1209 <render_text_scanline_16btpp+0x3be>
    120d:	fa                   	cli
    120e:	f4                   	hlt
    120f:	eb fd                	jmp    120e <render_text_scanline_16btpp+0x3c3>
						px_x -= bitc / 16;
    1211:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1214:	8d 50 0f             	lea    edx,[eax+0xf]
    1217:	85 c0                	test   eax,eax
    1219:	0f 48 c2             	cmovs  eax,edx
    121c:	c1 f8 04             	sar    eax,0x4
    121f:	f7 d8                	neg    eax
    1221:	01 45 14             	add    DWORD PTR [ebp+0x14],eax
						p0_x += bitc / 16; /* unneccessary as r does not change anymore */
    1224:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1227:	8d 50 0f             	lea    edx,[eax+0xf]
    122a:	85 c0                	test   eax,eax
    122c:	0f 48 c2             	cmovs  eax,edx
    122f:	c1 f8 04             	sar    eax,0x4
    1232:	01 45 1c             	add    DWORD PTR [ebp+0x1c],eax
		while (px_x) {
    1235:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
    1239:	0f 85 e1 fd ff ff    	jne    1020 <render_text_scanline_16btpp+0x1d5>
				} else
						break;
		}
}
    123f:	eb 04                	jmp    1245 <render_text_scanline_16btpp+0x3fa>
						break;
    1241:	90                   	nop
    1242:	eb 01                	jmp    1245 <render_text_scanline_16btpp+0x3fa>
						break;
    1244:	90                   	nop
}
    1245:	90                   	nop
    1246:	83 c4 70             	add    esp,0x70
    1249:	5b                   	pop    ebx
    124a:	5e                   	pop    esi
    124b:	5d                   	pop    ebp
    124c:	c3                   	ret

0000124d <render_text_scanline_32btpp>:

/* we're generating 4byte colorvalues /w unknown alignment. To enable
 * 8 byte transfer, two pixel have to be generated. */
void render_text_scanline_32btpp(const char* font, char* str, void* mem,
				ssize_t px_x, ssize_t cur_x, ssize_t p0_x)
{
    124d:	55                   	push   ebp
    124e:	89 e5                	mov    ebp,esp
    1250:	53                   	push   ebx
    1251:	83 ec 74             	sub    esp,0x74
		uint8_t pxb[8 + 7]; /* 7 for stack alignment */
		ssize_t misalign = ((size_t)mem % 8) ? (8 - (size_t)mem % 8) : 0;
    1254:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1257:	83 e0 07             	and    eax,0x7
    125a:	85 c0                	test   eax,eax
    125c:	74 11                	je     126f <render_text_scanline_32btpp+0x22>
    125e:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1261:	83 e0 07             	and    eax,0x7
    1264:	ba 08 00 00 00       	mov    edx,0x8
    1269:	29 c2                	sub    edx,eax
    126b:	89 d0                	mov    eax,edx
    126d:	eb 05                	jmp    1274 <render_text_scanline_32btpp+0x27>
    126f:	b8 00 00 00 00       	mov    eax,0x0
    1274:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		ssize_t r = p0_x % 8;
    1277:	8b 55 1c             	mov    edx,DWORD PTR [ebp+0x1c]
    127a:	89 d0                	mov    eax,edx
    127c:	c1 f8 1f             	sar    eax,0x1f
    127f:	c1 e8 1d             	shr    eax,0x1d
    1282:	01 c2                	add    edx,eax
    1284:	83 e2 07             	and    edx,0x7
    1287:	29 c2                	sub    edx,eax
    1289:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
		uint8_t* pixbuf = pxb + (((size_t)pxb % 8) ? (8 - ((size_t)pxb % 8)) : 0);
    128c:	8d 45 b9             	lea    eax,[ebp-0x47]
    128f:	83 e0 07             	and    eax,0x7
    1292:	85 c0                	test   eax,eax
    1294:	74 11                	je     12a7 <render_text_scanline_32btpp+0x5a>
    1296:	8d 45 b9             	lea    eax,[ebp-0x47]
    1299:	83 e0 07             	and    eax,0x7
    129c:	89 c2                	mov    edx,eax
    129e:	b8 08 00 00 00       	mov    eax,0x8
    12a3:	29 d0                	sub    eax,edx
    12a5:	eb 05                	jmp    12ac <render_text_scanline_32btpp+0x5f>
    12a7:	b8 00 00 00 00       	mov    eax,0x0
    12ac:	8d 55 b9             	lea    edx,[ebp-0x47]
    12af:	01 d0                	add    eax,edx
    12b1:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
		/* 64-bit aligned moves are enough */

		if (misalign) { /* LFB is dword aligned, we want qword access */
    12b4:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    12b8:	0f 84 bc 02 00 00    	je     157a <render_text_scanline_32btpp+0x32d>
				int col = p0_x / 8, inv = (col == cur_x);
    12be:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
    12c1:	8d 50 07             	lea    edx,[eax+0x7]
    12c4:	85 c0                	test   eax,eax
    12c6:	0f 48 c2             	cmovs  eax,edx
    12c9:	c1 f8 03             	sar    eax,0x3
    12cc:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    12cf:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    12d2:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
    12d5:	0f 94 c0             	sete   al
    12d8:	0f b6 c0             	movzx  eax,al
    12db:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				ssize_t bc = min(misalign, 4 * px_x);
    12de:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    12e1:	c1 e0 02             	shl    eax,0x2
    12e4:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    12e7:	39 c2                	cmp    edx,eax
    12e9:	0f 4e c2             	cmovle eax,edx
    12ec:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
				ssize_t cc = rdiv(misalign, 4);
    12ef:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    12f2:	8d 50 03             	lea    edx,[eax+0x3]
    12f5:	85 c0                	test   eax,eax
    12f7:	0f 48 c2             	cmovs  eax,edx
    12fa:	c1 f8 02             	sar    eax,0x2
    12fd:	89 c2                	mov    edx,eax
    12ff:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1302:	83 e0 03             	and    eax,0x3
    1305:	85 c0                	test   eax,eax
    1307:	0f 95 c0             	setne  al
    130a:	0f b6 c0             	movzx  eax,al
    130d:	01 d0                	add    eax,edx
    130f:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
				ssize_t rmax = min(8, r + cc); //, cc1 = rmax - r;
    1312:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1315:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1318:	01 d0                	add    eax,edx
    131a:	ba 08 00 00 00       	mov    edx,0x8
    131f:	39 d0                	cmp    eax,edx
    1321:	0f 4f c2             	cmovg  eax,edx
    1324:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax

				generate_char_colors(font, str[0], str[1], 32,
    1327:	8b 4d b4             	mov    ecx,DWORD PTR [ebp-0x4c]
    132a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    132d:	83 c0 01             	add    eax,0x1
    1330:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1333:	0f be d0             	movsx  edx,al
    1336:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1339:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    133c:	0f be c0             	movsx  eax,al
    133f:	8b 5d e4             	mov    ebx,DWORD PTR [ebp-0x1c]
    1342:	89 5c 24 1c          	mov    DWORD PTR [esp+0x1c],ebx
    1346:	89 4c 24 18          	mov    DWORD PTR [esp+0x18],ecx
    134a:	8b 4d d8             	mov    ecx,DWORD PTR [ebp-0x28]
    134d:	89 4c 24 14          	mov    DWORD PTR [esp+0x14],ecx
    1351:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
    1354:	89 4c 24 10          	mov    DWORD PTR [esp+0x10],ecx
    1358:	c7 44 24 0c 20 00 00 00 	mov    DWORD PTR [esp+0xc],0x20
    1360:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    1364:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1368:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    136b:	89 04 24             	mov    DWORD PTR [esp],eax
    136e:	e8 fc ff ff ff       	call   136f <render_text_scanline_32btpp+0x122>
								r, rmax, pixbuf, inv);
				if (rmax == 8)
    1373:	83 7d d8 08          	cmp    DWORD PTR [ebp-0x28],0x8
    1377:	75 04                	jne    137d <render_text_scanline_32btpp+0x130>
						str += 2;
    1379:	83 45 0c 02          	add    DWORD PTR [ebp+0xc],0x2
				// if (cc > cc1) <- does not happen cc always 1
				memcpy(mem, pixbuf, bc);
    137d:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
    1380:	8b 55 b4             	mov    edx,DWORD PTR [ebp-0x4c]
    1383:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1386:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
    138a:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    138e:	89 04 24             	mov    DWORD PTR [esp],eax
    1391:	e8 6a ec ff ff       	call   0 <memcpy>
				px_x -= cc;
    1396:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1399:	29 45 14             	sub    DWORD PTR [ebp+0x14],eax
				p0_x += cc;
    139c:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    139f:	01 45 1c             	add    DWORD PTR [ebp+0x1c],eax
				mem += bc;
    13a2:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
    13a5:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    13a8:	01 d0                	add    eax,edx
    13aa:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
		}

		/* draw 2 pixels each */
		while (px_x) {
    13ad:	e9 c8 01 00 00       	jmp    157a <render_text_scanline_32btpp+0x32d>
				int col = p0_x / 8, inv = (col == cur_x);
    13b2:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
    13b5:	8d 50 07             	lea    edx,[eax+0x7]
    13b8:	85 c0                	test   eax,eax
    13ba:	0f 48 c2             	cmovs  eax,edx
    13bd:	c1 f8 03             	sar    eax,0x3
    13c0:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
    13c3:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    13c6:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
    13c9:	0f 94 c0             	sete   al
    13cc:	0f b6 c0             	movzx  eax,al
    13cf:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
				ssize_t rmax, bitc, btt = min(64, 32 * px_x);
    13d2:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    13d5:	c1 e0 05             	shl    eax,0x5
    13d8:	ba 40 00 00 00       	mov    edx,0x40
    13dd:	39 d0                	cmp    eax,edx
    13df:	0f 4f c2             	cmovg  eax,edx
    13e2:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
				r = p0_x % 8;
    13e5:	8b 55 1c             	mov    edx,DWORD PTR [ebp+0x1c]
    13e8:	89 d0                	mov    eax,edx
    13ea:	c1 f8 1f             	sar    eax,0x1f
    13ed:	c1 e8 1d             	shr    eax,0x1d
    13f0:	01 c2                	add    edx,eax
    13f2:	83 e2 07             	and    edx,0x7
    13f5:	29 c2                	sub    edx,eax
    13f7:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
				rmax = min(8, r + min(2, px_x)); /* only 2 pixels */
    13fa:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    13fd:	ba 02 00 00 00       	mov    edx,0x2
    1402:	39 d0                	cmp    eax,edx
    1404:	0f 4e d0             	cmovle edx,eax
    1407:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    140a:	01 d0                	add    eax,edx
    140c:	ba 08 00 00 00       	mov    edx,0x8
    1411:	39 d0                	cmp    eax,edx
    1413:	0f 4f c2             	cmovg  eax,edx
    1416:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
				/* get the remaining character pixels */
				bitc = generate_char_colors(font, str[0], str[1], 32,
    1419:	8b 4d b4             	mov    ecx,DWORD PTR [ebp-0x4c]
    141c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    141f:	83 c0 01             	add    eax,0x1
    1422:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1425:	0f be d0             	movsx  edx,al
    1428:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    142b:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    142e:	0f be c0             	movsx  eax,al
    1431:	8b 5d d0             	mov    ebx,DWORD PTR [ebp-0x30]
    1434:	89 5c 24 1c          	mov    DWORD PTR [esp+0x1c],ebx
    1438:	89 4c 24 18          	mov    DWORD PTR [esp+0x18],ecx
    143c:	8b 4d c8             	mov    ecx,DWORD PTR [ebp-0x38]
    143f:	89 4c 24 14          	mov    DWORD PTR [esp+0x14],ecx
    1443:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
    1446:	89 4c 24 10          	mov    DWORD PTR [esp+0x10],ecx
    144a:	c7 44 24 0c 20 00 00 00 	mov    DWORD PTR [esp+0xc],0x20
    1452:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    1456:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    145a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    145d:	89 04 24             	mov    DWORD PTR [esp],eax
    1460:	e8 fc ff ff ff       	call   1461 <render_text_scanline_32btpp+0x214>
    1465:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
								r, rmax, pixbuf, inv);
				/* now advance if neccessary */
				if (rmax == 8)
    1468:	83 7d c8 08          	cmp    DWORD PTR [ebp-0x38],0x8
    146c:	75 04                	jne    1472 <render_text_scanline_32btpp+0x225>
						str += 2;
    146e:	83 45 0c 02          	add    DWORD PTR [ebp+0xc],0x2
				/* and fetch one more pixel if needed (r=0) */
				if (bitc < btt) {
    1472:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1475:	3b 45 cc             	cmp    eax,DWORD PTR [ebp-0x34]
    1478:	7d 67                	jge    14e1 <render_text_scanline_32btpp+0x294>
						col++;
    147a:	83 45 d4 01          	add    DWORD PTR [ebp-0x2c],0x1
						inv = (col == cur_x);
    147e:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1481:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
    1484:	0f 94 c0             	sete   al
    1487:	0f b6 c0             	movzx  eax,al
    148a:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
						bitc += generate_char_colors(font, str[0], str[1], 32,
    148d:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    1490:	8d 58 04             	lea    ebx,[eax+0x4]
    1493:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1496:	83 c0 01             	add    eax,0x1
    1499:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    149c:	0f be d0             	movsx  edx,al
    149f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    14a2:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    14a5:	0f be c0             	movsx  eax,al
    14a8:	8b 4d d0             	mov    ecx,DWORD PTR [ebp-0x30]
    14ab:	89 4c 24 1c          	mov    DWORD PTR [esp+0x1c],ecx
    14af:	89 5c 24 18          	mov    DWORD PTR [esp+0x18],ebx
    14b3:	c7 44 24 14 01 00 00 00 	mov    DWORD PTR [esp+0x14],0x1
    14bb:	c7 44 24 10 00 00 00 00 	mov    DWORD PTR [esp+0x10],0x0
    14c3:	c7 44 24 0c 20 00 00 00 	mov    DWORD PTR [esp+0xc],0x20
    14cb:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    14cf:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    14d3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    14d6:	89 04 24             	mov    DWORD PTR [esp],eax
    14d9:	e8 fc ff ff ff       	call   14da <render_text_scanline_32btpp+0x28d>
    14de:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
										0, 1, pixbuf + 4, inv);
				}
				/* now transfer */
				if (bitc >= 64) {
    14e1:	83 7d f4 3f          	cmp    DWORD PTR [ebp-0xc],0x3f
    14e5:	7e 21                	jle    1508 <render_text_scanline_32btpp+0x2bb>
						move_64(pixbuf, mem);
    14e7:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    14ea:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
    14ed:	0f 6f 00             	movq   mm0,QWORD PTR [eax]
    14f0:	0f 7f 02             	movq   QWORD PTR [edx],mm0
						mem += 8; /* intentionally no bitc subtract */
    14f3:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    14f6:	83 c0 08             	add    eax,0x8
    14f9:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
						}
						break;
				}

				/* and don't advance as r = 0 is already handled (sth. remains) */
				if (px_x) {
    14fc:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
    1500:	0f 84 80 00 00 00    	je     1586 <render_text_scanline_32btpp+0x339>
    1506:	eb 4e                	jmp    1556 <render_text_scanline_32btpp+0x309>
						if (bitc >= 32) {
    1508:	83 7d f4 1f          	cmp    DWORD PTR [ebp-0xc],0x1f
    150c:	7e 19                	jle    1527 <render_text_scanline_32btpp+0x2da>
								*(uint32_t*)mem = *(uint32_t*)pixbuf;
    150e:	8b 55 b4             	mov    edx,DWORD PTR [ebp-0x4c]
    1511:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1514:	8b 12                	mov    edx,DWORD PTR [edx]
    1516:	89 10                	mov    DWORD PTR [eax],edx
								mem += 4;
    1518:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    151b:	83 c0 04             	add    eax,0x4
    151e:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
								bitc -= 32;
    1521:	83 6d f4 20          	sub    DWORD PTR [ebp-0xc],0x20
						break;
    1525:	eb 62                	jmp    1589 <render_text_scanline_32btpp+0x33c>
						} else if (bitc) {
    1527:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    152b:	74 5c                	je     1589 <render_text_scanline_32btpp+0x33c>
								die("cant happen with dword sized pixels!\n");
    152d:	c7 44 24 04 1c 01 00 00 	mov    DWORD PTR [esp+0x4],0x11c
    1535:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    153c:	e8 fc ff ff ff       	call   153d <render_text_scanline_32btpp+0x2f0>
    1541:	e8 fc ff ff ff       	call   1542 <render_text_scanline_32btpp+0x2f5>
    1546:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    154d:	e8 fc ff ff ff       	call   154e <render_text_scanline_32btpp+0x301>
    1552:	fa                   	cli
    1553:	f4                   	hlt
    1554:	eb fd                	jmp    1553 <render_text_scanline_32btpp+0x306>
						px_x -= bitc / 32;
    1556:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1559:	8d 50 1f             	lea    edx,[eax+0x1f]
    155c:	85 c0                	test   eax,eax
    155e:	0f 48 c2             	cmovs  eax,edx
    1561:	c1 f8 05             	sar    eax,0x5
    1564:	f7 d8                	neg    eax
    1566:	01 45 14             	add    DWORD PTR [ebp+0x14],eax
						p0_x += bitc / 32; /* unneccessary as r does not change anymore */
    1569:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    156c:	8d 50 1f             	lea    edx,[eax+0x1f]
    156f:	85 c0                	test   eax,eax
    1571:	0f 48 c2             	cmovs  eax,edx
    1574:	c1 f8 05             	sar    eax,0x5
    1577:	01 45 1c             	add    DWORD PTR [ebp+0x1c],eax
		while (px_x) {
    157a:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
    157e:	0f 85 2e fe ff ff    	jne    13b2 <render_text_scanline_32btpp+0x165>
				} else
						break;
		}
}
    1584:	eb 04                	jmp    158a <render_text_scanline_32btpp+0x33d>
						break;
    1586:	90                   	nop
    1587:	eb 01                	jmp    158a <render_text_scanline_32btpp+0x33d>
						break;
    1589:	90                   	nop
}
    158a:	90                   	nop
    158b:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    158e:	c9                   	leave
    158f:	c3                   	ret

00001590 <render_text_scanline_8btpp>:

/* ~32 times better performance than /w byte access in old method below */
void render_text_scanline_8btpp(const char* font, char* str, void* mem,
				ssize_t px_x, ssize_t cur_x, ssize_t p0_x)
{
    1590:	55                   	push   ebp
    1591:	89 e5                	mov    ebp,esp
    1593:	56                   	push   esi
    1594:	53                   	push   ebx
    1595:	83 ec 70             	sub    esp,0x70
		uint8_t pxb[8 + 7]; /* for any stack alignment */
		ssize_t misalign = ((size_t)mem % 8) ? (8 - (size_t)mem % 8) : 0;
    1598:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    159b:	83 e0 07             	and    eax,0x7
    159e:	85 c0                	test   eax,eax
    15a0:	74 11                	je     15b3 <render_text_scanline_8btpp+0x23>
    15a2:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    15a5:	83 e0 07             	and    eax,0x7
    15a8:	ba 08 00 00 00       	mov    edx,0x8
    15ad:	29 c2                	sub    edx,eax
    15af:	89 d0                	mov    eax,edx
    15b1:	eb 05                	jmp    15b8 <render_text_scanline_8btpp+0x28>
    15b3:	b8 00 00 00 00       	mov    eax,0x0
    15b8:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		ssize_t r = p0_x % 8;
    15bb:	8b 55 1c             	mov    edx,DWORD PTR [ebp+0x1c]
    15be:	89 d0                	mov    eax,edx
    15c0:	c1 f8 1f             	sar    eax,0x1f
    15c3:	c1 e8 1d             	shr    eax,0x1d
    15c6:	01 c2                	add    edx,eax
    15c8:	83 e2 07             	and    edx,0x7
    15cb:	29 c2                	sub    edx,eax
    15cd:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
		uint8_t* pixbuf = pxb + (((size_t)pxb % 8) ? (8 - ((size_t)pxb % 8)) : 0);
    15d0:	8d 45 b1             	lea    eax,[ebp-0x4f]
    15d3:	83 e0 07             	and    eax,0x7
    15d6:	85 c0                	test   eax,eax
    15d8:	74 11                	je     15eb <render_text_scanline_8btpp+0x5b>
    15da:	8d 45 b1             	lea    eax,[ebp-0x4f]
    15dd:	83 e0 07             	and    eax,0x7
    15e0:	89 c2                	mov    edx,eax
    15e2:	b8 08 00 00 00       	mov    eax,0x8
    15e7:	29 d0                	sub    eax,edx
    15e9:	eb 05                	jmp    15f0 <render_text_scanline_8btpp+0x60>
    15eb:	b8 00 00 00 00       	mov    eax,0x0
    15f0:	8d 55 b1             	lea    edx,[ebp-0x4f]
    15f3:	01 d0                	add    eax,edx
    15f5:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
		/* 64-bit aligned moves are enough */

		if (misalign) { /* we first have to draw misalign pixels */
    15f8:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    15fc:	0f 84 77 03 00 00    	je     1979 <render_text_scanline_8btpp+0x3e9>
				int col = p0_x / 8, inv = (col == cur_x);
    1602:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
    1605:	8d 50 07             	lea    edx,[eax+0x7]
    1608:	85 c0                	test   eax,eax
    160a:	0f 48 c2             	cmovs  eax,edx
    160d:	c1 f8 03             	sar    eax,0x3
    1610:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1613:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1616:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
    1619:	0f 94 c0             	sete   al
    161c:	0f b6 c0             	movzx  eax,al
    161f:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
				ssize_t bc = min(misalign, px_x); /* r already set */
    1622:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
    1625:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1628:	39 c2                	cmp    edx,eax
    162a:	0f 4e c2             	cmovle eax,edx
    162d:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
				ssize_t rmax = min(8, r + bc), bc1 = rmax - r;
    1630:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    1633:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1636:	01 d0                	add    eax,edx
    1638:	ba 08 00 00 00       	mov    edx,0x8
    163d:	39 d0                	cmp    eax,edx
    163f:	0f 4f c2             	cmovg  eax,edx
    1642:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
    1645:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1648:	2b 45 e4             	sub    eax,DWORD PTR [ebp-0x1c]
    164b:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax

				generate_char_colors(font, str[0], str[1], 8,
    164e:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    1651:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1654:	83 c0 01             	add    eax,0x1
    1657:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    165a:	0f be d0             	movsx  edx,al
    165d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1660:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1663:	0f be c0             	movsx  eax,al
    1666:	8b 5d dc             	mov    ebx,DWORD PTR [ebp-0x24]
    1669:	89 5c 24 1c          	mov    DWORD PTR [esp+0x1c],ebx
    166d:	89 4c 24 18          	mov    DWORD PTR [esp+0x18],ecx
    1671:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
    1674:	89 4c 24 14          	mov    DWORD PTR [esp+0x14],ecx
    1678:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
    167b:	89 4c 24 10          	mov    DWORD PTR [esp+0x10],ecx
    167f:	c7 44 24 0c 08 00 00 00 	mov    DWORD PTR [esp+0xc],0x8
    1687:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    168b:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    168f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1692:	89 04 24             	mov    DWORD PTR [esp],eax
    1695:	e8 fc ff ff ff       	call   1696 <render_text_scanline_8btpp+0x106>
								r, rmax, pixbuf, inv);
				if (rmax == 8)
    169a:	83 7d d4 08          	cmp    DWORD PTR [ebp-0x2c],0x8
    169e:	75 04                	jne    16a4 <render_text_scanline_8btpp+0x114>
						str += 2;
    16a0:	83 45 0c 02          	add    DWORD PTR [ebp+0xc],0x2
				if (bc > bc1) {
    16a4:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    16a7:	3b 45 d0             	cmp    eax,DWORD PTR [ebp-0x30]
    16aa:	7e 6b                	jle    1717 <render_text_scanline_8btpp+0x187>
						col++;
    16ac:	83 45 e0 01          	add    DWORD PTR [ebp-0x20],0x1
						inv = (col == cur_x);
    16b0:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    16b3:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
    16b6:	0f 94 c0             	sete   al
    16b9:	0f b6 c0             	movzx  eax,al
    16bc:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
						generate_char_colors(font, str[0], str[1], 8,
    16bf:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
    16c2:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    16c5:	8d 34 02             	lea    esi,[edx+eax*1]
    16c8:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    16cb:	2b 45 d0             	sub    eax,DWORD PTR [ebp-0x30]
    16ce:	89 c1                	mov    ecx,eax
    16d0:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    16d3:	83 c0 01             	add    eax,0x1
    16d6:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    16d9:	0f be d0             	movsx  edx,al
    16dc:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    16df:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    16e2:	0f be c0             	movsx  eax,al
    16e5:	8b 5d dc             	mov    ebx,DWORD PTR [ebp-0x24]
    16e8:	89 5c 24 1c          	mov    DWORD PTR [esp+0x1c],ebx
    16ec:	89 74 24 18          	mov    DWORD PTR [esp+0x18],esi
    16f0:	89 4c 24 14          	mov    DWORD PTR [esp+0x14],ecx
    16f4:	c7 44 24 10 00 00 00 00 	mov    DWORD PTR [esp+0x10],0x0
    16fc:	c7 44 24 0c 08 00 00 00 	mov    DWORD PTR [esp+0xc],0x8
    1704:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    1708:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    170c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    170f:	89 04 24             	mov    DWORD PTR [esp],eax
    1712:	e8 fc ff ff ff       	call   1713 <render_text_scanline_8btpp+0x183>
										0, bc - bc1, pixbuf + bc1, inv);
				}
				memcpy(mem, pixbuf, bc);
    1717:	8b 4d d8             	mov    ecx,DWORD PTR [ebp-0x28]
    171a:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
    171d:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1720:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
    1724:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1728:	89 04 24             	mov    DWORD PTR [esp],eax
    172b:	e8 d0 e8 ff ff       	call   0 <memcpy>
				px_x -= bc;
    1730:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1733:	29 45 14             	sub    DWORD PTR [ebp+0x14],eax
				p0_x += bc;
    1736:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1739:	01 45 1c             	add    DWORD PTR [ebp+0x1c],eax
				mem += bc;
    173c:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
    173f:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1742:	01 d0                	add    eax,edx
    1744:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
		}

		/* now we can draw 8 pixels each */
		while (px_x) {
    1747:	e9 2d 02 00 00       	jmp    1979 <render_text_scanline_8btpp+0x3e9>
				int col = p0_x / 8, inv = (col == cur_x);
    174c:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
    174f:	8d 50 07             	lea    edx,[eax+0x7]
    1752:	85 c0                	test   eax,eax
    1754:	0f 48 c2             	cmovs  eax,edx
    1757:	c1 f8 03             	sar    eax,0x3
    175a:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
    175d:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1760:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
    1763:	0f 94 c0             	sete   al
    1766:	0f b6 c0             	movzx  eax,al
    1769:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
				ssize_t rmax, bitc, btt = min(64, 8 * px_x), cc;
    176c:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    176f:	c1 e0 03             	shl    eax,0x3
    1772:	ba 40 00 00 00       	mov    edx,0x40
    1777:	39 d0                	cmp    eax,edx
    1779:	0f 4f c2             	cmovg  eax,edx
    177c:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
				r = p0_x % 8;
    177f:	8b 55 1c             	mov    edx,DWORD PTR [ebp+0x1c]
    1782:	89 d0                	mov    eax,edx
    1784:	c1 f8 1f             	sar    eax,0x1f
    1787:	c1 e8 1d             	shr    eax,0x1d
    178a:	01 c2                	add    edx,eax
    178c:	83 e2 07             	and    edx,0x7
    178f:	29 c2                	sub    edx,eax
    1791:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
				rmax = min(8, r + px_x);
    1794:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    1797:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    179a:	01 d0                	add    eax,edx
    179c:	ba 08 00 00 00       	mov    edx,0x8
    17a1:	39 d0                	cmp    eax,edx
    17a3:	0f 4f c2             	cmovg  eax,edx
    17a6:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
				/* get the remaining character pixels */
				bitc = generate_char_colors(font, str[0], str[1], 8,
    17a9:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    17ac:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    17af:	83 c0 01             	add    eax,0x1
    17b2:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    17b5:	0f be d0             	movsx  edx,al
    17b8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    17bb:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    17be:	0f be c0             	movsx  eax,al
    17c1:	8b 5d c8             	mov    ebx,DWORD PTR [ebp-0x38]
    17c4:	89 5c 24 1c          	mov    DWORD PTR [esp+0x1c],ebx
    17c8:	89 4c 24 18          	mov    DWORD PTR [esp+0x18],ecx
    17cc:	8b 4d c0             	mov    ecx,DWORD PTR [ebp-0x40]
    17cf:	89 4c 24 14          	mov    DWORD PTR [esp+0x14],ecx
    17d3:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
    17d6:	89 4c 24 10          	mov    DWORD PTR [esp+0x10],ecx
    17da:	c7 44 24 0c 08 00 00 00 	mov    DWORD PTR [esp+0xc],0x8
    17e2:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    17e6:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    17ea:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    17ed:	89 04 24             	mov    DWORD PTR [esp],eax
    17f0:	e8 fc ff ff ff       	call   17f1 <render_text_scanline_8btpp+0x261>
    17f5:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
								r, rmax, pixbuf, inv);
				/* now advance */
				str += 2;
    17f8:	83 45 0c 02          	add    DWORD PTR [ebp+0xc],0x2
				cc = bitc / 8;
    17fc:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    17ff:	8d 50 07             	lea    edx,[eax+0x7]
    1802:	85 c0                	test   eax,eax
    1804:	0f 48 c2             	cmovs  eax,edx
    1807:	c1 f8 03             	sar    eax,0x3
    180a:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				/* and fetch more pixels if needed (r=0) */
				if (bitc < btt) {
    180d:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1810:	3b 45 c4             	cmp    eax,DWORD PTR [ebp-0x3c]
    1813:	0f 8d 8d 00 00 00    	jge    18a6 <render_text_scanline_8btpp+0x316>
						col++;
    1819:	83 45 cc 01          	add    DWORD PTR [ebp-0x34],0x1
						inv = (col == cur_x);
    181d:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1820:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
    1823:	0f 94 c0             	sete   al
    1826:	0f b6 c0             	movzx  eax,al
    1829:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
						bitc += generate_char_colors(font, str[0], str[1], 8,
    182c:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
    182f:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1832:	8d 34 02             	lea    esi,[edx+eax*1]
    1835:	83 7d 14 08          	cmp    DWORD PTR [ebp+0x14],0x8
    1839:	7e 0a                	jle    1845 <render_text_scanline_8btpp+0x2b5>
    183b:	b8 08 00 00 00       	mov    eax,0x8
    1840:	2b 45 f0             	sub    eax,DWORD PTR [ebp-0x10]
    1843:	eb 06                	jmp    184b <render_text_scanline_8btpp+0x2bb>
    1845:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1848:	2b 45 f0             	sub    eax,DWORD PTR [ebp-0x10]
    184b:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    184e:	83 c2 01             	add    edx,0x1
    1851:	0f b6 12             	movzx  edx,BYTE PTR [edx]
    1854:	0f be ca             	movsx  ecx,dl
    1857:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    185a:	0f b6 12             	movzx  edx,BYTE PTR [edx]
    185d:	0f be d2             	movsx  edx,dl
    1860:	8b 5d c8             	mov    ebx,DWORD PTR [ebp-0x38]
    1863:	89 5c 24 1c          	mov    DWORD PTR [esp+0x1c],ebx
    1867:	89 74 24 18          	mov    DWORD PTR [esp+0x18],esi
    186b:	89 44 24 14          	mov    DWORD PTR [esp+0x14],eax
    186f:	c7 44 24 10 00 00 00 00 	mov    DWORD PTR [esp+0x10],0x0
    1877:	c7 44 24 0c 08 00 00 00 	mov    DWORD PTR [esp+0xc],0x8
    187f:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
    1883:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1887:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    188a:	89 04 24             	mov    DWORD PTR [esp],eax
    188d:	e8 fc ff ff ff       	call   188e <render_text_scanline_8btpp+0x2fe>
    1892:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
										0, min(8 - cc, px_x - cc), pixbuf + cc, inv);
						cc = bitc / 8;
    1895:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1898:	8d 50 07             	lea    edx,[eax+0x7]
    189b:	85 c0                	test   eax,eax
    189d:	0f 48 c2             	cmovs  eax,edx
    18a0:	c1 f8 03             	sar    eax,0x3
    18a3:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				}
				/* now transfer */
				if (bitc >= 64) {
    18a6:	83 7d f4 3f          	cmp    DWORD PTR [ebp-0xc],0x3f
    18aa:	7e 24                	jle    18d0 <render_text_scanline_8btpp+0x340>
						move_64(pixbuf, mem);
    18ac:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    18af:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
    18b2:	0f 6f 00             	movq   mm0,QWORD PTR [eax]
    18b5:	0f 7f 02             	movq   QWORD PTR [edx],mm0
						mem += 8; /* intentionally no bitc subtract */
    18b8:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    18bb:	83 c0 08             	add    eax,0x8
    18be:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
						}
						break;
				}

				/* and don't advance as r = 0 is already handled (sth. remains) */
				if (px_x) {
    18c1:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
    18c5:	0f 84 ba 00 00 00    	je     1985 <render_text_scanline_8btpp+0x3f5>
    18cb:	e9 9d 00 00 00       	jmp    196d <render_text_scanline_8btpp+0x3dd>
						uint8_t* pt = pixbuf;
    18d0:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    18d3:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
						if (bitc >= 32) {
    18d6:	83 7d f4 1f          	cmp    DWORD PTR [ebp-0xc],0x1f
    18da:	7e 1b                	jle    18f7 <render_text_scanline_8btpp+0x367>
								*(uint32_t*)mem = *(uint32_t*)pixbuf;
    18dc:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
    18df:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    18e2:	8b 12                	mov    edx,DWORD PTR [edx]
    18e4:	89 10                	mov    DWORD PTR [eax],edx
								pt += 4;
    18e6:	83 45 ec 04          	add    DWORD PTR [ebp-0x14],0x4
								mem += 4;
    18ea:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    18ed:	83 c0 04             	add    eax,0x4
    18f0:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
								bitc -= 32;
    18f3:	83 6d f4 20          	sub    DWORD PTR [ebp-0xc],0x20
						if (bitc >= 16) {
    18f7:	83 7d f4 0f          	cmp    DWORD PTR [ebp-0xc],0xf
    18fb:	7e 1d                	jle    191a <render_text_scanline_8btpp+0x38a>
								*(uint16_t*)mem = *(uint16_t*)pt;
    18fd:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1900:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1903:	0f b7 12             	movzx  edx,WORD PTR [edx]
    1906:	66 89 10             	mov    WORD PTR [eax],dx
								pt += 2;
    1909:	83 45 ec 02          	add    DWORD PTR [ebp-0x14],0x2
								mem += 2;
    190d:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1910:	83 c0 02             	add    eax,0x2
    1913:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
								bitc -= 16;
    1916:	83 6d f4 10          	sub    DWORD PTR [ebp-0xc],0x10
						if (bitc >= 8) {
    191a:	83 7d f4 07          	cmp    DWORD PTR [ebp-0xc],0x7
    191e:	7e 1e                	jle    193e <render_text_scanline_8btpp+0x3ae>
								*(uint8_t*)mem = *(uint8_t*)pt;
    1920:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1923:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1926:	0f b6 12             	movzx  edx,BYTE PTR [edx]
    1929:	88 10                	mov    BYTE PTR [eax],dl
								pt += 1;
    192b:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
								mem += 1;
    192f:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1932:	83 c0 01             	add    eax,0x1
    1935:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
								bitc -= 8;
    1938:	83 6d f4 08          	sub    DWORD PTR [ebp-0xc],0x8
						break;
    193c:	eb 4a                	jmp    1988 <render_text_scanline_8btpp+0x3f8>
						} else if (bitc) {
    193e:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1942:	74 44                	je     1988 <render_text_scanline_8btpp+0x3f8>
								die("cant happen with byte sized pixels!\n");
    1944:	c7 44 24 04 94 01 00 00 	mov    DWORD PTR [esp+0x4],0x194
    194c:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    1953:	e8 fc ff ff ff       	call   1954 <render_text_scanline_8btpp+0x3c4>
    1958:	e8 fc ff ff ff       	call   1959 <render_text_scanline_8btpp+0x3c9>
    195d:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1964:	e8 fc ff ff ff       	call   1965 <render_text_scanline_8btpp+0x3d5>
    1969:	fa                   	cli
    196a:	f4                   	hlt
    196b:	eb fd                	jmp    196a <render_text_scanline_8btpp+0x3da>
						px_x -= cc;
    196d:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1970:	29 45 14             	sub    DWORD PTR [ebp+0x14],eax
						p0_x += cc; /* unneccessary as r does not change anymore */
    1973:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1976:	01 45 1c             	add    DWORD PTR [ebp+0x1c],eax
		while (px_x) {
    1979:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
    197d:	0f 85 c9 fd ff ff    	jne    174c <render_text_scanline_8btpp+0x1bc>
				} else
						break;
		}
}
    1983:	eb 04                	jmp    1989 <render_text_scanline_8btpp+0x3f9>
						break;
    1985:	90                   	nop
    1986:	eb 01                	jmp    1989 <render_text_scanline_8btpp+0x3f9>
						break;
    1988:	90                   	nop
}
    1989:	90                   	nop
    198a:	83 c4 70             	add    esp,0x70
    198d:	5b                   	pop    ebx
    198e:	5e                   	pop    esi
    198f:	5d                   	pop    ebp
    1990:	c3                   	ret

00001991 <render_text>:
/* this function uses pixel addressing for width and height
 * making it possible to render half/overlapping characters.
 */
void render_text(const char* font, char* str, void* mem, size_t text_stride, size_t mem_stride,
		size_t btpp, ssize_t px_x, ssize_t px_y, int starts_half, int cur_x, int cur_y, ssize_t p0_x, ssize_t p0_y)
{
    1991:	55                   	push   ebp
    1992:	89 e5                	mov    ebp,esp
    1994:	83 ec 38             	sub    esp,0x38
		(void)starts_half;
//		char is_half = 0, ends_half = 0;
		/* pixel offset is handled before calling the function */
//		is_half = starts_half;
//		ends_half = (px_x % 2) ? (!starts_half) : (starts_half);
		for (ssize_t ln = p0_y; ln < px_y + p0_y; ln++) {
    1997:	8b 45 38             	mov    eax,DWORD PTR [ebp+0x38]
    199a:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    199d:	e9 fc 01 00 00       	jmp    1b9e <render_text+0x20d>
				ssize_t l = ln % 16; ssize_t cur_xv;
    19a2:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    19a5:	89 d0                	mov    eax,edx
    19a7:	c1 f8 1f             	sar    eax,0x1f
    19aa:	c1 e8 1c             	shr    eax,0x1c
    19ad:	01 c2                	add    edx,eax
    19af:	83 e2 0f             	and    edx,0xf
    19b2:	29 c2                	sub    edx,eax
    19b4:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx

				/* check cursor */
				if (ln / 16 == cur_y)
    19b7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    19ba:	8d 50 0f             	lea    edx,[eax+0xf]
    19bd:	85 c0                	test   eax,eax
    19bf:	0f 48 c2             	cmovs  eax,edx
    19c2:	c1 f8 04             	sar    eax,0x4
    19c5:	39 45 30             	cmp    DWORD PTR [ebp+0x30],eax
    19c8:	75 08                	jne    19d2 <render_text+0x41>
						cur_xv = cur_x;
    19ca:	8b 45 2c             	mov    eax,DWORD PTR [ebp+0x2c]
    19cd:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    19d0:	eb 07                	jmp    19d9 <render_text+0x48>
				else
						cur_xv = -1;
    19d2:	c7 45 f0 ff ff ff ff 	mov    DWORD PTR [ebp-0x10],0xffffffff

				/* invoke the scanline drawing routines */
				switch (btpp) {
    19d9:	83 7d 1c 20          	cmp    DWORD PTR [ebp+0x1c],0x20
    19dd:	74 46                	je     1a25 <render_text+0x94>
    19df:	83 7d 1c 20          	cmp    DWORD PTR [ebp+0x1c],0x20
    19e3:	0f 87 75 01 00 00    	ja     1b5e <render_text+0x1cd>
    19e9:	83 7d 1c 18          	cmp    DWORD PTR [ebp+0x1c],0x18
    19ed:	0f 84 b0 00 00 00    	je     1aa3 <render_text+0x112>
    19f3:	83 7d 1c 18          	cmp    DWORD PTR [ebp+0x1c],0x18
    19f7:	0f 87 61 01 00 00    	ja     1b5e <render_text+0x1cd>
    19fd:	83 7d 1c 08          	cmp    DWORD PTR [ebp+0x1c],0x8
    1a01:	0f 84 22 01 00 00    	je     1b29 <render_text+0x198>
    1a07:	83 7d 1c 08          	cmp    DWORD PTR [ebp+0x1c],0x8
    1a0b:	0f 82 4d 01 00 00    	jb     1b5e <render_text+0x1cd>
    1a11:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
    1a14:	83 e8 0f             	sub    eax,0xf
    1a17:	83 f8 01             	cmp    eax,0x1
    1a1a:	0f 87 3e 01 00 00    	ja     1b5e <render_text+0x1cd>
    1a20:	e9 c8 00 00 00       	jmp    1aed <render_text+0x15c>
						case 32:
								if (cpu.has_sse)
    1a25:	0f b6 05 5b 00 00 00 	movzx  eax,BYTE PTR ds:0x5b
    1a2c:	83 e0 02             	and    eax,0x2
    1a2f:	84 c0                	test   al,al
    1a31:	74 38                	je     1a6b <render_text+0xda>
										render_text_scanline_32btpp_sse(font + l, str,
    1a33:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1a36:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1a39:	01 c2                	add    edx,eax
    1a3b:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    1a3e:	89 44 24 14          	mov    DWORD PTR [esp+0x14],eax
    1a42:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1a45:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
    1a49:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
    1a4c:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    1a50:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1a53:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1a57:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1a5a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1a5e:	89 14 24             	mov    DWORD PTR [esp],edx
    1a61:	e8 fc ff ff ff       	call   1a62 <render_text+0xd1>
												mem, px_x, cur_xv, p0_x);
								else
										render_text_scanline_32btpp(font + l, str,
												mem, px_x, cur_xv, p0_x);
								break;
    1a66:	e9 1d 01 00 00       	jmp    1b88 <render_text+0x1f7>
										render_text_scanline_32btpp(font + l, str,
    1a6b:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1a6e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1a71:	01 c2                	add    edx,eax
    1a73:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    1a76:	89 44 24 14          	mov    DWORD PTR [esp+0x14],eax
    1a7a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1a7d:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
    1a81:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
    1a84:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    1a88:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1a8b:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1a8f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1a92:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1a96:	89 14 24             	mov    DWORD PTR [esp],edx
    1a99:	e8 fc ff ff ff       	call   1a9a <render_text+0x109>
								break;
    1a9e:	e9 e5 00 00 00       	jmp    1b88 <render_text+0x1f7>
						case 24: /* 16 bytes /w sse really needed */
								if (cpu.has_sse)
    1aa3:	0f b6 05 5b 00 00 00 	movzx  eax,BYTE PTR ds:0x5b
    1aaa:	83 e0 02             	and    eax,0x2
    1aad:	84 c0                	test   al,al
    1aaf:	0f 84 d2 00 00 00    	je     1b87 <render_text+0x1f6>
										render_text_scanline_24btpp_sse(font + l, str,
    1ab5:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1ab8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1abb:	01 c2                	add    edx,eax
    1abd:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    1ac0:	89 44 24 14          	mov    DWORD PTR [esp+0x14],eax
    1ac4:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1ac7:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
    1acb:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
    1ace:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    1ad2:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1ad5:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1ad9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1adc:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1ae0:	89 14 24             	mov    DWORD PTR [esp],edx
    1ae3:	e8 fc ff ff ff       	call   1ae4 <render_text+0x153>
												mem, px_x, cur_xv, p0_x);
								//else
								//		render_text_scanline_24btpp(font + l, str,
								//				mem, px_x, cur_xv, p0_x);
								break;
    1ae8:	e9 9a 00 00 00       	jmp    1b87 <render_text+0x1f6>
						case 15:
						case 16:
								render_text_scanline_16btpp(font + l, str,
    1aed:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1af0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1af3:	01 c2                	add    edx,eax
    1af5:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
    1af8:	89 44 24 18          	mov    DWORD PTR [esp+0x18],eax
    1afc:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    1aff:	89 44 24 14          	mov    DWORD PTR [esp+0x14],eax
    1b03:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1b06:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
    1b0a:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
    1b0d:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    1b11:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1b14:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1b18:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1b1b:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1b1f:	89 14 24             	mov    DWORD PTR [esp],edx
    1b22:	e8 fc ff ff ff       	call   1b23 <render_text+0x192>
												mem, px_x, cur_xv, p0_x, btpp);
								break;
    1b27:	eb 5f                	jmp    1b88 <render_text+0x1f7>
						case 8:
								render_text_scanline_8btpp(font + l, str,
    1b29:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1b2c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b2f:	01 c2                	add    edx,eax
    1b31:	8b 45 34             	mov    eax,DWORD PTR [ebp+0x34]
    1b34:	89 44 24 14          	mov    DWORD PTR [esp+0x14],eax
    1b38:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1b3b:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
    1b3f:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
    1b42:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    1b46:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1b49:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    1b4d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1b50:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1b54:	89 14 24             	mov    DWORD PTR [esp],edx
    1b57:	e8 fc ff ff ff       	call   1b58 <render_text+0x1c7>
												mem, px_x, cur_xv, p0_x);
								break;
    1b5c:	eb 2a                	jmp    1b88 <render_text+0x1f7>
						default:
/*								render_text_scanline_xbtpp(font + l, str, btpp,
												mem, px_x, cur_xv, p0_x);*/
								die("not impl\n");
    1b5e:	c7 44 24 04 b9 01 00 00 	mov    DWORD PTR [esp+0x4],0x1b9
    1b66:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    1b6d:	e8 fc ff ff ff       	call   1b6e <render_text+0x1dd>
    1b72:	e8 fc ff ff ff       	call   1b73 <render_text+0x1e2>
    1b77:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1b7e:	e8 fc ff ff ff       	call   1b7f <render_text+0x1ee>
    1b83:	fa                   	cli
    1b84:	f4                   	hlt
    1b85:	eb fd                	jmp    1b84 <render_text+0x1f3>
								break;
    1b87:	90                   	nop
								break;
				}

				/* advance */
				if (l == 15) {
    1b88:	83 7d ec 0f          	cmp    DWORD PTR [ebp-0x14],0xf
    1b8c:	75 06                	jne    1b94 <render_text+0x203>
						str += text_stride;
    1b8e:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1b91:	01 45 0c             	add    DWORD PTR [ebp+0xc],eax
				}
				mem += mem_stride;
    1b94:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
    1b97:	01 45 10             	add    DWORD PTR [ebp+0x10],eax
		for (ssize_t ln = p0_y; ln < px_y + p0_y; ln++) {
    1b9a:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    1b9e:	8b 55 24             	mov    edx,DWORD PTR [ebp+0x24]
    1ba1:	8b 45 38             	mov    eax,DWORD PTR [ebp+0x38]
    1ba4:	01 d0                	add    eax,edx
    1ba6:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
    1ba9:	0f 8c f3 fd ff ff    	jl     19a2 <render_text+0x11>
		}
}
    1baf:	90                   	nop
    1bb0:	90                   	nop
    1bb1:	c9                   	leave
    1bb2:	c3                   	ret

00001bb3 <add_stride>:
		ssize_t x1, x2;
};

/* adds stride and returns 1 if new element was needed */
int add_stride(struct stride* sb, size_t num, struct stride* s)
{
    1bb3:	55                   	push   ebp
    1bb4:	89 e5                	mov    ebp,esp
    1bb6:	53                   	push   ebx
    1bb7:	83 ec 24             	sub    esp,0x24
		/* assume sortedness (our insertions are sorted) */
		for (size_t i = 0; i < num; i++) {
    1bba:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    1bc1:	eb 7c                	jmp    1c3f <add_stride+0x8c>
				if (sb[i].x1 == s->x2) { /* extend below */
    1bc3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1bc6:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    1bcd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1bd0:	01 d0                	add    eax,edx
    1bd2:	8b 10                	mov    edx,DWORD PTR [eax]
    1bd4:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1bd7:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1bda:	39 c2                	cmp    edx,eax
    1bdc:	75 20                	jne    1bfe <add_stride+0x4b>
						sb[i].x1 = s->x1;
    1bde:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1be1:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    1be8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1beb:	01 c2                	add    edx,eax
    1bed:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1bf0:	8b 00                	mov    eax,DWORD PTR [eax]
    1bf2:	89 02                	mov    DWORD PTR [edx],eax
						return 0;
    1bf4:	b8 00 00 00 00       	mov    eax,0x0
    1bf9:	e9 08 01 00 00       	jmp    1d06 <add_stride+0x153>
				} else if (sb[i].x2 == s->x1) { /* extend above */
    1bfe:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1c01:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    1c08:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1c0b:	01 d0                	add    eax,edx
    1c0d:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1c10:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1c13:	8b 00                	mov    eax,DWORD PTR [eax]
    1c15:	39 c2                	cmp    edx,eax
    1c17:	75 22                	jne    1c3b <add_stride+0x88>
						sb[i].x2 = s->x2;
    1c19:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1c1c:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    1c23:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1c26:	01 c2                	add    edx,eax
    1c28:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1c2b:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1c2e:	89 42 04             	mov    DWORD PTR [edx+0x4],eax
						return 0;
    1c31:	b8 00 00 00 00       	mov    eax,0x0
    1c36:	e9 cb 00 00 00       	jmp    1d06 <add_stride+0x153>
		for (size_t i = 0; i < num; i++) {
    1c3b:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    1c3f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1c42:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
    1c45:	0f 82 78 ff ff ff    	jb     1bc3 <add_stride+0x10>
				}
		}
		/* insert sorted */
		for (size_t i = 0; i < num; i++)
    1c4b:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    1c52:	e9 81 00 00 00       	jmp    1cd8 <add_stride+0x125>
				if (sb[i].x1 < s->x2) {
    1c57:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1c5a:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    1c61:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1c64:	01 d0                	add    eax,edx
    1c66:	8b 10                	mov    edx,DWORD PTR [eax]
    1c68:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1c6b:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1c6e:	39 c2                	cmp    edx,eax
    1c70:	7d 62                	jge    1cd4 <add_stride+0x121>
						memmove(sb + i + 1, sb + i, (num - i) * sizeof(*s));
    1c72:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1c75:	2b 45 f0             	sub    eax,DWORD PTR [ebp-0x10]
    1c78:	8d 0c c5 00 00 00 00 	lea    ecx,[eax*8+0x0]
    1c7f:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1c82:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    1c89:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1c8c:	01 c2                	add    edx,eax
    1c8e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1c91:	83 c0 01             	add    eax,0x1
    1c94:	8d 1c c5 00 00 00 00 	lea    ebx,[eax*8+0x0]
    1c9b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1c9e:	01 d8                	add    eax,ebx
    1ca0:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
    1ca4:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1ca8:	89 04 24             	mov    DWORD PTR [esp],eax
    1cab:	e8 fc ff ff ff       	call   1cac <add_stride+0xf9>
						sb[i] = *s;
    1cb0:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1cb3:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    1cba:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1cbd:	8d 0c 02             	lea    ecx,[edx+eax*1]
    1cc0:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1cc3:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1cc6:	8b 00                	mov    eax,DWORD PTR [eax]
    1cc8:	89 01                	mov    DWORD PTR [ecx],eax
    1cca:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
						return 1;
    1ccd:	b8 01 00 00 00       	mov    eax,0x1
    1cd2:	eb 32                	jmp    1d06 <add_stride+0x153>
		for (size_t i = 0; i < num; i++)
    1cd4:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
    1cd8:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1cdb:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
    1cde:	0f 82 73 ff ff ff    	jb     1c57 <add_stride+0xa4>
				}
		/* element is last */
		sb[num] = *s;
    1ce4:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1ce7:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    1cee:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1cf1:	8d 0c 02             	lea    ecx,[edx+eax*1]
    1cf4:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1cf7:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1cfa:	8b 00                	mov    eax,DWORD PTR [eax]
    1cfc:	89 01                	mov    DWORD PTR [ecx],eax
    1cfe:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		return 1;
    1d01:	b8 01 00 00 00       	mov    eax,0x1
}
    1d06:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    1d09:	c9                   	leave
    1d0a:	c3                   	ret

00001d0b <framebuffer_redraw>:

uint64_t fb_rdt = 0;
/* redraws the complete screen */
void framebuffer_redraw_region(struct framebuffer* fb, struct kio_region* r);
void framebuffer_redraw(struct framebuffer* fb)
{
    1d0b:	55                   	push   ebp
    1d0c:	89 e5                	mov    ebp,esp
    1d0e:	83 ec 38             	sub    esp,0x38
		struct kio_region r = {0}; /* sse alignment */
    1d11:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
    1d18:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
    1d1f:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
    1d26:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    1d2d:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		r.lx = fb->chw_x; r.ly = fb->chw_y;
    1d34:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1d37:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    1d3a:	66 89 45 e8          	mov    WORD PTR [ebp-0x18],ax
    1d3e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1d41:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    1d44:	66 89 45 ea          	mov    WORD PTR [ebp-0x16],ax
		r.x = fb->cho_x; r.y = fb->cho_y;
    1d48:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1d4b:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
    1d4e:	66 89 45 e4          	mov    WORD PTR [ebp-0x1c],ax
    1d52:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1d55:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    1d58:	66 89 45 e6          	mov    WORD PTR [ebp-0x1a],ax
		framebuffer_redraw_region(fb, &r);
    1d5c:	8d 45 e4             	lea    eax,[ebp-0x1c]
    1d5f:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1d63:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1d66:	89 04 24             	mov    DWORD PTR [esp],eax
    1d69:	e8 fc ff ff ff       	call   1d6a <framebuffer_redraw+0x5f>
}
    1d6e:	90                   	nop
    1d6f:	c9                   	leave
    1d70:	c3                   	ret

00001d71 <framebuffer_redraw_region>:

/* redraws a defined region (screen relative, not buffer, internal) */
void framebuffer_redraw_region(struct framebuffer* fb, struct kio_region* r)
{
    1d71:	55                   	push   ebp
    1d72:	89 e5                	mov    ebp,esp
    1d74:	57                   	push   edi
    1d75:	56                   	push   esi
    1d76:	53                   	push   ebx
    1d77:	81 ec dc 01 00 00    	sub    esp,0x1dc
		if (vga_mem_ptr == fb->text_mem)
    1d7d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1d80:	8b 10                	mov    edx,DWORD PTR [eax]
    1d82:	a1 00 00 00 00       	mov    eax,ds:0x0
    1d87:	39 c2                	cmp    edx,eax
    1d89:	0f 84 42 0c 00 00    	je     29d1 <framebuffer_redraw_region+0xc60>
				return; /* don't do anything if we're directly on video memory */
		else if (video_mode.is_textmode) {
    1d8f:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
    1d96:	84 c0                	test   al,al
    1d98:	0f 84 74 03 00 00    	je     2112 <framebuffer_redraw_region+0x3a1>
				if (video_mode.width == fb->width && fb->chw_x == fb->width
    1d9e:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    1da4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1da7:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1daa:	39 c2                	cmp    edx,eax
    1dac:	0f 85 61 01 00 00    	jne    1f13 <framebuffer_redraw_region+0x1a2>
    1db2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1db5:	8b 50 2c             	mov    edx,DWORD PTR [eax+0x2c]
    1db8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1dbb:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1dbe:	39 c2                	cmp    edx,eax
    1dc0:	0f 85 4d 01 00 00    	jne    1f13 <framebuffer_redraw_region+0x1a2>
							   && r->lx == fb->width && !fb->pix_x) {
    1dc6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1dc9:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
    1dcd:	0f bf d0             	movsx  edx,ax
    1dd0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1dd3:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1dd6:	39 c2                	cmp    edx,eax
    1dd8:	0f 85 35 01 00 00    	jne    1f13 <framebuffer_redraw_region+0x1a2>
    1dde:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1de1:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    1de4:	85 c0                	test   eax,eax
    1de6:	0f 85 27 01 00 00    	jne    1f13 <framebuffer_redraw_region+0x1a2>
						ssize_t nl;
						/* super easy memory transfer */
						fb->cho_x = 0;
    1dec:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1def:	c7 40 24 00 00 00 00 	mov    DWORD PTR [eax+0x24],0x0
						nl = min(min(video_mode.height - fb->pix_y, fb->chw_y),
    1df6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1df9:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
    1dfd:	0f bf d0             	movsx  edx,ax
    1e00:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1e03:	8b 58 08             	mov    ebx,DWORD PTR [eax+0x8]
    1e06:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1e09:	8b 48 28             	mov    ecx,DWORD PTR [eax+0x28]
    1e0c:	89 d8                	mov    eax,ebx
    1e0e:	29 c8                	sub    eax,ecx
    1e10:	39 c2                	cmp    edx,eax
    1e12:	0f 4f d0             	cmovg  edx,eax
    1e15:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1e18:	8b 48 30             	mov    ecx,DWORD PTR [eax+0x30]
    1e1b:	8b 35 08 00 00 00    	mov    esi,DWORD PTR ds:0x8
    1e21:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1e24:	8b 58 20             	mov    ebx,DWORD PTR [eax+0x20]
    1e27:	89 f0                	mov    eax,esi
    1e29:	29 d8                	sub    eax,ebx
    1e2b:	39 c1                	cmp    ecx,eax
    1e2d:	0f 4e c1             	cmovle eax,ecx
    1e30:	39 c2                	cmp    edx,eax
    1e32:	0f 4e c2             	cmovle eax,edx
    1e35:	89 45 90             	mov    DWORD PTR [ebp-0x70],eax
										min(fb->height - fb->cho_y, r->ly));
						memcpy(vga_mem_ptr + (fb->pix_y + r->y) * 2 * video_mode.width,
										fb->text_mem + (fb->cho_y + r->y) * 2
										* fb->width, nl * 2 * fb->width);
    1e38:	8b 45 90             	mov    eax,DWORD PTR [ebp-0x70]
    1e3b:	8d 14 00             	lea    edx,[eax+eax*1]
    1e3e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1e41:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1e44:	0f af c2             	imul   eax,edx
						memcpy(vga_mem_ptr + (fb->pix_y + r->y) * 2 * video_mode.width,
    1e47:	89 c6                	mov    esi,eax
										fb->text_mem + (fb->cho_y + r->y) * 2
    1e49:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1e4c:	8b 10                	mov    edx,DWORD PTR [eax]
    1e4e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1e51:	8b 48 28             	mov    ecx,DWORD PTR [eax+0x28]
    1e54:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1e57:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    1e5b:	98                   	cwde
    1e5c:	01 c8                	add    eax,ecx
    1e5e:	8d 0c 00             	lea    ecx,[eax+eax*1]
										* fb->width, nl * 2 * fb->width);
    1e61:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1e64:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1e67:	0f af c1             	imul   eax,ecx
										fb->text_mem + (fb->cho_y + r->y) * 2
    1e6a:	01 c2                	add    edx,eax
						memcpy(vga_mem_ptr + (fb->pix_y + r->y) * 2 * video_mode.width,
    1e6c:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    1e72:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1e75:	8b 58 20             	mov    ebx,DWORD PTR [eax+0x20]
    1e78:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1e7b:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    1e7f:	98                   	cwde
    1e80:	01 d8                	add    eax,ebx
    1e82:	8d 1c 00             	lea    ebx,[eax+eax*1]
    1e85:	a1 04 00 00 00       	mov    eax,ds:0x4
    1e8a:	0f af c3             	imul   eax,ebx
    1e8d:	01 c8                	add    eax,ecx
    1e8f:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    1e93:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1e97:	89 04 24             	mov    DWORD PTR [esp],eax
    1e9a:	e8 61 e1 ff ff       	call   0 <memcpy>
						/* show we're outside of buffer (for large cho_y) */
						if (nl < fb->chw_y)
    1e9f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ea2:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    1ea5:	39 45 90             	cmp    DWORD PTR [ebp-0x70],eax
    1ea8:	0f 8d 5e 02 00 00    	jge    210c <framebuffer_redraw_region+0x39b>
								bzero(vga_mem_ptr + (fb->pix_y + r->y + nl) * 2 * fb->width,
										(min(fb->chw_y, video_mode.height - fb->pix_y)
    1eae:	8b 15 08 00 00 00    	mov    edx,DWORD PTR ds:0x8
    1eb4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1eb7:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    1eba:	29 c2                	sub    edx,eax
    1ebc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ebf:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    1ec2:	39 c2                	cmp    edx,eax
    1ec4:	0f 4e c2             	cmovle eax,edx
										 - nl) * fb->width * 2);
    1ec7:	2b 45 90             	sub    eax,DWORD PTR [ebp-0x70]
    1eca:	89 c2                	mov    edx,eax
    1ecc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ecf:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1ed2:	0f af c2             	imul   eax,edx
    1ed5:	01 c0                	add    eax,eax
								bzero(vga_mem_ptr + (fb->pix_y + r->y + nl) * 2 * fb->width,
    1ed7:	89 c3                	mov    ebx,eax
    1ed9:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    1edf:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ee2:	8b 48 20             	mov    ecx,DWORD PTR [eax+0x20]
    1ee5:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1ee8:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    1eec:	98                   	cwde
    1eed:	01 c1                	add    ecx,eax
    1eef:	8b 45 90             	mov    eax,DWORD PTR [ebp-0x70]
    1ef2:	01 c8                	add    eax,ecx
    1ef4:	8d 0c 00             	lea    ecx,[eax+eax*1]
    1ef7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1efa:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1efd:	0f af c1             	imul   eax,ecx
    1f00:	01 d0                	add    eax,edx
    1f02:	89 5c 24 04          	mov    DWORD PTR [esp+0x4],ebx
    1f06:	89 04 24             	mov    DWORD PTR [esp],eax
    1f09:	e8 fc ff ff ff       	call   1f0a <framebuffer_redraw_region+0x199>
							   && r->lx == fb->width && !fb->pix_x) {
    1f0e:	e9 f9 01 00 00       	jmp    210c <framebuffer_redraw_region+0x39b>
				} else {
						ssize_t nl, nc; void *src, *dst;
						/* copy linewise */
						nl = min(min(video_mode.height - fb->pix_y, fb->chw_y),
    1f13:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1f16:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
    1f1a:	0f bf d0             	movsx  edx,ax
    1f1d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1f20:	8b 58 08             	mov    ebx,DWORD PTR [eax+0x8]
    1f23:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1f26:	8b 48 28             	mov    ecx,DWORD PTR [eax+0x28]
    1f29:	89 d8                	mov    eax,ebx
    1f2b:	29 c8                	sub    eax,ecx
    1f2d:	39 c2                	cmp    edx,eax
    1f2f:	0f 4f d0             	cmovg  edx,eax
    1f32:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1f35:	8b 48 30             	mov    ecx,DWORD PTR [eax+0x30]
    1f38:	8b 35 08 00 00 00    	mov    esi,DWORD PTR ds:0x8
    1f3e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1f41:	8b 58 20             	mov    ebx,DWORD PTR [eax+0x20]
    1f44:	89 f0                	mov    eax,esi
    1f46:	29 d8                	sub    eax,ebx
    1f48:	39 c1                	cmp    ecx,eax
    1f4a:	0f 4e c1             	cmovle eax,ecx
    1f4d:	39 c2                	cmp    edx,eax
    1f4f:	0f 4e c2             	cmovle eax,edx
    1f52:	89 45 8c             	mov    DWORD PTR [ebp-0x74],eax
									   	min(fb->height - fb->cho_y, r->ly));
						nc = min(min(video_mode.width - fb->pix_x, fb->chw_x),
    1f55:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1f58:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
    1f5c:	0f bf d0             	movsx  edx,ax
    1f5f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1f62:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    1f65:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1f68:	8b 48 24             	mov    ecx,DWORD PTR [eax+0x24]
    1f6b:	89 d8                	mov    eax,ebx
    1f6d:	29 c8                	sub    eax,ecx
    1f6f:	39 c2                	cmp    edx,eax
    1f71:	0f 4f d0             	cmovg  edx,eax
    1f74:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1f77:	8b 48 2c             	mov    ecx,DWORD PTR [eax+0x2c]
    1f7a:	8b 35 04 00 00 00    	mov    esi,DWORD PTR ds:0x4
    1f80:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1f83:	8b 58 1c             	mov    ebx,DWORD PTR [eax+0x1c]
    1f86:	89 f0                	mov    eax,esi
    1f88:	29 d8                	sub    eax,ebx
    1f8a:	39 c1                	cmp    ecx,eax
    1f8c:	0f 4e c1             	cmovle eax,ecx
    1f8f:	39 c2                	cmp    edx,eax
    1f91:	0f 4e c2             	cmovle eax,edx
    1f94:	89 45 88             	mov    DWORD PTR [ebp-0x78],eax
										min(fb->width - fb->cho_x, r->lx));
						src = fb->text_mem + (fb->cho_y + r->y) * 2 * fb->width + 2 * (fb->cho_x + r->y);
    1f97:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1f9a:	8b 10                	mov    edx,DWORD PTR [eax]
    1f9c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1f9f:	8b 48 28             	mov    ecx,DWORD PTR [eax+0x28]
    1fa2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1fa5:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    1fa9:	98                   	cwde
    1faa:	01 c8                	add    eax,ecx
    1fac:	8d 0c 00             	lea    ecx,[eax+eax*1]
    1faf:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1fb2:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1fb5:	0f af c1             	imul   eax,ecx
    1fb8:	89 c3                	mov    ebx,eax
    1fba:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1fbd:	8b 48 24             	mov    ecx,DWORD PTR [eax+0x24]
    1fc0:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1fc3:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    1fc7:	98                   	cwde
    1fc8:	01 c8                	add    eax,ecx
    1fca:	01 c0                	add    eax,eax
    1fcc:	01 d8                	add    eax,ebx
    1fce:	01 d0                	add    eax,edx
    1fd0:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
						dst = vga_mem_ptr + (fb->pix_y + r->y) * 2 * video_mode.width + 2 * (fb->pix_x + r->y);
    1fd3:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    1fd9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1fdc:	8b 48 20             	mov    ecx,DWORD PTR [eax+0x20]
    1fdf:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1fe2:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    1fe6:	98                   	cwde
    1fe7:	01 c8                	add    eax,ecx
    1fe9:	8d 0c 00             	lea    ecx,[eax+eax*1]
    1fec:	a1 04 00 00 00       	mov    eax,ds:0x4
    1ff1:	0f af c1             	imul   eax,ecx
    1ff4:	89 c3                	mov    ebx,eax
    1ff6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ff9:	8b 48 1c             	mov    ecx,DWORD PTR [eax+0x1c]
    1ffc:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1fff:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    2003:	98                   	cwde
    2004:	01 c8                	add    eax,ecx
    2006:	01 c0                	add    eax,eax
    2008:	01 d8                	add    eax,ebx
    200a:	01 d0                	add    eax,edx
    200c:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
						while (nl) {
    200f:	e9 80 00 00 00       	jmp    2094 <framebuffer_redraw_region+0x323>
								memcpy(dst, src, 2 * nc);
    2014:	8b 45 88             	mov    eax,DWORD PTR [ebp-0x78]
    2017:	01 c0                	add    eax,eax
    2019:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    201d:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2020:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2024:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    2027:	89 04 24             	mov    DWORD PTR [esp],eax
    202a:	e8 d1 df ff ff       	call   0 <memcpy>
								if (nc < min(fb->chw_x, r->lx))
    202f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2032:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
    2036:	0f bf d0             	movsx  edx,ax
    2039:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    203c:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    203f:	39 c2                	cmp    edx,eax
    2041:	0f 4e c2             	cmovle eax,edx
    2044:	39 45 88             	cmp    DWORD PTR [ebp-0x78],eax
    2047:	7d 36                	jge    207f <framebuffer_redraw_region+0x30e>
										bzero(dst + 2 * nc, min(fb->chw_x,
    2049:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    204f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2052:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    2055:	29 c2                	sub    edx,eax
    2057:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    205a:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    205d:	39 c2                	cmp    edx,eax
    205f:	0f 4e c2             	cmovle eax,edx
											  video_mode.width - fb->pix_x) - nc);
    2062:	2b 45 88             	sub    eax,DWORD PTR [ebp-0x78]
										bzero(dst + 2 * nc, min(fb->chw_x,
    2065:	89 c2                	mov    edx,eax
    2067:	8b 45 88             	mov    eax,DWORD PTR [ebp-0x78]
    206a:	01 c0                	add    eax,eax
    206c:	89 c1                	mov    ecx,eax
    206e:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    2071:	01 c8                	add    eax,ecx
    2073:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    2077:	89 04 24             	mov    DWORD PTR [esp],eax
    207a:	e8 fc ff ff ff       	call   207b <framebuffer_redraw_region+0x30a>
								dst += video_mode.width * 2;
    207f:	a1 04 00 00 00       	mov    eax,ds:0x4
    2084:	01 c0                	add    eax,eax
    2086:	01 45 e0             	add    DWORD PTR [ebp-0x20],eax
								src += fb->width * 2;
    2089:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    208c:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    208f:	01 c0                	add    eax,eax
    2091:	01 45 e4             	add    DWORD PTR [ebp-0x1c],eax
						while (nl) {
    2094:	83 7d 8c 00          	cmp    DWORD PTR [ebp-0x74],0x0
    2098:	0f 85 76 ff ff ff    	jne    2014 <framebuffer_redraw_region+0x2a3>
						}
						/* show we're outside (large cho_...) */
						nc = min(min(fb->chw_x, r->lx), video_mode.width - fb->pix_x);
    209e:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    20a4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    20a7:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    20aa:	89 d1                	mov    ecx,edx
    20ac:	29 c1                	sub    ecx,eax
    20ae:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    20b1:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
    20b5:	0f bf d0             	movsx  edx,ax
    20b8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    20bb:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    20be:	39 c2                	cmp    edx,eax
    20c0:	0f 4e c2             	cmovle eax,edx
    20c3:	39 c1                	cmp    ecx,eax
    20c5:	0f 4e c1             	cmovle eax,ecx
    20c8:	89 45 88             	mov    DWORD PTR [ebp-0x78],eax
						if (nl < min(fb->chw_y, r->ly)) {
    20cb:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    20ce:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
    20d2:	0f bf d0             	movsx  edx,ax
    20d5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    20d8:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    20db:	39 c2                	cmp    edx,eax
    20dd:	0f 4e c2             	cmovle eax,edx
    20e0:	39 45 8c             	cmp    DWORD PTR [ebp-0x74],eax
    20e3:	0f 8d eb 08 00 00    	jge    29d4 <framebuffer_redraw_region+0xc63>
								bzero(dst, 2 * nc);
    20e9:	8b 45 88             	mov    eax,DWORD PTR [ebp-0x78]
    20ec:	01 c0                	add    eax,eax
    20ee:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    20f2:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    20f5:	89 04 24             	mov    DWORD PTR [esp],eax
    20f8:	e8 fc ff ff ff       	call   20f9 <framebuffer_redraw_region+0x388>
								dst += video_mode.width * 2;
    20fd:	a1 04 00 00 00       	mov    eax,ds:0x4
    2102:	01 c0                	add    eax,eax
    2104:	01 45 e0             	add    DWORD PTR [ebp-0x20],eax
						}
				}
				return;
    2107:	e9 c8 08 00 00       	jmp    29d4 <framebuffer_redraw_region+0xc63>
							   && r->lx == fb->width && !fb->pix_x) {
    210c:	90                   	nop
				return;
    210d:	e9 c2 08 00 00       	jmp    29d4 <framebuffer_redraw_region+0xc63>
		} else {
				int shf = 0;
    2112:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
				void* mem = vga_mem_ptr; char* str = fb->text_mem;
    2119:	a1 00 00 00 00       	mov    eax,ds:0x0
    211e:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    2121:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2124:	8b 00                	mov    eax,DWORD PTR [eax]
    2126:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				ssize_t px_x, px_y, o_x, o_y;

				/* calculate the pixel offsets */
				o_x = fb->pix_x + r->x * 8;
    2129:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    212c:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    212f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2132:	0f b7 00             	movzx  eax,WORD PTR [eax]
    2135:	98                   	cwde
    2136:	c1 e0 03             	shl    eax,0x3
    2139:	01 d0                	add    eax,edx
    213b:	89 45 a8             	mov    DWORD PTR [ebp-0x58],eax
				o_y = fb->pix_y + r->y * 16;
    213e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2141:	8b 50 20             	mov    edx,DWORD PTR [eax+0x20]
    2144:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2147:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    214b:	98                   	cwde
    214c:	c1 e0 04             	shl    eax,0x4
    214f:	01 d0                	add    eax,edx
    2151:	89 45 a4             	mov    DWORD PTR [ebp-0x5c],eax
				px_x = r->lx * 8;
    2154:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2157:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
    215b:	98                   	cwde
    215c:	c1 e0 03             	shl    eax,0x3
    215f:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
				px_y = r->ly * 16;
    2162:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2165:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
    2169:	98                   	cwde
    216a:	c1 e0 04             	shl    eax,0x4
    216d:	89 45 9c             	mov    DWORD PTR [ebp-0x64],eax
				/* and ensure the bounds */
				if (o_x >= video_mode.width || o_y >= video_mode.height)
    2170:	a1 04 00 00 00       	mov    eax,ds:0x4
    2175:	39 45 a8             	cmp    DWORD PTR [ebp-0x58],eax
    2178:	0f 8d 59 08 00 00    	jge    29d7 <framebuffer_redraw_region+0xc66>
    217e:	a1 08 00 00 00       	mov    eax,ds:0x8
    2183:	39 45 a4             	cmp    DWORD PTR [ebp-0x5c],eax
    2186:	0f 8d 4b 08 00 00    	jge    29d7 <framebuffer_redraw_region+0xc66>
					return;
				/* from the text buffer */
				px_x = min(px_x, 8 * min(fb->width - fb->cho_x - r->x, fb->chw_x - r->x));
    218c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    218f:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    2192:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2195:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
    2198:	29 c2                	sub    edx,eax
    219a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    219d:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    21a0:	39 c2                	cmp    edx,eax
    21a2:	7d 20                	jge    21c4 <framebuffer_redraw_region+0x453>
    21a4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    21a7:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    21aa:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    21ad:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
    21b0:	29 c2                	sub    edx,eax
    21b2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    21b5:	0f b7 00             	movzx  eax,WORD PTR [eax]
    21b8:	98                   	cwde
    21b9:	29 c2                	sub    edx,eax
    21bb:	8d 04 d5 00 00 00 00 	lea    eax,[edx*8+0x0]
    21c2:	eb 16                	jmp    21da <framebuffer_redraw_region+0x469>
    21c4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    21c7:	8b 50 2c             	mov    edx,DWORD PTR [eax+0x2c]
    21ca:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    21cd:	0f b7 00             	movzx  eax,WORD PTR [eax]
    21d0:	98                   	cwde
    21d1:	29 c2                	sub    edx,eax
    21d3:	8d 04 d5 00 00 00 00 	lea    eax,[edx*8+0x0]
    21da:	8b 55 a0             	mov    edx,DWORD PTR [ebp-0x60]
    21dd:	39 c2                	cmp    edx,eax
    21df:	0f 4e c2             	cmovle eax,edx
    21e2:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
				px_y = min(px_y, 16 * min(fb->height - fb->cho_y - r->y, fb->chw_y - r->y));
    21e5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    21e8:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    21eb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    21ee:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    21f1:	29 c2                	sub    edx,eax
    21f3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    21f6:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    21f9:	39 c2                	cmp    edx,eax
    21fb:	7d 1f                	jge    221c <framebuffer_redraw_region+0x4ab>
    21fd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2200:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    2203:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2206:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2209:	29 c2                	sub    edx,eax
    220b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    220e:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    2212:	98                   	cwde
    2213:	29 c2                	sub    edx,eax
    2215:	89 d0                	mov    eax,edx
    2217:	c1 e0 04             	shl    eax,0x4
    221a:	eb 15                	jmp    2231 <framebuffer_redraw_region+0x4c0>
    221c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    221f:	8b 50 30             	mov    edx,DWORD PTR [eax+0x30]
    2222:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2225:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    2229:	98                   	cwde
    222a:	29 c2                	sub    edx,eax
    222c:	89 d0                	mov    eax,edx
    222e:	c1 e0 04             	shl    eax,0x4
    2231:	8b 55 9c             	mov    edx,DWORD PTR [ebp-0x64]
    2234:	39 c2                	cmp    edx,eax
    2236:	0f 4e c2             	cmovle eax,edx
    2239:	89 45 9c             	mov    DWORD PTR [ebp-0x64],eax
				/* and from video memory */
				px_x = min(px_x, video_mode.width - o_x);
    223c:	a1 04 00 00 00       	mov    eax,ds:0x4
    2241:	2b 45 a8             	sub    eax,DWORD PTR [ebp-0x58]
    2244:	8b 55 a0             	mov    edx,DWORD PTR [ebp-0x60]
    2247:	39 c2                	cmp    edx,eax
    2249:	0f 4e c2             	cmovle eax,edx
    224c:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
				px_y = min(px_y, video_mode.height - o_y);
    224f:	a1 08 00 00 00       	mov    eax,ds:0x8
    2254:	2b 45 a4             	sub    eax,DWORD PTR [ebp-0x5c]
    2257:	8b 55 9c             	mov    edx,DWORD PTR [ebp-0x64]
    225a:	39 c2                	cmp    edx,eax
    225c:	0f 4e c2             	cmovle eax,edx
    225f:	89 45 9c             	mov    DWORD PTR [ebp-0x64],eax
				if (px_x < 0 || px_y < 0)
    2262:	83 7d a0 00          	cmp    DWORD PTR [ebp-0x60],0x0
    2266:	0f 88 6e 07 00 00    	js     29da <framebuffer_redraw_region+0xc69>
    226c:	83 7d 9c 00          	cmp    DWORD PTR [ebp-0x64],0x0
    2270:	0f 88 64 07 00 00    	js     29da <framebuffer_redraw_region+0xc69>
					return;
				
				if (video_mode.gm_bts == 4)
    2276:	0f b6 05 01 00 00 00 	movzx  eax,BYTE PTR ds:0x1
    227d:	3c 04                	cmp    al,0x4
    227f:	75 20                	jne    22a1 <framebuffer_redraw_region+0x530>
					shf = ((o_x % 2) == 1);
    2281:	8b 55 a8             	mov    edx,DWORD PTR [ebp-0x58]
    2284:	89 d0                	mov    eax,edx
    2286:	c1 f8 1f             	sar    eax,0x1f
    2289:	c1 e8 1f             	shr    eax,0x1f
    228c:	01 c2                	add    edx,eax
    228e:	83 e2 01             	and    edx,0x1
    2291:	29 c2                	sub    edx,eax
    2293:	89 d0                	mov    eax,edx
    2295:	83 f8 01             	cmp    eax,0x1
    2298:	0f 94 c0             	sete   al
    229b:	0f b6 c0             	movzx  eax,al
    229e:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
				
				/* set the memory references */
				mem += o_y * video_mode.bpsl + o_x * video_mode.btpp;
    22a1:	8b 15 0c 00 00 00    	mov    edx,DWORD PTR ds:0xc
    22a7:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
    22aa:	0f af d0             	imul   edx,eax
    22ad:	0f b6 05 02 00 00 00 	movzx  eax,BYTE PTR ds:0x2
    22b4:	0f be c0             	movsx  eax,al
    22b7:	0f af 45 a8          	imul   eax,DWORD PTR [ebp-0x58]
    22bb:	01 d0                	add    eax,edx
    22bd:	01 45 d8             	add    DWORD PTR [ebp-0x28],eax
				str += (fb->cho_y + r->y) * 2 * fb->width + (fb->cho_x + r->x) * 2;
    22c0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    22c3:	8b 50 28             	mov    edx,DWORD PTR [eax+0x28]
    22c6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    22c9:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    22cd:	98                   	cwde
    22ce:	01 d0                	add    eax,edx
    22d0:	8d 14 00             	lea    edx,[eax+eax*1]
    22d3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    22d6:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    22d9:	0f af d0             	imul   edx,eax
    22dc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    22df:	8b 48 24             	mov    ecx,DWORD PTR [eax+0x24]
    22e2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    22e5:	0f b7 00             	movzx  eax,WORD PTR [eax]
    22e8:	98                   	cwde
    22e9:	01 c8                	add    eax,ecx
    22eb:	01 c0                	add    eax,eax
    22ed:	01 d0                	add    eax,edx
    22ef:	01 45 d4             	add    DWORD PTR [ebp-0x2c],eax

				/* check for excluding rects */
				if (fb->r_excl) {
    22f2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    22f5:	8b 40 38             	mov    eax,DWORD PTR [eax+0x38]
    22f8:	85 c0                	test   eax,eax
    22fa:	0f 84 3d 06 00 00    	je     293d <framebuffer_redraw_region+0xbcc>
						/* use y and x stride marks */
						size_t ns_y = 0, ns_x = 0;
    2300:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [ebp-0x30],0x0
    2307:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
						struct stride /* exclude range:  y is key */
								stride_y[10], stride_x[20];
						struct exclude_rect* pe = fb->r_excl;
    230e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2311:	8b 40 38             	mov    eax,DWORD PTR [eax+0x38]
    2314:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
						while (pe) {
    2317:	e9 c7 01 00 00       	jmp    24e3 <framebuffer_redraw_region+0x772>
								struct exclude_rect er = {0};
    231c:	c7 85 74 ff ff ff 00 00 00 00 	mov    DWORD PTR [ebp-0x8c],0x0
    2326:	c7 85 78 ff ff ff 00 00 00 00 	mov    DWORD PTR [ebp-0x88],0x0
    2330:	c7 85 7c ff ff ff 00 00 00 00 	mov    DWORD PTR [ebp-0x84],0x0
    233a:	c7 45 80 00 00 00 00 	mov    DWORD PTR [ebp-0x80],0x0
    2341:	c7 45 84 00 00 00 00 	mov    DWORD PTR [ebp-0x7c],0x0
								er = *pe;
    2348:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    234b:	8b 10                	mov    edx,DWORD PTR [eax]
    234d:	89 95 74 ff ff ff    	mov    DWORD PTR [ebp-0x8c],edx
    2353:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    2356:	89 95 78 ff ff ff    	mov    DWORD PTR [ebp-0x88],edx
    235c:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    235f:	89 95 7c ff ff ff    	mov    DWORD PTR [ebp-0x84],edx
    2365:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    2368:	89 55 80             	mov    DWORD PTR [ebp-0x80],edx
    236b:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    236e:	89 45 84             	mov    DWORD PTR [ebp-0x7c],eax
								er.x -= fb->pix_x;
    2371:	8b 95 74 ff ff ff    	mov    edx,DWORD PTR [ebp-0x8c]
    2377:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    237a:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    237d:	29 c2                	sub    edx,eax
    237f:	89 95 74 ff ff ff    	mov    DWORD PTR [ebp-0x8c],edx
								er.y -= fb->pix_y;
    2385:	8b 95 78 ff ff ff    	mov    edx,DWORD PTR [ebp-0x88]
    238b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    238e:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    2391:	29 c2                	sub    edx,eax
    2393:	89 95 78 ff ff ff    	mov    DWORD PTR [ebp-0x88],edx
								if (er.x + er.lx > o_x && er.y + er.ly > o_y) {
    2399:	8b 95 74 ff ff ff    	mov    edx,DWORD PTR [ebp-0x8c]
    239f:	8b 85 7c ff ff ff    	mov    eax,DWORD PTR [ebp-0x84]
    23a5:	01 d0                	add    eax,edx
    23a7:	39 45 a8             	cmp    DWORD PTR [ebp-0x58],eax
    23aa:	0f 8d 2a 01 00 00    	jge    24da <framebuffer_redraw_region+0x769>
    23b0:	8b 95 78 ff ff ff    	mov    edx,DWORD PTR [ebp-0x88]
    23b6:	8b 45 80             	mov    eax,DWORD PTR [ebp-0x80]
    23b9:	01 d0                	add    eax,edx
    23bb:	39 45 a4             	cmp    DWORD PTR [ebp-0x5c],eax
    23be:	0f 8d 16 01 00 00    	jge    24da <framebuffer_redraw_region+0x769>
										if (o_x + px_x > er.x && o_y + px_y > er.y) {
    23c4:	8b 55 a8             	mov    edx,DWORD PTR [ebp-0x58]
    23c7:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    23ca:	01 c2                	add    edx,eax
    23cc:	8b 85 74 ff ff ff    	mov    eax,DWORD PTR [ebp-0x8c]
    23d2:	39 c2                	cmp    edx,eax
    23d4:	0f 8e 00 01 00 00    	jle    24da <framebuffer_redraw_region+0x769>
    23da:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    23dd:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    23e0:	01 c2                	add    edx,eax
    23e2:	8b 85 78 ff ff ff    	mov    eax,DWORD PTR [ebp-0x88]
    23e8:	39 c2                	cmp    edx,eax
    23ea:	0f 8e ea 00 00 00    	jle    24da <framebuffer_redraw_region+0x769>
												struct stride sx, sy;
												/* overlap y */
												if (ns_y == 10 || ns_x == 20) /* we could draw parts */
    23f0:	83 7d d0 0a          	cmp    DWORD PTR [ebp-0x30],0xa
    23f4:	74 06                	je     23fc <framebuffer_redraw_region+0x68b>
    23f6:	83 7d cc 14          	cmp    DWORD PTR [ebp-0x34],0x14
    23fa:	75 29                	jne    2425 <framebuffer_redraw_region+0x6b4>
														die("use bigger fb stride buffers\n");
    23fc:	c7 44 24 04 c3 01 00 00 	mov    DWORD PTR [esp+0x4],0x1c3
    2404:	c7 04 24 0c 00 00 00 	mov    DWORD PTR [esp],0xc
    240b:	e8 fc ff ff ff       	call   240c <framebuffer_redraw_region+0x69b>
    2410:	e8 fc ff ff ff       	call   2411 <framebuffer_redraw_region+0x6a0>
    2415:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    241c:	e8 fc ff ff ff       	call   241d <framebuffer_redraw_region+0x6ac>
    2421:	fa                   	cli
    2422:	f4                   	hlt
    2423:	eb fd                	jmp    2422 <framebuffer_redraw_region+0x6b1>
												/* crop the rect and insert two strides */
												sx.x1 = max(o_x, er.x);
    2425:	8b 95 74 ff ff ff    	mov    edx,DWORD PTR [ebp-0x8c]
    242b:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    242e:	39 c2                	cmp    edx,eax
    2430:	0f 4d c2             	cmovge eax,edx
    2433:	89 85 6c ff ff ff    	mov    DWORD PTR [ebp-0x94],eax
												sx.x2 = min(er.x + er.lx, o_x + px_x);
    2439:	8b 55 a8             	mov    edx,DWORD PTR [ebp-0x58]
    243c:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    243f:	01 c2                	add    edx,eax
    2441:	8b 8d 74 ff ff ff    	mov    ecx,DWORD PTR [ebp-0x8c]
    2447:	8b 85 7c ff ff ff    	mov    eax,DWORD PTR [ebp-0x84]
    244d:	01 c8                	add    eax,ecx
    244f:	39 c2                	cmp    edx,eax
    2451:	0f 4e c2             	cmovle eax,edx
    2454:	89 85 70 ff ff ff    	mov    DWORD PTR [ebp-0x90],eax
												sy.x1 = max(o_y, er.y);
    245a:	8b 95 78 ff ff ff    	mov    edx,DWORD PTR [ebp-0x88]
    2460:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
    2463:	39 c2                	cmp    edx,eax
    2465:	0f 4d c2             	cmovge eax,edx
    2468:	89 85 64 ff ff ff    	mov    DWORD PTR [ebp-0x9c],eax
												sy.x2 = min(er.y + er.ly, o_y + px_y);
    246e:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    2471:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    2474:	01 c2                	add    edx,eax
    2476:	8b 8d 78 ff ff ff    	mov    ecx,DWORD PTR [ebp-0x88]
    247c:	8b 45 80             	mov    eax,DWORD PTR [ebp-0x80]
    247f:	01 c8                	add    eax,ecx
    2481:	39 c2                	cmp    edx,eax
    2483:	0f 4e c2             	cmovle eax,edx
    2486:	89 85 68 ff ff ff    	mov    DWORD PTR [ebp-0x98],eax
												if(add_stride(stride_y, ns_y, &sy))
    248c:	8d 85 64 ff ff ff    	lea    eax,[ebp-0x9c]
    2492:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2496:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    2499:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    249d:	8d 85 74 fe ff ff    	lea    eax,[ebp-0x18c]
    24a3:	89 04 24             	mov    DWORD PTR [esp],eax
    24a6:	e8 fc ff ff ff       	call   24a7 <framebuffer_redraw_region+0x736>
    24ab:	85 c0                	test   eax,eax
    24ad:	74 04                	je     24b3 <framebuffer_redraw_region+0x742>
														ns_y++;
    24af:	83 45 d0 01          	add    DWORD PTR [ebp-0x30],0x1
												if (add_stride(stride_x, ns_x, &sx))
    24b3:	8d 85 6c ff ff ff    	lea    eax,[ebp-0x94]
    24b9:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    24bd:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    24c0:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    24c4:	8d 85 c4 fe ff ff    	lea    eax,[ebp-0x13c]
    24ca:	89 04 24             	mov    DWORD PTR [esp],eax
    24cd:	e8 fc ff ff ff       	call   24ce <framebuffer_redraw_region+0x75d>
    24d2:	85 c0                	test   eax,eax
    24d4:	74 04                	je     24da <framebuffer_redraw_region+0x769>
														ns_x++;
    24d6:	83 45 cc 01          	add    DWORD PTR [ebp-0x34],0x1
										}
								}
								pe = pe->next;
    24da:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    24dd:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    24e0:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
						while (pe) {
    24e3:	83 7d c8 00          	cmp    DWORD PTR [ebp-0x38],0x0
    24e7:	0f 85 2f fe ff ff    	jne    231c <framebuffer_redraw_region+0x5ab>
						}
						/* add the dummy entries (so we don't have to check at +x) */
						stride_y[ns_y].x1 = o_y + px_y;
    24ed:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    24f0:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    24f3:	01 c2                	add    edx,eax
    24f5:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    24f8:	89 94 c5 74 fe ff ff 	mov    DWORD PTR [ebp+eax*8-0x18c],edx
						stride_y[ns_y++].x2 = o_y + px_y;
    24ff:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    2502:	8d 50 01             	lea    edx,[eax+0x1]
    2505:	89 55 d0             	mov    DWORD PTR [ebp-0x30],edx
    2508:	8b 4d a4             	mov    ecx,DWORD PTR [ebp-0x5c]
    250b:	8b 55 9c             	mov    edx,DWORD PTR [ebp-0x64]
    250e:	01 ca                	add    edx,ecx
    2510:	89 94 c5 78 fe ff ff 	mov    DWORD PTR [ebp+eax*8-0x188],edx
						stride_x[ns_x].x1 = o_x + px_x;
    2517:	8b 55 a8             	mov    edx,DWORD PTR [ebp-0x58]
    251a:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    251d:	01 c2                	add    edx,eax
    251f:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    2522:	89 94 c5 c4 fe ff ff 	mov    DWORD PTR [ebp+eax*8-0x13c],edx
						stride_x[ns_x++].x2 = o_x + px_x;
    2529:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    252c:	8d 50 01             	lea    edx,[eax+0x1]
    252f:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
    2532:	8b 4d a8             	mov    ecx,DWORD PTR [ebp-0x58]
    2535:	8b 55 a0             	mov    edx,DWORD PTR [ebp-0x60]
    2538:	01 ca                	add    edx,ecx
    253a:	89 94 c5 c8 fe ff ff 	mov    DWORD PTR [ebp+eax*8-0x138],edx
						if (ns_y > 1 && ns_x > 1) {
    2541:	83 7d d0 01          	cmp    DWORD PTR [ebp-0x30],0x1
    2545:	0f 86 f2 03 00 00    	jbe    293d <framebuffer_redraw_region+0xbcc>
    254b:	83 7d cc 01          	cmp    DWORD PTR [ebp-0x34],0x1
    254f:	0f 86 e8 03 00 00    	jbe    293d <framebuffer_redraw_region+0xbcc>
								ssize_t lpx_x, lpx_y, lo_x = o_x, lo_y = o_y;
    2555:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    2558:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
    255b:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
    255e:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
								char* str2 = str; int shf2 = shf; void* mem2;
    2561:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    2564:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
    2567:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    256a:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
								/* now we have a field of strides */
								for (size_t i = 0; i < ns_y; i++) {
    256d:	c7 45 b0 00 00 00 00 	mov    DWORD PTR [ebp-0x50],0x0
    2574:	e9 b3 03 00 00       	jmp    292c <framebuffer_redraw_region+0xbbb>
										/* draw full lines before the stride */
										if (stride_y[i].x1 > lo_y) {
    2579:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    257c:	8b 84 c5 74 fe ff ff 	mov    eax,DWORD PTR [ebp+eax*8-0x18c]
    2583:	39 45 c0             	cmp    DWORD PTR [ebp-0x40],eax
    2586:	0f 8d 0a 01 00 00    	jge    2696 <framebuffer_redraw_region+0x925>
												lpx_x = px_x;
    258c:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    258f:	89 45 98             	mov    DWORD PTR [ebp-0x68],eax
												lo_x = o_x;
    2592:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    2595:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
												shf2 = shf;
    2598:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    259b:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
												lpx_y = min(stride_y[i].x1 - lo_y, o_y + px_y - lo_y);
    259e:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    25a1:	8b 94 c5 74 fe ff ff 	mov    edx,DWORD PTR [ebp+eax*8-0x18c]
    25a8:	8b 4d a4             	mov    ecx,DWORD PTR [ebp-0x5c]
    25ab:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    25ae:	01 c8                	add    eax,ecx
    25b0:	39 c2                	cmp    edx,eax
    25b2:	7d 0f                	jge    25c3 <framebuffer_redraw_region+0x852>
    25b4:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    25b7:	8b 84 c5 74 fe ff ff 	mov    eax,DWORD PTR [ebp+eax*8-0x18c]
    25be:	2b 45 c0             	sub    eax,DWORD PTR [ebp-0x40]
    25c1:	eb 0b                	jmp    25ce <framebuffer_redraw_region+0x85d>
    25c3:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    25c6:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    25c9:	01 d0                	add    eax,edx
    25cb:	2b 45 c0             	sub    eax,DWORD PTR [ebp-0x40]
    25ce:	89 45 94             	mov    DWORD PTR [ebp-0x6c],eax
												if (lpx_y) /* skip empty dummy */
    25d1:	83 7d 94 00          	cmp    DWORD PTR [ebp-0x6c],0x0
    25d5:	0f 84 bb 00 00 00    	je     2696 <framebuffer_redraw_region+0x925>
													render_text(fb->font, str2, mem, 2 * fb->width,
														video_mode.bpsl, video_mode.gm_bts, lpx_x,
														lpx_y, shf2, fb->cur_x - r->x, fb->cur_y - r->y,
														0, (lo_y - o_y) % 16);
    25db:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    25de:	2b 45 a4             	sub    eax,DWORD PTR [ebp-0x5c]
    25e1:	89 c2                	mov    edx,eax
													render_text(fb->font, str2, mem, 2 * fb->width,
    25e3:	89 d0                	mov    eax,edx
    25e5:	c1 f8 1f             	sar    eax,0x1f
    25e8:	c1 e8 1c             	shr    eax,0x1c
    25eb:	01 c2                	add    edx,eax
    25ed:	83 e2 0f             	and    edx,0xf
    25f0:	29 c2                	sub    edx,eax
    25f2:	89 95 64 fe ff ff    	mov    DWORD PTR [ebp-0x19c],edx
														lpx_y, shf2, fb->cur_x - r->x, fb->cur_y - r->y,
    25f8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    25fb:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    25fe:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2601:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    2605:	98                   	cwde
													render_text(fb->font, str2, mem, 2 * fb->width,
    2606:	89 d7                	mov    edi,edx
    2608:	29 c7                	sub    edi,eax
														lpx_y, shf2, fb->cur_x - r->x, fb->cur_y - r->y,
    260a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    260d:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
    2610:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2613:	0f b7 00             	movzx  eax,WORD PTR [eax]
    2616:	98                   	cwde
													render_text(fb->font, str2, mem, 2 * fb->width,
    2617:	89 d6                	mov    esi,edx
    2619:	29 c6                	sub    esi,eax
														video_mode.bpsl, video_mode.gm_bts, lpx_x,
    261b:	0f b6 05 01 00 00 00 	movzx  eax,BYTE PTR ds:0x1
													render_text(fb->font, str2, mem, 2 * fb->width,
    2622:	0f be d8             	movsx  ebx,al
														video_mode.bpsl, video_mode.gm_bts, lpx_x,
    2625:	8b 0d 0c 00 00 00    	mov    ecx,DWORD PTR ds:0xc
													render_text(fb->font, str2, mem, 2 * fb->width,
    262b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    262e:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2631:	01 c0                	add    eax,eax
    2633:	89 85 60 fe ff ff    	mov    DWORD PTR [ebp-0x1a0],eax
    2639:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    263c:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    263f:	8b 85 64 fe ff ff    	mov    eax,DWORD PTR [ebp-0x19c]
    2645:	89 44 24 30          	mov    DWORD PTR [esp+0x30],eax
    2649:	c7 44 24 2c 00 00 00 00 	mov    DWORD PTR [esp+0x2c],0x0
    2651:	89 7c 24 28          	mov    DWORD PTR [esp+0x28],edi
    2655:	89 74 24 24          	mov    DWORD PTR [esp+0x24],esi
    2659:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    265c:	89 44 24 20          	mov    DWORD PTR [esp+0x20],eax
    2660:	8b 45 94             	mov    eax,DWORD PTR [ebp-0x6c]
    2663:	89 44 24 1c          	mov    DWORD PTR [esp+0x1c],eax
    2667:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
    266a:	89 44 24 18          	mov    DWORD PTR [esp+0x18],eax
    266e:	89 5c 24 14          	mov    DWORD PTR [esp+0x14],ebx
    2672:	89 4c 24 10          	mov    DWORD PTR [esp+0x10],ecx
    2676:	8b 85 60 fe ff ff    	mov    eax,DWORD PTR [ebp-0x1a0]
    267c:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    2680:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2683:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2687:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    268a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    268e:	89 14 24             	mov    DWORD PTR [esp],edx
    2691:	e8 fc ff ff ff       	call   2692 <framebuffer_redraw_region+0x921>
										}
										/* we are inside the stride */
										/* update the references */
										mem += (stride_y[i].x1 - lo_y) * video_mode.bpsl;
    2696:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    2699:	8b 84 c5 74 fe ff ff 	mov    eax,DWORD PTR [ebp+eax*8-0x18c]
    26a0:	2b 45 c0             	sub    eax,DWORD PTR [ebp-0x40]
    26a3:	89 c2                	mov    edx,eax
    26a5:	a1 0c 00 00 00       	mov    eax,ds:0xc
    26aa:	0f af c2             	imul   eax,edx
    26ad:	01 45 d8             	add    DWORD PTR [ebp-0x28],eax
										str += ((stride_y[i].x1 - lo_y) / 16) * 2 * fb->width;
    26b0:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    26b3:	8b 84 c5 74 fe ff ff 	mov    eax,DWORD PTR [ebp+eax*8-0x18c]
    26ba:	2b 45 c0             	sub    eax,DWORD PTR [ebp-0x40]
    26bd:	8d 50 0f             	lea    edx,[eax+0xf]
    26c0:	85 c0                	test   eax,eax
    26c2:	0f 48 c2             	cmovs  eax,edx
    26c5:	c1 f8 04             	sar    eax,0x4
    26c8:	8d 14 00             	lea    edx,[eax+eax*1]
    26cb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    26ce:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    26d1:	0f af c2             	imul   eax,edx
    26d4:	01 45 d4             	add    DWORD PTR [ebp-0x2c],eax
										str2 = str;
    26d7:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    26da:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
										lo_y = stride_y[i].x1;
    26dd:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    26e0:	8b 84 c5 74 fe ff ff 	mov    eax,DWORD PTR [ebp+eax*8-0x18c]
    26e7:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
										lpx_y = min(o_y + px_y, stride_y[i].x2) - stride_y[i].x1;
    26ea:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    26ed:	8b 94 c5 78 fe ff ff 	mov    edx,DWORD PTR [ebp+eax*8-0x188]
    26f4:	8b 4d a4             	mov    ecx,DWORD PTR [ebp-0x5c]
    26f7:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    26fa:	01 c8                	add    eax,ecx
    26fc:	39 c2                	cmp    edx,eax
    26fe:	0f 4f d0             	cmovg  edx,eax
    2701:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    2704:	8b 84 c5 74 fe ff ff 	mov    eax,DWORD PTR [ebp+eax*8-0x18c]
    270b:	29 c2                	sub    edx,eax
    270d:	89 55 94             	mov    DWORD PTR [ebp-0x6c],edx
										if (!lpx_y) /* break after zero stride */
    2710:	83 7d 94 00          	cmp    DWORD PTR [ebp-0x6c],0x0
    2714:	0f 84 c3 02 00 00    	je     29dd <framebuffer_redraw_region+0xc6c>
												break;
										lo_x = o_x;
    271a:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    271d:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
										shf2 = shf;
    2720:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    2723:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
										mem2 = mem;
    2726:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2729:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
										/* now draw the x strides */
										for (size_t j = 0; j < ns_x; j++) {
    272c:	c7 45 ac 00 00 00 00 	mov    DWORD PTR [ebp-0x54],0x0
    2733:	e9 9a 01 00 00       	jmp    28d2 <framebuffer_redraw_region+0xb61>
												/* draw to x before */
												if (stride_x[j].x1 > lo_x) {
    2738:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    273b:	8b 84 c5 c4 fe ff ff 	mov    eax,DWORD PTR [ebp+eax*8-0x13c]
    2742:	39 45 c4             	cmp    DWORD PTR [ebp-0x3c],eax
    2745:	0f 8d 0f 01 00 00    	jge    285a <framebuffer_redraw_region+0xae9>
														lpx_x = min(o_x + px_x - lo_x, stride_x[j].x1 - lo_x);
    274b:	8b 55 a8             	mov    edx,DWORD PTR [ebp-0x58]
    274e:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    2751:	01 c2                	add    edx,eax
    2753:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2756:	8b 84 c5 c4 fe ff ff 	mov    eax,DWORD PTR [ebp+eax*8-0x13c]
    275d:	39 c2                	cmp    edx,eax
    275f:	7d 0d                	jge    276e <framebuffer_redraw_region+0x9fd>
    2761:	8b 55 a8             	mov    edx,DWORD PTR [ebp-0x58]
    2764:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    2767:	01 d0                	add    eax,edx
    2769:	2b 45 c4             	sub    eax,DWORD PTR [ebp-0x3c]
    276c:	eb 0d                	jmp    277b <framebuffer_redraw_region+0xa0a>
    276e:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2771:	8b 84 c5 c4 fe ff ff 	mov    eax,DWORD PTR [ebp+eax*8-0x13c]
    2778:	2b 45 c4             	sub    eax,DWORD PTR [ebp-0x3c]
    277b:	89 45 98             	mov    DWORD PTR [ebp-0x68],eax
														render_text(fb->font, str2, mem2, 2 * fb->width,
																video_mode.bpsl, video_mode.gm_bts, lpx_x,
																lpx_y, shf2, fb->cur_x - r->x, fb->cur_y - r->y,
																(lo_x - o_x) % 8, (lo_y - o_y) % 16);
    277e:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    2781:	2b 45 a4             	sub    eax,DWORD PTR [ebp-0x5c]
    2784:	89 c2                	mov    edx,eax
														render_text(fb->font, str2, mem2, 2 * fb->width,
    2786:	89 d0                	mov    eax,edx
    2788:	c1 f8 1f             	sar    eax,0x1f
    278b:	c1 e8 1c             	shr    eax,0x1c
    278e:	01 c2                	add    edx,eax
    2790:	83 e2 0f             	and    edx,0xf
    2793:	29 c2                	sub    edx,eax
    2795:	89 95 64 fe ff ff    	mov    DWORD PTR [ebp-0x19c],edx
																(lo_x - o_x) % 8, (lo_y - o_y) % 16);
    279b:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    279e:	2b 45 a8             	sub    eax,DWORD PTR [ebp-0x58]
    27a1:	89 c2                	mov    edx,eax
														render_text(fb->font, str2, mem2, 2 * fb->width,
    27a3:	89 d0                	mov    eax,edx
    27a5:	c1 f8 1f             	sar    eax,0x1f
    27a8:	c1 e8 1d             	shr    eax,0x1d
    27ab:	01 c2                	add    edx,eax
    27ad:	83 e2 07             	and    edx,0x7
    27b0:	29 c2                	sub    edx,eax
    27b2:	89 95 60 fe ff ff    	mov    DWORD PTR [ebp-0x1a0],edx
																lpx_y, shf2, fb->cur_x - r->x, fb->cur_y - r->y,
    27b8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    27bb:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    27be:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    27c1:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    27c5:	98                   	cwde
														render_text(fb->font, str2, mem2, 2 * fb->width,
    27c6:	89 d7                	mov    edi,edx
    27c8:	29 c7                	sub    edi,eax
    27ca:	89 bd 5c fe ff ff    	mov    DWORD PTR [ebp-0x1a4],edi
																lpx_y, shf2, fb->cur_x - r->x, fb->cur_y - r->y,
    27d0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    27d3:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
    27d6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    27d9:	0f b7 00             	movzx  eax,WORD PTR [eax]
    27dc:	98                   	cwde
														render_text(fb->font, str2, mem2, 2 * fb->width,
    27dd:	89 d7                	mov    edi,edx
    27df:	29 c7                	sub    edi,eax
																video_mode.bpsl, video_mode.gm_bts, lpx_x,
    27e1:	0f b6 05 01 00 00 00 	movzx  eax,BYTE PTR ds:0x1
														render_text(fb->font, str2, mem2, 2 * fb->width,
    27e8:	0f be f0             	movsx  esi,al
																video_mode.bpsl, video_mode.gm_bts, lpx_x,
    27eb:	8b 1d 0c 00 00 00    	mov    ebx,DWORD PTR ds:0xc
														render_text(fb->font, str2, mem2, 2 * fb->width,
    27f1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    27f4:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    27f7:	01 c0                	add    eax,eax
    27f9:	89 c1                	mov    ecx,eax
    27fb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    27fe:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    2801:	8b 85 64 fe ff ff    	mov    eax,DWORD PTR [ebp-0x19c]
    2807:	89 44 24 30          	mov    DWORD PTR [esp+0x30],eax
    280b:	8b 85 60 fe ff ff    	mov    eax,DWORD PTR [ebp-0x1a0]
    2811:	89 44 24 2c          	mov    DWORD PTR [esp+0x2c],eax
    2815:	8b 85 5c fe ff ff    	mov    eax,DWORD PTR [ebp-0x1a4]
    281b:	89 44 24 28          	mov    DWORD PTR [esp+0x28],eax
    281f:	89 7c 24 24          	mov    DWORD PTR [esp+0x24],edi
    2823:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
    2826:	89 44 24 20          	mov    DWORD PTR [esp+0x20],eax
    282a:	8b 45 94             	mov    eax,DWORD PTR [ebp-0x6c]
    282d:	89 44 24 1c          	mov    DWORD PTR [esp+0x1c],eax
    2831:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
    2834:	89 44 24 18          	mov    DWORD PTR [esp+0x18],eax
    2838:	89 74 24 14          	mov    DWORD PTR [esp+0x14],esi
    283c:	89 5c 24 10          	mov    DWORD PTR [esp+0x10],ebx
    2840:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    2844:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    2847:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    284b:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
    284e:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2852:	89 14 24             	mov    DWORD PTR [esp],edx
    2855:	e8 fc ff ff ff       	call   2856 <framebuffer_redraw_region+0xae5>
												}
												/* draw nothing as x,y are inside */
												lo_x = stride_x[j].x2;
    285a:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    285d:	8b 84 c5 c8 fe ff ff 	mov    eax,DWORD PTR [ebp+eax*8-0x138]
    2864:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
												str2 = str + ((lo_x - o_x) / 8) * 2;
    2867:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    286a:	2b 45 a8             	sub    eax,DWORD PTR [ebp-0x58]
    286d:	8d 50 07             	lea    edx,[eax+0x7]
    2870:	85 c0                	test   eax,eax
    2872:	0f 48 c2             	cmovs  eax,edx
    2875:	c1 f8 03             	sar    eax,0x3
    2878:	01 c0                	add    eax,eax
    287a:	89 c2                	mov    edx,eax
    287c:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    287f:	01 d0                	add    eax,edx
    2881:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
												mem2 = mem + (lo_x - o_x) * video_mode.btpp;
    2884:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2887:	2b 45 a8             	sub    eax,DWORD PTR [ebp-0x58]
    288a:	89 c2                	mov    edx,eax
    288c:	0f b6 05 02 00 00 00 	movzx  eax,BYTE PTR ds:0x2
    2893:	0f be c0             	movsx  eax,al
    2896:	0f af c2             	imul   eax,edx
    2899:	89 c2                	mov    edx,eax
    289b:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    289e:	01 d0                	add    eax,edx
    28a0:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
												if (video_mode.gm_bts == 4)
    28a3:	0f b6 05 01 00 00 00 	movzx  eax,BYTE PTR ds:0x1
    28aa:	3c 04                	cmp    al,0x4
    28ac:	75 20                	jne    28ce <framebuffer_redraw_region+0xb5d>
														shf2 = ((lo_x % 2) == 1);
    28ae:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    28b1:	89 d0                	mov    eax,edx
    28b3:	c1 f8 1f             	sar    eax,0x1f
    28b6:	c1 e8 1f             	shr    eax,0x1f
    28b9:	01 c2                	add    edx,eax
    28bb:	83 e2 01             	and    edx,0x1
    28be:	29 c2                	sub    edx,eax
    28c0:	89 d0                	mov    eax,edx
    28c2:	83 f8 01             	cmp    eax,0x1
    28c5:	0f 94 c0             	sete   al
    28c8:	0f b6 c0             	movzx  eax,al
    28cb:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
										for (size_t j = 0; j < ns_x; j++) {
    28ce:	83 45 ac 01          	add    DWORD PTR [ebp-0x54],0x1
    28d2:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    28d5:	3b 45 cc             	cmp    eax,DWORD PTR [ebp-0x34]
    28d8:	0f 82 5a fe ff ff    	jb     2738 <framebuffer_redraw_region+0x9c7>
										}
										/* and set the memory */
										mem += lpx_y * video_mode.bpsl;
    28de:	8b 15 0c 00 00 00    	mov    edx,DWORD PTR ds:0xc
    28e4:	8b 45 94             	mov    eax,DWORD PTR [ebp-0x6c]
    28e7:	0f af c2             	imul   eax,edx
    28ea:	01 45 d8             	add    DWORD PTR [ebp-0x28],eax
										str2 = str + ((stride_y[i].x2 - lo_y) / 16) * 2 * fb->width;
    28ed:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    28f0:	8b 84 c5 78 fe ff ff 	mov    eax,DWORD PTR [ebp+eax*8-0x188]
    28f7:	2b 45 c0             	sub    eax,DWORD PTR [ebp-0x40]
    28fa:	8d 50 0f             	lea    edx,[eax+0xf]
    28fd:	85 c0                	test   eax,eax
    28ff:	0f 48 c2             	cmovs  eax,edx
    2902:	c1 f8 04             	sar    eax,0x4
    2905:	8d 14 00             	lea    edx,[eax+eax*1]
    2908:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    290b:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    290e:	0f af c2             	imul   eax,edx
    2911:	89 c2                	mov    edx,eax
    2913:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    2916:	01 d0                	add    eax,edx
    2918:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
										lo_y = stride_y[i].x2;
    291b:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    291e:	8b 84 c5 78 fe ff ff 	mov    eax,DWORD PTR [ebp+eax*8-0x188]
    2925:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
								for (size_t i = 0; i < ns_y; i++) {
    2928:	83 45 b0 01          	add    DWORD PTR [ebp-0x50],0x1
    292c:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    292f:	3b 45 d0             	cmp    eax,DWORD PTR [ebp-0x30]
    2932:	0f 82 41 fc ff ff    	jb     2579 <framebuffer_redraw_region+0x808>
								}
								return;
    2938:	e9 a1 00 00 00       	jmp    29de <framebuffer_redraw_region+0xc6d>
				}

				/* and draw the text */
				render_text(fb->font, str, mem, 2 * fb->width, video_mode.bpsl,
						video_mode.gm_bts, px_x, px_y, shf, fb->cur_x - r->x,
						fb->cur_y - r->y, 0, 0);
    293d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2940:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    2943:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2946:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    294a:	98                   	cwde
				render_text(fb->font, str, mem, 2 * fb->width, video_mode.bpsl,
    294b:	89 d6                	mov    esi,edx
    294d:	29 c6                	sub    esi,eax
						video_mode.gm_bts, px_x, px_y, shf, fb->cur_x - r->x,
    294f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2952:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
    2955:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2958:	0f b7 00             	movzx  eax,WORD PTR [eax]
    295b:	98                   	cwde
				render_text(fb->font, str, mem, 2 * fb->width, video_mode.bpsl,
    295c:	89 d3                	mov    ebx,edx
    295e:	29 c3                	sub    ebx,eax
						video_mode.gm_bts, px_x, px_y, shf, fb->cur_x - r->x,
    2960:	0f b6 05 01 00 00 00 	movzx  eax,BYTE PTR ds:0x1
				render_text(fb->font, str, mem, 2 * fb->width, video_mode.bpsl,
    2967:	0f be c8             	movsx  ecx,al
    296a:	8b 15 0c 00 00 00    	mov    edx,DWORD PTR ds:0xc
    2970:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2973:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2976:	01 c0                	add    eax,eax
    2978:	89 c7                	mov    edi,eax
    297a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    297d:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    2980:	c7 44 24 30 00 00 00 00 	mov    DWORD PTR [esp+0x30],0x0
    2988:	c7 44 24 2c 00 00 00 00 	mov    DWORD PTR [esp+0x2c],0x0
    2990:	89 74 24 28          	mov    DWORD PTR [esp+0x28],esi
    2994:	89 5c 24 24          	mov    DWORD PTR [esp+0x24],ebx
    2998:	8b 5d dc             	mov    ebx,DWORD PTR [ebp-0x24]
    299b:	89 5c 24 20          	mov    DWORD PTR [esp+0x20],ebx
    299f:	8b 5d 9c             	mov    ebx,DWORD PTR [ebp-0x64]
    29a2:	89 5c 24 1c          	mov    DWORD PTR [esp+0x1c],ebx
    29a6:	8b 5d a0             	mov    ebx,DWORD PTR [ebp-0x60]
    29a9:	89 5c 24 18          	mov    DWORD PTR [esp+0x18],ebx
    29ad:	89 4c 24 14          	mov    DWORD PTR [esp+0x14],ecx
    29b1:	89 54 24 10          	mov    DWORD PTR [esp+0x10],edx
    29b5:	89 7c 24 0c          	mov    DWORD PTR [esp+0xc],edi
    29b9:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    29bc:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    29c0:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    29c3:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    29c7:	89 04 24             	mov    DWORD PTR [esp],eax
    29ca:	e8 fc ff ff ff       	call   29cb <framebuffer_redraw_region+0xc5a>
    29cf:	eb 0d                	jmp    29de <framebuffer_redraw_region+0xc6d>
				return; /* don't do anything if we're directly on video memory */
    29d1:	90                   	nop
    29d2:	eb 0a                	jmp    29de <framebuffer_redraw_region+0xc6d>
				return;
    29d4:	90                   	nop
    29d5:	eb 07                	jmp    29de <framebuffer_redraw_region+0xc6d>
					return;
    29d7:	90                   	nop
    29d8:	eb 04                	jmp    29de <framebuffer_redraw_region+0xc6d>
					return;
    29da:	90                   	nop
    29db:	eb 01                	jmp    29de <framebuffer_redraw_region+0xc6d>
												break;
    29dd:	90                   	nop
		}
}
    29de:	81 c4 dc 01 00 00    	add    esp,0x1dc
    29e4:	5b                   	pop    ebx
    29e5:	5e                   	pop    esi
    29e6:	5f                   	pop    edi
    29e7:	5d                   	pop    ebp
    29e8:	c3                   	ret

000029e9 <framebuffer_redraw_updates>:

void framebuffer_redraw_updates(struct framebuffer* fb)
{
    29e9:	55                   	push   ebp
    29ea:	89 e5                	mov    ebp,esp
    29ec:	53                   	push   ebx
    29ed:	83 ec 34             	sub    esp,0x34
		uint64_t tm;
		struct rct *rc, **prc;
Pos1:
		rc = fb->r_ud; prc = &fb->r_ud;
    29f0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    29f3:	8b 40 34             	mov    eax,DWORD PTR [eax+0x34]
    29f6:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    29f9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    29fc:	83 c0 34             	add    eax,0x34
    29ff:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		if (!rc)
    2a02:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    2a06:	0f 84 19 01 00 00    	je     2b25 <framebuffer_redraw_updates+0x13c>
				return;
		if (cpu.has_tsc)
    2a0c:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    2a13:	83 e0 10             	and    eax,0x10
    2a16:	84 c0                	test   al,al
    2a18:	74 08                	je     2a22 <framebuffer_redraw_updates+0x39>
				asm volatile ("rdtsc" : "=A" (tm));
    2a1a:	0f 31                	rdtsc
    2a1c:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    2a1f:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
		do {
				if (rc->r_ct) {
    2a22:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2a25:	8b 80 84 02 00 00    	mov    eax,DWORD PTR [eax+0x284]
    2a2b:	85 c0                	test   eax,eax
    2a2d:	0f 84 98 00 00 00    	je     2acb <framebuffer_redraw_updates+0xe2>
						/* take element temorary out of list */
						if (__sync_bool_compare_and_swap(prc, rc, rc->next)) {
    2a33:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2a36:	8b 80 80 02 00 00    	mov    eax,DWORD PTR [eax+0x280]
    2a3c:	89 c1                	mov    ecx,eax
    2a3e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2a41:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    2a44:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [edx],ecx
    2a48:	0f 94 c0             	sete   al
    2a4b:	84 c0                	test   al,al
    2a4d:	74 a1                	je     29f0 <framebuffer_redraw_updates+0x7>
								/* success */
								for (size_t i = 0; i < rc->r_ct; i++)
    2a4f:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
    2a56:	eb 25                	jmp    2a7d <framebuffer_redraw_updates+0x94>
										framebuffer_redraw_region(fb, rc->r + i);
    2a58:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
    2a5b:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    2a5e:	89 d0                	mov    eax,edx
    2a60:	c1 e0 02             	shl    eax,0x2
    2a63:	01 d0                	add    eax,edx
    2a65:	c1 e0 02             	shl    eax,0x2
    2a68:	01 c8                	add    eax,ecx
    2a6a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2a6e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2a71:	89 04 24             	mov    DWORD PTR [esp],eax
    2a74:	e8 fc ff ff ff       	call   2a75 <framebuffer_redraw_updates+0x8c>
								for (size_t i = 0; i < rc->r_ct; i++)
    2a79:	83 45 e4 01          	add    DWORD PTR [ebp-0x1c],0x1
    2a7d:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2a80:	8b 80 84 02 00 00    	mov    eax,DWORD PTR [eax+0x284]
    2a86:	39 45 e4             	cmp    DWORD PTR [ebp-0x1c],eax
    2a89:	72 cd                	jb     2a58 <framebuffer_redraw_updates+0x6f>
								rc->r_ct = 0;
    2a8b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2a8e:	c7 80 84 02 00 00 00 00 00 00 	mov    DWORD PTR [eax+0x284],0x0
								/* now put the buffer back at the front */
								do {
										rc->next = fb->r_ud;
    2a98:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2a9b:	8b 50 34             	mov    edx,DWORD PTR [eax+0x34]
    2a9e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2aa1:	89 90 80 02 00 00    	mov    DWORD PTR [eax+0x280],edx
								} while (!__sync_bool_compare_and_swap(&fb->r_ud, rc->next, rc));
    2aa7:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    2aaa:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2aad:	8b 80 80 02 00 00    	mov    eax,DWORD PTR [eax+0x280]
    2ab3:	89 c3                	mov    ebx,eax
    2ab5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2ab8:	8d 48 34             	lea    ecx,[eax+0x34]
    2abb:	89 d8                	mov    eax,ebx
    2abd:	f0 0f b1 11          	lock cmpxchg DWORD PTR [ecx],edx
    2ac1:	0f 94 c0             	sete   al
    2ac4:	83 f0 01             	xor    eax,0x1
    2ac7:	84 c0                	test   al,al
    2ac9:	75 cd                	jne    2a98 <framebuffer_redraw_updates+0xaf>
						} else
								goto Pos1;
				}
				prc = &rc->next;
    2acb:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2ace:	05 80 02 00 00       	add    eax,0x280
    2ad3:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		} while ((rc = rc->next));
    2ad6:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2ad9:	8b 80 80 02 00 00    	mov    eax,DWORD PTR [eax+0x280]
    2adf:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    2ae2:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    2ae6:	0f 85 36 ff ff ff    	jne    2a22 <framebuffer_redraw_updates+0x39>
		if (cpu.has_tsc) {
    2aec:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    2af3:	83 e0 10             	and    eax,0x10
    2af6:	84 c0                	test   al,al
    2af8:	74 2c                	je     2b26 <framebuffer_redraw_updates+0x13d>
				asm volatile ("rdtsc" : "=A" (fb_rdt));
    2afa:	0f 31                	rdtsc
    2afc:	a3 00 00 00 00       	mov    ds:0x0,eax
    2b01:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
				fb_rdt -= tm;
    2b07:	a1 00 00 00 00       	mov    eax,ds:0x0
    2b0c:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    2b12:	2b 45 f0             	sub    eax,DWORD PTR [ebp-0x10]
    2b15:	1b 55 f4             	sbb    edx,DWORD PTR [ebp-0xc]
    2b18:	a3 00 00 00 00       	mov    ds:0x0,eax
    2b1d:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
    2b23:	eb 01                	jmp    2b26 <framebuffer_redraw_updates+0x13d>
				return;
    2b25:	90                   	nop
		}
}
    2b26:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    2b29:	c9                   	leave
    2b2a:	c3                   	ret

00002b2b <framebuffer_update_region>:

void framebuffer_update_region(struct framebuffer* fb, struct kio_region* r)
{
    2b2b:	55                   	push   ebp
    2b2c:	89 e5                	mov    ebp,esp
    2b2e:	53                   	push   ebx
    2b2f:	83 ec 44             	sub    esp,0x44
		struct kio_region r2;
		struct rct* ptr = fb->r_ud;
    2b32:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2b35:	8b 40 34             	mov    eax,DWORD PTR [eax+0x34]
    2b38:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		size_t idx;
		if (fb->text_mem == vga_mem_ptr)
    2b3b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2b3e:	8b 10                	mov    edx,DWORD PTR [eax]
    2b40:	a1 00 00 00 00       	mov    eax,ds:0x0
    2b45:	39 c2                	cmp    edx,eax
    2b47:	0f 84 38 04 00 00    	je     2f85 <framebuffer_update_region+0x45a>
				return;

		/* for now update on every call */
		r2.x = max(0, r->x - fb->cho_x);
    2b4d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2b50:	0f b7 00             	movzx  eax,WORD PTR [eax]
    2b53:	0f bf c8             	movsx  ecx,ax
    2b56:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2b59:	8b 50 24             	mov    edx,DWORD PTR [eax+0x24]
    2b5c:	89 c8                	mov    eax,ecx
    2b5e:	29 d0                	sub    eax,edx
    2b60:	ba 00 00 00 00       	mov    edx,0x0
    2b65:	85 c0                	test   eax,eax
    2b67:	0f 48 c2             	cmovs  eax,edx
    2b6a:	66 89 45 cc          	mov    WORD PTR [ebp-0x34],ax
		r2.y = max(0, r->y - fb->cho_y);
    2b6e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2b71:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    2b75:	0f bf c8             	movsx  ecx,ax
    2b78:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2b7b:	8b 50 28             	mov    edx,DWORD PTR [eax+0x28]
    2b7e:	89 c8                	mov    eax,ecx
    2b80:	29 d0                	sub    eax,edx
    2b82:	ba 00 00 00 00       	mov    edx,0x0
    2b87:	85 c0                	test   eax,eax
    2b89:	0f 48 c2             	cmovs  eax,edx
    2b8c:	66 89 45 ce          	mov    WORD PTR [ebp-0x32],ax
		r2.fmt = r->fmt;
    2b90:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2b93:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    2b97:	88 45 d8             	mov    BYTE PTR [ebp-0x28],al
		r2.lx = min(fb->chw_x - r2.x, r->lx);
    2b9a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2b9d:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
    2ba1:	0f bf d0             	movsx  edx,ax
    2ba4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2ba7:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    2baa:	0f b7 4d cc          	movzx  ecx,WORD PTR [ebp-0x34]
    2bae:	0f bf c9             	movsx  ecx,cx
    2bb1:	29 c8                	sub    eax,ecx
    2bb3:	39 c2                	cmp    edx,eax
    2bb5:	0f 4e c2             	cmovle eax,edx
    2bb8:	66 89 45 d0          	mov    WORD PTR [ebp-0x30],ax
		r2.ly = min(fb->chw_y - r2.y, r->ly);
    2bbc:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2bbf:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
    2bc3:	0f bf d0             	movsx  edx,ax
    2bc6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2bc9:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    2bcc:	0f b7 4d ce          	movzx  ecx,WORD PTR [ebp-0x32]
    2bd0:	0f bf c9             	movsx  ecx,cx
    2bd3:	29 c8                	sub    eax,ecx
    2bd5:	39 c2                	cmp    edx,eax
    2bd7:	0f 4e c2             	cmovle eax,edx
    2bda:	66 89 45 d2          	mov    WORD PTR [ebp-0x2e],ax
		/* check for visibility */
		if (r2.x >= fb->chw_x || r2.y >= fb->chw_y ||
    2bde:	0f b7 45 cc          	movzx  eax,WORD PTR [ebp-0x34]
    2be2:	0f bf d0             	movsx  edx,ax
    2be5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2be8:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    2beb:	39 c2                	cmp    edx,eax
    2bed:	0f 8d 95 03 00 00    	jge    2f88 <framebuffer_update_region+0x45d>
    2bf3:	0f b7 45 ce          	movzx  eax,WORD PTR [ebp-0x32]
    2bf7:	0f bf d0             	movsx  edx,ax
    2bfa:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2bfd:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    2c00:	39 c2                	cmp    edx,eax
    2c02:	0f 8d 80 03 00 00    	jge    2f88 <framebuffer_update_region+0x45d>
			r2.x + r2.lx < fb->cho_x || r2.y + r2.ly < fb->cho_y)
    2c08:	0f b7 45 cc          	movzx  eax,WORD PTR [ebp-0x34]
    2c0c:	0f bf d0             	movsx  edx,ax
    2c0f:	0f b7 45 d0          	movzx  eax,WORD PTR [ebp-0x30]
    2c13:	98                   	cwde
    2c14:	01 c2                	add    edx,eax
    2c16:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2c19:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
		if (r2.x >= fb->chw_x || r2.y >= fb->chw_y ||
    2c1c:	39 c2                	cmp    edx,eax
    2c1e:	0f 8c 64 03 00 00    	jl     2f88 <framebuffer_update_region+0x45d>
			r2.x + r2.lx < fb->cho_x || r2.y + r2.ly < fb->cho_y)
    2c24:	0f b7 45 ce          	movzx  eax,WORD PTR [ebp-0x32]
    2c28:	0f bf d0             	movsx  edx,ax
    2c2b:	0f b7 45 d2          	movzx  eax,WORD PTR [ebp-0x2e]
    2c2f:	98                   	cwde
    2c30:	01 c2                	add    edx,eax
    2c32:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2c35:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2c38:	39 c2                	cmp    edx,eax
    2c3a:	0f 8c 48 03 00 00    	jl     2f88 <framebuffer_update_region+0x45d>
				return;
		/* check for pending updates */
Pos1:
    2c40:	90                   	nop
		ptr = fb->r_ud;
    2c41:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2c44:	8b 40 34             	mov    eax,DWORD PTR [eax+0x34]
    2c47:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		while (ptr) { /* TODO: overhaul this -> leads to freezes */
    2c4a:	e9 91 02 00 00       	jmp    2ee0 <framebuffer_update_region+0x3b5>
				size_t i;
				for (i = 0; i < ptr->r_ct; i++) {
    2c4f:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    2c56:	e9 79 01 00 00       	jmp    2dd4 <framebuffer_update_region+0x2a9>
						/* check for extending horizontally */
						if (ptr->r[i].y == r2.y && ptr->r[i].ly == r2.ly) {
    2c5b:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    2c5e:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    2c61:	89 d0                	mov    eax,edx
    2c63:	c1 e0 02             	shl    eax,0x2
    2c66:	01 d0                	add    eax,edx
    2c68:	c1 e0 02             	shl    eax,0x2
    2c6b:	01 c8                	add    eax,ecx
    2c6d:	83 c0 02             	add    eax,0x2
    2c70:	0f b7 10             	movzx  edx,WORD PTR [eax]
    2c73:	0f b7 45 ce          	movzx  eax,WORD PTR [ebp-0x32]
    2c77:	66 39 c2             	cmp    dx,ax
    2c7a:	0f 85 cb 00 00 00    	jne    2d4b <framebuffer_update_region+0x220>
    2c80:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    2c83:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    2c86:	89 d0                	mov    eax,edx
    2c88:	c1 e0 02             	shl    eax,0x2
    2c8b:	01 d0                	add    eax,edx
    2c8d:	c1 e0 02             	shl    eax,0x2
    2c90:	01 c8                	add    eax,ecx
    2c92:	83 c0 06             	add    eax,0x6
    2c95:	0f b7 10             	movzx  edx,WORD PTR [eax]
    2c98:	0f b7 45 d2          	movzx  eax,WORD PTR [ebp-0x2e]
    2c9c:	66 39 c2             	cmp    dx,ax
    2c9f:	0f 85 a6 00 00 00    	jne    2d4b <framebuffer_update_region+0x220>
								short new_lx, old_lx = ptr->r[i].lx;
    2ca5:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    2ca8:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    2cab:	89 d0                	mov    eax,edx
    2cad:	c1 e0 02             	shl    eax,0x2
    2cb0:	01 d0                	add    eax,edx
    2cb2:	c1 e0 02             	shl    eax,0x2
    2cb5:	01 c8                	add    eax,ecx
    2cb7:	83 c0 04             	add    eax,0x4
    2cba:	0f b7 00             	movzx  eax,WORD PTR [eax]
    2cbd:	66 89 45 e6          	mov    WORD PTR [ebp-0x1a],ax
								if (ptr->r[i].x + ptr->r[i].lx == r2.x) {
    2cc1:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    2cc4:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    2cc7:	89 d0                	mov    eax,edx
    2cc9:	c1 e0 02             	shl    eax,0x2
    2ccc:	01 d0                	add    eax,edx
    2cce:	c1 e0 02             	shl    eax,0x2
    2cd1:	01 c8                	add    eax,ecx
    2cd3:	0f b7 00             	movzx  eax,WORD PTR [eax]
    2cd6:	0f bf c8             	movsx  ecx,ax
    2cd9:	8b 5d f4             	mov    ebx,DWORD PTR [ebp-0xc]
    2cdc:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    2cdf:	89 d0                	mov    eax,edx
    2ce1:	c1 e0 02             	shl    eax,0x2
    2ce4:	01 d0                	add    eax,edx
    2ce6:	c1 e0 02             	shl    eax,0x2
    2ce9:	01 d8                	add    eax,ebx
    2ceb:	83 c0 04             	add    eax,0x4
    2cee:	0f b7 00             	movzx  eax,WORD PTR [eax]
    2cf1:	98                   	cwde
    2cf2:	8d 14 01             	lea    edx,[ecx+eax*1]
    2cf5:	0f b7 45 cc          	movzx  eax,WORD PTR [ebp-0x34]
    2cf9:	98                   	cwde
    2cfa:	39 c2                	cmp    edx,eax
    2cfc:	75 4d                	jne    2d4b <framebuffer_update_region+0x220>
										new_lx = old_lx + r2.lx;
    2cfe:	0f b7 45 d0          	movzx  eax,WORD PTR [ebp-0x30]
    2d02:	89 c2                	mov    edx,eax
    2d04:	0f b7 45 e6          	movzx  eax,WORD PTR [ebp-0x1a]
    2d08:	01 d0                	add    eax,edx
    2d0a:	66 89 45 e4          	mov    WORD PTR [ebp-0x1c],ax
										/* try to combine */
										if (!__sync_bool_compare_and_swap(&ptr->r[i].lx, old_lx, new_lx))
    2d0e:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
    2d12:	0f b7 d8             	movzx  ebx,ax
    2d15:	0f b7 45 e6          	movzx  eax,WORD PTR [ebp-0x1a]
    2d19:	0f b7 c8             	movzx  ecx,ax
    2d1c:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    2d1f:	89 d0                	mov    eax,edx
    2d21:	c1 e0 02             	shl    eax,0x2
    2d24:	01 d0                	add    eax,edx
    2d26:	c1 e0 02             	shl    eax,0x2
    2d29:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    2d2c:	01 d0                	add    eax,edx
    2d2e:	8d 50 04             	lea    edx,[eax+0x4]
    2d31:	89 c8                	mov    eax,ecx
    2d33:	66 f0 0f b1 1a       	lock cmpxchg WORD PTR [edx],bx
    2d38:	0f 94 c0             	sete   al
    2d3b:	83 f0 01             	xor    eax,0x1
    2d3e:	84 c0                	test   al,al
    2d40:	0f 84 45 02 00 00    	je     2f8b <framebuffer_update_region+0x460>
												goto Pos1;
    2d46:	e9 f6 fe ff ff       	jmp    2c41 <framebuffer_update_region+0x116>
//										}
//										return;
//								}
//						}
						/* also check for duplicates */
						if (ptr->r[i].x == r2.x && ptr->r[i].y == r2.y
    2d4b:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    2d4e:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    2d51:	89 d0                	mov    eax,edx
    2d53:	c1 e0 02             	shl    eax,0x2
    2d56:	01 d0                	add    eax,edx
    2d58:	c1 e0 02             	shl    eax,0x2
    2d5b:	01 c8                	add    eax,ecx
    2d5d:	0f b7 10             	movzx  edx,WORD PTR [eax]
    2d60:	0f b7 45 cc          	movzx  eax,WORD PTR [ebp-0x34]
    2d64:	66 39 c2             	cmp    dx,ax
    2d67:	75 67                	jne    2dd0 <framebuffer_update_region+0x2a5>
    2d69:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    2d6c:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    2d6f:	89 d0                	mov    eax,edx
    2d71:	c1 e0 02             	shl    eax,0x2
    2d74:	01 d0                	add    eax,edx
    2d76:	c1 e0 02             	shl    eax,0x2
    2d79:	01 c8                	add    eax,ecx
    2d7b:	83 c0 02             	add    eax,0x2
    2d7e:	0f b7 10             	movzx  edx,WORD PTR [eax]
    2d81:	0f b7 45 ce          	movzx  eax,WORD PTR [ebp-0x32]
    2d85:	66 39 c2             	cmp    dx,ax
    2d88:	75 46                	jne    2dd0 <framebuffer_update_region+0x2a5>
							&& ptr->r[i].lx == r2.lx && ptr->r[i].ly == r2.ly)
    2d8a:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    2d8d:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    2d90:	89 d0                	mov    eax,edx
    2d92:	c1 e0 02             	shl    eax,0x2
    2d95:	01 d0                	add    eax,edx
    2d97:	c1 e0 02             	shl    eax,0x2
    2d9a:	01 c8                	add    eax,ecx
    2d9c:	83 c0 04             	add    eax,0x4
    2d9f:	0f b7 10             	movzx  edx,WORD PTR [eax]
    2da2:	0f b7 45 d0          	movzx  eax,WORD PTR [ebp-0x30]
    2da6:	66 39 c2             	cmp    dx,ax
    2da9:	75 25                	jne    2dd0 <framebuffer_update_region+0x2a5>
    2dab:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    2dae:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    2db1:	89 d0                	mov    eax,edx
    2db3:	c1 e0 02             	shl    eax,0x2
    2db6:	01 d0                	add    eax,edx
    2db8:	c1 e0 02             	shl    eax,0x2
    2dbb:	01 c8                	add    eax,ecx
    2dbd:	83 c0 06             	add    eax,0x6
    2dc0:	0f b7 10             	movzx  edx,WORD PTR [eax]
    2dc3:	0f b7 45 d2          	movzx  eax,WORD PTR [ebp-0x2e]
    2dc7:	66 39 c2             	cmp    dx,ax
    2dca:	0f 84 be 01 00 00    	je     2f8e <framebuffer_update_region+0x463>
				for (i = 0; i < ptr->r_ct; i++) {
    2dd0:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
    2dd4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2dd7:	8b 80 84 02 00 00    	mov    eax,DWORD PTR [eax+0x284]
    2ddd:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
    2de0:	0f 82 75 fe ff ff    	jb     2c5b <framebuffer_update_region+0x130>
								return;
				}
				/* add inbetween */
				if ((idx = __sync_fetch_and_add(&ptr->r_ct, 1)) < 32) {
    2de6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2de9:	05 84 02 00 00       	add    eax,0x284
    2dee:	ba 01 00 00 00       	mov    edx,0x1
    2df3:	f0 0f c1 10          	lock xadd DWORD PTR [eax],edx
    2df7:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
    2dfa:	83 7d ec 1f          	cmp    DWORD PTR [ebp-0x14],0x1f
    2dfe:	77 34                	ja     2e34 <framebuffer_update_region+0x309>
						ptr->r[idx] = r2;
    2e00:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    2e03:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    2e06:	89 d0                	mov    eax,edx
    2e08:	c1 e0 02             	shl    eax,0x2
    2e0b:	01 d0                	add    eax,edx
    2e0d:	c1 e0 02             	shl    eax,0x2
    2e10:	01 c8                	add    eax,ecx
    2e12:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    2e15:	89 10                	mov    DWORD PTR [eax],edx
    2e17:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    2e1a:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
    2e1d:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    2e20:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
    2e23:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    2e26:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
    2e29:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    2e2c:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
						break;
    2e2f:	e9 b9 00 00 00       	jmp    2eed <framebuffer_update_region+0x3c2>
				} else
						__sync_fetch_and_sub(&ptr->r_ct, 1);
    2e34:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2e37:	05 84 02 00 00       	add    eax,0x284
    2e3c:	f0 83 28 01          	lock sub DWORD PTR [eax],0x1
				/* we need a new container */
				if (!ptr->next) {
    2e40:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2e43:	8b 80 80 02 00 00    	mov    eax,DWORD PTR [eax+0x280]
    2e49:	85 c0                	test   eax,eax
    2e4b:	0f 85 83 00 00 00    	jne    2ed4 <framebuffer_update_region+0x3a9>
						while (fb_no_malloc);
    2e51:	90                   	nop
    2e52:	a1 00 00 00 00       	mov    eax,ds:0x0
    2e57:	85 c0                	test   eax,eax
    2e59:	75 f7                	jne    2e52 <framebuffer_update_region+0x327>
						struct rct* rn = kmalloc(sizeof(struct rct));
    2e5b:	c7 04 24 88 02 00 00 	mov    DWORD PTR [esp],0x288
    2e62:	e8 fc ff ff ff       	call   2e63 <framebuffer_update_region+0x338>
    2e67:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
						rn->r_ct = 1;
    2e6a:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    2e6d:	c7 80 84 02 00 00 01 00 00 00 	mov    DWORD PTR [eax+0x284],0x1
						rn->r[0] = r2;
    2e77:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    2e7a:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    2e7d:	89 10                	mov    DWORD PTR [eax],edx
    2e7f:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    2e82:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
    2e85:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    2e88:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
    2e8b:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    2e8e:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
    2e91:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    2e94:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
						rn->next = NULL;
    2e97:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    2e9a:	c7 80 80 02 00 00 00 00 00 00 	mov    DWORD PTR [eax+0x280],0x0
						if (__sync_bool_compare_and_swap(&ptr->next, NULL, rn))
    2ea4:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    2ea7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2eaa:	8d 88 80 02 00 00    	lea    ecx,[eax+0x280]
    2eb0:	b8 00 00 00 00       	mov    eax,0x0
    2eb5:	f0 0f b1 11          	lock cmpxchg DWORD PTR [ecx],edx
    2eb9:	0f 94 c0             	sete   al
    2ebc:	84 c0                	test   al,al
    2ebe:	75 2c                	jne    2eec <framebuffer_update_region+0x3c1>
								break;
						else if (!fb_no_malloc) { /* someone was faster */
    2ec0:	a1 00 00 00 00       	mov    eax,ds:0x0
    2ec5:	85 c0                	test   eax,eax
    2ec7:	75 0b                	jne    2ed4 <framebuffer_update_region+0x3a9>
								kfree(rn);
    2ec9:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    2ecc:	89 04 24             	mov    DWORD PTR [esp],eax
    2ecf:	e8 fc ff ff ff       	call   2ed0 <framebuffer_update_region+0x3a5>
								//goto Pos1; ptr=next
						}
				}
				ptr = ptr->next;
    2ed4:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2ed7:	8b 80 80 02 00 00    	mov    eax,DWORD PTR [eax+0x280]
    2edd:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		while (ptr) { /* TODO: overhaul this -> leads to freezes */
    2ee0:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    2ee4:	0f 85 65 fd ff ff    	jne    2c4f <framebuffer_update_region+0x124>
    2eea:	eb 01                	jmp    2eed <framebuffer_update_region+0x3c2>
								break;
    2eec:	90                   	nop
		}
		/* else extend the list */
		if (!fb->r_ud) 
    2eed:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2ef0:	8b 40 34             	mov    eax,DWORD PTR [eax+0x34]
    2ef3:	85 c0                	test   eax,eax
    2ef5:	0f 85 94 00 00 00    	jne    2f8f <framebuffer_update_region+0x464>
				if (fb_no_malloc) {
    2efb:	a1 00 00 00 00       	mov    eax,ds:0x0
    2f00:	85 c0                	test   eax,eax
    2f02:	74 0c                	je     2f10 <framebuffer_update_region+0x3e5>
					fb->r_ud = &rc_initial;
    2f04:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2f07:	c7 40 34 00 00 00 00 	mov    DWORD PTR [eax+0x34],0x0
    2f0e:	eb 7f                	jmp    2f8f <framebuffer_update_region+0x464>
				} else {
						struct rct* rn = kmalloc(sizeof(struct rct));
    2f10:	c7 04 24 88 02 00 00 	mov    DWORD PTR [esp],0x288
    2f17:	e8 fc ff ff ff       	call   2f18 <framebuffer_update_region+0x3ed>
    2f1c:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
						rn->r_ct = 1;
    2f1f:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    2f22:	c7 80 84 02 00 00 01 00 00 00 	mov    DWORD PTR [eax+0x284],0x1
						rn->r[0] = r2;
    2f2c:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    2f2f:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    2f32:	89 10                	mov    DWORD PTR [eax],edx
    2f34:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    2f37:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
    2f3a:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    2f3d:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
    2f40:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    2f43:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
    2f46:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    2f49:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
						rn->next = NULL;
    2f4c:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    2f4f:	c7 80 80 02 00 00 00 00 00 00 	mov    DWORD PTR [eax+0x280],0x0
						if (!__sync_bool_compare_and_swap(&fb->r_ud, NULL, rn)) {
    2f59:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    2f5c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2f5f:	8d 48 34             	lea    ecx,[eax+0x34]
    2f62:	b8 00 00 00 00       	mov    eax,0x0
    2f67:	f0 0f b1 11          	lock cmpxchg DWORD PTR [ecx],edx
    2f6b:	0f 94 c0             	sete   al
    2f6e:	83 f0 01             	xor    eax,0x1
    2f71:	84 c0                	test   al,al
    2f73:	74 1a                	je     2f8f <framebuffer_update_region+0x464>
								/* someone was faster */
								kfree(rn);
    2f75:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    2f78:	89 04 24             	mov    DWORD PTR [esp],eax
    2f7b:	e8 fc ff ff ff       	call   2f7c <framebuffer_update_region+0x451>
								goto Pos1;
    2f80:	e9 bc fc ff ff       	jmp    2c41 <framebuffer_update_region+0x116>
				return;
    2f85:	90                   	nop
    2f86:	eb 07                	jmp    2f8f <framebuffer_update_region+0x464>
				return;
    2f88:	90                   	nop
    2f89:	eb 04                	jmp    2f8f <framebuffer_update_region+0x464>
										return;
    2f8b:	90                   	nop
    2f8c:	eb 01                	jmp    2f8f <framebuffer_update_region+0x464>
								return;
    2f8e:	90                   	nop
						}	
		}
}
    2f8f:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    2f92:	c9                   	leave
    2f93:	c3                   	ret

00002f94 <framebuffer_scroll>:

/* we have to redraw everything */
void framebuffer_scroll(struct framebuffer* fb, ssize_t nly, ssize_t nlx)
{
    2f94:	55                   	push   ebp
    2f95:	89 e5                	mov    ebp,esp
    2f97:	83 ec 18             	sub    esp,0x18
		if (nly != 1 || nlx)
    2f9a:	83 7d 0c 01          	cmp    DWORD PTR [ebp+0xc],0x1
    2f9e:	75 08                	jne    2fa8 <framebuffer_scroll+0x14>
    2fa0:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    2fa4:	75 02                	jne    2fa8 <framebuffer_scroll+0x14>
    2fa6:	eb 02                	jmp    2faa <framebuffer_scroll+0x16>
				while (1); /* only lines for now */
    2fa8:	eb fe                	jmp    2fa8 <framebuffer_scroll+0x14>
		memmove(fb->text_mem, fb->text_mem + fb->width * 2,
					   	2 * fb->width * (fb->height - 1));
    2faa:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2fad:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2fb0:	8d 14 00             	lea    edx,[eax+eax*1]
    2fb3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2fb6:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2fb9:	83 e8 01             	sub    eax,0x1
    2fbc:	0f af c2             	imul   eax,edx
		memmove(fb->text_mem, fb->text_mem + fb->width * 2,
    2fbf:	89 c1                	mov    ecx,eax
    2fc1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2fc4:	8b 10                	mov    edx,DWORD PTR [eax]
    2fc6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2fc9:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2fcc:	01 c0                	add    eax,eax
    2fce:	01 c2                	add    edx,eax
    2fd0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2fd3:	8b 00                	mov    eax,DWORD PTR [eax]
    2fd5:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
    2fd9:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    2fdd:	89 04 24             	mov    DWORD PTR [esp],eax
    2fe0:	e8 fc ff ff ff       	call   2fe1 <framebuffer_scroll+0x4d>
		//framebuffer_redraw(fb);
}
    2fe5:	90                   	nop
    2fe6:	c9                   	leave
    2fe7:	c3                   	ret

00002fe8 <framebuffer_scroll_region>:

void framebuffer_scroll_region(struct framebuffer* fb,
				struct kio_region* r, ssize_t nx, ssize_t ny)
{
    2fe8:	55                   	push   ebp
    2fe9:	89 e5                	mov    ebp,esp
    2feb:	53                   	push   ebx
    2fec:	83 ec 24             	sub    esp,0x24
		ssize_t i; char* src = NULL;
    2fef:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
		if (ny != 1 || nx)
    2ff6:	83 7d 14 01          	cmp    DWORD PTR [ebp+0x14],0x1
    2ffa:	75 08                	jne    3004 <framebuffer_scroll_region+0x1c>
    2ffc:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    3000:	75 02                	jne    3004 <framebuffer_scroll_region+0x1c>
    3002:	eb 02                	jmp    3006 <framebuffer_scroll_region+0x1e>
				while (1); /* only lines for now */
    3004:	eb fe                	jmp    3004 <framebuffer_scroll_region+0x1c>
		/* sanity check */
		if (r->x + r->lx > fb->width)
    3006:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    3009:	0f b7 00             	movzx  eax,WORD PTR [eax]
    300c:	0f bf d0             	movsx  edx,ax
    300f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    3012:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
    3016:	98                   	cwde
    3017:	01 c2                	add    edx,eax
    3019:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    301c:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    301f:	39 c2                	cmp    edx,eax
    3021:	0f 8f 0f 01 00 00    	jg     3136 <framebuffer_scroll_region+0x14e>
				return;
		if (r->y + r->ly > fb->height)
    3027:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    302a:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    302e:	0f bf d0             	movsx  edx,ax
    3031:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    3034:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
    3038:	98                   	cwde
    3039:	01 c2                	add    edx,eax
    303b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    303e:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    3041:	39 c2                	cmp    edx,eax
    3043:	0f 8f f0 00 00 00    	jg     3139 <framebuffer_scroll_region+0x151>
				return;
		/* by moving possibly strided memory */
		for (i = r->y; i < r->y + r->ly - 1; i++)
    3049:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    304c:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    3050:	98                   	cwde
    3051:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    3054:	eb 6b                	jmp    30c1 <framebuffer_scroll_region+0xd9>
				memcpy(fb->text_mem + i * fb->width * 2 + r->x * 2,
					   (src = fb->text_mem + (i + 1) * fb->width * 2 + r->x * 2),
					   r->lx * 2);
    3056:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    3059:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
    305d:	98                   	cwde
    305e:	01 c0                	add    eax,eax
				memcpy(fb->text_mem + i * fb->width * 2 + r->x * 2,
    3060:	89 c3                	mov    ebx,eax
					   (src = fb->text_mem + (i + 1) * fb->width * 2 + r->x * 2),
    3062:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3065:	8b 10                	mov    edx,DWORD PTR [eax]
    3067:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    306a:	8d 48 01             	lea    ecx,[eax+0x1]
    306d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3070:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    3073:	0f af c1             	imul   eax,ecx
    3076:	01 c0                	add    eax,eax
    3078:	89 c1                	mov    ecx,eax
    307a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    307d:	0f b7 00             	movzx  eax,WORD PTR [eax]
    3080:	98                   	cwde
    3081:	01 c0                	add    eax,eax
    3083:	01 c8                	add    eax,ecx
    3085:	01 d0                	add    eax,edx
    3087:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				memcpy(fb->text_mem + i * fb->width * 2 + r->x * 2,
    308a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    308d:	8b 10                	mov    edx,DWORD PTR [eax]
    308f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3092:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    3095:	0f af 45 f4          	imul   eax,DWORD PTR [ebp-0xc]
    3099:	01 c0                	add    eax,eax
    309b:	89 c1                	mov    ecx,eax
    309d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    30a0:	0f b7 00             	movzx  eax,WORD PTR [eax]
    30a3:	98                   	cwde
    30a4:	01 c0                	add    eax,eax
    30a6:	01 c8                	add    eax,ecx
    30a8:	01 c2                	add    edx,eax
    30aa:	89 5c 24 08          	mov    DWORD PTR [esp+0x8],ebx
    30ae:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    30b1:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    30b5:	89 14 24             	mov    DWORD PTR [esp],edx
    30b8:	e8 43 cf ff ff       	call   0 <memcpy>
		for (i = r->y; i < r->y + r->ly - 1; i++)
    30bd:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    30c1:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    30c4:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    30c8:	0f bf d0             	movsx  edx,ax
    30cb:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    30ce:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
    30d2:	98                   	cwde
    30d3:	01 d0                	add    eax,edx
    30d5:	83 e8 01             	sub    eax,0x1
    30d8:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
    30db:	0f 8c 75 ff ff ff    	jl     3056 <framebuffer_scroll_region+0x6e>
		if (!src)
    30e1:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    30e5:	74 55                	je     313c <framebuffer_scroll_region+0x154>
				return;
		for (i = 0; i < 2 * r->lx; i += 2) {
    30e7:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    30ee:	eb 23                	jmp    3113 <framebuffer_scroll_region+0x12b>
				src[i] = '\0';
    30f0:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    30f3:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    30f6:	01 d0                	add    eax,edx
    30f8:	c6 00 00             	mov    BYTE PTR [eax],0x0
				src[i + 1] = r->fmt;
    30fb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    30fe:	8d 50 01             	lea    edx,[eax+0x1]
    3101:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    3104:	01 c2                	add    edx,eax
    3106:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    3109:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    310d:	88 02                	mov    BYTE PTR [edx],al
		for (i = 0; i < 2 * r->lx; i += 2) {
    310f:	83 45 f4 02          	add    DWORD PTR [ebp-0xc],0x2
    3113:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    3116:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
    311a:	98                   	cwde
    311b:	01 c0                	add    eax,eax
    311d:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
    3120:	7c ce                	jl     30f0 <framebuffer_scroll_region+0x108>
		} /* TODO other scrolls */
		/*bzero(fb->text_mem + i * fb->width * 2 + r->x * 2, r->lx * 2);*/
		framebuffer_update_region(fb, r);
    3122:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    3125:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3129:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    312c:	89 04 24             	mov    DWORD PTR [esp],eax
    312f:	e8 fc ff ff ff       	call   3130 <framebuffer_scroll_region+0x148>
    3134:	eb 07                	jmp    313d <framebuffer_scroll_region+0x155>
				return;
    3136:	90                   	nop
    3137:	eb 04                	jmp    313d <framebuffer_scroll_region+0x155>
				return;
    3139:	90                   	nop
    313a:	eb 01                	jmp    313d <framebuffer_scroll_region+0x155>
				return;
    313c:	90                   	nop
}
    313d:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    3140:	c9                   	leave
    3141:	c3                   	ret

00003142 <framebuffer_clear_region>:

void framebuffer_clear_region(struct framebuffer* fb, struct kio_region* r)
{
    3142:	55                   	push   ebp
    3143:	89 e5                	mov    ebp,esp
    3145:	83 ec 28             	sub    esp,0x28
		char* p;
		if (r->x + r->lx > fb->width)
    3148:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    314b:	0f b7 00             	movzx  eax,WORD PTR [eax]
    314e:	0f bf d0             	movsx  edx,ax
    3151:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    3154:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
    3158:	98                   	cwde
    3159:	01 c2                	add    edx,eax
    315b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    315e:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    3161:	39 c2                	cmp    edx,eax
    3163:	0f 8f dc 00 00 00    	jg     3245 <framebuffer_clear_region+0x103>
				return;
		if (r->y + r->ly > fb->height)
    3169:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    316c:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    3170:	0f bf d0             	movsx  edx,ax
    3173:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    3176:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
    317a:	98                   	cwde
    317b:	01 c2                	add    edx,eax
    317d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3180:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    3183:	39 c2                	cmp    edx,eax
    3185:	0f 8f bd 00 00 00    	jg     3248 <framebuffer_clear_region+0x106>
				return;
		p = (char*)fb->text_mem + 2 * r->y * fb->width + 2 * r->x;
    318b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    318e:	8b 10                	mov    edx,DWORD PTR [eax]
    3190:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    3193:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    3197:	98                   	cwde
    3198:	8d 0c 00             	lea    ecx,[eax+eax*1]
    319b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    319e:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    31a1:	0f af c1             	imul   eax,ecx
    31a4:	89 c1                	mov    ecx,eax
    31a6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    31a9:	0f b7 00             	movzx  eax,WORD PTR [eax]
    31ac:	98                   	cwde
    31ad:	01 c0                	add    eax,eax
    31af:	01 c8                	add    eax,ecx
    31b1:	01 d0                	add    eax,edx
    31b3:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		for (ssize_t l = 0; l < r->ly; l++)
    31b6:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    31bd:	eb 65                	jmp    3224 <framebuffer_clear_region+0xe2>
				for (ssize_t c = 0; c < r->lx; c++) {
    31bf:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    31c6:	eb 4b                	jmp    3213 <framebuffer_clear_region+0xd1>
						p[l * 2 * fb->width + 2 * c] = '\0';
    31c8:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    31cb:	8d 14 00             	lea    edx,[eax+eax*1]
    31ce:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    31d1:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    31d4:	0f af c2             	imul   eax,edx
    31d7:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    31da:	01 d2                	add    edx,edx
    31dc:	01 d0                	add    eax,edx
    31de:	89 c2                	mov    edx,eax
    31e0:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    31e3:	01 d0                	add    eax,edx
    31e5:	c6 00 00             	mov    BYTE PTR [eax],0x0
						p[l * 2 * fb->width + 2 * c + 1] = r->fmt;
    31e8:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    31eb:	8d 14 00             	lea    edx,[eax+eax*1]
    31ee:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    31f1:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    31f4:	0f af c2             	imul   eax,edx
    31f7:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    31fa:	01 d2                	add    edx,edx
    31fc:	01 d0                	add    eax,edx
    31fe:	8d 50 01             	lea    edx,[eax+0x1]
    3201:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    3204:	01 c2                	add    edx,eax
    3206:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    3209:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    320d:	88 02                	mov    BYTE PTR [edx],al
				for (ssize_t c = 0; c < r->lx; c++) {
    320f:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
    3213:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    3216:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
    321a:	98                   	cwde
    321b:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
    321e:	7c a8                	jl     31c8 <framebuffer_clear_region+0x86>
		for (ssize_t l = 0; l < r->ly; l++)
    3220:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    3224:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    3227:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
    322b:	98                   	cwde
    322c:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
    322f:	7c 8e                	jl     31bf <framebuffer_clear_region+0x7d>
				}
		framebuffer_update_region(fb, r);
    3231:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    3234:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3238:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    323b:	89 04 24             	mov    DWORD PTR [esp],eax
    323e:	e8 fc ff ff ff       	call   323f <framebuffer_clear_region+0xfd>
    3243:	eb 04                	jmp    3249 <framebuffer_clear_region+0x107>
				return;
    3245:	90                   	nop
    3246:	eb 01                	jmp    3249 <framebuffer_clear_region+0x107>
				return;
    3248:	90                   	nop
}
    3249:	c9                   	leave
    324a:	c3                   	ret

0000324b <framebuffer_set_cursor>:

/* has to flush the previous character and the new one and also pending updates */
void framebuffer_set_cursor(struct framebuffer* fb, ssize_t x, ssize_t y)
{
    324b:	55                   	push   ebp
    324c:	89 e5                	mov    ebp,esp
    324e:	83 ec 38             	sub    esp,0x38
		struct kio_region r;
		if (fb->cur_x > 0 && fb->cur_y > 0
    3251:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3254:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    3257:	85 c0                	test   eax,eax
    3259:	0f 8e 84 00 00 00    	jle    32e3 <framebuffer_set_cursor+0x98>
    325f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3262:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    3265:	85 c0                	test   eax,eax
    3267:	7e 7a                	jle    32e3 <framebuffer_set_cursor+0x98>
			&& fb->cur_x < fb->chw_x
    3269:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    326c:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
    326f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3272:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    3275:	39 c2                	cmp    edx,eax
    3277:	7d 6a                	jge    32e3 <framebuffer_set_cursor+0x98>
			&& fb->cur_y < fb->chw_y) {
    3279:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    327c:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    327f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3282:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    3285:	39 c2                	cmp    edx,eax
    3287:	7d 5a                	jge    32e3 <framebuffer_set_cursor+0x98>
				r.x = fb->cur_x + fb->cho_y;
    3289:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    328c:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    328f:	89 c2                	mov    edx,eax
    3291:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3294:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    3297:	01 d0                	add    eax,edx
    3299:	66 89 45 e4          	mov    WORD PTR [ebp-0x1c],ax
				r.lx = 1;
    329d:	66 c7 45 e8 01 00    	mov    WORD PTR [ebp-0x18],0x1
				r.y = fb->cur_y + fb->cho_y;
    32a3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    32a6:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    32a9:	89 c2                	mov    edx,eax
    32ab:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    32ae:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    32b1:	01 d0                	add    eax,edx
    32b3:	66 89 45 e6          	mov    WORD PTR [ebp-0x1a],ax
				r.ly = 1;
    32b7:	66 c7 45 ea 01 00    	mov    WORD PTR [ebp-0x16],0x1
				fb->cur_x = x;
    32bd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    32c0:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    32c3:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
				fb->cur_y = y;
    32c6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    32c9:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
    32cc:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
				framebuffer_update_region(fb, &r);
    32cf:	8d 45 e4             	lea    eax,[ebp-0x1c]
    32d2:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    32d6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    32d9:	89 04 24             	mov    DWORD PTR [esp],eax
    32dc:	e8 fc ff ff ff       	call   32dd <framebuffer_set_cursor+0x92>
    32e1:	eb 12                	jmp    32f5 <framebuffer_set_cursor+0xaa>
		} else {
				fb->cur_x = x;
    32e3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    32e6:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    32e9:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
				fb->cur_y = y;
    32ec:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    32ef:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
    32f2:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
		}
		r.x = fb->cur_x + fb->cho_x;
    32f5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    32f8:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    32fb:	89 c2                	mov    edx,eax
    32fd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3300:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
    3303:	01 d0                	add    eax,edx
    3305:	66 89 45 e4          	mov    WORD PTR [ebp-0x1c],ax
		r.y = fb->cur_y + fb->cho_y;
    3309:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    330c:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    330f:	89 c2                	mov    edx,eax
    3311:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3314:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    3317:	01 d0                	add    eax,edx
    3319:	66 89 45 e6          	mov    WORD PTR [ebp-0x1a],ax
		r.lx = r.ly = 1;
    331d:	66 c7 45 ea 01 00    	mov    WORD PTR [ebp-0x16],0x1
    3323:	0f b7 45 ea          	movzx  eax,WORD PTR [ebp-0x16]
    3327:	66 89 45 e8          	mov    WORD PTR [ebp-0x18],ax
		framebuffer_update_region(fb, &r);
    332b:	8d 45 e4             	lea    eax,[ebp-0x1c]
    332e:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    3332:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    3335:	89 04 24             	mov    DWORD PTR [esp],eax
    3338:	e8 fc ff ff ff       	call   3339 <framebuffer_set_cursor+0xee>
		//framebuffer_redraw(fb);
}
    333d:	90                   	nop
    333e:	c9                   	leave
    333f:	c3                   	ret

00003340 <framebuffer_resize>:

/* works on character cells */
void framebuffer_resize(struct framebuffer* fb, ssize_t new_lx, ssize_t new_ly)
{
    3340:	55                   	push   ebp
    3341:	89 e5                	mov    ebp,esp
		(void)fb; (void)new_lx; (void)new_ly;
}
    3343:	90                   	nop
    3344:	5d                   	pop    ebp
    3345:	c3                   	ret
