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
P 7450 3350
F 0 "U5" H 7450 3350 50  0000 C CNN
F 1 "8042" H 7450 3200 50  0000 C CNN
F 2 "Package_DIP:DIP-40_W15.24mm_Socket_LongPads" H 7450 3550 50  0001 C CNN
F 3 "" H 7450 3550 50  0001 C CNN
	1    7450 3350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR016
U 1 1 5F8C40E2
P 7450 4850
F 0 "#PWR016" H 7450 4600 50  0001 C CNN
F 1 "GND" H 7455 4677 50  0000 C CNN
F 2 "" H 7450 4850 50  0001 C CNN
F 3 "" H 7450 4850 50  0001 C CNN
	1    7450 4850
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR015
U 1 1 5F8C4260
P 7450 1850
F 0 "#PWR015" H 7450 1700 50  0001 C CNN
F 1 "VCC" H 7465 2023 50  0000 C CNN
F 2 "" H 7450 1850 50  0001 C CNN
F 3 "" H 7450 1850 50  0001 C CNN
	1    7450 1850
	1    0    0    -1  
$EndComp
Wire Wire Line
	6600 2150 6750 2150
Text GLabel 6600 2150 0    50   Input ~ 0
~RESET
$Comp
L 74xx:SN74LS07N U3
U 2 1 5F94362B
P 4700 4450
F 0 "U3" H 4700 4133 50  0000 C CNN
F 1 "74HC07" H 4700 4224 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 4700 4450 50  0001 C CNN
F 3 "www.ti.com/lit/ds/symlink/sn74ls07.pdf" H 4700 4450 50  0001 C CNN
	2    4700 4450
	-1   0    0    1   
$EndComp
$Comp
L 74xx:SN74LS07N U3
U 1 1 5F942AA1
P 4700 3850
F 0 "U3" H 4700 3533 50  0000 C CNN
F 1 "74HC07" H 4700 3624 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 4700 3850 50  0001 C CNN
F 3 "www.ti.com/lit/ds/symlink/sn74ls07.pdf" H 4700 3850 50  0001 C CNN
	1    4700 3850
	-1   0    0    1   
$EndComp
Wire Wire Line
	6750 3850 5850 3850
Wire Wire Line
	5250 3850 5000 3850
Wire Wire Line
	6750 3950 5850 3950
Wire Wire Line
	5850 3950 5850 4450
Wire Wire Line
	5850 4450 5000 4450
Wire Wire Line
	4400 3850 4300 3850
Wire Wire Line
	6750 4450 5950 4450
Wire Wire Line
	5950 4450 5950 4850
Wire Wire Line
	4300 4850 4300 4450
Wire Wire Line
	4300 4450 4400 4450
Wire Wire Line
	4300 3850 4300 3350
Wire Wire Line
	4300 3350 5950 3350
Wire Wire Line
	5950 3350 5950 4350
Wire Wire Line
	5950 4350 6750 4350
Connection ~ 4300 3850
NoConn ~ 8150 3450
Wire Wire Line
	8900 4550 8150 4550
Wire Wire Line
	8150 4350 8600 4350
Wire Wire Line
	8600 4350 8600 4850
Wire Wire Line
	8600 4850 9650 4850
Wire Wire Line
	9650 4850 9650 4550
Wire Wire Line
	9650 4550 9500 4550
Wire Wire Line
	9650 4550 9800 4550
Connection ~ 9650 4550
Text GLabel 9800 4550 2    50   Input ~ 0
PCLK
NoConn ~ 6750 3750
NoConn ~ 6750 3550
NoConn ~ 6750 3450
NoConn ~ 6750 3650
NoConn ~ 6750 3350
NoConn ~ 6750 3250
Wire Wire Line
	8150 2150 8300 2150
Wire Wire Line
	8300 2150 8300 1850
Wire Wire Line
	8150 2350 8300 2350
$Comp
L power:VCC #PWR017
U 1 1 5F9531F0
P 8300 1850
F 0 "#PWR017" H 8300 1700 50  0001 C CNN
F 1 "VCC" H 8315 2023 50  0000 C CNN
F 2 "" H 8300 1850 50  0001 C CNN
F 3 "" H 8300 1850 50  0001 C CNN
	1    8300 1850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR018
U 1 1 5F954519
P 8300 2350
F 0 "#PWR018" H 8300 2100 50  0001 C CNN
F 1 "GND" H 8305 2177 50  0000 C CNN
F 2 "" H 8300 2350 50  0001 C CNN
F 3 "" H 8300 2350 50  0001 C CNN
	1    8300 2350
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR019
U 1 1 5F954B8E
P 8300 4050
F 0 "#PWR019" H 8300 3900 50  0001 C CNN
F 1 "VCC" H 8315 4223 50  0000 C CNN
F 2 "" H 8300 4050 50  0001 C CNN
F 3 "" H 8300 4050 50  0001 C CNN
	1    8300 4050
	0    1    1    0   
