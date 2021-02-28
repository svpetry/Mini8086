EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 8
Title "Mini8086 I/O board"
Date "2020-11-05"
Rev "1.2"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Interface_UART:MAX232 U2
U 1 1 5F80B184
P 6950 2300
F 0 "U2" H 6950 2550 50  0000 C CNN
F 1 "MAX232" H 7300 1200 50  0000 C CNN
F 2 "Package_SO:SOIC-16_3.9x9.9mm_P1.27mm" H 7000 1250 50  0001 L CNN
F 3 "http://www.ti.com/lit/ds/symlink/max232.pdf" H 6950 2400 50  0001 C CNN
	1    6950 2300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR05
U 1 1 5F8C3394
P 4100 4300
F 0 "#PWR05" H 4100 4050 50  0001 C CNN
F 1 "GND" H 4105 4127 50  0000 C CNN
F 2 "" H 4100 4300 50  0001 C CNN
F 3 "" H 4100 4300 50  0001 C CNN
	1    4100 4300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR08
U 1 1 5F8C3999
P 6950 3500
F 0 "#PWR08" H 6950 3250 50  0001 C CNN
F 1 "GND" H 6955 3327 50  0000 C CNN
F 2 "" H 6950 3500 50  0001 C CNN
F 3 "" H 6950 3500 50  0001 C CNN
	1    6950 3500
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR07
U 1 1 5F8C3B22
P 6950 1100
F 0 "#PWR07" H 6950 950 50  0001 C CNN
F 1 "VCC" H 6965 1273 50  0000 C CNN
F 2 "" H 6950 1100 50  0001 C CNN
F 3 "" H 6950 1100 50  0001 C CNN
	1    6950 1100
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR04
U 1 1 5F8C3CDE
P 4100 900
F 0 "#PWR04" H 4100 750 50  0001 C CNN
F 1 "VCC" H 4115 1073 50  0000 C CNN
F 2 "" H 4100 900 50  0001 C CNN
F 3 "" H 4100 900 50  0001 C CNN
	1    4100 900 
	1    0    0    -1  
$EndComp
Wire Wire Line
	2900 2300 3100 2300
Wire Wire Line
	2900 2200 3100 2200
Wire Wire Line
	2900 2100 3100 2100
Entry Wire Line
	2900 2100 2800 2000
Entry Wire Line
	2900 2200 2800 2100
Entry Wire Line
	2900 2300 2800 2200
Wire Bus Line
	2800 1950 2700 1950
Text GLabel 2700 1950 0    50   Input ~ 0
A[0..19]
Text Label 2950 2100 0    50   ~ 0
A0
Text Label 2950 2200 0    50   ~ 0
A1
Text Label 2950 2300 0    50   ~ 0
A2
Wire Wire Line
	2900 1900 3100 1900
Wire Wire Line
	2900 1700 3100 1700
Wire Wire Line
	2900 1800 3100 1800
Wire Wire Line
	2900 1600 3100 1600
Wire Wire Line
	2900 1500 3100 1500
Wire Wire Line
	2900 1400 3100 1400
Wire Wire Line
	2900 1300 3100 1300
Wire Wire Line
	2900 1200 3100 1200
Entry Wire Line
	2900 1200 2800 1100
Entry Wire Line
	2900 1300 2800 1200
Entry Wire Line
	2900 1400 2800 1300
Entry Wire Line
	2900 1500 2800 1400
Entry Wire Line
	2900 1600 2800 1500
Entry Wire Line
	2900 1700 2800 1600
Entry Wire Line
	2900 1800 2800 1700
Entry Wire Line
	2900 1900 2800 1800
Wire Bus Line
	2800 1050 2700 1050
Text GLabel 2700 1050 0    50   BiDi ~ 0
D[0..7]
$Comp
L Device:CP C3
U 1 1 5F8A5B92
P 5950 1550
F 0 "C3" H 6068 1596 50  0000 L CNN
F 1 "10µ" H 6068 1505 50  0000 L CNN
F 2 "Capacitor_SMD:CP_Elec_4x3.9" H 5988 1400 50  0001 C CNN
F 3 "~" H 5950 1550 50  0001 C CNN
	1    5950 1550
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C4
U 1 1 5F8A625C
P 7900 1550
F 0 "C4" H 8018 1596 50  0000 L CNN
F 1 "10µ" H 8018 1505 50  0000 L CNN
F 2 "Capacitor_SMD:CP_Elec_4x3.9" H 7938 1400 50  0001 C CNN
F 3 "~" H 7900 1550 50  0001 C CNN
	1    7900 1550
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C6
U 1 1 5F8A66C7
P 8350 1550
F 0 "C6" H 8232 1504 50  0000 R CNN
F 1 "10µ" H 8232 1595 50  0000 R CNN
F 2 "Capacitor_SMD:CP_Elec_4x3.9" H 8388 1400 50  0001 C CNN
F 3 "~" H 8350 1550 50  0001 C CNN
	1    8350 1550
	-1   0    0    1   
