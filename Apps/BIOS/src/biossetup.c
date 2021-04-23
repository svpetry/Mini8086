#include "biossetup.h"
#include "../../Lib/types.h"
#include "../../Lib/keys.h"
#include "../../Lib/screen.h"
#include "keyboard.h"
#include "bios.h"
#include "../../Lib/strutils.h"
#include "../../Lib/ds1307.h"
#include "start.h"

#define BS_COLUMN 20
#define BS_ROW 6
#define BS_COLUMN2 42

static void putnum_2(int num) {
    if (num < 10)
        putch('0');
    else
        putch('0' + num / 10);
    putch('0' + num % 10);    
}

static void update_values() {
    // time
    setcursor(BS_COLUMN2, BS_ROW);
    putnum_2(t_hours);
    putch(':');
    putnum_2(t_minutes);
    putch(':');
    putnum_2(t_seconds);

    // date
    setcursor(BS_COLUMN2, BS_ROW + 1);
    if (cfg_rtc) {
        byte day, month, year;
        ds1307_getdate(&day, &month, &year);
        putnum_2(day);
        putch('-');
        putnum_2(month);
        putstr("-20");
        putnum_2(year);
    } else {
        putstr("(RTC not available)");
    }

    // keyboard layout
    setcursor(BS_COLUMN2, BS_ROW + 2);
    putstr("DE");
}

static int input_number(byte col, byte row, byte digits) {
    int num = 0;
    int i;
    while (digits > 0) {
        byte wait = 1;
        do {
            setcursor(col, row);
            putch(' ' + 128);
            for (i = 0; i < 20000 & !haschar(); i++) asm("nop");
            if (!haschar()) {
                setcursor(col, row);
                putch(' ');
                for (i = 0; i < 20000 & !haschar(); i++) asm("nop");
            }
            char c = getchar();
            if (c >= '0' && c <= '9') {
                setcursor(col, row);
                putch(c);
                num = num * 10 + c - '0';
                wait = 0;
            }
        } while (wait);
        col++;
        digits--;
    }
    return num;
}

static void input_time() {
    byte hours = input_number(BS_COLUMN2, BS_ROW, 2);
    byte minutes = input_number(BS_COLUMN2 + 3, BS_ROW, 2);
    byte seconds = input_number(BS_COLUMN2 + 6, BS_ROW, 2);
    if (hours > 23) hours = 23;
    if (minutes > 59) minutes = 59;
    if (seconds > 59) seconds = 59;
    asm("CLI");
    t_hours = hours;
    t_minutes = minutes;
    t_seconds = seconds;
    asm("STI");
    if (cfg_rtc) ds1307_settime(hours, minutes, seconds);
}

static void input_date() {
    byte day = input_number(BS_COLUMN2, BS_ROW + 1, 2);
    byte month = input_number(BS_COLUMN2 + 3, BS_ROW + 1, 2);
    byte year = input_number(BS_COLUMN2 + 8, BS_ROW + 1, 2);
    if (day > 31) day = 31;
    if (month > 12) month = 12;
    ds1307_setdate(day, month, year);
}

static void input_keylayout() {

}

void biossetup() {
    int i;

    for (i = 1; i < 23; i++)
        clrrow(i);
    for (i = 0; i < 80; i++)
        setchar(i, 24, ' ' + 128);

    byte exit = 0;
    do {
        setcursor(BS_COLUMN, BS_ROW);
        putstr("[1] Time");
        setcursor(BS_COLUMN, BS_ROW + 1);
        putstr("[2] Date");
        setcursor(BS_COLUMN, BS_ROW + 2);
        putstr("[3] Keyboard layout");

        i = 0;
        while (!haschar()) {
            if (++i == 2000) {
                i = 0;
                update_values();
            }
        }

        char c = getchar();
        switch (c) {
            case '1':
                input_time();
                break;
            case '2':
                input_date();
                break;
            case '3':
            input_keylayout();
                break;
            case KEY_ESCAPE:
                exit = 1;
                break;
        }

    } while (!exit);

    asm("ljmpw $0xFFFF, $0x0000");
}
