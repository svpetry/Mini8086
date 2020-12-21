#define RAND_MAX 32767

typedef unsigned int size_t;

int rand(void);
void srand(unsigned int seed);
void __far *memcpy1(void __far *dest, void __far *src, size_t bytes);
void __far *memset1(void __far *dest, unsigned char val, size_t bytes);
