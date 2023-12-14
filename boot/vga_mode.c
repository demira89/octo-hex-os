/* early.c : Implements the pre-loading of modulefiles using BIOS
 *           real-mode functions. */

#include "fixmem.h"
#include "basedefs.h"
#include "../limits.h"

struct vmd {
		char is_textmode; char gm_bts; /* 4/8/15/16/24/32 */
		char btpp;
		int32_t width, height; uint32_t bpsl;
		uint32_t fnt, txt; uint32_t ptr;
};
struct vmd video_mode = {1, 0, 0, 80, 25, 0, 0, (uint32_t)FM_VGA_TEST, 0};
void* vga_mem_ptr = (void*)FM_VIDEO_MEMORY;
/* used for paging the pmem */
void* vga_pmem = (void*)FM_VIDEO_MEMORY;
size_t vga_pmem_size = 0x8000; /* b8000-c0000 color TM */
const char* vga_font = NULL;

char call_int16(uint16_t ax)
{
		extern void rm_int16();
		extern uint16_t vga_ax;
		extern uint16_t vga_rv;
		vga_ax = ax;
		rm_int16();
		return (vga_rv & 0xff);
}

void call_int15(uint32_t mus)
{
		extern void rm_int15();
		extern uint16_t vga_cx;
		extern uint16_t vga_dx;
		vga_dx = mus & 0xffff;
		vga_cx = mus >> 16;
		rm_int15();
}

uint16_t call_vga_int10(uint16_t func, uint16_t sel, void* buf, uint16_t* bcd_regs)
{
		extern void rm_vga_int10();
		extern uint16_t vga_ax;
		extern uint16_t vga_bx;
		extern uint16_t vga_cx;
		extern uint16_t vga_dx;
		extern uint16_t vga_es;
		extern uint16_t vga_bp;
		extern uint16_t vga_di;
		extern uint16_t vga_rv;
		extern uint16_t vga_rv2;
		extern uint16_t vga_rv3;
		extern uint16_t vga_rv4;
		if ((size_t)buf > 0x100000)
				return -1;
		vga_es = (size_t)buf / 0x10;
		vga_di = (size_t)buf % 0x10;
		vga_ax = func;
		vga_cx = sel;
		if (bcd_regs) {
				vga_bx = bcd_regs[0];
				vga_cx = bcd_regs[1];
				vga_dx = bcd_regs[2];
		}
		rm_vga_int10();
		if (bcd_regs) {
				bcd_regs[0] = vga_rv2;
				bcd_regs[1] = vga_rv3;
				bcd_regs[2] = vga_rv4;
				if (func == 0x1130) {
						bcd_regs[0] = vga_es;
						bcd_regs[1] = vga_bp;
				}
		}
		return vga_rv;
}

typedef uint32_t far_ptr;
struct __attribute__ ((packed)) vbe_info {
		char sig[4];
		uint8_t minor_version;
		uint8_t major_version;
		far_ptr oem_name;
		uint32_t caps;
		far_ptr mode_ptr;
		uint16_t vmem;
		union {
				char res[236];
				struct __attribute__ ((packed)) {
						uint8_t minor_version;
						uint8_t major_version;
						far_ptr vendor_name;
						far_ptr product_name;
						far_ptr product_revision;
						uint16_t af_version;
						far_ptr acc_modes;
						char res3[216];
				} vbe2;
		};
		char res2[256];
};

struct __attribute__ ((packed)) vbe_modeinfo {
		uint16_t attr;
		uint8_t w1attr;
		uint8_t w2attr;
		uint16_t wgran;
		uint16_t wsiz;
		uint16_t w1seg;
		uint16_t w2seg;
		far_ptr wpos_fn;
		uint16_t bpsl;
		/* opt in 1.0-1.1 */
		uint16_t width;
		uint16_t height;
		uint8_t cwidth;
		uint8_t cheight;
		uint8_t memplanes;
		uint8_t btpp;
		uint8_t nbnks;
		uint8_t memtp;
		uint8_t bnksz;
		uint8_t nip; // -1
		uint8_t res; // 1 for vbe3
		/* vbe 1.2+ */
		uint8_t rdmsz;
		uint8_t rdfpos;
		uint8_t grmsz;
		uint8_t grfpos;
		uint8_t blmsz;
		uint8_t blfpos;
		uint8_t rsmsz;
		uint8_t rsfpos;
		uint8_t dcmi;
		/* vbe2+ */
		void* plfb;
		void* posm;
		uint16_t sosm; // KB
		/* vbe3 */
		uint16_t bpsl_lm;
		uint8_t nim_bm;
		uint8_t nim_lm;
		/* lm */
		uint8_t rdmsz_lm;
		uint8_t rdfpos_lm;
		uint8_t grmsz_lm;
		uint8_t grfpos_lm;
		uint8_t blmsz_lm;
		uint8_t blfpos_lm;
		uint8_t rsmsz_lm;
		uint8_t rsfpos_lm;
		/* pixclock */
		uint32_t pxclk;
		char res2[190];
};

