#include "cmdline.h"
#include "cmd_defs.h"
#include "../../Lib/bios_misc.h"
#include "../../Lib/bios_screen.h"
#include "../../Lib/kernel.h"
#include "../../Lib/utils.h"
#include "../../Lib/strutils.h"

char last_cmdbuf[CMDLINE_MAXLEN + 1];
char cmdbuf[CMDLINE_MAXLEN + 1];
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

	last_cmdbuf[0] = 0;
	putchar('\n');
    puts(cmd_prompt);

	enable_cursor(1);
	int pos = 0;
    char c;
    do {
        do {
			c = getchar();
		} while (!c);
		if (c >= 32 && pos < CMDLINE_MAXLEN) {
			putchar(c);
			cmdbuf[pos++] = c;
		} else if (c == 0x08 && pos > 0) { // backspace
			putchar(c);
			pos--;
		} else if (c == 0x02) { // cursor up
			while (pos > 0) {
				putchar(0x08); // backspace
				pos--;
			}
			strcpy(cmdbuf, last_cmdbuf);
			puts(cmdbuf);
			pos = strlen(cmdbuf);
		}
    } while (c != '\n');
	enable_cursor(0);

	cmdbuf[pos] = 0x00;
	strcpy(last_cmdbuf, cmdbuf);
	strtolower(cmdbuf);
	splitparams();

    putchar('\n');
}
