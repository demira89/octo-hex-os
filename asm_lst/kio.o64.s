
kio.o64:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <memcpy>:
				} else if (nonz)
						ctx->putchar(ctx, '0');
				else if ((32 - i) <= prec) /* has precedence over with */
						ctx->putchar(ctx, '0');
				else if ((32 - i) <= width)
						ctx->putchar(ctx, flags & KFL_ZERO_PREFIX ? '0' : ' ');
       0:	55                   	push   rbp
       1:	48 89 e5             	mov    rbp,rsp
       4:	48 83 ec 28          	sub    rsp,0x28
       8:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
       c:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
      10:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
				else if (i == 31 && prec >= 0) /* only print 0 for nonneg prec */
      14:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
      18:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						ctx->putchar(ctx, '0');
      1c:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
      20:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				else
      24:	eb 1d                	jmp    43 <memcpy+0x43>
						rv--;
      26:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
      2a:	48 8d 42 01          	lea    rax,[rdx+0x1]
      2e:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
      32:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      36:	48 8d 48 01          	lea    rcx,[rax+0x1]
      3a:	48 89 4d f8          	mov    QWORD PTR [rbp-0x8],rcx
      3e:	0f b6 12             	movzx  edx,BYTE PTR [rdx]
      41:	88 10                	mov    BYTE PTR [rax],dl
				else
      43:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
      47:	48 8d 50 ff          	lea    rdx,[rax-0x1]
      4b:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
      4f:	48 85 c0             	test   rax,rax
      52:	75 d2                	jne    26 <memcpy+0x26>
				arg <<= 1;
      54:	90                   	nop
      55:	90                   	nop
      56:	c9                   	leave
      57:	c3                   	ret

0000000000000058 <kio_fb_resize>:
{
      58:	55                   	push   rbp
      59:	48 89 e5             	mov    rbp,rsp
		reg_def.lx = fb_initial.width - 20;
      5c:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 62 <kio_fb_resize+0xa>
      62:	83 e8 14             	sub    eax,0x14
      65:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 6c <kio_fb_resize+0x14>
		reg_def.ly = fb_initial.height;
      6c:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 72 <kio_fb_resize+0x1a>
      72:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 79 <kio_fb_resize+0x21>
		kernel_fb_resize();
      79:	b8 00 00 00 00       	mov    eax,0x0
      7e:	e8 00 00 00 00       	call   83 <kio_fb_resize+0x2b>
		kbd_fb_resize(fb_initial.width, fb_initial.height);
      83:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 89 <kio_fb_resize+0x31>
      89:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 8f <kio_fb_resize+0x37>
      8f:	89 d6                	mov    esi,edx
      91:	89 c7                	mov    edi,eax
      93:	e8 00 00 00 00       	call   98 <kio_fb_resize+0x40>
}
      98:	90                   	nop
      99:	5d                   	pop    rbp
      9a:	c3                   	ret

