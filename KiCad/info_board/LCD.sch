EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 2
Title "Mini8086 info board"
Date ""
Rev "1.1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L 74xx:74LS573 U2
U 1 1 5F99CF9B
P 5300 2250
F 0 "U2" H 5300 2250 50  0000 C CNN
F 1 "74HC573" H 5550 1550 50  0000 C CNN
F 2 "Package_DIP:DIP-20_W7.62mm_LongPads" H 5300 2250 50  0001 C CNN
F 3 "74xx/74hc573.pdf" H 5300 2250 50  0001 C CNN
	1    5300 2250
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS138 U1
U 1 1 5F99DE23
P 2550 2250
F 0 "U1" H 2550 2250 50  0000 C CNN
F 1 "74HC138" H 2800 1650 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm_LongPads" H 2550 2250 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS138" H 2550 2250 50  0001 C CNN
	1    2550 2250
	1    0    0    -1  
$EndComp
Wire Wire Line
	2050 1950 1850 1950
Wire Wire Line
	1850 2050 2050 2050
Wire Wire Line
	1850 2150 2050 2150
Wire Wire Line
	3700 1950 3050 1950
$Comp
L power:GND #PWR018
U 1 1 5F9A4510
P 5300 3050
F 0 "#PWR018" H 5300 2800 50  0001 C CNN
F 1 "GND" H 5305 2877 50  0000 C CNN
F 2 "" H 5300 3050 50  0001 C CNN
F 3 "" H 5300 3050 50  0001 C CNN
	1    5300 3050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR016
U 1 1 5F9A4B38
P 2550 5150
F 0 "#PWR016" H 2550 4900 50  0001 C CNN
F 1 "GND" H 2555 4977 50  0000 C CNN
F 2 "" H 2550 5150 50  0001 C CNN
F 3 "" H 2550 5150 50  0001 C CNN
	1    2550 5150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR021
U 1 1 5F9A4FBF
P 8200 3100
F 0 "#PWR021" H 8200 2850 50  0001 C CNN
F 1 "GND" H 8205 2927 50  0000 C CNN
F 2 "" H 8200 3100 50  0001 C CNN
F 3 "" H 8200 3100 50  0001 C CNN
	1    8200 3100
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR017
U 1 1 5F9A5CC1
P 5300 1450
F 0 "#PWR017" H 5300 1300 50  0001 C CNN
F 1 "VCC" H 5315 1623 50  0000 C CNN
F 2 "" H 5300 1450 50  0001 C CNN
F 3 "" H 5300 1450 50  0001 C CNN
	1    5300 1450
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR015
U 1 1 5F9A63C9
P 2550 1650
F 0 "#PWR015" H 2550 1500 50  0001 C CNN
F 1 "VCC" H 2565 1823 50  0000 C CNN
F 2 "" H 2550 1650 50  0001 C CNN
F 3 "" H 2550 1650 50  0001 C CNN
	1    2550 1650
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR020
U 1 1 5F9A6972
P 8200 1500
F 0 "#PWR020" H 8200 1350 50  0001 C CNN
F 1 "VCC" H 8215 1673 50  0000 C CNN
F 2 "" H 8200 1500 50  0001 C CNN
F 3 "" H 8200 1500 50  0001 C CNN
	1    8200 1500
	1    0    0    -1  
$EndComp
Text GLabel 3700 2750 0    50   Input ~ 0
~WR
Text GLabel 1700 2650 0    50   Input ~ 0
~IO_DBG
Wire Wire Line
	2050 2650 1700 2650
Wire Wire Line
	2050 2550 1950 2550
Wire Wire Line
	1950 2550 1950 2950
$Comp
L power:GND #PWR013
U 1 1 5F9A7B45
P 1950 2950
F 0 "#PWR013" H 1950 2700 50  0001 C CNN
F 1 "GND" H 1955 2777 50  0000 C CNN
F 2 "" H 1950 2950 50  0001 C CNN
F 3 "" H 1950 2950 50  0001 C CNN
	1    1950 2950
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR014
U 1 1 5F9A7FF1
P 2050 2450
F 0 "#PWR014" H 2050 2300 50  0001 C CNN
F 1 "VCC" V 2065 2577 50  0000 L CNN
F 2 "" H 2050 2450 50  0001 C CNN
F 3 "" H 2050 2450 50  0001 C CNN
	1    2050 2450
	0    -1   -1   0   
