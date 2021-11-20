#include "file_buffer.h"
#include "bios_fs.h"

#define BUFFER_SIZE 512

static byte buffer[BUFFER_SIZE];
static int bufptr;
static dword remaining;
static byte current_handle;

static void read_next_block() {
    if (remaining == 0) return;
    if (remaining < BUFFER_SIZE)
        fs_read(current_handle, buffer, remaining);
    else
        fs_read(current_handle, buffer, BUFFER_SIZE);
    bufptr = 0;
}

byte fs_open_buffered(const char *path, byte *handle, dword *size) {
    if (fs_filesize(path, &remaining)) return TRUE;
    if (fs_open(path, &current_handle, MODE_READ)) return TRUE;
    
    *size = remaining;
    *handle = current_handle;
    read_next_block();
}

byte fs_read_buffered(byte handle) {
    if (remaining == 0) return 0;
    byte value = buffer[bufptr++];
    remaining--;
    if (bufptr == BUFFER_SIZE) read_next_block();
    return value;
}
