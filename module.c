/* module.c : Implements the loading of in-memory ELF modulefiles
 *            and the linking for enabling their execution
 * */

#include "limits.h"
#include "kernel.h"
#include "elf.h"
#include "module.h"

/* lsmod: Module, Size, Used by
 * modprobe: load module + dep.
 * modprobe -r: unload module + autodep.
 * insmod: load module if dep. present
 * rmmod: unload module
 * */
#ifdef MEMBABBLE
#define mbprintf printf
#else
#define mbprintf noprintf
#endif
#ifdef SYMBABBLE
#define sbprintf printf
#else
#define sbprintf noprintf
#endif

/* int init_module() and void cleanup_module() needed */

typedef int (*mod_init)();
typedef void (*mod_cleanup)();

struct module_info
{
		char mi_name[20];
		mod_init mi_init;
		mod_cleanup mi_cleanup;
		void* vm_ofs[4];
		size_t sz_secs[4];
};

struct module_info_container
{
		struct module_info* ptrs[7];
		struct module_info_container* next;
};

static struct module_info_container mic_def = {{NULL}, NULL};
enum mt_sec
{
		MT_SEC_TEXT = 0,
		MT_SEC_DATA = 1,
		MT_SEC_RODATA = 2,
		MT_SEC_BSS = 3
};
static struct module_table
{
		void* vm_ofs[4];
		size_t sz_secs[4];
		struct module_info_container* mt_mic;
} mod_tbl = {
		{ (void*)0xa0000000, (void*)0xb0000000,
		(void*)0xc0000000, (void*)0xd0000000 },
		{ 0, 0, 0, 0 }, &mic_def };

enum elferr
{
		ELF_OK = 0,
		ELF_WRONG_MAGIC = 1,
		ELF_NOT_CLASS32,
		ELF_NOT_LE,
		ELF_NOMEM,
		ELF_VERSION_NOT_SUPPORTED,
		ELF_WRONG_OSABI,
		ELF_NOT_REL,
		ELF_NOT_386,
		ELF_INCOMPATIBLE_HEADER,
		ELF_CONTAINS_PROG_HEADERS,
		ELF_NO_SECTIONS_DEFINED,
		ELF_WRONG_SHDR_SIZE,
		ELF_NO_SECTION_STRTAB,
		ELF_SECTION_RWX,
		/* parse function errors */
		ELF_GSTAB_ALREADY_PRESENT,
		ELF_STRING_PARSE_NUMBER,
		ELF_PARSE_FORMAT_NOT_NM,
};

struct symbol_list
{
		struct {
				void* vma;
				char* name; /* strdup */
				char type;
		} entries[64];
		struct symbol_list* next;
} *gs_lst = NULL;

char* elf_fetch_string(Elf32_Ehdr* hdr, Elf32_Shdr* shdr, Elf32_Half strtab, Elf32_Word str)
{
		if (!shdr[strtab].sh_size)
				return "";
		if (shdr[strtab].sh_type != SHT_STRTAB)
				return "no STRTAB referenced";
		if (str >= shdr[strtab].sh_size)
				return "STRTAB entry out of range";
		return ((char*)hdr + shdr[strtab].sh_offset) + str;
}

void elf_dump_symtab(Elf32_Ehdr* hdr, Elf32_Shdr* shdr, Elf32_Half symtab)
{
		void* ptr = ((void*)hdr + shdr[symtab].sh_offset);
		size_t i, ct = shdr[symtab].sh_size / shdr[symtab].sh_entsize;
		if (ct <= 1)
				return;
		printf("dumping symtab with %lu entries\n", ct);
		printf("   Num:    Value  Size Type    Bind   Section  Name\n");
		for (i = 1; i < ct; i++) {
				Elf32_Sym* s = (ptr + i * shdr[symtab].sh_entsize);
				char *name = "STN_UNDEF", *sec, *stp, *stb;
				if (s->st_name)
						name = elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name);
				if (ELF32_ST_TYPE(s->st_info) == STT_NOTYPE)
						stp = "NOTYPE ";
				else if (ELF32_ST_TYPE(s->st_info) == STT_OBJECT)
						stp = "OBJECT ";
				else if (ELF32_ST_TYPE(s->st_info) == STT_FUNC)
						stp = "FUNC   ";
				else if (ELF32_ST_TYPE(s->st_info) == STT_SECTION)
						stp = "SECTION";
				else if (ELF32_ST_TYPE(s->st_info) == STT_FILE)
						stp = "FILE   ";
				else if (ELF32_ST_TYPE(s->st_info) >= 13/*STT_LOPROC*/ &&
						ELF32_ST_TYPE(s->st_info) <= 15/*STT_HIPROC*/)
						stp = "PROC   ";
				else
						stp = "UNKNOWN";
				if (ELF32_ST_BIND(s->st_info) == STB_LOCAL)
						stb = "LOCAL ";
				else if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL)
						stb = "GLOBAL";
				else if (ELF32_ST_BIND(s->st_info) == STB_WEAK)
						stb = "WEAK  ";
				else if (ELF32_ST_BIND(s->st_info) >= 13 &&
						ELF32_ST_BIND(s->st_info) <= 15)
						stb = "PROC  ";
				else
						stb = "UNK   ";
				if (s->st_shndx == SHN_ABS)
						sec = "ABS     ";
				else if (s->st_shndx == SHN_COMMON)
						sec = "COMMON  ";
				else if (s->st_shndx == SHN_UNDEF)
						sec = "UNDEF   ";
				else
						sec = elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[s->st_shndx].sh_name);
				printf("%6lu: %08u %5u %s %s %8.8s %.13s\n", i, s->st_value, s->st_size,
					stp, stb, sec, name);
		}
}

