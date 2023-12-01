
kio.o64:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <memcpy>:
				unsigned int bt = (arg & 0x80000000);
				rv++;
				if (bt) {
						nonz = 1;
						ctx->putchar(ctx, '1');
				} else if (nonz)
       0:	55                   	push   rbp
       1:	48 89 e5             	mov    rbp,rsp
       4:	48 83 ec 28          	sub    rsp,0x28
       8:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
       c:	48 89 75 e0          	mov    QWORD PTR [rbp-0x20],rsi
      10:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
						ctx->putchar(ctx, '0');
      14:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
      18:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
				else if ((32 - i) <= prec) /* has precedence over with */
      1c:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
      20:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
						ctx->putchar(ctx, '0');
      24:	eb 1d                	jmp    43 <memcpy+0x43>
				else if ((32 - i) <= width)
      26:	48 8b 55 f0          	mov    rdx,QWORD PTR [rbp-0x10]
      2a:	48 8d 42 01          	lea    rax,[rdx+0x1]
      2e:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
      32:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
      36:	48 8d 48 01          	lea    rcx,[rax+0x1]
      3a:	48 89 4d f8          	mov    QWORD PTR [rbp-0x8],rcx
      3e:	0f b6 12             	movzx  edx,BYTE PTR [rdx]
      41:	88 10                	mov    BYTE PTR [rax],dl
						ctx->putchar(ctx, '0');
      43:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
      47:	48 8d 50 ff          	lea    rdx,[rax-0x1]
      4b:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
      4f:	48 85 c0             	test   rax,rax
      52:	75 d2                	jne    26 <memcpy+0x26>
						ctx->putchar(ctx, flags & KFL_ZERO_PREFIX ? '0' : ' ');
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
     224:	66 89 45 d0          	mov    WORD PTR [rbp-0x30],ax
						r.y = y;
     228:	0f b7 45 bc          	movzx  eax,WORD PTR [rbp-0x44]
     22c:	66 89 45 d2          	mov    WORD PTR [rbp-0x2e],ax
						r.lx = 1;
     230:	66 c7 45 d4 01 00    	mov    WORD PTR [rbp-0x2c],0x1
						r.ly = 1;
     236:	66 c7 45 d6 01 00    	mov    WORD PTR [rbp-0x2a],0x1
						r.fmt = cr->fmt;
     23c:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
     240:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
     244:	88 45 dc             	mov    BYTE PTR [rbp-0x24],al
						framebuffer_update_region(&fb_initial, &r);
     247:	48 8d 45 d0          	lea    rax,[rbp-0x30]
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
     356:	66 89 45 e2          	mov    WORD PTR [rbp-0x1e],ax
		r.x = cr->x;
     35a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     35e:	0f b7 00             	movzx  eax,WORD PTR [rax]
     361:	66 89 45 e0          	mov    WORD PTR [rbp-0x20],ax
		r.ly = 1;
     365:	66 c7 45 e6 01 00    	mov    WORD PTR [rbp-0x1a],0x1
		r.lx = cr->lx;
     36b:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     36f:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
     373:	66 89 45 e4          	mov    WORD PTR [rbp-0x1c],ax
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
     38e:	0f b7 55 e2          	movzx  edx,WORD PTR [rbp-0x1e]
     392:	0f bf ca             	movsx  ecx,dx
     395:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 39b <scroll_left+0x65>
     39b:	0f af d1             	imul   edx,ecx
     39e:	01 d2                	add    edx,edx
     3a0:	48 63 ca             	movsxd rcx,edx
     3a3:	0f b7 55 e0          	movzx  edx,WORD PTR [rbp-0x20]
     3a7:	0f bf d2             	movsx  edx,dx
     3aa:	01 d2                	add    edx,edx
     3ac:	48 63 d2             	movsxd rdx,edx
     3af:	48 01 ca             	add    rdx,rcx
     3b2:	48 83 c2 02          	add    rdx,0x2
		memcpy((char*)fb_initial.text_mem + r.y * fb_initial.width * 2 + r.x * 2,
     3b6:	48 01 d6             	add    rsi,rdx
     3b9:	48 8b 3d 00 00 00 00 	mov    rdi,QWORD PTR [rip+0x0]        # 3c0 <scroll_left+0x8a>
     3c0:	0f b7 55 e2          	movzx  edx,WORD PTR [rbp-0x1e]
     3c4:	0f bf ca             	movsx  ecx,dx
     3c7:	8b 15 00 00 00 00    	mov    edx,DWORD PTR [rip+0x0]        # 3cd <scroll_left+0x97>
     3cd:	0f af d1             	imul   edx,ecx
     3d0:	01 d2                	add    edx,edx
     3d2:	48 63 ca             	movsxd rcx,edx
     3d5:	0f b7 55 e0          	movzx  edx,WORD PTR [rbp-0x20]
     3d9:	0f bf d2             	movsx  edx,dx
     3dc:	01 d2                	add    edx,edx
     3de:	48 63 d2             	movsxd rdx,edx
     3e1:	48 01 ca             	add    rdx,rcx
     3e4:	48 8d 0c 17          	lea    rcx,[rdi+rdx*1]
     3e8:	48 89 c2             	mov    rdx,rax
     3eb:	48 89 cf             	mov    rdi,rcx
     3ee:	e8 0d fc ff ff       	call   0 <memcpy>
		framebuffer_update_region(&fb_initial, &r);
     3f3:	48 8d 45 e0          	lea    rax,[rbp-0x20]
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
     99a:	66 89 45 e0          	mov    WORD PTR [rbp-0x20],ax
				r.y = cr->y + cr->cur_y;
     99e:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     9a2:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
     9a6:	89 c2                	mov    edx,eax
     9a8:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     9ac:	0f b7 40 10          	movzx  eax,WORD PTR [rax+0x10]
     9b0:	01 d0                	add    eax,edx
     9b2:	66 89 45 e2          	mov    WORD PTR [rbp-0x1e],ax
				r.ly = 1;
     9b6:	66 c7 45 e6 01 00    	mov    WORD PTR [rbp-0x1a],0x1
				r.lx = cr->lx - cr->cur_x;
     9bc:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     9c0:	0f b7 40 04          	movzx  eax,WORD PTR [rax+0x4]
     9c4:	89 c2                	mov    edx,eax
     9c6:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
     9ca:	0f b7 40 0e          	movzx  eax,WORD PTR [rax+0xe]
     9ce:	89 c1                	mov    ecx,eax
     9d0:	89 d0                	mov    eax,edx
     9d2:	29 c8                	sub    eax,ecx
     9d4:	66 89 45 e4          	mov    WORD PTR [rbp-0x1c],ax
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
     a62:	48 8d 45 e0          	lea    rax,[rbp-0x20]
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
				else
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
    1790:	e9 b4 09 00 00       	jmp    2149 <internal_vprintf+0x9f8>
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
    17ed:	e9 57 09 00 00       	jmp    2149 <internal_vprintf+0x9f8>
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
    188b:	e9 b9 08 00 00       	jmp    2149 <internal_vprintf+0x9f8>
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
    190d:	e9 37 08 00 00       	jmp    2149 <internal_vprintf+0x9f8>
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
    192c:	e9 18 08 00 00       	jmp    2149 <internal_vprintf+0x9f8>
							} else if (is_fmt && *fmt == '*') {
    1931:	80 7d ff 00          	cmp    BYTE PTR [rbp-0x1],0x0
    1935:	74 41                	je     1978 <internal_vprintf+0x227>
    1937:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    193b:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    193e:	3c 2a                	cmp    al,0x2a
    1940:	75 36                	jne    1978 <internal_vprintf+0x227>
									if (is_fmt == 2)
    1942:	80 7d ff 02          	cmp    BYTE PTR [rbp-0x1],0x2
    1946:	75 14                	jne    195c <internal_vprintf+0x20b>
											prec = va_arg(args, int);
    1948:	48 83 45 a8 04       	add    QWORD PTR [rbp-0x58],0x4
    194d:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1951:	48 83 e8 04          	sub    rax,0x4
    1955:	8b 00                	mov    eax,DWORD PTR [rax]
    1957:	88 45 fc             	mov    BYTE PTR [rbp-0x4],al
    195a:	eb 12                	jmp    196e <internal_vprintf+0x21d>
											width = va_arg(args, int);
    195c:	48 83 45 a8 04       	add    QWORD PTR [rbp-0x58],0x4
    1961:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1965:	48 83 e8 04          	sub    rax,0x4
    1969:	8b 00                	mov    eax,DWORD PTR [rax]
    196b:	88 45 fd             	mov    BYTE PTR [rbp-0x3],al
									fmt++;
    196e:	48 83 45 b0 01       	add    QWORD PTR [rbp-0x50],0x1
    1973:	e9 d1 07 00 00       	jmp    2149 <internal_vprintf+0x9f8>
							} else if (is_fmt) {
    1978:	80 7d ff 00          	cmp    BYTE PTR [rbp-0x1],0x0
    197c:	0f 84 9e 07 00 00    	je     2120 <internal_vprintf+0x9cf>
									if (is_fmt == 2 && !prec)
    1982:	80 7d ff 02          	cmp    BYTE PTR [rbp-0x1],0x2
    1986:	75 0a                	jne    1992 <internal_vprintf+0x241>
    1988:	80 7d fc 00          	cmp    BYTE PTR [rbp-0x4],0x0
    198c:	75 04                	jne    1992 <internal_vprintf+0x241>
											prec = -1; /* no zero */
    198e:	c6 45 fc ff          	mov    BYTE PTR [rbp-0x4],0xff
									if (*fmt == 'h') {
    1992:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1996:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1999:	3c 68                	cmp    al,0x68
    199b:	75 27                	jne    19c4 <internal_vprintf+0x273>
											fmt++;
    199d:	48 83 45 b0 01       	add    QWORD PTR [rbp-0x50],0x1
											if (*fmt == 'h') {
    19a2:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    19a6:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    19a9:	3c 68                	cmp    al,0x68
    19ab:	75 0e                	jne    19bb <internal_vprintf+0x26a>
													size = 1; /* hh */
    19ad:	c6 45 fb 01          	mov    BYTE PTR [rbp-0x5],0x1
													fmt++;
    19b1:	48 83 45 b0 01       	add    QWORD PTR [rbp-0x50],0x1
    19b6:	e9 8b 00 00 00       	jmp    1a46 <internal_vprintf+0x2f5>
													size = 2; /* h */
    19bb:	c6 45 fb 02          	mov    BYTE PTR [rbp-0x5],0x2
    19bf:	e9 82 00 00 00       	jmp    1a46 <internal_vprintf+0x2f5>
									} else if (*fmt == 'l') {
    19c4:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    19c8:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    19cb:	3c 6c                	cmp    al,0x6c
    19cd:	75 21                	jne    19f0 <internal_vprintf+0x29f>
											fmt++;
    19cf:	48 83 45 b0 01       	add    QWORD PTR [rbp-0x50],0x1
											if (*fmt == 'l') {
    19d4:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    19d8:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    19db:	3c 6c                	cmp    al,0x6c
    19dd:	75 0b                	jne    19ea <internal_vprintf+0x299>
													size = 4; /* ll */
    19df:	c6 45 fb 04          	mov    BYTE PTR [rbp-0x5],0x4
													fmt++;
    19e3:	48 83 45 b0 01       	add    QWORD PTR [rbp-0x50],0x1
    19e8:	eb 5c                	jmp    1a46 <internal_vprintf+0x2f5>
													size = 3;
    19ea:	c6 45 fb 03          	mov    BYTE PTR [rbp-0x5],0x3
    19ee:	eb 56                	jmp    1a46 <internal_vprintf+0x2f5>
									} else if (*fmt == 'j') {
    19f0:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    19f4:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    19f7:	3c 6a                	cmp    al,0x6a
    19f9:	75 0b                	jne    1a06 <internal_vprintf+0x2b5>
											fmt++;
    19fb:	48 83 45 b0 01       	add    QWORD PTR [rbp-0x50],0x1
											size = 5;
    1a00:	c6 45 fb 05          	mov    BYTE PTR [rbp-0x5],0x5
    1a04:	eb 40                	jmp    1a46 <internal_vprintf+0x2f5>
									} else if (*fmt == 'z') {
    1a06:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1a0a:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1a0d:	3c 7a                	cmp    al,0x7a
    1a0f:	75 0b                	jne    1a1c <internal_vprintf+0x2cb>
											size = 6;
    1a11:	c6 45 fb 06          	mov    BYTE PTR [rbp-0x5],0x6
											fmt++;
    1a15:	48 83 45 b0 01       	add    QWORD PTR [rbp-0x50],0x1
    1a1a:	eb 2a                	jmp    1a46 <internal_vprintf+0x2f5>
									} else if (*fmt == 't') {
    1a1c:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1a20:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1a23:	3c 74                	cmp    al,0x74
    1a25:	75 0b                	jne    1a32 <internal_vprintf+0x2e1>
											size = 7;
    1a27:	c6 45 fb 07          	mov    BYTE PTR [rbp-0x5],0x7
											fmt++;
    1a2b:	48 83 45 b0 01       	add    QWORD PTR [rbp-0x50],0x1
    1a30:	eb 14                	jmp    1a46 <internal_vprintf+0x2f5>
									} else if (*fmt == 'L') {
    1a32:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1a36:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1a39:	3c 4c                	cmp    al,0x4c
    1a3b:	75 09                	jne    1a46 <internal_vprintf+0x2f5>
											size = 8;
    1a3d:	c6 45 fb 08          	mov    BYTE PTR [rbp-0x5],0x8
											fmt++;
    1a41:	48 83 45 b0 01       	add    QWORD PTR [rbp-0x50],0x1
									if (*fmt == 'd' || *fmt == 'i') {
    1a46:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1a4a:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1a4d:	3c 64                	cmp    al,0x64
    1a4f:	74 0f                	je     1a60 <internal_vprintf+0x30f>
    1a51:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1a55:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1a58:	3c 69                	cmp    al,0x69
    1a5a:	0f 85 21 01 00 00    	jne    1b81 <internal_vprintf+0x430>
											signed long long int val = 0;
    1a60:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
											if (!size) val = va_arg(args, signed int);
    1a68:	80 7d fb 00          	cmp    BYTE PTR [rbp-0x5],0x0
    1a6c:	75 1a                	jne    1a88 <internal_vprintf+0x337>
    1a6e:	48 83 45 a8 04       	add    QWORD PTR [rbp-0x58],0x4
    1a73:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1a77:	48 83 e8 04          	sub    rax,0x4
    1a7b:	8b 00                	mov    eax,DWORD PTR [rax]
    1a7d:	48 98                	cdqe
    1a7f:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1a83:	e9 d2 00 00 00       	jmp    1b5a <internal_vprintf+0x409>
											else if (size == 1) val = va_arg(args, signed char);
    1a88:	80 7d fb 01          	cmp    BYTE PTR [rbp-0x5],0x1
    1a8c:	75 1d                	jne    1aab <internal_vprintf+0x35a>
    1a8e:	48 83 45 a8 04       	add    QWORD PTR [rbp-0x58],0x4
    1a93:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1a97:	48 83 e8 04          	sub    rax,0x4
    1a9b:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1a9e:	48 0f be c0          	movsx  rax,al
    1aa2:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1aa6:	e9 af 00 00 00       	jmp    1b5a <internal_vprintf+0x409>
											else if (size == 2) val = va_arg(args, signed short int);
    1aab:	80 7d fb 02          	cmp    BYTE PTR [rbp-0x5],0x2
    1aaf:	75 1d                	jne    1ace <internal_vprintf+0x37d>
    1ab1:	48 83 45 a8 04       	add    QWORD PTR [rbp-0x58],0x4
    1ab6:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1aba:	48 83 e8 04          	sub    rax,0x4
    1abe:	0f b7 00             	movzx  eax,WORD PTR [rax]
    1ac1:	48 0f bf c0          	movsx  rax,ax
    1ac5:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1ac9:	e9 8c 00 00 00       	jmp    1b5a <internal_vprintf+0x409>
											else if (size == 3) val = va_arg(args, signed long int);
    1ace:	80 7d fb 03          	cmp    BYTE PTR [rbp-0x5],0x3
    1ad2:	75 16                	jne    1aea <internal_vprintf+0x399>
    1ad4:	48 83 45 a8 08       	add    QWORD PTR [rbp-0x58],0x8
    1ad9:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1add:	48 83 e8 08          	sub    rax,0x8
    1ae1:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1ae4:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1ae8:	eb 70                	jmp    1b5a <internal_vprintf+0x409>
											else if (size == 4) val = va_arg(args, signed long long int);
    1aea:	80 7d fb 04          	cmp    BYTE PTR [rbp-0x5],0x4
    1aee:	75 13                	jne    1b03 <internal_vprintf+0x3b2>
    1af0:	48 83 45 a8 08       	add    QWORD PTR [rbp-0x58],0x8
    1af5:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1af9:	48 8b 40 f8          	mov    rax,QWORD PTR [rax-0x8]
    1afd:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1b01:	eb 57                	jmp    1b5a <internal_vprintf+0x409>
											else if (size == 5) val = va_arg(args, intmax_t);
    1b03:	80 7d fb 05          	cmp    BYTE PTR [rbp-0x5],0x5
    1b07:	75 13                	jne    1b1c <internal_vprintf+0x3cb>
    1b09:	48 83 45 a8 08       	add    QWORD PTR [rbp-0x58],0x8
    1b0e:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1b12:	48 8b 40 f8          	mov    rax,QWORD PTR [rax-0x8]
    1b16:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1b1a:	eb 3e                	jmp    1b5a <internal_vprintf+0x409>
											else if (size == 6) val = va_arg(args, ssize_t);
    1b1c:	80 7d fb 06          	cmp    BYTE PTR [rbp-0x5],0x6
    1b20:	75 17                	jne    1b39 <internal_vprintf+0x3e8>
    1b22:	48 83 45 a8 04       	add    QWORD PTR [rbp-0x58],0x4
    1b27:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1b2b:	48 83 e8 04          	sub    rax,0x4
    1b2f:	8b 00                	mov    eax,DWORD PTR [rax]
    1b31:	48 98                	cdqe
    1b33:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1b37:	eb 21                	jmp    1b5a <internal_vprintf+0x409>
											else if (size == 7) val = va_arg(args, ptrdiff_t);
    1b39:	80 7d fb 07          	cmp    BYTE PTR [rbp-0x5],0x7
    1b3d:	75 16                	jne    1b55 <internal_vprintf+0x404>
    1b3f:	48 83 45 a8 08       	add    QWORD PTR [rbp-0x58],0x8
    1b44:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1b48:	48 83 e8 08          	sub    rax,0x8
    1b4c:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1b4f:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    1b53:	eb 05                	jmp    1b5a <internal_vprintf+0x409>
											else (void)va_arg(args, long double); /* remove bogus value*/
    1b55:	48 83 45 a8 10       	add    QWORD PTR [rbp-0x58],0x10
											rv += putd(ctx, val, flags, width, prec);
    1b5a:	0f be 7d fc          	movsx  edi,BYTE PTR [rbp-0x4]
    1b5e:	0f be 4d fd          	movsx  ecx,BYTE PTR [rbp-0x3]
    1b62:	0f be 55 fe          	movsx  edx,BYTE PTR [rbp-0x2]
    1b66:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1b6a:	48 8b 75 e8          	mov    rsi,QWORD PTR [rbp-0x18]
    1b6e:	41 89 f8             	mov    r8d,edi
    1b71:	48 89 c7             	mov    rdi,rax
    1b74:	e8 00 00 00 00       	call   1b79 <internal_vprintf+0x428>
    1b79:	01 45 f4             	add    DWORD PTR [rbp-0xc],eax
									if (*fmt == 'd' || *fmt == 'i') {
    1b7c:	e9 84 05 00 00       	jmp    2105 <internal_vprintf+0x9b4>
									} else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'u' || *fmt == 'o' || *fmt == 'b') {
    1b81:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1b85:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1b88:	3c 78                	cmp    al,0x78
    1b8a:	74 30                	je     1bbc <internal_vprintf+0x46b>
    1b8c:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1b90:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1b93:	3c 58                	cmp    al,0x58
    1b95:	74 25                	je     1bbc <internal_vprintf+0x46b>
    1b97:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1b9b:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1b9e:	3c 75                	cmp    al,0x75
    1ba0:	74 1a                	je     1bbc <internal_vprintf+0x46b>
    1ba2:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1ba6:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1ba9:	3c 6f                	cmp    al,0x6f
    1bab:	74 0f                	je     1bbc <internal_vprintf+0x46b>
    1bad:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1bb1:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1bb4:	3c 62                	cmp    al,0x62
    1bb6:	0f 85 0b 02 00 00    	jne    1dc7 <internal_vprintf+0x676>
											unsigned long long int val = 0;
    1bbc:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
											if (!size) val = va_arg(args, unsigned int);
    1bc4:	80 7d fb 00          	cmp    BYTE PTR [rbp-0x5],0x0
    1bc8:	75 1a                	jne    1be4 <internal_vprintf+0x493>
    1bca:	48 83 45 a8 04       	add    QWORD PTR [rbp-0x58],0x4
    1bcf:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1bd3:	48 83 e8 04          	sub    rax,0x4
    1bd7:	8b 00                	mov    eax,DWORD PTR [rax]
    1bd9:	89 c0                	mov    eax,eax
    1bdb:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    1bdf:	e9 cf 00 00 00       	jmp    1cb3 <internal_vprintf+0x562>
											else if (size == 1) val = va_arg(args, unsigned char);
    1be4:	80 7d fb 01          	cmp    BYTE PTR [rbp-0x5],0x1
    1be8:	75 1c                	jne    1c06 <internal_vprintf+0x4b5>
    1bea:	48 83 45 a8 04       	add    QWORD PTR [rbp-0x58],0x4
    1bef:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1bf3:	48 83 e8 04          	sub    rax,0x4
    1bf7:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1bfa:	0f b6 c0             	movzx  eax,al
    1bfd:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    1c01:	e9 ad 00 00 00       	jmp    1cb3 <internal_vprintf+0x562>
											else if (size == 2) val = va_arg(args, unsigned short int);
    1c06:	80 7d fb 02          	cmp    BYTE PTR [rbp-0x5],0x2
    1c0a:	75 1c                	jne    1c28 <internal_vprintf+0x4d7>
    1c0c:	48 83 45 a8 04       	add    QWORD PTR [rbp-0x58],0x4
    1c11:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1c15:	48 83 e8 04          	sub    rax,0x4
    1c19:	0f b7 00             	movzx  eax,WORD PTR [rax]
    1c1c:	0f b7 c0             	movzx  eax,ax
    1c1f:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    1c23:	e9 8b 00 00 00       	jmp    1cb3 <internal_vprintf+0x562>
											else if (size == 3) val = va_arg(args, unsigned long int);
    1c28:	80 7d fb 03          	cmp    BYTE PTR [rbp-0x5],0x3
    1c2c:	75 16                	jne    1c44 <internal_vprintf+0x4f3>
    1c2e:	48 83 45 a8 08       	add    QWORD PTR [rbp-0x58],0x8
    1c33:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1c37:	48 83 e8 08          	sub    rax,0x8
    1c3b:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1c3e:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    1c42:	eb 6f                	jmp    1cb3 <internal_vprintf+0x562>
											else if (size == 4) val = va_arg(args, unsigned long long int);
    1c44:	80 7d fb 04          	cmp    BYTE PTR [rbp-0x5],0x4
    1c48:	75 13                	jne    1c5d <internal_vprintf+0x50c>
    1c4a:	48 83 45 a8 08       	add    QWORD PTR [rbp-0x58],0x8
    1c4f:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1c53:	48 8b 40 f8          	mov    rax,QWORD PTR [rax-0x8]
    1c57:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    1c5b:	eb 56                	jmp    1cb3 <internal_vprintf+0x562>
											else if (size == 5) val = va_arg(args, uintmax_t);
    1c5d:	80 7d fb 05          	cmp    BYTE PTR [rbp-0x5],0x5
    1c61:	75 13                	jne    1c76 <internal_vprintf+0x525>
    1c63:	48 83 45 a8 08       	add    QWORD PTR [rbp-0x58],0x8
    1c68:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1c6c:	48 8b 40 f8          	mov    rax,QWORD PTR [rax-0x8]
    1c70:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    1c74:	eb 3d                	jmp    1cb3 <internal_vprintf+0x562>
											else if (size == 6) val = va_arg(args, size_t);
    1c76:	80 7d fb 06          	cmp    BYTE PTR [rbp-0x5],0x6
    1c7a:	75 16                	jne    1c92 <internal_vprintf+0x541>
    1c7c:	48 83 45 a8 08       	add    QWORD PTR [rbp-0x58],0x8
    1c81:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1c85:	48 83 e8 08          	sub    rax,0x8
    1c89:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1c8c:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    1c90:	eb 21                	jmp    1cb3 <internal_vprintf+0x562>
											else if (size == 7) val = va_arg(args, ptrdiff_t);
    1c92:	80 7d fb 07          	cmp    BYTE PTR [rbp-0x5],0x7
    1c96:	75 16                	jne    1cae <internal_vprintf+0x55d>
    1c98:	48 83 45 a8 08       	add    QWORD PTR [rbp-0x58],0x8
    1c9d:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1ca1:	48 83 e8 08          	sub    rax,0x8
    1ca5:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1ca8:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    1cac:	eb 05                	jmp    1cb3 <internal_vprintf+0x562>
											else (void)va_arg(args, long double); /* remove bogus value*/
    1cae:	48 83 45 a8 10       	add    QWORD PTR [rbp-0x58],0x10
											if (*fmt == 'x')
    1cb3:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1cb7:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1cba:	3c 78                	cmp    al,0x78
    1cbc:	75 2d                	jne    1ceb <internal_vprintf+0x59a>
													rv += putu(ctx, val, flags | KFL_IS_HEX, width, prec);
    1cbe:	0f be 7d fc          	movsx  edi,BYTE PTR [rbp-0x4]
    1cc2:	0f be 4d fd          	movsx  ecx,BYTE PTR [rbp-0x3]
    1cc6:	0f b6 45 fe          	movzx  eax,BYTE PTR [rbp-0x2]
    1cca:	83 c8 01             	or     eax,0x1
    1ccd:	0f be d0             	movsx  edx,al
    1cd0:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1cd4:	48 8b 75 e0          	mov    rsi,QWORD PTR [rbp-0x20]
    1cd8:	41 89 f8             	mov    r8d,edi
    1cdb:	48 89 c7             	mov    rdi,rax
    1cde:	e8 00 00 00 00       	call   1ce3 <internal_vprintf+0x592>
    1ce3:	01 45 f4             	add    DWORD PTR [rbp-0xc],eax
									} else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'u' || *fmt == 'o' || *fmt == 'b') {
    1ce6:	e9 19 04 00 00       	jmp    2104 <internal_vprintf+0x9b3>
											else if (*fmt == 'X')
    1ceb:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1cef:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1cf2:	3c 58                	cmp    al,0x58
    1cf4:	75 2d                	jne    1d23 <internal_vprintf+0x5d2>
													rv += putu(ctx, val, flags | KFL_IS_HEX | KFL_CAPITAL, width, prec);
    1cf6:	0f be 7d fc          	movsx  edi,BYTE PTR [rbp-0x4]
    1cfa:	0f be 4d fd          	movsx  ecx,BYTE PTR [rbp-0x3]
    1cfe:	0f b6 45 fe          	movzx  eax,BYTE PTR [rbp-0x2]
    1d02:	83 c8 81             	or     eax,0xffffff81
    1d05:	0f be d0             	movsx  edx,al
    1d08:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1d0c:	48 8b 75 e0          	mov    rsi,QWORD PTR [rbp-0x20]
    1d10:	41 89 f8             	mov    r8d,edi
    1d13:	48 89 c7             	mov    rdi,rax
    1d16:	e8 00 00 00 00       	call   1d1b <internal_vprintf+0x5ca>
    1d1b:	01 45 f4             	add    DWORD PTR [rbp-0xc],eax
									} else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'u' || *fmt == 'o' || *fmt == 'b') {
    1d1e:	e9 e1 03 00 00       	jmp    2104 <internal_vprintf+0x9b3>
											else if (*fmt == 'u')
    1d23:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1d27:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1d2a:	3c 75                	cmp    al,0x75
    1d2c:	75 27                	jne    1d55 <internal_vprintf+0x604>
													rv += putu(ctx, val, flags, width, prec);
    1d2e:	0f be 7d fc          	movsx  edi,BYTE PTR [rbp-0x4]
    1d32:	0f be 4d fd          	movsx  ecx,BYTE PTR [rbp-0x3]
    1d36:	0f be 55 fe          	movsx  edx,BYTE PTR [rbp-0x2]
    1d3a:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1d3e:	48 8b 75 e0          	mov    rsi,QWORD PTR [rbp-0x20]
    1d42:	41 89 f8             	mov    r8d,edi
    1d45:	48 89 c7             	mov    rdi,rax
    1d48:	e8 00 00 00 00       	call   1d4d <internal_vprintf+0x5fc>
    1d4d:	01 45 f4             	add    DWORD PTR [rbp-0xc],eax
									} else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'u' || *fmt == 'o' || *fmt == 'b') {
    1d50:	e9 af 03 00 00       	jmp    2104 <internal_vprintf+0x9b3>
											else if (*fmt == 'o')
    1d55:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1d59:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1d5c:	3c 6f                	cmp    al,0x6f
    1d5e:	75 2d                	jne    1d8d <internal_vprintf+0x63c>
													rv += putu(ctx, val, flags | KFL_IS_OCT, width, prec);
    1d60:	0f be 7d fc          	movsx  edi,BYTE PTR [rbp-0x4]
    1d64:	0f be 4d fd          	movsx  ecx,BYTE PTR [rbp-0x3]
    1d68:	0f b6 45 fe          	movzx  eax,BYTE PTR [rbp-0x2]
    1d6c:	83 c8 40             	or     eax,0x40
    1d6f:	0f be d0             	movsx  edx,al
    1d72:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1d76:	48 8b 75 e0          	mov    rsi,QWORD PTR [rbp-0x20]
    1d7a:	41 89 f8             	mov    r8d,edi
    1d7d:	48 89 c7             	mov    rdi,rax
    1d80:	e8 00 00 00 00       	call   1d85 <internal_vprintf+0x634>
    1d85:	01 45 f4             	add    DWORD PTR [rbp-0xc],eax
									} else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'u' || *fmt == 'o' || *fmt == 'b') {
    1d88:	e9 77 03 00 00       	jmp    2104 <internal_vprintf+0x9b3>
											else if (*fmt == 'b')
    1d8d:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1d91:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1d94:	3c 62                	cmp    al,0x62
    1d96:	0f 85 68 03 00 00    	jne    2104 <internal_vprintf+0x9b3>
													rv += putb(ctx, val, flags, width, prec);
    1d9c:	0f be 75 fc          	movsx  esi,BYTE PTR [rbp-0x4]
    1da0:	0f be 4d fd          	movsx  ecx,BYTE PTR [rbp-0x3]
    1da4:	0f be 55 fe          	movsx  edx,BYTE PTR [rbp-0x2]
    1da8:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    1dac:	89 c7                	mov    edi,eax
    1dae:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1db2:	41 89 f0             	mov    r8d,esi
    1db5:	89 fe                	mov    esi,edi
    1db7:	48 89 c7             	mov    rdi,rax
    1dba:	e8 00 00 00 00       	call   1dbf <internal_vprintf+0x66e>
    1dbf:	01 45 f4             	add    DWORD PTR [rbp-0xc],eax
									} else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'u' || *fmt == 'o' || *fmt == 'b') {
    1dc2:	e9 3d 03 00 00       	jmp    2104 <internal_vprintf+0x9b3>
									} else if(*fmt == 'p')/* {
    1dc7:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1dcb:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1dce:	3c 70                	cmp    al,0x70
    1dd0:	75 37                	jne    1e09 <internal_vprintf+0x6b8>
											rv += putu(ctx, (uint64_t)(uintptr_t)va_arg(args, void*), /*KFL_ZERO_PREFIX |*/ KFL_IS_HEX,
    1dd2:	48 83 45 a8 08       	add    QWORD PTR [rbp-0x58],0x8
    1dd7:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1ddb:	48 83 e8 08          	sub    rax,0x8
    1ddf:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1de2:	48 89 c6             	mov    rsi,rax
    1de5:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1de9:	41 b8 10 00 00 00    	mov    r8d,0x10
    1def:	b9 00 00 00 00       	mov    ecx,0x0
    1df4:	ba 01 00 00 00       	mov    edx,0x1
    1df9:	48 89 c7             	mov    rdi,rax
    1dfc:	e8 00 00 00 00       	call   1e01 <internal_vprintf+0x6b0>
    1e01:	01 45 f4             	add    DWORD PTR [rbp-0xc],eax
    1e04:	e9 fc 02 00 00       	jmp    2105 <internal_vprintf+0x9b4>
									else if (*fmt == 's') {
    1e09:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1e0d:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1e10:	3c 73                	cmp    al,0x73
    1e12:	0f 85 4d 01 00 00    	jne    1f65 <internal_vprintf+0x814>
											const char* str = va_arg(args, const char*);
    1e18:	48 83 45 a8 08       	add    QWORD PTR [rbp-0x58],0x8
    1e1d:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1e21:	48 8b 40 f8          	mov    rax,QWORD PTR [rax-0x8]
    1e25:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
											if(str) {
    1e29:	48 83 7d d8 00       	cmp    QWORD PTR [rbp-0x28],0x0
    1e2e:	0f 84 19 01 00 00    	je     1f4d <internal_vprintf+0x7fc>
													size_t l = strlen(str);
    1e34:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1e38:	48 89 c7             	mov    rdi,rax
    1e3b:	e8 00 00 00 00       	call   1e40 <internal_vprintf+0x6ef>
    1e40:	48 89 45 d0          	mov    QWORD PTR [rbp-0x30],rax
													if ((size_t)width > l) {
    1e44:	48 0f be 45 fd       	movsx  rax,BYTE PTR [rbp-0x3]
    1e49:	48 39 45 d0          	cmp    QWORD PTR [rbp-0x30],rax
    1e4d:	73 76                	jae    1ec5 <internal_vprintf+0x774>
															if (!(flags & KFL_LEFT_ALIGN))
    1e4f:	0f be 45 fe          	movsx  eax,BYTE PTR [rbp-0x2]
    1e53:	83 e0 08             	and    eax,0x8
    1e56:	85 c0                	test   eax,eax
    1e58:	75 2b                	jne    1e85 <internal_vprintf+0x734>
																	cputs(str);
    1e5a:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1e5e:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
    1e62:	49 89 d2             	mov    r10,rdx
    1e65:	48 89 c7             	mov    rdi,rax
    1e68:	e8 98 f8 ff ff       	call   1705 <cputs.0>
															while ((size_t)(width--) > l)
    1e6d:	eb 16                	jmp    1e85 <internal_vprintf+0x734>
																	ctx->putchar(ctx, ' ');
    1e6f:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1e73:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    1e77:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1e7b:	be 20 00 00 00       	mov    esi,0x20
    1e80:	48 89 c7             	mov    rdi,rax
    1e83:	ff d2                	call   rdx
															while ((size_t)(width--) > l)
    1e85:	0f b6 45 fd          	movzx  eax,BYTE PTR [rbp-0x3]
    1e89:	89 c2                	mov    edx,eax
    1e8b:	83 ea 01             	sub    edx,0x1
    1e8e:	88 55 fd             	mov    BYTE PTR [rbp-0x3],dl
    1e91:	48 0f be c0          	movsx  rax,al
    1e95:	48 39 45 d0          	cmp    QWORD PTR [rbp-0x30],rax
    1e99:	72 d4                	jb     1e6f <internal_vprintf+0x71e>
															if (flags & KFL_LEFT_ALIGN)
    1e9b:	0f be 45 fe          	movsx  eax,BYTE PTR [rbp-0x2]
    1e9f:	83 e0 08             	and    eax,0x8
    1ea2:	85 c0                	test   eax,eax
    1ea4:	74 13                	je     1eb9 <internal_vprintf+0x768>
																	cputs(str);
    1ea6:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1eaa:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
    1eae:	49 89 d2             	mov    r10,rdx
    1eb1:	48 89 c7             	mov    rdi,rax
    1eb4:	e8 4c f8 ff ff       	call   1705 <cputs.0>
															rv += width;
    1eb9:	0f be 45 fd          	movsx  eax,BYTE PTR [rbp-0x3]
    1ebd:	01 45 f4             	add    DWORD PTR [rbp-0xc],eax
    1ec0:	e9 40 02 00 00       	jmp    2105 <internal_vprintf+0x9b4>
													} else if (prec && l > (size_t)prec) {
    1ec5:	80 7d fc 00          	cmp    BYTE PTR [rbp-0x4],0x0
    1ec9:	74 5c                	je     1f27 <internal_vprintf+0x7d6>
    1ecb:	48 0f be 45 fc       	movsx  rax,BYTE PTR [rbp-0x4]
    1ed0:	48 3b 45 d0          	cmp    rax,QWORD PTR [rbp-0x30]
    1ed4:	73 51                	jae    1f27 <internal_vprintf+0x7d6>
															rv += prec;
    1ed6:	0f be 45 fc          	movsx  eax,BYTE PTR [rbp-0x4]
    1eda:	01 45 f4             	add    DWORD PTR [rbp-0xc],eax
															l = 0;
    1edd:	48 c7 45 d0 00 00 00 00 	mov    QWORD PTR [rbp-0x30],0x0
															while (l++ < (size_t)prec)
    1ee5:	eb 25                	jmp    1f0c <internal_vprintf+0x7bb>
																	ctx->putchar(ctx, *str++);
    1ee7:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1eeb:	48 8b 48 10          	mov    rcx,QWORD PTR [rax+0x10]
    1eef:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1ef3:	48 8d 50 01          	lea    rdx,[rax+0x1]
    1ef7:	48 89 55 d8          	mov    QWORD PTR [rbp-0x28],rdx
    1efb:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1efe:	0f be d0             	movsx  edx,al
    1f01:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1f05:	89 d6                	mov    esi,edx
    1f07:	48 89 c7             	mov    rdi,rax
    1f0a:	ff d1                	call   rcx
															while (l++ < (size_t)prec)
    1f0c:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1f10:	48 8d 50 01          	lea    rdx,[rax+0x1]
    1f14:	48 89 55 d0          	mov    QWORD PTR [rbp-0x30],rdx
    1f18:	48 0f be 55 fc       	movsx  rdx,BYTE PTR [rbp-0x4]
    1f1d:	48 39 d0             	cmp    rax,rdx
    1f20:	72 c5                	jb     1ee7 <internal_vprintf+0x796>
													} else if (prec && l > (size_t)prec) {
    1f22:	e9 de 01 00 00       	jmp    2105 <internal_vprintf+0x9b4>
													} else {
															rv += l;
    1f27:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    1f2b:	89 c2                	mov    edx,eax
    1f2d:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
    1f30:	01 d0                	add    eax,edx
    1f32:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
															cputs(str);
    1f35:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    1f39:	48 8d 55 c0          	lea    rdx,[rbp-0x40]
    1f3d:	49 89 d2             	mov    r10,rdx
    1f40:	48 89 c7             	mov    rdi,rax
    1f43:	e8 bd f7 ff ff       	call   1705 <cputs.0>
    1f48:	e9 b8 01 00 00       	jmp    2105 <internal_vprintf+0x9b4>
													}
											}
											else
													cputs("(null)");
    1f4d:	48 8d 45 c0          	lea    rax,[rbp-0x40]
    1f51:	49 89 c2             	mov    r10,rax
    1f54:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    1f5b:	e8 a5 f7 ff ff       	call   1705 <cputs.0>
    1f60:	e9 a0 01 00 00       	jmp    2105 <internal_vprintf+0x9b4>
									} else if (*fmt == 'c') {
    1f65:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1f69:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1f6c:	3c 63                	cmp    al,0x63
    1f6e:	75 2e                	jne    1f9e <internal_vprintf+0x84d>
											ctx->putchar(ctx, (char)va_arg(args, int));
    1f70:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1f74:	48 8b 48 10          	mov    rcx,QWORD PTR [rax+0x10]
    1f78:	48 83 45 a8 04       	add    QWORD PTR [rbp-0x58],0x4
    1f7d:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1f81:	48 83 e8 04          	sub    rax,0x4
    1f85:	8b 00                	mov    eax,DWORD PTR [rax]
    1f87:	0f be d0             	movsx  edx,al
    1f8a:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    1f8e:	89 d6                	mov    esi,edx
    1f90:	48 89 c7             	mov    rdi,rax
    1f93:	ff d1                	call   rcx
											rv++;
    1f95:	83 45 f4 01          	add    DWORD PTR [rbp-0xc],0x1
    1f99:	e9 67 01 00 00       	jmp    2105 <internal_vprintf+0x9b4>
									} else if (*fmt == 'f')
    1f9e:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1fa2:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1fa5:	3c 66                	cmp    al,0x66
    1fa7:	0f 84 58 01 00 00    	je     2105 <internal_vprintf+0x9b4>
											/* FPU init needed? */;
									else if (*fmt == 'n') {
    1fad:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    1fb1:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1fb4:	3c 6e                	cmp    al,0x6e
    1fb6:	0f 85 0f 01 00 00    	jne    20cb <internal_vprintf+0x97a>
											if (!size)
    1fbc:	80 7d fb 00          	cmp    BYTE PTR [rbp-0x5],0x0
    1fc0:	75 1a                	jne    1fdc <internal_vprintf+0x88b>
													*va_arg(args, int*) = (int)rv;
    1fc2:	48 83 45 a8 08       	add    QWORD PTR [rbp-0x58],0x8
    1fc7:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1fcb:	48 83 e8 08          	sub    rax,0x8
    1fcf:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1fd2:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    1fd5:	89 10                	mov    DWORD PTR [rax],edx
    1fd7:	e9 29 01 00 00       	jmp    2105 <internal_vprintf+0x9b4>
											else if (size == 1)
    1fdc:	80 7d fb 01          	cmp    BYTE PTR [rbp-0x5],0x1
    1fe0:	75 1a                	jne    1ffc <internal_vprintf+0x8ab>
													*va_arg(args, signed char*) = (signed char)rv;
    1fe2:	48 83 45 a8 08       	add    QWORD PTR [rbp-0x58],0x8
    1fe7:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1feb:	48 83 e8 08          	sub    rax,0x8
    1fef:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1ff2:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    1ff5:	88 10                	mov    BYTE PTR [rax],dl
    1ff7:	e9 09 01 00 00       	jmp    2105 <internal_vprintf+0x9b4>
											else if (size == 2)
    1ffc:	80 7d fb 02          	cmp    BYTE PTR [rbp-0x5],0x2
    2000:	75 1b                	jne    201d <internal_vprintf+0x8cc>
													*va_arg(args, short int*) = (short int)rv;
    2002:	48 83 45 a8 08       	add    QWORD PTR [rbp-0x58],0x8
    2007:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    200b:	48 83 e8 08          	sub    rax,0x8
    200f:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2012:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    2015:	66 89 10             	mov    WORD PTR [rax],dx
    2018:	e9 e8 00 00 00       	jmp    2105 <internal_vprintf+0x9b4>
											else if (size == 3)
    201d:	80 7d fb 03          	cmp    BYTE PTR [rbp-0x5],0x3
    2021:	75 1e                	jne    2041 <internal_vprintf+0x8f0>
													*va_arg(args, long int*) = (long int)rv;
    2023:	48 83 45 a8 08       	add    QWORD PTR [rbp-0x58],0x8
    2028:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    202c:	48 83 e8 08          	sub    rax,0x8
    2030:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2033:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    2036:	48 63 d2             	movsxd rdx,edx
    2039:	48 89 10             	mov    QWORD PTR [rax],rdx
    203c:	e9 c4 00 00 00       	jmp    2105 <internal_vprintf+0x9b4>
											else if (size == 4)
    2041:	80 7d fb 04          	cmp    BYTE PTR [rbp-0x5],0x4
    2045:	75 1e                	jne    2065 <internal_vprintf+0x914>
													*va_arg(args, long long int*) = (long long int)rv;
    2047:	48 83 45 a8 08       	add    QWORD PTR [rbp-0x58],0x8
    204c:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2050:	48 83 e8 08          	sub    rax,0x8
    2054:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2057:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    205a:	48 63 d2             	movsxd rdx,edx
    205d:	48 89 10             	mov    QWORD PTR [rax],rdx
    2060:	e9 a0 00 00 00       	jmp    2105 <internal_vprintf+0x9b4>
											else if (size == 5)
    2065:	80 7d fb 05          	cmp    BYTE PTR [rbp-0x5],0x5
    2069:	75 1b                	jne    2086 <internal_vprintf+0x935>
													*va_arg(args, intmax_t*) = (intmax_t)rv;
    206b:	48 83 45 a8 08       	add    QWORD PTR [rbp-0x58],0x8
    2070:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2074:	48 83 e8 08          	sub    rax,0x8
    2078:	48 8b 00             	mov    rax,QWORD PTR [rax]
    207b:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    207e:	48 63 d2             	movsxd rdx,edx
    2081:	48 89 10             	mov    QWORD PTR [rax],rdx
    2084:	eb 7f                	jmp    2105 <internal_vprintf+0x9b4>
											else if (size == 6)
    2086:	80 7d fb 06          	cmp    BYTE PTR [rbp-0x5],0x6
    208a:	75 17                	jne    20a3 <internal_vprintf+0x952>
													*va_arg(args, ssize_t*) = (ssize_t)rv;
    208c:	48 83 45 a8 08       	add    QWORD PTR [rbp-0x58],0x8
    2091:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    2095:	48 83 e8 08          	sub    rax,0x8
    2099:	48 8b 00             	mov    rax,QWORD PTR [rax]
    209c:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    209f:	89 10                	mov    DWORD PTR [rax],edx
    20a1:	eb 62                	jmp    2105 <internal_vprintf+0x9b4>
											else if (size == 7)
    20a3:	80 7d fb 07          	cmp    BYTE PTR [rbp-0x5],0x7
    20a7:	75 1b                	jne    20c4 <internal_vprintf+0x973>
													*va_arg(args, ptrdiff_t*) = (ptrdiff_t)rv;
    20a9:	48 83 45 a8 08       	add    QWORD PTR [rbp-0x58],0x8
    20ae:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    20b2:	48 83 e8 08          	sub    rax,0x8
    20b6:	48 8b 00             	mov    rax,QWORD PTR [rax]
    20b9:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    20bc:	48 63 d2             	movsxd rdx,edx
    20bf:	48 89 10             	mov    QWORD PTR [rax],rdx
    20c2:	eb 41                	jmp    2105 <internal_vprintf+0x9b4>
											else
													(void)va_arg(args, long double*);
    20c4:	48 83 45 a8 08       	add    QWORD PTR [rbp-0x58],0x8
    20c9:	eb 3a                	jmp    2105 <internal_vprintf+0x9b4>
									} else { /* ignore */
											ctx->putchar(ctx, '%');
    20cb:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    20cf:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
    20d3:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    20d7:	be 25 00 00 00       	mov    esi,0x25
    20dc:	48 89 c7             	mov    rdi,rax
    20df:	ff d2                	call   rdx
											ctx->putchar(ctx, *fmt);
    20e1:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    20e5:	48 8b 48 10          	mov    rcx,QWORD PTR [rax+0x10]
    20e9:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    20ed:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    20f0:	0f be d0             	movsx  edx,al
    20f3:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    20f7:	89 d6                	mov    esi,edx
    20f9:	48 89 c7             	mov    rdi,rax
    20fc:	ff d1                	call   rcx
											rv += 2;
    20fe:	83 45 f4 02          	add    DWORD PTR [rbp-0xc],0x2
    2102:	eb 01                	jmp    2105 <internal_vprintf+0x9b4>
									} else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'u' || *fmt == 'o' || *fmt == 'b') {
    2104:	90                   	nop
									}
									fmt++;
    2105:	48 83 45 b0 01       	add    QWORD PTR [rbp-0x50],0x1
									is_fmt = 0;
    210a:	c6 45 ff 00          	mov    BYTE PTR [rbp-0x1],0x0
									flags = KFL_LEFT_ALIGN;
    210e:	c6 45 fe 08          	mov    BYTE PTR [rbp-0x2],0x8
									width = 0;
    2112:	c6 45 fd 00          	mov    BYTE PTR [rbp-0x3],0x0
									prec = 0;
    2116:	c6 45 fc 00          	mov    BYTE PTR [rbp-0x4],0x0
									size = 0;
    211a:	c6 45 fb 00          	mov    BYTE PTR [rbp-0x5],0x0
    211e:	eb 29                	jmp    2149 <internal_vprintf+0x9f8>
							} else {
									ctx->putchar(ctx, *(fmt++));
    2120:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    2124:	48 8b 48 10          	mov    rcx,QWORD PTR [rax+0x10]
    2128:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    212c:	48 8d 50 01          	lea    rdx,[rax+0x1]
    2130:	48 89 55 b0          	mov    QWORD PTR [rbp-0x50],rdx
    2134:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    2137:	0f be d0             	movsx  edx,al
    213a:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    213e:	89 d6                	mov    esi,edx
    2140:	48 89 c7             	mov    rdi,rax
    2143:	ff d1                	call   rcx
									rv++;
    2145:	83 45 f4 01          	add    DWORD PTR [rbp-0xc],0x1
		while (*fmt) {
    2149:	48 8b 45 b0          	mov    rax,QWORD PTR [rbp-0x50]
    214d:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    2150:	84 c0                	test   al,al
    2152:	0f 85 3d f6 ff ff    	jne    1795 <internal_vprintf+0x44>
							}
			}
		}
		return rv;
    2158:	8b 45 f4             	mov    eax,DWORD PTR [rbp-0xc]
}
    215b:	c9                   	leave
    215c:	c3                   	ret

