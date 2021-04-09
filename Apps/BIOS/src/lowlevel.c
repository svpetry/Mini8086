#include "lowlevel.h"

inline void outp(word port, byte value) {
    asm(
        "movb %1, %%al\n"
        "movw %0, %%dx\n"
        "outb %%al, %%dx"
        : : "g" (port), "g" (value)
    );
}

inline byte inp(word port) {
    byte value;
    asm(
        "movw %1, %%dx\n"
        "inb %%dx, %%al\n"
        "movb %%al, %0\n"
        : "=g" (value) : "g" (port)
    );
    return value;
}
