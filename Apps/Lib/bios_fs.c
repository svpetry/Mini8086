#include "bios_fs.h"
#include "utils.h"

byte fs_volname(char *s) {
    byte status;
    asm volatile (
        "pushw %%cs\n"
        "popw %%dx\n"
        "movw %1, %%cx\n"
        "movb $0x20, %%ah\n"
        "int $0x10\n"
        "movb %%al, %0"
        : "=g" (status)
        : "g" (s)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
    return status;
}

byte fs_open(const char *path, byte *handle, byte mode) {
    byte status, h;
    asm volatile (
        "pushw %%cs\n"
        "popw %%dx\n"
        "movw %2, %%cx\n"
        "movb %3, %%al\n"
        "movb $0x21, %%ah\n"
        "int $0x10\n"
        "movb %%al, %0\n"
        "movb %%ah, %1\n"
        : "=g" (status), "=g" (h)
        : "g" (path), "g" (mode)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
    *handle = h;
    return status;
}

byte fs_close(byte handle) {
    byte status;
    asm volatile (
        "movb %1, %%al\n"
        "movb $0x22, %%ah\n"
        "int $0x10\n"
        "movb %%al, %0\n"
        : "=g" (status)
        : "g" (handle)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
    return status;
}
/*
byte fs_fileinfo(const char *path, dword *size,
    byte *year, byte *month, byte *day, 
    byte *hour, byte *minute, byte *second) {
    
    byte status;
    word date, time;
    word sizel, sizeh;
    asm volatile (
        "pushw %%cs\n"
        "popw %%dx\n"
        "movw %5, %%cx\n"
        "movb $0x23, %%ah\n"
        "int $0x10\n"
        "movb %%al, %0\n"
        "movw %%dx, %1\n"
        "movw %%cx, %2\n"
        "movw %%si, %3\n"
        "movw %%di, %4\n"
        : "=g" (status), "=g" (sizeh), "=g" (sizel), "=g" (date), "=g" (time)
        : "g" (path)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
    *size = (((dword)sizeh) << 16) + sizel;
    *year = date >> 9;
    *month = (date >> 5) & 0x0F;
    *day = date & 0x1F;
    *hour = time >> 11;
    *minute = (time >> 5) & 0x3F;
    *second = (time & 0x1F) << 1;
    return status;
}
*/
byte fs_filesize(const char *path, dword *size) {
    byte status;
    word sizel, sizeh;
    asm volatile (
        // "movw $0x1234, %%dx\n"
        "pushw %%cs\n"
        "popw %%dx\n"
        "movw %3, %%cx\n"
        "movb $0x23, %%ah\n"
        "int $0x10\n"
        "movb %%al, %0\n"
        "movw %%dx, %1\n"
        "movw %%cx, %2\n"
        : "=g" (status),"=g" (sizeh), "=g" (sizel)
        : "g" (path)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
    *size = (((dword)sizeh) << 16) + sizel;
    return status;
}

byte fs_seek(byte handle, dword pos) {
    byte status;
    asm volatile (
        "movb %1, %%al\n"
        "movw %2, %%dx\n"
        "movw %3, %%cx\n"
        "movb $0x24, %%ah\n"
        "int $0x10\n"
        "movb %%al, %0\n"
        : "=g" (status)
        : "g" (handle), "g" ((word)(pos >> 16)), "g" ((word)(pos & 0xFFFF))
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
    return status;
}

byte fs_rename(const char *oldname, const char *newname) {

}

byte fs_read(byte handle, byte __far *buffer, word count) {
    byte status;
    volatile word bufh = (word)((dword)buffer >> 16);
    volatile word bufl = (word)((dword)buffer & 0xFFFF);
    asm volatile (
        "movb %1, %%al\n"
        "movw %2, %%dx\n"
        "movw %3, %%cx\n"
        "movw %4, %%si\n"
        "movb $0x26, %%ah\n"
        "int $0x10\n"
        "movb %%al, %0\n"
        : "=g" (status)
        : "g" (handle), "g" (bufh), "g" (bufl), "g" (count)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
    return status;
}

byte fs_write(byte handle, byte __far *buffer, word count) {
    byte status;
    volatile word bufh = (word)((dword)buffer >> 16);
    volatile word bufl = (word)((dword)buffer & 0xFFFF);
    asm volatile (
        "movb %1, %%al\n"
        "movw %2, %%dx\n"
        "movw %3, %%cx\n"
        "movw %4, %%si\n"
        "movb $0x27, %%ah\n"
        "int $0x10\n"
        "movb %%al, %0\n"
        : "=g" (status)
        : "g" (handle), "g" (bufh), "g" (bufl), "g" (count)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
    return status;
}

byte fs_opendir(const char *path, byte *handle) {
    byte status, h;
    asm volatile (
        "pushw %%cs\n"
        "popw %%dx\n"
        "movw %2, %%cx\n"
        "movb $0x28, %%ah\n"
        "int $0x10\n"
        "movb %%al, %0\n"
        "movb %%ah, %1\n"
        : "=g" (status), "=g" (h)
        : "g" (path)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
    *handle = h;
    return status;
}

byte fs_closedir(byte handle) {
    byte status;
    asm volatile (
        "movb %1, %%al\n"
        "movb $0x29, %%ah\n"
        "int $0x10\n"
        "movb %%al, %0\n"
        : "=g" (status)
        : "g" (handle)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
    return status;
}

byte fs_read_entry(byte handle, char *s) {
    byte status;
    asm volatile (
        "pushw %%cs\n"
        "popw %%dx\n"
        "movw %1, %%cx\n"
        "movb %2, %%al\n"
        "movb $0x2A, %%ah\n"
        "int $0x10\n"
        "movb %%al, %0\n"
        : "=g" (status)
        : "g" (s), "g" (handle)
        : "ax", "cx", "dx", "si", "di", "cc", "memory"
    );
    return status;
}

byte fs_createdir(const char *dirname) {
    
}
