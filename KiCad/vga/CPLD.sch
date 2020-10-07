EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 6
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	3050 2150 3050 1950
Text GLabel 3050 1950 1    50   Input ~ 0
~VGA_MEM
Text GLabel 2350 1950 1    50   Input ~ 0
~WR
Text GLabel 2450 1750 1    50   Input ~ 0
~RD
Wire Wire Line
	2450 2150 2450 1750
Wire Wire Line
	2350 2150 2350 1950
$Comp
L power:GND #PWR05
U 1 1 5F6B9432
P 2750 2150
F 0 "#PWR05" H 2750 1900 50  0001 C CNN
F 1 "GND" H 2755 1977 50  0000 C CNN
F 2 "" H 2750 2150 50  0001 C CNN
F 3 "" H 2750 2150 50  0001 C CNN
	1    2750 2150
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR010
U 1 1 5F6BC187
P 3650 2150
F 0 "#PWR010" H 3650 1900 50  0001 C CNN
F 1 "GND" H 3655 1977 50  0000 C CNN
F 2 "" H 3650 2150 50  0001 C CNN
F 3 "" H 3650 2150 50  0001 C CNN
	1    3650 2150
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR014
U 1 1 5F6BC8B9
P 4700 2700
F 0 "#PWR014" H 4700 2450 50  0001 C CNN
F 1 "GND" V 4705 2572 50  0000 R CNN
F 2 "" H 4700 2700 50  0001 C CNN
F 3 "" H 4700 2700 50  0001 C CNN
	1    4700 2700
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR016
U 1 1 5F6BCFC3
P 4700 4000
F 0 "#PWR016" H 4700 3750 50  0001 C CNN
F 1 "GND" V 4705 3872 50  0000 R CNN
F 2 "" H 4700 4000 50  0001 C CNN
F 3 "" H 4700 4000 50  0001 C CNN
	1    4700 4000
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR02
U 1 1 5F6BD822
P 2000 3200
F 0 "#PWR02" H 2000 2950 50  0001 C CNN
F 1 "GND" V 2005 3072 50  0000 R CNN
F 2 "" H 2000 3200 50  0001 C CNN
F 3 "" H 2000 3200 50  0001 C CNN
	1    2000 3200
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR04
U 1 1 5F6BDF59
P 2000 4500
F 0 "#PWR04" H 2000 4250 50  0001 C CNN
F 1 "GND" V 2005 4372 50  0000 R CNN
F 2 "" H 2000 4500 50  0001 C CNN
F 3 "" H 2000 4500 50  0001 C CNN
	1    2000 4500
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR08
U 1 1 5F6BE851
P 3250 4900
F 0 "#PWR08" H 3250 4650 50  0001 C CNN
F 1 "GND" H 3255 4727 50  0000 C CNN
F 2 "" H 3250 4900 50  0001 C CNN
F 3 "" H 3250 4900 50  0001 C CNN
	1    3250 4900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR011
U 1 1 5F6BF4BB
P 3750 4900
F 0 "#PWR011" H 3750 4650 50  0001 C CNN
F 1 "GND" H 3755 4727 50  0000 C CNN
F 2 "" H 3750 4900 50  0001 C CNN
F 3 "" H 3750 4900 50  0001 C CNN
	1    3750 4900
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR09
U 1 1 5F6BF953
P 3350 5150
F 0 "#PWR09" H 3350 5000 50  0001 C CNN
F 1 "VCC" H 3365 5323 50  0000 C CNN
F 2 "" H 3350 5150 50  0001 C CNN
F 3 "" H 3350 5150 50  0001 C CNN
	1    3350 5150
	-1   0    0    1   
$EndComp
$Comp
L power:VCC #PWR013
U 1 1 5F6C066F
P 4350 4900
F 0 "#PWR013" H 4350 4750 50  0001 C CNN
F 1 "VCC" H 4365 5073 50  0000 C CNN
F 2 "" H 4350 4900 50  0001 C CNN
F 3 "" H 4350 4900 50  0001 C CNN
	1    4350 4900
	-1   0    0    1   
$EndComp
$Comp
L power:VCC #PWR03
U 1 1 5F6C152F
P 2000 3900
F 0 "#PWR03" H 2000 3750 50  0001 C CNN
F 1 "VCC" V 2015 4027 50  0000 L CNN
F 2 "" H 2000 3900 50  0001 C CNN
F 3 "" H 2000 3900 50  0001 C CNN
	1    2000 3900
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR015
U 1 1 5F6C1DBD
P 4700 3300
F 0 "#PWR015" H 4700 3150 50  0001 C CNN
F 1 "VCC" V 4715 3428 50  0000 L CNN
F 2 "" H 4700 3300 50  0001 C CNN
F 3 "" H 4700 3300 50  0001 C CNN
	1    4700 3300
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR012
U 1 1 5F6C2914
P 4050 2150
F 0 "#PWR012" H 4050 2000 50  0001 C CNN
F 1 "VCC" H 4065 2323 50  0000 C CNN
F 2 "" H 4050 2150 50  0001 C CNN
F 3 "" H 4050 2150 50  0001 C CNN
	1    4050 2150
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR07
U 1 1 5F6C32C2
P 3150 2150
F 0 "#PWR07" H 3150 2000 50  0001 C CNN
F 1 "VCC" H 3165 2323 50  0000 C CNN
F 2 "" H 3150 2150 50  0001 C CNN
F 3 "" H 3150 2150 50  0001 C CNN
	1    3150 2150
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR01
U 1 1 5F6C3911
P 2000 2600
F 0 "#PWR01" H 2000 2450 50  0001 C CNN
F 1 "VCC" V 2015 2727 50  0000 L CNN
F 2 "" H 2000 2600 50  0001 C CNN
F 3 "" H 2000 2600 50  0001 C CNN
	1    2000 2600
	0    -1   -1   0   