$EndComp
Entry Wire Line
	1850 1950 1750 1850
Entry Wire Line
	1850 2050 1750 1950
Entry Wire Line
	1850 2150 1750 2050
Text Label 1900 1950 0    50   ~ 0
A0
Text Label 1900 2050 0    50   ~ 0
A1
Text Label 1900 2150 0    50   ~ 0
A2
Wire Bus Line
	1750 1800 1650 1800
Text GLabel 1650 1800 0    50   Input ~ 0
A[0..2]
Wire Wire Line
	4600 2450 4800 2450
Wire Wire Line
	4600 2350 4800 2350
Wire Wire Line
	4600 2250 4800 2250
Wire Wire Line
	4600 2150 4800 2150
Wire Wire Line
	4600 2050 4800 2050
Wire Wire Line
	4600 1950 4800 1950
Wire Wire Line
	4600 1850 4800 1850
Wire Wire Line
	4600 1750 4800 1750
Entry Wire Line
	4600 1750 4500 1650
Entry Wire Line
	4600 1850 4500 1750
Entry Wire Line
	4600 1950 4500 1850
Entry Wire Line
	4600 2050 4500 1950
Entry Wire Line
	4600 2150 4500 2050
Entry Wire Line
	4600 2250 4500 2150
Entry Wire Line
	4600 2350 4500 2250
Entry Wire Line
	4600 2450 4500 2350
Wire Bus Line
	4500 1600 4400 1600
Text GLabel 4400 1600 0    50   Input ~ 0
D[0..7]
Text Label 4650 1750 0    50   ~ 0
D0
Text Label 4650 1850 0    50   ~ 0
D1
Text Label 4650 1950 0    50   ~ 0
D2
Text Label 4650 2050 0    50   ~ 0
D3
Text Label 4650 2150 0    50   ~ 0
D4
Text Label 4650 2250 0    50   ~ 0
D5
Text Label 4650 2350 0    50   ~ 0
D6
Text Label 4650 2450 0    50   ~ 0
D7
Wire Wire Line
	7800 2600 7100 2600
Wire Wire Line
	7100 2600 7100 1750
Wire Wire Line
	7100 1750 5800 1750
Wire Wire Line
	7800 2700 7000 2700
Wire Wire Line
	7000 2700 7000 1850
Wire Wire Line
	7000 1850 5800 1850
Wire Wire Line
	7800 2800 6900 2800
Wire Wire Line
	6900 2800 6900 1950
Wire Wire Line
	6900 1950 5800 1950
Wire Wire Line
	7800 2900 6800 2900
Wire Wire Line
	6800 2900 6800 2050
Wire Wire Line
	6800 2050 5800 2050
Wire Wire Line
	7800 1800 7600 1800
Wire Wire Line
	7600 1800 7600 2200
Wire Wire Line
	7800 2200 7600 2200
Connection ~ 7600 2200
Wire Wire Line
	7600 2200 7600 2300
Wire Wire Line
	7800 2300 7600 2300
Connection ~ 7600 2300
Wire Wire Line
	7600 2300 7600 2400
Wire Wire Line
	7800 2400 7600 2400
Connection ~ 7600 2400
Wire Wire Line
	7600 2400 7600 2500
Wire Wire Line
	7800 2500 7600 2500
Connection ~ 7600 2500
Wire Wire Line
	7600 2500 7600 3100
Wire Wire Line
	5800 2150 7200 2150
Wire Wire Line
	7200 2150 7200 1900
Wire Wire Line
	7200 1900 7800 1900
Wire Wire Line
	5800 2250 7300 2250
Wire Wire Line
	7300 2250 7300 1700
Wire Wire Line
	7300 1700 7800 1700
Wire Wire Line
	8600 2100 8800 2100
Wire Wire Line
	8800 2100 8800 3100
