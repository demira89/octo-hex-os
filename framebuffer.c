/* framebuffer.c: Implements a text mode framebuffer for drawing text
 *                into (S)VGA video memory.
 * */

#include "limits.h"
#include "kernel.h"
#include "kdata.h"
#include "boot/fixmem.h"

struct vmd video_mode;
struct framebuffer fb_initial = {(void*)0xb8000, 80, 25, NULL, 1, 0, 0, 0, 0, 0, 0, 80, 25, NULL, NULL};
/* video memory location after paging */
void* vga_mem_ptr = (void*)0xb8000;
/* used for paging the pmem */
void* vga_pmem = (void*)0xb8000;
size_t vga_pmem_size = 0x8000; /* b8000-c0000 color TM */
const char* vga_font = NULL;

struct vmdesc {
		uint64_t vga_base;
		uint64_t vga_size;
		uint64_t vga_virt;
};

void fb_video_setup()
{
		struct vmdesc* vmd;
		memcpy(&video_mode, FM_VIDEO_MODE, sizeof(video_mode));
		vga_font = (const char*)video_mode.fnt;
		vmd = (void*)video_mode.ptr;
		vga_mem_ptr = (void*)vmd->vga_virt;
		vga_pmem = (void*)vmd->vga_base;
		vga_pmem_size = (size_t)vmd->vga_size;
		framebuffer_initialize(&fb_initial, (void*)video_mode.fnt,
						(void*)video_mode.txt,video_mode.width / 8,
						video_mode.height / 16, 0, 0, /* pxl_ofs_xy*/
						0, 0, /* char_ofs_xy*/ video_mode.width / 8,
						video_mode.height / 16 /* char_width_xy*/);
		/* update the console info */
		extern void kio_fb_resize();
		kio_fb_resize();
		puts("done setting up the framebuffer");
		framebuffer_redraw(&fb_initial);
}

void framebuffer_initialize(struct framebuffer* fb, const char* font,
				void* textmem, ssize_t width, ssize_t height,
				ssize_t pxl_ofs_x, ssize_t pxl_ofs_y,
				ssize_t char_ofs_x, ssize_t char_ofs_y,
				ssize_t char_width_x, ssize_t char_width_y)
{
		fb->text_mem = textmem;
		fb->font = font;
		fb->width = width;
		fb->height = height;
		fb->is_visible = 1;
		fb->cur_x = fb->cur_y = 0;
		fb->pix_x = pxl_ofs_x;
		fb->pix_y = pxl_ofs_y;
		fb->cho_x = char_ofs_x;
		fb->cho_y = char_ofs_y;
		fb->chw_x = char_width_x;
		fb->chw_y = char_width_y;
		fb->r_ud = NULL;
		fb->r_excl = NULL;
}

void framebuffer_add_exclude_rect(struct framebuffer* fb, struct exclude_rect* r)
{
		if (!r)
				return;
		do {
				r->next = fb->r_excl;
		} while (!__sync_bool_compare_and_swap(&fb->r_excl, r->next, r));
}

void framebuffer_remove_exclude_rect(struct framebuffer* fb, struct exclude_rect* r)
{
		struct exclude_rect **er, *r2;
Pos1:
		er = &fb->r_excl;
		while ((r2 = *er)) {
				if (r2 == r) {
						if (__sync_bool_compare_and_swap(er, r, r->next))
								return;
						else
								goto Pos1;
				}
				er = &r2->next;
		}
}

union col32 {
		uint32_t val;
		struct {
				uint8_t b, g, r, x;
		};
};

union col32 palette_32[16] = {
		{ .r = 0, .g = 0, .b = 0 }, // black
		{ .r = 0, .g = 0, .b = 0xaa }, // blue
		{ .r = 0, .g = 0xaa, .b = 0 }, // green
		{ .r = 0, .g = 0xaa, .b = 0xaa }, // cyan
		{ .r = 0xaa, .g = 0, .b = 0 }, // red
		{ .r = 0xaa, .g = 0, .b = 0xaa }, // violet
		{ .r = 0xaa, .g = 0x55, .b = 0 }, // brown
		{ .r = 0xaa, .g = 0xaa, .b = 0xaa }, // grey
		{ .r = 0x55, .g = 0x55, .b = 0x55 }, // dark grey
		{ .r = 0x55, .g = 0x55, .b = 0xaa }, // light blue
		{ .r = 0x55, .g = 0xaa, .b = 0x55 }, // light green
		{ .r = 0x55, .g = 0xaa, .b = 0xaa }, // light cyan
		{ .r = 0xaa, .g = 0x55, .b = 0x55 }, // light red
		{ .r = 0xaa, .g = 0x55, .b = 0xaa }, // light violet
		{ .r = 0xaa, .g = 0x55, .b = 0x55 }, // yellow
		{ .r = 0xff, .g = 0xff, .b = 0xff } // white
};

uint32_t get_tm_color(char col, char is_set, int btpp)
{
		switch (btpp) {
				case 4: /* same palette */
						if (is_set)
								return col & 0x0f;
						else
								return (col >> 4) & 0x0f;
				case 8: /* 8 bit default palette */
						if (is_set)
								return col & 0x0f;
						else
								return (col >> 4) & 0x0f;
				case 15: /* 15/16 bits r5g6b5 x1r5g5b5 */
				case 16: {
						uint32_t rv; union col32 iv;
						if (is_set)
								iv = palette_32[col & 0x0f];
						else
								iv = palette_32[(col >> 4) & 0x0f];
						if (btpp == 15)
								rv = (iv.b >> 3) | ((iv.g >> 3) << 5) | ((iv.r >> 3) << 10);
						else
								rv = (iv.b >> 3) | ((iv.g >> 2) << 5) | ((iv.r >> 3) << 11);
						return rv;
					 }
				case 24:
				case 32:
						if (is_set)
								return palette_32[col & 0x0f].val;
						else
								return palette_32[(col >> 4) & 0x0f].val;
		}
		return 0x2f0c0c2f; /* canary */
}

