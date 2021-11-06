#ifndef SCHEDULER_H
#define SCHEDULER_H

#include "../../Lib/types.h"
#include "../../Lib/kernel_defs.h"

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
