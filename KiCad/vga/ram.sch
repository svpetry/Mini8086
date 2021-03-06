EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 3 7
Title "Mini8086 VGA board"
Date ""
Rev "1.1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Memory_RAM:CY62256-70PC U2
U 1 1 5F685141
P 2400 2550
F 0 "U2" H 2100 1650 50  0000 C CNN
F 1 "61256-15" H 2800 1650 50  0000 C CNN
F 2 "Package_DIP:DIP-28_W7.62mm_Socket_LongPads" H 2400 2450 50  0001 C CNN
F 3 "https://ecee.colorado.edu/~mcclurel/Cypress_SRAM_CY62256.pdf" H 2400 2450 50  0001 C CNN
	1    2400 2550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR020
U 1 1 5F68844C
P 2400 3450
F 0 "#PWR020" H 2400 3200 50  0001 C CNN
F 1 "GND" H 2405 3277 50  0000 C CNN
F 2 "" H 2400 3450 50  0001 C CNN
F 3 "" H 2400 3450 50  0001 C CNN
	1    2400 3450
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR019
U 1 1 5F68890E
P 2400 1650
F 0 "#PWR019" H 2400 1500 50  0001 C CNN
F 1 "VCC" H 2415 1823 50  0000 C CNN
F 2 "" H 2400 1650 50  0001 C CNN
F 3 "" H 2400 1650 50  0001 C CNN
	1    2400 1650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR023
U 1 1 5F68A4E2
P 2900 2950
F 0 "#PWR023" H 2900 2700 50  0001 C CNN
F 1 "GND" V 2905 2822 50  0000 R CNN
F 2 "" H 2900 2950 50  0001 C CNN
F 3 "" H 2900 2950 50  0001 C CNN
	1    2900 2950
	0    -1   -1   0   
$EndComp
Text GLabel 3150 2750 2    50   Input ~ 0
~CS_R0
Text GLabel 3150 3050 2    50   Input ~ 0
~WE_R0
Wire Wire Line
	3150 2750 2900 2750
Wire Wire Line
	2900 3050 3150 3050
Entry Wire Line
	1550 3150 1650 3250
Entry Wire Line
	1550 3050 1650 3150
Entry Wire Line
	1550 2950 1650 3050
Entry Wire Line
	1550 2850 1650 2950
Entry Wire Line
	1550 2750 1650 2850
Entry Wire Line
	1550 2650 1650 2750
Entry Wire Line
	1550 2550 1650 2650
Entry Wire Line
	1550 2450 1650 2550
Entry Wire Line
	1550 2350 1650 2450
Entry Wire Line
	1550 2250 1650 2350
Entry Wire Line
	1550 2150 1650 2250
Entry Wire Line
	1550 2050 1650 2150
Entry Wire Line
	1550 1950 1650 2050
Entry Wire Line
	1550 1850 1650 1950
Entry Wire Line
	1550 1750 1650 1850
Text Label 1850 1850 2    50   ~ 0
RA0
Text Label 1850 1950 2    50   ~ 0
RA1
Text Label 1850 2050 2    50   ~ 0
RA2
Text Label 1850 2150 2    50   ~ 0
RA3
Text Label 1850 2250 2    50   ~ 0
RA4
Text Label 1850 2350 2    50   ~ 0
RA5
Text Label 1850 2450 2    50   ~ 0
RA6
Text Label 1850 2550 2    50   ~ 0
RA7
Text Label 1850 2650 2    50   ~ 0
RA8
Text Label 1850 2750 2    50   ~ 0
RA9
Text Label 1900 2850 2    50   ~ 0
RA10
Text Label 1900 2950 2    50   ~ 0
RA11
Text Label 1900 3050 2    50   ~ 0
RA12
Text Label 1900 3150 2    50   ~ 0
RA13
Text Label 1900 3250 2    50   ~ 0
RA14
Wire Wire Line
	1650 1850 1900 1850
Wire Wire Line
	1650 1950 1900 1950
Wire Wire Line
	1650 2050 1900 2050
Wire Wire Line
	1650 2150 1900 2150
Wire Wire Line
	1650 2250 1900 2250
Wire Wire Line
	1650 2350 1900 2350
Wire Wire Line
	1650 2450 1900 2450
