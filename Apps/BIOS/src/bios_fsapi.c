#include "bios_fsapi.h"
#include "sd.h"
#include "ff.h"
#include "bios_api.h"
#include "../../Lib/screen.h"
#include "../../Lib/strutils.h"
#include "../../Lib/biosdefs.h"

#define MAX_HANDLES     5
#define MAX_FNAME_LEN   13
#define MAX_PATH_LEN    80

#define FAR_PTR_STR(seg, offs) (char __far *)(((dword)seg << 16) + offs)

static FATFS fs;
static FIL file_obj[MAX_HANDLES];
static DIR dir_obj[MAX_HANDLES];

static byte mounted;

static void far_to_near_str(word seg, word offs, char *dest, byte maxlen) {
    char __far *str = FAR_PTR_STR(seg, offs);
    while (--maxlen > 0 && *str)
        *(dest++) = *(str++);
    *dest = 0;
}

static void mount_if_needed() {
    if (mounted) return;
    f_mount(&fs, "", 0);
    mounted = 1;
}

static byte new_file_handle(byte *handle) {
    for (*handle = 0; *handle < MAX_HANDLES; *handle++) {
        if (file_obj[*handle].obj.fs == NULL) return 0;
    }
    return 1;
}

static byte new_dir_handle(byte *handle) {
    for (*handle = 0; *handle < MAX_HANDLES; *handle++) {
        if (dir_obj[*handle].obj.fs == NULL) return 0;
    }
    return 1;
}

void initialize_filesys() {
    for (byte i = 0; i < MAX_HANDLES; i++) {
        file_obj[i].obj.fs = NULL;
        dir_obj[i].obj.fs = NULL;
    }
    mounted = 0;
}

void fsapi_unmount() {
    if (mounted) {
        f_unmount("");
        mounted = 0;
    }
}

static void read_volname() {
    char s[MAX_FNAME_LEN];
    dword sn;
    char __far *dest = FAR_PTR_STR(int_dx, int_cx);
    if (f_getlabel("", s, &sn) != FR_OK) {
        *dest = 0;
        int_ax = 0x01;
        return;
    }
    for (byte i = 0; i < MAX_FNAME_LEN && s[i]; i++, dest++)
        *dest = s[i];
    *dest = 0;
    int_ax = 0x00;
    return;
}

static void open_file() {
    byte mode;
    switch (int_ax & 0xFF) {
        case MODE_READ:
            mode = FA_READ | FA_OPEN_EXISTING;
            break;
        case MODE_WRITE:
            mode = FA_WRITE | FA_CREATE_ALWAYS;
            break;
        case MODE_APPEND:
            mode = FA_WRITE | FA_OPEN_APPEND;
            break;
    }
    byte handle;
    if (new_file_handle(&handle)) {
        int_ax = 0x01;
        return;
    }
    FIL *fo = &file_obj[handle];

    char filepath[MAX_PATH_LEN];
    far_to_near_str(int_dx, int_cx, filepath, MAX_PATH_LEN);
    if (f_open(fo, filepath, mode) != FR_OK) {
        int_ax = 0x01;
        return;
    }
    int_ax = handle << 8;
}

static void close_file() {
    byte handle = int_ax & 0xFF;
    FIL *fo = &file_obj[handle];
    f_close(fo);
    fo->obj.fs = NULL;
}

static void file_info() {
    char filepath[MAX_PATH_LEN];
    far_to_near_str(int_dx, int_cx, filepath, MAX_PATH_LEN);
    FILINFO fi;

    FRESULT result = f_stat(filepath, &fi);
    if (result != FR_OK) {
        int_ax = 0x01;
        return;
    }
    int_ax = fi.fattrib << 8;
    int_dx = fi.fsize >> 16;
    int_cx = fi.fsize & 0xFFFF;
    int_si = fi.fdate;
    int_di = fi.ftime;
}

static void file_seek() {
    byte handle = int_ax & 0xFF;
    FIL *fo = &file_obj[handle];
    if (f_lseek(fo, (((dword)int_dx) << 16) + int_cx) != FR_OK) {
        int_ax = 0x01;
        return;
    }
    int_ax = 0x00;
    return;
}

