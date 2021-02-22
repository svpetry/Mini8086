EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 3 7
Title "Mini8086 main system board"
Date ""
Rev "2.1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Memory_EPROM:27C512 U8
U 1 1 5F96D906
P 4600 3550
F 0 "U8" H 4600 3550 50  0000 C CNN
F 1 "27C512" H 4800 2500 50  0000 C CNN
F 2 "Package_DIP:DIP-28_W15.24mm_Socket_LongPads" H 4600 3550 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/doc0015.pdf" H 4600 3550 50  0001 C CNN
	1    4600 3550
	1    0    0    -1  
$EndComp
$Comp
L Memory_EPROM:27C512 U9
U 1 1 5F96EF70
P 6600 3550
F 0 "U9" H 6600 3550 50  0000 C CNN
F 1 "27C512" H 6800 2500 50  0000 C CNN
F 2 "Package_DIP:DIP-28_W15.24mm_Socket_LongPads" H 6600 3550 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/doc0015.pdf" H 6600 3550 50  0001 C CNN
	1    6600 3550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR028
U 1 1 5F971C7B
P 4600 4650
F 0 "#PWR028" H 4600 4400 50  0001 C CNN
F 1 "GND" H 4605 4477 50  0000 C CNN
F 2 "" H 4600 4650 50  0001 C CNN
F 3 "" H 4600 4650 50  0001 C CNN
	1    4600 4650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR030
U 1 1 5F971D93
P 6600 4650
F 0 "#PWR030" H 6600 4400 50  0001 C CNN
F 1 "GND" H 6605 4477 50  0000 C CNN
F 2 "" H 6600 4650 50  0001 C CNN
F 3 "" H 6600 4650 50  0001 C CNN
	1    6600 4650
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR029
U 1 1 5F9723EC
P 6600 2450
F 0 "#PWR029" H 6600 2300 50  0001 C CNN
F 1 "VCC" H 6615 2623 50  0000 C CNN
F 2 "" H 6600 2450 50  0001 C CNN
F 3 "" H 6600 2450 50  0001 C CNN
	1    6600 2450
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR027
U 1 1 5F972A41
P 4600 2450
F 0 "#PWR027" H 4600 2300 50  0001 C CNN
F 1 "VCC" H 4615 2623 50  0000 C CNN
F 2 "" H 4600 2450 50  0001 C CNN
F 3 "" H 4600 2450 50  0001 C CNN
	1    4600 2450
	1    0    0    -1  
$EndComp
Wire Wire Line
	5200 2650 5000 2650
Wire Wire Line
	5200 2750 5000 2750
Wire Wire Line
	5200 2850 5000 2850
Wire Wire Line
	5200 2950 5000 2950
Wire Wire Line
	5200 3050 5000 3050
Wire Wire Line
	5200 3150 5000 3150
Wire Wire Line
	5200 3250 5000 3250
Wire Wire Line
	5200 3350 5000 3350
Wire Wire Line
	7200 2650 7000 2650
Wire Wire Line
	7200 2750 7000 2750
Wire Wire Line
	7200 2850 7000 2850
Wire Wire Line
	7200 2950 7000 2950
Wire Wire Line
	7200 3050 7000 3050
Wire Wire Line
	7200 3150 7000 3150
Wire Wire Line
	7200 3250 7000 3250
Wire Wire Line
	7200 3350 7000 3350
Wire Wire Line
	6000 2650 6200 2650
Wire Wire Line
	6000 2750 6200 2750
Wire Wire Line
	6000 2850 6200 2850
Wire Wire Line
	6000 2950 6200 2950
Wire Wire Line
	6000 3050 6200 3050
Wire Wire Line
	6000 3150 6200 3150
Wire Wire Line
	6000 3250 6200 3250
Wire Wire Line
	6000 3350 6200 3350
Wire Wire Line
	6000 3450 6200 3450
Wire Wire Line
	6000 3550 6200 3550
Wire Wire Line
	6000 3650 6200 3650
Wire Wire Line
	6000 3750 6200 3750
Wire Wire Line
	6000 3850 6200 3850
