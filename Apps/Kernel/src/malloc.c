#include "malloc.h"

static header __far *freep = NULL;
static void __far *heap_start;
word heap_size;

static header __far *inc_ptr(header __far *p, int units) {
	dword ptr = (dword)(p + units);
	word offs = ptr;
	word seg = ptr >> 16;
	seg += offs >> 4;
	offs = 0;
	ptr = (((dword)seg) << 16) + offs;
	return (header __far *)(ptr);
}

unsigned int malloc_free_ram() {
	unsigned int size;
	header __far *p;
	size = freep->h.size;
	p = freep->h.ptr;
	
	while (p != freep) {
		size += p->h.size;
		p = p->h.ptr;
	}
	return size << 2;
}

void malloc_reset(void __far *start, dword size) {
	freep = NULL;
	heap_start = start;
	heap_size = size;
}

void __far *malloc_(unsigned int nbytes) {
	header __far *p;
	header __far *prevp;
	unsigned int nunits;

	nunits = (nbytes + sizeof(header) - 1) / sizeof(header) + 1;
	if ((prevp = freep) == NULL) {   /* no free list yet */
		freep = prevp = (header __far *)heap_start;
		freep->h.size = heap_size;
		freep->h.ptr = (header __far *)heap_start;
	}
	for (p = prevp->h.ptr; ; prevp = p, p = p->h.ptr) {
		if (p->h.size >= nunits) {  /* big enough */
			if (p->h.size == nunits)  /* exactly */
				prevp->h.ptr = p->h.ptr;
			else {              /* allocate tail end */
				p->h.size -= nunits;
				p = inc_ptr(p, p->h.size);
				p->h.size = nunits;
			}
			freep = prevp;

			return (void __far *)inc_ptr(p, 1);
		}
		if (p == freep)  /* wrapped around free list */
			return NULL;    /* none left */
	}
}

void free_(void __far *ap) {
	header __far *bp;
	header __far *p;

	bp = (header __far *)ap - 1;    /* point to block header */
	for (p = freep; !(bp > p && bp < p->h.ptr); p = p->h.ptr)
		if (p >= p->h.ptr && (bp > p || bp < p->h.ptr))
			break;  /* freed block at start or end of arena */

	if (bp + bp->h.size == p->h.ptr) {    /* join to upper nbr */
		bp->h.size += p->h.ptr->h.size;
		bp->h.ptr = p->h.ptr->h.ptr;
	} else
		bp->h.ptr = p->h.ptr;
	if (p + p->h.size == bp) {            /* join to lower nbr */
		p->h.size += bp->h.size;
		p->h.ptr = bp->h.ptr;
	} else
		p->h.ptr = bp;
	freep = p;
}