//#ifndef __clang__
//STATIC_ASSERT(sizeof(struct vbe_info)==512, vbe_info_not_512_bytes);
//STATIC_ASSERT(sizeof(struct vbe_modeinfo)==256, vbe_modeinfo_not_256_bytes);
//#endif

#define yesno(q) ((q)?("yes"):("no "))

void draw_vga(void* ptr, const char* fnt, struct vbe_modeinfo* mi)
{
		size_t i, j, k, l;
		const char* str[8] = {"!!!!##12_.,!", "Hello World!",
		"123456789", "ANTIDOTE", "\"§$%&/&/()=", "\t\b\023\001", "Aoijb9erh45", "ZT  iojwe =====+"};
		const char* cr;
		for (l = 0; l < 8; l++) {
				void* mem = ptr + l * 16 * mi->bpsl_lm;
				for (i = 0; i < 16; i++) {
						void* mp = mem + i * mi->bpsl_lm;
						const char* s2 = str[l];
						for (k = 0; k < mi->bpsl_lm * 8 / 8 / mi->btpp; k++) {
								if (!*s2)
										break;
								cr = fnt + ((uint32_t)*(uint8_t*)s2 * 16);
								s2++;
								for (j = 0; j < 8; j++) {
										/* put up to 8 white pixels */
										int set = ((cr[i] & (1 << (7 - j))) != 0);
										if (mi->btpp == 16) {
												if (set)
														*(uint16_t*)mp = 0xffff;
												//else
												//		*(uint16_t*)mp = 0x0000;
												mp += 2;
										} else if (mi->btpp == 24) {
												if (set)
														*(uint16_t*)mp = 0xffff;
												//else
												//		*(uint16_t*)mp = 0x0000;
												mp += 2;
												if (set)
														*(uint8_t*)mp = 0xff;
												//else
												//		*(uint8_t*)mp = 0x00;
												mp++;
										} else if (mi->btpp == 32) {
												if (set)
														*(uint32_t*)mp = 0x00ffffff;
												//else
												//		*(uint32_t*)mp = 0x00000000;
												mp += 4;
										} else { /* 8 or other */
												if (set)
														*(uint8_t*)mp = 0x0f;
												//else
												//		*(uint8_t*)mp = 0xf0;
												mp++;
										}
								}
						}
				}
		}
}