$EndComp
Text GLabel 1700 2800 0    50   Output ~ 0
~WE_R0
Text GLabel 1250 2900 0    50   Output ~ 0
~WE_R1
Text GLabel 1700 3000 0    50   Output ~ 0
~WE_R2
Text GLabel 1250 3100 0    50   Output ~ 0
~WE_R3
Wire Wire Line
	2000 2800 1700 2800
Wire Wire Line
	1250 2900 2000 2900
Wire Wire Line
	2000 3000 1700 3000
Wire Wire Line
	1250 3100 2000 3100
Text GLabel 1700 3300 0    50   Output ~ 0
~CS_R0
Text GLabel 1250 3400 0    50   Output ~ 0
~CS_R1
Text GLabel 1700 3500 0    50   Output ~ 0
~CS_R2
Text GLabel 1250 3600 0    50   Output ~ 0
~CS_R3
Wire Wire Line
	2000 3300 1700 3300
Wire Wire Line
	1250 3400 2000 3400
Wire Wire Line
	2000 3500 1700 3500
Wire Wire Line
	2000 3600 1250 3600
Text GLabel 1850 3700 0    50   Output ~ 0
CPU_RAM_DIR
Wire Wire Line
	2000 3700 1850 3700
Wire Wire Line
	1700 4000 2000 4000
Text GLabel 1700 4000 0    50   Output ~ 0
LATCH
Text GLabel 1250 4100 0    50   Output ~ 0
~OE_L0
Text GLabel 1700 4200 0    50   Output ~ 0
~OE_L1
Text GLabel 1250 4300 0    50   Output ~ 0
~OE_L2
Text GLabel 1700 4400 0    50   Output ~ 0
~OE_L3
Wire Wire Line
	1250 4100 2000 4100
Wire Wire Line
	2000 4200 1700 4200
Wire Wire Line
	2000 4300 1250 4300
Wire Wire Line
	1700 4400 2000 4400
Wire Wire Line
	3350 5150 3350 4900
$Comp
L power:VCC #PWR06
U 1 1 5F6CA4BF
P 2850 4900
F 0 "#PWR06" H 2850 4750 50  0001 C CNN
F 1 "VCC" H 2865 5073 50  0000 C CNN
F 2 "" H 2850 4900 50  0001 C CNN
F 3 "" H 2850 4900 50  0001 C CNN
	1    2850 4900
	-1   0    0    1   
$EndComp
Text GLabel 2350 5150 3    50   Output ~ 0
CHROW0
Text GLabel 2450 5550 3    50   Output ~ 0
CHROW1
Text GLabel 2550 5150 3    50   Output ~ 0
CHROW2
Text GLabel 2650 5550 3    50   Output ~ 0
CHROW3
Wire Wire Line
	2350 5150 2350 4900
Wire Wire Line
	2450 5550 2450 4900
Wire Wire Line
	2550 5150 2550 4900
Wire Wire Line
	2650 5550 2650 4900
Text GLabel 2950 5150 3    50   Output ~ 0
~CHARMODE
Text GLabel 3050 5600 3    50   Input ~ 0
~CHARPIXEL
Wire Wire Line
	2950 5150 2950 4900
Wire Wire Line
	3050 4900 3050 5600
Text GLabel 3450 5550 3    50   Output ~ 0
CHCOL0
Text GLabel 3550 5150 3    50   Output ~ 0
CHCOL1
Text GLabel 3650 5550 3    50   Output ~ 0
CHCOL2
Wire Wire Line
	3550 5150 3550 4900
Wire Wire Line
	3450 4900 3450 5550
Wire Wire Line
	3650 5550 3650 4900
Text GLabel 3950 5600 3    50   Output ~ 0
~CHAR_BG
Text GLabel 4050 5050 3    50   Output ~ 0
~CHR_TO_COL
Wire Wire Line
	4050 4900 4050 5050
Wire Wire Line
	3950 4900 3950 5600
$Comp
L Oscillator:ACO-xxxMHz X1
U 1 1 5F6F02F6
P 4850 1250
F 0 "X1" H 4506 1296 50  0000 R CNN
F 1 "50 MHz" H 4506 1205 50  0000 R CNN
F 2 "Oscillator:Oscillator_DIP-14" H 5300 900 50  0001 C CNN
F 3 "http://www.conwin.com/datasheets/cx/cx030.pdf" H 4750 1250 50  0001 C CNN
	1    4850 1250
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR018
U 1 1 5F6F1C7E
P 4850 1550
F 0 "#PWR018" H 4850 1300 50  0001 C CNN
F 1 "GND" H 4855 1377 50  0000 C CNN
F 2 "" H 4850 1550 50  0001 C CNN
F 3 "" H 4850 1550 50  0001 C CNN
	1    4850 1550
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR017
U 1 1 5F6F23A2
P 4850 950
F 0 "#PWR017" H 4850 800 50  0001 C CNN
F 1 "VCC" H 4865 1123 50  0000 C CNN
F 2 "" H 4850 950 50  0001 C CNN
F 3 "" H 4850 950 50  0001 C CNN
	1    4850 950 
	1    0    0    -1  
