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
void start_process(char *filename);

/* wait for a given number of milliseconds */
void sleep(word milliseconds);

/* kill a process */
void kill_process(int process_id);

/* list process */
void list_process(proc_info_ext *proc_info, byte first);

#endif
