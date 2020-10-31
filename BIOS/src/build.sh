ia16-elf-gcc -Os -c -o crt0.o CRT0.S
ia16-elf-gcc -O3 -save-temps -mcmodel=small -fno-jump-tables -nostartfiles -T BIOS.LD -o b.bin bios.c io.c utils.c boot.c start.c lowlevel.c
