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
P 9050 3400
F 0 "U12" H 9050 3400 50  0000 C CNN
F 1 "27C512" H 9250 2350 50  0000 C CNN
F 2 "Package_DIP:DIP-28_W15.24mm_Socket_LongPads" H 9050 3400 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/doc0015.pdf" H 9050 3400 50  0001 C CNN
	1    9050 3400
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR041
U 1 1 5F84020D
P 9050 2300
F 0 "#PWR041" H 9050 2150 50  0001 C CNN
F 1 "VCC" H 9065 2473 50  0000 C CNN
F 2 "" H 9050 2300 50  0001 C CNN
F 3 "" H 9050 2300 50  0001 C CNN
	1    9050 2300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR042
U 1 1 5F8403DC
P 9050 4500
F 0 "#PWR042" H 9050 4250 50  0001 C CNN
F 1 "GND" H 9055 4327 50  0000 C CNN
F 2 "" H 9050 4500 50  0001 C CNN
F 3 "" H 9050 4500 50  0001 C CNN
	1    9050 4500
	1    0    0    -1  
$EndComp
Wire Wire Line
	8650 3200 8500 3200
Wire Wire Line
	8500 3200 8500 3300
Wire Wire Line
	8650 3300 8500 3300
Connection ~ 8500 3300
Wire Wire Line
	8500 3300 8500 4200
$Comp
L power:GND #PWR040
U 1 1 5F84074D
P 8500 4500
F 0 "#PWR040" H 8500 4250 50  0001 C CNN
F 1 "GND" H 8505 4327 50  0000 C CNN
F 2 "" H 8500 4500 50  0001 C CNN
F 3 "" H 8500 4500 50  0001 C CNN
	1    8500 4500
	1    0    0    -1  
$EndComp
Wire Wire Line
	8650 4200 8500 4200
Connection ~ 8500 4200
Wire Wire Line
	8500 4200 8500 4300
Wire Wire Line
	8500 4300 8650 4300
Connection ~ 8500 4300
Wire Wire Line
	8500 4300 8500 4500
Wire Wire Line
	9450 2500 9900 2500
Wire Wire Line
	9450 2600 9550 2600
Wire Wire Line
	9450 2700 9900 2700
Wire Wire Line
	9450 2800 9550 2800
Wire Wire Line
	9450 2900 9900 2900
Wire Wire Line
	9450 3000 9550 3000
Wire Wire Line
	9450 3100 9900 3100
Wire Wire Line
	9450 3200 9550 3200
Text GLabel 9900 2500 2    50   Output ~ 0
~MEMRD
Text GLabel 9550 2600 2    50   Output ~ 0
~MEMWR
Text GLabel 9900 2700 2    50   Output ~ 0
~ROMRD
Text GLabel 9550 2800 2    50   Output ~ 0
~IO0
Text GLabel 9900 2900 2    50   Output ~ 0
~IO1
Text GLabel 9550 3000 2    50   Output ~ 0
~IO2
Text GLabel 9900 3100 2    50   Output ~ 0
~VGA_MEM
Text GLabel 9550 3200 2    50   Output ~ 0
~VGA_IO
Wire Wire Line
	8650 4000 8350 4000
Wire Wire Line
	8650 3900 8050 3900
Wire Wire Line
	8350 3800 8650 3800
Text GLabel 8350 4000 0    50   Input ~ 0
~WR
Text GLabel 8050 3900 0    50   Input ~ 0
~RD
Text GLabel 8350 3800 0    50   Input ~ 0
M_~IO
Wire Wire Line
	8650 3400 8250 3400
Wire Wire Line
	8650 3500 8250 3500
Wire Wire Line
	8250 3600 8650 3600
Wire Wire Line
	8250 3700 8650 3700
Entry Wire Line
	8250 2500 8150 2400
Entry Wire Line
	8250 2600 8150 2500
Entry Wire Line
	8250 2700 8150 2600
Entry Wire Line
	8250 2800 8150 2700
Entry Wire Line
	8250 2900 8150 2800
Entry Wire Line
	8250 3000 8150 2900
Entry Wire Line
	8250 3100 8150 3000
Entry Wire Line
	8250 3400 8150 3300
Entry Wire Line
	8250 3500 8150 3400
Entry Wire Line
	8250 3600 8150 3500
Entry Wire Line
	8250 3700 8150 3600
Wire Bus Line
	8150 2300 8050 2300
