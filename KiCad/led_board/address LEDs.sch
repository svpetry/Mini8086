EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 4
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
L 74xx:74HC245 U1
U 1 1 5FDA4FA0
P 1950 1700
F 0 "U1" H 1700 1000 50  0000 C CNN
F 1 "74HC245" H 2200 1000 50  0000 C CNN
F 2 "Package_SO:SO-20_12.8x7.5mm_P1.27mm" H 1950 1700 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC245" H 1950 1700 50  0001 C CNN
F 4 "C5625" H 1950 1700 50  0001 C CNN "LCSC"
	1    1950 1700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR016
U 1 1 5FDA6CF0
P 1950 2500
F 0 "#PWR016" H 1950 2250 50  0001 C CNN
F 1 "GND" H 1955 2327 50  0000 C CNN
F 2 "" H 1950 2500 50  0001 C CNN
F 3 "" H 1950 2500 50  0001 C CNN
	1    1950 2500
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR015
U 1 1 5FDA6E16
P 1950 900
F 0 "#PWR015" H 1950 750 50  0001 C CNN
F 1 "VCC" H 1965 1073 50  0000 C CNN
F 2 "" H 1950 900 50  0001 C CNN
F 3 "" H 1950 900 50  0001 C CNN
	1    1950 900 
	1    0    0    -1  
$EndComp
Wire Wire Line
	1450 2200 1400 2200
Wire Wire Line
	1400 2200 1400 2500
$Comp
L power:GND #PWR09
U 1 1 5FDA7067
P 1400 2500
F 0 "#PWR09" H 1400 2250 50  0001 C CNN
F 1 "GND" H 1405 2327 50  0000 C CNN
F 2 "" H 1400 2500 50  0001 C CNN
F 3 "" H 1400 2500 50  0001 C CNN
	1    1400 2500
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR012
U 1 1 5FDA7471
P 1450 2100
F 0 "#PWR012" H 1450 1950 50  0001 C CNN
F 1 "VCC" V 1465 2227 50  0000 L CNN
F 2 "" H 1450 2100 50  0001 C CNN
F 3 "" H 1450 2100 50  0001 C CNN
	1    1450 2100
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1250 1200 1450 1200
Wire Wire Line
	1250 1300 1450 1300
Wire Wire Line
	1250 1400 1450 1400
Wire Wire Line
	1250 1500 1450 1500
Wire Wire Line
	1250 1600 1450 1600
Wire Wire Line
	1250 1700 1450 1700
Wire Wire Line
	1250 1800 1450 1800
Wire Wire Line
	1250 1900 1450 1900
Entry Wire Line
	1250 1200 1150 1100
Entry Wire Line
	1250 1300 1150 1200
Entry Wire Line
	1250 1400 1150 1300
Entry Wire Line
	1250 1500 1150 1400
Entry Wire Line
	1250 1600 1150 1500
Entry Wire Line
	1250 1700 1150 1600
Entry Wire Line
	1250 1800 1150 1700
Entry Wire Line
	1250 1900 1150 1800
Wire Bus Line
	1150 1050 1050 1050
