# Hardware interrupts 

| | |
| --- | --- |
| IRQ0 | 8254 Timer 0 |
| IRQ1 | keyboard |
| IRQ2 | 8254 Timer 1 |
| IRQ3 | (Serial port 2) |
| IRQ4 | Serial port 1 |
| IRQ5 | VGA retrace |
| IRQ6 | SD controller |
| IRQ7 | I2C controller |

# All interrupts
| Int | Address | Type | Function |
| --- | --- | --- | --- |
| 00h | 0000h | CPU | divide by zero |
| 01h | 0004h | CPU | single step |
| 02h | 0008h | CPU | NMI |
| 03h | 000Ch | CPU | breakpoint (INT 3) |
| 04h | 0010h | CPU | overflow (INTO) |
| 05h | 0014h | - | - |
| 06h | 0018h | - | - |
| 07h | 001Ch | - | - |
| 08h | 0020h | Hardware | IRQ0 |
| 09h | 0024h | Hardware | IRQ1 |
| 0Ah | 0028h | Hardware | IRQ2 |
| 0Bh | 002Ch | Hardware | IRQ3 |
| 0Ch | 0030h | Hardware | IRQ4 |
| 0Dh | 0034h | Hardware | IRQ5 |
| 0Eh | 0038h | Hardware | IRQ6 |
| 0Fh | 003Ch | Hardware | IRQ7 |
| 10h | 0040h | Software | BIOS |
| 20h | 0080h | Software | Kernel |