EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 4 5
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Memory_EPROM:27C512 U12
U 1 1 5F83E586
P 8750 3400
F 0 "U12" H 8750 3400 50  0000 C CNN
F 1 "27C512" H 8950 2350 50  0000 C CNN
F 2 "Package_DIP:DIP-28_W15.24mm_Socket_LongPads" H 8750 3400 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/doc0015.pdf" H 8750 3400 50  0001 C CNN
	1    8750 3400
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR041
U 1 1 5F84020D
P 8750 2300
F 0 "#PWR041" H 8750 2150 50  0001 C CNN
F 1 "VCC" H 8765 2473 50  0000 C CNN
F 2 "" H 8750 2300 50  0001 C CNN
F 3 "" H 8750 2300 50  0001 C CNN
	1    8750 2300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR042
U 1 1 5F8403DC
P 8750 4500
F 0 "#PWR042" H 8750 4250 50  0001 C CNN
F 1 "GND" H 8755 4327 50  0000 C CNN
F 2 "" H 8750 4500 50  0001 C CNN
F 3 "" H 8750 4500 50  0001 C CNN
	1    8750 4500
	1    0    0    -1  
$EndComp
Wire Wire Line
	8350 3200 8200 3200
Wire Wire Line
	8200 3200 8200 3300
Wire Wire Line
	8350 3300 8200 3300
Connection ~ 8200 3300
Wire Wire Line
	8200 3300 8200 4200
$Comp
L power:GND #PWR040
U 1 1 5F84074D
P 8200 4500
F 0 "#PWR040" H 8200 4250 50  0001 C CNN
F 1 "GND" H 8205 4327 50  0000 C CNN
F 2 "" H 8200 4500 50  0001 C CNN
F 3 "" H 8200 4500 50  0001 C CNN
	1    8200 4500
	1    0    0    -1  
$EndComp
Wire Wire Line
	8350 4200 8200 4200
Connection ~ 8200 4200
Wire Wire Line
	8200 4200 8200 4300
Wire Wire Line
	8200 4300 8350 4300
Connection ~ 8200 4300
Wire Wire Line
	8200 4300 8200 4500
Wire Wire Line
	9150 2500 9650 2500
Wire Wire Line
	9150 2600 9250 2600
Wire Wire Line
	9150 2700 9650 2700
Wire Wire Line
	9150 2800 9250 2800
Wire Wire Line
	9150 2900 9650 2900
Wire Wire Line
	9150 3000 9250 3000
Wire Wire Line
	9150 3100 9650 3100
Wire Wire Line
	9150 3200 9250 3200
Text GLabel 9650 2500 2    50   Output ~ 0
~MEMRD
Text GLabel 9250 2600 2    50   Output ~ 0
~MEMWR
Text GLabel 9650 2700 2    50   Output ~ 0
~ROMRD
Text GLabel 9250 2800 2    50   Output ~ 0
~IO_TIMER
Text GLabel 9650 2900 2    50   Output ~ 0
~IO_PIC
Text GLabel 9250 3000 2    50   Output ~ 0
~IO_DBG
Text GLabel 9650 3100 2    50   Output ~ 0
~VGA_MEM
Text GLabel 9250 3200 2    50   Output ~ 0
~VGA_IO
Wire Wire Line
	8350 4000 8050 4000
Wire Wire Line
	8350 3900 7750 3900
Wire Wire Line
	8050 3800 8350 3800
Text GLabel 8050 4000 0    50   Input ~ 0
~WR
Text GLabel 7750 3900 0    50   Input ~ 0
~RD
Text GLabel 8050 3800 0    50   Input ~ 0
M_~IO
Wire Wire Line
	8350 3400 7950 3400
Wire Wire Line
	8350 3500 7950 3500
Wire Wire Line
	7950 3600 8350 3600
Wire Wire Line
	7950 3700 8350 3700
Entry Wire Line
	7950 2500 7850 2400
Entry Wire Line
	7950 2600 7850 2500
Entry Wire Line
	7950 2700 7850 2600
Entry Wire Line
	7950 2800 7850 2700
Entry Wire Line
	7950 2900 7850 2800
Entry Wire Line
	7950 3000 7850 2900
Entry Wire Line
	7950 3100 7850 3000
Entry Wire Line
	7950 3400 7850 3300
Entry Wire Line
	7950 3500 7850 3400
Entry Wire Line
	7950 3600 7850 3500
Entry Wire Line
	7950 3700 7850 3600
Wire Bus Line
	7850 2300 7750 2300