Wire Wire Line
	1650 2550 1900 2550
Wire Wire Line
	1650 2650 1900 2650
Wire Wire Line
	1650 2750 1900 2750
Wire Wire Line
	1650 2850 1900 2850
Wire Wire Line
	1650 2950 1900 2950
Wire Wire Line
	1650 3050 1900 3050
Wire Wire Line
	1650 3150 1900 3150
Wire Wire Line
	1650 3250 1900 3250
Wire Wire Line
	2900 1850 3150 1850
Wire Wire Line
	2900 1950 3150 1950
Wire Wire Line
	2900 2050 3150 2050
Wire Wire Line
	2900 2150 3150 2150
Wire Wire Line
	2900 2250 3150 2250
Wire Wire Line
	2900 2350 3150 2350
Wire Wire Line
	2900 2450 3150 2450
Wire Wire Line
	2900 2550 3150 2550
Entry Wire Line
	3250 1750 3150 1850
Entry Wire Line
	3250 1850 3150 1950
Entry Wire Line
	3250 2050 3150 2150
Entry Wire Line
	3250 1950 3150 2050
Entry Wire Line
	3250 2150 3150 2250
Entry Wire Line
	3250 2250 3150 2350
Entry Wire Line
	3250 2350 3150 2450
Entry Wire Line
	3250 2450 3150 2550
Wire Bus Line
	3250 1650 3300 1650
Text Label 3150 1850 2    50   ~ 0
R0D0
Text Label 3150 1950 2    50   ~ 0
R0D1
Text Label 3150 2050 2    50   ~ 0
R0D2
Text Label 3150 2150 2    50   ~ 0
R0D3
Text Label 3150 2250 2    50   ~ 0
R0D4
Text Label 3150 2350 2    50   ~ 0
R0D5
Text Label 3150 2450 2    50   ~ 0
R0D6
Text Label 3150 2550 2    50   ~ 0
R0D7
$Comp
L Memory_RAM:CY62256-70PC U3
U 1 1 5F6A5CD5
P 2400 5100
F 0 "U3" H 2100 4200 50  0000 C CNN
F 1 "61256-15" H 2800 4200 50  0000 C CNN
F 2 "Package_DIP:DIP-28_W7.62mm_Socket_LongPads" H 2400 5000 50  0001 C CNN
F 3 "https://ecee.colorado.edu/~mcclurel/Cypress_SRAM_CY62256.pdf" H 2400 5000 50  0001 C CNN
	1    2400 5100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR022
U 1 1 5F6A5CDF
P 2400 6000
F 0 "#PWR022" H 2400 5750 50  0001 C CNN
F 1 "GND" H 2405 5827 50  0000 C CNN
F 2 "" H 2400 6000 50  0001 C CNN
F 3 "" H 2400 6000 50  0001 C CNN
	1    2400 6000
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR021
U 1 1 5F6A5CE9
P 2400 4200
F 0 "#PWR021" H 2400 4050 50  0001 C CNN
F 1 "VCC" H 2415 4373 50  0000 C CNN
F 2 "" H 2400 4200 50  0001 C CNN
F 3 "" H 2400 4200 50  0001 C CNN
	1    2400 4200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR024
U 1 1 5F6A5CF3
P 2900 5500
F 0 "#PWR024" H 2900 5250 50  0001 C CNN
F 1 "GND" V 2905 5372 50  0000 R CNN
F 2 "" H 2900 5500 50  0001 C CNN
F 3 "" H 2900 5500 50  0001 C CNN
	1    2900 5500
	0    -1   -1   0   
$EndComp
Text GLabel 3150 5300 2    50   Input ~ 0
~CS_R2
Text GLabel 3150 5600 2    50   Input ~ 0
~WE_R2
Wire Wire Line
	3150 5300 2900 5300
Wire Wire Line
	2900 5600 3150 5600
Entry Wire Line
	1550 5700 1650 5800
Entry Wire Line
	1550 5600 1650 5700
Entry Wire Line
	1550 5500 1650 5600
Entry Wire Line
	1550 5400 1650 5500
Entry Wire Line
	1550 5300 1650 5400
Entry Wire Line
	1550 5200 1650 5300
Entry Wire Line
	1550 5100 1650 5200
