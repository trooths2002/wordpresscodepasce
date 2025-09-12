@echo off
cls
title The Righteous Teachers - Getting Started
echo ======================================================
echo    The Righteous Teachers - Getting Started
echo ======================================================
echo.
echo Welcome to your WordPress development environment setup!
echo.
echo This script will guide you through the setup process.
echo.
echo Press any key to begin...
pause >nul
echo.
echo Step 1: Installing XAMPP
echo -----------------------
echo Please follow the XAMPP installation guide:
echo - Open XAMPP_INSTALLATION_GUIDE.md
echo - Or visit: https://www.apachefriends.org/index.html
echo.
echo After installing XAMPP, press any key to continue...
pause >nul
echo.
echo Step 2: Setting up WordPress
echo --------------------------
echo You can either:
echo 1. Run the automated setup: start-local-dev.bat (recommended)
echo 2. Follow the manual setup in COMPLETE_LOCAL_SETUP_GUIDE.md
echo.
echo Press any key to launch the automated setup...
pause >nul
echo.
echo Starting automated setup...
start "" "start-local-dev.bat"
echo.
echo The automated setup window should now be open.
echo.
echo Step 3: Import your content
echo ------------------------
echo After WordPress is installed:
echo 1. Log in to your admin dashboard
echo 2. Go to Tools ^> Import ^> WordPress
echo 3. Upload therighteousteachers.WordPress.2025-09-11.xml
echo.
echo Step 4: Test staging connection
echo -----------------------------
echo 1. Ensure mcp-wordpress-server\.env has correct staging credentials
echo 2. Run test-staging-connection.js to verify connection
echo.
echo ======================================================
echo    Setup Process Started Successfully!
echo ======================================================
echo.
echo Next steps:
echo 1. Install XAMPP if not already done
echo 2. Run the automated WordPress setup
echo 3. Import your existing content
echo 4. Begin developing locally
echo.
echo Helpful files:
echo - COMPLETE_LOCAL_SETUP_GUIDE.md (complete setup guide)
echo - LOCAL_SETUP_CHECKLIST.md (track your progress)
echo - XAMPP_INSTALLATION_GUIDE.md (XAMPP installation help)
echo.
echo Press any key to exit...
pause >nul