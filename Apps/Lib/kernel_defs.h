#ifndef KERNEL_DEFS_H
#define KERNEL_DEFS_H

#include "types.h"

struct proc_info_ext {
    word id;
    char name[9];
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
    SR_CHECKSUM_ERROR
} SRESULT;

#endif
