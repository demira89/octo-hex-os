#include "limits.h"
#include "kernel.h"
#define KIO
#include "kdata.h"

/* blocking i.e. PrtScr  */
char cur_brk = 0;
/* the default buffer for undirected printf */
struct kio_region reg_def = { 0, 0, 60, 25, 0, 0, 0x07, KIO_REGION_INPUT_WRAP, 0, 0, SPIN_LOCK_UNLOCKED };
/* getch_region with focus regions & focusable & highlighting & tabbing */

void kio_fb_resize()
{
		reg_def.lx = fb_initial.width - 20;
		reg_def.ly = fb_initial.height;
		extern void kernel_fb_resize();
		extern void kbd_fb_resize(int lx, int ly);
		kernel_fb_resize();
		kbd_fb_resize(fb_initial.width, fb_initial.height);
}

char getc_pr(struct kio_region* cr, unsigned short x, unsigned short y)
{
		if (x < cr->lx && y < cr->ly) {
				x += cr->x;
				y += cr->y;
				return ((char*)fb_initial.text_mem)[2 * (y * fb_initial.width + x)];
		} else
				return 0;
}

void putc_pr(struct kio_region* cr, char c, unsigned short x, unsigned short y)
{
		/* buffer is num_colsXnum_rows
		 * x & y are region relative */
		if (x < cr->lx && y < cr->ly) { /* don't corrupt memory */
				struct kio_region r; char *p1, *p2;
				x += cr->x;
				y += cr->y;
				if (x >= fb_initial.width || y >= fb_initial.height)
						return;
				p1 = &((char*)fb_initial.text_mem)[2 * (y * fb_initial.width + x)];
				p2 = &((char*)fb_initial.text_mem)[2 * (y * fb_initial.width + x) + 1];
				if (*p1 != c || *p2 != cr->fmt) {
						*p1 = c;
						*p2 = cr->fmt;
						r.x = x;
						r.y = y;
						r.lx = 1;
						r.ly = 1;
						r.fmt = cr->fmt;
						framebuffer_update_region(&fb_initial, &r);
				}
		}
}

void putc_prc(struct kio_region* cr, char fmt, char c, unsigned short x, unsigned short y)
{
		char f = cr->fmt;
		cr->fmt = fmt;
		putc_pr(cr, c, x, y);
		cr->fmt = f;
}

void region_clear(struct kio_region* cr)
{
		framebuffer_clear_region(&fb_initial, cr);
}

void scroll_buffer(struct kio_region* cr)
{
		int i, k;
		framebuffer_scroll_region(&fb_initial, cr, 0, 1);
		/* busy spin to slow down scrolling (if enabled) */
		if (!(cr->flags & KIO_REGION_NO_DELAY)) {
			mdelay(50);
			/* and honor the break key */
			while (cur_brk)
					__asm__("hlt");
		}
}

void scroll_left(struct kio_region* cr)
{
		struct kio_region r;
		r.y = cr->y + cr->cur_y;
		r.x = cr->x;
		r.ly = 1;
		r.lx = cr->lx;
		memcpy((char*)fb_initial.text_mem + r.y * fb_initial.width * 2 + r.x * 2,
						(char*)fb_initial.text_mem + r.y * fb_initial.width * 2 + r.x * 2 + 2,
						(cr->lx - 1) * 2);
		framebuffer_update_region(&fb_initial, &r);
		cr->cur_x--;
		putc_pr(cr, '\0', cr->cur_x, cr->cur_y);
}

//void vga_update_cursor(short x, short y)
//{/* TODO ------------------------ */
//		int ofs = y * 80 + x;
//		/* ofs -> 0xe-0xf in vga index */
//		if (video_mode.is_textmode) {
//				outb(VGA_CH_INDEX, 0x0f);
//				outb(VGA_CH_DATA, ofs & 0xff);
//				outb(VGA_CH_INDEX, 0x0e);
//				outb(VGA_CH_DATA, (ofs >> 8) & 0xff);
//		}
//}