000000000000009b <getc_pr>:
{
      9b:	55                   	push   rbp
      9c:	48 89 e5             	mov    rbp,rsp
      9f:	48 83 ec 10          	sub    rsp,0x10
      a3:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
      a7:	89 f1                	mov    ecx,esi
      a9:	89 d0                	mov    eax,edx
      ab:	89 ca                	mov    edx,ecx
      ad:	66 89 55 f4          	mov    WORD PTR [rbp-0xc],dx
      b1:	66 89 45 f0          	mov    WORD PTR [rbp-0x10],ax
		if (x < cr->lx && y < cr->ly) {
      b5:	0f b7 55 f4          	movzx  edx,WORD PTR [rbp-0xc]
      b9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      bd:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
      c1:	98                   	cwde
      c2:	39 c2                	cmp    edx,eax
      c4:	7d 4e                	jge    114 <getc_pr+0x79>
      c6:	0f b7 55 f0          	movzx  edx,WORD PTR [rbp-0x10]
      ca:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      ce:	0f b7 40 06          	movzx  eax,WORD PTR [rax+0x6]
      d2:	98                   	cwde
      d3:	39 c2                	cmp    edx,eax
      d5:	7d 3d                	jge    114 <getc_pr+0x79>
				x += cr->x;
      d7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      db:	0f b7 00             	movzx  eax,WORD PTR [rax]
      de:	66 01 45 f4          	add    WORD PTR [rbp-0xc],ax
				y += cr->y;
      e2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      e6:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
      ea:	66 01 45 f0          	add    WORD PTR [rbp-0x10],ax
				return ((char*)fb_initial.text_mem)[2 * (y * fb_initial.width + x)];
      ee:	48 8b 0d 00 00 00 00 	mov    rcx,QWORD PTR [rip+0x0]        # f5 <getc_pr+0x5a>
      f5:	0f b7 55 f0          	movzx  edx,WORD PTR [rbp-0x10]
      f9:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # ff <getc_pr+0x64>
      ff:	0f af d0             	imul   edx,eax
     102:	0f b7 45 f4          	movzx  eax,WORD PTR [rbp-0xc]
     106:	01 d0                	add    eax,edx
     108:	01 c0                	add    eax,eax
     10a:	48 98                	cdqe
     10c:	48 01 c8             	add    rax,rcx
     10f:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     112:	eb 05                	jmp    119 <getc_pr+0x7e>
				return 0;
     114:	b8 00 00 00 00       	mov    eax,0x0
}
     119:	c9                   	leave
     11a:	c3                   	ret

000000000000011b <putc_pr>:
{
     11b:	55                   	push   rbp
     11c:	48 89 e5             	mov    rbp,rsp
     11f:	48 83 ec 50          	sub    rsp,0x50
     123:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
     127:	89 c8                	mov    eax,ecx
     129:	89 f1                	mov    ecx,esi
     12b:	88 4d c4             	mov    BYTE PTR [rbp-0x3c],cl
     12e:	66 89 55 c0          	mov    WORD PTR [rbp-0x40],dx
     132:	66 89 45 bc          	mov    WORD PTR [rbp-0x44],ax
		if (x < cr->lx && y < cr->ly) { /* don't corrupt memory */
     136:	0f b7 55 c0          	movzx  edx,WORD PTR [rbp-0x40]
     13a:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     13e:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
     142:	98                   	cwde
     143:	39 c2                	cmp    edx,eax
     145:	0f 8d 12 01 00 00    	jge    25d <putc_pr+0x142>
     14b:	0f b7 55 bc          	movzx  edx,WORD PTR [rbp-0x44]
     14f:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     153:	0f b7 40 06          	movzx  eax,WORD PTR [rax+0x6]
     157:	98                   	cwde
     158:	39 c2                	cmp    edx,eax
     15a:	0f 8d fd 00 00 00    	jge    25d <putc_pr+0x142>
				x += cr->x;
     160:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     164:	0f b7 00             	movzx  eax,WORD PTR [rax]
     167:	66 01 45 c0          	add    WORD PTR [rbp-0x40],ax
				y += cr->y;
     16b:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     16f:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
     173:	66 01 45 bc          	add    WORD PTR [rbp-0x44],ax
				if (x >= fb_initial.width || y >= fb_initial.height)
     177:	0f b7 55 c0          	movzx  edx,WORD PTR [rbp-0x40]
     17b:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 181 <putc_pr+0x66>
     181:	39 c2                	cmp    edx,eax
     183:	0f 8d d3 00 00 00    	jge    25c <putc_pr+0x141>
     189:	0f b7 55 bc          	movzx  edx,WORD PTR [rbp-0x44]
     18d:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 193 <putc_pr+0x78>
     193:	39 c2                	cmp    edx,eax
     195:	0f 8d c1 00 00 00    	jge    25c <putc_pr+0x141>
				p1 = &((char*)fb_initial.text_mem)[2 * (y * fb_initial.width + x)];
     19b:	48 8b 0d 00 00 00 00 	mov    rcx,QWORD PTR [rip+0x0]        # 1a2 <putc_pr+0x87>
     1a2:	0f b7 55 bc          	movzx  edx,WORD PTR [rbp-0x44]
     1a6:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 1ac <putc_pr+0x91>
     1ac:	0f af d0             	imul   edx,eax
     1af:	0f b7 45 c0          	movzx  eax,WORD PTR [rbp-0x40]
     1b3:	01 d0                	add    eax,edx
     1b5:	01 c0                	add    eax,eax
     1b7:	48 98                	cdqe
     1b9:	48 01 c8             	add    rax,rcx
     1bc:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				p2 = &((char*)fb_initial.text_mem)[2 * (y * fb_initial.width + x) + 1];
     1c0:	48 8b 0d 00 00 00 00 	mov    rcx,QWORD PTR [rip+0x0]        # 1c7 <putc_pr+0xac>
     1c7:	0f b7 55 bc          	movzx  edx,WORD PTR [rbp-0x44]
     1cb:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 1d1 <putc_pr+0xb6>
     1d1:	0f af d0             	imul   edx,eax
     1d4:	0f b7 45 c0          	movzx  eax,WORD PTR [rbp-0x40]
     1d8:	01 d0                	add    eax,edx
     1da:	01 c0                	add    eax,eax
     1dc:	48 98                	cdqe
     1de:	48 83 c0 01          	add    rax,0x1
     1e2:	48 01 c8             	add    rax,rcx
     1e5:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
				if (*p1 != c || *p2 != cr->fmt) {
     1e9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     1ed:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     1f0:	38 45 c4             	cmp    BYTE PTR [rbp-0x3c],al
     1f3:	75 13                	jne    208 <putc_pr+0xed>
     1f5:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     1f9:	0f b6 10             	movzx  edx,BYTE PTR [rax]
     1fc:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     200:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
     204:	38 c2                	cmp    dl,al
     206:	74 55                	je     25d <putc_pr+0x142>
						*p1 = c;
     208:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     20c:	0f b6 55 c4          	movzx  edx,BYTE PTR [rbp-0x3c]
     210:	88 10                	mov    BYTE PTR [rax],dl
						*p2 = cr->fmt;
     212:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     216:	0f b6 50 0c          	movzx  edx,BYTE PTR [rax+0xc]
     21a:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     21e:	88 10                	mov    BYTE PTR [rax],dl
						r.x = x;
     220:	0f b7 45 c0          	movzx  eax,WORD PTR [rbp-0x40]
     224:	66 89 45 dc          	mov    WORD PTR [rbp-0x24],ax
						r.y = y;
     228:	0f b7 45 bc          	movzx  eax,WORD PTR [rbp-0x44]
     22c:	66 89 45 de          	mov    WORD PTR [rbp-0x22],ax
						r.lx = 1;
     230:	66 c7 45 e0 01 00    	mov    WORD PTR [rbp-0x20],0x1
						r.ly = 1;
     236:	66 c7 45 e2 01 00    	mov    WORD PTR [rbp-0x1e],0x1
						r.fmt = cr->fmt;
     23c:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     240:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
     244:	88 45 e8             	mov    BYTE PTR [rbp-0x18],al
						framebuffer_update_region(&fb_initial, &r);
     247:	48 8d 45 dc          	lea    rax,[rbp-0x24]
     24b:	48 89 c6             	mov    rsi,rax
     24e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     255:	e8 00 00 00 00       	call   25a <putc_pr+0x13f>
     25a:	eb 01                	jmp    25d <putc_pr+0x142>
						return;
     25c:	90                   	nop
}
     25d:	c9                   	leave
     25e:	c3                   	ret

000000000000025f <putc_prc>:
{
     25f:	55                   	push   rbp
     260:	48 89 e5             	mov    rbp,rsp
     263:	48 83 ec 30          	sub    rsp,0x30
     267:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
     26b:	89 c8                	mov    eax,ecx
     26d:	44 89 c7             	mov    edi,r8d
     270:	89 f1                	mov    ecx,esi
     272:	88 4d e4             	mov    BYTE PTR [rbp-0x1c],cl
     275:	88 55 e0             	mov    BYTE PTR [rbp-0x20],dl
     278:	66 89 45 dc          	mov    WORD PTR [rbp-0x24],ax
     27c:	89 f8                	mov    eax,edi
     27e:	66 89 45 d8          	mov    WORD PTR [rbp-0x28],ax
		char f = cr->fmt;
     282:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     286:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
     28a:	88 45 ff             	mov    BYTE PTR [rbp-0x1],al
		cr->fmt = fmt;
     28d:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     291:	0f b6 55 e4          	movzx  edx,BYTE PTR [rbp-0x1c]
     295:	88 50 0c             	mov    BYTE PTR [rax+0xc],dl
		putc_pr(cr, c, x, y);
     298:	0f b7 4d d8          	movzx  ecx,WORD PTR [rbp-0x28]
     29c:	0f b7 55 dc          	movzx  edx,WORD PTR [rbp-0x24]
     2a0:	0f be 75 e0          	movsx  esi,BYTE PTR [rbp-0x20]
     2a4:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     2a8:	48 89 c7             	mov    rdi,rax
     2ab:	e8 00 00 00 00       	call   2b0 <putc_prc+0x51>
		cr->fmt = f;
     2b0:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     2b4:	0f b6 55 ff          	movzx  edx,BYTE PTR [rbp-0x1]
     2b8:	88 50 0c             	mov    BYTE PTR [rax+0xc],dl
}
     2bb:	90                   	nop
     2bc:	c9                   	leave
     2bd:	c3                   	ret

00000000000002be <region_clear>:
{
     2be:	55                   	push   rbp
     2bf:	48 89 e5             	mov    rbp,rsp
     2c2:	48 83 ec 10          	sub    rsp,0x10
     2c6:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		framebuffer_clear_region(&fb_initial, cr);
     2ca:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     2ce:	48 89 c6             	mov    rsi,rax
     2d1:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     2d8:	e8 00 00 00 00       	call   2dd <region_clear+0x1f>
}
     2dd:	90                   	nop
     2de:	c9                   	leave
     2df:	c3                   	ret

00000000000002e0 <scroll_buffer>:
{
     2e0:	55                   	push   rbp
     2e1:	48 89 e5             	mov    rbp,rsp
     2e4:	48 83 ec 10          	sub    rsp,0x10
     2e8:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		framebuffer_scroll_region(&fb_initial, cr, 0, 1);
     2ec:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     2f0:	b9 01 00 00 00       	mov    ecx,0x1
     2f5:	ba 00 00 00 00       	mov    edx,0x0
     2fa:	48 89 c6             	mov    rsi,rax
     2fd:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     304:	e8 00 00 00 00       	call   309 <scroll_buffer+0x29>
		if (!(cr->flags & KIO_REGION_NO_DELAY)) {
     309:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     30d:	0f b6 40 0d          	movzx  eax,BYTE PTR [rax+0xd]
     311:	0f be c0             	movsx  eax,al
     314:	83 e0 01             	and    eax,0x1
     317:	85 c0                	test   eax,eax
     319:	75 18                	jne    333 <scroll_buffer+0x53>
			mdelay(50);
     31b:	bf 32 00 00 00       	mov    edi,0x32
     320:	e8 00 00 00 00       	call   325 <scroll_buffer+0x45>
			while (cur_brk)
     325:	eb 01                	jmp    328 <scroll_buffer+0x48>
					__asm__("hlt");
     327:	f4                   	hlt
			while (cur_brk)
     328:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 32f <scroll_buffer+0x4f>
     32f:	84 c0                	test   al,al
     331:	75 f4                	jne    327 <scroll_buffer+0x47>
}
     333:	90                   	nop
     334:	c9                   	leave
     335:	c3                   	ret

0000000000000336 <scroll_left>:
{
     336:	55                   	push   rbp
     337:	48 89 e5             	mov    rbp,rsp
     33a:	48 83 ec 30          	sub    rsp,0x30
     33e:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
		r.y = cr->y + cr->cur_y;
     342:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     346:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
     34a:	89 c2                	mov    edx,eax
     34c:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     350:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
     354:	01 d0                	add    eax,edx
     356:	66 89 45 ee          	mov    WORD PTR [rbp-0x12],ax
		r.x = cr->x;
     35a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     35e:	0f b7 00             	movzx  eax,WORD PTR [rax]
     361:	66 89 45 ec          	mov    WORD PTR [rbp-0x14],ax
		r.ly = 1;
     365:	66 c7 45 f2 01 00    	mov    WORD PTR [rbp-0xe],0x1
		r.lx = cr->lx;
     36b:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     36f:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
     373:	66 89 45 f0          	mov    WORD PTR [rbp-0x10],ax
						(cr->lx - 1) * 2);
     377:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     37b:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
     37f:	98                   	cwde
     380:	83 e8 01             	sub    eax,0x1
     383:	01 c0                	add    eax,eax
		memcpy((char*)fb_initial.text_mem + r.y * fb_initial.width * 2 + r.x * 2,
     385:	48 98                	cdqe
						(char*)fb_initial.text_mem + r.y * fb_initial.width * 2 + r.x * 2 + 2,
     387:	48 8b 35 00 00 00 00 	mov    rsi,QWORD PTR [rip+0x0]        # 38e <scroll_left+0x58>
     38e:	0f b7 55 ee          	movzx  edx,WORD PTR [rbp-0x12]
     392:	0f bf ca             	movsx  ecx,dx
     395:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 39b <scroll_left+0x65>
     39b:	0f af d1             	imul   edx,ecx
     39e:	01 d2                	add    edx,edx
     3a0:	48 63 ca             	movsxd rcx,edx
     3a3:	0f b7 55 ec          	movzx  edx,WORD PTR [rbp-0x14]
     3a7:	0f bf d2             	movsx  edx,dx
     3aa:	01 d2                	add    edx,edx
     3ac:	48 63 d2             	movsxd rdx,edx
     3af:	48 01 ca             	add    rdx,rcx
     3b2:	48 83 c2 02          	add    rdx,0x2
		memcpy((char*)fb_initial.text_mem + r.y * fb_initial.width * 2 + r.x * 2,
     3b6:	48 01 d6             	add    rsi,rdx
     3b9:	48 8b 3d 00 00 00 00 	mov    rdi,QWORD PTR [rip+0x0]        # 3c0 <scroll_left+0x8a>
     3c0:	0f b7 55 ee          	movzx  edx,WORD PTR [rbp-0x12]
     3c4:	0f bf ca             	movsx  ecx,dx
     3c7:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 3cd <scroll_left+0x97>
     3cd:	0f af d1             	imul   edx,ecx
     3d0:	01 d2                	add    edx,edx
     3d2:	48 63 ca             	movsxd rcx,edx
     3d5:	0f b7 55 ec          	movzx  edx,WORD PTR [rbp-0x14]
     3d9:	0f bf d2             	movsx  edx,dx
     3dc:	01 d2                	add    edx,edx
     3de:	48 63 d2             	movsxd rdx,edx
     3e1:	48 01 ca             	add    rdx,rcx
     3e4:	48 8d 0c 17          	lea    rcx,[rdi+rdx*1]
     3e8:	48 89 c2             	mov    rdx,rax
     3eb:	48 89 cf             	mov    rdi,rcx
     3ee:	e8 0d fc ff ff       	call   0 <memcpy>
		framebuffer_update_region(&fb_initial, &r);
     3f3:	48 8d 45 ec          	lea    rax,[rbp-0x14]
     3f7:	48 89 c6             	mov    rsi,rax
     3fa:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     401:	e8 00 00 00 00       	call   406 <scroll_left+0xd0>
		cr->cur_x--;
     406:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     40a:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     40e:	83 e8 01             	sub    eax,0x1
     411:	89 c2                	mov    edx,eax
     413:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     417:	66 89 50 0e          	mov    WORD PTR [rax+0xe],dx
		putc_pr(cr, '\0', cr->cur_x, cr->cur_y);
     41b:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     41f:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
     423:	0f b7 c8             	movzx  ecx,ax
     426:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     42a:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     42e:	0f b7 d0             	movzx  edx,ax
     431:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     435:	be 00 00 00 00       	mov    esi,0x0
     43a:	48 89 c7             	mov    rdi,rax
     43d:	e8 00 00 00 00       	call   442 <scroll_left+0x10c>
}
     442:	90                   	nop
     443:	c9                   	leave
     444:	c3                   	ret

0000000000000445 <region_unputchar>:
{
     445:	55                   	push   rbp
     446:	48 89 e5             	mov    rbp,rsp
     449:	48 83 ec 10          	sub    rsp,0x10
     44d:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		if (cr->cur_x) {
     451:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     455:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     459:	66 85 c0             	test   ax,ax
     45c:	74 41                	je     49f <region_unputchar+0x5a>
				cr->cur_x--;
     45e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     462:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     466:	83 e8 01             	sub    eax,0x1
     469:	89 c2                	mov    edx,eax
     46b:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     46f:	66 89 50 0e          	mov    WORD PTR [rax+0xe],dx
				putc_pr(cr, '\0', cr->cur_x, cr->cur_y);
     473:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     477:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
     47b:	0f b7 c8             	movzx  ecx,ax
     47e:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     482:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     486:	0f b7 d0             	movzx  edx,ax
     489:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     48d:	be 00 00 00 00       	mov    esi,0x0
     492:	48 89 c7             	mov    rdi,rax
     495:	e8 00 00 00 00       	call   49a <region_unputchar+0x55>
}
     49a:	e9 ac 00 00 00       	jmp    54b <region_unputchar+0x106>
		} else if (cr->cur_y) {
     49f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     4a3:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
     4a7:	66 85 c0             	test   ax,ax
     4aa:	0f 84 9b 00 00 00    	je     54b <region_unputchar+0x106>
				cr->cur_y--;
     4b0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     4b4:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
     4b8:	83 e8 01             	sub    eax,0x1
     4bb:	89 c2                	mov    edx,eax
     4bd:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     4c1:	66 89 50 10          	mov    WORD PTR [rax+0x10],dx
				cr->cur_x = cr->lx;
     4c5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     4c9:	0f b7 50 04          	movzx  edx,WORD PTR [rax+0x4]
     4cd:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     4d1:	66 89 50 0e          	mov    WORD PTR [rax+0xe],dx
				while (--cr->cur_x)
     4d5:	eb 28                	jmp    4ff <region_unputchar+0xba>
						if (getc_pr(cr, cr->cur_x, cr->cur_y) != '\0')
     4d7:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     4db:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
     4df:	0f b7 d0             	movzx  edx,ax
     4e2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     4e6:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     4ea:	0f b7 c8             	movzx  ecx,ax
     4ed:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     4f1:	89 ce                	mov    esi,ecx
     4f3:	48 89 c7             	mov    rdi,rax
     4f6:	e8 00 00 00 00       	call   4fb <region_unputchar+0xb6>
     4fb:	84 c0                	test   al,al
     4fd:	75 24                	jne    523 <region_unputchar+0xde>
				while (--cr->cur_x)
     4ff:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     503:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     507:	83 e8 01             	sub    eax,0x1
     50a:	89 c2                	mov    edx,eax
     50c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     510:	66 89 50 0e          	mov    WORD PTR [rax+0xe],dx
     514:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     518:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     51c:	66 85 c0             	test   ax,ax
     51f:	75 b6                	jne    4d7 <region_unputchar+0x92>
     521:	eb 01                	jmp    524 <region_unputchar+0xdf>
								break;
     523:	90                   	nop
				putc_pr(cr, '\0', cr->cur_x, cr->cur_y);
     524:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     528:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
     52c:	0f b7 c8             	movzx  ecx,ax
     52f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     533:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     537:	0f b7 d0             	movzx  edx,ax
     53a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     53e:	be 00 00 00 00       	mov    esi,0x0
     543:	48 89 c7             	mov    rdi,rax
     546:	e8 00 00 00 00       	call   54b <region_unputchar+0x106>
}
     54b:	90                   	nop
     54c:	c9                   	leave
     54d:	c3                   	ret

000000000000054e <region_getline>:
{
     54e:	55                   	push   rbp
     54f:	48 89 e5             	mov    rbp,rsp
     552:	48 83 ec 50          	sub    rsp,0x50
     556:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
     55a:	48 89 75 c0          	mov    QWORD PTR [rbp-0x40],rsi
     55e:	48 89 55 b8          	mov    QWORD PTR [rbp-0x48],rdx
		char* str; size_t rem, ct = 0;
     562:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
		if (!lineptr || !n || (cr->flags & KIO_REGION_INPUT_DISABLED)) {
     56a:	48 83 7d c0 00       	cmp    QWORD PTR [rbp-0x40],0x0
     56f:	74 19                	je     58a <region_getline+0x3c>
     571:	48 83 7d b8 00       	cmp    QWORD PTR [rbp-0x48],0x0
     576:	74 12                	je     58a <region_getline+0x3c>
     578:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     57c:	0f b6 40 0d          	movzx  eax,BYTE PTR [rax+0xd]
     580:	0f be c0             	movsx  eax,al
     583:	83 e0 08             	and    eax,0x8
     586:	85 c0                	test   eax,eax
     588:	74 16                	je     5a0 <region_getline+0x52>
				errno = EINVAL;
     58a:	c7 05 00 00 00 00 16 00 00 00 	mov    DWORD PTR [rip+0x0],0x16        # 594 <region_getline+0x46>
				return -1;
     594:	48 c7 c0 ff ff ff ff 	mov    rax,0xffffffffffffffff
     59b:	e9 c1 02 00 00       	jmp    861 <region_getline+0x313>
		str = *lineptr;
     5a0:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     5a4:	48 8b 00             	mov    rax,QWORD PTR [rax]
     5a7:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
		rem = *n;
     5ab:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     5af:	48 8b 00             	mov    rax,QWORD PTR [rax]
     5b2:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
		if (rem == 0) {
     5b6:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
     5bb:	75 2c                	jne    5e9 <region_getline+0x9b>
				str = kmalloc(80);
     5bd:	bf 50 00 00 00       	mov    edi,0x50
     5c2:	e8 00 00 00 00       	call   5c7 <region_getline+0x79>
     5c7:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				rem = 80;
     5cb:	48 c7 45 f0 50 00 00 00 	mov    QWORD PTR [rbp-0x10],0x50
				*n = 80;
     5d3:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     5d7:	48 c7 00 50 00 00 00 	mov    QWORD PTR [rax],0x50
				*lineptr = str;
     5de:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     5e2:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     5e6:	48 89 10             	mov    QWORD PTR [rax],rdx
				if (!(cr->flags & KIO_REGION_INPUT_NOCURSOR)) {
     5e9:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     5ed:	0f b6 40 0d          	movzx  eax,BYTE PTR [rax+0xd]
     5f1:	84 c0                	test   al,al
     5f3:	78 39                	js     62e <region_getline+0xe0>
										cr->y + cr->cur_y);
     5f5:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     5f9:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
     5fd:	0f bf d0             	movsx  edx,ax
     600:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     604:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
     608:	98                   	cwde
						framebuffer_set_cursor(&fb_initial, cr->x + cr->cur_x,
     609:	01 c2                	add    edx,eax
     60b:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     60f:	0f b7 00             	movzx  eax,WORD PTR [rax]
     612:	0f bf c8             	movsx  ecx,ax
     615:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     619:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     61d:	98                   	cwde
     61e:	01 c8                	add    eax,ecx
     620:	89 c6                	mov    esi,eax
     622:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     629:	e8 00 00 00 00       	call   62e <region_getline+0xe0>
				int c = region_getchar(cr);
     62e:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     632:	48 89 c7             	mov    rdi,rax
     635:	e8 00 00 00 00       	call   63a <region_getline+0xec>
     63a:	89 45 e4             	mov    DWORD PTR [rbp-0x1c],eax
				if (c == EOF) {
     63d:	83 7d e4 ff          	cmp    DWORD PTR [rbp-0x1c],0xffffffff
     641:	75 17                	jne    65a <region_getline+0x10c>
						str[ct] = '\0';
     643:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     647:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     64b:	48 01 d0             	add    rax,rdx
     64e:	c6 00 00             	mov    BYTE PTR [rax],0x0
						return ct;
     651:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     655:	e9 07 02 00 00       	jmp    861 <region_getline+0x313>
				} else if (c == '\b') {
     65a:	83 7d e4 08          	cmp    DWORD PTR [rbp-0x1c],0x8
     65e:	0f 85 be 00 00 00    	jne    722 <region_getline+0x1d4>
						if (ct) {
     664:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
     669:	0f 84 ec 01 00 00    	je     85b <region_getline+0x30d>
								str[--ct] = '\0';
     66f:	48 83 6d e8 01       	sub    QWORD PTR [rbp-0x18],0x1
     674:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     678:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     67c:	48 01 d0             	add    rax,rdx
     67f:	c6 00 00             	mov    BYTE PTR [rax],0x0
								if (cr->cur_x || (cr->flags & KIO_REGION_INPUT_MULTILINE))
     682:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     686:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     68a:	66 85 c0             	test   ax,ax
     68d:	75 12                	jne    6a1 <region_getline+0x153>
     68f:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     693:	0f b6 40 0d          	movzx  eax,BYTE PTR [rax+0xd]
     697:	0f be c0             	movsx  eax,al
     69a:	83 e0 10             	and    eax,0x10
     69d:	85 c0                	test   eax,eax
     69f:	74 11                	je     6b2 <region_getline+0x164>
										region_unputchar(cr);
     6a1:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     6a5:	48 89 c7             	mov    rdi,rax
     6a8:	e8 00 00 00 00       	call   6ad <region_getline+0x15f>
						continue;
     6ad:	e9 a9 01 00 00       	jmp    85b <region_getline+0x30d>
								else if (ct && !(cr->flags & KIO_REGION_INPUT_MULTILINE)) {
     6b2:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
     6b7:	0f 84 9e 01 00 00    	je     85b <region_getline+0x30d>
     6bd:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     6c1:	0f b6 40 0d          	movzx  eax,BYTE PTR [rax+0xd]
     6c5:	0f be c0             	movsx  eax,al
     6c8:	83 e0 10             	and    eax,0x10
     6cb:	85 c0                	test   eax,eax
     6cd:	0f 85 88 01 00 00    	jne    85b <region_getline+0x30d>
										size_t nc = min(ct, (size_t)cr->lx);
     6d3:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     6d7:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
     6db:	48 0f bf c0          	movsx  rax,ax
     6df:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
     6e3:	48 39 c2             	cmp    rdx,rax
     6e6:	48 0f 46 c2          	cmovbe rax,rdx
     6ea:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
										region_puts(cr, str + (ct - nc));
     6ee:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     6f2:	48 2b 45 d8          	sub    rax,QWORD PTR [rbp-0x28]
     6f6:	48 89 c2             	mov    rdx,rax
     6f9:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     6fd:	48 01 c2             	add    rdx,rax
     700:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     704:	48 89 d6             	mov    rsi,rdx
     707:	48 89 c7             	mov    rdi,rax
     70a:	e8 00 00 00 00       	call   70f <region_getline+0x1c1>
										cr->cur_x = nc;
     70f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     713:	89 c2                	mov    edx,eax
     715:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     719:	66 89 50 0e          	mov    WORD PTR [rax+0xe],dx
						continue;
     71d:	e9 39 01 00 00       	jmp    85b <region_getline+0x30d>
				str[ct++] = c;
     722:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     726:	48 8d 50 01          	lea    rdx,[rax+0x1]
     72a:	48 89 55 e8          	mov    QWORD PTR [rbp-0x18],rdx
     72e:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     732:	48 01 d0             	add    rax,rdx
     735:	8b 55 e4             	mov    edx,DWORD PTR [rbp-0x1c]
     738:	88 10                	mov    BYTE PTR [rax],dl
				if (ct + 1 == rem) {
     73a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     73e:	48 83 c0 01          	add    rax,0x1
     742:	48 39 45 f0          	cmp    QWORD PTR [rbp-0x10],rax
     746:	75 44                	jne    78c <region_getline+0x23e>
						rem *= 2;
     748:	48 d1 65 f0          	shl    QWORD PTR [rbp-0x10],1
						str = krealloc(str, rem);
     74c:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     750:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     754:	48 89 d6             	mov    rsi,rdx
     757:	48 89 c7             	mov    rdi,rax
     75a:	e8 00 00 00 00       	call   75f <region_getline+0x211>
     75f:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
						if (!str)
     763:	48 83 7d f8 00       	cmp    QWORD PTR [rbp-0x8],0x0
     768:	75 0c                	jne    776 <region_getline+0x228>
								return -1;
     76a:	48 c7 c0 ff ff ff ff 	mov    rax,0xffffffffffffffff
     771:	e9 eb 00 00 00       	jmp    861 <region_getline+0x313>
						*n = rem;
     776:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
     77a:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     77e:	48 89 10             	mov    QWORD PTR [rax],rdx
						*lineptr = str;
     781:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     785:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     789:	48 89 10             	mov    QWORD PTR [rax],rdx
				if ((c == 10 || c == 13) && !(cr->flags & KIO_REGION_INPUT_MULTILINE)) {
     78c:	83 7d e4 0a          	cmp    DWORD PTR [rbp-0x1c],0xa
     790:	74 06                	je     798 <region_getline+0x24a>
     792:	83 7d e4 0d          	cmp    DWORD PTR [rbp-0x1c],0xd
     796:	75 3a                	jne    7d2 <region_getline+0x284>
     798:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     79c:	0f b6 40 0d          	movzx  eax,BYTE PTR [rax+0xd]
     7a0:	0f be c0             	movsx  eax,al
     7a3:	83 e0 10             	and    eax,0x10
     7a6:	85 c0                	test   eax,eax
     7a8:	75 28                	jne    7d2 <region_getline+0x284>
						region_putchar(cr, '\n');
     7aa:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     7ae:	be 0a 00 00 00       	mov    esi,0xa
     7b3:	48 89 c7             	mov    rdi,rax
     7b6:	e8 00 00 00 00       	call   7bb <region_getline+0x26d>
						str[ct] = '\0';
     7bb:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     7bf:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     7c3:	48 01 d0             	add    rax,rdx
     7c6:	c6 00 00             	mov    BYTE PTR [rax],0x0
						return ct;
     7c9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     7cd:	e9 8f 00 00 00       	jmp    861 <region_getline+0x313>
				if (!(cr->flags & KIO_REGION_INPUT_MULTILINE) && cr->cur_x == cr->lx) {
     7d2:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     7d6:	0f b6 40 0d          	movzx  eax,BYTE PTR [rax+0xd]
     7da:	0f be c0             	movsx  eax,al
     7dd:	83 e0 10             	and    eax,0x10
     7e0:	85 c0                	test   eax,eax
     7e2:	75 5e                	jne    842 <region_getline+0x2f4>
     7e4:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     7e8:	0f b7 50 0e          	movzx  edx,WORD PTR [rax+0xe]
     7ec:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     7f0:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
     7f4:	66 39 c2             	cmp    dx,ax
     7f7:	75 49                	jne    842 <region_getline+0x2f4>
						if (cr->flags & KIO_REGION_INPUT_WRAP) {
     7f9:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     7fd:	0f b6 40 0d          	movzx  eax,BYTE PTR [rax+0xd]
     801:	0f be c0             	movsx  eax,al
     804:	83 e0 40             	and    eax,0x40
     807:	85 c0                	test   eax,eax
     809:	74 22                	je     82d <region_getline+0x2df>
								scroll_left(cr);
     80b:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     80f:	48 89 c7             	mov    rdi,rax
     812:	e8 00 00 00 00       	call   817 <region_getline+0x2c9>
								region_putchar(cr, c);
     817:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     81a:	0f be d0             	movsx  edx,al
     81d:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     821:	89 d6                	mov    esi,edx
     823:	48 89 c7             	mov    rdi,rax
     826:	e8 00 00 00 00       	call   82b <region_getline+0x2dd>
						if (cr->flags & KIO_REGION_INPUT_WRAP) {
     82b:	eb 2f                	jmp    85c <region_getline+0x30e>
								str[--ct] = '\0';
     82d:	48 83 6d e8 01       	sub    QWORD PTR [rbp-0x18],0x1
     832:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
     836:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     83a:	48 01 d0             	add    rax,rdx
     83d:	c6 00 00             	mov    BYTE PTR [rax],0x0
						if (cr->flags & KIO_REGION_INPUT_WRAP) {
     840:	eb 1a                	jmp    85c <region_getline+0x30e>
						region_putchar(cr, c);
     842:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     845:	0f be d0             	movsx  edx,al
     848:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     84c:	89 d6                	mov    esi,edx
     84e:	48 89 c7             	mov    rdi,rax
     851:	e8 00 00 00 00       	call   856 <region_getline+0x308>
     856:	e9 8e fd ff ff       	jmp    5e9 <region_getline+0x9b>
						continue;
     85b:	90                   	nop
		do {
     85c:	e9 88 fd ff ff       	jmp    5e9 <region_getline+0x9b>
}
     861:	c9                   	leave
     862:	c3                   	ret

0000000000000863 <getline>:
{
     863:	55                   	push   rbp
     864:	48 89 e5             	mov    rbp,rsp
     867:	48 83 ec 10          	sub    rsp,0x10
     86b:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
     86f:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
		kbd_handler(); // poke the buffer
     873:	b8 00 00 00 00       	mov    eax,0x0
     878:	e8 00 00 00 00       	call   87d <getline+0x1a>
		return region_getline(&reg_def, lineptr, n);
     87d:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
     881:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     885:	48 89 c6             	mov    rsi,rax
     888:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     88f:	e8 00 00 00 00       	call   894 <getline+0x31>
}
     894:	c9                   	leave
     895:	c3                   	ret

0000000000000896 <region_getchar>:
{
     896:	55                   	push   rbp
     897:	48 89 e5             	mov    rbp,rsp
     89a:	48 83 ec 20          	sub    rsp,0x20
     89e:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		if (cr->flags & KIO_REGION_INPUT_DISABLED)
     8a2:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     8a6:	0f b6 40 0d          	movzx  eax,BYTE PTR [rax+0xd]
     8aa:	0f be c0             	movsx  eax,al
     8ad:	83 e0 08             	and    eax,0x8
     8b0:	85 c0                	test   eax,eax
     8b2:	75 03                	jne    8b7 <region_getchar+0x21>
Pos1:
     8b4:	90                   	nop
     8b5:	eb 07                	jmp    8be <region_getchar+0x28>
				return EOF;
     8b7:	b8 ff ff ff ff       	mov    eax,0xffffffff
     8bc:	eb 5c                	jmp    91a <region_getchar+0x84>
		if (kbd_event_present()) {
     8be:	b8 00 00 00 00       	mov    eax,0x0
     8c3:	e8 00 00 00 00       	call   8c8 <region_getchar+0x32>
     8c8:	85 c0                	test   eax,eax
     8ca:	74 27                	je     8f3 <region_getchar+0x5d>
				struct key_event ke = kbd_get_event();
     8cc:	b8 00 00 00 00       	mov    eax,0x0
     8d1:	e8 00 00 00 00       	call   8d6 <region_getchar+0x40>
     8d6:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
				int rv = kbd_event_translate(&ke);
     8d9:	48 8d 45 f8          	lea    rax,[rbp-0x8]
     8dd:	48 89 c7             	mov    rdi,rax
     8e0:	e8 00 00 00 00       	call   8e5 <region_getchar+0x4f>
     8e5:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
				if (rv != 0)
     8e8:	83 7d fc 00          	cmp    DWORD PTR [rbp-0x4],0x0
     8ec:	74 d0                	je     8be <region_getchar+0x28>
						return rv;
     8ee:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
     8f1:	eb 27                	jmp    91a <region_getchar+0x84>
		} else if (cr->flags & KIO_REGION_INPUT_NONBLOCKING)
     8f3:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     8f7:	0f b6 40 0d          	movzx  eax,BYTE PTR [rax+0xd]
     8fb:	0f be c0             	movsx  eax,al
     8fe:	83 e0 20             	and    eax,0x20
     901:	85 c0                	test   eax,eax
     903:	74 07                	je     90c <region_getchar+0x76>
				return EOF;
     905:	b8 ff ff ff ff       	mov    eax,0xffffffff
     90a:	eb 0e                	jmp    91a <region_getchar+0x84>
				wait_on_event(&wq_kbd);
     90c:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     913:	e8 00 00 00 00       	call   918 <region_getchar+0x82>
		goto Pos1;
     918:	eb a4                	jmp    8be <region_getchar+0x28>
}
     91a:	c9                   	leave
     91b:	c3                   	ret

000000000000091c <region_putchar>:
{
     91c:	55                   	push   rbp
     91d:	48 89 e5             	mov    rbp,rsp
     920:	48 83 ec 30          	sub    rsp,0x30
     924:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
     928:	89 f0                	mov    eax,esi
     92a:	88 45 d4             	mov    BYTE PTR [rbp-0x2c],al
		if (c == 10 || c == 13) {
     92d:	80 7d d4 0a          	cmp    BYTE PTR [rbp-0x2c],0xa
     931:	74 0a                	je     93d <region_putchar+0x21>
     933:	80 7d d4 0d          	cmp    BYTE PTR [rbp-0x2c],0xd
     937:	0f 85 3d 01 00 00    	jne    a7a <region_putchar+0x15e>
				for (i = cr->cur_x; i < cr->lx; i++)
     93d:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     941:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     945:	66 89 45 fe          	mov    WORD PTR [rbp-0x2],ax
     949:	eb 2e                	jmp    979 <region_putchar+0x5d>
						putc_pr(cr, '\0', i, cr->cur_y);
     94b:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     94f:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
     953:	0f b7 c8             	movzx  ecx,ax
     956:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
     95a:	0f b7 d0             	movzx  edx,ax
     95d:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     961:	be 00 00 00 00       	mov    esi,0x0
     966:	48 89 c7             	mov    rdi,rax
     969:	e8 00 00 00 00       	call   96e <region_putchar+0x52>
				for (i = cr->cur_x; i < cr->lx; i++)
     96e:	0f b7 45 fe          	movzx  eax,WORD PTR [rbp-0x2]
     972:	83 c0 01             	add    eax,0x1
     975:	66 89 45 fe          	mov    WORD PTR [rbp-0x2],ax
     979:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     97d:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
     981:	66 39 45 fe          	cmp    WORD PTR [rbp-0x2],ax
     985:	7c c4                	jl     94b <region_putchar+0x2f>
				r.x = cr->x + cr->cur_x;
     987:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     98b:	0f b7 00             	movzx  eax,WORD PTR [rax]
     98e:	89 c2                	mov    edx,eax
     990:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     994:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     998:	01 d0                	add    eax,edx
     99a:	66 89 45 ea          	mov    WORD PTR [rbp-0x16],ax
				r.y = cr->y + cr->cur_y;
     99e:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     9a2:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
     9a6:	89 c2                	mov    edx,eax
     9a8:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     9ac:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
     9b0:	01 d0                	add    eax,edx
     9b2:	66 89 45 ec          	mov    WORD PTR [rbp-0x14],ax
				r.ly = 1;
     9b6:	66 c7 45 f0 01 00    	mov    WORD PTR [rbp-0x10],0x1
				r.lx = cr->lx - cr->cur_x;
     9bc:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     9c0:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
     9c4:	89 c2                	mov    edx,eax
     9c6:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     9ca:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     9ce:	89 c1                	mov    ecx,eax
     9d0:	89 d0                	mov    eax,edx
     9d2:	29 c8                	sub    eax,ecx
     9d4:	66 89 45 ee          	mov    WORD PTR [rbp-0x12],ax
				cr->cur_x = 0;
     9d8:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     9dc:	66 c7 40 0e 00 00    	mov    WORD PTR [rax+0xe],0x0
				if (++cr->cur_y == cr->ly) {
     9e2:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     9e6:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
     9ea:	83 c0 01             	add    eax,0x1
     9ed:	89 c2                	mov    edx,eax
     9ef:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     9f3:	66 89 50 10          	mov    WORD PTR [rax+0x10],dx
     9f7:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     9fb:	0f b7 50 10          	movzx  edx,WORD PTR [rax+0x10]
     9ff:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     a03:	0f b7 40 06          	movzx  eax,WORD PTR [rax+0x6]
     a07:	66 39 c2             	cmp    dx,ax
     a0a:	75 4b                	jne    a57 <region_putchar+0x13b>
						if (!(cr->flags & KIO_REGION_DEFERED_SCROLL)) {
     a0c:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     a10:	0f b6 40 0d          	movzx  eax,BYTE PTR [rax+0xd]
     a14:	0f be c0             	movsx  eax,al
     a17:	83 e0 04             	and    eax,0x4
     a1a:	85 c0                	test   eax,eax
     a1c:	75 39                	jne    a57 <region_putchar+0x13b>
								cr->cur_y--;
     a1e:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     a22:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
     a26:	83 e8 01             	sub    eax,0x1
     a29:	89 c2                	mov    edx,eax
     a2b:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     a2f:	66 89 50 10          	mov    WORD PTR [rax+0x10],dx
								if (!(cr->flags & KIO_REGION_NO_SCROLL)) {
     a33:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     a37:	0f b6 40 0d          	movzx  eax,BYTE PTR [rax+0xd]
     a3b:	0f be c0             	movsx  eax,al
     a3e:	83 e0 02             	and    eax,0x2
     a41:	85 c0                	test   eax,eax
     a43:	75 12                	jne    a57 <region_putchar+0x13b>
										scroll_buffer(cr);
     a45:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     a49:	48 89 c7             	mov    rdi,rax
     a4c:	e8 00 00 00 00       	call   a51 <region_putchar+0x135>
										i = -1;
     a51:	66 c7 45 fe ff ff    	mov    WORD PTR [rbp-0x2],0xffff
				if (i != -1)
     a57:	66 83 7d fe ff       	cmp    WORD PTR [rbp-0x2],0xffff
     a5c:	0f 84 90 01 00 00    	je     bf2 <region_putchar+0x2d6>
						framebuffer_update_region(&fb_initial, &r);
     a62:	48 8d 45 ea          	lea    rax,[rbp-0x16]
     a66:	48 89 c6             	mov    rsi,rax
     a69:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     a70:	e8 00 00 00 00       	call   a75 <region_putchar+0x159>
		if (c == 10 || c == 13) {
     a75:	e9 78 01 00 00       	jmp    bf2 <region_putchar+0x2d6>
		} else if (c == '\t') {
     a7a:	80 7d d4 09          	cmp    BYTE PTR [rbp-0x2c],0x9
     a7e:	0f 85 96 00 00 00    	jne    b1a <region_putchar+0x1fe>
				if (cr->cur_x == cr->lx)
     a84:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     a88:	0f b7 50 0e          	movzx  edx,WORD PTR [rax+0xe]
     a8c:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     a90:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
     a94:	66 39 c2             	cmp    dx,ax
     a97:	75 11                	jne    aaa <region_putchar+0x18e>
						region_putchar(cr, '\n');
     a99:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     a9d:	be 0a 00 00 00       	mov    esi,0xa
     aa2:	48 89 c7             	mov    rdi,rax
     aa5:	e8 00 00 00 00       	call   aaa <region_putchar+0x18e>
				for (c = 0; cr->cur_x < cr->lx && c < 4; cr->cur_x++, c++)
     aaa:	c6 45 d4 00          	mov    BYTE PTR [rbp-0x2c],0x0
     aae:	eb 46                	jmp    af6 <region_putchar+0x1da>
						putc_pr(cr, ' ', cr->cur_x, cr->cur_y);
     ab0:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     ab4:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
     ab8:	0f b7 c8             	movzx  ecx,ax
     abb:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     abf:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     ac3:	0f b7 d0             	movzx  edx,ax
     ac6:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     aca:	be 20 00 00 00       	mov    esi,0x20
     acf:	48 89 c7             	mov    rdi,rax
     ad2:	e8 00 00 00 00       	call   ad7 <region_putchar+0x1bb>
				for (c = 0; cr->cur_x < cr->lx && c < 4; cr->cur_x++, c++)
     ad7:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     adb:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     adf:	83 c0 01             	add    eax,0x1
     ae2:	89 c2                	mov    edx,eax
     ae4:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     ae8:	66 89 50 0e          	mov    WORD PTR [rax+0xe],dx
     aec:	0f b6 45 d4          	movzx  eax,BYTE PTR [rbp-0x2c]
     af0:	83 c0 01             	add    eax,0x1
     af3:	88 45 d4             	mov    BYTE PTR [rbp-0x2c],al
     af6:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     afa:	0f b7 50 0e          	movzx  edx,WORD PTR [rax+0xe]
     afe:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     b02:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
     b06:	66 39 c2             	cmp    dx,ax
     b09:	0f 8d e4 00 00 00    	jge    bf3 <region_putchar+0x2d7>
     b0f:	80 7d d4 03          	cmp    BYTE PTR [rbp-0x2c],0x3
     b13:	7e 9b                	jle    ab0 <region_putchar+0x194>
     b15:	e9 d9 00 00 00       	jmp    bf3 <region_putchar+0x2d7>
		} else if (cr->cur_x == cr->lx) {
     b1a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     b1e:	0f b7 50 0e          	movzx  edx,WORD PTR [rax+0xe]
     b22:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     b26:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
     b2a:	66 39 c2             	cmp    dx,ax
     b2d:	75 75                	jne    ba4 <region_putchar+0x288>
				region_putchar(cr, '\n');
     b2f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     b33:	be 0a 00 00 00       	mov    esi,0xa
     b38:	48 89 c7             	mov    rdi,rax
     b3b:	e8 00 00 00 00       	call   b40 <region_putchar+0x224>
				cr->cur_x = 0;
     b40:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     b44:	66 c7 40 0e 00 00    	mov    WORD PTR [rax+0xe],0x0
				putc_pr(cr, c, cr->cur_x++, cr->cur_y);
     b4a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     b4e:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
     b52:	0f b7 c8             	movzx  ecx,ax
     b55:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     b59:	0f b7 50 0e          	movzx  edx,WORD PTR [rax+0xe]
     b5d:	89 d0                	mov    eax,edx
     b5f:	83 c0 01             	add    eax,0x1
     b62:	89 c6                	mov    esi,eax
     b64:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     b68:	66 89 70 0e          	mov    WORD PTR [rax+0xe],si
     b6c:	89 d0                	mov    eax,edx
     b6e:	0f b7 d0             	movzx  edx,ax
     b71:	0f be 75 d4          	movsx  esi,BYTE PTR [rbp-0x2c]
     b75:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     b79:	48 89 c7             	mov    rdi,rax
     b7c:	e8 00 00 00 00       	call   b81 <region_putchar+0x265>
     b81:	eb 70                	jmp    bf3 <region_putchar+0x2d7>
						scroll_buffer(cr);
     b83:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     b87:	48 89 c7             	mov    rdi,rax
     b8a:	e8 00 00 00 00       	call   b8f <region_putchar+0x273>
						cr->cur_y--;
     b8f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     b93:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
     b97:	83 e8 01             	sub    eax,0x1
     b9a:	89 c2                	mov    edx,eax
     b9c:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     ba0:	66 89 50 10          	mov    WORD PTR [rax+0x10],dx
				while (cr->cur_y >= cr->ly) {
     ba4:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     ba8:	0f b7 50 10          	movzx  edx,WORD PTR [rax+0x10]
     bac:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     bb0:	0f b7 40 06          	movzx  eax,WORD PTR [rax+0x6]
     bb4:	66 39 c2             	cmp    dx,ax
     bb7:	7d ca                	jge    b83 <region_putchar+0x267>
				putc_pr(cr, c, cr->cur_x++, cr->cur_y);
     bb9:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     bbd:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
     bc1:	0f b7 c8             	movzx  ecx,ax
     bc4:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     bc8:	0f b7 50 0e          	movzx  edx,WORD PTR [rax+0xe]
     bcc:	89 d0                	mov    eax,edx
     bce:	83 c0 01             	add    eax,0x1
     bd1:	89 c6                	mov    esi,eax
     bd3:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     bd7:	66 89 70 0e          	mov    WORD PTR [rax+0xe],si
     bdb:	89 d0                	mov    eax,edx
     bdd:	0f b7 d0             	movzx  edx,ax
     be0:	0f be 75 d4          	movsx  esi,BYTE PTR [rbp-0x2c]
     be4:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     be8:	48 89 c7             	mov    rdi,rax
     beb:	e8 00 00 00 00       	call   bf0 <region_putchar+0x2d4>
     bf0:	eb 01                	jmp    bf3 <region_putchar+0x2d7>
		if (c == 10 || c == 13) {
     bf2:	90                   	nop
		return c;
     bf3:	0f be 45 d4          	movsx  eax,BYTE PTR [rbp-0x2c]
}
     bf7:	c9                   	leave
     bf8:	c3                   	ret

0000000000000bf9 <getchar>:
{
     bf9:	55                   	push   rbp
     bfa:	48 89 e5             	mov    rbp,rsp
		return region_getchar(&reg_def);
     bfd:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     c04:	e8 00 00 00 00       	call   c09 <getchar+0x10>
}
     c09:	5d                   	pop    rbp
     c0a:	c3                   	ret

0000000000000c0b <putchar>:
{
     c0b:	55                   	push   rbp
     c0c:	48 89 e5             	mov    rbp,rsp
     c0f:	48 83 ec 10          	sub    rsp,0x10
     c13:	89 f8                	mov    eax,edi
     c15:	88 45 fc             	mov    BYTE PTR [rbp-0x4],al
		return region_putchar(&reg_def, c);
     c18:	0f be 45 fc          	movsx  eax,BYTE PTR [rbp-0x4]
     c1c:	89 c6                	mov    esi,eax
     c1e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     c25:	e8 00 00 00 00       	call   c2a <putchar+0x1f>
}
     c2a:	c9                   	leave
     c2b:	c3                   	ret

0000000000000c2c <region_puts>:
{
     c2c:	55                   	push   rbp
     c2d:	48 89 e5             	mov    rbp,rsp
     c30:	48 83 ec 10          	sub    rsp,0x10
     c34:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
     c38:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
		while(*str)
     c3c:	eb 20                	jmp    c5e <region_puts+0x32>
				region_putchar(cr, *(str++));
     c3e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     c42:	48 8d 50 01          	lea    rdx,[rax+0x1]
     c46:	48 89 55 f0          	mov    QWORD PTR [rbp-0x10],rdx
     c4a:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     c4d:	0f be d0             	movsx  edx,al
     c50:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     c54:	89 d6                	mov    esi,edx
     c56:	48 89 c7             	mov    rdi,rax
     c59:	e8 00 00 00 00       	call   c5e <region_puts+0x32>
		while(*str)
     c5e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
     c62:	0f b6 00             	movzx  eax,BYTE PTR [rax]
     c65:	84 c0                	test   al,al
     c67:	75 d5                	jne    c3e <region_puts+0x12>
}
     c69:	90                   	nop
     c6a:	90                   	nop
     c6b:	c9                   	leave
     c6c:	c3                   	ret

0000000000000c6d <puts>:
{
     c6d:	55                   	push   rbp
     c6e:	48 89 e5             	mov    rbp,rsp
     c71:	48 83 ec 10          	sub    rsp,0x10
     c75:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
		return region_puts(&reg_def, str);
     c79:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
     c7d:	48 89 c6             	mov    rsi,rax
     c80:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
     c87:	e8 00 00 00 00       	call   c8c <puts+0x1f>
}
     c8c:	c9                   	leave
     c8d:	c3                   	ret

0000000000000c8e <putb>:
{
     c8e:	55                   	push   rbp
     c8f:	48 89 e5             	mov    rbp,rsp
     c92:	48 83 ec 30          	sub    rsp,0x30
     c96:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
     c9a:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
     c9d:	89 c8                	mov    eax,ecx
     c9f:	44 89 c1             	mov    ecx,r8d
     ca2:	88 55 e0             	mov    BYTE PTR [rbp-0x20],dl
     ca5:	88 45 dc             	mov    BYTE PTR [rbp-0x24],al
     ca8:	89 c8                	mov    eax,ecx
     caa:	88 45 d8             	mov    BYTE PTR [rbp-0x28],al
		int i, nonz = 0, rv = 0;
     cad:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0
     cb4:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
		for (i = 0; i < 32; i++) {
     cbb:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
     cc2:	e9 ef 00 00 00       	jmp    db6 <putb+0x128>
				unsigned int bt = (arg & 0x80000000);
     cc7:	8b 45 e4             	mov    eax,DWORD PTR [rbp-0x1c]
     cca:	25 00 00 00 80       	and    eax,0x80000000
     ccf:	89 45 f0             	mov    DWORD PTR [rbp-0x10],eax
				rv++;
     cd2:	83 45 f4 01          	add    DWORD PTR [rbp-0xc],0x1
				if (bt) {
     cd6:	83 7d f0 00          	cmp    DWORD PTR [rbp-0x10],0x0
     cda:	74 22                	je     cfe <putb+0x70>
						nonz = 1;
     cdc:	c7 45 f8 01 00 00 00 	mov    DWORD PTR [rbp-0x8],0x1
						ctx->putchar(ctx, '1');
     ce3:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     ce7:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
     ceb:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     cef:	be 31 00 00 00       	mov    esi,0x31
     cf4:	48 89 c7             	mov    rdi,rax
     cf7:	ff d2                	call   rdx
     cf9:	e9 b1 00 00 00       	jmp    daf <putb+0x121>
				} else if (nonz)
     cfe:	83 7d f8 00          	cmp    DWORD PTR [rbp-0x8],0x0
     d02:	74 1b                	je     d1f <putb+0x91>
						ctx->putchar(ctx, '0');
     d04:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     d08:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
     d0c:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     d10:	be 30 00 00 00       	mov    esi,0x30
     d15:	48 89 c7             	mov    rdi,rax
     d18:	ff d2                	call   rdx
     d1a:	e9 90 00 00 00       	jmp    daf <putb+0x121>
				else if ((32 - i) <= prec) /* has precedence over with */
     d1f:	b8 20 00 00 00       	mov    eax,0x20
     d24:	2b 45 fc             	sub    eax,DWORD PTR [rbp-0x4]
     d27:	89 c2                	mov    edx,eax
     d29:	0f be 45 d8          	movsx  eax,BYTE PTR [rbp-0x28]
     d2d:	39 c2                	cmp    edx,eax
     d2f:	7f 18                	jg     d49 <putb+0xbb>
						ctx->putchar(ctx, '0');
     d31:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     d35:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
     d39:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     d3d:	be 30 00 00 00       	mov    esi,0x30
     d42:	48 89 c7             	mov    rdi,rax
     d45:	ff d2                	call   rdx
     d47:	eb 66                	jmp    daf <putb+0x121>
				else if ((32 - i) <= width)
     d49:	b8 20 00 00 00       	mov    eax,0x20
     d4e:	2b 45 fc             	sub    eax,DWORD PTR [rbp-0x4]
     d51:	89 c2                	mov    edx,eax
     d53:	0f be 45 dc          	movsx  eax,BYTE PTR [rbp-0x24]
     d57:	39 c2                	cmp    edx,eax
     d59:	7f 2c                	jg     d87 <putb+0xf9>
						ctx->putchar(ctx, flags & KFL_ZERO_PREFIX ? '0' : ' ');
     d5b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     d5f:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
     d63:	0f be 45 e0          	movsx  eax,BYTE PTR [rbp-0x20]
     d67:	83 e0 02             	and    eax,0x2
     d6a:	85 c0                	test   eax,eax
     d6c:	74 07                	je     d75 <putb+0xe7>
     d6e:	b9 30 00 00 00       	mov    ecx,0x30
     d73:	eb 05                	jmp    d7a <putb+0xec>
     d75:	b9 20 00 00 00       	mov    ecx,0x20
     d7a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     d7e:	89 ce                	mov    esi,ecx
     d80:	48 89 c7             	mov    rdi,rax
     d83:	ff d2                	call   rdx
     d85:	eb 28                	jmp    daf <putb+0x121>
				else if (i == 31 && prec >= 0) /* only print 0 for nonneg prec */
     d87:	83 7d fc 1f          	cmp    DWORD PTR [rbp-0x4],0x1f
     d8b:	75 1e                	jne    dab <putb+0x11d>
     d8d:	80 7d d8 00          	cmp    BYTE PTR [rbp-0x28],0x0
     d91:	78 18                	js     dab <putb+0x11d>
						ctx->putchar(ctx, '0');
     d93:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     d97:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
     d9b:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
     d9f:	be 30 00 00 00       	mov    esi,0x30
     da4:	48 89 c7             	mov    rdi,rax
     da7:	ff d2                	call   rdx
     da9:	eb 04                	jmp    daf <putb+0x121>
						rv--;
     dab:	83 6d f4 01          	sub    DWORD PTR [rbp-0xc],0x1
				arg <<= 1;
     daf:	d1 65 e4             	shl    DWORD PTR [rbp-0x1c],1
		for (i = 0; i < 32; i++) {
     db2:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
     db6:	83 7d fc 1f          	cmp    DWORD PTR [rbp-0x4],0x1f
     dba:	0f 8e 07 ff ff ff    	jle    cc7 <putb+0x39>
		}
		return rv;
     dc0:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
}
     dc3:	c9                   	leave
     dc4:	c3                   	ret

0000000000000dc5 <putu64>:

int putu64(struct ivp_ctx* ctx, unsigned long long int arg, char flags)
{
     dc5:	55                   	push   rbp
     dc6:	48 89 e5             	mov    rbp,rsp
     dc9:	48 83 ec 70          	sub    rsp,0x70
     dcd:	48 89 7d a8          	mov    QWORD PTR [rbp-0x58],rdi
     dd1:	48 89 75 a0          	mov    QWORD PTR [rbp-0x60],rsi
     dd5:	89 d0                	mov    eax,edx
     dd7:	88 45 9c             	mov    BYTE PTR [rbp-0x64],al
		int rv = 0, i, nonz = 0;
     dda:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
     de1:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
		if (flags & KFL_IS_HEX) {
     de8:	0f be 45 9c          	movsx  eax,BYTE PTR [rbp-0x64]
     dec:	83 e0 01             	and    eax,0x1
     def:	85 c0                	test   eax,eax
     df1:	0f 84 ed 00 00 00    	je     ee4 <putu64+0x11f>
				for (i = 0; i < 16; i++) {
     df7:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0
     dfe:	e9 d2 00 00 00       	jmp    ed5 <putu64+0x110>
						unsigned long long int hf = (arg & 0xf000000000000000);
     e03:	48 b8 00 00 00 00 00 00 00 f0 	movabs rax,0xf000000000000000
     e0d:	48 23 45 a0          	and    rax,QWORD PTR [rbp-0x60]
     e11:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
						char hc = (flags & KFL_CAPITAL) ? CHEXCHAR(hf >> 60) : HEXCHAR(hf >> 60);
     e15:	80 7d 9c 00          	cmp    BYTE PTR [rbp-0x64],0x0
     e19:	79 28                	jns    e43 <putu64+0x7e>
     e1b:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     e1f:	48 c1 e8 3c          	shr    rax,0x3c
     e23:	48 83 f8 09          	cmp    rax,0x9
     e27:	77 0d                	ja     e36 <putu64+0x71>
     e29:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     e2d:	48 c1 e8 3c          	shr    rax,0x3c
     e31:	83 c0 30             	add    eax,0x30
     e34:	eb 33                	jmp    e69 <putu64+0xa4>
     e36:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     e3a:	48 c1 e8 3c          	shr    rax,0x3c
     e3e:	83 c0 37             	add    eax,0x37
     e41:	eb 26                	jmp    e69 <putu64+0xa4>
     e43:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     e47:	48 c1 e8 3c          	shr    rax,0x3c
     e4b:	48 83 f8 09          	cmp    rax,0x9
     e4f:	77 0d                	ja     e5e <putu64+0x99>
     e51:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     e55:	48 c1 e8 3c          	shr    rax,0x3c
     e59:	83 c0 30             	add    eax,0x30
     e5c:	eb 0b                	jmp    e69 <putu64+0xa4>
     e5e:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
     e62:	48 c1 e8 3c          	shr    rax,0x3c
     e66:	83 c0 57             	add    eax,0x57
     e69:	88 45 bf             	mov    BYTE PTR [rbp-0x41],al
						rv++;
     e6c:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
						if (hc != '0') {
     e70:	80 7d bf 30          	cmp    BYTE PTR [rbp-0x41],0x30
     e74:	74 27                	je     e9d <putu64+0xd8>
								nonz = 1;
     e76:	c7 45 f4 01 00 00 00 	mov    DWORD PTR [rbp-0xc],0x1
								if (ctx) ctx->putchar(ctx, hc);
     e7d:	48 83 7d a8 00       	cmp    QWORD PTR [rbp-0x58],0x0
     e82:	74 48                	je     ecc <putu64+0x107>
     e84:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     e88:	48 8b 48 10          	mov    rcx,QWORD PTR [rax+0x10]
     e8c:	0f be 55 bf          	movsx  edx,BYTE PTR [rbp-0x41]
     e90:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     e94:	89 d6                	mov    esi,edx
     e96:	48 89 c7             	mov    rdi,rax
     e99:	ff d1                	call   rcx
     e9b:	eb 2f                	jmp    ecc <putu64+0x107>
						} else if (nonz || i == 15) {
     e9d:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
     ea1:	75 06                	jne    ea9 <putu64+0xe4>
     ea3:	83 7d f8 0f          	cmp    DWORD PTR [rbp-0x8],0xf
     ea7:	75 1f                	jne    ec8 <putu64+0x103>
								if (ctx) ctx->putchar(ctx, '0');
     ea9:	48 83 7d a8 00       	cmp    QWORD PTR [rbp-0x58],0x0
     eae:	74 1c                	je     ecc <putu64+0x107>
     eb0:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     eb4:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
     eb8:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     ebc:	be 30 00 00 00       	mov    esi,0x30
     ec1:	48 89 c7             	mov    rdi,rax
     ec4:	ff d2                	call   rdx
     ec6:	eb 04                	jmp    ecc <putu64+0x107>
						} else
								rv--;
     ec8:	83 6d fc 01          	sub    DWORD PTR [rbp-0x4],0x1
						arg <<= 4;
     ecc:	48 c1 65 a0 04       	shl    QWORD PTR [rbp-0x60],0x4
				for (i = 0; i < 16; i++) {
     ed1:	83 45 f8 01          	add    DWORD PTR [rbp-0x8],0x1
     ed5:	83 7d f8 0f          	cmp    DWORD PTR [rbp-0x8],0xf
     ed9:	0f 8e 24 ff ff ff    	jle    e03 <putu64+0x3e>
     edf:	e9 b9 01 00 00       	jmp    109d <putu64+0x2d8>
				}
		} else if (flags & KFL_IS_OCT) {
     ee4:	0f be 45 9c          	movsx  eax,BYTE PTR [rbp-0x64]
     ee8:	83 e0 40             	and    eax,0x40
     eeb:	85 c0                	test   eax,eax
     eed:	0f 84 d5 00 00 00    	je     fc8 <putu64+0x203>
				/* process first bit */
				if (arg & (1ull << 63)) {
     ef3:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     ef7:	48 85 c0             	test   rax,rax
     efa:	79 28                	jns    f24 <putu64+0x15f>
						rv++; nonz = 1;
     efc:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
     f00:	c7 45 f4 01 00 00 00 	mov    DWORD PTR [rbp-0xc],0x1
						if (ctx) ctx->putchar(ctx, '1');
     f07:	48 83 7d a8 00       	cmp    QWORD PTR [rbp-0x58],0x0
     f0c:	74 16                	je     f24 <putu64+0x15f>
     f0e:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     f12:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
     f16:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     f1a:	be 31 00 00 00       	mov    esi,0x31
     f1f:	48 89 c7             	mov    rdi,rax
     f22:	ff d2                	call   rdx
				}
				for (i = 0; i < 21; i++) {
     f24:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0
     f2b:	e9 89 00 00 00       	jmp    fb9 <putu64+0x1f4>
						unsigned long long int of = (arg & 0700000000000000000000);
     f30:	48 b8 00 00 00 00 00 00 00 70 	movabs rax,0x7000000000000000
     f3a:	48 23 45 a0          	and    rax,QWORD PTR [rbp-0x60]
     f3e:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
						char oc = '0' + (char)(of >> 60);
     f42:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
     f46:	48 c1 e8 3c          	shr    rax,0x3c
     f4a:	83 c0 30             	add    eax,0x30
     f4d:	88 45 cf             	mov    BYTE PTR [rbp-0x31],al
						rv++;
     f50:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
						if (oc != '0') {
     f54:	80 7d cf 30          	cmp    BYTE PTR [rbp-0x31],0x30
     f58:	74 27                	je     f81 <putu64+0x1bc>
								nonz = 1;
     f5a:	c7 45 f4 01 00 00 00 	mov    DWORD PTR [rbp-0xc],0x1
								if (ctx) ctx->putchar(ctx, oc);
     f61:	48 83 7d a8 00       	cmp    QWORD PTR [rbp-0x58],0x0
     f66:	74 48                	je     fb0 <putu64+0x1eb>
     f68:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     f6c:	48 8b 48 10          	mov    rcx,QWORD PTR [rax+0x10]
     f70:	0f be 55 cf          	movsx  edx,BYTE PTR [rbp-0x31]
     f74:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     f78:	89 d6                	mov    esi,edx
     f7a:	48 89 c7             	mov    rdi,rax
     f7d:	ff d1                	call   rcx
     f7f:	eb 2f                	jmp    fb0 <putu64+0x1eb>
						} else if (nonz || i == 20) {
     f81:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
     f85:	75 06                	jne    f8d <putu64+0x1c8>
     f87:	83 7d f8 14          	cmp    DWORD PTR [rbp-0x8],0x14
     f8b:	75 1f                	jne    fac <putu64+0x1e7>
								if (ctx) ctx->putchar(ctx, '0');
     f8d:	48 83 7d a8 00       	cmp    QWORD PTR [rbp-0x58],0x0
     f92:	74 1c                	je     fb0 <putu64+0x1eb>
     f94:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     f98:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
     f9c:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
     fa0:	be 30 00 00 00       	mov    esi,0x30
     fa5:	48 89 c7             	mov    rdi,rax
     fa8:	ff d2                	call   rdx
     faa:	eb 04                	jmp    fb0 <putu64+0x1eb>
						} else
								rv--;
     fac:	83 6d fc 01          	sub    DWORD PTR [rbp-0x4],0x1
						arg <<= 3;
     fb0:	48 c1 65 a0 03       	shl    QWORD PTR [rbp-0x60],0x3
				for (i = 0; i < 21; i++) {
     fb5:	83 45 f8 01          	add    DWORD PTR [rbp-0x8],0x1
     fb9:	83 7d f8 14          	cmp    DWORD PTR [rbp-0x8],0x14
     fbd:	0f 8e 6d ff ff ff    	jle    f30 <putu64+0x16b>
     fc3:	e9 d5 00 00 00       	jmp    109d <putu64+0x2d8>
				}
		} else {
				unsigned long long int div = 1000000000000000000;
     fc8:	48 b8 00 00 64 a7 b3 b6 e0 0d 	movabs rax,0xde0b6b3a7640000
     fd2:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
				unsigned long long int res; char frst = 0;
     fd6:	c6 45 e7 00          	mov    BYTE PTR [rbp-0x19],0x0
				i = 0;
     fda:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0
				while (div) {
     fe1:	e9 a6 00 00 00       	jmp    108c <putu64+0x2c7>
					res = arg / div;
     fe6:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     fea:	ba 00 00 00 00       	mov    edx,0x0
     fef:	48 f7 75 e8          	div    QWORD PTR [rbp-0x18]
     ff3:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
					arg %= div; rv++;
     ff7:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
     ffb:	ba 00 00 00 00       	mov    edx,0x0
    1000:	48 f7 75 e8          	div    QWORD PTR [rbp-0x18]
    1004:	48 89 55 a0          	mov    QWORD PTR [rbp-0x60],rdx
    1008:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
					if (res || frst) {
    100c:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
    1011:	75 06                	jne    1019 <putu64+0x254>
    1013:	80 7d e7 00          	cmp    BYTE PTR [rbp-0x19],0x0
    1017:	74 2a                	je     1043 <putu64+0x27e>
						if (ctx) ctx->putchar(ctx, '0' + (char)res);
    1019:	48 83 7d a8 00       	cmp    QWORD PTR [rbp-0x58],0x0
    101e:	74 1d                	je     103d <putu64+0x278>
    1020:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1024:	48 8b 48 10          	mov    rcx,QWORD PTR [rax+0x10]
    1028:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    102c:	83 c0 30             	add    eax,0x30
    102f:	0f be d0             	movsx  edx,al
    1032:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1036:	89 d6                	mov    esi,edx
    1038:	48 89 c7             	mov    rdi,rax
    103b:	ff d1                	call   rcx
						frst = 1;
    103d:	c6 45 e7 01          	mov    BYTE PTR [rbp-0x19],0x1
    1041:	eb 29                	jmp    106c <putu64+0x2a7>
					} else if (i == 18) {
    1043:	83 7d f8 12          	cmp    DWORD PTR [rbp-0x8],0x12
    1047:	75 1f                	jne    1068 <putu64+0x2a3>
							if (ctx) ctx->putchar(ctx, '0');
    1049:	48 83 7d a8 00       	cmp    QWORD PTR [rbp-0x58],0x0
    104e:	74 1c                	je     106c <putu64+0x2a7>
    1050:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1054:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1058:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    105c:	be 30 00 00 00       	mov    esi,0x30
    1061:	48 89 c7             	mov    rdi,rax
    1064:	ff d2                	call   rdx
    1066:	eb 04                	jmp    106c <putu64+0x2a7>
					} else
							rv--;
    1068:	83 6d fc 01          	sub    DWORD PTR [rbp-0x4],0x1
					div /= 10;
    106c:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1070:	48 ba cd cc cc cc cc cc cc cc 	movabs rdx,0xcccccccccccccccd
    107a:	48 f7 e2             	mul    rdx
    107d:	48 89 d0             	mov    rax,rdx
    1080:	48 c1 e8 03          	shr    rax,0x3
    1084:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
					i++;
    1088:	83 45 f8 01          	add    DWORD PTR [rbp-0x8],0x1
				while (div) {
    108c:	48 83 7d e8 00       	cmp    QWORD PTR [rbp-0x18],0x0
    1091:	0f 85 4f ff ff ff    	jne    fe6 <putu64+0x221>
				}
				i = rv;
    1097:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    109a:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
		}
		return rv;
    109d:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
    10a0:	c9                   	leave
    10a1:	c3                   	ret

00000000000010a2 <usermode_entry>:

void usermode_entry()
{
    10a2:	55                   	push   rbp
    10a3:	48 89 e5             	mov    rbp,rsp
    10a6:	48 83 ec 10          	sub    rsp,0x10
		int val = 4;
    10aa:	c7 45 fc 04 00 00 00 	mov    DWORD PTR [rbp-0x4],0x4
		printf("The adress of the stack is around %p\n", &val);
    10b1:	48 8d 45 fc          	lea    rax,[rbp-0x4]
    10b5:	48 89 c6             	mov    rsi,rax
    10b8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    10bf:	b8 00 00 00 00       	mov    eax,0x0
    10c4:	e8 00 00 00 00       	call   10c9 <usermode_entry+0x27>
		printf("which is set within the kernel stack\n");
    10c9:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    10d0:	b8 00 00 00 00       	mov    eax,0x0
    10d5:	e8 00 00 00 00       	call   10da <usermode_entry+0x38>
		while (1);
    10da:	90                   	nop
    10db:	eb fd                	jmp    10da <usermode_entry+0x38>

00000000000010dd <fun>:

}

void fun()
{
    10dd:	55                   	push   rbp
    10de:	48 89 e5             	mov    rbp,rsp
		/* float test etc. */
		extern void to_usermode();
		/*to_usermode();*/
}
    10e1:	90                   	nop
    10e2:	5d                   	pop    rbp
    10e3:	c3                   	ret

00000000000010e4 <putu>:
 * tz localtime usw.
 * thread list & lock registry
__thread int iv = 0; <- drepper TLS article LDO, LE, LI
iv = 5; */
int putu(struct ivp_ctx* ctx, unsigned long long int arg, char flags, char width, char prec)
{
    10e4:	55                   	push   rbp
    10e5:	48 89 e5             	mov    rbp,rsp
    10e8:	48 83 ec 40          	sub    rsp,0x40
    10ec:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
    10f0:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi
    10f4:	89 c8                	mov    eax,ecx
    10f6:	44 89 c1             	mov    ecx,r8d
    10f9:	88 55 cc             	mov    BYTE PTR [rbp-0x34],dl
    10fc:	88 45 c8             	mov    BYTE PTR [rbp-0x38],al
    10ff:	89 c8                	mov    eax,ecx
    1101:	88 45 c4             	mov    BYTE PTR [rbp-0x3c],al
		int len, rv = 0;
    1104:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
		int ns = 0, nz = 0, neg = ((flags & KFL_IS_NEG) == KFL_IS_NEG), zero = 0;
    110b:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0
    1112:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
    1119:	0f be 45 cc          	movsx  eax,BYTE PTR [rbp-0x34]
    111d:	25 c0 00 00 00       	and    eax,0xc0
    1122:	3d c0 00 00 00       	cmp    eax,0xc0
    1127:	0f 94 c0             	sete   al
    112a:	0f b6 c0             	movzx  eax,al
    112d:	89 45 ec             	mov    DWORD PTR [rbp-0x14],eax
    1130:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [rbp-0x10],0x0
		if (neg/* && (flags & KFL_IS_HEX)*/)
    1137:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
    113b:	74 04                	je     1141 <putu+0x5d>
				flags &= ~KFL_IS_OCT;
    113d:	80 65 cc bf          	and    BYTE PTR [rbp-0x34],0xbf
		/* calc len */
		len = putu64(NULL, arg, flags);
    1141:	0f be 55 cc          	movsx  edx,BYTE PTR [rbp-0x34]
    1145:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1149:	48 89 c6             	mov    rsi,rax
    114c:	bf 00 00 00 00       	mov    edi,0x0
    1151:	e8 00 00 00 00       	call   1156 <putu+0x72>
    1156:	89 45 e8             	mov    DWORD PTR [rbp-0x18],eax
		/* print at least width characters with prec digits */
		if (neg || (flags & (KFL_ALWAYS_SIGN | KFL_SPACE_PLUS)))
    1159:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
    115d:	75 0b                	jne    116a <putu+0x86>
    115f:	0f be 45 cc          	movsx  eax,BYTE PTR [rbp-0x34]
    1163:	83 e0 24             	and    eax,0x24
    1166:	85 c0                	test   eax,eax
    1168:	74 04                	je     116e <putu+0x8a>
				rv++; /* one sign character */
    116a:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
		rv += len;
    116e:	8b 45 e8             	mov    eax,DWORD PTR [rbp-0x18]
    1171:	01 45 fc             	add    DWORD PTR [rbp-0x4],eax
		if ((prec == -1) && !arg) {/* omit zero and sign, honor width */
    1174:	80 7d c4 ff          	cmp    BYTE PTR [rbp-0x3c],0xff
    1178:	75 17                	jne    1191 <putu+0xad>
    117a:	48 83 7d d0 00       	cmp    QWORD PTR [rbp-0x30],0x0
    117f:	75 10                	jne    1191 <putu+0xad>
				rv = 0;
    1181:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
				zero = 1;
    1188:	c7 45 f0 01 00 00 00 	mov    DWORD PTR [rbp-0x10],0x1
    118f:	eb 2b                	jmp    11bc <putu+0xd8>
		}
		else if (flags & KFL_TYPE_PREFIX) {/* print type prefix (if printing 0) */
    1191:	0f be 45 cc          	movsx  eax,BYTE PTR [rbp-0x34]
    1195:	83 e0 10             	and    eax,0x10
    1198:	85 c0                	test   eax,eax
    119a:	74 20                	je     11bc <putu+0xd8>
				if (flags & KFL_IS_HEX)
    119c:	0f be 45 cc          	movsx  eax,BYTE PTR [rbp-0x34]
    11a0:	83 e0 01             	and    eax,0x1
    11a3:	85 c0                	test   eax,eax
    11a5:	74 06                	je     11ad <putu+0xc9>
						rv += 2;
    11a7:	83 45 fc 02          	add    DWORD PTR [rbp-0x4],0x2
    11ab:	eb 0f                	jmp    11bc <putu+0xd8>
				else if (flags & KFL_IS_OCT)
    11ad:	0f be 45 cc          	movsx  eax,BYTE PTR [rbp-0x34]
    11b1:	83 e0 40             	and    eax,0x40
    11b4:	85 c0                	test   eax,eax
    11b6:	74 04                	je     11bc <putu+0xd8>
						rv++;
    11b8:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
		}
		/* get nz and ns to match width & prec */
		if (flags & KFL_ZERO_PREFIX) {
    11bc:	0f be 45 cc          	movsx  eax,BYTE PTR [rbp-0x34]
    11c0:	83 e0 02             	and    eax,0x2
    11c3:	85 c0                	test   eax,eax
    11c5:	74 22                	je     11e9 <putu+0x105>
				nz = max(width - rv, prec);
    11c7:	0f be 55 c4          	movsx  edx,BYTE PTR [rbp-0x3c]
    11cb:	0f be 45 c8          	movsx  eax,BYTE PTR [rbp-0x38]
    11cf:	2b 45 fc             	sub    eax,DWORD PTR [rbp-0x4]
    11d2:	39 c2                	cmp    edx,eax
    11d4:	0f 4d c2             	cmovge eax,edx
    11d7:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
				if (nz < 0)
    11da:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
    11de:	79 46                	jns    1226 <putu+0x142>
						nz = 0;
    11e0:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
    11e7:	eb 3d                	jmp    1226 <putu+0x142>
		} else {
				if (prec > 0)
    11e9:	80 7d c4 00          	cmp    BYTE PTR [rbp-0x3c],0x0
    11ed:	7e 0a                	jle    11f9 <putu+0x115>
						nz = prec - len;
    11ef:	0f be 45 c4          	movsx  eax,BYTE PTR [rbp-0x3c]
    11f3:	2b 45 e8             	sub    eax,DWORD PTR [rbp-0x18]
    11f6:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
				if (nz < 0)
    11f9:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
    11fd:	79 07                	jns    1206 <putu+0x122>
						nz = 0;
    11ff:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
				if (width)
    1206:	80 7d c8 00          	cmp    BYTE PTR [rbp-0x38],0x0
    120a:	74 0d                	je     1219 <putu+0x135>
						ns = width - rv - nz;
    120c:	0f be 45 c8          	movsx  eax,BYTE PTR [rbp-0x38]
    1210:	2b 45 fc             	sub    eax,DWORD PTR [rbp-0x4]
    1213:	2b 45 f4             	sub    eax,DWORD PTR [rbp-0xc]
    1216:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
				if (ns < 0)
    1219:	83 7d f8 00          	cmp    DWORD PTR [rbp-0x8],0x0
    121d:	79 07                	jns    1226 <putu+0x142>
						ns = 0;
    121f:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0
		}
		rv += nz + ns;
    1226:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    1229:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    122c:	01 d0                	add    eax,edx
    122e:	01 45 fc             	add    DWORD PTR [rbp-0x4],eax
		/* now print and start with padding */
		if (flags & KFL_LEFT_ALIGN)
    1231:	0f be 45 cc          	movsx  eax,BYTE PTR [rbp-0x34]
    1235:	83 e0 08             	and    eax,0x8
    1238:	85 c0                	test   eax,eax
    123a:	74 25                	je     1261 <putu+0x17d>
				while (ns--)
    123c:	eb 16                	jmp    1254 <putu+0x170>
						ctx->putchar(ctx, ' ');
    123e:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1242:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1246:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    124a:	be 20 00 00 00       	mov    esi,0x20
    124f:	48 89 c7             	mov    rdi,rax
    1252:	ff d2                	call   rdx
				while (ns--)
    1254:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    1257:	8d 50 ff             	lea    edx,[rax-0x1]
    125a:	89 55 f8             	mov    DWORD PTR [rbp-0x8],edx
    125d:	85 c0                	test   eax,eax
    125f:	75 dd                	jne    123e <putu+0x15a>
		/* now the sign */
		if (neg)
    1261:	83 7d ec 00          	cmp    DWORD PTR [rbp-0x14],0x0
    1265:	74 18                	je     127f <putu+0x19b>
				ctx->putchar(ctx, '-');
    1267:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    126b:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    126f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1273:	be 2d 00 00 00       	mov    esi,0x2d
    1278:	48 89 c7             	mov    rdi,rax
    127b:	ff d2                	call   rdx
    127d:	eb 50                	jmp    12cf <putu+0x1eb>
		else if (flags & KFL_ALWAYS_SIGN && !zero)
    127f:	0f be 45 cc          	movsx  eax,BYTE PTR [rbp-0x34]
    1283:	83 e0 04             	and    eax,0x4
    1286:	85 c0                	test   eax,eax
    1288:	74 1e                	je     12a8 <putu+0x1c4>
    128a:	83 7d f0 00          	cmp    DWORD PTR [rbp-0x10],0x0
    128e:	75 18                	jne    12a8 <putu+0x1c4>
				ctx->putchar(ctx, '+');
    1290:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1294:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1298:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    129c:	be 2b 00 00 00       	mov    esi,0x2b
    12a1:	48 89 c7             	mov    rdi,rax
    12a4:	ff d2                	call   rdx
    12a6:	eb 27                	jmp    12cf <putu+0x1eb>
		else if (flags & KFL_SPACE_PLUS && !zero)
    12a8:	0f be 45 cc          	movsx  eax,BYTE PTR [rbp-0x34]
    12ac:	83 e0 20             	and    eax,0x20
    12af:	85 c0                	test   eax,eax
    12b1:	74 1c                	je     12cf <putu+0x1eb>
    12b3:	83 7d f0 00          	cmp    DWORD PTR [rbp-0x10],0x0
    12b7:	75 16                	jne    12cf <putu+0x1eb>
				ctx->putchar(ctx, ' ');
    12b9:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    12bd:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    12c1:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    12c5:	be 20 00 00 00       	mov    esi,0x20
    12ca:	48 89 c7             	mov    rdi,rax
    12cd:	ff d2                	call   rdx
		/* now the type prefix */
		if ((flags & KFL_TYPE_PREFIX) && !zero) {
    12cf:	0f be 45 cc          	movsx  eax,BYTE PTR [rbp-0x34]
    12d3:	83 e0 10             	and    eax,0x10
    12d6:	85 c0                	test   eax,eax
    12d8:	0f 84 9a 00 00 00    	je     1378 <putu+0x294>
    12de:	83 7d f0 00          	cmp    DWORD PTR [rbp-0x10],0x0
    12e2:	0f 85 90 00 00 00    	jne    1378 <putu+0x294>
				if (flags & KFL_IS_HEX) {
    12e8:	0f be 45 cc          	movsx  eax,BYTE PTR [rbp-0x34]
    12ec:	83 e0 01             	and    eax,0x1
    12ef:	85 c0                	test   eax,eax
    12f1:	74 4c                	je     133f <putu+0x25b>
						ctx->putchar(ctx, '0');
    12f3:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    12f7:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    12fb:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    12ff:	be 30 00 00 00       	mov    esi,0x30
    1304:	48 89 c7             	mov    rdi,rax
    1307:	ff d2                	call   rdx
						if (flags & KFL_CAPITAL)
    1309:	80 7d cc 00          	cmp    BYTE PTR [rbp-0x34],0x0
    130d:	79 18                	jns    1327 <putu+0x243>
								ctx->putchar(ctx, 'X');
    130f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1313:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1317:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    131b:	be 58 00 00 00       	mov    esi,0x58
    1320:	48 89 c7             	mov    rdi,rax
    1323:	ff d2                	call   rdx
    1325:	eb 51                	jmp    1378 <putu+0x294>
						else
								ctx->putchar(ctx, 'x');
    1327:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    132b:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    132f:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1333:	be 78 00 00 00       	mov    esi,0x78
    1338:	48 89 c7             	mov    rdi,rax
    133b:	ff d2                	call   rdx
    133d:	eb 39                	jmp    1378 <putu+0x294>
				} else if (flags & KFL_IS_OCT)
    133f:	0f be 45 cc          	movsx  eax,BYTE PTR [rbp-0x34]
    1343:	83 e0 40             	and    eax,0x40
    1346:	85 c0                	test   eax,eax
    1348:	74 2e                	je     1378 <putu+0x294>
						ctx->putchar(ctx, '0');
    134a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    134e:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1352:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1356:	be 30 00 00 00       	mov    esi,0x30
    135b:	48 89 c7             	mov    rdi,rax
    135e:	ff d2                	call   rdx
		}
		/* print the zero padding */
		while (nz--)
    1360:	eb 16                	jmp    1378 <putu+0x294>
				ctx->putchar(ctx, '0');
    1362:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1366:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    136a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    136e:	be 30 00 00 00       	mov    esi,0x30
    1373:	48 89 c7             	mov    rdi,rax
    1376:	ff d2                	call   rdx
		while (nz--)
    1378:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    137b:	8d 50 ff             	lea    edx,[rax-0x1]
    137e:	89 55 f4             	mov    DWORD PTR [rbp-0xc],edx
    1381:	85 c0                	test   eax,eax
    1383:	75 dd                	jne    1362 <putu+0x27e>
		/* now emit the digits */
		if (!zero)
    1385:	83 7d f0 00          	cmp    DWORD PTR [rbp-0x10],0x0
    1389:	75 2f                	jne    13ba <putu+0x2d6>
				putu64(ctx, arg, flags);
    138b:	0f be 55 cc          	movsx  edx,BYTE PTR [rbp-0x34]
    138f:	48 8b 4d d0          	mov    rcx,QWORD PTR [rbp-0x30]
    1393:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1397:	48 89 ce             	mov    rsi,rcx
    139a:	48 89 c7             	mov    rdi,rax
    139d:	e8 00 00 00 00       	call   13a2 <putu+0x2be>
		/* and the padding */
		while (ns-- > 0)
    13a2:	eb 16                	jmp    13ba <putu+0x2d6>
				ctx->putchar(ctx, ' ');
    13a4:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    13a8:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    13ac:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    13b0:	be 20 00 00 00       	mov    esi,0x20
    13b5:	48 89 c7             	mov    rdi,rax
    13b8:	ff d2                	call   rdx
		while (ns-- > 0)
    13ba:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    13bd:	8d 50 ff             	lea    edx,[rax-0x1]
    13c0:	89 55 f8             	mov    DWORD PTR [rbp-0x8],edx
    13c3:	85 c0                	test   eax,eax
    13c5:	7f dd                	jg     13a4 <putu+0x2c0>
		return rv;
    13c7:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
    13ca:	c9                   	leave
    13cb:	c3                   	ret

00000000000013cc <putmin>:

int putmin(struct ivp_ctx* ctx, char flags, char width, char prec)
{
    13cc:	55                   	push   rbp
    13cd:	48 89 e5             	mov    rbp,rsp
    13d0:	48 83 ec 60          	sub    rsp,0x60
    13d4:	48 89 7d b8          	mov    QWORD PTR [rbp-0x48],rdi
    13d8:	89 c8                	mov    eax,ecx
    13da:	89 f1                	mov    ecx,esi
    13dc:	88 4d b4             	mov    BYTE PTR [rbp-0x4c],cl
    13df:	88 55 b0             	mov    BYTE PTR [rbp-0x50],dl
    13e2:	88 45 ac             	mov    BYTE PTR [rbp-0x54],al
		const char* str_min[] =
    13e5:	48 c7 45 c0 00 00 00 00 	mov    QWORD PTR [rbp-0x40],0x0
    13ed:	48 c7 45 c8 00 00 00 00 	mov    QWORD PTR [rbp-0x38],0x0
    13f5:	48 c7 45 d0 00 00 00 00 	mov    QWORD PTR [rbp-0x30],0x0
		{
				/*"-8000", "-80000000",*/ "8000000000000000", /* hex */
				/*"-100000", "-20000000000",*/ "1000000000000000000000", /* oct*/
				/*"-32768", "-2147483648",*/ "9223372036854775808" /* dec */
		};
		int rv = 0, nz = 0, ns = 0, len;
    13fd:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
    1404:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0
    140b:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
		const char* str = ((flags & KFL_IS_HEX) ? str_min[0] : ((flags & KFL_IS_OCT) ? str_min[1] : str_min[2]));
    1412:	0f be 45 b4          	movsx  eax,BYTE PTR [rbp-0x4c]
    1416:	83 e0 01             	and    eax,0x1
    1419:	85 c0                	test   eax,eax
    141b:	74 06                	je     1423 <putmin+0x57>
    141d:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1421:	eb 15                	jmp    1438 <putmin+0x6c>
    1423:	0f be 45 b4          	movsx  eax,BYTE PTR [rbp-0x4c]
    1427:	83 e0 40             	and    eax,0x40
    142a:	85 c0                	test   eax,eax
    142c:	74 06                	je     1434 <putmin+0x68>
    142e:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    1432:	eb 04                	jmp    1438 <putmin+0x6c>
    1434:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1438:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
		len = strlen(str);
    143c:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1440:	48 89 c7             	mov    rdi,rax
    1443:	e8 00 00 00 00       	call   1448 <putmin+0x7c>
    1448:	89 45 dc             	mov    DWORD PTR [rbp-0x24],eax
		rv = len + 1;
    144b:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    144e:	83 c0 01             	add    eax,0x1
    1451:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		if (flags & KFL_TYPE_PREFIX) {
    1454:	0f be 45 b4          	movsx  eax,BYTE PTR [rbp-0x4c]
    1458:	83 e0 10             	and    eax,0x10
    145b:	85 c0                	test   eax,eax
    145d:	74 20                	je     147f <putmin+0xb3>
				if (flags & KFL_IS_HEX)
    145f:	0f be 45 b4          	movsx  eax,BYTE PTR [rbp-0x4c]
    1463:	83 e0 01             	and    eax,0x1
    1466:	85 c0                	test   eax,eax
    1468:	74 06                	je     1470 <putmin+0xa4>
						rv += 2;
    146a:	83 45 fc 02          	add    DWORD PTR [rbp-0x4],0x2
    146e:	eb 0f                	jmp    147f <putmin+0xb3>
				else if (flags & KFL_IS_OCT)
    1470:	0f be 45 b4          	movsx  eax,BYTE PTR [rbp-0x4c]
    1474:	83 e0 40             	and    eax,0x40
    1477:	85 c0                	test   eax,eax
    1479:	74 04                	je     147f <putmin+0xb3>
						rv += 1;
    147b:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
		}
		/* calculate the spacing */
		if (flags & KFL_ZERO_PREFIX) {
    147f:	0f be 45 b4          	movsx  eax,BYTE PTR [rbp-0x4c]
    1483:	83 e0 02             	and    eax,0x2
    1486:	85 c0                	test   eax,eax
    1488:	74 22                	je     14ac <putmin+0xe0>
				nz = max(width - rv, prec);
    148a:	0f be 55 ac          	movsx  edx,BYTE PTR [rbp-0x54]
    148e:	0f be 45 b0          	movsx  eax,BYTE PTR [rbp-0x50]
    1492:	2b 45 fc             	sub    eax,DWORD PTR [rbp-0x4]
    1495:	39 c2                	cmp    edx,eax
    1497:	0f 4d c2             	cmovge eax,edx
    149a:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
				if (nz < 0)
    149d:	83 7d f8 00          	cmp    DWORD PTR [rbp-0x8],0x0
    14a1:	79 46                	jns    14e9 <putmin+0x11d>
						nz = 0;
    14a3:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0
    14aa:	eb 3d                	jmp    14e9 <putmin+0x11d>
		} else {
				if (prec > 0)
    14ac:	80 7d ac 00          	cmp    BYTE PTR [rbp-0x54],0x0
    14b0:	7e 0a                	jle    14bc <putmin+0xf0>
						nz = prec - len;
    14b2:	0f be 45 ac          	movsx  eax,BYTE PTR [rbp-0x54]
    14b6:	2b 45 dc             	sub    eax,DWORD PTR [rbp-0x24]
    14b9:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
				if (nz < 0)
    14bc:	83 7d f8 00          	cmp    DWORD PTR [rbp-0x8],0x0
    14c0:	79 07                	jns    14c9 <putmin+0xfd>
						nz = 0;
    14c2:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [rbp-0x8],0x0
				if (width)
    14c9:	80 7d b0 00          	cmp    BYTE PTR [rbp-0x50],0x0
    14cd:	74 0d                	je     14dc <putmin+0x110>
						ns = width - rv - nz;
    14cf:	0f be 45 b0          	movsx  eax,BYTE PTR [rbp-0x50]
    14d3:	2b 45 fc             	sub    eax,DWORD PTR [rbp-0x4]
    14d6:	2b 45 f8             	sub    eax,DWORD PTR [rbp-0x8]
    14d9:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
				if (ns < 0)
    14dc:	83 7d f4 00          	cmp    DWORD PTR [rbp-0xc],0x0
    14e0:	79 07                	jns    14e9 <putmin+0x11d>
						ns = 0;
    14e2:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
		}
		rv += nz + ns;
    14e9:	8b 55 f8             	mov    edx,DWORD PTR [rbp-0x8]
    14ec:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    14ef:	01 d0                	add    eax,edx
    14f1:	01 45 fc             	add    DWORD PTR [rbp-0x4],eax
		/* print spaces */
		if (flags & KFL_LEFT_ALIGN)
    14f4:	0f be 45 b4          	movsx  eax,BYTE PTR [rbp-0x4c]
    14f8:	83 e0 08             	and    eax,0x8
    14fb:	85 c0                	test   eax,eax
    14fd:	74 25                	je     1524 <putmin+0x158>
				while (ns--)
    14ff:	eb 16                	jmp    1517 <putmin+0x14b>
						ctx->putchar(ctx, ' ');
    1501:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1505:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1509:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    150d:	be 20 00 00 00       	mov    esi,0x20
    1512:	48 89 c7             	mov    rdi,rax
    1515:	ff d2                	call   rdx
				while (ns--)
    1517:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    151a:	8d 50 ff             	lea    edx,[rax-0x1]
    151d:	89 55 f4             	mov    DWORD PTR [rbp-0xc],edx
    1520:	85 c0                	test   eax,eax
    1522:	75 dd                	jne    1501 <putmin+0x135>
		/* print the minus sign */
		if (ctx) ctx->putchar(ctx, '-');
    1524:	48 83 7d b8 00       	cmp    QWORD PTR [rbp-0x48],0x0
    1529:	74 16                	je     1541 <putmin+0x175>
    152b:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    152f:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1533:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1537:	be 2d 00 00 00       	mov    esi,0x2d
    153c:	48 89 c7             	mov    rdi,rax
    153f:	ff d2                	call   rdx
		/* print the type prefix */
		if (flags & KFL_TYPE_PREFIX) {
    1541:	0f be 45 b4          	movsx  eax,BYTE PTR [rbp-0x4c]
    1545:	83 e0 10             	and    eax,0x10
    1548:	85 c0                	test   eax,eax
    154a:	0f 84 90 00 00 00    	je     15e0 <putmin+0x214>
				if (flags & KFL_IS_HEX) {
    1550:	0f be 45 b4          	movsx  eax,BYTE PTR [rbp-0x4c]
    1554:	83 e0 01             	and    eax,0x1
    1557:	85 c0                	test   eax,eax
    1559:	74 4c                	je     15a7 <putmin+0x1db>
						ctx->putchar(ctx, '0');
    155b:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    155f:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1563:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1567:	be 30 00 00 00       	mov    esi,0x30
    156c:	48 89 c7             	mov    rdi,rax
    156f:	ff d2                	call   rdx
						if (flags & KFL_CAPITAL)
    1571:	80 7d b4 00          	cmp    BYTE PTR [rbp-0x4c],0x0
    1575:	79 18                	jns    158f <putmin+0x1c3>
								ctx->putchar(ctx, 'X');
    1577:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    157b:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    157f:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1583:	be 58 00 00 00       	mov    esi,0x58
    1588:	48 89 c7             	mov    rdi,rax
    158b:	ff d2                	call   rdx
    158d:	eb 51                	jmp    15e0 <putmin+0x214>
						else
								ctx->putchar(ctx, 'x');
    158f:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1593:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1597:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    159b:	be 78 00 00 00       	mov    esi,0x78
    15a0:	48 89 c7             	mov    rdi,rax
    15a3:	ff d2                	call   rdx
    15a5:	eb 39                	jmp    15e0 <putmin+0x214>
				} else if (flags & KFL_IS_OCT)
    15a7:	0f be 45 b4          	movsx  eax,BYTE PTR [rbp-0x4c]
    15ab:	83 e0 40             	and    eax,0x40
    15ae:	85 c0                	test   eax,eax
    15b0:	74 2e                	je     15e0 <putmin+0x214>
						ctx->putchar(ctx, '0');
    15b2:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    15b6:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    15ba:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    15be:	be 30 00 00 00       	mov    esi,0x30
    15c3:	48 89 c7             	mov    rdi,rax
    15c6:	ff d2                	call   rdx
		}
		/* and the zero prefix */
		while (nz--)
    15c8:	eb 16                	jmp    15e0 <putmin+0x214>
				ctx->putchar(ctx, '0');
    15ca:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    15ce:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    15d2:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    15d6:	be 30 00 00 00       	mov    esi,0x30
    15db:	48 89 c7             	mov    rdi,rax
    15de:	ff d2                	call   rdx
		while (nz--)
    15e0:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    15e3:	8d 50 ff             	lea    edx,[rax-0x1]
    15e6:	89 55 f8             	mov    DWORD PTR [rbp-0x8],edx
    15e9:	85 c0                	test   eax,eax
    15eb:	75 dd                	jne    15ca <putmin+0x1fe>
		/* print the number */
		if (ctx) for (size_t i = 0; i < strlen(str); i++)
    15ed:	48 83 7d b8 00       	cmp    QWORD PTR [rbp-0x48],0x0
    15f2:	74 5d                	je     1651 <putmin+0x285>
    15f4:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
    15fc:	eb 29                	jmp    1627 <putmin+0x25b>
				ctx->putchar(ctx, str[i]);
    15fe:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1602:	48 8b 48 10          	mov    rcx,QWORD PTR [rax+0x10]
    1606:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    160a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    160e:	48 01 d0             	add    rax,rdx
    1611:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1614:	0f be d0             	movsx  edx,al
    1617:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    161b:	89 d6                	mov    esi,edx
    161d:	48 89 c7             	mov    rdi,rax
    1620:	ff d1                	call   rcx
		if (ctx) for (size_t i = 0; i < strlen(str); i++)
    1622:	48 83 45 e8 01       	add    QWORD PTR [rbp-0x18],0x1
    1627:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    162b:	48 89 c7             	mov    rdi,rax
    162e:	e8 00 00 00 00       	call   1633 <putmin+0x267>
    1633:	48 39 45 e8          	cmp    QWORD PTR [rbp-0x18],rax
    1637:	72 c5                	jb     15fe <putmin+0x232>
		/* print spaces */
		while (ns-- > 0)
    1639:	eb 16                	jmp    1651 <putmin+0x285>
				ctx->putchar(ctx, ' ');
    163b:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    163f:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1643:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1647:	be 20 00 00 00       	mov    esi,0x20
    164c:	48 89 c7             	mov    rdi,rax
    164f:	ff d2                	call   rdx
		while (ns-- > 0)
    1651:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1654:	8d 50 ff             	lea    edx,[rax-0x1]
    1657:	89 55 f4             	mov    DWORD PTR [rbp-0xc],edx
    165a:	85 c0                	test   eax,eax
    165c:	7f dd                	jg     163b <putmin+0x26f>
		return rv;
    165e:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
    1661:	c9                   	leave
    1662:	c3                   	ret

0000000000001663 <putd>:

int putd(struct ivp_ctx* ctx, long long int arg, char flags, char width, char prec)
{
    1663:	55                   	push   rbp
    1664:	48 89 e5             	mov    rbp,rsp
    1667:	48 83 ec 20          	sub    rsp,0x20
    166b:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
    166f:	48 89 75 f0          	mov    QWORD PTR [rbp-0x10],rsi
    1673:	89 c8                	mov    eax,ecx
    1675:	44 89 c1             	mov    ecx,r8d
    1678:	88 55 ec             	mov    BYTE PTR [rbp-0x14],dl
    167b:	88 45 e8             	mov    BYTE PTR [rbp-0x18],al
    167e:	89 c8                	mov    eax,ecx
    1680:	88 45 e4             	mov    BYTE PTR [rbp-0x1c],al
		if (arg < 0) {
    1683:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
    1688:	79 5a                	jns    16e4 <putd+0x81>
				if (arg > LLONG_MIN)
    168a:	48 b8 00 00 00 00 00 00 00 80 	movabs rax,0x8000000000000000
    1694:	48 39 45 f0          	cmp    QWORD PTR [rbp-0x10],rax
    1698:	74 30                	je     16ca <putd+0x67>
						return putu(ctx, -arg, flags | KFL_IS_NEG, width, prec);
    169a:	0f be 75 e4          	movsx  esi,BYTE PTR [rbp-0x1c]
    169e:	0f be 4d e8          	movsx  ecx,BYTE PTR [rbp-0x18]
    16a2:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
    16a6:	83 c8 c0             	or     eax,0xffffffc0
    16a9:	0f be d0             	movsx  edx,al
    16ac:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    16b0:	48 f7 d8             	neg    rax
    16b3:	48 89 c7             	mov    rdi,rax
    16b6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    16ba:	41 89 f0             	mov    r8d,esi
    16bd:	48 89 fe             	mov    rsi,rdi
    16c0:	48 89 c7             	mov    rdi,rax
    16c3:	e8 00 00 00 00       	call   16c8 <putd+0x65>
    16c8:	eb 39                	jmp    1703 <putd+0xa0>
				else
						return putmin(ctx, flags, width, prec);
    16ca:	0f be 4d e4          	movsx  ecx,BYTE PTR [rbp-0x1c]
    16ce:	0f be 55 e8          	movsx  edx,BYTE PTR [rbp-0x18]
    16d2:	0f be 75 ec          	movsx  esi,BYTE PTR [rbp-0x14]
    16d6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    16da:	48 89 c7             	mov    rdi,rax
    16dd:	e8 00 00 00 00       	call   16e2 <putd+0x7f>
    16e2:	eb 1f                	jmp    1703 <putd+0xa0>
		} else
				return putu(ctx, (unsigned long long int)arg, flags, width, prec);
    16e4:	0f be 7d e4          	movsx  edi,BYTE PTR [rbp-0x1c]
    16e8:	0f be 4d e8          	movsx  ecx,BYTE PTR [rbp-0x18]
    16ec:	0f be 55 ec          	movsx  edx,BYTE PTR [rbp-0x14]
    16f0:	48 8b 75 f0          	mov    rsi,QWORD PTR [rbp-0x10]
    16f4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    16f8:	41 89 f8             	mov    r8d,edi
    16fb:	48 89 c7             	mov    rdi,rax
    16fe:	e8 00 00 00 00       	call   1703 <putd+0xa0>
}
    1703:	c9                   	leave
    1704:	c3                   	ret

0000000000001705 <cputs.0>:
															0, 2 * sizeof(void*) / sizeof(char));
									/*		cur_fmt = fm;
									}*/
									else if (*fmt == 's') {
											/* no wchar_t support */
											void cputs(const char* s) {
    1705:	55                   	push   rbp
    1706:	48 89 e5             	mov    rbp,rsp
    1709:	53                   	push   rbx
    170a:	48 83 ec 18          	sub    rsp,0x18
    170e:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    1712:	4c 89 d3             	mov    rbx,r10
    1715:	4c 89 55 e0          	mov    QWORD PTR [rbp-0x20],r10
													while (*s)
    1719:	eb 23                	jmp    173e <cputs.0+0x39>
															ctx->putchar(ctx, *s++);
    171b:	48 8b 03             	mov    rax,QWORD PTR [rbx]
    171e:	48 8b 48 10          	mov    rcx,QWORD PTR [rax+0x10]
    1722:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1726:	48 8d 50 01          	lea    rdx,[rax+0x1]
    172a:	48 89 55 e8          	mov    QWORD PTR [rbp-0x18],rdx
    172e:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1731:	0f be d0             	movsx  edx,al
    1734:	48 8b 03             	mov    rax,QWORD PTR [rbx]
    1737:	89 d6                	mov    esi,edx
    1739:	48 89 c7             	mov    rdi,rax
    173c:	ff d1                	call   rcx
													while (*s)
    173e:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1742:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1745:	84 c0                	test   al,al
    1747:	75 d2                	jne    171b <cputs.0+0x16>
											}
    1749:	90                   	nop
    174a:	90                   	nop
    174b:	48 8b 5d f8          	mov    rbx,QWORD PTR [rbp-0x8]
    174f:	c9                   	leave
    1750:	c3                   	ret

0000000000001751 <internal_vprintf>:
{
    1751:	55                   	push   rbp
    1752:	48 89 e5             	mov    rbp,rsp
    1755:	48 83 ec 60          	sub    rsp,0x60
    1759:	48 89 7d b8          	mov    QWORD PTR [rbp-0x48],rdi
    175d:	48 89 75 b0          	mov    QWORD PTR [rbp-0x50],rsi
    1761:	48 89 55 a8          	mov    QWORD PTR [rbp-0x58],rdx
int internal_vprintf(struct ivp_ctx* ctx, const char* fmt, va_list args)
    1765:	48 8d 45 10          	lea    rax,[rbp+0x10]
    1769:	48 89 45 c8          	mov    QWORD PTR [rbp-0x38],rax
    176d:	48 8b 45 b8          	mov    rax,QWORD PTR [rbp-0x48]
    1771:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
		char is_fmt = 0, flags = KFL_LEFT_ALIGN, width = 0, prec = 0, size = 0;
    1775:	c6 45 ff 00          	mov    BYTE PTR [rbp-0x1],0x0
    1779:	c6 45 fe 08          	mov    BYTE PTR [rbp-0x2],0x8
    177d:	c6 45 fd 00          	mov    BYTE PTR [rbp-0x3],0x0
    1781:	c6 45 fc 00          	mov    BYTE PTR [rbp-0x4],0x0
    1785:	c6 45 fb 00          	mov    BYTE PTR [rbp-0x5],0x0
		int rv = 0;
    1789:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [rbp-0xc],0x0
		while (*fmt) {
    1790:	e9 18 0f 00 00       	jmp    26ad <internal_vprintf+0xf5c>
			switch (*fmt) {
    1795:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1799:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    179c:	0f be c0             	movsx  eax,al
    179f:	83 f8 25             	cmp    eax,0x25
    17a2:	75 4e                	jne    17f2 <internal_vprintf+0xa1>
							is_fmt = !is_fmt;
    17a4:	80 7d ff 00          	cmp    BYTE PTR [rbp-0x1],0x0
    17a8:	0f 94 c0             	sete   al
    17ab:	88 45 ff             	mov    BYTE PTR [rbp-0x1],al
							if (!is_fmt) {
    17ae:	80 7d ff 00          	cmp    BYTE PTR [rbp-0x1],0x0
    17b2:	75 21                	jne    17d5 <internal_vprintf+0x84>
									ctx->putchar(ctx, *fmt);
    17b4:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    17b8:	48 8b 48 10          	mov    rcx,QWORD PTR [rax+0x10]
    17bc:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    17c0:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    17c3:	0f be d0             	movsx  edx,al
    17c6:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    17ca:	89 d6                	mov    esi,edx
    17cc:	48 89 c7             	mov    rdi,rax
    17cf:	ff d1                	call   rcx
									rv++;
    17d1:	83 45 f4 01          	add    DWORD PTR [rbp-0xc],0x1
							fmt++;
    17d5:	48 83 45 b0 01       	add    QWORD PTR [rbp-0x50],0x1
							width = prec = 0;
    17da:	c6 45 fc 00          	mov    BYTE PTR [rbp-0x4],0x0
    17de:	0f b6 45 fc          	movzx  eax,BYTE PTR [rbp-0x4]
    17e2:	88 45 fd             	mov    BYTE PTR [rbp-0x3],al
							flags = KFL_LEFT_ALIGN;
    17e5:	c6 45 fe 08          	mov    BYTE PTR [rbp-0x2],0x8
							size = 0;
    17e9:	c6 45 fb 00          	mov    BYTE PTR [rbp-0x5],0x0
							break;
    17ed:	e9 bb 0e 00 00       	jmp    26ad <internal_vprintf+0xf5c>
							if ((is_fmt == 1) && (*fmt == ' ' || *fmt == '0' || *fmt == '#' || *fmt == '+' || *fmt == '-')) {
    17f2:	80 7d ff 01          	cmp    BYTE PTR [rbp-0x1],0x1
    17f6:	0f 85 94 00 00 00    	jne    1890 <internal_vprintf+0x13f>
    17fc:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1800:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1803:	3c 20                	cmp    al,0x20
    1805:	74 2c                	je     1833 <internal_vprintf+0xe2>
    1807:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    180b:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    180e:	3c 30                	cmp    al,0x30
    1810:	74 21                	je     1833 <internal_vprintf+0xe2>
    1812:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1816:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1819:	3c 23                	cmp    al,0x23
    181b:	74 16                	je     1833 <internal_vprintf+0xe2>
    181d:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1821:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1824:	3c 2b                	cmp    al,0x2b
    1826:	74 0b                	je     1833 <internal_vprintf+0xe2>
    1828:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    182c:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    182f:	3c 2d                	cmp    al,0x2d
    1831:	75 5d                	jne    1890 <internal_vprintf+0x13f>
									if (*fmt == ' ')
    1833:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1837:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    183a:	3c 20                	cmp    al,0x20
    183c:	75 06                	jne    1844 <internal_vprintf+0xf3>
											flags |= KFL_SPACE_PLUS;
    183e:	80 4d fe 20          	or     BYTE PTR [rbp-0x2],0x20
    1842:	eb 42                	jmp    1886 <internal_vprintf+0x135>
									else if (*fmt == '0')
    1844:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1848:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    184b:	3c 30                	cmp    al,0x30
    184d:	75 06                	jne    1855 <internal_vprintf+0x104>
											flags |= KFL_ZERO_PREFIX;
    184f:	80 4d fe 02          	or     BYTE PTR [rbp-0x2],0x2
    1853:	eb 31                	jmp    1886 <internal_vprintf+0x135>
									else if (*fmt == '+')
    1855:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1859:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    185c:	3c 2b                	cmp    al,0x2b
    185e:	75 06                	jne    1866 <internal_vprintf+0x115>
											flags |= KFL_ALWAYS_SIGN;
    1860:	80 4d fe 04          	or     BYTE PTR [rbp-0x2],0x4
    1864:	eb 20                	jmp    1886 <internal_vprintf+0x135>
									else if (*fmt == '-')
    1866:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    186a:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    186d:	3c 2d                	cmp    al,0x2d
    186f:	75 06                	jne    1877 <internal_vprintf+0x126>
											flags &= ~KFL_LEFT_ALIGN;
    1871:	80 65 fe f7          	and    BYTE PTR [rbp-0x2],0xf7
    1875:	eb 0f                	jmp    1886 <internal_vprintf+0x135>
									else if (*fmt == '#')
    1877:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    187b:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    187e:	3c 23                	cmp    al,0x23
    1880:	75 04                	jne    1886 <internal_vprintf+0x135>
											flags |= KFL_TYPE_PREFIX;
    1882:	80 4d fe 10          	or     BYTE PTR [rbp-0x2],0x10
									fmt++;
    1886:	48 83 45 b0 01       	add    QWORD PTR [rbp-0x50],0x1
    188b:	e9 1d 0e 00 00       	jmp    26ad <internal_vprintf+0xf5c>
							} else if (is_fmt && *fmt >= '0' && *fmt <= '9') {
    1890:	80 7d ff 00          	cmp    BYTE PTR [rbp-0x1],0x0
    1894:	74 7c                	je     1912 <internal_vprintf+0x1c1>
    1896:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    189a:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    189d:	3c 2f                	cmp    al,0x2f
    189f:	7e 71                	jle    1912 <internal_vprintf+0x1c1>
    18a1:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    18a5:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    18a8:	3c 39                	cmp    al,0x39
    18aa:	7f 66                	jg     1912 <internal_vprintf+0x1c1>
									if (is_fmt == 1)
    18ac:	80 7d ff 01          	cmp    BYTE PTR [rbp-0x1],0x1
    18b0:	75 04                	jne    18b6 <internal_vprintf+0x165>
											is_fmt = 3;
    18b2:	c6 45 ff 03          	mov    BYTE PTR [rbp-0x1],0x3
									if (is_fmt == 2) {
    18b6:	80 7d ff 02          	cmp    BYTE PTR [rbp-0x1],0x2
    18ba:	75 27                	jne    18e3 <internal_vprintf+0x192>
											prec *= 10;
    18bc:	0f b6 55 fc          	movzx  edx,BYTE PTR [rbp-0x4]
    18c0:	89 d0                	mov    eax,edx
    18c2:	c1 e0 02             	shl    eax,0x2
    18c5:	01 d0                	add    eax,edx
    18c7:	01 c0                	add    eax,eax
    18c9:	88 45 fc             	mov    BYTE PTR [rbp-0x4],al
											prec += (*fmt - '0');
    18cc:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    18d0:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    18d3:	89 c2                	mov    edx,eax
    18d5:	0f b6 45 fc          	movzx  eax,BYTE PTR [rbp-0x4]
    18d9:	01 d0                	add    eax,edx
    18db:	83 e8 30             	sub    eax,0x30
    18de:	88 45 fc             	mov    BYTE PTR [rbp-0x4],al
    18e1:	eb 25                	jmp    1908 <internal_vprintf+0x1b7>
											width *= 10;
    18e3:	0f b6 55 fd          	movzx  edx,BYTE PTR [rbp-0x3]
    18e7:	89 d0                	mov    eax,edx
    18e9:	c1 e0 02             	shl    eax,0x2
    18ec:	01 d0                	add    eax,edx
    18ee:	01 c0                	add    eax,eax
    18f0:	88 45 fd             	mov    BYTE PTR [rbp-0x3],al
											width += (*fmt - '0');
    18f3:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    18f7:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    18fa:	89 c2                	mov    edx,eax
    18fc:	0f b6 45 fd          	movzx  eax,BYTE PTR [rbp-0x3]
    1900:	01 d0                	add    eax,edx
    1902:	83 e8 30             	sub    eax,0x30
    1905:	88 45 fd             	mov    BYTE PTR [rbp-0x3],al
									fmt++;
    1908:	48 83 45 b0 01       	add    QWORD PTR [rbp-0x50],0x1
    190d:	e9 9b 0d 00 00       	jmp    26ad <internal_vprintf+0xf5c>
							} else if (is_fmt && *fmt == '.') {
    1912:	80 7d ff 00          	cmp    BYTE PTR [rbp-0x1],0x0
    1916:	74 19                	je     1931 <internal_vprintf+0x1e0>
    1918:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    191c:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    191f:	3c 2e                	cmp    al,0x2e
    1921:	75 0e                	jne    1931 <internal_vprintf+0x1e0>
									is_fmt = 2;
    1923:	c6 45 ff 02          	mov    BYTE PTR [rbp-0x1],0x2
									fmt++;
    1927:	48 83 45 b0 01       	add    QWORD PTR [rbp-0x50],0x1
    192c:	e9 7c 0d 00 00       	jmp    26ad <internal_vprintf+0xf5c>
							} else if (is_fmt && *fmt == '*') {
    1931:	80 7d ff 00          	cmp    BYTE PTR [rbp-0x1],0x0
    1935:	0f 84 b1 00 00 00    	je     19ec <internal_vprintf+0x29b>
    193b:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    193f:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1942:	3c 2a                	cmp    al,0x2a
    1944:	0f 85 a2 00 00 00    	jne    19ec <internal_vprintf+0x29b>
									if (is_fmt == 2)
    194a:	80 7d ff 02          	cmp    BYTE PTR [rbp-0x1],0x2
    194e:	75 4a                	jne    199a <internal_vprintf+0x249>
											prec = va_arg(args, int);
    1950:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1954:	8b 00                	mov    eax,DWORD PTR [rax]
    1956:	83 f8 2f             	cmp    eax,0x2f
    1959:	77 24                	ja     197f <internal_vprintf+0x22e>
    195b:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    195f:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1963:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1967:	8b 00                	mov    eax,DWORD PTR [rax]
    1969:	89 c0                	mov    eax,eax
    196b:	48 01 d0             	add    rax,rdx
    196e:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1972:	8b 12                	mov    edx,DWORD PTR [rdx]
    1974:	8d 4a 08             	lea    ecx,[rdx+0x8]
    1977:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    197b:	89 0a                	mov    DWORD PTR [rdx],ecx
    197d:	eb 14                	jmp    1993 <internal_vprintf+0x242>
    197f:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1983:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1987:	48 8d 48 08          	lea    rcx,[rax+0x8]
    198b:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    198f:	48 89 4a 08          	mov    QWORD PTR [rdx+0x8],rcx
    1993:	8b 00                	mov    eax,DWORD PTR [rax]
    1995:	88 45 fc             	mov    BYTE PTR [rbp-0x4],al
    1998:	eb 48                	jmp    19e2 <internal_vprintf+0x291>
											width = va_arg(args, int);
    199a:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    199e:	8b 00                	mov    eax,DWORD PTR [rax]
    19a0:	83 f8 2f             	cmp    eax,0x2f
    19a3:	77 24                	ja     19c9 <internal_vprintf+0x278>
    19a5:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    19a9:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    19ad:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    19b1:	8b 00                	mov    eax,DWORD PTR [rax]
    19b3:	89 c0                	mov    eax,eax
    19b5:	48 01 d0             	add    rax,rdx
    19b8:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    19bc:	8b 12                	mov    edx,DWORD PTR [rdx]
    19be:	8d 4a 08             	lea    ecx,[rdx+0x8]
    19c1:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    19c5:	89 0a                	mov    DWORD PTR [rdx],ecx
    19c7:	eb 14                	jmp    19dd <internal_vprintf+0x28c>
    19c9:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    19cd:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    19d1:	48 8d 48 08          	lea    rcx,[rax+0x8]
    19d5:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    19d9:	48 89 4a 08          	mov    QWORD PTR [rdx+0x8],rcx
    19dd:	8b 00                	mov    eax,DWORD PTR [rax]
    19df:	88 45 fd             	mov    BYTE PTR [rbp-0x3],al
									fmt++;
    19e2:	48 83 45 b0 01       	add    QWORD PTR [rbp-0x50],0x1
    19e7:	e9 c1 0c 00 00       	jmp    26ad <internal_vprintf+0xf5c>
							} else if (is_fmt) {
    19ec:	80 7d ff 00          	cmp    BYTE PTR [rbp-0x1],0x0
    19f0:	0f 84 8e 0c 00 00    	je     2684 <internal_vprintf+0xf33>
									if (is_fmt == 2 && !prec)
    19f6:	80 7d ff 02          	cmp    BYTE PTR [rbp-0x1],0x2
    19fa:	75 0a                	jne    1a06 <internal_vprintf+0x2b5>
    19fc:	80 7d fc 00          	cmp    BYTE PTR [rbp-0x4],0x0
    1a00:	75 04                	jne    1a06 <internal_vprintf+0x2b5>
											prec = -1; /* no zero */
    1a02:	c6 45 fc ff          	mov    BYTE PTR [rbp-0x4],0xff
									if (*fmt == 'h') {
    1a06:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1a0a:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1a0d:	3c 68                	cmp    al,0x68
    1a0f:	75 27                	jne    1a38 <internal_vprintf+0x2e7>
											fmt++;
    1a11:	48 83 45 b0 01       	add    QWORD PTR [rbp-0x50],0x1
											if (*fmt == 'h') {
    1a16:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1a1a:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1a1d:	3c 68                	cmp    al,0x68
    1a1f:	75 0e                	jne    1a2f <internal_vprintf+0x2de>
													size = 1; /* hh */
    1a21:	c6 45 fb 01          	mov    BYTE PTR [rbp-0x5],0x1
													fmt++;
    1a25:	48 83 45 b0 01       	add    QWORD PTR [rbp-0x50],0x1
    1a2a:	e9 8b 00 00 00       	jmp    1aba <internal_vprintf+0x369>
													size = 2; /* h */
    1a2f:	c6 45 fb 02          	mov    BYTE PTR [rbp-0x5],0x2
    1a33:	e9 82 00 00 00       	jmp    1aba <internal_vprintf+0x369>
									} else if (*fmt == 'l') {
    1a38:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1a3c:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1a3f:	3c 6c                	cmp    al,0x6c
    1a41:	75 21                	jne    1a64 <internal_vprintf+0x313>
											fmt++;
    1a43:	48 83 45 b0 01       	add    QWORD PTR [rbp-0x50],0x1
											if (*fmt == 'l') {
    1a48:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1a4c:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1a4f:	3c 6c                	cmp    al,0x6c
    1a51:	75 0b                	jne    1a5e <internal_vprintf+0x30d>
													size = 4; /* ll */
    1a53:	c6 45 fb 04          	mov    BYTE PTR [rbp-0x5],0x4
													fmt++;
    1a57:	48 83 45 b0 01       	add    QWORD PTR [rbp-0x50],0x1
    1a5c:	eb 5c                	jmp    1aba <internal_vprintf+0x369>
													size = 3;
    1a5e:	c6 45 fb 03          	mov    BYTE PTR [rbp-0x5],0x3
    1a62:	eb 56                	jmp    1aba <internal_vprintf+0x369>
									} else if (*fmt == 'j') {
    1a64:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1a68:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1a6b:	3c 6a                	cmp    al,0x6a
    1a6d:	75 0b                	jne    1a7a <internal_vprintf+0x329>
											fmt++;
    1a6f:	48 83 45 b0 01       	add    QWORD PTR [rbp-0x50],0x1
											size = 5;
    1a74:	c6 45 fb 05          	mov    BYTE PTR [rbp-0x5],0x5
    1a78:	eb 40                	jmp    1aba <internal_vprintf+0x369>
									} else if (*fmt == 'z') {
    1a7a:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1a7e:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1a81:	3c 7a                	cmp    al,0x7a
    1a83:	75 0b                	jne    1a90 <internal_vprintf+0x33f>
											size = 6;
    1a85:	c6 45 fb 06          	mov    BYTE PTR [rbp-0x5],0x6
											fmt++;
    1a89:	48 83 45 b0 01       	add    QWORD PTR [rbp-0x50],0x1
    1a8e:	eb 2a                	jmp    1aba <internal_vprintf+0x369>
									} else if (*fmt == 't') {
    1a90:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1a94:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1a97:	3c 74                	cmp    al,0x74
    1a99:	75 0b                	jne    1aa6 <internal_vprintf+0x355>
											size = 7;
    1a9b:	c6 45 fb 07          	mov    BYTE PTR [rbp-0x5],0x7
											fmt++;
    1a9f:	48 83 45 b0 01       	add    QWORD PTR [rbp-0x50],0x1
    1aa4:	eb 14                	jmp    1aba <internal_vprintf+0x369>
									} else if (*fmt == 'L') {
    1aa6:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1aaa:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1aad:	3c 4c                	cmp    al,0x4c
    1aaf:	75 09                	jne    1aba <internal_vprintf+0x369>
											size = 8;
    1ab1:	c6 45 fb 08          	mov    BYTE PTR [rbp-0x5],0x8
											fmt++;
    1ab5:	48 83 45 b0 01       	add    QWORD PTR [rbp-0x50],0x1
									if (*fmt == 'd' || *fmt == 'i') {
    1aba:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1abe:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1ac1:	3c 64                	cmp    al,0x64
    1ac3:	74 0f                	je     1ad4 <internal_vprintf+0x383>
    1ac5:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1ac9:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1acc:	3c 69                	cmp    al,0x69
    1ace:	0f 85 55 02 00 00    	jne    1d29 <internal_vprintf+0x5d8>
											signed long long int val = 0;
    1ad4:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
											if (!size) val = va_arg(args, signed int);
    1adc:	80 7d fb 00          	cmp    BYTE PTR [rbp-0x5],0x0
    1ae0:	75 50                	jne    1b32 <internal_vprintf+0x3e1>
    1ae2:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1ae6:	8b 00                	mov    eax,DWORD PTR [rax]
    1ae8:	83 f8 2f             	cmp    eax,0x2f
    1aeb:	77 24                	ja     1b11 <internal_vprintf+0x3c0>
    1aed:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1af1:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1af5:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1af9:	8b 00                	mov    eax,DWORD PTR [rax]
    1afb:	89 c0                	mov    eax,eax
    1afd:	48 01 d0             	add    rax,rdx
    1b00:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1b04:	8b 12                	mov    edx,DWORD PTR [rdx]
    1b06:	8d 4a 08             	lea    ecx,[rdx+0x8]
    1b09:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1b0d:	89 0a                	mov    DWORD PTR [rdx],ecx
    1b0f:	eb 14                	jmp    1b25 <internal_vprintf+0x3d4>
    1b11:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1b15:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1b19:	48 8d 48 08          	lea    rcx,[rax+0x8]
    1b1d:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1b21:	48 89 4a 08          	mov    QWORD PTR [rdx+0x8],rcx
    1b25:	8b 00                	mov    eax,DWORD PTR [rax]
    1b27:	48 98                	cdqe
    1b29:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1b2d:	e9 d0 01 00 00       	jmp    1d02 <internal_vprintf+0x5b1>
											else if (size == 1) val = va_arg(args, signed char);
    1b32:	80 7d fb 01          	cmp    BYTE PTR [rbp-0x5],0x1
    1b36:	75 02                	jne    1b3a <internal_vprintf+0x3e9>
    1b38:	0f 0b                	ud2
											else if (size == 2) val = va_arg(args, signed short int);
    1b3a:	80 7d fb 02          	cmp    BYTE PTR [rbp-0x5],0x2
    1b3e:	75 02                	jne    1b42 <internal_vprintf+0x3f1>
    1b40:	0f 0b                	ud2
											else if (size == 3) val = va_arg(args, signed long int);
    1b42:	80 7d fb 03          	cmp    BYTE PTR [rbp-0x5],0x3
    1b46:	75 4f                	jne    1b97 <internal_vprintf+0x446>
    1b48:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1b4c:	8b 00                	mov    eax,DWORD PTR [rax]
    1b4e:	83 f8 2f             	cmp    eax,0x2f
    1b51:	77 24                	ja     1b77 <internal_vprintf+0x426>
    1b53:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1b57:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1b5b:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1b5f:	8b 00                	mov    eax,DWORD PTR [rax]
    1b61:	89 c0                	mov    eax,eax
    1b63:	48 01 d0             	add    rax,rdx
    1b66:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1b6a:	8b 12                	mov    edx,DWORD PTR [rdx]
    1b6c:	8d 4a 08             	lea    ecx,[rdx+0x8]
    1b6f:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1b73:	89 0a                	mov    DWORD PTR [rdx],ecx
    1b75:	eb 14                	jmp    1b8b <internal_vprintf+0x43a>
    1b77:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1b7b:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1b7f:	48 8d 48 08          	lea    rcx,[rax+0x8]
    1b83:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1b87:	48 89 4a 08          	mov    QWORD PTR [rdx+0x8],rcx
    1b8b:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1b8e:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1b92:	e9 6b 01 00 00       	jmp    1d02 <internal_vprintf+0x5b1>
											else if (size == 4) val = va_arg(args, signed long long int);
    1b97:	80 7d fb 04          	cmp    BYTE PTR [rbp-0x5],0x4
    1b9b:	75 4f                	jne    1bec <internal_vprintf+0x49b>
    1b9d:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1ba1:	8b 00                	mov    eax,DWORD PTR [rax]
    1ba3:	83 f8 2f             	cmp    eax,0x2f
    1ba6:	77 24                	ja     1bcc <internal_vprintf+0x47b>
    1ba8:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1bac:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1bb0:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1bb4:	8b 00                	mov    eax,DWORD PTR [rax]
    1bb6:	89 c0                	mov    eax,eax
    1bb8:	48 01 d0             	add    rax,rdx
    1bbb:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1bbf:	8b 12                	mov    edx,DWORD PTR [rdx]
    1bc1:	8d 4a 08             	lea    ecx,[rdx+0x8]
    1bc4:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1bc8:	89 0a                	mov    DWORD PTR [rdx],ecx
    1bca:	eb 14                	jmp    1be0 <internal_vprintf+0x48f>
    1bcc:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1bd0:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1bd4:	48 8d 48 08          	lea    rcx,[rax+0x8]
    1bd8:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1bdc:	48 89 4a 08          	mov    QWORD PTR [rdx+0x8],rcx
    1be0:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1be3:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1be7:	e9 16 01 00 00       	jmp    1d02 <internal_vprintf+0x5b1>
											else if (size == 5) val = va_arg(args, intmax_t);
    1bec:	80 7d fb 05          	cmp    BYTE PTR [rbp-0x5],0x5
    1bf0:	75 4f                	jne    1c41 <internal_vprintf+0x4f0>
    1bf2:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1bf6:	8b 00                	mov    eax,DWORD PTR [rax]
    1bf8:	83 f8 2f             	cmp    eax,0x2f
    1bfb:	77 24                	ja     1c21 <internal_vprintf+0x4d0>
    1bfd:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1c01:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1c05:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1c09:	8b 00                	mov    eax,DWORD PTR [rax]
    1c0b:	89 c0                	mov    eax,eax
    1c0d:	48 01 d0             	add    rax,rdx
    1c10:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1c14:	8b 12                	mov    edx,DWORD PTR [rdx]
    1c16:	8d 4a 08             	lea    ecx,[rdx+0x8]
    1c19:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1c1d:	89 0a                	mov    DWORD PTR [rdx],ecx
    1c1f:	eb 14                	jmp    1c35 <internal_vprintf+0x4e4>
    1c21:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1c25:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1c29:	48 8d 48 08          	lea    rcx,[rax+0x8]
    1c2d:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1c31:	48 89 4a 08          	mov    QWORD PTR [rdx+0x8],rcx
    1c35:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1c38:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1c3c:	e9 c1 00 00 00       	jmp    1d02 <internal_vprintf+0x5b1>
											else if (size == 6) val = va_arg(args, ssize_t);
    1c41:	80 7d fb 06          	cmp    BYTE PTR [rbp-0x5],0x6
    1c45:	75 4d                	jne    1c94 <internal_vprintf+0x543>
    1c47:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1c4b:	8b 00                	mov    eax,DWORD PTR [rax]
    1c4d:	83 f8 2f             	cmp    eax,0x2f
    1c50:	77 24                	ja     1c76 <internal_vprintf+0x525>
    1c52:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1c56:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1c5a:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1c5e:	8b 00                	mov    eax,DWORD PTR [rax]
    1c60:	89 c0                	mov    eax,eax
    1c62:	48 01 d0             	add    rax,rdx
    1c65:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1c69:	8b 12                	mov    edx,DWORD PTR [rdx]
    1c6b:	8d 4a 08             	lea    ecx,[rdx+0x8]
    1c6e:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1c72:	89 0a                	mov    DWORD PTR [rdx],ecx
    1c74:	eb 14                	jmp    1c8a <internal_vprintf+0x539>
    1c76:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1c7a:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1c7e:	48 8d 48 08          	lea    rcx,[rax+0x8]
    1c82:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1c86:	48 89 4a 08          	mov    QWORD PTR [rdx+0x8],rcx
    1c8a:	8b 00                	mov    eax,DWORD PTR [rax]
    1c8c:	48 98                	cdqe
    1c8e:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1c92:	eb 6e                	jmp    1d02 <internal_vprintf+0x5b1>
											else if (size == 7) val = va_arg(args, ptrdiff_t);
    1c94:	80 7d fb 07          	cmp    BYTE PTR [rbp-0x5],0x7
    1c98:	75 4c                	jne    1ce6 <internal_vprintf+0x595>
    1c9a:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1c9e:	8b 00                	mov    eax,DWORD PTR [rax]
    1ca0:	83 f8 2f             	cmp    eax,0x2f
    1ca3:	77 24                	ja     1cc9 <internal_vprintf+0x578>
    1ca5:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1ca9:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1cad:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1cb1:	8b 00                	mov    eax,DWORD PTR [rax]
    1cb3:	89 c0                	mov    eax,eax
    1cb5:	48 01 d0             	add    rax,rdx
    1cb8:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1cbc:	8b 12                	mov    edx,DWORD PTR [rdx]
    1cbe:	8d 4a 08             	lea    ecx,[rdx+0x8]
    1cc1:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1cc5:	89 0a                	mov    DWORD PTR [rdx],ecx
    1cc7:	eb 14                	jmp    1cdd <internal_vprintf+0x58c>
    1cc9:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1ccd:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1cd1:	48 8d 48 08          	lea    rcx,[rax+0x8]
    1cd5:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1cd9:	48 89 4a 08          	mov    QWORD PTR [rdx+0x8],rcx
    1cdd:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1ce0:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1ce4:	eb 1c                	jmp    1d02 <internal_vprintf+0x5b1>
											else (void)va_arg(args, long double); /* remove bogus value*/
    1ce6:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1cea:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1cee:	48 83 c0 0f          	add    rax,0xf
    1cf2:	48 83 e0 f0          	and    rax,0xfffffffffffffff0
    1cf6:	48 8d 50 10          	lea    rdx,[rax+0x10]
    1cfa:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1cfe:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
											rv += putd(ctx, val, flags, width, prec);
    1d02:	0f be 7d fc          	movsx  edi,BYTE PTR [rbp-0x4]
    1d06:	0f be 4d fd          	movsx  ecx,BYTE PTR [rbp-0x3]
    1d0a:	0f be 55 fe          	movsx  edx,BYTE PTR [rbp-0x2]
    1d0e:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1d12:	48 8b 75 e8          	mov    rsi,QWORD PTR [rbp-0x18]
    1d16:	41 89 f8             	mov    r8d,edi
    1d19:	48 89 c7             	mov    rdi,rax
    1d1c:	e8 00 00 00 00       	call   1d21 <internal_vprintf+0x5d0>
    1d21:	01 45 f4             	add    DWORD PTR [rbp-0xc],eax
									if (*fmt == 'd' || *fmt == 'i') {
    1d24:	e9 40 09 00 00       	jmp    2669 <internal_vprintf+0xf18>
									} else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'u' || *fmt == 'o' || *fmt == 'b') {
    1d29:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1d2d:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1d30:	3c 78                	cmp    al,0x78
    1d32:	74 30                	je     1d64 <internal_vprintf+0x613>
    1d34:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1d38:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1d3b:	3c 58                	cmp    al,0x58
    1d3d:	74 25                	je     1d64 <internal_vprintf+0x613>
    1d3f:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1d43:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1d46:	3c 75                	cmp    al,0x75
    1d48:	74 1a                	je     1d64 <internal_vprintf+0x613>
    1d4a:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1d4e:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1d51:	3c 6f                	cmp    al,0x6f
    1d53:	74 0f                	je     1d64 <internal_vprintf+0x613>
    1d55:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1d59:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1d5c:	3c 62                	cmp    al,0x62
    1d5e:	0f 85 41 03 00 00    	jne    20a5 <internal_vprintf+0x954>
											unsigned long long int val = 0;
    1d64:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
											if (!size) val = va_arg(args, unsigned int);
    1d6c:	80 7d fb 00          	cmp    BYTE PTR [rbp-0x5],0x0
    1d70:	75 50                	jne    1dc2 <internal_vprintf+0x671>
    1d72:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1d76:	8b 00                	mov    eax,DWORD PTR [rax]
    1d78:	83 f8 2f             	cmp    eax,0x2f
    1d7b:	77 24                	ja     1da1 <internal_vprintf+0x650>
    1d7d:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1d81:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1d85:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1d89:	8b 00                	mov    eax,DWORD PTR [rax]
    1d8b:	89 c0                	mov    eax,eax
    1d8d:	48 01 d0             	add    rax,rdx
    1d90:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1d94:	8b 12                	mov    edx,DWORD PTR [rdx]
    1d96:	8d 4a 08             	lea    ecx,[rdx+0x8]
    1d99:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1d9d:	89 0a                	mov    DWORD PTR [rdx],ecx
    1d9f:	eb 14                	jmp    1db5 <internal_vprintf+0x664>
    1da1:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1da5:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1da9:	48 8d 48 08          	lea    rcx,[rax+0x8]
    1dad:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1db1:	48 89 4a 08          	mov    QWORD PTR [rdx+0x8],rcx
    1db5:	8b 00                	mov    eax,DWORD PTR [rax]
    1db7:	89 c0                	mov    eax,eax
    1db9:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    1dbd:	e9 cf 01 00 00       	jmp    1f91 <internal_vprintf+0x840>
											else if (size == 1) val = va_arg(args, unsigned char);
    1dc2:	80 7d fb 01          	cmp    BYTE PTR [rbp-0x5],0x1
    1dc6:	75 02                	jne    1dca <internal_vprintf+0x679>
    1dc8:	0f 0b                	ud2
											else if (size == 2) val = va_arg(args, unsigned short int);
    1dca:	80 7d fb 02          	cmp    BYTE PTR [rbp-0x5],0x2
    1dce:	75 02                	jne    1dd2 <internal_vprintf+0x681>
    1dd0:	0f 0b                	ud2
											else if (size == 3) val = va_arg(args, unsigned long int);
    1dd2:	80 7d fb 03          	cmp    BYTE PTR [rbp-0x5],0x3
    1dd6:	75 4f                	jne    1e27 <internal_vprintf+0x6d6>
    1dd8:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1ddc:	8b 00                	mov    eax,DWORD PTR [rax]
    1dde:	83 f8 2f             	cmp    eax,0x2f
    1de1:	77 24                	ja     1e07 <internal_vprintf+0x6b6>
    1de3:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1de7:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1deb:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1def:	8b 00                	mov    eax,DWORD PTR [rax]
    1df1:	89 c0                	mov    eax,eax
    1df3:	48 01 d0             	add    rax,rdx
    1df6:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1dfa:	8b 12                	mov    edx,DWORD PTR [rdx]
    1dfc:	8d 4a 08             	lea    ecx,[rdx+0x8]
    1dff:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1e03:	89 0a                	mov    DWORD PTR [rdx],ecx
    1e05:	eb 14                	jmp    1e1b <internal_vprintf+0x6ca>
    1e07:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1e0b:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1e0f:	48 8d 48 08          	lea    rcx,[rax+0x8]
    1e13:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1e17:	48 89 4a 08          	mov    QWORD PTR [rdx+0x8],rcx
    1e1b:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1e1e:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    1e22:	e9 6a 01 00 00       	jmp    1f91 <internal_vprintf+0x840>
											else if (size == 4) val = va_arg(args, unsigned long long int);
    1e27:	80 7d fb 04          	cmp    BYTE PTR [rbp-0x5],0x4
    1e2b:	75 4f                	jne    1e7c <internal_vprintf+0x72b>
    1e2d:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1e31:	8b 00                	mov    eax,DWORD PTR [rax]
    1e33:	83 f8 2f             	cmp    eax,0x2f
    1e36:	77 24                	ja     1e5c <internal_vprintf+0x70b>
    1e38:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1e3c:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1e40:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1e44:	8b 00                	mov    eax,DWORD PTR [rax]
    1e46:	89 c0                	mov    eax,eax
    1e48:	48 01 d0             	add    rax,rdx
    1e4b:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1e4f:	8b 12                	mov    edx,DWORD PTR [rdx]
    1e51:	8d 4a 08             	lea    ecx,[rdx+0x8]
    1e54:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1e58:	89 0a                	mov    DWORD PTR [rdx],ecx
    1e5a:	eb 14                	jmp    1e70 <internal_vprintf+0x71f>
    1e5c:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1e60:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1e64:	48 8d 48 08          	lea    rcx,[rax+0x8]
    1e68:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1e6c:	48 89 4a 08          	mov    QWORD PTR [rdx+0x8],rcx
    1e70:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1e73:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    1e77:	e9 15 01 00 00       	jmp    1f91 <internal_vprintf+0x840>
											else if (size == 5) val = va_arg(args, uintmax_t);
    1e7c:	80 7d fb 05          	cmp    BYTE PTR [rbp-0x5],0x5
    1e80:	75 4f                	jne    1ed1 <internal_vprintf+0x780>
    1e82:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1e86:	8b 00                	mov    eax,DWORD PTR [rax]
    1e88:	83 f8 2f             	cmp    eax,0x2f
    1e8b:	77 24                	ja     1eb1 <internal_vprintf+0x760>
    1e8d:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1e91:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1e95:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1e99:	8b 00                	mov    eax,DWORD PTR [rax]
    1e9b:	89 c0                	mov    eax,eax
    1e9d:	48 01 d0             	add    rax,rdx
    1ea0:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1ea4:	8b 12                	mov    edx,DWORD PTR [rdx]
    1ea6:	8d 4a 08             	lea    ecx,[rdx+0x8]
    1ea9:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1ead:	89 0a                	mov    DWORD PTR [rdx],ecx
    1eaf:	eb 14                	jmp    1ec5 <internal_vprintf+0x774>
    1eb1:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1eb5:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1eb9:	48 8d 48 08          	lea    rcx,[rax+0x8]
    1ebd:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1ec1:	48 89 4a 08          	mov    QWORD PTR [rdx+0x8],rcx
    1ec5:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1ec8:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    1ecc:	e9 c0 00 00 00       	jmp    1f91 <internal_vprintf+0x840>
											else if (size == 6) val = va_arg(args, size_t);
    1ed1:	80 7d fb 06          	cmp    BYTE PTR [rbp-0x5],0x6
    1ed5:	75 4c                	jne    1f23 <internal_vprintf+0x7d2>
    1ed7:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1edb:	8b 00                	mov    eax,DWORD PTR [rax]
    1edd:	83 f8 2f             	cmp    eax,0x2f
    1ee0:	77 24                	ja     1f06 <internal_vprintf+0x7b5>
    1ee2:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1ee6:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1eea:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1eee:	8b 00                	mov    eax,DWORD PTR [rax]
    1ef0:	89 c0                	mov    eax,eax
    1ef2:	48 01 d0             	add    rax,rdx
    1ef5:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1ef9:	8b 12                	mov    edx,DWORD PTR [rdx]
    1efb:	8d 4a 08             	lea    ecx,[rdx+0x8]
    1efe:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1f02:	89 0a                	mov    DWORD PTR [rdx],ecx
    1f04:	eb 14                	jmp    1f1a <internal_vprintf+0x7c9>
    1f06:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1f0a:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1f0e:	48 8d 48 08          	lea    rcx,[rax+0x8]
    1f12:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1f16:	48 89 4a 08          	mov    QWORD PTR [rdx+0x8],rcx
    1f1a:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1f1d:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    1f21:	eb 6e                	jmp    1f91 <internal_vprintf+0x840>
											else if (size == 7) val = va_arg(args, ptrdiff_t);
    1f23:	80 7d fb 07          	cmp    BYTE PTR [rbp-0x5],0x7
    1f27:	75 4c                	jne    1f75 <internal_vprintf+0x824>
    1f29:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1f2d:	8b 00                	mov    eax,DWORD PTR [rax]
    1f2f:	83 f8 2f             	cmp    eax,0x2f
    1f32:	77 24                	ja     1f58 <internal_vprintf+0x807>
    1f34:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1f38:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1f3c:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1f40:	8b 00                	mov    eax,DWORD PTR [rax]
    1f42:	89 c0                	mov    eax,eax
    1f44:	48 01 d0             	add    rax,rdx
    1f47:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1f4b:	8b 12                	mov    edx,DWORD PTR [rdx]
    1f4d:	8d 4a 08             	lea    ecx,[rdx+0x8]
    1f50:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1f54:	89 0a                	mov    DWORD PTR [rdx],ecx
    1f56:	eb 14                	jmp    1f6c <internal_vprintf+0x81b>
    1f58:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1f5c:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1f60:	48 8d 48 08          	lea    rcx,[rax+0x8]
    1f64:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    1f68:	48 89 4a 08          	mov    QWORD PTR [rdx+0x8],rcx
    1f6c:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1f6f:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    1f73:	eb 1c                	jmp    1f91 <internal_vprintf+0x840>
											else (void)va_arg(args, long double); /* remove bogus value*/
    1f75:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1f79:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    1f7d:	48 83 c0 0f          	add    rax,0xf
    1f81:	48 83 e0 f0          	and    rax,0xfffffffffffffff0
    1f85:	48 8d 50 10          	lea    rdx,[rax+0x10]
    1f89:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1f8d:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
											if (*fmt == 'x')
    1f91:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1f95:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1f98:	3c 78                	cmp    al,0x78
    1f9a:	75 2d                	jne    1fc9 <internal_vprintf+0x878>
													rv += putu(ctx, val, flags | KFL_IS_HEX, width, prec);
    1f9c:	0f be 7d fc          	movsx  edi,BYTE PTR [rbp-0x4]
    1fa0:	0f be 4d fd          	movsx  ecx,BYTE PTR [rbp-0x3]
    1fa4:	0f b6 45 fe          	movzx  eax,BYTE PTR [rbp-0x2]
    1fa8:	83 c8 01             	or     eax,0x1
    1fab:	0f be d0             	movsx  edx,al
    1fae:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1fb2:	48 8b 75 e0          	mov    rsi,QWORD PTR [rbp-0x20]
    1fb6:	41 89 f8             	mov    r8d,edi
    1fb9:	48 89 c7             	mov    rdi,rax
    1fbc:	e8 00 00 00 00       	call   1fc1 <internal_vprintf+0x870>
    1fc1:	01 45 f4             	add    DWORD PTR [rbp-0xc],eax
									} else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'u' || *fmt == 'o' || *fmt == 'b') {
    1fc4:	e9 9f 06 00 00       	jmp    2668 <internal_vprintf+0xf17>
											else if (*fmt == 'X')
    1fc9:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1fcd:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1fd0:	3c 58                	cmp    al,0x58
    1fd2:	75 2d                	jne    2001 <internal_vprintf+0x8b0>
													rv += putu(ctx, val, flags | KFL_IS_HEX | KFL_CAPITAL, width, prec);
    1fd4:	0f be 7d fc          	movsx  edi,BYTE PTR [rbp-0x4]
    1fd8:	0f be 4d fd          	movsx  ecx,BYTE PTR [rbp-0x3]
    1fdc:	0f b6 45 fe          	movzx  eax,BYTE PTR [rbp-0x2]
    1fe0:	83 c8 81             	or     eax,0xffffff81
    1fe3:	0f be d0             	movsx  edx,al
    1fe6:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1fea:	48 8b 75 e0          	mov    rsi,QWORD PTR [rbp-0x20]
    1fee:	41 89 f8             	mov    r8d,edi
    1ff1:	48 89 c7             	mov    rdi,rax
    1ff4:	e8 00 00 00 00       	call   1ff9 <internal_vprintf+0x8a8>
    1ff9:	01 45 f4             	add    DWORD PTR [rbp-0xc],eax
									} else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'u' || *fmt == 'o' || *fmt == 'b') {
    1ffc:	e9 67 06 00 00       	jmp    2668 <internal_vprintf+0xf17>
											else if (*fmt == 'u')
    2001:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2005:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    2008:	3c 75                	cmp    al,0x75
    200a:	75 27                	jne    2033 <internal_vprintf+0x8e2>
													rv += putu(ctx, val, flags, width, prec);
    200c:	0f be 7d fc          	movsx  edi,BYTE PTR [rbp-0x4]
    2010:	0f be 4d fd          	movsx  ecx,BYTE PTR [rbp-0x3]
    2014:	0f be 55 fe          	movsx  edx,BYTE PTR [rbp-0x2]
    2018:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    201c:	48 8b 75 e0          	mov    rsi,QWORD PTR [rbp-0x20]
    2020:	41 89 f8             	mov    r8d,edi
    2023:	48 89 c7             	mov    rdi,rax
    2026:	e8 00 00 00 00       	call   202b <internal_vprintf+0x8da>
    202b:	01 45 f4             	add    DWORD PTR [rbp-0xc],eax
									} else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'u' || *fmt == 'o' || *fmt == 'b') {
    202e:	e9 35 06 00 00       	jmp    2668 <internal_vprintf+0xf17>
											else if (*fmt == 'o')
    2033:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2037:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    203a:	3c 6f                	cmp    al,0x6f
    203c:	75 2d                	jne    206b <internal_vprintf+0x91a>
													rv += putu(ctx, val, flags | KFL_IS_OCT, width, prec);
    203e:	0f be 7d fc          	movsx  edi,BYTE PTR [rbp-0x4]
    2042:	0f be 4d fd          	movsx  ecx,BYTE PTR [rbp-0x3]
    2046:	0f b6 45 fe          	movzx  eax,BYTE PTR [rbp-0x2]
    204a:	83 c8 40             	or     eax,0x40
    204d:	0f be d0             	movsx  edx,al
    2050:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2054:	48 8b 75 e0          	mov    rsi,QWORD PTR [rbp-0x20]
    2058:	41 89 f8             	mov    r8d,edi
    205b:	48 89 c7             	mov    rdi,rax
    205e:	e8 00 00 00 00       	call   2063 <internal_vprintf+0x912>
    2063:	01 45 f4             	add    DWORD PTR [rbp-0xc],eax
									} else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'u' || *fmt == 'o' || *fmt == 'b') {
    2066:	e9 fd 05 00 00       	jmp    2668 <internal_vprintf+0xf17>
											else if (*fmt == 'b')
    206b:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    206f:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    2072:	3c 62                	cmp    al,0x62
    2074:	0f 85 ee 05 00 00    	jne    2668 <internal_vprintf+0xf17>
													rv += putb(ctx, val, flags, width, prec);
    207a:	0f be 75 fc          	movsx  esi,BYTE PTR [rbp-0x4]
    207e:	0f be 4d fd          	movsx  ecx,BYTE PTR [rbp-0x3]
    2082:	0f be 55 fe          	movsx  edx,BYTE PTR [rbp-0x2]
    2086:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    208a:	89 c7                	mov    edi,eax
    208c:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2090:	41 89 f0             	mov    r8d,esi
    2093:	89 fe                	mov    esi,edi
    2095:	48 89 c7             	mov    rdi,rax
    2098:	e8 00 00 00 00       	call   209d <internal_vprintf+0x94c>
    209d:	01 45 f4             	add    DWORD PTR [rbp-0xc],eax
									} else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'u' || *fmt == 'o' || *fmt == 'b') {
    20a0:	e9 c3 05 00 00       	jmp    2668 <internal_vprintf+0xf17>
									} else if(*fmt == 'p')/* {
    20a5:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    20a9:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    20ac:	3c 70                	cmp    al,0x70
    20ae:	75 6d                	jne    211d <internal_vprintf+0x9cc>
											rv += putu(ctx, (uint64_t)(uintptr_t)va_arg(args, void*), /*KFL_ZERO_PREFIX |*/ KFL_IS_HEX,
    20b0:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    20b4:	8b 00                	mov    eax,DWORD PTR [rax]
    20b6:	83 f8 2f             	cmp    eax,0x2f
    20b9:	77 24                	ja     20df <internal_vprintf+0x98e>
    20bb:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    20bf:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    20c3:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    20c7:	8b 00                	mov    eax,DWORD PTR [rax]
    20c9:	89 c0                	mov    eax,eax
    20cb:	48 01 d0             	add    rax,rdx
    20ce:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    20d2:	8b 12                	mov    edx,DWORD PTR [rdx]
    20d4:	8d 4a 08             	lea    ecx,[rdx+0x8]
    20d7:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    20db:	89 0a                	mov    DWORD PTR [rdx],ecx
    20dd:	eb 14                	jmp    20f3 <internal_vprintf+0x9a2>
    20df:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    20e3:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    20e7:	48 8d 48 08          	lea    rcx,[rax+0x8]
    20eb:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    20ef:	48 89 4a 08          	mov    QWORD PTR [rdx+0x8],rcx
    20f3:	48 8b 00             	mov    rax,QWORD PTR [rax]
    20f6:	48 89 c6             	mov    rsi,rax
    20f9:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    20fd:	41 b8 10 00 00 00    	mov    r8d,0x10
    2103:	b9 00 00 00 00       	mov    ecx,0x0
    2108:	ba 01 00 00 00       	mov    edx,0x1
    210d:	48 89 c7             	mov    rdi,rax
    2110:	e8 00 00 00 00       	call   2115 <internal_vprintf+0x9c4>
    2115:	01 45 f4             	add    DWORD PTR [rbp-0xc],eax
    2118:	e9 4c 05 00 00       	jmp    2669 <internal_vprintf+0xf18>
									else if (*fmt == 's') {
    211d:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2121:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    2124:	3c 73                	cmp    al,0x73
    2126:	0f 85 86 01 00 00    	jne    22b2 <internal_vprintf+0xb61>
											const char* str = va_arg(args, const char*);
    212c:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2130:	8b 00                	mov    eax,DWORD PTR [rax]
    2132:	83 f8 2f             	cmp    eax,0x2f
    2135:	77 24                	ja     215b <internal_vprintf+0xa0a>
    2137:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    213b:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    213f:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2143:	8b 00                	mov    eax,DWORD PTR [rax]
    2145:	89 c0                	mov    eax,eax
    2147:	48 01 d0             	add    rax,rdx
    214a:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    214e:	8b 12                	mov    edx,DWORD PTR [rdx]
    2150:	8d 4a 08             	lea    ecx,[rdx+0x8]
    2153:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    2157:	89 0a                	mov    DWORD PTR [rdx],ecx
    2159:	eb 14                	jmp    216f <internal_vprintf+0xa1e>
    215b:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    215f:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2163:	48 8d 48 08          	lea    rcx,[rax+0x8]
    2167:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    216b:	48 89 4a 08          	mov    QWORD PTR [rdx+0x8],rcx
    216f:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2172:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
											if(str) {
    2176:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
    217b:	0f 84 19 01 00 00    	je     229a <internal_vprintf+0xb49>
													size_t l = strlen(str);
    2181:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2185:	48 89 c7             	mov    rdi,rax
    2188:	e8 00 00 00 00       	call   218d <internal_vprintf+0xa3c>
    218d:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
													if ((size_t)width > l) {
    2191:	48 0f be 45 fd       	movsx  rax,BYTE PTR [rbp-0x3]
    2196:	48 39 45 d0          	cmp    QWORD PTR [rbp-0x30],rax
    219a:	73 76                	jae    2212 <internal_vprintf+0xac1>
															if (!(flags & KFL_LEFT_ALIGN))
    219c:	0f be 45 fe          	movsx  eax,BYTE PTR [rbp-0x2]
    21a0:	83 e0 08             	and    eax,0x8
    21a3:	85 c0                	test   eax,eax
    21a5:	75 2b                	jne    21d2 <internal_vprintf+0xa81>
																	cputs(str);
    21a7:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    21ab:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
    21af:	49 89 d2             	mov    r10,rdx
    21b2:	48 89 c7             	mov    rdi,rax
    21b5:	e8 4b f5 ff ff       	call   1705 <cputs.0>
															while ((size_t)(width--) > l)
    21ba:	eb 16                	jmp    21d2 <internal_vprintf+0xa81>
																	ctx->putchar(ctx, ' ');
    21bc:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    21c0:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    21c4:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    21c8:	be 20 00 00 00       	mov    esi,0x20
    21cd:	48 89 c7             	mov    rdi,rax
    21d0:	ff d2                	call   rdx
															while ((size_t)(width--) > l)
    21d2:	0f b6 45 fd          	movzx  eax,BYTE PTR [rbp-0x3]
    21d6:	89 c2                	mov    edx,eax
    21d8:	83 ea 01             	sub    edx,0x1
    21db:	88 55 fd             	mov    BYTE PTR [rbp-0x3],dl
    21de:	48 0f be c0          	movsx  rax,al
    21e2:	48 39 45 d0          	cmp    QWORD PTR [rbp-0x30],rax
    21e6:	72 d4                	jb     21bc <internal_vprintf+0xa6b>
															if (flags & KFL_LEFT_ALIGN)
    21e8:	0f be 45 fe          	movsx  eax,BYTE PTR [rbp-0x2]
    21ec:	83 e0 08             	and    eax,0x8
    21ef:	85 c0                	test   eax,eax
    21f1:	74 13                	je     2206 <internal_vprintf+0xab5>
																	cputs(str);
    21f3:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    21f7:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
    21fb:	49 89 d2             	mov    r10,rdx
    21fe:	48 89 c7             	mov    rdi,rax
    2201:	e8 ff f4 ff ff       	call   1705 <cputs.0>
															rv += width;
    2206:	0f be 45 fd          	movsx  eax,BYTE PTR [rbp-0x3]
    220a:	01 45 f4             	add    DWORD PTR [rbp-0xc],eax
    220d:	e9 57 04 00 00       	jmp    2669 <internal_vprintf+0xf18>
													} else if (prec && l > (size_t)prec) {
    2212:	80 7d fc 00          	cmp    BYTE PTR [rbp-0x4],0x0
    2216:	74 5c                	je     2274 <internal_vprintf+0xb23>
    2218:	48 0f be 45 fc       	movsx  rax,BYTE PTR [rbp-0x4]
    221d:	48 3b 45 d0          	cmp    rax,QWORD PTR [rbp-0x30]
    2221:	73 51                	jae    2274 <internal_vprintf+0xb23>
															rv += prec;
    2223:	0f be 45 fc          	movsx  eax,BYTE PTR [rbp-0x4]
    2227:	01 45 f4             	add    DWORD PTR [rbp-0xc],eax
															l = 0;
    222a:	48 c7 45 d0 00 00 00 00 	mov    QWORD PTR [rbp-0x30],0x0
															while (l++ < (size_t)prec)
    2232:	eb 25                	jmp    2259 <internal_vprintf+0xb08>
																	ctx->putchar(ctx, *str++);
    2234:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2238:	48 8b 48 10          	mov    rcx,QWORD PTR [rax+0x10]
    223c:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2240:	48 8d 50 01          	lea    rdx,[rax+0x1]
    2244:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
    2248:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    224b:	0f be d0             	movsx  edx,al
    224e:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2252:	89 d6                	mov    esi,edx
    2254:	48 89 c7             	mov    rdi,rax
    2257:	ff d1                	call   rcx
															while (l++ < (size_t)prec)
    2259:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    225d:	48 8d 50 01          	lea    rdx,[rax+0x1]
    2261:	48 89 55 d0          	mov    QWORD PTR [rbp-0x30],rdx
    2265:	48 0f be 55 fc       	movsx  rdx,BYTE PTR [rbp-0x4]
    226a:	48 39 d0             	cmp    rax,rdx
    226d:	72 c5                	jb     2234 <internal_vprintf+0xae3>
													} else if (prec && l > (size_t)prec) {
    226f:	e9 f5 03 00 00       	jmp    2669 <internal_vprintf+0xf18>
													} else {
															rv += l;
    2274:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    2278:	89 c2                	mov    edx,eax
    227a:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    227d:	01 d0                	add    eax,edx
    227f:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
															cputs(str);
    2282:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2286:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
    228a:	49 89 d2             	mov    r10,rdx
    228d:	48 89 c7             	mov    rdi,rax
    2290:	e8 70 f4 ff ff       	call   1705 <cputs.0>
    2295:	e9 cf 03 00 00       	jmp    2669 <internal_vprintf+0xf18>
													}
											}
											else
													cputs("(null)");
    229a:	48 8d 45 c0          	lea    rax,[rbp-0x40]
    229e:	49 89 c2             	mov    r10,rax
    22a1:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    22a8:	e8 58 f4 ff ff       	call   1705 <cputs.0>
    22ad:	e9 b7 03 00 00       	jmp    2669 <internal_vprintf+0xf18>
									} else if (*fmt == 'c') {
    22b2:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    22b6:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    22b9:	3c 63                	cmp    al,0x63
    22bb:	75 64                	jne    2321 <internal_vprintf+0xbd0>
											ctx->putchar(ctx, (char)va_arg(args, int));
    22bd:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    22c1:	48 8b 48 10          	mov    rcx,QWORD PTR [rax+0x10]
    22c5:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    22c9:	8b 00                	mov    eax,DWORD PTR [rax]
    22cb:	83 f8 2f             	cmp    eax,0x2f
    22ce:	77 24                	ja     22f4 <internal_vprintf+0xba3>
    22d0:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    22d4:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    22d8:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    22dc:	8b 00                	mov    eax,DWORD PTR [rax]
    22de:	89 c0                	mov    eax,eax
    22e0:	48 01 d0             	add    rax,rdx
    22e3:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    22e7:	8b 12                	mov    edx,DWORD PTR [rdx]
    22e9:	8d 72 08             	lea    esi,[rdx+0x8]
    22ec:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    22f0:	89 32                	mov    DWORD PTR [rdx],esi
    22f2:	eb 14                	jmp    2308 <internal_vprintf+0xbb7>
    22f4:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    22f8:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    22fc:	48 8d 70 08          	lea    rsi,[rax+0x8]
    2300:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    2304:	48 89 72 08          	mov    QWORD PTR [rdx+0x8],rsi
    2308:	8b 00                	mov    eax,DWORD PTR [rax]
    230a:	0f be d0             	movsx  edx,al
    230d:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2311:	89 d6                	mov    esi,edx
    2313:	48 89 c7             	mov    rdi,rax
    2316:	ff d1                	call   rcx
											rv++;
    2318:	83 45 f4 01          	add    DWORD PTR [rbp-0xc],0x1
    231c:	e9 48 03 00 00       	jmp    2669 <internal_vprintf+0xf18>
									} else if (*fmt == 'f')
    2321:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2325:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    2328:	3c 66                	cmp    al,0x66
    232a:	0f 84 39 03 00 00    	je     2669 <internal_vprintf+0xf18>
											/* FPU init needed? */;
									else if (*fmt == 'n') {
    2330:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2334:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    2337:	3c 6e                	cmp    al,0x6e
    2339:	0f 85 f0 02 00 00    	jne    262f <internal_vprintf+0xede>
											if (!size)
    233f:	80 7d fb 00          	cmp    BYTE PTR [rbp-0x5],0x0
    2343:	75 50                	jne    2395 <internal_vprintf+0xc44>
													*va_arg(args, int*) = (int)rv;
    2345:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2349:	8b 00                	mov    eax,DWORD PTR [rax]
    234b:	83 f8 2f             	cmp    eax,0x2f
    234e:	77 24                	ja     2374 <internal_vprintf+0xc23>
    2350:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2354:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    2358:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    235c:	8b 00                	mov    eax,DWORD PTR [rax]
    235e:	89 c0                	mov    eax,eax
    2360:	48 01 d0             	add    rax,rdx
    2363:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    2367:	8b 12                	mov    edx,DWORD PTR [rdx]
    2369:	8d 4a 08             	lea    ecx,[rdx+0x8]
    236c:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    2370:	89 0a                	mov    DWORD PTR [rdx],ecx
    2372:	eb 14                	jmp    2388 <internal_vprintf+0xc37>
    2374:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2378:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    237c:	48 8d 48 08          	lea    rcx,[rax+0x8]
    2380:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    2384:	48 89 4a 08          	mov    QWORD PTR [rdx+0x8],rcx
    2388:	48 8b 00             	mov    rax,QWORD PTR [rax]
    238b:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    238e:	89 10                	mov    DWORD PTR [rax],edx
    2390:	e9 d4 02 00 00       	jmp    2669 <internal_vprintf+0xf18>
											else if (size == 1)
    2395:	80 7d fb 01          	cmp    BYTE PTR [rbp-0x5],0x1
    2399:	75 50                	jne    23eb <internal_vprintf+0xc9a>
													*va_arg(args, signed char*) = (signed char)rv;
    239b:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    239f:	8b 00                	mov    eax,DWORD PTR [rax]
    23a1:	83 f8 2f             	cmp    eax,0x2f
    23a4:	77 24                	ja     23ca <internal_vprintf+0xc79>
    23a6:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    23aa:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    23ae:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    23b2:	8b 00                	mov    eax,DWORD PTR [rax]
    23b4:	89 c0                	mov    eax,eax
    23b6:	48 01 d0             	add    rax,rdx
    23b9:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    23bd:	8b 12                	mov    edx,DWORD PTR [rdx]
    23bf:	8d 4a 08             	lea    ecx,[rdx+0x8]
    23c2:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    23c6:	89 0a                	mov    DWORD PTR [rdx],ecx
    23c8:	eb 14                	jmp    23de <internal_vprintf+0xc8d>
    23ca:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    23ce:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    23d2:	48 8d 48 08          	lea    rcx,[rax+0x8]
    23d6:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    23da:	48 89 4a 08          	mov    QWORD PTR [rdx+0x8],rcx
    23de:	48 8b 00             	mov    rax,QWORD PTR [rax]
    23e1:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    23e4:	88 10                	mov    BYTE PTR [rax],dl
    23e6:	e9 7e 02 00 00       	jmp    2669 <internal_vprintf+0xf18>
											else if (size == 2)
    23eb:	80 7d fb 02          	cmp    BYTE PTR [rbp-0x5],0x2
    23ef:	75 51                	jne    2442 <internal_vprintf+0xcf1>
													*va_arg(args, short int*) = (short int)rv;
    23f1:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    23f5:	8b 00                	mov    eax,DWORD PTR [rax]
    23f7:	83 f8 2f             	cmp    eax,0x2f
    23fa:	77 24                	ja     2420 <internal_vprintf+0xccf>
    23fc:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2400:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    2404:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2408:	8b 00                	mov    eax,DWORD PTR [rax]
    240a:	89 c0                	mov    eax,eax
    240c:	48 01 d0             	add    rax,rdx
    240f:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    2413:	8b 12                	mov    edx,DWORD PTR [rdx]
    2415:	8d 4a 08             	lea    ecx,[rdx+0x8]
    2418:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    241c:	89 0a                	mov    DWORD PTR [rdx],ecx
    241e:	eb 14                	jmp    2434 <internal_vprintf+0xce3>
    2420:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2424:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2428:	48 8d 48 08          	lea    rcx,[rax+0x8]
    242c:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    2430:	48 89 4a 08          	mov    QWORD PTR [rdx+0x8],rcx
    2434:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2437:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    243a:	66 89 10             	mov    WORD PTR [rax],dx
    243d:	e9 27 02 00 00       	jmp    2669 <internal_vprintf+0xf18>
											else if (size == 3)
    2442:	80 7d fb 03          	cmp    BYTE PTR [rbp-0x5],0x3
    2446:	75 54                	jne    249c <internal_vprintf+0xd4b>
													*va_arg(args, long int*) = (long int)rv;
    2448:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    244c:	8b 00                	mov    eax,DWORD PTR [rax]
    244e:	83 f8 2f             	cmp    eax,0x2f
    2451:	77 24                	ja     2477 <internal_vprintf+0xd26>
    2453:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2457:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    245b:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    245f:	8b 00                	mov    eax,DWORD PTR [rax]
    2461:	89 c0                	mov    eax,eax
    2463:	48 01 d0             	add    rax,rdx
    2466:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    246a:	8b 12                	mov    edx,DWORD PTR [rdx]
    246c:	8d 4a 08             	lea    ecx,[rdx+0x8]
    246f:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    2473:	89 0a                	mov    DWORD PTR [rdx],ecx
    2475:	eb 14                	jmp    248b <internal_vprintf+0xd3a>
    2477:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    247b:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    247f:	48 8d 48 08          	lea    rcx,[rax+0x8]
    2483:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    2487:	48 89 4a 08          	mov    QWORD PTR [rdx+0x8],rcx
    248b:	48 8b 00             	mov    rax,QWORD PTR [rax]
    248e:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    2491:	48 63 d2             	movsxd rdx,edx
    2494:	48 89 10             	mov    QWORD PTR [rax],rdx
    2497:	e9 cd 01 00 00       	jmp    2669 <internal_vprintf+0xf18>
											else if (size == 4)
    249c:	80 7d fb 04          	cmp    BYTE PTR [rbp-0x5],0x4
    24a0:	75 54                	jne    24f6 <internal_vprintf+0xda5>
													*va_arg(args, long long int*) = (long long int)rv;
    24a2:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    24a6:	8b 00                	mov    eax,DWORD PTR [rax]
    24a8:	83 f8 2f             	cmp    eax,0x2f
    24ab:	77 24                	ja     24d1 <internal_vprintf+0xd80>
    24ad:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    24b1:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    24b5:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    24b9:	8b 00                	mov    eax,DWORD PTR [rax]
    24bb:	89 c0                	mov    eax,eax
    24bd:	48 01 d0             	add    rax,rdx
    24c0:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    24c4:	8b 12                	mov    edx,DWORD PTR [rdx]
    24c6:	8d 4a 08             	lea    ecx,[rdx+0x8]
    24c9:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    24cd:	89 0a                	mov    DWORD PTR [rdx],ecx
    24cf:	eb 14                	jmp    24e5 <internal_vprintf+0xd94>
    24d1:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    24d5:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    24d9:	48 8d 48 08          	lea    rcx,[rax+0x8]
    24dd:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    24e1:	48 89 4a 08          	mov    QWORD PTR [rdx+0x8],rcx
    24e5:	48 8b 00             	mov    rax,QWORD PTR [rax]
    24e8:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    24eb:	48 63 d2             	movsxd rdx,edx
    24ee:	48 89 10             	mov    QWORD PTR [rax],rdx
    24f1:	e9 73 01 00 00       	jmp    2669 <internal_vprintf+0xf18>
											else if (size == 5)
    24f6:	80 7d fb 05          	cmp    BYTE PTR [rbp-0x5],0x5
    24fa:	75 54                	jne    2550 <internal_vprintf+0xdff>
													*va_arg(args, intmax_t*) = (intmax_t)rv;
    24fc:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2500:	8b 00                	mov    eax,DWORD PTR [rax]
    2502:	83 f8 2f             	cmp    eax,0x2f
    2505:	77 24                	ja     252b <internal_vprintf+0xdda>
    2507:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    250b:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    250f:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2513:	8b 00                	mov    eax,DWORD PTR [rax]
    2515:	89 c0                	mov    eax,eax
    2517:	48 01 d0             	add    rax,rdx
    251a:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    251e:	8b 12                	mov    edx,DWORD PTR [rdx]
    2520:	8d 4a 08             	lea    ecx,[rdx+0x8]
    2523:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    2527:	89 0a                	mov    DWORD PTR [rdx],ecx
    2529:	eb 14                	jmp    253f <internal_vprintf+0xdee>
    252b:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    252f:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2533:	48 8d 48 08          	lea    rcx,[rax+0x8]
    2537:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    253b:	48 89 4a 08          	mov    QWORD PTR [rdx+0x8],rcx
    253f:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2542:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    2545:	48 63 d2             	movsxd rdx,edx
    2548:	48 89 10             	mov    QWORD PTR [rax],rdx
    254b:	e9 19 01 00 00       	jmp    2669 <internal_vprintf+0xf18>
											else if (size == 6)
    2550:	80 7d fb 06          	cmp    BYTE PTR [rbp-0x5],0x6
    2554:	75 50                	jne    25a6 <internal_vprintf+0xe55>
													*va_arg(args, ssize_t*) = (ssize_t)rv;
    2556:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    255a:	8b 00                	mov    eax,DWORD PTR [rax]
    255c:	83 f8 2f             	cmp    eax,0x2f
    255f:	77 24                	ja     2585 <internal_vprintf+0xe34>
    2561:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2565:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    2569:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    256d:	8b 00                	mov    eax,DWORD PTR [rax]
    256f:	89 c0                	mov    eax,eax
    2571:	48 01 d0             	add    rax,rdx
    2574:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    2578:	8b 12                	mov    edx,DWORD PTR [rdx]
    257a:	8d 4a 08             	lea    ecx,[rdx+0x8]
    257d:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    2581:	89 0a                	mov    DWORD PTR [rdx],ecx
    2583:	eb 14                	jmp    2599 <internal_vprintf+0xe48>
    2585:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2589:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    258d:	48 8d 48 08          	lea    rcx,[rax+0x8]
    2591:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    2595:	48 89 4a 08          	mov    QWORD PTR [rdx+0x8],rcx
    2599:	48 8b 00             	mov    rax,QWORD PTR [rax]
    259c:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    259f:	89 10                	mov    DWORD PTR [rax],edx
    25a1:	e9 c3 00 00 00       	jmp    2669 <internal_vprintf+0xf18>
											else if (size == 7)
    25a6:	80 7d fb 07          	cmp    BYTE PTR [rbp-0x5],0x7
    25aa:	75 51                	jne    25fd <internal_vprintf+0xeac>
													*va_arg(args, ptrdiff_t*) = (ptrdiff_t)rv;
    25ac:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    25b0:	8b 00                	mov    eax,DWORD PTR [rax]
    25b2:	83 f8 2f             	cmp    eax,0x2f
    25b5:	77 24                	ja     25db <internal_vprintf+0xe8a>
    25b7:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    25bb:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    25bf:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    25c3:	8b 00                	mov    eax,DWORD PTR [rax]
    25c5:	89 c0                	mov    eax,eax
    25c7:	48 01 d0             	add    rax,rdx
    25ca:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    25ce:	8b 12                	mov    edx,DWORD PTR [rdx]
    25d0:	8d 4a 08             	lea    ecx,[rdx+0x8]
    25d3:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    25d7:	89 0a                	mov    DWORD PTR [rdx],ecx
    25d9:	eb 14                	jmp    25ef <internal_vprintf+0xe9e>
    25db:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    25df:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    25e3:	48 8d 48 08          	lea    rcx,[rax+0x8]
    25e7:	48 8b 55 a8          	mov    rdx,QWORD PTR [rbp-0x58]
    25eb:	48 89 4a 08          	mov    QWORD PTR [rdx+0x8],rcx
    25ef:	48 8b 00             	mov    rax,QWORD PTR [rax]
    25f2:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    25f5:	48 63 d2             	movsxd rdx,edx
    25f8:	48 89 10             	mov    QWORD PTR [rax],rdx
    25fb:	eb 6c                	jmp    2669 <internal_vprintf+0xf18>
											else
													(void)va_arg(args, long double*);
    25fd:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2601:	8b 00                	mov    eax,DWORD PTR [rax]
    2603:	83 f8 2f             	cmp    eax,0x2f
    2606:	77 11                	ja     2619 <internal_vprintf+0xec8>
    2608:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    260c:	8b 00                	mov    eax,DWORD PTR [rax]
    260e:	8d 50 08             	lea    edx,[rax+0x8]
    2611:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2615:	89 10                	mov    DWORD PTR [rax],edx
    2617:	eb 50                	jmp    2669 <internal_vprintf+0xf18>
    2619:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    261d:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2621:	48 8d 50 08          	lea    rdx,[rax+0x8]
    2625:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2629:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
    262d:	eb 3a                	jmp    2669 <internal_vprintf+0xf18>
									} else { /* ignore */
											ctx->putchar(ctx, '%');
    262f:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2633:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    2637:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    263b:	be 25 00 00 00       	mov    esi,0x25
    2640:	48 89 c7             	mov    rdi,rax
    2643:	ff d2                	call   rdx
											ctx->putchar(ctx, *fmt);
    2645:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2649:	48 8b 48 10          	mov    rcx,QWORD PTR [rax+0x10]
    264d:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2651:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    2654:	0f be d0             	movsx  edx,al
    2657:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    265b:	89 d6                	mov    esi,edx
    265d:	48 89 c7             	mov    rdi,rax
    2660:	ff d1                	call   rcx
											rv += 2;
    2662:	83 45 f4 02          	add    DWORD PTR [rbp-0xc],0x2
    2666:	eb 01                	jmp    2669 <internal_vprintf+0xf18>
									} else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'u' || *fmt == 'o' || *fmt == 'b') {
    2668:	90                   	nop
									}
									fmt++;
    2669:	48 83 45 b0 01       	add    QWORD PTR [rbp-0x50],0x1
									is_fmt = 0;
    266e:	c6 45 ff 00          	mov    BYTE PTR [rbp-0x1],0x0
									flags = KFL_LEFT_ALIGN;
    2672:	c6 45 fe 08          	mov    BYTE PTR [rbp-0x2],0x8
									width = 0;
    2676:	c6 45 fd 00          	mov    BYTE PTR [rbp-0x3],0x0
									prec = 0;
    267a:	c6 45 fc 00          	mov    BYTE PTR [rbp-0x4],0x0
									size = 0;
    267e:	c6 45 fb 00          	mov    BYTE PTR [rbp-0x5],0x0
    2682:	eb 29                	jmp    26ad <internal_vprintf+0xf5c>
							} else {
									ctx->putchar(ctx, *(fmt++));
    2684:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2688:	48 8b 48 10          	mov    rcx,QWORD PTR [rax+0x10]
    268c:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    2690:	48 8d 50 01          	lea    rdx,[rax+0x1]
    2694:	48 89 55 b0          	mov    QWORD PTR [rbp-0x50],rdx
    2698:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    269b:	0f be d0             	movsx  edx,al
    269e:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    26a2:	89 d6                	mov    esi,edx
    26a4:	48 89 c7             	mov    rdi,rax
    26a7:	ff d1                	call   rcx
									rv++;
    26a9:	83 45 f4 01          	add    DWORD PTR [rbp-0xc],0x1
		while (*fmt) {
    26ad:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    26b1:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    26b4:	84 c0                	test   al,al
    26b6:	0f 85 d9 f0 ff ff    	jne    1795 <internal_vprintf+0x44>
							}
			}
		}
		return rv;
    26bc:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
}
    26bf:	c9                   	leave
    26c0:	c3                   	ret

00000000000026c1 <ctx_c_putchar>:

void ctx_c_putchar(struct ivp_ctx* ctx, char c)
{
    26c1:	55                   	push   rbp
    26c2:	48 89 e5             	mov    rbp,rsp
    26c5:	48 83 ec 10          	sub    rsp,0x10
    26c9:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
    26cd:	89 f0                	mov    eax,esi
    26cf:	88 45 f4             	mov    BYTE PTR [rbp-0xc],al
		region_putchar(ctx->buf, c);
    26d2:	0f be 55 f4          	movsx  edx,BYTE PTR [rbp-0xc]
    26d6:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    26da:	48 8b 00             	mov    rax,QWORD PTR [rax]
    26dd:	89 d6                	mov    esi,edx
    26df:	48 89 c7             	mov    rdi,rax
    26e2:	e8 00 00 00 00       	call   26e7 <ctx_c_putchar+0x26>
}
    26e7:	90                   	nop
    26e8:	c9                   	leave
    26e9:	c3                   	ret

00000000000026ea <ctx_s_putchar>:

void ctx_s_putchar(struct ivp_ctx* ctx, char c)
{
    26ea:	55                   	push   rbp
    26eb:	48 89 e5             	mov    rbp,rsp
    26ee:	48 83 ec 10          	sub    rsp,0x10
    26f2:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
    26f6:	89 f0                	mov    eax,esi
    26f8:	88 45 f4             	mov    BYTE PTR [rbp-0xc],al
		if (ctx->buf) {
    26fb:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    26ff:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2702:	48 85 c0             	test   rax,rax
    2705:	74 46                	je     274d <ctx_s_putchar+0x63>
				if (!ctx->n) {
    2707:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    270b:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    270f:	48 85 c0             	test   rax,rax
    2712:	75 0d                	jne    2721 <ctx_s_putchar+0x37>
						ctx->buf = NULL;
    2714:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2718:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
						return;
    271f:	eb 2c                	jmp    274d <ctx_s_putchar+0x63>
				}
				*ctx->buf++ = c;
    2721:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2725:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2728:	48 8d 48 01          	lea    rcx,[rax+0x1]
    272c:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    2730:	48 89 0a             	mov    QWORD PTR [rdx],rcx
    2733:	0f b6 55 f4          	movzx  edx,BYTE PTR [rbp-0xc]
    2737:	88 10                	mov    BYTE PTR [rax],dl
				ctx->n--;
    2739:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    273d:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    2741:	48 8d 50 ff          	lea    rdx,[rax-0x1]
    2745:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2749:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
		}
}
    274d:	c9                   	leave
    274e:	c3                   	ret

000000000000274f <vrprintf>:

int vrprintf(struct kio_region* cr, const char* fmt, va_list args)
{
    274f:	55                   	push   rbp
    2750:	48 89 e5             	mov    rbp,rsp
    2753:	48 83 ec 40          	sub    rsp,0x40
    2757:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
    275b:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi
    275f:	48 89 55 c8          	mov    QWORD PTR [rbp-0x38],rdx
		int rv;
		struct ivp_ctx ct = {cr, 0, &ctx_c_putchar};
    2763:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2767:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    276b:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
    2773:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		rv = internal_vprintf(&ct, fmt, args);
    277b:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    277f:	48 8b 4d d0          	mov    rcx,QWORD PTR [rbp-0x30]
    2783:	48 8d 45 e0          	lea    rax,[rbp-0x20]
    2787:	48 89 ce             	mov    rsi,rcx
    278a:	48 89 c7             	mov    rdi,rax
    278d:	e8 00 00 00 00       	call   2792 <vrprintf+0x43>
    2792:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		return rv;
    2795:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
    2798:	c9                   	leave
    2799:	c3                   	ret

000000000000279a <vprintf>:

int vprintf(const char* fmt, va_list args)
{
    279a:	55                   	push   rbp
    279b:	48 89 e5             	mov    rbp,rsp
    279e:	48 83 ec 30          	sub    rsp,0x30
    27a2:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
    27a6:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi
		int rv;
		struct ivp_ctx ct = {&reg_def, 0, &ctx_c_putchar};
    27aa:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
    27b2:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
    27ba:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		rv = internal_vprintf(&ct, fmt, args);
    27c2:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    27c6:	48 8b 4d d8          	mov    rcx,QWORD PTR [rbp-0x28]
    27ca:	48 8d 45 e0          	lea    rax,[rbp-0x20]
    27ce:	48 89 ce             	mov    rsi,rcx
    27d1:	48 89 c7             	mov    rdi,rax
    27d4:	e8 00 00 00 00       	call   27d9 <vprintf+0x3f>
    27d9:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		return rv;
    27dc:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
    27df:	c9                   	leave
    27e0:	c3                   	ret

00000000000027e1 <rprintf>:

/* with region ptr, region has lock & spin_trylock & lock-free add-buffer
  & malloc in irq question */
int rprintf(struct kio_region* cr, const char* fmt, ...)
{
    27e1:	55                   	push   rbp
    27e2:	48 89 e5             	mov    rbp,rsp
    27e5:	48 83 ec 60          	sub    rsp,0x60
    27e9:	48 89 7d a8          	mov    QWORD PTR [rbp-0x58],rdi
    27ed:	48 89 75 a0          	mov    QWORD PTR [rbp-0x60],rsi
    27f1:	48 89 55 e0          	mov    QWORD PTR [rbp-0x20],rdx
    27f5:	48 89 4d e8          	mov    QWORD PTR [rbp-0x18],rcx
    27f9:	4c 89 45 f0          	mov    QWORD PTR [rbp-0x10],r8
    27fd:	4c 89 4d f8          	mov    QWORD PTR [rbp-0x8],r9
		int rv;
		va_list args;
		va_start(args, fmt);
    2801:	c7 45 b0 10 00 00 00 	mov    DWORD PTR [rbp-0x50],0x10
    2808:	48 8d 45 10          	lea    rax,[rbp+0x10]
    280c:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
    2810:	48 8d 45 d0          	lea    rax,[rbp-0x30]
    2814:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
		rv = vrprintf(cr, fmt, args);
    2818:	48 8d 55 b0          	lea    rdx,[rbp-0x50]
    281c:	48 8b 4d a0          	mov    rcx,QWORD PTR [rbp-0x60]
    2820:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2824:	48 89 ce             	mov    rsi,rcx
    2827:	48 89 c7             	mov    rdi,rax
    282a:	e8 00 00 00 00       	call   282f <rprintf+0x4e>
    282f:	89 45 cc             	mov    DWORD PTR [rbp-0x34],eax
		va_end(args);
		return rv;
    2832:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
}
    2835:	c9                   	leave
    2836:	c3                   	ret

0000000000002837 <crprintf>:

int crprintf(char col, struct kio_region* cr, const char* fmt, ...)
{
    2837:	55                   	push   rbp
    2838:	48 89 e5             	mov    rbp,rsp
    283b:	48 83 ec 70          	sub    rsp,0x70
    283f:	89 f8                	mov    eax,edi
    2841:	48 89 75 a0          	mov    QWORD PTR [rbp-0x60],rsi
    2845:	48 89 55 98          	mov    QWORD PTR [rbp-0x68],rdx
    2849:	48 89 4d e8          	mov    QWORD PTR [rbp-0x18],rcx
    284d:	4c 89 45 f0          	mov    QWORD PTR [rbp-0x10],r8
    2851:	4c 89 4d f8          	mov    QWORD PTR [rbp-0x8],r9
    2855:	88 45 ac             	mov    BYTE PTR [rbp-0x54],al
		int rv; char cf = cr->fmt;
    2858:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    285c:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    2860:	88 45 cf             	mov    BYTE PTR [rbp-0x31],al
		va_list args;
		va_start(args, fmt);
    2863:	c7 45 b0 18 00 00 00 	mov    DWORD PTR [rbp-0x50],0x18
    286a:	48 8d 45 10          	lea    rax,[rbp+0x10]
    286e:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
    2872:	48 8d 45 d0          	lea    rax,[rbp-0x30]
    2876:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
		cr->fmt = col;
    287a:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    287e:	0f b6 55 ac          	movzx  edx,BYTE PTR [rbp-0x54]
    2882:	88 50 0c             	mov    BYTE PTR [rax+0xc],dl
		rv = vrprintf(cr, fmt, args);
    2885:	48 8d 55 b0          	lea    rdx,[rbp-0x50]
    2889:	48 8b 4d 98          	mov    rcx,QWORD PTR [rbp-0x68]
    288d:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    2891:	48 89 ce             	mov    rsi,rcx
    2894:	48 89 c7             	mov    rdi,rax
    2897:	e8 00 00 00 00       	call   289c <crprintf+0x65>
    289c:	89 45 c8             	mov    DWORD PTR [rbp-0x38],eax
		cr->fmt = cf;
    289f:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    28a3:	0f b6 55 cf          	movzx  edx,BYTE PTR [rbp-0x31]
    28a7:	88 50 0c             	mov    BYTE PTR [rax+0xc],dl
		va_end(args);
		return rv;
    28aa:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
}
    28ad:	c9                   	leave
    28ae:	c3                   	ret

00000000000028af <cprintf>:

int cprintf(char col, const char* fmt, ...)
{
    28af:	55                   	push   rbp
    28b0:	48 89 e5             	mov    rbp,rsp
    28b3:	48 83 ec 60          	sub    rsp,0x60
    28b7:	89 f8                	mov    eax,edi
    28b9:	48 89 75 a0          	mov    QWORD PTR [rbp-0x60],rsi
    28bd:	48 89 55 e0          	mov    QWORD PTR [rbp-0x20],rdx
    28c1:	48 89 4d e8          	mov    QWORD PTR [rbp-0x18],rcx
    28c5:	4c 89 45 f0          	mov    QWORD PTR [rbp-0x10],r8
    28c9:	4c 89 4d f8          	mov    QWORD PTR [rbp-0x8],r9
    28cd:	88 45 ac             	mov    BYTE PTR [rbp-0x54],al
		int rv; char cf = reg_def.fmt;
    28d0:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 28d7 <cprintf+0x28>
    28d7:	88 45 cf             	mov    BYTE PTR [rbp-0x31],al
		va_list args;
		va_start(args, fmt);
    28da:	c7 45 b0 10 00 00 00 	mov    DWORD PTR [rbp-0x50],0x10
    28e1:	48 8d 45 10          	lea    rax,[rbp+0x10]
    28e5:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
    28e9:	48 8d 45 d0          	lea    rax,[rbp-0x30]
    28ed:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
		reg_def.fmt = col;
    28f1:	0f b6 45 ac          	movzx  eax,BYTE PTR [rbp-0x54]
    28f5:	88 05 00 00 00 00    	mov    BYTE PTR [rip+0x0],al        # 28fb <cprintf+0x4c>
		rv = vprintf(fmt, args);
    28fb:	48 8d 55 b0          	lea    rdx,[rbp-0x50]
    28ff:	48 8b 45 a0          	mov    rax,QWORD PTR [rbp-0x60]
    2903:	48 89 d6             	mov    rsi,rdx
    2906:	48 89 c7             	mov    rdi,rax
    2909:	e8 00 00 00 00       	call   290e <cprintf+0x5f>
    290e:	89 45 c8             	mov    DWORD PTR [rbp-0x38],eax
		reg_def.fmt = cf;
    2911:	0f b6 45 cf          	movzx  eax,BYTE PTR [rbp-0x31]
    2915:	88 05 00 00 00 00    	mov    BYTE PTR [rip+0x0],al        # 291b <cprintf+0x6c>
		va_end(args);
		return rv;
    291b:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
}
    291e:	c9                   	leave
    291f:	c3                   	ret

0000000000002920 <vsprintf>:

int vsprintf(char* str, const char* fmt, va_list args)
{
    2920:	55                   	push   rbp
    2921:	48 89 e5             	mov    rbp,rsp
    2924:	48 83 ec 40          	sub    rsp,0x40
    2928:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
    292c:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi
    2930:	48 89 55 c8          	mov    QWORD PTR [rbp-0x38],rdx
		struct ivp_ctx ct = {str, 0xffffffff, &ctx_s_putchar};
    2934:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2938:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    293c:	b8 ff ff ff ff       	mov    eax,0xffffffff
    2941:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
    2945:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		return internal_vprintf(&ct, fmt, args);
    294d:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    2951:	48 8b 4d d0          	mov    rcx,QWORD PTR [rbp-0x30]
    2955:	48 8d 45 e8          	lea    rax,[rbp-0x18]
    2959:	48 89 ce             	mov    rsi,rcx
    295c:	48 89 c7             	mov    rdi,rax
    295f:	e8 00 00 00 00       	call   2964 <vsprintf+0x44>
}
    2964:	c9                   	leave
    2965:	c3                   	ret

0000000000002966 <sprintf>:

int sprintf(char* str, const char* fmt, ...)
{
    2966:	55                   	push   rbp
    2967:	48 89 e5             	mov    rbp,rsp
    296a:	48 83 ec 60          	sub    rsp,0x60
    296e:	48 89 7d a8          	mov    QWORD PTR [rbp-0x58],rdi
    2972:	48 89 75 a0          	mov    QWORD PTR [rbp-0x60],rsi
    2976:	48 89 55 e0          	mov    QWORD PTR [rbp-0x20],rdx
    297a:	48 89 4d e8          	mov    QWORD PTR [rbp-0x18],rcx
    297e:	4c 89 45 f0          	mov    QWORD PTR [rbp-0x10],r8
    2982:	4c 89 4d f8          	mov    QWORD PTR [rbp-0x8],r9
		int rv;
		va_list args;
		va_start(args, fmt);
    2986:	c7 45 b0 10 00 00 00 	mov    DWORD PTR [rbp-0x50],0x10
    298d:	48 8d 45 10          	lea    rax,[rbp+0x10]
    2991:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
    2995:	48 8d 45 d0          	lea    rax,[rbp-0x30]
    2999:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
		rv = vsprintf(str, fmt, args);
    299d:	48 8d 55 b0          	lea    rdx,[rbp-0x50]
    29a1:	48 8b 4d a0          	mov    rcx,QWORD PTR [rbp-0x60]
    29a5:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    29a9:	48 89 ce             	mov    rsi,rcx
    29ac:	48 89 c7             	mov    rdi,rax
    29af:	e8 00 00 00 00       	call   29b4 <sprintf+0x4e>
    29b4:	89 45 cc             	mov    DWORD PTR [rbp-0x34],eax
		va_end(args);
		return rv;
    29b7:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
}
    29ba:	c9                   	leave
    29bb:	c3                   	ret

00000000000029bc <vsnprintf>:

int vsnprintf(char* str, size_t n, const char* fmt, va_list args)
{
    29bc:	55                   	push   rbp
    29bd:	48 89 e5             	mov    rbp,rsp
    29c0:	48 83 ec 40          	sub    rsp,0x40
    29c4:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
    29c8:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi
    29cc:	48 89 55 c8          	mov    QWORD PTR [rbp-0x38],rdx
    29d0:	48 89 4d c0          	mov    QWORD PTR [rbp-0x40],rcx
		struct ivp_ctx ct = {str, n, &ctx_s_putchar};
    29d4:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    29d8:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    29dc:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    29e0:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
    29e4:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
		return internal_vprintf(&ct, fmt, args);
    29ec:	48 8b 55 c0          	mov    rdx,QWORD PTR [rbp-0x40]
    29f0:	48 8b 4d c8          	mov    rcx,QWORD PTR [rbp-0x38]
    29f4:	48 8d 45 e8          	lea    rax,[rbp-0x18]
    29f8:	48 89 ce             	mov    rsi,rcx
    29fb:	48 89 c7             	mov    rdi,rax
    29fe:	e8 00 00 00 00       	call   2a03 <vsnprintf+0x47>
}
    2a03:	c9                   	leave
    2a04:	c3                   	ret

0000000000002a05 <snprintf>:

int snprintf(char* str, size_t n, const char* fmt, ...)
{
    2a05:	55                   	push   rbp
    2a06:	48 89 e5             	mov    rbp,rsp
    2a09:	48 83 ec 70          	sub    rsp,0x70
    2a0d:	48 89 7d a8          	mov    QWORD PTR [rbp-0x58],rdi
    2a11:	48 89 75 a0          	mov    QWORD PTR [rbp-0x60],rsi
    2a15:	48 89 55 98          	mov    QWORD PTR [rbp-0x68],rdx
    2a19:	48 89 4d e8          	mov    QWORD PTR [rbp-0x18],rcx
    2a1d:	4c 89 45 f0          	mov    QWORD PTR [rbp-0x10],r8
    2a21:	4c 89 4d f8          	mov    QWORD PTR [rbp-0x8],r9
		int rv;
		va_list args;
		va_start(args, fmt);
    2a25:	c7 45 b0 18 00 00 00 	mov    DWORD PTR [rbp-0x50],0x18
    2a2c:	48 8d 45 10          	lea    rax,[rbp+0x10]
    2a30:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
    2a34:	48 8d 45 d0          	lea    rax,[rbp-0x30]
    2a38:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
		rv = vsnprintf(str, n, fmt, args);
    2a3c:	48 8d 4d b0          	lea    rcx,[rbp-0x50]
    2a40:	48 8b 55 98          	mov    rdx,QWORD PTR [rbp-0x68]
    2a44:	48 8b 75 a0          	mov    rsi,QWORD PTR [rbp-0x60]
    2a48:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2a4c:	48 89 c7             	mov    rdi,rax
    2a4f:	e8 00 00 00 00       	call   2a54 <snprintf+0x4f>
    2a54:	89 45 cc             	mov    DWORD PTR [rbp-0x34],eax
		va_end(args);
		return rv;
    2a57:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
}
    2a5a:	c9                   	leave
    2a5b:	c3                   	ret

0000000000002a5c <printf>:

int printf(const char* fmt, ...)
{
    2a5c:	55                   	push   rbp
    2a5d:	48 89 e5             	mov    rbp,rsp
    2a60:	48 83 ec 60          	sub    rsp,0x60
    2a64:	48 89 7d a8          	mov    QWORD PTR [rbp-0x58],rdi
    2a68:	48 89 75 d8          	mov    QWORD PTR [rbp-0x28],rsi
    2a6c:	48 89 55 e0          	mov    QWORD PTR [rbp-0x20],rdx
    2a70:	48 89 4d e8          	mov    QWORD PTR [rbp-0x18],rcx
    2a74:	4c 89 45 f0          	mov    QWORD PTR [rbp-0x10],r8
    2a78:	4c 89 4d f8          	mov    QWORD PTR [rbp-0x8],r9
		int rv;
		va_list args;
		va_start(args, fmt);
    2a7c:	c7 45 b0 08 00 00 00 	mov    DWORD PTR [rbp-0x50],0x8
    2a83:	48 8d 45 10          	lea    rax,[rbp+0x10]
    2a87:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
    2a8b:	48 8d 45 d0          	lea    rax,[rbp-0x30]
    2a8f:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
		rv = vprintf(fmt, args);
    2a93:	48 8d 55 b0          	lea    rdx,[rbp-0x50]
    2a97:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2a9b:	48 89 d6             	mov    rsi,rdx
    2a9e:	48 89 c7             	mov    rdi,rax
    2aa1:	e8 00 00 00 00       	call   2aa6 <printf+0x4a>
    2aa6:	89 45 cc             	mov    DWORD PTR [rbp-0x34],eax
		va_end(args);
		return rv;
    2aa9:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
}
    2aac:	c9                   	leave
    2aad:	c3                   	ret

0000000000002aae <iprintf>:
/* no delay intr version */
int iprintf(const char* fmt, ...)
{
    2aae:	55                   	push   rbp
    2aaf:	48 89 e5             	mov    rbp,rsp
    2ab2:	48 83 ec 60          	sub    rsp,0x60
    2ab6:	48 89 7d a8          	mov    QWORD PTR [rbp-0x58],rdi
    2aba:	48 89 75 d8          	mov    QWORD PTR [rbp-0x28],rsi
    2abe:	48 89 55 e0          	mov    QWORD PTR [rbp-0x20],rdx
    2ac2:	48 89 4d e8          	mov    QWORD PTR [rbp-0x18],rcx
    2ac6:	4c 89 45 f0          	mov    QWORD PTR [rbp-0x10],r8
    2aca:	4c 89 4d f8          	mov    QWORD PTR [rbp-0x8],r9
		int rv;
		va_list args;
		va_start(args, fmt);
    2ace:	c7 45 b0 08 00 00 00 	mov    DWORD PTR [rbp-0x50],0x8
    2ad5:	48 8d 45 10          	lea    rax,[rbp+0x10]
    2ad9:	48 89 45 b8          	mov    QWORD PTR [rbp-0x48],rax
    2add:	48 8d 45 d0          	lea    rax,[rbp-0x30]
    2ae1:	48 89 45 c0          	mov    QWORD PTR [rbp-0x40],rax
		reg_def.flags |= KIO_REGION_NO_DELAY;
    2ae5:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2aec <iprintf+0x3e>
    2aec:	83 c8 01             	or     eax,0x1
    2aef:	88 05 00 00 00 00    	mov    BYTE PTR [rip+0x0],al        # 2af5 <iprintf+0x47>
		rv = vprintf(fmt, args);
    2af5:	48 8d 55 b0          	lea    rdx,[rbp-0x50]
    2af9:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2afd:	48 89 d6             	mov    rsi,rdx
    2b00:	48 89 c7             	mov    rdi,rax
    2b03:	e8 00 00 00 00       	call   2b08 <iprintf+0x5a>
    2b08:	89 45 cc             	mov    DWORD PTR [rbp-0x34],eax
		reg_def.flags &= ~KIO_REGION_NO_DELAY;
    2b0b:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 2b12 <iprintf+0x64>
    2b12:	83 e0 fe             	and    eax,0xfffffffe
    2b15:	88 05 00 00 00 00    	mov    BYTE PTR [rip+0x0],al        # 2b1b <iprintf+0x6d>
		va_end(args);
		return rv;
    2b1b:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
}
    2b1e:	c9                   	leave
    2b1f:	c3                   	ret

0000000000002b20 <noprintf>:
int noprintf(const char* c, ...) { (void)c; return 0; }
    2b20:	55                   	push   rbp
    2b21:	48 89 e5             	mov    rbp,rsp
    2b24:	48 83 ec 38          	sub    rsp,0x38
    2b28:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
    2b2c:	48 89 75 d8          	mov    QWORD PTR [rbp-0x28],rsi
    2b30:	48 89 55 e0          	mov    QWORD PTR [rbp-0x20],rdx
    2b34:	48 89 4d e8          	mov    QWORD PTR [rbp-0x18],rcx
    2b38:	4c 89 45 f0          	mov    QWORD PTR [rbp-0x10],r8
    2b3c:	4c 89 4d f8          	mov    QWORD PTR [rbp-0x8],r9
    2b40:	b8 00 00 00 00       	mov    eax,0x0
    2b45:	c9                   	leave
    2b46:	c3                   	ret

0000000000002b47 <memdump>:

void memdump(void* ofs, size_t sz)
{
    2b47:	55                   	push   rbp
    2b48:	48 89 e5             	mov    rbp,rsp
    2b4b:	48 83 ec 40          	sub    rsp,0x40
    2b4f:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
    2b53:	48 89 75 c0          	mov    QWORD PTR [rbp-0x40],rsi
		size_t i, ct;

		printf("dumping memory at %p with size %u:\n", ofs, sz);
    2b57:	48 8b 55 c0          	mov    rdx,QWORD PTR [rbp-0x40]
    2b5b:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    2b5f:	48 89 c6             	mov    rsi,rax
    2b62:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2b69:	b8 00 00 00 00       	mov    eax,0x0
    2b6e:	e8 00 00 00 00       	call   2b73 <memdump+0x2c>
		for (i = 0; i < sz; i += 16) {
    2b73:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
    2b7b:	e9 7a 01 00 00       	jmp    2cfa <memdump+0x1b3>
				uint16_t* mem = (uint16_t*)(ofs + i);
    2b80:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    2b84:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2b88:	48 01 d0             	add    rax,rdx
    2b8b:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
				uint8_t nbl = 41; /* 41 blanks until text output */
    2b8f:	c6 45 ef 29          	mov    BYTE PTR [rbp-0x11],0x29
				/* xxd-style output: 8 words and text */
				for (ct = 0; ct < 8; ct++) {
    2b93:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
    2b9b:	e9 b8 00 00 00       	jmp    2c58 <memdump+0x111>
						if (i + 2 * ct <= sz - 2) {
    2ba0:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2ba4:	48 8d 14 00          	lea    rdx,[rax+rax*1]
    2ba8:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2bac:	48 01 d0             	add    rax,rdx
    2baf:	48 8b 55 c0          	mov    rdx,QWORD PTR [rbp-0x40]
    2bb3:	48 83 ea 02          	sub    rdx,0x2
    2bb7:	48 39 c2             	cmp    rdx,rax
    2bba:	72 4f                	jb     2c0b <memdump+0xc4>
								printf("%04x ", ((mem[ct] << 8) & 0xff00) | (mem[ct] >> 8));
    2bbc:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2bc0:	48 8d 14 00          	lea    rdx,[rax+rax*1]
    2bc4:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    2bc8:	48 01 d0             	add    rax,rdx
    2bcb:	0f b7 00             	movzx  eax,WORD PTR [rax]
    2bce:	0f b7 c0             	movzx  eax,ax
    2bd1:	c1 e0 08             	shl    eax,0x8
    2bd4:	0f b7 d0             	movzx  edx,ax
    2bd7:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2bdb:	48 8d 0c 00          	lea    rcx,[rax+rax*1]
    2bdf:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    2be3:	48 01 c8             	add    rax,rcx
    2be6:	0f b7 00             	movzx  eax,WORD PTR [rax]
    2be9:	66 c1 e8 08          	shr    ax,0x8
    2bed:	0f b7 c0             	movzx  eax,ax
    2bf0:	09 d0                	or     eax,edx
    2bf2:	89 c6                	mov    esi,eax
    2bf4:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2bfb:	b8 00 00 00 00       	mov    eax,0x0
    2c00:	e8 00 00 00 00       	call   2c05 <memdump+0xbe>
								nbl -= 5;
    2c05:	80 6d ef 05          	sub    BYTE PTR [rbp-0x11],0x5
    2c09:	eb 48                	jmp    2c53 <memdump+0x10c>
						} else if (i + 2 * ct == sz - 1) { /* ending on half word */
    2c0b:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2c0f:	48 8d 14 00          	lea    rdx,[rax+rax*1]
    2c13:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2c17:	48 01 c2             	add    rdx,rax
    2c1a:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2c1e:	48 83 e8 01          	sub    rax,0x1
    2c22:	48 39 c2             	cmp    rdx,rax
    2c25:	75 3e                	jne    2c65 <memdump+0x11e>
								printf("%02x   ", *(uint8_t*)(mem + ct));
    2c27:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2c2b:	48 8d 14 00          	lea    rdx,[rax+rax*1]
    2c2f:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    2c33:	48 01 d0             	add    rax,rdx
    2c36:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    2c39:	0f b6 c0             	movzx  eax,al
    2c3c:	89 c6                	mov    esi,eax
    2c3e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2c45:	b8 00 00 00 00       	mov    eax,0x0
    2c4a:	e8 00 00 00 00       	call   2c4f <memdump+0x108>
								nbl -= 5;
    2c4f:	80 6d ef 05          	sub    BYTE PTR [rbp-0x11],0x5
				for (ct = 0; ct < 8; ct++) {
    2c53:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
    2c58:	48 83 7d f0 07       	cmp    QWORD PTR [rbp-0x10],0x7
    2c5d:	0f 86 3d ff ff ff    	jbe    2ba0 <memdump+0x59>
    2c63:	eb 0d                	jmp    2c72 <memdump+0x12b>
						} else
								break;
    2c65:	90                   	nop
				}
				/* fill with blanks */
				while (nbl--)
    2c66:	eb 0a                	jmp    2c72 <memdump+0x12b>
						putchar(' ');
    2c68:	bf 20 00 00 00       	mov    edi,0x20
    2c6d:	e8 00 00 00 00       	call   2c72 <memdump+0x12b>
				while (nbl--)
    2c72:	0f b6 45 ef          	movzx  eax,BYTE PTR [rbp-0x11]
    2c76:	8d 50 ff             	lea    edx,[rax-0x1]
    2c79:	88 55 ef             	mov    BYTE PTR [rbp-0x11],dl
    2c7c:	84 c0                	test   al,al
    2c7e:	75 e8                	jne    2c68 <memdump+0x121>
				/* output the text */
				for (ct = 0; ct < 16; ct++) {
    2c80:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
    2c88:	eb 57                	jmp    2ce1 <memdump+0x19a>
						char* c = (char*)mem + ct;
    2c8a:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    2c8e:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2c92:	48 01 d0             	add    rax,rdx
    2c95:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
						if (i + ct >= sz)
    2c99:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    2c9d:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2ca1:	48 01 d0             	add    rax,rdx
    2ca4:	48 3b 45 c0          	cmp    rax,QWORD PTR [rbp-0x40]
    2ca8:	73 40                	jae    2cea <memdump+0x1a3>
								break;
						if (isprint(*c))
    2caa:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2cae:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    2cb1:	0f be c0             	movsx  eax,al
    2cb4:	89 c7                	mov    edi,eax
    2cb6:	e8 00 00 00 00       	call   2cbb <memdump+0x174>
    2cbb:	85 c0                	test   eax,eax
    2cbd:	74 13                	je     2cd2 <memdump+0x18b>
								putchar(*c);
    2cbf:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2cc3:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    2cc6:	0f be c0             	movsx  eax,al
    2cc9:	89 c7                	mov    edi,eax
    2ccb:	e8 00 00 00 00       	call   2cd0 <memdump+0x189>
    2cd0:	eb 0a                	jmp    2cdc <memdump+0x195>
						else
								putchar('.');
    2cd2:	bf 2e 00 00 00       	mov    edi,0x2e
    2cd7:	e8 00 00 00 00       	call   2cdc <memdump+0x195>
				for (ct = 0; ct < 16; ct++) {
    2cdc:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
    2ce1:	48 83 7d f0 0f       	cmp    QWORD PTR [rbp-0x10],0xf
    2ce6:	76 a2                	jbe    2c8a <memdump+0x143>
    2ce8:	eb 01                	jmp    2ceb <memdump+0x1a4>
								break;
    2cea:	90                   	nop
				}
				putchar('\n');
    2ceb:	bf 0a 00 00 00       	mov    edi,0xa
    2cf0:	e8 00 00 00 00       	call   2cf5 <memdump+0x1ae>
		for (i = 0; i < sz; i += 16) {
    2cf5:	48 83 45 f8 10       	add    QWORD PTR [rbp-0x8],0x10
    2cfa:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2cfe:	48 3b 45 c0          	cmp    rax,QWORD PTR [rbp-0x40]
    2d02:	0f 82 78 fe ff ff    	jb     2b80 <memdump+0x39>
		}
}
    2d08:	90                   	nop
    2d09:	90                   	nop
    2d0a:	c9                   	leave
    2d0b:	c3                   	ret
