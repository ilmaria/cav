@echo off

set arch=x64
set executable=cav
set build_dir=build

call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" %arch%

set debugflags=/Od /Zi
set releaseflags=/Ox /GL /Qpar
set devflags=/Zi
set commonflags=/Wall /Fo%build_dir%\%executable%.obj /I "3rd_party\SDL2\include"

mkdir %build_dir%
set linkerflags=/out:%build_dir%\%executable%.exe /subsystem:console /libpath:3rd_party\SDL2\lib\%arch%

cl.exe %releaseflags% %commonflags% %devflags% "src\main.c" SDL2.lib SDL2main.lib /link %linkerflags%