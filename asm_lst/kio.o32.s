
kio.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <memcpy>:
				} else if (nonz)
						ctx->putchar(ctx, '0');
				else if ((32 - i) <= prec) /* has precedence over with */
						ctx->putchar(ctx, '0');
				else if ((32 - i) <= width)
						ctx->putchar(ctx, flags & KFL_ZERO_PREFIX ? '0' : ' ');
       0:	55                   	push   ebp
       1:	89 e5                	mov    ebp,esp
       3:	83 ec 10             	sub    esp,0x10
				else if (i == 31 && prec >= 0) /* only print 0 for nonneg prec */
       6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
       9:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
						ctx->putchar(ctx, '0');
       c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
       f:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
				else
      12:	eb 17                	jmp    2b <memcpy+0x2b>
						rv--;
      14:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
      17:	8d 42 01             	lea    eax,[edx+0x1]
      1a:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
      1d:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
      20:	8d 48 01             	lea    ecx,[eax+0x1]
      23:	89 4d fc             	mov    DWORD PTR [ebp-0x4],ecx
      26:	0f b6 12             	movzx  edx,BYTE PTR [edx]
      29:	88 10                	mov    BYTE PTR [eax],dl
				else
      2b:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
      2e:	8d 50 ff             	lea    edx,[eax-0x1]
      31:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
      34:	85 c0                	test   eax,eax
      36:	75 dc                	jne    14 <memcpy+0x14>
				arg <<= 1;
      38:	90                   	nop
      39:	90                   	nop
      3a:	c9                   	leave
      3b:	c3                   	ret

0000003c <kio_fb_resize>:
{
      3c:	55                   	push   ebp
      3d:	89 e5                	mov    ebp,esp
      3f:	83 ec 18             	sub    esp,0x18
		reg_def.lx = fb_initial.width - 20;
      42:	a1 04 00 00 00       	mov    eax,ds:0x4
      47:	83 e8 14             	sub    eax,0x14
      4a:	66 a3 04 00 00 00    	mov    ds:0x4,ax
		reg_def.ly = fb_initial.height;
      50:	a1 08 00 00 00       	mov    eax,ds:0x8
      55:	66 a3 06 00 00 00    	mov    ds:0x6,ax
		kernel_fb_resize();
      5b:	e8 fc ff ff ff       	call   5c <kio_fb_resize+0x20>
		kbd_fb_resize(fb_initial.width, fb_initial.height);
      60:	8b 15 08 00 00 00    	mov    edx,DWORD PTR ds:0x8
      66:	a1 04 00 00 00       	mov    eax,ds:0x4
      6b:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
      6f:	89 04 24             	mov    DWORD PTR [esp],eax
      72:	e8 fc ff ff ff       	call   73 <kio_fb_resize+0x37>
}
      77:	90                   	nop
      78:	c9                   	leave
      79:	c3                   	ret

