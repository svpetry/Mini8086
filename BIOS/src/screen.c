#include "screen.h"
#include "strutils.h"
#include "lowlevel.h"
#include "utils.h"
#include "types.h"

byte cursor_col;
byte cursor_row;
byte textcol;
word __far (*screen)[2000];
word __far (*scrbuf)[2000];

void set_textcol(byte col) {
    textcol = col;
}

void init_screen() {
    outp(0x50, 0b00000000); // activate text mode
    outp(0x51, 0b10000000); // background color: blue

    screen = (void __far *)0xC0000000;
    scrbuf = (void __far *)0x20000000;
    cursor_col = 0;
    cursor_row = 0;
    textcol = 0b11100100; // light blue

    clrscr();
}

void clrscr() {
    word i;
    for (i = 0; i < 2000; i++) {
        (*screen)[i] = 0;
        (*scrbuf)[i] = 0;
    }
    setcursor(0, 0);
}

static void copy_bufline(int dest, int src) {
    byte __far *bufptr = (byte __far *)scrbuf;
    memcpy_(bufptr + dest * 160, bufptr + src * 160, 160);
}

void scrolldown() {
    int i;
    for (i = 0; i < 24; i++)
        copy_bufline(i + 1, i);
    memset_(scrbuf, 0, 160);
    memcpy_(screen, scrbuf, 4000);
    if (cursor_row < 24)
        cursor_row++;
}

void scrollup() {
    int i;
    byte __far *ptr = (byte __far *)scrbuf;
    for (i = 0; i < 24; i++)
        copy_bufline(i, i + 1); 
    memset_(ptr + 24 * 160, 0, 160);
    memcpy_(screen, scrbuf, 4000);
    if (cursor_row > 0)
        cursor_row--;
}

void setcursor(word col, word row) {
    cursor_col = col;
    cursor_row = row;
}

void putch(char c) {
    if (c != '\n') {
        word index = cursor_row * 80 + cursor_col;
        word data = c + (textcol << 8);
        (*screen)[index] = data;
        (*scrbuf)[index] = data;
        cursor_col++;
    }

    if (c == '\n' || cursor_col == 80) {
        cursor_col = 0;
        if (cursor_row == 24)
            scrollup();
        cursor_row++;
    }
}

void setchar(word col, word row, char c) {
    word index = row * 80 + col;
    word data = c + (textcol << 8);
    (*screen)[index] = data;
    (*scrbuf)[index] = data;
}

void putstr(const char *str) {
    while (*str)
        putch(*(str++));
}

void putstr_inv(const char *str) {
    while (*str)
        putch(*(str++) + 0x80);
}

void puthexbyte(byte value) {
    char s[3];
    itohex(value, s);   
    if (value < 16)
        putch('0');
    putstr(s);
}
