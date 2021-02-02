EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 5 7
Title "Mini8086 main system board"
Date ""
Rev "1.1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L power:GND #PWR054
U 1 1 5F74D46A
P 3150 4650
F 0 "#PWR054" H 3150 4400 50  0001 C CNN
F 1 "GND" V 3155 4522 50  0000 R CNN
F 2 "" H 3150 4650 50  0001 C CNN
F 3 "" H 3150 4650 50  0001 C CNN
	1    3150 4650
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR053
U 1 1 5F74D63B
P 3150 4550
F 0 "#PWR053" H 3150 4300 50  0001 C CNN
F 1 "GND" V 3155 4422 50  0000 R CNN
F 2 "" H 3150 4550 50  0001 C CNN
F 3 "" H 3150 4550 50  0001 C CNN
	1    3150 4550
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR047
U 1 1 5F74D838
P 2200 4550
F 0 "#PWR047" H 2200 4300 50  0001 C CNN
F 1 "GND" V 2205 4422 50  0000 R CNN
F 2 "" H 2200 4550 50  0001 C CNN
F 3 "" H 2200 4550 50  0001 C CNN
	1    2200 4550
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR048
U 1 1 5F74DC31
P 2200 4650
F 0 "#PWR048" H 2200 4400 50  0001 C CNN
F 1 "GND" V 2205 4522 50  0000 R CNN
F 2 "" H 2200 4650 50  0001 C CNN
F 3 "" H 2200 4650 50  0001 C CNN
	1    2200 4650
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR043
U 1 1 5F74DE5C
P 2200 1150
F 0 "#PWR043" H 2200 900 50  0001 C CNN
F 1 "GND" V 2205 1022 50  0000 R CNN
F 2 "" H 2200 1150 50  0001 C CNN
F 3 "" H 2200 1150 50  0001 C CNN
	1    2200 1150
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR044
U 1 1 5F74E666
P 2200 1250
F 0 "#PWR044" H 2200 1000 50  0001 C CNN
F 1 "GND" V 2205 1122 50  0000 R CNN
F 2 "" H 2200 1250 50  0001 C CNN
F 3 "" H 2200 1250 50  0001 C CNN
	1    2200 1250
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR049
U 1 1 5F74E81A
P 3150 1150
F 0 "#PWR049" H 3150 900 50  0001 C CNN
F 1 "GND" V 3155 1022 50  0000 R CNN
F 2 "" H 3150 1150 50  0001 C CNN
F 3 "" H 3150 1150 50  0001 C CNN
	1    3150 1150
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR050
U 1 1 5F74EC13
P 3150 1250
F 0 "#PWR050" H 3150 1000 50  0001 C CNN
F 1 "GND" V 3155 1122 50  0000 R CNN
F 2 "" H 3150 1250 50  0001 C CNN
F 3 "" H 3150 1250 50  0001 C CNN
	1    3150 1250
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR051
U 1 1 5F74EF84
P 3150 4350
F 0 "#PWR051" H 3150 4200 50  0001 C CNN
F 1 "VCC" V 3165 4478 50  0000 L CNN
F 2 "" H 3150 4350 50  0001 C CNN
F 3 "" H 3150 4350 50  0001 C CNN
	1    3150 4350
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR052
U 1 1 5F74F84A
P 3150 4450
F 0 "#PWR052" H 3150 4300 50  0001 C CNN
F 1 "VCC" V 3165 4578 50  0000 L CNN
F 2 "" H 3150 4450 50  0001 C CNN
F 3 "" H 3150 4450 50  0001 C CNN
	1    3150 4450
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR046
U 1 1 5F74FB04
P 2200 4450
F 0 "#PWR046" H 2200 4300 50  0001 C CNN
F 1 "VCC" V 2215 4577 50  0000 L CNN
F 2 "" H 2200 4450 50  0001 C CNN
F 3 "" H 2200 4450 50  0001 C CNN
	1    2200 4450
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR045
U 1 1 5F7501D2
P 2200 4350
F 0 "#PWR045" H 2200 4200 50  0001 C CNN
F 1 "VCC" V 2215 4477 50  0000 L CNN
F 2 "" H 2200 4350 50  0001 C CNN
F 3 "" H 2200 4350 50  0001 C CNN
	1    2200 4350
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3150 1450 3250 1450
Wire Wire Line
	3150 1550 3650 1550
Wire Wire Line
	3150 1650 3250 1650
Wire Wire Line
	3150 1750 3650 1750
Wire Wire Line
	3150 1850 3250 1850
Wire Wire Line
	3150 1950 3650 1950
Wire Wire Line
	3150 2050 3250 2050
