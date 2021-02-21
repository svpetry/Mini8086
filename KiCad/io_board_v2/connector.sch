EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 6 8
Title "Mini8086 I/O board"
Date "2020-11-05"
Rev "1.0"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
NoConn ~ 4500 3200
NoConn ~ 4500 3300
NoConn ~ 4500 3400
NoConn ~ 4500 3500
NoConn ~ 4500 3600
NoConn ~ 4500 3700
NoConn ~ 4500 3800
NoConn ~ 4500 3900
Wire Wire Line
	4500 5100 4550 5100
Wire Wire Line
	4550 5100 4550 5200
Wire Wire Line
	4500 5000 4550 5000
Wire Wire Line
	4550 5000 4550 5100
Connection ~ 4550 5100
Wire Wire Line
	4500 4900 4550 4900
Wire Wire Line
	4500 4800 4550 4800
Wire Wire Line
	4550 4800 4550 4900
Wire Wire Line
	3550 5100 3500 5100
Wire Wire Line
	3500 5100 3500 5200
Wire Wire Line
	3550 5000 3500 5000
Wire Wire Line
	3500 5000 3500 5100
Connection ~ 3500 5100
Wire Wire Line
	3550 4900 3500 4900
Wire Wire Line
	3550 4800 3500 4800
Wire Wire Line
	3500 4800 3500 4900
$Comp
L power:GND #PWR023
U 1 1 5F8CAFD2
P 4550 5200
F 0 "#PWR023" H 4550 4950 50  0001 C CNN
F 1 "GND" H 4555 5027 50  0000 C CNN
F 2 "" H 4550 5200 50  0001 C CNN
F 3 "" H 4550 5200 50  0001 C CNN
	1    4550 5200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR022
U 1 1 5F8CB129
P 3500 5200
F 0 "#PWR022" H 3500 4950 50  0001 C CNN
F 1 "GND" H 3505 5027 50  0000 C CNN
F 2 "" H 3500 5200 50  0001 C CNN
F 3 "" H 3500 5200 50  0001 C CNN
	1    3500 5200
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR020
U 1 1 5F8CB697
P 3100 4800
F 0 "#PWR020" H 3100 4650 50  0001 C CNN
F 1 "VCC" H 3115 4973 50  0000 C CNN
F 2 "" H 3100 4800 50  0001 C CNN
F 3 "" H 3100 4800 50  0001 C CNN
	1    3100 4800
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR025
U 1 1 5F8CC89B
P 4950 4800
F 0 "#PWR025" H 4950 4650 50  0001 C CNN
F 1 "VCC" H 4965 4973 50  0000 C CNN
F 2 "" H 4950 4800 50  0001 C CNN
F 3 "" H 4950 4800 50  0001 C CNN
	1    4950 4800
	1    0    0    -1  
$EndComp
Wire Wire Line
	4950 4800 4550 4800
Connection ~ 4550 4800
Wire Wire Line
	3100 4800 3500 4800
Connection ~ 3500 4800
Wire Wire Line
	3550 4700 3350 4700
Wire Wire Line
	3550 4600 3350 4600
Wire Wire Line
	3350 4500 3550 4500
Wire Wire Line
	3350 4400 3550 4400
Wire Wire Line
	3350 4300 3550 4300
Wire Wire Line
	3350 4200 3550 4200
Wire Wire Line
	3350 4100 3550 4100
Wire Wire Line
	3350 4000 3550 4000
Wire Wire Line
	3350 3900 3550 3900
Wire Wire Line
	3350 3800 3550 3800
Entry Wire Line
	3350 3700 3250 3600
Entry Wire Line
	3350 3800 3250 3700
Entry Wire Line
	3350 3900 3250 3800
Entry Wire Line
	3350 4000 3250 3900
Entry Wire Line
	3350 4100 3250 4000
Entry Wire Line
	3350 4200 3250 4100
Entry Wire Line
	3350 4300 3250 4200
Entry Wire Line
	3350 4400 3250 4300
Entry Wire Line
	3350 4500 3250 4400
Entry Wire Line
	3350 4600 3250 4500
Entry Wire Line
	3350 4700 3250 4600
Wire Bus Line
	3250 3500 3150 3500
Text GLabel 3150 3500 0    50   Output ~ 0
A[0..19]
NoConn ~ 3550 2600
NoConn ~ 3550 2500
NoConn ~ 3550 2400
NoConn ~ 3550 1900
NoConn ~ 3550 2000
Text GLabel 5850 1450 2    50   Output ~ 0
RESET
NoConn ~ 4500 2000
NoConn ~ 4500 2100
Wire Wire Line
	4500 2400 4700 2400