Text GLabel 1050 1050 0    50   Input ~ 0
A[0..19]
Text Label 1300 1200 0    50   ~ 0
A0
Text Label 1300 1300 0    50   ~ 0
A1
Text Label 1300 1400 0    50   ~ 0
A2
Text Label 1300 1500 0    50   ~ 0
A3
Text Label 1300 1600 0    50   ~ 0
A4
Text Label 1300 1700 0    50   ~ 0
A5
Text Label 1300 1800 0    50   ~ 0
A6
Text Label 1300 1900 0    50   ~ 0
A7
$Comp
L Device:LED D1
U 1 1 5FDAAE9A
P 2650 2050
F 0 "D1" V 2689 1932 50  0000 R CNN
F 1 "A7" V 2598 1932 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 2650 2050 50  0001 C CNN
F 3 "~" H 2650 2050 50  0001 C CNN
	1    2650 2050
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D4
U 1 1 5FDAC436
P 3000 2050
F 0 "D4" V 3039 1932 50  0000 R CNN
F 1 "A6" V 2948 1932 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 3000 2050 50  0001 C CNN
F 3 "~" H 3000 2050 50  0001 C CNN
	1    3000 2050
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D7
U 1 1 5FDAC98F
P 3350 2050
F 0 "D7" V 3389 1932 50  0000 R CNN
F 1 "A5" V 3298 1932 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 3350 2050 50  0001 C CNN
F 3 "~" H 3350 2050 50  0001 C CNN
	1    3350 2050
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D10
U 1 1 5FDACDDA
P 3700 2050
F 0 "D10" V 3739 1932 50  0000 R CNN
F 1 "A4" V 3648 1932 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 3700 2050 50  0001 C CNN
F 3 "~" H 3700 2050 50  0001 C CNN
	1    3700 2050
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D13
U 1 1 5FDAD155
P 4050 2050
F 0 "D13" V 4089 1932 50  0000 R CNN
F 1 "A3" V 3998 1932 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 4050 2050 50  0001 C CNN
F 3 "~" H 4050 2050 50  0001 C CNN
	1    4050 2050
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D16
U 1 1 5FDAD528
P 4400 2050
F 0 "D16" V 4439 1932 50  0000 R CNN
F 1 "A2" V 4348 1932 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 4400 2050 50  0001 C CNN
F 3 "~" H 4400 2050 50  0001 C CNN
	1    4400 2050
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D19
U 1 1 5FDAD8D7
P 4750 2050
F 0 "D19" V 4789 1932 50  0000 R CNN
F 1 "A1" V 4698 1932 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 4750 2050 50  0001 C CNN
F 3 "~" H 4750 2050 50  0001 C CNN
	1    4750 2050
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D22
U 1 1 5FDADC7E
P 5100 2050
F 0 "D22" V 5139 1932 50  0000 R CNN
F 1 "A0" V 5048 1932 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 5100 2050 50  0001 C CNN
F 3 "~" H 5100 2050 50  0001 C CNN
	1    5100 2050
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2450 1900 2650 1900
Wire Wire Line
	2450 1800 3000 1800
Wire Wire Line
	3000 1800 3000 1900
Wire Wire Line
	2450 1700 3350 1700
Wire Wire Line
	3350 1700 3350 1900
Wire Wire Line
	2450 1600 3700 1600
Wire Wire Line
	3700 1600 3700 1900
Wire Wire Line
	2450 1500 4050 1500
Wire Wire Line
	4050 1500 4050 1900
Wire Wire Line
	2450 1400 4400 1400
Wire Wire Line
	4400 1400 4400 1900
Wire Wire Line
	4750 1300 4750 1900
Wire Wire Line
	2450 1300 4750 1300
Wire Wire Line
	2450 1200 5100 1200
Wire Wire Line
	5100 1200 5100 1900
$Comp
L Device:R R22
U 1 1 5FDB076E
P 5100 2350
F 0 "R22" H 5170 2396 50  0000 L CNN
F 1 "300" H 5170 2305 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 5030 2350 50  0001 C CNN
F 3 "~" H 5100 2350 50  0001 C CNN
	1    5100 2350
	1    0    0    -1  
$EndComp
$Comp
L Device:R R19
U 1 1 5FDB0E6F
P 4750 2350
F 0 "R19" H 4820 2396 50  0000 L CNN
F 1 "300" H 4820 2305 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 4680 2350 50  0001 C CNN
F 3 "~" H 4750 2350 50  0001 C CNN
	1    4750 2350
	1    0    0    -1  
$EndComp
$Comp
L Device:R R16
U 1 1 5FDB0FDE
P 4400 2350
F 0 "R16" H 4470 2396 50  0000 L CNN
F 1 "300" H 4470 2305 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 4330 2350 50  0001 C CNN
F 3 "~" H 4400 2350 50  0001 C CNN
	1    4400 2350
	1    0    0    -1  
$EndComp
$Comp
L Device:R R13
U 1 1 5FDB110D
P 4050 2350
F 0 "R13" H 4120 2396 50  0000 L CNN
F 1 "300" H 4120 2305 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 3980 2350 50  0001 C CNN
F 3 "~" H 4050 2350 50  0001 C CNN
	1    4050 2350
	1    0    0    -1  
$EndComp
$Comp
L Device:R R7
U 1 1 5FDB135B
P 3350 2350
F 0 "R7" H 3420 2396 50  0000 L CNN
F 1 "300" H 3420 2305 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 3280 2350 50  0001 C CNN
F 3 "~" H 3350 2350 50  0001 C CNN
	1    3350 2350
	1    0    0    -1  
