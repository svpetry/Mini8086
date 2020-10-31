EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 4 7
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
L Connector:SD_Card J3
U 1 1 5F8F4BD4
P 9300 3300
F 0 "J3" H 9300 3965 50  0000 C CNN
F 1 "SD_Card" H 9300 3874 50  0000 C CNN
F 2 "Connector_Card:SD_Kyocera_145638109211859+" H 9300 3300 50  0001 C CNN
F 3 "http://portal.fciconnect.com/Comergent//fci/drawing/10067847.pdf" H 9300 3300 50  0001 C CNN
	1    9300 3300
	1    0    0    -1  
$EndComp
Text GLabel 8600 5150 0    50   Input ~ 0
~WR
Text GLabel 8350 5050 0    50   Input ~ 0
~RD
Entry Wire Line
	8150 5550 8050 5450
Wire Bus Line
	8050 5450 8000 5450
Text GLabel 8000 5450 0    50   Input ~ 0
A[0..19]
Text Label 8250 5550 0    50   ~ 0
A0
Text GLabel 6950 5150 1    50   Input ~ 0
~CS_DRIVE
Wire Wire Line
	8400 3200 8200 3200
Wire Wire Line
	8400 3500 8200 3500
Connection ~ 8200 3500
Wire Wire Line
	8200 3500 8200 3850
Wire Wire Line
	8400 3600 7650 3600
NoConn ~ 10200 3200
Wire Wire Line
	10200 3500 10350 3500
Wire Wire Line
	10350 3500 10350 3850
Wire Wire Line
	10350 3400 10350 3500
Connection ~ 10350 3500
Wire Wire Line
	10200 3400 10350 3400
$Comp
L power:GND #PWR056
U 1 1 5F91FF13
P 10350 3850
F 0 "#PWR056" H 10350 3600 50  0001 C CNN
F 1 "GND" H 10355 3677 50  0000 C CNN
F 2 "" H 10350 3850 50  0001 C CNN
F 3 "" H 10350 3850 50  0001 C CNN
	1    10350 3850
	1    0    0    -1  
$EndComp
Wire Wire Line
	8200 3200 8200 3500
Wire Wire Line
	8400 3300 8100 3300
NoConn ~ 8400 3700
Text Label 7850 3600 0    50   ~ 0
DO
Text Label 7850 3400 0    50   ~ 0
SCLK
Text Label 7850 3100 0    50   ~ 0
DI
Text Label 7850 3000 0    50   ~ 0
CS
NoConn ~ 8400 2900
$Comp
L power:GND #PWR044
U 1 1 5F904414
P 5750 3750
F 0 "#PWR044" H 5750 3500 50  0001 C CNN
F 1 "GND" H 5755 3577 50  0000 C CNN
F 2 "" H 5750 3750 50  0001 C CNN
F 3 "" H 5750 3750 50  0001 C CNN
	1    5750 3750
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR049
U 1 1 5F91B5E7
P 8200 3850
F 0 "#PWR049" H 8200 3600 50  0001 C CNN
F 1 "GND" H 8205 3677 50  0000 C CNN
F 2 "" H 8200 3850 50  0001 C CNN
F 3 "" H 8200 3850 50  0001 C CNN
	1    8200 3850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR040
U 1 1 5F90503B
P 10350 5600
F 0 "#PWR040" H 10350 5350 50  0001 C CNN
F 1 "GND" H 10355 5427 50  0000 C CNN
F 2 "" H 10350 5600 50  0001 C CNN
F 3 "" H 10350 5600 50  0001 C CNN
	1    10350 5600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR038
U 1 1 5F905534
P 8900 4950
F 0 "#PWR038" H 8900 4700 50  0001 C CNN
F 1 "GND" H 8905 4777 50  0000 C CNN
F 2 "" H 8900 4950 50  0001 C CNN
F 3 "" H 8900 4950 50  0001 C CNN
	1    8900 4950
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR042
U 1 1 5F905BA4
P 3050 6550
F 0 "#PWR042" H 3050 6300 50  0001 C CNN
F 1 "GND" H 3055 6377 50  0000 C CNN
F 2 "" H 3050 6550 50  0001 C CNN
F 3 "" H 3050 6550 50  0001 C CNN
	1    3050 6550
	1    0    0    -1  