$EndComp
Wire Wire Line
	3550 2150 3550 1250
Wire Wire Line
	3550 1250 4550 1250
Wire Wire Line
	3350 2150 3350 1950
Text GLabel 3350 1950 1    50   Input ~ 0
~RESET
Entry Wire Line
	5500 2500 5400 2600
Entry Wire Line
	5500 2400 5400 2500
Entry Wire Line
	5500 2700 5400 2800
Entry Wire Line
	5500 2800 5400 2900
Entry Wire Line
	5500 2900 5400 3000
Entry Wire Line
	5500 3000 5400 3100
Entry Wire Line
	5500 3100 5400 3200
Entry Wire Line
	5500 3300 5400 3400
Entry Wire Line
	5500 3400 5400 3500
Entry Wire Line
	5500 3500 5400 3600
Entry Wire Line
	5500 3600 5400 3700
Entry Wire Line
	5500 3700 5400 3800
Entry Wire Line
	5500 3800 5400 3900
Entry Wire Line
	5500 4000 5400 4100
Entry Wire Line
	5500 4100 5400 4200
Wire Wire Line
	4700 2500 5400 2500
Wire Wire Line
	4700 2600 5400 2600
Wire Wire Line
	4700 2800 5400 2800
Wire Wire Line
	4700 2900 5400 2900
Wire Wire Line
	4700 3000 5400 3000
Wire Wire Line
	4700 3100 5400 3100
Wire Wire Line
	4700 3200 5400 3200
Wire Wire Line
	4700 3400 5400 3400
Wire Wire Line
	4700 3500 5400 3500
Wire Wire Line
	4700 3600 5400 3600
Wire Wire Line
	4700 3700 5400 3700
Wire Wire Line
	4700 3800 5400 3800
Wire Wire Line
	4700 3900 5400 3900
Wire Wire Line
	4700 4100 5400 4100
Wire Wire Line
	4700 4200 5400 4200
Wire Bus Line
	5500 2300 5550 2300
Text GLabel 5550 2300 2    50   Output ~ 0
RA[0..14]
Text Label 5050 2500 0    50   ~ 0
RA0
Text Label 5050 2600 0    50   ~ 0
RA1
Text Label 5050 2800 0    50   ~ 0
RA2
Text Label 5050 2900 0    50   ~ 0
RA3
Text Label 5050 3000 0    50   ~ 0
RA4
Text Label 5050 3100 0    50   ~ 0
RA5
Text Label 5050 3200 0    50   ~ 0
RA6
Text Label 5050 3400 0    50   ~ 0
RA7
Text Label 5050 3500 0    50   ~ 0
RA8
Text Label 5050 3600 0    50   ~ 0
RA9
Text Label 5050 3700 0    50   ~ 0
RA10
Text Label 5050 3800 0    50   ~ 0
RA11
Text Label 5050 3900 0    50   ~ 0
RA12
Text Label 5050 4100 0    50   ~ 0
RA13
Text Label 5050 4200 0    50   ~ 0
RA14
Entry Wire Line
	2750 1450 2850 1550
Entry Wire Line
	2750 1450 2850 1550
Entry Wire Line
	2550 1450 2650 1550
Entry Wire Line
	2450 1450 2550 1550
Wire Wire Line
	2850 1550 2850 2150
Wire Wire Line
	2650 1550 2650 2150
Wire Wire Line
	2550 1550 2550 2150
Text Label 2850 1900 1    50   ~ 0
A0
Text Label 2650 1900 1    50   ~ 0
A1
Text Label 2550 1900 1    50   ~ 0
A2
Text GLabel 2400 1450 0    50   Input ~ 0
A[0..19]
Wire Wire Line
	2750 4900 2750 5150
Text GLabel 2750 5150 3    50   Input ~ 0
~BHE
Text GLabel 4250 1150 1    50   Output ~ 0
~V_SYNC
Wire Wire Line
	4250 2150 4250 1150
NoConn ~ 3750 2150
NoConn ~ 3450 2150
NoConn ~ 3250 2150
NoConn ~ 3150 4900
NoConn ~ 4700 4300
NoConn ~ 2000 2700
$Comp
L Device:C C1
U 1 1 5F96E986
P 850 7050
F 0 "C1" H 965 7096 50  0000 L CNN
F 1 "100n" H 965 7005 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 888 6900 50  0001 C CNN
F 3 "~" H 850 7050 50  0001 C CNN
	1    850  7050
	1    0    0    -1  
$EndComp
$Comp
L Device:C C2
U 1 1 5F970209
P 1250 7050
F 0 "C2" H 1365 7096 50  0000 L CNN
F 1 "100n" H 1365 7005 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 1288 6900 50  0001 C CNN
F 3 "~" H 1250 7050 50  0001 C CNN
	1    1250 7050
	1    0    0    -1  
