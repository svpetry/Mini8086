EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 7
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
L Device:R R6
U 1 1 5F819246
P 1650 1200
F 0 "R6" H 1580 1154 50  0000 R CNN
F 1 "4K7" H 1580 1245 50  0000 R CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 1580 1200 50  0001 C CNN
F 3 "~" H 1650 1200 50  0001 C CNN
	1    1650 1200
	-1   0    0    1   
$EndComp
Text GLabel 1550 1950 0    50   Input ~ 0
RESET
Text GLabel 1550 1750 0    50   Input ~ 0
READY
Text GLabel 1550 1550 0    50   Input ~ 0
CLK
Wire Wire Line
	1750 1950 1550 1950
Wire Wire Line
	1750 1750 1550 1750
Wire Wire Line
	1750 1550 1550 1550
Text GLabel 3700 1900 2    50   BiDi ~ 0
AD[0..19]
Wire Bus Line
	3600 1900 3700 1900
Wire Wire Line
	3250 1850 3150 1850
Text GLabel 3250 1850 2    50   Output ~ 0
~BHE~_S7
Wire Wire Line
	3150 1750 3700 1750
Text GLabel 3700 1750 2    50   Output ~ 0
ALE
Text GLabel 3650 4250 2    50   Output ~ 0
M_~IO
$Comp
L power:GND #PWR0109
U 1 1 5FA5E367
P 1750 3450
F 0 "#PWR0109" H 1750 3200 50  0001 C CNN
F 1 "GND" H 1755 3277 50  0000 C CNN
F 2 "" H 1750 3450 50  0001 C CNN
F 3 "" H 1750 3450 50  0001 C CNN
	1    1750 3450
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 5F833B90
P 1650 1050
F 0 "#PWR0102" H 1650 800 50  0001 C CNN
F 1 "GND" H 1655 877 50  0000 C CNN
F 2 "" H 1650 1050 50  0001 C CNN
F 3 "" H 1650 1050 50  0001 C CNN
	1    1650 1050
	-1   0    0    1   
$EndComp
Wire Wire Line
	1650 2250 1600 2250
Connection ~ 1650 2250
Wire Wire Line
	1650 2250 1650 1350
Wire Wire Line
	1750 2250 1650 2250
NoConn ~ 1750 3250
Wire Wire Line
	3250 1650 3150 1650
Wire Wire Line
	3700 1550 3150 1550
Text GLabel 3700 1550 2    50   Output ~ 0
DT_~R
Text GLabel 3250 1650 2    50   Output ~ 0
~DEN
Text Label 3250 4050 0    50   ~ 0
AD19
Text Label 3250 3950 0    50   ~ 0
AD18
Text Label 3250 3850 0    50   ~ 0
AD17
Text Label 3250 3750 0    50   ~ 0
AD16
Text Label 3250 3550 0    50   ~ 0
AD15
Text Label 3250 3450 0    50   ~ 0
AD14
Text Label 3250 3350 0    50   ~ 0
AD13
Text Label 3250 3250 0    50   ~ 0
AD12
Text Label 3250 3150 0    50   ~ 0
AD11
Text Label 3250 3050 0    50   ~ 0
AD10
Text Label 3250 2950 0    50   ~ 0
AD9
Text Label 3250 2850 0    50   ~ 0
AD8
Text Label 3250 2750 0    50   ~ 0
AD7
Text Label 3250 2650 0    50   ~ 0
AD6
Text Label 3250 2550 0    50   ~ 0
AD5
Text Label 3250 2450 0    50   ~ 0
AD4
Text Label 3250 2350 0    50   ~ 0
AD3
Text Label 3250 2250 0    50   ~ 0
AD2
Text Label 3250 2150 0    50   ~ 0
AD1
Text Label 3250 2050 0    50   ~ 0
AD0
Entry Wire Line
	3500 4050 3600 3950
Entry Wire Line
	3500 3950 3600 3850
Entry Wire Line
	3500 3850 3600 3750
Entry Wire Line
	3500 3750 3600 3650
Entry Wire Line
	3500 3550 3600 3450
Entry Wire Line
	3500 3450 3600 3350
Entry Wire Line
	3500 3350 3600 3250
Entry Wire Line
	3500 3250 3600 3150
Entry Wire Line
	3500 3150 3600 3050
