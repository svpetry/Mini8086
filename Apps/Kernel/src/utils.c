#include "utils.h"
#include "../../Lib/bios_screen.h"

void error(const char *msg) {
    putstr("KERNEL: ");
    putstr(msg);
    putch('\n');
}

void file_error(const char *filename, const char *msg) {
    putstr("KERNEL: ");
    putstr(filename);
    putch(' ');
    putstr(msg);
    putch('\n');
}

