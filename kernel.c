/* no includes */
#include "limits.h"
#include "kernel.h"
#include "kdata.h"
#include <cpuid.h>

void ktimer_tick();

struct IDTDescr {
		uint16_t offset_1; // offset bits 0..15
		uint16_t selector; // a code segment selector in GDT or LDT
		uint8_t zero;      // unused, set to 0
		uint8_t type_attr; // type and attributes, see below
		uint16_t offset_2; // offset bits 16..31
};
extern void* idt;
extern void exceptionHandler(int i, void* ptr)
{
		struct IDTDescr* dt = &idt;
		if (i < 17) {
				dt[i].offset_1 = (uint16_t)((uint32_t)ptr & 0x0000ffff);
				dt[i].offset_2 = (uint16_t)((uint32_t)ptr >> 16);
		}
}
extern void set_debug_traps();
extern void breakpoint();
extern void print_stacktrace();
extern void print_exception(void* eip, unsigned int code)
{
		while (eip);
		switch (code) {
				case 0:
					printf("#DE at %p\n", eip);
					break;
				case 3:
					printf("#BP at %p\n", (void*)((char*)eip-1));
					break;
				case 4:
					printf("#OF before %p\n", eip);
					break;
				case 5:
					printf("#BR at %p\n", eip);
					while (1);
					break;
				case 6:
					printf("#UD at %p\n", eip);
					while (1);
					print_stacktrace();
					break;
				case 7:
					printf("#NM at %p\nFPU is disabled or not present\n", eip);
					/* TODO enable FPU */
					break;
				case 8:
					printf("#DF with error code %x\n", (unsigned int)eip);
					die("that's it");
					break;
				case 9:
					printf("Legacy coprocessor segment overrun at %p\n", eip);
					break;
				case 15:
					printf("Reserved gate called from %p\n", eip);
					break;
				case 16:
					printf("#MF at %p\n", eip);
					break;
				case 17:
					printf("#AC at %p\n", eip);
					break;
				case 18:
					cprintf(KFMT_ERROR, "#MC received while at %p\n", eip);
					while (1);
					break;
				case 19:
					printf("#XM at %p\n", eip);
					break;
				case 20:
					printf("#VE at %p\n", eip);
					break;
				case 30:
					printf("#SX at %p\n", eip);
					break;
				default:
					printf("int %x at %p\n", code, eip);
					break;
		}
}

struct idt_entry
{
	unsigned short offset_1;
	unsigned short selector;
	unsigned char zero;
	unsigned char type_attr;
	unsigned short offset_2;
};

extern void print_idt(struct idt_entry* idt, unsigned int num)
{
		unsigned int i;
		printf("IDT at %p\n", idt);
		for (i = 0; i < num; i++) {
				printf("IDT entry %d: %x:%p type=%x\n", i, idt->selector,
								(void*)((((unsigned int)idt->offset_2) << 16) + idt->offset_1),
								idt->type_attr);
				idt++;
		}
}

extern unsigned int debug_handler(void* eip, unsigned int dr6)
{
		cprintf(KFMT_INFO, "#DB at %p with DR6=%x\n", eip, dr6);
		/* busy spin for attaching debugger */
		//while (eip);
		return 0;
}

void irq_mask(uint8_t line)
{
		uint16_t prt;
		if (line < 8)
				prt = PIC1_DATA;
		else if (line <= 15) {
				prt = PIC2_DATA;
				line -= 8;
		} else
				return;
		line = inb(prt) | (1 << line);
		outb(prt, line);
}

void irq_unmask(uint8_t line)
{
		uint16_t prt;
		if (line < 8)
				prt = PIC1_DATA;
		else if (line <= 15) {
				prt = PIC2_DATA;
				line -= 8;
		} else
				return;
		line = inb(prt) & ~(1 << line);
		outb(prt, line);
}

void pic_disable()
{
		outb(PIC2_COMMAND, 0xff);
		outb(PIC1_COMMAND, 0xff);
}

uint16_t pic_get_irr() /* currently requested interrupts */
{
		outb(PIC1_COMMAND, 0x0a); /* PIC_READ_IRR */
		outb(PIC2_COMMAND, 0x0a);
		return (inb(PIC2_COMMAND) << 8) | inb(PIC1_COMMAND);
}

uint16_t pic_get_isr() /* currently serviced interrput */
{
		outb(PIC1_COMMAND, 0x0b); /* PIC_READ_ISR */
		outb(PIC2_COMMAND, 0x0b);
		return (inb(PIC2_COMMAND) << 8) | inb(PIC1_COMMAND);
}

/**************** COM routines to be moved into module *******************/
static int com_present = 0;
static uint16_t com_ports[4] = {0};
static uint16_t def_port = 0;

void enable_com(int num, uint16_t port)
{
		if (!com_present) {
				com_present = 1;
				def_port = port;
				irq_unmask(3);
				irq_unmask(4);
		}
		if (num < 4)
				com_ports[num] = port;
		/* set the parameters of this port */
		outb(port + 1, 0x00); /* disable interrupts */
		outb(port + 3, 0x80); /* DLAB enable */
		outb(port + 0, 0x0c); /* baud 9600 (div 12) */
		outb(port + 1, 0x00);
		outb(port + 3, 0x03); /* DLAB disable, 8+1 bits no parity */
		outb(port + 2, 0xe7); /* enable FIFO and trigger at 14 bytes and clear */
		/* e=64bt buf, c=16bt  */
		outb(port + 4, 0x0b);
		outb(port + 1, 0x07); /* enable buf empty & recv & line status interrupt */
		/*void putDebugChar(char);
		char getDebugChar();
		while (1) {
				putchar(getDebugChar());
				putDebugChar('G');
		}*/
		/*while (1) putDebugChar('H');*/
#ifndef NO_GDB
		set_debug_traps();
		breakpoint();
#endif
/*		breakpoint();
		breakpoint();
		breakpoint();*/
}

void com_interrupt(int irq)
{
		uint16_t port;
		/*printf("COM irq%d\n", irq);*/
		for (int i = 0; i < 4; i++) {
				uint8_t lsr, iir;
				port = com_ports[i];
				if (!port)
						continue;
				iir = inb(port + 2);
				if ((iir & 1)) /* 0 means yes 1 no */
						continue;
				/*printf("COM%d iir: %08b\n", i, iir);*/
				if ((iir & 0x0e) == 0x00) /* modem status*/
						inb(port + 6); /* just pop the interrupt */
				else if ((iir & 0x0e) == 0x02) { /* transmitter empty */
						/* TODO: write pending */
						/*int j = 0;
						iprintf("COM%d writing data...\n", i);
						while (inb(port + 5) & 0x20) { *//* transmit possible *//*
								outb(port, 'H');
								j++;
						}
						printf("put %d bytes\n", j);*/
				} else if ((iir & 0x0e) == 0x04) { /* data available */
						/*printf("data to be read:\n");*/
				} else if ((iir & 0x0e) == 0x06) { /* line status interrupt */
						iprintf("line status:\n");
				} else if ((iir & 0x0e) == 0x0c) { /* time out */
						/*iprintf("timeout:\n");*/
				} else
						iprintf("unknown interrupt on COM%d\n", i);

				lsr = inb(port + 5);
				/*printf("COM%d lsr: %08b\n", i, lsr);*/
				if (lsr & (1 << 7)) { /* clear fifo */
						outb(port + 2, 0xc7);
				} else if (lsr & (1 << 3)) { /* framing error */
						iprintf("COM%d framing error\n", i);
				} else if (lsr & (1 << 2)) { /* parity error */
						iprintf("COM%d parity error\n", i);
				} else if (lsr & (1 << 1)) { /* overrun */
						iprintf("COM%d overrun\n", i);
				}
				/* always fetch data to not block the port */
				if (lsr & 1) { /* data ready */
						iprintf("COM%d data: \"", i);
						do {
								char c = inb(port);
								if (c == 3) { /* TODO: reimplement stub */
										//breakpoint();
								} else
										putchar(c);
						} while (inb(port + 5) & 1);
						iprintf("\"\n");
				}
		}
}

