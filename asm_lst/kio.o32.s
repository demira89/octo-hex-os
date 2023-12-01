
kio.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <memcpy>:
				unsigned int bt = (arg & 0x80000000);
				rv++;
				if (bt) {
						nonz = 1;
						ctx->putchar(ctx, '1');
				} else if (nonz)
       0:	55                   	push   ebp
       1:	89 e5                	mov    ebp,esp
       3:	83 ec 10             	sub    esp,0x10
						ctx->putchar(ctx, '0');
       6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
       9:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
				else if ((32 - i) <= prec) /* has precedence over with */
       c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
       f:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
						ctx->putchar(ctx, '0');
      12:	eb 17                	jmp    2b <memcpy+0x2b>
				else if ((32 - i) <= width)
      14:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
      17:	8d 42 01             	lea    eax,[edx+0x1]
      1a:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
      1d:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
      20:	8d 48 01             	lea    ecx,[eax+0x1]
      23:	89 4d fc             	mov    DWORD PTR [ebp-0x4],ecx
      26:	0f b6 12             	movzx  edx,BYTE PTR [edx]
      29:	88 10                	mov    BYTE PTR [eax],dl
						ctx->putchar(ctx, '0');
      2b:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
      2e:	8d 50 ff             	lea    edx,[eax-0x1]
      31:	89 55 10             	mov    DWORD PTR [ebp+0x10],edx
      34:	85 c0                	test   eax,eax
      36:	75 dc                	jne    14 <memcpy+0x14>
						ctx->putchar(ctx, flags & KFL_ZERO_PREFIX ? '0' : ' ');
      38:	90                   	nop
      39:	90                   	nop
      3a:	c9                   	leave
      3b:	c3                   	ret

0000003c <kio_fb_resize>:
{
      3c:	55                   	push   ebp
      3d:	89 e5                	mov    ebp,esp
      3f:	83 ec 08             	sub    esp,0x8
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
      6b:	83 ec 08             	sub    esp,0x8
      6e:	52                   	push   edx
      6f:	50                   	push   eax
      70:	e8 fc ff ff ff       	call   71 <kio_fb_resize+0x35>
      75:	83 c4 10             	add    esp,0x10
}
      78:	90                   	nop
      79:	c9                   	leave
      7a:	c3                   	ret

