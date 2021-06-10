#ifndef CMDLINE_H
#define CMDLINE_H

#include "cmd_defs.h"

extern char last_cmdbuf[CMDLINE_MAXLEN];
extern char cmdbuf[CMDLINE_MAXLEN];

void read_cmdline();

#endif