Entry Wire Line
	3500 3050 3600 2950
Entry Wire Line
	3500 2950 3600 2850
Entry Wire Line
	3500 2850 3600 2750
Entry Wire Line
	3500 2750 3600 2650
Entry Wire Line
	3500 2650 3600 2550
Entry Wire Line
	3500 2550 3600 2450
Entry Wire Line
	3500 2450 3600 2350
Entry Wire Line
	3500 2350 3600 2250
Entry Wire Line
	3500 2250 3600 2150
Entry Wire Line
	3500 2150 3600 2050
Entry Wire Line
	3500 2050 3600 1950
Wire Wire Line
	3500 4050 3150 4050
Wire Wire Line
	3500 3950 3150 3950
Wire Wire Line
	3500 3850 3150 3850
Wire Wire Line
	3500 3750 3150 3750
Wire Wire Line
	3500 3550 3150 3550
Wire Wire Line
	3500 3450 3150 3450
Wire Wire Line
	3500 3350 3150 3350
Wire Wire Line
	3500 3250 3150 3250
Wire Wire Line
	3500 3150 3150 3150
Wire Wire Line
	3500 3050 3150 3050
Wire Wire Line
	3500 2950 3150 2950
Wire Wire Line
	3500 2850 3150 2850
Wire Wire Line
	3500 2750 3150 2750
Wire Wire Line
	3150 2650 3500 2650
Wire Wire Line
	3500 2550 3150 2550
Wire Wire Line
	3500 2450 3150 2450
Wire Wire Line
	3500 2350 3150 2350
Wire Wire Line
	3150 2250 3500 2250
Wire Wire Line
	3150 2150 3500 2150
Wire Wire Line
	3150 2050 3500 2050
Text GLabel 1750 2450 0    50   Input ~ 0
INT
Text GLabel 1600 2250 0    50   Input ~ 0
NMI
Text GLabel 3250 4550 2    50   Output ~ 0
~INTA
Text GLabel 3650 4450 2    50   Output ~ 0
~RD
Text GLabel 3250 4350 2    50   Output ~ 0
~WR
Wire Wire Line
	3150 4350 3250 4350
Wire Wire Line
	3150 4250 3650 4250
Wire Wire Line
	3150 4450 3650 4450
Wire Wire Line
	3150 4550 3250 4550
$Comp
L power:GND #PWR011
U 1 1 5F792C8A
P 1750 2750
F 0 "#PWR011" H 1750 2500 50  0001 C CNN
F 1 "GND" H 1755 2577 50  0000 C CNN
F 2 "" H 1750 2750 50  0001 C CNN
F 3 "" H 1750 2750 50  0001 C CNN
	1    1750 2750
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR012
U 1 1 5F79210C
P 1750 4550
F 0 "#PWR012" H 1750 4400 50  0001 C CNN
F 1 "VCC" H 1765 4723 50  0000 C CNN
F 2 "" H 1750 4550 50  0001 C CNN
F 3 "" H 1750 4550 50  0001 C CNN
	1    1750 4550
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR015
U 1 1 5F74A069
P 2350 4850
F 0 "#PWR015" H 2350 4600 50  0001 C CNN
F 1 "GND" H 2355 4677 50  0000 C CNN
F 2 "" H 2350 4850 50  0001 C CNN
F 3 "" H 2350 4850 50  0001 C CNN
	1    2350 4850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR017
U 1 1 5F749B36
P 2550 4850
F 0 "#PWR017" H 2550 4600 50  0001 C CNN
F 1 "GND" H 2555 4677 50  0000 C CNN
F 2 "" H 2550 4850 50  0001 C CNN
F 3 "" H 2550 4850 50  0001 C CNN
	1    2550 4850
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR016
U 1 1 5F749511
P 2450 1250
F 0 "#PWR016" H 2450 1100 50  0001 C CNN
F 1 "VCC" H 2465 1423 50  0000 C CNN
F 2 "" H 2450 1250 50  0001 C CNN
F 3 "" H 2450 1250 50  0001 C CNN
	1    2450 1250
	1    0    0    -1  
