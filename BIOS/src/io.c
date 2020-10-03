#include "io.h"

void outp(int port, unsigned char value) {
    asm(
        "movb %1, %%al\n"
        "movw %0, %%dx\n"
        "outb %%al, %%dx"
        : : "g" (port), "g" (value)
    );
}

void DisplayNumber(unsigned char x) {
    unsigned char a;
    
    switch (x) {
        case 0x00:
            a = 0x3F;
            break;
        case 0x01:
            a = 0x06;
            break;
        case 0x02:
            a = 0x5B;
            break;
        case 0x03:
            a = 0x4F;
            break;
        case 0x04:
            a = 0x66;
            break;
        case 0x05:
            a = 0x6D;
            break;
        case 0x06:
            a = 0x7D;
            break;
        case 0x07:
            a = 0x07;
            break;
        case 0x08:
            a = 0x7F;
            break;
        case 0x09:
            a = 0x6F;
            break;
        case 0x0A:
            a = 0x77;
            break;
        case 0x0B:
            a = 0x7C;
            break;
        case 0x0C:
            a = 0x39;
            break;
        case 0x0D:
            a = 0x5E;
            break;
        case 0x0E:
            a = 0x79;
            break;
        case 0x0F:
            a = 0x71;
            break;
    }
    outp(0x10, ~a);
}