void region_unputchar(struct kio_region* cr)
{
		if (cr->cur_x) {
				cr->cur_x--;
				putc_pr(cr, '\0', cr->cur_x, cr->cur_y);
		} else if (cr->cur_y) {
				cr->cur_y--;
				cr->cur_x = cr->lx;
				while (--cr->cur_x)
						if (getc_pr(cr, cr->cur_x, cr->cur_y) != '\0')
								break;
				putc_pr(cr, '\0', cr->cur_x, cr->cur_y);
		}
}

size_t region_getline(struct kio_region* cr, char** lineptr, size_t* n)
{
		char* str; size_t rem, ct = 0;
		if (!lineptr || !n || (cr->flags & KIO_REGION_INPUT_DISABLED)) {
				errno = EINVAL;
				return -1;
		}
		str = *lineptr;
		rem = *n;
		if (rem == 0) {
				str = kmalloc(80);
				rem = 80;
				*n = 80;
				*lineptr = str;
		}
		/* possibly set the VGA cursor */
		do {
				if (!(cr->flags & KIO_REGION_INPUT_NOCURSOR)) {
						framebuffer_set_cursor(&fb_initial, cr->x + cr->cur_x,
										cr->y + cr->cur_y);
				}
				int c = region_getchar(cr);
				if (c == EOF) {
						str[ct] = '\0';
						return ct;
				} else if (c == '\b') {
						if (ct) {
								str[--ct] = '\0';
								if (cr->cur_x || (cr->flags & KIO_REGION_INPUT_MULTILINE))
										region_unputchar(cr);
								else if (ct && !(cr->flags & KIO_REGION_INPUT_MULTILINE)) {
										size_t nc = min(ct, (size_t)cr->lx);
										region_puts(cr, str + (ct - nc));
										cr->cur_x = nc;
								}
						}
						continue;
				} else if (c == 27) { /* keep it currently */
				}
				str[ct++] = c;
				if (ct + 1 == rem) {
						/* realloc */
						rem *= 2;
						str = krealloc(str, rem);
						if (!str)
								return -1;
						*n = rem;
						*lineptr = str;
				}
				/* check for newline (if not multiline) */
				if ((c == 10 || c == 13) && !(cr->flags & KIO_REGION_INPUT_MULTILINE)) {
						region_putchar(cr, '\n');
						str[ct] = '\0';
						return ct;
				}
				/* else print the character */
				if (!(cr->flags & KIO_REGION_INPUT_MULTILINE) && cr->cur_x == cr->lx) {
						if (cr->flags & KIO_REGION_INPUT_WRAP) {
								scroll_left(cr);
								region_putchar(cr, c);
						} else /* full */
								str[--ct] = '\0';
				} else
						region_putchar(cr, c);
		} while (1);
}

size_t getline(char** lineptr, size_t* n) /*, FILE* stream);*/
{
		extern void kbd_handler();
		kbd_handler(); // poke the buffer
		return region_getline(&reg_def, lineptr, n);
}

int region_getchar(struct kio_region* cr)
{
		if (cr->flags & KIO_REGION_INPUT_DISABLED)
				return EOF;
		// TODO: cr->has_focus
Pos1:
		if (kbd_event_present()) {
				struct key_event ke = kbd_get_event();
				int rv = kbd_event_translate(&ke);
				if (rv != 0)
						return rv;
		} else if (cr->flags & KIO_REGION_INPUT_NONBLOCKING)
				return EOF;
		else {
				extern struct wait_queue wq_kbd;
				wait_on_event(&wq_kbd);
		}
		goto Pos1;
}

