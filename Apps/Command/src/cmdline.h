#ifndef CMDLINE_H
#define CMDLINE_H

#include "cmd_defs.h"
#include "../../Lib/types.h"

extern char last_cmdbuf[CMDLINE_MAXLEN + 1];
extern char *params[MAX_PARAMS];
extern byte paramcount;

void read_cmdline();

#endif
