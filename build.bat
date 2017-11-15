@echo off

set executable=cav
set build_dir=build

call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x64  

set debugflags=/Od /Zi
set releaseflags=/Ox /GL /Qpar
set devflags=/Zi
set commonflags=/Wall /I "3rd_party\SDL2\include" /Fo%build_dir%\%executable%.obj

mkdir %build_dir%
set linkerflags=/OUT:%build_dir%\%executable%.exe

cl.exe %releaseflags% %commonflags% %devflags% "src\main.c" /link %linkerflags%