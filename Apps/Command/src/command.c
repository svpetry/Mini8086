#include "../../Lib/strutils.h"
#include "../../Lib/bios_screen.h"
#include "../../Lib/bios_misc.h"
#include "../../Lib/bios_fs.h"
#include "../../Lib/kernel.h"
#include "cmd_defs.h"
#include "cmdline.h"

void init() {
    clrscr();
    
    puts("Mini8086 command shell " CMD_VER "\n\n");
}

void start() {
    while (1) {
        read_cmdline(command, params);


    }
}

int main() {
    init();
    start();
}