#include "io.h"
#include "strutils.h"
#include "lowlevel.h"

#define LCD_PORT 0x10
#define LCD_RS 0b00010000
#define LCD_E 0b00100000

unsigned char cursor_col;
unsigned char cursor_row;
unsigned char textcol;
unsigned char __far (*screen)[4000];

void set_textcol(unsigned char col) {
    textcol = col;
}

void init_screen() {
    outp(0x50, 0b00000000); // activate text mode
    outp(0x51, 0b01000000); // background color: dark blue

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

void lcd_delay_long() {
    int i;
    for (i = 0; i < 12000; i++) {
        asm("nop");
    }
}

void lcd_delay_short() {
    int i;
    for (i = 0; i < 60; i++) {
        asm("nop");
    }
}

void lcd_cmd(unsigned char cmd) {
    unsigned char a;

    outp(LCD_PORT, 0x00);

    // higher nibble
    a = cmd >> 4;
    a |= LCD_E;
    outp(LCD_PORT, a);
    a &= ~LCD_E;
    outp(LCD_PORT, a);

    // lower nibble
    a = cmd & 0x0F;
    a |= LCD_E;
    outp(LCD_PORT, a);
    a &= ~LCD_E;
    outp(LCD_PORT, a);

    lcd_delay_short();
}

void lcd_clear() {
    lcd_cmd(0b00000001);
    lcd_delay_long();
}

void lcd_init() {
    unsigned char a;
    
    outp(LCD_PORT, 0x00);

    // init
    a = 0b00000011;

    a |= LCD_E;
    outp(LCD_PORT, a);
    a &= ~LCD_E;
    outp(LCD_PORT, a);
    lcd_delay_long();

    a |= LCD_E;
    outp(LCD_PORT, a);
    a &= ~LCD_E;
    outp(LCD_PORT, a);
    lcd_delay_long();

    a |= LCD_E;
    outp(LCD_PORT, a);
    a &= ~LCD_E;
    outp(LCD_PORT, a);
    lcd_delay_long();
    
    // init 4 bit mode
    a = 0b00000010;
    a |= LCD_E;
    outp(LCD_PORT, a);
    a &= ~LCD_E;
    outp(LCD_PORT, a);

    // clear screen, cursor to pos 0
    lcd_clear();

    // cursor direction right, shift off
    lcd_cmd(0b00000110);
    lcd_delay_long();

    // display on, cursor off
    lcd_cmd(0b00001100);

    // 4 bit interface, two rows 
    lcd_cmd(0b00101000);
}

void lcd_putstr(int col, int row, char *str) {
    unsigned char cmd;
    
    // set cursor position
    switch (row) {
        case 0:
            cmd = 0x00;
            break;
        case 1:
            cmd = 0x40;
            break;
        case 2:
            cmd = 0x14;
            break;
        case 3:
            cmd = 0x54;
            break;
    }
    cmd = (cmd + col) | 0b10000000;
    lcd_cmd(cmd);

    // write characters
    outp(LCD_PORT, LCD_RS);
    while (*str) {
        cmd = *str >> 4;
        cmd |= LCD_RS | LCD_E;
        outp(LCD_PORT, cmd);
        cmd &= ~LCD_E;
        outp(LCD_PORT, cmd);

        cmd = *str & 0x0F;
        cmd |= LCD_RS | LCD_E;
        outp(LCD_PORT, cmd);
        cmd &= ~LCD_E;
        outp(LCD_PORT, cmd);

        lcd_delay_short();

        str++;
    }
}