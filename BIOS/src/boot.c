#include "boot.h"
#include "defs.h"
#include "screen.h"
#include "strutils.h"
#include "start.h"
#include "sd.h"
#include "bios.h"
#include "ff.h"

#define BOOT_ROW 20
#define BOOT_COL 40

static void setline(char *s) {
    int i;
#ifndef SD_DEBUG
    setcursor(BOOT_COL, BOOT_ROW);
#endif
    putstr(s);
#ifndef SD_DEBUG
    for (i = 0; i < 80 - strlen(s); i++) putch(' ');
#endif
}

static void delay_1sec() {
    int start_ticks = ticks;
    while (ticks == start_ticks) ;
    while (ticks != start_ticks) ;
}

static void tryboot() {
    FATFS fs;
    FIL f;
    FSIZE_t size;
    FRESULT res;
    UINT br;
    void __far * dest = (void __far *)0x01000000;

    res = f_mount(&fs, "", 0);
    if (res != FR_OK) return;

    res = f_open(&f, "boot.bin", FA_READ);
    if (res != FR_OK) return;

    // size = f_size(&f);
    // res = f_read(&f, dest, size, &br);
    // if (res != FR_OK) return;

    asm("nop");

    while (1) ;
}

void boot() {
#if SD_DEBUG
    clrscr();
#endif
    if (cfg_sddrive) {
        
        while (1) {
            while (!sd_inserted()) {
                setline("Please insert SD card.");
                delay_1sec();
            }
            setline("");
            delay_1sec();

            tryboot();

            while (sd_inserted()) {
                setline("Could not load boot.bin. Please remove SD card.");
                delay_1sec();
            }
            setline("");
            
            sd_reset();
            delay_1sec();
        }
    } else
        setline("No boot drive present. System halted.");
}