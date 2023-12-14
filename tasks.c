/* tasks.c : Provides the implementation for scheduling and task switching.
 * */

#include "kernel.h"
#include "kdata.h"

#ifndef __clang__
STATIC_ASSERT(sizeof(struct tss)==104, tss_not_104_bytes);
#endif

int preempt_needs_init = 1;

struct stack_container {
		void* vm_base;
		void* vm_ptr;
		void* vm_top;
		size_t n_alloc;
		size_t n_res;
		size_t n_guard;
		void* free_stacks;
} kernel_stacks = { VM_KERNEL_STACK_BASE, VM_KERNEL_STACK_BASE, VM_KERNEL_STACK_LIMIT,
		7, 0, 1, NULL };
/* capacity for 512 stacks */
volatile struct tss main_tss = {0}, intr_tss = {0}; /* TSS for usermode proc1? */

/* STACK LAYOUT:
 * ------ vm_base ---------
 * STACK 1  n_res   reserved
 *          n_alloc mapped
 *          n_guard unallocated
 * ------------------------
 * STACK N
 * ------ vm_ptr ----------
 * ------ vm_top ----------
 * */
void* alloc_stack()
{
		void* rv;
		while (kernel_stacks.free_stacks) {
				rv = kernel_stacks.free_stacks;
				if (__sync_bool_compare_and_swap(&kernel_stacks.free_stacks, rv, *((void**)rv - 1))) {
						/* we've reserved a stack */
						cprintf(KFMT_INFO, "stack from %p to %p reused\n", rv,
										rv - 4096 * (kernel_stacks.n_alloc + kernel_stacks.n_res));
						return rv;
				}
		}
		/* we have to allocate new */
		rv = kernel_stacks.vm_ptr;
		rv += 4096 * (kernel_stacks.n_alloc + kernel_stacks.n_guard + kernel_stacks.n_res);
		if (rv > kernel_stacks.vm_top)
				return NULL;
		rv = mm_alloc_vmem(&mm_kernel, kernel_stacks.n_alloc,
						rv - 4096 * (kernel_stacks.n_alloc + kernel_stacks.n_guard),
					   	MMGR_MAP_WRITE | MMGR_MAP_KERNEL);
		if (rv) {
				rv += kernel_stacks.n_alloc * 4096;
				kernel_stacks.vm_ptr = rv + 4096 * kernel_stacks.n_guard;
				cprintf(KFMT_INFO, "alloc_stack(): from %p to %p\n",
								rv, rv - 4096 * (kernel_stacks.n_alloc + kernel_stacks.n_res));
				return rv;
		} else
				return NULL;
}

void free_stack(void* stack_base)
{
		/* w/o deallocation (use stack for list) */
		/* TODO: this leaks sensitive data; mark as to be scrubbed or sth. */
		void** pptr = (void**)(stack_base - sizeof(void*));
		do {
				*pptr = kernel_stacks.free_stacks;
		} while (!__sync_bool_compare_and_swap(&kernel_stacks.free_stacks, *pptr, stack_base));
}

void install_tss(uint64_t* gdte, uintptr_t tss_addr)
{
#ifdef __x86_64__
		/* set top half */
		*(gdte + 1) = (uint64_t)tss_addr >> 32;
		/* 64-bit TSS has same TYPE field as 32-bit TSS */
#endif
		/* set descriptor */
		*gdte = ((uint64_t)(tss_addr & 0x00ffffff) << 16) /* base */
				+ ((uint64_t)(tss_addr & 0xff000000) << 32)
				+ 0x0040890000000000ull /* attributes 32TSS pres. */
				+ (sizeof(struct tss) - 1);
}

void mmgr_init_tss()
{
		extern uint64_t kernltss, intrtss;
		extern void gate_8();
		uint64_t* gdt = &kernltss;
		void* stk = alloc_stack();
		if (stk)
				printf("allocated interrupt stack for first TSS at %p\n", stk);
		else while (1);
		/* configure the values of the tss */
#ifdef __x86_64__
		main_tss.rsp0 = (uint64_t)stk;
#else
		main_tss.ss0 = SEG_DATA; /* kernel ds */
		main_tss.esp0 = (uint32_t)stk;
#endif
		main_tss.iomap = sizeof(struct tss);
		/* now install it */
		install_tss(gdt, (intptr_t)&main_tss);
		asm volatile("ltr %%ax": : "a" (SEG_TSS_PL0));
		/* Now do the same to harden the #SS handler
		 * (reuse the stack as it will not be used for now)*/
		gdt = &intrtss;
		intr_tss.iomap = sizeof(struct tss);
		/* TODO: use x86_64 known-good stacks instead as there are
		 * no task gates anymore */
#ifdef __x86_64__
		/* we don't use a task gate, so no rip needed (also unavailable) */
		intr_tss.ist1 = (uint64_t)stk;
		intr_tss.rsp0 = (uint64_t)stk;
		/* also no CR3 change possible */
#else
		intr_tss.ss0 = SEG_DATA;
		intr_tss.esp0 = (uint32_t)stk;
		intr_tss.cs = SEG_CODE;
		intr_tss.ds = intr_tss.es = SEG_DATA;
		intr_tss.ss = SEG_DATA;
		intr_tss.gs = SEG_DATA;
		intr_tss.fs = SEG_DATA_PROC;
		intr_tss.esp = (uint32_t)stk;// - 0x40; /* esp+14*x in handler <- PROLLY MISCONCEPTION */
		asm ("mov %%cr3, %%eax\n movl %%eax, %0\n" : "=m" (intr_tss.cr3) : : "eax");
		intr_tss.eip = (uint32_t)&gate_8; /* already uses iret */
#endif
		install_tss(gdt, (uintptr_t)&intr_tss);
		/* now we have to fix gate 8 in the IDT */
		extern uint64_t idt_desc_8;
#ifdef __x86_64__ /* use interrupt gate with IST1 */
#else /* use task gate */
		/* 0x85 = present; type=5 = task gate
		 * selector = 0x0048 task selector in gdt */
		idt_desc_8 = 0x0000850000480000;
#endif
}

