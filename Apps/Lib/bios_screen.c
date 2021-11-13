#include "bios_screen.h"
#include "types.h"

static word addr;

void clrscr() {
    asm volatile (
        "movb $0x00, %%ah\n"
        "int $0x10\n"
        : /* no outputs */
        : /* no inputs */
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
}

void scrolldown(byte lines) {
    asm volatile (
        "movb %0, %%al\n"
        "movb $0x02, %%ah\n"
        "int $0x10\n"
        : /* no outputs */
        : "g" (lines)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
}

void scrollup(byte lines) {
    asm volatile (
        "movb %0, %%al\n"
        "movb $0x03, %%ah\n"
        "int $0x10\n"
        : /* no outputs */
        : "g" (lines)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
}

void setcursor(byte col, byte row) {
    asm volatile (
        "movb $0x01, %%al\n"
        "movb $0x01, %%ah\n"
        "movb %0, %%dl\n"
        "movb %1, %%dh\n"
        "int $0x10\n"
        : /* no outputs */
        : "g" (col), "g" (row)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
}

void getcursor(byte *col, byte *row) {
    byte c, r;
    asm volatile (
        "movb $0x00, %%al\n"
        "movb $0x01, %%ah\n"
        "int $0x10\n"
        "movb %%dl, %0\n"
        "movb %%dh, %1\n"
        : "=g" (c), "=g" (r)
        : /* no inputs */
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
    *col = c;
    *row = r;
}

int putchar(int c) {
    asm volatile (
        "movb $0x04, %%ah\n"
        "movb %0, %%al\n"
        "int $0x10\n"
        : /* no outputs */
        : "g" (c)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
    return 0;
}

int puts(const char *str) {
    addr = (word)str;
    asm volatile (
        "movb $0x06, %%ah\n"
        "movw %%ss, %%dx\n"
        "movw %0, %%cx\n"
        "int $0x10\n"
        : /* no outputs */
        : "m" (addr)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
    return 0;
}

void settext(byte col, byte row, const char *s, byte color, byte inverse) {
    addr = (word)s;
    asm volatile (
        "movb $0x07, %%ah\n"
        "movw %%ss, %%si\n"
        "movw %0, %%di\n"
        "movb %1, %%dl\n"
        "movb %2, %%dh\n"
        "movb %3, %%cl\n"
        "movb %4, %%ch\n"
        "int $0x10\n"
        : /* no outputs */
        : "m" (addr), "g" (col), "g" (row), "g" (color), "g" (inverse)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
}

void enable_cursor(byte enable) {
    asm volatile (
        "movb $0x08, %%ah\n"
        "movb %0, %%al\n"
        "int $0x10\n"
        : /* no outputs */
        : "g" (enable)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
}

void set_textcolor(byte color) {
    asm volatile (
        "movb $0x09, %%ah\n"
        "movb %0, %%al\n"
        "int $0x10\n"
        : /* no outputs */
        : "g" (color)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
}

void set_bgcolor(byte color) {
    asm volatile (
        "movb $0x0A, %%ah\n"
        "movb %0, %%al\n"
        "int $0x10\n"
        : /* no outputs */
        : "g" (color)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
}

void settextdim(byte first_row, byte last_row) {
    asm volatile (
        "movb $0x0B, %%ah\n"
        "movb %0, %%dl\n"
        "movb %1, %%dh\n"
        "int $0x10\n"
        : /* no outputs */
        : "g" (first_row), "g" (last_row)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
}