int region_putchar(struct kio_region* cr, char c)
{
		struct kio_region r;
		if (c == 10 || c == 13) {
				short i;
				/* Clear until EOL(R) and move cursor down */
				for (i = cr->cur_x; i < cr->lx; i++)
						putc_pr(cr, '\0', i, cr->cur_y);
				r.x = cr->x + cr->cur_x;
				r.y = cr->y + cr->cur_y;
				r.ly = 1;
				r.lx = cr->lx - cr->cur_x;
				cr->cur_x = 0;
				if (++cr->cur_y == cr->ly) {
						/* Advance screen */
						if (!(cr->flags & KIO_REGION_DEFERED_SCROLL)) {
								cr->cur_y--;
								if (!(cr->flags & KIO_REGION_NO_SCROLL)) {
										scroll_buffer(cr);
										i = -1;
								}
						}
				}
				if (i != -1)
						framebuffer_update_region(&fb_initial, &r);
		} else if (c == '\t') {
				if (cr->cur_x == cr->lx)
						region_putchar(cr, '\n');
				for (c = 0; cr->cur_x < cr->lx && c < 4; cr->cur_x++, c++)
						putc_pr(cr, ' ', cr->cur_x, cr->cur_y);
		} else if (cr->cur_x == cr->lx) {
				region_putchar(cr, '\n');
				cr->cur_x = 0;
				putc_pr(cr, c, cr->cur_x++, cr->cur_y);
		} else {
				while (cr->cur_y >= cr->ly) {
						scroll_buffer(cr);
						cr->cur_y--;
				}
				putc_pr(cr, c, cr->cur_x++, cr->cur_y);
		}
		return c;
}

int getchar()
{
		return region_getchar(&reg_def);
}

int putchar(char c)
{
		return region_putchar(&reg_def, c);
}

void region_puts(struct kio_region* cr, const char* str)
{
		while(*str)
				region_putchar(cr, *(str++));
}

void puts(const char* str)
{
		return region_puts(&reg_def, str);
}

#define HEXCHAR(v) (((v) < 0xa) ? ('0' + (v)) : ('a' + (v) - 0xa))
#define CHEXCHAR(v) (((v) < 0xa) ? ('0' + (v)) : ('A' + (v) - 0xa))
#define KFL_IS_HEX      1
#define KFL_ZERO_PREFIX 2
#define KFL_ALWAYS_SIGN 4
#define KFL_LEFT_ALIGN  8
#define KFL_TYPE_PREFIX 16
#define KFL_SPACE_PLUS  32
#define KFL_IS_OCT      64
#define KFL_CAPITAL     128
#define KFL_IS_NEG      (KFL_CAPITAL | KFL_IS_OCT) /* no oct capitals */

struct ivp_ctx {
		char* buf;
		size_t n;
		void (*putchar)(struct ivp_ctx*, char);
};


int putb(struct ivp_ctx* ctx, unsigned int arg, char flags, char width, char prec)
{
		int i, nonz = 0, rv = 0;
		for (i = 0; i < 32; i++) {
				unsigned int bt = (arg & 0x80000000);
				rv++;
				if (bt) {
						nonz = 1;
						ctx->putchar(ctx, '1');
				} else if (nonz)
						ctx->putchar(ctx, '0');
				else if ((32 - i) <= prec) /* has precedence over with */
						ctx->putchar(ctx, '0');
				else if ((32 - i) <= width)
						ctx->putchar(ctx, flags & KFL_ZERO_PREFIX ? '0' : ' ');
				else if (i == 31 && prec >= 0) /* only print 0 for nonneg prec */
						ctx->putchar(ctx, '0');
				else
						rv--;
				arg <<= 1;
		}
		return rv;
}

