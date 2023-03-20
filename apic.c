/* apic.c : An attempt to clean up the LAPIC, IOAPIC,
 *          TPR, PPR, IPR mess, which was built up over
 *          the last few months.
 * */

#include "kernel.h"
#include "kdata.h"


/* global data for APIC */
uint64_t apic_pm_base = 0xfffff000;
void* bp_apic_base = (void*)0xefff0000;
uint32_t apic_initialized = 0;
uint8_t apic_cur_log = 2; /* (1 << i) for assigning log. dest. */
struct {
		uint64_t page;
		void* ptr_base;
		uint16_t ptr_ofs;
		uint8_t max_pin;
		uint8_t real_id; /* maybe the tables are wrong? */
} ioapic_mappings[16]; /* up to 16 ioapics are supported */


void cpu_get_msr(uint32_t msr, uint32_t* eax, uint32_t* edx)
{
		__asm__("rdmsr" : "=a" (*eax), "=d" (*edx) : "c" (msr) : );
}

void cpu_set_msr(uint32_t msr, uint32_t eax, uint32_t edx)
{
		__asm__("wrmsr" : : "a" (eax), "d" (edx), "c" (msr) : );
}

/* only for TPR not subclass (4-7 TPR, 0-3 SubTPR) */
void apic_set_tpr(uint8_t tpr)
{
		apic_reg(APIC_REG_TASKPRIOR) = (tpr << 4);
}

void apic_set_ldr(uint8_t ld)
{
		apic_reg(APIC_REG_LDR) = (uint32_t)ld << 24;
}

void apic_set_dfr(uint8_t mod)
{
		apic_reg(APIC_REG_DFR) = ((uint32_t)mod << 28) | 0x0fffffff;
}
/**********  I/O APIC Interrupt Handling  ********************************/
uint32_t ioapic_read(uint8_t id, uint8_t reg)
{
		void* ptr = ioapic_mappings[id].ptr_base + ioapic_mappings[id].ptr_ofs;
		*(volatile uint8_t*)ptr = reg;
		return *(volatile uint32_t*)(ptr + 0x10);
}

void ioapic_write(uint8_t id, uint8_t reg, uint32_t val)
{
		void* ptr = ioapic_mappings[id].ptr_base + ioapic_mappings[id].ptr_ofs;
		*(volatile uint8_t*)ptr = reg;
		*(volatile uint32_t*)(ptr + 0x10) = val;
}

void init_ioapic(uint8_t id, void* addr)
{
		void* vmem = NULL; size_t ofs = (size_t)addr % 4096;
		uint64_t page = (size_t)addr - (size_t)addr % 4096;

		printf("%p %x\n", addr, (uint32_t)page);
		/* check for an existing mapping */
		for (size_t i = 0; i < 16; i++)
				if (ioapic_mappings[i].page == page) {
						vmem = ioapic_mappings[i].ptr_base;
						break;
				}

		/* else map the IOAPIC and print the register contents */
		if (!vmem) {
				struct page_range pr;
				extern void* bp_apic_base;
				vmem = bp_apic_base - 4096;
				pr.base = page; pr.count = 1;
				vmem = mm_map(&mm_kernel, bp_apic_base - 4096, &pr, 1,
						MMGR_MAP_MMIO | MMGR_MAP_WRITE |
					   	MMGR_MAP_KERNEL | MMGR_MAP_NO_CACHING);
				if (!vmem) {
						die("unable to map I/O APIC.\n");
				} else if (vmem == bp_apic_base - 4096)
						bp_apic_base -= 4096;
				else {} /* mapped somewhere known by mmap (can't happen) */
		}

		/* now put the mapping into the table */
		if (id < 16) {
				ioapic_mappings[id].page = page;
				ioapic_mappings[id].ptr_base = vmem;
				ioapic_mappings[id].ptr_ofs = ofs;
				/* set the offset */
				vmem += ofs;
		} else
				die("I/O APIC ID larger than 15 found!\n");

		/* read some data */
		printf("reg1: %08x\n", ioapic_read(id, 0));
		printf("reg2: %08x\n", ioapic_read(id, 1));
		printf("reg3: %08x\n", ioapic_read(id, 2));
		ioapic_mappings[id].max_pin = (ioapic_read(id, 1) >> 16) & 0xff;
		ioapic_mappings[id].real_id = (ioapic_read(id, 0) >> 24) & 0x0f;

		/* IDT 40-47 == irq8-15 -> A-H --> 8-15 */
		/* just do a "stupid" default initialization */
		for (int i = 16; i < ioapic_mappings[id].max_pin + 1; i++) {
				/* set the destination (now APIC 00 later logical all low prio )*/
				ioapic_write(id, 0x11 + i * 2, 0x00000000);
				/* set the vector and mode and unmask */
				ioapic_write(id, 0x10 + i * 2, 0x0000a000 /* a=lvl low; 0=phys,fixed */
						| (40 + (i - 16) % 8)); /* 40-47 (round-robin if more) */
		}


		/* and print the current configuration */
		printf("I/O APIC with ID %x (%d pins):\n", ioapic_mappings[id].real_id,
				ioapic_mappings[id].max_pin + 1);
		for (int i = 0; i < ioapic_mappings[id].max_pin + 1; i++) {
				uint64_t dat = ioapic_read(id, 0x10 + i * 2) | ((uint64_t)
						ioapic_read(id, 0x11 + i * 2) << 32);
				printf("REDTBL%-3d %016llx\n", i, dat);
		}
		printf("\n");

		/* we're going to test some IPIs */
//		uint8_t ld = 1;
//		apic_set_tpr(1); /* we're now uninterruptible by LP IPIs */
//		do { /* logical destination mode */
//				printf("Issuing IPI with ld=%08b\n", ld);
//				mdelay(500);
//				apic_reg(APIC_REG_ICRH) = (uint32_t)ld << 24;
//				/* 8 log fix; 9 log LP */
//				apic_reg(APIC_REG_ICRL) = 0x00004900 | 0x3e; /* level, edge */
//				mdelay(2000);
//				if (++ld >= (1 << nproc)) /* send to existing procs */
//						ld = 1;
//		} while (1);
}