#ifdef __x86_64__
struct task_state {
		uint64_t gs;
		uint64_t fs;
		uint64_t es;
		uint64_t ds;
		uint64_t r15;
		uint64_t r14;
		uint64_t r13;
		uint64_t r12;
		uint64_t r11;
		uint64_t r10;
		uint64_t r9;
		uint64_t r8;
		uint64_t rdi;
		uint64_t rsi;
		uint64_t rbp;
		uint64_t rsp;
		uint64_t rbx;
		uint64_t rdx;
		uint64_t rcx;
		uint64_t rax;
		uint64_t rip;
		uint64_t cs;
		uint64_t rflags;
		uint64_t rsp_rpl; /* pushed always, not only for cross privilege */
		uint64_t ss_rpl;
};
#else
struct task_state {
		uint32_t gs;
		uint32_t fs;
		uint32_t es;
		uint32_t ds;
		uint32_t edi;
		uint32_t esi;
		uint32_t ebp;
		uint32_t esp;
		uint32_t ebx;
		uint32_t edx;
		uint32_t ecx;
		uint32_t eax;
		uint32_t eip; /* regular, no vm86(else ss, esp before) */
		uint32_t cs; /* 32bit */
		uint32_t eflags;
		uint32_t esp_rpl; /* not present for some */
		uint32_t ss_rpl;
};
#endif
#ifdef __x86_64__
#define stack_ptr(t) ((void*)t->ts->rsp)
#define instr_ptr(t) ((void*)t->ts->rip)
#else
#define stack_ptr(t) ((void*)t->ts->esp)
#define instr_ptr(t) ((void*)t->ts->eip)
#endif

struct tsi* tks[128] = {0}; /* ptrs to stack base (cti...) */
size_t n_tks = 0; // <- real task store

struct pqe {
		struct tsi **cur, **end; /* full if end+1=cur */
		struct tsi* tks[32];
		struct pqe* next;
};

struct priority_queue {
		struct pqe* queues[4];
} pqs[2] = {{0},{0}}, *run_queue = pqs, *expired_queue = pqs + 1;
spinlock_t pq_lock = SPIN_LOCK_UNLOCKED;

void pq_enqueue(struct priority_queue* pq, struct tsi* t)
{
		struct pqe* e = pq->queues[t->cur_priority];
		if (!e) {
				e = pq->queues[t->cur_priority] = kzalloc(sizeof(struct pqe));
				e->next = NULL;
				e->cur = e->end = &e->tks[0];
				pq->queues[t->cur_priority] = e;
		}
		do { /* insert O(1) per pqe, but next->next->next */
				/* full if end+1=cur */
				if (e->end + 1 != e->cur) {
						/* handle special case of perfect alignment */
						if (!(e->cur == e->tks && (e->end + 1 == e->tks + COUNT_OF(e->tks)))) {
								*e->end = t;
								//TODO: proper accounting
								//t->run_time = 0;
								//t->quota = 10;
								//t->flags &= ~TIF_YIELDED;
								/* adjust the endptr */
								if (++e->end == e->tks + COUNT_OF(e->tks))
										e->end = &e->tks[0];
								return;
						}
				}
				if (!e->next) {
						e->next = kzalloc(sizeof(struct pqe));
						e->next->next = NULL;
						e->next->cur = e->next->end = &e->next->tks[0];
				}
				e = e->next;
		} while (1);
}

struct tsi* pq_dequeue(struct priority_queue* pq)
{
		struct tsi* rv;
		for (uint32_t p = PRIORITY_MAX; p <= PRIORITY_MIN; p++) {
				struct pqe* e = pq->queues[p];
				while (e) {
						if (e->cur != e->end) {
								rv = *e->cur++;
								/* wrap around */
								if (e->cur == (e->tks + COUNT_OF(e->tks)))
										e->cur = e->tks;
								return rv;
						}
						e = e->next;
				}
		}
		return NULL; /* major rotation */
}

//void pq_fill(struct priority_queue* pq)
//{
//		for (size_t i = 0; i < n_tks; i++)
//				pq_enqueue(pq, &tks[i]);
//}

struct stack_limits
{
		void* base;
		void* limit;
};

int get_stack(void* ptr, struct stack_limits* sl)
{
		int rv; size_t np;
		if ((ptr < kernel_stacks.vm_base) || (ptr > kernel_stacks.vm_ptr)) {
				return -1;
		}
		ptr = (void*)((size_t)ptr - (size_t)kernel_stacks.vm_base);
		rv = (size_t)ptr / 4096;
		np = kernel_stacks.n_alloc + kernel_stacks.n_guard + kernel_stacks.n_res;
		rv /= np;
		sl->limit = kernel_stacks.vm_base + rv * np * 4096;
		sl->base = sl->limit + 4096 * (np - kernel_stacks.n_guard);
		return rv;
}

