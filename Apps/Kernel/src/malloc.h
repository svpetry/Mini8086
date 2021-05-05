#include "../../Lib/types.h"

union header {
	struct header_int {
		union header __far *ptr;
		dword size;
	} h;
	byte fill[16];
};

typedef union header header;

unsigned int malloc_free_ram();
void malloc_reset(void __far *heap_start, dword heap_size);
void __far *malloc_(unsigned int nbytes);
void free_(void __far *ap);