Entry Wire Line
	1550 5000 1650 5100
Entry Wire Line
	1550 4900 1650 5000
Entry Wire Line
	1550 4800 1650 4900
Entry Wire Line
	1550 4700 1650 4800
Entry Wire Line
	1550 4600 1650 4700
Entry Wire Line
	1550 4500 1650 4600
Entry Wire Line
	1550 4400 1650 4500
Entry Wire Line
	1550 4300 1650 4400
Text Label 1850 4400 2    50   ~ 0
RA0
Text Label 1850 4500 2    50   ~ 0
RA1
Text Label 1850 4600 2    50   ~ 0
RA2
Text Label 1850 4700 2    50   ~ 0
RA3
Text Label 1850 4800 2    50   ~ 0
RA4
Text Label 1850 4900 2    50   ~ 0
RA5
Text Label 1850 5000 2    50   ~ 0
RA6
Text Label 1850 5100 2    50   ~ 0
RA7
Text Label 1850 5200 2    50   ~ 0
RA8
Text Label 1850 5300 2    50   ~ 0
RA9
Text Label 1900 5400 2    50   ~ 0
RA10
Text Label 1900 5500 2    50   ~ 0
RA11
Text Label 1900 5600 2    50   ~ 0
RA12
Text Label 1900 5700 2    50   ~ 0
RA13
Text Label 1900 5800 2    50   ~ 0
RA14
Wire Wire Line
	1650 4400 1900 4400
Wire Wire Line
	1650 4500 1900 4500
Wire Wire Line
	1650 4600 1900 4600
Wire Wire Line
	1650 4700 1900 4700
Wire Wire Line
	1650 4800 1900 4800
Wire Wire Line
	1650 4900 1900 4900
Wire Wire Line
	1650 5000 1900 5000
Wire Wire Line
	1650 5100 1900 5100
Wire Wire Line
	1650 5200 1900 5200
Wire Wire Line
	1650 5300 1900 5300
Wire Wire Line
	1650 5400 1900 5400
Wire Wire Line
	1650 5500 1900 5500
Wire Wire Line
	1650 5600 1900 5600
Wire Wire Line
	1650 5700 1900 5700
Wire Wire Line
	1650 5800 1900 5800
Wire Wire Line
	2900 4400 3150 4400
Wire Wire Line
	2900 4500 3150 4500
Wire Wire Line
	2900 4600 3150 4600
Wire Wire Line
	2900 4700 3150 4700
Wire Wire Line
	2900 4800 3150 4800
Wire Wire Line
	2900 4900 3150 4900
Wire Wire Line
	2900 5000 3150 5000
Wire Wire Line
	2900 5100 3150 5100
Entry Wire Line
	3250 4300 3150 4400
Entry Wire Line
	3250 4400 3150 4500
Entry Wire Line
	3250 4600 3150 4700
Entry Wire Line
	3250 4500 3150 4600
Entry Wire Line
	3250 4700 3150 4800
Entry Wire Line
	3250 4800 3150 4900
Entry Wire Line
	3250 4900 3150 5000
Entry Wire Line
	3250 5000 3150 5100
Wire Bus Line
	3250 4200 3300 4200
Text Label 3150 4400 2    50   ~ 0
R2D0
Text Label 3150 4500 2    50   ~ 0
R2D1
Text Label 3150 4600 2    50   ~ 0
R2D2
Text Label 3150 4700 2    50   ~ 0
R2D3
Text Label 3150 4800 2    50   ~ 0
R2D4
Text Label 3150 4900 2    50   ~ 0
R2D5
Text Label 3150 5000 2    50   ~ 0
R2D6
Text Label 3150 5100 2    50   ~ 0
R2D7
$Comp
L Memory_RAM:CY62256-70PC U4
U 1 1 5F6B3FAA
P 5350 2550
F 0 "U4" H 5050 1650 50  0000 C CNN
F 1 "61256-15" H 5750 1650 50  0000 C CNN
F 2 "Package_DIP:DIP-28_W7.62mm_Socket_LongPads" H 5350 2450 50  0001 C CNN
F 3 "https://ecee.colorado.edu/~mcclurel/Cypress_SRAM_CY62256.pdf" H 5350 2450 50  0001 C CNN
	1    5350 2550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR026
