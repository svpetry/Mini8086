#include "screen.h"
#include "strutils.h"
#include "lowlevel.h"
#include "utils.h"
#include "types.h"

#define SCREEN_COLUMNS 80
#define SCREEN_ROWS    25
#define SCREEN_SIZE (SCREEN_COLUMNS * SCREEN_ROWS)

byte cursor_state = 0;
byte cursor_enabled = 0;
byte cursor_hidden = 0;
byte cursor_col = 0;
byte cursor_row = 0;
byte textcol;
word __far (*screen)[SCREEN_SIZE];
word __far (*scrbuf)[SCREEN_SIZE];

static byte hide_cursor() {
    if (cursor_hidden || !cursor_enabled) return 0;

    cursor_hidden = 1;
    if (cursor_state) {
        word index = cursor_row * SCREEN_COLUMNS + cursor_col;
        (*screen)[index] = (*scrbuf)[index];
    }
    return 1;
}

static void restore_cursor() {
    if (!cursor_hidden || !cursor_enabled) return;

    if (cursor_state) {
        word index = cursor_row * SCREEN_COLUMNS + cursor_col;
        (*screen)[index] = (*scrbuf)[index] + 128;
    }
    cursor_hidden = 0;
}

void cursor_blink() {
    if (!cursor_enabled || cursor_hidden) return;

    word index = cursor_row * SCREEN_COLUMNS + cursor_col;
    if (cursor_state) {
        cursor_state = 0;
        (*screen)[index] = (*scrbuf)[index];
    } else {
        cursor_state = 1;
        (*screen)[index] = (*scrbuf)[index] + 128;
    }
}

void enable_cursor(byte enable) {
    if (cursor_enabled == enable) return;

    if (!enable && cursor_state && !cursor_hidden) {
        word index = cursor_row * SCREEN_COLUMNS + cursor_col;
        (*screen)[index] = (*scrbuf)[index];
    }
    cursor_enabled = enable;
    cursor_state = 0;
    cursor_hidden = 0;
}

void set_textcol(byte color) {
    textcol = color;
}

void init_screen() {
    outp(0x50, 0b00000000); // activate text mode
    outp(0x51, 0b10000000); // background color: blue

    screen = (void __far *)0xC0000000;
    scrbuf = (void __far *)0x04000000;
    textcol = 0b11100100; // light blue

    clrscr();
}

void clrscr() {
    byte hidden = hide_cursor();
    word data = textcol << 8;
    memset16(screen, data, SCREEN_SIZE);
    memset16(scrbuf, data, SCREEN_SIZE);
    setcursor(0, 0);
    if (hidden) restore_cursor();
}

void clrrow(byte row) {
    byte hidden = hide_cursor();
    word i;
    word data = textcol << 8;
    for (i = row * SCREEN_COLUMNS; i < (row + 1) * SCREEN_COLUMNS; i++) {
        (*screen)[i] = data;
        (*scrbuf)[i] = data;
    }
    if (hidden) restore_cursor();
}

static void copy_bufline(int dest, int src) {
    byte __far *bufptr = (byte __far *)scrbuf;
    memcpy_(bufptr + dest * SCREEN_COLUMNS * 2, bufptr + src * SCREEN_COLUMNS * 2, SCREEN_COLUMNS * 2);
}

void scrolldown() {
    byte hidden = hide_cursor();
    int i;
    for (i = 0; i < SCREEN_ROWS - 1; i++)
        copy_bufline(i + 1, i);
    memset16(scrbuf, (word)textcol << 8, SCREEN_COLUMNS);
    memcpy_(screen, scrbuf, SCREEN_SIZE * 2);
    if (cursor_row < SCREEN_ROWS - 1)
        cursor_row++;
    if (hidden) restore_cursor();
}

void scrollup() {
    byte hidden = hide_cursor();
    int i;
    byte __far *ptr = (byte __far *)scrbuf;
    for (i = 0; i < SCREEN_ROWS - 1; i++)
        copy_bufline(i, i + 1); 
    memset16(ptr + (SCREEN_ROWS - 1) * SCREEN_COLUMNS * 2, (word)textcol << 8, SCREEN_COLUMNS);
    memcpy_(screen, scrbuf, SCREEN_SIZE * 2);
    if (cursor_row > 0)
        cursor_row--;
    if (hidden) restore_cursor();
}

void setcursor(byte col, byte row) {
    byte hidden = hide_cursor();
    cursor_col = col;
    cursor_row = row;
    if (hidden) restore_cursor();
}

int putchar(int c) {
    char ch = (char)c;

    byte hidden = hide_cursor();
    if (ch != '\n') {
        word index = cursor_row * SCREEN_COLUMNS + cursor_col;
        word data = ch + (textcol << 8);
        (*screen)[index] = data;
        (*scrbuf)[index] = data;
        cursor_col++;
    }

    if (ch == '\n' || cursor_col == SCREEN_COLUMNS) {
        cursor_col = 0;
        if (cursor_row == SCREEN_ROWS - 1)
            scrollup();
        cursor_row++;
    }
    
    // handle backspace
    if (ch == 0x08) {
        if (cursor_col == 0) {
            if (cursor_row > 0) {
                cursor_row--;
                cursor_col = SCREEN_COLUMNS - 1;
            }
        } else
            cursor_col--;
        
        word index = cursor_row * SCREEN_COLUMNS + cursor_col;
        word data = 0x20 + (textcol << 8);
        (*screen)[index] = data;
        (*scrbuf)[index] = data;
    }
    if (hidden) restore_cursor();
    return 0;
}

void setchar(byte col, byte row, char c) {
    byte hidden = 0;
    if (col == cursor_col && row == cursor_row)
        hidden = hide_cursor();
    
    word index = row * SCREEN_COLUMNS + col;
    word data = c + (textcol << 8);
    (*screen)[index] = data;
    (*scrbuf)[index] = data;
    if (hidden) restore_cursor();
}

void settext(byte col, byte row, const char *s, byte color) {
    byte hidden = hide_cursor();
    word index = row * SCREEN_COLUMNS + col;
    while (*s && index < SCREEN_SIZE) {
        word data = *s + (textcol << 8);
        (*screen)[index] = data;
        (*scrbuf)[index] = data;
        s++;
        index++;
    }
    if (hidden) restore_cursor();
}

void settext_far(byte col, byte row, const char __far *s, byte color) {
    byte hidden = hide_cursor();
    word index = row * SCREEN_COLUMNS + col;
    while (*s && index < SCREEN_SIZE) {
        word data = *s + (textcol << 8);
        (*screen)[index] = data;
        (*scrbuf)[index] = data;
        s++;
        index++;
    }
    if (hidden) restore_cursor();
}

char getscreenchar(byte col, byte row) {
    word index = row * SCREEN_COLUMNS + col;
    return (*scrbuf)[index];
}

int puts(const char *str) {
    byte hidden = hide_cursor();
    while (*str)
        putchar(*(str++));
    if (hidden) restore_cursor();
    return 0;
}

int puts_inv(const char *str) {
    byte hidden = hide_cursor();
    while (*str)
        putchar(*(str++) + 0x80);
    if (hidden) restore_cursor();
    return 0;
}

int puts_far(const char __far *str) {
    byte hidden = hide_cursor();
    while (*str)
        putchar(*(str++));
    if (hidden) restore_cursor();
    return 0;
}

void puthexbyte(byte value) {
    byte hidden = hide_cursor();
    char s[3];
    itohex(value, s);   
    if (value < 16)
        putchar('0');
    puts(s);
    if (hidden) restore_cursor();
}
