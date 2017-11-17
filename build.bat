@echo off

set build_type=%1
set arch=x64
set executable=cav
set debugflags=/Od /Zi
set releaseflags=/Ox /GL /Qpar
set devflags=%releaseflags% /Zi
set commonflags=/Wall  /I "3rd_party\SDL2\include"
set deps="3rd_party\SDL2\lib\x64\SDL2.dll"

:: This enables cl.exe usage
call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" %arch%

if "%build_type%"=="release" (
    set build_dir=build\release
    set compilerflags=%releaseflags% %commonflags% /Fo%build_dir%\%executable%.obj
    set subsystem=/subsystem:windows
) else (
    set build_dir=build\dev
    set compilerflags=%devflags% %commonflags% /Fo%build_dir%\%executable%.obj
    set subsystem=/subsystem:console
)

mkdir %build_dir%
set linkerflags=/out:%build_dir%\%executable%.exe %subsystem% /libpath:3rd_party\SDL2\lib\%arch%
set libs=SDL2.lib SDL2main.lib

cl.exe %compilerflags% "src\main.c" %libs% /link %linkerflags%

:: Copy necessary dependencies into build dir
for %%x in (%deps%) do (
    copy %%x %build_dir%
)