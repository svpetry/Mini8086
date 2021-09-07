## 0x10-0x17 debug port

---

## 0x20-0x27 PIC (8259)
- 0x20 command port
- 0x21 data port

---

## 0x30-0x37 chipset
- 0x30 control port

### control port: ------bb

| | |
| --- | --- |
| bb | memory bank 0x80000-0xBFFFF |

---

## 0x40-0x47 Timer (8254)
- 0x40 channel 0 data port
- 0x41 channel 1 data port
- 0x42 channel 2 data port
- 0x43 command register

---

## 0x50-0x57 VGA
- 0x50 VGA control port
- 0x51 background color

### control port: --hvipmm

| | | |
| --- | --- | --- |
| mm | r/w | graphics mode (0 = text, 1 = 320x200x8) |
| p | r/w | active plane |
| i | r/w | enable vertical retrace interrupt |
| v | r | vertical retrace (1 = active) |
| h | r | horizontal retrace (1 = active) |

---

## 0x60-0x67 controller (8042)

---

## 0x70-0x77 controller (PCA9564)

---
## 0x80-0x87 UART (16550)

---
## 0x90-0x97 controller
- 0x90 control port
- 0x91 status port
- 0x92 data port

### control port: iirgcddd

| | |
| --- | --- |
| ddd | clock divider |
| c | SD_CS |
| g | green LED |
| r | red LED |
| ii | interrupt (0 = no IRQ, 1 = IRQ on card insert, 2 = IRQ on op  finished) |

### status port: ------cb

| | |
| --- | --- |
| b | busy flag (1 = busy, 0 = idle) |
| c | card detect (1 = card inserted, 0 = no card) |
