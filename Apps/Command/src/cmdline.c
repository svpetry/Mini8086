#include "cmdline.h"
#include "cmd_defs.h"
#include "../../Lib/bios_misc.h"
#include "../../Lib/bios_screen.h"
#include "../../Lib/kernel.h"
#include "../../Lib/utils.h"

char last_cmdbuf[CMDLINE_MAXLEN];
char cmdbuf[CMDLINE_MAXLEN];
char *params[MAX_PARAMS];
byte paramcount;

void splitparams() {
	char *p;

	p = cmdbuf;

	while (*p == ' ')
		p++;

	if (*p) {
		params[0] = p;
		paramcount = 1;

		while (*p) {
			if (*p == ' ' || !*p) {
				*(p++) = 0;
				while (*p == ' ')
					p++;
				if (*p) {
					if (paramcount < MAX_PARAMS) {
						params[paramcount] = p;
						paramcount++;
					} else
						break;
				}
			} else
				p++;
		}
	} else
    	paramcount = 0;
}

void read_cmdline() {
	const char *wrong_parameter_count = "Wrong parameter count!";
	const char *cmd_prompt = "CMD>";

	memset(cmdbuf, 0, CMDLINE_MAXLEN);
	last_cmdbuf[0] = 0;
    puts(cmd_prompt);

    byte last_ticks = get_ticks();
    byte tick_count;
    char c;
    do {
        c = getchar();
        if (!c) {
            sleep(40);
        }
        
    } while (!c);

    putchar('\n');
}