$EndComp
$Comp
L MCU_Intel:8086_Min_Mode U4
U 1 1 5F740BF0
P 2450 3050
F 0 "U4" H 2450 3150 50  0000 C CNN
F 1 "8086" H 2450 3050 50  0000 C CNN
F 2 "Package_DIP:DIP-40_W15.24mm_Socket_LongPads" H 2500 3150 50  0001 C CIN
F 3 "http://datasheets.chipdb.org/Intel/x86/808x/datashts/8086/231455-006.pdf" H 2450 3100 50  0001 C CNN
	1    2450 3050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0111
U 1 1 5FC8586F
P 5350 3400
F 0 "#PWR0111" H 5350 3150 50  0001 C CNN
F 1 "GND" H 5355 3227 50  0000 C CNN
F 2 "" H 5350 3400 50  0001 C CNN
F 3 "" H 5350 3400 50  0001 C CNN
	1    5350 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	5350 3300 5350 3400
Wire Wire Line
	5100 2850 5100 3000
Wire Wire Line
	5350 3000 5350 2850
Wire Wire Line
	5100 3300 5100 3400
$Comp
L Device:R R8
U 1 1 5F82EE29
P 5100 3150
F 0 "R8" H 5030 3104 50  0000 R CNN
F 1 "4K7" H 5030 3195 50  0000 R CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 5030 3150 50  0001 C CNN
F 3 "~" H 5100 3150 50  0001 C CNN
	1    5100 3150
	1    0    0    -1  
$EndComp
$Comp
L Device:R R7
U 1 1 5F82E30F
P 5350 3150
F 0 "R7" H 5280 3104 50  0000 R CNN
F 1 "4K7" H 5280 3195 50  0000 R CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 5280 3150 50  0001 C CNN
F 3 "~" H 5350 3150 50  0001 C CNN
	1    5350 3150
	-1   0    0    1   
$EndComp
Text GLabel 5100 3400 3    50   Input ~ 0
RDY1
Text GLabel 5350 2850 1    50   Input ~ 0
RDY2
$Comp
L Mini8086:SN74ALVC164245 U1
U 1 1 6010C80C
P 8500 2050
F 0 "U1" H 8500 2100 50  0000 C CNN
F 1 "SN74ALVC164245" H 8500 1950 50  0000 C CNN
F 2 "Package_SO:SSOP-48_7.5x15.9mm_P0.635mm" H 8550 2050 50  0001 C CNN
F 3 "" H 8550 2050 50  0001 C CNN
	1    8500 2050
	1    0    0    -1  
$EndComp
Wire Wire Line
	8150 3200 8150 3250
Wire Wire Line
	8850 3250 8850 3200
Wire Wire Line
	8750 3250 8750 3200
Connection ~ 8750 3250
Wire Wire Line
	8750 3250 8850 3250
Wire Wire Line
	8650 3250 8650 3200
Connection ~ 8650 3250
Wire Wire Line
	8650 3250 8750 3250
Wire Wire Line
	8550 3250 8550 3200
Connection ~ 8550 3250
Wire Wire Line
	8550 3250 8650 3250
Wire Wire Line
	8450 3250 8450 3200
Connection ~ 8450 3250
Wire Wire Line
	8450 3250 8550 3250
Wire Wire Line
	8150 3250 8250 3250
Wire Wire Line
	8350 3200 8350 3250
Connection ~ 8350 3250
Wire Wire Line
	8350 3250 8450 3250
Wire Wire Line
	8250 3250 8250 3200
Connection ~ 8250 3250
Wire Wire Line
	8250 3250 8350 3250
$Comp
L power:GND #PWR0103
U 1 1 60119487
P 8850 3300
F 0 "#PWR0103" H 8850 3050 50  0001 C CNN
F 1 "GND" H 8855 3127 50  0000 C CNN
F 2 "" H 8850 3300 50  0001 C CNN
F 3 "" H 8850 3300 50  0001 C CNN
	1    8850 3300
	1    0    0    -1  
$EndComp
Wire Wire Line
	8350 900  8350 850 
Wire Wire Line
	8350 850  8250 850 
Wire Wire Line
	8250 850  8250 900 
Wire Wire Line
	8700 900  8700 850 
Wire Wire Line
	8700 850  8800 850 
Wire Wire Line
	8800 850  8800 900 
Connection ~ 8350 850 
Wire Wire Line
	8800 850  8950 850 
Connection ~ 8800 850 
Wire Wire Line
	8350 800  8350 850 
