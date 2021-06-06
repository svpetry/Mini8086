#ifndef KERNEL_DEFS_H
#define KERNEL_DEFS_H

struct proc_info_ext {
    word id;
    char name[9];
    dword size;
    byte priority;
};

typedef struct proc_info_ext proc_info_ext;

#endif
