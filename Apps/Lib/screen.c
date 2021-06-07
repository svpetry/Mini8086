#include "screen.h"
#include "strutils.h"
#include "lowlevel.h"
#include "utils.h"
#include "types.h"

#define SCREEN_COLUMNS 80
#define SCREEN_ROWS    25
#define SCREEN_SIZE (SCREEN_COLUMNS * SCREEN_ROWS)

byte cursor_col;
byte cursor_row;
byte textcol;
word __far (*screen)[SCREEN_SIZE];
word __far (*scrbuf)[SCREEN_SIZE];

void set_textcol(byte color) {
    textcol = color;
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
    for (i = 0; i < SCREEN_SIZE; i++) {
        (*screen)[i] = 0;
        (*scrbuf)[i] = 0;
    }
    setcursor(0, 0);
}

void clrrow(byte row) {
    word i;
    for (i = row * SCREEN_COLUMNS; i < (row + 1) * SCREEN_COLUMNS; i++) {
        (*screen)[i] = 0;
        (*scrbuf)[i] = 0;
    }
}

static void copy_bufline(int dest, int src) {
    byte __far *bufptr = (byte __far *)scrbuf;
    memcpy_(bufptr + dest * SCREEN_COLUMNS * 2, bufptr + src * SCREEN_COLUMNS * 2, SCREEN_COLUMNS * 2);
}

void scrolldown() {
    int i;
    for (i = 0; i < SCREEN_ROWS - 1; i++)
        copy_bufline(i + 1, i);
    memset_(scrbuf, 0, SCREEN_COLUMNS * 2);
    memcpy_(screen, scrbuf, SCREEN_SIZE * 2);
    if (cursor_row < SCREEN_ROWS - 1)
        cursor_row++;
}

void scrollup() {
    int i;
    byte __far *ptr = (byte __far *)scrbuf;
    for (i = 0; i < SCREEN_ROWS - 1; i++)
        copy_bufline(i, i + 1); 
    memset_(ptr + (SCREEN_ROWS - 1) * SCREEN_COLUMNS * 2, 0, SCREEN_COLUMNS * 2);
    memcpy_(screen, scrbuf, SCREEN_SIZE * 2);
    if (cursor_row > 0)
        cursor_row--;
}

void setcursor(byte col, byte row) {
    cursor_col = col;
    cursor_row = row;
}

int putchar(int c) {
    if (c != '\n') {
        word index = cursor_row * SCREEN_COLUMNS + cursor_col;
        word data = c + (textcol << 8);
        (*screen)[index] = data;
        (*scrbuf)[index] = data;
        cursor_col++;
    }

    if (c == '\n' || cursor_col == SCREEN_COLUMNS) {
        cursor_col = 0;
        if (cursor_row == SCREEN_ROWS - 1)
            scrollup();
        cursor_row++;
    }
    return 0;
}

void setchar(byte col, byte row, char c) {
    word index = row * SCREEN_COLUMNS + col;
    word data = c + (textcol << 8);
    (*screen)[index] = data;
    (*scrbuf)[index] = data;
}

void settext(byte col, byte row, const char *s, byte color) {
    word index = row * SCREEN_COLUMNS + col;
    while (*s && index < SCREEN_SIZE) {
        word data = *s + (textcol << 8);
        (*screen)[index] = data;
        (*scrbuf)[index] = data;
        s++;
        index++;
    }
}

void settext_far(byte col, byte row, const char __far *s, byte color) {
    word index = row * SCREEN_COLUMNS + col;
    while (*s && index < SCREEN_SIZE) {
        word data = *s + (textcol << 8);
        (*screen)[index] = data;
        (*scrbuf)[index] = data;
        s++;
        index++;
    }
}

char getscreenchar(byte col, byte row) {
    word index = row * SCREEN_COLUMNS + col;
    return (*scrbuf)[index];
}

int puts(const char *str) {
    while (*str)
        putchar(*(str++));
    return 0;
}

int puts_inv(const char *str) {
    while (*str)
        putchar(*(str++) + 0x80);
    return 0;
}

int puts_far(const char __far *str) {
    while (*str)
        putchar(*(str++));
    return 0;
}

void puthexbyte(byte value) {
    char s[3];
    itohex(value, s);   
    if (value < 16)
        putchar('0');
    puts(s);
}