uint64_t task_gettime()
{
		uint64_t rv; extern uint32_t apic_initialized;
		if (cpu.invariant_tsc) {
				asm volatile ("rdtsc" : "=A" (rv));
		} else if (cpu.has_apic) {
				if (!apic_initialized)
						return 0;
				/* use APIC timer */
				if (nproc > 1)
						rv = (per_cpu_ptr()->ticks->tick << 32) | apic_reg(APIC_REG_TMRCURRCNT);
				else
						rv = (jiffies << 32) | apic_bp_reg(APIC_REG_TMRCURRCNT);
		} else {
			rv = jiffies;
		}
		return rv;
}

struct tsi* get_task_esp(void* esp)
{
		static struct tsi dummy = {0, .preempt_count = 0xffff};
		struct tsi* rv;
		int stk; struct stack_limits sl;
		stk = get_stack(esp, &sl);
		if (stk == -1) {
				if (preempt_needs_init)
						return &dummy;
				printf("kernel_stacks: %p to %p\n", kernel_stacks.vm_base, kernel_stacks.vm_ptr);
				die("unkown stack at %p\n", esp);
				return NULL;
		}
		/* we have a real stack */
		rv = sl.base;
		rv--;
		return rv;
}

struct tsi* get_task()
{
		int dm;
		return get_task_esp(&dm);
}

/* safe as pushad has been performed */
void task_save_state(struct task_state* esp)
{
		struct stack_limits sl; int st;
		if (esp->cs & 3) { /* RPL>0, i.e. call from usermode */
				/* we should be in the main_tss */
				/* TODO: usermode threads */
				st = get_stack(esp, &sl);
				if (st == -1) {
						/* unknown user->kernel stack */
				} else {
				}
				/* the associated usermode stack is esp_rpl */
				printf("irq0 from usermode with stack at %p\n",
#ifdef __x86_64__
								(void*)esp->rsp_rpl
#else
								(void*)esp->esp_rpl
#endif
					  );
				printf("current esp: %p\n", esp);
				printf("cs: %x\n", esp->cs);
				while (1);
		} else if ((size_t)esp <= 0x80000 && (size_t)esp > 0x60000) {
				/* initial kernel stack */
		} else {
				struct tsi* t;
				/* some other kernel thread/task */
				st = get_stack(esp, &sl);
				if (st == -1) {
						printf("unrecognized ring0 task!\n");
						return;
				}
				t = sl.base;
				t--;
				t->ts = esp;
				t->stop_time = task_gettime();
		}
}

void print_task(struct tsi* ts)
{
		char proc_str[5] = "N/A";
		if (ts->task_proc != 0xffffffff)
				snprintf(proc_str, 5, "%4u", ts->task_proc);
		//printf("ID FLG STACK    PRIORITY  RUNTIME[ms] RUNTIME      QTA NAME         SCHED  \n"
		//       "                BASE CUR  TOT[s] LAST   TOTAL LAST                  BUMP ROT\n");
		printf("%2u %c%c%c %4.4s %p %4u %3u %7u %4u %7u %4u %3d %-12s" STAT_COUNTER("%4u %3u") "\n", ts->task_id,
				(ts->flags & TIF_RUNNING) ? 'R' : (ts->flags & TIF_EXPIRED) ? 'X' : (ts->flags & TIF_SLEEPING) ? 'S': ' ',
				(ts->flags & TIF_KERNEL_STACK) ? ((ts->flags & TIF_IDLE) ? 'I' : 'K') : 'U',
				(ts->flags & TIF_YIELDED) ? 'Y' : ' ', proc_str,
				ts->stack_base, ts->priority, ts->cur_priority,
				(uint32_t)(ts->ns_acc / 1000000000), ts->ns_per_sec / 1000000,
				ts->run_time, ts->run_time_sec, ts->quota, ts->name
				STAT_ARG(ts->task_mr_bumps) STAT_ARG(ts->task_mr_expires));
}

struct perf_ctrs* cpu_stat_counter(uint32_t id)
{
		if (nproc > 1) {
				struct processor_data* pd = get_cpu_data(id);
				if (!pd)
						return NULL;
				return pd->ticks;
		} else
				return bp_tick;
}

struct {
		uint32_t vals[8]; /* i k u ni pi pk pu pni */
} *cpu_pcs = NULL;
uint32_t nproc_alloc = 0, nproc_rep = 0;

int cpu_calc_percentages(size_t i)
{
		struct perf_ctrs* pc = cpu_stat_counter(i);
		if (!pc) {
				bzero(&cpu_pcs[i + 1], sizeof(cpu_pcs[i + 1]));
				cpu_pcs[i + 1].vals[0] = 0xffffffff;
				return -1;
		}
		/* add ikuni */
		cpu_pcs[0].vals[0] += pc->ns_idle_per_sec;
		cpu_pcs[0].vals[1] += pc->ns_kernel_per_sec;
		cpu_pcs[0].vals[2] += pc->ns_user_per_sec;
		cpu_pcs[0].vals[3] += 1000000000 - pc->ns_idle_per_sec
				- pc->ns_kernel_per_sec - pc->ns_user_per_sec;
		/* do local ikuni */
		cpu_pcs[i + 1].vals[0] = pc->ns_idle_per_sec;
		cpu_pcs[i + 1].vals[1] = pc->ns_kernel_per_sec;
		cpu_pcs[i + 1].vals[2] = pc->ns_user_per_sec;
		cpu_pcs[i + 1].vals[3] = 1000000000 - pc->ns_idle_per_sec
				- pc->ns_kernel_per_sec - pc->ns_user_per_sec;
		/* do the local percentages */
		for (size_t j = 0; j < 4; j++) {
				const uint32_t ntot = 10000000;
				uint32_t val = cpu_pcs[i + 1].vals[j];
				cpu_pcs[i + 1].vals[j] = val / ntot;
				cpu_pcs[i + 1].vals[4 + j] = 10 * (val % ntot) / ntot;
		}
		return 0;
}

