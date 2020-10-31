EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 6 7
Title ""
Date ""
Rev "1.0"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Memory_EPROM:27C512 U?
U 1 1 5F8C6720
P 3300 2950
AR Path="/5F8065B9/5F8C6720" Ref="U?"  Part="1" 
AR Path="/5F8C5C81/5F8C6720" Ref="U6"  Part="1" 
F 0 "U6" H 3300 2950 50  0000 C CNN
F 1 "27C512" H 3500 1850 50  0000 C CNN
F 2 "Package_DIP:DIP-28_W15.24mm_Socket_LongPads" H 3300 2950 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/doc0015.pdf" H 3300 2950 50  0001 C CNN
	1    3300 2950
	1    0    0    -1  
$EndComp
Text Notes 2950 4450 0    50   ~ 0
io address decoder
$Comp
L power:GND #PWR028
U 1 1 5F8C684E
P 3300 4050
F 0 "#PWR028" H 3300 3800 50  0001 C CNN
F 1 "GND" H 3305 3877 50  0000 C CNN
F 2 "" H 3300 4050 50  0001 C CNN
F 3 "" H 3300 4050 50  0001 C CNN
	1    3300 4050
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR027
U 1 1 5F8C698C
P 3300 1850
F 0 "#PWR027" H 3300 1700 50  0001 C CNN
F 1 "VCC" H 3315 2023 50  0000 C CNN
F 2 "" H 3300 1850 50  0001 C CNN
F 3 "" H 3300 1850 50  0001 C CNN
	1    3300 1850
	1    0    0    -1  
$EndComp
Wire Wire Line
	2700 2050 2900 2050
Wire Wire Line
	2700 2150 2900 2150
Wire Wire Line
	2700 2250 2900 2250
Wire Wire Line
	2700 2350 2900 2350
Wire Wire Line
	2700 2450 2900 2450
Wire Wire Line
	2700 2550 2900 2550
Wire Wire Line
	2900 2650 2700 2650
Wire Wire Line
	2900 3550 2700 3550
Entry Wire Line
	2700 2050 2600 1950
Entry Wire Line
	2700 2150 2600 2050
Entry Wire Line
	2700 2250 2600 2150
Entry Wire Line
	2700 2350 2600 2250
Entry Wire Line
	2700 2450 2600 2350
Entry Wire Line
	2700 2550 2600 2450
Entry Wire Line
	2700 2650 2600 2550
Wire Wire Line
	2700 2750 2900 2750
Entry Wire Line
	2700 2750 2600 2650
Text Label 2750 2050 0    50   ~ 0
A3
Text Label 2750 2150 0    50   ~ 0
A4
Text Label 2750 2250 0    50   ~ 0
A5
Text Label 2750 2350 0    50   ~ 0
A6
Text Label 2750 2450 0    50   ~ 0
A7
Text Label 2750 2550 0    50   ~ 0
A8
Text Label 2750 2650 0    50   ~ 0
A9
Text Label 2750 2750 0    50   ~ 0
A10
Wire Wire Line
	2900 3250 2800 3250
Wire Wire Line
	2900 3150 2800 3150
Wire Wire Line
	2800 3150 2800 3250
Connection ~ 2800 3250
Wire Wire Line
	2900 3050 2800 3050
Wire Wire Line
	2800 3050 2800 3150
Connection ~ 2800 3150
Wire Wire Line
	2900 2950 2800 2950
Wire Wire Line
	2800 2950 2800 3050
Connection ~ 2800 3050
Wire Wire Line
	2800 2850 2900 2850
Connection ~ 2800 2950
Wire Wire Line
	2800 2950 2800 2850
Text GLabel 2700 3550 0    50   Input ~ 0
M_~IO
$Comp
L power:GND #PWR026
U 1 1 5F8C90A7
P 2800 4050
F 0 "#PWR026" H 2800 3800 50  0001 C CNN
F 1 "GND" H 2805 3877 50  0000 C CNN
F 2 "" H 2800 4050 50  0001 C CNN
F 3 "" H 2800 4050 50  0001 C CNN
	1    2800 4050
	1    0    0    -1  
