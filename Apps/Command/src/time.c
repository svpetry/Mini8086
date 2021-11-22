#include "time.h"
#include "cmdline.h"
#include "utils.h"
#include "../../Lib/bios_screen.h"
#include "../../Lib/bios_misc.h"
#include "../../Lib/bios_time.h"
#include "../../Lib/strutils.h"

void getset_time() {
    if (paramcount > 1) {
        char *time = params[1];
        if (strlen(time) != 8 || time[2] != ':' || time[5] != ':') {
            puts("Error: wrong time format.\n");
        }
        byte hours, minutes, seconds;
        time[5] = 0;
        time[2] = 0;
        seconds = atoi(time + 6);
        minutes = atoi(time + 3);
        hours = atoi(time);
        set_time(hours, minutes, seconds);
        return;
    }
    
    byte year, month, day, hours, minutes, seconds;
    get_date_time(&year, &month, &day, &hours, &minutes, &seconds);
    puts("\n  ");
    put2digits(hours);
    putchar(':');
    put2digits(minutes);
    putchar(':');
    put2digits(seconds);
    putchar('\n');
}

void getset_date() {
    if (paramcount > 1) {
        char *date = params[1];
        if (strlen(date) != 10 || date[4] != '-' || date[7] != '-') {
            puts("Error: wrong date format.\n");
        }
        byte year, month, day;
        date[7] = 0;
        date[4] = 0;
        day = atoi(date + 8);
        month = atoi(date + 5);
        year = atoi(date) - 2000;
        set_date(year, month, day);
        return;
    }
    
    byte year, month, day, hours, minutes, seconds;
    get_date_time(&year, &month, &day, &hours, &minutes, &seconds);
    puts("\n  20");
    put2digits(year);
    putchar('-');
    put2digits(month);
    putchar('-');
    put2digits(day);
    putchar('\n');
}