$EndComp
$Comp
L Device:C C3
U 1 1 5F970746
P 1650 7050
F 0 "C3" H 1765 7096 50  0000 L CNN
F 1 "100n" H 1765 7005 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 1688 6900 50  0001 C CNN
F 3 "~" H 1650 7050 50  0001 C CNN
	1    1650 7050
	1    0    0    -1  
$EndComp
$Comp
L Device:C C4
U 1 1 5F970C71
P 2050 7050
F 0 "C4" H 2165 7096 50  0000 L CNN
F 1 "100n" H 2165 7005 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 2088 6900 50  0001 C CNN
F 3 "~" H 2050 7050 50  0001 C CNN
	1    2050 7050
	1    0    0    -1  
$EndComp
$Comp
L Device:C C5
U 1 1 5F970F9E
P 2450 7050
F 0 "C5" H 2565 7096 50  0000 L CNN
F 1 "100n" H 2565 7005 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 2488 6900 50  0001 C CNN
F 3 "~" H 2450 7050 50  0001 C CNN
	1    2450 7050
	1    0    0    -1  
$EndComp
$Comp
L Device:C C6
U 1 1 5F97150A
P 2850 7050
F 0 "C6" H 2965 7096 50  0000 L CNN
F 1 "100n" H 2965 7005 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 2888 6900 50  0001 C CNN
F 3 "~" H 2850 7050 50  0001 C CNN
	1    2850 7050
	1    0    0    -1  
$EndComp
$Comp
L Device:C C7
U 1 1 5F971945
P 3250 7050
F 0 "C7" H 3365 7096 50  0000 L CNN
F 1 "100n" H 3365 7005 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 3288 6900 50  0001 C CNN
F 3 "~" H 3250 7050 50  0001 C CNN
	1    3250 7050
	1    0    0    -1  
$EndComp
$Comp
L Device:C C8
U 1 1 5F97575D
P 3650 7050
F 0 "C8" H 3765 7096 50  0000 L CNN
F 1 "100n" H 3765 7005 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 3688 6900 50  0001 C CNN
F 3 "~" H 3650 7050 50  0001 C CNN
	1    3650 7050
	1    0    0    -1  
$EndComp
$Comp
L Device:C C9
U 1 1 5F975990
P 4050 7050
F 0 "C9" H 4165 7096 50  0000 L CNN
F 1 "100n" H 4165 7005 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 4088 6900 50  0001 C CNN
F 3 "~" H 4050 7050 50  0001 C CNN
	1    4050 7050
	1    0    0    -1  
$EndComp
$Comp
L Device:C C10
U 1 1 5F975CC4
P 4450 7050
F 0 "C10" H 4565 7096 50  0000 L CNN
F 1 "100n" H 4565 7005 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 4488 6900 50  0001 C CNN
F 3 "~" H 4450 7050 50  0001 C CNN
	1    4450 7050
	1    0    0    -1  
$EndComp
$Comp
L Device:C C11
U 1 1 5F9760DC
P 4850 7050
F 0 "C11" H 4965 7096 50  0000 L CNN
F 1 "100n" H 4965 7005 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 4888 6900 50  0001 C CNN
F 3 "~" H 4850 7050 50  0001 C CNN
	1    4850 7050
	1    0    0    -1  
$EndComp
$Comp
L Device:C C12
U 1 1 5F9765A1
P 5250 7050
F 0 "C12" H 5365 7096 50  0000 L CNN
F 1 "100n" H 5365 7005 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 5288 6900 50  0001 C CNN
F 3 "~" H 5250 7050 50  0001 C CNN
	1    5250 7050
	1    0    0    -1  
$EndComp
$Comp
L Device:C C13
U 1 1 5F976904
P 5650 7050
F 0 "C13" H 5765 7096 50  0000 L CNN
F 1 "100n" H 5765 7005 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 5688 6900 50  0001 C CNN
F 3 "~" H 5650 7050 50  0001 C CNN
	1    5650 7050
	1    0    0    -1  
$EndComp
$Comp
L Device:C C14
U 1 1 5F976D46
P 6050 7050
F 0 "C14" H 6165 7096 50  0000 L CNN
F 1 "100n" H 6165 7005 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 6088 6900 50  0001 C CNN
F 3 "~" H 6050 7050 50  0001 C CNN
	1    6050 7050
	1    0    0    -1  
$EndComp
$Comp
L Device:C C15
U 1 1 5F977163
P 6450 7050
F 0 "C15" H 6565 7096 50  0000 L CNN
F 1 "100n" H 6565 7005 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 6488 6900 50  0001 C CNN
F 3 "~" H 6450 7050 50  0001 C CNN
	1    6450 7050
	1    0    0    -1  
$EndComp
Wire Wire Line
	6450 7200 6450 7300
Wire Wire Line
	6450 7300 6050 7300
Wire Wire Line
	1250 7200 1250 7300
Connection ~ 1250 7300
Wire Wire Line
	1250 7300 850  7300
Wire Wire Line
	1650 7200 1650 7300
Connection ~ 1650 7300
Wire Wire Line
	1650 7300 1250 7300
Wire Wire Line
	2050 7200 2050 7300
Connection ~ 2050 7300
Wire Wire Line
	2050 7300 1650 7300
Wire Wire Line
	2450 7200 2450 7300
Connection ~ 2450 7300
Wire Wire Line
	2450 7300 2050 7300
Wire Wire Line
	2850 7200 2850 7300