$Comp
L power:VCC #PWR0104
U 1 1 6011F897
P 8350 800
F 0 "#PWR0104" H 8350 650 50  0001 C CNN
F 1 "VCC" H 8365 973 50  0000 C CNN
F 2 "" H 8350 800 50  0001 C CNN
F 3 "" H 8350 800 50  0001 C CNN
	1    8350 800 
	1    0    0    -1  
$EndComp
Text GLabel 8950 850  2    50   Input ~ 0
VCC36
$Comp
L power:GND #PWR0105
U 1 1 60122CD9
P 9250 3000
F 0 "#PWR0105" H 9250 2750 50  0001 C CNN
F 1 "GND" V 9255 2872 50  0000 R CNN
F 2 "" H 9250 3000 50  0001 C CNN
F 3 "" H 9250 3000 50  0001 C CNN
	1    9250 3000
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0106
U 1 1 60123207
P 9250 1100
F 0 "#PWR0106" H 9250 850 50  0001 C CNN
F 1 "GND" V 9255 972 50  0000 R CNN
F 2 "" H 9250 1100 50  0001 C CNN
F 3 "" H 9250 1100 50  0001 C CNN
	1    9250 1100
	0    -1   -1   0   
$EndComp
Text GLabel 7250 3000 0    50   Input ~ 0
DATA_DIR
Wire Wire Line
	7750 1250 7350 1250
Wire Wire Line
	7350 1350 7750 1350
Wire Wire Line
	7350 1450 7750 1450
Wire Wire Line
	7350 1550 7750 1550
Wire Wire Line
	7350 1650 7750 1650
Wire Wire Line
	7350 1750 7750 1750
Wire Wire Line
	7350 1850 7750 1850
Wire Wire Line
	7350 1950 7750 1950
Wire Wire Line
	7750 2150 7350 2150
Wire Wire Line
	7350 2250 7750 2250
Wire Wire Line
	7350 2350 7750 2350
Wire Wire Line
	7350 2450 7750 2450
Wire Wire Line
	7350 2550 7750 2550
Wire Wire Line
	7350 2650 7750 2650
Wire Wire Line
	7350 2750 7750 2750
Wire Wire Line
	7350 2850 7750 2850
Entry Wire Line
	7350 1250 7250 1150
Entry Wire Line
	7350 1350 7250 1250
Entry Wire Line
	7350 1450 7250 1350
Entry Wire Line
	7350 1550 7250 1450
Entry Wire Line
	7350 1650 7250 1550
Entry Wire Line
	7350 1750 7250 1650
Entry Wire Line
	7350 1850 7250 1750
Entry Wire Line
	7350 1950 7250 1850
Entry Wire Line
	7350 2150 7250 2050
Entry Wire Line
	7350 2250 7250 2150
Entry Wire Line
	7350 2350 7250 2250
Entry Wire Line
	7350 2450 7250 2350
Entry Wire Line
	7350 2550 7250 2450
Entry Wire Line
	7350 2650 7250 2550
Entry Wire Line
	7350 2750 7250 2650
Entry Wire Line
	7350 2850 7250 2750
Wire Bus Line
	7250 1100 7150 1100
Text GLabel 7150 1100 0    50   BiDi ~ 0
AD[0..19]
Text Label 7500 1250 0    50   ~ 0
AD0
Text Label 7500 1350 0    50   ~ 0
AD1
Text Label 7500 1450 0    50   ~ 0
AD2
Text Label 7500 1550 0    50   ~ 0
AD3
Text Label 7500 1650 0    50   ~ 0
AD4
Text Label 7500 1750 0    50   ~ 0
AD5
Text Label 7500 1850 0    50   ~ 0
AD6
Text Label 7500 1950 0    50   ~ 0
AD7
Text Label 7500 2150 0    50   ~ 0
AD8
Text Label 7500 2250 0    50   ~ 0
AD9
Text Label 7500 2350 0    50   ~ 0
AD10
Text Label 7500 2450 0    50   ~ 0
AD11
Text Label 7500 2550 0    50   ~ 0
AD12
Text Label 7500 2650 0    50   ~ 0
AD13
Text Label 7500 2750 0    50   ~ 0
AD14
Text Label 7500 2850 0    50   ~ 0
AD15
Wire Wire Line
	7250 3000 7400 3000
Wire Wire Line
	7750 1100 7400 1100
Wire Wire Line
	7400 1100 7400 3000