/* generates up to 8 pixel color values (returns bitcount) */
int generate_char_colors(const char* font, char c, char fmt, size_t btpp,
				ssize_t r, ssize_t rmax, uint8_t* cvs, int inv /*, int bitc*/)
{
		int rv = 0;
		uint8_t f = (uint8_t)font[c * 16];
		for (; r < rmax; r++) {
				int is_set = f & (1 << (7 - r));
				uint32_t cv;
				/* cursor handling */
				if (inv)
						is_set = !is_set;
				/* get the color */
				cv = get_tm_color(fmt, is_set, btpp);
				/* construct the data */
				switch (btpp) {
						case 32:
								*(uint32_t*)cvs = (uint32_t)cv;
								cvs += 4; rv += 32;
								break;
						case 24:
								*(uint16_t*)cvs = (uint16_t)(cv & 0xffff);
								cvs += 2;
								*(uint8_t*)cvs++ = (uint8_t)(cv >> 16);
								rv += 24;
								break;
						case 15:
						case 16:
								*(uint16_t*)cvs = (uint16_t)cv;
								cvs += 2; rv += 16; /* even for 15 */
								break;
						case 8:
								*cvs++ = (uint8_t)cv; rv += 8;
								break;
						case 4:
								rv += 4;
								die("also complicated!\n");
								break;
				}
		}
		return rv;
}

#define move_128(s,d) do { \
		__asm__ ("mov %1, %%eax\n" \
				 "mov %0, %%edx\n" \
				 "movaps (%%eax), %%xmm0\n" \
				 "movaps %%xmm0, (%%edx)\n" \
				: "=m" (d) : "m" (s) : "xmm0", "eax", "edx"); \
		} while (0)

#define move_64(s,d) do { \
		__asm__ ("mov %1, %%eax\n" \
				 "mov %0, %%edx\n" \
				 "movq (%%eax), %%mm0\n" \
				 "movq %%mm0, (%%edx)\n" \
				 : "=m" (d) : "m" (s) : "mm0", "eax", "edx"); \
		} while(0)


/* we're generating 4byte colorvalues /w unknown alignment. To enable
 * 16 byte transfers, 4 pixels /w 16 bytes have to be generated. */
void render_text_scanline_32btpp_sse(const char* font, char* str, void* mem,
				ssize_t px_x, ssize_t cur_x, ssize_t p0_x)
{
		uint8_t pxb[16 + 15]; /* 15 for stack alignment */
		ssize_t misalign = ((size_t)mem % 16) ? (16 - (size_t)mem % 16) : 0;
		ssize_t r = p0_x % 8;
		uint8_t* pixbuf = pxb + (((size_t)pxb % 16) ? (16 - ((size_t)pxb % 16)) : 0);
		/* 64-bit aligned moves are enough */

		if (misalign) { /* LFB is dword aligned, we want (dq/o)word access */
				int col = p0_x / 8, inv = (col == cur_x);
				ssize_t bc = min(misalign, 4 * px_x);
				ssize_t cc = rdiv(misalign, 4);
				ssize_t rmax = min(8, r + cc), cc1 = rmax - r;

				generate_char_colors(font, str[0], str[1], 32,
								r, rmax, pixbuf, inv);
				if (rmax == 8)
						str += 2;
				if (cc > cc1) { /* generate the new char */
						col++; inv = (col == cur_x);
						generate_char_colors(font, str[0], str[1], 32,
										0, cc - cc1, pixbuf + cc1 * 4, inv);
				}
				memcpy(mem, pixbuf, bc);
				px_x -= cc;
				p0_x += cc;
				mem += bc;
		}

		/* draw 4 pixels each */
		while (px_x) {
				int col = p0_x / 8, inv = (col == cur_x);
				ssize_t rmax, bitc, btt = min(128, 32 * px_x);
				r = p0_x % 8;
				rmax = min(8, r + min(4, px_x)); /* only 4 pixels */
				/* get the remaining character pixels */
				bitc = generate_char_colors(font, str[0], str[1], 32,
								r, rmax, pixbuf, inv);
				/* now advance if neccessary */
				if (rmax == 8)
						str += 2;
				/* and fetch up to three more pixels if needed (r=0) */
				if (bitc < btt) {
						col++; int pc = (btt - bitc) / 32;
						inv = (col == cur_x);
						bitc += generate_char_colors(font, str[0], str[1], 32,
										0, pc, pixbuf + bitc / 32, inv);
				}
				/* now transfer */
				if (bitc >= 128) {
						move_128(pixbuf, mem);
						mem += 16; /* intentionally no bitc subtract */
				} else {
						uint8_t* pt = pixbuf;
						if (bitc >= 64) {
								move_64(pixbuf, mem);
								pt += 8;
								mem += 8;
								bitc -= 64;
						}
						if (bitc >= 32) {
								*(uint32_t*)mem = *(uint32_t*)pt;
								pt += 4;
								mem += 4;
								bitc -= 32;
						} else if (bitc) {
								die("cant happen with dword sized pixels!\n");
						}
						break;
				}

				/* and don't advance as r = 0 is already handled (sth. remains) */
				if (px_x) {
						px_x -= bitc / 32;
						p0_x += bitc / 32; /* unneccessary as r does not change anymore */
				} else
						break;
		}
}

/* we're generating 3byte colorvalues /w unknown alignment. To enable
 * 16 byte transfers, 6 pixels /w 18 bytes have to be generated. */