Text GLabel 8050 2300 0    50   Input ~ 0
A[0..19]
Text Label 8300 2500 0    50   ~ 0
A3
Text Label 8300 2600 0    50   ~ 0
A4
Text Label 8300 2700 0    50   ~ 0
A5
Text Label 8300 2800 0    50   ~ 0
A6
Text Label 8300 2900 0    50   ~ 0
A7
Text Label 8300 3000 0    50   ~ 0
A8
Text Label 8300 3100 0    50   ~ 0
A9
Wire Wire Line
	8250 2500 8650 2500
Wire Wire Line
	8250 2600 8650 2600
Wire Wire Line
	8250 2700 8650 2700
Wire Wire Line
	8250 2800 8650 2800
Wire Wire Line
	8250 2900 8650 2900
Wire Wire Line
	8250 3000 8650 3000
Wire Wire Line
	8250 3100 8650 3100
Text Label 8300 3400 0    50   ~ 0
A16
Text Label 8300 3500 0    50   ~ 0
A17
Text Label 8300 3600 0    50   ~ 0
A18
Text Label 8300 3700 0    50   ~ 0
A19
$Comp
L Interface:8259 U11
U 1 1 5F84FF3C
P 5300 2650
F 0 "U11" H 5300 2650 50  0000 C CNN
F 1 "8259" H 5500 1650 50  0000 C CNN
F 2 "Package_DIP:DIP-28_W15.24mm_Socket_LongPads" H 5300 2650 50  0001 C CIN
F 3 "http://pdos.csail.mit.edu/6.828/2005/readings/hardware/8259A.pdf" H 5300 2650 50  0001 C CNN
	1    5300 2650
	1    0    0    -1  
$EndComp
$Comp
L Timer:8254 U10
U 1 1 5F850A78
P 3200 5550
F 0 "U10" H 3200 5550 50  0000 C CNN
F 1 "8254" H 3400 4650 50  0000 C CNN
F 2 "Package_DIP:DIP-24_W15.24mm_Socket_LongPads" H 3250 5800 50  0001 C CNN
F 3 "http://www.scs.stanford.edu/10wi-cs140/pintos/specs/8254.pdf" H 2750 6450 50  0001 C CNN
	1    3200 5550
	1    0    0    -1  
$EndComp
$Comp
L Oscillator:CXO_DIP14 X1
U 1 1 5F8530AE
P 4850 5450
F 0 "X1" H 4750 5150 50  0000 R CNN
F 1 "1 MHz" H 4800 5750 50  0000 R CNN
F 2 "Oscillator:Oscillator_DIP-14" H 5300 5100 50  0001 C CNN
F 3 "http://cdn-reichelt.de/documents/datenblatt/B400/OSZI.pdf" H 4750 5450 50  0001 C CNN
	1    4850 5450
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR032
U 1 1 5F85463D
P 3200 6550
F 0 "#PWR032" H 3200 6300 50  0001 C CNN
F 1 "GND" H 3205 6377 50  0000 C CNN
F 2 "" H 3200 6550 50  0001 C CNN
F 3 "" H 3200 6550 50  0001 C CNN
	1    3200 6550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR035
U 1 1 5F8547DF
P 4850 5750
F 0 "#PWR035" H 4850 5500 50  0001 C CNN
F 1 "GND" H 4855 5577 50  0000 C CNN
F 2 "" H 4850 5750 50  0001 C CNN
F 3 "" H 4850 5750 50  0001 C CNN
	1    4850 5750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR037
U 1 1 5F854C80
P 5300 3750
F 0 "#PWR037" H 5300 3500 50  0001 C CNN
F 1 "GND" H 5305 3577 50  0000 C CNN
F 2 "" H 5300 3750 50  0001 C CNN
F 3 "" H 5300 3750 50  0001 C CNN
	1    5300 3750
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR034
U 1 1 5F855189
P 4850 5150
F 0 "#PWR034" H 4850 5000 50  0001 C CNN
F 1 "VCC" H 4865 5323 50  0000 C CNN
F 2 "" H 4850 5150 50  0001 C CNN
F 3 "" H 4850 5150 50  0001 C CNN
	1    4850 5150
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR031
U 1 1 5F85532E
P 3200 4550
F 0 "#PWR031" H 3200 4400 50  0001 C CNN
F 1 "VCC" H 3215 4723 50  0000 C CNN
F 2 "" H 3200 4550 50  0001 C CNN
F 3 "" H 3200 4550 50  0001 C CNN
	1    3200 4550
	1    0    0    -1  
$EndComp
Wire Wire Line
	2500 6250 2600 6250
Wire Wire Line
	2100 6050 2600 6050