$EndComp
$Comp
L power:VCC #PWR010
U 1 1 5F8A68A6
P 8350 1150
F 0 "#PWR010" H 8350 1000 50  0001 C CNN
F 1 "VCC" H 8365 1323 50  0000 C CNN
F 2 "" H 8350 1150 50  0001 C CNN
F 3 "" H 8350 1150 50  0001 C CNN
	1    8350 1150
	1    0    0    -1  
$EndComp
Wire Wire Line
	7750 1900 8350 1900
Wire Wire Line
	8350 1900 8350 1700
Wire Wire Line
	8350 1400 8350 1150
Wire Wire Line
	7900 1400 7750 1400
Wire Wire Line
	7900 1700 7750 1700
Wire Wire Line
	6150 1400 5950 1400
Wire Wire Line
	6150 1700 5950 1700
$Comp
L power:GND #PWR09
U 1 1 5F8AAE3F
P 8100 3450
F 0 "#PWR09" H 8100 3200 50  0001 C CNN
F 1 "GND" H 8105 3277 50  0000 C CNN
F 2 "" H 8100 3450 50  0001 C CNN
F 3 "" H 8100 3450 50  0001 C CNN
	1    8100 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	7750 2200 8100 2200
Wire Wire Line
	8100 2200 8100 3150
$Comp
L Device:CP C5
U 1 1 5F8A98AB
P 8100 3300
F 0 "C5" H 7982 3254 50  0000 R CNN
F 1 "10µ" H 7982 3345 50  0000 R CNN
F 2 "Capacitor_SMD:CP_Elec_4x3.9" H 8138 3150 50  0001 C CNN
F 3 "~" H 8100 3300 50  0001 C CNN
	1    8100 3300
	-1   0    0    1   
$EndComp
Wire Wire Line
	3100 2500 2950 2500
Wire Wire Line
	2950 2500 2950 2400
Wire Wire Line
	2950 2400 3100 2400
Wire Wire Line
	2950 2400 2800 2400
Connection ~ 2950 2400
$Comp
L power:VCC #PWR02
U 1 1 5F8A7865
P 2800 2400
F 0 "#PWR02" H 2800 2250 50  0001 C CNN
F 1 "VCC" H 2815 2573 50  0000 C CNN
F 2 "" H 2800 2400 50  0001 C CNN
F 3 "" H 2800 2400 50  0001 C CNN
	1    2800 2400
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3100 2600 2850 2600
Text GLabel 2850 2600 0    50   Input ~ 0
~CS_UART
Wire Wire Line
	3100 3800 2900 3800
Wire Wire Line
	2900 3800 2900 4250
Connection ~ 2900 3800
Wire Wire Line
	3100 3500 2900 3500
$Comp
L power:GND #PWR03
U 1 1 5F8AB337
P 2900 4250
F 0 "#PWR03" H 2900 4000 50  0001 C CNN
F 1 "GND" H 2905 4077 50  0000 C CNN
F 2 "" H 2900 4250 50  0001 C CNN
F 3 "" H 2900 4250 50  0001 C CNN
	1    2900 4250
	1    0    0    -1  
$EndComp
Wire Wire Line
	3100 3400 2800 3400
Text GLabel 2800 3400 0    50   Input ~ 0
~WR
Text GLabel 2800 3600 0    50   Input ~ 0
~RD
Wire Wire Line
	5100 3800 5650 3800
Wire Wire Line
	5650 3800 5650 4000
Wire Wire Line
	5650 4000 5100 4000
Wire Wire Line
	5100 1400 5200 1400
Wire Wire Line
	5200 1400 5200 1300
$Comp
L power:VCC #PWR06
U 1 1 5F8AE296
P 5200 1300
F 0 "#PWR06" H 5200 1150 50  0001 C CNN
F 1 "VCC" H 5215 1473 50  0000 C CNN
F 2 "" H 5200 1300 50  0001 C CNN
F 3 "" H 5200 1300 50  0001 C CNN
	1    5200 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	3100 3900 2800 3900
