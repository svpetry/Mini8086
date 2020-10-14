#include "io.h"
#include "utils.h"

unsigned char cursor_col;
unsigned char cursor_row;
unsigned char textcol;
unsigned char __far (*screen)[4000];
//unsigned char __far *screen;

void init_screen() {
    outp(0x28, 0b00000000); // activate text mode
    outp(0x2A, 0b01000000); // background color: dark blue

    screen = (void __far *)0xC0000000;
    cursor_col = 0;
    cursor_row = 0;
    textcol = 0b11100100; // light blue

    clrscr();
}

void clrscr() {
    unsigned int i;
    for (i = 0; i < 4000; i += 2)
        (*screen)[i] = 0;
}

void scrolldown() {

}

void setcursor(unsigned int col, unsigned int row) {
    cursor_col = col;
    cursor_row = row;
}

void putch(char c) {
    unsigned int index = cursor_row * 160 + cursor_col * 2;
    (*screen)[index] = c;
    (*screen)[index + 1] = textcol;

    cursor_col++;
    if (cursor_col == 80) {
        cursor_col = 0;
        if (cursor_row == 24)
            scrolldown();
        cursor_row++;
    }
}

void putstr(char *str) {
    while (*str)
        putch(*(str++));
}

void putstr_inv(char *str) {
    while (*str)
        putch(*(str++) + 0x80);
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