Text GLabel 3250 1450 2    50   Output ~ 0
RESET
Text GLabel 3650 1550 2    50   Input ~ 0
~MEMWR
Text GLabel 3250 1650 2    50   Input ~ 0
~MEMRD
Text GLabel 3650 1750 2    50   Input ~ 0
~BHE
Text GLabel 3250 1850 2    50   Input ~ 0
M_~IO
Text GLabel 3650 1950 2    50   Input ~ 0
~WR
Text GLabel 3250 2050 2    50   Input ~ 0
~RD
Wire Wire Line
	2200 1850 2100 1850
Wire Wire Line
	2200 1950 1650 1950
Wire Wire Line
	2200 2050 2100 2050
Wire Wire Line
	2200 2150 1650 2150
Text GLabel 2100 1850 0    50   Input ~ 0
RDY2
Text GLabel 1650 1950 0    50   Input ~ 0
RDY1
Text GLabel 2100 2050 0    50   Input ~ 0
~VGA_MEM
Text GLabel 1650 2150 0    50   Input ~ 0
~VGA_IO
Wire Wire Line
	2200 4250 1900 4250
Wire Wire Line
	1900 4150 2200 4150
Wire Wire Line
	1900 4050 2200 4050
Wire Wire Line
	1900 3950 2200 3950
Wire Wire Line
	1900 3850 2200 3850
Wire Wire Line
	1900 3750 2200 3750
Wire Wire Line
	1900 3650 2200 3650
Wire Wire Line
	1900 3550 2200 3550
Wire Wire Line
	1900 3450 2200 3450
Wire Wire Line
	1900 3350 2200 3350
Wire Wire Line
	1900 3250 2200 3250
Wire Wire Line
	1900 3150 2200 3150
Wire Wire Line
	1900 3050 2200 3050
Wire Wire Line
	1900 2950 2200 2950
Wire Wire Line
	1900 2850 2200 2850
Wire Wire Line
	1900 2750 2200 2750
Wire Wire Line
	1900 2650 2200 2650
Wire Wire Line
	1900 2550 2200 2550
Wire Wire Line
	1900 2450 2200 2450
Wire Wire Line
	1900 2350 2200 2350
Entry Wire Line
	1900 2350 1800 2450
Entry Wire Line
	1900 2450 1800 2550
Entry Wire Line
	1900 2550 1800 2650
Entry Wire Line
	1900 2650 1800 2750
Entry Wire Line
	1900 2750 1800 2850
Entry Wire Line
	1900 2850 1800 2950
Entry Wire Line
	1900 2950 1800 3050
Entry Wire Line
	1900 3050 1800 3150
Entry Wire Line
	1900 3150 1800 3250
Entry Wire Line
	1900 3250 1800 3350
Entry Wire Line
	1900 3350 1800 3450
Entry Wire Line
	1900 3450 1800 3550
Entry Wire Line
	1900 3550 1800 3650
Entry Wire Line
	1900 3650 1800 3750
Entry Wire Line
	1900 3750 1800 3850
Entry Wire Line
	1900 3850 1800 3950
Entry Wire Line
	1900 3950 1800 4050
Entry Wire Line
	1900 4050 1800 4150
Entry Wire Line
	1900 4150 1800 4250
Entry Wire Line
	1900 4250 1800 4350
Wire Bus Line
	1800 4450 1750 4450
Wire Wire Line
	3500 2750 3150 2750
Wire Wire Line
	3500 2850 3150 2850
Wire Wire Line
	3500 2950 3150 2950
Wire Wire Line
	3500 3050 3150 3050
Wire Wire Line
	3500 3150 3150 3150
Wire Wire Line
	3500 3250 3150 3250
Wire Wire Line
	3500 3350 3150 3350
Wire Wire Line
	3500 3450 3150 3450
Wire Wire Line
	3500 3550 3150 3550
Wire Wire Line
	3500 3650 3150 3650
Wire Wire Line
	3500 3750 3150 3750
Wire Wire Line
	3500 3850 3150 3850
Wire Wire Line
	3500 3950 3150 3950
Wire Wire Line
	3500 4050 3150 4050
Wire Wire Line
	3500 4150 3150 4150
Wire Wire Line
	3150 4250 3500 4250
Entry Wire Line
	3500 2750 3600 2850
Entry Wire Line
	3500 2850 3600 2950
Entry Wire Line
	3500 2950 3600 3050
Entry Wire Line
	3500 3050 3600 3150
Entry Wire Line
	3500 3150 3600 3250
Entry Wire Line
	3500 3250 3600 3350
Entry Wire Line
	3500 3350 3600 3450
Entry Wire Line
	3500 3450 3600 3550
Entry Wire Line
	3500 3550 3600 3650
Entry Wire Line
	3500 3650 3600 3750
Entry Wire Line
	3500 3750 3600 3850
Entry Wire Line
	3500 3850 3600 3950
Entry Wire Line
	3500 3950 3600 4050
Entry Wire Line
	3500 4050 3600 4150
Entry Wire Line
	3500 4150 3600 4250
Entry Wire Line
	3500 4250 3600 4350