void ioapic_print_is()
{
		for (int i = 0; i < 16; i++) {
				uint32_t pin = 0;
				if (!ioapic_mappings[i].ptr_base)
						continue;
				for (int j = 0; j < ioapic_mappings[i].max_pin + 1; j++) {
						uint32_t st;
						st = ioapic_read(i, 0x10 + 2 * j);
						if (st & (1 << 12)) /* DS=pending */
								pin |= (1 << j);
				}
				printf("IOAPIC%u: %08x\n", i, pin);
		}
}

/**********  Local APIC configuration including IPIs  ********************/
void ap_apic_init()
{
		/* TODO use regular init as APIC MMIO memory is global */
		/* we're using iprintf to avoid needless waiting */
		struct page_range pr = {0,1};
		uint32_t eax, edx;
		cpu_get_msr(APIC_BASE_MSR, &eax, &edx);
		pr.base = ((uint64_t)(edx & 0x0f)) << 32 | (eax & 0xfffff000);
		iprintf("msr: %08x%08x\n", edx, eax);
		/* ensure PM location */
		if (!pr.base)
				die("APIC has no PM location assigned. TODO: write PM MMIO address allocator.\n");
		iprintf("AP APIC base: %016llx\n", pr.base);
		if (!(eax & APIC_BASE_MSR_ENABLE)) {
				cpu_set_msr(APIC_BASE_MSR, (pr.base & 0xfffff000) |
					APIC_BASE_MSR_ENABLE, (pr.base >> 32) & 0x0f);
		}
		/* keep track of the memory & map it */
		per_cpu_ptr()->apic_phys = pr.base;
		per_cpu_ptr()->apic_addr = mm_map(&mm_kernel, per_cpu_ptr()->apic_addr,
				&pr, 1, MMGR_MAP_MMIO | MMGR_MAP_WRITE
				| MMGR_MAP_NO_CACHING | MMGR_MAP_KERNEL);
		/* set logical dest and mode */
		apic_set_dfr(0xf); /* flat mode */
		apic_set_ldr(apic_cur_log);
		apic_set_tpr(0); /* receive any intr */
		if (!(apic_cur_log <<= 1)) /* x86 rol */
				apic_cur_log = 1;
		/* TODO: possibly cause TLB shootdown */
		/* now APIC_BASE points to the xAPIC memory */
		iprintf("The registers are configured as follows:\n");
		iprintf("spurious:  %08x\n", apic_reg(APIC_REG_SPURIOUS));
		iprintf("error:     %08x\n", apic_reg(APIC_REG_ESR));
		iprintf("LVT timer: %08x\n", apic_reg(APIC_REG_LVT_TMR));
		iprintf("LVT therm: %08x\n", apic_reg(APIC_REG_LVT_THERM));
		iprintf("LVT perf:  %08x\n", apic_reg(APIC_REG_LVT_PERF));
		iprintf("LVT LINT0: %08x\n", apic_reg(APIC_REG_LVT_LINT0));
		iprintf("LVT LINT1: %08x\n", apic_reg(APIC_REG_LVT_LINT1));
		iprintf("LVT error: %08x\n", apic_reg(APIC_REG_LVT_ERR));
		apic_reg(APIC_REG_SPURIOUS) = 0x00000100 | 0x3f;
		iprintf("spurious:  %08x\n", apic_reg(APIC_REG_SPURIOUS));
		apic_reg(APIC_REG_LVT_ERR) = 0x3c; /* 0 | 3c */
		/* (val << 16): R00M=one-shot, R01M per, R11M tsc, R=res, M=mask */
		apic_reg(APIC_REG_LVT_TMR) = 0x00000000 | 0x3d; /* one-shot */
		/* mask the LINTS */
		apic_reg(APIC_REG_LVT_LINT0) = 0x00010700; /* masked extInt */
		apic_reg(APIC_REG_LVT_LINT1) = 0x00010400; /* masked NMI */
		/* arm the error register */
		apic_reg(APIC_REG_ESR) = 0;
		apic_reg(APIC_REG_TMRDIV) = 0x0b; /* div=1 ; 111 */
		apic_reg(APIC_REG_TMRINITCNT) = 0x0fffffff; /* 1.5s at 3GHz */
}

