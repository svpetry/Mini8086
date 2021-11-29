#include "utils.h"
#include "../../Lib/types.h"

byte iswhite(char c) {
	return c == ' ' || c == '\t' || c == '\r';
}

byte isletter(char c) {
	return (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z');
}

byte isnum(char c) {
	return (c >= '0' && c <= '9') || c == '.';
}

void strcpy_near_to_far(char __far *dest, const char *src) {
    char __far *temp = dest;
    while (*dest++ = *src++) ;
}