void com_status()
{
		for (int i = 0; i < 4; i++)
				if (com_ports[i]) {
						uint16_t port = com_ports[i];
						uint8_t lsr;
						lsr = inb(port + 5);
						printf("COM%d lsr: %08b\n", i, lsr);
				}
}

int is_transit_empty(uint16_t port)
{
		return inb(port + 5) & 0x20;
}

void putDebugChar(char c)
{
		while (!is_transit_empty(def_port));
		outb(def_port, c);
}

int serial_received(uint16_t port)
{
		return inb(port + 5) & 1;
}

char getDebugChar()
{
		while (!serial_received(def_port));
		return inb(def_port);
}

/*************************************************************************/
struct irqe {
		irq_handler_function fun;
		struct irqe* next;
} *irq_funs[14];
/* used for device IRQ handlers */
void forward_irq(unsigned int irq)
{
		struct irqe* pt;
		if (!irq || irq > 15)
				return;
		pt = irq_funs[--irq]; /* 1 based */
		while (pt) {
				if (pt->fun(irq + 1)) /* handled */
						break;
				pt = pt->next;
		}
}

int install_irq_handler(unsigned int irq, irq_handler_function fun)
{
		if (!irq || irq > 15)
				return 0;
		struct irqe* p = kmalloc(sizeof(*p));
		if (!p)
				return 0;
		p->fun = fun;
		/* unmask first */
		if (!irq_funs[irq - 1])
				irq_unmask(irq);
		do {
				p->next = irq_funs[irq - 1];
		} while (!__sync_bool_compare_and_swap(&irq_funs[irq - 1], p->next, p));
		return 1;
}

int remove_irq_handler(unsigned int irq, irq_handler_function fun)
{
		struct irqe* pt, *prev = NULL;
		if (!irq || irq > 15)
				return 0;
start:
		pt = irq_funs[irq - 1];
		while (pt) {
				if (pt->fun == fun) {
						if (prev) {
								if (!__sync_bool_compare_and_swap(&prev->next,
														pt, pt->next))
										goto start;
						} else {
								if (!__sync_bool_compare_and_swap(&irq_funs[irq - 1],
														pt, pt->next))
										goto start;
						}
						kfree(pt);
						return 1;
				}
				prev = pt;
				pt = pt->next;
		}
		return 0;
}

/**********  MSI Support  ************************************************/
extern void msi_handler(unsigned int msi)
{
		iprintf("MSI %u received on processor %u\n", msi, smp_processor_id());
}
/*************************************************************************/
volatile void (*irq0_hook)() = NULL;
volatile void (*apic_hook)() = NULL;
extern void irq_handler(unsigned int irq)
{
		int spurious = 0; void (*hook)();
		uint16_t isr;

	//	if (irq)
	//			printf("IRQ %u\n", irq);
		if (irq >= 8) { /* check if intr from I/O APIC */
				isr = pic_get_isr();
				if (!isr) { /* we have a PCI interrupt */
						iprintf("PCI IRQ %u\n", irq);
						framebuffer_redraw(&fb_initial);
						forward_irq(irq);
						apic_reg(APIC_REG_EOI) = 0;
						return; /* don't signal the PIC */
				}
		}
		switch (irq) {
				case 0:
					if ((hook = irq0_hook))
							hook();
					ktimer_tick();
					break;
				case 1:
					kbd_handler();
					break;
				case 3:
				case 4:
					com_interrupt(irq);
					break;
				case 7:
					if (!(pic_get_isr() & (1 << 7)))
							spurious = 1;
					break;
				case 15:
					if (irq == 15 && !(pic_get_isr() & (1 << 15)))
							spurious = 1;
					break;
				default:
		/*			printf("IRQ with no associated handler received\n"
						"this line should be masked in the PIC and never raised\n"
						"the interrupt will be ignored, but declared as handled to the PIC\n"
						"The IRQ is number %u\n", irq); <- forward_irq */
					break;
		}
		if(!spurious && irq > 7) /* ack to slave if needed */
				outb(PIC2, 0x20);
		if (!spurious || irq > 7)
				outb(PIC1, 0x20); /* ack interrupt (even sp. from slave) */
		if (!spurious && irq)
				forward_irq(irq);

		/* now schedule on irq0 */
		void task_schedule_isr(void*);
		if (!irq)
				task_schedule_isr(*(void**)(&irq + 1));
}

extern unsigned int nmi_handler(unsigned char port_b, unsigned char port_a)
{
		int i, j;
		if (port_a & 0x10) {
				/* watchdog timer -> no abort */
				printf("NMI watchdog received\n");
				return 0;
		}
		if (port_b & 0x40)
				printf("Hardware bus channel error\n");
		else if (port_b & 0x80)
				printf("Memory read/write error\n");
		else
				printf("Unknown NMI error A=%x, B=%x\n", port_a, port_b);
		puts("restarting");
		for (i = 0; i < 3; i++) {
				for (j = 0; j < INT_MAX; j++);
				putchar('.');
		}
		putchar('\n');
		return 1;
}

int mm_handle_pagefault(struct mm* mm, void* eip, uint32_t seg_error, void* cr2);
extern void segment_handler(void* eip, unsigned int seg_error, void* cr2, unsigned int type)
{
		const char* tp = "#UNKNOWN";
		switch(type) {
				case 0: tp = "#TS"; break;
				case 1: tp = "#NP"; break;
				case 2: tp = "#SS"; break;
				case 3: tp = "#GP"; break;
				case 4: tp = "#PF"; break;
		}
		if (type == 4) {
				if(mm_handle_pagefault(&mm_kernel, eip, seg_error, cr2) == 0)
						return; /* continue execution */
		}
		cprintf(KFMT_INFO, "Segment exception handler: %s at %p with error %x (cr2=%p)\n",
						tp, eip, seg_error, cr2);
		if (seg_error != 4) {
				/* decode segment error */
				printf("The segment error originated %s and"
						" references the %s descriptor table"
						" at index 0x%x\n",
						(seg_error & 1) ? "external" : "internal",
						(seg_error & 2) ? "interrupt" : ((seg_error & 4) ? "local" : "global"),
					  (seg_error & 0xffff8) >> 3);
				print_stacktrace();
				die("segment death\n");
		} else
				die("unfixable #PF\n");
}

extern void PIC_remap(uint8_t ofs1, uint8_t ofs2)
{
		uint8_t a1, a2;

		a1 = inb(PIC1_DATA);                      /* save the masks */
		a2 = inb(PIC2_DATA);

		outb(PIC1_COMMAND, ICW1_INIT+ICW1_ICW4);  /* start the initialization */
		io_wait();                                /* expects 3 control bytes */
		outb(PIC2_COMMAND, ICW1_INIT+ICW1_ICW4);
		io_wait();
		outb(PIC1_DATA, ofs1);                    /* master gate offset */
		io_wait();
		outb(PIC2_DATA, ofs2);                    /* slave gate offset */
		io_wait();
		outb(PIC1_DATA, 4);                       /* tell master of the presence */
		io_wait();                                /* of slave at IRQ2 (1<<2) */
		outb(PIC2_DATA, 2);                       /* tell slave it's second */
		io_wait();                                /* in cascade */

		outb(PIC1_DATA, ICW4_8086);               /* master in standard mode */
		io_wait();
		outb(PIC2_DATA, ICW4_8086);               /* slave in standard mode */
		io_wait();

		outb(PIC1_DATA, a1);                      /* restore saved masks */
		outb(PIC2_DATA, a2);

		cprintf(KFMT_INFO, "PICs remapped to %x and %x with masks %x and %x\n",
						ofs1, ofs2, a1, a2);
}


int cmos_is_updating()
{
		outb(CMOS_CH_INDEX, 0x0a);
		/*io_wait();*/
		return inb(CMOS_CH_DATA) & 0x80;
}

unsigned char cmos_get_register(unsigned char reg)
{
		outb(CMOS_CH_INDEX, reg);
		/*io_wait();*/
		return inb(CMOS_CH_DATA);
}

