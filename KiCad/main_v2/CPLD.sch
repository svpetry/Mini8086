EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 6 7
Title "Mini8086 main system board"
Date ""
Rev "1.1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	3300 1250 2800 1250
Wire Wire Line
	3300 1350 3200 1350
Wire Wire Line
	3300 1450 2800 1450
Wire Wire Line
	3300 1550 3200 1550
Wire Wire Line
	3300 1650 2800 1650
Wire Wire Line
	3300 1750 3200 1750
Wire Wire Line
	3300 1850 2800 1850
Wire Wire Line
	3300 1950 3200 1950
Text GLabel 2800 1250 0    50   Output ~ 0
~MEMRD
Text GLabel 3200 1350 0    50   Output ~ 0
~MEMWR
Text GLabel 2800 1450 0    50   Output ~ 0
~ROMRD
Text GLabel 3200 1550 0    50   Output ~ 0
~IO_TIMER
Text GLabel 2800 1650 0    50   Output ~ 0
~IO_PIC
Text GLabel 3200 1750 0    50   Output ~ 0
~IO_DBG
Text GLabel 2800 1850 0    50   Output ~ 0
~VGA_MEM
Text GLabel 3200 1950 0    50   Output ~ 0
~VGA_IO
Text GLabel 6450 5250 2    50   Input ~ 0
~WR_3
Text GLabel 6000 5350 2    50   Input ~ 0
~RD_3
Text GLabel 2800 1250 0    50   Output ~ 0
~MEMRD
Text GLabel 3200 1350 0    50   Output ~ 0
~MEMWR
Text GLabel 2800 1450 0    50   Output ~ 0
~ROMRD
Text GLabel 3200 1550 0    50   Output ~ 0
~IO_TIMER
Text GLabel 2800 1650 0    50   Output ~ 0
~IO_PIC
Text GLabel 3200 1750 0    50   Output ~ 0
~IO_DBG
Text GLabel 2800 1850 0    50   Output ~ 0
~VGA_MEM
Text GLabel 3200 1950 0    50   Output ~ 0
~VGA_IO
$Comp
L CPLD_Altera:EPM570T144 U5
U 1 1 5FEE3AAE
P 4500 4250
F 0 "U5" H 4500 4350 50  0000 C CNN
F 1 "EPM570T144" H 4500 4250 50  0000 C CNN
F 2 "Package_QFP:LQFP-144_20x20mm_P0.5mm" H 5100 1000 50  0001 L CNN
F 3 "https://www.altera.com/content/dam/altera-www/global/en_US/pdfs/literature/hb/max2/max2_mii5v1.pdf" H 4500 4250 50  0001 C CNN
	1    4500 4250
	1    0    0    -1  
$EndComp
Wire Wire Line
	3900 950  3900 800 
Wire Wire Line
	3900 800  4000 800 
Wire Wire Line
	5000 800  5000 950 
Wire Wire Line
	4900 950  4900 800 
Connection ~ 4900 800 
Wire Wire Line
	4900 800  5000 800 
Wire Wire Line
	4800 950  4800 800 
Connection ~ 4800 800 
Wire Wire Line
	4800 800  4900 800 
Wire Wire Line
	4700 950  4700 800 
Connection ~ 4700 800 
Wire Wire Line
	4700 800  4800 800 
Wire Wire Line
	4600 950  4600 800 
Connection ~ 4600 800 
Wire Wire Line
	4600 800  4700 800 
Wire Wire Line
	4500 950  4500 800 
Connection ~ 4500 800 
Wire Wire Line
	4500 800  4600 800 
Wire Wire Line
	4400 950  4400 800 
Connection ~ 4400 800 
Wire Wire Line
	4400 800  4500 800 
Wire Wire Line
	4300 950  4300 800 
Wire Wire Line
	4300 800  4400 800 
Wire Wire Line
	4200 950  4200 800 
Wire Wire Line
	4100 950  4100 800 
Connection ~ 4100 800 
Wire Wire Line
	4100 800  4200 800 
Wire Wire Line
	4000 950  4000 800 
Connection ~ 4000 800 
Wire Wire Line
	4000 800  4100 800 
Wire Wire Line
	3900 7550 3900 7650
Wire Wire Line
	3900 7650 4000 7650
Wire Wire Line
	5000 7650 5000 7550
Wire Wire Line
	4900 7550 4900 7650
Connection ~ 4900 7650
Wire Wire Line
	4900 7650 5000 7650
Wire Wire Line
	4800 7550 4800 7650
Connection ~ 4800 7650
Wire Wire Line
	4800 7650 4900 7650
Wire Wire Line
	4700 7550 4700 7650
Connection ~ 4700 7650
Wire Wire Line
	4700 7650 4800 7650
Wire Wire Line
	4600 7550 4600 7650
Connection ~ 4600 7650
Wire Wire Line
	4600 7650 4700 7650
Wire Wire Line
	4500 7550 4500 7650
Connection ~ 4500 7650
Wire Wire Line
	4500 7650 4600 7650
Wire Wire Line
	4400 7550 4400 7650
Connection ~ 4400 7650
Wire Wire Line
	4400 7650 4500 7650
