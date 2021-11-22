#include "strutils.h"
#include "types.h"

int strempty(const char *s) {
	return s[0] == 0;
}

int strlen(const char *str) {
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

void *rtrim(char *s, int n, char c) {
	int l = strlen(s);
	int diff = n - l;
	while (diff > 0) {
		diff--;
		s[l++] = c;
	}
	s[l] = 0;
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

int strcmp(const char *s1, const char *s2) {
    while (*s1 && (*s1 == *s2)) {
        s1++;
        s2++;
    }
    return *(const unsigned char*)s1 - *(const unsigned char*)s2;
}

int strncmp(const char *s1, const char *s2, int n) {
    while (n && *s1 && (*s1 == *s2)) {
        ++s1;
        ++s2;
        --n;
    }
    if (n == 0)
        return 0;
    else
        return *(unsigned char *)s1 - *(unsigned char *)s2;
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

int tolower(int c) {
	if (c >= 'A' && c <= 'Z')
		return c - 'A' + 'a';
	return c;
}

void strtolower(char *s) {
	while (*s) {
		*s = tolower(*s);
		s++;
    }
}

int toupper(int c) {
	if (c >= 'a' && c <= 'z')
		return c - 'a' + 'A';
	return c;
}

void strtoupper(char *s) {
	while (*s) {
		*s = toupper(*s);
		s++;
    }
}

int atoi(char *s) {
	int result = 0;
	while (*s == ' ') s++;
	int neg = (*s == '-');
	if (neg) s++;
	while (*s == ' ') s++;
	while (*s) {
		result = result * 10 + *s - '0';
		s++;
	}
	if (neg) return -result;
	return result;
}

int strpos(const char *haystack, const char *needle) {
	int needle_len = strlen(needle);
	int maxi = strlen(haystack) - needle_len;
	for (int i = 0; i <= maxi; i++) {
		int j;
		for (j = 0; j < needle_len; j++) {
			if (haystack[i + j] != needle[j])
				break;
		}
		if (j == needle_len) return i;
	}
	return -1;
}

char *strofchar(char *s, int n, char c) {
	while (n > 0) {
		*(s++) = c;
		n--;
	}
	*s = '\0';
}

char *strchr(const char *s, int c) {
    while (*s != (char)c)
        if (*(++s) == '\0') return NULL;
    return (char *)s;
}
