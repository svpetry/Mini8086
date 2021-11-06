#ifndef APP_PARAMS_H
#define APP_PARAMS_H

#define MAX_PARAMS    6
#define PARAMS_MAXLEN 64

extern int paramcount;
extern char *params[MAX_PARAMS];

void init_params();

#endif