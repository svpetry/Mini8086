#ifndef UTILS_H
#define UTILS_H

#include "types.h"

#define RAND_MAX 32767

typedef unsigned int size_t;

/* returns a pseudo random number */
int rand(void);

/* initializes the random number generator */
void srand(unsigned int seed);

/* memory copy (far pointer) */
void __far *memcpy_(void __far *dest, const void __far *src, size_t len);

/* fill memory (far pointer) */
void __far *memset_(void __far *dest, unsigned char val, size_t len);

/* fill memory (far pointer, 16 bit) */
void __far *memset16(void __far *dest, unsigned int val, size_t len);

/* memory copy (near pointer) */
void *memcpy(void *dest, const void *src, size_t len);

/* fill memory (near pointer) */
void *memset(void *dest, int val, size_t len);

/* convert near to far pointer */
void __far *near_to_far(void *p);

#endif
