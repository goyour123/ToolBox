@REM =========================================================================================
@REM                                autoCreateDataVolume.bat
@REM =========================================================================================
@REM This batch file would auto-create a volume named DATA with letter D from the volume with 
@REM letter C, and the letter D volume would consume half-size space of the letter C volume.
@REM This file is needed to be run as administrator.
@REM =========================================================================================

@REM Create diskpart script dpSrc.txt for getting volume infomation.
echo list volume > %~dp0dpSrc.txt

@REM Check whether the Data volume exist or not.
for /f "tokens=2-4" %%b in ('diskpart /s %~dp0dpSrc.txt^|findstr /c:" D "') do (
  if /i %%d == DATA (
    goto END
  )
  
  @REM The letter D is occupied by other volume.
  if /i %%c == D (
    set volRmLtrNum=%%b
  )
)

@REM Remove the letter D from the occupied volume. 
if defined volRmLtrNum (
  echo select volume %volRmLtrNum% > %~dp0dpSrc.txt
  echo remove letter=D >> %~dp0dpSrc.txt
  diskpart /s %~dp0dpSrc.txt
  echo list volume > %~dp0dpSrc.txt
)

@REM Get the volume number with letter C.
for /f "tokens=2-6" %%b in ('diskpart /s %~dp0dpSrc.txt^|findstr /c:" C "') do (
  if /i %%c == C (
    set cVolNum=%%b
    set cVolSize=%%f
  )
)

@REM Use half-size of letter C space.
set /a "dVolSize=(%cVolSize%/2)*1000"

@REM Rewrite the diskpart script dpSrc.txt again for creating volume.
echo select volume %cVolNum% > %~dp0dpSrc.txt
echo shrink desired=%dVolSize% >> %~dp0dpSrc.txt
echo select disk 0 >> %~dp0dpSrc.txt
echo create partition primary size=%dVolSize% >> %~dp0dpSrc.txt
diskpart /s %~dp0dpSrc.txt

@REM Rewrite the diskpart script dpSrc.txt for getting volume infomation again.
echo list volume > %~dp0dpSrc.txt

@REM Get the index number of new volume
for /f "tokens=2" %%b in ('diskpart /s %~dp0dpSrc.txt^|findstr /c:" RAW "') do (
  set dVolNum=%%b
)

@REM Format the new volume and assign letter D to it.
echo select volume %dVolNum% > %~dp0dpSrc.txt
echo format quick fs=ntfs label="DATA" >> %~dp0dpSrc.txt
echo assign letter=D >> %~dp0dpSrc.txt
diskpart /s %~dp0dpSrc.txt

:END
@REM Delete dpSrc.txt after execution.
del /q %~dp0dpSrc.txt
exit /b 0