Wire Wire Line
	2100 5950 2600 5950
Wire Wire Line
	2300 5850 2600 5850
Wire Wire Line
	2500 5750 2600 5750
Wire Wire Line
	2400 4850 2600 4850
Wire Wire Line
	2400 4950 2600 4950
Wire Wire Line
	2400 5050 2600 5050
Wire Wire Line
	2400 5150 2600 5150
Wire Wire Line
	2400 5250 2600 5250
Wire Wire Line
	2400 5350 2600 5350
Wire Wire Line
	2400 5450 2600 5450
Wire Wire Line
	2400 5550 2600 5550
Wire Wire Line
	4500 1850 4700 1850
Wire Wire Line
	4500 1950 4700 1950
Wire Wire Line
	4500 2050 4700 2050
Wire Wire Line
	4500 2150 4700 2150
Wire Wire Line
	4500 2250 4700 2250
Wire Wire Line
	4500 2350 4700 2350
Wire Wire Line
	4500 2450 4700 2450
Wire Wire Line
	4500 2550 4700 2550
Wire Wire Line
	6350 1850 5900 1850
Wire Wire Line
	6000 1950 5900 1950
Wire Wire Line
	6350 2050 5900 2050
Wire Wire Line
	5900 2150 6000 2150
Wire Wire Line
	6350 2250 5900 2250
Wire Wire Line
	6000 2350 5900 2350
Text GLabel 6350 1850 2    50   Input ~ 0
IRQ7
Text GLabel 6000 1950 2    50   Input ~ 0
IRQ6
Text GLabel 6350 2050 2    50   Input ~ 0
IRQ5
Text GLabel 6000 2150 2    50   Input ~ 0
IRQ4
Text GLabel 6350 2250 2    50   Input ~ 0
IRQ3
Text GLabel 6000 2350 2    50   Input ~ 0
IRQ2
Wire Wire Line
	5900 3150 6250 3150
Wire Wire Line
	6250 3150 6250 3050
$Comp
L power:VCC #PWR036
U 1 1 5F88937D
P 5300 1550
F 0 "#PWR036" H 5300 1400 50  0001 C CNN
F 1 "VCC" H 5315 1723 50  0000 C CNN
F 2 "" H 5300 1550 50  0001 C CNN
F 3 "" H 5300 1550 50  0001 C CNN
	1    5300 1550
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR039
U 1 1 5F8899AD
P 6250 3050
F 0 "#PWR039" H 6250 2900 50  0001 C CNN
F 1 "VCC" H 6265 3223 50  0000 C CNN
F 2 "" H 6250 3050 50  0001 C CNN
F 3 "" H 6250 3050 50  0001 C CNN
	1    6250 3050
	1    0    0    -1  
$EndComp
Entry Wire Line
	4500 1850 4400 1750
Entry Wire Line
	4500 1950 4400 1850
Entry Wire Line
	4500 2050 4400 1950
Entry Wire Line
	4500 2150 4400 2050
Entry Wire Line
	4500 2250 4400 2150
Entry Wire Line
	4500 2350 4400 2250
Entry Wire Line
	4500 2450 4400 2350
Entry Wire Line
	4500 2550 4400 2450
Entry Wire Line
	2400 4850 2300 4750
Entry Wire Line
	2400 4950 2300 4850
Entry Wire Line
	2400 5050 2300 4950
Entry Wire Line
	2400 5150 2300 5050
Entry Wire Line
	2400 5250 2300 5150
Entry Wire Line
	2400 5350 2300 5250
Entry Wire Line
	2400 5450 2300 5350
Entry Wire Line
	2400 5550 2300 5450
Wire Bus Line
	4400 1650 4300 1650
Wire Bus Line
	2300 4650 2200 4650
Text GLabel 4300 1650 0    50   BiDi ~ 0
D[0..15]
Text GLabel 2200 4650 0    50   BiDi ~ 0
D[0..15]
Text Label 4550 1850 0    50   ~ 0
D0
Text Label 4550 1950 0    50   ~ 0
D1
Text Label 4550 2050 0    50   ~ 0
D2
Text Label 4550 2150 0    50   ~ 0
D3
Text Label 4550 2250 0    50   ~ 0
D4
Text Label 4550 2350 0    50   ~ 0
D5
Text Label 4550 2450 0    50   ~ 0
D6
Text Label 4550 2550 0    50   ~ 0
D7
Text Label 2450 4850 0    50   ~ 0
D0
Text Label 2450 4950 0    50   ~ 0
D1
Text Label 2450 5050 0    50   ~ 0
D2
Text Label 2450 5150 0    50   ~ 0
D3
Text Label 2450 5250 0    50   ~ 0
D4
Text Label 2450 5350 0    50   ~ 0
D5
Text Label 2450 5450 0    50   ~ 0
D6
Text Label 2450 5550 0    50   ~ 0
D7
Wire Wire Line
	3800 6050 3900 6050
