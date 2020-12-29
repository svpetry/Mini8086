#include "strutils.h"

int strlen(char *str) {
    const char *s;
    for (s = str; *s; ++s) ;
    return s - str;
}

char *strcpy(char *dest, const char *src) {
    char *temp = dest;
    while (*dest++ = *src++) ;
    return temp;
}

char *strcat(char *dest, const char *src) {
    int i, j;
    for (i = 0; dest[i] != '\0'; i++) ;
    for (j = 0; src[j] != '\0'; j++)
        dest[i + j] = src[j];
    dest[i + j] = '\0';
    return dest;
}

void *ltrim(char *s, int n, char c) {
	int l = strlen(s);
	int diff = n - l;
	int i;
	s[n] = '\0';
	while (l > 0) {
		l--;
		s[l + diff] = s[l];
	}
	while (diff > 0) {
		diff--;
		s[diff] = c;
	}
	return s;
}

void reverse(char s[]) {
	int i, j;
	char c;

	for (i = 0, j = strlen(s) - 1; i < j; i++, j--) {
		c = s[i];
		s[i] = s[j];
		s[j] = c;
	}
}

void itoa(int n, char s[]) {
	 int i, sign;

	 if ((sign = n) < 0)  /* record sign */
		 n = -n;          /* make n positive */
	 i = 0;
	 do {       /* generate digits in reverse order */
		 s[i++] = n % 10 + '0';   /* get next digit */
	 } while ((n /= 10) > 0);     /* delete it */
	 if (sign < 0)
		 s[i++] = '-';
	 s[i] = '\0';
	 reverse(s);
}

void itohex(int n, char s[]) {
	int i, sign;
	char c;

	if ((sign = n) < 0)
		n = -n;
	i = 0;
	do {
		c = n % 16;
		if (c < 10)
			c += '0';
		else
			c += 'A' - 10;
		s[i++] = c;
	} while ((n /= 16) > 0);
	if (sign < 0)
		s[i++] = '-';
	s[i] = '\0';
	reverse(s);
}

void ltoa(long i, char* buf) {
	char reverse[14];
	char* s;
	char sign = i < 0;

	if (i < 0)
		i = -i;
	reverse[13] = 0;
	s = reverse + 13;
	do {
		*--s = "0123456789"[i % 10];
		i /= 10;
	} while (i);
	if (sign)
		*--s = '-';
    strcpy(buf, s);
}
