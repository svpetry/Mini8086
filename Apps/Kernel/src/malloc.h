#include "../../Lib/types.h"

struct header {
	struct header __far *ptr;
	dword size;
};
typedef struct header header;

dword malloc_free_ram();
void malloc_reset(void __far *heap_start, dword heap_size);
void __far *malloc_(dword nbytes);
void free_(void __far *ap);
