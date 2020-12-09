EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 8 8
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
L power:GND #PWR0108
U 1 1 5FAD835F
P 4500 4200
F 0 "#PWR0108" H 4500 3950 50  0001 C CNN
F 1 "GND" H 4505 4027 50  0000 C CNN
F 2 "" H 4500 4200 50  0001 C CNN
F 3 "" H 4500 4200 50  0001 C CNN
	1    4500 4200
	1    0    0    -1  
$EndComp
Wire Wire Line
	1800 2250 2000 2250
Wire Wire Line
	1800 2350 2000 2350
Wire Wire Line
	1800 2450 2000 2450
Wire Wire Line
	1800 2550 2000 2550
Wire Wire Line
	1800 2650 2000 2650
Wire Wire Line
	1800 2750 2000 2750
Wire Wire Line
	1800 2850 2000 2850
Wire Wire Line
	1800 2950 2000 2950
Wire Wire Line
	3950 3150 3750 3150
Wire Wire Line
	3750 3250 3950 3250
Entry Wire Line
	1800 2250 1700 2150
Entry Wire Line
	1800 2350 1700 2250
Entry Wire Line
	1800 2450 1700 2350
Entry Wire Line
	1800 2550 1700 2450
Entry Wire Line
	1800 2650 1700 2550
Entry Wire Line
	1800 2750 1700 2650
Entry Wire Line
	1800 2850 1700 2750
Entry Wire Line
	1800 2950 1700 2850
Entry Wire Line
	3750 3150 3650 3250
Entry Wire Line
	3750 3250 3650 3350
Wire Bus Line
	1700 2100 1600 2100
Text GLabel 1600 2100 0    50   Input ~ 0
D[0..7]
Text GLabel 3500 3400 0    50   Input ~ 0
A[0..19]
Text Label 1850 2250 0    50   ~ 0
D0
Text Label 1850 2350 0    50   ~ 0
D1
Text Label 1850 2450 0    50   ~ 0
D2
Text Label 1850 2550 0    50   ~ 0
D3
Text Label 1850 2650 0    50   ~ 0
D4
Text Label 1850 2750 0    50   ~ 0
D5
Text Label 1850 2850 0    50   ~ 0
D6
Text Label 1850 2950 0    50   ~ 0
D7
Text Label 3800 3150 0    50   ~ 0
A0
Text Label 3800 3250 0    50   ~ 0
A1
Wire Wire Line
	3850 3450 3950 3450
Wire Wire Line
	3650 3550 3950 3550
Text GLabel 3850 3450 0    50   Input ~ 0
~RD
Text GLabel 3650 3550 0    50   Input ~ 0
~WR
Wire Wire Line
	3950 3750 3850 3750
Text GLabel 3850 3750 0    50   Input ~ 0
~RESET
Wire Wire Line
	3950 3950 3850 3950
Text GLabel 3850 3950 0    50   Input ~ 0
~CS_I2C
Wire Wire Line
	3950 3850 3500 3850
Text GLabel 3500 3850 0    50   Output ~ 0
~INT_I2C
$Comp
L Connector_Generic:Conn_01x04 J5
U 1 1 5FAE4542
P 7350 2950
F 0 "J5" H 7430 2942 50  0000 L CNN
F 1 "DS1307" H 7430 2851 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 7350 2950 50  0001 C CNN
F 3 "~" H 7350 2950 50  0001 C CNN
	1    7350 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	5000 2400 5500 2400
Wire Wire Line
	5000 2500 5200 2500
$Comp
L Connector_Generic:Conn_01x04 J6
U 1 1 5FAE8586
P 7350 4100
F 0 "J6" H 7430 4092 50  0000 L CNN
F 1 "BME280" H 7430 4001 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 7350 4100 50  0001 C CNN
F 3 "~" H 7350 4100 50  0001 C CNN
	1    7350 4100
	1    0    0    -1  
$EndComp
Connection ~ 5500 2400
Wire Wire Line
	5500 2400 5650 2400
$Comp
L Device:R R10
U 1 1 5FAF7F1D
P 5200 2100
F 0 "R10" H 5270 2146 50  0000 L CNN
F 1 "1K8" H 5270 2055 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 5130 2100 50  0001 C CNN
F 3 "~" H 5200 2100 50  0001 C CNN
	1    5200 2100
	1    0    0    -1  