void render_text_scanline_24btpp_sse(const char* font, char* str, void* mem,
				ssize_t px_x, ssize_t cur_x, ssize_t p0_x)
{
		uint8_t pxb[18 + 2 + 15]; /* 15 for stack alignment, 2 for bt_ofs */
		ssize_t misalign = ((size_t)mem % 16) ? (16 - (size_t)mem % 16) : 0;
		ssize_t r = p0_x % 8;
		uint8_t* pixbuf = pxb + (((size_t)pxb % 16) ? (16 - ((size_t)pxb % 16)) : 0);
		ssize_t bt_ofs = 0; /* used to control writing into pixbuf (1/3 pixels)*/
		/* 64-bit aligned moves are enough */

		if (misalign) { /* LFB is dword aligned, we want (dq/o)word access */
				int col = p0_x / 8, inv = (col == cur_x);
				ssize_t bc = min(misalign, 3 * px_x);
				ssize_t cc = rdiv(bc, 3);
				ssize_t rmax = min(8, r + cc), cc1 = rmax - r;

				generate_char_colors(font, str[0], str[1], 24,
								r, rmax, pixbuf, inv);
				if (rmax == 8)
						str += 2;
				if (cc > cc1) { /* generate the new char */
						col++; inv = (col == cur_x);
						generate_char_colors(font, str[0], str[1], 24,
										0, cc - cc1, pixbuf + cc1 * 3, inv);
				}
				memcpy(mem, pixbuf, bc);
				/* now indicate the remaining pixel part if there and
				 * copy the data to the front for the later transfer */
				if (bc % 3) {
						bt_ofs = 3 * cc - bc;
						memcpy(pixbuf, pixbuf + bc, bt_ofs);
						/* no bt_ofs pixels from this pixel are left in pixbuf */
				}
				px_x -= cc;
				p0_x += cc;
				mem += misalign; /* safer than bc */
		}

		/* draw 5 2/3 pixels each (6,5,5) */
		while (px_x) { /* 144 bit vs. 128 16bt remain (2/3) */
				int col = p0_x / 8, inv = (col == cur_x);
				ssize_t cc = min(bt_ofs ? 5 : 6, px_x), cc1; /* 655 */
				ssize_t rmax, bitc, btt = min(128, 24 * px_x + 8 * bt_ofs);
				r = p0_x % 8;
				rmax = min(8, r + cc); /* only up to 6 pixels */
				/* get the remaining character pixels */
				bitc = generate_char_colors(font, str[0], str[1], 24,
								r, rmax, pixbuf + bt_ofs, inv);
				cc1 = rmax - r;
				/* now advance if neccessary */
				if (rmax == 8)
						str += 2;
				/* and fetch up to five more pixels if needed (r=0) */
				if (cc > cc1) {
						col++; inv = (col == cur_x);
						bitc += generate_char_colors(font, str[0], str[1], 24,
										0, cc - cc1, pixbuf + bt_ofs + cc1 * 3, inv);
				}
				/* now transfer */
				if (btt >= 128) {
						move_128(pixbuf, mem);
						mem += 16;
				} else {
						uint8_t* pt = pixbuf;
						if (btt >= 64) {
								move_64(pixbuf, mem);
								pt += 8;
								mem += 8;
								btt -= 64;
						}
						if (btt >= 32) {
								*(uint32_t*)mem = *(uint32_t*)pt;
								pt += 4;
								mem += 4;
								btt -= 32;
						} else if (btt >= 16) {
								*(uint16_t*)mem = *(uint16_t*)pt;
								pt += 2;
								mem += 2;
								btt -= 16;
						} else if (bitc >= 8) {
								*(uint8_t*)mem = *(uint8_t*)pt;
								pt += 1;
								mem += 1;
								btt -= 8;
						} else if (bitc) {
								die("can't happen with 3byte sized pixels\n");
						}
						break;
				}

				/* and don't advance as r = 0 is already handled (sth. remains) */
				if (px_x) {
						px_x -= cc; /* bitc is 24-divisible */
						p0_x += cc; /* unneccessary as r does not change anymore */
						/* copy remaining data */
						/* |bt_ofs*8-bitc| */
						if (!bt_ofs--)
								bt_ofs = 2;
						memcpy(pixbuf, pixbuf + 16, bt_ofs);
				} else
						break;
		}

		/* transfer the leftover pixel data */
		if (bt_ofs)
				memcpy(pixbuf, mem, bt_ofs);
}

/* we're generating 2byte colorvalues /w unknown alignment. To enable
 * 8 byte transfer, four pixels have to be generated. */
void render_text_scanline_16btpp(const char* font, char* str, void* mem,
				ssize_t px_x, ssize_t cur_x, ssize_t p0_x, size_t btpp)
{
		uint8_t pxb[8 + 7]; /* 7 for stack alignment */
		ssize_t misalign = ((size_t)mem % 8) ? (8 - (size_t)mem % 8) : 0;
		ssize_t r = p0_x % 8;
		uint8_t* pixbuf = pxb + (((size_t)pxb % 8) ? (8 - ((size_t)pxb % 8)) : 0);
		/* 64-bit aligned moves are enough */

		if (misalign) { /* LFB is dword aligned, we want qword access */
				int col = p0_x / 8, inv = (col == cur_x);
				ssize_t bc = min(misalign, 2 * px_x);
				ssize_t cc = rdiv(misalign, 2);
				ssize_t rmax = min(8, r + cc), cc1 = rmax - r;

				generate_char_colors(font, str[0], str[1], btpp,
								r, rmax, pixbuf, inv);
				if (rmax == 8)
						str += 2;
				if (cc > cc1) {
						col++; inv = (col == cur_x);
						generate_char_colors(font, str[0], str[1], btpp,
										0, cc - cc1, pixbuf + cc1, inv);
				}
				memcpy(mem, pixbuf, bc);
				px_x -= cc;
				p0_x += cc;
				mem += bc;
		}

		/* draw 4 pixels each */
		while (px_x) {
				int col = p0_x / 8, inv = (col == cur_x);
				ssize_t rmax, bitc, btt = min(64, 16 * px_x);
				r = p0_x % 8;
				rmax = min(8, r + min(4, px_x)); /* only 2 pixels */
				/* get the remaining character pixels */
				bitc = generate_char_colors(font, str[0], str[1], btpp,
								r, rmax, pixbuf, inv);
				/* now advance if neccessary */
				if (rmax == 8)
						str += 2;
				/* and fetch up to three more pixels if needed (r=0) */
				if (bitc < btt) {
						col++;
						inv = (col == cur_x);
						bitc += generate_char_colors(font, str[0], str[1], btpp,
										0, (btt - bitc) / 16, pixbuf + bitc / 16, inv);
				}
				/* now transfer */
				if (bitc >= 64) {
						move_64(pixbuf, mem);
						mem += 8; /* intentionally no bitc subtract */
				} else {
						void* pt = pixbuf;
						if (bitc >= 32) {
								*(uint32_t*)mem = *(uint32_t*)pixbuf;
								mem += 4;
								pt += 4;
								bitc -= 32;
						}
						if (bitc >= 16) {
								*(uint32_t*)mem = *(uint32_t*)pt;
								mem += 2;
								bitc -= 16;
						} else if (bitc) {
								die("cant happen with word sized pixels! %d\n", px_x);
						}
						break;
				}

				/* and don't advance as r = 0 is already handled (sth. remains) */
				if (px_x) {
						px_x -= bitc / 16;
						p0_x += bitc / 16; /* unneccessary as r does not change anymore */
				} else
						break;
		}
}