Wire Wire Line
	4300 7550 4300 7650
Connection ~ 4300 7650
Wire Wire Line
	4300 7650 4400 7650
Wire Wire Line
	4200 7550 4200 7650
Connection ~ 4200 7650
Wire Wire Line
	4200 7650 4300 7650
Wire Wire Line
	4100 7550 4100 7650
Connection ~ 4100 7650
Wire Wire Line
	4100 7650 4200 7650
Wire Wire Line
	4000 7550 4000 7650
Connection ~ 4000 7650
Wire Wire Line
	4000 7650 4100 7650
$Comp
L power:GND #PWR0115
U 1 1 5FF18020
P 5100 7650
F 0 "#PWR0115" H 5100 7400 50  0001 C CNN
F 1 "GND" V 5105 7522 50  0000 R CNN
F 2 "" H 5100 7650 50  0001 C CNN
F 3 "" H 5100 7650 50  0001 C CNN
	1    5100 7650
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5100 7650 5000 7650
Connection ~ 5000 7650
Wire Wire Line
	4200 800  4300 800 
Connection ~ 4200 800 
Connection ~ 4300 800 
Wire Wire Line
	5000 800  5100 800 
Connection ~ 5000 800 
Text GLabel 5100 800  2    50   Input ~ 0
VCC36
$Comp
L Oscillator:ASE-xxxMHz X3
U 1 1 5FF2431B
P 1600 2650
F 0 "X3" H 1350 2400 50  0000 L CNN
F 1 "60 MHz" H 1700 2400 50  0000 L CNN
F 2 "Oscillator:Oscillator_SMD_Abracon_ASV-4Pin_7.0x5.1mm" H 2300 2300 50  0001 C CNN
F 3 "http://www.abracon.com/Oscillators/ASV.pdf" H 1500 2650 50  0001 C CNN
	1    1600 2650
	1    0    0    -1  
$EndComp
Wire Wire Line
	3300 2650 1900 2650
$Comp
L power:GND #PWR0116
U 1 1 5FF28877
P 1600 2950
F 0 "#PWR0116" H 1600 2700 50  0001 C CNN
F 1 "GND" H 1605 2777 50  0000 C CNN
F 2 "" H 1600 2950 50  0001 C CNN
F 3 "" H 1600 2950 50  0001 C CNN
	1    1600 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	3900 800  1600 800 
Wire Wire Line
	1600 800  1600 2300
Connection ~ 3900 800 
Wire Wire Line
	1300 2650 1200 2650
Wire Wire Line
	1200 2650 1200 2300
Wire Wire Line
	1200 2300 1600 2300
Connection ~ 1600 2300
Wire Wire Line
	1600 2300 1600 2350
Text Label 2850 2650 0    50   ~ 0
CPLD_CLK
Text Label 5750 3050 0    50   ~ 0
LAD4
Text Label 5750 3150 0    50   ~ 0
LAD5
Text Label 5750 3250 0    50   ~ 0
LAD6
Text Label 5750 3350 0    50   ~ 0
LAD7
Text Label 5750 3450 0    50   ~ 0
LAD8
Text Label 5750 3550 0    50   ~ 0
LAD9
Text Label 5750 3650 0    50   ~ 0
LAD10
Text Label 5750 3750 0    50   ~ 0
LAD11
Text Label 5750 3850 0    50   ~ 0
LAD12
Text Label 5750 3950 0    50   ~ 0
LAD13
Text Label 5750 4050 0    50   ~ 0
LAD14
Text Label 5750 4150 0    50   ~ 0
LAD15
Text Label 5750 4250 0    50   ~ 0
LAD16
Text Label 5750 4350 0    50   ~ 0
LAD17
Text Label 5750 4550 0    50   ~ 0
LAD19
Text Label 5750 2950 0    50   ~ 0
LAD3
Text Label 5750 2850 0    50   ~ 0
LAD2
Text Label 5750 2750 0    50   ~ 0
LAD1
Wire Wire Line
	6000 4550 5700 4550
Wire Wire Line
	6000 4450 5700 4450
Wire Wire Line
	6000 4350 5700 4350
Wire Wire Line
	6000 4250 5700 4250
Entry Wire Line
	6000 4150 6100 4050
Entry Wire Line
	6000 2650 6100 2550
Entry Wire Line
	6000 2750 6100 2650
Entry Wire Line
	6000 2850 6100 2750
Entry Wire Line
	6000 2950 6100 2850
Entry Wire Line
	6000 3050 6100 2950
Entry Wire Line
	6000 3150 6100 3050
Entry Wire Line
	6000 3250 6100 3150
Entry Wire Line
	6000 3350 6100 3250
Entry Wire Line
	6000 3450 6100 3350
Entry Wire Line
	6000 3550 6100 3450
Entry Wire Line
	6000 3650 6100 3550
Entry Wire Line
	6000 3750 6100 3650
Entry Wire Line
	6000 3850 6100 3750
Entry Wire Line
	6000 3950 6100 3850
Entry Wire Line
	6000 4050 6100 3950
Wire Wire Line
	5700 4050 6000 4050
Wire Wire Line
	5700 3950 6000 3950
