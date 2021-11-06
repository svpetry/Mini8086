.section .text
.code16
.global _start

_start:
	xorw %ax, %ax
	movw %ax, %ds

	// INT 20h
	movw $0x0080, %di
	movw $int20-_start, (%di)
	movw %cs, %ax
	incw %di
	incw %di
	movw %ax, (%di)

	movw %ax, %ds

	cli
	call main
	hlt

/* INT 20h (kernel functions) */
int20:
	push %bx
	push %bp
	push %ds
	push %es

	movw %cs, %bx
	movw %bx, %ds
	movw %bx, %es

	movw %ax, int_ax
	movw %cx, int_cx
	movw %dx, int_dx
	movw %si, int_si

	cli
	movw %ss, %ax
	movw %ax, int_ss_save
	movw %sp, int_sp_save
	movw %bx, %ss
	movw sp_save, %sp

	cld
	call int_kernel

	movw int_ss_save, %ax
	movw %ax, %ss
	movw int_sp_save, %sp

	movw int_ax, %ax
	movw int_cx, %cx
	movw int_dx, %dx
	movw int_si, %si

	pop %es
	pop %ds
	pop %bp
	pop %bx
	iret

.size _start, . - _start
