
framebuffer.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <memcpy>:
								mem += 4;
								bitc -= 32;
						} else if (bitc) {
								die("cant happen with dword sized pixels!\n");
						}
						break;
       0:	55                   	push   ebp
       1:	89 e5                	mov    ebp,esp
       3:	83 ec 10             	sub    esp,0x10
				}
       6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
       9:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax

       c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
       f:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
				/* and don't advance as r = 0 is already handled (sth. remains) */
      12:	eb 17                	jmp    2b <memcpy+0x2b>
				if (px_x) {
      14:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
      17:	8d 42 01             	lea    eax,[edx+0x1]
      1a:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
      1d:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
      20:	8d 48 01             	lea    ecx,[eax+0x1]
      23:	89 4d fc             	mov    DWORD PTR [ebp-0x4],ecx
      26:	0f b6 12             	movzx  edx,BYTE PTR [edx]
      29:	88 10                	mov    BYTE PTR [eax],dl
				/* and don't advance as r = 0 is already handled (sth. remains) */
      2b:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
      2e:	8d 50 ff             	lea    edx,[eax-0x1]
      31:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
      34:	85 c0                	test   eax,eax
      36:	75 dc                	jne    14 <memcpy+0x14>
						px_x -= bitc / 32;
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
      42:	83 ec 1c             	sub    esp,0x1c
		memcpy(&video_mode, FM_VIDEO_MODE, sizeof(video_mode));
      45:	6a 1c                	push   0x1c
      47:	68 00 f0 04 00       	push   0x4f000
      4c:	68 00 00 00 00       	push   0x0
      51:	e8 aa ff ff ff       	call   0 <memcpy>
      56:	83 c4 0c             	add    esp,0xc
		vga_font = (const char*)video_mode.fnt;
      59:	a1 10 00 00 00       	mov    eax,ds:0x10
      5e:	a3 00 00 00 00       	mov    ds:0x0,eax
		vmd = (void*)video_mode.ptr;
      63:	a1 18 00 00 00       	mov    eax,ds:0x18
      68:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		vga_mem_ptr = (void*)vmd->vga_virt;
      6b:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
      6e:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
      71:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
      74:	a3 00 00 00 00       	mov    ds:0x0,eax
		vga_pmem = (void*)vmd->vga_base;
      79:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
      7c:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
      7f:	8b 00                	mov    eax,DWORD PTR [eax]
      81:	a3 00 00 00 00       	mov    ds:0x0,eax
		vga_pmem_size = (size_t)vmd->vga_size;
      86:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
      89:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
      8c:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
      8f:	a3 00 00 00 00       	mov    ds:0x0,eax
						video_mode.height / 16 /* char_width_xy*/);
      94:	a1 08 00 00 00       	mov    eax,ds:0x8
		framebuffer_initialize(&fb_initial, (void*)video_mode.fnt,
      99:	8d 50 0f             	lea    edx,[eax+0xf]
      9c:	85 c0                	test   eax,eax
      9e:	0f 48 c2             	cmovs  eax,edx
      a1:	c1 f8 04             	sar    eax,0x4
      a4:	89 c7                	mov    edi,eax
						0, 0, /* char_ofs_xy*/ video_mode.width / 8,
      a6:	a1 04 00 00 00       	mov    eax,ds:0x4
		framebuffer_initialize(&fb_initial, (void*)video_mode.fnt,
      ab:	8d 50 07             	lea    edx,[eax+0x7]
      ae:	85 c0                	test   eax,eax
      b0:	0f 48 c2             	cmovs  eax,edx
      b3:	c1 f8 03             	sar    eax,0x3
      b6:	89 c6                	mov    esi,eax
						video_mode.height / 16, 0, 0, /* pxl_ofs_xy*/
      b8:	a1 08 00 00 00       	mov    eax,ds:0x8
		framebuffer_initialize(&fb_initial, (void*)video_mode.fnt,
      bd:	8d 50 0f             	lea    edx,[eax+0xf]
      c0:	85 c0                	test   eax,eax
      c2:	0f 48 c2             	cmovs  eax,edx
      c5:	c1 f8 04             	sar    eax,0x4
      c8:	89 c3                	mov    ebx,eax
						(void*)video_mode.txt,video_mode.width / 8,
      ca:	a1 04 00 00 00       	mov    eax,ds:0x4
		framebuffer_initialize(&fb_initial, (void*)video_mode.fnt,
      cf:	8d 50 07             	lea    edx,[eax+0x7]
      d2:	85 c0                	test   eax,eax
      d4:	0f 48 c2             	cmovs  eax,edx
      d7:	c1 f8 03             	sar    eax,0x3
      da:	89 c1                	mov    ecx,eax
						(void*)video_mode.txt,video_mode.width / 8,
      dc:	a1 14 00 00 00       	mov    eax,ds:0x14
		framebuffer_initialize(&fb_initial, (void*)video_mode.fnt,
      e1:	89 c2                	mov    edx,eax
      e3:	a1 10 00 00 00       	mov    eax,ds:0x10
      e8:	83 ec 04             	sub    esp,0x4
      eb:	57                   	push   edi
      ec:	56                   	push   esi
      ed:	6a 00                	push   0x0
      ef:	6a 00                	push   0x0
      f1:	6a 00                	push   0x0
      f3:	6a 00                	push   0x0
      f5:	53                   	push   ebx
      f6:	51                   	push   ecx
      f7:	52                   	push   edx
      f8:	50                   	push   eax
      f9:	68 00 00 00 00       	push   0x0
      fe:	e8 fc ff ff ff       	call   ff <fb_video_setup+0xc3>
     103:	83 c4 30             	add    esp,0x30
		kio_fb_resize();
     106:	e8 fc ff ff ff       	call   107 <fb_video_setup+0xcb>
		puts("done setting up the framebuffer");
     10b:	83 ec 0c             	sub    esp,0xc
     10e:	68 00 00 00 00       	push   0x0
     113:	e8 fc ff ff ff       	call   114 <fb_video_setup+0xd8>
     118:	83 c4 10             	add    esp,0x10
		framebuffer_redraw(&fb_initial);
     11b:	83 ec 0c             	sub    esp,0xc
     11e:	68 00 00 00 00       	push   0x0
     123:	e8 fc ff ff ff       	call   124 <fb_video_setup+0xe8>
     128:	83 c4 10             	add    esp,0x10
}
     12b:	90                   	nop
     12c:	8d 65 f4             	lea    esp,[ebp-0xc]
     12f:	5b                   	pop    ebx
     130:	5e                   	pop    esi
     131:	5f                   	pop    edi
     132:	5d                   	pop    ebp
     133:	c3                   	ret

00000134 <framebuffer_initialize>:
{
     134:	55                   	push   ebp
     135:	89 e5                	mov    ebp,esp
		fb->text_mem = textmem;
     137:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     13a:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     13d:	89 10                	mov    DWORD PTR [eax],edx
		fb->font = font;
     13f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     142:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     145:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
		fb->width = width;
     148:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     14b:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
     14e:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		fb->height = height;
     151:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     154:	8b 55 18             	mov    edx,DWORD PTR [ebp+0x18]
     157:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
		fb->is_visible = 1;
     15a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     15d:	c7 40 10 01 00 00 00 	mov    DWORD PTR [eax+0x10],0x1
		fb->cur_x = fb->cur_y = 0;
     164:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     167:	c7 40 18 00 00 00 00 	mov    DWORD PTR [eax+0x18],0x0
     16e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     171:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
     174:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     177:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
		fb->pix_x = pxl_ofs_x;
     17a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     17d:	8b 55 1c             	mov    edx,DWORD PTR [ebp+0x1c]
     180:	89 50 1c             	mov    DWORD PTR [eax+0x1c],edx
		fb->pix_y = pxl_ofs_y;
     183:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     186:	8b 55 20             	mov    edx,DWORD PTR [ebp+0x20]
     189:	89 50 20             	mov    DWORD PTR [eax+0x20],edx
		fb->cho_x = char_ofs_x;
     18c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     18f:	8b 55 24             	mov    edx,DWORD PTR [ebp+0x24]
     192:	89 50 24             	mov    DWORD PTR [eax+0x24],edx
		fb->cho_y = char_ofs_y;
     195:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     198:	8b 55 28             	mov    edx,DWORD PTR [ebp+0x28]
     19b:	89 50 28             	mov    DWORD PTR [eax+0x28],edx
		fb->chw_x = char_width_x;
     19e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1a1:	8b 55 2c             	mov    edx,DWORD PTR [ebp+0x2c]
     1a4:	89 50 2c             	mov    DWORD PTR [eax+0x2c],edx
		fb->chw_y = char_width_y;
     1a7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1aa:	8b 55 30             	mov    edx,DWORD PTR [ebp+0x30]
     1ad:	89 50 30             	mov    DWORD PTR [eax+0x30],edx
		fb->r_ud = NULL;
     1b0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1b3:	c7 40 34 00 00 00 00 	mov    DWORD PTR [eax+0x34],0x0
		fb->r_excl = NULL;
     1ba:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1bd:	c7 40 38 00 00 00 00 	mov    DWORD PTR [eax+0x38],0x0
}
     1c4:	90                   	nop
     1c5:	5d                   	pop    ebp
     1c6:	c3                   	ret

000001c7 <framebuffer_add_exclude_rect>:
{
     1c7:	55                   	push   ebp
     1c8:	89 e5                	mov    ebp,esp
     1ca:	53                   	push   ebx
		if (!r)
     1cb:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
     1cf:	74 2f                	je     200 <framebuffer_add_exclude_rect+0x39>
				r->next = fb->r_excl;
     1d1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1d4:	8b 50 38             	mov    edx,DWORD PTR [eax+0x38]
     1d7:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     1da:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
		} while (!__sync_bool_compare_and_swap(&fb->r_excl, r->next, r));
     1dd:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     1e0:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     1e3:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     1e6:	89 c3                	mov    ebx,eax
     1e8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1eb:	8d 48 38             	lea    ecx,[eax+0x38]
     1ee:	89 d8                	mov    eax,ebx
     1f0:	f0 0f b1 11          	lock cmpxchg DWORD PTR [ecx],edx
     1f4:	0f 94 c0             	sete   al
     1f7:	83 f0 01             	xor    eax,0x1
     1fa:	84 c0                	test   al,al
     1fc:	75 d3                	jne    1d1 <framebuffer_add_exclude_rect+0xa>
     1fe:	eb 01                	jmp    201 <framebuffer_add_exclude_rect+0x3a>
				return;
     200:	90                   	nop
}
     201:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     204:	c9                   	leave
     205:	c3                   	ret

00000206 <framebuffer_remove_exclude_rect>:
{
     206:	55                   	push   ebp
     207:	89 e5                	mov    ebp,esp
     209:	83 ec 10             	sub    esp,0x10
		er = &fb->r_excl;
     20c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     20f:	83 c0 38             	add    eax,0x38
     212:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		while ((r2 = *er)) {
     215:	eb 2c                	jmp    243 <framebuffer_remove_exclude_rect+0x3d>
				if (r2 == r) {
     217:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     21a:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
     21d:	75 1b                	jne    23a <framebuffer_remove_exclude_rect+0x34>
						if (__sync_bool_compare_and_swap(er, r, r->next))
     21f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     222:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
     225:	89 c1                	mov    ecx,eax
     227:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     22a:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
     22d:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [edx],ecx
     231:	0f 94 c0             	sete   al
     234:	84 c0                	test   al,al
     236:	75 1b                	jne    253 <framebuffer_remove_exclude_rect+0x4d>
								goto Pos1;
     238:	eb d2                	jmp    20c <framebuffer_remove_exclude_rect+0x6>
				er = &r2->next;
     23a:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
     23d:	83 c0 10             	add    eax,0x10
     240:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
		while ((r2 = *er)) {
     243:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     246:	8b 00                	mov    eax,DWORD PTR [eax]
     248:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
     24b:	83 7d f8 00          	cmp    DWORD PTR [ebp-0x8],0x0
     24f:	75 c6                	jne    217 <framebuffer_remove_exclude_rect+0x11>
     251:	eb 01                	jmp    254 <framebuffer_remove_exclude_rect+0x4e>
								return;
     253:	90                   	nop
}
     254:	c9                   	leave
     255:	c3                   	ret

00000256 <get_tm_color>:
{
     256:	55                   	push   ebp
     257:	89 e5                	mov    ebp,esp
     259:	83 ec 18             	sub    esp,0x18
     25c:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     25f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     262:	88 55 ec             	mov    BYTE PTR [ebp-0x14],dl
     265:	88 45 e8             	mov    BYTE PTR [ebp-0x18],al
		switch (btpp) {
     268:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     26b:	83 e8 04             	sub    eax,0x4
     26e:	83 f8 1c             	cmp    eax,0x1c
     271:	0f 87 10 01 00 00    	ja     387 <get_tm_color+0x131>
     277:	8b 04 85 20 00 00 00 	mov    eax,DWORD PTR [eax*4+0x20]
     27e:	ff e0                	jmp    eax
						if (is_set)
     280:	80 7d e8 00          	cmp    BYTE PTR [ebp-0x18],0x0
     284:	74 0c                	je     292 <get_tm_color+0x3c>
								return col & 0x0f;
     286:	0f be 45 ec          	movsx  eax,BYTE PTR [ebp-0x14]
     28a:	83 e0 0f             	and    eax,0xf
     28d:	e9 fa 00 00 00       	jmp    38c <get_tm_color+0x136>
								return (col >> 4) & 0x0f;
     292:	0f b6 45 ec          	movzx  eax,BYTE PTR [ebp-0x14]
     296:	c0 f8 04             	sar    al,0x4
     299:	0f be c0             	movsx  eax,al
     29c:	83 e0 0f             	and    eax,0xf
     29f:	e9 e8 00 00 00       	jmp    38c <get_tm_color+0x136>
						if (is_set)
     2a4:	80 7d e8 00          	cmp    BYTE PTR [ebp-0x18],0x0
     2a8:	74 0c                	je     2b6 <get_tm_color+0x60>
								return col & 0x0f;
     2aa:	0f be 45 ec          	movsx  eax,BYTE PTR [ebp-0x14]
     2ae:	83 e0 0f             	and    eax,0xf
     2b1:	e9 d6 00 00 00       	jmp    38c <get_tm_color+0x136>
								return (col >> 4) & 0x0f;
     2b6:	0f b6 45 ec          	movzx  eax,BYTE PTR [ebp-0x14]
     2ba:	c0 f8 04             	sar    al,0x4
     2bd:	0f be c0             	movsx  eax,al
     2c0:	83 e0 0f             	and    eax,0xf
     2c3:	e9 c4 00 00 00       	jmp    38c <get_tm_color+0x136>
						if (is_set)
     2c8:	80 7d e8 00          	cmp    BYTE PTR [ebp-0x18],0x0
     2cc:	74 13                	je     2e1 <get_tm_color+0x8b>
								iv = palette_32[col & 0x0f];
     2ce:	0f be 45 ec          	movsx  eax,BYTE PTR [ebp-0x14]
     2d2:	83 e0 0f             	and    eax,0xf
     2d5:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
     2dc:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
     2df:	eb 17                	jmp    2f8 <get_tm_color+0xa2>
								iv = palette_32[(col >> 4) & 0x0f];
     2e1:	0f b6 45 ec          	movzx  eax,BYTE PTR [ebp-0x14]
     2e5:	c0 f8 04             	sar    al,0x4
     2e8:	0f be c0             	movsx  eax,al
     2eb:	83 e0 0f             	and    eax,0xf
     2ee:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
     2f5:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
						if (btpp == 15)
     2f8:	83 7d 10 0f          	cmp    DWORD PTR [ebp+0x10],0xf
     2fc:	75 2d                	jne    32b <get_tm_color+0xd5>
								rv = (iv.b >> 3) | ((iv.g >> 3) << 5) | ((iv.r >> 3) << 10);
     2fe:	0f b6 45 f8          	movzx  eax,BYTE PTR [ebp-0x8]
     302:	c0 e8 03             	shr    al,0x3
     305:	0f b6 c0             	movzx  eax,al
     308:	0f b6 55 f9          	movzx  edx,BYTE PTR [ebp-0x7]
     30c:	c0 ea 03             	shr    dl,0x3
     30f:	0f b6 d2             	movzx  edx,dl
     312:	c1 e2 05             	shl    edx,0x5
     315:	09 c2                	or     edx,eax
     317:	0f b6 45 fa          	movzx  eax,BYTE PTR [ebp-0x6]
     31b:	c0 e8 03             	shr    al,0x3
     31e:	0f b6 c0             	movzx  eax,al
     321:	c1 e0 0a             	shl    eax,0xa
     324:	09 d0                	or     eax,edx
     326:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
     329:	eb 2b                	jmp    356 <get_tm_color+0x100>
								rv = (iv.b >> 3) | ((iv.g >> 2) << 5) | ((iv.r >> 3) << 11);
     32b:	0f b6 45 f8          	movzx  eax,BYTE PTR [ebp-0x8]
     32f:	c0 e8 03             	shr    al,0x3
     332:	0f b6 c0             	movzx  eax,al
     335:	0f b6 55 f9          	movzx  edx,BYTE PTR [ebp-0x7]
     339:	c0 ea 02             	shr    dl,0x2
     33c:	0f b6 d2             	movzx  edx,dl
     33f:	c1 e2 05             	shl    edx,0x5
     342:	09 c2                	or     edx,eax
     344:	0f b6 45 fa          	movzx  eax,BYTE PTR [ebp-0x6]
     348:	c0 e8 03             	shr    al,0x3
     34b:	0f b6 c0             	movzx  eax,al
     34e:	c1 e0 0b             	shl    eax,0xb
     351:	09 d0                	or     eax,edx
     353:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
						return rv;
     356:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
     359:	eb 31                	jmp    38c <get_tm_color+0x136>
						if (is_set)
     35b:	80 7d e8 00          	cmp    BYTE PTR [ebp-0x18],0x0
     35f:	74 10                	je     371 <get_tm_color+0x11b>
								return palette_32[col & 0x0f].val;
     361:	0f be 45 ec          	movsx  eax,BYTE PTR [ebp-0x14]
     365:	83 e0 0f             	and    eax,0xf
     368:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
     36f:	eb 1b                	jmp    38c <get_tm_color+0x136>
								return palette_32[(col >> 4) & 0x0f].val;
     371:	0f b6 45 ec          	movzx  eax,BYTE PTR [ebp-0x14]
     375:	c0 f8 04             	sar    al,0x4
     378:	0f be c0             	movsx  eax,al
     37b:	83 e0 0f             	and    eax,0xf
     37e:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [eax*4+0x0]
     385:	eb 05                	jmp    38c <get_tm_color+0x136>
		return 0x2f0c0c2f; /* canary */
     387:	b8 2f 0c 0c 2f       	mov    eax,0x2f0c0c2f
}
     38c:	c9                   	leave
     38d:	c3                   	ret

0000038e <generate_char_colors>:
{
     38e:	55                   	push   ebp
     38f:	89 e5                	mov    ebp,esp
     391:	53                   	push   ebx
     392:	83 ec 24             	sub    esp,0x24
     395:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
     398:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     39b:	88 55 e4             	mov    BYTE PTR [ebp-0x1c],dl
     39e:	88 45 e0             	mov    BYTE PTR [ebp-0x20],al
		int rv = 0;
     3a1:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		uint8_t f = (uint8_t)font[c * 16];
     3a8:	0f be 45 e4          	movsx  eax,BYTE PTR [ebp-0x1c]
     3ac:	c1 e0 04             	shl    eax,0x4
     3af:	89 c2                	mov    edx,eax
     3b1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3b4:	01 d0                	add    eax,edx
     3b6:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     3b9:	88 45 ef             	mov    BYTE PTR [ebp-0x11],al
		for (; r < rmax; r++) {
     3bc:	e9 fd 00 00 00       	jmp    4be <generate_char_colors+0x130>
				int is_set = f & (1 << (7 - r));
     3c1:	0f b6 55 ef          	movzx  edx,BYTE PTR [ebp-0x11]
     3c5:	b8 07 00 00 00       	mov    eax,0x7
     3ca:	2b 45 18             	sub    eax,DWORD PTR [ebp+0x18]
     3cd:	bb 01 00 00 00       	mov    ebx,0x1
     3d2:	89 c1                	mov    ecx,eax
     3d4:	d3 e3                	shl    ebx,cl
     3d6:	89 d8                	mov    eax,ebx
     3d8:	21 d0                	and    eax,edx
     3da:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				if (inv)
     3dd:	83 7d 24 00          	cmp    DWORD PTR [ebp+0x24],0x0
     3e1:	74 0d                	je     3f0 <generate_char_colors+0x62>
						is_set = !is_set;
     3e3:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     3e7:	0f 94 c0             	sete   al
     3ea:	0f b6 c0             	movzx  eax,al
     3ed:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				cv = get_tm_color(fmt, is_set, btpp);
     3f0:	8b 4d 14             	mov    ecx,DWORD PTR [ebp+0x14]
     3f3:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     3f6:	0f be d0             	movsx  edx,al
     3f9:	0f be 45 e0          	movsx  eax,BYTE PTR [ebp-0x20]
     3fd:	51                   	push   ecx
     3fe:	52                   	push   edx
     3ff:	50                   	push   eax
     400:	e8 fc ff ff ff       	call   401 <generate_char_colors+0x73>
     405:	83 c4 0c             	add    esp,0xc
     408:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				switch (btpp) {
     40b:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     40e:	83 e8 04             	sub    eax,0x4
     411:	83 f8 1c             	cmp    eax,0x1c
     414:	0f 87 a0 00 00 00    	ja     4ba <generate_char_colors+0x12c>
     41a:	8b 04 85 a8 00 00 00 	mov    eax,DWORD PTR [eax*4+0xa8]
     421:	ff e0                	jmp    eax
								*(uint32_t*)cvs = (uint32_t)cv;
     423:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     426:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
     429:	89 10                	mov    DWORD PTR [eax],edx
								cvs += 4; rv += 32;
     42b:	83 45 20 04          	add    DWORD PTR [ebp+0x20],0x4
     42f:	83 45 f4 20          	add    DWORD PTR [ebp-0xc],0x20
								break;
     433:	e9 82 00 00 00       	jmp    4ba <generate_char_colors+0x12c>
								*(uint16_t*)cvs = (uint16_t)(cv & 0xffff);
     438:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     43b:	89 c2                	mov    edx,eax
     43d:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     440:	66 89 10             	mov    WORD PTR [eax],dx
								cvs += 2;
     443:	83 45 20 02          	add    DWORD PTR [ebp+0x20],0x2
								*(uint8_t*)cvs++ = (uint8_t)(cv >> 16);
     447:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     44a:	c1 e8 10             	shr    eax,0x10
     44d:	89 c1                	mov    ecx,eax
     44f:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     452:	8d 50 01             	lea    edx,[eax+0x1]
     455:	89 55 20             	mov    DWORD PTR [ebp+0x20],edx
     458:	89 ca                	mov    edx,ecx
     45a:	88 10                	mov    BYTE PTR [eax],dl
								rv += 24;
     45c:	83 45 f4 18          	add    DWORD PTR [ebp-0xc],0x18
								break;
     460:	eb 58                	jmp    4ba <generate_char_colors+0x12c>
								*(uint16_t*)cvs = (uint16_t)cv;
     462:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     465:	89 c2                	mov    edx,eax
     467:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     46a:	66 89 10             	mov    WORD PTR [eax],dx
								cvs += 2; rv += 16; /* even for 15 */
     46d:	83 45 20 02          	add    DWORD PTR [ebp+0x20],0x2
     471:	83 45 f4 10          	add    DWORD PTR [ebp-0xc],0x10
								break;
     475:	eb 43                	jmp    4ba <generate_char_colors+0x12c>
								*cvs++ = (uint8_t)cv; rv += 8;
     477:	8b 45 20             	mov    eax,DWORD PTR [ebp+0x20]
     47a:	8d 50 01             	lea    edx,[eax+0x1]
     47d:	89 55 20             	mov    DWORD PTR [ebp+0x20],edx
     480:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
     483:	88 10                	mov    BYTE PTR [eax],dl
     485:	83 45 f4 08          	add    DWORD PTR [ebp-0xc],0x8
								break;
     489:	eb 2f                	jmp    4ba <generate_char_colors+0x12c>
								rv += 4;
     48b:	83 45 f4 04          	add    DWORD PTR [ebp-0xc],0x4
								die("also complicated!\n");
     48f:	83 ec 08             	sub    esp,0x8
     492:	68 94 00 00 00       	push   0x94
     497:	6a 0c                	push   0xc
     499:	e8 fc ff ff ff       	call   49a <generate_char_colors+0x10c>
     49e:	83 c4 10             	add    esp,0x10
     4a1:	e8 fc ff ff ff       	call   4a2 <generate_char_colors+0x114>
     4a6:	83 ec 0c             	sub    esp,0xc
     4a9:	68 00 00 00 00       	push   0x0
     4ae:	e8 fc ff ff ff       	call   4af <generate_char_colors+0x121>
     4b3:	83 c4 10             	add    esp,0x10
     4b6:	fa                   	cli
     4b7:	f4                   	hlt
     4b8:	eb fd                	jmp    4b7 <generate_char_colors+0x129>
		for (; r < rmax; r++) {
     4ba:	83 45 18 01          	add    DWORD PTR [ebp+0x18],0x1
     4be:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     4c1:	3b 45 1c             	cmp    eax,DWORD PTR [ebp+0x1c]
     4c4:	0f 8c f7 fe ff ff    	jl     3c1 <generate_char_colors+0x33>
		return rv;
     4ca:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
     4cd:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     4d0:	c9                   	leave
     4d1:	c3                   	ret

000004d2 <render_text_scanline_32btpp_sse>:
{
     4d2:	55                   	push   ebp
     4d3:	89 e5                	mov    ebp,esp
     4d5:	53                   	push   ebx
     4d6:	83 ec 64             	sub    esp,0x64
		ssize_t misalign = ((size_t)mem % 16) ? (16 - (size_t)mem % 16) : 0;
     4d9:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     4dc:	83 e0 0f             	and    eax,0xf
     4df:	85 c0                	test   eax,eax
     4e1:	74 11                	je     4f4 <render_text_scanline_32btpp_sse+0x22>
     4e3:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     4e6:	83 e0 0f             	and    eax,0xf
     4e9:	ba 10 00 00 00       	mov    edx,0x10
     4ee:	29 c2                	sub    edx,eax
     4f0:	89 d0                	mov    eax,edx
     4f2:	eb 05                	jmp    4f9 <render_text_scanline_32btpp_sse+0x27>
     4f4:	b8 00 00 00 00       	mov    eax,0x0
     4f9:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		ssize_t r = p0_x % 8;
     4fc:	8b 55 1c             	mov    edx,DWORD PTR [ebp+0x1c]
     4ff:	89 d0                	mov    eax,edx
     501:	c1 f8 1f             	sar    eax,0x1f
     504:	c1 e8 1d             	shr    eax,0x1d
     507:	01 c2                	add    edx,eax
     509:	83 e2 07             	and    edx,0x7
     50c:	29 c2                	sub    edx,eax
     50e:	89 55 e8             	mov    DWORD PTR [ebp-0x18],edx
		uint8_t* pixbuf = pxb + (((size_t)pxb % 16) ? (16 - ((size_t)pxb % 16)) : 0);
     511:	8d 45 9d             	lea    eax,[ebp-0x63]
     514:	83 e0 0f             	and    eax,0xf
     517:	85 c0                	test   eax,eax
     519:	74 11                	je     52c <render_text_scanline_32btpp_sse+0x5a>
     51b:	8d 45 9d             	lea    eax,[ebp-0x63]
     51e:	83 e0 0f             	and    eax,0xf
     521:	89 c2                	mov    edx,eax
     523:	b8 10 00 00 00       	mov    eax,0x10
     528:	29 d0                	sub    eax,edx
     52a:	eb 05                	jmp    531 <render_text_scanline_32btpp_sse+0x5f>
     52c:	b8 00 00 00 00       	mov    eax,0x0
     531:	8d 55 9d             	lea    edx,[ebp-0x63]
     534:	01 d0                	add    eax,edx
     536:	89 45 98             	mov    DWORD PTR [ebp-0x68],eax
		if (misalign) { /* LFB is dword aligned, we want (dq/o)word access */
     539:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     53d:	0f 84 1a 03 00 00    	je     85d <render_text_scanline_32btpp_sse+0x38b>
				int col = p0_x / 8, inv = (col == cur_x);
     543:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     546:	8d 50 07             	lea    edx,[eax+0x7]
     549:	85 c0                	test   eax,eax
     54b:	0f 48 c2             	cmovs  eax,edx
     54e:	c1 f8 03             	sar    eax,0x3
     551:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
     554:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     557:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
     55a:	0f 94 c0             	sete   al
     55d:	0f b6 c0             	movzx  eax,al
     560:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
				ssize_t bc = min(misalign, 4 * px_x);
     563:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     566:	c1 e0 02             	shl    eax,0x2
     569:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     56c:	39 c2                	cmp    edx,eax
     56e:	0f 4e c2             	cmovle eax,edx
     571:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
				ssize_t cc = rdiv(misalign, 4);
     574:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     577:	8d 50 03             	lea    edx,[eax+0x3]
     57a:	85 c0                	test   eax,eax
     57c:	0f 48 c2             	cmovs  eax,edx
     57f:	c1 f8 02             	sar    eax,0x2
     582:	89 c2                	mov    edx,eax
     584:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     587:	83 e0 03             	and    eax,0x3
     58a:	85 c0                	test   eax,eax
     58c:	0f 95 c0             	setne  al
     58f:	0f b6 c0             	movzx  eax,al
     592:	01 d0                	add    eax,edx
     594:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
				ssize_t rmax = min(8, r + cc), cc1 = rmax - r;
     597:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
     59a:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     59d:	01 d0                	add    eax,edx
     59f:	ba 08 00 00 00       	mov    edx,0x8
     5a4:	39 d0                	cmp    eax,edx
     5a6:	0f 4f c2             	cmovg  eax,edx
     5a9:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
     5ac:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     5af:	2b 45 e8             	sub    eax,DWORD PTR [ebp-0x18]
     5b2:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
				generate_char_colors(font, str[0], str[1], 32,
     5b5:	8b 4d 98             	mov    ecx,DWORD PTR [ebp-0x68]
     5b8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     5bb:	83 c0 01             	add    eax,0x1
     5be:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     5c1:	0f be d0             	movsx  edx,al
     5c4:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     5c7:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     5ca:	0f be c0             	movsx  eax,al
     5cd:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
     5d0:	51                   	push   ecx
     5d1:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
     5d4:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
     5d7:	6a 20                	push   0x20
     5d9:	52                   	push   edx
     5da:	50                   	push   eax
     5db:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     5de:	e8 fc ff ff ff       	call   5df <render_text_scanline_32btpp_sse+0x10d>
     5e3:	83 c4 20             	add    esp,0x20
				if (rmax == 8)
     5e6:	83 7d d4 08          	cmp    DWORD PTR [ebp-0x2c],0x8
     5ea:	75 04                	jne    5f0 <render_text_scanline_32btpp_sse+0x11e>
						str += 2;
     5ec:	83 45 0c 02          	add    DWORD PTR [ebp+0xc],0x2
				if (cc > cc1) { /* generate the new char */
     5f0:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     5f3:	3b 45 d0             	cmp    eax,DWORD PTR [ebp-0x30]
     5f6:	7e 52                	jle    64a <render_text_scanline_32btpp_sse+0x178>
						col++; inv = (col == cur_x);
     5f8:	83 45 e4 01          	add    DWORD PTR [ebp-0x1c],0x1
     5fc:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     5ff:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
     602:	0f 94 c0             	sete   al
     605:	0f b6 c0             	movzx  eax,al
     608:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
						generate_char_colors(font, str[0], str[1], 32,
     60b:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
										0, cc - cc1, pixbuf + cc1 * 4, inv);
     60e:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
     611:	c1 e2 02             	shl    edx,0x2
						generate_char_colors(font, str[0], str[1], 32,
     614:	8d 1c 10             	lea    ebx,[eax+edx*1]
     617:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     61a:	2b 45 d0             	sub    eax,DWORD PTR [ebp-0x30]
     61d:	89 c1                	mov    ecx,eax
     61f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     622:	83 c0 01             	add    eax,0x1
     625:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     628:	0f be d0             	movsx  edx,al
     62b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     62e:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     631:	0f be c0             	movsx  eax,al
     634:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
     637:	53                   	push   ebx
     638:	51                   	push   ecx
     639:	6a 00                	push   0x0
     63b:	6a 20                	push   0x20
     63d:	52                   	push   edx
     63e:	50                   	push   eax
     63f:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     642:	e8 fc ff ff ff       	call   643 <render_text_scanline_32btpp_sse+0x171>
     647:	83 c4 20             	add    esp,0x20
				memcpy(mem, pixbuf, bc);
     64a:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
     64d:	8b 55 98             	mov    edx,DWORD PTR [ebp-0x68]
     650:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     653:	83 ec 04             	sub    esp,0x4
     656:	51                   	push   ecx
     657:	52                   	push   edx
     658:	50                   	push   eax
     659:	e8 a2 f9 ff ff       	call   0 <memcpy>
     65e:	83 c4 10             	add    esp,0x10
				px_x -= cc;
     661:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     664:	29 45 14             	sub    DWORD PTR [ebp+0x14],eax
				p0_x += cc;
     667:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     66a:	01 45 1c             	add    DWORD PTR [ebp+0x1c],eax
				mem += bc;
     66d:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     670:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     673:	01 d0                	add    eax,edx
     675:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
		while (px_x) {
     678:	e9 e0 01 00 00       	jmp    85d <render_text_scanline_32btpp_sse+0x38b>
				int col = p0_x / 8, inv = (col == cur_x);
     67d:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     680:	8d 50 07             	lea    edx,[eax+0x7]
     683:	85 c0                	test   eax,eax
     685:	0f 48 c2             	cmovs  eax,edx
     688:	c1 f8 03             	sar    eax,0x3
     68b:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
     68e:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     691:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
     694:	0f 94 c0             	sete   al
     697:	0f b6 c0             	movzx  eax,al
     69a:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
				ssize_t rmax, bitc, btt = min(128, 32 * px_x);
     69d:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     6a0:	c1 e0 05             	shl    eax,0x5
     6a3:	ba 80 00 00 00       	mov    edx,0x80
     6a8:	39 d0                	cmp    eax,edx
     6aa:	0f 4f c2             	cmovg  eax,edx
     6ad:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
				r = p0_x % 8;
     6b0:	8b 55 1c             	mov    edx,DWORD PTR [ebp+0x1c]
     6b3:	89 d0                	mov    eax,edx
     6b5:	c1 f8 1f             	sar    eax,0x1f
     6b8:	c1 e8 1d             	shr    eax,0x1d
     6bb:	01 c2                	add    edx,eax
     6bd:	83 e2 07             	and    edx,0x7
     6c0:	29 c2                	sub    edx,eax
     6c2:	89 55 e8             	mov    DWORD PTR [ebp-0x18],edx
				rmax = min(8, r + min(4, px_x)); /* only 4 pixels */
     6c5:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     6c8:	ba 04 00 00 00       	mov    edx,0x4
     6cd:	39 d0                	cmp    eax,edx
     6cf:	0f 4e d0             	cmovle edx,eax
     6d2:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     6d5:	01 d0                	add    eax,edx
     6d7:	ba 08 00 00 00       	mov    edx,0x8
     6dc:	39 d0                	cmp    eax,edx
     6de:	0f 4f c2             	cmovg  eax,edx
     6e1:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
				bitc = generate_char_colors(font, str[0], str[1], 32,
     6e4:	8b 4d 98             	mov    ecx,DWORD PTR [ebp-0x68]
     6e7:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     6ea:	83 c0 01             	add    eax,0x1
     6ed:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     6f0:	0f be d0             	movsx  edx,al
     6f3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     6f6:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     6f9:	0f be c0             	movsx  eax,al
     6fc:	ff 75 c8             	push   DWORD PTR [ebp-0x38]
     6ff:	51                   	push   ecx
     700:	ff 75 c0             	push   DWORD PTR [ebp-0x40]
     703:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
     706:	6a 20                	push   0x20
     708:	52                   	push   edx
     709:	50                   	push   eax
     70a:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     70d:	e8 fc ff ff ff       	call   70e <render_text_scanline_32btpp_sse+0x23c>
     712:	83 c4 20             	add    esp,0x20
     715:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				if (rmax == 8)
     718:	83 7d c0 08          	cmp    DWORD PTR [ebp-0x40],0x8
     71c:	75 04                	jne    722 <render_text_scanline_32btpp_sse+0x250>
						str += 2;
     71e:	83 45 0c 02          	add    DWORD PTR [ebp+0xc],0x2
				if (bitc < btt) {
     722:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     725:	3b 45 c4             	cmp    eax,DWORD PTR [ebp-0x3c]
     728:	7d 6b                	jge    795 <render_text_scanline_32btpp_sse+0x2c3>
						col++; int pc = (btt - bitc) / 32;
     72a:	83 45 cc 01          	add    DWORD PTR [ebp-0x34],0x1
     72e:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
     731:	2b 45 f4             	sub    eax,DWORD PTR [ebp-0xc]
     734:	8d 50 1f             	lea    edx,[eax+0x1f]
     737:	85 c0                	test   eax,eax
     739:	0f 48 c2             	cmovs  eax,edx
     73c:	c1 f8 05             	sar    eax,0x5
     73f:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
						inv = (col == cur_x);
     742:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     745:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
     748:	0f 94 c0             	sete   al
     74b:	0f b6 c0             	movzx  eax,al
     74e:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
						bitc += generate_char_colors(font, str[0], str[1], 32,
     751:	8b 55 98             	mov    edx,DWORD PTR [ebp-0x68]
										0, pc, pixbuf + bitc / 32, inv);
     754:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     757:	8d 48 1f             	lea    ecx,[eax+0x1f]
     75a:	85 c0                	test   eax,eax
     75c:	0f 48 c1             	cmovs  eax,ecx
     75f:	c1 f8 05             	sar    eax,0x5
						bitc += generate_char_colors(font, str[0], str[1], 32,
     762:	8d 0c 02             	lea    ecx,[edx+eax*1]
     765:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     768:	83 c0 01             	add    eax,0x1
     76b:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     76e:	0f be d0             	movsx  edx,al
     771:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     774:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     777:	0f be c0             	movsx  eax,al
     77a:	ff 75 c8             	push   DWORD PTR [ebp-0x38]
     77d:	51                   	push   ecx
     77e:	ff 75 bc             	push   DWORD PTR [ebp-0x44]
     781:	6a 00                	push   0x0
     783:	6a 20                	push   0x20
     785:	52                   	push   edx
     786:	50                   	push   eax
     787:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     78a:	e8 fc ff ff ff       	call   78b <render_text_scanline_32btpp_sse+0x2b9>
     78f:	83 c4 20             	add    esp,0x20
     792:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
				if (bitc >= 128) {
     795:	83 7d f4 7f          	cmp    DWORD PTR [ebp-0xc],0x7f
     799:	7e 21                	jle    7bc <render_text_scanline_32btpp_sse+0x2ea>
						move_128(pixbuf, mem);
     79b:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
     79e:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     7a1:	0f 28 00             	movaps xmm0,XMMWORD PTR [eax]
     7a4:	0f 29 02             	movaps XMMWORD PTR [edx],xmm0
						mem += 16; /* intentionally no bitc subtract */
     7a7:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     7aa:	83 c0 10             	add    eax,0x10
     7ad:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
				if (px_x) {
     7b0:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     7b4:	0f 84 af 00 00 00    	je     869 <render_text_scanline_32btpp_sse+0x397>
     7ba:	eb 7d                	jmp    839 <render_text_scanline_32btpp_sse+0x367>
						uint8_t* pt = pixbuf;
     7bc:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
     7bf:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
						if (bitc >= 64) {
     7c2:	83 7d f4 3f          	cmp    DWORD PTR [ebp-0xc],0x3f
     7c6:	7e 1d                	jle    7e5 <render_text_scanline_32btpp_sse+0x313>
								move_64(pixbuf, mem);
     7c8:	8b 45 98             	mov    eax,DWORD PTR [ebp-0x68]
     7cb:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     7ce:	0f 6f 00             	movq   mm0,QWORD PTR [eax]
     7d1:	0f 7f 02             	movq   QWORD PTR [edx],mm0
								pt += 8;
     7d4:	83 45 f0 08          	add    DWORD PTR [ebp-0x10],0x8
								mem += 8;
     7d8:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     7db:	83 c0 08             	add    eax,0x8
     7de:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
								bitc -= 64;
     7e1:	83 6d f4 40          	sub    DWORD PTR [ebp-0xc],0x40
						if (bitc >= 32) {
     7e5:	83 7d f4 1f          	cmp    DWORD PTR [ebp-0xc],0x1f
     7e9:	7e 1d                	jle    808 <render_text_scanline_32btpp_sse+0x336>
								*(uint32_t*)mem = *(uint32_t*)pt;
     7eb:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     7ee:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     7f1:	8b 12                	mov    edx,DWORD PTR [edx]
     7f3:	89 10                	mov    DWORD PTR [eax],edx
								pt += 4;
     7f5:	83 45 f0 04          	add    DWORD PTR [ebp-0x10],0x4
								mem += 4;
     7f9:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     7fc:	83 c0 04             	add    eax,0x4
     7ff:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
								bitc -= 32;
     802:	83 6d f4 20          	sub    DWORD PTR [ebp-0xc],0x20
						break;
     806:	eb 64                	jmp    86c <render_text_scanline_32btpp_sse+0x39a>
						} else if (bitc) {
     808:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     80c:	74 5e                	je     86c <render_text_scanline_32btpp_sse+0x39a>
								die("cant happen with dword sized pixels!\n");
     80e:	83 ec 08             	sub    esp,0x8
     811:	68 1c 01 00 00       	push   0x11c
     816:	6a 0c                	push   0xc
     818:	e8 fc ff ff ff       	call   819 <render_text_scanline_32btpp_sse+0x347>
     81d:	83 c4 10             	add    esp,0x10
     820:	e8 fc ff ff ff       	call   821 <render_text_scanline_32btpp_sse+0x34f>
     825:	83 ec 0c             	sub    esp,0xc
     828:	68 00 00 00 00       	push   0x0
     82d:	e8 fc ff ff ff       	call   82e <render_text_scanline_32btpp_sse+0x35c>
     832:	83 c4 10             	add    esp,0x10
     835:	fa                   	cli
     836:	f4                   	hlt
     837:	eb fd                	jmp    836 <render_text_scanline_32btpp_sse+0x364>
						px_x -= bitc / 32;
     839:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     83c:	8d 50 1f             	lea    edx,[eax+0x1f]
     83f:	85 c0                	test   eax,eax
     841:	0f 48 c2             	cmovs  eax,edx
     844:	c1 f8 05             	sar    eax,0x5
     847:	f7 d8                	neg    eax
     849:	01 45 14             	add    DWORD PTR [ebp+0x14],eax
						p0_x += bitc / 32; /* unneccessary as r does not change anymore */
     84c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     84f:	8d 50 1f             	lea    edx,[eax+0x1f]
     852:	85 c0                	test   eax,eax
     854:	0f 48 c2             	cmovs  eax,edx
     857:	c1 f8 05             	sar    eax,0x5
     85a:	01 45 1c             	add    DWORD PTR [ebp+0x1c],eax
		while (px_x) {
     85d:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     861:	0f 85 16 fe ff ff    	jne    67d <render_text_scanline_32btpp_sse+0x1ab>
				} else
						break;
		}
}
     867:	eb 04                	jmp    86d <render_text_scanline_32btpp_sse+0x39b>
						break;
     869:	90                   	nop
     86a:	eb 01                	jmp    86d <render_text_scanline_32btpp_sse+0x39b>
						break;
     86c:	90                   	nop
}
     86d:	90                   	nop
     86e:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     871:	c9                   	leave
     872:	c3                   	ret

00000873 <render_text_scanline_24btpp_sse>:

/* we're generating 3byte colorvalues /w unknown alignment. To enable
 * 16 byte transfers, 6 pixels /w 18 bytes have to be generated. */
void render_text_scanline_24btpp_sse(const char* font, char* str, void* mem,
				ssize_t px_x, ssize_t cur_x, ssize_t p0_x)
{
     873:	55                   	push   ebp
     874:	89 e5                	mov    ebp,esp
     876:	53                   	push   ebx
     877:	83 ec 74             	sub    esp,0x74
		uint8_t pxb[18 + 2 + 15]; /* 15 for stack alignment, 2 for bt_ofs */
		ssize_t misalign = ((size_t)mem % 16) ? (16 - (size_t)mem % 16) : 0;
     87a:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     87d:	83 e0 0f             	and    eax,0xf
     880:	85 c0                	test   eax,eax
     882:	74 11                	je     895 <render_text_scanline_24btpp_sse+0x22>
     884:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     887:	83 e0 0f             	and    eax,0xf
     88a:	ba 10 00 00 00       	mov    edx,0x10
     88f:	29 c2                	sub    edx,eax
     891:	89 d0                	mov    eax,edx
     893:	eb 05                	jmp    89a <render_text_scanline_24btpp_sse+0x27>
     895:	b8 00 00 00 00       	mov    eax,0x0
     89a:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		ssize_t r = p0_x % 8;
     89d:	8b 55 1c             	mov    edx,DWORD PTR [ebp+0x1c]
     8a0:	89 d0                	mov    eax,edx
     8a2:	c1 f8 1f             	sar    eax,0x1f
     8a5:	c1 e8 1d             	shr    eax,0x1d
     8a8:	01 c2                	add    edx,eax
     8aa:	83 e2 07             	and    edx,0x7
     8ad:	29 c2                	sub    edx,eax
     8af:	89 55 e0             	mov    DWORD PTR [ebp-0x20],edx
		uint8_t* pixbuf = pxb + (((size_t)pxb % 16) ? (16 - ((size_t)pxb % 16)) : 0);
     8b2:	8d 45 91             	lea    eax,[ebp-0x6f]
     8b5:	83 e0 0f             	and    eax,0xf
     8b8:	85 c0                	test   eax,eax
     8ba:	74 11                	je     8cd <render_text_scanline_24btpp_sse+0x5a>
     8bc:	8d 45 91             	lea    eax,[ebp-0x6f]
     8bf:	83 e0 0f             	and    eax,0xf
     8c2:	89 c2                	mov    edx,eax
     8c4:	b8 10 00 00 00       	mov    eax,0x10
     8c9:	29 d0                	sub    eax,edx
     8cb:	eb 05                	jmp    8d2 <render_text_scanline_24btpp_sse+0x5f>
     8cd:	b8 00 00 00 00       	mov    eax,0x0
     8d2:	8d 55 91             	lea    edx,[ebp-0x6f]
     8d5:	01 d0                	add    eax,edx
     8d7:	89 45 8c             	mov    DWORD PTR [ebp-0x74],eax
		ssize_t bt_ofs = 0; /* used to control writing into pixbuf (1/3 pixels)*/
     8da:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		/* 64-bit aligned moves are enough */

		if (misalign) { /* LFB is dword aligned, we want (dq/o)word access */
     8e1:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
     8e5:	0f 84 11 04 00 00    	je     cfc <render_text_scanline_24btpp_sse+0x489>
				int col = p0_x / 8, inv = (col == cur_x);
     8eb:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     8ee:	8d 50 07             	lea    edx,[eax+0x7]
     8f1:	85 c0                	test   eax,eax
     8f3:	0f 48 c2             	cmovs  eax,edx
     8f6:	c1 f8 03             	sar    eax,0x3
     8f9:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
     8fc:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     8ff:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
     902:	0f 94 c0             	sete   al
     905:	0f b6 c0             	movzx  eax,al
     908:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
				ssize_t bc = min(misalign, 3 * px_x);
     90b:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
     90e:	89 d0                	mov    eax,edx
     910:	01 c0                	add    eax,eax
     912:	01 d0                	add    eax,edx
     914:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
     917:	39 c2                	cmp    edx,eax
     919:	0f 4e c2             	cmovle eax,edx
     91c:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				ssize_t cc = rdiv(bc, 3);
     91f:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
     922:	ba 56 55 55 55       	mov    edx,0x55555556
     927:	89 c8                	mov    eax,ecx
     929:	f7 ea                	imul   edx
     92b:	89 c8                	mov    eax,ecx
     92d:	c1 f8 1f             	sar    eax,0x1f
     930:	89 d3                	mov    ebx,edx
     932:	29 c3                	sub    ebx,eax
     934:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
     937:	ba 56 55 55 55       	mov    edx,0x55555556
     93c:	89 c8                	mov    eax,ecx
     93e:	f7 ea                	imul   edx
     940:	89 c8                	mov    eax,ecx
     942:	c1 f8 1f             	sar    eax,0x1f
     945:	29 c2                	sub    edx,eax
     947:	89 d0                	mov    eax,edx
     949:	01 c0                	add    eax,eax
     94b:	01 d0                	add    eax,edx
     94d:	29 c1                	sub    ecx,eax
     94f:	89 ca                	mov    edx,ecx
     951:	85 d2                	test   edx,edx
     953:	0f 95 c0             	setne  al
     956:	0f b6 c0             	movzx  eax,al
     959:	01 d8                	add    eax,ebx
     95b:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
				ssize_t rmax = min(8, r + cc), cc1 = rmax - r;
     95e:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
     961:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     964:	01 d0                	add    eax,edx
     966:	ba 08 00 00 00       	mov    edx,0x8
     96b:	39 d0                	cmp    eax,edx
     96d:	0f 4f c2             	cmovg  eax,edx
     970:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
     973:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     976:	2b 45 e0             	sub    eax,DWORD PTR [ebp-0x20]
     979:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax

				generate_char_colors(font, str[0], str[1], 24,
     97c:	8b 4d 8c             	mov    ecx,DWORD PTR [ebp-0x74]
     97f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     982:	83 c0 01             	add    eax,0x1
     985:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     988:	0f be d0             	movsx  edx,al
     98b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     98e:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     991:	0f be c0             	movsx  eax,al
     994:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
     997:	51                   	push   ecx
     998:	ff 75 cc             	push   DWORD PTR [ebp-0x34]
     99b:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
     99e:	6a 18                	push   0x18
     9a0:	52                   	push   edx
     9a1:	50                   	push   eax
     9a2:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     9a5:	e8 fc ff ff ff       	call   9a6 <render_text_scanline_24btpp_sse+0x133>
     9aa:	83 c4 20             	add    esp,0x20
								r, rmax, pixbuf, inv);
				if (rmax == 8)
     9ad:	83 7d cc 08          	cmp    DWORD PTR [ebp-0x34],0x8
     9b1:	75 04                	jne    9b7 <render_text_scanline_24btpp_sse+0x144>
						str += 2;
     9b3:	83 45 0c 02          	add    DWORD PTR [ebp+0xc],0x2
				if (cc > cc1) { /* generate the new char */
     9b7:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     9ba:	3b 45 c8             	cmp    eax,DWORD PTR [ebp-0x38]
     9bd:	7e 55                	jle    a14 <render_text_scanline_24btpp_sse+0x1a1>
						col++; inv = (col == cur_x);
     9bf:	83 45 dc 01          	add    DWORD PTR [ebp-0x24],0x1
     9c3:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     9c6:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
     9c9:	0f 94 c0             	sete   al
     9cc:	0f b6 c0             	movzx  eax,al
     9cf:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
						generate_char_colors(font, str[0], str[1], 24,
     9d2:	8b 4d 8c             	mov    ecx,DWORD PTR [ebp-0x74]
										0, cc - cc1, pixbuf + cc1 * 3, inv);
     9d5:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
     9d8:	89 d0                	mov    eax,edx
     9da:	01 c0                	add    eax,eax
     9dc:	01 d0                	add    eax,edx
						generate_char_colors(font, str[0], str[1], 24,
     9de:	8d 1c 01             	lea    ebx,[ecx+eax*1]
     9e1:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     9e4:	2b 45 c8             	sub    eax,DWORD PTR [ebp-0x38]
     9e7:	89 c1                	mov    ecx,eax
     9e9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     9ec:	83 c0 01             	add    eax,0x1
     9ef:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     9f2:	0f be d0             	movsx  edx,al
     9f5:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     9f8:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     9fb:	0f be c0             	movsx  eax,al
     9fe:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
     a01:	53                   	push   ebx
     a02:	51                   	push   ecx
     a03:	6a 00                	push   0x0
     a05:	6a 18                	push   0x18
     a07:	52                   	push   edx
     a08:	50                   	push   eax
     a09:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     a0c:	e8 fc ff ff ff       	call   a0d <render_text_scanline_24btpp_sse+0x19a>
     a11:	83 c4 20             	add    esp,0x20
				}
				memcpy(mem, pixbuf, bc);
     a14:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
     a17:	8b 55 8c             	mov    edx,DWORD PTR [ebp-0x74]
     a1a:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     a1d:	83 ec 04             	sub    esp,0x4
     a20:	51                   	push   ecx
     a21:	52                   	push   edx
     a22:	50                   	push   eax
     a23:	e8 d8 f5 ff ff       	call   0 <memcpy>
     a28:	83 c4 10             	add    esp,0x10
				/* now indicate the remaining pixel part if there and
				 * copy the data to the front for the later transfer */
				if (bc % 3) {
     a2b:	8b 4d d4             	mov    ecx,DWORD PTR [ebp-0x2c]
     a2e:	ba 56 55 55 55       	mov    edx,0x55555556
     a33:	89 c8                	mov    eax,ecx
     a35:	f7 ea                	imul   edx
     a37:	89 c8                	mov    eax,ecx
     a39:	c1 f8 1f             	sar    eax,0x1f
     a3c:	29 c2                	sub    edx,eax
     a3e:	89 d0                	mov    eax,edx
     a40:	01 c0                	add    eax,eax
     a42:	01 d0                	add    eax,edx
     a44:	29 c1                	sub    ecx,eax
     a46:	89 ca                	mov    edx,ecx
     a48:	85 d2                	test   edx,edx
     a4a:	74 2b                	je     a77 <render_text_scanline_24btpp_sse+0x204>
						bt_ofs = 3 * cc - bc;
     a4c:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
     a4f:	89 d0                	mov    eax,edx
     a51:	01 c0                	add    eax,eax
     a53:	01 d0                	add    eax,edx
     a55:	2b 45 d4             	sub    eax,DWORD PTR [ebp-0x2c]
     a58:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						memcpy(pixbuf, pixbuf + bc, bt_ofs);
     a5b:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     a5e:	8b 4d 8c             	mov    ecx,DWORD PTR [ebp-0x74]
     a61:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     a64:	01 c1                	add    ecx,eax
     a66:	8b 45 8c             	mov    eax,DWORD PTR [ebp-0x74]
     a69:	83 ec 04             	sub    esp,0x4
     a6c:	52                   	push   edx
     a6d:	51                   	push   ecx
     a6e:	50                   	push   eax
     a6f:	e8 8c f5 ff ff       	call   0 <memcpy>
     a74:	83 c4 10             	add    esp,0x10
						/* no bt_ofs pixels from this pixel are left in pixbuf */
				}
				px_x -= cc;
     a77:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     a7a:	29 45 14             	sub    DWORD PTR [ebp+0x14],eax
				p0_x += cc;
     a7d:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     a80:	01 45 1c             	add    DWORD PTR [ebp+0x1c],eax
				mem += misalign; /* safer than bc */
     a83:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     a86:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     a89:	01 d0                	add    eax,edx
     a8b:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
		}

		/* draw 5 2/3 pixels each (6,5,5) */
		while (px_x) { /* 144 bit vs. 128 16bt remain (2/3) */
     a8e:	e9 69 02 00 00       	jmp    cfc <render_text_scanline_24btpp_sse+0x489>
				int col = p0_x / 8, inv = (col == cur_x);
     a93:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     a96:	8d 50 07             	lea    edx,[eax+0x7]
     a99:	85 c0                	test   eax,eax
     a9b:	0f 48 c2             	cmovs  eax,edx
     a9e:	c1 f8 03             	sar    eax,0x3
     aa1:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
     aa4:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
     aa7:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
     aaa:	0f 94 c0             	sete   al
     aad:	0f b6 c0             	movzx  eax,al
     ab0:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
				ssize_t cc = min(bt_ofs ? 5 : 6, px_x), cc1; /* 655 */
     ab3:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     ab7:	74 07                	je     ac0 <render_text_scanline_24btpp_sse+0x24d>
     ab9:	b8 05 00 00 00       	mov    eax,0x5
     abe:	eb 05                	jmp    ac5 <render_text_scanline_24btpp_sse+0x252>
     ac0:	b8 06 00 00 00       	mov    eax,0x6
     ac5:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
     ac8:	39 d0                	cmp    eax,edx
     aca:	0f 4f c2             	cmovg  eax,edx
     acd:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
				ssize_t rmax, bitc, btt = min(128, 24 * px_x + 8 * bt_ofs);
     ad0:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
     ad3:	89 d0                	mov    eax,edx
     ad5:	01 c0                	add    eax,eax
     ad7:	01 c2                	add    edx,eax
     ad9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     adc:	01 d0                	add    eax,edx
     ade:	c1 e0 03             	shl    eax,0x3
     ae1:	ba 80 00 00 00       	mov    edx,0x80
     ae6:	39 d0                	cmp    eax,edx
     ae8:	0f 4f c2             	cmovg  eax,edx
     aeb:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				r = p0_x % 8;
     aee:	8b 55 1c             	mov    edx,DWORD PTR [ebp+0x1c]
     af1:	89 d0                	mov    eax,edx
     af3:	c1 f8 1f             	sar    eax,0x1f
     af6:	c1 e8 1d             	shr    eax,0x1d
     af9:	01 c2                	add    edx,eax
     afb:	83 e2 07             	and    edx,0x7
     afe:	29 c2                	sub    edx,eax
     b00:	89 55 e0             	mov    DWORD PTR [ebp-0x20],edx
				rmax = min(8, r + cc); /* only up to 6 pixels */
     b03:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
     b06:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
     b09:	01 d0                	add    eax,edx
     b0b:	ba 08 00 00 00       	mov    edx,0x8
     b10:	39 d0                	cmp    eax,edx
     b12:	0f 4f c2             	cmovg  eax,edx
     b15:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
				/* get the remaining character pixels */
				bitc = generate_char_colors(font, str[0], str[1], 24,
     b18:	8b 55 8c             	mov    edx,DWORD PTR [ebp-0x74]
     b1b:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     b1e:	8d 0c 02             	lea    ecx,[edx+eax*1]
     b21:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     b24:	83 c0 01             	add    eax,0x1
     b27:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     b2a:	0f be d0             	movsx  edx,al
     b2d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     b30:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     b33:	0f be c0             	movsx  eax,al
     b36:	ff 75 c0             	push   DWORD PTR [ebp-0x40]
     b39:	51                   	push   ecx
     b3a:	ff 75 b8             	push   DWORD PTR [ebp-0x48]
     b3d:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
     b40:	6a 18                	push   0x18
     b42:	52                   	push   edx
     b43:	50                   	push   eax
     b44:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     b47:	e8 fc ff ff ff       	call   b48 <render_text_scanline_24btpp_sse+0x2d5>
     b4c:	83 c4 20             	add    esp,0x20
     b4f:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
								r, rmax, pixbuf + bt_ofs, inv);
				cc1 = rmax - r;
     b52:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
     b55:	2b 45 e0             	sub    eax,DWORD PTR [ebp-0x20]
     b58:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
				/* now advance if neccessary */
				if (rmax == 8)
     b5b:	83 7d b8 08          	cmp    DWORD PTR [ebp-0x48],0x8
     b5f:	75 04                	jne    b65 <render_text_scanline_24btpp_sse+0x2f2>
						str += 2;
     b61:	83 45 0c 02          	add    DWORD PTR [ebp+0xc],0x2
				/* and fetch up to five more pixels if needed (r=0) */
				if (cc > cc1) {
     b65:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
     b68:	3b 45 b4             	cmp    eax,DWORD PTR [ebp-0x4c]
     b6b:	7e 5f                	jle    bcc <render_text_scanline_24btpp_sse+0x359>
						col++; inv = (col == cur_x);
     b6d:	83 45 c4 01          	add    DWORD PTR [ebp-0x3c],0x1
     b71:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
     b74:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
     b77:	0f 94 c0             	sete   al
     b7a:	0f b6 c0             	movzx  eax,al
     b7d:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
						bitc += generate_char_colors(font, str[0], str[1], 24,
     b80:	8b 4d 8c             	mov    ecx,DWORD PTR [ebp-0x74]
										0, cc - cc1, pixbuf + bt_ofs + cc1 * 3, inv);
     b83:	8b 55 b4             	mov    edx,DWORD PTR [ebp-0x4c]
     b86:	89 d0                	mov    eax,edx
     b88:	01 c0                	add    eax,eax
     b8a:	01 d0                	add    eax,edx
     b8c:	89 c2                	mov    edx,eax
     b8e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     b91:	01 d0                	add    eax,edx
						bitc += generate_char_colors(font, str[0], str[1], 24,
     b93:	8d 1c 01             	lea    ebx,[ecx+eax*1]
     b96:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
     b99:	2b 45 b4             	sub    eax,DWORD PTR [ebp-0x4c]
     b9c:	89 c1                	mov    ecx,eax
     b9e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     ba1:	83 c0 01             	add    eax,0x1
     ba4:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     ba7:	0f be d0             	movsx  edx,al
     baa:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     bad:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     bb0:	0f be c0             	movsx  eax,al
     bb3:	ff 75 c0             	push   DWORD PTR [ebp-0x40]
     bb6:	53                   	push   ebx
     bb7:	51                   	push   ecx
     bb8:	6a 00                	push   0x0
     bba:	6a 18                	push   0x18
     bbc:	52                   	push   edx
     bbd:	50                   	push   eax
     bbe:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     bc1:	e8 fc ff ff ff       	call   bc2 <render_text_scanline_24btpp_sse+0x34f>
     bc6:	83 c4 20             	add    esp,0x20
     bc9:	01 45 f0             	add    DWORD PTR [ebp-0x10],eax
				}
				/* now transfer */
				if (btt >= 128) {
     bcc:	83 7d ec 7f          	cmp    DWORD PTR [ebp-0x14],0x7f
     bd0:	7e 24                	jle    bf6 <render_text_scanline_24btpp_sse+0x383>
						move_128(pixbuf, mem);
     bd2:	8b 45 8c             	mov    eax,DWORD PTR [ebp-0x74]
     bd5:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     bd8:	0f 28 00             	movaps xmm0,XMMWORD PTR [eax]
     bdb:	0f 29 02             	movaps XMMWORD PTR [edx],xmm0
						mem += 16;
     bde:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     be1:	83 c0 10             	add    eax,0x10
     be4:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
						}
						break;
				}

				/* and don't advance as r = 0 is already handled (sth. remains) */
				if (px_x) {
     be7:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     beb:	0f 84 17 01 00 00    	je     d08 <render_text_scanline_24btpp_sse+0x495>
     bf1:	e9 cc 00 00 00       	jmp    cc2 <render_text_scanline_24btpp_sse+0x44f>
						uint8_t* pt = pixbuf;
     bf6:	8b 45 8c             	mov    eax,DWORD PTR [ebp-0x74]
     bf9:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
						if (btt >= 64) {
     bfc:	83 7d ec 3f          	cmp    DWORD PTR [ebp-0x14],0x3f
     c00:	7e 1d                	jle    c1f <render_text_scanline_24btpp_sse+0x3ac>
								move_64(pixbuf, mem);
     c02:	8b 45 8c             	mov    eax,DWORD PTR [ebp-0x74]
     c05:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     c08:	0f 6f 00             	movq   mm0,QWORD PTR [eax]
     c0b:	0f 7f 02             	movq   QWORD PTR [edx],mm0
								pt += 8;
     c0e:	83 45 e8 08          	add    DWORD PTR [ebp-0x18],0x8
								mem += 8;
     c12:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     c15:	83 c0 08             	add    eax,0x8
     c18:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
								btt -= 64;
     c1b:	83 6d ec 40          	sub    DWORD PTR [ebp-0x14],0x40
						if (btt >= 32) {
     c1f:	83 7d ec 1f          	cmp    DWORD PTR [ebp-0x14],0x1f
     c23:	7e 20                	jle    c45 <render_text_scanline_24btpp_sse+0x3d2>
								*(uint32_t*)mem = *(uint32_t*)pt;
     c25:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     c28:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
     c2b:	8b 12                	mov    edx,DWORD PTR [edx]
     c2d:	89 10                	mov    DWORD PTR [eax],edx
								pt += 4;
     c2f:	83 45 e8 04          	add    DWORD PTR [ebp-0x18],0x4
								mem += 4;
     c33:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     c36:	83 c0 04             	add    eax,0x4
     c39:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
								btt -= 32;
     c3c:	83 6d ec 20          	sub    DWORD PTR [ebp-0x14],0x20
						break;
     c40:	e9 c6 00 00 00       	jmp    d0b <render_text_scanline_24btpp_sse+0x498>
						} else if (btt >= 16) {
     c45:	83 7d ec 0f          	cmp    DWORD PTR [ebp-0x14],0xf
     c49:	7e 22                	jle    c6d <render_text_scanline_24btpp_sse+0x3fa>
								*(uint16_t*)mem = *(uint16_t*)pt;
     c4b:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     c4e:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
     c51:	0f b7 12             	movzx  edx,WORD PTR [edx]
     c54:	66 89 10             	mov    WORD PTR [eax],dx
								pt += 2;
     c57:	83 45 e8 02          	add    DWORD PTR [ebp-0x18],0x2
								mem += 2;
     c5b:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     c5e:	83 c0 02             	add    eax,0x2
     c61:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
								btt -= 16;
     c64:	83 6d ec 10          	sub    DWORD PTR [ebp-0x14],0x10
						break;
     c68:	e9 9e 00 00 00       	jmp    d0b <render_text_scanline_24btpp_sse+0x498>
						} else if (bitc >= 8) {
     c6d:	83 7d f0 07          	cmp    DWORD PTR [ebp-0x10],0x7
     c71:	7e 1e                	jle    c91 <render_text_scanline_24btpp_sse+0x41e>
								*(uint8_t*)mem = *(uint8_t*)pt;
     c73:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     c76:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
     c79:	0f b6 12             	movzx  edx,BYTE PTR [edx]
     c7c:	88 10                	mov    BYTE PTR [eax],dl
								pt += 1;
     c7e:	83 45 e8 01          	add    DWORD PTR [ebp-0x18],0x1
								mem += 1;
     c82:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     c85:	83 c0 01             	add    eax,0x1
     c88:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
								btt -= 8;
     c8b:	83 6d ec 08          	sub    DWORD PTR [ebp-0x14],0x8
						break;
     c8f:	eb 7a                	jmp    d0b <render_text_scanline_24btpp_sse+0x498>
						} else if (bitc) {
     c91:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     c95:	74 74                	je     d0b <render_text_scanline_24btpp_sse+0x498>
								die("can't happen with 3byte sized pixels\n");
     c97:	83 ec 08             	sub    esp,0x8
     c9a:	68 44 01 00 00       	push   0x144
     c9f:	6a 0c                	push   0xc
     ca1:	e8 fc ff ff ff       	call   ca2 <render_text_scanline_24btpp_sse+0x42f>
     ca6:	83 c4 10             	add    esp,0x10
     ca9:	e8 fc ff ff ff       	call   caa <render_text_scanline_24btpp_sse+0x437>
     cae:	83 ec 0c             	sub    esp,0xc
     cb1:	68 00 00 00 00       	push   0x0
     cb6:	e8 fc ff ff ff       	call   cb7 <render_text_scanline_24btpp_sse+0x444>
     cbb:	83 c4 10             	add    esp,0x10
     cbe:	fa                   	cli
     cbf:	f4                   	hlt
     cc0:	eb fd                	jmp    cbf <render_text_scanline_24btpp_sse+0x44c>
						px_x -= cc; /* bitc is 24-divisible */
     cc2:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
     cc5:	29 45 14             	sub    DWORD PTR [ebp+0x14],eax
						p0_x += cc; /* unneccessary as r does not change anymore */
     cc8:	8b 45 bc             	mov    eax,DWORD PTR [ebp-0x44]
     ccb:	01 45 1c             	add    DWORD PTR [ebp+0x1c],eax
						/* copy remaining data */
						/* |bt_ofs*8-bitc| */
						if (!bt_ofs--)
     cce:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     cd1:	8d 50 ff             	lea    edx,[eax-0x1]
     cd4:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
     cd7:	85 c0                	test   eax,eax
     cd9:	75 07                	jne    ce2 <render_text_scanline_24btpp_sse+0x46f>
								bt_ofs = 2;
     cdb:	c7 45 f4 02 00 00 00 	mov    DWORD PTR [ebp-0xc],0x2
						memcpy(pixbuf, pixbuf + 16, bt_ofs);
     ce2:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     ce5:	8b 45 8c             	mov    eax,DWORD PTR [ebp-0x74]
     ce8:	8d 48 10             	lea    ecx,[eax+0x10]
     ceb:	8b 45 8c             	mov    eax,DWORD PTR [ebp-0x74]
     cee:	83 ec 04             	sub    esp,0x4
     cf1:	52                   	push   edx
     cf2:	51                   	push   ecx
     cf3:	50                   	push   eax
     cf4:	e8 07 f3 ff ff       	call   0 <memcpy>
     cf9:	83 c4 10             	add    esp,0x10
		while (px_x) { /* 144 bit vs. 128 16bt remain (2/3) */
     cfc:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
     d00:	0f 85 8d fd ff ff    	jne    a93 <render_text_scanline_24btpp_sse+0x220>
     d06:	eb 04                	jmp    d0c <render_text_scanline_24btpp_sse+0x499>
				} else
						break;
     d08:	90                   	nop
     d09:	eb 01                	jmp    d0c <render_text_scanline_24btpp_sse+0x499>
						break;
     d0b:	90                   	nop
		}

		/* transfer the leftover pixel data */
		if (bt_ofs)
     d0c:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     d10:	74 17                	je     d29 <render_text_scanline_24btpp_sse+0x4b6>
				memcpy(pixbuf, mem, bt_ofs);
     d12:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
     d15:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     d18:	8b 45 8c             	mov    eax,DWORD PTR [ebp-0x74]
     d1b:	83 ec 04             	sub    esp,0x4
     d1e:	51                   	push   ecx
     d1f:	52                   	push   edx
     d20:	50                   	push   eax
     d21:	e8 da f2 ff ff       	call   0 <memcpy>
     d26:	83 c4 10             	add    esp,0x10
}
     d29:	90                   	nop
     d2a:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     d2d:	c9                   	leave
     d2e:	c3                   	ret

00000d2f <render_text_scanline_16btpp>:

/* we're generating 2byte colorvalues /w unknown alignment. To enable
 * 8 byte transfer, four pixels have to be generated. */
void render_text_scanline_16btpp(const char* font, char* str, void* mem,
				ssize_t px_x, ssize_t cur_x, ssize_t p0_x, size_t btpp)
{
     d2f:	55                   	push   ebp
     d30:	89 e5                	mov    ebp,esp
     d32:	53                   	push   ebx
     d33:	83 ec 54             	sub    esp,0x54
		uint8_t pxb[8 + 7]; /* 7 for stack alignment */
		ssize_t misalign = ((size_t)mem % 8) ? (8 - (size_t)mem % 8) : 0;
     d36:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     d39:	83 e0 07             	and    eax,0x7
     d3c:	85 c0                	test   eax,eax
     d3e:	74 11                	je     d51 <render_text_scanline_16btpp+0x22>
     d40:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     d43:	83 e0 07             	and    eax,0x7
     d46:	ba 08 00 00 00       	mov    edx,0x8
     d4b:	29 c2                	sub    edx,eax
     d4d:	89 d0                	mov    eax,edx
     d4f:	eb 05                	jmp    d56 <render_text_scanline_16btpp+0x27>
     d51:	b8 00 00 00 00       	mov    eax,0x0
     d56:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		ssize_t r = p0_x % 8;
     d59:	8b 55 1c             	mov    edx,DWORD PTR [ebp+0x1c]
     d5c:	89 d0                	mov    eax,edx
     d5e:	c1 f8 1f             	sar    eax,0x1f
     d61:	c1 e8 1d             	shr    eax,0x1d
     d64:	01 c2                	add    edx,eax
     d66:	83 e2 07             	and    edx,0x7
     d69:	29 c2                	sub    edx,eax
     d6b:	89 55 e8             	mov    DWORD PTR [ebp-0x18],edx
		uint8_t* pixbuf = pxb + (((size_t)pxb % 8) ? (8 - ((size_t)pxb % 8)) : 0);
     d6e:	8d 45 b1             	lea    eax,[ebp-0x4f]
     d71:	83 e0 07             	and    eax,0x7
     d74:	85 c0                	test   eax,eax
     d76:	74 11                	je     d89 <render_text_scanline_16btpp+0x5a>
     d78:	8d 45 b1             	lea    eax,[ebp-0x4f]
     d7b:	83 e0 07             	and    eax,0x7
     d7e:	89 c2                	mov    edx,eax
     d80:	b8 08 00 00 00       	mov    eax,0x8
     d85:	29 d0                	sub    eax,edx
     d87:	eb 05                	jmp    d8e <render_text_scanline_16btpp+0x5f>
     d89:	b8 00 00 00 00       	mov    eax,0x0
     d8e:	8d 55 b1             	lea    edx,[ebp-0x4f]
     d91:	01 d0                	add    eax,edx
     d93:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
		/* 64-bit aligned moves are enough */

		if (misalign) { /* LFB is dword aligned, we want qword access */
     d96:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     d9a:	0f 84 0a 03 00 00    	je     10aa <render_text_scanline_16btpp+0x37b>
				int col = p0_x / 8, inv = (col == cur_x);
     da0:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     da3:	8d 50 07             	lea    edx,[eax+0x7]
     da6:	85 c0                	test   eax,eax
     da8:	0f 48 c2             	cmovs  eax,edx
     dab:	c1 f8 03             	sar    eax,0x3
     dae:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
     db1:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     db4:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
     db7:	0f 94 c0             	sete   al
     dba:	0f b6 c0             	movzx  eax,al
     dbd:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
				ssize_t bc = min(misalign, 2 * px_x);
     dc0:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     dc3:	01 c0                	add    eax,eax
     dc5:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     dc8:	39 c2                	cmp    edx,eax
     dca:	0f 4e c2             	cmovle eax,edx
     dcd:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
				ssize_t cc = rdiv(misalign, 2);
     dd0:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     dd3:	89 c2                	mov    edx,eax
     dd5:	c1 ea 1f             	shr    edx,0x1f
     dd8:	01 d0                	add    eax,edx
     dda:	d1 f8                	sar    eax,1
     ddc:	89 c2                	mov    edx,eax
     dde:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     de1:	83 e0 01             	and    eax,0x1
     de4:	01 d0                	add    eax,edx
     de6:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
				ssize_t rmax = min(8, r + cc), cc1 = rmax - r;
     de9:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
     dec:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     def:	01 d0                	add    eax,edx
     df1:	ba 08 00 00 00       	mov    edx,0x8
     df6:	39 d0                	cmp    eax,edx
     df8:	0f 4f c2             	cmovg  eax,edx
     dfb:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
     dfe:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
     e01:	2b 45 e8             	sub    eax,DWORD PTR [ebp-0x18]
     e04:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax

				generate_char_colors(font, str[0], str[1], btpp,
     e07:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
     e0a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     e0d:	83 c0 01             	add    eax,0x1
     e10:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     e13:	0f be d0             	movsx  edx,al
     e16:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     e19:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     e1c:	0f be c0             	movsx  eax,al
     e1f:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
     e22:	51                   	push   ecx
     e23:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
     e26:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
     e29:	ff 75 20             	push   DWORD PTR [ebp+0x20]
     e2c:	52                   	push   edx
     e2d:	50                   	push   eax
     e2e:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     e31:	e8 fc ff ff ff       	call   e32 <render_text_scanline_16btpp+0x103>
     e36:	83 c4 20             	add    esp,0x20
								r, rmax, pixbuf, inv);
				if (rmax == 8)
     e39:	83 7d d4 08          	cmp    DWORD PTR [ebp-0x2c],0x8
     e3d:	75 04                	jne    e43 <render_text_scanline_16btpp+0x114>
						str += 2;
     e3f:	83 45 0c 02          	add    DWORD PTR [ebp+0xc],0x2
				if (cc > cc1) {
     e43:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     e46:	3b 45 d0             	cmp    eax,DWORD PTR [ebp-0x30]
     e49:	7e 50                	jle    e9b <render_text_scanline_16btpp+0x16c>
						col++; inv = (col == cur_x);
     e4b:	83 45 e4 01          	add    DWORD PTR [ebp-0x1c],0x1
     e4f:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     e52:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
     e55:	0f 94 c0             	sete   al
     e58:	0f b6 c0             	movzx  eax,al
     e5b:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
						generate_char_colors(font, str[0], str[1], btpp,
     e5e:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
     e61:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     e64:	8d 1c 02             	lea    ebx,[edx+eax*1]
     e67:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     e6a:	2b 45 d0             	sub    eax,DWORD PTR [ebp-0x30]
     e6d:	89 c1                	mov    ecx,eax
     e6f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     e72:	83 c0 01             	add    eax,0x1
     e75:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     e78:	0f be d0             	movsx  edx,al
     e7b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     e7e:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     e81:	0f be c0             	movsx  eax,al
     e84:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
     e87:	53                   	push   ebx
     e88:	51                   	push   ecx
     e89:	6a 00                	push   0x0
     e8b:	ff 75 20             	push   DWORD PTR [ebp+0x20]
     e8e:	52                   	push   edx
     e8f:	50                   	push   eax
     e90:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     e93:	e8 fc ff ff ff       	call   e94 <render_text_scanline_16btpp+0x165>
     e98:	83 c4 20             	add    esp,0x20
										0, cc - cc1, pixbuf + cc1, inv);
				}
				memcpy(mem, pixbuf, bc);
     e9b:	8b 4d dc             	mov    ecx,DWORD PTR [ebp-0x24]
     e9e:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
     ea1:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     ea4:	83 ec 04             	sub    esp,0x4
     ea7:	51                   	push   ecx
     ea8:	52                   	push   edx
     ea9:	50                   	push   eax
     eaa:	e8 51 f1 ff ff       	call   0 <memcpy>
     eaf:	83 c4 10             	add    esp,0x10
				px_x -= cc;
     eb2:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     eb5:	29 45 14             	sub    DWORD PTR [ebp+0x14],eax
				p0_x += cc;
     eb8:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
     ebb:	01 45 1c             	add    DWORD PTR [ebp+0x1c],eax
				mem += bc;
     ebe:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     ec1:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
     ec4:	01 d0                	add    eax,edx
     ec6:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
		}

		/* draw 4 pixels each */
		while (px_x) {
     ec9:	e9 dc 01 00 00       	jmp    10aa <render_text_scanline_16btpp+0x37b>
				int col = p0_x / 8, inv = (col == cur_x);
     ece:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
     ed1:	8d 50 07             	lea    edx,[eax+0x7]
     ed4:	85 c0                	test   eax,eax
     ed6:	0f 48 c2             	cmovs  eax,edx
     ed9:	c1 f8 03             	sar    eax,0x3
     edc:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
     edf:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     ee2:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
     ee5:	0f 94 c0             	sete   al
     ee8:	0f b6 c0             	movzx  eax,al
     eeb:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
				ssize_t rmax, bitc, btt = min(64, 16 * px_x);
     eee:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     ef1:	c1 e0 04             	shl    eax,0x4
     ef4:	ba 40 00 00 00       	mov    edx,0x40
     ef9:	39 d0                	cmp    eax,edx
     efb:	0f 4f c2             	cmovg  eax,edx
     efe:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
				r = p0_x % 8;
     f01:	8b 55 1c             	mov    edx,DWORD PTR [ebp+0x1c]
     f04:	89 d0                	mov    eax,edx
     f06:	c1 f8 1f             	sar    eax,0x1f
     f09:	c1 e8 1d             	shr    eax,0x1d
     f0c:	01 c2                	add    edx,eax
     f0e:	83 e2 07             	and    edx,0x7
     f11:	29 c2                	sub    edx,eax
     f13:	89 55 e8             	mov    DWORD PTR [ebp-0x18],edx
				rmax = min(8, r + min(4, px_x)); /* only 2 pixels */
     f16:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
     f19:	ba 04 00 00 00       	mov    edx,0x4
     f1e:	39 d0                	cmp    eax,edx
     f20:	0f 4e d0             	cmovle edx,eax
     f23:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     f26:	01 d0                	add    eax,edx
     f28:	ba 08 00 00 00       	mov    edx,0x8
     f2d:	39 d0                	cmp    eax,edx
     f2f:	0f 4f c2             	cmovg  eax,edx
     f32:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
				/* get the remaining character pixels */
				bitc = generate_char_colors(font, str[0], str[1], btpp,
     f35:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
     f38:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     f3b:	83 c0 01             	add    eax,0x1
     f3e:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     f41:	0f be d0             	movsx  edx,al
     f44:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     f47:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     f4a:	0f be c0             	movsx  eax,al
     f4d:	ff 75 c8             	push   DWORD PTR [ebp-0x38]
     f50:	51                   	push   ecx
     f51:	ff 75 c0             	push   DWORD PTR [ebp-0x40]
     f54:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
     f57:	ff 75 20             	push   DWORD PTR [ebp+0x20]
     f5a:	52                   	push   edx
     f5b:	50                   	push   eax
     f5c:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     f5f:	e8 fc ff ff ff       	call   f60 <render_text_scanline_16btpp+0x231>
     f64:	83 c4 20             	add    esp,0x20
     f67:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
								r, rmax, pixbuf, inv);
				/* now advance if neccessary */
				if (rmax == 8)
     f6a:	83 7d c0 08          	cmp    DWORD PTR [ebp-0x40],0x8
     f6e:	75 04                	jne    f74 <render_text_scanline_16btpp+0x245>
						str += 2;
     f70:	83 45 0c 02          	add    DWORD PTR [ebp+0xc],0x2
				/* and fetch up to three more pixels if needed (r=0) */
				if (bitc < btt) {
     f74:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     f77:	3b 45 c4             	cmp    eax,DWORD PTR [ebp-0x3c]
     f7a:	7d 69                	jge    fe5 <render_text_scanline_16btpp+0x2b6>
						col++;
     f7c:	83 45 cc 01          	add    DWORD PTR [ebp-0x34],0x1
						inv = (col == cur_x);
     f80:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
     f83:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
     f86:	0f 94 c0             	sete   al
     f89:	0f b6 c0             	movzx  eax,al
     f8c:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
						bitc += generate_char_colors(font, str[0], str[1], btpp,
     f8f:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
										0, (btt - bitc) / 16, pixbuf + bitc / 16, inv);
     f92:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     f95:	8d 48 0f             	lea    ecx,[eax+0xf]
     f98:	85 c0                	test   eax,eax
     f9a:	0f 48 c1             	cmovs  eax,ecx
     f9d:	c1 f8 04             	sar    eax,0x4
						bitc += generate_char_colors(font, str[0], str[1], btpp,
     fa0:	8d 0c 02             	lea    ecx,[edx+eax*1]
										0, (btt - bitc) / 16, pixbuf + bitc / 16, inv);
     fa3:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
     fa6:	2b 45 f4             	sub    eax,DWORD PTR [ebp-0xc]
						bitc += generate_char_colors(font, str[0], str[1], btpp,
     fa9:	8d 50 0f             	lea    edx,[eax+0xf]
     fac:	85 c0                	test   eax,eax
     fae:	0f 48 c2             	cmovs  eax,edx
     fb1:	c1 f8 04             	sar    eax,0x4
     fb4:	89 c3                	mov    ebx,eax
     fb6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     fb9:	83 c0 01             	add    eax,0x1
     fbc:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     fbf:	0f be d0             	movsx  edx,al
     fc2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     fc5:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     fc8:	0f be c0             	movsx  eax,al
     fcb:	ff 75 c8             	push   DWORD PTR [ebp-0x38]
     fce:	51                   	push   ecx
     fcf:	53                   	push   ebx
     fd0:	6a 00                	push   0x0
     fd2:	ff 75 20             	push   DWORD PTR [ebp+0x20]
     fd5:	52                   	push   edx
     fd6:	50                   	push   eax
     fd7:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     fda:	e8 fc ff ff ff       	call   fdb <render_text_scanline_16btpp+0x2ac>
     fdf:	83 c4 20             	add    esp,0x20
     fe2:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
				}
				/* now transfer */
				if (bitc >= 64) {
     fe5:	83 7d f4 3f          	cmp    DWORD PTR [ebp-0xc],0x3f
     fe9:	7e 21                	jle    100c <render_text_scanline_16btpp+0x2dd>
						move_64(pixbuf, mem);
     feb:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
     fee:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
     ff1:	0f 6f 00             	movq   mm0,QWORD PTR [eax]
     ff4:	0f 7f 02             	movq   QWORD PTR [edx],mm0
						mem += 8; /* intentionally no bitc subtract */
     ff7:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     ffa:	83 c0 08             	add    eax,0x8
     ffd:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
						}
						break;
				}

				/* and don't advance as r = 0 is already handled (sth. remains) */
				if (px_x) {
    1000:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
    1004:	0f 84 ac 00 00 00    	je     10b6 <render_text_scanline_16btpp+0x387>
    100a:	eb 7a                	jmp    1086 <render_text_scanline_16btpp+0x357>
						void* pt = pixbuf;
    100c:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    100f:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
						if (bitc >= 32) {
    1012:	83 7d f4 1f          	cmp    DWORD PTR [ebp-0xc],0x1f
    1016:	7e 1b                	jle    1033 <render_text_scanline_16btpp+0x304>
								*(uint32_t*)mem = *(uint32_t*)pixbuf;
    1018:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
    101b:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    101e:	8b 12                	mov    edx,DWORD PTR [edx]
    1020:	89 10                	mov    DWORD PTR [eax],edx
								mem += 4;
    1022:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1025:	83 c0 04             	add    eax,0x4
    1028:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
								pt += 4;
    102b:	83 45 f0 04          	add    DWORD PTR [ebp-0x10],0x4
								bitc -= 32;
    102f:	83 6d f4 20          	sub    DWORD PTR [ebp-0xc],0x20
						if (bitc >= 16) {
    1033:	83 7d f4 0f          	cmp    DWORD PTR [ebp-0xc],0xf
    1037:	7e 19                	jle    1052 <render_text_scanline_16btpp+0x323>
								*(uint32_t*)mem = *(uint32_t*)pt;
    1039:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    103c:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    103f:	8b 12                	mov    edx,DWORD PTR [edx]
    1041:	89 10                	mov    DWORD PTR [eax],edx
								mem += 2;
    1043:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1046:	83 c0 02             	add    eax,0x2
    1049:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
								bitc -= 16;
    104c:	83 6d f4 10          	sub    DWORD PTR [ebp-0xc],0x10
						break;
    1050:	eb 67                	jmp    10b9 <render_text_scanline_16btpp+0x38a>
						} else if (bitc) {
    1052:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1056:	74 61                	je     10b9 <render_text_scanline_16btpp+0x38a>
								die("cant happen with word sized pixels! %d\n", px_x);
    1058:	83 ec 04             	sub    esp,0x4
    105b:	ff 75 14             	push   DWORD PTR [ebp+0x14]
    105e:	68 6c 01 00 00       	push   0x16c
    1063:	6a 0c                	push   0xc
    1065:	e8 fc ff ff ff       	call   1066 <render_text_scanline_16btpp+0x337>
    106a:	83 c4 10             	add    esp,0x10
    106d:	e8 fc ff ff ff       	call   106e <render_text_scanline_16btpp+0x33f>
    1072:	83 ec 0c             	sub    esp,0xc
    1075:	68 00 00 00 00       	push   0x0
    107a:	e8 fc ff ff ff       	call   107b <render_text_scanline_16btpp+0x34c>
    107f:	83 c4 10             	add    esp,0x10
    1082:	fa                   	cli
    1083:	f4                   	hlt
    1084:	eb fd                	jmp    1083 <render_text_scanline_16btpp+0x354>
						px_x -= bitc / 16;
    1086:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1089:	8d 50 0f             	lea    edx,[eax+0xf]
    108c:	85 c0                	test   eax,eax
    108e:	0f 48 c2             	cmovs  eax,edx
    1091:	c1 f8 04             	sar    eax,0x4
    1094:	f7 d8                	neg    eax
    1096:	01 45 14             	add    DWORD PTR [ebp+0x14],eax
						p0_x += bitc / 16; /* unneccessary as r does not change anymore */
    1099:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    109c:	8d 50 0f             	lea    edx,[eax+0xf]
    109f:	85 c0                	test   eax,eax
    10a1:	0f 48 c2             	cmovs  eax,edx
    10a4:	c1 f8 04             	sar    eax,0x4
    10a7:	01 45 1c             	add    DWORD PTR [ebp+0x1c],eax
		while (px_x) {
    10aa:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
    10ae:	0f 85 1a fe ff ff    	jne    ece <render_text_scanline_16btpp+0x19f>
				} else
						break;
		}
}
    10b4:	eb 04                	jmp    10ba <render_text_scanline_16btpp+0x38b>
						break;
    10b6:	90                   	nop
    10b7:	eb 01                	jmp    10ba <render_text_scanline_16btpp+0x38b>
						break;
    10b9:	90                   	nop
}
    10ba:	90                   	nop
    10bb:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    10be:	c9                   	leave
    10bf:	c3                   	ret

000010c0 <render_text_scanline_32btpp>:

/* we're generating 4byte colorvalues /w unknown alignment. To enable
 * 8 byte transfer, two pixel have to be generated. */
void render_text_scanline_32btpp(const char* font, char* str, void* mem,
				ssize_t px_x, ssize_t cur_x, ssize_t p0_x)
{
    10c0:	55                   	push   ebp
    10c1:	89 e5                	mov    ebp,esp
    10c3:	83 ec 58             	sub    esp,0x58
		uint8_t pxb[8 + 7]; /* 7 for stack alignment */
		ssize_t misalign = ((size_t)mem % 8) ? (8 - (size_t)mem % 8) : 0;
    10c6:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    10c9:	83 e0 07             	and    eax,0x7
    10cc:	85 c0                	test   eax,eax
    10ce:	74 11                	je     10e1 <render_text_scanline_32btpp+0x21>
    10d0:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    10d3:	83 e0 07             	and    eax,0x7
    10d6:	ba 08 00 00 00       	mov    edx,0x8
    10db:	29 c2                	sub    edx,eax
    10dd:	89 d0                	mov    eax,edx
    10df:	eb 05                	jmp    10e6 <render_text_scanline_32btpp+0x26>
    10e1:	b8 00 00 00 00       	mov    eax,0x0
    10e6:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		ssize_t r = p0_x % 8;
    10e9:	8b 55 1c             	mov    edx,DWORD PTR [ebp+0x1c]
    10ec:	89 d0                	mov    eax,edx
    10ee:	c1 f8 1f             	sar    eax,0x1f
    10f1:	c1 e8 1d             	shr    eax,0x1d
    10f4:	01 c2                	add    edx,eax
    10f6:	83 e2 07             	and    edx,0x7
    10f9:	29 c2                	sub    edx,eax
    10fb:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
		uint8_t* pixbuf = pxb + (((size_t)pxb % 8) ? (8 - ((size_t)pxb % 8)) : 0);
    10fe:	8d 45 b9             	lea    eax,[ebp-0x47]
    1101:	83 e0 07             	and    eax,0x7
    1104:	85 c0                	test   eax,eax
    1106:	74 11                	je     1119 <render_text_scanline_32btpp+0x59>
    1108:	8d 45 b9             	lea    eax,[ebp-0x47]
    110b:	83 e0 07             	and    eax,0x7
    110e:	89 c2                	mov    edx,eax
    1110:	b8 08 00 00 00       	mov    eax,0x8
    1115:	29 d0                	sub    eax,edx
    1117:	eb 05                	jmp    111e <render_text_scanline_32btpp+0x5e>
    1119:	b8 00 00 00 00       	mov    eax,0x0
    111e:	8d 55 b9             	lea    edx,[ebp-0x47]
    1121:	01 d0                	add    eax,edx
    1123:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
		/* 64-bit aligned moves are enough */

		if (misalign) { /* LFB is dword aligned, we want qword access */
    1126:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    112a:	0f 84 67 02 00 00    	je     1397 <render_text_scanline_32btpp+0x2d7>
				int col = p0_x / 8, inv = (col == cur_x);
    1130:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
    1133:	8d 50 07             	lea    edx,[eax+0x7]
    1136:	85 c0                	test   eax,eax
    1138:	0f 48 c2             	cmovs  eax,edx
    113b:	c1 f8 03             	sar    eax,0x3
    113e:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    1141:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1144:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
    1147:	0f 94 c0             	sete   al
    114a:	0f b6 c0             	movzx  eax,al
    114d:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
				ssize_t bc = min(misalign, 4 * px_x);
    1150:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1153:	c1 e0 02             	shl    eax,0x2
    1156:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    1159:	39 c2                	cmp    edx,eax
    115b:	0f 4e c2             	cmovle eax,edx
    115e:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
				ssize_t cc = rdiv(misalign, 4);
    1161:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1164:	8d 50 03             	lea    edx,[eax+0x3]
    1167:	85 c0                	test   eax,eax
    1169:	0f 48 c2             	cmovs  eax,edx
    116c:	c1 f8 02             	sar    eax,0x2
    116f:	89 c2                	mov    edx,eax
    1171:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1174:	83 e0 03             	and    eax,0x3
    1177:	85 c0                	test   eax,eax
    1179:	0f 95 c0             	setne  al
    117c:	0f b6 c0             	movzx  eax,al
    117f:	01 d0                	add    eax,edx
    1181:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
				ssize_t rmax = min(8, r + cc); //, cc1 = rmax - r;
    1184:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1187:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    118a:	01 d0                	add    eax,edx
    118c:	ba 08 00 00 00       	mov    edx,0x8
    1191:	39 d0                	cmp    eax,edx
    1193:	0f 4f c2             	cmovg  eax,edx
    1196:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax

				generate_char_colors(font, str[0], str[1], 32,
    1199:	8b 4d b4             	mov    ecx,DWORD PTR [ebp-0x4c]
    119c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    119f:	83 c0 01             	add    eax,0x1
    11a2:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    11a5:	0f be d0             	movsx  edx,al
    11a8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    11ab:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    11ae:	0f be c0             	movsx  eax,al
    11b1:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
    11b4:	51                   	push   ecx
    11b5:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
    11b8:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
    11bb:	6a 20                	push   0x20
    11bd:	52                   	push   edx
    11be:	50                   	push   eax
    11bf:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    11c2:	e8 fc ff ff ff       	call   11c3 <render_text_scanline_32btpp+0x103>
    11c7:	83 c4 20             	add    esp,0x20
								r, rmax, pixbuf, inv);
				if (rmax == 8)
    11ca:	83 7d d8 08          	cmp    DWORD PTR [ebp-0x28],0x8
    11ce:	75 04                	jne    11d4 <render_text_scanline_32btpp+0x114>
						str += 2;
    11d0:	83 45 0c 02          	add    DWORD PTR [ebp+0xc],0x2
				// if (cc > cc1) <- does not happen cc always 1
				memcpy(mem, pixbuf, bc);
    11d4:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
    11d7:	8b 55 b4             	mov    edx,DWORD PTR [ebp-0x4c]
    11da:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    11dd:	83 ec 04             	sub    esp,0x4
    11e0:	51                   	push   ecx
    11e1:	52                   	push   edx
    11e2:	50                   	push   eax
    11e3:	e8 18 ee ff ff       	call   0 <memcpy>
    11e8:	83 c4 10             	add    esp,0x10
				px_x -= cc;
    11eb:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    11ee:	29 45 14             	sub    DWORD PTR [ebp+0x14],eax
				p0_x += cc;
    11f1:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    11f4:	01 45 1c             	add    DWORD PTR [ebp+0x1c],eax
				mem += bc;
    11f7:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
    11fa:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    11fd:	01 d0                	add    eax,edx
    11ff:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
		}

		/* draw 2 pixels each */
		while (px_x) {
    1202:	e9 90 01 00 00       	jmp    1397 <render_text_scanline_32btpp+0x2d7>
				int col = p0_x / 8, inv = (col == cur_x);
    1207:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
    120a:	8d 50 07             	lea    edx,[eax+0x7]
    120d:	85 c0                	test   eax,eax
    120f:	0f 48 c2             	cmovs  eax,edx
    1212:	c1 f8 03             	sar    eax,0x3
    1215:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
    1218:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    121b:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
    121e:	0f 94 c0             	sete   al
    1221:	0f b6 c0             	movzx  eax,al
    1224:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
				ssize_t rmax, bitc, btt = min(64, 32 * px_x);
    1227:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    122a:	c1 e0 05             	shl    eax,0x5
    122d:	ba 40 00 00 00       	mov    edx,0x40
    1232:	39 d0                	cmp    eax,edx
    1234:	0f 4f c2             	cmovg  eax,edx
    1237:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
				r = p0_x % 8;
    123a:	8b 55 1c             	mov    edx,DWORD PTR [ebp+0x1c]
    123d:	89 d0                	mov    eax,edx
    123f:	c1 f8 1f             	sar    eax,0x1f
    1242:	c1 e8 1d             	shr    eax,0x1d
    1245:	01 c2                	add    edx,eax
    1247:	83 e2 07             	and    edx,0x7
    124a:	29 c2                	sub    edx,eax
    124c:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
				rmax = min(8, r + min(2, px_x)); /* only 2 pixels */
    124f:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1252:	ba 02 00 00 00       	mov    edx,0x2
    1257:	39 d0                	cmp    eax,edx
    1259:	0f 4e d0             	cmovle edx,eax
    125c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    125f:	01 d0                	add    eax,edx
    1261:	ba 08 00 00 00       	mov    edx,0x8
    1266:	39 d0                	cmp    eax,edx
    1268:	0f 4f c2             	cmovg  eax,edx
    126b:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
				/* get the remaining character pixels */
				bitc = generate_char_colors(font, str[0], str[1], 32,
    126e:	8b 4d b4             	mov    ecx,DWORD PTR [ebp-0x4c]
    1271:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1274:	83 c0 01             	add    eax,0x1
    1277:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    127a:	0f be d0             	movsx  edx,al
    127d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1280:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1283:	0f be c0             	movsx  eax,al
    1286:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
    1289:	51                   	push   ecx
    128a:	ff 75 c8             	push   DWORD PTR [ebp-0x38]
    128d:	ff 75 ec             	push   DWORD PTR [ebp-0x14]
    1290:	6a 20                	push   0x20
    1292:	52                   	push   edx
    1293:	50                   	push   eax
    1294:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1297:	e8 fc ff ff ff       	call   1298 <render_text_scanline_32btpp+0x1d8>
    129c:	83 c4 20             	add    esp,0x20
    129f:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
								r, rmax, pixbuf, inv);
				/* now advance if neccessary */
				if (rmax == 8)
    12a2:	83 7d c8 08          	cmp    DWORD PTR [ebp-0x38],0x8
    12a6:	75 04                	jne    12ac <render_text_scanline_32btpp+0x1ec>
						str += 2;
    12a8:	83 45 0c 02          	add    DWORD PTR [ebp+0xc],0x2
				/* and fetch one more pixel if needed (r=0) */
				if (bitc < btt) {
    12ac:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    12af:	3b 45 cc             	cmp    eax,DWORD PTR [ebp-0x34]
    12b2:	7d 48                	jge    12fc <render_text_scanline_32btpp+0x23c>
						col++;
    12b4:	83 45 d4 01          	add    DWORD PTR [ebp-0x2c],0x1
						inv = (col == cur_x);
    12b8:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    12bb:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
    12be:	0f 94 c0             	sete   al
    12c1:	0f b6 c0             	movzx  eax,al
    12c4:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
						bitc += generate_char_colors(font, str[0], str[1], 32,
    12c7:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    12ca:	8d 48 04             	lea    ecx,[eax+0x4]
    12cd:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    12d0:	83 c0 01             	add    eax,0x1
    12d3:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    12d6:	0f be d0             	movsx  edx,al
    12d9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    12dc:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    12df:	0f be c0             	movsx  eax,al
    12e2:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
    12e5:	51                   	push   ecx
    12e6:	6a 01                	push   0x1
    12e8:	6a 00                	push   0x0
    12ea:	6a 20                	push   0x20
    12ec:	52                   	push   edx
    12ed:	50                   	push   eax
    12ee:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    12f1:	e8 fc ff ff ff       	call   12f2 <render_text_scanline_32btpp+0x232>
    12f6:	83 c4 20             	add    esp,0x20
    12f9:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
										0, 1, pixbuf + 4, inv);
				}
				/* now transfer */
				if (bitc >= 64) {
    12fc:	83 7d f4 3f          	cmp    DWORD PTR [ebp-0xc],0x3f
    1300:	7e 21                	jle    1323 <render_text_scanline_32btpp+0x263>
						move_64(pixbuf, mem);
    1302:	8b 45 b4             	mov    eax,DWORD PTR [ebp-0x4c]
    1305:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
    1308:	0f 6f 00             	movq   mm0,QWORD PTR [eax]
    130b:	0f 7f 02             	movq   QWORD PTR [edx],mm0
						mem += 8; /* intentionally no bitc subtract */
    130e:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1311:	83 c0 08             	add    eax,0x8
    1314:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
						}
						break;
				}

				/* and don't advance as r = 0 is already handled (sth. remains) */
				if (px_x) {
    1317:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
    131b:	0f 84 82 00 00 00    	je     13a3 <render_text_scanline_32btpp+0x2e3>
    1321:	eb 50                	jmp    1373 <render_text_scanline_32btpp+0x2b3>
						if (bitc >= 32) {
    1323:	83 7d f4 1f          	cmp    DWORD PTR [ebp-0xc],0x1f
    1327:	7e 19                	jle    1342 <render_text_scanline_32btpp+0x282>
								*(uint32_t*)mem = *(uint32_t*)pixbuf;
    1329:	8b 55 b4             	mov    edx,DWORD PTR [ebp-0x4c]
    132c:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    132f:	8b 12                	mov    edx,DWORD PTR [edx]
    1331:	89 10                	mov    DWORD PTR [eax],edx
								mem += 4;
    1333:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1336:	83 c0 04             	add    eax,0x4
    1339:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
								bitc -= 32;
    133c:	83 6d f4 20          	sub    DWORD PTR [ebp-0xc],0x20
						break;
    1340:	eb 64                	jmp    13a6 <render_text_scanline_32btpp+0x2e6>
						} else if (bitc) {
    1342:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1346:	74 5e                	je     13a6 <render_text_scanline_32btpp+0x2e6>
								die("cant happen with dword sized pixels!\n");
    1348:	83 ec 08             	sub    esp,0x8
    134b:	68 1c 01 00 00       	push   0x11c
    1350:	6a 0c                	push   0xc
    1352:	e8 fc ff ff ff       	call   1353 <render_text_scanline_32btpp+0x293>
    1357:	83 c4 10             	add    esp,0x10
    135a:	e8 fc ff ff ff       	call   135b <render_text_scanline_32btpp+0x29b>
    135f:	83 ec 0c             	sub    esp,0xc
    1362:	68 00 00 00 00       	push   0x0
    1367:	e8 fc ff ff ff       	call   1368 <render_text_scanline_32btpp+0x2a8>
    136c:	83 c4 10             	add    esp,0x10
    136f:	fa                   	cli
    1370:	f4                   	hlt
    1371:	eb fd                	jmp    1370 <render_text_scanline_32btpp+0x2b0>
						px_x -= bitc / 32;
    1373:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1376:	8d 50 1f             	lea    edx,[eax+0x1f]
    1379:	85 c0                	test   eax,eax
    137b:	0f 48 c2             	cmovs  eax,edx
    137e:	c1 f8 05             	sar    eax,0x5
    1381:	f7 d8                	neg    eax
    1383:	01 45 14             	add    DWORD PTR [ebp+0x14],eax
						p0_x += bitc / 32; /* unneccessary as r does not change anymore */
    1386:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1389:	8d 50 1f             	lea    edx,[eax+0x1f]
    138c:	85 c0                	test   eax,eax
    138e:	0f 48 c2             	cmovs  eax,edx
    1391:	c1 f8 05             	sar    eax,0x5
    1394:	01 45 1c             	add    DWORD PTR [ebp+0x1c],eax
		while (px_x) {
    1397:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
    139b:	0f 85 66 fe ff ff    	jne    1207 <render_text_scanline_32btpp+0x147>
				} else
						break;
		}
}
    13a1:	eb 04                	jmp    13a7 <render_text_scanline_32btpp+0x2e7>
						break;
    13a3:	90                   	nop
    13a4:	eb 01                	jmp    13a7 <render_text_scanline_32btpp+0x2e7>
						break;
    13a6:	90                   	nop
}
    13a7:	90                   	nop
    13a8:	c9                   	leave
    13a9:	c3                   	ret

000013aa <render_text_scanline_8btpp>:

/* ~32 times better performance than /w byte access in old method below */
void render_text_scanline_8btpp(const char* font, char* str, void* mem,
				ssize_t px_x, ssize_t cur_x, ssize_t p0_x)
{
    13aa:	55                   	push   ebp
    13ab:	89 e5                	mov    ebp,esp
    13ad:	53                   	push   ebx
    13ae:	83 ec 54             	sub    esp,0x54
		uint8_t pxb[8 + 7]; /* for any stack alignment */
		ssize_t misalign = ((size_t)mem % 8) ? (8 - (size_t)mem % 8) : 0;
    13b1:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    13b4:	83 e0 07             	and    eax,0x7
    13b7:	85 c0                	test   eax,eax
    13b9:	74 11                	je     13cc <render_text_scanline_8btpp+0x22>
    13bb:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    13be:	83 e0 07             	and    eax,0x7
    13c1:	ba 08 00 00 00       	mov    edx,0x8
    13c6:	29 c2                	sub    edx,eax
    13c8:	89 d0                	mov    eax,edx
    13ca:	eb 05                	jmp    13d1 <render_text_scanline_8btpp+0x27>
    13cc:	b8 00 00 00 00       	mov    eax,0x0
    13d1:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		ssize_t r = p0_x % 8;
    13d4:	8b 55 1c             	mov    edx,DWORD PTR [ebp+0x1c]
    13d7:	89 d0                	mov    eax,edx
    13d9:	c1 f8 1f             	sar    eax,0x1f
    13dc:	c1 e8 1d             	shr    eax,0x1d
    13df:	01 c2                	add    edx,eax
    13e1:	83 e2 07             	and    edx,0x7
    13e4:	29 c2                	sub    edx,eax
    13e6:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
		uint8_t* pixbuf = pxb + (((size_t)pxb % 8) ? (8 - ((size_t)pxb % 8)) : 0);
    13e9:	8d 45 b1             	lea    eax,[ebp-0x4f]
    13ec:	83 e0 07             	and    eax,0x7
    13ef:	85 c0                	test   eax,eax
    13f1:	74 11                	je     1404 <render_text_scanline_8btpp+0x5a>
    13f3:	8d 45 b1             	lea    eax,[ebp-0x4f]
    13f6:	83 e0 07             	and    eax,0x7
    13f9:	89 c2                	mov    edx,eax
    13fb:	b8 08 00 00 00       	mov    eax,0x8
    1400:	29 d0                	sub    eax,edx
    1402:	eb 05                	jmp    1409 <render_text_scanline_8btpp+0x5f>
    1404:	b8 00 00 00 00       	mov    eax,0x0
    1409:	8d 55 b1             	lea    edx,[ebp-0x4f]
    140c:	01 d0                	add    eax,edx
    140e:	89 45 ac             	mov    DWORD PTR [ebp-0x54],eax
		/* 64-bit aligned moves are enough */

		if (misalign) { /* we first have to draw misalign pixels */
    1411:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    1415:	0f 84 05 03 00 00    	je     1720 <render_text_scanline_8btpp+0x376>
				int col = p0_x / 8, inv = (col == cur_x);
    141b:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
    141e:	8d 50 07             	lea    edx,[eax+0x7]
    1421:	85 c0                	test   eax,eax
    1423:	0f 48 c2             	cmovs  eax,edx
    1426:	c1 f8 03             	sar    eax,0x3
    1429:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    142c:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    142f:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
    1432:	0f 94 c0             	sete   al
    1435:	0f b6 c0             	movzx  eax,al
    1438:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
				ssize_t bc = min(misalign, px_x); /* r already set */
    143b:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
    143e:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    1441:	39 c2                	cmp    edx,eax
    1443:	0f 4e c2             	cmovle eax,edx
    1446:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
				ssize_t rmax = min(8, r + bc), bc1 = rmax - r;
    1449:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    144c:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    144f:	01 d0                	add    eax,edx
    1451:	ba 08 00 00 00       	mov    edx,0x8
    1456:	39 d0                	cmp    eax,edx
    1458:	0f 4f c2             	cmovg  eax,edx
    145b:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
    145e:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1461:	2b 45 e4             	sub    eax,DWORD PTR [ebp-0x1c]
    1464:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax

				generate_char_colors(font, str[0], str[1], 8,
    1467:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    146a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    146d:	83 c0 01             	add    eax,0x1
    1470:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1473:	0f be d0             	movsx  edx,al
    1476:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1479:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    147c:	0f be c0             	movsx  eax,al
    147f:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
    1482:	51                   	push   ecx
    1483:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    1486:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
    1489:	6a 08                	push   0x8
    148b:	52                   	push   edx
    148c:	50                   	push   eax
    148d:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1490:	e8 fc ff ff ff       	call   1491 <render_text_scanline_8btpp+0xe7>
    1495:	83 c4 20             	add    esp,0x20
								r, rmax, pixbuf, inv);
				if (rmax == 8)
    1498:	83 7d d4 08          	cmp    DWORD PTR [ebp-0x2c],0x8
    149c:	75 04                	jne    14a2 <render_text_scanline_8btpp+0xf8>
						str += 2;
    149e:	83 45 0c 02          	add    DWORD PTR [ebp+0xc],0x2
				if (bc > bc1) {
    14a2:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    14a5:	3b 45 d0             	cmp    eax,DWORD PTR [ebp-0x30]
    14a8:	7e 4f                	jle    14f9 <render_text_scanline_8btpp+0x14f>
						col++;
    14aa:	83 45 e0 01          	add    DWORD PTR [ebp-0x20],0x1
						inv = (col == cur_x);
    14ae:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    14b1:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
    14b4:	0f 94 c0             	sete   al
    14b7:	0f b6 c0             	movzx  eax,al
    14ba:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
						generate_char_colors(font, str[0], str[1], 8,
    14bd:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
    14c0:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    14c3:	8d 1c 02             	lea    ebx,[edx+eax*1]
    14c6:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    14c9:	2b 45 d0             	sub    eax,DWORD PTR [ebp-0x30]
    14cc:	89 c1                	mov    ecx,eax
    14ce:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    14d1:	83 c0 01             	add    eax,0x1
    14d4:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    14d7:	0f be d0             	movsx  edx,al
    14da:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    14dd:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    14e0:	0f be c0             	movsx  eax,al
    14e3:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
    14e6:	53                   	push   ebx
    14e7:	51                   	push   ecx
    14e8:	6a 00                	push   0x0
    14ea:	6a 08                	push   0x8
    14ec:	52                   	push   edx
    14ed:	50                   	push   eax
    14ee:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    14f1:	e8 fc ff ff ff       	call   14f2 <render_text_scanline_8btpp+0x148>
    14f6:	83 c4 20             	add    esp,0x20
										0, bc - bc1, pixbuf + bc1, inv);
				}
				memcpy(mem, pixbuf, bc);
    14f9:	8b 4d d8             	mov    ecx,DWORD PTR [ebp-0x28]
    14fc:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
    14ff:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1502:	83 ec 04             	sub    esp,0x4
    1505:	51                   	push   ecx
    1506:	52                   	push   edx
    1507:	50                   	push   eax
    1508:	e8 f3 ea ff ff       	call   0 <memcpy>
    150d:	83 c4 10             	add    esp,0x10
				px_x -= bc;
    1510:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1513:	29 45 14             	sub    DWORD PTR [ebp+0x14],eax
				p0_x += bc;
    1516:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1519:	01 45 1c             	add    DWORD PTR [ebp+0x1c],eax
				mem += bc;
    151c:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
    151f:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1522:	01 d0                	add    eax,edx
    1524:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
		}

		/* now we can draw 8 pixels each */
		while (px_x) {
    1527:	e9 f4 01 00 00       	jmp    1720 <render_text_scanline_8btpp+0x376>
				int col = p0_x / 8, inv = (col == cur_x);
    152c:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
    152f:	8d 50 07             	lea    edx,[eax+0x7]
    1532:	85 c0                	test   eax,eax
    1534:	0f 48 c2             	cmovs  eax,edx
    1537:	c1 f8 03             	sar    eax,0x3
    153a:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
    153d:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    1540:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
    1543:	0f 94 c0             	sete   al
    1546:	0f b6 c0             	movzx  eax,al
    1549:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
				ssize_t rmax, bitc, btt = min(64, 8 * px_x), cc;
    154c:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    154f:	c1 e0 03             	shl    eax,0x3
    1552:	ba 40 00 00 00       	mov    edx,0x40
    1557:	39 d0                	cmp    eax,edx
    1559:	0f 4f c2             	cmovg  eax,edx
    155c:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
				r = p0_x % 8;
    155f:	8b 55 1c             	mov    edx,DWORD PTR [ebp+0x1c]
    1562:	89 d0                	mov    eax,edx
    1564:	c1 f8 1f             	sar    eax,0x1f
    1567:	c1 e8 1d             	shr    eax,0x1d
    156a:	01 c2                	add    edx,eax
    156c:	83 e2 07             	and    edx,0x7
    156f:	29 c2                	sub    edx,eax
    1571:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
				rmax = min(8, r + px_x);
    1574:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    1577:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    157a:	01 d0                	add    eax,edx
    157c:	ba 08 00 00 00       	mov    edx,0x8
    1581:	39 d0                	cmp    eax,edx
    1583:	0f 4f c2             	cmovg  eax,edx
    1586:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
				/* get the remaining character pixels */
				bitc = generate_char_colors(font, str[0], str[1], 8,
    1589:	8b 4d ac             	mov    ecx,DWORD PTR [ebp-0x54]
    158c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    158f:	83 c0 01             	add    eax,0x1
    1592:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1595:	0f be d0             	movsx  edx,al
    1598:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    159b:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    159e:	0f be c0             	movsx  eax,al
    15a1:	ff 75 c8             	push   DWORD PTR [ebp-0x38]
    15a4:	51                   	push   ecx
    15a5:	ff 75 c0             	push   DWORD PTR [ebp-0x40]
    15a8:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
    15ab:	6a 08                	push   0x8
    15ad:	52                   	push   edx
    15ae:	50                   	push   eax
    15af:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    15b2:	e8 fc ff ff ff       	call   15b3 <render_text_scanline_8btpp+0x209>
    15b7:	83 c4 20             	add    esp,0x20
    15ba:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
								r, rmax, pixbuf, inv);
				/* now advance */
				str += 2;
    15bd:	83 45 0c 02          	add    DWORD PTR [ebp+0xc],0x2
				cc = bitc / 8;
    15c1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    15c4:	8d 50 07             	lea    edx,[eax+0x7]
    15c7:	85 c0                	test   eax,eax
    15c9:	0f 48 c2             	cmovs  eax,edx
    15cc:	c1 f8 03             	sar    eax,0x3
    15cf:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				/* and fetch more pixels if needed (r=0) */
				if (bitc < btt) {
    15d2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    15d5:	3b 45 c4             	cmp    eax,DWORD PTR [ebp-0x3c]
    15d8:	7d 71                	jge    164b <render_text_scanline_8btpp+0x2a1>
						col++;
    15da:	83 45 cc 01          	add    DWORD PTR [ebp-0x34],0x1
						inv = (col == cur_x);
    15de:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    15e1:	3b 45 18             	cmp    eax,DWORD PTR [ebp+0x18]
    15e4:	0f 94 c0             	sete   al
    15e7:	0f b6 c0             	movzx  eax,al
    15ea:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
						bitc += generate_char_colors(font, str[0], str[1], 8,
    15ed:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
    15f0:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    15f3:	8d 1c 02             	lea    ebx,[edx+eax*1]
    15f6:	83 7d 14 08          	cmp    DWORD PTR [ebp+0x14],0x8
    15fa:	7e 0a                	jle    1606 <render_text_scanline_8btpp+0x25c>
    15fc:	b8 08 00 00 00       	mov    eax,0x8
    1601:	2b 45 f0             	sub    eax,DWORD PTR [ebp-0x10]
    1604:	eb 06                	jmp    160c <render_text_scanline_8btpp+0x262>
    1606:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    1609:	2b 45 f0             	sub    eax,DWORD PTR [ebp-0x10]
    160c:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    160f:	83 c2 01             	add    edx,0x1
    1612:	0f b6 12             	movzx  edx,BYTE PTR [edx]
    1615:	0f be ca             	movsx  ecx,dl
    1618:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    161b:	0f b6 12             	movzx  edx,BYTE PTR [edx]
    161e:	0f be d2             	movsx  edx,dl
    1621:	ff 75 c8             	push   DWORD PTR [ebp-0x38]
    1624:	53                   	push   ebx
    1625:	50                   	push   eax
    1626:	6a 00                	push   0x0
    1628:	6a 08                	push   0x8
    162a:	51                   	push   ecx
    162b:	52                   	push   edx
    162c:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    162f:	e8 fc ff ff ff       	call   1630 <render_text_scanline_8btpp+0x286>
    1634:	83 c4 20             	add    esp,0x20
    1637:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
										0, min(8 - cc, px_x - cc), pixbuf + cc, inv);
						cc = bitc / 8;
    163a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    163d:	8d 50 07             	lea    edx,[eax+0x7]
    1640:	85 c0                	test   eax,eax
    1642:	0f 48 c2             	cmovs  eax,edx
    1645:	c1 f8 03             	sar    eax,0x3
    1648:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				}
				/* now transfer */
				if (bitc >= 64) {
    164b:	83 7d f4 3f          	cmp    DWORD PTR [ebp-0xc],0x3f
    164f:	7e 24                	jle    1675 <render_text_scanline_8btpp+0x2cb>
						move_64(pixbuf, mem);
    1651:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    1654:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
    1657:	0f 6f 00             	movq   mm0,QWORD PTR [eax]
    165a:	0f 7f 02             	movq   QWORD PTR [edx],mm0
						mem += 8; /* intentionally no bitc subtract */
    165d:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1660:	83 c0 08             	add    eax,0x8
    1663:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
						}
						break;
				}

				/* and don't advance as r = 0 is already handled (sth. remains) */
				if (px_x) {
    1666:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
    166a:	0f 84 bc 00 00 00    	je     172c <render_text_scanline_8btpp+0x382>
    1670:	e9 9f 00 00 00       	jmp    1714 <render_text_scanline_8btpp+0x36a>
						uint8_t* pt = pixbuf;
    1675:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    1678:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
						if (bitc >= 32) {
    167b:	83 7d f4 1f          	cmp    DWORD PTR [ebp-0xc],0x1f
    167f:	7e 1b                	jle    169c <render_text_scanline_8btpp+0x2f2>
								*(uint32_t*)mem = *(uint32_t*)pixbuf;
    1681:	8b 55 ac             	mov    edx,DWORD PTR [ebp-0x54]
    1684:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1687:	8b 12                	mov    edx,DWORD PTR [edx]
    1689:	89 10                	mov    DWORD PTR [eax],edx
								pt += 4;
    168b:	83 45 ec 04          	add    DWORD PTR [ebp-0x14],0x4
								mem += 4;
    168f:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1692:	83 c0 04             	add    eax,0x4
    1695:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
								bitc -= 32;
    1698:	83 6d f4 20          	sub    DWORD PTR [ebp-0xc],0x20
						if (bitc >= 16) {
    169c:	83 7d f4 0f          	cmp    DWORD PTR [ebp-0xc],0xf
    16a0:	7e 1d                	jle    16bf <render_text_scanline_8btpp+0x315>
								*(uint16_t*)mem = *(uint16_t*)pt;
    16a2:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    16a5:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    16a8:	0f b7 12             	movzx  edx,WORD PTR [edx]
    16ab:	66 89 10             	mov    WORD PTR [eax],dx
								pt += 2;
    16ae:	83 45 ec 02          	add    DWORD PTR [ebp-0x14],0x2
								mem += 2;
    16b2:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    16b5:	83 c0 02             	add    eax,0x2
    16b8:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
								bitc -= 16;
    16bb:	83 6d f4 10          	sub    DWORD PTR [ebp-0xc],0x10
						if (bitc >= 8) {
    16bf:	83 7d f4 07          	cmp    DWORD PTR [ebp-0xc],0x7
    16c3:	7e 1e                	jle    16e3 <render_text_scanline_8btpp+0x339>
								*(uint8_t*)mem = *(uint8_t*)pt;
    16c5:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    16c8:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    16cb:	0f b6 12             	movzx  edx,BYTE PTR [edx]
    16ce:	88 10                	mov    BYTE PTR [eax],dl
								pt += 1;
    16d0:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
								mem += 1;
    16d4:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    16d7:	83 c0 01             	add    eax,0x1
    16da:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
								bitc -= 8;
    16dd:	83 6d f4 08          	sub    DWORD PTR [ebp-0xc],0x8
						break;
    16e1:	eb 4c                	jmp    172f <render_text_scanline_8btpp+0x385>
						} else if (bitc) {
    16e3:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    16e7:	74 46                	je     172f <render_text_scanline_8btpp+0x385>
								die("cant happen with byte sized pixels!\n");
    16e9:	83 ec 08             	sub    esp,0x8
    16ec:	68 94 01 00 00       	push   0x194
    16f1:	6a 0c                	push   0xc
    16f3:	e8 fc ff ff ff       	call   16f4 <render_text_scanline_8btpp+0x34a>
    16f8:	83 c4 10             	add    esp,0x10
    16fb:	e8 fc ff ff ff       	call   16fc <render_text_scanline_8btpp+0x352>
    1700:	83 ec 0c             	sub    esp,0xc
    1703:	68 00 00 00 00       	push   0x0
    1708:	e8 fc ff ff ff       	call   1709 <render_text_scanline_8btpp+0x35f>
    170d:	83 c4 10             	add    esp,0x10
    1710:	fa                   	cli
    1711:	f4                   	hlt
    1712:	eb fd                	jmp    1711 <render_text_scanline_8btpp+0x367>
						px_x -= cc;
    1714:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1717:	29 45 14             	sub    DWORD PTR [ebp+0x14],eax
						p0_x += cc; /* unneccessary as r does not change anymore */
    171a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    171d:	01 45 1c             	add    DWORD PTR [ebp+0x1c],eax
		while (px_x) {
    1720:	83 7d 14 00          	cmp    DWORD PTR [ebp+0x14],0x0
    1724:	0f 85 02 fe ff ff    	jne    152c <render_text_scanline_8btpp+0x182>
				} else
						break;
		}
}
    172a:	eb 04                	jmp    1730 <render_text_scanline_8btpp+0x386>
						break;
    172c:	90                   	nop
    172d:	eb 01                	jmp    1730 <render_text_scanline_8btpp+0x386>
						break;
    172f:	90                   	nop
}
    1730:	90                   	nop
    1731:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    1734:	c9                   	leave
    1735:	c3                   	ret

00001736 <render_text>:
/* this function uses pixel addressing for width and height
 * making it possible to render half/overlapping characters.
 */
void render_text(const char* font, char* str, void* mem, size_t text_stride, size_t mem_stride,
		size_t btpp, ssize_t px_x, ssize_t px_y, int starts_half, int cur_x, int cur_y, ssize_t p0_x, ssize_t p0_y)
{
    1736:	55                   	push   ebp
    1737:	89 e5                	mov    ebp,esp
    1739:	83 ec 18             	sub    esp,0x18
		(void)starts_half;
//		char is_half = 0, ends_half = 0;
		/* pixel offset is handled before calling the function */
//		is_half = starts_half;
//		ends_half = (px_x % 2) ? (!starts_half) : (starts_half);
		for (ssize_t ln = p0_y; ln < px_y + p0_y; ln++) {
    173c:	8b 45 38             	mov    eax,DWORD PTR [ebp+0x38]
    173f:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1742:	e9 a7 01 00 00       	jmp    18ee <render_text+0x1b8>
				ssize_t l = ln % 16; ssize_t cur_xv;
    1747:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    174a:	89 d0                	mov    eax,edx
    174c:	c1 f8 1f             	sar    eax,0x1f
    174f:	c1 e8 1c             	shr    eax,0x1c
    1752:	01 c2                	add    edx,eax
    1754:	83 e2 0f             	and    edx,0xf
    1757:	29 c2                	sub    edx,eax
    1759:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx

				/* check cursor */
				if (ln / 16 == cur_y)
    175c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    175f:	8d 50 0f             	lea    edx,[eax+0xf]
    1762:	85 c0                	test   eax,eax
    1764:	0f 48 c2             	cmovs  eax,edx
    1767:	c1 f8 04             	sar    eax,0x4
    176a:	39 45 30             	cmp    DWORD PTR [ebp+0x30],eax
    176d:	75 08                	jne    1777 <render_text+0x41>
						cur_xv = cur_x;
    176f:	8b 45 2c             	mov    eax,DWORD PTR [ebp+0x2c]
    1772:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    1775:	eb 07                	jmp    177e <render_text+0x48>
				else
						cur_xv = -1;
    1777:	c7 45 f0 ff ff ff ff 	mov    DWORD PTR [ebp-0x10],0xffffffff

				/* invoke the scanline drawing routines */
				switch (btpp) {
    177e:	83 7d 1c 20          	cmp    DWORD PTR [ebp+0x1c],0x20
    1782:	74 46                	je     17ca <render_text+0x94>
    1784:	83 7d 1c 20          	cmp    DWORD PTR [ebp+0x1c],0x20
    1788:	0f 87 1e 01 00 00    	ja     18ac <render_text+0x176>
    178e:	83 7d 1c 18          	cmp    DWORD PTR [ebp+0x1c],0x18
    1792:	0f 84 90 00 00 00    	je     1828 <render_text+0xf2>
    1798:	83 7d 1c 18          	cmp    DWORD PTR [ebp+0x1c],0x18
    179c:	0f 87 0a 01 00 00    	ja     18ac <render_text+0x176>
    17a2:	83 7d 1c 08          	cmp    DWORD PTR [ebp+0x1c],0x8
    17a6:	0f 84 db 00 00 00    	je     1887 <render_text+0x151>
    17ac:	83 7d 1c 08          	cmp    DWORD PTR [ebp+0x1c],0x8
    17b0:	0f 82 f6 00 00 00    	jb     18ac <render_text+0x176>
    17b6:	8b 45 1c             	mov    eax,DWORD PTR [ebp+0x1c]
    17b9:	83 e8 0f             	sub    eax,0xf
    17bc:	83 f8 01             	cmp    eax,0x1
    17bf:	0f 87 e7 00 00 00    	ja     18ac <render_text+0x176>
    17c5:	e9 95 00 00 00       	jmp    185f <render_text+0x129>
						case 32:
								if (cpu.has_sse)
    17ca:	0f b6 05 5b 00 00 00 	movzx  eax,BYTE PTR ds:0x5b
    17d1:	83 e0 02             	and    eax,0x2
    17d4:	84 c0                	test   al,al
    17d6:	74 28                	je     1800 <render_text+0xca>
										render_text_scanline_32btpp_sse(font + l, str,
    17d8:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    17db:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    17de:	01 d0                	add    eax,edx
    17e0:	83 ec 08             	sub    esp,0x8
    17e3:	ff 75 34             	push   DWORD PTR [ebp+0x34]
    17e6:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    17e9:	ff 75 20             	push   DWORD PTR [ebp+0x20]
    17ec:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    17ef:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    17f2:	50                   	push   eax
    17f3:	e8 fc ff ff ff       	call   17f4 <render_text+0xbe>
    17f8:	83 c4 20             	add    esp,0x20
												mem, px_x, cur_xv, p0_x);
								else
										render_text_scanline_32btpp(font + l, str,
												mem, px_x, cur_xv, p0_x);
								break;
    17fb:	e9 d8 00 00 00       	jmp    18d8 <render_text+0x1a2>
										render_text_scanline_32btpp(font + l, str,
    1800:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1803:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1806:	01 d0                	add    eax,edx
    1808:	83 ec 08             	sub    esp,0x8
    180b:	ff 75 34             	push   DWORD PTR [ebp+0x34]
    180e:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    1811:	ff 75 20             	push   DWORD PTR [ebp+0x20]
    1814:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    1817:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    181a:	50                   	push   eax
    181b:	e8 fc ff ff ff       	call   181c <render_text+0xe6>
    1820:	83 c4 20             	add    esp,0x20
								break;
    1823:	e9 b0 00 00 00       	jmp    18d8 <render_text+0x1a2>
						case 24: /* 16 bytes /w sse really needed */
								if (cpu.has_sse)
    1828:	0f b6 05 5b 00 00 00 	movzx  eax,BYTE PTR ds:0x5b
    182f:	83 e0 02             	and    eax,0x2
    1832:	84 c0                	test   al,al
    1834:	0f 84 9d 00 00 00    	je     18d7 <render_text+0x1a1>
										render_text_scanline_24btpp_sse(font + l, str,
    183a:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    183d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1840:	01 d0                	add    eax,edx
    1842:	83 ec 08             	sub    esp,0x8
    1845:	ff 75 34             	push   DWORD PTR [ebp+0x34]
    1848:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    184b:	ff 75 20             	push   DWORD PTR [ebp+0x20]
    184e:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    1851:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    1854:	50                   	push   eax
    1855:	e8 fc ff ff ff       	call   1856 <render_text+0x120>
    185a:	83 c4 20             	add    esp,0x20
												mem, px_x, cur_xv, p0_x);
								//else
								//		render_text_scanline_24btpp(font + l, str,
								//				mem, px_x, cur_xv, p0_x);
								break;
    185d:	eb 78                	jmp    18d7 <render_text+0x1a1>
						case 15:
						case 16:
								render_text_scanline_16btpp(font + l, str,
    185f:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1862:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1865:	01 d0                	add    eax,edx
    1867:	83 ec 04             	sub    esp,0x4
    186a:	ff 75 1c             	push   DWORD PTR [ebp+0x1c]
    186d:	ff 75 34             	push   DWORD PTR [ebp+0x34]
    1870:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    1873:	ff 75 20             	push   DWORD PTR [ebp+0x20]
    1876:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    1879:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    187c:	50                   	push   eax
    187d:	e8 fc ff ff ff       	call   187e <render_text+0x148>
    1882:	83 c4 20             	add    esp,0x20
												mem, px_x, cur_xv, p0_x, btpp);
								break;
    1885:	eb 51                	jmp    18d8 <render_text+0x1a2>
						case 8:
								render_text_scanline_8btpp(font + l, str,
    1887:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    188a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    188d:	01 d0                	add    eax,edx
    188f:	83 ec 08             	sub    esp,0x8
    1892:	ff 75 34             	push   DWORD PTR [ebp+0x34]
    1895:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    1898:	ff 75 20             	push   DWORD PTR [ebp+0x20]
    189b:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    189e:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    18a1:	50                   	push   eax
    18a2:	e8 fc ff ff ff       	call   18a3 <render_text+0x16d>
    18a7:	83 c4 20             	add    esp,0x20
												mem, px_x, cur_xv, p0_x);
								break;
    18aa:	eb 2c                	jmp    18d8 <render_text+0x1a2>
						default:
/*								render_text_scanline_xbtpp(font + l, str, btpp,
												mem, px_x, cur_xv, p0_x);*/
								die("not impl\n");
    18ac:	83 ec 08             	sub    esp,0x8
    18af:	68 b9 01 00 00       	push   0x1b9
    18b4:	6a 0c                	push   0xc
    18b6:	e8 fc ff ff ff       	call   18b7 <render_text+0x181>
    18bb:	83 c4 10             	add    esp,0x10
    18be:	e8 fc ff ff ff       	call   18bf <render_text+0x189>
    18c3:	83 ec 0c             	sub    esp,0xc
    18c6:	68 00 00 00 00       	push   0x0
    18cb:	e8 fc ff ff ff       	call   18cc <render_text+0x196>
    18d0:	83 c4 10             	add    esp,0x10
    18d3:	fa                   	cli
    18d4:	f4                   	hlt
    18d5:	eb fd                	jmp    18d4 <render_text+0x19e>
								break;
    18d7:	90                   	nop
								break;
				}

				/* advance */
				if (l == 15) {
    18d8:	83 7d ec 0f          	cmp    DWORD PTR [ebp-0x14],0xf
    18dc:	75 06                	jne    18e4 <render_text+0x1ae>
						str += text_stride;
    18de:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    18e1:	01 45 0c             	add    DWORD PTR [ebp+0xc],eax
				}
				mem += mem_stride;
    18e4:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
    18e7:	01 45 10             	add    DWORD PTR [ebp+0x10],eax
		for (ssize_t ln = p0_y; ln < px_y + p0_y; ln++) {
    18ea:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    18ee:	8b 55 24             	mov    edx,DWORD PTR [ebp+0x24]
    18f1:	8b 45 38             	mov    eax,DWORD PTR [ebp+0x38]
    18f4:	01 d0                	add    eax,edx
    18f6:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
    18f9:	0f 8c 48 fe ff ff    	jl     1747 <render_text+0x11>
		}
}
    18ff:	90                   	nop
    1900:	90                   	nop
    1901:	c9                   	leave
    1902:	c3                   	ret

00001903 <add_stride>:
		ssize_t x1, x2;
};

/* adds stride and returns 1 if new element was needed */
int add_stride(struct stride* sb, size_t num, struct stride* s)
{
    1903:	55                   	push   ebp
    1904:	89 e5                	mov    ebp,esp
    1906:	53                   	push   ebx
    1907:	83 ec 14             	sub    esp,0x14
		/* assume sortedness (our insertions are sorted) */
		for (size_t i = 0; i < num; i++) {
    190a:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    1911:	eb 7c                	jmp    198f <add_stride+0x8c>
				if (sb[i].x1 == s->x2) { /* extend below */
    1913:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1916:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    191d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1920:	01 d0                	add    eax,edx
    1922:	8b 10                	mov    edx,DWORD PTR [eax]
    1924:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1927:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    192a:	39 c2                	cmp    edx,eax
    192c:	75 20                	jne    194e <add_stride+0x4b>
						sb[i].x1 = s->x1;
    192e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1931:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    1938:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    193b:	01 c2                	add    edx,eax
    193d:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1940:	8b 00                	mov    eax,DWORD PTR [eax]
    1942:	89 02                	mov    DWORD PTR [edx],eax
						return 0;
    1944:	b8 00 00 00 00       	mov    eax,0x0
    1949:	e9 03 01 00 00       	jmp    1a51 <add_stride+0x14e>
				} else if (sb[i].x2 == s->x1) { /* extend above */
    194e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1951:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    1958:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    195b:	01 d0                	add    eax,edx
    195d:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1960:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1963:	8b 00                	mov    eax,DWORD PTR [eax]
    1965:	39 c2                	cmp    edx,eax
    1967:	75 22                	jne    198b <add_stride+0x88>
						sb[i].x2 = s->x2;
    1969:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    196c:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    1973:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1976:	01 c2                	add    edx,eax
    1978:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    197b:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    197e:	89 42 04             	mov    DWORD PTR [edx+0x4],eax
						return 0;
    1981:	b8 00 00 00 00       	mov    eax,0x0
    1986:	e9 c6 00 00 00       	jmp    1a51 <add_stride+0x14e>
		for (size_t i = 0; i < num; i++) {
    198b:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    198f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    1992:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
    1995:	0f 82 78 ff ff ff    	jb     1913 <add_stride+0x10>
				}
		}
		/* insert sorted */
		for (size_t i = 0; i < num; i++)
    199b:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    19a2:	eb 7f                	jmp    1a23 <add_stride+0x120>
				if (sb[i].x1 < s->x2) {
    19a4:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    19a7:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    19ae:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    19b1:	01 d0                	add    eax,edx
    19b3:	8b 10                	mov    edx,DWORD PTR [eax]
    19b5:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    19b8:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    19bb:	39 c2                	cmp    edx,eax
    19bd:	7d 60                	jge    1a1f <add_stride+0x11c>
						memmove(sb + i + 1, sb + i, (num - i) * sizeof(*s));
    19bf:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    19c2:	2b 45 f0             	sub    eax,DWORD PTR [ebp-0x10]
    19c5:	8d 0c c5 00 00 00 00 	lea    ecx,[eax*8+0x0]
    19cc:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    19cf:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    19d6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    19d9:	01 c2                	add    edx,eax
    19db:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    19de:	83 c0 01             	add    eax,0x1
    19e1:	8d 1c c5 00 00 00 00 	lea    ebx,[eax*8+0x0]
    19e8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    19eb:	01 d8                	add    eax,ebx
    19ed:	83 ec 04             	sub    esp,0x4
    19f0:	51                   	push   ecx
    19f1:	52                   	push   edx
    19f2:	50                   	push   eax
    19f3:	e8 fc ff ff ff       	call   19f4 <add_stride+0xf1>
    19f8:	83 c4 10             	add    esp,0x10
						sb[i] = *s;
    19fb:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    19fe:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    1a05:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1a08:	8d 0c 02             	lea    ecx,[edx+eax*1]
    1a0b:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1a0e:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1a11:	8b 00                	mov    eax,DWORD PTR [eax]
    1a13:	89 01                	mov    DWORD PTR [ecx],eax
    1a15:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
						return 1;
    1a18:	b8 01 00 00 00       	mov    eax,0x1
    1a1d:	eb 32                	jmp    1a51 <add_stride+0x14e>
		for (size_t i = 0; i < num; i++)
    1a1f:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
    1a23:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1a26:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
    1a29:	0f 82 75 ff ff ff    	jb     19a4 <add_stride+0xa1>
				}
		/* element is last */
		sb[num] = *s;
    1a2f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1a32:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
    1a39:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1a3c:	8d 0c 02             	lea    ecx,[edx+eax*1]
    1a3f:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1a42:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1a45:	8b 00                	mov    eax,DWORD PTR [eax]
    1a47:	89 01                	mov    DWORD PTR [ecx],eax
    1a49:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
		return 1;
    1a4c:	b8 01 00 00 00       	mov    eax,0x1
}
    1a51:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    1a54:	c9                   	leave
    1a55:	c3                   	ret

00001a56 <framebuffer_redraw>:

uint64_t fb_rdt = 0;
/* redraws the complete screen */
void framebuffer_redraw_region(struct framebuffer* fb, struct kio_region* r);
void framebuffer_redraw(struct framebuffer* fb)
{
    1a56:	55                   	push   ebp
    1a57:	89 e5                	mov    ebp,esp
    1a59:	83 ec 28             	sub    esp,0x28
		struct kio_region r = {0}; /* sse alignment */
    1a5c:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
    1a63:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
    1a6a:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
    1a71:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    1a78:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		r.lx = fb->chw_x; r.ly = fb->chw_y;
    1a7f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1a82:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    1a85:	66 89 45 e8          	mov    WORD PTR [ebp-0x18],ax
    1a89:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1a8c:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    1a8f:	66 89 45 ea          	mov    WORD PTR [ebp-0x16],ax
		r.x = fb->cho_x; r.y = fb->cho_y;
    1a93:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1a96:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
    1a99:	66 89 45 e4          	mov    WORD PTR [ebp-0x1c],ax
    1a9d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1aa0:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    1aa3:	66 89 45 e6          	mov    WORD PTR [ebp-0x1a],ax
		framebuffer_redraw_region(fb, &r);
    1aa7:	83 ec 08             	sub    esp,0x8
    1aaa:	8d 45 e4             	lea    eax,[ebp-0x1c]
    1aad:	50                   	push   eax
    1aae:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1ab1:	e8 fc ff ff ff       	call   1ab2 <framebuffer_redraw+0x5c>
    1ab6:	83 c4 10             	add    esp,0x10
}
    1ab9:	90                   	nop
    1aba:	c9                   	leave
    1abb:	c3                   	ret

00001abc <framebuffer_redraw_region>:

/* redraws a defined region (screen relative, not buffer, internal) */
void framebuffer_redraw_region(struct framebuffer* fb, struct kio_region* r)
{
    1abc:	55                   	push   ebp
    1abd:	89 e5                	mov    ebp,esp
    1abf:	57                   	push   edi
    1ac0:	56                   	push   esi
    1ac1:	53                   	push   ebx
    1ac2:	81 ec 9c 01 00 00    	sub    esp,0x19c
		if (vga_mem_ptr == fb->text_mem)
    1ac8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1acb:	8b 10                	mov    edx,DWORD PTR [eax]
    1acd:	a1 00 00 00 00       	mov    eax,ds:0x0
    1ad2:	39 c2                	cmp    edx,eax
    1ad4:	0f 84 a0 0b 00 00    	je     267a <framebuffer_redraw_region+0xbbe>
				return; /* don't do anything if we're directly on video memory */
		else if (video_mode.is_textmode) {
    1ada:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
    1ae1:	84 c0                	test   al,al
    1ae3:	0f 84 6a 03 00 00    	je     1e53 <framebuffer_redraw_region+0x397>
				if (video_mode.width == fb->width && fb->chw_x == fb->width
    1ae9:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    1aef:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1af2:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1af5:	39 c2                	cmp    edx,eax
    1af7:	0f 85 5d 01 00 00    	jne    1c5a <framebuffer_redraw_region+0x19e>
    1afd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b00:	8b 50 2c             	mov    edx,DWORD PTR [eax+0x2c]
    1b03:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b06:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1b09:	39 c2                	cmp    edx,eax
    1b0b:	0f 85 49 01 00 00    	jne    1c5a <framebuffer_redraw_region+0x19e>
							   && r->lx == fb->width && !fb->pix_x) {
    1b11:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1b14:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
    1b18:	0f bf d0             	movsx  edx,ax
    1b1b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b1e:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1b21:	39 c2                	cmp    edx,eax
    1b23:	0f 85 31 01 00 00    	jne    1c5a <framebuffer_redraw_region+0x19e>
    1b29:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b2c:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    1b2f:	85 c0                	test   eax,eax
    1b31:	0f 85 23 01 00 00    	jne    1c5a <framebuffer_redraw_region+0x19e>
						ssize_t nl;
						/* super easy memory transfer */
						fb->cho_x = 0;
    1b37:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b3a:	c7 40 24 00 00 00 00 	mov    DWORD PTR [eax+0x24],0x0
						nl = min(min(video_mode.height - fb->pix_y, fb->chw_y),
    1b41:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1b44:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
    1b48:	0f bf d0             	movsx  edx,ax
    1b4b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b4e:	8b 58 08             	mov    ebx,DWORD PTR [eax+0x8]
    1b51:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b54:	8b 48 28             	mov    ecx,DWORD PTR [eax+0x28]
    1b57:	89 d8                	mov    eax,ebx
    1b59:	29 c8                	sub    eax,ecx
    1b5b:	39 c2                	cmp    edx,eax
    1b5d:	0f 4f d0             	cmovg  edx,eax
    1b60:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b63:	8b 48 30             	mov    ecx,DWORD PTR [eax+0x30]
    1b66:	8b 35 08 00 00 00    	mov    esi,DWORD PTR ds:0x8
    1b6c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b6f:	8b 58 20             	mov    ebx,DWORD PTR [eax+0x20]
    1b72:	89 f0                	mov    eax,esi
    1b74:	29 d8                	sub    eax,ebx
    1b76:	39 c1                	cmp    ecx,eax
    1b78:	0f 4e c1             	cmovle eax,ecx
    1b7b:	39 c2                	cmp    edx,eax
    1b7d:	0f 4e c2             	cmovle eax,edx
    1b80:	89 45 90             	mov    DWORD PTR [ebp-0x70],eax
										min(fb->height - fb->cho_y, r->ly));
						memcpy(vga_mem_ptr + (fb->pix_y + r->y) * 2 * video_mode.width,
										fb->text_mem + (fb->cho_y + r->y) * 2
										* fb->width, nl * 2 * fb->width);
    1b83:	8b 45 90             	mov    eax,DWORD PTR [ebp-0x70]
    1b86:	8d 14 00             	lea    edx,[eax+eax*1]
    1b89:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b8c:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1b8f:	0f af c2             	imul   eax,edx
						memcpy(vga_mem_ptr + (fb->pix_y + r->y) * 2 * video_mode.width,
    1b92:	89 c6                	mov    esi,eax
										fb->text_mem + (fb->cho_y + r->y) * 2
    1b94:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b97:	8b 10                	mov    edx,DWORD PTR [eax]
    1b99:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1b9c:	8b 48 28             	mov    ecx,DWORD PTR [eax+0x28]
    1b9f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1ba2:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    1ba6:	98                   	cwde
    1ba7:	01 c8                	add    eax,ecx
    1ba9:	8d 0c 00             	lea    ecx,[eax+eax*1]
										* fb->width, nl * 2 * fb->width);
    1bac:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1baf:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1bb2:	0f af c1             	imul   eax,ecx
										fb->text_mem + (fb->cho_y + r->y) * 2
    1bb5:	01 c2                	add    edx,eax
						memcpy(vga_mem_ptr + (fb->pix_y + r->y) * 2 * video_mode.width,
    1bb7:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
    1bbd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1bc0:	8b 58 20             	mov    ebx,DWORD PTR [eax+0x20]
    1bc3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1bc6:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    1bca:	98                   	cwde
    1bcb:	01 d8                	add    eax,ebx
    1bcd:	8d 1c 00             	lea    ebx,[eax+eax*1]
    1bd0:	a1 04 00 00 00       	mov    eax,ds:0x4
    1bd5:	0f af c3             	imul   eax,ebx
    1bd8:	01 c8                	add    eax,ecx
    1bda:	56                   	push   esi
    1bdb:	52                   	push   edx
    1bdc:	50                   	push   eax
    1bdd:	e8 1e e4 ff ff       	call   0 <memcpy>
    1be2:	83 c4 0c             	add    esp,0xc
						/* show we're outside of buffer (for large cho_y) */
						if (nl < fb->chw_y)
    1be5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1be8:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    1beb:	39 45 90             	cmp    DWORD PTR [ebp-0x70],eax
    1bee:	0f 8d 59 02 00 00    	jge    1e4d <framebuffer_redraw_region+0x391>
								bzero(vga_mem_ptr + (fb->pix_y + r->y + nl) * 2 * fb->width,
										(min(fb->chw_y, video_mode.height - fb->pix_y)
    1bf4:	8b 15 08 00 00 00    	mov    edx,DWORD PTR ds:0x8
    1bfa:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1bfd:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    1c00:	29 c2                	sub    edx,eax
    1c02:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1c05:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    1c08:	39 c2                	cmp    edx,eax
    1c0a:	0f 4e c2             	cmovle eax,edx
										 - nl) * fb->width * 2);
    1c0d:	2b 45 90             	sub    eax,DWORD PTR [ebp-0x70]
    1c10:	89 c2                	mov    edx,eax
    1c12:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1c15:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1c18:	0f af c2             	imul   eax,edx
    1c1b:	01 c0                	add    eax,eax
								bzero(vga_mem_ptr + (fb->pix_y + r->y + nl) * 2 * fb->width,
    1c1d:	89 c3                	mov    ebx,eax
    1c1f:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    1c25:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1c28:	8b 48 20             	mov    ecx,DWORD PTR [eax+0x20]
    1c2b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1c2e:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    1c32:	98                   	cwde
    1c33:	01 c1                	add    ecx,eax
    1c35:	8b 45 90             	mov    eax,DWORD PTR [ebp-0x70]
    1c38:	01 c8                	add    eax,ecx
    1c3a:	8d 0c 00             	lea    ecx,[eax+eax*1]
    1c3d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1c40:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1c43:	0f af c1             	imul   eax,ecx
    1c46:	01 d0                	add    eax,edx
    1c48:	83 ec 08             	sub    esp,0x8
    1c4b:	53                   	push   ebx
    1c4c:	50                   	push   eax
    1c4d:	e8 fc ff ff ff       	call   1c4e <framebuffer_redraw_region+0x192>
    1c52:	83 c4 10             	add    esp,0x10
							   && r->lx == fb->width && !fb->pix_x) {
    1c55:	e9 f3 01 00 00       	jmp    1e4d <framebuffer_redraw_region+0x391>
				} else {
						ssize_t nl, nc; void *src, *dst;
						/* copy linewise */
						nl = min(min(video_mode.height - fb->pix_y, fb->chw_y),
    1c5a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1c5d:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
    1c61:	0f bf d0             	movsx  edx,ax
    1c64:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1c67:	8b 58 08             	mov    ebx,DWORD PTR [eax+0x8]
    1c6a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1c6d:	8b 48 28             	mov    ecx,DWORD PTR [eax+0x28]
    1c70:	89 d8                	mov    eax,ebx
    1c72:	29 c8                	sub    eax,ecx
    1c74:	39 c2                	cmp    edx,eax
    1c76:	0f 4f d0             	cmovg  edx,eax
    1c79:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1c7c:	8b 48 30             	mov    ecx,DWORD PTR [eax+0x30]
    1c7f:	8b 35 08 00 00 00    	mov    esi,DWORD PTR ds:0x8
    1c85:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1c88:	8b 58 20             	mov    ebx,DWORD PTR [eax+0x20]
    1c8b:	89 f0                	mov    eax,esi
    1c8d:	29 d8                	sub    eax,ebx
    1c8f:	39 c1                	cmp    ecx,eax
    1c91:	0f 4e c1             	cmovle eax,ecx
    1c94:	39 c2                	cmp    edx,eax
    1c96:	0f 4e c2             	cmovle eax,edx
    1c99:	89 45 8c             	mov    DWORD PTR [ebp-0x74],eax
									   	min(fb->height - fb->cho_y, r->ly));
						nc = min(min(video_mode.width - fb->pix_x, fb->chw_x),
    1c9c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1c9f:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
    1ca3:	0f bf d0             	movsx  edx,ax
    1ca6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ca9:	8b 58 04             	mov    ebx,DWORD PTR [eax+0x4]
    1cac:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1caf:	8b 48 24             	mov    ecx,DWORD PTR [eax+0x24]
    1cb2:	89 d8                	mov    eax,ebx
    1cb4:	29 c8                	sub    eax,ecx
    1cb6:	39 c2                	cmp    edx,eax
    1cb8:	0f 4f d0             	cmovg  edx,eax
    1cbb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1cbe:	8b 48 2c             	mov    ecx,DWORD PTR [eax+0x2c]
    1cc1:	8b 35 04 00 00 00    	mov    esi,DWORD PTR ds:0x4
    1cc7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1cca:	8b 58 1c             	mov    ebx,DWORD PTR [eax+0x1c]
    1ccd:	89 f0                	mov    eax,esi
    1ccf:	29 d8                	sub    eax,ebx
    1cd1:	39 c1                	cmp    ecx,eax
    1cd3:	0f 4e c1             	cmovle eax,ecx
    1cd6:	39 c2                	cmp    edx,eax
    1cd8:	0f 4e c2             	cmovle eax,edx
    1cdb:	89 45 88             	mov    DWORD PTR [ebp-0x78],eax
										min(fb->width - fb->cho_x, r->lx));
						src = fb->text_mem + (fb->cho_y + r->y) * 2 * fb->width + 2 * (fb->cho_x + r->y);
    1cde:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ce1:	8b 10                	mov    edx,DWORD PTR [eax]
    1ce3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ce6:	8b 48 28             	mov    ecx,DWORD PTR [eax+0x28]
    1ce9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1cec:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    1cf0:	98                   	cwde
    1cf1:	01 c8                	add    eax,ecx
    1cf3:	8d 0c 00             	lea    ecx,[eax+eax*1]
    1cf6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1cf9:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1cfc:	0f af c1             	imul   eax,ecx
    1cff:	89 c3                	mov    ebx,eax
    1d01:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1d04:	8b 48 24             	mov    ecx,DWORD PTR [eax+0x24]
    1d07:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1d0a:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    1d0e:	98                   	cwde
    1d0f:	01 c8                	add    eax,ecx
    1d11:	01 c0                	add    eax,eax
    1d13:	01 d8                	add    eax,ebx
    1d15:	01 d0                	add    eax,edx
    1d17:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
						dst = vga_mem_ptr + (fb->pix_y + r->y) * 2 * video_mode.width + 2 * (fb->pix_x + r->y);
    1d1a:	8b 15 00 00 00 00    	mov    edx,DWORD PTR ds:0x0
    1d20:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1d23:	8b 48 20             	mov    ecx,DWORD PTR [eax+0x20]
    1d26:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1d29:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    1d2d:	98                   	cwde
    1d2e:	01 c8                	add    eax,ecx
    1d30:	8d 0c 00             	lea    ecx,[eax+eax*1]
    1d33:	a1 04 00 00 00       	mov    eax,ds:0x4
    1d38:	0f af c1             	imul   eax,ecx
    1d3b:	89 c3                	mov    ebx,eax
    1d3d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1d40:	8b 48 1c             	mov    ecx,DWORD PTR [eax+0x1c]
    1d43:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1d46:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    1d4a:	98                   	cwde
    1d4b:	01 c8                	add    eax,ecx
    1d4d:	01 c0                	add    eax,eax
    1d4f:	01 d8                	add    eax,ebx
    1d51:	01 d0                	add    eax,edx
    1d53:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
						while (nl) {
    1d56:	eb 7d                	jmp    1dd5 <framebuffer_redraw_region+0x319>
								memcpy(dst, src, 2 * nc);
    1d58:	8b 45 88             	mov    eax,DWORD PTR [ebp-0x78]
    1d5b:	01 c0                	add    eax,eax
    1d5d:	83 ec 04             	sub    esp,0x4
    1d60:	50                   	push   eax
    1d61:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
    1d64:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
    1d67:	e8 94 e2 ff ff       	call   0 <memcpy>
    1d6c:	83 c4 10             	add    esp,0x10
								if (nc < min(fb->chw_x, r->lx))
    1d6f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1d72:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
    1d76:	0f bf d0             	movsx  edx,ax
    1d79:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1d7c:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    1d7f:	39 c2                	cmp    edx,eax
    1d81:	0f 4e c2             	cmovle eax,edx
    1d84:	39 45 88             	cmp    DWORD PTR [ebp-0x78],eax
    1d87:	7d 37                	jge    1dc0 <framebuffer_redraw_region+0x304>
										bzero(dst + 2 * nc, min(fb->chw_x,
    1d89:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    1d8f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1d92:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    1d95:	29 c2                	sub    edx,eax
    1d97:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1d9a:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    1d9d:	39 c2                	cmp    edx,eax
    1d9f:	0f 4e c2             	cmovle eax,edx
											  video_mode.width - fb->pix_x) - nc);
    1da2:	2b 45 88             	sub    eax,DWORD PTR [ebp-0x78]
										bzero(dst + 2 * nc, min(fb->chw_x,
    1da5:	89 c2                	mov    edx,eax
    1da7:	8b 45 88             	mov    eax,DWORD PTR [ebp-0x78]
    1daa:	01 c0                	add    eax,eax
    1dac:	89 c1                	mov    ecx,eax
    1dae:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1db1:	01 c8                	add    eax,ecx
    1db3:	83 ec 08             	sub    esp,0x8
    1db6:	52                   	push   edx
    1db7:	50                   	push   eax
    1db8:	e8 fc ff ff ff       	call   1db9 <framebuffer_redraw_region+0x2fd>
    1dbd:	83 c4 10             	add    esp,0x10
								dst += video_mode.width * 2;
    1dc0:	a1 04 00 00 00       	mov    eax,ds:0x4
    1dc5:	01 c0                	add    eax,eax
    1dc7:	01 45 e0             	add    DWORD PTR [ebp-0x20],eax
								src += fb->width * 2;
    1dca:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1dcd:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    1dd0:	01 c0                	add    eax,eax
    1dd2:	01 45 e4             	add    DWORD PTR [ebp-0x1c],eax
						while (nl) {
    1dd5:	83 7d 8c 00          	cmp    DWORD PTR [ebp-0x74],0x0
    1dd9:	0f 85 79 ff ff ff    	jne    1d58 <framebuffer_redraw_region+0x29c>
						}
						/* show we're outside (large cho_...) */
						nc = min(min(fb->chw_x, r->lx), video_mode.width - fb->pix_x);
    1ddf:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    1de5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1de8:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    1deb:	89 d1                	mov    ecx,edx
    1ded:	29 c1                	sub    ecx,eax
    1def:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1df2:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
    1df6:	0f bf d0             	movsx  edx,ax
    1df9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1dfc:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    1dff:	39 c2                	cmp    edx,eax
    1e01:	0f 4e c2             	cmovle eax,edx
    1e04:	39 c1                	cmp    ecx,eax
    1e06:	0f 4e c1             	cmovle eax,ecx
    1e09:	89 45 88             	mov    DWORD PTR [ebp-0x78],eax
						if (nl < min(fb->chw_y, r->ly)) {
    1e0c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1e0f:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
    1e13:	0f bf d0             	movsx  edx,ax
    1e16:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1e19:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    1e1c:	39 c2                	cmp    edx,eax
    1e1e:	0f 4e c2             	cmovle eax,edx
    1e21:	39 45 8c             	cmp    DWORD PTR [ebp-0x74],eax
    1e24:	0f 8d 53 08 00 00    	jge    267d <framebuffer_redraw_region+0xbc1>
								bzero(dst, 2 * nc);
    1e2a:	8b 45 88             	mov    eax,DWORD PTR [ebp-0x78]
    1e2d:	01 c0                	add    eax,eax
    1e2f:	83 ec 08             	sub    esp,0x8
    1e32:	50                   	push   eax
    1e33:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
    1e36:	e8 fc ff ff ff       	call   1e37 <framebuffer_redraw_region+0x37b>
    1e3b:	83 c4 10             	add    esp,0x10
								dst += video_mode.width * 2;
    1e3e:	a1 04 00 00 00       	mov    eax,ds:0x4
    1e43:	01 c0                	add    eax,eax
    1e45:	01 45 e0             	add    DWORD PTR [ebp-0x20],eax
						}
				}
				return;
    1e48:	e9 30 08 00 00       	jmp    267d <framebuffer_redraw_region+0xbc1>
							   && r->lx == fb->width && !fb->pix_x) {
    1e4d:	90                   	nop
				return;
    1e4e:	e9 2a 08 00 00       	jmp    267d <framebuffer_redraw_region+0xbc1>
		} else {
				int shf = 0;
    1e53:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
				void* mem = vga_mem_ptr; char* str = fb->text_mem;
    1e5a:	a1 00 00 00 00       	mov    eax,ds:0x0
    1e5f:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    1e62:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1e65:	8b 00                	mov    eax,DWORD PTR [eax]
    1e67:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
				ssize_t px_x, px_y, o_x, o_y;

				/* calculate the pixel offsets */
				o_x = fb->pix_x + r->x * 8;
    1e6a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1e6d:	8b 50 1c             	mov    edx,DWORD PTR [eax+0x1c]
    1e70:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1e73:	0f b7 00             	movzx  eax,WORD PTR [eax]
    1e76:	98                   	cwde
    1e77:	c1 e0 03             	shl    eax,0x3
    1e7a:	01 d0                	add    eax,edx
    1e7c:	89 45 a8             	mov    DWORD PTR [ebp-0x58],eax
				o_y = fb->pix_y + r->y * 16;
    1e7f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1e82:	8b 50 20             	mov    edx,DWORD PTR [eax+0x20]
    1e85:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1e88:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    1e8c:	98                   	cwde
    1e8d:	c1 e0 04             	shl    eax,0x4
    1e90:	01 d0                	add    eax,edx
    1e92:	89 45 a4             	mov    DWORD PTR [ebp-0x5c],eax
				px_x = r->lx * 8;
    1e95:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1e98:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
    1e9c:	98                   	cwde
    1e9d:	c1 e0 03             	shl    eax,0x3
    1ea0:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
				px_y = r->ly * 16;
    1ea3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1ea6:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
    1eaa:	98                   	cwde
    1eab:	c1 e0 04             	shl    eax,0x4
    1eae:	89 45 9c             	mov    DWORD PTR [ebp-0x64],eax
				/* and ensure the bounds */
				if (o_x >= video_mode.width || o_y >= video_mode.height)
    1eb1:	a1 04 00 00 00       	mov    eax,ds:0x4
    1eb6:	39 45 a8             	cmp    DWORD PTR [ebp-0x58],eax
    1eb9:	0f 8d c1 07 00 00    	jge    2680 <framebuffer_redraw_region+0xbc4>
    1ebf:	a1 08 00 00 00       	mov    eax,ds:0x8
    1ec4:	39 45 a4             	cmp    DWORD PTR [ebp-0x5c],eax
    1ec7:	0f 8d b3 07 00 00    	jge    2680 <framebuffer_redraw_region+0xbc4>
					return;
				/* from the text buffer */
				px_x = min(px_x, 8 * min(fb->width - fb->cho_x - r->x, fb->chw_x - r->x));
    1ecd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ed0:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1ed3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ed6:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
    1ed9:	29 c2                	sub    edx,eax
    1edb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ede:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    1ee1:	39 c2                	cmp    edx,eax
    1ee3:	7d 20                	jge    1f05 <framebuffer_redraw_region+0x449>
    1ee5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1ee8:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1eeb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1eee:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
    1ef1:	29 c2                	sub    edx,eax
    1ef3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1ef6:	0f b7 00             	movzx  eax,WORD PTR [eax]
    1ef9:	98                   	cwde
    1efa:	29 c2                	sub    edx,eax
    1efc:	8d 04 d5 00 00 00 00 	lea    eax,[edx*8+0x0]
    1f03:	eb 16                	jmp    1f1b <framebuffer_redraw_region+0x45f>
    1f05:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1f08:	8b 50 2c             	mov    edx,DWORD PTR [eax+0x2c]
    1f0b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1f0e:	0f b7 00             	movzx  eax,WORD PTR [eax]
    1f11:	98                   	cwde
    1f12:	29 c2                	sub    edx,eax
    1f14:	8d 04 d5 00 00 00 00 	lea    eax,[edx*8+0x0]
    1f1b:	8b 55 a0             	mov    edx,DWORD PTR [ebp-0x60]
    1f1e:	39 c2                	cmp    edx,eax
    1f20:	0f 4e c2             	cmovle eax,edx
    1f23:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
				px_y = min(px_y, 16 * min(fb->height - fb->cho_y - r->y, fb->chw_y - r->y));
    1f26:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1f29:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    1f2c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1f2f:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    1f32:	29 c2                	sub    edx,eax
    1f34:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1f37:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    1f3a:	39 c2                	cmp    edx,eax
    1f3c:	7d 1f                	jge    1f5d <framebuffer_redraw_region+0x4a1>
    1f3e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1f41:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    1f44:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1f47:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    1f4a:	29 c2                	sub    edx,eax
    1f4c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1f4f:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    1f53:	98                   	cwde
    1f54:	29 c2                	sub    edx,eax
    1f56:	89 d0                	mov    eax,edx
    1f58:	c1 e0 04             	shl    eax,0x4
    1f5b:	eb 15                	jmp    1f72 <framebuffer_redraw_region+0x4b6>
    1f5d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1f60:	8b 50 30             	mov    edx,DWORD PTR [eax+0x30]
    1f63:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1f66:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    1f6a:	98                   	cwde
    1f6b:	29 c2                	sub    edx,eax
    1f6d:	89 d0                	mov    eax,edx
    1f6f:	c1 e0 04             	shl    eax,0x4
    1f72:	8b 55 9c             	mov    edx,DWORD PTR [ebp-0x64]
    1f75:	39 c2                	cmp    edx,eax
    1f77:	0f 4e c2             	cmovle eax,edx
    1f7a:	89 45 9c             	mov    DWORD PTR [ebp-0x64],eax
				/* and from video memory */
				px_x = min(px_x, video_mode.width - o_x);
    1f7d:	a1 04 00 00 00       	mov    eax,ds:0x4
    1f82:	2b 45 a8             	sub    eax,DWORD PTR [ebp-0x58]
    1f85:	8b 55 a0             	mov    edx,DWORD PTR [ebp-0x60]
    1f88:	39 c2                	cmp    edx,eax
    1f8a:	0f 4e c2             	cmovle eax,edx
    1f8d:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
				px_y = min(px_y, video_mode.height - o_y);
    1f90:	a1 08 00 00 00       	mov    eax,ds:0x8
    1f95:	2b 45 a4             	sub    eax,DWORD PTR [ebp-0x5c]
    1f98:	8b 55 9c             	mov    edx,DWORD PTR [ebp-0x64]
    1f9b:	39 c2                	cmp    edx,eax
    1f9d:	0f 4e c2             	cmovle eax,edx
    1fa0:	89 45 9c             	mov    DWORD PTR [ebp-0x64],eax
				if (px_x < 0 || px_y < 0)
    1fa3:	83 7d a0 00          	cmp    DWORD PTR [ebp-0x60],0x0
    1fa7:	0f 88 d6 06 00 00    	js     2683 <framebuffer_redraw_region+0xbc7>
    1fad:	83 7d 9c 00          	cmp    DWORD PTR [ebp-0x64],0x0
    1fb1:	0f 88 cc 06 00 00    	js     2683 <framebuffer_redraw_region+0xbc7>
					return;
				
				if (video_mode.gm_bts == 4)
    1fb7:	0f b6 05 01 00 00 00 	movzx  eax,BYTE PTR ds:0x1
    1fbe:	3c 04                	cmp    al,0x4
    1fc0:	75 20                	jne    1fe2 <framebuffer_redraw_region+0x526>
					shf = ((o_x % 2) == 1);
    1fc2:	8b 55 a8             	mov    edx,DWORD PTR [ebp-0x58]
    1fc5:	89 d0                	mov    eax,edx
    1fc7:	c1 f8 1f             	sar    eax,0x1f
    1fca:	c1 e8 1f             	shr    eax,0x1f
    1fcd:	01 c2                	add    edx,eax
    1fcf:	83 e2 01             	and    edx,0x1
    1fd2:	29 c2                	sub    edx,eax
    1fd4:	89 d0                	mov    eax,edx
    1fd6:	83 f8 01             	cmp    eax,0x1
    1fd9:	0f 94 c0             	sete   al
    1fdc:	0f b6 c0             	movzx  eax,al
    1fdf:	89 45 dc             	mov    DWORD PTR [ebp-0x24],eax
				
				/* set the memory references */
				mem += o_y * video_mode.bpsl + o_x * video_mode.btpp;
    1fe2:	8b 15 0c 00 00 00    	mov    edx,DWORD PTR ds:0xc
    1fe8:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
    1feb:	0f af d0             	imul   edx,eax
    1fee:	0f b6 05 02 00 00 00 	movzx  eax,BYTE PTR ds:0x2
    1ff5:	0f be c0             	movsx  eax,al
    1ff8:	0f af 45 a8          	imul   eax,DWORD PTR [ebp-0x58]
    1ffc:	01 d0                	add    eax,edx
    1ffe:	01 45 d8             	add    DWORD PTR [ebp-0x28],eax
				str += (fb->cho_y + r->y) * 2 * fb->width + (fb->cho_x + r->x) * 2;
    2001:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2004:	8b 50 28             	mov    edx,DWORD PTR [eax+0x28]
    2007:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    200a:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    200e:	98                   	cwde
    200f:	01 d0                	add    eax,edx
    2011:	8d 14 00             	lea    edx,[eax+eax*1]
    2014:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2017:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    201a:	0f af d0             	imul   edx,eax
    201d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2020:	8b 48 24             	mov    ecx,DWORD PTR [eax+0x24]
    2023:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2026:	0f b7 00             	movzx  eax,WORD PTR [eax]
    2029:	98                   	cwde
    202a:	01 c8                	add    eax,ecx
    202c:	01 c0                	add    eax,eax
    202e:	01 d0                	add    eax,edx
    2030:	01 45 d4             	add    DWORD PTR [ebp-0x2c],eax

				/* check for excluding rects */
				if (fb->r_excl) {
    2033:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2036:	8b 40 38             	mov    eax,DWORD PTR [eax+0x38]
    2039:	85 c0                	test   eax,eax
    203b:	0f 84 d0 05 00 00    	je     2611 <framebuffer_redraw_region+0xb55>
						/* use y and x stride marks */
						size_t ns_y = 0, ns_x = 0;
    2041:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [ebp-0x30],0x0
    2048:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
						struct stride /* exclude range:  y is key */
								stride_y[10], stride_x[20];
						struct exclude_rect* pe = fb->r_excl;
    204f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2052:	8b 40 38             	mov    eax,DWORD PTR [eax+0x38]
    2055:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
						while (pe) {
    2058:	e9 c3 01 00 00       	jmp    2220 <framebuffer_redraw_region+0x764>
								struct exclude_rect er = {0};
    205d:	c7 85 74 ff ff ff 00 00 00 00 	mov    DWORD PTR [ebp-0x8c],0x0
    2067:	c7 85 78 ff ff ff 00 00 00 00 	mov    DWORD PTR [ebp-0x88],0x0
    2071:	c7 85 7c ff ff ff 00 00 00 00 	mov    DWORD PTR [ebp-0x84],0x0
    207b:	c7 45 80 00 00 00 00 	mov    DWORD PTR [ebp-0x80],0x0
    2082:	c7 45 84 00 00 00 00 	mov    DWORD PTR [ebp-0x7c],0x0
								er = *pe;
    2089:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    208c:	8b 10                	mov    edx,DWORD PTR [eax]
    208e:	89 95 74 ff ff ff    	mov    DWORD PTR [ebp-0x8c],edx
    2094:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    2097:	89 95 78 ff ff ff    	mov    DWORD PTR [ebp-0x88],edx
    209d:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    20a0:	89 95 7c ff ff ff    	mov    DWORD PTR [ebp-0x84],edx
    20a6:	8b 50 0c             	mov    edx,DWORD PTR [eax+0xc]
    20a9:	89 55 80             	mov    DWORD PTR [ebp-0x80],edx
    20ac:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    20af:	89 45 84             	mov    DWORD PTR [ebp-0x7c],eax
								er.x -= fb->pix_x;
    20b2:	8b 95 74 ff ff ff    	mov    edx,DWORD PTR [ebp-0x8c]
    20b8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    20bb:	8b 40 1c             	mov    eax,DWORD PTR [eax+0x1c]
    20be:	29 c2                	sub    edx,eax
    20c0:	89 95 74 ff ff ff    	mov    DWORD PTR [ebp-0x8c],edx
								er.y -= fb->pix_y;
    20c6:	8b 95 78 ff ff ff    	mov    edx,DWORD PTR [ebp-0x88]
    20cc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    20cf:	8b 40 20             	mov    eax,DWORD PTR [eax+0x20]
    20d2:	29 c2                	sub    edx,eax
    20d4:	89 95 78 ff ff ff    	mov    DWORD PTR [ebp-0x88],edx
								if (er.x + er.lx > o_x && er.y + er.ly > o_y) {
    20da:	8b 95 74 ff ff ff    	mov    edx,DWORD PTR [ebp-0x8c]
    20e0:	8b 85 7c ff ff ff    	mov    eax,DWORD PTR [ebp-0x84]
    20e6:	01 d0                	add    eax,edx
    20e8:	39 45 a8             	cmp    DWORD PTR [ebp-0x58],eax
    20eb:	0f 8d 26 01 00 00    	jge    2217 <framebuffer_redraw_region+0x75b>
    20f1:	8b 95 78 ff ff ff    	mov    edx,DWORD PTR [ebp-0x88]
    20f7:	8b 45 80             	mov    eax,DWORD PTR [ebp-0x80]
    20fa:	01 d0                	add    eax,edx
    20fc:	39 45 a4             	cmp    DWORD PTR [ebp-0x5c],eax
    20ff:	0f 8d 12 01 00 00    	jge    2217 <framebuffer_redraw_region+0x75b>
										if (o_x + px_x > er.x && o_y + px_y > er.y) {
    2105:	8b 55 a8             	mov    edx,DWORD PTR [ebp-0x58]
    2108:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    210b:	01 c2                	add    edx,eax
    210d:	8b 85 74 ff ff ff    	mov    eax,DWORD PTR [ebp-0x8c]
    2113:	39 c2                	cmp    edx,eax
    2115:	0f 8e fc 00 00 00    	jle    2217 <framebuffer_redraw_region+0x75b>
    211b:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    211e:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    2121:	01 c2                	add    edx,eax
    2123:	8b 85 78 ff ff ff    	mov    eax,DWORD PTR [ebp-0x88]
    2129:	39 c2                	cmp    edx,eax
    212b:	0f 8e e6 00 00 00    	jle    2217 <framebuffer_redraw_region+0x75b>
												struct stride sx, sy;
												/* overlap y */
												if (ns_y == 10 || ns_x == 20) /* we could draw parts */
    2131:	83 7d d0 0a          	cmp    DWORD PTR [ebp-0x30],0xa
    2135:	74 06                	je     213d <framebuffer_redraw_region+0x681>
    2137:	83 7d cc 14          	cmp    DWORD PTR [ebp-0x34],0x14
    213b:	75 2b                	jne    2168 <framebuffer_redraw_region+0x6ac>
														die("use bigger fb stride buffers\n");
    213d:	83 ec 08             	sub    esp,0x8
    2140:	68 c3 01 00 00       	push   0x1c3
    2145:	6a 0c                	push   0xc
    2147:	e8 fc ff ff ff       	call   2148 <framebuffer_redraw_region+0x68c>
    214c:	83 c4 10             	add    esp,0x10
    214f:	e8 fc ff ff ff       	call   2150 <framebuffer_redraw_region+0x694>
    2154:	83 ec 0c             	sub    esp,0xc
    2157:	68 00 00 00 00       	push   0x0
    215c:	e8 fc ff ff ff       	call   215d <framebuffer_redraw_region+0x6a1>
    2161:	83 c4 10             	add    esp,0x10
    2164:	fa                   	cli
    2165:	f4                   	hlt
    2166:	eb fd                	jmp    2165 <framebuffer_redraw_region+0x6a9>
												/* crop the rect and insert two strides */
												sx.x1 = max(o_x, er.x);
    2168:	8b 95 74 ff ff ff    	mov    edx,DWORD PTR [ebp-0x8c]
    216e:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    2171:	39 c2                	cmp    edx,eax
    2173:	0f 4d c2             	cmovge eax,edx
    2176:	89 85 6c ff ff ff    	mov    DWORD PTR [ebp-0x94],eax
												sx.x2 = min(er.x + er.lx, o_x + px_x);
    217c:	8b 55 a8             	mov    edx,DWORD PTR [ebp-0x58]
    217f:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    2182:	01 c2                	add    edx,eax
    2184:	8b 8d 74 ff ff ff    	mov    ecx,DWORD PTR [ebp-0x8c]
    218a:	8b 85 7c ff ff ff    	mov    eax,DWORD PTR [ebp-0x84]
    2190:	01 c8                	add    eax,ecx
    2192:	39 c2                	cmp    edx,eax
    2194:	0f 4e c2             	cmovle eax,edx
    2197:	89 85 70 ff ff ff    	mov    DWORD PTR [ebp-0x90],eax
												sy.x1 = max(o_y, er.y);
    219d:	8b 95 78 ff ff ff    	mov    edx,DWORD PTR [ebp-0x88]
    21a3:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
    21a6:	39 c2                	cmp    edx,eax
    21a8:	0f 4d c2             	cmovge eax,edx
    21ab:	89 85 64 ff ff ff    	mov    DWORD PTR [ebp-0x9c],eax
												sy.x2 = min(er.y + er.ly, o_y + px_y);
    21b1:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    21b4:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    21b7:	01 c2                	add    edx,eax
    21b9:	8b 8d 78 ff ff ff    	mov    ecx,DWORD PTR [ebp-0x88]
    21bf:	8b 45 80             	mov    eax,DWORD PTR [ebp-0x80]
    21c2:	01 c8                	add    eax,ecx
    21c4:	39 c2                	cmp    edx,eax
    21c6:	0f 4e c2             	cmovle eax,edx
    21c9:	89 85 68 ff ff ff    	mov    DWORD PTR [ebp-0x98],eax
												if(add_stride(stride_y, ns_y, &sy))
    21cf:	83 ec 04             	sub    esp,0x4
    21d2:	8d 85 64 ff ff ff    	lea    eax,[ebp-0x9c]
    21d8:	50                   	push   eax
    21d9:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
    21dc:	8d 85 74 fe ff ff    	lea    eax,[ebp-0x18c]
    21e2:	50                   	push   eax
    21e3:	e8 fc ff ff ff       	call   21e4 <framebuffer_redraw_region+0x728>
    21e8:	83 c4 10             	add    esp,0x10
    21eb:	85 c0                	test   eax,eax
    21ed:	74 04                	je     21f3 <framebuffer_redraw_region+0x737>
														ns_y++;
    21ef:	83 45 d0 01          	add    DWORD PTR [ebp-0x30],0x1
												if (add_stride(stride_x, ns_x, &sx))
    21f3:	83 ec 04             	sub    esp,0x4
    21f6:	8d 85 6c ff ff ff    	lea    eax,[ebp-0x94]
    21fc:	50                   	push   eax
    21fd:	ff 75 cc             	push   DWORD PTR [ebp-0x34]
    2200:	8d 85 c4 fe ff ff    	lea    eax,[ebp-0x13c]
    2206:	50                   	push   eax
    2207:	e8 fc ff ff ff       	call   2208 <framebuffer_redraw_region+0x74c>
    220c:	83 c4 10             	add    esp,0x10
    220f:	85 c0                	test   eax,eax
    2211:	74 04                	je     2217 <framebuffer_redraw_region+0x75b>
														ns_x++;
    2213:	83 45 cc 01          	add    DWORD PTR [ebp-0x34],0x1
										}
								}
								pe = pe->next;
    2217:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    221a:	8b 40 10             	mov    eax,DWORD PTR [eax+0x10]
    221d:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
						while (pe) {
    2220:	83 7d c8 00          	cmp    DWORD PTR [ebp-0x38],0x0
    2224:	0f 85 33 fe ff ff    	jne    205d <framebuffer_redraw_region+0x5a1>
						}
						/* add the dummy entries (so we don't have to check at +x) */
						stride_y[ns_y].x1 = o_y + px_y;
    222a:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    222d:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    2230:	01 c2                	add    edx,eax
    2232:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    2235:	89 94 c5 74 fe ff ff 	mov    DWORD PTR [ebp+eax*8-0x18c],edx
						stride_y[ns_y++].x2 = o_y + px_y;
    223c:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    223f:	8d 50 01             	lea    edx,[eax+0x1]
    2242:	89 55 d0             	mov    DWORD PTR [ebp-0x30],edx
    2245:	8b 4d a4             	mov    ecx,DWORD PTR [ebp-0x5c]
    2248:	8b 55 9c             	mov    edx,DWORD PTR [ebp-0x64]
    224b:	01 ca                	add    edx,ecx
    224d:	89 94 c5 78 fe ff ff 	mov    DWORD PTR [ebp+eax*8-0x188],edx
						stride_x[ns_x].x1 = o_x + px_x;
    2254:	8b 55 a8             	mov    edx,DWORD PTR [ebp-0x58]
    2257:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    225a:	01 c2                	add    edx,eax
    225c:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    225f:	89 94 c5 c4 fe ff ff 	mov    DWORD PTR [ebp+eax*8-0x13c],edx
						stride_x[ns_x++].x2 = o_x + px_x;
    2266:	8b 45 cc             	mov    eax,DWORD PTR [ebp-0x34]
    2269:	8d 50 01             	lea    edx,[eax+0x1]
    226c:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
    226f:	8b 4d a8             	mov    ecx,DWORD PTR [ebp-0x58]
    2272:	8b 55 a0             	mov    edx,DWORD PTR [ebp-0x60]
    2275:	01 ca                	add    edx,ecx
    2277:	89 94 c5 c8 fe ff ff 	mov    DWORD PTR [ebp+eax*8-0x138],edx
						if (ns_y > 1 && ns_x > 1) {
    227e:	83 7d d0 01          	cmp    DWORD PTR [ebp-0x30],0x1
    2282:	0f 86 89 03 00 00    	jbe    2611 <framebuffer_redraw_region+0xb55>
    2288:	83 7d cc 01          	cmp    DWORD PTR [ebp-0x34],0x1
    228c:	0f 86 7f 03 00 00    	jbe    2611 <framebuffer_redraw_region+0xb55>
								ssize_t lpx_x, lpx_y, lo_x = o_x, lo_y = o_y;
    2292:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    2295:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
    2298:	8b 45 a4             	mov    eax,DWORD PTR [ebp-0x5c]
    229b:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
								char* str2 = str; int shf2 = shf; void* mem2;
    229e:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    22a1:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
    22a4:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    22a7:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
								/* now we have a field of strides */
								for (size_t i = 0; i < ns_y; i++) {
    22aa:	c7 45 b0 00 00 00 00 	mov    DWORD PTR [ebp-0x50],0x0
    22b1:	e9 4d 03 00 00       	jmp    2603 <framebuffer_redraw_region+0xb47>
										/* draw full lines before the stride */
										if (stride_y[i].x1 > lo_y) {
    22b6:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    22b9:	8b 84 c5 74 fe ff ff 	mov    eax,DWORD PTR [ebp+eax*8-0x18c]
    22c0:	39 45 c0             	cmp    DWORD PTR [ebp-0x40],eax
    22c3:	0f 8d d7 00 00 00    	jge    23a0 <framebuffer_redraw_region+0x8e4>
												lpx_x = px_x;
    22c9:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    22cc:	89 45 98             	mov    DWORD PTR [ebp-0x68],eax
												lo_x = o_x;
    22cf:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    22d2:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
												shf2 = shf;
    22d5:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    22d8:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
												lpx_y = min(stride_y[i].x1 - lo_y, o_y + px_y - lo_y);
    22db:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    22de:	8b 94 c5 74 fe ff ff 	mov    edx,DWORD PTR [ebp+eax*8-0x18c]
    22e5:	8b 4d a4             	mov    ecx,DWORD PTR [ebp-0x5c]
    22e8:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    22eb:	01 c8                	add    eax,ecx
    22ed:	39 c2                	cmp    edx,eax
    22ef:	7d 0f                	jge    2300 <framebuffer_redraw_region+0x844>
    22f1:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    22f4:	8b 84 c5 74 fe ff ff 	mov    eax,DWORD PTR [ebp+eax*8-0x18c]
    22fb:	2b 45 c0             	sub    eax,DWORD PTR [ebp-0x40]
    22fe:	eb 0b                	jmp    230b <framebuffer_redraw_region+0x84f>
    2300:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
    2303:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    2306:	01 d0                	add    eax,edx
    2308:	2b 45 c0             	sub    eax,DWORD PTR [ebp-0x40]
    230b:	89 45 94             	mov    DWORD PTR [ebp-0x6c],eax
												if (lpx_y) /* skip empty dummy */
    230e:	83 7d 94 00          	cmp    DWORD PTR [ebp-0x6c],0x0
    2312:	0f 84 88 00 00 00    	je     23a0 <framebuffer_redraw_region+0x8e4>
													render_text(fb->font, str2, mem, 2 * fb->width,
														video_mode.bpsl, video_mode.gm_bts, lpx_x,
														lpx_y, shf2, fb->cur_x - r->x, fb->cur_y - r->y,
														0, (lo_y - o_y) % 16);
    2318:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    231b:	2b 45 a4             	sub    eax,DWORD PTR [ebp-0x5c]
    231e:	89 c2                	mov    edx,eax
													render_text(fb->font, str2, mem, 2 * fb->width,
    2320:	89 d0                	mov    eax,edx
    2322:	c1 f8 1f             	sar    eax,0x1f
    2325:	c1 e8 1c             	shr    eax,0x1c
    2328:	01 c2                	add    edx,eax
    232a:	83 e2 0f             	and    edx,0xf
    232d:	29 c2                	sub    edx,eax
    232f:	89 95 64 fe ff ff    	mov    DWORD PTR [ebp-0x19c],edx
														lpx_y, shf2, fb->cur_x - r->x, fb->cur_y - r->y,
    2335:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2338:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    233b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    233e:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    2342:	98                   	cwde
													render_text(fb->font, str2, mem, 2 * fb->width,
    2343:	89 d6                	mov    esi,edx
    2345:	29 c6                	sub    esi,eax
														lpx_y, shf2, fb->cur_x - r->x, fb->cur_y - r->y,
    2347:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    234a:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
    234d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2350:	0f b7 00             	movzx  eax,WORD PTR [eax]
    2353:	98                   	cwde
													render_text(fb->font, str2, mem, 2 * fb->width,
    2354:	89 d3                	mov    ebx,edx
    2356:	29 c3                	sub    ebx,eax
														video_mode.bpsl, video_mode.gm_bts, lpx_x,
    2358:	0f b6 05 01 00 00 00 	movzx  eax,BYTE PTR ds:0x1
													render_text(fb->font, str2, mem, 2 * fb->width,
    235f:	0f be c8             	movsx  ecx,al
														video_mode.bpsl, video_mode.gm_bts, lpx_x,
    2362:	8b 15 0c 00 00 00    	mov    edx,DWORD PTR ds:0xc
													render_text(fb->font, str2, mem, 2 * fb->width,
    2368:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    236b:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    236e:	01 c0                	add    eax,eax
    2370:	89 c7                	mov    edi,eax
    2372:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2375:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    2378:	83 ec 0c             	sub    esp,0xc
    237b:	ff b5 64 fe ff ff    	push   DWORD PTR [ebp-0x19c]
    2381:	6a 00                	push   0x0
    2383:	56                   	push   esi
    2384:	53                   	push   ebx
    2385:	ff 75 b8             	push   DWORD PTR [ebp-0x48]
    2388:	ff 75 94             	push   DWORD PTR [ebp-0x6c]
    238b:	ff 75 98             	push   DWORD PTR [ebp-0x68]
    238e:	51                   	push   ecx
    238f:	52                   	push   edx
    2390:	57                   	push   edi
    2391:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
    2394:	ff 75 bc             	push   DWORD PTR [ebp-0x44]
    2397:	50                   	push   eax
    2398:	e8 fc ff ff ff       	call   2399 <framebuffer_redraw_region+0x8dd>
    239d:	83 c4 40             	add    esp,0x40
										}
										/* we are inside the stride */
										/* update the references */
										mem += (stride_y[i].x1 - lo_y) * video_mode.bpsl;
    23a0:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    23a3:	8b 84 c5 74 fe ff ff 	mov    eax,DWORD PTR [ebp+eax*8-0x18c]
    23aa:	2b 45 c0             	sub    eax,DWORD PTR [ebp-0x40]
    23ad:	89 c2                	mov    edx,eax
    23af:	a1 0c 00 00 00       	mov    eax,ds:0xc
    23b4:	0f af c2             	imul   eax,edx
    23b7:	01 45 d8             	add    DWORD PTR [ebp-0x28],eax
										str += ((stride_y[i].x1 - lo_y) / 16) * 2 * fb->width;
    23ba:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    23bd:	8b 84 c5 74 fe ff ff 	mov    eax,DWORD PTR [ebp+eax*8-0x18c]
    23c4:	2b 45 c0             	sub    eax,DWORD PTR [ebp-0x40]
    23c7:	8d 50 0f             	lea    edx,[eax+0xf]
    23ca:	85 c0                	test   eax,eax
    23cc:	0f 48 c2             	cmovs  eax,edx
    23cf:	c1 f8 04             	sar    eax,0x4
    23d2:	8d 14 00             	lea    edx,[eax+eax*1]
    23d5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    23d8:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    23db:	0f af c2             	imul   eax,edx
    23de:	01 45 d4             	add    DWORD PTR [ebp-0x2c],eax
										str2 = str;
    23e1:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    23e4:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
										lo_y = stride_y[i].x1;
    23e7:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    23ea:	8b 84 c5 74 fe ff ff 	mov    eax,DWORD PTR [ebp+eax*8-0x18c]
    23f1:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
										lpx_y = min(o_y + px_y, stride_y[i].x2) - stride_y[i].x1;
    23f4:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    23f7:	8b 94 c5 78 fe ff ff 	mov    edx,DWORD PTR [ebp+eax*8-0x188]
    23fe:	8b 4d a4             	mov    ecx,DWORD PTR [ebp-0x5c]
    2401:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    2404:	01 c8                	add    eax,ecx
    2406:	39 c2                	cmp    edx,eax
    2408:	0f 4f d0             	cmovg  edx,eax
    240b:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    240e:	8b 84 c5 74 fe ff ff 	mov    eax,DWORD PTR [ebp+eax*8-0x18c]
    2415:	29 c2                	sub    edx,eax
    2417:	89 55 94             	mov    DWORD PTR [ebp-0x6c],edx
										if (!lpx_y) /* break after zero stride */
    241a:	83 7d 94 00          	cmp    DWORD PTR [ebp-0x6c],0x0
    241e:	0f 84 62 02 00 00    	je     2686 <framebuffer_redraw_region+0xbca>
												break;
										lo_x = o_x;
    2424:	8b 45 a8             	mov    eax,DWORD PTR [ebp-0x58]
    2427:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
										shf2 = shf;
    242a:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    242d:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
										mem2 = mem;
    2430:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2433:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
										/* now draw the x strides */
										for (size_t j = 0; j < ns_x; j++) {
    2436:	c7 45 ac 00 00 00 00 	mov    DWORD PTR [ebp-0x54],0x0
    243d:	e9 67 01 00 00       	jmp    25a9 <framebuffer_redraw_region+0xaed>
												/* draw to x before */
												if (stride_x[j].x1 > lo_x) {
    2442:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2445:	8b 84 c5 c4 fe ff ff 	mov    eax,DWORD PTR [ebp+eax*8-0x13c]
    244c:	39 45 c4             	cmp    DWORD PTR [ebp-0x3c],eax
    244f:	0f 8d dc 00 00 00    	jge    2531 <framebuffer_redraw_region+0xa75>
														lpx_x = min(o_x + px_x - lo_x, stride_x[j].x1 - lo_x);
    2455:	8b 55 a8             	mov    edx,DWORD PTR [ebp-0x58]
    2458:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    245b:	01 c2                	add    edx,eax
    245d:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2460:	8b 84 c5 c4 fe ff ff 	mov    eax,DWORD PTR [ebp+eax*8-0x13c]
    2467:	39 c2                	cmp    edx,eax
    2469:	7d 0d                	jge    2478 <framebuffer_redraw_region+0x9bc>
    246b:	8b 55 a8             	mov    edx,DWORD PTR [ebp-0x58]
    246e:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
    2471:	01 d0                	add    eax,edx
    2473:	2b 45 c4             	sub    eax,DWORD PTR [ebp-0x3c]
    2476:	eb 0d                	jmp    2485 <framebuffer_redraw_region+0x9c9>
    2478:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    247b:	8b 84 c5 c4 fe ff ff 	mov    eax,DWORD PTR [ebp+eax*8-0x13c]
    2482:	2b 45 c4             	sub    eax,DWORD PTR [ebp-0x3c]
    2485:	89 45 98             	mov    DWORD PTR [ebp-0x68],eax
														render_text(fb->font, str2, mem2, 2 * fb->width,
																video_mode.bpsl, video_mode.gm_bts, lpx_x,
																lpx_y, shf2, fb->cur_x - r->x, fb->cur_y - r->y,
																(lo_x - o_x) % 8, (lo_y - o_y) % 16);
    2488:	8b 45 c0             	mov    eax,DWORD PTR [ebp-0x40]
    248b:	2b 45 a4             	sub    eax,DWORD PTR [ebp-0x5c]
    248e:	89 c2                	mov    edx,eax
														render_text(fb->font, str2, mem2, 2 * fb->width,
    2490:	89 d0                	mov    eax,edx
    2492:	c1 f8 1f             	sar    eax,0x1f
    2495:	c1 e8 1c             	shr    eax,0x1c
    2498:	01 c2                	add    edx,eax
    249a:	83 e2 0f             	and    edx,0xf
    249d:	29 c2                	sub    edx,eax
    249f:	89 95 64 fe ff ff    	mov    DWORD PTR [ebp-0x19c],edx
																(lo_x - o_x) % 8, (lo_y - o_y) % 16);
    24a5:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    24a8:	2b 45 a8             	sub    eax,DWORD PTR [ebp-0x58]
    24ab:	89 c2                	mov    edx,eax
														render_text(fb->font, str2, mem2, 2 * fb->width,
    24ad:	89 d0                	mov    eax,edx
    24af:	c1 f8 1f             	sar    eax,0x1f
    24b2:	c1 e8 1d             	shr    eax,0x1d
    24b5:	01 c2                	add    edx,eax
    24b7:	83 e2 07             	and    edx,0x7
    24ba:	29 c2                	sub    edx,eax
    24bc:	89 95 60 fe ff ff    	mov    DWORD PTR [ebp-0x1a0],edx
																lpx_y, shf2, fb->cur_x - r->x, fb->cur_y - r->y,
    24c2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    24c5:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    24c8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    24cb:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    24cf:	98                   	cwde
														render_text(fb->font, str2, mem2, 2 * fb->width,
    24d0:	89 d7                	mov    edi,edx
    24d2:	29 c7                	sub    edi,eax
																lpx_y, shf2, fb->cur_x - r->x, fb->cur_y - r->y,
    24d4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    24d7:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
    24da:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    24dd:	0f b7 00             	movzx  eax,WORD PTR [eax]
    24e0:	98                   	cwde
														render_text(fb->font, str2, mem2, 2 * fb->width,
    24e1:	89 d6                	mov    esi,edx
    24e3:	29 c6                	sub    esi,eax
																video_mode.bpsl, video_mode.gm_bts, lpx_x,
    24e5:	0f b6 05 01 00 00 00 	movzx  eax,BYTE PTR ds:0x1
														render_text(fb->font, str2, mem2, 2 * fb->width,
    24ec:	0f be c8             	movsx  ecx,al
																video_mode.bpsl, video_mode.gm_bts, lpx_x,
    24ef:	8b 15 0c 00 00 00    	mov    edx,DWORD PTR ds:0xc
														render_text(fb->font, str2, mem2, 2 * fb->width,
    24f5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    24f8:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    24fb:	01 c0                	add    eax,eax
    24fd:	89 c3                	mov    ebx,eax
    24ff:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2502:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    2505:	83 ec 0c             	sub    esp,0xc
    2508:	ff b5 64 fe ff ff    	push   DWORD PTR [ebp-0x19c]
    250e:	ff b5 60 fe ff ff    	push   DWORD PTR [ebp-0x1a0]
    2514:	57                   	push   edi
    2515:	56                   	push   esi
    2516:	ff 75 b8             	push   DWORD PTR [ebp-0x48]
    2519:	ff 75 94             	push   DWORD PTR [ebp-0x6c]
    251c:	ff 75 98             	push   DWORD PTR [ebp-0x68]
    251f:	51                   	push   ecx
    2520:	52                   	push   edx
    2521:	53                   	push   ebx
    2522:	ff 75 b4             	push   DWORD PTR [ebp-0x4c]
    2525:	ff 75 bc             	push   DWORD PTR [ebp-0x44]
    2528:	50                   	push   eax
    2529:	e8 fc ff ff ff       	call   252a <framebuffer_redraw_region+0xa6e>
    252e:	83 c4 40             	add    esp,0x40
												}
												/* draw nothing as x,y are inside */
												lo_x = stride_x[j].x2;
    2531:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    2534:	8b 84 c5 c8 fe ff ff 	mov    eax,DWORD PTR [ebp+eax*8-0x138]
    253b:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
												str2 = str + ((lo_x - o_x) / 8) * 2;
    253e:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    2541:	2b 45 a8             	sub    eax,DWORD PTR [ebp-0x58]
    2544:	8d 50 07             	lea    edx,[eax+0x7]
    2547:	85 c0                	test   eax,eax
    2549:	0f 48 c2             	cmovs  eax,edx
    254c:	c1 f8 03             	sar    eax,0x3
    254f:	01 c0                	add    eax,eax
    2551:	89 c2                	mov    edx,eax
    2553:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    2556:	01 d0                	add    eax,edx
    2558:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
												mem2 = mem + (lo_x - o_x) * video_mode.btpp;
    255b:	8b 45 c4             	mov    eax,DWORD PTR [ebp-0x3c]
    255e:	2b 45 a8             	sub    eax,DWORD PTR [ebp-0x58]
    2561:	89 c2                	mov    edx,eax
    2563:	0f b6 05 02 00 00 00 	movzx  eax,BYTE PTR ds:0x2
    256a:	0f be c0             	movsx  eax,al
    256d:	0f af c2             	imul   eax,edx
    2570:	89 c2                	mov    edx,eax
    2572:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    2575:	01 d0                	add    eax,edx
    2577:	89 45 b4             	mov    DWORD PTR [ebp-0x4c],eax
												if (video_mode.gm_bts == 4)
    257a:	0f b6 05 01 00 00 00 	movzx  eax,BYTE PTR ds:0x1
    2581:	3c 04                	cmp    al,0x4
    2583:	75 20                	jne    25a5 <framebuffer_redraw_region+0xae9>
														shf2 = ((lo_x % 2) == 1);
    2585:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
    2588:	89 d0                	mov    eax,edx
    258a:	c1 f8 1f             	sar    eax,0x1f
    258d:	c1 e8 1f             	shr    eax,0x1f
    2590:	01 c2                	add    edx,eax
    2592:	83 e2 01             	and    edx,0x1
    2595:	29 c2                	sub    edx,eax
    2597:	89 d0                	mov    eax,edx
    2599:	83 f8 01             	cmp    eax,0x1
    259c:	0f 94 c0             	sete   al
    259f:	0f b6 c0             	movzx  eax,al
    25a2:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
										for (size_t j = 0; j < ns_x; j++) {
    25a5:	83 45 ac 01          	add    DWORD PTR [ebp-0x54],0x1
    25a9:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    25ac:	3b 45 cc             	cmp    eax,DWORD PTR [ebp-0x34]
    25af:	0f 82 8d fe ff ff    	jb     2442 <framebuffer_redraw_region+0x986>
										}
										/* and set the memory */
										mem += lpx_y * video_mode.bpsl;
    25b5:	8b 15 0c 00 00 00    	mov    edx,DWORD PTR ds:0xc
    25bb:	8b 45 94             	mov    eax,DWORD PTR [ebp-0x6c]
    25be:	0f af c2             	imul   eax,edx
    25c1:	01 45 d8             	add    DWORD PTR [ebp-0x28],eax
										str2 = str + ((stride_y[i].x2 - lo_y) / 16) * 2 * fb->width;
    25c4:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    25c7:	8b 84 c5 78 fe ff ff 	mov    eax,DWORD PTR [ebp+eax*8-0x188]
    25ce:	2b 45 c0             	sub    eax,DWORD PTR [ebp-0x40]
    25d1:	8d 50 0f             	lea    edx,[eax+0xf]
    25d4:	85 c0                	test   eax,eax
    25d6:	0f 48 c2             	cmovs  eax,edx
    25d9:	c1 f8 04             	sar    eax,0x4
    25dc:	8d 14 00             	lea    edx,[eax+eax*1]
    25df:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    25e2:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    25e5:	0f af c2             	imul   eax,edx
    25e8:	89 c2                	mov    edx,eax
    25ea:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    25ed:	01 d0                	add    eax,edx
    25ef:	89 45 bc             	mov    DWORD PTR [ebp-0x44],eax
										lo_y = stride_y[i].x2;
    25f2:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    25f5:	8b 84 c5 78 fe ff ff 	mov    eax,DWORD PTR [ebp+eax*8-0x188]
    25fc:	89 45 c0             	mov    DWORD PTR [ebp-0x40],eax
								for (size_t i = 0; i < ns_y; i++) {
    25ff:	83 45 b0 01          	add    DWORD PTR [ebp-0x50],0x1
    2603:	8b 45 b0             	mov    eax,DWORD PTR [ebp-0x50]
    2606:	3b 45 d0             	cmp    eax,DWORD PTR [ebp-0x30]
    2609:	0f 82 a7 fc ff ff    	jb     22b6 <framebuffer_redraw_region+0x7fa>
								}
								return;
    260f:	eb 76                	jmp    2687 <framebuffer_redraw_region+0xbcb>
				}

				/* and draw the text */
				render_text(fb->font, str, mem, 2 * fb->width, video_mode.bpsl,
						video_mode.gm_bts, px_x, px_y, shf, fb->cur_x - r->x,
						fb->cur_y - r->y, 0, 0);
    2611:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2614:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    2617:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    261a:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    261e:	98                   	cwde
				render_text(fb->font, str, mem, 2 * fb->width, video_mode.bpsl,
    261f:	89 d6                	mov    esi,edx
    2621:	29 c6                	sub    esi,eax
						video_mode.gm_bts, px_x, px_y, shf, fb->cur_x - r->x,
    2623:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2626:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
    2629:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    262c:	0f b7 00             	movzx  eax,WORD PTR [eax]
    262f:	98                   	cwde
				render_text(fb->font, str, mem, 2 * fb->width, video_mode.bpsl,
    2630:	89 d3                	mov    ebx,edx
    2632:	29 c3                	sub    ebx,eax
						video_mode.gm_bts, px_x, px_y, shf, fb->cur_x - r->x,
    2634:	0f b6 05 01 00 00 00 	movzx  eax,BYTE PTR ds:0x1
				render_text(fb->font, str, mem, 2 * fb->width, video_mode.bpsl,
    263b:	0f be c8             	movsx  ecx,al
    263e:	8b 15 0c 00 00 00    	mov    edx,DWORD PTR ds:0xc
    2644:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2647:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    264a:	01 c0                	add    eax,eax
    264c:	89 c7                	mov    edi,eax
    264e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2651:	8b 40 0c             	mov    eax,DWORD PTR [eax+0xc]
    2654:	83 ec 0c             	sub    esp,0xc
    2657:	6a 00                	push   0x0
    2659:	6a 00                	push   0x0
    265b:	56                   	push   esi
    265c:	53                   	push   ebx
    265d:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
    2660:	ff 75 9c             	push   DWORD PTR [ebp-0x64]
    2663:	ff 75 a0             	push   DWORD PTR [ebp-0x60]
    2666:	51                   	push   ecx
    2667:	52                   	push   edx
    2668:	57                   	push   edi
    2669:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
    266c:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    266f:	50                   	push   eax
    2670:	e8 fc ff ff ff       	call   2671 <framebuffer_redraw_region+0xbb5>
    2675:	83 c4 40             	add    esp,0x40
    2678:	eb 0d                	jmp    2687 <framebuffer_redraw_region+0xbcb>
				return; /* don't do anything if we're directly on video memory */
    267a:	90                   	nop
    267b:	eb 0a                	jmp    2687 <framebuffer_redraw_region+0xbcb>
				return;
    267d:	90                   	nop
    267e:	eb 07                	jmp    2687 <framebuffer_redraw_region+0xbcb>
					return;
    2680:	90                   	nop
    2681:	eb 04                	jmp    2687 <framebuffer_redraw_region+0xbcb>
					return;
    2683:	90                   	nop
    2684:	eb 01                	jmp    2687 <framebuffer_redraw_region+0xbcb>
												break;
    2686:	90                   	nop
		}
}
    2687:	8d 65 f4             	lea    esp,[ebp-0xc]
    268a:	5b                   	pop    ebx
    268b:	5e                   	pop    esi
    268c:	5f                   	pop    edi
    268d:	5d                   	pop    ebp
    268e:	c3                   	ret

0000268f <framebuffer_redraw_updates>:

void framebuffer_redraw_updates(struct framebuffer* fb)
{
    268f:	55                   	push   ebp
    2690:	89 e5                	mov    ebp,esp
    2692:	53                   	push   ebx
    2693:	83 ec 24             	sub    esp,0x24
		uint64_t tm;
		struct rct *rc, **prc;
Pos1:
		rc = fb->r_ud; prc = &fb->r_ud;
    2696:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2699:	8b 40 34             	mov    eax,DWORD PTR [eax+0x34]
    269c:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    269f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    26a2:	83 c0 34             	add    eax,0x34
    26a5:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		if (!rc)
    26a8:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    26ac:	0f 84 19 01 00 00    	je     27cb <framebuffer_redraw_updates+0x13c>
				return;
		if (cpu.has_tsc)
    26b2:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    26b9:	83 e0 10             	and    eax,0x10
    26bc:	84 c0                	test   al,al
    26be:	74 08                	je     26c8 <framebuffer_redraw_updates+0x39>
				asm volatile ("rdtsc" : "=A" (tm));
    26c0:	0f 31                	rdtsc
    26c2:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    26c5:	89 55 f4             	mov    DWORD PTR [ebp-0xc],edx
		do {
				if (rc->r_ct) {
    26c8:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    26cb:	8b 80 84 02 00 00    	mov    eax,DWORD PTR [eax+0x284]
    26d1:	85 c0                	test   eax,eax
    26d3:	0f 84 98 00 00 00    	je     2771 <framebuffer_redraw_updates+0xe2>
						/* take element temorary out of list */
						if (__sync_bool_compare_and_swap(prc, rc, rc->next)) {
    26d9:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    26dc:	8b 80 80 02 00 00    	mov    eax,DWORD PTR [eax+0x280]
    26e2:	89 c1                	mov    ecx,eax
    26e4:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    26e7:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    26ea:	f0 0f b1 0a          	lock cmpxchg DWORD PTR [edx],ecx
    26ee:	0f 94 c0             	sete   al
    26f1:	84 c0                	test   al,al
    26f3:	74 a1                	je     2696 <framebuffer_redraw_updates+0x7>
								/* success */
								for (size_t i = 0; i < rc->r_ct; i++)
    26f5:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
    26fc:	eb 25                	jmp    2723 <framebuffer_redraw_updates+0x94>
										framebuffer_redraw_region(fb, rc->r + i);
    26fe:	8b 4d ec             	mov    ecx,DWORD PTR [ebp-0x14]
    2701:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    2704:	89 d0                	mov    eax,edx
    2706:	c1 e0 02             	shl    eax,0x2
    2709:	01 d0                	add    eax,edx
    270b:	c1 e0 02             	shl    eax,0x2
    270e:	01 c8                	add    eax,ecx
    2710:	83 ec 08             	sub    esp,0x8
    2713:	50                   	push   eax
    2714:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    2717:	e8 fc ff ff ff       	call   2718 <framebuffer_redraw_updates+0x89>
    271c:	83 c4 10             	add    esp,0x10
								for (size_t i = 0; i < rc->r_ct; i++)
    271f:	83 45 e4 01          	add    DWORD PTR [ebp-0x1c],0x1
    2723:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2726:	8b 80 84 02 00 00    	mov    eax,DWORD PTR [eax+0x284]
    272c:	39 45 e4             	cmp    DWORD PTR [ebp-0x1c],eax
    272f:	72 cd                	jb     26fe <framebuffer_redraw_updates+0x6f>
								rc->r_ct = 0;
    2731:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2734:	c7 80 84 02 00 00 00 00 00 00 	mov    DWORD PTR [eax+0x284],0x0
								/* now put the buffer back at the front */
								do {
										rc->next = fb->r_ud;
    273e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2741:	8b 50 34             	mov    edx,DWORD PTR [eax+0x34]
    2744:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2747:	89 90 80 02 00 00    	mov    DWORD PTR [eax+0x280],edx
								} while (!__sync_bool_compare_and_swap(&fb->r_ud, rc->next, rc));
    274d:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    2750:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2753:	8b 80 80 02 00 00    	mov    eax,DWORD PTR [eax+0x280]
    2759:	89 c3                	mov    ebx,eax
    275b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    275e:	8d 48 34             	lea    ecx,[eax+0x34]
    2761:	89 d8                	mov    eax,ebx
    2763:	f0 0f b1 11          	lock cmpxchg DWORD PTR [ecx],edx
    2767:	0f 94 c0             	sete   al
    276a:	83 f0 01             	xor    eax,0x1
    276d:	84 c0                	test   al,al
    276f:	75 cd                	jne    273e <framebuffer_redraw_updates+0xaf>
						} else
								goto Pos1;
				}
				prc = &rc->next;
    2771:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2774:	05 80 02 00 00       	add    eax,0x280
    2779:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
		} while ((rc = rc->next));
    277c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    277f:	8b 80 80 02 00 00    	mov    eax,DWORD PTR [eax+0x280]
    2785:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    2788:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    278c:	0f 85 36 ff ff ff    	jne    26c8 <framebuffer_redraw_updates+0x39>
		if (cpu.has_tsc) {
    2792:	0f b6 05 58 00 00 00 	movzx  eax,BYTE PTR ds:0x58
    2799:	83 e0 10             	and    eax,0x10
    279c:	84 c0                	test   al,al
    279e:	74 2c                	je     27cc <framebuffer_redraw_updates+0x13d>
				asm volatile ("rdtsc" : "=A" (fb_rdt));
    27a0:	0f 31                	rdtsc
    27a2:	a3 00 00 00 00       	mov    ds:0x0,eax
    27a7:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
				fb_rdt -= tm;
    27ad:	a1 00 00 00 00       	mov    eax,ds:0x0
    27b2:	8b 15 04 00 00 00    	mov    edx,DWORD PTR ds:0x4
    27b8:	2b 45 f0             	sub    eax,DWORD PTR [ebp-0x10]
    27bb:	1b 55 f4             	sbb    edx,DWORD PTR [ebp-0xc]
    27be:	a3 00 00 00 00       	mov    ds:0x0,eax
    27c3:	89 15 04 00 00 00    	mov    DWORD PTR ds:0x4,edx
    27c9:	eb 01                	jmp    27cc <framebuffer_redraw_updates+0x13d>
				return;
    27cb:	90                   	nop
		}
}
    27cc:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    27cf:	c9                   	leave
    27d0:	c3                   	ret

000027d1 <framebuffer_update_region>:

void framebuffer_update_region(struct framebuffer* fb, struct kio_region* r)
{
    27d1:	55                   	push   ebp
    27d2:	89 e5                	mov    ebp,esp
    27d4:	53                   	push   ebx
    27d5:	83 ec 34             	sub    esp,0x34
		struct kio_region r2;
		struct rct* ptr = fb->r_ud;
    27d8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    27db:	8b 40 34             	mov    eax,DWORD PTR [eax+0x34]
    27de:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		size_t idx;
		if (fb->text_mem == vga_mem_ptr)
    27e1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    27e4:	8b 10                	mov    edx,DWORD PTR [eax]
    27e6:	a1 00 00 00 00       	mov    eax,ds:0x0
    27eb:	39 c2                	cmp    edx,eax
    27ed:	0f 84 49 04 00 00    	je     2c3c <framebuffer_update_region+0x46b>
				return;

		/* for now update on every call */
		r2.x = max(0, r->x - fb->cho_x);
    27f3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    27f6:	0f b7 00             	movzx  eax,WORD PTR [eax]
    27f9:	0f bf c8             	movsx  ecx,ax
    27fc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    27ff:	8b 50 24             	mov    edx,DWORD PTR [eax+0x24]
    2802:	89 c8                	mov    eax,ecx
    2804:	29 d0                	sub    eax,edx
    2806:	ba 00 00 00 00       	mov    edx,0x0
    280b:	85 c0                	test   eax,eax
    280d:	0f 48 c2             	cmovs  eax,edx
    2810:	66 89 45 cc          	mov    WORD PTR [ebp-0x34],ax
		r2.y = max(0, r->y - fb->cho_y);
    2814:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2817:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    281b:	0f bf c8             	movsx  ecx,ax
    281e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2821:	8b 50 28             	mov    edx,DWORD PTR [eax+0x28]
    2824:	89 c8                	mov    eax,ecx
    2826:	29 d0                	sub    eax,edx
    2828:	ba 00 00 00 00       	mov    edx,0x0
    282d:	85 c0                	test   eax,eax
    282f:	0f 48 c2             	cmovs  eax,edx
    2832:	66 89 45 ce          	mov    WORD PTR [ebp-0x32],ax
		r2.fmt = r->fmt;
    2836:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2839:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    283d:	88 45 d8             	mov    BYTE PTR [ebp-0x28],al
		r2.lx = min(fb->chw_x - r2.x, r->lx);
    2840:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2843:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
    2847:	0f bf d0             	movsx  edx,ax
    284a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    284d:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    2850:	0f b7 4d cc          	movzx  ecx,WORD PTR [ebp-0x34]
    2854:	0f bf c9             	movsx  ecx,cx
    2857:	29 c8                	sub    eax,ecx
    2859:	39 c2                	cmp    edx,eax
    285b:	0f 4e c2             	cmovle eax,edx
    285e:	66 89 45 d0          	mov    WORD PTR [ebp-0x30],ax
		r2.ly = min(fb->chw_y - r2.y, r->ly);
    2862:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2865:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
    2869:	0f bf d0             	movsx  edx,ax
    286c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    286f:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    2872:	0f b7 4d ce          	movzx  ecx,WORD PTR [ebp-0x32]
    2876:	0f bf c9             	movsx  ecx,cx
    2879:	29 c8                	sub    eax,ecx
    287b:	39 c2                	cmp    edx,eax
    287d:	0f 4e c2             	cmovle eax,edx
    2880:	66 89 45 d2          	mov    WORD PTR [ebp-0x2e],ax
		/* check for visibility */
		if (r2.x >= fb->chw_x || r2.y >= fb->chw_y ||
    2884:	0f b7 45 cc          	movzx  eax,WORD PTR [ebp-0x34]
    2888:	0f bf d0             	movsx  edx,ax
    288b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    288e:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    2891:	39 c2                	cmp    edx,eax
    2893:	0f 8d a6 03 00 00    	jge    2c3f <framebuffer_update_region+0x46e>
    2899:	0f b7 45 ce          	movzx  eax,WORD PTR [ebp-0x32]
    289d:	0f bf d0             	movsx  edx,ax
    28a0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    28a3:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    28a6:	39 c2                	cmp    edx,eax
    28a8:	0f 8d 91 03 00 00    	jge    2c3f <framebuffer_update_region+0x46e>
			r2.x + r2.lx < fb->cho_x || r2.y + r2.ly < fb->cho_y)
    28ae:	0f b7 45 cc          	movzx  eax,WORD PTR [ebp-0x34]
    28b2:	0f bf d0             	movsx  edx,ax
    28b5:	0f b7 45 d0          	movzx  eax,WORD PTR [ebp-0x30]
    28b9:	98                   	cwde
    28ba:	01 c2                	add    edx,eax
    28bc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    28bf:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
		if (r2.x >= fb->chw_x || r2.y >= fb->chw_y ||
    28c2:	39 c2                	cmp    edx,eax
    28c4:	0f 8c 75 03 00 00    	jl     2c3f <framebuffer_update_region+0x46e>
			r2.x + r2.lx < fb->cho_x || r2.y + r2.ly < fb->cho_y)
    28ca:	0f b7 45 ce          	movzx  eax,WORD PTR [ebp-0x32]
    28ce:	0f bf d0             	movsx  edx,ax
    28d1:	0f b7 45 d2          	movzx  eax,WORD PTR [ebp-0x2e]
    28d5:	98                   	cwde
    28d6:	01 c2                	add    edx,eax
    28d8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    28db:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    28de:	39 c2                	cmp    edx,eax
    28e0:	0f 8c 59 03 00 00    	jl     2c3f <framebuffer_update_region+0x46e>
				return;
		/* check for pending updates */
Pos1:
    28e6:	90                   	nop
		ptr = fb->r_ud;
    28e7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    28ea:	8b 40 34             	mov    eax,DWORD PTR [eax+0x34]
    28ed:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		while (ptr) { /* TODO: overhaul this -> leads to freezes */
    28f0:	e9 98 02 00 00       	jmp    2b8d <framebuffer_update_region+0x3bc>
				size_t i;
				for (i = 0; i < ptr->r_ct; i++) {
    28f5:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    28fc:	e9 79 01 00 00       	jmp    2a7a <framebuffer_update_region+0x2a9>
						/* check for extending horizontally */
						if (ptr->r[i].y == r2.y && ptr->r[i].ly == r2.ly) {
    2901:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    2904:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    2907:	89 d0                	mov    eax,edx
    2909:	c1 e0 02             	shl    eax,0x2
    290c:	01 d0                	add    eax,edx
    290e:	c1 e0 02             	shl    eax,0x2
    2911:	01 c8                	add    eax,ecx
    2913:	83 c0 02             	add    eax,0x2
    2916:	0f b7 10             	movzx  edx,WORD PTR [eax]
    2919:	0f b7 45 ce          	movzx  eax,WORD PTR [ebp-0x32]
    291d:	66 39 c2             	cmp    dx,ax
    2920:	0f 85 cb 00 00 00    	jne    29f1 <framebuffer_update_region+0x220>
    2926:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    2929:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    292c:	89 d0                	mov    eax,edx
    292e:	c1 e0 02             	shl    eax,0x2
    2931:	01 d0                	add    eax,edx
    2933:	c1 e0 02             	shl    eax,0x2
    2936:	01 c8                	add    eax,ecx
    2938:	83 c0 06             	add    eax,0x6
    293b:	0f b7 10             	movzx  edx,WORD PTR [eax]
    293e:	0f b7 45 d2          	movzx  eax,WORD PTR [ebp-0x2e]
    2942:	66 39 c2             	cmp    dx,ax
    2945:	0f 85 a6 00 00 00    	jne    29f1 <framebuffer_update_region+0x220>
								short new_lx, old_lx = ptr->r[i].lx;
    294b:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    294e:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    2951:	89 d0                	mov    eax,edx
    2953:	c1 e0 02             	shl    eax,0x2
    2956:	01 d0                	add    eax,edx
    2958:	c1 e0 02             	shl    eax,0x2
    295b:	01 c8                	add    eax,ecx
    295d:	83 c0 04             	add    eax,0x4
    2960:	0f b7 00             	movzx  eax,WORD PTR [eax]
    2963:	66 89 45 e6          	mov    WORD PTR [ebp-0x1a],ax
								if (ptr->r[i].x + ptr->r[i].lx == r2.x) {
    2967:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    296a:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    296d:	89 d0                	mov    eax,edx
    296f:	c1 e0 02             	shl    eax,0x2
    2972:	01 d0                	add    eax,edx
    2974:	c1 e0 02             	shl    eax,0x2
    2977:	01 c8                	add    eax,ecx
    2979:	0f b7 00             	movzx  eax,WORD PTR [eax]
    297c:	0f bf c8             	movsx  ecx,ax
    297f:	8b 5d f4             	mov    ebx,DWORD PTR [ebp-0xc]
    2982:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    2985:	89 d0                	mov    eax,edx
    2987:	c1 e0 02             	shl    eax,0x2
    298a:	01 d0                	add    eax,edx
    298c:	c1 e0 02             	shl    eax,0x2
    298f:	01 d8                	add    eax,ebx
    2991:	83 c0 04             	add    eax,0x4
    2994:	0f b7 00             	movzx  eax,WORD PTR [eax]
    2997:	98                   	cwde
    2998:	8d 14 01             	lea    edx,[ecx+eax*1]
    299b:	0f b7 45 cc          	movzx  eax,WORD PTR [ebp-0x34]
    299f:	98                   	cwde
    29a0:	39 c2                	cmp    edx,eax
    29a2:	75 4d                	jne    29f1 <framebuffer_update_region+0x220>
										new_lx = old_lx + r2.lx;
    29a4:	0f b7 45 d0          	movzx  eax,WORD PTR [ebp-0x30]
    29a8:	89 c2                	mov    edx,eax
    29aa:	0f b7 45 e6          	movzx  eax,WORD PTR [ebp-0x1a]
    29ae:	01 d0                	add    eax,edx
    29b0:	66 89 45 e4          	mov    WORD PTR [ebp-0x1c],ax
										/* try to combine */
										if (!__sync_bool_compare_and_swap(&ptr->r[i].lx, old_lx, new_lx))
    29b4:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
    29b8:	0f b7 d8             	movzx  ebx,ax
    29bb:	0f b7 45 e6          	movzx  eax,WORD PTR [ebp-0x1a]
    29bf:	0f b7 c8             	movzx  ecx,ax
    29c2:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    29c5:	89 d0                	mov    eax,edx
    29c7:	c1 e0 02             	shl    eax,0x2
    29ca:	01 d0                	add    eax,edx
    29cc:	c1 e0 02             	shl    eax,0x2
    29cf:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    29d2:	01 d0                	add    eax,edx
    29d4:	8d 50 04             	lea    edx,[eax+0x4]
    29d7:	89 c8                	mov    eax,ecx
    29d9:	66 f0 0f b1 1a       	lock cmpxchg WORD PTR [edx],bx
    29de:	0f 94 c0             	sete   al
    29e1:	83 f0 01             	xor    eax,0x1
    29e4:	84 c0                	test   al,al
    29e6:	0f 84 56 02 00 00    	je     2c42 <framebuffer_update_region+0x471>
												goto Pos1;
    29ec:	e9 f6 fe ff ff       	jmp    28e7 <framebuffer_update_region+0x116>
//										}
//										return;
//								}
//						}
						/* also check for duplicates */
						if (ptr->r[i].x == r2.x && ptr->r[i].y == r2.y
    29f1:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    29f4:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    29f7:	89 d0                	mov    eax,edx
    29f9:	c1 e0 02             	shl    eax,0x2
    29fc:	01 d0                	add    eax,edx
    29fe:	c1 e0 02             	shl    eax,0x2
    2a01:	01 c8                	add    eax,ecx
    2a03:	0f b7 10             	movzx  edx,WORD PTR [eax]
    2a06:	0f b7 45 cc          	movzx  eax,WORD PTR [ebp-0x34]
    2a0a:	66 39 c2             	cmp    dx,ax
    2a0d:	75 67                	jne    2a76 <framebuffer_update_region+0x2a5>
    2a0f:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    2a12:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    2a15:	89 d0                	mov    eax,edx
    2a17:	c1 e0 02             	shl    eax,0x2
    2a1a:	01 d0                	add    eax,edx
    2a1c:	c1 e0 02             	shl    eax,0x2
    2a1f:	01 c8                	add    eax,ecx
    2a21:	83 c0 02             	add    eax,0x2
    2a24:	0f b7 10             	movzx  edx,WORD PTR [eax]
    2a27:	0f b7 45 ce          	movzx  eax,WORD PTR [ebp-0x32]
    2a2b:	66 39 c2             	cmp    dx,ax
    2a2e:	75 46                	jne    2a76 <framebuffer_update_region+0x2a5>
							&& ptr->r[i].lx == r2.lx && ptr->r[i].ly == r2.ly)
    2a30:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    2a33:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    2a36:	89 d0                	mov    eax,edx
    2a38:	c1 e0 02             	shl    eax,0x2
    2a3b:	01 d0                	add    eax,edx
    2a3d:	c1 e0 02             	shl    eax,0x2
    2a40:	01 c8                	add    eax,ecx
    2a42:	83 c0 04             	add    eax,0x4
    2a45:	0f b7 10             	movzx  edx,WORD PTR [eax]
    2a48:	0f b7 45 d0          	movzx  eax,WORD PTR [ebp-0x30]
    2a4c:	66 39 c2             	cmp    dx,ax
    2a4f:	75 25                	jne    2a76 <framebuffer_update_region+0x2a5>
    2a51:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    2a54:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    2a57:	89 d0                	mov    eax,edx
    2a59:	c1 e0 02             	shl    eax,0x2
    2a5c:	01 d0                	add    eax,edx
    2a5e:	c1 e0 02             	shl    eax,0x2
    2a61:	01 c8                	add    eax,ecx
    2a63:	83 c0 06             	add    eax,0x6
    2a66:	0f b7 10             	movzx  edx,WORD PTR [eax]
    2a69:	0f b7 45 d2          	movzx  eax,WORD PTR [ebp-0x2e]
    2a6d:	66 39 c2             	cmp    dx,ax
    2a70:	0f 84 cf 01 00 00    	je     2c45 <framebuffer_update_region+0x474>
				for (i = 0; i < ptr->r_ct; i++) {
    2a76:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
    2a7a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2a7d:	8b 80 84 02 00 00    	mov    eax,DWORD PTR [eax+0x284]
    2a83:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
    2a86:	0f 82 75 fe ff ff    	jb     2901 <framebuffer_update_region+0x130>
								return;
				}
				/* add inbetween */
				if ((idx = __sync_fetch_and_add(&ptr->r_ct, 1)) < 32) {
    2a8c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2a8f:	05 84 02 00 00       	add    eax,0x284
    2a94:	ba 01 00 00 00       	mov    edx,0x1
    2a99:	f0 0f c1 10          	lock xadd DWORD PTR [eax],edx
    2a9d:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
    2aa0:	83 7d ec 1f          	cmp    DWORD PTR [ebp-0x14],0x1f
    2aa4:	77 34                	ja     2ada <framebuffer_update_region+0x309>
						ptr->r[idx] = r2;
    2aa6:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
    2aa9:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    2aac:	89 d0                	mov    eax,edx
    2aae:	c1 e0 02             	shl    eax,0x2
    2ab1:	01 d0                	add    eax,edx
    2ab3:	c1 e0 02             	shl    eax,0x2
    2ab6:	01 c8                	add    eax,ecx
    2ab8:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    2abb:	89 10                	mov    DWORD PTR [eax],edx
    2abd:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    2ac0:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
    2ac3:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    2ac6:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
    2ac9:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    2acc:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
    2acf:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    2ad2:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
						break;
    2ad5:	e9 c0 00 00 00       	jmp    2b9a <framebuffer_update_region+0x3c9>
				} else
						__sync_fetch_and_sub(&ptr->r_ct, 1);
    2ada:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2add:	05 84 02 00 00       	add    eax,0x284
    2ae2:	f0 83 28 01          	lock sub DWORD PTR [eax],0x1
				/* we need a new container */
				if (!ptr->next) {
    2ae6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2ae9:	8b 80 80 02 00 00    	mov    eax,DWORD PTR [eax+0x280]
    2aef:	85 c0                	test   eax,eax
    2af1:	0f 85 8a 00 00 00    	jne    2b81 <framebuffer_update_region+0x3b0>
						while (fb_no_malloc);
    2af7:	90                   	nop
    2af8:	a1 00 00 00 00       	mov    eax,ds:0x0
    2afd:	85 c0                	test   eax,eax
    2aff:	75 f7                	jne    2af8 <framebuffer_update_region+0x327>
						struct rct* rn = kmalloc(sizeof(struct rct));
    2b01:	83 ec 0c             	sub    esp,0xc
    2b04:	68 88 02 00 00       	push   0x288
    2b09:	e8 fc ff ff ff       	call   2b0a <framebuffer_update_region+0x339>
    2b0e:	83 c4 10             	add    esp,0x10
    2b11:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
						rn->r_ct = 1;
    2b14:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    2b17:	c7 80 84 02 00 00 01 00 00 00 	mov    DWORD PTR [eax+0x284],0x1
						rn->r[0] = r2;
    2b21:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    2b24:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    2b27:	89 10                	mov    DWORD PTR [eax],edx
    2b29:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    2b2c:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
    2b2f:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    2b32:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
    2b35:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    2b38:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
    2b3b:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    2b3e:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
						rn->next = NULL;
    2b41:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    2b44:	c7 80 80 02 00 00 00 00 00 00 	mov    DWORD PTR [eax+0x280],0x0
						if (__sync_bool_compare_and_swap(&ptr->next, NULL, rn))
    2b4e:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    2b51:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2b54:	8d 88 80 02 00 00    	lea    ecx,[eax+0x280]
    2b5a:	b8 00 00 00 00       	mov    eax,0x0
    2b5f:	f0 0f b1 11          	lock cmpxchg DWORD PTR [ecx],edx
    2b63:	0f 94 c0             	sete   al
    2b66:	84 c0                	test   al,al
    2b68:	75 2f                	jne    2b99 <framebuffer_update_region+0x3c8>
								break;
						else if (!fb_no_malloc) { /* someone was faster */
    2b6a:	a1 00 00 00 00       	mov    eax,ds:0x0
    2b6f:	85 c0                	test   eax,eax
    2b71:	75 0e                	jne    2b81 <framebuffer_update_region+0x3b0>
								kfree(rn);
    2b73:	83 ec 0c             	sub    esp,0xc
    2b76:	ff 75 e8             	push   DWORD PTR [ebp-0x18]
    2b79:	e8 fc ff ff ff       	call   2b7a <framebuffer_update_region+0x3a9>
    2b7e:	83 c4 10             	add    esp,0x10
								//goto Pos1; ptr=next
						}
				}
				ptr = ptr->next;
    2b81:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2b84:	8b 80 80 02 00 00    	mov    eax,DWORD PTR [eax+0x280]
    2b8a:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		while (ptr) { /* TODO: overhaul this -> leads to freezes */
    2b8d:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    2b91:	0f 85 5e fd ff ff    	jne    28f5 <framebuffer_update_region+0x124>
    2b97:	eb 01                	jmp    2b9a <framebuffer_update_region+0x3c9>
								break;
    2b99:	90                   	nop
		}
		/* else extend the list */
		if (!fb->r_ud) 
    2b9a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2b9d:	8b 40 34             	mov    eax,DWORD PTR [eax+0x34]
    2ba0:	85 c0                	test   eax,eax
    2ba2:	0f 85 9e 00 00 00    	jne    2c46 <framebuffer_update_region+0x475>
				if (fb_no_malloc) {
    2ba8:	a1 00 00 00 00       	mov    eax,ds:0x0
    2bad:	85 c0                	test   eax,eax
    2baf:	74 0f                	je     2bc0 <framebuffer_update_region+0x3ef>
					fb->r_ud = &rc_initial;
    2bb1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2bb4:	c7 40 34 00 00 00 00 	mov    DWORD PTR [eax+0x34],0x0
    2bbb:	e9 86 00 00 00       	jmp    2c46 <framebuffer_update_region+0x475>
				} else {
						struct rct* rn = kmalloc(sizeof(struct rct));
    2bc0:	83 ec 0c             	sub    esp,0xc
    2bc3:	68 88 02 00 00       	push   0x288
    2bc8:	e8 fc ff ff ff       	call   2bc9 <framebuffer_update_region+0x3f8>
    2bcd:	83 c4 10             	add    esp,0x10
    2bd0:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
						rn->r_ct = 1;
    2bd3:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    2bd6:	c7 80 84 02 00 00 01 00 00 00 	mov    DWORD PTR [eax+0x284],0x1
						rn->r[0] = r2;
    2be0:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    2be3:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
    2be6:	89 10                	mov    DWORD PTR [eax],edx
    2be8:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
    2beb:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
    2bee:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    2bf1:	89 50 08             	mov    DWORD PTR [eax+0x8],edx
    2bf4:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    2bf7:	89 50 0c             	mov    DWORD PTR [eax+0xc],edx
    2bfa:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    2bfd:	89 50 10             	mov    DWORD PTR [eax+0x10],edx
						rn->next = NULL;
    2c00:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    2c03:	c7 80 80 02 00 00 00 00 00 00 	mov    DWORD PTR [eax+0x280],0x0
						if (!__sync_bool_compare_and_swap(&fb->r_ud, NULL, rn)) {
    2c0d:	8b 55 e0             	mov    edx,DWORD PTR [ebp-0x20]
    2c10:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2c13:	8d 48 34             	lea    ecx,[eax+0x34]
    2c16:	b8 00 00 00 00       	mov    eax,0x0
    2c1b:	f0 0f b1 11          	lock cmpxchg DWORD PTR [ecx],edx
    2c1f:	0f 94 c0             	sete   al
    2c22:	83 f0 01             	xor    eax,0x1
    2c25:	84 c0                	test   al,al
    2c27:	74 1d                	je     2c46 <framebuffer_update_region+0x475>
								/* someone was faster */
								kfree(rn);
    2c29:	83 ec 0c             	sub    esp,0xc
    2c2c:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
    2c2f:	e8 fc ff ff ff       	call   2c30 <framebuffer_update_region+0x45f>
    2c34:	83 c4 10             	add    esp,0x10
								goto Pos1;
    2c37:	e9 ab fc ff ff       	jmp    28e7 <framebuffer_update_region+0x116>
				return;
    2c3c:	90                   	nop
    2c3d:	eb 07                	jmp    2c46 <framebuffer_update_region+0x475>
				return;
    2c3f:	90                   	nop
    2c40:	eb 04                	jmp    2c46 <framebuffer_update_region+0x475>
										return;
    2c42:	90                   	nop
    2c43:	eb 01                	jmp    2c46 <framebuffer_update_region+0x475>
								return;
    2c45:	90                   	nop
						}	
		}
}
    2c46:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    2c49:	c9                   	leave
    2c4a:	c3                   	ret

00002c4b <framebuffer_scroll>:

/* we have to redraw everything */
void framebuffer_scroll(struct framebuffer* fb, ssize_t nly, ssize_t nlx)
{
    2c4b:	55                   	push   ebp
    2c4c:	89 e5                	mov    ebp,esp
    2c4e:	83 ec 08             	sub    esp,0x8
		if (nly != 1 || nlx)
    2c51:	83 7d 0c 01          	cmp    DWORD PTR [ebp+0xc],0x1
    2c55:	75 08                	jne    2c5f <framebuffer_scroll+0x14>
    2c57:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    2c5b:	75 02                	jne    2c5f <framebuffer_scroll+0x14>
    2c5d:	eb 02                	jmp    2c61 <framebuffer_scroll+0x16>
				while (1); /* only lines for now */
    2c5f:	eb fe                	jmp    2c5f <framebuffer_scroll+0x14>
		memmove(fb->text_mem, fb->text_mem + fb->width * 2,
					   	2 * fb->width * (fb->height - 1));
    2c61:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2c64:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2c67:	8d 14 00             	lea    edx,[eax+eax*1]
    2c6a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2c6d:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2c70:	83 e8 01             	sub    eax,0x1
    2c73:	0f af c2             	imul   eax,edx
		memmove(fb->text_mem, fb->text_mem + fb->width * 2,
    2c76:	89 c1                	mov    ecx,eax
    2c78:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2c7b:	8b 10                	mov    edx,DWORD PTR [eax]
    2c7d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2c80:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2c83:	01 c0                	add    eax,eax
    2c85:	01 c2                	add    edx,eax
    2c87:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2c8a:	8b 00                	mov    eax,DWORD PTR [eax]
    2c8c:	83 ec 04             	sub    esp,0x4
    2c8f:	51                   	push   ecx
    2c90:	52                   	push   edx
    2c91:	50                   	push   eax
    2c92:	e8 fc ff ff ff       	call   2c93 <framebuffer_scroll+0x48>
    2c97:	83 c4 10             	add    esp,0x10
		//framebuffer_redraw(fb);
}
    2c9a:	90                   	nop
    2c9b:	c9                   	leave
    2c9c:	c3                   	ret

00002c9d <framebuffer_scroll_region>:

void framebuffer_scroll_region(struct framebuffer* fb,
				struct kio_region* r, ssize_t nx, ssize_t ny)
{
    2c9d:	55                   	push   ebp
    2c9e:	89 e5                	mov    ebp,esp
    2ca0:	53                   	push   ebx
    2ca1:	83 ec 14             	sub    esp,0x14
		ssize_t i; char* src = NULL;
    2ca4:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
		if (ny != 1 || nx)
    2cab:	83 7d 14 01          	cmp    DWORD PTR [ebp+0x14],0x1
    2caf:	75 08                	jne    2cb9 <framebuffer_scroll_region+0x1c>
    2cb1:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
    2cb5:	75 02                	jne    2cb9 <framebuffer_scroll_region+0x1c>
    2cb7:	eb 02                	jmp    2cbb <framebuffer_scroll_region+0x1e>
				while (1); /* only lines for now */
    2cb9:	eb fe                	jmp    2cb9 <framebuffer_scroll_region+0x1c>
		/* sanity check */
		if (r->x + r->lx > fb->width)
    2cbb:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2cbe:	0f b7 00             	movzx  eax,WORD PTR [eax]
    2cc1:	0f bf d0             	movsx  edx,ax
    2cc4:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2cc7:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
    2ccb:	98                   	cwde
    2ccc:	01 c2                	add    edx,eax
    2cce:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2cd1:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2cd4:	39 c2                	cmp    edx,eax
    2cd6:	0f 8f 08 01 00 00    	jg     2de4 <framebuffer_scroll_region+0x147>
				return;
		if (r->y + r->ly > fb->height)
    2cdc:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2cdf:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    2ce3:	0f bf d0             	movsx  edx,ax
    2ce6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2ce9:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
    2ced:	98                   	cwde
    2cee:	01 c2                	add    edx,eax
    2cf0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2cf3:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2cf6:	39 c2                	cmp    edx,eax
    2cf8:	0f 8f e9 00 00 00    	jg     2de7 <framebuffer_scroll_region+0x14a>
				return;
		/* by moving possibly strided memory */
		for (i = r->y; i < r->y + r->ly - 1; i++)
    2cfe:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2d01:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    2d05:	98                   	cwde
    2d06:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    2d09:	eb 65                	jmp    2d70 <framebuffer_scroll_region+0xd3>
				memcpy(fb->text_mem + i * fb->width * 2 + r->x * 2,
					   (src = fb->text_mem + (i + 1) * fb->width * 2 + r->x * 2),
					   r->lx * 2);
    2d0b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2d0e:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
    2d12:	98                   	cwde
    2d13:	01 c0                	add    eax,eax
				memcpy(fb->text_mem + i * fb->width * 2 + r->x * 2,
    2d15:	89 c3                	mov    ebx,eax
					   (src = fb->text_mem + (i + 1) * fb->width * 2 + r->x * 2),
    2d17:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2d1a:	8b 10                	mov    edx,DWORD PTR [eax]
    2d1c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2d1f:	8d 48 01             	lea    ecx,[eax+0x1]
    2d22:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2d25:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2d28:	0f af c1             	imul   eax,ecx
    2d2b:	01 c0                	add    eax,eax
    2d2d:	89 c1                	mov    ecx,eax
    2d2f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2d32:	0f b7 00             	movzx  eax,WORD PTR [eax]
    2d35:	98                   	cwde
    2d36:	01 c0                	add    eax,eax
    2d38:	01 c8                	add    eax,ecx
    2d3a:	01 d0                	add    eax,edx
    2d3c:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				memcpy(fb->text_mem + i * fb->width * 2 + r->x * 2,
    2d3f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2d42:	8b 10                	mov    edx,DWORD PTR [eax]
    2d44:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2d47:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2d4a:	0f af 45 f4          	imul   eax,DWORD PTR [ebp-0xc]
    2d4e:	01 c0                	add    eax,eax
    2d50:	89 c1                	mov    ecx,eax
    2d52:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2d55:	0f b7 00             	movzx  eax,WORD PTR [eax]
    2d58:	98                   	cwde
    2d59:	01 c0                	add    eax,eax
    2d5b:	01 c8                	add    eax,ecx
    2d5d:	01 d0                	add    eax,edx
    2d5f:	53                   	push   ebx
    2d60:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    2d63:	50                   	push   eax
    2d64:	e8 97 d2 ff ff       	call   0 <memcpy>
    2d69:	83 c4 0c             	add    esp,0xc
		for (i = r->y; i < r->y + r->ly - 1; i++)
    2d6c:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    2d70:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2d73:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    2d77:	0f bf d0             	movsx  edx,ax
    2d7a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2d7d:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
    2d81:	98                   	cwde
    2d82:	01 d0                	add    eax,edx
    2d84:	83 e8 01             	sub    eax,0x1
    2d87:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
    2d8a:	0f 8c 7b ff ff ff    	jl     2d0b <framebuffer_scroll_region+0x6e>
		if (!src)
    2d90:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    2d94:	74 54                	je     2dea <framebuffer_scroll_region+0x14d>
				return;
		for (i = 0; i < 2 * r->lx; i += 2) {
    2d96:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    2d9d:	eb 23                	jmp    2dc2 <framebuffer_scroll_region+0x125>
				src[i] = '\0';
    2d9f:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    2da2:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2da5:	01 d0                	add    eax,edx
    2da7:	c6 00 00             	mov    BYTE PTR [eax],0x0
				src[i + 1] = r->fmt;
    2daa:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2dad:	8d 50 01             	lea    edx,[eax+0x1]
    2db0:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2db3:	01 c2                	add    edx,eax
    2db5:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2db8:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    2dbc:	88 02                	mov    BYTE PTR [edx],al
		for (i = 0; i < 2 * r->lx; i += 2) {
    2dbe:	83 45 f4 02          	add    DWORD PTR [ebp-0xc],0x2
    2dc2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2dc5:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
    2dc9:	98                   	cwde
    2dca:	01 c0                	add    eax,eax
    2dcc:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
    2dcf:	7c ce                	jl     2d9f <framebuffer_scroll_region+0x102>
		} /* TODO other scrolls */
		/*bzero(fb->text_mem + i * fb->width * 2 + r->x * 2, r->lx * 2);*/
		framebuffer_update_region(fb, r);
    2dd1:	83 ec 08             	sub    esp,0x8
    2dd4:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    2dd7:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    2dda:	e8 fc ff ff ff       	call   2ddb <framebuffer_scroll_region+0x13e>
    2ddf:	83 c4 10             	add    esp,0x10
    2de2:	eb 07                	jmp    2deb <framebuffer_scroll_region+0x14e>
				return;
    2de4:	90                   	nop
    2de5:	eb 04                	jmp    2deb <framebuffer_scroll_region+0x14e>
				return;
    2de7:	90                   	nop
    2de8:	eb 01                	jmp    2deb <framebuffer_scroll_region+0x14e>
				return;
    2dea:	90                   	nop
}
    2deb:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    2dee:	c9                   	leave
    2def:	c3                   	ret

00002df0 <framebuffer_clear_region>:

void framebuffer_clear_region(struct framebuffer* fb, struct kio_region* r)
{
    2df0:	55                   	push   ebp
    2df1:	89 e5                	mov    ebp,esp
    2df3:	83 ec 18             	sub    esp,0x18
		char* p;
		if (r->x + r->lx > fb->width)
    2df6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2df9:	0f b7 00             	movzx  eax,WORD PTR [eax]
    2dfc:	0f bf d0             	movsx  edx,ax
    2dff:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2e02:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
    2e06:	98                   	cwde
    2e07:	01 c2                	add    edx,eax
    2e09:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2e0c:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2e0f:	39 c2                	cmp    edx,eax
    2e11:	0f 8f db 00 00 00    	jg     2ef2 <framebuffer_clear_region+0x102>
				return;
		if (r->y + r->ly > fb->height)
    2e17:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2e1a:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    2e1e:	0f bf d0             	movsx  edx,ax
    2e21:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2e24:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
    2e28:	98                   	cwde
    2e29:	01 c2                	add    edx,eax
    2e2b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2e2e:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2e31:	39 c2                	cmp    edx,eax
    2e33:	0f 8f bc 00 00 00    	jg     2ef5 <framebuffer_clear_region+0x105>
				return;
		p = (char*)fb->text_mem + 2 * r->y * fb->width + 2 * r->x;
    2e39:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2e3c:	8b 10                	mov    edx,DWORD PTR [eax]
    2e3e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2e41:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
    2e45:	98                   	cwde
    2e46:	8d 0c 00             	lea    ecx,[eax+eax*1]
    2e49:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2e4c:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2e4f:	0f af c1             	imul   eax,ecx
    2e52:	89 c1                	mov    ecx,eax
    2e54:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2e57:	0f b7 00             	movzx  eax,WORD PTR [eax]
    2e5a:	98                   	cwde
    2e5b:	01 c0                	add    eax,eax
    2e5d:	01 c8                	add    eax,ecx
    2e5f:	01 d0                	add    eax,edx
    2e61:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		for (ssize_t l = 0; l < r->ly; l++)
    2e64:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    2e6b:	eb 65                	jmp    2ed2 <framebuffer_clear_region+0xe2>
				for (ssize_t c = 0; c < r->lx; c++) {
    2e6d:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    2e74:	eb 4b                	jmp    2ec1 <framebuffer_clear_region+0xd1>
						p[l * 2 * fb->width + 2 * c] = '\0';
    2e76:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2e79:	8d 14 00             	lea    edx,[eax+eax*1]
    2e7c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2e7f:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2e82:	0f af c2             	imul   eax,edx
    2e85:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    2e88:	01 d2                	add    edx,edx
    2e8a:	01 d0                	add    eax,edx
    2e8c:	89 c2                	mov    edx,eax
    2e8e:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2e91:	01 d0                	add    eax,edx
    2e93:	c6 00 00             	mov    BYTE PTR [eax],0x0
						p[l * 2 * fb->width + 2 * c + 1] = r->fmt;
    2e96:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2e99:	8d 14 00             	lea    edx,[eax+eax*1]
    2e9c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2e9f:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2ea2:	0f af c2             	imul   eax,edx
    2ea5:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    2ea8:	01 d2                	add    edx,edx
    2eaa:	01 d0                	add    eax,edx
    2eac:	8d 50 01             	lea    edx,[eax+0x1]
    2eaf:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2eb2:	01 c2                	add    edx,eax
    2eb4:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2eb7:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    2ebb:	88 02                	mov    BYTE PTR [edx],al
				for (ssize_t c = 0; c < r->lx; c++) {
    2ebd:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
    2ec1:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2ec4:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
    2ec8:	98                   	cwde
    2ec9:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
    2ecc:	7c a8                	jl     2e76 <framebuffer_clear_region+0x86>
		for (ssize_t l = 0; l < r->ly; l++)
    2ece:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
    2ed2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2ed5:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
    2ed9:	98                   	cwde
    2eda:	39 45 f4             	cmp    DWORD PTR [ebp-0xc],eax
    2edd:	7c 8e                	jl     2e6d <framebuffer_clear_region+0x7d>
				}
		framebuffer_update_region(fb, r);
    2edf:	83 ec 08             	sub    esp,0x8
    2ee2:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    2ee5:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    2ee8:	e8 fc ff ff ff       	call   2ee9 <framebuffer_clear_region+0xf9>
    2eed:	83 c4 10             	add    esp,0x10
    2ef0:	eb 04                	jmp    2ef6 <framebuffer_clear_region+0x106>
				return;
    2ef2:	90                   	nop
    2ef3:	eb 01                	jmp    2ef6 <framebuffer_clear_region+0x106>
				return;
    2ef5:	90                   	nop
}
    2ef6:	c9                   	leave
    2ef7:	c3                   	ret

00002ef8 <framebuffer_set_cursor>:

/* has to flush the previous character and the new one and also pending updates */
void framebuffer_set_cursor(struct framebuffer* fb, ssize_t x, ssize_t y)
{
    2ef8:	55                   	push   ebp
    2ef9:	89 e5                	mov    ebp,esp
    2efb:	83 ec 28             	sub    esp,0x28
		struct kio_region r;
		if (fb->cur_x > 0 && fb->cur_y > 0
    2efe:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2f01:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    2f04:	85 c0                	test   eax,eax
    2f06:	0f 8e 84 00 00 00    	jle    2f90 <framebuffer_set_cursor+0x98>
    2f0c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2f0f:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    2f12:	85 c0                	test   eax,eax
    2f14:	7e 7a                	jle    2f90 <framebuffer_set_cursor+0x98>
			&& fb->cur_x < fb->chw_x
    2f16:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2f19:	8b 50 14             	mov    edx,DWORD PTR [eax+0x14]
    2f1c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2f1f:	8b 40 2c             	mov    eax,DWORD PTR [eax+0x2c]
    2f22:	39 c2                	cmp    edx,eax
    2f24:	7d 6a                	jge    2f90 <framebuffer_set_cursor+0x98>
			&& fb->cur_y < fb->chw_y) {
    2f26:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2f29:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
    2f2c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2f2f:	8b 40 30             	mov    eax,DWORD PTR [eax+0x30]
    2f32:	39 c2                	cmp    edx,eax
    2f34:	7d 5a                	jge    2f90 <framebuffer_set_cursor+0x98>
				r.x = fb->cur_x + fb->cho_y;
    2f36:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2f39:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    2f3c:	89 c2                	mov    edx,eax
    2f3e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2f41:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2f44:	01 d0                	add    eax,edx
    2f46:	66 89 45 e4          	mov    WORD PTR [ebp-0x1c],ax
				r.lx = 1;
    2f4a:	66 c7 45 e8 01 00    	mov    WORD PTR [ebp-0x18],0x1
				r.y = fb->cur_y + fb->cho_y;
    2f50:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2f53:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    2f56:	89 c2                	mov    edx,eax
    2f58:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2f5b:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2f5e:	01 d0                	add    eax,edx
    2f60:	66 89 45 e6          	mov    WORD PTR [ebp-0x1a],ax
				r.ly = 1;
    2f64:	66 c7 45 ea 01 00    	mov    WORD PTR [ebp-0x16],0x1
				fb->cur_x = x;
    2f6a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2f6d:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2f70:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
				fb->cur_y = y;
    2f73:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2f76:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
    2f79:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
				framebuffer_update_region(fb, &r);
    2f7c:	83 ec 08             	sub    esp,0x8
    2f7f:	8d 45 e4             	lea    eax,[ebp-0x1c]
    2f82:	50                   	push   eax
    2f83:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    2f86:	e8 fc ff ff ff       	call   2f87 <framebuffer_set_cursor+0x8f>
    2f8b:	83 c4 10             	add    esp,0x10
    2f8e:	eb 12                	jmp    2fa2 <framebuffer_set_cursor+0xaa>
		} else {
				fb->cur_x = x;
    2f90:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2f93:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2f96:	89 50 14             	mov    DWORD PTR [eax+0x14],edx
				fb->cur_y = y;
    2f99:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2f9c:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
    2f9f:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
		}
		r.x = fb->cur_x + fb->cho_x;
    2fa2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2fa5:	8b 40 14             	mov    eax,DWORD PTR [eax+0x14]
    2fa8:	89 c2                	mov    edx,eax
    2faa:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2fad:	8b 40 24             	mov    eax,DWORD PTR [eax+0x24]
    2fb0:	01 d0                	add    eax,edx
    2fb2:	66 89 45 e4          	mov    WORD PTR [ebp-0x1c],ax
		r.y = fb->cur_y + fb->cho_y;
    2fb6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2fb9:	8b 40 18             	mov    eax,DWORD PTR [eax+0x18]
    2fbc:	89 c2                	mov    edx,eax
    2fbe:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2fc1:	8b 40 28             	mov    eax,DWORD PTR [eax+0x28]
    2fc4:	01 d0                	add    eax,edx
    2fc6:	66 89 45 e6          	mov    WORD PTR [ebp-0x1a],ax
		r.lx = r.ly = 1;
    2fca:	66 c7 45 ea 01 00    	mov    WORD PTR [ebp-0x16],0x1
    2fd0:	0f b7 45 ea          	movzx  eax,WORD PTR [ebp-0x16]
    2fd4:	66 89 45 e8          	mov    WORD PTR [ebp-0x18],ax
		framebuffer_update_region(fb, &r);
    2fd8:	83 ec 08             	sub    esp,0x8
    2fdb:	8d 45 e4             	lea    eax,[ebp-0x1c]
    2fde:	50                   	push   eax
    2fdf:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    2fe2:	e8 fc ff ff ff       	call   2fe3 <framebuffer_set_cursor+0xeb>
    2fe7:	83 c4 10             	add    esp,0x10
		//framebuffer_redraw(fb);
}
    2fea:	90                   	nop
    2feb:	c9                   	leave
    2fec:	c3                   	ret

00002fed <framebuffer_resize>:

/* works on character cells */
void framebuffer_resize(struct framebuffer* fb, ssize_t new_lx, ssize_t new_ly)
{
    2fed:	55                   	push   ebp
    2fee:	89 e5                	mov    ebp,esp
		(void)fb; (void)new_lx; (void)new_ly;
}
    2ff0:	90                   	nop
    2ff1:	5d                   	pop    ebp
    2ff2:	c3                   	ret
