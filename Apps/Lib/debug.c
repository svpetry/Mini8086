#include "debug.h"
#include "strutils.h"
#include "bios_screen.h"

void puthexbyte(byte value) {
    char s[3];
    itohex(value, s);   
    if (value < 16)
        putchar('0');
    puts(s);
}

void puthexword(word value) {
    volatile byte h = value >> 8;
    volatile byte l = value & 0xFF;
    puthexbyte(h);
    puthexbyte(l);
}

void showpointer(void __far *ptr) {
	dword p = (dword)ptr;
	volatile word hi = (word)(p >> 16);
	volatile word lo = (word)(p & 0xFFFF);

    puthexword(hi);
	putchar(':');
    puthexword(lo);
    putchar('\n');
}
