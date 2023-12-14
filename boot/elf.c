/* elf.c : Handles the loading of the ELF kernel image. */

#include "fixmem.h"
#include "basedefs.h"
#include "../elf.h"

//#define CRC32POLYREV 0xEDB88320 /* CRC-32 Polynom, umgekehrte Bitfolge */
//
//void crc_32(uint32_t* crc32, uint8_t* buffer, uint8_t length)
//{
//		uint8_t i;
//		while(length--) {
//				for(i = 0x80; i; i >>= 1) {
//						if(((*(uint8_t*)crc32 * i) & i) != (*buffer & i))
//								*crc32 = (*crc32 >> 1) ^ CRC32POLYREV;
//						else
//								*crc32 >>= 1;
//				}
//				buffer++;
//		}
//}

void putb(uint8_t bt)
{
		char st[3];
		for (int i = 0; i < 2; i++) {
				char c = i ? (bt & 0xf) : (bt >> 4);
				if (c > 9)
						c = 'a' + c - 10;
				else
						c = '0' + c;
				st[i] = c;
		}
		st[2] = 0;
		putstr(st);
}
//
//void putmem(void* mem, size_t ct)
//{
//		size_t lc = ct / 16;
//		put_nl();
//		for (size_t i = 0; i < lc; i++) {
//				char* p = mem;
//				put32((uint32_t)mem);
//				putstr(": ");
//				for (int j = 0; j < 16; j++) {
//						putb(p[j]);
//						if (j % 2 == 1)
//								putstr(" ");
//				}
//				putstr(" ");
//				p = mem;
//				for (int j = 0; j < 16; j++) {
//						char str[] = ".";
//						if (p[j] > 0x1f && p[j] < 0x7f)
//								str[0] = p[j];
//						putstr(str);
//				}
//				mem += 16;
//				put_nl();
//		}
//}

/* returns null if structure spans non-cont. pages */
void* elf_offset(struct page_range* pr, int prc, Elf64_Off o, size_t len)
{
		for (int i = 0; i < prc; i++) {
				size_t bc = pr[i].count * 4096;
				if (bc <= o) { /* no in this part */
						o -= bc;
						continue;
				}
				if (o + len <= bc) { /* same range */
						void* rv = (void*)(size_t)(pr[i].base + o);
						return rv;
				} else if (i + 1 < prc) {
						/* cont? */
						if (pr[i].base + bc == pr[i + 1].base) {
								bc += pr[i + 1].count * 4096;
								if (o + len <= bc)
										return (void*)(size_t)(pr[i].base + o);
								else
										return 0;
						} else
								return 0;
				} else
						return 0;
		}
		return 0;
}

/* elf64 format files */
uint64_t map_elf64(uint32_t pct, struct page_range* pr, int prc)
{
		Elf64_Addr rv;
		Elf64_Ehdr* hdr = (Elf64_Ehdr*)(size_t)pr->base;
		/*Elf64_Shdr* shdr; not needed */ size_t i;
		Elf64_Phdr* phdr;

		putstr("ELF64 mapping"); put32(pct); puts(" pages");

		/* perform basic checks */
		if (strncmp((const char*)hdr->e_ident, ELFMAG, SELFMAG) != 0)
				return -1;
		if (hdr->e_ident[EI_CLASS] != ELFCLASS64)
				return -1;
		if (hdr->e_ident[EI_DATA] != ELFDATA2LSB)
				return -1;
		if (hdr->e_ident[EI_VERSION] != EV_CURRENT)
				return -1;
		if (hdr->e_ident[EI_OSABI] != ELFOSABI_NONE)
				return -1;

		/* matching ELF64 found -> check for object file */
		if (hdr->e_type != ET_EXEC)
				return -1;
		if (hdr->e_machine != EM_X86_64)
				return -1;
		if (hdr->e_ehsize != sizeof(*hdr))
				return -1;
		if (!hdr->e_phnum) /* PH count */
				return -1;
		if (!hdr->e_shnum) /* section count */
				return -1;
		if (hdr->e_shentsize != sizeof(Elf64_Shdr))
				return -1;
		if (hdr->e_phentsize != sizeof(Elf64_Phdr))
				return -1;
		if (hdr->e_shstrndx == SHN_UNDEF)
				return -1; /* no strtab (needed for symbols) */

		rv = hdr->e_entry;

		/* interprete the program headers */
		/* (only suitable for specially prepared (aligned) images)
		 * created by the Makefile for the kernel.elf file. */
		for (i = 0; i < hdr->e_phnum; i++) {
				struct page_range pr2[32]; size_t pr2c = 32;
				phdr = elf_offset(pr, prc, hdr->e_phoff
						+ i * sizeof(Elf64_Phdr), sizeof(Elf64_Phdr));
				if (!phdr) {
						puts("Phdr spans multiple pages: Impelemnt copying.");
						while (1);
				}
				/* show its contents */
				switch (phdr->p_type) {
						case PT_LOAD: {
								putstr("FOFS ");
								put64(phdr->p_offset);
								putstr(" -> VMEM ");
								put64(phdr->p_vaddr);
								putstr(" SZ: ");
								put64(phdr->p_memsz);
								putstr(phdr->p_flags & PF_R ? " R" : "  ");
								putstr(phdr->p_flags & PF_W ? "W" : " ");
								putstr(phdr->p_flags & PF_X ? "X" : " ");
								put_nl();
								mm_perform_mapping(2, phdr->p_offset, pr, prc,
												phdr->p_vaddr, phdr->p_filesz, phdr->p_memsz, pr2, pr2c,
												phdr->p_flags & PF_X, phdr->p_flags & PF_W);
								break;
						}
						case PT_GNU_STACK:
									  /* maybe save stack align */
								break;
						default: /* ignore */
								break;
				}
		}

		/* TODO: and also preserve the symbol table */
		return rv;
}