000000000000215d <ctx_c_putchar>:

void ctx_c_putchar(struct ivp_ctx* ctx, char c)
{
    215d:	55                   	push   rbp
    215e:	48 89 e5             	mov    rbp,rsp
    2161:	48 83 ec 10          	sub    rsp,0x10
    2165:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
    2169:	89 f0                	mov    eax,esi
    216b:	88 45 f4             	mov    BYTE PTR [rbp-0xc],al
		region_putchar(ctx->buf, c);
    216e:	0f be 55 f4          	movsx  edx,BYTE PTR [rbp-0xc]
    2172:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2176:	48 8b 00             	mov    rax,QWORD PTR [rax]
    2179:	89 d6                	mov    esi,edx
    217b:	48 89 c7             	mov    rdi,rax
    217e:	e8 00 00 00 00       	call   2183 <ctx_c_putchar+0x26>
}
    2183:	90                   	nop
    2184:	c9                   	leave
    2185:	c3                   	ret

0000000000002186 <ctx_s_putchar>:

void ctx_s_putchar(struct ivp_ctx* ctx, char c)
{
    2186:	55                   	push   rbp
    2187:	48 89 e5             	mov    rbp,rsp
    218a:	48 83 ec 10          	sub    rsp,0x10
    218e:	48 89 7d f8          	mov    QWORD PTR [rbp-0x8],rdi
    2192:	89 f0                	mov    eax,esi
    2194:	88 45 f4             	mov    BYTE PTR [rbp-0xc],al
		if (ctx->buf) {
    2197:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    219b:	48 8b 00             	mov    rax,QWORD PTR [rax]
    219e:	48 85 c0             	test   rax,rax
    21a1:	74 46                	je     21e9 <ctx_s_putchar+0x63>
				if (!ctx->n) {
    21a3:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    21a7:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    21ab:	48 85 c0             	test   rax,rax
    21ae:	75 0d                	jne    21bd <ctx_s_putchar+0x37>
						ctx->buf = NULL;
    21b0:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    21b4:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
						return;
    21bb:	eb 2c                	jmp    21e9 <ctx_s_putchar+0x63>
				}
				*ctx->buf++ = c;
    21bd:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    21c1:	48 8b 00             	mov    rax,QWORD PTR [rax]
    21c4:	48 8d 48 01          	lea    rcx,[rax+0x1]
    21c8:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    21cc:	48 89 0a             	mov    QWORD PTR [rdx],rcx
    21cf:	0f b6 55 f4          	movzx  edx,BYTE PTR [rbp-0xc]
    21d3:	88 10                	mov    BYTE PTR [rax],dl
				ctx->n--;
    21d5:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    21d9:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
    21dd:	48 8d 50 ff          	lea    rdx,[rax-0x1]
    21e1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    21e5:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
		}
}
    21e9:	c9                   	leave
    21ea:	c3                   	ret