Connection ~ 7400 3000
Wire Wire Line
	7400 3000 7750 3000
Wire Wire Line
	9250 1250 9650 1250
Wire Wire Line
	9650 1350 9250 1350
Wire Wire Line
	9250 1450 9650 1450
Wire Wire Line
	9650 1550 9250 1550
Wire Wire Line
	9250 1650 9650 1650
Wire Wire Line
	9650 1750 9250 1750
Wire Wire Line
	9250 1850 9650 1850
Wire Wire Line
	9650 1950 9250 1950
Wire Wire Line
	9250 2150 9650 2150
Wire Wire Line
	9650 2250 9250 2250
Wire Wire Line
	9250 2350 9650 2350
Wire Wire Line
	9650 2450 9250 2450
Wire Wire Line
	9250 2550 9650 2550
Wire Wire Line
	9650 2650 9250 2650
Wire Wire Line
	9250 2750 9650 2750
Wire Wire Line
	9650 2850 9250 2850
Entry Wire Line
	9650 1250 9750 1150
Entry Wire Line
	9650 1350 9750 1250
Entry Wire Line
	9650 1450 9750 1350
Entry Wire Line
	9650 1550 9750 1450
Entry Wire Line
	9650 1650 9750 1550
Entry Wire Line
	9650 1750 9750 1650
Entry Wire Line
	9650 1850 9750 1750
Entry Wire Line
	9650 1950 9750 1850
Entry Wire Line
	9650 2150 9750 2050
Entry Wire Line
	9650 2250 9750 2150
Entry Wire Line
	9650 2350 9750 2250
Entry Wire Line
	9650 2450 9750 2350
Entry Wire Line
	9650 2550 9750 2450
Entry Wire Line
	9650 2650 9750 2550
Entry Wire Line
	9650 2750 9750 2650
Entry Wire Line
	9650 2850 9750 2750
Wire Bus Line
	9750 1100 9850 1100
Text GLabel 9850 1100 2    50   BiDi ~ 0
LAD[0..19]
Wire Wire Line
	8850 3300 8850 3250
Connection ~ 8850 3250
Text Label 9350 1250 0    50   ~ 0
LAD0
Text Label 9350 1350 0    50   ~ 0
LAD1
Text Label 9350 1450 0    50   ~ 0
LAD2
Text Label 9350 1550 0    50   ~ 0
LAD3
Text Label 9350 1650 0    50   ~ 0
LAD4
Text Label 9350 1750 0    50   ~ 0
LAD5
Text Label 9350 1850 0    50   ~ 0
LAD6
Text Label 9350 1950 0    50   ~ 0
LAD7
Text Label 9350 2150 0    50   ~ 0
LAD8
Text Label 9350 2250 0    50   ~ 0
LAD9
Text Label 9350 2350 0    50   ~ 0
LAD10
Text Label 9350 2450 0    50   ~ 0
LAD11
Text Label 9350 2550 0    50   ~ 0
LAD12
Text Label 9350 2650 0    50   ~ 0
LAD13
Text Label 9350 2750 0    50   ~ 0
LAD14
Text Label 9350 2850 0    50   ~ 0
LAD15
$Comp
L Mini8086:SN74ALVC164245 U2
U 1 1 601A0E01
P 8500 4950
F 0 "U2" H 8500 5000 50  0000 C CNN
F 1 "SN74ALVC164245" H 8500 4850 50  0000 C CNN
F 2 "Package_SO:SSOP-48_7.5x15.9mm_P0.635mm" H 8550 4950 50  0001 C CNN
F 3 "" H 8550 4950 50  0001 C CNN
	1    8500 4950
	1    0    0    -1  
$EndComp
Wire Wire Line
	8150 6100 8150 6150
Wire Wire Line
	8850 6150 8850 6100
Wire Wire Line
	8750 6150 8750 6100
Connection ~ 8750 6150
Wire Wire Line
	8750 6150 8850 6150
Wire Wire Line
	8650 6150 8650 6100
Connection ~ 8650 6150
Wire Wire Line
	8650 6150 8750 6150
Wire Wire Line
	8550 6150 8550 6100
Connection ~ 8550 6150
Wire Wire Line
	8550 6150 8650 6150
Wire Wire Line
	8450 6150 8450 6100