Connection ~ 2850 7300
Wire Wire Line
	2850 7300 2450 7300
Wire Wire Line
	3250 7200 3250 7300
Connection ~ 3250 7300
Wire Wire Line
	3250 7300 2850 7300
Wire Wire Line
	3650 7200 3650 7300
Connection ~ 3650 7300
Wire Wire Line
	3650 7300 3250 7300
Wire Wire Line
	4050 7200 4050 7300
Connection ~ 4050 7300
Wire Wire Line
	4050 7300 3650 7300
Wire Wire Line
	4450 7200 4450 7300
Connection ~ 4450 7300
Wire Wire Line
	4450 7300 4050 7300
Wire Wire Line
	4850 7200 4850 7300
Connection ~ 4850 7300
Wire Wire Line
	4850 7300 4450 7300
Wire Wire Line
	5250 7200 5250 7300
Connection ~ 5250 7300
Wire Wire Line
	5250 7300 4850 7300
Wire Wire Line
	5650 7200 5650 7300
Connection ~ 5650 7300
Wire Wire Line
	5650 7300 5250 7300
Wire Wire Line
	6050 7200 6050 7300
Connection ~ 6050 7300
Wire Wire Line
	6050 7300 5650 7300
Wire Wire Line
	6450 6900 6450 6800
Wire Wire Line
	6450 6800 6050 6800
Wire Wire Line
	1250 6900 1250 6800
Connection ~ 1250 6800
Wire Wire Line
	1250 6800 850  6800
Wire Wire Line
	1650 6900 1650 6800
Connection ~ 1650 6800
Wire Wire Line
	1650 6800 1250 6800
Wire Wire Line
	2050 6900 2050 6800
Connection ~ 2050 6800
Wire Wire Line
	2050 6800 1650 6800
Wire Wire Line
	2450 6900 2450 6800
Connection ~ 2450 6800
Wire Wire Line
	2450 6800 2050 6800
Wire Wire Line
	2850 6900 2850 6800
Connection ~ 2850 6800
Wire Wire Line
	2850 6800 2450 6800
Wire Wire Line
	3250 6800 3250 6900
Connection ~ 3250 6800
Wire Wire Line
	3250 6800 2850 6800
Wire Wire Line
	3650 6900 3650 6800
Connection ~ 3650 6800
Wire Wire Line
	3650 6800 3250 6800
Wire Wire Line
	4050 6900 4050 6800
Connection ~ 4050 6800
Wire Wire Line
	4050 6800 3650 6800
Wire Wire Line
	4450 6900 4450 6800
Connection ~ 4450 6800
Wire Wire Line
	4450 6800 4050 6800
Wire Wire Line
	4850 6900 4850 6800
Connection ~ 4850 6800
Wire Wire Line
	4850 6800 4450 6800
Wire Wire Line
	5250 6900 5250 6800
Connection ~ 5250 6800
Wire Wire Line
	5250 6800 4850 6800
Wire Wire Line
	5650 6900 5650 6800
Connection ~ 5650 6800
Wire Wire Line
	5650 6800 5250 6800
Wire Wire Line
	6050 6900 6050 6800
Connection ~ 6050 6800
Wire Wire Line
	6050 6800 5650 6800
Wire Wire Line
	850  6800 850  6900
Wire Wire Line
	850  7200 850  7300
Connection ~ 850  7300
Wire Wire Line
	850  7300 850  7400
Connection ~ 850  6800
$Comp
L power:VCC #PWR078
U 1 1 5F9C341E
P 850 6700
F 0 "#PWR078" H 850 6550 50  0001 C CNN
F 1 "VCC" H 865 6873 50  0000 C CNN
F 2 "" H 850 6700 50  0001 C CNN
F 3 "" H 850 6700 50  0001 C CNN
	1    850  6700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR079
U 1 1 5F9C3D22
P 850 7400
F 0 "#PWR079" H 850 7150 50  0001 C CNN
F 1 "GND" H 855 7227 50  0000 C CNN
F 2 "" H 850 7400 50  0001 C CNN
F 3 "" H 850 7400 50  0001 C CNN
	1    850  7400
	1    0    0    -1  
$EndComp
$Comp
L Device:C C16
U 1 1 5F9ED393
P 5900 5600
F 0 "C16" H 6015 5646 50  0000 L CNN
F 1 "100n" H 6015 5555 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.4mm_W2.1mm_P2.50mm" H 5938 5450 50  0001 C CNN
F 3 "~" H 5900 5600 50  0001 C CNN
	1    5900 5600
	1    0    0    -1  
$EndComp
$Comp
L Device:C C17
U 1 1 5F9ED9FA
P 6300 5600
F 0 "C17" H 6415 5646 50  0000 L CNN
F 1 "100n" H 6415 5555 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.4mm_W2.1mm_P2.50mm" H 6338 5450 50  0001 C CNN
F 3 "~" H 6300 5600 50  0001 C CNN
	1    6300 5600
	1    0    0    -1  
$EndComp
$Comp
L Device:C C18
U 1 1 5F9EDB88
P 6700 5600
F 0 "C18" H 6815 5646 50  0000 L CNN
F 1 "100n" H 6815 5555 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.4mm_W2.1mm_P2.50mm" H 6738 5450 50  0001 C CNN
F 3 "~" H 6700 5600 50  0001 C CNN
	1    6700 5600
	1    0    0    -1  
