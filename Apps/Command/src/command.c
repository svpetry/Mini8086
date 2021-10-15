#include "../../Lib/strutils.h"
#include "../../Lib/bios_screen.h"
#include "../../Lib/bios_misc.h"
#include "../../Lib/bios_fs.h"
#include "../../Lib/kernel.h"
#include "cmd_defs.h"
#include "cmdline.h"
#include "misc.h"
#include "time.h"
#include "directory.h"

char *cmd_version = "Mini8086 command shell " CMD_VER "\n\n";

void init() {
    clrscr();
    puts(cmd_version);
}

void process_command() {
    // CLS
    if (!strcmp(params[0], "cls")) {
        clrscr();
    
    // VER
    } else if (!strcmp(params[0], "ver")) {
        putchar('\n');
        puts(cmd_version);

    // HELP
    } else if (!strcmp(params[0], "help")) {
        show_help();

    // DIR
    } else if (!strcmp(params[0], "dir")) {

    // REN
    } else if (!strcmp(params[0], "ren")) {

    // DEL
    } else if (!strcmp(params[0], "del")) {

    // CD
    } else if (!strcmp(params[0], "cd")) {

    // TIME
    } else if (!strcmp(params[0], "time")) {

    // DATE
    } else if (!strcmp(params[0], "date")) {

    // REBOOT
    } else if (!strcmp(params[0], "reboot")) {

    // PS
    } else if (!strcmp(params[0], "ps")) {

    // KILL
    } else if (!strcmp(params[0], "kill")) {

    // TYPE
    } else if (!strcmp(params[0], "type")) {

    // SHOWPIC
    } else if (!strcmp(params[0], "showpic")) {

    } else {

    }
}

void start() {
    while (1) {
        read_cmdline();
        if (paramcount > 0)
            process_command();
    }
}

int main() {
    puts("Hello.\n");
    while (1) ;
    
    init();
    start();
}