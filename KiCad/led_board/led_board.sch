EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 4
Title "Mini8086 LED board"
Date ""
Rev "1.1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L led_board-rescue:Edge72-Mini8086 X1
U 1 1 5FD2F4CE
P 3500 4000
F 0 "X1" H 3525 5965 50  0000 C CNN
F 1 "Edge72" H 3525 5874 50  0000 C CNN
F 2 "Mini8086:BUS_72" H 4050 4000 50  0001 C CNN
F 3 "" H 4050 4000 50  0001 C CNN
	1    3500 4000
	1    0    0    -1  
$EndComp
Wire Wire Line
	3050 5400 2300 5400
Wire Wire Line
	2300 5300 3050 5300
Wire Wire Line
	2300 5200 3050 5200
Wire Wire Line
	2300 5100 3050 5100
Wire Wire Line
	2300 5000 3050 5000
Wire Wire Line
	2300 4900 3050 4900
Wire Wire Line
	2300 4800 3050 4800
Wire Wire Line
	2300 4700 3050 4700
Wire Wire Line
	2300 4600 3050 4600
Wire Wire Line
	2300 4500 3050 4500
Wire Wire Line
	2300 4400 3050 4400
Wire Wire Line
	2300 4300 3050 4300
Wire Wire Line
	2300 4200 3050 4200
Wire Wire Line
	2300 4100 3050 4100
Wire Wire Line
	2300 4000 3050 4000
Wire Wire Line
	2300 3900 3050 3900
Wire Wire Line
	2300 3800 3050 3800
Wire Wire Line
	2300 3700 3050 3700
Wire Wire Line
	2300 3600 3050 3600
Wire Wire Line
	2300 3500 3050 3500
Wire Wire Line
	3050 5700 2950 5700
Wire Wire Line
	2950 5700 2950 5800
Wire Wire Line
	2950 5800 3050 5800
Wire Wire Line
	2950 5800 2950 5900
Connection ~ 2950 5800
Wire Wire Line
	4000 5700 4100 5700
Wire Wire Line
	4100 5700 4100 5800
Wire Wire Line
	4100 5800 4000 5800
Wire Wire Line
	4100 5800 4100 5900
Connection ~ 4100 5800
Wire Wire Line
	3050 5600 2950 5600
Wire Wire Line
	2950 5600 2950 5500
Wire Wire Line
	2950 5500 3050 5500
Wire Wire Line
	4000 5500 4100 5500
Wire Wire Line
	4100 5500 4100 5600
Wire Wire Line
	4100 5600 4000 5600
Wire Wire Line
	4000 5400 4700 5400
Wire Wire Line
	4700 5300 4000 5300
Wire Wire Line
	4700 5200 4000 5200
Wire Wire Line
	4700 5100 4000 5100
Wire Wire Line
	4700 5000 4000 5000
Wire Wire Line
	4700 4900 4000 4900
Wire Wire Line
	4700 4800 4000 4800
Wire Wire Line
	4700 4700 4000 4700
Wire Wire Line
	4700 4600 4000 4600
Wire Wire Line
	4700 4500 4000 4500
Wire Wire Line
	4700 4400 4000 4400
Wire Wire Line
	4700 4300 4000 4300
Wire Wire Line
	4700 4200 4000 4200
Wire Wire Line
	4700 4100 4000 4100
Wire Wire Line
	4700 4000 4000 4000
Wire Wire Line
	4700 3900 4000 3900
Entry Wire Line
	4700 3900 4800 3800
Entry Wire Line
	4700 4000 4800 3900
Entry Wire Line
	4700 4100 4800 4000
Entry Wire Line
	4700 4200 4800 4100
Entry Wire Line
	4700 4300 4800 4200
Entry Wire Line
	4700 4400 4800 4300
Entry Wire Line
	4700 4500 4800 4400
Entry Wire Line
	4700 4600 4800 4500
Entry Wire Line
	4700 4700 4800 4600
