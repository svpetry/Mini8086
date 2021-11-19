#ifndef FILE_BUFFER_H
#define FILE_BUFFER_H

#include "types.h"

/* open file */
byte fs_open_buffered(const char *path, byte *handle, dword *size);

/* read byte from file */
byte fs_read_buffered(byte handle);

#endif
