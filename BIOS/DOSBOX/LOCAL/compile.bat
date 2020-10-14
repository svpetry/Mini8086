del *.o

i16gcc -Os -c -o crt0.o crt0.s

i16gcc -O0 -save-temps -mcmodel=small -fno-jump-tables -nostartfiles -T BIOS.LD -o b.bin io.c utils.c boot.c b0.c start.c

if exist b.bin exit