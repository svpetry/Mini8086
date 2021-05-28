#include "../../Lib/types.h"

enum processstate {
    ps_new,
    ps_running,
    ps_finished,
    ps_idle
};

struct processinfo {
    word id;
    char name[9];
    enum processstate state;
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
    byte unused[13];
} fileheader;

void start_scheduler();
