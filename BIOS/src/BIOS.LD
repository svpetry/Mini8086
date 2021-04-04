OUTPUT_FORMAT(binary)
ENTRY(main)
STARTUP(crt0.o)

MEMORY {
	rom (rx) : ORIGIN = 0xF0000, LENGTH = 64K - 0x10
	ram (!rx) : ORIGIN = 0x00400, LENGTH = 0x00C00
}

SECTIONS {
	.text : {
		*(.text .text.*)
	} >rom

	.data : {
		__data_loadaddr = LOADADDR(.data) - 0xF0000;
		*(.nildata .nildata.*);
		*(.rodata .rodata.*);
		*(.data .data.*);
		__data_size = SIZEOF(.data);
	} >ram AT>rom

	.bss (NOLOAD) : {
		*(.bss .bss.*);
		*(COMMON);
		__bss_size = SIZEOF(.bss);
	} >ram

	/DISCARD/ : { *(.*) }
}
