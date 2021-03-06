EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 4 4
Title "Mini8086 LED board"
Date ""
Rev "1.1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L 74xx:74HC245 U?
U 1 1 5FDFDFEB
P 2350 1900
AR Path="/5FDA4A79/5FDFDFEB" Ref="U?"  Part="1" 
AR Path="/5FDA4CF8/5FDFDFEB" Ref="U6"  Part="1" 
F 0 "U6" H 2100 1200 50  0000 C CNN
F 1 "74HC245" H 2600 1200 50  0000 C CNN
F 2 "Package_SO:SO-20_12.8x7.5mm_P1.27mm" H 2350 1900 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC245" H 2350 1900 50  0001 C CNN
F 4 "C5625" H 2350 1900 50  0001 C CNN "LCSC"
	1    2350 1900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FDFDFF1
P 2350 2700
AR Path="/5FDA4A79/5FDFDFF1" Ref="#PWR?"  Part="1" 
AR Path="/5FDA4CF8/5FDFDFF1" Ref="#PWR038"  Part="1" 
F 0 "#PWR038" H 2350 2450 50  0001 C CNN
F 1 "GND" H 2355 2527 50  0000 C CNN
F 2 "" H 2350 2700 50  0001 C CNN
F 3 "" H 2350 2700 50  0001 C CNN
	1    2350 2700
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5FDFDFF7
P 2350 1100
AR Path="/5FDA4A79/5FDFDFF7" Ref="#PWR?"  Part="1" 
AR Path="/5FDA4CF8/5FDFDFF7" Ref="#PWR037"  Part="1" 
F 0 "#PWR037" H 2350 950 50  0001 C CNN
F 1 "VCC" H 2365 1273 50  0000 C CNN
F 2 "" H 2350 1100 50  0001 C CNN
F 3 "" H 2350 1100 50  0001 C CNN
	1    2350 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	1850 2400 1800 2400
Wire Wire Line
	1800 2400 1800 2700
