#ifndef STRUTILS_FAR_H
#define STRUTILS_FAR_H

#include "types.h"

/* returns 0 if the string is empty */
int strempty_far(const char __far *s);

/* return the length of a string */
int strlen_far(const char __far *s);

/* copy a string */
char __far *strcpy_far(char __far *dest, const char __far *src);

/* append a string */
char __far *strcat_far(char __far *dest, const char __far *src);

/* compare two strings, returns 0 if both are equal */
int strcmp_far(const char __far *s1, const char __far *s2);

#endif