/* we're generating 4byte colorvalues /w unknown alignment. To enable
 * 8 byte transfer, two pixel have to be generated. */
void render_text_scanline_32btpp(const char* font, char* str, void* mem,
				ssize_t px_x, ssize_t cur_x, ssize_t p0_x)
{
		uint8_t pxb[8 + 7]; /* 7 for stack alignment */
		ssize_t misalign = ((size_t)mem % 8) ? (8 - (size_t)mem % 8) : 0;
		ssize_t r = p0_x % 8;
		uint8_t* pixbuf = pxb + (((size_t)pxb % 8) ? (8 - ((size_t)pxb % 8)) : 0);
		/* 64-bit aligned moves are enough */

		if (misalign) { /* LFB is dword aligned, we want qword access */
				int col = p0_x / 8, inv = (col == cur_x);
				ssize_t bc = min(misalign, 4 * px_x);
				ssize_t cc = rdiv(misalign, 4);
				ssize_t rmax = min(8, r + cc); //, cc1 = rmax - r;

				generate_char_colors(font, str[0], str[1], 32,
								r, rmax, pixbuf, inv);
				if (rmax == 8)
						str += 2;
				// if (cc > cc1) <- does not happen cc always 1
				memcpy(mem, pixbuf, bc);
				px_x -= cc;
				p0_x += cc;
				mem += bc;
		}

		/* draw 2 pixels each */
		while (px_x) {
				int col = p0_x / 8, inv = (col == cur_x);
				ssize_t rmax, bitc, btt = min(64, 32 * px_x);
				r = p0_x % 8;
				rmax = min(8, r + min(2, px_x)); /* only 2 pixels */
				/* get the remaining character pixels */
				bitc = generate_char_colors(font, str[0], str[1], 32,
								r, rmax, pixbuf, inv);
				/* now advance if neccessary */
				if (rmax == 8)
						str += 2;
				/* and fetch one more pixel if needed (r=0) */
				if (bitc < btt) {
						col++;
						inv = (col == cur_x);
						bitc += generate_char_colors(font, str[0], str[1], 32,
										0, 1, pixbuf + 4, inv);
				}
				/* now transfer */
				if (bitc >= 64) {
						move_64(pixbuf, mem);
						mem += 8; /* intentionally no bitc subtract */
				} else {
						if (bitc >= 32) {
								*(uint32_t*)mem = *(uint32_t*)pixbuf;
								mem += 4;
								bitc -= 32;
						} else if (bitc) {
								die("cant happen with dword sized pixels!\n");
						}
						break;
				}

				/* and don't advance as r = 0 is already handled (sth. remains) */
				if (px_x) {
						px_x -= bitc / 32;
						p0_x += bitc / 32; /* unneccessary as r does not change anymore */
				} else
						break;
		}
}

/* ~32 times better performance than /w byte access in old method below */
void render_text_scanline_8btpp(const char* font, char* str, void* mem,
				ssize_t px_x, ssize_t cur_x, ssize_t p0_x)
{
		uint8_t pxb[8 + 7]; /* for any stack alignment */
		ssize_t misalign = ((size_t)mem % 8) ? (8 - (size_t)mem % 8) : 0;
		ssize_t r = p0_x % 8;
		uint8_t* pixbuf = pxb + (((size_t)pxb % 8) ? (8 - ((size_t)pxb % 8)) : 0);
		/* 64-bit aligned moves are enough */

		if (misalign) { /* we first have to draw misalign pixels */
				int col = p0_x / 8, inv = (col == cur_x);
				ssize_t bc = min(misalign, px_x); /* r already set */
				ssize_t rmax = min(8, r + bc), bc1 = rmax - r;

				generate_char_colors(font, str[0], str[1], 8,
								r, rmax, pixbuf, inv);
				if (rmax == 8)
						str += 2;
				if (bc > bc1) {
						col++;
						inv = (col == cur_x);
						generate_char_colors(font, str[0], str[1], 8,
										0, bc - bc1, pixbuf + bc1, inv);
				}
				memcpy(mem, pixbuf, bc);
				px_x -= bc;
				p0_x += bc;
				mem += bc;
		}

		/* now we can draw 8 pixels each */
		while (px_x) {
				int col = p0_x / 8, inv = (col == cur_x);
				ssize_t rmax, bitc, btt = min(64, 8 * px_x), cc;
				r = p0_x % 8;
				rmax = min(8, r + px_x);
				/* get the remaining character pixels */
				bitc = generate_char_colors(font, str[0], str[1], 8,
								r, rmax, pixbuf, inv);
				/* now advance */
				str += 2;
				cc = bitc / 8;
				/* and fetch more pixels if needed (r=0) */
				if (bitc < btt) {
						col++;
						inv = (col == cur_x);
						bitc += generate_char_colors(font, str[0], str[1], 8,
										0, min(8 - cc, px_x - cc), pixbuf + cc, inv);
						cc = bitc / 8;
				}
				/* now transfer */
				if (bitc >= 64) {
						move_64(pixbuf, mem);
						mem += 8; /* intentionally no bitc subtract */
				} else {
						uint8_t* pt = pixbuf;
						if (bitc >= 32) {
								*(uint32_t*)mem = *(uint32_t*)pixbuf;
								pt += 4;
								mem += 4;
								bitc -= 32;
						}
						if (bitc >= 16) {
								*(uint16_t*)mem = *(uint16_t*)pt;
								pt += 2;
								mem += 2;
								bitc -= 16;
						}
						if (bitc >= 8) {
								*(uint8_t*)mem = *(uint8_t*)pt;
								pt += 1;
								mem += 1;
								bitc -= 8;
						} else if (bitc) {
								die("cant happen with byte sized pixels!\n");
						}
						break;
				}

				/* and don't advance as r = 0 is already handled (sth. remains) */
				if (px_x) {
						px_x -= cc;
						p0_x += cc; /* unneccessary as r does not change anymore */
				} else
						break;
		}
}