$Comp
L power:GND #PWR?
U 1 1 5FDFDFFF
P 1800 2700
AR Path="/5FDA4A79/5FDFDFFF" Ref="#PWR?"  Part="1" 
AR Path="/5FDA4CF8/5FDFDFFF" Ref="#PWR035"  Part="1" 
F 0 "#PWR035" H 1800 2450 50  0001 C CNN
F 1 "GND" H 1805 2527 50  0000 C CNN
F 2 "" H 1800 2700 50  0001 C CNN
F 3 "" H 1800 2700 50  0001 C CNN
	1    1800 2700
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5FDFE005
P 1850 2300
AR Path="/5FDA4A79/5FDFE005" Ref="#PWR?"  Part="1" 
AR Path="/5FDA4CF8/5FDFE005" Ref="#PWR036"  Part="1" 
F 0 "#PWR036" H 1850 2150 50  0001 C CNN
F 1 "VCC" V 1865 2427 50  0000 L CNN
F 2 "" H 1850 2300 50  0001 C CNN
F 3 "" H 1850 2300 50  0001 C CNN
	1    1850 2300
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D?
U 1 1 5FDFE025
P 3050 2250
AR Path="/5FDA4A79/5FDFE025" Ref="D?"  Part="1" 
AR Path="/5FDA4CF8/5FDFE025" Ref="D41"  Part="1" 
F 0 "D41" V 3089 2132 50  0000 R CNN
F 1 "NMI" V 2998 2132 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 3050 2250 50  0001 C CNN
F 3 "~" H 3050 2250 50  0001 C CNN
	1    3050 2250
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D?
U 1 1 5FDFE02B
P 3400 2250
AR Path="/5FDA4A79/5FDFE02B" Ref="D?"  Part="1" 
AR Path="/5FDA4CF8/5FDFE02B" Ref="D42"  Part="1" 
F 0 "D42" V 3439 2132 50  0000 R CNN
F 1 "TMR2" V 3348 2132 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 3400 2250 50  0001 C CNN
F 3 "~" H 3400 2250 50  0001 C CNN
	1    3400 2250
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D?
U 1 1 5FDFE031
P 3750 2250
AR Path="/5FDA4A79/5FDFE031" Ref="D?"  Part="1" 
AR Path="/5FDA4CF8/5FDFE031" Ref="D43"  Part="1" 
F 0 "D43" V 3789 2132 50  0000 R CNN
F 1 "IRQ7" V 3698 2132 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 3750 2250 50  0001 C CNN
F 3 "~" H 3750 2250 50  0001 C CNN
	1    3750 2250
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D?
U 1 1 5FDFE037
P 4100 2250
AR Path="/5FDA4A79/5FDFE037" Ref="D?"  Part="1" 
AR Path="/5FDA4CF8/5FDFE037" Ref="D44"  Part="1" 
F 0 "D44" V 4139 2132 50  0000 R CNN
F 1 "IRQ6" V 4048 2132 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 4100 2250 50  0001 C CNN
F 3 "~" H 4100 2250 50  0001 C CNN
	1    4100 2250
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D?
U 1 1 5FDFE03D
P 4450 2250
AR Path="/5FDA4A79/5FDFE03D" Ref="D?"  Part="1" 
AR Path="/5FDA4CF8/5FDFE03D" Ref="D45"  Part="1" 
F 0 "D45" V 4489 2132 50  0000 R CNN
F 1 "IRQ5" V 4398 2132 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 4450 2250 50  0001 C CNN
F 3 "~" H 4450 2250 50  0001 C CNN
	1    4450 2250
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D?
U 1 1 5FDFE043
P 4800 2250
AR Path="/5FDA4A79/5FDFE043" Ref="D?"  Part="1" 
AR Path="/5FDA4CF8/5FDFE043" Ref="D46"  Part="1" 
F 0 "D46" V 4839 2132 50  0000 R CNN
F 1 "IRQ4" V 4748 2132 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 4800 2250 50  0001 C CNN
F 3 "~" H 4800 2250 50  0001 C CNN
	1    4800 2250
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D?
U 1 1 5FDFE049
P 5150 2250
AR Path="/5FDA4A79/5FDFE049" Ref="D?"  Part="1" 
AR Path="/5FDA4CF8/5FDFE049" Ref="D47"  Part="1" 
F 0 "D47" V 5189 2132 50  0000 R CNN
F 1 "IRQ3" V 5098 2132 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 5150 2250 50  0001 C CNN
F 3 "~" H 5150 2250 50  0001 C CNN
	1    5150 2250
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D?
U 1 1 5FDFE04F
P 5500 2250
AR Path="/5FDA4A79/5FDFE04F" Ref="D?"  Part="1" 
AR Path="/5FDA4CF8/5FDFE04F" Ref="D48"  Part="1" 
F 0 "D48" V 5539 2132 50  0000 R CNN
F 1 "IRQ1" V 5448 2132 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 5500 2250 50  0001 C CNN
F 3 "~" H 5500 2250 50  0001 C CNN
	1    5500 2250
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2850 2100 3050 2100
Wire Wire Line
	2850 2000 3400 2000
Wire Wire Line
	3400 2000 3400 2100
Wire Wire Line
	2850 1900 3750 1900
Wire Wire Line
	3750 1900 3750 2100
Wire Wire Line
	2850 1800 4100 1800
Wire Wire Line
	4100 1800 4100 2100
Wire Wire Line
	2850 1700 4450 1700
Wire Wire Line
	4450 1700 4450 2100
Wire Wire Line
	2850 1600 4800 1600
Wire Wire Line
	4800 1600 4800 2100
Wire Wire Line
	5150 1500 5150 2100
Wire Wire Line
	2850 1500 5150 1500
Wire Wire Line
	2850 1400 5500 1400
Wire Wire Line
	5500 1400 5500 2100