Connection ~ 8450 6150
Wire Wire Line
	8450 6150 8550 6150
Wire Wire Line
	8150 6150 8250 6150
Wire Wire Line
	8350 6100 8350 6150
Connection ~ 8350 6150
Wire Wire Line
	8350 6150 8450 6150
Wire Wire Line
	8250 6150 8250 6100
Connection ~ 8250 6150
Wire Wire Line
	8250 6150 8350 6150
$Comp
L power:GND #PWR0107
U 1 1 601A0E1C
P 8850 6200
F 0 "#PWR0107" H 8850 5950 50  0001 C CNN
F 1 "GND" H 8855 6027 50  0000 C CNN
F 2 "" H 8850 6200 50  0001 C CNN
F 3 "" H 8850 6200 50  0001 C CNN
	1    8850 6200
	1    0    0    -1  
$EndComp
Wire Wire Line
	8350 3800 8350 3750
Wire Wire Line
	8350 3750 8250 3750
Wire Wire Line
	8250 3750 8250 3800
Wire Wire Line
	8700 3800 8700 3750
Wire Wire Line
	8700 3750 8800 3750
Wire Wire Line
	8800 3750 8800 3800
Connection ~ 8350 3750
Wire Wire Line
	8800 3750 8950 3750
Connection ~ 8800 3750
Text GLabel 8950 3750 2    50   Input ~ 0
VCC36
$Comp
L power:GND #PWR0108
U 1 1 601A0E33
P 9250 5900
F 0 "#PWR0108" H 9250 5650 50  0001 C CNN
F 1 "GND" V 9255 5772 50  0000 R CNN
F 2 "" H 9250 5900 50  0001 C CNN
F 3 "" H 9250 5900 50  0001 C CNN
	1    9250 5900
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0112
U 1 1 601A0E39
P 9250 4000
F 0 "#PWR0112" H 9250 3750 50  0001 C CNN
F 1 "GND" V 9255 3872 50  0000 R CNN
F 2 "" H 9250 4000 50  0001 C CNN
F 3 "" H 9250 4000 50  0001 C CNN
	1    9250 4000
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7750 4150 7350 4150
Wire Wire Line
	7350 4250 7750 4250
Wire Wire Line
	7350 4350 7750 4350
Wire Wire Line
	7350 4450 7750 4450
Wire Wire Line
	7350 4550 7750 4550
Wire Wire Line
	7350 4750 7750 4750
Wire Wire Line
	7750 5050 7350 5050
Wire Wire Line
	7350 5250 7750 5250
Entry Wire Line
	7350 4150 7250 4050
Entry Wire Line
	7350 4250 7250 4150
Entry Wire Line
	7350 4350 7250 4250
Entry Wire Line
	7350 4450 7250 4350
Wire Bus Line
	7250 4000 7150 4000
Text GLabel 7150 4000 0    50   Input ~ 0
AD[0..19]
Text Label 7500 4150 0    50   ~ 0
AD16
Text Label 7500 4250 0    50   ~ 0
AD17
Text Label 7500 4350 0    50   ~ 0
AD18
Text Label 7500 4450 0    50   ~ 0
AD19
Wire Wire Line
	9250 4150 9650 4150
Wire Wire Line
	9650 4250 9250 4250
Wire Wire Line
	9250 4350 9650 4350
Wire Wire Line
	9650 4450 9250 4450
Wire Wire Line
	9250 4550 9650 4550
Wire Wire Line
	9250 4750 9650 4750
Entry Wire Line
	9650 4150 9750 4050
Entry Wire Line
	9650 4250 9750 4150
Entry Wire Line
	9650 4350 9750 4250
Entry Wire Line
	9650 4450 9750 4350
Wire Bus Line
	9750 4000 9850 4000
Text GLabel 9850 4000 2    50   Output ~ 0
LAD[0..19]
Wire Wire Line
	8850 6200 8850 6150
Connection ~ 8850 6150
Text Label 9350 4150 0    50   ~ 0
LAD16
Text Label 9350 4250 0    50   ~ 0
LAD17
Text Label 9350 4350 0    50   ~ 0
LAD18
Text Label 9350 4450 0    50   ~ 0
LAD19
Wire Wire Line
	8350 3700 8350 3750