0000007a <getc_pr>:
{
      7a:	55                   	push   ebp
      7b:	89 e5                	mov    ebp,esp
      7d:	83 ec 08             	sub    esp,0x8
      80:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
      83:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
      86:	66 89 55 fc          	mov    WORD PTR [ebp-0x4],dx
      8a:	66 89 45 f8          	mov    WORD PTR [ebp-0x8],ax
		if (x < cr->lx && y < cr->ly) {
      8e:	0f b7 55 fc          	movzx  edx,WORD PTR [ebp-0x4]
      92:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      95:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
      99:	98                   	cwde
      9a:	39 c2                	cmp    edx,eax
      9c:	7d 46                	jge    e4 <getc_pr+0x6a>
      9e:	0f b7 55 f8          	movzx  edx,WORD PTR [ebp-0x8]
      a2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      a5:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
      a9:	98                   	cwde
      aa:	39 c2                	cmp    edx,eax
      ac:	7d 36                	jge    e4 <getc_pr+0x6a>
				x += cr->x;
      ae:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      b1:	0f b7 00             	movzx  eax,WORD PTR [eax]
      b4:	66 01 45 fc          	add    WORD PTR [ebp-0x4],ax
				y += cr->y;
      b8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      bb:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
      bf:	66 01 45 f8          	add    WORD PTR [ebp-0x8],ax
				return ((char*)fb_initial.text_mem)[2 * (y * fb_initial.width + x)];
      c3:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
      c9:	0f b7 55 f8          	movzx  edx,WORD PTR [ebp-0x8]
      cd:	a1 04 00 00 00       	mov    eax,ds:0x4
      d2:	0f af d0             	imul   edx,eax
      d5:	0f b7 45 fc          	movzx  eax,WORD PTR [ebp-0x4]
      d9:	01 d0                	add    eax,edx
      db:	01 c0                	add    eax,eax
      dd:	01 c8                	add    eax,ecx
      df:	0f b6 00             	movzx  eax,BYTE PTR [eax]
      e2:	eb 05                	jmp    e9 <getc_pr+0x6f>
				return 0;
      e4:	b8 00 00 00 00       	mov    eax,0x0
}
      e9:	c9                   	leave
      ea:	c3                   	ret

000000eb <putc_pr>:
{
      eb:	55                   	push   ebp
      ec:	89 e5                	mov    ebp,esp
      ee:	83 ec 48             	sub    esp,0x48
      f1:	8b 4d 0c             	mov    ecx,DWORD PTR [ebp+0xc]
      f4:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
      f7:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
      fa:	88 4d d4             	mov    BYTE PTR [ebp-0x2c],cl
      fd:	66 89 55 d0          	mov    WORD PTR [ebp-0x30],dx
     101:	66 89 45 cc          	mov    WORD PTR [ebp-0x34],ax
		if (x < cr->lx && y < cr->ly) { /* don't corrupt memory */
     105:	0f b7 55 d0          	movzx  edx,WORD PTR [ebp-0x30]
     109:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     10c:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
     110:	98                   	cwde
     111:	39 c2                	cmp    edx,eax
     113:	0f 8d f9 00 00 00    	jge    212 <putc_pr+0x127>
     119:	0f b7 55 cc          	movzx  edx,WORD PTR [ebp-0x34]
     11d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     120:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
     124:	98                   	cwde
     125:	39 c2                	cmp    edx,eax
     127:	0f 8d e5 00 00 00    	jge    212 <putc_pr+0x127>
				x += cr->x;
     12d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     130:	0f b7 00             	movzx  eax,WORD PTR [eax]
     133:	66 01 45 d0          	add    WORD PTR [ebp-0x30],ax
				y += cr->y;
     137:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     13a:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
     13e:	66 01 45 cc          	add    WORD PTR [ebp-0x34],ax
				if (x >= fb_initial.width || y >= fb_initial.height)
     142:	0f b7 55 d0          	movzx  edx,WORD PTR [ebp-0x30]
     146:	a1 04 00 00 00       	mov    eax,ds:0x4
     14b:	39 c2                	cmp    edx,eax
     14d:	0f 8d be 00 00 00    	jge    211 <putc_pr+0x126>
     153:	0f b7 55 cc          	movzx  edx,WORD PTR [ebp-0x34]
     157:	a1 08 00 00 00       	mov    eax,ds:0x8
     15c:	39 c2                	cmp    edx,eax
     15e:	0f 8d ad 00 00 00    	jge    211 <putc_pr+0x126>
				p1 = &((char*)fb_initial.text_mem)[2 * (y * fb_initial.width + x)];
     164:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
     16a:	0f b7 55 cc          	movzx  edx,WORD PTR [ebp-0x34]
     16e:	a1 04 00 00 00       	mov    eax,ds:0x4
     173:	0f af d0             	imul   edx,eax
     176:	0f b7 45 d0          	movzx  eax,WORD PTR [ebp-0x30]
     17a:	01 d0                	add    eax,edx
     17c:	01 c0                	add    eax,eax
     17e:	01 c8                	add    eax,ecx
     180:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				p2 = &((char*)fb_initial.text_mem)[2 * (y * fb_initial.width + x) + 1];
     183:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
     189:	0f b7 55 cc          	movzx  edx,WORD PTR [ebp-0x34]
     18d:	a1 04 00 00 00       	mov    eax,ds:0x4
     192:	0f af d0             	imul   edx,eax
     195:	0f b7 45 d0          	movzx  eax,WORD PTR [ebp-0x30]
     199:	01 d0                	add    eax,edx
     19b:	01 c0                	add    eax,eax
     19d:	83 c0 01             	add    eax,0x1
     1a0:	01 c8                	add    eax,ecx
     1a2:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				if (*p1 != c || *p2 != cr->fmt) {
     1a5:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     1a8:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     1ab:	38 45 d4             	cmp    BYTE PTR [ebp-0x2c],al
     1ae:	75 11                	jne    1c1 <putc_pr+0xd6>
     1b0:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     1b3:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     1b6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1b9:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
     1bd:	38 c2                	cmp    dl,al
     1bf:	74 51                	je     212 <putc_pr+0x127>
						*p1 = c;
     1c1:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     1c4:	0f b6 55 d4          	movzx  edx,BYTE PTR [ebp-0x2c]
     1c8:	88 10                	mov    BYTE PTR [eax],dl
						*p2 = cr->fmt;
     1ca:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1cd:	0f b6 50 0c          	movzx  edx,BYTE PTR [eax+0xc]
     1d1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     1d4:	88 10                	mov    BYTE PTR [eax],dl
						r.x = x;
     1d6:	0f b7 45 d0          	movzx  eax,WORD PTR [ebp-0x30]
     1da:	66 89 45 dc          	mov    WORD PTR [ebp-0x24],ax
						r.y = y;
     1de:	0f b7 45 cc          	movzx  eax,WORD PTR [ebp-0x34]
     1e2:	66 89 45 de          	mov    WORD PTR [ebp-0x22],ax
						r.lx = 1;
     1e6:	66 c7 45 e0 01 00    	mov    WORD PTR [ebp-0x20],0x1
						r.ly = 1;
     1ec:	66 c7 45 e2 01 00    	mov    WORD PTR [ebp-0x1e],0x1
						r.fmt = cr->fmt;
     1f2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1f5:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
     1f9:	88 45 e8             	mov    BYTE PTR [ebp-0x18],al
						framebuffer_update_region(&fb_initial, &r);
     1fc:	8d 45 dc             	lea    eax,[ebp-0x24]
     1ff:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     203:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     20a:	e8 fc ff ff ff       	call   20b <putc_pr+0x120>
     20f:	eb 01                	jmp    212 <putc_pr+0x127>
						return;
     211:	90                   	nop
}
     212:	c9                   	leave
     213:	c3                   	ret

00000214 <putc_prc>:
{
     214:	55                   	push   ebp
     215:	89 e5                	mov    ebp,esp
     217:	53                   	push   ebx
     218:	83 ec 34             	sub    esp,0x34
     21b:	8b 5d 0c             	mov    ebx,DWORD PTR [ebp+0xc]
     21e:	8b 4d 10             	mov    ecx,DWORD PTR [ebp+0x10]
     221:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
     224:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     227:	88 5d e4             	mov    BYTE PTR [ebp-0x1c],bl
     22a:	88 4d e0             	mov    BYTE PTR [ebp-0x20],cl
     22d:	66 89 55 dc          	mov    WORD PTR [ebp-0x24],dx
     231:	66 89 45 d8          	mov    WORD PTR [ebp-0x28],ax
		char f = cr->fmt;
     235:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     238:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
     23c:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
		cr->fmt = fmt;
     23f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     242:	0f b6 55 e4          	movzx  edx,BYTE PTR [ebp-0x1c]
     246:	88 50 0c             	mov    BYTE PTR [eax+0xc],dl
		putc_pr(cr, c, x, y);
     249:	0f b7 4d d8          	movzx  ecx,WORD PTR [ebp-0x28]
     24d:	0f b7 55 dc          	movzx  edx,WORD PTR [ebp-0x24]
     251:	0f be 45 e0          	movsx  eax,BYTE PTR [ebp-0x20]
     255:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
     259:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     25d:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     261:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     264:	89 04 24             	mov    DWORD PTR [esp],eax
     267:	e8 fc ff ff ff       	call   268 <putc_prc+0x54>
		cr->fmt = f;
     26c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     26f:	0f b6 55 f7          	movzx  edx,BYTE PTR [ebp-0x9]
     273:	88 50 0c             	mov    BYTE PTR [eax+0xc],dl
}
     276:	90                   	nop
     277:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     27a:	c9                   	leave
     27b:	c3                   	ret

0000027c <region_clear>:
{
     27c:	55                   	push   ebp
     27d:	89 e5                	mov    ebp,esp
     27f:	83 ec 18             	sub    esp,0x18
		framebuffer_clear_region(&fb_initial, cr);
     282:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     285:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     289:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     290:	e8 fc ff ff ff       	call   291 <region_clear+0x15>
}
     295:	90                   	nop
     296:	c9                   	leave
     297:	c3                   	ret

00000298 <scroll_buffer>:
{
     298:	55                   	push   ebp
     299:	89 e5                	mov    ebp,esp
     29b:	83 ec 18             	sub    esp,0x18
		framebuffer_scroll_region(&fb_initial, cr, 0, 1);
     29e:	c7 44 24 0c 01 00 00 00 	mov    DWORD PTR [esp+0xc],0x1
     2a6:	c7 44 24 08 00 00 00 00 	mov    DWORD PTR [esp+0x8],0x0
     2ae:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     2b1:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     2b5:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     2bc:	e8 fc ff ff ff       	call   2bd <scroll_buffer+0x25>
		if (!(cr->flags & KIO_REGION_NO_DELAY)) {
     2c1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     2c4:	0f b6 40 0d          	movzx  eax,BYTE PTR [eax+0xd]
     2c8:	0f be c0             	movsx  eax,al
     2cb:	83 e0 01             	and    eax,0x1
     2ce:	85 c0                	test   eax,eax
     2d0:	75 1a                	jne    2ec <scroll_buffer+0x54>
			mdelay(50);
     2d2:	c7 04 24 32 00 00 00 	mov    DWORD PTR [esp],0x32
     2d9:	e8 fc ff ff ff       	call   2da <scroll_buffer+0x42>
			while (cur_brk)
     2de:	eb 01                	jmp    2e1 <scroll_buffer+0x49>
					__asm__("hlt");
     2e0:	f4                   	hlt
			while (cur_brk)
     2e1:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
     2e8:	84 c0                	test   al,al
     2ea:	75 f4                	jne    2e0 <scroll_buffer+0x48>
}
     2ec:	90                   	nop
     2ed:	c9                   	leave
     2ee:	c3                   	ret

000002ef <scroll_left>:
{
     2ef:	55                   	push   ebp
     2f0:	89 e5                	mov    ebp,esp
     2f2:	56                   	push   esi
     2f3:	53                   	push   ebx
     2f4:	83 ec 30             	sub    esp,0x30
		r.y = cr->y + cr->cur_y;
     2f7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     2fa:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
     2fe:	89 c2                	mov    edx,eax
     300:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     303:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     307:	01 d0                	add    eax,edx
     309:	66 89 45 e6          	mov    WORD PTR [ebp-0x1a],ax
		r.x = cr->x;
     30d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     310:	0f b7 00             	movzx  eax,WORD PTR [eax]
     313:	66 89 45 e4          	mov    WORD PTR [ebp-0x1c],ax
		r.ly = 1;
     317:	66 c7 45 ea 01 00    	mov    WORD PTR [ebp-0x16],0x1
		r.lx = cr->lx;
     31d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     320:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
     324:	66 89 45 e8          	mov    WORD PTR [ebp-0x18],ax
						(cr->lx - 1) * 2);
     328:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     32b:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
     32f:	98                   	cwde
     330:	83 e8 01             	sub    eax,0x1
     333:	01 c0                	add    eax,eax
		memcpy((char*)fb_initial.text_mem + r.y * fb_initial.width * 2 + r.x * 2,
     335:	89 c6                	mov    esi,eax
						(char*)fb_initial.text_mem + r.y * fb_initial.width * 2 + r.x * 2 + 2,
     337:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
     33d:	0f b7 45 e6          	movzx  eax,WORD PTR [ebp-0x1a]
     341:	0f bf d0             	movsx  edx,ax
     344:	a1 04 00 00 00       	mov    eax,ds:0x4
     349:	0f af c2             	imul   eax,edx
     34c:	01 c0                	add    eax,eax
     34e:	89 c2                	mov    edx,eax
     350:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
     354:	98                   	cwde
     355:	01 c0                	add    eax,eax
     357:	01 d0                	add    eax,edx
     359:	83 c0 02             	add    eax,0x2
		memcpy((char*)fb_initial.text_mem + r.y * fb_initial.width * 2 + r.x * 2,
     35c:	01 c1                	add    ecx,eax
     35e:	8b 1d 00 00 00 00    	mov    ebx,DWORD PTR ds:0x0
     364:	0f b7 45 e6          	movzx  eax,WORD PTR [ebp-0x1a]
     368:	0f bf d0             	movsx  edx,ax
     36b:	a1 04 00 00 00       	mov    eax,ds:0x4
     370:	0f af c2             	imul   eax,edx
     373:	01 c0                	add    eax,eax
     375:	89 c2                	mov    edx,eax
     377:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
     37b:	98                   	cwde
     37c:	01 c0                	add    eax,eax
     37e:	01 d0                	add    eax,edx
     380:	01 d8                	add    eax,ebx
     382:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
     386:	89 4c 24 04          	mov    DWORD PTR [esp+0x4],ecx
     38a:	89 04 24             	mov    DWORD PTR [esp],eax
     38d:	e8 6e fc ff ff       	call   0 <memcpy>
		framebuffer_update_region(&fb_initial, &r);
     392:	8d 45 e4             	lea    eax,[ebp-0x1c]
     395:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     399:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     3a0:	e8 fc ff ff ff       	call   3a1 <scroll_left+0xb2>
		cr->cur_x--;
     3a5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3a8:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     3ac:	83 e8 01             	sub    eax,0x1
     3af:	89 c2                	mov    edx,eax
     3b1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3b4:	66 89 50 0e          	mov    WORD PTR [eax+0xe],dx
		putc_pr(cr, '\0', cr->cur_x, cr->cur_y);
     3b8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3bb:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     3bf:	0f b7 d0             	movzx  edx,ax
     3c2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3c5:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     3c9:	0f b7 c0             	movzx  eax,ax
     3cc:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
     3d0:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     3d4:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
     3dc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3df:	89 04 24             	mov    DWORD PTR [esp],eax
     3e2:	e8 fc ff ff ff       	call   3e3 <scroll_left+0xf4>
}
     3e7:	90                   	nop
     3e8:	83 c4 30             	add    esp,0x30
     3eb:	5b                   	pop    ebx
     3ec:	5e                   	pop    esi
     3ed:	5d                   	pop    ebp
     3ee:	c3                   	ret

000003ef <region_unputchar>:
{
     3ef:	55                   	push   ebp
     3f0:	89 e5                	mov    ebp,esp
     3f2:	83 ec 18             	sub    esp,0x18
		if (cr->cur_x) {
     3f5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3f8:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     3fc:	66 85 c0             	test   ax,ax
     3ff:	74 47                	je     448 <region_unputchar+0x59>
				cr->cur_x--;
     401:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     404:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     408:	83 e8 01             	sub    eax,0x1
     40b:	89 c2                	mov    edx,eax
     40d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     410:	66 89 50 0e          	mov    WORD PTR [eax+0xe],dx
				putc_pr(cr, '\0', cr->cur_x, cr->cur_y);
     414:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     417:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     41b:	0f b7 d0             	movzx  edx,ax
     41e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     421:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     425:	0f b7 c0             	movzx  eax,ax
     428:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
     42c:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     430:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
     438:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     43b:	89 04 24             	mov    DWORD PTR [esp],eax
     43e:	e8 fc ff ff ff       	call   43f <region_unputchar+0x50>
}
     443:	e9 af 00 00 00       	jmp    4f7 <region_unputchar+0x108>
		} else if (cr->cur_y) {
     448:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     44b:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     44f:	66 85 c0             	test   ax,ax
     452:	0f 84 9f 00 00 00    	je     4f7 <region_unputchar+0x108>
				cr->cur_y--;
     458:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     45b:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     45f:	83 e8 01             	sub    eax,0x1
     462:	89 c2                	mov    edx,eax
     464:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     467:	66 89 50 10          	mov    WORD PTR [eax+0x10],dx
				cr->cur_x = cr->lx;
     46b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     46e:	0f b7 50 04          	movzx  edx,WORD PTR [eax+0x4]
     472:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     475:	66 89 50 0e          	mov    WORD PTR [eax+0xe],dx
				while (--cr->cur_x)
     479:	eb 2b                	jmp    4a6 <region_unputchar+0xb7>
						if (getc_pr(cr, cr->cur_x, cr->cur_y) != '\0')
     47b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     47e:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     482:	0f b7 d0             	movzx  edx,ax
     485:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     488:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     48c:	0f b7 c0             	movzx  eax,ax
     48f:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     493:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     497:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     49a:	89 04 24             	mov    DWORD PTR [esp],eax
     49d:	e8 fc ff ff ff       	call   49e <region_unputchar+0xaf>
     4a2:	84 c0                	test   al,al
     4a4:	75 21                	jne    4c7 <region_unputchar+0xd8>
				while (--cr->cur_x)
     4a6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     4a9:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     4ad:	83 e8 01             	sub    eax,0x1
     4b0:	89 c2                	mov    edx,eax
     4b2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     4b5:	66 89 50 0e          	mov    WORD PTR [eax+0xe],dx
     4b9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     4bc:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     4c0:	66 85 c0             	test   ax,ax
     4c3:	75 b6                	jne    47b <region_unputchar+0x8c>
     4c5:	eb 01                	jmp    4c8 <region_unputchar+0xd9>
								break;
     4c7:	90                   	nop
				putc_pr(cr, '\0', cr->cur_x, cr->cur_y);
     4c8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     4cb:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     4cf:	0f b7 d0             	movzx  edx,ax
     4d2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     4d5:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     4d9:	0f b7 c0             	movzx  eax,ax
     4dc:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
     4e0:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     4e4:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
     4ec:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     4ef:	89 04 24             	mov    DWORD PTR [esp],eax
     4f2:	e8 fc ff ff ff       	call   4f3 <region_unputchar+0x104>
}
     4f7:	90                   	nop
     4f8:	c9                   	leave
     4f9:	c3                   	ret

000004fa <region_getline>:
{
     4fa:	55                   	push   ebp
     4fb:	89 e5                	mov    ebp,esp
     4fd:	83 ec 38             	sub    esp,0x38
		char* str; size_t rem, ct = 0;
     500:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		if (!lineptr || !n || (cr->flags & KIO_REGION_INPUT_DISABLED)) {
     507:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
     50b:	74 17                	je     524 <region_getline+0x2a>
     50d:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
     511:	74 11                	je     524 <region_getline+0x2a>
     513:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     516:	0f b6 40 0d          	movzx  eax,BYTE PTR [eax+0xd]
     51a:	0f be c0             	movsx  eax,al
     51d:	83 e0 08             	and    eax,0x8
     520:	85 c0                	test   eax,eax
     522:	74 14                	je     538 <region_getline+0x3e>
				errno = EINVAL;
     524:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
				return -1;
     52e:	b8 ff ff ff ff       	mov    eax,0xffffffff
     533:	e9 7a 02 00 00       	jmp    7b2 <region_getline+0x2b8>
		str = *lineptr;
     538:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     53b:	8b 00                	mov    eax,DWORD PTR [eax]
     53d:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		rem = *n;
     540:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     543:	8b 00                	mov    eax,DWORD PTR [eax]
     545:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		if (rem == 0) {
     548:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     54c:	75 27                	jne    575 <region_getline+0x7b>
				str = kmalloc(80);
     54e:	c7 04 24 50 00 00 00 	mov    DWORD PTR [esp],0x50
     555:	e8 fc ff ff ff       	call   556 <region_getline+0x5c>
     55a:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				rem = 80;
     55d:	c7 45 f0 50 00 00 00 	mov    DWORD PTR [ebp-0x10],0x50
				*n = 80;
     564:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     567:	c7 00 50 00 00 00    	mov    DWORD PTR [eax],0x50
				*lineptr = str;
     56d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     570:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     573:	89 10                	mov    DWORD PTR [eax],edx
				if (!(cr->flags & KIO_REGION_INPUT_NOCURSOR)) {
     575:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     578:	0f b6 40 0d          	movzx  eax,BYTE PTR [eax+0xd]
     57c:	84 c0                	test   al,al
     57e:	78 3b                	js     5bb <region_getline+0xc1>
										cr->y + cr->cur_y);
     580:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     583:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
     587:	0f bf d0             	movsx  edx,ax
     58a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     58d:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     591:	98                   	cwde
						framebuffer_set_cursor(&fb_initial, cr->x + cr->cur_x,
     592:	01 c2                	add    edx,eax
     594:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     597:	0f b7 00             	movzx  eax,WORD PTR [eax]
     59a:	0f bf c8             	movsx  ecx,ax
     59d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     5a0:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     5a4:	98                   	cwde
     5a5:	01 c8                	add    eax,ecx
     5a7:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     5ab:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     5af:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     5b6:	e8 fc ff ff ff       	call   5b7 <region_getline+0xbd>
				int c = region_getchar(cr);
     5bb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     5be:	89 04 24             	mov    DWORD PTR [esp],eax
     5c1:	e8 fc ff ff ff       	call   5c2 <region_getline+0xc8>
     5c6:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				if (c == EOF) {
     5c9:	83 7d e8 ff          	cmp    DWORD PTR [ebp-0x18],0xffffffff
     5cd:	75 13                	jne    5e2 <region_getline+0xe8>
						str[ct] = '\0';
     5cf:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     5d2:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     5d5:	01 d0                	add    eax,edx
     5d7:	c6 00 00             	mov    BYTE PTR [eax],0x0
						return ct;
     5da:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     5dd:	e9 d0 01 00 00       	jmp    7b2 <region_getline+0x2b8>
				} else if (c == '\b') {
     5e2:	83 7d e8 08          	cmp    DWORD PTR [ebp-0x18],0x8
     5e6:	0f 85 a5 00 00 00    	jne    691 <region_getline+0x197>
						if (ct) {
     5ec:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     5f0:	0f 84 b6 01 00 00    	je     7ac <region_getline+0x2b2>
								str[--ct] = '\0';
     5f6:	83 6d ec 01          	sub    DWORD PTR [ebp-0x14],0x1
     5fa:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     5fd:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     600:	01 d0                	add    eax,edx
     602:	c6 00 00             	mov    BYTE PTR [eax],0x0
								if (cr->cur_x || (cr->flags & KIO_REGION_INPUT_MULTILINE))
     605:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     608:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     60c:	66 85 c0             	test   ax,ax
     60f:	75 11                	jne    622 <region_getline+0x128>
     611:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     614:	0f b6 40 0d          	movzx  eax,BYTE PTR [eax+0xd]
     618:	0f be c0             	movsx  eax,al
     61b:	83 e0 10             	and    eax,0x10
     61e:	85 c0                	test   eax,eax
     620:	74 10                	je     632 <region_getline+0x138>
										region_unputchar(cr);
     622:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     625:	89 04 24             	mov    DWORD PTR [esp],eax
     628:	e8 fc ff ff ff       	call   629 <region_getline+0x12f>
						continue;
     62d:	e9 7a 01 00 00       	jmp    7ac <region_getline+0x2b2>
								else if (ct && !(cr->flags & KIO_REGION_INPUT_MULTILINE)) {
     632:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     636:	0f 84 70 01 00 00    	je     7ac <region_getline+0x2b2>
     63c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     63f:	0f b6 40 0d          	movzx  eax,BYTE PTR [eax+0xd]
     643:	0f be c0             	movsx  eax,al
     646:	83 e0 10             	and    eax,0x10
     649:	85 c0                	test   eax,eax
     64b:	0f 85 5b 01 00 00    	jne    7ac <region_getline+0x2b2>
										size_t nc = min(ct, (size_t)cr->lx);
     651:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     654:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
     658:	98                   	cwde
     659:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     65c:	39 c2                	cmp    edx,eax
     65e:	0f 46 c2             	cmovbe eax,edx
     661:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
										region_puts(cr, str + (ct - nc));
     664:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     667:	2b 45 e4             	sub    eax,DWORD PTR [ebp-0x1c]
     66a:	89 c2                	mov    edx,eax
     66c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     66f:	01 d0                	add    eax,edx
     671:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     675:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     678:	89 04 24             	mov    DWORD PTR [esp],eax
     67b:	e8 fc ff ff ff       	call   67c <region_getline+0x182>
										cr->cur_x = nc;
     680:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     683:	89 c2                	mov    edx,eax
     685:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     688:	66 89 50 0e          	mov    WORD PTR [eax+0xe],dx
						continue;
     68c:	e9 1b 01 00 00       	jmp    7ac <region_getline+0x2b2>
				str[ct++] = c;
     691:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     694:	8d 50 01             	lea    edx,[eax+0x1]
     697:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
     69a:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     69d:	01 d0                	add    eax,edx
     69f:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
     6a2:	88 10                	mov    BYTE PTR [eax],dl
				if (ct + 1 == rem) {
     6a4:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     6a7:	83 c0 01             	add    eax,0x1
     6aa:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
     6ad:	75 38                	jne    6e7 <region_getline+0x1ed>
						rem *= 2;
     6af:	d1 65 f0             	shl    DWORD PTR [ebp-0x10],1
						str = krealloc(str, rem);
     6b2:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     6b5:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     6b9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     6bc:	89 04 24             	mov    DWORD PTR [esp],eax
     6bf:	e8 fc ff ff ff       	call   6c0 <region_getline+0x1c6>
     6c4:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						if (!str)
     6c7:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     6cb:	75 0a                	jne    6d7 <region_getline+0x1dd>
								return -1;
     6cd:	b8 ff ff ff ff       	mov    eax,0xffffffff
     6d2:	e9 db 00 00 00       	jmp    7b2 <region_getline+0x2b8>
						*n = rem;
     6d7:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     6da:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     6dd:	89 10                	mov    DWORD PTR [eax],edx
						*lineptr = str;
     6df:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     6e2:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     6e5:	89 10                	mov    DWORD PTR [eax],edx
				if ((c == 10 || c == 13) && !(cr->flags & KIO_REGION_INPUT_MULTILINE)) {
     6e7:	83 7d e8 0a          	cmp    DWORD PTR [ebp-0x18],0xa
     6eb:	74 06                	je     6f3 <region_getline+0x1f9>
     6ed:	83 7d e8 0d          	cmp    DWORD PTR [ebp-0x18],0xd
     6f1:	75 37                	jne    72a <region_getline+0x230>
     6f3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     6f6:	0f b6 40 0d          	movzx  eax,BYTE PTR [eax+0xd]
     6fa:	0f be c0             	movsx  eax,al
     6fd:	83 e0 10             	and    eax,0x10
     700:	85 c0                	test   eax,eax
     702:	75 26                	jne    72a <region_getline+0x230>
						region_putchar(cr, '\n');
     704:	c7 44 24 04 0a 00 00 00 	mov    DWORD PTR [esp+0x4],0xa
     70c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     70f:	89 04 24             	mov    DWORD PTR [esp],eax
     712:	e8 fc ff ff ff       	call   713 <region_getline+0x219>
						str[ct] = '\0';
     717:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     71a:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     71d:	01 d0                	add    eax,edx
     71f:	c6 00 00             	mov    BYTE PTR [eax],0x0
						return ct;
     722:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     725:	e9 88 00 00 00       	jmp    7b2 <region_getline+0x2b8>
				if (!(cr->flags & KIO_REGION_INPUT_MULTILINE) && cr->cur_x == cr->lx) {
     72a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     72d:	0f b6 40 0d          	movzx  eax,BYTE PTR [eax+0xd]
     731:	0f be c0             	movsx  eax,al
     734:	83 e0 10             	and    eax,0x10
     737:	85 c0                	test   eax,eax
     739:	75 57                	jne    792 <region_getline+0x298>
     73b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     73e:	0f b7 50 0e          	movzx  edx,WORD PTR [eax+0xe]
     742:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     745:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
     749:	66 39 c2             	cmp    dx,ax
     74c:	75 44                	jne    792 <region_getline+0x298>
						if (cr->flags & KIO_REGION_INPUT_WRAP) {
     74e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     751:	0f b6 40 0d          	movzx  eax,BYTE PTR [eax+0xd]
     755:	0f be c0             	movsx  eax,al
     758:	83 e0 40             	and    eax,0x40
     75b:	85 c0                	test   eax,eax
     75d:	74 22                	je     781 <region_getline+0x287>
								scroll_left(cr);
     75f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     762:	89 04 24             	mov    DWORD PTR [esp],eax
     765:	e8 fc ff ff ff       	call   766 <region_getline+0x26c>
								region_putchar(cr, c);
     76a:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     76d:	0f be c0             	movsx  eax,al
     770:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     774:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     777:	89 04 24             	mov    DWORD PTR [esp],eax
     77a:	e8 fc ff ff ff       	call   77b <region_getline+0x281>
						if (cr->flags & KIO_REGION_INPUT_WRAP) {
     77f:	eb 2c                	jmp    7ad <region_getline+0x2b3>
								str[--ct] = '\0';
     781:	83 6d ec 01          	sub    DWORD PTR [ebp-0x14],0x1
     785:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     788:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     78b:	01 d0                	add    eax,edx
     78d:	c6 00 00             	mov    BYTE PTR [eax],0x0
						if (cr->flags & KIO_REGION_INPUT_WRAP) {
     790:	eb 1b                	jmp    7ad <region_getline+0x2b3>
						region_putchar(cr, c);
     792:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     795:	0f be c0             	movsx  eax,al
     798:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     79c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     79f:	89 04 24             	mov    DWORD PTR [esp],eax
     7a2:	e8 fc ff ff ff       	call   7a3 <region_getline+0x2a9>
     7a7:	e9 c9 fd ff ff       	jmp    575 <region_getline+0x7b>
						continue;
     7ac:	90                   	nop
		do {
     7ad:	e9 c3 fd ff ff       	jmp    575 <region_getline+0x7b>
}
     7b2:	c9                   	leave
     7b3:	c3                   	ret

000007b4 <getline>:
{
     7b4:	55                   	push   ebp
     7b5:	89 e5                	mov    ebp,esp
     7b7:	83 ec 18             	sub    esp,0x18
		kbd_handler(); // poke the buffer
     7ba:	e8 fc ff ff ff       	call   7bb <getline+0x7>
		return region_getline(&reg_def, lineptr, n);
     7bf:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     7c2:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     7c6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     7c9:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     7cd:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     7d4:	e8 fc ff ff ff       	call   7d5 <getline+0x21>
}
     7d9:	c9                   	leave
     7da:	c3                   	ret

000007db <region_getchar>:
{
     7db:	55                   	push   ebp
     7dc:	89 e5                	mov    ebp,esp
     7de:	83 ec 28             	sub    esp,0x28
		if (cr->flags & KIO_REGION_INPUT_DISABLED)
     7e1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     7e4:	0f b6 40 0d          	movzx  eax,BYTE PTR [eax+0xd]
     7e8:	0f be c0             	movsx  eax,al
     7eb:	83 e0 08             	and    eax,0x8
     7ee:	85 c0                	test   eax,eax
     7f0:	75 03                	jne    7f5 <region_getchar+0x1a>
Pos1:
     7f2:	90                   	nop
     7f3:	eb 07                	jmp    7fc <region_getchar+0x21>
				return EOF;
     7f5:	b8 ff ff ff ff       	mov    eax,0xffffffff
     7fa:	eb 56                	jmp    852 <region_getchar+0x77>
		if (kbd_event_present()) {
     7fc:	e8 fc ff ff ff       	call   7fd <region_getchar+0x22>
     801:	85 c0                	test   eax,eax
     803:	74 27                	je     82c <region_getchar+0x51>
				struct key_event ke = kbd_get_event();
     805:	8d 45 f0             	lea    eax,[ebp-0x10]
     808:	89 04 24             	mov    DWORD PTR [esp],eax
     80b:	e8 fc ff ff ff       	call   80c <region_getchar+0x31>
     810:	83 ec 04             	sub    esp,0x4
				int rv = kbd_event_translate(&ke);
     813:	8d 45 f0             	lea    eax,[ebp-0x10]
     816:	89 04 24             	mov    DWORD PTR [esp],eax
     819:	e8 fc ff ff ff       	call   81a <region_getchar+0x3f>
     81e:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				if (rv != 0)
     821:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     825:	74 d5                	je     7fc <region_getchar+0x21>
						return rv;
     827:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     82a:	eb 26                	jmp    852 <region_getchar+0x77>
		} else if (cr->flags & KIO_REGION_INPUT_NONBLOCKING)
     82c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     82f:	0f b6 40 0d          	movzx  eax,BYTE PTR [eax+0xd]
     833:	0f be c0             	movsx  eax,al
     836:	83 e0 20             	and    eax,0x20
     839:	85 c0                	test   eax,eax
     83b:	74 07                	je     844 <region_getchar+0x69>
				return EOF;
     83d:	b8 ff ff ff ff       	mov    eax,0xffffffff
     842:	eb 0e                	jmp    852 <region_getchar+0x77>
				wait_on_event(&wq_kbd);
     844:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     84b:	e8 fc ff ff ff       	call   84c <region_getchar+0x71>
		goto Pos1;
     850:	eb aa                	jmp    7fc <region_getchar+0x21>
}
     852:	c9                   	leave
     853:	c3                   	ret

00000854 <region_putchar>:
{
     854:	55                   	push   ebp
     855:	89 e5                	mov    ebp,esp
     857:	53                   	push   ebx
     858:	83 ec 44             	sub    esp,0x44
     85b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     85e:	88 45 d4             	mov    BYTE PTR [ebp-0x2c],al
		if (c == 10 || c == 13) {
     861:	80 7d d4 0a          	cmp    BYTE PTR [ebp-0x2c],0xa
     865:	74 0a                	je     871 <region_putchar+0x1d>
     867:	80 7d d4 0d          	cmp    BYTE PTR [ebp-0x2c],0xd
     86b:	0f 85 34 01 00 00    	jne    9a5 <region_putchar+0x151>
				for (i = cr->cur_x; i < cr->lx; i++)
     871:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     874:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     878:	66 89 45 f6          	mov    WORD PTR [ebp-0xa],ax
     87c:	eb 37                	jmp    8b5 <region_putchar+0x61>
						putc_pr(cr, '\0', i, cr->cur_y);
     87e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     881:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     885:	0f b7 d0             	movzx  edx,ax
     888:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
     88c:	0f b7 c0             	movzx  eax,ax
     88f:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
     893:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     897:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
     89f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8a2:	89 04 24             	mov    DWORD PTR [esp],eax
     8a5:	e8 fc ff ff ff       	call   8a6 <region_putchar+0x52>
				for (i = cr->cur_x; i < cr->lx; i++)
     8aa:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
     8ae:	83 c0 01             	add    eax,0x1
     8b1:	66 89 45 f6          	mov    WORD PTR [ebp-0xa],ax
     8b5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8b8:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
     8bc:	66 39 45 f6          	cmp    WORD PTR [ebp-0xa],ax
     8c0:	7c bc                	jl     87e <region_putchar+0x2a>
				r.x = cr->x + cr->cur_x;
     8c2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8c5:	0f b7 00             	movzx  eax,WORD PTR [eax]
     8c8:	89 c2                	mov    edx,eax
     8ca:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8cd:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     8d1:	01 d0                	add    eax,edx
     8d3:	66 89 45 e2          	mov    WORD PTR [ebp-0x1e],ax
				r.y = cr->y + cr->cur_y;
     8d7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8da:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
     8de:	89 c2                	mov    edx,eax
     8e0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8e3:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     8e7:	01 d0                	add    eax,edx
     8e9:	66 89 45 e4          	mov    WORD PTR [ebp-0x1c],ax
				r.ly = 1;
     8ed:	66 c7 45 e8 01 00    	mov    WORD PTR [ebp-0x18],0x1
				r.lx = cr->lx - cr->cur_x;
     8f3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8f6:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
     8fa:	89 c2                	mov    edx,eax
     8fc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8ff:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     903:	89 c1                	mov    ecx,eax
     905:	89 d0                	mov    eax,edx
     907:	29 c8                	sub    eax,ecx
     909:	66 89 45 e6          	mov    WORD PTR [ebp-0x1a],ax
				cr->cur_x = 0;
     90d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     910:	66 c7 40 0e 00 00    	mov    WORD PTR [eax+0xe],0x0
				if (++cr->cur_y == cr->ly) {
     916:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     919:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     91d:	83 c0 01             	add    eax,0x1
     920:	89 c2                	mov    edx,eax
     922:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     925:	66 89 50 10          	mov    WORD PTR [eax+0x10],dx
     929:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     92c:	0f b7 50 10          	movzx  edx,WORD PTR [eax+0x10]
     930:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     933:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
     937:	66 39 c2             	cmp    dx,ax
     93a:	75 46                	jne    982 <region_putchar+0x12e>
						if (!(cr->flags & KIO_REGION_DEFERED_SCROLL)) {
     93c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     93f:	0f b6 40 0d          	movzx  eax,BYTE PTR [eax+0xd]
     943:	0f be c0             	movsx  eax,al
     946:	83 e0 04             	and    eax,0x4
     949:	85 c0                	test   eax,eax
     94b:	75 35                	jne    982 <region_putchar+0x12e>
								cr->cur_y--;
     94d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     950:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     954:	83 e8 01             	sub    eax,0x1
     957:	89 c2                	mov    edx,eax
     959:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     95c:	66 89 50 10          	mov    WORD PTR [eax+0x10],dx
								if (!(cr->flags & KIO_REGION_NO_SCROLL)) {
     960:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     963:	0f b6 40 0d          	movzx  eax,BYTE PTR [eax+0xd]
     967:	0f be c0             	movsx  eax,al
     96a:	83 e0 02             	and    eax,0x2
     96d:	85 c0                	test   eax,eax
     96f:	75 11                	jne    982 <region_putchar+0x12e>
										scroll_buffer(cr);
     971:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     974:	89 04 24             	mov    DWORD PTR [esp],eax
     977:	e8 fc ff ff ff       	call   978 <region_putchar+0x124>
										i = -1;
     97c:	66 c7 45 f6 ff ff    	mov    WORD PTR [ebp-0xa],0xffff
				if (i != -1)
     982:	66 83 7d f6 ff       	cmp    WORD PTR [ebp-0xa],0xffff
     987:	0f 84 9e 01 00 00    	je     b2b <region_putchar+0x2d7>
						framebuffer_update_region(&fb_initial, &r);
     98d:	8d 45 e2             	lea    eax,[ebp-0x1e]
     990:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     994:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     99b:	e8 fc ff ff ff       	call   99c <region_putchar+0x148>
		if (c == 10 || c == 13) {
     9a0:	e9 86 01 00 00       	jmp    b2b <region_putchar+0x2d7>
		} else if (c == '\t') {
     9a5:	80 7d d4 09          	cmp    BYTE PTR [ebp-0x2c],0x9
     9a9:	0f 85 9a 00 00 00    	jne    a49 <region_putchar+0x1f5>
				if (cr->cur_x == cr->lx)
     9af:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     9b2:	0f b7 50 0e          	movzx  edx,WORD PTR [eax+0xe]
     9b6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     9b9:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
     9bd:	66 39 c2             	cmp    dx,ax
     9c0:	75 13                	jne    9d5 <region_putchar+0x181>
						region_putchar(cr, '\n');
     9c2:	c7 44 24 04 0a 00 00 00 	mov    DWORD PTR [esp+0x4],0xa
     9ca:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     9cd:	89 04 24             	mov    DWORD PTR [esp],eax
     9d0:	e8 fc ff ff ff       	call   9d1 <region_putchar+0x17d>
				for (c = 0; cr->cur_x < cr->lx && c < 4; cr->cur_x++, c++)
     9d5:	c6 45 d4 00          	mov    BYTE PTR [ebp-0x2c],0x0
     9d9:	eb 4c                	jmp    a27 <region_putchar+0x1d3>
						putc_pr(cr, ' ', cr->cur_x, cr->cur_y);
     9db:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     9de:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     9e2:	0f b7 d0             	movzx  edx,ax
     9e5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     9e8:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     9ec:	0f b7 c0             	movzx  eax,ax
     9ef:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
     9f3:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     9f7:	c7 44 24 04 20 00 00 00 	mov    DWORD PTR [esp+0x4],0x20
     9ff:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a02:	89 04 24             	mov    DWORD PTR [esp],eax
     a05:	e8 fc ff ff ff       	call   a06 <region_putchar+0x1b2>
				for (c = 0; cr->cur_x < cr->lx && c < 4; cr->cur_x++, c++)
     a0a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a0d:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     a11:	83 c0 01             	add    eax,0x1
     a14:	89 c2                	mov    edx,eax
     a16:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a19:	66 89 50 0e          	mov    WORD PTR [eax+0xe],dx
     a1d:	0f b6 45 d4          	movzx  eax,BYTE PTR [ebp-0x2c]
     a21:	83 c0 01             	add    eax,0x1
     a24:	88 45 d4             	mov    BYTE PTR [ebp-0x2c],al
     a27:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a2a:	0f b7 50 0e          	movzx  edx,WORD PTR [eax+0xe]
     a2e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a31:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
     a35:	66 39 c2             	cmp    dx,ax
     a38:	0f 8d ee 00 00 00    	jge    b2c <region_putchar+0x2d8>
     a3e:	80 7d d4 03          	cmp    BYTE PTR [ebp-0x2c],0x3
     a42:	7e 97                	jle    9db <region_putchar+0x187>
     a44:	e9 e3 00 00 00       	jmp    b2c <region_putchar+0x2d8>
		} else if (cr->cur_x == cr->lx) {
     a49:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a4c:	0f b7 50 0e          	movzx  edx,WORD PTR [eax+0xe]
     a50:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a53:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
     a57:	66 39 c2             	cmp    dx,ax
     a5a:	75 7b                	jne    ad7 <region_putchar+0x283>
				region_putchar(cr, '\n');
     a5c:	c7 44 24 04 0a 00 00 00 	mov    DWORD PTR [esp+0x4],0xa
     a64:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a67:	89 04 24             	mov    DWORD PTR [esp],eax
     a6a:	e8 fc ff ff ff       	call   a6b <region_putchar+0x217>
				cr->cur_x = 0;
     a6f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a72:	66 c7 40 0e 00 00    	mov    WORD PTR [eax+0xe],0x0
				putc_pr(cr, c, cr->cur_x++, cr->cur_y);
     a78:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a7b:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     a7f:	0f b7 c8             	movzx  ecx,ax
     a82:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a85:	0f b7 50 0e          	movzx  edx,WORD PTR [eax+0xe]
     a89:	89 d0                	mov    eax,edx
     a8b:	83 c0 01             	add    eax,0x1
     a8e:	89 c3                	mov    ebx,eax
     a90:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a93:	66 89 58 0e          	mov    WORD PTR [eax+0xe],bx
     a97:	89 d0                	mov    eax,edx
     a99:	0f b7 d0             	movzx  edx,ax
     a9c:	0f be 45 d4          	movsx  eax,BYTE PTR [ebp-0x2c]
     aa0:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
     aa4:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     aa8:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     aac:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     aaf:	89 04 24             	mov    DWORD PTR [esp],eax
     ab2:	e8 fc ff ff ff       	call   ab3 <region_putchar+0x25f>
     ab7:	eb 73                	jmp    b2c <region_putchar+0x2d8>
						scroll_buffer(cr);
     ab9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     abc:	89 04 24             	mov    DWORD PTR [esp],eax
     abf:	e8 fc ff ff ff       	call   ac0 <region_putchar+0x26c>
						cr->cur_y--;
     ac4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     ac7:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     acb:	83 e8 01             	sub    eax,0x1
     ace:	89 c2                	mov    edx,eax
     ad0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     ad3:	66 89 50 10          	mov    WORD PTR [eax+0x10],dx
				while (cr->cur_y >= cr->ly) {
     ad7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     ada:	0f b7 50 10          	movzx  edx,WORD PTR [eax+0x10]
     ade:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     ae1:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
     ae5:	66 39 c2             	cmp    dx,ax
     ae8:	7d cf                	jge    ab9 <region_putchar+0x265>
				putc_pr(cr, c, cr->cur_x++, cr->cur_y);
     aea:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     aed:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     af1:	0f b7 c8             	movzx  ecx,ax
     af4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     af7:	0f b7 50 0e          	movzx  edx,WORD PTR [eax+0xe]
     afb:	89 d0                	mov    eax,edx
     afd:	83 c0 01             	add    eax,0x1
     b00:	89 c3                	mov    ebx,eax
     b02:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     b05:	66 89 58 0e          	mov    WORD PTR [eax+0xe],bx
     b09:	89 d0                	mov    eax,edx
     b0b:	0f b7 d0             	movzx  edx,ax
     b0e:	0f be 45 d4          	movsx  eax,BYTE PTR [ebp-0x2c]
     b12:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
     b16:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
     b1a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     b1e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     b21:	89 04 24             	mov    DWORD PTR [esp],eax
     b24:	e8 fc ff ff ff       	call   b25 <region_putchar+0x2d1>
     b29:	eb 01                	jmp    b2c <region_putchar+0x2d8>
		if (c == 10 || c == 13) {
     b2b:	90                   	nop
		return c;
     b2c:	0f be 45 d4          	movsx  eax,BYTE PTR [ebp-0x2c]
}
     b30:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     b33:	c9                   	leave
     b34:	c3                   	ret

00000b35 <getchar>:
{
     b35:	55                   	push   ebp
     b36:	89 e5                	mov    ebp,esp
     b38:	83 ec 18             	sub    esp,0x18
		return region_getchar(&reg_def);
     b3b:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     b42:	e8 fc ff ff ff       	call   b43 <getchar+0xe>
}
     b47:	c9                   	leave
     b48:	c3                   	ret

00000b49 <putchar>:
{
     b49:	55                   	push   ebp
     b4a:	89 e5                	mov    ebp,esp
     b4c:	83 ec 28             	sub    esp,0x28
     b4f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     b52:	88 45 f4             	mov    BYTE PTR [ebp-0xc],al
		return region_putchar(&reg_def, c);
     b55:	0f be 45 f4          	movsx  eax,BYTE PTR [ebp-0xc]
     b59:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     b5d:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     b64:	e8 fc ff ff ff       	call   b65 <putchar+0x1c>
}
     b69:	c9                   	leave
     b6a:	c3                   	ret

00000b6b <region_puts>:
{
     b6b:	55                   	push   ebp
     b6c:	89 e5                	mov    ebp,esp
     b6e:	83 ec 18             	sub    esp,0x18
		while(*str)
     b71:	eb 1e                	jmp    b91 <region_puts+0x26>
				region_putchar(cr, *(str++));
     b73:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     b76:	8d 50 01             	lea    edx,[eax+0x1]
     b79:	89 55 0c             	mov    DWORD PTR [ebp+0xc],edx
     b7c:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     b7f:	0f be c0             	movsx  eax,al
     b82:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     b86:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     b89:	89 04 24             	mov    DWORD PTR [esp],eax
     b8c:	e8 fc ff ff ff       	call   b8d <region_puts+0x22>
		while(*str)
     b91:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     b94:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     b97:	84 c0                	test   al,al
     b99:	75 d8                	jne    b73 <region_puts+0x8>
}
     b9b:	90                   	nop
     b9c:	90                   	nop
     b9d:	c9                   	leave
     b9e:	c3                   	ret

00000b9f <puts>:
{
     b9f:	55                   	push   ebp
     ba0:	89 e5                	mov    ebp,esp
     ba2:	83 ec 18             	sub    esp,0x18
		return region_puts(&reg_def, str);
     ba5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     ba8:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
     bac:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
     bb3:	e8 fc ff ff ff       	call   bb4 <puts+0x15>
}
     bb8:	c9                   	leave
     bb9:	c3                   	ret

00000bba <putb>:
{
     bba:	55                   	push   ebp
     bbb:	89 e5                	mov    ebp,esp
     bbd:	83 ec 38             	sub    esp,0x38
     bc0:	8b 4d 10             	mov    ecx,DWORD PTR [ebp+0x10]
     bc3:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
     bc6:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     bc9:	88 4d e4             	mov    BYTE PTR [ebp-0x1c],cl
     bcc:	88 55 e0             	mov    BYTE PTR [ebp-0x20],dl
     bcf:	88 45 dc             	mov    BYTE PTR [ebp-0x24],al
		int i, nonz = 0, rv = 0;
     bd2:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
     bd9:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		for (i = 0; i < 32; i++) {
     be0:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
     be7:	e9 ee 00 00 00       	jmp    cda <putb+0x120>
				unsigned int bt = (arg & 0x80000000);
     bec:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     bef:	25 00 00 00 80       	and    eax,0x80000000
     bf4:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				rv++;
     bf7:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
				if (bt) {
     bfb:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
     bff:	74 22                	je     c23 <putb+0x69>
						nonz = 1;
     c01:	c7 45 f0 01 00 00 00 	mov    DWORD PTR [ebp-0x10],0x1
						ctx->putchar(ctx, '1');
     c08:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c0b:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     c0e:	c7 44 24 04 31 00 00 00 	mov    DWORD PTR [esp+0x4],0x31
     c16:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     c19:	89 14 24             	mov    DWORD PTR [esp],edx
     c1c:	ff d0                	call   eax
     c1e:	e9 b0 00 00 00       	jmp    cd3 <putb+0x119>
				} else if (nonz)
     c23:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     c27:	74 1b                	je     c44 <putb+0x8a>
						ctx->putchar(ctx, '0');
     c29:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c2c:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     c2f:	c7 44 24 04 30 00 00 00 	mov    DWORD PTR [esp+0x4],0x30
     c37:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     c3a:	89 14 24             	mov    DWORD PTR [esp],edx
     c3d:	ff d0                	call   eax
     c3f:	e9 8f 00 00 00       	jmp    cd3 <putb+0x119>
				else if ((32 - i) <= prec) /* has precedence over with */
     c44:	b8 20 00 00 00       	mov    eax,0x20
     c49:	2b 45 f4             	sub    eax,DWORD PTR [ebp-0xc]
     c4c:	89 c2                	mov    edx,eax
     c4e:	0f be 45 dc          	movsx  eax,BYTE PTR [ebp-0x24]
     c52:	39 c2                	cmp    edx,eax
     c54:	7f 18                	jg     c6e <putb+0xb4>
						ctx->putchar(ctx, '0');
     c56:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c59:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     c5c:	c7 44 24 04 30 00 00 00 	mov    DWORD PTR [esp+0x4],0x30
     c64:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     c67:	89 14 24             	mov    DWORD PTR [esp],edx
     c6a:	ff d0                	call   eax
     c6c:	eb 65                	jmp    cd3 <putb+0x119>
				else if ((32 - i) <= width)
     c6e:	b8 20 00 00 00       	mov    eax,0x20
     c73:	2b 45 f4             	sub    eax,DWORD PTR [ebp-0xc]
     c76:	89 c2                	mov    edx,eax
     c78:	0f be 45 e0          	movsx  eax,BYTE PTR [ebp-0x20]
     c7c:	39 c2                	cmp    edx,eax
     c7e:	7f 2b                	jg     cab <putb+0xf1>
						ctx->putchar(ctx, flags & KFL_ZERO_PREFIX ? '0' : ' ');
     c80:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c83:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     c86:	0f be 55 e4          	movsx  edx,BYTE PTR [ebp-0x1c]
     c8a:	83 e2 02             	and    edx,0x2
     c8d:	85 d2                	test   edx,edx
     c8f:	74 07                	je     c98 <putb+0xde>
     c91:	ba 30 00 00 00       	mov    edx,0x30
     c96:	eb 05                	jmp    c9d <putb+0xe3>
     c98:	ba 20 00 00 00       	mov    edx,0x20
     c9d:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     ca1:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     ca4:	89 14 24             	mov    DWORD PTR [esp],edx
     ca7:	ff d0                	call   eax
     ca9:	eb 28                	jmp    cd3 <putb+0x119>
				else if (i == 31 && prec >= 0) /* only print 0 for nonneg prec */
     cab:	83 7d f4 1f          	cmp    DWORD PTR [ebp-0xc],0x1f
     caf:	75 1e                	jne    ccf <putb+0x115>
     cb1:	80 7d dc 00          	cmp    BYTE PTR [ebp-0x24],0x0
     cb5:	78 18                	js     ccf <putb+0x115>
						ctx->putchar(ctx, '0');
     cb7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     cba:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     cbd:	c7 44 24 04 30 00 00 00 	mov    DWORD PTR [esp+0x4],0x30
     cc5:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     cc8:	89 14 24             	mov    DWORD PTR [esp],edx
     ccb:	ff d0                	call   eax
     ccd:	eb 04                	jmp    cd3 <putb+0x119>
						rv--;
     ccf:	83 6d ec 01          	sub    DWORD PTR [ebp-0x14],0x1
				arg <<= 1;
     cd3:	d1 65 0c             	shl    DWORD PTR [ebp+0xc],1
		for (i = 0; i < 32; i++) {
     cd6:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     cda:	83 7d f4 1f          	cmp    DWORD PTR [ebp-0xc],0x1f
     cde:	0f 8e 08 ff ff ff    	jle    bec <putb+0x32>
		}
		return rv;
     ce4:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
}
     ce7:	c9                   	leave
     ce8:	c3                   	ret

00000ce9 <putu64>:

int putu64(struct ivp_ctx* ctx, unsigned long long int arg, char flags)
{
     ce9:	55                   	push   ebp
     cea:	89 e5                	mov    ebp,esp
     cec:	53                   	push   ebx
     ced:	83 ec 74             	sub    esp,0x74
     cf0:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
     cf3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     cf6:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
     cf9:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     cfc:	89 45 a4             	mov    DWORD PTR [ebp-0x5c],eax
     cff:	89 d0                	mov    eax,edx
     d01:	88 45 9c             	mov    BYTE PTR [ebp-0x64],al
		int rv = 0, i, nonz = 0;
     d04:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
     d0b:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		if (flags & KFL_IS_HEX) {
     d12:	0f be 45 9c          	movsx  eax,BYTE PTR [ebp-0x64]
     d16:	83 e0 01             	and    eax,0x1
     d19:	85 c0                	test   eax,eax
     d1b:	0f 84 2f 01 00 00    	je     e50 <putu64+0x167>
				for (i = 0; i < 16; i++) {
     d21:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
     d28:	e9 14 01 00 00       	jmp    e41 <putu64+0x158>
						unsigned long long int hf = (arg & 0xf000000000000000);
     d2d:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
     d30:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
     d33:	b8 00 00 00 00       	mov    eax,0x0
     d38:	81 e2 00 00 00 f0    	and    edx,0xf0000000
     d3e:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
     d41:	89 55 bc             	mov    DWORD PTR [ebp-0x44],edx
						char hc = (flags & KFL_CAPITAL) ? CHEXCHAR(hf >> 60) : HEXCHAR(hf >> 60);
     d44:	80 7d 9c 00          	cmp    BYTE PTR [ebp-0x64],0x0
     d48:	79 41                	jns    d8b <putu64+0xa2>
     d4a:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
     d4d:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
     d50:	89 d0                	mov    eax,edx
     d52:	31 d2                	xor    edx,edx
     d54:	c1 e8 1c             	shr    eax,0x1c
     d57:	bb 09 00 00 00       	mov    ebx,0x9
     d5c:	b9 00 00 00 00       	mov    ecx,0x0
     d61:	39 c3                	cmp    ebx,eax
     d63:	19 d1                	sbb    ecx,edx
     d65:	72 12                	jb     d79 <putu64+0x90>
     d67:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
     d6a:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
     d6d:	89 d0                	mov    eax,edx
     d6f:	31 d2                	xor    edx,edx
     d71:	c1 e8 1c             	shr    eax,0x1c
     d74:	83 c0 30             	add    eax,0x30
     d77:	eb 51                	jmp    dca <putu64+0xe1>
     d79:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
     d7c:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
     d7f:	89 d0                	mov    eax,edx
     d81:	31 d2                	xor    edx,edx
     d83:	c1 e8 1c             	shr    eax,0x1c
     d86:	83 c0 37             	add    eax,0x37
     d89:	eb 3f                	jmp    dca <putu64+0xe1>
     d8b:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
     d8e:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
     d91:	89 d0                	mov    eax,edx
     d93:	31 d2                	xor    edx,edx
     d95:	c1 e8 1c             	shr    eax,0x1c
     d98:	bb 09 00 00 00       	mov    ebx,0x9
     d9d:	b9 00 00 00 00       	mov    ecx,0x0
     da2:	39 c3                	cmp    ebx,eax
     da4:	19 d1                	sbb    ecx,edx
     da6:	72 12                	jb     dba <putu64+0xd1>
     da8:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
     dab:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
     dae:	89 d0                	mov    eax,edx
     db0:	31 d2                	xor    edx,edx
     db2:	c1 e8 1c             	shr    eax,0x1c
     db5:	83 c0 30             	add    eax,0x30
     db8:	eb 10                	jmp    dca <putu64+0xe1>
     dba:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
     dbd:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
     dc0:	89 d0                	mov    eax,edx
     dc2:	31 d2                	xor    edx,edx
     dc4:	c1 e8 1c             	shr    eax,0x1c
     dc7:	83 c0 57             	add    eax,0x57
     dca:	88 45 b7             	mov    BYTE PTR [ebp-0x49],al
						rv++;
     dcd:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
						if (hc != '0') {
     dd1:	80 7d b7 30          	cmp    BYTE PTR [ebp-0x49],0x30
     dd5:	74 25                	je     dfc <putu64+0x113>
								nonz = 1;
     dd7:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [ebp-0x14],0x1
								if (ctx) ctx->putchar(ctx, hc);
     dde:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     de2:	74 46                	je     e2a <putu64+0x141>
     de4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     de7:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     dea:	0f be 55 b7          	movsx  edx,BYTE PTR [ebp-0x49]
     dee:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     df2:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     df5:	89 14 24             	mov    DWORD PTR [esp],edx
     df8:	ff d0                	call   eax
     dfa:	eb 2e                	jmp    e2a <putu64+0x141>
						} else if (nonz || i == 15) {
     dfc:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     e00:	75 06                	jne    e08 <putu64+0x11f>
     e02:	83 7d f0 0f          	cmp    DWORD PTR [ebp-0x10],0xf
     e06:	75 1e                	jne    e26 <putu64+0x13d>
								if (ctx) ctx->putchar(ctx, '0');
     e08:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     e0c:	74 1c                	je     e2a <putu64+0x141>
     e0e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     e11:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     e14:	c7 44 24 04 30 00 00 00 	mov    DWORD PTR [esp+0x4],0x30
     e1c:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     e1f:	89 14 24             	mov    DWORD PTR [esp],edx
     e22:	ff d0                	call   eax
     e24:	eb 04                	jmp    e2a <putu64+0x141>
						} else
								rv--;
     e26:	83 6d f4 01          	sub    DWORD PTR [ebp-0xc],0x1
						arg <<= 4;
     e2a:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
     e2d:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
     e30:	0f a4 c2 04          	shld   edx,eax,0x4
     e34:	c1 e0 04             	shl    eax,0x4
     e37:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
     e3a:	89 55 a4             	mov    DWORD PTR [ebp-0x5c],edx
				for (i = 0; i < 16; i++) {
     e3d:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
     e41:	83 7d f0 0f          	cmp    DWORD PTR [ebp-0x10],0xf
     e45:	0f 8e e2 fe ff ff    	jle    d2d <putu64+0x44>
     e4b:	e9 02 02 00 00       	jmp    1052 <putu64+0x369>
				}
		} else if (flags & KFL_IS_OCT) {
     e50:	0f be 45 9c          	movsx  eax,BYTE PTR [ebp-0x64]
     e54:	83 e0 40             	and    eax,0x40
     e57:	85 c0                	test   eax,eax
     e59:	0f 84 ea 00 00 00    	je     f49 <putu64+0x260>
				/* process first bit */
				if (arg & (1ull << 63)) {
     e5f:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
     e62:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
     e65:	85 d2                	test   edx,edx
     e67:	79 27                	jns    e90 <putu64+0x1a7>
						rv++; nonz = 1;
     e69:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     e6d:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [ebp-0x14],0x1
						if (ctx) ctx->putchar(ctx, '1');
     e74:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     e78:	74 16                	je     e90 <putu64+0x1a7>
     e7a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     e7d:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     e80:	c7 44 24 04 31 00 00 00 	mov    DWORD PTR [esp+0x4],0x31
     e88:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     e8b:	89 14 24             	mov    DWORD PTR [esp],edx
     e8e:	ff d0                	call   eax
				}
				for (i = 0; i < 21; i++) {
     e90:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
     e97:	e9 9e 00 00 00       	jmp    f3a <putu64+0x251>
						unsigned long long int of = (arg & 0700000000000000000000);
     e9c:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
     e9f:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
     ea2:	b8 00 00 00 00       	mov    eax,0x0
     ea7:	81 e2 00 00 00 70    	and    edx,0x70000000
     ead:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
     eb0:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
						char oc = '0' + (char)(of >> 60);
     eb3:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
     eb6:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
     eb9:	89 d0                	mov    eax,edx
     ebb:	31 d2                	xor    edx,edx
     ebd:	c1 e8 1c             	shr    eax,0x1c
     ec0:	83 c0 30             	add    eax,0x30
     ec3:	88 45 c7             	mov    BYTE PTR [ebp-0x39],al
						rv++;
     ec6:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
						if (oc != '0') {
     eca:	80 7d c7 30          	cmp    BYTE PTR [ebp-0x39],0x30
     ece:	74 25                	je     ef5 <putu64+0x20c>
								nonz = 1;
     ed0:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [ebp-0x14],0x1
								if (ctx) ctx->putchar(ctx, oc);
     ed7:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     edb:	74 46                	je     f23 <putu64+0x23a>
     edd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     ee0:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     ee3:	0f be 55 c7          	movsx  edx,BYTE PTR [ebp-0x39]
     ee7:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     eeb:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     eee:	89 14 24             	mov    DWORD PTR [esp],edx
     ef1:	ff d0                	call   eax
     ef3:	eb 2e                	jmp    f23 <putu64+0x23a>
						} else if (nonz || i == 20) {
     ef5:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     ef9:	75 06                	jne    f01 <putu64+0x218>
     efb:	83 7d f0 14          	cmp    DWORD PTR [ebp-0x10],0x14
     eff:	75 1e                	jne    f1f <putu64+0x236>
								if (ctx) ctx->putchar(ctx, '0');
     f01:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     f05:	74 1c                	je     f23 <putu64+0x23a>
     f07:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     f0a:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     f0d:	c7 44 24 04 30 00 00 00 	mov    DWORD PTR [esp+0x4],0x30
     f15:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     f18:	89 14 24             	mov    DWORD PTR [esp],edx
     f1b:	ff d0                	call   eax
     f1d:	eb 04                	jmp    f23 <putu64+0x23a>
						} else
								rv--;
     f1f:	83 6d f4 01          	sub    DWORD PTR [ebp-0xc],0x1
						arg <<= 3;
     f23:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
     f26:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
     f29:	0f a4 c2 03          	shld   edx,eax,0x3
     f2d:	c1 e0 03             	shl    eax,0x3
     f30:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
     f33:	89 55 a4             	mov    DWORD PTR [ebp-0x5c],edx
				for (i = 0; i < 21; i++) {
     f36:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
     f3a:	83 7d f0 14          	cmp    DWORD PTR [ebp-0x10],0x14
     f3e:	0f 8e 58 ff ff ff    	jle    e9c <putu64+0x1b3>
     f44:	e9 09 01 00 00       	jmp    1052 <putu64+0x369>
				}
		} else {
				unsigned long long int div = 1000000000000000000;
     f49:	c7 45 e0 00 00 64 a7 	mov    DWORD PTR [ebp-0x20],0xa7640000
     f50:	c7 45 e4 b3 b6 e0 0d 	mov    DWORD PTR [ebp-0x1c],0xde0b6b3
				unsigned long long int res; char frst = 0;
     f57:	c6 45 df 00          	mov    BYTE PTR [ebp-0x21],0x0
				i = 0;
     f5b:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
				while (div) {
     f62:	e9 d9 00 00 00       	jmp    1040 <putu64+0x357>
					res = arg / div;
     f67:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     f6a:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
     f6d:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
     f71:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
     f75:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
     f78:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
     f7b:	89 04 24             	mov    DWORD PTR [esp],eax
     f7e:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     f82:	e8 fc ff ff ff       	call   f83 <putu64+0x29a>
     f87:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
     f8a:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
					arg %= div; rv++;
     f8d:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
     f90:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
     f93:	8b 4d e0             	mov    ecx,DWORD PTR [ebp-0x20]
     f96:	8b 5d e4             	mov    ebx,DWORD PTR [ebp-0x1c]
     f99:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
     f9d:	89 5c 24 0c          	mov    DWORD PTR [esp+0xc],ebx
     fa1:	89 04 24             	mov    DWORD PTR [esp],eax
     fa4:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     fa8:	e8 fc ff ff ff       	call   fa9 <putu64+0x2c0>
     fad:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
     fb0:	89 55 a4             	mov    DWORD PTR [ebp-0x5c],edx
     fb3:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
					if (res || frst) {
     fb7:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     fba:	0b 45 d4             	or     eax,DWORD PTR [ebp-0x2c]
     fbd:	75 06                	jne    fc5 <putu64+0x2dc>
     fbf:	80 7d df 00          	cmp    BYTE PTR [ebp-0x21],0x0
     fc3:	74 27                	je     fec <putu64+0x303>
						if (ctx) ctx->putchar(ctx, '0' + (char)res);
     fc5:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     fc9:	74 1b                	je     fe6 <putu64+0x2fd>
     fcb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     fce:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     fd1:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
     fd4:	83 c2 30             	add    edx,0x30
     fd7:	0f be d2             	movsx  edx,dl
     fda:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
     fde:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
     fe1:	89 14 24             	mov    DWORD PTR [esp],edx
     fe4:	ff d0                	call   eax
						frst = 1;
     fe6:	c6 45 df 01          	mov    BYTE PTR [ebp-0x21],0x1
     fea:	eb 28                	jmp    1014 <putu64+0x32b>
					} else if (i == 18) {
     fec:	83 7d f0 12          	cmp    DWORD PTR [ebp-0x10],0x12
     ff0:	75 1e                	jne    1010 <putu64+0x327>
							if (ctx) ctx->putchar(ctx, '0');
     ff2:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     ff6:	74 1c                	je     1014 <putu64+0x32b>
     ff8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     ffb:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     ffe:	c7 44 24 04 30 00 00 00 	mov    DWORD PTR [esp+0x4],0x30
    1006:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    1009:	89 14 24             	mov    DWORD PTR [esp],edx
    100c:	ff d0                	call   eax
    100e:	eb 04                	jmp    1014 <putu64+0x32b>
					} else
							rv--;
    1010:	83 6d f4 01          	sub    DWORD PTR [ebp-0xc],0x1
					div /= 10;
    1014:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1017:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    101a:	c7 44 24 08 0a 00 00 00 	mov    DWORD PTR [esp+0x8],0xa
    1022:	c7 44 24 0c 00 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    102a:	89 04 24             	mov    DWORD PTR [esp],eax
    102d:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1031:	e8 fc ff ff ff       	call   1032 <putu64+0x349>
    1036:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1039:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
					i++;
    103c:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
				while (div) {
    1040:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1043:	0b 45 e4             	or     eax,DWORD PTR [ebp-0x1c]
    1046:	0f 85 1b ff ff ff    	jne    f67 <putu64+0x27e>
				}
				i = rv;
    104c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    104f:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		}
		return rv;
    1052:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    1055:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    1058:	c9                   	leave
    1059:	c3                   	ret

0000105a <usermode_entry>:

void usermode_entry()
{
    105a:	55                   	push   ebp
    105b:	89 e5                	mov    ebp,esp
    105d:	83 ec 28             	sub    esp,0x28
		int val = 4;
    1060:	c7 45 f4 04 00 00 00 	mov    DWORD PTR [ebp-0xc],0x4
		printf("The adress of the stack is around %p\n", &val);
    1067:	8d 45 f4             	lea    eax,[ebp-0xc]
    106a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    106e:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1075:	e8 fc ff ff ff       	call   1076 <usermode_entry+0x1c>
		printf("which is set within the kernel stack\n");
    107a:	c7 04 24 28 00 00 00 	mov    DWORD PTR [esp],0x28
    1081:	e8 fc ff ff ff       	call   1082 <usermode_entry+0x28>
		while (1);
    1086:	90                   	nop
    1087:	eb fd                	jmp    1086 <usermode_entry+0x2c>

00001089 <fun>:

}

void fun()
{
    1089:	55                   	push   ebp
    108a:	89 e5                	mov    ebp,esp
		/* float test etc. */
		extern void to_usermode();
		/*to_usermode();*/
}
    108c:	90                   	nop
    108d:	5d                   	pop    ebp
    108e:	c3                   	ret

0000108f <putu>:
 * tz localtime usw.
 * thread list & lock registry
__thread int iv = 0; <- drepper TLS article LDO, LE, LI
iv = 5; */
int putu(struct ivp_ctx* ctx, unsigned long long int arg, char flags, char width, char prec)
{
    108f:	55                   	push   ebp
    1090:	89 e5                	mov    ebp,esp
    1092:	53                   	push   ebx
    1093:	83 ec 54             	sub    esp,0x54
    1096:	8b 5d 14             	mov    ebx,DWORD PTR [ebp+0x14]
    1099:	8b 4d 18             	mov    ecx,DWORD PTR [ebp+0x18]
    109c:	8b 55 1c             	mov    edx,DWORD PTR [ebp+0x1c]
    109f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    10a2:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
    10a5:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    10a8:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
    10ab:	89 d8                	mov    eax,ebx
    10ad:	88 45 cc             	mov    BYTE PTR [ebp-0x34],al
    10b0:	89 c8                	mov    eax,ecx
    10b2:	88 45 c8             	mov    BYTE PTR [ebp-0x38],al
    10b5:	89 d0                	mov    eax,edx
    10b7:	88 45 c4             	mov    BYTE PTR [ebp-0x3c],al
		int len, rv = 0;
    10ba:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		int ns = 0, nz = 0, neg = ((flags & KFL_IS_NEG) == KFL_IS_NEG), zero = 0;
    10c1:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    10c8:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
    10cf:	0f be 45 cc          	movsx  eax,BYTE PTR [ebp-0x34]
    10d3:	25 c0 00 00 00       	and    eax,0xc0
    10d8:	3d c0 00 00 00       	cmp    eax,0xc0
    10dd:	0f 94 c0             	sete   al
    10e0:	0f b6 c0             	movzx  eax,al
    10e3:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    10e6:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
		if (neg/* && (flags & KFL_IS_HEX)*/)
    10ed:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    10f1:	74 04                	je     10f7 <putu+0x68>
				flags &= ~KFL_IS_OCT;
    10f3:	80 65 cc bf          	and    BYTE PTR [ebp-0x34],0xbf
		/* calc len */
		len = putu64(NULL, arg, flags);
    10f7:	0f be 45 cc          	movsx  eax,BYTE PTR [ebp-0x34]
    10fb:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    10ff:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1102:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    1105:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1109:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    110d:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    1114:	e8 fc ff ff ff       	call   1115 <putu+0x86>
    1119:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		/* print at least width characters with prec digits */
		if (neg || (flags & (KFL_ALWAYS_SIGN | KFL_SPACE_PLUS)))
    111c:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    1120:	75 0b                	jne    112d <putu+0x9e>
    1122:	0f be 45 cc          	movsx  eax,BYTE PTR [ebp-0x34]
    1126:	83 e0 24             	and    eax,0x24
    1129:	85 c0                	test   eax,eax
    112b:	74 04                	je     1131 <putu+0xa2>
				rv++; /* one sign character */
    112d:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
		rv += len;
    1131:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1134:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
		if ((prec == -1) && !arg) {/* omit zero and sign, honor width */
    1137:	80 7d c4 ff          	cmp    BYTE PTR [ebp-0x3c],0xff
    113b:	75 18                	jne    1155 <putu+0xc6>
    113d:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1140:	0b 45 d4             	or     eax,DWORD PTR [ebp-0x2c]
    1143:	75 10                	jne    1155 <putu+0xc6>
				rv = 0;
    1145:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
				zero = 1;
    114c:	c7 45 e8 01 00 00 00 	mov    DWORD PTR [ebp-0x18],0x1
    1153:	eb 2b                	jmp    1180 <putu+0xf1>
		}
		else if (flags & KFL_TYPE_PREFIX) {/* print type prefix (if printing 0) */
    1155:	0f be 45 cc          	movsx  eax,BYTE PTR [ebp-0x34]
    1159:	83 e0 10             	and    eax,0x10
    115c:	85 c0                	test   eax,eax
    115e:	74 20                	je     1180 <putu+0xf1>
				if (flags & KFL_IS_HEX)
    1160:	0f be 45 cc          	movsx  eax,BYTE PTR [ebp-0x34]
    1164:	83 e0 01             	and    eax,0x1
    1167:	85 c0                	test   eax,eax
    1169:	74 06                	je     1171 <putu+0xe2>
						rv += 2;
    116b:	83 45 f4 02          	add    DWORD PTR [ebp-0xc],0x2
    116f:	eb 0f                	jmp    1180 <putu+0xf1>
				else if (flags & KFL_IS_OCT)
    1171:	0f be 45 cc          	movsx  eax,BYTE PTR [ebp-0x34]
    1175:	83 e0 40             	and    eax,0x40
    1178:	85 c0                	test   eax,eax
    117a:	74 04                	je     1180 <putu+0xf1>
						rv++;
    117c:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
		}
		/* get nz and ns to match width & prec */
		if (flags & KFL_ZERO_PREFIX) {
    1180:	0f be 45 cc          	movsx  eax,BYTE PTR [ebp-0x34]
    1184:	83 e0 02             	and    eax,0x2
    1187:	85 c0                	test   eax,eax
    1189:	74 22                	je     11ad <putu+0x11e>
				nz = max(width - rv, prec);
    118b:	0f be 55 c4          	movsx  edx,BYTE PTR [ebp-0x3c]
    118f:	0f be 45 c8          	movsx  eax,BYTE PTR [ebp-0x38]
    1193:	2b 45 f4             	sub    eax,DWORD PTR [ebp-0xc]
    1196:	39 c2                	cmp    edx,eax
    1198:	0f 4d c2             	cmovge eax,edx
    119b:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				if (nz < 0)
    119e:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    11a2:	79 46                	jns    11ea <putu+0x15b>
						nz = 0;
    11a4:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
    11ab:	eb 3d                	jmp    11ea <putu+0x15b>
		} else {
				if (prec > 0)
    11ad:	80 7d c4 00          	cmp    BYTE PTR [ebp-0x3c],0x0
    11b1:	7e 0a                	jle    11bd <putu+0x12e>
						nz = prec - len;
    11b3:	0f be 45 c4          	movsx  eax,BYTE PTR [ebp-0x3c]
    11b7:	2b 45 e0             	sub    eax,DWORD PTR [ebp-0x20]
    11ba:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				if (nz < 0)
    11bd:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    11c1:	79 07                	jns    11ca <putu+0x13b>
						nz = 0;
    11c3:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
				if (width)
    11ca:	80 7d c8 00          	cmp    BYTE PTR [ebp-0x38],0x0
    11ce:	74 0d                	je     11dd <putu+0x14e>
						ns = width - rv - nz;
    11d0:	0f be 45 c8          	movsx  eax,BYTE PTR [ebp-0x38]
    11d4:	2b 45 f4             	sub    eax,DWORD PTR [ebp-0xc]
    11d7:	2b 45 ec             	sub    eax,DWORD PTR [ebp-0x14]
    11da:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				if (ns < 0)
    11dd:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    11e1:	79 07                	jns    11ea <putu+0x15b>
						ns = 0;
    11e3:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
		}
		rv += nz + ns;
    11ea:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    11ed:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    11f0:	01 d0                	add    eax,edx
    11f2:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
		/* now print and start with padding */
		if (flags & KFL_LEFT_ALIGN)
    11f5:	0f be 45 cc          	movsx  eax,BYTE PTR [ebp-0x34]
    11f9:	83 e0 08             	and    eax,0x8
    11fc:	85 c0                	test   eax,eax
    11fe:	74 25                	je     1225 <putu+0x196>
				while (ns--)
    1200:	eb 16                	jmp    1218 <putu+0x189>
						ctx->putchar(ctx, ' ');
    1202:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1205:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1208:	c7 44 24 04 20 00 00 00 	mov    DWORD PTR [esp+0x4],0x20
    1210:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    1213:	89 14 24             	mov    DWORD PTR [esp],edx
    1216:	ff d0                	call   eax
				while (ns--)
    1218:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    121b:	8d 50 ff             	lea    edx,[eax-0x1]
    121e:	89 55 f0             	mov    DWORD PTR [ebp-0x10],edx
    1221:	85 c0                	test   eax,eax
    1223:	75 dd                	jne    1202 <putu+0x173>
		/* now the sign */
		if (neg)
    1225:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    1229:	74 18                	je     1243 <putu+0x1b4>
				ctx->putchar(ctx, '-');
    122b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    122e:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1231:	c7 44 24 04 2d 00 00 00 	mov    DWORD PTR [esp+0x4],0x2d
    1239:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    123c:	89 14 24             	mov    DWORD PTR [esp],edx
    123f:	ff d0                	call   eax
    1241:	eb 50                	jmp    1293 <putu+0x204>
		else if (flags & KFL_ALWAYS_SIGN && !zero)
    1243:	0f be 45 cc          	movsx  eax,BYTE PTR [ebp-0x34]
    1247:	83 e0 04             	and    eax,0x4
    124a:	85 c0                	test   eax,eax
    124c:	74 1e                	je     126c <putu+0x1dd>
    124e:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    1252:	75 18                	jne    126c <putu+0x1dd>
				ctx->putchar(ctx, '+');
    1254:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1257:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    125a:	c7 44 24 04 2b 00 00 00 	mov    DWORD PTR [esp+0x4],0x2b
    1262:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    1265:	89 14 24             	mov    DWORD PTR [esp],edx
    1268:	ff d0                	call   eax
    126a:	eb 27                	jmp    1293 <putu+0x204>
		else if (flags & KFL_SPACE_PLUS && !zero)
    126c:	0f be 45 cc          	movsx  eax,BYTE PTR [ebp-0x34]
    1270:	83 e0 20             	and    eax,0x20
    1273:	85 c0                	test   eax,eax
    1275:	74 1c                	je     1293 <putu+0x204>
    1277:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    127b:	75 16                	jne    1293 <putu+0x204>
				ctx->putchar(ctx, ' ');
    127d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1280:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1283:	c7 44 24 04 20 00 00 00 	mov    DWORD PTR [esp+0x4],0x20
    128b:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    128e:	89 14 24             	mov    DWORD PTR [esp],edx
    1291:	ff d0                	call   eax
		/* now the type prefix */
		if ((flags & KFL_TYPE_PREFIX) && !zero) {
    1293:	0f be 45 cc          	movsx  eax,BYTE PTR [ebp-0x34]
    1297:	83 e0 10             	and    eax,0x10
    129a:	85 c0                	test   eax,eax
    129c:	0f 84 9a 00 00 00    	je     133c <putu+0x2ad>
    12a2:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    12a6:	0f 85 90 00 00 00    	jne    133c <putu+0x2ad>
				if (flags & KFL_IS_HEX) {
    12ac:	0f be 45 cc          	movsx  eax,BYTE PTR [ebp-0x34]
    12b0:	83 e0 01             	and    eax,0x1
    12b3:	85 c0                	test   eax,eax
    12b5:	74 4c                	je     1303 <putu+0x274>
						ctx->putchar(ctx, '0');
    12b7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    12ba:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    12bd:	c7 44 24 04 30 00 00 00 	mov    DWORD PTR [esp+0x4],0x30
    12c5:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    12c8:	89 14 24             	mov    DWORD PTR [esp],edx
    12cb:	ff d0                	call   eax
						if (flags & KFL_CAPITAL)
    12cd:	80 7d cc 00          	cmp    BYTE PTR [ebp-0x34],0x0
    12d1:	79 18                	jns    12eb <putu+0x25c>
								ctx->putchar(ctx, 'X');
    12d3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    12d6:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    12d9:	c7 44 24 04 58 00 00 00 	mov    DWORD PTR [esp+0x4],0x58
    12e1:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    12e4:	89 14 24             	mov    DWORD PTR [esp],edx
    12e7:	ff d0                	call   eax
    12e9:	eb 51                	jmp    133c <putu+0x2ad>
						else
								ctx->putchar(ctx, 'x');
    12eb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    12ee:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    12f1:	c7 44 24 04 78 00 00 00 	mov    DWORD PTR [esp+0x4],0x78
    12f9:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    12fc:	89 14 24             	mov    DWORD PTR [esp],edx
    12ff:	ff d0                	call   eax
    1301:	eb 39                	jmp    133c <putu+0x2ad>
				} else if (flags & KFL_IS_OCT)
    1303:	0f be 45 cc          	movsx  eax,BYTE PTR [ebp-0x34]
    1307:	83 e0 40             	and    eax,0x40
    130a:	85 c0                	test   eax,eax
    130c:	74 2e                	je     133c <putu+0x2ad>
						ctx->putchar(ctx, '0');
    130e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1311:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1314:	c7 44 24 04 30 00 00 00 	mov    DWORD PTR [esp+0x4],0x30
    131c:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    131f:	89 14 24             	mov    DWORD PTR [esp],edx
    1322:	ff d0                	call   eax
		}
		/* print the zero padding */
		while (nz--)
    1324:	eb 16                	jmp    133c <putu+0x2ad>
				ctx->putchar(ctx, '0');
    1326:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1329:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    132c:	c7 44 24 04 30 00 00 00 	mov    DWORD PTR [esp+0x4],0x30
    1334:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    1337:	89 14 24             	mov    DWORD PTR [esp],edx
    133a:	ff d0                	call   eax
		while (nz--)
    133c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    133f:	8d 50 ff             	lea    edx,[eax-0x1]
    1342:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
    1345:	85 c0                	test   eax,eax
    1347:	75 dd                	jne    1326 <putu+0x297>
		/* now emit the digits */
		if (!zero)
    1349:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    134d:	75 39                	jne    1388 <putu+0x2f9>
				putu64(ctx, arg, flags);
    134f:	0f be 45 cc          	movsx  eax,BYTE PTR [ebp-0x34]
    1353:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    1357:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    135a:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    135d:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1361:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    1365:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1368:	89 04 24             	mov    DWORD PTR [esp],eax
    136b:	e8 fc ff ff ff       	call   136c <putu+0x2dd>
		/* and the padding */
		while (ns-- > 0)
    1370:	eb 16                	jmp    1388 <putu+0x2f9>
				ctx->putchar(ctx, ' ');
    1372:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1375:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1378:	c7 44 24 04 20 00 00 00 	mov    DWORD PTR [esp+0x4],0x20
    1380:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    1383:	89 14 24             	mov    DWORD PTR [esp],edx
    1386:	ff d0                	call   eax
		while (ns-- > 0)
    1388:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    138b:	8d 50 ff             	lea    edx,[eax-0x1]
    138e:	89 55 f0             	mov    DWORD PTR [ebp-0x10],edx
    1391:	85 c0                	test   eax,eax
    1393:	7f dd                	jg     1372 <putu+0x2e3>
		return rv;
    1395:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    1398:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    139b:	c9                   	leave
    139c:	c3                   	ret

0000139d <putmin>:

int putmin(struct ivp_ctx* ctx, char flags, char width, char prec)
{
    139d:	55                   	push   ebp
    139e:	89 e5                	mov    ebp,esp
    13a0:	83 ec 58             	sub    esp,0x58
    13a3:	8b 4d 0c             	mov    ecx,DWORD PTR [ebp+0xc]
    13a6:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
    13a9:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    13ac:	88 4d c4             	mov    BYTE PTR [ebp-0x3c],cl
    13af:	88 55 c0             	mov    BYTE PTR [ebp-0x40],dl
    13b2:	88 45 bc             	mov    BYTE PTR [ebp-0x44],al
		const char* str_min[] =
    13b5:	c7 45 d4 4e 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x4e
    13bc:	c7 45 d8 5f 00 00 00 	mov    DWORD PTR [ebp-0x28],0x5f
    13c3:	c7 45 dc 76 00 00 00 	mov    DWORD PTR [ebp-0x24],0x76
		{
				/*"-8000", "-80000000",*/ "8000000000000000", /* hex */
				/*"-100000", "-20000000000",*/ "1000000000000000000000", /* oct*/
				/*"-32768", "-2147483648",*/ "9223372036854775808" /* dec */
		};
		int rv = 0, nz = 0, ns = 0, len;
    13ca:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    13d1:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    13d8:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		const char* str = ((flags & KFL_IS_HEX) ? str_min[0] : ((flags & KFL_IS_OCT) ? str_min[1] : str_min[2]));
    13df:	0f be 45 c4          	movsx  eax,BYTE PTR [ebp-0x3c]
    13e3:	83 e0 01             	and    eax,0x1
    13e6:	85 c0                	test   eax,eax
    13e8:	74 05                	je     13ef <putmin+0x52>
    13ea:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    13ed:	eb 13                	jmp    1402 <putmin+0x65>
    13ef:	0f be 45 c4          	movsx  eax,BYTE PTR [ebp-0x3c]
    13f3:	83 e0 40             	and    eax,0x40
    13f6:	85 c0                	test   eax,eax
    13f8:	74 05                	je     13ff <putmin+0x62>
    13fa:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    13fd:	eb 03                	jmp    1402 <putmin+0x65>
    13ff:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    1402:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		len = strlen(str);
    1405:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    1408:	89 04 24             	mov    DWORD PTR [esp],eax
    140b:	e8 fc ff ff ff       	call   140c <putmin+0x6f>
    1410:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		rv = len + 1;
    1413:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1416:	83 c0 01             	add    eax,0x1
    1419:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (flags & KFL_TYPE_PREFIX) {
    141c:	0f be 45 c4          	movsx  eax,BYTE PTR [ebp-0x3c]
    1420:	83 e0 10             	and    eax,0x10
    1423:	85 c0                	test   eax,eax
    1425:	74 20                	je     1447 <putmin+0xaa>
				if (flags & KFL_IS_HEX)
    1427:	0f be 45 c4          	movsx  eax,BYTE PTR [ebp-0x3c]
    142b:	83 e0 01             	and    eax,0x1
    142e:	85 c0                	test   eax,eax
    1430:	74 06                	je     1438 <putmin+0x9b>
						rv += 2;
    1432:	83 45 f4 02          	add    DWORD PTR [ebp-0xc],0x2
    1436:	eb 0f                	jmp    1447 <putmin+0xaa>
				else if (flags & KFL_IS_OCT)
    1438:	0f be 45 c4          	movsx  eax,BYTE PTR [ebp-0x3c]
    143c:	83 e0 40             	and    eax,0x40
    143f:	85 c0                	test   eax,eax
    1441:	74 04                	je     1447 <putmin+0xaa>
						rv += 1;
    1443:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
		}
		/* calculate the spacing */
		if (flags & KFL_ZERO_PREFIX) {
    1447:	0f be 45 c4          	movsx  eax,BYTE PTR [ebp-0x3c]
    144b:	83 e0 02             	and    eax,0x2
    144e:	85 c0                	test   eax,eax
    1450:	74 22                	je     1474 <putmin+0xd7>
				nz = max(width - rv, prec);
    1452:	0f be 55 bc          	movsx  edx,BYTE PTR [ebp-0x44]
    1456:	0f be 45 c0          	movsx  eax,BYTE PTR [ebp-0x40]
    145a:	2b 45 f4             	sub    eax,DWORD PTR [ebp-0xc]
    145d:	39 c2                	cmp    edx,eax
    145f:	0f 4d c2             	cmovge eax,edx
    1462:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				if (nz < 0)
    1465:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    1469:	79 46                	jns    14b1 <putmin+0x114>
						nz = 0;
    146b:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    1472:	eb 3d                	jmp    14b1 <putmin+0x114>
		} else {
				if (prec > 0)
    1474:	80 7d bc 00          	cmp    BYTE PTR [ebp-0x44],0x0
    1478:	7e 0a                	jle    1484 <putmin+0xe7>
						nz = prec - len;
    147a:	0f be 45 bc          	movsx  eax,BYTE PTR [ebp-0x44]
    147e:	2b 45 e0             	sub    eax,DWORD PTR [ebp-0x20]
    1481:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				if (nz < 0)
    1484:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    1488:	79 07                	jns    1491 <putmin+0xf4>
						nz = 0;
    148a:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
				if (width)
    1491:	80 7d c0 00          	cmp    BYTE PTR [ebp-0x40],0x0
    1495:	74 0d                	je     14a4 <putmin+0x107>
						ns = width - rv - nz;
    1497:	0f be 45 c0          	movsx  eax,BYTE PTR [ebp-0x40]
    149b:	2b 45 f4             	sub    eax,DWORD PTR [ebp-0xc]
    149e:	2b 45 f0             	sub    eax,DWORD PTR [ebp-0x10]
    14a1:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				if (ns < 0)
    14a4:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    14a8:	79 07                	jns    14b1 <putmin+0x114>
						ns = 0;
    14aa:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		}
		rv += nz + ns;
    14b1:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    14b4:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    14b7:	01 d0                	add    eax,edx
    14b9:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
		/* print spaces */
		if (flags & KFL_LEFT_ALIGN)
    14bc:	0f be 45 c4          	movsx  eax,BYTE PTR [ebp-0x3c]
    14c0:	83 e0 08             	and    eax,0x8
    14c3:	85 c0                	test   eax,eax
    14c5:	74 25                	je     14ec <putmin+0x14f>
				while (ns--)
    14c7:	eb 16                	jmp    14df <putmin+0x142>
						ctx->putchar(ctx, ' ');
    14c9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    14cc:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    14cf:	c7 44 24 04 20 00 00 00 	mov    DWORD PTR [esp+0x4],0x20
    14d7:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    14da:	89 14 24             	mov    DWORD PTR [esp],edx
    14dd:	ff d0                	call   eax
				while (ns--)
    14df:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    14e2:	8d 50 ff             	lea    edx,[eax-0x1]
    14e5:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
    14e8:	85 c0                	test   eax,eax
    14ea:	75 dd                	jne    14c9 <putmin+0x12c>
		/* print the minus sign */
		if (ctx) ctx->putchar(ctx, '-');
    14ec:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    14f0:	74 16                	je     1508 <putmin+0x16b>
    14f2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    14f5:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    14f8:	c7 44 24 04 2d 00 00 00 	mov    DWORD PTR [esp+0x4],0x2d
    1500:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    1503:	89 14 24             	mov    DWORD PTR [esp],edx
    1506:	ff d0                	call   eax
		/* print the type prefix */
		if (flags & KFL_TYPE_PREFIX) {
    1508:	0f be 45 c4          	movsx  eax,BYTE PTR [ebp-0x3c]
    150c:	83 e0 10             	and    eax,0x10
    150f:	85 c0                	test   eax,eax
    1511:	0f 84 90 00 00 00    	je     15a7 <putmin+0x20a>
				if (flags & KFL_IS_HEX) {
    1517:	0f be 45 c4          	movsx  eax,BYTE PTR [ebp-0x3c]
    151b:	83 e0 01             	and    eax,0x1
    151e:	85 c0                	test   eax,eax
    1520:	74 4c                	je     156e <putmin+0x1d1>
						ctx->putchar(ctx, '0');
    1522:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1525:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1528:	c7 44 24 04 30 00 00 00 	mov    DWORD PTR [esp+0x4],0x30
    1530:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    1533:	89 14 24             	mov    DWORD PTR [esp],edx
    1536:	ff d0                	call   eax
						if (flags & KFL_CAPITAL)
    1538:	80 7d c4 00          	cmp    BYTE PTR [ebp-0x3c],0x0
    153c:	79 18                	jns    1556 <putmin+0x1b9>
								ctx->putchar(ctx, 'X');
    153e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1541:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1544:	c7 44 24 04 58 00 00 00 	mov    DWORD PTR [esp+0x4],0x58
    154c:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    154f:	89 14 24             	mov    DWORD PTR [esp],edx
    1552:	ff d0                	call   eax
    1554:	eb 51                	jmp    15a7 <putmin+0x20a>
						else
								ctx->putchar(ctx, 'x');
    1556:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1559:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    155c:	c7 44 24 04 78 00 00 00 	mov    DWORD PTR [esp+0x4],0x78
    1564:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    1567:	89 14 24             	mov    DWORD PTR [esp],edx
    156a:	ff d0                	call   eax
    156c:	eb 39                	jmp    15a7 <putmin+0x20a>
				} else if (flags & KFL_IS_OCT)
    156e:	0f be 45 c4          	movsx  eax,BYTE PTR [ebp-0x3c]
    1572:	83 e0 40             	and    eax,0x40
    1575:	85 c0                	test   eax,eax
    1577:	74 2e                	je     15a7 <putmin+0x20a>
						ctx->putchar(ctx, '0');
    1579:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    157c:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    157f:	c7 44 24 04 30 00 00 00 	mov    DWORD PTR [esp+0x4],0x30
    1587:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    158a:	89 14 24             	mov    DWORD PTR [esp],edx
    158d:	ff d0                	call   eax
		}
		/* and the zero prefix */
		while (nz--)
    158f:	eb 16                	jmp    15a7 <putmin+0x20a>
				ctx->putchar(ctx, '0');
    1591:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1594:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1597:	c7 44 24 04 30 00 00 00 	mov    DWORD PTR [esp+0x4],0x30
    159f:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    15a2:	89 14 24             	mov    DWORD PTR [esp],edx
    15a5:	ff d0                	call   eax
		while (nz--)
    15a7:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    15aa:	8d 50 ff             	lea    edx,[eax-0x1]
    15ad:	89 55 f0             	mov    DWORD PTR [ebp-0x10],edx
    15b0:	85 c0                	test   eax,eax
    15b2:	75 dd                	jne    1591 <putmin+0x1f4>
		/* print the number */
		if (ctx) for (size_t i = 0; i < strlen(str); i++)
    15b4:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    15b8:	74 55                	je     160f <putmin+0x272>
    15ba:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
    15c1:	eb 24                	jmp    15e7 <putmin+0x24a>
				ctx->putchar(ctx, str[i]);
    15c3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    15c6:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    15c9:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
    15cc:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    15cf:	01 ca                	add    edx,ecx
    15d1:	0f b6 12             	movzx  edx,BYTE PTR [edx]
    15d4:	0f be d2             	movsx  edx,dl
    15d7:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    15db:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    15de:	89 14 24             	mov    DWORD PTR [esp],edx
    15e1:	ff d0                	call   eax
		if (ctx) for (size_t i = 0; i < strlen(str); i++)
    15e3:	83 45 e8 01          	add    DWORD PTR [ebp-0x18],0x1
    15e7:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    15ea:	89 04 24             	mov    DWORD PTR [esp],eax
    15ed:	e8 fc ff ff ff       	call   15ee <putmin+0x251>
    15f2:	39 45 e8             	cmp    DWORD PTR [ebp-0x18],eax
    15f5:	72 cc                	jb     15c3 <putmin+0x226>
		/* print spaces */
		while (ns-- > 0)
    15f7:	eb 16                	jmp    160f <putmin+0x272>
				ctx->putchar(ctx, ' ');
    15f9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    15fc:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    15ff:	c7 44 24 04 20 00 00 00 	mov    DWORD PTR [esp+0x4],0x20
    1607:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    160a:	89 14 24             	mov    DWORD PTR [esp],edx
    160d:	ff d0                	call   eax
		while (ns-- > 0)
    160f:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1612:	8d 50 ff             	lea    edx,[eax-0x1]
    1615:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
    1618:	85 c0                	test   eax,eax
    161a:	7f dd                	jg     15f9 <putmin+0x25c>
		return rv;
    161c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    161f:	c9                   	leave
    1620:	c3                   	ret

00001621 <putd>:

int putd(struct ivp_ctx* ctx, long long int arg, char flags, char width, char prec)
{
    1621:	55                   	push   ebp
    1622:	89 e5                	mov    ebp,esp
    1624:	56                   	push   esi
    1625:	53                   	push   ebx
    1626:	83 ec 40             	sub    esp,0x40
    1629:	8b 5d 14             	mov    ebx,DWORD PTR [ebp+0x14]
    162c:	8b 4d 18             	mov    ecx,DWORD PTR [ebp+0x18]
    162f:	8b 55 1c             	mov    edx,DWORD PTR [ebp+0x1c]
    1632:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1635:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    1638:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    163b:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    163e:	89 d8                	mov    eax,ebx
    1640:	88 45 ec             	mov    BYTE PTR [ebp-0x14],al
    1643:	89 c8                	mov    eax,ecx
    1645:	88 45 e8             	mov    BYTE PTR [ebp-0x18],al
    1648:	89 d0                	mov    eax,edx
    164a:	88 45 e4             	mov    BYTE PTR [ebp-0x1c],al
		if (arg < 0) {
    164d:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1651:	79 75                	jns    16c8 <putd+0xa7>
				if (arg > LLONG_MIN)
    1653:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1656:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    1659:	81 f2 00 00 00 80    	xor    edx,0x80000000
    165f:	09 d0                	or     eax,edx
    1661:	74 40                	je     16a3 <putd+0x82>
						return putu(ctx, -arg, flags | KFL_IS_NEG, width, prec);
    1663:	0f be 75 e4          	movsx  esi,BYTE PTR [ebp-0x1c]
    1667:	0f be 5d e8          	movsx  ebx,BYTE PTR [ebp-0x18]
    166b:	0f b6 45 ec          	movzx  eax,BYTE PTR [ebp-0x14]
    166f:	83 c8 c0             	or     eax,0xffffffc0
    1672:	0f be c8             	movsx  ecx,al
    1675:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1678:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    167b:	f7 d8                	neg    eax
    167d:	83 d2 00             	adc    edx,0x0
    1680:	f7 da                	neg    edx
    1682:	89 74 24 14          	mov    DWORD PTR [esp+0x14],esi
    1686:	89 5c 24 10          	mov    DWORD PTR [esp+0x10],ebx
    168a:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    168e:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1692:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    1696:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1699:	89 04 24             	mov    DWORD PTR [esp],eax
    169c:	e8 fc ff ff ff       	call   169d <putd+0x7c>
    16a1:	eb 56                	jmp    16f9 <putd+0xd8>
				else
						return putmin(ctx, flags, width, prec);
    16a3:	0f be 4d e4          	movsx  ecx,BYTE PTR [ebp-0x1c]
    16a7:	0f be 55 e8          	movsx  edx,BYTE PTR [ebp-0x18]
    16ab:	0f be 45 ec          	movsx  eax,BYTE PTR [ebp-0x14]
    16af:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    16b3:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    16b7:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    16bb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    16be:	89 04 24             	mov    DWORD PTR [esp],eax
    16c1:	e8 fc ff ff ff       	call   16c2 <putd+0xa1>
    16c6:	eb 31                	jmp    16f9 <putd+0xd8>
		} else
				return putu(ctx, (unsigned long long int)arg, flags, width, prec);
    16c8:	0f be 75 e4          	movsx  esi,BYTE PTR [ebp-0x1c]
    16cc:	0f be 5d e8          	movsx  ebx,BYTE PTR [ebp-0x18]
    16d0:	0f be 4d ec          	movsx  ecx,BYTE PTR [ebp-0x14]
    16d4:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    16d7:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    16da:	89 74 24 14          	mov    DWORD PTR [esp+0x14],esi
    16de:	89 5c 24 10          	mov    DWORD PTR [esp+0x10],ebx
    16e2:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    16e6:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    16ea:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    16ee:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    16f1:	89 04 24             	mov    DWORD PTR [esp],eax
    16f4:	e8 fc ff ff ff       	call   16f5 <putd+0xd4>
}
    16f9:	83 c4 40             	add    esp,0x40
    16fc:	5b                   	pop    ebx
    16fd:	5e                   	pop    esi
    16fe:	5d                   	pop    ebp
    16ff:	c3                   	ret

00001700 <cputs.0>:
															0, 2 * sizeof(void*) / sizeof(char));
									/*		cur_fmt = fm;
									}*/
									else if (*fmt == 's') {
											/* no wchar_t support */
											void cputs(const char* s) {
    1700:	55                   	push   ebp
    1701:	89 e5                	mov    ebp,esp
    1703:	53                   	push   ebx
    1704:	83 ec 24             	sub    esp,0x24
    1707:	89 cb                	mov    ebx,ecx
    1709:	89 4d f4             	mov    DWORD PTR [ebp-0xc],ecx
													while (*s)
    170c:	eb 1f                	jmp    172d <cputs.0+0x2d>
															ctx->putchar(ctx, *s++);
    170e:	8b 03                	mov    eax,DWORD PTR [ebx]
    1710:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    1713:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1716:	8d 48 01             	lea    ecx,[eax+0x1]
    1719:	89 4d 08             	mov    DWORD PTR [ebp+0x8],ecx
    171c:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    171f:	0f be c8             	movsx  ecx,al
    1722:	8b 03                	mov    eax,DWORD PTR [ebx]
    1724:	89 4c 24 04          	mov    DWORD PTR [esp+0x4],ecx
    1728:	89 04 24             	mov    DWORD PTR [esp],eax
    172b:	ff d2                	call   edx
													while (*s)
    172d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1730:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1733:	84 c0                	test   al,al
    1735:	75 d7                	jne    170e <cputs.0+0xe>
											}
    1737:	90                   	nop
    1738:	90                   	nop
    1739:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    173c:	c9                   	leave
    173d:	c3                   	ret

0000173e <internal_vprintf>:
{
    173e:	55                   	push   ebp
    173f:	89 e5                	mov    ebp,esp
    1741:	56                   	push   esi
    1742:	53                   	push   ebx
    1743:	83 ec 50             	sub    esp,0x50
int internal_vprintf(struct ivp_ctx* ctx, const char* fmt, va_list args)
    1746:	8d 45 08             	lea    eax,[ebp+0x8]
    1749:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
    174c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    174f:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
		char is_fmt = 0, flags = KFL_LEFT_ALIGN, width = 0, prec = 0, size = 0;
    1752:	c6 45 f7 00          	mov    BYTE PTR [ebp-0x9],0x0
    1756:	c6 45 f6 08          	mov    BYTE PTR [ebp-0xa],0x8
    175a:	c6 45 f5 00          	mov    BYTE PTR [ebp-0xb],0x0
    175e:	c6 45 f4 00          	mov    BYTE PTR [ebp-0xc],0x0
    1762:	c6 45 f3 00          	mov    BYTE PTR [ebp-0xd],0x0
		int rv = 0;
    1766:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		while (*fmt) {
    176d:	e9 2a 09 00 00       	jmp    209c <internal_vprintf+0x95e>
			switch (*fmt) {
    1772:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1775:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1778:	0f be c0             	movsx  eax,al
    177b:	83 f8 25             	cmp    eax,0x25
    177e:	75 4b                	jne    17cb <internal_vprintf+0x8d>
							is_fmt = !is_fmt;
    1780:	80 7d f7 00          	cmp    BYTE PTR [ebp-0x9],0x0
    1784:	0f 94 c0             	sete   al
    1787:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
							if (!is_fmt) {
    178a:	80 7d f7 00          	cmp    BYTE PTR [ebp-0x9],0x0
    178e:	75 1f                	jne    17af <internal_vprintf+0x71>
									ctx->putchar(ctx, *fmt);
    1790:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1793:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1796:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    1799:	0f b6 12             	movzx  edx,BYTE PTR [edx]
    179c:	0f be ca             	movsx  ecx,dl
    179f:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
    17a2:	89 4c 24 04          	mov    DWORD PTR [esp+0x4],ecx
    17a6:	89 14 24             	mov    DWORD PTR [esp],edx
    17a9:	ff d0                	call   eax
									rv++;
    17ab:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
							fmt++;
    17af:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
							width = prec = 0;
    17b3:	c6 45 f4 00          	mov    BYTE PTR [ebp-0xc],0x0
    17b7:	0f b6 45 f4          	movzx  eax,BYTE PTR [ebp-0xc]
    17bb:	88 45 f5             	mov    BYTE PTR [ebp-0xb],al
							flags = KFL_LEFT_ALIGN;
    17be:	c6 45 f6 08          	mov    BYTE PTR [ebp-0xa],0x8
							size = 0;
    17c2:	c6 45 f3 00          	mov    BYTE PTR [ebp-0xd],0x0
							break;
    17c6:	e9 d1 08 00 00       	jmp    209c <internal_vprintf+0x95e>
							if ((is_fmt == 1) && (*fmt == ' ' || *fmt == '0' || *fmt == '#' || *fmt == '+' || *fmt == '-')) {
    17cb:	80 7d f7 01          	cmp    BYTE PTR [ebp-0x9],0x1
    17cf:	0f 85 89 00 00 00    	jne    185e <internal_vprintf+0x120>
    17d5:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    17d8:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    17db:	3c 20                	cmp    al,0x20
    17dd:	74 28                	je     1807 <internal_vprintf+0xc9>
    17df:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    17e2:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    17e5:	3c 30                	cmp    al,0x30
    17e7:	74 1e                	je     1807 <internal_vprintf+0xc9>
    17e9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    17ec:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    17ef:	3c 23                	cmp    al,0x23
    17f1:	74 14                	je     1807 <internal_vprintf+0xc9>
    17f3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    17f6:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    17f9:	3c 2b                	cmp    al,0x2b
    17fb:	74 0a                	je     1807 <internal_vprintf+0xc9>
    17fd:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1800:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1803:	3c 2d                	cmp    al,0x2d
    1805:	75 57                	jne    185e <internal_vprintf+0x120>
									if (*fmt == ' ')
    1807:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    180a:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    180d:	3c 20                	cmp    al,0x20
    180f:	75 06                	jne    1817 <internal_vprintf+0xd9>
											flags |= KFL_SPACE_PLUS;
    1811:	80 4d f6 20          	or     BYTE PTR [ebp-0xa],0x20
    1815:	eb 3e                	jmp    1855 <internal_vprintf+0x117>
									else if (*fmt == '0')
    1817:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    181a:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    181d:	3c 30                	cmp    al,0x30
    181f:	75 06                	jne    1827 <internal_vprintf+0xe9>
											flags |= KFL_ZERO_PREFIX;
    1821:	80 4d f6 02          	or     BYTE PTR [ebp-0xa],0x2
    1825:	eb 2e                	jmp    1855 <internal_vprintf+0x117>
									else if (*fmt == '+')
    1827:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    182a:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    182d:	3c 2b                	cmp    al,0x2b
    182f:	75 06                	jne    1837 <internal_vprintf+0xf9>
											flags |= KFL_ALWAYS_SIGN;
    1831:	80 4d f6 04          	or     BYTE PTR [ebp-0xa],0x4
    1835:	eb 1e                	jmp    1855 <internal_vprintf+0x117>
									else if (*fmt == '-')
    1837:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    183a:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    183d:	3c 2d                	cmp    al,0x2d
    183f:	75 06                	jne    1847 <internal_vprintf+0x109>
											flags &= ~KFL_LEFT_ALIGN;
    1841:	80 65 f6 f7          	and    BYTE PTR [ebp-0xa],0xf7
    1845:	eb 0e                	jmp    1855 <internal_vprintf+0x117>
									else if (*fmt == '#')
    1847:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    184a:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    184d:	3c 23                	cmp    al,0x23
    184f:	75 04                	jne    1855 <internal_vprintf+0x117>
											flags |= KFL_TYPE_PREFIX;
    1851:	80 4d f6 10          	or     BYTE PTR [ebp-0xa],0x10
									fmt++;
    1855:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
    1859:	e9 3e 08 00 00       	jmp    209c <internal_vprintf+0x95e>
							} else if (is_fmt && *fmt >= '0' && *fmt <= '9') {
    185e:	80 7d f7 00          	cmp    BYTE PTR [ebp-0x9],0x0
    1862:	74 77                	je     18db <internal_vprintf+0x19d>
    1864:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1867:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    186a:	3c 2f                	cmp    al,0x2f
    186c:	7e 6d                	jle    18db <internal_vprintf+0x19d>
    186e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1871:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1874:	3c 39                	cmp    al,0x39
    1876:	7f 63                	jg     18db <internal_vprintf+0x19d>
									if (is_fmt == 1)
    1878:	80 7d f7 01          	cmp    BYTE PTR [ebp-0x9],0x1
    187c:	75 04                	jne    1882 <internal_vprintf+0x144>
											is_fmt = 3;
    187e:	c6 45 f7 03          	mov    BYTE PTR [ebp-0x9],0x3
									if (is_fmt == 2) {
    1882:	80 7d f7 02          	cmp    BYTE PTR [ebp-0x9],0x2
    1886:	75 26                	jne    18ae <internal_vprintf+0x170>
											prec *= 10;
    1888:	0f b6 55 f4          	movzx  edx,BYTE PTR [ebp-0xc]
    188c:	89 d0                	mov    eax,edx
    188e:	c1 e0 02             	shl    eax,0x2
    1891:	01 d0                	add    eax,edx
    1893:	01 c0                	add    eax,eax
    1895:	88 45 f4             	mov    BYTE PTR [ebp-0xc],al
											prec += (*fmt - '0');
    1898:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    189b:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    189e:	89 c2                	mov    edx,eax
    18a0:	0f b6 45 f4          	movzx  eax,BYTE PTR [ebp-0xc]
    18a4:	01 d0                	add    eax,edx
    18a6:	83 e8 30             	sub    eax,0x30
    18a9:	88 45 f4             	mov    BYTE PTR [ebp-0xc],al
    18ac:	eb 24                	jmp    18d2 <internal_vprintf+0x194>
											width *= 10;
    18ae:	0f b6 55 f5          	movzx  edx,BYTE PTR [ebp-0xb]
    18b2:	89 d0                	mov    eax,edx
    18b4:	c1 e0 02             	shl    eax,0x2
    18b7:	01 d0                	add    eax,edx
    18b9:	01 c0                	add    eax,eax
    18bb:	88 45 f5             	mov    BYTE PTR [ebp-0xb],al
											width += (*fmt - '0');
    18be:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    18c1:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    18c4:	89 c2                	mov    edx,eax
    18c6:	0f b6 45 f5          	movzx  eax,BYTE PTR [ebp-0xb]
    18ca:	01 d0                	add    eax,edx
    18cc:	83 e8 30             	sub    eax,0x30
    18cf:	88 45 f5             	mov    BYTE PTR [ebp-0xb],al
									fmt++;
    18d2:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
    18d6:	e9 c1 07 00 00       	jmp    209c <internal_vprintf+0x95e>
							} else if (is_fmt && *fmt == '.') {
    18db:	80 7d f7 00          	cmp    BYTE PTR [ebp-0x9],0x0
    18df:	74 17                	je     18f8 <internal_vprintf+0x1ba>
    18e1:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    18e4:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    18e7:	3c 2e                	cmp    al,0x2e
    18e9:	75 0d                	jne    18f8 <internal_vprintf+0x1ba>
									is_fmt = 2;
    18eb:	c6 45 f7 02          	mov    BYTE PTR [ebp-0x9],0x2
									fmt++;
    18ef:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
    18f3:	e9 a4 07 00 00       	jmp    209c <internal_vprintf+0x95e>
							} else if (is_fmt && *fmt == '*') {
    18f8:	80 7d f7 00          	cmp    BYTE PTR [ebp-0x9],0x0
    18fc:	74 37                	je     1935 <internal_vprintf+0x1f7>
    18fe:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1901:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1904:	3c 2a                	cmp    al,0x2a
    1906:	75 2d                	jne    1935 <internal_vprintf+0x1f7>
									if (is_fmt == 2)
    1908:	80 7d f7 02          	cmp    BYTE PTR [ebp-0x9],0x2
    190c:	75 10                	jne    191e <internal_vprintf+0x1e0>
											prec = va_arg(args, int);
    190e:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1911:	8d 50 04             	lea    edx,[eax+0x4]
    1914:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    1917:	8b 00                	mov    eax,DWORD PTR [eax]
    1919:	88 45 f4             	mov    BYTE PTR [ebp-0xc],al
    191c:	eb 0e                	jmp    192c <internal_vprintf+0x1ee>
											width = va_arg(args, int);
    191e:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1921:	8d 50 04             	lea    edx,[eax+0x4]
    1924:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    1927:	8b 00                	mov    eax,DWORD PTR [eax]
    1929:	88 45 f5             	mov    BYTE PTR [ebp-0xb],al
									fmt++;
    192c:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
    1930:	e9 67 07 00 00       	jmp    209c <internal_vprintf+0x95e>
							} else if (is_fmt) {
    1935:	80 7d f7 00          	cmp    BYTE PTR [ebp-0x9],0x0
    1939:	0f 84 38 07 00 00    	je     2077 <internal_vprintf+0x939>
									if (is_fmt == 2 && !prec)
    193f:	80 7d f7 02          	cmp    BYTE PTR [ebp-0x9],0x2
    1943:	75 0a                	jne    194f <internal_vprintf+0x211>
    1945:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
    1949:	75 04                	jne    194f <internal_vprintf+0x211>
											prec = -1; /* no zero */
    194b:	c6 45 f4 ff          	mov    BYTE PTR [ebp-0xc],0xff
									if (*fmt == 'h') {
    194f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1952:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1955:	3c 68                	cmp    al,0x68
    1957:	75 1e                	jne    1977 <internal_vprintf+0x239>
											fmt++;
    1959:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
											if (*fmt == 'h') {
    195d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1960:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1963:	3c 68                	cmp    al,0x68
    1965:	75 0a                	jne    1971 <internal_vprintf+0x233>
													size = 1; /* hh */
    1967:	c6 45 f3 01          	mov    BYTE PTR [ebp-0xd],0x1
													fmt++;
    196b:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
    196f:	eb 7c                	jmp    19ed <internal_vprintf+0x2af>
													size = 2; /* h */
    1971:	c6 45 f3 02          	mov    BYTE PTR [ebp-0xd],0x2
    1975:	eb 76                	jmp    19ed <internal_vprintf+0x2af>
									} else if (*fmt == 'l') {
    1977:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    197a:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    197d:	3c 6c                	cmp    al,0x6c
    197f:	75 1e                	jne    199f <internal_vprintf+0x261>
											fmt++;
    1981:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
											if (*fmt == 'l') {
    1985:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1988:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    198b:	3c 6c                	cmp    al,0x6c
    198d:	75 0a                	jne    1999 <internal_vprintf+0x25b>
													size = 4; /* ll */
    198f:	c6 45 f3 04          	mov    BYTE PTR [ebp-0xd],0x4
													fmt++;
    1993:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
    1997:	eb 54                	jmp    19ed <internal_vprintf+0x2af>
													size = 3;
    1999:	c6 45 f3 03          	mov    BYTE PTR [ebp-0xd],0x3
    199d:	eb 4e                	jmp    19ed <internal_vprintf+0x2af>
									} else if (*fmt == 'j') {
    199f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    19a2:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    19a5:	3c 6a                	cmp    al,0x6a
    19a7:	75 0a                	jne    19b3 <internal_vprintf+0x275>
											fmt++;
    19a9:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
											size = 5;
    19ad:	c6 45 f3 05          	mov    BYTE PTR [ebp-0xd],0x5
    19b1:	eb 3a                	jmp    19ed <internal_vprintf+0x2af>
									} else if (*fmt == 'z') {
    19b3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    19b6:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    19b9:	3c 7a                	cmp    al,0x7a
    19bb:	75 0a                	jne    19c7 <internal_vprintf+0x289>
											size = 6;
    19bd:	c6 45 f3 06          	mov    BYTE PTR [ebp-0xd],0x6
											fmt++;
    19c1:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
    19c5:	eb 26                	jmp    19ed <internal_vprintf+0x2af>
									} else if (*fmt == 't') {
    19c7:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    19ca:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    19cd:	3c 74                	cmp    al,0x74
    19cf:	75 0a                	jne    19db <internal_vprintf+0x29d>
											size = 7;
    19d1:	c6 45 f3 07          	mov    BYTE PTR [ebp-0xd],0x7
											fmt++;
    19d5:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
    19d9:	eb 12                	jmp    19ed <internal_vprintf+0x2af>
									} else if (*fmt == 'L') {
    19db:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    19de:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    19e1:	3c 4c                	cmp    al,0x4c
    19e3:	75 08                	jne    19ed <internal_vprintf+0x2af>
											size = 8;
    19e5:	c6 45 f3 08          	mov    BYTE PTR [ebp-0xd],0x8
											fmt++;
    19e9:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
									if (*fmt == 'd' || *fmt == 'i') {
    19ed:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    19f0:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    19f3:	3c 64                	cmp    al,0x64
    19f5:	74 0e                	je     1a05 <internal_vprintf+0x2c7>
    19f7:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    19fa:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    19fd:	3c 69                	cmp    al,0x69
    19ff:	0f 85 03 01 00 00    	jne    1b08 <internal_vprintf+0x3ca>
											signed long long int val = 0;
    1a05:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
    1a0c:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
											if (!size) val = va_arg(args, signed int);
    1a13:	80 7d f3 00          	cmp    BYTE PTR [ebp-0xd],0x0
    1a17:	75 17                	jne    1a30 <internal_vprintf+0x2f2>
    1a19:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1a1c:	8d 50 04             	lea    edx,[eax+0x4]
    1a1f:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    1a22:	8b 00                	mov    eax,DWORD PTR [eax]
    1a24:	99                   	cdq
    1a25:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1a28:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
    1a2b:	e9 9f 00 00 00       	jmp    1acf <internal_vprintf+0x391>
											else if (size == 1) val = va_arg(args, signed char);
    1a30:	80 7d f3 01          	cmp    BYTE PTR [ebp-0xd],0x1
    1a34:	75 02                	jne    1a38 <internal_vprintf+0x2fa>
    1a36:	0f 0b                	ud2
											else if (size == 2) val = va_arg(args, signed short int);
    1a38:	80 7d f3 02          	cmp    BYTE PTR [ebp-0xd],0x2
    1a3c:	75 02                	jne    1a40 <internal_vprintf+0x302>
    1a3e:	0f 0b                	ud2
											else if (size == 3) val = va_arg(args, signed long int);
    1a40:	80 7d f3 03          	cmp    BYTE PTR [ebp-0xd],0x3
    1a44:	75 14                	jne    1a5a <internal_vprintf+0x31c>
    1a46:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1a49:	8d 50 04             	lea    edx,[eax+0x4]
    1a4c:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    1a4f:	8b 00                	mov    eax,DWORD PTR [eax]
    1a51:	99                   	cdq
    1a52:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1a55:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
    1a58:	eb 75                	jmp    1acf <internal_vprintf+0x391>
											else if (size == 4) val = va_arg(args, signed long long int);
    1a5a:	80 7d f3 04          	cmp    BYTE PTR [ebp-0xd],0x4
    1a5e:	75 16                	jne    1a76 <internal_vprintf+0x338>
    1a60:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1a63:	8d 50 08             	lea    edx,[eax+0x8]
    1a66:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    1a69:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1a6c:	8b 00                	mov    eax,DWORD PTR [eax]
    1a6e:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1a71:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
    1a74:	eb 59                	jmp    1acf <internal_vprintf+0x391>
											else if (size == 5) val = va_arg(args, intmax_t);
    1a76:	80 7d f3 05          	cmp    BYTE PTR [ebp-0xd],0x5
    1a7a:	75 16                	jne    1a92 <internal_vprintf+0x354>
    1a7c:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1a7f:	8d 50 08             	lea    edx,[eax+0x8]
    1a82:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    1a85:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1a88:	8b 00                	mov    eax,DWORD PTR [eax]
    1a8a:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1a8d:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
    1a90:	eb 3d                	jmp    1acf <internal_vprintf+0x391>
											else if (size == 6) val = va_arg(args, ssize_t);
    1a92:	80 7d f3 06          	cmp    BYTE PTR [ebp-0xd],0x6
    1a96:	75 14                	jne    1aac <internal_vprintf+0x36e>
    1a98:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1a9b:	8d 50 04             	lea    edx,[eax+0x4]
    1a9e:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    1aa1:	8b 00                	mov    eax,DWORD PTR [eax]
    1aa3:	99                   	cdq
    1aa4:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1aa7:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
    1aaa:	eb 23                	jmp    1acf <internal_vprintf+0x391>
											else if (size == 7) val = va_arg(args, ptrdiff_t);
    1aac:	80 7d f3 07          	cmp    BYTE PTR [ebp-0xd],0x7
    1ab0:	75 14                	jne    1ac6 <internal_vprintf+0x388>
    1ab2:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1ab5:	8d 50 04             	lea    edx,[eax+0x4]
    1ab8:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    1abb:	8b 00                	mov    eax,DWORD PTR [eax]
    1abd:	99                   	cdq
    1abe:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1ac1:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
    1ac4:	eb 09                	jmp    1acf <internal_vprintf+0x391>
											else (void)va_arg(args, long double); /* remove bogus value*/
    1ac6:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1ac9:	83 c0 0c             	add    eax,0xc
    1acc:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
											rv += putd(ctx, val, flags, width, prec);
    1acf:	0f be 5d f4          	movsx  ebx,BYTE PTR [ebp-0xc]
    1ad3:	0f be 55 f5          	movsx  edx,BYTE PTR [ebp-0xb]
    1ad7:	0f be 45 f6          	movsx  eax,BYTE PTR [ebp-0xa]
    1adb:	8b 4d c8             	mov    ecx,DWORD PTR [ebp-0x38]
    1ade:	89 5c 24 14          	mov    DWORD PTR [esp+0x14],ebx
    1ae2:	89 54 24 10          	mov    DWORD PTR [esp+0x10],edx
    1ae6:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    1aea:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1aed:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
    1af0:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1af4:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    1af8:	89 0c 24             	mov    DWORD PTR [esp],ecx
    1afb:	e8 fc ff ff ff       	call   1afc <internal_vprintf+0x3be>
    1b00:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
									if (*fmt == 'd' || *fmt == 'i') {
    1b03:	e9 55 05 00 00       	jmp    205d <internal_vprintf+0x91f>
									} else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'u' || *fmt == 'o' || *fmt == 'b') {
    1b08:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1b0b:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1b0e:	3c 78                	cmp    al,0x78
    1b10:	74 2c                	je     1b3e <internal_vprintf+0x400>
    1b12:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1b15:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1b18:	3c 58                	cmp    al,0x58
    1b1a:	74 22                	je     1b3e <internal_vprintf+0x400>
    1b1c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1b1f:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1b22:	3c 75                	cmp    al,0x75
    1b24:	74 18                	je     1b3e <internal_vprintf+0x400>
    1b26:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1b29:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1b2c:	3c 6f                	cmp    al,0x6f
    1b2e:	74 0e                	je     1b3e <internal_vprintf+0x400>
    1b30:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1b33:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1b36:	3c 62                	cmp    al,0x62
    1b38:	0f 85 31 02 00 00    	jne    1d6f <internal_vprintf+0x631>
											unsigned long long int val = 0;
    1b3e:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [ebp-0x28],0x0
    1b45:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
											if (!size) val = va_arg(args, unsigned int);
    1b4c:	80 7d f3 00          	cmp    BYTE PTR [ebp-0xd],0x0
    1b50:	75 1a                	jne    1b6c <internal_vprintf+0x42e>
    1b52:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1b55:	8d 50 04             	lea    edx,[eax+0x4]
    1b58:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    1b5b:	8b 00                	mov    eax,DWORD PTR [eax]
    1b5d:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    1b60:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
    1b67:	e9 a5 00 00 00       	jmp    1c11 <internal_vprintf+0x4d3>
											else if (size == 1) val = va_arg(args, unsigned char);
    1b6c:	80 7d f3 01          	cmp    BYTE PTR [ebp-0xd],0x1
    1b70:	75 02                	jne    1b74 <internal_vprintf+0x436>
    1b72:	0f 0b                	ud2
											else if (size == 2) val = va_arg(args, unsigned short int);
    1b74:	80 7d f3 02          	cmp    BYTE PTR [ebp-0xd],0x2
    1b78:	75 02                	jne    1b7c <internal_vprintf+0x43e>
    1b7a:	0f 0b                	ud2
											else if (size == 3) val = va_arg(args, unsigned long int);
    1b7c:	80 7d f3 03          	cmp    BYTE PTR [ebp-0xd],0x3
    1b80:	75 17                	jne    1b99 <internal_vprintf+0x45b>
    1b82:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1b85:	8d 50 04             	lea    edx,[eax+0x4]
    1b88:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    1b8b:	8b 00                	mov    eax,DWORD PTR [eax]
    1b8d:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    1b90:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
    1b97:	eb 78                	jmp    1c11 <internal_vprintf+0x4d3>
											else if (size == 4) val = va_arg(args, unsigned long long int);
    1b99:	80 7d f3 04          	cmp    BYTE PTR [ebp-0xd],0x4
    1b9d:	75 16                	jne    1bb5 <internal_vprintf+0x477>
    1b9f:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1ba2:	8d 50 08             	lea    edx,[eax+0x8]
    1ba5:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    1ba8:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1bab:	8b 00                	mov    eax,DWORD PTR [eax]
    1bad:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    1bb0:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
    1bb3:	eb 5c                	jmp    1c11 <internal_vprintf+0x4d3>
											else if (size == 5) val = va_arg(args, uintmax_t);
    1bb5:	80 7d f3 05          	cmp    BYTE PTR [ebp-0xd],0x5
    1bb9:	75 16                	jne    1bd1 <internal_vprintf+0x493>
    1bbb:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1bbe:	8d 50 08             	lea    edx,[eax+0x8]
    1bc1:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    1bc4:	8b 50 04             	mov    edx,DWORD PTR [eax+0x4]
    1bc7:	8b 00                	mov    eax,DWORD PTR [eax]
    1bc9:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    1bcc:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
    1bcf:	eb 40                	jmp    1c11 <internal_vprintf+0x4d3>
											else if (size == 6) val = va_arg(args, size_t);
    1bd1:	80 7d f3 06          	cmp    BYTE PTR [ebp-0xd],0x6
    1bd5:	75 17                	jne    1bee <internal_vprintf+0x4b0>
    1bd7:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1bda:	8d 50 04             	lea    edx,[eax+0x4]
    1bdd:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    1be0:	8b 00                	mov    eax,DWORD PTR [eax]
    1be2:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    1be5:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
    1bec:	eb 23                	jmp    1c11 <internal_vprintf+0x4d3>
											else if (size == 7) val = va_arg(args, ptrdiff_t);
    1bee:	80 7d f3 07          	cmp    BYTE PTR [ebp-0xd],0x7
    1bf2:	75 14                	jne    1c08 <internal_vprintf+0x4ca>
    1bf4:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1bf7:	8d 50 04             	lea    edx,[eax+0x4]
    1bfa:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    1bfd:	8b 00                	mov    eax,DWORD PTR [eax]
    1bff:	99                   	cdq
    1c00:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    1c03:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
    1c06:	eb 09                	jmp    1c11 <internal_vprintf+0x4d3>
											else (void)va_arg(args, long double); /* remove bogus value*/
    1c08:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1c0b:	83 c0 0c             	add    eax,0xc
    1c0e:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
											if (*fmt == 'x')
    1c11:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1c14:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1c17:	3c 78                	cmp    al,0x78
    1c19:	75 3f                	jne    1c5a <internal_vprintf+0x51c>
													rv += putu(ctx, val, flags | KFL_IS_HEX, width, prec);
    1c1b:	0f be 5d f4          	movsx  ebx,BYTE PTR [ebp-0xc]
    1c1f:	0f be 55 f5          	movsx  edx,BYTE PTR [ebp-0xb]
    1c23:	0f b6 45 f6          	movzx  eax,BYTE PTR [ebp-0xa]
    1c27:	83 c8 01             	or     eax,0x1
    1c2a:	0f be c0             	movsx  eax,al
    1c2d:	8b 4d c8             	mov    ecx,DWORD PTR [ebp-0x38]
    1c30:	89 5c 24 14          	mov    DWORD PTR [esp+0x14],ebx
    1c34:	89 54 24 10          	mov    DWORD PTR [esp+0x10],edx
    1c38:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    1c3c:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1c3f:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1c42:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1c46:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    1c4a:	89 0c 24             	mov    DWORD PTR [esp],ecx
    1c4d:	e8 fc ff ff ff       	call   1c4e <internal_vprintf+0x510>
    1c52:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
									} else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'u' || *fmt == 'o' || *fmt == 'b') {
    1c55:	e9 02 04 00 00       	jmp    205c <internal_vprintf+0x91e>
											else if (*fmt == 'X')
    1c5a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1c5d:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1c60:	3c 58                	cmp    al,0x58
    1c62:	75 3f                	jne    1ca3 <internal_vprintf+0x565>
													rv += putu(ctx, val, flags | KFL_IS_HEX | KFL_CAPITAL, width, prec);
    1c64:	0f be 5d f4          	movsx  ebx,BYTE PTR [ebp-0xc]
    1c68:	0f be 55 f5          	movsx  edx,BYTE PTR [ebp-0xb]
    1c6c:	0f b6 45 f6          	movzx  eax,BYTE PTR [ebp-0xa]
    1c70:	83 c8 81             	or     eax,0xffffff81
    1c73:	0f be c0             	movsx  eax,al
    1c76:	8b 4d c8             	mov    ecx,DWORD PTR [ebp-0x38]
    1c79:	89 5c 24 14          	mov    DWORD PTR [esp+0x14],ebx
    1c7d:	89 54 24 10          	mov    DWORD PTR [esp+0x10],edx
    1c81:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    1c85:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1c88:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1c8b:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1c8f:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    1c93:	89 0c 24             	mov    DWORD PTR [esp],ecx
    1c96:	e8 fc ff ff ff       	call   1c97 <internal_vprintf+0x559>
    1c9b:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
									} else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'u' || *fmt == 'o' || *fmt == 'b') {
    1c9e:	e9 b9 03 00 00       	jmp    205c <internal_vprintf+0x91e>
											else if (*fmt == 'u')
    1ca3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1ca6:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1ca9:	3c 75                	cmp    al,0x75
    1cab:	75 39                	jne    1ce6 <internal_vprintf+0x5a8>
													rv += putu(ctx, val, flags, width, prec);
    1cad:	0f be 5d f4          	movsx  ebx,BYTE PTR [ebp-0xc]
    1cb1:	0f be 55 f5          	movsx  edx,BYTE PTR [ebp-0xb]
    1cb5:	0f be 45 f6          	movsx  eax,BYTE PTR [ebp-0xa]
    1cb9:	8b 4d c8             	mov    ecx,DWORD PTR [ebp-0x38]
    1cbc:	89 5c 24 14          	mov    DWORD PTR [esp+0x14],ebx
    1cc0:	89 54 24 10          	mov    DWORD PTR [esp+0x10],edx
    1cc4:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    1cc8:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1ccb:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1cce:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1cd2:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    1cd6:	89 0c 24             	mov    DWORD PTR [esp],ecx
    1cd9:	e8 fc ff ff ff       	call   1cda <internal_vprintf+0x59c>
    1cde:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
									} else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'u' || *fmt == 'o' || *fmt == 'b') {
    1ce1:	e9 76 03 00 00       	jmp    205c <internal_vprintf+0x91e>
											else if (*fmt == 'o')
    1ce6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1ce9:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1cec:	3c 6f                	cmp    al,0x6f
    1cee:	75 3f                	jne    1d2f <internal_vprintf+0x5f1>
													rv += putu(ctx, val, flags | KFL_IS_OCT, width, prec);
    1cf0:	0f be 5d f4          	movsx  ebx,BYTE PTR [ebp-0xc]
    1cf4:	0f be 55 f5          	movsx  edx,BYTE PTR [ebp-0xb]
    1cf8:	0f b6 45 f6          	movzx  eax,BYTE PTR [ebp-0xa]
    1cfc:	83 c8 40             	or     eax,0x40
    1cff:	0f be c0             	movsx  eax,al
    1d02:	8b 4d c8             	mov    ecx,DWORD PTR [ebp-0x38]
    1d05:	89 5c 24 14          	mov    DWORD PTR [esp+0x14],ebx
    1d09:	89 54 24 10          	mov    DWORD PTR [esp+0x10],edx
    1d0d:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    1d11:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1d14:	8b 55 dc             	mov    edx,DWORD PTR [ebp-0x24]
    1d17:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1d1b:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    1d1f:	89 0c 24             	mov    DWORD PTR [esp],ecx
    1d22:	e8 fc ff ff ff       	call   1d23 <internal_vprintf+0x5e5>
    1d27:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
									} else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'u' || *fmt == 'o' || *fmt == 'b') {
    1d2a:	e9 2d 03 00 00       	jmp    205c <internal_vprintf+0x91e>
											else if (*fmt == 'b')
    1d2f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1d32:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1d35:	3c 62                	cmp    al,0x62
    1d37:	0f 85 1f 03 00 00    	jne    205c <internal_vprintf+0x91e>
													rv += putb(ctx, val, flags, width, prec);
    1d3d:	0f be 75 f4          	movsx  esi,BYTE PTR [ebp-0xc]
    1d41:	0f be 5d f5          	movsx  ebx,BYTE PTR [ebp-0xb]
    1d45:	0f be 4d f6          	movsx  ecx,BYTE PTR [ebp-0xa]
    1d49:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    1d4c:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1d4f:	89 74 24 10          	mov    DWORD PTR [esp+0x10],esi
    1d53:	89 5c 24 0c          	mov    DWORD PTR [esp+0xc],ebx
    1d57:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
    1d5b:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    1d5f:	89 04 24             	mov    DWORD PTR [esp],eax
    1d62:	e8 fc ff ff ff       	call   1d63 <internal_vprintf+0x625>
    1d67:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
									} else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'u' || *fmt == 'o' || *fmt == 'b') {
    1d6a:	e9 ed 02 00 00       	jmp    205c <internal_vprintf+0x91e>
									} else if(*fmt == 'p')/* {
    1d6f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1d72:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1d75:	3c 70                	cmp    al,0x70
    1d77:	75 43                	jne    1dbc <internal_vprintf+0x67e>
											rv += putu(ctx, (uint64_t)(uintptr_t)va_arg(args, void*), /*KFL_ZERO_PREFIX |*/ KFL_IS_HEX,
    1d79:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1d7c:	8d 50 04             	lea    edx,[eax+0x4]
    1d7f:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    1d82:	8b 00                	mov    eax,DWORD PTR [eax]
    1d84:	ba 00 00 00 00       	mov    edx,0x0
    1d89:	8b 4d c8             	mov    ecx,DWORD PTR [ebp-0x38]
    1d8c:	c7 44 24 14 08 00 00 00 	mov    DWORD PTR [esp+0x14],0x8
    1d94:	c7 44 24 10 00 00 00 00 	mov    DWORD PTR [esp+0x10],0x0
    1d9c:	c7 44 24 0c 01 00 00 00 	mov    DWORD PTR [esp+0xc],0x1
    1da4:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    1da8:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    1dac:	89 0c 24             	mov    DWORD PTR [esp],ecx
    1daf:	e8 fc ff ff ff       	call   1db0 <internal_vprintf+0x672>
    1db4:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
    1db7:	e9 a1 02 00 00       	jmp    205d <internal_vprintf+0x91f>
									else if (*fmt == 's') {
    1dbc:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1dbf:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1dc2:	3c 73                	cmp    al,0x73
    1dc4:	0f 85 29 01 00 00    	jne    1ef3 <internal_vprintf+0x7b5>
											const char* str = va_arg(args, const char*);
    1dca:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1dcd:	8d 50 04             	lea    edx,[eax+0x4]
    1dd0:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    1dd3:	8b 00                	mov    eax,DWORD PTR [eax]
    1dd5:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
											if(str) {
    1dd8:	83 7d d4 00          	cmp    DWORD PTR [ebp-0x2c],0x0
    1ddc:	0f 84 fb 00 00 00    	je     1edd <internal_vprintf+0x79f>
													size_t l = strlen(str);
    1de2:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1de5:	89 04 24             	mov    DWORD PTR [esp],eax
    1de8:	e8 fc ff ff ff       	call   1de9 <internal_vprintf+0x6ab>
    1ded:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
													if ((size_t)width > l) {
    1df0:	0f be 45 f5          	movsx  eax,BYTE PTR [ebp-0xb]
    1df4:	39 45 d0             	cmp    DWORD PTR [ebp-0x30],eax
    1df7:	73 6e                	jae    1e67 <internal_vprintf+0x729>
															if (!(flags & KFL_LEFT_ALIGN))
    1df9:	0f be 45 f6          	movsx  eax,BYTE PTR [ebp-0xa]
    1dfd:	83 e0 08             	and    eax,0x8
    1e00:	85 c0                	test   eax,eax
    1e02:	75 28                	jne    1e2c <internal_vprintf+0x6ee>
																	cputs(str);
    1e04:	8d 45 c8             	lea    eax,[ebp-0x38]
    1e07:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    1e0a:	89 14 24             	mov    DWORD PTR [esp],edx
    1e0d:	89 c1                	mov    ecx,eax
    1e0f:	e8 ec f8 ff ff       	call   1700 <cputs.0>
															while ((size_t)(width--) > l)
    1e14:	eb 16                	jmp    1e2c <internal_vprintf+0x6ee>
																	ctx->putchar(ctx, ' ');
    1e16:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1e19:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1e1c:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
    1e1f:	c7 44 24 04 20 00 00 00 	mov    DWORD PTR [esp+0x4],0x20
    1e27:	89 14 24             	mov    DWORD PTR [esp],edx
    1e2a:	ff d0                	call   eax
															while ((size_t)(width--) > l)
    1e2c:	0f b6 45 f5          	movzx  eax,BYTE PTR [ebp-0xb]
    1e30:	89 c2                	mov    edx,eax
    1e32:	83 ea 01             	sub    edx,0x1
    1e35:	88 55 f5             	mov    BYTE PTR [ebp-0xb],dl
    1e38:	0f be c0             	movsx  eax,al
    1e3b:	39 45 d0             	cmp    DWORD PTR [ebp-0x30],eax
    1e3e:	72 d6                	jb     1e16 <internal_vprintf+0x6d8>
															if (flags & KFL_LEFT_ALIGN)
    1e40:	0f be 45 f6          	movsx  eax,BYTE PTR [ebp-0xa]
    1e44:	83 e0 08             	and    eax,0x8
    1e47:	85 c0                	test   eax,eax
    1e49:	74 10                	je     1e5b <internal_vprintf+0x71d>
																	cputs(str);
    1e4b:	8d 45 c8             	lea    eax,[ebp-0x38]
    1e4e:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    1e51:	89 14 24             	mov    DWORD PTR [esp],edx
    1e54:	89 c1                	mov    ecx,eax
    1e56:	e8 a5 f8 ff ff       	call   1700 <cputs.0>
															rv += width;
    1e5b:	0f be 45 f5          	movsx  eax,BYTE PTR [ebp-0xb]
    1e5f:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
    1e62:	e9 f6 01 00 00       	jmp    205d <internal_vprintf+0x91f>
													} else if (prec && l > (size_t)prec) {
    1e67:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
    1e6b:	74 50                	je     1ebd <internal_vprintf+0x77f>
    1e6d:	0f be 45 f4          	movsx  eax,BYTE PTR [ebp-0xc]
    1e71:	3b 45 d0             	cmp    eax,DWORD PTR [ebp-0x30]
    1e74:	73 47                	jae    1ebd <internal_vprintf+0x77f>
															rv += prec;
    1e76:	0f be 45 f4          	movsx  eax,BYTE PTR [ebp-0xc]
    1e7a:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
															l = 0;
    1e7d:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [ebp-0x30],0x0
															while (l++ < (size_t)prec)
    1e84:	eb 21                	jmp    1ea7 <internal_vprintf+0x769>
																	ctx->putchar(ctx, *str++);
    1e86:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1e89:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    1e8c:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1e8f:	8d 48 01             	lea    ecx,[eax+0x1]
    1e92:	89 4d d4             	mov    DWORD PTR [ebp-0x2c],ecx
    1e95:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1e98:	0f be c8             	movsx  ecx,al
    1e9b:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1e9e:	89 4c 24 04          	mov    DWORD PTR [esp+0x4],ecx
    1ea2:	89 04 24             	mov    DWORD PTR [esp],eax
    1ea5:	ff d2                	call   edx
															while (l++ < (size_t)prec)
    1ea7:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1eaa:	8d 50 01             	lea    edx,[eax+0x1]
    1ead:	89 55 d0             	mov    DWORD PTR [ebp-0x30],edx
    1eb0:	0f be 55 f4          	movsx  edx,BYTE PTR [ebp-0xc]
    1eb4:	39 d0                	cmp    eax,edx
    1eb6:	72 ce                	jb     1e86 <internal_vprintf+0x748>
													} else if (prec && l > (size_t)prec) {
    1eb8:	e9 a0 01 00 00       	jmp    205d <internal_vprintf+0x91f>
													} else {
															rv += l;
    1ebd:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1ec0:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1ec3:	01 d0                	add    eax,edx
    1ec5:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
															cputs(str);
    1ec8:	8d 45 c8             	lea    eax,[ebp-0x38]
    1ecb:	8b 55 d4             	mov    edx,DWORD PTR [ebp-0x2c]
    1ece:	89 14 24             	mov    DWORD PTR [esp],edx
    1ed1:	89 c1                	mov    ecx,eax
    1ed3:	e8 28 f8 ff ff       	call   1700 <cputs.0>
    1ed8:	e9 80 01 00 00       	jmp    205d <internal_vprintf+0x91f>
													}
											}
											else
													cputs("(null)");
    1edd:	8d 45 c8             	lea    eax,[ebp-0x38]
    1ee0:	c7 04 24 8a 00 00 00 	mov    DWORD PTR [esp],0x8a
    1ee7:	89 c1                	mov    ecx,eax
    1ee9:	e8 12 f8 ff ff       	call   1700 <cputs.0>
    1eee:	e9 6a 01 00 00       	jmp    205d <internal_vprintf+0x91f>
									} else if (*fmt == 'c') {
    1ef3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1ef6:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1ef9:	3c 63                	cmp    al,0x63
    1efb:	75 29                	jne    1f26 <internal_vprintf+0x7e8>
											ctx->putchar(ctx, (char)va_arg(args, int));
    1efd:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1f00:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    1f03:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1f06:	8d 48 04             	lea    ecx,[eax+0x4]
    1f09:	89 4d 10             	mov    DWORD PTR [ebp+0x10],ecx
    1f0c:	8b 00                	mov    eax,DWORD PTR [eax]
    1f0e:	0f be c8             	movsx  ecx,al
    1f11:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1f14:	89 4c 24 04          	mov    DWORD PTR [esp+0x4],ecx
    1f18:	89 04 24             	mov    DWORD PTR [esp],eax
    1f1b:	ff d2                	call   edx
											rv++;
    1f1d:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
    1f21:	e9 37 01 00 00       	jmp    205d <internal_vprintf+0x91f>
									} else if (*fmt == 'f')
    1f26:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1f29:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1f2c:	3c 66                	cmp    al,0x66
    1f2e:	0f 84 29 01 00 00    	je     205d <internal_vprintf+0x91f>
											/* FPU init needed? */;
									else if (*fmt == 'n') {
    1f34:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1f37:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1f3a:	3c 6e                	cmp    al,0x6e
    1f3c:	0f 85 e3 00 00 00    	jne    2025 <internal_vprintf+0x8e7>
											if (!size)
    1f42:	80 7d f3 00          	cmp    BYTE PTR [ebp-0xd],0x0
    1f46:	75 15                	jne    1f5d <internal_vprintf+0x81f>
													*va_arg(args, int*) = (int)rv;
    1f48:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1f4b:	8d 50 04             	lea    edx,[eax+0x4]
    1f4e:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    1f51:	8b 00                	mov    eax,DWORD PTR [eax]
    1f53:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1f56:	89 10                	mov    DWORD PTR [eax],edx
    1f58:	e9 00 01 00 00       	jmp    205d <internal_vprintf+0x91f>
											else if (size == 1)
    1f5d:	80 7d f3 01          	cmp    BYTE PTR [ebp-0xd],0x1
    1f61:	75 15                	jne    1f78 <internal_vprintf+0x83a>
													*va_arg(args, signed char*) = (signed char)rv;
    1f63:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1f66:	8d 50 04             	lea    edx,[eax+0x4]
    1f69:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    1f6c:	8b 00                	mov    eax,DWORD PTR [eax]
    1f6e:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1f71:	88 10                	mov    BYTE PTR [eax],dl
    1f73:	e9 e5 00 00 00       	jmp    205d <internal_vprintf+0x91f>
											else if (size == 2)
    1f78:	80 7d f3 02          	cmp    BYTE PTR [ebp-0xd],0x2
    1f7c:	75 16                	jne    1f94 <internal_vprintf+0x856>
													*va_arg(args, short int*) = (short int)rv;
    1f7e:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1f81:	8d 50 04             	lea    edx,[eax+0x4]
    1f84:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    1f87:	8b 00                	mov    eax,DWORD PTR [eax]
    1f89:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1f8c:	66 89 10             	mov    WORD PTR [eax],dx
    1f8f:	e9 c9 00 00 00       	jmp    205d <internal_vprintf+0x91f>
											else if (size == 3)
    1f94:	80 7d f3 03          	cmp    BYTE PTR [ebp-0xd],0x3
    1f98:	75 15                	jne    1faf <internal_vprintf+0x871>
													*va_arg(args, long int*) = (long int)rv;
    1f9a:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1f9d:	8d 50 04             	lea    edx,[eax+0x4]
    1fa0:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    1fa3:	8b 00                	mov    eax,DWORD PTR [eax]
    1fa5:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1fa8:	89 10                	mov    DWORD PTR [eax],edx
    1faa:	e9 ae 00 00 00       	jmp    205d <internal_vprintf+0x91f>
											else if (size == 4)
    1faf:	80 7d f3 04          	cmp    BYTE PTR [ebp-0xd],0x4
    1fb3:	75 19                	jne    1fce <internal_vprintf+0x890>
													*va_arg(args, long long int*) = (long long int)rv;
    1fb5:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1fb8:	8d 50 04             	lea    edx,[eax+0x4]
    1fbb:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    1fbe:	8b 08                	mov    ecx,DWORD PTR [eax]
    1fc0:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1fc3:	99                   	cdq
    1fc4:	89 01                	mov    DWORD PTR [ecx],eax
    1fc6:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
    1fc9:	e9 8f 00 00 00       	jmp    205d <internal_vprintf+0x91f>
											else if (size == 5)
    1fce:	80 7d f3 05          	cmp    BYTE PTR [ebp-0xd],0x5
    1fd2:	75 16                	jne    1fea <internal_vprintf+0x8ac>
													*va_arg(args, intmax_t*) = (intmax_t)rv;
    1fd4:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1fd7:	8d 50 04             	lea    edx,[eax+0x4]
    1fda:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    1fdd:	8b 08                	mov    ecx,DWORD PTR [eax]
    1fdf:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1fe2:	99                   	cdq
    1fe3:	89 01                	mov    DWORD PTR [ecx],eax
    1fe5:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
    1fe8:	eb 73                	jmp    205d <internal_vprintf+0x91f>
											else if (size == 6)
    1fea:	80 7d f3 06          	cmp    BYTE PTR [ebp-0xd],0x6
    1fee:	75 12                	jne    2002 <internal_vprintf+0x8c4>
													*va_arg(args, ssize_t*) = (ssize_t)rv;
    1ff0:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1ff3:	8d 50 04             	lea    edx,[eax+0x4]
    1ff6:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    1ff9:	8b 00                	mov    eax,DWORD PTR [eax]
    1ffb:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1ffe:	89 10                	mov    DWORD PTR [eax],edx
    2000:	eb 5b                	jmp    205d <internal_vprintf+0x91f>
											else if (size == 7)
    2002:	80 7d f3 07          	cmp    BYTE PTR [ebp-0xd],0x7
    2006:	75 12                	jne    201a <internal_vprintf+0x8dc>
													*va_arg(args, ptrdiff_t*) = (ptrdiff_t)rv;
    2008:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    200b:	8d 50 04             	lea    edx,[eax+0x4]
    200e:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
    2011:	8b 00                	mov    eax,DWORD PTR [eax]
    2013:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    2016:	89 10                	mov    DWORD PTR [eax],edx
    2018:	eb 43                	jmp    205d <internal_vprintf+0x91f>
											else
													(void)va_arg(args, long double*);
    201a:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    201d:	83 c0 04             	add    eax,0x4
    2020:	89 45 10             	mov    DWORD PTR [ebp+0x10],eax
    2023:	eb 38                	jmp    205d <internal_vprintf+0x91f>
									} else { /* ignore */
											ctx->putchar(ctx, '%');
    2025:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    2028:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    202b:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
    202e:	c7 44 24 04 25 00 00 00 	mov    DWORD PTR [esp+0x4],0x25
    2036:	89 14 24             	mov    DWORD PTR [esp],edx
    2039:	ff d0                	call   eax
											ctx->putchar(ctx, *fmt);
    203b:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    203e:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    2041:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2044:	0f b6 12             	movzx  edx,BYTE PTR [edx]
    2047:	0f be ca             	movsx  ecx,dl
    204a:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
    204d:	89 4c 24 04          	mov    DWORD PTR [esp+0x4],ecx
    2051:	89 14 24             	mov    DWORD PTR [esp],edx
    2054:	ff d0                	call   eax
											rv += 2;
    2056:	83 45 ec 02          	add    DWORD PTR [ebp-0x14],0x2
    205a:	eb 01                	jmp    205d <internal_vprintf+0x91f>
									} else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'u' || *fmt == 'o' || *fmt == 'b') {
    205c:	90                   	nop
									}
									fmt++;
    205d:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
									is_fmt = 0;
    2061:	c6 45 f7 00          	mov    BYTE PTR [ebp-0x9],0x0
									flags = KFL_LEFT_ALIGN;
    2065:	c6 45 f6 08          	mov    BYTE PTR [ebp-0xa],0x8
									width = 0;
    2069:	c6 45 f5 00          	mov    BYTE PTR [ebp-0xb],0x0
									prec = 0;
    206d:	c6 45 f4 00          	mov    BYTE PTR [ebp-0xc],0x0
									size = 0;
    2071:	c6 45 f3 00          	mov    BYTE PTR [ebp-0xd],0x0
    2075:	eb 25                	jmp    209c <internal_vprintf+0x95e>
							} else {
									ctx->putchar(ctx, *(fmt++));
    2077:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    207a:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    207d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2080:	8d 48 01             	lea    ecx,[eax+0x1]
    2083:	89 4d 0c             	mov    DWORD PTR [ebp+0xc],ecx
    2086:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    2089:	0f be c8             	movsx  ecx,al
    208c:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    208f:	89 4c 24 04          	mov    DWORD PTR [esp+0x4],ecx
    2093:	89 04 24             	mov    DWORD PTR [esp],eax
    2096:	ff d2                	call   edx
									rv++;
    2098:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
		while (*fmt) {
    209c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    209f:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    20a2:	84 c0                	test   al,al
    20a4:	0f 85 c8 f6 ff ff    	jne    1772 <internal_vprintf+0x34>
							}
			}
		}
		return rv;
    20aa:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
}
    20ad:	83 c4 50             	add    esp,0x50
    20b0:	5b                   	pop    ebx
    20b1:	5e                   	pop    esi
    20b2:	5d                   	pop    ebp
    20b3:	c3                   	ret

000020b4 <ctx_c_putchar>:

void ctx_c_putchar(struct ivp_ctx* ctx, char c)
{
    20b4:	55                   	push   ebp
    20b5:	89 e5                	mov    ebp,esp
    20b7:	83 ec 28             	sub    esp,0x28
    20ba:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    20bd:	88 45 f4             	mov    BYTE PTR [ebp-0xc],al
		region_putchar(ctx->buf, c);
    20c0:	0f be 55 f4          	movsx  edx,BYTE PTR [ebp-0xc]
    20c4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    20c7:	8b 00                	mov    eax,DWORD PTR [eax]
    20c9:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    20cd:	89 04 24             	mov    DWORD PTR [esp],eax
    20d0:	e8 fc ff ff ff       	call   20d1 <ctx_c_putchar+0x1d>
}
    20d5:	90                   	nop
    20d6:	c9                   	leave
    20d7:	c3                   	ret

000020d8 <ctx_s_putchar>:

void ctx_s_putchar(struct ivp_ctx* ctx, char c)
{
    20d8:	55                   	push   ebp
    20d9:	89 e5                	mov    ebp,esp
    20db:	83 ec 04             	sub    esp,0x4
    20de:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    20e1:	88 45 fc             	mov    BYTE PTR [ebp-0x4],al
		if (ctx->buf) {
    20e4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    20e7:	8b 00                	mov    eax,DWORD PTR [eax]
    20e9:	85 c0                	test   eax,eax
    20eb:	74 37                	je     2124 <ctx_s_putchar+0x4c>
				if (!ctx->n) {
    20ed:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    20f0:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    20f3:	85 c0                	test   eax,eax
    20f5:	75 0b                	jne    2102 <ctx_s_putchar+0x2a>
						ctx->buf = NULL;
    20f7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    20fa:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
						return;
    2100:	eb 22                	jmp    2124 <ctx_s_putchar+0x4c>
				}
				*ctx->buf++ = c;
    2102:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2105:	8b 00                	mov    eax,DWORD PTR [eax]
    2107:	8d 48 01             	lea    ecx,[eax+0x1]
    210a:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    210d:	89 0a                	mov    DWORD PTR [edx],ecx
    210f:	0f b6 55 fc          	movzx  edx,BYTE PTR [ebp-0x4]
    2113:	88 10                	mov    BYTE PTR [eax],dl
				ctx->n--;
    2115:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2118:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    211b:	8d 50 ff             	lea    edx,[eax-0x1]
    211e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2121:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		}
}
    2124:	c9                   	leave
    2125:	c3                   	ret

00002126 <vrprintf>:

int vrprintf(struct kio_region* cr, const char* fmt, va_list args)
{
    2126:	55                   	push   ebp
    2127:	89 e5                	mov    ebp,esp
    2129:	83 ec 28             	sub    esp,0x28
		int rv;
		struct ivp_ctx ct = {cr, 0, &ctx_c_putchar};
    212c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    212f:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    2132:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
    2139:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
		rv = internal_vprintf(&ct, fmt, args);
    2140:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    2143:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2147:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    214a:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    214e:	8d 45 e8             	lea    eax,[ebp-0x18]
    2151:	89 04 24             	mov    DWORD PTR [esp],eax
    2154:	e8 fc ff ff ff       	call   2155 <vrprintf+0x2f>
    2159:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		return rv;
    215c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    215f:	c9                   	leave
    2160:	c3                   	ret

00002161 <vprintf>:

int vprintf(const char* fmt, va_list args)
{
    2161:	55                   	push   ebp
    2162:	89 e5                	mov    ebp,esp
    2164:	83 ec 28             	sub    esp,0x28
		int rv;
		struct ivp_ctx ct = {&reg_def, 0, &ctx_c_putchar};
    2167:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
    216e:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
    2175:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
		rv = internal_vprintf(&ct, fmt, args);
    217c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    217f:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2183:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2186:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    218a:	8d 45 e8             	lea    eax,[ebp-0x18]
    218d:	89 04 24             	mov    DWORD PTR [esp],eax
    2190:	e8 fc ff ff ff       	call   2191 <vprintf+0x30>
    2195:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		return rv;
    2198:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    219b:	c9                   	leave
    219c:	c3                   	ret

0000219d <rprintf>:

/* with region ptr, region has lock & spin_trylock & lock-free add-buffer
  & malloc in irq question */
int rprintf(struct kio_region* cr, const char* fmt, ...)
{
    219d:	55                   	push   ebp
    219e:	89 e5                	mov    ebp,esp
    21a0:	83 ec 28             	sub    esp,0x28
		int rv;
		va_list args;
		va_start(args, fmt);
    21a3:	8d 45 10             	lea    eax,[ebp+0x10]
    21a6:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		rv = vrprintf(cr, fmt, args);
    21a9:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    21ac:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    21b0:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    21b3:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    21b7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    21ba:	89 04 24             	mov    DWORD PTR [esp],eax
    21bd:	e8 fc ff ff ff       	call   21be <rprintf+0x21>
    21c2:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		va_end(args);
		return rv;
    21c5:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    21c8:	c9                   	leave
    21c9:	c3                   	ret

000021ca <crprintf>:

int crprintf(char col, struct kio_region* cr, const char* fmt, ...)
{
    21ca:	55                   	push   ebp
    21cb:	89 e5                	mov    ebp,esp
    21cd:	83 ec 38             	sub    esp,0x38
    21d0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    21d3:	88 45 e4             	mov    BYTE PTR [ebp-0x1c],al
		int rv; char cf = cr->fmt;
    21d6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    21d9:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    21dd:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
		va_list args;
		va_start(args, fmt);
    21e0:	8d 45 14             	lea    eax,[ebp+0x14]
    21e3:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		cr->fmt = col;
    21e6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    21e9:	0f b6 55 e4          	movzx  edx,BYTE PTR [ebp-0x1c]
    21ed:	88 50 0c             	mov    BYTE PTR [eax+0xc],dl
		rv = vrprintf(cr, fmt, args);
    21f0:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    21f3:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    21f7:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    21fa:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    21fe:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2201:	89 04 24             	mov    DWORD PTR [esp],eax
    2204:	e8 fc ff ff ff       	call   2205 <crprintf+0x3b>
    2209:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		cr->fmt = cf;
    220c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    220f:	0f b6 55 f7          	movzx  edx,BYTE PTR [ebp-0x9]
    2213:	88 50 0c             	mov    BYTE PTR [eax+0xc],dl
		va_end(args);
		return rv;
    2216:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
}
    2219:	c9                   	leave
    221a:	c3                   	ret

0000221b <cprintf>:

int cprintf(char col, const char* fmt, ...)
{
    221b:	55                   	push   ebp
    221c:	89 e5                	mov    ebp,esp
    221e:	83 ec 38             	sub    esp,0x38
    2221:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2224:	88 45 e4             	mov    BYTE PTR [ebp-0x1c],al
		int rv; char cf = reg_def.fmt;
    2227:	0f b6 05 0c 00 00 00 	movzx  eax,BYTE PTR ds:0xc
    222e:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
		va_list args;
		va_start(args, fmt);
    2231:	8d 45 10             	lea    eax,[ebp+0x10]
    2234:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		reg_def.fmt = col;
    2237:	0f b6 45 e4          	movzx  eax,BYTE PTR [ebp-0x1c]
    223b:	a2 0c 00 00 00       	mov    ds:0xc,al
		rv = vprintf(fmt, args);
    2240:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    2243:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2247:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    224a:	89 04 24             	mov    DWORD PTR [esp],eax
    224d:	e8 fc ff ff ff       	call   224e <cprintf+0x33>
    2252:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		reg_def.fmt = cf;
    2255:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
    2259:	a2 0c 00 00 00       	mov    ds:0xc,al
		va_end(args);
		return rv;
    225e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
}
    2261:	c9                   	leave
    2262:	c3                   	ret

00002263 <vsprintf>:

int vsprintf(char* str, const char* fmt, va_list args)
{
    2263:	55                   	push   ebp
    2264:	89 e5                	mov    ebp,esp
    2266:	83 ec 28             	sub    esp,0x28
		struct ivp_ctx ct = {str, 0xffffffff, &ctx_s_putchar};
    2269:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    226c:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    226f:	c7 45 f0 ff ff ff ff 	mov    DWORD PTR [ebp-0x10],0xffffffff
    2276:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		return internal_vprintf(&ct, fmt, args);
    227d:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    2280:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2284:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2287:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    228b:	8d 45 ec             	lea    eax,[ebp-0x14]
    228e:	89 04 24             	mov    DWORD PTR [esp],eax
    2291:	e8 fc ff ff ff       	call   2292 <vsprintf+0x2f>
}
    2296:	c9                   	leave
    2297:	c3                   	ret

00002298 <sprintf>:

int sprintf(char* str, const char* fmt, ...)
{
    2298:	55                   	push   ebp
    2299:	89 e5                	mov    ebp,esp
    229b:	83 ec 28             	sub    esp,0x28
		int rv;
		va_list args;
		va_start(args, fmt);
    229e:	8d 45 10             	lea    eax,[ebp+0x10]
    22a1:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		rv = vsprintf(str, fmt, args);
    22a4:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    22a7:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    22ab:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    22ae:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    22b2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    22b5:	89 04 24             	mov    DWORD PTR [esp],eax
    22b8:	e8 fc ff ff ff       	call   22b9 <sprintf+0x21>
    22bd:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		va_end(args);
		return rv;
    22c0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    22c3:	c9                   	leave
    22c4:	c3                   	ret

000022c5 <vsnprintf>:

int vsnprintf(char* str, size_t n, const char* fmt, va_list args)
{
    22c5:	55                   	push   ebp
    22c6:	89 e5                	mov    ebp,esp
    22c8:	83 ec 28             	sub    esp,0x28
		struct ivp_ctx ct = {str, n, &ctx_s_putchar};
    22cb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    22ce:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    22d1:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    22d4:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    22d7:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		return internal_vprintf(&ct, fmt, args);
    22de:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    22e1:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    22e5:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    22e8:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    22ec:	8d 45 ec             	lea    eax,[ebp-0x14]
    22ef:	89 04 24             	mov    DWORD PTR [esp],eax
    22f2:	e8 fc ff ff ff       	call   22f3 <vsnprintf+0x2e>
}
    22f7:	c9                   	leave
    22f8:	c3                   	ret

000022f9 <snprintf>:

int snprintf(char* str, size_t n, const char* fmt, ...)
{
    22f9:	55                   	push   ebp
    22fa:	89 e5                	mov    ebp,esp
    22fc:	83 ec 28             	sub    esp,0x28
		int rv;
		va_list args;
		va_start(args, fmt);
    22ff:	8d 45 14             	lea    eax,[ebp+0x14]
    2302:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		rv = vsnprintf(str, n, fmt, args);
    2305:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2308:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    230c:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    230f:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    2313:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2316:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    231a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    231d:	89 04 24             	mov    DWORD PTR [esp],eax
    2320:	e8 fc ff ff ff       	call   2321 <snprintf+0x28>
    2325:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		va_end(args);
		return rv;
    2328:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    232b:	c9                   	leave
    232c:	c3                   	ret

0000232d <printf>:

int printf(const char* fmt, ...)
{
    232d:	55                   	push   ebp
    232e:	89 e5                	mov    ebp,esp
    2330:	83 ec 28             	sub    esp,0x28
		int rv;
		va_list args;
		va_start(args, fmt);
    2333:	8d 45 0c             	lea    eax,[ebp+0xc]
    2336:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		rv = vprintf(fmt, args);
    2339:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    233c:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2340:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2343:	89 04 24             	mov    DWORD PTR [esp],eax
    2346:	e8 fc ff ff ff       	call   2347 <printf+0x1a>
    234b:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		va_end(args);
		return rv;
    234e:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    2351:	c9                   	leave
    2352:	c3                   	ret

00002353 <iprintf>:
/* no delay intr version */
int iprintf(const char* fmt, ...)
{
    2353:	55                   	push   ebp
    2354:	89 e5                	mov    ebp,esp
    2356:	83 ec 28             	sub    esp,0x28
		int rv;
		va_list args;
		va_start(args, fmt);
    2359:	8d 45 0c             	lea    eax,[ebp+0xc]
    235c:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		reg_def.flags |= KIO_REGION_NO_DELAY;
    235f:	0f b6 05 0d 00 00 00 	movzx  eax,BYTE PTR ds:0xd
    2366:	83 c8 01             	or     eax,0x1
    2369:	a2 0d 00 00 00       	mov    ds:0xd,al
		rv = vprintf(fmt, args);
    236e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2371:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    2375:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2378:	89 04 24             	mov    DWORD PTR [esp],eax
    237b:	e8 fc ff ff ff       	call   237c <iprintf+0x29>
    2380:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		reg_def.flags &= ~KIO_REGION_NO_DELAY;
    2383:	0f b6 05 0d 00 00 00 	movzx  eax,BYTE PTR ds:0xd
    238a:	83 e0 fe             	and    eax,0xfffffffe
    238d:	a2 0d 00 00 00       	mov    ds:0xd,al
		va_end(args);
		return rv;
    2392:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    2395:	c9                   	leave
    2396:	c3                   	ret

00002397 <noprintf>:
int noprintf(const char* c, ...) { (void)c; return 0; }
    2397:	55                   	push   ebp
    2398:	89 e5                	mov    ebp,esp
    239a:	b8 00 00 00 00       	mov    eax,0x0
    239f:	5d                   	pop    ebp
    23a0:	c3                   	ret

000023a1 <memdump>:

void memdump(void* ofs, size_t sz)
{
    23a1:	55                   	push   ebp
    23a2:	89 e5                	mov    ebp,esp
    23a4:	83 ec 38             	sub    esp,0x38
		size_t i, ct;

		printf("dumping memory at %p with size %u:\n", ofs, sz);
    23a7:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    23aa:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    23ae:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    23b1:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    23b5:	c7 04 24 94 00 00 00 	mov    DWORD PTR [esp],0x94
    23bc:	e8 fc ff ff ff       	call   23bd <memdump+0x1c>
		for (i = 0; i < sz; i += 16) {
    23c1:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    23c8:	e9 4d 01 00 00       	jmp    251a <memdump+0x179>
				uint16_t* mem = (uint16_t*)(ofs + i);
    23cd:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    23d0:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    23d3:	01 d0                	add    eax,edx
    23d5:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				uint8_t nbl = 41; /* 41 blanks until text output */
    23d8:	c6 45 ef 29          	mov    BYTE PTR [ebp-0x11],0x29
				/* xxd-style output: 8 words and text */
				for (ct = 0; ct < 8; ct++) {
    23dc:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    23e3:	e9 97 00 00 00       	jmp    247f <memdump+0xde>
						if (i + 2 * ct <= sz - 2) {
    23e8:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    23eb:	8d 14 00             	lea    edx,[eax+eax*1]
    23ee:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    23f1:	01 d0                	add    eax,edx
    23f3:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    23f6:	83 ea 02             	sub    edx,0x2
    23f9:	39 c2                	cmp    edx,eax
    23fb:	72 44                	jb     2441 <memdump+0xa0>
								printf("%04x ", ((mem[ct] << 8) & 0xff00) | (mem[ct] >> 8));
    23fd:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2400:	8d 14 00             	lea    edx,[eax+eax*1]
    2403:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    2406:	01 d0                	add    eax,edx
    2408:	0f b7 00             	movzx  eax,WORD PTR [eax]
    240b:	0f b7 c0             	movzx  eax,ax
    240e:	c1 e0 08             	shl    eax,0x8
    2411:	0f b7 d0             	movzx  edx,ax
    2414:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2417:	8d 0c 00             	lea    ecx,[eax+eax*1]
    241a:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    241d:	01 c8                	add    eax,ecx
    241f:	0f b7 00             	movzx  eax,WORD PTR [eax]
    2422:	66 c1 e8 08          	shr    ax,0x8
    2426:	0f b7 c0             	movzx  eax,ax
    2429:	09 d0                	or     eax,edx
    242b:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    242f:	c7 04 24 b8 00 00 00 	mov    DWORD PTR [esp],0xb8
    2436:	e8 fc ff ff ff       	call   2437 <memdump+0x96>
								nbl -= 5;
    243b:	80 6d ef 05          	sub    BYTE PTR [ebp-0x11],0x5
    243f:	eb 3a                	jmp    247b <memdump+0xda>
						} else if (i + 2 * ct == sz - 1) { /* ending on half word */
    2441:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2444:	8d 14 00             	lea    edx,[eax+eax*1]
    2447:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    244a:	01 c2                	add    edx,eax
    244c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    244f:	83 e8 01             	sub    eax,0x1
    2452:	39 c2                	cmp    edx,eax
    2454:	75 35                	jne    248b <memdump+0xea>
								printf("%02x   ", *(uint8_t*)(mem + ct));
    2456:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2459:	8d 14 00             	lea    edx,[eax+eax*1]
    245c:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    245f:	01 d0                	add    eax,edx
    2461:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    2464:	0f b6 c0             	movzx  eax,al
    2467:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    246b:	c7 04 24 be 00 00 00 	mov    DWORD PTR [esp],0xbe
    2472:	e8 fc ff ff ff       	call   2473 <memdump+0xd2>
								nbl -= 5;
    2477:	80 6d ef 05          	sub    BYTE PTR [ebp-0x11],0x5
				for (ct = 0; ct < 8; ct++) {
    247b:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
    247f:	83 7d f0 07          	cmp    DWORD PTR [ebp-0x10],0x7
    2483:	0f 86 5f ff ff ff    	jbe    23e8 <memdump+0x47>
    2489:	eb 0f                	jmp    249a <memdump+0xf9>
						} else
								break;
    248b:	90                   	nop
				}
				/* fill with blanks */
				while (nbl--)
    248c:	eb 0c                	jmp    249a <memdump+0xf9>
						putchar(' ');
    248e:	c7 04 24 20 00 00 00 	mov    DWORD PTR [esp],0x20
    2495:	e8 fc ff ff ff       	call   2496 <memdump+0xf5>
				while (nbl--)
    249a:	0f b6 45 ef          	movzx  eax,BYTE PTR [ebp-0x11]
    249e:	8d 50 ff             	lea    edx,[eax-0x1]
    24a1:	88 55 ef             	mov    BYTE PTR [ebp-0x11],dl
    24a4:	84 c0                	test   al,al
    24a6:	75 e6                	jne    248e <memdump+0xed>
				/* output the text */
				for (ct = 0; ct < 16; ct++) {
    24a8:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    24af:	eb 50                	jmp    2501 <memdump+0x160>
						char* c = (char*)mem + ct;
    24b1:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    24b4:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    24b7:	01 d0                	add    eax,edx
    24b9:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
						if (i + ct >= sz)
    24bc:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    24bf:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    24c2:	01 d0                	add    eax,edx
    24c4:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
    24c7:	73 40                	jae    2509 <memdump+0x168>
								break;
						if (isprint(*c))
    24c9:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    24cc:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    24cf:	0f be c0             	movsx  eax,al
    24d2:	89 04 24             	mov    DWORD PTR [esp],eax
    24d5:	e8 fc ff ff ff       	call   24d6 <memdump+0x135>
    24da:	85 c0                	test   eax,eax
    24dc:	74 13                	je     24f1 <memdump+0x150>
								putchar(*c);
    24de:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    24e1:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    24e4:	0f be c0             	movsx  eax,al
    24e7:	89 04 24             	mov    DWORD PTR [esp],eax
    24ea:	e8 fc ff ff ff       	call   24eb <memdump+0x14a>
    24ef:	eb 0c                	jmp    24fd <memdump+0x15c>
						else
								putchar('.');
    24f1:	c7 04 24 2e 00 00 00 	mov    DWORD PTR [esp],0x2e
    24f8:	e8 fc ff ff ff       	call   24f9 <memdump+0x158>
				for (ct = 0; ct < 16; ct++) {
    24fd:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
    2501:	83 7d f0 0f          	cmp    DWORD PTR [ebp-0x10],0xf
    2505:	76 aa                	jbe    24b1 <memdump+0x110>
    2507:	eb 01                	jmp    250a <memdump+0x169>
								break;
    2509:	90                   	nop
				}
				putchar('\n');
    250a:	c7 04 24 0a 00 00 00 	mov    DWORD PTR [esp],0xa
    2511:	e8 fc ff ff ff       	call   2512 <memdump+0x171>
		for (i = 0; i < sz; i += 16) {
    2516:	83 45 f4 10          	add    DWORD PTR [ebp-0xc],0x10
    251a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    251d:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
    2520:	0f 82 a7 fe ff ff    	jb     23cd <memdump+0x2c>
		}
}
    2526:	90                   	nop
    2527:	90                   	nop
    2528:	c9                   	leave
    2529:	c3                   	ret