#define R_386_NONE 0
#define R_386_32 1
#define R_386_PC32 2
#define R_386_GOT32 3
#define R_386_PLT32 4
#define R_386_COPY 5
#define R_386_GLOB_DAT 6
#define R_386_JMP_SLOT 7
#define R_386_RELATIVE 8
#define R_386_GOTOFF 9
#define R_386_GOTPC 10

const char* elf_rel_type_string(Elf32_Word t)
{
		switch (t) {
		case R_386_NONE:
				return "R_386_NONE";
		case R_386_32:
				return "R_386_32";
		case R_386_PC32:
				return "R_386_PC32";
		case R_386_GOT32:
				return "R_386_GOT32";
		case R_386_PLT32:
				return "R_386_PLT32";
		case R_386_COPY:
				return "R_386_COPY";
		case R_386_GLOB_DAT:
				return "R_386_GLOB_DAT";
		case R_386_JMP_SLOT:
				return "R_386_JMP_SLOT";
		case R_386_RELATIVE:
				return "R_386_RELATIVE";
		case R_386_GOTOFF:
				return "R_386_GOTOFF";
		case R_386_GOTPC:
				return "R_386_GOTPC";
		default:
				return "UNKNOWN";
		}
}

void elf_dump_rel(Elf32_Ehdr* hdr, Elf32_Shdr* shdr, Elf32_Half rel)
{
		void* ptr = ((void*)hdr + shdr[rel].sh_offset), *sptr, *stptr;
		size_t i, ct = shdr[rel].sh_size / shdr[rel].sh_entsize;
		Elf32_Shdr* stb;
		if (!ct)
				return;

		/* get the associated section and symbol table */
		sptr = (void*)hdr + shdr[shdr[rel].sh_info].sh_offset;
		stptr = (void*)hdr + shdr[shdr[rel].sh_link].sh_offset;
		stb = shdr + shdr[rel].sh_link;

		printf("dumping relocations with %lu entries\n", ct);
		printf("relocations apply to section %s\n", elf_fetch_string(hdr,
			shdr, hdr->e_shstrndx, shdr[shdr[rel].sh_info].sh_name));
		printf("   Num:   Offset Type              Field SyNdx SymbolName\n");
		for (i = 0; i < ct; i++) {
				/* only access addend if SHT_RELA */
				Elf32_Rela* r = (ptr + i * shdr[rel].sh_entsize);
				Elf32_Sym* s = (stptr + ELF32_R_SYM(r->r_info) * stb->sh_entsize);
				const char* sn; char dat[] = "DAT: ........";

				if (s->st_name)
						sn = elf_fetch_string(hdr, shdr, stb->sh_link, s->st_name);
				else if ((shdr[s->st_shndx].sh_flags & SHF_WRITE) == 0
						&& shdr[s->st_shndx].sh_flags & SHF_ALLOC
						&& (shdr[s->st_shndx].sh_flags & SHF_EXECINSTR) == 0) {
						/* rodata-like R_386_32 */
						const char* c = (void*)hdr + shdr[s->st_shndx].sh_offset;
						uint32_t of = *(uint32_t*)(sptr + r->r_offset), j;
						for (j = 0; j < 8; j++)
								if (isprint(c[of + j]))
										dat[j + 5] = c[of + j];
								else
										dat[j + 5] = '.';
						sn = dat;
				} else
						sn = elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[s->st_shndx].sh_name);

				printf("%6lu: %8x %14s %8x %5u %.13s\n", i, r->r_offset,
					elf_rel_type_string(ELF32_R_TYPE(r->r_info)),
					*(uint32_t*)(sptr + r->r_offset), ELF32_R_SYM(r->r_info), sn);
		}
}