$Comp
L Device:R R?
U 1 1 5FDFE064
P 5500 2550
AR Path="/5FDA4A79/5FDFE064" Ref="R?"  Part="1" 
AR Path="/5FDA4CF8/5FDFE064" Ref="R48"  Part="1" 
F 0 "R48" H 5570 2596 50  0000 L CNN
F 1 "300" H 5570 2505 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 5430 2550 50  0001 C CNN
F 3 "~" H 5500 2550 50  0001 C CNN
F 4 "C17887" H 5500 2550 50  0001 C CNN "LCSC"
	1    5500 2550
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5FDFE06A
P 5150 2550
AR Path="/5FDA4A79/5FDFE06A" Ref="R?"  Part="1" 
AR Path="/5FDA4CF8/5FDFE06A" Ref="R47"  Part="1" 
F 0 "R47" H 5220 2596 50  0000 L CNN
F 1 "300" H 5220 2505 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 5080 2550 50  0001 C CNN
F 3 "~" H 5150 2550 50  0001 C CNN
F 4 "C17887" H 5150 2550 50  0001 C CNN "LCSC"
	1    5150 2550
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5FDFE070
P 4800 2550
AR Path="/5FDA4A79/5FDFE070" Ref="R?"  Part="1" 
AR Path="/5FDA4CF8/5FDFE070" Ref="R46"  Part="1" 
F 0 "R46" H 4870 2596 50  0000 L CNN
F 1 "300" H 4870 2505 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 4730 2550 50  0001 C CNN
F 3 "~" H 4800 2550 50  0001 C CNN
F 4 "C17887" H 4800 2550 50  0001 C CNN "LCSC"
	1    4800 2550
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5FDFE076
P 4450 2550
AR Path="/5FDA4A79/5FDFE076" Ref="R?"  Part="1" 
AR Path="/5FDA4CF8/5FDFE076" Ref="R45"  Part="1" 
F 0 "R45" H 4520 2596 50  0000 L CNN
F 1 "300" H 4520 2505 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 4380 2550 50  0001 C CNN
F 3 "~" H 4450 2550 50  0001 C CNN
F 4 "C17887" H 4450 2550 50  0001 C CNN "LCSC"
	1    4450 2550
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5FDFE07C
P 4100 2550
AR Path="/5FDA4A79/5FDFE07C" Ref="R?"  Part="1" 
AR Path="/5FDA4CF8/5FDFE07C" Ref="R44"  Part="1" 
F 0 "R44" H 4170 2596 50  0000 L CNN
F 1 "300" H 4170 2505 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 4030 2550 50  0001 C CNN
F 3 "~" H 4100 2550 50  0001 C CNN
F 4 "C17887" H 4100 2550 50  0001 C CNN "LCSC"
	1    4100 2550
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5FDFE082
P 3750 2550
AR Path="/5FDA4A79/5FDFE082" Ref="R?"  Part="1" 
AR Path="/5FDA4CF8/5FDFE082" Ref="R43"  Part="1" 
F 0 "R43" H 3820 2596 50  0000 L CNN
F 1 "300" H 3820 2505 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 3680 2550 50  0001 C CNN
F 3 "~" H 3750 2550 50  0001 C CNN
F 4 "C17887" H 3750 2550 50  0001 C CNN "LCSC"
	1    3750 2550
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5FDFE088
P 3400 2550
AR Path="/5FDA4A79/5FDFE088" Ref="R?"  Part="1" 
AR Path="/5FDA4CF8/5FDFE088" Ref="R42"  Part="1" 
F 0 "R42" H 3470 2596 50  0000 L CNN
F 1 "300" H 3470 2505 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 3330 2550 50  0001 C CNN
F 3 "~" H 3400 2550 50  0001 C CNN
F 4 "C17887" H 3400 2550 50  0001 C CNN "LCSC"
	1    3400 2550
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5FDFE08E
P 3050 2550
AR Path="/5FDA4A79/5FDFE08E" Ref="R?"  Part="1" 
AR Path="/5FDA4CF8/5FDFE08E" Ref="R41"  Part="1" 
F 0 "R41" H 3120 2596 50  0000 L CNN
F 1 "300" H 3120 2505 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 2980 2550 50  0001 C CNN
F 3 "~" H 3050 2550 50  0001 C CNN
F 4 "C17887" H 3050 2550 50  0001 C CNN "LCSC"
	1    3050 2550
	1    0    0    -1  
$EndComp
Wire Wire Line
	3050 2700 3050 2850
Wire Wire Line
	5500 2850 5500 2700
Wire Wire Line
	5150 2850 5150 2700
Connection ~ 5150 2850
Wire Wire Line
	5150 2850 5500 2850
Wire Wire Line
	4800 2850 4800 2700
Connection ~ 4800 2850
Wire Wire Line
	4800 2850 5150 2850
Wire Wire Line
	4450 2850 4450 2700
Connection ~ 4450 2850
Wire Wire Line
	4450 2850 4800 2850
Wire Wire Line
	4100 2700 4100 2850
Connection ~ 4100 2850
Wire Wire Line
	4100 2850 4450 2850
Wire Wire Line
	3050 2850 3400 2850
Wire Wire Line
	3750 2700 3750 2850
Connection ~ 3750 2850
Wire Wire Line
	3750 2850 4100 2850