/* relative to 1AD */
#define COUNT_LEAPS(Y)   ( ((Y)-1)/4 - ((Y)-1)/100 + ((Y)-1)/400 )
#define COUNT_DAYS(Y)  ( ((Y)-1)*365 + COUNT_LEAPS(Y) )
#define IS_LEAP_YEAR(Y)     ( ((Y)>0) && !((Y)%4) && ( ((Y)%100) || !((Y)%400) ) )
struct tm cmos_get_time()
{
		struct tm rv = {0}, rvb = {0};
		struct tm* pt = &rv; uint8_t regB;
		while (1) {
				while (cmos_is_updating()); /* busy spin (maybe called by ihander */
				pt->tm_sec = cmos_get_register(0);
				pt->tm_min = cmos_get_register(2);
				pt->tm_hour = cmos_get_register(4);
				pt->tm_wday = cmos_get_register(6);// - 1;
				pt->tm_mday = cmos_get_register(7);
				pt->tm_mon = cmos_get_register(8);
				pt->tm_year = cmos_get_register(9);
				pt->tm_year |= (cmos_get_register(0x32) << 8); /* century or bogus data */
				if (pt == &rv)
						pt = &rvb;
				else if (rv.tm_sec != rvb.tm_sec ||
								rv.tm_min != rvb.tm_min ||
								rv.tm_hour != rvb.tm_hour ||
								rv.tm_wday != rvb.tm_wday ||
								rv.tm_mday != rvb.tm_mday ||
								rv.tm_mon != rvb.tm_mon ||
								rv.tm_year != rvb.tm_year)
						pt = &rv;
				else
						break;
		}
		/* possibly convert BCD & 24h clock */
		regB = cmos_get_register(0x0b);
		if (!(regB & 0x04)) {
				pt->tm_sec = (pt->tm_sec & 0xf) + ((pt->tm_sec / 16) * 10);
				pt->tm_min = (pt->tm_min & 0xf) + ((pt->tm_min / 16) * 10);
				pt->tm_hour = (pt->tm_hour & 0x80) | ((pt->tm_hour & 0xf) + (((pt->tm_hour & 0x70) / 16) * 10));
				pt->tm_wday = (pt->tm_wday & 0xf) + ((pt->tm_wday / 16) * 10);
				pt->tm_mday = (pt->tm_mday & 0xf) + ((pt->tm_mday / 16) * 10);
				pt->tm_mon = (pt->tm_mon & 0xf) + ((pt->tm_mon / 16) * 10);
				pt->tm_year = ((pt->tm_year & 0xf) + ((pt->tm_year / 16) * 10))
						| ((((pt->tm_year & 0xf) >> 8) + ((((pt->tm_year & 0xf000) >> 8) / 16) * 10)) << 8);
		}
		if (!(regB & 0x02) && (pt->tm_hour & 0x80))
				pt->tm_hour = (((pt->tm_hour & 0x7f) + 12) % 24);
		/* convert century */
		pt->tm_year = 100 * ((pt->tm_year & 0xff00) >> 8) + (pt->tm_year & 0xff);
		/* use C standard definition */
		pt->tm_year -= 1900;
		pt->tm_yday = pt->tm_mday - 1;
		static const int dayct_nl[] = { 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334 };
		static const int dayct_lp[] = { 0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335 };
		pt->tm_mon -= 1;
		if (IS_LEAP_YEAR(pt->tm_year + 1900))
				pt->tm_yday += dayct_lp[pt->tm_mon];
		else
				pt->tm_yday += dayct_nl[pt->tm_mon];
		
		return *pt;
}

/* TODO: TLS for errno */
int errno = 0;
/*struct cti cti = {1};*/
struct perf_ctrs bp_pc = {0,0,0,0};
struct perf_ctrs* bp_tick = &bp_pc;
uint64_t km_set = 0, counter_print = 0, counter_sec = 0;
struct kio_region km_regS = { 60, 0, 20, 5, 0, 0, 0x27, KIO_REGION_NO_DELAY | KIO_REGION_NO_SCROLL, 0, 0, SPIN_LOCK_UNLOCKED };
struct kio_region km_regC = { 60, 23, 20, 2, 0, 0, 0x0f, KIO_REGION_NO_DELAY | KIO_REGION_NO_SCROLL, 0, 0, SPIN_LOCK_UNLOCKED };
struct tm km_time = {0};
size_t h_stats[4] = {0}, h_stats_old[4] = {0};

void kernel_fb_resize()
{
		km_regS.x = fb_initial.width - 20;
		km_regC.x = fb_initial.width - 20;
		km_regC.y = fb_initial.height - 2;
}

void second_tick()
{
		extern void task_do_stats();
		/* only check every second */
		if(((jiffies - km_set) > CMOS_THRESHOLD)) {
				km_time = cmos_get_time();
				km_set = jiffies;
		}
		task_do_stats();
		/* update the display time */
		{
				double scs = (double)jiffies / HZ;
				uint32_t secs = 0, mins = 0, hrs = 0, days = 0;
				static uint32_t old_sc = 0;
				km_regS.cur_x = 4;
				km_regS.cur_y = 2;
				/* format uptime */
				days = (uint32_t)(scs / 86400.0f);
				scs -= 86400.0f * days;
				hrs = (uint32_t)(scs / 3600.0f);
				scs -= 3600.0f * hrs;
				mins = (uint32_t)(scs / 60.0f);
				scs -= 60.0f * mins;
				secs = (uint32_t)(scs);
				if (secs != old_sc) {
						crprintf(0x2f, &km_regS, "%ud %uh %um %us\n", days, hrs, mins, secs);
						old_sc = secs;
				}
				/* and print time and date if present */
				km_regS.cur_x = 0;
				km_regS.cur_y = 3;
				if (km_time.tm_year) {
						uint32_t adsec = ((double)(jiffies - km_set) / HZ);
						struct tm ta = km_time;
						ta.tm_sec += adsec;
						if (ta.tm_sec > 59) {
								ta.tm_min += ta.tm_sec / 60;
								ta.tm_sec %= 60;
						}
						if (ta.tm_min > 59) {
								ta.tm_hour += ta.tm_min / 60;
								ta.tm_min %= 60;
						}
						if (ta.tm_hour > 23) {
								ta.tm_mday += ta.tm_hour / 24;
								ta.tm_wday += ta.tm_hour / 24;
								ta.tm_yday += ta.tm_hour / 24;
								ta.tm_hour %= 24;
						}
						if (ta.tm_wday > 6) {
								ta.tm_wday %= 7;
						}
						/* ignore the rest as it is only informational */
						if (adsec)
								crprintf(0x2f, &km_regS, "date: %d-%d-%d (%d)\ntime: %d:%02d:%02d",
										1900 + ta.tm_year,
										ta.tm_mon + 1, ta.tm_mday,
										ta.tm_wday, ta.tm_hour,
										ta.tm_min, ta.tm_sec);
				}
		}
		/* redraw the cpu-usage diagram */
		{
				void putc_prc(struct kio_region* cr, char fmt, char c,
								unsigned short x, unsigned short y);
				extern struct {
						uint32_t vals[8]; /* i k u ni pi pk pu pni */
				} *cpu_pcs;
				const uint16_t gran = 10;
				uint16_t l_k, l_n, l_u, pc_a, pc_b;
				/* calculate the limits from granularity */
				l_k = 1 + (gran * cpu_pcs[0].vals[1]) / 100;
				l_n = 1 + (gran * (cpu_pcs[0].vals[1] + cpu_pcs[0].vals[3])) / 100;
				l_u = 1 + (gran * (cpu_pcs[0].vals[1] + cpu_pcs[0].vals[3] 
										+ cpu_pcs[0].vals[2])) / 100;
				/* put the brackets there */
				putc_prc(&km_regC, KFMT_NORMAL, '[', 0, 0);
				putc_prc(&km_regC, KFMT_NORMAL, ']', 11, 0);
				/* and now the percentage */
				for (uint16_t i = 1; i < 1 + gran; i++) {
						if (i < l_k)
								putc_prc(&km_regC, KFMT_ERROR, '|', i, 0);
						else if (i < l_n)
								putc_prc(&km_regC, KFMT_WARN, '|', i, 0);
						else if (i < l_u)
								putc_prc(&km_regC, KFMT_INFO, '|', i, 0);
						else
								putc_prc(&km_regC, KFMT_NORMAL, ' ', i, 0);
				}
				/* also written */
				km_regC.cur_y = 0;
				km_regC.cur_x = 2 + gran;
				pc_a = min(100, 100 - cpu_pcs[0].vals[0] - ((cpu_pcs[0].vals[4] > 0)
								? 1 : 0));
				pc_b = min(9, 10 - cpu_pcs[0].vals[4]);
				if (pc_a == 100)
						pc_b = 0;
				crprintf(KFMT_NORMAL, &km_regC, "%3u.%1u%%", pc_a, pc_b);
		}
}

