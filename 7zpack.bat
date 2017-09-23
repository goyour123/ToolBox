@REM
@REM Use 7-Zip to pack a folder without types of files in 7zpack.ini
@REM

@set zpath="C:\Program Files\7-Zip"

@REM Check whether the arg1 is an absolute path or not
@for /f "delims=\ tokens=1" %%a in ("%1") do @(
    if %%a == C: set drive=C:
    if %%a == D: set drive=D:
    if %%a == E: set drive=E:
    if %%a == F: set drive=F:
    if %%a == G: set drive=G:
)

@set folder=%1
@if not defined drive (
    @set folder=%cd%\%1\
)

@set ignore=%cd%\7zpack.ini

@REM Extract the last item in folder path
@set looppath=%folder%
:lastitemloop
@for /f "delims=\ tokens=1*" %%a in ("%looppath%") do @(
    @set zname=%%a
    @set looppath=%%b
    goto lastitemloop
)

@REM Change path to target path
@%drive%
@cd %folder%

start cmd.exe /c "%zpath%\7z.exe" a -xr@%ignore% %~dp0%zname%.7z

@%~d0
@cd %~p0