Wire Bus Line
	3600 4450 3650 4450
Text Label 3250 2750 0    50   ~ 0
D15
Text Label 3250 2850 0    50   ~ 0
D14
Text Label 3250 2950 0    50   ~ 0
D13
Text Label 3250 3050 0    50   ~ 0
D12
Text Label 3250 3150 0    50   ~ 0
D11
Text Label 3250 3250 0    50   ~ 0
D10
Text Label 3250 3350 0    50   ~ 0
D9
Text Label 3250 3450 0    50   ~ 0
D8
Text Label 3250 3550 0    50   ~ 0
D7
Text Label 3250 3650 0    50   ~ 0
D6
Text Label 3250 3750 0    50   ~ 0
D5
Text Label 3250 3850 0    50   ~ 0
D4
Text Label 3250 3950 0    50   ~ 0
D3
Text Label 3250 4050 0    50   ~ 0
D2
Text Label 3250 4150 0    50   ~ 0
D1
Text Label 3250 4250 0    50   ~ 0
D0
Text Label 2000 4250 0    50   ~ 0
A0
Text Label 2000 4150 0    50   ~ 0
A1
Text Label 2000 4050 0    50   ~ 0
A2
Text Label 2000 3950 0    50   ~ 0
A3
Text Label 2000 3850 0    50   ~ 0
A4
Text Label 2000 3750 0    50   ~ 0
A5
Text Label 2000 3650 0    50   ~ 0
A6
Text Label 2000 3550 0    50   ~ 0
A7
Text Label 2000 3450 0    50   ~ 0
A8
Text Label 2000 3350 0    50   ~ 0
A9
Text Label 2000 3250 0    50   ~ 0
A10
Text Label 2000 3150 0    50   ~ 0
A11
Text Label 2000 3050 0    50   ~ 0
A12
Text Label 2000 2950 0    50   ~ 0
A13
Text Label 2000 2850 0    50   ~ 0
A14
Text Label 2000 2750 0    50   ~ 0
A15
Text Label 2000 2650 0    50   ~ 0
A16
Text Label 2000 2550 0    50   ~ 0
A17
Text Label 2000 2450 0    50   ~ 0
A18
Text Label 2000 2350 0    50   ~ 0
A19
Wire Wire Line
	3150 2650 3500 2650
Wire Wire Line
	3150 2550 3500 2550
Wire Wire Line
	3500 2450 3150 2450
Wire Wire Line
	3500 2350 3150 2350
Wire Wire Line
	3500 2250 3150 2250
Wire Wire Line
	3500 2150 3150 2150
Text GLabel 3500 2650 2    50   Input ~ 0
IRQ1
Text GLabel 3500 2550 2    50   Input ~ 0
IRQ3
Text GLabel 3500 2450 2    50   Input ~ 0
IRQ4
Text GLabel 3500 2350 2    50   Input ~ 0
IRQ5
Text GLabel 3500 2250 2    50   Input ~ 0
IRQ6
Text GLabel 3500 2150 2    50   Input ~ 0
IRQ7
Text GLabel 3650 4450 2    50   BiDi ~ 0
D[0..15]
Text GLabel 1750 4450 0    50   Input ~ 0
A[0..19]
NoConn ~ 3150 1350
NoConn ~ 2200 1350
NoConn ~ 2200 2250
Wire Wire Line
	2200 1750 1650 1750
Text GLabel 1650 1750 0    50   Input ~ 0
PCLK
$Comp
L Device:C C4
U 1 1 5F81713B
P 3050 6500
F 0 "C4" H 3165 6546 50  0000 L CNN
F 1 "100n" H 3165 6455 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 3088 6350 50  0001 C CNN
F 3 "~" H 3050 6500 50  0001 C CNN
	1    3050 6500
	1    0    0    -1  
$EndComp
$Comp
L Device:C C5
U 1 1 5F81744A
P 3450 6500
F 0 "C5" H 3565 6546 50  0000 L CNN
F 1 "100n" H 3565 6455 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 3488 6350 50  0001 C CNN
F 3 "~" H 3450 6500 50  0001 C CNN
	1    3450 6500
	1    0    0    -1  
$EndComp
$Comp
L Device:C C6
U 1 1 5F817699
P 3850 6500
F 0 "C6" H 3965 6546 50  0000 L CNN
F 1 "100n" H 3965 6455 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 3888 6350 50  0001 C CNN
F 3 "~" H 3850 6500 50  0001 C CNN
	1    3850 6500
	1    0    0    -1  
$EndComp
$Comp
L Device:C C7
U 1 1 5F817A02
P 4250 6500
F 0 "C7" H 4365 6546 50  0000 L CNN
F 1 "100n" H 4365 6455 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 4288 6350 50  0001 C CNN
F 3 "~" H 4250 6500 50  0001 C CNN
	1    4250 6500
	1    0    0    -1  
