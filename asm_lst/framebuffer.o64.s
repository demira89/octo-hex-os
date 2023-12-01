
framebuffer.o64:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <memcpy>:
								mem += 4;
								bitc -= 32;
						} else if (bitc) {
								die("cant happen with dword sized pixels!\n");
						}
						break;
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
				/* and don't advance as r = 0 is already handled (sth. remains) */
      24:	eb 1d                	jmp    43 <memcpy+0x43>
				if (px_x) {
      26:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
      2a:	48 8d 42 01          	lea    rax,[rdx+0x1]
      2e:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
      32:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      36:	48 8d 48 01          	lea    rcx,[rax+0x1]
      3a:	48 89 4d f8          	mov    QWORD PTR [rbp-0x8],rcx
      3e:	0f b6 12             	movzx  edx,BYTE PTR [rdx]
      41:	88 10                	mov    BYTE PTR [rax],dl
				/* and don't advance as r = 0 is already handled (sth. remains) */
      43:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
      47:	48 8d 50 ff          	lea    rdx,[rax-0x1]
      4b:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
      4f:	48 85 c0             	test   rax,rax
      52:	75 d2                	jne    26 <memcpy+0x26>
						px_x -= bitc / 32;
      54:	90                   	nop
      55:	90                   	nop
      56:	c9                   	leave
      57:	c3                   	ret

0000000000000058 <fb_video_setup>:
{
      58:	55                   	push   rbp
      59:	48 89 e5             	mov    rbp,rsp
      5c:	48 83 ec 10          	sub    rsp,0x10
		memcpy(&video_mode, FM_VIDEO_MODE, sizeof(video_mode));
      60:	ba 1c 00 00 00       	mov    edx,0x1c
      65:	be 00 f0 04 00       	mov    esi,0x4f000
      6a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
      71:	e8 8a ff ff ff       	call   0 <memcpy>
		vga_font = (const char*)video_mode.fnt;
      76:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 7c <fb_video_setup+0x24>
      7c:	89 c0                	mov    eax,eax
      7e:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 85 <fb_video_setup+0x2d>
		vmd = (void*)video_mode.ptr;
      85:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 8b <fb_video_setup+0x33>
      8b:	89 c0                	mov    eax,eax
      8d:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		vga_mem_ptr = (void*)vmd->vga_virt;
      91:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      95:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
      99:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # a0 <fb_video_setup+0x48>
		vga_pmem = (void*)vmd->vga_base;
      a0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      a4:	48 8b 00             	mov    rax,QWORD PTR [rax]
      a7:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # ae <fb_video_setup+0x56>
		vga_pmem_size = (size_t)vmd->vga_size;
      ae:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      b2:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
      b6:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # bd <fb_video_setup+0x65>
						video_mode.height / 16 /* char_width_xy*/);
      bd:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # c3 <fb_video_setup+0x6b>
		framebuffer_initialize(&fb_initial, (void*)video_mode.fnt,
      c3:	8d 50 0f             	lea    edx,[rax+0xf]
      c6:	85 c0                	test   eax,eax
      c8:	0f 48 c2             	cmovs  eax,edx
      cb:	c1 f8 04             	sar    eax,0x4
      ce:	89 c7                	mov    edi,eax
						0, 0, /* char_ofs_xy*/ video_mode.width / 8,
      d0:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # d6 <fb_video_setup+0x7e>
		framebuffer_initialize(&fb_initial, (void*)video_mode.fnt,
      d6:	8d 50 07             	lea    edx,[rax+0x7]
      d9:	85 c0                	test   eax,eax
      db:	0f 48 c2             	cmovs  eax,edx
      de:	c1 f8 03             	sar    eax,0x3
      e1:	89 c6                	mov    esi,eax
						video_mode.height / 16, 0, 0, /* pxl_ofs_xy*/
      e3:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # e9 <fb_video_setup+0x91>
		framebuffer_initialize(&fb_initial, (void*)video_mode.fnt,
      e9:	8d 50 0f             	lea    edx,[rax+0xf]
      ec:	85 c0                	test   eax,eax
      ee:	0f 48 c2             	cmovs  eax,edx
      f1:	c1 f8 04             	sar    eax,0x4
      f4:	41 89 c0             	mov    r8d,eax
						(void*)video_mode.txt,video_mode.width / 8,
      f7:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # fd <fb_video_setup+0xa5>
		framebuffer_initialize(&fb_initial, (void*)video_mode.fnt,
      fd:	8d 50 07             	lea    edx,[rax+0x7]
     100:	85 c0                	test   eax,eax
     102:	0f 48 c2             	cmovs  eax,edx
     105:	c1 f8 03             	sar    eax,0x3
     108:	89 c1                	mov    ecx,eax
						(void*)video_mode.txt,video_mode.width / 8,
     10a:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 110 <fb_video_setup+0xb8>
     110:	89 c0                	mov    eax,eax
		framebuffer_initialize(&fb_initial, (void*)video_mode.fnt,
     112:	48 89 c2             	mov    rdx,rax
     115:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 11b <fb_video_setup+0xc3>
     11b:	89 c0                	mov    eax,eax
     11d:	48 83 ec 08          	sub    rsp,0x8
     121:	57                   	push   rdi
     122:	56                   	push   rsi
     123:	6a 00                	push   0x0
     125:	6a 00                	push   0x0
     127:	6a 00                	push   0x0
     129:	41 b9 00 00 00 00    	mov    r9d,0x0
     12f:	48 89 c6             	mov    rsi,rax
     132:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     139:	e8 00 00 00 00       	call   13e <fb_video_setup+0xe6>
     13e:	48 83 c4 30          	add    rsp,0x30
		kio_fb_resize();
     142:	b8 00 00 00 00       	mov    eax,0x0
     147:	e8 00 00 00 00       	call   14c <fb_video_setup+0xf4>
		puts("done setting up the framebuffer");
     14c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     153:	e8 00 00 00 00       	call   158 <fb_video_setup+0x100>
		framebuffer_redraw(&fb_initial);
     158:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     15f:	e8 00 00 00 00       	call   164 <fb_video_setup+0x10c>
}
     164:	90                   	nop
     165:	c9                   	leave
     166:	c3                   	ret

0000000000000167 <framebuffer_initialize>:
{
     167:	55                   	push   rbp
     168:	48 89 e5             	mov    rbp,rsp
     16b:	48 83 ec 28          	sub    rsp,0x28
     16f:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
     173:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
     177:	48 89 55 e8          	mov    QWORD PTR [rbp-0x18],rdx
     17b:	89 4d e4             	mov    DWORD PTR [rbp-0x1c],ecx
     17e:	44 89 45 e0          	mov    DWORD PTR [rbp-0x20],r8d
     182:	44 89 4d dc          	mov    DWORD PTR [rbp-0x24],r9d
		fb->text_mem = textmem;
     186:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     18a:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     18e:	48 89 10             	mov    QWORD PTR [rax],rdx
		fb->font = font;
     191:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     195:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     199:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
		fb->width = width;
     19d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1a1:	8b 55 e4             	mov    edx,DWORD PTR [rbp-0x1c]
     1a4:	89 50 08             	mov    DWORD PTR [rax+0x8],edx
		fb->height = height;
     1a7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1ab:	8b 55 e0             	mov    edx,DWORD PTR [rbp-0x20]
     1ae:	89 50 0c             	mov    DWORD PTR [rax+0xc],edx
		fb->is_visible = 1;
     1b1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1b5:	c7 40 18 01 00 00 00 	mov    DWORD PTR [rax+0x18],0x1
		fb->cur_x = fb->cur_y = 0;
     1bc:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1c0:	c7 40 20 00 00 00 00 	mov    DWORD PTR [rax+0x20],0x0
     1c7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1cb:	8b 50 20             	mov    edx,DWORD PTR [rax+0x20]
     1ce:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1d2:	89 50 1c             	mov    DWORD PTR [rax+0x1c],edx
		fb->pix_x = pxl_ofs_x;
     1d5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1d9:	8b 55 dc             	mov    edx,DWORD PTR [rbp-0x24]
     1dc:	89 50 24             	mov    DWORD PTR [rax+0x24],edx
		fb->pix_y = pxl_ofs_y;
     1df:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1e3:	8b 55 10             	mov    edx,DWORD PTR [rbp+0x10]
     1e6:	89 50 28             	mov    DWORD PTR [rax+0x28],edx
		fb->cho_x = char_ofs_x;
     1e9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1ed:	8b 55 18             	mov    edx,DWORD PTR [rbp+0x18]
     1f0:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
		fb->cho_y = char_ofs_y;
     1f3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1f7:	8b 55 20             	mov    edx,DWORD PTR [rbp+0x20]
     1fa:	89 50 30             	mov    DWORD PTR [rax+0x30],edx
		fb->chw_x = char_width_x;
     1fd:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     201:	8b 55 28             	mov    edx,DWORD PTR [rbp+0x28]
     204:	89 50 34             	mov    DWORD PTR [rax+0x34],edx
		fb->chw_y = char_width_y;
     207:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     20b:	8b 55 30             	mov    edx,DWORD PTR [rbp+0x30]
     20e:	89 50 38             	mov    DWORD PTR [rax+0x38],edx
		fb->r_ud = NULL;
     211:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     215:	48 c7 40 40 00 00 00 00 	mov    QWORD PTR [rax+0x40],0x0
		fb->r_excl = NULL;
     21d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     221:	48 c7 40 48 00 00 00 00 	mov    QWORD PTR [rax+0x48],0x0
}
     229:	90                   	nop
     22a:	c9                   	leave
     22b:	c3                   	ret

000000000000022c <framebuffer_add_exclude_rect>:
{
     22c:	55                   	push   rbp
     22d:	48 89 e5             	mov    rbp,rsp
     230:	48 83 ec 10          	sub    rsp,0x10
     234:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
     238:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
		if (!r)
     23c:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
     241:	74 3b                	je     27e <framebuffer_add_exclude_rect+0x52>
				r->next = fb->r_excl;
     243:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     247:	48 8b 50 48          	mov    rdx,QWORD PTR [rax+0x48]
     24b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     24f:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
		} while (!__sync_bool_compare_and_swap(&fb->r_excl, r->next, r));
     253:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     257:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     25b:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
     25f:	48 89 c6             	mov    rsi,rax
     262:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     266:	48 8d 48 48          	lea    rcx,[rax+0x48]
     26a:	48 89 f0             	mov    rax,rsi
     26d:	f0 48 0f b1 11       	lock cmpxchg QWORD PTR [rcx],rdx
     272:	0f 94 c0             	sete   al
     275:	83 f0 01             	xor    eax,0x1
     278:	84 c0                	test   al,al
     27a:	75 c7                	jne    243 <framebuffer_add_exclude_rect+0x17>
     27c:	eb 01                	jmp    27f <framebuffer_add_exclude_rect+0x53>
				return;
     27e:	90                   	nop
}
     27f:	c9                   	leave
     280:	c3                   	ret

0000000000000281 <framebuffer_remove_exclude_rect>:
{
     281:	55                   	push   rbp
     282:	48 89 e5             	mov    rbp,rsp
     285:	48 83 ec 20          	sub    rsp,0x20
     289:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
     28d:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
		er = &fb->r_excl;
     291:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     295:	48 83 c0 48          	add    rax,0x48
     299:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		while ((r2 = *er)) {
     29d:	eb 37                	jmp    2d6 <framebuffer_remove_exclude_rect+0x55>
				if (r2 == r) {
     29f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     2a3:	48 3b 45 e0          	cmp    rax,QWORD PTR [rbp-0x20]
     2a7:	75 21                	jne    2ca <framebuffer_remove_exclude_rect+0x49>
						if (__sync_bool_compare_and_swap(er, r, r->next))
     2a9:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     2ad:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
     2b1:	48 89 c1             	mov    rcx,rax
     2b4:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     2b8:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     2bc:	f0 48 0f b1 0a       	lock cmpxchg QWORD PTR [rdx],rcx
     2c1:	0f 94 c0             	sete   al
     2c4:	84 c0                	test   al,al
     2c6:	75 22                	jne    2ea <framebuffer_remove_exclude_rect+0x69>
								goto Pos1;
     2c8:	eb c7                	jmp    291 <framebuffer_remove_exclude_rect+0x10>
				er = &r2->next;
     2ca:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     2ce:	48 83 c0 10          	add    rax,0x10
     2d2:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		while ((r2 = *er)) {
     2d6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     2da:	48 8b 00             	mov    rax,QWORD PTR [rax]
     2dd:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
     2e1:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
     2e6:	75 b7                	jne    29f <framebuffer_remove_exclude_rect+0x1e>
     2e8:	eb 01                	jmp    2eb <framebuffer_remove_exclude_rect+0x6a>
								return;
     2ea:	90                   	nop
}
     2eb:	c9                   	leave
     2ec:	c3                   	ret

00000000000002ed <get_tm_color>:
{
     2ed:	55                   	push   rbp
     2ee:	48 89 e5             	mov    rbp,rsp
     2f1:	48 83 ec 20          	sub    rsp,0x20
     2f5:	89 f9                	mov    ecx,edi
     2f7:	89 f0                	mov    eax,esi
     2f9:	89 55 e4             	mov    DWORD PTR [rbp-0x1c],edx
     2fc:	89 ca                	mov    edx,ecx
     2fe:	88 55 ec             	mov    BYTE PTR [rbp-0x14],dl
     301:	88 45 e8             	mov    BYTE PTR [rbp-0x18],al
		switch (btpp) {
     304:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     307:	83 e8 04             	sub    eax,0x4
     30a:	83 f8 1c             	cmp    eax,0x1c
     30d:	0f 87 1b 01 00 00    	ja     42e <get_tm_color+0x141>
     313:	89 c0                	mov    eax,eax
     315:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
     31d:	ff e0                	jmp    rax
						if (is_set)
     31f:	80 7d e8 00          	cmp    BYTE PTR [rbp-0x18],0x0
     323:	74 0c                	je     331 <get_tm_color+0x44>
								return col & 0x0f;
     325:	0f be 45 ec          	movsx  eax,BYTE PTR [rbp-0x14]
     329:	83 e0 0f             	and    eax,0xf
     32c:	e9 02 01 00 00       	jmp    433 <get_tm_color+0x146>
								return (col >> 4) & 0x0f;
     331:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
     335:	c0 f8 04             	sar    al,0x4
     338:	0f be c0             	movsx  eax,al
     33b:	83 e0 0f             	and    eax,0xf
     33e:	e9 f0 00 00 00       	jmp    433 <get_tm_color+0x146>
						if (is_set)
     343:	80 7d e8 00          	cmp    BYTE PTR [rbp-0x18],0x0
     347:	74 0c                	je     355 <get_tm_color+0x68>
								return col & 0x0f;
     349:	0f be 45 ec          	movsx  eax,BYTE PTR [rbp-0x14]
     34d:	83 e0 0f             	and    eax,0xf
     350:	e9 de 00 00 00       	jmp    433 <get_tm_color+0x146>
								return (col >> 4) & 0x0f;
     355:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
     359:	c0 f8 04             	sar    al,0x4
     35c:	0f be c0             	movsx  eax,al
     35f:	83 e0 0f             	and    eax,0xf
     362:	e9 cc 00 00 00       	jmp    433 <get_tm_color+0x146>
						if (is_set)
     367:	80 7d e8 00          	cmp    BYTE PTR [rbp-0x18],0x0
     36b:	74 15                	je     382 <get_tm_color+0x95>
								iv = palette_32[col & 0x0f];
     36d:	0f be 45 ec          	movsx  eax,BYTE PTR [rbp-0x14]
     371:	83 e0 0f             	and    eax,0xf
     374:	48 98                	cdqe
     376:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [rax*4+0x0]
     37d:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
     380:	eb 19                	jmp    39b <get_tm_color+0xae>
								iv = palette_32[(col >> 4) & 0x0f];
     382:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
     386:	c0 f8 04             	sar    al,0x4
     389:	0f be c0             	movsx  eax,al
     38c:	83 e0 0f             	and    eax,0xf
     38f:	48 98                	cdqe
     391:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [rax*4+0x0]
     398:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
						if (btpp == 15)
     39b:	83 7d e4 0f          	cmp    DWORD PTR [rbp-0x1c],0xf
     39f:	75 2d                	jne    3ce <get_tm_color+0xe1>
								rv = (iv.b >> 3) | ((iv.g >> 3) << 5) | ((iv.r >> 3) << 10);
     3a1:	0f b6 45 f8          	movzx  eax,BYTE PTR [rbp-0x8]
     3a5:	c0 e8 03             	shr    al,0x3
     3a8:	0f b6 c0             	movzx  eax,al
     3ab:	0f b6 55 f9          	movzx  edx,BYTE PTR [rbp-0x7]
     3af:	c0 ea 03             	shr    dl,0x3
     3b2:	0f b6 d2             	movzx  edx,dl
     3b5:	c1 e2 05             	shl    edx,0x5
     3b8:	09 c2                	or     edx,eax
     3ba:	0f b6 45 fa          	movzx  eax,BYTE PTR [rbp-0x6]
     3be:	c0 e8 03             	shr    al,0x3
     3c1:	0f b6 c0             	movzx  eax,al
     3c4:	c1 e0 0a             	shl    eax,0xa
     3c7:	09 d0                	or     eax,edx
     3c9:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
     3cc:	eb 2b                	jmp    3f9 <get_tm_color+0x10c>
								rv = (iv.b >> 3) | ((iv.g >> 2) << 5) | ((iv.r >> 3) << 11);
     3ce:	0f b6 45 f8          	movzx  eax,BYTE PTR [rbp-0x8]
     3d2:	c0 e8 03             	shr    al,0x3
     3d5:	0f b6 c0             	movzx  eax,al
     3d8:	0f b6 55 f9          	movzx  edx,BYTE PTR [rbp-0x7]
     3dc:	c0 ea 02             	shr    dl,0x2
     3df:	0f b6 d2             	movzx  edx,dl
     3e2:	c1 e2 05             	shl    edx,0x5
     3e5:	09 c2                	or     edx,eax
     3e7:	0f b6 45 fa          	movzx  eax,BYTE PTR [rbp-0x6]
     3eb:	c0 e8 03             	shr    al,0x3
     3ee:	0f b6 c0             	movzx  eax,al
     3f1:	c1 e0 0b             	shl    eax,0xb
     3f4:	09 d0                	or     eax,edx
     3f6:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
						return rv;
     3f9:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     3fc:	eb 35                	jmp    433 <get_tm_color+0x146>
						if (is_set)
     3fe:	80 7d e8 00          	cmp    BYTE PTR [rbp-0x18],0x0
     402:	74 12                	je     416 <get_tm_color+0x129>
								return palette_32[col & 0x0f].val;
     404:	0f be 45 ec          	movsx  eax,BYTE PTR [rbp-0x14]
     408:	83 e0 0f             	and    eax,0xf
     40b:	48 98                	cdqe
     40d:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [rax*4+0x0]
     414:	eb 1d                	jmp    433 <get_tm_color+0x146>
								return palette_32[(col >> 4) & 0x0f].val;
     416:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
     41a:	c0 f8 04             	sar    al,0x4
     41d:	0f be c0             	movsx  eax,al
     420:	83 e0 0f             	and    eax,0xf
     423:	48 98                	cdqe
     425:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [rax*4+0x0]
     42c:	eb 05                	jmp    433 <get_tm_color+0x146>
		return 0x2f0c0c2f; /* canary */
     42e:	b8 2f 0c 0c 2f       	mov    eax,0x2f0c0c2f
}
     433:	c9                   	leave
     434:	c3                   	ret

0000000000000435 <generate_char_colors>:
{
     435:	55                   	push   rbp
     436:	48 89 e5             	mov    rbp,rsp
     439:	48 83 ec 30          	sub    rsp,0x30
     43d:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
     441:	89 d0                	mov    eax,edx
     443:	48 89 4d d8          	mov    QWORD PTR [rbp-0x28],rcx
     447:	44 89 45 d4          	mov    DWORD PTR [rbp-0x2c],r8d
     44b:	44 89 4d d0          	mov    DWORD PTR [rbp-0x30],r9d
     44f:	89 f2                	mov    edx,esi
     451:	88 55 e4             	mov    BYTE PTR [rbp-0x1c],dl
     454:	88 45 e0             	mov    BYTE PTR [rbp-0x20],al
		int rv = 0;
     457:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		uint8_t f = (uint8_t)font[c * 16];
     45e:	0f be 45 e4          	movsx  eax,BYTE PTR [rbp-0x1c]
     462:	c1 e0 04             	shl    eax,0x4
     465:	48 63 d0             	movsxd rdx,eax
     468:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     46c:	48 01 d0             	add    rax,rdx
     46f:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     472:	88 45 f7             	mov    BYTE PTR [rbp-0x9],al
		for (; r < rmax; r++) {
     475:	e9 13 01 00 00       	jmp    58d <generate_char_colors+0x158>
				int is_set = f & (1 << (7 - r));
     47a:	0f b6 55 f7          	movzx  edx,BYTE PTR [rbp-0x9]
     47e:	b8 07 00 00 00       	mov    eax,0x7
     483:	2b 45 d4             	sub    eax,DWORD PTR [rbp-0x2c]
     486:	be 01 00 00 00       	mov    esi,0x1
     48b:	89 c1                	mov    ecx,eax
     48d:	d3 e6                	shl    esi,cl
     48f:	89 f0                	mov    eax,esi
     491:	21 d0                	and    eax,edx
     493:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
				if (inv)
     496:	83 7d 18 00          	cmp    DWORD PTR [rbp+0x18],0x0
     49a:	74 0d                	je     4a9 <generate_char_colors+0x74>
						is_set = !is_set;
     49c:	83 7d f8 00          	cmp    DWORD PTR [rbp-0x8],0x0
     4a0:	0f 94 c0             	sete   al
     4a3:	0f b6 c0             	movzx  eax,al
     4a6:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
				cv = get_tm_color(fmt, is_set, btpp);
     4a9:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     4ad:	89 c2                	mov    edx,eax
     4af:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
     4b2:	0f be c8             	movsx  ecx,al
     4b5:	0f be 45 e0          	movsx  eax,BYTE PTR [rbp-0x20]
     4b9:	89 ce                	mov    esi,ecx
     4bb:	89 c7                	mov    edi,eax
     4bd:	e8 00 00 00 00       	call   4c2 <generate_char_colors+0x8d>
     4c2:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
				switch (btpp) {
     4c5:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     4c9:	48 83 e8 04          	sub    rax,0x4
     4cd:	48 83 f8 1c          	cmp    rax,0x1c
     4d1:	0f 87 b2 00 00 00    	ja     589 <generate_char_colors+0x154>
     4d7:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
     4df:	ff e0                	jmp    rax
								*(uint32_t*)cvs = (uint32_t)cv;
     4e1:	48 8b 45 10          	mov    rax,QWORD PTR [rbp+0x10]
     4e5:	8b 55 f0             	mov    edx,DWORD PTR [rbp-0x10]
     4e8:	89 10                	mov    DWORD PTR [rax],edx
								cvs += 4; rv += 32;
     4ea:	48 83 45 10 04       	add    QWORD PTR [rbp+0x10],0x4
     4ef:	83 45 fc 20          	add    DWORD PTR [rbp-0x4],0x20
								break;
     4f3:	e9 91 00 00 00       	jmp    589 <generate_char_colors+0x154>
								*(uint16_t*)cvs = (uint16_t)(cv & 0xffff);
     4f8:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     4fb:	89 c2                	mov    edx,eax
     4fd:	48 8b 45 10          	mov    rax,QWORD PTR [rbp+0x10]
     501:	66 89 10             	mov    WORD PTR [rax],dx
								cvs += 2;
     504:	48 83 45 10 02       	add    QWORD PTR [rbp+0x10],0x2
								*(uint8_t*)cvs++ = (uint8_t)(cv >> 16);
     509:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     50c:	c1 e8 10             	shr    eax,0x10
     50f:	89 c1                	mov    ecx,eax
     511:	48 8b 45 10          	mov    rax,QWORD PTR [rbp+0x10]
     515:	48 8d 50 01          	lea    rdx,[rax+0x1]
     519:	48 89 55 10          	mov    QWORD PTR [rbp+0x10],rdx
     51d:	89 ca                	mov    edx,ecx
     51f:	88 10                	mov    BYTE PTR [rax],dl
								rv += 24;
     521:	83 45 fc 18          	add    DWORD PTR [rbp-0x4],0x18
								break;
     525:	eb 62                	jmp    589 <generate_char_colors+0x154>
								*(uint16_t*)cvs = (uint16_t)cv;
     527:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     52a:	89 c2                	mov    edx,eax
     52c:	48 8b 45 10          	mov    rax,QWORD PTR [rbp+0x10]
     530:	66 89 10             	mov    WORD PTR [rax],dx
								cvs += 2; rv += 16; /* even for 15 */
     533:	48 83 45 10 02       	add    QWORD PTR [rbp+0x10],0x2
     538:	83 45 fc 10          	add    DWORD PTR [rbp-0x4],0x10
								break;
     53c:	eb 4b                	jmp    589 <generate_char_colors+0x154>
								*cvs++ = (uint8_t)cv; rv += 8;
     53e:	48 8b 45 10          	mov    rax,QWORD PTR [rbp+0x10]
     542:	48 8d 50 01          	lea    rdx,[rax+0x1]
     546:	48 89 55 10          	mov    QWORD PTR [rbp+0x10],rdx
     54a:	8b 55 f0             	mov    edx,DWORD PTR [rbp-0x10]
     54d:	88 10                	mov    BYTE PTR [rax],dl
     54f:	83 45 fc 08          	add    DWORD PTR [rbp-0x4],0x8
								break;
     553:	eb 34                	jmp    589 <generate_char_colors+0x154>
								rv += 4;
     555:	83 45 fc 04          	add    DWORD PTR [rbp-0x4],0x4
								die("also complicated!\n");
     559:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     560:	bf 0c 00 00 00       	mov    edi,0xc
     565:	b8 00 00 00 00       	mov    eax,0x0
     56a:	e8 00 00 00 00       	call   56f <generate_char_colors+0x13a>
     56f:	b8 00 00 00 00       	mov    eax,0x0
     574:	e8 00 00 00 00       	call   579 <generate_char_colors+0x144>
     579:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     580:	e8 00 00 00 00       	call   585 <generate_char_colors+0x150>
     585:	fa                   	cli
     586:	f4                   	hlt
     587:	eb fd                	jmp    586 <generate_char_colors+0x151>
		for (; r < rmax; r++) {
     589:	83 45 d4 01          	add    DWORD PTR [rbp-0x2c],0x1
     58d:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
     590:	3b 45 d0             	cmp    eax,DWORD PTR [rbp-0x30]
     593:	0f 8c e1 fe ff ff    	jl     47a <generate_char_colors+0x45>
		return rv;
     599:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
     59c:	c9                   	leave
     59d:	c3                   	ret

000000000000059e <render_text_scanline_32btpp_sse>:
{
     59e:	55                   	push   rbp
     59f:	48 89 e5             	mov    rbp,rsp
     5a2:	48 81 ec b0 00 00 00 	sub    rsp,0xb0
     5a9:	48 89 bd 78 ff ff ff 	mov    QWORD PTR [rbp-0x88],rdi
     5b0:	48 89 b5 70 ff ff ff 	mov    QWORD PTR [rbp-0x90],rsi
     5b7:	48 89 95 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rdx
     5be:	89 8d 64 ff ff ff    	mov    DWORD PTR [rbp-0x9c],ecx
     5c4:	44 89 85 60 ff ff ff 	mov    DWORD PTR [rbp-0xa0],r8d
     5cb:	44 89 8d 5c ff ff ff 	mov    DWORD PTR [rbp-0xa4],r9d
		ssize_t misalign = ((size_t)mem % 16) ? (16 - (size_t)mem % 16) : 0;
     5d2:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     5d9:	83 e0 0f             	and    eax,0xf
     5dc:	48 85 c0             	test   rax,rax
     5df:	74 15                	je     5f6 <render_text_scanline_32btpp_sse+0x58>
     5e1:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     5e8:	83 e0 0f             	and    eax,0xf
     5eb:	ba 10 00 00 00       	mov    edx,0x10
     5f0:	29 c2                	sub    edx,eax
     5f2:	89 d0                	mov    eax,edx
     5f4:	eb 05                	jmp    5fb <render_text_scanline_32btpp_sse+0x5d>
     5f6:	b8 00 00 00 00       	mov    eax,0x0
     5fb:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
		ssize_t r = p0_x % 8;
     5fe:	8b 95 5c ff ff ff    	mov    edx,DWORD PTR [rbp-0xa4]
     604:	89 d0                	mov    eax,edx
     606:	c1 f8 1f             	sar    eax,0x1f
     609:	c1 e8 1d             	shr    eax,0x1d
     60c:	01 c2                	add    edx,eax
     60e:	83 e2 07             	and    edx,0x7
     611:	29 c2                	sub    edx,eax
     613:	89 55 e8             	mov    DWORD PTR [rbp-0x18],edx
		uint8_t* pixbuf = pxb + (((size_t)pxb % 16) ? (16 - ((size_t)pxb % 16)) : 0);
     616:	48 8d 45 90          	lea    rax,[rbp-0x70]
     61a:	83 e0 0f             	and    eax,0xf
     61d:	48 85 c0             	test   rax,rax
     620:	74 14                	je     636 <render_text_scanline_32btpp_sse+0x98>
     622:	48 8d 45 90          	lea    rax,[rbp-0x70]
     626:	83 e0 0f             	and    eax,0xf
     629:	48 89 c2             	mov    rdx,rax
     62c:	b8 10 00 00 00       	mov    eax,0x10
     631:	48 29 d0             	sub    rax,rdx
     634:	eb 05                	jmp    63b <render_text_scanline_32btpp_sse+0x9d>
     636:	b8 00 00 00 00       	mov    eax,0x0
     63b:	48 8d 55 90          	lea    rdx,[rbp-0x70]
     63f:	48 01 d0             	add    rax,rdx
     642:	48 89 45 88          	mov    QWORD PTR [rbp-0x78],rax
		if (misalign) { /* LFB is dword aligned, we want (dq/o)word access */
     646:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
     64a:	0f 84 02 04 00 00    	je     a52 <render_text_scanline_32btpp_sse+0x4b4>
				int col = p0_x / 8, inv = (col == cur_x);
     650:	8b 85 5c ff ff ff    	mov    eax,DWORD PTR [rbp-0xa4]
     656:	8d 50 07             	lea    edx,[rax+0x7]
     659:	85 c0                	test   eax,eax
     65b:	0f 48 c2             	cmovs  eax,edx
     65e:	c1 f8 03             	sar    eax,0x3
     661:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
     664:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     667:	3b 85 60 ff ff ff    	cmp    eax,DWORD PTR [rbp-0xa0]
     66d:	0f 94 c0             	sete   al
     670:	0f b6 c0             	movzx  eax,al
     673:	89 45 e0             	mov    DWORD PTR [rbp-0x20],eax
				ssize_t bc = min(misalign, 4 * px_x);
     676:	8b 85 64 ff ff ff    	mov    eax,DWORD PTR [rbp-0x9c]
     67c:	c1 e0 02             	shl    eax,0x2
     67f:	8b 55 ec             	mov    edx,DWORD PTR [rbp-0x14]
     682:	39 c2                	cmp    edx,eax
     684:	0f 4e c2             	cmovle eax,edx
     687:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
				ssize_t cc = rdiv(misalign, 4);
     68a:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     68d:	8d 50 03             	lea    edx,[rax+0x3]
     690:	85 c0                	test   eax,eax
     692:	0f 48 c2             	cmovs  eax,edx
     695:	c1 f8 02             	sar    eax,0x2
     698:	89 c2                	mov    edx,eax
     69a:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     69d:	83 e0 03             	and    eax,0x3
     6a0:	85 c0                	test   eax,eax
     6a2:	0f 95 c0             	setne  al
     6a5:	0f b6 c0             	movzx  eax,al
     6a8:	01 d0                	add    eax,edx
     6aa:	89 45 d8             	mov    DWORD PTR [rbp-0x28],eax
				ssize_t rmax = min(8, r + cc), cc1 = rmax - r;
     6ad:	8b 55 e8             	mov    edx,DWORD PTR [rbp-0x18]
     6b0:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
     6b3:	01 d0                	add    eax,edx
     6b5:	ba 08 00 00 00       	mov    edx,0x8
     6ba:	39 d0                	cmp    eax,edx
     6bc:	0f 4f c2             	cmovg  eax,edx
     6bf:	89 45 d4             	mov    DWORD PTR [rbp-0x2c],eax
     6c2:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
     6c5:	2b 45 e8             	sub    eax,DWORD PTR [rbp-0x18]
     6c8:	89 45 d0             	mov    DWORD PTR [rbp-0x30],eax
				generate_char_colors(font, str[0], str[1], 32,
     6cb:	48 8b 4d 88          	mov    rcx,QWORD PTR [rbp-0x78]
     6cf:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     6d6:	48 83 c0 01          	add    rax,0x1
     6da:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     6dd:	0f be d0             	movsx  edx,al
     6e0:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     6e7:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     6ea:	0f be f0             	movsx  esi,al
     6ed:	44 8b 4d d4          	mov    r9d,DWORD PTR [rbp-0x2c]
     6f1:	44 8b 45 e8          	mov    r8d,DWORD PTR [rbp-0x18]
     6f5:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     6fc:	8b 7d e0             	mov    edi,DWORD PTR [rbp-0x20]
     6ff:	57                   	push   rdi
     700:	51                   	push   rcx
     701:	b9 20 00 00 00       	mov    ecx,0x20
     706:	48 89 c7             	mov    rdi,rax
     709:	e8 00 00 00 00       	call   70e <render_text_scanline_32btpp_sse+0x170>
     70e:	48 83 c4 10          	add    rsp,0x10
				if (rmax == 8)
     712:	83 7d d4 08          	cmp    DWORD PTR [rbp-0x2c],0x8
     716:	75 08                	jne    720 <render_text_scanline_32btpp_sse+0x182>
						str += 2;
     718:	48 83 85 70 ff ff ff 02 	add    QWORD PTR [rbp-0x90],0x2
				if (cc > cc1) { /* generate the new char */
     720:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
     723:	3b 45 d0             	cmp    eax,DWORD PTR [rbp-0x30]
     726:	7e 73                	jle    79b <render_text_scanline_32btpp_sse+0x1fd>
						col++; inv = (col == cur_x);
     728:	83 45 e4 01          	add    DWORD PTR [rbp-0x1c],0x1
     72c:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     72f:	3b 85 60 ff ff ff    	cmp    eax,DWORD PTR [rbp-0xa0]
     735:	0f 94 c0             	sete   al
     738:	0f b6 c0             	movzx  eax,al
     73b:	89 45 e0             	mov    DWORD PTR [rbp-0x20],eax
						generate_char_colors(font, str[0], str[1], 32,
     73e:	48 8b 55 88          	mov    rdx,QWORD PTR [rbp-0x78]
										0, cc - cc1, pixbuf + cc1 * 4, inv);
     742:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
     745:	c1 e0 02             	shl    eax,0x2
     748:	48 98                	cdqe
						generate_char_colors(font, str[0], str[1], 32,
     74a:	48 8d 3c 02          	lea    rdi,[rdx+rax*1]
     74e:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
     751:	2b 45 d0             	sub    eax,DWORD PTR [rbp-0x30]
     754:	41 89 c0             	mov    r8d,eax
     757:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     75e:	48 83 c0 01          	add    rax,0x1
     762:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     765:	0f be d0             	movsx  edx,al
     768:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     76f:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     772:	0f be f0             	movsx  esi,al
     775:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     77c:	8b 4d e0             	mov    ecx,DWORD PTR [rbp-0x20]
     77f:	51                   	push   rcx
     780:	57                   	push   rdi
     781:	45 89 c1             	mov    r9d,r8d
     784:	41 b8 00 00 00 00    	mov    r8d,0x0
     78a:	b9 20 00 00 00       	mov    ecx,0x20
     78f:	48 89 c7             	mov    rdi,rax
     792:	e8 00 00 00 00       	call   797 <render_text_scanline_32btpp_sse+0x1f9>
     797:	48 83 c4 10          	add    rsp,0x10
				memcpy(mem, pixbuf, bc);
     79b:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
     79e:	48 63 d0             	movsxd rdx,eax
     7a1:	48 8b 4d 88          	mov    rcx,QWORD PTR [rbp-0x78]
     7a5:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     7ac:	48 89 ce             	mov    rsi,rcx
     7af:	48 89 c7             	mov    rdi,rax
     7b2:	e8 49 f8 ff ff       	call   0 <memcpy>
				px_x -= cc;
     7b7:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
     7ba:	29 85 64 ff ff ff    	sub    DWORD PTR [rbp-0x9c],eax
				p0_x += cc;
     7c0:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
     7c3:	01 85 5c ff ff ff    	add    DWORD PTR [rbp-0xa4],eax
				mem += bc;
     7c9:	48 8b 95 68 ff ff ff 	mov    rdx,QWORD PTR [rbp-0x98]
     7d0:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
     7d3:	48 98                	cdqe
     7d5:	48 01 d0             	add    rax,rdx
     7d8:	48 89 85 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rax
		while (px_x) {
     7df:	e9 6e 02 00 00       	jmp    a52 <render_text_scanline_32btpp_sse+0x4b4>
				int col = p0_x / 8, inv = (col == cur_x);
     7e4:	8b 85 5c ff ff ff    	mov    eax,DWORD PTR [rbp-0xa4]
     7ea:	8d 50 07             	lea    edx,[rax+0x7]
     7ed:	85 c0                	test   eax,eax
     7ef:	0f 48 c2             	cmovs  eax,edx
     7f2:	c1 f8 03             	sar    eax,0x3
     7f5:	89 45 cc             	mov    DWORD PTR [rbp-0x34],eax
     7f8:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
     7fb:	3b 85 60 ff ff ff    	cmp    eax,DWORD PTR [rbp-0xa0]
     801:	0f 94 c0             	sete   al
     804:	0f b6 c0             	movzx  eax,al
     807:	89 45 c8             	mov    DWORD PTR [rbp-0x38],eax
				ssize_t rmax, bitc, btt = min(128, 32 * px_x);
     80a:	8b 85 64 ff ff ff    	mov    eax,DWORD PTR [rbp-0x9c]
     810:	c1 e0 05             	shl    eax,0x5
     813:	ba 80 00 00 00       	mov    edx,0x80
     818:	39 d0                	cmp    eax,edx
     81a:	0f 4f c2             	cmovg  eax,edx
     81d:	89 45 c4             	mov    DWORD PTR [rbp-0x3c],eax
				r = p0_x % 8;
     820:	8b 95 5c ff ff ff    	mov    edx,DWORD PTR [rbp-0xa4]
     826:	89 d0                	mov    eax,edx
     828:	c1 f8 1f             	sar    eax,0x1f
     82b:	c1 e8 1d             	shr    eax,0x1d
     82e:	01 c2                	add    edx,eax
     830:	83 e2 07             	and    edx,0x7
     833:	29 c2                	sub    edx,eax
     835:	89 55 e8             	mov    DWORD PTR [rbp-0x18],edx
				rmax = min(8, r + min(4, px_x)); /* only 4 pixels */
     838:	8b 85 64 ff ff ff    	mov    eax,DWORD PTR [rbp-0x9c]
     83e:	ba 04 00 00 00       	mov    edx,0x4
     843:	39 d0                	cmp    eax,edx
     845:	0f 4e d0             	cmovle edx,eax
     848:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
     84b:	01 d0                	add    eax,edx
     84d:	ba 08 00 00 00       	mov    edx,0x8
     852:	39 d0                	cmp    eax,edx
     854:	0f 4f c2             	cmovg  eax,edx
     857:	89 45 c0             	mov    DWORD PTR [rbp-0x40],eax
				bitc = generate_char_colors(font, str[0], str[1], 32,
     85a:	48 8b 4d 88          	mov    rcx,QWORD PTR [rbp-0x78]
     85e:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     865:	48 83 c0 01          	add    rax,0x1
     869:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     86c:	0f be d0             	movsx  edx,al
     86f:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     876:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     879:	0f be f0             	movsx  esi,al
     87c:	44 8b 4d c0          	mov    r9d,DWORD PTR [rbp-0x40]
     880:	44 8b 45 e8          	mov    r8d,DWORD PTR [rbp-0x18]
     884:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     88b:	8b 7d c8             	mov    edi,DWORD PTR [rbp-0x38]
     88e:	57                   	push   rdi
     88f:	51                   	push   rcx
     890:	b9 20 00 00 00       	mov    ecx,0x20
     895:	48 89 c7             	mov    rdi,rax
     898:	e8 00 00 00 00       	call   89d <render_text_scanline_32btpp_sse+0x2ff>
     89d:	48 83 c4 10          	add    rsp,0x10
     8a1:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
				if (rmax == 8)
     8a4:	83 7d c0 08          	cmp    DWORD PTR [rbp-0x40],0x8
     8a8:	75 08                	jne    8b2 <render_text_scanline_32btpp_sse+0x314>
						str += 2;
     8aa:	48 83 85 70 ff ff ff 02 	add    QWORD PTR [rbp-0x90],0x2
				if (bitc < btt) {
     8b2:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     8b5:	3b 45 c4             	cmp    eax,DWORD PTR [rbp-0x3c]
     8b8:	0f 8d 8d 00 00 00    	jge    94b <render_text_scanline_32btpp_sse+0x3ad>
						col++; int pc = (btt - bitc) / 32;
     8be:	83 45 cc 01          	add    DWORD PTR [rbp-0x34],0x1
     8c2:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
     8c5:	2b 45 fc             	sub    eax,DWORD PTR [rbp-0x4]
     8c8:	8d 50 1f             	lea    edx,[rax+0x1f]
     8cb:	85 c0                	test   eax,eax
     8cd:	0f 48 c2             	cmovs  eax,edx
     8d0:	c1 f8 05             	sar    eax,0x5
     8d3:	89 45 bc             	mov    DWORD PTR [rbp-0x44],eax
						inv = (col == cur_x);
     8d6:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
     8d9:	3b 85 60 ff ff ff    	cmp    eax,DWORD PTR [rbp-0xa0]
     8df:	0f 94 c0             	sete   al
     8e2:	0f b6 c0             	movzx  eax,al
     8e5:	89 45 c8             	mov    DWORD PTR [rbp-0x38],eax
						bitc += generate_char_colors(font, str[0], str[1], 32,
     8e8:	48 8b 55 88          	mov    rdx,QWORD PTR [rbp-0x78]
										0, pc, pixbuf + bitc / 32, inv);
     8ec:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     8ef:	8d 48 1f             	lea    ecx,[rax+0x1f]
     8f2:	85 c0                	test   eax,eax
     8f4:	0f 48 c1             	cmovs  eax,ecx
     8f7:	c1 f8 05             	sar    eax,0x5
     8fa:	48 98                	cdqe
						bitc += generate_char_colors(font, str[0], str[1], 32,
     8fc:	48 8d 3c 02          	lea    rdi,[rdx+rax*1]
     900:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     907:	48 83 c0 01          	add    rax,0x1
     90b:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     90e:	0f be d0             	movsx  edx,al
     911:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     918:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     91b:	0f be f0             	movsx  esi,al
     91e:	44 8b 45 bc          	mov    r8d,DWORD PTR [rbp-0x44]
     922:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     929:	8b 4d c8             	mov    ecx,DWORD PTR [rbp-0x38]
     92c:	51                   	push   rcx
     92d:	57                   	push   rdi
     92e:	45 89 c1             	mov    r9d,r8d
     931:	41 b8 00 00 00 00    	mov    r8d,0x0
     937:	b9 20 00 00 00       	mov    ecx,0x20
     93c:	48 89 c7             	mov    rdi,rax
     93f:	e8 00 00 00 00       	call   944 <render_text_scanline_32btpp_sse+0x3a6>
     944:	48 83 c4 10          	add    rsp,0x10
     948:	01 45 fc             	add    DWORD PTR [rbp-0x4],eax
				if (bitc >= 128) {
     94b:	83 7d fc 7f          	cmp    DWORD PTR [rbp-0x4],0x7f
     94f:	7e 35                	jle    986 <render_text_scanline_32btpp_sse+0x3e8>
						move_128(pixbuf, mem);
     951:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
     955:	48 8b 95 68 ff ff ff 	mov    rdx,QWORD PTR [rbp-0x98]
     95c:	0f 28 00             	movaps xmm0,XMMWORD PTR [rax]
     95f:	0f 29 02             	movaps XMMWORD PTR [rdx],xmm0
						mem += 16; /* intentionally no bitc subtract */
     962:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     969:	48 83 c0 10          	add    rax,0x10
     96d:	48 89 85 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rax
				if (px_x) {
     974:	83 bd 64 ff ff ff 00 	cmp    DWORD PTR [rbp-0x9c],0x0
     97b:	0f 84 e0 00 00 00    	je     a61 <render_text_scanline_32btpp_sse+0x4c3>
     981:	e9 a2 00 00 00       	jmp    a28 <render_text_scanline_32btpp_sse+0x48a>
						uint8_t* pt = pixbuf;
     986:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
     98a:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
						if (bitc >= 64) {
     98e:	83 7d fc 3f          	cmp    DWORD PTR [rbp-0x4],0x3f
     992:	7e 2c                	jle    9c0 <render_text_scanline_32btpp_sse+0x422>
								move_64(pixbuf, mem);
     994:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
     998:	48 8b 95 68 ff ff ff 	mov    rdx,QWORD PTR [rbp-0x98]
     99f:	0f 6f 00             	movq   mm0,QWORD PTR [rax]
     9a2:	0f 7f 02             	movq   QWORD PTR [rdx],mm0
								pt += 8;
     9a5:	48 83 45 f0 08       	add    QWORD PTR [rbp-0x10],0x8
								mem += 8;
     9aa:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     9b1:	48 83 c0 08          	add    rax,0x8
     9b5:	48 89 85 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rax
								bitc -= 64;
     9bc:	83 6d fc 40          	sub    DWORD PTR [rbp-0x4],0x40
						if (bitc >= 32) {
     9c0:	83 7d fc 1f          	cmp    DWORD PTR [rbp-0x4],0x1f
     9c4:	7e 2c                	jle    9f2 <render_text_scanline_32btpp_sse+0x454>
								*(uint32_t*)mem = *(uint32_t*)pt;
     9c6:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     9cd:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     9d1:	8b 12                	mov    edx,DWORD PTR [rdx]
     9d3:	89 10                	mov    DWORD PTR [rax],edx
								pt += 4;
     9d5:	48 83 45 f0 04       	add    QWORD PTR [rbp-0x10],0x4
								mem += 4;
     9da:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     9e1:	48 83 c0 04          	add    rax,0x4
     9e5:	48 89 85 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rax
								bitc -= 32;
     9ec:	83 6d fc 20          	sub    DWORD PTR [rbp-0x4],0x20
						break;
     9f0:	eb 72                	jmp    a64 <render_text_scanline_32btpp_sse+0x4c6>
						} else if (bitc) {
     9f2:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
     9f6:	74 6c                	je     a64 <render_text_scanline_32btpp_sse+0x4c6>
								die("cant happen with dword sized pixels!\n");
     9f8:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     9ff:	bf 0c 00 00 00       	mov    edi,0xc
     a04:	b8 00 00 00 00       	mov    eax,0x0
     a09:	e8 00 00 00 00       	call   a0e <render_text_scanline_32btpp_sse+0x470>
     a0e:	b8 00 00 00 00       	mov    eax,0x0
     a13:	e8 00 00 00 00       	call   a18 <render_text_scanline_32btpp_sse+0x47a>
     a18:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     a1f:	e8 00 00 00 00       	call   a24 <render_text_scanline_32btpp_sse+0x486>
     a24:	fa                   	cli
     a25:	f4                   	hlt
     a26:	eb fd                	jmp    a25 <render_text_scanline_32btpp_sse+0x487>
						px_x -= bitc / 32;
     a28:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     a2b:	8d 50 1f             	lea    edx,[rax+0x1f]
     a2e:	85 c0                	test   eax,eax
     a30:	0f 48 c2             	cmovs  eax,edx
     a33:	c1 f8 05             	sar    eax,0x5
     a36:	f7 d8                	neg    eax
     a38:	01 85 64 ff ff ff    	add    DWORD PTR [rbp-0x9c],eax
						p0_x += bitc / 32; /* unneccessary as r does not change anymore */
     a3e:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     a41:	8d 50 1f             	lea    edx,[rax+0x1f]
     a44:	85 c0                	test   eax,eax
     a46:	0f 48 c2             	cmovs  eax,edx
     a49:	c1 f8 05             	sar    eax,0x5
     a4c:	01 85 5c ff ff ff    	add    DWORD PTR [rbp-0xa4],eax
		while (px_x) {
     a52:	83 bd 64 ff ff ff 00 	cmp    DWORD PTR [rbp-0x9c],0x0
     a59:	0f 85 85 fd ff ff    	jne    7e4 <render_text_scanline_32btpp_sse+0x246>
				} else
						break;
		}
}
     a5f:	eb 04                	jmp    a65 <render_text_scanline_32btpp_sse+0x4c7>
						break;
     a61:	90                   	nop
     a62:	eb 01                	jmp    a65 <render_text_scanline_32btpp_sse+0x4c7>
						break;
     a64:	90                   	nop
}
     a65:	90                   	nop
     a66:	c9                   	leave
     a67:	c3                   	ret

0000000000000a68 <render_text_scanline_24btpp_sse>:

/* we're generating 3byte colorvalues /w unknown alignment. To enable
 * 16 byte transfers, 6 pixels /w 18 bytes have to be generated. */
void render_text_scanline_24btpp_sse(const char* font, char* str, void* mem,
				ssize_t px_x, ssize_t cur_x, ssize_t p0_x)
{
     a68:	55                   	push   rbp
     a69:	48 89 e5             	mov    rbp,rsp
     a6c:	48 81 ec b0 00 00 00 	sub    rsp,0xb0
     a73:	48 89 bd 78 ff ff ff 	mov    QWORD PTR [rbp-0x88],rdi
     a7a:	48 89 b5 70 ff ff ff 	mov    QWORD PTR [rbp-0x90],rsi
     a81:	48 89 95 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rdx
     a88:	89 8d 64 ff ff ff    	mov    DWORD PTR [rbp-0x9c],ecx
     a8e:	44 89 85 60 ff ff ff 	mov    DWORD PTR [rbp-0xa0],r8d
     a95:	44 89 8d 5c ff ff ff 	mov    DWORD PTR [rbp-0xa4],r9d
		uint8_t pxb[18 + 2 + 15]; /* 15 for stack alignment, 2 for bt_ofs */
		ssize_t misalign = ((size_t)mem % 16) ? (16 - (size_t)mem % 16) : 0;
     a9c:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     aa3:	83 e0 0f             	and    eax,0xf
     aa6:	48 85 c0             	test   rax,rax
     aa9:	74 15                	je     ac0 <render_text_scanline_24btpp_sse+0x58>
     aab:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     ab2:	83 e0 0f             	and    eax,0xf
     ab5:	ba 10 00 00 00       	mov    edx,0x10
     aba:	29 c2                	sub    edx,eax
     abc:	89 d0                	mov    eax,edx
     abe:	eb 05                	jmp    ac5 <render_text_scanline_24btpp_sse+0x5d>
     ac0:	b8 00 00 00 00       	mov    eax,0x0
     ac5:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
		ssize_t r = p0_x % 8;
     ac8:	8b 95 5c ff ff ff    	mov    edx,DWORD PTR [rbp-0xa4]
     ace:	89 d0                	mov    eax,edx
     ad0:	c1 f8 1f             	sar    eax,0x1f
     ad3:	c1 e8 1d             	shr    eax,0x1d
     ad6:	01 c2                	add    edx,eax
     ad8:	83 e2 07             	and    edx,0x7
     adb:	29 c2                	sub    edx,eax
     add:	89 55 e0             	mov    DWORD PTR [rbp-0x20],edx
		uint8_t* pixbuf = pxb + (((size_t)pxb % 16) ? (16 - ((size_t)pxb % 16)) : 0);
     ae0:	48 8d 45 90          	lea    rax,[rbp-0x70]
     ae4:	83 e0 0f             	and    eax,0xf
     ae7:	48 85 c0             	test   rax,rax
     aea:	74 14                	je     b00 <render_text_scanline_24btpp_sse+0x98>
     aec:	48 8d 45 90          	lea    rax,[rbp-0x70]
     af0:	83 e0 0f             	and    eax,0xf
     af3:	48 89 c2             	mov    rdx,rax
     af6:	b8 10 00 00 00       	mov    eax,0x10
     afb:	48 29 d0             	sub    rax,rdx
     afe:	eb 05                	jmp    b05 <render_text_scanline_24btpp_sse+0x9d>
     b00:	b8 00 00 00 00       	mov    eax,0x0
     b05:	48 8d 55 90          	lea    rdx,[rbp-0x70]
     b09:	48 01 d0             	add    rax,rdx
     b0c:	48 89 45 88          	mov    QWORD PTR [rbp-0x78],rax
		ssize_t bt_ofs = 0; /* used to control writing into pixbuf (1/3 pixels)*/
     b10:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		/* 64-bit aligned moves are enough */

		if (misalign) { /* LFB is dword aligned, we want (dq/o)word access */
     b17:	83 7d e4 00          	cmp    DWORD PTR [rbp-0x1c],0x0
     b1b:	0f 84 3a 05 00 00    	je     105b <render_text_scanline_24btpp_sse+0x5f3>
				int col = p0_x / 8, inv = (col == cur_x);
     b21:	8b 85 5c ff ff ff    	mov    eax,DWORD PTR [rbp-0xa4]
     b27:	8d 50 07             	lea    edx,[rax+0x7]
     b2a:	85 c0                	test   eax,eax
     b2c:	0f 48 c2             	cmovs  eax,edx
     b2f:	c1 f8 03             	sar    eax,0x3
     b32:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
     b35:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
     b38:	3b 85 60 ff ff ff    	cmp    eax,DWORD PTR [rbp-0xa0]
     b3e:	0f 94 c0             	sete   al
     b41:	0f b6 c0             	movzx  eax,al
     b44:	89 45 d8             	mov    DWORD PTR [rbp-0x28],eax
				ssize_t bc = min(misalign, 3 * px_x);
     b47:	8b 95 64 ff ff ff    	mov    edx,DWORD PTR [rbp-0x9c]
     b4d:	89 d0                	mov    eax,edx
     b4f:	01 c0                	add    eax,eax
     b51:	01 d0                	add    eax,edx
     b53:	8b 55 e4             	mov    edx,DWORD PTR [rbp-0x1c]
     b56:	39 c2                	cmp    edx,eax
     b58:	0f 4e c2             	cmovle eax,edx
     b5b:	89 45 d4             	mov    DWORD PTR [rbp-0x2c],eax
				ssize_t cc = rdiv(bc, 3);
     b5e:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
     b61:	48 63 d0             	movsxd rdx,eax
     b64:	48 69 d2 56 55 55 55 	imul   rdx,rdx,0x55555556
     b6b:	48 c1 ea 20          	shr    rdx,0x20
     b6f:	c1 f8 1f             	sar    eax,0x1f
     b72:	89 d6                	mov    esi,edx
     b74:	29 c6                	sub    esi,eax
     b76:	8b 4d d4             	mov    ecx,DWORD PTR [rbp-0x2c]
     b79:	48 63 c1             	movsxd rax,ecx
     b7c:	48 69 c0 56 55 55 55 	imul   rax,rax,0x55555556
     b83:	48 c1 e8 20          	shr    rax,0x20
     b87:	48 89 c2             	mov    rdx,rax
     b8a:	89 c8                	mov    eax,ecx
     b8c:	c1 f8 1f             	sar    eax,0x1f
     b8f:	29 c2                	sub    edx,eax
     b91:	89 d0                	mov    eax,edx
     b93:	01 c0                	add    eax,eax
     b95:	01 d0                	add    eax,edx
     b97:	29 c1                	sub    ecx,eax
     b99:	89 ca                	mov    edx,ecx
     b9b:	85 d2                	test   edx,edx
     b9d:	0f 95 c0             	setne  al
     ba0:	0f b6 c0             	movzx  eax,al
     ba3:	01 f0                	add    eax,esi
     ba5:	89 45 d0             	mov    DWORD PTR [rbp-0x30],eax
				ssize_t rmax = min(8, r + cc), cc1 = rmax - r;
     ba8:	8b 55 e0             	mov    edx,DWORD PTR [rbp-0x20]
     bab:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
     bae:	01 d0                	add    eax,edx
     bb0:	ba 08 00 00 00       	mov    edx,0x8
     bb5:	39 d0                	cmp    eax,edx
     bb7:	0f 4f c2             	cmovg  eax,edx
     bba:	89 45 cc             	mov    DWORD PTR [rbp-0x34],eax
     bbd:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
     bc0:	2b 45 e0             	sub    eax,DWORD PTR [rbp-0x20]
     bc3:	89 45 c8             	mov    DWORD PTR [rbp-0x38],eax

				generate_char_colors(font, str[0], str[1], 24,
     bc6:	48 8b 4d 88          	mov    rcx,QWORD PTR [rbp-0x78]
     bca:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     bd1:	48 83 c0 01          	add    rax,0x1
     bd5:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     bd8:	0f be d0             	movsx  edx,al
     bdb:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     be2:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     be5:	0f be f0             	movsx  esi,al
     be8:	44 8b 4d cc          	mov    r9d,DWORD PTR [rbp-0x34]
     bec:	44 8b 45 e0          	mov    r8d,DWORD PTR [rbp-0x20]
     bf0:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     bf7:	8b 7d d8             	mov    edi,DWORD PTR [rbp-0x28]
     bfa:	57                   	push   rdi
     bfb:	51                   	push   rcx
     bfc:	b9 18 00 00 00       	mov    ecx,0x18
     c01:	48 89 c7             	mov    rdi,rax
     c04:	e8 00 00 00 00       	call   c09 <render_text_scanline_24btpp_sse+0x1a1>
     c09:	48 83 c4 10          	add    rsp,0x10
								r, rmax, pixbuf, inv);
				if (rmax == 8)
     c0d:	83 7d cc 08          	cmp    DWORD PTR [rbp-0x34],0x8
     c11:	75 08                	jne    c1b <render_text_scanline_24btpp_sse+0x1b3>
						str += 2;
     c13:	48 83 85 70 ff ff ff 02 	add    QWORD PTR [rbp-0x90],0x2
				if (cc > cc1) { /* generate the new char */
     c1b:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
     c1e:	3b 45 c8             	cmp    eax,DWORD PTR [rbp-0x38]
     c21:	7e 76                	jle    c99 <render_text_scanline_24btpp_sse+0x231>
						col++; inv = (col == cur_x);
     c23:	83 45 dc 01          	add    DWORD PTR [rbp-0x24],0x1
     c27:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
     c2a:	3b 85 60 ff ff ff    	cmp    eax,DWORD PTR [rbp-0xa0]
     c30:	0f 94 c0             	sete   al
     c33:	0f b6 c0             	movzx  eax,al
     c36:	89 45 d8             	mov    DWORD PTR [rbp-0x28],eax
						generate_char_colors(font, str[0], str[1], 24,
     c39:	48 8b 4d 88          	mov    rcx,QWORD PTR [rbp-0x78]
										0, cc - cc1, pixbuf + cc1 * 3, inv);
     c3d:	8b 55 c8             	mov    edx,DWORD PTR [rbp-0x38]
     c40:	89 d0                	mov    eax,edx
     c42:	01 c0                	add    eax,eax
     c44:	01 d0                	add    eax,edx
     c46:	48 98                	cdqe
						generate_char_colors(font, str[0], str[1], 24,
     c48:	48 8d 3c 01          	lea    rdi,[rcx+rax*1]
     c4c:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
     c4f:	2b 45 c8             	sub    eax,DWORD PTR [rbp-0x38]
     c52:	41 89 c0             	mov    r8d,eax
     c55:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     c5c:	48 83 c0 01          	add    rax,0x1
     c60:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     c63:	0f be d0             	movsx  edx,al
     c66:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     c6d:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     c70:	0f be f0             	movsx  esi,al
     c73:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     c7a:	8b 4d d8             	mov    ecx,DWORD PTR [rbp-0x28]
     c7d:	51                   	push   rcx
     c7e:	57                   	push   rdi
     c7f:	45 89 c1             	mov    r9d,r8d
     c82:	41 b8 00 00 00 00    	mov    r8d,0x0
     c88:	b9 18 00 00 00       	mov    ecx,0x18
     c8d:	48 89 c7             	mov    rdi,rax
     c90:	e8 00 00 00 00       	call   c95 <render_text_scanline_24btpp_sse+0x22d>
     c95:	48 83 c4 10          	add    rsp,0x10
				}
				memcpy(mem, pixbuf, bc);
     c99:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
     c9c:	48 63 d0             	movsxd rdx,eax
     c9f:	48 8b 4d 88          	mov    rcx,QWORD PTR [rbp-0x78]
     ca3:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     caa:	48 89 ce             	mov    rsi,rcx
     cad:	48 89 c7             	mov    rdi,rax
     cb0:	e8 4b f3 ff ff       	call   0 <memcpy>
				/* now indicate the remaining pixel part if there and
				 * copy the data to the front for the later transfer */
				if (bc % 3) {
     cb5:	8b 4d d4             	mov    ecx,DWORD PTR [rbp-0x2c]
     cb8:	48 63 c1             	movsxd rax,ecx
     cbb:	48 69 c0 56 55 55 55 	imul   rax,rax,0x55555556
     cc2:	48 c1 e8 20          	shr    rax,0x20
     cc6:	48 89 c2             	mov    rdx,rax
     cc9:	89 c8                	mov    eax,ecx
     ccb:	c1 f8 1f             	sar    eax,0x1f
     cce:	29 c2                	sub    edx,eax
     cd0:	89 d0                	mov    eax,edx
     cd2:	01 c0                	add    eax,eax
     cd4:	01 d0                	add    eax,edx
     cd6:	29 c1                	sub    ecx,eax
     cd8:	89 ca                	mov    edx,ecx
     cda:	85 d2                	test   edx,edx
     cdc:	74 30                	je     d0e <render_text_scanline_24btpp_sse+0x2a6>
						bt_ofs = 3 * cc - bc;
     cde:	8b 55 d0             	mov    edx,DWORD PTR [rbp-0x30]
     ce1:	89 d0                	mov    eax,edx
     ce3:	01 c0                	add    eax,eax
     ce5:	01 d0                	add    eax,edx
     ce7:	2b 45 d4             	sub    eax,DWORD PTR [rbp-0x2c]
     cea:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
						memcpy(pixbuf, pixbuf + bc, bt_ofs);
     ced:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     cf0:	48 63 d0             	movsxd rdx,eax
     cf3:	48 8b 4d 88          	mov    rcx,QWORD PTR [rbp-0x78]
     cf7:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
     cfa:	48 98                	cdqe
     cfc:	48 01 c1             	add    rcx,rax
     cff:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
     d03:	48 89 ce             	mov    rsi,rcx
     d06:	48 89 c7             	mov    rdi,rax
     d09:	e8 f2 f2 ff ff       	call   0 <memcpy>
						/* no bt_ofs pixels from this pixel are left in pixbuf */
				}
				px_x -= cc;
     d0e:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
     d11:	29 85 64 ff ff ff    	sub    DWORD PTR [rbp-0x9c],eax
				p0_x += cc;
     d17:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
     d1a:	01 85 5c ff ff ff    	add    DWORD PTR [rbp-0xa4],eax
				mem += misalign; /* safer than bc */
     d20:	48 8b 95 68 ff ff ff 	mov    rdx,QWORD PTR [rbp-0x98]
     d27:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     d2a:	48 98                	cdqe
     d2c:	48 01 d0             	add    rax,rdx
     d2f:	48 89 85 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rax
		}

		/* draw 5 2/3 pixels each (6,5,5) */
		while (px_x) { /* 144 bit vs. 128 16bt remain (2/3) */
     d36:	e9 20 03 00 00       	jmp    105b <render_text_scanline_24btpp_sse+0x5f3>
				int col = p0_x / 8, inv = (col == cur_x);
     d3b:	8b 85 5c ff ff ff    	mov    eax,DWORD PTR [rbp-0xa4]
     d41:	8d 50 07             	lea    edx,[rax+0x7]
     d44:	85 c0                	test   eax,eax
     d46:	0f 48 c2             	cmovs  eax,edx
     d49:	c1 f8 03             	sar    eax,0x3
     d4c:	89 45 c4             	mov    DWORD PTR [rbp-0x3c],eax
     d4f:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
     d52:	3b 85 60 ff ff ff    	cmp    eax,DWORD PTR [rbp-0xa0]
     d58:	0f 94 c0             	sete   al
     d5b:	0f b6 c0             	movzx  eax,al
     d5e:	89 45 c0             	mov    DWORD PTR [rbp-0x40],eax
				ssize_t cc = min(bt_ofs ? 5 : 6, px_x), cc1; /* 655 */
     d61:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
     d65:	74 07                	je     d6e <render_text_scanline_24btpp_sse+0x306>
     d67:	b8 05 00 00 00       	mov    eax,0x5
     d6c:	eb 05                	jmp    d73 <render_text_scanline_24btpp_sse+0x30b>
     d6e:	b8 06 00 00 00       	mov    eax,0x6
     d73:	8b 95 64 ff ff ff    	mov    edx,DWORD PTR [rbp-0x9c]
     d79:	39 d0                	cmp    eax,edx
     d7b:	0f 4f c2             	cmovg  eax,edx
     d7e:	89 45 bc             	mov    DWORD PTR [rbp-0x44],eax
				ssize_t rmax, bitc, btt = min(128, 24 * px_x + 8 * bt_ofs);
     d81:	8b 95 64 ff ff ff    	mov    edx,DWORD PTR [rbp-0x9c]
     d87:	89 d0                	mov    eax,edx
     d89:	01 c0                	add    eax,eax
     d8b:	01 c2                	add    edx,eax
     d8d:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     d90:	01 d0                	add    eax,edx
     d92:	c1 e0 03             	shl    eax,0x3
     d95:	ba 80 00 00 00       	mov    edx,0x80
     d9a:	39 d0                	cmp    eax,edx
     d9c:	0f 4f c2             	cmovg  eax,edx
     d9f:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
				r = p0_x % 8;
     da2:	8b 95 5c ff ff ff    	mov    edx,DWORD PTR [rbp-0xa4]
     da8:	89 d0                	mov    eax,edx
     daa:	c1 f8 1f             	sar    eax,0x1f
     dad:	c1 e8 1d             	shr    eax,0x1d
     db0:	01 c2                	add    edx,eax
     db2:	83 e2 07             	and    edx,0x7
     db5:	29 c2                	sub    edx,eax
     db7:	89 55 e0             	mov    DWORD PTR [rbp-0x20],edx
				rmax = min(8, r + cc); /* only up to 6 pixels */
     dba:	8b 55 e0             	mov    edx,DWORD PTR [rbp-0x20]
     dbd:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44]
     dc0:	01 d0                	add    eax,edx
     dc2:	ba 08 00 00 00       	mov    edx,0x8
     dc7:	39 d0                	cmp    eax,edx
     dc9:	0f 4f c2             	cmovg  eax,edx
     dcc:	89 45 b8             	mov    DWORD PTR [rbp-0x48],eax
				/* get the remaining character pixels */
				bitc = generate_char_colors(font, str[0], str[1], 24,
     dcf:	48 8b 55 88          	mov    rdx,QWORD PTR [rbp-0x78]
     dd3:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     dd6:	48 98                	cdqe
     dd8:	48 8d 3c 02          	lea    rdi,[rdx+rax*1]
     ddc:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     de3:	48 83 c0 01          	add    rax,0x1
     de7:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     dea:	0f be d0             	movsx  edx,al
     ded:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     df4:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     df7:	0f be f0             	movsx  esi,al
     dfa:	44 8b 4d b8          	mov    r9d,DWORD PTR [rbp-0x48]
     dfe:	44 8b 45 e0          	mov    r8d,DWORD PTR [rbp-0x20]
     e02:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     e09:	8b 4d c0             	mov    ecx,DWORD PTR [rbp-0x40]
     e0c:	51                   	push   rcx
     e0d:	57                   	push   rdi
     e0e:	b9 18 00 00 00       	mov    ecx,0x18
     e13:	48 89 c7             	mov    rdi,rax
     e16:	e8 00 00 00 00       	call   e1b <render_text_scanline_24btpp_sse+0x3b3>
     e1b:	48 83 c4 10          	add    rsp,0x10
     e1f:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
								r, rmax, pixbuf + bt_ofs, inv);
				cc1 = rmax - r;
     e22:	8b 45 b8             	mov    eax,DWORD PTR [rbp-0x48]
     e25:	2b 45 e0             	sub    eax,DWORD PTR [rbp-0x20]
     e28:	89 45 b4             	mov    DWORD PTR [rbp-0x4c],eax
				/* now advance if neccessary */
				if (rmax == 8)
     e2b:	83 7d b8 08          	cmp    DWORD PTR [rbp-0x48],0x8
     e2f:	75 08                	jne    e39 <render_text_scanline_24btpp_sse+0x3d1>
						str += 2;
     e31:	48 83 85 70 ff ff ff 02 	add    QWORD PTR [rbp-0x90],0x2
				/* and fetch up to five more pixels if needed (r=0) */
				if (cc > cc1) {
     e39:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44]
     e3c:	3b 45 b4             	cmp    eax,DWORD PTR [rbp-0x4c]
     e3f:	0f 8e 82 00 00 00    	jle    ec7 <render_text_scanline_24btpp_sse+0x45f>
						col++; inv = (col == cur_x);
     e45:	83 45 c4 01          	add    DWORD PTR [rbp-0x3c],0x1
     e49:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
     e4c:	3b 85 60 ff ff ff    	cmp    eax,DWORD PTR [rbp-0xa0]
     e52:	0f 94 c0             	sete   al
     e55:	0f b6 c0             	movzx  eax,al
     e58:	89 45 c0             	mov    DWORD PTR [rbp-0x40],eax
						bitc += generate_char_colors(font, str[0], str[1], 24,
     e5b:	48 8b 4d 88          	mov    rcx,QWORD PTR [rbp-0x78]
										0, cc - cc1, pixbuf + bt_ofs + cc1 * 3, inv);
     e5f:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     e62:	48 63 f0             	movsxd rsi,eax
     e65:	8b 55 b4             	mov    edx,DWORD PTR [rbp-0x4c]
     e68:	89 d0                	mov    eax,edx
     e6a:	01 c0                	add    eax,eax
     e6c:	01 d0                	add    eax,edx
     e6e:	48 98                	cdqe
     e70:	48 01 f0             	add    rax,rsi
						bitc += generate_char_colors(font, str[0], str[1], 24,
     e73:	48 8d 3c 01          	lea    rdi,[rcx+rax*1]
     e77:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44]
     e7a:	2b 45 b4             	sub    eax,DWORD PTR [rbp-0x4c]
     e7d:	41 89 c0             	mov    r8d,eax
     e80:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     e87:	48 83 c0 01          	add    rax,0x1
     e8b:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     e8e:	0f be d0             	movsx  edx,al
     e91:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     e98:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     e9b:	0f be f0             	movsx  esi,al
     e9e:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     ea5:	8b 4d c0             	mov    ecx,DWORD PTR [rbp-0x40]
     ea8:	51                   	push   rcx
     ea9:	57                   	push   rdi
     eaa:	45 89 c1             	mov    r9d,r8d
     ead:	41 b8 00 00 00 00    	mov    r8d,0x0
     eb3:	b9 18 00 00 00       	mov    ecx,0x18
     eb8:	48 89 c7             	mov    rdi,rax
     ebb:	e8 00 00 00 00       	call   ec0 <render_text_scanline_24btpp_sse+0x458>
     ec0:	48 83 c4 10          	add    rsp,0x10
     ec4:	01 45 f8             	add    DWORD PTR [rbp-0x8],eax
				}
				/* now transfer */
				if (btt >= 128) {
     ec7:	83 7d f4 7f          	cmp    DWORD PTR [rbp-0xc],0x7f
     ecb:	7e 35                	jle    f02 <render_text_scanline_24btpp_sse+0x49a>
						move_128(pixbuf, mem);
     ecd:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
     ed1:	48 8b 95 68 ff ff ff 	mov    rdx,QWORD PTR [rbp-0x98]
     ed8:	0f 28 00             	movaps xmm0,XMMWORD PTR [rax]
     edb:	0f 29 02             	movaps XMMWORD PTR [rdx],xmm0
						mem += 16;
     ede:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     ee5:	48 83 c0 10          	add    rax,0x10
     ee9:	48 89 85 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rax
						}
						break;
				}

				/* and don't advance as r = 0 is already handled (sth. remains) */
				if (px_x) {
     ef0:	83 bd 64 ff ff ff 00 	cmp    DWORD PTR [rbp-0x9c],0x0
     ef7:	0f 84 6d 01 00 00    	je     106a <render_text_scanline_24btpp_sse+0x602>
     efd:	e9 16 01 00 00       	jmp    1018 <render_text_scanline_24btpp_sse+0x5b0>
						uint8_t* pt = pixbuf;
     f02:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
     f06:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
						if (btt >= 64) {
     f0a:	83 7d f4 3f          	cmp    DWORD PTR [rbp-0xc],0x3f
     f0e:	7e 2c                	jle    f3c <render_text_scanline_24btpp_sse+0x4d4>
								move_64(pixbuf, mem);
     f10:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
     f14:	48 8b 95 68 ff ff ff 	mov    rdx,QWORD PTR [rbp-0x98]
     f1b:	0f 6f 00             	movq   mm0,QWORD PTR [rax]
     f1e:	0f 7f 02             	movq   QWORD PTR [rdx],mm0
								pt += 8;
     f21:	48 83 45 e8 08       	add    QWORD PTR [rbp-0x18],0x8
								mem += 8;
     f26:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     f2d:	48 83 c0 08          	add    rax,0x8
     f31:	48 89 85 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rax
								btt -= 64;
     f38:	83 6d f4 40          	sub    DWORD PTR [rbp-0xc],0x40
						if (btt >= 32) {
     f3c:	83 7d f4 1f          	cmp    DWORD PTR [rbp-0xc],0x1f
     f40:	7e 2f                	jle    f71 <render_text_scanline_24btpp_sse+0x509>
								*(uint32_t*)mem = *(uint32_t*)pt;
     f42:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     f49:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     f4d:	8b 12                	mov    edx,DWORD PTR [rdx]
     f4f:	89 10                	mov    DWORD PTR [rax],edx
								pt += 4;
     f51:	48 83 45 e8 04       	add    QWORD PTR [rbp-0x18],0x4
								mem += 4;
     f56:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     f5d:	48 83 c0 04          	add    rax,0x4
     f61:	48 89 85 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rax
								btt -= 32;
     f68:	83 6d f4 20          	sub    DWORD PTR [rbp-0xc],0x20
						break;
     f6c:	e9 fc 00 00 00       	jmp    106d <render_text_scanline_24btpp_sse+0x605>
						} else if (btt >= 16) {
     f71:	83 7d f4 0f          	cmp    DWORD PTR [rbp-0xc],0xf
     f75:	7e 31                	jle    fa8 <render_text_scanline_24btpp_sse+0x540>
								*(uint16_t*)mem = *(uint16_t*)pt;
     f77:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     f7e:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     f82:	0f b7 12             	movzx  edx,WORD PTR [rdx]
     f85:	66 89 10             	mov    WORD PTR [rax],dx
								pt += 2;
     f88:	48 83 45 e8 02       	add    QWORD PTR [rbp-0x18],0x2
								mem += 2;
     f8d:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     f94:	48 83 c0 02          	add    rax,0x2
     f98:	48 89 85 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rax
								btt -= 16;
     f9f:	83 6d f4 10          	sub    DWORD PTR [rbp-0xc],0x10
						break;
     fa3:	e9 c5 00 00 00       	jmp    106d <render_text_scanline_24btpp_sse+0x605>
						} else if (bitc >= 8) {
     fa8:	83 7d f8 07          	cmp    DWORD PTR [rbp-0x8],0x7
     fac:	7e 30                	jle    fde <render_text_scanline_24btpp_sse+0x576>
								*(uint8_t*)mem = *(uint8_t*)pt;
     fae:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     fb5:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     fb9:	0f b6 12             	movzx  edx,BYTE PTR [rdx]
     fbc:	88 10                	mov    BYTE PTR [rax],dl
								pt += 1;
     fbe:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
								mem += 1;
     fc3:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     fca:	48 83 c0 01          	add    rax,0x1
     fce:	48 89 85 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rax
								btt -= 8;
     fd5:	83 6d f4 08          	sub    DWORD PTR [rbp-0xc],0x8
						break;
     fd9:	e9 8f 00 00 00       	jmp    106d <render_text_scanline_24btpp_sse+0x605>
						} else if (bitc) {
     fde:	83 7d f8 00          	cmp    DWORD PTR [rbp-0x8],0x0
     fe2:	0f 84 85 00 00 00    	je     106d <render_text_scanline_24btpp_sse+0x605>
								die("can't happen with 3byte sized pixels\n");
     fe8:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     fef:	bf 0c 00 00 00       	mov    edi,0xc
     ff4:	b8 00 00 00 00       	mov    eax,0x0
     ff9:	e8 00 00 00 00       	call   ffe <render_text_scanline_24btpp_sse+0x596>
     ffe:	b8 00 00 00 00       	mov    eax,0x0
    1003:	e8 00 00 00 00       	call   1008 <render_text_scanline_24btpp_sse+0x5a0>
    1008:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    100f:	e8 00 00 00 00       	call   1014 <render_text_scanline_24btpp_sse+0x5ac>
    1014:	fa                   	cli
    1015:	f4                   	hlt
    1016:	eb fd                	jmp    1015 <render_text_scanline_24btpp_sse+0x5ad>
						px_x -= cc; /* bitc is 24-divisible */
    1018:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44]
    101b:	29 85 64 ff ff ff    	sub    DWORD PTR [rbp-0x9c],eax
						p0_x += cc; /* unneccessary as r does not change anymore */
    1021:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44]
    1024:	01 85 5c ff ff ff    	add    DWORD PTR [rbp-0xa4],eax
						/* copy remaining data */
						/* |bt_ofs*8-bitc| */
						if (!bt_ofs--)
    102a:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    102d:	8d 50 ff             	lea    edx,[rax-0x1]
    1030:	89 55 fc             	mov    DWORD PTR [rbp-0x4],edx
    1033:	85 c0                	test   eax,eax
    1035:	75 07                	jne    103e <render_text_scanline_24btpp_sse+0x5d6>
								bt_ofs = 2;
    1037:	c7 45 fc 02 00 00 00 	mov    DWORD PTR [rbp-0x4],0x2
						memcpy(pixbuf, pixbuf + 16, bt_ofs);
    103e:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1041:	48 63 d0             	movsxd rdx,eax
    1044:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1048:	48 8d 48 10          	lea    rcx,[rax+0x10]
    104c:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1050:	48 89 ce             	mov    rsi,rcx
    1053:	48 89 c7             	mov    rdi,rax
    1056:	e8 a5 ef ff ff       	call   0 <memcpy>
		while (px_x) { /* 144 bit vs. 128 16bt remain (2/3) */
    105b:	83 bd 64 ff ff ff 00 	cmp    DWORD PTR [rbp-0x9c],0x0
    1062:	0f 85 d3 fc ff ff    	jne    d3b <render_text_scanline_24btpp_sse+0x2d3>
    1068:	eb 04                	jmp    106e <render_text_scanline_24btpp_sse+0x606>
				} else
						break;
    106a:	90                   	nop
    106b:	eb 01                	jmp    106e <render_text_scanline_24btpp_sse+0x606>
						break;
    106d:	90                   	nop
		}

		/* transfer the leftover pixel data */
		if (bt_ofs)
    106e:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
    1072:	74 1c                	je     1090 <render_text_scanline_24btpp_sse+0x628>
				memcpy(pixbuf, mem, bt_ofs);
    1074:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1077:	48 63 d0             	movsxd rdx,eax
    107a:	48 8b 8d 68 ff ff ff 	mov    rcx,QWORD PTR [rbp-0x98]
    1081:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1085:	48 89 ce             	mov    rsi,rcx
    1088:	48 89 c7             	mov    rdi,rax
    108b:	e8 70 ef ff ff       	call   0 <memcpy>
}
    1090:	90                   	nop
    1091:	c9                   	leave
    1092:	c3                   	ret

0000000000001093 <render_text_scanline_16btpp>:

/* we're generating 2byte colorvalues /w unknown alignment. To enable
 * 8 byte transfer, four pixels have to be generated. */
void render_text_scanline_16btpp(const char* font, char* str, void* mem,
				ssize_t px_x, ssize_t cur_x, ssize_t p0_x, size_t btpp)
{
    1093:	55                   	push   rbp
    1094:	48 89 e5             	mov    rbp,rsp
    1097:	48 81 ec 90 00 00 00 	sub    rsp,0x90
    109e:	48 89 7d 98          	mov    QWORD PTR [rbp-0x68],rdi
    10a2:	48 89 75 90          	mov    QWORD PTR [rbp-0x70],rsi
    10a6:	48 89 55 88          	mov    QWORD PTR [rbp-0x78],rdx
    10aa:	89 4d 84             	mov    DWORD PTR [rbp-0x7c],ecx
    10ad:	44 89 45 80          	mov    DWORD PTR [rbp-0x80],r8d
    10b1:	44 89 8d 7c ff ff ff 	mov    DWORD PTR [rbp-0x84],r9d
		uint8_t pxb[8 + 7]; /* 7 for stack alignment */
		ssize_t misalign = ((size_t)mem % 8) ? (8 - (size_t)mem % 8) : 0;
    10b8:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    10bc:	83 e0 07             	and    eax,0x7
    10bf:	48 85 c0             	test   rax,rax
    10c2:	74 12                	je     10d6 <render_text_scanline_16btpp+0x43>
    10c4:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    10c8:	83 e0 07             	and    eax,0x7
    10cb:	ba 08 00 00 00       	mov    edx,0x8
    10d0:	29 c2                	sub    edx,eax
    10d2:	89 d0                	mov    eax,edx
    10d4:	eb 05                	jmp    10db <render_text_scanline_16btpp+0x48>
    10d6:	b8 00 00 00 00       	mov    eax,0x0
    10db:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
		ssize_t r = p0_x % 8;
    10de:	8b 95 7c ff ff ff    	mov    edx,DWORD PTR [rbp-0x84]
    10e4:	89 d0                	mov    eax,edx
    10e6:	c1 f8 1f             	sar    eax,0x1f
    10e9:	c1 e8 1d             	shr    eax,0x1d
    10ec:	01 c2                	add    edx,eax
    10ee:	83 e2 07             	and    edx,0x7
    10f1:	29 c2                	sub    edx,eax
    10f3:	89 55 e8             	mov    DWORD PTR [rbp-0x18],edx
		uint8_t* pixbuf = pxb + (((size_t)pxb % 8) ? (8 - ((size_t)pxb % 8)) : 0);
    10f6:	48 8d 45 b1          	lea    rax,[rbp-0x4f]
    10fa:	83 e0 07             	and    eax,0x7
    10fd:	48 85 c0             	test   rax,rax
    1100:	74 14                	je     1116 <render_text_scanline_16btpp+0x83>
    1102:	48 8d 45 b1          	lea    rax,[rbp-0x4f]
    1106:	83 e0 07             	and    eax,0x7
    1109:	48 89 c2             	mov    rdx,rax
    110c:	b8 08 00 00 00       	mov    eax,0x8
    1111:	48 29 d0             	sub    rax,rdx
    1114:	eb 05                	jmp    111b <render_text_scanline_16btpp+0x88>
    1116:	b8 00 00 00 00       	mov    eax,0x0
    111b:	48 8d 55 b1          	lea    rdx,[rbp-0x4f]
    111f:	48 01 d0             	add    rax,rdx
    1122:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
		/* 64-bit aligned moves are enough */

		if (misalign) { /* LFB is dword aligned, we want qword access */
    1126:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
    112a:	0f 84 80 03 00 00    	je     14b0 <render_text_scanline_16btpp+0x41d>
				int col = p0_x / 8, inv = (col == cur_x);
    1130:	8b 85 7c ff ff ff    	mov    eax,DWORD PTR [rbp-0x84]
    1136:	8d 50 07             	lea    edx,[rax+0x7]
    1139:	85 c0                	test   eax,eax
    113b:	0f 48 c2             	cmovs  eax,edx
    113e:	c1 f8 03             	sar    eax,0x3
    1141:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
    1144:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    1147:	3b 45 80             	cmp    eax,DWORD PTR [rbp-0x80]
    114a:	0f 94 c0             	sete   al
    114d:	0f b6 c0             	movzx  eax,al
    1150:	89 45 e0             	mov    DWORD PTR [rbp-0x20],eax
				ssize_t bc = min(misalign, 2 * px_x);
    1153:	8b 45 84             	mov    eax,DWORD PTR [rbp-0x7c]
    1156:	01 c0                	add    eax,eax
    1158:	8b 55 ec             	mov    edx,DWORD PTR [rbp-0x14]
    115b:	39 c2                	cmp    edx,eax
    115d:	0f 4e c2             	cmovle eax,edx
    1160:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
				ssize_t cc = rdiv(misalign, 2);
    1163:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    1166:	89 c2                	mov    edx,eax
    1168:	c1 ea 1f             	shr    edx,0x1f
    116b:	01 d0                	add    eax,edx
    116d:	d1 f8                	sar    eax,1
    116f:	89 c2                	mov    edx,eax
    1171:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    1174:	83 e0 01             	and    eax,0x1
    1177:	01 d0                	add    eax,edx
    1179:	89 45 d8             	mov    DWORD PTR [rbp-0x28],eax
				ssize_t rmax = min(8, r + cc), cc1 = rmax - r;
    117c:	8b 55 e8             	mov    edx,DWORD PTR [rbp-0x18]
    117f:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    1182:	01 d0                	add    eax,edx
    1184:	ba 08 00 00 00       	mov    edx,0x8
    1189:	39 d0                	cmp    eax,edx
    118b:	0f 4f c2             	cmovg  eax,edx
    118e:	89 45 d4             	mov    DWORD PTR [rbp-0x2c],eax
    1191:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
    1194:	2b 45 e8             	sub    eax,DWORD PTR [rbp-0x18]
    1197:	89 45 d0             	mov    DWORD PTR [rbp-0x30],eax

				generate_char_colors(font, str[0], str[1], btpp,
    119a:	48 8b 7d a8          	mov    rdi,QWORD PTR [rbp-0x58]
    119e:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    11a2:	48 83 c0 01          	add    rax,0x1
    11a6:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    11a9:	0f be d0             	movsx  edx,al
    11ac:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    11b0:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    11b3:	0f be f0             	movsx  esi,al
    11b6:	44 8b 4d d4          	mov    r9d,DWORD PTR [rbp-0x2c]
    11ba:	44 8b 55 e8          	mov    r10d,DWORD PTR [rbp-0x18]
    11be:	48 8b 4d 10          	mov    rcx,QWORD PTR [rbp+0x10]
    11c2:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    11c6:	44 8b 45 e0          	mov    r8d,DWORD PTR [rbp-0x20]
    11ca:	41 50                	push   r8
    11cc:	57                   	push   rdi
    11cd:	45 89 d0             	mov    r8d,r10d
    11d0:	48 89 c7             	mov    rdi,rax
    11d3:	e8 00 00 00 00       	call   11d8 <render_text_scanline_16btpp+0x145>
    11d8:	48 83 c4 10          	add    rsp,0x10
								r, rmax, pixbuf, inv);
				if (rmax == 8)
    11dc:	83 7d d4 08          	cmp    DWORD PTR [rbp-0x2c],0x8
    11e0:	75 05                	jne    11e7 <render_text_scanline_16btpp+0x154>
						str += 2;
    11e2:	48 83 45 90 02       	add    QWORD PTR [rbp-0x70],0x2
				if (cc > cc1) {
    11e7:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    11ea:	3b 45 d0             	cmp    eax,DWORD PTR [rbp-0x30]
    11ed:	7e 61                	jle    1250 <render_text_scanline_16btpp+0x1bd>
						col++; inv = (col == cur_x);
    11ef:	83 45 e4 01          	add    DWORD PTR [rbp-0x1c],0x1
    11f3:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    11f6:	3b 45 80             	cmp    eax,DWORD PTR [rbp-0x80]
    11f9:	0f 94 c0             	sete   al
    11fc:	0f b6 c0             	movzx  eax,al
    11ff:	89 45 e0             	mov    DWORD PTR [rbp-0x20],eax
						generate_char_colors(font, str[0], str[1], btpp,
    1202:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1206:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
    1209:	48 98                	cdqe
    120b:	4c 8d 04 02          	lea    r8,[rdx+rax*1]
    120f:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    1212:	2b 45 d0             	sub    eax,DWORD PTR [rbp-0x30]
    1215:	41 89 c1             	mov    r9d,eax
    1218:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    121c:	48 83 c0 01          	add    rax,0x1
    1220:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1223:	0f be d0             	movsx  edx,al
    1226:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    122a:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    122d:	0f be f0             	movsx  esi,al
    1230:	48 8b 4d 10          	mov    rcx,QWORD PTR [rbp+0x10]
    1234:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1238:	8b 7d e0             	mov    edi,DWORD PTR [rbp-0x20]
    123b:	57                   	push   rdi
    123c:	41 50                	push   r8
    123e:	41 b8 00 00 00 00    	mov    r8d,0x0
    1244:	48 89 c7             	mov    rdi,rax
    1247:	e8 00 00 00 00       	call   124c <render_text_scanline_16btpp+0x1b9>
    124c:	48 83 c4 10          	add    rsp,0x10
										0, cc - cc1, pixbuf + cc1, inv);
				}
				memcpy(mem, pixbuf, bc);
    1250:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    1253:	48 63 d0             	movsxd rdx,eax
    1256:	48 8b 4d a8          	mov    rcx,QWORD PTR [rbp-0x58]
    125a:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    125e:	48 89 ce             	mov    rsi,rcx
    1261:	48 89 c7             	mov    rdi,rax
    1264:	e8 97 ed ff ff       	call   0 <memcpy>
				px_x -= cc;
    1269:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    126c:	29 45 84             	sub    DWORD PTR [rbp-0x7c],eax
				p0_x += cc;
    126f:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    1272:	01 85 7c ff ff ff    	add    DWORD PTR [rbp-0x84],eax
				mem += bc;
    1278:	48 8b 55 88          	mov    rdx,QWORD PTR [rbp-0x78]
    127c:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    127f:	48 98                	cdqe
    1281:	48 01 d0             	add    rax,rdx
    1284:	48 89 45 88          	mov    QWORD PTR [rbp-0x78],rax
		}

		/* draw 4 pixels each */
		while (px_x) {
    1288:	e9 23 02 00 00       	jmp    14b0 <render_text_scanline_16btpp+0x41d>
				int col = p0_x / 8, inv = (col == cur_x);
    128d:	8b 85 7c ff ff ff    	mov    eax,DWORD PTR [rbp-0x84]
    1293:	8d 50 07             	lea    edx,[rax+0x7]
    1296:	85 c0                	test   eax,eax
    1298:	0f 48 c2             	cmovs  eax,edx
    129b:	c1 f8 03             	sar    eax,0x3
    129e:	89 45 cc             	mov    DWORD PTR [rbp-0x34],eax
    12a1:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
    12a4:	3b 45 80             	cmp    eax,DWORD PTR [rbp-0x80]
    12a7:	0f 94 c0             	sete   al
    12aa:	0f b6 c0             	movzx  eax,al
    12ad:	89 45 c8             	mov    DWORD PTR [rbp-0x38],eax
				ssize_t rmax, bitc, btt = min(64, 16 * px_x);
    12b0:	8b 45 84             	mov    eax,DWORD PTR [rbp-0x7c]
    12b3:	c1 e0 04             	shl    eax,0x4
    12b6:	ba 40 00 00 00       	mov    edx,0x40
    12bb:	39 d0                	cmp    eax,edx
    12bd:	0f 4f c2             	cmovg  eax,edx
    12c0:	89 45 c4             	mov    DWORD PTR [rbp-0x3c],eax
				r = p0_x % 8;
    12c3:	8b 95 7c ff ff ff    	mov    edx,DWORD PTR [rbp-0x84]
    12c9:	89 d0                	mov    eax,edx
    12cb:	c1 f8 1f             	sar    eax,0x1f
    12ce:	c1 e8 1d             	shr    eax,0x1d
    12d1:	01 c2                	add    edx,eax
    12d3:	83 e2 07             	and    edx,0x7
    12d6:	29 c2                	sub    edx,eax
    12d8:	89 55 e8             	mov    DWORD PTR [rbp-0x18],edx
				rmax = min(8, r + min(4, px_x)); /* only 2 pixels */
    12db:	8b 45 84             	mov    eax,DWORD PTR [rbp-0x7c]
    12de:	ba 04 00 00 00       	mov    edx,0x4
    12e3:	39 d0                	cmp    eax,edx
    12e5:	0f 4e d0             	cmovle edx,eax
    12e8:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    12eb:	01 d0                	add    eax,edx
    12ed:	ba 08 00 00 00       	mov    edx,0x8
    12f2:	39 d0                	cmp    eax,edx
    12f4:	0f 4f c2             	cmovg  eax,edx
    12f7:	89 45 c0             	mov    DWORD PTR [rbp-0x40],eax
				/* get the remaining character pixels */
				bitc = generate_char_colors(font, str[0], str[1], btpp,
    12fa:	48 8b 7d a8          	mov    rdi,QWORD PTR [rbp-0x58]
    12fe:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1302:	48 83 c0 01          	add    rax,0x1
    1306:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1309:	0f be d0             	movsx  edx,al
    130c:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1310:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1313:	0f be f0             	movsx  esi,al
    1316:	44 8b 4d c0          	mov    r9d,DWORD PTR [rbp-0x40]
    131a:	44 8b 55 e8          	mov    r10d,DWORD PTR [rbp-0x18]
    131e:	48 8b 4d 10          	mov    rcx,QWORD PTR [rbp+0x10]
    1322:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1326:	44 8b 45 c8          	mov    r8d,DWORD PTR [rbp-0x38]
    132a:	41 50                	push   r8
    132c:	57                   	push   rdi
    132d:	45 89 d0             	mov    r8d,r10d
    1330:	48 89 c7             	mov    rdi,rax
    1333:	e8 00 00 00 00       	call   1338 <render_text_scanline_16btpp+0x2a5>
    1338:	48 83 c4 10          	add    rsp,0x10
    133c:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
								r, rmax, pixbuf, inv);
				/* now advance if neccessary */
				if (rmax == 8)
    133f:	83 7d c0 08          	cmp    DWORD PTR [rbp-0x40],0x8
    1343:	75 05                	jne    134a <render_text_scanline_16btpp+0x2b7>
						str += 2;
    1345:	48 83 45 90 02       	add    QWORD PTR [rbp-0x70],0x2
				/* and fetch up to three more pixels if needed (r=0) */
				if (bitc < btt) {
    134a:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    134d:	3b 45 c4             	cmp    eax,DWORD PTR [rbp-0x3c]
    1350:	7d 7a                	jge    13cc <render_text_scanline_16btpp+0x339>
						col++;
    1352:	83 45 cc 01          	add    DWORD PTR [rbp-0x34],0x1
						inv = (col == cur_x);
    1356:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
    1359:	3b 45 80             	cmp    eax,DWORD PTR [rbp-0x80]
    135c:	0f 94 c0             	sete   al
    135f:	0f b6 c0             	movzx  eax,al
    1362:	89 45 c8             	mov    DWORD PTR [rbp-0x38],eax
						bitc += generate_char_colors(font, str[0], str[1], btpp,
    1365:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
										0, (btt - bitc) / 16, pixbuf + bitc / 16, inv);
    1369:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    136c:	8d 48 0f             	lea    ecx,[rax+0xf]
    136f:	85 c0                	test   eax,eax
    1371:	0f 48 c1             	cmovs  eax,ecx
    1374:	c1 f8 04             	sar    eax,0x4
    1377:	48 98                	cdqe
						bitc += generate_char_colors(font, str[0], str[1], btpp,
    1379:	4c 8d 04 02          	lea    r8,[rdx+rax*1]
										0, (btt - bitc) / 16, pixbuf + bitc / 16, inv);
    137d:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    1380:	2b 45 fc             	sub    eax,DWORD PTR [rbp-0x4]
						bitc += generate_char_colors(font, str[0], str[1], btpp,
    1383:	8d 50 0f             	lea    edx,[rax+0xf]
    1386:	85 c0                	test   eax,eax
    1388:	0f 48 c2             	cmovs  eax,edx
    138b:	c1 f8 04             	sar    eax,0x4
    138e:	41 89 c1             	mov    r9d,eax
    1391:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1395:	48 83 c0 01          	add    rax,0x1
    1399:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    139c:	0f be d0             	movsx  edx,al
    139f:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    13a3:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    13a6:	0f be f0             	movsx  esi,al
    13a9:	48 8b 4d 10          	mov    rcx,QWORD PTR [rbp+0x10]
    13ad:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    13b1:	8b 7d c8             	mov    edi,DWORD PTR [rbp-0x38]
    13b4:	57                   	push   rdi
    13b5:	41 50                	push   r8
    13b7:	41 b8 00 00 00 00    	mov    r8d,0x0
    13bd:	48 89 c7             	mov    rdi,rax
    13c0:	e8 00 00 00 00       	call   13c5 <render_text_scanline_16btpp+0x332>
    13c5:	48 83 c4 10          	add    rsp,0x10
    13c9:	01 45 fc             	add    DWORD PTR [rbp-0x4],eax
				}
				/* now transfer */
				if (bitc >= 64) {
    13cc:	83 7d fc 3f          	cmp    DWORD PTR [rbp-0x4],0x3f
    13d0:	7e 29                	jle    13fb <render_text_scanline_16btpp+0x368>
						move_64(pixbuf, mem);
    13d2:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    13d6:	48 8b 55 88          	mov    rdx,QWORD PTR [rbp-0x78]
    13da:	0f 6f 00             	movq   mm0,QWORD PTR [rax]
    13dd:	0f 7f 02             	movq   QWORD PTR [rdx],mm0
						mem += 8; /* intentionally no bitc subtract */
    13e0:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    13e4:	48 83 c0 08          	add    rax,0x8
    13e8:	48 89 45 88          	mov    QWORD PTR [rbp-0x78],rax
						}
						break;
				}

				/* and don't advance as r = 0 is already handled (sth. remains) */
				if (px_x) {
    13ec:	83 7d 84 00          	cmp    DWORD PTR [rbp-0x7c],0x0
    13f0:	0f 84 c6 00 00 00    	je     14bc <render_text_scanline_16btpp+0x429>
    13f6:	e9 8e 00 00 00       	jmp    1489 <render_text_scanline_16btpp+0x3f6>
						void* pt = pixbuf;
    13fb:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    13ff:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
						if (bitc >= 32) {
    1403:	83 7d fc 1f          	cmp    DWORD PTR [rbp-0x4],0x1f
    1407:	7e 21                	jle    142a <render_text_scanline_16btpp+0x397>
								*(uint32_t*)mem = *(uint32_t*)pixbuf;
    1409:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    140d:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1411:	8b 12                	mov    edx,DWORD PTR [rdx]
    1413:	89 10                	mov    DWORD PTR [rax],edx
								mem += 4;
    1415:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1419:	48 83 c0 04          	add    rax,0x4
    141d:	48 89 45 88          	mov    QWORD PTR [rbp-0x78],rax
								pt += 4;
    1421:	48 83 45 f0 04       	add    QWORD PTR [rbp-0x10],0x4
								bitc -= 32;
    1426:	83 6d fc 20          	sub    DWORD PTR [rbp-0x4],0x20
						if (bitc >= 16) {
    142a:	83 7d fc 0f          	cmp    DWORD PTR [rbp-0x4],0xf
    142e:	7e 1e                	jle    144e <render_text_scanline_16btpp+0x3bb>
								*(uint32_t*)mem = *(uint32_t*)pt;
    1430:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1434:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1438:	8b 12                	mov    edx,DWORD PTR [rdx]
    143a:	89 10                	mov    DWORD PTR [rax],edx
								mem += 2;
    143c:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1440:	48 83 c0 02          	add    rax,0x2
    1444:	48 89 45 88          	mov    QWORD PTR [rbp-0x78],rax
								bitc -= 16;
    1448:	83 6d fc 10          	sub    DWORD PTR [rbp-0x4],0x10
						break;
    144c:	eb 71                	jmp    14bf <render_text_scanline_16btpp+0x42c>
						} else if (bitc) {
    144e:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
    1452:	74 6b                	je     14bf <render_text_scanline_16btpp+0x42c>
								die("cant happen with word sized pixels! %d\n", px_x);
    1454:	8b 45 84             	mov    eax,DWORD PTR [rbp-0x7c]
    1457:	89 c2                	mov    edx,eax
    1459:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1460:	bf 0c 00 00 00       	mov    edi,0xc
    1465:	b8 00 00 00 00       	mov    eax,0x0
    146a:	e8 00 00 00 00       	call   146f <render_text_scanline_16btpp+0x3dc>
    146f:	b8 00 00 00 00       	mov    eax,0x0
    1474:	e8 00 00 00 00       	call   1479 <render_text_scanline_16btpp+0x3e6>
    1479:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1480:	e8 00 00 00 00       	call   1485 <render_text_scanline_16btpp+0x3f2>
    1485:	fa                   	cli
    1486:	f4                   	hlt
    1487:	eb fd                	jmp    1486 <render_text_scanline_16btpp+0x3f3>
						px_x -= bitc / 16;
    1489:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    148c:	8d 50 0f             	lea    edx,[rax+0xf]
    148f:	85 c0                	test   eax,eax
    1491:	0f 48 c2             	cmovs  eax,edx
    1494:	c1 f8 04             	sar    eax,0x4
    1497:	f7 d8                	neg    eax
    1499:	01 45 84             	add    DWORD PTR [rbp-0x7c],eax
						p0_x += bitc / 16; /* unneccessary as r does not change anymore */
    149c:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    149f:	8d 50 0f             	lea    edx,[rax+0xf]
    14a2:	85 c0                	test   eax,eax
    14a4:	0f 48 c2             	cmovs  eax,edx
    14a7:	c1 f8 04             	sar    eax,0x4
    14aa:	01 85 7c ff ff ff    	add    DWORD PTR [rbp-0x84],eax
		while (px_x) {
    14b0:	83 7d 84 00          	cmp    DWORD PTR [rbp-0x7c],0x0
    14b4:	0f 85 d3 fd ff ff    	jne    128d <render_text_scanline_16btpp+0x1fa>
				} else
						break;
		}
}
    14ba:	eb 04                	jmp    14c0 <render_text_scanline_16btpp+0x42d>
						break;
    14bc:	90                   	nop
    14bd:	eb 01                	jmp    14c0 <render_text_scanline_16btpp+0x42d>
						break;
    14bf:	90                   	nop
}
    14c0:	90                   	nop
    14c1:	c9                   	leave
    14c2:	c3                   	ret

00000000000014c3 <render_text_scanline_32btpp>:

/* we're generating 4byte colorvalues /w unknown alignment. To enable
 * 8 byte transfer, two pixel have to be generated. */
void render_text_scanline_32btpp(const char* font, char* str, void* mem,
				ssize_t px_x, ssize_t cur_x, ssize_t p0_x)
{
    14c3:	55                   	push   rbp
    14c4:	48 89 e5             	mov    rbp,rsp
    14c7:	48 83 c4 80          	add    rsp,0xffffffffffffff80
    14cb:	48 89 7d a8          	mov    QWORD PTR [rbp-0x58],rdi
    14cf:	48 89 75 a0          	mov    QWORD PTR [rbp-0x60],rsi
    14d3:	48 89 55 98          	mov    QWORD PTR [rbp-0x68],rdx
    14d7:	89 4d 94             	mov    DWORD PTR [rbp-0x6c],ecx
    14da:	44 89 45 90          	mov    DWORD PTR [rbp-0x70],r8d
    14de:	44 89 4d 8c          	mov    DWORD PTR [rbp-0x74],r9d
		uint8_t pxb[8 + 7]; /* 7 for stack alignment */
		ssize_t misalign = ((size_t)mem % 8) ? (8 - (size_t)mem % 8) : 0;
    14e2:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    14e6:	83 e0 07             	and    eax,0x7
    14e9:	48 85 c0             	test   rax,rax
    14ec:	74 12                	je     1500 <render_text_scanline_32btpp+0x3d>
    14ee:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    14f2:	83 e0 07             	and    eax,0x7
    14f5:	ba 08 00 00 00       	mov    edx,0x8
    14fa:	29 c2                	sub    edx,eax
    14fc:	89 d0                	mov    eax,edx
    14fe:	eb 05                	jmp    1505 <render_text_scanline_32btpp+0x42>
    1500:	b8 00 00 00 00       	mov    eax,0x0
    1505:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
		ssize_t r = p0_x % 8;
    1508:	8b 55 8c             	mov    edx,DWORD PTR [rbp-0x74]
    150b:	89 d0                	mov    eax,edx
    150d:	c1 f8 1f             	sar    eax,0x1f
    1510:	c1 e8 1d             	shr    eax,0x1d
    1513:	01 c2                	add    edx,eax
    1515:	83 e2 07             	and    edx,0x7
    1518:	29 c2                	sub    edx,eax
    151a:	89 55 f4             	mov    DWORD PTR [rbp-0xc],edx
		uint8_t* pixbuf = pxb + (((size_t)pxb % 8) ? (8 - ((size_t)pxb % 8)) : 0);
    151d:	48 8d 45 c1          	lea    rax,[rbp-0x3f]
    1521:	83 e0 07             	and    eax,0x7
    1524:	48 85 c0             	test   rax,rax
    1527:	74 14                	je     153d <render_text_scanline_32btpp+0x7a>
    1529:	48 8d 45 c1          	lea    rax,[rbp-0x3f]
    152d:	83 e0 07             	and    eax,0x7
    1530:	48 89 c2             	mov    rdx,rax
    1533:	b8 08 00 00 00       	mov    eax,0x8
    1538:	48 29 d0             	sub    rax,rdx
    153b:	eb 05                	jmp    1542 <render_text_scanline_32btpp+0x7f>
    153d:	b8 00 00 00 00       	mov    eax,0x0
    1542:	48 8d 55 c1          	lea    rdx,[rbp-0x3f]
    1546:	48 01 d0             	add    rax,rdx
    1549:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
		/* 64-bit aligned moves are enough */

		if (misalign) { /* LFB is dword aligned, we want qword access */
    154d:	83 7d f8 00          	cmp    DWORD PTR [rbp-0x8],0x0
    1551:	0f 84 ad 02 00 00    	je     1804 <render_text_scanline_32btpp+0x341>
				int col = p0_x / 8, inv = (col == cur_x);
    1557:	8b 45 8c             	mov    eax,DWORD PTR [rbp-0x74]
    155a:	8d 50 07             	lea    edx,[rax+0x7]
    155d:	85 c0                	test   eax,eax
    155f:	0f 48 c2             	cmovs  eax,edx
    1562:	c1 f8 03             	sar    eax,0x3
    1565:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
    1568:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
    156b:	3b 45 90             	cmp    eax,DWORD PTR [rbp-0x70]
    156e:	0f 94 c0             	sete   al
    1571:	0f b6 c0             	movzx  eax,al
    1574:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
				ssize_t bc = min(misalign, 4 * px_x);
    1577:	8b 45 94             	mov    eax,DWORD PTR [rbp-0x6c]
    157a:	c1 e0 02             	shl    eax,0x2
    157d:	8b 55 f8             	mov    edx,DWORD PTR [rbp-0x8]
    1580:	39 c2                	cmp    edx,eax
    1582:	0f 4e c2             	cmovle eax,edx
    1585:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
				ssize_t cc = rdiv(misalign, 4);
    1588:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    158b:	8d 50 03             	lea    edx,[rax+0x3]
    158e:	85 c0                	test   eax,eax
    1590:	0f 48 c2             	cmovs  eax,edx
    1593:	c1 f8 02             	sar    eax,0x2
    1596:	89 c2                	mov    edx,eax
    1598:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    159b:	83 e0 03             	and    eax,0x3
    159e:	85 c0                	test   eax,eax
    15a0:	0f 95 c0             	setne  al
    15a3:	0f b6 c0             	movzx  eax,al
    15a6:	01 d0                	add    eax,edx
    15a8:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
				ssize_t rmax = min(8, r + cc); //, cc1 = rmax - r;
    15ab:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    15ae:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    15b1:	01 d0                	add    eax,edx
    15b3:	ba 08 00 00 00       	mov    edx,0x8
    15b8:	39 d0                	cmp    eax,edx
    15ba:	0f 4f c2             	cmovg  eax,edx
    15bd:	89 45 e0             	mov    DWORD PTR [rbp-0x20],eax

				generate_char_colors(font, str[0], str[1], 32,
    15c0:	48 8b 4d b8          	mov    rcx,QWORD PTR [rbp-0x48]
    15c4:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    15c8:	48 83 c0 01          	add    rax,0x1
    15cc:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    15cf:	0f be d0             	movsx  edx,al
    15d2:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    15d6:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    15d9:	0f be f0             	movsx  esi,al
    15dc:	44 8b 4d e0          	mov    r9d,DWORD PTR [rbp-0x20]
    15e0:	44 8b 45 f4          	mov    r8d,DWORD PTR [rbp-0xc]
    15e4:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    15e8:	8b 7d ec             	mov    edi,DWORD PTR [rbp-0x14]
    15eb:	57                   	push   rdi
    15ec:	51                   	push   rcx
    15ed:	b9 20 00 00 00       	mov    ecx,0x20
    15f2:	48 89 c7             	mov    rdi,rax
    15f5:	e8 00 00 00 00       	call   15fa <render_text_scanline_32btpp+0x137>
    15fa:	48 83 c4 10          	add    rsp,0x10
								r, rmax, pixbuf, inv);
				if (rmax == 8)
    15fe:	83 7d e0 08          	cmp    DWORD PTR [rbp-0x20],0x8
    1602:	75 05                	jne    1609 <render_text_scanline_32btpp+0x146>
						str += 2;
    1604:	48 83 45 a0 02       	add    QWORD PTR [rbp-0x60],0x2
				// if (cc > cc1) <- does not happen cc always 1
				memcpy(mem, pixbuf, bc);
    1609:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    160c:	48 63 d0             	movsxd rdx,eax
    160f:	48 8b 4d b8          	mov    rcx,QWORD PTR [rbp-0x48]
    1613:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1617:	48 89 ce             	mov    rsi,rcx
    161a:	48 89 c7             	mov    rdi,rax
    161d:	e8 de e9 ff ff       	call   0 <memcpy>
				px_x -= cc;
    1622:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    1625:	29 45 94             	sub    DWORD PTR [rbp-0x6c],eax
				p0_x += cc;
    1628:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    162b:	01 45 8c             	add    DWORD PTR [rbp-0x74],eax
				mem += bc;
    162e:	48 8b 55 98          	mov    rdx,QWORD PTR [rbp-0x68]
    1632:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    1635:	48 98                	cdqe
    1637:	48 01 d0             	add    rax,rdx
    163a:	48 89 45 98          	mov    QWORD PTR [rbp-0x68],rax
		}

		/* draw 2 pixels each */
		while (px_x) {
    163e:	e9 c1 01 00 00       	jmp    1804 <render_text_scanline_32btpp+0x341>
				int col = p0_x / 8, inv = (col == cur_x);
    1643:	8b 45 8c             	mov    eax,DWORD PTR [rbp-0x74]
    1646:	8d 50 07             	lea    edx,[rax+0x7]
    1649:	85 c0                	test   eax,eax
    164b:	0f 48 c2             	cmovs  eax,edx
    164e:	c1 f8 03             	sar    eax,0x3
    1651:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
    1654:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    1657:	3b 45 90             	cmp    eax,DWORD PTR [rbp-0x70]
    165a:	0f 94 c0             	sete   al
    165d:	0f b6 c0             	movzx  eax,al
    1660:	89 45 d8             	mov    DWORD PTR [rbp-0x28],eax
				ssize_t rmax, bitc, btt = min(64, 32 * px_x);
    1663:	8b 45 94             	mov    eax,DWORD PTR [rbp-0x6c]
    1666:	c1 e0 05             	shl    eax,0x5
    1669:	ba 40 00 00 00       	mov    edx,0x40
    166e:	39 d0                	cmp    eax,edx
    1670:	0f 4f c2             	cmovg  eax,edx
    1673:	89 45 d4             	mov    DWORD PTR [rbp-0x2c],eax
				r = p0_x % 8;
    1676:	8b 55 8c             	mov    edx,DWORD PTR [rbp-0x74]
    1679:	89 d0                	mov    eax,edx
    167b:	c1 f8 1f             	sar    eax,0x1f
    167e:	c1 e8 1d             	shr    eax,0x1d
    1681:	01 c2                	add    edx,eax
    1683:	83 e2 07             	and    edx,0x7
    1686:	29 c2                	sub    edx,eax
    1688:	89 55 f4             	mov    DWORD PTR [rbp-0xc],edx
				rmax = min(8, r + min(2, px_x)); /* only 2 pixels */
    168b:	8b 45 94             	mov    eax,DWORD PTR [rbp-0x6c]
    168e:	ba 02 00 00 00       	mov    edx,0x2
    1693:	39 d0                	cmp    eax,edx
    1695:	0f 4e d0             	cmovle edx,eax
    1698:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    169b:	01 d0                	add    eax,edx
    169d:	ba 08 00 00 00       	mov    edx,0x8
    16a2:	39 d0                	cmp    eax,edx
    16a4:	0f 4f c2             	cmovg  eax,edx
    16a7:	89 45 d0             	mov    DWORD PTR [rbp-0x30],eax
				/* get the remaining character pixels */
				bitc = generate_char_colors(font, str[0], str[1], 32,
    16aa:	48 8b 4d b8          	mov    rcx,QWORD PTR [rbp-0x48]
    16ae:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    16b2:	48 83 c0 01          	add    rax,0x1
    16b6:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    16b9:	0f be d0             	movsx  edx,al
    16bc:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    16c0:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    16c3:	0f be f0             	movsx  esi,al
    16c6:	44 8b 4d d0          	mov    r9d,DWORD PTR [rbp-0x30]
    16ca:	44 8b 45 f4          	mov    r8d,DWORD PTR [rbp-0xc]
    16ce:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    16d2:	8b 7d d8             	mov    edi,DWORD PTR [rbp-0x28]
    16d5:	57                   	push   rdi
    16d6:	51                   	push   rcx
    16d7:	b9 20 00 00 00       	mov    ecx,0x20
    16dc:	48 89 c7             	mov    rdi,rax
    16df:	e8 00 00 00 00       	call   16e4 <render_text_scanline_32btpp+0x221>
    16e4:	48 83 c4 10          	add    rsp,0x10
    16e8:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
								r, rmax, pixbuf, inv);
				/* now advance if neccessary */
				if (rmax == 8)
    16eb:	83 7d d0 08          	cmp    DWORD PTR [rbp-0x30],0x8
    16ef:	75 05                	jne    16f6 <render_text_scanline_32btpp+0x233>
						str += 2;
    16f1:	48 83 45 a0 02       	add    QWORD PTR [rbp-0x60],0x2
				/* and fetch one more pixel if needed (r=0) */
				if (bitc < btt) {
    16f6:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    16f9:	3b 45 d4             	cmp    eax,DWORD PTR [rbp-0x2c]
    16fc:	7d 5c                	jge    175a <render_text_scanline_32btpp+0x297>
						col++;
    16fe:	83 45 dc 01          	add    DWORD PTR [rbp-0x24],0x1
						inv = (col == cur_x);
    1702:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    1705:	3b 45 90             	cmp    eax,DWORD PTR [rbp-0x70]
    1708:	0f 94 c0             	sete   al
    170b:	0f b6 c0             	movzx  eax,al
    170e:	89 45 d8             	mov    DWORD PTR [rbp-0x28],eax
						bitc += generate_char_colors(font, str[0], str[1], 32,
    1711:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1715:	48 8d 78 04          	lea    rdi,[rax+0x4]
    1719:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    171d:	48 83 c0 01          	add    rax,0x1
    1721:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1724:	0f be d0             	movsx  edx,al
    1727:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    172b:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    172e:	0f be f0             	movsx  esi,al
    1731:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1735:	8b 4d d8             	mov    ecx,DWORD PTR [rbp-0x28]
    1738:	51                   	push   rcx
    1739:	57                   	push   rdi
    173a:	41 b9 01 00 00 00    	mov    r9d,0x1
    1740:	41 b8 00 00 00 00    	mov    r8d,0x0
    1746:	b9 20 00 00 00       	mov    ecx,0x20
    174b:	48 89 c7             	mov    rdi,rax
    174e:	e8 00 00 00 00       	call   1753 <render_text_scanline_32btpp+0x290>
    1753:	48 83 c4 10          	add    rsp,0x10
    1757:	01 45 fc             	add    DWORD PTR [rbp-0x4],eax
										0, 1, pixbuf + 4, inv);
				}
				/* now transfer */
				if (bitc >= 64) {
    175a:	83 7d fc 3f          	cmp    DWORD PTR [rbp-0x4],0x3f
    175e:	7e 26                	jle    1786 <render_text_scanline_32btpp+0x2c3>
						move_64(pixbuf, mem);
    1760:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1764:	48 8b 55 98          	mov    rdx,QWORD PTR [rbp-0x68]
    1768:	0f 6f 00             	movq   mm0,QWORD PTR [rax]
    176b:	0f 7f 02             	movq   QWORD PTR [rdx],mm0
						mem += 8; /* intentionally no bitc subtract */
    176e:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1772:	48 83 c0 08          	add    rax,0x8
    1776:	48 89 45 98          	mov    QWORD PTR [rbp-0x68],rax
						}
						break;
				}

				/* and don't advance as r = 0 is already handled (sth. remains) */
				if (px_x) {
    177a:	83 7d 94 00          	cmp    DWORD PTR [rbp-0x6c],0x0
    177e:	0f 84 8c 00 00 00    	je     1810 <render_text_scanline_32btpp+0x34d>
    1784:	eb 5a                	jmp    17e0 <render_text_scanline_32btpp+0x31d>
						if (bitc >= 32) {
    1786:	83 7d fc 1f          	cmp    DWORD PTR [rbp-0x4],0x1f
    178a:	7e 1e                	jle    17aa <render_text_scanline_32btpp+0x2e7>
								*(uint32_t*)mem = *(uint32_t*)pixbuf;
    178c:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
    1790:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1794:	8b 12                	mov    edx,DWORD PTR [rdx]
    1796:	89 10                	mov    DWORD PTR [rax],edx
								mem += 4;
    1798:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    179c:	48 83 c0 04          	add    rax,0x4
    17a0:	48 89 45 98          	mov    QWORD PTR [rbp-0x68],rax
								bitc -= 32;
    17a4:	83 6d fc 20          	sub    DWORD PTR [rbp-0x4],0x20
						break;
    17a8:	eb 69                	jmp    1813 <render_text_scanline_32btpp+0x350>
						} else if (bitc) {
    17aa:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
    17ae:	74 63                	je     1813 <render_text_scanline_32btpp+0x350>
								die("cant happen with dword sized pixels!\n");
    17b0:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    17b7:	bf 0c 00 00 00       	mov    edi,0xc
    17bc:	b8 00 00 00 00       	mov    eax,0x0
    17c1:	e8 00 00 00 00       	call   17c6 <render_text_scanline_32btpp+0x303>
    17c6:	b8 00 00 00 00       	mov    eax,0x0
    17cb:	e8 00 00 00 00       	call   17d0 <render_text_scanline_32btpp+0x30d>
    17d0:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    17d7:	e8 00 00 00 00       	call   17dc <render_text_scanline_32btpp+0x319>
    17dc:	fa                   	cli
    17dd:	f4                   	hlt
    17de:	eb fd                	jmp    17dd <render_text_scanline_32btpp+0x31a>
						px_x -= bitc / 32;
    17e0:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    17e3:	8d 50 1f             	lea    edx,[rax+0x1f]
    17e6:	85 c0                	test   eax,eax
    17e8:	0f 48 c2             	cmovs  eax,edx
    17eb:	c1 f8 05             	sar    eax,0x5
    17ee:	f7 d8                	neg    eax
    17f0:	01 45 94             	add    DWORD PTR [rbp-0x6c],eax
						p0_x += bitc / 32; /* unneccessary as r does not change anymore */
    17f3:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    17f6:	8d 50 1f             	lea    edx,[rax+0x1f]
    17f9:	85 c0                	test   eax,eax
    17fb:	0f 48 c2             	cmovs  eax,edx
    17fe:	c1 f8 05             	sar    eax,0x5
    1801:	01 45 8c             	add    DWORD PTR [rbp-0x74],eax
		while (px_x) {
    1804:	83 7d 94 00          	cmp    DWORD PTR [rbp-0x6c],0x0
    1808:	0f 85 35 fe ff ff    	jne    1643 <render_text_scanline_32btpp+0x180>
				} else
						break;
		}
}
    180e:	eb 04                	jmp    1814 <render_text_scanline_32btpp+0x351>
						break;
    1810:	90                   	nop
    1811:	eb 01                	jmp    1814 <render_text_scanline_32btpp+0x351>
						break;
    1813:	90                   	nop
}
    1814:	90                   	nop
    1815:	c9                   	leave
    1816:	c3                   	ret

0000000000001817 <render_text_scanline_8btpp>:

/* ~32 times better performance than /w byte access in old method below */
void render_text_scanline_8btpp(const char* font, char* str, void* mem,
				ssize_t px_x, ssize_t cur_x, ssize_t p0_x)
{
    1817:	55                   	push   rbp
    1818:	48 89 e5             	mov    rbp,rsp
    181b:	48 81 ec 90 00 00 00 	sub    rsp,0x90
    1822:	48 89 7d 98          	mov    QWORD PTR [rbp-0x68],rdi
    1826:	48 89 75 90          	mov    QWORD PTR [rbp-0x70],rsi
    182a:	48 89 55 88          	mov    QWORD PTR [rbp-0x78],rdx
    182e:	89 4d 84             	mov    DWORD PTR [rbp-0x7c],ecx
    1831:	44 89 45 80          	mov    DWORD PTR [rbp-0x80],r8d
    1835:	44 89 8d 7c ff ff ff 	mov    DWORD PTR [rbp-0x84],r9d
		uint8_t pxb[8 + 7]; /* for any stack alignment */
		ssize_t misalign = ((size_t)mem % 8) ? (8 - (size_t)mem % 8) : 0;
    183c:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1840:	83 e0 07             	and    eax,0x7
    1843:	48 85 c0             	test   rax,rax
    1846:	74 12                	je     185a <render_text_scanline_8btpp+0x43>
    1848:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    184c:	83 e0 07             	and    eax,0x7
    184f:	ba 08 00 00 00       	mov    edx,0x8
    1854:	29 c2                	sub    edx,eax
    1856:	89 d0                	mov    eax,edx
    1858:	eb 05                	jmp    185f <render_text_scanline_8btpp+0x48>
    185a:	b8 00 00 00 00       	mov    eax,0x0
    185f:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
		ssize_t r = p0_x % 8;
    1862:	8b 95 7c ff ff ff    	mov    edx,DWORD PTR [rbp-0x84]
    1868:	89 d0                	mov    eax,edx
    186a:	c1 f8 1f             	sar    eax,0x1f
    186d:	c1 e8 1d             	shr    eax,0x1d
    1870:	01 c2                	add    edx,eax
    1872:	83 e2 07             	and    edx,0x7
    1875:	29 c2                	sub    edx,eax
    1877:	89 55 e8             	mov    DWORD PTR [rbp-0x18],edx
		uint8_t* pixbuf = pxb + (((size_t)pxb % 8) ? (8 - ((size_t)pxb % 8)) : 0);
    187a:	48 8d 45 b5          	lea    rax,[rbp-0x4b]
    187e:	83 e0 07             	and    eax,0x7
    1881:	48 85 c0             	test   rax,rax
    1884:	74 14                	je     189a <render_text_scanline_8btpp+0x83>
    1886:	48 8d 45 b5          	lea    rax,[rbp-0x4b]
    188a:	83 e0 07             	and    eax,0x7
    188d:	48 89 c2             	mov    rdx,rax
    1890:	b8 08 00 00 00       	mov    eax,0x8
    1895:	48 29 d0             	sub    rax,rdx
    1898:	eb 05                	jmp    189f <render_text_scanline_8btpp+0x88>
    189a:	b8 00 00 00 00       	mov    eax,0x0
    189f:	48 8d 55 b5          	lea    rdx,[rbp-0x4b]
    18a3:	48 01 d0             	add    rax,rdx
    18a6:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
		/* 64-bit aligned moves are enough */

		if (misalign) { /* we first have to draw misalign pixels */
    18aa:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
    18ae:	0f 84 80 03 00 00    	je     1c34 <render_text_scanline_8btpp+0x41d>
				int col = p0_x / 8, inv = (col == cur_x);
    18b4:	8b 85 7c ff ff ff    	mov    eax,DWORD PTR [rbp-0x84]
    18ba:	8d 50 07             	lea    edx,[rax+0x7]
    18bd:	85 c0                	test   eax,eax
    18bf:	0f 48 c2             	cmovs  eax,edx
    18c2:	c1 f8 03             	sar    eax,0x3
    18c5:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
    18c8:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    18cb:	3b 45 80             	cmp    eax,DWORD PTR [rbp-0x80]
    18ce:	0f 94 c0             	sete   al
    18d1:	0f b6 c0             	movzx  eax,al
    18d4:	89 45 e0             	mov    DWORD PTR [rbp-0x20],eax
				ssize_t bc = min(misalign, px_x); /* r already set */
    18d7:	8b 55 84             	mov    edx,DWORD PTR [rbp-0x7c]
    18da:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    18dd:	39 c2                	cmp    edx,eax
    18df:	0f 4e c2             	cmovle eax,edx
    18e2:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
				ssize_t rmax = min(8, r + bc), bc1 = rmax - r;
    18e5:	8b 55 e8             	mov    edx,DWORD PTR [rbp-0x18]
    18e8:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    18eb:	01 d0                	add    eax,edx
    18ed:	ba 08 00 00 00       	mov    edx,0x8
    18f2:	39 d0                	cmp    eax,edx
    18f4:	0f 4f c2             	cmovg  eax,edx
    18f7:	89 45 d8             	mov    DWORD PTR [rbp-0x28],eax
    18fa:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    18fd:	2b 45 e8             	sub    eax,DWORD PTR [rbp-0x18]
    1900:	89 45 d4             	mov    DWORD PTR [rbp-0x2c],eax

				generate_char_colors(font, str[0], str[1], 8,
    1903:	48 8b 4d a8          	mov    rcx,QWORD PTR [rbp-0x58]
    1907:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    190b:	48 83 c0 01          	add    rax,0x1
    190f:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1912:	0f be d0             	movsx  edx,al
    1915:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1919:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    191c:	0f be f0             	movsx  esi,al
    191f:	44 8b 4d d8          	mov    r9d,DWORD PTR [rbp-0x28]
    1923:	44 8b 45 e8          	mov    r8d,DWORD PTR [rbp-0x18]
    1927:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    192b:	8b 7d e0             	mov    edi,DWORD PTR [rbp-0x20]
    192e:	57                   	push   rdi
    192f:	51                   	push   rcx
    1930:	b9 08 00 00 00       	mov    ecx,0x8
    1935:	48 89 c7             	mov    rdi,rax
    1938:	e8 00 00 00 00       	call   193d <render_text_scanline_8btpp+0x126>
    193d:	48 83 c4 10          	add    rsp,0x10
								r, rmax, pixbuf, inv);
				if (rmax == 8)
    1941:	83 7d d8 08          	cmp    DWORD PTR [rbp-0x28],0x8
    1945:	75 05                	jne    194c <render_text_scanline_8btpp+0x135>
						str += 2;
    1947:	48 83 45 90 02       	add    QWORD PTR [rbp-0x70],0x2
				if (bc > bc1) {
    194c:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    194f:	3b 45 d4             	cmp    eax,DWORD PTR [rbp-0x2c]
    1952:	7e 64                	jle    19b8 <render_text_scanline_8btpp+0x1a1>
						col++;
    1954:	83 45 e4 01          	add    DWORD PTR [rbp-0x1c],0x1
						inv = (col == cur_x);
    1958:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    195b:	3b 45 80             	cmp    eax,DWORD PTR [rbp-0x80]
    195e:	0f 94 c0             	sete   al
    1961:	0f b6 c0             	movzx  eax,al
    1964:	89 45 e0             	mov    DWORD PTR [rbp-0x20],eax
						generate_char_colors(font, str[0], str[1], 8,
    1967:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    196b:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
    196e:	48 98                	cdqe
    1970:	48 8d 3c 02          	lea    rdi,[rdx+rax*1]
    1974:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    1977:	2b 45 d4             	sub    eax,DWORD PTR [rbp-0x2c]
    197a:	41 89 c0             	mov    r8d,eax
    197d:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1981:	48 83 c0 01          	add    rax,0x1
    1985:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1988:	0f be d0             	movsx  edx,al
    198b:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    198f:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1992:	0f be f0             	movsx  esi,al
    1995:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1999:	8b 4d e0             	mov    ecx,DWORD PTR [rbp-0x20]
    199c:	51                   	push   rcx
    199d:	57                   	push   rdi
    199e:	45 89 c1             	mov    r9d,r8d
    19a1:	41 b8 00 00 00 00    	mov    r8d,0x0
    19a7:	b9 08 00 00 00       	mov    ecx,0x8
    19ac:	48 89 c7             	mov    rdi,rax
    19af:	e8 00 00 00 00       	call   19b4 <render_text_scanline_8btpp+0x19d>
    19b4:	48 83 c4 10          	add    rsp,0x10
										0, bc - bc1, pixbuf + bc1, inv);
				}
				memcpy(mem, pixbuf, bc);
    19b8:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    19bb:	48 63 d0             	movsxd rdx,eax
    19be:	48 8b 4d a8          	mov    rcx,QWORD PTR [rbp-0x58]
    19c2:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    19c6:	48 89 ce             	mov    rsi,rcx
    19c9:	48 89 c7             	mov    rdi,rax
    19cc:	e8 2f e6 ff ff       	call   0 <memcpy>
				px_x -= bc;
    19d1:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    19d4:	29 45 84             	sub    DWORD PTR [rbp-0x7c],eax
				p0_x += bc;
    19d7:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    19da:	01 85 7c ff ff ff    	add    DWORD PTR [rbp-0x84],eax
				mem += bc;
    19e0:	48 8b 55 88          	mov    rdx,QWORD PTR [rbp-0x78]
    19e4:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    19e7:	48 98                	cdqe
    19e9:	48 01 d0             	add    rax,rdx
    19ec:	48 89 45 88          	mov    QWORD PTR [rbp-0x78],rax
		}

		/* now we can draw 8 pixels each */
		while (px_x) {
    19f0:	e9 3f 02 00 00       	jmp    1c34 <render_text_scanline_8btpp+0x41d>
				int col = p0_x / 8, inv = (col == cur_x);
    19f5:	8b 85 7c ff ff ff    	mov    eax,DWORD PTR [rbp-0x84]
    19fb:	8d 50 07             	lea    edx,[rax+0x7]
    19fe:	85 c0                	test   eax,eax
    1a00:	0f 48 c2             	cmovs  eax,edx
    1a03:	c1 f8 03             	sar    eax,0x3
    1a06:	89 45 d0             	mov    DWORD PTR [rbp-0x30],eax
    1a09:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
    1a0c:	3b 45 80             	cmp    eax,DWORD PTR [rbp-0x80]
    1a0f:	0f 94 c0             	sete   al
    1a12:	0f b6 c0             	movzx  eax,al
    1a15:	89 45 cc             	mov    DWORD PTR [rbp-0x34],eax
				ssize_t rmax, bitc, btt = min(64, 8 * px_x), cc;
    1a18:	8b 45 84             	mov    eax,DWORD PTR [rbp-0x7c]
    1a1b:	c1 e0 03             	shl    eax,0x3
    1a1e:	ba 40 00 00 00       	mov    edx,0x40
    1a23:	39 d0                	cmp    eax,edx
    1a25:	0f 4f c2             	cmovg  eax,edx
    1a28:	89 45 c8             	mov    DWORD PTR [rbp-0x38],eax
				r = p0_x % 8;
    1a2b:	8b 95 7c ff ff ff    	mov    edx,DWORD PTR [rbp-0x84]
    1a31:	89 d0                	mov    eax,edx
    1a33:	c1 f8 1f             	sar    eax,0x1f
    1a36:	c1 e8 1d             	shr    eax,0x1d
    1a39:	01 c2                	add    edx,eax
    1a3b:	83 e2 07             	and    edx,0x7
    1a3e:	29 c2                	sub    edx,eax
    1a40:	89 55 e8             	mov    DWORD PTR [rbp-0x18],edx
				rmax = min(8, r + px_x);
    1a43:	8b 55 e8             	mov    edx,DWORD PTR [rbp-0x18]
    1a46:	8b 45 84             	mov    eax,DWORD PTR [rbp-0x7c]
    1a49:	01 d0                	add    eax,edx
    1a4b:	ba 08 00 00 00       	mov    edx,0x8
    1a50:	39 d0                	cmp    eax,edx
    1a52:	0f 4f c2             	cmovg  eax,edx
    1a55:	89 45 c4             	mov    DWORD PTR [rbp-0x3c],eax
				/* get the remaining character pixels */
				bitc = generate_char_colors(font, str[0], str[1], 8,
    1a58:	48 8b 4d a8          	mov    rcx,QWORD PTR [rbp-0x58]
    1a5c:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1a60:	48 83 c0 01          	add    rax,0x1
    1a64:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1a67:	0f be d0             	movsx  edx,al
    1a6a:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1a6e:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1a71:	0f be f0             	movsx  esi,al
    1a74:	44 8b 4d c4          	mov    r9d,DWORD PTR [rbp-0x3c]
    1a78:	44 8b 45 e8          	mov    r8d,DWORD PTR [rbp-0x18]
    1a7c:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1a80:	8b 7d cc             	mov    edi,DWORD PTR [rbp-0x34]
    1a83:	57                   	push   rdi
    1a84:	51                   	push   rcx
    1a85:	b9 08 00 00 00       	mov    ecx,0x8
    1a8a:	48 89 c7             	mov    rdi,rax
    1a8d:	e8 00 00 00 00       	call   1a92 <render_text_scanline_8btpp+0x27b>
    1a92:	48 83 c4 10          	add    rsp,0x10
    1a96:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
								r, rmax, pixbuf, inv);
				/* now advance */
				str += 2;
    1a99:	48 83 45 90 02       	add    QWORD PTR [rbp-0x70],0x2
				cc = bitc / 8;
    1a9e:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1aa1:	8d 50 07             	lea    edx,[rax+0x7]
    1aa4:	85 c0                	test   eax,eax
    1aa6:	0f 48 c2             	cmovs  eax,edx
    1aa9:	c1 f8 03             	sar    eax,0x3
    1aac:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
				/* and fetch more pixels if needed (r=0) */
				if (bitc < btt) {
    1aaf:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1ab2:	3b 45 c8             	cmp    eax,DWORD PTR [rbp-0x38]
    1ab5:	0f 8d 83 00 00 00    	jge    1b3e <render_text_scanline_8btpp+0x327>
						col++;
    1abb:	83 45 d0 01          	add    DWORD PTR [rbp-0x30],0x1
						inv = (col == cur_x);
    1abf:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
    1ac2:	3b 45 80             	cmp    eax,DWORD PTR [rbp-0x80]
    1ac5:	0f 94 c0             	sete   al
    1ac8:	0f b6 c0             	movzx  eax,al
    1acb:	89 45 cc             	mov    DWORD PTR [rbp-0x34],eax
						bitc += generate_char_colors(font, str[0], str[1], 8,
    1ace:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1ad2:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    1ad5:	48 98                	cdqe
    1ad7:	4c 8d 04 02          	lea    r8,[rdx+rax*1]
    1adb:	83 7d 84 08          	cmp    DWORD PTR [rbp-0x7c],0x8
    1adf:	7e 0a                	jle    1aeb <render_text_scanline_8btpp+0x2d4>
    1ae1:	b8 08 00 00 00       	mov    eax,0x8
    1ae6:	2b 45 f8             	sub    eax,DWORD PTR [rbp-0x8]
    1ae9:	eb 06                	jmp    1af1 <render_text_scanline_8btpp+0x2da>
    1aeb:	8b 45 84             	mov    eax,DWORD PTR [rbp-0x7c]
    1aee:	2b 45 f8             	sub    eax,DWORD PTR [rbp-0x8]
    1af1:	48 8b 55 90          	mov    rdx,QWORD PTR [rbp-0x70]
    1af5:	48 83 c2 01          	add    rdx,0x1
    1af9:	0f b6 12             	movzx  edx,BYTE PTR [rdx]
    1afc:	0f be d2             	movsx  edx,dl
    1aff:	48 8b 4d 90          	mov    rcx,QWORD PTR [rbp-0x70]
    1b03:	0f b6 09             	movzx  ecx,BYTE PTR [rcx]
    1b06:	0f be f1             	movsx  esi,cl
    1b09:	48 8b 7d 98          	mov    rdi,QWORD PTR [rbp-0x68]
    1b0d:	8b 4d cc             	mov    ecx,DWORD PTR [rbp-0x34]
    1b10:	51                   	push   rcx
    1b11:	41 50                	push   r8
    1b13:	41 89 c1             	mov    r9d,eax
    1b16:	41 b8 00 00 00 00    	mov    r8d,0x0
    1b1c:	b9 08 00 00 00       	mov    ecx,0x8
    1b21:	e8 00 00 00 00       	call   1b26 <render_text_scanline_8btpp+0x30f>
    1b26:	48 83 c4 10          	add    rsp,0x10
    1b2a:	01 45 fc             	add    DWORD PTR [rbp-0x4],eax
										0, min(8 - cc, px_x - cc), pixbuf + cc, inv);
						cc = bitc / 8;
    1b2d:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1b30:	8d 50 07             	lea    edx,[rax+0x7]
    1b33:	85 c0                	test   eax,eax
    1b35:	0f 48 c2             	cmovs  eax,edx
    1b38:	c1 f8 03             	sar    eax,0x3
    1b3b:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
				}
				/* now transfer */
				if (bitc >= 64) {
    1b3e:	83 7d fc 3f          	cmp    DWORD PTR [rbp-0x4],0x3f
    1b42:	7e 29                	jle    1b6d <render_text_scanline_8btpp+0x356>
						move_64(pixbuf, mem);
    1b44:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1b48:	48 8b 55 88          	mov    rdx,QWORD PTR [rbp-0x78]
    1b4c:	0f 6f 00             	movq   mm0,QWORD PTR [rax]
    1b4f:	0f 7f 02             	movq   QWORD PTR [rdx],mm0
						mem += 8; /* intentionally no bitc subtract */
    1b52:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1b56:	48 83 c0 08          	add    rax,0x8
    1b5a:	48 89 45 88          	mov    QWORD PTR [rbp-0x78],rax
						}
						break;
				}

				/* and don't advance as r = 0 is already handled (sth. remains) */
				if (px_x) {
    1b5e:	83 7d 84 00          	cmp    DWORD PTR [rbp-0x7c],0x0
    1b62:	0f 84 d8 00 00 00    	je     1c40 <render_text_scanline_8btpp+0x429>
    1b68:	e9 b8 00 00 00       	jmp    1c25 <render_text_scanline_8btpp+0x40e>
						uint8_t* pt = pixbuf;
    1b6d:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1b71:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
						if (bitc >= 32) {
    1b75:	83 7d fc 1f          	cmp    DWORD PTR [rbp-0x4],0x1f
    1b79:	7e 21                	jle    1b9c <render_text_scanline_8btpp+0x385>
								*(uint32_t*)mem = *(uint32_t*)pixbuf;
    1b7b:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1b7f:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1b83:	8b 12                	mov    edx,DWORD PTR [rdx]
    1b85:	89 10                	mov    DWORD PTR [rax],edx
								pt += 4;
    1b87:	48 83 45 f0 04       	add    QWORD PTR [rbp-0x10],0x4
								mem += 4;
    1b8c:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1b90:	48 83 c0 04          	add    rax,0x4
    1b94:	48 89 45 88          	mov    QWORD PTR [rbp-0x78],rax
								bitc -= 32;
    1b98:	83 6d fc 20          	sub    DWORD PTR [rbp-0x4],0x20
						if (bitc >= 16) {
    1b9c:	83 7d fc 0f          	cmp    DWORD PTR [rbp-0x4],0xf
    1ba0:	7e 23                	jle    1bc5 <render_text_scanline_8btpp+0x3ae>
								*(uint16_t*)mem = *(uint16_t*)pt;
    1ba2:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1ba6:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1baa:	0f b7 12             	movzx  edx,WORD PTR [rdx]
    1bad:	66 89 10             	mov    WORD PTR [rax],dx
								pt += 2;
    1bb0:	48 83 45 f0 02       	add    QWORD PTR [rbp-0x10],0x2
								mem += 2;
    1bb5:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1bb9:	48 83 c0 02          	add    rax,0x2
    1bbd:	48 89 45 88          	mov    QWORD PTR [rbp-0x78],rax
								bitc -= 16;
    1bc1:	83 6d fc 10          	sub    DWORD PTR [rbp-0x4],0x10
						if (bitc >= 8) {
    1bc5:	83 7d fc 07          	cmp    DWORD PTR [rbp-0x4],0x7
    1bc9:	7e 24                	jle    1bef <render_text_scanline_8btpp+0x3d8>
								*(uint8_t*)mem = *(uint8_t*)pt;
    1bcb:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1bcf:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1bd3:	0f b6 12             	movzx  edx,BYTE PTR [rdx]
    1bd6:	88 10                	mov    BYTE PTR [rax],dl
								pt += 1;
    1bd8:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
								mem += 1;
    1bdd:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1be1:	48 83 c0 01          	add    rax,0x1
    1be5:	48 89 45 88          	mov    QWORD PTR [rbp-0x78],rax
								bitc -= 8;
    1be9:	83 6d fc 08          	sub    DWORD PTR [rbp-0x4],0x8
						break;
    1bed:	eb 54                	jmp    1c43 <render_text_scanline_8btpp+0x42c>
						} else if (bitc) {
    1bef:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
    1bf3:	74 4e                	je     1c43 <render_text_scanline_8btpp+0x42c>
								die("cant happen with byte sized pixels!\n");
    1bf5:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1bfc:	bf 0c 00 00 00       	mov    edi,0xc
    1c01:	b8 00 00 00 00       	mov    eax,0x0
    1c06:	e8 00 00 00 00       	call   1c0b <render_text_scanline_8btpp+0x3f4>
    1c0b:	b8 00 00 00 00       	mov    eax,0x0
    1c10:	e8 00 00 00 00       	call   1c15 <render_text_scanline_8btpp+0x3fe>
    1c15:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1c1c:	e8 00 00 00 00       	call   1c21 <render_text_scanline_8btpp+0x40a>
    1c21:	fa                   	cli
    1c22:	f4                   	hlt
    1c23:	eb fd                	jmp    1c22 <render_text_scanline_8btpp+0x40b>
						px_x -= cc;
    1c25:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    1c28:	29 45 84             	sub    DWORD PTR [rbp-0x7c],eax
						p0_x += cc; /* unneccessary as r does not change anymore */
    1c2b:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    1c2e:	01 85 7c ff ff ff    	add    DWORD PTR [rbp-0x84],eax
		while (px_x) {
    1c34:	83 7d 84 00          	cmp    DWORD PTR [rbp-0x7c],0x0
    1c38:	0f 85 b7 fd ff ff    	jne    19f5 <render_text_scanline_8btpp+0x1de>
				} else
						break;
		}
}
    1c3e:	eb 04                	jmp    1c44 <render_text_scanline_8btpp+0x42d>
						break;
    1c40:	90                   	nop
    1c41:	eb 01                	jmp    1c44 <render_text_scanline_8btpp+0x42d>
						break;
    1c43:	90                   	nop
}
    1c44:	90                   	nop
    1c45:	c9                   	leave
    1c46:	c3                   	ret

0000000000001c47 <render_text>:
/* this function uses pixel addressing for width and height
 * making it possible to render half/overlapping characters.
 */
void render_text(const char* font, char* str, void* mem, size_t text_stride, size_t mem_stride,
		size_t btpp, ssize_t px_x, ssize_t px_y, int starts_half, int cur_x, int cur_y, ssize_t p0_x, ssize_t p0_y)
{
    1c47:	55                   	push   rbp
    1c48:	48 89 e5             	mov    rbp,rsp
    1c4b:	48 83 ec 40          	sub    rsp,0x40
    1c4f:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    1c53:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
    1c57:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
    1c5b:	48 89 4d d0          	mov    QWORD PTR [rbp-0x30],rcx
    1c5f:	4c 89 45 c8          	mov    QWORD PTR [rbp-0x38],r8
    1c63:	4c 89 4d c0          	mov    QWORD PTR [rbp-0x40],r9
		(void)starts_half;
//		char is_half = 0, ends_half = 0;
		/* pixel offset is handled before calling the function */
//		is_half = starts_half;
//		ends_half = (px_x % 2) ? (!starts_half) : (starts_half);
		for (ssize_t ln = p0_y; ln < px_y + p0_y; ln++) {
    1c67:	8b 45 40             	mov    eax,DWORD PTR [rbp+0x40]
    1c6a:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
    1c6d:	e9 fb 01 00 00       	jmp    1e6d <render_text+0x226>
				ssize_t l = ln % 16; ssize_t cur_xv;
    1c72:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    1c75:	89 d0                	mov    eax,edx
    1c77:	c1 f8 1f             	sar    eax,0x1f
    1c7a:	c1 e8 1c             	shr    eax,0x1c
    1c7d:	01 c2                	add    edx,eax
    1c7f:	83 e2 0f             	and    edx,0xf
    1c82:	29 c2                	sub    edx,eax
    1c84:	89 55 f4             	mov    DWORD PTR [rbp-0xc],edx

				/* check cursor */
				if (ln / 16 == cur_y)
    1c87:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1c8a:	8d 50 0f             	lea    edx,[rax+0xf]
    1c8d:	85 c0                	test   eax,eax
    1c8f:	0f 48 c2             	cmovs  eax,edx
    1c92:	c1 f8 04             	sar    eax,0x4
    1c95:	39 45 30             	cmp    DWORD PTR [rbp+0x30],eax
    1c98:	75 08                	jne    1ca2 <render_text+0x5b>
						cur_xv = cur_x;
    1c9a:	8b 45 28             	mov    eax,DWORD PTR [rbp+0x28]
    1c9d:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
    1ca0:	eb 07                	jmp    1ca9 <render_text+0x62>
				else
						cur_xv = -1;
    1ca2:	c7 45 f8 ff ff ff ff 	mov    DWORD PTR [rbp-0x8],0xffffffff

				/* invoke the scanline drawing routines */
				switch (btpp) {
    1ca9:	48 83 7d c0 20       	cmp    QWORD PTR [rbp-0x40],0x20
    1cae:	74 4e                	je     1cfe <render_text+0xb7>
    1cb0:	48 83 7d c0 20       	cmp    QWORD PTR [rbp-0x40],0x20
    1cb5:	0f 87 67 01 00 00    	ja     1e22 <render_text+0x1db>
    1cbb:	48 83 7d c0 18       	cmp    QWORD PTR [rbp-0x40],0x18
    1cc0:	0f 84 ac 00 00 00    	je     1d72 <render_text+0x12b>
    1cc6:	48 83 7d c0 18       	cmp    QWORD PTR [rbp-0x40],0x18
    1ccb:	0f 87 51 01 00 00    	ja     1e22 <render_text+0x1db>
    1cd1:	48 83 7d c0 08       	cmp    QWORD PTR [rbp-0x40],0x8
    1cd6:	0f 84 16 01 00 00    	je     1df2 <render_text+0x1ab>
    1cdc:	48 83 7d c0 08       	cmp    QWORD PTR [rbp-0x40],0x8
    1ce1:	0f 82 3b 01 00 00    	jb     1e22 <render_text+0x1db>
    1ce7:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1ceb:	48 83 e8 0f          	sub    rax,0xf
    1cef:	48 83 f8 01          	cmp    rax,0x1
    1cf3:	0f 87 29 01 00 00    	ja     1e22 <render_text+0x1db>
    1cf9:	e9 b9 00 00 00       	jmp    1db7 <render_text+0x170>
						case 32:
								if (cpu.has_sse)
    1cfe:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 1d05 <render_text+0xbe>
    1d05:	83 e0 02             	and    eax,0x2
    1d08:	84 c0                	test   al,al
    1d0a:	74 33                	je     1d3f <render_text+0xf8>
										render_text_scanline_32btpp_sse(font + l, str,
    1d0c:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1d0f:	48 63 d0             	movsxd rdx,eax
    1d12:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1d16:	48 8d 3c 02          	lea    rdi,[rdx+rax*1]
    1d1a:	44 8b 45 38          	mov    r8d,DWORD PTR [rbp+0x38]
    1d1e:	8b 75 f8             	mov    esi,DWORD PTR [rbp-0x8]
    1d21:	8b 4d 10             	mov    ecx,DWORD PTR [rbp+0x10]
    1d24:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    1d28:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1d2c:	45 89 c1             	mov    r9d,r8d
    1d2f:	41 89 f0             	mov    r8d,esi
    1d32:	48 89 c6             	mov    rsi,rax
    1d35:	e8 00 00 00 00       	call   1d3a <render_text+0xf3>
												mem, px_x, cur_xv, p0_x);
								else
										render_text_scanline_32btpp(font + l, str,
												mem, px_x, cur_xv, p0_x);
								break;
    1d3a:	e9 14 01 00 00       	jmp    1e53 <render_text+0x20c>
										render_text_scanline_32btpp(font + l, str,
    1d3f:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1d42:	48 63 d0             	movsxd rdx,eax
    1d45:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1d49:	48 8d 3c 02          	lea    rdi,[rdx+rax*1]
    1d4d:	44 8b 45 38          	mov    r8d,DWORD PTR [rbp+0x38]
    1d51:	8b 75 f8             	mov    esi,DWORD PTR [rbp-0x8]
    1d54:	8b 4d 10             	mov    ecx,DWORD PTR [rbp+0x10]
    1d57:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    1d5b:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1d5f:	45 89 c1             	mov    r9d,r8d
    1d62:	41 89 f0             	mov    r8d,esi
    1d65:	48 89 c6             	mov    rsi,rax
    1d68:	e8 00 00 00 00       	call   1d6d <render_text+0x126>
								break;
    1d6d:	e9 e1 00 00 00       	jmp    1e53 <render_text+0x20c>
						case 24: /* 16 bytes /w sse really needed */
								if (cpu.has_sse)
    1d72:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 1d79 <render_text+0x132>
    1d79:	83 e0 02             	and    eax,0x2
    1d7c:	84 c0                	test   al,al
    1d7e:	0f 84 ce 00 00 00    	je     1e52 <render_text+0x20b>
										render_text_scanline_24btpp_sse(font + l, str,
    1d84:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1d87:	48 63 d0             	movsxd rdx,eax
    1d8a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1d8e:	48 8d 3c 02          	lea    rdi,[rdx+rax*1]
    1d92:	44 8b 45 38          	mov    r8d,DWORD PTR [rbp+0x38]
    1d96:	8b 75 f8             	mov    esi,DWORD PTR [rbp-0x8]
    1d99:	8b 4d 10             	mov    ecx,DWORD PTR [rbp+0x10]
    1d9c:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    1da0:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1da4:	45 89 c1             	mov    r9d,r8d
    1da7:	41 89 f0             	mov    r8d,esi
    1daa:	48 89 c6             	mov    rsi,rax
    1dad:	e8 00 00 00 00       	call   1db2 <render_text+0x16b>
												mem, px_x, cur_xv, p0_x);
								//else
								//		render_text_scanline_24btpp(font + l, str,
								//				mem, px_x, cur_xv, p0_x);
								break;
    1db2:	e9 9b 00 00 00       	jmp    1e52 <render_text+0x20b>
						case 15:
						case 16:
								render_text_scanline_16btpp(font + l, str,
    1db7:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1dba:	48 63 d0             	movsxd rdx,eax
    1dbd:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1dc1:	48 8d 3c 02          	lea    rdi,[rdx+rax*1]
    1dc5:	44 8b 45 38          	mov    r8d,DWORD PTR [rbp+0x38]
    1dc9:	8b 75 f8             	mov    esi,DWORD PTR [rbp-0x8]
    1dcc:	8b 4d 10             	mov    ecx,DWORD PTR [rbp+0x10]
    1dcf:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    1dd3:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1dd7:	48 83 ec 08          	sub    rsp,0x8
    1ddb:	ff 75 c0             	push   QWORD PTR [rbp-0x40]
    1dde:	45 89 c1             	mov    r9d,r8d
    1de1:	41 89 f0             	mov    r8d,esi
    1de4:	48 89 c6             	mov    rsi,rax
    1de7:	e8 00 00 00 00       	call   1dec <render_text+0x1a5>
    1dec:	48 83 c4 10          	add    rsp,0x10
												mem, px_x, cur_xv, p0_x, btpp);
								break;
    1df0:	eb 61                	jmp    1e53 <render_text+0x20c>
						case 8:
								render_text_scanline_8btpp(font + l, str,
    1df2:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1df5:	48 63 d0             	movsxd rdx,eax
    1df8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1dfc:	48 8d 3c 02          	lea    rdi,[rdx+rax*1]
    1e00:	44 8b 45 38          	mov    r8d,DWORD PTR [rbp+0x38]
    1e04:	8b 75 f8             	mov    esi,DWORD PTR [rbp-0x8]
    1e07:	8b 4d 10             	mov    ecx,DWORD PTR [rbp+0x10]
    1e0a:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    1e0e:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1e12:	45 89 c1             	mov    r9d,r8d
    1e15:	41 89 f0             	mov    r8d,esi
    1e18:	48 89 c6             	mov    rsi,rax
    1e1b:	e8 00 00 00 00       	call   1e20 <render_text+0x1d9>
												mem, px_x, cur_xv, p0_x);
								break;
    1e20:	eb 31                	jmp    1e53 <render_text+0x20c>
						default:
/*								render_text_scanline_xbtpp(font + l, str, btpp,
												mem, px_x, cur_xv, p0_x);*/
								die("not impl\n");
    1e22:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1e29:	bf 0c 00 00 00       	mov    edi,0xc
    1e2e:	b8 00 00 00 00       	mov    eax,0x0
    1e33:	e8 00 00 00 00       	call   1e38 <render_text+0x1f1>
    1e38:	b8 00 00 00 00       	mov    eax,0x0
    1e3d:	e8 00 00 00 00       	call   1e42 <render_text+0x1fb>
    1e42:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1e49:	e8 00 00 00 00       	call   1e4e <render_text+0x207>
    1e4e:	fa                   	cli
    1e4f:	f4                   	hlt
    1e50:	eb fd                	jmp    1e4f <render_text+0x208>
								break;
    1e52:	90                   	nop
								break;
				}

				/* advance */
				if (l == 15) {
    1e53:	83 7d f4 0f          	cmp    DWORD PTR [rbp-0xc],0xf
    1e57:	75 08                	jne    1e61 <render_text+0x21a>
						str += text_stride;
    1e59:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1e5d:	48 01 45 e0          	add    QWORD PTR [rbp-0x20],rax
				}
				mem += mem_stride;
    1e61:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1e65:	48 01 45 d8          	add    QWORD PTR [rbp-0x28],rax
		for (ssize_t ln = p0_y; ln < px_y + p0_y; ln++) {
    1e69:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
    1e6d:	8b 55 18             	mov    edx,DWORD PTR [rbp+0x18]
    1e70:	8b 45 40             	mov    eax,DWORD PTR [rbp+0x40]
    1e73:	01 d0                	add    eax,edx
    1e75:	39 45 fc             	cmp    DWORD PTR [rbp-0x4],eax
    1e78:	0f 8c f4 fd ff ff    	jl     1c72 <render_text+0x2b>
		}
}
    1e7e:	90                   	nop
    1e7f:	90                   	nop
    1e80:	c9                   	leave
    1e81:	c3                   	ret

0000000000001e82 <add_stride>:
		ssize_t x1, x2;
};

/* adds stride and returns 1 if new element was needed */
int add_stride(struct stride* sb, size_t num, struct stride* s)
{
    1e82:	55                   	push   rbp
    1e83:	48 89 e5             	mov    rbp,rsp
    1e86:	48 83 ec 30          	sub    rsp,0x30
    1e8a:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    1e8e:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
    1e92:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
		/* assume sortedness (our insertions are sorted) */
		for (size_t i = 0; i < num; i++) {
    1e96:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
    1e9e:	e9 91 00 00 00       	jmp    1f34 <add_stride+0xb2>
				if (sb[i].x1 == s->x2) { /* extend below */
    1ea3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1ea7:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
    1eaf:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1eb3:	48 01 d0             	add    rax,rdx
    1eb6:	8b 10                	mov    edx,DWORD PTR [rax]
    1eb8:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1ebc:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1ebf:	39 c2                	cmp    edx,eax
    1ec1:	75 25                	jne    1ee8 <add_stride+0x66>
						sb[i].x1 = s->x1;
    1ec3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1ec7:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
    1ecf:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1ed3:	48 01 c2             	add    rdx,rax
    1ed6:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1eda:	8b 00                	mov    eax,DWORD PTR [rax]
    1edc:	89 02                	mov    DWORD PTR [rdx],eax
						return 0;
    1ede:	b8 00 00 00 00       	mov    eax,0x0
    1ee3:	e9 25 01 00 00       	jmp    200d <add_stride+0x18b>
				} else if (sb[i].x2 == s->x1) { /* extend above */
    1ee8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1eec:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
    1ef4:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1ef8:	48 01 d0             	add    rax,rdx
    1efb:	8b 50 04             	mov    edx,DWORD PTR [rax+0x4]
    1efe:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1f02:	8b 00                	mov    eax,DWORD PTR [rax]
    1f04:	39 c2                	cmp    edx,eax
    1f06:	75 27                	jne    1f2f <add_stride+0xad>
						sb[i].x2 = s->x2;
    1f08:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1f0c:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
    1f14:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1f18:	48 01 c2             	add    rdx,rax
    1f1b:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1f1f:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1f22:	89 42 04             	mov    DWORD PTR [rdx+0x4],eax
						return 0;
    1f25:	b8 00 00 00 00       	mov    eax,0x0
    1f2a:	e9 de 00 00 00       	jmp    200d <add_stride+0x18b>
		for (size_t i = 0; i < num; i++) {
    1f2f:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
    1f34:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1f38:	48 3b 45 e0          	cmp    rax,QWORD PTR [rbp-0x20]
    1f3c:	0f 82 61 ff ff ff    	jb     1ea3 <add_stride+0x21>
				}
		}
		/* insert sorted */
		for (size_t i = 0; i < num; i++)
    1f42:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
    1f4a:	e9 8e 00 00 00       	jmp    1fdd <add_stride+0x15b>
				if (sb[i].x1 < s->x2) {
    1f4f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1f53:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
    1f5b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1f5f:	48 01 d0             	add    rax,rdx
    1f62:	8b 10                	mov    edx,DWORD PTR [rax]
    1f64:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1f68:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1f6b:	39 c2                	cmp    edx,eax
    1f6d:	7d 69                	jge    1fd8 <add_stride+0x156>
						memmove(sb + i + 1, sb + i, (num - i) * sizeof(*s));
    1f6f:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1f73:	48 2b 45 f0          	sub    rax,QWORD PTR [rbp-0x10]
    1f77:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
    1f7f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1f83:	48 8d 0c c5 00 00 00 00 	lea    rcx,[rax*8+0x0]
    1f8b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1f8f:	48 01 c1             	add    rcx,rax
    1f92:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1f96:	48 83 c0 01          	add    rax,0x1
    1f9a:	48 8d 34 c5 00 00 00 00 	lea    rsi,[rax*8+0x0]
    1fa2:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1fa6:	48 01 f0             	add    rax,rsi
    1fa9:	48 89 ce             	mov    rsi,rcx
    1fac:	48 89 c7             	mov    rdi,rax
    1faf:	e8 00 00 00 00       	call   1fb4 <add_stride+0x132>
						sb[i] = *s;
    1fb4:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1fb8:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
    1fc0:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1fc4:	48 01 c2             	add    rdx,rax
    1fc7:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1fcb:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1fce:	48 89 02             	mov    QWORD PTR [rdx],rax
						return 1;
    1fd1:	b8 01 00 00 00       	mov    eax,0x1
    1fd6:	eb 35                	jmp    200d <add_stride+0x18b>
		for (size_t i = 0; i < num; i++)
    1fd8:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
    1fdd:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1fe1:	48 3b 45 e0          	cmp    rax,QWORD PTR [rbp-0x20]
    1fe5:	0f 82 64 ff ff ff    	jb     1f4f <add_stride+0xcd>
				}
		/* element is last */
		sb[num] = *s;
    1feb:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1fef:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
    1ff7:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1ffb:	48 01 c2             	add    rdx,rax
    1ffe:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2002:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2005:	48 89 02             	mov    QWORD PTR [rdx],rax
		return 1;
    2008:	b8 01 00 00 00       	mov    eax,0x1
}
    200d:	c9                   	leave
    200e:	c3                   	ret

000000000000200f <framebuffer_redraw>:

uint64_t fb_rdt = 0;
/* redraws the complete screen */
void framebuffer_redraw_region(struct framebuffer* fb, struct kio_region* r);
void framebuffer_redraw(struct framebuffer* fb)
{
    200f:	55                   	push   rbp
    2010:	48 89 e5             	mov    rbp,rsp
    2013:	48 83 ec 30          	sub    rsp,0x30
    2017:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		struct kio_region r = {0}; /* sse alignment */
    201b:	66 0f ef c0          	pxor   xmm0,xmm0
    201f:	0f 29 45 e0          	movaps XMMWORD PTR [rbp-0x20],xmm0
    2023:	66 0f 7e 45 f0       	movd   DWORD PTR [rbp-0x10],xmm0
		r.lx = fb->chw_x; r.ly = fb->chw_y;
    2028:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    202c:	8b 40 34             	mov    eax,DWORD PTR [rax+0x34]
    202f:	66 89 45 e4          	mov    WORD PTR [rbp-0x1c],ax
    2033:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2037:	8b 40 38             	mov    eax,DWORD PTR [rax+0x38]
    203a:	66 89 45 e6          	mov    WORD PTR [rbp-0x1a],ax
		r.x = fb->cho_x; r.y = fb->cho_y;
    203e:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2042:	8b 40 2c             	mov    eax,DWORD PTR [rax+0x2c]
    2045:	66 89 45 e0          	mov    WORD PTR [rbp-0x20],ax
    2049:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    204d:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
    2050:	66 89 45 e2          	mov    WORD PTR [rbp-0x1e],ax
		framebuffer_redraw_region(fb, &r);
    2054:	48 8d 55 e0          	lea    rdx,[rbp-0x20]
    2058:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    205c:	48 89 d6             	mov    rsi,rdx
    205f:	48 89 c7             	mov    rdi,rax
    2062:	e8 00 00 00 00       	call   2067 <framebuffer_redraw+0x58>
}
    2067:	90                   	nop
    2068:	c9                   	leave
    2069:	c3                   	ret

000000000000206a <framebuffer_redraw_region>:

/* redraws a defined region (screen relative, not buffer, internal) */
void framebuffer_redraw_region(struct framebuffer* fb, struct kio_region* r)
{
    206a:	55                   	push   rbp
    206b:	48 89 e5             	mov    rbp,rsp
    206e:	53                   	push   rbx
    206f:	48 81 ec c8 01 00 00 	sub    rsp,0x1c8
    2076:	48 89 bd 38 fe ff ff 	mov    QWORD PTR [rbp-0x1c8],rdi
    207d:	48 89 b5 30 fe ff ff 	mov    QWORD PTR [rbp-0x1d0],rsi
		if (vga_mem_ptr == fb->text_mem)
    2084:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    208b:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    208e:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2095 <framebuffer_redraw_region+0x2b>
    2095:	48 39 c2             	cmp    rdx,rax
    2098:	0f 84 fd 0e 00 00    	je     2f9b <framebuffer_redraw_region+0xf31>
				return; /* don't do anything if we're directly on video memory */
		else if (video_mode.is_textmode) {
    209e:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 20a5 <framebuffer_redraw_region+0x3b>
    20a5:	84 c0                	test   al,al
    20a7:	0f 84 b1 04 00 00    	je     255e <framebuffer_redraw_region+0x4f4>
				if (video_mode.width == fb->width && fb->chw_x == fb->width
    20ad:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 20b3 <framebuffer_redraw_region+0x49>
    20b3:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    20ba:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    20bd:	39 c2                	cmp    edx,eax
    20bf:	0f 85 e5 01 00 00    	jne    22aa <framebuffer_redraw_region+0x240>
    20c5:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    20cc:	8b 50 34             	mov    edx,DWORD PTR [rax+0x34]
    20cf:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    20d6:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    20d9:	39 c2                	cmp    edx,eax
    20db:	0f 85 c9 01 00 00    	jne    22aa <framebuffer_redraw_region+0x240>
							   && r->lx == fb->width && !fb->pix_x) {
    20e1:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    20e8:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
    20ec:	0f bf d0             	movsx  edx,ax
    20ef:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    20f6:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    20f9:	39 c2                	cmp    edx,eax
    20fb:	0f 85 a9 01 00 00    	jne    22aa <framebuffer_redraw_region+0x240>
    2101:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2108:	8b 40 24             	mov    eax,DWORD PTR [rax+0x24]
    210b:	85 c0                	test   eax,eax
    210d:	0f 85 97 01 00 00    	jne    22aa <framebuffer_redraw_region+0x240>
						ssize_t nl;
						/* super easy memory transfer */
						fb->cho_x = 0;
    2113:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    211a:	c7 40 2c 00 00 00 00 	mov    DWORD PTR [rax+0x2c],0x0
						nl = min(min(video_mode.height - fb->pix_y, fb->chw_y),
    2121:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    2128:	0f b7 40 06          	movzx  eax,WORD PTR [rax+0x6]
    212c:	0f bf d0             	movsx  edx,ax
    212f:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2136:	8b 70 0c             	mov    esi,DWORD PTR [rax+0xc]
    2139:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2140:	8b 48 30             	mov    ecx,DWORD PTR [rax+0x30]
    2143:	89 f0                	mov    eax,esi
    2145:	29 c8                	sub    eax,ecx
    2147:	39 c2                	cmp    edx,eax
    2149:	0f 4f d0             	cmovg  edx,eax
    214c:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2153:	8b 48 38             	mov    ecx,DWORD PTR [rax+0x38]
    2156:	8b 3d 00 00 00 00    	mov    edi,DWORD PTR [rip+0x0]        # 215c <framebuffer_redraw_region+0xf2>
    215c:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2163:	8b 70 28             	mov    esi,DWORD PTR [rax+0x28]
    2166:	89 f8                	mov    eax,edi
    2168:	29 f0                	sub    eax,esi
    216a:	39 c1                	cmp    ecx,eax
    216c:	0f 4e c1             	cmovle eax,ecx
    216f:	39 c2                	cmp    edx,eax
    2171:	0f 4e c2             	cmovle eax,edx
    2174:	89 85 64 ff ff ff    	mov    DWORD PTR [rbp-0x9c],eax
										min(fb->height - fb->cho_y, r->ly));
						memcpy(vga_mem_ptr + (fb->pix_y + r->y) * 2 * video_mode.width,
										fb->text_mem + (fb->cho_y + r->y) * 2
										* fb->width, nl * 2 * fb->width);
    217a:	8b 85 64 ff ff ff    	mov    eax,DWORD PTR [rbp-0x9c]
    2180:	8d 14 00             	lea    edx,[rax+rax*1]
    2183:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    218a:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    218d:	0f af c2             	imul   eax,edx
						memcpy(vga_mem_ptr + (fb->pix_y + r->y) * 2 * video_mode.width,
    2190:	48 98                	cdqe
										fb->text_mem + (fb->cho_y + r->y) * 2
    2192:	48 8b 95 38 fe ff ff 	mov    rdx,QWORD PTR [rbp-0x1c8]
    2199:	48 8b 0a             	mov    rcx,QWORD PTR [rdx]
    219c:	48 8b 95 38 fe ff ff 	mov    rdx,QWORD PTR [rbp-0x1c8]
    21a3:	8b 72 30             	mov    esi,DWORD PTR [rdx+0x30]
    21a6:	48 8b 95 30 fe ff ff 	mov    rdx,QWORD PTR [rbp-0x1d0]
    21ad:	0f b7 52 02          	movzx  edx,WORD PTR [rdx+0x2]
    21b1:	0f bf d2             	movsx  edx,dx
    21b4:	01 f2                	add    edx,esi
    21b6:	8d 34 12             	lea    esi,[rdx+rdx*1]
										* fb->width, nl * 2 * fb->width);
    21b9:	48 8b 95 38 fe ff ff 	mov    rdx,QWORD PTR [rbp-0x1c8]
    21c0:	8b 52 08             	mov    edx,DWORD PTR [rdx+0x8]
    21c3:	0f af d6             	imul   edx,esi
    21c6:	48 63 d2             	movsxd rdx,edx
										fb->text_mem + (fb->cho_y + r->y) * 2
    21c9:	48 8d 34 11          	lea    rsi,[rcx+rdx*1]
						memcpy(vga_mem_ptr + (fb->pix_y + r->y) * 2 * video_mode.width,
    21cd:	48 8b 0d 00 00 00 00 	mov    rcx,QWORD PTR [rip+0x0]        # 21d4 <framebuffer_redraw_region+0x16a>
    21d4:	48 8b 95 38 fe ff ff 	mov    rdx,QWORD PTR [rbp-0x1c8]
    21db:	8b 7a 28             	mov    edi,DWORD PTR [rdx+0x28]
    21de:	48 8b 95 30 fe ff ff 	mov    rdx,QWORD PTR [rbp-0x1d0]
    21e5:	0f b7 52 02          	movzx  edx,WORD PTR [rdx+0x2]
    21e9:	0f bf d2             	movsx  edx,dx
    21ec:	01 fa                	add    edx,edi
    21ee:	8d 3c 12             	lea    edi,[rdx+rdx*1]
    21f1:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 21f7 <framebuffer_redraw_region+0x18d>
    21f7:	0f af d7             	imul   edx,edi
    21fa:	48 63 d2             	movsxd rdx,edx
    21fd:	48 01 d1             	add    rcx,rdx
    2200:	48 89 c2             	mov    rdx,rax
    2203:	48 89 cf             	mov    rdi,rcx
    2206:	e8 f5 dd ff ff       	call   0 <memcpy>
						/* show we're outside of buffer (for large cho_y) */
						if (nl < fb->chw_y)
    220b:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2212:	8b 40 38             	mov    eax,DWORD PTR [rax+0x38]
    2215:	39 85 64 ff ff ff    	cmp    DWORD PTR [rbp-0x9c],eax
    221b:	0f 8d 37 03 00 00    	jge    2558 <framebuffer_redraw_region+0x4ee>
								bzero(vga_mem_ptr + (fb->pix_y + r->y + nl) * 2 * fb->width,
										(min(fb->chw_y, video_mode.height - fb->pix_y)
    2221:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 2227 <framebuffer_redraw_region+0x1bd>
    2227:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    222e:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    2231:	29 c2                	sub    edx,eax
    2233:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    223a:	8b 40 38             	mov    eax,DWORD PTR [rax+0x38]
    223d:	39 c2                	cmp    edx,eax
    223f:	0f 4e c2             	cmovle eax,edx
										 - nl) * fb->width * 2);
    2242:	2b 85 64 ff ff ff    	sub    eax,DWORD PTR [rbp-0x9c]
    2248:	89 c2                	mov    edx,eax
    224a:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2251:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    2254:	0f af c2             	imul   eax,edx
    2257:	01 c0                	add    eax,eax
								bzero(vga_mem_ptr + (fb->pix_y + r->y + nl) * 2 * fb->width,
    2259:	48 98                	cdqe
    225b:	48 8b 0d 00 00 00 00 	mov    rcx,QWORD PTR [rip+0x0]        # 2262 <framebuffer_redraw_region+0x1f8>
    2262:	48 8b 95 38 fe ff ff 	mov    rdx,QWORD PTR [rbp-0x1c8]
    2269:	8b 72 28             	mov    esi,DWORD PTR [rdx+0x28]
    226c:	48 8b 95 30 fe ff ff 	mov    rdx,QWORD PTR [rbp-0x1d0]
    2273:	0f b7 52 02          	movzx  edx,WORD PTR [rdx+0x2]
    2277:	0f bf d2             	movsx  edx,dx
    227a:	01 d6                	add    esi,edx
    227c:	8b 95 64 ff ff ff    	mov    edx,DWORD PTR [rbp-0x9c]
    2282:	01 f2                	add    edx,esi
    2284:	8d 34 12             	lea    esi,[rdx+rdx*1]
    2287:	48 8b 95 38 fe ff ff 	mov    rdx,QWORD PTR [rbp-0x1c8]
    228e:	8b 52 08             	mov    edx,DWORD PTR [rdx+0x8]
    2291:	0f af d6             	imul   edx,esi
    2294:	48 63 d2             	movsxd rdx,edx
    2297:	48 01 ca             	add    rdx,rcx
    229a:	48 89 c6             	mov    rsi,rax
    229d:	48 89 d7             	mov    rdi,rdx
    22a0:	e8 00 00 00 00       	call   22a5 <framebuffer_redraw_region+0x23b>
							   && r->lx == fb->width && !fb->pix_x) {
    22a5:	e9 ae 02 00 00       	jmp    2558 <framebuffer_redraw_region+0x4ee>
				} else {
						ssize_t nl, nc; void *src, *dst;
						/* copy linewise */
						nl = min(min(video_mode.height - fb->pix_y, fb->chw_y),
    22aa:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    22b1:	0f b7 40 06          	movzx  eax,WORD PTR [rax+0x6]
    22b5:	0f bf d0             	movsx  edx,ax
    22b8:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    22bf:	8b 70 0c             	mov    esi,DWORD PTR [rax+0xc]
    22c2:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    22c9:	8b 48 30             	mov    ecx,DWORD PTR [rax+0x30]
    22cc:	89 f0                	mov    eax,esi
    22ce:	29 c8                	sub    eax,ecx
    22d0:	39 c2                	cmp    edx,eax
    22d2:	0f 4f d0             	cmovg  edx,eax
    22d5:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    22dc:	8b 48 38             	mov    ecx,DWORD PTR [rax+0x38]
    22df:	8b 3d 00 00 00 00    	mov    edi,DWORD PTR [rip+0x0]        # 22e5 <framebuffer_redraw_region+0x27b>
    22e5:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    22ec:	8b 70 28             	mov    esi,DWORD PTR [rax+0x28]
    22ef:	89 f8                	mov    eax,edi
    22f1:	29 f0                	sub    eax,esi
    22f3:	39 c1                	cmp    ecx,eax
    22f5:	0f 4e c1             	cmovle eax,ecx
    22f8:	39 c2                	cmp    edx,eax
    22fa:	0f 4e c2             	cmovle eax,edx
    22fd:	89 85 60 ff ff ff    	mov    DWORD PTR [rbp-0xa0],eax
									   	min(fb->height - fb->cho_y, r->ly));
						nc = min(min(video_mode.width - fb->pix_x, fb->chw_x),
    2303:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    230a:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
    230e:	0f bf d0             	movsx  edx,ax
    2311:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2318:	8b 70 08             	mov    esi,DWORD PTR [rax+0x8]
    231b:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2322:	8b 48 2c             	mov    ecx,DWORD PTR [rax+0x2c]
    2325:	89 f0                	mov    eax,esi
    2327:	29 c8                	sub    eax,ecx
    2329:	39 c2                	cmp    edx,eax
    232b:	0f 4f d0             	cmovg  edx,eax
    232e:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2335:	8b 48 34             	mov    ecx,DWORD PTR [rax+0x34]
    2338:	8b 3d 00 00 00 00    	mov    edi,DWORD PTR [rip+0x0]        # 233e <framebuffer_redraw_region+0x2d4>
    233e:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2345:	8b 70 24             	mov    esi,DWORD PTR [rax+0x24]
    2348:	89 f8                	mov    eax,edi
    234a:	29 f0                	sub    eax,esi
    234c:	39 c1                	cmp    ecx,eax
    234e:	0f 4e c1             	cmovle eax,ecx
    2351:	39 c2                	cmp    edx,eax
    2353:	0f 4e c2             	cmovle eax,edx
    2356:	89 85 5c ff ff ff    	mov    DWORD PTR [rbp-0xa4],eax
										min(fb->width - fb->cho_x, r->lx));
						src = fb->text_mem + (fb->cho_y + r->y) * 2 * fb->width + 2 * (fb->cho_x + r->y);
    235c:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2363:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    2366:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    236d:	8b 48 30             	mov    ecx,DWORD PTR [rax+0x30]
    2370:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    2377:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    237b:	98                   	cwde
    237c:	01 c8                	add    eax,ecx
    237e:	8d 0c 00             	lea    ecx,[rax+rax*1]
    2381:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2388:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    238b:	0f af c1             	imul   eax,ecx
    238e:	48 63 c8             	movsxd rcx,eax
    2391:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2398:	8b 70 2c             	mov    esi,DWORD PTR [rax+0x2c]
    239b:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    23a2:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    23a6:	98                   	cwde
    23a7:	01 f0                	add    eax,esi
    23a9:	01 c0                	add    eax,eax
    23ab:	48 98                	cdqe
    23ad:	48 01 c8             	add    rax,rcx
    23b0:	48 01 d0             	add    rax,rdx
    23b3:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
						dst = vga_mem_ptr + (fb->pix_y + r->y) * 2 * video_mode.width + 2 * (fb->pix_x + r->y);
    23b7:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 23be <framebuffer_redraw_region+0x354>
    23be:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    23c5:	8b 48 28             	mov    ecx,DWORD PTR [rax+0x28]
    23c8:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    23cf:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    23d3:	98                   	cwde
    23d4:	01 c8                	add    eax,ecx
    23d6:	8d 0c 00             	lea    ecx,[rax+rax*1]
    23d9:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 23df <framebuffer_redraw_region+0x375>
    23df:	0f af c1             	imul   eax,ecx
    23e2:	48 63 c8             	movsxd rcx,eax
    23e5:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    23ec:	8b 70 24             	mov    esi,DWORD PTR [rax+0x24]
    23ef:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    23f6:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    23fa:	98                   	cwde
    23fb:	01 f0                	add    eax,esi
    23fd:	01 c0                	add    eax,eax
    23ff:	48 98                	cdqe
    2401:	48 01 c8             	add    rax,rcx
    2404:	48 01 d0             	add    rax,rdx
    2407:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
						while (nl) {
    240b:	e9 a9 00 00 00       	jmp    24b9 <framebuffer_redraw_region+0x44f>
								memcpy(dst, src, 2 * nc);
    2410:	8b 85 5c ff ff ff    	mov    eax,DWORD PTR [rbp-0xa4]
    2416:	01 c0                	add    eax,eax
    2418:	48 63 d0             	movsxd rdx,eax
    241b:	48 8b 4d e8          	mov    rcx,QWORD PTR [rbp-0x18]
    241f:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    2423:	48 89 ce             	mov    rsi,rcx
    2426:	48 89 c7             	mov    rdi,rax
    2429:	e8 d2 db ff ff       	call   0 <memcpy>
								if (nc < min(fb->chw_x, r->lx))
    242e:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    2435:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
    2439:	0f bf d0             	movsx  edx,ax
    243c:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2443:	8b 40 34             	mov    eax,DWORD PTR [rax+0x34]
    2446:	39 c2                	cmp    edx,eax
    2448:	0f 4e c2             	cmovle eax,edx
    244b:	39 85 5c ff ff ff    	cmp    DWORD PTR [rbp-0xa4],eax
    2451:	7d 46                	jge    2499 <framebuffer_redraw_region+0x42f>
										bzero(dst + 2 * nc, min(fb->chw_x,
    2453:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 2459 <framebuffer_redraw_region+0x3ef>
    2459:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2460:	8b 40 24             	mov    eax,DWORD PTR [rax+0x24]
    2463:	29 c2                	sub    edx,eax
    2465:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    246c:	8b 40 34             	mov    eax,DWORD PTR [rax+0x34]
    246f:	39 c2                	cmp    edx,eax
    2471:	0f 4e c2             	cmovle eax,edx
											  video_mode.width - fb->pix_x) - nc);
    2474:	2b 85 5c ff ff ff    	sub    eax,DWORD PTR [rbp-0xa4]
										bzero(dst + 2 * nc, min(fb->chw_x,
    247a:	48 98                	cdqe
    247c:	8b 95 5c ff ff ff    	mov    edx,DWORD PTR [rbp-0xa4]
    2482:	01 d2                	add    edx,edx
    2484:	48 63 ca             	movsxd rcx,edx
    2487:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    248b:	48 01 ca             	add    rdx,rcx
    248e:	48 89 c6             	mov    rsi,rax
    2491:	48 89 d7             	mov    rdi,rdx
    2494:	e8 00 00 00 00       	call   2499 <framebuffer_redraw_region+0x42f>
								dst += video_mode.width * 2;
    2499:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 249f <framebuffer_redraw_region+0x435>
    249f:	01 c0                	add    eax,eax
    24a1:	48 98                	cdqe
    24a3:	48 01 45 e0          	add    QWORD PTR [rbp-0x20],rax
								src += fb->width * 2;
    24a7:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    24ae:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    24b1:	01 c0                	add    eax,eax
    24b3:	48 98                	cdqe
    24b5:	48 01 45 e8          	add    QWORD PTR [rbp-0x18],rax
						while (nl) {
    24b9:	83 bd 60 ff ff ff 00 	cmp    DWORD PTR [rbp-0xa0],0x0
    24c0:	0f 85 4a ff ff ff    	jne    2410 <framebuffer_redraw_region+0x3a6>
						}
						/* show we're outside (large cho_...) */
						nc = min(min(fb->chw_x, r->lx), video_mode.width - fb->pix_x);
    24c6:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 24cc <framebuffer_redraw_region+0x462>
    24cc:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    24d3:	8b 40 24             	mov    eax,DWORD PTR [rax+0x24]
    24d6:	89 d1                	mov    ecx,edx
    24d8:	29 c1                	sub    ecx,eax
    24da:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    24e1:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
    24e5:	0f bf d0             	movsx  edx,ax
    24e8:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    24ef:	8b 40 34             	mov    eax,DWORD PTR [rax+0x34]
    24f2:	39 c2                	cmp    edx,eax
    24f4:	0f 4e c2             	cmovle eax,edx
    24f7:	39 c1                	cmp    ecx,eax
    24f9:	0f 4e c1             	cmovle eax,ecx
    24fc:	89 85 5c ff ff ff    	mov    DWORD PTR [rbp-0xa4],eax
						if (nl < min(fb->chw_y, r->ly)) {
    2502:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    2509:	0f b7 40 06          	movzx  eax,WORD PTR [rax+0x6]
    250d:	0f bf d0             	movsx  edx,ax
    2510:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2517:	8b 40 38             	mov    eax,DWORD PTR [rax+0x38]
    251a:	39 c2                	cmp    edx,eax
    251c:	0f 4e c2             	cmovle eax,edx
    251f:	39 85 60 ff ff ff    	cmp    DWORD PTR [rbp-0xa0],eax
    2525:	0f 8d 73 0a 00 00    	jge    2f9e <framebuffer_redraw_region+0xf34>
								bzero(dst, 2 * nc);
    252b:	8b 85 5c ff ff ff    	mov    eax,DWORD PTR [rbp-0xa4]
    2531:	01 c0                	add    eax,eax
    2533:	48 63 d0             	movsxd rdx,eax
    2536:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    253a:	48 89 d6             	mov    rsi,rdx
    253d:	48 89 c7             	mov    rdi,rax
    2540:	e8 00 00 00 00       	call   2545 <framebuffer_redraw_region+0x4db>
								dst += video_mode.width * 2;
    2545:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 254b <framebuffer_redraw_region+0x4e1>
    254b:	01 c0                	add    eax,eax
    254d:	48 98                	cdqe
    254f:	48 01 45 e0          	add    QWORD PTR [rbp-0x20],rax
						}
				}
				return;
    2553:	e9 46 0a 00 00       	jmp    2f9e <framebuffer_redraw_region+0xf34>
							   && r->lx == fb->width && !fb->pix_x) {
    2558:	90                   	nop
				return;
    2559:	e9 40 0a 00 00       	jmp    2f9e <framebuffer_redraw_region+0xf34>
		} else {
				int shf = 0;
    255e:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [rbp-0x24],0x0
				void* mem = vga_mem_ptr; char* str = fb->text_mem;
    2565:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 256c <framebuffer_redraw_region+0x502>
    256c:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
    2570:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2577:	48 8b 00             	mov    rax,QWORD PTR [rax]
    257a:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
				ssize_t px_x, px_y, o_x, o_y;

				/* calculate the pixel offsets */
				o_x = fb->pix_x + r->x * 8;
    257e:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2585:	8b 50 24             	mov    edx,DWORD PTR [rax+0x24]
    2588:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    258f:	0f b7 00             	movzx  eax,WORD PTR [rax]
    2592:	98                   	cwde
    2593:	c1 e0 03             	shl    eax,0x3
    2596:	01 d0                	add    eax,edx
    2598:	89 85 7c ff ff ff    	mov    DWORD PTR [rbp-0x84],eax
				o_y = fb->pix_y + r->y * 16;
    259e:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    25a5:	8b 50 28             	mov    edx,DWORD PTR [rax+0x28]
    25a8:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    25af:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    25b3:	98                   	cwde
    25b4:	c1 e0 04             	shl    eax,0x4
    25b7:	01 d0                	add    eax,edx
    25b9:	89 85 78 ff ff ff    	mov    DWORD PTR [rbp-0x88],eax
				px_x = r->lx * 8;
    25bf:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    25c6:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
    25ca:	98                   	cwde
    25cb:	c1 e0 03             	shl    eax,0x3
    25ce:	89 85 74 ff ff ff    	mov    DWORD PTR [rbp-0x8c],eax
				px_y = r->ly * 16;
    25d4:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    25db:	0f b7 40 06          	movzx  eax,WORD PTR [rax+0x6]
    25df:	98                   	cwde
    25e0:	c1 e0 04             	shl    eax,0x4
    25e3:	89 85 70 ff ff ff    	mov    DWORD PTR [rbp-0x90],eax
				/* and ensure the bounds */
				if (o_x >= video_mode.width || o_y >= video_mode.height)
    25e9:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 25ef <framebuffer_redraw_region+0x585>
    25ef:	39 85 7c ff ff ff    	cmp    DWORD PTR [rbp-0x84],eax
    25f5:	0f 8d a6 09 00 00    	jge    2fa1 <framebuffer_redraw_region+0xf37>
    25fb:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2601 <framebuffer_redraw_region+0x597>
    2601:	39 85 78 ff ff ff    	cmp    DWORD PTR [rbp-0x88],eax
    2607:	0f 8d 94 09 00 00    	jge    2fa1 <framebuffer_redraw_region+0xf37>
					return;
				/* from the text buffer */
				px_x = min(px_x, 8 * min(fb->width - fb->cho_x - r->x, fb->chw_x - r->x));
    260d:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2614:	8b 50 08             	mov    edx,DWORD PTR [rax+0x8]
    2617:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    261e:	8b 40 2c             	mov    eax,DWORD PTR [rax+0x2c]
    2621:	29 c2                	sub    edx,eax
    2623:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    262a:	8b 40 34             	mov    eax,DWORD PTR [rax+0x34]
    262d:	39 c2                	cmp    edx,eax
    262f:	7d 2c                	jge    265d <framebuffer_redraw_region+0x5f3>
    2631:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2638:	8b 50 08             	mov    edx,DWORD PTR [rax+0x8]
    263b:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2642:	8b 40 2c             	mov    eax,DWORD PTR [rax+0x2c]
    2645:	29 c2                	sub    edx,eax
    2647:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    264e:	0f b7 00             	movzx  eax,WORD PTR [rax]
    2651:	98                   	cwde
    2652:	29 c2                	sub    edx,eax
    2654:	8d 04 d5 00 00 00 00 	lea    eax,[rdx*8+0x0]
    265b:	eb 1e                	jmp    267b <framebuffer_redraw_region+0x611>
    265d:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2664:	8b 50 34             	mov    edx,DWORD PTR [rax+0x34]
    2667:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    266e:	0f b7 00             	movzx  eax,WORD PTR [rax]
    2671:	98                   	cwde
    2672:	29 c2                	sub    edx,eax
    2674:	8d 04 d5 00 00 00 00 	lea    eax,[rdx*8+0x0]
    267b:	8b 95 74 ff ff ff    	mov    edx,DWORD PTR [rbp-0x8c]
    2681:	39 c2                	cmp    edx,eax
    2683:	0f 4e c2             	cmovle eax,edx
    2686:	89 85 74 ff ff ff    	mov    DWORD PTR [rbp-0x8c],eax
				px_y = min(px_y, 16 * min(fb->height - fb->cho_y - r->y, fb->chw_y - r->y));
    268c:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2693:	8b 50 0c             	mov    edx,DWORD PTR [rax+0xc]
    2696:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    269d:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
    26a0:	29 c2                	sub    edx,eax
    26a2:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    26a9:	8b 40 38             	mov    eax,DWORD PTR [rax+0x38]
    26ac:	39 c2                	cmp    edx,eax
    26ae:	7d 2b                	jge    26db <framebuffer_redraw_region+0x671>
    26b0:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    26b7:	8b 50 0c             	mov    edx,DWORD PTR [rax+0xc]
    26ba:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    26c1:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
    26c4:	29 c2                	sub    edx,eax
    26c6:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    26cd:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    26d1:	98                   	cwde
    26d2:	29 c2                	sub    edx,eax
    26d4:	89 d0                	mov    eax,edx
    26d6:	c1 e0 04             	shl    eax,0x4
    26d9:	eb 1d                	jmp    26f8 <framebuffer_redraw_region+0x68e>
    26db:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    26e2:	8b 50 38             	mov    edx,DWORD PTR [rax+0x38]
    26e5:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    26ec:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    26f0:	98                   	cwde
    26f1:	29 c2                	sub    edx,eax
    26f3:	89 d0                	mov    eax,edx
    26f5:	c1 e0 04             	shl    eax,0x4
    26f8:	8b 95 70 ff ff ff    	mov    edx,DWORD PTR [rbp-0x90]
    26fe:	39 c2                	cmp    edx,eax
    2700:	0f 4e c2             	cmovle eax,edx
    2703:	89 85 70 ff ff ff    	mov    DWORD PTR [rbp-0x90],eax
				/* and from video memory */
				px_x = min(px_x, video_mode.width - o_x);
    2709:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 270f <framebuffer_redraw_region+0x6a5>
    270f:	2b 85 7c ff ff ff    	sub    eax,DWORD PTR [rbp-0x84]
    2715:	8b 95 74 ff ff ff    	mov    edx,DWORD PTR [rbp-0x8c]
    271b:	39 c2                	cmp    edx,eax
    271d:	0f 4e c2             	cmovle eax,edx
    2720:	89 85 74 ff ff ff    	mov    DWORD PTR [rbp-0x8c],eax
				px_y = min(px_y, video_mode.height - o_y);
    2726:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 272c <framebuffer_redraw_region+0x6c2>
    272c:	2b 85 78 ff ff ff    	sub    eax,DWORD PTR [rbp-0x88]
    2732:	8b 95 70 ff ff ff    	mov    edx,DWORD PTR [rbp-0x90]
    2738:	39 c2                	cmp    edx,eax
    273a:	0f 4e c2             	cmovle eax,edx
    273d:	89 85 70 ff ff ff    	mov    DWORD PTR [rbp-0x90],eax
				if (px_x < 0 || px_y < 0)
    2743:	83 bd 74 ff ff ff 00 	cmp    DWORD PTR [rbp-0x8c],0x0
    274a:	0f 88 54 08 00 00    	js     2fa4 <framebuffer_redraw_region+0xf3a>
    2750:	83 bd 70 ff ff ff 00 	cmp    DWORD PTR [rbp-0x90],0x0
    2757:	0f 88 47 08 00 00    	js     2fa4 <framebuffer_redraw_region+0xf3a>
					return;
				
				if (video_mode.gm_bts == 4)
    275d:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2764 <framebuffer_redraw_region+0x6fa>
    2764:	3c 04                	cmp    al,0x4
    2766:	75 23                	jne    278b <framebuffer_redraw_region+0x721>
					shf = ((o_x % 2) == 1);
    2768:	8b 95 7c ff ff ff    	mov    edx,DWORD PTR [rbp-0x84]
    276e:	89 d0                	mov    eax,edx
    2770:	c1 f8 1f             	sar    eax,0x1f
    2773:	c1 e8 1f             	shr    eax,0x1f
    2776:	01 c2                	add    edx,eax
    2778:	83 e2 01             	and    edx,0x1
    277b:	29 c2                	sub    edx,eax
    277d:	89 d0                	mov    eax,edx
    277f:	83 f8 01             	cmp    eax,0x1
    2782:	0f 94 c0             	sete   al
    2785:	0f b6 c0             	movzx  eax,al
    2788:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
				
				/* set the memory references */
				mem += o_y * video_mode.bpsl + o_x * video_mode.btpp;
    278b:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 2791 <framebuffer_redraw_region+0x727>
    2791:	8b 85 78 ff ff ff    	mov    eax,DWORD PTR [rbp-0x88]
    2797:	0f af d0             	imul   edx,eax
    279a:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 27a1 <framebuffer_redraw_region+0x737>
    27a1:	0f be c0             	movsx  eax,al
    27a4:	0f af 85 7c ff ff ff 	imul   eax,DWORD PTR [rbp-0x84]
    27ab:	01 d0                	add    eax,edx
    27ad:	89 c0                	mov    eax,eax
    27af:	48 01 45 d0          	add    QWORD PTR [rbp-0x30],rax
				str += (fb->cho_y + r->y) * 2 * fb->width + (fb->cho_x + r->x) * 2;
    27b3:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    27ba:	8b 50 30             	mov    edx,DWORD PTR [rax+0x30]
    27bd:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    27c4:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    27c8:	98                   	cwde
    27c9:	01 d0                	add    eax,edx
    27cb:	8d 14 00             	lea    edx,[rax+rax*1]
    27ce:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    27d5:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    27d8:	0f af d0             	imul   edx,eax
    27db:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    27e2:	8b 48 2c             	mov    ecx,DWORD PTR [rax+0x2c]
    27e5:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    27ec:	0f b7 00             	movzx  eax,WORD PTR [rax]
    27ef:	98                   	cwde
    27f0:	01 c8                	add    eax,ecx
    27f2:	01 c0                	add    eax,eax
    27f4:	01 d0                	add    eax,edx
    27f6:	48 98                	cdqe
    27f8:	48 01 45 c8          	add    QWORD PTR [rbp-0x38],rax

				/* check for excluding rects */
				if (fb->r_excl) {
    27fc:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2803:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    2807:	48 85 c0             	test   rax,rax
    280a:	0f 84 f3 06 00 00    	je     2f03 <framebuffer_redraw_region+0xe99>
						/* use y and x stride marks */
						size_t ns_y = 0, ns_x = 0;
    2810:	48 c7 45 c0 00 00 00 00 	mov    QWORD PTR [rbp-0x40],0x0
    2818:	48 c7 45 b8 00 00 00 00 	mov    QWORD PTR [rbp-0x48],0x0
						struct stride /* exclude range:  y is key */
								stride_y[10], stride_x[20];
						struct exclude_rect* pe = fb->r_excl;
    2820:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2827:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    282b:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
						while (pe) {
    282f:	e9 e5 01 00 00       	jmp    2a19 <framebuffer_redraw_region+0x9af>
								struct exclude_rect er = {0};
    2834:	66 0f ef c0          	pxor   xmm0,xmm0
    2838:	0f 29 85 40 ff ff ff 	movaps XMMWORD PTR [rbp-0xc0],xmm0
    283f:	66 0f d6 85 50 ff ff ff 	movq   QWORD PTR [rbp-0xb0],xmm0
								er = *pe;
    2847:	48 8b 4d b0          	mov    rcx,QWORD PTR [rbp-0x50]
    284b:	48 8b 01             	mov    rax,QWORD PTR [rcx]
    284e:	48 8b 51 08          	mov    rdx,QWORD PTR [rcx+0x8]
    2852:	48 89 85 40 ff ff ff 	mov    QWORD PTR [rbp-0xc0],rax
    2859:	48 89 95 48 ff ff ff 	mov    QWORD PTR [rbp-0xb8],rdx
    2860:	48 8b 41 10          	mov    rax,QWORD PTR [rcx+0x10]
    2864:	48 89 85 50 ff ff ff 	mov    QWORD PTR [rbp-0xb0],rax
								er.x -= fb->pix_x;
    286b:	8b 95 40 ff ff ff    	mov    edx,DWORD PTR [rbp-0xc0]
    2871:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2878:	8b 40 24             	mov    eax,DWORD PTR [rax+0x24]
    287b:	29 c2                	sub    edx,eax
    287d:	89 95 40 ff ff ff    	mov    DWORD PTR [rbp-0xc0],edx
								er.y -= fb->pix_y;
    2883:	8b 95 44 ff ff ff    	mov    edx,DWORD PTR [rbp-0xbc]
    2889:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2890:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    2893:	29 c2                	sub    edx,eax
    2895:	89 95 44 ff ff ff    	mov    DWORD PTR [rbp-0xbc],edx
								if (er.x + er.lx > o_x && er.y + er.ly > o_y) {
    289b:	8b 95 40 ff ff ff    	mov    edx,DWORD PTR [rbp-0xc0]
    28a1:	8b 85 48 ff ff ff    	mov    eax,DWORD PTR [rbp-0xb8]
    28a7:	01 d0                	add    eax,edx
    28a9:	39 85 7c ff ff ff    	cmp    DWORD PTR [rbp-0x84],eax
    28af:	0f 8d 58 01 00 00    	jge    2a0d <framebuffer_redraw_region+0x9a3>
    28b5:	8b 95 44 ff ff ff    	mov    edx,DWORD PTR [rbp-0xbc]
    28bb:	8b 85 4c ff ff ff    	mov    eax,DWORD PTR [rbp-0xb4]
    28c1:	01 d0                	add    eax,edx
    28c3:	39 85 78 ff ff ff    	cmp    DWORD PTR [rbp-0x88],eax
    28c9:	0f 8d 3e 01 00 00    	jge    2a0d <framebuffer_redraw_region+0x9a3>
										if (o_x + px_x > er.x && o_y + px_y > er.y) {
    28cf:	8b 95 7c ff ff ff    	mov    edx,DWORD PTR [rbp-0x84]
    28d5:	8b 85 74 ff ff ff    	mov    eax,DWORD PTR [rbp-0x8c]
    28db:	01 c2                	add    edx,eax
    28dd:	8b 85 40 ff ff ff    	mov    eax,DWORD PTR [rbp-0xc0]
    28e3:	39 c2                	cmp    edx,eax
    28e5:	0f 8e 22 01 00 00    	jle    2a0d <framebuffer_redraw_region+0x9a3>
    28eb:	8b 95 78 ff ff ff    	mov    edx,DWORD PTR [rbp-0x88]
    28f1:	8b 85 70 ff ff ff    	mov    eax,DWORD PTR [rbp-0x90]
    28f7:	01 c2                	add    edx,eax
    28f9:	8b 85 44 ff ff ff    	mov    eax,DWORD PTR [rbp-0xbc]
    28ff:	39 c2                	cmp    edx,eax
    2901:	0f 8e 06 01 00 00    	jle    2a0d <framebuffer_redraw_region+0x9a3>
												struct stride sx, sy;
												/* overlap y */
												if (ns_y == 10 || ns_x == 20) /* we could draw parts */
    2907:	48 83 7d c0 0a       	cmp    QWORD PTR [rbp-0x40],0xa
    290c:	74 07                	je     2915 <framebuffer_redraw_region+0x8ab>
    290e:	48 83 7d b8 14       	cmp    QWORD PTR [rbp-0x48],0x14
    2913:	75 30                	jne    2945 <framebuffer_redraw_region+0x8db>
														die("use bigger fb stride buffers\n");
    2915:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    291c:	bf 0c 00 00 00       	mov    edi,0xc
    2921:	b8 00 00 00 00       	mov    eax,0x0
    2926:	e8 00 00 00 00       	call   292b <framebuffer_redraw_region+0x8c1>
    292b:	b8 00 00 00 00       	mov    eax,0x0
    2930:	e8 00 00 00 00       	call   2935 <framebuffer_redraw_region+0x8cb>
    2935:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    293c:	e8 00 00 00 00       	call   2941 <framebuffer_redraw_region+0x8d7>
    2941:	fa                   	cli
    2942:	f4                   	hlt
    2943:	eb fd                	jmp    2942 <framebuffer_redraw_region+0x8d8>
												/* crop the rect and insert two strides */
												sx.x1 = max(o_x, er.x);
    2945:	8b 95 40 ff ff ff    	mov    edx,DWORD PTR [rbp-0xc0]
    294b:	8b 85 7c ff ff ff    	mov    eax,DWORD PTR [rbp-0x84]
    2951:	39 c2                	cmp    edx,eax
    2953:	0f 4d c2             	cmovge eax,edx
    2956:	89 85 38 ff ff ff    	mov    DWORD PTR [rbp-0xc8],eax
												sx.x2 = min(er.x + er.lx, o_x + px_x);
    295c:	8b 95 7c ff ff ff    	mov    edx,DWORD PTR [rbp-0x84]
    2962:	8b 85 74 ff ff ff    	mov    eax,DWORD PTR [rbp-0x8c]
    2968:	01 c2                	add    edx,eax
    296a:	8b 8d 40 ff ff ff    	mov    ecx,DWORD PTR [rbp-0xc0]
    2970:	8b 85 48 ff ff ff    	mov    eax,DWORD PTR [rbp-0xb8]
    2976:	01 c8                	add    eax,ecx
    2978:	39 c2                	cmp    edx,eax
    297a:	0f 4e c2             	cmovle eax,edx
    297d:	89 85 3c ff ff ff    	mov    DWORD PTR [rbp-0xc4],eax
												sy.x1 = max(o_y, er.y);
    2983:	8b 95 44 ff ff ff    	mov    edx,DWORD PTR [rbp-0xbc]
    2989:	8b 85 78 ff ff ff    	mov    eax,DWORD PTR [rbp-0x88]
    298f:	39 c2                	cmp    edx,eax
    2991:	0f 4d c2             	cmovge eax,edx
    2994:	89 85 30 ff ff ff    	mov    DWORD PTR [rbp-0xd0],eax
												sy.x2 = min(er.y + er.ly, o_y + px_y);
    299a:	8b 95 78 ff ff ff    	mov    edx,DWORD PTR [rbp-0x88]
    29a0:	8b 85 70 ff ff ff    	mov    eax,DWORD PTR [rbp-0x90]
    29a6:	01 c2                	add    edx,eax
    29a8:	8b 8d 44 ff ff ff    	mov    ecx,DWORD PTR [rbp-0xbc]
    29ae:	8b 85 4c ff ff ff    	mov    eax,DWORD PTR [rbp-0xb4]
    29b4:	01 c8                	add    eax,ecx
    29b6:	39 c2                	cmp    edx,eax
    29b8:	0f 4e c2             	cmovle eax,edx
    29bb:	89 85 34 ff ff ff    	mov    DWORD PTR [rbp-0xcc],eax
												if(add_stride(stride_y, ns_y, &sy))
    29c1:	48 8d 95 30 ff ff ff 	lea    rdx,[rbp-0xd0]
    29c8:	48 8b 4d c0          	mov    rcx,QWORD PTR [rbp-0x40]
    29cc:	48 8d 85 40 fe ff ff 	lea    rax,[rbp-0x1c0]
    29d3:	48 89 ce             	mov    rsi,rcx
    29d6:	48 89 c7             	mov    rdi,rax
    29d9:	e8 00 00 00 00       	call   29de <framebuffer_redraw_region+0x974>
    29de:	85 c0                	test   eax,eax
    29e0:	74 05                	je     29e7 <framebuffer_redraw_region+0x97d>
														ns_y++;
    29e2:	48 83 45 c0 01       	add    QWORD PTR [rbp-0x40],0x1
												if (add_stride(stride_x, ns_x, &sx))
    29e7:	48 8d 95 38 ff ff ff 	lea    rdx,[rbp-0xc8]
    29ee:	48 8b 4d b8          	mov    rcx,QWORD PTR [rbp-0x48]
    29f2:	48 8d 85 90 fe ff ff 	lea    rax,[rbp-0x170]
    29f9:	48 89 ce             	mov    rsi,rcx
    29fc:	48 89 c7             	mov    rdi,rax
    29ff:	e8 00 00 00 00       	call   2a04 <framebuffer_redraw_region+0x99a>
    2a04:	85 c0                	test   eax,eax
    2a06:	74 05                	je     2a0d <framebuffer_redraw_region+0x9a3>
														ns_x++;
    2a08:	48 83 45 b8 01       	add    QWORD PTR [rbp-0x48],0x1
										}
								}
								pe = pe->next;
    2a0d:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2a11:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    2a15:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
						while (pe) {
    2a19:	48 83 7d b0 00       	cmp    QWORD PTR [rbp-0x50],0x0
    2a1e:	0f 85 10 fe ff ff    	jne    2834 <framebuffer_redraw_region+0x7ca>
						}
						/* add the dummy entries (so we don't have to check at +x) */
						stride_y[ns_y].x1 = o_y + px_y;
    2a24:	8b 95 78 ff ff ff    	mov    edx,DWORD PTR [rbp-0x88]
    2a2a:	8b 85 70 ff ff ff    	mov    eax,DWORD PTR [rbp-0x90]
    2a30:	01 c2                	add    edx,eax
    2a32:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2a36:	89 94 c5 40 fe ff ff 	mov    DWORD PTR [rbp+rax*8-0x1c0],edx
						stride_y[ns_y++].x2 = o_y + px_y;
    2a3d:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2a41:	48 8d 50 01          	lea    rdx,[rax+0x1]
    2a45:	48 89 55 c0          	mov    QWORD PTR [rbp-0x40],rdx
    2a49:	8b 8d 78 ff ff ff    	mov    ecx,DWORD PTR [rbp-0x88]
    2a4f:	8b 95 70 ff ff ff    	mov    edx,DWORD PTR [rbp-0x90]
    2a55:	01 ca                	add    edx,ecx
    2a57:	89 94 c5 44 fe ff ff 	mov    DWORD PTR [rbp+rax*8-0x1bc],edx
						stride_x[ns_x].x1 = o_x + px_x;
    2a5e:	8b 95 7c ff ff ff    	mov    edx,DWORD PTR [rbp-0x84]
    2a64:	8b 85 74 ff ff ff    	mov    eax,DWORD PTR [rbp-0x8c]
    2a6a:	01 c2                	add    edx,eax
    2a6c:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2a70:	89 94 c5 90 fe ff ff 	mov    DWORD PTR [rbp+rax*8-0x170],edx
						stride_x[ns_x++].x2 = o_x + px_x;
    2a77:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2a7b:	48 8d 50 01          	lea    rdx,[rax+0x1]
    2a7f:	48 89 55 b8          	mov    QWORD PTR [rbp-0x48],rdx
    2a83:	8b 8d 7c ff ff ff    	mov    ecx,DWORD PTR [rbp-0x84]
    2a89:	8b 95 74 ff ff ff    	mov    edx,DWORD PTR [rbp-0x8c]
    2a8f:	01 ca                	add    edx,ecx
    2a91:	89 94 c5 94 fe ff ff 	mov    DWORD PTR [rbp+rax*8-0x16c],edx
						if (ns_y > 1 && ns_x > 1) {
    2a98:	48 83 7d c0 01       	cmp    QWORD PTR [rbp-0x40],0x1
    2a9d:	0f 86 60 04 00 00    	jbe    2f03 <framebuffer_redraw_region+0xe99>
    2aa3:	48 83 7d b8 01       	cmp    QWORD PTR [rbp-0x48],0x1
    2aa8:	0f 86 55 04 00 00    	jbe    2f03 <framebuffer_redraw_region+0xe99>
								ssize_t lpx_x, lpx_y, lo_x = o_x, lo_y = o_y;
    2aae:	8b 85 7c ff ff ff    	mov    eax,DWORD PTR [rbp-0x84]
    2ab4:	89 45 ac             	mov    DWORD PTR [rbp-0x54],eax
    2ab7:	8b 85 78 ff ff ff    	mov    eax,DWORD PTR [rbp-0x88]
    2abd:	89 45 a8             	mov    DWORD PTR [rbp-0x58],eax
								char* str2 = str; int shf2 = shf; void* mem2;
    2ac0:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    2ac4:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
    2ac8:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    2acb:	89 45 9c             	mov    DWORD PTR [rbp-0x64],eax
								/* now we have a field of strides */
								for (size_t i = 0; i < ns_y; i++) {
    2ace:	48 c7 45 88 00 00 00 00 	mov    QWORD PTR [rbp-0x78],0x0
    2ad6:	e9 15 04 00 00       	jmp    2ef0 <framebuffer_redraw_region+0xe86>
										/* draw full lines before the stride */
										if (stride_y[i].x1 > lo_y) {
    2adb:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2adf:	8b 84 c5 40 fe ff ff 	mov    eax,DWORD PTR [rbp+rax*8-0x1c0]
    2ae6:	39 45 a8             	cmp    DWORD PTR [rbp-0x58],eax
    2ae9:	0f 8d 1f 01 00 00    	jge    2c0e <framebuffer_redraw_region+0xba4>
												lpx_x = px_x;
    2aef:	8b 85 74 ff ff ff    	mov    eax,DWORD PTR [rbp-0x8c]
    2af5:	89 85 6c ff ff ff    	mov    DWORD PTR [rbp-0x94],eax
												lo_x = o_x;
    2afb:	8b 85 7c ff ff ff    	mov    eax,DWORD PTR [rbp-0x84]
    2b01:	89 45 ac             	mov    DWORD PTR [rbp-0x54],eax
												shf2 = shf;
    2b04:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    2b07:	89 45 9c             	mov    DWORD PTR [rbp-0x64],eax
												lpx_y = min(stride_y[i].x1 - lo_y, o_y + px_y - lo_y);
    2b0a:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2b0e:	8b 94 c5 40 fe ff ff 	mov    edx,DWORD PTR [rbp+rax*8-0x1c0]
    2b15:	8b 8d 78 ff ff ff    	mov    ecx,DWORD PTR [rbp-0x88]
    2b1b:	8b 85 70 ff ff ff    	mov    eax,DWORD PTR [rbp-0x90]
    2b21:	01 c8                	add    eax,ecx
    2b23:	39 c2                	cmp    edx,eax
    2b25:	7d 10                	jge    2b37 <framebuffer_redraw_region+0xacd>
    2b27:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2b2b:	8b 84 c5 40 fe ff ff 	mov    eax,DWORD PTR [rbp+rax*8-0x1c0]
    2b32:	2b 45 a8             	sub    eax,DWORD PTR [rbp-0x58]
    2b35:	eb 11                	jmp    2b48 <framebuffer_redraw_region+0xade>
    2b37:	8b 95 78 ff ff ff    	mov    edx,DWORD PTR [rbp-0x88]
    2b3d:	8b 85 70 ff ff ff    	mov    eax,DWORD PTR [rbp-0x90]
    2b43:	01 d0                	add    eax,edx
    2b45:	2b 45 a8             	sub    eax,DWORD PTR [rbp-0x58]
    2b48:	89 85 68 ff ff ff    	mov    DWORD PTR [rbp-0x98],eax
												if (lpx_y) /* skip empty dummy */
    2b4e:	83 bd 68 ff ff ff 00 	cmp    DWORD PTR [rbp-0x98],0x0
    2b55:	0f 84 b3 00 00 00    	je     2c0e <framebuffer_redraw_region+0xba4>
													render_text(fb->font, str2, mem, 2 * fb->width,
														video_mode.bpsl, video_mode.gm_bts, lpx_x,
														lpx_y, shf2, fb->cur_x - r->x, fb->cur_y - r->y,
														0, (lo_y - o_y) % 16);
    2b5b:	8b 45 a8             	mov    eax,DWORD PTR [rbp-0x58]
    2b5e:	2b 85 78 ff ff ff    	sub    eax,DWORD PTR [rbp-0x88]
    2b64:	89 c2                	mov    edx,eax
													render_text(fb->font, str2, mem, 2 * fb->width,
    2b66:	89 d0                	mov    eax,edx
    2b68:	c1 f8 1f             	sar    eax,0x1f
    2b6b:	c1 e8 1c             	shr    eax,0x1c
    2b6e:	01 c2                	add    edx,eax
    2b70:	83 e2 0f             	and    edx,0xf
    2b73:	29 c2                	sub    edx,eax
    2b75:	41 89 d2             	mov    r10d,edx
														lpx_y, shf2, fb->cur_x - r->x, fb->cur_y - r->y,
    2b78:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2b7f:	8b 50 20             	mov    edx,DWORD PTR [rax+0x20]
    2b82:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    2b89:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    2b8d:	98                   	cwde
													render_text(fb->font, str2, mem, 2 * fb->width,
    2b8e:	29 c2                	sub    edx,eax
    2b90:	41 89 d0             	mov    r8d,edx
														lpx_y, shf2, fb->cur_x - r->x, fb->cur_y - r->y,
    2b93:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2b9a:	8b 50 1c             	mov    edx,DWORD PTR [rax+0x1c]
    2b9d:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    2ba4:	0f b7 00             	movzx  eax,WORD PTR [rax]
    2ba7:	98                   	cwde
													render_text(fb->font, str2, mem, 2 * fb->width,
    2ba8:	89 d7                	mov    edi,edx
    2baa:	29 c7                	sub    edi,eax
														video_mode.bpsl, video_mode.gm_bts, lpx_x,
    2bac:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2bb3 <framebuffer_redraw_region+0xb49>
													render_text(fb->font, str2, mem, 2 * fb->width,
    2bb3:	4c 0f be c8          	movsx  r9,al
														video_mode.bpsl, video_mode.gm_bts, lpx_x,
    2bb7:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2bbd <framebuffer_redraw_region+0xb53>
													render_text(fb->font, str2, mem, 2 * fb->width,
    2bbd:	41 89 c3             	mov    r11d,eax
    2bc0:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2bc7:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    2bca:	01 c0                	add    eax,eax
    2bcc:	48 63 c8             	movsxd rcx,eax
    2bcf:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2bd6:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    2bda:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    2bde:	48 8b 75 a0          	mov    rsi,QWORD PTR [rbp-0x60]
    2be2:	48 83 ec 08          	sub    rsp,0x8
    2be6:	41 52                	push   r10
    2be8:	6a 00                	push   0x0
    2bea:	41 50                	push   r8
    2bec:	57                   	push   rdi
    2bed:	8b 7d 9c             	mov    edi,DWORD PTR [rbp-0x64]
    2bf0:	57                   	push   rdi
    2bf1:	8b bd 68 ff ff ff    	mov    edi,DWORD PTR [rbp-0x98]
    2bf7:	57                   	push   rdi
    2bf8:	8b bd 6c ff ff ff    	mov    edi,DWORD PTR [rbp-0x94]
    2bfe:	57                   	push   rdi
    2bff:	4d 89 d8             	mov    r8,r11
    2c02:	48 89 c7             	mov    rdi,rax
    2c05:	e8 00 00 00 00       	call   2c0a <framebuffer_redraw_region+0xba0>
    2c0a:	48 83 c4 40          	add    rsp,0x40
										}
										/* we are inside the stride */
										/* update the references */
										mem += (stride_y[i].x1 - lo_y) * video_mode.bpsl;
    2c0e:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2c12:	8b 84 c5 40 fe ff ff 	mov    eax,DWORD PTR [rbp+rax*8-0x1c0]
    2c19:	2b 45 a8             	sub    eax,DWORD PTR [rbp-0x58]
    2c1c:	89 c2                	mov    edx,eax
    2c1e:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2c24 <framebuffer_redraw_region+0xbba>
    2c24:	0f af c2             	imul   eax,edx
    2c27:	89 c0                	mov    eax,eax
    2c29:	48 01 45 d0          	add    QWORD PTR [rbp-0x30],rax
										str += ((stride_y[i].x1 - lo_y) / 16) * 2 * fb->width;
    2c2d:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2c31:	8b 84 c5 40 fe ff ff 	mov    eax,DWORD PTR [rbp+rax*8-0x1c0]
    2c38:	2b 45 a8             	sub    eax,DWORD PTR [rbp-0x58]
    2c3b:	8d 50 0f             	lea    edx,[rax+0xf]
    2c3e:	85 c0                	test   eax,eax
    2c40:	0f 48 c2             	cmovs  eax,edx
    2c43:	c1 f8 04             	sar    eax,0x4
    2c46:	8d 14 00             	lea    edx,[rax+rax*1]
    2c49:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2c50:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    2c53:	0f af c2             	imul   eax,edx
    2c56:	48 98                	cdqe
    2c58:	48 01 45 c8          	add    QWORD PTR [rbp-0x38],rax
										str2 = str;
    2c5c:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    2c60:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
										lo_y = stride_y[i].x1;
    2c64:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2c68:	8b 84 c5 40 fe ff ff 	mov    eax,DWORD PTR [rbp+rax*8-0x1c0]
    2c6f:	89 45 a8             	mov    DWORD PTR [rbp-0x58],eax
										lpx_y = min(o_y + px_y, stride_y[i].x2) - stride_y[i].x1;
    2c72:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2c76:	8b 94 c5 44 fe ff ff 	mov    edx,DWORD PTR [rbp+rax*8-0x1bc]
    2c7d:	8b 8d 78 ff ff ff    	mov    ecx,DWORD PTR [rbp-0x88]
    2c83:	8b 85 70 ff ff ff    	mov    eax,DWORD PTR [rbp-0x90]
    2c89:	01 c8                	add    eax,ecx
    2c8b:	39 c2                	cmp    edx,eax
    2c8d:	0f 4f d0             	cmovg  edx,eax
    2c90:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2c94:	8b 84 c5 40 fe ff ff 	mov    eax,DWORD PTR [rbp+rax*8-0x1c0]
    2c9b:	29 c2                	sub    edx,eax
    2c9d:	89 95 68 ff ff ff    	mov    DWORD PTR [rbp-0x98],edx
										if (!lpx_y) /* break after zero stride */
    2ca3:	83 bd 68 ff ff ff 00 	cmp    DWORD PTR [rbp-0x98],0x0
    2caa:	0f 84 f7 02 00 00    	je     2fa7 <framebuffer_redraw_region+0xf3d>
												break;
										lo_x = o_x;
    2cb0:	8b 85 7c ff ff ff    	mov    eax,DWORD PTR [rbp-0x84]
    2cb6:	89 45 ac             	mov    DWORD PTR [rbp-0x54],eax
										shf2 = shf;
    2cb9:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    2cbc:	89 45 9c             	mov    DWORD PTR [rbp-0x64],eax
										mem2 = mem;
    2cbf:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    2cc3:	48 89 45 90          	mov    QWORD PTR [rbp-0x70],rax
										/* now draw the x strides */
										for (size_t j = 0; j < ns_x; j++) {
    2cc7:	48 c7 45 80 00 00 00 00 	mov    QWORD PTR [rbp-0x80],0x0
    2ccf:	e9 af 01 00 00       	jmp    2e83 <framebuffer_redraw_region+0xe19>
												/* draw to x before */
												if (stride_x[j].x1 > lo_x) {
    2cd4:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    2cd8:	8b 84 c5 90 fe ff ff 	mov    eax,DWORD PTR [rbp+rax*8-0x170]
    2cdf:	39 45 ac             	cmp    DWORD PTR [rbp-0x54],eax
    2ce2:	0f 8d 13 01 00 00    	jge    2dfb <framebuffer_redraw_region+0xd91>
														lpx_x = min(o_x + px_x - lo_x, stride_x[j].x1 - lo_x);
    2ce8:	8b 95 7c ff ff ff    	mov    edx,DWORD PTR [rbp-0x84]
    2cee:	8b 85 74 ff ff ff    	mov    eax,DWORD PTR [rbp-0x8c]
    2cf4:	01 c2                	add    edx,eax
    2cf6:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    2cfa:	8b 84 c5 90 fe ff ff 	mov    eax,DWORD PTR [rbp+rax*8-0x170]
    2d01:	39 c2                	cmp    edx,eax
    2d03:	7d 13                	jge    2d18 <framebuffer_redraw_region+0xcae>
    2d05:	8b 95 7c ff ff ff    	mov    edx,DWORD PTR [rbp-0x84]
    2d0b:	8b 85 74 ff ff ff    	mov    eax,DWORD PTR [rbp-0x8c]
    2d11:	01 d0                	add    eax,edx
    2d13:	2b 45 ac             	sub    eax,DWORD PTR [rbp-0x54]
    2d16:	eb 0e                	jmp    2d26 <framebuffer_redraw_region+0xcbc>
    2d18:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    2d1c:	8b 84 c5 90 fe ff ff 	mov    eax,DWORD PTR [rbp+rax*8-0x170]
    2d23:	2b 45 ac             	sub    eax,DWORD PTR [rbp-0x54]
    2d26:	89 85 6c ff ff ff    	mov    DWORD PTR [rbp-0x94],eax
														render_text(fb->font, str2, mem2, 2 * fb->width,
																video_mode.bpsl, video_mode.gm_bts, lpx_x,
																lpx_y, shf2, fb->cur_x - r->x, fb->cur_y - r->y,
																(lo_x - o_x) % 8, (lo_y - o_y) % 16);
    2d2c:	8b 45 a8             	mov    eax,DWORD PTR [rbp-0x58]
    2d2f:	2b 85 78 ff ff ff    	sub    eax,DWORD PTR [rbp-0x88]
    2d35:	89 c2                	mov    edx,eax
														render_text(fb->font, str2, mem2, 2 * fb->width,
    2d37:	89 d0                	mov    eax,edx
    2d39:	c1 f8 1f             	sar    eax,0x1f
    2d3c:	c1 e8 1c             	shr    eax,0x1c
    2d3f:	01 c2                	add    edx,eax
    2d41:	83 e2 0f             	and    edx,0xf
    2d44:	29 c2                	sub    edx,eax
    2d46:	41 89 d3             	mov    r11d,edx
																(lo_x - o_x) % 8, (lo_y - o_y) % 16);
    2d49:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
    2d4c:	2b 85 7c ff ff ff    	sub    eax,DWORD PTR [rbp-0x84]
    2d52:	89 c2                	mov    edx,eax
														render_text(fb->font, str2, mem2, 2 * fb->width,
    2d54:	89 d0                	mov    eax,edx
    2d56:	c1 f8 1f             	sar    eax,0x1f
    2d59:	c1 e8 1d             	shr    eax,0x1d
    2d5c:	01 c2                	add    edx,eax
    2d5e:	83 e2 07             	and    edx,0x7
    2d61:	29 c2                	sub    edx,eax
    2d63:	41 89 d2             	mov    r10d,edx
																lpx_y, shf2, fb->cur_x - r->x, fb->cur_y - r->y,
    2d66:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2d6d:	8b 50 20             	mov    edx,DWORD PTR [rax+0x20]
    2d70:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    2d77:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    2d7b:	98                   	cwde
														render_text(fb->font, str2, mem2, 2 * fb->width,
    2d7c:	29 c2                	sub    edx,eax
    2d7e:	41 89 d0             	mov    r8d,edx
																lpx_y, shf2, fb->cur_x - r->x, fb->cur_y - r->y,
    2d81:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2d88:	8b 50 1c             	mov    edx,DWORD PTR [rax+0x1c]
    2d8b:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    2d92:	0f b7 00             	movzx  eax,WORD PTR [rax]
    2d95:	98                   	cwde
														render_text(fb->font, str2, mem2, 2 * fb->width,
    2d96:	89 d7                	mov    edi,edx
    2d98:	29 c7                	sub    edi,eax
																video_mode.bpsl, video_mode.gm_bts, lpx_x,
    2d9a:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2da1 <framebuffer_redraw_region+0xd37>
														render_text(fb->font, str2, mem2, 2 * fb->width,
    2da1:	4c 0f be c8          	movsx  r9,al
																video_mode.bpsl, video_mode.gm_bts, lpx_x,
    2da5:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2dab <framebuffer_redraw_region+0xd41>
														render_text(fb->font, str2, mem2, 2 * fb->width,
    2dab:	89 c3                	mov    ebx,eax
    2dad:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2db4:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    2db7:	01 c0                	add    eax,eax
    2db9:	48 63 c8             	movsxd rcx,eax
    2dbc:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2dc3:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    2dc7:	48 8b 55 90          	mov    rdx,QWORD PTR [rbp-0x70]
    2dcb:	48 8b 75 a0          	mov    rsi,QWORD PTR [rbp-0x60]
    2dcf:	48 83 ec 08          	sub    rsp,0x8
    2dd3:	41 53                	push   r11
    2dd5:	41 52                	push   r10
    2dd7:	41 50                	push   r8
    2dd9:	57                   	push   rdi
    2dda:	8b 7d 9c             	mov    edi,DWORD PTR [rbp-0x64]
    2ddd:	57                   	push   rdi
    2dde:	8b bd 68 ff ff ff    	mov    edi,DWORD PTR [rbp-0x98]
    2de4:	57                   	push   rdi
    2de5:	8b bd 6c ff ff ff    	mov    edi,DWORD PTR [rbp-0x94]
    2deb:	57                   	push   rdi
    2dec:	49 89 d8             	mov    r8,rbx
    2def:	48 89 c7             	mov    rdi,rax
    2df2:	e8 00 00 00 00       	call   2df7 <framebuffer_redraw_region+0xd8d>
    2df7:	48 83 c4 40          	add    rsp,0x40
												}
												/* draw nothing as x,y are inside */
												lo_x = stride_x[j].x2;
    2dfb:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    2dff:	8b 84 c5 94 fe ff ff 	mov    eax,DWORD PTR [rbp+rax*8-0x16c]
    2e06:	89 45 ac             	mov    DWORD PTR [rbp-0x54],eax
												str2 = str + ((lo_x - o_x) / 8) * 2;
    2e09:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
    2e0c:	2b 85 7c ff ff ff    	sub    eax,DWORD PTR [rbp-0x84]
    2e12:	8d 50 07             	lea    edx,[rax+0x7]
    2e15:	85 c0                	test   eax,eax
    2e17:	0f 48 c2             	cmovs  eax,edx
    2e1a:	c1 f8 03             	sar    eax,0x3
    2e1d:	01 c0                	add    eax,eax
    2e1f:	48 63 d0             	movsxd rdx,eax
    2e22:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    2e26:	48 01 d0             	add    rax,rdx
    2e29:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
												mem2 = mem + (lo_x - o_x) * video_mode.btpp;
    2e2d:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
    2e30:	2b 85 7c ff ff ff    	sub    eax,DWORD PTR [rbp-0x84]
    2e36:	89 c2                	mov    edx,eax
    2e38:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2e3f <framebuffer_redraw_region+0xdd5>
    2e3f:	0f be c0             	movsx  eax,al
    2e42:	0f af c2             	imul   eax,edx
    2e45:	48 63 d0             	movsxd rdx,eax
    2e48:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    2e4c:	48 01 d0             	add    rax,rdx
    2e4f:	48 89 45 90          	mov    QWORD PTR [rbp-0x70],rax
												if (video_mode.gm_bts == 4)
    2e53:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2e5a <framebuffer_redraw_region+0xdf0>
    2e5a:	3c 04                	cmp    al,0x4
    2e5c:	75 20                	jne    2e7e <framebuffer_redraw_region+0xe14>
														shf2 = ((lo_x % 2) == 1);
    2e5e:	8b 55 ac             	mov    edx,DWORD PTR [rbp-0x54]
    2e61:	89 d0                	mov    eax,edx
    2e63:	c1 f8 1f             	sar    eax,0x1f
    2e66:	c1 e8 1f             	shr    eax,0x1f
    2e69:	01 c2                	add    edx,eax
    2e6b:	83 e2 01             	and    edx,0x1
    2e6e:	29 c2                	sub    edx,eax
    2e70:	89 d0                	mov    eax,edx
    2e72:	83 f8 01             	cmp    eax,0x1
    2e75:	0f 94 c0             	sete   al
    2e78:	0f b6 c0             	movzx  eax,al
    2e7b:	89 45 9c             	mov    DWORD PTR [rbp-0x64],eax
										for (size_t j = 0; j < ns_x; j++) {
    2e7e:	48 83 45 80 01       	add    QWORD PTR [rbp-0x80],0x1
    2e83:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    2e87:	48 3b 45 b8          	cmp    rax,QWORD PTR [rbp-0x48]
    2e8b:	0f 82 43 fe ff ff    	jb     2cd4 <framebuffer_redraw_region+0xc6a>
										}
										/* and set the memory */
										mem += lpx_y * video_mode.bpsl;
    2e91:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 2e97 <framebuffer_redraw_region+0xe2d>
    2e97:	8b 85 68 ff ff ff    	mov    eax,DWORD PTR [rbp-0x98]
    2e9d:	0f af c2             	imul   eax,edx
    2ea0:	89 c0                	mov    eax,eax
    2ea2:	48 01 45 d0          	add    QWORD PTR [rbp-0x30],rax
										str2 = str + ((stride_y[i].x2 - lo_y) / 16) * 2 * fb->width;
    2ea6:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2eaa:	8b 84 c5 44 fe ff ff 	mov    eax,DWORD PTR [rbp+rax*8-0x1bc]
    2eb1:	2b 45 a8             	sub    eax,DWORD PTR [rbp-0x58]
    2eb4:	8d 50 0f             	lea    edx,[rax+0xf]
    2eb7:	85 c0                	test   eax,eax
    2eb9:	0f 48 c2             	cmovs  eax,edx
    2ebc:	c1 f8 04             	sar    eax,0x4
    2ebf:	8d 14 00             	lea    edx,[rax+rax*1]
    2ec2:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2ec9:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    2ecc:	0f af c2             	imul   eax,edx
    2ecf:	48 63 d0             	movsxd rdx,eax
    2ed2:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    2ed6:	48 01 d0             	add    rax,rdx
    2ed9:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
										lo_y = stride_y[i].x2;
    2edd:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2ee1:	8b 84 c5 44 fe ff ff 	mov    eax,DWORD PTR [rbp+rax*8-0x1bc]
    2ee8:	89 45 a8             	mov    DWORD PTR [rbp-0x58],eax
								for (size_t i = 0; i < ns_y; i++) {
    2eeb:	48 83 45 88 01       	add    QWORD PTR [rbp-0x78],0x1
    2ef0:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2ef4:	48 3b 45 c0          	cmp    rax,QWORD PTR [rbp-0x40]
    2ef8:	0f 82 dd fb ff ff    	jb     2adb <framebuffer_redraw_region+0xa71>
								}
								return;
    2efe:	e9 a5 00 00 00       	jmp    2fa8 <framebuffer_redraw_region+0xf3e>
				}

				/* and draw the text */
				render_text(fb->font, str, mem, 2 * fb->width, video_mode.bpsl,
						video_mode.gm_bts, px_x, px_y, shf, fb->cur_x - r->x,
						fb->cur_y - r->y, 0, 0);
    2f03:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2f0a:	8b 50 20             	mov    edx,DWORD PTR [rax+0x20]
    2f0d:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    2f14:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    2f18:	98                   	cwde
				render_text(fb->font, str, mem, 2 * fb->width, video_mode.bpsl,
    2f19:	29 c2                	sub    edx,eax
    2f1b:	41 89 d0             	mov    r8d,edx
						video_mode.gm_bts, px_x, px_y, shf, fb->cur_x - r->x,
    2f1e:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2f25:	8b 50 1c             	mov    edx,DWORD PTR [rax+0x1c]
    2f28:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    2f2f:	0f b7 00             	movzx  eax,WORD PTR [rax]
    2f32:	98                   	cwde
				render_text(fb->font, str, mem, 2 * fb->width, video_mode.bpsl,
    2f33:	89 d7                	mov    edi,edx
    2f35:	29 c7                	sub    edi,eax
						video_mode.gm_bts, px_x, px_y, shf, fb->cur_x - r->x,
    2f37:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2f3e <framebuffer_redraw_region+0xed4>
				render_text(fb->font, str, mem, 2 * fb->width, video_mode.bpsl,
    2f3e:	4c 0f be c8          	movsx  r9,al
    2f42:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2f48 <framebuffer_redraw_region+0xede>
    2f48:	41 89 c2             	mov    r10d,eax
    2f4b:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2f52:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    2f55:	01 c0                	add    eax,eax
    2f57:	48 63 c8             	movsxd rcx,eax
    2f5a:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2f61:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    2f65:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    2f69:	48 8b 75 c8          	mov    rsi,QWORD PTR [rbp-0x38]
    2f6d:	48 83 ec 08          	sub    rsp,0x8
    2f71:	6a 00                	push   0x0
    2f73:	6a 00                	push   0x0
    2f75:	41 50                	push   r8
    2f77:	57                   	push   rdi
    2f78:	8b 7d dc             	mov    edi,DWORD PTR [rbp-0x24]
    2f7b:	57                   	push   rdi
    2f7c:	8b bd 70 ff ff ff    	mov    edi,DWORD PTR [rbp-0x90]
    2f82:	57                   	push   rdi
    2f83:	8b bd 74 ff ff ff    	mov    edi,DWORD PTR [rbp-0x8c]
    2f89:	57                   	push   rdi
    2f8a:	4d 89 d0             	mov    r8,r10
    2f8d:	48 89 c7             	mov    rdi,rax
    2f90:	e8 00 00 00 00       	call   2f95 <framebuffer_redraw_region+0xf2b>
    2f95:	48 83 c4 40          	add    rsp,0x40
    2f99:	eb 0d                	jmp    2fa8 <framebuffer_redraw_region+0xf3e>
				return; /* don't do anything if we're directly on video memory */
    2f9b:	90                   	nop
    2f9c:	eb 0a                	jmp    2fa8 <framebuffer_redraw_region+0xf3e>
				return;
    2f9e:	90                   	nop
    2f9f:	eb 07                	jmp    2fa8 <framebuffer_redraw_region+0xf3e>
					return;
    2fa1:	90                   	nop
    2fa2:	eb 04                	jmp    2fa8 <framebuffer_redraw_region+0xf3e>
					return;
    2fa4:	90                   	nop
    2fa5:	eb 01                	jmp    2fa8 <framebuffer_redraw_region+0xf3e>
												break;
    2fa7:	90                   	nop
		}
}
    2fa8:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
    2fac:	c9                   	leave
    2fad:	c3                   	ret

0000000000002fae <framebuffer_redraw_updates>:

void framebuffer_redraw_updates(struct framebuffer* fb)
{
    2fae:	55                   	push   rbp
    2faf:	48 89 e5             	mov    rbp,rsp
    2fb2:	48 83 ec 30          	sub    rsp,0x30
    2fb6:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		uint64_t tm;
		struct rct *rc, **prc;
Pos1:
		rc = fb->r_ud; prc = &fb->r_ud;
    2fba:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2fbe:	48 8b 40 40          	mov    rax,QWORD PTR [rax+0x40]
    2fc2:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
    2fc6:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2fca:	48 83 c0 40          	add    rax,0x40
    2fce:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		if (!rc)
    2fd2:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
    2fd7:	0f 84 34 01 00 00    	je     3111 <framebuffer_redraw_updates+0x163>
				return;
		if (cpu.has_tsc)
    2fdd:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2fe4 <framebuffer_redraw_updates+0x36>
    2fe4:	83 e0 10             	and    eax,0x10
    2fe7:	84 c0                	test   al,al
    2fe9:	74 06                	je     2ff1 <framebuffer_redraw_updates+0x43>
				asm volatile ("rdtsc" : "=A" (tm));
    2feb:	0f 31                	rdtsc
    2fed:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		do {
				if (rc->r_ct) {
    2ff1:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2ff5:	48 8b 80 88 02 00 00 	mov    rax,QWORD PTR [rax+0x288]
    2ffc:	48 85 c0             	test   rax,rax
    2fff:	0f 84 b9 00 00 00    	je     30be <framebuffer_redraw_updates+0x110>
						/* take element temorary out of list */
						if (__sync_bool_compare_and_swap(prc, rc, rc->next)) {
    3005:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3009:	48 8b 80 80 02 00 00 	mov    rax,QWORD PTR [rax+0x280]
    3010:	48 89 c1             	mov    rcx,rax
    3013:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3017:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    301b:	f0 48 0f b1 0a       	lock cmpxchg QWORD PTR [rdx],rcx
    3020:	0f 94 c0             	sete   al
    3023:	84 c0                	test   al,al
    3025:	74 93                	je     2fba <framebuffer_redraw_updates+0xc>
								/* success */
								for (size_t i = 0; i < rc->r_ct; i++)
    3027:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
    302f:	eb 2e                	jmp    305f <framebuffer_redraw_updates+0xb1>
										framebuffer_redraw_region(fb, rc->r + i);
    3031:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
    3035:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    3039:	48 89 d0             	mov    rax,rdx
    303c:	48 c1 e0 02          	shl    rax,0x2
    3040:	48 01 d0             	add    rax,rdx
    3043:	48 c1 e0 02          	shl    rax,0x2
    3047:	48 8d 14 01          	lea    rdx,[rcx+rax*1]
    304b:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    304f:	48 89 d6             	mov    rsi,rdx
    3052:	48 89 c7             	mov    rdi,rax
    3055:	e8 00 00 00 00       	call   305a <framebuffer_redraw_updates+0xac>
								for (size_t i = 0; i < rc->r_ct; i++)
    305a:	48 83 45 e0 01       	add    QWORD PTR [rbp-0x20],0x1
    305f:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3063:	48 8b 80 88 02 00 00 	mov    rax,QWORD PTR [rax+0x288]
    306a:	48 39 45 e0          	cmp    QWORD PTR [rbp-0x20],rax
    306e:	72 c1                	jb     3031 <framebuffer_redraw_updates+0x83>
								rc->r_ct = 0;
    3070:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3074:	48 c7 80 88 02 00 00 00 00 00 00 	mov    QWORD PTR [rax+0x288],0x0
								/* now put the buffer back at the front */
								do {
										rc->next = fb->r_ud;
    307f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3083:	48 8b 50 40          	mov    rdx,QWORD PTR [rax+0x40]
    3087:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    308b:	48 89 90 80 02 00 00 	mov    QWORD PTR [rax+0x280],rdx
								} while (!__sync_bool_compare_and_swap(&fb->r_ud, rc->next, rc));
    3092:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    3096:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    309a:	48 8b 80 80 02 00 00 	mov    rax,QWORD PTR [rax+0x280]
    30a1:	48 89 c6             	mov    rsi,rax
    30a4:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    30a8:	48 8d 48 40          	lea    rcx,[rax+0x40]
    30ac:	48 89 f0             	mov    rax,rsi
    30af:	f0 48 0f b1 11       	lock cmpxchg QWORD PTR [rcx],rdx
    30b4:	0f 94 c0             	sete   al
    30b7:	83 f0 01             	xor    eax,0x1
    30ba:	84 c0                	test   al,al
    30bc:	75 c1                	jne    307f <framebuffer_redraw_updates+0xd1>
						} else
								goto Pos1;
				}
				prc = &rc->next;
    30be:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    30c2:	48 05 80 02 00 00    	add    rax,0x280
    30c8:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		} while ((rc = rc->next));
    30cc:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    30d0:	48 8b 80 80 02 00 00 	mov    rax,QWORD PTR [rax+0x280]
    30d7:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
    30db:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
    30e0:	0f 85 0b ff ff ff    	jne    2ff1 <framebuffer_redraw_updates+0x43>
		if (cpu.has_tsc) {
    30e6:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 30ed <framebuffer_redraw_updates+0x13f>
    30ed:	83 e0 10             	and    eax,0x10
    30f0:	84 c0                	test   al,al
    30f2:	74 1e                	je     3112 <framebuffer_redraw_updates+0x164>
				asm volatile ("rdtsc" : "=A" (fb_rdt));
    30f4:	0f 31                	rdtsc
    30f6:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 30fd <framebuffer_redraw_updates+0x14f>
				fb_rdt -= tm;
    30fd:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 3104 <framebuffer_redraw_updates+0x156>
    3104:	48 2b 45 f8          	sub    rax,QWORD PTR [rbp-0x8]
    3108:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 310f <framebuffer_redraw_updates+0x161>
    310f:	eb 01                	jmp    3112 <framebuffer_redraw_updates+0x164>
				return;
    3111:	90                   	nop
		}
}
    3112:	c9                   	leave
    3113:	c3                   	ret

0000000000003114 <framebuffer_update_region>:

void framebuffer_update_region(struct framebuffer* fb, struct kio_region* r)
{
    3114:	55                   	push   rbp
    3115:	48 89 e5             	mov    rbp,rsp
    3118:	48 83 ec 60          	sub    rsp,0x60
    311c:	48 89 7d a8          	mov    QWORD PTR [rbp-0x58],rdi
    3120:	48 89 75 a0          	mov    QWORD PTR [rbp-0x60],rsi
		struct kio_region r2;
		struct rct* ptr = fb->r_ud;
    3124:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3128:	48 8b 40 40          	mov    rax,QWORD PTR [rax+0x40]
    312c:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		size_t idx;
		if (fb->text_mem == vga_mem_ptr)
    3130:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3134:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    3137:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 313e <framebuffer_update_region+0x2a>
    313e:	48 39 c2             	cmp    rdx,rax
    3141:	0f 84 b6 04 00 00    	je     35fd <framebuffer_update_region+0x4e9>
				return;

		/* for now update on every call */
		r2.x = max(0, r->x - fb->cho_x);
    3147:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    314b:	0f b7 00             	movzx  eax,WORD PTR [rax]
    314e:	0f bf c8             	movsx  ecx,ax
    3151:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3155:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
    3158:	89 c8                	mov    eax,ecx
    315a:	29 d0                	sub    eax,edx
    315c:	ba 00 00 00 00       	mov    edx,0x0
    3161:	85 c0                	test   eax,eax
    3163:	0f 48 c2             	cmovs  eax,edx
    3166:	66 89 45 b0          	mov    WORD PTR [rbp-0x50],ax
		r2.y = max(0, r->y - fb->cho_y);
    316a:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    316e:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    3172:	0f bf c8             	movsx  ecx,ax
    3175:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3179:	8b 50 30             	mov    edx,DWORD PTR [rax+0x30]
    317c:	89 c8                	mov    eax,ecx
    317e:	29 d0                	sub    eax,edx
    3180:	ba 00 00 00 00       	mov    edx,0x0
    3185:	85 c0                	test   eax,eax
    3187:	0f 48 c2             	cmovs  eax,edx
    318a:	66 89 45 b2          	mov    WORD PTR [rbp-0x4e],ax
		r2.fmt = r->fmt;
    318e:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    3192:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    3196:	88 45 bc             	mov    BYTE PTR [rbp-0x44],al
		r2.lx = min(fb->chw_x - r2.x, r->lx);
    3199:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    319d:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
    31a1:	0f bf d0             	movsx  edx,ax
    31a4:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    31a8:	8b 40 34             	mov    eax,DWORD PTR [rax+0x34]
    31ab:	0f b7 4d b0          	movzx  ecx,WORD PTR [rbp-0x50]
    31af:	0f bf c9             	movsx  ecx,cx
    31b2:	29 c8                	sub    eax,ecx
    31b4:	39 c2                	cmp    edx,eax
    31b6:	0f 4e c2             	cmovle eax,edx
    31b9:	66 89 45 b4          	mov    WORD PTR [rbp-0x4c],ax
		r2.ly = min(fb->chw_y - r2.y, r->ly);
    31bd:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    31c1:	0f b7 40 06          	movzx  eax,WORD PTR [rax+0x6]
    31c5:	0f bf d0             	movsx  edx,ax
    31c8:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    31cc:	8b 40 38             	mov    eax,DWORD PTR [rax+0x38]
    31cf:	0f b7 4d b2          	movzx  ecx,WORD PTR [rbp-0x4e]
    31d3:	0f bf c9             	movsx  ecx,cx
    31d6:	29 c8                	sub    eax,ecx
    31d8:	39 c2                	cmp    edx,eax
    31da:	0f 4e c2             	cmovle eax,edx
    31dd:	66 89 45 b6          	mov    WORD PTR [rbp-0x4a],ax
		/* check for visibility */
		if (r2.x >= fb->chw_x || r2.y >= fb->chw_y ||
    31e1:	0f b7 45 b0          	movzx  eax,WORD PTR [rbp-0x50]
    31e5:	0f bf d0             	movsx  edx,ax
    31e8:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    31ec:	8b 40 34             	mov    eax,DWORD PTR [rax+0x34]
    31ef:	39 c2                	cmp    edx,eax
    31f1:	0f 8d 09 04 00 00    	jge    3600 <framebuffer_update_region+0x4ec>
    31f7:	0f b7 45 b2          	movzx  eax,WORD PTR [rbp-0x4e]
    31fb:	0f bf d0             	movsx  edx,ax
    31fe:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3202:	8b 40 38             	mov    eax,DWORD PTR [rax+0x38]
    3205:	39 c2                	cmp    edx,eax
    3207:	0f 8d f3 03 00 00    	jge    3600 <framebuffer_update_region+0x4ec>
			r2.x + r2.lx < fb->cho_x || r2.y + r2.ly < fb->cho_y)
    320d:	0f b7 45 b0          	movzx  eax,WORD PTR [rbp-0x50]
    3211:	0f bf d0             	movsx  edx,ax
    3214:	0f b7 45 b4          	movzx  eax,WORD PTR [rbp-0x4c]
    3218:	98                   	cwde
    3219:	01 c2                	add    edx,eax
    321b:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    321f:	8b 40 2c             	mov    eax,DWORD PTR [rax+0x2c]
		if (r2.x >= fb->chw_x || r2.y >= fb->chw_y ||
    3222:	39 c2                	cmp    edx,eax
    3224:	0f 8c d6 03 00 00    	jl     3600 <framebuffer_update_region+0x4ec>
			r2.x + r2.lx < fb->cho_x || r2.y + r2.ly < fb->cho_y)
    322a:	0f b7 45 b2          	movzx  eax,WORD PTR [rbp-0x4e]
    322e:	0f bf d0             	movsx  edx,ax
    3231:	0f b7 45 b6          	movzx  eax,WORD PTR [rbp-0x4a]
    3235:	98                   	cwde
    3236:	01 c2                	add    edx,eax
    3238:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    323c:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
    323f:	39 c2                	cmp    edx,eax
    3241:	0f 8c b9 03 00 00    	jl     3600 <framebuffer_update_region+0x4ec>
				return;
		/* check for pending updates */
Pos1:
    3247:	90                   	nop
		ptr = fb->r_ud;
    3248:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    324c:	48 8b 40 40          	mov    rax,QWORD PTR [rax+0x40]
    3250:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		while (ptr) { /* TODO: overhaul this -> leads to freezes */
    3254:	e9 f4 02 00 00       	jmp    354d <framebuffer_update_region+0x439>
				size_t i;
				for (i = 0; i < ptr->r_ct; i++) {
    3259:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
    3261:	e9 c8 01 00 00       	jmp    342e <framebuffer_update_region+0x31a>
						/* check for extending horizontally */
						if (ptr->r[i].y == r2.y && ptr->r[i].ly == r2.ly) {
    3266:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    326a:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    326e:	48 89 d0             	mov    rax,rdx
    3271:	48 c1 e0 02          	shl    rax,0x2
    3275:	48 01 d0             	add    rax,rdx
    3278:	48 c1 e0 02          	shl    rax,0x2
    327c:	48 01 c8             	add    rax,rcx
    327f:	48 83 c0 02          	add    rax,0x2
    3283:	0f b7 10             	movzx  edx,WORD PTR [rax]
    3286:	0f b7 45 b2          	movzx  eax,WORD PTR [rbp-0x4e]
    328a:	66 39 c2             	cmp    dx,ax
    328d:	0f 85 f2 00 00 00    	jne    3385 <framebuffer_update_region+0x271>
    3293:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    3297:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    329b:	48 89 d0             	mov    rax,rdx
    329e:	48 c1 e0 02          	shl    rax,0x2
    32a2:	48 01 d0             	add    rax,rdx
    32a5:	48 c1 e0 02          	shl    rax,0x2
    32a9:	48 01 c8             	add    rax,rcx
    32ac:	48 83 c0 06          	add    rax,0x6
    32b0:	0f b7 10             	movzx  edx,WORD PTR [rax]
    32b3:	0f b7 45 b6          	movzx  eax,WORD PTR [rbp-0x4a]
    32b7:	66 39 c2             	cmp    dx,ax
    32ba:	0f 85 c5 00 00 00    	jne    3385 <framebuffer_update_region+0x271>
								short new_lx, old_lx = ptr->r[i].lx;
    32c0:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    32c4:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    32c8:	48 89 d0             	mov    rax,rdx
    32cb:	48 c1 e0 02          	shl    rax,0x2
    32cf:	48 01 d0             	add    rax,rdx
    32d2:	48 c1 e0 02          	shl    rax,0x2
    32d6:	48 01 c8             	add    rax,rcx
    32d9:	48 83 c0 04          	add    rax,0x4
    32dd:	0f b7 00             	movzx  eax,WORD PTR [rax]
    32e0:	66 89 45 de          	mov    WORD PTR [rbp-0x22],ax
								if (ptr->r[i].x + ptr->r[i].lx == r2.x) {
    32e4:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    32e8:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    32ec:	48 89 d0             	mov    rax,rdx
    32ef:	48 c1 e0 02          	shl    rax,0x2
    32f3:	48 01 d0             	add    rax,rdx
    32f6:	48 c1 e0 02          	shl    rax,0x2
    32fa:	48 01 c8             	add    rax,rcx
    32fd:	0f b7 00             	movzx  eax,WORD PTR [rax]
    3300:	0f bf c8             	movsx  ecx,ax
    3303:	48 8b 75 f8          	mov    rsi,QWORD PTR [rbp-0x8]
    3307:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    330b:	48 89 d0             	mov    rax,rdx
    330e:	48 c1 e0 02          	shl    rax,0x2
    3312:	48 01 d0             	add    rax,rdx
    3315:	48 c1 e0 02          	shl    rax,0x2
    3319:	48 01 f0             	add    rax,rsi
    331c:	48 83 c0 04          	add    rax,0x4
    3320:	0f b7 00             	movzx  eax,WORD PTR [rax]
    3323:	98                   	cwde
    3324:	8d 14 01             	lea    edx,[rcx+rax*1]
    3327:	0f b7 45 b0          	movzx  eax,WORD PTR [rbp-0x50]
    332b:	98                   	cwde
    332c:	39 c2                	cmp    edx,eax
    332e:	75 55                	jne    3385 <framebuffer_update_region+0x271>
										new_lx = old_lx + r2.lx;
    3330:	0f b7 45 b4          	movzx  eax,WORD PTR [rbp-0x4c]
    3334:	89 c2                	mov    edx,eax
    3336:	0f b7 45 de          	movzx  eax,WORD PTR [rbp-0x22]
    333a:	01 d0                	add    eax,edx
    333c:	66 89 45 dc          	mov    WORD PTR [rbp-0x24],ax
										/* try to combine */
										if (!__sync_bool_compare_and_swap(&ptr->r[i].lx, old_lx, new_lx))
    3340:	0f b7 45 dc          	movzx  eax,WORD PTR [rbp-0x24]
    3344:	0f b7 f0             	movzx  esi,ax
    3347:	0f b7 45 de          	movzx  eax,WORD PTR [rbp-0x22]
    334b:	0f b7 c8             	movzx  ecx,ax
    334e:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    3352:	48 89 d0             	mov    rax,rdx
    3355:	48 c1 e0 02          	shl    rax,0x2
    3359:	48 01 d0             	add    rax,rdx
    335c:	48 c1 e0 02          	shl    rax,0x2
    3360:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    3364:	48 01 d0             	add    rax,rdx
    3367:	48 8d 50 04          	lea    rdx,[rax+0x4]
    336b:	89 c8                	mov    eax,ecx
    336d:	66 f0 0f b1 32       	lock cmpxchg WORD PTR [rdx],si
    3372:	0f 94 c0             	sete   al
    3375:	83 f0 01             	xor    eax,0x1
    3378:	84 c0                	test   al,al
    337a:	0f 84 83 02 00 00    	je     3603 <framebuffer_update_region+0x4ef>
												goto Pos1;
    3380:	e9 c3 fe ff ff       	jmp    3248 <framebuffer_update_region+0x134>
//										}
//										return;
//								}
//						}
						/* also check for duplicates */
						if (ptr->r[i].x == r2.x && ptr->r[i].y == r2.y
    3385:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    3389:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    338d:	48 89 d0             	mov    rax,rdx
    3390:	48 c1 e0 02          	shl    rax,0x2
    3394:	48 01 d0             	add    rax,rdx
    3397:	48 c1 e0 02          	shl    rax,0x2
    339b:	48 01 c8             	add    rax,rcx
    339e:	0f b7 10             	movzx  edx,WORD PTR [rax]
    33a1:	0f b7 45 b0          	movzx  eax,WORD PTR [rbp-0x50]
    33a5:	66 39 c2             	cmp    dx,ax
    33a8:	75 7f                	jne    3429 <framebuffer_update_region+0x315>
    33aa:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    33ae:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    33b2:	48 89 d0             	mov    rax,rdx
    33b5:	48 c1 e0 02          	shl    rax,0x2
    33b9:	48 01 d0             	add    rax,rdx
    33bc:	48 c1 e0 02          	shl    rax,0x2
    33c0:	48 01 c8             	add    rax,rcx
    33c3:	48 83 c0 02          	add    rax,0x2
    33c7:	0f b7 10             	movzx  edx,WORD PTR [rax]
    33ca:	0f b7 45 b2          	movzx  eax,WORD PTR [rbp-0x4e]
    33ce:	66 39 c2             	cmp    dx,ax
    33d1:	75 56                	jne    3429 <framebuffer_update_region+0x315>
							&& ptr->r[i].lx == r2.lx && ptr->r[i].ly == r2.ly)
    33d3:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    33d7:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    33db:	48 89 d0             	mov    rax,rdx
    33de:	48 c1 e0 02          	shl    rax,0x2
    33e2:	48 01 d0             	add    rax,rdx
    33e5:	48 c1 e0 02          	shl    rax,0x2
    33e9:	48 01 c8             	add    rax,rcx
    33ec:	48 83 c0 04          	add    rax,0x4
    33f0:	0f b7 10             	movzx  edx,WORD PTR [rax]
    33f3:	0f b7 45 b4          	movzx  eax,WORD PTR [rbp-0x4c]
    33f7:	66 39 c2             	cmp    dx,ax
    33fa:	75 2d                	jne    3429 <framebuffer_update_region+0x315>
    33fc:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    3400:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    3404:	48 89 d0             	mov    rax,rdx
    3407:	48 c1 e0 02          	shl    rax,0x2
    340b:	48 01 d0             	add    rax,rdx
    340e:	48 c1 e0 02          	shl    rax,0x2
    3412:	48 01 c8             	add    rax,rcx
    3415:	48 83 c0 06          	add    rax,0x6
    3419:	0f b7 10             	movzx  edx,WORD PTR [rax]
    341c:	0f b7 45 b6          	movzx  eax,WORD PTR [rbp-0x4a]
    3420:	66 39 c2             	cmp    dx,ax
    3423:	0f 84 dd 01 00 00    	je     3606 <framebuffer_update_region+0x4f2>
				for (i = 0; i < ptr->r_ct; i++) {
    3429:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
    342e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3432:	48 8b 80 88 02 00 00 	mov    rax,QWORD PTR [rax+0x288]
    3439:	48 39 45 f0          	cmp    QWORD PTR [rbp-0x10],rax
    343d:	0f 82 23 fe ff ff    	jb     3266 <framebuffer_update_region+0x152>
								return;
				}
				/* add inbetween */
				if ((idx = __sync_fetch_and_add(&ptr->r_ct, 1)) < 32) {
    3443:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3447:	48 05 88 02 00 00    	add    rax,0x288
    344d:	ba 01 00 00 00       	mov    edx,0x1
    3452:	f0 48 0f c1 10       	lock xadd QWORD PTR [rax],rdx
    3457:	48 89 55 e8          	mov    QWORD PTR [rbp-0x18],rdx
    345b:	48 83 7d e8 1f       	cmp    QWORD PTR [rbp-0x18],0x1f
    3460:	77 33                	ja     3495 <framebuffer_update_region+0x381>
						ptr->r[idx] = r2;
    3462:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    3466:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    346a:	48 89 d0             	mov    rax,rdx
    346d:	48 c1 e0 02          	shl    rax,0x2
    3471:	48 01 d0             	add    rax,rdx
    3474:	48 c1 e0 02          	shl    rax,0x2
    3478:	48 01 c1             	add    rcx,rax
    347b:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    347f:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
    3483:	48 89 01             	mov    QWORD PTR [rcx],rax
    3486:	48 89 51 08          	mov    QWORD PTR [rcx+0x8],rdx
    348a:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    348d:	89 41 10             	mov    DWORD PTR [rcx+0x10],eax
						break;
    3490:	e9 c6 00 00 00       	jmp    355b <framebuffer_update_region+0x447>
				} else
						__sync_fetch_and_sub(&ptr->r_ct, 1);
    3495:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3499:	48 05 88 02 00 00    	add    rax,0x288
    349f:	f0 48 83 28 01       	lock sub QWORD PTR [rax],0x1
				/* we need a new container */
				if (!ptr->next) {
    34a4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    34a8:	48 8b 80 80 02 00 00 	mov    rax,QWORD PTR [rax+0x280]
    34af:	48 85 c0             	test   rax,rax
    34b2:	0f 85 86 00 00 00    	jne    353e <framebuffer_update_region+0x42a>
						while (fb_no_malloc);
    34b8:	90                   	nop
    34b9:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 34bf <framebuffer_update_region+0x3ab>
    34bf:	85 c0                	test   eax,eax
    34c1:	75 f6                	jne    34b9 <framebuffer_update_region+0x3a5>
						struct rct* rn = kmalloc(sizeof(struct rct));
    34c3:	bf 90 02 00 00       	mov    edi,0x290
    34c8:	e8 00 00 00 00       	call   34cd <framebuffer_update_region+0x3b9>
    34cd:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
						rn->r_ct = 1;
    34d1:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    34d5:	48 c7 80 88 02 00 00 01 00 00 00 	mov    QWORD PTR [rax+0x288],0x1
						rn->r[0] = r2;
    34e0:	48 8b 4d e0          	mov    rcx,QWORD PTR [rbp-0x20]
    34e4:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    34e8:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
    34ec:	48 89 01             	mov    QWORD PTR [rcx],rax
    34ef:	48 89 51 08          	mov    QWORD PTR [rcx+0x8],rdx
    34f3:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    34f6:	89 41 10             	mov    DWORD PTR [rcx+0x10],eax
						rn->next = NULL;
    34f9:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    34fd:	48 c7 80 80 02 00 00 00 00 00 00 	mov    QWORD PTR [rax+0x280],0x0
						if (__sync_bool_compare_and_swap(&ptr->next, NULL, rn))
    3508:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    350c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3510:	48 8d 88 80 02 00 00 	lea    rcx,[rax+0x280]
    3517:	b8 00 00 00 00       	mov    eax,0x0
    351c:	f0 48 0f b1 11       	lock cmpxchg QWORD PTR [rcx],rdx
    3521:	0f 94 c0             	sete   al
    3524:	84 c0                	test   al,al
    3526:	75 32                	jne    355a <framebuffer_update_region+0x446>
								break;
						else if (!fb_no_malloc) { /* someone was faster */
    3528:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 352e <framebuffer_update_region+0x41a>
    352e:	85 c0                	test   eax,eax
    3530:	75 0c                	jne    353e <framebuffer_update_region+0x42a>
								kfree(rn);
    3532:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3536:	48 89 c7             	mov    rdi,rax
    3539:	e8 00 00 00 00       	call   353e <framebuffer_update_region+0x42a>
								//goto Pos1; ptr=next
						}
				}
				ptr = ptr->next;
    353e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3542:	48 8b 80 80 02 00 00 	mov    rax,QWORD PTR [rax+0x280]
    3549:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		while (ptr) { /* TODO: overhaul this -> leads to freezes */
    354d:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    3552:	0f 85 01 fd ff ff    	jne    3259 <framebuffer_update_region+0x145>
    3558:	eb 01                	jmp    355b <framebuffer_update_region+0x447>
								break;
    355a:	90                   	nop
		}
		/* else extend the list */
		if (!fb->r_ud) 
    355b:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    355f:	48 8b 40 40          	mov    rax,QWORD PTR [rax+0x40]
    3563:	48 85 c0             	test   rax,rax
    3566:	0f 85 9b 00 00 00    	jne    3607 <framebuffer_update_region+0x4f3>
				if (fb_no_malloc) {
    356c:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3572 <framebuffer_update_region+0x45e>
    3572:	85 c0                	test   eax,eax
    3574:	74 11                	je     3587 <framebuffer_update_region+0x473>
					fb->r_ud = &rc_initial;
    3576:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    357a:	48 c7 40 40 00 00 00 00 	mov    QWORD PTR [rax+0x40],0x0
    3582:	e9 80 00 00 00       	jmp    3607 <framebuffer_update_region+0x4f3>
				} else {
						struct rct* rn = kmalloc(sizeof(struct rct));
    3587:	bf 90 02 00 00       	mov    edi,0x290
    358c:	e8 00 00 00 00       	call   3591 <framebuffer_update_region+0x47d>
    3591:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
						rn->r_ct = 1;
    3595:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    3599:	48 c7 80 88 02 00 00 01 00 00 00 	mov    QWORD PTR [rax+0x288],0x1
						rn->r[0] = r2;
    35a4:	48 8b 4d d0          	mov    rcx,QWORD PTR [rbp-0x30]
    35a8:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    35ac:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
    35b0:	48 89 01             	mov    QWORD PTR [rcx],rax
    35b3:	48 89 51 08          	mov    QWORD PTR [rcx+0x8],rdx
    35b7:	8b 45 c0             	mov    eax,DWORD PTR [rbp-0x40]
    35ba:	89 41 10             	mov    DWORD PTR [rcx+0x10],eax
						rn->next = NULL;
    35bd:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    35c1:	48 c7 80 80 02 00 00 00 00 00 00 	mov    QWORD PTR [rax+0x280],0x0
						if (!__sync_bool_compare_and_swap(&fb->r_ud, NULL, rn)) {
    35cc:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    35d0:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    35d4:	48 8d 48 40          	lea    rcx,[rax+0x40]
    35d8:	b8 00 00 00 00       	mov    eax,0x0
    35dd:	f0 48 0f b1 11       	lock cmpxchg QWORD PTR [rcx],rdx
    35e2:	0f 94 c0             	sete   al
    35e5:	83 f0 01             	xor    eax,0x1
    35e8:	84 c0                	test   al,al
    35ea:	74 1b                	je     3607 <framebuffer_update_region+0x4f3>
								/* someone was faster */
								kfree(rn);
    35ec:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    35f0:	48 89 c7             	mov    rdi,rax
    35f3:	e8 00 00 00 00       	call   35f8 <framebuffer_update_region+0x4e4>
								goto Pos1;
    35f8:	e9 4b fc ff ff       	jmp    3248 <framebuffer_update_region+0x134>
				return;
    35fd:	90                   	nop
    35fe:	eb 07                	jmp    3607 <framebuffer_update_region+0x4f3>
				return;
    3600:	90                   	nop
    3601:	eb 04                	jmp    3607 <framebuffer_update_region+0x4f3>
										return;
    3603:	90                   	nop
    3604:	eb 01                	jmp    3607 <framebuffer_update_region+0x4f3>
								return;
    3606:	90                   	nop
						}	
		}
}
    3607:	c9                   	leave
    3608:	c3                   	ret

0000000000003609 <framebuffer_scroll>:

/* we have to redraw everything */
void framebuffer_scroll(struct framebuffer* fb, ssize_t nly, ssize_t nlx)
{
    3609:	55                   	push   rbp
    360a:	48 89 e5             	mov    rbp,rsp
    360d:	48 83 ec 10          	sub    rsp,0x10
    3611:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
    3615:	89 75 f4             	mov    DWORD PTR [rbp-0xc],esi
    3618:	89 55 f0             	mov    DWORD PTR [rbp-0x10],edx
		if (nly != 1 || nlx)
    361b:	83 7d f4 01          	cmp    DWORD PTR [rbp-0xc],0x1
    361f:	75 08                	jne    3629 <framebuffer_scroll+0x20>
    3621:	83 7d f0 00          	cmp    DWORD PTR [rbp-0x10],0x0
    3625:	75 02                	jne    3629 <framebuffer_scroll+0x20>
    3627:	eb 02                	jmp    362b <framebuffer_scroll+0x22>
				while (1); /* only lines for now */
    3629:	eb fe                	jmp    3629 <framebuffer_scroll+0x20>
		memmove(fb->text_mem, fb->text_mem + fb->width * 2,
					   	2 * fb->width * (fb->height - 1));
    362b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    362f:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    3632:	8d 14 00             	lea    edx,[rax+rax*1]
    3635:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3639:	8b 40 0c             	mov    eax,DWORD PTR [rax+0xc]
    363c:	83 e8 01             	sub    eax,0x1
    363f:	0f af c2             	imul   eax,edx
		memmove(fb->text_mem, fb->text_mem + fb->width * 2,
    3642:	48 63 d0             	movsxd rdx,eax
    3645:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3649:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    364c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3650:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    3653:	01 c0                	add    eax,eax
    3655:	48 98                	cdqe
    3657:	48 01 c1             	add    rcx,rax
    365a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    365e:	48 8b 00             	mov    rax,QWORD PTR [rax]
    3661:	48 89 ce             	mov    rsi,rcx
    3664:	48 89 c7             	mov    rdi,rax
    3667:	e8 00 00 00 00       	call   366c <framebuffer_scroll+0x63>
		//framebuffer_redraw(fb);
}
    366c:	90                   	nop
    366d:	c9                   	leave
    366e:	c3                   	ret

000000000000366f <framebuffer_scroll_region>:

void framebuffer_scroll_region(struct framebuffer* fb,
				struct kio_region* r, ssize_t nx, ssize_t ny)
{
    366f:	55                   	push   rbp
    3670:	48 89 e5             	mov    rbp,rsp
    3673:	48 83 ec 30          	sub    rsp,0x30
    3677:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    367b:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
    367f:	89 55 dc             	mov    DWORD PTR [rbp-0x24],edx
    3682:	89 4d d8             	mov    DWORD PTR [rbp-0x28],ecx
		ssize_t i; char* src = NULL;
    3685:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		if (ny != 1 || nx)
    368d:	83 7d d8 01          	cmp    DWORD PTR [rbp-0x28],0x1
    3691:	75 08                	jne    369b <framebuffer_scroll_region+0x2c>
    3693:	83 7d dc 00          	cmp    DWORD PTR [rbp-0x24],0x0
    3697:	75 02                	jne    369b <framebuffer_scroll_region+0x2c>
    3699:	eb 02                	jmp    369d <framebuffer_scroll_region+0x2e>
				while (1); /* only lines for now */
    369b:	eb fe                	jmp    369b <framebuffer_scroll_region+0x2c>
		/* sanity check */
		if (r->x + r->lx > fb->width)
    369d:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    36a1:	0f b7 00             	movzx  eax,WORD PTR [rax]
    36a4:	0f bf d0             	movsx  edx,ax
    36a7:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    36ab:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
    36af:	98                   	cwde
    36b0:	01 c2                	add    edx,eax
    36b2:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    36b6:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    36b9:	39 c2                	cmp    edx,eax
    36bb:	0f 8f 34 01 00 00    	jg     37f5 <framebuffer_scroll_region+0x186>
				return;
		if (r->y + r->ly > fb->height)
    36c1:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    36c5:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    36c9:	0f bf d0             	movsx  edx,ax
    36cc:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    36d0:	0f b7 40 06          	movzx  eax,WORD PTR [rax+0x6]
    36d4:	98                   	cwde
    36d5:	01 c2                	add    edx,eax
    36d7:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    36db:	8b 40 0c             	mov    eax,DWORD PTR [rax+0xc]
    36de:	39 c2                	cmp    edx,eax
    36e0:	0f 8f 12 01 00 00    	jg     37f8 <framebuffer_scroll_region+0x189>
				return;
		/* by moving possibly strided memory */
		for (i = r->y; i < r->y + r->ly - 1; i++)
    36e6:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    36ea:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    36ee:	98                   	cwde
    36ef:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
    36f2:	eb 7c                	jmp    3770 <framebuffer_scroll_region+0x101>
				memcpy(fb->text_mem + i * fb->width * 2 + r->x * 2,
					   (src = fb->text_mem + (i + 1) * fb->width * 2 + r->x * 2),
					   r->lx * 2);
    36f4:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    36f8:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
    36fc:	98                   	cwde
    36fd:	01 c0                	add    eax,eax
				memcpy(fb->text_mem + i * fb->width * 2 + r->x * 2,
    36ff:	48 63 d0             	movsxd rdx,eax
					   (src = fb->text_mem + (i + 1) * fb->width * 2 + r->x * 2),
    3702:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    3706:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    3709:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    370c:	8d 70 01             	lea    esi,[rax+0x1]
    370f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    3713:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    3716:	0f af c6             	imul   eax,esi
    3719:	01 c0                	add    eax,eax
    371b:	48 63 f0             	movsxd rsi,eax
    371e:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3722:	0f b7 00             	movzx  eax,WORD PTR [rax]
    3725:	98                   	cwde
    3726:	01 c0                	add    eax,eax
    3728:	48 98                	cdqe
    372a:	48 01 f0             	add    rax,rsi
    372d:	48 01 c8             	add    rax,rcx
    3730:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				memcpy(fb->text_mem + i * fb->width * 2 + r->x * 2,
    3734:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    3738:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    373b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    373f:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    3742:	0f af 45 fc          	imul   eax,DWORD PTR [rbp-0x4]
    3746:	01 c0                	add    eax,eax
    3748:	48 63 f0             	movsxd rsi,eax
    374b:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    374f:	0f b7 00             	movzx  eax,WORD PTR [rax]
    3752:	98                   	cwde
    3753:	01 c0                	add    eax,eax
    3755:	48 98                	cdqe
    3757:	48 01 f0             	add    rax,rsi
    375a:	48 01 c1             	add    rcx,rax
    375d:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3761:	48 89 c6             	mov    rsi,rax
    3764:	48 89 cf             	mov    rdi,rcx
    3767:	e8 94 c8 ff ff       	call   0 <memcpy>
		for (i = r->y; i < r->y + r->ly - 1; i++)
    376c:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
    3770:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3774:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    3778:	0f bf d0             	movsx  edx,ax
    377b:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    377f:	0f b7 40 06          	movzx  eax,WORD PTR [rax+0x6]
    3783:	98                   	cwde
    3784:	01 d0                	add    eax,edx
    3786:	83 e8 01             	sub    eax,0x1
    3789:	39 45 fc             	cmp    DWORD PTR [rbp-0x4],eax
    378c:	0f 8c 62 ff ff ff    	jl     36f4 <framebuffer_scroll_region+0x85>
		if (!src)
    3792:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
    3797:	74 62                	je     37fb <framebuffer_scroll_region+0x18c>
				return;
		for (i = 0; i < 2 * r->lx; i += 2) {
    3799:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
    37a0:	eb 2e                	jmp    37d0 <framebuffer_scroll_region+0x161>
				src[i] = '\0';
    37a2:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    37a5:	48 63 d0             	movsxd rdx,eax
    37a8:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    37ac:	48 01 d0             	add    rax,rdx
    37af:	c6 00 00             	mov    BYTE PTR [rax],0x0
				src[i + 1] = r->fmt;
    37b2:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    37b5:	48 98                	cdqe
    37b7:	48 8d 50 01          	lea    rdx,[rax+0x1]
    37bb:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    37bf:	48 01 c2             	add    rdx,rax
    37c2:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    37c6:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    37ca:	88 02                	mov    BYTE PTR [rdx],al
		for (i = 0; i < 2 * r->lx; i += 2) {
    37cc:	83 45 fc 02          	add    DWORD PTR [rbp-0x4],0x2
    37d0:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    37d4:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
    37d8:	98                   	cwde
    37d9:	01 c0                	add    eax,eax
    37db:	39 45 fc             	cmp    DWORD PTR [rbp-0x4],eax
    37de:	7c c2                	jl     37a2 <framebuffer_scroll_region+0x133>
		} /* TODO other scrolls */
		/*bzero(fb->text_mem + i * fb->width * 2 + r->x * 2, r->lx * 2);*/
		framebuffer_update_region(fb, r);
    37e0:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    37e4:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    37e8:	48 89 d6             	mov    rsi,rdx
    37eb:	48 89 c7             	mov    rdi,rax
    37ee:	e8 00 00 00 00       	call   37f3 <framebuffer_scroll_region+0x184>
    37f3:	eb 07                	jmp    37fc <framebuffer_scroll_region+0x18d>
				return;
    37f5:	90                   	nop
    37f6:	eb 04                	jmp    37fc <framebuffer_scroll_region+0x18d>
				return;
    37f8:	90                   	nop
    37f9:	eb 01                	jmp    37fc <framebuffer_scroll_region+0x18d>
				return;
    37fb:	90                   	nop
}
    37fc:	c9                   	leave
    37fd:	c3                   	ret

00000000000037fe <framebuffer_clear_region>:

void framebuffer_clear_region(struct framebuffer* fb, struct kio_region* r)
{
    37fe:	55                   	push   rbp
    37ff:	48 89 e5             	mov    rbp,rsp
    3802:	48 83 ec 20          	sub    rsp,0x20
    3806:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    380a:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
		char* p;
		if (r->x + r->lx > fb->width)
    380e:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3812:	0f b7 00             	movzx  eax,WORD PTR [rax]
    3815:	0f bf d0             	movsx  edx,ax
    3818:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    381c:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
    3820:	98                   	cwde
    3821:	01 c2                	add    edx,eax
    3823:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    3827:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    382a:	39 c2                	cmp    edx,eax
    382c:	0f 8f f8 00 00 00    	jg     392a <framebuffer_clear_region+0x12c>
				return;
		if (r->y + r->ly > fb->height)
    3832:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3836:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    383a:	0f bf d0             	movsx  edx,ax
    383d:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3841:	0f b7 40 06          	movzx  eax,WORD PTR [rax+0x6]
    3845:	98                   	cwde
    3846:	01 c2                	add    edx,eax
    3848:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    384c:	8b 40 0c             	mov    eax,DWORD PTR [rax+0xc]
    384f:	39 c2                	cmp    edx,eax
    3851:	0f 8f d6 00 00 00    	jg     392d <framebuffer_clear_region+0x12f>
				return;
		p = (char*)fb->text_mem + 2 * r->y * fb->width + 2 * r->x;
    3857:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    385b:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    385e:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3862:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    3866:	98                   	cwde
    3867:	8d 0c 00             	lea    ecx,[rax+rax*1]
    386a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    386e:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    3871:	0f af c1             	imul   eax,ecx
    3874:	48 63 c8             	movsxd rcx,eax
    3877:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    387b:	0f b7 00             	movzx  eax,WORD PTR [rax]
    387e:	98                   	cwde
    387f:	01 c0                	add    eax,eax
    3881:	48 98                	cdqe
    3883:	48 01 c8             	add    rax,rcx
    3886:	48 01 d0             	add    rax,rdx
    3889:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		for (ssize_t l = 0; l < r->ly; l++)
    388d:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
    3894:	eb 71                	jmp    3907 <framebuffer_clear_region+0x109>
				for (ssize_t c = 0; c < r->lx; c++) {
    3896:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0
    389d:	eb 56                	jmp    38f5 <framebuffer_clear_region+0xf7>
						p[l * 2 * fb->width + 2 * c] = '\0';
    389f:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    38a2:	8d 14 00             	lea    edx,[rax+rax*1]
    38a5:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    38a9:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    38ac:	0f af c2             	imul   eax,edx
    38af:	8b 55 f8             	mov    edx,DWORD PTR [rbp-0x8]
    38b2:	01 d2                	add    edx,edx
    38b4:	01 d0                	add    eax,edx
    38b6:	48 63 d0             	movsxd rdx,eax
    38b9:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    38bd:	48 01 d0             	add    rax,rdx
    38c0:	c6 00 00             	mov    BYTE PTR [rax],0x0
						p[l * 2 * fb->width + 2 * c + 1] = r->fmt;
    38c3:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    38c6:	8d 14 00             	lea    edx,[rax+rax*1]
    38c9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    38cd:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    38d0:	0f af c2             	imul   eax,edx
    38d3:	8b 55 f8             	mov    edx,DWORD PTR [rbp-0x8]
    38d6:	01 d2                	add    edx,edx
    38d8:	01 d0                	add    eax,edx
    38da:	48 98                	cdqe
    38dc:	48 8d 50 01          	lea    rdx,[rax+0x1]
    38e0:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    38e4:	48 01 c2             	add    rdx,rax
    38e7:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    38eb:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    38ef:	88 02                	mov    BYTE PTR [rdx],al
				for (ssize_t c = 0; c < r->lx; c++) {
    38f1:	83 45 f8 01          	add    DWORD PTR [rbp-0x8],0x1
    38f5:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    38f9:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
    38fd:	98                   	cwde
    38fe:	39 45 f8             	cmp    DWORD PTR [rbp-0x8],eax
    3901:	7c 9c                	jl     389f <framebuffer_clear_region+0xa1>
		for (ssize_t l = 0; l < r->ly; l++)
    3903:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
    3907:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    390b:	0f b7 40 06          	movzx  eax,WORD PTR [rax+0x6]
    390f:	98                   	cwde
    3910:	39 45 fc             	cmp    DWORD PTR [rbp-0x4],eax
    3913:	7c 81                	jl     3896 <framebuffer_clear_region+0x98>
				}
		framebuffer_update_region(fb, r);
    3915:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    3919:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    391d:	48 89 d6             	mov    rsi,rdx
    3920:	48 89 c7             	mov    rdi,rax
    3923:	e8 00 00 00 00       	call   3928 <framebuffer_clear_region+0x12a>
    3928:	eb 04                	jmp    392e <framebuffer_clear_region+0x130>
				return;
    392a:	90                   	nop
    392b:	eb 01                	jmp    392e <framebuffer_clear_region+0x130>
				return;
    392d:	90                   	nop
}
    392e:	c9                   	leave
    392f:	c3                   	ret

0000000000003930 <framebuffer_set_cursor>:

/* has to flush the previous character and the new one and also pending updates */
void framebuffer_set_cursor(struct framebuffer* fb, ssize_t x, ssize_t y)
{
    3930:	55                   	push   rbp
    3931:	48 89 e5             	mov    rbp,rsp
    3934:	48 83 ec 30          	sub    rsp,0x30
    3938:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
    393c:	89 75 d4             	mov    DWORD PTR [rbp-0x2c],esi
    393f:	89 55 d0             	mov    DWORD PTR [rbp-0x30],edx
		struct kio_region r;
		if (fb->cur_x > 0 && fb->cur_y > 0
    3942:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3946:	8b 40 1c             	mov    eax,DWORD PTR [rax+0x1c]
    3949:	85 c0                	test   eax,eax
    394b:	0f 8e 94 00 00 00    	jle    39e5 <framebuffer_set_cursor+0xb5>
    3951:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3955:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    3958:	85 c0                	test   eax,eax
    395a:	0f 8e 85 00 00 00    	jle    39e5 <framebuffer_set_cursor+0xb5>
			&& fb->cur_x < fb->chw_x
    3960:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3964:	8b 50 1c             	mov    edx,DWORD PTR [rax+0x1c]
    3967:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    396b:	8b 40 34             	mov    eax,DWORD PTR [rax+0x34]
    396e:	39 c2                	cmp    edx,eax
    3970:	7d 73                	jge    39e5 <framebuffer_set_cursor+0xb5>
			&& fb->cur_y < fb->chw_y) {
    3972:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3976:	8b 50 20             	mov    edx,DWORD PTR [rax+0x20]
    3979:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    397d:	8b 40 38             	mov    eax,DWORD PTR [rax+0x38]
    3980:	39 c2                	cmp    edx,eax
    3982:	7d 61                	jge    39e5 <framebuffer_set_cursor+0xb5>
				r.x = fb->cur_x + fb->cho_y;
    3984:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3988:	8b 40 1c             	mov    eax,DWORD PTR [rax+0x1c]
    398b:	89 c2                	mov    edx,eax
    398d:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3991:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
    3994:	01 d0                	add    eax,edx
    3996:	66 89 45 e0          	mov    WORD PTR [rbp-0x20],ax
				r.lx = 1;
    399a:	66 c7 45 e4 01 00    	mov    WORD PTR [rbp-0x1c],0x1
				r.y = fb->cur_y + fb->cho_y;
    39a0:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    39a4:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    39a7:	89 c2                	mov    edx,eax
    39a9:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    39ad:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
    39b0:	01 d0                	add    eax,edx
    39b2:	66 89 45 e2          	mov    WORD PTR [rbp-0x1e],ax
				r.ly = 1;
    39b6:	66 c7 45 e6 01 00    	mov    WORD PTR [rbp-0x1a],0x1
				fb->cur_x = x;
    39bc:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    39c0:	8b 55 d4             	mov    edx,DWORD PTR [rbp-0x2c]
    39c3:	89 50 1c             	mov    DWORD PTR [rax+0x1c],edx
				fb->cur_y = y;
    39c6:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    39ca:	8b 55 d0             	mov    edx,DWORD PTR [rbp-0x30]
    39cd:	89 50 20             	mov    DWORD PTR [rax+0x20],edx
				framebuffer_update_region(fb, &r);
    39d0:	48 8d 55 e0          	lea    rdx,[rbp-0x20]
    39d4:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    39d8:	48 89 d6             	mov    rsi,rdx
    39db:	48 89 c7             	mov    rdi,rax
    39de:	e8 00 00 00 00       	call   39e3 <framebuffer_set_cursor+0xb3>
    39e3:	eb 14                	jmp    39f9 <framebuffer_set_cursor+0xc9>
		} else {
				fb->cur_x = x;
    39e5:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    39e9:	8b 55 d4             	mov    edx,DWORD PTR [rbp-0x2c]
    39ec:	89 50 1c             	mov    DWORD PTR [rax+0x1c],edx
				fb->cur_y = y;
    39ef:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    39f3:	8b 55 d0             	mov    edx,DWORD PTR [rbp-0x30]
    39f6:	89 50 20             	mov    DWORD PTR [rax+0x20],edx
		}
		r.x = fb->cur_x + fb->cho_x;
    39f9:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    39fd:	8b 40 1c             	mov    eax,DWORD PTR [rax+0x1c]
    3a00:	89 c2                	mov    edx,eax
    3a02:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3a06:	8b 40 2c             	mov    eax,DWORD PTR [rax+0x2c]
    3a09:	01 d0                	add    eax,edx
    3a0b:	66 89 45 e0          	mov    WORD PTR [rbp-0x20],ax
		r.y = fb->cur_y + fb->cho_y;
    3a0f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3a13:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    3a16:	89 c2                	mov    edx,eax
    3a18:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3a1c:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
    3a1f:	01 d0                	add    eax,edx
    3a21:	66 89 45 e2          	mov    WORD PTR [rbp-0x1e],ax
		r.lx = r.ly = 1;
    3a25:	66 c7 45 e6 01 00    	mov    WORD PTR [rbp-0x1a],0x1
    3a2b:	0f b7 45 e6          	movzx  eax,WORD PTR [rbp-0x1a]
    3a2f:	66 89 45 e4          	mov    WORD PTR [rbp-0x1c],ax
		framebuffer_update_region(fb, &r);
    3a33:	48 8d 55 e0          	lea    rdx,[rbp-0x20]
    3a37:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3a3b:	48 89 d6             	mov    rsi,rdx
    3a3e:	48 89 c7             	mov    rdi,rax
    3a41:	e8 00 00 00 00       	call   3a46 <framebuffer_set_cursor+0x116>
		//framebuffer_redraw(fb);
}
    3a46:	90                   	nop
    3a47:	c9                   	leave
    3a48:	c3                   	ret

0000000000003a49 <framebuffer_resize>:

/* works on character cells */
void framebuffer_resize(struct framebuffer* fb, ssize_t new_lx, ssize_t new_ly)
{
    3a49:	55                   	push   rbp
    3a4a:	48 89 e5             	mov    rbp,rsp
    3a4d:	48 83 ec 10          	sub    rsp,0x10
    3a51:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
    3a55:	89 75 f4             	mov    DWORD PTR [rbp-0xc],esi
    3a58:	89 55 f0             	mov    DWORD PTR [rbp-0x10],edx
		(void)fb; (void)new_lx; (void)new_ly;
}
    3a5b:	90                   	nop
    3a5c:	c9                   	leave
    3a5d:	c3                   	ret