Wire Wire Line
	5700 3850 6000 3850
Wire Wire Line
	5700 3750 6000 3750
Wire Wire Line
	5700 3650 6000 3650
Wire Wire Line
	5700 3550 6000 3550
Wire Wire Line
	5700 3450 6000 3450
Wire Wire Line
	5700 3350 6000 3350
Wire Wire Line
	5700 3250 6000 3250
Wire Wire Line
	5700 3150 6000 3150
Wire Wire Line
	5700 3050 6000 3050
Wire Wire Line
	5700 2950 6000 2950
Wire Wire Line
	5700 2850 6000 2850
Wire Wire Line
	5700 2750 6000 2750
Wire Wire Line
	5700 2650 6000 2650
Wire Wire Line
	5700 4150 6000 4150
Text Label 5750 2650 0    50   ~ 0
LAD0
Entry Wire Line
	6000 4250 6100 4150
Entry Wire Line
	6000 4350 6100 4250
Text Label 5750 4450 0    50   ~ 0
LAD18
Entry Wire Line
	6000 4450 6100 4350
Entry Wire Line
	6000 4550 6100 4450
Wire Wire Line
	6000 4750 5700 4750
Text GLabel 6450 4850 2    50   Input ~ 0
DT_~R~_3
Text GLabel 6000 4950 2    50   Input ~ 0
~DEN_3
Text GLabel 6450 5050 2    50   Input ~ 0
ALE_3
Text GLabel 6000 5150 2    50   Input ~ 0
M_~IO~_3
Text GLabel 6000 4750 2    50   Input ~ 0
~BHE~_S7_3
Wire Bus Line
	6100 2450 6200 2450
NoConn ~ 5700 2550
NoConn ~ 5700 2450
NoConn ~ 5700 2350
Wire Wire Line
	3300 6650 3050 6650
Wire Wire Line
	3050 6550 3300 6550
Wire Wire Line
	3050 6450 3300 6450
Wire Wire Line
	3050 6350 3300 6350
Wire Wire Line
	3050 6250 3300 6250
Wire Wire Line
	3050 6150 3300 6150
Wire Wire Line
	3050 6050 3300 6050
Wire Wire Line
	3050 5950 3300 5950
Wire Wire Line
	3050 5750 3300 5750
Wire Wire Line
	3050 5650 3300 5650
Wire Wire Line
	3050 5550 3300 5550
Wire Wire Line
	3050 5450 3300 5450
Wire Wire Line
	3050 5350 3300 5350
Wire Wire Line
	3050 5250 3300 5250
Wire Wire Line
	3050 5150 3300 5150
Wire Wire Line
	3050 5050 3300 5050
Wire Wire Line
	3050 4950 3300 4950
Wire Wire Line
	3050 4850 3300 4850
Wire Wire Line
	3050 4750 3300 4750
Wire Wire Line
	3050 4550 3300 4550
Wire Wire Line
	3050 4450 3300 4450
Wire Wire Line
	3050 4350 3300 4350
Wire Wire Line
	3050 4250 3300 4250
Wire Wire Line
	3050 4150 3300 4150
Wire Wire Line
	3050 4050 3300 4050
Wire Wire Line
	3050 3950 3300 3950
Wire Wire Line
	3050 3850 3300 3850
Wire Wire Line
	3050 3750 3300 3750
Wire Wire Line
	3050 3650 3300 3650
Wire Wire Line
	3050 3550 3300 3550
Wire Wire Line
	3050 3450 3300 3450
Wire Wire Line
	3050 3350 3300 3350
Wire Wire Line
	3050 3250 3300 3250
Wire Wire Line
	3050 3150 3300 3150
Wire Wire Line
	3050 3050 3300 3050
Entry Wire Line
	3050 3050 2950 2950
Entry Wire Line
	3050 3150 2950 3050
Entry Wire Line
	3050 3250 2950 3150
Entry Wire Line
	3050 3350 2950 3250
Entry Wire Line
	3050 3450 2950 3350
Entry Wire Line
	3050 3550 2950 3450
Entry Wire Line
	3050 3650 2950 3550
Entry Wire Line
	3050 3750 2950 3650
Entry Wire Line
	3050 3850 2950 3750
Entry Wire Line
	3050 3950 2950 3850
Entry Wire Line
	3050 4050 2950 3950
Entry Wire Line
	3050 4150 2950 4050
Entry Wire Line
	3050 4250 2950 4150
Entry Wire Line
	3050 4350 2950 4250
Entry Wire Line
	3050 4450 2950 4350
Entry Wire Line
	3050 4550 2950 4450
Entry Wire Line
	3050 4750 2950 4650
Entry Wire Line
	3050 4850 2950 4750
Entry Wire Line
	3050 4950 2950 4850
Entry Wire Line
	3050 5050 2950 4950
Entry Wire Line
	3050 5150 2950 5050
Entry Wire Line
	3050 5250 2950 5150
Entry Wire Line
	3050 5350 2950 5250
Entry Wire Line
	3050 5450 2950 5350
Entry Wire Line
	3050 5550 2950 5450
Entry Wire Line
	3050 5650 2950 5550
Entry Wire Line
	3050 5750 2950 5650
