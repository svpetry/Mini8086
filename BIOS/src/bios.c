#include "bios.h"
#include "io.h"
#include "utils.h"
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

int main() {
    hours = 0;
    minutes = 0;
    seconds = 0;
    ticks = 0;

    unsigned int i, j;
    char s[12];

    init_screen();
    lcd_init();

    // while (1) {
    //     itoa(seconds, s);
    //     strcat(s, " ");
    //     lcd_putstr(0, 0, s);
    // }

    // show startup screen, system test
    startup();

    // boot from SD card
    boot();

    while (1) ;
}
