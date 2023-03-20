/* kbd.c : Contains the keyboard handling code for basic text input
 *         including keyboard state and a keyboard buffer
 * */

#include "limits.h"
#include "kernel.h"
#include "kdata.h"

uint16_t kb_state = 0;
void* rb_events = 0;
void* rb_commands = 0;
struct kio_region kb_reg = { 60, 9, 20, 13, 0, 0, 0x1f, KIO_REGION_NO_DELAY | KIO_REGION_DEFERED_SCROLL, 0, 0, SPIN_LOCK_UNLOCKED };
struct kio_region kb_regH = { 60, 5, 20, 4, 0, 0, 0x1f, KIO_REGION_NO_DELAY | KIO_REGION_NO_SCROLL, 0, 0, SPIN_LOCK_UNLOCKED };
struct kio_region kb_regN = { 70, 22, 10, 1, 0, 0, 0x0f, KIO_REGION_NO_DELAY | KIO_REGION_NO_SCROLL, 0, 0, SPIN_LOCK_UNLOCKED };
struct wait_queue_head wq_kbd = WAIT_QUEUE_HEAD(wq_kbd);

void kbd_fb_resize(int lx, int ly)
{
		kb_reg.x = lx - 20;
		kb_reg.ly = ly - 12;
		kb_regH.x = lx - 20;
		kb_regN.x = lx - 10;
		kb_regN.y = ly - 2;
}

void kbd_init()
{
		uint8_t cmd;
		/* TODO: possibly reset the keyboard */
		/* initialize the buffer */
		rb_events = ringbuffer_allocate(KBD_INIT_BUFSIZE);
		rb_commands = ringbuffer_allocate(KBD_INIT_BUFSIZE);
		void region_clear(struct kio_region*);
		region_clear(&kb_reg);
		rprintf(&kb_regH, "    LGTNRRRLLLSSSSSS"
			   "    ---XSACSACSAC---"
			   "    CNSTHLTHLTHLTCNS"
			   "    LLLRTTLTTLTTLLLL");
		cmd = KBC_RESET;
		ringbuffer_enqueue(rb_commands, &cmd, sizeof(cmd));
}

void kbd_wait()
{
		while (!(inb(KBD_CH4) & 1));
}

void kbd_process_queue()
{
		size_t s;
		/* processes the command queue and modifies the
		 * ringbuffer -> no interrupts */
		/*while ((inb(KBD_CH4) & 3));*/
		preempt_disable();

		while ((s = ringbuffer_available(rb_commands))) {
				uint8_t cmd, a1, a2, nr = 0;
				ringbuffer_dequeue(rb_commands, &cmd, sizeof(cmd));
				rprintf(&kb_reg, "handling command %x\n", cmd);
				switch (cmd) {
						case KBC_RESET:
								outb(KBD_CH0, 0xff);
								a1 = inb(KBD_CH0);
								nr = 1;
								if (a1 == 0xfa) {
										kbd_wait();
										a2 = inb(KBD_CH0);
										nr = 2;
								}
								break;
						case KBC_ENABLE:
								outb(KBD_CH0, 0xf4);
								kbd_wait();
								a1 = inb(KBD_CH0);
								nr = 1;
								break;
						case KBC_DISABLE: /* wait for confirmation */
								outb(KBD_CH0, 0xf5);
								kbd_wait();
								a2 = inb(KBD_CH4);
								while ((a1 = inb(KBD_CH0))) {
										if (a1 == 0xfa || a1 == 0x00 || a1 == 0xfe)
												break;
										if (a2 & (1 << 5)) /* read sth useful */
												kbd_handle_sc(a1); /* watch out for ff and fe too */
										else
												break;
								}
								nr = 1;
								break;
						case KBC_SET_LIGHTS:
								outb(KBD_CH0, 0xed);
								kbd_wait();
								a1 = inb(KBD_CH0);
								nr = 1;
								ringbuffer_dequeue(rb_commands, &cmd, sizeof(cmd));
								if (a1 == 0xfa) {
										outb(KBD_CH0, cmd);
										kbd_wait();
										a2 = inb(KBD_CH0);
										nr = 2;
								}
								break;
						default: /* possible corruption of data */
								break;
				}
				if (nr == 1)
						rprintf(&kb_reg, "response %x\n", a1);
				else if (nr == 2)
						rprintf(&kb_reg, "responses %x %x\n", a1, a2);
		}

		preempt_enable();
}

int kbd_event_present()
{
		return ringbuffer_available(rb_events) / sizeof(struct key_event);
}

struct key_event kbd_get_event()
{
		struct key_event rv;
		ringbuffer_dequeue(rb_events, &rv, sizeof(rv));
		return rv;
}