Entry Wire Line
	4700 4800 4800 4700
Entry Wire Line
	4700 4900 4800 4800
Entry Wire Line
	4700 5000 4800 4900
Entry Wire Line
	4700 5100 4800 5000
Entry Wire Line
	4700 5200 4800 5100
Entry Wire Line
	4700 5300 4800 5200
Entry Wire Line
	4700 5400 4800 5300
Entry Wire Line
	2300 5400 2200 5300
Entry Wire Line
	2300 5300 2200 5200
Entry Wire Line
	2300 5200 2200 5100
Entry Wire Line
	2300 5100 2200 5000
Entry Wire Line
	2300 5000 2200 4900
Entry Wire Line
	2300 4900 2200 4800
Entry Wire Line
	2300 4800 2200 4700
Entry Wire Line
	2300 4700 2200 4600
Entry Wire Line
	2300 4600 2200 4500
Entry Wire Line
	2300 4500 2200 4400
Entry Wire Line
	2300 4400 2200 4300
Entry Wire Line
	2300 4300 2200 4200
Entry Wire Line
	2300 4200 2200 4100
Entry Wire Line
	2300 4100 2200 4000
Entry Wire Line
	2300 4000 2200 3900
Entry Wire Line
	2300 3900 2200 3800
Entry Wire Line
	2300 3800 2200 3700
Entry Wire Line
	2300 3700 2200 3600
Entry Wire Line
	2300 3600 2200 3500
Entry Wire Line
	2300 3500 2200 3400
Wire Bus Line
	2200 3350 2100 3350
Wire Bus Line
	4800 3750 4900 3750
Text GLabel 4900 3750 2    50   Output ~ 0
D[0..15]
Text GLabel 2100 3350 0    50   Output ~ 0
A[0..19]
Wire Wire Line
	4100 5500 4200 5500
Connection ~ 4100 5500
Wire Wire Line
	2950 5500 2200 5500
Connection ~ 2950 5500
$Comp
L power:GND #PWR04
U 1 1 5FD50554
P 4100 5900
F 0 "#PWR04" H 4100 5650 50  0001 C CNN
F 1 "GND" H 4105 5727 50  0000 C CNN
F 2 "" H 4100 5900 50  0001 C CNN
F 3 "" H 4100 5900 50  0001 C CNN
	1    4100 5900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR03
U 1 1 5FD506AB
P 2950 5900
F 0 "#PWR03" H 2950 5650 50  0001 C CNN
F 1 "GND" H 2955 5727 50  0000 C CNN
F 2 "" H 2950 5900 50  0001 C CNN
F 3 "" H 2950 5900 50  0001 C CNN
	1    2950 5900
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR06
U 1 1 5FD50DF6
P 4200 5500
F 0 "#PWR06" H 4200 5350 50  0001 C CNN
F 1 "VCC" V 4215 5628 50  0000 L CNN
F 2 "" H 4200 5500 50  0001 C CNN
F 3 "" H 4200 5500 50  0001 C CNN
	1    4200 5500
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR01
U 1 1 5FD51049
P 2200 5500
F 0 "#PWR01" H 2200 5350 50  0001 C CNN
F 1 "VCC" V 2215 5627 50  0000 L CNN
F 2 "" H 2200 5500 50  0001 C CNN
F 3 "" H 2200 5500 50  0001 C CNN
	1    2200 5500
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3050 2400 2950 2400
Wire Wire Line
	2950 2400 2950 2300
Wire Wire Line
	2950 2300 3050 2300
Wire Wire Line
	4000 2400 4100 2400
Wire Wire Line
	4100 2400 4100 2300
Wire Wire Line
	4100 2300 4000 2300
Wire Wire Line
	2950 2300 2850 2300
Connection ~ 2950 2300
Wire Wire Line
	4100 2300 4200 2300
