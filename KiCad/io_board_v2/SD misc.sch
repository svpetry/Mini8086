EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 5 8
Title "Mini8086 I/O board"
Date "2020-11-05"
Rev "1.2"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text GLabel 7850 3300 0    50   Input ~ 0
D_EN
Text GLabel 8450 3300 2    50   Output ~ 0
~D_EN
Text GLabel 7850 2800 0    50   Input ~ 0
~SD_IRQ
Text GLabel 8450 2800 2    50   Output ~ 0
IRQ6
$Comp
L 74xx:74HCT04 U8
U 1 1 60221100
P 8150 2800
F 0 "U8" H 8150 3117 50  0000 C CNN
F 1 "74HCT04" H 8150 3026 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 8150 2800 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 8150 2800 50  0001 C CNN
	1    8150 2800
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HCT04 U8
U 2 1 60221AF0
P 8150 3300
F 0 "U8" H 8150 3617 50  0000 C CNN
F 1 "74HCT04" H 8150 3526 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 8150 3300 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 8150 3300 50  0001 C CNN
	2    8150 3300
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HCT04 U8
U 3 1 6022274C
P 8150 3800
F 0 "U8" H 8150 4117 50  0000 C CNN
F 1 "74HCT04" H 8150 4026 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 8150 3800 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 8150 3800 50  0001 C CNN
	3    8150 3800
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HCT04 U8
U 4 1 60222B65
P 8150 4300
F 0 "U8" H 8150 4617 50  0000 C CNN
F 1 "74HCT04" H 8150 4526 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 8150 4300 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 8150 4300 50  0001 C CNN
	4    8150 4300
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HCT04 U8
U 5 1 60222FB5
P 8150 4800
F 0 "U8" H 8150 5117 50  0000 C CNN
F 1 "74HCT04" H 8150 5026 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 8150 4800 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 8150 4800 50  0001 C CNN
	5    8150 4800
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HCT04 U8
U 6 1 60223441
P 8150 5300
F 0 "U8" H 8150 5617 50  0000 C CNN
F 1 "74HCT04" H 8150 5526 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 8150 5300 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 8150 5300 50  0001 C CNN
	6    8150 5300
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HCT04 U8
U 7 1 60223909
P 9750 4550
F 0 "U8" H 9980 4596 50  0000 L CNN
F 1 "74HCT04" H 9980 4505 50  0000 L CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 9750 4550 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 9750 4550 50  0001 C CNN
	7    9750 4550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0104
U 1 1 6022807C
P 9750 5050
F 0 "#PWR0104" H 9750 4800 50  0001 C CNN
F 1 "GND" H 9755 4877 50  0000 C CNN
F 2 "" H 9750 5050 50  0001 C CNN
F 3 "" H 9750 5050 50  0001 C CNN
	1    9750 5050
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0114
U 1 1 60228D10
P 9750 4050
F 0 "#PWR0114" H 9750 3900 50  0001 C CNN
F 1 "VCC" H 9765 4223 50  0000 C CNN
F 2 "" H 9750 4050 50  0001 C CNN
F 3 "" H 9750 4050 50  0001 C CNN
	1    9750 4050
	1    0    0    -1  
$EndComp
Text GLabel 7850 3800 0    50   Input ~ 0
CS_UART
Text GLabel 7850 4300 0    50   Input ~ 0
CS_8042
Text GLabel 7850 4800 0    50   Input ~ 0
CS_I2C
Text GLabel 8450 3800 2    50   Output ~ 0
~CS_UART
Text GLabel 8450 4300 2    50   Output ~ 0
~CS_8042
Text GLabel 8450 4800 2    50   Output ~ 0
~CS_I2C
$Comp
L power:GND #PWR0115
U 1 1 6022BD6D
P 4200 4800
F 0 "#PWR0115" H 4200 4550 50  0001 C CNN
F 1 "GND" H 4205 4627 50  0000 C CNN
F 2 "" H 4200 4800 50  0001 C CNN
F 3 "" H 4200 4800 50  0001 C CNN
	1    4200 4800
	1    0    0    -1  
$EndComp
Text GLabel 4200 3100 1    50   Input ~ 0
VCC3
Wire Wire Line
	4700 3400 4900 3400
Wire Wire Line
	4900 3500 4700 3500
Wire Wire Line
	4900 3600 4700 3600
