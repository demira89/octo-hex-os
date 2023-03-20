/* base.c : Contains the C entry point of the stage2 boot loader
 *          which is going to provide basic paging and will load
 *          the kernel image to high memory.
 * */

#include <cpuid.h>
#include "fixmem.h"
#include "basedefs.h"

static void* const vmem = FM_VIDEO_MEMORY;
static void* vmc = FM_VIDEO_MEMORY;
void scrl()
{
		int i = 0;
		/* scroll */
		mem_cpy(vmem, vmem + 2 * 80, 24 * 2 * 80);
		vmc -= 2 * 80;
		/* and zero last line */
		for (char* c = vmem + 24 * 2 * 80; i < 80; i++)
				c[2 * i] = ' ';
}
void putc(char c)
{
		while (vmc - vmem >= (2 * 80 * 25))
	   			scrl();
		char* vm = vmc;
		*vm++ = c;
		*vm++ = 0x0f;
		vmc = (void*)vm;
}
void putstr(const char* str) /* simple wrap-around */
{
		while (*str)
	   			putc(*str++);
}
void unputc()
{
		if (vmc > vmem) {
				((char*)vmc)[-2] = ' ';
				vmc -= 2;
		}
}
void nputstr(const char* str, int n)
{
		while (*str && n--)
	   			putc(*str++);
}
void put_nl()
{
		size_t len = (size_t)(vmc - vmem) % 160;
		if (len) {
				for (size_t k = 0; k < 160 - len; k++)
						((char*)vmc)[k] = 0;
				vmc += 160 - len;
		} else
				vmc += 160;
}
void puts(const char* str)
{
		putstr(str);
		put_nl();
}
int strncmp(const char* p1, const char* p2, size_t num)
{
		register const unsigned char* s1 = (const unsigned char*)p1;
		register const unsigned char* s2 = (const unsigned char*)p2;
		register unsigned char c1, c2;
		register size_t n = num;
		
		while (n) {
				c1 = (unsigned char)*s1++;
				c2 = (unsigned char)*s2++;
				if (c1 == '\0' || (c1 != c2))
						return c1 - c2;
				else
						n--;
		}

		return c1 - c2;
}

void enable_sse()
{
		/* enable SSE if present */
		uint32_t eax, ebx, ecx, edx;
		__cpuid(1, eax, ebx, ecx, edx);
		if (edx & (1<< 25)) {
				asm("mov %%cr0, %%eax\n"
					"or $2, %%eax\n"
					"and $0xfffffffb, %%eax\n"
					"mov %%eax, %%cr0\n"
					: : : "eax"); /* clear em(2); set mp(1) bit */
				asm("mov %%cr4, %%eax\n"
					"or $0x00000600, %%eax\n"
					"mov %%eax, %%cr4\n"
					: : : "eax"); /* set oxfxsr osxmmexcpt */
		}
}

/* Entry point working on physical memory with all interrupts
 * disabled, a basic GDT and an invalid IDT. */
void base_entry()
{
		/* First check for 32, PAE and 64-bit */
		int mode = 0; /* 0=32, 1=PAE, 2=64 */
		unsigned int eax, ebx, ecx, edx;
		uint64_t ep;

		__cpuid(0, eax, ebx, ecx, edx);

		/* eax leaves */
		if (eax >= 1) {
				__cpuid(1, eax, ebx, ecx, edx);
				if (edx & (1 << 6)) /* PAE */
						mode = 1;
		}

		/* EFEAT leaves */
		__cpuid(0x80000000, eax, ebx, ecx, edx);
		if (eax >= 0x80000001) {
				__cpuid(0x80000001, eax, ebx, ecx, edx);
				if (edx & (1 << 29))
						mode = 2;
				else if (edx & (1 << 6)) /* PAE alternative */
						mode = 1;
		}

		if (mode == 0)
				puts("32-bit");
		else if (mode == 1)
				puts("PAE");
		else if (mode == 2)
				puts("64-bit");

		/* and initialize the mini-mm */
		mm_initialize(mode);

		/* Then load the kernel image & modules via BIOS functions */
		ep = fl_load_images(mode);

		/* select the video mode */
		void vga_init(int mode);
		vga_init(mode);

		/* enable paging (and LM?) and jump into
		 * the kernel */
		mm_enable_paging(mode, ep);
}