/* this function uses pixel addressing for width and height
 * making it possible to render half/overlapping characters.
 */
void render_text(const char* font, char* str, void* mem, size_t text_stride, size_t mem_stride,
		size_t btpp, ssize_t px_x, ssize_t px_y, int starts_half, int cur_x, int cur_y, ssize_t p0_x, ssize_t p0_y)
{
		(void)starts_half;
//		char is_half = 0, ends_half = 0;
		/* pixel offset is handled before calling the function */
//		is_half = starts_half;
//		ends_half = (px_x % 2) ? (!starts_half) : (starts_half);
		for (ssize_t ln = p0_y; ln < px_y + p0_y; ln++) {
				ssize_t l = ln % 16; ssize_t cur_xv;

				/* check cursor */
				if (ln / 16 == cur_y)
						cur_xv = cur_x;
				else
						cur_xv = -1;

				/* invoke the scanline drawing routines */
				switch (btpp) {
						case 32:
								if (cpu.has_sse)
										render_text_scanline_32btpp_sse(font + l, str,
												mem, px_x, cur_xv, p0_x);
								else
										render_text_scanline_32btpp(font + l, str,
												mem, px_x, cur_xv, p0_x);
								break;
						case 24: /* 16 bytes /w sse really needed */
								if (cpu.has_sse)
										render_text_scanline_24btpp_sse(font + l, str,
												mem, px_x, cur_xv, p0_x);
								//else
								//		render_text_scanline_24btpp(font + l, str,
								//				mem, px_x, cur_xv, p0_x);
								break;
						case 15:
						case 16:
								render_text_scanline_16btpp(font + l, str,
												mem, px_x, cur_xv, p0_x, btpp);
								break;
						case 8:
								render_text_scanline_8btpp(font + l, str,
												mem, px_x, cur_xv, p0_x);
								break;
						default:
/*								render_text_scanline_xbtpp(font + l, str, btpp,
												mem, px_x, cur_xv, p0_x);*/
								die("not impl\n");
								break;
				}

				/* advance */
				if (l == 15) {
						str += text_stride;
				}
				mem += mem_stride;
		}
}
//void render_text(const char* font, char* str, void* mem, size_t text_stride, size_t mem_stride,
//		size_t btpp, ssize_t px_x, ssize_t px_y, int starts_half, int cur_x, int cur_y, ssize_t p0_x, ssize_t p0_y)
//{
//		char is_half = 0, ends_half = 0;
//		/* pixel offset is handled before calling the function */
//		is_half = starts_half;
//		ends_half = (px_x % 2) ? (!starts_half) : (starts_half);
//		for (ssize_t ln = p0_y; ln < px_y + p0_y; ln++) {
//				char* c = str; ssize_t l = ln % 16;
//				uint8_t f = (uint8_t)font[*c * 16 + l]; uint8_t* vm = mem;
//				for (ssize_t rw = p0_x; rw < px_x + p0_x; rw++) {
//						ssize_t r = rw % 8; uint32_t cv;
//						int is_set = f & (1 << (7 - r));
//						/* check for cursor (invert) */
//						if ((rw / 8 == cur_x) && (ln / 16 == cur_y))
//								is_set = !is_set;
//						/* get the color value */
//						cv = get_tm_color(c[1], is_set, btpp);
//						/* for now draw few single pixels */
//						switch (btpp) {
//								case 4: /* try to byte align */
//										/* propably superflous as there'll be no LFB */
//										if (!rw && is_half) {
//												*vm = (*vm & 0x0f) | ((cv << 4) & 0xf0);
//												vm++;
//										} else if (px_x - rw >= 2) {
//												uint32_t cv2;
//												/* we possibly have to fetch the next character */
//												if (r <= 6) {
//														cv2 = get_tm_color(c[3], f & (1 << (6 - r)), btpp);
//														*vm = (cv & 0x0f) | ((cv2 << 4) & 0xf0);
//												} else { /* r=7, r++=8 */
//													c += 2;
//													f = (uint8_t)font[*c * 16 + ln];
//													cv2 = get_tm_color(c[1], f & 1, btpp);
//													*vm = (cv & 0x0f) | ((cv2 << 4) & 0xf0);
//												}
//												vm++;
//												rw++;
//												continue;
//										} else if (ends_half) { /* we have to combine pixels */
//												*vm = (*vm & 0xf0) | (cv & 0x0f);
//										} else { /* shouldn't happen */
//												while (1);
//										}
//										break;
//								case 8:
//										*vm = cv & 0xff;
//										vm++;
//										break;
//								case 15:
//								case 16:
//										*(uint16_t*)vm = cv & 0xffff;
//										vm += 2;
//										break;
//								case 24:
//										*vm = ((cv >> 16) & 0xff);
//										vm++;
//										*(uint16_t*)vm = cv & 0xffff;
//										vm += 2;
//										break;
//								case 32:
//										*(uint32_t*)vm = cv;
//										vm += 4;
//										break;
//						}
//						if (r == 7) {
//								c += 2;
//								f = (uint8_t)font[*c * 16 + l];
//						}
//				}
//				if (l == 15) {
//						str += text_stride;
//				}
//				mem += mem_stride;
//		}
//}

