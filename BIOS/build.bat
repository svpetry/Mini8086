@echo off

del *.bin
nasm -f bin src\resetvector.asm -o resetvector.bin

md bios
del bios\*.* /q
copy src\*.h bios /b /v /y
copy src\*.c bios /b /v /y
copy src\*.S bios /b /v /y
copy src\*.LD bios /b /v /y
copy src\*.sh bios /b /v /y

cd bios
REM c:\windows\sysnative\wsl ./build.sh
wsl ./build.sh
cd ..

copy bios\*.bin . /b /v /y

REM del b.asm
REM disasm b.bin > b.asm

BiosBuilder
REM if not exist ROM0.bin pause
pause