int putu64(struct ivp_ctx* ctx, unsigned long long int arg, char flags)
{
		int rv = 0, i, nonz = 0;
		if (flags & KFL_IS_HEX) {
				for (i = 0; i < 16; i++) {
						unsigned long long int hf = (arg & 0xf000000000000000);
						char hc = (flags & KFL_CAPITAL) ? CHEXCHAR(hf >> 60) : HEXCHAR(hf >> 60);
						rv++;
						if (hc != '0') {
								nonz = 1;
								if (ctx) ctx->putchar(ctx, hc);
						} else if (nonz || i == 15) {
								if (ctx) ctx->putchar(ctx, '0');
						} else
								rv--;
						arg <<= 4;
				}
		} else if (flags & KFL_IS_OCT) {
				/* process first bit */
				if (arg & (1ull << 63)) {
						rv++; nonz = 1;
						if (ctx) ctx->putchar(ctx, '1');
				}
				for (i = 0; i < 21; i++) {
						unsigned long long int of = (arg & 0700000000000000000000);
						char oc = '0' + (char)(of >> 60);
						rv++;
						if (oc != '0') {
								nonz = 1;
								if (ctx) ctx->putchar(ctx, oc);
						} else if (nonz || i == 20) {
								if (ctx) ctx->putchar(ctx, '0');
						} else
								rv--;
						arg <<= 3;
				}
		} else {
				unsigned long long int div = 1000000000000000000;
				unsigned long long int res; char frst = 0;
				i = 0;
				while (div) {
					res = arg / div;
					arg %= div; rv++;
					if (res || frst) {
						if (ctx) ctx->putchar(ctx, '0' + (char)res);
						frst = 1;
					} else if (i == 18) {
							if (ctx) ctx->putchar(ctx, '0');
					} else
							rv--;
					div /= 10;
					i++;
				}
				i = rv;
		}
		return rv;
}

void usermode_entry()
{
		int val = 4;
		printf("The adress of the stack is around %p\n", &val);
		printf("which is set within the kernel stack\n");
		while (1);

}

void fun()
{
		/* float test etc. */
		extern void to_usermode();
		/*to_usermode();*/
}
/* TODO: 
 * #ifdef GDB asctime -> ls <- done
 * und TSS ltr <- done
 * common_data.h mit allen tabellen usw. & RM-PM Transfer
 * IMMER MEHR -> Kernel Image & Bootloader trennen
 * COM usw. aufraeumen
 * Page scrub granularer <- done
 * PAE problemchen <- done
 * VMEM allocator
 * sched & ls problem
 * tz localtime usw.
 * thread list & lock registry
__thread int iv = 0; <- drepper TLS article LDO, LE, LI
iv = 5; */
int putu(struct ivp_ctx* ctx, unsigned long long int arg, char flags, char width, char prec)
{
		int len, rv = 0;
		int ns = 0, nz = 0, neg = ((flags & KFL_IS_NEG) == KFL_IS_NEG), zero = 0;
		if (neg/* && (flags & KFL_IS_HEX)*/)
				flags &= ~KFL_IS_OCT;
		/* calc len */
		len = putu64(NULL, arg, flags);
		/* print at least width characters with prec digits */
		if (neg || (flags & (KFL_ALWAYS_SIGN | KFL_SPACE_PLUS)))
				rv++; /* one sign character */
		rv += len;
		if ((prec == -1) && !arg) {/* omit zero and sign, honor width */
				rv = 0;
				zero = 1;
		}
		else if (flags & KFL_TYPE_PREFIX) {/* print type prefix (if printing 0) */
				if (flags & KFL_IS_HEX)
						rv += 2;
				else if (flags & KFL_IS_OCT)
						rv++;
		}
		/* get nz and ns to match width & prec */
		if (flags & KFL_ZERO_PREFIX) {
				nz = max(width - rv, prec);
				if (nz < 0)
						nz = 0;
		} else {
				if (prec > 0)
						nz = prec - len;
				if (nz < 0)
						nz = 0;
				if (width)
						ns = width - rv - nz;
				if (ns < 0)
						ns = 0;
		}
		rv += nz + ns;
		/* now print and start with padding */
		if (flags & KFL_LEFT_ALIGN)
				while (ns--)
						ctx->putchar(ctx, ' ');
		/* now the sign */
		if (neg)
				ctx->putchar(ctx, '-');
		else if (flags & KFL_ALWAYS_SIGN && !zero)
				ctx->putchar(ctx, '+');
		else if (flags & KFL_SPACE_PLUS && !zero)
				ctx->putchar(ctx, ' ');
		/* now the type prefix */
		if ((flags & KFL_TYPE_PREFIX) && !zero) {
				if (flags & KFL_IS_HEX) {
						ctx->putchar(ctx, '0');
						if (flags & KFL_CAPITAL)
								ctx->putchar(ctx, 'X');
						else
								ctx->putchar(ctx, 'x');
				} else if (flags & KFL_IS_OCT)
						ctx->putchar(ctx, '0');
		}
		/* print the zero padding */
		while (nz--)
				ctx->putchar(ctx, '0');
		/* now emit the digits */
		if (!zero)
				putu64(ctx, arg, flags);
		/* and the padding */
		while (ns-- > 0)
				ctx->putchar(ctx, ' ');
		return rv;
}

