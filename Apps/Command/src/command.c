#include "../../Lib/strutils.h"
#include "../../Lib/bios_screen.h"
#include "../../Lib/bios_misc.h"
#include "../../Lib/bios_fs.h"
#include "../../Lib/kernel.h"

int main() {
    char s[8];
    for (int i = 0; i < 100; i++) {
        putstr("Hello from command - ");
        itoa(i, s);
        putstr(s);
        putch('\n');
        sleep(500);
    }
}