Entry Wire Line
	3050 5950 2950 5850
Entry Wire Line
	3050 6050 2950 5950
Entry Wire Line
	3050 6150 2950 6050
Entry Wire Line
	3050 6250 2950 6150
Entry Wire Line
	3050 6350 2950 6250
Entry Wire Line
	3050 6450 2950 6350
Entry Wire Line
	3050 6550 2950 6450
Entry Wire Line
	3050 6650 2950 6550
Wire Bus Line
	2950 2900 2850 2900
Wire Bus Line
	2950 4600 2850 4600
Text GLabel 2850 2900 0    50   BiDi ~ 0
LD[0..15]
Text GLabel 2850 4600 0    50   Output ~ 0
A[0..19]
Wire Wire Line
	3300 2150 2800 2150
NoConn ~ 3300 2050
Text GLabel 2800 2150 0    50   Output ~ 0
~BHE
Text GLabel 6450 5450 2    50   Input ~ 0
~INTA_3
Wire Wire Line
	5700 5850 6000 5850
Wire Wire Line
	5700 5950 6350 5950
Wire Wire Line
	5700 6050 6000 6050
Text GLabel 6000 5850 2    50   Output ~ 0
CLK
Text GLabel 6350 5950 2    50   Output ~ 0
READY
Text GLabel 6000 6050 2    50   Output ~ 0
RESET
NoConn ~ 5700 5750
NoConn ~ 3300 2750
NoConn ~ 3300 2550
NoConn ~ 3300 2250
Text Label 3100 4750 0    50   ~ 0
A0
Text Label 3100 4850 0    50   ~ 0
A1
Text Label 3100 4950 0    50   ~ 0
A2
Text Label 3100 5050 0    50   ~ 0
A3
Text Label 3100 5150 0    50   ~ 0
A4
Text Label 3100 5250 0    50   ~ 0
A5
Text Label 3100 5350 0    50   ~ 0
A6
Text Label 3100 5450 0    50   ~ 0
A7
Text Label 3100 5550 0    50   ~ 0
A8
Text Label 3100 5650 0    50   ~ 0
A9
Text Label 3100 5750 0    50   ~ 0
A10
Text Label 3100 5950 0    50   ~ 0
A11
Text Label 3100 6050 0    50   ~ 0
A12
Text Label 3100 6150 0    50   ~ 0
A13
Text Label 3100 6250 0    50   ~ 0
A14
Text Label 3100 6350 0    50   ~ 0
A15
Text Label 3100 6450 0    50   ~ 0
A16
Text Label 3100 6550 0    50   ~ 0
A17
Text Label 3100 6650 0    50   ~ 0
A18
NoConn ~ 5700 4650
NoConn ~ 3300 4650
Wire Wire Line
	3300 6750 3050 6750
Entry Wire Line
	3050 6750 2950 6650
Text Label 3100 6750 0    50   ~ 0
A19
Text Label 3100 3050 0    50   ~ 0
LD0
Text Label 3100 3150 0    50   ~ 0
LD1
Text Label 3100 3250 0    50   ~ 0
LD2
Text Label 3100 3350 0    50   ~ 0
LD3
Text Label 3100 3450 0    50   ~ 0
LD4
Text Label 3100 3550 0    50   ~ 0
LD5
Text Label 3100 3650 0    50   ~ 0
LD6
Text Label 3100 3750 0    50   ~ 0
LD7
Text Label 3100 3850 0    50   ~ 0
LD8
Text Label 3100 3950 0    50   ~ 0
LD9
Text Label 3100 4050 0    50   ~ 0
LD10
Text Label 3100 4150 0    50   ~ 0
LD11
Text Label 3100 4250 0    50   ~ 0
LD12
Text Label 3100 4350 0    50   ~ 0
LD13
Text Label 3100 4450 0    50   ~ 0
LD14
Text Label 3100 4550 0    50   ~ 0
LD15
NoConn ~ 3300 2950
NoConn ~ 5700 6150
Text GLabel 3200 2350 0    50   Output ~ 0
~RAM0_CE
Text GLabel 2800 2450 0    50   Output ~ 0
~RAM1_CE
Wire Wire Line
	3300 2350 3200 2350
Wire Wire Line
	3300 2450 2800 2450
Wire Wire Line
	3300 5850 3050 5850
Wire Wire Line
	3050 5850 3050 5800
$Comp
L Mini8086:SN74ALVC164245 U?
U 1 1 5FF16C78
P 9050 2200
AR Path="/5F740693/5FF16C78" Ref="U?"  Part="1" 
AR Path="/5F8BB07A/5FF16C78" Ref="U12"  Part="1" 
F 0 "U12" H 9050 2250 50  0000 C CNN
F 1 "SN74ALVC164245" H 9050 2100 50  0000 C CNN
F 2 "Package_SO:SSOP-48_7.5x15.9mm_P0.635mm" H 9100 2200 50  0001 C CNN
F 3 "" H 9100 2200 50  0001 C CNN
	1    9050 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	8700 3350 8700 3400
Wire Wire Line
	9400 3400 9400 3350
Wire Wire Line
	9300 3400 9300 3350