$EndComp
$Comp
L Device:R R4
U 1 1 5FDB148A
P 3000 2350
F 0 "R4" H 3070 2396 50  0000 L CNN
F 1 "300" H 3070 2305 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 2930 2350 50  0001 C CNN
F 3 "~" H 3000 2350 50  0001 C CNN
	1    3000 2350
	1    0    0    -1  
$EndComp
$Comp
L Device:R R1
U 1 1 5FDB15FD
P 2650 2350
F 0 "R1" H 2720 2396 50  0000 L CNN
F 1 "300" H 2720 2305 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 2580 2350 50  0001 C CNN
F 3 "~" H 2650 2350 50  0001 C CNN
	1    2650 2350
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 2500 2650 2650
Wire Wire Line
	5100 2650 5100 2500
Wire Wire Line
	4750 2650 4750 2500
Connection ~ 4750 2650
Wire Wire Line
	4750 2650 5100 2650
Wire Wire Line
	4400 2650 4400 2500
Connection ~ 4400 2650
Wire Wire Line
	4400 2650 4750 2650
Wire Wire Line
	4050 2650 4050 2500
Connection ~ 4050 2650
Wire Wire Line
	4050 2650 4400 2650
Wire Wire Line
	3700 2500 3700 2650
Connection ~ 3700 2650
Wire Wire Line
	3700 2650 4050 2650
Wire Wire Line
	2650 2650 3000 2650
Wire Wire Line
	3350 2500 3350 2650
Connection ~ 3350 2650
Wire Wire Line
	3350 2650 3700 2650
Wire Wire Line
	3000 2500 3000 2650
Connection ~ 3000 2650
Wire Wire Line
	3000 2650 3350 2650
Wire Wire Line
	2650 2650 2650 2750
Connection ~ 2650 2650
$Comp
L power:GND #PWR021
U 1 1 5FDB55DC
P 2650 2750
F 0 "#PWR021" H 2650 2500 50  0001 C CNN
F 1 "GND" H 2655 2577 50  0000 C CNN
F 2 "" H 2650 2750 50  0001 C CNN
F 3 "" H 2650 2750 50  0001 C CNN
	1    2650 2750
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC245 U2
U 1 1 5FDCD5FC
P 1950 3800
F 0 "U2" H 1700 3100 50  0000 C CNN
F 1 "74HC245" H 2200 3100 50  0000 C CNN
F 2 "Package_SO:SO-20_12.8x7.5mm_P1.27mm" H 1950 3800 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC245" H 1950 3800 50  0001 C CNN
F 4 "C5625" H 1950 3800 50  0001 C CNN "LCSC"
	1    1950 3800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR018
U 1 1 5FDCD602
P 1950 4600
F 0 "#PWR018" H 1950 4350 50  0001 C CNN
F 1 "GND" H 1955 4427 50  0000 C CNN
F 2 "" H 1950 4600 50  0001 C CNN
F 3 "" H 1950 4600 50  0001 C CNN
	1    1950 4600
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR017
U 1 1 5FDCD608
P 1950 3000
F 0 "#PWR017" H 1950 2850 50  0001 C CNN
F 1 "VCC" H 1965 3173 50  0000 C CNN
F 2 "" H 1950 3000 50  0001 C CNN
F 3 "" H 1950 3000 50  0001 C CNN
	1    1950 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	1450 4300 1400 4300
Wire Wire Line
	1400 4300 1400 4600
$Comp
L power:GND #PWR010
U 1 1 5FDCD610
P 1400 4600
F 0 "#PWR010" H 1400 4350 50  0001 C CNN
F 1 "GND" H 1405 4427 50  0000 C CNN
F 2 "" H 1400 4600 50  0001 C CNN
F 3 "" H 1400 4600 50  0001 C CNN
	1    1400 4600
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR013
U 1 1 5FDCD616
P 1450 4200
F 0 "#PWR013" H 1450 4050 50  0001 C CNN
F 1 "VCC" V 1465 4327 50  0000 L CNN
F 2 "" H 1450 4200 50  0001 C CNN
F 3 "" H 1450 4200 50  0001 C CNN
	1    1450 4200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1250 3300 1450 3300
Wire Wire Line
	1250 3400 1450 3400
Wire Wire Line
	1250 3500 1450 3500
Wire Wire Line
	1250 3600 1450 3600
Wire Wire Line
	1250 3700 1450 3700
Wire Wire Line
	1250 3800 1450 3800
Wire Wire Line
	1250 3900 1450 3900
