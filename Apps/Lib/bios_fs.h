#include "types.h"

/* get volume name */
byte fs_volname(char *s);

/* open file */
byte fs_open(const char *filename, byte *handle);

/* close file */
byte fs_close(byte handle);

/* get file information */
byte fs_fileinfo(const char *filename, dword *size,
    byte *year, byte *month, byte *day, byte *hour, byte *minute, byte *second);

/* seek file stream */
byte fs_seek(byte handle, dword pos);

/* rename file */
byte fs_rename(const char *oldname, const char *newname);

/* read data from file */
byte fs_read(byte handle, byte *buffer, dword count);

/* write data to file */
byte fs_write(byte handle, byte *buffer, dword count);

/* open directory */
byte fs_opendir(byte *handle);

/* read next directory entry */
byte fs_read_entry(byte handle, char *s);

/* close directory */
byte fs_closedir(byte handle);

/* create directory */
byte fs_createdir(const char *dirname);