void elf_relocate_section(Elf32_Ehdr* hdr, Elf32_Shdr* shdr, Elf32_Half rel)
{
		void* ptr = ((void*)hdr + shdr[rel].sh_offset), *sptr, *stptr;
		size_t i, ct = shdr[rel].sh_size / shdr[rel].sh_entsize;
		Elf32_Shdr* stb;
		if (!ct)
				return;

		/* get the associated section and symbol table */
		sptr = (void*)shdr[shdr[rel].sh_info].sh_addr; /* vma */
		stptr = (void*)hdr + shdr[shdr[rel].sh_link].sh_offset;
		stb = shdr + shdr[rel].sh_link;

		sbprintf("%lu relocations apply to section %s\n", ct, elf_fetch_string(hdr,
			shdr, hdr->e_shstrndx, shdr[shdr[rel].sh_info].sh_name));
		for (i = 0; i < ct; i++) {
				/* only access addend if SHT_RELA */
				Elf32_Addr val = 0;
				Elf32_Rela* r = (ptr + i * shdr[rel].sh_entsize);
				void** pptr = (void**)(sptr + r->r_offset);
				Elf32_Sym* s = (stptr + ELF32_R_SYM(r->r_info) * stb->sh_entsize);
				if (ELF32_R_SYM(r->r_info) == 0/*STN_UNDEF*/)
						s = NULL;

				if (s && !s->st_value) {
						cprintf(KFMT_ERROR, "tried to relocate reference to undefined symbol\n");
						while (1);
				} else
						val = s->st_value;

				/* now perform the relocation on *pptr */
				if (shdr[rel].sh_type == SHT_RELA) {
						cprintf(KFMT_ERROR, "RELA relocations not implemented\n");
						while (1);
				} else {
						switch (ELF32_R_TYPE(r->r_info)) {
						case R_386_NONE: /* do nothing */
								break;
						case R_386_32: /* S+A */
								*pptr = (size_t)val + *pptr;
								break;
						case R_386_PC32: /* S + A - P */
								*pptr = (size_t)val + *pptr - (size_t)pptr;
								break;
						case R_386_COPY: /* do nothing? */
								break;
						case R_386_GLOB_DAT: /* set GOT values to S */
								*pptr = (void*)val;
								break;
						case R_386_JMP_SLOT: /* modify PLT-entry at r->offset */
						case R_386_GOT32:
						case R_386_PLT32:
						case R_386_RELATIVE:
						case R_386_GOTOFF:
						case R_386_GOTPC:
						default:
								cprintf(KFMT_ERROR, "relocation type not implemented\n");
								while (1);
						}
				}
		}
}

const char* get_section_type_string(Elf32_Word tp)
{
		if (tp == SHT_PROGBITS)
				return "PROGBITS";
		else if (tp == SHT_SYMTAB)
				return "SYMTAB";
		else if (tp == SHT_DYNSYM)
				return "DYNSYM";
		else if (tp == SHT_STRTAB)
				return "STRTAB";
		else if (tp == SHT_RELA)
				return "RELA";
		else if (tp == SHT_HASH)
				return "HASH";
		else if (tp == SHT_DYNAMIC)
				return "DYNAMIC";
		else if (tp == SHT_NOTE)
				return "NOTE";
		else if (tp == SHT_NOBITS)
				return "NOBITS";
		else if (tp == SHT_REL)
				return "REL";
		else if (tp == SHT_SHLIB)
				return "SHLIB";
		else if (tp >= SHT_LOPROC && tp <= SHT_HIPROC)
				return "PROC";
		else if (tp >= SHT_LOUSER && tp <= SHT_HIUSER)
				return "USER";
		else
				return "RESERVED";
}

void elf_store_global_symbol(const char* name, void* vma, char type, int is_weak)
{
		struct symbol_list* sl = gs_lst;
		size_t i = 0; int wrt = 0;
		if (!sl)
				return;

		if (!name) {
				cprintf(KFMT_WARN, "elf_store_global_symbol called for symbol "
								"of type %c with name \"\" at %p\n", type, vma);
		}

		/* search for existng definition and give an offset to which to write to */
		while (sl) {
				if (!sl->entries[i].name)
						break;
				if (strcmp(name, sl->entries[i].name) == 0) {
						/* found a first match */
						if (sl->entries[i].type == type) {
								if (is_weak) /* use existing symbol definition */
										return;
								cprintf(KFMT_WARN, "overwriting symbol %s defined at %p with "
									"symbol at %p\n", sl->entries[i].name, sl->entries[i].vma, vma);
								kfree(sl->entries[i].name); /* just in case */
								wrt = 1;
								break; /* only overwrite full matches */
						}
				}
				if (++i == 64) {
						if (sl->next) {
								sl = sl->next;
								i = 0;
						} else {
								/* allocate space for the next one and quit the loop */
								i = 0;
								sl = sl->next = kmalloc(sizeof(struct symbol_list));
								if (!sl)
										return;
								sl->next = NULL; /* IMPORTANT! as kmalloc != cmalloc */
								break;
						}
				}
		}

		/* now write the new definition */
		sl->entries[i].name = strdup(name);
		sl->entries[i].type = type;
		sl->entries[i].vma = vma;
		/* and null-terminate if last */
		if (++i < 64 && !wrt) {
				sl->entries[i].name = NULL;
				sl->entries[i].vma = NULL;
		}
}

Elf32_Addr elf_locate_global_symbol(const char* name, char type)
{
		struct symbol_list* sl = gs_lst;
		size_t i = 0;
		if (!sl)
				return (Elf32_Addr)NULL;

		while (sl) {
				if (!sl->entries[i].name)
						break; /* end of list */
				if (strcmp(sl->entries[i].name, name) == 0) {
						/* found a match candidate */
						if (sl->entries[i].type == type) /* exact match */
								return (Elf32_Addr)sl->entries[i].vma;
						else if (sl->entries[i].type == 'B' && type == 'D')
								return (Elf32_Addr)sl->entries[i].vma; /* compatible */
				}

				if (++i == 64) {
						sl = sl->next;
						i = 0;
				}
		}

		/* no match found */
		return (Elf32_Addr)NULL;
}

void* locate_module_function(char* name)
{
		Elf32_Addr rv;
		rv = elf_locate_global_symbol(name, 'T');
		if (!rv)
				rv = elf_locate_global_symbol(name, 'D');
		if (!rv) {
				struct symbol_list* sl = gs_lst;
				size_t i = 0;
				while (sl) {
						printf("%s %c\n", sl->entries[i].name, sl->entries[i].type);
						if (++i == 64) {
								sl = sl->next;
								i = 0;
						}
				}
		}
		return (void*)rv;
}