$EndComp
$Comp
L Device:R R11
U 1 1 5FAF84E2
P 5500 2100
F 0 "R11" H 5570 2146 50  0000 L CNN
F 1 "1K8" H 5570 2055 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 5430 2100 50  0001 C CNN
F 3 "~" H 5500 2100 50  0001 C CNN
	1    5500 2100
	1    0    0    -1  
$EndComp
Wire Wire Line
	5500 2400 5500 2250
Wire Wire Line
	5200 2250 5200 2500
Connection ~ 5200 2500
Wire Wire Line
	5200 1950 5200 1850
Wire Wire Line
	5200 1850 5500 1850
Wire Wire Line
	5500 1950 5500 1850
$Comp
L Memory_EEPROM:M24C02-WMN U18
U 1 1 5FAFF485
P 7200 1950
F 0 "U18" H 7000 1700 50  0000 C CNN
F 1 "24C04" H 7400 1700 50  0000 C CNN
F 2 "Package_SO:SOIC-8_3.9x4.9mm_P1.27mm" H 7200 2300 50  0001 C CNN
F 3 "http://www.st.com/content/ccc/resource/technical/document/datasheet/b0/d8/50/40/5a/85/49/6f/DM00071904.pdf/files/DM00071904.pdf/jcr:content/translations/en.DM00071904.pdf" H 7250 1450 50  0001 C CNN
	1    7200 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	7150 4100 7050 4100
Wire Wire Line
	7050 4100 7050 4400
Wire Wire Line
	7050 4000 7150 4000
$Comp
L power:GND #PWR0109
U 1 1 5FB9B1AE
P 7050 4400
F 0 "#PWR0109" H 7050 4150 50  0001 C CNN
F 1 "GND" H 7055 4227 50  0000 C CNN
F 2 "" H 7050 4400 50  0001 C CNN
F 3 "" H 7050 4400 50  0001 C CNN
	1    7050 4400
	1    0    0    -1  
$EndComp
Text GLabel 7150 3800 2    50   Input ~ 0
VCC3
Wire Wire Line
	7150 3800 7050 3800
Wire Wire Line
	7050 3800 7050 4000
Wire Wire Line
	7150 4200 6950 4200
Wire Wire Line
	7150 4300 6950 4300
Text GLabel 6950 4300 0    50   Input ~ 0
SDA
Text GLabel 6950 4200 0    50   Input ~ 0
SCL
$Comp
L power:GND #PWR0110
U 1 1 5FB9D832
P 7200 2250
F 0 "#PWR0110" H 7200 2000 50  0001 C CNN
F 1 "GND" H 7205 2077 50  0000 C CNN
F 2 "" H 7200 2250 50  0001 C CNN
F 3 "" H 7200 2250 50  0001 C CNN
	1    7200 2250
	1    0    0    -1  
$EndComp
Text GLabel 7300 1550 2    50   Input ~ 0
VCC3
Wire Wire Line
	7300 1550 7200 1550
Wire Wire Line
	7200 1550 7200 1650
Text GLabel 6950 2850 0    50   Input ~ 0
SCL
Text GLabel 6950 2950 0    50   Input ~ 0
SDA
Wire Wire Line
	7150 3150 7050 3150
Wire Wire Line
	7050 3150 7050 3250
Wire Wire Line
	7150 3050 7050 3050
Wire Wire Line
	7050 3050 7050 2700
Text GLabel 7150 2700 2    50   Input ~ 0
VCC3
Wire Wire Line
	7050 2700 7150 2700
$Comp
L power:GND #PWR0111
U 1 1 5FBA17EC
P 7050 3250
F 0 "#PWR0111" H 7050 3000 50  0001 C CNN
F 1 "GND" H 7055 3077 50  0000 C CNN
F 2 "" H 7050 3250 50  0001 C CNN
F 3 "" H 7050 3250 50  0001 C CNN
	1    7050 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	7150 2850 6950 2850
Wire Wire Line
	6950 2950 7150 2950
Wire Wire Line
	5200 2500 5650 2500
Text GLabel 5650 2400 2    50   Input ~ 0
SCL
Text GLabel 5650 2500 2    50   Input ~ 0
SDA
Text GLabel 7600 1950 2    50   Input ~ 0
SCL
Text GLabel 7600 1850 2    50   Input ~ 0
SDA
Wire Wire Line
	7600 2050 7800 2050
$Comp
L power:GND #PWR0112
U 1 1 5FBAB9A0
P 7800 2250
F 0 "#PWR0112" H 7800 2000 50  0001 C CNN
F 1 "GND" H 7805 2077 50  0000 C CNN
F 2 "" H 7800 2250 50  0001 C CNN
F 3 "" H 7800 2250 50  0001 C CNN
	1    7800 2250
	1    0    0    -1  