$Comp
L power:GND #PWR019
U 1 1 5F9B2A5B
P 7600 3100
F 0 "#PWR019" H 7600 2850 50  0001 C CNN
F 1 "GND" H 7605 2927 50  0000 C CNN
F 2 "" H 7600 3100 50  0001 C CNN
F 3 "" H 7600 3100 50  0001 C CNN
	1    7600 3100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR022
U 1 1 5F9B2E62
P 8800 3100
F 0 "#PWR022" H 8800 2850 50  0001 C CNN
F 1 "GND" H 8805 2927 50  0000 C CNN
F 2 "" H 8800 3100 50  0001 C CNN
F 3 "" H 8800 3100 50  0001 C CNN
	1    8800 3100
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR023
U 1 1 5F9B5510
P 9650 850
F 0 "#PWR023" H 9650 700 50  0001 C CNN
F 1 "VCC" H 9665 1023 50  0000 C CNN
F 2 "" H 9650 850 50  0001 C CNN
F 3 "" H 9650 850 50  0001 C CNN
	1    9650 850 
	1    0    0    -1  
$EndComp
Wire Wire Line
	9250 1300 9250 1250
$Comp
L Device:R_POT_TRIM RV1
U 1 1 5F9BE4FA
P 9250 1450
F 0 "RV1" H 9181 1496 50  0000 R CNN
F 1 "10K" H 9181 1405 50  0000 R CNN
F 2 "Potentiometer_THT:Potentiometer_Piher_PT-10-V05_Vertical" H 9250 1450 50  0001 C CNN
F 3 "~" H 9250 1450 50  0001 C CNN
	1    9250 1450
	-1   0    0    -1  
$EndComp
$Comp
L Display_Character:WC1602A DS1
U 1 1 5F986E1E
P 8200 2300
F 0 "DS1" H 8200 2300 50  0000 C CNN
F 1 "WC1602A" H 8450 1500 50  0000 C CNN
F 2 "Display:WC1602A" H 8200 1400 50  0001 C CIN
F 3 "http://www.wincomlcd.com/pdf/WC1602A-SFYLYHTC06.pdf" H 8900 2300 50  0001 C CNN
	1    8200 2300
	1    0    0    -1  
$EndComp
$Comp
L Device:C C2
U 1 1 5F98D398
P 8100 4750
F 0 "C2" H 8215 4796 50  0000 L CNN
F 1 "100n" H 8215 4705 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 8138 4600 50  0001 C CNN
F 3 "~" H 8100 4750 50  0001 C CNN
	1    8100 4750
	1    0    0    -1  
$EndComp
$Comp
L Device:C C1
U 1 1 5F98DD24
P 7650 4750
F 0 "C1" H 7765 4796 50  0000 L CNN
F 1 "100n" H 7765 4705 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 7688 4600 50  0001 C CNN
F 3 "~" H 7650 4750 50  0001 C CNN
	1    7650 4750
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C3
U 1 1 5F98E76F
P 8550 4750
F 0 "C3" H 8668 4796 50  0000 L CNN
F 1 "100u" H 8668 4705 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D5.0mm_P2.50mm" H 8588 4600 50  0001 C CNN
F 3 "~" H 8550 4750 50  0001 C CNN
	1    8550 4750
	1    0    0    -1  
$EndComp
Wire Wire Line
	7650 4900 7650 4950
Wire Wire Line
	7650 4950 8100 4950
Wire Wire Line
	8550 4950 8550 5000
Wire Wire Line
	8550 4900 8550 4950
Connection ~ 8550 4950
Wire Wire Line
	8100 4900 8100 4950
Connection ~ 8100 4950
Wire Wire Line
	8100 4950 8550 4950
Wire Wire Line
	7650 4600 7650 4550
Wire Wire Line
	7650 4550 8100 4550
Wire Wire Line
	8550 4550 8550 4600
Wire Wire Line
	8100 4600 8100 4550
Connection ~ 8100 4550
Wire Wire Line
	8100 4550 8550 4550
Wire Wire Line
	8550 4550 8550 4500
