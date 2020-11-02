ia16-elf-gcc -Os -c -o crt0.o CRT0.S
ia16-elf-gcc -Os -save-temps -mcmodel=small -fno-jump-tables -nostartfiles -mtune=i8086 -mno-segment-relocation-stuff -T BIOS.LD -o b.bin bios.c io.c utils.c boot.c start.c lowlevel.c biosfunc.c
