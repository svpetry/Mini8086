#include "lcd.h"
#include "types.h"
#include "strutils.h"
#include "lowlevel.h"

#define LCD_PORT 0x10
#define LCD_RS 0b00010000
#define LCD_E 0b00100000

static void lcd_delay_long() {
    int i;
    for (i = 0; i < 12000; i++) {
        asm volatile("nop");
    }
}

static void lcd_delay_short() {
    int i;
    for (i = 0; i < 60; i++) {
        asm volatile("nop");
    }
}

static void lcd_cmd(byte cmd) {
    byte a;

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
    byte a;
    
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

void lcd_puts(int col, int row, const char *str) {
    byte cmd;
    
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
