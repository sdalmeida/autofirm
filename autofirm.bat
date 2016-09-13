@ECHO off
ECHO.
ECHO    ----------------------------------
ECHO    *  3DS AUTOFIRM - GUIDE EDITION  *
ECHO    ----------------------------------
ECHO.
ECHO.
ECHO    INSTRUCTIONS:
ECHO.
ECHO  - NAND.BIN file should be in the same folder of this .bat
ECHO    You can extract it from your 3DS via a hardmod.
ECHO    Hardmod Guide: https://gbatemp.net/threads/414498/
ECHO.
ECHO  - All decrypted NATIVE-FIRMs should be in the same folder too.
ECHO    You can download the files from https://git.io/vo5OS
ECHO.
ECHO.
ECHO.
ECHO Press a button only when you are sure that everything's ready
pause
cls
ECHO.
ECHO    ----------------------------------
ECHO    *  3DS AUTOFIRM - GUIDE EDITION  *
ECHO    ----------------------------------
ECHO.
ECHO.
ECHO    SELECT YOUR 3DS MODEL AND VERSION:
ECHO.
ECHO  1) 11.0.0 - OLD 3DS/XL or 2DS
ECHO.
ECHO  2) 11.0.0 - NEW 3DS/XL
ECHO.    
ECHO  3) 11.1.0 - OLD 3DS/XL or 2DS
ECHO.
ECHO  4) 11.1.0 - NEW 3DS/XL
ECHO.    
ECHO.    
ECHO.      
SET /p option= Please enter one of the options:

if %option%==1  ( goto old3ds110 )
if %option%==2  ( goto new3ds110 )
if %option%==3  ( goto old3ds111 )
if %option%==4  ( goto new3ds111 )
:old3ds110
cls
ECHO Creating a backup copy of the nand.bin file...
copy nand.bin backup_nand.bin
ECHO Done.
3DSFirm.exe -d nand.bin firm0.bin firm1.bin
xor firm0.bin firm110_OLD.bin
xor firm0.bin.out firm104_OLD.bin
xor firm1.bin firm110_OLD.bin
xor firm1.bin.out firm104_OLD.bin
rename firm0.bin.out.out firm0new.bin
rename firm1.bin.out.out firm1new.bin
3DSFirm.exe -i nand.bin firm0new.bin firm1new.bin
del *.out
goto end
:new3ds110
cls
ECHO Creating a backup copy of the nand.bin file...
copy nand.bin backup_nand.bin
ECHO Done.
3DSFirm.exe -d nand.bin firm0.bin firm1.bin
xor firm0.bin firm110_NEW.bin
xor firm0.bin.out firm104_NEW.bin
xor firm1.bin firm110_NEW.bin
xor firm1.bin.out firm104_NEW.bin
rename firm0.bin.out.out firm0new.bin
rename firm1.bin.out.out firm1new.bin
3DSFirm.exe -i nand.bin firm0new.bin firm1new.bin
del *.out
goto end
:old3ds111
cls
ECHO Creating a backup copy of the nand.bin file...
copy nand.bin backup_nand.bin
ECHO Done.
3DSFirm.exe -d nand.bin firm0.bin firm1.bin
xor firm0.bin firm111_OLD.bin
xor firm0.bin.out firm104_OLD.bin
xor firm1.bin firm111_OLD.bin
xor firm1.bin.out firm104_OLD.bin
rename firm0.bin.out.out firm0new.bin
rename firm1.bin.out.out firm1new.bin
3DSFirm.exe -i nand.bin firm0new.bin firm1new.bin
del *.out
goto end
:new3ds111
cls
ECHO Creating a backup copy of the nand.bin file...
copy nand.bin backup_nand.bin
ECHO Done.
3DSFirm.exe -d nand.bin firm0.bin firm1.bin
xor firm0.bin firm111_NEW.bin
xor firm0.bin.out firm104_NEW.bin
xor firm1.bin firm111_NEW.bin
xor firm1.bin.out firm104_NEW.bin
rename firm0.bin.out.out firm0new.bin
rename firm1.bin.out.out firm1new.bin
3DSFirm.exe -i nand.bin firm0new.bin firm1new.bin
del *.out
goto end
:end
cls
ECHO.
ECHO    ----------------------------------
ECHO    *  3DS AUTOFIRM - GUIDE EDITION  *
ECHO    ----------------------------------
ECHO.
ECHO.
ECHO    A patched NAND.BIN file has been generated.
ECHO    please re-flash it back on your 3DS 
ECHO.
ECHO    If something goes wrong, you can restore the backup_nand.bin file on your 3DS
ECHO    in order to return on a working firmware.
ECHO.
ECHO    This batch file is based on the REBOOT.MS's Autofirm.
ECHO    REBOOT.MS's Autofirm is based on the Raugo's original Autofirm.
pause

