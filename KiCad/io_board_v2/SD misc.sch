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
Text GLabel 6900 3000 0    50   Input ~ 0
D_EN
Text GLabel 7500 3000 2    50   Output ~ 0
~D_EN
Text GLabel 6900 2500 0    50   Input ~ 0
~SD_IRQ
Text GLabel 7500 2500 2    50   Output ~ 0
IRQ6
$Comp
L 74xx:74HCT04 U8
U 1 1 60221100
P 7200 2500
F 0 "U8" H 7200 2817 50  0000 C CNN
F 1 "74HCT04" H 7200 2726 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 7200 2500 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 7200 2500 50  0001 C CNN
	1    7200 2500
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HCT04 U8
U 2 1 60221AF0
P 7200 3000
F 0 "U8" H 7200 3317 50  0000 C CNN
F 1 "74HCT04" H 7200 3226 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 7200 3000 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 7200 3000 50  0001 C CNN
	2    7200 3000
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HCT04 U8
U 3 1 6022274C
P 7200 3500
F 0 "U8" H 7200 3817 50  0000 C CNN
F 1 "74HCT04" H 7200 3726 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 7200 3500 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 7200 3500 50  0001 C CNN
	3    7200 3500
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HCT04 U8
U 4 1 60222B65
P 7200 4000
F 0 "U8" H 7200 4317 50  0000 C CNN
F 1 "74HCT04" H 7200 4226 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 7200 4000 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 7200 4000 50  0001 C CNN
	4    7200 4000
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HCT04 U8
U 5 1 60222FB5
P 7200 4500
F 0 "U8" H 7200 4817 50  0000 C CNN
F 1 "74HCT04" H 7200 4726 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 7200 4500 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 7200 4500 50  0001 C CNN
	5    7200 4500
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HCT04 U8
U 6 1 60223441
P 7200 5000
F 0 "U8" H 7200 5317 50  0000 C CNN
F 1 "74HCT04" H 7200 5226 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 7200 5000 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 7200 5000 50  0001 C CNN
	6    7200 5000
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HCT04 U8
U 7 1 60223909
P 8800 3550
F 0 "U8" H 9030 3596 50  0000 L CNN
F 1 "74HCT04" H 9030 3505 50  0000 L CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 8800 3550 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT04.pdf" H 8800 3550 50  0001 C CNN
	7    8800 3550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0104
U 1 1 6022807C
P 8800 4050
F 0 "#PWR0104" H 8800 3800 50  0001 C CNN
F 1 "GND" H 8805 3877 50  0000 C CNN
F 2 "" H 8800 4050 50  0001 C CNN
F 3 "" H 8800 4050 50  0001 C CNN
	1    8800 4050
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0114
U 1 1 60228D10
P 8800 3050
F 0 "#PWR0114" H 8800 2900 50  0001 C CNN
F 1 "VCC" H 8815 3223 50  0000 C CNN
F 2 "" H 8800 3050 50  0001 C CNN
F 3 "" H 8800 3050 50  0001 C CNN
	1    8800 3050
	1    0    0    -1  
$EndComp
Text GLabel 6900 3500 0    50   Input ~ 0
CS_UART
Text GLabel 6900 4000 0    50   Input ~ 0
CS_8042
Text GLabel 6900 4500 0    50   Input ~ 0
CS_I2C
Text GLabel 7500 3500 2    50   Output ~ 0
~CS_UART
Text GLabel 7500 4000 2    50   Output ~ 0
~CS_8042
Text GLabel 7500 4500 2    50   Output ~ 0
~CS_I2C
$Comp
L power:GND #PWR0115
U 1 1 6022BD6D
P 3250 4500
F 0 "#PWR0115" H 3250 4250 50  0001 C CNN
F 1 "GND" H 3255 4327 50  0000 C CNN
F 2 "" H 3250 4500 50  0001 C CNN
F 3 "" H 3250 4500 50  0001 C CNN
	1    3250 4500
	1    0    0    -1  
$EndComp
Text GLabel 3250 2800 1    50   Input ~ 0
VCC3
Wire Wire Line
	3750 3100 3950 3100
Wire Wire Line
	3950 3200 3750 3200
Wire Wire Line
	3950 3300 3750 3300