Connection ~ 9300 3400
Wire Wire Line
	9300 3400 9400 3400
Wire Wire Line
	9200 3400 9200 3350
Connection ~ 9200 3400
Wire Wire Line
	9200 3400 9300 3400
Wire Wire Line
	9100 3400 9100 3350
Connection ~ 9100 3400
Wire Wire Line
	9100 3400 9200 3400
Wire Wire Line
	9000 3400 9000 3350
Connection ~ 9000 3400
Wire Wire Line
	9000 3400 9100 3400
Wire Wire Line
	8700 3400 8800 3400
Wire Wire Line
	8900 3350 8900 3400
Connection ~ 8900 3400
Wire Wire Line
	8900 3400 9000 3400
Wire Wire Line
	8800 3400 8800 3350
Connection ~ 8800 3400
Wire Wire Line
	8800 3400 8900 3400
$Comp
L power:GND #PWR?
U 1 1 5FF16C93
P 9400 3450
AR Path="/5F740693/5FF16C93" Ref="#PWR?"  Part="1" 
AR Path="/5F8BB07A/5FF16C93" Ref="#PWR0119"  Part="1" 
F 0 "#PWR0119" H 9400 3200 50  0001 C CNN
F 1 "GND" H 9405 3277 50  0000 C CNN
F 2 "" H 9400 3450 50  0001 C CNN
F 3 "" H 9400 3450 50  0001 C CNN
	1    9400 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	8900 1050 8900 1000
Wire Wire Line
	8900 1000 8800 1000
Wire Wire Line
	8800 1000 8800 1050
Wire Wire Line
	9250 1050 9250 1000
Wire Wire Line
	9250 1000 9350 1000
Wire Wire Line
	9350 1000 9350 1050
Connection ~ 8900 1000
Wire Wire Line
	9350 1000 9500 1000
Connection ~ 9350 1000
Wire Wire Line
	8900 950  8900 1000
$Comp
L power:VCC #PWR?
U 1 1 5FF16CA3
P 8900 950
AR Path="/5F740693/5FF16CA3" Ref="#PWR?"  Part="1" 
AR Path="/5F8BB07A/5FF16CA3" Ref="#PWR0120"  Part="1" 
F 0 "#PWR0120" H 8900 800 50  0001 C CNN
F 1 "VCC" H 8915 1123 50  0000 C CNN
F 2 "" H 8900 950 50  0001 C CNN
F 3 "" H 8900 950 50  0001 C CNN
	1    8900 950 
	1    0    0    -1  
$EndComp
Text GLabel 9500 1000 2    50   Input ~ 0
VCC36
Text GLabel 7800 3150 0    50   Input ~ 0
~DATA_DIR
Wire Wire Line
	8300 1400 7900 1400
Wire Wire Line
	7900 1500 8300 1500
Wire Wire Line
	7900 1600 8300 1600
Wire Wire Line
	7900 1700 8300 1700
Wire Wire Line
	7900 1800 8300 1800
Wire Wire Line
	7900 1900 8300 1900
Wire Wire Line
	7900 2000 8300 2000
Wire Wire Line
	7900 2100 8300 2100
Wire Wire Line
	8300 2300 7900 2300
Wire Wire Line
	7900 2400 8300 2400
Wire Wire Line
	7900 2500 8300 2500
Wire Wire Line
	7900 2600 8300 2600
Wire Wire Line
	7900 2700 8300 2700
Wire Wire Line
	7900 2800 8300 2800
Wire Wire Line
	7900 2900 8300 2900
Wire Wire Line
	7900 3000 8300 3000
Entry Wire Line
	7900 1400 7800 1300
Entry Wire Line
	7900 1500 7800 1400
Entry Wire Line
	7900 1600 7800 1500
Entry Wire Line
	7900 1700 7800 1600
Entry Wire Line
	7900 1800 7800 1700
Entry Wire Line
	7900 1900 7800 1800
Entry Wire Line
	7900 2000 7800 1900
Entry Wire Line
	7900 2100 7800 2000
Entry Wire Line
	7900 2300 7800 2200
Entry Wire Line
	7900 2400 7800 2300
Entry Wire Line
	7900 2500 7800 2400
Entry Wire Line
	7900 2600 7800 2500
Entry Wire Line
	7900 2700 7800 2600
Entry Wire Line
	7900 2800 7800 2700
Entry Wire Line
	7900 2900 7800 2800
Entry Wire Line
	7900 3000 7800 2900
Wire Bus Line
	7800 1250 7700 1250
Text GLabel 7700 1250 0    50   BiDi ~ 0
D[0..15]
Text Label 8050 1400 0    50   ~ 0
D0
Text Label 8050 1500 0    50   ~ 0
D1
Text Label 8050 1600 0    50   ~ 0
D2
Text Label 8050 1700 0    50   ~ 0
D3
Text Label 8050 1800 0    50   ~ 0
D4
Text Label 8050 1900 0    50   ~ 0
D5
Text Label 8050 2000 0    50   ~ 0
D6
Text Label 8050 2100 0    50   ~ 0
D7
Text Label 8050 2300 0    50   ~ 0
D8
Text Label 8050 2400 0    50   ~ 0
D9
Text Label 8050 2500 0    50   ~ 0
D10
Text Label 8050 2600 0    50   ~ 0
D11
Text Label 8050 2700 0    50   ~ 0
D12
Text Label 8050 2800 0    50   ~ 0
D13
Text Label 8050 2900 0    50   ~ 0
D14
Text Label 8050 3000 0    50   ~ 0
D15
Wire Wire Line
	7800 3150 7950 3150