Text GLabel 7750 2300 0    50   Input ~ 0
A[0..19]
Text Label 8000 2500 0    50   ~ 0
A3
Text Label 8000 2600 0    50   ~ 0
A4
Text Label 8000 2700 0    50   ~ 0
A5
Text Label 8000 2800 0    50   ~ 0
A6
Text Label 8000 2900 0    50   ~ 0
A7
Text Label 8000 3000 0    50   ~ 0
A8
Text Label 8000 3100 0    50   ~ 0
A9
Wire Wire Line
	7950 2500 8350 2500
Wire Wire Line
	7950 2600 8350 2600
Wire Wire Line
	7950 2700 8350 2700
Wire Wire Line
	7950 2800 8350 2800
Wire Wire Line
	7950 2900 8350 2900
Wire Wire Line
	7950 3000 8350 3000
Wire Wire Line
	7950 3100 8350 3100
Text Label 8000 3400 0    50   ~ 0
A16
Text Label 8000 3500 0    50   ~ 0
A17
Text Label 8000 3600 0    50   ~ 0
A18
Text Label 8000 3700 0    50   ~ 0
A19
$Comp
L Interface:8259 U11
U 1 1 5F84FF3C
P 4750 2400
F 0 "U11" H 4750 2400 50  0000 C CNN
F 1 "8259" H 4950 1400 50  0000 C CNN
F 2 "Package_DIP:DIP-28_W15.24mm_Socket_LongPads" H 4750 2400 50  0001 C CIN
F 3 "http://pdos.csail.mit.edu/6.828/2005/readings/hardware/8259A.pdf" H 4750 2400 50  0001 C CNN
	1    4750 2400
	1    0    0    -1  
$EndComp
$Comp
L Timer:8254 U10
U 1 1 5F850A78
P 2650 5300
F 0 "U10" H 2650 5300 50  0000 C CNN
F 1 "8254" H 2850 4400 50  0000 C CNN
F 2 "Package_DIP:DIP-24_W15.24mm_Socket_LongPads" H 2700 5550 50  0001 C CNN
F 3 "http://www.scs.stanford.edu/10wi-cs140/pintos/specs/8254.pdf" H 2200 6200 50  0001 C CNN
	1    2650 5300
	1    0    0    -1  
$EndComp
$Comp
L Oscillator:CXO_DIP14 X1
U 1 1 5F8530AE
P 4550 5200
F 0 "X1" H 4450 4900 50  0000 R CNN
F 1 "1 MHz" H 4500 5500 50  0000 R CNN
F 2 "Oscillator:Oscillator_DIP-14" H 5000 4850 50  0001 C CNN
F 3 "http://cdn-reichelt.de/documents/datenblatt/B400/OSZI.pdf" H 4450 5200 50  0001 C CNN
	1    4550 5200
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR032
U 1 1 5F85463D
P 2650 6300
F 0 "#PWR032" H 2650 6050 50  0001 C CNN
F 1 "GND" H 2655 6127 50  0000 C CNN
F 2 "" H 2650 6300 50  0001 C CNN
F 3 "" H 2650 6300 50  0001 C CNN
	1    2650 6300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR035
U 1 1 5F8547DF
P 4550 5500
F 0 "#PWR035" H 4550 5250 50  0001 C CNN
F 1 "GND" H 4555 5327 50  0000 C CNN
F 2 "" H 4550 5500 50  0001 C CNN
F 3 "" H 4550 5500 50  0001 C CNN
	1    4550 5500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR037
U 1 1 5F854C80
P 4750 3500
F 0 "#PWR037" H 4750 3250 50  0001 C CNN
F 1 "GND" H 4755 3327 50  0000 C CNN
F 2 "" H 4750 3500 50  0001 C CNN
F 3 "" H 4750 3500 50  0001 C CNN
	1    4750 3500
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR034
U 1 1 5F855189
P 4550 4900
F 0 "#PWR034" H 4550 4750 50  0001 C CNN
F 1 "VCC" H 4565 5073 50  0000 C CNN
F 2 "" H 4550 4900 50  0001 C CNN
F 3 "" H 4550 4900 50  0001 C CNN
	1    4550 4900
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR031
U 1 1 5F85532E
P 2650 4300
F 0 "#PWR031" H 2650 4150 50  0001 C CNN
F 1 "VCC" H 2665 4473 50  0000 C CNN
F 2 "" H 2650 4300 50  0001 C CNN
F 3 "" H 2650 4300 50  0001 C CNN
	1    2650 4300
	1    0    0    -1  
$EndComp
Wire Wire Line
	1950 6000 2050 6000
Wire Wire Line
	1550 5800 2050 5800
Wire Wire Line
	1550 5700 2050 5700
Wire Wire Line
	1750 5600 2050 5600
Wire Wire Line
	1950 5500 2050 5500
Wire Wire Line
	1850 4600 2050 4600
