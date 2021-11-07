#include "strutils_far.h"

int strempty_far(const char __far *s) {
	return s[0] == 0;
}

int strlen_far(const char __far *str) {
    const char __far *s;
    for (s = str; *s; ++s) ;
    return s - str;
}

char __far *strcpy_far(char __far *dest, const char __far *src) {
    char __far *temp = dest;
    while (*dest++ = *src++) ;
    return temp;
}

char __far *strcat_far(char __far *dest, const char __far *src) {
    int i, j;
    for (i = 0; dest[i] != '\0'; i++) ;
    for (j = 0; src[j] != '\0'; j++)
        dest[i + j] = src[j];
    dest[i + j] = '\0';
    return dest;
}

int strcmp_far(const char __far *s1, const char __far *s2) {
    while (*s1 && (*s1 == *s2)) {
        s1++;
        s2++;
    }
    return *(const unsigned char*)s1 - *(const unsigned char*)s2;
}
