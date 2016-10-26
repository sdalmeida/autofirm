@ECHO off
:: Checking if all files are present
IF NOT EXIST "nand.bin" (
    color 4
    echo nand.bin was out found!
    echo Please place "nand.bin" in this folder
    pause
    exit /b 1
)
color 3
ECHO.
ECHO                        ----------------------------------
ECHO                        *  3DS AUTOFIRM - GUIDE EDITION  *
ECHO                        ----------------------------------
ECHO.
ECHO.
ECHO    INSTRUCTIONS:
ECHO.
ECHO  - NAND.BIN file should be in the same folder as this .bat
ECHO    You can extract it from your 3DS/2DS via a hardmod.
ECHO    Hardmod Guide: https://gbatemp.net/threads/414498/
ECHO.
ECHO  - Decrypted NATIVE-FIRMs should be in the "source\firmwares\" folder.
ECHO    You can download the files from https://git.io/vo5OS
ECHO.
ECHO.
ECHO.
ECHO Press any button only when you are sure that everything's ready
pause
cls
ECHO.
ECHO                        ----------------------------------
ECHO                        *  3DS AUTOFIRM - GUIDE EDITION  *
ECHO                        ----------------------------------
ECHO.
ECHO.
ECHO    SELECT YOUR 3DS/2DS MODEL AND VERSION:
ECHO.
ECHO  1) 11.0.0 - OLD 3DS/XL or 2DS
ECHO.
ECHO  2) 11.1.0 - OLD 3DS/XL or 2DS
ECHO.
ECHO. 3) 11.2.0 - OLD 3DS/XL or 2DS
ECHO.
ECHO  4) 11.0.0 - NEW 3DS/XL
ECHO.
ECHO  5) 11.1.0 - NEW 3DS/XL
ECHO.
ECHO  6) 11.1.0 - NEW 3DS/XL
ECHO.
ECHO.
ECHO.
SET /p option= Please enter one of the options:
IF "%option%"=="1" (
    SET firm0="source\firmwares\firm110_OLD.bin"
    SET firm1="source\firmwares\firm104_OLD.bin"
) ELSE IF "%option%"=="2" (
    SET firm0="source\firmwares\firm111_OLD.bin"
    SET firm1="source\firmwares\firm104_old.bin"
) ELSE IF "%option%"=="3" (
    SET firm0="source\firmwares\firm112_OLD.bin"
    SET firm1="source\firmwares\firm104_OLD.bin"
) ELSE IF "%option%"=="4" (
    SET firm0="source\firmwares\firm110_NEW.bin"
    SET firm1="source\firmwares\firm104_NEW.bin"
) ELSE IF "%option%"=="5" (
    SET firm0="source\firmwares\firm111_NEW.bin"
    SET firm1="source\firmwares\firm104_NEW.bin"
) ELSE IF "%option%"=="6" (
    SET firm0="source\firmwares\firm112_NEW.bin"
    SET firm1="source\firmwares\firm104_NEW.bin"
) ELSE (
    exit /b 1
)
cls
IF NOT EXIST %firm0% (
    goto firmError
)
ECHO Creating a backup copy of the nand.bin file...
copy nand.bin source\nand.bin
ECHO Done.
ECHO [** Running 3DSFirm.exe **] > log.txt
source\3DSFirm.exe -d source\nand.bin source\tmp\firm0.bin source\tmp\firm1.bin >> log.txt
IF ERRORLEVEL 1 GOTO error
ECHO [** Success! **] >> log.txt
ECHO [** Running 1st XOR **] >> log.txt
source\xor source\tmp\firm0.bin %firm0% >> log.txt
IF ERRORLEVEL 1 GOTO error
ECHO [** Success! **] >> log.txt
ECHO [** Running 2nd XOR **] >> log.txt
source\xor source\tmp\firm0.bin.out %firm1% >> log.txt
IF ERRORLEVEL 1 GOTO error
ECHO [** Success! **] >> log.txt
ECHO [** Running 3rd XOR **] >> log.txt
source\xor source\tmp\firm1.bin %firm0% >> log.txt
IF ERRORLEVEL 1 GOTO error
ECHO [** Success! **] >> log.txt
ECHO [** Running 4th XOR **] >> log.txt
source\xor source\tmp\firm1.bin.out %firm1% >> log.txt
IF ERRORLEVEL 1 GOTO error
ECHO [** Success! **] >> log.txt
ECHO [** Renaming files **] >> log.txt
ren source\tmp\firm0.bin.out.out firm0new.bin
ren source\tmp\firm1.bin.out.out firm1new.bin
ECHO [** Success! **] >> log.txt
ECHO [** Running final 3DSFirm.exe **] >> log.txt
source\3DSFirm.exe -i source\nand.bin source\tmp\firm0new.bin source\tmp\firm1new.bin >> log.txt
IF ERRORLEVEL 1 GOTO error
ECHO [** Success! **] >> log.txt
move /Y source\nand.bin nand_patched.bin
del /F /Q source\tmp\*.bin*
ECHO [** Temp files deleted **] >> log.txt
cls
ECHO.
ECHO                        ----------------------------------
ECHO                        *  3DS AUTOFIRM - GUIDE EDITION  *
ECHO                        ----------------------------------
ECHO.
ECHO.
ECHO    A patched "NAND.BIN" file has been generated.
ECHO    Please flash "nand_patched.bin" back to your 3DS/2DS.
ECHO.
ECHO    If something goes wrong, you can restore the "backup_nand.bin" file
ECHO    on your 3DS/2DS in order to return on a working firmware.
ECHO.
ECHO    This batch file is based on the REBOOT.MS's Autofirm.
ECHO    REBOOT.MS's Autofirm is based on the Raugo's original Autofirm.
ECHO.
pause
exit

:error
    color 4
    cls
    ECHO [** Error! **] >> log.txt
    ECHO.
    ECHO                        ----------------------------------
    ECHO                        *  3DS AUTOFIRM - GUIDE EDITION  *
    ECHO                        ----------------------------------
    ECHO.
    ECHO.
    ECHO    Something went wrong! Do not flash "nand_patched.bin" to your system!
    ECHO    If you do, your system will be bricked!
    ECHO    Please look at the "log.txt" file to see where the error occured!
    ECHO    If you need help, go to "gbatemp.net" and include the "log.txt" file.
    ECHO.
    pause
    exit /b 1

:firmError
    color 4
    cls
    ECHO [** Error! %firm0% doesn't exist! **] >> log.txt
    ECHO.
    ECHO                        ----------------------------------
    ECHO                        *  3DS AUTOFIRM - GUIDE EDITION  *
    ECHO                        ----------------------------------
    ECHO.
    ECHO.
    ECHO    I could not find FIRM file %firm0%!
    ECHO    Do not flash "nand_patched.bin" to your system!
    ECHO    If you do, your system will be bricked!
    ECHO    Please download the necessary FIRM file from: https://git.io/vo5OS
    ECHO.
    pause
    exit /b 1