Wire Wire Line
	1250 4000 1450 4000
Entry Wire Line
	1250 3300 1150 3200
Entry Wire Line
	1250 3400 1150 3300
Entry Wire Line
	1250 3500 1150 3400
Entry Wire Line
	1250 3600 1150 3500
Entry Wire Line
	1250 3700 1150 3600
Entry Wire Line
	1250 3800 1150 3700
Entry Wire Line
	1250 3900 1150 3800
Entry Wire Line
	1250 4000 1150 3900
Wire Bus Line
	1150 3150 1050 3150
Text GLabel 1050 3150 0    50   Input ~ 0
A[0..19]
Text Label 1300 3300 0    50   ~ 0
A8
Text Label 1300 3400 0    50   ~ 0
A9
Text Label 1300 3500 0    50   ~ 0
A10
Text Label 1300 3600 0    50   ~ 0
A11
Text Label 1300 3700 0    50   ~ 0
A12
Text Label 1300 3800 0    50   ~ 0
A13
Text Label 1300 3900 0    50   ~ 0
A14
Text Label 1300 4000 0    50   ~ 0
A15
$Comp
L Device:LED D2
U 1 1 5FDCD636
P 2650 4150
F 0 "D2" V 2689 4032 50  0000 R CNN
F 1 "A15" V 2598 4032 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 2650 4150 50  0001 C CNN
F 3 "~" H 2650 4150 50  0001 C CNN
	1    2650 4150
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D5
U 1 1 5FDCD63C
P 3000 4150
F 0 "D5" V 3039 4032 50  0000 R CNN
F 1 "A14" V 2948 4032 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 3000 4150 50  0001 C CNN
F 3 "~" H 3000 4150 50  0001 C CNN
	1    3000 4150
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D8
U 1 1 5FDCD642
P 3350 4150
F 0 "D8" V 3389 4032 50  0000 R CNN
F 1 "A13" V 3298 4032 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 3350 4150 50  0001 C CNN
F 3 "~" H 3350 4150 50  0001 C CNN
	1    3350 4150
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D11
U 1 1 5FDCD648
P 3700 4150
F 0 "D11" V 3739 4032 50  0000 R CNN
F 1 "A12" V 3648 4032 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 3700 4150 50  0001 C CNN
F 3 "~" H 3700 4150 50  0001 C CNN
	1    3700 4150
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D14
U 1 1 5FDCD64E
P 4050 4150
F 0 "D14" V 4089 4032 50  0000 R CNN
F 1 "A11" V 3998 4032 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 4050 4150 50  0001 C CNN
F 3 "~" H 4050 4150 50  0001 C CNN
	1    4050 4150
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D17
U 1 1 5FDCD654
P 4400 4150
F 0 "D17" V 4439 4032 50  0000 R CNN
F 1 "A10" V 4348 4032 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 4400 4150 50  0001 C CNN
F 3 "~" H 4400 4150 50  0001 C CNN
	1    4400 4150
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D20
U 1 1 5FDCD65A
P 4750 4150
F 0 "D20" V 4789 4032 50  0000 R CNN
F 1 "A9" V 4698 4032 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 4750 4150 50  0001 C CNN
F 3 "~" H 4750 4150 50  0001 C CNN
	1    4750 4150
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D23
U 1 1 5FDCD660
P 5100 4150
F 0 "D23" V 5139 4032 50  0000 R CNN
F 1 "A8" V 5048 4032 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 5100 4150 50  0001 C CNN
F 3 "~" H 5100 4150 50  0001 C CNN
	1    5100 4150
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2450 4000 2650 4000
Wire Wire Line
	2450 3900 3000 3900
Wire Wire Line
	3000 3900 3000 4000
Wire Wire Line
	2450 3800 3350 3800
Wire Wire Line
	3350 3800 3350 4000
Wire Wire Line
	2450 3700 3700 3700
Wire Wire Line
	3700 3700 3700 4000
Wire Wire Line
	2450 3600 4050 3600
Wire Wire Line
	4050 3600 4050 4000
Wire Wire Line
	2450 3500 4400 3500
Wire Wire Line
	4400 3500 4400 4000
Wire Wire Line
	4750 3400 4750 4000
Wire Wire Line
	2450 3400 4750 3400
Wire Wire Line
	2450 3300 5100 3300
Wire Wire Line
	5100 3300 5100 4000