U 1 1 5F6B3FB4
P 5350 3450
F 0 "#PWR026" H 5350 3200 50  0001 C CNN
F 1 "GND" H 5355 3277 50  0000 C CNN
F 2 "" H 5350 3450 50  0001 C CNN
F 3 "" H 5350 3450 50  0001 C CNN
	1    5350 3450
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR025
U 1 1 5F6B3FBE
P 5350 1650
F 0 "#PWR025" H 5350 1500 50  0001 C CNN
F 1 "VCC" H 5365 1823 50  0000 C CNN
F 2 "" H 5350 1650 50  0001 C CNN
F 3 "" H 5350 1650 50  0001 C CNN
	1    5350 1650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR029
U 1 1 5F6B3FC8
P 5850 2950
F 0 "#PWR029" H 5850 2700 50  0001 C CNN
F 1 "GND" V 5855 2822 50  0000 R CNN
F 2 "" H 5850 2950 50  0001 C CNN
F 3 "" H 5850 2950 50  0001 C CNN
	1    5850 2950
	0    -1   -1   0   
$EndComp
Text GLabel 6100 2750 2    50   Input ~ 0
~CS_R1
Text GLabel 6100 3050 2    50   Input ~ 0
~WE_R1
Wire Wire Line
	6100 2750 5850 2750
Wire Wire Line
	5850 3050 6100 3050
Entry Wire Line
	4500 3150 4600 3250
Entry Wire Line
	4500 3050 4600 3150
Entry Wire Line
	4500 2950 4600 3050
Entry Wire Line
	4500 2850 4600 2950
Entry Wire Line
	4500 2750 4600 2850
Entry Wire Line
	4500 2650 4600 2750
Entry Wire Line
	4500 2550 4600 2650
Entry Wire Line
	4500 2450 4600 2550
Entry Wire Line
	4500 2350 4600 2450
Entry Wire Line
	4500 2250 4600 2350
Entry Wire Line
	4500 2150 4600 2250
Entry Wire Line
	4500 2050 4600 2150
Entry Wire Line
	4500 1950 4600 2050
Entry Wire Line
	4500 1850 4600 1950
Entry Wire Line
	4500 1750 4600 1850
Text Label 4800 1850 2    50   ~ 0
RA0
Text Label 4800 1950 2    50   ~ 0
RA1
Text Label 4800 2050 2    50   ~ 0
RA2
Text Label 4800 2150 2    50   ~ 0
RA3
Text Label 4800 2250 2    50   ~ 0
RA4
Text Label 4800 2350 2    50   ~ 0
RA5
Text Label 4800 2450 2    50   ~ 0
RA6
Text Label 4800 2550 2    50   ~ 0
RA7
Text Label 4800 2650 2    50   ~ 0
RA8
Text Label 4800 2750 2    50   ~ 0
RA9
Text Label 4850 2850 2    50   ~ 0
RA10
Text Label 4850 2950 2    50   ~ 0
RA11
Text Label 4850 3050 2    50   ~ 0
RA12
Text Label 4850 3150 2    50   ~ 0
RA13
Text Label 4850 3250 2    50   ~ 0
RA14
Wire Wire Line
	4600 1850 4850 1850
Wire Wire Line
	4600 1950 4850 1950
Wire Wire Line
	4600 2050 4850 2050
Wire Wire Line
	4600 2150 4850 2150
Wire Wire Line
	4600 2250 4850 2250
Wire Wire Line
	4600 2350 4850 2350
Wire Wire Line
	4600 2450 4850 2450
Wire Wire Line
	4600 2550 4850 2550
Wire Wire Line
	4600 2650 4850 2650
Wire Wire Line
	4600 2750 4850 2750
Wire Wire Line
	4600 2850 4850 2850
Wire Wire Line
	4600 2950 4850 2950
Wire Wire Line
	4600 3050 4850 3050
Wire Wire Line
	4600 3150 4850 3150
Wire Wire Line
	4600 3250 4850 3250
Wire Wire Line
	5850 1850 6100 1850
Wire Wire Line
	5850 1950 6100 1950
Wire Wire Line
	5850 2050 6100 2050
Wire Wire Line
	5850 2150 6100 2150