Connection ~ 8550 4550
$Comp
L power:GND #PWR025
U 1 1 5F9958E3
P 8550 5000
F 0 "#PWR025" H 8550 4750 50  0001 C CNN
F 1 "GND" H 8555 4827 50  0000 C CNN
F 2 "" H 8550 5000 50  0001 C CNN
F 3 "" H 8550 5000 50  0001 C CNN
	1    8550 5000
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR024
U 1 1 5F995D41
P 8550 4500
F 0 "#PWR024" H 8550 4350 50  0001 C CNN
F 1 "VCC" H 8565 4673 50  0000 C CNN
F 2 "" H 8550 4500 50  0001 C CNN
F 3 "" H 8550 4500 50  0001 C CNN
	1    8550 4500
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS367 U3
U 1 1 5F9A4A19
P 2550 4450
F 0 "U3" H 2550 4450 50  0000 C CNN
F 1 "74LS367" H 2750 3850 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm_LongPads" H 2550 4450 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS367" H 2550 4450 50  0001 C CNN
	1    2550 4450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR027
U 1 1 5F9A70A4
P 2550 2950
F 0 "#PWR027" H 2550 2700 50  0001 C CNN
F 1 "GND" H 2555 2777 50  0000 C CNN
F 2 "" H 2550 2950 50  0001 C CNN
F 3 "" H 2550 2950 50  0001 C CNN
	1    2550 2950
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR028
U 1 1 5F9A74F8
P 2550 3750
F 0 "#PWR028" H 2550 3600 50  0001 C CNN
F 1 "VCC" H 2565 3923 50  0000 C CNN
F 2 "" H 2550 3750 50  0001 C CNN
F 3 "" H 2550 3750 50  0001 C CNN
	1    2550 3750
	1    0    0    -1  
$EndComp
Wire Wire Line
	2050 4750 1950 4750
Wire Wire Line
	1950 4750 1950 4850
Wire Wire Line
	2050 4850 1950 4850
Connection ~ 1950 4850
Wire Wire Line
	1950 4850 1950 5150
$Comp
L power:GND #PWR026
U 1 1 5F9AA6EB
P 1950 5150
F 0 "#PWR026" H 1950 4900 50  0001 C CNN
F 1 "GND" H 1955 4977 50  0000 C CNN
F 2 "" H 1950 5150 50  0001 C CNN
F 3 "" H 1950 5150 50  0001 C CNN
	1    1950 5150
	1    0    0    -1  
$EndComp
Wire Wire Line
	2050 4050 1950 4050
Wire Wire Line
	2050 4150 1550 4150
Wire Wire Line
	2050 4250 1950 4250
Wire Wire Line
	2050 4350 1550 4350
Wire Wire Line
	2050 4450 1950 4450
Wire Wire Line
	2050 4550 1550 4550
Text GLabel 1950 4050 0    50   Input ~ 0
~RD
Text GLabel 1550 4150 0    50   Input ~ 0
~WR
Text GLabel 1950 4450 0    50   Input ~ 0
~IO
Text GLabel 1950 4250 0    50   Input ~ 0
~MEMRD
Text GLabel 1550 4350 0    50   Input ~ 0
~MEMWR
Text GLabel 1550 4550 0    50   Input ~ 0
~BHE
$Comp
L Device:R_Small R1
U 1 1 5F9C083B
P 3600 4800
F 0 "R1" H 3659 4846 50  0000 L CNN
F 1 "220" H 3659 4755 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" H 3600 4800 50  0001 C CNN
F 3 "~" H 3600 4800 50  0001 C CNN
	1    3600 4800
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D1
U 1 1 5F9C0F5E
P 3600 5150
F 0 "D1" V 3639 5032 50  0000 R CNN
F 1 "LED" V 3548 5032 50  0000 R CNN
F 2 "LED_THT:LED_D5.0mm" H 3600 5150 50  0001 C CNN
F 3 "~" H 3600 5150 50  0001 C CNN
	1    3600 5150
	0    1    1    0   
$EndComp
Wire Wire Line
	3600 5000 3600 4900
