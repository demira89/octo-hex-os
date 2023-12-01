
kbd.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <outb>:
				if (scancode == 0x2a) { /* LSHIFT */
						kb_state |= KBD_STATE_LSHIFT;
						if (!(kb_state & KBD_STATE_SHIFT)) {
								kb_state |= KBD_STATE_SHIFT;
						}
						/*if (kb_state & KBD_STATE_NEXT_RIGHT) *//* fake lshift */
   0:	55                   	push   ebp
   1:	89 e5                	mov    ebp,esp
   3:	83 ec 08             	sub    esp,0x8
   6:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
   9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
   c:	66 89 55 fc          	mov    WORD PTR [ebp-0x4],dx
  10:	88 45 f8             	mov    BYTE PTR [ebp-0x8],al
						/*		kb_state &= ~KBD_STATE_NEXT_RIGHT;*/
  13:	0f b6 45 f8          	movzx  eax,BYTE PTR [ebp-0x8]
  17:	0f b7 55 fc          	movzx  edx,WORD PTR [ebp-0x4]
  1b:	ee                   	out    dx,al
				} else if (scancode == 0x36) { /* RSHIFT */
  1c:	90                   	nop
  1d:	c9                   	leave
  1e:	c3                   	ret

0000001f <inb>:
						kb_state |= KBD_STATE_RSHIFT;
						if (!(kb_state & KBD_STATE_SHIFT)) {
								kb_state |= KBD_STATE_SHIFT;
  1f:	55                   	push   ebp
  20:	89 e5                	mov    ebp,esp
  22:	83 ec 14             	sub    esp,0x14
  25:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
  28:	66 89 45 ec          	mov    WORD PTR [ebp-0x14],ax
						}
				} else if (scancode == 0x3a) { /* CAPS_LOCK */
  2c:	0f b7 45 ec          	movzx  eax,WORD PTR [ebp-0x14]
  30:	89 c2                	mov    edx,eax
  32:	ec                   	in     al,dx
  33:	88 45 ff             	mov    BYTE PTR [ebp-0x1],al
						if (!(kb_state & KBD_STATE_CAPS_LOCK)) {
  36:	0f b6 45 ff          	movzx  eax,BYTE PTR [ebp-0x1]
							kb_state |= KBD_STATE_CAPS_LOCK;
  3a:	c9                   	leave
  3b:	c3                   	ret

0000003c <kbd_fb_resize>:
{
  3c:	55                   	push   ebp
  3d:	89 e5                	mov    ebp,esp
		kb_reg.x = lx - 20;
  3f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
  42:	83 e8 14             	sub    eax,0x14
  45:	66 a3 00 00 00 00    	mov    ds:0x0,ax
		kb_reg.ly = ly - 12;
  4b:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
  4e:	83 e8 0c             	sub    eax,0xc
  51:	66 a3 06 00 00 00    	mov    ds:0x6,ax
		kb_regH.x = lx - 20;
  57:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
  5a:	83 e8 14             	sub    eax,0x14
  5d:	66 a3 00 00 00 00    	mov    ds:0x0,ax
		kb_regN.x = lx - 10;
  63:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
  66:	83 e8 0a             	sub    eax,0xa
  69:	66 a3 00 00 00 00    	mov    ds:0x0,ax
		kb_regN.y = ly - 2;
  6f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
  72:	83 e8 02             	sub    eax,0x2
  75:	66 a3 02 00 00 00    	mov    ds:0x2,ax
}
  7b:	90                   	nop
  7c:	5d                   	pop    ebp
  7d:	c3                   	ret

0000007e <kbd_init>:
{
  7e:	55                   	push   ebp
  7f:	89 e5                	mov    ebp,esp
  81:	83 ec 18             	sub    esp,0x18
		rb_events = ringbuffer_allocate(KBD_INIT_BUFSIZE);
  84:	83 ec 0c             	sub    esp,0xc
  87:	68 00 02 00 00       	push   0x200
  8c:	e8 fc ff ff ff       	call   8d <kbd_init+0xf>
  91:	83 c4 10             	add    esp,0x10
  94:	a3 00 00 00 00       	mov    ds:0x0,eax
		rb_commands = ringbuffer_allocate(KBD_INIT_BUFSIZE);
  99:	83 ec 0c             	sub    esp,0xc
  9c:	68 00 02 00 00       	push   0x200
  a1:	e8 fc ff ff ff       	call   a2 <kbd_init+0x24>
  a6:	83 c4 10             	add    esp,0x10
  a9:	a3 00 00 00 00       	mov    ds:0x0,eax
		region_clear(&kb_reg);
  ae:	83 ec 0c             	sub    esp,0xc
  b1:	68 00 00 00 00       	push   0x0
  b6:	e8 fc ff ff ff       	call   b7 <kbd_init+0x39>
  bb:	83 c4 10             	add    esp,0x10
		rprintf(&kb_regH, "    LGTNRRRLLLSSSSSS"
  be:	83 ec 08             	sub    esp,0x8
  c1:	68 00 00 00 00       	push   0x0
  c6:	68 00 00 00 00       	push   0x0
  cb:	e8 fc ff ff ff       	call   cc <kbd_init+0x4e>
  d0:	83 c4 10             	add    esp,0x10
		cmd = KBC_RESET;
  d3:	c6 45 f7 01          	mov    BYTE PTR [ebp-0x9],0x1
		ringbuffer_enqueue(rb_commands, &cmd, sizeof(cmd));
  d7:	a1 00 00 00 00       	mov    eax,ds:0x0
  dc:	83 ec 04             	sub    esp,0x4
  df:	6a 01                	push   0x1
  e1:	8d 55 f7             	lea    edx,[ebp-0x9]
  e4:	52                   	push   edx
  e5:	50                   	push   eax
  e6:	e8 fc ff ff ff       	call   e7 <kbd_init+0x69>
  eb:	83 c4 10             	add    esp,0x10
}
  ee:	90                   	nop
  ef:	c9                   	leave
  f0:	c3                   	ret

000000f1 <kbd_wait>:
{
  f1:	55                   	push   ebp
  f2:	89 e5                	mov    ebp,esp
		while (!(inb(KBD_CH4) & 1));
  f4:	90                   	nop
  f5:	6a 64                	push   0x64
  f7:	e8 23 ff ff ff       	call   1f <inb>
  fc:	83 c4 04             	add    esp,0x4
  ff:	0f b6 c0             	movzx  eax,al
 102:	83 e0 01             	and    eax,0x1
 105:	85 c0                	test   eax,eax
 107:	74 ec                	je     f5 <kbd_wait+0x4>
}
 109:	90                   	nop
 10a:	90                   	nop
 10b:	c9                   	leave
 10c:	c3                   	ret

0000010d <kbd_process_queue>:
{
 10d:	55                   	push   ebp
 10e:	89 e5                	mov    ebp,esp
 110:	83 ec 18             	sub    esp,0x18
		preempt_disable();
 113:	e8 fc ff ff ff       	call   114 <kbd_process_queue+0x7>
 118:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
 11b:	83 c2 01             	add    edx,0x1
 11e:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
		while ((s = ringbuffer_available(rb_commands))) {
 121:	e9 28 02 00 00       	jmp    34e <kbd_process_queue+0x241>
				uint8_t cmd, a1, a2, nr = 0;
 126:	c6 45 f5 00          	mov    BYTE PTR [ebp-0xb],0x0
				ringbuffer_dequeue(rb_commands, &cmd, sizeof(cmd));
 12a:	a1 00 00 00 00       	mov    eax,ds:0x0
 12f:	83 ec 04             	sub    esp,0x4
 132:	6a 01                	push   0x1
 134:	8d 55 ef             	lea    edx,[ebp-0x11]
 137:	52                   	push   edx
 138:	50                   	push   eax
 139:	e8 fc ff ff ff       	call   13a <kbd_process_queue+0x2d>
 13e:	83 c4 10             	add    esp,0x10
				rprintf(&kb_reg, "handling command %x\n", cmd);
 141:	0f b6 45 ef          	movzx  eax,BYTE PTR [ebp-0x11]
 145:	0f b6 c0             	movzx  eax,al
 148:	83 ec 04             	sub    esp,0x4
 14b:	50                   	push   eax
 14c:	68 51 00 00 00       	push   0x51
 151:	68 00 00 00 00       	push   0x0
 156:	e8 fc ff ff ff       	call   157 <kbd_process_queue+0x4a>
 15b:	83 c4 10             	add    esp,0x10
				switch (cmd) {
 15e:	0f b6 45 ef          	movzx  eax,BYTE PTR [ebp-0x11]
 162:	0f b6 c0             	movzx  eax,al
 165:	83 f8 04             	cmp    eax,0x4
 168:	0f 84 1d 01 00 00    	je     28b <kbd_process_queue+0x17e>
 16e:	83 f8 04             	cmp    eax,0x4
 171:	0f 8f 8c 01 00 00    	jg     303 <kbd_process_queue+0x1f6>
 177:	83 f8 03             	cmp    eax,0x3
 17a:	74 6a                	je     1e6 <kbd_process_queue+0xd9>
 17c:	83 f8 03             	cmp    eax,0x3
 17f:	0f 8f 7e 01 00 00    	jg     303 <kbd_process_queue+0x1f6>
 185:	83 f8 01             	cmp    eax,0x1
 188:	74 0e                	je     198 <kbd_process_queue+0x8b>
 18a:	83 f8 02             	cmp    eax,0x2
 18d:	0f 84 83 00 00 00    	je     216 <kbd_process_queue+0x109>
								break;
 193:	e9 6b 01 00 00       	jmp    303 <kbd_process_queue+0x1f6>
								outb(KBD_CH0, 0xff);
 198:	83 ec 08             	sub    esp,0x8
 19b:	68 ff 00 00 00       	push   0xff
 1a0:	6a 60                	push   0x60
 1a2:	e8 59 fe ff ff       	call   0 <outb>
 1a7:	83 c4 10             	add    esp,0x10
								a1 = inb(KBD_CH0);
 1aa:	83 ec 0c             	sub    esp,0xc
 1ad:	6a 60                	push   0x60
 1af:	e8 6b fe ff ff       	call   1f <inb>
 1b4:	83 c4 10             	add    esp,0x10
 1b7:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
								nr = 1;
 1ba:	c6 45 f5 01          	mov    BYTE PTR [ebp-0xb],0x1
								if (a1 == 0xfa) {
 1be:	80 7d f7 fa          	cmp    BYTE PTR [ebp-0x9],0xfa
 1c2:	0f 85 3e 01 00 00    	jne    306 <kbd_process_queue+0x1f9>
										kbd_wait();
 1c8:	e8 fc ff ff ff       	call   1c9 <kbd_process_queue+0xbc>
										a2 = inb(KBD_CH0);
 1cd:	83 ec 0c             	sub    esp,0xc
 1d0:	6a 60                	push   0x60
 1d2:	e8 48 fe ff ff       	call   1f <inb>
 1d7:	83 c4 10             	add    esp,0x10
 1da:	88 45 f6             	mov    BYTE PTR [ebp-0xa],al
										nr = 2;
 1dd:	c6 45 f5 02          	mov    BYTE PTR [ebp-0xb],0x2
								break;
 1e1:	e9 20 01 00 00       	jmp    306 <kbd_process_queue+0x1f9>
								outb(KBD_CH0, 0xf4);
 1e6:	83 ec 08             	sub    esp,0x8
 1e9:	68 f4 00 00 00       	push   0xf4
 1ee:	6a 60                	push   0x60
 1f0:	e8 0b fe ff ff       	call   0 <outb>
 1f5:	83 c4 10             	add    esp,0x10
								kbd_wait();
 1f8:	e8 fc ff ff ff       	call   1f9 <kbd_process_queue+0xec>
								a1 = inb(KBD_CH0);
 1fd:	83 ec 0c             	sub    esp,0xc
 200:	6a 60                	push   0x60
 202:	e8 18 fe ff ff       	call   1f <inb>
 207:	83 c4 10             	add    esp,0x10
 20a:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
								nr = 1;
 20d:	c6 45 f5 01          	mov    BYTE PTR [ebp-0xb],0x1
								break;
 211:	e9 f4 00 00 00       	jmp    30a <kbd_process_queue+0x1fd>
								outb(KBD_CH0, 0xf5);
 216:	83 ec 08             	sub    esp,0x8
 219:	68 f5 00 00 00       	push   0xf5
 21e:	6a 60                	push   0x60
 220:	e8 db fd ff ff       	call   0 <outb>
 225:	83 c4 10             	add    esp,0x10
								kbd_wait();
 228:	e8 fc ff ff ff       	call   229 <kbd_process_queue+0x11c>
								a2 = inb(KBD_CH4);
 22d:	83 ec 0c             	sub    esp,0xc
 230:	6a 64                	push   0x64
 232:	e8 e8 fd ff ff       	call   1f <inb>
 237:	83 c4 10             	add    esp,0x10
 23a:	88 45 f6             	mov    BYTE PTR [ebp-0xa],al
								while ((a1 = inb(KBD_CH0))) {
 23d:	eb 2d                	jmp    26c <kbd_process_queue+0x15f>
										if (a1 == 0xfa || a1 == 0x00 || a1 == 0xfe)
 23f:	80 7d f7 fa          	cmp    BYTE PTR [ebp-0x9],0xfa
 243:	74 40                	je     285 <kbd_process_queue+0x178>
 245:	80 7d f7 00          	cmp    BYTE PTR [ebp-0x9],0x0
 249:	74 3a                	je     285 <kbd_process_queue+0x178>
 24b:	80 7d f7 fe          	cmp    BYTE PTR [ebp-0x9],0xfe
 24f:	74 34                	je     285 <kbd_process_queue+0x178>
										if (a2 & (1 << 5)) /* read sth useful */
 251:	0f b6 45 f6          	movzx  eax,BYTE PTR [ebp-0xa]
 255:	83 e0 20             	and    eax,0x20
 258:	85 c0                	test   eax,eax
 25a:	74 28                	je     284 <kbd_process_queue+0x177>
												kbd_handle_sc(a1); /* watch out for ff and fe too */
 25c:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
 260:	83 ec 0c             	sub    esp,0xc
 263:	50                   	push   eax
 264:	e8 fc ff ff ff       	call   265 <kbd_process_queue+0x158>
 269:	83 c4 10             	add    esp,0x10
								while ((a1 = inb(KBD_CH0))) {
 26c:	83 ec 0c             	sub    esp,0xc
 26f:	6a 60                	push   0x60
 271:	e8 a9 fd ff ff       	call   1f <inb>
 276:	83 c4 10             	add    esp,0x10
 279:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
 27c:	80 7d f7 00          	cmp    BYTE PTR [ebp-0x9],0x0
 280:	75 bd                	jne    23f <kbd_process_queue+0x132>
 282:	eb 01                	jmp    285 <kbd_process_queue+0x178>
												break;
 284:	90                   	nop
								nr = 1;
 285:	c6 45 f5 01          	mov    BYTE PTR [ebp-0xb],0x1
								break;
 289:	eb 7f                	jmp    30a <kbd_process_queue+0x1fd>
								outb(KBD_CH0, 0xed);
 28b:	83 ec 08             	sub    esp,0x8
 28e:	68 ed 00 00 00       	push   0xed
 293:	6a 60                	push   0x60
 295:	e8 66 fd ff ff       	call   0 <outb>
 29a:	83 c4 10             	add    esp,0x10
								kbd_wait();
 29d:	e8 fc ff ff ff       	call   29e <kbd_process_queue+0x191>
								a1 = inb(KBD_CH0);
 2a2:	83 ec 0c             	sub    esp,0xc
 2a5:	6a 60                	push   0x60
 2a7:	e8 73 fd ff ff       	call   1f <inb>
 2ac:	83 c4 10             	add    esp,0x10
 2af:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
								nr = 1;
 2b2:	c6 45 f5 01          	mov    BYTE PTR [ebp-0xb],0x1
								ringbuffer_dequeue(rb_commands, &cmd, sizeof(cmd));
 2b6:	a1 00 00 00 00       	mov    eax,ds:0x0
 2bb:	83 ec 04             	sub    esp,0x4
 2be:	6a 01                	push   0x1
 2c0:	8d 55 ef             	lea    edx,[ebp-0x11]
 2c3:	52                   	push   edx
 2c4:	50                   	push   eax
 2c5:	e8 fc ff ff ff       	call   2c6 <kbd_process_queue+0x1b9>
 2ca:	83 c4 10             	add    esp,0x10
								if (a1 == 0xfa) {
 2cd:	80 7d f7 fa          	cmp    BYTE PTR [ebp-0x9],0xfa
 2d1:	75 36                	jne    309 <kbd_process_queue+0x1fc>
										outb(KBD_CH0, cmd);
 2d3:	0f b6 45 ef          	movzx  eax,BYTE PTR [ebp-0x11]
 2d7:	0f b6 c0             	movzx  eax,al
 2da:	83 ec 08             	sub    esp,0x8
 2dd:	50                   	push   eax
 2de:	6a 60                	push   0x60
 2e0:	e8 1b fd ff ff       	call   0 <outb>
 2e5:	83 c4 10             	add    esp,0x10
										kbd_wait();
 2e8:	e8 fc ff ff ff       	call   2e9 <kbd_process_queue+0x1dc>
										a2 = inb(KBD_CH0);
 2ed:	83 ec 0c             	sub    esp,0xc
 2f0:	6a 60                	push   0x60
 2f2:	e8 28 fd ff ff       	call   1f <inb>
 2f7:	83 c4 10             	add    esp,0x10
 2fa:	88 45 f6             	mov    BYTE PTR [ebp-0xa],al
										nr = 2;
 2fd:	c6 45 f5 02          	mov    BYTE PTR [ebp-0xb],0x2
								break;
 301:	eb 06                	jmp    309 <kbd_process_queue+0x1fc>
								break;
 303:	90                   	nop
 304:	eb 04                	jmp    30a <kbd_process_queue+0x1fd>
								break;
 306:	90                   	nop
 307:	eb 01                	jmp    30a <kbd_process_queue+0x1fd>
								break;
 309:	90                   	nop
				if (nr == 1)
 30a:	80 7d f5 01          	cmp    BYTE PTR [ebp-0xb],0x1
 30e:	75 1c                	jne    32c <kbd_process_queue+0x21f>
						rprintf(&kb_reg, "response %x\n", a1);
 310:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
 314:	83 ec 04             	sub    esp,0x4
 317:	50                   	push   eax
 318:	68 66 00 00 00       	push   0x66
 31d:	68 00 00 00 00       	push   0x0
 322:	e8 fc ff ff ff       	call   323 <kbd_process_queue+0x216>
 327:	83 c4 10             	add    esp,0x10
 32a:	eb 22                	jmp    34e <kbd_process_queue+0x241>
				else if (nr == 2)
 32c:	80 7d f5 02          	cmp    BYTE PTR [ebp-0xb],0x2
 330:	75 1c                	jne    34e <kbd_process_queue+0x241>
						rprintf(&kb_reg, "responses %x %x\n", a1, a2);
 332:	0f b6 55 f6          	movzx  edx,BYTE PTR [ebp-0xa]
 336:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
 33a:	52                   	push   edx
 33b:	50                   	push   eax
 33c:	68 73 00 00 00       	push   0x73
 341:	68 00 00 00 00       	push   0x0
 346:	e8 fc ff ff ff       	call   347 <kbd_process_queue+0x23a>
 34b:	83 c4 10             	add    esp,0x10
		while ((s = ringbuffer_available(rb_commands))) {
 34e:	a1 00 00 00 00       	mov    eax,ds:0x0
 353:	83 ec 0c             	sub    esp,0xc
 356:	50                   	push   eax
 357:	e8 fc ff ff ff       	call   358 <kbd_process_queue+0x24b>
 35c:	83 c4 10             	add    esp,0x10
 35f:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
 362:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
 366:	0f 85 ba fd ff ff    	jne    126 <kbd_process_queue+0x19>
		preempt_enable();
 36c:	e8 fc ff ff ff       	call   36d <kbd_process_queue+0x260>
 371:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
 374:	83 ea 01             	sub    edx,0x1
 377:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
 37a:	e8 fc ff ff ff       	call   37b <kbd_process_queue+0x26e>
 37f:	8b 00                	mov    eax,DWORD PTR [eax]
 381:	83 e0 01             	and    eax,0x1
 384:	85 c0                	test   eax,eax
 386:	74 05                	je     38d <kbd_process_queue+0x280>
 388:	e8 fc ff ff ff       	call   389 <kbd_process_queue+0x27c>
}
 38d:	90                   	nop
 38e:	c9                   	leave
 38f:	c3                   	ret

00000390 <kbd_event_present>:
{
 390:	55                   	push   ebp
 391:	89 e5                	mov    ebp,esp
 393:	83 ec 08             	sub    esp,0x8
		return ringbuffer_available(rb_events) / sizeof(struct key_event);
 396:	a1 00 00 00 00       	mov    eax,ds:0x0
 39b:	83 ec 0c             	sub    esp,0xc
 39e:	50                   	push   eax
 39f:	e8 fc ff ff ff       	call   3a0 <kbd_event_present+0x10>
 3a4:	83 c4 10             	add    esp,0x10
 3a7:	c1 e8 02             	shr    eax,0x2
}
 3aa:	c9                   	leave
 3ab:	c3                   	ret

000003ac <kbd_get_event>:
{
 3ac:	55                   	push   ebp
 3ad:	89 e5                	mov    ebp,esp
 3af:	83 ec 18             	sub    esp,0x18
		ringbuffer_dequeue(rb_events, &rv, sizeof(rv));
 3b2:	a1 00 00 00 00       	mov    eax,ds:0x0
 3b7:	83 ec 04             	sub    esp,0x4
 3ba:	6a 04                	push   0x4
 3bc:	8d 55 f4             	lea    edx,[ebp-0xc]
 3bf:	52                   	push   edx
 3c0:	50                   	push   eax
 3c1:	e8 fc ff ff ff       	call   3c2 <kbd_get_event+0x16>
 3c6:	83 c4 10             	add    esp,0x10
		return rv;
 3c9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 3cc:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
 3cf:	89 10                	mov    DWORD PTR [eax],edx
}
 3d1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 3d4:	c9                   	leave
 3d5:	c2 04 00             	ret    0x4

000003d8 <kbd_lights_update>:
{
 3d8:	55                   	push   ebp
 3d9:	89 e5                	mov    ebp,esp
 3db:	83 ec 18             	sub    esp,0x18
		cmd = KBC_DISABLE;
 3de:	c6 45 f7 02          	mov    BYTE PTR [ebp-0x9],0x2
		ringbuffer_enqueue(rb_commands, &cmd, sizeof(cmd));
 3e2:	a1 00 00 00 00       	mov    eax,ds:0x0
 3e7:	83 ec 04             	sub    esp,0x4
 3ea:	6a 01                	push   0x1
 3ec:	8d 55 f7             	lea    edx,[ebp-0x9]
 3ef:	52                   	push   edx
 3f0:	50                   	push   eax
 3f1:	e8 fc ff ff ff       	call   3f2 <kbd_lights_update+0x1a>
 3f6:	83 c4 10             	add    esp,0x10
		cmd = KBC_SET_LIGHTS;
 3f9:	c6 45 f7 04          	mov    BYTE PTR [ebp-0x9],0x4
		ringbuffer_enqueue(rb_commands, &cmd, sizeof(cmd));
 3fd:	a1 00 00 00 00       	mov    eax,ds:0x0
 402:	83 ec 04             	sub    esp,0x4
 405:	6a 01                	push   0x1
 407:	8d 55 f7             	lea    edx,[ebp-0x9]
 40a:	52                   	push   edx
 40b:	50                   	push   eax
 40c:	e8 fc ff ff ff       	call   40d <kbd_lights_update+0x35>
 411:	83 c4 10             	add    esp,0x10
		cmd = (kb_state & KBD_LIGHT_MASK) >> 13;
 414:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 41b:	66 c1 e8 0d          	shr    ax,0xd
 41f:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
		ringbuffer_enqueue(rb_commands, &cmd, sizeof(cmd));
 422:	a1 00 00 00 00       	mov    eax,ds:0x0
 427:	83 ec 04             	sub    esp,0x4
 42a:	6a 01                	push   0x1
 42c:	8d 55 f7             	lea    edx,[ebp-0x9]
 42f:	52                   	push   edx
 430:	50                   	push   eax
 431:	e8 fc ff ff ff       	call   432 <kbd_lights_update+0x5a>
 436:	83 c4 10             	add    esp,0x10
		cmd = KBC_ENABLE;
 439:	c6 45 f7 03          	mov    BYTE PTR [ebp-0x9],0x3
		ringbuffer_enqueue(rb_commands, &cmd, sizeof(cmd));
 43d:	a1 00 00 00 00       	mov    eax,ds:0x0
 442:	83 ec 04             	sub    esp,0x4
 445:	6a 01                	push   0x1
 447:	8d 55 f7             	lea    edx,[ebp-0x9]
 44a:	52                   	push   edx
 44b:	50                   	push   eax
 44c:	e8 fc ff ff ff       	call   44d <kbd_lights_update+0x75>
 451:	83 c4 10             	add    esp,0x10
		kb_regN.cur_x = kb_regN.cur_y = 0;
 454:	66 c7 05 10 00 00 00 00 00 	mov    WORD PTR ds:0x10,0x0
 45d:	0f b7 05 10 00 00 00 	movzx  eax,WORD PTR ds:0x10
 464:	66 a3 0e 00 00 00    	mov    ds:0xe,ax
		region_putchar(&kb_regN, (kb_state & KBD_LIGHT_NUM_LOCK) ? '#' : ' ');
 46a:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 471:	0f b7 c0             	movzx  eax,ax
 474:	25 00 40 00 00       	and    eax,0x4000
 479:	85 c0                	test   eax,eax
 47b:	74 07                	je     484 <kbd_lights_update+0xac>
 47d:	b8 23 00 00 00       	mov    eax,0x23
 482:	eb 05                	jmp    489 <kbd_lights_update+0xb1>
 484:	b8 20 00 00 00       	mov    eax,0x20
 489:	83 ec 08             	sub    esp,0x8
 48c:	50                   	push   eax
 48d:	68 00 00 00 00       	push   0x0
 492:	e8 fc ff ff ff       	call   493 <kbd_lights_update+0xbb>
 497:	83 c4 10             	add    esp,0x10
		region_putchar(&kb_regN, (kb_state & KBD_LIGHT_CAPS_LOCK) ? '#' : ' ');
 49a:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 4a1:	66 85 c0             	test   ax,ax
 4a4:	79 07                	jns    4ad <kbd_lights_update+0xd5>
 4a6:	b8 23 00 00 00       	mov    eax,0x23
 4ab:	eb 05                	jmp    4b2 <kbd_lights_update+0xda>
 4ad:	b8 20 00 00 00       	mov    eax,0x20
 4b2:	83 ec 08             	sub    esp,0x8
 4b5:	50                   	push   eax
 4b6:	68 00 00 00 00       	push   0x0
 4bb:	e8 fc ff ff ff       	call   4bc <kbd_lights_update+0xe4>
 4c0:	83 c4 10             	add    esp,0x10
		region_putchar(&kb_regN, (kb_state & KBD_LIGHT_SCROLL_LOCK) ? '#' : ' ');
 4c3:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 4ca:	0f b7 c0             	movzx  eax,ax
 4cd:	25 00 20 00 00       	and    eax,0x2000
 4d2:	85 c0                	test   eax,eax
 4d4:	74 07                	je     4dd <kbd_lights_update+0x105>
 4d6:	b8 23 00 00 00       	mov    eax,0x23
 4db:	eb 05                	jmp    4e2 <kbd_lights_update+0x10a>
 4dd:	b8 20 00 00 00       	mov    eax,0x20
 4e2:	83 ec 08             	sub    esp,0x8
 4e5:	50                   	push   eax
 4e6:	68 00 00 00 00       	push   0x0
 4eb:	e8 fc ff ff ff       	call   4ec <kbd_lights_update+0x114>
 4f0:	83 c4 10             	add    esp,0x10
}
 4f3:	90                   	nop
 4f4:	c9                   	leave
 4f5:	c3                   	ret

000004f6 <kbd_handler>:
{
 4f6:	55                   	push   ebp
 4f7:	89 e5                	mov    ebp,esp
 4f9:	83 ec 18             	sub    esp,0x18
		if (!rb_events || !rb_commands) /* don't corrupt memory */
 4fc:	a1 00 00 00 00       	mov    eax,ds:0x0
 501:	85 c0                	test   eax,eax
 503:	74 70                	je     575 <kbd_handler+0x7f>
 505:	a1 00 00 00 00       	mov    eax,ds:0x0
 50a:	85 c0                	test   eax,eax
 50c:	74 67                	je     575 <kbd_handler+0x7f>
				sc = inb(KBD_CH0);
 50e:	6a 60                	push   0x60
 510:	e8 0a fb ff ff       	call   1f <inb>
 515:	83 c4 04             	add    esp,0x4
 518:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
				if (sc != 0xfa && sc != 0xfe && sc != 0x00 && sc != 0xff)
 51b:	80 7d f7 fa          	cmp    BYTE PTR [ebp-0x9],0xfa
 51f:	74 22                	je     543 <kbd_handler+0x4d>
 521:	80 7d f7 fe          	cmp    BYTE PTR [ebp-0x9],0xfe
 525:	74 1c                	je     543 <kbd_handler+0x4d>
 527:	80 7d f7 00          	cmp    BYTE PTR [ebp-0x9],0x0
 52b:	74 16                	je     543 <kbd_handler+0x4d>
 52d:	80 7d f7 ff          	cmp    BYTE PTR [ebp-0x9],0xff
 531:	74 10                	je     543 <kbd_handler+0x4d>
						kbd_handle_sc(sc);
 533:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
 537:	83 ec 0c             	sub    esp,0xc
 53a:	50                   	push   eax
 53b:	e8 fc ff ff ff       	call   53c <kbd_handler+0x46>
 540:	83 c4 10             	add    esp,0x10
		} while ((inb(KBD_CH4) & 1));
 543:	83 ec 0c             	sub    esp,0xc
 546:	6a 64                	push   0x64
 548:	e8 d2 fa ff ff       	call   1f <inb>
 54d:	83 c4 10             	add    esp,0x10
 550:	0f b6 c0             	movzx  eax,al
 553:	83 e0 01             	and    eax,0x1
 556:	85 c0                	test   eax,eax
 558:	75 b4                	jne    50e <kbd_handler+0x18>
		if (kbd_event_present())
 55a:	e8 fc ff ff ff       	call   55b <kbd_handler+0x65>
 55f:	85 c0                	test   eax,eax
 561:	74 13                	je     576 <kbd_handler+0x80>
				wake_up_external_event(&wq_kbd);
 563:	83 ec 0c             	sub    esp,0xc
 566:	68 00 00 00 00       	push   0x0
 56b:	e8 fc ff ff ff       	call   56c <kbd_handler+0x76>
 570:	83 c4 10             	add    esp,0x10
 573:	eb 01                	jmp    576 <kbd_handler+0x80>
				return;
 575:	90                   	nop
}
 576:	c9                   	leave
 577:	c3                   	ret

00000578 <kbd_handle_sc>:
{
 578:	55                   	push   ebp
 579:	89 e5                	mov    ebp,esp
 57b:	83 ec 28             	sub    esp,0x28
 57e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 581:	88 45 e4             	mov    BYTE PTR [ebp-0x1c],al
		ke.prs = !(scancode & 0x80);
 584:	0f b6 45 e4          	movzx  eax,BYTE PTR [ebp-0x1c]
 588:	f7 d0                	not    eax
 58a:	c0 e8 07             	shr    al,0x7
 58d:	88 45 f2             	mov    BYTE PTR [ebp-0xe],al
		ke.state = kb_state;
 590:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 597:	66 89 45 f4          	mov    WORD PTR [ebp-0xc],ax
		ke.sc = scancode & 0x7f;
 59b:	0f b6 45 e4          	movzx  eax,BYTE PTR [ebp-0x1c]
 59f:	83 e0 7f             	and    eax,0x7f
 5a2:	88 45 f3             	mov    BYTE PTR [ebp-0xd],al
		ringbuffer_enqueue(rb_events, &ke, sizeof(ke));
 5a5:	a1 00 00 00 00       	mov    eax,ds:0x0
 5aa:	83 ec 04             	sub    esp,0x4
 5ad:	6a 04                	push   0x4
 5af:	8d 55 f2             	lea    edx,[ebp-0xe]
 5b2:	52                   	push   edx
 5b3:	50                   	push   eax
 5b4:	e8 fc ff ff ff       	call   5b5 <kbd_handle_sc+0x3d>
 5b9:	83 c4 10             	add    esp,0x10
		if (scancode & 0x80) {
 5bc:	0f b6 45 e4          	movzx  eax,BYTE PTR [ebp-0x1c]
 5c0:	84 c0                	test   al,al
 5c2:	0f 89 66 02 00 00    	jns    82e <kbd_handle_sc+0x2b6>
				scs = scancode;
 5c8:	0f b6 45 e4          	movzx  eax,BYTE PTR [ebp-0x1c]
 5cc:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
				scancode ^= 0x80;
 5cf:	80 75 e4 80          	xor    BYTE PTR [ebp-0x1c],0x80
				if (scancode == 0x3a) { /* CAPS_LOCK */
 5d3:	80 7d e4 3a          	cmp    BYTE PTR [ebp-0x1c],0x3a
 5d7:	75 2a                	jne    603 <kbd_handle_sc+0x8b>
						if (kb_state & KBD_STATE_CAPS_LOCK) {
 5d9:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 5e0:	0f b7 c0             	movzx  eax,ax
 5e3:	83 e0 04             	and    eax,0x4
 5e6:	85 c0                	test   eax,eax
 5e8:	0f 84 e8 01 00 00    	je     7d6 <kbd_handle_sc+0x25e>
								kb_state &= ~KBD_STATE_CAPS_LOCK;
 5ee:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 5f5:	83 e0 fb             	and    eax,0xfffffffb
 5f8:	66 a3 00 00 00 00    	mov    ds:0x0,ax
 5fe:	e9 d3 01 00 00       	jmp    7d6 <kbd_handle_sc+0x25e>
				} else if (scancode == 0x46) { /* SCROLL LOCK */
 603:	80 7d e4 46          	cmp    BYTE PTR [ebp-0x1c],0x46
 607:	75 2a                	jne    633 <kbd_handle_sc+0xbb>
						if (kb_state & KBD_STATE_SCROLL_LOCK) {
 609:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 610:	0f b7 c0             	movzx  eax,ax
 613:	83 e0 01             	and    eax,0x1
 616:	85 c0                	test   eax,eax
 618:	0f 84 b8 01 00 00    	je     7d6 <kbd_handle_sc+0x25e>
								kb_state &= ~KBD_STATE_SCROLL_LOCK;
 61e:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 625:	83 e0 fe             	and    eax,0xfffffffe
 628:	66 a3 00 00 00 00    	mov    ds:0x0,ax
 62e:	e9 a3 01 00 00       	jmp    7d6 <kbd_handle_sc+0x25e>
				} else if (scancode == 0x45) { /* NUM LOCK */
 633:	80 7d e4 45          	cmp    BYTE PTR [ebp-0x1c],0x45
 637:	75 2a                	jne    663 <kbd_handle_sc+0xeb>
						if (kb_state & KBD_STATE_NUM_LOCK) {
 639:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 640:	0f b7 c0             	movzx  eax,ax
 643:	83 e0 02             	and    eax,0x2
 646:	85 c0                	test   eax,eax
 648:	0f 84 88 01 00 00    	je     7d6 <kbd_handle_sc+0x25e>
								kb_state &= ~KBD_STATE_NUM_LOCK;
 64e:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 655:	83 e0 fd             	and    eax,0xfffffffd
 658:	66 a3 00 00 00 00    	mov    ds:0x0,ax
 65e:	e9 73 01 00 00       	jmp    7d6 <kbd_handle_sc+0x25e>
				} else if (scancode == 0x60) { /* RIGHT signalling */
 663:	80 7d e4 60          	cmp    BYTE PTR [ebp-0x1c],0x60
 667:	75 2c                	jne    695 <kbd_handle_sc+0x11d>
						if (!(kb_state & KBD_STATE_NEXT_RIGHT)) {
 669:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 670:	0f b7 c0             	movzx  eax,ax
 673:	25 00 10 00 00       	and    eax,0x1000
 678:	85 c0                	test   eax,eax
 67a:	0f 85 56 01 00 00    	jne    7d6 <kbd_handle_sc+0x25e>
								kb_state |= KBD_STATE_NEXT_RIGHT;
 680:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 687:	80 cc 10             	or     ah,0x10
 68a:	66 a3 00 00 00 00    	mov    ds:0x0,ax
 690:	e9 41 01 00 00       	jmp    7d6 <kbd_handle_sc+0x25e>
				} else if (scancode == 0x2a) { /* LSHIFT */
 695:	80 7d e4 2a          	cmp    BYTE PTR [ebp-0x1c],0x2a
 699:	75 3c                	jne    6d7 <kbd_handle_sc+0x15f>
						kb_state &= ~KBD_STATE_LSHIFT;
 69b:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 6a2:	80 e4 fe             	and    ah,0xfe
 6a5:	66 a3 00 00 00 00    	mov    ds:0x0,ax
						if (!(kb_state & KBD_STATE_RSHIFT))
 6ab:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 6b2:	0f b7 c0             	movzx  eax,ax
 6b5:	25 00 08 00 00       	and    eax,0x800
 6ba:	85 c0                	test   eax,eax
 6bc:	0f 85 14 01 00 00    	jne    7d6 <kbd_handle_sc+0x25e>
								kb_state &= ~KBD_STATE_SHIFT;
 6c2:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 6c9:	83 e0 df             	and    eax,0xffffffdf
 6cc:	66 a3 00 00 00 00    	mov    ds:0x0,ax
 6d2:	e9 ff 00 00 00       	jmp    7d6 <kbd_handle_sc+0x25e>
				} else if (scancode == 0x36) { /* RSHIFT */
 6d7:	80 7d e4 36          	cmp    BYTE PTR [ebp-0x1c],0x36
 6db:	75 3c                	jne    719 <kbd_handle_sc+0x1a1>
						kb_state &= ~KBD_STATE_RSHIFT;
 6dd:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 6e4:	80 e4 f7             	and    ah,0xf7
 6e7:	66 a3 00 00 00 00    	mov    ds:0x0,ax
						if (!(kb_state & KBD_STATE_LSHIFT))
 6ed:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 6f4:	0f b7 c0             	movzx  eax,ax
 6f7:	25 00 01 00 00       	and    eax,0x100
 6fc:	85 c0                	test   eax,eax
 6fe:	0f 85 d2 00 00 00    	jne    7d6 <kbd_handle_sc+0x25e>
								kb_state &= ~KBD_STATE_SHIFT;
 704:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 70b:	83 e0 df             	and    eax,0xffffffdf
 70e:	66 a3 00 00 00 00    	mov    ds:0x0,ax
 714:	e9 bd 00 00 00       	jmp    7d6 <kbd_handle_sc+0x25e>
				} else if (scancode == 0x1d) { /* L/R CONTROL */
 719:	80 7d e4 1d          	cmp    BYTE PTR [ebp-0x1c],0x1d
 71d:	75 5a                	jne    779 <kbd_handle_sc+0x201>
						if (kb_state & KBD_STATE_NEXT_RIGHT) {
 71f:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 726:	0f b7 c0             	movzx  eax,ax
 729:	25 00 10 00 00       	and    eax,0x1000
 72e:	85 c0                	test   eax,eax
 730:	74 12                	je     744 <kbd_handle_sc+0x1cc>
								kb_state &= ~KBD_STATE_RCONTROL;
 732:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 739:	80 e4 fd             	and    ah,0xfd
 73c:	66 a3 00 00 00 00    	mov    ds:0x0,ax
 742:	eb 10                	jmp    754 <kbd_handle_sc+0x1dc>
								kb_state &= ~KBD_STATE_LCONTROL;
 744:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 74b:	83 e0 bf             	and    eax,0xffffffbf
 74e:	66 a3 00 00 00 00    	mov    ds:0x0,ax
						if (!(kb_state & (KBD_STATE_LCONTROL | KBD_STATE_RCONTROL)))
 754:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 75b:	0f b7 c0             	movzx  eax,ax
 75e:	25 40 02 00 00       	and    eax,0x240
 763:	85 c0                	test   eax,eax
 765:	75 6f                	jne    7d6 <kbd_handle_sc+0x25e>
								kb_state &= ~KBD_STATE_CONTROL;
 767:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 76e:	83 e0 f7             	and    eax,0xfffffff7
 771:	66 a3 00 00 00 00    	mov    ds:0x0,ax
 777:	eb 5d                	jmp    7d6 <kbd_handle_sc+0x25e>
				} else if (scancode == 0x38) { /* L/R ALT */
 779:	80 7d e4 38          	cmp    BYTE PTR [ebp-0x1c],0x38
 77d:	75 57                	jne    7d6 <kbd_handle_sc+0x25e>
						if (kb_state & KBD_STATE_NEXT_RIGHT) {
 77f:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 786:	0f b7 c0             	movzx  eax,ax
 789:	25 00 10 00 00       	and    eax,0x1000
 78e:	85 c0                	test   eax,eax
 790:	74 12                	je     7a4 <kbd_handle_sc+0x22c>
								kb_state &= ~KBD_STATE_RALT;
 792:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 799:	80 e4 fb             	and    ah,0xfb
 79c:	66 a3 00 00 00 00    	mov    ds:0x0,ax
 7a2:	eb 0f                	jmp    7b3 <kbd_handle_sc+0x23b>
								kb_state &= ~KBD_STATE_LALT;
 7a4:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 7ab:	24 7f                	and    al,0x7f
 7ad:	66 a3 00 00 00 00    	mov    ds:0x0,ax
						if (!(kb_state & (KBD_STATE_LALT | KBD_STATE_RALT)))
 7b3:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 7ba:	0f b7 c0             	movzx  eax,ax
 7bd:	25 80 04 00 00       	and    eax,0x480
 7c2:	85 c0                	test   eax,eax
 7c4:	75 10                	jne    7d6 <kbd_handle_sc+0x25e>
								kb_state &= ~KBD_STATE_ALT;
 7c6:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 7cd:	83 e0 ef             	and    eax,0xffffffef
 7d0:	66 a3 00 00 00 00    	mov    ds:0x0,ax
				rprintf(&kb_reg, "r%02x %016b\n", scancode, kb_state);
 7d6:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 7dd:	0f b7 d0             	movzx  edx,ax
 7e0:	0f b6 45 e4          	movzx  eax,BYTE PTR [ebp-0x1c]
 7e4:	52                   	push   edx
 7e5:	50                   	push   eax
 7e6:	68 84 00 00 00       	push   0x84
 7eb:	68 00 00 00 00       	push   0x0
 7f0:	e8 fc ff ff ff       	call   7f1 <kbd_handle_sc+0x279>
 7f5:	83 c4 10             	add    esp,0x10
				if (scancode != 0x60 && (kb_state & KBD_STATE_NEXT_RIGHT)) {
 7f8:	80 7d e4 60          	cmp    BYTE PTR [ebp-0x1c],0x60
 7fc:	0f 84 ba 02 00 00    	je     abc <kbd_handle_sc+0x544>
 802:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 809:	0f b7 c0             	movzx  eax,ax
 80c:	25 00 10 00 00       	and    eax,0x1000
 811:	85 c0                	test   eax,eax
 813:	0f 84 a3 02 00 00    	je     abc <kbd_handle_sc+0x544>
						kb_state &= ~KBD_STATE_NEXT_RIGHT;
 819:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 820:	80 e4 ef             	and    ah,0xef
 823:	66 a3 00 00 00 00    	mov    ds:0x0,ax
				if (kb_state & KBD_STATE_NEXT_RIGHT) {
						kb_state &= ~KBD_STATE_NEXT_RIGHT;
				}
				/*printf("key with scancode %x pressed\n", scancode);*/
		}
}
 829:	e9 8e 02 00 00       	jmp    abc <kbd_handle_sc+0x544>
				if (scancode == 0x2a) { /* LSHIFT */
 82e:	80 7d e4 2a          	cmp    BYTE PTR [ebp-0x1c],0x2a
 832:	75 3a                	jne    86e <kbd_handle_sc+0x2f6>
						kb_state |= KBD_STATE_LSHIFT;
 834:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 83b:	80 cc 01             	or     ah,0x1
 83e:	66 a3 00 00 00 00    	mov    ds:0x0,ax
						if (!(kb_state & KBD_STATE_SHIFT)) {
 844:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 84b:	0f b7 c0             	movzx  eax,ax
 84e:	83 e0 20             	and    eax,0x20
 851:	85 c0                	test   eax,eax
 853:	0f 85 1e 02 00 00    	jne    a77 <kbd_handle_sc+0x4ff>
								kb_state |= KBD_STATE_SHIFT;
 859:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 860:	83 c8 20             	or     eax,0x20
 863:	66 a3 00 00 00 00    	mov    ds:0x0,ax
 869:	e9 09 02 00 00       	jmp    a77 <kbd_handle_sc+0x4ff>
				} else if (scancode == 0x36) { /* RSHIFT */
 86e:	80 7d e4 36          	cmp    BYTE PTR [ebp-0x1c],0x36
 872:	75 3a                	jne    8ae <kbd_handle_sc+0x336>
						kb_state |= KBD_STATE_RSHIFT;
 874:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 87b:	80 cc 08             	or     ah,0x8
 87e:	66 a3 00 00 00 00    	mov    ds:0x0,ax
						if (!(kb_state & KBD_STATE_SHIFT)) {
 884:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 88b:	0f b7 c0             	movzx  eax,ax
 88e:	83 e0 20             	and    eax,0x20
 891:	85 c0                	test   eax,eax
 893:	0f 85 de 01 00 00    	jne    a77 <kbd_handle_sc+0x4ff>
								kb_state |= KBD_STATE_SHIFT;
 899:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 8a0:	83 c8 20             	or     eax,0x20
 8a3:	66 a3 00 00 00 00    	mov    ds:0x0,ax
 8a9:	e9 c9 01 00 00       	jmp    a77 <kbd_handle_sc+0x4ff>
				} else if (scancode == 0x3a) { /* CAPS_LOCK */
 8ae:	80 7d e4 3a          	cmp    BYTE PTR [ebp-0x1c],0x3a
 8b2:	75 40                	jne    8f4 <kbd_handle_sc+0x37c>
						if (!(kb_state & KBD_STATE_CAPS_LOCK)) {
 8b4:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 8bb:	0f b7 c0             	movzx  eax,ax
 8be:	83 e0 04             	and    eax,0x4
 8c1:	85 c0                	test   eax,eax
 8c3:	0f 85 ae 01 00 00    	jne    a77 <kbd_handle_sc+0x4ff>
							kb_state |= KBD_STATE_CAPS_LOCK;
 8c9:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 8d0:	83 c8 04             	or     eax,0x4
 8d3:	66 a3 00 00 00 00    	mov    ds:0x0,ax
							kb_state ^= KBD_LIGHT_CAPS_LOCK;
 8d9:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 8e0:	66 35 00 80          	xor    ax,0x8000
 8e4:	66 a3 00 00 00 00    	mov    ds:0x0,ax
							kbd_lights_update();
 8ea:	e8 fc ff ff ff       	call   8eb <kbd_handle_sc+0x373>
 8ef:	e9 83 01 00 00       	jmp    a77 <kbd_handle_sc+0x4ff>
				} else if (scancode == 0x1d) { /* L/R CONTROL */
 8f4:	80 7d e4 1d          	cmp    BYTE PTR [ebp-0x1c],0x1d
 8f8:	75 4a                	jne    944 <kbd_handle_sc+0x3cc>
						if (kb_state & KBD_STATE_NEXT_RIGHT) {
 8fa:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 901:	0f b7 c0             	movzx  eax,ax
 904:	25 00 10 00 00       	and    eax,0x1000
 909:	85 c0                	test   eax,eax
 90b:	74 12                	je     91f <kbd_handle_sc+0x3a7>
								kb_state |= KBD_STATE_RCONTROL;
 90d:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 914:	80 cc 02             	or     ah,0x2
 917:	66 a3 00 00 00 00    	mov    ds:0x0,ax
 91d:	eb 10                	jmp    92f <kbd_handle_sc+0x3b7>
								kb_state |= KBD_STATE_LCONTROL;
 91f:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 926:	83 c8 40             	or     eax,0x40
 929:	66 a3 00 00 00 00    	mov    ds:0x0,ax
						kb_state |= KBD_STATE_CONTROL;
 92f:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 936:	83 c8 08             	or     eax,0x8
 939:	66 a3 00 00 00 00    	mov    ds:0x0,ax
 93f:	e9 33 01 00 00       	jmp    a77 <kbd_handle_sc+0x4ff>
				} else if (scancode == 0x38) { /* L/R ALT */
 944:	80 7d e4 38          	cmp    BYTE PTR [ebp-0x1c],0x38
 948:	75 49                	jne    993 <kbd_handle_sc+0x41b>
						if (kb_state & KBD_STATE_NEXT_RIGHT) {
 94a:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 951:	0f b7 c0             	movzx  eax,ax
 954:	25 00 10 00 00       	and    eax,0x1000
 959:	85 c0                	test   eax,eax
 95b:	74 12                	je     96f <kbd_handle_sc+0x3f7>
								kb_state |= KBD_STATE_RALT;
 95d:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 964:	80 cc 04             	or     ah,0x4
 967:	66 a3 00 00 00 00    	mov    ds:0x0,ax
 96d:	eb 0f                	jmp    97e <kbd_handle_sc+0x406>
								kb_state |= KBD_STATE_LALT;
 96f:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 976:	0c 80                	or     al,0x80
 978:	66 a3 00 00 00 00    	mov    ds:0x0,ax
						kb_state |= KBD_STATE_ALT;
 97e:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 985:	83 c8 10             	or     eax,0x10
 988:	66 a3 00 00 00 00    	mov    ds:0x0,ax
 98e:	e9 e4 00 00 00       	jmp    a77 <kbd_handle_sc+0x4ff>
				} else if (scancode == 0x46) { /* SCROLL_LOCK */
 993:	80 7d e4 46          	cmp    BYTE PTR [ebp-0x1c],0x46
 997:	75 3f                	jne    9d8 <kbd_handle_sc+0x460>
						if (!(kb_state & KBD_STATE_SCROLL_LOCK)) {
 999:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 9a0:	0f b7 c0             	movzx  eax,ax
 9a3:	83 e0 01             	and    eax,0x1
 9a6:	85 c0                	test   eax,eax
 9a8:	0f 85 c9 00 00 00    	jne    a77 <kbd_handle_sc+0x4ff>
							kb_state |= KBD_STATE_SCROLL_LOCK;
 9ae:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 9b5:	83 c8 01             	or     eax,0x1
 9b8:	66 a3 00 00 00 00    	mov    ds:0x0,ax
							kb_state ^= KBD_LIGHT_SCROLL_LOCK;
 9be:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 9c5:	80 f4 20             	xor    ah,0x20
 9c8:	66 a3 00 00 00 00    	mov    ds:0x0,ax
							kbd_lights_update();
 9ce:	e8 fc ff ff ff       	call   9cf <kbd_handle_sc+0x457>
 9d3:	e9 9f 00 00 00       	jmp    a77 <kbd_handle_sc+0x4ff>
				} else if (scancode == 0x45) { /* NUM_LOCK and brk */
 9d8:	80 7d e4 45          	cmp    BYTE PTR [ebp-0x1c],0x45
 9dc:	75 5c                	jne    a3a <kbd_handle_sc+0x4c2>
						if (kb_state & KBD_STATE_CONTROL) {
 9de:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 9e5:	0f b7 c0             	movzx  eax,ax
 9e8:	83 e0 08             	and    eax,0x8
 9eb:	85 c0                	test   eax,eax
 9ed:	74 13                	je     a02 <kbd_handle_sc+0x48a>
								cur_brk = !cur_brk;
 9ef:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
 9f6:	84 c0                	test   al,al
 9f8:	0f 94 c0             	sete   al
 9fb:	a2 00 00 00 00       	mov    ds:0x0,al
 a00:	eb 75                	jmp    a77 <kbd_handle_sc+0x4ff>
						} else if (!(kb_state & KBD_STATE_NUM_LOCK)) {
 a02:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 a09:	0f b7 c0             	movzx  eax,ax
 a0c:	83 e0 02             	and    eax,0x2
 a0f:	85 c0                	test   eax,eax
 a11:	75 64                	jne    a77 <kbd_handle_sc+0x4ff>
							kb_state |= KBD_STATE_NUM_LOCK;
 a13:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 a1a:	83 c8 02             	or     eax,0x2
 a1d:	66 a3 00 00 00 00    	mov    ds:0x0,ax
							kb_state ^= KBD_LIGHT_NUM_LOCK;
 a23:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 a2a:	80 f4 40             	xor    ah,0x40
 a2d:	66 a3 00 00 00 00    	mov    ds:0x0,ax
							kbd_lights_update();
 a33:	e8 fc ff ff ff       	call   a34 <kbd_handle_sc+0x4bc>
 a38:	eb 3d                	jmp    a77 <kbd_handle_sc+0x4ff>
				} else if (scancode == 0x53) { /* delete */
 a3a:	80 7d e4 53          	cmp    BYTE PTR [ebp-0x1c],0x53
 a3e:	75 37                	jne    a77 <kbd_handle_sc+0x4ff>
						if ((kb_state & KBD_STATE_CONTROL) && (kb_state & KBD_STATE_ALT)) {
 a40:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 a47:	0f b7 c0             	movzx  eax,ax
 a4a:	83 e0 08             	and    eax,0x8
 a4d:	85 c0                	test   eax,eax
 a4f:	74 26                	je     a77 <kbd_handle_sc+0x4ff>
 a51:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 a58:	0f b7 c0             	movzx  eax,ax
 a5b:	83 e0 10             	and    eax,0x10
 a5e:	85 c0                	test   eax,eax
 a60:	74 15                	je     a77 <kbd_handle_sc+0x4ff>
								printf("rebooting\n");
 a62:	83 ec 0c             	sub    esp,0xc
 a65:	68 91 00 00 00       	push   0x91
 a6a:	e8 fc ff ff ff       	call   a6b <kbd_handle_sc+0x4f3>
 a6f:	83 c4 10             	add    esp,0x10
								pc_reset();
 a72:	e8 fc ff ff ff       	call   a73 <kbd_handle_sc+0x4fb>
				rprintf(&kb_reg, "p%02x %016b\n", scancode, kb_state);
 a77:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 a7e:	0f b7 d0             	movzx  edx,ax
 a81:	0f b6 45 e4          	movzx  eax,BYTE PTR [ebp-0x1c]
 a85:	52                   	push   edx
 a86:	50                   	push   eax
 a87:	68 9c 00 00 00       	push   0x9c
 a8c:	68 00 00 00 00       	push   0x0
 a91:	e8 fc ff ff ff       	call   a92 <kbd_handle_sc+0x51a>
 a96:	83 c4 10             	add    esp,0x10
				if (kb_state & KBD_STATE_NEXT_RIGHT) {
 a99:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 aa0:	0f b7 c0             	movzx  eax,ax
 aa3:	25 00 10 00 00       	and    eax,0x1000
 aa8:	85 c0                	test   eax,eax
 aaa:	74 10                	je     abc <kbd_handle_sc+0x544>
						kb_state &= ~KBD_STATE_NEXT_RIGHT;
 aac:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 ab3:	80 e4 ef             	and    ah,0xef
 ab6:	66 a3 00 00 00 00    	mov    ds:0x0,ax
}
 abc:	90                   	nop
 abd:	c9                   	leave
 abe:	c3                   	ret

00000abf <kbd_event_translate>:
};

/* TODO: keymaps(5)-like support 
 *       notify event consumers */
int kbd_event_translate(const struct key_event* ke)
{
 abf:	55                   	push   ebp
 ac0:	89 e5                	mov    ebp,esp
 ac2:	83 ec 10             	sub    esp,0x10
		/* miserable kludge <-> 128x256 keymaps in code */
		if (ke->prs) {
 ac5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 ac8:	0f b6 00             	movzx  eax,BYTE PTR [eax]
 acb:	84 c0                	test   al,al
 acd:	0f 84 5a 01 00 00    	je     c2d <kbd_event_translate+0x16e>
				uint16_t kbs = ke->state & (KBD_STATE_SHIFT | KBD_LIGHT_CAPS_LOCK);
 ad3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 ad6:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
 ada:	66 25 20 80          	and    ax,0x8020
 ade:	66 89 45 fc          	mov    WORD PTR [ebp-0x4],ax
				char rv;
				if (!(ke->state & KBD_STATE_NEXT_RIGHT) && (ke->state & KBD_LIGHT_NUM_LOCK)
 ae2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 ae5:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
 ae9:	0f b7 c0             	movzx  eax,ax
 aec:	25 00 10 00 00       	and    eax,0x1000
 af1:	85 c0                	test   eax,eax
 af3:	0f 85 c9 00 00 00    	jne    bc2 <kbd_event_translate+0x103>
 af9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 afc:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
 b00:	0f b7 c0             	movzx  eax,ax
 b03:	25 00 40 00 00       	and    eax,0x4000
 b08:	85 c0                	test   eax,eax
 b0a:	0f 84 b2 00 00 00    	je     bc2 <kbd_event_translate+0x103>
					&& ((ke->sc >= 0x47 && ke->sc <= 0x49)
 b10:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 b13:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
 b17:	3c 46                	cmp    al,0x46
 b19:	76 0b                	jbe    b26 <kbd_event_translate+0x67>
 b1b:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 b1e:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
 b22:	3c 49                	cmp    al,0x49
 b24:	76 2c                	jbe    b52 <kbd_event_translate+0x93>
					|| (ke->sc >= 0x4b && ke->sc <= 0x4d)
 b26:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 b29:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
 b2d:	3c 4a                	cmp    al,0x4a
 b2f:	76 0b                	jbe    b3c <kbd_event_translate+0x7d>
 b31:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 b34:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
 b38:	3c 4d                	cmp    al,0x4d
 b3a:	76 16                	jbe    b52 <kbd_event_translate+0x93>
					|| (ke->sc >= 0x4f && ke->sc <= 0x53))) {
 b3c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 b3f:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
 b43:	3c 4e                	cmp    al,0x4e
 b45:	76 7b                	jbe    bc2 <kbd_event_translate+0x103>
 b47:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 b4a:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
 b4e:	3c 53                	cmp    al,0x53
 b50:	77 70                	ja     bc2 <kbd_event_translate+0x103>
						/* produce numbers and . */
						if (ke->sc <= 0x49)
 b52:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 b55:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
 b59:	3c 49                	cmp    al,0x49
 b5b:	77 12                	ja     b6f <kbd_event_translate+0xb0>
								return '7' + (ke->sc - 0x47);
 b5d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 b60:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
 b64:	0f b6 c0             	movzx  eax,al
 b67:	83 e8 10             	sub    eax,0x10
 b6a:	e9 c3 00 00 00       	jmp    c32 <kbd_event_translate+0x173>
						else if (ke->sc <= 0x4d)
 b6f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 b72:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
 b76:	3c 4d                	cmp    al,0x4d
 b78:	77 12                	ja     b8c <kbd_event_translate+0xcd>
								return '4' + (ke->sc - 0x4b);
 b7a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 b7d:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
 b81:	0f b6 c0             	movzx  eax,al
 b84:	83 e8 17             	sub    eax,0x17
 b87:	e9 a6 00 00 00       	jmp    c32 <kbd_event_translate+0x173>
						else if (ke->sc <= 0x51)
 b8c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 b8f:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
 b93:	3c 51                	cmp    al,0x51
 b95:	77 12                	ja     ba9 <kbd_event_translate+0xea>
								return '1' + (ke->sc - 0x4f);
 b97:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 b9a:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
 b9e:	0f b6 c0             	movzx  eax,al
 ba1:	83 e8 1e             	sub    eax,0x1e
 ba4:	e9 89 00 00 00       	jmp    c32 <kbd_event_translate+0x173>
						else if (ke->sc == 0x52)
 ba9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 bac:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
 bb0:	3c 52                	cmp    al,0x52
 bb2:	75 07                	jne    bbb <kbd_event_translate+0xfc>
								return '0';
 bb4:	b8 30 00 00 00       	mov    eax,0x30
 bb9:	eb 77                	jmp    c32 <kbd_event_translate+0x173>
						else
								return '.';
 bbb:	b8 2e 00 00 00       	mov    eax,0x2e
 bc0:	eb 70                	jmp    c32 <kbd_event_translate+0x173>
				}
				/* get the characters */
				if (kbs != 0 && kbs != (KBD_STATE_SHIFT & KBD_LIGHT_CAPS_LOCK)) /* caps */
 bc2:	66 83 7d fc 00       	cmp    WORD PTR [ebp-0x4],0x0
 bc7:	74 23                	je     bec <kbd_event_translate+0x12d>
 bc9:	66 83 7d fc 00       	cmp    WORD PTR [ebp-0x4],0x0
 bce:	74 1c                	je     bec <kbd_event_translate+0x12d>
						rv = kb_scancodes[(ke->sc & 0x7f) + 128];
 bd0:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 bd3:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
 bd7:	0f b6 c0             	movzx  eax,al
 bda:	83 e0 7f             	and    eax,0x7f
 bdd:	83 e8 80             	sub    eax,0xffffff80
 be0:	0f b6 80 00 00 00 00 	movzx  eax,BYTE PTR [eax+0x0]
 be7:	88 45 ff             	mov    BYTE PTR [ebp-0x1],al
 bea:	eb 17                	jmp    c03 <kbd_event_translate+0x144>
				else /* small */
						rv = kb_scancodes[ke->sc & 0x7f];
 bec:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 bef:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
 bf3:	0f b6 c0             	movzx  eax,al
 bf6:	83 e0 7f             	and    eax,0x7f
 bf9:	0f b6 80 00 00 00 00 	movzx  eax,BYTE PTR [eax+0x0]
 c00:	88 45 ff             	mov    BYTE PTR [ebp-0x1],al
				/* treat ctrl+z as EOF */
				if (ke->state & KBD_STATE_CONTROL && (rv == 'z' || rv == 'd'))
 c03:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 c06:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
 c0a:	0f b7 c0             	movzx  eax,ax
 c0d:	83 e0 08             	and    eax,0x8
 c10:	85 c0                	test   eax,eax
 c12:	74 13                	je     c27 <kbd_event_translate+0x168>
 c14:	80 7d ff 7a          	cmp    BYTE PTR [ebp-0x1],0x7a
 c18:	74 06                	je     c20 <kbd_event_translate+0x161>
 c1a:	80 7d ff 64          	cmp    BYTE PTR [ebp-0x1],0x64
 c1e:	75 07                	jne    c27 <kbd_event_translate+0x168>
						return EOF;
 c20:	b8 ff ff ff ff       	mov    eax,0xffffffff
 c25:	eb 0b                	jmp    c32 <kbd_event_translate+0x173>
				/* TODO: ctrl+c etc. signal handlers */
				return rv;
 c27:	0f be 45 ff          	movsx  eax,BYTE PTR [ebp-0x1]
 c2b:	eb 05                	jmp    c32 <kbd_event_translate+0x173>
		}
		return 0;
 c2d:	b8 00 00 00 00       	mov    eax,0x0
}
 c32:	c9                   	leave
 c33:	c3                   	ret
