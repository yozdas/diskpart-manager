@echo off
setlocal enabledelayedexpansion

:: Administrator check
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo You must run this script AS ADMINISTRATOR!
    pause
    exit /b
)

:main
cls
echo ******************************
echo *      DISKPART MANAGER      *
echo ******************************
echo.
echo 1. List Disks
echo 2. Format Disk
echo 3. Change Attributes
echo 4. Exit
echo.
echo Press CTRL+C at any time to quit
echo.
set /p choice="Enter your choice (1-4): "

if "%choice%"=="1" goto list_disks
if "%choice%"=="2" goto format_disk
if "%choice%"=="3" goto change_attr
if "%choice%"=="4" exit
echo Invalid selection! Please enter 1-4.
timeout /t 2 >nul
goto main

:list_disks
cls
echo Listing disks...
echo list disk | diskpart | findstr /r /c:"Disk [0-9]"
echo.
echo Press ANY KEY to return to main menu, or CTRL+C to exit
pause >nul
goto main

:format_disk
cls
echo list disk | diskpart | findstr /r /c:"Disk [0-9]"
echo.
echo Enter 'B' at any time to return to main menu
echo.

:get_diskno
set /p "diskno=Enter disk number: "
if not defined diskno goto get_diskno
if /i "%diskno%"=="B" goto main
echo %diskno%|findstr /r "^[0-9][0-9]*$" >nul
if %errorLevel% neq 0 (
    echo Invalid disk number! Numbers only.
    goto get_diskno
)

:get_fs
set /p "fs=File system (NTFS/FAT32/exFAT): "
if not defined fs goto get_fs
if /i "%fs%"=="B" goto main
set "fs=!fs: =!" & set "fs=!fs: =!"
for %%A in (NTFS FAT32 exFAT) do if /i "!fs!"=="%%A" set fs=%%A & goto fs_ok
echo Invalid file system! Valid options: NTFS, FAT32, exFAT
goto get_fs
:fs_ok

set /p "label=Volume label (max 32 chars): "
if /i "!label!"=="B" goto main

:get_unit
set /p "unit=Allocation unit size (default: leave blank): "
if /i "!unit!"=="B" goto main
if defined unit (
    echo !unit!|findstr /r "^[0-9][0-9]*$" >nul
    if %errorLevel% neq 0 (
        echo Invalid unit size! Numbers only.
        goto get_unit
    )
    set "unit=unit=!unit!"
)

:get_quick
set /p "quick=Quick format? (Y/N): "
if /i "%quick%"=="B" goto main
if /i "!quick!"=="Y" set "quick=quick"
if /i "!quick!"=="N" set "quick="
if not defined quick (
    echo Invalid choice! Enter Y or N.
    goto get_quick
)

:confirm_format
set /p "confirm=WARNING! ALL DATA ON DISK !diskno! WILL BE PERMANENTLY DELETED! Continue? (Y/N): "
if /i "%confirm%"=="B" goto main
if /i "!confirm!"=="N" goto main
if /i not "!confirm!"=="Y" (
    echo Invalid choice! Enter Y or N.
    goto confirm_format
)

:: System disk protection
set "sysdisk="
for /f "tokens=2,3" %%a in ('echo list disk ^| diskpart') do (
    if "%%a"=="Disk" if "%%b"=="!diskno!" (
        echo list disk | diskpart | findstr /c:"%%a %%b" | findstr /c:"*" >nul
        if !errorlevel! == 0 set "sysdisk=yes"
    )
)
if defined sysdisk (
    echo ERROR: Disk !diskno! is marked as SYSTEM DISK!
    echo Cannot format system disk!
    timeout /t 3 >nul
    goto main
)

(
    echo select disk !diskno!
    echo clean
    echo create partition primary
    echo format fs=!fs! label="!label!" !unit! !quick!
    echo assign
) > format_script.txt

diskpart /s format_script.txt
if %errorLevel% neq 0 echo ERROR: Formatting failed!
del format_script.txt
echo Formatting completed.
timeout /t 2 >nul
goto main

:change_attr
cls
echo list disk | diskpart | findstr /r /c:"Disk [0-9]"
echo.
echo Enter 'B' at any time to return to main menu
echo.

:get_attr_diskno
set /p "diskno=Enter disk number: "
if not defined diskno goto get_attr_diskno
if /i "%diskno%"=="B" goto main
echo %diskno%|findstr /r "^[0-9][0-9]*$" >nul
if %errorLevel% neq 0 (
    echo Invalid disk number! Numbers only.
    goto get_attr_diskno
)

:get_attr
set /p "attr=Attribute to change (READONLY/HIDDEN/OFFLINE): "
if not defined attr goto get_attr
if /i "%attr%"=="B" goto main
for %%A in (READONLY HIDDEN OFFLINE) do if /i "!attr!"=="%%A" set attr=%%A & goto attr_ok
echo Invalid attribute! Valid options: READONLY, HIDDEN, OFFLINE
goto get_attr
:attr_ok

:get_operation
set /p "operation=Operation (SET/CLEAR): "
if /i "%operation%"=="B" goto main
if /i "!operation!"=="SET" set "operation=SET"
if /i "!operation!"=="CLEAR" set "operation=CLEAR"
if not defined operation (
    echo Invalid operation! Enter SET or CLEAR.
    goto get_operation
)

:confirm_attr
set /p "confirm=Disk !diskno!: !operation! !attr! attribute. Continue? (Y/N): "
if /i "%confirm%"=="B" goto main
if /i "!confirm!"=="N" goto main
if /i not "!confirm!"=="Y" (
    echo Invalid choice! Enter Y or N.
    goto confirm_attr
)

:: System disk warning for attribute change
set "sysdisk="
for /f "tokens=2,3" %%a in ('echo list disk ^| diskpart') do (
    if "%%a"=="Disk" if "%%b"=="!diskno!" (
        echo list disk | diskpart | findstr /c:"%%a %%b" | findstr /c:"*" >nul
        if !errorlevel! == 0 set "sysdisk=yes"
    )
)
if defined sysdisk (
    echo WARNING: Disk !diskno! is SYSTEM DISK!
    set /p "continue=Changing attributes may cause system instability! Continue? (Y/N): "
    if /i not "!continue!"=="Y" goto main
)

(
    echo select disk !diskno!
    echo attributes disk !operation! !attr!
) > attr_script.txt

diskpart /s attr_script.txt
if %errorLevel% neq 0 echo ERROR: Attribute change failed!
del attr_script.txt
echo Attribute change completed.
timeout /t 2 >nul
goto main