$EndComp
$Comp
L Device:C C19
U 1 1 5F9EDDEF
P 7100 5600
F 0 "C19" H 7215 5646 50  0000 L CNN
F 1 "100n" H 7215 5555 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.4mm_W2.1mm_P2.50mm" H 7138 5450 50  0001 C CNN
F 3 "~" H 7100 5600 50  0001 C CNN
	1    7100 5600
	1    0    0    -1  
$EndComp
$Comp
L Device:C C20
U 1 1 5F9EE122
P 7500 5600
F 0 "C20" H 7615 5646 50  0000 L CNN
F 1 "100n" H 7615 5555 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.4mm_W2.1mm_P2.50mm" H 7538 5450 50  0001 C CNN
F 3 "~" H 7500 5600 50  0001 C CNN
	1    7500 5600
	1    0    0    -1  
$EndComp
Wire Wire Line
	7500 5750 7500 5850
Wire Wire Line
	7500 5850 7100 5850
Wire Wire Line
	5900 5850 5900 5750
Wire Wire Line
	6300 5750 6300 5850
Connection ~ 6300 5850
Wire Wire Line
	6300 5850 5900 5850
Wire Wire Line
	6700 5750 6700 5850
Connection ~ 6700 5850
Wire Wire Line
	6700 5850 6300 5850
Wire Wire Line
	7100 5750 7100 5850
Connection ~ 7100 5850
Wire Wire Line
	7100 5850 6700 5850
Connection ~ 5900 5850
Wire Wire Line
	5900 5350 6300 5350
Wire Wire Line
	7500 5350 7500 5450
Wire Wire Line
	5900 5350 5900 5450
Wire Wire Line
	7100 5450 7100 5350
Connection ~ 7100 5350
Wire Wire Line
	7100 5350 7500 5350
Wire Wire Line
	6700 5450 6700 5350
Connection ~ 6700 5350
Wire Wire Line
	6700 5350 7100 5350
Wire Wire Line
	6300 5450 6300 5350
Connection ~ 6300 5350
Wire Wire Line
	6300 5350 6700 5350
Wire Wire Line
	5900 5850 5900 5950
Wire Wire Line
	5900 5350 5900 5250
Connection ~ 5900 5350
$Comp
L power:GND #PWR081
U 1 1 5FA25645
P 5900 5950
F 0 "#PWR081" H 5900 5700 50  0001 C CNN
F 1 "GND" H 5905 5777 50  0000 C CNN
F 2 "" H 5900 5950 50  0001 C CNN
F 3 "" H 5900 5950 50  0001 C CNN
	1    5900 5950
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR080
U 1 1 5FA25A3F
P 5900 5250
F 0 "#PWR080" H 5900 5100 50  0001 C CNN
F 1 "VCC" H 5915 5423 50  0000 C CNN
F 2 "" H 5900 5250 50  0001 C CNN
F 3 "" H 5900 5250 50  0001 C CNN
	1    5900 5250
	1    0    0    -1  
$EndComp
$Comp
L Device:C C21
U 1 1 5FA4EF2F
P 7900 5600
F 0 "C21" H 8015 5646 50  0000 L CNN
F 1 "100n" H 8015 5555 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 7938 5450 50  0001 C CNN
F 3 "~" H 7900 5600 50  0001 C CNN
	1    7900 5600
	1    0    0    -1  
$EndComp
Wire Wire Line
	7900 5450 7900 5350
Wire Wire Line
	7900 5350 7500 5350
Connection ~ 7500 5350
Wire Wire Line
	7900 5750 7900 5850
Wire Wire Line
	7900 5850 7500 5850
Connection ~ 7500 5850
Wire Wire Line
	4700 4500 4900 4500
Wire Wire Line
	4700 4400 5350 4400
Text GLabel 4900 4500 2    50   Output ~ 0
~CPU_RAM2
Text GLabel 5350 4400 2    50   Output ~ 0
~CPU_RAM3
Text GLabel 1300 3800 0    50   Output ~ 0
~CPU_RAM_ADDR
Wire Wire Line
	2000 3800 1300 3800
Wire Wire Line
	4150 4900 4150 5600
Text GLabel 4150 5600 3    50   Output ~ 0
~CPU_RAM0
Text GLabel 4250 5150 3    50   Output ~ 0
~CPU_RAM1
$Comp
L Mini8086:EPM7064S U14
U 1 1 5F76BBCB
P 8400 3050
F 0 "U14" H 8350 2800 50  0000 L CNN
F 1 "EPM7064S" H 8200 2900 50  0000 L CNN
F 2 "Package_LCC:PLCC-44_THT-Socket" H 8500 2900 50  0001 C CNN
F 3 "" H 8500 2900 50  0001 C CNN
	1    8400 3050
	1    0    0    -1  
$EndComp
Wire Wire Line
	3550 1250 3550 700 
Wire Wire Line
	3550 700  8600 700 
Wire Wire Line
	8600 700  8600 2150
