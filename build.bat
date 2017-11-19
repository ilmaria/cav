@echo off

set build_type=%1
set out_dir=dist
set app=cav
set debugflags=/Od /Zi
set releaseflags=/Ox /GL /Qpar
set devflags=/Zi
set commonflags=/Wall /I "include"

:: This enables cl.exe usage
call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x64

if "%build_type%"=="release" (
    set build_dir=%out_dir%\release
    set compilerflags=%releaseflags% %commonflags% /Fo%build_dir%\%app%.obj /Fd%build_dir%\%app%.pdb
    set subsystem=/subsystem:windows
) else (
    set build_dir=%out_dir%\dev
    set compilerflags=%devflags% %commonflags% /Fo%build_dir%\%app%.obj /Fd%build_dir%\%app%.pdb
    set subsystem=/subsystem:console
)

if not exist %build_dir% mkdir %build_dir%

set linkerflags=/out:%build_dir%\%app%.exe %subsystem% /libpath:lib
set libs=^
    SDL2\SDL2.lib^
    SDL2\SDL2main.lib

cl.exe %compilerflags% "src\main.c" %libs% /link %linkerflags%

:: Copy necessary dependencies into build dir
set deps="lib\SDL2\SDL2.dll"

for %%x in (%deps%) do (
    copy %%x %build_dir%
)
