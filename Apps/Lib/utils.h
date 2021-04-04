#include "types.h"

#define RAND_MAX 32767

typedef unsigned int size_t;

/* returns a pseudo random number */
int rand(void);

/* initializes the random number generator */
void srand(unsigned int seed);

/* memory copy */
void __far *memcpy_(void __far *dest, void __far *src, size_t bytes);

/* fill memory */
void __far *memset_(void __far *dest, unsigned char val, size_t bytes);

/* convert near to far pointer */
void __far *near_to_far(void *p);
