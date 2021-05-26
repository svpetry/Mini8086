#include "bios.h"
#include "../../Lib/screen.h"
#include "../../Lib/lcd.h"
#include "../../Lib/lowlevel.h"
#include "../../Lib/strutils.h"
#include "../../Lib/utils.h"
#include "../../Lib/ds1307.h"
#include "../../Lib/keys.h"
#include "defs.h"
#include "boot.h"
#include "start.h"
#include "sd.h"
#include "keyboard.h"
#include "ff.h"
#include "filebrowser.h"
#include "bios_setup.h"
#include "bios_api.h"
#include "bios_fsapi.h"

volatile word sp_save;
volatile word ss_save;

volatile byte t_hours;
volatile byte t_minutes;
volatile byte t_seconds;
volatile byte ticks; // 20 ticks/sec.

// interrupt handler
void int_div_by_zero() {
    clrscr();
    putstr("DIVIDE BY ZERO ERROR. SYSTEM HALTED.");
    asm volatile("hlt");
}

void int_nmi() {
    clrscr();
    putstr("HARDWARE ERROR. SYSTEM HALTED.");
    asm volatile("hlt");
}

void int_overflow() {
    clrscr();
    putstr("OVERFLOW ERROR. SYSTEM HALTED.");
    asm volatile("hlt");
}

void int_timer() {
    if (++ticks < 20) return;
    ticks = 0;
    if (++t_seconds < 60) return;
    t_seconds = 0;
    if (++t_minutes < 60) return;
    t_minutes = 0;
    if (++t_hours < 24) return;
    t_hours = 0;
}

void int_keyboard() {
    keyb_handleint();
}

void int_drive() {
    sd_reset();
    fsapi_unmount();
}

void update_clock() {
    byte hours, minutes, seconds;
    ds1307_gettime(&hours, &minutes, &seconds);
    ticks = 0;
    t_hours = hours;
    t_minutes = minutes;
    t_seconds = seconds;
}

void draw_menu() {
    setcursor(2, 24);
    putstr_inv("F1 BOOT FROM SD    F2 FILE SYSTEM BROWSER    F10 BIOS SETUP");
}

void handle_bootmenu() {
    char key = getchar();
    if (key == KEY_DELETE || key == KEY_ESCAPE || key >= KEY_F1 && key <= KEY_F12) {
        draw_menu();
        while (getchar()) asm volatile("nop");
        while (key != KEY_F1) {
            switch (key) {
                case KEY_F2:
                    filebrowser();
                    break;
                case KEY_F10:
                    bios_setup();
                    break;
            }
            while (!haschar()) asm volatile("nop");
            key = getchar();
        }
    }
}
/*
void __far test() {
    putstr("Hello!");
}
*/
int main() {
    word i, j, k;
    byte a;
    char s[12];

    t_hours = 0;
    t_minutes = 0;
    t_seconds = 0;
    ticks = 0;

    initialize_filesys();
    init_screen();
    keyb_init();
#if LCD != 0
    lcd_init();
#endif

    // show startup screen, system test
    startup();

    // update clock from RTC module
    if (cfg_rtc) update_clock();

    for (i = 0; i < 1000; i++)
        for (j = 0; j < 100; j++)
            asm volatile("nop");

    handle_bootmenu();

#if LCD == 1602
    lcd_putstr(0, 0, "                ");
    while (1) {
        itoa(t_hours, s);
        ltrim(s, 2, '0');
        lcd_putstr(8, 0, s);
        lcd_putstr(10, 0, ":");
        itoa(t_minutes, s);
        ltrim(s, 2, '0');
        lcd_putstr(11, 0, s);
        lcd_putstr(13, 0, ":");
        itoa(t_seconds, s);
        ltrim(s, 2, '0');
        lcd_putstr(14, 0, s);

        for (j = 0; j < 1000; j++)
            asm volatile("nop");
    }
#endif
#if LCD == 2004
    while (1) {
        itoa(t_hours, s);
        ltrim(s, 2, '0');
        lcd_putstr(0, 3, s);
        lcd_putstr(2, 3, ":");
        itoa(t_minutes, s);
        ltrim(s, 2, '0');
        lcd_putstr(3, 3, s);
        lcd_putstr(5, 3, ":");
        itoa(t_seconds, s);
        ltrim(s, 2, '0');
        lcd_putstr(6, 3, s);

        for (j = 0; j < 1000; j++)
            asm volatile("nop");
    }
#endif

    // void __far (*func)() = &test;

    // clrscr();
    // (*func)();

    // boot from SD card
    boot();

    while (1) ;
}