Wire Wire Line
	3900 6050 3900 5550
Wire Wire Line
	3800 5050 3900 5050
Connection ~ 3900 5050
Wire Wire Line
	3900 5050 3900 4750
Wire Wire Line
	3800 5550 3900 5550
Connection ~ 3900 5550
Wire Wire Line
	3900 5550 3900 5050
$Comp
L power:VCC #PWR033
U 1 1 5F899863
P 3900 4750
F 0 "#PWR033" H 3900 4600 50  0001 C CNN
F 1 "VCC" H 3915 4923 50  0000 C CNN
F 2 "" H 3900 4750 50  0001 C CNN
F 3 "" H 3900 4750 50  0001 C CNN
	1    3900 4750
	1    0    0    -1  
$EndComp
Wire Wire Line
	3800 4950 4100 4950
Wire Wire Line
	4100 4950 4100 5450
Wire Wire Line
	4100 5950 3800 5950
Wire Wire Line
	3800 5450 4100 5450
Connection ~ 4100 5450
Wire Wire Line
	4100 5450 4100 5950
Wire Wire Line
	4550 5450 4100 5450
Wire Wire Line
	3800 5150 4300 5150
Wire Wire Line
	4300 5150 4300 4350
Wire Wire Line
	4300 4350 6450 4350
Wire Wire Line
	6450 4350 6450 2550
Wire Wire Line
	5900 2550 6450 2550
Wire Wire Line
	3800 5650 4400 5650
Wire Wire Line
	4400 5650 4400 4450
Wire Wire Line
	4400 4450 6550 4450
Wire Wire Line
	6550 4450 6550 2450
Wire Wire Line
	5900 2450 6550 2450
Wire Wire Line
	3800 6150 4000 6150
Text GLabel 4000 6150 2    50   Output ~ 0
NMI
Wire Wire Line
	4700 2750 4500 2750
Wire Wire Line
	4400 2950 4700 2950
Wire Wire Line
	4600 3050 4700 3050
Wire Wire Line
	4400 3150 4700 3150
Wire Wire Line
	4600 3350 4700 3350
Wire Wire Line
	4400 3450 4700 3450
Text GLabel 4600 3350 0    50   Output ~ 0
INT
Text GLabel 4400 3450 0    50   Input ~ 0
~INTA
Text GLabel 4400 2950 0    50   Input ~ 0
~IO1
Text GLabel 4600 3050 0    50   Input ~ 0
~WR
Text GLabel 4400 3150 0    50   Input ~ 0
~RD
Text GLabel 2500 5750 0    50   Input ~ 0
~RD
Text GLabel 2300 5850 0    50   Input ~ 0
~WR
Text GLabel 2500 6250 0    50   Input ~ 0
~IO0
$Comp
L power:VCC #PWR0101
U 1 1 5F7C1C78
P 5150 5450
F 0 "#PWR0101" H 5150 5300 50  0001 C CNN
F 1 "VCC" H 5165 5623 50  0000 C CNN
F 2 "" H 5150 5450 50  0001 C CNN
F 3 "" H 5150 5450 50  0001 C CNN
	1    5150 5450
	0    1    1    0   
$EndComp
Entry Wire Line
	2100 5950 2000 5850
Entry Wire Line
	2100 6050 2000 5950
Text Label 2400 5950 0    50   ~ 0
A1
Text Label 2400 6050 0    50   ~ 0
A2
Wire Bus Line
	2000 5800 1900 5800
Text GLabel 1900 5800 0    50   Input ~ 0
A[0..19]
Text Label 4550 2750 0    50   ~ 0
A1
Entry Wire Line
	4500 2750 4400 2650
Wire Bus Line
	4400 2650 4350 2650
Text GLabel 4350 2650 0    50   Input ~ 0
A[0..19]
NoConn ~ 5900 2750
NoConn ~ 5900 2850
NoConn ~ 5900 2950
Wire Bus Line
	2000 5800 2000 5950
Wire Bus Line
	8150 2300 8150 3600
Wire Bus Line
	4400 1650 4400 2450
Wire Bus Line
	2300 4650 2300 5450
$EndSCHEMATC