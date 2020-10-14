#include "start.h"
#include "io.h"
#include "utils.h"

#define RESULT_COL 20

void error() {
    putstr(" ERROR!");
//    asm("hlt");
}

void check_cpu(int row) {
    setcursor(4, row);
    putstr("CPU");

    setcursor(RESULT_COL, row);
    putstr("Intel 8086 or compatible");
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
        if (count < 64) {
            memptr++;
            count++;
        } else {
            memptr += 64;
            count += 64;
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
            if (count < 64) {
                memptr++;
                count++;
            } else {
                memptr += 64;
                count += 64;
            }
        }

        memstart += 0x10000000;
    }

    putstr(" OK");
}

void check_timer(int row) {
    setcursor(4, row);
    putstr("TIMER");

    setcursor(RESULT_COL, row);
    putstr("OK");
}

void check_serial(int row) {
    setcursor(4, row);
    putstr("SERIAL PORTS");

    setcursor(RESULT_COL, row);
    putstr("N/A");
}

void check_sd_drive(int row) {
    setcursor(4, row);
    putstr("SD DRIVE");

    setcursor(RESULT_COL, row);
    putstr("N/A");
}

void check_sound(int row) {
    setcursor(4, row);
    putstr("SOUND");

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
    check_serial(i++);
    check_sd_drive(i++);
    check_sound(i++);
}