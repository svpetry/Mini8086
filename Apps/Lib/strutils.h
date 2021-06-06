#ifndef STRUTILS_H
#define STRUTILS_H

/* returs the length of a string */
int strlen(char *s);

/* copies a string */
char *strcpy(char *dest, const char *src);

/* appends a string */
char *strcat(char *dest, const char *src);

/* enhances a string to length n by adding characters c to the left side */
void *ltrim(char *s, int n, char c);

/* reverses a string */
void reverse(char s[]);

/* compares two strings, returns 0 if both are equal */
int strncmp(const char *s1, const char *s2, int n);

/* converts an integer to a string */
void itoa(int n, char s[]);

/* converts an integer to a hex string */
void itohex(int n, char s[]);

/* converts a long integer to a string */
void ltoa(long i, char* buf);

#endif