struct stride {
		ssize_t x1, x2;
};

/* adds stride and returns 1 if new element was needed */
int add_stride(struct stride* sb, size_t num, struct stride* s)
{
		/* assume sortedness (our insertions are sorted) */
		for (size_t i = 0; i < num; i++) {
				if (sb[i].x1 == s->x2) { /* extend below */
						sb[i].x1 = s->x1;
						return 0;
				} else if (sb[i].x2 == s->x1) { /* extend above */
						sb[i].x2 = s->x2;
						return 0;
				}
		}
		/* insert sorted */
		for (size_t i = 0; i < num; i++)
				if (sb[i].x1 < s->x2) {
						memmove(sb + i + 1, sb + i, (num - i) * sizeof(*s));
						sb[i] = *s;
						return 1;
				}
		/* element is last */
		sb[num] = *s;
		return 1;
}

uint64_t fb_rdt = 0;
/* redraws the complete screen */
void framebuffer_redraw_region(struct framebuffer* fb, struct kio_region* r);
void framebuffer_redraw(struct framebuffer* fb)
{
		struct kio_region r = {0};
		r.lx = fb->chw_x; r.ly = fb->chw_y;
		r.x = fb->cho_x; r.y = fb->cho_y;
		framebuffer_redraw_region(fb, &r);
}

/* redraws a defined region (screen relative, not buffer, internal) */
void framebuffer_redraw_region(struct framebuffer* fb, struct kio_region* r)
{
		if (vga_mem_ptr == fb->text_mem)
				return; /* don't do anything if we're directly on video memory */
		else if (video_mode.is_textmode) {
				if (video_mode.width == fb->width && fb->chw_x == fb->width
							   && r->lx == fb->width && !fb->pix_x) {
						ssize_t nl;
						/* super easy memory transfer */
						fb->cho_x = 0;
						nl = min(min(video_mode.height - fb->pix_y, fb->chw_y),
										min(fb->height - fb->cho_y, r->ly));
						memcpy(vga_mem_ptr + (fb->pix_y + r->y) * 2 * video_mode.width,
										fb->text_mem + (fb->cho_y + r->y) * 2
										* fb->width, nl * 2 * fb->width);
						/* show we're outside of buffer (for large cho_y) */
						if (nl < fb->chw_y)
								bzero(vga_mem_ptr + (fb->pix_y + r->y + nl) * 2 * fb->width,
										(min(fb->chw_y, video_mode.height - fb->pix_y)
										 - nl) * fb->width * 2);
				} else {
						ssize_t nl, nc; void *src, *dst;
						/* copy linewise */
						nl = min(min(video_mode.height - fb->pix_y, fb->chw_y),
									   	min(fb->height - fb->cho_y, r->ly));
						nc = min(min(video_mode.width - fb->pix_x, fb->chw_x),
										min(fb->width - fb->cho_x, r->lx));
						src = fb->text_mem + (fb->cho_y + r->y) * 2 * fb->width + 2 * (fb->cho_x + r->y);
						dst = vga_mem_ptr + (fb->pix_y + r->y) * 2 * video_mode.width + 2 * (fb->pix_x + r->y);
						while (nl) {
								memcpy(dst, src, 2 * nc);
								if (nc < min(fb->chw_x, r->lx))
										bzero(dst + 2 * nc, min(fb->chw_x,
											  video_mode.width - fb->pix_x) - nc);
								dst += video_mode.width * 2;
								src += fb->width * 2;
						}
						/* show we're outside (large cho_...) */
						nc = min(min(fb->chw_x, r->lx), video_mode.width - fb->pix_x);
						if (nl < min(fb->chw_y, r->ly)) {
								bzero(dst, 2 * nc);
								dst += video_mode.width * 2;
						}
				}
				return;
		} else {
				int shf = 0;
				void* mem = vga_mem_ptr; char* str = fb->text_mem;
				ssize_t px_x, px_y, o_x, o_y;

				/* calculate the pixel offsets */
				o_x = fb->pix_x + r->x * 8;
				o_y = fb->pix_y + r->y * 16;
				px_x = r->lx * 8;
				px_y = r->ly * 16;
				/* and ensure the bounds */
				if (o_x >= video_mode.width || o_y >= video_mode.height)
					return;
				/* from the text buffer */
				px_x = min(px_x, 8 * min(fb->width - fb->cho_x - r->x, fb->chw_x - r->x));
				px_y = min(px_y, 16 * min(fb->height - fb->cho_y - r->y, fb->chw_y - r->y));
				/* and from video memory */
				px_x = min(px_x, video_mode.width - o_x);
				px_y = min(px_y, video_mode.height - o_y);
				if (px_x < 0 || px_y < 0)
					return;
				
				if (video_mode.gm_bts == 4)
					shf = ((o_x % 2) == 1);
				
				/* set the memory references */
				mem += o_y * video_mode.bpsl + o_x * video_mode.btpp;
				str += (fb->cho_y + r->y) * 2 * fb->width + (fb->cho_x + r->x) * 2;

				/* check for excluding rects */
				if (fb->r_excl) {
						/* use y and x stride marks */
						size_t ns_y = 0, ns_x = 0;
						struct stride /* exclude range:  y is key */
								stride_y[10], stride_x[20];
						struct exclude_rect* pe = fb->r_excl;
						while (pe) {
								struct exclude_rect er = {0};
								er = *pe;
								er.x -= fb->pix_x;
								er.y -= fb->pix_y;
								if (er.x + er.lx > o_x && er.y + er.ly > o_y) {
										if (o_x + px_x > er.x && o_y + px_y > er.y) {
												struct stride sx, sy;
												/* overlap y */
												if (ns_y == 10 || ns_x == 20) /* we could draw parts */
														die("use bigger fb stride buffers\n");
												/* crop the rect and insert two strides */
												sx.x1 = max(o_x, er.x);
												sx.x2 = min(er.x + er.lx, o_x + px_x);
												sy.x1 = max(o_y, er.y);
												sy.x2 = min(er.y + er.ly, o_y + px_y);
												if(add_stride(stride_y, ns_y, &sy))
														ns_y++;
												if (add_stride(stride_x, ns_x, &sx))
														ns_x++;
										}
								}
								pe = pe->next;
						}
						/* add the dummy entries (so we don't have to check at +x) */
						stride_y[ns_y].x1 = o_y + px_y;
						stride_y[ns_y++].x2 = o_y + px_y;
						stride_x[ns_x].x1 = o_x + px_x;
						stride_x[ns_x++].x2 = o_x + px_x;
						if (ns_y > 1 && ns_x > 1) {
								ssize_t lpx_x, lpx_y, lo_x = o_x, lo_y = o_y;
								char* str2 = str; int shf2 = shf; void* mem2;
								/* now we have a field of strides */
								for (size_t i = 0; i < ns_y; i++) {
										/* draw full lines before the stride */
										if (stride_y[i].x1 > lo_y) {
												lpx_x = px_x;
												lo_x = o_x;
												shf2 = shf;
												lpx_y = min(stride_y[i].x1 - lo_y, o_y + px_y - lo_y);
												if (lpx_y) /* skip empty dummy */
													render_text(fb->font, str2, mem, 2 * fb->width,
														video_mode.bpsl, video_mode.gm_bts, lpx_x,
														lpx_y, shf2, fb->cur_x - r->x, fb->cur_y - r->y,
														0, (lo_y - o_y) % 16);
										}
										/* we are inside the stride */
										/* update the references */
										mem += (stride_y[i].x1 - lo_y) * video_mode.bpsl;
										str += ((stride_y[i].x1 - lo_y) / 16) * 2 * fb->width;
										str2 = str;
										lo_y = stride_y[i].x1;
										lpx_y = min(o_y + px_y, stride_y[i].x2) - stride_y[i].x1;
										if (!lpx_y) /* break after zero stride */
												break;
										lo_x = o_x;
										shf2 = shf;
										mem2 = mem;
										/* now draw the x strides */
										for (size_t j = 0; j < ns_x; j++) {
												/* draw to x before */
												if (stride_x[j].x1 > lo_x) {
														lpx_x = min(o_x + px_x - lo_x, stride_x[j].x1 - lo_x);
														render_text(fb->font, str2, mem2, 2 * fb->width,
																video_mode.bpsl, video_mode.gm_bts, lpx_x,
																lpx_y, shf2, fb->cur_x - r->x, fb->cur_y - r->y,
																(lo_x - o_x) % 8, (lo_y - o_y) % 16);
												}
												/* draw nothing as x,y are inside */
												lo_x = stride_x[j].x2;
												str2 = str + ((lo_x - o_x) / 8) * 2;
												mem2 = mem + (lo_x - o_x) * video_mode.btpp;
												if (video_mode.gm_bts == 4)
														shf2 = ((lo_x % 2) == 1);
										}
										/* and set the memory */
										mem += lpx_y * video_mode.bpsl;
										str2 = str + ((stride_y[i].x2 - lo_y) / 16) * 2 * fb->width;
										lo_y = stride_y[i].x2;
								}
								return;
						} else {} /* fall back */
				}

				/* and draw the text */
				render_text(fb->font, str, mem, 2 * fb->width, video_mode.bpsl,
						video_mode.gm_bts, px_x, px_y, shf, fb->cur_x - r->x,
						fb->cur_y - r->y, 0, 0);
		}
}