static void file_rename() {
    char old_name[MAX_PATH_LEN];
    far_to_near_str(int_dx, int_cx, old_name, MAX_PATH_LEN);
    char new_name[MAX_PATH_LEN];
    far_to_near_str(int_si, int_di, new_name, MAX_PATH_LEN);
    if (f_rename(old_name, new_name) != FR_OK)
        int_ax = 0x01;
    else
        int_ax = 0x00;
}

static void file_read() {
    byte handle = int_ax & 0xFF;
    FIL *fo = &file_obj[handle];
    void __far *buffer = (void __far *)((((dword)int_dx) << 16) + int_cx);
    word bytes_read;
    if (f_read(fo, buffer, int_si, &bytes_read) != FR_OK) {
        int_ax = 0x01;
        return;
    }
    int_ax = 0x00;
    int_di = bytes_read;
}

static void file_write() {
    byte handle = int_ax & 0xFF;
    FIL *fo = &file_obj[handle];
    void __far *buffer = (void __far *)((((dword)int_dx) << 16) + int_cx);
    word bytes_written;
    if (f_write(fo, buffer, int_si, &bytes_written) != FR_OK) {
        int_ax = 0x01;
        return;
    }
    int_ax = 0x00;
    int_di = bytes_written;
}

static void open_dir() {
    byte handle;
    if (new_dir_handle(&handle)) {
        int_ax = 0x01;
        return;
    }
    DIR *dirobj = &dir_obj[handle];

    char path[MAX_PATH_LEN];
    far_to_near_str(int_dx, int_cx, path, MAX_PATH_LEN);
    if (f_opendir(dirobj, path) != FR_OK) {
        int_ax = 0x01;
        return;
    }
    int_ax = handle << 8;
}

static void close_dir() {
    byte handle = int_ax & 0xFF;
    DIR *dirobj = &dir_obj[handle];
    if (f_closedir(dirobj) != FR_OK) {
        int_ax = 0x01;
        return;
    }
    dirobj->obj.fs = NULL;
    int_ax = 0x00;
}

static void read_dir_entry() {
    byte handle = int_ax & 0xFF;
    DIR *dirobj = &dir_obj[handle];
    char __far *dest = FAR_PTR_STR(int_dx, int_cx);

    FILINFO fi;
    if (f_readdir(dirobj, &fi) != FR_OK) {
        *dest = 0;
        int_ax = 0x01;
        return;
    }
    for (byte i = 0; i < MAX_FNAME_LEN && fi.fname[i]; i++, dest++)
        *dest = fi.fname[i];
    *dest = 0;
    int_ax = 0x00;
}

static void create_dir() {
    char filepath[MAX_PATH_LEN];
    far_to_near_str(int_dx, int_cx, filepath, MAX_PATH_LEN);

    FRESULT result = f_mkdir(filepath);
    if (result != FR_OK) {
        int_ax = 0x01;
        return;
    }
    int_ax = 0x00;
}

static void delete_file() {
    char filepath[MAX_PATH_LEN];
    far_to_near_str(int_dx, int_cx, filepath, MAX_PATH_LEN);

    FRESULT result = f_unlink(filepath);
    if (result != FR_OK) {
        int_ax = 0x01;
        return;
    }
    int_ax = 0x00;
}

void handle_filesys(byte code) {
    FRESULT res;
    int_ax = 0;
    if (!sd_inserted()) {
        int_ax = 0x01; // error
        return;
    }

    mount_if_needed();

    switch (code) {

        // read volume name
        case 0x20:
            read_volname();
            break;

        // open file
        case 0x21:
            open_file();
            break;

        // close file
        case 0x22:
            close_file();
            break;

        // get file info
        case 0x23:
            file_info();
            break;

        // seek
        case 0x24:
            file_seek();
            break;

        // rename file
        case 0x25:
            file_rename();
            break;
        
        // read data
        case 0x26:
            file_read();
            break;

        // write data
        case 0x27:
            file_write();
            break;

        // open directory
        case 0x28:
            open_dir();
            break;
        
        // close directory
        case 0x29:
            close_dir();
            break;

        // read next directory entry
        case 0x2A:
            read_dir_entry();
            break;

        // create directory
        case 0x2B:
            create_dir();
            break;

        // delete file
        case 0x2C:
            delete_file();
            break;

    }
}
