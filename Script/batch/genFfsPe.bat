

@rem Check the arguments
@if /i [%1] == [nmake] (
  @start /wait cmd.exe /c %1 %2 %3
  @if %errorlevel% neq 0 (
    @goto ERROR
  )
)

@rem Get the pe file name
@set mkfpath=%~p3
:LOOPMKFPATH
@for /f "delims=\ tokens=1*" %%a in ("%mkfpath%") do @(
  @set pename=%%a
  @set mkfpath=%%b
  @goto LOOPMKFPATH
)
@echo %pename%

@rem Get system time for naming
@for /f "tokens=1,2,3 delims=/" %%a in ("%date:~0,10%") do @(
  set subname=%%b%%c
)
@for /f "tokens=1,2,3 delims=: " %%a in ("%time:~0,8%") do @(
  set subname=%subname%%%a%%b%%c
)

@rem Gernerating the ffs
@set ffsoutpath=%cd%\BIOS
@set efipath=%~dp3OUTPUT
..\..\..\BaseTools\Bin\Win32\GenSec.exe -s EFI_SECTION_PE32 -o %ffsoutpath%\%pename%_%subname%.pe %efipath%\%pename%.efi
@if %errorlevel% neq 0 (
  @goto ERROR
) else (
  @goto END
)

:ERROR
@echo FAILED!!!
@exit /b

:END
@echo %ffsoutpath%\%pename%_%subname%.pe
@exit /b
