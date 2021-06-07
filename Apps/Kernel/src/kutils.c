#include "kutils.h"
#include "../../Lib/bios_screen.h"

void error(const char *msg) {
    puts("KERNEL: ");
    puts(msg);
    putchar('\n');
}

void file_error(const char *filename, const char *msg) {
    puts("KERNEL: ");
    puts(filename);
    putchar(' ');
    puts(msg);
    putchar('\n');
}