Wire Wire Line
	6000 3950 6200 3950
Wire Wire Line
	6000 4050 6200 4050
Wire Wire Line
	6000 4150 6200 4150
Wire Wire Line
	4000 2650 4200 2650
Wire Wire Line
	4000 2750 4200 2750
Wire Wire Line
	4000 2850 4200 2850
Wire Wire Line
	4000 2950 4200 2950
Wire Wire Line
	4000 3050 4200 3050
Wire Wire Line
	4000 3150 4200 3150
Wire Wire Line
	4000 3250 4200 3250
Wire Wire Line
	4000 3350 4200 3350
Wire Wire Line
	4000 3450 4200 3450
Wire Wire Line
	4000 3550 4200 3550
Wire Wire Line
	4000 3650 4200 3650
Wire Wire Line
	4000 3750 4200 3750
Wire Wire Line
	4000 3850 4200 3850
Wire Wire Line
	4000 3950 4200 3950
Wire Wire Line
	4000 4050 4200 4050
Wire Wire Line
	4000 4150 4200 4150
Entry Wire Line
	4000 2650 3900 2550
Entry Wire Line
	4000 2750 3900 2650
Entry Wire Line
	4000 2850 3900 2750
Entry Wire Line
	4000 2950 3900 2850
Entry Wire Line
	4000 3050 3900 2950
Entry Wire Line
	4000 3150 3900 3050
Entry Wire Line
	4000 3250 3900 3150
Entry Wire Line
	4000 3350 3900 3250
Entry Wire Line
	4000 3450 3900 3350
Entry Wire Line
	4000 3550 3900 3450
Entry Wire Line
	4000 3650 3900 3550
Entry Wire Line
	4000 3750 3900 3650
Entry Wire Line
	4000 3850 3900 3750
Entry Wire Line
	4000 3950 3900 3850
Entry Wire Line
	4000 4050 3900 3950
Entry Wire Line
	4000 4150 3900 4050
Entry Wire Line
	5200 2650 5300 2550
Entry Wire Line
	5200 2750 5300 2650
Entry Wire Line
	5200 2850 5300 2750
Entry Wire Line
	5200 2950 5300 2850
Entry Wire Line
	5200 3050 5300 2950
Entry Wire Line
	5200 3150 5300 3050
Entry Wire Line
	5200 3250 5300 3150
Entry Wire Line
	5200 3350 5300 3250
Entry Wire Line
	6000 2650 5900 2550
Entry Wire Line
	6000 2750 5900 2650
Entry Wire Line
	6000 2850 5900 2750
Entry Wire Line
	6000 2950 5900 2850
Entry Wire Line
	6000 3050 5900 2950
Entry Wire Line
	6000 3150 5900 3050
Entry Wire Line
	6000 3250 5900 3150
Entry Wire Line
	6000 3350 5900 3250
Entry Wire Line
	6000 3450 5900 3350
Entry Wire Line
	6000 3550 5900 3450
Entry Wire Line
	6000 3650 5900 3550
Entry Wire Line
	6000 3750 5900 3650
Entry Wire Line
	6000 3850 5900 3750
Entry Wire Line
	6000 3950 5900 3850
Entry Wire Line
	6000 4050 5900 3950
Entry Wire Line
	6000 4150 5900 4050
Entry Wire Line
	7200 2650 7300 2550
Entry Wire Line
	7200 2750 7300 2650
Entry Wire Line
	7200 2850 7300 2750
Entry Wire Line
	7200 2950 7300 2850
Entry Wire Line
	7200 3050 7300 2950
Entry Wire Line
	7200 3150 7300 3050
Entry Wire Line
	7200 3250 7300 3150
Entry Wire Line
	7200 3350 7300 3250
Wire Wire Line
	6200 4350 6100 4350
Wire Wire Line
	6200 4450 5750 4450
Wire Wire Line
	4200 4450 4000 4450