void store_module_info(struct module_info* mi)
{
		struct module_info_container* mc;
		mc = mod_tbl.mt_mic;
		do {
				for (int i = 0; i < 7; i++)
						if (!mc->ptrs[i]) {
								mc->ptrs[i] = kmalloc(sizeof(struct module_info));
								if (!mc->ptrs[i])
										return;
								memcpy(mc->ptrs[i], mi, sizeof(struct module_info));
								for (int j = 0; j < 4; j++)
										mod_tbl.sz_secs[j] += mi->sz_secs[j];
								return;
						}
				if (!mc->next) {
						mc->next = kmalloc(sizeof(struct module_info_container));
						if (mc->next)
								bzero(mc->next, sizeof(struct module_info_container));
				}
		} while ((mc = mc->next));
}

void list_modules()
{
		struct module_info_container* mc;
		mc = mod_tbl.mt_mic;
		printf("Module                     Size\n");
		do {
				for (int i = 0; i < 7; i++)
						if (mc->ptrs[i]) {
								struct module_info* mi = mc->ptrs[i];
								printf("%20s %10lu\n", mi->mi_name, mi->sz_secs[0] +
											mi->sz_secs[1] + mi->sz_secs[2] + mi->sz_secs[3]);
						} else
								break;
		} while ((mc = mc->next));
		printf("TOTAL                %10lu\n", mod_tbl.sz_secs[0] +
						mod_tbl.sz_secs[1] + mod_tbl.sz_secs[2] + mod_tbl.sz_secs[3]);
}

void list_module_info(const char* name)
{
		struct module_info_container* mc;
		mc = mod_tbl.mt_mic;
		do {
				for (int i = 0; i < 7; i++)
						if (mc->ptrs[i]) {
								struct module_info* mi = mc->ptrs[i];
								if (strcmp(mi->mi_name, name) == 0) {
										printf("module %s resides at:\n", name);
										printf("SECTION     .text    .data  .rodata     .bss\n");
										printf("OFFSET   %p %p %p %p\n", mi->vm_ofs[0],
												mi->vm_ofs[1], mi->vm_ofs[2], mi->vm_ofs[3]);
										printf("SIZE     %8lu %8lu %8lu %8lu\n", mi->sz_secs[0],
												mi->sz_secs[1], mi->sz_secs[2], mi->sz_secs[3]);
										printf("with the two functions\n");
										printf("module_init     at %p and\n", mi->mi_init);
										printf("module_cleanup  at %p\n", mi->mi_cleanup);
										return;
								}
						} else
								break;
		} while ((mc = mc->next));
		printf("modinfo: ERROR: Module %s not found.\n", name);
}

const char* elf_get_closest_symbol(void* ptr, size_t* offset)
{
		struct symbol_list* sl = gs_lst;
		size_t i = 0; const char* rv = ""; void* base = NULL;
		if (!sl) {
				*offset = (size_t)ptr;
				return "";
		}

		while (sl) {
				if (sl->entries[i].vma <= ptr && sl->entries[i].vma > base) {
						/* found a new one */
						rv = sl->entries[i].name;
						base = sl->entries[i].vma;
						if (base == ptr) /* abort on first exact match */
								break;
				}
				if (++i == 64) {
						sl = sl->next;
						i = 0;
				}
		}

		*offset = ptr - base;
		return rv;
}

