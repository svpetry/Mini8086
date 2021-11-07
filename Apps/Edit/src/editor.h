#ifndef EDITOR_H
#define EDITOR_H

#include "../../Lib/types.h"

#define MAX_LINE_LENGTH 120
#define LINE_HEADER_SIZE 9
#define NEW_LINE_SIZE 20

struct line_header {
	struct line_header __far *next;
	struct line_header __far *prev;
	byte size;
	char line[MAX_LINE_LENGTH + 1];
};

void init_editor();
void start_editor();

#endif