Wire Wire Line
	8300 1250 7950 1250
Wire Wire Line
	7950 1250 7950 3150
Connection ~ 7950 3150
Wire Wire Line
	7950 3150 8300 3150
Wire Wire Line
	9800 1400 10200 1400
Wire Wire Line
	10200 1500 9800 1500
Wire Wire Line
	9800 1600 10200 1600
Wire Wire Line
	10200 1700 9800 1700
Wire Wire Line
	9800 1800 10200 1800
Wire Wire Line
	10200 1900 9800 1900
Wire Wire Line
	9800 2000 10200 2000
Wire Wire Line
	10200 2100 9800 2100
Wire Wire Line
	9800 2300 10200 2300
Wire Wire Line
	10200 2400 9800 2400
Wire Wire Line
	9800 2500 10200 2500
Wire Wire Line
	10200 2600 9800 2600
Wire Wire Line
	9800 2700 10200 2700
Wire Wire Line
	10200 2800 9800 2800
Wire Wire Line
	9800 2900 10200 2900
Wire Wire Line
	10200 3000 9800 3000
Entry Wire Line
	10200 1400 10300 1300
Entry Wire Line
	10200 1500 10300 1400
Entry Wire Line
	10200 1600 10300 1500
Entry Wire Line
	10200 1700 10300 1600
Entry Wire Line
	10200 1800 10300 1700
Entry Wire Line
	10200 1900 10300 1800
Entry Wire Line
	10200 2000 10300 1900
Entry Wire Line
	10200 2100 10300 2000
Entry Wire Line
	10200 2300 10300 2200
Entry Wire Line
	10200 2400 10300 2300
Entry Wire Line
	10200 2500 10300 2400
Entry Wire Line
	10200 2600 10300 2500
Entry Wire Line
	10200 2700 10300 2600
Entry Wire Line
	10200 2800 10300 2700
Entry Wire Line
	10200 2900 10300 2800
Entry Wire Line
	10200 3000 10300 2900
Wire Bus Line
	10300 1250 10400 1250
Text GLabel 10400 1250 2    50   BiDi ~ 0
LD[0..15]
Wire Wire Line
	9400 3450 9400 3400
Connection ~ 9400 3400
Text Label 9900 1400 0    50   ~ 0
LD0
Text Label 9900 1500 0    50   ~ 0
LD1
Text Label 9900 1600 0    50   ~ 0
LD2
Text Label 9900 1700 0    50   ~ 0
LD3
Text Label 9900 1800 0    50   ~ 0
LD4
Text Label 9900 1900 0    50   ~ 0
LD5
Text Label 9900 2000 0    50   ~ 0
LD6
Text Label 9900 2100 0    50   ~ 0
LD7
Text Label 9900 2300 0    50   ~ 0
LD8
Text Label 9900 2400 0    50   ~ 0
LD9
Text Label 9900 2500 0    50   ~ 0
LD10
Text Label 9900 2600 0    50   ~ 0
LD11
Text Label 9900 2700 0    50   ~ 0
LD12
Text Label 9900 2800 0    50   ~ 0
LD13
Text Label 9900 2900 0    50   ~ 0
LD14
Text Label 9900 3000 0    50   ~ 0
LD15
Wire Wire Line
	6450 4850 5700 4850
Wire Wire Line
	6000 4950 5700 4950
Wire Wire Line
	6000 5150 5700 5150
Wire Wire Line
	6450 5050 5700 5050
Wire Wire Line
	6450 5250 5700 5250
Wire Wire Line
	6000 5350 5700 5350
Wire Wire Line
	6450 5450 5700 5450
NoConn ~ 5700 5650
NoConn ~ 5700 6250
$Comp
L Connector_Generic:Conn_02x05_Odd_Even J1
U 1 1 5FEEC69C
P 9600 5050
F 0 "J1" H 9650 5467 50  0000 C CNN
F 1 "JTAG" H 9650 5376 50  0000 C CNN
F 2 "Connector_IDC:IDC-Header_2x05_P2.54mm_Vertical" H 9600 5050 50  0001 C CNN
F 3 "~" H 9600 5050 50  0001 C CNN
	1    9600 5050
	1    0    0    -1  
$EndComp
Text GLabel 3300 6850 0    50   BiDi ~ 0
TMS
Text GLabel 3300 6950 0    50   BiDi ~ 0
TDI
Text GLabel 3300 7050 0    50   BiDi ~ 0
TCK
Text GLabel 3300 7150 0    50   BiDi ~ 0
TDO
Wire Wire Line
	9400 4850 8700 4850
