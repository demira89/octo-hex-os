
kbd.o64:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <outb>:
				if (scancode == 0x2a) { /* LSHIFT */
						kb_state |= KBD_STATE_LSHIFT;
						if (!(kb_state & KBD_STATE_SHIFT)) {
								kb_state |= KBD_STATE_SHIFT;
						}
						/*if (kb_state & KBD_STATE_NEXT_RIGHT) *//* fake lshift */
   0:	55                   	push   rbp
   1:	48 89 e5             	mov    rbp,rsp
   4:	48 83 ec 08          	sub    rsp,0x8
   8:	89 fa                	mov    edx,edi
   a:	89 f0                	mov    eax,esi
   c:	66 89 55 fc          	mov    WORD PTR [rbp-0x4],dx
  10:	88 45 f8             	mov    BYTE PTR [rbp-0x8],al
						/*		kb_state &= ~KBD_STATE_NEXT_RIGHT;*/
  13:	0f b6 45 f8          	movzx  eax,BYTE PTR [rbp-0x8]
  17:	0f b7 55 fc          	movzx  edx,WORD PTR [rbp-0x4]
  1b:	ee                   	out    dx,al
				} else if (scancode == 0x36) { /* RSHIFT */
  1c:	90                   	nop
  1d:	c9                   	leave
  1e:	c3                   	ret

000000000000001f <inb>:
						kb_state |= KBD_STATE_RSHIFT;
						if (!(kb_state & KBD_STATE_SHIFT)) {
								kb_state |= KBD_STATE_SHIFT;
  1f:	55                   	push   rbp
  20:	48 89 e5             	mov    rbp,rsp
  23:	48 83 ec 18          	sub    rsp,0x18
  27:	89 f8                	mov    eax,edi
  29:	66 89 45 ec          	mov    WORD PTR [rbp-0x14],ax
						}
				} else if (scancode == 0x3a) { /* CAPS_LOCK */
  2d:	0f b7 45 ec          	movzx  eax,WORD PTR [rbp-0x14]
  31:	89 c2                	mov    edx,eax
  33:	ec                   	in     al,dx
  34:	88 45 ff             	mov    BYTE PTR [rbp-0x1],al
						if (!(kb_state & KBD_STATE_CAPS_LOCK)) {
  37:	0f b6 45 ff          	movzx  eax,BYTE PTR [rbp-0x1]
							kb_state |= KBD_STATE_CAPS_LOCK;
  3b:	c9                   	leave
  3c:	c3                   	ret

000000000000003d <kbd_fb_resize>:
{
  3d:	55                   	push   rbp
  3e:	48 89 e5             	mov    rbp,rsp
  41:	48 83 ec 08          	sub    rsp,0x8
  45:	89 7d fc             	mov    DWORD PTR [rbp-0x4],edi
  48:	89 75 f8             	mov    DWORD PTR [rbp-0x8],esi
		kb_reg.x = lx - 20;
  4b:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
  4e:	83 e8 14             	sub    eax,0x14
  51:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 58 <kbd_fb_resize+0x1b>
		kb_reg.ly = ly - 12;
  58:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
  5b:	83 e8 0c             	sub    eax,0xc
  5e:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 65 <kbd_fb_resize+0x28>
		kb_regH.x = lx - 20;
  65:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
  68:	83 e8 14             	sub    eax,0x14
  6b:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 72 <kbd_fb_resize+0x35>
		kb_regN.x = lx - 10;
  72:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
  75:	83 e8 0a             	sub    eax,0xa
  78:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 7f <kbd_fb_resize+0x42>
		kb_regN.y = ly - 2;
  7f:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
  82:	83 e8 02             	sub    eax,0x2
  85:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 8c <kbd_fb_resize+0x4f>
}
  8c:	90                   	nop
  8d:	c9                   	leave
  8e:	c3                   	ret

000000000000008f <kbd_init>:
{
  8f:	55                   	push   rbp
  90:	48 89 e5             	mov    rbp,rsp
  93:	48 83 ec 10          	sub    rsp,0x10
		rb_events = ringbuffer_allocate(KBD_INIT_BUFSIZE);
  97:	bf 00 02 00 00       	mov    edi,0x200
  9c:	e8 00 00 00 00       	call   a1 <kbd_init+0x12>
  a1:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # a8 <kbd_init+0x19>
		rb_commands = ringbuffer_allocate(KBD_INIT_BUFSIZE);
  a8:	bf 00 02 00 00       	mov    edi,0x200
  ad:	e8 00 00 00 00       	call   b2 <kbd_init+0x23>
  b2:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # b9 <kbd_init+0x2a>
		region_clear(&kb_reg);
  b9:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
  c0:	e8 00 00 00 00       	call   c5 <kbd_init+0x36>
		rprintf(&kb_regH, "    LGTNRRRLLLSSSSSS"
  c5:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
  cc:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
  d3:	b8 00 00 00 00       	mov    eax,0x0
  d8:	e8 00 00 00 00       	call   dd <kbd_init+0x4e>
		cmd = KBC_RESET;
  dd:	c6 45 ff 01          	mov    BYTE PTR [rbp-0x1],0x1
		ringbuffer_enqueue(rb_commands, &cmd, sizeof(cmd));
  e1:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # e8 <kbd_init+0x59>
  e8:	48 8d 4d ff          	lea    rcx,[rbp-0x1]
  ec:	ba 01 00 00 00       	mov    edx,0x1
  f1:	48 89 ce             	mov    rsi,rcx
  f4:	48 89 c7             	mov    rdi,rax
  f7:	e8 00 00 00 00       	call   fc <kbd_init+0x6d>
}
  fc:	90                   	nop
  fd:	c9                   	leave
  fe:	c3                   	ret

00000000000000ff <kbd_wait>:
{
  ff:	55                   	push   rbp
 100:	48 89 e5             	mov    rbp,rsp
		while (!(inb(KBD_CH4) & 1));
 103:	90                   	nop
 104:	bf 64 00 00 00       	mov    edi,0x64
 109:	e8 11 ff ff ff       	call   1f <inb>
 10e:	0f b6 c0             	movzx  eax,al
 111:	83 e0 01             	and    eax,0x1
 114:	85 c0                	test   eax,eax
 116:	74 ec                	je     104 <kbd_wait+0x5>
}
 118:	90                   	nop
 119:	90                   	nop
 11a:	5d                   	pop    rbp
 11b:	c3                   	ret

000000000000011c <kbd_process_queue>:
{
 11c:	55                   	push   rbp
 11d:	48 89 e5             	mov    rbp,rsp
 120:	48 83 ec 20          	sub    rsp,0x20
		preempt_disable();
 124:	b8 00 00 00 00       	mov    eax,0x0
 129:	e8 00 00 00 00       	call   12e <kbd_process_queue+0x12>
 12e:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
 131:	83 c2 01             	add    edx,0x1
 134:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
		while ((s = ringbuffer_available(rb_commands))) {
 137:	e9 30 02 00 00       	jmp    36c <kbd_process_queue+0x250>
				uint8_t cmd, a1, a2, nr = 0;
 13c:	c6 45 fd 00          	mov    BYTE PTR [rbp-0x3],0x0
				ringbuffer_dequeue(rb_commands, &cmd, sizeof(cmd));
 140:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 147 <kbd_process_queue+0x2b>
 147:	48 8d 4d ef          	lea    rcx,[rbp-0x11]
 14b:	ba 01 00 00 00       	mov    edx,0x1
 150:	48 89 ce             	mov    rsi,rcx
 153:	48 89 c7             	mov    rdi,rax
 156:	e8 00 00 00 00       	call   15b <kbd_process_queue+0x3f>
				rprintf(&kb_reg, "handling command %x\n", cmd);
 15b:	0f b6 45 ef          	movzx  eax,BYTE PTR [rbp-0x11]
 15f:	0f b6 c0             	movzx  eax,al
 162:	89 c2                	mov    edx,eax
 164:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
 16b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 172:	b8 00 00 00 00       	mov    eax,0x0
 177:	e8 00 00 00 00       	call   17c <kbd_process_queue+0x60>
				switch (cmd) {
 17c:	0f b6 45 ef          	movzx  eax,BYTE PTR [rbp-0x11]
 180:	0f b6 c0             	movzx  eax,al
 183:	83 f8 04             	cmp    eax,0x4
 186:	0f 84 0e 01 00 00    	je     29a <kbd_process_queue+0x17e>
 18c:	83 f8 04             	cmp    eax,0x4
 18f:	0f 8f 80 01 00 00    	jg     315 <kbd_process_queue+0x1f9>
 195:	83 f8 03             	cmp    eax,0x3
 198:	74 62                	je     1fc <kbd_process_queue+0xe0>
 19a:	83 f8 03             	cmp    eax,0x3
 19d:	0f 8f 72 01 00 00    	jg     315 <kbd_process_queue+0x1f9>
 1a3:	83 f8 01             	cmp    eax,0x1
 1a6:	74 0a                	je     1b2 <kbd_process_queue+0x96>
 1a8:	83 f8 02             	cmp    eax,0x2
 1ab:	74 7e                	je     22b <kbd_process_queue+0x10f>
								break;
 1ad:	e9 63 01 00 00       	jmp    315 <kbd_process_queue+0x1f9>
								outb(KBD_CH0, 0xff);
 1b2:	be ff 00 00 00       	mov    esi,0xff
 1b7:	bf 60 00 00 00       	mov    edi,0x60
 1bc:	e8 3f fe ff ff       	call   0 <outb>
								a1 = inb(KBD_CH0);
 1c1:	bf 60 00 00 00       	mov    edi,0x60
 1c6:	e8 54 fe ff ff       	call   1f <inb>
 1cb:	88 45 ff             	mov    BYTE PTR [rbp-0x1],al
								nr = 1;
 1ce:	c6 45 fd 01          	mov    BYTE PTR [rbp-0x3],0x1
								if (a1 == 0xfa) {
 1d2:	80 7d ff fa          	cmp    BYTE PTR [rbp-0x1],0xfa
 1d6:	0f 85 3c 01 00 00    	jne    318 <kbd_process_queue+0x1fc>
										kbd_wait();
 1dc:	b8 00 00 00 00       	mov    eax,0x0
 1e1:	e8 00 00 00 00       	call   1e6 <kbd_process_queue+0xca>
										a2 = inb(KBD_CH0);
 1e6:	bf 60 00 00 00       	mov    edi,0x60
 1eb:	e8 2f fe ff ff       	call   1f <inb>
 1f0:	88 45 fe             	mov    BYTE PTR [rbp-0x2],al
										nr = 2;
 1f3:	c6 45 fd 02          	mov    BYTE PTR [rbp-0x3],0x2
								break;
 1f7:	e9 1c 01 00 00       	jmp    318 <kbd_process_queue+0x1fc>
								outb(KBD_CH0, 0xf4);
 1fc:	be f4 00 00 00       	mov    esi,0xf4
 201:	bf 60 00 00 00       	mov    edi,0x60
 206:	e8 f5 fd ff ff       	call   0 <outb>
								kbd_wait();
 20b:	b8 00 00 00 00       	mov    eax,0x0
 210:	e8 00 00 00 00       	call   215 <kbd_process_queue+0xf9>
								a1 = inb(KBD_CH0);
 215:	bf 60 00 00 00       	mov    edi,0x60
 21a:	e8 00 fe ff ff       	call   1f <inb>
 21f:	88 45 ff             	mov    BYTE PTR [rbp-0x1],al
								nr = 1;
 222:	c6 45 fd 01          	mov    BYTE PTR [rbp-0x3],0x1
								break;
 226:	e9 f1 00 00 00       	jmp    31c <kbd_process_queue+0x200>
								outb(KBD_CH0, 0xf5);
 22b:	be f5 00 00 00       	mov    esi,0xf5
 230:	bf 60 00 00 00       	mov    edi,0x60
 235:	e8 c6 fd ff ff       	call   0 <outb>
								kbd_wait();
 23a:	b8 00 00 00 00       	mov    eax,0x0
 23f:	e8 00 00 00 00       	call   244 <kbd_process_queue+0x128>
								a2 = inb(KBD_CH4);
 244:	bf 64 00 00 00       	mov    edi,0x64
 249:	e8 d1 fd ff ff       	call   1f <inb>
 24e:	88 45 fe             	mov    BYTE PTR [rbp-0x2],al
								while ((a1 = inb(KBD_CH0))) {
 251:	eb 28                	jmp    27b <kbd_process_queue+0x15f>
										if (a1 == 0xfa || a1 == 0x00 || a1 == 0xfe)
 253:	80 7d ff fa          	cmp    BYTE PTR [rbp-0x1],0xfa
 257:	74 38                	je     291 <kbd_process_queue+0x175>
 259:	80 7d ff 00          	cmp    BYTE PTR [rbp-0x1],0x0
 25d:	74 32                	je     291 <kbd_process_queue+0x175>
 25f:	80 7d ff fe          	cmp    BYTE PTR [rbp-0x1],0xfe
 263:	74 2c                	je     291 <kbd_process_queue+0x175>
										if (a2 & (1 << 5)) /* read sth useful */
 265:	0f b6 45 fe          	movzx  eax,BYTE PTR [rbp-0x2]
 269:	83 e0 20             	and    eax,0x20
 26c:	85 c0                	test   eax,eax
 26e:	74 20                	je     290 <kbd_process_queue+0x174>
												kbd_handle_sc(a1); /* watch out for ff and fe too */
 270:	0f b6 45 ff          	movzx  eax,BYTE PTR [rbp-0x1]
 274:	89 c7                	mov    edi,eax
 276:	e8 00 00 00 00       	call   27b <kbd_process_queue+0x15f>
								while ((a1 = inb(KBD_CH0))) {
 27b:	bf 60 00 00 00       	mov    edi,0x60
 280:	e8 9a fd ff ff       	call   1f <inb>
 285:	88 45 ff             	mov    BYTE PTR [rbp-0x1],al
 288:	80 7d ff 00          	cmp    BYTE PTR [rbp-0x1],0x0
 28c:	75 c5                	jne    253 <kbd_process_queue+0x137>
 28e:	eb 01                	jmp    291 <kbd_process_queue+0x175>
												break;
 290:	90                   	nop
								nr = 1;
 291:	c6 45 fd 01          	mov    BYTE PTR [rbp-0x3],0x1
								break;
 295:	e9 82 00 00 00       	jmp    31c <kbd_process_queue+0x200>
								outb(KBD_CH0, 0xed);
 29a:	be ed 00 00 00       	mov    esi,0xed
 29f:	bf 60 00 00 00       	mov    edi,0x60
 2a4:	e8 57 fd ff ff       	call   0 <outb>
								kbd_wait();
 2a9:	b8 00 00 00 00       	mov    eax,0x0
 2ae:	e8 00 00 00 00       	call   2b3 <kbd_process_queue+0x197>
								a1 = inb(KBD_CH0);
 2b3:	bf 60 00 00 00       	mov    edi,0x60
 2b8:	e8 62 fd ff ff       	call   1f <inb>
 2bd:	88 45 ff             	mov    BYTE PTR [rbp-0x1],al
								nr = 1;
 2c0:	c6 45 fd 01          	mov    BYTE PTR [rbp-0x3],0x1
								ringbuffer_dequeue(rb_commands, &cmd, sizeof(cmd));
 2c4:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 2cb <kbd_process_queue+0x1af>
 2cb:	48 8d 4d ef          	lea    rcx,[rbp-0x11]
 2cf:	ba 01 00 00 00       	mov    edx,0x1
 2d4:	48 89 ce             	mov    rsi,rcx
 2d7:	48 89 c7             	mov    rdi,rax
 2da:	e8 00 00 00 00       	call   2df <kbd_process_queue+0x1c3>
								if (a1 == 0xfa) {
 2df:	80 7d ff fa          	cmp    BYTE PTR [rbp-0x1],0xfa
 2e3:	75 36                	jne    31b <kbd_process_queue+0x1ff>
										outb(KBD_CH0, cmd);
 2e5:	0f b6 45 ef          	movzx  eax,BYTE PTR [rbp-0x11]
 2e9:	0f b6 c0             	movzx  eax,al
 2ec:	89 c6                	mov    esi,eax
 2ee:	bf 60 00 00 00       	mov    edi,0x60
 2f3:	e8 08 fd ff ff       	call   0 <outb>
										kbd_wait();
 2f8:	b8 00 00 00 00       	mov    eax,0x0
 2fd:	e8 00 00 00 00       	call   302 <kbd_process_queue+0x1e6>
										a2 = inb(KBD_CH0);
 302:	bf 60 00 00 00       	mov    edi,0x60
 307:	e8 13 fd ff ff       	call   1f <inb>
 30c:	88 45 fe             	mov    BYTE PTR [rbp-0x2],al
										nr = 2;
 30f:	c6 45 fd 02          	mov    BYTE PTR [rbp-0x3],0x2
								break;
 313:	eb 06                	jmp    31b <kbd_process_queue+0x1ff>
								break;
 315:	90                   	nop
 316:	eb 04                	jmp    31c <kbd_process_queue+0x200>
								break;
 318:	90                   	nop
 319:	eb 01                	jmp    31c <kbd_process_queue+0x200>
								break;
 31b:	90                   	nop
				if (nr == 1)
 31c:	80 7d fd 01          	cmp    BYTE PTR [rbp-0x3],0x1
 320:	75 20                	jne    342 <kbd_process_queue+0x226>
						rprintf(&kb_reg, "response %x\n", a1);
 322:	0f b6 45 ff          	movzx  eax,BYTE PTR [rbp-0x1]
 326:	89 c2                	mov    edx,eax
 328:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
 32f:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 336:	b8 00 00 00 00       	mov    eax,0x0
 33b:	e8 00 00 00 00       	call   340 <kbd_process_queue+0x224>
 340:	eb 2a                	jmp    36c <kbd_process_queue+0x250>
				else if (nr == 2)
 342:	80 7d fd 02          	cmp    BYTE PTR [rbp-0x3],0x2
 346:	75 24                	jne    36c <kbd_process_queue+0x250>
						rprintf(&kb_reg, "responses %x %x\n", a1, a2);
 348:	0f b6 55 fe          	movzx  edx,BYTE PTR [rbp-0x2]
 34c:	0f b6 45 ff          	movzx  eax,BYTE PTR [rbp-0x1]
 350:	89 d1                	mov    ecx,edx
 352:	89 c2                	mov    edx,eax
 354:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
 35b:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 362:	b8 00 00 00 00       	mov    eax,0x0
 367:	e8 00 00 00 00       	call   36c <kbd_process_queue+0x250>
		while ((s = ringbuffer_available(rb_commands))) {
 36c:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 373 <kbd_process_queue+0x257>
 373:	48 89 c7             	mov    rdi,rax
 376:	e8 00 00 00 00       	call   37b <kbd_process_queue+0x25f>
 37b:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
 37f:	48 83 7d f0 00       	cmp    QWORD PTR [rbp-0x10],0x0
 384:	0f 85 b2 fd ff ff    	jne    13c <kbd_process_queue+0x20>
		preempt_enable();
 38a:	b8 00 00 00 00       	mov    eax,0x0
 38f:	e8 00 00 00 00       	call   394 <kbd_process_queue+0x278>
 394:	8b 50 2c             	mov    edx,DWORD PTR [rax+0x2c]
 397:	83 ea 01             	sub    edx,0x1
 39a:	89 50 2c             	mov    DWORD PTR [rax+0x2c],edx
 39d:	b8 00 00 00 00       	mov    eax,0x0
 3a2:	e8 00 00 00 00       	call   3a7 <kbd_process_queue+0x28b>
 3a7:	8b 00                	mov    eax,DWORD PTR [rax]
 3a9:	83 e0 01             	and    eax,0x1
 3ac:	85 c0                	test   eax,eax
 3ae:	74 0a                	je     3ba <kbd_process_queue+0x29e>
 3b0:	b8 00 00 00 00       	mov    eax,0x0
 3b5:	e8 00 00 00 00       	call   3ba <kbd_process_queue+0x29e>
}
 3ba:	90                   	nop
 3bb:	c9                   	leave
 3bc:	c3                   	ret

00000000000003bd <kbd_event_present>:
{
 3bd:	55                   	push   rbp
 3be:	48 89 e5             	mov    rbp,rsp
		return ringbuffer_available(rb_events) / sizeof(struct key_event);
 3c1:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 3c8 <kbd_event_present+0xb>
 3c8:	48 89 c7             	mov    rdi,rax
 3cb:	e8 00 00 00 00       	call   3d0 <kbd_event_present+0x13>
 3d0:	48 c1 e8 02          	shr    rax,0x2
}
 3d4:	5d                   	pop    rbp
 3d5:	c3                   	ret

00000000000003d6 <kbd_get_event>:
{
 3d6:	55                   	push   rbp
 3d7:	48 89 e5             	mov    rbp,rsp
 3da:	48 83 ec 10          	sub    rsp,0x10
		ringbuffer_dequeue(rb_events, &rv, sizeof(rv));
 3de:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 3e5 <kbd_get_event+0xf>
 3e5:	48 8d 4d fc          	lea    rcx,[rbp-0x4]
 3e9:	ba 04 00 00 00       	mov    edx,0x4
 3ee:	48 89 ce             	mov    rsi,rcx
 3f1:	48 89 c7             	mov    rdi,rax
 3f4:	e8 00 00 00 00       	call   3f9 <kbd_get_event+0x23>
		return rv;
 3f9:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
}
 3fc:	c9                   	leave
 3fd:	c3                   	ret

00000000000003fe <kbd_lights_update>:
{
 3fe:	55                   	push   rbp
 3ff:	48 89 e5             	mov    rbp,rsp
 402:	48 83 ec 10          	sub    rsp,0x10
		cmd = KBC_DISABLE;
 406:	c6 45 ff 02          	mov    BYTE PTR [rbp-0x1],0x2
		ringbuffer_enqueue(rb_commands, &cmd, sizeof(cmd));
 40a:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 411 <kbd_lights_update+0x13>
 411:	48 8d 4d ff          	lea    rcx,[rbp-0x1]
 415:	ba 01 00 00 00       	mov    edx,0x1
 41a:	48 89 ce             	mov    rsi,rcx
 41d:	48 89 c7             	mov    rdi,rax
 420:	e8 00 00 00 00       	call   425 <kbd_lights_update+0x27>
		cmd = KBC_SET_LIGHTS;
 425:	c6 45 ff 04          	mov    BYTE PTR [rbp-0x1],0x4
		ringbuffer_enqueue(rb_commands, &cmd, sizeof(cmd));
 429:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 430 <kbd_lights_update+0x32>
 430:	48 8d 4d ff          	lea    rcx,[rbp-0x1]
 434:	ba 01 00 00 00       	mov    edx,0x1
 439:	48 89 ce             	mov    rsi,rcx
 43c:	48 89 c7             	mov    rdi,rax
 43f:	e8 00 00 00 00       	call   444 <kbd_lights_update+0x46>
		cmd = (kb_state & KBD_LIGHT_MASK) >> 13;
 444:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 44b <kbd_lights_update+0x4d>
 44b:	66 c1 e8 0d          	shr    ax,0xd
 44f:	88 45 ff             	mov    BYTE PTR [rbp-0x1],al
		ringbuffer_enqueue(rb_commands, &cmd, sizeof(cmd));
 452:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 459 <kbd_lights_update+0x5b>
 459:	48 8d 4d ff          	lea    rcx,[rbp-0x1]
 45d:	ba 01 00 00 00       	mov    edx,0x1
 462:	48 89 ce             	mov    rsi,rcx
 465:	48 89 c7             	mov    rdi,rax
 468:	e8 00 00 00 00       	call   46d <kbd_lights_update+0x6f>
		cmd = KBC_ENABLE;
 46d:	c6 45 ff 03          	mov    BYTE PTR [rbp-0x1],0x3
		ringbuffer_enqueue(rb_commands, &cmd, sizeof(cmd));
 471:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 478 <kbd_lights_update+0x7a>
 478:	48 8d 4d ff          	lea    rcx,[rbp-0x1]
 47c:	ba 01 00 00 00       	mov    edx,0x1
 481:	48 89 ce             	mov    rsi,rcx
 484:	48 89 c7             	mov    rdi,rax
 487:	e8 00 00 00 00       	call   48c <kbd_lights_update+0x8e>
		kb_regN.cur_x = kb_regN.cur_y = 0;
 48c:	66 c7 05 00 00 00 00 00 00 	mov    WORD PTR [rip+0x0],0x0        # 495 <kbd_lights_update+0x97>
 495:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 49c <kbd_lights_update+0x9e>
 49c:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 4a3 <kbd_lights_update+0xa5>
		region_putchar(&kb_regN, (kb_state & KBD_LIGHT_NUM_LOCK) ? '#' : ' ');
 4a3:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 4aa <kbd_lights_update+0xac>
 4aa:	0f b7 c0             	movzx  eax,ax
 4ad:	25 00 40 00 00       	and    eax,0x4000
 4b2:	85 c0                	test   eax,eax
 4b4:	74 07                	je     4bd <kbd_lights_update+0xbf>
 4b6:	b8 23 00 00 00       	mov    eax,0x23
 4bb:	eb 05                	jmp    4c2 <kbd_lights_update+0xc4>
 4bd:	b8 20 00 00 00       	mov    eax,0x20
 4c2:	89 c6                	mov    esi,eax
 4c4:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 4cb:	e8 00 00 00 00       	call   4d0 <kbd_lights_update+0xd2>
		region_putchar(&kb_regN, (kb_state & KBD_LIGHT_CAPS_LOCK) ? '#' : ' ');
 4d0:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 4d7 <kbd_lights_update+0xd9>
 4d7:	66 85 c0             	test   ax,ax
 4da:	79 07                	jns    4e3 <kbd_lights_update+0xe5>
 4dc:	b8 23 00 00 00       	mov    eax,0x23
 4e1:	eb 05                	jmp    4e8 <kbd_lights_update+0xea>
 4e3:	b8 20 00 00 00       	mov    eax,0x20
 4e8:	89 c6                	mov    esi,eax
 4ea:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 4f1:	e8 00 00 00 00       	call   4f6 <kbd_lights_update+0xf8>
		region_putchar(&kb_regN, (kb_state & KBD_LIGHT_SCROLL_LOCK) ? '#' : ' ');
 4f6:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 4fd <kbd_lights_update+0xff>
 4fd:	0f b7 c0             	movzx  eax,ax
 500:	25 00 20 00 00       	and    eax,0x2000
 505:	85 c0                	test   eax,eax
 507:	74 07                	je     510 <kbd_lights_update+0x112>
 509:	b8 23 00 00 00       	mov    eax,0x23
 50e:	eb 05                	jmp    515 <kbd_lights_update+0x117>
 510:	b8 20 00 00 00       	mov    eax,0x20
 515:	89 c6                	mov    esi,eax
 517:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 51e:	e8 00 00 00 00       	call   523 <kbd_lights_update+0x125>
}
 523:	90                   	nop
 524:	c9                   	leave
 525:	c3                   	ret

0000000000000526 <kbd_handler>:
{
 526:	55                   	push   rbp
 527:	48 89 e5             	mov    rbp,rsp
 52a:	48 83 ec 10          	sub    rsp,0x10
		if (!rb_events || !rb_commands) /* don't corrupt memory */
 52e:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 535 <kbd_handler+0xf>
 535:	48 85 c0             	test   rax,rax
 538:	74 6c                	je     5a6 <kbd_handler+0x80>
 53a:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 541 <kbd_handler+0x1b>
 541:	48 85 c0             	test   rax,rax
 544:	74 60                	je     5a6 <kbd_handler+0x80>
				sc = inb(KBD_CH0);
 546:	bf 60 00 00 00       	mov    edi,0x60
 54b:	e8 cf fa ff ff       	call   1f <inb>
 550:	88 45 ff             	mov    BYTE PTR [rbp-0x1],al
				if (sc != 0xfa && sc != 0xfe && sc != 0x00 && sc != 0xff)
 553:	80 7d ff fa          	cmp    BYTE PTR [rbp-0x1],0xfa
 557:	74 1d                	je     576 <kbd_handler+0x50>
 559:	80 7d ff fe          	cmp    BYTE PTR [rbp-0x1],0xfe
 55d:	74 17                	je     576 <kbd_handler+0x50>
 55f:	80 7d ff 00          	cmp    BYTE PTR [rbp-0x1],0x0
 563:	74 11                	je     576 <kbd_handler+0x50>
 565:	80 7d ff ff          	cmp    BYTE PTR [rbp-0x1],0xff
 569:	74 0b                	je     576 <kbd_handler+0x50>
						kbd_handle_sc(sc);
 56b:	0f b6 45 ff          	movzx  eax,BYTE PTR [rbp-0x1]
 56f:	89 c7                	mov    edi,eax
 571:	e8 00 00 00 00       	call   576 <kbd_handler+0x50>
		} while ((inb(KBD_CH4) & 1));
 576:	bf 64 00 00 00       	mov    edi,0x64
 57b:	e8 9f fa ff ff       	call   1f <inb>
 580:	0f b6 c0             	movzx  eax,al
 583:	83 e0 01             	and    eax,0x1
 586:	85 c0                	test   eax,eax
 588:	75 bc                	jne    546 <kbd_handler+0x20>
		if (kbd_event_present())
 58a:	b8 00 00 00 00       	mov    eax,0x0
 58f:	e8 00 00 00 00       	call   594 <kbd_handler+0x6e>
 594:	85 c0                	test   eax,eax
 596:	74 0f                	je     5a7 <kbd_handler+0x81>
				wake_up_external_event(&wq_kbd);
 598:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 59f:	e8 00 00 00 00       	call   5a4 <kbd_handler+0x7e>
 5a4:	eb 01                	jmp    5a7 <kbd_handler+0x81>
				return;
 5a6:	90                   	nop
}
 5a7:	c9                   	leave
 5a8:	c3                   	ret

00000000000005a9 <kbd_handle_sc>:
{
 5a9:	55                   	push   rbp
 5aa:	48 89 e5             	mov    rbp,rsp
 5ad:	48 83 ec 20          	sub    rsp,0x20
 5b1:	89 f8                	mov    eax,edi
 5b3:	88 45 ec             	mov    BYTE PTR [rbp-0x14],al
		ke.prs = !(scancode & 0x80);
 5b6:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
 5ba:	f7 d0                	not    eax
 5bc:	c0 e8 07             	shr    al,0x7
 5bf:	88 45 fa             	mov    BYTE PTR [rbp-0x6],al
		ke.state = kb_state;
 5c2:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 5c9 <kbd_handle_sc+0x20>
 5c9:	66 89 45 fc          	mov    WORD PTR [rbp-0x4],ax
		ke.sc = scancode & 0x7f;
 5cd:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
 5d1:	83 e0 7f             	and    eax,0x7f
 5d4:	88 45 fb             	mov    BYTE PTR [rbp-0x5],al
		ringbuffer_enqueue(rb_events, &ke, sizeof(ke));
 5d7:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 5de <kbd_handle_sc+0x35>
 5de:	48 8d 4d fa          	lea    rcx,[rbp-0x6]
 5e2:	ba 04 00 00 00       	mov    edx,0x4
 5e7:	48 89 ce             	mov    rsi,rcx
 5ea:	48 89 c7             	mov    rdi,rax
 5ed:	e8 00 00 00 00       	call   5f2 <kbd_handle_sc+0x49>
		if (scancode & 0x80) {
 5f2:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
 5f6:	84 c0                	test   al,al
 5f8:	0f 89 7d 02 00 00    	jns    87b <kbd_handle_sc+0x2d2>
				scs = scancode;
 5fe:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
 602:	88 45 ff             	mov    BYTE PTR [rbp-0x1],al
				scancode ^= 0x80;
 605:	80 75 ec 80          	xor    BYTE PTR [rbp-0x14],0x80
				if (scancode == 0x3a) { /* CAPS_LOCK */
 609:	80 7d ec 3a          	cmp    BYTE PTR [rbp-0x14],0x3a
 60d:	75 2b                	jne    63a <kbd_handle_sc+0x91>
						if (kb_state & KBD_STATE_CAPS_LOCK) {
 60f:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 616 <kbd_handle_sc+0x6d>
 616:	0f b7 c0             	movzx  eax,ax
 619:	83 e0 04             	and    eax,0x4
 61c:	85 c0                	test   eax,eax
 61e:	0f 84 f6 01 00 00    	je     81a <kbd_handle_sc+0x271>
								kb_state &= ~KBD_STATE_CAPS_LOCK;
 624:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 62b <kbd_handle_sc+0x82>
 62b:	83 e0 fb             	and    eax,0xfffffffb
 62e:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 635 <kbd_handle_sc+0x8c>
 635:	e9 e0 01 00 00       	jmp    81a <kbd_handle_sc+0x271>
				} else if (scancode == 0x46) { /* SCROLL LOCK */
 63a:	80 7d ec 46          	cmp    BYTE PTR [rbp-0x14],0x46
 63e:	75 2b                	jne    66b <kbd_handle_sc+0xc2>
						if (kb_state & KBD_STATE_SCROLL_LOCK) {
 640:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 647 <kbd_handle_sc+0x9e>
 647:	0f b7 c0             	movzx  eax,ax
 64a:	83 e0 01             	and    eax,0x1
 64d:	85 c0                	test   eax,eax
 64f:	0f 84 c5 01 00 00    	je     81a <kbd_handle_sc+0x271>
								kb_state &= ~KBD_STATE_SCROLL_LOCK;
 655:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 65c <kbd_handle_sc+0xb3>
 65c:	83 e0 fe             	and    eax,0xfffffffe
 65f:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 666 <kbd_handle_sc+0xbd>
 666:	e9 af 01 00 00       	jmp    81a <kbd_handle_sc+0x271>
				} else if (scancode == 0x45) { /* NUM LOCK */
 66b:	80 7d ec 45          	cmp    BYTE PTR [rbp-0x14],0x45
 66f:	75 2b                	jne    69c <kbd_handle_sc+0xf3>
						if (kb_state & KBD_STATE_NUM_LOCK) {
 671:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 678 <kbd_handle_sc+0xcf>
 678:	0f b7 c0             	movzx  eax,ax
 67b:	83 e0 02             	and    eax,0x2
 67e:	85 c0                	test   eax,eax
 680:	0f 84 94 01 00 00    	je     81a <kbd_handle_sc+0x271>
								kb_state &= ~KBD_STATE_NUM_LOCK;
 686:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 68d <kbd_handle_sc+0xe4>
 68d:	83 e0 fd             	and    eax,0xfffffffd
 690:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 697 <kbd_handle_sc+0xee>
 697:	e9 7e 01 00 00       	jmp    81a <kbd_handle_sc+0x271>
				} else if (scancode == 0x60) { /* RIGHT signalling */
 69c:	80 7d ec 60          	cmp    BYTE PTR [rbp-0x14],0x60
 6a0:	75 2d                	jne    6cf <kbd_handle_sc+0x126>
						if (!(kb_state & KBD_STATE_NEXT_RIGHT)) {
 6a2:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 6a9 <kbd_handle_sc+0x100>
 6a9:	0f b7 c0             	movzx  eax,ax
 6ac:	25 00 10 00 00       	and    eax,0x1000
 6b1:	85 c0                	test   eax,eax
 6b3:	0f 85 61 01 00 00    	jne    81a <kbd_handle_sc+0x271>
								kb_state |= KBD_STATE_NEXT_RIGHT;
 6b9:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 6c0 <kbd_handle_sc+0x117>
 6c0:	80 cc 10             	or     ah,0x10
 6c3:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 6ca <kbd_handle_sc+0x121>
 6ca:	e9 4b 01 00 00       	jmp    81a <kbd_handle_sc+0x271>
				} else if (scancode == 0x2a) { /* LSHIFT */
 6cf:	80 7d ec 2a          	cmp    BYTE PTR [rbp-0x14],0x2a
 6d3:	75 3e                	jne    713 <kbd_handle_sc+0x16a>
						kb_state &= ~KBD_STATE_LSHIFT;
 6d5:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 6dc <kbd_handle_sc+0x133>
 6dc:	80 e4 fe             	and    ah,0xfe
 6df:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 6e6 <kbd_handle_sc+0x13d>
						if (!(kb_state & KBD_STATE_RSHIFT))
 6e6:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 6ed <kbd_handle_sc+0x144>
 6ed:	0f b7 c0             	movzx  eax,ax
 6f0:	25 00 08 00 00       	and    eax,0x800
 6f5:	85 c0                	test   eax,eax
 6f7:	0f 85 1d 01 00 00    	jne    81a <kbd_handle_sc+0x271>
								kb_state &= ~KBD_STATE_SHIFT;
 6fd:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 704 <kbd_handle_sc+0x15b>
 704:	83 e0 df             	and    eax,0xffffffdf
 707:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 70e <kbd_handle_sc+0x165>
 70e:	e9 07 01 00 00       	jmp    81a <kbd_handle_sc+0x271>
				} else if (scancode == 0x36) { /* RSHIFT */
 713:	80 7d ec 36          	cmp    BYTE PTR [rbp-0x14],0x36
 717:	75 3e                	jne    757 <kbd_handle_sc+0x1ae>
						kb_state &= ~KBD_STATE_RSHIFT;
 719:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 720 <kbd_handle_sc+0x177>
 720:	80 e4 f7             	and    ah,0xf7
 723:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 72a <kbd_handle_sc+0x181>
						if (!(kb_state & KBD_STATE_LSHIFT))
 72a:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 731 <kbd_handle_sc+0x188>
 731:	0f b7 c0             	movzx  eax,ax
 734:	25 00 01 00 00       	and    eax,0x100
 739:	85 c0                	test   eax,eax
 73b:	0f 85 d9 00 00 00    	jne    81a <kbd_handle_sc+0x271>
								kb_state &= ~KBD_STATE_SHIFT;
 741:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 748 <kbd_handle_sc+0x19f>
 748:	83 e0 df             	and    eax,0xffffffdf
 74b:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 752 <kbd_handle_sc+0x1a9>
 752:	e9 c3 00 00 00       	jmp    81a <kbd_handle_sc+0x271>
				} else if (scancode == 0x1d) { /* L/R CONTROL */
 757:	80 7d ec 1d          	cmp    BYTE PTR [rbp-0x14],0x1d
 75b:	75 5d                	jne    7ba <kbd_handle_sc+0x211>
						if (kb_state & KBD_STATE_NEXT_RIGHT) {
 75d:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 764 <kbd_handle_sc+0x1bb>
 764:	0f b7 c0             	movzx  eax,ax
 767:	25 00 10 00 00       	and    eax,0x1000
 76c:	85 c0                	test   eax,eax
 76e:	74 13                	je     783 <kbd_handle_sc+0x1da>
								kb_state &= ~KBD_STATE_RCONTROL;
 770:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 777 <kbd_handle_sc+0x1ce>
 777:	80 e4 fd             	and    ah,0xfd
 77a:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 781 <kbd_handle_sc+0x1d8>
 781:	eb 11                	jmp    794 <kbd_handle_sc+0x1eb>
								kb_state &= ~KBD_STATE_LCONTROL;
 783:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 78a <kbd_handle_sc+0x1e1>
 78a:	83 e0 bf             	and    eax,0xffffffbf
 78d:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 794 <kbd_handle_sc+0x1eb>
						if (!(kb_state & (KBD_STATE_LCONTROL | KBD_STATE_RCONTROL)))
 794:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 79b <kbd_handle_sc+0x1f2>
 79b:	0f b7 c0             	movzx  eax,ax
 79e:	25 40 02 00 00       	and    eax,0x240
 7a3:	85 c0                	test   eax,eax
 7a5:	75 73                	jne    81a <kbd_handle_sc+0x271>
								kb_state &= ~KBD_STATE_CONTROL;
 7a7:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 7ae <kbd_handle_sc+0x205>
 7ae:	83 e0 f7             	and    eax,0xfffffff7
 7b1:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 7b8 <kbd_handle_sc+0x20f>
 7b8:	eb 60                	jmp    81a <kbd_handle_sc+0x271>
				} else if (scancode == 0x38) { /* L/R ALT */
 7ba:	80 7d ec 38          	cmp    BYTE PTR [rbp-0x14],0x38
 7be:	75 5a                	jne    81a <kbd_handle_sc+0x271>
						if (kb_state & KBD_STATE_NEXT_RIGHT) {
 7c0:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 7c7 <kbd_handle_sc+0x21e>
 7c7:	0f b7 c0             	movzx  eax,ax
 7ca:	25 00 10 00 00       	and    eax,0x1000
 7cf:	85 c0                	test   eax,eax
 7d1:	74 13                	je     7e6 <kbd_handle_sc+0x23d>
								kb_state &= ~KBD_STATE_RALT;
 7d3:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 7da <kbd_handle_sc+0x231>
 7da:	80 e4 fb             	and    ah,0xfb
 7dd:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 7e4 <kbd_handle_sc+0x23b>
 7e4:	eb 10                	jmp    7f6 <kbd_handle_sc+0x24d>
								kb_state &= ~KBD_STATE_LALT;
 7e6:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 7ed <kbd_handle_sc+0x244>
 7ed:	24 7f                	and    al,0x7f
 7ef:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 7f6 <kbd_handle_sc+0x24d>
						if (!(kb_state & (KBD_STATE_LALT | KBD_STATE_RALT)))
 7f6:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 7fd <kbd_handle_sc+0x254>
 7fd:	0f b7 c0             	movzx  eax,ax
 800:	25 80 04 00 00       	and    eax,0x480
 805:	85 c0                	test   eax,eax
 807:	75 11                	jne    81a <kbd_handle_sc+0x271>
								kb_state &= ~KBD_STATE_ALT;
 809:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 810 <kbd_handle_sc+0x267>
 810:	83 e0 ef             	and    eax,0xffffffef
 813:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 81a <kbd_handle_sc+0x271>
				rprintf(&kb_reg, "r%02x %016b\n", scancode, kb_state);
 81a:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 821 <kbd_handle_sc+0x278>
 821:	0f b7 d0             	movzx  edx,ax
 824:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
 828:	89 d1                	mov    ecx,edx
 82a:	89 c2                	mov    edx,eax
 82c:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
 833:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 83a:	b8 00 00 00 00       	mov    eax,0x0
 83f:	e8 00 00 00 00       	call   844 <kbd_handle_sc+0x29b>
				if (scancode != 0x60 && (kb_state & KBD_STATE_NEXT_RIGHT)) {
 844:	80 7d ec 60          	cmp    BYTE PTR [rbp-0x14],0x60
 848:	0f 84 ed 02 00 00    	je     b3b <kbd_handle_sc+0x592>
 84e:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 855 <kbd_handle_sc+0x2ac>
 855:	0f b7 c0             	movzx  eax,ax
 858:	25 00 10 00 00       	and    eax,0x1000
 85d:	85 c0                	test   eax,eax
 85f:	0f 84 d6 02 00 00    	je     b3b <kbd_handle_sc+0x592>
						kb_state &= ~KBD_STATE_NEXT_RIGHT;
 865:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 86c <kbd_handle_sc+0x2c3>
 86c:	80 e4 ef             	and    ah,0xef
 86f:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 876 <kbd_handle_sc+0x2cd>
				if (kb_state & KBD_STATE_NEXT_RIGHT) {
						kb_state &= ~KBD_STATE_NEXT_RIGHT;
				}
				/*printf("key with scancode %x pressed\n", scancode);*/
		}
}
 876:	e9 c0 02 00 00       	jmp    b3b <kbd_handle_sc+0x592>
				if (scancode == 0x2a) { /* LSHIFT */
 87b:	80 7d ec 2a          	cmp    BYTE PTR [rbp-0x14],0x2a
 87f:	75 3c                	jne    8bd <kbd_handle_sc+0x314>
						kb_state |= KBD_STATE_LSHIFT;
 881:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 888 <kbd_handle_sc+0x2df>
 888:	80 cc 01             	or     ah,0x1
 88b:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 892 <kbd_handle_sc+0x2e9>
						if (!(kb_state & KBD_STATE_SHIFT)) {
 892:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 899 <kbd_handle_sc+0x2f0>
 899:	0f b7 c0             	movzx  eax,ax
 89c:	83 e0 20             	and    eax,0x20
 89f:	85 c0                	test   eax,eax
 8a1:	0f 85 46 02 00 00    	jne    aed <kbd_handle_sc+0x544>
								kb_state |= KBD_STATE_SHIFT;
 8a7:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 8ae <kbd_handle_sc+0x305>
 8ae:	83 c8 20             	or     eax,0x20
 8b1:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 8b8 <kbd_handle_sc+0x30f>
 8b8:	e9 30 02 00 00       	jmp    aed <kbd_handle_sc+0x544>
				} else if (scancode == 0x36) { /* RSHIFT */
 8bd:	80 7d ec 36          	cmp    BYTE PTR [rbp-0x14],0x36
 8c1:	75 3c                	jne    8ff <kbd_handle_sc+0x356>
						kb_state |= KBD_STATE_RSHIFT;
 8c3:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 8ca <kbd_handle_sc+0x321>
 8ca:	80 cc 08             	or     ah,0x8
 8cd:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 8d4 <kbd_handle_sc+0x32b>
						if (!(kb_state & KBD_STATE_SHIFT)) {
 8d4:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 8db <kbd_handle_sc+0x332>
 8db:	0f b7 c0             	movzx  eax,ax
 8de:	83 e0 20             	and    eax,0x20
 8e1:	85 c0                	test   eax,eax
 8e3:	0f 85 04 02 00 00    	jne    aed <kbd_handle_sc+0x544>
								kb_state |= KBD_STATE_SHIFT;
 8e9:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 8f0 <kbd_handle_sc+0x347>
 8f0:	83 c8 20             	or     eax,0x20
 8f3:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 8fa <kbd_handle_sc+0x351>
 8fa:	e9 ee 01 00 00       	jmp    aed <kbd_handle_sc+0x544>
				} else if (scancode == 0x3a) { /* CAPS_LOCK */
 8ff:	80 7d ec 3a          	cmp    BYTE PTR [rbp-0x14],0x3a
 903:	75 47                	jne    94c <kbd_handle_sc+0x3a3>
						if (!(kb_state & KBD_STATE_CAPS_LOCK)) {
 905:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 90c <kbd_handle_sc+0x363>
 90c:	0f b7 c0             	movzx  eax,ax
 90f:	83 e0 04             	and    eax,0x4
 912:	85 c0                	test   eax,eax
 914:	0f 85 d3 01 00 00    	jne    aed <kbd_handle_sc+0x544>
							kb_state |= KBD_STATE_CAPS_LOCK;
 91a:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 921 <kbd_handle_sc+0x378>
 921:	83 c8 04             	or     eax,0x4
 924:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 92b <kbd_handle_sc+0x382>
							kb_state ^= KBD_LIGHT_CAPS_LOCK;
 92b:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 932 <kbd_handle_sc+0x389>
 932:	66 35 00 80          	xor    ax,0x8000
 936:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 93d <kbd_handle_sc+0x394>
							kbd_lights_update();
 93d:	b8 00 00 00 00       	mov    eax,0x0
 942:	e8 00 00 00 00       	call   947 <kbd_handle_sc+0x39e>
 947:	e9 a1 01 00 00       	jmp    aed <kbd_handle_sc+0x544>
				} else if (scancode == 0x1d) { /* L/R CONTROL */
 94c:	80 7d ec 1d          	cmp    BYTE PTR [rbp-0x14],0x1d
 950:	75 4d                	jne    99f <kbd_handle_sc+0x3f6>
						if (kb_state & KBD_STATE_NEXT_RIGHT) {
 952:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 959 <kbd_handle_sc+0x3b0>
 959:	0f b7 c0             	movzx  eax,ax
 95c:	25 00 10 00 00       	and    eax,0x1000
 961:	85 c0                	test   eax,eax
 963:	74 13                	je     978 <kbd_handle_sc+0x3cf>
								kb_state |= KBD_STATE_RCONTROL;
 965:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 96c <kbd_handle_sc+0x3c3>
 96c:	80 cc 02             	or     ah,0x2
 96f:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 976 <kbd_handle_sc+0x3cd>
 976:	eb 11                	jmp    989 <kbd_handle_sc+0x3e0>
								kb_state |= KBD_STATE_LCONTROL;
 978:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 97f <kbd_handle_sc+0x3d6>
 97f:	83 c8 40             	or     eax,0x40
 982:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 989 <kbd_handle_sc+0x3e0>
						kb_state |= KBD_STATE_CONTROL;
 989:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 990 <kbd_handle_sc+0x3e7>
 990:	83 c8 08             	or     eax,0x8
 993:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 99a <kbd_handle_sc+0x3f1>
 99a:	e9 4e 01 00 00       	jmp    aed <kbd_handle_sc+0x544>
				} else if (scancode == 0x38) { /* L/R ALT */
 99f:	80 7d ec 38          	cmp    BYTE PTR [rbp-0x14],0x38
 9a3:	75 4c                	jne    9f1 <kbd_handle_sc+0x448>
						if (kb_state & KBD_STATE_NEXT_RIGHT) {
 9a5:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 9ac <kbd_handle_sc+0x403>
 9ac:	0f b7 c0             	movzx  eax,ax
 9af:	25 00 10 00 00       	and    eax,0x1000
 9b4:	85 c0                	test   eax,eax
 9b6:	74 13                	je     9cb <kbd_handle_sc+0x422>
								kb_state |= KBD_STATE_RALT;
 9b8:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 9bf <kbd_handle_sc+0x416>
 9bf:	80 cc 04             	or     ah,0x4
 9c2:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 9c9 <kbd_handle_sc+0x420>
 9c9:	eb 10                	jmp    9db <kbd_handle_sc+0x432>
								kb_state |= KBD_STATE_LALT;
 9cb:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 9d2 <kbd_handle_sc+0x429>
 9d2:	0c 80                	or     al,0x80
 9d4:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 9db <kbd_handle_sc+0x432>
						kb_state |= KBD_STATE_ALT;
 9db:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 9e2 <kbd_handle_sc+0x439>
 9e2:	83 c8 10             	or     eax,0x10
 9e5:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # 9ec <kbd_handle_sc+0x443>
 9ec:	e9 fc 00 00 00       	jmp    aed <kbd_handle_sc+0x544>
				} else if (scancode == 0x46) { /* SCROLL_LOCK */
 9f1:	80 7d ec 46          	cmp    BYTE PTR [rbp-0x14],0x46
 9f5:	75 46                	jne    a3d <kbd_handle_sc+0x494>
						if (!(kb_state & KBD_STATE_SCROLL_LOCK)) {
 9f7:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # 9fe <kbd_handle_sc+0x455>
 9fe:	0f b7 c0             	movzx  eax,ax
 a01:	83 e0 01             	and    eax,0x1
 a04:	85 c0                	test   eax,eax
 a06:	0f 85 e1 00 00 00    	jne    aed <kbd_handle_sc+0x544>
							kb_state |= KBD_STATE_SCROLL_LOCK;
 a0c:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # a13 <kbd_handle_sc+0x46a>
 a13:	83 c8 01             	or     eax,0x1
 a16:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # a1d <kbd_handle_sc+0x474>
							kb_state ^= KBD_LIGHT_SCROLL_LOCK;
 a1d:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # a24 <kbd_handle_sc+0x47b>
 a24:	80 f4 20             	xor    ah,0x20
 a27:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # a2e <kbd_handle_sc+0x485>
							kbd_lights_update();
 a2e:	b8 00 00 00 00       	mov    eax,0x0
 a33:	e8 00 00 00 00       	call   a38 <kbd_handle_sc+0x48f>
 a38:	e9 b0 00 00 00       	jmp    aed <kbd_handle_sc+0x544>
				} else if (scancode == 0x45) { /* NUM_LOCK and brk */
 a3d:	80 7d ec 45          	cmp    BYTE PTR [rbp-0x14],0x45
 a41:	75 67                	jne    aaa <kbd_handle_sc+0x501>
						if (kb_state & KBD_STATE_CONTROL) {
 a43:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # a4a <kbd_handle_sc+0x4a1>
 a4a:	0f b7 c0             	movzx  eax,ax
 a4d:	83 e0 08             	and    eax,0x8
 a50:	85 c0                	test   eax,eax
 a52:	74 17                	je     a6b <kbd_handle_sc+0x4c2>
								cur_brk = !cur_brk;
 a54:	0f b6 05 00 00 00 00 	movzx  eax,BYTE PTR [rip+0x0]        # a5b <kbd_handle_sc+0x4b2>
 a5b:	84 c0                	test   al,al
 a5d:	0f 94 c0             	sete   al
 a60:	88 05 00 00 00 00    	mov    BYTE PTR [rip+0x0],al        # a66 <kbd_handle_sc+0x4bd>
 a66:	e9 82 00 00 00       	jmp    aed <kbd_handle_sc+0x544>
						} else if (!(kb_state & KBD_STATE_NUM_LOCK)) {
 a6b:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # a72 <kbd_handle_sc+0x4c9>
 a72:	0f b7 c0             	movzx  eax,ax
 a75:	83 e0 02             	and    eax,0x2
 a78:	85 c0                	test   eax,eax
 a7a:	75 71                	jne    aed <kbd_handle_sc+0x544>
							kb_state |= KBD_STATE_NUM_LOCK;
 a7c:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # a83 <kbd_handle_sc+0x4da>
 a83:	83 c8 02             	or     eax,0x2
 a86:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # a8d <kbd_handle_sc+0x4e4>
							kb_state ^= KBD_LIGHT_NUM_LOCK;
 a8d:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # a94 <kbd_handle_sc+0x4eb>
 a94:	80 f4 40             	xor    ah,0x40
 a97:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # a9e <kbd_handle_sc+0x4f5>
							kbd_lights_update();
 a9e:	b8 00 00 00 00       	mov    eax,0x0
 aa3:	e8 00 00 00 00       	call   aa8 <kbd_handle_sc+0x4ff>
 aa8:	eb 43                	jmp    aed <kbd_handle_sc+0x544>
				} else if (scancode == 0x53) { /* delete */
 aaa:	80 7d ec 53          	cmp    BYTE PTR [rbp-0x14],0x53
 aae:	75 3d                	jne    aed <kbd_handle_sc+0x544>
						if ((kb_state & KBD_STATE_CONTROL) && (kb_state & KBD_STATE_ALT)) {
 ab0:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # ab7 <kbd_handle_sc+0x50e>
 ab7:	0f b7 c0             	movzx  eax,ax
 aba:	83 e0 08             	and    eax,0x8
 abd:	85 c0                	test   eax,eax
 abf:	74 2c                	je     aed <kbd_handle_sc+0x544>
 ac1:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # ac8 <kbd_handle_sc+0x51f>
 ac8:	0f b7 c0             	movzx  eax,ax
 acb:	83 e0 10             	and    eax,0x10
 ace:	85 c0                	test   eax,eax
 ad0:	74 1b                	je     aed <kbd_handle_sc+0x544>
								printf("rebooting\n");
 ad2:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 ad9:	b8 00 00 00 00       	mov    eax,0x0
 ade:	e8 00 00 00 00       	call   ae3 <kbd_handle_sc+0x53a>
								pc_reset();
 ae3:	b8 00 00 00 00       	mov    eax,0x0
 ae8:	e8 00 00 00 00       	call   aed <kbd_handle_sc+0x544>
				rprintf(&kb_reg, "p%02x %016b\n", scancode, kb_state);
 aed:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # af4 <kbd_handle_sc+0x54b>
 af4:	0f b7 d0             	movzx  edx,ax
 af7:	0f b6 45 ec          	movzx  eax,BYTE PTR [rbp-0x14]
 afb:	89 d1                	mov    ecx,edx
 afd:	89 c2                	mov    edx,eax
 aff:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
 b06:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 b0d:	b8 00 00 00 00       	mov    eax,0x0
 b12:	e8 00 00 00 00       	call   b17 <kbd_handle_sc+0x56e>
				if (kb_state & KBD_STATE_NEXT_RIGHT) {
 b17:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # b1e <kbd_handle_sc+0x575>
 b1e:	0f b7 c0             	movzx  eax,ax
 b21:	25 00 10 00 00       	and    eax,0x1000
 b26:	85 c0                	test   eax,eax
 b28:	74 11                	je     b3b <kbd_handle_sc+0x592>
						kb_state &= ~KBD_STATE_NEXT_RIGHT;
 b2a:	0f b7 05 00 00 00 00 	movzx  eax,WORD PTR [rip+0x0]        # b31 <kbd_handle_sc+0x588>
 b31:	80 e4 ef             	and    ah,0xef
 b34:	66 89 05 00 00 00 00 	mov    WORD PTR [rip+0x0],ax        # b3b <kbd_handle_sc+0x592>
}
 b3b:	90                   	nop
 b3c:	c9                   	leave
 b3d:	c3                   	ret

0000000000000b3e <kbd_event_translate>:
};

/* TODO: keymaps(5)-like support 
 *       notify event consumers */
int kbd_event_translate(const struct key_event* ke)
{
 b3e:	55                   	push   rbp
 b3f:	48 89 e5             	mov    rbp,rsp
 b42:	48 83 ec 18          	sub    rsp,0x18
 b46:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
		/* miserable kludge <-> 128x256 keymaps in code */
		if (ke->prs) {
 b4a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 b4e:	0f b6 00             	movzx  eax,BYTE PTR [rax]
 b51:	84 c0                	test   al,al
 b53:	0f 84 75 01 00 00    	je     cce <kbd_event_translate+0x190>
				uint16_t kbs = ke->state & (KBD_STATE_SHIFT | KBD_LIGHT_CAPS_LOCK);
 b59:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 b5d:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
 b61:	66 25 20 80          	and    ax,0x8020
 b65:	66 89 45 fc          	mov    WORD PTR [rbp-0x4],ax
				char rv;
				if (!(ke->state & KBD_STATE_NEXT_RIGHT) && (ke->state & KBD_LIGHT_NUM_LOCK)
 b69:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 b6d:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
 b71:	0f b7 c0             	movzx  eax,ax
 b74:	25 00 10 00 00       	and    eax,0x1000
 b79:	85 c0                	test   eax,eax
 b7b:	0f 85 db 00 00 00    	jne    c5c <kbd_event_translate+0x11e>
 b81:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 b85:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
 b89:	0f b7 c0             	movzx  eax,ax
 b8c:	25 00 40 00 00       	and    eax,0x4000
 b91:	85 c0                	test   eax,eax
 b93:	0f 84 c3 00 00 00    	je     c5c <kbd_event_translate+0x11e>
					&& ((ke->sc >= 0x47 && ke->sc <= 0x49)
 b99:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 b9d:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
 ba1:	3c 46                	cmp    al,0x46
 ba3:	76 0c                	jbe    bb1 <kbd_event_translate+0x73>
 ba5:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 ba9:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
 bad:	3c 49                	cmp    al,0x49
 baf:	76 34                	jbe    be5 <kbd_event_translate+0xa7>
					|| (ke->sc >= 0x4b && ke->sc <= 0x4d)
 bb1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 bb5:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
 bb9:	3c 4a                	cmp    al,0x4a
 bbb:	76 0c                	jbe    bc9 <kbd_event_translate+0x8b>
 bbd:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 bc1:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
 bc5:	3c 4d                	cmp    al,0x4d
 bc7:	76 1c                	jbe    be5 <kbd_event_translate+0xa7>
					|| (ke->sc >= 0x4f && ke->sc <= 0x53))) {
 bc9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 bcd:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
 bd1:	3c 4e                	cmp    al,0x4e
 bd3:	0f 86 83 00 00 00    	jbe    c5c <kbd_event_translate+0x11e>
 bd9:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 bdd:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
 be1:	3c 53                	cmp    al,0x53
 be3:	77 77                	ja     c5c <kbd_event_translate+0x11e>
						/* produce numbers and . */
						if (ke->sc <= 0x49)
 be5:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 be9:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
 bed:	3c 49                	cmp    al,0x49
 bef:	77 13                	ja     c04 <kbd_event_translate+0xc6>
								return '7' + (ke->sc - 0x47);
 bf1:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 bf5:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
 bf9:	0f b6 c0             	movzx  eax,al
 bfc:	83 e8 10             	sub    eax,0x10
 bff:	e9 cf 00 00 00       	jmp    cd3 <kbd_event_translate+0x195>
						else if (ke->sc <= 0x4d)
 c04:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 c08:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
 c0c:	3c 4d                	cmp    al,0x4d
 c0e:	77 13                	ja     c23 <kbd_event_translate+0xe5>
								return '4' + (ke->sc - 0x4b);
 c10:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 c14:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
 c18:	0f b6 c0             	movzx  eax,al
 c1b:	83 e8 17             	sub    eax,0x17
 c1e:	e9 b0 00 00 00       	jmp    cd3 <kbd_event_translate+0x195>
						else if (ke->sc <= 0x51)
 c23:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 c27:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
 c2b:	3c 51                	cmp    al,0x51
 c2d:	77 13                	ja     c42 <kbd_event_translate+0x104>
								return '1' + (ke->sc - 0x4f);
 c2f:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 c33:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
 c37:	0f b6 c0             	movzx  eax,al
 c3a:	83 e8 1e             	sub    eax,0x1e
 c3d:	e9 91 00 00 00       	jmp    cd3 <kbd_event_translate+0x195>
						else if (ke->sc == 0x52)
 c42:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 c46:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
 c4a:	3c 52                	cmp    al,0x52
 c4c:	75 07                	jne    c55 <kbd_event_translate+0x117>
								return '0';
 c4e:	b8 30 00 00 00       	mov    eax,0x30
 c53:	eb 7e                	jmp    cd3 <kbd_event_translate+0x195>
						else
								return '.';
 c55:	b8 2e 00 00 00       	mov    eax,0x2e
 c5a:	eb 77                	jmp    cd3 <kbd_event_translate+0x195>
				}
				/* get the characters */
				if (kbs != 0 && kbs != (KBD_STATE_SHIFT & KBD_LIGHT_CAPS_LOCK)) /* caps */
 c5c:	66 83 7d fc 00       	cmp    WORD PTR [rbp-0x4],0x0
 c61:	74 26                	je     c89 <kbd_event_translate+0x14b>
 c63:	66 83 7d fc 00       	cmp    WORD PTR [rbp-0x4],0x0
 c68:	74 1f                	je     c89 <kbd_event_translate+0x14b>
						rv = kb_scancodes[(ke->sc & 0x7f) + 128];
 c6a:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 c6e:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
 c72:	0f b6 c0             	movzx  eax,al
 c75:	83 e0 7f             	and    eax,0x7f
 c78:	83 e8 80             	sub    eax,0xffffff80
 c7b:	48 98                	cdqe
 c7d:	0f b6 80 00 00 00 00 	movzx  eax,BYTE PTR [rax+0x0]
 c84:	88 45 ff             	mov    BYTE PTR [rbp-0x1],al
 c87:	eb 1a                	jmp    ca3 <kbd_event_translate+0x165>
				else /* small */
						rv = kb_scancodes[ke->sc & 0x7f];
 c89:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 c8d:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
 c91:	0f b6 c0             	movzx  eax,al
 c94:	83 e0 7f             	and    eax,0x7f
 c97:	48 98                	cdqe
 c99:	0f b6 80 00 00 00 00 	movzx  eax,BYTE PTR [rax+0x0]
 ca0:	88 45 ff             	mov    BYTE PTR [rbp-0x1],al
				/* treat ctrl+z as EOF */
				if (ke->state & KBD_STATE_CONTROL && (rv == 'z' || rv == 'd'))
 ca3:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
 ca7:	0f b7 40 02          	movzx  eax,WORD PTR [rax+0x2]
 cab:	0f b7 c0             	movzx  eax,ax
 cae:	83 e0 08             	and    eax,0x8
 cb1:	85 c0                	test   eax,eax
 cb3:	74 13                	je     cc8 <kbd_event_translate+0x18a>
 cb5:	80 7d ff 7a          	cmp    BYTE PTR [rbp-0x1],0x7a
 cb9:	74 06                	je     cc1 <kbd_event_translate+0x183>
 cbb:	80 7d ff 64          	cmp    BYTE PTR [rbp-0x1],0x64
 cbf:	75 07                	jne    cc8 <kbd_event_translate+0x18a>
						return EOF;
 cc1:	b8 ff ff ff ff       	mov    eax,0xffffffff
 cc6:	eb 0b                	jmp    cd3 <kbd_event_translate+0x195>
				/* TODO: ctrl+c etc. signal handlers */
				return rv;
 cc8:	0f be 45 ff          	movsx  eax,BYTE PTR [rbp-0x1]
 ccc:	eb 05                	jmp    cd3 <kbd_event_translate+0x195>
		}
		return 0;
 cce:	b8 00 00 00 00       	mov    eax,0x0
}
 cd3:	c9                   	leave
 cd4:	c3                   	ret
