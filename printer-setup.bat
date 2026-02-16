@ECHO OFF

:: Change "servername" to the name of your print server
SET server=servername

SET /p printer=what is the name of the printer?: 

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