void cpu_do_stats()
{
		if (!cpu_pcs || (nproc != nproc_alloc)) {
				if (cpu_pcs)
						kfree(cpu_pcs);
				cpu_pcs = kmalloc((nproc + 1) * sizeof(*cpu_pcs));
				nproc_alloc = nproc;
		}
		bzero(&cpu_pcs[0], sizeof(cpu_pcs[0]));
		size_t nval = 0; uint32_t ntot;
		for (size_t i = 0; i < nproc; i++) {
				if (-1 == cpu_calc_percentages(i))
						continue;
				nval++;
		}
		nproc_rep = nval;
		/* calculate the total percentages (assuming a second has passed) */
		ntot = 10000000 * nval; /* div 100 */
		if (!ntot)
			return; /* div0 otherwise */
		for (size_t i = 0; i < 4; i++) {
				uint32_t val = cpu_pcs[0].vals[i];
				cpu_pcs[0].vals[i] = val / ntot;
				cpu_pcs[0].vals[4 + i] = 10 * (val % ntot) / ntot;
		}
}

void print_cpus()
{
		printf("listing cpus: %u total, %u provided data\n", nproc, nproc_rep);
		printf("%%Cpu(s):%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id\n",
				cpu_pcs[0].vals[2], cpu_pcs[0].vals[6], /* u pu */
				cpu_pcs[0].vals[1], cpu_pcs[0].vals[5], /* k pk */
				cpu_pcs[0].vals[3], cpu_pcs[0].vals[7], /* ni pni */
				cpu_pcs[0].vals[0], cpu_pcs[0].vals[4]); /* i pi */
		for (size_t i = 0; i < nproc; i++) {
				if (cpu_pcs[i + 1].vals[0] == 0xffffffff) {
						printf("%%Cpu%-3u: N/A\n");
						continue;
				}
				struct perf_ctrs* pc = get_cpu_data(i)->ticks;
				printf("%%Cpu%-3u:%3u.%01u us,%3u.%01u sy,%3u.%01u na,%3u.%01u id, %u sched/s, %u sched\n", i,
						cpu_pcs[i + 1].vals[2], cpu_pcs[i + 1].vals[6], /* u pu */
						cpu_pcs[i + 1].vals[1], cpu_pcs[i + 1].vals[5], /* k pk */
						cpu_pcs[i + 1].vals[3], cpu_pcs[i + 1].vals[7], /* ni pni */
						cpu_pcs[i + 1].vals[0], cpu_pcs[i + 1].vals[4], /* i pi */
						pc->n_times_per_sec, pc->n_times);
		}
}

struct {
		uint32_t n_running;
		uint32_t n_sleeping;
		uint32_t n_pending;
//		uint32_t n_stopped;
//		uint32_t n_zombie;
		uint32_t tot_runtime; /* sec */
		uint32_t sec_runtime; /* ms */
} task_stats = {0};
STAT_DECL_COUNTER(sched_mr_count, uint32_t) = 0;

void print_tasks()
{
		const char* md = "";
		if (cpu.invariant_tsc)
				md = "inv_tsc";
		else if (cpu.has_apic)
				md = "apic timer";
		else
				md = "PIT ticks";
		printf("Tasks:%4u total,%4u running,%4u pending,%4u sleeping\n",
				n_tks, task_stats.n_running, task_stats.n_pending, task_stats.n_sleeping);
		printf("Task time:%6u secs total, %4u ms last sec, mode: %s\n",
				task_stats.tot_runtime, task_stats.sec_runtime, md);
		print_cpus();
		printf("listing tasks: %u total" STAT_COUNTER("  major rotations: %u")  "\n", n_tks STAT_ARG(sched_mr_count));
		printf("ID FLG PROC STACK    PRIORITY  RUNTIME[ms] RUNTIME      QTA NAME        " STAT_COUNTER("SCHED  ") "\n"
		       "                     BASE CUR  TOT[s] LAST   TOTAL LAST                 " STAT_COUNTER("BUMP ROT") "\n");
		for (size_t i = 0; i < n_tks; i++)
				print_task(tks[i]);
		//task_spawn(loop_func, NULL, PRIORITY_REGULAR);
}

/* function is called every second from the main loop for perfcounter updates */
void task_do_stats()
{
		bzero(&task_stats, sizeof(task_stats));
		for (size_t i = 0; i < n_tks; i++) {
				struct tsi* t = tks[i];
				if (!t)
						continue;
				t->run_time_sec = t->run_time - t->sec_run_time;
				t->sec_run_time = t->run_time;
				t->ns_per_sec = t->ns_acc - t->sec_ns_acc;
				t->sec_ns_acc = t->ns_acc;
				if (t->flags & TIF_RUNNING)
						task_stats.n_running++;
				else if (t->flags & TIF_SLEEPING)
						task_stats.n_sleeping++;
				else /* unix running = pend+running */
						task_stats.n_pending++;
				task_stats.tot_runtime += (uint32_t)(t->ns_acc / 1000000000llu);
				task_stats.sec_runtime += t->ns_per_sec / 1000000;
		}
		for (size_t i = 0; i < nproc; i++) {
				struct perf_ctrs* pc = cpu_stat_counter(i);
				if (!pc)
						continue;
				pc->ns_idle_per_sec = pc->ns_idle - pc->sec_ns_idle;
				pc->sec_ns_idle = pc->ns_idle;
				pc->ns_user_per_sec = pc->ns_user - pc->sec_ns_user;
				pc->sec_ns_user = pc->ns_user;
				pc->ns_kernel_per_sec = pc->ns_kernel - pc->sec_ns_kernel;
				pc->sec_ns_kernel = pc->ns_kernel;
				pc->n_times_per_sec = pc->n_times - pc->sec_n_times;
				pc->sec_n_times = pc->n_times;
		}
		cpu_do_stats();
}

