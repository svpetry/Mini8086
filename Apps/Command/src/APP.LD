OUTPUT_FORMAT(binary)
ENTRY(main)
STARTUP(crt0.o)

MEMORY {
	ram (!rx) : ORIGIN = 0x00000, LENGTH = 0x2000
}

SECTIONS {
	.text : {
		*(.text .text.*)
	} >ram

	.data : {
		*(.nildata .nildata.*);
		*(.rodata .rodata.*);
		*(.data .data.*);
	} >ram

	.bss (NOLOAD) : {
		*(.bss .bss.*);
		*(COMMON);
	} >ram

	/DISCARD/ : { *(.*) }
}
