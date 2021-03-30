#include "defs.h"
#include "bios.h"
#include "screen.h"
#include "lcd.h"
#include "lowlevel.h"
#include "strutils.h"
#include "utils.h"
#include "boot.h"
#include "start.h"
#include "sd.h"
#include "ff.h"

volatile word sp_save;
volatile word ss_save;

volatile byte hours;
volatile byte minutes;
volatile byte seconds;
volatile byte ticks; // 20 ticks/sec.

// interrupt handler
void int_div_by_zero() {
    clrscr();
    putstr("DIVIDE BY ZERO ERROR. SYSTEM HALTED.");
    asm("hlt");
}

void int_nmi() {
    clrscr();
    putstr("HARDWARE ERROR. SYSTEM HALTED.");
    asm("hlt");
}

void int_overflow() {
    clrscr();
    putstr("OVERFLOW ERROR. SYSTEM HALTED.");
    asm("hlt");
}

void int_timer() {
    ticks++;
    if (ticks == 20) {
        ticks = 0;
        seconds++;
        if (seconds == 60) {
            seconds = 0;
            minutes++;
            if (minutes == 60) {
                minutes = 0;
                hours++;
                if (hours == 24) {
                    hours = 0;
                }
            }
        }
    }
}

void int_keyboard() {

}

void int_drive() {
    sd_reset();
}

void demo1() {
    outp(0x50, 0b00000010);
    
    byte r, g, b;

    word x, y;
    byte __far *screen = (void __far *)0xC0000000;
    for (y = 0; y < 200; y++) {
        for (x = 0; x < 320; x++) {
            
            r = (x % 80) / 10;
            g = y / 25;
            b = x / 80;
            *(screen++) = (b << 6) + (g << 3) + (r << 0);
        }
    }
    screen = (void __far *)0xCFA00000;
    for (y = 0; y < 200; y++) {
        for (x = 0; x < 320; x++) {
            
            r = (x % 80) / 10;
            g = y / 25;
            b = x / 80;
            *(screen++) = (b << 6) + (g << 3) + (r << 0);
        }
    }

    while (1) ;
}

void demo2() {
    outp(0x50, 0b00000001); // 320 x 200 x 256
    byte __far *screen = (void __far *)0xC0000000;
    byte __far *picture = (void __far *)0xE0000000;
    memcpy1(screen, picture, 64000);

    while (1) ;
}

void demo() {
    word i, j;

    clrscr();
    while (1) {
        set_textcol(rand());
        putstr("ABCDEFGHIJKLMNOPQRSTXYZ");
    }
}

void fatfs_test() {
    char str[12], label[12];

    FATFS fs;
    DIR dj;
    FILINFO fno;
    FRESULT res;

    putstr("\n\n");

    res = f_mount(&fs, "", 0);
    putstr("f_mount: ");
    itoa(res, str);
    putstr(str);
    putch('\n');

    res = f_getlabel("", label, 0);
    putstr("f_getlabel: ");
    itoa(res, str);
    putstr(str);
    putch('\n');

    putstr("volume label: ");
    putstr(label);
    putch('\n');

    res = f_opendir(&dj, "");
    if (res == FR_OK) {
        res = f_readdir(&dj, &fno) ;
        while (res == FR_OK && fno.fname[0]) {
            putstr(fno.fname);
            putch('\n');
            res = f_readdir(&dj, &fno);
        }
        f_closedir(&dj);
    }
    
}

int main() {
    word i, j, k;
    byte a;
    char s[12];

    hours = 0;
    minutes = 0;
    seconds = 0;
    ticks = 0;

    init_screen();
#if LCD != 0
    lcd_init();
#endif

    // show startup screen, system test
    startup();

    for (i = 0; i < 1000; i++)
        for (j = 0; j < 100; j++)
            asm("nop");

    fatfs_test();
    while (1) ;

#if LCD == 1602
    lcd_putstr(0, 0, "                ");
    while (1) {
        itoa(hours, s);
        ltrim(s, 2, '0');
        lcd_putstr(8, 0, s);
        lcd_putstr(10, 0, ":");
        itoa(minutes, s);
        ltrim(s, 2, '0');
        lcd_putstr(11, 0, s);
        lcd_putstr(13, 0, ":");
        itoa(seconds, s);
        ltrim(s, 2, '0');
        lcd_putstr(14, 0, s);

        for (j = 0; j < 1000; j++)
            asm("nop");
    }
#endif
#if LCD == 2004
    while (1) {
        itoa(hours, s);
        ltrim(s, 2, '0');
        lcd_putstr(0, 3, s);
        lcd_putstr(2, 3, ":");
        itoa(minutes, s);
        ltrim(s, 2, '0');
        lcd_putstr(3, 3, s);
        lcd_putstr(5, 3, ":");
        itoa(seconds, s);
        ltrim(s, 2, '0');
        lcd_putstr(6, 3, s);

        for (j = 0; j < 1000; j++)
            asm("nop");
    }
#endif

    // boot from SD card
    boot();

    while (1) ;
}