$Comp
L Device:R R23
U 1 1 5FDCD675
P 5100 4450
F 0 "R23" H 5170 4496 50  0000 L CNN
F 1 "300" H 5170 4405 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 5030 4450 50  0001 C CNN
F 3 "~" H 5100 4450 50  0001 C CNN
	1    5100 4450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R20
U 1 1 5FDCD67B
P 4750 4450
F 0 "R20" H 4820 4496 50  0000 L CNN
F 1 "300" H 4820 4405 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 4680 4450 50  0001 C CNN
F 3 "~" H 4750 4450 50  0001 C CNN
	1    4750 4450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R17
U 1 1 5FDCD681
P 4400 4450
F 0 "R17" H 4470 4496 50  0000 L CNN
F 1 "300" H 4470 4405 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 4330 4450 50  0001 C CNN
F 3 "~" H 4400 4450 50  0001 C CNN
	1    4400 4450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R14
U 1 1 5FDCD687
P 4050 4450
F 0 "R14" H 4120 4496 50  0000 L CNN
F 1 "300" H 4120 4405 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 3980 4450 50  0001 C CNN
F 3 "~" H 4050 4450 50  0001 C CNN
	1    4050 4450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R11
U 1 1 5FDCD68D
P 3700 4450
F 0 "R11" H 3770 4496 50  0000 L CNN
F 1 "300" H 3770 4405 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 3630 4450 50  0001 C CNN
F 3 "~" H 3700 4450 50  0001 C CNN
	1    3700 4450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R8
U 1 1 5FDCD693
P 3350 4450
F 0 "R8" H 3420 4496 50  0000 L CNN
F 1 "300" H 3420 4405 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 3280 4450 50  0001 C CNN
F 3 "~" H 3350 4450 50  0001 C CNN
	1    3350 4450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R5
U 1 1 5FDCD699
P 3000 4450
F 0 "R5" H 3070 4496 50  0000 L CNN
F 1 "300" H 3070 4405 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 2930 4450 50  0001 C CNN
F 3 "~" H 3000 4450 50  0001 C CNN
	1    3000 4450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 5FDCD69F
P 2650 4450
F 0 "R2" H 2720 4496 50  0000 L CNN
F 1 "300" H 2720 4405 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 2580 4450 50  0001 C CNN
F 3 "~" H 2650 4450 50  0001 C CNN
	1    2650 4450
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 4600 2650 4750
Wire Wire Line
	5100 4750 5100 4600
Wire Wire Line
	4750 4750 4750 4600
Connection ~ 4750 4750
Wire Wire Line
	4750 4750 5100 4750
Wire Wire Line
	4400 4750 4400 4600
Connection ~ 4400 4750
Wire Wire Line
	4400 4750 4750 4750
Wire Wire Line
	4050 4750 4050 4600
Connection ~ 4050 4750
Wire Wire Line
	4050 4750 4400 4750
Wire Wire Line
	3700 4600 3700 4750
Connection ~ 3700 4750
Wire Wire Line
	3700 4750 4050 4750
Wire Wire Line
	2650 4750 3000 4750
Wire Wire Line
	3350 4600 3350 4750
Connection ~ 3350 4750
Wire Wire Line
	3350 4750 3700 4750
Wire Wire Line
	3000 4600 3000 4750
Connection ~ 3000 4750
Wire Wire Line
	3000 4750 3350 4750
Wire Wire Line
	2650 4750 2650 4850
Connection ~ 2650 4750
$Comp
L power:GND #PWR022
U 1 1 5FDCD6BC
P 2650 4850
F 0 "#PWR022" H 2650 4600 50  0001 C CNN
F 1 "GND" H 2655 4677 50  0000 C CNN
F 2 "" H 2650 4850 50  0001 C CNN
F 3 "" H 2650 4850 50  0001 C CNN
	1    2650 4850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR020
U 1 1 5FDD8428
P 1950 6700
F 0 "#PWR020" H 1950 6450 50  0001 C CNN
F 1 "GND" H 1955 6527 50  0000 C CNN
F 2 "" H 1950 6700 50  0001 C CNN
F 3 "" H 1950 6700 50  0001 C CNN
	1    1950 6700
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR019
U 1 1 5FDD842E
P 1950 5100
F 0 "#PWR019" H 1950 4950 50  0001 C CNN
F 1 "VCC" H 1965 5273 50  0000 C CNN
F 2 "" H 1950 5100 50  0001 C CNN
F 3 "" H 1950 5100 50  0001 C CNN
	1    1950 5100
	1    0    0    -1  
