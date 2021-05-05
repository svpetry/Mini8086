#include "../../Lib/types.h"

enum processstate {
    ps_new,
    ps_running,
    ps_finished,
    ps_idle
};

struct processinfo {
    word id;
    enum processstate state;
    word size; // size in units (16 bytes)
    struct processinfo __far *next;
    word sp_save;
    word ss_save;
    byte priority;
};

typedef struct processinfo processinfo;

void start_scheduler();