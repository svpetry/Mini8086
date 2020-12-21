#include "utils.h"
#include "types.h"

static dword next = 1;

int rand(void) { 
    next = next * 1103515245 + 12345; 
    return (word)(next / 65536) % 32768; 
} 
  
void srand(word seed) { 
    next = seed; 
}

void __far *memcpy1(void __far *dest, void __far *src, size_t bytes) {
    word __far *s = src;
    word __far *d = dest;

    while (bytes >=2) {
        *(d++) = *(s++);
        bytes -= 2;
    }
    if (bytes == 1) {
        *((byte __far *) d) = *((byte __far *) s);
    }

    // size_t words = bytes / 2;
    // bytes %= 2;
    // __asm__ volatile("cld\n" "rep movsw" : : "S" (src), "D" (dest), "c" (words));
    // __asm__ volatile(        "rep movsb" : : "c" (bytes));
    return dest;
}

void __far *memset1(void __far *dest, byte val, size_t bytes) {
    word __far *d = dest;
    word wval = (val << 8) | val;

    while (bytes >=2) {
        *(d++) = wval;
        bytes -= 2;
    }
    if (bytes == 1) {
        *((byte __far *) d) = val;
    }

    // size_t words = bytes / 2;
    // bytes %= 2;
    // word wval = (val << 8) | val;
    // __asm__ volatile("cld\n" "rep stosw" : : "D"(dest), "ax"(wval), "c" (words));
    // __asm__ volatile(        "rep stosb" : : "al"(val), "c" (bytes));
    return dest;
}