/* is used to call function passed into task_spawn with
 * arguments and to cleanup after completion */
void task_initfunc()
{
		void (*fun)(void*); /* register int *foo asm ("r12"); alt */
		void* arg;
		/* arguments are passed in eax and ecx */
#ifdef __x86_64__
		asm volatile("mov %%rax, %0" : "=rm" (fun) );
		asm volatile("mov %%rcx, %0" : "=rm" (arg) );
#else
		asm volatile("mov %%eax, %0" : "=rm" (fun) );
		asm volatile("mov %%ecx, %0" : "=rm" (arg) );
#endif
		asm ("sti");
		/* now call the function */
		fun(arg);
		/* and deallocate the task and its stack */
		get_task()->flags |= TIF_DEALLOCATE;
		task_yield();
		while (1) {
				cprintf(KFMT_WARN, "Deallocated task is rescheduled. This should never happen!\n");
				task_yield();
		}
}

void task_spawn_named(void (*fn)(void*), void* dat, uint32_t priority, const char* name)
{
		if (n_tks < 128) {
				struct tsi ts = {0}; int flg;
				int id; struct stack_limits sl;
				void* stk = alloc_stack();
				if (!stk) {
						die("Failed to alloc stack!\n");
						return;
				}
				if ((flg = if_enabled()))
						preempt_disable();
				spin_lock(&pq_lock);
				/* store ALL info at stack bottom */
				struct tsi* pts = stk;
				pts--;
				struct task_state* ti = (void*)pts;
				ti--; /* store info at stack bottom */
				id = get_stack(stk, &sl);
				ts.flags = TIF_KERNEL_STACK;
				ts.task_id = id;
				ts.stack_base = sl.base;
				ts.stack_limit = sl.limit;
				ts.priority = ts.cur_priority = priority;
				ts.name = name;
				ts.quota = 10; ts.run_time = 0;
				ts.ts = ti;
				ts.task_proc = 0xffffffff;
				bzero(ti, sizeof(*ti));
				ti->cs = SEG_CODE;
				ti->ds = ti->es = SEG_DATA;
#ifdef __x86_64__
				ti->gs = SEG_DATA_PROC;
				ti->fs = SEG_DATA;
				ti->rsp = (uint64_t)ti;
				ti->rbp = ti->rsp;
				ti->rflags = (1 << 9)/* | (1 << 8)*/; /* IF TF (interrupt enable, single-step) */
				ti->rax = (uint64_t)fn;
				ti->rcx = (uint64_t)dat;
				ti->rip = (uint64_t)task_initfunc;
#else
				ti->gs = SEG_DATA;
				ti->fs = SEG_DATA_PROC; // x86, x86_64 other way
				ti->esp = (uint32_t)ti;
				ti->ebp = ti->esp;
				ti->eflags = (1 << 9)/* | (1 << 8)*/; /* IF TF (interrupt enable, single-step) */
				ti->eax = (uint32_t)fn;
				ti->ecx = (uint32_t)dat;
				ti->eip = (uint32_t)task_initfunc;
#endif
				*pts = ts;
				tks[n_tks++] = pts;
				pq_enqueue(run_queue, pts);
				spin_unlock(&pq_lock);
				if (flg)
						preempt_enable();
		}
}

#ifdef __x86_64__
#define longjmp(rsp) { \
		extern void irq0_longjmp(); \
		asm volatile ( \
						"mov %0, %%rsp\n" \
						"jmp irq0_longjmp\n" \
						: : "r" (rsp)); \
}
#else
#define longjmp(esp) { \
		extern void irq0_longjmp(); \
		asm volatile ( \
						"mov %0, %%esp\n" \
						"jmp irq0_longjmp\n" \
						: : "r" (esp)); \
}
#endif

void task_deallocate(struct tsi* t)
{
		/* we have the pq_lock so tks is ours
		 * --> remove the ptr */
		for (size_t i = 0; i < n_tks; i++)
				if (tks[i] == t) {
						tks[i] = NULL;
						/* shorten list and possibly swap last element */
						tks[i] = tks[--n_tks];
						break;
				}
		/* now free the stack */
		free_stack(t->stack_base);
}

struct preempt_doc {
		uint32_t proc;
		uint32_t task_id;
		const char* task_name;
		void* eip;
		void* esp;
} *pr_lst = NULL;
size_t pr_idx = 0;

void task_diag()
{
		static int diag = 0;
		size_t end = pr_idx;
		asm("cli");
		if (diag++)
				return;
		framebuffer_redraw(&fb_initial);
		mdelay(1000);
		print_tasks();
		printf("PROC TASK TASK_NAME        EIP      ESP\n");
		for (size_t i = end - 1; i != end; i--) {
				printf("%4u %4u %16s %p %p\n", (pr_lst[i].proc >> 24),
						pr_lst[i].task_id, pr_lst[i].task_name,
						pr_lst[i].eip, pr_lst[i].esp);
				if (i % 20)
						framebuffer_redraw(&fb_initial);
				if (!i)
						i = 128;
		}
}

