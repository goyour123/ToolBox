@echo off
start /wait regedit.exe /e %cd%tmp.txt "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power"

for /f "tokens=2 delims=:" %%a in ('find "FwPOSTTime" %cd%tmp.txt') do set fwposttime_hex=%%a
echo %fwposttime_hex%

del /q %cd%tmp.txt
pause