int vga_list_modes(int base_num, uint16_t* ml, int test)
{
		int ct = base_num, ln = 0; char *font, *txt; uint16_t r0[3];
		if (!ml) {
				puts("none");
				return 0;
		}
		/* save the font (returns es:bp) (rm accessible stack) */
		r0[0] = 0x0600;
		call_vga_int10(0x1130, 0, NULL, r0);
		vga_font = font = (char*)(((uint32_t)r0[0] << 4) + (r0[1] & 0xffff));
		/*memcpy(font, ft, 4096);*/
		if (test) {
				txt = FM_VGA_TEST;
				bzero(txt, 8000);
		}
		puts("NMBR VGA  WIDTHxHGT RGB TM  SUP LFB BPP BPSL");
		while (*ml != 0xffff) {
				char buf[256];
				bzero(buf, 256);
				if (call_vga_int10(0x4f01, *ml, buf, NULL) == 0x004f) {
						struct vbe_modeinfo* mi = (struct vbe_modeinfo*)buf;
						nput32(ct++, 3);
						putstr(": ");
						put16s(*ml);
						nput32(mi->width, 4);
						putstr("x");
						nput32(mi->height, -4);
						putstr(" ");
						nput32(mi->rdmsz, 0);
						nput32(mi->grmsz, 0);
						nput32(mi->blmsz, 0);
						putstr(" ");
						putstr(yesno(!(mi->attr & 16)));
						putstr(" ");
						putstr(yesno(mi->attr & 1));
						putstr(" ");
						putstr(yesno(mi->attr & 128));
						putstr(" ");
						nput32(mi->btpp, 3);
						putstr(" ");
						nput32(mi->bpsl, 4);
						put_nl();
						if (ct % 24 == 0) {
								/* pause for display */
								puts("--More--");
								call_int16(0);
								put_nl();
								puts("NMBR VGA WIDTHxHGT RGB TM  SUP LFB BPP BPSL");
						}
						if (test && (mi->attr & 128)) { /* test LFB only */
								uint16_t regs[3] = {0, 0, 0};
								size_t i; void* mpt;
								/* save textmode text */
								mem_cpy(txt + ln * 160, (void*)0xb8000, 4000);
								if (ln++ == 4000) {
										mem_cpy(txt, txt + 160, 7840);
										ln--;
								}
								/* display window info */
								putstr("window1 at ");
								put32(mi->w1seg * 0x10);
								put_nl();
								putstr("window2 at ");
								put32(mi->w2seg * 0x10);
								put_nl();
								putstr("window size: ");
								put32(mi->wsiz * 1024);
								put_nl();
								putstr("window granularity: ");
								put32(mi->wgran * 1024);
								put_nl();
								putstr("scrmsz: ");
								nput32((uint32_t)mi->bpsl * (uint32_t)mi->height, 0);
								put_nl();
								putstr("scrmsz_l: ");
								nput32((uint32_t)mi->bpsl_lm * (uint32_t)mi->height, 0);
								put_nl();
								putstr("LFB at ");
								put32((uint32_t)mi->plfb);
								put_nl();
								/* switch to mode */
								puts("switching mode...");
								call_int15(500000); // 500 ms
								//for (i = 0; i < UINT_MAX / 8; i++);
								if (mi->attr & 128)
										regs[0] = *ml | 0x4000;
								else
										regs[0] = *ml;
								if (call_vga_int10(0x4f02, 0, NULL, regs) != 0x004f) {
										puts("Unable to switch modes");
										*ml = 0; ct--;
										continue;
								}
								/* TEST the framebuffer */
								video_mode.bpsl = mi->bpsl_lm;
								video_mode.gm_bts = mi->btpp;
								video_mode.btpp = rdiv(mi->btpp, 8);
								video_mode.is_textmode = 0;
								video_mode.width = mi->width;
								video_mode.height = mi->height;
								if (mi->attr & 128)
										mpt = vga_mem_ptr = mi->plfb;
								else {
										mpt = vga_mem_ptr = (void*)((size_t)mi->w1seg * 0x10);
										/* check window size */
										video_mode.bpsl = mi->bpsl;
										if (mi->wsiz * 1024 < video_mode.height * mi->bpsl)
												video_mode.height = mi->wsiz * 1024 / mi->bpsl;
								}
								//for (size_t k = 0; k < 250; k++) {
								//		struct framebuffer fb;
								//		framebuffer_initialize(&fb, font, txt,
								//						80, 50, k * 1, 0 /* pxl_ofs_xy*/,
								//						0, 0, /* char_ofs_xy*/
								//						80, 50/* char_width_xy*/);
								//		while (inb(0x3da) & 0x08);
								//		while (!(inb(0x3da) & 0x08));
								//		framebuffer_redraw(&fb);
								//		for (i = 0; i < UINT_MAX / 1000; i++);
								//}
								vga_mem_ptr = (void*)0xb8000;
								/* fill graphics */
								uint32_t val = 0x310f00ff;
								for (size_t k = 0; k < 10/*UINT_MAX*/; k++) {
										char* ptr = (char*)mpt;
										for (i = 0; i < video_mode.height * video_mode.bpsl; i += 4) {
												*(uint32_t*)(ptr + i) = val;
										}
										draw_vga(ptr, font, mi);
										//for (i = 0; i < UINT_MAX / 20; i++);
										call_int15(100000); // 100 ms
										val = val * 0x42936 - val % 34;
								}
								/* wait */
								//for (i = 0; i < UINT_MAX / 4; i++);
								call_int15(500000); // 500 ms
								/* restore mode */
								call_vga_int10(0x0003, 0, NULL, NULL);
								mem_cpy((void*)0xb8000, txt + (ln - 1) * 160, 4000);
						}
				} else /* remove nonviable modes */
						*ml = 0;
				ml++;
		}
		if (ct == base_num)
				puts("none");
		return ct - base_num;
}

