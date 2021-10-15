#include "misc.h"
#include "../../Lib/bios_screen.h"

void show_help() {
    puts(
        "\n"
        "CLS      Clear screen\n"
        "VER      Show version information\n"
        "HELP     Show help\n"
        "DIR      List directory content\n"
        "REN      Rename file\n"
        "DEL      Delete file\n"
        "CD       Change directory\n"
        "TIME     Show/set time\n"
        "DATE     Show/set date\n"
        "REBOOT   Reboot system\n"
        "PS       Show processes\n"
        "KILL     Kill process\n"
        "TYPE     Display file contents\n"
        "SHOWPIC  Show picture\n"
    );
}