$EndComp
$Comp
L Device:C C8
U 1 1 5F817CFE
P 4650 6500
F 0 "C8" H 4765 6546 50  0000 L CNN
F 1 "100n" H 4765 6455 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 4688 6350 50  0001 C CNN
F 3 "~" H 4650 6500 50  0001 C CNN
	1    4650 6500
	1    0    0    -1  
$EndComp
$Comp
L Device:C C9
U 1 1 5F818002
P 5050 6500
F 0 "C9" H 5165 6546 50  0000 L CNN
F 1 "100n" H 5165 6455 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 5088 6350 50  0001 C CNN
F 3 "~" H 5050 6500 50  0001 C CNN
	1    5050 6500
	1    0    0    -1  
$EndComp
$Comp
L Device:C C10
U 1 1 5F818253
P 5450 6500
F 0 "C10" H 5565 6546 50  0000 L CNN
F 1 "100n" H 5565 6455 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 5488 6350 50  0001 C CNN
F 3 "~" H 5450 6500 50  0001 C CNN
	1    5450 6500
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C12
U 1 1 5F818E28
P 6250 6500
F 0 "C12" H 6368 6546 50  0000 L CNN
F 1 "47µ" H 6368 6455 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D4.0mm_P2.00mm" H 6288 6350 50  0001 C CNN
F 3 "~" H 6250 6500 50  0001 C CNN
	1    6250 6500
	1    0    0    -1  
$EndComp
Wire Wire Line
	6250 6250 6250 6350
Wire Wire Line
	5050 6350 5050 6250
Connection ~ 5050 6250
Wire Wire Line
	4650 6350 4650 6250
Connection ~ 4650 6250
Wire Wire Line
	4650 6250 5050 6250
Wire Wire Line
	5050 6250 5450 6250
Wire Wire Line
	5450 6350 5450 6250
Connection ~ 5450 6250
Wire Wire Line
	4250 6350 4250 6250
Connection ~ 4250 6250
Wire Wire Line
	4250 6250 4650 6250
Wire Wire Line
	3850 6350 3850 6250
Connection ~ 3850 6250
Wire Wire Line
	3850 6250 4250 6250
Wire Wire Line
	3450 6350 3450 6250
Connection ~ 3450 6250
Wire Wire Line
	3450 6250 3850 6250
Wire Wire Line
	3050 6350 3050 6250
Wire Wire Line
	3050 6250 3450 6250
Wire Wire Line
	6250 6750 6250 6650
Wire Wire Line
	5450 6750 5450 6650
Connection ~ 5450 6750
Wire Wire Line
	5050 6750 5050 6650
Connection ~ 5050 6750
Wire Wire Line
	5050 6750 5450 6750
Wire Wire Line
	4650 6750 4650 6650
Connection ~ 4650 6750
Wire Wire Line
	4650 6750 5050 6750
Wire Wire Line
	4250 6750 4250 6650
Connection ~ 4250 6750
Wire Wire Line
	4250 6750 4650 6750
Wire Wire Line
	3850 6750 3850 6650
Connection ~ 3850 6750
Wire Wire Line
	3850 6750 4250 6750
Wire Wire Line
	3450 6750 3450 6650
Connection ~ 3450 6750
Wire Wire Line
	3450 6750 3850 6750
Wire Wire Line
	3050 6650 3050 6750
Wire Wire Line
	3050 6750 3450 6750
Wire Wire Line
	6250 6750 6250 6850
Connection ~ 6250 6750
Wire Wire Line
	6250 6250 6250 6150
Connection ~ 6250 6250
$Comp
L power:GND #PWR055
U 1 1 5F84F09A
P 6250 6850
F 0 "#PWR055" H 6250 6600 50  0001 C CNN
F 1 "GND" H 6255 6677 50  0000 C CNN
F 2 "" H 6250 6850 50  0001 C CNN
F 3 "" H 6250 6850 50  0001 C CNN
	1    6250 6850
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR038
U 1 1 5F84F39E
P 6250 6150
F 0 "#PWR038" H 6250 6000 50  0001 C CNN
F 1 "VCC" H 6265 6323 50  0000 C CNN
F 2 "" H 6250 6150 50  0001 C CNN
F 3 "" H 6250 6150 50  0001 C CNN
	1    6250 6150
	1    0    0    -1  
$EndComp
Wire Wire Line
	2200 1650 2100 1650
Text GLabel 2100 1650 0    50   Input ~ 0
~IO_DBG
$Comp
L main-rescue:Edge72-Mini8086 X2
U 1 1 5F808933
P 2650 2850
F 0 "X2" H 2675 4815 50  0000 C CNN
F 1 "Edge72" H 2675 4724 50  0000 C CNN
F 2 "Mini8086:BUS_72" H 3200 2850 50  0001 C CNN
F 3 "" H 3200 2850 50  0001 C CNN
	1    2650 2850
	1    0    0    -1  