void print_counter()
{
		extern uint64_t fb_rdt; uint64_t rdt; const char* tp = "";
		if (counter_print == jiffies) /* limit the updates */
				return;
		counter_print = jiffies;
		if (tsc_per_ms) {
				tp = " ns";
				rdt = fb_rdt * 1000000 / tsc_per_ms;
				if (rdt > 99999) {
						rdt /= 1000;
						tp = " mu";
				}
				if (rdt > 99999) {
						rdt /= 1000;
						tp = " ms";
				}
		} else
				rdt = fb_rdt;
		km_regC.cur_x = 0; km_regC.cur_y = 1;
		rprintf(&km_regC, "%7llu: %7llu%s", counter_print, rdt, tp);
		if ((jiffies - counter_sec) > HZ || !counter_sec) {
				if (!counter_sec)
						counter_sec = jiffies;
				else
						counter_sec += HZ;
				second_tick();
		}

		/* update memory stats faster than every second! really? */
		km_regS.cur_x = 0;
		km_regS.cur_y = 1;
		
		void kstats(size_t* s_total, size_t* s_commit,
					   	size_t* s_free, size_t* s_nheaps);
		kstats(h_stats, h_stats + 1, h_stats + 2, h_stats + 3);
		for (size_t i = 0; i < 4; i++)
				if (h_stats_old[i] != h_stats[i]) {
						crprintf(0x2f, &km_regS, "%4uk %4u%s %2u %4uk", (h_stats[0]) / 1024,
								h_stats[1] >= 100000 ? h_stats[1] / 1024 : h_stats[1],
								h_stats[1] >= 100000 ? "k" : ((h_stats[1] >= 10000) ? "" : " "),
								h_stats[3], (h_stats[2]) / 1024);
						for (; i < 4; i++)
								h_stats_old[i] = h_stats[i];
						break;
				}
}

/* this is the workhorse used for time-keeping */
void ktimer_tick()
{
		extern uint64_t fb_udc;
		extern uint64_t fb_rdc;
		extern uint64_t fb_rdt;
		/* timekeeping */
		jiffies++;
		if (irq0_hook) /* don't starve bogo_mips calculation */
				return;

		static volatile int redr = 0;
		extern int preempt_needs_init;
		if (preempt_needs_init && !redr--) {
				redr = 10;
				print_counter();
				framebuffer_redraw_updates(&fb_initial);
		}
}

void kredraw(void* data)
{
		while (1) {
				extern struct wait_queue_head wq_timer;
				print_counter();
				//asm("cli");
				preempt_disable();
				framebuffer_redraw_updates(&fb_initial);
				preempt_enable_no_resched();
				//asm("sti");
				wait_timeout(&wq_timer, HZ / 60);
		}
}

int clock_gettime(clockid_t clk_id, struct timespec* tp)
{
		if (!tp || clk_id != CLOCK_REALTIME) {
				errno = EINVAL;
				return -1;
		}
		/* query the cmos for REALTIME if needed */
		if (!km_set) {
				km_time = cmos_get_time();
				km_set = jiffies;
		}
		tp->tv_nsec = 0;
		if (1 == 2) {
				/* questionable as it takes a microsecond to get nanosec prec */
				uint16_t ct; /* should cli restore i; but data not critical */
				/* fill the nsec from the counter (costly) */
				outb(PIT1_CTR, 0b00000000); /* latch timer of CH0 */
				ct = inb(PIT1_CH0);
				ct |= (uint16_t)inb(PIT1_CH0) << 8;
				ct = (uint16_t)(PIT_FREQ / CLOCKS_PER_SEC) - ct;
				tp->tv_nsec += (long)((double)(uint32_t)ct * 1000000 / PIT_FREQ);
		}
		/* calculate the number of leap days since 1970 */
		time_t diff = jiffies - km_set;
		tp->tv_nsec = diff - (time_t)((time_t)(diff / CLOCKS_PER_SEC) * CLOCKS_PER_SEC);
		tp->tv_nsec = (long)((tp->tv_nsec * 1000000) / CLOCKS_PER_SEC);
		tp->tv_sec = 86400 * ((COUNT_DAYS(1900 + km_time.tm_year) - COUNT_DAYS(1970))
						+ km_time.tm_yday) + 3600 * km_time.tm_hour
						+ 60 * km_time.tm_min + km_time.tm_sec
						+ (time_t)(diff / CLOCKS_PER_SEC);
		return 0;
}

uint32_t loops_per_jiffy = 0, loops_per_ms = INT_MAX / 150 / 100;
uint64_t tsc_per_ms = 0;
void calibrate_bogo_mips(uint16_t pit_div)
{
		static uint32_t ct = 0, old_ct = 0, delta[8] = {0}, ni = 0;
		static uint64_t ts_delta[8], ts_ct = 0;
		uint32_t limit = 0x00f00000; /* very low for QEMU-software emu */
		void hook_fun() {
				ni++;
				if (old_ct && ni <= 9) {
						delta[ni - 2] = ct - old_ct;
						if (cpu.has_tsc)
								asm volatile ("rdtsc" : "=A" (ts_delta[ni - 2]));
				}
				old_ct = ct;
				if (ni >= 9)
						irq0_hook = NULL;
		}

		printf("calibrating bogous MIPS value...\n");
		/* do the adaptive loop
		 * if limit needs to be > 32bit we're f'ed  */
		do {
				/* zero the variables */
				ct = old_ct = ni = 0;
				/* (re-)install the irq0 hook */
				irq0_hook = hook_fun;
				for (ct = 0; ct < limit; ct++);
				if (ni < 9) { /* unusable -> redo */
						limit <<= 4;
						printf("increasing bogous MIPS calibration loop limit to %x\n", limit);
						/* wait for hook self-removal */
						while (irq0_hook);
						ni = 0;
				}
		} while (ni < 9);

		/* now we have 8 positive delta values for
		 * calibrating bogo_mips each div ticks apart */
		old_ct = 0;
		for (ct = 0; ct < 8; ct++) {
				printf("%u: %08x\n", ct, delta[ct]);
				old_ct += delta[ct];
				if (cpu.has_tsc && ct)
						ts_ct += ts_delta[ct] - ts_delta[ct - 1];
		}
		old_ct /= 8;
		if (cpu.has_tsc)
				ts_ct /= 7;
		printf("Bougous MIPS calibrated to %08x steps per PIT tick with a "
				"PIT divider of %u\n", old_ct, pit_div);
		loops_per_jiffy = old_ct;
		printf("Therefore a delay of 1 ms corresponds to %u steps.\n",
				(loops_per_ms = (uint32_t)(HZ * (uint64_t)old_ct / 1000)));
		if (cpu.has_tsc) {
				printf("As this CPU has a TSC a PIT tick corresponds to %llu "
						"TSC ticks --> %llu ticks per ms.\n", ts_ct,
					   (tsc_per_ms = HZ * ts_ct / 1000));
		}
}

void ndelay(unsigned long nsecs)
{
		uint32_t ct = 0, limit = (uint32_t)((uint64_t)nsecs * loops_per_ms / 1000000);
		/* uses the same double mem-access
		 * as in the calibration routine */
		for (ct = 0; ct < limit; ct++);
}

