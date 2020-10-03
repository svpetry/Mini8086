i16gcc -Os -c -o crt0.o crt0.s

i16gcc -O0 -mseparate-code-segment -fno-jump-tables -nostartfiles -T BIOS.LD -o bios0.bin io.c biosfunc.c startup.c boot.c bios0.c

@rem pause
@rem exit