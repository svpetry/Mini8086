#ifndef LIB_KERNEL_H
#define LIB_KERNEL_H

#include "types.h"
#include "kernel_defs.h"

/* allocate memory */
void __far *k_malloc(dword size);

/* free memory */
void k_free(void __far *ptr);

/* check free memory */
dword k_check_free_memory();

/* start a process */
SRESULT start_process(char *path, char *params, word *pid, byte *process_kind);

/* wait for a given number of milliseconds */
void sleep(word milliseconds);

/* kill a process */
byte terminate_process(int process_id);

/* check if process exists */
byte check_process(int process_id);

/* list process */
void list_process(proc_info_ext *proc_info, byte first);

#endif