int putmin(struct ivp_ctx* ctx, char flags, char width, char prec)
{
		const char* str_min[] =
		{
				/*"-8000", "-80000000",*/ "8000000000000000", /* hex */
				/*"-100000", "-20000000000",*/ "1000000000000000000000", /* oct*/
				/*"-32768", "-2147483648",*/ "9223372036854775808" /* dec */
		};
		int rv = 0, nz = 0, ns = 0, len;
		const char* str = ((flags & KFL_IS_HEX) ? str_min[0] : ((flags & KFL_IS_OCT) ? str_min[1] : str_min[2]));
		len = strlen(str);
		rv = len + 1;
		if (flags & KFL_TYPE_PREFIX) {
				if (flags & KFL_IS_HEX)
						rv += 2;
				else if (flags & KFL_IS_OCT)
						rv += 1;
		}
		/* calculate the spacing */
		if (flags & KFL_ZERO_PREFIX) {
				nz = max(width - rv, prec);
				if (nz < 0)
						nz = 0;
		} else {
				if (prec > 0)
						nz = prec - len;
				if (nz < 0)
						nz = 0;
				if (width)
						ns = width - rv - nz;
				if (ns < 0)
						ns = 0;
		}
		rv += nz + ns;
		/* print spaces */
		if (flags & KFL_LEFT_ALIGN)
				while (ns--)
						ctx->putchar(ctx, ' ');
		/* print the minus sign */
		if (ctx) ctx->putchar(ctx, '-');
		/* print the type prefix */
		if (flags & KFL_TYPE_PREFIX) {
				if (flags & KFL_IS_HEX) {
						ctx->putchar(ctx, '0');
						if (flags & KFL_CAPITAL)
								ctx->putchar(ctx, 'X');
						else
								ctx->putchar(ctx, 'x');
				} else if (flags & KFL_IS_OCT)
						ctx->putchar(ctx, '0');
		}
		/* and the zero prefix */
		while (nz--)
				ctx->putchar(ctx, '0');
		/* print the number */
		if (ctx) for (size_t i = 0; i < strlen(str); i++)
				ctx->putchar(ctx, str[i]);
		/* print spaces */
		while (ns-- > 0)
				ctx->putchar(ctx, ' ');
		return rv;
}

int putd(struct ivp_ctx* ctx, long long int arg, char flags, char width, char prec)
{
		if (arg < 0) {
				if (arg > LLONG_MIN)
						return putu(ctx, -arg, flags | KFL_IS_NEG, width, prec);
				else
						return putmin(ctx, flags, width, prec);
		} else
				return putu(ctx, (unsigned long long int)arg, flags, width, prec);
}

