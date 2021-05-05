#include "malloc.h"

static Header __far *freep = NULL;
static void __far *heap_start;
word heap_size;

unsigned int malloc_free_ram() {
	unsigned int size;
	Header __far *p;
	size = freep->size;
	p = freep->ptr;
	
	while (p != freep) {
		size += p->size;
		p = p->ptr;
	}
	return size << 2;
}

void malloc_reset(void __far *start, word size) {
	freep = NULL;
	heap_start = start;
	heap_size = size;
}

void *malloc_(unsigned int nbytes) {
	Header __far *p;
	Header __far *prevp;
	unsigned int nunits;

	nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
	if ((prevp = freep) == NULL) {   /* no free list yet */
		freep = prevp = (Header __far *)heap_start;
		freep->size = heap_size;
		freep->ptr = (Header __far *)heap_start;
	}
	for (p = prevp->ptr; ; prevp = p, p = p->ptr) {
		if (p->size >= nunits) {  /* big enough */
			if (p->size == nunits)  /* exactly */
				prevp->ptr = p->ptr;
			else {              /* allocate tail end */
				p->size -= nunits;
				p += p->size;
				p->size = nunits;
			}
			freep = prevp;

			return (void *)(p + 1);
		}
		if (p == freep)  /* wrapped around free list */
			return NULL;    /* none left */
	}
}

void free_(void __far *ap) {
	Header __far *bp;
	Header __far *p;

	bp = (Header __far *)ap - 1;    /* point to block header */
	for (p = freep; !(bp > p && bp < p->ptr); p = p->ptr)
		if (p >= p->ptr && (bp > p || bp < p->ptr))
			break;  /* freed block at start or end of arena */

	if (bp + bp->size == p->ptr) {    /* join to upper nbr */
		bp->size += p->ptr->size;
		bp->ptr = p->ptr->ptr;
	} else
		bp->ptr = p->ptr;
	if (p + p->size == bp) {            /* join to lower nbr */
		p->size += bp->size;
		p->ptr = bp->ptr;
	} else
		p->ptr = bp;
	freep = p;
}