Connection ~ 4100 2300
$Comp
L power:GND #PWR05
U 1 1 5FD5917B
P 4200 2300
F 0 "#PWR05" H 4200 2050 50  0001 C CNN
F 1 "GND" V 4205 2172 50  0000 R CNN
F 2 "" H 4200 2300 50  0001 C CNN
F 3 "" H 4200 2300 50  0001 C CNN
	1    4200 2300
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR02
U 1 1 5FD592E7
P 2850 2300
F 0 "#PWR02" H 2850 2050 50  0001 C CNN
F 1 "GND" V 2855 2172 50  0000 R CNN
F 2 "" H 2850 2300 50  0001 C CNN
F 3 "" H 2850 2300 50  0001 C CNN
	1    2850 2300
	0    1    1    0   
$EndComp
Wire Wire Line
	4100 3800 4000 3800
Wire Wire Line
	4450 3700 4000 3700
Wire Wire Line
	4100 3600 4000 3600
Wire Wire Line
	4450 3500 4000 3500
Wire Wire Line
	4100 3400 4000 3400
Wire Wire Line
	4450 3300 4000 3300
Wire Wire Line
	4100 3200 4000 3200
Wire Wire Line
	4450 3100 4000 3100
Text GLabel 4100 3800 2    50   Output ~ 0
IRQ1
Text GLabel 4450 3700 2    50   Output ~ 0
IRQ3
Text GLabel 4100 3600 2    50   Output ~ 0
IRQ4
Text GLabel 4450 3500 2    50   Output ~ 0
IRQ5
Text GLabel 4100 3400 2    50   Output ~ 0
IRQ6
Text GLabel 4450 3300 2    50   Output ~ 0
IRQ7
Text GLabel 4100 3200 2    50   Output ~ 0
~RD
Text GLabel 4450 3100 2    50   Output ~ 0
~WR
Text GLabel 4100 3000 2    50   Output ~ 0
M_~IO
Wire Wire Line
	4100 3000 4000 3000
Wire Wire Line
	4000 2800 4100 2800
Wire Wire Line
	4000 2700 4450 2700
Wire Wire Line
	4000 2600 4100 2600
Text GLabel 4100 2800 2    50   Output ~ 0
~MEMRD
Text GLabel 4450 2700 2    50   Output ~ 0
~MEMWR
Text GLabel 4100 2600 2    50   Output ~ 0
RESET
Text Label 4400 3900 0    50   ~ 0
D15
Text Label 4400 4000 0    50   ~ 0
D14
Text Label 4400 4100 0    50   ~ 0
D13
Text Label 4400 4200 0    50   ~ 0
D12
Text Label 4400 4300 0    50   ~ 0
D11
Text Label 4400 4400 0    50   ~ 0
D10
Text Label 4400 4500 0    50   ~ 0
D9
Text Label 4400 4600 0    50   ~ 0
D8
Text Label 4400 4700 0    50   ~ 0
D7
Text Label 4400 4800 0    50   ~ 0
D6
Text Label 4400 4900 0    50   ~ 0
D5
Text Label 4400 5000 0    50   ~ 0
D4
Text Label 4400 5100 0    50   ~ 0
D3
Text Label 4400 5200 0    50   ~ 0
D2
Text Label 4400 5300 0    50   ~ 0
D1
Text Label 4400 5400 0    50   ~ 0
D0
Text Label 2650 5400 0    50   ~ 0
A0
Text Label 2650 5300 0    50   ~ 0
A1
Text Label 2650 5200 0    50   ~ 0
A2
Text Label 2650 5100 0    50   ~ 0
A3
Text Label 2650 5000 0    50   ~ 0
A4
Text Label 2650 4900 0    50   ~ 0
A5
Text Label 2650 4800 0    50   ~ 0
A6
Text Label 2650 4700 0    50   ~ 0
A7
Text Label 2650 4600 0    50   ~ 0
A8
Text Label 2650 4500 0    50   ~ 0
A9
Text Label 2650 4400 0    50   ~ 0
A10
Text Label 2650 4300 0    50   ~ 0
A11
Text Label 2650 4200 0    50   ~ 0
A12
Text Label 2650 4100 0    50   ~ 0
A13
Text Label 2650 4000 0    50   ~ 0
A14
Text Label 2650 3900 0    50   ~ 0
A15
Text Label 2650 3800 0    50   ~ 0
A16
Text Label 2650 3700 0    50   ~ 0
A17
Text Label 2650 3600 0    50   ~ 0
A18
Text Label 2650 3500 0    50   ~ 0
A19
Wire Wire Line
	2950 3300 3050 3300