int internal_vprintf(struct ivp_ctx* ctx, const char* fmt, va_list args)
{
		char is_fmt = 0, flags = KFL_LEFT_ALIGN, width = 0, prec = 0, size = 0;
		int rv = 0;
		while (*fmt) {
			switch (*fmt) {
					case '%':
							is_fmt = !is_fmt;
							if (!is_fmt) {
									ctx->putchar(ctx, *fmt);
									rv++;
							}
							fmt++;
							width = prec = 0;
							flags = KFL_LEFT_ALIGN;
							size = 0;
							break;
					default:
							if ((is_fmt == 1) && (*fmt == ' ' || *fmt == '0' || *fmt == '#' || *fmt == '+' || *fmt == '-')) {
									if (*fmt == ' ')
											flags |= KFL_SPACE_PLUS;
									else if (*fmt == '0')
											flags |= KFL_ZERO_PREFIX;
									else if (*fmt == '+')
											flags |= KFL_ALWAYS_SIGN;
									else if (*fmt == '-')
											flags &= ~KFL_LEFT_ALIGN;
									else if (*fmt == '#')
											flags |= KFL_TYPE_PREFIX;
									fmt++;
							} else if (is_fmt && *fmt >= '0' && *fmt <= '9') {
									if (is_fmt == 1)
											is_fmt = 3;
									if (is_fmt == 2) {
											prec *= 10;
											prec += (*fmt - '0');
									} else { /* is_fmt == 3 */
											width *= 10;
											width += (*fmt - '0');
											/* possibly check for width=0 due to 00 */
									}
									fmt++;
							} else if (is_fmt && *fmt == '.') {
									is_fmt = 2;
									fmt++;
							} else if (is_fmt && *fmt == '*') {
									if (is_fmt == 2)
											prec = va_arg(args, int);
									else
											width = va_arg(args, int);
									fmt++;
							} else if (is_fmt) {
									/* set the right prec */
									if (is_fmt == 2 && !prec)
											prec = -1; /* no zero */
									/* read size prefix */
									if (*fmt == 'h') {
											fmt++;
											if (*fmt == 'h') {
													size = 1; /* hh */
													fmt++;
											} else
													size = 2; /* h */
									} else if (*fmt == 'l') {
											fmt++;
											if (*fmt == 'l') {
													size = 4; /* ll */
													fmt++;
											} else
													size = 3;
									} else if (*fmt == 'j') {
											fmt++;
											size = 5;
									} else if (*fmt == 'z') {
											size = 6;
											fmt++;
									} else if (*fmt == 't') {
											size = 7;
											fmt++;
									} else if (*fmt == 'L') {
											size = 8;
											fmt++;
									}
									/* DIRECTLY read type */
									if (*fmt == 'd' || *fmt == 'i') {
											signed long long int val = 0;
											if (!size) val = va_arg(args, signed int);
											else if (size == 1) val = va_arg(args, signed char);
											else if (size == 2) val = va_arg(args, signed short int);
											else if (size == 3) val = va_arg(args, signed long int);
											else if (size == 4) val = va_arg(args, signed long long int);
											else if (size == 5) val = va_arg(args, intmax_t);
											else if (size == 6) val = va_arg(args, ssize_t);
											else if (size == 7) val = va_arg(args, ptrdiff_t);
											else (void)va_arg(args, long double); /* remove bogus value*/
											rv += putd(ctx, val, flags, width, prec);
									} else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'u' || *fmt == 'o' || *fmt == 'b') {
											unsigned long long int val = 0;
											if (!size) val = va_arg(args, unsigned int);
											else if (size == 1) val = va_arg(args, unsigned char);
											else if (size == 2) val = va_arg(args, unsigned short int);
											else if (size == 3) val = va_arg(args, unsigned long int);
											else if (size == 4) val = va_arg(args, unsigned long long int);
											else if (size == 5) val = va_arg(args, uintmax_t);
											else if (size == 6) val = va_arg(args, size_t);
											else if (size == 7) val = va_arg(args, ptrdiff_t);
											else (void)va_arg(args, long double); /* remove bogus value*/
											if (*fmt == 'x')
													rv += putu(ctx, val, flags | KFL_IS_HEX, width, prec);
											else if (*fmt == 'X')
													rv += putu(ctx, val, flags | KFL_IS_HEX | KFL_CAPITAL, width, prec);
											else if (*fmt == 'u')
													rv += putu(ctx, val, flags, width, prec);
											else if (*fmt == 'o')
													rv += putu(ctx, val, flags | KFL_IS_OCT, width, prec);
											else if (*fmt == 'b')
													rv += putb(ctx, val, flags, width, prec);
									} else if(*fmt == 'p')/* {
											char fm = cur_fmt;
											cur_fmt = (cur_fmt & 0xf) | 0x10;*/
											rv += putu(ctx, (uint64_t)(uintptr_t)va_arg(args, void*), /*KFL_ZERO_PREFIX |*/ KFL_IS_HEX,
															0, 2 * sizeof(void*) / sizeof(char));
									/*		cur_fmt = fm;
									}*/
									else if (*fmt == 's') {
											/* no wchar_t support */
											void cputs(const char* s) {
													while (*s)
															ctx->putchar(ctx, *s++);
											}
											const char* str = va_arg(args, const char*);
											if(str) {
													size_t l = strlen(str);
													if ((size_t)width > l) {
															if (!(flags & KFL_LEFT_ALIGN))
																	cputs(str);
															while ((size_t)(width--) > l)
																	ctx->putchar(ctx, ' ');
															if (flags & KFL_LEFT_ALIGN)
																	cputs(str);
															rv += width;
													} else if (prec && l > (size_t)prec) {
															rv += prec;
															l = 0;
															while (l++ < (size_t)prec)
																	ctx->putchar(ctx, *str++);
													} else {
															rv += l;
															cputs(str);
													}
											}
											else
													cputs("(null)");
									} else if (*fmt == 'c') {
											ctx->putchar(ctx, (char)va_arg(args, int));
											rv++;
									} else if (*fmt == 'f')
											/* FPU init needed? */;
									else if (*fmt == 'n') {
											if (!size)
													*va_arg(args, int*) = (int)rv;
											else if (size == 1)
													*va_arg(args, signed char*) = (signed char)rv;
											else if (size == 2)
													*va_arg(args, short int*) = (short int)rv;
											else if (size == 3)
													*va_arg(args, long int*) = (long int)rv;
											else if (size == 4)
													*va_arg(args, long long int*) = (long long int)rv;
											else if (size == 5)
													*va_arg(args, intmax_t*) = (intmax_t)rv;
											else if (size == 6)
													*va_arg(args, ssize_t*) = (ssize_t)rv;
											else if (size == 7)
													*va_arg(args, ptrdiff_t*) = (ptrdiff_t)rv;
											else
													(void)va_arg(args, long double*);
									} else { /* ignore */
											ctx->putchar(ctx, '%');
											ctx->putchar(ctx, *fmt);
											rv += 2;
									}
									fmt++;
									is_fmt = 0;
									flags = KFL_LEFT_ALIGN;
									width = 0;
									prec = 0;
									size = 0;
							} else {
									ctx->putchar(ctx, *(fmt++));
									rv++;
							}
			}
		}
		return rv;
}