$Comp
L power:VCC #PWR0113
U 1 1 601A0E2C
P 8350 3700
F 0 "#PWR0113" H 8350 3550 50  0001 C CNN
F 1 "VCC" H 8365 3873 50  0000 C CNN
F 2 "" H 8350 3700 50  0001 C CNN
F 3 "" H 8350 3700 50  0001 C CNN
	1    8350 3700
	1    0    0    -1  
$EndComp
Text GLabel 7350 4550 0    50   Input ~ 0
~BHE~_S7
Wire Wire Line
	6950 4650 7750 4650
Wire Wire Line
	6950 4850 7750 4850
Wire Wire Line
	6950 5150 7750 5150
Wire Wire Line
	6950 5350 7750 5350
Text GLabel 6950 4650 0    50   Input ~ 0
DT_~R
Text GLabel 7350 4750 0    50   Input ~ 0
~DEN
Text GLabel 6950 4850 0    50   Input ~ 0
ALE
Text GLabel 7350 5050 0    50   Input ~ 0
M_~IO
Text GLabel 6950 5150 0    50   Input ~ 0
~WR
Text GLabel 7350 5250 0    50   Input ~ 0
~RD
Text GLabel 6950 5350 0    50   Input ~ 0
~INTA
Wire Wire Line
	9250 4650 10100 4650
Wire Wire Line
	9250 4850 10100 4850
Text GLabel 9650 4750 2    50   Output ~ 0
~DEN_3
Text GLabel 10100 4850 2    50   Output ~ 0
ALE_3
Wire Wire Line
	9250 5050 9650 5050
Wire Wire Line
	9250 5150 10100 5150
Wire Wire Line
	9250 5250 9650 5250
Wire Wire Line
	9250 5350 10100 5350
Text GLabel 9650 5050 2    50   Output ~ 0
M_~IO~_3
Text GLabel 10100 5150 2    50   Output ~ 0
~WR_3
Text GLabel 9650 5250 2    50   Output ~ 0
~RD_3
Text GLabel 10100 5350 2    50   Output ~ 0
~INTA_3
Text GLabel 10100 4650 2    50   Output ~ 0
DT_~R~_3
Text GLabel 9650 4550 2    50   Output ~ 0
~BHE~_S7_3
Text GLabel 5100 2850 1    50   Input ~ 0
VCC36
NoConn ~ 9250 5450
NoConn ~ 9250 5550
NoConn ~ 9250 5650
NoConn ~ 9250 5750
Wire Wire Line
	7750 5750 7650 5750
Wire Wire Line
	7650 5750 7650 5650
Wire Wire Line
	7650 5450 7750 5450
Wire Wire Line
	7750 5550 7650 5550
Connection ~ 7650 5550
Wire Wire Line
	7650 5550 7650 5450
Wire Wire Line
	7750 5650 7650 5650
Connection ~ 7650 5650
Wire Wire Line
	7650 5650 7650 5550
Connection ~ 7650 5750
$Comp
L power:GND #PWR0101
U 1 1 5FF4B1C8
P 7650 6250
F 0 "#PWR0101" H 7650 6000 50  0001 C CNN
F 1 "GND" H 7655 6077 50  0000 C CNN
F 2 "" H 7650 6250 50  0001 C CNN
F 3 "" H 7650 6250 50  0001 C CNN
	1    7650 6250
	1    0    0    -1  
$EndComp
Text Notes 6700 3250 0    50   ~ 0
0 = output (B -> A)\n1 = input (A -> B)\n
Wire Wire Line
	7750 5900 7650 5900
Wire Wire Line
	7650 5900 7650 5750
$Comp
L power:GND #PWR0110
U 1 1 6014334C
P 7750 4000
F 0 "#PWR0110" H 7750 3750 50  0001 C CNN
F 1 "GND" V 7750 3800 50  0000 C CNN
F 2 "" H 7750 4000 50  0001 C CNN
F 3 "" H 7750 4000 50  0001 C CNN
	1    7750 4000
	0    1    1    0   
$EndComp
Wire Wire Line
	7650 6250 7650 5900
Wire Bus Line
	9750 4000 9750 4350
Wire Bus Line
	7250 4000 7250 4350
Wire Bus Line
	9750 1100 9750 2750
Wire Bus Line
	7250 1100 7250 2750
Wire Bus Line
	3600 1900 3600 3950
Connection ~ 7650 5900
$EndSCHEMATC
