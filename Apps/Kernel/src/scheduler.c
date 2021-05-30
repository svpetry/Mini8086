#include "scheduler.h"
#include "malloc.h"
#include "../../Lib/lowlevel.h"
#include "../../Lib/bios_screen.h"
#include "../../Lib/strutils.h"
#include "../../Lib/bios_fs.h"
#include "../../Lib/utils.h"
#include "../../Lib/crc8.h"

#define MAX_THREADS 64

#define PIC_DATA    0x21
#define TMR_CH1     0x41
#define TMR_CH1_STR "0x41"
#define TMR_CMD     0x43
#define TMR_CMD_STR "0x43"

// // timer values for 20 ms interval (decimal 20000)
#define TMR_LO      0x20
#define TMR_LO_STR  "0x20"
#define TMR_HI      0x4E
#define TMR_HI_STR  "0x4E"

// timer values for 50 ms interval (decimal 60000)
// #define TMR_LO      0x60
// #define TMR_HI      0xEA

static processinfo __far *current_process;
static volatile byte header_offset;
static word pid_gen;

static volatile word sp_save;
static volatile word proc_ss_save;
static volatile word proc_sp_save;

static dword procstart;
static byte terminate;

static void puthexbyte(byte value) {
    char s[3];
    itohex(value, s);   
    if (value < 16)
        putch('0');
    putstr(s);
}

static void puthexword(word value) {
    volatile byte h = value >> 8;
    volatile byte l = value & 0xFF;
    puthexbyte(h);
    puthexbyte(l);
}

static void showpointer(void __far *ptr) {
	dword p = (dword)ptr;
	volatile word hi = (word)(p >> 16);
	volatile word lo = (word)(p & 0xFFFF);

    puthexword(hi);
	putch(':');
    puthexword(lo);
    putch('\n');
}

/* handle INT 81h (terminate process) */
static void __far handle_terminate() {
    asm volatile (
        "pushf\n"
	    "push %%ax\n"
	    "push %%bx\n"
	    "push %%cx\n"
	    "push %%dx\n"
	    "push %%si\n"
	    "push %%di\n"
	    "push %%bp\n"
	    "push %%ds\n"
	    "push %%es\n"

        // save process stack to CX:BX
        "movw %%sp, %%bx\n"
        "movw %%ss, %%cx\n"

        // restore segments
        "movw %%cs, %%ax\n"
        "movw %%ax, %%ss\n"
        "movw %%ax, %%ds\n"
        "movw %%ax, %%es\n"

        // restore stack from sp_save
        "movw %3, %%sp\n"

        // save process stack from CX:BX to proc_ss_save:proc_sp_save
        "movw %%bx, %1\n"
        "movw %%cx, %0\n"
        "movb $0x01, %2\n"

        "cld\n"
        "lret"
        : "=m" (proc_ss_save), "=m" (proc_sp_save), "=m" (terminate)
        : "m" (sp_save)
        :
    );
}

/* handle INT 80h (sleep) */
static void __far handle_sleep() {
    asm volatile (
        "pushf\n"
	    "push %%ax\n"
	    "push %%bx\n"
	    "push %%cx\n"
	    "push %%dx\n"
	    "push %%si\n"
	    "push %%di\n"
	    "push %%bp\n"
	    "push %%ds\n"
	    "push %%es\n"

        // save process stack to CX:BX
        "movw %%sp, %%bx\n"
        "movw %%ss, %%cx\n"

        // restore segments
        "movw %%cs, %%ax\n"
        "movw %%ax, %%ss\n"
        "movw %%ax, %%ds\n"
        "movw %%ax, %%es\n"

        // reset timer
        "movw $0b01110110, %%ax\n"
        "out %%ax, $"TMR_CMD_STR"\n"
        "movw $"TMR_LO_STR", %%ax\n"
        "out %%ax, $"TMR_CH1_STR"\n"
        "movw $"TMR_HI_STR", %%ax\n"
        "out %%ax, $"TMR_CH1_STR"\n"

        // restore stack from sp_save
        "movw %2, %%sp\n"

        // save process stack from CX:BX to proc_ss_save:proc_sp_save
        "movw %%bx, %1\n"
        "movw %%cx, %0\n"

        "cld\n"
        "lret"
        : "=m" (proc_ss_save), "=m" (proc_sp_save)
        : "m" (sp_save) 
        :
    );
}