void ctx_c_putchar(struct ivp_ctx* ctx, char c)
{
		region_putchar(ctx->buf, c);
}

void ctx_s_putchar(struct ivp_ctx* ctx, char c)
{
		if (ctx->buf) {
				if (!ctx->n) {
						ctx->buf = NULL;
						return;
				}
				*ctx->buf++ = c;
				ctx->n--;
		}
}

int vrprintf(struct kio_region* cr, const char* fmt, va_list args)
{
		int rv;
		struct ivp_ctx ct = {cr, 0, &ctx_c_putchar};
		rv = internal_vprintf(&ct, fmt, args);
		return rv;
}

int vprintf(const char* fmt, va_list args)
{
		int rv;
		struct ivp_ctx ct = {&reg_def, 0, &ctx_c_putchar};
		rv = internal_vprintf(&ct, fmt, args);
		return rv;
}

/* with region ptr, region has lock & spin_trylock & lock-free add-buffer
  & malloc in irq question */
int rprintf(struct kio_region* cr, const char* fmt, ...)
{
		int rv;
		va_list args;
		va_start(args, fmt);
		rv = vrprintf(cr, fmt, args);
		va_end(args);
		return rv;
}

int crprintf(char col, struct kio_region* cr, const char* fmt, ...)
{
		int rv; char cf = cr->fmt;
		va_list args;
		va_start(args, fmt);
		cr->fmt = col;
		rv = vrprintf(cr, fmt, args);
		cr->fmt = cf;
		va_end(args);
		return rv;
}

