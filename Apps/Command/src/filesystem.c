#include "filesystem.h"
#include "cmdline.h"
#include "../../Lib/bios_fs.h"
#include "../../Lib/bios_screen.h"
#include "../../Lib/strutils.h"

#define FILENAME_LEN 16

char current_path[MAX_PATH];

static void put2digits(byte num) {
    char s[4];
    if (num < 10) putchar('0');
    itoa(num, s);
    puts(s);
}

byte handle_file_param(char *filepath, byte index, dword *size, byte checkexist) {
    if (paramcount < index + 1) {
        puts("No file name given.\n");
        return 1;
    }
    
    strcpy(filepath, current_path);
    strcat(filepath, "\\");
    strcat(filepath, params[index]);

    if (checkexist && fs_filesize(filepath, size) || size == 0) {
          puts("File not found or read error.\n");
          return 1;
    }
    return 0;
}

byte handle_dir_param(char *path, byte checkexist) {
    if (paramcount < 2) {
        puts("No directory name given.\n");
        return 1;
    }
    char *folder_name = params[1];
    strtoupper(folder_name);

    strcpy(path, current_path);
    strcat(path, "\\");
    strcat(path, folder_name);

    if (checkexist) {
        byte attrib;
        if (fs_fileattrib(path, &attrib) || (attrib & AM_DIR) == 0) {
            puts("Directory not found.\n");
            return 1;
        }
    }
    return 0;
}

void list_directory() {
    int i;
    char s[32];

    char volname[FILENAME_LEN];
    if (fs_volname(volname)) {
        puts("Drive error!\n");
        return;
    }

    // print volume name
    putchar('\n');
    putchar(' ');
    puts(volname);
    putchar('\n');
    for (i = 0; i < 48; i++) putchar('-');
    putchar('\n');
    if (!strempty(current_path)) puts(" ..\n");

    byte handle;
    if (fs_opendir(current_path, &handle)) {
        puts("Error opening directory!\n");
        return;
    }

    char filename[FILENAME_LEN];
    char path[MAX_PATH];
    do {
        if (fs_read_entry(handle, filename)) {
            puts("Error!\n");
            return;
        } else if (filename[0] != 0) {
            // print file name
            putchar(' ');
            rtrim(filename, 14, ' ');
            puts(filename);

            // print file size (or <DIR> for directories)
            strcpy(path, current_path);
            strcat(path, "\\");
            strcat(path, filename);
            dword size;
            byte year, month, day, hour, minute, second, attrib;
            if (!fs_fileinfo(path, &size, &year, &month, &day, &hour, &minute, &second, &attrib)) {
                char sizestr[10];
                if ((attrib & AM_DIR) > 0) {
                    strcpy(sizestr, "<DIR>");
                } else {
                    size >>= 10;
                    sizestr[0] = 0;
                    if (size > 999999) {
                        strcpy(sizestr, ">= 1 G");
                    } else {
                        if (size > 999) {
                            itoa(size / 1000, sizestr);
                            strcat(sizestr, ".");
                        }
                        itoa(size % 1000, s);
                        if (size > 999) ltrim(s, 3, '0');
                        strcat(sizestr, s);
                        strcat(sizestr, " K");
                    }
                }
                ltrim(sizestr, 10, ' ');
                puts(sizestr);
                puts("   ");

                // print file timestamp
                word trueyear = 1980 + year;
                itoa(trueyear, s);
                puts(s);
                putchar('-');
                put2digits(month);
                putchar('-');
                put2digits(day);
                putchar(' ');
                put2digits(hour);
                putchar(':');
                put2digits(minute);
                putchar(':');
                put2digits(second);
            }
            putchar('\n');
        }
    } while (!strempty(filename));

    fs_closedir(handle);
    for (i = 0; i < 48; i++) putchar('-');
    putchar('\n');
}

void rename() {
    char filepath_old[MAX_PATH];
    char filepath_new[MAX_PATH];
    dword size;
    if (handle_file_param(filepath_old, 1, &size, TRUE)) return;
    if (handle_file_param(filepath_new, 2, &size, FALSE)) return;
    if (fs_rename(filepath_old, filepath_new)) puts("Error: Could not rename file.\n");
}

void delete() {
    char filepath[MAX_PATH];
    dword size;
    if (handle_file_param(filepath, 1, &size, TRUE)) return;
    if (fs_delete(filepath)) puts("Error: Could not delete file.\n");
}

void change_directory() {
    if (paramcount < 2) {
        puts("No directory name given.\n");
        return;
    }
    char *folder_name = params[1];
    strtoupper(folder_name);

    if (!strcmp(folder_name, ".")) return;
    if (!strcmp(folder_name, "..")) {
        int i = strlen(current_path);
        while (i > 0) {
            i--;
            if (current_path[i] == '\\') {
                current_path[i] = 0;
                return;
            }
        }
        puts("Directory not found.\n");
        return;
    }

    char path[MAX_PATH];
    strcpy(path, current_path);
    strcat(path, "\\");
    strcat(path, folder_name);

    byte attrib;
    if (fs_fileattrib(path, &attrib) || (attrib & AM_DIR) == 0) {
        puts("Directory not found.\n");
        return;
    }

    strcpy(current_path, path);
}

void create_directory() {
    char path[MAX_PATH];
    if (handle_dir_param(path, FALSE)) return;
    if (fs_createdir(path)) puts("Error: Could not create directory.\n");
}

void remove_directory() {
    char path[MAX_PATH];
    if (handle_dir_param(path, TRUE)) return;
    if (fs_delete(path)) puts("Error: Could not delete directory.\n");
}