EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 7 7
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Mini8086:IS61WV25616 U6
U 1 1 5FEBFE9F
P 2700 2500
AR Path="/5FEBFE9F" Ref="U6"  Part="1" 
AR Path="/6026E34B/5FEBFE9F" Ref="U6"  Part="1" 
F 0 "U6" H 2400 1050 50  0000 C CNN
F 1 "IS61WV25616" H 2350 950 50  0000 C CNN
F 2 "Package_SO:TSOP-II-44_10.16x18.41mm_P0.8mm" H 2700 2500 50  0001 C CNN
F 3 "" H 2700 2500 50  0001 C CNN
	1    2700 2500
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 1300 2650 1200
Wire Wire Line
	2650 1200 2750 1200
Wire Wire Line
	2750 1200 2750 1300
Wire Wire Line
	2750 1200 2850 1200
Connection ~ 2750 1200
Wire Wire Line
	2650 3950 2650 4050
Wire Wire Line
	2650 4050 2750 4050
Wire Wire Line
	2750 4050 2750 3950
Wire Wire Line
	2750 4050 2750 4150
Connection ~ 2750 4050
$Comp
L power:GND #PWR0117
U 1 1 5FEC539C
P 2750 4150
F 0 "#PWR0117" H 2750 3900 50  0001 C CNN
F 1 "GND" H 2755 3977 50  0000 C CNN
F 2 "" H 2750 4150 50  0001 C CNN
F 3 "" H 2750 4150 50  0001 C CNN
	1    2750 4150
	1    0    0    -1  
$EndComp
Text GLabel 2850 1200 2    50   Input ~ 0
VCC36
Text GLabel 2050 3450 0    50   Input ~ 0
~RAM0_CE
Text GLabel 1650 3550 0    50   Input ~ 0
~LMEMRD
Text GLabel 2050 3650 0    50   Input ~ 0
~LMEMWR
Wire Wire Line
	2250 3450 2050 3450
Wire Wire Line
	2250 3550 1650 3550
Wire Wire Line
	2250 3650 2050 3650
Text Label 2050 3300 0    50   ~ 0
A18
Text Label 2050 3200 0    50   ~ 0
A17
Text Label 2050 3100 0    50   ~ 0
A16
Text Label 2050 3000 0    50   ~ 0
A15
Text Label 2050 2900 0    50   ~ 0
A14
Text Label 2050 2800 0    50   ~ 0
A13
Text Label 2050 2700 0    50   ~ 0
A12
Text Label 2050 2600 0    50   ~ 0
A11
Text Label 2050 2500 0    50   ~ 0
A10
Text Label 2050 2400 0    50   ~ 0
A9
Text Label 2050 2300 0    50   ~ 0
A8
Text Label 2050 2200 0    50   ~ 0
A7
Text Label 2050 2100 0    50   ~ 0
A6
Text Label 2050 2000 0    50   ~ 0
A5
Text Label 2050 1900 0    50   ~ 0
A4
Text Label 2050 1800 0    50   ~ 0
A3
Text Label 2050 1700 0    50   ~ 0
A2
Text Label 2050 1600 0    50   ~ 0
A1
Entry Wire Line
	2000 3300 1900 3200
Entry Wire Line
	2000 3200 1900 3100
Entry Wire Line
	2000 1600 1900 1500
Entry Wire Line
	2000 1700 1900 1600
Entry Wire Line
	2000 1800 1900 1700
Entry Wire Line
	2000 1900 1900 1800
Entry Wire Line
	2000 2000 1900 1900
Entry Wire Line
	2000 2100 1900 2000
Entry Wire Line
	2000 2200 1900 2100
Entry Wire Line
	2000 2300 1900 2200
Entry Wire Line
	2000 2400 1900 2300
Entry Wire Line
	2000 2500 1900 2400
Entry Wire Line
	2000 2600 1900 2500
Entry Wire Line
	2000 2700 1900 2600
Entry Wire Line
	2000 2800 1900 2700
Entry Wire Line
	2000 2900 1900 2800
Entry Wire Line
	2000 3000 1900 2900
Entry Wire Line
	2000 3100 1900 3000
Wire Wire Line
	2000 3300 2250 3300
Wire Wire Line
	2000 3200 2250 3200
Wire Wire Line
	2000 3100 2250 3100
Wire Wire Line
	2000 3000 2250 3000
Wire Wire Line
	2000 2900 2250 2900
Wire Wire Line
	2000 2800 2250 2800
