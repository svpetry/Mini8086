#include "debug.h"
#include "../../Lib/types.h"
#include "../../Lib/utils.h"
#include "../../Lib/screen.h"
#include "../../Lib/lowlevel.h"
#include "../../Lib/strutils.h"
#include "ff.h"

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
    memcpy_(screen, picture, 64000);

    while (1) ;
}

void demo() {
    word i, j;

    clrscr();
    while (1) {
        set_textcol(rand());
        puts("ABCDEFGHIJKLMNOPQRSTXYZ");
    }
}

void fatfs_test() {
    char str[12], label[12];

    FATFS fs;
    DIR dj;
    FILINFO fno;
    FRESULT res;

    puts("\n\n");

    res = f_mount(&fs, "", 0);
    puts("f_mount: ");
    itoa(res, str);
    puts(str);
    putchar('\n');

    res = f_getlabel("", label, 0);
    puts("f_getlabel: ");
    itoa(res, str);
    puts(str);
    putchar('\n');

    puts("volume label: ");
    puts(label);
    putchar('\n');

    res = f_opendir(&dj, "");
    if (res == FR_OK) {
        res = f_readdir(&dj, &fno) ;
        while (res == FR_OK && fno.fname[0]) {
            puts(fno.fname);
            putchar('\n');
            res = f_readdir(&dj, &fno);
        }
        f_closedir(&dj);
    }
}

