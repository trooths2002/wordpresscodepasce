@echo off
title The Righteous Teachers - Local Development Environment Setup
echo ========================================
echo The Righteous Teachers - Local Development Environment
echo ========================================
echo.

echo Checking system requirements...
echo.

echo PHP Version:
php -v >nul 2>&1
if %errorlevel% == 0 (
    for /f "tokens=*" %%i in ('php -v') do echo %%i
) else (
    echo ❌ PHP not found in PATH
    echo    You need to install PHP or add it to your PATH
    echo.
)

echo.
echo WP-CLI Version:
wp --version >nul 2>&1
if %errorlevel% == 0 (
    for /f "tokens=*" %%i in ('wp --version') do echo %%i
) else (
    echo ❌ WP-CLI not found
    echo    Using local wp-cli.phar
    php wp-cli.phar --version
)

echo.
echo ========================================
echo.

echo Available Setup Options:
echo 1. Quick Local Development with PHP Built-in Server
echo 2. Install XAMPP (Recommended for full WordPress features)
echo 3. Automated WordPress Setup (Requires XAMPP)
echo 4. Check existing local WordPress installations
echo 5. Exit
echo.

choice /c 12345 /m "Select an option"
if errorlevel 5 goto :exit
if errorlevel 4 goto :check_existing
if errorlevel 3 goto :automated_setup
if errorlevel 2 goto :install_xampp
if errorlevel 1 goto :quick_setup

:quick_setup
echo.
echo Setting up quick local development environment...
echo.

echo Creating local test directory...
if not exist "C:\Users\tjd20.LAPTOP-PCMC2SUO\wordpress-local-test" (
    mkdir "C:\Users\tjd20.LAPTOP-PCMC2SUO\wordpress-local-test"
    echo ✅ Created wordpress-local-test directory
) else (
    echo ✅ wordpress-local-test directory already exists
)

echo.
echo To start a simple PHP server:
echo 1. Navigate to your WordPress files directory
echo 2. Run: php -S localhost:8000
echo.
echo Note: This is limited and WordPress may not work fully with built-in server
echo For full WordPress functionality, install XAMPP (Option 2)
echo.
echo Alternative: Use WSL for development environment
echo Run: start-wsl-environment.bat
echo.
pause
goto :menu

:install_xampp
echo.
echo XAMPP Installation Options:
echo =========================
echo 1. Manual Installation (Download and install manually)
echo 2. Silent Installation (Automated download and install)
echo 3. Chocolatey Installation (Requires Chocolatey)
echo 4. Use WSL instead of XAMPP (Recommended if download fails)
echo 5. Low Disk Space Solutions (Recommended for current situation)
echo 6. Back to main menu
echo.

choice /c 123456 /m "Select installation method"
if errorlevel 6 goto :menu
if errorlevel 5 goto :low_disk_space_solutions
if errorlevel 4 goto :wsl_setup
if errorlevel 3 goto :choco_install
if errorlevel 2 goto :silent_install
if errorlevel 1 goto :manual_install

:low_disk_space_solutions
echo.
echo Low Disk Space Solutions:
echo =======================
echo.
echo You have approximately 24.5 GB free space, which may not be sufficient for XAMPP.
echo Here are alternative approaches that require less disk space:
echo.
echo 1. Use WSL with lightweight components (Recommended)
echo 2. Free up disk space with cleanup tools
echo 3. Use GitHub Codespaces (cloud-based development)
echo.
echo For immediate WordPress development with minimal space requirements:
echo Run: setup-wsl-wordpress.bat
echo.
echo To free up disk space:
echo Run: cleanup-disk-space.bat
echo.
echo For cloud-based development with GitHub Codespaces:
echo 1. Fork repository: https://github.com/zerasul/wordpresscodepasce
echo 2. Create a codespace from your fork
echo 3. Check: GITHUB_CODESPACES_WORDPRESS_GUIDE.md
echo.
echo For detailed solutions, see: LOW_DISK_SPACE_SOLUTIONS_SUMMARY.md
echo.
pause
goto :menu

:wsl_setup
echo.
echo Setting up WordPress development environment with WSL...
echo.
echo This option uses Windows Subsystem for Linux instead of XAMPP.
echo.
call start-wsl-environment.bat
goto :menu

:manual_install
echo.
echo Manual XAMPP Installation:
echo =========================
echo 1. Visit: https://www.apachefriends.org/index.html
echo 2. Download the Windows version
echo 3. Run the installer as Administrator
echo 4. Select components: Apache, MySQL, PHP, phpMyAdmin
echo 5. Complete installation
echo.
echo For detailed instructions, see: MANUAL_XAMPP_INSTALLATION_GUIDE.md
echo If you're having download issues, see: XAMPP_DOWNLOAD_TROUBLESHOOTING.md
echo.
echo After installation:
echo 1. Start Apache and MySQL services in XAMPP Control Panel
echo 2. Place WordPress files in C:\xampp\htdocs\therighteousteachers
echo 3. Access at: http://localhost/therighteousteachers
echo.
pause
goto :menu

:silent_install
echo.
echo Silent XAMPP Installation:
echo =========================
echo Running robust installation script...
echo.
call install-xampp-robust.bat
goto :menu

