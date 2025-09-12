@echo off
cls
title XAMPP Corrected Installation
echo ========================================
echo    XAMPP Corrected Installation
echo ========================================
echo.
echo Checking prerequisites...
echo.

:: Check if running as administrator
net session >nul 2>&1
if %errorLevel% == 0 (
    echo ✓ Running as Administrator
) else (
    echo ⚠ Not running as Administrator
    echo   Some features may not work correctly
    echo.
)

echo.
echo Downloading XAMPP installer...
echo.

:: Download XAMPP with the correct URL
powershell -Command "Invoke-WebRequest -Uri 'https://sourceforge.net/projects/xampp/files/XAMPP%20Windows/8.0.25/xampp-windows-x64-8.0.25-0-VS16-installer.exe/download' -OutFile 'xampp-installer.exe' -UserAgent 'Mozilla/5.0'"

if exist "xampp-installer.exe" (
    echo ✓ XAMPP installer downloaded successfully
    echo.
    echo Installing XAMPP...
    echo This may take several minutes. Please be patient...
    echo.
    
    :: Run installation with detailed output
    echo Starting installation process...
    xampp-installer.exe --mode unattended
    
    if %errorlevel% == 0 (
        echo.
        echo ========================================
        echo    Installation Successful!
        echo ========================================
        echo.
        echo ✓ XAMPP has been installed successfully!
        echo.
        echo Checking installation...
        timeout /t 2 /nobreak >nul
        
        if exist "C:\xampp\xampp-control.exe" (
            echo ✓ XAMPP Control Panel found
            echo.
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
            echo ⚠ XAMPP Control Panel not found in expected location
            echo   Installation may have completed with issues
            echo.
            echo Checking if XAMPP directory exists...
            if exist "C:\xampp" (
                echo ✓ XAMPP directory found
                echo   Trying to locate control panel...
                dir "C:\xampp" | findstr "xampp-control"
                if errorlevel 1 (
                    echo ⚠ Control panel executable not found
                    echo   You may need to manually locate it
                )
            ) else (
                echo ✗ XAMPP directory not found
                echo   Installation may have failed
            )
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
        echo 3. Ensure sufficient disk space is available (at least 1GB free)
        echo 4. Temporarily disable antivirus software during installation
        echo 5. Check Windows Event Viewer for detailed error information
        echo.
        echo Alternative installation methods:
        echo 1. Manually download from https://www.apachefriends.org/
        echo 2. Use the start-local-dev.bat menu option for manual installation
        echo.
    )
) else (
    echo ✗ Failed to download XAMPP installer
    echo   Please check your internet connection and try again
    echo.
    echo Alternative installation methods:
    echo 1. Manually download from https://www.apachefriends.org/
    echo 2. Use the start-local-dev.bat menu option for manual installation
    echo.
)

echo.
echo Cleaning up temporary files...
if exist "xampp-installer.exe" (
    del /q xampp-installer.exe >nul 2>&1
    echo ✓ Installer file removed
) else (
    echo ℹ Installer file already removed
)

echo.
echo Press any key to exit...
pause >nul