$Comp
L Device:R_Small R3
U 1 1 5F9C645D
P 3950 4800
F 0 "R3" H 4009 4846 50  0000 L CNN
F 1 "220" H 4009 4755 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" H 3950 4800 50  0001 C CNN
F 3 "~" H 3950 4800 50  0001 C CNN
	1    3950 4800
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D2
U 1 1 5F9C6463
P 3950 5150
F 0 "D2" V 3989 5032 50  0000 R CNN
F 1 "LED" V 3898 5032 50  0000 R CNN
F 2 "LED_THT:LED_D5.0mm" H 3950 5150 50  0001 C CNN
F 3 "~" H 3950 5150 50  0001 C CNN
	1    3950 5150
	0    1    1    0   
$EndComp
Wire Wire Line
	3950 5000 3950 4900
$Comp
L Device:R_Small R4
U 1 1 5F9CAF60
P 4300 4800
F 0 "R4" H 4359 4846 50  0000 L CNN
F 1 "220" H 4359 4755 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" H 4300 4800 50  0001 C CNN
F 3 "~" H 4300 4800 50  0001 C CNN
	1    4300 4800
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D3
U 1 1 5F9CAF66
P 4300 5150
F 0 "D3" V 4339 5032 50  0000 R CNN
F 1 "LED" V 4248 5032 50  0000 R CNN
F 2 "LED_THT:LED_D5.0mm" H 4300 5150 50  0001 C CNN
F 3 "~" H 4300 5150 50  0001 C CNN
	1    4300 5150
	0    1    1    0   
$EndComp
Wire Wire Line
	4300 5000 4300 4900
$Comp
L Device:R_Small R5
U 1 1 5F9CDC9E
P 4650 4800
F 0 "R5" H 4709 4846 50  0000 L CNN
F 1 "220" H 4709 4755 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" H 4650 4800 50  0001 C CNN
F 3 "~" H 4650 4800 50  0001 C CNN
	1    4650 4800
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D4
U 1 1 5F9CDCA4
P 4650 5150
F 0 "D4" V 4689 5032 50  0000 R CNN
F 1 "LED" V 4598 5032 50  0000 R CNN
F 2 "LED_THT:LED_D5.0mm" H 4650 5150 50  0001 C CNN
F 3 "~" H 4650 5150 50  0001 C CNN
	1    4650 5150
	0    1    1    0   
$EndComp
Wire Wire Line
	4650 5000 4650 4900
$Comp
L Device:R_Small R6
U 1 1 5F9D2ED5
P 5000 4800
F 0 "R6" H 5059 4846 50  0000 L CNN
F 1 "220" H 5059 4755 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" H 5000 4800 50  0001 C CNN
F 3 "~" H 5000 4800 50  0001 C CNN
	1    5000 4800
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D5
U 1 1 5F9D2EDB
P 5000 5150
F 0 "D5" V 5039 5032 50  0000 R CNN
F 1 "LED" V 4948 5032 50  0000 R CNN
F 2 "LED_THT:LED_D5.0mm" H 5000 5150 50  0001 C CNN
F 3 "~" H 5000 5150 50  0001 C CNN
	1    5000 5150
	0    1    1    0   
$EndComp
Wire Wire Line
	5000 5000 5000 4900
$Comp
L Device:R_Small R7
U 1 1 5F9D594A
P 5350 4800
F 0 "R7" H 5409 4846 50  0000 L CNN
F 1 "220" H 5409 4755 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" H 5350 4800 50  0001 C CNN
F 3 "~" H 5350 4800 50  0001 C CNN
	1    5350 4800
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D6
U 1 1 5F9D5950
P 5350 5150
F 0 "D6" V 5389 5032 50  0000 R CNN
F 1 "LED" V 5298 5032 50  0000 R CNN
F 2 "LED_THT:LED_D5.0mm" H 5350 5150 50  0001 C CNN
F 3 "~" H 5350 5150 50  0001 C CNN
	1    5350 5150
	0    1    1    0   
$EndComp
Wire Wire Line
	5350 5000 5350 4900
Wire Wire Line
	3050 4550 3600 4550
Wire Wire Line
	3600 4550 3600 4700
Wire Wire Line
	3050 4450 3950 4450