$EndComp
Wire Bus Line
	2600 1850 2500 1850
Text GLabel 2500 1850 0    50   Input ~ 0
A[0..19]
Wire Wire Line
	2900 3750 2800 3750
Connection ~ 2800 3750
Wire Wire Line
	2800 3750 2800 3850
Wire Wire Line
	2900 3850 2800 3850
Connection ~ 2800 3850
Wire Wire Line
	2800 3850 2800 4050
Wire Wire Line
	3700 2050 3800 2050
Wire Wire Line
	3700 2150 4300 2150
Wire Wire Line
	3700 2250 3800 2250
Text GLabel 3800 2050 2    50   Output ~ 0
~CS_UART
Text GLabel 4300 2150 2    50   Output ~ 0
~CS_8042
Text GLabel 3800 2250 2    50   Output ~ 0
~CS_DRIVE
$Comp
L Device:C C10
U 1 1 5F8EBF44
P 6900 3500
F 0 "C10" H 7015 3546 50  0000 L CNN
F 1 "100n" H 7015 3455 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 6938 3350 50  0001 C CNN
F 3 "~" H 6900 3500 50  0001 C CNN
	1    6900 3500
	1    0    0    -1  
$EndComp
$Comp
L Device:C C11
U 1 1 5F8EC562
P 7350 3500
F 0 "C11" H 7465 3546 50  0000 L CNN
F 1 "100n" H 7465 3455 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 7388 3350 50  0001 C CNN
F 3 "~" H 7350 3500 50  0001 C CNN
	1    7350 3500
	1    0    0    -1  
$EndComp
$Comp
L Device:C C12
U 1 1 5F8EC8D7
P 7800 3500
F 0 "C12" H 7915 3546 50  0000 L CNN
F 1 "100n" H 7915 3455 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 7838 3350 50  0001 C CNN
F 3 "~" H 7800 3500 50  0001 C CNN
	1    7800 3500
	1    0    0    -1  
$EndComp
$Comp
L Device:C C13
U 1 1 5F8ECC23
P 8250 3500
F 0 "C13" H 8365 3546 50  0000 L CNN
F 1 "100n" H 8365 3455 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 8288 3350 50  0001 C CNN
F 3 "~" H 8250 3500 50  0001 C CNN
	1    8250 3500
	1    0    0    -1  
$EndComp
$Comp
L Device:C C14
U 1 1 5F8ED015
P 8700 3500
F 0 "C14" H 8815 3546 50  0000 L CNN
F 1 "100n" H 8815 3455 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 8738 3350 50  0001 C CNN
F 3 "~" H 8700 3500 50  0001 C CNN
	1    8700 3500
	1    0    0    -1  
$EndComp
$Comp
L Device:C C15
U 1 1 5F8EDB92
P 9150 3500
F 0 "C15" H 9265 3546 50  0000 L CNN
F 1 "100n" H 9265 3455 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 9188 3350 50  0001 C CNN
F 3 "~" H 9150 3500 50  0001 C CNN
	1    9150 3500
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C16
U 1 1 5F8EE20C
P 9600 3500
F 0 "C16" H 9718 3546 50  0000 L CNN
F 1 "47µ" H 9718 3455 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D6.3mm_P2.50mm" H 9638 3350 50  0001 C CNN
F 3 "~" H 9600 3500 50  0001 C CNN
	1    9600 3500
	1    0    0    -1  
$EndComp
Wire Wire Line
	9600 3650 9600 3750
Wire Wire Line
	9600 3750 9150 3750
Wire Wire Line
	6900 3750 6900 3650
Wire Wire Line
	6900 3350 6900 3250
Wire Wire Line
	6900 3250 7350 3250
Wire Wire Line
	9600 3250 9600 3350
Wire Wire Line
	9150 3350 9150 3250
Connection ~ 9150 3250
Wire Wire Line
	9150 3250 9600 3250
Wire Wire Line
	9150 3650 9150 3750
Connection ~ 9150 3750
Wire Wire Line
	9150 3750 8700 3750
Wire Wire Line
	8700 3650 8700 3750
