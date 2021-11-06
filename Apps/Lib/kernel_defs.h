#ifndef KERNEL_DEFS_H
#define KERNEL_DEFS_H

#include "types.h"

struct proc_info_ext {
    word id;
    char name[10];
    dword size;
    byte priority;
};
typedef struct proc_info_ext proc_info_ext;

typedef enum {
    SR_OK = 0,
    SR_FILE_NOT_FOUND,
    SR_FILE_OPEN_ERROR,
    SR_NO_EXEC,
    SR_READ_ERROR,
    SR_CHECKSUM_ERROR,
    SR_REJECTED
} SRESULT;

typedef enum {
    PT_FOREGROUND = 0,
    PT_BACKGROUND
} PROC_TYPE;

typedef enum {
    PS_NEW = 0,
    PS_RUNNING,
    PS_FINISHED,
    PS_IDLE,
    PS_TERMINATE    
} PSTATE;

struct processinfo {
    word id;
    char name[9];
    char params[64];
    PSTATE state;
    word size; // size in units (16 bytes)
    word sp_save;
    word ss_save;
    byte priority;
    struct processinfo __far *next;
    struct processinfo __far *prev;
};
typedef struct processinfo processinfo;

#endif