Wire Wire Line
	3950 4450 3950 4700
Wire Wire Line
	3050 4350 4300 4350
Wire Wire Line
	4300 4350 4300 4700
Wire Wire Line
	3050 4250 4650 4250
Wire Wire Line
	4650 4250 4650 4700
Wire Wire Line
	3050 4150 5000 4150
Wire Wire Line
	5000 4150 5000 4700
Wire Wire Line
	3050 4050 5350 4050
Wire Wire Line
	5350 4050 5350 4700
$Comp
L Device:C C4
U 1 1 5FA01756
P 7200 4750
F 0 "C4" H 7315 4796 50  0000 L CNN
F 1 "100n" H 7315 4705 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 7238 4600 50  0001 C CNN
F 3 "~" H 7200 4750 50  0001 C CNN
	1    7200 4750
	1    0    0    -1  
$EndComp
Wire Wire Line
	7650 4550 7200 4550
Wire Wire Line
	7200 4550 7200 4600
Connection ~ 7650 4550
Wire Wire Line
	7200 4900 7200 4950
Wire Wire Line
	7200 4950 7650 4950
Connection ~ 7650 4950
$Comp
L Device:R_Small R8
U 1 1 5FA25F01
P 6050 3100
F 0 "R8" H 6109 3146 50  0000 L CNN
F 1 "220" H 6109 3055 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" H 6050 3100 50  0001 C CNN
F 3 "~" H 6050 3100 50  0001 C CNN
	1    6050 3100
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D7
U 1 1 5FA25F07
P 6050 3450
F 0 "D7" V 6089 3332 50  0000 R CNN
F 1 "LED" V 5998 3332 50  0000 R CNN
F 2 "LED_THT:LED_D5.0mm" H 6050 3450 50  0001 C CNN
F 3 "~" H 6050 3450 50  0001 C CNN
	1    6050 3450
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6050 3300 6050 3200
Wire Wire Line
	6050 3600 6050 3700
$Comp
L power:GND #PWR035
U 1 1 5FA25F0F
P 6050 3700
F 0 "#PWR035" H 6050 3450 50  0001 C CNN
F 1 "GND" H 6055 3527 50  0000 C CNN
F 2 "" H 6050 3700 50  0001 C CNN
F 3 "" H 6050 3700 50  0001 C CNN
	1    6050 3700
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R9
U 1 1 5FA25F15
P 6400 3100
F 0 "R9" H 6459 3146 50  0000 L CNN
F 1 "220" H 6459 3055 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" H 6400 3100 50  0001 C CNN
F 3 "~" H 6400 3100 50  0001 C CNN
	1    6400 3100
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D8
U 1 1 5FA25F1B
P 6400 3450
F 0 "D8" V 6439 3332 50  0000 R CNN
F 1 "LED" V 6348 3332 50  0000 R CNN
F 2 "LED_THT:LED_D5.0mm" H 6400 3450 50  0001 C CNN
F 3 "~" H 6400 3450 50  0001 C CNN
	1    6400 3450
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6400 3300 6400 3200
Wire Wire Line
	6400 3600 6400 3700
$Comp
L power:GND #PWR036
U 1 1 5FA25F23
P 6400 3700
F 0 "#PWR036" H 6400 3450 50  0001 C CNN
F 1 "GND" H 6405 3527 50  0000 C CNN
F 2 "" H 6400 3700 50  0001 C CNN
F 3 "" H 6400 3700 50  0001 C CNN
	1    6400 3700
	1    0    0    -1  
$EndComp
Wire Wire Line
	6050 2450 6050 3000
Wire Wire Line
	6400 2350 6400 3000
Wire Wire Line
	5800 2450 6050 2450
Wire Wire Line
	5800 2350 6400 2350
