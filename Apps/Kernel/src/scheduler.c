#include "scheduler.h"
#include "kmalloc.h"
#include "kutils.h"
#include "../../Lib/kernel_defs.h"
#include "../../Lib/lowlevel.h"
#include "../../Lib/bios_screen.h"
#include "../../Lib/strutils.h"
#include "../../Lib/bios_fs.h"
#include "../../Lib/utils.h"
#include "../../Lib/crc8.h"

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

#define PRIORITY_ORDER_LEN 9
#define PRIORITY_LEVELS    3 // priority levels P1, P2, P3. P0 = realtime priority (stored in the same list as P1)

static byte priority_order[PRIORITY_ORDER_LEN] = {1, 1, 2, 1, 1, 2, 1, 1, 3};
static byte prio_order_idx;

static processinfo __far *current_process;
static processinfo __far *processes[PRIORITY_LEVELS]; // double linked list of processes for each priority level
static volatile byte header_offset;
static word pid_gen;

volatile word sp_save;
static volatile word proc_ss_save;
static volatile word proc_sp_save;

static dword procstart;
static byte terminate;

/*
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
*/

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
	    "pushw %%ax\n"
	    "pushw %%bx\n"
	    "pushw %%cx\n"
	    "pushw %%dx\n"
	    "pushw %%si\n"
	    "pushw %%di\n"
	    "pushw %%bp\n"
	    "pushw %%ds\n"
	    "pushw %%es\n"

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
}

/* handler timer 1 interrupt (IRQ2) */
static void __far handle_timer() {
    asm volatile (
        "sti\n"
        "pushf\n"
	    "pushw %%ax\n"

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
	    "pushw %%bx\n"
	    "pushw %%cx\n"
	    "pushw %%dx\n"
	    "pushw %%si\n"
	    "pushw %%di\n"
	    "pushw %%bp\n"
	    "pushw %%ds\n"
	    "pushw %%es\n"

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
    for (int i = 0; i < PRIORITY_LEVELS; i++)
        processes[i] = NULL;
    pid_gen = 1;
    prio_order_idx = 0;
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
    asm volatile (
        "movw $0b01110110, %ax\n" // CH1, square wave generator
        "out %ax, $"TMR_CMD_STR"\n"
        "movw $"TMR_LO_STR", %ax\n"
        "out %ax, $"TMR_CH1_STR"\n"
        "movw $"TMR_HI_STR", %ax\n"
        "out %ax, $"TMR_CH1_STR"\n"
    );
}

static void stop_timer() {
    asm volatile (
        "movw $0b01110010, %ax\n" // CH1, hardware re-triggerable one-shot (means disabled)
        "out %ax, $"TMR_CMD_STR"\n"
        "movw $0xFF, %ax\n"
        "out %ax, $"TMR_CH1_STR"\n"
        "out %ax, $"TMR_CH1_STR"\n"
    );
}

static processinfo __far *get_next_process() {
    processinfo __far *process = NULL;
    byte start_order_idx = prio_order_idx;
    do {
        byte prio = priority_order[prio_order_idx];
        do {
            process = processes[prio - 1];
            if (process == NULL) prio--;
        } while (process == NULL && prio > 0);
        
        if (process != NULL)
            processes[prio] = process->next;

        if (++prio_order_idx == PRIORITY_ORDER_LEN)
            prio_order_idx = 0;
    } while (process == NULL && prio_order_idx != start_order_idx);

    return process;
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
        "popw %es\n"
        "popw %ds\n"
        "popw %bp\n"
        "popw %di\n"
        "popw %si\n"
        "popw %dx\n"
        "popw %cx\n"
        "popw %bx\n"
        "popw %ax\n"
        "popf\n"
        "iret\n"
    );
    /* never returns */
}