$EndComp
Wire Wire Line
	1450 6400 1400 6400
Wire Wire Line
	1400 6400 1400 6700
$Comp
L power:GND #PWR011
U 1 1 5FDD8436
P 1400 6700
F 0 "#PWR011" H 1400 6450 50  0001 C CNN
F 1 "GND" H 1405 6527 50  0000 C CNN
F 2 "" H 1400 6700 50  0001 C CNN
F 3 "" H 1400 6700 50  0001 C CNN
	1    1400 6700
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR014
U 1 1 5FDD843C
P 1300 6300
F 0 "#PWR014" H 1300 6150 50  0001 C CNN
F 1 "VCC" V 1315 6427 50  0000 L CNN
F 2 "" H 1300 6300 50  0001 C CNN
F 3 "" H 1300 6300 50  0001 C CNN
	1    1300 6300
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1250 5400 1450 5400
Wire Wire Line
	1250 5500 1450 5500
Wire Wire Line
	1250 5600 1450 5600
Wire Wire Line
	1250 5700 1450 5700
Entry Wire Line
	1250 5400 1150 5300
Entry Wire Line
	1250 5500 1150 5400
Entry Wire Line
	1250 5600 1150 5500
Entry Wire Line
	1250 5700 1150 5600
Wire Bus Line
	1150 5250 1050 5250
Text GLabel 1050 5250 0    50   Input ~ 0
A[0..19]
Text Label 1300 5400 0    50   ~ 0
A16
Text Label 1300 5500 0    50   ~ 0
A17
Text Label 1300 5600 0    50   ~ 0
A18
Text Label 1300 5700 0    50   ~ 0
A19
$Comp
L Device:LED D15
U 1 1 5FDD8474
P 4050 6250
F 0 "D15" V 4089 6132 50  0000 R CNN
F 1 "A19" V 3998 6132 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 4050 6250 50  0001 C CNN
F 3 "~" H 4050 6250 50  0001 C CNN
	1    4050 6250
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D18
U 1 1 5FDD847A
P 4400 6250
F 0 "D18" V 4439 6132 50  0000 R CNN
F 1 "A18" V 4348 6132 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 4400 6250 50  0001 C CNN
F 3 "~" H 4400 6250 50  0001 C CNN
	1    4400 6250
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D21
U 1 1 5FDD8480
P 4750 6250
F 0 "D21" V 4789 6132 50  0000 R CNN
F 1 "A17" V 4698 6132 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 4750 6250 50  0001 C CNN
F 3 "~" H 4750 6250 50  0001 C CNN
	1    4750 6250
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D24
U 1 1 5FDD8486
P 5100 6250
F 0 "D24" V 5139 6132 50  0000 R CNN
F 1 "A16" V 5048 6132 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 5100 6250 50  0001 C CNN
F 3 "~" H 5100 6250 50  0001 C CNN
	1    5100 6250
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2450 5700 4050 5700
Wire Wire Line
	4050 5700 4050 6100
Wire Wire Line
	2450 5600 4400 5600
Wire Wire Line
	4400 5600 4400 6100
Wire Wire Line
	4750 5500 4750 6100
Wire Wire Line
	2450 5500 4750 5500
Wire Wire Line
	2450 5400 5100 5400
Wire Wire Line
	5100 5400 5100 6100
$Comp
L Device:R R24
U 1 1 5FDD849B
P 5100 6550
F 0 "R24" H 5170 6596 50  0000 L CNN
F 1 "300" H 5170 6505 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 5030 6550 50  0001 C CNN
F 3 "~" H 5100 6550 50  0001 C CNN
	1    5100 6550
	1    0    0    -1  
$EndComp
$Comp
L Device:R R21
U 1 1 5FDD84A1
P 4750 6550
F 0 "R21" H 4820 6596 50  0000 L CNN
F 1 "300" H 4820 6505 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 4680 6550 50  0001 C CNN
F 3 "~" H 4750 6550 50  0001 C CNN
	1    4750 6550
	1    0    0    -1  
$EndComp
$Comp
L Device:R R18
U 1 1 5FDD84A7
P 4400 6550
F 0 "R18" H 4470 6596 50  0000 L CNN
F 1 "300" H 4470 6505 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 4330 6550 50  0001 C CNN
F 3 "~" H 4400 6550 50  0001 C CNN
	1    4400 6550
	1    0    0    -1  
