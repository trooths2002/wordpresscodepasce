@echo off
cls
title Check Available CLI Installation Methods
echo ========================================
echo    Check Available CLI Installation Methods
echo ========================================
echo.
echo This script checks which CLI tools are available for XAMPP installation.
echo.
echo Checking PowerShell...
powershell -Command "Write-Host 'PowerShell version:' (Get-Host).Version"
if %errorlevel% == 0 (
    echo ✓ PowerShell is available
) else (
    echo ✗ PowerShell is not available
)
echo.

echo Checking Chocolatey...
choco --version >nul 2>&1
if %errorlevel% == 0 (
    echo ✓ Chocolatey is available
    for /f "tokens=*" %%i in ('choco --version') do echo   Version: %%i
) else (
    echo ✗ Chocolatey is not available
)
echo.

echo Checking Winget...
winget --version >nul 2>&1
if %errorlevel% == 0 (
    echo ✓ Winget is available
    for /f "tokens=*" %%i in ('winget --version') do echo   Version: %%i
) else (
    echo ✗ Winget is not available
)
echo.

echo Checking WSL...
wsl --version >nul 2>&1
if %errorlevel% == 0 (
    echo ✓ WSL is available
    for /f "tokens=*" %%i in ('wsl --version') do echo   Version: %%i
) else (
    echo ✗ WSL is not available (or not installed)
)
echo.

echo ========================================
echo    Available Installation Methods
echo ========================================
echo.
if %errorlevel% == 0 (
    echo ✓ Direct PowerShell Download and Silent Install: AVAILABLE
) else (
    echo ✗ Direct PowerShell Download and Silent Install: MAYBE AVAILABLE
)
echo.

choco --version >nul 2>&1
if %errorlevel% == 0 (
    echo ✓ Chocolatey Installation: AVAILABLE
    echo   Run: choco install xampp -y
) else (
    echo ✗ Chocolatey Installation: NOT AVAILABLE
    echo   Install Chocolatey first, then use this method
)
echo.

winget --version >nul 2>&1
if %errorlevel% == 0 (
    echo ✓ Winget Installation: AVAILABLE
    echo   Run: winget install -e --id XAMPP.XAMPP
) else (
    echo ✗ Winget Installation: NOT AVAILABLE
    echo   Winget may be available in newer Windows versions
)
echo.

wsl --version >nul 2>&1
if %errorlevel% == 0 (
    echo ✓ WSL Installation: AVAILABLE
    echo   Run: wsl sudo apt install apache2 mysql-server php
) else (
    echo ✗ WSL Installation: NOT AVAILABLE
    echo   Enable WSL feature and install a Linux distribution
)
echo.

echo ========================================
echo    Recommended Next Steps
echo ========================================
echo.
echo 1. For immediate installation, use Direct PowerShell method
echo 2. For package management, install Chocolatey first
echo 3. For Windows 10/11, check if Winget is available
echo 4. For development environment, consider WSL
echo.
echo Press any key to exit...
pause >nul