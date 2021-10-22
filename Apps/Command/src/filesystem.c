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

byte handle_file_param(char *filepath, dword *size) {
    if (paramcount < 2) {
        puts("No file name given.\n");
        return 1;
    }
    
    strcpy(filepath, current_path);
    strcat(filepath, "\\");
    strcat(filepath, params[1]);

    if (fs_filesize(filepath, size)) {
          puts("File not found or read error.\n");
          return 1;
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

    putchar(' ');
    puts(volname);
    putchar('\n');
    for (i = 0; i < 48; i++) putchar('-');
    putchar('\n');

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
    } while (filename[0] != 0);

    fs_closedir(handle);
    for (i = 0; i < 48; i++) putchar('-');
    putchar('\n');
}

void rename() {

}

void delete() {

}

void change_directory() {

}
