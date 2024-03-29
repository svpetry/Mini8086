#include "boot.h"
#include "../../Lib/screen.h"
#include "../../Lib/strutils.h"
#include "defs.h"
#include "start.h"
#include "sd.h"
#include "bios.h"
#include "ff.h"

#define BOOT_ROW 20
#define BOOT_COL 4

static void setline(char *s) {
    int i;
    setcursor(BOOT_COL, BOOT_ROW);
    puts(s);
    for (i = 0; i < 80 - strlen(s); i++)
        putchar(' ');
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
    void __far *dest = (void __far *)0x05000000;

    res = f_mount(&fs, "", 0);
    if (res != FR_OK) return;

    res = f_open(&f, "kernel.bin", FA_READ);
    if (res != FR_OK) return;

    // load kernel.bin to 0500:0000
    size = f_size(&f);
    res = f_read(&f, dest, size, &br);
    if (res != FR_OK)
        return;
    f_close(&f);
    f_unmount("");

    clrscr();

    // initialize segments and stack, then far jump to 0500:0000
    asm(
        "cli\n"
        "mov $0x0500, %ax\n"
        "mov %ax, %ds\n"
        "mov %ax, %es\n"
        "mov %ax, %ss\n"
        "mov $0x0AFFE, %sp\n"
        "sti\n"
        "ljmp $0x0500, $0x0000\n"
    );
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
                setline("Could not load kernel.bin. Please remove SD card.");
                delay_1sec();
            }
            setline("");

            sd_reset();
            delay_1sec();
        }
    } else
        setline("No boot drive present. System halted.");
}