Wire Wire Line
	1850 4700 2050 4700
Wire Wire Line
	1850 4800 2050 4800
Wire Wire Line
	1850 4900 2050 4900
Wire Wire Line
	1850 5000 2050 5000
Wire Wire Line
	1850 5100 2050 5100
Wire Wire Line
	1850 5200 2050 5200
Wire Wire Line
	1850 5300 2050 5300
Wire Wire Line
	3950 1600 4150 1600
Wire Wire Line
	3950 1700 4150 1700
Wire Wire Line
	3950 1800 4150 1800
Wire Wire Line
	3950 1900 4150 1900
Wire Wire Line
	3950 2000 4150 2000
Wire Wire Line
	3950 2100 4150 2100
Wire Wire Line
	3950 2200 4150 2200
Wire Wire Line
	3950 2300 4150 2300
Wire Wire Line
	5800 1600 5350 1600
Wire Wire Line
	5450 1700 5350 1700
Wire Wire Line
	5800 1800 5350 1800
Wire Wire Line
	5350 1900 5450 1900
Wire Wire Line
	5800 2000 5350 2000
Text GLabel 5800 1600 2    50   Input ~ 0
IRQ7
Text GLabel 5450 1700 2    50   Input ~ 0
IRQ6
Text GLabel 5800 1800 2    50   Input ~ 0
IRQ5
Text GLabel 5450 1900 2    50   Input ~ 0
IRQ4
Text GLabel 5800 2000 2    50   Input ~ 0
IRQ3
Wire Wire Line
	5700 2900 5700 2800
$Comp
L power:VCC #PWR036
U 1 1 5F88937D
P 4750 1300
F 0 "#PWR036" H 4750 1150 50  0001 C CNN
F 1 "VCC" H 4765 1473 50  0000 C CNN
F 2 "" H 4750 1300 50  0001 C CNN
F 3 "" H 4750 1300 50  0001 C CNN
	1    4750 1300
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR039
U 1 1 5F8899AD
P 5700 2800
F 0 "#PWR039" H 5700 2650 50  0001 C CNN
F 1 "VCC" H 5715 2973 50  0000 C CNN
F 2 "" H 5700 2800 50  0001 C CNN
F 3 "" H 5700 2800 50  0001 C CNN
	1    5700 2800
	1    0    0    -1  
$EndComp
Entry Wire Line
	3950 1600 3850 1500
Entry Wire Line
	3950 1700 3850 1600
Entry Wire Line
	3950 1800 3850 1700
Entry Wire Line
	3950 1900 3850 1800
Entry Wire Line
	3950 2000 3850 1900
Entry Wire Line
	3950 2100 3850 2000
Entry Wire Line
	3950 2200 3850 2100
Entry Wire Line
	3950 2300 3850 2200
Entry Wire Line
	1850 4600 1750 4500
Entry Wire Line
	1850 4700 1750 4600
Entry Wire Line
	1850 4800 1750 4700
Entry Wire Line
	1850 4900 1750 4800
Entry Wire Line
	1850 5000 1750 4900
Entry Wire Line
	1850 5100 1750 5000
Entry Wire Line
	1850 5200 1750 5100
Entry Wire Line
	1850 5300 1750 5200
Wire Bus Line
	3850 1400 3750 1400
Wire Bus Line
	1750 4400 1650 4400
Text GLabel 3750 1400 0    50   BiDi ~ 0
D[0..15]
Text GLabel 1650 4400 0    50   BiDi ~ 0
D[0..15]
Text Label 4000 1600 0    50   ~ 0
D0
Text Label 4000 1700 0    50   ~ 0
D1
Text Label 4000 1800 0    50   ~ 0
D2
Text Label 4000 1900 0    50   ~ 0
D3
Text Label 4000 2000 0    50   ~ 0
D4
Text Label 4000 2100 0    50   ~ 0
D5
Text Label 4000 2200 0    50   ~ 0
D6
Text Label 4000 2300 0    50   ~ 0
D7
Text Label 1900 4600 0    50   ~ 0
D0
Text Label 1900 4700 0    50   ~ 0
D1
Text Label 1900 4800 0    50   ~ 0
D2
Text Label 1900 4900 0    50   ~ 0
D3
Text Label 1900 5000 0    50   ~ 0
D4
Text Label 1900 5100 0    50   ~ 0
D5
Text Label 1900 5200 0    50   ~ 0
D6
Text Label 1900 5300 0    50   ~ 0
D7
Wire Wire Line
	3250 5800 3350 5800
Wire Wire Line
	3350 5800 3350 5300
Wire Wire Line
	3250 4800 3350 4800
Connection ~ 3350 4800
Wire Wire Line
	3350 4800 3350 4500