int switch_to_mode(uint16_t m)
{
		char buf[256], txt[4000];
		struct vbe_modeinfo* mi = (struct vbe_modeinfo*)buf;
		putstr("switching to mode ");
		put16s(m);
		put_nl();
		/* get the description */
		if (call_vga_int10(0x4f01, m, buf, NULL) == 0x004f) {
				if (mi->btpp != 4 || mi->attr & 128) {
						uint16_t regs[3] = {0, 0, 0};
						char* txt2; size_t nx, ny;
						/* save the text */
						mem_cpy(txt, (void*)0xb8000, 4000);
						/* switch the mode */
						if (mi->attr & 128)
								regs[0] = m | 0x4000;
						else
								regs[0] = m;
						if (call_vga_int10(0x4f02, 0, NULL, regs) != 0x004f) {
								puts("Unable to switch modes");
								return 0;
						}
						/* set up the mode description */
						video_mode.bpsl = mi->bpsl_lm;
						video_mode.gm_bts = mi->btpp;
						video_mode.btpp = rdiv(mi->btpp, 8);
						video_mode.is_textmode = 0;
						video_mode.width = mi->width;
						video_mode.height = mi->height;
						if (mi->attr & 128) {
								vga_mem_ptr = mi->plfb;
								vga_pmem = mi->plfb;
								vga_pmem_size = (mi->bpsl_lm * video_mode.height) * (1 + mi->nim_lm);
								if (!vga_pmem_size)
										vga_pmem_size = mi->bpsl * video_mode.height * (1 + mi->nim_lm);
						} else {
								vga_mem_ptr = (void*)((size_t)mi->w1seg * 0x10);
								/* check window size */
								video_mode.bpsl = mi->bpsl;
								if (mi->wsiz * 1024 < video_mode.height * mi->bpsl)
										video_mode.height = mi->wsiz * 1024 / mi->bpsl;
								vga_pmem = vga_mem_ptr;
								vga_pmem_size = mi->wsiz * 1024;
						}
						/* create a new text buffer */
						nx = video_mode.width / 8;
						ny = video_mode.height / 16; /* maybe history later on */

						txt2 = FM_VGA_TEST; /* FIXME: use allocator */
						bzero(txt2, 2 * nx * ny);
						//txt2 = kzalloc(2 * nx * ny); /* or die alloc */

						/* copy the buffer */
						for (size_t i = 0; i < min(ny, 25); i++)
								mem_cpy(txt2 + 2 * i * nx, txt + 2 * i * 80, min(80, nx));
						/* create the framebuffer */
						return -1;
// TODO: move into struct & kernel initfunc
//						framebuffer_initialize(&fb_initial, vga_font, txt2,
//										nx, ny, 0, 0 /* pxl_ofs_xy*/,
//										0, 0, /* char_ofs_xy*/
//										nx, ny/* char_width_xy*/);
//						/* update the console info */
//						extern void kio_fb_resize();
//						kio_fb_resize();
//						puts("done setting up the framebuffer");
//						framebuffer_redraw(&fb_initial);
//						return 1;
				} else {
						puts("4-bit modes without LFB are not supported");
						return 0;
				}
		} else
				return 0;
}

const char* farchar(far_ptr p)
{
		return (char*)(((p & 0xffff0000) >> 12) + (p & 0xffff));
}