static void run_process() {
    terminate = 0;

    pstate ps = current_process->state;
    dword ptr; /* contains the pointer to the code to be called */
    word new_sp = 0;
    if (ps == PS_NEW) {
        if (current_process->priority == 0)
            stop_timer(); // real time priority
        ptr = (dword)current_process;
        volatile word seg = (ptr >> 16) + header_offset;
        volatile word offs = ptr;
        ptr = ((dword)seg << 16) + offs;
        new_sp = (current_process->size * 16) - 2;
    } else if (ps == PS_IDLE) {
        ptr = (dword)&resume_process;
    }

    if (ps == PS_NEW || ps == PS_IDLE) {
        current_process->state = PS_RUNNING;
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

        current_process->state = PS_IDLE;
        current_process->ss_save = proc_ss_save;
        current_process->sp_save = proc_sp_save;
    }
}

static void init_process(processinfo __far *new_pi, const char *filename, byte priority) {
    new_pi->id = pid_gen++;
    new_pi->state = PS_NEW;
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

static SRESULT new_process(const char *filename) {
    dword size;
    if (fs_filesize(filename, &size)) {
        file_error(filename, "not found.");
        return SR_FILE_NOT_FOUND;
    }

    byte handle;
    if (fs_open(filename, &handle, MODE_READ)) {
        file_error(filename, "open error.");
        return SR_FILE_OPEN_ERROR;
    }
    
    fileheader header;
    void __far *ptr = near_to_far(&header);
    fs_read(handle, ptr, sizeof(fileheader));
    size -= sizeof(fileheader);

    if (header.id[0] != 'E' || header.id[1] != 'X') {
        file_error(filename, "not executable.");
        return SR_NO_EXEC;
    }

    word pheader_size = ((sizeof(processinfo) + 15) / 16) * 16;
    byte __far *mem = malloc_((((dword)header.size) << 10) + pheader_size);

    processinfo __far *new_pi = (processinfo __far *)mem;
    init_process(new_pi, filename, header.priority);
    new_pi->size = (word)header.size << 6;

    // set pointer to memory after header
    word seg = (word)((dword)mem >> 16);
    word offs = (word)((dword)mem & 0xFFFF);
    seg += pheader_size >> 4;
    mem = (byte __far *)(((dword)seg << 16) + (dword)offs);

    SRESULT sresult = SR_OK;
    if (fs_read(handle, mem, size)) {
        file_error(filename, "read error.");
        sresult = SR_READ_ERROR;
    }
    fs_close(handle);

    if (sresult == SR_OK) {
        if (check_crc8(mem, size, header.crc8)) {
            file_error(filename, "checksum error.");
            sresult = SR_CHECKSUM_ERROR;
        }
    }

    if (sresult != SR_OK) {
        free_(new_pi);
        return sresult;
    }
        
    byte pindex = header.priority == 0 ? 0 : header.priority - 1;
    processinfo __far *curr_pi = processes[pindex];
    if (curr_pi == NULL) {
        curr_pi = new_pi;
        curr_pi->next = new_pi;
        curr_pi->prev = new_pi;
        processes[pindex] = curr_pi;
    } else {
        new_pi->next = curr_pi->next;
        new_pi->prev = curr_pi;
        curr_pi->next->prev = new_pi;
        curr_pi->next = new_pi;
    }
    return SR_OK;
}

static void terminate_process() {
    processinfo __far *p = current_process;
    current_process = NULL;
    
    if (p->next == p) {
         byte pindex = p->priority == 0 ? 0 : p->priority - 1;
         processes[pindex] = NULL;
    } else {
        p->prev->next = p->next;
        p->next->prev = p->prev;
    }

    free_((void __far *)p);
}

void start_scheduler(const char *command_name) {
    init();

    while (1) {
        current_process = get_next_process();

        if (current_process == NULL) {
            new_process(command_name);
            current_process = get_next_process();
            if (current_process == NULL) {
                error("Could not load command shell. System halted.");
                asm volatile (
                    "cli\n"
                    "hlt\n"
                );
            }
        }

        start_timer();
        run_process();
        stop_timer();
        if (terminate) terminate_process();
    }
}
