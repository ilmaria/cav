@echo off

call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x64  

:: Debug
::set compilerflags=/Od /Zi

:: Release
set compilerflags=/Ox /GL /Qpar /Wall

set linkerflags=/OUT:cav.exe

cl.exe %compilerflags% "src\main.c" /link %linkerflags%