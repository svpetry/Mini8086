#include "kmalloc.h"

#define UNIT_SIZE 16

static header __far *freep = NULL;
static void __far *heap_start;
static dword heap_size;

static header __far *inc_ptr(header __far *p, int units) {
	dword dw_ptr = (dword)p;
	dw_ptr += (dword)units << 16;
	return (header __far *)dw_ptr;
}

dword malloc_free_ram() {
	dword size;
	header __far *p;
	size = freep->size;
	p = freep->ptr;
	
	while (p != freep) {
		size += p->size;
		p = p->ptr;
	}
	return size * UNIT_SIZE;
}

void malloc_reset(void __far *start, dword size) {
	freep = NULL;
	heap_start = start;
	heap_size = size / UNIT_SIZE;
}

void __far *malloc_(dword nbytes) {
	header __far *p;
	header __far *prevp;
	dword nunits;

	nunits = (nbytes + UNIT_SIZE - 1) / UNIT_SIZE + 1;
	if ((prevp = freep) == NULL) {   /* no free list yet */
		freep = prevp = (header __far *)heap_start;
		freep->size = heap_size;
		freep->ptr = (header __far *)heap_start;
	}
	for (p = prevp->ptr; ; prevp = p, p = p->ptr) {
		if (p->size >= nunits) {  /* big enough */
			if (p->size == nunits)  /* exactly */
				prevp->ptr = p->ptr;
			else {              /* allocate tail end */
				p->size -= nunits;
				p = inc_ptr(p, p->size);
				p->size = nunits;
			}
			freep = prevp;

			void __far *memp = (void __far *)inc_ptr(p, 1);
			return memp;
		}
		if (p == freep)  /* wrapped around free list */
			return NULL;    /* none left */
	}
}

void free_(void __far *ap) {
	header __far *bp;
	header __far *p;

	bp = (header __far *)ap;    /* point to block header */
	bp = inc_ptr(bp, -1);

	for (p = freep; !(bp > p && bp < p->ptr); p = p->ptr)
		if (p >= p->ptr && (bp > p || bp < p->ptr))
			break;  /* freed block at start or end of arena */

	if (bp + bp->size == p->ptr) {    /* join to upper nbr */
		bp->size += p->ptr->size;
		bp->ptr = p->ptr->ptr;
	} else
		bp->ptr = p->ptr;
	if (p + p->size == bp) {          /* join to lower nbr */
		p->size += bp->size;
		p->ptr = bp->ptr;
	} else
		p->ptr = bp;
	freep = p;
}
