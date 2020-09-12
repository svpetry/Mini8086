@rem i16gcc -c -O0 -fno-jump-tables -save-temps -o io.o io.c
@rem i16gcc -c -O0 -fno-jump-tables -save-temps -o biosfunc.o biosfunc.c
@rem i16gcc -c -O0 -fno-jump-tables -save-temps -o startup.o startup.c
@rem i16gcc -c -O0 -fno-jump-tables -save-temps -o boot.o boot.c

i16gcc -O0 -mseparate-code-segment -fno-jump-tables -nostartfiles -T BIOS.LD -o bios0.bin io.c biosfunc.c startup.c boot.c bios0.c
@rem pause
@rem exit