Text GLabel 2800 3900 0    50   Output ~ 0
IRQ4
$Comp
L Device:R_Small R2
U 1 1 5F8BA463
P 2450 3100
F 0 "R2" V 2646 3100 50  0000 C CNN
F 1 "47" V 2555 3100 50  0000 C CNN
F 2 "Resistor_SMD:R_1206_3216Metric" H 2450 3100 50  0001 C CNN
F 3 "~" H 2450 3100 50  0001 C CNN
	1    2450 3100
	0    -1   -1   0   
$EndComp
$Comp
L Device:R_Small R1
U 1 1 5F8BAFD9
P 2150 2950
F 0 "R1" H 2091 2904 50  0000 R CNN
F 1 "1M" H 2091 2995 50  0000 R CNN
F 2 "Resistor_SMD:R_1206_3216Metric" H 2150 2950 50  0001 C CNN
F 3 "~" H 2150 2950 50  0001 C CNN
	1    2150 2950
	-1   0    0    1   
$EndComp
$Comp
L Device:C C2
U 1 1 5F8BBC1D
P 1650 3400
F 0 "C2" H 1765 3446 50  0000 L CNN
F 1 "27p" H 1765 3355 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 1688 3250 50  0001 C CNN
F 3 "~" H 1650 3400 50  0001 C CNN
	1    1650 3400
	1    0    0    -1  
$EndComp
$Comp
L Device:C C1
U 1 1 5F8BC7BA
P 1200 3400
F 0 "C1" H 1315 3446 50  0000 L CNN
F 1 "27p" H 1315 3355 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 1238 3250 50  0001 C CNN
F 3 "~" H 1200 3400 50  0001 C CNN
	1    1200 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	3100 3100 2550 3100
Wire Wire Line
	2150 2800 2150 2850
Wire Wire Line
	2150 2800 3100 2800
Wire Wire Line
	2150 3100 2150 3050
Wire Wire Line
	2150 3100 2350 3100
$Comp
L Device:Crystal Y1
U 1 1 5F8C4622
P 1650 2950
F 0 "Y1" V 1696 2819 50  0000 R CNN
F 1 "8 MHz" V 1605 2819 50  0000 R CNN
F 2 "Crystal:Crystal_HC49-U_Vertical" H 1650 2950 50  0001 C CNN
F 3 "~" H 1650 2950 50  0001 C CNN
	1    1650 2950
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1650 2800 2150 2800
Connection ~ 2150 2800
Wire Wire Line
	1650 3100 2150 3100
Connection ~ 2150 3100
Wire Wire Line
	1650 3250 1650 3100
Connection ~ 1650 3100
Wire Wire Line
	1200 3250 1200 2800
Wire Wire Line
	1200 2800 1650 2800
Connection ~ 1650 2800
Wire Wire Line
	1650 3550 1650 3650
Wire Wire Line
	1650 3650 1200 3650
Wire Wire Line
	1200 3650 1200 3550
Wire Wire Line
	1200 3650 1200 3750
Connection ~ 1200 3650
$Comp
L power:GND #PWR01
U 1 1 5F8CC1AD
P 1200 3750
F 0 "#PWR01" H 1200 3500 50  0001 C CNN
F 1 "GND" H 1205 3577 50  0000 C CNN
F 2 "" H 1200 3750 50  0001 C CNN
F 3 "" H 1200 3750 50  0001 C CNN
	1    1200 3750
	1    0    0    -1  
$EndComp
NoConn ~ 5100 2300
NoConn ~ 5100 2000
Wire Wire Line
	5100 2900 5550 2900
Wire Wire Line
	5550 2900 5550 2400
Wire Wire Line
	5550 2400 6150 2400
Wire Wire Line
	5100 2800 6150 2800
Wire Wire Line
	7750 2800 8550 2800
Wire Wire Line
	8550 2800 8550 2600
Text Label 7850 2800 0    50   ~ 0
RX
Text Label 7850 2400 0    50   ~ 0
TX
Wire Wire Line
	7750 2600 8250 2600
Text Label 7850 2600 0    50   ~ 0
RTS
Wire Wire Line
	8400 2300 8400 3000
Wire Wire Line
	8400 3000 7750 3000
Text Label 7850 3000 0    50   ~ 0
CTS
Wire Wire Line
	6150 2600 5400 2600
Wire Wire Line
	5400 2600 5400 2200
Wire Wire Line
	5400 2200 5100 2200
Wire Wire Line
	6150 3000 5700 3000
Wire Wire Line
	5700 3000 5700 1700
Wire Wire Line
	5700 1700 5100 1700
Wire Wire Line
	8250 2500 8250 2600
NoConn ~ 5100 2100
NoConn ~ 5100 3200
NoConn ~ 5100 3300
NoConn ~ 5100 3400
Wire Wire Line
	3100 4000 2550 4000
