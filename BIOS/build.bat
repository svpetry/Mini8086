@rem build.bat

del *.obj
del *.bin
del *.err

cls

nasm -f bin resetvector.asm -o resetvector.bin
nasm -f bin initializer.asm -o initializer.bin

call buildbios.bat

del *.obj
BiosBuilder
