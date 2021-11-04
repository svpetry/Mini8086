#ifndef BIOS_FS_H
#define BIOS_FS_H

#include "types.h"
#include "biosdefs.h"

#define MAX_PATH 80

/* File attribute bits for directory entry */
#define	AM_RDO	0x01	/* Read only */
#define	AM_HID	0x02	/* Hidden */
#define	AM_SYS	0x04	/* System */
#define AM_DIR	0x10	/* Directory */
#define AM_ARC	0x20	/* Archive */

/* File access mode and open method flags */
#define	FA_READ				0x01
#define	FA_WRITE			0x02
#define	FA_OPEN_EXISTING	0x00
#define	FA_CREATE_NEW		0x04
#define	FA_CREATE_ALWAYS	0x08
#define	FA_OPEN_ALWAYS		0x10
#define	FA_OPEN_APPEND		0x30

/* get volume name */
byte fs_volname(char *s);

/* open file */
byte fs_open(const char *path, byte *handle, byte mode);

/* close file */
byte fs_close(byte handle);

/* get file/directory information */
byte fs_fileinfo(const char *path, dword *size,
    byte *year, byte *month, byte *day, byte *hour, byte *minute, byte *second,
    byte *attrib);

/* get file/directory attributes */
byte fs_fileattrib(const char *path, byte *attrib);

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
byte fs_createdir(const char *path);

/* delete file or directory */
byte fs_delete(const char *path);

#endif
