@echo off
cls
title XAMPP Robust Download
echo ========================================
echo    XAMPP Robust Download
echo ========================================
echo.
echo This script will try multiple sources to download XAMPP
echo.

:: List of alternative download sources
set SOURCE1=https://downloadsapachefriends.global.ssl.fastly.net/xampp-files/8.0.25/xampp-windows-x64-8.0.25-0-VS16-installer.exe?from_af=true
set SOURCE2=https://sourceforge.net/projects/xampp/files/XAMPP%20Windows/8.0.25/xampp-windows-x64-8.0.25-0-VS16-installer.exe/download
set SOURCE3=https://master.dl.sourceforge.net/project/xampp/XAMPP%20Windows/8.0.25/xampp-windows-x64-8.0.25-0-VS16-installer.exe?viasf=1

echo Trying Source 1...
echo URL: %SOURCE1%
echo.
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%SOURCE1%' -OutFile 'xampp-installer.exe' -UserAgent 'Mozilla/5.0' -TimeoutSec 30 -ErrorAction Stop"
if exist "xampp-installer.exe" (
    echo.
    echo ✓ Download successful from Source 1!
    goto :success
)

echo.
echo Source 1 failed. Trying Source 2...
echo URL: %SOURCE2%
echo.
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%SOURCE2%' -OutFile 'xampp-installer.exe' -UserAgent 'Mozilla/5.0' -TimeoutSec 30 -ErrorAction Stop"
if exist "xampp-installer.exe" (
    echo.
    echo ✓ Download successful from Source 2!
    goto :success
)

echo.
echo Source 2 failed. Trying Source 3...
echo URL: %SOURCE3%
echo.
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%SOURCE3%' -OutFile 'xampp-installer.exe' -UserAgent 'Mozilla/5.0' -TimeoutSec 30 -ErrorAction Stop"
if exist "xampp-installer.exe" (
    echo.
    echo ✓ Download successful from Source 3!
    goto :success
)

echo.
echo ========================================
echo    All download attempts failed
echo ========================================
echo.
echo Possible reasons:
echo 1. Internet connection issues
echo 2. Firewall/antivirus blocking downloads
echo 3. SourceForge download restrictions
echo 4. Temporary server issues
echo.
echo Alternative solutions:
echo 1. Manually download from https://www.apachefriends.org/download.html
echo 2. Try downloading with your web browser
echo 3. Temporarily disable antivirus during download
echo 4. Use a download manager
echo.
goto :end

:success
echo.
echo ========================================
echo    Download Successful!
echo ========================================
echo.
echo Installing XAMPP...
echo.
xampp-installer.exe --mode unattended
if %errorlevel% == 0 (
    echo.
    echo ✓ XAMPP installed successfully!
    echo.
    echo Starting XAMPP Control Panel...
    start "" "C:\xampp\xampp-control.exe"
) else (
    echo.
    echo ✗ Installation failed with error code: %errorlevel%
    echo.
    echo Please run the installer manually:
    echo Right-click on xampp-installer.exe and select "Run as administrator"
)

:end
echo.
echo Cleaning up...
del /q xampp-installer.exe >nul 2>&1
echo.
echo Press any key to exit...
pause >nul