void udelay(unsigned long usecs)
{
		while (usecs--)
				ndelay(1000);
}

void mdelay(unsigned long msecs)
{
		if (!loops_per_ms)
				return;
		while (msecs--)
				udelay(1000);
}

uint32_t apic_reload_value = 0x0fffffff;
uint8_t apic_div = 0x0b;
#define NCF_AP 48
static uint32_t n_ct = 0xffffffff, exp = 0; static uint32_t tmr_val = 0;
/* the expiration hook */
void apic_expire() {
		if (!exp) /* don't unsignal 2 (done) */
				exp = 1;
}

/* the irq0 calibration worker */
void irq0_worker() {
		if (n_ct == 0xffffffff) {
				/* enable the timer */
				apic_bp_reg(APIC_REG_TMRDIV) = apic_div;
				apic_bp_reg(APIC_REG_TMRINITCNT) = 0xffffffff;
				n_ct = 0;
				return;
		} else if (exp) {
				/* timer has expired and sample is too small */
				n_ct = 0xffffffff; exp = 0; tmr_val = 0;
				if (apic_div == 0x0b)
						apic_div = 1;
				else {
						/* bits: 3210; 2=R=0, bin: 2-128, 1 */
						uint8_t val = (((apic_div & 0x08) >> 1) | (apic_div & 0x03));
						val++;
						apic_div = ((val & 0x04) << 1) | (val & 0x03);
						if (apic_div == 0x0b)
								die("unable to divide high enough!\n");
				}
		} else if (n_ct < NCF_AP - 1)
				n_ct++;
		else {
				/* remove one of the hooks */
				tmr_val = apic_bp_reg(APIC_REG_TMRCURRCNT);
				irq0_hook = NULL;
				exp = 2;
		}
}

/* function is already during preemption */
void apic_timer_setup()
{
		/* strategy: set a irq0-hook which initializes the apic timer
		 * and reads the count(s) on the next iteration(s). If the
		 * APIC timer expires before completion the divider is increased. */

		/* enable the timer function of the BP */
		printf("calibrating BP APIC timer...\n");
		/* (val << 16): R00M=one-shot, R01M per, R11M tsc, R=res, M=mask */
		apic_bp_reg(APIC_REG_LVT_TMR) = 0x00000000 | 0x3d; /* one-shot */

		/* now perform the work */
		preempt_disable();
		apic_hook = apic_expire;
		irq0_hook = irq0_worker;

		/* wait for completion */
		while (exp != 2);

		/* disarm the bp timer for now */
		apic_bp_reg(APIC_REG_TMRINITCNT) = 0;

		/* remove the apic hook (possible rc? nope; intr preempts this)*/
		apic_hook = NULL;

		/* reenable preemption */
		preempt_enable();

		/* calculate the tick values */
		tmr_val = (0xffffffff - tmr_val) / NCF_AP;
		printf("On average: %08x APIC timer ticks per PIT interrupt.\n", tmr_val);
		apic_reload_value = tmr_val;
		{
				uint64_t freq = ((uint64_t)HZ * tmr_val);
				uint32_t mhz = (uint32_t)(freq / 1000000);
				uint32_t khz = (uint32_t)(freq % 1000000) / 1000;
				cprintf(KFMT_INFO, "This results in an APIC timer frequency of %u.%03u MHz\n",
						mhz, khz);
		}
}

void timer_setup()
{
		uint8_t bt; const char* ams[4] = {"latch", "lo", "hi", "lo/hi"};
		uint16_t div; uint64_t tmv;
		const char* oms[8] = {
				"int on count", "one-shot counter",
				"rate generator", "square wave generator",
				"software strobe", "hardware strobe",
				"rate generator", "square wave generator"
		};
		__asm__("cli");
		km_time = cmos_get_time();
		km_set = jiffies; /* should be counter but alas */
		/* get info on the status of the timer */
		outb(PIT1_CTR, 0b11010010); /* latch status of CH0 */
		bt = inb(PIT1_CH0);
		printf("PIT1_CH0 status is %08b\n", bt);
		printf("with access mode: %s\n", ams[(bt >> 4) & 0x03]);
		printf("and operating mode: %s\n", oms[(bt >> 1) & 0x07]);
		/* change the mode */
		printf("timer will be set to rate generator lo/hi mode\n");
		outb(PIT1_CTR, 0b00110110); /* binary CH0 lohi rategen */
		/* and the divisor */
		printf("divisor for HZ=%d: %u\n", HZ, 1193182u / HZ);
		//div = 9861; //11931; //0xffff;
		div = 1193182u / HZ;
		//printf("with a divisor of %u\n", div);
		//printf("resulting in a frequency of ~%u Hz\n", 1193182u / div);
		outb(PIT1_CH0, div & 0xff);
		outb(PIT1_CH0, (div >> 8) & 0xff);
		__asm__("sti");
		calibrate_bogo_mips(div);
		printf("done\n");
		/* testing the resolution */
		printf("delaying execution for 200 ms...\n");
		tmv = jiffies;
		mdelay(200);
		cprintf(KFMT_INFO, "%u jiffies have passed, with HZ=%d this corresponds"
				" to %u ms, resulting in a deviation of %+d ms\n",
				(uint32_t)(jiffies - tmv), HZ, (uint32_t)((jiffies - tmv) * 1000 / HZ),
				(int32_t)((jiffies - tmv) * 1000 / HZ) - 200);
}

//uint32_t apic_tick_ct = 0;
void apic_tick()
{
		//apic_tick_ct++;
		//if (apic_tick_ct % (10 * nproc * HZ) == 0)
		//		printf("APIC %08x received timer interrupt (global ct=%u)\n",
		//				apic_reg(APIC_REG_APICID), apic_tick_ct);
		apic_reg(APIC_REG_TMRINITCNT) = apic_reload_value;
		per_cpu_ptr()->ticks->tick++;
}

void apic_ipi()
{
		printf("APIC %x (TPR=%x) received IPI\n", apic_reg(APIC_REG_APICID),
				apic_reg(APIC_REG_TASKPRIOR));
		//printf("Current timer value %x\n", apic_reg(APIC_REG_TMRCURRCNT));
}

/* kernel entry point of APs */
extern void ap_entry()
{
		void enable_sse();
		enable_sse(); /* avoid hangups form sched. kredraw (using sse) */
		/* local APIC init */
		extern void ap_apic_init(); /* PCP works afterwards */
		ap_apic_init();
		/* prevent death by empty queues */
		extern void kidle(void*);
		/* two per proc for the worst-case */
		task_spawn(kidle, NULL, PRIORITY_MIN);
		task_spawn(kidle, NULL, PRIORITY_MIN);
		/* signal we don't need the trampoline anymore */
		extern uint8_t ap_start;
		ap_start = 0; /* still unsafe as task_schedule builds a stack frame */
		/* TODO: per-cpu tasks & runqueues */
		/* switch to stack of task (sti included in eflags of tasks) */
		extern void task_schedule(struct tsi*);
		task_schedule(NULL);
		/* should never return */
		while (1); /* DBG: busy wait */
}

/* About MP stacks and TSS:
 * Kernel stack in ring0 -> interrupt on same stack -> 1 global stack per task
 * Usermode ring 3 stacks -> on interrupt switch to stack in per-processor TSS
 * which could be interrupted, preempted -> for each user stack a TSS is needed
 * TSS stacks can also be transferred between processors -> all stacks bound to
 * tasks, i.e. no processor-specific stacks needed.
 */

