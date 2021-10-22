.section .text
.code16
.global _start

_start:
	mov %cs, %ax
	mov %ax, %ds
	mov %ax, %es
	mov %ax, %ss
	mov %si, %sp // SI contains new stack pointer
	call main
	int $0x81

.size _start, . - _start
