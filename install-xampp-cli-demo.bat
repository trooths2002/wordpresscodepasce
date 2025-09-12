@echo off
cls
title XAMPP CLI Installation Demo
echo ========================================
echo    XAMPP CLI Installation Demo
echo ========================================
echo.
echo This script demonstrates how to install XAMPP using CLI commands.
echo.
echo Methods available:
echo 1. Direct download and silent install
echo 2. Using package managers (Chocolatey)
echo 3. Using winget (Windows Package Manager)
echo.
echo Note: This is a demo script. Actual installation requires running
echo the specific installation methods.
echo.
echo ========================================
echo    Method 1: Direct Download
echo ========================================
echo.
echo PowerShell command to download XAMPP:
echo powershell -Command "Invoke-WebRequest -Uri 'https://www.apachefriends.org/xampp-files/8.0.25/xampp-windows-x64-8.0.25-0-VS16-installer.exe' -OutFile 'xampp-installer.exe'"
echo.
echo Silent installation command:
echo xampp-installer.exe --mode unattended
echo.
echo ========================================
echo    Method 2: Chocolatey
echo ========================================
echo.
echo First install Chocolatey (if not already installed):
echo Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
echo.
echo Then install XAMPP:
echo choco install xampp -y
echo.
echo ========================================
echo    Method 3: Winget
echo ========================================
echo.
echo Install XAMPP using winget:
echo winget install -e --id XAMPP.XAMPP
echo.
echo ========================================
echo    Additional Commands
echo ========================================
echo.
echo Start XAMPP services:
echo net start xampp
echo.
echo Stop XAMPP services:
echo net stop xampp
echo.
echo ========================================
echo    Notes
echo ========================================
echo.
echo - Always run installation as Administrator
echo - Ensure Windows Defender or antivirus doesn't block installation
echo - After installation, start Apache and MySQL services via XAMPP Control Panel
echo.
echo Press any key to exit...
pause >nul