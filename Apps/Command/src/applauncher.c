#include "applauncher.h"
#include "filesystem.h"
#include "cmdline.h"
#include "../../Lib/strutils.h"
#include "../../Lib/bios_screen.h"
#include "../../Lib/kernel.h"

static void handle_error(SRESULT result) {
    switch (result) {
        case SR_FILE_OPEN_ERROR:
            puts("File open error!\n");
            break;
        case SR_NO_EXEC:
            puts("File not executable!\n");
            break;
        case SR_READ_ERROR:
            puts("Read error!\n");
            break;
        case SR_CHECKSUM_ERROR:
            puts("Checksum error!\n");
            break;
        default:
            puts("Unknown error!\n");
            break;
    }
}

void launch_application() {
    char filepath[MAX_PATH];
    strcpy(filepath, current_path);
    strcat(filepath, "\\");
    strcat(filepath, params[0]);
    dword size;
    if (fs_filesize(filepath, &size) || size == 0) {
        strcat(filepath, ".bin");
        if (fs_filesize(filepath, &size) || size == 0) {
            puts("Unknown command!\n");
            return;
        }
    }

    word pid;
    PROC_TYPE ptype;
    SRESULT result = start_process(filepath, &pid, &ptype);
    if (result == SR_OK) {
        if (ptype == PT_FOREGROUND) {
            do {
                sleep(100);
            } while (!check_process(pid));

            set_bgcolor(BLACK);
            set_textcolor(LIGHT_GRAY);
            clrscr();
        }
    } else 
        handle_error(result);
}