$EndComp
Wire Wire Line
	2200 1550 1650 1550
Wire Wire Line
	2200 1450 2100 1450
Text GLabel 1650 1550 0    50   Input ~ 0
NMI
Text GLabel 2100 1450 0    50   Input ~ 0
TMR2
$Comp
L Regulator_Linear:LM317_SOT-223 U3
U 1 1 6010476C
P 5550 1850
F 0 "U3" H 5550 2092 50  0000 C CNN
F 1 "LM317" H 5550 2001 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-223-3_TabPin2" H 5550 2100 50  0001 C CIN
F 3 "http://www.ti.com/lit/ds/symlink/lm317.pdf" H 5550 1850 50  0001 C CNN
	1    5550 1850
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0114
U 1 1 60104EBB
P 5050 1350
F 0 "#PWR0114" H 5050 1200 50  0001 C CNN
F 1 "VCC" H 5065 1523 50  0000 C CNN
F 2 "" H 5050 1350 50  0001 C CNN
F 3 "" H 5050 1350 50  0001 C CNN
	1    5050 1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5250 1850 5050 1850
Wire Wire Line
	5050 1850 5050 1450
Wire Wire Line
	5850 1850 5950 1850
Text GLabel 9550 1850 2    50   Output ~ 0
VCC36
$Comp
L Device:C C1
U 1 1 6006F75E
P 5050 2200
F 0 "C1" H 5165 2246 50  0000 L CNN
F 1 "100n" H 5165 2155 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 5088 2050 50  0001 C CNN
F 3 "~" H 5050 2200 50  0001 C CNN
	1    5050 2200
	1    0    0    -1  
$EndComp
$Comp
L Device:R_POT_TRIM RV1
U 1 1 6006FFA5
P 5550 2400
F 0 "RV1" H 5481 2446 50  0000 R CNN
F 1 "500" H 5481 2355 50  0000 R CNN
F 2 "Potentiometer_THT:Potentiometer_Runtron_RM-065_Vertical" H 5550 2400 50  0001 C CNN
F 3 "~" H 5550 2400 50  0001 C CNN
	1    5550 2400
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R4
U 1 1 60071081
P 5950 2050
F 0 "R4" H 6009 2096 50  0000 L CNN
F 1 "180/200" H 6009 2005 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" H 5950 2050 50  0001 C CNN
F 3 "~" H 5950 2050 50  0001 C CNN
	1    5950 2050
	1    0    0    -1  
$EndComp
Wire Wire Line
	5550 2250 5550 2200
Wire Wire Line
	5050 2050 5050 1850
Connection ~ 5050 1850
Wire Wire Line
	5050 2350 5050 2600
Wire Wire Line
	5050 2600 5550 2600
Wire Wire Line
	5550 2600 5550 2550
Connection ~ 5550 2600
Wire Wire Line
	5550 2200 5950 2200
Wire Wire Line
	5950 2200 5950 2150
Connection ~ 5550 2200
Wire Wire Line
	5550 2200 5550 2150
Wire Wire Line
	5950 1950 5950 1850
Connection ~ 5950 1850
$Comp
L power:GND #PWR03
U 1 1 6009167C
P 5550 2700
F 0 "#PWR03" H 5550 2450 50  0001 C CNN
F 1 "GND" H 5555 2527 50  0000 C CNN
F 2 "" H 5550 2700 50  0001 C CNN
F 3 "" H 5550 2700 50  0001 C CNN
	1    5550 2700
	1    0    0    -1  
$EndComp
Wire Wire Line
	5550 2700 5550 2600
$Comp
L Device:CP C2
U 1 1 60098FDC
P 6600 2200
F 0 "C2" H 6718 2246 50  0000 L CNN
F 1 "47u" H 6718 2155 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D4.0mm_P2.00mm" H 6638 2050 50  0001 C CNN
F 3 "~" H 6600 2200 50  0001 C CNN
	1    6600 2200
	1    0    0    -1  
$EndComp
$Comp
L Device:C C3
U 1 1 60099B41
P 7000 2200
F 0 "C3" H 7115 2246 50  0000 L CNN
F 1 "100n" H 7115 2155 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 7038 2050 50  0001 C CNN
F 3 "~" H 7000 2200 50  0001 C CNN
	1    7000 2200
	1    0    0    -1  
$EndComp
$Comp
L Device:C C13
U 1 1 6009A101
P 7400 2200
F 0 "C13" H 7515 2246 50  0000 L CNN
F 1 "100n" H 7515 2155 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 7438 2050 50  0001 C CNN
F 3 "~" H 7400 2200 50  0001 C CNN
	1    7400 2200
	1    0    0    -1  
