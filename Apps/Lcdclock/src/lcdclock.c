#include "../../Lib/strutils.h"
#include "../../Lib/kernel.h"
#include "../../Lib/lowlevel.h"
#include "../../Lib/lcd.h"
#include "../../Lib/bios_time.h"

byte month_offs[12] = {0, 3, 3, 6, 1, 4, 6, 2, 5, 0, 3, 5};
byte month_offs_leap[12] = {0, 3, 4, 0, 2, 5, 0, 3, 6, 1, 4, 6};
char *weekdays[7] = {"Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"};

int calc_weekday(byte year, byte month, byte day) {
    byte m;
    long lyear = year + 2000;
    if (lyear % 4 == 0 && lyear % 100 != 0 || lyear % 400 == 0)
        m = month_offs_leap[month - 1];
    else
        m = month_offs[month - 1];
    long x = 
        day + m 
        + 5 * ((lyear - 1) % 4) 
        + 4 * ((lyear - 1) % 100) 
        + 6 * (lyear - 1) % 400;
    return x % 7;
}

void show_time(byte hours, byte minutes, byte seconds) {
    char s[6];
    byte col = 2, row = 1;
    itoa(hours, s);
    ltrim(s, 2, '0');
    lcd_puts(col, row, s);
    col += 2;
    lcd_puts(col++, row, ":");
    itoa(minutes, s);
    ltrim(s, 2, '0');
    lcd_puts(col, row, s);
    col += 2;
    lcd_puts(col++, row, ":");
    itoa(seconds, s);
    ltrim(s, 2, '0');
    lcd_puts(col, row, s);
}

void show_date() {
    byte year, month, day, hours, minutes, seconds;
    get_date_time(&year, &month, &day, &hours, &minutes, &seconds);

    byte col = 1, row = 0;
    char *weekday = weekdays[calc_weekday(year, month, day)];
    lcd_puts(col, row, weekday);
    col += 3;

    char s[6];
    itoa(day, s);
    ltrim(s, 2, '0');
    lcd_puts(col, row, s);
    col += 2;
    lcd_puts(col++, row, ".");
    itoa(month, s);
    ltrim(s, 2, '0');
    lcd_puts(col, row, s);
    col += 2;
    lcd_puts(col, row, ".20");
    col += 3;
    itoa(year, s);
    ltrim(s, 2, '0');
    lcd_puts(col, row, s);
}

void update_clock() {
    byte hours, minutes, seconds;
    get_time(&hours, &minutes, &seconds);
    show_time(hours, minutes, seconds);
    if (seconds == 0)
        show_date();
}

int main() {
    lcd_init();
    show_date();
    while (1) {
        update_clock();
        sleep(1000);
    }
}