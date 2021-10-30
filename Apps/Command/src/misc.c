#include "misc.h"
#include "cmdline.h"
#include "filesystem.h"
#include "../../Lib/strutils.h"
#include "../../Lib/bios_screen.h"
#include "../../Lib/bios_fs.h"
#include "../../Lib/bios_misc.h"
#include "../../Lib/utils.h"
#include "../../Lib/lowlevel.h"

void show_help() {
    puts(
        "\n"
        "CLS        Clear screen\n"
        "VER        Show version information\n"
        "HELP       Show help\n"
        "DIR        List directory content\n"
        "REN        Rename file\n"
        "DEL        Delete file\n"
        "CD         Change directory\n"
        "MD         Create directory\n"
        "TIME       Show/set time\n"
        "DATE       Show/set date\n"
        "REBOOT     Reboot system\n"
        "PS         Show processes\n"
        "TERMINATE  Terminate process\n"
        "TYPE       Display file contents\n"
        "SHOWPIC    Show picture\n"
    );
}

void print_file_contents() {
    char filepath[MAX_PATH];
    dword size;
    if (handle_file_param(filepath, 1, &size, TRUE)) return;

    byte handle;
    if (fs_open(filepath, &handle, FA_READ | FA_OPEN_EXISTING)) {
        puts("Error opening file.\n");
        return;
    }

    while (size > 0 && getchar() != 0x1B) {
        word readlen = size > 256 ? 256 : size;
        char buffer[257];
        fs_read(handle, near_to_far(buffer), readlen);
        buffer[readlen] = 0;
        puts(buffer);
        size -= readlen;
    }

    fs_close(handle);
}

void showpic() {
    char filepath[MAX_PATH];
    dword size;
    if (handle_file_param(filepath, 1, &size, TRUE)) return;

    if (size == 64000) {
        outp(0x50, 0b00000001); // 320 x 200 x 256
        byte __far *screen = (void __far *)0xC0000000;
        byte handle;
        fs_open(filepath, &handle, FA_READ | FA_OPEN_EXISTING);
        fs_read(handle, screen, 64000);
        fs_close(handle);

        while (!getchar()) asm volatile ("nop");
        outp(0x50, 0b00000000);
        clrscr();

    } else if (size == 128000) {
        outp(0x50, 0b00000010); // 320 x 400 x 256

    } else
        puts("Cannot determine image resolution.\n");
}