int cprintf(char col, const char* fmt, ...)
{
		int rv; char cf = reg_def.fmt;
		va_list args;
		va_start(args, fmt);
		reg_def.fmt = col;
		rv = vprintf(fmt, args);
		reg_def.fmt = cf;
		va_end(args);
		return rv;
}

int vsprintf(char* str, const char* fmt, va_list args)
{
		struct ivp_ctx ct = {str, 0xffffffff, &ctx_s_putchar};
		return internal_vprintf(&ct, fmt, args);
}

int sprintf(char* str, const char* fmt, ...)
{
		int rv;
		va_list args;
		va_start(args, fmt);
		rv = vsprintf(str, fmt, args);
		va_end(args);
		return rv;
}

int vsnprintf(char* str, size_t n, const char* fmt, va_list args)
{
		struct ivp_ctx ct = {str, n, &ctx_s_putchar};
		return internal_vprintf(&ct, fmt, args);
}

int snprintf(char* str, size_t n, const char* fmt, ...)
{
		int rv;
		va_list args;
		va_start(args, fmt);
		rv = vsnprintf(str, n, fmt, args);
		va_end(args);
		return rv;
}

int printf(const char* fmt, ...)
{
		int rv;
		va_list args;
		va_start(args, fmt);
		rv = vprintf(fmt, args);
		va_end(args);
		return rv;
}
/* no delay intr version */
int iprintf(const char* fmt, ...)
{
		int rv;
		va_list args;
		va_start(args, fmt);
		reg_def.flags |= KIO_REGION_NO_DELAY;
		rv = vprintf(fmt, args);
		reg_def.flags &= ~KIO_REGION_NO_DELAY;
		va_end(args);
		return rv;
}
int noprintf(const char* c, ...) { (void)c; return 0; }

void memdump(void* ofs, size_t sz)
{
		size_t i, ct;

		printf("dumping memory at %p with size %u:\n", ofs, sz);
		for (i = 0; i < sz; i += 16) {
				uint16_t* mem = (uint16_t*)(ofs + i);
				uint8_t nbl = 41; /* 41 blanks until text output */
				/* xxd-style output: 8 words and text */
				for (ct = 0; ct < 8; ct++) {
						if (i + 2 * ct <= sz - 2) {
								printf("%04x ", ((mem[ct] << 8) & 0xff00) | (mem[ct] >> 8));
								nbl -= 5;
						} else if (i + 2 * ct == sz - 1) { /* ending on half word */
								printf("%02x   ", *(uint8_t*)(mem + ct));
								nbl -= 5;
						} else
								break;
				}
				/* fill with blanks */
				while (nbl--)
						putchar(' ');
				/* output the text */
				for (ct = 0; ct < 16; ct++) {
						char* c = (char*)mem + ct;
						if (i + ct >= sz)
								break;
						if (isprint(*c))
								putchar(*c);
						else
								putchar('.');
				}
				putchar('\n');
		}
}