Wire Wire Line
	3400 2700 3400 2850
Connection ~ 3400 2850
Wire Wire Line
	3400 2850 3750 2850
Wire Wire Line
	3050 2850 3050 2950
Connection ~ 3050 2850
$Comp
L power:GND #PWR?
U 1 1 5FDFE0AB
P 3050 2950
AR Path="/5FDA4A79/5FDFE0AB" Ref="#PWR?"  Part="1" 
AR Path="/5FDA4CF8/5FDFE0AB" Ref="#PWR040"  Part="1" 
F 0 "#PWR040" H 3050 2700 50  0001 C CNN
F 1 "GND" H 3055 2777 50  0000 C CNN
F 2 "" H 3050 2950 50  0001 C CNN
F 3 "" H 3050 2950 50  0001 C CNN
	1    3050 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	1750 1400 1850 1400
Wire Wire Line
	1500 1500 1850 1500
Wire Wire Line
	1750 1600 1850 1600
Wire Wire Line
	1500 1700 1850 1700
Wire Wire Line
	1750 1800 1850 1800
Wire Wire Line
	1500 1900 1850 1900
Text GLabel 1750 1400 0    50   Input ~ 0
IRQ1
Text GLabel 1500 1500 0    50   Input ~ 0
IRQ3
Text GLabel 1750 1600 0    50   Input ~ 0
IRQ4
Text GLabel 1500 1700 0    50   Input ~ 0
IRQ5
Text GLabel 1750 1800 0    50   Input ~ 0
IRQ6
Text GLabel 1500 1900 0    50   Input ~ 0
IRQ7
Wire Wire Line
	1850 2000 1750 2000
Wire Wire Line
	1850 2100 1500 2100
Text GLabel 1750 2000 0    50   Input ~ 0
TMR2
Text GLabel 1500 2100 0    50   Input ~ 0
NMI
$Comp
L 74xx:74HC245 U?
U 1 1 5FDE912A
P 2350 4400
AR Path="/5FDA4A79/5FDE912A" Ref="U?"  Part="1" 
AR Path="/5FDA4CF8/5FDE912A" Ref="U7"  Part="1" 
F 0 "U7" H 2100 3700 50  0000 C CNN
F 1 "74HC245" H 2600 3700 50  0000 C CNN
F 2 "Package_SO:SO-20_12.8x7.5mm_P1.27mm" H 2350 4400 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC245" H 2350 4400 50  0001 C CNN
F 4 "C5625" H 2350 4400 50  0001 C CNN "LCSC"
	1    2350 4400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FDE9130
P 2350 5200
AR Path="/5FDA4A79/5FDE9130" Ref="#PWR?"  Part="1" 
AR Path="/5FDA4CF8/5FDE9130" Ref="#PWR043"  Part="1" 
F 0 "#PWR043" H 2350 4950 50  0001 C CNN
F 1 "GND" H 2355 5027 50  0000 C CNN
F 2 "" H 2350 5200 50  0001 C CNN
F 3 "" H 2350 5200 50  0001 C CNN
	1    2350 5200
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5FDE9136
P 2350 3600
AR Path="/5FDA4A79/5FDE9136" Ref="#PWR?"  Part="1" 
AR Path="/5FDA4CF8/5FDE9136" Ref="#PWR042"  Part="1" 
F 0 "#PWR042" H 2350 3450 50  0001 C CNN
F 1 "VCC" H 2365 3773 50  0000 C CNN
F 2 "" H 2350 3600 50  0001 C CNN
F 3 "" H 2350 3600 50  0001 C CNN
	1    2350 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	1850 4900 1800 4900
Wire Wire Line
	1800 4900 1800 5200