Wire Wire Line
	4500 2500 4950 2500
Text GLabel 4700 2400 2    50   Output ~ 0
~WR
Text GLabel 4950 2500 2    50   Output ~ 0
~RD
Wire Wire Line
	4950 2300 4500 2300
Text GLabel 4950 2300 2    50   Output ~ 0
M_~IO
Wire Wire Line
	4500 1600 4650 1600
Wire Wire Line
	4650 1600 4650 1450
Wire Wire Line
	4500 1700 4650 1700
Wire Wire Line
	4650 1700 4650 1600
Connection ~ 4650 1600
Wire Wire Line
	3550 1600 3400 1600
Wire Wire Line
	3400 1600 3400 1450
Wire Wire Line
	3550 1700 3400 1700
Wire Wire Line
	3400 1700 3400 1600
Connection ~ 3400 1600
$Comp
L power:GND #PWR024
U 1 1 5F8E7587
P 4650 1450
F 0 "#PWR024" H 4650 1200 50  0001 C CNN
F 1 "GND" H 4655 1277 50  0000 C CNN
F 2 "" H 4650 1450 50  0001 C CNN
F 3 "" H 4650 1450 50  0001 C CNN
	1    4650 1450
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR021
U 1 1 5F8E795D
P 3400 1450
F 0 "#PWR021" H 3400 1200 50  0001 C CNN
F 1 "GND" H 3405 1277 50  0000 C CNN
F 2 "" H 3400 1450 50  0001 C CNN
F 3 "" H 3400 1450 50  0001 C CNN
	1    3400 1450
	-1   0    0    1   
$EndComp
Wire Wire Line
	4500 4700 4700 4700
Wire Wire Line
	4700 4600 4500 4600
Wire Wire Line
	4700 4500 4500 4500
Wire Wire Line
	4700 4400 4500 4400
Wire Wire Line
	4700 4300 4500 4300
Wire Wire Line
	4700 4200 4500 4200
Wire Wire Line
	4700 4100 4500 4100
Wire Wire Line
	4700 4000 4500 4000
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
Wire Bus Line
	4800 3850 4900 3850
Text GLabel 4900 3850 2    50   BiDi ~ 0
D[0..7]
Text Label 4550 4700 0    50   ~ 0
D0
Text Label 4550 4600 0    50   ~ 0
D1
Text Label 4550 4500 0    50   ~ 0
D2
Text Label 4550 4400 0    50   ~ 0
D3
Text Label 4550 4300 0    50   ~ 0
D4
Text Label 4550 4200 0    50   ~ 0
D5
Text Label 4550 4100 0    50   ~ 0
D6
Text Label 4550 4000 0    50   ~ 0
D7
Wire Wire Line
	4700 2900 4500 2900
Text GLabel 4700 2900 2    50   Input ~ 0
IRQ4
Wire Wire Line
	4700 3100 4500 3100
Text GLabel 4700 3100 2    50   Input ~ 0
IRQ1
Wire Wire Line
	4700 2700 4500 2700
Text GLabel 4700 2700 2    50   Input ~ 0
IRQ6
NoConn ~ 4500 3000
NoConn ~ 4500 2800
Wire Wire Line
	3550 2200 3350 2200
Text GLabel 3350 2200 0    50   Output ~ 0
PCLK
NoConn ~ 4500 2200
Text Label 3400 4700 0    50   ~ 0
A0
Text Label 3400 4600 0    50   ~ 0
A1
Text Label 3400 4500 0    50   ~ 0
A2
Text Label 3400 4400 0    50   ~ 0
A3
Text Label 3400 4300 0    50   ~ 0
A4
Text Label 3400 4200 0    50   ~ 0
A5
Text Label 3400 4100 0    50   ~ 0
A6
Text Label 3400 4000 0    50   ~ 0
A7
Text Label 3400 3900 0    50   ~ 0
A8
Text Label 3400 3800 0    50   ~ 0
A9
NoConn ~ 3550 2700
NoConn ~ 3550 2300
Wire Wire Line
	4500 1900 5000 1900
Wire Wire Line
	5850 1450 5000 1450
Wire Wire Line
	5000 1450 5000 1900
Connection ~ 5000 1900
Wire Wire Line
	5000 1900 5150 1900
Wire Wire Line
	5750 1900 5850 1900
