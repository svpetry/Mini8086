# Mini8086
A small, extensible Intel 8086 based computer system.

## PCBs

Some boards are made with Eagle but then I switched to KiCad because my Eagle License covers only 2 layer boards and I don't like their new licensing model (it's to expensive for hobbyists).
Schematics and layout are contained in the folders Eagle and KiCad.

### Backplane (Eagle)

First revision of the system backplane with 6 slots and a power connector.

### Backplane (KiCad)

Second revision of the backplane. Has 7 slots and two power connectors (one of them USB-C).

### RAM board (Eagle)

RAM board with 512 KB SRAM.

### Info board (KiCad)

A 16x2 HD44780 based LCD can be mounted to this board. Also contains some LEDs for important signals.

### LED board (KiCad)

Information board with LEDs for the busses and all important signals.

### CPU board Rev 1 (KiCad, "main") 

First revision of the CPU board, contains socket for an Intel 8086 CPU, ROM and other important system chips:
* Intel 8259 interrupt controller
* Intel 8254 timer

### CPU board Rev 2 (KiCad, "mainv2")

Second revision of the CPU board where I replaced most of the logic chips with an Altera CPLD. Also contains 1 MB SRAM so the external RAM board is not needed.

### VGA board (KiCad)

Simple graphics card with 128 KB SRAM and VGA output. Supported modes:
* text mode 80x25 characters, 256 colors (resolution 640x400 pixels)
* 320x200, 256 colors
* 320x400, 256 colors
* 640x200, 256 colors

### I/O board (KiCad)

* Slots for SD and MicroSD cards. Simple SPI controller implemented in an Altera CPLD.
* PS/2 keyboard connector
* RS232 connector
* I²C controller with a RTC module, BMP sensor module and EEPROM connected.