$EndComp
Wire Wire Line
	8300 4050 8150 4050
$Comp
L power:VCC #PWR014
U 1 1 5F955BD6
P 6600 4150
F 0 "#PWR014" H 6600 4000 50  0001 C CNN
F 1 "VCC" H 6615 4323 50  0000 C CNN
F 2 "" H 6600 4150 50  0001 C CNN
F 3 "" H 6600 4150 50  0001 C CNN
	1    6600 4150
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6600 4150 6750 4150
Wire Wire Line
	8150 3750 8300 3750
Wire Wire Line
	8150 3850 8500 3850
Text GLabel 8300 3750 2    50   Input ~ 0
~RD
Text GLabel 8500 3850 2    50   Input ~ 0
~WR
Text GLabel 6600 4550 0    50   Input ~ 0
~CS_8042
Wire Wire Line
	6600 4550 6750 4550
NoConn ~ 6750 2350
NoConn ~ 6750 2450
NoConn ~ 6750 2550
NoConn ~ 6750 2650
NoConn ~ 6750 2750
NoConn ~ 6750 2850
NoConn ~ 6750 2950
NoConn ~ 6750 3050
Wire Wire Line
	8550 2550 8150 2550
Wire Wire Line
	8150 2650 8550 2650
Wire Wire Line
	8550 2750 8150 2750
Wire Wire Line
	8150 2850 8550 2850
Wire Wire Line
	8550 2950 8150 2950
Wire Wire Line
	8550 3050 8150 3050
Wire Wire Line
	8150 3150 8550 3150
Wire Wire Line
	8550 3250 8150 3250
Entry Wire Line
	8550 2550 8650 2450
Entry Wire Line
	8550 2650 8650 2550
Entry Wire Line
	8550 2750 8650 2650
Entry Wire Line
	8550 2850 8650 2750
Entry Wire Line
	8550 2950 8650 2850
Entry Wire Line
	8550 3050 8650 2950
Entry Wire Line
	8550 3150 8650 3050
Entry Wire Line
	8550 3250 8650 3150
Wire Bus Line
	8650 2400 8800 2400
Text GLabel 8800 2400 2    50   BiDi ~ 0
D[0..7]
Text Label 8250 2550 0    50   ~ 0
D0
Text Label 8250 2650 0    50   ~ 0
D1
Text Label 8250 2750 0    50   ~ 0
D2
Text Label 8250 2850 0    50   ~ 0
D3
Text Label 8250 2950 0    50   ~ 0
D4
Text Label 8250 3050 0    50   ~ 0
D5
Text Label 8250 3150 0    50   ~ 0
D6
Text Label 8250 3250 0    50   ~ 0
D7
$Comp
L Connector:Mini-DIN-6 J2
U 1 1 5F96756C
P 2250 4350
F 0 "J2" H 2250 4717 50  0000 C CNN
F 1 "Keyboard" H 2250 4626 50  0000 C CNN
F 2 "Mini8086:Mini_din6" H 2250 4350 50  0001 C CNN
F 3 "http://service.powerdynamics.com/ec/Catalog17/Section%2011.pdf" H 2250 4350 50  0001 C CNN
	1    2250 4350
	1    0    0    -1  
$EndComp
Text Label 3750 3850 0    50   ~ 0
KBD_CLK
Text Label 3750 4450 0    50   ~ 0
KBD_DATA
$Comp
L Device:C C9
U 1 1 5F97297F
P 3300 4800
F 0 "C9" H 3415 4846 50  0000 L CNN
F 1 "47p" H 3415 4755 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 3338 4650 50  0001 C CNN
F 3 "~" H 3300 4800 50  0001 C CNN
	1    3300 4800
	1    0    0    -1  
$EndComp
$Comp
L Device:C C8
U 1 1 5F972FF2
P 2900 4800
F 0 "C8" H 3015 4846 50  0000 L CNN
F 1 "47p" H 3015 4755 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 2938 4650 50  0001 C CNN
F 3 "~" H 2900 4800 50  0001 C CNN
	1    2900 4800
	1    0    0    -1  
$EndComp
Wire Wire Line
	4300 4850 5950 4850
Wire Wire Line
	2550 4450 3300 4450
Connection ~ 4300 4450
Wire Wire Line
	2550 4250 2900 4250
Wire Wire Line
	3600 4250 3600 3850
Wire Wire Line
	3600 3850 4300 3850
Wire Wire Line
	2900 4650 2900 4250
Connection ~ 2900 4250
Wire Wire Line
	2900 4250 3600 4250
Wire Wire Line
	3300 4650 3300 4450
Connection ~ 3300 4450
Wire Wire Line
	3300 4450 4300 4450
Wire Wire Line
	2900 4950 2900 5100
Wire Wire Line
	2900 5100 3300 5100
Wire Wire Line
	3300 5100 3300 4950
Wire Wire Line
	3300 5100 3300 5200