$EndComp
$Comp
L Device:C C15
U 1 1 6009A4DA
P 7800 2200
F 0 "C15" H 7915 2246 50  0000 L CNN
F 1 "100n" H 7915 2155 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 7838 2050 50  0001 C CNN
F 3 "~" H 7800 2200 50  0001 C CNN
	1    7800 2200
	1    0    0    -1  
$EndComp
$Comp
L Device:C C17
U 1 1 6009A767
P 8200 2200
F 0 "C17" H 8315 2246 50  0000 L CNN
F 1 "100n" H 8315 2155 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 8238 2050 50  0001 C CNN
F 3 "~" H 8200 2200 50  0001 C CNN
	1    8200 2200
	1    0    0    -1  
$EndComp
$Comp
L Device:C C19
U 1 1 6009A989
P 8600 2200
F 0 "C19" H 8715 2246 50  0000 L CNN
F 1 "100n" H 8715 2155 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 8638 2050 50  0001 C CNN
F 3 "~" H 8600 2200 50  0001 C CNN
	1    8600 2200
	1    0    0    -1  
$EndComp
$Comp
L Device:C C21
U 1 1 6009AB78
P 9000 2200
F 0 "C21" H 9115 2246 50  0000 L CNN
F 1 "100n" H 9115 2155 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 9038 2050 50  0001 C CNN
F 3 "~" H 9000 2200 50  0001 C CNN
	1    9000 2200
	1    0    0    -1  
$EndComp
$Comp
L Device:C C23
U 1 1 6009E705
P 9400 2200
F 0 "C23" H 9515 2246 50  0000 L CNN
F 1 "100n" H 9515 2155 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 9438 2050 50  0001 C CNN
F 3 "~" H 9400 2200 50  0001 C CNN
	1    9400 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	9400 2350 9400 2600
Wire Wire Line
	9000 2350 9000 2600
Connection ~ 9000 2600
Wire Wire Line
	9000 2600 9400 2600
Wire Wire Line
	5550 2600 6600 2600
Connection ~ 8600 2600
Wire Wire Line
	8600 2600 9000 2600
Connection ~ 8200 2600
Wire Wire Line
	8200 2600 8600 2600
Wire Wire Line
	7800 2350 7800 2600
Connection ~ 7800 2600
Wire Wire Line
	7800 2600 8200 2600
Wire Wire Line
	7400 2350 7400 2600
Connection ~ 7400 2600
Wire Wire Line
	7400 2600 7800 2600
Wire Wire Line
	7000 2350 7000 2600
Connection ~ 7000 2600
Wire Wire Line
	6600 2350 6600 2600
Connection ~ 6600 2600
Wire Wire Line
	6600 2600 7000 2600
Wire Wire Line
	6600 2050 6600 1850
Wire Wire Line
	5950 1850 6600 1850
Connection ~ 6600 1850
Wire Wire Line
	6600 1850 7000 1850
Wire Wire Line
	7000 2050 7000 1850
Connection ~ 7000 1850
Wire Wire Line
	7400 2050 7400 1850
Connection ~ 7400 1850
Wire Wire Line
	7400 1850 7800 1850
Wire Wire Line
	7800 2050 7800 1850
Connection ~ 7800 1850
Wire Wire Line
	7800 1850 8200 1850
Wire Wire Line
	8200 2050 8200 1850
Connection ~ 8200 1850
Wire Wire Line
	8200 1850 8600 1850
Wire Wire Line
	8600 2050 8600 1850
Connection ~ 8600 1850
Wire Wire Line
	8600 1850 9000 1850
Wire Wire Line
	9000 2050 9000 1850
Connection ~ 9000 1850
Wire Wire Line
	9000 1850 9400 1850
Wire Wire Line
	9400 2050 9400 1850
Connection ~ 9400 1850
Wire Wire Line
	9400 1850 9550 1850
Wire Wire Line
	8200 2350 8200 2600
Wire Wire Line
	8600 2350 8600 2600
Text GLabel 9550 2900 2    50   Output ~ 0
VCC36
$Comp
L Device:C C14
U 1 1 6010E07C
P 7400 3250
F 0 "C14" H 7515 3296 50  0000 L CNN
F 1 "100n" H 7515 3205 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 7438 3100 50  0001 C CNN
F 3 "~" H 7400 3250 50  0001 C CNN
	1    7400 3250
	1    0    0    -1  
$EndComp
$Comp
L Device:C C16
U 1 1 6010E082
P 7800 3250
F 0 "C16" H 7915 3296 50  0000 L CNN
F 1 "100n" H 7915 3205 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 7838 3100 50  0001 C CNN
F 3 "~" H 7800 3250 50  0001 C CNN
	1    7800 3250
	1    0    0    -1  
$EndComp
$Comp
L Device:C C18
U 1 1 6010E088
P 8200 3250
F 0 "C18" H 8315 3296 50  0000 L CNN
F 1 "100n" H 8315 3205 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 8238 3100 50  0001 C CNN
F 3 "~" H 8200 3250 50  0001 C CNN
	1    8200 3250
	1    0    0    -1  