Wire Wire Line
	3950 3400 3750 3400
Wire Wire Line
	3750 3500 3950 3500
Wire Wire Line
	3950 3600 3750 3600
Wire Wire Line
	3950 3700 3750 3700
Wire Wire Line
	3950 3800 3750 3800
Wire Wire Line
	2750 3400 2550 3400
Wire Wire Line
	2550 3300 2750 3300
Wire Wire Line
	2550 3200 2750 3200
Wire Wire Line
	2550 3100 2750 3100
Wire Wire Line
	2750 3800 2550 3800
Wire Wire Line
	2550 3700 2750 3700
Wire Wire Line
	2550 3600 2750 3600
Wire Wire Line
	2550 3500 2750 3500
Entry Wire Line
	3950 3100 4050 3000
Entry Wire Line
	3950 3200 4050 3100
Entry Wire Line
	3950 3300 4050 3200
Entry Wire Line
	3950 3400 4050 3300
Entry Wire Line
	3950 3500 4050 3400
Entry Wire Line
	3950 3600 4050 3500
Entry Wire Line
	3950 3700 4050 3600
Entry Wire Line
	3950 3800 4050 3700
Entry Wire Line
	2550 3100 2450 3000
Entry Wire Line
	2550 3200 2450 3100
Entry Wire Line
	2550 3300 2450 3200
Entry Wire Line
	2550 3400 2450 3300
Entry Wire Line
	2550 3500 2450 3400
Entry Wire Line
	2550 3600 2450 3500
Entry Wire Line
	2550 3700 2450 3600
Entry Wire Line
	2550 3800 2450 3700
Wire Bus Line
	4050 2900 4150 2900
Wire Bus Line
	2450 2900 2350 2900
Text GLabel 4150 2900 2    50   Output ~ 0
AL[3..10]
Text GLabel 2350 2900 0    50   Input ~ 0
A[0..19]
Text Label 2600 3100 0    50   ~ 0
A3
Text Label 2600 3200 0    50   ~ 0
A4
Text Label 2600 3300 0    50   ~ 0
A5
Text Label 2600 3400 0    50   ~ 0
A6
Text Label 2600 3500 0    50   ~ 0
A7
Text Label 2600 3600 0    50   ~ 0
A8
Text Label 2600 3700 0    50   ~ 0
A9
Text Label 2600 3800 0    50   ~ 0
A10
Text Label 3800 3100 0    50   ~ 0
AL3
Text Label 3800 3200 0    50   ~ 0
AL4
Text Label 3800 3300 0    50   ~ 0
AL5
Text Label 3800 3400 0    50   ~ 0
AL6
Text Label 3800 3500 0    50   ~ 0
AL7
Text Label 3800 3600 0    50   ~ 0
AL8
Text Label 3800 3700 0    50   ~ 0
AL9
Text Label 3800 3800 0    50   ~ 0
AL10
NoConn ~ 7500 5000
$Comp
L power:GND #PWR0118
U 1 1 6023B1B4
P 6900 5000
F 0 "#PWR0118" H 6900 4750 50  0001 C CNN
F 1 "GND" V 6905 4872 50  0000 R CNN
F 2 "" H 6900 5000 50  0001 C CNN
F 3 "" H 6900 5000 50  0001 C CNN
	1    6900 5000
	0    1    1    0   
$EndComp
$Comp
L 74xx:74HC245 U9
U 1 1 6027493D
P 3250 3600
F 0 "U9" H 2950 2900 50  0000 C CNN
F 1 "SN74LVC245A" H 3600 2900 50  0000 C CNN
F 2 "Package_SO:TSSOP-20_4.4x6.5mm_P0.65mm" H 3250 3600 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC245" H 3250 3600 50  0001 C CNN
	1    3250 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	3250 4500 3250 4450
Wire Wire Line
	3250 4450 2700 4450
Wire Wire Line
	2700 4450 2700 4100
Wire Wire Line
	2700 4100 2750 4100
Connection ~ 3250 4450
Wire Wire Line
	3250 4450 3250 4400
Text GLabel 2750 4000 0    50   Input ~ 0
VCC3
Wire Bus Line
	4050 2900 4050 3700
Wire Bus Line
	2450 2900 2450 3700
$EndSCHEMATC
