@ECHO OFF

:: Change "servername" to the name of your print server
SET server=servername

(powershell.exe -NoProfile -Command "& {Get-Printer -ComputerName "$printserver" | Select-Object -ExpandProperty Name}")> "printerlist.txt" 2>&1

SET /p printer=what is the name of the printer?: 

FOR /F "tokens=*" %%A IN ('FINDSTR /i /C:%printer% printerlist.txt') DO SET printer=%%A

SET choice=
SET /p choice=Is "%printer%" correct? [Y/N]: 
IF NOT '%choice%'=='' SET choice=%choice:~0,1%
IF '%choice%'=='Y' GOTO yes
IF '%choice%'=='y' GOTO yes
IF '%choice%'=='N' GOTO no
IF '%choice%'=='n' GOTO no
IF '%choice%'=='' GOTO no
ECHO "%choice%" is not valid
ECHO.
GOTO START

:no
%0

:yes
rundll32 printui.dll PrintUIEntry /in /n\\%server%\%printer%
ECHO Printer "%printer%" has been set up
PAUSE
EXIT
