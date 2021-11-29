#ifndef CLIB_STDLIB_H
#define CLIB_STDLIB_H

#define NULL 0

typedef unsigned long size_t;

/* convert a string to an integer */
int atoi(const char *s);

/* returns a pseudo random number */
int rand(void);

/* initializes the random number generator */
void srand(unsigned int seed);

#endif