0000007b <getc_pr>:
{
      7b:	55                   	push   ebp
      7c:	89 e5                	mov    ebp,esp
      7e:	83 ec 08             	sub    esp,0x8
      81:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
      84:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
      87:	66 89 55 fc          	mov    WORD PTR [ebp-0x4],dx
      8b:	66 89 45 f8          	mov    WORD PTR [ebp-0x8],ax
		if (x < cr->lx && y < cr->ly) {
      8f:	0f b7 55 fc          	movzx  edx,WORD PTR [ebp-0x4]
      93:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      96:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
      9a:	98                   	cwde
      9b:	39 c2                	cmp    edx,eax
      9d:	7d 46                	jge    e5 <getc_pr+0x6a>
      9f:	0f b7 55 f8          	movzx  edx,WORD PTR [ebp-0x8]
      a3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      a6:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
      aa:	98                   	cwde
      ab:	39 c2                	cmp    edx,eax
      ad:	7d 36                	jge    e5 <getc_pr+0x6a>
				x += cr->x;
      af:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      b2:	0f b7 00             	movzx  eax,WORD PTR [eax]
      b5:	66 01 45 fc          	add    WORD PTR [ebp-0x4],ax
				y += cr->y;
      b9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
      bc:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
      c0:	66 01 45 f8          	add    WORD PTR [ebp-0x8],ax
				return ((char*)fb_initial.text_mem)[2 * (y * fb_initial.width + x)];
      c4:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
      ca:	0f b7 55 f8          	movzx  edx,WORD PTR [ebp-0x8]
      ce:	a1 04 00 00 00       	mov    eax,ds:0x4
      d3:	0f af d0             	imul   edx,eax
      d6:	0f b7 45 fc          	movzx  eax,WORD PTR [ebp-0x4]
      da:	01 d0                	add    eax,edx
      dc:	01 c0                	add    eax,eax
      de:	01 c8                	add    eax,ecx
      e0:	0f b6 00             	movzx  eax,BYTE PTR [eax]
      e3:	eb 05                	jmp    ea <getc_pr+0x6f>
				return 0;
      e5:	b8 00 00 00 00       	mov    eax,0x0
}
      ea:	c9                   	leave
      eb:	c3                   	ret

000000ec <putc_pr>:
{
      ec:	55                   	push   ebp
      ed:	89 e5                	mov    ebp,esp
      ef:	83 ec 38             	sub    esp,0x38
      f2:	8b 4d 0c             	mov    ecx,DWORD PTR [ebp+0xc]
      f5:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
      f8:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
      fb:	88 4d d4             	mov    BYTE PTR [ebp-0x2c],cl
      fe:	66 89 55 d0          	mov    WORD PTR [ebp-0x30],dx
     102:	66 89 45 cc          	mov    WORD PTR [ebp-0x34],ax
		if (x < cr->lx && y < cr->ly) { /* don't corrupt memory */
     106:	0f b7 55 d0          	movzx  edx,WORD PTR [ebp-0x30]
     10a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     10d:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
     111:	98                   	cwde
     112:	39 c2                	cmp    edx,eax
     114:	0f 8d fa 00 00 00    	jge    214 <putc_pr+0x128>
     11a:	0f b7 55 cc          	movzx  edx,WORD PTR [ebp-0x34]
     11e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     121:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
     125:	98                   	cwde
     126:	39 c2                	cmp    edx,eax
     128:	0f 8d e6 00 00 00    	jge    214 <putc_pr+0x128>
				x += cr->x;
     12e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     131:	0f b7 00             	movzx  eax,WORD PTR [eax]
     134:	66 01 45 d0          	add    WORD PTR [ebp-0x30],ax
				y += cr->y;
     138:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     13b:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
     13f:	66 01 45 cc          	add    WORD PTR [ebp-0x34],ax
				if (x >= fb_initial.width || y >= fb_initial.height)
     143:	0f b7 55 d0          	movzx  edx,WORD PTR [ebp-0x30]
     147:	a1 04 00 00 00       	mov    eax,ds:0x4
     14c:	39 c2                	cmp    edx,eax
     14e:	0f 8d bf 00 00 00    	jge    213 <putc_pr+0x127>
     154:	0f b7 55 cc          	movzx  edx,WORD PTR [ebp-0x34]
     158:	a1 08 00 00 00       	mov    eax,ds:0x8
     15d:	39 c2                	cmp    edx,eax
     15f:	0f 8d ae 00 00 00    	jge    213 <putc_pr+0x127>
				p1 = &((char*)fb_initial.text_mem)[2 * (y * fb_initial.width + x)];
     165:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
     16b:	0f b7 55 cc          	movzx  edx,WORD PTR [ebp-0x34]
     16f:	a1 04 00 00 00       	mov    eax,ds:0x4
     174:	0f af d0             	imul   edx,eax
     177:	0f b7 45 d0          	movzx  eax,WORD PTR [ebp-0x30]
     17b:	01 d0                	add    eax,edx
     17d:	01 c0                	add    eax,eax
     17f:	01 c8                	add    eax,ecx
     181:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				p2 = &((char*)fb_initial.text_mem)[2 * (y * fb_initial.width + x) + 1];
     184:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
     18a:	0f b7 55 cc          	movzx  edx,WORD PTR [ebp-0x34]
     18e:	a1 04 00 00 00       	mov    eax,ds:0x4
     193:	0f af d0             	imul   edx,eax
     196:	0f b7 45 d0          	movzx  eax,WORD PTR [ebp-0x30]
     19a:	01 d0                	add    eax,edx
     19c:	01 c0                	add    eax,eax
     19e:	83 c0 01             	add    eax,0x1
     1a1:	01 c8                	add    eax,ecx
     1a3:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				if (*p1 != c || *p2 != cr->fmt) {
     1a6:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     1a9:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     1ac:	38 45 d4             	cmp    BYTE PTR [ebp-0x2c],al
     1af:	75 11                	jne    1c2 <putc_pr+0xd6>
     1b1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     1b4:	0f b6 10             	movzx  edx,BYTE PTR [eax]
     1b7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1ba:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
     1be:	38 c2                	cmp    dl,al
     1c0:	74 52                	je     214 <putc_pr+0x128>
						*p1 = c;
     1c2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     1c5:	0f b6 55 d4          	movzx  edx,BYTE PTR [ebp-0x2c]
     1c9:	88 10                	mov    BYTE PTR [eax],dl
						*p2 = cr->fmt;
     1cb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1ce:	0f b6 50 0c          	movzx  edx,BYTE PTR [eax+0xc]
     1d2:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
     1d5:	88 10                	mov    BYTE PTR [eax],dl
						r.x = x;
     1d7:	0f b7 45 d0          	movzx  eax,WORD PTR [ebp-0x30]
     1db:	66 89 45 dc          	mov    WORD PTR [ebp-0x24],ax
						r.y = y;
     1df:	0f b7 45 cc          	movzx  eax,WORD PTR [ebp-0x34]
     1e3:	66 89 45 de          	mov    WORD PTR [ebp-0x22],ax
						r.lx = 1;
     1e7:	66 c7 45 e0 01 00    	mov    WORD PTR [ebp-0x20],0x1
						r.ly = 1;
     1ed:	66 c7 45 e2 01 00    	mov    WORD PTR [ebp-0x1e],0x1
						r.fmt = cr->fmt;
     1f3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     1f6:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
     1fa:	88 45 e8             	mov    BYTE PTR [ebp-0x18],al
						framebuffer_update_region(&fb_initial, &r);
     1fd:	83 ec 08             	sub    esp,0x8
     200:	8d 45 dc             	lea    eax,[ebp-0x24]
     203:	50                   	push   eax
     204:	68 00 00 00 00       	push   0x0
     209:	e8 fc ff ff ff       	call   20a <putc_pr+0x11e>
     20e:	83 c4 10             	add    esp,0x10
     211:	eb 01                	jmp    214 <putc_pr+0x128>
						return;
     213:	90                   	nop
}
     214:	c9                   	leave
     215:	c3                   	ret

00000216 <putc_prc>:
{
     216:	55                   	push   ebp
     217:	89 e5                	mov    ebp,esp
     219:	53                   	push   ebx
     21a:	83 ec 24             	sub    esp,0x24
     21d:	8b 5d 0c             	mov    ebx,DWORD PTR [ebp+0xc]
     220:	8b 4d 10             	mov    ecx,DWORD PTR [ebp+0x10]
     223:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
     226:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     229:	88 5d e4             	mov    BYTE PTR [ebp-0x1c],bl
     22c:	88 4d e0             	mov    BYTE PTR [ebp-0x20],cl
     22f:	66 89 55 dc          	mov    WORD PTR [ebp-0x24],dx
     233:	66 89 45 d8          	mov    WORD PTR [ebp-0x28],ax
		char f = cr->fmt;
     237:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     23a:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
     23e:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
		cr->fmt = fmt;
     241:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     244:	0f b6 55 e4          	movzx  edx,BYTE PTR [ebp-0x1c]
     248:	88 50 0c             	mov    BYTE PTR [eax+0xc],dl
		putc_pr(cr, c, x, y);
     24b:	0f b7 4d d8          	movzx  ecx,WORD PTR [ebp-0x28]
     24f:	0f b7 55 dc          	movzx  edx,WORD PTR [ebp-0x24]
     253:	0f be 45 e0          	movsx  eax,BYTE PTR [ebp-0x20]
     257:	51                   	push   ecx
     258:	52                   	push   edx
     259:	50                   	push   eax
     25a:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     25d:	e8 fc ff ff ff       	call   25e <putc_prc+0x48>
     262:	83 c4 10             	add    esp,0x10
		cr->fmt = f;
     265:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     268:	0f b6 55 f7          	movzx  edx,BYTE PTR [ebp-0x9]
     26c:	88 50 0c             	mov    BYTE PTR [eax+0xc],dl
}
     26f:	90                   	nop
     270:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     273:	c9                   	leave
     274:	c3                   	ret

00000275 <region_clear>:
{
     275:	55                   	push   ebp
     276:	89 e5                	mov    ebp,esp
     278:	83 ec 08             	sub    esp,0x8
		framebuffer_clear_region(&fb_initial, cr);
     27b:	83 ec 08             	sub    esp,0x8
     27e:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     281:	68 00 00 00 00       	push   0x0
     286:	e8 fc ff ff ff       	call   287 <region_clear+0x12>
     28b:	83 c4 10             	add    esp,0x10
}
     28e:	90                   	nop
     28f:	c9                   	leave
     290:	c3                   	ret

00000291 <scroll_buffer>:
{
     291:	55                   	push   ebp
     292:	89 e5                	mov    ebp,esp
     294:	83 ec 08             	sub    esp,0x8
		framebuffer_scroll_region(&fb_initial, cr, 0, 1);
     297:	6a 01                	push   0x1
     299:	6a 00                	push   0x0
     29b:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     29e:	68 00 00 00 00       	push   0x0
     2a3:	e8 fc ff ff ff       	call   2a4 <scroll_buffer+0x13>
     2a8:	83 c4 10             	add    esp,0x10
		if (!(cr->flags & KIO_REGION_NO_DELAY)) {
     2ab:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     2ae:	0f b6 40 0d          	movzx  eax,BYTE PTR [eax+0xd]
     2b2:	0f be c0             	movsx  eax,al
     2b5:	83 e0 01             	and    eax,0x1
     2b8:	85 c0                	test   eax,eax
     2ba:	75 1b                	jne    2d7 <scroll_buffer+0x46>
			mdelay(50);
     2bc:	83 ec 0c             	sub    esp,0xc
     2bf:	6a 32                	push   0x32
     2c1:	e8 fc ff ff ff       	call   2c2 <scroll_buffer+0x31>
     2c6:	83 c4 10             	add    esp,0x10
			while (cur_brk)
     2c9:	eb 01                	jmp    2cc <scroll_buffer+0x3b>
					__asm__("hlt");
     2cb:	f4                   	hlt
			while (cur_brk)
     2cc:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
     2d3:	84 c0                	test   al,al
     2d5:	75 f4                	jne    2cb <scroll_buffer+0x3a>
}
     2d7:	90                   	nop
     2d8:	c9                   	leave
     2d9:	c3                   	ret

000002da <scroll_left>:
{
     2da:	55                   	push   ebp
     2db:	89 e5                	mov    ebp,esp
     2dd:	56                   	push   esi
     2de:	53                   	push   ebx
     2df:	83 ec 20             	sub    esp,0x20
		r.y = cr->y + cr->cur_y;
     2e2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     2e5:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
     2e9:	89 c2                	mov    edx,eax
     2eb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     2ee:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     2f2:	01 d0                	add    eax,edx
     2f4:	66 89 45 e6          	mov    WORD PTR [ebp-0x1a],ax
		r.x = cr->x;
     2f8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     2fb:	0f b7 00             	movzx  eax,WORD PTR [eax]
     2fe:	66 89 45 e4          	mov    WORD PTR [ebp-0x1c],ax
		r.ly = 1;
     302:	66 c7 45 ea 01 00    	mov    WORD PTR [ebp-0x16],0x1
		r.lx = cr->lx;
     308:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     30b:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
     30f:	66 89 45 e8          	mov    WORD PTR [ebp-0x18],ax
						(cr->lx - 1) * 2);
     313:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     316:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
     31a:	98                   	cwde
     31b:	83 e8 01             	sub    eax,0x1
     31e:	01 c0                	add    eax,eax
		memcpy((char*)fb_initial.text_mem + r.y * fb_initial.width * 2 + r.x * 2,
     320:	89 c6                	mov    esi,eax
						(char*)fb_initial.text_mem + r.y * fb_initial.width * 2 + r.x * 2 + 2,
     322:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR ds:0x0
     328:	0f b7 45 e6          	movzx  eax,WORD PTR [ebp-0x1a]
     32c:	0f bf d0             	movsx  edx,ax
     32f:	a1 04 00 00 00       	mov    eax,ds:0x4
     334:	0f af c2             	imul   eax,edx
     337:	01 c0                	add    eax,eax
     339:	89 c2                	mov    edx,eax
     33b:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
     33f:	98                   	cwde
     340:	01 c0                	add    eax,eax
     342:	01 d0                	add    eax,edx
     344:	83 c0 02             	add    eax,0x2
		memcpy((char*)fb_initial.text_mem + r.y * fb_initial.width * 2 + r.x * 2,
     347:	01 c1                	add    ecx,eax
     349:	8b 1d 00 00 00 00    	mov    ebx,DWORD PTR ds:0x0
     34f:	0f b7 45 e6          	movzx  eax,WORD PTR [ebp-0x1a]
     353:	0f bf d0             	movsx  edx,ax
     356:	a1 04 00 00 00       	mov    eax,ds:0x4
     35b:	0f af c2             	imul   eax,edx
     35e:	01 c0                	add    eax,eax
     360:	89 c2                	mov    edx,eax
     362:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
     366:	98                   	cwde
     367:	01 c0                	add    eax,eax
     369:	01 d0                	add    eax,edx
     36b:	01 d8                	add    eax,ebx
     36d:	56                   	push   esi
     36e:	51                   	push   ecx
     36f:	50                   	push   eax
     370:	e8 8b fc ff ff       	call   0 <memcpy>
     375:	83 c4 0c             	add    esp,0xc
		framebuffer_update_region(&fb_initial, &r);
     378:	83 ec 08             	sub    esp,0x8
     37b:	8d 45 e4             	lea    eax,[ebp-0x1c]
     37e:	50                   	push   eax
     37f:	68 00 00 00 00       	push   0x0
     384:	e8 fc ff ff ff       	call   385 <scroll_left+0xab>
     389:	83 c4 10             	add    esp,0x10
		cr->cur_x--;
     38c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     38f:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     393:	83 e8 01             	sub    eax,0x1
     396:	89 c2                	mov    edx,eax
     398:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     39b:	66 89 50 0e          	mov    WORD PTR [eax+0xe],dx
		putc_pr(cr, '\0', cr->cur_x, cr->cur_y);
     39f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3a2:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     3a6:	0f b7 d0             	movzx  edx,ax
     3a9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3ac:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     3b0:	0f b7 c0             	movzx  eax,ax
     3b3:	52                   	push   edx
     3b4:	50                   	push   eax
     3b5:	6a 00                	push   0x0
     3b7:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     3ba:	e8 fc ff ff ff       	call   3bb <scroll_left+0xe1>
     3bf:	83 c4 10             	add    esp,0x10
}
     3c2:	90                   	nop
     3c3:	8d 65 f8             	lea    esp,[ebp-0x8]
     3c6:	5b                   	pop    ebx
     3c7:	5e                   	pop    esi
     3c8:	5d                   	pop    ebp
     3c9:	c3                   	ret

000003ca <region_unputchar>:
{
     3ca:	55                   	push   ebp
     3cb:	89 e5                	mov    ebp,esp
     3cd:	83 ec 08             	sub    esp,0x8
		if (cr->cur_x) {
     3d0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3d3:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     3d7:	66 85 c0             	test   ax,ax
     3da:	74 3b                	je     417 <region_unputchar+0x4d>
				cr->cur_x--;
     3dc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3df:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     3e3:	83 e8 01             	sub    eax,0x1
     3e6:	89 c2                	mov    edx,eax
     3e8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3eb:	66 89 50 0e          	mov    WORD PTR [eax+0xe],dx
				putc_pr(cr, '\0', cr->cur_x, cr->cur_y);
     3ef:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3f2:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     3f6:	0f b7 d0             	movzx  edx,ax
     3f9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     3fc:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     400:	0f b7 c0             	movzx  eax,ax
     403:	52                   	push   edx
     404:	50                   	push   eax
     405:	6a 00                	push   0x0
     407:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     40a:	e8 fc ff ff ff       	call   40b <region_unputchar+0x41>
     40f:	83 c4 10             	add    esp,0x10
}
     412:	e9 a0 00 00 00       	jmp    4b7 <region_unputchar+0xed>
		} else if (cr->cur_y) {
     417:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     41a:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     41e:	66 85 c0             	test   ax,ax
     421:	0f 84 90 00 00 00    	je     4b7 <region_unputchar+0xed>
				cr->cur_y--;
     427:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     42a:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     42e:	83 e8 01             	sub    eax,0x1
     431:	89 c2                	mov    edx,eax
     433:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     436:	66 89 50 10          	mov    WORD PTR [eax+0x10],dx
				cr->cur_x = cr->lx;
     43a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     43d:	0f b7 50 04          	movzx  edx,WORD PTR [eax+0x4]
     441:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     444:	66 89 50 0e          	mov    WORD PTR [eax+0xe],dx
				while (--cr->cur_x)
     448:	eb 28                	jmp    472 <region_unputchar+0xa8>
						if (getc_pr(cr, cr->cur_x, cr->cur_y) != '\0')
     44a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     44d:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     451:	0f b7 d0             	movzx  edx,ax
     454:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     457:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     45b:	0f b7 c0             	movzx  eax,ax
     45e:	83 ec 04             	sub    esp,0x4
     461:	52                   	push   edx
     462:	50                   	push   eax
     463:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     466:	e8 fc ff ff ff       	call   467 <region_unputchar+0x9d>
     46b:	83 c4 10             	add    esp,0x10
     46e:	84 c0                	test   al,al
     470:	75 21                	jne    493 <region_unputchar+0xc9>
				while (--cr->cur_x)
     472:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     475:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     479:	83 e8 01             	sub    eax,0x1
     47c:	89 c2                	mov    edx,eax
     47e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     481:	66 89 50 0e          	mov    WORD PTR [eax+0xe],dx
     485:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     488:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     48c:	66 85 c0             	test   ax,ax
     48f:	75 b9                	jne    44a <region_unputchar+0x80>
     491:	eb 01                	jmp    494 <region_unputchar+0xca>
								break;
     493:	90                   	nop
				putc_pr(cr, '\0', cr->cur_x, cr->cur_y);
     494:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     497:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     49b:	0f b7 d0             	movzx  edx,ax
     49e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     4a1:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     4a5:	0f b7 c0             	movzx  eax,ax
     4a8:	52                   	push   edx
     4a9:	50                   	push   eax
     4aa:	6a 00                	push   0x0
     4ac:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     4af:	e8 fc ff ff ff       	call   4b0 <region_unputchar+0xe6>
     4b4:	83 c4 10             	add    esp,0x10
}
     4b7:	90                   	nop
     4b8:	c9                   	leave
     4b9:	c3                   	ret

000004ba <region_getline>:
{
     4ba:	55                   	push   ebp
     4bb:	89 e5                	mov    ebp,esp
     4bd:	83 ec 28             	sub    esp,0x28
		char* str; size_t rem, ct = 0;
     4c0:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		if (!lineptr || !n || (cr->flags & KIO_REGION_INPUT_DISABLED)) {
     4c7:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
     4cb:	74 17                	je     4e4 <region_getline+0x2a>
     4cd:	83 7d 10 00          	cmp    DWORD PTR [ebp+0x10],0x0
     4d1:	74 11                	je     4e4 <region_getline+0x2a>
     4d3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     4d6:	0f b6 40 0d          	movzx  eax,BYTE PTR [eax+0xd]
     4da:	0f be c0             	movsx  eax,al
     4dd:	83 e0 08             	and    eax,0x8
     4e0:	85 c0                	test   eax,eax
     4e2:	74 14                	je     4f8 <region_getline+0x3e>
				errno = EINVAL;
     4e4:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR ds:0x0,0x16
				return -1;
     4ee:	b8 ff ff ff ff       	mov    eax,0xffffffff
     4f3:	e9 7e 02 00 00       	jmp    776 <region_getline+0x2bc>
		str = *lineptr;
     4f8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     4fb:	8b 00                	mov    eax,DWORD PTR [eax]
     4fd:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		rem = *n;
     500:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     503:	8b 00                	mov    eax,DWORD PTR [eax]
     505:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		if (rem == 0) {
     508:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     50c:	75 28                	jne    536 <region_getline+0x7c>
				str = kmalloc(80);
     50e:	83 ec 0c             	sub    esp,0xc
     511:	6a 50                	push   0x50
     513:	e8 fc ff ff ff       	call   514 <region_getline+0x5a>
     518:	83 c4 10             	add    esp,0x10
     51b:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				rem = 80;
     51e:	c7 45 f0 50 00 00 00 	mov    DWORD PTR [ebp-0x10],0x50
				*n = 80;
     525:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     528:	c7 00 50 00 00 00    	mov    DWORD PTR [eax],0x50
				*lineptr = str;
     52e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     531:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     534:	89 10                	mov    DWORD PTR [eax],edx
				if (!(cr->flags & KIO_REGION_INPUT_NOCURSOR)) {
     536:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     539:	0f b6 40 0d          	movzx  eax,BYTE PTR [eax+0xd]
     53d:	84 c0                	test   al,al
     53f:	78 39                	js     57a <region_getline+0xc0>
										cr->y + cr->cur_y);
     541:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     544:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
     548:	0f bf d0             	movsx  edx,ax
     54b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     54e:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     552:	98                   	cwde
						framebuffer_set_cursor(&fb_initial, cr->x + cr->cur_x,
     553:	01 c2                	add    edx,eax
     555:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     558:	0f b7 00             	movzx  eax,WORD PTR [eax]
     55b:	0f bf c8             	movsx  ecx,ax
     55e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     561:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     565:	98                   	cwde
     566:	01 c8                	add    eax,ecx
     568:	83 ec 04             	sub    esp,0x4
     56b:	52                   	push   edx
     56c:	50                   	push   eax
     56d:	68 00 00 00 00       	push   0x0
     572:	e8 fc ff ff ff       	call   573 <region_getline+0xb9>
     577:	83 c4 10             	add    esp,0x10
				int c = region_getchar(cr);
     57a:	83 ec 0c             	sub    esp,0xc
     57d:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     580:	e8 fc ff ff ff       	call   581 <region_getline+0xc7>
     585:	83 c4 10             	add    esp,0x10
     588:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				if (c == EOF) {
     58b:	83 7d e8 ff          	cmp    DWORD PTR [ebp-0x18],0xffffffff
     58f:	75 13                	jne    5a4 <region_getline+0xea>
						str[ct] = '\0';
     591:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     594:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     597:	01 d0                	add    eax,edx
     599:	c6 00 00             	mov    BYTE PTR [eax],0x0
						return ct;
     59c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     59f:	e9 d2 01 00 00       	jmp    776 <region_getline+0x2bc>
				} else if (c == '\b') {
     5a4:	83 7d e8 08          	cmp    DWORD PTR [ebp-0x18],0x8
     5a8:	0f 85 a8 00 00 00    	jne    656 <region_getline+0x19c>
						if (ct) {
     5ae:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     5b2:	0f 84 b8 01 00 00    	je     770 <region_getline+0x2b6>
								str[--ct] = '\0';
     5b8:	83 6d ec 01          	sub    DWORD PTR [ebp-0x14],0x1
     5bc:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     5bf:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     5c2:	01 d0                	add    eax,edx
     5c4:	c6 00 00             	mov    BYTE PTR [eax],0x0
								if (cr->cur_x || (cr->flags & KIO_REGION_INPUT_MULTILINE))
     5c7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     5ca:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     5ce:	66 85 c0             	test   ax,ax
     5d1:	75 11                	jne    5e4 <region_getline+0x12a>
     5d3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     5d6:	0f b6 40 0d          	movzx  eax,BYTE PTR [eax+0xd]
     5da:	0f be c0             	movsx  eax,al
     5dd:	83 e0 10             	and    eax,0x10
     5e0:	85 c0                	test   eax,eax
     5e2:	74 13                	je     5f7 <region_getline+0x13d>
										region_unputchar(cr);
     5e4:	83 ec 0c             	sub    esp,0xc
     5e7:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     5ea:	e8 fc ff ff ff       	call   5eb <region_getline+0x131>
     5ef:	83 c4 10             	add    esp,0x10
						continue;
     5f2:	e9 79 01 00 00       	jmp    770 <region_getline+0x2b6>
								else if (ct && !(cr->flags & KIO_REGION_INPUT_MULTILINE)) {
     5f7:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     5fb:	0f 84 6f 01 00 00    	je     770 <region_getline+0x2b6>
     601:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     604:	0f b6 40 0d          	movzx  eax,BYTE PTR [eax+0xd]
     608:	0f be c0             	movsx  eax,al
     60b:	83 e0 10             	and    eax,0x10
     60e:	85 c0                	test   eax,eax
     610:	0f 85 5a 01 00 00    	jne    770 <region_getline+0x2b6>
										size_t nc = min(ct, (size_t)cr->lx);
     616:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     619:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
     61d:	98                   	cwde
     61e:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
     621:	39 c2                	cmp    edx,eax
     623:	0f 46 c2             	cmovbe eax,edx
     626:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
										region_puts(cr, str + (ct - nc));
     629:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     62c:	2b 45 e4             	sub    eax,DWORD PTR [ebp-0x1c]
     62f:	89 c2                	mov    edx,eax
     631:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     634:	01 d0                	add    eax,edx
     636:	83 ec 08             	sub    esp,0x8
     639:	50                   	push   eax
     63a:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     63d:	e8 fc ff ff ff       	call   63e <region_getline+0x184>
     642:	83 c4 10             	add    esp,0x10
										cr->cur_x = nc;
     645:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
     648:	89 c2                	mov    edx,eax
     64a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     64d:	66 89 50 0e          	mov    WORD PTR [eax+0xe],dx
						continue;
     651:	e9 1a 01 00 00       	jmp    770 <region_getline+0x2b6>
				str[ct++] = c;
     656:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     659:	8d 50 01             	lea    edx,[eax+0x1]
     65c:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
     65f:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     662:	01 d0                	add    eax,edx
     664:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
     667:	88 10                	mov    BYTE PTR [eax],dl
				if (ct + 1 == rem) {
     669:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     66c:	83 c0 01             	add    eax,0x1
     66f:	39 45 f0             	cmp    DWORD PTR [ebp-0x10],eax
     672:	75 37                	jne    6ab <region_getline+0x1f1>
						rem *= 2;
     674:	d1 65 f0             	shl    DWORD PTR [ebp-0x10],1
						str = krealloc(str, rem);
     677:	83 ec 08             	sub    esp,0x8
     67a:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
     67d:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
     680:	e8 fc ff ff ff       	call   681 <region_getline+0x1c7>
     685:	83 c4 10             	add    esp,0x10
     688:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
						if (!str)
     68b:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     68f:	75 0a                	jne    69b <region_getline+0x1e1>
								return -1;
     691:	b8 ff ff ff ff       	mov    eax,0xffffffff
     696:	e9 db 00 00 00       	jmp    776 <region_getline+0x2bc>
						*n = rem;
     69b:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     69e:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
     6a1:	89 10                	mov    DWORD PTR [eax],edx
						*lineptr = str;
     6a3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     6a6:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     6a9:	89 10                	mov    DWORD PTR [eax],edx
				if ((c == 10 || c == 13) && !(cr->flags & KIO_REGION_INPUT_MULTILINE)) {
     6ab:	83 7d e8 0a          	cmp    DWORD PTR [ebp-0x18],0xa
     6af:	74 06                	je     6b7 <region_getline+0x1fd>
     6b1:	83 7d e8 0d          	cmp    DWORD PTR [ebp-0x18],0xd
     6b5:	75 34                	jne    6eb <region_getline+0x231>
     6b7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     6ba:	0f b6 40 0d          	movzx  eax,BYTE PTR [eax+0xd]
     6be:	0f be c0             	movsx  eax,al
     6c1:	83 e0 10             	and    eax,0x10
     6c4:	85 c0                	test   eax,eax
     6c6:	75 23                	jne    6eb <region_getline+0x231>
						region_putchar(cr, '\n');
     6c8:	83 ec 08             	sub    esp,0x8
     6cb:	6a 0a                	push   0xa
     6cd:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     6d0:	e8 fc ff ff ff       	call   6d1 <region_getline+0x217>
     6d5:	83 c4 10             	add    esp,0x10
						str[ct] = '\0';
     6d8:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     6db:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     6de:	01 d0                	add    eax,edx
     6e0:	c6 00 00             	mov    BYTE PTR [eax],0x0
						return ct;
     6e3:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     6e6:	e9 8b 00 00 00       	jmp    776 <region_getline+0x2bc>
				if (!(cr->flags & KIO_REGION_INPUT_MULTILINE) && cr->cur_x == cr->lx) {
     6eb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     6ee:	0f b6 40 0d          	movzx  eax,BYTE PTR [eax+0xd]
     6f2:	0f be c0             	movsx  eax,al
     6f5:	83 e0 10             	and    eax,0x10
     6f8:	85 c0                	test   eax,eax
     6fa:	75 5a                	jne    756 <region_getline+0x29c>
     6fc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     6ff:	0f b7 50 0e          	movzx  edx,WORD PTR [eax+0xe]
     703:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     706:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
     70a:	66 39 c2             	cmp    dx,ax
     70d:	75 47                	jne    756 <region_getline+0x29c>
						if (cr->flags & KIO_REGION_INPUT_WRAP) {
     70f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     712:	0f b6 40 0d          	movzx  eax,BYTE PTR [eax+0xd]
     716:	0f be c0             	movsx  eax,al
     719:	83 e0 40             	and    eax,0x40
     71c:	85 c0                	test   eax,eax
     71e:	74 25                	je     745 <region_getline+0x28b>
								scroll_left(cr);
     720:	83 ec 0c             	sub    esp,0xc
     723:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     726:	e8 fc ff ff ff       	call   727 <region_getline+0x26d>
     72b:	83 c4 10             	add    esp,0x10
								region_putchar(cr, c);
     72e:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     731:	0f be c0             	movsx  eax,al
     734:	83 ec 08             	sub    esp,0x8
     737:	50                   	push   eax
     738:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     73b:	e8 fc ff ff ff       	call   73c <region_getline+0x282>
     740:	83 c4 10             	add    esp,0x10
						if (cr->flags & KIO_REGION_INPUT_WRAP) {
     743:	eb 2c                	jmp    771 <region_getline+0x2b7>
								str[--ct] = '\0';
     745:	83 6d ec 01          	sub    DWORD PTR [ebp-0x14],0x1
     749:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
     74c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
     74f:	01 d0                	add    eax,edx
     751:	c6 00 00             	mov    BYTE PTR [eax],0x0
						if (cr->flags & KIO_REGION_INPUT_WRAP) {
     754:	eb 1b                	jmp    771 <region_getline+0x2b7>
						region_putchar(cr, c);
     756:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
     759:	0f be c0             	movsx  eax,al
     75c:	83 ec 08             	sub    esp,0x8
     75f:	50                   	push   eax
     760:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     763:	e8 fc ff ff ff       	call   764 <region_getline+0x2aa>
     768:	83 c4 10             	add    esp,0x10
     76b:	e9 c6 fd ff ff       	jmp    536 <region_getline+0x7c>
						continue;
     770:	90                   	nop
		do {
     771:	e9 c0 fd ff ff       	jmp    536 <region_getline+0x7c>
}
     776:	c9                   	leave
     777:	c3                   	ret

00000778 <getline>:
{
     778:	55                   	push   ebp
     779:	89 e5                	mov    ebp,esp
     77b:	83 ec 08             	sub    esp,0x8
		kbd_handler(); // poke the buffer
     77e:	e8 fc ff ff ff       	call   77f <getline+0x7>
		return region_getline(&reg_def, lineptr, n);
     783:	83 ec 04             	sub    esp,0x4
     786:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
     789:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     78c:	68 00 00 00 00       	push   0x0
     791:	e8 fc ff ff ff       	call   792 <getline+0x1a>
     796:	83 c4 10             	add    esp,0x10
}
     799:	c9                   	leave
     79a:	c3                   	ret

0000079b <region_getchar>:
{
     79b:	55                   	push   ebp
     79c:	89 e5                	mov    ebp,esp
     79e:	83 ec 18             	sub    esp,0x18
		if (cr->flags & KIO_REGION_INPUT_DISABLED)
     7a1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     7a4:	0f b6 40 0d          	movzx  eax,BYTE PTR [eax+0xd]
     7a8:	0f be c0             	movsx  eax,al
     7ab:	83 e0 08             	and    eax,0x8
     7ae:	85 c0                	test   eax,eax
     7b0:	75 03                	jne    7b5 <region_getchar+0x1a>
Pos1:
     7b2:	90                   	nop
     7b3:	eb 07                	jmp    7bc <region_getchar+0x21>
				return EOF;
     7b5:	b8 ff ff ff ff       	mov    eax,0xffffffff
     7ba:	eb 5f                	jmp    81b <region_getchar+0x80>
		if (kbd_event_present()) {
     7bc:	e8 fc ff ff ff       	call   7bd <region_getchar+0x22>
     7c1:	85 c0                	test   eax,eax
     7c3:	74 2c                	je     7f1 <region_getchar+0x56>
				struct key_event ke = kbd_get_event();
     7c5:	8d 45 f0             	lea    eax,[ebp-0x10]
     7c8:	83 ec 0c             	sub    esp,0xc
     7cb:	50                   	push   eax
     7cc:	e8 fc ff ff ff       	call   7cd <region_getchar+0x32>
     7d1:	83 c4 0c             	add    esp,0xc
				int rv = kbd_event_translate(&ke);
     7d4:	83 ec 0c             	sub    esp,0xc
     7d7:	8d 45 f0             	lea    eax,[ebp-0x10]
     7da:	50                   	push   eax
     7db:	e8 fc ff ff ff       	call   7dc <region_getchar+0x41>
     7e0:	83 c4 10             	add    esp,0x10
     7e3:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
				if (rv != 0)
     7e6:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
     7ea:	74 d0                	je     7bc <region_getchar+0x21>
						return rv;
     7ec:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     7ef:	eb 2a                	jmp    81b <region_getchar+0x80>
		} else if (cr->flags & KIO_REGION_INPUT_NONBLOCKING)
     7f1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     7f4:	0f b6 40 0d          	movzx  eax,BYTE PTR [eax+0xd]
     7f8:	0f be c0             	movsx  eax,al
     7fb:	83 e0 20             	and    eax,0x20
     7fe:	85 c0                	test   eax,eax
     800:	74 07                	je     809 <region_getchar+0x6e>
				return EOF;
     802:	b8 ff ff ff ff       	mov    eax,0xffffffff
     807:	eb 12                	jmp    81b <region_getchar+0x80>
				wait_on_event(&wq_kbd);
     809:	83 ec 0c             	sub    esp,0xc
     80c:	68 00 00 00 00       	push   0x0
     811:	e8 fc ff ff ff       	call   812 <region_getchar+0x77>
     816:	83 c4 10             	add    esp,0x10
		goto Pos1;
     819:	eb a1                	jmp    7bc <region_getchar+0x21>
}
     81b:	c9                   	leave
     81c:	c3                   	ret

0000081d <region_putchar>:
{
     81d:	55                   	push   ebp
     81e:	89 e5                	mov    ebp,esp
     820:	53                   	push   ebx
     821:	83 ec 34             	sub    esp,0x34
     824:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     827:	88 45 d4             	mov    BYTE PTR [ebp-0x2c],al
		if (c == 10 || c == 13) {
     82a:	80 7d d4 0a          	cmp    BYTE PTR [ebp-0x2c],0xa
     82e:	74 0a                	je     83a <region_putchar+0x1d>
     830:	80 7d d4 0d          	cmp    BYTE PTR [ebp-0x2c],0xd
     834:	0f 85 2c 01 00 00    	jne    966 <region_putchar+0x149>
				for (i = cr->cur_x; i < cr->lx; i++)
     83a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     83d:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     841:	66 89 45 f6          	mov    WORD PTR [ebp-0xa],ax
     845:	eb 2b                	jmp    872 <region_putchar+0x55>
						putc_pr(cr, '\0', i, cr->cur_y);
     847:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     84a:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     84e:	0f b7 d0             	movzx  edx,ax
     851:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
     855:	0f b7 c0             	movzx  eax,ax
     858:	52                   	push   edx
     859:	50                   	push   eax
     85a:	6a 00                	push   0x0
     85c:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     85f:	e8 fc ff ff ff       	call   860 <region_putchar+0x43>
     864:	83 c4 10             	add    esp,0x10
				for (i = cr->cur_x; i < cr->lx; i++)
     867:	0f b7 45 f6          	movzx  eax,WORD PTR [ebp-0xa]
     86b:	83 c0 01             	add    eax,0x1
     86e:	66 89 45 f6          	mov    WORD PTR [ebp-0xa],ax
     872:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     875:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
     879:	66 39 45 f6          	cmp    WORD PTR [ebp-0xa],ax
     87d:	7c c8                	jl     847 <region_putchar+0x2a>
				r.x = cr->x + cr->cur_x;
     87f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     882:	0f b7 00             	movzx  eax,WORD PTR [eax]
     885:	89 c2                	mov    edx,eax
     887:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     88a:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     88e:	01 d0                	add    eax,edx
     890:	66 89 45 e2          	mov    WORD PTR [ebp-0x1e],ax
				r.y = cr->y + cr->cur_y;
     894:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     897:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
     89b:	89 c2                	mov    edx,eax
     89d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8a0:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     8a4:	01 d0                	add    eax,edx
     8a6:	66 89 45 e4          	mov    WORD PTR [ebp-0x1c],ax
				r.ly = 1;
     8aa:	66 c7 45 e8 01 00    	mov    WORD PTR [ebp-0x18],0x1
				r.lx = cr->lx - cr->cur_x;
     8b0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8b3:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
     8b7:	89 c2                	mov    edx,eax
     8b9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8bc:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     8c0:	89 c1                	mov    ecx,eax
     8c2:	89 d0                	mov    eax,edx
     8c4:	29 c8                	sub    eax,ecx
     8c6:	66 89 45 e6          	mov    WORD PTR [ebp-0x1a],ax
				cr->cur_x = 0;
     8ca:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8cd:	66 c7 40 0e 00 00    	mov    WORD PTR [eax+0xe],0x0
				if (++cr->cur_y == cr->ly) {
     8d3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8d6:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     8da:	83 c0 01             	add    eax,0x1
     8dd:	89 c2                	mov    edx,eax
     8df:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8e2:	66 89 50 10          	mov    WORD PTR [eax+0x10],dx
     8e6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8e9:	0f b7 50 10          	movzx  edx,WORD PTR [eax+0x10]
     8ed:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8f0:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
     8f4:	66 39 c2             	cmp    dx,ax
     8f7:	75 49                	jne    942 <region_putchar+0x125>
						if (!(cr->flags & KIO_REGION_DEFERED_SCROLL)) {
     8f9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     8fc:	0f b6 40 0d          	movzx  eax,BYTE PTR [eax+0xd]
     900:	0f be c0             	movsx  eax,al
     903:	83 e0 04             	and    eax,0x4
     906:	85 c0                	test   eax,eax
     908:	75 38                	jne    942 <region_putchar+0x125>
								cr->cur_y--;
     90a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     90d:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     911:	83 e8 01             	sub    eax,0x1
     914:	89 c2                	mov    edx,eax
     916:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     919:	66 89 50 10          	mov    WORD PTR [eax+0x10],dx
								if (!(cr->flags & KIO_REGION_NO_SCROLL)) {
     91d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     920:	0f b6 40 0d          	movzx  eax,BYTE PTR [eax+0xd]
     924:	0f be c0             	movsx  eax,al
     927:	83 e0 02             	and    eax,0x2
     92a:	85 c0                	test   eax,eax
     92c:	75 14                	jne    942 <region_putchar+0x125>
										scroll_buffer(cr);
     92e:	83 ec 0c             	sub    esp,0xc
     931:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     934:	e8 fc ff ff ff       	call   935 <region_putchar+0x118>
     939:	83 c4 10             	add    esp,0x10
										i = -1;
     93c:	66 c7 45 f6 ff ff    	mov    WORD PTR [ebp-0xa],0xffff
				if (i != -1)
     942:	66 83 7d f6 ff       	cmp    WORD PTR [ebp-0xa],0xffff
     947:	0f 84 7e 01 00 00    	je     acb <region_putchar+0x2ae>
						framebuffer_update_region(&fb_initial, &r);
     94d:	83 ec 08             	sub    esp,0x8
     950:	8d 45 e2             	lea    eax,[ebp-0x1e]
     953:	50                   	push   eax
     954:	68 00 00 00 00       	push   0x0
     959:	e8 fc ff ff ff       	call   95a <region_putchar+0x13d>
     95e:	83 c4 10             	add    esp,0x10
		if (c == 10 || c == 13) {
     961:	e9 65 01 00 00       	jmp    acb <region_putchar+0x2ae>
		} else if (c == '\t') {
     966:	80 7d d4 09          	cmp    BYTE PTR [ebp-0x2c],0x9
     96a:	0f 85 8b 00 00 00    	jne    9fb <region_putchar+0x1de>
				if (cr->cur_x == cr->lx)
     970:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     973:	0f b7 50 0e          	movzx  edx,WORD PTR [eax+0xe]
     977:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     97a:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
     97e:	66 39 c2             	cmp    dx,ax
     981:	75 10                	jne    993 <region_putchar+0x176>
						region_putchar(cr, '\n');
     983:	83 ec 08             	sub    esp,0x8
     986:	6a 0a                	push   0xa
     988:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     98b:	e8 fc ff ff ff       	call   98c <region_putchar+0x16f>
     990:	83 c4 10             	add    esp,0x10
				for (c = 0; cr->cur_x < cr->lx && c < 4; cr->cur_x++, c++)
     993:	c6 45 d4 00          	mov    BYTE PTR [ebp-0x2c],0x0
     997:	eb 40                	jmp    9d9 <region_putchar+0x1bc>
						putc_pr(cr, ' ', cr->cur_x, cr->cur_y);
     999:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     99c:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     9a0:	0f b7 d0             	movzx  edx,ax
     9a3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     9a6:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     9aa:	0f b7 c0             	movzx  eax,ax
     9ad:	52                   	push   edx
     9ae:	50                   	push   eax
     9af:	6a 20                	push   0x20
     9b1:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     9b4:	e8 fc ff ff ff       	call   9b5 <region_putchar+0x198>
     9b9:	83 c4 10             	add    esp,0x10
				for (c = 0; cr->cur_x < cr->lx && c < 4; cr->cur_x++, c++)
     9bc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     9bf:	0f b7 40 0e          	movzx  eax,WORD PTR [eax+0xe]
     9c3:	83 c0 01             	add    eax,0x1
     9c6:	89 c2                	mov    edx,eax
     9c8:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     9cb:	66 89 50 0e          	mov    WORD PTR [eax+0xe],dx
     9cf:	0f b6 45 d4          	movzx  eax,BYTE PTR [ebp-0x2c]
     9d3:	83 c0 01             	add    eax,0x1
     9d6:	88 45 d4             	mov    BYTE PTR [ebp-0x2c],al
     9d9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     9dc:	0f b7 50 0e          	movzx  edx,WORD PTR [eax+0xe]
     9e0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     9e3:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
     9e7:	66 39 c2             	cmp    dx,ax
     9ea:	0f 8d dc 00 00 00    	jge    acc <region_putchar+0x2af>
     9f0:	80 7d d4 03          	cmp    BYTE PTR [ebp-0x2c],0x3
     9f4:	7e a3                	jle    999 <region_putchar+0x17c>
     9f6:	e9 d1 00 00 00       	jmp    acc <region_putchar+0x2af>
		} else if (cr->cur_x == cr->lx) {
     9fb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     9fe:	0f b7 50 0e          	movzx  edx,WORD PTR [eax+0xe]
     a02:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a05:	0f b7 40 04          	movzx  eax,WORD PTR [eax+0x4]
     a09:	66 39 c2             	cmp    dx,ax
     a0c:	75 72                	jne    a80 <region_putchar+0x263>
				region_putchar(cr, '\n');
     a0e:	83 ec 08             	sub    esp,0x8
     a11:	6a 0a                	push   0xa
     a13:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     a16:	e8 fc ff ff ff       	call   a17 <region_putchar+0x1fa>
     a1b:	83 c4 10             	add    esp,0x10
				cr->cur_x = 0;
     a1e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a21:	66 c7 40 0e 00 00    	mov    WORD PTR [eax+0xe],0x0
				putc_pr(cr, c, cr->cur_x++, cr->cur_y);
     a27:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a2a:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     a2e:	0f b7 c8             	movzx  ecx,ax
     a31:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a34:	0f b7 50 0e          	movzx  edx,WORD PTR [eax+0xe]
     a38:	89 d0                	mov    eax,edx
     a3a:	83 c0 01             	add    eax,0x1
     a3d:	89 c3                	mov    ebx,eax
     a3f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a42:	66 89 58 0e          	mov    WORD PTR [eax+0xe],bx
     a46:	89 d0                	mov    eax,edx
     a48:	0f b7 d0             	movzx  edx,ax
     a4b:	0f be 45 d4          	movsx  eax,BYTE PTR [ebp-0x2c]
     a4f:	51                   	push   ecx
     a50:	52                   	push   edx
     a51:	50                   	push   eax
     a52:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     a55:	e8 fc ff ff ff       	call   a56 <region_putchar+0x239>
     a5a:	83 c4 10             	add    esp,0x10
     a5d:	eb 6d                	jmp    acc <region_putchar+0x2af>
						scroll_buffer(cr);
     a5f:	83 ec 0c             	sub    esp,0xc
     a62:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     a65:	e8 fc ff ff ff       	call   a66 <region_putchar+0x249>
     a6a:	83 c4 10             	add    esp,0x10
						cr->cur_y--;
     a6d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a70:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     a74:	83 e8 01             	sub    eax,0x1
     a77:	89 c2                	mov    edx,eax
     a79:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a7c:	66 89 50 10          	mov    WORD PTR [eax+0x10],dx
				while (cr->cur_y >= cr->ly) {
     a80:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a83:	0f b7 50 10          	movzx  edx,WORD PTR [eax+0x10]
     a87:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a8a:	0f b7 40 06          	movzx  eax,WORD PTR [eax+0x6]
     a8e:	66 39 c2             	cmp    dx,ax
     a91:	7d cc                	jge    a5f <region_putchar+0x242>
				putc_pr(cr, c, cr->cur_x++, cr->cur_y);
     a93:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     a96:	0f b7 40 10          	movzx  eax,WORD PTR [eax+0x10]
     a9a:	0f b7 c8             	movzx  ecx,ax
     a9d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     aa0:	0f b7 50 0e          	movzx  edx,WORD PTR [eax+0xe]
     aa4:	89 d0                	mov    eax,edx
     aa6:	83 c0 01             	add    eax,0x1
     aa9:	89 c3                	mov    ebx,eax
     aab:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     aae:	66 89 58 0e          	mov    WORD PTR [eax+0xe],bx
     ab2:	89 d0                	mov    eax,edx
     ab4:	0f b7 d0             	movzx  edx,ax
     ab7:	0f be 45 d4          	movsx  eax,BYTE PTR [ebp-0x2c]
     abb:	51                   	push   ecx
     abc:	52                   	push   edx
     abd:	50                   	push   eax
     abe:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     ac1:	e8 fc ff ff ff       	call   ac2 <region_putchar+0x2a5>
     ac6:	83 c4 10             	add    esp,0x10
     ac9:	eb 01                	jmp    acc <region_putchar+0x2af>
		if (c == 10 || c == 13) {
     acb:	90                   	nop
		return c;
     acc:	0f be 45 d4          	movsx  eax,BYTE PTR [ebp-0x2c]
}
     ad0:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     ad3:	c9                   	leave
     ad4:	c3                   	ret

00000ad5 <getchar>:
{
     ad5:	55                   	push   ebp
     ad6:	89 e5                	mov    ebp,esp
     ad8:	83 ec 08             	sub    esp,0x8
		return region_getchar(&reg_def);
     adb:	83 ec 0c             	sub    esp,0xc
     ade:	68 00 00 00 00       	push   0x0
     ae3:	e8 fc ff ff ff       	call   ae4 <getchar+0xf>
     ae8:	83 c4 10             	add    esp,0x10
}
     aeb:	c9                   	leave
     aec:	c3                   	ret

00000aed <putchar>:
{
     aed:	55                   	push   ebp
     aee:	89 e5                	mov    ebp,esp
     af0:	83 ec 18             	sub    esp,0x18
     af3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     af6:	88 45 f4             	mov    BYTE PTR [ebp-0xc],al
		return region_putchar(&reg_def, c);
     af9:	0f be 45 f4          	movsx  eax,BYTE PTR [ebp-0xc]
     afd:	83 ec 08             	sub    esp,0x8
     b00:	50                   	push   eax
     b01:	68 00 00 00 00       	push   0x0
     b06:	e8 fc ff ff ff       	call   b07 <putchar+0x1a>
     b0b:	83 c4 10             	add    esp,0x10
}
     b0e:	c9                   	leave
     b0f:	c3                   	ret

00000b10 <region_puts>:
{
     b10:	55                   	push   ebp
     b11:	89 e5                	mov    ebp,esp
     b13:	83 ec 08             	sub    esp,0x8
		while(*str)
     b16:	eb 1e                	jmp    b36 <region_puts+0x26>
				region_putchar(cr, *(str++));
     b18:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     b1b:	8d 50 01             	lea    edx,[eax+0x1]
     b1e:	89 55 0c             	mov    DWORD PTR [ebp+0xc],edx
     b21:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     b24:	0f be c0             	movsx  eax,al
     b27:	83 ec 08             	sub    esp,0x8
     b2a:	50                   	push   eax
     b2b:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     b2e:	e8 fc ff ff ff       	call   b2f <region_puts+0x1f>
     b33:	83 c4 10             	add    esp,0x10
		while(*str)
     b36:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     b39:	0f b6 00             	movzx  eax,BYTE PTR [eax]
     b3c:	84 c0                	test   al,al
     b3e:	75 d8                	jne    b18 <region_puts+0x8>
}
     b40:	90                   	nop
     b41:	90                   	nop
     b42:	c9                   	leave
     b43:	c3                   	ret

00000b44 <puts>:
{
     b44:	55                   	push   ebp
     b45:	89 e5                	mov    ebp,esp
     b47:	83 ec 08             	sub    esp,0x8
		return region_puts(&reg_def, str);
     b4a:	83 ec 08             	sub    esp,0x8
     b4d:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     b50:	68 00 00 00 00       	push   0x0
     b55:	e8 fc ff ff ff       	call   b56 <puts+0x12>
     b5a:	83 c4 10             	add    esp,0x10
}
     b5d:	c9                   	leave
     b5e:	c3                   	ret

00000b5f <putb>:
{
     b5f:	55                   	push   ebp
     b60:	89 e5                	mov    ebp,esp
     b62:	83 ec 28             	sub    esp,0x28
     b65:	8b 4d 10             	mov    ecx,DWORD PTR [ebp+0x10]
     b68:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
     b6b:	8b 45 18             	mov    eax,DWORD PTR [ebp+0x18]
     b6e:	88 4d e4             	mov    BYTE PTR [ebp-0x1c],cl
     b71:	88 55 e0             	mov    BYTE PTR [ebp-0x20],dl
     b74:	88 45 dc             	mov    BYTE PTR [ebp-0x24],al
		int i, nonz = 0, rv = 0;
     b77:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
     b7e:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		for (i = 0; i < 32; i++) {
     b85:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
     b8c:	e9 e2 00 00 00       	jmp    c73 <putb+0x114>
				unsigned int bt = (arg & 0x80000000);
     b91:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     b94:	25 00 00 00 80       	and    eax,0x80000000
     b99:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				rv++;
     b9c:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
				if (bt) {
     ba0:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
     ba4:	74 1f                	je     bc5 <putb+0x66>
						nonz = 1;
     ba6:	c7 45 f0 01 00 00 00 	mov    DWORD PTR [ebp-0x10],0x1
						ctx->putchar(ctx, '1');
     bad:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     bb0:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     bb3:	83 ec 08             	sub    esp,0x8
     bb6:	6a 31                	push   0x31
     bb8:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     bbb:	ff d0                	call   eax
     bbd:	83 c4 10             	add    esp,0x10
     bc0:	e9 a7 00 00 00       	jmp    c6c <putb+0x10d>
				} else if (nonz)
     bc5:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
     bc9:	74 18                	je     be3 <putb+0x84>
						ctx->putchar(ctx, '0');
     bcb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     bce:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     bd1:	83 ec 08             	sub    esp,0x8
     bd4:	6a 30                	push   0x30
     bd6:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     bd9:	ff d0                	call   eax
     bdb:	83 c4 10             	add    esp,0x10
     bde:	e9 89 00 00 00       	jmp    c6c <putb+0x10d>
				else if ((32 - i) <= prec) /* has precedence over with */
     be3:	b8 20 00 00 00       	mov    eax,0x20
     be8:	2b 45 f4             	sub    eax,DWORD PTR [ebp-0xc]
     beb:	89 c2                	mov    edx,eax
     bed:	0f be 45 dc          	movsx  eax,BYTE PTR [ebp-0x24]
     bf1:	39 c2                	cmp    edx,eax
     bf3:	7f 15                	jg     c0a <putb+0xab>
						ctx->putchar(ctx, '0');
     bf5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     bf8:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     bfb:	83 ec 08             	sub    esp,0x8
     bfe:	6a 30                	push   0x30
     c00:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     c03:	ff d0                	call   eax
     c05:	83 c4 10             	add    esp,0x10
     c08:	eb 62                	jmp    c6c <putb+0x10d>
				else if ((32 - i) <= width)
     c0a:	b8 20 00 00 00       	mov    eax,0x20
     c0f:	2b 45 f4             	sub    eax,DWORD PTR [ebp-0xc]
     c12:	89 c2                	mov    edx,eax
     c14:	0f be 45 e0          	movsx  eax,BYTE PTR [ebp-0x20]
     c18:	39 c2                	cmp    edx,eax
     c1a:	7f 2b                	jg     c47 <putb+0xe8>
						ctx->putchar(ctx, flags & KFL_ZERO_PREFIX ? '0' : ' ');
     c1c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c1f:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     c22:	0f be 55 e4          	movsx  edx,BYTE PTR [ebp-0x1c]
     c26:	83 e2 02             	and    edx,0x2
     c29:	85 d2                	test   edx,edx
     c2b:	74 07                	je     c34 <putb+0xd5>
     c2d:	ba 30 00 00 00       	mov    edx,0x30
     c32:	eb 05                	jmp    c39 <putb+0xda>
     c34:	ba 20 00 00 00       	mov    edx,0x20
     c39:	83 ec 08             	sub    esp,0x8
     c3c:	52                   	push   edx
     c3d:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     c40:	ff d0                	call   eax
     c42:	83 c4 10             	add    esp,0x10
     c45:	eb 25                	jmp    c6c <putb+0x10d>
				else if (i == 31 && prec >= 0) /* only print 0 for nonneg prec */
     c47:	83 7d f4 1f          	cmp    DWORD PTR [ebp-0xc],0x1f
     c4b:	75 1b                	jne    c68 <putb+0x109>
     c4d:	80 7d dc 00          	cmp    BYTE PTR [ebp-0x24],0x0
     c51:	78 15                	js     c68 <putb+0x109>
						ctx->putchar(ctx, '0');
     c53:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     c56:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     c59:	83 ec 08             	sub    esp,0x8
     c5c:	6a 30                	push   0x30
     c5e:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     c61:	ff d0                	call   eax
     c63:	83 c4 10             	add    esp,0x10
     c66:	eb 04                	jmp    c6c <putb+0x10d>
				else
						rv--;
     c68:	83 6d ec 01          	sub    DWORD PTR [ebp-0x14],0x1
				arg <<= 1;
     c6c:	d1 65 0c             	shl    DWORD PTR [ebp+0xc],1
		for (i = 0; i < 32; i++) {
     c6f:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     c73:	83 7d f4 1f          	cmp    DWORD PTR [ebp-0xc],0x1f
     c77:	0f 8e 14 ff ff ff    	jle    b91 <putb+0x32>
		}
		return rv;
     c7d:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
}
     c80:	c9                   	leave
     c81:	c3                   	ret

00000c82 <putu64>:

int putu64(struct ivp_ctx* ctx, unsigned long long int arg, char flags)
{
     c82:	55                   	push   ebp
     c83:	89 e5                	mov    ebp,esp
     c85:	53                   	push   ebx
     c86:	83 ec 64             	sub    esp,0x64
     c89:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
     c8c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
     c8f:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
     c92:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
     c95:	89 45 a4             	mov    DWORD PTR [ebp-0x5c],eax
     c98:	89 d0                	mov    eax,edx
     c9a:	88 45 9c             	mov    BYTE PTR [ebp-0x64],al
		int rv = 0, i, nonz = 0;
     c9d:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
     ca4:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		if (flags & KFL_IS_HEX) {
     cab:	0f be 45 9c          	movsx  eax,BYTE PTR [ebp-0x64]
     caf:	83 e0 01             	and    eax,0x1
     cb2:	85 c0                	test   eax,eax
     cb4:	0f 84 2c 01 00 00    	je     de6 <putu64+0x164>
				for (i = 0; i < 16; i++) {
     cba:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
     cc1:	e9 11 01 00 00       	jmp    dd7 <putu64+0x155>
						unsigned long long int hf = (arg & 0xf000000000000000);
     cc6:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
     cc9:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
     ccc:	b8 00 00 00 00       	mov    eax,0x0
     cd1:	81 e2 00 00 00 f0    	and    edx,0xf0000000
     cd7:	89 45 b8             	mov    DWORD PTR [ebp-0x48],eax
     cda:	89 55 bc             	mov    DWORD PTR [ebp-0x44],edx
						char hc = (flags & KFL_CAPITAL) ? CHEXCHAR(hf >> 60) : HEXCHAR(hf >> 60);
     cdd:	80 7d 9c 00          	cmp    BYTE PTR [ebp-0x64],0x0
     ce1:	79 41                	jns    d24 <putu64+0xa2>
     ce3:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
     ce6:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
     ce9:	89 d0                	mov    eax,edx
     ceb:	31 d2                	xor    edx,edx
     ced:	c1 e8 1c             	shr    eax,0x1c
     cf0:	bb 09 00 00 00       	mov    ebx,0x9
     cf5:	b9 00 00 00 00       	mov    ecx,0x0
     cfa:	39 c3                	cmp    ebx,eax
     cfc:	19 d1                	sbb    ecx,edx
     cfe:	72 12                	jb     d12 <putu64+0x90>
     d00:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
     d03:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
     d06:	89 d0                	mov    eax,edx
     d08:	31 d2                	xor    edx,edx
     d0a:	c1 e8 1c             	shr    eax,0x1c
     d0d:	83 c0 30             	add    eax,0x30
     d10:	eb 51                	jmp    d63 <putu64+0xe1>
     d12:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
     d15:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
     d18:	89 d0                	mov    eax,edx
     d1a:	31 d2                	xor    edx,edx
     d1c:	c1 e8 1c             	shr    eax,0x1c
     d1f:	83 c0 37             	add    eax,0x37
     d22:	eb 3f                	jmp    d63 <putu64+0xe1>
     d24:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
     d27:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
     d2a:	89 d0                	mov    eax,edx
     d2c:	31 d2                	xor    edx,edx
     d2e:	c1 e8 1c             	shr    eax,0x1c
     d31:	bb 09 00 00 00       	mov    ebx,0x9
     d36:	b9 00 00 00 00       	mov    ecx,0x0
     d3b:	39 c3                	cmp    ebx,eax
     d3d:	19 d1                	sbb    ecx,edx
     d3f:	72 12                	jb     d53 <putu64+0xd1>
     d41:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
     d44:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
     d47:	89 d0                	mov    eax,edx
     d49:	31 d2                	xor    edx,edx
     d4b:	c1 e8 1c             	shr    eax,0x1c
     d4e:	83 c0 30             	add    eax,0x30
     d51:	eb 10                	jmp    d63 <putu64+0xe1>
     d53:	8b 45 b8             	mov    eax,DWORD PTR [ebp-0x48]
     d56:	8b 55 bc             	mov    edx,DWORD PTR [ebp-0x44]
     d59:	89 d0                	mov    eax,edx
     d5b:	31 d2                	xor    edx,edx
     d5d:	c1 e8 1c             	shr    eax,0x1c
     d60:	83 c0 57             	add    eax,0x57
     d63:	88 45 b7             	mov    BYTE PTR [ebp-0x49],al
						rv++;
     d66:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
						if (hc != '0') {
     d6a:	80 7d b7 30          	cmp    BYTE PTR [ebp-0x49],0x30
     d6e:	74 25                	je     d95 <putu64+0x113>
								nonz = 1;
     d70:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [ebp-0x14],0x1
								if (ctx) ctx->putchar(ctx, hc);
     d77:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     d7b:	74 43                	je     dc0 <putu64+0x13e>
     d7d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     d80:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     d83:	0f be 55 b7          	movsx  edx,BYTE PTR [ebp-0x49]
     d87:	83 ec 08             	sub    esp,0x8
     d8a:	52                   	push   edx
     d8b:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     d8e:	ff d0                	call   eax
     d90:	83 c4 10             	add    esp,0x10
     d93:	eb 2b                	jmp    dc0 <putu64+0x13e>
						} else if (nonz || i == 15) {
     d95:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     d99:	75 06                	jne    da1 <putu64+0x11f>
     d9b:	83 7d f0 0f          	cmp    DWORD PTR [ebp-0x10],0xf
     d9f:	75 1b                	jne    dbc <putu64+0x13a>
								if (ctx) ctx->putchar(ctx, '0');
     da1:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     da5:	74 19                	je     dc0 <putu64+0x13e>
     da7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     daa:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     dad:	83 ec 08             	sub    esp,0x8
     db0:	6a 30                	push   0x30
     db2:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     db5:	ff d0                	call   eax
     db7:	83 c4 10             	add    esp,0x10
     dba:	eb 04                	jmp    dc0 <putu64+0x13e>
						} else
								rv--;
     dbc:	83 6d f4 01          	sub    DWORD PTR [ebp-0xc],0x1
						arg <<= 4;
     dc0:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
     dc3:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
     dc6:	0f a4 c2 04          	shld   edx,eax,0x4
     dca:	c1 e0 04             	shl    eax,0x4
     dcd:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
     dd0:	89 55 a4             	mov    DWORD PTR [ebp-0x5c],edx
				for (i = 0; i < 16; i++) {
     dd3:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
     dd7:	83 7d f0 0f          	cmp    DWORD PTR [ebp-0x10],0xf
     ddb:	0f 8e e5 fe ff ff    	jle    cc6 <putu64+0x44>
     de1:	e9 d5 01 00 00       	jmp    fbb <putu64+0x339>
				}
		} else if (flags & KFL_IS_OCT) {
     de6:	0f be 45 9c          	movsx  eax,BYTE PTR [ebp-0x64]
     dea:	83 e0 40             	and    eax,0x40
     ded:	85 c0                	test   eax,eax
     def:	0f 84 e4 00 00 00    	je     ed9 <putu64+0x257>
				/* process first bit */
				if (arg & (1ull << 63)) {
     df5:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
     df8:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
     dfb:	85 d2                	test   edx,edx
     dfd:	79 24                	jns    e23 <putu64+0x1a1>
						rv++; nonz = 1;
     dff:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
     e03:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [ebp-0x14],0x1
						if (ctx) ctx->putchar(ctx, '1');
     e0a:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     e0e:	74 13                	je     e23 <putu64+0x1a1>
     e10:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     e13:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     e16:	83 ec 08             	sub    esp,0x8
     e19:	6a 31                	push   0x31
     e1b:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     e1e:	ff d0                	call   eax
     e20:	83 c4 10             	add    esp,0x10
				}
				for (i = 0; i < 21; i++) {
     e23:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
     e2a:	e9 9b 00 00 00       	jmp    eca <putu64+0x248>
						unsigned long long int of = (arg & 0700000000000000000000);
     e2f:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
     e32:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
     e35:	b8 00 00 00 00       	mov    eax,0x0
     e3a:	81 e2 00 00 00 70    	and    edx,0x70000000
     e40:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
     e43:	89 55 cc             	mov    DWORD PTR [ebp-0x34],edx
						char oc = '0' + (char)(of >> 60);
     e46:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
     e49:	8b 55 cc             	mov    edx,DWORD PTR [ebp-0x34]
     e4c:	89 d0                	mov    eax,edx
     e4e:	31 d2                	xor    edx,edx
     e50:	c1 e8 1c             	shr    eax,0x1c
     e53:	83 c0 30             	add    eax,0x30
     e56:	88 45 c7             	mov    BYTE PTR [ebp-0x39],al
						rv++;
     e59:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
						if (oc != '0') {
     e5d:	80 7d c7 30          	cmp    BYTE PTR [ebp-0x39],0x30
     e61:	74 25                	je     e88 <putu64+0x206>
								nonz = 1;
     e63:	c7 45 ec 01 00 00 00 	mov    DWORD PTR [ebp-0x14],0x1
								if (ctx) ctx->putchar(ctx, oc);
     e6a:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     e6e:	74 43                	je     eb3 <putu64+0x231>
     e70:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     e73:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     e76:	0f be 55 c7          	movsx  edx,BYTE PTR [ebp-0x39]
     e7a:	83 ec 08             	sub    esp,0x8
     e7d:	52                   	push   edx
     e7e:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     e81:	ff d0                	call   eax
     e83:	83 c4 10             	add    esp,0x10
     e86:	eb 2b                	jmp    eb3 <putu64+0x231>
						} else if (nonz || i == 20) {
     e88:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
     e8c:	75 06                	jne    e94 <putu64+0x212>
     e8e:	83 7d f0 14          	cmp    DWORD PTR [ebp-0x10],0x14
     e92:	75 1b                	jne    eaf <putu64+0x22d>
								if (ctx) ctx->putchar(ctx, '0');
     e94:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     e98:	74 19                	je     eb3 <putu64+0x231>
     e9a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     e9d:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     ea0:	83 ec 08             	sub    esp,0x8
     ea3:	6a 30                	push   0x30
     ea5:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     ea8:	ff d0                	call   eax
     eaa:	83 c4 10             	add    esp,0x10
     ead:	eb 04                	jmp    eb3 <putu64+0x231>
						} else
								rv--;
     eaf:	83 6d f4 01          	sub    DWORD PTR [ebp-0xc],0x1
						arg <<= 3;
     eb3:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
     eb6:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
     eb9:	0f a4 c2 03          	shld   edx,eax,0x3
     ebd:	c1 e0 03             	shl    eax,0x3
     ec0:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
     ec3:	89 55 a4             	mov    DWORD PTR [ebp-0x5c],edx
				for (i = 0; i < 21; i++) {
     ec6:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
     eca:	83 7d f0 14          	cmp    DWORD PTR [ebp-0x10],0x14
     ece:	0f 8e 5b ff ff ff    	jle    e2f <putu64+0x1ad>
     ed4:	e9 e2 00 00 00       	jmp    fbb <putu64+0x339>
				}
		} else {
				unsigned long long int div = 1000000000000000000;
     ed9:	c7 45 e0 00 00 64 a7 	mov    DWORD PTR [ebp-0x20],0xa7640000
     ee0:	c7 45 e4 b3 b6 e0 0d 	mov    DWORD PTR [ebp-0x1c],0xde0b6b3
				unsigned long long int res; char frst = 0;
     ee7:	c6 45 df 00          	mov    BYTE PTR [ebp-0x21],0x0
				i = 0;
     eeb:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
				while (div) {
     ef2:	e9 b2 00 00 00       	jmp    fa9 <putu64+0x327>
					res = arg / div;
     ef7:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
     efa:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
     efd:	ff 75 a4             	push   DWORD PTR [ebp-0x5c]
     f00:	ff 75 a0             	push   DWORD PTR [ebp-0x60]
     f03:	e8 fc ff ff ff       	call   f04 <putu64+0x282>
     f08:	83 c4 10             	add    esp,0x10
     f0b:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
     f0e:	89 55 d4             	mov    DWORD PTR [ebp-0x2c],edx
					arg %= div; rv++;
     f11:	8b 45 a0             	mov    eax,DWORD PTR [ebp-0x60]
     f14:	8b 55 a4             	mov    edx,DWORD PTR [ebp-0x5c]
     f17:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
     f1a:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
     f1d:	52                   	push   edx
     f1e:	50                   	push   eax
     f1f:	e8 fc ff ff ff       	call   f20 <putu64+0x29e>
     f24:	83 c4 10             	add    esp,0x10
     f27:	89 45 a0             	mov    DWORD PTR [ebp-0x60],eax
     f2a:	89 55 a4             	mov    DWORD PTR [ebp-0x5c],edx
     f2d:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
					if (res || frst) {
     f31:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
     f34:	0b 45 d4             	or     eax,DWORD PTR [ebp-0x2c]
     f37:	75 06                	jne    f3f <putu64+0x2bd>
     f39:	80 7d df 00          	cmp    BYTE PTR [ebp-0x21],0x0
     f3d:	74 27                	je     f66 <putu64+0x2e4>
						if (ctx) ctx->putchar(ctx, '0' + (char)res);
     f3f:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     f43:	74 1b                	je     f60 <putu64+0x2de>
     f45:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     f48:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     f4b:	8b 55 d0             	mov    edx,DWORD PTR [ebp-0x30]
     f4e:	83 c2 30             	add    edx,0x30
     f51:	0f be d2             	movsx  edx,dl
     f54:	83 ec 08             	sub    esp,0x8
     f57:	52                   	push   edx
     f58:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     f5b:	ff d0                	call   eax
     f5d:	83 c4 10             	add    esp,0x10
						frst = 1;
     f60:	c6 45 df 01          	mov    BYTE PTR [ebp-0x21],0x1
     f64:	eb 25                	jmp    f8b <putu64+0x309>
					} else if (i == 18) {
     f66:	83 7d f0 12          	cmp    DWORD PTR [ebp-0x10],0x12
     f6a:	75 1b                	jne    f87 <putu64+0x305>
							if (ctx) ctx->putchar(ctx, '0');
     f6c:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
     f70:	74 19                	je     f8b <putu64+0x309>
     f72:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
     f75:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
     f78:	83 ec 08             	sub    esp,0x8
     f7b:	6a 30                	push   0x30
     f7d:	ff 75 08             	push   DWORD PTR [ebp+0x8]
     f80:	ff d0                	call   eax
     f82:	83 c4 10             	add    esp,0x10
     f85:	eb 04                	jmp    f8b <putu64+0x309>
					} else
							rv--;
     f87:	83 6d f4 01          	sub    DWORD PTR [ebp-0xc],0x1
					div /= 10;
     f8b:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     f8e:	8b 55 e4             	mov    edx,DWORD PTR [ebp-0x1c]
     f91:	6a 00                	push   0x0
     f93:	6a 0a                	push   0xa
     f95:	52                   	push   edx
     f96:	50                   	push   eax
     f97:	e8 fc ff ff ff       	call   f98 <putu64+0x316>
     f9c:	83 c4 10             	add    esp,0x10
     f9f:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
     fa2:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
					i++;
     fa5:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
				while (div) {
     fa9:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
     fac:	0b 45 e4             	or     eax,DWORD PTR [ebp-0x1c]
     faf:	0f 85 42 ff ff ff    	jne    ef7 <putu64+0x275>
				}
				i = rv;
     fb5:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
     fb8:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		}
		return rv;
     fbb:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
     fbe:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
     fc1:	c9                   	leave
     fc2:	c3                   	ret

00000fc3 <usermode_entry>:

void usermode_entry()
{
     fc3:	55                   	push   ebp
     fc4:	89 e5                	mov    ebp,esp
     fc6:	83 ec 18             	sub    esp,0x18
		int val = 4;
     fc9:	c7 45 f4 04 00 00 00 	mov    DWORD PTR [ebp-0xc],0x4
		printf("The adress of the stack is around %p\n", &val);
     fd0:	83 ec 08             	sub    esp,0x8
     fd3:	8d 45 f4             	lea    eax,[ebp-0xc]
     fd6:	50                   	push   eax
     fd7:	68 00 00 00 00       	push   0x0
     fdc:	e8 fc ff ff ff       	call   fdd <usermode_entry+0x1a>
     fe1:	83 c4 10             	add    esp,0x10
		printf("which is set within the kernel stack\n");
     fe4:	83 ec 0c             	sub    esp,0xc
     fe7:	68 28 00 00 00       	push   0x28
     fec:	e8 fc ff ff ff       	call   fed <usermode_entry+0x2a>
     ff1:	83 c4 10             	add    esp,0x10
		while (1);
     ff4:	90                   	nop
     ff5:	eb fd                	jmp    ff4 <usermode_entry+0x31>

00000ff7 <fun>:

}

void fun()
{
     ff7:	55                   	push   ebp
     ff8:	89 e5                	mov    ebp,esp
		/* float test etc. */
		extern void to_usermode();
		/*to_usermode();*/
}
     ffa:	90                   	nop
     ffb:	5d                   	pop    ebp
     ffc:	c3                   	ret

00000ffd <putu>:
 * tz localtime usw.
 * thread list & lock registry
__thread int iv = 0; <- drepper TLS article LDO, LE, LI
iv = 5; */
int putu(struct ivp_ctx* ctx, unsigned long long int arg, char flags, char width, char prec)
{
     ffd:	55                   	push   ebp
     ffe:	89 e5                	mov    ebp,esp
    1000:	53                   	push   ebx
    1001:	83 ec 44             	sub    esp,0x44
    1004:	8b 5d 14             	mov    ebx,DWORD PTR [ebp+0x14]
    1007:	8b 4d 18             	mov    ecx,DWORD PTR [ebp+0x18]
    100a:	8b 55 1c             	mov    edx,DWORD PTR [ebp+0x1c]
    100d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1010:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
    1013:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1016:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
    1019:	89 d8                	mov    eax,ebx
    101b:	88 45 cc             	mov    BYTE PTR [ebp-0x34],al
    101e:	89 c8                	mov    eax,ecx
    1020:	88 45 c8             	mov    BYTE PTR [ebp-0x38],al
    1023:	89 d0                	mov    eax,edx
    1025:	88 45 c4             	mov    BYTE PTR [ebp-0x3c],al
		int len, rv = 0;
    1028:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		int ns = 0, nz = 0, neg = ((flags & KFL_IS_NEG) == KFL_IS_NEG), zero = 0;
    102f:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    1036:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
    103d:	0f be 45 cc          	movsx  eax,BYTE PTR [ebp-0x34]
    1041:	25 c0 00 00 00       	and    eax,0xc0
    1046:	3d c0 00 00 00       	cmp    eax,0xc0
    104b:	0f 94 c0             	sete   al
    104e:	0f b6 c0             	movzx  eax,al
    1051:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
    1054:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
		if (neg/* && (flags & KFL_IS_HEX)*/)
    105b:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    105f:	74 04                	je     1065 <putu+0x68>
				flags &= ~KFL_IS_OCT;
    1061:	80 65 cc bf          	and    BYTE PTR [ebp-0x34],0xbf
		/* calc len */
		len = putu64(NULL, arg, flags);
    1065:	0f be 45 cc          	movsx  eax,BYTE PTR [ebp-0x34]
    1069:	50                   	push   eax
    106a:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    106d:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
    1070:	6a 00                	push   0x0
    1072:	e8 fc ff ff ff       	call   1073 <putu+0x76>
    1077:	83 c4 10             	add    esp,0x10
    107a:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		/* print at least width characters with prec digits */
		if (neg || (flags & (KFL_ALWAYS_SIGN | KFL_SPACE_PLUS)))
    107d:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    1081:	75 0b                	jne    108e <putu+0x91>
    1083:	0f be 45 cc          	movsx  eax,BYTE PTR [ebp-0x34]
    1087:	83 e0 24             	and    eax,0x24
    108a:	85 c0                	test   eax,eax
    108c:	74 04                	je     1092 <putu+0x95>
				rv++; /* one sign character */
    108e:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
		rv += len;
    1092:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1095:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
		if ((prec == -1) && !arg) {/* omit zero and sign, honor width */
    1098:	80 7d c4 ff          	cmp    BYTE PTR [ebp-0x3c],0xff
    109c:	75 18                	jne    10b6 <putu+0xb9>
    109e:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    10a1:	0b 45 d4             	or     eax,DWORD PTR [ebp-0x2c]
    10a4:	75 10                	jne    10b6 <putu+0xb9>
				rv = 0;
    10a6:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
				zero = 1;
    10ad:	c7 45 e8 01 00 00 00 	mov    DWORD PTR [ebp-0x18],0x1
    10b4:	eb 2b                	jmp    10e1 <putu+0xe4>
		}
		else if (flags & KFL_TYPE_PREFIX) {/* print type prefix (if printing 0) */
    10b6:	0f be 45 cc          	movsx  eax,BYTE PTR [ebp-0x34]
    10ba:	83 e0 10             	and    eax,0x10
    10bd:	85 c0                	test   eax,eax
    10bf:	74 20                	je     10e1 <putu+0xe4>
				if (flags & KFL_IS_HEX)
    10c1:	0f be 45 cc          	movsx  eax,BYTE PTR [ebp-0x34]
    10c5:	83 e0 01             	and    eax,0x1
    10c8:	85 c0                	test   eax,eax
    10ca:	74 06                	je     10d2 <putu+0xd5>
						rv += 2;
    10cc:	83 45 f4 02          	add    DWORD PTR [ebp-0xc],0x2
    10d0:	eb 0f                	jmp    10e1 <putu+0xe4>
				else if (flags & KFL_IS_OCT)
    10d2:	0f be 45 cc          	movsx  eax,BYTE PTR [ebp-0x34]
    10d6:	83 e0 40             	and    eax,0x40
    10d9:	85 c0                	test   eax,eax
    10db:	74 04                	je     10e1 <putu+0xe4>
						rv++;
    10dd:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
		}
		/* get nz and ns to match width & prec */
		if (flags & KFL_ZERO_PREFIX) {
    10e1:	0f be 45 cc          	movsx  eax,BYTE PTR [ebp-0x34]
    10e5:	83 e0 02             	and    eax,0x2
    10e8:	85 c0                	test   eax,eax
    10ea:	74 22                	je     110e <putu+0x111>
				nz = max(width - rv, prec);
    10ec:	0f be 55 c4          	movsx  edx,BYTE PTR [ebp-0x3c]
    10f0:	0f be 45 c8          	movsx  eax,BYTE PTR [ebp-0x38]
    10f4:	2b 45 f4             	sub    eax,DWORD PTR [ebp-0xc]
    10f7:	39 c2                	cmp    edx,eax
    10f9:	0f 4d c2             	cmovge eax,edx
    10fc:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				if (nz < 0)
    10ff:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    1103:	79 46                	jns    114b <putu+0x14e>
						nz = 0;
    1105:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
    110c:	eb 3d                	jmp    114b <putu+0x14e>
		} else {
				if (prec > 0)
    110e:	80 7d c4 00          	cmp    BYTE PTR [ebp-0x3c],0x0
    1112:	7e 0a                	jle    111e <putu+0x121>
						nz = prec - len;
    1114:	0f be 45 c4          	movsx  eax,BYTE PTR [ebp-0x3c]
    1118:	2b 45 e0             	sub    eax,DWORD PTR [ebp-0x20]
    111b:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				if (nz < 0)
    111e:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    1122:	79 07                	jns    112b <putu+0x12e>
						nz = 0;
    1124:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
				if (width)
    112b:	80 7d c8 00          	cmp    BYTE PTR [ebp-0x38],0x0
    112f:	74 0d                	je     113e <putu+0x141>
						ns = width - rv - nz;
    1131:	0f be 45 c8          	movsx  eax,BYTE PTR [ebp-0x38]
    1135:	2b 45 f4             	sub    eax,DWORD PTR [ebp-0xc]
    1138:	2b 45 ec             	sub    eax,DWORD PTR [ebp-0x14]
    113b:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				if (ns < 0)
    113e:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    1142:	79 07                	jns    114b <putu+0x14e>
						ns = 0;
    1144:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
		}
		rv += nz + ns;
    114b:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    114e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1151:	01 d0                	add    eax,edx
    1153:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
		/* now print and start with padding */
		if (flags & KFL_LEFT_ALIGN)
    1156:	0f be 45 cc          	movsx  eax,BYTE PTR [ebp-0x34]
    115a:	83 e0 08             	and    eax,0x8
    115d:	85 c0                	test   eax,eax
    115f:	74 22                	je     1183 <putu+0x186>
				while (ns--)
    1161:	eb 13                	jmp    1176 <putu+0x179>
						ctx->putchar(ctx, ' ');
    1163:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1166:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1169:	83 ec 08             	sub    esp,0x8
    116c:	6a 20                	push   0x20
    116e:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1171:	ff d0                	call   eax
    1173:	83 c4 10             	add    esp,0x10
				while (ns--)
    1176:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    1179:	8d 50 ff             	lea    edx,[eax-0x1]
    117c:	89 55 f0             	mov    DWORD PTR [ebp-0x10],edx
    117f:	85 c0                	test   eax,eax
    1181:	75 e0                	jne    1163 <putu+0x166>
		/* now the sign */
		if (neg)
    1183:	83 7d e4 00          	cmp    DWORD PTR [ebp-0x1c],0x0
    1187:	74 15                	je     119e <putu+0x1a1>
				ctx->putchar(ctx, '-');
    1189:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    118c:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    118f:	83 ec 08             	sub    esp,0x8
    1192:	6a 2d                	push   0x2d
    1194:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1197:	ff d0                	call   eax
    1199:	83 c4 10             	add    esp,0x10
    119c:	eb 4a                	jmp    11e8 <putu+0x1eb>
		else if (flags & KFL_ALWAYS_SIGN && !zero)
    119e:	0f be 45 cc          	movsx  eax,BYTE PTR [ebp-0x34]
    11a2:	83 e0 04             	and    eax,0x4
    11a5:	85 c0                	test   eax,eax
    11a7:	74 1b                	je     11c4 <putu+0x1c7>
    11a9:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    11ad:	75 15                	jne    11c4 <putu+0x1c7>
				ctx->putchar(ctx, '+');
    11af:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    11b2:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    11b5:	83 ec 08             	sub    esp,0x8
    11b8:	6a 2b                	push   0x2b
    11ba:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    11bd:	ff d0                	call   eax
    11bf:	83 c4 10             	add    esp,0x10
    11c2:	eb 24                	jmp    11e8 <putu+0x1eb>
		else if (flags & KFL_SPACE_PLUS && !zero)
    11c4:	0f be 45 cc          	movsx  eax,BYTE PTR [ebp-0x34]
    11c8:	83 e0 20             	and    eax,0x20
    11cb:	85 c0                	test   eax,eax
    11cd:	74 19                	je     11e8 <putu+0x1eb>
    11cf:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    11d3:	75 13                	jne    11e8 <putu+0x1eb>
				ctx->putchar(ctx, ' ');
    11d5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    11d8:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    11db:	83 ec 08             	sub    esp,0x8
    11de:	6a 20                	push   0x20
    11e0:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    11e3:	ff d0                	call   eax
    11e5:	83 c4 10             	add    esp,0x10
		/* now the type prefix */
		if ((flags & KFL_TYPE_PREFIX) && !zero) {
    11e8:	0f be 45 cc          	movsx  eax,BYTE PTR [ebp-0x34]
    11ec:	83 e0 10             	and    eax,0x10
    11ef:	85 c0                	test   eax,eax
    11f1:	0f 84 8b 00 00 00    	je     1282 <putu+0x285>
    11f7:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    11fb:	0f 85 81 00 00 00    	jne    1282 <putu+0x285>
				if (flags & KFL_IS_HEX) {
    1201:	0f be 45 cc          	movsx  eax,BYTE PTR [ebp-0x34]
    1205:	83 e0 01             	and    eax,0x1
    1208:	85 c0                	test   eax,eax
    120a:	74 43                	je     124f <putu+0x252>
						ctx->putchar(ctx, '0');
    120c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    120f:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1212:	83 ec 08             	sub    esp,0x8
    1215:	6a 30                	push   0x30
    1217:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    121a:	ff d0                	call   eax
    121c:	83 c4 10             	add    esp,0x10
						if (flags & KFL_CAPITAL)
    121f:	80 7d cc 00          	cmp    BYTE PTR [ebp-0x34],0x0
    1223:	79 15                	jns    123a <putu+0x23d>
								ctx->putchar(ctx, 'X');
    1225:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1228:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    122b:	83 ec 08             	sub    esp,0x8
    122e:	6a 58                	push   0x58
    1230:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1233:	ff d0                	call   eax
    1235:	83 c4 10             	add    esp,0x10
    1238:	eb 48                	jmp    1282 <putu+0x285>
						else
								ctx->putchar(ctx, 'x');
    123a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    123d:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1240:	83 ec 08             	sub    esp,0x8
    1243:	6a 78                	push   0x78
    1245:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1248:	ff d0                	call   eax
    124a:	83 c4 10             	add    esp,0x10
    124d:	eb 33                	jmp    1282 <putu+0x285>
				} else if (flags & KFL_IS_OCT)
    124f:	0f be 45 cc          	movsx  eax,BYTE PTR [ebp-0x34]
    1253:	83 e0 40             	and    eax,0x40
    1256:	85 c0                	test   eax,eax
    1258:	74 28                	je     1282 <putu+0x285>
						ctx->putchar(ctx, '0');
    125a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    125d:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1260:	83 ec 08             	sub    esp,0x8
    1263:	6a 30                	push   0x30
    1265:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1268:	ff d0                	call   eax
    126a:	83 c4 10             	add    esp,0x10
		}
		/* print the zero padding */
		while (nz--)
    126d:	eb 13                	jmp    1282 <putu+0x285>
				ctx->putchar(ctx, '0');
    126f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1272:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1275:	83 ec 08             	sub    esp,0x8
    1278:	6a 30                	push   0x30
    127a:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    127d:	ff d0                	call   eax
    127f:	83 c4 10             	add    esp,0x10
		while (nz--)
    1282:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1285:	8d 50 ff             	lea    edx,[eax-0x1]
    1288:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
    128b:	85 c0                	test   eax,eax
    128d:	75 e0                	jne    126f <putu+0x272>
		/* now emit the digits */
		if (!zero)
    128f:	83 7d e8 00          	cmp    DWORD PTR [ebp-0x18],0x0
    1293:	75 2b                	jne    12c0 <putu+0x2c3>
				putu64(ctx, arg, flags);
    1295:	0f be 45 cc          	movsx  eax,BYTE PTR [ebp-0x34]
    1299:	50                   	push   eax
    129a:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    129d:	ff 75 d0             	push   DWORD PTR [ebp-0x30]
    12a0:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    12a3:	e8 fc ff ff ff       	call   12a4 <putu+0x2a7>
    12a8:	83 c4 10             	add    esp,0x10
		/* and the padding */
		while (ns-- > 0)
    12ab:	eb 13                	jmp    12c0 <putu+0x2c3>
				ctx->putchar(ctx, ' ');
    12ad:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    12b0:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    12b3:	83 ec 08             	sub    esp,0x8
    12b6:	6a 20                	push   0x20
    12b8:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    12bb:	ff d0                	call   eax
    12bd:	83 c4 10             	add    esp,0x10
		while (ns-- > 0)
    12c0:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    12c3:	8d 50 ff             	lea    edx,[eax-0x1]
    12c6:	89 55 f0             	mov    DWORD PTR [ebp-0x10],edx
    12c9:	85 c0                	test   eax,eax
    12cb:	7f e0                	jg     12ad <putu+0x2b0>
		return rv;
    12cd:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    12d0:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    12d3:	c9                   	leave
    12d4:	c3                   	ret

000012d5 <putmin>:

int putmin(struct ivp_ctx* ctx, char flags, char width, char prec)
{
    12d5:	55                   	push   ebp
    12d6:	89 e5                	mov    ebp,esp
    12d8:	83 ec 48             	sub    esp,0x48
    12db:	8b 4d 0c             	mov    ecx,DWORD PTR [ebp+0xc]
    12de:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
    12e1:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
    12e4:	88 4d c4             	mov    BYTE PTR [ebp-0x3c],cl
    12e7:	88 55 c0             	mov    BYTE PTR [ebp-0x40],dl
    12ea:	88 45 bc             	mov    BYTE PTR [ebp-0x44],al
		const char* str_min[] =
    12ed:	c7 45 d4 4e 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x4e
    12f4:	c7 45 d8 5f 00 00 00 	mov    DWORD PTR [ebp-0x28],0x5f
    12fb:	c7 45 dc 76 00 00 00 	mov    DWORD PTR [ebp-0x24],0x76
		{
				/*"-8000", "-80000000",*/ "8000000000000000", /* hex */
				/*"-100000", "-20000000000",*/ "1000000000000000000000", /* oct*/
				/*"-32768", "-2147483648",*/ "9223372036854775808" /* dec */
		};
		int rv = 0, nz = 0, ns = 0, len;
    1302:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    1309:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    1310:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		const char* str = ((flags & KFL_IS_HEX) ? str_min[0] : ((flags & KFL_IS_OCT) ? str_min[1] : str_min[2]));
    1317:	0f be 45 c4          	movsx  eax,BYTE PTR [ebp-0x3c]
    131b:	83 e0 01             	and    eax,0x1
    131e:	85 c0                	test   eax,eax
    1320:	74 05                	je     1327 <putmin+0x52>
    1322:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1325:	eb 13                	jmp    133a <putmin+0x65>
    1327:	0f be 45 c4          	movsx  eax,BYTE PTR [ebp-0x3c]
    132b:	83 e0 40             	and    eax,0x40
    132e:	85 c0                	test   eax,eax
    1330:	74 05                	je     1337 <putmin+0x62>
    1332:	8b 45 d8             	mov    eax,DWORD PTR [ebp-0x28]
    1335:	eb 03                	jmp    133a <putmin+0x65>
    1337:	8b 45 dc             	mov    eax,DWORD PTR [ebp-0x24]
    133a:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
		len = strlen(str);
    133d:	83 ec 0c             	sub    esp,0xc
    1340:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
    1343:	e8 fc ff ff ff       	call   1344 <putmin+0x6f>
    1348:	83 c4 10             	add    esp,0x10
    134b:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
		rv = len + 1;
    134e:	8b 45 e0             	mov    eax,DWORD PTR [ebp-0x20]
    1351:	83 c0 01             	add    eax,0x1
    1354:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		if (flags & KFL_TYPE_PREFIX) {
    1357:	0f be 45 c4          	movsx  eax,BYTE PTR [ebp-0x3c]
    135b:	83 e0 10             	and    eax,0x10
    135e:	85 c0                	test   eax,eax
    1360:	74 20                	je     1382 <putmin+0xad>
				if (flags & KFL_IS_HEX)
    1362:	0f be 45 c4          	movsx  eax,BYTE PTR [ebp-0x3c]
    1366:	83 e0 01             	and    eax,0x1
    1369:	85 c0                	test   eax,eax
    136b:	74 06                	je     1373 <putmin+0x9e>
						rv += 2;
    136d:	83 45 f4 02          	add    DWORD PTR [ebp-0xc],0x2
    1371:	eb 0f                	jmp    1382 <putmin+0xad>
				else if (flags & KFL_IS_OCT)
    1373:	0f be 45 c4          	movsx  eax,BYTE PTR [ebp-0x3c]
    1377:	83 e0 40             	and    eax,0x40
    137a:	85 c0                	test   eax,eax
    137c:	74 04                	je     1382 <putmin+0xad>
						rv += 1;
    137e:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
		}
		/* calculate the spacing */
		if (flags & KFL_ZERO_PREFIX) {
    1382:	0f be 45 c4          	movsx  eax,BYTE PTR [ebp-0x3c]
    1386:	83 e0 02             	and    eax,0x2
    1389:	85 c0                	test   eax,eax
    138b:	74 22                	je     13af <putmin+0xda>
				nz = max(width - rv, prec);
    138d:	0f be 55 bc          	movsx  edx,BYTE PTR [ebp-0x44]
    1391:	0f be 45 c0          	movsx  eax,BYTE PTR [ebp-0x40]
    1395:	2b 45 f4             	sub    eax,DWORD PTR [ebp-0xc]
    1398:	39 c2                	cmp    edx,eax
    139a:	0f 4d c2             	cmovge eax,edx
    139d:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				if (nz < 0)
    13a0:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    13a4:	79 46                	jns    13ec <putmin+0x117>
						nz = 0;
    13a6:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    13ad:	eb 3d                	jmp    13ec <putmin+0x117>
		} else {
				if (prec > 0)
    13af:	80 7d bc 00          	cmp    BYTE PTR [ebp-0x44],0x0
    13b3:	7e 0a                	jle    13bf <putmin+0xea>
						nz = prec - len;
    13b5:	0f be 45 bc          	movsx  eax,BYTE PTR [ebp-0x44]
    13b9:	2b 45 e0             	sub    eax,DWORD PTR [ebp-0x20]
    13bc:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
				if (nz < 0)
    13bf:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
    13c3:	79 07                	jns    13cc <putmin+0xf7>
						nz = 0;
    13c5:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
				if (width)
    13cc:	80 7d c0 00          	cmp    BYTE PTR [ebp-0x40],0x0
    13d0:	74 0d                	je     13df <putmin+0x10a>
						ns = width - rv - nz;
    13d2:	0f be 45 c0          	movsx  eax,BYTE PTR [ebp-0x40]
    13d6:	2b 45 f4             	sub    eax,DWORD PTR [ebp-0xc]
    13d9:	2b 45 f0             	sub    eax,DWORD PTR [ebp-0x10]
    13dc:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
				if (ns < 0)
    13df:	83 7d ec 00          	cmp    DWORD PTR [ebp-0x14],0x0
    13e3:	79 07                	jns    13ec <putmin+0x117>
						ns = 0;
    13e5:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		}
		rv += nz + ns;
    13ec:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
    13ef:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    13f2:	01 d0                	add    eax,edx
    13f4:	01 45 f4             	add    DWORD PTR [ebp-0xc],eax
		/* print spaces */
		if (flags & KFL_LEFT_ALIGN)
    13f7:	0f be 45 c4          	movsx  eax,BYTE PTR [ebp-0x3c]
    13fb:	83 e0 08             	and    eax,0x8
    13fe:	85 c0                	test   eax,eax
    1400:	74 22                	je     1424 <putmin+0x14f>
				while (ns--)
    1402:	eb 13                	jmp    1417 <putmin+0x142>
						ctx->putchar(ctx, ' ');
    1404:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1407:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    140a:	83 ec 08             	sub    esp,0x8
    140d:	6a 20                	push   0x20
    140f:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1412:	ff d0                	call   eax
    1414:	83 c4 10             	add    esp,0x10
				while (ns--)
    1417:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    141a:	8d 50 ff             	lea    edx,[eax-0x1]
    141d:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
    1420:	85 c0                	test   eax,eax
    1422:	75 e0                	jne    1404 <putmin+0x12f>
		/* print the minus sign */
		if (ctx) ctx->putchar(ctx, '-');
    1424:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    1428:	74 13                	je     143d <putmin+0x168>
    142a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    142d:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1430:	83 ec 08             	sub    esp,0x8
    1433:	6a 2d                	push   0x2d
    1435:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1438:	ff d0                	call   eax
    143a:	83 c4 10             	add    esp,0x10
		/* print the type prefix */
		if (flags & KFL_TYPE_PREFIX) {
    143d:	0f be 45 c4          	movsx  eax,BYTE PTR [ebp-0x3c]
    1441:	83 e0 10             	and    eax,0x10
    1444:	85 c0                	test   eax,eax
    1446:	0f 84 81 00 00 00    	je     14cd <putmin+0x1f8>
				if (flags & KFL_IS_HEX) {
    144c:	0f be 45 c4          	movsx  eax,BYTE PTR [ebp-0x3c]
    1450:	83 e0 01             	and    eax,0x1
    1453:	85 c0                	test   eax,eax
    1455:	74 43                	je     149a <putmin+0x1c5>
						ctx->putchar(ctx, '0');
    1457:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    145a:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    145d:	83 ec 08             	sub    esp,0x8
    1460:	6a 30                	push   0x30
    1462:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1465:	ff d0                	call   eax
    1467:	83 c4 10             	add    esp,0x10
						if (flags & KFL_CAPITAL)
    146a:	80 7d c4 00          	cmp    BYTE PTR [ebp-0x3c],0x0
    146e:	79 15                	jns    1485 <putmin+0x1b0>
								ctx->putchar(ctx, 'X');
    1470:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1473:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1476:	83 ec 08             	sub    esp,0x8
    1479:	6a 58                	push   0x58
    147b:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    147e:	ff d0                	call   eax
    1480:	83 c4 10             	add    esp,0x10
    1483:	eb 48                	jmp    14cd <putmin+0x1f8>
						else
								ctx->putchar(ctx, 'x');
    1485:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1488:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    148b:	83 ec 08             	sub    esp,0x8
    148e:	6a 78                	push   0x78
    1490:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1493:	ff d0                	call   eax
    1495:	83 c4 10             	add    esp,0x10
    1498:	eb 33                	jmp    14cd <putmin+0x1f8>
				} else if (flags & KFL_IS_OCT)
    149a:	0f be 45 c4          	movsx  eax,BYTE PTR [ebp-0x3c]
    149e:	83 e0 40             	and    eax,0x40
    14a1:	85 c0                	test   eax,eax
    14a3:	74 28                	je     14cd <putmin+0x1f8>
						ctx->putchar(ctx, '0');
    14a5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    14a8:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    14ab:	83 ec 08             	sub    esp,0x8
    14ae:	6a 30                	push   0x30
    14b0:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    14b3:	ff d0                	call   eax
    14b5:	83 c4 10             	add    esp,0x10
		}
		/* and the zero prefix */
		while (nz--)
    14b8:	eb 13                	jmp    14cd <putmin+0x1f8>
				ctx->putchar(ctx, '0');
    14ba:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    14bd:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    14c0:	83 ec 08             	sub    esp,0x8
    14c3:	6a 30                	push   0x30
    14c5:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    14c8:	ff d0                	call   eax
    14ca:	83 c4 10             	add    esp,0x10
		while (nz--)
    14cd:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    14d0:	8d 50 ff             	lea    edx,[eax-0x1]
    14d3:	89 55 f0             	mov    DWORD PTR [ebp-0x10],edx
    14d6:	85 c0                	test   eax,eax
    14d8:	75 e0                	jne    14ba <putmin+0x1e5>
		/* print the number */
		if (ctx) for (size_t i = 0; i < strlen(str); i++)
    14da:	83 7d 08 00          	cmp    DWORD PTR [ebp+0x8],0x0
    14de:	74 55                	je     1535 <putmin+0x260>
    14e0:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
    14e7:	eb 24                	jmp    150d <putmin+0x238>
				ctx->putchar(ctx, str[i]);
    14e9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    14ec:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    14ef:	8b 4d e4             	mov    ecx,DWORD PTR [ebp-0x1c]
    14f2:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    14f5:	01 ca                	add    edx,ecx
    14f7:	0f b6 12             	movzx  edx,BYTE PTR [edx]
    14fa:	0f be d2             	movsx  edx,dl
    14fd:	83 ec 08             	sub    esp,0x8
    1500:	52                   	push   edx
    1501:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1504:	ff d0                	call   eax
    1506:	83 c4 10             	add    esp,0x10
		if (ctx) for (size_t i = 0; i < strlen(str); i++)
    1509:	83 45 e8 01          	add    DWORD PTR [ebp-0x18],0x1
    150d:	83 ec 0c             	sub    esp,0xc
    1510:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
    1513:	e8 fc ff ff ff       	call   1514 <putmin+0x23f>
    1518:	83 c4 10             	add    esp,0x10
    151b:	39 45 e8             	cmp    DWORD PTR [ebp-0x18],eax
    151e:	72 c9                	jb     14e9 <putmin+0x214>
		/* print spaces */
		while (ns-- > 0)
    1520:	eb 13                	jmp    1535 <putmin+0x260>
				ctx->putchar(ctx, ' ');
    1522:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1525:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1528:	83 ec 08             	sub    esp,0x8
    152b:	6a 20                	push   0x20
    152d:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    1530:	ff d0                	call   eax
    1532:	83 c4 10             	add    esp,0x10
		while (ns-- > 0)
    1535:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1538:	8d 50 ff             	lea    edx,[eax-0x1]
    153b:	89 55 ec             	mov    DWORD PTR [ebp-0x14],edx
    153e:	85 c0                	test   eax,eax
    1540:	7f e0                	jg     1522 <putmin+0x24d>
		return rv;
    1542:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    1545:	c9                   	leave
    1546:	c3                   	ret

00001547 <putd>:

int putd(struct ivp_ctx* ctx, long long int arg, char flags, char width, char prec)
{
    1547:	55                   	push   ebp
    1548:	89 e5                	mov    ebp,esp
    154a:	56                   	push   esi
    154b:	53                   	push   ebx
    154c:	83 ec 20             	sub    esp,0x20
    154f:	8b 5d 14             	mov    ebx,DWORD PTR [ebp+0x14]
    1552:	8b 4d 18             	mov    ecx,DWORD PTR [ebp+0x18]
    1555:	8b 55 1c             	mov    edx,DWORD PTR [ebp+0x1c]
    1558:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    155b:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    155e:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1561:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
    1564:	89 d8                	mov    eax,ebx
    1566:	88 45 ec             	mov    BYTE PTR [ebp-0x14],al
    1569:	89 c8                	mov    eax,ecx
    156b:	88 45 e8             	mov    BYTE PTR [ebp-0x18],al
    156e:	89 d0                	mov    eax,edx
    1570:	88 45 e4             	mov    BYTE PTR [ebp-0x1c],al
		if (arg < 0) {
    1573:	83 7d f4 00          	cmp    DWORD PTR [ebp-0xc],0x0
    1577:	79 60                	jns    15d9 <putd+0x92>
				if (arg > LLONG_MIN)
    1579:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    157c:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    157f:	81 f2 00 00 00 80    	xor    edx,0x80000000
    1585:	09 d0                	or     eax,edx
    1587:	74 34                	je     15bd <putd+0x76>
						return putu(ctx, -arg, flags | KFL_IS_NEG, width, prec);
    1589:	0f be 75 e4          	movsx  esi,BYTE PTR [ebp-0x1c]
    158d:	0f be 5d e8          	movsx  ebx,BYTE PTR [ebp-0x18]
    1591:	0f b6 45 ec          	movzx  eax,BYTE PTR [ebp-0x14]
    1595:	83 c8 c0             	or     eax,0xffffffc0
    1598:	0f be c8             	movsx  ecx,al
    159b:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    159e:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    15a1:	f7 d8                	neg    eax
    15a3:	83 d2 00             	adc    edx,0x0
    15a6:	f7 da                	neg    edx
    15a8:	83 ec 08             	sub    esp,0x8
    15ab:	56                   	push   esi
    15ac:	53                   	push   ebx
    15ad:	51                   	push   ecx
    15ae:	52                   	push   edx
    15af:	50                   	push   eax
    15b0:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    15b3:	e8 fc ff ff ff       	call   15b4 <putd+0x6d>
    15b8:	83 c4 20             	add    esp,0x20
    15bb:	eb 41                	jmp    15fe <putd+0xb7>
				else
						return putmin(ctx, flags, width, prec);
    15bd:	0f be 4d e4          	movsx  ecx,BYTE PTR [ebp-0x1c]
    15c1:	0f be 55 e8          	movsx  edx,BYTE PTR [ebp-0x18]
    15c5:	0f be 45 ec          	movsx  eax,BYTE PTR [ebp-0x14]
    15c9:	51                   	push   ecx
    15ca:	52                   	push   edx
    15cb:	50                   	push   eax
    15cc:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    15cf:	e8 fc ff ff ff       	call   15d0 <putd+0x89>
    15d4:	83 c4 10             	add    esp,0x10
    15d7:	eb 25                	jmp    15fe <putd+0xb7>
		} else
				return putu(ctx, (unsigned long long int)arg, flags, width, prec);
    15d9:	0f be 75 e4          	movsx  esi,BYTE PTR [ebp-0x1c]
    15dd:	0f be 5d e8          	movsx  ebx,BYTE PTR [ebp-0x18]
    15e1:	0f be 4d ec          	movsx  ecx,BYTE PTR [ebp-0x14]
    15e5:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    15e8:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    15eb:	83 ec 08             	sub    esp,0x8
    15ee:	56                   	push   esi
    15ef:	53                   	push   ebx
    15f0:	51                   	push   ecx
    15f1:	52                   	push   edx
    15f2:	50                   	push   eax
    15f3:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    15f6:	e8 fc ff ff ff       	call   15f7 <putd+0xb0>
    15fb:	83 c4 20             	add    esp,0x20
}
    15fe:	8d 65 f8             	lea    esp,[ebp-0x8]
    1601:	5b                   	pop    ebx
    1602:	5e                   	pop    esi
    1603:	5d                   	pop    ebp
    1604:	c3                   	ret

00001605 <cputs.0>:
															0, 2 * sizeof(void*) / sizeof(char));
									/*		cur_fmt = fm;
									}*/
									else if (*fmt == 's') {
											/* no wchar_t support */
											void cputs(const char* s) {
    1605:	55                   	push   ebp
    1606:	89 e5                	mov    ebp,esp
    1608:	53                   	push   ebx
    1609:	83 ec 14             	sub    esp,0x14
    160c:	89 cb                	mov    ebx,ecx
    160e:	89 4d f4             	mov    DWORD PTR [ebp-0xc],ecx
													while (*s)
    1611:	eb 20                	jmp    1633 <cputs.0+0x2e>
															ctx->putchar(ctx, *s++);
    1613:	8b 03                	mov    eax,DWORD PTR [ebx]
    1615:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    1618:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    161b:	8d 48 01             	lea    ecx,[eax+0x1]
    161e:	89 4d 08             	mov    DWORD PTR [ebp+0x8],ecx
    1621:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1624:	0f be c8             	movsx  ecx,al
    1627:	8b 03                	mov    eax,DWORD PTR [ebx]
    1629:	83 ec 08             	sub    esp,0x8
    162c:	51                   	push   ecx
    162d:	50                   	push   eax
    162e:	ff d2                	call   edx
    1630:	83 c4 10             	add    esp,0x10
													while (*s)
    1633:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1636:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1639:	84 c0                	test   al,al
    163b:	75 d6                	jne    1613 <cputs.0+0xe>
											}
    163d:	90                   	nop
    163e:	90                   	nop
    163f:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
    1642:	c9                   	leave
    1643:	c3                   	ret

00001644 <internal_vprintf>:
{
    1644:	55                   	push   ebp
    1645:	89 e5                	mov    ebp,esp
    1647:	56                   	push   esi
    1648:	53                   	push   ebx
    1649:	83 ec 30             	sub    esp,0x30
int internal_vprintf(struct ivp_ctx* ctx, const char* fmt, va_list args)
    164c:	8d 45 08             	lea    eax,[ebp+0x8]
    164f:	89 45 cc             	mov    DWORD PTR [ebp-0x34],eax
    1652:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1655:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
		char is_fmt = 0, flags = KFL_LEFT_ALIGN, width = 0, prec = 0, size = 0;
    1658:	c6 45 f7 00          	mov    BYTE PTR [ebp-0x9],0x0
    165c:	c6 45 f6 08          	mov    BYTE PTR [ebp-0xa],0x8
    1660:	c6 45 f5 00          	mov    BYTE PTR [ebp-0xb],0x0
    1664:	c6 45 f4 00          	mov    BYTE PTR [ebp-0xc],0x0
    1668:	c6 45 f3 00          	mov    BYTE PTR [ebp-0xd],0x0
		int rv = 0;
    166c:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
		while (*fmt) {
    1673:	e9 4a 09 00 00       	jmp    1fc2 <internal_vprintf+0x97e>
			switch (*fmt) {
    1678:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    167b:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    167e:	0f be c0             	movsx  eax,al
    1681:	83 f8 25             	cmp    eax,0x25
    1684:	75 4c                	jne    16d2 <internal_vprintf+0x8e>
							is_fmt = !is_fmt;
    1686:	80 7d f7 00          	cmp    BYTE PTR [ebp-0x9],0x0
    168a:	0f 94 c0             	sete   al
    168d:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
							if (!is_fmt) {
    1690:	80 7d f7 00          	cmp    BYTE PTR [ebp-0x9],0x0
    1694:	75 20                	jne    16b6 <internal_vprintf+0x72>
									ctx->putchar(ctx, *fmt);
    1696:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1699:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    169c:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    169f:	0f b6 12             	movzx  edx,BYTE PTR [edx]
    16a2:	0f be ca             	movsx  ecx,dl
    16a5:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
    16a8:	83 ec 08             	sub    esp,0x8
    16ab:	51                   	push   ecx
    16ac:	52                   	push   edx
    16ad:	ff d0                	call   eax
    16af:	83 c4 10             	add    esp,0x10
									rv++;
    16b2:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
							fmt++;
    16b6:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
							width = prec = 0;
    16ba:	c6 45 f4 00          	mov    BYTE PTR [ebp-0xc],0x0
    16be:	0f b6 45 f4          	movzx  eax,BYTE PTR [ebp-0xc]
    16c2:	88 45 f5             	mov    BYTE PTR [ebp-0xb],al
							flags = KFL_LEFT_ALIGN;
    16c5:	c6 45 f6 08          	mov    BYTE PTR [ebp-0xa],0x8
							size = 0;
    16c9:	c6 45 f3 00          	mov    BYTE PTR [ebp-0xd],0x0
							break;
    16cd:	e9 f0 08 00 00       	jmp    1fc2 <internal_vprintf+0x97e>
							if ((is_fmt == 1) && (*fmt == ' ' || *fmt == '0' || *fmt == '#' || *fmt == '+' || *fmt == '-')) {
    16d2:	80 7d f7 01          	cmp    BYTE PTR [ebp-0x9],0x1
    16d6:	0f 85 89 00 00 00    	jne    1765 <internal_vprintf+0x121>
    16dc:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    16df:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    16e2:	3c 20                	cmp    al,0x20
    16e4:	74 28                	je     170e <internal_vprintf+0xca>
    16e6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    16e9:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    16ec:	3c 30                	cmp    al,0x30
    16ee:	74 1e                	je     170e <internal_vprintf+0xca>
    16f0:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    16f3:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    16f6:	3c 23                	cmp    al,0x23
    16f8:	74 14                	je     170e <internal_vprintf+0xca>
    16fa:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    16fd:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1700:	3c 2b                	cmp    al,0x2b
    1702:	74 0a                	je     170e <internal_vprintf+0xca>
    1704:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1707:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    170a:	3c 2d                	cmp    al,0x2d
    170c:	75 57                	jne    1765 <internal_vprintf+0x121>
									if (*fmt == ' ')
    170e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1711:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1714:	3c 20                	cmp    al,0x20
    1716:	75 06                	jne    171e <internal_vprintf+0xda>
											flags |= KFL_SPACE_PLUS;
    1718:	80 4d f6 20          	or     BYTE PTR [ebp-0xa],0x20
    171c:	eb 3e                	jmp    175c <internal_vprintf+0x118>
									else if (*fmt == '0')
    171e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1721:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1724:	3c 30                	cmp    al,0x30
    1726:	75 06                	jne    172e <internal_vprintf+0xea>
											flags |= KFL_ZERO_PREFIX;
    1728:	80 4d f6 02          	or     BYTE PTR [ebp-0xa],0x2
    172c:	eb 2e                	jmp    175c <internal_vprintf+0x118>
									else if (*fmt == '+')
    172e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1731:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1734:	3c 2b                	cmp    al,0x2b
    1736:	75 06                	jne    173e <internal_vprintf+0xfa>
											flags |= KFL_ALWAYS_SIGN;
    1738:	80 4d f6 04          	or     BYTE PTR [ebp-0xa],0x4
    173c:	eb 1e                	jmp    175c <internal_vprintf+0x118>
									else if (*fmt == '-')
    173e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1741:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1744:	3c 2d                	cmp    al,0x2d
    1746:	75 06                	jne    174e <internal_vprintf+0x10a>
											flags &= ~KFL_LEFT_ALIGN;
    1748:	80 65 f6 f7          	and    BYTE PTR [ebp-0xa],0xf7
    174c:	eb 0e                	jmp    175c <internal_vprintf+0x118>
									else if (*fmt == '#')
    174e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1751:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1754:	3c 23                	cmp    al,0x23
    1756:	75 04                	jne    175c <internal_vprintf+0x118>
											flags |= KFL_TYPE_PREFIX;
    1758:	80 4d f6 10          	or     BYTE PTR [ebp-0xa],0x10
									fmt++;
    175c:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
    1760:	e9 5d 08 00 00       	jmp    1fc2 <internal_vprintf+0x97e>
							} else if (is_fmt && *fmt >= '0' && *fmt <= '9') {
    1765:	80 7d f7 00          	cmp    BYTE PTR [ebp-0x9],0x0
    1769:	74 77                	je     17e2 <internal_vprintf+0x19e>
    176b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    176e:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1771:	3c 2f                	cmp    al,0x2f
    1773:	7e 6d                	jle    17e2 <internal_vprintf+0x19e>
    1775:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1778:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    177b:	3c 39                	cmp    al,0x39
    177d:	7f 63                	jg     17e2 <internal_vprintf+0x19e>
									if (is_fmt == 1)
    177f:	80 7d f7 01          	cmp    BYTE PTR [ebp-0x9],0x1
    1783:	75 04                	jne    1789 <internal_vprintf+0x145>
											is_fmt = 3;
    1785:	c6 45 f7 03          	mov    BYTE PTR [ebp-0x9],0x3
									if (is_fmt == 2) {
    1789:	80 7d f7 02          	cmp    BYTE PTR [ebp-0x9],0x2
    178d:	75 26                	jne    17b5 <internal_vprintf+0x171>
											prec *= 10;
    178f:	0f b6 55 f4          	movzx  edx,BYTE PTR [ebp-0xc]
    1793:	89 d0                	mov    eax,edx
    1795:	c1 e0 02             	shl    eax,0x2
    1798:	01 d0                	add    eax,edx
    179a:	01 c0                	add    eax,eax
    179c:	88 45 f4             	mov    BYTE PTR [ebp-0xc],al
											prec += (*fmt - '0');
    179f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    17a2:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    17a5:	89 c2                	mov    edx,eax
    17a7:	0f b6 45 f4          	movzx  eax,BYTE PTR [ebp-0xc]
    17ab:	01 d0                	add    eax,edx
    17ad:	83 e8 30             	sub    eax,0x30
    17b0:	88 45 f4             	mov    BYTE PTR [ebp-0xc],al
    17b3:	eb 24                	jmp    17d9 <internal_vprintf+0x195>
											width *= 10;
    17b5:	0f b6 55 f5          	movzx  edx,BYTE PTR [ebp-0xb]
    17b9:	89 d0                	mov    eax,edx
    17bb:	c1 e0 02             	shl    eax,0x2
    17be:	01 d0                	add    eax,edx
    17c0:	01 c0                	add    eax,eax
    17c2:	88 45 f5             	mov    BYTE PTR [ebp-0xb],al
											width += (*fmt - '0');
    17c5:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    17c8:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    17cb:	89 c2                	mov    edx,eax
    17cd:	0f b6 45 f5          	movzx  eax,BYTE PTR [ebp-0xb]
    17d1:	01 d0                	add    eax,edx
    17d3:	83 e8 30             	sub    eax,0x30
    17d6:	88 45 f5             	mov    BYTE PTR [ebp-0xb],al
									fmt++;
    17d9:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
    17dd:	e9 e0 07 00 00       	jmp    1fc2 <internal_vprintf+0x97e>
							} else if (is_fmt && *fmt == '.') {
    17e2:	80 7d f7 00          	cmp    BYTE PTR [ebp-0x9],0x0
    17e6:	74 17                	je     17ff <internal_vprintf+0x1bb>
    17e8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    17eb:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    17ee:	3c 2e                	cmp    al,0x2e
    17f0:	75 0d                	jne    17ff <internal_vprintf+0x1bb>
									is_fmt = 2;
    17f2:	c6 45 f7 02          	mov    BYTE PTR [ebp-0x9],0x2
									fmt++;
    17f6:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
    17fa:	e9 c3 07 00 00       	jmp    1fc2 <internal_vprintf+0x97e>
							} else if (is_fmt && *fmt == '*') {
    17ff:	80 7d f7 00          	cmp    BYTE PTR [ebp-0x9],0x0
    1803:	74 39                	je     183e <internal_vprintf+0x1fa>
    1805:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1808:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    180b:	3c 2a                	cmp    al,0x2a
    180d:	75 2f                	jne    183e <internal_vprintf+0x1fa>
									if (is_fmt == 2)
    180f:	80 7d f7 02          	cmp    BYTE PTR [ebp-0x9],0x2
    1813:	75 11                	jne    1826 <internal_vprintf+0x1e2>
											prec = va_arg(args, int);
    1815:	83 45 10 04          	add    DWORD PTR [ebp+0x10],0x4
    1819:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    181c:	83 e8 04             	sub    eax,0x4
    181f:	8b 00                	mov    eax,DWORD PTR [eax]
    1821:	88 45 f4             	mov    BYTE PTR [ebp-0xc],al
    1824:	eb 0f                	jmp    1835 <internal_vprintf+0x1f1>
											width = va_arg(args, int);
    1826:	83 45 10 04          	add    DWORD PTR [ebp+0x10],0x4
    182a:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    182d:	83 e8 04             	sub    eax,0x4
    1830:	8b 00                	mov    eax,DWORD PTR [eax]
    1832:	88 45 f5             	mov    BYTE PTR [ebp-0xb],al
									fmt++;
    1835:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
    1839:	e9 84 07 00 00       	jmp    1fc2 <internal_vprintf+0x97e>
							} else if (is_fmt) {
    183e:	80 7d f7 00          	cmp    BYTE PTR [ebp-0x9],0x0
    1842:	0f 84 54 07 00 00    	je     1f9c <internal_vprintf+0x958>
									if (is_fmt == 2 && !prec)
    1848:	80 7d f7 02          	cmp    BYTE PTR [ebp-0x9],0x2
    184c:	75 0a                	jne    1858 <internal_vprintf+0x214>
    184e:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
    1852:	75 04                	jne    1858 <internal_vprintf+0x214>
											prec = -1; /* no zero */
    1854:	c6 45 f4 ff          	mov    BYTE PTR [ebp-0xc],0xff
									if (*fmt == 'h') {
    1858:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    185b:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    185e:	3c 68                	cmp    al,0x68
    1860:	75 1e                	jne    1880 <internal_vprintf+0x23c>
											fmt++;
    1862:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
											if (*fmt == 'h') {
    1866:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1869:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    186c:	3c 68                	cmp    al,0x68
    186e:	75 0a                	jne    187a <internal_vprintf+0x236>
													size = 1; /* hh */
    1870:	c6 45 f3 01          	mov    BYTE PTR [ebp-0xd],0x1
													fmt++;
    1874:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
    1878:	eb 7c                	jmp    18f6 <internal_vprintf+0x2b2>
													size = 2; /* h */
    187a:	c6 45 f3 02          	mov    BYTE PTR [ebp-0xd],0x2
    187e:	eb 76                	jmp    18f6 <internal_vprintf+0x2b2>
									} else if (*fmt == 'l') {
    1880:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1883:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1886:	3c 6c                	cmp    al,0x6c
    1888:	75 1e                	jne    18a8 <internal_vprintf+0x264>
											fmt++;
    188a:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
											if (*fmt == 'l') {
    188e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1891:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1894:	3c 6c                	cmp    al,0x6c
    1896:	75 0a                	jne    18a2 <internal_vprintf+0x25e>
													size = 4; /* ll */
    1898:	c6 45 f3 04          	mov    BYTE PTR [ebp-0xd],0x4
													fmt++;
    189c:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
    18a0:	eb 54                	jmp    18f6 <internal_vprintf+0x2b2>
													size = 3;
    18a2:	c6 45 f3 03          	mov    BYTE PTR [ebp-0xd],0x3
    18a6:	eb 4e                	jmp    18f6 <internal_vprintf+0x2b2>
									} else if (*fmt == 'j') {
    18a8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    18ab:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    18ae:	3c 6a                	cmp    al,0x6a
    18b0:	75 0a                	jne    18bc <internal_vprintf+0x278>
											fmt++;
    18b2:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
											size = 5;
    18b6:	c6 45 f3 05          	mov    BYTE PTR [ebp-0xd],0x5
    18ba:	eb 3a                	jmp    18f6 <internal_vprintf+0x2b2>
									} else if (*fmt == 'z') {
    18bc:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    18bf:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    18c2:	3c 7a                	cmp    al,0x7a
    18c4:	75 0a                	jne    18d0 <internal_vprintf+0x28c>
											size = 6;
    18c6:	c6 45 f3 06          	mov    BYTE PTR [ebp-0xd],0x6
											fmt++;
    18ca:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
    18ce:	eb 26                	jmp    18f6 <internal_vprintf+0x2b2>
									} else if (*fmt == 't') {
    18d0:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    18d3:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    18d6:	3c 74                	cmp    al,0x74
    18d8:	75 0a                	jne    18e4 <internal_vprintf+0x2a0>
											size = 7;
    18da:	c6 45 f3 07          	mov    BYTE PTR [ebp-0xd],0x7
											fmt++;
    18de:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
    18e2:	eb 12                	jmp    18f6 <internal_vprintf+0x2b2>
									} else if (*fmt == 'L') {
    18e4:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    18e7:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    18ea:	3c 4c                	cmp    al,0x4c
    18ec:	75 08                	jne    18f6 <internal_vprintf+0x2b2>
											size = 8;
    18ee:	c6 45 f3 08          	mov    BYTE PTR [ebp-0xd],0x8
											fmt++;
    18f2:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
									if (*fmt == 'd' || *fmt == 'i') {
    18f6:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    18f9:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    18fc:	3c 64                	cmp    al,0x64
    18fe:	74 0e                	je     190e <internal_vprintf+0x2ca>
    1900:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1903:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1906:	3c 69                	cmp    al,0x69
    1908:	0f 85 25 01 00 00    	jne    1a33 <internal_vprintf+0x3ef>
											signed long long int val = 0;
    190e:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
    1915:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
											if (!size) val = va_arg(args, signed int);
    191c:	80 7d f3 00          	cmp    BYTE PTR [ebp-0xd],0x0
    1920:	75 18                	jne    193a <internal_vprintf+0x2f6>
    1922:	83 45 10 04          	add    DWORD PTR [ebp+0x10],0x4
    1926:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1929:	83 e8 04             	sub    eax,0x4
    192c:	8b 00                	mov    eax,DWORD PTR [eax]
    192e:	99                   	cdq
    192f:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1932:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
    1935:	e9 cd 00 00 00       	jmp    1a07 <internal_vprintf+0x3c3>
											else if (size == 1) val = va_arg(args, signed char);
    193a:	80 7d f3 01          	cmp    BYTE PTR [ebp-0xd],0x1
    193e:	75 1c                	jne    195c <internal_vprintf+0x318>
    1940:	83 45 10 04          	add    DWORD PTR [ebp+0x10],0x4
    1944:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1947:	83 e8 04             	sub    eax,0x4
    194a:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    194d:	0f be c0             	movsx  eax,al
    1950:	99                   	cdq
    1951:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1954:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
    1957:	e9 ab 00 00 00       	jmp    1a07 <internal_vprintf+0x3c3>
											else if (size == 2) val = va_arg(args, signed short int);
    195c:	80 7d f3 02          	cmp    BYTE PTR [ebp-0xd],0x2
    1960:	75 1a                	jne    197c <internal_vprintf+0x338>
    1962:	83 45 10 04          	add    DWORD PTR [ebp+0x10],0x4
    1966:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1969:	83 e8 04             	sub    eax,0x4
    196c:	0f b7 00             	movzx  eax,WORD PTR [eax]
    196f:	98                   	cwde
    1970:	99                   	cdq
    1971:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1974:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
    1977:	e9 8b 00 00 00       	jmp    1a07 <internal_vprintf+0x3c3>
											else if (size == 3) val = va_arg(args, signed long int);
    197c:	80 7d f3 03          	cmp    BYTE PTR [ebp-0xd],0x3
    1980:	75 15                	jne    1997 <internal_vprintf+0x353>
    1982:	83 45 10 04          	add    DWORD PTR [ebp+0x10],0x4
    1986:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1989:	83 e8 04             	sub    eax,0x4
    198c:	8b 00                	mov    eax,DWORD PTR [eax]
    198e:	99                   	cdq
    198f:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    1992:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
    1995:	eb 70                	jmp    1a07 <internal_vprintf+0x3c3>
											else if (size == 4) val = va_arg(args, signed long long int);
    1997:	80 7d f3 04          	cmp    BYTE PTR [ebp-0xd],0x4
    199b:	75 15                	jne    19b2 <internal_vprintf+0x36e>
    199d:	83 45 10 08          	add    DWORD PTR [ebp+0x10],0x8
    19a1:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    19a4:	8b 50 fc             	mov    edx,DWORD PTR [eax-0x4]
    19a7:	8b 40 f8             	mov    eax,DWORD PTR [eax-0x8]
    19aa:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    19ad:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
    19b0:	eb 55                	jmp    1a07 <internal_vprintf+0x3c3>
											else if (size == 5) val = va_arg(args, intmax_t);
    19b2:	80 7d f3 05          	cmp    BYTE PTR [ebp-0xd],0x5
    19b6:	75 15                	jne    19cd <internal_vprintf+0x389>
    19b8:	83 45 10 08          	add    DWORD PTR [ebp+0x10],0x8
    19bc:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    19bf:	8b 50 fc             	mov    edx,DWORD PTR [eax-0x4]
    19c2:	8b 40 f8             	mov    eax,DWORD PTR [eax-0x8]
    19c5:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    19c8:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
    19cb:	eb 3a                	jmp    1a07 <internal_vprintf+0x3c3>
											else if (size == 6) val = va_arg(args, ssize_t);
    19cd:	80 7d f3 06          	cmp    BYTE PTR [ebp-0xd],0x6
    19d1:	75 15                	jne    19e8 <internal_vprintf+0x3a4>
    19d3:	83 45 10 04          	add    DWORD PTR [ebp+0x10],0x4
    19d7:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    19da:	83 e8 04             	sub    eax,0x4
    19dd:	8b 00                	mov    eax,DWORD PTR [eax]
    19df:	99                   	cdq
    19e0:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    19e3:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
    19e6:	eb 1f                	jmp    1a07 <internal_vprintf+0x3c3>
											else if (size == 7) val = va_arg(args, ptrdiff_t);
    19e8:	80 7d f3 07          	cmp    BYTE PTR [ebp-0xd],0x7
    19ec:	75 15                	jne    1a03 <internal_vprintf+0x3bf>
    19ee:	83 45 10 04          	add    DWORD PTR [ebp+0x10],0x4
    19f2:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    19f5:	83 e8 04             	sub    eax,0x4
    19f8:	8b 00                	mov    eax,DWORD PTR [eax]
    19fa:	99                   	cdq
    19fb:	89 45 e0             	mov    DWORD PTR [ebp-0x20],eax
    19fe:	89 55 e4             	mov    DWORD PTR [ebp-0x1c],edx
    1a01:	eb 04                	jmp    1a07 <internal_vprintf+0x3c3>
											else (void)va_arg(args, long double); /* remove bogus value*/
    1a03:	83 45 10 0c          	add    DWORD PTR [ebp+0x10],0xc
											rv += putd(ctx, val, flags, width, prec);
    1a07:	0f be 5d f4          	movsx  ebx,BYTE PTR [ebp-0xc]
    1a0b:	0f be 4d f5          	movsx  ecx,BYTE PTR [ebp-0xb]
    1a0f:	0f be 55 f6          	movsx  edx,BYTE PTR [ebp-0xa]
    1a13:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1a16:	83 ec 08             	sub    esp,0x8
    1a19:	53                   	push   ebx
    1a1a:	51                   	push   ecx
    1a1b:	52                   	push   edx
    1a1c:	ff 75 e4             	push   DWORD PTR [ebp-0x1c]
    1a1f:	ff 75 e0             	push   DWORD PTR [ebp-0x20]
    1a22:	50                   	push   eax
    1a23:	e8 fc ff ff ff       	call   1a24 <internal_vprintf+0x3e0>
    1a28:	83 c4 20             	add    esp,0x20
    1a2b:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
									if (*fmt == 'd' || *fmt == 'i') {
    1a2e:	e9 4f 05 00 00       	jmp    1f82 <internal_vprintf+0x93e>
									} else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'u' || *fmt == 'o' || *fmt == 'b') {
    1a33:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1a36:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1a39:	3c 78                	cmp    al,0x78
    1a3b:	74 2c                	je     1a69 <internal_vprintf+0x425>
    1a3d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1a40:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1a43:	3c 58                	cmp    al,0x58
    1a45:	74 22                	je     1a69 <internal_vprintf+0x425>
    1a47:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1a4a:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1a4d:	3c 75                	cmp    al,0x75
    1a4f:	74 18                	je     1a69 <internal_vprintf+0x425>
    1a51:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1a54:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1a57:	3c 6f                	cmp    al,0x6f
    1a59:	74 0e                	je     1a69 <internal_vprintf+0x425>
    1a5b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1a5e:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1a61:	3c 62                	cmp    al,0x62
    1a63:	0f 85 2c 02 00 00    	jne    1c95 <internal_vprintf+0x651>
											unsigned long long int val = 0;
    1a69:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [ebp-0x28],0x0
    1a70:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
											if (!size) val = va_arg(args, unsigned int);
    1a77:	80 7d f3 00          	cmp    BYTE PTR [ebp-0xd],0x0
    1a7b:	75 1b                	jne    1a98 <internal_vprintf+0x454>
    1a7d:	83 45 10 04          	add    DWORD PTR [ebp+0x10],0x4
    1a81:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1a84:	83 e8 04             	sub    eax,0x4
    1a87:	8b 00                	mov    eax,DWORD PTR [eax]
    1a89:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    1a8c:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
    1a93:	e9 db 00 00 00       	jmp    1b73 <internal_vprintf+0x52f>
											else if (size == 1) val = va_arg(args, unsigned char);
    1a98:	80 7d f3 01          	cmp    BYTE PTR [ebp-0xd],0x1
    1a9c:	75 1f                	jne    1abd <internal_vprintf+0x479>
    1a9e:	83 45 10 04          	add    DWORD PTR [ebp+0x10],0x4
    1aa2:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1aa5:	83 e8 04             	sub    eax,0x4
    1aa8:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1aab:	0f b6 c0             	movzx  eax,al
    1aae:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    1ab1:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
    1ab8:	e9 b6 00 00 00       	jmp    1b73 <internal_vprintf+0x52f>
											else if (size == 2) val = va_arg(args, unsigned short int);
    1abd:	80 7d f3 02          	cmp    BYTE PTR [ebp-0xd],0x2
    1ac1:	75 1f                	jne    1ae2 <internal_vprintf+0x49e>
    1ac3:	83 45 10 04          	add    DWORD PTR [ebp+0x10],0x4
    1ac7:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1aca:	83 e8 04             	sub    eax,0x4
    1acd:	0f b7 00             	movzx  eax,WORD PTR [eax]
    1ad0:	0f b7 c0             	movzx  eax,ax
    1ad3:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    1ad6:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
    1add:	e9 91 00 00 00       	jmp    1b73 <internal_vprintf+0x52f>
											else if (size == 3) val = va_arg(args, unsigned long int);
    1ae2:	80 7d f3 03          	cmp    BYTE PTR [ebp-0xd],0x3
    1ae6:	75 18                	jne    1b00 <internal_vprintf+0x4bc>
    1ae8:	83 45 10 04          	add    DWORD PTR [ebp+0x10],0x4
    1aec:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1aef:	83 e8 04             	sub    eax,0x4
    1af2:	8b 00                	mov    eax,DWORD PTR [eax]
    1af4:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    1af7:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
    1afe:	eb 73                	jmp    1b73 <internal_vprintf+0x52f>
											else if (size == 4) val = va_arg(args, unsigned long long int);
    1b00:	80 7d f3 04          	cmp    BYTE PTR [ebp-0xd],0x4
    1b04:	75 15                	jne    1b1b <internal_vprintf+0x4d7>
    1b06:	83 45 10 08          	add    DWORD PTR [ebp+0x10],0x8
    1b0a:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1b0d:	8b 50 fc             	mov    edx,DWORD PTR [eax-0x4]
    1b10:	8b 40 f8             	mov    eax,DWORD PTR [eax-0x8]
    1b13:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    1b16:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
    1b19:	eb 58                	jmp    1b73 <internal_vprintf+0x52f>
											else if (size == 5) val = va_arg(args, uintmax_t);
    1b1b:	80 7d f3 05          	cmp    BYTE PTR [ebp-0xd],0x5
    1b1f:	75 15                	jne    1b36 <internal_vprintf+0x4f2>
    1b21:	83 45 10 08          	add    DWORD PTR [ebp+0x10],0x8
    1b25:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1b28:	8b 50 fc             	mov    edx,DWORD PTR [eax-0x4]
    1b2b:	8b 40 f8             	mov    eax,DWORD PTR [eax-0x8]
    1b2e:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    1b31:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
    1b34:	eb 3d                	jmp    1b73 <internal_vprintf+0x52f>
											else if (size == 6) val = va_arg(args, size_t);
    1b36:	80 7d f3 06          	cmp    BYTE PTR [ebp-0xd],0x6
    1b3a:	75 18                	jne    1b54 <internal_vprintf+0x510>
    1b3c:	83 45 10 04          	add    DWORD PTR [ebp+0x10],0x4
    1b40:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1b43:	83 e8 04             	sub    eax,0x4
    1b46:	8b 00                	mov    eax,DWORD PTR [eax]
    1b48:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    1b4b:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
    1b52:	eb 1f                	jmp    1b73 <internal_vprintf+0x52f>
											else if (size == 7) val = va_arg(args, ptrdiff_t);
    1b54:	80 7d f3 07          	cmp    BYTE PTR [ebp-0xd],0x7
    1b58:	75 15                	jne    1b6f <internal_vprintf+0x52b>
    1b5a:	83 45 10 04          	add    DWORD PTR [ebp+0x10],0x4
    1b5e:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1b61:	83 e8 04             	sub    eax,0x4
    1b64:	8b 00                	mov    eax,DWORD PTR [eax]
    1b66:	99                   	cdq
    1b67:	89 45 d8             	mov    DWORD PTR [ebp-0x28],eax
    1b6a:	89 55 dc             	mov    DWORD PTR [ebp-0x24],edx
    1b6d:	eb 04                	jmp    1b73 <internal_vprintf+0x52f>
											else (void)va_arg(args, long double); /* remove bogus value*/
    1b6f:	83 45 10 0c          	add    DWORD PTR [ebp+0x10],0xc
											if (*fmt == 'x')
    1b73:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1b76:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1b79:	3c 78                	cmp    al,0x78
    1b7b:	75 32                	jne    1baf <internal_vprintf+0x56b>
													rv += putu(ctx, val, flags | KFL_IS_HEX, width, prec);
    1b7d:	0f be 5d f4          	movsx  ebx,BYTE PTR [ebp-0xc]
    1b81:	0f be 4d f5          	movsx  ecx,BYTE PTR [ebp-0xb]
    1b85:	0f b6 45 f6          	movzx  eax,BYTE PTR [ebp-0xa]
    1b89:	83 c8 01             	or     eax,0x1
    1b8c:	0f be d0             	movsx  edx,al
    1b8f:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1b92:	83 ec 08             	sub    esp,0x8
    1b95:	53                   	push   ebx
    1b96:	51                   	push   ecx
    1b97:	52                   	push   edx
    1b98:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
    1b9b:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
    1b9e:	50                   	push   eax
    1b9f:	e8 fc ff ff ff       	call   1ba0 <internal_vprintf+0x55c>
    1ba4:	83 c4 20             	add    esp,0x20
    1ba7:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
									} else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'u' || *fmt == 'o' || *fmt == 'b') {
    1baa:	e9 d2 03 00 00       	jmp    1f81 <internal_vprintf+0x93d>
											else if (*fmt == 'X')
    1baf:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1bb2:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1bb5:	3c 58                	cmp    al,0x58
    1bb7:	75 32                	jne    1beb <internal_vprintf+0x5a7>
													rv += putu(ctx, val, flags | KFL_IS_HEX | KFL_CAPITAL, width, prec);
    1bb9:	0f be 5d f4          	movsx  ebx,BYTE PTR [ebp-0xc]
    1bbd:	0f be 4d f5          	movsx  ecx,BYTE PTR [ebp-0xb]
    1bc1:	0f b6 45 f6          	movzx  eax,BYTE PTR [ebp-0xa]
    1bc5:	83 c8 81             	or     eax,0xffffff81
    1bc8:	0f be d0             	movsx  edx,al
    1bcb:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1bce:	83 ec 08             	sub    esp,0x8
    1bd1:	53                   	push   ebx
    1bd2:	51                   	push   ecx
    1bd3:	52                   	push   edx
    1bd4:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
    1bd7:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
    1bda:	50                   	push   eax
    1bdb:	e8 fc ff ff ff       	call   1bdc <internal_vprintf+0x598>
    1be0:	83 c4 20             	add    esp,0x20
    1be3:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
									} else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'u' || *fmt == 'o' || *fmt == 'b') {
    1be6:	e9 96 03 00 00       	jmp    1f81 <internal_vprintf+0x93d>
											else if (*fmt == 'u')
    1beb:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1bee:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1bf1:	3c 75                	cmp    al,0x75
    1bf3:	75 2c                	jne    1c21 <internal_vprintf+0x5dd>
													rv += putu(ctx, val, flags, width, prec);
    1bf5:	0f be 5d f4          	movsx  ebx,BYTE PTR [ebp-0xc]
    1bf9:	0f be 4d f5          	movsx  ecx,BYTE PTR [ebp-0xb]
    1bfd:	0f be 55 f6          	movsx  edx,BYTE PTR [ebp-0xa]
    1c01:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1c04:	83 ec 08             	sub    esp,0x8
    1c07:	53                   	push   ebx
    1c08:	51                   	push   ecx
    1c09:	52                   	push   edx
    1c0a:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
    1c0d:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
    1c10:	50                   	push   eax
    1c11:	e8 fc ff ff ff       	call   1c12 <internal_vprintf+0x5ce>
    1c16:	83 c4 20             	add    esp,0x20
    1c19:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
									} else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'u' || *fmt == 'o' || *fmt == 'b') {
    1c1c:	e9 60 03 00 00       	jmp    1f81 <internal_vprintf+0x93d>
											else if (*fmt == 'o')
    1c21:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1c24:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1c27:	3c 6f                	cmp    al,0x6f
    1c29:	75 32                	jne    1c5d <internal_vprintf+0x619>
													rv += putu(ctx, val, flags | KFL_IS_OCT, width, prec);
    1c2b:	0f be 5d f4          	movsx  ebx,BYTE PTR [ebp-0xc]
    1c2f:	0f be 4d f5          	movsx  ecx,BYTE PTR [ebp-0xb]
    1c33:	0f b6 45 f6          	movzx  eax,BYTE PTR [ebp-0xa]
    1c37:	83 c8 40             	or     eax,0x40
    1c3a:	0f be d0             	movsx  edx,al
    1c3d:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1c40:	83 ec 08             	sub    esp,0x8
    1c43:	53                   	push   ebx
    1c44:	51                   	push   ecx
    1c45:	52                   	push   edx
    1c46:	ff 75 dc             	push   DWORD PTR [ebp-0x24]
    1c49:	ff 75 d8             	push   DWORD PTR [ebp-0x28]
    1c4c:	50                   	push   eax
    1c4d:	e8 fc ff ff ff       	call   1c4e <internal_vprintf+0x60a>
    1c52:	83 c4 20             	add    esp,0x20
    1c55:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
									} else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'u' || *fmt == 'o' || *fmt == 'b') {
    1c58:	e9 24 03 00 00       	jmp    1f81 <internal_vprintf+0x93d>
											else if (*fmt == 'b')
    1c5d:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1c60:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1c63:	3c 62                	cmp    al,0x62
    1c65:	0f 85 16 03 00 00    	jne    1f81 <internal_vprintf+0x93d>
													rv += putb(ctx, val, flags, width, prec);
    1c6b:	0f be 75 f4          	movsx  esi,BYTE PTR [ebp-0xc]
    1c6f:	0f be 5d f5          	movsx  ebx,BYTE PTR [ebp-0xb]
    1c73:	0f be 4d f6          	movsx  ecx,BYTE PTR [ebp-0xa]
    1c77:	8b 55 d8             	mov    edx,DWORD PTR [ebp-0x28]
    1c7a:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1c7d:	83 ec 0c             	sub    esp,0xc
    1c80:	56                   	push   esi
    1c81:	53                   	push   ebx
    1c82:	51                   	push   ecx
    1c83:	52                   	push   edx
    1c84:	50                   	push   eax
    1c85:	e8 fc ff ff ff       	call   1c86 <internal_vprintf+0x642>
    1c8a:	83 c4 20             	add    esp,0x20
    1c8d:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
									} else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'u' || *fmt == 'o' || *fmt == 'b') {
    1c90:	e9 ec 02 00 00       	jmp    1f81 <internal_vprintf+0x93d>
									} else if(*fmt == 'p')/* {
    1c95:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1c98:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1c9b:	3c 70                	cmp    al,0x70
    1c9d:	75 30                	jne    1ccf <internal_vprintf+0x68b>
											rv += putu(ctx, (uint64_t)(uintptr_t)va_arg(args, void*), /*KFL_ZERO_PREFIX |*/ KFL_IS_HEX,
    1c9f:	83 45 10 04          	add    DWORD PTR [ebp+0x10],0x4
    1ca3:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1ca6:	83 e8 04             	sub    eax,0x4
    1ca9:	8b 00                	mov    eax,DWORD PTR [eax]
    1cab:	ba 00 00 00 00       	mov    edx,0x0
    1cb0:	8b 4d c8             	mov    ecx,DWORD PTR [ebp-0x38]
    1cb3:	83 ec 08             	sub    esp,0x8
    1cb6:	6a 08                	push   0x8
    1cb8:	6a 00                	push   0x0
    1cba:	6a 01                	push   0x1
    1cbc:	52                   	push   edx
    1cbd:	50                   	push   eax
    1cbe:	51                   	push   ecx
    1cbf:	e8 fc ff ff ff       	call   1cc0 <internal_vprintf+0x67c>
    1cc4:	83 c4 20             	add    esp,0x20
    1cc7:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
    1cca:	e9 b3 02 00 00       	jmp    1f82 <internal_vprintf+0x93e>
									else if (*fmt == 's') {
    1ccf:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1cd2:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1cd5:	3c 73                	cmp    al,0x73
    1cd7:	0f 85 37 01 00 00    	jne    1e14 <internal_vprintf+0x7d0>
											const char* str = va_arg(args, const char*);
    1cdd:	83 45 10 04          	add    DWORD PTR [ebp+0x10],0x4
    1ce1:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1ce4:	8b 40 fc             	mov    eax,DWORD PTR [eax-0x4]
    1ce7:	89 45 d4             	mov    DWORD PTR [ebp-0x2c],eax
											if(str) {
    1cea:	83 7d d4 00          	cmp    DWORD PTR [ebp-0x2c],0x0
    1cee:	0f 84 06 01 00 00    	je     1dfa <internal_vprintf+0x7b6>
													size_t l = strlen(str);
    1cf4:	83 ec 0c             	sub    esp,0xc
    1cf7:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    1cfa:	e8 fc ff ff ff       	call   1cfb <internal_vprintf+0x6b7>
    1cff:	83 c4 10             	add    esp,0x10
    1d02:	89 45 d0             	mov    DWORD PTR [ebp-0x30],eax
													if ((size_t)width > l) {
    1d05:	0f be 45 f5          	movsx  eax,BYTE PTR [ebp-0xb]
    1d09:	39 45 d0             	cmp    DWORD PTR [ebp-0x30],eax
    1d0c:	73 72                	jae    1d80 <internal_vprintf+0x73c>
															if (!(flags & KFL_LEFT_ALIGN))
    1d0e:	0f be 45 f6          	movsx  eax,BYTE PTR [ebp-0xa]
    1d12:	83 e0 08             	and    eax,0x8
    1d15:	85 c0                	test   eax,eax
    1d17:	75 29                	jne    1d42 <internal_vprintf+0x6fe>
																	cputs(str);
    1d19:	83 ec 0c             	sub    esp,0xc
    1d1c:	8d 45 c8             	lea    eax,[ebp-0x38]
    1d1f:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    1d22:	89 c1                	mov    ecx,eax
    1d24:	e8 dc f8 ff ff       	call   1605 <cputs.0>
    1d29:	83 c4 10             	add    esp,0x10
															while ((size_t)(width--) > l)
    1d2c:	eb 14                	jmp    1d42 <internal_vprintf+0x6fe>
																	ctx->putchar(ctx, ' ');
    1d2e:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1d31:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1d34:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
    1d37:	83 ec 08             	sub    esp,0x8
    1d3a:	6a 20                	push   0x20
    1d3c:	52                   	push   edx
    1d3d:	ff d0                	call   eax
    1d3f:	83 c4 10             	add    esp,0x10
															while ((size_t)(width--) > l)
    1d42:	0f b6 45 f5          	movzx  eax,BYTE PTR [ebp-0xb]
    1d46:	89 c2                	mov    edx,eax
    1d48:	83 ea 01             	sub    edx,0x1
    1d4b:	88 55 f5             	mov    BYTE PTR [ebp-0xb],dl
    1d4e:	0f be c0             	movsx  eax,al
    1d51:	39 45 d0             	cmp    DWORD PTR [ebp-0x30],eax
    1d54:	72 d8                	jb     1d2e <internal_vprintf+0x6ea>
															if (flags & KFL_LEFT_ALIGN)
    1d56:	0f be 45 f6          	movsx  eax,BYTE PTR [ebp-0xa]
    1d5a:	83 e0 08             	and    eax,0x8
    1d5d:	85 c0                	test   eax,eax
    1d5f:	74 13                	je     1d74 <internal_vprintf+0x730>
																	cputs(str);
    1d61:	83 ec 0c             	sub    esp,0xc
    1d64:	8d 45 c8             	lea    eax,[ebp-0x38]
    1d67:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    1d6a:	89 c1                	mov    ecx,eax
    1d6c:	e8 94 f8 ff ff       	call   1605 <cputs.0>
    1d71:	83 c4 10             	add    esp,0x10
															rv += width;
    1d74:	0f be 45 f5          	movsx  eax,BYTE PTR [ebp-0xb]
    1d78:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
    1d7b:	e9 02 02 00 00       	jmp    1f82 <internal_vprintf+0x93e>
													} else if (prec && l > (size_t)prec) {
    1d80:	80 7d f4 00          	cmp    BYTE PTR [ebp-0xc],0x0
    1d84:	74 51                	je     1dd7 <internal_vprintf+0x793>
    1d86:	0f be 45 f4          	movsx  eax,BYTE PTR [ebp-0xc]
    1d8a:	3b 45 d0             	cmp    eax,DWORD PTR [ebp-0x30]
    1d8d:	73 48                	jae    1dd7 <internal_vprintf+0x793>
															rv += prec;
    1d8f:	0f be 45 f4          	movsx  eax,BYTE PTR [ebp-0xc]
    1d93:	01 45 ec             	add    DWORD PTR [ebp-0x14],eax
															l = 0;
    1d96:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [ebp-0x30],0x0
															while (l++ < (size_t)prec)
    1d9d:	eb 22                	jmp    1dc1 <internal_vprintf+0x77d>
																	ctx->putchar(ctx, *str++);
    1d9f:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1da2:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    1da5:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    1da8:	8d 48 01             	lea    ecx,[eax+0x1]
    1dab:	89 4d d4             	mov    DWORD PTR [ebp-0x2c],ecx
    1dae:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1db1:	0f be c8             	movsx  ecx,al
    1db4:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1db7:	83 ec 08             	sub    esp,0x8
    1dba:	51                   	push   ecx
    1dbb:	50                   	push   eax
    1dbc:	ff d2                	call   edx
    1dbe:	83 c4 10             	add    esp,0x10
															while (l++ < (size_t)prec)
    1dc1:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1dc4:	8d 50 01             	lea    edx,[eax+0x1]
    1dc7:	89 55 d0             	mov    DWORD PTR [ebp-0x30],edx
    1dca:	0f be 55 f4          	movsx  edx,BYTE PTR [ebp-0xc]
    1dce:	39 d0                	cmp    eax,edx
    1dd0:	72 cd                	jb     1d9f <internal_vprintf+0x75b>
													} else if (prec && l > (size_t)prec) {
    1dd2:	e9 ab 01 00 00       	jmp    1f82 <internal_vprintf+0x93e>
													} else {
															rv += l;
    1dd7:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1dda:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    1ddd:	01 d0                	add    eax,edx
    1ddf:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
															cputs(str);
    1de2:	83 ec 0c             	sub    esp,0xc
    1de5:	8d 45 c8             	lea    eax,[ebp-0x38]
    1de8:	ff 75 d4             	push   DWORD PTR [ebp-0x2c]
    1deb:	89 c1                	mov    ecx,eax
    1ded:	e8 13 f8 ff ff       	call   1605 <cputs.0>
    1df2:	83 c4 10             	add    esp,0x10
    1df5:	e9 88 01 00 00       	jmp    1f82 <internal_vprintf+0x93e>
													}
											}
											else
													cputs("(null)");
    1dfa:	83 ec 0c             	sub    esp,0xc
    1dfd:	8d 45 c8             	lea    eax,[ebp-0x38]
    1e00:	68 8a 00 00 00       	push   0x8a
    1e05:	89 c1                	mov    ecx,eax
    1e07:	e8 f9 f7 ff ff       	call   1605 <cputs.0>
    1e0c:	83 c4 10             	add    esp,0x10
    1e0f:	e9 6e 01 00 00       	jmp    1f82 <internal_vprintf+0x93e>
									} else if (*fmt == 'c') {
    1e14:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1e17:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1e1a:	3c 63                	cmp    al,0x63
    1e1c:	75 2b                	jne    1e49 <internal_vprintf+0x805>
											ctx->putchar(ctx, (char)va_arg(args, int));
    1e1e:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1e21:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1e24:	83 45 10 04          	add    DWORD PTR [ebp+0x10],0x4
    1e28:	8b 55 10             	mov    edx,DWORD PTR [ebp+0x10]
    1e2b:	83 ea 04             	sub    edx,0x4
    1e2e:	8b 12                	mov    edx,DWORD PTR [edx]
    1e30:	0f be ca             	movsx  ecx,dl
    1e33:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
    1e36:	83 ec 08             	sub    esp,0x8
    1e39:	51                   	push   ecx
    1e3a:	52                   	push   edx
    1e3b:	ff d0                	call   eax
    1e3d:	83 c4 10             	add    esp,0x10
											rv++;
    1e40:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
    1e44:	e9 39 01 00 00       	jmp    1f82 <internal_vprintf+0x93e>
									} else if (*fmt == 'f')
    1e49:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1e4c:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1e4f:	3c 66                	cmp    al,0x66
    1e51:	0f 84 2b 01 00 00    	je     1f82 <internal_vprintf+0x93e>
											/* FPU init needed? */;
									else if (*fmt == 'n') {
    1e57:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1e5a:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1e5d:	3c 6e                	cmp    al,0x6e
    1e5f:	0f 85 e6 00 00 00    	jne    1f4b <internal_vprintf+0x907>
											if (!size)
    1e65:	80 7d f3 00          	cmp    BYTE PTR [ebp-0xd],0x0
    1e69:	75 16                	jne    1e81 <internal_vprintf+0x83d>
													*va_arg(args, int*) = (int)rv;
    1e6b:	83 45 10 04          	add    DWORD PTR [ebp+0x10],0x4
    1e6f:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1e72:	83 e8 04             	sub    eax,0x4
    1e75:	8b 00                	mov    eax,DWORD PTR [eax]
    1e77:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1e7a:	89 10                	mov    DWORD PTR [eax],edx
    1e7c:	e9 01 01 00 00       	jmp    1f82 <internal_vprintf+0x93e>
											else if (size == 1)
    1e81:	80 7d f3 01          	cmp    BYTE PTR [ebp-0xd],0x1
    1e85:	75 16                	jne    1e9d <internal_vprintf+0x859>
													*va_arg(args, signed char*) = (signed char)rv;
    1e87:	83 45 10 04          	add    DWORD PTR [ebp+0x10],0x4
    1e8b:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1e8e:	83 e8 04             	sub    eax,0x4
    1e91:	8b 00                	mov    eax,DWORD PTR [eax]
    1e93:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1e96:	88 10                	mov    BYTE PTR [eax],dl
    1e98:	e9 e5 00 00 00       	jmp    1f82 <internal_vprintf+0x93e>
											else if (size == 2)
    1e9d:	80 7d f3 02          	cmp    BYTE PTR [ebp-0xd],0x2
    1ea1:	75 17                	jne    1eba <internal_vprintf+0x876>
													*va_arg(args, short int*) = (short int)rv;
    1ea3:	83 45 10 04          	add    DWORD PTR [ebp+0x10],0x4
    1ea7:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1eaa:	83 e8 04             	sub    eax,0x4
    1ead:	8b 00                	mov    eax,DWORD PTR [eax]
    1eaf:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1eb2:	66 89 10             	mov    WORD PTR [eax],dx
    1eb5:	e9 c8 00 00 00       	jmp    1f82 <internal_vprintf+0x93e>
											else if (size == 3)
    1eba:	80 7d f3 03          	cmp    BYTE PTR [ebp-0xd],0x3
    1ebe:	75 16                	jne    1ed6 <internal_vprintf+0x892>
													*va_arg(args, long int*) = (long int)rv;
    1ec0:	83 45 10 04          	add    DWORD PTR [ebp+0x10],0x4
    1ec4:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1ec7:	83 e8 04             	sub    eax,0x4
    1eca:	8b 00                	mov    eax,DWORD PTR [eax]
    1ecc:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1ecf:	89 10                	mov    DWORD PTR [eax],edx
    1ed1:	e9 ac 00 00 00       	jmp    1f82 <internal_vprintf+0x93e>
											else if (size == 4)
    1ed6:	80 7d f3 04          	cmp    BYTE PTR [ebp-0xd],0x4
    1eda:	75 1a                	jne    1ef6 <internal_vprintf+0x8b2>
													*va_arg(args, long long int*) = (long long int)rv;
    1edc:	83 45 10 04          	add    DWORD PTR [ebp+0x10],0x4
    1ee0:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1ee3:	83 e8 04             	sub    eax,0x4
    1ee6:	8b 08                	mov    ecx,DWORD PTR [eax]
    1ee8:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1eeb:	99                   	cdq
    1eec:	89 01                	mov    DWORD PTR [ecx],eax
    1eee:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
    1ef1:	e9 8c 00 00 00       	jmp    1f82 <internal_vprintf+0x93e>
											else if (size == 5)
    1ef6:	80 7d f3 05          	cmp    BYTE PTR [ebp-0xd],0x5
    1efa:	75 17                	jne    1f13 <internal_vprintf+0x8cf>
													*va_arg(args, intmax_t*) = (intmax_t)rv;
    1efc:	83 45 10 04          	add    DWORD PTR [ebp+0x10],0x4
    1f00:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1f03:	83 e8 04             	sub    eax,0x4
    1f06:	8b 08                	mov    ecx,DWORD PTR [eax]
    1f08:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
    1f0b:	99                   	cdq
    1f0c:	89 01                	mov    DWORD PTR [ecx],eax
    1f0e:	89 51 04             	mov    DWORD PTR [ecx+0x4],edx
    1f11:	eb 6f                	jmp    1f82 <internal_vprintf+0x93e>
											else if (size == 6)
    1f13:	80 7d f3 06          	cmp    BYTE PTR [ebp-0xd],0x6
    1f17:	75 13                	jne    1f2c <internal_vprintf+0x8e8>
													*va_arg(args, ssize_t*) = (ssize_t)rv;
    1f19:	83 45 10 04          	add    DWORD PTR [ebp+0x10],0x4
    1f1d:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1f20:	83 e8 04             	sub    eax,0x4
    1f23:	8b 00                	mov    eax,DWORD PTR [eax]
    1f25:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1f28:	89 10                	mov    DWORD PTR [eax],edx
    1f2a:	eb 56                	jmp    1f82 <internal_vprintf+0x93e>
											else if (size == 7)
    1f2c:	80 7d f3 07          	cmp    BYTE PTR [ebp-0xd],0x7
    1f30:	75 13                	jne    1f45 <internal_vprintf+0x901>
													*va_arg(args, ptrdiff_t*) = (ptrdiff_t)rv;
    1f32:	83 45 10 04          	add    DWORD PTR [ebp+0x10],0x4
    1f36:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    1f39:	83 e8 04             	sub    eax,0x4
    1f3c:	8b 00                	mov    eax,DWORD PTR [eax]
    1f3e:	8b 55 ec             	mov    edx,DWORD PTR [ebp-0x14]
    1f41:	89 10                	mov    DWORD PTR [eax],edx
    1f43:	eb 3d                	jmp    1f82 <internal_vprintf+0x93e>
											else
													(void)va_arg(args, long double*);
    1f45:	83 45 10 04          	add    DWORD PTR [ebp+0x10],0x4
    1f49:	eb 37                	jmp    1f82 <internal_vprintf+0x93e>
									} else { /* ignore */
											ctx->putchar(ctx, '%');
    1f4b:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1f4e:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1f51:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
    1f54:	83 ec 08             	sub    esp,0x8
    1f57:	6a 25                	push   0x25
    1f59:	52                   	push   edx
    1f5a:	ff d0                	call   eax
    1f5c:	83 c4 10             	add    esp,0x10
											ctx->putchar(ctx, *fmt);
    1f5f:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1f62:	8b 40 08             	mov    eax,DWORD PTR [eax+0x8]
    1f65:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    1f68:	0f b6 12             	movzx  edx,BYTE PTR [edx]
    1f6b:	0f be ca             	movsx  ecx,dl
    1f6e:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
    1f71:	83 ec 08             	sub    esp,0x8
    1f74:	51                   	push   ecx
    1f75:	52                   	push   edx
    1f76:	ff d0                	call   eax
    1f78:	83 c4 10             	add    esp,0x10
											rv += 2;
    1f7b:	83 45 ec 02          	add    DWORD PTR [ebp-0x14],0x2
    1f7f:	eb 01                	jmp    1f82 <internal_vprintf+0x93e>
									} else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'u' || *fmt == 'o' || *fmt == 'b') {
    1f81:	90                   	nop
									}
									fmt++;
    1f82:	83 45 0c 01          	add    DWORD PTR [ebp+0xc],0x1
									is_fmt = 0;
    1f86:	c6 45 f7 00          	mov    BYTE PTR [ebp-0x9],0x0
									flags = KFL_LEFT_ALIGN;
    1f8a:	c6 45 f6 08          	mov    BYTE PTR [ebp-0xa],0x8
									width = 0;
    1f8e:	c6 45 f5 00          	mov    BYTE PTR [ebp-0xb],0x0
									prec = 0;
    1f92:	c6 45 f4 00          	mov    BYTE PTR [ebp-0xc],0x0
									size = 0;
    1f96:	c6 45 f3 00          	mov    BYTE PTR [ebp-0xd],0x0
    1f9a:	eb 26                	jmp    1fc2 <internal_vprintf+0x97e>
							} else {
									ctx->putchar(ctx, *(fmt++));
    1f9c:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1f9f:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
    1fa2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1fa5:	8d 48 01             	lea    ecx,[eax+0x1]
    1fa8:	89 4d 0c             	mov    DWORD PTR [ebp+0xc],ecx
    1fab:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1fae:	0f be c8             	movsx  ecx,al
    1fb1:	8b 45 c8             	mov    eax,DWORD PTR [ebp-0x38]
    1fb4:	83 ec 08             	sub    esp,0x8
    1fb7:	51                   	push   ecx
    1fb8:	50                   	push   eax
    1fb9:	ff d2                	call   edx
    1fbb:	83 c4 10             	add    esp,0x10
									rv++;
    1fbe:	83 45 ec 01          	add    DWORD PTR [ebp-0x14],0x1
		while (*fmt) {
    1fc2:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1fc5:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    1fc8:	84 c0                	test   al,al
    1fca:	0f 85 a8 f6 ff ff    	jne    1678 <internal_vprintf+0x34>
							}
			}
		}
		return rv;
    1fd0:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
}
    1fd3:	8d 65 f8             	lea    esp,[ebp-0x8]
    1fd6:	5b                   	pop    ebx
    1fd7:	5e                   	pop    esi
    1fd8:	5d                   	pop    ebp
    1fd9:	c3                   	ret

00001fda <ctx_c_putchar>:

void ctx_c_putchar(struct ivp_ctx* ctx, char c)
{
    1fda:	55                   	push   ebp
    1fdb:	89 e5                	mov    ebp,esp
    1fdd:	83 ec 18             	sub    esp,0x18
    1fe0:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    1fe3:	88 45 f4             	mov    BYTE PTR [ebp-0xc],al
		region_putchar(ctx->buf, c);
    1fe6:	0f be 55 f4          	movsx  edx,BYTE PTR [ebp-0xc]
    1fea:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    1fed:	8b 00                	mov    eax,DWORD PTR [eax]
    1fef:	83 ec 08             	sub    esp,0x8
    1ff2:	52                   	push   edx
    1ff3:	50                   	push   eax
    1ff4:	e8 fc ff ff ff       	call   1ff5 <ctx_c_putchar+0x1b>
    1ff9:	83 c4 10             	add    esp,0x10
}
    1ffc:	90                   	nop
    1ffd:	c9                   	leave
    1ffe:	c3                   	ret

00001fff <ctx_s_putchar>:

void ctx_s_putchar(struct ivp_ctx* ctx, char c)
{
    1fff:	55                   	push   ebp
    2000:	89 e5                	mov    ebp,esp
    2002:	83 ec 04             	sub    esp,0x4
    2005:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2008:	88 45 fc             	mov    BYTE PTR [ebp-0x4],al
		if (ctx->buf) {
    200b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    200e:	8b 00                	mov    eax,DWORD PTR [eax]
    2010:	85 c0                	test   eax,eax
    2012:	74 37                	je     204b <ctx_s_putchar+0x4c>
				if (!ctx->n) {
    2014:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2017:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    201a:	85 c0                	test   eax,eax
    201c:	75 0b                	jne    2029 <ctx_s_putchar+0x2a>
						ctx->buf = NULL;
    201e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2021:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
						return;
    2027:	eb 22                	jmp    204b <ctx_s_putchar+0x4c>
				}
				*ctx->buf++ = c;
    2029:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    202c:	8b 00                	mov    eax,DWORD PTR [eax]
    202e:	8d 48 01             	lea    ecx,[eax+0x1]
    2031:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    2034:	89 0a                	mov    DWORD PTR [edx],ecx
    2036:	0f b6 55 fc          	movzx  edx,BYTE PTR [ebp-0x4]
    203a:	88 10                	mov    BYTE PTR [eax],dl
				ctx->n--;
    203c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    203f:	8b 40 04             	mov    eax,DWORD PTR [eax+0x4]
    2042:	8d 50 ff             	lea    edx,[eax-0x1]
    2045:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2048:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
		}
}
    204b:	c9                   	leave
    204c:	c3                   	ret

0000204d <vrprintf>:

int vrprintf(struct kio_region* cr, const char* fmt, va_list args)
{
    204d:	55                   	push   ebp
    204e:	89 e5                	mov    ebp,esp
    2050:	83 ec 18             	sub    esp,0x18
		int rv;
		struct ivp_ctx ct = {cr, 0, &ctx_c_putchar};
    2053:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2056:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
    2059:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
    2060:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
		rv = internal_vprintf(&ct, fmt, args);
    2067:	83 ec 04             	sub    esp,0x4
    206a:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    206d:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    2070:	8d 45 e8             	lea    eax,[ebp-0x18]
    2073:	50                   	push   eax
    2074:	e8 fc ff ff ff       	call   2075 <vrprintf+0x28>
    2079:	83 c4 10             	add    esp,0x10
    207c:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		return rv;
    207f:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    2082:	c9                   	leave
    2083:	c3                   	ret

00002084 <vprintf>:

int vprintf(const char* fmt, va_list args)
{
    2084:	55                   	push   ebp
    2085:	89 e5                	mov    ebp,esp
    2087:	83 ec 18             	sub    esp,0x18
		int rv;
		struct ivp_ctx ct = {&reg_def, 0, &ctx_c_putchar};
    208a:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
    2091:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
    2098:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
		rv = internal_vprintf(&ct, fmt, args);
    209f:	83 ec 04             	sub    esp,0x4
    20a2:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    20a5:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    20a8:	8d 45 e8             	lea    eax,[ebp-0x18]
    20ab:	50                   	push   eax
    20ac:	e8 fc ff ff ff       	call   20ad <vprintf+0x29>
    20b1:	83 c4 10             	add    esp,0x10
    20b4:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		return rv;
    20b7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
}
    20ba:	c9                   	leave
    20bb:	c3                   	ret

000020bc <rprintf>:

/* with region ptr, region has lock & spin_trylock & lock-free add-buffer
  & malloc in irq question */
int rprintf(struct kio_region* cr, const char* fmt, ...)
{
    20bc:	55                   	push   ebp
    20bd:	89 e5                	mov    ebp,esp
    20bf:	83 ec 18             	sub    esp,0x18
		int rv;
		va_list args;
		va_start(args, fmt);
    20c2:	8d 45 0c             	lea    eax,[ebp+0xc]
    20c5:	83 c0 04             	add    eax,0x4
    20c8:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		rv = vrprintf(cr, fmt, args);
    20cb:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    20ce:	83 ec 04             	sub    esp,0x4
    20d1:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    20d4:	50                   	push   eax
    20d5:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    20d8:	e8 fc ff ff ff       	call   20d9 <rprintf+0x1d>
    20dd:	83 c4 10             	add    esp,0x10
    20e0:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		va_end(args);
    20e3:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		return rv;
    20ea:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
}
    20ed:	c9                   	leave
    20ee:	c3                   	ret

000020ef <crprintf>:

int crprintf(char col, struct kio_region* cr, const char* fmt, ...)
{
    20ef:	55                   	push   ebp
    20f0:	89 e5                	mov    ebp,esp
    20f2:	83 ec 28             	sub    esp,0x28
    20f5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    20f8:	88 45 e4             	mov    BYTE PTR [ebp-0x1c],al
		int rv; char cf = cr->fmt;
    20fb:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    20fe:	0f b6 40 0c          	movzx  eax,BYTE PTR [eax+0xc]
    2102:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
		va_list args;
		va_start(args, fmt);
    2105:	8d 45 10             	lea    eax,[ebp+0x10]
    2108:	83 c0 04             	add    eax,0x4
    210b:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		cr->fmt = col;
    210e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2111:	0f b6 55 e4          	movzx  edx,BYTE PTR [ebp-0x1c]
    2115:	88 50 0c             	mov    BYTE PTR [eax+0xc],dl
		rv = vrprintf(cr, fmt, args);
    2118:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    211b:	83 ec 04             	sub    esp,0x4
    211e:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    2121:	50                   	push   eax
    2122:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    2125:	e8 fc ff ff ff       	call   2126 <crprintf+0x37>
    212a:	83 c4 10             	add    esp,0x10
    212d:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		cr->fmt = cf;
    2130:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2133:	0f b6 55 f7          	movzx  edx,BYTE PTR [ebp-0x9]
    2137:	88 50 0c             	mov    BYTE PTR [eax+0xc],dl
		va_end(args);
    213a:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
		return rv;
    2141:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
}
    2144:	c9                   	leave
    2145:	c3                   	ret

00002146 <cprintf>:

int cprintf(char col, const char* fmt, ...)
{
    2146:	55                   	push   ebp
    2147:	89 e5                	mov    ebp,esp
    2149:	83 ec 28             	sub    esp,0x28
    214c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    214f:	88 45 e4             	mov    BYTE PTR [ebp-0x1c],al
		int rv; char cf = reg_def.fmt;
    2152:	0f b6 05 0c 00 00 00 	movzx  eax,BYTE PTR ds:0xc
    2159:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
		va_list args;
		va_start(args, fmt);
    215c:	8d 45 0c             	lea    eax,[ebp+0xc]
    215f:	83 c0 04             	add    eax,0x4
    2162:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		reg_def.fmt = col;
    2165:	0f b6 45 e4          	movzx  eax,BYTE PTR [ebp-0x1c]
    2169:	a2 0c 00 00 00       	mov    ds:0xc,al
		rv = vprintf(fmt, args);
    216e:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    2171:	83 ec 08             	sub    esp,0x8
    2174:	ff 75 f0             	push   DWORD PTR [ebp-0x10]
    2177:	50                   	push   eax
    2178:	e8 fc ff ff ff       	call   2179 <cprintf+0x33>
    217d:	83 c4 10             	add    esp,0x10
    2180:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
		reg_def.fmt = cf;
    2183:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
    2187:	a2 0c 00 00 00       	mov    ds:0xc,al
		va_end(args);
    218c:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
		return rv;
    2193:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
}
    2196:	c9                   	leave
    2197:	c3                   	ret

00002198 <vsprintf>:

int vsprintf(char* str, const char* fmt, va_list args)
{
    2198:	55                   	push   ebp
    2199:	89 e5                	mov    ebp,esp
    219b:	83 ec 18             	sub    esp,0x18
		struct ivp_ctx ct = {str, 0xffffffff, &ctx_s_putchar};
    219e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    21a1:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    21a4:	c7 45 f0 ff ff ff ff 	mov    DWORD PTR [ebp-0x10],0xffffffff
    21ab:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		return internal_vprintf(&ct, fmt, args);
    21b2:	83 ec 04             	sub    esp,0x4
    21b5:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    21b8:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    21bb:	8d 45 ec             	lea    eax,[ebp-0x14]
    21be:	50                   	push   eax
    21bf:	e8 fc ff ff ff       	call   21c0 <vsprintf+0x28>
    21c4:	83 c4 10             	add    esp,0x10
}
    21c7:	c9                   	leave
    21c8:	c3                   	ret

000021c9 <sprintf>:

int sprintf(char* str, const char* fmt, ...)
{
    21c9:	55                   	push   ebp
    21ca:	89 e5                	mov    ebp,esp
    21cc:	83 ec 18             	sub    esp,0x18
		int rv;
		va_list args;
		va_start(args, fmt);
    21cf:	8d 45 0c             	lea    eax,[ebp+0xc]
    21d2:	83 c0 04             	add    eax,0x4
    21d5:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		rv = vsprintf(str, fmt, args);
    21d8:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    21db:	83 ec 04             	sub    esp,0x4
    21de:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    21e1:	50                   	push   eax
    21e2:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    21e5:	e8 fc ff ff ff       	call   21e6 <sprintf+0x1d>
    21ea:	83 c4 10             	add    esp,0x10
    21ed:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		va_end(args);
    21f0:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		return rv;
    21f7:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
}
    21fa:	c9                   	leave
    21fb:	c3                   	ret

000021fc <vsnprintf>:

int vsnprintf(char* str, size_t n, const char* fmt, va_list args)
{
    21fc:	55                   	push   ebp
    21fd:	89 e5                	mov    ebp,esp
    21ff:	83 ec 18             	sub    esp,0x18
		struct ivp_ctx ct = {str, n, &ctx_s_putchar};
    2202:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    2205:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
    2208:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    220b:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
    220e:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		return internal_vprintf(&ct, fmt, args);
    2215:	83 ec 04             	sub    esp,0x4
    2218:	ff 75 14             	push   DWORD PTR [ebp+0x14]
    221b:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    221e:	8d 45 ec             	lea    eax,[ebp-0x14]
    2221:	50                   	push   eax
    2222:	e8 fc ff ff ff       	call   2223 <vsnprintf+0x27>
    2227:	83 c4 10             	add    esp,0x10
}
    222a:	c9                   	leave
    222b:	c3                   	ret

0000222c <snprintf>:

int snprintf(char* str, size_t n, const char* fmt, ...)
{
    222c:	55                   	push   ebp
    222d:	89 e5                	mov    ebp,esp
    222f:	83 ec 18             	sub    esp,0x18
		int rv;
		va_list args;
		va_start(args, fmt);
    2232:	8d 45 10             	lea    eax,[ebp+0x10]
    2235:	83 c0 04             	add    eax,0x4
    2238:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		rv = vsnprintf(str, n, fmt, args);
    223b:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
    223e:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    2241:	50                   	push   eax
    2242:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    2245:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    2248:	e8 fc ff ff ff       	call   2249 <snprintf+0x1d>
    224d:	83 c4 10             	add    esp,0x10
    2250:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		va_end(args);
    2253:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		return rv;
    225a:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
}
    225d:	c9                   	leave
    225e:	c3                   	ret

0000225f <printf>:

int printf(const char* fmt, ...)
{
    225f:	55                   	push   ebp
    2260:	89 e5                	mov    ebp,esp
    2262:	83 ec 18             	sub    esp,0x18
		int rv;
		va_list args;
		va_start(args, fmt);
    2265:	8d 45 0c             	lea    eax,[ebp+0xc]
    2268:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		rv = vprintf(fmt, args);
    226b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    226e:	83 ec 08             	sub    esp,0x8
    2271:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    2274:	50                   	push   eax
    2275:	e8 fc ff ff ff       	call   2276 <printf+0x17>
    227a:	83 c4 10             	add    esp,0x10
    227d:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		va_end(args);
    2280:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		return rv;
    2287:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
}
    228a:	c9                   	leave
    228b:	c3                   	ret

0000228c <iprintf>:
/* no delay intr version */
int iprintf(const char* fmt, ...)
{
    228c:	55                   	push   ebp
    228d:	89 e5                	mov    ebp,esp
    228f:	83 ec 18             	sub    esp,0x18
		int rv;
		va_list args;
		va_start(args, fmt);
    2292:	8d 45 0c             	lea    eax,[ebp+0xc]
    2295:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
		reg_def.flags |= KIO_REGION_NO_DELAY;
    2298:	0f b6 05 0d 00 00 00 	movzx  eax,BYTE PTR ds:0xd
    229f:	83 c8 01             	or     eax,0x1
    22a2:	a2 0d 00 00 00       	mov    ds:0xd,al
		rv = vprintf(fmt, args);
    22a7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    22aa:	83 ec 08             	sub    esp,0x8
    22ad:	ff 75 f4             	push   DWORD PTR [ebp-0xc]
    22b0:	50                   	push   eax
    22b1:	e8 fc ff ff ff       	call   22b2 <iprintf+0x26>
    22b6:	83 c4 10             	add    esp,0x10
    22b9:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
		reg_def.flags &= ~KIO_REGION_NO_DELAY;
    22bc:	0f b6 05 0d 00 00 00 	movzx  eax,BYTE PTR ds:0xd
    22c3:	83 e0 fe             	and    eax,0xfffffffe
    22c6:	a2 0d 00 00 00       	mov    ds:0xd,al
		va_end(args);
    22cb:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
		return rv;
    22d2:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
}
    22d5:	c9                   	leave
    22d6:	c3                   	ret

000022d7 <noprintf>:
int noprintf(const char* c, ...) { (void)c; return 0; }
    22d7:	55                   	push   ebp
    22d8:	89 e5                	mov    ebp,esp
    22da:	b8 00 00 00 00       	mov    eax,0x0
    22df:	5d                   	pop    ebp
    22e0:	c3                   	ret

000022e1 <memdump>:

void memdump(void* ofs, size_t sz)
{
    22e1:	55                   	push   ebp
    22e2:	89 e5                	mov    ebp,esp
    22e4:	83 ec 28             	sub    esp,0x28
		size_t i, ct;

		printf("dumping memory at %p with size %u:\n", ofs, sz);
    22e7:	83 ec 04             	sub    esp,0x4
    22ea:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    22ed:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    22f0:	68 94 00 00 00       	push   0x94
    22f5:	e8 fc ff ff ff       	call   22f6 <memdump+0x15>
    22fa:	83 c4 10             	add    esp,0x10
		for (i = 0; i < sz; i += 16) {
    22fd:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
    2304:	e9 5a 01 00 00       	jmp    2463 <memdump+0x182>
				uint16_t* mem = (uint16_t*)(ofs + i);
    2309:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
    230c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    230f:	01 d0                	add    eax,edx
    2311:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
				uint8_t nbl = 41; /* 41 blanks until text output */
    2314:	c6 45 ef 29          	mov    BYTE PTR [ebp-0x11],0x29
				/* xxd-style output: 8 words and text */
				for (ct = 0; ct < 8; ct++) {
    2318:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    231f:	e9 99 00 00 00       	jmp    23bd <memdump+0xdc>
						if (i + 2 * ct <= sz - 2) {
    2324:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2327:	8d 14 00             	lea    edx,[eax+eax*1]
    232a:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    232d:	01 d0                	add    eax,edx
    232f:	8b 55 0c             	mov    edx,DWORD PTR [ebp+0xc]
    2332:	83 ea 02             	sub    edx,0x2
    2335:	39 c2                	cmp    edx,eax
    2337:	72 45                	jb     237e <memdump+0x9d>
								printf("%04x ", ((mem[ct] << 8) & 0xff00) | (mem[ct] >> 8));
    2339:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    233c:	8d 14 00             	lea    edx,[eax+eax*1]
    233f:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    2342:	01 d0                	add    eax,edx
    2344:	0f b7 00             	movzx  eax,WORD PTR [eax]
    2347:	0f b7 c0             	movzx  eax,ax
    234a:	c1 e0 08             	shl    eax,0x8
    234d:	0f b7 d0             	movzx  edx,ax
    2350:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2353:	8d 0c 00             	lea    ecx,[eax+eax*1]
    2356:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    2359:	01 c8                	add    eax,ecx
    235b:	0f b7 00             	movzx  eax,WORD PTR [eax]
    235e:	66 c1 e8 08          	shr    ax,0x8
    2362:	0f b7 c0             	movzx  eax,ax
    2365:	09 d0                	or     eax,edx
    2367:	83 ec 08             	sub    esp,0x8
    236a:	50                   	push   eax
    236b:	68 b8 00 00 00       	push   0xb8
    2370:	e8 fc ff ff ff       	call   2371 <memdump+0x90>
    2375:	83 c4 10             	add    esp,0x10
								nbl -= 5;
    2378:	80 6d ef 05          	sub    BYTE PTR [ebp-0x11],0x5
    237c:	eb 3b                	jmp    23b9 <memdump+0xd8>
						} else if (i + 2 * ct == sz - 1) { /* ending on half word */
    237e:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2381:	8d 14 00             	lea    edx,[eax+eax*1]
    2384:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2387:	01 c2                	add    edx,eax
    2389:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
    238c:	83 e8 01             	sub    eax,0x1
    238f:	39 c2                	cmp    edx,eax
    2391:	75 36                	jne    23c9 <memdump+0xe8>
								printf("%02x   ", *(uint8_t*)(mem + ct));
    2393:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2396:	8d 14 00             	lea    edx,[eax+eax*1]
    2399:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
    239c:	01 d0                	add    eax,edx
    239e:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    23a1:	0f b6 c0             	movzx  eax,al
    23a4:	83 ec 08             	sub    esp,0x8
    23a7:	50                   	push   eax
    23a8:	68 be 00 00 00       	push   0xbe
    23ad:	e8 fc ff ff ff       	call   23ae <memdump+0xcd>
    23b2:	83 c4 10             	add    esp,0x10
								nbl -= 5;
    23b5:	80 6d ef 05          	sub    BYTE PTR [ebp-0x11],0x5
				for (ct = 0; ct < 8; ct++) {
    23b9:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
    23bd:	83 7d f0 07          	cmp    DWORD PTR [ebp-0x10],0x7
    23c1:	0f 86 5d ff ff ff    	jbe    2324 <memdump+0x43>
    23c7:	eb 10                	jmp    23d9 <memdump+0xf8>
						} else
								break;
    23c9:	90                   	nop
				}
				/* fill with blanks */
				while (nbl--)
    23ca:	eb 0d                	jmp    23d9 <memdump+0xf8>
						putchar(' ');
    23cc:	83 ec 0c             	sub    esp,0xc
    23cf:	6a 20                	push   0x20
    23d1:	e8 fc ff ff ff       	call   23d2 <memdump+0xf1>
    23d6:	83 c4 10             	add    esp,0x10
				while (nbl--)
    23d9:	0f b6 45 ef          	movzx  eax,BYTE PTR [ebp-0x11]
    23dd:	8d 50 ff             	lea    edx,[eax-0x1]
    23e0:	88 55 ef             	mov    BYTE PTR [ebp-0x11],dl
    23e3:	84 c0                	test   al,al
    23e5:	75 e5                	jne    23cc <memdump+0xeb>
				/* output the text */
				for (ct = 0; ct < 16; ct++) {
    23e7:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
    23ee:	eb 59                	jmp    2449 <memdump+0x168>
						char* c = (char*)mem + ct;
    23f0:	8b 55 e8             	mov    edx,DWORD PTR [ebp-0x18]
    23f3:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    23f6:	01 d0                	add    eax,edx
    23f8:	89 45 e4             	mov    DWORD PTR [ebp-0x1c],eax
						if (i + ct >= sz)
    23fb:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
    23fe:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
    2401:	01 d0                	add    eax,edx
    2403:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
    2406:	73 49                	jae    2451 <memdump+0x170>
								break;
						if (isprint(*c))
    2408:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    240b:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    240e:	0f be c0             	movsx  eax,al
    2411:	83 ec 0c             	sub    esp,0xc
    2414:	50                   	push   eax
    2415:	e8 fc ff ff ff       	call   2416 <memdump+0x135>
    241a:	83 c4 10             	add    esp,0x10
    241d:	85 c0                	test   eax,eax
    241f:	74 17                	je     2438 <memdump+0x157>
								putchar(*c);
    2421:	8b 45 e4             	mov    eax,DWORD PTR [ebp-0x1c]
    2424:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    2427:	0f be c0             	movsx  eax,al
    242a:	83 ec 0c             	sub    esp,0xc
    242d:	50                   	push   eax
    242e:	e8 fc ff ff ff       	call   242f <memdump+0x14e>
    2433:	83 c4 10             	add    esp,0x10
    2436:	eb 0d                	jmp    2445 <memdump+0x164>
						else
								putchar('.');
    2438:	83 ec 0c             	sub    esp,0xc
    243b:	6a 2e                	push   0x2e
    243d:	e8 fc ff ff ff       	call   243e <memdump+0x15d>
    2442:	83 c4 10             	add    esp,0x10
				for (ct = 0; ct < 16; ct++) {
    2445:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
    2449:	83 7d f0 0f          	cmp    DWORD PTR [ebp-0x10],0xf
    244d:	76 a1                	jbe    23f0 <memdump+0x10f>
    244f:	eb 01                	jmp    2452 <memdump+0x171>
								break;
    2451:	90                   	nop
				}
				putchar('\n');
    2452:	83 ec 0c             	sub    esp,0xc
    2455:	6a 0a                	push   0xa
    2457:	e8 fc ff ff ff       	call   2458 <memdump+0x177>
    245c:	83 c4 10             	add    esp,0x10
		for (i = 0; i < sz; i += 16) {
    245f:	83 45 f4 10          	add    DWORD PTR [ebp-0xc],0x10
    2463:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
    2466:	3b 45 0c             	cmp    eax,DWORD PTR [ebp+0xc]
    2469:	0f 82 9a fe ff ff    	jb     2309 <memdump+0x28>
		}
}
    246f:	90                   	nop
    2470:	90                   	nop
    2471:	c9                   	leave
    2472:	c3                   	ret
