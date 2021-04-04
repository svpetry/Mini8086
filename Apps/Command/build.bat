@echo off
if exist c:\windows\sysnative\wsl.exe (
	c:\windows\sysnative\wsl ./build.sh
) else (
	wsl ./build.sh
)

pause