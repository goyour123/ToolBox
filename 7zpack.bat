@REM
@REM Use 7-Zip to pack a folder without types of files in 7zpack.ini
@REM

@REM Set the folder to pack
@set folder="D:\Python\Python3.5\Rabbit"
@set zpath="C:\Program Files\7-Zip"
@set ignore=%cd%\7zpack.ini

for /f "delims=\ tokens=4" %%a in (%folder%) do @set zname=%%a

cd %folder%
start cmd.exe /c "%zpath%\7z.exe" a -xr@%ignore% %zname% && move /y %cd%\%zname%.7z %~dp0