Wire Wire Line
	2650 3200 3050 3200
Wire Wire Line
	2950 2700 3050 2700
Wire Wire Line
	2650 2600 3050 2600
Text GLabel 2950 3300 0    50   Output ~ 0
~VGA_IO
Text GLabel 2650 3200 0    50   Output ~ 0
~VGA_MEM
Text GLabel 2950 2700 0    50   Output ~ 0
NMI
Text GLabel 2650 2600 0    50   Output ~ 0
TMR2
$Sheet
S 1000 1000 500  500 
U 5FDA4A79
F0 "address LEDs" 50
F1 "address LEDs.sch" 50
$EndSheet
$Sheet
S 2000 1000 500  500 
U 5FDA4BBB
F0 "data LEDs" 50
F1 "data LEDs.sch" 50
$EndSheet
$Sheet
S 3000 1000 500  500 
U 5FDA4CF8
F0 "control LEDs" 50
F1 "control LEDs.sch" 50
$EndSheet
$Comp
L Device:C C1
U 1 1 5FDFF787
P 6500 3050
F 0 "C1" H 6615 3096 50  0000 L CNN
F 1 "100n" H 6615 3005 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 6538 2900 50  0001 C CNN
F 3 "~" H 6500 3050 50  0001 C CNN
F 4 "C24497" H 6500 3050 50  0001 C CNN "LCSC"
	1    6500 3050
	1    0    0    -1  
$EndComp
$Comp
L Device:C C2
U 1 1 5FDFFDE5
P 6900 3050
F 0 "C2" H 7015 3096 50  0000 L CNN
F 1 "100n" H 7015 3005 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 6938 2900 50  0001 C CNN
F 3 "~" H 6900 3050 50  0001 C CNN
F 4 "C24497" H 6900 3050 50  0001 C CNN "LCSC"
	1    6900 3050
	1    0    0    -1  
$EndComp
$Comp
L Device:C C3
U 1 1 5FE0009F
P 7300 3050
F 0 "C3" H 7415 3096 50  0000 L CNN
F 1 "100n" H 7415 3005 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 7338 2900 50  0001 C CNN
F 3 "~" H 7300 3050 50  0001 C CNN
F 4 "C24497" H 7300 3050 50  0001 C CNN "LCSC"
	1    7300 3050
	1    0    0    -1  
$EndComp
$Comp
L Device:C C4
U 1 1 5FE00307
P 7700 3050
F 0 "C4" H 7815 3096 50  0000 L CNN
F 1 "100n" H 7815 3005 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 7738 2900 50  0001 C CNN
F 3 "~" H 7700 3050 50  0001 C CNN
F 4 "C24497" H 7700 3050 50  0001 C CNN "LCSC"
	1    7700 3050
	1    0    0    -1  
$EndComp
Wire Wire Line
	6500 3200 6500 3300
Wire Wire Line
	6500 3300 6900 3300
Wire Wire Line
	7700 3200 7700 3300
Connection ~ 7700 3300
Wire Wire Line
	7700 3300 7700 3400
Wire Wire Line
	7300 3200 7300 3300
Connection ~ 7300 3300
Wire Wire Line
	7300 3300 7700 3300
Wire Wire Line
	6900 3200 6900 3300
Connection ~ 6900 3300
Wire Wire Line
	6900 3300 7300 3300
Wire Wire Line
	6500 2900 6500 2800
Wire Wire Line
	6500 2800 6900 2800
