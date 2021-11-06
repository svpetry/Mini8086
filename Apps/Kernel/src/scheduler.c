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

// timer values for 20 ms interval (decimal 20000)
#define TMR_LO      0x20
#define TMR_LO_STR  "0x20"
#define TMR_HI      0x4E
#define TMR_HI_STR  "0x4E"

// timer values for 50 ms interval (decimal 60000)
// #define TMR_LO      0x60
// #define TMR_HI      0xEA

#define PRIORITY_ORDER_LEN 9
#define PRIORITY_LEVELS    3 // priority levels P1, P2, P3. P0 = realtime priority (stored in the same list as P1)
#define MAX_PROCESSES      32

static byte priority_order[PRIORITY_ORDER_LEN] = {1, 1, 2, 1, 1, 2, 1, 1, 3};
static byte prio_order_idx;

int process_count;
processinfo __far *processes[MAX_PROCESSES]; // linear list of processes
static processinfo __far *current_process;
static processinfo __far *proc_by_prio[PRIORITY_LEVELS]; // double linked list of processes for each priority level
static volatile byte header_offset;
static word pid_gen;

volatile word sp_save;
static volatile word proc_ss_save;
static volatile word proc_sp_save;

static dword procstart;
static byte terminate;

/* handle INT 81h (terminate process) */
static void __far handle_terminate() {
    asm volatile (
        "cli\n"

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
        "cli\n"

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
	    "pushw %%ax\n"

        // check if called from ROM or kernel
        "movw %%ss, %%ax\n"
        "cmpw $0x1000, %%ax\n"
        "jae cont\n"

        // send EOI
        "movb $0x20, %%al\n"
        "out %%al, $0x20\n"
        "popw %%ax\n"

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
        proc_by_prio[i] = NULL;
    pid_gen = 1;
    process_count = 0;
    for (int i = 0; i < MAX_PROCESSES; i++)
        processes[i] = NULL;
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
        "movw $0b01110110, %%ax\n" // CH1, square wave generator
        "out %%ax, $"TMR_CMD_STR"\n"
        "movw $"TMR_LO_STR", %%ax\n"
        "out %%ax, $"TMR_CH1_STR"\n"
        "movw $"TMR_HI_STR", %%ax\n"
        "out %%ax, $"TMR_CH1_STR"\n"
        : : : "ax"
    );
}

static void stop_timer() {
    asm volatile (
        "movw $0b01110010, %%ax\n" // CH1, hardware re-triggerable one-shot (means disabled)
        "out %%ax, $"TMR_CMD_STR"\n"
        "movw $0xFF, %%ax\n"
        "out %%ax, $"TMR_CH1_STR"\n"
        "out %%ax, $"TMR_CH1_STR"\n"
        : : : "ax"
    );
}

static processinfo __far *get_next_process() {
    processinfo __far *process = NULL;
    byte start_order_idx = prio_order_idx;
    do {
        byte prio = priority_order[prio_order_idx];
        do {
            process = proc_by_prio[prio - 1];
            if (process == NULL) prio--;
        } while (process == NULL && prio > 0);
        
        if (process != NULL)
            proc_by_prio[prio] = process->next;

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
        "iret\n"
    );
    /* never returns */
}