void framebuffer_redraw_updates(struct framebuffer* fb)
{
		uint64_t tm;
		struct rct *rc, **prc;
Pos1:
		rc = fb->r_ud; prc = &fb->r_ud;
		if (!rc)
				return;
		if (cpu.has_tsc)
				asm volatile ("rdtsc" : "=A" (tm));
		do {
				if (rc->r_ct) {
						/* take element temorary out of list */
						if (__sync_bool_compare_and_swap(prc, rc, rc->next)) {
								/* success */
								for (size_t i = 0; i < rc->r_ct; i++)
										framebuffer_redraw_region(fb, rc->r + i);
								rc->r_ct = 0;
								/* now put the buffer back at the front */
								do {
										rc->next = fb->r_ud;
								} while (!__sync_bool_compare_and_swap(&fb->r_ud, rc->next, rc));
						} else
								goto Pos1;
				}
				prc = &rc->next;
		} while ((rc = rc->next));
		if (cpu.has_tsc) {
				asm volatile ("rdtsc" : "=A" (fb_rdt));
				fb_rdt -= tm;
		}
}

void framebuffer_update_region(struct framebuffer* fb, struct kio_region* r)
{
		struct kio_region r2;
		struct rct* ptr = fb->r_ud;
		size_t idx;
		if (fb->text_mem == vga_mem_ptr)
				return;

		/* for now update on every call */
		r2.x = max(0, r->x - fb->cho_x);
		r2.y = max(0, r->y - fb->cho_y);
		r2.fmt = r->fmt;
		r2.lx = min(fb->chw_x - r2.x, r->lx);
		r2.ly = min(fb->chw_y - r2.y, r->ly);
		/* check for visibility */
		if (r2.x >= fb->chw_x || r2.y >= fb->chw_y ||
			r2.x + r2.lx < fb->cho_x || r2.y + r2.ly < fb->cho_y)
				return;
		/* check for pending updates */
Pos1:
		ptr = fb->r_ud;
		while (ptr) { /* TODO: overhaul this -> leads to freezes */
				size_t i;
				for (i = 0; i < ptr->r_ct; i++) {
						/* check for extending horizontally */
						if (ptr->r[i].y == r2.y && ptr->r[i].ly == r2.ly) {
								short new_lx, old_lx = ptr->r[i].lx;
								if (ptr->r[i].x + ptr->r[i].lx == r2.x) {
										new_lx = old_lx + r2.lx;
										/* try to combine */
										if (!__sync_bool_compare_and_swap(&ptr->r[i].lx, old_lx, new_lx))
												goto Pos1;
										return;
								}
						}
						/* or vertically */
//						if (ptr->r[i].x == r2.x && ptr->r[i].lx == r2.lx) {
//								/* check for spaces */
//								if (ptr->r[i].y < r2.y) {
//										if (ptr->r[i].y + ptr->r[i].ly >= r2.y) {
//												/* combine */
//												if (r2.y + r2.ly > ptr->r[i].y + ptr->r[i].ly)
//														ptr->r[i].ly = r2.y + r2.ly - ptr->r[i].y;
//												return;
//										}
//								} else if (r2.y + r2.ly >= ptr->r[i].y) {
//										/* extend */
//										if (r2.y + r2.ly < ptr->r[i].y + ptr->r[i].ly) {
//												ptr->r[i].ly = ptr->r[i].y + ptr->r[i].ly - r2.y;
//												ptr->r[i].y = r2.y;
//										}
//										return;
//								}
//						}
						/* also check for duplicates */
						if (ptr->r[i].x == r2.x && ptr->r[i].y == r2.y
							&& ptr->r[i].lx == r2.lx && ptr->r[i].ly == r2.ly)
								return;
				}
				/* add inbetween */
				if ((idx = __sync_fetch_and_add(&ptr->r_ct, 1)) < 32) {
						ptr->r[idx] = r2;
						break;
				} else
						__sync_fetch_and_sub(&ptr->r_ct, 1);
				/* we need a new container */
				if (!ptr->next) {
						struct rct* rn = kmalloc(sizeof(struct rct));
						rn->r_ct = 1;
						rn->r[0] = r2;
						rn->next = NULL;
						if (__sync_bool_compare_and_swap(&ptr->next, NULL, rn))
								break;
						else { /* someone was faster */
								kfree(rn);
								//goto Pos1; ptr=next
						}
				}
				ptr = ptr->next;
		}
		/* else extend the list */
		if (!fb->r_ud) {
				struct rct* rn = kmalloc(sizeof(struct rct));
				rn->r_ct = 1;
				rn->r[0] = r2;
				rn->next = NULL;
				if (!__sync_bool_compare_and_swap(&fb->r_ud, NULL, rn)) {
						/* someone was faster */
						kfree(rn);
						goto Pos1;
				}	
		}
}

