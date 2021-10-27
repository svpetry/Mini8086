#include "utils.h"
#include "../../Lib/bios_screen.h"
#include "../../Lib/strutils.h"

void put2digits(byte num) {
    char s[4];
    if (num < 10) putchar('0');
    itoa(num, s);
    puts(s);
}