/* bss_vmem is in/out parameter which points to the top of bss after call */
void elf_resolve_symbols(Elf32_Ehdr* hdr, Elf32_Shdr* shdr, Elf32_Half symtab, void** bss_vmem, struct module_info* mi)
{
		void* ptr = ((void*)hdr + shdr[symtab].sh_offset);
		size_t i, ct = shdr[symtab].sh_size / shdr[symtab].sh_entsize;
		if (ct <= 1)
				return;
		sbprintf("Resolving symbols in symtab with %lu entries\n", ct);
		for (i = 1; i < ct; i++) {
				Elf32_Sym* s = (ptr + i * shdr[symtab].sh_entsize);
				if (s->st_shndx == SHN_UNDEF) {
						char* sn, tp = 'T';
						/* unresolved symbol -> find in map */
						sbprintf("using external symbol with name %s\n",
										(sn = elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name)));
						if (ELF32_ST_TYPE(s->st_info) == STT_OBJECT)
								tp = 'D';
						s->st_value = elf_locate_global_symbol(sn, tp);
						if (!s->st_value) {
								cprintf(KFMT_ERROR, "unresolved external symbol %c \"%s\"\n", tp, sn);
								while (1);
						} else
								sbprintf("\twhich was resolved to %p\n", (void*)s->st_value);
				} else if (s->st_shndx == SHN_COMMON) {
						char* sn, tp = 'D'; Elf32_Addr ad = (Elf32_Addr)NULL;
						sbprintf("Common symbol with size %u and alignment %u with name %s\n",
										s->st_size, s->st_value,
										(sn = elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name)));
						if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
										ELF32_ST_BIND(s->st_info) == STB_WEAK) {
								/* lookup on global symtab */
								ad = elf_locate_global_symbol(sn, tp);
								if (ad)
										sbprintf("global definition found at %p\n", (void*)ad);
						}
						/* lookup on symtab or else allocate */
						if (!ad) {
								/* allocate rw bss (dumb align) */
								if ((size_t)*bss_vmem % (size_t)s->st_value) {
										*bss_vmem += s->st_value - ((size_t)*bss_vmem % s->st_value);
										s->st_value = (Elf32_Addr)*bss_vmem;
										*bss_vmem += s->st_size;
										sbprintf("will be allocated at %p\n", (void*)s->st_value);
								}
								/* publish the location if applicable */
								if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
												ELF32_ST_BIND(s->st_info) == STB_WEAK) {
										elf_store_global_symbol(sn, (void*)s->st_value, tp,
													   	(ELF32_ST_BIND(s->st_info) == STB_WEAK));
										sbprintf("and is global\n");
								}
						} else
								s->st_value = ad;
				} else if (s->st_shndx < SHN_LORESERVE) {
						/* local symbol so get virtual address for relocations */
						if (!(shdr[s->st_shndx].sh_flags & SHF_ALLOC))
								continue; /* skip symbols in unused sections */
						s->st_value += shdr[s->st_shndx].sh_addr;
						sbprintf("symbol %s from %s defined at vmem=%p\n",
										elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name),
										elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[s->st_shndx].sh_name),
							  			(void*)s->st_value);
						if (strcmp(elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name), "module_init") == 0) {
								mi->mi_init = (mod_init)s->st_value;
								sbprintf("found global entry module_init at %p\n", mi->mi_init);
						} else if (strcmp(elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name), "module_cleanup") == 0) {
								mi->mi_cleanup = (mod_cleanup)s->st_value;
								sbprintf("found global exit module_cleanup at %p\n", mi->mi_cleanup);
						}
						if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
										ELF32_ST_BIND(s->st_info) == STB_WEAK) {
								/* exported symbol -> to global symtab */
								char tp = 'T', *sn;
								if (ELF32_ST_TYPE(s->st_info) == STT_OBJECT)
										tp = 'D';
								sn = elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name);
								elf_store_global_symbol(sn, (void*)s->st_value, tp, ELF32_ST_BIND(s->st_info) == STB_WEAK);
						}
				} else if (s->st_shndx == SHN_ABS) {
						sbprintf("absolute symbol with name %s and value %p\n",
										elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name),
							  			(void*)s->st_value);
						if (ELF32_ST_BIND(s->st_info) == STB_GLOBAL ||
										ELF32_ST_BIND(s->st_info) == STB_WEAK) {
								char tp = 'T', *sn;
								if (ELF32_ST_TYPE(s->st_info) == STT_OBJECT)
										tp = 'D';
								sn = elf_fetch_string(hdr, shdr, shdr[symtab].sh_link, s->st_name);
								elf_store_global_symbol(sn, (void*)s->st_value, tp, ELF32_ST_BIND(s->st_info) == STB_WEAK);
						}
				}
		}
}

/*#define ELF_DIAG*/

enum elferr load_elf(void* mem, uint32_t sz, struct module_info* mi)
{
		Elf32_Ehdr* hdr = (Elf32_Ehdr*)mem;
		Elf32_Shdr* shdr; size_t i;

		/* perform basic checks */
		if (strncmp((const char*)hdr->e_ident, ELFMAG, 4) != 0)
				return ELF_WRONG_MAGIC;
		if (hdr->e_ident[EI_CLASS] != ELFCLASS32)
				return ELF_NOT_CLASS32;
		if (hdr->e_ident[EI_DATA] != ELFDATA2LSB)
				return ELF_NOT_LE;
		if (hdr->e_ident[EI_VERSION] != EV_CURRENT)
				return ELF_VERSION_NOT_SUPPORTED;
		if (hdr->e_ident[EI_OSABI] != ELFOSABI_NONE)
				return ELF_WRONG_OSABI;

		/* matching ELF32 found -> check for object file */
		if (hdr->e_type != ET_REL)
				return ELF_NOT_REL;
		if (hdr->e_machine != EM_386)
				return ELF_NOT_386;
		if (hdr->e_ehsize != sizeof(*hdr))
				return ELF_INCOMPATIBLE_HEADER;
		if (hdr->e_phnum)
				return ELF_CONTAINS_PROG_HEADERS;
		if (!hdr->e_shnum)
				return ELF_NO_SECTIONS_DEFINED;
		if (hdr->e_shentsize != sizeof(Elf32_Shdr))
				return ELF_WRONG_SHDR_SIZE;
		if (hdr->e_shstrndx == SHN_UNDEF)
				return ELF_NO_SECTION_STRTAB;

		/* set the initial offsets */
		for (i = 0; i < 4; i++)
				mi->vm_ofs[i] = mod_tbl.vm_ofs[i];

