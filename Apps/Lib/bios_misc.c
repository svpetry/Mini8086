#include "bios_misc.h"
#include "types.h"

char getchar() {
    char c;
    asm volatile (
        "movb $0x10, %%ah\n"
        "int $0x10\n"
        "movb %%al, %0"
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
        "movb %%al, %0"
        : "=g" (ticks)
        : /* no inputs */
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
    return ticks;
}