/* we have to redraw everything */
void framebuffer_scroll(struct framebuffer* fb, ssize_t nly, ssize_t nlx)
{
		if (nly != 1 || nlx)
				while (1); /* only lines for now */
		memmove(fb->text_mem, fb->text_mem + fb->width * 2,
					   	2 * fb->width * (fb->height - 1));
		//framebuffer_redraw(fb);
}

void framebuffer_scroll_region(struct framebuffer* fb,
				struct kio_region* r, ssize_t nx, ssize_t ny)
{
		ssize_t i; char* src = NULL;
		if (ny != 1 || nx)
				while (1); /* only lines for now */
		/* sanity check */
		if (r->x + r->lx > fb->width)
				return;
		if (r->y + r->ly > fb->height)
				return;
		/* by moving possibly strided memory */
		for (i = r->y; i < r->y + r->ly - 1; i++)
				memcpy(fb->text_mem + i * fb->width * 2 + r->x * 2,
					   (src = fb->text_mem + (i + 1) * fb->width * 2 + r->x * 2),
					   r->lx * 2);
		if (!src)
				return;
		for (i = 0; i < 2 * r->lx; i += 2) {
				src[i] = '\0';
				src[i + 1] = r->fmt;
		} /* TODO other scrolls */
		/*bzero(fb->text_mem + i * fb->width * 2 + r->x * 2, r->lx * 2);*/
		framebuffer_update_region(fb, r);
}

void framebuffer_clear_region(struct framebuffer* fb, struct kio_region* r)
{
		char* p;
		if (r->x + r->lx > fb->width)
				return;
		if (r->y + r->ly > fb->height)
				return;
		p = (char*)fb->text_mem + 2 * r->y * fb->width + 2 * r->x;
		for (ssize_t l = 0; l < r->ly; l++)
				for (ssize_t c = 0; c < r->lx; c++) {
						p[l * 2 * fb->width + 2 * c] = '\0';
						p[l * 2 * fb->width + 2 * c + 1] = r->fmt;
				}
		framebuffer_update_region(fb, r);
}

/* has to flush the previous character and the new one and also pending updates */
void framebuffer_set_cursor(struct framebuffer* fb, ssize_t x, ssize_t y)
{
		struct kio_region r;
		if (fb->cur_x > 0 && fb->cur_y > 0
			&& fb->cur_x < fb->chw_x
			&& fb->cur_y < fb->chw_y) {
				r.x = fb->cur_x + fb->cho_y;
				r.lx = 1;
				r.y = fb->cur_y + fb->cho_y;
				r.ly = 1;
				fb->cur_x = x;
				fb->cur_y = y;
				framebuffer_update_region(fb, &r);
		} else {
				fb->cur_x = x;
				fb->cur_y = y;
		}
		r.x = fb->cur_x + fb->cho_x;
		r.y = fb->cur_y + fb->cho_y;
		r.lx = r.ly = 1;
		framebuffer_update_region(fb, &r);
		//framebuffer_redraw(fb);
}

/* works on character cells */
void framebuffer_resize(struct framebuffer* fb, ssize_t new_lx, ssize_t new_ly)
{
		(void)fb; (void)new_lx; (void)new_ly;
}

