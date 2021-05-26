#include "bios_screen.h"
#include "types.h"

static word addr;

void clrscr() {
    asm volatile (
        "movb $0x00, %%ah\n"
        "int $0x10"
        : /* no outputs */
        : /* no inputs */
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
}

void scrolldown() {
    asm volatile (
        "movb $0x02, %%ah\n"
        "int $0x10"
        : /* no outputs */
        : /* no inputs */
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
}

void scrollup() {
    asm volatile (
        "movb $0x03, %%ah\n"
        "int $0x10"
        : /* no outputs */
        : /* no inputs */
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
}

void setcursor(byte col, byte row) {
    asm volatile (
        "movb $0x01, %%ah\n"
        "movb %0, %%dl\n"
        "movb %1, %%dh\n"
        "int $0x10"
        : /* no outputs */
        : "g" (col), "g" (row)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
}

void putch(char c) {
    asm volatile (
        "movb $0x04, %%ah\n"
        "movb %0, %%al\n"
        "int $0x10"
        : /* no outputs */
        : "g" (c)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
}

void putstr(const char *str) {
    addr = (word)str;
    asm volatile (
        "movb $0x06, %%ah\n"
        "movw %%ss, %%dx\n"
        "movw %0, %%cx\n"
        "int $0x10"
        : /* no outputs */
        : "m" (addr)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
}
