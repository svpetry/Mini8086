#ifndef STRUTILS_H
#define STRUTILS_H

/* return the length of a string */
int strlen(char *s);

/* copy a string */
char *strcpy(char *dest, const char *src);

/* append a string */
char *strcat(char *dest, const char *src);

/* enhance a string to length n by adding characters c to the left side */
void *ltrim(char *s, int n, char c);

/* reverse a string */
void reverse(char s[]);

/* compare two strings, returns 0 if both are equal */
int strcmp(const char* s1, const char* s2);

/* compare two strings, returns 0 if both are equal */
int strncmp(const char *s1, const char *s2, int n);

/* convert an integer to a string */
void itoa(int n, char s[]);

/* convert an integer to a hex string */
void itohex(int n, char s[]);

/* convert a long integer to a string */
void ltoa(long i, char* buf);

/* convert a character to lowercase */
int tolower(int c);

/* convert all characters in a string to lowercase */
void strtolower(char *s);

#endif
