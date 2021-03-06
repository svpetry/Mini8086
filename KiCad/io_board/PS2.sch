EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 3 8
Title "Mini8086 I/O board"
Date "2020-11-05"
Rev "1.0"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L MCU_Intel:8040 U5
U 1 1 5F80E5BD
P 7450 3600
F 0 "U5" H 7450 3600 50  0000 C CNN
F 1 "8042" H 7450 3450 50  0000 C CNN
F 2 "Package_DIP:DIP-40_W15.24mm_Socket_LongPads" H 7450 3800 50  0001 C CNN
F 3 "" H 7450 3800 50  0001 C CNN
	1    7450 3600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR016
U 1 1 5F8C40E2
P 7450 5100
F 0 "#PWR016" H 7450 4850 50  0001 C CNN
F 1 "GND" H 7455 4927 50  0000 C CNN
F 2 "" H 7450 5100 50  0001 C CNN
F 3 "" H 7450 5100 50  0001 C CNN
	1    7450 5100
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR015
U 1 1 5F8C4260
P 7450 2100
F 0 "#PWR015" H 7450 1950 50  0001 C CNN
F 1 "VCC" H 7465 2273 50  0000 C CNN
F 2 "" H 7450 2100 50  0001 C CNN
F 3 "" H 7450 2100 50  0001 C CNN
	1    7450 2100
	1    0    0    -1  
$EndComp
Wire Wire Line
	6600 2400 6750 2400
Text GLabel 6600 2400 0    50   Input ~ 0
~RESET
$Comp
L 74xx:SN74LS07N U3
U 2 1 5F94362B
P 4700 4700
F 0 "U3" H 4700 4383 50  0000 C CNN
F 1 "74HC07" H 4700 4474 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 4700 4700 50  0001 C CNN
F 3 "www.ti.com/lit/ds/symlink/sn74ls07.pdf" H 4700 4700 50  0001 C CNN
	2    4700 4700
	-1   0    0    1   
$EndComp
$Comp
L 74xx:SN74LS07N U3
U 1 1 5F942AA1
P 4700 4100
F 0 "U3" H 4700 3783 50  0000 C CNN
F 1 "74HC07" H 4700 3874 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 4700 4100 50  0001 C CNN
F 3 "www.ti.com/lit/ds/symlink/sn74ls07.pdf" H 4700 4100 50  0001 C CNN
	1    4700 4100
	-1   0    0    1   
$EndComp
Wire Wire Line
	6750 4100 5850 4100
Wire Wire Line
	5250 4100 5000 4100
Wire Wire Line
	6750 4200 5850 4200
Wire Wire Line
	5850 4200 5850 4700
Wire Wire Line
	5850 4700 5000 4700
Wire Wire Line
	4400 4100 4300 4100
Wire Wire Line
	6750 4700 5950 4700
Wire Wire Line
	5950 4700 5950 5100
Wire Wire Line
	4300 5100 4300 4700
Wire Wire Line
	4300 4700 4400 4700
Wire Wire Line
	4300 4100 4300 3600
Wire Wire Line
	4300 3600 5950 3600
Wire Wire Line
	5950 3600 5950 4600
Wire Wire Line
	5950 4600 6750 4600
Connection ~ 4300 4100
NoConn ~ 8150 3700
Wire Wire Line
	8900 4800 8150 4800
Wire Wire Line
	8150 4600 8600 4600
Wire Wire Line
	8600 4600 8600 5100
Wire Wire Line
	8600 5100 9650 5100
Wire Wire Line
	9650 5100 9650 4800
Wire Wire Line
	9650 4800 9500 4800
Wire Wire Line
	9650 4800 9800 4800
Connection ~ 9650 4800
Text GLabel 9800 4800 2    50   Input ~ 0
PCLK
NoConn ~ 6750 4000
NoConn ~ 6750 3800
NoConn ~ 6750 3700
NoConn ~ 6750 3600
NoConn ~ 6750 3500
Wire Wire Line
	8150 2400 8300 2400
Wire Wire Line
	8300 2400 8300 2100
