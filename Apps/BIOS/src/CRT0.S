.section .text
.code16
.global _start

.set BIOS_STACK_START, 0x3FFE

.set PIC_CMD, 0x20
.set PIC_DATA, 0x21
.set TMR_CH0, 0x40
.set TMR_CH1, 0x41
.set TMR_CH2, 0x42
.set TMR_CMD, 0x43
// .set PPI_PORTA, 0x10
// .set PPI_PORTB, 0x11
// .set PPI_PORTC, 0x12
// .set PPI_CTRL, 0x13

// PIC initialization command words
.set ICW1, 0b00010111
.set ICW2, 0x08 // interrupt offset
.set ICW4, 0b00000001 // 8086 mode, normal EOI, unbuffered mode
.set OCW1, 0b11111100 // enable interrupt 0 (timer), 1 (keyboard)

.macro ENTER_INTERRUPT
	sti
	pushf
	push %ax
	push %bx
	push %cx
	push %dx
	push %si
	push %di
	push %bp
	push %ds
	push %es
	// change data segment and stack
	movw %ss, %ax
	xorw %bx, %bx
	movw %bx, %ds
	movw %bx, %es
	movw %bx, %ss
	movw %ax, ss_save
	movw %sp, sp_save
	andw %ax, %ax
	jz no_stack_chg_\@
	movw $BIOS_STACK_START, %sp
no_stack_chg_\@:
.endm

.macro LEAVE_INTERRUPT
	// restore stack
	movw ss_save, %ax
	movw sp_save, %sp
	movw %ax, %ss

	pop %es
	pop %ds
	pop %bp
	pop %di
	pop %si
	pop %dx
	pop %cx
	pop %bx
	mov $0x20, %al
	out %al, $PIC_CMD // send EOI
	pop %ax
	popf
	iret
.endm

_start:
	// set segments
	movw $0x0000, %dx
	movw %dx, %ds
	movw %dx, %es
	movw %dx, %ss
	movw $BIOS_STACK_START, %sp

	// copy .data segment to ram
	movw %cs, %ax
	movw %ax, %ds
	movw $__data_loadaddr, %si
	movw $0x0400, %di
	movw $__data_size, %cx
	rep movsb
	movw %dx, %ds

	// clear .bss segment
	movw $__bss_size, %cx
	xor %al, %al
	rep stosb

	// // write to PPI control port
	// movb $0x80, %al
	// outb %al, $PPI_CTRL

	// // set all port bits to 0
	// xorb %al, %al
	// outb %al, $PPI_PORTA
	// outb %al, $PPI_PORTB
	// outb %al, $PPI_PORTC

	// set all interrupt vectors to int_empty
	movw %cs, %bx
	movw $0x0100, %cx
	mov $0x0000, %di
clr_loop:
	movw $int_empty-_start, (%di)
	add $0x02, %di
	movw %bx, (%di)
	add $0x02, %di
	loop clr_loop

	// INT 00h
	movw $0x0000, %di
	movw $int00-_start, (%di)

	// INT 02h
	movw $0x0008, %di
	movw $int02-_start, (%di)

	// INT 04h
	movw $0x0010, %di
	movw $int04-_start, (%di)

	// INT 08h
	movw $0x0020, %di
	movw $int08-_start, (%di)

	// INT 09h
	movw $0x0024, %di
	movw $int09-_start, (%di)

	// INT 0Eh
	movw $0x0038, %di
	movw $int0E-_start, (%di)

	// INT 10h
	movw $0x0040, %di
	movw $int10-_start, (%di)

	// initialize timer 8254
	movb $0x36, %al // channel 0, access lobyte/hibyte, mode 3 (square wave generator)
	out %al, $TMR_CMD
	nop
	movb $0x50, %al // lobyte of 50000
	out %al, $TMR_CH0
	nop
	movb $0xC3, %al // hibyte of 50000
	out %al, $TMR_CH0
	nop

	// initialize PIC 8259
	movb $ICW1, %al
	out %al, $PIC_CMD
	nop
	movb $ICW2, %al
	out %al, $PIC_DATA
	nop
	movb $ICW4, %al
	out %al, $PIC_DATA
	nop
	movb $OCW1, %al
	out %al, $PIC_DATA
	nop

	// enable interrupts
	sti

	// run main
	call main
	hlt

	// interrupt handlers
int_empty:
	sti
	iret
	
	// CPU interrupts
int00:
	cld
	call int_div_by_zero
	sti
	iret
int02:
	cld
	call int_nmi
	sti
	iret
int04:
	cld
	call int_overflow
	sti
	iret
	
	/****** hardware interrupts ******/

	// IRQ0: timer
int08:
	ENTER_INTERRUPT
	cld
	call int_timer
	LEAVE_INTERRUPT
	
	// IRQ1: keyboard
int09:
	ENTER_INTERRUPT
	cld
	call int_keyboard
	LEAVE_INTERRUPT

	// IRQ6: sd drive
int0E:
	ENTER_INTERRUPT
	cld
	call int_drive
	LEAVE_INTERRUPT

	/****** software interrupts ******/
int10:
	pushf
	push %bx
	push %bp
	push %ds
	push %es

	xorw %bx, %bx
	movw %bx, %ds
	movw %bx, %es

	movw %ax, int_ax
	movw %cx, int_cx
	movw %dx, int_dx
	movw %si, int_si
	movw %di, int_di

	movw %ss, %ax
	movw %ax, int_ss_save
	movw %sp, int_sp_save
	movw %bx, %ss
	movw $BIOS_STACK_START, %sp

	cld
	call int_bios

	movw int_ss_save, %ax
	movw %ax, %ss
	movw int_sp_save, %sp

	movw int_ax, %ax
	movw int_cx, %cx
	movw int_dx, %dx
	movw int_si, %si
	movw int_di, %di

	pop %es
	pop %ds
	pop %bp
	pop %bx
	popf
	iret

.size _start, . - _start
