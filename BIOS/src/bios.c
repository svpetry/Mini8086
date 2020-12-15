#include "defs.h"
#include "bios.h"
#include "io.h"
#include "lowlevel.h"
#include "strutils.h"
#include "boot.h"
#include "start.h"

volatile unsigned int sp_save;
volatile unsigned int ss_save;

volatile unsigned char hours;
volatile unsigned char minutes;
volatile unsigned char seconds;
volatile unsigned char ticks; // 20 ticks/sec.

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

void demo() {
    while (1) {

    }
}

int main() {
    unsigned int i, j, k;
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

    demo();

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