		/* now first allocate the sections in memory */
		shdr = mem + hdr->e_shoff;
		for (i = 0; i < hdr->e_shnum; i++) {
				if (shdr[i].sh_type == SHT_NULL)
						continue;

				/* only allocate alloc section */
				if (shdr[i].sh_flags & SHF_ALLOC) {
						size_t pg_ct; struct page_range pr[10];
						Elf32_Word algn = shdr[i].sh_addralign;
						Elf32_Addr addr; void* mapaddr; int reuse = 0;
						Elf32_Off ofs = shdr[i].sh_offset;
						enum mt_sec sct;

						pg_ct = shdr[i].sh_size / 4096 + ((shdr[i].sh_size % 4096) ? 1 : 0);
						/* get the section type */
						if (shdr[i].sh_flags & SHF_WRITE) {
								/* TODO: C-o-w bss */
								if (shdr[i].sh_flags & SHF_EXECINSTR)
										return ELF_SECTION_RWX;
								if (shdr[i].sh_type == SHT_NOBITS)
										sct = MT_SEC_BSS;
								else
										sct = MT_SEC_DATA;
						} else if (shdr[i].sh_flags & SHF_EXECINSTR)
								sct = MT_SEC_TEXT;
						else {
								/* rodata, robss? */
								if (shdr[i].sh_type == SHT_NOBITS) {
										printf("Implement zero page!\n");
										while (1); /* c-o-w? nope! */
								}
								sct = MT_SEC_RODATA;
						}
						/* get the raw (unaligned) address */
						addr = (Elf32_Addr)mod_tbl.vm_ofs[sct] + mi->sz_secs[sct];
						mbprintf("unaligned address for %s: %p\n", elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[i].sh_name), (void*)addr);

						/* now do the alignment calculations */
						if (addr % algn)
								addr += algn - addr % algn;
						if (algn < 0x1000 && (addr % 4096)) {
								/* maybe save up to a single page by reusing an existing one of the same module */
								size_t ovs = shdr[i].sh_size % 4096; /* "oversize" */
								if (ovs && ovs < (4096 - (addr % 4096))) {
										/* oversize fits into existing page */
										mbprintf("reuse\n");
										pg_ct--;
										reuse = 1;
								}
						}
						if (addr % 4096)
								if (reuse) /* first use partially present page */
										mapaddr = (void*)(addr + 4096 - addr % 4096);
								else { /* alignment leaves page partially unused */
										mapaddr = (void*)(addr - addr % 4096);
										if (pg_ct * 4096 < shdr[i].sh_size + addr % 4096)
												pg_ct++; /* adjust space accordingly */
								}
						else
								mapaddr = (void*)addr;

						shdr[i].sh_addr = addr;
						mbprintf("aligned address: %p\n", (void*)addr);
						if (!mi->vm_ofs[sct])
								mi->vm_ofs[sct] = (void*)addr;
						mi->sz_secs[sct] += shdr[i].sh_size;

						/* fill the half-used page (if PROGBITS) */
						if (((void*)addr < mapaddr) && (shdr[i].sh_type != SHT_NOBITS)) {
								size_t n = (size_t)mapaddr - (size_t)addr;
								n = min(n, shdr[i].sh_size);
								memcpy((void*)addr, (void*)hdr + ofs, n);
								ofs += n;
								addr += n;
						}
						/* allocate the physical memory and map it to virtual memory */
						mbprintf("allocating %lu pages for size=%u\n", pg_ct, shdr[i].sh_size);
						while (pg_ct) {
								int flags = MMGR_MAP_KERNEL, remap = 0;
								size_t np = mm_alloc_pm(pg_ct, pr, countof(pr));
								if (shdr[i].sh_flags & SHF_EXECINSTR)
										flags |= MMGR_MAP_EXECUTE;
								if (shdr[i].sh_flags & SHF_WRITE)
										flags |= MMGR_MAP_WRITE;
								else if (shdr[i].sh_type != SHT_NOBITS) {
										flags |= MMGR_MAP_WRITE;
								}

								mbprintf("mapping %lu pages to %p\n", np, mapaddr);
								if (mm_map(&mm_kernel, mapaddr, pr, countof(pr), flags) != mapaddr) {
										printf("unexpected error mapping pmem to vmem\n");
										while (1);
								}
								/* copy data if present */
								if (shdr[i].sh_type != SHT_NOBITS) {
										size_t n = min(np * 4096, shdr[i].sh_size - (ofs - shdr[i].sh_offset));
										mbprintf("n=%lu, ofs=%u\n", n, ofs);
										if ((void*)addr > mapaddr)
												n -= (size_t)addr - (size_t)mapaddr;
										memcpy((void*)addr, (void*)hdr + ofs, n);
										mbprintf("copying %lu bytes to %p\n", n, (void*)addr);
										ofs += n;
										addr += n;
										if (remap) {
												flags &= ~MMGR_MAP_WRITE;
												mm_map(&mm_kernel, mapaddr, pr, countof(pr), flags);
										}
								}
								mapaddr += np * 4096;
								pg_ct -= np;
						}

						/* redundant and wrong */
						/*mod_tbl.sz_secs[sct] += addr + shdr[i].sh_size - (size_t)mod_tbl.vm_ofs[sct];*/
				}
#ifdef ELF_DIAG
				printf("found section %s with size %u at offset %u\n",
					elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[i].sh_name),
					shdr[i].sh_size, shdr[i].sh_offset);
				{
						char flg[4] = "   ", *tp;
						if (shdr[i].sh_flags & SHF_WRITE)
								flg[1] = 'w';
						if (shdr[i].sh_flags & SHF_EXECINSTR)
								flg[2] = 'x';
						if (shdr[i].sh_flags & SHF_ALLOC)
								flg[0] = 'a';
						tp = get_section_type_string(shdr[i].sh_type);
						printf("type is %s and flags are %s\n", tp, flg);
						if (shdr[i].sh_type == SHT_SYMTAB && shdr[i].sh_size)
								elf_dump_symtab(hdr, shdr, i);
						else if (shdr[i].sh_type == SHT_REL || shdr[i].sh_type == SHT_RELA)
								elf_dump_rel(hdr, shdr, i);
						printf("section address is %p and preferred align is %x\n",
							(void*)shdr[i].sh_addr, shdr[i].sh_addralign);
				}