$EndComp
Wire Wire Line
	7800 2250 7800 2050
Wire Wire Line
	6800 1850 6650 1850
Wire Wire Line
	6650 1850 6650 1950
Wire Wire Line
	6800 2050 6650 2050
Connection ~ 6650 2050
Wire Wire Line
	6650 2050 6650 2250
Wire Wire Line
	6800 1950 6650 1950
Connection ~ 6650 1950
Wire Wire Line
	6650 1950 6650 2050
$Comp
L power:GND #PWR045
U 1 1 5FBBE950
P 6650 2250
F 0 "#PWR045" H 6650 2000 50  0001 C CNN
F 1 "GND" H 6655 2077 50  0000 C CNN
F 2 "" H 6650 2250 50  0001 C CNN
F 3 "" H 6650 2250 50  0001 C CNN
	1    6650 2250
	1    0    0    -1  
$EndComp
$Comp
L Logic_LevelTranslator:SN74AVC8T245PW U19
U 1 1 5FC3AC90
P 2500 2450
F 0 "U19" H 2500 2400 50  0000 C CNN
F 1 "SN74AVC8T245PW" H 2900 1750 50  0000 C CNN
F 2 "Package_SO:TSSOP-24_4.4x7.8mm_P0.65mm" H 3400 1800 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74avc8t245.pdf" H 2450 2200 50  0001 C CNN
	1    2500 2450
	1    0    0    -1  
$EndComp
Wire Wire Line
	3000 2250 3950 2250
Wire Wire Line
	3950 2350 3000 2350
Wire Wire Line
	3000 2450 3950 2450
Wire Wire Line
	3950 2550 3000 2550
Wire Wire Line
	3000 2650 3950 2650
Wire Wire Line
	3950 2750 3000 2750
Wire Wire Line
	3000 2850 3950 2850
Wire Wire Line
	3950 2950 3000 2950
$Comp
L power:GND #PWR044
U 1 1 5FC457BD
P 2500 3150
F 0 "#PWR044" H 2500 2900 50  0001 C CNN
F 1 "GND" H 2505 2977 50  0000 C CNN
F 2 "" H 2500 3150 50  0001 C CNN
F 3 "" H 2500 3150 50  0001 C CNN
	1    2500 3150
	1    0    0    -1  
$EndComp
Text GLabel 2750 1750 2    50   Input ~ 0
VCC3
$Comp
L power:VCC #PWR043
U 1 1 5FC45AEF
P 2400 1850
F 0 "#PWR043" H 2400 1700 50  0001 C CNN
F 1 "VCC" H 2415 2023 50  0000 C CNN
F 2 "" H 2400 1850 50  0001 C CNN
F 3 "" H 2400 1850 50  0001 C CNN
	1    2400 1850
	1    0    0    -1  
$EndComp
Wire Wire Line
	2500 1850 2500 1750
Wire Wire Line
	2500 1750 2600 1750
Wire Wire Line
	2600 1850 2600 1750
Connection ~ 2600 1750
Wire Wire Line
	2600 1750 2750 1750
Text GLabel 3100 2050 2    50   Input ~ 0
~CS_I2C
Wire Wire Line
	3100 2050 3000 2050
Text GLabel 1900 2050 0    50   Input ~ 0
~RD
Wire Wire Line
	2000 2050 1900 2050
Text GLabel 5650 1850 2    50   Input ~ 0
VCC3
Wire Wire Line
	5650 1850 5500 1850
Connection ~ 5500 1850
Wire Wire Line
	5200 1850 4500 1850
Wire Wire Line
	4500 1850 4500 2000
Connection ~ 5200 1850
Wire Bus Line
	3650 3400 3500 3400
$Comp
L Mini8086:PCA9564D U17
U 1 1 5FC92A75
P 4500 2950
F 0 "U17" H 4500 3050 50  0000 C CNN
F 1 "PCA9564D" H 4500 2950 50  0000 C CNN
F 2 "Package_SO:SOIC-20W_7.5x12.8mm_P1.27mm" H 4500 2950 50  0001 C CNN
F 3 "" H 4500 2950 50  0001 C CNN
	1    4500 2950
	1    0    0    -1  
$EndComp
Wire Bus Line
	3650 3250 3650 3400
Wire Bus Line
	1700 2100 1700 2850
$EndSCHEMATC