00000000000021eb <vrprintf>:

int vrprintf(struct kio_region* cr, const char* fmt, va_list args)
{
    21eb:	55                   	push   rbp
    21ec:	48 89 e5             	mov    rbp,rsp
    21ef:	48 83 ec 40          	sub    rsp,0x40
    21f3:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
    21f7:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi
    21fb:	48 89 55 c8          	mov    QWORD PTR [rbp-0x38],rdx
		int rv;
		struct ivp_ctx ct = {cr, 0, &ctx_c_putchar};
    21ff:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    2203:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    2207:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
    220f:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		rv = internal_vprintf(&ct, fmt, args);
    2217:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    221b:	48 8b 4d d0          	mov    rcx,QWORD PTR [rbp-0x30]
    221f:	48 8d 45 e0          	lea    rax,[rbp-0x20]
    2223:	48 89 ce             	mov    rsi,rcx
    2226:	48 89 c7             	mov    rdi,rax
    2229:	e8 00 00 00 00       	call   222e <vrprintf+0x43>
    222e:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		return rv;
    2231:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
    2234:	c9                   	leave
    2235:	c3                   	ret

0000000000002236 <vprintf>:

int vprintf(const char* fmt, va_list args)
{
    2236:	55                   	push   rbp
    2237:	48 89 e5             	mov    rbp,rsp
    223a:	48 83 ec 30          	sub    rsp,0x30
    223e:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
    2242:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi
		int rv;
		struct ivp_ctx ct = {&reg_def, 0, &ctx_c_putchar};
    2246:	48 c7 45 e0 00 00 00 00 	mov    QWORD PTR [rbp-0x20],0x0
    224e:	48 c7 45 e8 00 00 00 00 	mov    QWORD PTR [rbp-0x18],0x0
    2256:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		rv = internal_vprintf(&ct, fmt, args);
    225e:	48 8b 55 d0          	mov    rdx,QWORD PTR [rbp-0x30]
    2262:	48 8b 4d d8          	mov    rcx,QWORD PTR [rbp-0x28]
    2266:	48 8d 45 e0          	lea    rax,[rbp-0x20]
    226a:	48 89 ce             	mov    rsi,rcx
    226d:	48 89 c7             	mov    rdi,rax
    2270:	e8 00 00 00 00       	call   2275 <vprintf+0x3f>
    2275:	89 45 fc             	mov    DWORD PTR [rbp-0x4],eax
		return rv;
    2278:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
    227b:	c9                   	leave
    227c:	c3                   	ret

000000000000227d <rprintf>:

/* with region ptr, region has lock & spin_trylock & lock-free add-buffer
  & malloc in irq question */
int rprintf(struct kio_region* cr, const char* fmt, ...)
{
    227d:	55                   	push   rbp
    227e:	48 89 e5             	mov    rbp,rsp
    2281:	48 81 ec d0 00 00 00 	sub    rsp,0xd0
    2288:	48 89 bd 38 ff ff ff 	mov    QWORD PTR [rbp-0xc8],rdi
    228f:	48 89 b5 30 ff ff ff 	mov    QWORD PTR [rbp-0xd0],rsi
    2296:	48 89 95 60 ff ff ff 	mov    QWORD PTR [rbp-0xa0],rdx
    229d:	48 89 8d 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rcx
    22a4:	4c 89 85 70 ff ff ff 	mov    QWORD PTR [rbp-0x90],r8
    22ab:	4c 89 8d 78 ff ff ff 	mov    QWORD PTR [rbp-0x88],r9
    22b2:	84 c0                	test   al,al
    22b4:	74 20                	je     22d6 <rprintf+0x59>
    22b6:	0f 29 45 80          	movaps XMMWORD PTR [rbp-0x80],xmm0
    22ba:	0f 29 4d 90          	movaps XMMWORD PTR [rbp-0x70],xmm1
    22be:	0f 29 55 a0          	movaps XMMWORD PTR [rbp-0x60],xmm2
    22c2:	0f 29 5d b0          	movaps XMMWORD PTR [rbp-0x50],xmm3
    22c6:	0f 29 65 c0          	movaps XMMWORD PTR [rbp-0x40],xmm4
    22ca:	0f 29 6d d0          	movaps XMMWORD PTR [rbp-0x30],xmm5
    22ce:	0f 29 75 e0          	movaps XMMWORD PTR [rbp-0x20],xmm6
    22d2:	0f 29 7d f0          	movaps XMMWORD PTR [rbp-0x10],xmm7
		int rv;
		va_list args;
		va_start(args, fmt);
    22d6:	48 8d 85 30 ff ff ff 	lea    rax,[rbp-0xd0]
    22dd:	48 83 c0 08          	add    rax,0x8
    22e1:	48 89 85 48 ff ff ff 	mov    QWORD PTR [rbp-0xb8],rax
		rv = vrprintf(cr, fmt, args);
    22e8:	48 8b 8d 30 ff ff ff 	mov    rcx,QWORD PTR [rbp-0xd0]
    22ef:	48 8b 95 48 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xb8]
    22f6:	48 8b 85 38 ff ff ff 	mov    rax,QWORD PTR [rbp-0xc8]
    22fd:	48 89 ce             	mov    rsi,rcx
    2300:	48 89 c7             	mov    rdi,rax
    2303:	e8 00 00 00 00       	call   2308 <rprintf+0x8b>
    2308:	89 85 44 ff ff ff    	mov    DWORD PTR [rbp-0xbc],eax
		va_end(args);
    230e:	48 c7 85 48 ff ff ff 00 00 00 00 	mov    QWORD PTR [rbp-0xb8],0x0
		return rv;
    2319:	8b 85 44 ff ff ff    	mov    eax,DWORD PTR [rbp-0xbc]
}
    231f:	c9                   	leave
    2320:	c3                   	ret

0000000000002321 <crprintf>:

int crprintf(char col, struct kio_region* cr, const char* fmt, ...)
{
    2321:	55                   	push   rbp
    2322:	48 89 e5             	mov    rbp,rsp
    2325:	48 81 ec f0 00 00 00 	sub    rsp,0xf0
    232c:	48 89 b5 20 ff ff ff 	mov    QWORD PTR [rbp-0xe0],rsi
    2333:	48 89 95 18 ff ff ff 	mov    QWORD PTR [rbp-0xe8],rdx
    233a:	48 89 8d 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rcx
    2341:	4c 89 85 70 ff ff ff 	mov    QWORD PTR [rbp-0x90],r8
    2348:	4c 89 8d 78 ff ff ff 	mov    QWORD PTR [rbp-0x88],r9
    234f:	84 c0                	test   al,al
    2351:	74 20                	je     2373 <crprintf+0x52>
    2353:	0f 29 45 80          	movaps XMMWORD PTR [rbp-0x80],xmm0
    2357:	0f 29 4d 90          	movaps XMMWORD PTR [rbp-0x70],xmm1
    235b:	0f 29 55 a0          	movaps XMMWORD PTR [rbp-0x60],xmm2
    235f:	0f 29 5d b0          	movaps XMMWORD PTR [rbp-0x50],xmm3
    2363:	0f 29 65 c0          	movaps XMMWORD PTR [rbp-0x40],xmm4
    2367:	0f 29 6d d0          	movaps XMMWORD PTR [rbp-0x30],xmm5
    236b:	0f 29 75 e0          	movaps XMMWORD PTR [rbp-0x20],xmm6
    236f:	0f 29 7d f0          	movaps XMMWORD PTR [rbp-0x10],xmm7
    2373:	89 f8                	mov    eax,edi
    2375:	88 85 2c ff ff ff    	mov    BYTE PTR [rbp-0xd4],al
		int rv; char cf = cr->fmt;
    237b:	48 8b 85 20 ff ff ff 	mov    rax,QWORD PTR [rbp-0xe0]
    2382:	0f b6 40 0c          	movzx  eax,BYTE PTR [rax+0xc]
    2386:	88 85 4f ff ff ff    	mov    BYTE PTR [rbp-0xb1],al
		va_list args;
		va_start(args, fmt);
    238c:	48 8d 85 18 ff ff ff 	lea    rax,[rbp-0xe8]
    2393:	48 83 c0 08          	add    rax,0x8
    2397:	48 89 85 40 ff ff ff 	mov    QWORD PTR [rbp-0xc0],rax
		cr->fmt = col;
    239e:	48 8b 85 20 ff ff ff 	mov    rax,QWORD PTR [rbp-0xe0]
    23a5:	0f b6 95 2c ff ff ff 	movzx  edx,BYTE PTR [rbp-0xd4]
    23ac:	88 50 0c             	mov    BYTE PTR [rax+0xc],dl
		rv = vrprintf(cr, fmt, args);
    23af:	48 8b 8d 18 ff ff ff 	mov    rcx,QWORD PTR [rbp-0xe8]
    23b6:	48 8b 95 40 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xc0]
    23bd:	48 8b 85 20 ff ff ff 	mov    rax,QWORD PTR [rbp-0xe0]
    23c4:	48 89 ce             	mov    rsi,rcx
    23c7:	48 89 c7             	mov    rdi,rax
    23ca:	e8 00 00 00 00       	call   23cf <crprintf+0xae>
    23cf:	89 85 3c ff ff ff    	mov    DWORD PTR [rbp-0xc4],eax
		cr->fmt = cf;
    23d5:	48 8b 85 20 ff ff ff 	mov    rax,QWORD PTR [rbp-0xe0]
    23dc:	0f b6 95 4f ff ff ff 	movzx  edx,BYTE PTR [rbp-0xb1]
    23e3:	88 50 0c             	mov    BYTE PTR [rax+0xc],dl
		va_end(args);
    23e6:	48 c7 85 40 ff ff ff 00 00 00 00 	mov    QWORD PTR [rbp-0xc0],0x0
		return rv;
    23f1:	8b 85 3c ff ff ff    	mov    eax,DWORD PTR [rbp-0xc4]
}
    23f7:	c9                   	leave
    23f8:	c3                   	ret