Wire Wire Line
	4900 3700 4700 3700
Wire Wire Line
	4700 3800 4900 3800
Wire Wire Line
	4900 3900 4700 3900
Wire Wire Line
	4900 4000 4700 4000
Wire Wire Line
	4900 4100 4700 4100
Wire Wire Line
	3700 3700 3500 3700
Wire Wire Line
	3500 3600 3700 3600
Wire Wire Line
	3500 3500 3700 3500
Wire Wire Line
	3500 3400 3700 3400
Wire Wire Line
	3700 4100 3500 4100
Wire Wire Line
	3500 4000 3700 4000
Wire Wire Line
	3500 3900 3700 3900
Wire Wire Line
	3500 3800 3700 3800
Entry Wire Line
	4900 3400 5000 3300
Entry Wire Line
	4900 3500 5000 3400
Entry Wire Line
	4900 3600 5000 3500
Entry Wire Line
	4900 3700 5000 3600
Entry Wire Line
	4900 3800 5000 3700
Entry Wire Line
	4900 3900 5000 3800
Entry Wire Line
	4900 4000 5000 3900
Entry Wire Line
	4900 4100 5000 4000
Entry Wire Line
	3500 3400 3400 3300
Entry Wire Line
	3500 3500 3400 3400
Entry Wire Line
	3500 3600 3400 3500
Entry Wire Line
	3500 3700 3400 3600
Entry Wire Line
	3500 3800 3400 3700
Entry Wire Line
	3500 3900 3400 3800
Entry Wire Line
	3500 4000 3400 3900
Entry Wire Line
	3500 4100 3400 4000
Wire Bus Line
	5000 3200 5100 3200
Wire Bus Line
	3400 3200 3300 3200
Text GLabel 5100 3200 2    50   Output ~ 0
AL[3..10]
Text GLabel 3300 3200 0    50   Input ~ 0
A[0..19]
Text Label 3550 3400 0    50   ~ 0
A3
Text Label 3550 3500 0    50   ~ 0
A4
Text Label 3550 3600 0    50   ~ 0
A5
Text Label 3550 3700 0    50   ~ 0
A6
Text Label 3550 3800 0    50   ~ 0
A7
Text Label 3550 3900 0    50   ~ 0
A8
Text Label 3550 4000 0    50   ~ 0
A9
Text Label 3550 4100 0    50   ~ 0
A10
Text Label 4750 3400 0    50   ~ 0
AL3
Text Label 4750 3500 0    50   ~ 0
AL4
Text Label 4750 3600 0    50   ~ 0
AL5
Text Label 4750 3700 0    50   ~ 0
AL6
Text Label 4750 3800 0    50   ~ 0
AL7
Text Label 4750 3900 0    50   ~ 0
AL8
Text Label 4750 4000 0    50   ~ 0
AL9
Text Label 4750 4100 0    50   ~ 0
AL10
NoConn ~ 8450 5300
$Comp
L power:GND #PWR0118
U 1 1 6023B1B4
P 7850 5300
F 0 "#PWR0118" H 7850 5050 50  0001 C CNN
F 1 "GND" V 7855 5172 50  0000 R CNN
F 2 "" H 7850 5300 50  0001 C CNN
F 3 "" H 7850 5300 50  0001 C CNN
	1    7850 5300
	0    1    1    0   
$EndComp
$Comp
L 74xx:74HC245 U9
U 1 1 6027493D
P 4200 3900
F 0 "U9" H 3900 3200 50  0000 C CNN
F 1 "SN74LVC245A" H 4550 3200 50  0000 C CNN
F 2 "Package_SO:TSSOP-20_4.4x6.5mm_P0.65mm" H 4200 3900 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC245" H 4200 3900 50  0001 C CNN
	1    4200 3900
	1    0    0    -1  
$EndComp
Wire Wire Line
	4200 4800 4200 4750
Wire Wire Line
	4200 4750 3650 4750
Wire Wire Line
	3650 4750 3650 4400
Wire Wire Line
	3650 4400 3700 4400
Connection ~ 4200 4750
Wire Wire Line
	4200 4750 4200 4700
Text GLabel 3700 4300 0    50   Input ~ 0
VCC3
Wire Bus Line
	5000 3200 5000 4000
Wire Bus Line
	3400 3200 3400 4000
$EndSCHEMATC