extern void apic_handler(uint32_t intr)
{
		static uint32_t num_spr = 0;
		switch (intr) {
			case 0:
				printf("APIC %x received error %08x\n",
					apic_reg(APIC_REG_APICID), apic_reg(APIC_REG_ESR));
				/* rearm the error register */
				apic_reg(APIC_REG_ESR) = 0;
				apic_reg(APIC_REG_EOI) = 0;
				break;
			case 1: {
				void (*hook)() = apic_hook;
				if (hook)
						hook();
				else
						apic_tick();
				apic_reg(APIC_REG_EOI) = 0;
				break;
				}
			case 2:
				apic_ipi();
				apic_reg(APIC_REG_EOI) = 0;
				break;
			case 3: /* don't ack the spurious interrupt */
				num_spr++;
				break;
			default:
				cprintf(KFMT_WARN, "unknown APIC intr %x received\n", intr);
				break;
		}
		if (intr == 1) {
				void task_schedule_isr(void*);
				task_schedule_isr(*(void**)(&intr + 1));
		}
}

static int calc_state = 0, calc_thr = 0, calc_print = 0;

void fun2(uint32_t* f) {
		while (1) {
				if (!calc_state)
						task_yield();
				else {
						int v = calc_thr;
						if ((v < 1) && __sync_bool_compare_and_swap(&calc_thr, v, v + 1))
								break;
				}
				for (size_t i = 0; i < 0xffffffff; i++);
				__sync_fetch_and_add(f, 1);
		}
}

void calc_thread(void* data)
{
		uint32_t val = 0; uint64_t to = 0; int upd;
		calc_state = 1;
		/* test er */
		/* here we do the integer calculations */
		while (1) {
				if (!calc_state)
						task_yield();
				for (size_t i = 0; i < 0xffffffff; i++);
				__sync_fetch_and_add(&val, 1);
				upd = time_after(jiffies, to);
				if (calc_print == 1 || (calc_print == 2 && upd)){
						printf("calculation result: %u\n", val);
						if (calc_print == 2)
								to = jiffies + 5 * HZ; /* print every 5 seconds */
						else
								calc_print = 0; /* print once */
				}
				while (calc_thr >= 2) {
						task_spawn(fun2, &val, PRIORITY_REGULAR);
						calc_thr--;
				}
		}
}

void calc_fun(const char* arg)
{
		int sel = atoi(arg);
		switch (sel) {
			case 0:
			default:
				printf("calc arg: starts/stops and shows the background\n"
				       "          test calculations. arg is a number with:\n"
					   "          1 - stop the calculations\n"
					   "          2 - start/resume the calculations\n"
					   "          3 - show the current results\n"
					   "          4 - show the results periodically\n"
					   "          5 - add a worker thread\n"
					   "          6 - add 5 worker threads\n"
					   "          7 - add 15 worker threads\n"
					   "          8 - remove a worker thread\n"
					   "          9 - remove 5 worker threads\n");
				break;
			case 1:
				calc_state = 0;
				break;
			case 2:
				if (!calc_thr) {
						task_spawn(calc_thread, NULL, PRIORITY_REGULAR);
						calc_thr = 1;
						//calc_state = 1;
				} else
						calc_state = 1;
				break;
			case 3:
				calc_print = 1;
				break;
			case 4:
				calc_print = 2;
				break;
			case 5:
				if (calc_thr)
						calc_thr++;
				break;
			case 6:
				if (calc_thr)
						calc_thr += 5;
				break;
			case 7:
				if (calc_thr)
						calc_thr += 15;
				break;
			case 8:
				if (calc_thr)
						calc_thr--;
				break;
			case 9:
				if (calc_thr)
						calc_thr -= 5;
				break;
		}
}
/*int sleep(unsigned int seconds)
{
		unsigned int now = counter;
		do {
				kbd_process_queue();
*/				/* for now only here */
				//mmgr_page_scrub();
/*				__asm__("hlt");
		} while ((unsigned int)((double)(counter - now) / CLOCKS_PER_SEC) < seconds);
		return 0;
}*/

void enable_sse()
{
		/* enable SSE if present */
		uint32_t eax, ebx, ecx, edx;
		__cpuid(1, eax, ebx, ecx, edx);
		if (edx & (1<< 25)) {
#ifdef __x86_64__
				asm("mov %%cr0, %%rax\n"
					"or $2, %%rax\n"
					"and $0xfb, %%al\n"
					"mov %%rax, %%cr0\n"
					"mov %%cr4, %%rax\n"
					"or $0x0600, %%ax\n"
					"mov %%rax, %%cr4\n"
					: : : "rax");
#else
				asm("mov %%cr0, %%eax\n"
					"or $2, %%eax\n"
					"and $0xfffffffb, %%eax\n"
					"mov %%eax, %%cr0\n"
					: : : "eax"); /* clear em(2); set mp(1) bit */
				asm("mov %%cr4, %%eax\n"
					"or $0x00000600, %%eax\n"
					"mov %%eax, %%cr4\n"
					: : : "eax"); /* set oxfxsr osxmmexcpt */
#endif
		}
}

void do_cpuid()
{
		uint32_t eax, ebx, ecx, edx;
		cpu.max_leaf = __get_cpuid_max(0, NULL);
		cpu.max_eleaf = __get_cpuid_max(0x80000000, NULL);
		__cpuid(0, eax, ebx, ecx, edx);
		((int*)cpu.vendor_id)[0] = ebx;
		((int*)cpu.vendor_id)[1] = edx;
		((int*)cpu.vendor_id)[2] = ecx;
		((int*)cpu.vendor_id)[3] = 0;
		if (cpu.max_leaf > 0) {
				__cpuid(1, eax, ebx, ecx, edx);
				cpu.feat_eax = eax;
				cpu.feat_ecx = ecx;
				cpu.feat_edx = edx;
				cpu.feat_ebx = ebx;
		}
		if (cpu.max_eleaf > 0x80000000) {
				__cpuid(0x80000001, eax, ebx, ecx, edx);
				cpu.efeat_eax = eax;
				cpu.efeat_ebx = ebx;
				cpu.efeat_ecx = ecx;
				cpu.efeat_edx = edx;
		}
		cpu.brand_string[0] = '\0';
		if (cpu.max_eleaf > 0x80000003) {
				/* get the brand string */
				uint32_t* pt = (uint32_t*)cpu.brand_string;
				for (uint32_t i = 1; i < 4; i++) {
						__cpuid(0x80000001 + i, eax, ebx, ecx, edx);
						*pt++ = eax;
						*pt++ = ebx;
						*pt++ = ecx;
						*pt++ = edx;
				}
		}
		if (cpu.max_eleaf >= 0x80000007 && cpu.has_tsc) {
				/* get invariant tsc */
				__cpuid(0x80000007, eax, ebx, ecx, edx);
				cpu.invariant_tsc = !!(edx & (1 << 8));
		}

		/* FIXME: using enable_sse due to framebuffer on x64 */
		enable_sse();
}
void cpu_info()
{
		printf("This cpu is \"%s\" and supports %u cpuid leaves and %u extended cpuid leaves\n",
						cpu.vendor_id, cpu.max_leaf, cpu.max_eleaf - 0x80000000);
		/* TODO: DBG! */
		//cpu.has_htt = 1;
		printf("Its main features are:\n");
		if (cpu.has_htt)
				printf("\tHyper-threading\n");
		if (cpu.has_pae)
				printf("\tPAE\n");
		if (cpu.has_apic)
				printf("\tAPIC\n");
		if (cpu.has_acpi)
				printf("\tACPI\n");
		printf("All features are:\n");
		printf("33222222222211111111110000000000\n");
		printf("10987654321098765432109876543210\n");
		printf("%032b\n", cpu.feat_eax);
		printf("%032b\n", cpu.feat_ebx);
		printf("%032b\n", cpu.feat_ecx);
		printf("%032b\n", cpu.feat_edx);
		if (cpu.max_eleaf > 0x80000000) {
				printf("The main extended features are:\n");
				if (cpu.e_pat)
						printf("\tPAT\n");
				if (cpu.e_has_mp)
						printf("\tMP capable\n");
				if (cpu.e_has_nx)
						printf("\tNX bit\n");
				if (cpu.e_has_longmode)
						printf("\tx86_64\n");
				printf("All extended features:\n");
				printf("%032b\n", cpu.efeat_eax);
				printf("%032b\n", cpu.efeat_ebx);
				printf("%032b\n", cpu.efeat_ecx);
				printf("%032b\n", cpu.efeat_edx);
		}
		if (cpu.max_eleaf >= 0x80000007 && cpu.has_tsc) {
				printf("The CPU's TSC is %s rate\n", cpu.invariant_tsc ? "constant" : "variable");
		}
		printf("The brand string is \"%s\"\n", cpu.brand_string);
}

