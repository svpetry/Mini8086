#include "lowlevel.h"

inline void outp(word port, byte value) {
    asm volatile (
        "movb %1, %%al\n"
        "movw %0, %%dx\n"
        "outb %%al, %%dx"
        : : "g" (port), "g" (value) : "ax", "dx"
    );
}

inline byte inp(word port) {
    byte value;
    asm volatile (
        "movw %1, %%dx\n"
        "inb %%dx, %%al\n"
        "movb %%al, %0\n"
        : "=g" (value) : "g" (port) : "ax", "dx"
    );
    return value;
}

void reboot() {
    asm volatile ("ljmpw $0xFFFF, $0x0000");
}
