#include "kutils.h"
#include "../../Lib/bios_screen.h"

void error(const char *msg) {
    puts("KERNEL: ");
    puts(msg);
    putchar('\n');
}
