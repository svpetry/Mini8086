#include "scheduler.h"
#include "malloc.h"
#include "../../Lib/lowlevel.h"
#include "../../Lib/bios_screen.h"
#include "../../Lib/strutils.h"

#define MAX_THREADS 64

#define PIC_DATA    0x21
#define TMR_CH1     0x41
#define TMR_CMD     0x43

// timer values for 20 ms interval (decimal 20000)
#define TMR_LO      0x20
#define TMR_HI      0x4E

static processinfo __far *current_process;
static word scheduler_seg;
static byte header_offset;

static volatile word ss_save;
static volatile word sp_save;

static void puthexbyte(byte value) {
    char s[3];
    itohex(value, s);   
    if (value < 16)
        putch('0');
    putstr(s);
}

static void puthexword(word value) {
    puthexbyte(value >> 8);
    puthexbyte((byte)value);
}

/* handle INT 81h (terminate process) */
static void __far handle_terminate() {
    asm(
        "nop\n"
        "nop\n"
    );
}

/* handle INT 80h (sleep) */
static void __far handle_sleep() {
    asm(
        "nop\n"
        "nop\n"
    );
}

/* handler timer 1 interrupt (IRQ2) */
static void __far handle_timer() {
    asm(
	    "push %ax\n"
	    "push %bx\n"
	    "push %cx\n"
	    "push %dx\n"
	    "push %si\n"
	    "push %di\n"
	    "push %bp\n"
	    "push %ds\n"
	    "push %es\n"

        "mov %cs, %ax\n"
        "mov %ax, %ds\n"
        "mov %ax, %es"
    );
    asm(
        "mov %0, %%ax\n"
        "mov %%ax, %%ss\n"
        "mov %1, %%sp\n"
        "lret"
        : : "g" (ss_save), "g" (sp_save) : "ax"
    );
}

static void init() {
    current_process = NULL;
    header_offset = (sizeof(processinfo) + 15) / 16;

    asm(
        "pushw %%cs\n"
        "popw %0"
        : "=g" (scheduler_seg)
        : /* no inputs */
        : /* uses no registers */
    );

    // set interrupt vectors
    dword __far *int_addr;
    int_addr = (dword __far *)0x00000028; // INT 0Ah (IRQ 3)
    *int_addr = (dword)(&handle_timer);
    int_addr = (dword __far *)0x00000200; // INT 80h (sleep)
    *int_addr = (dword)(&handle_sleep);
    int_addr = (dword __far *)0x00000204; // INT 81h (terminate)
    *int_addr = (dword)(&handle_terminate);

    // enable TIMER1 interrupt (IRQ2)
    byte mask = inp(PIC_DATA);
    mask &= 0b11111011;
    outp(PIC_DATA, mask);
}

static void restart_timer() {
    outp(TMR_CMD, 0b01110000); // CH1, interrupt on terminal count
    outp(TMR_CH1, TMR_LO);
    outp(TMR_CH1, TMR_HI);
}

static processinfo __far *get_next_process() {
    return current_process->next;
}

static void __far resume_process() {
    word ss_save = current_process->ss_save;
    word sp_save = current_process->sp_save;
    asm(
        "movw %0, %%ax\n"
        "movw %%ax, %%ss\n"
        "movw %1, %%sp\n"
        : : "g" (ss_save), "g" (sp_save) : "ax"
    );
    asm(
        "pop %es\n"
        "pop %ds\n"
        "pop %bp\n"
        "pop %di\n"
        "pop %si\n"
        "pop %dx\n"
        "pop %cx\n"
        "pop %bx\n"
        "pop %ax\n"
        "iret\n"   
    );
    /* never returns */
}

static void run_process() {
    enum processstate ps = current_process->state;
    dword ptr; /* contains the pointer to the code to be called */
    if (ps == ps_new) {
        ptr = (dword)current_process; // call to 
        word seg = (ptr >> 16) + header_offset;
        word offs = ptr;
        ptr = ((dword)seg << 16) + offs;
    } else if (ps == ps_idle) {
        ptr = (dword)&resume_process;
    }

    if (ps == ps_new || ps == ps_idle) {
        current_process->state = ps_running;
        asm(
            // save stack segment + pointer
            "movw %%ss, %%ax\n"
            "movw %%ax, %0\n"
            "movw %%sp, %%ax\n"
            "addw $4, %%ax\n"
            "movw %%ax, %1\n"

            "movw $0x1234, %%ax\n" // debugging

            // start process
            "lcall *(%2)"
            : "=g" (ss_save), "=g" (sp_save)
            : "g" (ptr)
            : "ax"
        );
    }
}

static void new_process(char *filename) {

}

void start_scheduler() {
    init();

    putstr("Hello World from scheduler!");

    do {
        current_process = get_next_process();
        restart_timer();
        run_process();
    } while (current_process != NULL);
}
