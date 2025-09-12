@echo off
cls
title XAMPP Installation
echo ========================================
echo    XAMPP Installation
echo ========================================
echo.
echo XAMPP installer has been downloaded.
echo.
echo Installing XAMPP silently...
echo This may take a few minutes. Please wait...
echo.

:: Run silent installation
xampp-installer.exe --mode unattended

if %errorlevel% == 0 (
    echo.
    echo ========================================
    echo    XAMPP Installation Complete!
    echo ========================================
    echo.
    echo ✓ XAMPP has been installed successfully!
    echo.
    echo Starting XAMPP Control Panel...
    echo.
    timeout /t 3 /nobreak >nul
    if exist "C:\xampp\xampp-control.exe" (
        echo Launching XAMPP Control Panel...
        start "" "C:\xampp\xampp-control.exe"
        echo.
        echo XAMPP Control Panel has been launched.
        echo.
        echo Next steps:
        echo 1. In XAMPP Control Panel, start Apache and MySQL services
        echo 2. Run start-local-dev.bat to continue WordPress setup
        echo.
    ) else (
        echo.
        echo XAMPP was installed but Control Panel not found.
        echo Please check if installation completed correctly.
        echo.
    )
) else (
    echo.
    echo ========================================
    echo    Installation Failed
    echo ========================================
    echo.
    echo ✗ Installation failed with error code: %errorlevel%
    echo.
    echo Troubleshooting tips:
    echo 1. Try running this script as Administrator
    echo 2. Check if another XAMPP installation exists
    echo 3. Ensure sufficient disk space is available
    echo 4. Check Windows Defender or antivirus settings
    echo.
)

echo.
echo Cleaning up installer file...
del /q xampp-installer.exe >nul 2>&1

echo.
echo Press any key to exit...
pause >nul