00000000000023f9 <cprintf>:

int cprintf(char col, const char* fmt, ...)
{
    23f9:	55                   	push   rbp
    23fa:	48 89 e5             	mov    rbp,rsp
    23fd:	48 81 ec e0 00 00 00 	sub    rsp,0xe0
    2404:	48 89 b5 20 ff ff ff 	mov    QWORD PTR [rbp-0xe0],rsi
    240b:	48 89 95 60 ff ff ff 	mov    QWORD PTR [rbp-0xa0],rdx
    2412:	48 89 8d 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rcx
    2419:	4c 89 85 70 ff ff ff 	mov    QWORD PTR [rbp-0x90],r8
    2420:	4c 89 8d 78 ff ff ff 	mov    QWORD PTR [rbp-0x88],r9
    2427:	84 c0                	test   al,al
    2429:	74 20                	je     244b <cprintf+0x52>
    242b:	0f 29 45 80          	movaps XMMWORD PTR [rbp-0x80],xmm0
    242f:	0f 29 4d 90          	movaps XMMWORD PTR [rbp-0x70],xmm1
    2433:	0f 29 55 a0          	movaps XMMWORD PTR [rbp-0x60],xmm2
    2437:	0f 29 5d b0          	movaps XMMWORD PTR [rbp-0x50],xmm3
    243b:	0f 29 65 c0          	movaps XMMWORD PTR [rbp-0x40],xmm4
    243f:	0f 29 6d d0          	movaps XMMWORD PTR [rbp-0x30],xmm5
    2443:	0f 29 75 e0          	movaps XMMWORD PTR [rbp-0x20],xmm6
    2447:	0f 29 7d f0          	movaps XMMWORD PTR [rbp-0x10],xmm7
    244b:	89 f8                	mov    eax,edi
    244d:	88 85 2c ff ff ff    	mov    BYTE PTR [rbp-0xd4],al
		int rv; char cf = reg_def.fmt;
    2453:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 245a <cprintf+0x61>
    245a:	88 85 4f ff ff ff    	mov    BYTE PTR [rbp-0xb1],al
		va_list args;
		va_start(args, fmt);
    2460:	48 8d 85 20 ff ff ff 	lea    rax,[rbp-0xe0]
    2467:	48 83 c0 08          	add    rax,0x8
    246b:	48 89 85 40 ff ff ff 	mov    QWORD PTR [rbp-0xc0],rax
		reg_def.fmt = col;
    2472:	0f b6 85 2c ff ff ff 	movzx  eax,BYTE PTR [rbp-0xd4]
    2479:	88 05 00 00 00 00    	mov    BYTE PTR [rip+0x0],al        # 247f <cprintf+0x86>
		rv = vprintf(fmt, args);
    247f:	48 8b 85 20 ff ff ff 	mov    rax,QWORD PTR [rbp-0xe0]
    2486:	48 8b 95 40 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xc0]
    248d:	48 89 d6             	mov    rsi,rdx
    2490:	48 89 c7             	mov    rdi,rax
    2493:	e8 00 00 00 00       	call   2498 <cprintf+0x9f>
    2498:	89 85 3c ff ff ff    	mov    DWORD PTR [rbp-0xc4],eax
		reg_def.fmt = cf;
    249e:	0f b6 85 4f ff ff ff 	movzx  eax,BYTE PTR [rbp-0xb1]
    24a5:	88 05 00 00 00 00    	mov    BYTE PTR [rip+0x0],al        # 24ab <cprintf+0xb2>
		va_end(args);
    24ab:	48 c7 85 40 ff ff ff 00 00 00 00 	mov    QWORD PTR [rbp-0xc0],0x0
		return rv;
    24b6:	8b 85 3c ff ff ff    	mov    eax,DWORD PTR [rbp-0xc4]
}
    24bc:	c9                   	leave
    24bd:	c3                   	ret