void kbd_lights_update()
{
#if 1
		uint8_t cmd;

		/* disable kbd */
		cmd = KBC_DISABLE;
		ringbuffer_enqueue(rb_commands, &cmd, sizeof(cmd));

		/* write light update */
		cmd = KBC_SET_LIGHTS;
		ringbuffer_enqueue(rb_commands, &cmd, sizeof(cmd));
		cmd = (kb_state & KBD_LIGHT_MASK) >> 13;
		ringbuffer_enqueue(rb_commands, &cmd, sizeof(cmd));

		/* reenable kbd */
		cmd = KBC_ENABLE;
		ringbuffer_enqueue(rb_commands, &cmd, sizeof(cmd));

#else
		uint8_t a1 = 0, a2, a3 = 0;

		/* wait for free (read control port) */
		while ((inb(KBD_CH4) & 2));

		/* disable kbd & read ack */
		outb(KBD_CH4, 0xad);
		a3 = inb(KBD_CH0);
		
		/* write to data port */
		outb(KBD_CH0, 0xed);

		/* check ACK */
		if ((a2 = inb(KBD_CH0)) == 0xfa) {
			/*write light status (caps num scr) */
			outb(KBD_CH0, (kb_state & KBD_LIGHT_MASK) >> 13);
			/* get ACK */
			a1 = inb(KBD_CH0);
		}

		/* reenable kbd */
		while ((inb(KBD_CH4) & 2));
		outb(KBD_CH4, 0xae);
		a3 = inb(KBD_CH0);
#endif

		/* DBG: write status above clock counter */
		kb_regN.cur_x = kb_regN.cur_y = 0;
		region_putchar(&kb_regN, (kb_state & KBD_LIGHT_NUM_LOCK) ? '#' : ' ');
		region_putchar(&kb_regN, (kb_state & KBD_LIGHT_CAPS_LOCK) ? '#' : ' ');
		region_putchar(&kb_regN, (kb_state & KBD_LIGHT_SCROLL_LOCK) ? '#' : ' ');
		/*putc(((a2 == 0xfa) && (a1 == 0xfa)) ? '+' : (((a2 == 0xfa) && (a1 == 0xfe)) ? '-' : '?'));*/
		/*push_region(&kb_reg);
		printf("st=%x ed=%x re=%x %d\n", a1, a2, a3, (kb_state & KBD_LIGHT_MASK) >> 13);
		pop_region();*/
		/*push_cursor(kio_num_cols() - 10, kio_num_lines() - 4, 0x07);
		static int seq = 0; stride push pop window wndprintf(fdesc)
		printf("%x %u", kb_state, seq++);
		pop_cursor();*/
}

void kbd_handler()
{
		unsigned char sc;
		if (!rb_events || !rb_commands) /* don't corrupt memory */
				return;
		do {
				sc = inb(KBD_CH0);
				if (sc != 0xfa && sc != 0xfe && sc != 0x00 && sc != 0xff)
						kbd_handle_sc(sc);
		} while ((inb(KBD_CH4) & 1));
		if (kbd_event_present())
				wake_up_external_event(&wq_kbd);
}