Text GLabel 5850 1900 2    50   Output ~ 0
~RESET
$Comp
L 74xx:74HC04 U4
U 4 1 5F902496
P 5450 1900
F 0 "U4" H 5450 2217 50  0000 C CNN
F 1 "74HCT04" H 5450 2126 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 5450 1900 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 5450 1900 50  0001 C CNN
	4    5450 1900
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC04 U4
U 5 1 5F90312F
P 5450 2600
F 0 "U4" H 5450 2917 50  0000 C CNN
F 1 "74HCT04" H 5450 2826 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 5450 2600 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 5450 2600 50  0001 C CNN
	5    5450 2600
	-1   0    0    1   
$EndComp
$Comp
L 74xx:74HC04 U4
U 6 1 5F904907
P 7350 1900
F 0 "U4" H 7350 2217 50  0000 C CNN
F 1 "74HCT04" H 7350 2126 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 7350 1900 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 7350 1900 50  0001 C CNN
	6    7350 1900
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC04 U4
U 7 1 5F904FC3
P 8550 4050
F 0 "U4" H 8780 4096 50  0000 L CNN
F 1 "74HCT04" H 8780 4005 50  0000 L CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 8550 4050 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 8550 4050 50  0001 C CNN
	7    8550 4050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR059
U 1 1 5F90625F
P 8550 4550
F 0 "#PWR059" H 8550 4300 50  0001 C CNN
F 1 "GND" H 8555 4377 50  0000 C CNN
F 2 "" H 8550 4550 50  0001 C CNN
F 3 "" H 8550 4550 50  0001 C CNN
	1    8550 4550
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR058
U 1 1 5F90653C
P 8550 3550
F 0 "#PWR058" H 8550 3400 50  0001 C CNN
F 1 "VCC" H 8565 3723 50  0000 C CNN
F 2 "" H 8550 3550 50  0001 C CNN
F 3 "" H 8550 3550 50  0001 C CNN
	1    8550 3550
	1    0    0    -1  
$EndComp
Wire Wire Line
	7050 1900 6900 1900
Wire Wire Line
	6900 1900 6900 2500
$Comp
L power:GND #PWR057
U 1 1 5F90A6C0
P 6900 2700
F 0 "#PWR057" H 6900 2450 50  0001 C CNN
F 1 "GND" H 6905 2527 50  0000 C CNN
F 2 "" H 6900 2700 50  0001 C CNN
F 3 "" H 6900 2700 50  0001 C CNN
	1    6900 2700
	1    0    0    -1  
$EndComp
NoConn ~ 7650 1900
Wire Wire Line
	5150 2600 4500 2600
Wire Wire Line
	5750 2600 5850 2600
Text GLabel 5850 2600 2    50   Input ~ 0
~INT_I2C
Text Label 4700 2600 0    50   ~ 0
IRQ7
NoConn ~ 3550 2100
NoConn ~ 3550 3600
NoConn ~ 3550 3500
NoConn ~ 3550 3400
NoConn ~ 3550 3300
NoConn ~ 3550 2800
NoConn ~ 3550 3200
NoConn ~ 3550 3100
NoConn ~ 3550 3000
NoConn ~ 3550 2900
Wire Wire Line
	3550 3700 3350 3700
Text Label 3400 3700 0    50   ~ 0
A10
$Comp
L io_board-rescue:Edge72-Mini8086 X1
U 1 1 60029863
P 4000 3300
F 0 "X1" H 4025 5265 50  0000 C CNN
F 1 "Edge72" H 4025 5174 50  0000 C CNN
F 2 "Mini8086:BUS_72" H 4550 3300 50  0001 C CNN
F 3 "" H 4550 3300 50  0001 C CNN
	1    4000 3300
	1    0    0    -1  
$EndComp
Wire Wire Line
	3350 1800 3550 1800
Wire Wire Line
	4500 1800 4700 1800
Text GLabel 3350 1800 0    50   Input ~ 0
SCL
Text GLabel 4700 1800 2    50   Input ~ 0
SDA
$Comp
L 74xx:74HCT04 U4
U 3 1 6023B420
P 7350 2500
F 0 "U4" H 7350 2817 50  0000 C CNN
F 1 "74HCT04" H 7350 2726 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 7350 2500 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 7350 2500 50  0001 C CNN
	3    7350 2500
	1    0    0    -1  
$EndComp
Wire Wire Line
	7050 2500 6900 2500
Connection ~ 6900 2500
Wire Wire Line
	6900 2500 6900 2700
NoConn ~ 7650 2500
Wire Bus Line
	4800 3850 4800 4600
Wire Bus Line
	3250 3500 3250 4600
$EndSCHEMATC
