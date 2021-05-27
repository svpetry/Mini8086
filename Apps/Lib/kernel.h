#include "types.h"

/* allocate memory */
void __far *k_malloc(dword size);

/* free memory */
void k_free(void __far *ptr);

/* start a process */
void start_process(char *filename);

/* wait for a given number of milliseconds */
void sleep(word milliseconds);
