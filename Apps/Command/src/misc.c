#include "misc.h"
#include "cmdline.h"
#include "filesystem.h"
#include "../../Lib/strutils.h"
#include "../../Lib/bios_screen.h"
#include "../../Lib/bios_fs.h"
#include "../../Lib/bios_misc.h"
#include "../../Lib/utils.h"
#include "../../Lib/kernel.h"
#include "../../Lib/lowlevel.h"
#include "../../Lib/colors.h"

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
        "PALETTE    Show color palette\n"
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

        while (!getchar()) sleep(0);
        outp(0x50, 0b00000000);
        clrscr();

    } else if (size == 128000) {
        outp(0x50, 0b00000010); // 320 x 400 x 256

    } else
        puts("Cannot determine image resolution.\n");
}

static void draw_col_bar(char *name, byte color) {
    char col_bar[21];
    strcpy(col_bar, name);
    char *s = col_bar;
    while (*s) {
        *s = *s + 128;
        s++;
    }
    rtrim(col_bar, 20, ' ' + 128);
    set_textcolor(color);
    puts(col_bar);
    putchar('\n');
}

static void show_col_blocks(byte blue) {
    for (byte green = 0; green < 8; green++) {
        puts("   ");
        for (byte red = 0; red < 8; red++) {
            byte col = red + (green << 3) + (blue << 6);
            set_textcolor(col);
            putchar(' ' + 128);
            putchar(' ' + 128);
        }
        for (byte red = 0; red < 8; red++) {
            byte col = red + (green << 3) + ((blue + 1) << 6);
            set_textcolor(col);
            putchar(' ' + 128);
            putchar(' ' + 128);
        }
        putchar('\n');
    }
}

void show_palette() {
    
    putchar('\n');
    show_col_blocks(0);
    show_col_blocks(2);

    while (!getchar()) sleep(0);

    putchar('\n');
    draw_col_bar("DARK_RED", DARK_RED);
    draw_col_bar("RED", RED);
    draw_col_bar("LIGHT_RED", LIGHT_RED);
    draw_col_bar("DARK_GREEN", DARK_GREEN);
    draw_col_bar("GREEN", GREEN);
    draw_col_bar("LIGHT_GREEN", LIGHT_GREEN);
    draw_col_bar("DARK_BLUE", DARK_BLUE);
    draw_col_bar("BLUE", BLUE);
    draw_col_bar("LIGHT_BLUE", LIGHT_BLUE);
    draw_col_bar("DARK_YELLOW", DARK_YELLOW);
    draw_col_bar("YELLOW", YELLOW);
    draw_col_bar("LIGHT_YELLOW", LIGHT_YELLOW);
    draw_col_bar("DARK_MAGENTA", DARK_MAGENTA);
    draw_col_bar("MAGENTA", MAGENTA);
    draw_col_bar("LIGHT_MAGENTA", LIGHT_MAGENTA);
    draw_col_bar("DARK_CYAN", DARK_CYAN);
    draw_col_bar("CYAN", CYAN);
    draw_col_bar("LIGHT_CYAN", LIGHT_CYAN);
    draw_col_bar("DARK_GRAY", DARK_GRAY);
    draw_col_bar("LIGHT_GRAY", LIGHT_GRAY);
    draw_col_bar("WHITE", WHITE);
    putchar('\n');
}