void proc_add_time(uint64_t ns, uint32_t flags)
{
		struct perf_ctrs* pc = (nproc > 1) ? per_cpu_ptr()->ticks : bp_tick;
		/* we're inside the pq lock -> no sync */
		if (flags & TIF_IDLE)
				pc->ns_idle += ns;
		else if (flags & TIF_KERNEL_STACK)
				pc->ns_kernel += ns;
		else
				pc->ns_user += ns;
		pc->n_times++;
}

/* returns runtime in ns */
uint64_t get_runtime(struct tsi* t)
{
		uint64_t rv;
		union {	uint64_t val; struct { uint32_t lo, hi; }; } b, e, d;
		b.val = t->start_time;
		e.val = t->stop_time;
		d.val = e.val - b.val;
		if (cpu.invariant_tsc) {
				rv = 1000000 * d.val / tsc_per_ms;
		} else if (cpu.has_acpi) {
				int64_t bias = 0;
				/* complicated double values */
				d.hi = e.hi - b.hi; /* jiffie/HZ difference */
				/* countdown timer values */
				bias = e.lo - b.lo;
				bias = bias * 1000000000ll / (HZ * apic_reload_value);
				rv = (uint64_t)(1000000000ull * d.hi / HZ + bias);
		} else { /* jiffies */
				rv = 1000000000ull * d.val / HZ;
		}
		return rv;
}
struct wait_queue_head wq_idle = WAIT_QUEUE_HEAD(wq_idle);
struct wait_queue_head wq_timer = WAIT_QUEUE_HEAD(wq_timer);

int sleep(unsigned int seconds)
{
		wait_timeout(&wq_timer, HZ * seconds);
		return 0;
}

static inline void wq_add(struct wait_queue_head* wq_head, struct wait_queue* wq_tail)
{
		spin_lock(&wq_head->lock);
		wq_head->prev->next = wq_tail;
		wq_tail->prev = wq_head->prev;
		wq_head->prev = wq_tail;
		wq_tail->next = wq_head;
		spin_unlock(&wq_head->lock);
}

static inline void wq_purge(struct wait_queue_head* wq, struct wait_queue* wq_e)
{
		int flg;
		spin_lock_irqsave(&wq->lock, &flg);
		if (wq->next != (struct wait_queue*)wq) {
				struct wait_queue* wq_n = wq->next;
				do {
						if (wq_n == wq_e) {
								wq_n->prev->next = wq_n->next;
								wq_n->next->prev = wq_n->prev;
								break;
						}
				} while ((wq_n = wq_n->next) != (struct wait_queue*)wq);
		}
		spin_unlock_irqrestore(&wq->lock, flg);
}

void wait_on_event(struct wait_queue_head* wq)
{
		struct wait_queue my_q;
		if (__sync_bool_compare_and_swap(&wq->signaled, 1, 0))
				return; /* handle signalling */
		if (preempt_needs_init)
				return;
		else if (preempt_count())
				return;
		my_q.task = get_task();
		my_q.timeout = 0;
		wq_add(wq, &my_q);
		if (!__sync_bool_compare_and_swap(&wq->signaled, 1, 0)) { /* again */
				my_q.task->flags |= TIF_SLEEPING;
				task_yield();
		}
		/* purge my_q as long as it's valid */
		wq_purge(wq, &my_q);
}

void wait_timeout(struct wait_queue_head* wq, uint32_t delta)
{
		struct wait_queue my_q;
		my_q.task = get_task();
		my_q.timeout = jiffies + delta;
		wq_add(wq, &my_q);
		my_q.task->flags |= TIF_SLEEPING;
		task_yield();
		/* purge my_q as long as it's valid */
		wq_purge(wq, &my_q);
}

int wake_task(struct tsi* t)
{
		int rv = 0;
		if (!t)
				cprintf(KFMT_WARN, "Empty queue entry in wait queue\n");
		else { /* TODO: maybe check if really sleeping */
				t->flags &= ~TIF_SLEEPING;
				pq_enqueue((t->flags & TIF_EXPIRED) ?
						expired_queue : run_queue, t);
				rv = 1;
		}
		return rv;
}

/* called by the scheduler holding pq_lock */
int wake_up(struct wait_queue_head* wq)
{
		int rv = 0;
		spin_lock(&wq->lock);
		if (wq->next != (struct wait_queue*)wq) {
				struct wait_queue* wq_n = wq->next;
				/* non empty but never remove the acutal head */
				wq_n->prev->next = wq_n->next;
				wq_n->next->prev = wq_n->prev;
				rv = wake_task(wq_n->task);
		}
		spin_unlock(&wq->lock);
		return rv;
}

int wake_up_all(struct wait_queue* wq)
{
		int rv = 0;
		while (wake_up(wq))
				rv++;
		return rv;
}

int wake_up_external_event(struct wait_queue_head* wq)
{
		int rv = 0;
		spin_lock(&wq->lock);
		if (wq->next != (struct wait_queue*)wq) {
				struct wait_queue* wq_n = wq->next;
				/* non empty but never remove the acutal head */
				wq_n->prev->next = wq_n->next;
				wq_n->next->prev = wq_n->prev;
				wq_n->timeout = jiffies;
				/* abuse the timer queue */
				wq_add(&wq_timer, wq_n);
				rv = 1;
				wq->signaled = 0;
		} else { /* empty -> prevent waiting forever */
				wq->signaled = 1;
		}
		spin_unlock(&wq->lock);
		return rv;
}

