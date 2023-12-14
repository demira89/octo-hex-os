
framebuffer.o64:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <memcpy>:
						break;
				}

				/* and don't advance as r = 0 is already handled (sth. remains) */
				if (px_x) {
						px_x -= bitc / 32;
       0:	55                   	push   rbp
       1:	48 89 e5             	mov    rbp,rsp
       4:	48 83 ec 28          	sub    rsp,0x28
       8:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
       c:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
      10:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
						p0_x += bitc / 32; /* unneccessary as r does not change anymore */
      14:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
      18:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				} else
      1c:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
      20:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
						break;
      24:	eb 1d                	jmp    43 <memcpy+0x43>
		}
      26:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
      2a:	48 8d 42 01          	lea    rax,[rdx+0x1]
      2e:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
      32:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      36:	48 8d 48 01          	lea    rcx,[rax+0x1]
      3a:	48 89 4d f8          	mov    QWORD PTR [rbp-0x8],rcx
      3e:	0f b6 12             	movzx  edx,BYTE PTR [rdx]
      41:	88 10                	mov    BYTE PTR [rax],dl
						break;
      43:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
      47:	48 8d 50 ff          	lea    rdx,[rax-0x1]
      4b:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
      4f:	48 85 c0             	test   rax,rax
      52:	75 d2                	jne    26 <memcpy+0x26>
}
      54:	90                   	nop
      55:	90                   	nop
      56:	c9                   	leave
      57:	c3                   	ret

0000000000000058 <fb_video_setup>:
{
      58:	55                   	push   rbp
      59:	48 89 e5             	mov    rbp,rsp
      5c:	48 83 ec 40          	sub    rsp,0x40
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
     11d:	89 7c 24 20          	mov    DWORD PTR [rsp+0x20],edi
     121:	89 74 24 18          	mov    DWORD PTR [rsp+0x18],esi
     125:	c7 44 24 10 00 00 00 00 	mov    DWORD PTR [rsp+0x10],0x0
     12d:	c7 44 24 08 00 00 00 00 	mov    DWORD PTR [rsp+0x8],0x0
     135:	c7 04 24 00 00 00 00 	mov    DWORD PTR [rsp],0x0
     13c:	41 b9 00 00 00 00    	mov    r9d,0x0
     142:	48 89 c6             	mov    rsi,rax
     145:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     14c:	e8 00 00 00 00       	call   151 <fb_video_setup+0xf9>
		kio_fb_resize();
     151:	b8 00 00 00 00       	mov    eax,0x0
     156:	e8 00 00 00 00       	call   15b <fb_video_setup+0x103>
		puts("done setting up the framebuffer");
     15b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     162:	e8 00 00 00 00       	call   167 <fb_video_setup+0x10f>
		framebuffer_redraw(&fb_initial);
     167:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     16e:	e8 00 00 00 00       	call   173 <fb_video_setup+0x11b>
}
     173:	90                   	nop
     174:	c9                   	leave
     175:	c3                   	ret

0000000000000176 <framebuffer_initialize>:
{
     176:	55                   	push   rbp
     177:	48 89 e5             	mov    rbp,rsp
     17a:	48 83 ec 28          	sub    rsp,0x28
     17e:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
     182:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
     186:	48 89 55 e8          	mov    QWORD PTR [rbp-0x18],rdx
     18a:	89 4d e4             	mov    DWORD PTR [rbp-0x1c],ecx
     18d:	44 89 45 e0          	mov    DWORD PTR [rbp-0x20],r8d
     191:	44 89 4d dc          	mov    DWORD PTR [rbp-0x24],r9d
		fb->text_mem = textmem;
     195:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     199:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     19d:	48 89 10             	mov    QWORD PTR [rax],rdx
		fb->font = font;
     1a0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1a4:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     1a8:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
		fb->width = width;
     1ac:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1b0:	8b 55 e4             	mov    edx,DWORD PTR [rbp-0x1c]
     1b3:	89 50 08             	mov    DWORD PTR [rax+0x8],edx
		fb->height = height;
     1b6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1ba:	8b 55 e0             	mov    edx,DWORD PTR [rbp-0x20]
     1bd:	89 50 0c             	mov    DWORD PTR [rax+0xc],edx
		fb->is_visible = 1;
     1c0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1c4:	c7 40 18 01 00 00 00 	mov    DWORD PTR [rax+0x18],0x1
		fb->cur_x = fb->cur_y = 0;
     1cb:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1cf:	c7 40 20 00 00 00 00 	mov    DWORD PTR [rax+0x20],0x0
     1d6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1da:	8b 50 20             	mov    edx,DWORD PTR [rax+0x20]
     1dd:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1e1:	89 50 1c             	mov    DWORD PTR [rax+0x1c],edx
		fb->pix_x = pxl_ofs_x;
     1e4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1e8:	8b 55 dc             	mov    edx,DWORD PTR [rbp-0x24]
     1eb:	89 50 24             	mov    DWORD PTR [rax+0x24],edx
		fb->pix_y = pxl_ofs_y;
     1ee:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1f2:	8b 55 10             	mov    edx,DWORD PTR [rbp+0x10]
     1f5:	89 50 28             	mov    DWORD PTR [rax+0x28],edx
		fb->cho_x = char_ofs_x;
     1f8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1fc:	8b 55 18             	mov    edx,DWORD PTR [rbp+0x18]
     1ff:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
		fb->cho_y = char_ofs_y;
     202:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     206:	8b 55 20             	mov    edx,DWORD PTR [rbp+0x20]
     209:	89 50 30             	mov    DWORD PTR [rax+0x30],edx
		fb->chw_x = char_width_x;
     20c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     210:	8b 55 28             	mov    edx,DWORD PTR [rbp+0x28]
     213:	89 50 34             	mov    DWORD PTR [rax+0x34],edx
		fb->chw_y = char_width_y;
     216:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     21a:	8b 55 30             	mov    edx,DWORD PTR [rbp+0x30]
     21d:	89 50 38             	mov    DWORD PTR [rax+0x38],edx
		fb->r_ud = NULL;
     220:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     224:	48 c7 40 40 00 00 00 00 	mov    QWORD PTR [rax+0x40],0x0
		fb->r_excl = NULL;
     22c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     230:	48 c7 40 48 00 00 00 00 	mov    QWORD PTR [rax+0x48],0x0
}
     238:	90                   	nop
     239:	c9                   	leave
     23a:	c3                   	ret

000000000000023b <framebuffer_add_exclude_rect>:
{
     23b:	55                   	push   rbp
     23c:	48 89 e5             	mov    rbp,rsp
     23f:	48 83 ec 10          	sub    rsp,0x10
     243:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
     247:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
		if (!r)
     24b:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
     250:	74 3b                	je     28d <framebuffer_add_exclude_rect+0x52>
				r->next = fb->r_excl;
     252:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     256:	48 8b 50 48          	mov    rdx,QWORD PTR [rax+0x48]
     25a:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     25e:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
		} while (!__sync_bool_compare_and_swap(&fb->r_excl, r->next, r));
     262:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     266:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     26a:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
     26e:	48 89 c6             	mov    rsi,rax
     271:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     275:	48 8d 48 48          	lea    rcx,[rax+0x48]
     279:	48 89 f0             	mov    rax,rsi
     27c:	f0 48 0f b1 11       	lock cmpxchg QWORD PTR [rcx],rdx
     281:	0f 94 c0             	sete   al
     284:	83 f0 01             	xor    eax,0x1
     287:	84 c0                	test   al,al
     289:	75 c7                	jne    252 <framebuffer_add_exclude_rect+0x17>
     28b:	eb 01                	jmp    28e <framebuffer_add_exclude_rect+0x53>
				return;
     28d:	90                   	nop
}
     28e:	c9                   	leave
     28f:	c3                   	ret

