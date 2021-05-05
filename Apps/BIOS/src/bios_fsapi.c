#include "bios_fsapi.h"
#include "sd.h"
#include "ff.h"
#include "bios_api.h"

#define MAX_HANDLES 10

// static FATFS fs;
// static FIL file_handles[MAX_HANDLES];
// static DIR dir_handles[MAX_HANDLES];

static byte mounted;

void initialize_filesys() {
    // for (byte i = 0; i < MAX_HANDLES; i++) {
    //     file_handles[i].obj.fs = NULL;
    //     dir_handles[i].obj.fs = NULL;
    // }
    mounted = 0;
}

void fsapi_unmount() {
    if (mounted) {
        f_unmount("");
        mounted = 0;
    }
}

static void mount_if_needed() {
    // if (mounted) return;
    // f_mount(&fs, "", 0);
    // mounted = 1;
}

void handle_filesys(byte code) {
    int_ax = 0;
    if (!sd_inserted()) {
        int_ax = 0x0100; // error
        return;
    }

    mount_if_needed();

    switch (code) {

        // read volume name
        case 0x20: {
            char s[12];
            dword sn;
            dword addr = (((dword)int_dx) << 16) + int_cx;
            char __far *dest = (char __far *)addr;
            f_getlabel("", s, &sn);
            for (byte i = 0; i < 12 && s[i]; i++, dest++)
                *dest = s[i];
            *dest = 0;
            break;
        }
    }
}
