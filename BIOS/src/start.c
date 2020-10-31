#include "start.h"
#include "io.h"
#include "utils.h"

#define RESULT_COL 20

extern unsigned char ticks;

char cfg_sddrive;
 
void error() {
    putstr(" ERROR!");
    while (1) ;
}

void check_cpu(int row) {
    setcursor(4, row);
    putstr("CPU");

    setcursor(RESULT_COL, row);
    putstr("--.- MHz");
    putstr(", Intel 8086 or compatible");
}

void check_memory(int row) {
    unsigned char __far (*memptr);
    unsigned long count;
    char s[12];

    setcursor(4, row);
    putstr("RAM");

    // test first 64 KB
    setcursor(RESULT_COL, row);
    putstr("64 KB");
    memptr = (unsigned char __far *)0x00000600;
    count = 0;
    while (count < 0xFA00) {
        *memptr = 0xAA;
        if (*memptr != 0xAA) error();
        *memptr = 0x55;
        if (*memptr != 0x55) error();
        if (count < 0x100) {
            memptr++;
            count++;
        } else {
            memptr += 0x100;
            count += 0x100;
        }
    }

    // test rest of memory
    unsigned long memstart = 0x10000000;
    while (memstart < 0xC0000000) {
        memptr = (unsigned char __far *)memstart;

        // check if memory block present
        *memptr = 0x0F;
        if (*memptr != 0x0F) break;

        setcursor(RESULT_COL, row);
        itoa(((memstart >> 28) + 1) * 64, s);
        putstr(s);
        putstr(" KB");

        count = 0;
        while (count < 0x10000) {
            *memptr = 0xAA;
            if (*memptr != 0xAA) error();
            *memptr = 0x55;
            if (*memptr != 0x55) error();
            if (count < 0x100) {
                memptr++;
                count++;
            } else {
                memptr += 0x100;
                count += 0x100;
            }
        }

        memstart += 0x10000000;
    }

    putstr(" OK");
}

void check_timer(int row) {
    setcursor(4, row);
    putstr("Timer");
 
    int i;
    unsigned int count = 10000;
    unsigned char t = ticks;
    while (t == ticks && count > 0) {
        for (i = 0; i < 10; i++) ;
        count--;
    }
    if (count == 0) {
        error();
        return;
    }

    count = 0;
    for (i = 0; i < 4; i++) {
        t = ticks;
        while (t == ticks)
            count++;
    }
    
    count /= 297;
    setcursor(RESULT_COL, 2);
    i = count / 100;
    if (i == 0)
        putch(' ');
    else
        putch('0' + i);
    count -= i * 100;
    i = count / 10;
    putch('0' + i);
    putch('.');
    count -= i * 10;
    putch('0' + count);
  
    setcursor(RESULT_COL, row);
    putstr("OK");
}

void check_keyboard(int row) {
    setcursor(4, row);
    putstr("Keyboard");
    setcursor(RESULT_COL, row);

    putstr("N/A");
}

void check_serial(int row) {
    setcursor(4, row);
    putstr("Serial ports");
    setcursor(RESULT_COL, row);

    putstr("N/A");
}

void check_sd_drive(int row) {
    setcursor(4, row);
    putstr("SD drive");
    setcursor(RESULT_COL, row);

    putstr("N/A");
    cfg_sddrive = 0;
}

void check_sound(int row) {
    setcursor(4, row);
    putstr("Sound");
    setcursor(RESULT_COL, row);

    putstr("N/A");
}

void startup() {
    int i;
    setcursor(0, 0);
    for (i = 0; i < 80; i++)
        putch(' ' + 128);
    setcursor(0, 24);
    for (i = 0; i < 80; i++)
        putch(' ' + 128);
    setcursor(1, 0);
    putstr_inv("Mini8086 BIOS 0.1   2020");

    i = 2;
    check_cpu(i++);
    check_memory(i++);
    check_timer(i++);
    check_keyboard(i++);
    check_serial(i++);
    check_sd_drive(i++);
    check_sound(i++);

    lcd_putstr(0, 0, "Mini8086     0.1");
    lcd_putstr(0, 1, "System ready!   ");
}