:choco_install
echo.
echo Chocolatey XAMPP Installation:
echo =============================
echo For CLI installation methods, see: XAMPP_CLI_INSTALLATION_GUIDE.md
echo.
echo Running Chocolatey installation script...
echo.
powershell -ExecutionPolicy Bypass -File "install-xampp-with-choco.ps1"
goto :menu

:automated_setup
echo.
echo Running Automated WordPress Setup...
echo This will download and configure WordPress automatically.
echo.
echo Prerequisite: XAMPP must be installed and running.
echo.
powershell -ExecutionPolicy Bypass -File "automate-wordpress-setup.ps1"
goto :menu

:check_existing
echo.
echo Checking for existing WordPress installations...
echo.

if exist "C:\Users\tjd20.LAPTOP-PCMC2SUO\local-wordpress" (
    echo ✅ Found: local-wordpress directory
    dir "C:\Users\tjd20.LAPTOP-PCMC2SUO\local-wordpress" >nul 2>&1
    if not errorlevel 1 (
        echo    Contents:
        dir "C:\Users\tjd20.LAPTOP-PCMC2SUO\local-wordpress" | findstr "wp-config"
        if errorlevel 1 (
            echo    No wp-config.php found - directory may be empty
        ) else (
            echo    wp-config.php found - WordPress installation detected
        )
    ) else (
        echo    Directory exists but is empty or inaccessible
    )
) else (
    echo ❌ local-wordpress directory not found
)

if exist "C:\Users\tjd20.LAPTOP-PCMC2SUO\wordpress" (
    echo ✅ Found: wordpress directory
    dir "C:\Users\tjd20.LAPTOP-PCMC2SUO\wordpress" >nul 2>&1
    if not errorlevel 1 (
        echo    Contents:
        dir "C:\Users\tjd20.LAPTOP-PCMC2SUO\wordpress" | findstr "wp-config"
        if errorlevel 1 (
            echo    No wp-config.php found - directory may be empty
        ) else (
            echo    wp-config.php found - WordPress installation detected
        )
    ) else (
        echo    Directory exists but is empty or inaccessible
    )
) else (
    echo ❌ wordpress directory not found
)

if exist "C:\Users\tjd20.LAPTOP-PCMC2SUO\wordpress-local-test" (
    echo ✅ Found: wordpress-local-test directory
    dir "C:\Users\tjd20.LAPTOP-PCMC2SUO\wordpress-local-test" >nul 2>&1
    if not errorlevel 1 (
        echo    Contents:
        dir "C:\Users\tjd20.LAPTOP-PCMC2SUO\wordpress-local-test" | findstr "wp-config"
        if errorlevel 1 (
            echo    No wp-config.php found - directory may be empty
        ) else (
            echo    wp-config.php found - WordPress installation detected
        )
    ) else (
        echo    Directory exists but is empty or inaccessible
    )
) else (
    echo ❌ wordpress-local-test directory not found
)

echo.
pause
goto :menu

:menu
echo.
echo ========================================
echo What would you like to do next?
echo ========================================
echo 1. View Quick Start Guide (LOCAL_STAGING_QUICK_START.md)
echo 2. View Detailed Setup Guide (LOCAL_STAGING_SETUP.md)
echo 3. View Implementation Action Plan (IMPLEMENTATION_ACTION_PLAN.md)
echo 4. View Manual XAMPP Installation Guide (MANUAL_XAMPP_INSTALLATION_GUIDE.md)
echo 5. View XAMPP Download Troubleshooting Guide (XAMPP_DOWNLOAD_TROUBLESHOOTING.md)
echo 6. View Low Disk Space Solutions (LOW_DISK_SPACE_SOLUTIONS_SUMMARY.md)
echo 7. Run this setup again
echo 8. Exit
echo.

choice /c 12345678 /m "Select an option"
if errorlevel 8 goto :exit
if errorlevel 7 goto :start
if errorlevel 6 goto :view_low_disk_space
if errorlevel 5 goto :view_xampp_troubleshooting
if errorlevel 4 goto :view_manual_xampp
if errorlevel 3 goto :view_action_plan
if errorlevel 2 goto :view_detailed
if errorlevel 1 goto :view_quick

:view_low_disk_space
echo.
echo Opening Low Disk Space Solutions...
echo Please check the file: LOW_DISK_SPACE_SOLUTIONS_SUMMARY.md
echo.
pause
goto :menu

:view_quick
echo.
echo Opening Quick Start Guide...
echo Please check the file: LOCAL_STAGING_QUICK_START.md
echo.
pause
goto :menu

:view_detailed
echo.
echo Opening Detailed Setup Guide...
echo Please check the file: LOCAL_STAGING_SETUP.md
echo.
pause
goto :menu

:view_action_plan
echo.
echo Opening Implementation Action Plan...
echo Please check the file: IMPLEMENTATION_ACTION_PLAN.md
echo.
pause
goto :menu

:view_manual_xampp
echo.
echo Opening Manual XAMPP Installation Guide...
echo Please check the file: MANUAL_XAMPP_INSTALLATION_GUIDE.md
echo.
pause
goto :menu

:view_xampp_troubleshooting
echo.
echo Opening XAMPP Download Troubleshooting Guide...
echo Please check the file: XAMPP_DOWNLOAD_TROUBLESHOOTING.md
echo.
pause
goto :menu

:exit
echo.
echo Thank you for using The Righteous Teachers Local Development Setup!
echo.
pause
exit /b

:start
cls
goto :begin