Text Label 5850 1750 0    50   ~ 0
LCD_D4
Text Label 5850 1850 0    50   ~ 0
LCD_D5
Text Label 5850 1950 0    50   ~ 0
LCD_D6
Text Label 5850 2050 0    50   ~ 0
LCD_D7
Text Label 5850 2150 0    50   ~ 0
LCD_RS
Text Label 5850 2250 0    50   ~ 0
LCD_E
Text Label 5850 2350 0    50   ~ 0
LED0
Text Label 5850 2450 0    50   ~ 0
LED1
NoConn ~ 3050 2050
NoConn ~ 3050 2150
NoConn ~ 3050 2250
NoConn ~ 3050 2350
NoConn ~ 3050 2450
NoConn ~ 3050 2550
NoConn ~ 3050 2650
Wire Wire Line
	8600 1700 8750 1700
Wire Wire Line
	8750 1700 8750 1450
Wire Wire Line
	8750 1450 9100 1450
Wire Wire Line
	9650 850  9650 900 
$Comp
L power:GND #PWR0101
U 1 1 5FA76216
P 9250 1600
F 0 "#PWR0101" H 9250 1350 50  0001 C CNN
F 1 "GND" H 9255 1427 50  0000 C CNN
F 2 "" H 9250 1600 50  0001 C CNN
F 3 "" H 9250 1600 50  0001 C CNN
	1    9250 1600
	1    0    0    -1  
$EndComp
$Comp
L Device:R R10
U 1 1 5FA7664E
P 9250 1100
F 0 "R10" V 9043 1100 50  0000 C CNN
F 1 "22K" V 9134 1100 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 9180 1100 50  0001 C CNN
F 3 "~" H 9250 1100 50  0001 C CNN
	1    9250 1100
	-1   0    0    1   
$EndComp
Wire Wire Line
	9250 950  9250 900 
Wire Wire Line
	9250 900  9650 900 
Connection ~ 9650 900 
Wire Wire Line
	9650 900  9650 2000
Wire Wire Line
	3600 5300 3600 5400
Wire Wire Line
	3600 5400 3950 5400
Wire Wire Line
	5350 5400 5350 5300
Wire Wire Line
	5000 5400 5000 5300
Connection ~ 5000 5400
Wire Wire Line
	5000 5400 5350 5400
Wire Wire Line
	4650 5400 4650 5300
Connection ~ 4650 5400
Wire Wire Line
	4650 5400 5000 5400
Wire Wire Line
	4300 5400 4300 5300
Connection ~ 4300 5400
Wire Wire Line
	4300 5400 4650 5400
Wire Wire Line
	3950 5400 3950 5300
Connection ~ 3950 5400
Wire Wire Line
	3950 5400 4300 5400
Wire Wire Line
	5700 5400 5700 5300
Wire Wire Line
	5350 5400 5700 5400
Connection ~ 5350 5400
$Comp
L power:VCC #PWR030
U 1 1 5FAD2EC5
P 5700 5300
F 0 "#PWR030" H 5700 5150 50  0001 C CNN
F 1 "VCC" H 5715 5473 50  0000 C CNN
F 2 "" H 5700 5300 50  0001 C CNN
F 3 "" H 5700 5300 50  0001 C CNN
	1    5700 5300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR029
U 1 1 5FAD956F
P 4750 3050
F 0 "#PWR029" H 4750 2800 50  0001 C CNN
F 1 "GND" H 4755 2877 50  0000 C CNN
F 2 "" H 4750 3050 50  0001 C CNN
F 3 "" H 4750 3050 50  0001 C CNN
	1    4750 3050
	1    0    0    -1  
$EndComp
Wire Wire Line
	4750 3050 4750 2750
Wire Wire Line
	4750 2750 4800 2750
$Comp
L power:VCC #PWR032
U 1 1 5FAEEC9E
P 10250 5000
F 0 "#PWR032" H 10250 4850 50  0001 C CNN
F 1 "VCC" H 10265 5173 50  0000 C CNN
F 2 "" H 10250 5000 50  0001 C CNN
F 3 "" H 10250 5000 50  0001 C CNN
	1    10250 5000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR033
U 1 1 5FAFBEB3
P 10250 6000
F 0 "#PWR033" H 10250 5750 50  0001 C CNN
F 1 "GND" H 10255 5827 50  0000 C CNN
F 2 "" H 10250 6000 50  0001 C CNN
F 3 "" H 10250 6000 50  0001 C CNN
	1    10250 6000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR031