Wire Wire Line
	5850 2250 6100 2250
Wire Wire Line
	5850 2350 6100 2350
Wire Wire Line
	5850 2450 6100 2450
Wire Wire Line
	5850 2550 6100 2550
Entry Wire Line
	6200 1750 6100 1850
Entry Wire Line
	6200 1850 6100 1950
Entry Wire Line
	6200 2050 6100 2150
Entry Wire Line
	6200 1950 6100 2050
Entry Wire Line
	6200 2150 6100 2250
Entry Wire Line
	6200 2250 6100 2350
Entry Wire Line
	6200 2350 6100 2450
Entry Wire Line
	6200 2450 6100 2550
Wire Bus Line
	6200 1650 6250 1650
Text Label 6100 1850 2    50   ~ 0
R1D0
Text Label 6100 1950 2    50   ~ 0
R1D1
Text Label 6100 2050 2    50   ~ 0
R1D2
Text Label 6100 2350 2    50   ~ 0
R1D5
Text Label 6100 2450 2    50   ~ 0
R1D6
Text Label 6100 2550 2    50   ~ 0
R1D7
$Comp
L Memory_RAM:CY62256-70PC U5
U 1 1 5F6B401F
P 5350 5100
F 0 "U5" H 5050 4200 50  0000 C CNN
F 1 "61256-15" H 5750 4200 50  0000 C CNN
F 2 "Package_DIP:DIP-28_W7.62mm_Socket_LongPads" H 5350 5000 50  0001 C CNN
F 3 "https://ecee.colorado.edu/~mcclurel/Cypress_SRAM_CY62256.pdf" H 5350 5000 50  0001 C CNN
	1    5350 5100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR028
U 1 1 5F6B4029
P 5350 6000
F 0 "#PWR028" H 5350 5750 50  0001 C CNN
F 1 "GND" H 5355 5827 50  0000 C CNN
F 2 "" H 5350 6000 50  0001 C CNN
F 3 "" H 5350 6000 50  0001 C CNN
	1    5350 6000
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR027
U 1 1 5F6B4033
P 5350 4200
F 0 "#PWR027" H 5350 4050 50  0001 C CNN
F 1 "VCC" H 5365 4373 50  0000 C CNN
F 2 "" H 5350 4200 50  0001 C CNN
F 3 "" H 5350 4200 50  0001 C CNN
	1    5350 4200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR030
U 1 1 5F6B403D
P 5850 5500
F 0 "#PWR030" H 5850 5250 50  0001 C CNN
F 1 "GND" V 5855 5372 50  0000 R CNN
F 2 "" H 5850 5500 50  0001 C CNN
F 3 "" H 5850 5500 50  0001 C CNN
	1    5850 5500
	0    -1   -1   0   
$EndComp
Text GLabel 6100 5300 2    50   Input ~ 0
~CS_R3
Text GLabel 6100 5600 2    50   Input ~ 0
~WE_R3
Wire Wire Line
	6100 5300 5850 5300
Wire Wire Line
	5850 5600 6100 5600
Entry Wire Line
	4500 5700 4600 5800
Entry Wire Line
	4500 5600 4600 5700
Entry Wire Line
	4500 5500 4600 5600
Entry Wire Line
	4500 5400 4600 5500
Entry Wire Line
	4500 5300 4600 5400
Entry Wire Line
	4500 5200 4600 5300
Entry Wire Line
	4500 5100 4600 5200
Entry Wire Line
	4500 5000 4600 5100
Entry Wire Line
	4500 4900 4600 5000
Entry Wire Line
	4500 4800 4600 4900
Entry Wire Line
	4500 4700 4600 4800
Entry Wire Line
	4500 4600 4600 4700
Entry Wire Line
	4500 4500 4600 4600
Entry Wire Line
	4500 4400 4600 4500
Entry Wire Line
	4500 4300 4600 4400