#endif
		}

		/* Now determine the symbol values*/
		for (i = 0; i < hdr->e_shnum; i++)
				if (shdr[i].sh_type == SHT_SYMTAB) {
						void* vm_bss = mi->vm_ofs[MT_SEC_BSS] + mi->sz_secs[MT_SEC_BSS];
						void* vm_aold = vm_bss + (((size_t)vm_bss % 4096) ? (4096 - ((size_t)vm_bss % 4096)) : 0);
						elf_resolve_symbols(hdr, shdr, i, &vm_bss, mi);
						if (vm_bss > vm_aold) {
								size_t pgc = 0; struct page_range pr[10];
								/* allocate new bss sections */
								pgc = vm_bss - vm_aold;
								pgc = pgc / 4096 + (pgc % 4096) ? 1 : 0;
								if (mm_alloc_pm(pgc, pr, 10) == pgc) {
										/* success */
										if (!mm_map(&mm_kernel, vm_aold, pr, 10, MMGR_MAP_WRITE | MMGR_MAP_KERNEL)) {
												printf("unable to map new bss pages to %p\n", vm_aold);
												while (1);
										}
										mi->sz_secs[MT_SEC_BSS] = vm_bss - mi->vm_ofs[MT_SEC_BSS];
								} else {
										printf("failed to extend bss section\n");
										while (1);
								}
						}
				}

		/* and perform the relocations */
		for (i = 0; i < hdr->e_shnum; i++)
				if (shdr[i].sh_type == SHT_REL || shdr[i].sh_type == SHT_RELA) {
						if (shdr[shdr[i].sh_info].sh_flags & SHF_ALLOC) {
								void* vm_begin = (void*)shdr[shdr[i].sh_info].sh_addr;
								size_t pgc = shdr[shdr[i].sh_info].sh_size;
								pgc = pgc / 4096 + ((pgc % 4096) ? 1 : 0);
								printf("performing relocations on section %s:\n",
										elf_fetch_string(hdr, shdr, hdr->e_shstrndx, shdr[shdr[i].sh_info].sh_name));
								/* unguard the section */
								printf("modifying %lu pages at %p\n", pgc, vm_begin);
								if (!(shdr[shdr[i].sh_info].sh_flags & SHF_WRITE))
										mm_protect(&mm_kernel, vm_begin, pgc, MMGR_MAP_WRITE | MMGR_MAP_SET);
								/* relocate */
								elf_relocate_section(hdr, shdr, i);
								/* reguard the section */
								if (!(shdr[shdr[i].sh_info].sh_flags & SHF_WRITE))
										mm_protect(&mm_kernel, vm_begin, pgc, MMGR_MAP_WRITE | MMGR_MAP_UNSET);
						}
				}

		/* page-align for the next module */
		/* DBG: and insert a guard-page */
		for (i = 0; i < 4; i++) {
				if (mi->sz_secs[i]) {
						mod_tbl.vm_ofs[i] = mi->vm_ofs[i] + mi->sz_secs[i];
						if ((size_t)mod_tbl.vm_ofs[i] % 4096) {
								/* section align */
								mod_tbl.vm_ofs[i] += 4096 - (size_t)mod_tbl.vm_ofs[i] % 4096;
						}
						/* add guard page */
						mod_tbl.vm_ofs[i] += 4096;
				}
		}

		return ELF_OK;
}

const char* get_elferr_string(enum elferr e)
{
		switch (e) {
		case ELF_WRONG_MAGIC:
				return "not ELF file";
		case ELF_NOT_CLASS32:
				return "not a 32-bit ELF file";
		case ELF_NOMEM:
				return "out of memory";
		case ELF_NOT_LE:
				return "not a little-endian file";
		case ELF_VERSION_NOT_SUPPORTED:
				return "unsupported ELF version";
		case ELF_WRONG_OSABI:
				return "unsupported OS ABI";
		case ELF_NOT_REL:
				return "modules have to be relocatable object files";
		case ELF_NOT_386:
				return "only i386 modules can be loaded";
		case ELF_INCOMPATIBLE_HEADER:
				return "unexpected size of ELF header";
		case ELF_CONTAINS_PROG_HEADERS:
				return "ELF contains program heades (no object file)";
		case ELF_NO_SECTIONS_DEFINED:
				return "ELF contains no defined sections";
		case ELF_WRONG_SHDR_SIZE:
				return "no matching ELF section header size";
		case ELF_NO_SECTION_STRTAB:
				return "no ELF STRTAB for section names";
		case ELF_SECTION_RWX:
				return "module contains rwx secton";
		case ELF_GSTAB_ALREADY_PRESENT:
				return "the global symbol table has already been loaded";
		case ELF_STRING_PARSE_NUMBER:
				return "the string parser expected a number but found none";
		case ELF_PARSE_FORMAT_NOT_NM:
				return "the provided symbol mapping file is not in the nm format";
		default:
				return "unknown";
		}
}