Connection ~ 3300 5100
$Comp
L power:GND #PWR013
U 1 1 5F987EA0
P 3300 5200
F 0 "#PWR013" H 3300 4950 50  0001 C CNN
F 1 "GND" H 3305 5027 50  0000 C CNN
F 2 "" H 3300 5200 50  0001 C CNN
F 3 "" H 3300 5200 50  0001 C CNN
	1    3300 5200
	1    0    0    -1  
$EndComp
NoConn ~ 1950 4450
NoConn ~ 1950 4250
Wire Wire Line
	2550 4350 2600 4350
Wire Wire Line
	2600 4350 2600 5100
Wire Wire Line
	2600 5100 2900 5100
Connection ~ 2900 5100
Wire Wire Line
	1950 4350 1800 4350
Wire Wire Line
	1800 4350 1800 3550
Connection ~ 1800 4350
$Comp
L Device:C C7
U 1 1 5F990A92
P 1800 4800
F 0 "C7" H 1915 4846 50  0000 L CNN
F 1 "47p" H 1915 4755 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 1838 4650 50  0001 C CNN
F 3 "~" H 1800 4800 50  0001 C CNN
	1    1800 4800
	1    0    0    -1  
$EndComp
Wire Wire Line
	1800 4350 1800 4650
Wire Wire Line
	1800 4950 1800 5100
Wire Wire Line
	1800 5100 2600 5100
Connection ~ 2600 5100
$Comp
L power:VCC #PWR012
U 1 1 5F993993
P 1800 3400
F 0 "#PWR012" H 1800 3250 50  0001 C CNN
F 1 "VCC" H 1815 3573 50  0000 C CNN
F 2 "" H 1800 3400 50  0001 C CNN
F 3 "" H 1800 3400 50  0001 C CNN
	1    1800 3400
	1    0    0    -1  
$EndComp
NoConn ~ 8150 3650
$Comp
L Device:R R4
U 1 1 5F975524
P 2900 3800
F 0 "R4" H 2970 3846 50  0000 L CNN
F 1 "6K8" H 2970 3755 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 2830 3800 50  0001 C CNN
F 3 "~" H 2900 3800 50  0001 C CNN
	1    2900 3800
	1    0    0    -1  
$EndComp
$Comp
L Device:R R5
U 1 1 5F9770E1
P 3300 3800
F 0 "R5" H 3370 3846 50  0000 L CNN
F 1 "6K8" H 3370 3755 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 3230 3800 50  0001 C CNN
F 3 "~" H 3300 3800 50  0001 C CNN
	1    3300 3800
	1    0    0    -1  
$EndComp
Wire Wire Line
	3300 3950 3300 4450
Wire Wire Line
	2900 3950 2900 4250
Wire Wire Line
	2900 3650 2900 3550
Wire Wire Line
	2900 3550 1800 3550
Connection ~ 1800 3550
Wire Wire Line
	1800 3550 1800 3400
Wire Wire Line
	3300 3650 3300 3550
Wire Wire Line
	3300 3550 2900 3550
Connection ~ 2900 3550
$Comp
L 74xx:74HC04 U4
U 1 1 5F8FBE53
P 5550 3850
F 0 "U4" H 5550 3533 50  0000 C CNN
F 1 "74HCT04" H 5550 3624 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 5550 3850 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 5550 3850 50  0001 C CNN
	1    5550 3850
	-1   0    0    1   
$EndComp
$Comp
L 74xx:74HC04 U4
U 2 1 5F8FD793
P 9200 4550
F 0 "U4" H 9200 4233 50  0000 C CNN
F 1 "74HCT04" H 9200 4324 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 9200 4550 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 9200 4550 50  0001 C CNN
	2    9200 4550
	-1   0    0    1   
$EndComp
$Comp
L 74xx:SN74LS07N U3
U 7 1 5FABB725
P 2200 1800
F 0 "U3" H 2430 1846 50  0000 L CNN
F 1 "74HC07" H 2430 1755 50  0000 L CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 2200 1800 50  0001 C CNN
F 3 "www.ti.com/lit/ds/symlink/sn74ls07.pdf" H 2200 1800 50  0001 C CNN
	7    2200 1800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR041
U 1 1 5FABDAD2
P 2200 2300
F 0 "#PWR041" H 2200 2050 50  0001 C CNN
F 1 "GND" H 2205 2127 50  0000 C CNN
F 2 "" H 2200 2300 50  0001 C CNN
F 3 "" H 2200 2300 50  0001 C CNN
	1    2200 2300
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR031
U 1 1 5FABE199
P 2200 1300
F 0 "#PWR031" H 2200 1150 50  0001 C CNN
F 1 "VCC" H 2215 1473 50  0000 C CNN
F 2 "" H 2200 1300 50  0001 C CNN
F 3 "" H 2200 1300 50  0001 C CNN
	1    2200 1300
	1    0    0    -1  
$EndComp
Wire Bus Line
	8650 2400 8650 3150
$EndSCHEMATC