0000000000000290 <framebuffer_remove_exclude_rect>:
{
     290:	55                   	push   rbp
     291:	48 89 e5             	mov    rbp,rsp
     294:	48 83 ec 20          	sub    rsp,0x20
     298:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
     29c:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
		er = &fb->r_excl;
     2a0:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     2a4:	48 83 c0 48          	add    rax,0x48
     2a8:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		while ((r2 = *er)) {
     2ac:	eb 37                	jmp    2e5 <framebuffer_remove_exclude_rect+0x55>
				if (r2 == r) {
     2ae:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     2b2:	48 3b 45 e0          	cmp    rax,QWORD PTR [rbp-0x20]
     2b6:	75 21                	jne    2d9 <framebuffer_remove_exclude_rect+0x49>
						if (__sync_bool_compare_and_swap(er, r, r->next))
     2b8:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     2bc:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
     2c0:	48 89 c1             	mov    rcx,rax
     2c3:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
     2c7:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     2cb:	f0 48 0f b1 0a       	lock cmpxchg QWORD PTR [rdx],rcx
     2d0:	0f 94 c0             	sete   al
     2d3:	84 c0                	test   al,al
     2d5:	75 22                	jne    2f9 <framebuffer_remove_exclude_rect+0x69>
								goto Pos1;
     2d7:	eb c7                	jmp    2a0 <framebuffer_remove_exclude_rect+0x10>
				er = &r2->next;
     2d9:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     2dd:	48 83 c0 10          	add    rax,0x10
     2e1:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		while ((r2 = *er)) {
     2e5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     2e9:	48 8b 00             	mov    rax,QWORD PTR [rax]
     2ec:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
     2f0:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
     2f5:	75 b7                	jne    2ae <framebuffer_remove_exclude_rect+0x1e>
     2f7:	eb 01                	jmp    2fa <framebuffer_remove_exclude_rect+0x6a>
								return;
     2f9:	90                   	nop
}
     2fa:	c9                   	leave
     2fb:	c3                   	ret

00000000000002fc <get_tm_color>:
{
     2fc:	55                   	push   rbp
     2fd:	48 89 e5             	mov    rbp,rsp
     300:	48 83 ec 20          	sub    rsp,0x20
     304:	89 f9                	mov    ecx,edi
     306:	89 f0                	mov    eax,esi
     308:	89 55 e4             	mov    DWORD PTR [rbp-0x1c],edx
     30b:	89 ca                	mov    edx,ecx
     30d:	88 55 ec             	mov    BYTE PTR [rbp-0x14],dl
     310:	88 45 e8             	mov    BYTE PTR [rbp-0x18],al
		switch (btpp) {
     313:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     316:	83 e8 04             	sub    eax,0x4
     319:	83 f8 1c             	cmp    eax,0x1c
     31c:	0f 87 1b 01 00 00    	ja     43d <get_tm_color+0x141>
     322:	89 c0                	mov    eax,eax
     324:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
     32c:	ff e0                	jmp    rax
						if (is_set)
     32e:	80 7d e8 00          	cmp    BYTE PTR [rbp-0x18],0x0
     332:	74 0c                	je     340 <get_tm_color+0x44>
								return col & 0x0f;
     334:	0f be 45 ec          	movsx  eax,BYTE PTR [rbp-0x14]
     338:	83 e0 0f             	and    eax,0xf
     33b:	e9 02 01 00 00       	jmp    442 <get_tm_color+0x146>
								return (col >> 4) & 0x0f;
     340:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
     344:	c0 f8 04             	sar    al,0x4
     347:	0f be c0             	movsx  eax,al
     34a:	83 e0 0f             	and    eax,0xf
     34d:	e9 f0 00 00 00       	jmp    442 <get_tm_color+0x146>
						if (is_set)
     352:	80 7d e8 00          	cmp    BYTE PTR [rbp-0x18],0x0
     356:	74 0c                	je     364 <get_tm_color+0x68>
								return col & 0x0f;
     358:	0f be 45 ec          	movsx  eax,BYTE PTR [rbp-0x14]
     35c:	83 e0 0f             	and    eax,0xf
     35f:	e9 de 00 00 00       	jmp    442 <get_tm_color+0x146>
								return (col >> 4) & 0x0f;
     364:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
     368:	c0 f8 04             	sar    al,0x4
     36b:	0f be c0             	movsx  eax,al
     36e:	83 e0 0f             	and    eax,0xf
     371:	e9 cc 00 00 00       	jmp    442 <get_tm_color+0x146>
						if (is_set)
     376:	80 7d e8 00          	cmp    BYTE PTR [rbp-0x18],0x0
     37a:	74 15                	je     391 <get_tm_color+0x95>
								iv = palette_32[col & 0x0f];
     37c:	0f be 45 ec          	movsx  eax,BYTE PTR [rbp-0x14]
     380:	83 e0 0f             	and    eax,0xf
     383:	48 98                	cdqe
     385:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [rax*4+0x0]
     38c:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
     38f:	eb 19                	jmp    3aa <get_tm_color+0xae>
								iv = palette_32[(col >> 4) & 0x0f];
     391:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
     395:	c0 f8 04             	sar    al,0x4
     398:	0f be c0             	movsx  eax,al
     39b:	83 e0 0f             	and    eax,0xf
     39e:	48 98                	cdqe
     3a0:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [rax*4+0x0]
     3a7:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
						if (btpp == 15)
     3aa:	83 7d e4 0f          	cmp    DWORD PTR [rbp-0x1c],0xf
     3ae:	75 2d                	jne    3dd <get_tm_color+0xe1>
								rv = (iv.b >> 3) | ((iv.g >> 3) << 5) | ((iv.r >> 3) << 10);
     3b0:	0f b6 45 f8          	movzx  eax,BYTE PTR [rbp-0x8]
     3b4:	c0 e8 03             	shr    al,0x3
     3b7:	0f b6 c0             	movzx  eax,al
     3ba:	0f b6 55 f9          	movzx  edx,BYTE PTR [rbp-0x7]
     3be:	c0 ea 03             	shr    dl,0x3
     3c1:	0f b6 d2             	movzx  edx,dl
     3c4:	c1 e2 05             	shl    edx,0x5
     3c7:	09 c2                	or     edx,eax
     3c9:	0f b6 45 fa          	movzx  eax,BYTE PTR [rbp-0x6]
     3cd:	c0 e8 03             	shr    al,0x3
     3d0:	0f b6 c0             	movzx  eax,al
     3d3:	c1 e0 0a             	shl    eax,0xa
     3d6:	09 d0                	or     eax,edx
     3d8:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
     3db:	eb 2b                	jmp    408 <get_tm_color+0x10c>
								rv = (iv.b >> 3) | ((iv.g >> 2) << 5) | ((iv.r >> 3) << 11);
     3dd:	0f b6 45 f8          	movzx  eax,BYTE PTR [rbp-0x8]
     3e1:	c0 e8 03             	shr    al,0x3
     3e4:	0f b6 c0             	movzx  eax,al
     3e7:	0f b6 55 f9          	movzx  edx,BYTE PTR [rbp-0x7]
     3eb:	c0 ea 02             	shr    dl,0x2
     3ee:	0f b6 d2             	movzx  edx,dl
     3f1:	c1 e2 05             	shl    edx,0x5
     3f4:	09 c2                	or     edx,eax
     3f6:	0f b6 45 fa          	movzx  eax,BYTE PTR [rbp-0x6]
     3fa:	c0 e8 03             	shr    al,0x3
     3fd:	0f b6 c0             	movzx  eax,al
     400:	c1 e0 0b             	shl    eax,0xb
     403:	09 d0                	or     eax,edx
     405:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
						return rv;
     408:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     40b:	eb 35                	jmp    442 <get_tm_color+0x146>
						if (is_set)
     40d:	80 7d e8 00          	cmp    BYTE PTR [rbp-0x18],0x0
     411:	74 12                	je     425 <get_tm_color+0x129>
								return palette_32[col & 0x0f].val;
     413:	0f be 45 ec          	movsx  eax,BYTE PTR [rbp-0x14]
     417:	83 e0 0f             	and    eax,0xf
     41a:	48 98                	cdqe
     41c:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [rax*4+0x0]
     423:	eb 1d                	jmp    442 <get_tm_color+0x146>
								return palette_32[(col >> 4) & 0x0f].val;
     425:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
     429:	c0 f8 04             	sar    al,0x4
     42c:	0f be c0             	movsx  eax,al
     42f:	83 e0 0f             	and    eax,0xf
     432:	48 98                	cdqe
     434:	8b 04 85 00 00 00 00 	mov    eax,DWORD PTR [rax*4+0x0]
     43b:	eb 05                	jmp    442 <get_tm_color+0x146>
		return 0x2f0c0c2f; /* canary */
     43d:	b8 2f 0c 0c 2f       	mov    eax,0x2f0c0c2f
}
     442:	c9                   	leave
     443:	c3                   	ret

0000000000000444 <generate_char_colors>:
{
     444:	55                   	push   rbp
     445:	48 89 e5             	mov    rbp,rsp
     448:	48 83 ec 30          	sub    rsp,0x30
     44c:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
     450:	89 d0                	mov    eax,edx
     452:	48 89 4d d8          	mov    QWORD PTR [rbp-0x28],rcx
     456:	44 89 45 d4          	mov    DWORD PTR [rbp-0x2c],r8d
     45a:	44 89 4d d0          	mov    DWORD PTR [rbp-0x30],r9d
     45e:	89 f2                	mov    edx,esi
     460:	88 55 e4             	mov    BYTE PTR [rbp-0x1c],dl
     463:	88 45 e0             	mov    BYTE PTR [rbp-0x20],al
		int rv = 0;
     466:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		uint8_t f = (uint8_t)font[c * 16];
     46d:	0f be 45 e4          	movsx  eax,BYTE PTR [rbp-0x1c]
     471:	c1 e0 04             	shl    eax,0x4
     474:	48 63 d0             	movsxd rdx,eax
     477:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     47b:	48 01 d0             	add    rax,rdx
     47e:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     481:	88 45 f7             	mov    BYTE PTR [rbp-0x9],al
		for (; r < rmax; r++) {
     484:	e9 13 01 00 00       	jmp    59c <generate_char_colors+0x158>
				int is_set = f & (1 << (7 - r));
     489:	0f b6 55 f7          	movzx  edx,BYTE PTR [rbp-0x9]
     48d:	b8 07 00 00 00       	mov    eax,0x7
     492:	2b 45 d4             	sub    eax,DWORD PTR [rbp-0x2c]
     495:	be 01 00 00 00       	mov    esi,0x1
     49a:	89 c1                	mov    ecx,eax
     49c:	d3 e6                	shl    esi,cl
     49e:	89 f0                	mov    eax,esi
     4a0:	21 d0                	and    eax,edx
     4a2:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
				if (inv)
     4a5:	83 7d 18 00          	cmp    DWORD PTR [rbp+0x18],0x0
     4a9:	74 0d                	je     4b8 <generate_char_colors+0x74>
						is_set = !is_set;
     4ab:	83 7d f8 00          	cmp    DWORD PTR [rbp-0x8],0x0
     4af:	0f 94 c0             	sete   al
     4b2:	0f b6 c0             	movzx  eax,al
     4b5:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
				cv = get_tm_color(fmt, is_set, btpp);
     4b8:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     4bc:	89 c2                	mov    edx,eax
     4be:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
     4c1:	0f be c8             	movsx  ecx,al
     4c4:	0f be 45 e0          	movsx  eax,BYTE PTR [rbp-0x20]
     4c8:	89 ce                	mov    esi,ecx
     4ca:	89 c7                	mov    edi,eax
     4cc:	e8 00 00 00 00       	call   4d1 <generate_char_colors+0x8d>
     4d1:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
				switch (btpp) {
     4d4:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     4d8:	48 83 e8 04          	sub    rax,0x4
     4dc:	48 83 f8 1c          	cmp    rax,0x1c
     4e0:	0f 87 b2 00 00 00    	ja     598 <generate_char_colors+0x154>
     4e6:	48 8b 04 c5 00 00 00 00 	mov    rax,QWORD PTR [rax*8+0x0]
     4ee:	ff e0                	jmp    rax
								*(uint32_t*)cvs = (uint32_t)cv;
     4f0:	48 8b 45 10          	mov    rax,QWORD PTR [rbp+0x10]
     4f4:	8b 55 f0             	mov    edx,DWORD PTR [rbp-0x10]
     4f7:	89 10                	mov    DWORD PTR [rax],edx
								cvs += 4; rv += 32;
     4f9:	48 83 45 10 04       	add    QWORD PTR [rbp+0x10],0x4
     4fe:	83 45 fc 20          	add    DWORD PTR [rbp-0x4],0x20
								break;
     502:	e9 91 00 00 00       	jmp    598 <generate_char_colors+0x154>
								*(uint16_t*)cvs = (uint16_t)(cv & 0xffff);
     507:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     50a:	89 c2                	mov    edx,eax
     50c:	48 8b 45 10          	mov    rax,QWORD PTR [rbp+0x10]
     510:	66 89 10             	mov    WORD PTR [rax],dx
								cvs += 2;
     513:	48 83 45 10 02       	add    QWORD PTR [rbp+0x10],0x2
								*(uint8_t*)cvs++ = (uint8_t)(cv >> 16);
     518:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     51b:	c1 e8 10             	shr    eax,0x10
     51e:	89 c1                	mov    ecx,eax
     520:	48 8b 45 10          	mov    rax,QWORD PTR [rbp+0x10]
     524:	48 8d 50 01          	lea    rdx,[rax+0x1]
     528:	48 89 55 10          	mov    QWORD PTR [rbp+0x10],rdx
     52c:	89 ca                	mov    edx,ecx
     52e:	88 10                	mov    BYTE PTR [rax],dl
								rv += 24;
     530:	83 45 fc 18          	add    DWORD PTR [rbp-0x4],0x18
								break;
     534:	eb 62                	jmp    598 <generate_char_colors+0x154>
								*(uint16_t*)cvs = (uint16_t)cv;
     536:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
     539:	89 c2                	mov    edx,eax
     53b:	48 8b 45 10          	mov    rax,QWORD PTR [rbp+0x10]
     53f:	66 89 10             	mov    WORD PTR [rax],dx
								cvs += 2; rv += 16; /* even for 15 */
     542:	48 83 45 10 02       	add    QWORD PTR [rbp+0x10],0x2
     547:	83 45 fc 10          	add    DWORD PTR [rbp-0x4],0x10
								break;
     54b:	eb 4b                	jmp    598 <generate_char_colors+0x154>
								*cvs++ = (uint8_t)cv; rv += 8;
     54d:	48 8b 45 10          	mov    rax,QWORD PTR [rbp+0x10]
     551:	48 8d 50 01          	lea    rdx,[rax+0x1]
     555:	48 89 55 10          	mov    QWORD PTR [rbp+0x10],rdx
     559:	8b 55 f0             	mov    edx,DWORD PTR [rbp-0x10]
     55c:	88 10                	mov    BYTE PTR [rax],dl
     55e:	83 45 fc 08          	add    DWORD PTR [rbp-0x4],0x8
								break;
     562:	eb 34                	jmp    598 <generate_char_colors+0x154>
								rv += 4;
     564:	83 45 fc 04          	add    DWORD PTR [rbp-0x4],0x4
								die("also complicated!\n");
     568:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     56f:	bf 0c 00 00 00       	mov    edi,0xc
     574:	b8 00 00 00 00       	mov    eax,0x0
     579:	e8 00 00 00 00       	call   57e <generate_char_colors+0x13a>
     57e:	b8 00 00 00 00       	mov    eax,0x0
     583:	e8 00 00 00 00       	call   588 <generate_char_colors+0x144>
     588:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     58f:	e8 00 00 00 00       	call   594 <generate_char_colors+0x150>
     594:	fa                   	cli
     595:	f4                   	hlt
     596:	eb fd                	jmp    595 <generate_char_colors+0x151>
		for (; r < rmax; r++) {
     598:	83 45 d4 01          	add    DWORD PTR [rbp-0x2c],0x1
     59c:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
     59f:	3b 45 d0             	cmp    eax,DWORD PTR [rbp-0x30]
     5a2:	0f 8c e1 fe ff ff    	jl     489 <generate_char_colors+0x45>
		return rv;
     5a8:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
     5ab:	c9                   	leave
     5ac:	c3                   	ret

00000000000005ad <render_text_scanline_32btpp_sse>:
{
     5ad:	55                   	push   rbp
     5ae:	48 89 e5             	mov    rbp,rsp
     5b1:	48 81 ec c0 00 00 00 	sub    rsp,0xc0
     5b8:	48 89 bd 78 ff ff ff 	mov    QWORD PTR [rbp-0x88],rdi
     5bf:	48 89 b5 70 ff ff ff 	mov    QWORD PTR [rbp-0x90],rsi
     5c6:	48 89 95 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rdx
     5cd:	89 8d 64 ff ff ff    	mov    DWORD PTR [rbp-0x9c],ecx
     5d3:	44 89 85 60 ff ff ff 	mov    DWORD PTR [rbp-0xa0],r8d
     5da:	44 89 8d 5c ff ff ff 	mov    DWORD PTR [rbp-0xa4],r9d
		ssize_t misalign = ((size_t)mem % 16) ? (16 - (size_t)mem % 16) : 0;
     5e1:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     5e8:	83 e0 0f             	and    eax,0xf
     5eb:	48 85 c0             	test   rax,rax
     5ee:	74 15                	je     605 <render_text_scanline_32btpp_sse+0x58>
     5f0:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     5f7:	83 e0 0f             	and    eax,0xf
     5fa:	ba 10 00 00 00       	mov    edx,0x10
     5ff:	29 c2                	sub    edx,eax
     601:	89 d0                	mov    eax,edx
     603:	eb 05                	jmp    60a <render_text_scanline_32btpp_sse+0x5d>
     605:	b8 00 00 00 00       	mov    eax,0x0
     60a:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
		ssize_t r = p0_x % 8;
     60d:	8b 95 5c ff ff ff    	mov    edx,DWORD PTR [rbp-0xa4]
     613:	89 d0                	mov    eax,edx
     615:	c1 f8 1f             	sar    eax,0x1f
     618:	c1 e8 1d             	shr    eax,0x1d
     61b:	01 c2                	add    edx,eax
     61d:	83 e2 07             	and    edx,0x7
     620:	29 c2                	sub    edx,eax
     622:	89 55 e8             	mov    DWORD PTR [rbp-0x18],edx
		uint8_t* pixbuf = pxb + (((size_t)pxb % 16) ? (16 - ((size_t)pxb % 16)) : 0);
     625:	48 8d 45 90          	lea    rax,[rbp-0x70]
     629:	83 e0 0f             	and    eax,0xf
     62c:	48 85 c0             	test   rax,rax
     62f:	74 14                	je     645 <render_text_scanline_32btpp_sse+0x98>
     631:	48 8d 45 90          	lea    rax,[rbp-0x70]
     635:	83 e0 0f             	and    eax,0xf
     638:	48 89 c2             	mov    rdx,rax
     63b:	b8 10 00 00 00       	mov    eax,0x10
     640:	48 29 d0             	sub    rax,rdx
     643:	eb 05                	jmp    64a <render_text_scanline_32btpp_sse+0x9d>
     645:	b8 00 00 00 00       	mov    eax,0x0
     64a:	48 8d 55 90          	lea    rdx,[rbp-0x70]
     64e:	48 01 d0             	add    rax,rdx
     651:	48 89 45 88          	mov    QWORD PTR [rbp-0x78],rax
		if (misalign) { /* LFB is dword aligned, we want (dq/o)word access */
     655:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
     659:	0f 84 0a 04 00 00    	je     a69 <render_text_scanline_32btpp_sse+0x4bc>
				int col = p0_x / 8, inv = (col == cur_x);
     65f:	8b 85 5c ff ff ff    	mov    eax,DWORD PTR [rbp-0xa4]
     665:	8d 50 07             	lea    edx,[rax+0x7]
     668:	85 c0                	test   eax,eax
     66a:	0f 48 c2             	cmovs  eax,edx
     66d:	c1 f8 03             	sar    eax,0x3
     670:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
     673:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     676:	3b 85 60 ff ff ff    	cmp    eax,DWORD PTR [rbp-0xa0]
     67c:	0f 94 c0             	sete   al
     67f:	0f b6 c0             	movzx  eax,al
     682:	89 45 e0             	mov    DWORD PTR [rbp-0x20],eax
				ssize_t bc = min(misalign, 4 * px_x);
     685:	8b 85 64 ff ff ff    	mov    eax,DWORD PTR [rbp-0x9c]
     68b:	c1 e0 02             	shl    eax,0x2
     68e:	8b 55 ec             	mov    edx,DWORD PTR [rbp-0x14]
     691:	39 c2                	cmp    edx,eax
     693:	0f 4e c2             	cmovle eax,edx
     696:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
				ssize_t cc = rdiv(misalign, 4);
     699:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     69c:	8d 50 03             	lea    edx,[rax+0x3]
     69f:	85 c0                	test   eax,eax
     6a1:	0f 48 c2             	cmovs  eax,edx
     6a4:	c1 f8 02             	sar    eax,0x2
     6a7:	89 c2                	mov    edx,eax
     6a9:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
     6ac:	83 e0 03             	and    eax,0x3
     6af:	85 c0                	test   eax,eax
     6b1:	0f 95 c0             	setne  al
     6b4:	0f b6 c0             	movzx  eax,al
     6b7:	01 d0                	add    eax,edx
     6b9:	89 45 d8             	mov    DWORD PTR [rbp-0x28],eax
				ssize_t rmax = min(8, r + cc), cc1 = rmax - r;
     6bc:	8b 55 e8             	mov    edx,DWORD PTR [rbp-0x18]
     6bf:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
     6c2:	01 d0                	add    eax,edx
     6c4:	ba 08 00 00 00       	mov    edx,0x8
     6c9:	39 d0                	cmp    eax,edx
     6cb:	0f 4f c2             	cmovg  eax,edx
     6ce:	89 45 d4             	mov    DWORD PTR [rbp-0x2c],eax
     6d1:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
     6d4:	2b 45 e8             	sub    eax,DWORD PTR [rbp-0x18]
     6d7:	89 45 d0             	mov    DWORD PTR [rbp-0x30],eax
				generate_char_colors(font, str[0], str[1], 32,
     6da:	48 8b 4d 88          	mov    rcx,QWORD PTR [rbp-0x78]
     6de:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     6e5:	48 83 c0 01          	add    rax,0x1
     6e9:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     6ec:	0f be d0             	movsx  edx,al
     6ef:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     6f6:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     6f9:	0f be f0             	movsx  esi,al
     6fc:	44 8b 4d d4          	mov    r9d,DWORD PTR [rbp-0x2c]
     700:	44 8b 45 e8          	mov    r8d,DWORD PTR [rbp-0x18]
     704:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     70b:	8b 7d e0             	mov    edi,DWORD PTR [rbp-0x20]
     70e:	89 7c 24 08          	mov    DWORD PTR [rsp+0x8],edi
     712:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
     716:	b9 20 00 00 00       	mov    ecx,0x20
     71b:	48 89 c7             	mov    rdi,rax
     71e:	e8 00 00 00 00       	call   723 <render_text_scanline_32btpp_sse+0x176>
				if (rmax == 8)
     723:	83 7d d4 08          	cmp    DWORD PTR [rbp-0x2c],0x8
     727:	75 08                	jne    731 <render_text_scanline_32btpp_sse+0x184>
						str += 2;
     729:	48 83 85 70 ff ff ff 02 	add    QWORD PTR [rbp-0x90],0x2
				if (cc > cc1) { /* generate the new char */
     731:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
     734:	3b 45 d0             	cmp    eax,DWORD PTR [rbp-0x30]
     737:	7e 75                	jle    7ae <render_text_scanline_32btpp_sse+0x201>
						col++; inv = (col == cur_x);
     739:	83 45 e4 01          	add    DWORD PTR [rbp-0x1c],0x1
     73d:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     740:	3b 85 60 ff ff ff    	cmp    eax,DWORD PTR [rbp-0xa0]
     746:	0f 94 c0             	sete   al
     749:	0f b6 c0             	movzx  eax,al
     74c:	89 45 e0             	mov    DWORD PTR [rbp-0x20],eax
						generate_char_colors(font, str[0], str[1], 32,
     74f:	48 8b 55 88          	mov    rdx,QWORD PTR [rbp-0x78]
										0, cc - cc1, pixbuf + cc1 * 4, inv);
     753:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
     756:	c1 e0 02             	shl    eax,0x2
     759:	48 98                	cdqe
						generate_char_colors(font, str[0], str[1], 32,
     75b:	48 8d 3c 02          	lea    rdi,[rdx+rax*1]
     75f:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
     762:	2b 45 d0             	sub    eax,DWORD PTR [rbp-0x30]
     765:	41 89 c0             	mov    r8d,eax
     768:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     76f:	48 83 c0 01          	add    rax,0x1
     773:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     776:	0f be d0             	movsx  edx,al
     779:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     780:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     783:	0f be f0             	movsx  esi,al
     786:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     78d:	8b 4d e0             	mov    ecx,DWORD PTR [rbp-0x20]
     790:	89 4c 24 08          	mov    DWORD PTR [rsp+0x8],ecx
     794:	48 89 3c 24          	mov    QWORD PTR [rsp],rdi
     798:	45 89 c1             	mov    r9d,r8d
     79b:	41 b8 00 00 00 00    	mov    r8d,0x0
     7a1:	b9 20 00 00 00       	mov    ecx,0x20
     7a6:	48 89 c7             	mov    rdi,rax
     7a9:	e8 00 00 00 00       	call   7ae <render_text_scanline_32btpp_sse+0x201>
				memcpy(mem, pixbuf, bc);
     7ae:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
     7b1:	48 63 d0             	movsxd rdx,eax
     7b4:	48 8b 4d 88          	mov    rcx,QWORD PTR [rbp-0x78]
     7b8:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     7bf:	48 89 ce             	mov    rsi,rcx
     7c2:	48 89 c7             	mov    rdi,rax
     7c5:	e8 36 f8 ff ff       	call   0 <memcpy>
				px_x -= cc;
     7ca:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
     7cd:	29 85 64 ff ff ff    	sub    DWORD PTR [rbp-0x9c],eax
				p0_x += cc;
     7d3:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
     7d6:	01 85 5c ff ff ff    	add    DWORD PTR [rbp-0xa4],eax
				mem += bc;
     7dc:	48 8b 95 68 ff ff ff 	mov    rdx,QWORD PTR [rbp-0x98]
     7e3:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
     7e6:	48 98                	cdqe
     7e8:	48 01 d0             	add    rax,rdx
     7eb:	48 89 85 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rax
		while (px_x) {
     7f2:	e9 72 02 00 00       	jmp    a69 <render_text_scanline_32btpp_sse+0x4bc>
				int col = p0_x / 8, inv = (col == cur_x);
     7f7:	8b 85 5c ff ff ff    	mov    eax,DWORD PTR [rbp-0xa4]
     7fd:	8d 50 07             	lea    edx,[rax+0x7]
     800:	85 c0                	test   eax,eax
     802:	0f 48 c2             	cmovs  eax,edx
     805:	c1 f8 03             	sar    eax,0x3
     808:	89 45 cc             	mov    DWORD PTR [rbp-0x34],eax
     80b:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
     80e:	3b 85 60 ff ff ff    	cmp    eax,DWORD PTR [rbp-0xa0]
     814:	0f 94 c0             	sete   al
     817:	0f b6 c0             	movzx  eax,al
     81a:	89 45 c8             	mov    DWORD PTR [rbp-0x38],eax
				ssize_t rmax, bitc, btt = min(128, 32 * px_x);
     81d:	8b 85 64 ff ff ff    	mov    eax,DWORD PTR [rbp-0x9c]
     823:	c1 e0 05             	shl    eax,0x5
     826:	ba 80 00 00 00       	mov    edx,0x80
     82b:	39 d0                	cmp    eax,edx
     82d:	0f 4f c2             	cmovg  eax,edx
     830:	89 45 c4             	mov    DWORD PTR [rbp-0x3c],eax
				r = p0_x % 8;
     833:	8b 95 5c ff ff ff    	mov    edx,DWORD PTR [rbp-0xa4]
     839:	89 d0                	mov    eax,edx
     83b:	c1 f8 1f             	sar    eax,0x1f
     83e:	c1 e8 1d             	shr    eax,0x1d
     841:	01 c2                	add    edx,eax
     843:	83 e2 07             	and    edx,0x7
     846:	29 c2                	sub    edx,eax
     848:	89 55 e8             	mov    DWORD PTR [rbp-0x18],edx
				rmax = min(8, r + min(4, px_x)); /* only 4 pixels */
     84b:	8b 85 64 ff ff ff    	mov    eax,DWORD PTR [rbp-0x9c]
     851:	ba 04 00 00 00       	mov    edx,0x4
     856:	39 d0                	cmp    eax,edx
     858:	0f 4e d0             	cmovle edx,eax
     85b:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
     85e:	01 d0                	add    eax,edx
     860:	ba 08 00 00 00       	mov    edx,0x8
     865:	39 d0                	cmp    eax,edx
     867:	0f 4f c2             	cmovg  eax,edx
     86a:	89 45 c0             	mov    DWORD PTR [rbp-0x40],eax
				bitc = generate_char_colors(font, str[0], str[1], 32,
     86d:	48 8b 4d 88          	mov    rcx,QWORD PTR [rbp-0x78]
     871:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     878:	48 83 c0 01          	add    rax,0x1
     87c:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     87f:	0f be d0             	movsx  edx,al
     882:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     889:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     88c:	0f be f0             	movsx  esi,al
     88f:	44 8b 4d c0          	mov    r9d,DWORD PTR [rbp-0x40]
     893:	44 8b 45 e8          	mov    r8d,DWORD PTR [rbp-0x18]
     897:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     89e:	8b 7d c8             	mov    edi,DWORD PTR [rbp-0x38]
     8a1:	89 7c 24 08          	mov    DWORD PTR [rsp+0x8],edi
     8a5:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
     8a9:	b9 20 00 00 00       	mov    ecx,0x20
     8ae:	48 89 c7             	mov    rdi,rax
     8b1:	e8 00 00 00 00       	call   8b6 <render_text_scanline_32btpp_sse+0x309>
     8b6:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
				if (rmax == 8)
     8b9:	83 7d c0 08          	cmp    DWORD PTR [rbp-0x40],0x8
     8bd:	75 08                	jne    8c7 <render_text_scanline_32btpp_sse+0x31a>
						str += 2;
     8bf:	48 83 85 70 ff ff ff 02 	add    QWORD PTR [rbp-0x90],0x2
				if (bitc < btt) {
     8c7:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     8ca:	3b 45 c4             	cmp    eax,DWORD PTR [rbp-0x3c]
     8cd:	0f 8d 8f 00 00 00    	jge    962 <render_text_scanline_32btpp_sse+0x3b5>
						col++; int pc = (btt - bitc) / 32;
     8d3:	83 45 cc 01          	add    DWORD PTR [rbp-0x34],0x1
     8d7:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
     8da:	2b 45 fc             	sub    eax,DWORD PTR [rbp-0x4]
     8dd:	8d 50 1f             	lea    edx,[rax+0x1f]
     8e0:	85 c0                	test   eax,eax
     8e2:	0f 48 c2             	cmovs  eax,edx
     8e5:	c1 f8 05             	sar    eax,0x5
     8e8:	89 45 bc             	mov    DWORD PTR [rbp-0x44],eax
						inv = (col == cur_x);
     8eb:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
     8ee:	3b 85 60 ff ff ff    	cmp    eax,DWORD PTR [rbp-0xa0]
     8f4:	0f 94 c0             	sete   al
     8f7:	0f b6 c0             	movzx  eax,al
     8fa:	89 45 c8             	mov    DWORD PTR [rbp-0x38],eax
						bitc += generate_char_colors(font, str[0], str[1], 32,
     8fd:	48 8b 55 88          	mov    rdx,QWORD PTR [rbp-0x78]
										0, pc, pixbuf + bitc / 32, inv);
     901:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     904:	8d 48 1f             	lea    ecx,[rax+0x1f]
     907:	85 c0                	test   eax,eax
     909:	0f 48 c1             	cmovs  eax,ecx
     90c:	c1 f8 05             	sar    eax,0x5
     90f:	48 98                	cdqe
						bitc += generate_char_colors(font, str[0], str[1], 32,
     911:	48 8d 3c 02          	lea    rdi,[rdx+rax*1]
     915:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     91c:	48 83 c0 01          	add    rax,0x1
     920:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     923:	0f be d0             	movsx  edx,al
     926:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     92d:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     930:	0f be f0             	movsx  esi,al
     933:	44 8b 45 bc          	mov    r8d,DWORD PTR [rbp-0x44]
     937:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     93e:	8b 4d c8             	mov    ecx,DWORD PTR [rbp-0x38]
     941:	89 4c 24 08          	mov    DWORD PTR [rsp+0x8],ecx
     945:	48 89 3c 24          	mov    QWORD PTR [rsp],rdi
     949:	45 89 c1             	mov    r9d,r8d
     94c:	41 b8 00 00 00 00    	mov    r8d,0x0
     952:	b9 20 00 00 00       	mov    ecx,0x20
     957:	48 89 c7             	mov    rdi,rax
     95a:	e8 00 00 00 00       	call   95f <render_text_scanline_32btpp_sse+0x3b2>
     95f:	01 45 fc             	add    DWORD PTR [rbp-0x4],eax
				if (bitc >= 128) {
     962:	83 7d fc 7f          	cmp    DWORD PTR [rbp-0x4],0x7f
     966:	7e 35                	jle    99d <render_text_scanline_32btpp_sse+0x3f0>
						move_128(pixbuf, mem);
     968:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
     96c:	48 8b 95 68 ff ff ff 	mov    rdx,QWORD PTR [rbp-0x98]
     973:	0f 28 00             	movaps xmm0,XMMWORD PTR [rax]
     976:	0f 29 02             	movaps XMMWORD PTR [rdx],xmm0
						mem += 16; /* intentionally no bitc subtract */
     979:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     980:	48 83 c0 10          	add    rax,0x10
     984:	48 89 85 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rax
				if (px_x) {
     98b:	83 bd 64 ff ff ff 00 	cmp    DWORD PTR [rbp-0x9c],0x0
     992:	0f 84 e0 00 00 00    	je     a78 <render_text_scanline_32btpp_sse+0x4cb>
     998:	e9 a2 00 00 00       	jmp    a3f <render_text_scanline_32btpp_sse+0x492>
						uint8_t* pt = pixbuf;
     99d:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
     9a1:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
						if (bitc >= 64) {
     9a5:	83 7d fc 3f          	cmp    DWORD PTR [rbp-0x4],0x3f
     9a9:	7e 2c                	jle    9d7 <render_text_scanline_32btpp_sse+0x42a>
								move_64(pixbuf, mem);
     9ab:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
     9af:	48 8b 95 68 ff ff ff 	mov    rdx,QWORD PTR [rbp-0x98]
     9b6:	0f 6f 00             	movq   mm0,QWORD PTR [rax]
     9b9:	0f 7f 02             	movq   QWORD PTR [rdx],mm0
								pt += 8;
     9bc:	48 83 45 f0 08       	add    QWORD PTR [rbp-0x10],0x8
								mem += 8;
     9c1:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     9c8:	48 83 c0 08          	add    rax,0x8
     9cc:	48 89 85 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rax
								bitc -= 64;
     9d3:	83 6d fc 40          	sub    DWORD PTR [rbp-0x4],0x40
						if (bitc >= 32) {
     9d7:	83 7d fc 1f          	cmp    DWORD PTR [rbp-0x4],0x1f
     9db:	7e 2c                	jle    a09 <render_text_scanline_32btpp_sse+0x45c>
								*(uint32_t*)mem = *(uint32_t*)pt;
     9dd:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     9e4:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     9e8:	8b 12                	mov    edx,DWORD PTR [rdx]
     9ea:	89 10                	mov    DWORD PTR [rax],edx
								pt += 4;
     9ec:	48 83 45 f0 04       	add    QWORD PTR [rbp-0x10],0x4
								mem += 4;
     9f1:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     9f8:	48 83 c0 04          	add    rax,0x4
     9fc:	48 89 85 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rax
								bitc -= 32;
     a03:	83 6d fc 20          	sub    DWORD PTR [rbp-0x4],0x20
						break;
     a07:	eb 72                	jmp    a7b <render_text_scanline_32btpp_sse+0x4ce>
						} else if (bitc) {
     a09:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
     a0d:	74 6c                	je     a7b <render_text_scanline_32btpp_sse+0x4ce>
								die("cant happen with dword sized pixels!\n");
     a0f:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
     a16:	bf 0c 00 00 00       	mov    edi,0xc
     a1b:	b8 00 00 00 00       	mov    eax,0x0
     a20:	e8 00 00 00 00       	call   a25 <render_text_scanline_32btpp_sse+0x478>
     a25:	b8 00 00 00 00       	mov    eax,0x0
     a2a:	e8 00 00 00 00       	call   a2f <render_text_scanline_32btpp_sse+0x482>
     a2f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     a36:	e8 00 00 00 00       	call   a3b <render_text_scanline_32btpp_sse+0x48e>
     a3b:	fa                   	cli
     a3c:	f4                   	hlt
     a3d:	eb fd                	jmp    a3c <render_text_scanline_32btpp_sse+0x48f>
						px_x -= bitc / 32;
     a3f:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     a42:	8d 50 1f             	lea    edx,[rax+0x1f]
     a45:	85 c0                	test   eax,eax
     a47:	0f 48 c2             	cmovs  eax,edx
     a4a:	c1 f8 05             	sar    eax,0x5
     a4d:	f7 d8                	neg    eax
     a4f:	01 85 64 ff ff ff    	add    DWORD PTR [rbp-0x9c],eax
						p0_x += bitc / 32; /* unneccessary as r does not change anymore */
     a55:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     a58:	8d 50 1f             	lea    edx,[rax+0x1f]
     a5b:	85 c0                	test   eax,eax
     a5d:	0f 48 c2             	cmovs  eax,edx
     a60:	c1 f8 05             	sar    eax,0x5
     a63:	01 85 5c ff ff ff    	add    DWORD PTR [rbp-0xa4],eax
		while (px_x) {
     a69:	83 bd 64 ff ff ff 00 	cmp    DWORD PTR [rbp-0x9c],0x0
     a70:	0f 85 81 fd ff ff    	jne    7f7 <render_text_scanline_32btpp_sse+0x24a>
}
     a76:	eb 04                	jmp    a7c <render_text_scanline_32btpp_sse+0x4cf>
						break;
     a78:	90                   	nop
     a79:	eb 01                	jmp    a7c <render_text_scanline_32btpp_sse+0x4cf>
						break;
     a7b:	90                   	nop
}
     a7c:	90                   	nop
     a7d:	c9                   	leave
     a7e:	c3                   	ret

0000000000000a7f <render_text_scanline_24btpp_sse>:

/* we're generating 3byte colorvalues /w unknown alignment. To enable
 * 16 byte transfers, 6 pixels /w 18 bytes have to be generated. */
void render_text_scanline_24btpp_sse(const char* font, char* str, void* mem,
				ssize_t px_x, ssize_t cur_x, ssize_t p0_x)
{
     a7f:	55                   	push   rbp
     a80:	48 89 e5             	mov    rbp,rsp
     a83:	48 81 ec c0 00 00 00 	sub    rsp,0xc0
     a8a:	48 89 bd 78 ff ff ff 	mov    QWORD PTR [rbp-0x88],rdi
     a91:	48 89 b5 70 ff ff ff 	mov    QWORD PTR [rbp-0x90],rsi
     a98:	48 89 95 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rdx
     a9f:	89 8d 64 ff ff ff    	mov    DWORD PTR [rbp-0x9c],ecx
     aa5:	44 89 85 60 ff ff ff 	mov    DWORD PTR [rbp-0xa0],r8d
     aac:	44 89 8d 5c ff ff ff 	mov    DWORD PTR [rbp-0xa4],r9d
		uint8_t pxb[18 + 2 + 15]; /* 15 for stack alignment, 2 for bt_ofs */
		ssize_t misalign = ((size_t)mem % 16) ? (16 - (size_t)mem % 16) : 0;
     ab3:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     aba:	83 e0 0f             	and    eax,0xf
     abd:	48 85 c0             	test   rax,rax
     ac0:	74 15                	je     ad7 <render_text_scanline_24btpp_sse+0x58>
     ac2:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     ac9:	83 e0 0f             	and    eax,0xf
     acc:	ba 10 00 00 00       	mov    edx,0x10
     ad1:	29 c2                	sub    edx,eax
     ad3:	89 d0                	mov    eax,edx
     ad5:	eb 05                	jmp    adc <render_text_scanline_24btpp_sse+0x5d>
     ad7:	b8 00 00 00 00       	mov    eax,0x0
     adc:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
		ssize_t r = p0_x % 8;
     adf:	8b 95 5c ff ff ff    	mov    edx,DWORD PTR [rbp-0xa4]
     ae5:	89 d0                	mov    eax,edx
     ae7:	c1 f8 1f             	sar    eax,0x1f
     aea:	c1 e8 1d             	shr    eax,0x1d
     aed:	01 c2                	add    edx,eax
     aef:	83 e2 07             	and    edx,0x7
     af2:	29 c2                	sub    edx,eax
     af4:	89 55 e0             	mov    DWORD PTR [rbp-0x20],edx
		uint8_t* pixbuf = pxb + (((size_t)pxb % 16) ? (16 - ((size_t)pxb % 16)) : 0);
     af7:	48 8d 45 90          	lea    rax,[rbp-0x70]
     afb:	83 e0 0f             	and    eax,0xf
     afe:	48 85 c0             	test   rax,rax
     b01:	74 14                	je     b17 <render_text_scanline_24btpp_sse+0x98>
     b03:	48 8d 45 90          	lea    rax,[rbp-0x70]
     b07:	83 e0 0f             	and    eax,0xf
     b0a:	48 89 c2             	mov    rdx,rax
     b0d:	b8 10 00 00 00       	mov    eax,0x10
     b12:	48 29 d0             	sub    rax,rdx
     b15:	eb 05                	jmp    b1c <render_text_scanline_24btpp_sse+0x9d>
     b17:	b8 00 00 00 00       	mov    eax,0x0
     b1c:	48 8d 55 90          	lea    rdx,[rbp-0x70]
     b20:	48 01 d0             	add    rax,rdx
     b23:	48 89 45 88          	mov    QWORD PTR [rbp-0x78],rax
		ssize_t bt_ofs = 0; /* used to control writing into pixbuf (1/3 pixels)*/
     b27:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		/* 64-bit aligned moves are enough */

		if (misalign) { /* LFB is dword aligned, we want (dq/o)word access */
     b2e:	83 7d e4 00          	cmp    DWORD PTR [rbp-0x1c],0x0
     b32:	0f 84 42 05 00 00    	je     107a <render_text_scanline_24btpp_sse+0x5fb>
				int col = p0_x / 8, inv = (col == cur_x);
     b38:	8b 85 5c ff ff ff    	mov    eax,DWORD PTR [rbp-0xa4]
     b3e:	8d 50 07             	lea    edx,[rax+0x7]
     b41:	85 c0                	test   eax,eax
     b43:	0f 48 c2             	cmovs  eax,edx
     b46:	c1 f8 03             	sar    eax,0x3
     b49:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
     b4c:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
     b4f:	3b 85 60 ff ff ff    	cmp    eax,DWORD PTR [rbp-0xa0]
     b55:	0f 94 c0             	sete   al
     b58:	0f b6 c0             	movzx  eax,al
     b5b:	89 45 d8             	mov    DWORD PTR [rbp-0x28],eax
				ssize_t bc = min(misalign, 3 * px_x);
     b5e:	8b 95 64 ff ff ff    	mov    edx,DWORD PTR [rbp-0x9c]
     b64:	89 d0                	mov    eax,edx
     b66:	01 c0                	add    eax,eax
     b68:	01 d0                	add    eax,edx
     b6a:	8b 55 e4             	mov    edx,DWORD PTR [rbp-0x1c]
     b6d:	39 c2                	cmp    edx,eax
     b6f:	0f 4e c2             	cmovle eax,edx
     b72:	89 45 d4             	mov    DWORD PTR [rbp-0x2c],eax
				ssize_t cc = rdiv(bc, 3);
     b75:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
     b78:	48 63 d0             	movsxd rdx,eax
     b7b:	48 69 d2 56 55 55 55 	imul   rdx,rdx,0x55555556
     b82:	48 c1 ea 20          	shr    rdx,0x20
     b86:	c1 f8 1f             	sar    eax,0x1f
     b89:	89 d6                	mov    esi,edx
     b8b:	29 c6                	sub    esi,eax
     b8d:	8b 4d d4             	mov    ecx,DWORD PTR [rbp-0x2c]
     b90:	48 63 c1             	movsxd rax,ecx
     b93:	48 69 c0 56 55 55 55 	imul   rax,rax,0x55555556
     b9a:	48 c1 e8 20          	shr    rax,0x20
     b9e:	48 89 c2             	mov    rdx,rax
     ba1:	89 c8                	mov    eax,ecx
     ba3:	c1 f8 1f             	sar    eax,0x1f
     ba6:	29 c2                	sub    edx,eax
     ba8:	89 d0                	mov    eax,edx
     baa:	01 c0                	add    eax,eax
     bac:	01 d0                	add    eax,edx
     bae:	29 c1                	sub    ecx,eax
     bb0:	89 ca                	mov    edx,ecx
     bb2:	85 d2                	test   edx,edx
     bb4:	0f 95 c0             	setne  al
     bb7:	0f b6 c0             	movzx  eax,al
     bba:	01 f0                	add    eax,esi
     bbc:	89 45 d0             	mov    DWORD PTR [rbp-0x30],eax
				ssize_t rmax = min(8, r + cc), cc1 = rmax - r;
     bbf:	8b 55 e0             	mov    edx,DWORD PTR [rbp-0x20]
     bc2:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
     bc5:	01 d0                	add    eax,edx
     bc7:	ba 08 00 00 00       	mov    edx,0x8
     bcc:	39 d0                	cmp    eax,edx
     bce:	0f 4f c2             	cmovg  eax,edx
     bd1:	89 45 cc             	mov    DWORD PTR [rbp-0x34],eax
     bd4:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
     bd7:	2b 45 e0             	sub    eax,DWORD PTR [rbp-0x20]
     bda:	89 45 c8             	mov    DWORD PTR [rbp-0x38],eax

				generate_char_colors(font, str[0], str[1], 24,
     bdd:	48 8b 4d 88          	mov    rcx,QWORD PTR [rbp-0x78]
     be1:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     be8:	48 83 c0 01          	add    rax,0x1
     bec:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     bef:	0f be d0             	movsx  edx,al
     bf2:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     bf9:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     bfc:	0f be f0             	movsx  esi,al
     bff:	44 8b 4d cc          	mov    r9d,DWORD PTR [rbp-0x34]
     c03:	44 8b 45 e0          	mov    r8d,DWORD PTR [rbp-0x20]
     c07:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     c0e:	8b 7d d8             	mov    edi,DWORD PTR [rbp-0x28]
     c11:	89 7c 24 08          	mov    DWORD PTR [rsp+0x8],edi
     c15:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
     c19:	b9 18 00 00 00       	mov    ecx,0x18
     c1e:	48 89 c7             	mov    rdi,rax
     c21:	e8 00 00 00 00       	call   c26 <render_text_scanline_24btpp_sse+0x1a7>
								r, rmax, pixbuf, inv);
				if (rmax == 8)
     c26:	83 7d cc 08          	cmp    DWORD PTR [rbp-0x34],0x8
     c2a:	75 08                	jne    c34 <render_text_scanline_24btpp_sse+0x1b5>
						str += 2;
     c2c:	48 83 85 70 ff ff ff 02 	add    QWORD PTR [rbp-0x90],0x2
				if (cc > cc1) { /* generate the new char */
     c34:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
     c37:	3b 45 c8             	cmp    eax,DWORD PTR [rbp-0x38]
     c3a:	7e 78                	jle    cb4 <render_text_scanline_24btpp_sse+0x235>
						col++; inv = (col == cur_x);
     c3c:	83 45 dc 01          	add    DWORD PTR [rbp-0x24],0x1
     c40:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
     c43:	3b 85 60 ff ff ff    	cmp    eax,DWORD PTR [rbp-0xa0]
     c49:	0f 94 c0             	sete   al
     c4c:	0f b6 c0             	movzx  eax,al
     c4f:	89 45 d8             	mov    DWORD PTR [rbp-0x28],eax
						generate_char_colors(font, str[0], str[1], 24,
     c52:	48 8b 4d 88          	mov    rcx,QWORD PTR [rbp-0x78]
										0, cc - cc1, pixbuf + cc1 * 3, inv);
     c56:	8b 55 c8             	mov    edx,DWORD PTR [rbp-0x38]
     c59:	89 d0                	mov    eax,edx
     c5b:	01 c0                	add    eax,eax
     c5d:	01 d0                	add    eax,edx
     c5f:	48 98                	cdqe
						generate_char_colors(font, str[0], str[1], 24,
     c61:	48 8d 3c 01          	lea    rdi,[rcx+rax*1]
     c65:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
     c68:	2b 45 c8             	sub    eax,DWORD PTR [rbp-0x38]
     c6b:	41 89 c0             	mov    r8d,eax
     c6e:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     c75:	48 83 c0 01          	add    rax,0x1
     c79:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     c7c:	0f be d0             	movsx  edx,al
     c7f:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     c86:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     c89:	0f be f0             	movsx  esi,al
     c8c:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     c93:	8b 4d d8             	mov    ecx,DWORD PTR [rbp-0x28]
     c96:	89 4c 24 08          	mov    DWORD PTR [rsp+0x8],ecx
     c9a:	48 89 3c 24          	mov    QWORD PTR [rsp],rdi
     c9e:	45 89 c1             	mov    r9d,r8d
     ca1:	41 b8 00 00 00 00    	mov    r8d,0x0
     ca7:	b9 18 00 00 00       	mov    ecx,0x18
     cac:	48 89 c7             	mov    rdi,rax
     caf:	e8 00 00 00 00       	call   cb4 <render_text_scanline_24btpp_sse+0x235>
				}
				memcpy(mem, pixbuf, bc);
     cb4:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
     cb7:	48 63 d0             	movsxd rdx,eax
     cba:	48 8b 4d 88          	mov    rcx,QWORD PTR [rbp-0x78]
     cbe:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     cc5:	48 89 ce             	mov    rsi,rcx
     cc8:	48 89 c7             	mov    rdi,rax
     ccb:	e8 30 f3 ff ff       	call   0 <memcpy>
				/* now indicate the remaining pixel part if there and
				 * copy the data to the front for the later transfer */
				if (bc % 3) {
     cd0:	8b 4d d4             	mov    ecx,DWORD PTR [rbp-0x2c]
     cd3:	48 63 c1             	movsxd rax,ecx
     cd6:	48 69 c0 56 55 55 55 	imul   rax,rax,0x55555556
     cdd:	48 c1 e8 20          	shr    rax,0x20
     ce1:	48 89 c2             	mov    rdx,rax
     ce4:	89 c8                	mov    eax,ecx
     ce6:	c1 f8 1f             	sar    eax,0x1f
     ce9:	29 c2                	sub    edx,eax
     ceb:	89 d0                	mov    eax,edx
     ced:	01 c0                	add    eax,eax
     cef:	01 d0                	add    eax,edx
     cf1:	29 c1                	sub    ecx,eax
     cf3:	89 ca                	mov    edx,ecx
     cf5:	85 d2                	test   edx,edx
     cf7:	74 30                	je     d29 <render_text_scanline_24btpp_sse+0x2aa>
						bt_ofs = 3 * cc - bc;
     cf9:	8b 55 d0             	mov    edx,DWORD PTR [rbp-0x30]
     cfc:	89 d0                	mov    eax,edx
     cfe:	01 c0                	add    eax,eax
     d00:	01 d0                	add    eax,edx
     d02:	2b 45 d4             	sub    eax,DWORD PTR [rbp-0x2c]
     d05:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
						memcpy(pixbuf, pixbuf + bc, bt_ofs);
     d08:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     d0b:	48 63 d0             	movsxd rdx,eax
     d0e:	48 8b 4d 88          	mov    rcx,QWORD PTR [rbp-0x78]
     d12:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
     d15:	48 98                	cdqe
     d17:	48 01 c1             	add    rcx,rax
     d1a:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
     d1e:	48 89 ce             	mov    rsi,rcx
     d21:	48 89 c7             	mov    rdi,rax
     d24:	e8 d7 f2 ff ff       	call   0 <memcpy>
						/* no bt_ofs pixels from this pixel are left in pixbuf */
				}
				px_x -= cc;
     d29:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
     d2c:	29 85 64 ff ff ff    	sub    DWORD PTR [rbp-0x9c],eax
				p0_x += cc;
     d32:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
     d35:	01 85 5c ff ff ff    	add    DWORD PTR [rbp-0xa4],eax
				mem += misalign; /* safer than bc */
     d3b:	48 8b 95 68 ff ff ff 	mov    rdx,QWORD PTR [rbp-0x98]
     d42:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     d45:	48 98                	cdqe
     d47:	48 01 d0             	add    rax,rdx
     d4a:	48 89 85 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rax
		}

		/* draw 5 2/3 pixels each (6,5,5) */
		while (px_x) { /* 144 bit vs. 128 16bt remain (2/3) */
     d51:	e9 24 03 00 00       	jmp    107a <render_text_scanline_24btpp_sse+0x5fb>
				int col = p0_x / 8, inv = (col == cur_x);
     d56:	8b 85 5c ff ff ff    	mov    eax,DWORD PTR [rbp-0xa4]
     d5c:	8d 50 07             	lea    edx,[rax+0x7]
     d5f:	85 c0                	test   eax,eax
     d61:	0f 48 c2             	cmovs  eax,edx
     d64:	c1 f8 03             	sar    eax,0x3
     d67:	89 45 c4             	mov    DWORD PTR [rbp-0x3c],eax
     d6a:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
     d6d:	3b 85 60 ff ff ff    	cmp    eax,DWORD PTR [rbp-0xa0]
     d73:	0f 94 c0             	sete   al
     d76:	0f b6 c0             	movzx  eax,al
     d79:	89 45 c0             	mov    DWORD PTR [rbp-0x40],eax
				ssize_t cc = min(bt_ofs ? 5 : 6, px_x), cc1; /* 655 */
     d7c:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
     d80:	74 07                	je     d89 <render_text_scanline_24btpp_sse+0x30a>
     d82:	b8 05 00 00 00       	mov    eax,0x5
     d87:	eb 05                	jmp    d8e <render_text_scanline_24btpp_sse+0x30f>
     d89:	b8 06 00 00 00       	mov    eax,0x6
     d8e:	8b 95 64 ff ff ff    	mov    edx,DWORD PTR [rbp-0x9c]
     d94:	39 d0                	cmp    eax,edx
     d96:	0f 4f c2             	cmovg  eax,edx
     d99:	89 45 bc             	mov    DWORD PTR [rbp-0x44],eax
				ssize_t rmax, bitc, btt = min(128, 24 * px_x + 8 * bt_ofs);
     d9c:	8b 95 64 ff ff ff    	mov    edx,DWORD PTR [rbp-0x9c]
     da2:	89 d0                	mov    eax,edx
     da4:	01 c0                	add    eax,eax
     da6:	01 c2                	add    edx,eax
     da8:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     dab:	01 d0                	add    eax,edx
     dad:	c1 e0 03             	shl    eax,0x3
     db0:	ba 80 00 00 00       	mov    edx,0x80
     db5:	39 d0                	cmp    eax,edx
     db7:	0f 4f c2             	cmovg  eax,edx
     dba:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
				r = p0_x % 8;
     dbd:	8b 95 5c ff ff ff    	mov    edx,DWORD PTR [rbp-0xa4]
     dc3:	89 d0                	mov    eax,edx
     dc5:	c1 f8 1f             	sar    eax,0x1f
     dc8:	c1 e8 1d             	shr    eax,0x1d
     dcb:	01 c2                	add    edx,eax
     dcd:	83 e2 07             	and    edx,0x7
     dd0:	29 c2                	sub    edx,eax
     dd2:	89 55 e0             	mov    DWORD PTR [rbp-0x20],edx
				rmax = min(8, r + cc); /* only up to 6 pixels */
     dd5:	8b 55 e0             	mov    edx,DWORD PTR [rbp-0x20]
     dd8:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44]
     ddb:	01 d0                	add    eax,edx
     ddd:	ba 08 00 00 00       	mov    edx,0x8
     de2:	39 d0                	cmp    eax,edx
     de4:	0f 4f c2             	cmovg  eax,edx
     de7:	89 45 b8             	mov    DWORD PTR [rbp-0x48],eax
				/* get the remaining character pixels */
				bitc = generate_char_colors(font, str[0], str[1], 24,
     dea:	48 8b 55 88          	mov    rdx,QWORD PTR [rbp-0x78]
     dee:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     df1:	48 98                	cdqe
     df3:	48 8d 3c 02          	lea    rdi,[rdx+rax*1]
     df7:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     dfe:	48 83 c0 01          	add    rax,0x1
     e02:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     e05:	0f be d0             	movsx  edx,al
     e08:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     e0f:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     e12:	0f be f0             	movsx  esi,al
     e15:	44 8b 4d b8          	mov    r9d,DWORD PTR [rbp-0x48]
     e19:	44 8b 45 e0          	mov    r8d,DWORD PTR [rbp-0x20]
     e1d:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     e24:	8b 4d c0             	mov    ecx,DWORD PTR [rbp-0x40]
     e27:	89 4c 24 08          	mov    DWORD PTR [rsp+0x8],ecx
     e2b:	48 89 3c 24          	mov    QWORD PTR [rsp],rdi
     e2f:	b9 18 00 00 00       	mov    ecx,0x18
     e34:	48 89 c7             	mov    rdi,rax
     e37:	e8 00 00 00 00       	call   e3c <render_text_scanline_24btpp_sse+0x3bd>
     e3c:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
								r, rmax, pixbuf + bt_ofs, inv);
				cc1 = rmax - r;
     e3f:	8b 45 b8             	mov    eax,DWORD PTR [rbp-0x48]
     e42:	2b 45 e0             	sub    eax,DWORD PTR [rbp-0x20]
     e45:	89 45 b4             	mov    DWORD PTR [rbp-0x4c],eax
				/* now advance if neccessary */
				if (rmax == 8)
     e48:	83 7d b8 08          	cmp    DWORD PTR [rbp-0x48],0x8
     e4c:	75 08                	jne    e56 <render_text_scanline_24btpp_sse+0x3d7>
						str += 2;
     e4e:	48 83 85 70 ff ff ff 02 	add    QWORD PTR [rbp-0x90],0x2
				/* and fetch up to five more pixels if needed (r=0) */
				if (cc > cc1) {
     e56:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44]
     e59:	3b 45 b4             	cmp    eax,DWORD PTR [rbp-0x4c]
     e5c:	0f 8e 84 00 00 00    	jle    ee6 <render_text_scanline_24btpp_sse+0x467>
						col++; inv = (col == cur_x);
     e62:	83 45 c4 01          	add    DWORD PTR [rbp-0x3c],0x1
     e66:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
     e69:	3b 85 60 ff ff ff    	cmp    eax,DWORD PTR [rbp-0xa0]
     e6f:	0f 94 c0             	sete   al
     e72:	0f b6 c0             	movzx  eax,al
     e75:	89 45 c0             	mov    DWORD PTR [rbp-0x40],eax
						bitc += generate_char_colors(font, str[0], str[1], 24,
     e78:	48 8b 4d 88          	mov    rcx,QWORD PTR [rbp-0x78]
										0, cc - cc1, pixbuf + bt_ofs + cc1 * 3, inv);
     e7c:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     e7f:	48 63 f0             	movsxd rsi,eax
     e82:	8b 55 b4             	mov    edx,DWORD PTR [rbp-0x4c]
     e85:	89 d0                	mov    eax,edx
     e87:	01 c0                	add    eax,eax
     e89:	01 d0                	add    eax,edx
     e8b:	48 98                	cdqe
     e8d:	48 01 f0             	add    rax,rsi
						bitc += generate_char_colors(font, str[0], str[1], 24,
     e90:	48 8d 3c 01          	lea    rdi,[rcx+rax*1]
     e94:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44]
     e97:	2b 45 b4             	sub    eax,DWORD PTR [rbp-0x4c]
     e9a:	41 89 c0             	mov    r8d,eax
     e9d:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     ea4:	48 83 c0 01          	add    rax,0x1
     ea8:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     eab:	0f be d0             	movsx  edx,al
     eae:	48 8b 85 70 ff ff ff 	mov    rax,QWORD PTR [rbp-0x90]
     eb5:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     eb8:	0f be f0             	movsx  esi,al
     ebb:	48 8b 85 78 ff ff ff 	mov    rax,QWORD PTR [rbp-0x88]
     ec2:	8b 4d c0             	mov    ecx,DWORD PTR [rbp-0x40]
     ec5:	89 4c 24 08          	mov    DWORD PTR [rsp+0x8],ecx
     ec9:	48 89 3c 24          	mov    QWORD PTR [rsp],rdi
     ecd:	45 89 c1             	mov    r9d,r8d
     ed0:	41 b8 00 00 00 00    	mov    r8d,0x0
     ed6:	b9 18 00 00 00       	mov    ecx,0x18
     edb:	48 89 c7             	mov    rdi,rax
     ede:	e8 00 00 00 00       	call   ee3 <render_text_scanline_24btpp_sse+0x464>
     ee3:	01 45 f8             	add    DWORD PTR [rbp-0x8],eax
				}
				/* now transfer */
				if (btt >= 128) {
     ee6:	83 7d f4 7f          	cmp    DWORD PTR [rbp-0xc],0x7f
     eea:	7e 35                	jle    f21 <render_text_scanline_24btpp_sse+0x4a2>
						move_128(pixbuf, mem);
     eec:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
     ef0:	48 8b 95 68 ff ff ff 	mov    rdx,QWORD PTR [rbp-0x98]
     ef7:	0f 28 00             	movaps xmm0,XMMWORD PTR [rax]
     efa:	0f 29 02             	movaps XMMWORD PTR [rdx],xmm0
						mem += 16;
     efd:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     f04:	48 83 c0 10          	add    rax,0x10
     f08:	48 89 85 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rax
						}
						break;
				}

				/* and don't advance as r = 0 is already handled (sth. remains) */
				if (px_x) {
     f0f:	83 bd 64 ff ff ff 00 	cmp    DWORD PTR [rbp-0x9c],0x0
     f16:	0f 84 6d 01 00 00    	je     1089 <render_text_scanline_24btpp_sse+0x60a>
     f1c:	e9 16 01 00 00       	jmp    1037 <render_text_scanline_24btpp_sse+0x5b8>
						uint8_t* pt = pixbuf;
     f21:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
     f25:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
						if (btt >= 64) {
     f29:	83 7d f4 3f          	cmp    DWORD PTR [rbp-0xc],0x3f
     f2d:	7e 2c                	jle    f5b <render_text_scanline_24btpp_sse+0x4dc>
								move_64(pixbuf, mem);
     f2f:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
     f33:	48 8b 95 68 ff ff ff 	mov    rdx,QWORD PTR [rbp-0x98]
     f3a:	0f 6f 00             	movq   mm0,QWORD PTR [rax]
     f3d:	0f 7f 02             	movq   QWORD PTR [rdx],mm0
								pt += 8;
     f40:	48 83 45 e8 08       	add    QWORD PTR [rbp-0x18],0x8
								mem += 8;
     f45:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     f4c:	48 83 c0 08          	add    rax,0x8
     f50:	48 89 85 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rax
								btt -= 64;
     f57:	83 6d f4 40          	sub    DWORD PTR [rbp-0xc],0x40
						if (btt >= 32) {
     f5b:	83 7d f4 1f          	cmp    DWORD PTR [rbp-0xc],0x1f
     f5f:	7e 2f                	jle    f90 <render_text_scanline_24btpp_sse+0x511>
								*(uint32_t*)mem = *(uint32_t*)pt;
     f61:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     f68:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     f6c:	8b 12                	mov    edx,DWORD PTR [rdx]
     f6e:	89 10                	mov    DWORD PTR [rax],edx
								pt += 4;
     f70:	48 83 45 e8 04       	add    QWORD PTR [rbp-0x18],0x4
								mem += 4;
     f75:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     f7c:	48 83 c0 04          	add    rax,0x4
     f80:	48 89 85 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rax
								btt -= 32;
     f87:	83 6d f4 20          	sub    DWORD PTR [rbp-0xc],0x20
						break;
     f8b:	e9 fc 00 00 00       	jmp    108c <render_text_scanline_24btpp_sse+0x60d>
						} else if (btt >= 16) {
     f90:	83 7d f4 0f          	cmp    DWORD PTR [rbp-0xc],0xf
     f94:	7e 31                	jle    fc7 <render_text_scanline_24btpp_sse+0x548>
								*(uint16_t*)mem = *(uint16_t*)pt;
     f96:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     f9d:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     fa1:	0f b7 12             	movzx  edx,WORD PTR [rdx]
     fa4:	66 89 10             	mov    WORD PTR [rax],dx
								pt += 2;
     fa7:	48 83 45 e8 02       	add    QWORD PTR [rbp-0x18],0x2
								mem += 2;
     fac:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     fb3:	48 83 c0 02          	add    rax,0x2
     fb7:	48 89 85 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rax
								btt -= 16;
     fbe:	83 6d f4 10          	sub    DWORD PTR [rbp-0xc],0x10
						break;
     fc2:	e9 c5 00 00 00       	jmp    108c <render_text_scanline_24btpp_sse+0x60d>
						} else if (bitc >= 8) {
     fc7:	83 7d f8 07          	cmp    DWORD PTR [rbp-0x8],0x7
     fcb:	7e 30                	jle    ffd <render_text_scanline_24btpp_sse+0x57e>
								*(uint8_t*)mem = *(uint8_t*)pt;
     fcd:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     fd4:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     fd8:	0f b6 12             	movzx  edx,BYTE PTR [rdx]
     fdb:	88 10                	mov    BYTE PTR [rax],dl
								pt += 1;
     fdd:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
								mem += 1;
     fe2:	48 8b 85 68 ff ff ff 	mov    rax,QWORD PTR [rbp-0x98]
     fe9:	48 83 c0 01          	add    rax,0x1
     fed:	48 89 85 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rax
								btt -= 8;
     ff4:	83 6d f4 08          	sub    DWORD PTR [rbp-0xc],0x8
						break;
     ff8:	e9 8f 00 00 00       	jmp    108c <render_text_scanline_24btpp_sse+0x60d>
						} else if (bitc) {
     ffd:	83 7d f8 00          	cmp    DWORD PTR [rbp-0x8],0x0
    1001:	0f 84 85 00 00 00    	je     108c <render_text_scanline_24btpp_sse+0x60d>
								die("can't happen with 3byte sized pixels\n");
    1007:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    100e:	bf 0c 00 00 00       	mov    edi,0xc
    1013:	b8 00 00 00 00       	mov    eax,0x0
    1018:	e8 00 00 00 00       	call   101d <render_text_scanline_24btpp_sse+0x59e>
    101d:	b8 00 00 00 00       	mov    eax,0x0
    1022:	e8 00 00 00 00       	call   1027 <render_text_scanline_24btpp_sse+0x5a8>
    1027:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    102e:	e8 00 00 00 00       	call   1033 <render_text_scanline_24btpp_sse+0x5b4>
    1033:	fa                   	cli
    1034:	f4                   	hlt
    1035:	eb fd                	jmp    1034 <render_text_scanline_24btpp_sse+0x5b5>
						px_x -= cc; /* bitc is 24-divisible */
    1037:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44]
    103a:	29 85 64 ff ff ff    	sub    DWORD PTR [rbp-0x9c],eax
						p0_x += cc; /* unneccessary as r does not change anymore */
    1040:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44]
    1043:	01 85 5c ff ff ff    	add    DWORD PTR [rbp-0xa4],eax
						/* copy remaining data */
						/* |bt_ofs*8-bitc| */
						if (!bt_ofs--)
    1049:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    104c:	8d 50 ff             	lea    edx,[rax-0x1]
    104f:	89 55 fc             	mov    DWORD PTR [rbp-0x4],edx
    1052:	85 c0                	test   eax,eax
    1054:	75 07                	jne    105d <render_text_scanline_24btpp_sse+0x5de>
								bt_ofs = 2;
    1056:	c7 45 fc 02 00 00 00 	mov    DWORD PTR [rbp-0x4],0x2
						memcpy(pixbuf, pixbuf + 16, bt_ofs);
    105d:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1060:	48 63 d0             	movsxd rdx,eax
    1063:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1067:	48 8d 48 10          	lea    rcx,[rax+0x10]
    106b:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    106f:	48 89 ce             	mov    rsi,rcx
    1072:	48 89 c7             	mov    rdi,rax
    1075:	e8 86 ef ff ff       	call   0 <memcpy>
		while (px_x) { /* 144 bit vs. 128 16bt remain (2/3) */
    107a:	83 bd 64 ff ff ff 00 	cmp    DWORD PTR [rbp-0x9c],0x0
    1081:	0f 85 cf fc ff ff    	jne    d56 <render_text_scanline_24btpp_sse+0x2d7>
    1087:	eb 04                	jmp    108d <render_text_scanline_24btpp_sse+0x60e>
				} else
						break;
    1089:	90                   	nop
    108a:	eb 01                	jmp    108d <render_text_scanline_24btpp_sse+0x60e>
						break;
    108c:	90                   	nop
		}

		/* transfer the leftover pixel data */
		if (bt_ofs)
    108d:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
    1091:	74 1c                	je     10af <render_text_scanline_24btpp_sse+0x630>
				memcpy(pixbuf, mem, bt_ofs);
    1093:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1096:	48 63 d0             	movsxd rdx,eax
    1099:	48 8b 8d 68 ff ff ff 	mov    rcx,QWORD PTR [rbp-0x98]
    10a0:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    10a4:	48 89 ce             	mov    rsi,rcx
    10a7:	48 89 c7             	mov    rdi,rax
    10aa:	e8 51 ef ff ff       	call   0 <memcpy>
}
    10af:	90                   	nop
    10b0:	c9                   	leave
    10b1:	c3                   	ret

00000000000010b2 <render_text_scanline_16btpp>:

/* we're generating 2byte colorvalues /w unknown alignment. To enable
 * 8 byte transfer, four pixels have to be generated. */
void render_text_scanline_16btpp(const char* font, char* str, void* mem,
				ssize_t px_x, ssize_t cur_x, ssize_t p0_x, size_t btpp)
{
    10b2:	55                   	push   rbp
    10b3:	48 89 e5             	mov    rbp,rsp
    10b6:	48 81 ec a0 00 00 00 	sub    rsp,0xa0
    10bd:	48 89 7d 98          	mov    QWORD PTR [rbp-0x68],rdi
    10c1:	48 89 75 90          	mov    QWORD PTR [rbp-0x70],rsi
    10c5:	48 89 55 88          	mov    QWORD PTR [rbp-0x78],rdx
    10c9:	89 4d 84             	mov    DWORD PTR [rbp-0x7c],ecx
    10cc:	44 89 45 80          	mov    DWORD PTR [rbp-0x80],r8d
    10d0:	44 89 8d 7c ff ff ff 	mov    DWORD PTR [rbp-0x84],r9d
		uint8_t pxb[8 + 7]; /* 7 for stack alignment */
		ssize_t misalign = ((size_t)mem % 8) ? (8 - (size_t)mem % 8) : 0;
    10d7:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    10db:	83 e0 07             	and    eax,0x7
    10de:	48 85 c0             	test   rax,rax
    10e1:	74 12                	je     10f5 <render_text_scanline_16btpp+0x43>
    10e3:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    10e7:	83 e0 07             	and    eax,0x7
    10ea:	ba 08 00 00 00       	mov    edx,0x8
    10ef:	29 c2                	sub    edx,eax
    10f1:	89 d0                	mov    eax,edx
    10f3:	eb 05                	jmp    10fa <render_text_scanline_16btpp+0x48>
    10f5:	b8 00 00 00 00       	mov    eax,0x0
    10fa:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
		ssize_t r = p0_x % 8;
    10fd:	8b 95 7c ff ff ff    	mov    edx,DWORD PTR [rbp-0x84]
    1103:	89 d0                	mov    eax,edx
    1105:	c1 f8 1f             	sar    eax,0x1f
    1108:	c1 e8 1d             	shr    eax,0x1d
    110b:	01 c2                	add    edx,eax
    110d:	83 e2 07             	and    edx,0x7
    1110:	29 c2                	sub    edx,eax
    1112:	89 55 e8             	mov    DWORD PTR [rbp-0x18],edx
		uint8_t* pixbuf = pxb + (((size_t)pxb % 8) ? (8 - ((size_t)pxb % 8)) : 0);
    1115:	48 8d 45 b1          	lea    rax,[rbp-0x4f]
    1119:	83 e0 07             	and    eax,0x7
    111c:	48 85 c0             	test   rax,rax
    111f:	74 14                	je     1135 <render_text_scanline_16btpp+0x83>
    1121:	48 8d 45 b1          	lea    rax,[rbp-0x4f]
    1125:	83 e0 07             	and    eax,0x7
    1128:	48 89 c2             	mov    rdx,rax
    112b:	b8 08 00 00 00       	mov    eax,0x8
    1130:	48 29 d0             	sub    rax,rdx
    1133:	eb 05                	jmp    113a <render_text_scanline_16btpp+0x88>
    1135:	b8 00 00 00 00       	mov    eax,0x0
    113a:	48 8d 55 b1          	lea    rdx,[rbp-0x4f]
    113e:	48 01 d0             	add    rax,rdx
    1141:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
		/* 64-bit aligned moves are enough */

		if (misalign) { /* LFB is dword aligned, we want qword access */
    1145:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
    1149:	0f 84 86 03 00 00    	je     14d5 <render_text_scanline_16btpp+0x423>
				int col = p0_x / 8, inv = (col == cur_x);
    114f:	8b 85 7c ff ff ff    	mov    eax,DWORD PTR [rbp-0x84]
    1155:	8d 50 07             	lea    edx,[rax+0x7]
    1158:	85 c0                	test   eax,eax
    115a:	0f 48 c2             	cmovs  eax,edx
    115d:	c1 f8 03             	sar    eax,0x3
    1160:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
    1163:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    1166:	3b 45 80             	cmp    eax,DWORD PTR [rbp-0x80]
    1169:	0f 94 c0             	sete   al
    116c:	0f b6 c0             	movzx  eax,al
    116f:	89 45 e0             	mov    DWORD PTR [rbp-0x20],eax
				ssize_t bc = min(misalign, 2 * px_x);
    1172:	8b 45 84             	mov    eax,DWORD PTR [rbp-0x7c]
    1175:	01 c0                	add    eax,eax
    1177:	8b 55 ec             	mov    edx,DWORD PTR [rbp-0x14]
    117a:	39 c2                	cmp    edx,eax
    117c:	0f 4e c2             	cmovle eax,edx
    117f:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
				ssize_t cc = rdiv(misalign, 2);
    1182:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    1185:	89 c2                	mov    edx,eax
    1187:	c1 ea 1f             	shr    edx,0x1f
    118a:	01 d0                	add    eax,edx
    118c:	d1 f8                	sar    eax,1
    118e:	89 c2                	mov    edx,eax
    1190:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    1193:	83 e0 01             	and    eax,0x1
    1196:	01 d0                	add    eax,edx
    1198:	89 45 d8             	mov    DWORD PTR [rbp-0x28],eax
				ssize_t rmax = min(8, r + cc), cc1 = rmax - r;
    119b:	8b 55 e8             	mov    edx,DWORD PTR [rbp-0x18]
    119e:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    11a1:	01 d0                	add    eax,edx
    11a3:	ba 08 00 00 00       	mov    edx,0x8
    11a8:	39 d0                	cmp    eax,edx
    11aa:	0f 4f c2             	cmovg  eax,edx
    11ad:	89 45 d4             	mov    DWORD PTR [rbp-0x2c],eax
    11b0:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
    11b3:	2b 45 e8             	sub    eax,DWORD PTR [rbp-0x18]
    11b6:	89 45 d0             	mov    DWORD PTR [rbp-0x30],eax

				generate_char_colors(font, str[0], str[1], btpp,
    11b9:	48 8b 7d a8          	mov    rdi,QWORD PTR [rbp-0x58]
    11bd:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    11c1:	48 83 c0 01          	add    rax,0x1
    11c5:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    11c8:	0f be d0             	movsx  edx,al
    11cb:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    11cf:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    11d2:	0f be f0             	movsx  esi,al
    11d5:	44 8b 4d d4          	mov    r9d,DWORD PTR [rbp-0x2c]
    11d9:	44 8b 55 e8          	mov    r10d,DWORD PTR [rbp-0x18]
    11dd:	48 8b 4d 10          	mov    rcx,QWORD PTR [rbp+0x10]
    11e1:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    11e5:	44 8b 45 e0          	mov    r8d,DWORD PTR [rbp-0x20]
    11e9:	44 89 44 24 08       	mov    DWORD PTR [rsp+0x8],r8d
    11ee:	48 89 3c 24          	mov    QWORD PTR [rsp],rdi
    11f2:	45 89 d0             	mov    r8d,r10d
    11f5:	48 89 c7             	mov    rdi,rax
    11f8:	e8 00 00 00 00       	call   11fd <render_text_scanline_16btpp+0x14b>
								r, rmax, pixbuf, inv);
				if (rmax == 8)
    11fd:	83 7d d4 08          	cmp    DWORD PTR [rbp-0x2c],0x8
    1201:	75 05                	jne    1208 <render_text_scanline_16btpp+0x156>
						str += 2;
    1203:	48 83 45 90 02       	add    QWORD PTR [rbp-0x70],0x2
				if (cc > cc1) {
    1208:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    120b:	3b 45 d0             	cmp    eax,DWORD PTR [rbp-0x30]
    120e:	7e 62                	jle    1272 <render_text_scanline_16btpp+0x1c0>
						col++; inv = (col == cur_x);
    1210:	83 45 e4 01          	add    DWORD PTR [rbp-0x1c],0x1
    1214:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    1217:	3b 45 80             	cmp    eax,DWORD PTR [rbp-0x80]
    121a:	0f 94 c0             	sete   al
    121d:	0f b6 c0             	movzx  eax,al
    1220:	89 45 e0             	mov    DWORD PTR [rbp-0x20],eax
						generate_char_colors(font, str[0], str[1], btpp,
    1223:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1227:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
    122a:	48 98                	cdqe
    122c:	4c 8d 04 02          	lea    r8,[rdx+rax*1]
    1230:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    1233:	2b 45 d0             	sub    eax,DWORD PTR [rbp-0x30]
    1236:	41 89 c1             	mov    r9d,eax
    1239:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    123d:	48 83 c0 01          	add    rax,0x1
    1241:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1244:	0f be d0             	movsx  edx,al
    1247:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    124b:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    124e:	0f be f0             	movsx  esi,al
    1251:	48 8b 4d 10          	mov    rcx,QWORD PTR [rbp+0x10]
    1255:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1259:	8b 7d e0             	mov    edi,DWORD PTR [rbp-0x20]
    125c:	89 7c 24 08          	mov    DWORD PTR [rsp+0x8],edi
    1260:	4c 89 04 24          	mov    QWORD PTR [rsp],r8
    1264:	41 b8 00 00 00 00    	mov    r8d,0x0
    126a:	48 89 c7             	mov    rdi,rax
    126d:	e8 00 00 00 00       	call   1272 <render_text_scanline_16btpp+0x1c0>
										0, cc - cc1, pixbuf + cc1, inv);
				}
				memcpy(mem, pixbuf, bc);
    1272:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    1275:	48 63 d0             	movsxd rdx,eax
    1278:	48 8b 4d a8          	mov    rcx,QWORD PTR [rbp-0x58]
    127c:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1280:	48 89 ce             	mov    rsi,rcx
    1283:	48 89 c7             	mov    rdi,rax
    1286:	e8 75 ed ff ff       	call   0 <memcpy>
				px_x -= cc;
    128b:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    128e:	29 45 84             	sub    DWORD PTR [rbp-0x7c],eax
				p0_x += cc;
    1291:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    1294:	01 85 7c ff ff ff    	add    DWORD PTR [rbp-0x84],eax
				mem += bc;
    129a:	48 8b 55 88          	mov    rdx,QWORD PTR [rbp-0x78]
    129e:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    12a1:	48 98                	cdqe
    12a3:	48 01 d0             	add    rax,rdx
    12a6:	48 89 45 88          	mov    QWORD PTR [rbp-0x78],rax
		}

		/* draw 4 pixels each */
		while (px_x) {
    12aa:	e9 26 02 00 00       	jmp    14d5 <render_text_scanline_16btpp+0x423>
				int col = p0_x / 8, inv = (col == cur_x);
    12af:	8b 85 7c ff ff ff    	mov    eax,DWORD PTR [rbp-0x84]
    12b5:	8d 50 07             	lea    edx,[rax+0x7]
    12b8:	85 c0                	test   eax,eax
    12ba:	0f 48 c2             	cmovs  eax,edx
    12bd:	c1 f8 03             	sar    eax,0x3
    12c0:	89 45 cc             	mov    DWORD PTR [rbp-0x34],eax
    12c3:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
    12c6:	3b 45 80             	cmp    eax,DWORD PTR [rbp-0x80]
    12c9:	0f 94 c0             	sete   al
    12cc:	0f b6 c0             	movzx  eax,al
    12cf:	89 45 c8             	mov    DWORD PTR [rbp-0x38],eax
				ssize_t rmax, bitc, btt = min(64, 16 * px_x);
    12d2:	8b 45 84             	mov    eax,DWORD PTR [rbp-0x7c]
    12d5:	c1 e0 04             	shl    eax,0x4
    12d8:	ba 40 00 00 00       	mov    edx,0x40
    12dd:	39 d0                	cmp    eax,edx
    12df:	0f 4f c2             	cmovg  eax,edx
    12e2:	89 45 c4             	mov    DWORD PTR [rbp-0x3c],eax
				r = p0_x % 8;
    12e5:	8b 95 7c ff ff ff    	mov    edx,DWORD PTR [rbp-0x84]
    12eb:	89 d0                	mov    eax,edx
    12ed:	c1 f8 1f             	sar    eax,0x1f
    12f0:	c1 e8 1d             	shr    eax,0x1d
    12f3:	01 c2                	add    edx,eax
    12f5:	83 e2 07             	and    edx,0x7
    12f8:	29 c2                	sub    edx,eax
    12fa:	89 55 e8             	mov    DWORD PTR [rbp-0x18],edx
				rmax = min(8, r + min(4, px_x)); /* only 2 pixels */
    12fd:	8b 45 84             	mov    eax,DWORD PTR [rbp-0x7c]
    1300:	ba 04 00 00 00       	mov    edx,0x4
    1305:	39 d0                	cmp    eax,edx
    1307:	0f 4e d0             	cmovle edx,eax
    130a:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    130d:	01 d0                	add    eax,edx
    130f:	ba 08 00 00 00       	mov    edx,0x8
    1314:	39 d0                	cmp    eax,edx
    1316:	0f 4f c2             	cmovg  eax,edx
    1319:	89 45 c0             	mov    DWORD PTR [rbp-0x40],eax
				/* get the remaining character pixels */
				bitc = generate_char_colors(font, str[0], str[1], btpp,
    131c:	48 8b 7d a8          	mov    rdi,QWORD PTR [rbp-0x58]
    1320:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1324:	48 83 c0 01          	add    rax,0x1
    1328:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    132b:	0f be d0             	movsx  edx,al
    132e:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1332:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1335:	0f be f0             	movsx  esi,al
    1338:	44 8b 4d c0          	mov    r9d,DWORD PTR [rbp-0x40]
    133c:	44 8b 55 e8          	mov    r10d,DWORD PTR [rbp-0x18]
    1340:	48 8b 4d 10          	mov    rcx,QWORD PTR [rbp+0x10]
    1344:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1348:	44 8b 45 c8          	mov    r8d,DWORD PTR [rbp-0x38]
    134c:	44 89 44 24 08       	mov    DWORD PTR [rsp+0x8],r8d
    1351:	48 89 3c 24          	mov    QWORD PTR [rsp],rdi
    1355:	45 89 d0             	mov    r8d,r10d
    1358:	48 89 c7             	mov    rdi,rax
    135b:	e8 00 00 00 00       	call   1360 <render_text_scanline_16btpp+0x2ae>
    1360:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
								r, rmax, pixbuf, inv);
				/* now advance if neccessary */
				if (rmax == 8)
    1363:	83 7d c0 08          	cmp    DWORD PTR [rbp-0x40],0x8
    1367:	75 05                	jne    136e <render_text_scanline_16btpp+0x2bc>
						str += 2;
    1369:	48 83 45 90 02       	add    QWORD PTR [rbp-0x70],0x2
				/* and fetch up to three more pixels if needed (r=0) */
				if (bitc < btt) {
    136e:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1371:	3b 45 c4             	cmp    eax,DWORD PTR [rbp-0x3c]
    1374:	7d 7b                	jge    13f1 <render_text_scanline_16btpp+0x33f>
						col++;
    1376:	83 45 cc 01          	add    DWORD PTR [rbp-0x34],0x1
						inv = (col == cur_x);
    137a:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
    137d:	3b 45 80             	cmp    eax,DWORD PTR [rbp-0x80]
    1380:	0f 94 c0             	sete   al
    1383:	0f b6 c0             	movzx  eax,al
    1386:	89 45 c8             	mov    DWORD PTR [rbp-0x38],eax
						bitc += generate_char_colors(font, str[0], str[1], btpp,
    1389:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
										0, (btt - bitc) / 16, pixbuf + bitc / 16, inv);
    138d:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1390:	8d 48 0f             	lea    ecx,[rax+0xf]
    1393:	85 c0                	test   eax,eax
    1395:	0f 48 c1             	cmovs  eax,ecx
    1398:	c1 f8 04             	sar    eax,0x4
    139b:	48 98                	cdqe
						bitc += generate_char_colors(font, str[0], str[1], btpp,
    139d:	4c 8d 04 02          	lea    r8,[rdx+rax*1]
										0, (btt - bitc) / 16, pixbuf + bitc / 16, inv);
    13a1:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    13a4:	2b 45 fc             	sub    eax,DWORD PTR [rbp-0x4]
						bitc += generate_char_colors(font, str[0], str[1], btpp,
    13a7:	8d 50 0f             	lea    edx,[rax+0xf]
    13aa:	85 c0                	test   eax,eax
    13ac:	0f 48 c2             	cmovs  eax,edx
    13af:	c1 f8 04             	sar    eax,0x4
    13b2:	41 89 c1             	mov    r9d,eax
    13b5:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    13b9:	48 83 c0 01          	add    rax,0x1
    13bd:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    13c0:	0f be d0             	movsx  edx,al
    13c3:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    13c7:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    13ca:	0f be f0             	movsx  esi,al
    13cd:	48 8b 4d 10          	mov    rcx,QWORD PTR [rbp+0x10]
    13d1:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    13d5:	8b 7d c8             	mov    edi,DWORD PTR [rbp-0x38]
    13d8:	89 7c 24 08          	mov    DWORD PTR [rsp+0x8],edi
    13dc:	4c 89 04 24          	mov    QWORD PTR [rsp],r8
    13e0:	41 b8 00 00 00 00    	mov    r8d,0x0
    13e6:	48 89 c7             	mov    rdi,rax
    13e9:	e8 00 00 00 00       	call   13ee <render_text_scanline_16btpp+0x33c>
    13ee:	01 45 fc             	add    DWORD PTR [rbp-0x4],eax
				}
				/* now transfer */
				if (bitc >= 64) {
    13f1:	83 7d fc 3f          	cmp    DWORD PTR [rbp-0x4],0x3f
    13f5:	7e 29                	jle    1420 <render_text_scanline_16btpp+0x36e>
						move_64(pixbuf, mem);
    13f7:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    13fb:	48 8b 55 88          	mov    rdx,QWORD PTR [rbp-0x78]
    13ff:	0f 6f 00             	movq   mm0,QWORD PTR [rax]
    1402:	0f 7f 02             	movq   QWORD PTR [rdx],mm0
						mem += 8; /* intentionally no bitc subtract */
    1405:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1409:	48 83 c0 08          	add    rax,0x8
    140d:	48 89 45 88          	mov    QWORD PTR [rbp-0x78],rax
						}
						break;
				}

				/* and don't advance as r = 0 is already handled (sth. remains) */
				if (px_x) {
    1411:	83 7d 84 00          	cmp    DWORD PTR [rbp-0x7c],0x0
    1415:	0f 84 c6 00 00 00    	je     14e1 <render_text_scanline_16btpp+0x42f>
    141b:	e9 8e 00 00 00       	jmp    14ae <render_text_scanline_16btpp+0x3fc>
						void* pt = pixbuf;
    1420:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1424:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
						if (bitc >= 32) {
    1428:	83 7d fc 1f          	cmp    DWORD PTR [rbp-0x4],0x1f
    142c:	7e 21                	jle    144f <render_text_scanline_16btpp+0x39d>
								*(uint32_t*)mem = *(uint32_t*)pixbuf;
    142e:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1432:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1436:	8b 12                	mov    edx,DWORD PTR [rdx]
    1438:	89 10                	mov    DWORD PTR [rax],edx
								mem += 4;
    143a:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    143e:	48 83 c0 04          	add    rax,0x4
    1442:	48 89 45 88          	mov    QWORD PTR [rbp-0x78],rax
								pt += 4;
    1446:	48 83 45 f0 04       	add    QWORD PTR [rbp-0x10],0x4
								bitc -= 32;
    144b:	83 6d fc 20          	sub    DWORD PTR [rbp-0x4],0x20
						if (bitc >= 16) {
    144f:	83 7d fc 0f          	cmp    DWORD PTR [rbp-0x4],0xf
    1453:	7e 1e                	jle    1473 <render_text_scanline_16btpp+0x3c1>
								*(uint32_t*)mem = *(uint32_t*)pt;
    1455:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1459:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    145d:	8b 12                	mov    edx,DWORD PTR [rdx]
    145f:	89 10                	mov    DWORD PTR [rax],edx
								mem += 2;
    1461:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1465:	48 83 c0 02          	add    rax,0x2
    1469:	48 89 45 88          	mov    QWORD PTR [rbp-0x78],rax
								bitc -= 16;
    146d:	83 6d fc 10          	sub    DWORD PTR [rbp-0x4],0x10
						break;
    1471:	eb 71                	jmp    14e4 <render_text_scanline_16btpp+0x432>
						} else if (bitc) {
    1473:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
    1477:	74 6b                	je     14e4 <render_text_scanline_16btpp+0x432>
								die("cant happen with word sized pixels! %d\n", px_x);
    1479:	8b 45 84             	mov    eax,DWORD PTR [rbp-0x7c]
    147c:	89 c2                	mov    edx,eax
    147e:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1485:	bf 0c 00 00 00       	mov    edi,0xc
    148a:	b8 00 00 00 00       	mov    eax,0x0
    148f:	e8 00 00 00 00       	call   1494 <render_text_scanline_16btpp+0x3e2>
    1494:	b8 00 00 00 00       	mov    eax,0x0
    1499:	e8 00 00 00 00       	call   149e <render_text_scanline_16btpp+0x3ec>
    149e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    14a5:	e8 00 00 00 00       	call   14aa <render_text_scanline_16btpp+0x3f8>
    14aa:	fa                   	cli
    14ab:	f4                   	hlt
    14ac:	eb fd                	jmp    14ab <render_text_scanline_16btpp+0x3f9>
						px_x -= bitc / 16;
    14ae:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    14b1:	8d 50 0f             	lea    edx,[rax+0xf]
    14b4:	85 c0                	test   eax,eax
    14b6:	0f 48 c2             	cmovs  eax,edx
    14b9:	c1 f8 04             	sar    eax,0x4
    14bc:	f7 d8                	neg    eax
    14be:	01 45 84             	add    DWORD PTR [rbp-0x7c],eax
						p0_x += bitc / 16; /* unneccessary as r does not change anymore */
    14c1:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    14c4:	8d 50 0f             	lea    edx,[rax+0xf]
    14c7:	85 c0                	test   eax,eax
    14c9:	0f 48 c2             	cmovs  eax,edx
    14cc:	c1 f8 04             	sar    eax,0x4
    14cf:	01 85 7c ff ff ff    	add    DWORD PTR [rbp-0x84],eax
		while (px_x) {
    14d5:	83 7d 84 00          	cmp    DWORD PTR [rbp-0x7c],0x0
    14d9:	0f 85 d0 fd ff ff    	jne    12af <render_text_scanline_16btpp+0x1fd>
				} else
						break;
		}
}
    14df:	eb 04                	jmp    14e5 <render_text_scanline_16btpp+0x433>
						break;
    14e1:	90                   	nop
    14e2:	eb 01                	jmp    14e5 <render_text_scanline_16btpp+0x433>
						break;
    14e4:	90                   	nop
}
    14e5:	90                   	nop
    14e6:	c9                   	leave
    14e7:	c3                   	ret

00000000000014e8 <render_text_scanline_32btpp>:

/* we're generating 4byte colorvalues /w unknown alignment. To enable
 * 8 byte transfer, two pixel have to be generated. */
void render_text_scanline_32btpp(const char* font, char* str, void* mem,
				ssize_t px_x, ssize_t cur_x, ssize_t p0_x)
{
    14e8:	55                   	push   rbp
    14e9:	48 89 e5             	mov    rbp,rsp
    14ec:	48 81 ec 90 00 00 00 	sub    rsp,0x90
    14f3:	48 89 7d a8          	mov    QWORD PTR [rbp-0x58],rdi
    14f7:	48 89 75 a0          	mov    QWORD PTR [rbp-0x60],rsi
    14fb:	48 89 55 98          	mov    QWORD PTR [rbp-0x68],rdx
    14ff:	89 4d 94             	mov    DWORD PTR [rbp-0x6c],ecx
    1502:	44 89 45 90          	mov    DWORD PTR [rbp-0x70],r8d
    1506:	44 89 4d 8c          	mov    DWORD PTR [rbp-0x74],r9d
		uint8_t pxb[8 + 7]; /* 7 for stack alignment */
		ssize_t misalign = ((size_t)mem % 8) ? (8 - (size_t)mem % 8) : 0;
    150a:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    150e:	83 e0 07             	and    eax,0x7
    1511:	48 85 c0             	test   rax,rax
    1514:	74 12                	je     1528 <render_text_scanline_32btpp+0x40>
    1516:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    151a:	83 e0 07             	and    eax,0x7
    151d:	ba 08 00 00 00       	mov    edx,0x8
    1522:	29 c2                	sub    edx,eax
    1524:	89 d0                	mov    eax,edx
    1526:	eb 05                	jmp    152d <render_text_scanline_32btpp+0x45>
    1528:	b8 00 00 00 00       	mov    eax,0x0
    152d:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
		ssize_t r = p0_x % 8;
    1530:	8b 55 8c             	mov    edx,DWORD PTR [rbp-0x74]
    1533:	89 d0                	mov    eax,edx
    1535:	c1 f8 1f             	sar    eax,0x1f
    1538:	c1 e8 1d             	shr    eax,0x1d
    153b:	01 c2                	add    edx,eax
    153d:	83 e2 07             	and    edx,0x7
    1540:	29 c2                	sub    edx,eax
    1542:	89 55 f4             	mov    DWORD PTR [rbp-0xc],edx
		uint8_t* pixbuf = pxb + (((size_t)pxb % 8) ? (8 - ((size_t)pxb % 8)) : 0);
    1545:	48 8d 45 c1          	lea    rax,[rbp-0x3f]
    1549:	83 e0 07             	and    eax,0x7
    154c:	48 85 c0             	test   rax,rax
    154f:	74 14                	je     1565 <render_text_scanline_32btpp+0x7d>
    1551:	48 8d 45 c1          	lea    rax,[rbp-0x3f]
    1555:	83 e0 07             	and    eax,0x7
    1558:	48 89 c2             	mov    rdx,rax
    155b:	b8 08 00 00 00       	mov    eax,0x8
    1560:	48 29 d0             	sub    rax,rdx
    1563:	eb 05                	jmp    156a <render_text_scanline_32btpp+0x82>
    1565:	b8 00 00 00 00       	mov    eax,0x0
    156a:	48 8d 55 c1          	lea    rdx,[rbp-0x3f]
    156e:	48 01 d0             	add    rax,rdx
    1571:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
		/* 64-bit aligned moves are enough */

		if (misalign) { /* LFB is dword aligned, we want qword access */
    1575:	83 7d f8 00          	cmp    DWORD PTR [rbp-0x8],0x0
    1579:	0f 84 b3 02 00 00    	je     1832 <render_text_scanline_32btpp+0x34a>
				int col = p0_x / 8, inv = (col == cur_x);
    157f:	8b 45 8c             	mov    eax,DWORD PTR [rbp-0x74]
    1582:	8d 50 07             	lea    edx,[rax+0x7]
    1585:	85 c0                	test   eax,eax
    1587:	0f 48 c2             	cmovs  eax,edx
    158a:	c1 f8 03             	sar    eax,0x3
    158d:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
    1590:	8b 45 f0             	mov    eax,DWORD PTR [rbp-0x10]
    1593:	3b 45 90             	cmp    eax,DWORD PTR [rbp-0x70]
    1596:	0f 94 c0             	sete   al
    1599:	0f b6 c0             	movzx  eax,al
    159c:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
				ssize_t bc = min(misalign, 4 * px_x);
    159f:	8b 45 94             	mov    eax,DWORD PTR [rbp-0x6c]
    15a2:	c1 e0 02             	shl    eax,0x2
    15a5:	8b 55 f8             	mov    edx,DWORD PTR [rbp-0x8]
    15a8:	39 c2                	cmp    edx,eax
    15aa:	0f 4e c2             	cmovle eax,edx
    15ad:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
				ssize_t cc = rdiv(misalign, 4);
    15b0:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    15b3:	8d 50 03             	lea    edx,[rax+0x3]
    15b6:	85 c0                	test   eax,eax
    15b8:	0f 48 c2             	cmovs  eax,edx
    15bb:	c1 f8 02             	sar    eax,0x2
    15be:	89 c2                	mov    edx,eax
    15c0:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    15c3:	83 e0 03             	and    eax,0x3
    15c6:	85 c0                	test   eax,eax
    15c8:	0f 95 c0             	setne  al
    15cb:	0f b6 c0             	movzx  eax,al
    15ce:	01 d0                	add    eax,edx
    15d0:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
				ssize_t rmax = min(8, r + cc); //, cc1 = rmax - r;
    15d3:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    15d6:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    15d9:	01 d0                	add    eax,edx
    15db:	ba 08 00 00 00       	mov    edx,0x8
    15e0:	39 d0                	cmp    eax,edx
    15e2:	0f 4f c2             	cmovg  eax,edx
    15e5:	89 45 e0             	mov    DWORD PTR [rbp-0x20],eax

				generate_char_colors(font, str[0], str[1], 32,
    15e8:	48 8b 4d b8          	mov    rcx,QWORD PTR [rbp-0x48]
    15ec:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    15f0:	48 83 c0 01          	add    rax,0x1
    15f4:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    15f7:	0f be d0             	movsx  edx,al
    15fa:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    15fe:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1601:	0f be f0             	movsx  esi,al
    1604:	44 8b 4d e0          	mov    r9d,DWORD PTR [rbp-0x20]
    1608:	44 8b 45 f4          	mov    r8d,DWORD PTR [rbp-0xc]
    160c:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1610:	8b 7d ec             	mov    edi,DWORD PTR [rbp-0x14]
    1613:	89 7c 24 08          	mov    DWORD PTR [rsp+0x8],edi
    1617:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
    161b:	b9 20 00 00 00       	mov    ecx,0x20
    1620:	48 89 c7             	mov    rdi,rax
    1623:	e8 00 00 00 00       	call   1628 <render_text_scanline_32btpp+0x140>
								r, rmax, pixbuf, inv);
				if (rmax == 8)
    1628:	83 7d e0 08          	cmp    DWORD PTR [rbp-0x20],0x8
    162c:	75 05                	jne    1633 <render_text_scanline_32btpp+0x14b>
						str += 2;
    162e:	48 83 45 a0 02       	add    QWORD PTR [rbp-0x60],0x2
				// if (cc > cc1) <- does not happen cc always 1
				memcpy(mem, pixbuf, bc);
    1633:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    1636:	48 63 d0             	movsxd rdx,eax
    1639:	48 8b 4d b8          	mov    rcx,QWORD PTR [rbp-0x48]
    163d:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1641:	48 89 ce             	mov    rsi,rcx
    1644:	48 89 c7             	mov    rdi,rax
    1647:	e8 b4 e9 ff ff       	call   0 <memcpy>
				px_x -= cc;
    164c:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    164f:	29 45 94             	sub    DWORD PTR [rbp-0x6c],eax
				p0_x += cc;
    1652:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    1655:	01 45 8c             	add    DWORD PTR [rbp-0x74],eax
				mem += bc;
    1658:	48 8b 55 98          	mov    rdx,QWORD PTR [rbp-0x68]
    165c:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    165f:	48 98                	cdqe
    1661:	48 01 d0             	add    rax,rdx
    1664:	48 89 45 98          	mov    QWORD PTR [rbp-0x68],rax
		}

		/* draw 2 pixels each */
		while (px_x) {
    1668:	e9 c5 01 00 00       	jmp    1832 <render_text_scanline_32btpp+0x34a>
				int col = p0_x / 8, inv = (col == cur_x);
    166d:	8b 45 8c             	mov    eax,DWORD PTR [rbp-0x74]
    1670:	8d 50 07             	lea    edx,[rax+0x7]
    1673:	85 c0                	test   eax,eax
    1675:	0f 48 c2             	cmovs  eax,edx
    1678:	c1 f8 03             	sar    eax,0x3
    167b:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
    167e:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    1681:	3b 45 90             	cmp    eax,DWORD PTR [rbp-0x70]
    1684:	0f 94 c0             	sete   al
    1687:	0f b6 c0             	movzx  eax,al
    168a:	89 45 d8             	mov    DWORD PTR [rbp-0x28],eax
				ssize_t rmax, bitc, btt = min(64, 32 * px_x);
    168d:	8b 45 94             	mov    eax,DWORD PTR [rbp-0x6c]
    1690:	c1 e0 05             	shl    eax,0x5
    1693:	ba 40 00 00 00       	mov    edx,0x40
    1698:	39 d0                	cmp    eax,edx
    169a:	0f 4f c2             	cmovg  eax,edx
    169d:	89 45 d4             	mov    DWORD PTR [rbp-0x2c],eax
				r = p0_x % 8;
    16a0:	8b 55 8c             	mov    edx,DWORD PTR [rbp-0x74]
    16a3:	89 d0                	mov    eax,edx
    16a5:	c1 f8 1f             	sar    eax,0x1f
    16a8:	c1 e8 1d             	shr    eax,0x1d
    16ab:	01 c2                	add    edx,eax
    16ad:	83 e2 07             	and    edx,0x7
    16b0:	29 c2                	sub    edx,eax
    16b2:	89 55 f4             	mov    DWORD PTR [rbp-0xc],edx
				rmax = min(8, r + min(2, px_x)); /* only 2 pixels */
    16b5:	8b 45 94             	mov    eax,DWORD PTR [rbp-0x6c]
    16b8:	ba 02 00 00 00       	mov    edx,0x2
    16bd:	39 d0                	cmp    eax,edx
    16bf:	0f 4e d0             	cmovle edx,eax
    16c2:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    16c5:	01 d0                	add    eax,edx
    16c7:	ba 08 00 00 00       	mov    edx,0x8
    16cc:	39 d0                	cmp    eax,edx
    16ce:	0f 4f c2             	cmovg  eax,edx
    16d1:	89 45 d0             	mov    DWORD PTR [rbp-0x30],eax
				/* get the remaining character pixels */
				bitc = generate_char_colors(font, str[0], str[1], 32,
    16d4:	48 8b 4d b8          	mov    rcx,QWORD PTR [rbp-0x48]
    16d8:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    16dc:	48 83 c0 01          	add    rax,0x1
    16e0:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    16e3:	0f be d0             	movsx  edx,al
    16e6:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    16ea:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    16ed:	0f be f0             	movsx  esi,al
    16f0:	44 8b 4d d0          	mov    r9d,DWORD PTR [rbp-0x30]
    16f4:	44 8b 45 f4          	mov    r8d,DWORD PTR [rbp-0xc]
    16f8:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    16fc:	8b 7d d8             	mov    edi,DWORD PTR [rbp-0x28]
    16ff:	89 7c 24 08          	mov    DWORD PTR [rsp+0x8],edi
    1703:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
    1707:	b9 20 00 00 00       	mov    ecx,0x20
    170c:	48 89 c7             	mov    rdi,rax
    170f:	e8 00 00 00 00       	call   1714 <render_text_scanline_32btpp+0x22c>
    1714:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
								r, rmax, pixbuf, inv);
				/* now advance if neccessary */
				if (rmax == 8)
    1717:	83 7d d0 08          	cmp    DWORD PTR [rbp-0x30],0x8
    171b:	75 05                	jne    1722 <render_text_scanline_32btpp+0x23a>
						str += 2;
    171d:	48 83 45 a0 02       	add    QWORD PTR [rbp-0x60],0x2
				/* and fetch one more pixel if needed (r=0) */
				if (bitc < btt) {
    1722:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1725:	3b 45 d4             	cmp    eax,DWORD PTR [rbp-0x2c]
    1728:	7d 5e                	jge    1788 <render_text_scanline_32btpp+0x2a0>
						col++;
    172a:	83 45 dc 01          	add    DWORD PTR [rbp-0x24],0x1
						inv = (col == cur_x);
    172e:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    1731:	3b 45 90             	cmp    eax,DWORD PTR [rbp-0x70]
    1734:	0f 94 c0             	sete   al
    1737:	0f b6 c0             	movzx  eax,al
    173a:	89 45 d8             	mov    DWORD PTR [rbp-0x28],eax
						bitc += generate_char_colors(font, str[0], str[1], 32,
    173d:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1741:	48 8d 78 04          	lea    rdi,[rax+0x4]
    1745:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    1749:	48 83 c0 01          	add    rax,0x1
    174d:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1750:	0f be d0             	movsx  edx,al
    1753:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    1757:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    175a:	0f be f0             	movsx  esi,al
    175d:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1761:	8b 4d d8             	mov    ecx,DWORD PTR [rbp-0x28]
    1764:	89 4c 24 08          	mov    DWORD PTR [rsp+0x8],ecx
    1768:	48 89 3c 24          	mov    QWORD PTR [rsp],rdi
    176c:	41 b9 01 00 00 00    	mov    r9d,0x1
    1772:	41 b8 00 00 00 00    	mov    r8d,0x0
    1778:	b9 20 00 00 00       	mov    ecx,0x20
    177d:	48 89 c7             	mov    rdi,rax
    1780:	e8 00 00 00 00       	call   1785 <render_text_scanline_32btpp+0x29d>
    1785:	01 45 fc             	add    DWORD PTR [rbp-0x4],eax
										0, 1, pixbuf + 4, inv);
				}
				/* now transfer */
				if (bitc >= 64) {
    1788:	83 7d fc 3f          	cmp    DWORD PTR [rbp-0x4],0x3f
    178c:	7e 26                	jle    17b4 <render_text_scanline_32btpp+0x2cc>
						move_64(pixbuf, mem);
    178e:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1792:	48 8b 55 98          	mov    rdx,QWORD PTR [rbp-0x68]
    1796:	0f 6f 00             	movq   mm0,QWORD PTR [rax]
    1799:	0f 7f 02             	movq   QWORD PTR [rdx],mm0
						mem += 8; /* intentionally no bitc subtract */
    179c:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    17a0:	48 83 c0 08          	add    rax,0x8
    17a4:	48 89 45 98          	mov    QWORD PTR [rbp-0x68],rax
						}
						break;
				}

				/* and don't advance as r = 0 is already handled (sth. remains) */
				if (px_x) {
    17a8:	83 7d 94 00          	cmp    DWORD PTR [rbp-0x6c],0x0
    17ac:	0f 84 8c 00 00 00    	je     183e <render_text_scanline_32btpp+0x356>
    17b2:	eb 5a                	jmp    180e <render_text_scanline_32btpp+0x326>
						if (bitc >= 32) {
    17b4:	83 7d fc 1f          	cmp    DWORD PTR [rbp-0x4],0x1f
    17b8:	7e 1e                	jle    17d8 <render_text_scanline_32btpp+0x2f0>
								*(uint32_t*)mem = *(uint32_t*)pixbuf;
    17ba:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
    17be:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    17c2:	8b 12                	mov    edx,DWORD PTR [rdx]
    17c4:	89 10                	mov    DWORD PTR [rax],edx
								mem += 4;
    17c6:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    17ca:	48 83 c0 04          	add    rax,0x4
    17ce:	48 89 45 98          	mov    QWORD PTR [rbp-0x68],rax
								bitc -= 32;
    17d2:	83 6d fc 20          	sub    DWORD PTR [rbp-0x4],0x20
						break;
    17d6:	eb 69                	jmp    1841 <render_text_scanline_32btpp+0x359>
						} else if (bitc) {
    17d8:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
    17dc:	74 63                	je     1841 <render_text_scanline_32btpp+0x359>
								die("cant happen with dword sized pixels!\n");
    17de:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    17e5:	bf 0c 00 00 00       	mov    edi,0xc
    17ea:	b8 00 00 00 00       	mov    eax,0x0
    17ef:	e8 00 00 00 00       	call   17f4 <render_text_scanline_32btpp+0x30c>
    17f4:	b8 00 00 00 00       	mov    eax,0x0
    17f9:	e8 00 00 00 00       	call   17fe <render_text_scanline_32btpp+0x316>
    17fe:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1805:	e8 00 00 00 00       	call   180a <render_text_scanline_32btpp+0x322>
    180a:	fa                   	cli
    180b:	f4                   	hlt
    180c:	eb fd                	jmp    180b <render_text_scanline_32btpp+0x323>
						px_x -= bitc / 32;
    180e:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1811:	8d 50 1f             	lea    edx,[rax+0x1f]
    1814:	85 c0                	test   eax,eax
    1816:	0f 48 c2             	cmovs  eax,edx
    1819:	c1 f8 05             	sar    eax,0x5
    181c:	f7 d8                	neg    eax
    181e:	01 45 94             	add    DWORD PTR [rbp-0x6c],eax
						p0_x += bitc / 32; /* unneccessary as r does not change anymore */
    1821:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1824:	8d 50 1f             	lea    edx,[rax+0x1f]
    1827:	85 c0                	test   eax,eax
    1829:	0f 48 c2             	cmovs  eax,edx
    182c:	c1 f8 05             	sar    eax,0x5
    182f:	01 45 8c             	add    DWORD PTR [rbp-0x74],eax
		while (px_x) {
    1832:	83 7d 94 00          	cmp    DWORD PTR [rbp-0x6c],0x0
    1836:	0f 85 31 fe ff ff    	jne    166d <render_text_scanline_32btpp+0x185>
				} else
						break;
		}
}
    183c:	eb 04                	jmp    1842 <render_text_scanline_32btpp+0x35a>
						break;
    183e:	90                   	nop
    183f:	eb 01                	jmp    1842 <render_text_scanline_32btpp+0x35a>
						break;
    1841:	90                   	nop
}
    1842:	90                   	nop
    1843:	c9                   	leave
    1844:	c3                   	ret

0000000000001845 <render_text_scanline_8btpp>:

/* ~32 times better performance than /w byte access in old method below */
void render_text_scanline_8btpp(const char* font, char* str, void* mem,
				ssize_t px_x, ssize_t cur_x, ssize_t p0_x)
{
    1845:	55                   	push   rbp
    1846:	48 89 e5             	mov    rbp,rsp
    1849:	48 81 ec a0 00 00 00 	sub    rsp,0xa0
    1850:	48 89 7d 98          	mov    QWORD PTR [rbp-0x68],rdi
    1854:	48 89 75 90          	mov    QWORD PTR [rbp-0x70],rsi
    1858:	48 89 55 88          	mov    QWORD PTR [rbp-0x78],rdx
    185c:	89 4d 84             	mov    DWORD PTR [rbp-0x7c],ecx
    185f:	44 89 45 80          	mov    DWORD PTR [rbp-0x80],r8d
    1863:	44 89 8d 7c ff ff ff 	mov    DWORD PTR [rbp-0x84],r9d
		uint8_t pxb[8 + 7]; /* for any stack alignment */
		ssize_t misalign = ((size_t)mem % 8) ? (8 - (size_t)mem % 8) : 0;
    186a:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    186e:	83 e0 07             	and    eax,0x7
    1871:	48 85 c0             	test   rax,rax
    1874:	74 12                	je     1888 <render_text_scanline_8btpp+0x43>
    1876:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    187a:	83 e0 07             	and    eax,0x7
    187d:	ba 08 00 00 00       	mov    edx,0x8
    1882:	29 c2                	sub    edx,eax
    1884:	89 d0                	mov    eax,edx
    1886:	eb 05                	jmp    188d <render_text_scanline_8btpp+0x48>
    1888:	b8 00 00 00 00       	mov    eax,0x0
    188d:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
		ssize_t r = p0_x % 8;
    1890:	8b 95 7c ff ff ff    	mov    edx,DWORD PTR [rbp-0x84]
    1896:	89 d0                	mov    eax,edx
    1898:	c1 f8 1f             	sar    eax,0x1f
    189b:	c1 e8 1d             	shr    eax,0x1d
    189e:	01 c2                	add    edx,eax
    18a0:	83 e2 07             	and    edx,0x7
    18a3:	29 c2                	sub    edx,eax
    18a5:	89 55 e8             	mov    DWORD PTR [rbp-0x18],edx
		uint8_t* pixbuf = pxb + (((size_t)pxb % 8) ? (8 - ((size_t)pxb % 8)) : 0);
    18a8:	48 8d 45 b5          	lea    rax,[rbp-0x4b]
    18ac:	83 e0 07             	and    eax,0x7
    18af:	48 85 c0             	test   rax,rax
    18b2:	74 14                	je     18c8 <render_text_scanline_8btpp+0x83>
    18b4:	48 8d 45 b5          	lea    rax,[rbp-0x4b]
    18b8:	83 e0 07             	and    eax,0x7
    18bb:	48 89 c2             	mov    rdx,rax
    18be:	b8 08 00 00 00       	mov    eax,0x8
    18c3:	48 29 d0             	sub    rax,rdx
    18c6:	eb 05                	jmp    18cd <render_text_scanline_8btpp+0x88>
    18c8:	b8 00 00 00 00       	mov    eax,0x0
    18cd:	48 8d 55 b5          	lea    rdx,[rbp-0x4b]
    18d1:	48 01 d0             	add    rax,rdx
    18d4:	48 89 45 a8          	mov    QWORD PTR [rbp-0x58],rax
		/* 64-bit aligned moves are enough */

		if (misalign) { /* we first have to draw misalign pixels */
    18d8:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
    18dc:	0f 84 87 03 00 00    	je     1c69 <render_text_scanline_8btpp+0x424>
				int col = p0_x / 8, inv = (col == cur_x);
    18e2:	8b 85 7c ff ff ff    	mov    eax,DWORD PTR [rbp-0x84]
    18e8:	8d 50 07             	lea    edx,[rax+0x7]
    18eb:	85 c0                	test   eax,eax
    18ed:	0f 48 c2             	cmovs  eax,edx
    18f0:	c1 f8 03             	sar    eax,0x3
    18f3:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
    18f6:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    18f9:	3b 45 80             	cmp    eax,DWORD PTR [rbp-0x80]
    18fc:	0f 94 c0             	sete   al
    18ff:	0f b6 c0             	movzx  eax,al
    1902:	89 45 e0             	mov    DWORD PTR [rbp-0x20],eax
				ssize_t bc = min(misalign, px_x); /* r already set */
    1905:	8b 55 84             	mov    edx,DWORD PTR [rbp-0x7c]
    1908:	8b 45 ec             	mov    eax,DWORD PTR [rbp-0x14]
    190b:	39 c2                	cmp    edx,eax
    190d:	0f 4e c2             	cmovle eax,edx
    1910:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
				ssize_t rmax = min(8, r + bc), bc1 = rmax - r;
    1913:	8b 55 e8             	mov    edx,DWORD PTR [rbp-0x18]
    1916:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    1919:	01 d0                	add    eax,edx
    191b:	ba 08 00 00 00       	mov    edx,0x8
    1920:	39 d0                	cmp    eax,edx
    1922:	0f 4f c2             	cmovg  eax,edx
    1925:	89 45 d8             	mov    DWORD PTR [rbp-0x28],eax
    1928:	8b 45 d8             	mov    eax,DWORD PTR [rbp-0x28]
    192b:	2b 45 e8             	sub    eax,DWORD PTR [rbp-0x18]
    192e:	89 45 d4             	mov    DWORD PTR [rbp-0x2c],eax

				generate_char_colors(font, str[0], str[1], 8,
    1931:	48 8b 4d a8          	mov    rcx,QWORD PTR [rbp-0x58]
    1935:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1939:	48 83 c0 01          	add    rax,0x1
    193d:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1940:	0f be d0             	movsx  edx,al
    1943:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1947:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    194a:	0f be f0             	movsx  esi,al
    194d:	44 8b 4d d8          	mov    r9d,DWORD PTR [rbp-0x28]
    1951:	44 8b 45 e8          	mov    r8d,DWORD PTR [rbp-0x18]
    1955:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1959:	8b 7d e0             	mov    edi,DWORD PTR [rbp-0x20]
    195c:	89 7c 24 08          	mov    DWORD PTR [rsp+0x8],edi
    1960:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
    1964:	b9 08 00 00 00       	mov    ecx,0x8
    1969:	48 89 c7             	mov    rdi,rax
    196c:	e8 00 00 00 00       	call   1971 <render_text_scanline_8btpp+0x12c>
								r, rmax, pixbuf, inv);
				if (rmax == 8)
    1971:	83 7d d8 08          	cmp    DWORD PTR [rbp-0x28],0x8
    1975:	75 05                	jne    197c <render_text_scanline_8btpp+0x137>
						str += 2;
    1977:	48 83 45 90 02       	add    QWORD PTR [rbp-0x70],0x2
				if (bc > bc1) {
    197c:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    197f:	3b 45 d4             	cmp    eax,DWORD PTR [rbp-0x2c]
    1982:	7e 66                	jle    19ea <render_text_scanline_8btpp+0x1a5>
						col++;
    1984:	83 45 e4 01          	add    DWORD PTR [rbp-0x1c],0x1
						inv = (col == cur_x);
    1988:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
    198b:	3b 45 80             	cmp    eax,DWORD PTR [rbp-0x80]
    198e:	0f 94 c0             	sete   al
    1991:	0f b6 c0             	movzx  eax,al
    1994:	89 45 e0             	mov    DWORD PTR [rbp-0x20],eax
						generate_char_colors(font, str[0], str[1], 8,
    1997:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    199b:	8b 45 d4             	mov    eax,DWORD PTR [rbp-0x2c]
    199e:	48 98                	cdqe
    19a0:	48 8d 3c 02          	lea    rdi,[rdx+rax*1]
    19a4:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    19a7:	2b 45 d4             	sub    eax,DWORD PTR [rbp-0x2c]
    19aa:	41 89 c0             	mov    r8d,eax
    19ad:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    19b1:	48 83 c0 01          	add    rax,0x1
    19b5:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    19b8:	0f be d0             	movsx  edx,al
    19bb:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    19bf:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    19c2:	0f be f0             	movsx  esi,al
    19c5:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    19c9:	8b 4d e0             	mov    ecx,DWORD PTR [rbp-0x20]
    19cc:	89 4c 24 08          	mov    DWORD PTR [rsp+0x8],ecx
    19d0:	48 89 3c 24          	mov    QWORD PTR [rsp],rdi
    19d4:	45 89 c1             	mov    r9d,r8d
    19d7:	41 b8 00 00 00 00    	mov    r8d,0x0
    19dd:	b9 08 00 00 00       	mov    ecx,0x8
    19e2:	48 89 c7             	mov    rdi,rax
    19e5:	e8 00 00 00 00       	call   19ea <render_text_scanline_8btpp+0x1a5>
										0, bc - bc1, pixbuf + bc1, inv);
				}
				memcpy(mem, pixbuf, bc);
    19ea:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    19ed:	48 63 d0             	movsxd rdx,eax
    19f0:	48 8b 4d a8          	mov    rcx,QWORD PTR [rbp-0x58]
    19f4:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    19f8:	48 89 ce             	mov    rsi,rcx
    19fb:	48 89 c7             	mov    rdi,rax
    19fe:	e8 fd e5 ff ff       	call   0 <memcpy>
				px_x -= bc;
    1a03:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    1a06:	29 45 84             	sub    DWORD PTR [rbp-0x7c],eax
				p0_x += bc;
    1a09:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    1a0c:	01 85 7c ff ff ff    	add    DWORD PTR [rbp-0x84],eax
				mem += bc;
    1a12:	48 8b 55 88          	mov    rdx,QWORD PTR [rbp-0x78]
    1a16:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    1a19:	48 98                	cdqe
    1a1b:	48 01 d0             	add    rax,rdx
    1a1e:	48 89 45 88          	mov    QWORD PTR [rbp-0x78],rax
		}

		/* now we can draw 8 pixels each */
		while (px_x) {
    1a22:	e9 42 02 00 00       	jmp    1c69 <render_text_scanline_8btpp+0x424>
				int col = p0_x / 8, inv = (col == cur_x);
    1a27:	8b 85 7c ff ff ff    	mov    eax,DWORD PTR [rbp-0x84]
    1a2d:	8d 50 07             	lea    edx,[rax+0x7]
    1a30:	85 c0                	test   eax,eax
    1a32:	0f 48 c2             	cmovs  eax,edx
    1a35:	c1 f8 03             	sar    eax,0x3
    1a38:	89 45 d0             	mov    DWORD PTR [rbp-0x30],eax
    1a3b:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
    1a3e:	3b 45 80             	cmp    eax,DWORD PTR [rbp-0x80]
    1a41:	0f 94 c0             	sete   al
    1a44:	0f b6 c0             	movzx  eax,al
    1a47:	89 45 cc             	mov    DWORD PTR [rbp-0x34],eax
				ssize_t rmax, bitc, btt = min(64, 8 * px_x), cc;
    1a4a:	8b 45 84             	mov    eax,DWORD PTR [rbp-0x7c]
    1a4d:	c1 e0 03             	shl    eax,0x3
    1a50:	ba 40 00 00 00       	mov    edx,0x40
    1a55:	39 d0                	cmp    eax,edx
    1a57:	0f 4f c2             	cmovg  eax,edx
    1a5a:	89 45 c8             	mov    DWORD PTR [rbp-0x38],eax
				r = p0_x % 8;
    1a5d:	8b 95 7c ff ff ff    	mov    edx,DWORD PTR [rbp-0x84]
    1a63:	89 d0                	mov    eax,edx
    1a65:	c1 f8 1f             	sar    eax,0x1f
    1a68:	c1 e8 1d             	shr    eax,0x1d
    1a6b:	01 c2                	add    edx,eax
    1a6d:	83 e2 07             	and    edx,0x7
    1a70:	29 c2                	sub    edx,eax
    1a72:	89 55 e8             	mov    DWORD PTR [rbp-0x18],edx
				rmax = min(8, r + px_x);
    1a75:	8b 55 e8             	mov    edx,DWORD PTR [rbp-0x18]
    1a78:	8b 45 84             	mov    eax,DWORD PTR [rbp-0x7c]
    1a7b:	01 d0                	add    eax,edx
    1a7d:	ba 08 00 00 00       	mov    edx,0x8
    1a82:	39 d0                	cmp    eax,edx
    1a84:	0f 4f c2             	cmovg  eax,edx
    1a87:	89 45 c4             	mov    DWORD PTR [rbp-0x3c],eax
				/* get the remaining character pixels */
				bitc = generate_char_colors(font, str[0], str[1], 8,
    1a8a:	48 8b 4d a8          	mov    rcx,QWORD PTR [rbp-0x58]
    1a8e:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1a92:	48 83 c0 01          	add    rax,0x1
    1a96:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1a99:	0f be d0             	movsx  edx,al
    1a9c:	48 8b 45 90          	mov    rax,QWORD PTR [rbp-0x70]
    1aa0:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1aa3:	0f be f0             	movsx  esi,al
    1aa6:	44 8b 4d c4          	mov    r9d,DWORD PTR [rbp-0x3c]
    1aaa:	44 8b 45 e8          	mov    r8d,DWORD PTR [rbp-0x18]
    1aae:	48 8b 45 98          	mov    rax,QWORD PTR [rbp-0x68]
    1ab2:	8b 7d cc             	mov    edi,DWORD PTR [rbp-0x34]
    1ab5:	89 7c 24 08          	mov    DWORD PTR [rsp+0x8],edi
    1ab9:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
    1abd:	b9 08 00 00 00       	mov    ecx,0x8
    1ac2:	48 89 c7             	mov    rdi,rax
    1ac5:	e8 00 00 00 00       	call   1aca <render_text_scanline_8btpp+0x285>
    1aca:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
								r, rmax, pixbuf, inv);
				/* now advance */
				str += 2;
    1acd:	48 83 45 90 02       	add    QWORD PTR [rbp-0x70],0x2
				cc = bitc / 8;
    1ad2:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1ad5:	8d 50 07             	lea    edx,[rax+0x7]
    1ad8:	85 c0                	test   eax,eax
    1ada:	0f 48 c2             	cmovs  eax,edx
    1add:	c1 f8 03             	sar    eax,0x3
    1ae0:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
				/* and fetch more pixels if needed (r=0) */
				if (bitc < btt) {
    1ae3:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1ae6:	3b 45 c8             	cmp    eax,DWORD PTR [rbp-0x38]
    1ae9:	0f 8d 84 00 00 00    	jge    1b73 <render_text_scanline_8btpp+0x32e>
						col++;
    1aef:	83 45 d0 01          	add    DWORD PTR [rbp-0x30],0x1
						inv = (col == cur_x);
    1af3:	8b 45 d0             	mov    eax,DWORD PTR [rbp-0x30]
    1af6:	3b 45 80             	cmp    eax,DWORD PTR [rbp-0x80]
    1af9:	0f 94 c0             	sete   al
    1afc:	0f b6 c0             	movzx  eax,al
    1aff:	89 45 cc             	mov    DWORD PTR [rbp-0x34],eax
						bitc += generate_char_colors(font, str[0], str[1], 8,
    1b02:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1b06:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    1b09:	48 98                	cdqe
    1b0b:	4c 8d 04 02          	lea    r8,[rdx+rax*1]
    1b0f:	83 7d 84 08          	cmp    DWORD PTR [rbp-0x7c],0x8
    1b13:	7e 0a                	jle    1b1f <render_text_scanline_8btpp+0x2da>
    1b15:	b8 08 00 00 00       	mov    eax,0x8
    1b1a:	2b 45 f8             	sub    eax,DWORD PTR [rbp-0x8]
    1b1d:	eb 06                	jmp    1b25 <render_text_scanline_8btpp+0x2e0>
    1b1f:	8b 45 84             	mov    eax,DWORD PTR [rbp-0x7c]
    1b22:	2b 45 f8             	sub    eax,DWORD PTR [rbp-0x8]
    1b25:	48 8b 55 90          	mov    rdx,QWORD PTR [rbp-0x70]
    1b29:	48 83 c2 01          	add    rdx,0x1
    1b2d:	0f b6 12             	movzx  edx,BYTE PTR [rdx]
    1b30:	0f be d2             	movsx  edx,dl
    1b33:	48 8b 4d 90          	mov    rcx,QWORD PTR [rbp-0x70]
    1b37:	0f b6 09             	movzx  ecx,BYTE PTR [rcx]
    1b3a:	0f be f1             	movsx  esi,cl
    1b3d:	48 8b 7d 98          	mov    rdi,QWORD PTR [rbp-0x68]
    1b41:	8b 4d cc             	mov    ecx,DWORD PTR [rbp-0x34]
    1b44:	89 4c 24 08          	mov    DWORD PTR [rsp+0x8],ecx
    1b48:	4c 89 04 24          	mov    QWORD PTR [rsp],r8
    1b4c:	41 89 c1             	mov    r9d,eax
    1b4f:	41 b8 00 00 00 00    	mov    r8d,0x0
    1b55:	b9 08 00 00 00       	mov    ecx,0x8
    1b5a:	e8 00 00 00 00       	call   1b5f <render_text_scanline_8btpp+0x31a>
    1b5f:	01 45 fc             	add    DWORD PTR [rbp-0x4],eax
										0, min(8 - cc, px_x - cc), pixbuf + cc, inv);
						cc = bitc / 8;
    1b62:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1b65:	8d 50 07             	lea    edx,[rax+0x7]
    1b68:	85 c0                	test   eax,eax
    1b6a:	0f 48 c2             	cmovs  eax,edx
    1b6d:	c1 f8 03             	sar    eax,0x3
    1b70:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
				}
				/* now transfer */
				if (bitc >= 64) {
    1b73:	83 7d fc 3f          	cmp    DWORD PTR [rbp-0x4],0x3f
    1b77:	7e 29                	jle    1ba2 <render_text_scanline_8btpp+0x35d>
						move_64(pixbuf, mem);
    1b79:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1b7d:	48 8b 55 88          	mov    rdx,QWORD PTR [rbp-0x78]
    1b81:	0f 6f 00             	movq   mm0,QWORD PTR [rax]
    1b84:	0f 7f 02             	movq   QWORD PTR [rdx],mm0
						mem += 8; /* intentionally no bitc subtract */
    1b87:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1b8b:	48 83 c0 08          	add    rax,0x8
    1b8f:	48 89 45 88          	mov    QWORD PTR [rbp-0x78],rax
						}
						break;
				}

				/* and don't advance as r = 0 is already handled (sth. remains) */
				if (px_x) {
    1b93:	83 7d 84 00          	cmp    DWORD PTR [rbp-0x7c],0x0
    1b97:	0f 84 d8 00 00 00    	je     1c75 <render_text_scanline_8btpp+0x430>
    1b9d:	e9 b8 00 00 00       	jmp    1c5a <render_text_scanline_8btpp+0x415>
						uint8_t* pt = pixbuf;
    1ba2:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1ba6:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
						if (bitc >= 32) {
    1baa:	83 7d fc 1f          	cmp    DWORD PTR [rbp-0x4],0x1f
    1bae:	7e 21                	jle    1bd1 <render_text_scanline_8btpp+0x38c>
								*(uint32_t*)mem = *(uint32_t*)pixbuf;
    1bb0:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1bb4:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1bb8:	8b 12                	mov    edx,DWORD PTR [rdx]
    1bba:	89 10                	mov    DWORD PTR [rax],edx
								pt += 4;
    1bbc:	48 83 45 f0 04       	add    QWORD PTR [rbp-0x10],0x4
								mem += 4;
    1bc1:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1bc5:	48 83 c0 04          	add    rax,0x4
    1bc9:	48 89 45 88          	mov    QWORD PTR [rbp-0x78],rax
								bitc -= 32;
    1bcd:	83 6d fc 20          	sub    DWORD PTR [rbp-0x4],0x20
						if (bitc >= 16) {
    1bd1:	83 7d fc 0f          	cmp    DWORD PTR [rbp-0x4],0xf
    1bd5:	7e 23                	jle    1bfa <render_text_scanline_8btpp+0x3b5>
								*(uint16_t*)mem = *(uint16_t*)pt;
    1bd7:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1bdb:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1bdf:	0f b7 12             	movzx  edx,WORD PTR [rdx]
    1be2:	66 89 10             	mov    WORD PTR [rax],dx
								pt += 2;
    1be5:	48 83 45 f0 02       	add    QWORD PTR [rbp-0x10],0x2
								mem += 2;
    1bea:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1bee:	48 83 c0 02          	add    rax,0x2
    1bf2:	48 89 45 88          	mov    QWORD PTR [rbp-0x78],rax
								bitc -= 16;
    1bf6:	83 6d fc 10          	sub    DWORD PTR [rbp-0x4],0x10
						if (bitc >= 8) {
    1bfa:	83 7d fc 07          	cmp    DWORD PTR [rbp-0x4],0x7
    1bfe:	7e 24                	jle    1c24 <render_text_scanline_8btpp+0x3df>
								*(uint8_t*)mem = *(uint8_t*)pt;
    1c00:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1c04:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    1c08:	0f b6 12             	movzx  edx,BYTE PTR [rdx]
    1c0b:	88 10                	mov    BYTE PTR [rax],dl
								pt += 1;
    1c0d:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
								mem += 1;
    1c12:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    1c16:	48 83 c0 01          	add    rax,0x1
    1c1a:	48 89 45 88          	mov    QWORD PTR [rbp-0x78],rax
								bitc -= 8;
    1c1e:	83 6d fc 08          	sub    DWORD PTR [rbp-0x4],0x8
						break;
    1c22:	eb 54                	jmp    1c78 <render_text_scanline_8btpp+0x433>
						} else if (bitc) {
    1c24:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
    1c28:	74 4e                	je     1c78 <render_text_scanline_8btpp+0x433>
								die("cant happen with byte sized pixels!\n");
    1c2a:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1c31:	bf 0c 00 00 00       	mov    edi,0xc
    1c36:	b8 00 00 00 00       	mov    eax,0x0
    1c3b:	e8 00 00 00 00       	call   1c40 <render_text_scanline_8btpp+0x3fb>
    1c40:	b8 00 00 00 00       	mov    eax,0x0
    1c45:	e8 00 00 00 00       	call   1c4a <render_text_scanline_8btpp+0x405>
    1c4a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1c51:	e8 00 00 00 00       	call   1c56 <render_text_scanline_8btpp+0x411>
    1c56:	fa                   	cli
    1c57:	f4                   	hlt
    1c58:	eb fd                	jmp    1c57 <render_text_scanline_8btpp+0x412>
						px_x -= cc;
    1c5a:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    1c5d:	29 45 84             	sub    DWORD PTR [rbp-0x7c],eax
						p0_x += cc; /* unneccessary as r does not change anymore */
    1c60:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    1c63:	01 85 7c ff ff ff    	add    DWORD PTR [rbp-0x84],eax
		while (px_x) {
    1c69:	83 7d 84 00          	cmp    DWORD PTR [rbp-0x7c],0x0
    1c6d:	0f 85 b4 fd ff ff    	jne    1a27 <render_text_scanline_8btpp+0x1e2>
				} else
						break;
		}
}
    1c73:	eb 04                	jmp    1c79 <render_text_scanline_8btpp+0x434>
						break;
    1c75:	90                   	nop
    1c76:	eb 01                	jmp    1c79 <render_text_scanline_8btpp+0x434>
						break;
    1c78:	90                   	nop
}
    1c79:	90                   	nop
    1c7a:	c9                   	leave
    1c7b:	c3                   	ret

0000000000001c7c <render_text>:
/* this function uses pixel addressing for width and height
 * making it possible to render half/overlapping characters.
 */
void render_text(const char* font, char* str, void* mem, size_t text_stride, size_t mem_stride,
		size_t btpp, ssize_t px_x, ssize_t px_y, int starts_half, int cur_x, int cur_y, ssize_t p0_x, ssize_t p0_y)
{
    1c7c:	55                   	push   rbp
    1c7d:	48 89 e5             	mov    rbp,rsp
    1c80:	48 83 ec 50          	sub    rsp,0x50
    1c84:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    1c88:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
    1c8c:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
    1c90:	48 89 4d d0          	mov    QWORD PTR [rbp-0x30],rcx
    1c94:	4c 89 45 c8          	mov    QWORD PTR [rbp-0x38],r8
    1c98:	4c 89 4d c0          	mov    QWORD PTR [rbp-0x40],r9
		(void)starts_half;
//		char is_half = 0, ends_half = 0;
		/* pixel offset is handled before calling the function */
//		is_half = starts_half;
//		ends_half = (px_x % 2) ? (!starts_half) : (starts_half);
		for (ssize_t ln = p0_y; ln < px_y + p0_y; ln++) {
    1c9c:	8b 45 40             	mov    eax,DWORD PTR [rbp+0x40]
    1c9f:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
    1ca2:	e9 f3 01 00 00       	jmp    1e9a <render_text+0x21e>
				ssize_t l = ln % 16; ssize_t cur_xv;
    1ca7:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    1caa:	89 d0                	mov    eax,edx
    1cac:	c1 f8 1f             	sar    eax,0x1f
    1caf:	c1 e8 1c             	shr    eax,0x1c
    1cb2:	01 c2                	add    edx,eax
    1cb4:	83 e2 0f             	and    edx,0xf
    1cb7:	29 c2                	sub    edx,eax
    1cb9:	89 55 f4             	mov    DWORD PTR [rbp-0xc],edx

				/* check cursor */
				if (ln / 16 == cur_y)
    1cbc:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1cbf:	8d 50 0f             	lea    edx,[rax+0xf]
    1cc2:	85 c0                	test   eax,eax
    1cc4:	0f 48 c2             	cmovs  eax,edx
    1cc7:	c1 f8 04             	sar    eax,0x4
    1cca:	39 45 30             	cmp    DWORD PTR [rbp+0x30],eax
    1ccd:	75 08                	jne    1cd7 <render_text+0x5b>
						cur_xv = cur_x;
    1ccf:	8b 45 28             	mov    eax,DWORD PTR [rbp+0x28]
    1cd2:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
    1cd5:	eb 07                	jmp    1cde <render_text+0x62>
				else
						cur_xv = -1;
    1cd7:	c7 45 f8 ff ff ff ff 	mov    DWORD PTR [rbp-0x8],0xffffffff

				/* invoke the scanline drawing routines */
				switch (btpp) {
    1cde:	48 83 7d c0 20       	cmp    QWORD PTR [rbp-0x40],0x20
    1ce3:	74 4e                	je     1d33 <render_text+0xb7>
    1ce5:	48 83 7d c0 20       	cmp    QWORD PTR [rbp-0x40],0x20
    1cea:	0f 87 5f 01 00 00    	ja     1e4f <render_text+0x1d3>
    1cf0:	48 83 7d c0 18       	cmp    QWORD PTR [rbp-0x40],0x18
    1cf5:	0f 84 ac 00 00 00    	je     1da7 <render_text+0x12b>
    1cfb:	48 83 7d c0 18       	cmp    QWORD PTR [rbp-0x40],0x18
    1d00:	0f 87 49 01 00 00    	ja     1e4f <render_text+0x1d3>
    1d06:	48 83 7d c0 08       	cmp    QWORD PTR [rbp-0x40],0x8
    1d0b:	0f 84 0e 01 00 00    	je     1e1f <render_text+0x1a3>
    1d11:	48 83 7d c0 08       	cmp    QWORD PTR [rbp-0x40],0x8
    1d16:	0f 82 33 01 00 00    	jb     1e4f <render_text+0x1d3>
    1d1c:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1d20:	48 83 e8 0f          	sub    rax,0xf
    1d24:	48 83 f8 01          	cmp    rax,0x1
    1d28:	0f 87 21 01 00 00    	ja     1e4f <render_text+0x1d3>
    1d2e:	e9 b9 00 00 00       	jmp    1dec <render_text+0x170>
						case 32:
								if (cpu.has_sse)
    1d33:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 1d3a <render_text+0xbe>
    1d3a:	83 e0 02             	and    eax,0x2
    1d3d:	84 c0                	test   al,al
    1d3f:	74 33                	je     1d74 <render_text+0xf8>
										render_text_scanline_32btpp_sse(font + l, str,
    1d41:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1d44:	48 63 d0             	movsxd rdx,eax
    1d47:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1d4b:	48 8d 3c 02          	lea    rdi,[rdx+rax*1]
    1d4f:	44 8b 45 38          	mov    r8d,DWORD PTR [rbp+0x38]
    1d53:	8b 75 f8             	mov    esi,DWORD PTR [rbp-0x8]
    1d56:	8b 4d 10             	mov    ecx,DWORD PTR [rbp+0x10]
    1d59:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    1d5d:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1d61:	45 89 c1             	mov    r9d,r8d
    1d64:	41 89 f0             	mov    r8d,esi
    1d67:	48 89 c6             	mov    rsi,rax
    1d6a:	e8 00 00 00 00       	call   1d6f <render_text+0xf3>
												mem, px_x, cur_xv, p0_x);
								else
										render_text_scanline_32btpp(font + l, str,
												mem, px_x, cur_xv, p0_x);
								break;
    1d6f:	e9 0c 01 00 00       	jmp    1e80 <render_text+0x204>
										render_text_scanline_32btpp(font + l, str,
    1d74:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1d77:	48 63 d0             	movsxd rdx,eax
    1d7a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1d7e:	48 8d 3c 02          	lea    rdi,[rdx+rax*1]
    1d82:	44 8b 45 38          	mov    r8d,DWORD PTR [rbp+0x38]
    1d86:	8b 75 f8             	mov    esi,DWORD PTR [rbp-0x8]
    1d89:	8b 4d 10             	mov    ecx,DWORD PTR [rbp+0x10]
    1d8c:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    1d90:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1d94:	45 89 c1             	mov    r9d,r8d
    1d97:	41 89 f0             	mov    r8d,esi
    1d9a:	48 89 c6             	mov    rsi,rax
    1d9d:	e8 00 00 00 00       	call   1da2 <render_text+0x126>
								break;
    1da2:	e9 d9 00 00 00       	jmp    1e80 <render_text+0x204>
						case 24: /* 16 bytes /w sse really needed */
								if (cpu.has_sse)
    1da7:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 1dae <render_text+0x132>
    1dae:	83 e0 02             	and    eax,0x2
    1db1:	84 c0                	test   al,al
    1db3:	0f 84 c6 00 00 00    	je     1e7f <render_text+0x203>
										render_text_scanline_24btpp_sse(font + l, str,
    1db9:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1dbc:	48 63 d0             	movsxd rdx,eax
    1dbf:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1dc3:	48 8d 3c 02          	lea    rdi,[rdx+rax*1]
    1dc7:	44 8b 45 38          	mov    r8d,DWORD PTR [rbp+0x38]
    1dcb:	8b 75 f8             	mov    esi,DWORD PTR [rbp-0x8]
    1dce:	8b 4d 10             	mov    ecx,DWORD PTR [rbp+0x10]
    1dd1:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    1dd5:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1dd9:	45 89 c1             	mov    r9d,r8d
    1ddc:	41 89 f0             	mov    r8d,esi
    1ddf:	48 89 c6             	mov    rsi,rax
    1de2:	e8 00 00 00 00       	call   1de7 <render_text+0x16b>
												mem, px_x, cur_xv, p0_x);
								//else
								//		render_text_scanline_24btpp(font + l, str,
								//				mem, px_x, cur_xv, p0_x);
								break;
    1de7:	e9 93 00 00 00       	jmp    1e7f <render_text+0x203>
						case 15:
						case 16:
								render_text_scanline_16btpp(font + l, str,
    1dec:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1def:	48 63 d0             	movsxd rdx,eax
    1df2:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1df6:	48 8d 3c 02          	lea    rdi,[rdx+rax*1]
    1dfa:	44 8b 4d 38          	mov    r9d,DWORD PTR [rbp+0x38]
    1dfe:	44 8b 45 f8          	mov    r8d,DWORD PTR [rbp-0x8]
    1e02:	8b 4d 10             	mov    ecx,DWORD PTR [rbp+0x10]
    1e05:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    1e09:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1e0d:	48 8b 75 c0          	mov    rsi,QWORD PTR [rbp-0x40]
    1e11:	48 89 34 24          	mov    QWORD PTR [rsp],rsi
    1e15:	48 89 c6             	mov    rsi,rax
    1e18:	e8 00 00 00 00       	call   1e1d <render_text+0x1a1>
												mem, px_x, cur_xv, p0_x, btpp);
								break;
    1e1d:	eb 61                	jmp    1e80 <render_text+0x204>
						case 8:
								render_text_scanline_8btpp(font + l, str,
    1e1f:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1e22:	48 63 d0             	movsxd rdx,eax
    1e25:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1e29:	48 8d 3c 02          	lea    rdi,[rdx+rax*1]
    1e2d:	44 8b 45 38          	mov    r8d,DWORD PTR [rbp+0x38]
    1e31:	8b 75 f8             	mov    esi,DWORD PTR [rbp-0x8]
    1e34:	8b 4d 10             	mov    ecx,DWORD PTR [rbp+0x10]
    1e37:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    1e3b:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1e3f:	45 89 c1             	mov    r9d,r8d
    1e42:	41 89 f0             	mov    r8d,esi
    1e45:	48 89 c6             	mov    rsi,rax
    1e48:	e8 00 00 00 00       	call   1e4d <render_text+0x1d1>
												mem, px_x, cur_xv, p0_x);
								break;
    1e4d:	eb 31                	jmp    1e80 <render_text+0x204>
						default:
/*								render_text_scanline_xbtpp(font + l, str, btpp,
												mem, px_x, cur_xv, p0_x);*/
								die("not impl\n");
    1e4f:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    1e56:	bf 0c 00 00 00       	mov    edi,0xc
    1e5b:	b8 00 00 00 00       	mov    eax,0x0
    1e60:	e8 00 00 00 00       	call   1e65 <render_text+0x1e9>
    1e65:	b8 00 00 00 00       	mov    eax,0x0
    1e6a:	e8 00 00 00 00       	call   1e6f <render_text+0x1f3>
    1e6f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1e76:	e8 00 00 00 00       	call   1e7b <render_text+0x1ff>
    1e7b:	fa                   	cli
    1e7c:	f4                   	hlt
    1e7d:	eb fd                	jmp    1e7c <render_text+0x200>
								break;
    1e7f:	90                   	nop
								break;
				}

				/* advance */
				if (l == 15) {
    1e80:	83 7d f4 0f          	cmp    DWORD PTR [rbp-0xc],0xf
    1e84:	75 08                	jne    1e8e <render_text+0x212>
						str += text_stride;
    1e86:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1e8a:	48 01 45 e0          	add    QWORD PTR [rbp-0x20],rax
				}
				mem += mem_stride;
    1e8e:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1e92:	48 01 45 d8          	add    QWORD PTR [rbp-0x28],rax
		for (ssize_t ln = p0_y; ln < px_y + p0_y; ln++) {
    1e96:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
    1e9a:	8b 55 18             	mov    edx,DWORD PTR [rbp+0x18]
    1e9d:	8b 45 40             	mov    eax,DWORD PTR [rbp+0x40]
    1ea0:	01 d0                	add    eax,edx
    1ea2:	39 45 fc             	cmp    DWORD PTR [rbp-0x4],eax
    1ea5:	0f 8c fc fd ff ff    	jl     1ca7 <render_text+0x2b>
		}
}
    1eab:	90                   	nop
    1eac:	90                   	nop
    1ead:	c9                   	leave
    1eae:	c3                   	ret

0000000000001eaf <add_stride>:
		ssize_t x1, x2;
};

/* adds stride and returns 1 if new element was needed */
int add_stride(struct stride* sb, size_t num, struct stride* s)
{
    1eaf:	55                   	push   rbp
    1eb0:	48 89 e5             	mov    rbp,rsp
    1eb3:	48 83 ec 30          	sub    rsp,0x30
    1eb7:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    1ebb:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
    1ebf:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
		/* assume sortedness (our insertions are sorted) */
		for (size_t i = 0; i < num; i++) {
    1ec3:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
    1ecb:	e9 91 00 00 00       	jmp    1f61 <add_stride+0xb2>
				if (sb[i].x1 == s->x2) { /* extend below */
    1ed0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1ed4:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
    1edc:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1ee0:	48 01 d0             	add    rax,rdx
    1ee3:	8b 10                	mov    edx,DWORD PTR [rax]
    1ee5:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1ee9:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1eec:	39 c2                	cmp    edx,eax
    1eee:	75 25                	jne    1f15 <add_stride+0x66>
						sb[i].x1 = s->x1;
    1ef0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1ef4:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
    1efc:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1f00:	48 01 c2             	add    rdx,rax
    1f03:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1f07:	8b 00                	mov    eax,DWORD PTR [rax]
    1f09:	89 02                	mov    DWORD PTR [rdx],eax
						return 0;
    1f0b:	b8 00 00 00 00       	mov    eax,0x0
    1f10:	e9 25 01 00 00       	jmp    203a <add_stride+0x18b>
				} else if (sb[i].x2 == s->x1) { /* extend above */
    1f15:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1f19:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
    1f21:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1f25:	48 01 d0             	add    rax,rdx
    1f28:	8b 50 04             	mov    edx,DWORD PTR [rax+0x4]
    1f2b:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1f2f:	8b 00                	mov    eax,DWORD PTR [rax]
    1f31:	39 c2                	cmp    edx,eax
    1f33:	75 27                	jne    1f5c <add_stride+0xad>
						sb[i].x2 = s->x2;
    1f35:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1f39:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
    1f41:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1f45:	48 01 c2             	add    rdx,rax
    1f48:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1f4c:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1f4f:	89 42 04             	mov    DWORD PTR [rdx+0x4],eax
						return 0;
    1f52:	b8 00 00 00 00       	mov    eax,0x0
    1f57:	e9 de 00 00 00       	jmp    203a <add_stride+0x18b>
		for (size_t i = 0; i < num; i++) {
    1f5c:	48 83 45 f8 01       	add    QWORD PTR [rbp-0x8],0x1
    1f61:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1f65:	48 3b 45 e0          	cmp    rax,QWORD PTR [rbp-0x20]
    1f69:	0f 82 61 ff ff ff    	jb     1ed0 <add_stride+0x21>
				}
		}
		/* insert sorted */
		for (size_t i = 0; i < num; i++)
    1f6f:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
    1f77:	e9 8e 00 00 00       	jmp    200a <add_stride+0x15b>
				if (sb[i].x1 < s->x2) {
    1f7c:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1f80:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
    1f88:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1f8c:	48 01 d0             	add    rax,rdx
    1f8f:	8b 10                	mov    edx,DWORD PTR [rax]
    1f91:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1f95:	8b 40 04             	mov    eax,DWORD PTR [rax+0x4]
    1f98:	39 c2                	cmp    edx,eax
    1f9a:	7d 69                	jge    2005 <add_stride+0x156>
						memmove(sb + i + 1, sb + i, (num - i) * sizeof(*s));
    1f9c:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1fa0:	48 2b 45 f0          	sub    rax,QWORD PTR [rbp-0x10]
    1fa4:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
    1fac:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1fb0:	48 8d 0c c5 00 00 00 00 	lea    rcx,[rax*8+0x0]
    1fb8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1fbc:	48 01 c1             	add    rcx,rax
    1fbf:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1fc3:	48 83 c0 01          	add    rax,0x1
    1fc7:	48 8d 34 c5 00 00 00 00 	lea    rsi,[rax*8+0x0]
    1fcf:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1fd3:	48 01 f0             	add    rax,rsi
    1fd6:	48 89 ce             	mov    rsi,rcx
    1fd9:	48 89 c7             	mov    rdi,rax
    1fdc:	e8 00 00 00 00       	call   1fe1 <add_stride+0x132>
						sb[i] = *s;
    1fe1:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    1fe5:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
    1fed:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1ff1:	48 01 c2             	add    rdx,rax
    1ff4:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1ff8:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1ffb:	48 89 02             	mov    QWORD PTR [rdx],rax
						return 1;
    1ffe:	b8 01 00 00 00       	mov    eax,0x1
    2003:	eb 35                	jmp    203a <add_stride+0x18b>
		for (size_t i = 0; i < num; i++)
    2005:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
    200a:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    200e:	48 3b 45 e0          	cmp    rax,QWORD PTR [rbp-0x20]
    2012:	0f 82 64 ff ff ff    	jb     1f7c <add_stride+0xcd>
				}
		/* element is last */
		sb[num] = *s;
    2018:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    201c:	48 8d 14 c5 00 00 00 00 	lea    rdx,[rax*8+0x0]
    2024:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    2028:	48 01 c2             	add    rdx,rax
    202b:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    202f:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2032:	48 89 02             	mov    QWORD PTR [rdx],rax
		return 1;
    2035:	b8 01 00 00 00       	mov    eax,0x1
}
    203a:	c9                   	leave
    203b:	c3                   	ret

000000000000203c <framebuffer_redraw>:

uint64_t fb_rdt = 0;
/* redraws the complete screen */
void framebuffer_redraw_region(struct framebuffer* fb, struct kio_region* r);
void framebuffer_redraw(struct framebuffer* fb)
{
    203c:	55                   	push   rbp
    203d:	48 89 e5             	mov    rbp,rsp
    2040:	48 83 ec 30          	sub    rsp,0x30
    2044:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		struct kio_region r = {0}; /* sse alignment */
    2048:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
    2050:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
    2058:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [rbp-0x10],0x0
		r.lx = fb->chw_x; r.ly = fb->chw_y;
    205f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2063:	8b 40 34             	mov    eax,DWORD PTR [rax+0x34]
    2066:	66 89 45 e4          	mov    WORD PTR [rbp-0x1c],ax
    206a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    206e:	8b 40 38             	mov    eax,DWORD PTR [rax+0x38]
    2071:	66 89 45 e6          	mov    WORD PTR [rbp-0x1a],ax
		r.x = fb->cho_x; r.y = fb->cho_y;
    2075:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2079:	8b 40 2c             	mov    eax,DWORD PTR [rax+0x2c]
    207c:	66 89 45 e0          	mov    WORD PTR [rbp-0x20],ax
    2080:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2084:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
    2087:	66 89 45 e2          	mov    WORD PTR [rbp-0x1e],ax
		framebuffer_redraw_region(fb, &r);
    208b:	48 8d 55 e0          	lea    rdx,[rbp-0x20]
    208f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2093:	48 89 d6             	mov    rsi,rdx
    2096:	48 89 c7             	mov    rdi,rax
    2099:	e8 00 00 00 00       	call   209e <framebuffer_redraw+0x62>
}
    209e:	90                   	nop
    209f:	c9                   	leave
    20a0:	c3                   	ret

00000000000020a1 <framebuffer_redraw_region>:

/* redraws a defined region (screen relative, not buffer, internal) */
void framebuffer_redraw_region(struct framebuffer* fb, struct kio_region* r)
{
    20a1:	55                   	push   rbp
    20a2:	48 89 e5             	mov    rbp,rsp
    20a5:	53                   	push   rbx
    20a6:	48 81 ec 08 02 00 00 	sub    rsp,0x208
    20ad:	48 89 bd 38 fe ff ff 	mov    QWORD PTR [rbp-0x1c8],rdi
    20b4:	48 89 b5 30 fe ff ff 	mov    QWORD PTR [rbp-0x1d0],rsi
		if (vga_mem_ptr == fb->text_mem)
    20bb:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    20c2:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    20c5:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 20cc <framebuffer_redraw_region+0x2b>
    20cc:	48 39 c2             	cmp    rdx,rax
    20cf:	0f 84 38 0f 00 00    	je     300d <framebuffer_redraw_region+0xf6c>
				return; /* don't do anything if we're directly on video memory */
		else if (video_mode.is_textmode) {
    20d5:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 20dc <framebuffer_redraw_region+0x3b>
    20dc:	84 c0                	test   al,al
    20de:	0f 84 b1 04 00 00    	je     2595 <framebuffer_redraw_region+0x4f4>
				if (video_mode.width == fb->width && fb->chw_x == fb->width
    20e4:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 20ea <framebuffer_redraw_region+0x49>
    20ea:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    20f1:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    20f4:	39 c2                	cmp    edx,eax
    20f6:	0f 85 e5 01 00 00    	jne    22e1 <framebuffer_redraw_region+0x240>
    20fc:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2103:	8b 50 34             	mov    edx,DWORD PTR [rax+0x34]
    2106:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    210d:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    2110:	39 c2                	cmp    edx,eax
    2112:	0f 85 c9 01 00 00    	jne    22e1 <framebuffer_redraw_region+0x240>
							   && r->lx == fb->width && !fb->pix_x) {
    2118:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    211f:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
    2123:	0f bf d0             	movsx  edx,ax
    2126:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    212d:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    2130:	39 c2                	cmp    edx,eax
    2132:	0f 85 a9 01 00 00    	jne    22e1 <framebuffer_redraw_region+0x240>
    2138:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    213f:	8b 40 24             	mov    eax,DWORD PTR [rax+0x24]
    2142:	85 c0                	test   eax,eax
    2144:	0f 85 97 01 00 00    	jne    22e1 <framebuffer_redraw_region+0x240>
						ssize_t nl;
						/* super easy memory transfer */
						fb->cho_x = 0;
    214a:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2151:	c7 40 2c 00 00 00 00 	mov    DWORD PTR [rax+0x2c],0x0
						nl = min(min(video_mode.height - fb->pix_y, fb->chw_y),
    2158:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    215f:	0f b7 40 06          	movzx  eax,WORD PTR [rax+0x6]
    2163:	0f bf d0             	movsx  edx,ax
    2166:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    216d:	8b 70 0c             	mov    esi,DWORD PTR [rax+0xc]
    2170:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2177:	8b 48 30             	mov    ecx,DWORD PTR [rax+0x30]
    217a:	89 f0                	mov    eax,esi
    217c:	29 c8                	sub    eax,ecx
    217e:	39 c2                	cmp    edx,eax
    2180:	0f 4f d0             	cmovg  edx,eax
    2183:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    218a:	8b 48 38             	mov    ecx,DWORD PTR [rax+0x38]
    218d:	8b 3d 00 00 00 00    	mov    edi,DWORD PTR [rip+0x0]        # 2193 <framebuffer_redraw_region+0xf2>
    2193:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    219a:	8b 70 28             	mov    esi,DWORD PTR [rax+0x28]
    219d:	89 f8                	mov    eax,edi
    219f:	29 f0                	sub    eax,esi
    21a1:	39 c1                	cmp    ecx,eax
    21a3:	0f 4e c1             	cmovle eax,ecx
    21a6:	39 c2                	cmp    edx,eax
    21a8:	0f 4e c2             	cmovle eax,edx
    21ab:	89 85 64 ff ff ff    	mov    DWORD PTR [rbp-0x9c],eax
										min(fb->height - fb->cho_y, r->ly));
						memcpy(vga_mem_ptr + (fb->pix_y + r->y) * 2 * video_mode.width,
										fb->text_mem + (fb->cho_y + r->y) * 2
										* fb->width, nl * 2 * fb->width);
    21b1:	8b 85 64 ff ff ff    	mov    eax,DWORD PTR [rbp-0x9c]
    21b7:	8d 14 00             	lea    edx,[rax+rax*1]
    21ba:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    21c1:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    21c4:	0f af c2             	imul   eax,edx
						memcpy(vga_mem_ptr + (fb->pix_y + r->y) * 2 * video_mode.width,
    21c7:	48 98                	cdqe
										fb->text_mem + (fb->cho_y + r->y) * 2
    21c9:	48 8b 95 38 fe ff ff 	mov    rdx,QWORD PTR [rbp-0x1c8]
    21d0:	48 8b 0a             	mov    rcx,QWORD PTR [rdx]
    21d3:	48 8b 95 38 fe ff ff 	mov    rdx,QWORD PTR [rbp-0x1c8]
    21da:	8b 72 30             	mov    esi,DWORD PTR [rdx+0x30]
    21dd:	48 8b 95 30 fe ff ff 	mov    rdx,QWORD PTR [rbp-0x1d0]
    21e4:	0f b7 52 02          	movzx  edx,WORD PTR [rdx+0x2]
    21e8:	0f bf d2             	movsx  edx,dx
    21eb:	01 f2                	add    edx,esi
    21ed:	8d 34 12             	lea    esi,[rdx+rdx*1]
										* fb->width, nl * 2 * fb->width);
    21f0:	48 8b 95 38 fe ff ff 	mov    rdx,QWORD PTR [rbp-0x1c8]
    21f7:	8b 52 08             	mov    edx,DWORD PTR [rdx+0x8]
    21fa:	0f af d6             	imul   edx,esi
    21fd:	48 63 d2             	movsxd rdx,edx
										fb->text_mem + (fb->cho_y + r->y) * 2
    2200:	48 8d 34 11          	lea    rsi,[rcx+rdx*1]
						memcpy(vga_mem_ptr + (fb->pix_y + r->y) * 2 * video_mode.width,
    2204:	48 8b 0d 00 00 00 00 	mov    rcx,QWORD PTR [rip+0x0]        # 220b <framebuffer_redraw_region+0x16a>
    220b:	48 8b 95 38 fe ff ff 	mov    rdx,QWORD PTR [rbp-0x1c8]
    2212:	8b 7a 28             	mov    edi,DWORD PTR [rdx+0x28]
    2215:	48 8b 95 30 fe ff ff 	mov    rdx,QWORD PTR [rbp-0x1d0]
    221c:	0f b7 52 02          	movzx  edx,WORD PTR [rdx+0x2]
    2220:	0f bf d2             	movsx  edx,dx
    2223:	01 fa                	add    edx,edi
    2225:	8d 3c 12             	lea    edi,[rdx+rdx*1]
    2228:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 222e <framebuffer_redraw_region+0x18d>
    222e:	0f af d7             	imul   edx,edi
    2231:	48 63 d2             	movsxd rdx,edx
    2234:	48 01 d1             	add    rcx,rdx
    2237:	48 89 c2             	mov    rdx,rax
    223a:	48 89 cf             	mov    rdi,rcx
    223d:	e8 be dd ff ff       	call   0 <memcpy>
						/* show we're outside of buffer (for large cho_y) */
						if (nl < fb->chw_y)
    2242:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2249:	8b 40 38             	mov    eax,DWORD PTR [rax+0x38]
    224c:	39 85 64 ff ff ff    	cmp    DWORD PTR [rbp-0x9c],eax
    2252:	0f 8d 37 03 00 00    	jge    258f <framebuffer_redraw_region+0x4ee>
								bzero(vga_mem_ptr + (fb->pix_y + r->y + nl) * 2 * fb->width,
										(min(fb->chw_y, video_mode.height - fb->pix_y)
    2258:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 225e <framebuffer_redraw_region+0x1bd>
    225e:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2265:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    2268:	29 c2                	sub    edx,eax
    226a:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2271:	8b 40 38             	mov    eax,DWORD PTR [rax+0x38]
    2274:	39 c2                	cmp    edx,eax
    2276:	0f 4e c2             	cmovle eax,edx
										 - nl) * fb->width * 2);
    2279:	2b 85 64 ff ff ff    	sub    eax,DWORD PTR [rbp-0x9c]
    227f:	89 c2                	mov    edx,eax
    2281:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2288:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    228b:	0f af c2             	imul   eax,edx
    228e:	01 c0                	add    eax,eax
								bzero(vga_mem_ptr + (fb->pix_y + r->y + nl) * 2 * fb->width,
    2290:	48 98                	cdqe
    2292:	48 8b 0d 00 00 00 00 	mov    rcx,QWORD PTR [rip+0x0]        # 2299 <framebuffer_redraw_region+0x1f8>
    2299:	48 8b 95 38 fe ff ff 	mov    rdx,QWORD PTR [rbp-0x1c8]
    22a0:	8b 72 28             	mov    esi,DWORD PTR [rdx+0x28]
    22a3:	48 8b 95 30 fe ff ff 	mov    rdx,QWORD PTR [rbp-0x1d0]
    22aa:	0f b7 52 02          	movzx  edx,WORD PTR [rdx+0x2]
    22ae:	0f bf d2             	movsx  edx,dx
    22b1:	01 d6                	add    esi,edx
    22b3:	8b 95 64 ff ff ff    	mov    edx,DWORD PTR [rbp-0x9c]
    22b9:	01 f2                	add    edx,esi
    22bb:	8d 34 12             	lea    esi,[rdx+rdx*1]
    22be:	48 8b 95 38 fe ff ff 	mov    rdx,QWORD PTR [rbp-0x1c8]
    22c5:	8b 52 08             	mov    edx,DWORD PTR [rdx+0x8]
    22c8:	0f af d6             	imul   edx,esi
    22cb:	48 63 d2             	movsxd rdx,edx
    22ce:	48 01 ca             	add    rdx,rcx
    22d1:	48 89 c6             	mov    rsi,rax
    22d4:	48 89 d7             	mov    rdi,rdx
    22d7:	e8 00 00 00 00       	call   22dc <framebuffer_redraw_region+0x23b>
							   && r->lx == fb->width && !fb->pix_x) {
    22dc:	e9 ae 02 00 00       	jmp    258f <framebuffer_redraw_region+0x4ee>
				} else {
						ssize_t nl, nc; void *src, *dst;
						/* copy linewise */
						nl = min(min(video_mode.height - fb->pix_y, fb->chw_y),
    22e1:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    22e8:	0f b7 40 06          	movzx  eax,WORD PTR [rax+0x6]
    22ec:	0f bf d0             	movsx  edx,ax
    22ef:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    22f6:	8b 70 0c             	mov    esi,DWORD PTR [rax+0xc]
    22f9:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2300:	8b 48 30             	mov    ecx,DWORD PTR [rax+0x30]
    2303:	89 f0                	mov    eax,esi
    2305:	29 c8                	sub    eax,ecx
    2307:	39 c2                	cmp    edx,eax
    2309:	0f 4f d0             	cmovg  edx,eax
    230c:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2313:	8b 48 38             	mov    ecx,DWORD PTR [rax+0x38]
    2316:	8b 3d 00 00 00 00    	mov    edi,DWORD PTR [rip+0x0]        # 231c <framebuffer_redraw_region+0x27b>
    231c:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2323:	8b 70 28             	mov    esi,DWORD PTR [rax+0x28]
    2326:	89 f8                	mov    eax,edi
    2328:	29 f0                	sub    eax,esi
    232a:	39 c1                	cmp    ecx,eax
    232c:	0f 4e c1             	cmovle eax,ecx
    232f:	39 c2                	cmp    edx,eax
    2331:	0f 4e c2             	cmovle eax,edx
    2334:	89 85 60 ff ff ff    	mov    DWORD PTR [rbp-0xa0],eax
									   	min(fb->height - fb->cho_y, r->ly));
						nc = min(min(video_mode.width - fb->pix_x, fb->chw_x),
    233a:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    2341:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
    2345:	0f bf d0             	movsx  edx,ax
    2348:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    234f:	8b 70 08             	mov    esi,DWORD PTR [rax+0x8]
    2352:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2359:	8b 48 2c             	mov    ecx,DWORD PTR [rax+0x2c]
    235c:	89 f0                	mov    eax,esi
    235e:	29 c8                	sub    eax,ecx
    2360:	39 c2                	cmp    edx,eax
    2362:	0f 4f d0             	cmovg  edx,eax
    2365:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    236c:	8b 48 34             	mov    ecx,DWORD PTR [rax+0x34]
    236f:	8b 3d 00 00 00 00    	mov    edi,DWORD PTR [rip+0x0]        # 2375 <framebuffer_redraw_region+0x2d4>
    2375:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    237c:	8b 70 24             	mov    esi,DWORD PTR [rax+0x24]
    237f:	89 f8                	mov    eax,edi
    2381:	29 f0                	sub    eax,esi
    2383:	39 c1                	cmp    ecx,eax
    2385:	0f 4e c1             	cmovle eax,ecx
    2388:	39 c2                	cmp    edx,eax
    238a:	0f 4e c2             	cmovle eax,edx
    238d:	89 85 5c ff ff ff    	mov    DWORD PTR [rbp-0xa4],eax
										min(fb->width - fb->cho_x, r->lx));
						src = fb->text_mem + (fb->cho_y + r->y) * 2 * fb->width + 2 * (fb->cho_x + r->y);
    2393:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    239a:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    239d:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    23a4:	8b 48 30             	mov    ecx,DWORD PTR [rax+0x30]
    23a7:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    23ae:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    23b2:	98                   	cwde
    23b3:	01 c8                	add    eax,ecx
    23b5:	8d 0c 00             	lea    ecx,[rax+rax*1]
    23b8:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    23bf:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    23c2:	0f af c1             	imul   eax,ecx
    23c5:	48 63 c8             	movsxd rcx,eax
    23c8:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    23cf:	8b 70 2c             	mov    esi,DWORD PTR [rax+0x2c]
    23d2:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    23d9:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    23dd:	98                   	cwde
    23de:	01 f0                	add    eax,esi
    23e0:	01 c0                	add    eax,eax
    23e2:	48 98                	cdqe
    23e4:	48 01 c8             	add    rax,rcx
    23e7:	48 01 d0             	add    rax,rdx
    23ea:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
						dst = vga_mem_ptr + (fb->pix_y + r->y) * 2 * video_mode.width + 2 * (fb->pix_x + r->y);
    23ee:	48 8b 15 00 00 00 00 	mov    rdx,QWORD PTR [rip+0x0]        # 23f5 <framebuffer_redraw_region+0x354>
    23f5:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    23fc:	8b 48 28             	mov    ecx,DWORD PTR [rax+0x28]
    23ff:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    2406:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    240a:	98                   	cwde
    240b:	01 c8                	add    eax,ecx
    240d:	8d 0c 00             	lea    ecx,[rax+rax*1]
    2410:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2416 <framebuffer_redraw_region+0x375>
    2416:	0f af c1             	imul   eax,ecx
    2419:	48 63 c8             	movsxd rcx,eax
    241c:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2423:	8b 70 24             	mov    esi,DWORD PTR [rax+0x24]
    2426:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    242d:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    2431:	98                   	cwde
    2432:	01 f0                	add    eax,esi
    2434:	01 c0                	add    eax,eax
    2436:	48 98                	cdqe
    2438:	48 01 c8             	add    rax,rcx
    243b:	48 01 d0             	add    rax,rdx
    243e:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
						while (nl) {
    2442:	e9 a9 00 00 00       	jmp    24f0 <framebuffer_redraw_region+0x44f>
								memcpy(dst, src, 2 * nc);
    2447:	8b 85 5c ff ff ff    	mov    eax,DWORD PTR [rbp-0xa4]
    244d:	01 c0                	add    eax,eax
    244f:	48 63 d0             	movsxd rdx,eax
    2452:	48 8b 4d e8          	mov    rcx,QWORD PTR [rbp-0x18]
    2456:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    245a:	48 89 ce             	mov    rsi,rcx
    245d:	48 89 c7             	mov    rdi,rax
    2460:	e8 9b db ff ff       	call   0 <memcpy>
								if (nc < min(fb->chw_x, r->lx))
    2465:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    246c:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
    2470:	0f bf d0             	movsx  edx,ax
    2473:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    247a:	8b 40 34             	mov    eax,DWORD PTR [rax+0x34]
    247d:	39 c2                	cmp    edx,eax
    247f:	0f 4e c2             	cmovle eax,edx
    2482:	39 85 5c ff ff ff    	cmp    DWORD PTR [rbp-0xa4],eax
    2488:	7d 46                	jge    24d0 <framebuffer_redraw_region+0x42f>
										bzero(dst + 2 * nc, min(fb->chw_x,
    248a:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 2490 <framebuffer_redraw_region+0x3ef>
    2490:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2497:	8b 40 24             	mov    eax,DWORD PTR [rax+0x24]
    249a:	29 c2                	sub    edx,eax
    249c:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    24a3:	8b 40 34             	mov    eax,DWORD PTR [rax+0x34]
    24a6:	39 c2                	cmp    edx,eax
    24a8:	0f 4e c2             	cmovle eax,edx
											  video_mode.width - fb->pix_x) - nc);
    24ab:	2b 85 5c ff ff ff    	sub    eax,DWORD PTR [rbp-0xa4]
										bzero(dst + 2 * nc, min(fb->chw_x,
    24b1:	48 98                	cdqe
    24b3:	8b 95 5c ff ff ff    	mov    edx,DWORD PTR [rbp-0xa4]
    24b9:	01 d2                	add    edx,edx
    24bb:	48 63 ca             	movsxd rcx,edx
    24be:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    24c2:	48 01 ca             	add    rdx,rcx
    24c5:	48 89 c6             	mov    rsi,rax
    24c8:	48 89 d7             	mov    rdi,rdx
    24cb:	e8 00 00 00 00       	call   24d0 <framebuffer_redraw_region+0x42f>
								dst += video_mode.width * 2;
    24d0:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 24d6 <framebuffer_redraw_region+0x435>
    24d6:	01 c0                	add    eax,eax
    24d8:	48 98                	cdqe
    24da:	48 01 45 e0          	add    QWORD PTR [rbp-0x20],rax
								src += fb->width * 2;
    24de:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    24e5:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    24e8:	01 c0                	add    eax,eax
    24ea:	48 98                	cdqe
    24ec:	48 01 45 e8          	add    QWORD PTR [rbp-0x18],rax
						while (nl) {
    24f0:	83 bd 60 ff ff ff 00 	cmp    DWORD PTR [rbp-0xa0],0x0
    24f7:	0f 85 4a ff ff ff    	jne    2447 <framebuffer_redraw_region+0x3a6>
						}
						/* show we're outside (large cho_...) */
						nc = min(min(fb->chw_x, r->lx), video_mode.width - fb->pix_x);
    24fd:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 2503 <framebuffer_redraw_region+0x462>
    2503:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    250a:	8b 40 24             	mov    eax,DWORD PTR [rax+0x24]
    250d:	89 d1                	mov    ecx,edx
    250f:	29 c1                	sub    ecx,eax
    2511:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    2518:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
    251c:	0f bf d0             	movsx  edx,ax
    251f:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2526:	8b 40 34             	mov    eax,DWORD PTR [rax+0x34]
    2529:	39 c2                	cmp    edx,eax
    252b:	0f 4e c2             	cmovle eax,edx
    252e:	39 c1                	cmp    ecx,eax
    2530:	0f 4e c1             	cmovle eax,ecx
    2533:	89 85 5c ff ff ff    	mov    DWORD PTR [rbp-0xa4],eax
						if (nl < min(fb->chw_y, r->ly)) {
    2539:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    2540:	0f b7 40 06          	movzx  eax,WORD PTR [rax+0x6]
    2544:	0f bf d0             	movsx  edx,ax
    2547:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    254e:	8b 40 38             	mov    eax,DWORD PTR [rax+0x38]
    2551:	39 c2                	cmp    edx,eax
    2553:	0f 4e c2             	cmovle eax,edx
    2556:	39 85 60 ff ff ff    	cmp    DWORD PTR [rbp-0xa0],eax
    255c:	0f 8d ae 0a 00 00    	jge    3010 <framebuffer_redraw_region+0xf6f>
								bzero(dst, 2 * nc);
    2562:	8b 85 5c ff ff ff    	mov    eax,DWORD PTR [rbp-0xa4]
    2568:	01 c0                	add    eax,eax
    256a:	48 63 d0             	movsxd rdx,eax
    256d:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    2571:	48 89 d6             	mov    rsi,rdx
    2574:	48 89 c7             	mov    rdi,rax
    2577:	e8 00 00 00 00       	call   257c <framebuffer_redraw_region+0x4db>
								dst += video_mode.width * 2;
    257c:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2582 <framebuffer_redraw_region+0x4e1>
    2582:	01 c0                	add    eax,eax
    2584:	48 98                	cdqe
    2586:	48 01 45 e0          	add    QWORD PTR [rbp-0x20],rax
						}
				}
				return;
    258a:	e9 81 0a 00 00       	jmp    3010 <framebuffer_redraw_region+0xf6f>
							   && r->lx == fb->width && !fb->pix_x) {
    258f:	90                   	nop
				return;
    2590:	e9 7b 0a 00 00       	jmp    3010 <framebuffer_redraw_region+0xf6f>
		} else {
				int shf = 0;
    2595:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [rbp-0x24],0x0
				void* mem = vga_mem_ptr; char* str = fb->text_mem;
    259c:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 25a3 <framebuffer_redraw_region+0x502>
    25a3:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
    25a7:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    25ae:	48 8b 00             	mov    rax,QWORD PTR [rax]
    25b1:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
				ssize_t px_x, px_y, o_x, o_y;

				/* calculate the pixel offsets */
				o_x = fb->pix_x + r->x * 8;
    25b5:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    25bc:	8b 50 24             	mov    edx,DWORD PTR [rax+0x24]
    25bf:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    25c6:	0f b7 00             	movzx  eax,WORD PTR [rax]
    25c9:	98                   	cwde
    25ca:	c1 e0 03             	shl    eax,0x3
    25cd:	01 d0                	add    eax,edx
    25cf:	89 85 7c ff ff ff    	mov    DWORD PTR [rbp-0x84],eax
				o_y = fb->pix_y + r->y * 16;
    25d5:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    25dc:	8b 50 28             	mov    edx,DWORD PTR [rax+0x28]
    25df:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    25e6:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    25ea:	98                   	cwde
    25eb:	c1 e0 04             	shl    eax,0x4
    25ee:	01 d0                	add    eax,edx
    25f0:	89 85 78 ff ff ff    	mov    DWORD PTR [rbp-0x88],eax
				px_x = r->lx * 8;
    25f6:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    25fd:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
    2601:	98                   	cwde
    2602:	c1 e0 03             	shl    eax,0x3
    2605:	89 85 74 ff ff ff    	mov    DWORD PTR [rbp-0x8c],eax
				px_y = r->ly * 16;
    260b:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    2612:	0f b7 40 06          	movzx  eax,WORD PTR [rax+0x6]
    2616:	98                   	cwde
    2617:	c1 e0 04             	shl    eax,0x4
    261a:	89 85 70 ff ff ff    	mov    DWORD PTR [rbp-0x90],eax
				/* and ensure the bounds */
				if (o_x >= video_mode.width || o_y >= video_mode.height)
    2620:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2626 <framebuffer_redraw_region+0x585>
    2626:	39 85 7c ff ff ff    	cmp    DWORD PTR [rbp-0x84],eax
    262c:	0f 8d e1 09 00 00    	jge    3013 <framebuffer_redraw_region+0xf72>
    2632:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2638 <framebuffer_redraw_region+0x597>
    2638:	39 85 78 ff ff ff    	cmp    DWORD PTR [rbp-0x88],eax
    263e:	0f 8d cf 09 00 00    	jge    3013 <framebuffer_redraw_region+0xf72>
					return;
				/* from the text buffer */
				px_x = min(px_x, 8 * min(fb->width - fb->cho_x - r->x, fb->chw_x - r->x));
    2644:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    264b:	8b 50 08             	mov    edx,DWORD PTR [rax+0x8]
    264e:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2655:	8b 40 2c             	mov    eax,DWORD PTR [rax+0x2c]
    2658:	29 c2                	sub    edx,eax
    265a:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2661:	8b 40 34             	mov    eax,DWORD PTR [rax+0x34]
    2664:	39 c2                	cmp    edx,eax
    2666:	7d 2c                	jge    2694 <framebuffer_redraw_region+0x5f3>
    2668:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    266f:	8b 50 08             	mov    edx,DWORD PTR [rax+0x8]
    2672:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2679:	8b 40 2c             	mov    eax,DWORD PTR [rax+0x2c]
    267c:	29 c2                	sub    edx,eax
    267e:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    2685:	0f b7 00             	movzx  eax,WORD PTR [rax]
    2688:	98                   	cwde
    2689:	29 c2                	sub    edx,eax
    268b:	8d 04 d5 00 00 00 00 	lea    eax,[rdx*8+0x0]
    2692:	eb 1e                	jmp    26b2 <framebuffer_redraw_region+0x611>
    2694:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    269b:	8b 50 34             	mov    edx,DWORD PTR [rax+0x34]
    269e:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    26a5:	0f b7 00             	movzx  eax,WORD PTR [rax]
    26a8:	98                   	cwde
    26a9:	29 c2                	sub    edx,eax
    26ab:	8d 04 d5 00 00 00 00 	lea    eax,[rdx*8+0x0]
    26b2:	8b 95 74 ff ff ff    	mov    edx,DWORD PTR [rbp-0x8c]
    26b8:	39 c2                	cmp    edx,eax
    26ba:	0f 4e c2             	cmovle eax,edx
    26bd:	89 85 74 ff ff ff    	mov    DWORD PTR [rbp-0x8c],eax
				px_y = min(px_y, 16 * min(fb->height - fb->cho_y - r->y, fb->chw_y - r->y));
    26c3:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    26ca:	8b 50 0c             	mov    edx,DWORD PTR [rax+0xc]
    26cd:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    26d4:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
    26d7:	29 c2                	sub    edx,eax
    26d9:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    26e0:	8b 40 38             	mov    eax,DWORD PTR [rax+0x38]
    26e3:	39 c2                	cmp    edx,eax
    26e5:	7d 2b                	jge    2712 <framebuffer_redraw_region+0x671>
    26e7:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    26ee:	8b 50 0c             	mov    edx,DWORD PTR [rax+0xc]
    26f1:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    26f8:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
    26fb:	29 c2                	sub    edx,eax
    26fd:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    2704:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    2708:	98                   	cwde
    2709:	29 c2                	sub    edx,eax
    270b:	89 d0                	mov    eax,edx
    270d:	c1 e0 04             	shl    eax,0x4
    2710:	eb 1d                	jmp    272f <framebuffer_redraw_region+0x68e>
    2712:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2719:	8b 50 38             	mov    edx,DWORD PTR [rax+0x38]
    271c:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    2723:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    2727:	98                   	cwde
    2728:	29 c2                	sub    edx,eax
    272a:	89 d0                	mov    eax,edx
    272c:	c1 e0 04             	shl    eax,0x4
    272f:	8b 95 70 ff ff ff    	mov    edx,DWORD PTR [rbp-0x90]
    2735:	39 c2                	cmp    edx,eax
    2737:	0f 4e c2             	cmovle eax,edx
    273a:	89 85 70 ff ff ff    	mov    DWORD PTR [rbp-0x90],eax
				/* and from video memory */
				px_x = min(px_x, video_mode.width - o_x);
    2740:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2746 <framebuffer_redraw_region+0x6a5>
    2746:	2b 85 7c ff ff ff    	sub    eax,DWORD PTR [rbp-0x84]
    274c:	8b 95 74 ff ff ff    	mov    edx,DWORD PTR [rbp-0x8c]
    2752:	39 c2                	cmp    edx,eax
    2754:	0f 4e c2             	cmovle eax,edx
    2757:	89 85 74 ff ff ff    	mov    DWORD PTR [rbp-0x8c],eax
				px_y = min(px_y, video_mode.height - o_y);
    275d:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2763 <framebuffer_redraw_region+0x6c2>
    2763:	2b 85 78 ff ff ff    	sub    eax,DWORD PTR [rbp-0x88]
    2769:	8b 95 70 ff ff ff    	mov    edx,DWORD PTR [rbp-0x90]
    276f:	39 c2                	cmp    edx,eax
    2771:	0f 4e c2             	cmovle eax,edx
    2774:	89 85 70 ff ff ff    	mov    DWORD PTR [rbp-0x90],eax
				if (px_x < 0 || px_y < 0)
    277a:	83 bd 74 ff ff ff 00 	cmp    DWORD PTR [rbp-0x8c],0x0
    2781:	0f 88 8f 08 00 00    	js     3016 <framebuffer_redraw_region+0xf75>
    2787:	83 bd 70 ff ff ff 00 	cmp    DWORD PTR [rbp-0x90],0x0
    278e:	0f 88 82 08 00 00    	js     3016 <framebuffer_redraw_region+0xf75>
					return;
				
				if (video_mode.gm_bts == 4)
    2794:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 279b <framebuffer_redraw_region+0x6fa>
    279b:	3c 04                	cmp    al,0x4
    279d:	75 23                	jne    27c2 <framebuffer_redraw_region+0x721>
					shf = ((o_x % 2) == 1);
    279f:	8b 95 7c ff ff ff    	mov    edx,DWORD PTR [rbp-0x84]
    27a5:	89 d0                	mov    eax,edx
    27a7:	c1 f8 1f             	sar    eax,0x1f
    27aa:	c1 e8 1f             	shr    eax,0x1f
    27ad:	01 c2                	add    edx,eax
    27af:	83 e2 01             	and    edx,0x1
    27b2:	29 c2                	sub    edx,eax
    27b4:	89 d0                	mov    eax,edx
    27b6:	83 f8 01             	cmp    eax,0x1
    27b9:	0f 94 c0             	sete   al
    27bc:	0f b6 c0             	movzx  eax,al
    27bf:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
				
				/* set the memory references */
				mem += o_y * video_mode.bpsl + o_x * video_mode.btpp;
    27c2:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 27c8 <framebuffer_redraw_region+0x727>
    27c8:	8b 85 78 ff ff ff    	mov    eax,DWORD PTR [rbp-0x88]
    27ce:	0f af d0             	imul   edx,eax
    27d1:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 27d8 <framebuffer_redraw_region+0x737>
    27d8:	0f be c0             	movsx  eax,al
    27db:	0f af 85 7c ff ff ff 	imul   eax,DWORD PTR [rbp-0x84]
    27e2:	01 d0                	add    eax,edx
    27e4:	89 c0                	mov    eax,eax
    27e6:	48 01 45 d0          	add    QWORD PTR [rbp-0x30],rax
				str += (fb->cho_y + r->y) * 2 * fb->width + (fb->cho_x + r->x) * 2;
    27ea:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    27f1:	8b 50 30             	mov    edx,DWORD PTR [rax+0x30]
    27f4:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    27fb:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    27ff:	98                   	cwde
    2800:	01 d0                	add    eax,edx
    2802:	8d 14 00             	lea    edx,[rax+rax*1]
    2805:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    280c:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    280f:	0f af d0             	imul   edx,eax
    2812:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2819:	8b 48 2c             	mov    ecx,DWORD PTR [rax+0x2c]
    281c:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    2823:	0f b7 00             	movzx  eax,WORD PTR [rax]
    2826:	98                   	cwde
    2827:	01 c8                	add    eax,ecx
    2829:	01 c0                	add    eax,eax
    282b:	01 d0                	add    eax,edx
    282d:	48 98                	cdqe
    282f:	48 01 45 c8          	add    QWORD PTR [rbp-0x38],rax

				/* check for excluding rects */
				if (fb->r_excl) {
    2833:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    283a:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    283e:	48 85 c0             	test   rax,rax
    2841:	0f 84 1c 07 00 00    	je     2f63 <framebuffer_redraw_region+0xec2>
						/* use y and x stride marks */
						size_t ns_y = 0, ns_x = 0;
    2847:	48 c7 45 c0 00 00 00 00 	mov    QWORD PTR [rbp-0x40],0x0
    284f:	48 c7 45 b8 00 00 00 00 	mov    QWORD PTR [rbp-0x48],0x0
						struct stride /* exclude range:  y is key */
								stride_y[10], stride_x[20];
						struct exclude_rect* pe = fb->r_excl;
    2857:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    285e:	48 8b 40 48          	mov    rax,QWORD PTR [rax+0x48]
    2862:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
						while (pe) {
    2866:	e9 f3 01 00 00       	jmp    2a5e <framebuffer_redraw_region+0x9bd>
								struct exclude_rect er = {0};
    286b:	48 c7 85 40 ff ff ff 00 00 00 00 	mov    QWORD PTR [rbp-0xc0],0x0
    2876:	48 c7 85 48 ff ff ff 00 00 00 00 	mov    QWORD PTR [rbp-0xb8],0x0
    2881:	48 c7 85 50 ff ff ff 00 00 00 00 	mov    QWORD PTR [rbp-0xb0],0x0
								er = *pe;
    288c:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2890:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    2893:	48 89 95 40 ff ff ff 	mov    QWORD PTR [rbp-0xc0],rdx
    289a:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
    289e:	48 89 95 48 ff ff ff 	mov    QWORD PTR [rbp-0xb8],rdx
    28a5:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    28a9:	48 89 85 50 ff ff ff 	mov    QWORD PTR [rbp-0xb0],rax
								er.x -= fb->pix_x;
    28b0:	8b 95 40 ff ff ff    	mov    edx,DWORD PTR [rbp-0xc0]
    28b6:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    28bd:	8b 40 24             	mov    eax,DWORD PTR [rax+0x24]
    28c0:	29 c2                	sub    edx,eax
    28c2:	89 95 40 ff ff ff    	mov    DWORD PTR [rbp-0xc0],edx
								er.y -= fb->pix_y;
    28c8:	8b 95 44 ff ff ff    	mov    edx,DWORD PTR [rbp-0xbc]
    28ce:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    28d5:	8b 40 28             	mov    eax,DWORD PTR [rax+0x28]
    28d8:	29 c2                	sub    edx,eax
    28da:	89 95 44 ff ff ff    	mov    DWORD PTR [rbp-0xbc],edx
								if (er.x + er.lx > o_x && er.y + er.ly > o_y) {
    28e0:	8b 95 40 ff ff ff    	mov    edx,DWORD PTR [rbp-0xc0]
    28e6:	8b 85 48 ff ff ff    	mov    eax,DWORD PTR [rbp-0xb8]
    28ec:	01 d0                	add    eax,edx
    28ee:	39 85 7c ff ff ff    	cmp    DWORD PTR [rbp-0x84],eax
    28f4:	0f 8d 58 01 00 00    	jge    2a52 <framebuffer_redraw_region+0x9b1>
    28fa:	8b 95 44 ff ff ff    	mov    edx,DWORD PTR [rbp-0xbc]
    2900:	8b 85 4c ff ff ff    	mov    eax,DWORD PTR [rbp-0xb4]
    2906:	01 d0                	add    eax,edx
    2908:	39 85 78 ff ff ff    	cmp    DWORD PTR [rbp-0x88],eax
    290e:	0f 8d 3e 01 00 00    	jge    2a52 <framebuffer_redraw_region+0x9b1>
										if (o_x + px_x > er.x && o_y + px_y > er.y) {
    2914:	8b 95 7c ff ff ff    	mov    edx,DWORD PTR [rbp-0x84]
    291a:	8b 85 74 ff ff ff    	mov    eax,DWORD PTR [rbp-0x8c]
    2920:	01 c2                	add    edx,eax
    2922:	8b 85 40 ff ff ff    	mov    eax,DWORD PTR [rbp-0xc0]
    2928:	39 c2                	cmp    edx,eax
    292a:	0f 8e 22 01 00 00    	jle    2a52 <framebuffer_redraw_region+0x9b1>
    2930:	8b 95 78 ff ff ff    	mov    edx,DWORD PTR [rbp-0x88]
    2936:	8b 85 70 ff ff ff    	mov    eax,DWORD PTR [rbp-0x90]
    293c:	01 c2                	add    edx,eax
    293e:	8b 85 44 ff ff ff    	mov    eax,DWORD PTR [rbp-0xbc]
    2944:	39 c2                	cmp    edx,eax
    2946:	0f 8e 06 01 00 00    	jle    2a52 <framebuffer_redraw_region+0x9b1>
												struct stride sx, sy;
												/* overlap y */
												if (ns_y == 10 || ns_x == 20) /* we could draw parts */
    294c:	48 83 7d c0 0a       	cmp    QWORD PTR [rbp-0x40],0xa
    2951:	74 07                	je     295a <framebuffer_redraw_region+0x8b9>
    2953:	48 83 7d b8 14       	cmp    QWORD PTR [rbp-0x48],0x14
    2958:	75 30                	jne    298a <framebuffer_redraw_region+0x8e9>
														die("use bigger fb stride buffers\n");
    295a:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
    2961:	bf 0c 00 00 00       	mov    edi,0xc
    2966:	b8 00 00 00 00       	mov    eax,0x0
    296b:	e8 00 00 00 00       	call   2970 <framebuffer_redraw_region+0x8cf>
    2970:	b8 00 00 00 00       	mov    eax,0x0
    2975:	e8 00 00 00 00       	call   297a <framebuffer_redraw_region+0x8d9>
    297a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2981:	e8 00 00 00 00       	call   2986 <framebuffer_redraw_region+0x8e5>
    2986:	fa                   	cli
    2987:	f4                   	hlt
    2988:	eb fd                	jmp    2987 <framebuffer_redraw_region+0x8e6>
												/* crop the rect and insert two strides */
												sx.x1 = max(o_x, er.x);
    298a:	8b 95 40 ff ff ff    	mov    edx,DWORD PTR [rbp-0xc0]
    2990:	8b 85 7c ff ff ff    	mov    eax,DWORD PTR [rbp-0x84]
    2996:	39 c2                	cmp    edx,eax
    2998:	0f 4d c2             	cmovge eax,edx
    299b:	89 85 38 ff ff ff    	mov    DWORD PTR [rbp-0xc8],eax
												sx.x2 = min(er.x + er.lx, o_x + px_x);
    29a1:	8b 95 7c ff ff ff    	mov    edx,DWORD PTR [rbp-0x84]
    29a7:	8b 85 74 ff ff ff    	mov    eax,DWORD PTR [rbp-0x8c]
    29ad:	01 c2                	add    edx,eax
    29af:	8b 8d 40 ff ff ff    	mov    ecx,DWORD PTR [rbp-0xc0]
    29b5:	8b 85 48 ff ff ff    	mov    eax,DWORD PTR [rbp-0xb8]
    29bb:	01 c8                	add    eax,ecx
    29bd:	39 c2                	cmp    edx,eax
    29bf:	0f 4e c2             	cmovle eax,edx
    29c2:	89 85 3c ff ff ff    	mov    DWORD PTR [rbp-0xc4],eax
												sy.x1 = max(o_y, er.y);
    29c8:	8b 95 44 ff ff ff    	mov    edx,DWORD PTR [rbp-0xbc]
    29ce:	8b 85 78 ff ff ff    	mov    eax,DWORD PTR [rbp-0x88]
    29d4:	39 c2                	cmp    edx,eax
    29d6:	0f 4d c2             	cmovge eax,edx
    29d9:	89 85 30 ff ff ff    	mov    DWORD PTR [rbp-0xd0],eax
												sy.x2 = min(er.y + er.ly, o_y + px_y);
    29df:	8b 95 78 ff ff ff    	mov    edx,DWORD PTR [rbp-0x88]
    29e5:	8b 85 70 ff ff ff    	mov    eax,DWORD PTR [rbp-0x90]
    29eb:	01 c2                	add    edx,eax
    29ed:	8b 8d 44 ff ff ff    	mov    ecx,DWORD PTR [rbp-0xbc]
    29f3:	8b 85 4c ff ff ff    	mov    eax,DWORD PTR [rbp-0xb4]
    29f9:	01 c8                	add    eax,ecx
    29fb:	39 c2                	cmp    edx,eax
    29fd:	0f 4e c2             	cmovle eax,edx
    2a00:	89 85 34 ff ff ff    	mov    DWORD PTR [rbp-0xcc],eax
												if(add_stride(stride_y, ns_y, &sy))
    2a06:	48 8d 95 30 ff ff ff 	lea    rdx,[rbp-0xd0]
    2a0d:	48 8b 4d c0          	mov    rcx,QWORD PTR [rbp-0x40]
    2a11:	48 8d 85 40 fe ff ff 	lea    rax,[rbp-0x1c0]
    2a18:	48 89 ce             	mov    rsi,rcx
    2a1b:	48 89 c7             	mov    rdi,rax
    2a1e:	e8 00 00 00 00       	call   2a23 <framebuffer_redraw_region+0x982>
    2a23:	85 c0                	test   eax,eax
    2a25:	74 05                	je     2a2c <framebuffer_redraw_region+0x98b>
														ns_y++;
    2a27:	48 83 45 c0 01       	add    QWORD PTR [rbp-0x40],0x1
												if (add_stride(stride_x, ns_x, &sx))
    2a2c:	48 8d 95 38 ff ff ff 	lea    rdx,[rbp-0xc8]
    2a33:	48 8b 4d b8          	mov    rcx,QWORD PTR [rbp-0x48]
    2a37:	48 8d 85 90 fe ff ff 	lea    rax,[rbp-0x170]
    2a3e:	48 89 ce             	mov    rsi,rcx
    2a41:	48 89 c7             	mov    rdi,rax
    2a44:	e8 00 00 00 00       	call   2a49 <framebuffer_redraw_region+0x9a8>
    2a49:	85 c0                	test   eax,eax
    2a4b:	74 05                	je     2a52 <framebuffer_redraw_region+0x9b1>
														ns_x++;
    2a4d:	48 83 45 b8 01       	add    QWORD PTR [rbp-0x48],0x1
										}
								}
								pe = pe->next;
    2a52:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2a56:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    2a5a:	48 89 45 b0          	mov    QWORD PTR [rbp-0x50],rax
						while (pe) {
    2a5e:	48 83 7d b0 00       	cmp    QWORD PTR [rbp-0x50],0x0
    2a63:	0f 85 02 fe ff ff    	jne    286b <framebuffer_redraw_region+0x7ca>
						}
						/* add the dummy entries (so we don't have to check at +x) */
						stride_y[ns_y].x1 = o_y + px_y;
    2a69:	8b 95 78 ff ff ff    	mov    edx,DWORD PTR [rbp-0x88]
    2a6f:	8b 85 70 ff ff ff    	mov    eax,DWORD PTR [rbp-0x90]
    2a75:	01 c2                	add    edx,eax
    2a77:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2a7b:	89 94 c5 40 fe ff ff 	mov    DWORD PTR [rbp+rax*8-0x1c0],edx
						stride_y[ns_y++].x2 = o_y + px_y;
    2a82:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2a86:	48 8d 50 01          	lea    rdx,[rax+0x1]
    2a8a:	48 89 55 c0          	mov    QWORD PTR [rbp-0x40],rdx
    2a8e:	8b 8d 78 ff ff ff    	mov    ecx,DWORD PTR [rbp-0x88]
    2a94:	8b 95 70 ff ff ff    	mov    edx,DWORD PTR [rbp-0x90]
    2a9a:	01 ca                	add    edx,ecx
    2a9c:	89 94 c5 44 fe ff ff 	mov    DWORD PTR [rbp+rax*8-0x1bc],edx
						stride_x[ns_x].x1 = o_x + px_x;
    2aa3:	8b 95 7c ff ff ff    	mov    edx,DWORD PTR [rbp-0x84]
    2aa9:	8b 85 74 ff ff ff    	mov    eax,DWORD PTR [rbp-0x8c]
    2aaf:	01 c2                	add    edx,eax
    2ab1:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2ab5:	89 94 c5 90 fe ff ff 	mov    DWORD PTR [rbp+rax*8-0x170],edx
						stride_x[ns_x++].x2 = o_x + px_x;
    2abc:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    2ac0:	48 8d 50 01          	lea    rdx,[rax+0x1]
    2ac4:	48 89 55 b8          	mov    QWORD PTR [rbp-0x48],rdx
    2ac8:	8b 8d 7c ff ff ff    	mov    ecx,DWORD PTR [rbp-0x84]
    2ace:	8b 95 74 ff ff ff    	mov    edx,DWORD PTR [rbp-0x8c]
    2ad4:	01 ca                	add    edx,ecx
    2ad6:	89 94 c5 94 fe ff ff 	mov    DWORD PTR [rbp+rax*8-0x16c],edx
						if (ns_y > 1 && ns_x > 1) {
    2add:	48 83 7d c0 01       	cmp    QWORD PTR [rbp-0x40],0x1
    2ae2:	0f 86 7b 04 00 00    	jbe    2f63 <framebuffer_redraw_region+0xec2>
    2ae8:	48 83 7d b8 01       	cmp    QWORD PTR [rbp-0x48],0x1
    2aed:	0f 86 70 04 00 00    	jbe    2f63 <framebuffer_redraw_region+0xec2>
								ssize_t lpx_x, lpx_y, lo_x = o_x, lo_y = o_y;
    2af3:	8b 85 7c ff ff ff    	mov    eax,DWORD PTR [rbp-0x84]
    2af9:	89 45 ac             	mov    DWORD PTR [rbp-0x54],eax
    2afc:	8b 85 78 ff ff ff    	mov    eax,DWORD PTR [rbp-0x88]
    2b02:	89 45 a8             	mov    DWORD PTR [rbp-0x58],eax
								char* str2 = str; int shf2 = shf; void* mem2;
    2b05:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    2b09:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
    2b0d:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    2b10:	89 45 9c             	mov    DWORD PTR [rbp-0x64],eax
								/* now we have a field of strides */
								for (size_t i = 0; i < ns_y; i++) {
    2b13:	48 c7 45 88 00 00 00 00 	mov    QWORD PTR [rbp-0x78],0x0
    2b1b:	e9 30 04 00 00       	jmp    2f50 <framebuffer_redraw_region+0xeaf>
										/* draw full lines before the stride */
										if (stride_y[i].x1 > lo_y) {
    2b20:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2b24:	8b 84 c5 40 fe ff ff 	mov    eax,DWORD PTR [rbp+rax*8-0x1c0]
    2b2b:	39 45 a8             	cmp    DWORD PTR [rbp-0x58],eax
    2b2e:	0f 8d 2e 01 00 00    	jge    2c62 <framebuffer_redraw_region+0xbc1>
												lpx_x = px_x;
    2b34:	8b 85 74 ff ff ff    	mov    eax,DWORD PTR [rbp-0x8c]
    2b3a:	89 85 6c ff ff ff    	mov    DWORD PTR [rbp-0x94],eax
												lo_x = o_x;
    2b40:	8b 85 7c ff ff ff    	mov    eax,DWORD PTR [rbp-0x84]
    2b46:	89 45 ac             	mov    DWORD PTR [rbp-0x54],eax
												shf2 = shf;
    2b49:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    2b4c:	89 45 9c             	mov    DWORD PTR [rbp-0x64],eax
												lpx_y = min(stride_y[i].x1 - lo_y, o_y + px_y - lo_y);
    2b4f:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2b53:	8b 94 c5 40 fe ff ff 	mov    edx,DWORD PTR [rbp+rax*8-0x1c0]
    2b5a:	8b 8d 78 ff ff ff    	mov    ecx,DWORD PTR [rbp-0x88]
    2b60:	8b 85 70 ff ff ff    	mov    eax,DWORD PTR [rbp-0x90]
    2b66:	01 c8                	add    eax,ecx
    2b68:	39 c2                	cmp    edx,eax
    2b6a:	7d 10                	jge    2b7c <framebuffer_redraw_region+0xadb>
    2b6c:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2b70:	8b 84 c5 40 fe ff ff 	mov    eax,DWORD PTR [rbp+rax*8-0x1c0]
    2b77:	2b 45 a8             	sub    eax,DWORD PTR [rbp-0x58]
    2b7a:	eb 11                	jmp    2b8d <framebuffer_redraw_region+0xaec>
    2b7c:	8b 95 78 ff ff ff    	mov    edx,DWORD PTR [rbp-0x88]
    2b82:	8b 85 70 ff ff ff    	mov    eax,DWORD PTR [rbp-0x90]
    2b88:	01 d0                	add    eax,edx
    2b8a:	2b 45 a8             	sub    eax,DWORD PTR [rbp-0x58]
    2b8d:	89 85 68 ff ff ff    	mov    DWORD PTR [rbp-0x98],eax
												if (lpx_y) /* skip empty dummy */
    2b93:	83 bd 68 ff ff ff 00 	cmp    DWORD PTR [rbp-0x98],0x0
    2b9a:	0f 84 c2 00 00 00    	je     2c62 <framebuffer_redraw_region+0xbc1>
													render_text(fb->font, str2, mem, 2 * fb->width,
														video_mode.bpsl, video_mode.gm_bts, lpx_x,
														lpx_y, shf2, fb->cur_x - r->x, fb->cur_y - r->y,
														0, (lo_y - o_y) % 16);
    2ba0:	8b 45 a8             	mov    eax,DWORD PTR [rbp-0x58]
    2ba3:	2b 85 78 ff ff ff    	sub    eax,DWORD PTR [rbp-0x88]
    2ba9:	89 c2                	mov    edx,eax
													render_text(fb->font, str2, mem, 2 * fb->width,
    2bab:	89 d0                	mov    eax,edx
    2bad:	c1 f8 1f             	sar    eax,0x1f
    2bb0:	c1 e8 1c             	shr    eax,0x1c
    2bb3:	01 c2                	add    edx,eax
    2bb5:	83 e2 0f             	and    edx,0xf
    2bb8:	29 c2                	sub    edx,eax
    2bba:	41 89 d2             	mov    r10d,edx
														lpx_y, shf2, fb->cur_x - r->x, fb->cur_y - r->y,
    2bbd:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2bc4:	8b 50 20             	mov    edx,DWORD PTR [rax+0x20]
    2bc7:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    2bce:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    2bd2:	98                   	cwde
													render_text(fb->font, str2, mem, 2 * fb->width,
    2bd3:	29 c2                	sub    edx,eax
    2bd5:	41 89 d0             	mov    r8d,edx
														lpx_y, shf2, fb->cur_x - r->x, fb->cur_y - r->y,
    2bd8:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2bdf:	8b 50 1c             	mov    edx,DWORD PTR [rax+0x1c]
    2be2:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    2be9:	0f b7 00             	movzx  eax,WORD PTR [rax]
    2bec:	98                   	cwde
													render_text(fb->font, str2, mem, 2 * fb->width,
    2bed:	89 d7                	mov    edi,edx
    2bef:	29 c7                	sub    edi,eax
														video_mode.bpsl, video_mode.gm_bts, lpx_x,
    2bf1:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2bf8 <framebuffer_redraw_region+0xb57>
													render_text(fb->font, str2, mem, 2 * fb->width,
    2bf8:	4c 0f be c8          	movsx  r9,al
														video_mode.bpsl, video_mode.gm_bts, lpx_x,
    2bfc:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2c02 <framebuffer_redraw_region+0xb61>
													render_text(fb->font, str2, mem, 2 * fb->width,
    2c02:	41 89 c3             	mov    r11d,eax
    2c05:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2c0c:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    2c0f:	01 c0                	add    eax,eax
    2c11:	48 63 c8             	movsxd rcx,eax
    2c14:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2c1b:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    2c1f:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    2c23:	48 8b 75 a0          	mov    rsi,QWORD PTR [rbp-0x60]
    2c27:	44 89 54 24 30       	mov    DWORD PTR [rsp+0x30],r10d
    2c2c:	c7 44 24 28 00 00 00 00 	mov    DWORD PTR [rsp+0x28],0x0
    2c34:	44 89 44 24 20       	mov    DWORD PTR [rsp+0x20],r8d
    2c39:	89 7c 24 18          	mov    DWORD PTR [rsp+0x18],edi
    2c3d:	8b 7d 9c             	mov    edi,DWORD PTR [rbp-0x64]
    2c40:	89 7c 24 10          	mov    DWORD PTR [rsp+0x10],edi
    2c44:	8b bd 68 ff ff ff    	mov    edi,DWORD PTR [rbp-0x98]
    2c4a:	89 7c 24 08          	mov    DWORD PTR [rsp+0x8],edi
    2c4e:	8b bd 6c ff ff ff    	mov    edi,DWORD PTR [rbp-0x94]
    2c54:	89 3c 24             	mov    DWORD PTR [rsp],edi
    2c57:	4d 89 d8             	mov    r8,r11
    2c5a:	48 89 c7             	mov    rdi,rax
    2c5d:	e8 00 00 00 00       	call   2c62 <framebuffer_redraw_region+0xbc1>
										}
										/* we are inside the stride */
										/* update the references */
										mem += (stride_y[i].x1 - lo_y) * video_mode.bpsl;
    2c62:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2c66:	8b 84 c5 40 fe ff ff 	mov    eax,DWORD PTR [rbp+rax*8-0x1c0]
    2c6d:	2b 45 a8             	sub    eax,DWORD PTR [rbp-0x58]
    2c70:	89 c2                	mov    edx,eax
    2c72:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2c78 <framebuffer_redraw_region+0xbd7>
    2c78:	0f af c2             	imul   eax,edx
    2c7b:	89 c0                	mov    eax,eax
    2c7d:	48 01 45 d0          	add    QWORD PTR [rbp-0x30],rax
										str += ((stride_y[i].x1 - lo_y) / 16) * 2 * fb->width;
    2c81:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2c85:	8b 84 c5 40 fe ff ff 	mov    eax,DWORD PTR [rbp+rax*8-0x1c0]
    2c8c:	2b 45 a8             	sub    eax,DWORD PTR [rbp-0x58]
    2c8f:	8d 50 0f             	lea    edx,[rax+0xf]
    2c92:	85 c0                	test   eax,eax
    2c94:	0f 48 c2             	cmovs  eax,edx
    2c97:	c1 f8 04             	sar    eax,0x4
    2c9a:	8d 14 00             	lea    edx,[rax+rax*1]
    2c9d:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2ca4:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    2ca7:	0f af c2             	imul   eax,edx
    2caa:	48 98                	cdqe
    2cac:	48 01 45 c8          	add    QWORD PTR [rbp-0x38],rax
										str2 = str;
    2cb0:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    2cb4:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
										lo_y = stride_y[i].x1;
    2cb8:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2cbc:	8b 84 c5 40 fe ff ff 	mov    eax,DWORD PTR [rbp+rax*8-0x1c0]
    2cc3:	89 45 a8             	mov    DWORD PTR [rbp-0x58],eax
										lpx_y = min(o_y + px_y, stride_y[i].x2) - stride_y[i].x1;
    2cc6:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2cca:	8b 94 c5 44 fe ff ff 	mov    edx,DWORD PTR [rbp+rax*8-0x1bc]
    2cd1:	8b 8d 78 ff ff ff    	mov    ecx,DWORD PTR [rbp-0x88]
    2cd7:	8b 85 70 ff ff ff    	mov    eax,DWORD PTR [rbp-0x90]
    2cdd:	01 c8                	add    eax,ecx
    2cdf:	39 c2                	cmp    edx,eax
    2ce1:	0f 4f d0             	cmovg  edx,eax
    2ce4:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2ce8:	8b 84 c5 40 fe ff ff 	mov    eax,DWORD PTR [rbp+rax*8-0x1c0]
    2cef:	29 c2                	sub    edx,eax
    2cf1:	89 95 68 ff ff ff    	mov    DWORD PTR [rbp-0x98],edx
										if (!lpx_y) /* break after zero stride */
    2cf7:	83 bd 68 ff ff ff 00 	cmp    DWORD PTR [rbp-0x98],0x0
    2cfe:	0f 84 15 03 00 00    	je     3019 <framebuffer_redraw_region+0xf78>
												break;
										lo_x = o_x;
    2d04:	8b 85 7c ff ff ff    	mov    eax,DWORD PTR [rbp-0x84]
    2d0a:	89 45 ac             	mov    DWORD PTR [rbp-0x54],eax
										shf2 = shf;
    2d0d:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    2d10:	89 45 9c             	mov    DWORD PTR [rbp-0x64],eax
										mem2 = mem;
    2d13:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    2d17:	48 89 45 90          	mov    QWORD PTR [rbp-0x70],rax
										/* now draw the x strides */
										for (size_t j = 0; j < ns_x; j++) {
    2d1b:	48 c7 45 80 00 00 00 00 	mov    QWORD PTR [rbp-0x80],0x0
    2d23:	e9 bb 01 00 00       	jmp    2ee3 <framebuffer_redraw_region+0xe42>
												/* draw to x before */
												if (stride_x[j].x1 > lo_x) {
    2d28:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    2d2c:	8b 84 c5 90 fe ff ff 	mov    eax,DWORD PTR [rbp+rax*8-0x170]
    2d33:	39 45 ac             	cmp    DWORD PTR [rbp-0x54],eax
    2d36:	0f 8d 1f 01 00 00    	jge    2e5b <framebuffer_redraw_region+0xdba>
														lpx_x = min(o_x + px_x - lo_x, stride_x[j].x1 - lo_x);
    2d3c:	8b 95 7c ff ff ff    	mov    edx,DWORD PTR [rbp-0x84]
    2d42:	8b 85 74 ff ff ff    	mov    eax,DWORD PTR [rbp-0x8c]
    2d48:	01 c2                	add    edx,eax
    2d4a:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    2d4e:	8b 84 c5 90 fe ff ff 	mov    eax,DWORD PTR [rbp+rax*8-0x170]
    2d55:	39 c2                	cmp    edx,eax
    2d57:	7d 13                	jge    2d6c <framebuffer_redraw_region+0xccb>
    2d59:	8b 95 7c ff ff ff    	mov    edx,DWORD PTR [rbp-0x84]
    2d5f:	8b 85 74 ff ff ff    	mov    eax,DWORD PTR [rbp-0x8c]
    2d65:	01 d0                	add    eax,edx
    2d67:	2b 45 ac             	sub    eax,DWORD PTR [rbp-0x54]
    2d6a:	eb 0e                	jmp    2d7a <framebuffer_redraw_region+0xcd9>
    2d6c:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    2d70:	8b 84 c5 90 fe ff ff 	mov    eax,DWORD PTR [rbp+rax*8-0x170]
    2d77:	2b 45 ac             	sub    eax,DWORD PTR [rbp-0x54]
    2d7a:	89 85 6c ff ff ff    	mov    DWORD PTR [rbp-0x94],eax
														render_text(fb->font, str2, mem2, 2 * fb->width,
																video_mode.bpsl, video_mode.gm_bts, lpx_x,
																lpx_y, shf2, fb->cur_x - r->x, fb->cur_y - r->y,
																(lo_x - o_x) % 8, (lo_y - o_y) % 16);
    2d80:	8b 45 a8             	mov    eax,DWORD PTR [rbp-0x58]
    2d83:	2b 85 78 ff ff ff    	sub    eax,DWORD PTR [rbp-0x88]
    2d89:	89 c2                	mov    edx,eax
														render_text(fb->font, str2, mem2, 2 * fb->width,
    2d8b:	89 d0                	mov    eax,edx
    2d8d:	c1 f8 1f             	sar    eax,0x1f
    2d90:	c1 e8 1c             	shr    eax,0x1c
    2d93:	01 c2                	add    edx,eax
    2d95:	83 e2 0f             	and    edx,0xf
    2d98:	29 c2                	sub    edx,eax
    2d9a:	41 89 d3             	mov    r11d,edx
																(lo_x - o_x) % 8, (lo_y - o_y) % 16);
    2d9d:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
    2da0:	2b 85 7c ff ff ff    	sub    eax,DWORD PTR [rbp-0x84]
    2da6:	89 c2                	mov    edx,eax
														render_text(fb->font, str2, mem2, 2 * fb->width,
    2da8:	89 d0                	mov    eax,edx
    2daa:	c1 f8 1f             	sar    eax,0x1f
    2dad:	c1 e8 1d             	shr    eax,0x1d
    2db0:	01 c2                	add    edx,eax
    2db2:	83 e2 07             	and    edx,0x7
    2db5:	29 c2                	sub    edx,eax
    2db7:	41 89 d2             	mov    r10d,edx
																lpx_y, shf2, fb->cur_x - r->x, fb->cur_y - r->y,
    2dba:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2dc1:	8b 50 20             	mov    edx,DWORD PTR [rax+0x20]
    2dc4:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    2dcb:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    2dcf:	98                   	cwde
														render_text(fb->font, str2, mem2, 2 * fb->width,
    2dd0:	29 c2                	sub    edx,eax
    2dd2:	41 89 d0             	mov    r8d,edx
																lpx_y, shf2, fb->cur_x - r->x, fb->cur_y - r->y,
    2dd5:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2ddc:	8b 50 1c             	mov    edx,DWORD PTR [rax+0x1c]
    2ddf:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    2de6:	0f b7 00             	movzx  eax,WORD PTR [rax]
    2de9:	98                   	cwde
														render_text(fb->font, str2, mem2, 2 * fb->width,
    2dea:	89 d7                	mov    edi,edx
    2dec:	29 c7                	sub    edi,eax
																video_mode.bpsl, video_mode.gm_bts, lpx_x,
    2dee:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2df5 <framebuffer_redraw_region+0xd54>
														render_text(fb->font, str2, mem2, 2 * fb->width,
    2df5:	4c 0f be c8          	movsx  r9,al
																video_mode.bpsl, video_mode.gm_bts, lpx_x,
    2df9:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2dff <framebuffer_redraw_region+0xd5e>
														render_text(fb->font, str2, mem2, 2 * fb->width,
    2dff:	89 c3                	mov    ebx,eax
    2e01:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2e08:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    2e0b:	01 c0                	add    eax,eax
    2e0d:	48 63 c8             	movsxd rcx,eax
    2e10:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2e17:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    2e1b:	48 8b 55 90          	mov    rdx,QWORD PTR [rbp-0x70]
    2e1f:	48 8b 75 a0          	mov    rsi,QWORD PTR [rbp-0x60]
    2e23:	44 89 5c 24 30       	mov    DWORD PTR [rsp+0x30],r11d
    2e28:	44 89 54 24 28       	mov    DWORD PTR [rsp+0x28],r10d
    2e2d:	44 89 44 24 20       	mov    DWORD PTR [rsp+0x20],r8d
    2e32:	89 7c 24 18          	mov    DWORD PTR [rsp+0x18],edi
    2e36:	8b 7d 9c             	mov    edi,DWORD PTR [rbp-0x64]
    2e39:	89 7c 24 10          	mov    DWORD PTR [rsp+0x10],edi
    2e3d:	8b bd 68 ff ff ff    	mov    edi,DWORD PTR [rbp-0x98]
    2e43:	89 7c 24 08          	mov    DWORD PTR [rsp+0x8],edi
    2e47:	8b bd 6c ff ff ff    	mov    edi,DWORD PTR [rbp-0x94]
    2e4d:	89 3c 24             	mov    DWORD PTR [rsp],edi
    2e50:	49 89 d8             	mov    r8,rbx
    2e53:	48 89 c7             	mov    rdi,rax
    2e56:	e8 00 00 00 00       	call   2e5b <framebuffer_redraw_region+0xdba>
												}
												/* draw nothing as x,y are inside */
												lo_x = stride_x[j].x2;
    2e5b:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    2e5f:	8b 84 c5 94 fe ff ff 	mov    eax,DWORD PTR [rbp+rax*8-0x16c]
    2e66:	89 45 ac             	mov    DWORD PTR [rbp-0x54],eax
												str2 = str + ((lo_x - o_x) / 8) * 2;
    2e69:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
    2e6c:	2b 85 7c ff ff ff    	sub    eax,DWORD PTR [rbp-0x84]
    2e72:	8d 50 07             	lea    edx,[rax+0x7]
    2e75:	85 c0                	test   eax,eax
    2e77:	0f 48 c2             	cmovs  eax,edx
    2e7a:	c1 f8 03             	sar    eax,0x3
    2e7d:	01 c0                	add    eax,eax
    2e7f:	48 63 d0             	movsxd rdx,eax
    2e82:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    2e86:	48 01 d0             	add    rax,rdx
    2e89:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
												mem2 = mem + (lo_x - o_x) * video_mode.btpp;
    2e8d:	8b 45 ac             	mov    eax,DWORD PTR [rbp-0x54]
    2e90:	2b 85 7c ff ff ff    	sub    eax,DWORD PTR [rbp-0x84]
    2e96:	89 c2                	mov    edx,eax
    2e98:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2e9f <framebuffer_redraw_region+0xdfe>
    2e9f:	0f be c0             	movsx  eax,al
    2ea2:	0f af c2             	imul   eax,edx
    2ea5:	48 63 d0             	movsxd rdx,eax
    2ea8:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    2eac:	48 01 d0             	add    rax,rdx
    2eaf:	48 89 45 90          	mov    QWORD PTR [rbp-0x70],rax
												if (video_mode.gm_bts == 4)
    2eb3:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2eba <framebuffer_redraw_region+0xe19>
    2eba:	3c 04                	cmp    al,0x4
    2ebc:	75 20                	jne    2ede <framebuffer_redraw_region+0xe3d>
														shf2 = ((lo_x % 2) == 1);
    2ebe:	8b 55 ac             	mov    edx,DWORD PTR [rbp-0x54]
    2ec1:	89 d0                	mov    eax,edx
    2ec3:	c1 f8 1f             	sar    eax,0x1f
    2ec6:	c1 e8 1f             	shr    eax,0x1f
    2ec9:	01 c2                	add    edx,eax
    2ecb:	83 e2 01             	and    edx,0x1
    2ece:	29 c2                	sub    edx,eax
    2ed0:	89 d0                	mov    eax,edx
    2ed2:	83 f8 01             	cmp    eax,0x1
    2ed5:	0f 94 c0             	sete   al
    2ed8:	0f b6 c0             	movzx  eax,al
    2edb:	89 45 9c             	mov    DWORD PTR [rbp-0x64],eax
										for (size_t j = 0; j < ns_x; j++) {
    2ede:	48 83 45 80 01       	add    QWORD PTR [rbp-0x80],0x1
    2ee3:	48 8b 45 80          	mov    rax,QWORD PTR [rbp-0x80]
    2ee7:	48 3b 45 b8          	cmp    rax,QWORD PTR [rbp-0x48]
    2eeb:	0f 82 37 fe ff ff    	jb     2d28 <framebuffer_redraw_region+0xc87>
										}
										/* and set the memory */
										mem += lpx_y * video_mode.bpsl;
    2ef1:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 2ef7 <framebuffer_redraw_region+0xe56>
    2ef7:	8b 85 68 ff ff ff    	mov    eax,DWORD PTR [rbp-0x98]
    2efd:	0f af c2             	imul   eax,edx
    2f00:	89 c0                	mov    eax,eax
    2f02:	48 01 45 d0          	add    QWORD PTR [rbp-0x30],rax
										str2 = str + ((stride_y[i].x2 - lo_y) / 16) * 2 * fb->width;
    2f06:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2f0a:	8b 84 c5 44 fe ff ff 	mov    eax,DWORD PTR [rbp+rax*8-0x1bc]
    2f11:	2b 45 a8             	sub    eax,DWORD PTR [rbp-0x58]
    2f14:	8d 50 0f             	lea    edx,[rax+0xf]
    2f17:	85 c0                	test   eax,eax
    2f19:	0f 48 c2             	cmovs  eax,edx
    2f1c:	c1 f8 04             	sar    eax,0x4
    2f1f:	8d 14 00             	lea    edx,[rax+rax*1]
    2f22:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2f29:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    2f2c:	0f af c2             	imul   eax,edx
    2f2f:	48 63 d0             	movsxd rdx,eax
    2f32:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    2f36:	48 01 d0             	add    rax,rdx
    2f39:	48 89 45 a0          	mov    QWORD PTR [rbp-0x60],rax
										lo_y = stride_y[i].x2;
    2f3d:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2f41:	8b 84 c5 44 fe ff ff 	mov    eax,DWORD PTR [rbp+rax*8-0x1bc]
    2f48:	89 45 a8             	mov    DWORD PTR [rbp-0x58],eax
								for (size_t i = 0; i < ns_y; i++) {
    2f4b:	48 83 45 88 01       	add    QWORD PTR [rbp-0x78],0x1
    2f50:	48 8b 45 88          	mov    rax,QWORD PTR [rbp-0x78]
    2f54:	48 3b 45 c0          	cmp    rax,QWORD PTR [rbp-0x40]
    2f58:	0f 82 c2 fb ff ff    	jb     2b20 <framebuffer_redraw_region+0xa7f>
								}
								return;
    2f5e:	e9 b7 00 00 00       	jmp    301a <framebuffer_redraw_region+0xf79>
				}

				/* and draw the text */
				render_text(fb->font, str, mem, 2 * fb->width, video_mode.bpsl,
						video_mode.gm_bts, px_x, px_y, shf, fb->cur_x - r->x,
						fb->cur_y - r->y, 0, 0);
    2f63:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2f6a:	8b 50 20             	mov    edx,DWORD PTR [rax+0x20]
    2f6d:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    2f74:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    2f78:	98                   	cwde
				render_text(fb->font, str, mem, 2 * fb->width, video_mode.bpsl,
    2f79:	29 c2                	sub    edx,eax
    2f7b:	41 89 d0             	mov    r8d,edx
						video_mode.gm_bts, px_x, px_y, shf, fb->cur_x - r->x,
    2f7e:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2f85:	8b 50 1c             	mov    edx,DWORD PTR [rax+0x1c]
    2f88:	48 8b 85 30 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1d0]
    2f8f:	0f b7 00             	movzx  eax,WORD PTR [rax]
    2f92:	98                   	cwde
				render_text(fb->font, str, mem, 2 * fb->width, video_mode.bpsl,
    2f93:	89 d7                	mov    edi,edx
    2f95:	29 c7                	sub    edi,eax
						video_mode.gm_bts, px_x, px_y, shf, fb->cur_x - r->x,
    2f97:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2f9e <framebuffer_redraw_region+0xefd>
				render_text(fb->font, str, mem, 2 * fb->width, video_mode.bpsl,
    2f9e:	4c 0f be c8          	movsx  r9,al
    2fa2:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2fa8 <framebuffer_redraw_region+0xf07>
    2fa8:	41 89 c2             	mov    r10d,eax
    2fab:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2fb2:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    2fb5:	01 c0                	add    eax,eax
    2fb7:	48 63 c8             	movsxd rcx,eax
    2fba:	48 8b 85 38 fe ff ff 	mov    rax,QWORD PTR [rbp-0x1c8]
    2fc1:	48 8b 40 10          	mov    rax,QWORD PTR [rax+0x10]
    2fc5:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    2fc9:	48 8b 75 c8          	mov    rsi,QWORD PTR [rbp-0x38]
    2fcd:	c7 44 24 30 00 00 00 00 	mov    DWORD PTR [rsp+0x30],0x0
    2fd5:	c7 44 24 28 00 00 00 00 	mov    DWORD PTR [rsp+0x28],0x0
    2fdd:	44 89 44 24 20       	mov    DWORD PTR [rsp+0x20],r8d
    2fe2:	89 7c 24 18          	mov    DWORD PTR [rsp+0x18],edi
    2fe6:	8b 7d dc             	mov    edi,DWORD PTR [rbp-0x24]
    2fe9:	89 7c 24 10          	mov    DWORD PTR [rsp+0x10],edi
    2fed:	8b bd 70 ff ff ff    	mov    edi,DWORD PTR [rbp-0x90]
    2ff3:	89 7c 24 08          	mov    DWORD PTR [rsp+0x8],edi
    2ff7:	8b bd 74 ff ff ff    	mov    edi,DWORD PTR [rbp-0x8c]
    2ffd:	89 3c 24             	mov    DWORD PTR [rsp],edi
    3000:	4d 89 d0             	mov    r8,r10
    3003:	48 89 c7             	mov    rdi,rax
    3006:	e8 00 00 00 00       	call   300b <framebuffer_redraw_region+0xf6a>
    300b:	eb 0d                	jmp    301a <framebuffer_redraw_region+0xf79>
				return; /* don't do anything if we're directly on video memory */
    300d:	90                   	nop
    300e:	eb 0a                	jmp    301a <framebuffer_redraw_region+0xf79>
				return;
    3010:	90                   	nop
    3011:	eb 07                	jmp    301a <framebuffer_redraw_region+0xf79>
					return;
    3013:	90                   	nop
    3014:	eb 04                	jmp    301a <framebuffer_redraw_region+0xf79>
					return;
    3016:	90                   	nop
    3017:	eb 01                	jmp    301a <framebuffer_redraw_region+0xf79>
												break;
    3019:	90                   	nop
		}
}
    301a:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
    301e:	c9                   	leave
    301f:	c3                   	ret

0000000000003020 <framebuffer_redraw_updates>:

void framebuffer_redraw_updates(struct framebuffer* fb)
{
    3020:	55                   	push   rbp
    3021:	48 89 e5             	mov    rbp,rsp
    3024:	48 83 ec 30          	sub    rsp,0x30
    3028:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		uint64_t tm;
		struct rct *rc, **prc;
Pos1:
		rc = fb->r_ud; prc = &fb->r_ud;
    302c:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3030:	48 8b 40 40          	mov    rax,QWORD PTR [rax+0x40]
    3034:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
    3038:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    303c:	48 83 c0 40          	add    rax,0x40
    3040:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		if (!rc)
    3044:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
    3049:	0f 84 34 01 00 00    	je     3183 <framebuffer_redraw_updates+0x163>
				return;
		if (cpu.has_tsc)
    304f:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 3056 <framebuffer_redraw_updates+0x36>
    3056:	83 e0 10             	and    eax,0x10
    3059:	84 c0                	test   al,al
    305b:	74 06                	je     3063 <framebuffer_redraw_updates+0x43>
				asm volatile ("rdtsc" : "=A" (tm));
    305d:	0f 31                	rdtsc
    305f:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		do {
				if (rc->r_ct) {
    3063:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3067:	48 8b 80 88 02 00 00 	mov    rax,QWORD PTR [rax+0x288]
    306e:	48 85 c0             	test   rax,rax
    3071:	0f 84 b9 00 00 00    	je     3130 <framebuffer_redraw_updates+0x110>
						/* take element temorary out of list */
						if (__sync_bool_compare_and_swap(prc, rc, rc->next)) {
    3077:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    307b:	48 8b 80 80 02 00 00 	mov    rax,QWORD PTR [rax+0x280]
    3082:	48 89 c1             	mov    rcx,rax
    3085:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3089:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    308d:	f0 48 0f b1 0a       	lock cmpxchg QWORD PTR [rdx],rcx
    3092:	0f 94 c0             	sete   al
    3095:	84 c0                	test   al,al
    3097:	74 93                	je     302c <framebuffer_redraw_updates+0xc>
								/* success */
								for (size_t i = 0; i < rc->r_ct; i++)
    3099:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
    30a1:	eb 2e                	jmp    30d1 <framebuffer_redraw_updates+0xb1>
										framebuffer_redraw_region(fb, rc->r + i);
    30a3:	48 8b 4d f0          	mov    rcx,QWORD PTR [rbp-0x10]
    30a7:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    30ab:	48 89 d0             	mov    rax,rdx
    30ae:	48 c1 e0 02          	shl    rax,0x2
    30b2:	48 01 d0             	add    rax,rdx
    30b5:	48 c1 e0 02          	shl    rax,0x2
    30b9:	48 8d 14 01          	lea    rdx,[rcx+rax*1]
    30bd:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    30c1:	48 89 d6             	mov    rsi,rdx
    30c4:	48 89 c7             	mov    rdi,rax
    30c7:	e8 00 00 00 00       	call   30cc <framebuffer_redraw_updates+0xac>
								for (size_t i = 0; i < rc->r_ct; i++)
    30cc:	48 83 45 e0 01       	add    QWORD PTR [rbp-0x20],0x1
    30d1:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    30d5:	48 8b 80 88 02 00 00 	mov    rax,QWORD PTR [rax+0x288]
    30dc:	48 39 45 e0          	cmp    QWORD PTR [rbp-0x20],rax
    30e0:	72 c1                	jb     30a3 <framebuffer_redraw_updates+0x83>
								rc->r_ct = 0;
    30e2:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    30e6:	48 c7 80 88 02 00 00 00 00 00 00 	mov    QWORD PTR [rax+0x288],0x0
								/* now put the buffer back at the front */
								do {
										rc->next = fb->r_ud;
    30f1:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    30f5:	48 8b 50 40          	mov    rdx,QWORD PTR [rax+0x40]
    30f9:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    30fd:	48 89 90 80 02 00 00 	mov    QWORD PTR [rax+0x280],rdx
								} while (!__sync_bool_compare_and_swap(&fb->r_ud, rc->next, rc));
    3104:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    3108:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    310c:	48 8b 80 80 02 00 00 	mov    rax,QWORD PTR [rax+0x280]
    3113:	48 89 c6             	mov    rsi,rax
    3116:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    311a:	48 8d 48 40          	lea    rcx,[rax+0x40]
    311e:	48 89 f0             	mov    rax,rsi
    3121:	f0 48 0f b1 11       	lock cmpxchg QWORD PTR [rcx],rdx
    3126:	0f 94 c0             	sete   al
    3129:	83 f0 01             	xor    eax,0x1
    312c:	84 c0                	test   al,al
    312e:	75 c1                	jne    30f1 <framebuffer_redraw_updates+0xd1>
						} else
								goto Pos1;
				}
				prc = &rc->next;
    3130:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3134:	48 05 80 02 00 00    	add    rax,0x280
    313a:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
		} while ((rc = rc->next));
    313e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3142:	48 8b 80 80 02 00 00 	mov    rax,QWORD PTR [rax+0x280]
    3149:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
    314d:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
    3152:	0f 85 0b ff ff ff    	jne    3063 <framebuffer_redraw_updates+0x43>
		if (cpu.has_tsc) {
    3158:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 315f <framebuffer_redraw_updates+0x13f>
    315f:	83 e0 10             	and    eax,0x10
    3162:	84 c0                	test   al,al
    3164:	74 1e                	je     3184 <framebuffer_redraw_updates+0x164>
				asm volatile ("rdtsc" : "=A" (fb_rdt));
    3166:	0f 31                	rdtsc
    3168:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 316f <framebuffer_redraw_updates+0x14f>
				fb_rdt -= tm;
    316f:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 3176 <framebuffer_redraw_updates+0x156>
    3176:	48 2b 45 f8          	sub    rax,QWORD PTR [rbp-0x8]
    317a:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 3181 <framebuffer_redraw_updates+0x161>
    3181:	eb 01                	jmp    3184 <framebuffer_redraw_updates+0x164>
				return;
    3183:	90                   	nop
		}
}
    3184:	c9                   	leave
    3185:	c3                   	ret

0000000000003186 <framebuffer_update_region>:

void framebuffer_update_region(struct framebuffer* fb, struct kio_region* r)
{
    3186:	55                   	push   rbp
    3187:	48 89 e5             	mov    rbp,rsp
    318a:	48 83 ec 60          	sub    rsp,0x60
    318e:	48 89 7d a8          	mov    QWORD PTR [rbp-0x58],rdi
    3192:	48 89 75 a0          	mov    QWORD PTR [rbp-0x60],rsi
		struct kio_region r2;
		struct rct* ptr = fb->r_ud;
    3196:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    319a:	48 8b 40 40          	mov    rax,QWORD PTR [rax+0x40]
    319e:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		size_t idx;
		if (fb->text_mem == vga_mem_ptr)
    31a2:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    31a6:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    31a9:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 31b0 <framebuffer_update_region+0x2a>
    31b0:	48 39 c2             	cmp    rdx,rax
    31b3:	0f 84 b6 04 00 00    	je     366f <framebuffer_update_region+0x4e9>
				return;

		/* for now update on every call */
		r2.x = max(0, r->x - fb->cho_x);
    31b9:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    31bd:	0f b7 00             	movzx  eax,WORD PTR [rax]
    31c0:	0f bf c8             	movsx  ecx,ax
    31c3:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    31c7:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
    31ca:	89 c8                	mov    eax,ecx
    31cc:	29 d0                	sub    eax,edx
    31ce:	ba 00 00 00 00       	mov    edx,0x0
    31d3:	85 c0                	test   eax,eax
    31d5:	0f 48 c2             	cmovs  eax,edx
    31d8:	66 89 45 b0          	mov    WORD PTR [rbp-0x50],ax
		r2.y = max(0, r->y - fb->cho_y);
    31dc:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    31e0:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    31e4:	0f bf c8             	movsx  ecx,ax
    31e7:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    31eb:	8b 50 30             	mov    edx,DWORD PTR [rax+0x30]
    31ee:	89 c8                	mov    eax,ecx
    31f0:	29 d0                	sub    eax,edx
    31f2:	ba 00 00 00 00       	mov    edx,0x0
    31f7:	85 c0                	test   eax,eax
    31f9:	0f 48 c2             	cmovs  eax,edx
    31fc:	66 89 45 b2          	mov    WORD PTR [rbp-0x4e],ax
		r2.fmt = r->fmt;
    3200:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    3204:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    3208:	88 45 bc             	mov    BYTE PTR [rbp-0x44],al
		r2.lx = min(fb->chw_x - r2.x, r->lx);
    320b:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    320f:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
    3213:	0f bf d0             	movsx  edx,ax
    3216:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    321a:	8b 40 34             	mov    eax,DWORD PTR [rax+0x34]
    321d:	0f b7 4d b0          	movzx  ecx,WORD PTR [rbp-0x50]
    3221:	0f bf c9             	movsx  ecx,cx
    3224:	29 c8                	sub    eax,ecx
    3226:	39 c2                	cmp    edx,eax
    3228:	0f 4e c2             	cmovle eax,edx
    322b:	66 89 45 b4          	mov    WORD PTR [rbp-0x4c],ax
		r2.ly = min(fb->chw_y - r2.y, r->ly);
    322f:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    3233:	0f b7 40 06          	movzx  eax,WORD PTR [rax+0x6]
    3237:	0f bf d0             	movsx  edx,ax
    323a:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    323e:	8b 40 38             	mov    eax,DWORD PTR [rax+0x38]
    3241:	0f b7 4d b2          	movzx  ecx,WORD PTR [rbp-0x4e]
    3245:	0f bf c9             	movsx  ecx,cx
    3248:	29 c8                	sub    eax,ecx
    324a:	39 c2                	cmp    edx,eax
    324c:	0f 4e c2             	cmovle eax,edx
    324f:	66 89 45 b6          	mov    WORD PTR [rbp-0x4a],ax
		/* check for visibility */
		if (r2.x >= fb->chw_x || r2.y >= fb->chw_y ||
    3253:	0f b7 45 b0          	movzx  eax,WORD PTR [rbp-0x50]
    3257:	0f bf d0             	movsx  edx,ax
    325a:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    325e:	8b 40 34             	mov    eax,DWORD PTR [rax+0x34]
    3261:	39 c2                	cmp    edx,eax
    3263:	0f 8d 09 04 00 00    	jge    3672 <framebuffer_update_region+0x4ec>
    3269:	0f b7 45 b2          	movzx  eax,WORD PTR [rbp-0x4e]
    326d:	0f bf d0             	movsx  edx,ax
    3270:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3274:	8b 40 38             	mov    eax,DWORD PTR [rax+0x38]
    3277:	39 c2                	cmp    edx,eax
    3279:	0f 8d f3 03 00 00    	jge    3672 <framebuffer_update_region+0x4ec>
			r2.x + r2.lx < fb->cho_x || r2.y + r2.ly < fb->cho_y)
    327f:	0f b7 45 b0          	movzx  eax,WORD PTR [rbp-0x50]
    3283:	0f bf d0             	movsx  edx,ax
    3286:	0f b7 45 b4          	movzx  eax,WORD PTR [rbp-0x4c]
    328a:	98                   	cwde
    328b:	01 c2                	add    edx,eax
    328d:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3291:	8b 40 2c             	mov    eax,DWORD PTR [rax+0x2c]
		if (r2.x >= fb->chw_x || r2.y >= fb->chw_y ||
    3294:	39 c2                	cmp    edx,eax
    3296:	0f 8c d6 03 00 00    	jl     3672 <framebuffer_update_region+0x4ec>
			r2.x + r2.lx < fb->cho_x || r2.y + r2.ly < fb->cho_y)
    329c:	0f b7 45 b2          	movzx  eax,WORD PTR [rbp-0x4e]
    32a0:	0f bf d0             	movsx  edx,ax
    32a3:	0f b7 45 b6          	movzx  eax,WORD PTR [rbp-0x4a]
    32a7:	98                   	cwde
    32a8:	01 c2                	add    edx,eax
    32aa:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    32ae:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
    32b1:	39 c2                	cmp    edx,eax
    32b3:	0f 8c b9 03 00 00    	jl     3672 <framebuffer_update_region+0x4ec>
				return;
		/* check for pending updates */
Pos1:
    32b9:	90                   	nop
		ptr = fb->r_ud;
    32ba:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    32be:	48 8b 40 40          	mov    rax,QWORD PTR [rax+0x40]
    32c2:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		while (ptr) { /* TODO: overhaul this -> leads to freezes */
    32c6:	e9 f4 02 00 00       	jmp    35bf <framebuffer_update_region+0x439>
				size_t i;
				for (i = 0; i < ptr->r_ct; i++) {
    32cb:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
    32d3:	e9 c8 01 00 00       	jmp    34a0 <framebuffer_update_region+0x31a>
						/* check for extending horizontally */
						if (ptr->r[i].y == r2.y && ptr->r[i].ly == r2.ly) {
    32d8:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    32dc:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    32e0:	48 89 d0             	mov    rax,rdx
    32e3:	48 c1 e0 02          	shl    rax,0x2
    32e7:	48 01 d0             	add    rax,rdx
    32ea:	48 c1 e0 02          	shl    rax,0x2
    32ee:	48 01 c8             	add    rax,rcx
    32f1:	48 83 c0 02          	add    rax,0x2
    32f5:	0f b7 10             	movzx  edx,WORD PTR [rax]
    32f8:	0f b7 45 b2          	movzx  eax,WORD PTR [rbp-0x4e]
    32fc:	66 39 c2             	cmp    dx,ax
    32ff:	0f 85 f2 00 00 00    	jne    33f7 <framebuffer_update_region+0x271>
    3305:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    3309:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    330d:	48 89 d0             	mov    rax,rdx
    3310:	48 c1 e0 02          	shl    rax,0x2
    3314:	48 01 d0             	add    rax,rdx
    3317:	48 c1 e0 02          	shl    rax,0x2
    331b:	48 01 c8             	add    rax,rcx
    331e:	48 83 c0 06          	add    rax,0x6
    3322:	0f b7 10             	movzx  edx,WORD PTR [rax]
    3325:	0f b7 45 b6          	movzx  eax,WORD PTR [rbp-0x4a]
    3329:	66 39 c2             	cmp    dx,ax
    332c:	0f 85 c5 00 00 00    	jne    33f7 <framebuffer_update_region+0x271>
								short new_lx, old_lx = ptr->r[i].lx;
    3332:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    3336:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    333a:	48 89 d0             	mov    rax,rdx
    333d:	48 c1 e0 02          	shl    rax,0x2
    3341:	48 01 d0             	add    rax,rdx
    3344:	48 c1 e0 02          	shl    rax,0x2
    3348:	48 01 c8             	add    rax,rcx
    334b:	48 83 c0 04          	add    rax,0x4
    334f:	0f b7 00             	movzx  eax,WORD PTR [rax]
    3352:	66 89 45 de          	mov    WORD PTR [rbp-0x22],ax
								if (ptr->r[i].x + ptr->r[i].lx == r2.x) {
    3356:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    335a:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    335e:	48 89 d0             	mov    rax,rdx
    3361:	48 c1 e0 02          	shl    rax,0x2
    3365:	48 01 d0             	add    rax,rdx
    3368:	48 c1 e0 02          	shl    rax,0x2
    336c:	48 01 c8             	add    rax,rcx
    336f:	0f b7 00             	movzx  eax,WORD PTR [rax]
    3372:	0f bf c8             	movsx  ecx,ax
    3375:	48 8b 75 f8          	mov    rsi,QWORD PTR [rbp-0x8]
    3379:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    337d:	48 89 d0             	mov    rax,rdx
    3380:	48 c1 e0 02          	shl    rax,0x2
    3384:	48 01 d0             	add    rax,rdx
    3387:	48 c1 e0 02          	shl    rax,0x2
    338b:	48 01 f0             	add    rax,rsi
    338e:	48 83 c0 04          	add    rax,0x4
    3392:	0f b7 00             	movzx  eax,WORD PTR [rax]
    3395:	98                   	cwde
    3396:	8d 14 01             	lea    edx,[rcx+rax*1]
    3399:	0f b7 45 b0          	movzx  eax,WORD PTR [rbp-0x50]
    339d:	98                   	cwde
    339e:	39 c2                	cmp    edx,eax
    33a0:	75 55                	jne    33f7 <framebuffer_update_region+0x271>
										new_lx = old_lx + r2.lx;
    33a2:	0f b7 45 b4          	movzx  eax,WORD PTR [rbp-0x4c]
    33a6:	89 c2                	mov    edx,eax
    33a8:	0f b7 45 de          	movzx  eax,WORD PTR [rbp-0x22]
    33ac:	01 d0                	add    eax,edx
    33ae:	66 89 45 dc          	mov    WORD PTR [rbp-0x24],ax
										/* try to combine */
										if (!__sync_bool_compare_and_swap(&ptr->r[i].lx, old_lx, new_lx))
    33b2:	0f b7 45 dc          	movzx  eax,WORD PTR [rbp-0x24]
    33b6:	0f b7 f0             	movzx  esi,ax
    33b9:	0f b7 45 de          	movzx  eax,WORD PTR [rbp-0x22]
    33bd:	0f b7 c8             	movzx  ecx,ax
    33c0:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    33c4:	48 89 d0             	mov    rax,rdx
    33c7:	48 c1 e0 02          	shl    rax,0x2
    33cb:	48 01 d0             	add    rax,rdx
    33ce:	48 c1 e0 02          	shl    rax,0x2
    33d2:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    33d6:	48 01 d0             	add    rax,rdx
    33d9:	48 8d 50 04          	lea    rdx,[rax+0x4]
    33dd:	89 c8                	mov    eax,ecx
    33df:	66 f0 0f b1 32       	lock cmpxchg WORD PTR [rdx],si
    33e4:	0f 94 c0             	sete   al
    33e7:	83 f0 01             	xor    eax,0x1
    33ea:	84 c0                	test   al,al
    33ec:	0f 84 83 02 00 00    	je     3675 <framebuffer_update_region+0x4ef>
												goto Pos1;
    33f2:	e9 c3 fe ff ff       	jmp    32ba <framebuffer_update_region+0x134>
//										}
//										return;
//								}
//						}
						/* also check for duplicates */
						if (ptr->r[i].x == r2.x && ptr->r[i].y == r2.y
    33f7:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    33fb:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    33ff:	48 89 d0             	mov    rax,rdx
    3402:	48 c1 e0 02          	shl    rax,0x2
    3406:	48 01 d0             	add    rax,rdx
    3409:	48 c1 e0 02          	shl    rax,0x2
    340d:	48 01 c8             	add    rax,rcx
    3410:	0f b7 10             	movzx  edx,WORD PTR [rax]
    3413:	0f b7 45 b0          	movzx  eax,WORD PTR [rbp-0x50]
    3417:	66 39 c2             	cmp    dx,ax
    341a:	75 7f                	jne    349b <framebuffer_update_region+0x315>
    341c:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    3420:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    3424:	48 89 d0             	mov    rax,rdx
    3427:	48 c1 e0 02          	shl    rax,0x2
    342b:	48 01 d0             	add    rax,rdx
    342e:	48 c1 e0 02          	shl    rax,0x2
    3432:	48 01 c8             	add    rax,rcx
    3435:	48 83 c0 02          	add    rax,0x2
    3439:	0f b7 10             	movzx  edx,WORD PTR [rax]
    343c:	0f b7 45 b2          	movzx  eax,WORD PTR [rbp-0x4e]
    3440:	66 39 c2             	cmp    dx,ax
    3443:	75 56                	jne    349b <framebuffer_update_region+0x315>
							&& ptr->r[i].lx == r2.lx && ptr->r[i].ly == r2.ly)
    3445:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    3449:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    344d:	48 89 d0             	mov    rax,rdx
    3450:	48 c1 e0 02          	shl    rax,0x2
    3454:	48 01 d0             	add    rax,rdx
    3457:	48 c1 e0 02          	shl    rax,0x2
    345b:	48 01 c8             	add    rax,rcx
    345e:	48 83 c0 04          	add    rax,0x4
    3462:	0f b7 10             	movzx  edx,WORD PTR [rax]
    3465:	0f b7 45 b4          	movzx  eax,WORD PTR [rbp-0x4c]
    3469:	66 39 c2             	cmp    dx,ax
    346c:	75 2d                	jne    349b <framebuffer_update_region+0x315>
    346e:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    3472:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
    3476:	48 89 d0             	mov    rax,rdx
    3479:	48 c1 e0 02          	shl    rax,0x2
    347d:	48 01 d0             	add    rax,rdx
    3480:	48 c1 e0 02          	shl    rax,0x2
    3484:	48 01 c8             	add    rax,rcx
    3487:	48 83 c0 06          	add    rax,0x6
    348b:	0f b7 10             	movzx  edx,WORD PTR [rax]
    348e:	0f b7 45 b6          	movzx  eax,WORD PTR [rbp-0x4a]
    3492:	66 39 c2             	cmp    dx,ax
    3495:	0f 84 dd 01 00 00    	je     3678 <framebuffer_update_region+0x4f2>
				for (i = 0; i < ptr->r_ct; i++) {
    349b:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
    34a0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    34a4:	48 8b 80 88 02 00 00 	mov    rax,QWORD PTR [rax+0x288]
    34ab:	48 39 45 f0          	cmp    QWORD PTR [rbp-0x10],rax
    34af:	0f 82 23 fe ff ff    	jb     32d8 <framebuffer_update_region+0x152>
								return;
				}
				/* add inbetween */
				if ((idx = __sync_fetch_and_add(&ptr->r_ct, 1)) < 32) {
    34b5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    34b9:	48 05 88 02 00 00    	add    rax,0x288
    34bf:	ba 01 00 00 00       	mov    edx,0x1
    34c4:	f0 48 0f c1 10       	lock xadd QWORD PTR [rax],rdx
    34c9:	48 89 55 e8          	mov    QWORD PTR [rbp-0x18],rdx
    34cd:	48 83 7d e8 1f       	cmp    QWORD PTR [rbp-0x18],0x1f
    34d2:	77 33                	ja     3507 <framebuffer_update_region+0x381>
						ptr->r[idx] = r2;
    34d4:	48 8b 4d f8          	mov    rcx,QWORD PTR [rbp-0x8]
    34d8:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    34dc:	48 89 d0             	mov    rax,rdx
    34df:	48 c1 e0 02          	shl    rax,0x2
    34e3:	48 01 d0             	add    rax,rdx
    34e6:	48 c1 e0 02          	shl    rax,0x2
    34ea:	48 01 c8             	add    rax,rcx
    34ed:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
    34f1:	48 89 10             	mov    QWORD PTR [rax],rdx
    34f4:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
    34f8:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
    34fc:	8b 55 c0             	mov    edx,DWORD PTR [rbp-0x40]
    34ff:	89 50 10             	mov    DWORD PTR [rax+0x10],edx
						break;
    3502:	e9 c6 00 00 00       	jmp    35cd <framebuffer_update_region+0x447>
				} else
						__sync_fetch_and_sub(&ptr->r_ct, 1);
    3507:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    350b:	48 05 88 02 00 00    	add    rax,0x288
    3511:	f0 48 83 28 01       	lock sub QWORD PTR [rax],0x1
				/* we need a new container */
				if (!ptr->next) {
    3516:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    351a:	48 8b 80 80 02 00 00 	mov    rax,QWORD PTR [rax+0x280]
    3521:	48 85 c0             	test   rax,rax
    3524:	0f 85 86 00 00 00    	jne    35b0 <framebuffer_update_region+0x42a>
						while (fb_no_malloc);
    352a:	90                   	nop
    352b:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 3531 <framebuffer_update_region+0x3ab>
    3531:	85 c0                	test   eax,eax
    3533:	75 f6                	jne    352b <framebuffer_update_region+0x3a5>
						struct rct* rn = kmalloc(sizeof(struct rct));
    3535:	bf 90 02 00 00       	mov    edi,0x290
    353a:	e8 00 00 00 00       	call   353f <framebuffer_update_region+0x3b9>
    353f:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
						rn->r_ct = 1;
    3543:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3547:	48 c7 80 88 02 00 00 01 00 00 00 	mov    QWORD PTR [rax+0x288],0x1
						rn->r[0] = r2;
    3552:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3556:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
    355a:	48 89 10             	mov    QWORD PTR [rax],rdx
    355d:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
    3561:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
    3565:	8b 55 c0             	mov    edx,DWORD PTR [rbp-0x40]
    3568:	89 50 10             	mov    DWORD PTR [rax+0x10],edx
						rn->next = NULL;
    356b:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    356f:	48 c7 80 80 02 00 00 00 00 00 00 	mov    QWORD PTR [rax+0x280],0x0
						if (__sync_bool_compare_and_swap(&ptr->next, NULL, rn))
    357a:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    357e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    3582:	48 8d 88 80 02 00 00 	lea    rcx,[rax+0x280]
    3589:	b8 00 00 00 00       	mov    eax,0x0
    358e:	f0 48 0f b1 11       	lock cmpxchg QWORD PTR [rcx],rdx
    3593:	0f 94 c0             	sete   al
    3596:	84 c0                	test   al,al
    3598:	75 32                	jne    35cc <framebuffer_update_region+0x446>
								break;
						else if (!fb_no_malloc) { /* someone was faster */
    359a:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 35a0 <framebuffer_update_region+0x41a>
    35a0:	85 c0                	test   eax,eax
    35a2:	75 0c                	jne    35b0 <framebuffer_update_region+0x42a>
								kfree(rn);
    35a4:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    35a8:	48 89 c7             	mov    rdi,rax
    35ab:	e8 00 00 00 00       	call   35b0 <framebuffer_update_region+0x42a>
								//goto Pos1; ptr=next
						}
				}
				ptr = ptr->next;
    35b0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    35b4:	48 8b 80 80 02 00 00 	mov    rax,QWORD PTR [rax+0x280]
    35bb:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		while (ptr) { /* TODO: overhaul this -> leads to freezes */
    35bf:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
    35c4:	0f 85 01 fd ff ff    	jne    32cb <framebuffer_update_region+0x145>
    35ca:	eb 01                	jmp    35cd <framebuffer_update_region+0x447>
								break;
    35cc:	90                   	nop
		}
		/* else extend the list */
		if (!fb->r_ud) 
    35cd:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    35d1:	48 8b 40 40          	mov    rax,QWORD PTR [rax+0x40]
    35d5:	48 85 c0             	test   rax,rax
    35d8:	0f 85 9b 00 00 00    	jne    3679 <framebuffer_update_region+0x4f3>
				if (fb_no_malloc) {
    35de:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 35e4 <framebuffer_update_region+0x45e>
    35e4:	85 c0                	test   eax,eax
    35e6:	74 11                	je     35f9 <framebuffer_update_region+0x473>
					fb->r_ud = &rc_initial;
    35e8:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    35ec:	48 c7 40 40 00 00 00 00 	mov    QWORD PTR [rax+0x40],0x0
    35f4:	e9 80 00 00 00       	jmp    3679 <framebuffer_update_region+0x4f3>
				} else {
						struct rct* rn = kmalloc(sizeof(struct rct));
    35f9:	bf 90 02 00 00       	mov    edi,0x290
    35fe:	e8 00 00 00 00       	call   3603 <framebuffer_update_region+0x47d>
    3603:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
						rn->r_ct = 1;
    3607:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    360b:	48 c7 80 88 02 00 00 01 00 00 00 	mov    QWORD PTR [rax+0x288],0x1
						rn->r[0] = r2;
    3616:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    361a:	48 8b 55 b0          	mov    rdx,QWORD PTR [rbp-0x50]
    361e:	48 89 10             	mov    QWORD PTR [rax],rdx
    3621:	48 8b 55 b8          	mov    rdx,QWORD PTR [rbp-0x48]
    3625:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
    3629:	8b 55 c0             	mov    edx,DWORD PTR [rbp-0x40]
    362c:	89 50 10             	mov    DWORD PTR [rax+0x10],edx
						rn->next = NULL;
    362f:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    3633:	48 c7 80 80 02 00 00 00 00 00 00 	mov    QWORD PTR [rax+0x280],0x0
						if (!__sync_bool_compare_and_swap(&fb->r_ud, NULL, rn)) {
    363e:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    3642:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    3646:	48 8d 48 40          	lea    rcx,[rax+0x40]
    364a:	b8 00 00 00 00       	mov    eax,0x0
    364f:	f0 48 0f b1 11       	lock cmpxchg QWORD PTR [rcx],rdx
    3654:	0f 94 c0             	sete   al
    3657:	83 f0 01             	xor    eax,0x1
    365a:	84 c0                	test   al,al
    365c:	74 1b                	je     3679 <framebuffer_update_region+0x4f3>
								/* someone was faster */
								kfree(rn);
    365e:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    3662:	48 89 c7             	mov    rdi,rax
    3665:	e8 00 00 00 00       	call   366a <framebuffer_update_region+0x4e4>
								goto Pos1;
    366a:	e9 4b fc ff ff       	jmp    32ba <framebuffer_update_region+0x134>
				return;
    366f:	90                   	nop
    3670:	eb 07                	jmp    3679 <framebuffer_update_region+0x4f3>
				return;
    3672:	90                   	nop
    3673:	eb 04                	jmp    3679 <framebuffer_update_region+0x4f3>
										return;
    3675:	90                   	nop
    3676:	eb 01                	jmp    3679 <framebuffer_update_region+0x4f3>
								return;
    3678:	90                   	nop
						}	
		}
}
    3679:	c9                   	leave
    367a:	c3                   	ret

000000000000367b <framebuffer_scroll>:

/* we have to redraw everything */
void framebuffer_scroll(struct framebuffer* fb, ssize_t nly, ssize_t nlx)
{
    367b:	55                   	push   rbp
    367c:	48 89 e5             	mov    rbp,rsp
    367f:	48 83 ec 10          	sub    rsp,0x10
    3683:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
    3687:	89 75 f4             	mov    DWORD PTR [rbp-0xc],esi
    368a:	89 55 f0             	mov    DWORD PTR [rbp-0x10],edx
		if (nly != 1 || nlx)
    368d:	83 7d f4 01          	cmp    DWORD PTR [rbp-0xc],0x1
    3691:	75 08                	jne    369b <framebuffer_scroll+0x20>
    3693:	83 7d f0 00          	cmp    DWORD PTR [rbp-0x10],0x0
    3697:	75 02                	jne    369b <framebuffer_scroll+0x20>
    3699:	eb 02                	jmp    369d <framebuffer_scroll+0x22>
				while (1); /* only lines for now */
    369b:	eb fe                	jmp    369b <framebuffer_scroll+0x20>
		memmove(fb->text_mem, fb->text_mem + fb->width * 2,
					   	2 * fb->width * (fb->height - 1));
    369d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    36a1:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    36a4:	8d 14 00             	lea    edx,[rax+rax*1]
    36a7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    36ab:	8b 40 0c             	mov    eax,DWORD PTR [rax+0xc]
    36ae:	83 e8 01             	sub    eax,0x1
    36b1:	0f af c2             	imul   eax,edx
		memmove(fb->text_mem, fb->text_mem + fb->width * 2,
    36b4:	48 63 d0             	movsxd rdx,eax
    36b7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    36bb:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    36be:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    36c2:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    36c5:	01 c0                	add    eax,eax
    36c7:	48 98                	cdqe
    36c9:	48 01 c1             	add    rcx,rax
    36cc:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    36d0:	48 8b 00             	mov    rax,QWORD PTR [rax]
    36d3:	48 89 ce             	mov    rsi,rcx
    36d6:	48 89 c7             	mov    rdi,rax
    36d9:	e8 00 00 00 00       	call   36de <framebuffer_scroll+0x63>
		//framebuffer_redraw(fb);
}
    36de:	90                   	nop
    36df:	c9                   	leave
    36e0:	c3                   	ret

00000000000036e1 <framebuffer_scroll_region>:

void framebuffer_scroll_region(struct framebuffer* fb,
				struct kio_region* r, ssize_t nx, ssize_t ny)
{
    36e1:	55                   	push   rbp
    36e2:	48 89 e5             	mov    rbp,rsp
    36e5:	48 83 ec 30          	sub    rsp,0x30
    36e9:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    36ed:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
    36f1:	89 55 dc             	mov    DWORD PTR [rbp-0x24],edx
    36f4:	89 4d d8             	mov    DWORD PTR [rbp-0x28],ecx
		ssize_t i; char* src = NULL;
    36f7:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		if (ny != 1 || nx)
    36ff:	83 7d d8 01          	cmp    DWORD PTR [rbp-0x28],0x1
    3703:	75 08                	jne    370d <framebuffer_scroll_region+0x2c>
    3705:	83 7d dc 00          	cmp    DWORD PTR [rbp-0x24],0x0
    3709:	75 02                	jne    370d <framebuffer_scroll_region+0x2c>
    370b:	eb 02                	jmp    370f <framebuffer_scroll_region+0x2e>
				while (1); /* only lines for now */
    370d:	eb fe                	jmp    370d <framebuffer_scroll_region+0x2c>
		/* sanity check */
		if (r->x + r->lx > fb->width)
    370f:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3713:	0f b7 00             	movzx  eax,WORD PTR [rax]
    3716:	0f bf d0             	movsx  edx,ax
    3719:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    371d:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
    3721:	98                   	cwde
    3722:	01 c2                	add    edx,eax
    3724:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    3728:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    372b:	39 c2                	cmp    edx,eax
    372d:	0f 8f 34 01 00 00    	jg     3867 <framebuffer_scroll_region+0x186>
				return;
		if (r->y + r->ly > fb->height)
    3733:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3737:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    373b:	0f bf d0             	movsx  edx,ax
    373e:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3742:	0f b7 40 06          	movzx  eax,WORD PTR [rax+0x6]
    3746:	98                   	cwde
    3747:	01 c2                	add    edx,eax
    3749:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    374d:	8b 40 0c             	mov    eax,DWORD PTR [rax+0xc]
    3750:	39 c2                	cmp    edx,eax
    3752:	0f 8f 12 01 00 00    	jg     386a <framebuffer_scroll_region+0x189>
				return;
		/* by moving possibly strided memory */
		for (i = r->y; i < r->y + r->ly - 1; i++)
    3758:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    375c:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    3760:	98                   	cwde
    3761:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
    3764:	eb 7c                	jmp    37e2 <framebuffer_scroll_region+0x101>
				memcpy(fb->text_mem + i * fb->width * 2 + r->x * 2,
					   (src = fb->text_mem + (i + 1) * fb->width * 2 + r->x * 2),
					   r->lx * 2);
    3766:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    376a:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
    376e:	98                   	cwde
    376f:	01 c0                	add    eax,eax
				memcpy(fb->text_mem + i * fb->width * 2 + r->x * 2,
    3771:	48 63 d0             	movsxd rdx,eax
					   (src = fb->text_mem + (i + 1) * fb->width * 2 + r->x * 2),
    3774:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    3778:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    377b:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    377e:	8d 70 01             	lea    esi,[rax+0x1]
    3781:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    3785:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    3788:	0f af c6             	imul   eax,esi
    378b:	01 c0                	add    eax,eax
    378d:	48 63 f0             	movsxd rsi,eax
    3790:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3794:	0f b7 00             	movzx  eax,WORD PTR [rax]
    3797:	98                   	cwde
    3798:	01 c0                	add    eax,eax
    379a:	48 98                	cdqe
    379c:	48 01 f0             	add    rax,rsi
    379f:	48 01 c8             	add    rax,rcx
    37a2:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				memcpy(fb->text_mem + i * fb->width * 2 + r->x * 2,
    37a6:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    37aa:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    37ad:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    37b1:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    37b4:	0f af 45 fc          	imul   eax,DWORD PTR [rbp-0x4]
    37b8:	01 c0                	add    eax,eax
    37ba:	48 63 f0             	movsxd rsi,eax
    37bd:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    37c1:	0f b7 00             	movzx  eax,WORD PTR [rax]
    37c4:	98                   	cwde
    37c5:	01 c0                	add    eax,eax
    37c7:	48 98                	cdqe
    37c9:	48 01 f0             	add    rax,rsi
    37cc:	48 01 c1             	add    rcx,rax
    37cf:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    37d3:	48 89 c6             	mov    rsi,rax
    37d6:	48 89 cf             	mov    rdi,rcx
    37d9:	e8 22 c8 ff ff       	call   0 <memcpy>
		for (i = r->y; i < r->y + r->ly - 1; i++)
    37de:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
    37e2:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    37e6:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    37ea:	0f bf d0             	movsx  edx,ax
    37ed:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    37f1:	0f b7 40 06          	movzx  eax,WORD PTR [rax+0x6]
    37f5:	98                   	cwde
    37f6:	01 d0                	add    eax,edx
    37f8:	83 e8 01             	sub    eax,0x1
    37fb:	39 45 fc             	cmp    DWORD PTR [rbp-0x4],eax
    37fe:	0f 8c 62 ff ff ff    	jl     3766 <framebuffer_scroll_region+0x85>
		if (!src)
    3804:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
    3809:	74 62                	je     386d <framebuffer_scroll_region+0x18c>
				return;
		for (i = 0; i < 2 * r->lx; i += 2) {
    380b:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
    3812:	eb 2e                	jmp    3842 <framebuffer_scroll_region+0x161>
				src[i] = '\0';
    3814:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    3817:	48 63 d0             	movsxd rdx,eax
    381a:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    381e:	48 01 d0             	add    rax,rdx
    3821:	c6 00 00             	mov    BYTE PTR [rax],0x0
				src[i + 1] = r->fmt;
    3824:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    3827:	48 98                	cdqe
    3829:	48 8d 50 01          	lea    rdx,[rax+0x1]
    382d:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3831:	48 01 c2             	add    rdx,rax
    3834:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3838:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    383c:	88 02                	mov    BYTE PTR [rdx],al
		for (i = 0; i < 2 * r->lx; i += 2) {
    383e:	83 45 fc 02          	add    DWORD PTR [rbp-0x4],0x2
    3842:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3846:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
    384a:	98                   	cwde
    384b:	01 c0                	add    eax,eax
    384d:	39 45 fc             	cmp    DWORD PTR [rbp-0x4],eax
    3850:	7c c2                	jl     3814 <framebuffer_scroll_region+0x133>
		} /* TODO other scrolls */
		/*bzero(fb->text_mem + i * fb->width * 2 + r->x * 2, r->lx * 2);*/
		framebuffer_update_region(fb, r);
    3852:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    3856:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    385a:	48 89 d6             	mov    rsi,rdx
    385d:	48 89 c7             	mov    rdi,rax
    3860:	e8 00 00 00 00       	call   3865 <framebuffer_scroll_region+0x184>
    3865:	eb 07                	jmp    386e <framebuffer_scroll_region+0x18d>
				return;
    3867:	90                   	nop
    3868:	eb 04                	jmp    386e <framebuffer_scroll_region+0x18d>
				return;
    386a:	90                   	nop
    386b:	eb 01                	jmp    386e <framebuffer_scroll_region+0x18d>
				return;
    386d:	90                   	nop
}
    386e:	c9                   	leave
    386f:	c3                   	ret

0000000000003870 <framebuffer_clear_region>:

void framebuffer_clear_region(struct framebuffer* fb, struct kio_region* r)
{
    3870:	55                   	push   rbp
    3871:	48 89 e5             	mov    rbp,rsp
    3874:	48 83 ec 20          	sub    rsp,0x20
    3878:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    387c:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
		char* p;
		if (r->x + r->lx > fb->width)
    3880:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    3884:	0f b7 00             	movzx  eax,WORD PTR [rax]
    3887:	0f bf d0             	movsx  edx,ax
    388a:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    388e:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
    3892:	98                   	cwde
    3893:	01 c2                	add    edx,eax
    3895:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    3899:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    389c:	39 c2                	cmp    edx,eax
    389e:	0f 8f f8 00 00 00    	jg     399c <framebuffer_clear_region+0x12c>
				return;
		if (r->y + r->ly > fb->height)
    38a4:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    38a8:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    38ac:	0f bf d0             	movsx  edx,ax
    38af:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    38b3:	0f b7 40 06          	movzx  eax,WORD PTR [rax+0x6]
    38b7:	98                   	cwde
    38b8:	01 c2                	add    edx,eax
    38ba:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    38be:	8b 40 0c             	mov    eax,DWORD PTR [rax+0xc]
    38c1:	39 c2                	cmp    edx,eax
    38c3:	0f 8f d6 00 00 00    	jg     399f <framebuffer_clear_region+0x12f>
				return;
		p = (char*)fb->text_mem + 2 * r->y * fb->width + 2 * r->x;
    38c9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    38cd:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    38d0:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    38d4:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
    38d8:	98                   	cwde
    38d9:	8d 0c 00             	lea    ecx,[rax+rax*1]
    38dc:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    38e0:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    38e3:	0f af c1             	imul   eax,ecx
    38e6:	48 63 c8             	movsxd rcx,eax
    38e9:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    38ed:	0f b7 00             	movzx  eax,WORD PTR [rax]
    38f0:	98                   	cwde
    38f1:	01 c0                	add    eax,eax
    38f3:	48 98                	cdqe
    38f5:	48 01 c8             	add    rax,rcx
    38f8:	48 01 d0             	add    rax,rdx
    38fb:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		for (ssize_t l = 0; l < r->ly; l++)
    38ff:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
    3906:	eb 71                	jmp    3979 <framebuffer_clear_region+0x109>
				for (ssize_t c = 0; c < r->lx; c++) {
    3908:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0
    390f:	eb 56                	jmp    3967 <framebuffer_clear_region+0xf7>
						p[l * 2 * fb->width + 2 * c] = '\0';
    3911:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    3914:	8d 14 00             	lea    edx,[rax+rax*1]
    3917:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    391b:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    391e:	0f af c2             	imul   eax,edx
    3921:	8b 55 f8             	mov    edx,DWORD PTR [rbp-0x8]
    3924:	01 d2                	add    edx,edx
    3926:	01 d0                	add    eax,edx
    3928:	48 63 d0             	movsxd rdx,eax
    392b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    392f:	48 01 d0             	add    rax,rdx
    3932:	c6 00 00             	mov    BYTE PTR [rax],0x0
						p[l * 2 * fb->width + 2 * c + 1] = r->fmt;
    3935:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    3938:	8d 14 00             	lea    edx,[rax+rax*1]
    393b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    393f:	8b 40 08             	mov    eax,DWORD PTR [rax+0x8]
    3942:	0f af c2             	imul   eax,edx
    3945:	8b 55 f8             	mov    edx,DWORD PTR [rbp-0x8]
    3948:	01 d2                	add    edx,edx
    394a:	01 d0                	add    eax,edx
    394c:	48 98                	cdqe
    394e:	48 8d 50 01          	lea    rdx,[rax+0x1]
    3952:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    3956:	48 01 c2             	add    rdx,rax
    3959:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    395d:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    3961:	88 02                	mov    BYTE PTR [rdx],al
				for (ssize_t c = 0; c < r->lx; c++) {
    3963:	83 45 f8 01          	add    DWORD PTR [rbp-0x8],0x1
    3967:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    396b:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
    396f:	98                   	cwde
    3970:	39 45 f8             	cmp    DWORD PTR [rbp-0x8],eax
    3973:	7c 9c                	jl     3911 <framebuffer_clear_region+0xa1>
		for (ssize_t l = 0; l < r->ly; l++)
    3975:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
    3979:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    397d:	0f b7 40 06          	movzx  eax,WORD PTR [rax+0x6]
    3981:	98                   	cwde
    3982:	39 45 fc             	cmp    DWORD PTR [rbp-0x4],eax
    3985:	7c 81                	jl     3908 <framebuffer_clear_region+0x98>
				}
		framebuffer_update_region(fb, r);
    3987:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    398b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    398f:	48 89 d6             	mov    rsi,rdx
    3992:	48 89 c7             	mov    rdi,rax
    3995:	e8 00 00 00 00       	call   399a <framebuffer_clear_region+0x12a>
    399a:	eb 04                	jmp    39a0 <framebuffer_clear_region+0x130>
				return;
    399c:	90                   	nop
    399d:	eb 01                	jmp    39a0 <framebuffer_clear_region+0x130>
				return;
    399f:	90                   	nop
}
    39a0:	c9                   	leave
    39a1:	c3                   	ret

00000000000039a2 <framebuffer_set_cursor>:

/* has to flush the previous character and the new one and also pending updates */
void framebuffer_set_cursor(struct framebuffer* fb, ssize_t x, ssize_t y)
{
    39a2:	55                   	push   rbp
    39a3:	48 89 e5             	mov    rbp,rsp
    39a6:	48 83 ec 30          	sub    rsp,0x30
    39aa:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
    39ae:	89 75 d4             	mov    DWORD PTR [rbp-0x2c],esi
    39b1:	89 55 d0             	mov    DWORD PTR [rbp-0x30],edx
		struct kio_region r;
		if (fb->cur_x > 0 && fb->cur_y > 0
    39b4:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    39b8:	8b 40 1c             	mov    eax,DWORD PTR [rax+0x1c]
    39bb:	85 c0                	test   eax,eax
    39bd:	0f 8e 94 00 00 00    	jle    3a57 <framebuffer_set_cursor+0xb5>
    39c3:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    39c7:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    39ca:	85 c0                	test   eax,eax
    39cc:	0f 8e 85 00 00 00    	jle    3a57 <framebuffer_set_cursor+0xb5>
			&& fb->cur_x < fb->chw_x
    39d2:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    39d6:	8b 50 1c             	mov    edx,DWORD PTR [rax+0x1c]
    39d9:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    39dd:	8b 40 34             	mov    eax,DWORD PTR [rax+0x34]
    39e0:	39 c2                	cmp    edx,eax
    39e2:	7d 73                	jge    3a57 <framebuffer_set_cursor+0xb5>
			&& fb->cur_y < fb->chw_y) {
    39e4:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    39e8:	8b 50 20             	mov    edx,DWORD PTR [rax+0x20]
    39eb:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    39ef:	8b 40 38             	mov    eax,DWORD PTR [rax+0x38]
    39f2:	39 c2                	cmp    edx,eax
    39f4:	7d 61                	jge    3a57 <framebuffer_set_cursor+0xb5>
				r.x = fb->cur_x + fb->cho_y;
    39f6:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    39fa:	8b 40 1c             	mov    eax,DWORD PTR [rax+0x1c]
    39fd:	89 c2                	mov    edx,eax
    39ff:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3a03:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
    3a06:	01 d0                	add    eax,edx
    3a08:	66 89 45 e0          	mov    WORD PTR [rbp-0x20],ax
				r.lx = 1;
    3a0c:	66 c7 45 e4 01 00    	mov    WORD PTR [rbp-0x1c],0x1
				r.y = fb->cur_y + fb->cho_y;
    3a12:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3a16:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    3a19:	89 c2                	mov    edx,eax
    3a1b:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3a1f:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
    3a22:	01 d0                	add    eax,edx
    3a24:	66 89 45 e2          	mov    WORD PTR [rbp-0x1e],ax
				r.ly = 1;
    3a28:	66 c7 45 e6 01 00    	mov    WORD PTR [rbp-0x1a],0x1
				fb->cur_x = x;
    3a2e:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3a32:	8b 55 d4             	mov    edx,DWORD PTR [rbp-0x2c]
    3a35:	89 50 1c             	mov    DWORD PTR [rax+0x1c],edx
				fb->cur_y = y;
    3a38:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3a3c:	8b 55 d0             	mov    edx,DWORD PTR [rbp-0x30]
    3a3f:	89 50 20             	mov    DWORD PTR [rax+0x20],edx
				framebuffer_update_region(fb, &r);
    3a42:	48 8d 55 e0          	lea    rdx,[rbp-0x20]
    3a46:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3a4a:	48 89 d6             	mov    rsi,rdx
    3a4d:	48 89 c7             	mov    rdi,rax
    3a50:	e8 00 00 00 00       	call   3a55 <framebuffer_set_cursor+0xb3>
    3a55:	eb 14                	jmp    3a6b <framebuffer_set_cursor+0xc9>
		} else {
				fb->cur_x = x;
    3a57:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3a5b:	8b 55 d4             	mov    edx,DWORD PTR [rbp-0x2c]
    3a5e:	89 50 1c             	mov    DWORD PTR [rax+0x1c],edx
				fb->cur_y = y;
    3a61:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3a65:	8b 55 d0             	mov    edx,DWORD PTR [rbp-0x30]
    3a68:	89 50 20             	mov    DWORD PTR [rax+0x20],edx
		}
		r.x = fb->cur_x + fb->cho_x;
    3a6b:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3a6f:	8b 40 1c             	mov    eax,DWORD PTR [rax+0x1c]
    3a72:	89 c2                	mov    edx,eax
    3a74:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3a78:	8b 40 2c             	mov    eax,DWORD PTR [rax+0x2c]
    3a7b:	01 d0                	add    eax,edx
    3a7d:	66 89 45 e0          	mov    WORD PTR [rbp-0x20],ax
		r.y = fb->cur_y + fb->cho_y;
    3a81:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3a85:	8b 40 20             	mov    eax,DWORD PTR [rax+0x20]
    3a88:	89 c2                	mov    edx,eax
    3a8a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3a8e:	8b 40 30             	mov    eax,DWORD PTR [rax+0x30]
    3a91:	01 d0                	add    eax,edx
    3a93:	66 89 45 e2          	mov    WORD PTR [rbp-0x1e],ax
		r.lx = r.ly = 1;
    3a97:	66 c7 45 e6 01 00    	mov    WORD PTR [rbp-0x1a],0x1
    3a9d:	0f b7 45 e6          	movzx  eax,WORD PTR [rbp-0x1a]
    3aa1:	66 89 45 e4          	mov    WORD PTR [rbp-0x1c],ax
		framebuffer_update_region(fb, &r);
    3aa5:	48 8d 55 e0          	lea    rdx,[rbp-0x20]
    3aa9:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    3aad:	48 89 d6             	mov    rsi,rdx
    3ab0:	48 89 c7             	mov    rdi,rax
    3ab3:	e8 00 00 00 00       	call   3ab8 <framebuffer_set_cursor+0x116>
		//framebuffer_redraw(fb);
}
    3ab8:	90                   	nop
    3ab9:	c9                   	leave
    3aba:	c3                   	ret

0000000000003abb <framebuffer_resize>:

/* works on character cells */
void framebuffer_resize(struct framebuffer* fb, ssize_t new_lx, ssize_t new_ly)
{
    3abb:	55                   	push   rbp
    3abc:	48 89 e5             	mov    rbp,rsp
    3abf:	48 83 ec 10          	sub    rsp,0x10
    3ac3:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
    3ac7:	89 75 f4             	mov    DWORD PTR [rbp-0xc],esi
    3aca:	89 55 f0             	mov    DWORD PTR [rbp-0x10],edx
		(void)fb; (void)new_lx; (void)new_ly;
}
    3acd:	90                   	nop
    3ace:	c9                   	leave
    3acf:	c3                   	ret