Wire Wire Line
	8150 2600 8300 2600
$Comp
L power:VCC #PWR017
U 1 1 5F9531F0
P 8300 2100
F 0 "#PWR017" H 8300 1950 50  0001 C CNN
F 1 "VCC" H 8315 2273 50  0000 C CNN
F 2 "" H 8300 2100 50  0001 C CNN
F 3 "" H 8300 2100 50  0001 C CNN
	1    8300 2100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR018
U 1 1 5F954519
P 8300 2600
F 0 "#PWR018" H 8300 2350 50  0001 C CNN
F 1 "GND" H 8305 2427 50  0000 C CNN
F 2 "" H 8300 2600 50  0001 C CNN
F 3 "" H 8300 2600 50  0001 C CNN
	1    8300 2600
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR019
U 1 1 5F954B8E
P 8300 4300
F 0 "#PWR019" H 8300 4150 50  0001 C CNN
F 1 "VCC" H 8315 4473 50  0000 C CNN
F 2 "" H 8300 4300 50  0001 C CNN
F 3 "" H 8300 4300 50  0001 C CNN
	1    8300 4300
	0    1    1    0   
$EndComp
Wire Wire Line
	8300 4300 8150 4300
$Comp
L power:VCC #PWR014
U 1 1 5F955BD6
P 6600 4400
F 0 "#PWR014" H 6600 4250 50  0001 C CNN
F 1 "VCC" H 6615 4573 50  0000 C CNN
F 2 "" H 6600 4400 50  0001 C CNN
F 3 "" H 6600 4400 50  0001 C CNN
	1    6600 4400
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6600 4400 6750 4400
Wire Wire Line
	8150 4000 8300 4000
Wire Wire Line
	8150 4100 8500 4100
Text GLabel 8300 4000 2    50   Input ~ 0
~RD
Text GLabel 8500 4100 2    50   Input ~ 0
~WR
Text GLabel 6600 4800 0    50   Input ~ 0
~CS_8042
Wire Wire Line
	6600 4800 6750 4800
NoConn ~ 6750 2600
NoConn ~ 6750 2700
NoConn ~ 6750 2800
NoConn ~ 6750 2900
NoConn ~ 6750 3000
NoConn ~ 6750 3100
NoConn ~ 6750 3200
NoConn ~ 6750 3300
Wire Wire Line
	8550 2800 8150 2800
Wire Wire Line
	8150 2900 8550 2900
Wire Wire Line
	8550 3000 8150 3000
Wire Wire Line
	8150 3100 8550 3100
Wire Wire Line
	8550 3200 8150 3200
Wire Wire Line
	8550 3300 8150 3300
Wire Wire Line
	8150 3400 8550 3400
Wire Wire Line
	8550 3500 8150 3500
Entry Wire Line
	8550 2800 8650 2700
Entry Wire Line
	8550 2900 8650 2800
Entry Wire Line
	8550 3000 8650 2900
Entry Wire Line
	8550 3100 8650 3000
Entry Wire Line
	8550 3200 8650 3100
Entry Wire Line
	8550 3300 8650 3200
Entry Wire Line
	8550 3400 8650 3300
Entry Wire Line
	8550 3500 8650 3400
Wire Bus Line
	8650 2650 8800 2650
Text GLabel 8800 2650 2    50   BiDi ~ 0
D[0..7]
Text Label 8250 2800 0    50   ~ 0
D0
Text Label 8250 2900 0    50   ~ 0
D1
Text Label 8250 3000 0    50   ~ 0
D2
Text Label 8250 3100 0    50   ~ 0
D3
Text Label 8250 3200 0    50   ~ 0
D4
Text Label 8250 3300 0    50   ~ 0
D5
Text Label 8250 3400 0    50   ~ 0
D6
Text Label 8250 3500 0    50   ~ 0
D7
$Comp
L Connector:Mini-DIN-6 J2
U 1 1 5F96756C
P 2250 4600
F 0 "J2" H 2250 4967 50  0000 C CNN
F 1 "Keyboard" H 2250 4876 50  0000 C CNN
F 2 "Mini8086:Mini_din6" H 2250 4600 50  0001 C CNN
F 3 "http://service.powerdynamics.com/ec/Catalog17/Section%2011.pdf" H 2250 4600 50  0001 C CNN
	1    2250 4600
	1    0    0    -1  
