@echo off
cls
title Check XAMPP Installation
echo ========================================
echo    Check XAMPP Installation
echo ========================================
echo.
echo Checking if XAMPP is installed...
echo.

if exist "C:\xampp\xampp-control.exe" (
    echo ✓ XAMPP is installed
    echo   Location: C:\xampp\
    echo.
    echo Starting XAMPP Control Panel...
    echo.
    start "" "C:\xampp\xampp-control.exe"
    echo XAMPP Control Panel started.
    echo.
    echo Next steps:
    echo 1. In XAMPP Control Panel, start Apache and MySQL services
    echo 2. Run start-local-dev.bat to continue WordPress setup
    echo.
) else (
    echo ✗ XAMPP is not installed or not found in the default location
    echo.
    echo Please:
    echo 1. Download XAMPP from https://www.apachefriends.org/download.html
    echo 2. Run the installer as Administrator
    echo 3. Install to the default location (C:\xampp\)
    echo 4. Run this script again after installation
    echo.
    echo Alternative locations to check:
    echo - C:\Program Files\xampp\
    echo - D:\xampp\
    echo - Any custom installation directory
    echo.
)

echo.
echo Press any key to exit...
pause >nul