Connection ~ 3550 1250
$Comp
L power:GND #PWR082
U 1 1 5F772E68
P 8300 3950
F 0 "#PWR082" H 8300 3700 50  0001 C CNN
F 1 "GND" H 8305 3777 50  0000 C CNN
F 2 "" H 8300 3950 50  0001 C CNN
F 3 "" H 8300 3950 50  0001 C CNN
	1    8300 3950
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR083
U 1 1 5F7733B6
P 8400 4200
F 0 "#PWR083" H 8400 4050 50  0001 C CNN
F 1 "VCC" H 8415 4373 50  0000 C CNN
F 2 "" H 8400 4200 50  0001 C CNN
F 3 "" H 8400 4200 50  0001 C CNN
	1    8400 4200
	-1   0    0    1   
$EndComp
$Comp
L power:VCC #PWR085
U 1 1 5F773C07
P 9300 2950
F 0 "#PWR085" H 9300 2800 50  0001 C CNN
F 1 "VCC" V 9315 3078 50  0000 L CNN
F 2 "" H 9300 2950 50  0001 C CNN
F 3 "" H 9300 2950 50  0001 C CNN
	1    9300 2950
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR086
U 1 1 5F779A73
P 9300 3450
F 0 "#PWR086" H 9300 3200 50  0001 C CNN
F 1 "GND" V 9305 3322 50  0000 R CNN
F 2 "" H 9300 3450 50  0001 C CNN
F 3 "" H 9300 3450 50  0001 C CNN
	1    9300 3450
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR051
U 1 1 5F779FD9
P 7500 3350
F 0 "#PWR051" H 7500 3200 50  0001 C CNN
F 1 "VCC" V 7515 3477 50  0000 L CNN
F 2 "" H 7500 3350 50  0001 C CNN
F 3 "" H 7500 3350 50  0001 C CNN
	1    7500 3350
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR050
U 1 1 5F77A567
P 7500 2850
F 0 "#PWR050" H 7500 2600 50  0001 C CNN
F 1 "GND" V 7505 2722 50  0000 R CNN
F 2 "" H 7500 2850 50  0001 C CNN
F 3 "" H 7500 2850 50  0001 C CNN
	1    7500 2850
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR084
U 1 1 5F77AABD
P 8700 2150
F 0 "#PWR084" H 8700 1900 50  0001 C CNN
F 1 "GND" H 8705 1977 50  0000 C CNN
F 2 "" H 8700 2150 50  0001 C CNN
F 3 "" H 8700 2150 50  0001 C CNN
	1    8700 2150
	-1   0    0    1   
$EndComp
Wire Wire Line
	8400 4200 8400 3950
Wire Wire Line
	7500 2550 7100 2550
Wire Wire Line
	7500 2650 7100 2650
Wire Wire Line
	7500 2750 7100 2750
Wire Wire Line
	7500 2950 7100 2950
Wire Wire Line
	7500 3050 7100 3050
Wire Wire Line
	7500 3150 7100 3150
Wire Wire Line
	7500 3250 7100 3250
Wire Wire Line
	7500 3450 7100 3450
Entry Wire Line
	7100 3450 7000 3350
Entry Wire Line
	7100 3250 7000 3150
Entry Wire Line
	7100 3150 7000 3050
Entry Wire Line
	7100 3050 7000 2950
Entry Wire Line
	7100 2950 7000 2850
Entry Wire Line
	7100 2750 7000 2650
Entry Wire Line
	7100 2650 7000 2550
Entry Wire Line
	7100 2550 7000 2450
Wire Bus Line
	7000 2350 6950 2350
Text GLabel 6950 2350 0    50   Input ~ 0
D[0..7]
Text Label 7150 3450 0    50   ~ 0
D0
Text Label 7150 3250 0    50   ~ 0
D1
Text Label 7150 3150 0    50   ~ 0
D2
Text Label 7150 3050 0    50   ~ 0
D3
Text Label 7150 2950 0    50   ~ 0
D4
Text Label 7150 2750 0    50   ~ 0
D5
Text Label 7150 2650 0    50   ~ 0
D6
Text Label 7150 2550 0    50   ~ 0
D7
Wire Wire Line
	7900 2150 7900 1900
Wire Wire Line
	7900 1900 3950 1900
Wire Wire Line
	3950 1900 3950 2150
Wire Wire Line
	8000 2150 8000 1800
Wire Wire Line
	8000 1800 3850 1800
Wire Wire Line
	3850 1800 3850 2150
Text Label 7250 1900 0    50   ~ 0
MODE0
Text Label 7250 1800 0    50   ~ 0
MODE1
Wire Wire Line
	8100 2150 8100 1800
Wire Wire Line
	8200 2150 8200 1800
Entry Wire Line
	8100 1800 8000 1700
Entry Wire Line
	8200 1800 8100 1700
Text GLabel 7900 1700 0    50   Input ~ 0
A[0..19]
Text Label 8200 2000 1    50   ~ 0
A1
Text Label 8100 2000 1    50   ~ 0
A2
Wire Wire Line
	4350 2150 4350 1650
Text GLabel 4350 1650 1    50   Output ~ 0
~H_SYNC
Wire Wire Line
	8900 3950 8900 4500
Wire Wire Line
	8800 3950 8800 4500
Wire Wire Line
	8700 3950 8700 4500
Wire Wire Line
	8600 3950 8600 4500
Wire Wire Line
	8500 3950 8500 4500
Wire Wire Line
	8200 3950 8200 4500
Wire Wire Line
	8100 3950 8100 4500
Wire Wire Line
	8000 3950 8000 4500
Entry Wire Line
	8000 4500 8100 4600
