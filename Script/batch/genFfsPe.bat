
@if /i [%1] == [nmake] (
  @start /wait cmd.exe /c %1 %2 %3
  @if %errorlevel% neq 0 (
    @goto ERROR
  )
)

@set mkfpath=%~p3
:LOOPMKFPATH
@for /f "delims=\ tokens=1*" %%a in ("%mkfpath%") do @(
  @set pename=%%a
  @set mkfpath=%%b
  @goto LOOPMKFPATH
)

@echo %pename%

@set ffsoutpath=%cd%\BIOS
@set efipath=%~dp3OUTPUT

..\..\..\BaseTools\Bin\Win32\GenSec.exe -s EFI_SECTION_PE32 -o %ffsoutpath%\%pename%.pe %efipath%\%pename%.efi
@if %errorlevel% neq 0 (
  @goto ERROR
) else (
  @goto END
)

:ERROR
@echo FAILED!!!
@exit /b

:END
@exit /b