U 1 1 5FAFC2B0
P 10000 3850
F 0 "#PWR031" H 10000 3600 50  0001 C CNN
F 1 "GND" H 10005 3677 50  0000 C CNN
F 2 "" H 10000 3850 50  0001 C CNN
F 3 "" H 10000 3850 50  0001 C CNN
	1    10000 3850
	1    0    0    -1  
$EndComp
NoConn ~ 10600 3600
NoConn ~ 10600 3050
Wire Wire Line
	4300 2650 4800 2650
Wire Wire Line
	3700 1950 3700 2550
$Comp
L 74xx:74LS02 U4
U 1 1 5F98F3CC
P 4000 2650
F 0 "U4" H 4000 2975 50  0000 C CNN
F 1 "74HC02" H 4000 2884 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 4000 2650 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74ls02" H 4000 2650 50  0001 C CNN
	1    4000 2650
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS02 U4
U 2 1 5F991646
P 10300 3050
F 0 "U4" H 10300 3375 50  0000 C CNN
F 1 "74HC02" H 10300 3284 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 10300 3050 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74ls02" H 10300 3050 50  0001 C CNN
	2    10300 3050
	1    0    0    -1  
$EndComp
Wire Wire Line
	10000 2950 10000 3150
Connection ~ 10000 3150
Wire Wire Line
	10000 3150 10000 3500
$Comp
L 74xx:74LS02 U4
U 3 1 5F99C8F3
P 10300 3600
F 0 "U4" H 10300 3925 50  0000 C CNN
F 1 "74HC02" H 10300 3834 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 10300 3600 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74ls02" H 10300 3600 50  0001 C CNN
	3    10300 3600
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS02 U4
U 4 1 5F99E440
P 4750 6250
F 0 "U4" H 4750 6575 50  0000 C CNN
F 1 "74HC02" H 4750 6484 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 4750 6250 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74ls02" H 4750 6250 50  0001 C CNN
	4    4750 6250
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS02 U4
U 5 1 5F99FB8B
P 10250 5500
F 0 "U4" H 10480 5546 50  0000 L CNN
F 1 "74HC02" H 10480 5455 50  0000 L CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 10250 5500 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74ls02" H 10250 5500 50  0001 C CNN
	5    10250 5500
	1    0    0    -1  
$EndComp
Wire Wire Line
	10000 3500 10000 3700
Connection ~ 10000 3500
Connection ~ 10000 3700
Text Label 3200 1950 0    50   ~ 0
~CS_LCDREG
$Comp
L Device:R_Small R11
U 1 1 5F9E0C9F
P 5350 6000
F 0 "R11" H 5409 6046 50  0000 L CNN
F 1 "220" H 5409 5955 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" H 5350 6000 50  0001 C CNN
F 3 "~" H 5350 6000 50  0001 C CNN
	1    5350 6000
	-1   0    0    1   
$EndComp
$Comp
L Device:LED D9
U 1 1 5F9E0CA5
P 5350 5650
F 0 "D9" V 5389 5532 50  0000 R CNN
F 1 "LED" V 5298 5532 50  0000 R CNN
F 2 "LED_THT:LED_D5.0mm" H 5350 5650 50  0001 C CNN
F 3 "~" H 5350 5650 50  0001 C CNN
	1    5350 5650
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5350 5800 5350 5900
Wire Wire Line
	5350 5500 5350 5400
Wire Wire Line
	10000 3700 10000 3850
Wire Wire Line
	5350 6250 5350 6100
Wire Wire Line
	5050 6250 5350 6250
Wire Wire Line
	4450 6350 4400 6350
Wire Wire Line
	4400 6350 4400 6150
Wire Wire Line
	4400 6150 4450 6150
Wire Wire Line
	4400 6150 4300 6150
Connection ~ 4400 6150
Text GLabel 4300 6150 0    50   Input ~ 0
RESET
Wire Wire Line
	8600 2000 9650 2000
Wire Bus Line
	1750 1800 1750 2050
Wire Bus Line
	4500 1600 4500 2350
$EndSCHEMATC