/* handler timer 1 interrupt (IRQ2) */
static void __far handle_timer() {
    asm volatile (
        "sti\n"
        "pushf\n"
	    "push %%ax\n"

        // check if called from ROM or kernel
        "movw %%ss, %%ax\n"
        "cmpw $0x0400, %%ax\n"
        "ja cont\n"

        // send EOI
        "movb $0x20, %%al\n"
        "out %%al, $0x20\n"
        "popw %%ax\n"
        "popf\n"

        "iret\n"

        "cont:\n"
	    "push %%bx\n"
	    "push %%cx\n"
	    "push %%dx\n"
	    "push %%si\n"
	    "push %%di\n"
	    "push %%bp\n"
	    "push %%ds\n"
	    "push %%es\n"

        "movb $0x20, %%al\n"
        "out %%al, $0x20\n" // send EOI

        // save process stack to CX:BX
        "movw %%sp, %%bx\n"
        "movw %%ss, %%cx\n"

        // restore segments
        "movw %%cs, %%ax\n"
        "movw %%ax, %%ss\n"
        "movw %%ax, %%ds\n"
        "movw %%ax, %%es\n"

        // restore stack from sp_save
        "movw %2, %%sp\n"

        // save process stack from CX:BX to proc_ss_save:proc_sp_save
        "movw %%bx, %1\n"
        "movw %%cx, %0\n"

        "cld\n"
        "lret"
        : "=m" (proc_ss_save), "=m" (proc_sp_save)
        : "m" (sp_save) 
        :
    );
    /* never returns */
}

