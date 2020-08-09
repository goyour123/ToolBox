@REM
@REM BuildEdk2.bat - Setup EDK2 build environment
@REM

@echo off

set EDK_WORKSPACE=%CD%
set EDK_REPO=edk2

set PYTHON_HOME=C:\Python27
set CYGWIN_HOME=C:\cygwin64

@REM set EDK_TOOLS_BIN=%EDK_WORKSPACE%\edk2-BaseTools-win32
set NASM_PREFIX=%EDK_WORKSPACE%\nasm-2.14.02\
set IASL_PREFIX=%EDK_WORKSPACE%\iasl-win-20180629\

cd %EDK_WORKSPACE%\%EDK_REPO%\

echo build -p EmulatorPkg\EmulatorPkg.dsc -t VS2019 -a X64 > %cd%\BuildEmulator.bat

call edksetup.bat
cmd
