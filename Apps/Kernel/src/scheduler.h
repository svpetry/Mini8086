#ifndef SCHEDULER_H
#define SCHEDULER_H

#include "../../Lib/types.h"

typedef enum {
    PS_NEW = 0,
    PS_RUNNING,
    PS_FINISHED,
    PS_IDLE
} pstate;

struct processinfo {
    word id;
    char name[9];
    pstate state;
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
    byte proc_type;
    byte priority;
    byte unused[10];
} fileheader;

extern volatile word sp_save;
extern int process_count;
extern processinfo __far *processes[];


void start_scheduler(const char *command_name);

#endif