void apic_init()
{
		struct page_range pr = {0,1};
		uint32_t eax, edx;
		if (cpu.has_x2APIC)
				cprintf(KFMT_INFO, "This CPU supports the x2APIC mode, but for "
						"simplicity it is run in xAPIC mode.\n");
		/* find and map the APIC registers */
		cpu_get_msr(APIC_BASE_MSR, &eax, &edx);
		pr.base = ((uint64_t)(edx & 0x0f)) << 32 | (eax & 0xfffff000);
		if (!pr.base) {
				// TODO: mmgr_get_mmio_pmem();
				pr.base = apic_pm_base;
		} else
				apic_pm_base = pr.base;
		if (!(eax & APIC_BASE_MSR_ENABLE)) {
				cpu_set_msr(APIC_BASE_MSR, (pr.base & 0xfffff000) |
					APIC_BASE_MSR_ENABLE, (pr.base >> 32) & 0x0f);
		}
		mm_map(&mm_kernel, bp_apic_base, &pr, 1, MMGR_MAP_MMIO | MMGR_MAP_WRITE
			| MMGR_MAP_NO_CACHING | MMGR_MAP_KERNEL);
		/* now access them */
		edx = apic_bp_reg(APIC_REG_APICID);
		printf("The APIC of the %s with ID %x is located at 0x%016llx\n",
			(eax & APIC_BASE_MSR_BSP) ? "BSP" : "AP", edx >> 24, pr.base);
		/* set the destination format and logical address */
		apic_bp_reg(APIC_REG_DFR) = 0xffffffff; /* flat */
		apic_bp_reg(APIC_REG_LDR) = 0x01000000; /* we'll do round-robin like */
		apic_bp_reg(APIC_REG_TASKPRIOR) = 0x00000000; /* receive any */
		/* post version info */
		eax = apic_bp_reg(APIC_REG_APICVER);
		printf("This processors APIC's version is %02xh (%s) which has "
			   "support for %u LVT entries%s.", eax & 0xff, ((eax & 0xff) < 0x10)
			   ? "external 82489DX APIC" : "integrated APIC", 1 + ((eax >> 16) & 0xff),
               (eax & 0x01000000) ? " and for EOI-broadcast suppression" : "");
		/* and the initial configuration */
		printf("The registers are configured as follows:\n");
		printf("spurious:  %08x\n", apic_bp_reg(APIC_REG_SPURIOUS));
		printf("error:     %08x\n", apic_bp_reg(APIC_REG_ESR));
		printf("LVT timer: %08x\n", apic_bp_reg(APIC_REG_LVT_TMR));
		printf("LVT therm: %08x\n", apic_bp_reg(APIC_REG_LVT_THERM));
		printf("LVT perf:  %08x\n", apic_bp_reg(APIC_REG_LVT_PERF));
		printf("LVT LINT0: %08x\n", apic_bp_reg(APIC_REG_LVT_LINT0));
		printf("LVT LINT1: %08x\n", apic_bp_reg(APIC_REG_LVT_LINT1));
		printf("LVT error: %08x\n", apic_bp_reg(APIC_REG_LVT_ERR));
		/* now install the handlers */
		apic_bp_reg(APIC_REG_SPURIOUS) = (apic_bp_reg(APIC_REG_SPURIOUS) & 0xffffff00) + 0x3f;
		apic_bp_reg(APIC_REG_LVT_ERR) = 0x3c; /* 0 | 3c */
		/* arm the error register */
		apic_bp_reg(APIC_REG_ESR) = 0;

		/* do the apic timer init */
		extern void apic_timer_setup();
		apic_timer_setup();
		apic_initialized = 1;

		/* (always) do MP init */
		void mp_entry();
		mp_entry();
		/* send self-IPI (only shorthand, i.e. lower reg) */
//		do { /*4c*/
//				apic_reg(APIC_REG_ICRL) = 0x00044000 | 50; /* level, edge */
//				for (size_t i = 0; i < 0x0f000000; i++);
//		} while (0);
}

