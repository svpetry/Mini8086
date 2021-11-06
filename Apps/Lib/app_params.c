#include "app_params.h"
#include "kernel_defs.h"
#include "strutils.h"

int paramcount;
char *params[MAX_PARAMS];
char paramstr[PARAMS_MAXLEN];

static void strcpy_far_to_near(char *dest, const char __far *src) {
    char *temp = dest;
    while (*dest++ = *src++) ;
}

void init_params() {
    processinfo __far *pi;

    int header_offset = (sizeof(processinfo) + 15) / 16;
    word seg;
    asm volatile(
        "movw %%cs, %%ax\n"
        "movw %%ax, %0\n"
        : "=g" (seg)
        : /* no inputs */
        : "ax", "cc"
    );
    seg -= header_offset;
    pi = (processinfo __far *)((dword)seg << 16);

    strcpy_far_to_near(paramstr, pi->params);

    int i;
    for (i = 0; i < MAX_PARAMS; i++)
        params[i] = '\0';
    i = 0;
    char *p = paramstr;
    params[i++] = p;
    while (*p) {
        if (*p == ' ') {
            *p = '\0';
            p++;
            params[i++] = p;
        } else
            p++;
    }
    if (!params[i][0])
        i--;
    paramcount = i;
}