$EndComp
Text Label 3750 4100 0    50   ~ 0
KBD_CLK
Text Label 3750 4700 0    50   ~ 0
KBD_DATA
$Comp
L Device:C C9
U 1 1 5F97297F
P 3300 5050
F 0 "C9" H 3415 5096 50  0000 L CNN
F 1 "47p" H 3415 5005 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 3338 4900 50  0001 C CNN
F 3 "~" H 3300 5050 50  0001 C CNN
	1    3300 5050
	1    0    0    -1  
$EndComp
$Comp
L Device:C C8
U 1 1 5F972FF2
P 2900 5050
F 0 "C8" H 3015 5096 50  0000 L CNN
F 1 "47p" H 3015 5005 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 2938 4900 50  0001 C CNN
F 3 "~" H 2900 5050 50  0001 C CNN
	1    2900 5050
	1    0    0    -1  
$EndComp
Wire Wire Line
	4300 5100 5950 5100
Connection ~ 4300 4700
Wire Wire Line
	3600 4300 3600 4100
Wire Wire Line
	3600 4100 4300 4100
Wire Wire Line
	2900 4900 2900 4700
Connection ~ 2900 4300
Wire Wire Line
	2900 4300 3600 4300
Wire Wire Line
	3300 4900 3300 4700
Connection ~ 3300 4700
Wire Wire Line
	3300 4700 4300 4700
Wire Wire Line
	2900 5200 2900 5350
Wire Wire Line
	2900 5350 3300 5350
Wire Wire Line
	3300 5350 3300 5200
Wire Wire Line
	3300 5350 3300 5450
Connection ~ 3300 5350
$Comp
L power:GND #PWR013
U 1 1 5F987EA0
P 3300 5450
F 0 "#PWR013" H 3300 5200 50  0001 C CNN
F 1 "GND" H 3305 5277 50  0000 C CNN
F 2 "" H 3300 5450 50  0001 C CNN
F 3 "" H 3300 5450 50  0001 C CNN
	1    3300 5450
	1    0    0    -1  
$EndComp
Connection ~ 2900 5350
$Comp
L Device:C C7
U 1 1 5F990A92
P 1800 5050
F 0 "C7" H 1915 5096 50  0000 L CNN
F 1 "47p" H 1915 5005 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 1838 4900 50  0001 C CNN
F 3 "~" H 1800 5050 50  0001 C CNN
	1    1800 5050
	1    0    0    -1  
$EndComp
Wire Wire Line
	1800 5200 1800 5350
$Comp
L power:VCC #PWR012
U 1 1 5F993993
P 1800 3650
F 0 "#PWR012" H 1800 3500 50  0001 C CNN
F 1 "VCC" H 1815 3823 50  0000 C CNN
F 2 "" H 1800 3650 50  0001 C CNN
F 3 "" H 1800 3650 50  0001 C CNN
	1    1800 3650
	1    0    0    -1  
$EndComp
$Comp
L Device:R R4
U 1 1 5F975524
P 2900 4050
F 0 "R4" H 2970 4096 50  0000 L CNN
F 1 "6K8" H 2970 4005 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 2830 4050 50  0001 C CNN
F 3 "~" H 2900 4050 50  0001 C CNN
	1    2900 4050
	1    0    0    -1  
$EndComp
$Comp
L Device:R R5
U 1 1 5F9770E1
P 3300 4050
F 0 "R5" H 3370 4096 50  0000 L CNN
F 1 "6K8" H 3370 4005 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 3230 4050 50  0001 C CNN
F 3 "~" H 3300 4050 50  0001 C CNN
	1    3300 4050
	1    0    0    -1  
$EndComp
Wire Wire Line
	3300 4200 3300 4600