Wire Wire Line
	7700 2800 7700 2900
Wire Wire Line
	7700 2800 7700 2700
Connection ~ 7700 2800
Wire Wire Line
	7300 2900 7300 2800
Connection ~ 7300 2800
Wire Wire Line
	7300 2800 7700 2800
Wire Wire Line
	6900 2800 6900 2900
Connection ~ 6900 2800
Wire Wire Line
	6900 2800 7300 2800
$Comp
L power:GND #PWR08
U 1 1 5FE1F3D4
P 7700 3400
F 0 "#PWR08" H 7700 3150 50  0001 C CNN
F 1 "GND" H 7705 3227 50  0000 C CNN
F 2 "" H 7700 3400 50  0001 C CNN
F 3 "" H 7700 3400 50  0001 C CNN
	1    7700 3400
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR07
U 1 1 5FE1FA3A
P 7700 2700
F 0 "#PWR07" H 7700 2550 50  0001 C CNN
F 1 "VCC" H 7715 2873 50  0000 C CNN
F 2 "" H 7700 2700 50  0001 C CNN
F 3 "" H 7700 2700 50  0001 C CNN
	1    7700 2700
	1    0    0    -1  
$EndComp
NoConn ~ 3050 2900
NoConn ~ 3050 2500
NoConn ~ 4000 2500
NoConn ~ 3050 3400
$Comp
L Device:C C6
U 1 1 5FDC934D
P 6100 3050
F 0 "C6" H 6215 3096 50  0000 L CNN
F 1 "100n" H 6215 3005 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 6138 2900 50  0001 C CNN
F 3 "~" H 6100 3050 50  0001 C CNN
F 4 "C24497" H 6100 3050 50  0001 C CNN "LCSC"
	1    6100 3050
	1    0    0    -1  
$EndComp
$Comp
L Device:C C5
U 1 1 5FDC98D8
P 5700 3050
F 0 "C5" H 5815 3096 50  0000 L CNN
F 1 "100n" H 5815 3005 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 5738 2900 50  0001 C CNN
F 3 "~" H 5700 3050 50  0001 C CNN
F 4 "C24497" H 5700 3050 50  0001 C CNN "LCSC"
	1    5700 3050
	1    0    0    -1  
$EndComp
Wire Wire Line
	6500 3300 6100 3300
Wire Wire Line
	6100 3300 6100 3200
Connection ~ 6500 3300
Wire Wire Line
	6100 3300 5700 3300
Wire Wire Line
	5700 3300 5700 3200
Connection ~ 6100 3300
Wire Wire Line
	6500 2800 6100 2800
Wire Wire Line
	6100 2800 6100 2900
Connection ~ 6500 2800
Wire Wire Line
	6100 2800 5700 2800
Wire Wire Line
	5700 2800 5700 2900
Connection ~ 6100 2800
$Comp
L Device:C C7
U 1 1 5FD3BD32
P 5300 3050
F 0 "C7" H 5415 3096 50  0000 L CNN
F 1 "100n" H 5415 3005 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 5338 2900 50  0001 C CNN
F 3 "~" H 5300 3050 50  0001 C CNN
F 4 "C24497" H 5300 3050 50  0001 C CNN "LCSC"
	1    5300 3050
	1    0    0    -1  
$EndComp
Wire Wire Line
	5700 3300 5300 3300
Wire Wire Line
	5300 3300 5300 3200
Connection ~ 5700 3300
Wire Wire Line
	5300 2900 5300 2800
Wire Wire Line
	5300 2800 5700 2800
Connection ~ 5700 2800
Text GLabel 4450 2900 2    50   Output ~ 0
~BHE
Wire Wire Line
	4000 2900 4450 2900
NoConn ~ 3050 3100
NoConn ~ 3050 3000
NoConn ~ 3050 2800
Wire Bus Line
	4800 3750 4800 5300
Wire Bus Line
	2200 3350 2200 5300
$EndSCHEMATC
