@echo off

del bin\b.bin
del bin\BIOS0.bin
del bin\BIOS1.bin
nasm -f bin src\resetvector.asm -o bin\resetvector.bin

if exist c:\windows\sysnative\wsl.exe (
	c:\windows\sysnative\wsl ./build.sh
) else (
	wsl ./build.sh
)

pause

if exist bin\b.bin (
	del bin\b.asm
	disasm bin\b.bin > bin\b.asm
	BiosBuilder
) else ( pause )