$EndComp
$Comp
L Device:R R15
U 1 1 5FDD84AD
P 4050 6550
F 0 "R15" H 4120 6596 50  0000 L CNN
F 1 "300" H 4120 6505 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 3980 6550 50  0001 C CNN
F 3 "~" H 4050 6550 50  0001 C CNN
	1    4050 6550
	1    0    0    -1  
$EndComp
Wire Wire Line
	5100 6850 5100 6700
Wire Wire Line
	4750 6850 4750 6700
Connection ~ 4750 6850
Wire Wire Line
	4750 6850 5100 6850
Wire Wire Line
	4400 6850 4400 6700
Connection ~ 4400 6850
Wire Wire Line
	4400 6850 4750 6850
Wire Wire Line
	4050 6850 4050 6700
Connection ~ 4050 6850
Wire Wire Line
	4050 6850 4400 6850
$Comp
L power:GND #PWR023
U 1 1 5FDD84E2
P 4050 6950
F 0 "#PWR023" H 4050 6700 50  0001 C CNN
F 1 "GND" H 4055 6777 50  0000 C CNN
F 2 "" H 4050 6950 50  0001 C CNN
F 3 "" H 4050 6950 50  0001 C CNN
	1    4050 6950
	1    0    0    -1  
$EndComp
Wire Wire Line
	4050 6850 4050 6950
NoConn ~ 2450 6100
NoConn ~ 2450 6000
NoConn ~ 2450 5900
Wire Wire Line
	1400 6400 1400 6100
Connection ~ 1400 6400
Wire Wire Line
	1450 6100 1400 6100
Connection ~ 1400 6100
Wire Wire Line
	1400 6100 1400 6000
Wire Wire Line
	1450 6000 1400 6000
Connection ~ 1400 6000
Wire Wire Line
	1400 6000 1400 5900
Wire Wire Line
	1450 5900 1400 5900
Wire Wire Line
	1450 6300 1300 6300
$Comp
L 74xx:74HC245 U3
U 1 1 5FDD8422
P 1950 5900
F 0 "U3" H 1700 5200 50  0000 C CNN
F 1 "74HC245" H 2200 5200 50  0000 C CNN
F 2 "Package_SO:SO-20_12.8x7.5mm_P1.27mm" H 1950 5900 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC245" H 1950 5900 50  0001 C CNN
F 4 "C5625" H 1950 5900 50  0001 C CNN "LCSC"
	1    1950 5900
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D53
U 1 1 5FD8D3AE
P 3700 6250
F 0 "D53" V 3739 6132 50  0000 R CNN
F 1 "~BHE" V 3648 6132 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 3700 6250 50  0001 C CNN
F 3 "~" H 3700 6250 50  0001 C CNN
	1    3700 6250
	0    1    1    0   
$EndComp
$Comp
L Device:R R53
U 1 1 5FD8D3B5
P 3700 6550
F 0 "R53" H 3770 6596 50  0000 L CNN
F 1 "300" H 3770 6505 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 3630 6550 50  0001 C CNN
F 3 "~" H 3700 6550 50  0001 C CNN
	1    3700 6550
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0101
U 1 1 5FD9DDE7
P 3700 6700
F 0 "#PWR0101" H 3700 6550 50  0001 C CNN
F 1 "VCC" H 3715 6873 50  0000 C CNN
F 2 "" H 3700 6700 50  0001 C CNN
F 3 "" H 3700 6700 50  0001 C CNN
	1    3700 6700
	-1   0    0    1   
$EndComp
Wire Wire Line
	3700 6100 3700 5800
Wire Wire Line
	3700 5800 2450 5800
Wire Wire Line
	1450 5800 1200 5800
Text GLabel 1200 5800 0    50   Input ~ 0
~BHE
Wire Bus Line
	1150 5250 1150 5600
Wire Bus Line
	1150 1050 1150 1800
Wire Bus Line
	1150 3150 1150 3900
$Comp
L Device:R R10
U 1 1 5FDB122C
P 3700 2350
F 0 "R10" H 3770 2396 50  0000 L CNN
F 1 "300" H 3770 2305 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 3630 2350 50  0001 C CNN
F 3 "~" H 3700 2350 50  0001 C CNN
	1    3700 2350
	1    0    0    -1  
$EndComp
$EndSCHEMATC