00000000000024be <vsprintf>:

int vsprintf(char* str, const char* fmt, va_list args)
{
    24be:	55                   	push   rbp
    24bf:	48 89 e5             	mov    rbp,rsp
    24c2:	48 83 ec 40          	sub    rsp,0x40
    24c6:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
    24ca:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi
    24ce:	48 89 55 c8          	mov    QWORD PTR [rbp-0x38],rdx
		struct ivp_ctx ct = {str, 0xffffffff, &ctx_s_putchar};
    24d2:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    24d6:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    24da:	b8 ff ff ff ff       	mov    eax,0xffffffff
    24df:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    24e3:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		return internal_vprintf(&ct, fmt, args);
    24eb:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    24ef:	48 8b 4d d0          	mov    rcx,QWORD PTR [rbp-0x30]
    24f3:	48 8d 45 e0          	lea    rax,[rbp-0x20]
    24f7:	48 89 ce             	mov    rsi,rcx
    24fa:	48 89 c7             	mov    rdi,rax
    24fd:	e8 00 00 00 00       	call   2502 <vsprintf+0x44>
}
    2502:	c9                   	leave
    2503:	c3                   	ret

0000000000002504 <sprintf>:

int sprintf(char* str, const char* fmt, ...)
{
    2504:	55                   	push   rbp
    2505:	48 89 e5             	mov    rbp,rsp
    2508:	48 81 ec d0 00 00 00 	sub    rsp,0xd0
    250f:	48 89 bd 38 ff ff ff 	mov    QWORD PTR [rbp-0xc8],rdi
    2516:	48 89 b5 30 ff ff ff 	mov    QWORD PTR [rbp-0xd0],rsi
    251d:	48 89 95 60 ff ff ff 	mov    QWORD PTR [rbp-0xa0],rdx
    2524:	48 89 8d 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rcx
    252b:	4c 89 85 70 ff ff ff 	mov    QWORD PTR [rbp-0x90],r8
    2532:	4c 89 8d 78 ff ff ff 	mov    QWORD PTR [rbp-0x88],r9
    2539:	84 c0                	test   al,al
    253b:	74 20                	je     255d <sprintf+0x59>
    253d:	0f 29 45 80          	movaps XMMWORD PTR [rbp-0x80],xmm0
    2541:	0f 29 4d 90          	movaps XMMWORD PTR [rbp-0x70],xmm1
    2545:	0f 29 55 a0          	movaps XMMWORD PTR [rbp-0x60],xmm2
    2549:	0f 29 5d b0          	movaps XMMWORD PTR [rbp-0x50],xmm3
    254d:	0f 29 65 c0          	movaps XMMWORD PTR [rbp-0x40],xmm4
    2551:	0f 29 6d d0          	movaps XMMWORD PTR [rbp-0x30],xmm5
    2555:	0f 29 75 e0          	movaps XMMWORD PTR [rbp-0x20],xmm6
    2559:	0f 29 7d f0          	movaps XMMWORD PTR [rbp-0x10],xmm7
		int rv;
		va_list args;
		va_start(args, fmt);
    255d:	48 8d 85 30 ff ff ff 	lea    rax,[rbp-0xd0]
    2564:	48 83 c0 08          	add    rax,0x8
    2568:	48 89 85 48 ff ff ff 	mov    QWORD PTR [rbp-0xb8],rax
		rv = vsprintf(str, fmt, args);
    256f:	48 8b 8d 30 ff ff ff 	mov    rcx,QWORD PTR [rbp-0xd0]
    2576:	48 8b 95 48 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xb8]
    257d:	48 8b 85 38 ff ff ff 	mov    rax,QWORD PTR [rbp-0xc8]
    2584:	48 89 ce             	mov    rsi,rcx
    2587:	48 89 c7             	mov    rdi,rax
    258a:	e8 00 00 00 00       	call   258f <sprintf+0x8b>
    258f:	89 85 44 ff ff ff    	mov    DWORD PTR [rbp-0xbc],eax
		va_end(args);
    2595:	48 c7 85 48 ff ff ff 00 00 00 00 	mov    QWORD PTR [rbp-0xb8],0x0
		return rv;
    25a0:	8b 85 44 ff ff ff    	mov    eax,DWORD PTR [rbp-0xbc]
}
    25a6:	c9                   	leave
    25a7:	c3                   	ret

