@echo off
start /wait regedit.exe /e %cd%tmp.txt "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power"

for /f "tokens=2 delims=:" %%a in ('find "FwPOSTTime" %cd%tmp.txt') do set fwposttime_hex=0x%%a

set /a fwposttime_dec=%fwposttime_hex%

echo FwPOSTTime %fwposttime_hex%(%fwposttime_dec%)

del /q %cd%tmp.txt
pause