static void init() {
    current_process = NULL;
    pid_gen = 1;
    header_offset = (sizeof(processinfo) + 15) / 16;

    // set interrupt vectors
    dword __far *int_addr;
    int_addr = (dword __far *)0x00000028; // INT 0Ah (IRQ 2)
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

static void start_timer() {
    outp(TMR_CMD, 0b01110110); // // CH1, square wave generator
    outp(TMR_CH1, TMR_LO);
    outp(TMR_CH1, TMR_HI);
}

static processinfo __far *get_next_process() {
    return current_process->next;
}

static void __far resume_process() {
    proc_ss_save = current_process->ss_save;
    proc_sp_save = current_process->sp_save;
    asm volatile (
        "movw %0, %%ax\n"
        "movw %1, %%sp\n"
        "movw %%ax, %%ss\n"
        : : "g" (proc_ss_save), "g" (proc_sp_save) : "ax", "memory"
    );
    asm volatile (
        "pop %es\n"
        "pop %ds\n"
        "pop %bp\n"
        "pop %di\n"
        "pop %si\n"
        "pop %dx\n"
        "pop %cx\n"
        "pop %bx\n"
        "pop %ax\n"
        "popf\n"
        "iret\n"
    );
    /* never returns */
}

static void run_process() {
    terminate = 0;

    enum processstate ps = current_process->state;
    dword ptr; /* contains the pointer to the code to be called */
    word new_sp = 0;
    if (ps == ps_new) {
        ptr = (dword)current_process; // call to 
        volatile word seg = (ptr >> 16) + header_offset;
        volatile word offs = ptr;
        ptr = ((dword)seg << 16) + offs;
        new_sp = (current_process->size * 16) - 2;
    } else if (ps == ps_idle) {
        ptr = (dword)&resume_process;
    }

    if (ps == ps_new || ps == ps_idle) {
        current_process->state = ps_running;
        procstart = ptr;
        asm volatile (
            // save stack segment + pointer, put new SP into SI
            "movw %%sp, %%ax\n"
            "subw $0x000C, %%ax\n" // 4 (call) + 4 * 2 (registers)
            "movw %%ax, %0\n"
            "movw %1, %%si\n"

            "pushw %%bx\n"
            "pushw %%bp\n"
            "pushw %%ds\n"
            "pushw %%es\n"

            "lcall *%2\n"

            "popw %%es\n"
            "popw %%ds\n"
            "popw %%bp\n"
            "popw %%bx\n"
            : "=g" (sp_save)
            : "g" (new_sp), "m" (procstart)
            : "ax", "cx", "dx", "si", "di"
        );

        current_process->state = ps_idle;
        current_process->ss_save = proc_ss_save;
        current_process->sp_save = proc_sp_save;
    }
}

static void init_process(processinfo __far *new_pi, const char *filename, byte priority) {
    new_pi->id = pid_gen++;
    new_pi->state = ps_new;
    new_pi->priority = priority;

    // set process name
    byte i = 0;
    while (filename[i] != 0 && filename[i] != '.' && i < 8) {
        new_pi->name[i] = filename[i];
        i++;
    }
    new_pi->name[i] = 0;
}

static byte check_crc8(byte __far *mem, word size, byte expected_crc) {
    byte crc = crc8x_fast(0, NULL, 0);
    crc = crc8x_fast(crc, mem, size);
    return crc != expected_crc;
}

static void new_process(char *filename, byte priority) {
    dword size;
    if (fs_filesize(filename, &size)) {
        putstr(filename);
        putstr(" not found.\n");
        return;
    }

    byte handle;
    if (fs_open(filename, &handle, MODE_READ)) {
        putstr(filename);
        putstr(" open error.\n");
        return;
    }
    
    fileheader header;
    void __far *ptr = near_to_far(&header);
    fs_read(handle, ptr, sizeof(fileheader));
    size -= sizeof(fileheader);

    if (header.id[0] != 'E' || header.id[1] != 'X') {
        putstr(filename);
        putstr(" not executable.");
        return;
    }

    word pheader_size = ((sizeof(processinfo) + 15) / 16) * 16;
    byte __far *mem = malloc_((((dword)header.size) << 10) + pheader_size);

    processinfo __far *new_pi = (processinfo __far *)mem;
    if (current_process == NULL) {
        current_process = new_pi;
        current_process->next = new_pi;
        current_process->prev = new_pi;
    } else {
        new_pi->next = current_process->next;
        new_pi->prev = current_process;
        current_process->next->prev = new_pi;
        current_process->next = new_pi;
    }

    init_process(new_pi, filename, priority);

    new_pi->size = (word)header.size << 6;

    // set pointer to memory after header
    word seg = (word)((dword)mem >> 16);
    word offs = (word)((dword)mem & 0xFFFF);
    seg += pheader_size >> 4;
    mem = (byte __far *)(((dword)seg << 16) + (dword)offs);

    byte error = 0;
    if (fs_read(handle, mem, size)) {
        putstr(filename);
        putstr(" read error.\n");
        error = 1;
    }
    fs_close(handle);

    if (!error && check_crc8(mem, size, header.crc8)) {
        putstr(filename);
        putstr(" checksum error.\n");
        error = 1;
    }

    if (error) {
        current_process->next = new_pi->next;
        current_process->next->prev = current_process;
        free_(new_pi);
    }
}

static void terminate_process() {
    processinfo __far *p = current_process;

    if (p->next == p) {
        free_((void __far *)p);
        current_process = NULL;
        clrscr();
        putstr("No process. System halted.\n");
        asm volatile (
            "cli\n"
            "hlt\n"
        );
    }

    p->prev->next = p->next;
    p->next->prev = p->prev;
    current_process = p->prev;
    free_((void __far *)p);
}

void start_scheduler() {
    init();

    new_process("command.bin", 1);
    new_process("command1.bin", 1);
    new_process("command2.bin", 1);
    start_timer();
    do {
        run_process();
        if (terminate) terminate_process();
        current_process = get_next_process();
    } while (current_process != NULL);
}
