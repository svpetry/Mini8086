#include "bios_screen_far.h"
#include "types.h"

int puts_far(const char __far *str) {
    word seg = ((dword)str) >> 16;
    word offs = ((dword)str) & 0xFFFF;
    asm volatile (
        "movb $0x06, %%ah\n"
        "movw %0, %%dx\n"
        "movw %1, %%cx\n"
        "int $0x10"
        : /* no outputs */
        : "m" (seg), "m" (offs)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
    return 0;
}

void settext_far(byte col, byte row, const char __far *s, byte color, byte inverse) {
    word seg = ((dword)s) >> 16;
    word offs = ((dword)s) & 0xFFFF;
    asm volatile (
        "movb $0x07, %%ah\n"
        "movw %0, %%si\n"
        "movw %1, %%di\n"
        "movb %2, %%dl\n"
        "movb %3, %%dh\n"
        "movb %4, %%cl\n"
        "movb %5, %%ch\n"
        "int $0x10"
        : /* no outputs */
        : "m" (seg), "g" (offs), "g" (col), "g" (row), "g" (color), "g" (inverse)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
}