Text GLabel 8400 4850 0    50   BiDi ~ 0
TCK
Text GLabel 8400 4950 0    50   BiDi ~ 0
TDO
Text GLabel 8400 5050 0    50   BiDi ~ 0
TMS
Text GLabel 8400 5250 0    50   BiDi ~ 0
TDI
Wire Wire Line
	9400 4950 8850 4950
NoConn ~ 9400 5150
NoConn ~ 9900 5150
NoConn ~ 9900 5050
Wire Wire Line
	9900 5250 10050 5250
Wire Wire Line
	10050 5250 10050 4850
Wire Wire Line
	10050 4850 9900 4850
Wire Wire Line
	10050 5250 10050 5350
Connection ~ 10050 5250
$Comp
L power:GND #PWR02
U 1 1 5FF87675
P 10050 5350
F 0 "#PWR02" H 10050 5100 50  0001 C CNN
F 1 "GND" H 10055 5177 50  0000 C CNN
F 2 "" H 10050 5350 50  0001 C CNN
F 3 "" H 10050 5350 50  0001 C CNN
	1    10050 5350
	1    0    0    -1  
$EndComp
Wire Wire Line
	9900 4950 10100 4950
Text GLabel 10100 4950 2    50   Input ~ 0
VCC36
Wire Wire Line
	8700 4850 8700 5350
Connection ~ 8700 4850
Wire Wire Line
	8700 4850 8400 4850
$Comp
L Device:R R1
U 1 1 5FFECE94
P 8700 5500
F 0 "R1" H 8770 5546 50  0000 L CNN
F 1 "2K2" H 8770 5455 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 8630 5500 50  0001 C CNN
F 3 "~" H 8700 5500 50  0001 C CNN
	1    8700 5500
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 5FFED322
P 8850 4600
F 0 "R2" H 8920 4646 50  0000 L CNN
F 1 "10K" H 8920 4555 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 8780 4600 50  0001 C CNN
F 3 "~" H 8850 4600 50  0001 C CNN
	1    8850 4600
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 5FFED72E
P 9150 4600
F 0 "R3" H 9220 4646 50  0000 L CNN
F 1 "10K" H 9220 4555 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 9080 4600 50  0001 C CNN
F 3 "~" H 9150 4600 50  0001 C CNN
	1    9150 4600
	1    0    0    -1  
$EndComp
Wire Wire Line
	8400 5250 9400 5250
Wire Wire Line
	9150 4750 9150 5050
Connection ~ 9150 5050
Wire Wire Line
	9150 5050 9400 5050
Wire Wire Line
	8850 4450 8850 4350
Wire Wire Line
	8850 4350 9150 4350
Wire Wire Line
	9150 4350 9150 4450
Wire Wire Line
	9150 4350 9250 4350
Connection ~ 9150 4350
Text GLabel 9250 4350 2    50   Input ~ 0
VCC36
$Comp
L power:GND #PWR01
U 1 1 600377A2
P 8700 5650
F 0 "#PWR01" H 8700 5400 50  0001 C CNN
F 1 "GND" H 8705 5477 50  0000 C CNN
F 2 "" H 8700 5650 50  0001 C CNN
F 3 "" H 8700 5650 50  0001 C CNN
	1    8700 5650
	1    0    0    -1  
$EndComp
Text GLabel 5800 2250 2    50   Output ~ 0
DATA_DIR
Wire Wire Line
	5800 2250 5700 2250
Wire Wire Line
	3300 2850 3150 2850
Wire Wire Line
	3150 2850 3150 2750
Wire Wire Line
	3150 2750 2450 2750
Text GLabel 2450 2750 0    50   Output ~ 0
~DATA_DIR
Wire Wire Line
	8400 5050 9150 5050
Wire Wire Line
	8850 4750 8850 4950
Connection ~ 8850 4950
Wire Wire Line
	8850 4950 8400 4950
Wire Wire Line
	9800 1250 10150 1250
Wire Wire Line
	10150 1250 10150 3150
Wire Wire Line
	10150 3150 9800 3150
Wire Wire Line
	10150 3150 10300 3150
Connection ~ 10150 3150
Text GLabel 10300 3150 2    50   Input ~ 0
~OE_DATA
Text GLabel 6250 2150 2    50   Output ~ 0
~OE_DATA
Wire Wire Line
	5700 2150 6250 2150
$Comp
L Device:C C40
U 1 1 5FFBA00E
P 2350 6050
F 0 "C40" H 2465 6096 50  0000 L CNN
F 1 "100n" H 2465 6005 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 2388 5900 50  0001 C CNN
F 3 "~" H 2350 6050 50  0001 C CNN
	1    2350 6050
	1    0    0    -1  
$EndComp
$Comp
L Device:R R16
U 1 1 5FFBAAF2
P 2350 5550
F 0 "R16" H 2420 5596 50  0000 L CNN
F 1 "1K" H 2420 5505 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 2280 5550 50  0001 C CNN
F 3 "~" H 2350 5550 50  0001 C CNN
	1    2350 5550
	1    0    0    -1  
$EndComp
$Comp
L Device:R R15
U 1 1 5FFBB40D
P 2100 5800
F 0 "R15" V 1893 5800 50  0000 C CNN
F 1 "33" V 1984 5800 50  0000 C CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 2030 5800 50  0001 C CNN
F 3 "~" H 2100 5800 50  0001 C CNN
	1    2100 5800
	0    1    1    0   