Text Label 4800 4400 2    50   ~ 0
RA0
Text Label 4800 4500 2    50   ~ 0
RA1
Text Label 4800 4600 2    50   ~ 0
RA2
Text Label 4800 4700 2    50   ~ 0
RA3
Text Label 4800 4800 2    50   ~ 0
RA4
Text Label 4800 4900 2    50   ~ 0
RA5
Text Label 4800 5000 2    50   ~ 0
RA6
Text Label 4800 5100 2    50   ~ 0
RA7
Text Label 4800 5200 2    50   ~ 0
RA8
Text Label 4800 5300 2    50   ~ 0
RA9
Text Label 4850 5400 2    50   ~ 0
RA10
Text Label 4850 5500 2    50   ~ 0
RA11
Text Label 4850 5600 2    50   ~ 0
RA12
Text Label 4850 5700 2    50   ~ 0
RA13
Text Label 4850 5800 2    50   ~ 0
RA14
Wire Wire Line
	4600 4400 4850 4400
Wire Wire Line
	4600 4500 4850 4500
Wire Wire Line
	4600 4600 4850 4600
Wire Wire Line
	4600 4700 4850 4700
Wire Wire Line
	4600 4800 4850 4800
Wire Wire Line
	4600 4900 4850 4900
Wire Wire Line
	4600 5000 4850 5000
Wire Wire Line
	4600 5100 4850 5100
Wire Wire Line
	4600 5200 4850 5200
Wire Wire Line
	4600 5300 4850 5300
Wire Wire Line
	4600 5400 4850 5400
Wire Wire Line
	4600 5500 4850 5500
Wire Wire Line
	4600 5600 4850 5600
Wire Wire Line
	4600 5700 4850 5700
Wire Wire Line
	4600 5800 4850 5800
Wire Wire Line
	5850 4400 6100 4400
Wire Wire Line
	5850 4500 6100 4500
Wire Wire Line
	5850 4600 6100 4600
Wire Wire Line
	5850 4700 6100 4700
Wire Wire Line
	5850 4800 6100 4800
Wire Wire Line
	5850 4900 6100 4900
Wire Wire Line
	5850 5000 6100 5000
Wire Wire Line
	5850 5100 6100 5100
Entry Wire Line
	6200 4300 6100 4400
Entry Wire Line
	6200 4400 6100 4500
Entry Wire Line
	6200 4600 6100 4700
Entry Wire Line
	6200 4500 6100 4600
Entry Wire Line
	6200 4700 6100 4800
Entry Wire Line
	6200 4800 6100 4900
Entry Wire Line
	6200 4900 6100 5000
Entry Wire Line
	6200 5000 6100 5100
Wire Bus Line
	6200 4200 6250 4200
Text Label 6100 4400 2    50   ~ 0
R3D0
Text Label 6100 4500 2    50   ~ 0
R3D1
Text Label 6100 4600 2    50   ~ 0
R3D2
Text Label 6100 4700 2    50   ~ 0
R3D3
Text Label 6100 4800 2    50   ~ 0
R3D4
Text Label 6100 5000 2    50   ~ 0
R3D6
Text Label 6100 5100 2    50   ~ 0
R3D7
Text Notes 2500 2600 2    50   ~ 0
RAM0
Text Notes 5450 2600 2    50   ~ 0
RAM1
Text Notes 2500 5150 2    50   ~ 0
RAM2
Text Notes 5450 5150 2    50   ~ 0
RAM3
Text Label 6100 2150 2    50   ~ 0
R1D3
Text Label 6100 2250 2    50   ~ 0
R1D4
Text Label 6100 4900 2    50   ~ 0
R3D5
Wire Bus Line
	1550 1300 4500 1300
Wire Bus Line
	1550 1300 1500 1300
Connection ~ 1550 1300
Text GLabel 1500 1300 0    50   Input ~ 0
RA[0..14]
Text GLabel 3300 1650 2    50   BiDi ~ 0
R0D[0..7]
Text GLabel 3300 4200 2    50   BiDi ~ 0
R2D[0..7]
Text GLabel 6250 1650 2    50   BiDi ~ 0
R1D[0..7]
Text GLabel 6250 4200 2    50   BiDi ~ 0
R3D[0..7]
Wire Bus Line
	3250 1650 3250 2450
Wire Bus Line
	3250 4200 3250 5000
Wire Bus Line
	6200 1650 6200 2450
Wire Bus Line
	6200 4200 6200 5000
Wire Bus Line
	1550 1300 1550 5700
Wire Bus Line
	4500 1300 4500 5700
$EndSCHEMATC