00000000000025a8 <vsnprintf>:

int vsnprintf(char* str, size_t n, const char* fmt, va_list args)
{
    25a8:	55                   	push   rbp
    25a9:	48 89 e5             	mov    rbp,rsp
    25ac:	48 83 ec 40          	sub    rsp,0x40
    25b0:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
    25b4:	48 89 75 d0          	mov    QWORD PTR [rbp-0x30],rsi
    25b8:	48 89 55 c8          	mov    QWORD PTR [rbp-0x38],rdx
    25bc:	48 89 4d c0          	mov    QWORD PTR [rbp-0x40],rcx
		struct ivp_ctx ct = {str, n, &ctx_s_putchar};
    25c0:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    25c4:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    25c8:	48 8b 45 d0          	mov    rax,QWORD PTR [rbp-0x30]
    25cc:	48 89 45 e8          	mov    QWORD PTR [rbp-0x18],rax
    25d0:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
		return internal_vprintf(&ct, fmt, args);
    25d8:	48 8b 55 c0          	mov    rdx,QWORD PTR [rbp-0x40]
    25dc:	48 8b 4d c8          	mov    rcx,QWORD PTR [rbp-0x38]
    25e0:	48 8d 45 e0          	lea    rax,[rbp-0x20]
    25e4:	48 89 ce             	mov    rsi,rcx
    25e7:	48 89 c7             	mov    rdi,rax
    25ea:	e8 00 00 00 00       	call   25ef <vsnprintf+0x47>
}
    25ef:	c9                   	leave
    25f0:	c3                   	ret

