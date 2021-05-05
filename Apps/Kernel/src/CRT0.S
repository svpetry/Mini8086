.section .text
.code16
.global _start

_start:
	call main
	hlt

.size _start, . - _start
