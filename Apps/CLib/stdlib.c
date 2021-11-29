#include "stdlib.h"
#include "stdint.h"

static unsigned long next = 1;

int atoi(const char *s) {
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

int rand(void) { 
    next = next * 1103515245 + 12345; 
    return (unsigned int)(next / 65536) % 32768; 
} 
  
void srand(unsigned int seed) { 
    next = seed; 
}