00000000000025f1 <snprintf>:

int snprintf(char* str, size_t n, const char* fmt, ...)
{
    25f1:	55                   	push   rbp
    25f2:	48 89 e5             	mov    rbp,rsp
    25f5:	48 81 ec e0 00 00 00 	sub    rsp,0xe0
    25fc:	48 89 bd 38 ff ff ff 	mov    QWORD PTR [rbp-0xc8],rdi
    2603:	48 89 b5 30 ff ff ff 	mov    QWORD PTR [rbp-0xd0],rsi
    260a:	48 89 95 28 ff ff ff 	mov    QWORD PTR [rbp-0xd8],rdx
    2611:	48 89 8d 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rcx
    2618:	4c 89 85 70 ff ff ff 	mov    QWORD PTR [rbp-0x90],r8
    261f:	4c 89 8d 78 ff ff ff 	mov    QWORD PTR [rbp-0x88],r9
    2626:	84 c0                	test   al,al
    2628:	74 20                	je     264a <snprintf+0x59>
    262a:	0f 29 45 80          	movaps XMMWORD PTR [rbp-0x80],xmm0
    262e:	0f 29 4d 90          	movaps XMMWORD PTR [rbp-0x70],xmm1
    2632:	0f 29 55 a0          	movaps XMMWORD PTR [rbp-0x60],xmm2
    2636:	0f 29 5d b0          	movaps XMMWORD PTR [rbp-0x50],xmm3
    263a:	0f 29 65 c0          	movaps XMMWORD PTR [rbp-0x40],xmm4
    263e:	0f 29 6d d0          	movaps XMMWORD PTR [rbp-0x30],xmm5
    2642:	0f 29 75 e0          	movaps XMMWORD PTR [rbp-0x20],xmm6
    2646:	0f 29 7d f0          	movaps XMMWORD PTR [rbp-0x10],xmm7
		int rv;
		va_list args;
		va_start(args, fmt);
    264a:	48 8d 85 28 ff ff ff 	lea    rax,[rbp-0xd8]
    2651:	48 83 c0 08          	add    rax,0x8
    2655:	48 89 85 48 ff ff ff 	mov    QWORD PTR [rbp-0xb8],rax
		rv = vsnprintf(str, n, fmt, args);
    265c:	48 8b 95 28 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xd8]
    2663:	48 8b 8d 48 ff ff ff 	mov    rcx,QWORD PTR [rbp-0xb8]
    266a:	48 8b b5 30 ff ff ff 	mov    rsi,QWORD PTR [rbp-0xd0]
    2671:	48 8b 85 38 ff ff ff 	mov    rax,QWORD PTR [rbp-0xc8]
    2678:	48 89 c7             	mov    rdi,rax
    267b:	e8 00 00 00 00       	call   2680 <snprintf+0x8f>
    2680:	89 85 44 ff ff ff    	mov    DWORD PTR [rbp-0xbc],eax
		va_end(args);
    2686:	48 c7 85 48 ff ff ff 00 00 00 00 	mov    QWORD PTR [rbp-0xb8],0x0
		return rv;
    2691:	8b 85 44 ff ff ff    	mov    eax,DWORD PTR [rbp-0xbc]
}
    2697:	c9                   	leave
    2698:	c3                   	ret

0000000000002699 <printf>:

int printf(const char* fmt, ...)
{
    2699:	55                   	push   rbp
    269a:	48 89 e5             	mov    rbp,rsp
    269d:	48 81 ec d0 00 00 00 	sub    rsp,0xd0
    26a4:	48 89 bd 38 ff ff ff 	mov    QWORD PTR [rbp-0xc8],rdi
    26ab:	48 89 b5 58 ff ff ff 	mov    QWORD PTR [rbp-0xa8],rsi
    26b2:	48 89 95 60 ff ff ff 	mov    QWORD PTR [rbp-0xa0],rdx
    26b9:	48 89 8d 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rcx
    26c0:	4c 89 85 70 ff ff ff 	mov    QWORD PTR [rbp-0x90],r8
    26c7:	4c 89 8d 78 ff ff ff 	mov    QWORD PTR [rbp-0x88],r9
    26ce:	84 c0                	test   al,al
    26d0:	74 20                	je     26f2 <printf+0x59>
    26d2:	0f 29 45 80          	movaps XMMWORD PTR [rbp-0x80],xmm0
    26d6:	0f 29 4d 90          	movaps XMMWORD PTR [rbp-0x70],xmm1
    26da:	0f 29 55 a0          	movaps XMMWORD PTR [rbp-0x60],xmm2
    26de:	0f 29 5d b0          	movaps XMMWORD PTR [rbp-0x50],xmm3
    26e2:	0f 29 65 c0          	movaps XMMWORD PTR [rbp-0x40],xmm4
    26e6:	0f 29 6d d0          	movaps XMMWORD PTR [rbp-0x30],xmm5
    26ea:	0f 29 75 e0          	movaps XMMWORD PTR [rbp-0x20],xmm6
    26ee:	0f 29 7d f0          	movaps XMMWORD PTR [rbp-0x10],xmm7
		int rv;
		va_list args;
		va_start(args, fmt);
    26f2:	48 8d 85 38 ff ff ff 	lea    rax,[rbp-0xc8]
    26f9:	48 83 c0 08          	add    rax,0x8
    26fd:	48 89 85 48 ff ff ff 	mov    QWORD PTR [rbp-0xb8],rax
		rv = vprintf(fmt, args);
    2704:	48 8b 85 38 ff ff ff 	mov    rax,QWORD PTR [rbp-0xc8]
    270b:	48 8b 95 48 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xb8]
    2712:	48 89 d6             	mov    rsi,rdx
    2715:	48 89 c7             	mov    rdi,rax
    2718:	e8 00 00 00 00       	call   271d <printf+0x84>
    271d:	89 85 44 ff ff ff    	mov    DWORD PTR [rbp-0xbc],eax
		va_end(args);
    2723:	48 c7 85 48 ff ff ff 00 00 00 00 	mov    QWORD PTR [rbp-0xb8],0x0
		return rv;
    272e:	8b 85 44 ff ff ff    	mov    eax,DWORD PTR [rbp-0xbc]
}
    2734:	c9                   	leave
    2735:	c3                   	ret

0000000000002736 <iprintf>:
/* no delay intr version */
int iprintf(const char* fmt, ...)
{
    2736:	55                   	push   rbp
    2737:	48 89 e5             	mov    rbp,rsp
    273a:	48 81 ec d0 00 00 00 	sub    rsp,0xd0
    2741:	48 89 bd 38 ff ff ff 	mov    QWORD PTR [rbp-0xc8],rdi
    2748:	48 89 b5 58 ff ff ff 	mov    QWORD PTR [rbp-0xa8],rsi
    274f:	48 89 95 60 ff ff ff 	mov    QWORD PTR [rbp-0xa0],rdx
    2756:	48 89 8d 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rcx
    275d:	4c 89 85 70 ff ff ff 	mov    QWORD PTR [rbp-0x90],r8
    2764:	4c 89 8d 78 ff ff ff 	mov    QWORD PTR [rbp-0x88],r9
    276b:	84 c0                	test   al,al
    276d:	74 20                	je     278f <iprintf+0x59>
    276f:	0f 29 45 80          	movaps XMMWORD PTR [rbp-0x80],xmm0
    2773:	0f 29 4d 90          	movaps XMMWORD PTR [rbp-0x70],xmm1
    2777:	0f 29 55 a0          	movaps XMMWORD PTR [rbp-0x60],xmm2
    277b:	0f 29 5d b0          	movaps XMMWORD PTR [rbp-0x50],xmm3
    277f:	0f 29 65 c0          	movaps XMMWORD PTR [rbp-0x40],xmm4
    2783:	0f 29 6d d0          	movaps XMMWORD PTR [rbp-0x30],xmm5
    2787:	0f 29 75 e0          	movaps XMMWORD PTR [rbp-0x20],xmm6
    278b:	0f 29 7d f0          	movaps XMMWORD PTR [rbp-0x10],xmm7
		int rv;
		va_list args;
		va_start(args, fmt);
    278f:	48 8d 85 38 ff ff ff 	lea    rax,[rbp-0xc8]
    2796:	48 83 c0 08          	add    rax,0x8
    279a:	48 89 85 48 ff ff ff 	mov    QWORD PTR [rbp-0xb8],rax
		reg_def.flags |= KIO_REGION_NO_DELAY;
    27a1:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 27a8 <iprintf+0x72>
    27a8:	83 c8 01             	or     eax,0x1
    27ab:	88 05 00 00 00 00    	mov    BYTE PTR [rip+0x0],al        # 27b1 <iprintf+0x7b>
		rv = vprintf(fmt, args);
    27b1:	48 8b 85 38 ff ff ff 	mov    rax,QWORD PTR [rbp-0xc8]
    27b8:	48 8b 95 48 ff ff ff 	mov    rdx,QWORD PTR [rbp-0xb8]
    27bf:	48 89 d6             	mov    rsi,rdx
    27c2:	48 89 c7             	mov    rdi,rax
    27c5:	e8 00 00 00 00       	call   27ca <iprintf+0x94>
    27ca:	89 85 44 ff ff ff    	mov    DWORD PTR [rbp-0xbc],eax
		reg_def.flags &= ~KIO_REGION_NO_DELAY;
    27d0:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # 27d7 <iprintf+0xa1>
    27d7:	83 e0 fe             	and    eax,0xfffffffe
    27da:	88 05 00 00 00 00    	mov    BYTE PTR [rip+0x0],al        # 27e0 <iprintf+0xaa>
		va_end(args);
    27e0:	48 c7 85 48 ff ff ff 00 00 00 00 	mov    QWORD PTR [rbp-0xb8],0x0
		return rv;
    27eb:	8b 85 44 ff ff ff    	mov    eax,DWORD PTR [rbp-0xbc]
}
    27f1:	c9                   	leave
    27f2:	c3                   	ret