enum elferr elf_parse_global_symtab(void* addr, size_t sz)
{
		const char* str = (const char*)addr; size_t cap = 64;
		struct symbol_list* sl;
		if (gs_lst)
				return ELF_GSTAB_ALREADY_PRESENT;

		/* allocate the initial capacity */
		sl = gs_lst = kmalloc(sizeof(struct symbol_list));
		if (!sl)
				return ELF_NOMEM;
		sl->next = NULL;

		while ((size_t)((void*)str - addr) < sz) {
				const char* s1 = str; char *s2; char tp = ' ';
				long val = strtol(str, (char**)&str, 16);
				
				if (s1 == str)
						return ELF_STRING_PARSE_NUMBER;
				if (*str++ != ' ')
						return ELF_PARSE_FORMAT_NOT_NM;
				tp = *str++;
				if (*str++ != ' ')
						return ELF_PARSE_FORMAT_NOT_NM;
				s1 = strchr(str, '\n');
				if (!s1) {
						printf("strchr!\n");
						s1 = (const char*)(addr + sz);
				}
				s2 = strndup(str, s1 - str);

				/*printf("symbol at %p: \"%s\" type %c\n", (void*)val, s2, tp);------------------*/
				if (strcmp(s2, "printf") == 0)
						if (&printf != (void*)val) {
								cprintf(KFMT_WARN, "WARNING! Loaded outdated symtab!\n");
								printf("printf is located at %p but symtab says it's at %p\n",
												&printf, (void*)val);
								printf("expect modules to fail randomly as the\n"
									   "symbols used therein will not be resolved correctly\n");
						}

				/* expand the capacity if needed */
				if (!cap) {
						sl->next = kmalloc(sizeof(struct symbol_list));
						if (!sl) {
								cprintf(KFMT_ERROR, "Out of memory for parsing global symbol table\n");
								while (1);
						}
						sl = sl->next;
						sl->next = NULL;
						cap = 64;
				}

				/* store the two values */
				sl->entries[64 - cap].name = s2;
				sl->entries[64 - cap].vma = (void*)val;
				sl->entries[64 - cap].type = tp;
				cap--;
				/* and advance */
				str = s1 + 1;
		}

		/* zero-terminate not fully used lists */
		if (cap) {
				sl->entries[64 - cap].name = NULL;
				sl->entries[64 - cap].vma = NULL;
		}
		return ELF_OK;
}

void load_modules()
{
		void* mem = (void*)0x200000;
		uint32_t mct = *(uint32_t*)mem;
		enum elferr ee;
		mem += sizeof(uint32_t);

		if (strcmp(mem, "LD.MAP") != 0) {
				cprintf(KFMT_ERROR, "first file has to be global symbol map\n");
				while (1);
		} else
				mem += 7;
		/* parse the kernel symbol table supplied in nm format */
		if ((ee = elf_parse_global_symtab(mem + sizeof(uint32_t), *(uint32_t*)mem))) {
				cprintf(KFMT_ERROR, "Failed to parse global kernel symbol table ("
					   "file ld.map in root directory)\n");
				cprintf(KFMT_ERROR, "reason: %s\n", get_elferr_string(ee));
				memdump(mem + sizeof(uint32_t), *(uint32_t*)mem);
				while (1);
		}
		mem += sizeof(uint32_t) + *(uint32_t*)mem;
		mct--;

		/* try to load each module */
		while (mct--) {
				const char* name = (const char*)mem;
				uint32_t sz;
				struct module_info mi = {0};
				mem += strlen(name) + 1;
				sz = *(uint32_t*)mem;
				mem += sizeof(uint32_t);
				strncpy(mi.mi_name, name, 20);
				printf("loading module %.20s...\n", mi.mi_name);
				if ((ee = load_elf(mem, sz, &mi))) {
						cprintf(KFMT_ERROR, "Failed to load ELF module at %p\n", mem);
						cprintf(KFMT_ERROR, "reason: %s\n", get_elferr_string(ee));
						while (1);
				} else {
						int errc;
						cprintf(KFMT_INFO, "loaded module at the following offsets and sizes:\n");
						cprintf(KFMT_INFO, ".text    %p %11lu\n", mi.vm_ofs[0], mi.sz_secs[0]);
						cprintf(KFMT_INFO, ".data    %p %11lu\n", mi.vm_ofs[1], mi.sz_secs[1]);
						cprintf(KFMT_INFO, ".rodata  %p %11lu\n", mi.vm_ofs[2], mi.sz_secs[2]);
						cprintf(KFMT_INFO, ".bss     %p %11lu\n", mi.vm_ofs[3], mi.sz_secs[3]);
						cprintf(KFMT_INFO, "calling module_init()...\n");
						errc = mi.mi_init();
						if (errc) {
								cprintf(KFMT_ERROR, "init failed with error %d\n", errc);
								while (1);
						} else {
								cprintf(KFMT_OK, "successfully initialized module \"%s\"\n", mi.mi_name);
								store_module_info(&mi);
						}
				}

				mem += sz;
		}

		printf("done loading kernel modules\n");
}

