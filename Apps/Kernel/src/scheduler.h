#ifndef SCHEDULER_H
#define SCHEDULER_H

#include "../../Lib/types.h"
#include "../../Lib/kernel_defs.h"

typedef struct {
    char id[2];
    byte size;
    byte crc8;
    PROC_TYPE proc_type;
    byte priority;
    byte unused[10];
} fileheader;

extern volatile word sp_save;
extern int process_count;
extern processinfo __far *processes[];

/* start the scheduler */
void start_scheduler(const char *command_name);

/* run new process */
SRESULT new_process(const char *filename, const char *params, int *pid, PROC_TYPE *ptype);

/* terminate process */
byte terminate_process(int pid);

#endif
