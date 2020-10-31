#include "bios.h"
#include "io.h"
#include "utils.h"
#include "boot.h"
#include "start.h"

unsigned char hours;
unsigned char minutes;
unsigned char seconds;
unsigned char ticks; // 20 ticks/sec.

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

void int_bios() {
    
}

int main() {
    hours = 0;
    minutes = 0;
    seconds = 0;
    ticks = 0;

    unsigned int i, j;

    lcd_init();
    init_screen();

    // show startup screen, system test
    startup();

    // boot from SD card
    boot();

    while (1) ;
}