int wake_up_all_external_event(struct wait_queue_head* wq)
{
		int rv = 0;
		while (wake_up_external_event(wq))
				rv++;
		if (rv) /* a bit iffy */
				wq->signaled = 0;
		return rv;
}

int wake_up_timer(struct wait_queue_head* wq)
{
		int rv = 0;
		spin_lock(&wq->lock);
		if (wq->next != (struct wait_queue*)wq) {
				struct wait_queue* wq_n = wq->next;
				do {
						if (wq_n->timeout <= jiffies) {
								wq_n->prev->next = wq_n->next;
								wq_n->next->prev = wq_n->prev;
								rv = wake_task(wq_n->task);
								if (rv)
										break;
						}
				} while ((wq_n = wq_n->next) != (struct wait_queue*)wq);
		}
		spin_unlock(&wq->lock);
		return rv;
}

int wake_up_timer_all(struct wait_queue_head* wq)
{
		int rv = 0;
		while (wake_up_timer(wq))
				rv++;
		return rv;
}

void kidle(void* data)
{
		get_task()->flags |= TIF_IDLE;
		while (1) {
				wait_on_event(&wq_idle);
				asm("hlt");
		}
}

/* we have a reinsert queue to avoid having running tasks in the run_queue */
#define RI_LIMIT 32 /* should be at most nproc */
struct tsi* ri_queue[RI_LIMIT]; /* protected by pq_lock */
size_t ri_ofs = 0;

/* called from everyone else (using cli before). The stack is the
 * stack of the current task. */
void task_schedule(struct tsi* prev_task)
{
		if (preempt_needs_init) /* returns to the task_state on the stack */
				return;    /* of the irq0 handler, i.e. where execution stopped. */

		struct tsi* t;
		/* calculate the runtime of prev_task and go back if no preemption */
		if (prev_task) {
				/* happens on same proc */
				uint64_t rt = get_runtime(prev_task);
				prev_task->ns_run = rt; // <- could be used for nice values
				prev_task->ns_acc += rt;
				proc_add_time(rt, prev_task->flags);
				/* go back but signify TIF_NEED_RESCHED */
				if (prev_task->preempt_count) {
						prev_task->flags |= TIF_NEED_RESCHED;
						prev_task->start_time = task_gettime();
						prev_task->quota--; /* go into negative values */
						return;
				} else if (prev_task->flags & TIF_NEED_RESCHED) /* clear the flag */
						prev_task->flags &= ~TIF_NEED_RESCHED;
		}

		/* enter the queue lock (entails free reign over ts values) */
		spin_lock(&pq_lock);
		/* wake up once */
		wake_up_timer_all(&wq_timer);
		/* check for reinsertion */
		for (size_t i = 0; i < ri_ofs; i++) {
				struct tsi* ti = ri_queue[i];
				if (ti->flags & TIF_RUNNING)
						continue;
				/* task is eligible */
				pq_enqueue((ti->flags & TIF_EXPIRED) ?
						expired_queue : run_queue, ti);
				/* shorten queue and redo current iteration */
				ri_queue[i--] = ri_queue[--ri_ofs];
		}

Pos1:
		t = pq_dequeue(run_queue);
		if (!t) { /* major rotation */
				struct priority_queue* q = run_queue;
				run_queue = expired_queue;
				expired_queue = q;
				for (size_t i = 0; i < n_tks; i++) /* unexpire them */
						tks[i]->flags &= ~TIF_EXPIRED;
				STAT_INC_COUNTER(sched_mr_count, 1);
				t = pq_dequeue(run_queue);
		}

		if (!t) { /* nothing to do? --> wake idle process */
				if (!prev_task || (prev_task->flags & TIF_SLEEPING)
							   || (prev_task->flags & TIF_YIELDED)) {
						wake_up(&wq_idle);
						goto Pos1;
				} else /* continue with current task */
						t = prev_task;
		}

		/* check for deallocation */
		if (t->flags & TIF_DEALLOCATE && !(t->flags & TIF_RUNNING)) {
				task_deallocate(t);
				goto Pos1;
		}

		/* check for sleeping tasks and if so, forget the task
		 * (wake_up is responsible for reenqueueing) */
		if (t->flags & TIF_SLEEPING)
				goto Pos1;

		/* "minor rotation" for task */
		if (--t->quota <= 0) {
				t->quota += 10;
				t->flags &= ~TIF_YIELDED;
				if (t->cur_priority != PRIORITY_MIN) {
						t->cur_priority++;
						STAT_INC_COUNTER(t->task_mr_bumps, 1);
				} else {
						/* check if quota reset on minor rotation */
						t->flags |= TIF_EXPIRED;
						t->cur_priority = t->priority;
						STAT_INC_COUNTER(t->task_mr_expires, 1);
				}
		}

		/* signal as running before release of scheduling lock (__sync is overkill) */
		if (__sync_fetch_and_or(&t->flags, TIF_RUNNING) & TIF_RUNNING) {
				/* THIS shouldn't happen anymore with the ri_queue */
				if (t != prev_task) { /* except if we're the one holding it */
						ri_queue[ri_ofs++] = t;
						t->quota++;
						if (ri_ofs == RI_LIMIT)
								die("Use a larger reinsertion queue!\n");
						goto Pos1; /* don't schedule the same task on many procs */
				}
		}
		barrier();
		t->run_time++; /* accounting */

		/* now jump into task */
		t->start_time = task_gettime();
		/* DEBUG check! */
		{
				struct stack_limits sl;
				if (get_stack(stack_ptr(t), &sl) == -1) {
						die("invalid task struct at %p (esp=%p)\nt%sprev_task\n",
								t->ts, stack_ptr(t), (t == prev_task) ? "==" : "!=");
				} else if (stack_ptr(t) < 0x7c00) {
						die("eip below 0x7c00 for task struct at %p\n", t->ts);
				} else if (t->stack_base < stack_ptr(t) || t->stack_limit > stack_ptr(t)) {
						die("jumping into wrong stack!\n");
				} else if (!t->ts)
						die("jumping into null!\n");
				//check_tasks();
				if (pr_lst) { /* ringbuffer */
						size_t idx;
get_idx:
						idx = __sync_fetch_and_add(&pr_idx, 1);
						if (idx > 127) {
								if (__sync_bool_compare_and_swap(&pr_idx, idx + 1, 0))
										idx = 0;
								else
										goto get_idx;
						}
						if (nproc > 1)
								pr_lst[idx].proc = per_cpu_ptr()->apic_id;
						else
								pr_lst[idx].proc = 0;
						pr_lst[idx].task_name = t->name;
						pr_lst[idx].task_id = t->task_id;
						pr_lst[idx].eip = instr_ptr(t);
						pr_lst[idx].esp = stack_ptr(t);
				}
		}
		/* document the processor */
		if (nproc > 1)
				t->task_proc = smp_processor_id();
		/* reinsert the previous task (if we don't do so next time) */
		if (prev_task && (t != prev_task)) {
				ri_queue[ri_ofs++] = prev_task;
				if (ri_ofs == RI_LIMIT)
						die("Use a larger reinsertion queue!\n");
		}
		spin_unlock(&pq_lock);

		/* release stack */
		{ /* only rely on registers */
				register void* ctx = t->ts;
				if (prev_task && (t != prev_task))
						prev_task->flags &= ~TIF_RUNNING;
				longjmp(ctx);
		}
}