extern void _start()
{
		extern int fb_no_malloc;
		/* set cpu to correct values */
		do_cpuid();

		/* transfer the frambuffer mappings */
		void fb_video_setup();
		fb_no_malloc = 1;
		fb_video_setup();

		/* transfer mmgr data from known locations */
		extern void mmgr_reinit();
		mmgr_reinit();
		fb_no_malloc = 0;


		/* use the correct GDT */
		extern void gdt_init();
		gdt_init();

		/* do the IDT setup & remap PIC */
		extern void idt_init();
		idt_init();
		PIC_remap(0x20, 0x28);
		asm("sti");

		/* protect null pointer */
		mm_unmap(&mm_kernel, NULL, 1);

		/* print cpu info */
		cpu_info();
		/* timekeeping setup */
		timer_setup();
		/* enable preemption (needed for MP init stacks) */
		/* enable preemption (calls kinit and never returns) */
		printf("starting preemption...\n");
		void preempt_init();
		preempt_init();

		cprintf(KFMT_ERROR, "preempt_init returned\n");
		while (1);
}

void kinit(void* data)
{
		cprintf(KFMT_OK, "kernel is now preemptive\n");
		/* APIC and MP init */
		if (cpu.has_apic) {
				extern void apic_init(); /* PCP works afterwards */
				apic_init();
		}
		region_clear(&km_regS);
		km_regS.cur_x = km_regS.cur_y = 0;
		region_puts(&km_regS, "total used  hp free\n\nup: ");
		/* Hardware detection and initialization */
		kbd_init();
		{
				char bt;
				printf("VGA IO base port (from 0x0463): %x\n", *(uint16_t*)(0x463));
				bt = inb(0x3cc);
				printf("VGA misc flags: %08b\n", bt);
/*				for (bt = 0; bt < 0xff; bt++) {*/
/*				outb(0x3d4, 0x0f); VGA CURSOR
				outb(0x3d5, 20);*/
/*				sleep(0);
				}*/
		}
		/* List the serial and printer ports */
		{
				uint16_t* ptr = (uint16_t*)0x400; int i;
				for (i = 0; i < 7; i++)
						if (ptr[i])
								if (i < 4) {
										printf("COM%d IO port: %u\n", i + 1, *ptr);
										enable_com(i, *ptr);
								} else
										printf("LPT%d IO port: %u\n", i - 3, *ptr);
						else
								if (i < 4)
										printf("COM%d not present\n", i + 1);
								else
										printf("LPT%d not present\n", i - 3);
		}
		/* Floppy devices */
		{
				uint8_t bt = cmos_get_register(0x10);
				uint8_t btM = (bt & 0xf0) >> 4;
				bt &= 0x0f;
				do {
						const char* drv;
						switch (btM != 0xff ? btM : bt) {
								case 0:
										drv = "no drive";
										break;
								case 1:
										drv = "360KiB 5.25\" drive";
										break;
								case 2:
										drv = "1.2MiB 5.25\" drive";
										break;
								case 3:
										drv = "720KiB 3.5\" drive";
										break;
								case 4:
										drv = "1.44MiB 3.5\" drive";
										break;
								case 5:
										drv = "2.88MiB 3.5\" drive";
										break;
								default:
										drv = "unknown";
										break;
						}
						printf("Floppy %s: %s\n", btM != 0xff ? "master" : "slave", drv);
						if (btM == 0xff)
								break;
						btM = 0xff;
				} while (1);
		}

		/* PCI enumeration */
		void load_modules();
		void fun();
		fun();
		load_modules();

		/* now go to the loop */
		void kloop();
		kloop();
}

/* performs scrubbing of pages at low priority */
void kscrub(void* data)
{
		while (1) {/* need_resched is checked periodically inside */
				extern struct wait_queue_head wq_timer;
				if (!mm_page_scrub())
						wait_timeout(&wq_timer, HZ);
		}
}

void kloop()
{
		/* file_cli */
		int (*fptr)(const char*) = locate_module_function("file_cli");
		void list_modules();
		void list_module_info(const char*);

		/* main loop */
		while (1) {
				char* str = 0; size_t n = 0;
				printf("enter text:\n");
				getline(&str, &n);
				if (str) {
						char* s2 = str;
						while (*s2++);
						if (s2 - 2 >= str)
								*(s2 - 2) = '\0';
						if (strcmp(str, "pt") == 0) {
								/* print tasks */
								void print_tasks();
								print_tasks();
						} else if (strncmp(str, "calc", 4) == 0) {
								/* start/stop show the calculations */
								calc_fun(str + 5);
						} else if (strcmp(str, "rds") == 0) {
								//framebuffer_redraw(&fb_initial);
								printf("%d %d\n", video_mode.width, video_mode.height);
								printf("%d %d\n", fb_initial.cho_x, fb_initial.cho_y);
								printf("%d %d\n", fb_initial.chw_x, fb_initial.chw_y);
								printf("%d %d\n", fb_initial.width, fb_initial.height);
								printf("regions:\n");
								printf("km_regC: %d %d %d %d\n", km_regC.x, km_regC.y, km_regC.lx, km_regC.ly);
								printf("km_regS: %d %d %d %d\n", km_regS.x, km_regS.y, km_regS.lx, km_regS.ly);
								framebuffer_update_region(&fb_initial, &km_regC);
						} else if (strcmp(str, "time") == 0) {
								struct timespec tsp; struct tm* ts = &km_time;
								km_time = cmos_get_time();
								km_set = jiffies;
								printf("upadting time from CMOS\n");
								clock_gettime(CLOCK_REALTIME, &tsp);
								printf("UNIX time: %llu.%lu\n", tsp.tv_sec, tsp.tv_nsec);
								printf("struct tm:\n");
								printf("tm_sec %d\n", ts->tm_sec);
								printf("tm_min %d\n", ts->tm_min);
								printf("tm_hour %d\n", ts->tm_hour);
								printf("tm_mday %d\n", ts->tm_mday);
								printf("tm_mon %d\n", ts->tm_mon);
								printf("tm_year %d\n", ts->tm_year);
								printf("tm_wday %d\n", ts->tm_wday);
								printf("tm_yday %d\n", ts->tm_yday);
								printf("tm_isdst %d\n", ts->tm_isdst);
						} else if(strcmp(str, "trhp") == 0) {
								unsigned int bval = 0xff;
								printf("trashing kernel heap\n");
								/* glibc rand */
								while (1) {
										printf("allocating %u bytes ...\n", (bval & 0xffff));
										printf("located at %p\n", kmalloc(bval & 0xffff));
										bval = (uint32_t)((1103515245*(uint64_t)bval+12345) % 0x80000000);
								}
						} else if (fptr && fptr(str)) {
								/* do nothing -> fptr() does it */
						} else if (strcmp(str, "lsmod") == 0)
								list_modules();
						else if (strncmp(str, "modinfo ", 7) == 0) {
								str += 8;
								list_module_info(str);
						} else if (strcmp(str, "com") == 0) {
								com_status();
						} else if (strcmp(str, "brk") == 0) {
								//breakpoint(); TODO reimpl.
						} else if (strncmp(str, "pma", 3) == 0) {
								int val;
								/* allocate pmem */
								val = atoi(str + 3);
								if (val) {
										struct page_range pr[10]; size_t rv;
										printf("allocating %d physical pages...\n", val);
										rv = mm_alloc_pm(pr, 10, val);
										printf("%u pages allocated\n", rv);
										for (rv = 0; rv < 10; rv++)
												if (!pr[rv].count)
														break;
												else
														printf("%u pages at %#08x%08x\n",
																	   pr[rv].count,
																	   (uint32_t)(pr[rv].base >> 32),
																	   (uint32_t)pr[rv].base);
								}
						} else if (strncmp(str, "pmf", 3) == 0) {
								long int val; char* ep;
								val = strtol(str + 3, &ep, 0);
								if (val) {
										int ct = atoi(ep);
										if (ct) {
												struct page_range pr;
												pr.base = val;
												pr.count = ct;
												printf("freeing %d physical pages at 0x%016llx\n",
																pr.count, pr.base);
												mm_free_pm(&pr, 1);
										}
								}
						} else if (strncmp(str, "pmu", 3) == 0) {
								long int val; char* ep;
								void mm_dump_pmu(size_t fm, size_t n, int is_rcp);
								val = strtol(str + 3, &ep, 0);
								if (val) {
										int ct = atoi(ep);
										if (ct)
												mm_dump_pmu(val, ct, 0);
								} else
										mm_dump_pmu(0, 0, 2);
						} else if (strncmp(str, "rcp", 3) == 0) {
								long int val; char* ep;
								void mm_dump_pmu(size_t fm, size_t n, int is_rcp);
								val = strtol(str + 3, &ep, 0);
								if (val) {
										int ct = atoi(ep);
										if (ct)
												mm_dump_pmu(val, ct, 1);
								} else
										mm_dump_pmu(0, 0, 2);
						} else if (strcmp(str, "reboot") == 0)
								pc_reset();
						else if (strcmp(str, "quit") == 0 || strcmp(str, "halt") == 0)
								pc_shutdown();
						else
								printf("Command \"%s\" read from keyboard is unrecognized\n", str);
						kfree(str);
				}
				//sleep(0);
		}
}

