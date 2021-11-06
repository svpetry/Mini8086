#include "screen.h"
#include "strutils.h"
#include "lowlevel.h"
#include "utils.h"
#include "types.h"
#include "colors.h"

#define SCREEN_COLUMNS 80
#define SCREEN_ROWS    25
#define SCREEN_SIZE (SCREEN_COLUMNS * SCREEN_ROWS)

byte cursor_state = 0;
byte cursor_enabled = 0;
byte cursor_hidden = 0;
byte cursor_col = 0;
byte cursor_row = 0;
byte s_first_row = 0;
byte s_last_row = SCREEN_ROWS - 1;
byte text_color;
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
    text_color = color;
}

void init_screen() {
    outp(0x50, 0b00000000); // activate text mode
    outp(0x51, DARKER_BLUE); // background color: darker blue

    screen = (void __far *)0xC0000000;
    scrbuf = (void __far *)0x04000000;
    text_color = LIGHTER_BLUE;

    clrscr();
}

void clrscr() {
    byte hidden = hide_cursor();
    s_first_row = 0;
    s_last_row = SCREEN_ROWS - 1;
    word data = text_color << 8;
    memset16(screen, data, SCREEN_SIZE);
    memset16(scrbuf, data, SCREEN_SIZE);
    setcursor(0, 0);
    if (hidden) restore_cursor();
}

void clrrow(byte row) {
    byte hidden = hide_cursor();
    word i;
    word data = text_color << 8;
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
    for (i = s_first_row; i < s_last_row; i++)
        copy_bufline(i + 1, i);
    memset16(scrbuf + s_first_row * SCREEN_COLUMNS * 2, (word)text_color << 8, SCREEN_COLUMNS);
    memcpy_(screen, scrbuf, SCREEN_SIZE * 2);
    if (cursor_row < SCREEN_ROWS - 1)
        cursor_row++;
    if (hidden) restore_cursor();
}

void scrollup() {
    byte hidden = hide_cursor();
    int i;
    byte __far *ptr = (byte __far *)scrbuf;
    for (i = s_first_row; i < s_last_row; i++)
        copy_bufline(i, i + 1); 
    memset16(ptr + s_last_row * SCREEN_COLUMNS * 2, (word)text_color << 8, SCREEN_COLUMNS);
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

void setdimensions(byte first_row, byte last_row) {
    s_first_row = first_row;
    s_last_row = last_row;
}

int putchar(int c) {
    byte ch = (byte)c;

    byte hidden = hide_cursor();
    if ((ch & 0b01111111) > 0x1F) {
        word index = cursor_row * SCREEN_COLUMNS + cursor_col;
        word data = ch + (((word)text_color) << 8);
        (*screen)[index] = data;
        (*scrbuf)[index] = data;
        cursor_col++;
    }

    if (ch == '\n' || cursor_col == SCREEN_COLUMNS) {
        cursor_col = 0;
        if (cursor_row == s_last_row)
            scrollup();
        cursor_row++;
    }
    
    // handle backspace
    if (ch == 0x08) {
        if (cursor_col == 0) {
            if (cursor_row > s_first_row) {
                cursor_row--;
                cursor_col = SCREEN_COLUMNS - 1;
            }
        } else
            cursor_col--;
        
        word index = cursor_row * SCREEN_COLUMNS + cursor_col;
        word data = 0x20 + (text_color << 8);
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
    word data = (byte)c + (text_color << 8);
    (*screen)[index] = data;
    (*scrbuf)[index] = data;
    if (hidden) restore_cursor();
}

void settext(byte col, byte row, const char *s, byte color) {
    byte hidden = hide_cursor();
    word index = row * SCREEN_COLUMNS + col;
    while (*s && index < SCREEN_SIZE) {
        word data = (byte)*s + (text_color << 8);
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
        word data = (byte)*s + (text_color << 8);
        (*screen)[index] = data;
        (*scrbuf)[index] = data;
        s++;
        index++;
    }
    if (hidden) restore_cursor();
}

void settext_far_inv(byte col, byte row, const char __far *s, byte color) {
    byte hidden = hide_cursor();
    word index = row * SCREEN_COLUMNS + col;
    while (*s && index < SCREEN_SIZE) {
        word data = ((byte)*s | 0x80) + (text_color << 8);
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
        putchar(*(str++) | 0x80);
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
