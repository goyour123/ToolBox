@REM
@REM setWinDbgTgtConfig.bat - Setup WinDbg environment via USB3
@REM

bcdedit /dbgsettings usb targetname:TEST
bcdedit /set {dbgsettings} busparams 2.0.3
bcdedit /debug on
bcdedit /set testsigning on
@pause