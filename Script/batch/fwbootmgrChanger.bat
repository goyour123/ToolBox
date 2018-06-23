@REM =========================================================================================
@REM                                  fwbootmgrChanger
@REM =========================================================================================

@echo off

setlocal EnableDelayedExpansion

echo fwbootmgr
echo.
set getDes=false
set /a optIdx=0
for /f "tokens=1*" %%a in ('bcdedit /enum firmware') do (
  if "!getDes!" EQU "true" (
    set des=%%b
    set /a optIdx += 1
    set getDes=false
    echo !optIdx!.identifier:          !id! 
    echo   description:          !des!
    echo.
  )

  if "%%a" EQU "identifier" (
    if "%%b" NEQ "{fwbootmgr}" (
      set id=%%b
      set getDes=true
    )
  )
)

REM set getDes=false
REM for /f "tokens=1*" %%a in ('bcdedit /enum firmware') do (
REM   if "!getDes!" EQU "true" (
REM     set des=%%b
REM     set getDes=false
REM   )

REM   if "%%a" EQU "identifier" (
REM     set id=%%b
REM     set getDes=true
REM   )
REM )
pause