/* ringbuffer structures */
struct ringbuffer
{
		size_t cap;
		size_t ofs_start;
		size_t ofs_end;
		spinlock_t lock;
		char data[];
};

/* ringbuffer functions*/
void* ringbuffer_allocate(size_t init_cap)
{
		void** rvR, *rv;
		rvR = (void**)kmalloc(sizeof(void*));
		if (!rvR)
				return 0;
		if ((rv = kmalloc(init_cap + sizeof(struct ringbuffer)))) {
				struct ringbuffer* rbf = (struct ringbuffer*)rv;
				rbf->cap = init_cap;
				rbf->ofs_start = 0;
				rbf->ofs_end = 0;
				spin_lock_init(&rbf->lock);
				*rvR = rv;
				return (void*)rvR;
		} else
				kfree(rvR);
		return 0;
}

void ringbuffer_enqueue(void* rbi, const void* dat, size_t s)
{
		struct ringbuffer* rb = *(struct ringbuffer**)rbi;
	//	spin_lock(&rb->lock);
		const char* data = (const char*)dat;
		size_t cap = rb->cap;
		if (rb->ofs_end > rb->ofs_start)
				cap -= rb->ofs_end - rb->ofs_start;
		else
				cap -= rb->cap - rb->ofs_start + rb->ofs_end + 1;
		if (cap < s) {
				void* nrb;
				/* allocate new buffer and shuffle data */
				size_t nc = rb->cap + max(rb->cap, 4 * s + 1);
				if ((nrb = krealloc(rb, nc + sizeof(struct ringbuffer)))) {
						/* enough memory */
						rb = (struct ringbuffer*)nrb;
						*(void**)rbi = nrb;
						/* move old data (if wrapped) */
						if (rb->ofs_end < rb->ofs_start) {
								memcpy(rb->data + rb->cap, rb->data, rb->ofs_end);
								rb->ofs_end += rb->ofs_start;
						}
						rb->cap = nc;
				} else {
	//					spin_unlock(&rb->lock);
						return; /* OOM */
				}
		}
		while (s--) {
				if (rb->ofs_end == rb->cap)
						rb->ofs_end = 0;
				rb->data[rb->ofs_end++] = *(data++);
		}
//		spin_unlock(&rb->lock);
}

void ringbuffer_dequeue(void* rbi, void* dat, size_t s)
{
		struct ringbuffer* rb = *(struct ringbuffer**)rbi;
//		spin_lock(&rb->lock);
		char* data = (char*)dat;
		while (s--) {
				if (rb->ofs_end == rb->ofs_start) {
//						spin_unlock(&rb->lock);
						return;
				}
				*(data++) = rb->data[rb->ofs_start++];
				if (rb->ofs_start == rb->cap) {
						rb->ofs_start = 0;
						if (rb->ofs_end == rb->cap)
								rb->ofs_end = 0;
				}
		}
//		spin_unlock(&rb->lock);
}

size_t ringbuffer_available(void* rbi)
{
		struct ringbuffer* rb = *(struct ringbuffer**)rbi;
		if (rb->ofs_end < rb->ofs_start)
				return rb->cap - rb->ofs_start + rb->ofs_end;
		else
				return rb->ofs_end - rb->ofs_start;
}

void ringbuffer_free(void* rbi)
{
		struct ringbuffer* rbf = *(struct ringbuffer**)rbi;
		spin_lock(&rbf->lock);
		kfree(rbf);
		kfree(rbi);
}

/* locking functions */
/* linux ticket spin (better than xchg under high contention) */
#define ACCESS_ONCE(x) (*(volatile __typeof__(x)*)&(x))
void spin_lock(spinlock_t* lock)
{
		register spinlock_t inc;
		inc.head_tail = 1 << (8 * sizeof(ticket_t));

		inc.head_tail = __sync_fetch_and_add(&lock->head_tail, inc.head_tail);

		for (;;) {
				if (inc.tickets.head == inc.tickets.tail)
						break;
				_mm_pause();
				inc.tickets.head = ACCESS_ONCE(lock->tickets.head);
		}
}

void spin_lock_init(spinlock_t* lock)
{
		*lock = (spinlock_t){0};
}

void spin_lock_irq(spinlock_t* lock)
{
		asm("cli");
		spin_lock(lock);
}

void spin_lock_irqsave(spinlock_t* lock, unsigned long* flags)
{
		*flags = !if_enabled();
		asm("cli");
		preempt_disable();
		spin_lock(lock);
}

int spin_trylock(spinlock_t* lock)
{
		spinlock_t old, new;

		old.head_tail = ACCESS_ONCE(lock->head_tail);
		if (old.tickets.head != old.tickets.tail)
				return 0;

		new.head_tail = old.head_tail + (1 << (8 * sizeof(ticket_t)));
		return __sync_bool_compare_and_swap(&lock->head_tail, old.head_tail, new.head_tail);
}

int spin_trylock_irq(spinlock_t* lock)
{
		int rv;
		asm("cli");
		rv = spin_trylock(lock);
		if (rv)
				return rv;
		asm("sti");
		return rv;
}

int spin_trylock_irqsave(spinlock_t* lock, int* flags)
{
		int rv;
		*flags = if_enabled();
		asm("cli");
		preempt_disable();
		rv = spin_trylock(lock);
		if (!rv) {
				if (*flags)
						asm("sti");
				preempt_enable_no_resched();
		}
		return rv;
}

void spin_unlock(spinlock_t* lock)
{
		__sync_fetch_and_add(&lock->tickets.head, 1);
}

void spin_unlock_irq(spinlock_t* lock)
{
		spin_unlock(lock);
		asm("sti");
}

void spin_unlock_irqrestore(spinlock_t* lock, unsigned long flags)
{
		spin_unlock(lock);
		if (flags)
				asm("sti");
		preempt_enable_no_resched();
}

void read_lock(rwlock_t* lock)
{
		if (!__sync_fetch_and_add(&lock->cnts.counter, 1)) {
				/* first reader */
				spin_lock(&lock->lock);
		}
}

void read_unlock(rwlock_t* lock)
{
		if (!__sync_sub_and_fetch(&lock->cnts.counter, 1)) {
				/* last reader, allow writing again */
				spin_unlock(&lock->lock);
		}
}

void write_lock(rwlock_t* lock)
{
		spin_lock(&lock->lock);
}

int write_trylock(rwlock_t* lock)
{
		return spin_trylock(&lock->lock);
}

void write_unlock(rwlock_t* lock)
{
		spin_unlock(&lock->lock);
}