Connection ~ 8700 3750
Wire Wire Line
	8700 3750 8250 3750
Wire Wire Line
	8700 3350 8700 3250
Connection ~ 8700 3250
Wire Wire Line
	8700 3250 9150 3250
Wire Wire Line
	8250 3350 8250 3250
Connection ~ 8250 3250
Wire Wire Line
	8250 3250 8700 3250
Wire Wire Line
	8250 3650 8250 3750
Connection ~ 8250 3750
Wire Wire Line
	8250 3750 7800 3750
Wire Wire Line
	7800 3250 7800 3350
Connection ~ 7800 3250
Wire Wire Line
	7800 3250 8250 3250
Wire Wire Line
	7800 3650 7800 3750
Connection ~ 7800 3750
Wire Wire Line
	7800 3750 7350 3750
Wire Wire Line
	7350 3750 7350 3650
Connection ~ 7350 3750
Wire Wire Line
	7350 3750 6900 3750
Wire Wire Line
	7350 3350 7350 3250
Connection ~ 7350 3250
Wire Wire Line
	7350 3250 7800 3250
Wire Wire Line
	9600 3750 9600 3850
Connection ~ 9600 3750
Wire Wire Line
	9600 3250 9600 3150
Connection ~ 9600 3250
$Comp
L power:VCC #PWR029
U 1 1 5F8F7E30
P 9600 3150
F 0 "#PWR029" H 9600 3000 50  0001 C CNN
F 1 "VCC" H 9615 3323 50  0000 C CNN
F 2 "" H 9600 3150 50  0001 C CNN
F 3 "" H 9600 3150 50  0001 C CNN
	1    9600 3150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR030
U 1 1 5F8F802C
P 9600 3850
F 0 "#PWR030" H 9600 3600 50  0001 C CNN
F 1 "GND" H 9605 3677 50  0000 C CNN
F 2 "" H 9600 3850 50  0001 C CNN
F 3 "" H 9600 3850 50  0001 C CNN
	1    9600 3850
	1    0    0    -1  
$EndComp
NoConn ~ 3700 2750
NoConn ~ 3700 2650
Wire Wire Line
	4300 2350 3700 2350
Text GLabel 4300 2350 2    50   Output ~ 0
~CS_BUFFER
Wire Wire Line
	2900 3450 2450 3450
Text GLabel 2450 3450 0    50   Input ~ 0
~RD
Wire Wire Line
	3700 2450 3800 2450
Text GLabel 3800 2450 2    50   Output ~ 0
~CS_DRVBUF
Wire Wire Line
	2800 3250 2800 3750
Wire Wire Line
	2700 3350 2900 3350
Text GLabel 2700 3350 0    50   Input ~ 0
~WR
$Comp
L Device:C C20
U 1 1 5F9CB403
P 6450 3500
F 0 "C20" H 6565 3546 50  0000 L CNN
F 1 "100n" H 6565 3455 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 6488 3350 50  0001 C CNN
F 3 "~" H 6450 3500 50  0001 C CNN
	1    6450 3500
	1    0    0    -1  
$EndComp
$Comp
L Device:C C19
U 1 1 5F9CB72A
P 6000 3500
F 0 "C19" H 6115 3546 50  0000 L CNN
F 1 "100n" H 6115 3455 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 6038 3350 50  0001 C CNN
F 3 "~" H 6000 3500 50  0001 C CNN
	1    6000 3500
	1    0    0    -1  
$EndComp
Wire Wire Line
	6450 3250 6450 3350
Wire Wire Line
	6450 3250 6900 3250
Connection ~ 6900 3250
Wire Wire Line
	6000 3350 6000 3250
Wire Wire Line
	6000 3250 6450 3250
Connection ~ 6450 3250
Wire Wire Line
	6450 3650 6450 3750
Wire Wire Line
	6450 3750 6900 3750
Connection ~ 6900 3750
Wire Wire Line
	6000 3650 6000 3750
Wire Wire Line
	6000 3750 6450 3750
Connection ~ 6450 3750
NoConn ~ 3700 2550
Wire Bus Line
	2600 1850 2600 2650
$EndSCHEMATC