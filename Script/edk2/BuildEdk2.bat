@REM
@REM BuildEdk2.bat - Setup EDK2 build environment
@REM

@echo off

set EDK_DRIVE=%~d0
set EDK_WORKSPACE=%CD%
set EDK_REPO=edk2

set PYTHON_HOME=C:\Python27
set CYGWIN_HOME=C:\cygwin64

set QEMU_HOME=C:\Program Files\qemu
@for /f "delims=\ tokens=1" %%a in ("%QEMU_HOME%") do @set QEMU_DRIVE=%%a

@REM set EDK_TOOLS_BIN=%EDK_WORKSPACE%\edk2-BaseTools-win32
set NASM_PREFIX=%EDK_WORKSPACE%\nasm-2.14.02\
set IASL_PREFIX=%EDK_WORKSPACE%\iasl-win-20180629\

cd %EDK_WORKSPACE%\%EDK_REPO%\


@REM Build EmulatorPkg setting
set EMU_TOOL_CHAIN=VS2019
set EMU_ARCH=X64
set EMU_TARGET=DEBUG
@REM Gen BuildEmulator.bat
echo build -p EmulatorPkg\EmulatorPkg.dsc -t %EMU_TOOL_CHAIN% -a %EMU_ARCH% -b %EMU_TARGET% > %cd%\BuildEmulator.bat
@REM Gen BuildOvmf.bat
echo build -p OvmfPkg\OvmfPkgX64.dsc -t %EMU_TOOL_CHAIN% -a %EMU_ARCH% -b %EMU_TARGET% > %cd%\BuildOvmf.bat

@REM Gen RunEmulator.bat
echo pushd %cd%\Build\Emulator%EMU_ARCH%\%EMU_TARGET%_%EMU_TOOL_CHAIN%\%EMU_ARCH% > %cd%\RunEmulator.bat
echo %cd%\Build\Emulator%EMU_ARCH%\%EMU_TARGET%_%EMU_TOOL_CHAIN%\%EMU_ARCH%\WinHost.exe >> %cd%\RunEmulator.bat
echo popd >> %cd%\RunEmulator.bat
@REM Gen RunOvmf.bat
echo pushd %QEMU_HOME% > %cd%\RunOvmf.bat
echo %QEMU_DRIVE% >> %cd%\RunOvmf.bat
echo start qemu-system-x86_64.exe -bios %EDK_WORKSPACE%\%EDK_REPO%\Build\Ovmf%EMU_ARCH%\%EMU_TARGET%_%EMU_TOOL_CHAIN%\FV\OVMF.fd >> %cd%\RunOvmf.bat
echo popd >> %cd%\RunOvmf.bat
echo %EDK_DRIVE% >> %cd%\RunOvmf.bat

call edksetup.bat
cmd