/* called from irq0/apic handler returning with iret via longjmp.
 * These handlers are gates, i.e. not-reentrant, ensuring that
 * they have always finished execution before the task switch. */
void task_schedule_isr(void* esp)
{
		struct tsi* t = get_task_esp(esp);
		task_schedule(t);
}

void task_yield()
{
		struct tsi* t;
		if (preempt_needs_init)
				return; /* shouldn't be called before preemption */
		t = get_task();
		if (t->preempt_count) { /* don't yield nonpreemptable task */
exit:
				return;
		}
		if (if_enabled())
				die("yielding in interrupt!\n");
		void* ptr = &&exit;
		asm volatile (
				"cli\n" // TODO: pushf w/o before cli?
#ifdef __x86_64__
				"mov %%rax, -26*8(%%rsp)\n" /* 25*8 bts -> save rax on top */
				"xor %%rax, %%rax\n"
				"mov %%ss, %%ax\n"
				"push %%rax\n"
				"push %%rsp\n"
				"pushfq\n"
				"orl $0x200, 0(%%rsp)\n"
				"mov %%cs, %%ax\n"
				"push %%rax\n"
				"push %0\n" /* new rip -> irq0_longjmp */
				/* now get rax */
				"mov -21*8(%%rsp), %%rax\n"
				"push %%rax\n"
				"push %%rcx\n"
				"push %%rdx\n"
				"push %%rbx\n"
				"push %%rsp\n"
				"push %%rbp\n"
				"push %%rsi\n"
				"push %%rdi\n"
				"push %%r8\n"
				"push %%r9\n"
				"push %%r10\n"
				"push %%r11\n"
				"push %%r12\n"
				"push %%r13\n"
				"push %%r14\n"
				"push %%r15\n"
				"mov %%ds, %%ax\n"
				"push %%rax\n"
				"mov %%es, %%ax\n"
				"push %%rax\n"
				"mov %%fs, %%ax\n"
				"push %%rax\n"
				"mov %%gs, %%ax\n"
				"push %%rax\n"
#else
				"pushf\n"
				"orl $0x200, 0(%%esp)\n"
				"push %%cs\n"
				"push %0\n"
				"pusha\n"
				"push %%ds\n"
				"push %%es\n"
				"push %%fs\n"
				"push %%gs\n"
				"movl %%esp, %0\n"
#endif
		: "=mr" (ptr) : "0" (ptr)
#ifdef __x86_64__
							 : "rax" /* we clobber rax */
#endif
							 );
		t->ts = ptr;
		t->flags |= TIF_YIELDED;
		/* NOPE! */
		//t->flags &= ~TIF_RUNNING;
		t->stop_time = task_gettime();
		task_schedule(t);
		goto exit;
}

/* this function makes the kernel preemptable and is freeing the
 * previous main kernel stack at 0x60000-0x80000 */
void preempt_init()
{
		asm ("cli");
		pr_lst = kmalloc(128 * sizeof(*pr_lst));
		extern void kinit(void*);
		extern void kredraw(void*);
		extern void kscrub(void*);
		task_spawn(kinit, NULL, PRIORITY_MAX);
		task_spawn(kredraw, NULL, PRIORITY_MAX);
		task_spawn(kscrub, NULL, PRIORITY_MIN);
		/* at least n+1 idle task are needed */
		task_spawn(kidle, NULL, PRIORITY_MIN);
		task_spawn(kidle, NULL, PRIORITY_MIN);
		preempt_needs_init = 0;
		task_schedule(NULL);
}