$EndComp
$Comp
L Device:C C20
U 1 1 6010E08E
P 8600 3250
F 0 "C20" H 8715 3296 50  0000 L CNN
F 1 "100n" H 8715 3205 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 8638 3100 50  0001 C CNN
F 3 "~" H 8600 3250 50  0001 C CNN
	1    8600 3250
	1    0    0    -1  
$EndComp
$Comp
L Device:C C22
U 1 1 6010E094
P 9000 3250
F 0 "C22" H 9115 3296 50  0000 L CNN
F 1 "100n" H 9115 3205 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 9038 3100 50  0001 C CNN
F 3 "~" H 9000 3250 50  0001 C CNN
	1    9000 3250
	1    0    0    -1  
$EndComp
$Comp
L Device:C C24
U 1 1 6010E09A
P 9400 3250
F 0 "C24" H 9515 3296 50  0000 L CNN
F 1 "100n" H 9515 3205 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 9438 3100 50  0001 C CNN
F 3 "~" H 9400 3250 50  0001 C CNN
	1    9400 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	9400 3400 9400 3650
Wire Wire Line
	9000 3400 9000 3650
Connection ~ 9000 3650
Wire Wire Line
	9000 3650 9400 3650
Connection ~ 8600 3650
Wire Wire Line
	8600 3650 9000 3650
Connection ~ 8200 3650
Wire Wire Line
	8200 3650 8600 3650
Wire Wire Line
	7800 3400 7800 3650
Connection ~ 7800 3650
Wire Wire Line
	7800 3650 8200 3650
Wire Wire Line
	7400 3400 7400 3650
Wire Wire Line
	7400 3650 7800 3650
Wire Wire Line
	7400 3100 7400 2900
Wire Wire Line
	7400 2900 7800 2900
Wire Wire Line
	7800 3100 7800 2900
Connection ~ 7800 2900
Wire Wire Line
	7800 2900 8200 2900
Wire Wire Line
	8200 3100 8200 2900
Connection ~ 8200 2900
Wire Wire Line
	8200 2900 8600 2900
Wire Wire Line
	8600 3100 8600 2900
Connection ~ 8600 2900
Wire Wire Line
	8600 2900 9000 2900
Wire Wire Line
	9000 3100 9000 2900
Connection ~ 9000 2900
Wire Wire Line
	9000 2900 9400 2900
Wire Wire Line
	9400 3100 9400 2900
Connection ~ 9400 2900
Wire Wire Line
	9400 2900 9550 2900
Wire Wire Line
	8200 3400 8200 3650
Wire Wire Line
	8600 3400 8600 3650
$Comp
L power:GND #PWR04
U 1 1 6014E111
P 9400 3700
F 0 "#PWR04" H 9400 3450 50  0001 C CNN
F 1 "GND" H 9405 3527 50  0000 C CNN
F 2 "" H 9400 3700 50  0001 C CNN
F 3 "" H 9400 3700 50  0001 C CNN
	1    9400 3700
	1    0    0    -1  
$EndComp
Wire Wire Line
	9400 3700 9400 3650
Connection ~ 9400 3650
$Comp
L Device:C C27
U 1 1 5FF29C41
P 7000 3250
F 0 "C27" H 7115 3296 50  0000 L CNN
F 1 "100n" H 7115 3205 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 7038 3100 50  0001 C CNN
F 3 "~" H 7000 3250 50  0001 C CNN
	1    7000 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	7400 2900 7000 2900
Wire Wire Line
	7000 2900 7000 3100
Connection ~ 7400 2900
Wire Wire Line
	7400 3650 7000 3650
Wire Wire Line
	7000 3650 7000 3400
Connection ~ 7400 3650
$Comp
L Device:C C26
U 1 1 5FF3793A
P 2650 6500
F 0 "C26" H 2765 6546 50  0000 L CNN
F 1 "100n" H 2765 6455 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 2688 6350 50  0001 C CNN
F 3 "~" H 2650 6500 50  0001 C CNN
	1    2650 6500
	1    0    0    -1  
$EndComp
$Comp
L Device:C C25
U 1 1 5FF37CF6
P 2250 6500
F 0 "C25" H 2365 6546 50  0000 L CNN
F 1 "100n" H 2365 6455 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 2288 6350 50  0001 C CNN
F 3 "~" H 2250 6500 50  0001 C CNN
	1    2250 6500
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 6250 2650 6350
Connection ~ 3050 6250
Wire Wire Line
	2250 6250 2250 6350
Wire Wire Line
	2250 6250 2650 6250
Connection ~ 2650 6250
Wire Wire Line
	2650 6250 3050 6250
Wire Wire Line
	3050 6750 2650 6750
Wire Wire Line
	2650 6750 2650 6650
Connection ~ 3050 6750
Wire Wire Line
	2650 6750 2250 6750
