#include "start.h"
#include "../../Lib/screen.h"
#include "../../Lib/lcd.h"
#include "../../Lib/strutils.h"
#include "../../Lib/types.h"
#include "../../Lib/lowlevel.h"
#include "../../Lib/i2c.h"
#include "../../Lib/eeprom.h"
#include "../../Lib/bmp280.h"
#include "../../Lib/ds1307.h"
#include "defs.h"
#include "build.h"
#include "sd.h"

#define RESULT_COL 20

extern volatile byte ticks;

byte cfg_sddrive;
byte cfg_rs232;
byte cfg_i2c;
byte cfg_eeprom;
byte cfg_bmp280;
byte cfg_rtc;

char freq_str[5];
int ram_kb;
volatile byte __far (*memptr);
 
static void error() {
    putstr(" ERROR!");
    while (1) ;
}

static void check_cpu(int row) {
    setcursor(4, row);
    putstr("CPU");

    setcursor(RESULT_COL, row);
    putstr("--.- MHz");
    putstr(", Intel 8086 or compatible");
}

static void check_memory(int row) {
    unsigned long count;
    char s[12];

    setcursor(4, row);
    putstr("RAM");

    // test first 64 KB
    setcursor(RESULT_COL, row);
    putstr("64 KB");
    memptr = (unsigned char __far *)0x00001000;
    count = 0;
    while (count < 0xF000) {
        *memptr = 0xAA;
        if (*memptr != 0xAA) error();
        *memptr = 0x55;
        if (*memptr != 0x55) error();
        if (count < 0x400) {
            memptr++;
            count++;
        } else {
            memptr += 0x10;
            count += 0x10;
        }
    }

    // test rest of memory
    unsigned long memstart = 0x10000000;
    while (memstart < 0xC0000000) {
        memptr = (byte __far *)memstart;

        // check if memory block present
        *memptr = 0x0F;
        if (*memptr != 0x0F) break;

        setcursor(RESULT_COL, row);
        ram_kb = ((memstart >> 28) + 1) * 64;
        itoa(ram_kb, s);
        putstr(s);
        putstr(" KB");

        count = 0;
        while (count < 0x10000) {
            *memptr = 0xAA;
            if (*memptr != 0xAA) error();
            *memptr = 0x55;
            if (*memptr != 0x55) error();
            if (count < 0x400) {
                memptr++;
                count++;
            } else {
                memptr += 0x10;
                count += 0x10;
            }
        }

        memstart += 0x10000000;
    }

    putstr(" OK");
}

static void check_timer(int row) {
    setcursor(4, row);
    putstr("Timer");

    int i;
    word count = 10000;
    byte t = ticks;
    while (t == ticks && count > 0) {
        for (i = 0; i < 10; i++) {
            asm("nop");
        }
        count--;
    }
    if (count == 0) {
        error();
        return;
    }

    // measure CPU frequency
    count = 0;
    for (i = 0; i < 4; i++) {
        t = ticks;
        while (t == ticks)
            count++;
    }
    
    // count /= 342;
    count /= 320;
    i = count / 100;
    if (i == 0)
        freq_str[0] = ' ';
    else
        freq_str[0] = '0' + i;
    count -= i * 100;
    i = count / 10;
    freq_str[1] = '0' + i;
    freq_str[2] = '.';
    count -= i * 10;
    freq_str[3] = '0' + count;
    freq_str[4] = 0;

    setcursor(RESULT_COL, 2);
    putstr(freq_str);
  
    setcursor(RESULT_COL, row);
    putstr("OK");
}

