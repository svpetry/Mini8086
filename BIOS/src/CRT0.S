.section .text
.code16
.global _start
_start:

	// set segments
	movw $0x0010, %dx
	movw %dx, %ds
	movw %dx, %es
	movw %dx, %ss
	movw $0xFEFE, %sp

	// copy .data segment to ram
	movw %cs, %ax
	movw %ax, %ds
	movw $__data_loadaddr, %si
	xorw %di, %di
	movw $__data_size, %cx
	rep movsb
	movw %dx, %ds

	// clear .bss segment
	movw $__bss_size, %cx
	xor %al, %al
	rep stosb

	// write to PPI control port
	movb $0x80, %al
	outb %al, $0x16

	// set all port bits to 0
	xorb %al, %al
	outb %al, $0x10
	outb %al, $0x12
	outb %al, $0x14

	# Run main
	call main
	hlt

.size _start, . - _start
