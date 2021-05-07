#include "bios_fs.h"
#include "utils.h"

byte fs_volname(char *s) {
    byte status;
    asm(
        "pushw %%ds\n"
        "popw %%dx\n"
        "movw %1, %%cx\n"
        "movb $0x20, %%ah\n"
        "int $0x10\n"
        "movb %%al, %0"
        : "=g" (status)
        : "g" (s)
        : "ax", "cx", "dx", "si", "di"
    );
    return status;
}

byte fs_open(const char *filename, byte *handle) {

}

byte fs_close(byte handle) {

}

byte fs_fileinfo(const char *filename, dword *size,
    byte *year, byte *month, byte *day, 
    byte *hour, byte *minute, byte *second) {

}

byte fs_seek(byte handle, dword pos) {

}

byte fs_rename(const char *oldname, const char *newname) {

}

byte fs_read(byte handle, byte *buffer, dword count) {

}

byte fs_write(byte handle, byte *buffer, dword count) {

}

byte fs_opendir(byte *handle) {

}

byte fs_read_entry(byte handle, char *s) {

}

byte fs_closedir(byte handle) {

}

byte fs_createdir(const char *dirname) {
    
}