$Comp
L power:GND #PWR?
U 1 1 5FDE913E
P 1800 5200
AR Path="/5FDA4A79/5FDE913E" Ref="#PWR?"  Part="1" 
AR Path="/5FDA4CF8/5FDE913E" Ref="#PWR039"  Part="1" 
F 0 "#PWR039" H 1800 4950 50  0001 C CNN
F 1 "GND" H 1805 5027 50  0000 C CNN
F 2 "" H 1800 5200 50  0001 C CNN
F 3 "" H 1800 5200 50  0001 C CNN
	1    1800 5200
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 5FDE9144
P 1850 4800
AR Path="/5FDA4A79/5FDE9144" Ref="#PWR?"  Part="1" 
AR Path="/5FDA4CF8/5FDE9144" Ref="#PWR041"  Part="1" 
F 0 "#PWR041" H 1850 4650 50  0001 C CNN
F 1 "VCC" V 1865 4927 50  0000 L CNN
F 2 "" H 1850 4800 50  0001 C CNN
F 3 "" H 1850 4800 50  0001 C CNN
	1    1850 4800
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D?
U 1 1 5FDE914A
P 3050 4750
AR Path="/5FDA4A79/5FDE914A" Ref="D?"  Part="1" 
AR Path="/5FDA4CF8/5FDE914A" Ref="D3"  Part="1" 
F 0 "D3" V 3089 4632 50  0000 R CNN
F 1 "RESET" V 2998 4632 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 3050 4750 50  0001 C CNN
F 3 "~" H 3050 4750 50  0001 C CNN
	1    3050 4750
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D?
U 1 1 5FDE9156
P 4250 4750
AR Path="/5FDA4A79/5FDE9156" Ref="D?"  Part="1" 
AR Path="/5FDA4CF8/5FDE9156" Ref="D9"  Part="1" 
F 0 "D9" V 4289 4632 50  0000 R CNN
F 1 "~VGA_IO" V 4198 4632 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 4250 4750 50  0001 C CNN
F 3 "~" H 4250 4750 50  0001 C CNN
	1    4250 4750
	0    1    1    0   
$EndComp
$Comp
L Device:LED D?
U 1 1 5FDE915C
P 4750 4750
AR Path="/5FDA4A79/5FDE915C" Ref="D?"  Part="1" 
AR Path="/5FDA4CF8/5FDE915C" Ref="D12"  Part="1" 
F 0 "D12" V 4789 4632 50  0000 R CNN
F 1 "~VGA_MEM" V 4698 4632 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 4750 4750 50  0001 C CNN
F 3 "~" H 4750 4750 50  0001 C CNN
	1    4750 4750
	0    1    1    0   
$EndComp
$Comp
L Device:LED D?
U 1 1 5FDE9162
P 5250 4750
AR Path="/5FDA4A79/5FDE9162" Ref="D?"  Part="1" 
AR Path="/5FDA4CF8/5FDE9162" Ref="D49"  Part="1" 
F 0 "D49" V 5289 4632 50  0000 R CNN
F 1 "~MEMRD" V 5198 4632 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 5250 4750 50  0001 C CNN
F 3 "~" H 5250 4750 50  0001 C CNN
	1    5250 4750
	0    1    1    0   
$EndComp
$Comp
L Device:LED D?
U 1 1 5FDE9168
P 5750 4750
AR Path="/5FDA4A79/5FDE9168" Ref="D?"  Part="1" 
AR Path="/5FDA4CF8/5FDE9168" Ref="D50"  Part="1" 
F 0 "D50" V 5789 4632 50  0000 R CNN
F 1 "~MEMWR" V 5698 4632 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 5750 4750 50  0001 C CNN
F 3 "~" H 5750 4750 50  0001 C CNN
	1    5750 4750
	0    1    1    0   
$EndComp
$Comp
L Device:LED D?
U 1 1 5FDE916E
P 6250 4750
AR Path="/5FDA4A79/5FDE916E" Ref="D?"  Part="1" 
AR Path="/5FDA4CF8/5FDE916E" Ref="D51"  Part="1" 
F 0 "D51" V 6289 4632 50  0000 R CNN
F 1 "~WR" V 6198 4632 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 6250 4750 50  0001 C CNN
F 3 "~" H 6250 4750 50  0001 C CNN
	1    6250 4750
	0    1    1    0   
$EndComp
Wire Wire Line
	2850 4600 3050 4600
Wire Wire Line
	2850 4400 4250 4400
Wire Wire Line
	4250 4400 4250 4600
Wire Wire Line
	2850 4300 4750 4300
Wire Wire Line
	4750 4300 4750 4600
Wire Wire Line
	2850 4200 5250 4200
Wire Wire Line
	5250 4200 5250 4600
Wire Wire Line
	2850 4100 5750 4100
Wire Wire Line
	5750 4100 5750 4600
Wire Wire Line
	6250 4000 6250 4600
Wire Wire Line
	2850 4000 6250 4000
Wire Wire Line
	2850 3900 6750 3900
Wire Wire Line
	6750 3900 6750 4600
