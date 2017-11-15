@echo off

set executable=cav
set build_dir=build

call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x64  

:: Debug
::set compilerflags=/Od /Zi

:: Release
set compilerflags=/Ox /GL /Qpar /Wall /I "3rd_party\SDL2\include" /Fo%build_dir%\%executable%.obj

mkdir %build_dir%
set linkerflags=/OUT:%build_dir%\%executable%.exe

cl.exe %compilerflags% "src\main.c" /link %linkerflags%