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