Wire Wire Line
	3250 5300 3350 5300
Connection ~ 3350 5300
Wire Wire Line
	3350 5300 3350 4800
$Comp
L power:VCC #PWR033
U 1 1 5F899863
P 3350 4500
F 0 "#PWR033" H 3350 4350 50  0001 C CNN
F 1 "VCC" H 3365 4673 50  0000 C CNN
F 2 "" H 3350 4500 50  0001 C CNN
F 3 "" H 3350 4500 50  0001 C CNN
	1    3350 4500
	1    0    0    -1  
$EndComp
Wire Wire Line
	3250 4700 3550 4700
Wire Wire Line
	3550 4700 3550 5200
Wire Wire Line
	3550 5700 3250 5700
Wire Wire Line
	3250 5200 3550 5200
Connection ~ 3550 5200
Wire Wire Line
	3550 5200 3550 5700
Wire Wire Line
	4250 5200 3550 5200
Wire Wire Line
	3250 4900 3750 4900
Wire Wire Line
	3750 4900 3750 4100
Wire Wire Line
	3750 4100 5900 4100
Wire Wire Line
	5900 4100 5900 2300
Wire Wire Line
	5350 2300 5900 2300
Wire Wire Line
	3250 5900 3450 5900
Text GLabel 3450 5900 2    50   Output ~ 0
TMR2
Wire Wire Line
	4150 2500 3950 2500
Wire Wire Line
	3850 2700 4150 2700
Wire Wire Line
	4050 2800 4150 2800
Wire Wire Line
	3850 2900 4150 2900
Wire Wire Line
	4050 3100 4150 3100
Wire Wire Line
	3850 3200 4150 3200
Text GLabel 4050 3100 0    50   Output ~ 0
INT
Text GLabel 3850 3200 0    50   Input ~ 0
~INTA
Text GLabel 3850 2700 0    50   Input ~ 0
~IO_PIC
Text GLabel 4050 2800 0    50   Input ~ 0
~WR
Text GLabel 3850 2900 0    50   Input ~ 0
~RD
Text GLabel 1950 5500 0    50   Input ~ 0
~RD
Text GLabel 1750 5600 0    50   Input ~ 0
~WR
Text GLabel 1950 6000 0    50   Input ~ 0
~IO_TIMER
$Comp
L power:VCC #PWR0101
U 1 1 5F7C1C78
P 4850 5200
F 0 "#PWR0101" H 4850 5050 50  0001 C CNN
F 1 "VCC" H 4865 5373 50  0000 C CNN
F 2 "" H 4850 5200 50  0001 C CNN
F 3 "" H 4850 5200 50  0001 C CNN
	1    4850 5200
	0    1    1    0   
$EndComp
Entry Wire Line
	1550 5700 1450 5600
Entry Wire Line
	1550 5800 1450 5700
Text Label 1850 5700 0    50   ~ 0
A1
Text Label 1850 5800 0    50   ~ 0
A2
Wire Bus Line
	1450 5550 1350 5550
Text GLabel 1350 5550 0    50   Input ~ 0
A[0..19]
Text Label 4000 2500 0    50   ~ 0
A1
Entry Wire Line
	3950 2500 3850 2400
Wire Bus Line
	3850 2400 3800 2400
Text GLabel 3800 2400 0    50   Input ~ 0
A[0..19]
NoConn ~ 5350 2500
NoConn ~ 5350 2600
NoConn ~ 5350 2700
$Comp
L Device:R R5
U 1 1 5F78548B
P 5550 2900
F 0 "R5" V 5343 2900 50  0000 C CNN
F 1 "4K7" V 5434 2900 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 5480 2900 50  0001 C CNN
F 3 "~" H 5550 2900 50  0001 C CNN
	1    5550 2900
	0    1    1    0   
$EndComp
Wire Wire Line
	5400 2900 5350 2900
Wire Wire Line
	5350 2200 5800 2200
Text GLabel 5800 2200 2    50   Input ~ 0
IRQ1
Text Label 5500 2300 0    50   ~ 0
IRQ0
Wire Wire Line
	6050 2100 6050 4200
Wire Wire Line
	6050 4200 3850 4200
Wire Wire Line
	3850 4200 3850 5400
Wire Wire Line
	3850 5400 3250 5400
Wire Wire Line
	5350 2100 6050 2100
Text Label 5500 2100 0    50   ~ 0
IRQ2
Wire Bus Line
	1450 5550 1450 5700
Wire Bus Line
	7850 2300 7850 3600
Wire Bus Line
	3850 1400 3850 2200
Wire Bus Line
	1750 4400 1750 5200
Text Notes 8550 4900 0    50   ~ 0
I/O decoder
$EndSCHEMATC
