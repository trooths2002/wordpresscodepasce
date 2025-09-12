@echo off
cls
title The Righteous Teachers - Development Environment Launcher
echo ======================================================
echo    The Righteous Teachers - Development Environment
echo ======================================================
echo.
echo Welcome to your WordPress development environment!
echo.
echo Available Options:
echo 1. Verify Current Setup
echo 2. Start Local Development Setup
echo 3. Launch XAMPP Control Panel
echo 4. Open Local WordPress Site
echo 5. Open WordPress Admin
echo 6. Test Staging Connection
echo 7. View Implementation Action Plan
echo 8. Exit
echo.
choice /c 12345678 /m "Select an option"
if errorlevel 8 goto :exit
if errorlevel 7 goto :action_plan
if errorlevel 6 goto :test_staging
if errorlevel 5 goto :wp_admin
if errorlevel 4 goto :wp_site
if errorlevel 3 goto :xampp
if errorlevel 2 goto :setup
if errorlevel 1 goto :verify

:verify
cls
echo Verifying current setup...
echo.
call verify-setup.bat
echo.
echo Press any key to return to menu...
pause >nul
cls
goto :start

:setup
cls
echo Starting local development setup...
echo.
call start-local-dev.bat
cls
goto :start

:xampp
echo.
echo Launching XAMPP Control Panel...
echo.
if exist "C:\xampp\xampp-control.exe" (
    start "" "C:\xampp\xampp-control.exe"
    echo XAMPP Control Panel launched.
) else (
    echo XAMPP is not installed.
    echo Please install XAMPP first.
)
echo.
echo Press any key to return to menu...
pause >nul
cls
goto :start

:wp_site
echo.
echo Opening local WordPress site...
echo.
start "" "http://localhost/therighteousteachers"
echo Local WordPress site opened in your browser.
echo.
echo Press any key to return to menu...
pause >nul
cls
goto :start

:wp_admin
echo.
echo Opening WordPress admin...
echo.
start "" "http://localhost/therighteousteachers/wp-admin"
echo WordPress admin opened in your browser.
echo.
echo Press any key to return to menu...
pause >nul
cls
goto :start

:test_staging
echo.
echo Testing staging connection...
echo.
if exist "test-staging-connection.js" (
    node test-staging-connection.js
) else (
    echo Test script not found.
)
echo.
echo Press any key to return to menu...
pause >nul
cls
goto :start

:action_plan
echo.
echo Opening Implementation Action Plan...
echo.
start "" "IMPLEMENTATION_ACTION_PLAN.md"
echo Implementation Action Plan opened.
echo.
echo Press any key to return to menu...
pause >nul
cls
goto :start

:exit
echo.
echo Thank you for using The Righteous Teachers Development Environment!
echo.
pause
exit /b

:start
echo ======================================================
echo    The Righteous Teachers - Development Environment
echo ======================================================
echo.
echo Available Options:
echo 1. Verify Current Setup
echo 2. Start Local Development Setup
echo 3. Launch XAMPP Control Panel
echo 4. Open Local WordPress Site
echo 5. Open WordPress Admin
echo 6. Test Staging Connection
echo 7. View Implementation Action Plan
echo 8. Exit
echo.
choice /c 12345678 /m "Select an option"
if errorlevel 8 goto :exit
if errorlevel 7 goto :action_plan
if errorlevel 6 goto :test_staging
if errorlevel 5 goto :wp_admin
if errorlevel 4 goto :wp_site
if errorlevel 3 goto :xampp
if errorlevel 2 goto :setup
if errorlevel 1 goto :verify