#include "types.h"
#include "biosdefs.h"

/* get volume name */
byte fs_volname(char *s);

/* open file */
byte fs_open(const char *path, byte *handle, byte mode);

/* close file */
byte fs_close(byte handle);

/* get file information */
// byte fs_fileinfo(const char *path, dword *size,
//     byte *year, byte *month, byte *day, byte *hour, byte *minute, byte *second);

/* get the file size */
byte fs_filesize(const char *path, dword *size);

/* seek file stream */
byte fs_seek(byte handle, dword pos);

/* rename file */
byte fs_rename(const char *oldname, const char *newname);

/* read data from file */
byte fs_read(byte handle, byte __far *buffer, word count);

/* write data to file */
byte fs_write(byte handle, byte __far *buffer, word count);

/* open directory */
byte fs_opendir(const char *path, byte *handle);

/* read next directory entry */
byte fs_read_entry(byte handle, char *s);

/* close directory */
byte fs_closedir(byte handle);

/* create directory */
byte fs_createdir(const char *dirname);
