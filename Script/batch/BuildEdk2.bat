@REM
@REM BuildEdk2.bat - Setup EDK2 build environment
@REM

@echo off

set EDK_WORKSPACE=D:\Project\edk2
set EDK_REPO=vUDK2018

set PYTHON_HOME=C:\Python27
set CYGWIN_HOME=C:\cygwin64

set EDK_TOOLS_BIN=%EDK_WORKSPACE%\edk2-BaseTools-win32
set NASM_PREFIX=%EDK_WORKSPACE%\nasm-2.13.03\
set IASL_PREFIX=%EDK_WORKSPACE%\iasl-win-20180629\

cd %EDK_WORKSPACE%\%EDK_REPO%\

call edksetup.bat
cmd