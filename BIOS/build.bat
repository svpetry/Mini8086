@echo off

del b.bin
del BIOS0.bin
del BIOS1.bin
nasm -f bin src\resetvector.asm -o resetvector.bin

md bios
del bios\*.* /q
copy src\*.h bios /b /v /y
copy src\*.c bios /b /v /y
copy src\*.S bios /b /v /y
copy src\*.LD bios /b /v /y
copy src\*.sh bios /b /v /y

cd bios
if exist c:\windows\sysnative\wsl.exe (
	c:\windows\sysnative\wsl ./build.sh
) else (
	wsl ./build.sh
)
cd ..

copy bios\*.bin . /b /v /y

REM pause

if exist b.bin (
	del b.asm
	disasm b.bin > b.asm
	BiosBuilder
) else ( pause )