Wire Wire Line
	2000 2700 2250 2700
Wire Wire Line
	2000 2600 2250 2600
Wire Wire Line
	2000 2500 2250 2500
Wire Wire Line
	2000 2400 2250 2400
Wire Wire Line
	2000 2300 2250 2300
Wire Wire Line
	2000 2200 2250 2200
Wire Wire Line
	2000 2100 2250 2100
Wire Wire Line
	2000 2000 2250 2000
Wire Wire Line
	2000 1900 2250 1900
Wire Wire Line
	2000 1800 2250 1800
Wire Wire Line
	2000 1700 2250 1700
Wire Wire Line
	2000 1600 2250 1600
Wire Bus Line
	1900 1450 1800 1450
Text GLabel 1800 1450 0    50   Input ~ 0
A[0..19]
$Comp
L Mini8086:IS61WV25616 U7
U 1 1 5FF7CD19
P 5650 2500
AR Path="/5FF7CD19" Ref="U7"  Part="1" 
AR Path="/6026E34B/5FF7CD19" Ref="U7"  Part="1" 
F 0 "U7" H 5350 1050 50  0000 C CNN
F 1 "IS61WV25616" H 5300 950 50  0000 C CNN
F 2 "Package_SO:TSOP-II-44_10.16x18.41mm_P0.8mm" H 5650 2500 50  0001 C CNN
F 3 "" H 5650 2500 50  0001 C CNN
	1    5650 2500
	1    0    0    -1  
$EndComp
Wire Wire Line
	5600 1300 5600 1200
Wire Wire Line
	5600 1200 5700 1200
Wire Wire Line
	5700 1200 5700 1300
Wire Wire Line
	5700 1200 5800 1200
Connection ~ 5700 1200
Wire Wire Line
	5600 3950 5600 4050
Wire Wire Line
	5600 4050 5700 4050
Wire Wire Line
	5700 4050 5700 3950
Wire Wire Line
	5700 4050 5700 4150
Connection ~ 5700 4050
$Comp
L power:GND #PWR0118
U 1 1 5FF7CD39
P 5700 4150
F 0 "#PWR0118" H 5700 3900 50  0001 C CNN
F 1 "GND" H 5705 3977 50  0000 C CNN
F 2 "" H 5700 4150 50  0001 C CNN
F 3 "" H 5700 4150 50  0001 C CNN
	1    5700 4150
	1    0    0    -1  
$EndComp
Text GLabel 5800 1200 2    50   Input ~ 0
VCC36
Text GLabel 5000 3450 0    50   Input ~ 0
~RAM1_CE
Text GLabel 4600 3550 0    50   Input ~ 0
~LMEMRD
Text GLabel 5000 3650 0    50   Input ~ 0
~LMEMWR
Wire Wire Line
	5200 3450 5000 3450
Wire Wire Line
	5200 3550 4600 3550
Wire Wire Line
	5200 3650 5000 3650
Text Label 5000 3300 0    50   ~ 0
A18
Text Label 5000 3200 0    50   ~ 0
A17
Text Label 5000 3100 0    50   ~ 0
A16
Text Label 5000 3000 0    50   ~ 0
A15
Text Label 5000 2900 0    50   ~ 0
A14
Text Label 5000 2800 0    50   ~ 0
A13
Text Label 5000 2700 0    50   ~ 0
A12
Text Label 5000 2600 0    50   ~ 0
A11
Text Label 5000 2500 0    50   ~ 0
A10
Text Label 5000 2400 0    50   ~ 0
A9
Text Label 5000 2300 0    50   ~ 0
A8
Text Label 5000 2200 0    50   ~ 0
A7
Text Label 5000 2100 0    50   ~ 0
A6
Text Label 5000 2000 0    50   ~ 0
A5
Text Label 5000 1900 0    50   ~ 0
A4
Text Label 5000 1800 0    50   ~ 0
A3
Text Label 5000 1700 0    50   ~ 0
A2
Text Label 5000 1600 0    50   ~ 0
A1
Entry Wire Line
	4950 3300 4850 3200
Entry Wire Line
	4950 3200 4850 3100
Entry Wire Line
	4950 1600 4850 1500
Entry Wire Line
	4950 1700 4850 1600
Entry Wire Line
	4950 1800 4850 1700
Entry Wire Line
	4950 1900 4850 1800
Entry Wire Line
	4950 2000 4850 1900
Entry Wire Line
	4950 2100 4850 2000
