@echo off
cls
title XAMPP Silent Installation
echo ========================================
echo    XAMPP Silent Installation
echo ========================================
echo.
echo Downloading XAMPP installer...
echo.

:: Check if installer already exists
if exist "xampp-installer.exe" (
    echo XAMPP installer already downloaded.
) else (
    echo Downloading XAMPP installer...
    powershell -Command "Invoke-WebRequest -Uri 'https://www.apachefriends.org/xampp-files/8.0.25/xampp-windows-x64-8.0.25-0-VS16-installer.exe' -OutFile 'xampp-installer.exe'"
    if %errorlevel% == 0 (
        echo ✓ Download completed successfully.
    ) else (
        echo ✗ Download failed. Please check your internet connection.
        echo Press any key to exit...
        pause >nul
        exit /b
    )
)

echo.
echo Installing XAMPP silently...
echo This may take a few minutes. Please wait...
echo.

:: Run silent installation
xampp-installer.exe --mode unattended

if %errorlevel% == 0 (
    echo.
    echo ✓ XAMPP installed successfully!
    echo.
    echo Starting XAMPP Control Panel...
    echo.
    timeout /t 3 /nobreak >nul
    if exist "C:\xampp\xampp-control.exe" (
        start "" "C:\xampp\xampp-control.exe"
        echo XAMPP Control Panel started.
    ) else (
        echo XAMPP Control Panel not found. Please check installation.
    )
) else (
    echo.
    echo ✗ Installation failed with error code: %errorlevel%
    echo Please try running the installer manually.
)

echo.
echo Cleaning up installer file...
del /q xampp-installer.exe >nul 2>&1

echo.
echo ========================================
echo    Installation Process Complete
echo ========================================
echo.
echo Next steps:
echo 1. In XAMPP Control Panel, start Apache and MySQL services
echo 2. Run start-local-dev.bat to continue WordPress setup
echo.
echo Press any key to exit...
pause >nul