00000000000027f3 <noprintf>:
int noprintf(const char* c, ...) { (void)c; return 0; }
    27f3:	55                   	push   rbp
    27f4:	48 89 e5             	mov    rbp,rsp
    27f7:	48 81 ec c0 00 00 00 	sub    rsp,0xc0
    27fe:	48 89 bd 48 ff ff ff 	mov    QWORD PTR [rbp-0xb8],rdi
    2805:	48 89 b5 58 ff ff ff 	mov    QWORD PTR [rbp-0xa8],rsi
    280c:	48 89 95 60 ff ff ff 	mov    QWORD PTR [rbp-0xa0],rdx
    2813:	48 89 8d 68 ff ff ff 	mov    QWORD PTR [rbp-0x98],rcx
    281a:	4c 89 85 70 ff ff ff 	mov    QWORD PTR [rbp-0x90],r8
    2821:	4c 89 8d 78 ff ff ff 	mov    QWORD PTR [rbp-0x88],r9
    2828:	84 c0                	test   al,al
    282a:	74 20                	je     284c <noprintf+0x59>
    282c:	0f 29 45 80          	movaps XMMWORD PTR [rbp-0x80],xmm0
    2830:	0f 29 4d 90          	movaps XMMWORD PTR [rbp-0x70],xmm1
    2834:	0f 29 55 a0          	movaps XMMWORD PTR [rbp-0x60],xmm2
    2838:	0f 29 5d b0          	movaps XMMWORD PTR [rbp-0x50],xmm3
    283c:	0f 29 65 c0          	movaps XMMWORD PTR [rbp-0x40],xmm4
    2840:	0f 29 6d d0          	movaps XMMWORD PTR [rbp-0x30],xmm5
    2844:	0f 29 75 e0          	movaps XMMWORD PTR [rbp-0x20],xmm6
    2848:	0f 29 7d f0          	movaps XMMWORD PTR [rbp-0x10],xmm7
    284c:	b8 00 00 00 00       	mov    eax,0x0
    2851:	c9                   	leave
    2852:	c3                   	ret

0000000000002853 <memdump>:

void memdump(void* ofs, size_t sz)
{
    2853:	55                   	push   rbp
    2854:	48 89 e5             	mov    rbp,rsp
    2857:	48 83 ec 40          	sub    rsp,0x40
    285b:	48 89 7d c8          	mov    QWORD PTR [rbp-0x38],rdi
    285f:	48 89 75 c0          	mov    QWORD PTR [rbp-0x40],rsi
		size_t i, ct;

		printf("dumping memory at %p with size %u:\n", ofs, sz);
    2863:	48 8b 55 c0          	mov    rdx,QWORD PTR [rbp-0x40]
    2867:	48 8b 45 c8          	mov    rax,QWORD PTR [rbp-0x38]
    286b:	48 89 c6             	mov    rsi,rax
    286e:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2875:	b8 00 00 00 00       	mov    eax,0x0
    287a:	e8 00 00 00 00       	call   287f <memdump+0x2c>
		for (i = 0; i < sz; i += 16) {
    287f:	48 c7 45 f8 00 00 00 00 	mov    QWORD PTR [rbp-0x8],0x0
    2887:	e9 7a 01 00 00       	jmp    2a06 <memdump+0x1b3>
				uint16_t* mem = (uint16_t*)(ofs + i);
    288c:	48 8b 55 c8          	mov    rdx,QWORD PTR [rbp-0x38]
    2890:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2894:	48 01 d0             	add    rax,rdx
    2897:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
				uint8_t nbl = 41; /* 41 blanks until text output */
    289b:	c6 45 ef 29          	mov    BYTE PTR [rbp-0x11],0x29
				/* xxd-style output: 8 words and text */
				for (ct = 0; ct < 8; ct++) {
    289f:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
    28a7:	e9 b8 00 00 00       	jmp    2964 <memdump+0x111>
						if (i + 2 * ct <= sz - 2) {
    28ac:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    28b0:	48 8d 14 00          	lea    rdx,[rax+rax*1]
    28b4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    28b8:	48 01 d0             	add    rax,rdx
    28bb:	48 8b 55 c0          	mov    rdx,QWORD PTR [rbp-0x40]
    28bf:	48 83 ea 02          	sub    rdx,0x2
    28c3:	48 39 c2             	cmp    rdx,rax
    28c6:	72 4f                	jb     2917 <memdump+0xc4>
								printf("%04x ", ((mem[ct] << 8) & 0xff00) | (mem[ct] >> 8));
    28c8:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    28cc:	48 8d 14 00          	lea    rdx,[rax+rax*1]
    28d0:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    28d4:	48 01 d0             	add    rax,rdx
    28d7:	0f b7 00             	movzx  eax,WORD PTR [rax]
    28da:	0f b7 c0             	movzx  eax,ax
    28dd:	c1 e0 08             	shl    eax,0x8
    28e0:	0f b7 d0             	movzx  edx,ax
    28e3:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    28e7:	48 8d 0c 00          	lea    rcx,[rax+rax*1]
    28eb:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    28ef:	48 01 c8             	add    rax,rcx
    28f2:	0f b7 00             	movzx  eax,WORD PTR [rax]
    28f5:	66 c1 e8 08          	shr    ax,0x8
    28f9:	0f b7 c0             	movzx  eax,ax
    28fc:	09 d0                	or     eax,edx
    28fe:	89 c6                	mov    esi,eax
    2900:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2907:	b8 00 00 00 00       	mov    eax,0x0
    290c:	e8 00 00 00 00       	call   2911 <memdump+0xbe>
								nbl -= 5;
    2911:	80 6d ef 05          	sub    BYTE PTR [rbp-0x11],0x5
    2915:	eb 48                	jmp    295f <memdump+0x10c>
						} else if (i + 2 * ct == sz - 1) { /* ending on half word */
    2917:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    291b:	48 8d 14 00          	lea    rdx,[rax+rax*1]
    291f:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2923:	48 01 c2             	add    rdx,rax
    2926:	48 8b 45 c0          	mov    rax,QWORD PTR [rbp-0x40]
    292a:	48 83 e8 01          	sub    rax,0x1
    292e:	48 39 c2             	cmp    rdx,rax
    2931:	75 3e                	jne    2971 <memdump+0x11e>
								printf("%02x   ", *(uint8_t*)(mem + ct));
    2933:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    2937:	48 8d 14 00          	lea    rdx,[rax+rax*1]
    293b:	48 8b 45 e0          	mov    rax,QWORD PTR [rbp-0x20]
    293f:	48 01 d0             	add    rax,rdx
    2942:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    2945:	0f b6 c0             	movzx  eax,al
    2948:	89 c6                	mov    esi,eax
    294a:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
    2951:	b8 00 00 00 00       	mov    eax,0x0
    2956:	e8 00 00 00 00       	call   295b <memdump+0x108>
								nbl -= 5;
    295b:	80 6d ef 05          	sub    BYTE PTR [rbp-0x11],0x5
				for (ct = 0; ct < 8; ct++) {
    295f:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
    2964:	48 83 7d f0 07       	cmp    QWORD PTR [rbp-0x10],0x7
    2969:	0f 86 3d ff ff ff    	jbe    28ac <memdump+0x59>
    296f:	eb 0d                	jmp    297e <memdump+0x12b>
						} else
								break;
    2971:	90                   	nop
				}
				/* fill with blanks */
				while (nbl--)
    2972:	eb 0a                	jmp    297e <memdump+0x12b>
						putchar(' ');
    2974:	bf 20 00 00 00       	mov    edi,0x20
    2979:	e8 00 00 00 00       	call   297e <memdump+0x12b>
				while (nbl--)
    297e:	0f b6 45 ef          	movzx  eax,BYTE PTR [rbp-0x11]
    2982:	8d 50 ff             	lea    edx,[rax-0x1]
    2985:	88 55 ef             	mov    BYTE PTR [rbp-0x11],dl
    2988:	84 c0                	test   al,al
    298a:	75 e8                	jne    2974 <memdump+0x121>
				/* output the text */
				for (ct = 0; ct < 16; ct++) {
    298c:	48 c7 45 f0 00 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
    2994:	eb 57                	jmp    29ed <memdump+0x19a>
						char* c = (char*)mem + ct;
    2996:	48 8b 55 e0          	mov    rdx,QWORD PTR [rbp-0x20]
    299a:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    299e:	48 01 d0             	add    rax,rdx
    29a1:	48 89 45 d8          	mov    QWORD PTR [rbp-0x28],rax
						if (i + ct >= sz)
    29a5:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    29a9:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    29ad:	48 01 d0             	add    rax,rdx
    29b0:	48 3b 45 c0          	cmp    rax,QWORD PTR [rbp-0x40]
    29b4:	73 40                	jae    29f6 <memdump+0x1a3>
								break;
						if (isprint(*c))
    29b6:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    29ba:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    29bd:	0f be c0             	movsx  eax,al
    29c0:	89 c7                	mov    edi,eax
    29c2:	e8 00 00 00 00       	call   29c7 <memdump+0x174>
    29c7:	85 c0                	test   eax,eax
    29c9:	74 13                	je     29de <memdump+0x18b>
								putchar(*c);
    29cb:	48 8b 45 d8          	mov    rax,QWORD PTR [rbp-0x28]
    29cf:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    29d2:	0f be c0             	movsx  eax,al
    29d5:	89 c7                	mov    edi,eax
    29d7:	e8 00 00 00 00       	call   29dc <memdump+0x189>
    29dc:	eb 0a                	jmp    29e8 <memdump+0x195>
						else
								putchar('.');
    29de:	bf 2e 00 00 00       	mov    edi,0x2e
    29e3:	e8 00 00 00 00       	call   29e8 <memdump+0x195>
				for (ct = 0; ct < 16; ct++) {
    29e8:	48 83 45 f0 01       	add    QWORD PTR [rbp-0x10],0x1
    29ed:	48 83 7d f0 0f       	cmp    QWORD PTR [rbp-0x10],0xf
    29f2:	76 a2                	jbe    2996 <memdump+0x143>
    29f4:	eb 01                	jmp    29f7 <memdump+0x1a4>
								break;
    29f6:	90                   	nop
				}
				putchar('\n');
    29f7:	bf 0a 00 00 00       	mov    edi,0xa
    29fc:	e8 00 00 00 00       	call   2a01 <memdump+0x1ae>
		for (i = 0; i < sz; i += 16) {
    2a01:	48 83 45 f8 10       	add    QWORD PTR [rbp-0x8],0x10
    2a06:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    2a0a:	48 3b 45 c0          	cmp    rax,QWORD PTR [rbp-0x40]
    2a0e:	0f 82 78 fe ff ff    	jb     288c <memdump+0x39>
		}
}
    2a14:	90                   	nop
    2a15:	90                   	nop
    2a16:	c9                   	leave
    2a17:	c3                   	ret
