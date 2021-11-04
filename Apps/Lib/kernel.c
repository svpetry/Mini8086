#include "kernel.h"
#include "bios_misc.h"
#include "types.h"

#define TICK_DURATION_MS 50

void __far *k_malloc(dword size) {
    word size_l = size;
    word size_h = size >> 16;
    word ptr_l, ptr_h;
    asm volatile (
        "movw %2, %%cx\n"
        "movw %3, %%dx\n"
        "movb $0x20, %%ah\n"
        "int $0x20\n"
        "movw %%cx, %0\n"
        "movw %%dx, %1\n"
        : "=g" (ptr_l), "=g" (ptr_h)
        : "g" (size_l), "g" (size_h)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
    dword ptr = (((dword)ptr_h) << 16) + ptr_l;
    return (void __far *)ptr;
}

void k_free(void __far *ptr) {
    dword dwptr = (dword)ptr;
    word ptr_l = dwptr;
    word ptr_h = dwptr >> 16;
    asm volatile (
        "movw %0, %%cx\n"
        "movw %1, %%dx\n"
        "movb $0x21, %%ah\n"
        "int $0x20\n"
        : /* no outputs */
        : "g" (ptr_l), "g" (ptr_h)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
}

dword k_check_free_memory() {
    word mem_l, mem_h;
    asm volatile (
        "movb $0x22, %%ah\n"
        "int $0x20\n"
        "movw %%cx, %0\n"
        "movw %%dx, %1\n"
        : "=g" (mem_l), "=g" (mem_h)
        : /* no outputs */
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
    return (((dword)mem_h) << 16) + mem_l;
}

SRESULT start_process(char *path, word *pid, byte *process_type) {
    byte status, ptype;
    word id;
    asm volatile (
        "pushw %%cs\n"
        "popw %%dx\n"
        "movw %3, %%cx\n"
        "movb $0x00, %%ah\n"
        "int $0x20\n"
        "movb %%al, %0\n"
        "movw %%cx, %1\n"
        "movb %%dl, %2\n"
        : "=g" (status), "=m" (id), "=g" (ptype) // "=g" results in compiler error
        : "g" (path)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
    *pid = id;
    *process_type = ptype;
    return status;
}

void sleep(word milliseconds) {
    if (milliseconds < TICK_DURATION_MS) {
        asm volatile (
            "int $0x80\n" // wait for next time slice
        );
        return;
    }
    word wait_ticks = milliseconds / TICK_DURATION_MS;
    while (wait_ticks > 0) {
        byte ticks = get_ticks();
        do {
            asm volatile (
                "int $0x80\n" // wait for next time slice
            );
        } while (ticks == get_ticks());
        wait_ticks--;
    }
}

byte terminate_process(int process_id) {
    byte status;
    asm volatile (
        "movw %1, %%cx\n"
        "movb $0x01, %%ah\n"
        "int $0x20\n"
        "movb %%al, %0\n"
        : "=g" (status)
        : "g" (process_id)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
    return status;
}

byte check_process(int process_id) {
    byte status;
    asm volatile (
        "movw %1, %%cx\n"
        "movb $0x02, %%ah\n"
        "int $0x20\n"
        "movb %%al, %0\n"
        : "=g" (status)
        : "g" (process_id)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
    return status;
}

void list_process(proc_info_ext *proc_info, byte first) {
    asm volatile (
        "movw %%ss, %%ax\n"
        "movw %%ax, %%dx\n"
        "movw %0, %%cx\n"
        "movb %1, %%al\n"
        "movb $0x10, %%ah\n"
        "int $0x20\n"
        : /* no outputs */
        : "g" (proc_info), "g" (first)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
}