void vga_init(int mode)
{
		char vg_buf[512] = "VBE2"; int test = 0;
		puts("VGA mode detection:");
		puts("Test each mode (y/n)?");
		do {
				char c = call_int16(0);
				if (c == 'y') {
						test = 1;
						break;
				} else if (c == 'n')
						break;
		} while (1);

		/* enable SSE if present */
		extern void enable_sse();
		enable_sse();

		bzero(vg_buf + 4, 508);
		if (call_vga_int10(0x4f00, 0, vg_buf, NULL) != 0x004f) {
				puts("VESA BIOS extensions not supported");
				while (1);
				return;
		}
		struct vbe_info* vi = (struct vbe_info*)vg_buf; size_t ml_cap = 0x100;
		uint16_t* mode_list = (uint16_t*)farchar(vi->mode_ptr); uint16_t m;
		int ml_base = 1, ml_ct = 0, num;
		/* fill the mode list 0x100-0x1ff and others */
		if (mode_list)
				while (*mode_list++ != 0xffff)
						ml_cap++;
		mode_list = FM_VGA_MODELIST; /* POINTER to fixed memory */
		for (m = 0x100; m < 0x200; m++)
				mode_list[m - 0x100] = m;
		/* now add the other entries */
		m = 0x100;
		for (uint16_t* mp = (uint16_t*)farchar(vi->mode_ptr); mp != NULL; mp++) {
				if (*mp == 0xffff)
						break;
				if (*mp >= 0x200 || *mp < 0x100)
						mode_list[m++] = *mp;
		}
		mode_list[m] = 0xffff;
		/* print the info */
		putstr("Signature: ");
		nputstr(vi->sig, 4);
		put_nl();
		putstr("VBE version: ");
		nput32(vi->major_version, 0);
		putstr(".");
		nput32(vi->minor_version, 0);
		put_nl();
		putstr("OEM: ");
		putstr(farchar(vi->oem_name));
		put_nl();
		putstr("Video memory: ");
		nput32(vi->vmem * 64 / 1024, 0);
		putstr("M");
		put_nl();
		putstr("Capabilities: ");
		if (vi->caps & 1)
				putstr("8-Bit DAC ");
		if (vi->caps & 2)
				putstr("non-VGA ");
		if (vi->caps & 4)
				putstr("pDAC w/ blank ");
		if (vi->caps & 8)
				putstr("VBE/AF ");
		if (vi->caps & 16)
				putstr("EDA for FB ");
		if (vi->caps & 32)
				putstr("HW cursor ");
		if (vi->caps & 64)
				putstr("HW clipping ");
		if (vi->caps & 128)
				putstr("Transparent BitBLT");
		put_nl();
		putstr("hexval: ");
		put32(vi->caps);
		put_nl();
		if (vi->major_version >= 2) {
				putstr("OEM software version: ");
				nput32(vi->vbe2.major_version, 0);
				putstr(".");
				nput32(vi->vbe2.minor_version, 0);
				put_nl();
				putstr("Vendor: ");
				putstr(farchar(vi->vbe2.vendor_name));
				put_nl();
				putstr("Product: ");
				putstr(farchar(vi->vbe2.product_name));
				put_nl();
				putstr("Product rev: ");
				putstr(farchar(vi->vbe2.product_revision));
				put_nl();
				//for (size_t i = 0; i < UINT_MAX / 3; i++);
				call_int15(1000000); // 1000 ms
				if (vi->caps & 8) {
						putstr("VBE/AF version: ");
						nput32(vi->vbe2.af_version >> 8, 0);
						putstr(".");
						nput32(vi->vbe2.af_version & 0xff, 0);
						put_nl();
						puts("Accelerated video modes:");
						ml_ct = vga_list_modes(ml_base, (uint16_t*)farchar(vi->vbe2.acc_modes), test);
						ml_base += ml_ct; /* distinguish accelerated modes */
				}
		} else	
				call_int15(1000000); // 1000 ms
				//for (size_t i = 0; i < UINT_MAX / 3; i++);
		puts("Video modes:");
		ml_ct += vga_list_modes(ml_base, mode_list, test);
read:
		num = 0;
		putstr("please select mode to use (1-");
		nput32(ml_ct, 0);
		putstr("): ");
		do {
				char c = call_int16(0);
				if (c >= '0' && c <= '9') {
						char* sr = " ";
						num = 10 * num + (c - '0');
						sr[0] = c;
						putstr(sr);
				} else if (c == '\n' || c == '\r') {
						put_nl();
						break;
				} else if (c == '\b') {
						num /= 10;
						unputc();
				}
		} while (1);
		/* get the mode number */
		if (num > 0 && num < ml_base) {
				uint16_t* mp = (uint16_t*)farchar(vi->vbe2.acc_modes);
				/* accelerated mode */
				m = mp[num - 1];
		} else if (num == 0)
				return;
		else if (num <= ml_ct) {
				uint16_t* mp = mode_list;
				/* regular mode in own buffer */
				while (num > ml_base) {
						if (*mp++)
								num--;
				}
				while (!*mp)
						mp++;
				m = *mp;
		} else {
				putstr("The value ");
				nput32(num, 0);
				puts(" is out of range");
				put_nl();
				goto read;
		}
		/* switch to the selected mode */
		if (!switch_to_mode(m))
				goto read;

		/* now map the memory */
		void* ptr2 = mm_register_video_memory(mode,
						(uint32_t)vga_pmem, (uint32_t)vga_pmem_size);
		/* and copy the video_mode structure */
		video_mode.fnt = (uint32_t)vga_font;
		video_mode.txt = (uint32_t)FM_VGA_TEST;
		video_mode.ptr = (uint32_t)ptr2;
		mem_cpy(FM_VIDEO_MODE, &video_mode, sizeof(video_mode));
}

