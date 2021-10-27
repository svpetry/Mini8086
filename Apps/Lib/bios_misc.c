#include "bios_misc.h"
#include "types.h"

char getchar() {
    char c;
    asm volatile (
        "movb $0x10, %%ah\n"
        "int $0x10\n"
        "movb %%al, %0\n"
        : "=g" (c)
        : /* no inputs */
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
    return c;
}

byte get_ticks() {
    byte ticks;
    asm volatile (
        "movb $0x11, %%ah\n"
        "int $0x10\n"
        "movb %%al, %0\n"
        : "=g" (ticks)
        : /* no inputs */
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
    return ticks;
}

void get_date_time(byte *year, byte *month, byte *day, 
    byte *hours, byte *minutes, byte *seconds) {

    word ax, cx, dx;
    asm volatile (
        "movb $0x12, %%ah\n"
        "int $0x10\n"
        "movw %%ax, %0\n"
        "movw %%cx, %1\n"
        "movw %%dx, %2\n"
        : "=g" (ax), "=g" (cx), "=g" (dx)
        : /* no inputs */
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
    *seconds = ax;
    *minutes = ax >> 8;
    *hours = cx;
    *day = cx >> 8;
    *month = dx;
    *year = dx >> 8;
}

void set_time(byte hours, byte minutes, byte seconds) {
    asm volatile (
        "movb $0x13, %%ah\n"
        "movb %2, %%cl\n"
        "movb %1, %%ch\n"
        "movb %0, %%dl\n"
        "int $0x10\n"
        : /* no outputs */
        : "g" (hours), "g" (minutes), "g" (seconds)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
}

void set_date(byte year, byte month, byte day) {
    asm volatile (
        "movb $0x14, %%ah\n"
        "movb %2, %%cl\n"
        "movb %1, %%ch\n"
        "movb %0, %%dl\n"
        "int $0x10\n"
        : /* no outputs */
        : "g" (year), "g" (month), "g" (day)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
}
