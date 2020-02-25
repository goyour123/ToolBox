@setlocal enabledelayedexpansion

@rem Set Recovery region offset and size
@set /a recvyoffset=0x1000000+0x83A000
@set /a recvysize=0x120000

@rem Check the arguments
@if /i [%1] == [nmake] (
  @start /b /wait cmd.exe /c %1 %2 %3
  @if !errorlevel! neq 0 (
    @goto ERROR
  )
)
@echo Build process done

@rem Get the build arch
@set mkfpath=%~p3
:LOOPMKFPATH
@for /f "delims=\ tokens=1*" %%a in ("%mkfpath%") do @(
  @set pename=%%a
  @set mkfpath=%%b
  @if [%%a] equ [X64] (
    @set arch=X64
  )
  @if [%%a] equ [IA32] (
    @set arch=IA32
  )
  @goto LOOPMKFPATH
)

@rem Get pe file name
@for /f "tokens=3" %%a in ('find "MODULE_NAME" %3') do @(
  @set pename=%%a
  @goto PEDONE
)
:PEDONE

@echo IMAGE:%pename% ARCH:%arch%

@rem Get system time for naming
@for /f "tokens=1,2,3 delims=/" %%a in ("%date:~0,10%") do @(
  @set subname=%%b%%c
)
@for /f "tokens=1,2,3 delims=: " %%a in ("%time:~0,8%") do @(
  @set subname=%subname%%%a%%b%%c
)

@if [%arch%] == [IA32] (
  @echo genFfsPe IA32 process

  @rem Get the name of rom file
  @set romdir=%cd%\BIOS
  @pushd %romdir%
  @for /f "delims=" %%a in ('dir /b *.fd') do @(
    @set biosname=%%~na
    @set biossize=%%~za
    @goto ROMDONE
  )
  :ROMDONE
  @popd
  @echo Rom file name: %biosname%
  @echo Rom file size: %biossize%

  @rem Extract Recovery region
  @set /a recvyend=%recvyoffset%+%recvysize%
  @if [%biossize%] gtr [%recvyend%] (
    start /b /wait ..\..\..\BaseTools\Bin\Win32\split.exe -f %romdir%\%biosname%.fd -s %recvyoffset% -p %romdir% -o temp.fd -t temp2.fd
    start /b /wait ..\..\..\BaseTools\Bin\Win32\split.exe -f %romdir%\temp2.fd -s %recvysize% -p %romdir% -o recvyorg.fd -t temp3.fd
  ) else (
    start /b /wait ..\..\..\BaseTools\Bin\Win32\split.exe -f %romdir%\%biosname%.fd -s %recvyoffset% -p %romdir% -o temp.fd -t temp2.fd
  )
  @del /q %romdir%\temp*.fd
) else (
  @echo genFfsPe X64 process
)

@rem Gernerating the ffs
@set ffsoutpath=%cd%\BIOS
@set efipath=%~dp3OUTPUT
..\..\..\BaseTools\Bin\Win32\GenSec.exe -s EFI_SECTION_PE32 -o %ffsoutpath%\%pename%_%subname%_pe.sct %efipath%\%pename%.efi
@if %errorlevel% neq 0 (
  @goto ERROR
) else (
  @goto END
)

:ERROR
@echo FAILED!!!
@exit /b

:END
@echo %ffsoutpath%\%pename%_%subname%_pe.sct
@exit /b