Text GLabel 6100 4350 0    50   Input ~ 0
~ROMRD
Text GLabel 3750 4250 0    50   Input ~ 0
~ROMRD
Text GLabel 5750 4450 0    50   Input ~ 0
~BHE
Text Label 4050 2650 0    50   ~ 0
A1
Text Label 4050 2750 0    50   ~ 0
A2
Text Label 4050 2850 0    50   ~ 0
A3
Text Label 4050 2950 0    50   ~ 0
A4
Text Label 4050 3050 0    50   ~ 0
A5
Text Label 4050 3150 0    50   ~ 0
A6
Text Label 4050 3250 0    50   ~ 0
A7
Text Label 4050 3350 0    50   ~ 0
A8
Text Label 4050 3450 0    50   ~ 0
A9
Text Label 4050 3550 0    50   ~ 0
A10
Text Label 4050 3650 0    50   ~ 0
A11
Text Label 4050 3750 0    50   ~ 0
A12
Text Label 4050 3850 0    50   ~ 0
A13
Text Label 4050 3950 0    50   ~ 0
A14
Text Label 4050 4050 0    50   ~ 0
A15
Text Label 4050 4150 0    50   ~ 0
A16
Text Label 5050 2650 0    50   ~ 0
D0
Text Label 5050 2750 0    50   ~ 0
D1
Text Label 5050 2850 0    50   ~ 0
D2
Text Label 5050 2950 0    50   ~ 0
D3
Text Label 5050 3050 0    50   ~ 0
D4
Text Label 5050 3150 0    50   ~ 0
D5
Text Label 5050 3250 0    50   ~ 0
D6
Text Label 5050 3350 0    50   ~ 0
D7
Text Label 6050 2650 0    50   ~ 0
A1
Text Label 6050 2750 0    50   ~ 0
A2
Text Label 6050 2850 0    50   ~ 0
A3
Text Label 6050 2950 0    50   ~ 0
A4
Text Label 6050 3050 0    50   ~ 0
A5
Text Label 6050 4050 0    50   ~ 0
A15
Text Label 6050 3150 0    50   ~ 0
A6
Text Label 6050 3250 0    50   ~ 0
A7
Text Label 6050 3350 0    50   ~ 0
A8
Text Label 6050 3450 0    50   ~ 0
A9
Text Label 6050 3550 0    50   ~ 0
A10
Text Label 6050 3650 0    50   ~ 0
A11
Text Label 6050 3750 0    50   ~ 0
A12
Text Label 6050 3850 0    50   ~ 0
A13
Text Label 6050 3950 0    50   ~ 0
A14
Text Label 6050 4150 0    50   ~ 0
A16
Text Label 7050 2650 0    50   ~ 0
D8
Text Label 7050 2750 0    50   ~ 0
D9
Text Label 7050 2850 0    50   ~ 0
D10
Text Label 7050 2950 0    50   ~ 0
D11
Text Label 7050 3050 0    50   ~ 0
D12
Text Label 7050 3150 0    50   ~ 0
D13
Text Label 7050 3250 0    50   ~ 0
D14
Text Label 7050 3350 0    50   ~ 0
D15
Wire Bus Line
	3900 2100 5900 2100
Wire Bus Line
	5300 1950 7300 1950
Text Notes 6400 5000 0    50   ~ 0
odd ROM
Wire Bus Line
	5300 1950 5200 1950
Connection ~ 5300 1950
Wire Bus Line
	3900 2100 3800 2100
Connection ~ 3900 2100
Text GLabel 5200 1950 0    50   Output ~ 0
D[0..15]
Text GLabel 3800 2100 0    50   Input ~ 0
A[0..19]
Text Notes 4400 5000 0    50   ~ 0
even ROM
Entry Wire Line
	4000 4450 3900 4350
Wire Wire Line
	4200 4350 4100 4350
Wire Wire Line
	4100 4350 4100 4250
Wire Wire Line
	4100 4250 3750 4250
Text Label 4050 4450 0    50   ~ 0
A0
Wire Bus Line
	5300 1950 5300 3250
Wire Bus Line
	7300 1950 7300 3250
Wire Bus Line
	3900 2100 3900 4350
Wire Bus Line
	5900 2100 5900 4050
$EndSCHEMATC