$EndComp
$Comp
L Regulator_Linear:AMS1117-3.3 U12
U 1 1 5F906868
P 9200 1250
F 0 "U12" H 9200 1492 50  0000 C CNN
F 1 "AMS1117-3.3" H 9200 1401 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-223-3_TabPin2" H 9200 1450 50  0001 C CNN
F 3 "http://www.advanced-monolithic.com/pdf/ds1117.pdf" H 9300 1000 50  0001 C CNN
	1    9200 1250
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR051
U 1 1 5F909AA6
P 9200 1800
F 0 "#PWR051" H 9200 1550 50  0001 C CNN
F 1 "GND" H 9205 1627 50  0000 C CNN
F 2 "" H 9200 1800 50  0001 C CNN
F 3 "" H 9200 1800 50  0001 C CNN
	1    9200 1800
	1    0    0    -1  
$EndComp
Wire Wire Line
	8100 1250 8100 3300
Wire Wire Line
	9500 1250 9750 1250
Wire Wire Line
	9750 1250 9750 1150
$Comp
L power:VCC #PWR039
U 1 1 5F90B164
P 8900 5450
F 0 "#PWR039" H 8900 5300 50  0001 C CNN
F 1 "VCC" V 8915 5577 50  0000 L CNN
F 2 "" H 8900 5450 50  0001 C CNN
F 3 "" H 8900 5450 50  0001 C CNN
	1    8900 5450
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR043
U 1 1 5F90B579
P 5750 3250
F 0 "#PWR043" H 5750 3100 50  0001 C CNN
F 1 "VCC" V 5765 3378 50  0000 L CNN
F 2 "" H 5750 3250 50  0001 C CNN
F 3 "" H 5750 3250 50  0001 C CNN
	1    5750 3250
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR041
U 1 1 5F90B9FA
P 10450 5800
F 0 "#PWR041" H 10450 5650 50  0001 C CNN
F 1 "VCC" H 10465 5973 50  0000 C CNN
F 2 "" H 10450 5800 50  0001 C CNN
F 3 "" H 10450 5800 50  0001 C CNN
	1    10450 5800
	-1   0    0    1   
$EndComp
Wire Wire Line
	10450 5800 10450 5600
$Comp
L power:VCC #PWR054
U 1 1 5F90D05D
P 9750 1150
F 0 "#PWR054" H 9750 1000 50  0001 C CNN
F 1 "VCC" H 9765 1323 50  0000 C CNN
F 2 "" H 9750 1150 50  0001 C CNN
F 3 "" H 9750 1150 50  0001 C CNN
	1    9750 1150
	1    0    0    -1  
$EndComp
$Comp
L Device:C C18
U 1 1 5F90DA39
P 8700 1500
F 0 "C18" H 8815 1546 50  0000 L CNN
F 1 "100n" H 8815 1455 50  0000 L CNN
F 2 "" H 8738 1350 50  0001 C CNN
F 3 "~" H 8700 1500 50  0001 C CNN
	1    8700 1500
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C17
U 1 1 5F90EE7C
P 8300 1500
F 0 "C17" H 8418 1546 50  0000 L CNN
F 1 "100µ" H 8418 1455 50  0000 L CNN
F 2 "" H 8338 1350 50  0001 C CNN
F 3 "~" H 8300 1500 50  0001 C CNN
	1    8300 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	9200 1550 9200 1750
Wire Wire Line
	8700 1650 8700 1750
Wire Wire Line
	8700 1750 9200 1750
Connection ~ 9200 1750
Wire Wire Line
	9200 1750 9200 1800
Wire Wire Line
	8300 1650 8300 1750
Wire Wire Line
	8300 1750 8700 1750
Connection ~ 8700 1750
Wire Wire Line
	8700 1350 8700 1250
Wire Wire Line
	8100 1250 8300 1250
Connection ~ 8700 1250
Wire Wire Line
	8700 1250 8900 1250
