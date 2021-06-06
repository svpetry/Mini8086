#ifndef MALLOC_H
#define MALLOC_H

#include "../../Lib/types.h"

struct header {
	struct header __far *ptr;
	unsigned int size;
};

typedef struct header Header;

unsigned int malloc_free_ram();
void malloc_reset(void __far *heap_start, word heap_size);
void *malloc_(unsigned int nbytes);
void free_(void __far *ap);

#endif