Text GLabel 2550 4000 0    50   Input ~ 0
RESET
Wire Wire Line
	5100 1600 5200 1600
Wire Wire Line
	5200 1600 5200 1500
Connection ~ 5200 1400
Wire Wire Line
	5100 1500 5200 1500
Connection ~ 5200 1500
Wire Wire Line
	5200 1500 5200 1400
$Comp
L Device:R R3
U 1 1 5F91C80E
P 9050 2200
F 0 "R3" V 8843 2200 50  0000 C CNN
F 1 "3K3" V 8934 2200 50  0000 C CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 8980 2200 50  0001 C CNN
F 3 "~" H 9050 2200 50  0001 C CNN
	1    9050 2200
	0    1    1    0   
$EndComp
Wire Wire Line
	8900 2200 8350 2200
Wire Wire Line
	8350 2200 8350 1900
Connection ~ 8350 1900
Wire Wire Line
	9550 2200 9200 2200
NoConn ~ 9550 2100
Wire Wire Line
	9550 2500 8250 2500
NoConn ~ 9550 2700
NoConn ~ 9550 2800
Wire Wire Line
	9550 2300 8400 2300
Wire Wire Line
	9550 2600 8550 2600
Wire Wire Line
	7750 2400 9550 2400
Wire Wire Line
	9850 3050 9850 3250
Connection ~ 9850 3050
Wire Wire Line
	10300 3050 9850 3050
Wire Wire Line
	10300 1800 10300 3050
Wire Wire Line
	9400 1800 10300 1800
Wire Wire Line
	9400 2000 9400 1800
Wire Wire Line
	9550 2000 9400 2000
$Comp
L power:GND #PWR011
U 1 1 5F8DE08B
P 9850 3250
F 0 "#PWR011" H 9850 3000 50  0001 C CNN
F 1 "GND" H 9855 3077 50  0000 C CNN
F 2 "" H 9850 3250 50  0001 C CNN
F 3 "" H 9850 3250 50  0001 C CNN
	1    9850 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	9850 3000 9850 3050
$Comp
L Connector:DB9_Male_MountingHoles J1
U 1 1 5F8DB542
P 9850 2400
F 0 "J1" H 10030 2402 50  0000 L CNN
F 1 "RS232" H 10030 2311 50  0000 L CNN
F 2 "Connector_Dsub:DSUB-9_Male_Horizontal_P2.77x2.84mm_EdgePinOffset4.94mm_Housed_MountingHolesOffset7.48mm" H 9850 2400 50  0001 C CNN
F 3 " ~" H 9850 2400 50  0001 C CNN
	1    9850 2400
	1    0    0    -1  
$EndComp
Text Label 2950 1200 0    50   ~ 0
D0
Text Label 2950 1300 0    50   ~ 0
D1
Text Label 2950 1400 0    50   ~ 0
D2
Text Label 2950 1500 0    50   ~ 0
D3
Text Label 2950 1600 0    50   ~ 0
D4
Text Label 2950 1700 0    50   ~ 0
D5
Text Label 2950 1800 0    50   ~ 0
D6
Text Label 2950 1900 0    50   ~ 0
D7
$Comp
L io_board-rescue:ST16C550CJ44-Mini8086 U1
U 1 1 5FC8676D
P 4100 2600
F 0 "U1" H 4100 2600 50  0000 C CNN
F 1 "ST16C550CJ44" H 4100 2450 50  0000 C CNN
F 2 "Package_LCC:PLCC-44_THT-Socket" H 4100 2600 50  0001 C CIN
F 3 "" H 4100 2600 50  0001 C CNN
	1    4100 2600
	1    0    0    -1  
$EndComp
Text Label 2700 2800 0    50   ~ 0
XTAL1
Text Label 2700 3100 0    50   ~ 0
XTAL2
NoConn ~ 3950 4250
NoConn ~ 3850 4250
NoConn ~ 3750 4250
NoConn ~ 3650 4250
Text Label 5150 1700 0    50   ~ 0
CTS_5
Text Label 5150 2200 0    50   ~ 0
RTS_5
Text Label 5150 2800 0    50   ~ 0
RX_5
Text Label 5150 2900 0    50   ~ 0
TX_5
Text Label 5250 4000 0    50   ~ 0
RCLK
Wire Wire Line
	2900 3500 2900 3700
Wire Wire Line
	3100 3600 2800 3600
Wire Wire Line
	3100 3700 2900 3700
Connection ~ 2900 3700
Wire Wire Line
	2900 3700 2900 3800
Wire Bus Line
	2800 1950 2800 2200
Wire Bus Line
	2800 1050 2800 1800
$EndSCHEMATC