Wire Wire Line
	8300 1350 8300 1250
Connection ~ 8300 1250
Wire Wire Line
	8300 1250 8700 1250
Text Label 8400 1250 0    50   ~ 0
VCC3
Wire Wire Line
	8100 1250 8050 1250
Connection ~ 8100 1250
Wire Wire Line
	7650 3000 7650 2700
Wire Wire Line
	7650 3000 8400 3000
Wire Wire Line
	7650 3600 7650 3850
Wire Wire Line
	6350 2700 6350 3350
Wire Wire Line
	6100 6900 6100 7150
Wire Wire Line
	6100 7150 6400 7150
$Comp
L power:GND #PWR055
U 1 1 5F95C272
P 6400 7150
F 0 "#PWR055" H 6400 6900 50  0001 C CNN
F 1 "GND" H 6405 6977 50  0000 C CNN
F 2 "" H 6400 7150 50  0001 C CNN
F 3 "" H 6400 7150 50  0001 C CNN
	1    6400 7150
	1    0    0    -1  
$EndComp
Wire Wire Line
	9950 5600 9950 6050
Wire Wire Line
	10050 5600 10050 6050
Wire Wire Line
	10150 5600 10150 6050
Wire Wire Line
	10250 5600 10250 6050
Wire Wire Line
	10550 6050 10550 5600
Wire Wire Line
	10650 5600 10650 6050
Wire Wire Line
	10750 6050 10750 5600
Wire Wire Line
	10850 6050 10850 5600
Entry Wire Line
	9950 6050 9850 6150
Entry Wire Line
	10050 6050 9950 6150
Entry Wire Line
	10150 6050 10050 6150
Entry Wire Line
	10250 6050 10150 6150
Entry Wire Line
	10550 6050 10450 6150
Entry Wire Line
	10650 6050 10550 6150
Entry Wire Line
	10750 6050 10650 6150
Entry Wire Line
	10850 6050 10750 6150
Text Label 9950 5800 1    50   ~ 0
RD0
Text Label 10050 5800 1    50   ~ 0
RD1
Text Label 10150 5800 1    50   ~ 0
RD2
Text Label 10250 5800 1    50   ~ 0
RD3
Text Label 10550 5800 1    50   ~ 0
RD4
Text Label 10650 5800 1    50   ~ 0
RD5
Text Label 10750 5800 1    50   ~ 0
RD6
Text Label 10850 5800 1    50   ~ 0
RD7
Text Label 6050 3850 0    50   ~ 0
SD_DO
Text Label 6050 3650 0    50   ~ 0
SD_SCLK
Text Label 6050 3350 0    50   ~ 0
SD_CS
Wire Wire Line
	5750 3350 6350 3350
NoConn ~ 8900 4650
NoConn ~ 8900 5250
NoConn ~ 5750 2950
NoConn ~ 5750 3550
Text GLabel 9800 6150 0    50   BiDi ~ 0
RD[0..7]
Wire Wire Line
	6350 5800 6350 5350
Wire Wire Line
	6450 5350 6450 5800
Wire Wire Line
	6550 5350 6550 5800
Text GLabel 6850 5700 1    50   Input ~ 0
~RESET
Wire Wire Line
	7250 5800 7250 5350
Wire Wire Line
	7350 5800 7350 5350
Wire Wire Line
	5750 2850 5950 2850
Wire Wire Line
	5750 3050 5950 3050
Wire Wire Line
	5750 3150 5950 3150
Entry Wire Line
	6350 5350 6250 5250
Entry Wire Line
	6450 5350 6350 5250
Entry Wire Line
	6550 5350 6450 5250
Entry Wire Line
	7250 5350 7150 5250
Entry Wire Line
	7350 5350 7250 5250
Entry Wire Line
	5950 2850 6050 2750
Entry Wire Line
	5950 3050 6050 2950
Entry Wire Line
	5950 3150 6050 3050
