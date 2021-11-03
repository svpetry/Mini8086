#include "kernel.h"
#include "../../Lib/types.h"
#include "../../Lib/kernel.h"
#include "../../Lib/strutils.h"
#include "../../Lib/bios_screen.h"
#include "../../Lib/kernel_defs.h"
#include "cmdline.h"

void handle_ps() {
    int i;
    char s[16];
    
    putchar('\n');
    puts("    ID Name        Size   Priority\n");
    for (i = 0; i < 35; i++) putchar('-');
    putchar('\n');

    proc_info_ext procinfo;
    list_process(&procinfo, TRUE);
    while (procinfo.id > 0) {
        // process id
        putchar(' ');
        itoa(procinfo.id, s);
        ltrim(s, 6 - strlen(s), ' ');
        puts(s);

        // process name
        putchar(' ');
        strcpy(s, procinfo.name);
        rtrim(s, 10, ' ');
        puts(s);

        // memory size
        int size_k = procinfo.size >> 10;
        itoa(size_k, s);
        ltrim(s, 4, ' ');
        puts(s);
        puts(" K   ");

        // priority
        putchar('0' + procinfo.priority);
        putchar('\n');

        list_process(&procinfo, FALSE);
    }
    for (i = 0; i < 35; i++) putchar('-');
    putchar('\n');
}

void handle_terminate() {
    if (paramcount < 2) {
        puts("No process ID given.\n");
        return;
    }
    int pid = atoi(params[1]);
    if (terminate_process(pid)) {
        puts("Could not terminate process with ID ");
        puts(params[1]);
        puts("!\n");
    }
}
