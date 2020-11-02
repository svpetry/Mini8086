#include "lowlevel.h"

inline void outp(unsigned int port, unsigned char value) {
    asm(
        "movb %1, %%al\n"
        "movw %0, %%dx\n"
        "outb %%al, %%dx"
        : : "g" (port), "g" (value)
    );
}

