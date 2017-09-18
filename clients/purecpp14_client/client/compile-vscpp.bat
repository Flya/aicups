@echo off

set VS_VERSION=

if "%VS_VERSION%" == "" (
   if "%VS140COMNTOOLS%" neq "" (
       call "%VS140COMNTOOLS%\vsvars32.bat"
       call "%VS140COMNTOOLS%\..\..\VC\bin\vcvars32.bat"
       set VS_VERSION="140"
       echo Compiling with Visual Studio 2015
   )
)

if "%VS_VERSION%" == "" (
    echo No Visual Studio installation has been found
    exit 1
)

echo ***

del /F /Q MyStrategy.exe

SetLocal EnableDelayedExpansion EnableExtensions

set FILES=

for %%i in (*.cpp) do (
    set FILES=!FILES! %%i
)

for %%i in (csimplesocket\*.cpp) do (
    set FILES=!FILES! %%i
)

cl /FeMyStrategy.exe /W3 /F268435456 /EHsc /O2 /DWIN32 /D_WINSOCK_DEPRECATED_NO_WARNINGS ws2_32.lib!FILES! 1>compilation.log
