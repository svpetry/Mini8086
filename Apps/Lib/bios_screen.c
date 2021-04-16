#include "bios_screen.h"
#include "types.h"

void clrscr() {
    asm(
        "movb $0x00, %%ah\n"
        "int $0x10"
        : /* no outputs */
        : /* no inputs */
        : "ax", "cx", "dx"
    );
}

void scrolldown() {
    asm(
        "movb $0x02, %%ah\n"
        "int $0x10"
        : /* no outputs */
        : /* no inputs */
        : "ax", "cx", "dx"
    );
}

void scrollup() {
    asm(
        "movb $0x03, %%ah\n"
        "int $0x10"
        : /* no outputs */
        : /* no inputs */
        : "ax", "cx", "dx"
    );
}

void setcursor(byte col, byte row) {
    asm(
        "movb $0x01, %%ah\n"
        "movb %0, %%dl\n"
        "movb %1, %%dh\n"
        "int $0x10"
        : /* no outputs */
        : "g" (col), "g" (row)
        : "ax", "cx", "dx"
    );
}

void putch(char c) {
    asm(
        "movb $0x04, %%ah\n"
        "movb %0, %%al\n"
        "int $0x10"
        : /* no outputs */
        : "g" (c)
        : "ax", "cx", "dx"
    );
}

void putstr(const char __far *str) {
    word seg = ((dword)str) >> 16;
    word offs = ((dword)str);
    asm(
        "movb $0x06, %%ah\n"
        "movw %0, %%cx\n"
        "movw %1, %%dx\n"
        "int $0x10"
        : /* no outputs */
        : "g" (seg), "g" (offs)
        : "ax", "cx", "dx"
    );
}