$EndComp
Wire Wire Line
	2350 5800 3050 5800
Connection ~ 2350 5800
Wire Wire Line
	2350 5800 2350 5700
Wire Wire Line
	2350 5800 2350 5900
Wire Wire Line
	2250 5800 2350 5800
$Comp
L power:GND #PWR06
U 1 1 5FFFE627
P 2350 6200
F 0 "#PWR06" H 2350 5950 50  0001 C CNN
F 1 "GND" V 2355 6072 50  0000 R CNN
F 2 "" H 2350 6200 50  0001 C CNN
F 3 "" H 2350 6200 50  0001 C CNN
	1    2350 6200
	1    0    0    -1  
$EndComp
Text GLabel 2350 5400 1    50   Input ~ 0
VCC36
$Comp
L Switch:SW_Push SW1
U 1 1 600117B0
P 1750 5800
F 0 "SW1" H 1750 6085 50  0000 C CNN
F 1 "Reset" H 1750 5994 50  0000 C CNN
F 2 "Button_Switch_SMD:SW_SPST_CK_RS282G05A3" H 1750 6000 50  0001 C CNN
F 3 "~" H 1750 6000 50  0001 C CNN
	1    1750 5800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR05
U 1 1 60011F39
P 1500 6200
F 0 "#PWR05" H 1500 5950 50  0001 C CNN
F 1 "GND" V 1505 6072 50  0000 R CNN
F 2 "" H 1500 6200 50  0001 C CNN
F 3 "" H 1500 6200 50  0001 C CNN
	1    1500 6200
	1    0    0    -1  
$EndComp
Wire Wire Line
	1500 5800 1550 5800
Wire Wire Line
	1500 5800 1500 6200
Text GLabel 5850 7050 2    50   Input ~ 0
RDY1
Text GLabel 5850 7150 2    50   Input ~ 0
RDY2
Wire Wire Line
	5850 7050 5700 7050
Wire Wire Line
	5850 7150 5700 7150
NoConn ~ 5700 6950
NoConn ~ 5700 6750
NoConn ~ 5700 6550
NoConn ~ 5700 6450
NoConn ~ 5700 6350
Wire Wire Line
	5850 6850 5700 6850
Text GLabel 5850 6850 2    50   Output ~ 0
PIT_CLK
NoConn ~ 5700 2050
NoConn ~ 5700 1950
NoConn ~ 5700 1850
NoConn ~ 5700 1750
NoConn ~ 5700 1650
NoConn ~ 5700 1550
NoConn ~ 5700 1450
Text Label 2450 5800 0    50   ~ 0
~CPLD_RESET
Text GLabel 5850 6650 2    50   Output ~ 0
PCLK
Wire Wire Line
	5850 6650 5700 6650
$Comp
L Device:R R17
U 1 1 60019F64
P 6900 5700
F 0 "R17" H 6970 5746 50  0000 L CNN
F 1 "120" H 6970 5655 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 6830 5700 50  0001 C CNN
F 3 "~" H 6900 5700 50  0001 C CNN
	1    6900 5700
	0    1    1    0   
$EndComp
Wire Wire Line
	5700 5550 6100 5550
Wire Wire Line
	6100 5550 6100 5700
Wire Wire Line
	6100 5700 6750 5700
Wire Wire Line
	7050 5700 7150 5700
Wire Wire Line
	7150 5700 7150 5800
$Comp
L power:GND #PWR08
U 1 1 6003F4E9
P 7150 6150
F 0 "#PWR08" H 7150 5900 50  0001 C CNN
F 1 "GND" H 7155 5977 50  0000 C CNN
F 2 "" H 7150 6150 50  0001 C CNN
F 3 "" H 7150 6150 50  0001 C CNN
	1    7150 6150
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D2
U 1 1 6003F9FA
P 7150 5950
F 0 "D2" V 7189 5832 50  0000 R CNN
F 1 "LED" V 7098 5832 50  0000 R CNN
F 2 "LED_SMD:LED_0805_2012Metric_Castellated" H 7150 5950 50  0001 C CNN
F 3 "~" H 7150 5950 50  0001 C CNN
	1    7150 5950
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7150 6150 7150 6100
Text Label 6200 5700 0    50   ~ 0
INFO_LED
Text GLabel 6200 2450 2    50   BiDi ~ 0
LAD[0..19]
Text Notes 7250 3400 0    50   ~ 0
0 = input (B -> A)\n1 = output (A -> B)\n
Text GLabel 5800 1250 2    50   Output ~ 0
~LMEMWR
Text GLabel 6250 1350 2    50   Output ~ 0
~LMEMRD
Wire Wire Line
	6250 1350 5700 1350
Wire Wire Line
	5800 1250 5700 1250
Wire Bus Line
	10300 1250 10300 2900
Wire Bus Line
	7800 1250 7800 2900
Wire Bus Line
	2950 4600 2950 6650
Wire Bus Line
	2950 2900 2950 4450
Wire Bus Line
	6100 2450 6100 4450
$EndSCHEMATC