Entry Wire Line
	4950 2200 4850 2100
Entry Wire Line
	4950 2300 4850 2200
Entry Wire Line
	4950 2400 4850 2300
Entry Wire Line
	4950 2500 4850 2400
Entry Wire Line
	4950 2600 4850 2500
Entry Wire Line
	4950 2700 4850 2600
Entry Wire Line
	4950 2800 4850 2700
Entry Wire Line
	4950 2900 4850 2800
Entry Wire Line
	4950 3000 4850 2900
Entry Wire Line
	4950 3100 4850 3000
Wire Wire Line
	4950 3300 5200 3300
Wire Wire Line
	4950 3200 5200 3200
Wire Wire Line
	4950 3100 5200 3100
Wire Wire Line
	4950 3000 5200 3000
Wire Wire Line
	4950 2900 5200 2900
Wire Wire Line
	4950 2800 5200 2800
Wire Wire Line
	4950 2700 5200 2700
Wire Wire Line
	4950 2600 5200 2600
Wire Wire Line
	4950 2500 5200 2500
Wire Wire Line
	4950 2400 5200 2400
Wire Wire Line
	4950 2300 5200 2300
Wire Wire Line
	4950 2200 5200 2200
Wire Wire Line
	4950 2100 5200 2100
Wire Wire Line
	4950 2000 5200 2000
Wire Wire Line
	4950 1900 5200 1900
Wire Wire Line
	4950 1800 5200 1800
Wire Wire Line
	4950 1700 5200 1700
Wire Wire Line
	4950 1600 5200 1600
Wire Bus Line
	4850 1450 4750 1450
Text GLabel 4750 1450 0    50   Input ~ 0
A[0..19]
NoConn ~ 6100 3650
NoConn ~ 3150 3650
Wire Wire Line
	3150 3550 3400 3550
Wire Wire Line
	6100 3550 6350 3550
Entry Wire Line
	3400 3550 3500 3450
Text GLabel 6250 3300 2    50   Input ~ 0
~BHE
Text GLabel 3300 3300 2    50   Input ~ 0
~BHE
Entry Wire Line
	6350 3550 6450 3450
Wire Bus Line
	6450 3450 6550 3450
Wire Bus Line
	3500 3450 3600 3450
Text GLabel 3600 3450 2    50   Input ~ 0
A[0..19]
Text GLabel 6550 3450 2    50   Input ~ 0
A[0..19]
Text Label 6200 3550 0    50   ~ 0
A0
Text Label 3250 3550 0    50   ~ 0
A0
Wire Wire Line
	6100 3450 6150 3450
Wire Wire Line
	6150 3450 6150 3300
Wire Wire Line
	6150 3300 6250 3300
Wire Wire Line
	3150 3450 3200 3450
Wire Wire Line
	3200 3450 3200 3300
Wire Wire Line
	3200 3300 3300 3300
Text Label 6350 3100 2    50   ~ 0
LD15
Text Label 6350 3000 2    50   ~ 0
LD14
Text Label 6350 2900 2    50   ~ 0
LD13
Text Label 6350 2800 2    50   ~ 0
LD12
Text Label 6350 2700 2    50   ~ 0
LD11
Text Label 6350 2600 2    50   ~ 0
LD10
Text Label 6300 2500 2    50   ~ 0
LD9
Text Label 6300 2400 2    50   ~ 0
LD8
Text Label 6300 2300 2    50   ~ 0
LD7
Text Label 6300 2200 2    50   ~ 0
LD6
Text Label 6300 2100 2    50   ~ 0
LD5
Text Label 6300 2000 2    50   ~ 0
LD4
Text Label 6300 1900 2    50   ~ 0
LD3
Text Label 6300 1800 2    50   ~ 0
LD2
Text Label 6300 1700 2    50   ~ 0
LD1
Text Label 6300 1600 2    50   ~ 0
LD0
Text GLabel 6600 1450 2    50   BiDi ~ 0
LD[0..15]
Wire Bus Line
	6500 1450 6600 1450
Entry Wire Line
	6400 3100 6500 3000
Entry Wire Line
	6400 3000 6500 2900
Entry Wire Line
	6400 2900 6500 2800
Entry Wire Line
	6400 2800 6500 2700
Entry Wire Line
	6400 2700 6500 2600
Entry Wire Line
	6400 2600 6500 2500
Entry Wire Line
	6400 2500 6500 2400
Entry Wire Line
	6400 2400 6500 2300
Entry Wire Line
	6400 2300 6500 2200