Wire Wire Line
	2900 4200 2900 4300
Wire Wire Line
	2900 3900 2900 3800
Wire Wire Line
	2900 3800 1800 3800
Connection ~ 1800 3800
Wire Wire Line
	1800 3800 1800 3650
Wire Wire Line
	3300 3900 3300 3800
Wire Wire Line
	3300 3800 2900 3800
Connection ~ 2900 3800
$Comp
L 74xx:74HC04 U4
U 1 1 5F8FBE53
P 5550 4100
F 0 "U4" H 5550 3783 50  0000 C CNN
F 1 "74HCT04" H 5550 3874 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 5550 4100 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 5550 4100 50  0001 C CNN
	1    5550 4100
	-1   0    0    1   
$EndComp
$Comp
L 74xx:74HC04 U4
U 2 1 5F8FD793
P 9200 4800
F 0 "U4" H 9200 4483 50  0000 C CNN
F 1 "74HCT04" H 9200 4574 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 9200 4800 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 9200 4800 50  0001 C CNN
	2    9200 4800
	-1   0    0    1   
$EndComp
$Comp
L 74xx:SN74LS07N U3
U 7 1 5FABB725
P 5000 1800
F 0 "U3" H 5230 1846 50  0000 L CNN
F 1 "74HC07" H 5230 1755 50  0000 L CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 5000 1800 50  0001 C CNN
F 3 "www.ti.com/lit/ds/symlink/sn74ls07.pdf" H 5000 1800 50  0001 C CNN
	7    5000 1800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR041
U 1 1 5FABDAD2
P 5000 2300
F 0 "#PWR041" H 5000 2050 50  0001 C CNN
F 1 "GND" H 5005 2127 50  0000 C CNN
F 2 "" H 5000 2300 50  0001 C CNN
F 3 "" H 5000 2300 50  0001 C CNN
	1    5000 2300
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR031
U 1 1 5FABE199
P 5000 1300
F 0 "#PWR031" H 5000 1150 50  0001 C CNN
F 1 "VCC" H 5015 1473 50  0000 C CNN
F 2 "" H 5000 1300 50  0001 C CNN
F 3 "" H 5000 1300 50  0001 C CNN
	1    5000 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	8150 3900 8500 3900
Wire Wire Line
	6750 3900 6600 3900
Text GLabel 6600 3900 0    50   Output ~ 0
IRQ1
Entry Wire Line
	8500 3900 8600 3800
Wire Bus Line
	8600 3800 8600 3700
Wire Bus Line
	8600 3700 8700 3700
Text GLabel 8700 3700 2    50   Input ~ 0
A[0..19]
Text Label 8300 3900 0    50   ~ 0
A2
Text Label 6200 4100 0    50   ~ 0
KCLK_OUT
Text Label 6200 4200 0    50   ~ 0
KDATA_OUT
Text Label 8300 4800 0    50   ~ 0
~PCLK
Wire Wire Line
	1800 5350 2250 5350
Wire Wire Line
	1800 3800 1800 4150
Wire Wire Line
	2550 4700 2900 4700
Connection ~ 2900 4700
Wire Wire Line
	2900 4700 2900 4300
Wire Wire Line
	1950 4700 1950 4900
Wire Wire Line
	1950 4900 2250 4900
Wire Wire Line
	2250 4900 2250 5350
Connection ~ 2250 5350
Wire Wire Line
	2250 5350 2900 5350
Wire Wire Line
	2550 4600 3300 4600
Connection ~ 3300 4600
Wire Wire Line
	3300 4600 3300 4700
Wire Wire Line
	2550 4500 2550 4150
Wire Wire Line
	2550 4150 1800 4150
Connection ~ 1800 4150
Wire Wire Line
	1800 4150 1800 4900
NoConn ~ 1950 4600
NoConn ~ 1950 4500
Text Notes 1400 3300 0    50   ~ 0
Attention: Mini-DIN 6 footprint pin numbers are wrong.\n
Wire Bus Line
	8650 2650 8650 3400
$EndSCHEMATC
