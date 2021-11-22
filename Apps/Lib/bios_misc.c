#include "bios_misc.h"
#include "types.h"
#include "kernel.h"

char getchar_nowait() {
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

char getchar() {
    char result;
    while ((result = getchar_nowait()) == 0) sleep(50);
    return result;
}