/* elf32 format files */
uint64_t map_elf32(int mode, uint32_t pct, struct page_range* pr, int prc)
{
		Elf32_Addr rv;
		Elf32_Ehdr* hdr = (Elf32_Ehdr*)(size_t)pr->base;
		/*Elf32_Shdr* shdr; not needed*/ size_t i;
		Elf32_Phdr* phdr;

		putstr("ELF32 mapping"); put32(pct); puts(" pages");

		/* perform basic checks */
		if (strncmp((const char*)hdr->e_ident, ELFMAG, SELFMAG) != 0)
				return -1;
		if (hdr->e_ident[EI_CLASS] != ELFCLASS32)
				return -1;
		if (hdr->e_ident[EI_DATA] != ELFDATA2LSB)
				return -1;
		if (hdr->e_ident[EI_VERSION] != EV_CURRENT)
				return -1;
		if (hdr->e_ident[EI_OSABI] != ELFOSABI_NONE)
				return -1;

		/* matching ELF32 found -> check for object file */
		if (hdr->e_type != ET_EXEC)
				return -1;
		if (hdr->e_machine != EM_386)
				return -1;
		if (hdr->e_ehsize != sizeof(*hdr))
				return -1;
		if (!hdr->e_phnum) /* PH count */
				return -1;
		if (!hdr->e_shnum) /* section count */
				return -1;
		if (hdr->e_shentsize != sizeof(Elf32_Shdr))
				return -1;
		if (hdr->e_phentsize != sizeof(Elf32_Phdr))
				return -1;
		if (hdr->e_shstrndx == SHN_UNDEF)
				return -1; /* no strtab (needed for symbols) */

		rv = hdr->e_entry;

		/* interprete the program headers */
		/* (only suitable for specially prepared (aligned) images)
		 * created by the Makefile for the kernel.elf file. */
		for (i = 0; i < hdr->e_phnum; i++) {
				struct page_range pr2[32]; size_t pr2c = 32;
				bzero(pr2, sizeof(pr2));
				phdr = elf_offset(pr, prc, hdr->e_phoff
						+ i * sizeof(Elf32_Phdr), sizeof(Elf32_Phdr));
				if (!phdr) {
						puts("Phdr spans multiple pages: Impelemnt copying.");
						while (1);
				}
				/* show its contents */
				switch (phdr->p_type) {
						case PT_LOAD: {
								putstr("FOFS ");
								put32(phdr->p_offset);
								putstr(" -> VMEM ");
								put32(phdr->p_vaddr);
								putstr(" SZ: ");
								put32(phdr->p_memsz);
								putstr(phdr->p_flags & PF_R ? " R" : "  ");
								putstr(phdr->p_flags & PF_W ? "W" : " ");
								putstr(phdr->p_flags & PF_X ? "X" : " ");
								put_nl();
								mm_perform_mapping(mode, phdr->p_offset, pr, prc,
												phdr->p_vaddr, phdr->p_filesz, phdr->p_memsz, pr2, pr2c,
												phdr->p_flags & PF_X, phdr->p_flags & PF_W);
								break;
						}
						case PT_GNU_STACK:
									  /* maybe save stack align */
								break;
						default: /* ignore */
								break;
				}
		}

		/* TODO: and also preserve the symbol table */
		return rv;
}

uint64_t map_elf_image(int mode, uint32_t pct, struct page_range* pr, int prc)
{
		uint64_t rv;
//		for (int i = 0; i < prc; i++) {
//				put64(*(uint64_t*)pr[i].base);
//				put32(pr[i].count);
//				pct -= pr[i].count;
//				void* pt = pr[i].base; uint32_t bc = pr[i].count * 4096;
//				while (bc) {
//						putmem(pt, 128);
//						for (size_t i = 0; i < 0x0fffffff; i++);
//						bc -= 128;
//						pt += 128;
//				}
//				if (!pct)
//						break;
//		}
		/* we don't have to perform relocations as we deal with
		 * an executable image with program headers. We only
		 * have to (possibly) move the individual sections to
		 * different memory pages and map them accordingly. */
		if (mode == 2)
				rv = map_elf64(pct, pr, prc);
		else
				rv = map_elf32(mode, pct, pr, prc);
		return rv;
}