void kbd_handle_sc(unsigned char scancode)
{
		unsigned char scs;
		struct key_event ke;
		ke.prs = !(scancode & 0x80);
		ke.state = kb_state;
		ke.sc = scancode & 0x7f;
		ringbuffer_enqueue(rb_events, &ke, sizeof(ke));

		if (scancode & 0x80) {
				/* key release */
				scs = scancode;
				scancode ^= 0x80;
				if (scancode == 0x3a) { /* CAPS_LOCK */
						if (kb_state & KBD_STATE_CAPS_LOCK) {
								kb_state &= ~KBD_STATE_CAPS_LOCK;
						}
						/*printf("r");*/
				} else if (scancode == 0x46) { /* SCROLL LOCK */
						if (kb_state & KBD_STATE_SCROLL_LOCK) {
								kb_state &= ~KBD_STATE_SCROLL_LOCK;
						}
				} else if (scancode == 0x45) { /* NUM LOCK */
						if (kb_state & KBD_STATE_NUM_LOCK) {
								kb_state &= ~KBD_STATE_NUM_LOCK;
						}
				} else if (scancode == 0x60) { /* RIGHT signalling */
						if (!(kb_state & KBD_STATE_NEXT_RIGHT)) {
								kb_state |= KBD_STATE_NEXT_RIGHT;
						}
				} else if (scancode == 0x2a) { /* LSHIFT */
						kb_state &= ~KBD_STATE_LSHIFT;
						if (!(kb_state & KBD_STATE_RSHIFT))
								kb_state &= ~KBD_STATE_SHIFT;
						/*if (kb_state & KBD_STATE_NEXT_RIGHT)*/ /* fake lshift */
						/*		kb_state &= ~KBD_STATE_NEXT_RIGHT;*/
				} else if (scancode == 0x36) { /* RSHIFT */
						kb_state &= ~KBD_STATE_RSHIFT;
						if (!(kb_state & KBD_STATE_LSHIFT))
								kb_state &= ~KBD_STATE_SHIFT;
				} else if (scancode == 0x1d) { /* L/R CONTROL */
						if (kb_state & KBD_STATE_NEXT_RIGHT) {
								kb_state &= ~KBD_STATE_RCONTROL;
								/*kb_state ^= KBD_STATE_NEXT_RIGHT;*/
						} else
								kb_state &= ~KBD_STATE_LCONTROL;
						if (!(kb_state & (KBD_STATE_LCONTROL | KBD_STATE_RCONTROL)))
								kb_state &= ~KBD_STATE_CONTROL;
				} else if (scancode == 0x38) { /* L/R ALT */
						if (kb_state & KBD_STATE_NEXT_RIGHT) {
								kb_state &= ~KBD_STATE_RALT;
						/*		kb_state ^= KBD_STATE_NEXT_RIGHT;*/
						} else
								kb_state &= ~KBD_STATE_LALT;
						if (!(kb_state & (KBD_STATE_LALT | KBD_STATE_RALT)))
								kb_state &= ~KBD_STATE_ALT;
				} else if(scancode == 0x53) { /* delete */
						/*if (kb_state & KBD_STATE_NEXT_RIGHT) {
								kb_state &= ~KBD_STATE_NEXT_RIGHT;
						}*/
				}
				rprintf(&kb_reg, "r%02x %016b\n", scancode, kb_state);
				if (scancode != 0x60 && (kb_state & KBD_STATE_NEXT_RIGHT)) {
						kb_state &= ~KBD_STATE_NEXT_RIGHT;
				}
				/*printf("key with scancode %x released\n", scancode);*/
		} else {
				/* key press */
				if (scancode == 0x2a) { /* LSHIFT */
						kb_state |= KBD_STATE_LSHIFT;
						if (!(kb_state & KBD_STATE_SHIFT)) {
								kb_state |= KBD_STATE_SHIFT;
						}
						/*if (kb_state & KBD_STATE_NEXT_RIGHT) *//* fake lshift */
						/*		kb_state &= ~KBD_STATE_NEXT_RIGHT;*/
				} else if (scancode == 0x36) { /* RSHIFT */
						kb_state |= KBD_STATE_RSHIFT;
						if (!(kb_state & KBD_STATE_SHIFT)) {
								kb_state |= KBD_STATE_SHIFT;
						}
				} else if (scancode == 0x3a) { /* CAPS_LOCK */
						if (!(kb_state & KBD_STATE_CAPS_LOCK)) {
							kb_state |= KBD_STATE_CAPS_LOCK;
							kb_state ^= KBD_LIGHT_CAPS_LOCK;
							kbd_lights_update();
						}
						/*printf("p");*/
				} else if (scancode == 0x1d) { /* L/R CONTROL */
						if (kb_state & KBD_STATE_NEXT_RIGHT) {
								kb_state |= KBD_STATE_RCONTROL;
								/*kb_state ^= KBD_STATE_NEXT_RIGHT;*/
						} else
								kb_state |= KBD_STATE_LCONTROL;
						kb_state |= KBD_STATE_CONTROL;
				} else if (scancode == 0x38) { /* L/R ALT */
						if (kb_state & KBD_STATE_NEXT_RIGHT) {
								kb_state |= KBD_STATE_RALT;
								/*kb_state ^= KBD_STATE_NEXT_RIGHT;*/
						} else
								kb_state |= KBD_STATE_LALT;
						kb_state |= KBD_STATE_ALT;
				} else if (scancode == 0x46) { /* SCROLL_LOCK */
						if (!(kb_state & KBD_STATE_SCROLL_LOCK)) {
							kb_state |= KBD_STATE_SCROLL_LOCK;
							kb_state ^= KBD_LIGHT_SCROLL_LOCK;
							kbd_lights_update();
						}
				} else if (scancode == 0x45) { /* NUM_LOCK and brk */
						if (kb_state & KBD_STATE_CONTROL) {
								/* pause/break */
								extern char cur_brk;
								cur_brk = !cur_brk;
						} else if (!(kb_state & KBD_STATE_NUM_LOCK)) {
							kb_state |= KBD_STATE_NUM_LOCK;
							kb_state ^= KBD_LIGHT_NUM_LOCK;
							kbd_lights_update();
						}
				} else if (scancode == 0x53) { /* delete */
						if ((kb_state & KBD_STATE_CONTROL) && (kb_state & KBD_STATE_ALT)) {
								/* reboot */ // PRINT to default region
								printf("rebooting\n");
								pc_reset();
						}
				}
				rprintf(&kb_reg, "p%02x %016b\n", scancode, kb_state);
				if (kb_state & KBD_STATE_NEXT_RIGHT) {
						kb_state &= ~KBD_STATE_NEXT_RIGHT;
				}
				/*printf("key with scancode %x pressed\n", scancode);*/
		}
}