Entry Wire Line
	6400 2200 6500 2100
Entry Wire Line
	6400 2100 6500 2000
Entry Wire Line
	6400 2000 6500 1900
Entry Wire Line
	6400 1900 6500 1800
Entry Wire Line
	6400 1800 6500 1700
Entry Wire Line
	6400 1700 6500 1600
Entry Wire Line
	6400 1600 6500 1500
Wire Wire Line
	6400 1600 6100 1600
Wire Wire Line
	6400 1700 6100 1700
Wire Wire Line
	6400 1800 6100 1800
Wire Wire Line
	6400 1900 6100 1900
Wire Wire Line
	6400 2000 6100 2000
Wire Wire Line
	6400 2100 6100 2100
Wire Wire Line
	6400 2200 6100 2200
Wire Wire Line
	6400 2300 6100 2300
Wire Wire Line
	6400 2400 6100 2400
Wire Wire Line
	6400 2500 6100 2500
Wire Wire Line
	6400 2600 6100 2600
Wire Wire Line
	6400 2700 6100 2700
Wire Wire Line
	6400 2800 6100 2800
Wire Wire Line
	6400 2900 6100 2900
Wire Wire Line
	6400 3000 6100 3000
Wire Wire Line
	6400 3100 6100 3100
Text Label 3400 3100 2    50   ~ 0
LD15
Text Label 3400 3000 2    50   ~ 0
LD14
Text Label 3400 2900 2    50   ~ 0
LD13
Text Label 3400 2800 2    50   ~ 0
LD12
Text Label 3400 2700 2    50   ~ 0
LD11
Text Label 3400 2600 2    50   ~ 0
LD10
Text Label 3350 2500 2    50   ~ 0
LD9
Text Label 3350 2400 2    50   ~ 0
LD8
Text Label 3350 2300 2    50   ~ 0
LD7
Text Label 3350 2200 2    50   ~ 0
LD6
Text Label 3350 2100 2    50   ~ 0
LD5
Text Label 3350 2000 2    50   ~ 0
LD4
Text Label 3350 1900 2    50   ~ 0
LD3
Text Label 3350 1800 2    50   ~ 0
LD2
Text Label 3350 1700 2    50   ~ 0
LD1
Text Label 3350 1600 2    50   ~ 0
LD0
Text GLabel 3650 1450 2    50   BiDi ~ 0
LD[0..15]
Wire Bus Line
	3550 1450 3650 1450
Entry Wire Line
	3450 3100 3550 3000
Entry Wire Line
	3450 3000 3550 2900
Entry Wire Line
	3450 2900 3550 2800
Entry Wire Line
	3450 2800 3550 2700
Entry Wire Line
	3450 2700 3550 2600
Entry Wire Line
	3450 2600 3550 2500
Entry Wire Line
	3450 2500 3550 2400
Entry Wire Line
	3450 2400 3550 2300
Entry Wire Line
	3450 2300 3550 2200
Entry Wire Line
	3450 2200 3550 2100
Entry Wire Line
	3450 2100 3550 2000
Entry Wire Line
	3450 2000 3550 1900
Entry Wire Line
	3450 1900 3550 1800
Entry Wire Line
	3450 1800 3550 1700
Entry Wire Line
	3450 1700 3550 1600
Entry Wire Line
	3450 1600 3550 1500
Wire Wire Line
	3450 1600 3150 1600
Wire Wire Line
	3450 1700 3150 1700
Wire Wire Line
	3450 1800 3150 1800
Wire Wire Line
	3450 1900 3150 1900
Wire Wire Line
	3450 2000 3150 2000
Wire Wire Line
	3450 2100 3150 2100
Wire Wire Line
	3450 2200 3150 2200
Wire Wire Line
	3450 2300 3150 2300
Wire Wire Line
	3450 2400 3150 2400
Wire Wire Line
	3450 2500 3150 2500
Wire Wire Line
	3450 2600 3150 2600
Wire Wire Line
	3450 2700 3150 2700
Wire Wire Line
	3450 2800 3150 2800
Wire Wire Line
	3450 2900 3150 2900
Wire Wire Line
	3450 3000 3150 3000
Wire Wire Line
	3450 3100 3150 3100
Wire Bus Line
	6500 1450 6500 3000
Wire Bus Line
	4850 1450 4850 3200
Wire Bus Line
	1900 1450 1900 3200
Wire Bus Line
	3550 1450 3550 3000
$EndSCHEMATC