Text GLabel 6050 5250 0    50   Input ~ 0
RA[0..8]
Text Label 6250 5550 1    50   ~ 0
RA0
Text Label 6350 5550 1    50   ~ 0
RA1
Text Label 6450 5550 1    50   ~ 0
RA2
Text Label 6550 5550 1    50   ~ 0
RA3
Text Label 7250 5550 1    50   ~ 0
RA4
Text Label 7350 5550 1    50   ~ 0
RA5
Text GLabel 10950 5700 3    50   Input ~ 0
CARD_DET
Text GLabel 10500 3100 2    50   Input ~ 0
CARD_DET
Wire Wire Line
	10500 3100 10200 3100
Wire Wire Line
	6850 5800 6850 5700
Wire Wire Line
	6950 5150 6950 5800
Wire Wire Line
	8350 5050 8900 5050
Wire Wire Line
	8600 5150 8900 5150
Wire Wire Line
	8900 4750 8800 4750
Wire Wire Line
	8800 4750 8800 4250
Wire Wire Line
	5850 5800 6250 5800
Wire Wire Line
	6250 5800 6250 5350
Entry Wire Line
	6250 5350 6150 5250
$Comp
L power:VCC #PWR031
U 1 1 5F9D7BCC
P 6650 5800
F 0 "#PWR031" H 6650 5650 50  0001 C CNN
F 1 "VCC" V 6665 5927 50  0000 L CNN
F 2 "" H 6650 5800 50  0001 C CNN
F 3 "" H 6650 5800 50  0001 C CNN
	1    6650 5800
	1    0    0    -1  
$EndComp
Text Label 5800 2850 0    50   ~ 0
RA6
Text Label 5800 3050 0    50   ~ 0
RA7
Text Label 5800 3150 0    50   ~ 0
RA8
$Comp
L 74xx:74LS32 U14
U 5 1 5F9F70D5
P 10350 1600
F 0 "U14" H 10580 1646 50  0000 L CNN
F 1 "74HC32" H 10400 1200 50  0000 L CNN
F 2 "" H 10350 1600 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS32" H 10350 1600 50  0001 C CNN
	5    10350 1600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR064
U 1 1 5FA2649E
P 10350 2100
F 0 "#PWR064" H 10350 1850 50  0001 C CNN
F 1 "GND" H 10355 1927 50  0000 C CNN
F 2 "" H 10350 2100 50  0001 C CNN
F 3 "" H 10350 2100 50  0001 C CNN
	1    10350 2100
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR063
U 1 1 5FA26720
P 10350 1100
F 0 "#PWR063" H 10350 950 50  0001 C CNN
F 1 "VCC" H 10365 1273 50  0000 C CNN
F 2 "" H 10350 1100 50  0001 C CNN
F 3 "" H 10350 1100 50  0001 C CNN
	1    10350 1100
	1    0    0    -1  
$EndComp
$Comp
L Oscillator:CXO_DIP14 X2
U 1 1 5FA56677
P 6100 1200
F 0 "X2" H 6000 1450 50  0000 R CNN
F 1 "10 MHz" H 6000 950 50  0000 R CNN
F 2 "Oscillator:Oscillator_DIP-14" H 6550 850 50  0001 C CNN
F 3 "http://cdn-reichelt.de/documents/datenblatt/B400/OSZI.pdf" H 6000 1200 50  0001 C CNN
	1    6100 1200
	-1   0    0    -1  
$EndComp
Wire Wire Line
	6500 1200 6500 850 
Wire Wire Line
	6500 850  6100 850 
Wire Wire Line
	6100 850  6100 900 
Wire Wire Line
	6400 1200 6500 1200
Wire Wire Line
	6100 850  6100 800 
Connection ~ 6100 850 
Wire Wire Line
	5800 1200 5050 1200
Wire Wire Line
	7050 4550 7050 5800
Text Label 5300 1200 0    50   ~ 0
CPLD_CLK
$Comp
L power:GND #PWR062
U 1 1 5FA8B361
P 6100 1500
F 0 "#PWR062" H 6100 1250 50  0001 C CNN
F 1 "GND" H 6105 1327 50  0000 C CNN
F 2 "" H 6100 1500 50  0001 C CNN
F 3 "" H 6100 1500 50  0001 C CNN
	1    6100 1500
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR061
U 1 1 5FA8C149
P 6100 800
F 0 "#PWR061" H 6100 650 50  0001 C CNN
F 1 "VCC" H 6115 973 50  0000 C CNN
F 2 "" H 6100 800 50  0001 C CNN
F 3 "" H 6100 800 50  0001 C CNN
	1    6100 800 
	1    0    0    -1  
