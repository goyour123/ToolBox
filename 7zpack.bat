@REM
@REM Use 7-Zip to pack a folder without types of files in 7zpack.ini
@REM

@REM Set the folder to pack
@set folder=D:\Python\Anaconda\Jiufen
@REM Pass the folder in the same directory of 7zpack.bat to argument 1 
@if exist %1 @set folder=%cd%\%1\

@set zpath="C:\Program Files\7-Zip"
@set ignore=%cd%\7zpack.ini

@del *.7z

@for /f "delims=\ tokens=4" %%a in ("%folder%") do @set zname=%%a

@pushd %folder%
start cmd.exe /c "%zpath%\7z.exe" a -xr@%ignore% %~dp0%zname%.7z
@popd