unsigned char kb_scancodes[256] =
{
		0, 27, '1', '2', '3', '4', '5', '6', '7', '8',/* 9 */
		'9', '0', '-', '=', '\b',/* Backspace */
		'\t',/* Tab */
		'q', 'w', 'e', 'r',/* 19 */
		't', 'y', 'u', 'i', 'o', 'p', '[', ']', '\n',/* Enter key */
		0, /* 29   - Control */
		'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', /* 39 */
		'\'', '`', 0, /* Left shift */
		'\\', 'z', 'x', 'c', 'v', 'b', 'n',/* 49 */
		'm', ',', '.', '/', 0, /* Right shift */
		'*',
		0, /* Alt */
		' ', /* Space bar */
		0, /* Caps lock 			*/
		0, /* 59 - F1 key ... > */
		0,   0,   0,   0,   0,   0,   0, 	  0,
		0, /* < ... F10 */
		0, /* 69 - Num lock*/
		0, /* Scroll 			Lock */
		0, /* Home key */
		0, /* Up Arrow */
		0, /* Page Up */
		'-',
		0, /* Left Arrow */
		0,
		0, /* Right Arrow */
		'+',
	    0,	/* 79 - End key*/
		0, /* Down Arrow */
		0, /* Page Down */
		0, /* Insert Key */
		0, /* Delete Key */
		0,   0,   0,
		0, /* F11 Key */
		0, /* F12 Key */
		0, /* All other keys are undefined */
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		/* top elements with shift*/
		0, 27, '!', '@', '#', '$', '%', '^', '&', '*',/* 9 */
		'(', ')', '_', '+', '\b',/* Backspace */
		'\t',/* Tab */
		'Q', 'W', 'E', 'R',/* 19 */
		'T', 'Y', 'U', 'I', 'O', 'P', '{', '}', '\n',/* Enter key */
		0, /* 29   - Control */
		'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', ':', /* 39 */
		'"', '~', 0, /* Left shift */
		'|', 'Z', 'X', 'C', 'V', 'B', 'N',/* 49 */
		'M', '<', '>', '?', 0, /* Right shift */
		'*',
		0, /* Alt */
		' ', /* Space bar */
		0, /* Caps lock 			*/
		0, /* 59 - F1 key ... > */
		0,   0,   0,   0,   0,   0,   0, 	  0,
		0, /* < ... F10 */
		0, /* 69 - Num lock*/
		0, /* Scroll 			Lock */
		0, /* Home key */
		0, /* Up Arrow */
		0, /* Page Up */
		'-',
		0, /* Left Arrow */
		0,
		0, /* Right Arrow */
		'+',
	    0,	/* 79 - End key*/
		0, /* Down Arrow */
		0, /* Page Down */
		0, /* Insert Key */
		0, /* Delete Key */
		0,   0,   0,
		0, /* F11 Key */
		0, /* F12 Key */
		0, /* All other keys are undefined */
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
};

/* TODO: keymaps(5)-like support 
 *       notify event consumers */
int kbd_event_translate(const struct key_event* ke)
{
		/* miserable kludge <-> 128x256 keymaps in code */
		if (ke->prs) {
				uint16_t kbs = ke->state & (KBD_STATE_SHIFT | KBD_LIGHT_CAPS_LOCK);
				char rv;
				if (!(ke->state & KBD_STATE_NEXT_RIGHT) && (ke->state & KBD_LIGHT_NUM_LOCK)
					&& ((ke->sc >= 0x47 && ke->sc <= 0x49)
					|| (ke->sc >= 0x4b && ke->sc <= 0x4d)
					|| (ke->sc >= 0x4f && ke->sc <= 0x53))) {
						/* produce numbers and . */
						if (ke->sc <= 0x49)
								return '7' + (ke->sc - 0x47);
						else if (ke->sc <= 0x4d)
								return '4' + (ke->sc - 0x4b);
						else if (ke->sc <= 0x51)
								return '1' + (ke->sc - 0x4f);
						else if (ke->sc == 0x52)
								return '0';
						else
								return '.';
				}
				/* get the characters */
				if (kbs != 0 && kbs != (KBD_STATE_SHIFT & KBD_LIGHT_CAPS_LOCK)) /* caps */
						rv = kb_scancodes[(ke->sc & 0x7f) + 128];
				else /* small */
						rv = kb_scancodes[ke->sc & 0x7f];
				/* treat ctrl+z as EOF */
				if (ke->state & KBD_STATE_CONTROL && (rv == 'z' || rv == 'd'))
						return EOF;
				/* TODO: ctrl+c etc. signal handlers */
				return rv;
		}
		return 0;
}