$EndComp
Wire Wire Line
	8900 4850 8600 4850
Text GLabel 8600 4850 0    50   Input ~ 0
SD_BUSY
Text GLabel 8600 5350 0    50   Input ~ 0
~WR_BUFFER
NoConn ~ 6700 6900
Wire Wire Line
	8150 5550 8900 5550
Wire Wire Line
	8600 5350 8900 5350
Wire Wire Line
	9750 5750 9100 5750
Wire Wire Line
	8450 6200 8450 5650
Wire Wire Line
	8450 5650 8900 5650
$Sheet
S 600  650  800  700 
U 5F9E8365
F0 "SD misc" 50
F1 "SD misc.sch" 50
$EndSheet
$Comp
L CPLD_Altera:EPM240M100 U7
U 1 1 5FA974CD
P 2750 4050
F 0 "U7" H 2750 4100 50  0000 C CNN
F 1 "EPM240M100" H 2750 4000 50  0000 C CNN
F 2 "Package_BGA:BGA-100_6.0x6.0mm_Layout11x11_P0.5mm_Ball0.3mm_Pad0.25mm_NSMD" H 3150 1700 50  0001 L CNN
F 3 "https://www.altera.com/content/dam/altera-www/global/en_US/pdfs/literature/hb/max2/max2_mii5v1.pdf" H 2750 4050 50  0001 C CNN
	1    2750 4050
	1    0    0    -1  
$EndComp
Wire Wire Line
	2350 6450 2450 6450
Wire Wire Line
	3050 6450 3050 6550
Connection ~ 3050 6450
Connection ~ 2450 6450
Wire Wire Line
	2450 6450 2550 6450
Connection ~ 2550 6450
Wire Wire Line
	2550 6450 2650 6450
Connection ~ 2650 6450
Wire Wire Line
	2650 6450 2750 6450
Connection ~ 2750 6450
Wire Wire Line
	2750 6450 2850 6450
Connection ~ 2850 6450
Wire Wire Line
	2850 6450 2950 6450
Connection ~ 2950 6450
Wire Wire Line
	2950 6450 3050 6450
Wire Wire Line
	5750 3850 6700 3850
Wire Wire Line
	5750 3650 6550 3650
Wire Wire Line
	6350 2700 6700 2700
Wire Wire Line
	6450 3100 8400 3100
Wire Wire Line
	6450 3450 6450 3100
Wire Wire Line
	5750 3450 6450 3450
Wire Wire Line
	6550 3400 6550 3650
Wire Wire Line
	6700 3400 6550 3400
Wire Wire Line
	7000 4150 7000 4100
Wire Wire Line
	7500 3650 7500 4100
Wire Wire Line
	7500 2950 7500 3650
Connection ~ 7500 3650
Wire Wire Line
	7000 3650 7500 3650
Wire Wire Line
	7500 4100 7000 4100
Wire Wire Line
	7000 2950 7500 2950
Wire Wire Line
	7650 3850 7300 3850
Wire Wire Line
	7300 3400 8400 3400
Wire Wire Line
	7650 2700 7300 2700
$Comp
L power:GND #PWR045
U 1 1 5F927792
P 7000 4150
F 0 "#PWR045" H 7000 3900 50  0001 C CNN
F 1 "GND" H 7005 3977 50  0000 C CNN
F 2 "" H 7000 4150 50  0001 C CNN
F 3 "" H 7000 4150 50  0001 C CNN
	1    7000 4150
	1    0    0    -1  
$EndComp
Text GLabel 8050 1250 0    50   Output ~ 0
VCC3
Wire Bus Line
	6050 1900 6050 3050
Wire Bus Line
	6050 5250 8050 5250
Wire Bus Line
	9800 6150 10750 6150
$EndSCHEMATC