Entry Wire Line
	8100 4500 8200 4600
Entry Wire Line
	8200 4500 8300 4600
Entry Wire Line
	8500 4500 8600 4600
Entry Wire Line
	8600 4500 8700 4600
Entry Wire Line
	8700 4500 8800 4600
Entry Wire Line
	8800 4500 8900 4600
Entry Wire Line
	8900 4500 9000 4600
Text GLabel 9250 4600 2    50   Output ~ 0
DCOL[0..7]
Text Label 8000 4300 1    50   ~ 0
DCOL0
Text Label 8100 4300 1    50   ~ 0
DCOL1
Text Label 8200 4300 1    50   ~ 0
DCOL2
Text Label 8500 4300 1    50   ~ 0
DCOL3
Text Label 8600 4300 1    50   ~ 0
DCOL4
Text Label 8700 4300 1    50   ~ 0
DCOL5
Text Label 8800 4300 1    50   ~ 0
DCOL6
Text Label 8900 4300 1    50   ~ 0
DCOL7
Wire Wire Line
	8300 2150 8300 1800
Text GLabel 8300 1800 1    50   Input ~ 0
~CHAR_BG
Wire Wire Line
	8800 2150 8800 1350
Wire Wire Line
	8800 1350 6500 1350
Wire Wire Line
	6500 1350 6500 2000
Wire Wire Line
	6500 2000 4150 2000
Wire Wire Line
	4150 2000 4150 2150
Text Label 7250 1350 0    50   ~ 0
PLANE
Wire Wire Line
	7500 3550 7200 3550
Text GLabel 7200 3550 0    50   Input ~ 0
~VGA_IO
Wire Wire Line
	7900 3950 7900 4450
Text GLabel 7900 4450 3    50   Input ~ 0
~WR
Text GLabel 8400 2100 1    50   Input ~ 0
~RESET
Wire Wire Line
	8400 2150 8400 2100
Wire Wire Line
	2000 2500 1700 2500
Text GLabel 1700 2500 0    50   Output ~ 0
RDY1
NoConn ~ 2950 2150
Wire Wire Line
	4250 4900 4250 5150
$Comp
L Mini8086:EPM7128S U1
U 1 1 5F66F70E
P 3350 3550
F 0 "U1" H 3300 3650 50  0000 L CNN
F 1 "EPM7128S" H 3150 3500 50  0000 L CNN
F 2 "Package_LCC:PLCC-84_THT-Socket" H 1500 4950 50  0001 C CNN
F 3 "" H 2450 4950 50  0001 C CNN
	1    3350 3550
	1    0    0    -1  
$EndComp
NoConn ~ 8500 2150
NoConn ~ 8900 2150
NoConn ~ 9300 3550
NoConn ~ 9300 3350
NoConn ~ 9300 3250
NoConn ~ 9300 3150
NoConn ~ 9300 3050
NoConn ~ 9300 2850
NoConn ~ 9300 2750
NoConn ~ 9300 2650
NoConn ~ 9300 2550
$Comp
L Device:CP C22
U 1 1 5F7DB7D6
P 8350 5600
F 0 "C22" H 8468 5646 50  0000 L CNN
F 1 "10µ" H 8468 5555 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D5.0mm_P2.50mm" H 8388 5450 50  0001 C CNN
F 3 "~" H 8350 5600 50  0001 C CNN
	1    8350 5600
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C23
U 1 1 5F7DBD5C
P 8750 5600
F 0 "C23" H 8868 5646 50  0000 L CNN
F 1 "10µ" H 8868 5555 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D5.0mm_P2.50mm" H 8788 5450 50  0001 C CNN
F 3 "~" H 8750 5600 50  0001 C CNN
	1    8750 5600
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C24
U 1 1 5F7DC096
P 9150 5600
F 0 "C24" H 9268 5646 50  0000 L CNN
F 1 "10µ" H 9268 5555 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D5.0mm_P2.50mm" H 9188 5450 50  0001 C CNN
F 3 "~" H 9150 5600 50  0001 C CNN
	1    9150 5600
	1    0    0    -1  
$EndComp
Wire Wire Line
	8350 5750 8350 5850
Wire Wire Line
	8350 5850 7900 5850
Connection ~ 7900 5850
Wire Wire Line
	8750 5750 8750 5850
Wire Wire Line
	8750 5850 8350 5850
Connection ~ 8350 5850
Wire Wire Line
	9150 5750 9150 5850
Wire Wire Line
	9150 5850 8750 5850
Connection ~ 8750 5850
Wire Wire Line
	8350 5450 8350 5350
Wire Wire Line
	8350 5350 7900 5350
Connection ~ 7900 5350
Wire Wire Line
	8750 5450 8750 5350
Wire Wire Line
	8750 5350 8350 5350
Connection ~ 8350 5350
Wire Wire Line
	9150 5450 9150 5350
Wire Wire Line
	9150 5350 8750 5350
Connection ~ 8750 5350
NoConn ~ 3850 4900
Wire Bus Line
	7900 1700 8100 1700
Wire Bus Line
	2400 1450 2750 1450
Wire Bus Line
	8100 4600 9250 4600
Wire Bus Line
	7000 2350 7000 3350
Wire Bus Line
	5500 2300 5500 4100
Wire Wire Line
	850  6700 850  6800
$EndSCHEMATC