static void run_process() {
    terminate = 0;
    
    PSTATE ps = current_process->state;
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

static void init_process(processinfo __far *new_pi, const char *filename, const char *params, byte priority) {
    new_pi->id = pid_gen++;
    new_pi->state = PS_NEW;
    new_pi->priority = priority;

    // set process name
    byte fidx = strlen(filename) - 1;
    while (fidx > 0 && filename[fidx - 1] != '\\') fidx--;
    byte i = 0;
    while (filename[fidx] && filename[fidx] != '.' && i < 8)
        new_pi->name[i++] = tolower(filename[fidx++]);
    new_pi->name[i] = 0;
    
    // set parameter string
    i = 0;
    while (params[i]) {
        new_pi->params[i] = params[i];
        i++;
    }
    new_pi->params[i] = 0;
}

static byte check_crc8(byte __far *mem, word size, byte expected_crc) {
    byte crc = crc8x_fast(0, NULL, 0);
    crc = crc8x_fast(crc, mem, size);
    return crc != expected_crc;
}

SRESULT new_process(const char *filename, const char *params, int *pid, PROC_TYPE *ptype) {
    if (process_count >= MAX_PROCESSES) return SR_REJECTED;

    dword size;
    if (fs_filesize(filename, &size))
        return SR_FILE_NOT_FOUND;

    byte handle;
    if (fs_open(filename, &handle, MODE_READ))
        return SR_FILE_OPEN_ERROR;
    
    fileheader header;
    void __far *ptr = near_to_far(&header);
    fs_read(handle, ptr, sizeof(fileheader));
    size -= sizeof(fileheader);

    if (header.id[0] != 'E' || header.id[1] != 'X')
        return SR_NO_EXEC;

    word pheader_size = ((sizeof(processinfo) + 15) / 16) * 16;
    dword memsize = (((dword)header.size) << 10) + pheader_size;
    byte __far *mem = malloc_(memsize);

    processinfo __far *new_pi = (processinfo __far *)mem;
    init_process(new_pi, filename, params, header.priority);
    new_pi->size = (word)header.size << 6;
    *ptype = header.proc_type;
    *pid = new_pi->id;

    // set pointer to memory after header
    word seg = (word)((dword)mem >> 16);
    word offs = (word)((dword)mem & 0xFFFF);
    seg += pheader_size >> 4;
    mem = (byte __far *)(((dword)seg << 16) + (dword)offs);

    SRESULT sresult = SR_OK;
    if (fs_read(handle, mem, size))
        sresult = SR_READ_ERROR;
    fs_close(handle);

    if (sresult == SR_OK) {
        if (check_crc8(mem, size, header.crc8))
            sresult = SR_CHECKSUM_ERROR;
    }

    if (sresult != SR_OK) {
        free_(new_pi);
        return sresult;
    }
    
    processes[process_count++] = new_pi;
    byte pindex = header.priority == 0 ? 0 : header.priority - 1;
    processinfo __far *curr_pi = proc_by_prio[pindex];
    if (curr_pi == NULL) {
        curr_pi = new_pi;
        curr_pi->next = new_pi;
        curr_pi->prev = new_pi;
        proc_by_prio[pindex] = curr_pi;
    } else {
        new_pi->next = curr_pi->next;
        new_pi->prev = curr_pi;
        curr_pi->next->prev = new_pi;
        curr_pi->next = new_pi;
    }
    return SR_OK;
}

static void terminate_current_process() {
    processinfo __far *p = current_process;
    
    int i = 0;
    while (i < process_count && processes[i] != p)
        i++;
    if (i == process_count) return;
    i++;
    while (i < process_count) {
        processes[i - 1] = processes[i];
        i++;
    }
    processes[i - 1] = NULL;
    process_count--;

    current_process = NULL;
    if (p->next == p) {
         byte pindex = p->priority == 0 ? 0 : p->priority - 1;
         proc_by_prio[pindex] = NULL;
    } else {
        p->prev->next = p->next;
        p->next->prev = p->prev;
    }

    free_((void __far *)p);
}

byte terminate_process(int pid) {
    if (current_process->id == pid) {
        terminate = TRUE;
        return 0;
    }
    int i = 0;
    while (i < process_count) {
        if (processes[i]->id == pid) {
            processes[i]->state = PS_TERMINATE;
            return 0;
        }
        i++;
    }
    return 1;
}

void start_scheduler(const char *command_name) {
    init();

    while (1) {
        current_process = get_next_process();
        if (current_process == NULL) {
            int pid;
            PROC_TYPE ptype;
            new_process(command_name, "", &pid, &ptype);
            current_process = get_next_process();
            if (current_process == NULL) {
                error("Could not load command shell. System halted.");
                asm volatile (
                    "cli\n"
                    "hlt\n"
                );
            }
        }

        if (current_process->state == PS_TERMINATE)
            terminate_current_process();
        else {
            start_timer();
            run_process();
            stop_timer();
            if (terminate)
                terminate_current_process();
        }
    }
}