$Comp
L Device:R R?
U 1 1 5FDE9189
P 6750 5050
AR Path="/5FDA4A79/5FDE9189" Ref="R?"  Part="1" 
AR Path="/5FDA4CF8/5FDE9189" Ref="R52"  Part="1" 
F 0 "R52" H 6820 5096 50  0000 L CNN
F 1 "300" H 6820 5005 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 6680 5050 50  0001 C CNN
F 3 "~" H 6750 5050 50  0001 C CNN
F 4 "C17887" H 6750 5050 50  0001 C CNN "LCSC"
	1    6750 5050
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5FDE918F
P 6250 5050
AR Path="/5FDA4A79/5FDE918F" Ref="R?"  Part="1" 
AR Path="/5FDA4CF8/5FDE918F" Ref="R51"  Part="1" 
F 0 "R51" H 6320 5096 50  0000 L CNN
F 1 "300" H 6320 5005 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 6180 5050 50  0001 C CNN
F 3 "~" H 6250 5050 50  0001 C CNN
F 4 "C17887" H 6250 5050 50  0001 C CNN "LCSC"
	1    6250 5050
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5FDE9195
P 5750 5050
AR Path="/5FDA4A79/5FDE9195" Ref="R?"  Part="1" 
AR Path="/5FDA4CF8/5FDE9195" Ref="R50"  Part="1" 
F 0 "R50" H 5820 5096 50  0000 L CNN
F 1 "300" H 5820 5005 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 5680 5050 50  0001 C CNN
F 3 "~" H 5750 5050 50  0001 C CNN
F 4 "C17887" H 5750 5050 50  0001 C CNN "LCSC"
	1    5750 5050
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5FDE919B
P 5250 5050
AR Path="/5FDA4A79/5FDE919B" Ref="R?"  Part="1" 
AR Path="/5FDA4CF8/5FDE919B" Ref="R49"  Part="1" 
F 0 "R49" H 5320 5096 50  0000 L CNN
F 1 "300" H 5320 5005 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 5180 5050 50  0001 C CNN
F 3 "~" H 5250 5050 50  0001 C CNN
F 4 "C17887" H 5250 5050 50  0001 C CNN "LCSC"
	1    5250 5050
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5FDE91A1
P 4750 5050
AR Path="/5FDA4A79/5FDE91A1" Ref="R?"  Part="1" 
AR Path="/5FDA4CF8/5FDE91A1" Ref="R12"  Part="1" 
F 0 "R12" H 4820 5096 50  0000 L CNN
F 1 "300" H 4820 5005 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 4680 5050 50  0001 C CNN
F 3 "~" H 4750 5050 50  0001 C CNN
F 4 "C17887" H 4750 5050 50  0001 C CNN "LCSC"
	1    4750 5050
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5FDE91A7
P 4250 5050
AR Path="/5FDA4A79/5FDE91A7" Ref="R?"  Part="1" 
AR Path="/5FDA4CF8/5FDE91A7" Ref="R9"  Part="1" 
F 0 "R9" H 4320 5096 50  0000 L CNN
F 1 "300" H 4320 5005 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 4180 5050 50  0001 C CNN
F 3 "~" H 4250 5050 50  0001 C CNN
F 4 "C17887" H 4250 5050 50  0001 C CNN "LCSC"
	1    4250 5050
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5FDE91B3
P 3050 5050
AR Path="/5FDA4A79/5FDE91B3" Ref="R?"  Part="1" 
AR Path="/5FDA4CF8/5FDE91B3" Ref="R3"  Part="1" 
F 0 "R3" H 3120 5096 50  0000 L CNN
F 1 "300" H 3120 5005 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 2980 5050 50  0001 C CNN
F 3 "~" H 3050 5050 50  0001 C CNN
F 4 "C17887" H 3050 5050 50  0001 C CNN "LCSC"
	1    3050 5050
	1    0    0    -1  
$EndComp
Wire Wire Line
	6750 5500 6750 5200
Wire Wire Line
	6250 5500 6250 5200
Connection ~ 6250 5500
Wire Wire Line
	6250 5500 6750 5500
Wire Wire Line
	5750 5500 5750 5200
Connection ~ 5750 5500
Wire Wire Line
	5750 5500 6250 5500
Wire Wire Line
	5250 5500 5250 5200
Connection ~ 5250 5500
Wire Wire Line
	5250 5500 5750 5500
Wire Wire Line
	4750 5200 4750 5500
