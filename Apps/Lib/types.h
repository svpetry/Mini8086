typedef unsigned char byte;
typedef unsigned int word;
typedef unsigned long dword;

#define NULL 0

/* macros for far pointers (a la Turbo C++ and Open Watcom) */
#define _FP_SEG(fp)	((unsigned)((unsigned long)(void __far *)(fp) >> 16))
#define _FP_OFF(fp)	((unsigned)(unsigned long)(void __far *)(fp))
#define _MK_FP(seg,off)	((void __far *)((((unsigned long)(seg)) << 16) | (off)))