
kbd.o32:     file format elf32-i386


Disassembly of section .text:

00000000 <outb>:
						/*if (kb_state & KBD_STATE_NEXT_RIGHT) *//* fake lshift */
						/*		kb_state &= ~KBD_STATE_NEXT_RIGHT;*/
				} else if (scancode == 0x36) { /* RSHIFT */
						kb_state |= KBD_STATE_RSHIFT;
						if (!(kb_state & KBD_STATE_SHIFT)) {
								kb_state |= KBD_STATE_SHIFT;
   0:	55                   	push   ebp
   1:	89 e5                	mov    ebp,esp
   3:	83 ec 08             	sub    esp,0x8
   6:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
   9:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
   c:	66 89 55 fc          	mov    WORD PTR [ebp-0x4],dx
  10:	88 45 f8             	mov    BYTE PTR [ebp-0x8],al
						}
  13:	0f b6 45 f8          	movzx  eax,BYTE PTR [ebp-0x8]
  17:	0f b7 55 fc          	movzx  edx,WORD PTR [ebp-0x4]
  1b:	ee                   	out    dx,al
				} else if (scancode == 0x3a) { /* CAPS_LOCK */
  1c:	90                   	nop
  1d:	c9                   	leave
  1e:	c3                   	ret

0000001f <inb>:
						if (!(kb_state & KBD_STATE_CAPS_LOCK)) {
							kb_state |= KBD_STATE_CAPS_LOCK;
							kb_state ^= KBD_LIGHT_CAPS_LOCK;
  1f:	55                   	push   ebp
  20:	89 e5                	mov    ebp,esp
  22:	83 ec 14             	sub    esp,0x14
  25:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
  28:	66 89 45 ec          	mov    WORD PTR [ebp-0x14],ax
							kbd_lights_update();
						}
  2c:	0f b7 45 ec          	movzx  eax,WORD PTR [ebp-0x14]
  30:	89 c2                	mov    edx,eax
  32:	ec                   	in     al,dx
  33:	88 45 ff             	mov    BYTE PTR [ebp-0x1],al
						/*printf("p");*/
  36:	0f b6 45 ff          	movzx  eax,BYTE PTR [ebp-0x1]
				} else if (scancode == 0x1d) { /* L/R CONTROL */
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
  81:	83 ec 28             	sub    esp,0x28
		rb_events = ringbuffer_allocate(KBD_INIT_BUFSIZE);
  84:	c7 04 24 00 02 00 00 	mov    DWORD PTR [esp],0x200
  8b:	e8 fc ff ff ff       	call   8c <kbd_init+0xe>
  90:	a3 00 00 00 00       	mov    ds:0x0,eax
		rb_commands = ringbuffer_allocate(KBD_INIT_BUFSIZE);
  95:	c7 04 24 00 02 00 00 	mov    DWORD PTR [esp],0x200
  9c:	e8 fc ff ff ff       	call   9d <kbd_init+0x1f>
  a1:	a3 00 00 00 00       	mov    ds:0x0,eax
		region_clear(&kb_reg);
  a6:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
  ad:	e8 fc ff ff ff       	call   ae <kbd_init+0x30>
		rprintf(&kb_regH, "    LGTNRRRLLLSSSSSS"
  b2:	c7 44 24 04 00 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
  ba:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
  c1:	e8 fc ff ff ff       	call   c2 <kbd_init+0x44>
		cmd = KBC_RESET;
  c6:	c6 45 f7 01          	mov    BYTE PTR [ebp-0x9],0x1
		ringbuffer_enqueue(rb_commands, &cmd, sizeof(cmd));
  ca:	a1 00 00 00 00       	mov    eax,ds:0x0
  cf:	c7 44 24 08 01 00 00 00 	mov    DWORD PTR [esp+0x8],0x1
  d7:	8d 55 f7             	lea    edx,[ebp-0x9]
  da:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
  de:	89 04 24             	mov    DWORD PTR [esp],eax
  e1:	e8 fc ff ff ff       	call   e2 <kbd_init+0x64>
}
  e6:	90                   	nop
  e7:	c9                   	leave
  e8:	c3                   	ret

000000e9 <kbd_wait>:
{
  e9:	55                   	push   ebp
  ea:	89 e5                	mov    ebp,esp
  ec:	83 ec 04             	sub    esp,0x4
		while (!(inb(KBD_CH4) & 1));
  ef:	90                   	nop
  f0:	c7 04 24 64 00 00 00 	mov    DWORD PTR [esp],0x64
  f7:	e8 23 ff ff ff       	call   1f <inb>
  fc:	0f b6 c0             	movzx  eax,al
  ff:	83 e0 01             	and    eax,0x1
 102:	85 c0                	test   eax,eax
 104:	74 ea                	je     f0 <kbd_wait+0x7>
}
 106:	90                   	nop
 107:	90                   	nop
 108:	c9                   	leave
 109:	c3                   	ret

0000010a <kbd_process_queue>:
{
 10a:	55                   	push   ebp
 10b:	89 e5                	mov    ebp,esp
 10d:	83 ec 28             	sub    esp,0x28
		preempt_disable();
 110:	e8 fc ff ff ff       	call   111 <kbd_process_queue+0x7>
 115:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
 118:	83 c2 01             	add    edx,0x1
 11b:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
		while ((s = ringbuffer_available(rb_commands))) {
 11e:	e9 40 02 00 00       	jmp    363 <kbd_process_queue+0x259>
				uint8_t cmd, a1, a2, nr = 0;
 123:	c6 45 f5 00          	mov    BYTE PTR [ebp-0xb],0x0
				ringbuffer_dequeue(rb_commands, &cmd, sizeof(cmd));
 127:	a1 00 00 00 00       	mov    eax,ds:0x0
 12c:	c7 44 24 08 01 00 00 00 	mov    DWORD PTR [esp+0x8],0x1
 134:	8d 55 ef             	lea    edx,[ebp-0x11]
 137:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
 13b:	89 04 24             	mov    DWORD PTR [esp],eax
 13e:	e8 fc ff ff ff       	call   13f <kbd_process_queue+0x35>
				rprintf(&kb_reg, "handling command %x\n", cmd);
 143:	0f b6 45 ef          	movzx  eax,BYTE PTR [ebp-0x11]
 147:	0f b6 c0             	movzx  eax,al
 14a:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
 14e:	c7 44 24 04 51 00 00 00 	mov    DWORD PTR [esp+0x4],0x51
 156:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 15d:	e8 fc ff ff ff       	call   15e <kbd_process_queue+0x54>
				switch (cmd) {
 162:	0f b6 45 ef          	movzx  eax,BYTE PTR [ebp-0x11]
 166:	0f b6 c0             	movzx  eax,al
 169:	83 f8 04             	cmp    eax,0x4
 16c:	0f 84 1d 01 00 00    	je     28f <kbd_process_queue+0x185>
 172:	83 f8 04             	cmp    eax,0x4
 175:	0f 8f 93 01 00 00    	jg     30e <kbd_process_queue+0x204>
 17b:	83 f8 03             	cmp    eax,0x3
 17e:	74 6a                	je     1ea <kbd_process_queue+0xe0>
 180:	83 f8 03             	cmp    eax,0x3
 183:	0f 8f 85 01 00 00    	jg     30e <kbd_process_queue+0x204>
 189:	83 f8 01             	cmp    eax,0x1
 18c:	74 0e                	je     19c <kbd_process_queue+0x92>
 18e:	83 f8 02             	cmp    eax,0x2
 191:	0f 84 84 00 00 00    	je     21b <kbd_process_queue+0x111>
								break;
 197:	e9 72 01 00 00       	jmp    30e <kbd_process_queue+0x204>
								outb(KBD_CH0, 0xff);
 19c:	c7 44 24 04 ff 00 00 00 	mov    DWORD PTR [esp+0x4],0xff
 1a4:	c7 04 24 60 00 00 00 	mov    DWORD PTR [esp],0x60
 1ab:	e8 50 fe ff ff       	call   0 <outb>
								a1 = inb(KBD_CH0);
 1b0:	c7 04 24 60 00 00 00 	mov    DWORD PTR [esp],0x60
 1b7:	e8 63 fe ff ff       	call   1f <inb>
 1bc:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
								nr = 1;
 1bf:	c6 45 f5 01          	mov    BYTE PTR [ebp-0xb],0x1
								if (a1 == 0xfa) {
 1c3:	80 7d f7 fa          	cmp    BYTE PTR [ebp-0x9],0xfa
 1c7:	0f 85 44 01 00 00    	jne    311 <kbd_process_queue+0x207>
										kbd_wait();
 1cd:	e8 fc ff ff ff       	call   1ce <kbd_process_queue+0xc4>
										a2 = inb(KBD_CH0);
 1d2:	c7 04 24 60 00 00 00 	mov    DWORD PTR [esp],0x60
 1d9:	e8 41 fe ff ff       	call   1f <inb>
 1de:	88 45 f6             	mov    BYTE PTR [ebp-0xa],al
										nr = 2;
 1e1:	c6 45 f5 02          	mov    BYTE PTR [ebp-0xb],0x2
								break;
 1e5:	e9 27 01 00 00       	jmp    311 <kbd_process_queue+0x207>
								outb(KBD_CH0, 0xf4);
 1ea:	c7 44 24 04 f4 00 00 00 	mov    DWORD PTR [esp+0x4],0xf4
 1f2:	c7 04 24 60 00 00 00 	mov    DWORD PTR [esp],0x60
 1f9:	e8 02 fe ff ff       	call   0 <outb>
								kbd_wait();
 1fe:	e8 fc ff ff ff       	call   1ff <kbd_process_queue+0xf5>
								a1 = inb(KBD_CH0);
 203:	c7 04 24 60 00 00 00 	mov    DWORD PTR [esp],0x60
 20a:	e8 10 fe ff ff       	call   1f <inb>
 20f:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
								nr = 1;
 212:	c6 45 f5 01          	mov    BYTE PTR [ebp-0xb],0x1
								break;
 216:	e9 fa 00 00 00       	jmp    315 <kbd_process_queue+0x20b>
								outb(KBD_CH0, 0xf5);
 21b:	c7 44 24 04 f5 00 00 00 	mov    DWORD PTR [esp+0x4],0xf5
 223:	c7 04 24 60 00 00 00 	mov    DWORD PTR [esp],0x60
 22a:	e8 d1 fd ff ff       	call   0 <outb>
								kbd_wait();
 22f:	e8 fc ff ff ff       	call   230 <kbd_process_queue+0x126>
								a2 = inb(KBD_CH4);
 234:	c7 04 24 64 00 00 00 	mov    DWORD PTR [esp],0x64
 23b:	e8 df fd ff ff       	call   1f <inb>
 240:	88 45 f6             	mov    BYTE PTR [ebp-0xa],al
								while ((a1 = inb(KBD_CH0))) {
 243:	eb 29                	jmp    26e <kbd_process_queue+0x164>
										if (a1 == 0xfa || a1 == 0x00 || a1 == 0xfe)
 245:	80 7d f7 fa          	cmp    BYTE PTR [ebp-0x9],0xfa
 249:	74 3b                	je     286 <kbd_process_queue+0x17c>
 24b:	80 7d f7 00          	cmp    BYTE PTR [ebp-0x9],0x0
 24f:	74 35                	je     286 <kbd_process_queue+0x17c>
 251:	80 7d f7 fe          	cmp    BYTE PTR [ebp-0x9],0xfe
 255:	74 2f                	je     286 <kbd_process_queue+0x17c>
										if (a2 & (1 << 5)) /* read sth useful */
 257:	0f b6 45 f6          	movzx  eax,BYTE PTR [ebp-0xa]
 25b:	83 e0 20             	and    eax,0x20
 25e:	85 c0                	test   eax,eax
 260:	74 23                	je     285 <kbd_process_queue+0x17b>
												kbd_handle_sc(a1); /* watch out for ff and fe too */
 262:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
 266:	89 04 24             	mov    DWORD PTR [esp],eax
 269:	e8 fc ff ff ff       	call   26a <kbd_process_queue+0x160>
								while ((a1 = inb(KBD_CH0))) {
 26e:	c7 04 24 60 00 00 00 	mov    DWORD PTR [esp],0x60
 275:	e8 a5 fd ff ff       	call   1f <inb>
 27a:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
 27d:	80 7d f7 00          	cmp    BYTE PTR [ebp-0x9],0x0
 281:	75 c2                	jne    245 <kbd_process_queue+0x13b>
 283:	eb 01                	jmp    286 <kbd_process_queue+0x17c>
												break;
 285:	90                   	nop
								nr = 1;
 286:	c6 45 f5 01          	mov    BYTE PTR [ebp-0xb],0x1
								break;
 28a:	e9 86 00 00 00       	jmp    315 <kbd_process_queue+0x20b>
								outb(KBD_CH0, 0xed);
 28f:	c7 44 24 04 ed 00 00 00 	mov    DWORD PTR [esp+0x4],0xed
 297:	c7 04 24 60 00 00 00 	mov    DWORD PTR [esp],0x60
 29e:	e8 5d fd ff ff       	call   0 <outb>
								kbd_wait();
 2a3:	e8 fc ff ff ff       	call   2a4 <kbd_process_queue+0x19a>
								a1 = inb(KBD_CH0);
 2a8:	c7 04 24 60 00 00 00 	mov    DWORD PTR [esp],0x60
 2af:	e8 6b fd ff ff       	call   1f <inb>
 2b4:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
								nr = 1;
 2b7:	c6 45 f5 01          	mov    BYTE PTR [ebp-0xb],0x1
								ringbuffer_dequeue(rb_commands, &cmd, sizeof(cmd));
 2bb:	a1 00 00 00 00       	mov    eax,ds:0x0
 2c0:	c7 44 24 08 01 00 00 00 	mov    DWORD PTR [esp+0x8],0x1
 2c8:	8d 55 ef             	lea    edx,[ebp-0x11]
 2cb:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
 2cf:	89 04 24             	mov    DWORD PTR [esp],eax
 2d2:	e8 fc ff ff ff       	call   2d3 <kbd_process_queue+0x1c9>
								if (a1 == 0xfa) {
 2d7:	80 7d f7 fa          	cmp    BYTE PTR [ebp-0x9],0xfa
 2db:	75 37                	jne    314 <kbd_process_queue+0x20a>
										outb(KBD_CH0, cmd);
 2dd:	0f b6 45 ef          	movzx  eax,BYTE PTR [ebp-0x11]
 2e1:	0f b6 c0             	movzx  eax,al
 2e4:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 2e8:	c7 04 24 60 00 00 00 	mov    DWORD PTR [esp],0x60
 2ef:	e8 0c fd ff ff       	call   0 <outb>
										kbd_wait();
 2f4:	e8 fc ff ff ff       	call   2f5 <kbd_process_queue+0x1eb>
										a2 = inb(KBD_CH0);
 2f9:	c7 04 24 60 00 00 00 	mov    DWORD PTR [esp],0x60
 300:	e8 1a fd ff ff       	call   1f <inb>
 305:	88 45 f6             	mov    BYTE PTR [ebp-0xa],al
										nr = 2;
 308:	c6 45 f5 02          	mov    BYTE PTR [ebp-0xb],0x2
								break;
 30c:	eb 06                	jmp    314 <kbd_process_queue+0x20a>
								break;
 30e:	90                   	nop
 30f:	eb 04                	jmp    315 <kbd_process_queue+0x20b>
								break;
 311:	90                   	nop
 312:	eb 01                	jmp    315 <kbd_process_queue+0x20b>
								break;
 314:	90                   	nop
				if (nr == 1)
 315:	80 7d f5 01          	cmp    BYTE PTR [ebp-0xb],0x1
 319:	75 1e                	jne    339 <kbd_process_queue+0x22f>
						rprintf(&kb_reg, "response %x\n", a1);
 31b:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
 31f:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
 323:	c7 44 24 04 66 00 00 00 	mov    DWORD PTR [esp+0x4],0x66
 32b:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 332:	e8 fc ff ff ff       	call   333 <kbd_process_queue+0x229>
 337:	eb 2a                	jmp    363 <kbd_process_queue+0x259>
				else if (nr == 2)
 339:	80 7d f5 02          	cmp    BYTE PTR [ebp-0xb],0x2
 33d:	75 24                	jne    363 <kbd_process_queue+0x259>
						rprintf(&kb_reg, "responses %x %x\n", a1, a2);
 33f:	0f b6 55 f6          	movzx  edx,BYTE PTR [ebp-0xa]
 343:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
 347:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
 34b:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
 34f:	c7 44 24 04 73 00 00 00 	mov    DWORD PTR [esp+0x4],0x73
 357:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 35e:	e8 fc ff ff ff       	call   35f <kbd_process_queue+0x255>
		while ((s = ringbuffer_available(rb_commands))) {
 363:	a1 00 00 00 00       	mov    eax,ds:0x0
 368:	89 04 24             	mov    DWORD PTR [esp],eax
 36b:	e8 fc ff ff ff       	call   36c <kbd_process_queue+0x262>
 370:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
 373:	83 7d f0 00          	cmp    DWORD PTR [ebp-0x10],0x0
 377:	0f 85 a6 fd ff ff    	jne    123 <kbd_process_queue+0x19>
		preempt_enable();
 37d:	e8 fc ff ff ff       	call   37e <kbd_process_queue+0x274>
 382:	8b 50 18             	mov    edx,DWORD PTR [eax+0x18]
 385:	83 ea 01             	sub    edx,0x1
 388:	89 50 18             	mov    DWORD PTR [eax+0x18],edx
 38b:	e8 fc ff ff ff       	call   38c <kbd_process_queue+0x282>
 390:	8b 00                	mov    eax,DWORD PTR [eax]
 392:	83 e0 01             	and    eax,0x1
 395:	85 c0                	test   eax,eax
 397:	74 05                	je     39e <kbd_process_queue+0x294>
 399:	e8 fc ff ff ff       	call   39a <kbd_process_queue+0x290>
}
 39e:	90                   	nop
 39f:	c9                   	leave
 3a0:	c3                   	ret

000003a1 <kbd_event_present>:
{
 3a1:	55                   	push   ebp
 3a2:	89 e5                	mov    ebp,esp
 3a4:	83 ec 18             	sub    esp,0x18
		return ringbuffer_available(rb_events) / sizeof(struct key_event);
 3a7:	a1 00 00 00 00       	mov    eax,ds:0x0
 3ac:	89 04 24             	mov    DWORD PTR [esp],eax
 3af:	e8 fc ff ff ff       	call   3b0 <kbd_event_present+0xf>
 3b4:	c1 e8 02             	shr    eax,0x2
}
 3b7:	c9                   	leave
 3b8:	c3                   	ret

000003b9 <kbd_get_event>:
{
 3b9:	55                   	push   ebp
 3ba:	89 e5                	mov    ebp,esp
 3bc:	83 ec 28             	sub    esp,0x28
		ringbuffer_dequeue(rb_events, &rv, sizeof(rv));
 3bf:	a1 00 00 00 00       	mov    eax,ds:0x0
 3c4:	c7 44 24 08 04 00 00 00 	mov    DWORD PTR [esp+0x8],0x4
 3cc:	8d 55 f4             	lea    edx,[ebp-0xc]
 3cf:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
 3d3:	89 04 24             	mov    DWORD PTR [esp],eax
 3d6:	e8 fc ff ff ff       	call   3d7 <kbd_get_event+0x1e>
		return rv;
 3db:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 3de:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
 3e1:	89 10                	mov    DWORD PTR [eax],edx
}
 3e3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 3e6:	c9                   	leave
 3e7:	c2 04 00             	ret    0x4

000003ea <kbd_lights_update>:
{
 3ea:	55                   	push   ebp
 3eb:	89 e5                	mov    ebp,esp
 3ed:	83 ec 28             	sub    esp,0x28
		cmd = KBC_DISABLE;
 3f0:	c6 45 f7 02          	mov    BYTE PTR [ebp-0x9],0x2
		ringbuffer_enqueue(rb_commands, &cmd, sizeof(cmd));
 3f4:	a1 00 00 00 00       	mov    eax,ds:0x0
 3f9:	c7 44 24 08 01 00 00 00 	mov    DWORD PTR [esp+0x8],0x1
 401:	8d 55 f7             	lea    edx,[ebp-0x9]
 404:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
 408:	89 04 24             	mov    DWORD PTR [esp],eax
 40b:	e8 fc ff ff ff       	call   40c <kbd_lights_update+0x22>
		cmd = KBC_SET_LIGHTS;
 410:	c6 45 f7 04          	mov    BYTE PTR [ebp-0x9],0x4
		ringbuffer_enqueue(rb_commands, &cmd, sizeof(cmd));
 414:	a1 00 00 00 00       	mov    eax,ds:0x0
 419:	c7 44 24 08 01 00 00 00 	mov    DWORD PTR [esp+0x8],0x1
 421:	8d 55 f7             	lea    edx,[ebp-0x9]
 424:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
 428:	89 04 24             	mov    DWORD PTR [esp],eax
 42b:	e8 fc ff ff ff       	call   42c <kbd_lights_update+0x42>
		cmd = (kb_state & KBD_LIGHT_MASK) >> 13;
 430:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 437:	66 c1 e8 0d          	shr    ax,0xd
 43b:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
		ringbuffer_enqueue(rb_commands, &cmd, sizeof(cmd));
 43e:	a1 00 00 00 00       	mov    eax,ds:0x0
 443:	c7 44 24 08 01 00 00 00 	mov    DWORD PTR [esp+0x8],0x1
 44b:	8d 55 f7             	lea    edx,[ebp-0x9]
 44e:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
 452:	89 04 24             	mov    DWORD PTR [esp],eax
 455:	e8 fc ff ff ff       	call   456 <kbd_lights_update+0x6c>
		cmd = KBC_ENABLE;
 45a:	c6 45 f7 03          	mov    BYTE PTR [ebp-0x9],0x3
		ringbuffer_enqueue(rb_commands, &cmd, sizeof(cmd));
 45e:	a1 00 00 00 00       	mov    eax,ds:0x0
 463:	c7 44 24 08 01 00 00 00 	mov    DWORD PTR [esp+0x8],0x1
 46b:	8d 55 f7             	lea    edx,[ebp-0x9]
 46e:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
 472:	89 04 24             	mov    DWORD PTR [esp],eax
 475:	e8 fc ff ff ff       	call   476 <kbd_lights_update+0x8c>
		kb_regN.cur_x = kb_regN.cur_y = 0;
 47a:	66 c7 05 10 00 00 00 00 00 	mov    WORD PTR ds:0x10,0x0
 483:	0f b7 05 10 00 00 00 	movzx  eax,WORD PTR ds:0x10
 48a:	66 a3 0e 00 00 00    	mov    ds:0xe,ax
		region_putchar(&kb_regN, (kb_state & KBD_LIGHT_NUM_LOCK) ? '#' : ' ');
 490:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 497:	0f b7 c0             	movzx  eax,ax
 49a:	25 00 40 00 00       	and    eax,0x4000
 49f:	85 c0                	test   eax,eax
 4a1:	74 07                	je     4aa <kbd_lights_update+0xc0>
 4a3:	b8 23 00 00 00       	mov    eax,0x23
 4a8:	eb 05                	jmp    4af <kbd_lights_update+0xc5>
 4aa:	b8 20 00 00 00       	mov    eax,0x20
 4af:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 4b3:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 4ba:	e8 fc ff ff ff       	call   4bb <kbd_lights_update+0xd1>
		region_putchar(&kb_regN, (kb_state & KBD_LIGHT_CAPS_LOCK) ? '#' : ' ');
 4bf:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 4c6:	66 85 c0             	test   ax,ax
 4c9:	79 07                	jns    4d2 <kbd_lights_update+0xe8>
 4cb:	b8 23 00 00 00       	mov    eax,0x23
 4d0:	eb 05                	jmp    4d7 <kbd_lights_update+0xed>
 4d2:	b8 20 00 00 00       	mov    eax,0x20
 4d7:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 4db:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 4e2:	e8 fc ff ff ff       	call   4e3 <kbd_lights_update+0xf9>
		region_putchar(&kb_regN, (kb_state & KBD_LIGHT_SCROLL_LOCK) ? '#' : ' ');
 4e7:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 4ee:	0f b7 c0             	movzx  eax,ax
 4f1:	25 00 20 00 00       	and    eax,0x2000
 4f6:	85 c0                	test   eax,eax
 4f8:	74 07                	je     501 <kbd_lights_update+0x117>
 4fa:	b8 23 00 00 00       	mov    eax,0x23
 4ff:	eb 05                	jmp    506 <kbd_lights_update+0x11c>
 501:	b8 20 00 00 00       	mov    eax,0x20
 506:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 50a:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 511:	e8 fc ff ff ff       	call   512 <kbd_lights_update+0x128>
}
 516:	90                   	nop
 517:	c9                   	leave
 518:	c3                   	ret

00000519 <kbd_handler>:
{
 519:	55                   	push   ebp
 51a:	89 e5                	mov    ebp,esp
 51c:	83 ec 28             	sub    esp,0x28
		if (!rb_events || !rb_commands) /* don't corrupt memory */
 51f:	a1 00 00 00 00       	mov    eax,ds:0x0
 524:	85 c0                	test   eax,eax
 526:	74 69                	je     591 <kbd_handler+0x78>
 528:	a1 00 00 00 00       	mov    eax,ds:0x0
 52d:	85 c0                	test   eax,eax
 52f:	74 60                	je     591 <kbd_handler+0x78>
				sc = inb(KBD_CH0);
 531:	c7 04 24 60 00 00 00 	mov    DWORD PTR [esp],0x60
 538:	e8 e2 fa ff ff       	call   1f <inb>
 53d:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
				if (sc != 0xfa && sc != 0xfe && sc != 0x00 && sc != 0xff)
 540:	80 7d f7 fa          	cmp    BYTE PTR [ebp-0x9],0xfa
 544:	74 1e                	je     564 <kbd_handler+0x4b>
 546:	80 7d f7 fe          	cmp    BYTE PTR [ebp-0x9],0xfe
 54a:	74 18                	je     564 <kbd_handler+0x4b>
 54c:	80 7d f7 00          	cmp    BYTE PTR [ebp-0x9],0x0
 550:	74 12                	je     564 <kbd_handler+0x4b>
 552:	80 7d f7 ff          	cmp    BYTE PTR [ebp-0x9],0xff
 556:	74 0c                	je     564 <kbd_handler+0x4b>
						kbd_handle_sc(sc);
 558:	0f b6 45 f7          	movzx  eax,BYTE PTR [ebp-0x9]
 55c:	89 04 24             	mov    DWORD PTR [esp],eax
 55f:	e8 fc ff ff ff       	call   560 <kbd_handler+0x47>
		} while ((inb(KBD_CH4) & 1));
 564:	c7 04 24 64 00 00 00 	mov    DWORD PTR [esp],0x64
 56b:	e8 af fa ff ff       	call   1f <inb>
 570:	0f b6 c0             	movzx  eax,al
 573:	83 e0 01             	and    eax,0x1
 576:	85 c0                	test   eax,eax
 578:	75 b7                	jne    531 <kbd_handler+0x18>
		if (kbd_event_present())
 57a:	e8 fc ff ff ff       	call   57b <kbd_handler+0x62>
 57f:	85 c0                	test   eax,eax
 581:	74 0f                	je     592 <kbd_handler+0x79>
				wake_up_external_event(&wq_kbd);
 583:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 58a:	e8 fc ff ff ff       	call   58b <kbd_handler+0x72>
 58f:	eb 01                	jmp    592 <kbd_handler+0x79>
				return;
 591:	90                   	nop
}
 592:	c9                   	leave
 593:	c3                   	ret

00000594 <kbd_handle_sc>:
{
 594:	55                   	push   ebp
 595:	89 e5                	mov    ebp,esp
 597:	83 ec 38             	sub    esp,0x38
 59a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 59d:	88 45 e4             	mov    BYTE PTR [ebp-0x1c],al
		ke.prs = !(scancode & 0x80);
 5a0:	0f b6 45 e4          	movzx  eax,BYTE PTR [ebp-0x1c]
 5a4:	f7 d0                	not    eax
 5a6:	c0 e8 07             	shr    al,0x7
 5a9:	88 45 f2             	mov    BYTE PTR [ebp-0xe],al
		ke.state = kb_state;
 5ac:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 5b3:	66 89 45 f4          	mov    WORD PTR [ebp-0xc],ax
		ke.sc = scancode & 0x7f;
 5b7:	0f b6 45 e4          	movzx  eax,BYTE PTR [ebp-0x1c]
 5bb:	83 e0 7f             	and    eax,0x7f
 5be:	88 45 f3             	mov    BYTE PTR [ebp-0xd],al
		ringbuffer_enqueue(rb_events, &ke, sizeof(ke));
 5c1:	a1 00 00 00 00       	mov    eax,ds:0x0
 5c6:	c7 44 24 08 04 00 00 00 	mov    DWORD PTR [esp+0x8],0x4
 5ce:	8d 55 f2             	lea    edx,[ebp-0xe]
 5d1:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
 5d5:	89 04 24             	mov    DWORD PTR [esp],eax
 5d8:	e8 fc ff ff ff       	call   5d9 <kbd_handle_sc+0x45>
		if (scancode & 0x80) {
 5dd:	0f b6 45 e4          	movzx  eax,BYTE PTR [ebp-0x1c]
 5e1:	84 c0                	test   al,al
 5e3:	0f 89 6e 02 00 00    	jns    857 <kbd_handle_sc+0x2c3>
				scs = scancode;
 5e9:	0f b6 45 e4          	movzx  eax,BYTE PTR [ebp-0x1c]
 5ed:	88 45 f7             	mov    BYTE PTR [ebp-0x9],al
				scancode ^= 0x80;
 5f0:	80 75 e4 80          	xor    BYTE PTR [ebp-0x1c],0x80
				if (scancode == 0x3a) { /* CAPS_LOCK */
 5f4:	80 7d e4 3a          	cmp    BYTE PTR [ebp-0x1c],0x3a
 5f8:	75 2a                	jne    624 <kbd_handle_sc+0x90>
						if (kb_state & KBD_STATE_CAPS_LOCK) {
 5fa:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 601:	0f b7 c0             	movzx  eax,ax
 604:	83 e0 04             	and    eax,0x4
 607:	85 c0                	test   eax,eax
 609:	0f 84 e8 01 00 00    	je     7f7 <kbd_handle_sc+0x263>
								kb_state &= ~KBD_STATE_CAPS_LOCK;
 60f:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 616:	83 e0 fb             	and    eax,0xfffffffb
 619:	66 a3 00 00 00 00    	mov    ds:0x0,ax
 61f:	e9 d3 01 00 00       	jmp    7f7 <kbd_handle_sc+0x263>
				} else if (scancode == 0x46) { /* SCROLL LOCK */
 624:	80 7d e4 46          	cmp    BYTE PTR [ebp-0x1c],0x46
 628:	75 2a                	jne    654 <kbd_handle_sc+0xc0>
						if (kb_state & KBD_STATE_SCROLL_LOCK) {
 62a:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 631:	0f b7 c0             	movzx  eax,ax
 634:	83 e0 01             	and    eax,0x1
 637:	85 c0                	test   eax,eax
 639:	0f 84 b8 01 00 00    	je     7f7 <kbd_handle_sc+0x263>
								kb_state &= ~KBD_STATE_SCROLL_LOCK;
 63f:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 646:	83 e0 fe             	and    eax,0xfffffffe
 649:	66 a3 00 00 00 00    	mov    ds:0x0,ax
 64f:	e9 a3 01 00 00       	jmp    7f7 <kbd_handle_sc+0x263>
				} else if (scancode == 0x45) { /* NUM LOCK */
 654:	80 7d e4 45          	cmp    BYTE PTR [ebp-0x1c],0x45
 658:	75 2a                	jne    684 <kbd_handle_sc+0xf0>
						if (kb_state & KBD_STATE_NUM_LOCK) {
 65a:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 661:	0f b7 c0             	movzx  eax,ax
 664:	83 e0 02             	and    eax,0x2
 667:	85 c0                	test   eax,eax
 669:	0f 84 88 01 00 00    	je     7f7 <kbd_handle_sc+0x263>
								kb_state &= ~KBD_STATE_NUM_LOCK;
 66f:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 676:	83 e0 fd             	and    eax,0xfffffffd
 679:	66 a3 00 00 00 00    	mov    ds:0x0,ax
 67f:	e9 73 01 00 00       	jmp    7f7 <kbd_handle_sc+0x263>
				} else if (scancode == 0x60) { /* RIGHT signalling */
 684:	80 7d e4 60          	cmp    BYTE PTR [ebp-0x1c],0x60
 688:	75 2c                	jne    6b6 <kbd_handle_sc+0x122>
						if (!(kb_state & KBD_STATE_NEXT_RIGHT)) {
 68a:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 691:	0f b7 c0             	movzx  eax,ax
 694:	25 00 10 00 00       	and    eax,0x1000
 699:	85 c0                	test   eax,eax
 69b:	0f 85 56 01 00 00    	jne    7f7 <kbd_handle_sc+0x263>
								kb_state |= KBD_STATE_NEXT_RIGHT;
 6a1:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 6a8:	80 cc 10             	or     ah,0x10
 6ab:	66 a3 00 00 00 00    	mov    ds:0x0,ax
 6b1:	e9 41 01 00 00       	jmp    7f7 <kbd_handle_sc+0x263>
				} else if (scancode == 0x2a) { /* LSHIFT */
 6b6:	80 7d e4 2a          	cmp    BYTE PTR [ebp-0x1c],0x2a
 6ba:	75 3c                	jne    6f8 <kbd_handle_sc+0x164>
						kb_state &= ~KBD_STATE_LSHIFT;
 6bc:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 6c3:	80 e4 fe             	and    ah,0xfe
 6c6:	66 a3 00 00 00 00    	mov    ds:0x0,ax
						if (!(kb_state & KBD_STATE_RSHIFT))
 6cc:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 6d3:	0f b7 c0             	movzx  eax,ax
 6d6:	25 00 08 00 00       	and    eax,0x800
 6db:	85 c0                	test   eax,eax
 6dd:	0f 85 14 01 00 00    	jne    7f7 <kbd_handle_sc+0x263>
								kb_state &= ~KBD_STATE_SHIFT;
 6e3:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 6ea:	83 e0 df             	and    eax,0xffffffdf
 6ed:	66 a3 00 00 00 00    	mov    ds:0x0,ax
 6f3:	e9 ff 00 00 00       	jmp    7f7 <kbd_handle_sc+0x263>
				} else if (scancode == 0x36) { /* RSHIFT */
 6f8:	80 7d e4 36          	cmp    BYTE PTR [ebp-0x1c],0x36
 6fc:	75 3c                	jne    73a <kbd_handle_sc+0x1a6>
						kb_state &= ~KBD_STATE_RSHIFT;
 6fe:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 705:	80 e4 f7             	and    ah,0xf7
 708:	66 a3 00 00 00 00    	mov    ds:0x0,ax
						if (!(kb_state & KBD_STATE_LSHIFT))
 70e:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 715:	0f b7 c0             	movzx  eax,ax
 718:	25 00 01 00 00       	and    eax,0x100
 71d:	85 c0                	test   eax,eax
 71f:	0f 85 d2 00 00 00    	jne    7f7 <kbd_handle_sc+0x263>
								kb_state &= ~KBD_STATE_SHIFT;
 725:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 72c:	83 e0 df             	and    eax,0xffffffdf
 72f:	66 a3 00 00 00 00    	mov    ds:0x0,ax
 735:	e9 bd 00 00 00       	jmp    7f7 <kbd_handle_sc+0x263>
				} else if (scancode == 0x1d) { /* L/R CONTROL */
 73a:	80 7d e4 1d          	cmp    BYTE PTR [ebp-0x1c],0x1d
 73e:	75 5a                	jne    79a <kbd_handle_sc+0x206>
						if (kb_state & KBD_STATE_NEXT_RIGHT) {
 740:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 747:	0f b7 c0             	movzx  eax,ax
 74a:	25 00 10 00 00       	and    eax,0x1000
 74f:	85 c0                	test   eax,eax
 751:	74 12                	je     765 <kbd_handle_sc+0x1d1>
								kb_state &= ~KBD_STATE_RCONTROL;
 753:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 75a:	80 e4 fd             	and    ah,0xfd
 75d:	66 a3 00 00 00 00    	mov    ds:0x0,ax
 763:	eb 10                	jmp    775 <kbd_handle_sc+0x1e1>
								kb_state &= ~KBD_STATE_LCONTROL;
 765:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 76c:	83 e0 bf             	and    eax,0xffffffbf
 76f:	66 a3 00 00 00 00    	mov    ds:0x0,ax
						if (!(kb_state & (KBD_STATE_LCONTROL | KBD_STATE_RCONTROL)))
 775:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 77c:	0f b7 c0             	movzx  eax,ax
 77f:	25 40 02 00 00       	and    eax,0x240
 784:	85 c0                	test   eax,eax
 786:	75 6f                	jne    7f7 <kbd_handle_sc+0x263>
								kb_state &= ~KBD_STATE_CONTROL;
 788:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 78f:	83 e0 f7             	and    eax,0xfffffff7
 792:	66 a3 00 00 00 00    	mov    ds:0x0,ax
 798:	eb 5d                	jmp    7f7 <kbd_handle_sc+0x263>
				} else if (scancode == 0x38) { /* L/R ALT */
 79a:	80 7d e4 38          	cmp    BYTE PTR [ebp-0x1c],0x38
 79e:	75 57                	jne    7f7 <kbd_handle_sc+0x263>
						if (kb_state & KBD_STATE_NEXT_RIGHT) {
 7a0:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 7a7:	0f b7 c0             	movzx  eax,ax
 7aa:	25 00 10 00 00       	and    eax,0x1000
 7af:	85 c0                	test   eax,eax
 7b1:	74 12                	je     7c5 <kbd_handle_sc+0x231>
								kb_state &= ~KBD_STATE_RALT;
 7b3:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 7ba:	80 e4 fb             	and    ah,0xfb
 7bd:	66 a3 00 00 00 00    	mov    ds:0x0,ax
 7c3:	eb 0f                	jmp    7d4 <kbd_handle_sc+0x240>
								kb_state &= ~KBD_STATE_LALT;
 7c5:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 7cc:	24 7f                	and    al,0x7f
 7ce:	66 a3 00 00 00 00    	mov    ds:0x0,ax
						if (!(kb_state & (KBD_STATE_LALT | KBD_STATE_RALT)))
 7d4:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 7db:	0f b7 c0             	movzx  eax,ax
 7de:	25 80 04 00 00       	and    eax,0x480
 7e3:	85 c0                	test   eax,eax
 7e5:	75 10                	jne    7f7 <kbd_handle_sc+0x263>
								kb_state &= ~KBD_STATE_ALT;
 7e7:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 7ee:	83 e0 ef             	and    eax,0xffffffef
 7f1:	66 a3 00 00 00 00    	mov    ds:0x0,ax
				rprintf(&kb_reg, "r%02x %016b\n", scancode, kb_state);
 7f7:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 7fe:	0f b7 d0             	movzx  edx,ax
 801:	0f b6 45 e4          	movzx  eax,BYTE PTR [ebp-0x1c]
 805:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
 809:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
 80d:	c7 44 24 04 84 00 00 00 	mov    DWORD PTR [esp+0x4],0x84
 815:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 81c:	e8 fc ff ff ff       	call   81d <kbd_handle_sc+0x289>
				if (scancode != 0x60 && (kb_state & KBD_STATE_NEXT_RIGHT)) {
 821:	80 7d e4 60          	cmp    BYTE PTR [ebp-0x1c],0x60
 825:	0f 84 be 02 00 00    	je     ae9 <kbd_handle_sc+0x555>
 82b:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 832:	0f b7 c0             	movzx  eax,ax
 835:	25 00 10 00 00       	and    eax,0x1000
 83a:	85 c0                	test   eax,eax
 83c:	0f 84 a7 02 00 00    	je     ae9 <kbd_handle_sc+0x555>
						kb_state &= ~KBD_STATE_NEXT_RIGHT;
 842:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 849:	80 e4 ef             	and    ah,0xef
 84c:	66 a3 00 00 00 00    	mov    ds:0x0,ax
				if (kb_state & KBD_STATE_NEXT_RIGHT) {
						kb_state &= ~KBD_STATE_NEXT_RIGHT;
				}
				/*printf("key with scancode %x pressed\n", scancode);*/
		}
}
 852:	e9 92 02 00 00       	jmp    ae9 <kbd_handle_sc+0x555>
				if (scancode == 0x2a) { /* LSHIFT */
 857:	80 7d e4 2a          	cmp    BYTE PTR [ebp-0x1c],0x2a
 85b:	75 3a                	jne    897 <kbd_handle_sc+0x303>
						kb_state |= KBD_STATE_LSHIFT;
 85d:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 864:	80 cc 01             	or     ah,0x1
 867:	66 a3 00 00 00 00    	mov    ds:0x0,ax
						if (!(kb_state & KBD_STATE_SHIFT)) {
 86d:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 874:	0f b7 c0             	movzx  eax,ax
 877:	83 e0 20             	and    eax,0x20
 87a:	85 c0                	test   eax,eax
 87c:	0f 85 1a 02 00 00    	jne    a9c <kbd_handle_sc+0x508>
								kb_state |= KBD_STATE_SHIFT;
 882:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 889:	83 c8 20             	or     eax,0x20
 88c:	66 a3 00 00 00 00    	mov    ds:0x0,ax
 892:	e9 05 02 00 00       	jmp    a9c <kbd_handle_sc+0x508>
				} else if (scancode == 0x36) { /* RSHIFT */
 897:	80 7d e4 36          	cmp    BYTE PTR [ebp-0x1c],0x36
 89b:	75 3a                	jne    8d7 <kbd_handle_sc+0x343>
						kb_state |= KBD_STATE_RSHIFT;
 89d:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 8a4:	80 cc 08             	or     ah,0x8
 8a7:	66 a3 00 00 00 00    	mov    ds:0x0,ax
						if (!(kb_state & KBD_STATE_SHIFT)) {
 8ad:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 8b4:	0f b7 c0             	movzx  eax,ax
 8b7:	83 e0 20             	and    eax,0x20
 8ba:	85 c0                	test   eax,eax
 8bc:	0f 85 da 01 00 00    	jne    a9c <kbd_handle_sc+0x508>
								kb_state |= KBD_STATE_SHIFT;
 8c2:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 8c9:	83 c8 20             	or     eax,0x20
 8cc:	66 a3 00 00 00 00    	mov    ds:0x0,ax
 8d2:	e9 c5 01 00 00       	jmp    a9c <kbd_handle_sc+0x508>
				} else if (scancode == 0x3a) { /* CAPS_LOCK */
 8d7:	80 7d e4 3a          	cmp    BYTE PTR [ebp-0x1c],0x3a
 8db:	75 40                	jne    91d <kbd_handle_sc+0x389>
						if (!(kb_state & KBD_STATE_CAPS_LOCK)) {
 8dd:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 8e4:	0f b7 c0             	movzx  eax,ax
 8e7:	83 e0 04             	and    eax,0x4
 8ea:	85 c0                	test   eax,eax
 8ec:	0f 85 aa 01 00 00    	jne    a9c <kbd_handle_sc+0x508>
							kb_state |= KBD_STATE_CAPS_LOCK;
 8f2:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 8f9:	83 c8 04             	or     eax,0x4
 8fc:	66 a3 00 00 00 00    	mov    ds:0x0,ax
							kb_state ^= KBD_LIGHT_CAPS_LOCK;
 902:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 909:	66 35 00 80          	xor    ax,0x8000
 90d:	66 a3 00 00 00 00    	mov    ds:0x0,ax
							kbd_lights_update();
 913:	e8 fc ff ff ff       	call   914 <kbd_handle_sc+0x380>
 918:	e9 7f 01 00 00       	jmp    a9c <kbd_handle_sc+0x508>
				} else if (scancode == 0x1d) { /* L/R CONTROL */
 91d:	80 7d e4 1d          	cmp    BYTE PTR [ebp-0x1c],0x1d
 921:	75 4a                	jne    96d <kbd_handle_sc+0x3d9>
						if (kb_state & KBD_STATE_NEXT_RIGHT) {
 923:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 92a:	0f b7 c0             	movzx  eax,ax
 92d:	25 00 10 00 00       	and    eax,0x1000
 932:	85 c0                	test   eax,eax
 934:	74 12                	je     948 <kbd_handle_sc+0x3b4>
								kb_state |= KBD_STATE_RCONTROL;
 936:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 93d:	80 cc 02             	or     ah,0x2
 940:	66 a3 00 00 00 00    	mov    ds:0x0,ax
 946:	eb 10                	jmp    958 <kbd_handle_sc+0x3c4>
								kb_state |= KBD_STATE_LCONTROL;
 948:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 94f:	83 c8 40             	or     eax,0x40
 952:	66 a3 00 00 00 00    	mov    ds:0x0,ax
						kb_state |= KBD_STATE_CONTROL;
 958:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 95f:	83 c8 08             	or     eax,0x8
 962:	66 a3 00 00 00 00    	mov    ds:0x0,ax
 968:	e9 2f 01 00 00       	jmp    a9c <kbd_handle_sc+0x508>
				} else if (scancode == 0x38) { /* L/R ALT */
 96d:	80 7d e4 38          	cmp    BYTE PTR [ebp-0x1c],0x38
 971:	75 49                	jne    9bc <kbd_handle_sc+0x428>
						if (kb_state & KBD_STATE_NEXT_RIGHT) {
 973:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 97a:	0f b7 c0             	movzx  eax,ax
 97d:	25 00 10 00 00       	and    eax,0x1000
 982:	85 c0                	test   eax,eax
 984:	74 12                	je     998 <kbd_handle_sc+0x404>
								kb_state |= KBD_STATE_RALT;
 986:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 98d:	80 cc 04             	or     ah,0x4
 990:	66 a3 00 00 00 00    	mov    ds:0x0,ax
 996:	eb 0f                	jmp    9a7 <kbd_handle_sc+0x413>
								kb_state |= KBD_STATE_LALT;
 998:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 99f:	0c 80                	or     al,0x80
 9a1:	66 a3 00 00 00 00    	mov    ds:0x0,ax
						kb_state |= KBD_STATE_ALT;
 9a7:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 9ae:	83 c8 10             	or     eax,0x10
 9b1:	66 a3 00 00 00 00    	mov    ds:0x0,ax
 9b7:	e9 e0 00 00 00       	jmp    a9c <kbd_handle_sc+0x508>
				} else if (scancode == 0x46) { /* SCROLL_LOCK */
 9bc:	80 7d e4 46          	cmp    BYTE PTR [ebp-0x1c],0x46
 9c0:	75 3f                	jne    a01 <kbd_handle_sc+0x46d>
						if (!(kb_state & KBD_STATE_SCROLL_LOCK)) {
 9c2:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 9c9:	0f b7 c0             	movzx  eax,ax
 9cc:	83 e0 01             	and    eax,0x1
 9cf:	85 c0                	test   eax,eax
 9d1:	0f 85 c5 00 00 00    	jne    a9c <kbd_handle_sc+0x508>
							kb_state |= KBD_STATE_SCROLL_LOCK;
 9d7:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 9de:	83 c8 01             	or     eax,0x1
 9e1:	66 a3 00 00 00 00    	mov    ds:0x0,ax
							kb_state ^= KBD_LIGHT_SCROLL_LOCK;
 9e7:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 9ee:	80 f4 20             	xor    ah,0x20
 9f1:	66 a3 00 00 00 00    	mov    ds:0x0,ax
							kbd_lights_update();
 9f7:	e8 fc ff ff ff       	call   9f8 <kbd_handle_sc+0x464>
 9fc:	e9 9b 00 00 00       	jmp    a9c <kbd_handle_sc+0x508>
				} else if (scancode == 0x45) { /* NUM_LOCK and brk */
 a01:	80 7d e4 45          	cmp    BYTE PTR [ebp-0x1c],0x45
 a05:	75 5c                	jne    a63 <kbd_handle_sc+0x4cf>
						if (kb_state & KBD_STATE_CONTROL) {
 a07:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 a0e:	0f b7 c0             	movzx  eax,ax
 a11:	83 e0 08             	and    eax,0x8
 a14:	85 c0                	test   eax,eax
 a16:	74 13                	je     a2b <kbd_handle_sc+0x497>
								cur_brk = !cur_brk;
 a18:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR ds:0x0
 a1f:	84 c0                	test   al,al
 a21:	0f 94 c0             	sete   al
 a24:	a2 00 00 00 00       	mov    ds:0x0,al
 a29:	eb 71                	jmp    a9c <kbd_handle_sc+0x508>
						} else if (!(kb_state & KBD_STATE_NUM_LOCK)) {
 a2b:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 a32:	0f b7 c0             	movzx  eax,ax
 a35:	83 e0 02             	and    eax,0x2
 a38:	85 c0                	test   eax,eax
 a3a:	75 60                	jne    a9c <kbd_handle_sc+0x508>
							kb_state |= KBD_STATE_NUM_LOCK;
 a3c:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 a43:	83 c8 02             	or     eax,0x2
 a46:	66 a3 00 00 00 00    	mov    ds:0x0,ax
							kb_state ^= KBD_LIGHT_NUM_LOCK;
 a4c:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 a53:	80 f4 40             	xor    ah,0x40
 a56:	66 a3 00 00 00 00    	mov    ds:0x0,ax
							kbd_lights_update();
 a5c:	e8 fc ff ff ff       	call   a5d <kbd_handle_sc+0x4c9>
 a61:	eb 39                	jmp    a9c <kbd_handle_sc+0x508>
				} else if (scancode == 0x53) { /* delete */
 a63:	80 7d e4 53          	cmp    BYTE PTR [ebp-0x1c],0x53
 a67:	75 33                	jne    a9c <kbd_handle_sc+0x508>
						if ((kb_state & KBD_STATE_CONTROL) && (kb_state & KBD_STATE_ALT)) {
 a69:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 a70:	0f b7 c0             	movzx  eax,ax
 a73:	83 e0 08             	and    eax,0x8
 a76:	85 c0                	test   eax,eax
 a78:	74 22                	je     a9c <kbd_handle_sc+0x508>
 a7a:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 a81:	0f b7 c0             	movzx  eax,ax
 a84:	83 e0 10             	and    eax,0x10
 a87:	85 c0                	test   eax,eax
 a89:	74 11                	je     a9c <kbd_handle_sc+0x508>
								printf("rebooting\n");
 a8b:	c7 04 24 91 00 00 00 	mov    DWORD PTR [esp],0x91
 a92:	e8 fc ff ff ff       	call   a93 <kbd_handle_sc+0x4ff>
								pc_reset();
 a97:	e8 fc ff ff ff       	call   a98 <kbd_handle_sc+0x504>
				rprintf(&kb_reg, "p%02x %016b\n", scancode, kb_state);
 a9c:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 aa3:	0f b7 d0             	movzx  edx,ax
 aa6:	0f b6 45 e4          	movzx  eax,BYTE PTR [ebp-0x1c]
 aaa:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
 aae:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
 ab2:	c7 44 24 04 9c 00 00 00 	mov    DWORD PTR [esp+0x4],0x9c
 aba:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 ac1:	e8 fc ff ff ff       	call   ac2 <kbd_handle_sc+0x52e>
				if (kb_state & KBD_STATE_NEXT_RIGHT) {
 ac6:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 acd:	0f b7 c0             	movzx  eax,ax
 ad0:	25 00 10 00 00       	and    eax,0x1000
 ad5:	85 c0                	test   eax,eax
 ad7:	74 10                	je     ae9 <kbd_handle_sc+0x555>
						kb_state &= ~KBD_STATE_NEXT_RIGHT;
 ad9:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR ds:0x0
 ae0:	80 e4 ef             	and    ah,0xef
 ae3:	66 a3 00 00 00 00    	mov    ds:0x0,ax
}
 ae9:	90                   	nop
 aea:	c9                   	leave
 aeb:	c3                   	ret

00000aec <kbd_event_translate>:
};

/* TODO: keymaps(5)-like support 
 *       notify event consumers */
int kbd_event_translate(const struct key_event* ke)
{
 aec:	55                   	push   ebp
 aed:	89 e5                	mov    ebp,esp
 aef:	83 ec 10             	sub    esp,0x10
		/* miserable kludge <-> 128x256 keymaps in code */
		if (ke->prs) {
 af2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 af5:	0f b6 00             	movzx  eax,BYTE PTR [eax]
 af8:	84 c0                	test   al,al
 afa:	0f 84 5a 01 00 00    	je     c5a <kbd_event_translate+0x16e>
				uint16_t kbs = ke->state & (KBD_STATE_SHIFT | KBD_LIGHT_CAPS_LOCK);
 b00:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 b03:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
 b07:	66 25 20 80          	and    ax,0x8020
 b0b:	66 89 45 fc          	mov    WORD PTR [ebp-0x4],ax
				char rv;
				if (!(ke->state & KBD_STATE_NEXT_RIGHT) && (ke->state & KBD_LIGHT_NUM_LOCK)
 b0f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 b12:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
 b16:	0f b7 c0             	movzx  eax,ax
 b19:	25 00 10 00 00       	and    eax,0x1000
 b1e:	85 c0                	test   eax,eax
 b20:	0f 85 c9 00 00 00    	jne    bef <kbd_event_translate+0x103>
 b26:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 b29:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
 b2d:	0f b7 c0             	movzx  eax,ax
 b30:	25 00 40 00 00       	and    eax,0x4000
 b35:	85 c0                	test   eax,eax
 b37:	0f 84 b2 00 00 00    	je     bef <kbd_event_translate+0x103>
					&& ((ke->sc >= 0x47 && ke->sc <= 0x49)
 b3d:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 b40:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
 b44:	3c 46                	cmp    al,0x46
 b46:	76 0b                	jbe    b53 <kbd_event_translate+0x67>
 b48:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 b4b:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
 b4f:	3c 49                	cmp    al,0x49
 b51:	76 2c                	jbe    b7f <kbd_event_translate+0x93>
					|| (ke->sc >= 0x4b && ke->sc <= 0x4d)
 b53:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 b56:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
 b5a:	3c 4a                	cmp    al,0x4a
 b5c:	76 0b                	jbe    b69 <kbd_event_translate+0x7d>
 b5e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 b61:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
 b65:	3c 4d                	cmp    al,0x4d
 b67:	76 16                	jbe    b7f <kbd_event_translate+0x93>
					|| (ke->sc >= 0x4f && ke->sc <= 0x53))) {
 b69:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 b6c:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
 b70:	3c 4e                	cmp    al,0x4e
 b72:	76 7b                	jbe    bef <kbd_event_translate+0x103>
 b74:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 b77:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
 b7b:	3c 53                	cmp    al,0x53
 b7d:	77 70                	ja     bef <kbd_event_translate+0x103>
						/* produce numbers and . */
						if (ke->sc <= 0x49)
 b7f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 b82:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
 b86:	3c 49                	cmp    al,0x49
 b88:	77 12                	ja     b9c <kbd_event_translate+0xb0>
								return '7' + (ke->sc - 0x47);
 b8a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 b8d:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
 b91:	0f b6 c0             	movzx  eax,al
 b94:	83 e8 10             	sub    eax,0x10
 b97:	e9 c3 00 00 00       	jmp    c5f <kbd_event_translate+0x173>
						else if (ke->sc <= 0x4d)
 b9c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 b9f:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
 ba3:	3c 4d                	cmp    al,0x4d
 ba5:	77 12                	ja     bb9 <kbd_event_translate+0xcd>
								return '4' + (ke->sc - 0x4b);
 ba7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 baa:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
 bae:	0f b6 c0             	movzx  eax,al
 bb1:	83 e8 17             	sub    eax,0x17
 bb4:	e9 a6 00 00 00       	jmp    c5f <kbd_event_translate+0x173>
						else if (ke->sc <= 0x51)
 bb9:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 bbc:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
 bc0:	3c 51                	cmp    al,0x51
 bc2:	77 12                	ja     bd6 <kbd_event_translate+0xea>
								return '1' + (ke->sc - 0x4f);
 bc4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 bc7:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
 bcb:	0f b6 c0             	movzx  eax,al
 bce:	83 e8 1e             	sub    eax,0x1e
 bd1:	e9 89 00 00 00       	jmp    c5f <kbd_event_translate+0x173>
						else if (ke->sc == 0x52)
 bd6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 bd9:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
 bdd:	3c 52                	cmp    al,0x52
 bdf:	75 07                	jne    be8 <kbd_event_translate+0xfc>
								return '0';
 be1:	b8 30 00 00 00       	mov    eax,0x30
 be6:	eb 77                	jmp    c5f <kbd_event_translate+0x173>
						else
								return '.';
 be8:	b8 2e 00 00 00       	mov    eax,0x2e
 bed:	eb 70                	jmp    c5f <kbd_event_translate+0x173>
				}
				/* get the characters */
				if (kbs != 0 && kbs != (KBD_STATE_SHIFT & KBD_LIGHT_CAPS_LOCK)) /* caps */
 bef:	66 83 7d fc 00       	cmp    WORD PTR [ebp-0x4],0x0
 bf4:	74 23                	je     c19 <kbd_event_translate+0x12d>
 bf6:	66 83 7d fc 00       	cmp    WORD PTR [ebp-0x4],0x0
 bfb:	74 1c                	je     c19 <kbd_event_translate+0x12d>
						rv = kb_scancodes[(ke->sc & 0x7f) + 128];
 bfd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 c00:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
 c04:	0f b6 c0             	movzx  eax,al
 c07:	83 e0 7f             	and    eax,0x7f
 c0a:	83 e8 80             	sub    eax,0xffffff80
 c0d:	0f b6 80 00 00 00 00 	movzx  eax,BYTE PTR [eax+0x0]
 c14:	88 45 ff             	mov    BYTE PTR [ebp-0x1],al
 c17:	eb 17                	jmp    c30 <kbd_event_translate+0x144>
				else /* small */
						rv = kb_scancodes[ke->sc & 0x7f];
 c19:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 c1c:	0f b6 40 01          	movzx  eax,BYTE PTR [eax+0x1]
 c20:	0f b6 c0             	movzx  eax,al
 c23:	83 e0 7f             	and    eax,0x7f
 c26:	0f b6 80 00 00 00 00 	movzx  eax,BYTE PTR [eax+0x0]
 c2d:	88 45 ff             	mov    BYTE PTR [ebp-0x1],al
				/* treat ctrl+z as EOF */
				if (ke->state & KBD_STATE_CONTROL && (rv == 'z' || rv == 'd'))
 c30:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 c33:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
 c37:	0f b7 c0             	movzx  eax,ax
 c3a:	83 e0 08             	and    eax,0x8
 c3d:	85 c0                	test   eax,eax
 c3f:	74 13                	je     c54 <kbd_event_translate+0x168>
 c41:	80 7d ff 7a          	cmp    BYTE PTR [ebp-0x1],0x7a
 c45:	74 06                	je     c4d <kbd_event_translate+0x161>
 c47:	80 7d ff 64          	cmp    BYTE PTR [ebp-0x1],0x64
 c4b:	75 07                	jne    c54 <kbd_event_translate+0x168>
						return EOF;
 c4d:	b8 ff ff ff ff       	mov    eax,0xffffffff
 c52:	eb 0b                	jmp    c5f <kbd_event_translate+0x173>
				/* TODO: ctrl+c etc. signal handlers */
				return rv;
 c54:	0f be 45 ff          	movsx  eax,BYTE PTR [ebp-0x1]
 c58:	eb 05                	jmp    c5f <kbd_event_translate+0x173>
		}
		return 0;
 c5a:	b8 00 00 00 00       	mov    eax,0x0
}
 c5f:	c9                   	leave
 c60:	c3                   	ret