Connection ~ 4750 5500
Wire Wire Line
	4750 5500 5250 5500
Wire Wire Line
	4250 5200 4250 5500
Connection ~ 4250 5500
Wire Wire Line
	4250 5500 4750 5500
Wire Wire Line
	1750 3900 1850 3900
Wire Wire Line
	1350 4000 1850 4000
Wire Wire Line
	1750 4100 1850 4100
Wire Wire Line
	1350 4200 1850 4200
Wire Wire Line
	1750 4300 1850 4300
Wire Wire Line
	1350 4400 1850 4400
Text GLabel 1750 3900 0    50   Input ~ 0
~RD
Text GLabel 1350 4000 0    50   Input ~ 0
~WR
Text GLabel 1750 4100 0    50   Input ~ 0
~MEMRD
Text GLabel 1350 4200 0    50   Input ~ 0
~MEMWR
Text GLabel 1750 4300 0    50   Input ~ 0
~VGA_MEM
Text GLabel 1350 4400 0    50   Input ~ 0
~VGA_IO
Wire Wire Line
	1850 4500 1750 4500
Wire Wire Line
	1850 4600 1350 4600
Text GLabel 1750 4500 0    50   Input ~ 0
M_~IO
Text GLabel 1350 4600 0    50   Input ~ 0
RESET
$Comp
L Device:LED D?
U 1 1 5FDE9174
P 6750 4750
AR Path="/5FDA4A79/5FDE9174" Ref="D?"  Part="1" 
AR Path="/5FDA4CF8/5FDE9174" Ref="D52"  Part="1" 
F 0 "D52" V 6789 4632 50  0000 R CNN
F 1 "~RD" V 6698 4632 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 6750 4750 50  0001 C CNN
F 3 "~" H 6750 4750 50  0001 C CNN
	1    6750 4750
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FE24827
P 3050 5200
AR Path="/5FDA4A79/5FE24827" Ref="#PWR?"  Part="1" 
AR Path="/5FDA4CF8/5FE24827" Ref="#PWR045"  Part="1" 
F 0 "#PWR045" H 3050 4950 50  0001 C CNN
F 1 "GND" H 3055 5027 50  0000 C CNN
F 2 "" H 3050 5200 50  0001 C CNN
F 3 "" H 3050 5200 50  0001 C CNN
	1    3050 5200
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5FDE91AD
P 3750 5050
AR Path="/5FDA4A79/5FDE91AD" Ref="R?"  Part="1" 
AR Path="/5FDA4CF8/5FDE91AD" Ref="R6"  Part="1" 
F 0 "R6" H 3820 5096 50  0000 L CNN
F 1 "300" H 3820 5005 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 3680 5050 50  0001 C CNN
F 3 "~" H 3750 5050 50  0001 C CNN
F 4 "C17887" H 3750 5050 50  0001 C CNN "LCSC"
	1    3750 5050
	1    0    0    -1  
$EndComp
Wire Wire Line
	3750 4500 3750 4600
Wire Wire Line
	2850 4500 3750 4500
$Comp
L power:VCC #PWR?
U 1 1 5FE137B0
P 2950 5500
AR Path="/5FDA4A79/5FE137B0" Ref="#PWR?"  Part="1" 
AR Path="/5FDA4CF8/5FE137B0" Ref="#PWR044"  Part="1" 
F 0 "#PWR044" H 2950 5350 50  0001 C CNN
F 1 "VCC" V 2965 5627 50  0000 L CNN
F 2 "" H 2950 5500 50  0001 C CNN
F 3 "" H 2950 5500 50  0001 C CNN
	1    2950 5500
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2950 5500 3750 5500
Wire Wire Line
	3750 5500 4250 5500
Connection ~ 3750 5500
Wire Wire Line
	3750 5200 3750 5500
$Comp
L Device:LED D?
U 1 1 5FDE9150
P 3750 4750
AR Path="/5FDA4A79/5FDE9150" Ref="D?"  Part="1" 
AR Path="/5FDA4CF8/5FDE9150" Ref="D6"  Part="1" 
F 0 "D6" V 3789 4632 50  0000 R CNN
F 1 "~IO" V 3698 4632 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 3750 4750 50  0001 C CNN
F 3 "~" H 3750 4750 50  0001 C CNN
	1    3750 4750
	0    1    1    0   
$EndComp
$EndSCHEMATC