static void check_keyboard(int row) {
    int i, j;
    byte data, status;

    setcursor(4, row);
    putstr("Keyboard");
    setcursor(RESULT_COL, row);

    outp(0x64, 0xAA);
    data = 0;
    for (j = 0; j < 10 && data != 0x55; j++) {
        for (i = 0; i < 2000; i++) asm("nop");
        data = inp(0x60);
    }
    if (data != 0x55) {
        putstr("N/A");
        return;
    }

    outp(0x64, 0xAB); // perform controller self test
    status = 0;
    for (j = 0; j < 10 && (status & 1) == 0; j++) {
        for (i = 0; i < 2000; i++) asm("nop");
        status = inp(0x64);
    }
    if ((status & 1) == 1) {
        data = inp(0x60);
        switch (data) {
            case 0x00:
                outp(0x64, 0x60); // write controller configuration byte
                while ((inp(0x64) & 0b00000010) > 1) ; // wait for empty input buffer
                outp(0x60, 0b00000001); // enable first PS/2 port interrupt
                
                while ((inp(0x64) & 0b00000010) > 1) ; // wait for empty input buffer
                outp(0x64, 0xAE); // enable keyboard interface
                putstr("OK");
                return;
            case 0x01:
                putstr("ERROR: clock line is stuck low");
                return;
            case 0x02:
                putstr("ERROR: clock line is stuck high");
                return;
            case 0x03:
                putstr("ERROR: data line is stuck low");
                return;
            case 0x04:
                putstr("ERROR: data line is stuck high");
                return;
        }
    }
    putstr("self test failed!");
}

static void check_serial(int row) {
    setcursor(4, row);
    putstr("Serial ports");
    setcursor(RESULT_COL, row);

    putstr("N/A");
}

static void check_sd_drive(int row) {
    setcursor(4, row);
    putstr("SD drive");
    setcursor(RESULT_COL, row);

    if (sd_reset()) {
        putstr("OK");
        cfg_sddrive = 1;        
    } else {
        putstr("N/A");
        cfg_sddrive = 0;
    }
}

static void check_sound(int row) {
    setcursor(4, row);
    putstr("Sound");
    setcursor(RESULT_COL, row);

    putstr("N/A");
}

static void check_i2c(int row) {
    setcursor(4, row);
    putstr("I2C controller");
    setcursor(RESULT_COL, row);

    if (!i2c_init(I2CF_88)) {
        putstr("OK");
        cfg_i2c = 1;        
    } else {
        putstr("N/A");
        cfg_i2c = 0;
    }
}

static void check_rtc(int row) {
    setcursor(5, row);
    putch(28);
    putstr(" RTC");
    setcursor(RESULT_COL, row);

    if (cfg_i2c && !ds1307_init()) {
        putstr("OK");
        cfg_rtc = 1;        
    } else {
        putstr("N/A");
        cfg_rtc = 0;
    }
}

static void check_eeprom(int row) {
    setcursor(5, row);
    putch(28);
    putstr(" EEPROM");
    setcursor(RESULT_COL, row);

    byte data;
    if (cfg_i2c && !eeprom_read_buf(0x00, &data, 1)) {
        putstr("OK");
        cfg_eeprom = 1;        
    } else {
        putstr("N/A");
        cfg_eeprom = 0;
    }
}

static void check_bmp280(int row) {
    setcursor(5, row);
    putch(28);
    putstr(" Sensor");
    setcursor(RESULT_COL, row);

    if (cfg_i2c && !bmp280_init()) {
        putstr("OK");
        cfg_bmp280 = 1;        
    } else {
        putstr("N/A");
        cfg_bmp280 = 0;
    }
}

void startup() {
    int i;
    for (i = 0; i < 80; i++) {
        setchar(i, 0, ' ' + 128);
        setchar(i, 24, ' ' + 128);
    }
    setcursor(1, 0);
    putstr_inv("Mini8086 BIOS 0.1");
    setcursor(64, 0);
    putstr_inv(BUILD);

    i = 2;
    check_cpu(i++);
    check_memory(i++);
    check_timer(i++);
    check_keyboard(i++);
    check_serial(i++);
    check_sd_drive(i++);
    check_sound(i++);
    check_i2c(i++);
    check_rtc(i++);
    check_eeprom(i++);
    check_bmp280(i++);

#if LCD == 1602
    lcd_putstr(0, 0, "Mini8086     0.1");
#endif
#if LCD == 2004
    lcd_putstr(0, 0, "Mini8086 BIOS    0.1");
#endif
#if LCD != 0
    char s[6];
    lcd_putstr(0, 1, freq_str);
    lcd_putstr(5, 1, "MHz");
    itoa(ram_kb, s);
    lcd_putstr(10, 1, s);
    lcd_putstr(14, 1, "KB");
#endif
}