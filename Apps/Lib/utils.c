#include "utils.h"
#include "types.h"

void __far *memcpy_(void __far *dest, const void __far *src, size_t len) {
	dword sp = (dword)src;
	volatile word shi = (word)(sp >> 16);
	volatile word slo = (word)(sp & 0xFFFF);

	dword dp = (dword)dest;
	volatile word dhi = (word)(dp >> 16);
	volatile word dlo = (word)(dp & 0xFFFF);

    asm volatile (
        "cld\n"
        "movw %4, %%cx\n"
        "shr $0x01, %%cx\n"
        "movw %0, %%ax\n"
        "movw %%ax, %%ds\n"
        "movw %1, %%si\n"
        "movw %2, %%ax\n"
        "movw %%ax, %%es\n"
        "movw %3, %%di\n"
        "rep movsw\n"
        "testw $0x0001, %4\n"
        "jz cont_mc\n"
        "movsb\n"
        "cont_mc:\n"
        : /* no output */
        : "g" (shi), "g" (slo), "g" (dhi), "g" (dlo), "g" (len) 
        : "ds", "si", "es", "di", "ax", "cx", "cc"
    );

    return dest;
}

void __far *memset_(void __far *dest, byte val, size_t len) {
	dword p = (dword)dest;
	volatile word hi = (word)(p >> 16);
	volatile word lo = (word)(p & 0xFFFF);

    asm volatile (
        "cld\n"
        "movw %3, %%cx\n"
        "shr $0x01, %%cx\n"
        "movw %0, %%ax\n"
        "movw %%ax, %%es\n"
        "movw %1, %%di\n"
        "movb %2, %%al\n"
        "movb %%al, %%ah\n"
        "rep stosw\n"
        "testw $0x0001, %3\n"
        "jz cont_ms\n"
        "stosb\n"
        "cont_ms:\n"
        : /* no output */
        : "g" (hi), "g" (lo), "g" (val), "g" (len) 
        : "es", "di", "cx", "ax", "cc"
    );
    return dest;
}

void __far *memset16(void __far *dest, unsigned int val, size_t len) {
	dword p = (dword)dest;
	volatile word hi = (word)(p >> 16);
	volatile word lo = (word)(p & 0xFFFF);

    asm volatile (
        "cld\n"
        "movw %3, %%cx\n"
        "movw %0, %%ax\n"
        "movw %%ax, %%es\n"
        "movw %1, %%di\n"
        "movw %2, %%ax\n"
        "rep stosw\n"
        : /* no output */
        : "g" (hi), "g" (lo), "g" (val), "g" (len) 
        : "es", "di", "cx", "ax", "cc"
    );
    return dest;
}

void *memcpy(void *dest, const void *src, size_t len) {
    const word *s = src;
    word *d = dest;

    while (len >= 2) {
        *(d++) = *(s++);
        len -= 2;
    }
    if (len == 1) {
        *((byte *)d) = *((byte *)s);
    }
    return dest;
}

void *memset(void *dest, int val, size_t len) {
    byte bval = (byte)val;
    word *d = dest;
    word wval = (bval << 8) | val;

    while (len >=2) {
        *(d++) = wval;
        len -= 2;
    }
    if (len == 1) {
        *((byte __far *) d) = bval;
    }
    return dest;
}

inline void __far * near_to_far(void *p) {
    dword lp;
    word seg;
    asm(
        "pushw %%ds\n"
        "popw %0"
        : "=g" (seg) :
    );
    lp = (word)p;
    lp += ((dword)seg) << 16;
    return (void __far *)lp;
}