Wire Wire Line
	2250 6750 2250 6650
Connection ~ 2650 6750
$Comp
L Device:C C28
U 1 1 5FF76D7B
P 1850 6500
F 0 "C28" H 1965 6546 50  0000 L CNN
F 1 "100n" H 1965 6455 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 1888 6350 50  0001 C CNN
F 3 "~" H 1850 6500 50  0001 C CNN
	1    1850 6500
	1    0    0    -1  
$EndComp
Wire Wire Line
	2250 6250 1850 6250
Wire Wire Line
	1850 6250 1850 6350
Connection ~ 2250 6250
Wire Wire Line
	2250 6750 1850 6750
Wire Wire Line
	1850 6750 1850 6650
Connection ~ 2250 6750
Wire Wire Line
	5700 2400 5950 2400
Wire Wire Line
	5950 2400 5950 2200
Connection ~ 5950 2200
Wire Wire Line
	5450 6250 5850 6250
Wire Wire Line
	5450 6750 5850 6750
$Comp
L Connector:TestPoint TP1
U 1 1 601A50E9
P 6600 1450
F 0 "TP1" H 6658 1568 50  0000 L CNN
F 1 "3V6" H 6658 1477 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.5mm" H 6800 1450 50  0001 C CNN
F 3 "~" H 6800 1450 50  0001 C CNN
	1    6600 1450
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP2
U 1 1 601A57F7
P 6900 1450
F 0 "TP2" H 6958 1568 50  0000 L CNN
F 1 "GND" H 6958 1477 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.5mm" H 7100 1450 50  0001 C CNN
F 3 "~" H 7100 1450 50  0001 C CNN
	1    6900 1450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR07
U 1 1 601A5CEC
P 6900 1450
F 0 "#PWR07" H 6900 1200 50  0001 C CNN
F 1 "GND" H 6905 1277 50  0000 C CNN
F 2 "" H 6900 1450 50  0001 C CNN
F 3 "" H 6900 1450 50  0001 C CNN
	1    6900 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	6600 1450 6600 1850
$Comp
L Device:C C11
U 1 1 601BC1A5
P 1450 6500
F 0 "C11" H 1565 6546 50  0000 L CNN
F 1 "100n" H 1565 6455 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 1488 6350 50  0001 C CNN
F 3 "~" H 1450 6500 50  0001 C CNN
	1    1450 6500
	1    0    0    -1  
$EndComp
Wire Wire Line
	1850 6250 1450 6250
Wire Wire Line
	1450 6250 1450 6350
Connection ~ 1850 6250
Wire Wire Line
	1850 6750 1450 6750
Wire Wire Line
	1450 6750 1450 6650
Connection ~ 1850 6750
$Comp
L Device:CP C29
U 1 1 5FF35E42
P 5850 6500
F 0 "C29" H 5968 6546 50  0000 L CNN
F 1 "10µ" H 5968 6455 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D4.0mm_P2.00mm" H 5888 6350 50  0001 C CNN
F 3 "~" H 5850 6500 50  0001 C CNN
	1    5850 6500
	1    0    0    -1  
$EndComp
Wire Wire Line
	5850 6350 5850 6250
Connection ~ 5850 6250
Wire Wire Line
	5850 6250 6250 6250
Wire Wire Line
	5850 6650 5850 6750
Connection ~ 5850 6750
Wire Wire Line
	5850 6750 6250 6750
$Comp
L Device:D_Schottky D1
U 1 1 5FF27C73
P 5550 1450
F 0 "D1" H 5550 1667 50  0000 C CNN
F 1 "SS16" H 5550 1576 50  0000 C CNN
F 2 "Diode_SMD:D_SMA" H 5550 1450 50  0001 C CNN
F 3 "~" H 5550 1450 50  0001 C CNN
	1    5550 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	5950 1850 5950 1450
Wire Wire Line
	5950 1450 5700 1450
Wire Wire Line
	5400 1450 5050 1450
Connection ~ 5050 1450
Wire Wire Line
	5050 1450 5050 1350
$Comp
L Device:C C30
U 1 1 600020B9
P 6600 3250
F 0 "C30" H 6715 3296 50  0000 L CNN
F 1 "100n" H 6715 3205 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 6638 3100 50  0001 C CNN
F 3 "~" H 6600 3250 50  0001 C CNN
	1    6600 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	7000 2900 6600 2900
Wire Wire Line
	6600 2900 6600 3100
Connection ~ 7000 2900
Wire Wire Line
	7000 3650 6600 3650
Wire Wire Line
	6600 3650 6600 3400
Connection ~ 7000 3650
Wire Wire Line
	7000 2600 7400 2600
Wire Wire Line
	7000 1850 7400 1850
Wire Bus Line
	3600 2850 3600 4450
Wire Bus Line
	1800 2450 1800 4450
$EndSCHEMATC