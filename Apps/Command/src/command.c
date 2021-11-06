#include "../../Lib/strutils.h"
#include "../../Lib/bios_screen.h"
#include "../../Lib/bios_misc.h"
#include "../../Lib/bios_fs.h"
#include "../../Lib/kernel.h"
#include "../../Lib/lowlevel.h"
#include "../../Lib/colors.h"
#include "cmd_defs.h"
#include "cmdline.h"
#include "misc.h"
#include "time.h"
#include "filesystem.h"
#include "kernel.h"
#include "applauncher.h"

char *cmd_version = "Mini8086 command shell " CMD_VER "\n";

void init() {
	// asm volatile ("movw $0x1234, %%ax" : : : "ax");

    set_bgcolor(BLACK);
    set_textcolor(LIGHT_GRAY);
    clrscr();
    puts(cmd_version);
    current_path[0] = 0;
    last_cmdbuf[0] = 0;
}

void process_command() {
    putchar('\n');

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
        list_directory();
        
    // REN
    } else if (!strcmp(params[0], "ren")) {
        rename();

    // DEL
    } else if (!strcmp(params[0], "del")) {
        delete();

    // CD
    } else if (!strcmp(params[0], "cd")) {
        change_directory();

    // MD
    } else if (!strcmp(params[0], "md")) {
        create_directory();

    // RD
    } else if (!strcmp(params[0], "rd")) {
        remove_directory();

    // TIME
    } else if (!strcmp(params[0], "time")) {
        getset_time();

    // DATE
    } else if (!strcmp(params[0], "date")) {
        getset_date();

    // REBOOT
    } else if (!strcmp(params[0], "reboot")) {
        reboot();

    // PS
    } else if (!strcmp(params[0], "ps")) {
        handle_ps();

    // TERMINATE
    } else if (!strcmp(params[0], "terminate")) {
        handle_terminate();

    // TYPE
    } else if (!strcmp(params[0], "type")) {
        print_file_contents();

    // SHOWPIC
    } else if (!strcmp(params[0], "showpic")) {
        showpic();

    // PALETTE
    } else if (!strcmp(params[0], "palette")) {
        show_palette();

    } else {
        launch_application();
    }
}

void start() {
    while (1) {
        putchar('\n');
        read_cmdline();
        if (paramcount > 0)
            process_command();
    }
}

int main() {
    init();
    start();
}