@echo off
cls
echo ======================================================
echo    The Righteous Teachers - Local WordPress Setup
echo ======================================================
echo.
echo This script will help you set up your local WordPress development environment.
echo.
echo Before proceeding, please ensure you have:
echo 1. Downloaded and installed XAMPP from https://www.apachefriends.org/index.html
echo 2. Started Apache and MySQL services in XAMPP Control Panel
echo.
echo Press any key to continue with the setup...
pause >nul
echo.
echo Step 1: Creating WordPress directory...
echo ----------------------------------------
if not exist "C:\xampp\htdocs\therighteousteachers" mkdir "C:\xampp\htdocs\therighteousteachers"
echo WordPress directory created at C:\xampp\htdocs\therighteousteachers
echo.
echo Step 2: Downloading WordPress (if not already present)...
echo -----------------------------------------------------
powershell -Command "Invoke-WebRequest https://wordpress.org/latest.zip -OutFile C:\xampp\htdocs\therighteousteachers\wordpress.zip"
echo WordPress downloaded successfully
echo.
echo Step 3: Extracting WordPress files...
echo -----------------------------------
powershell -Command "Expand-Archive -Path C:\xampp\htdocs\therighteousteachers\wordpress.zip -DestinationPath C:\xampp\htdocs\therighteousteachers -Force"
xcopy "C:\xampp\htdocs\therighteousteachers\wordpress\*" "C:\xampp\htdocs\therighteousteachers" /E /H /C /Y >nul
rmdir "C:\xampp\htdocs\therighteousteachers\wordpress" /S /Q >nul
del "C:\xampp\htdocs\therighteousteachers\wordpress.zip" >nul
echo WordPress files extracted successfully
echo.
echo Step 4: Creating database...
echo --------------------------
echo Please open phpMyAdmin in your browser (http://localhost/phpmyadmin)
echo 1. Click on "New" to create a new database
echo 2. Name it "therighteousteachers"
echo 3. Click "Create"
echo.
echo After creating the database, press any key to continue...
pause >nul
echo.
echo Step 5: Configuring WordPress...
echo -------------------------------
copy "C:\xampp\htdocs\therighteousteachers\wp-config-sample.php" "C:\xampp\htdocs\therighteousteachers\wp-config.php" >nul
powershell -Command "(Get-Content 'C:\xampp\htdocs\therighteousteachers\wp-config.php') -replace 'database_name_here', 'therighteousteachers' | Set-Content 'C:\xampp\htdocs\therighteousteachers\wp-config.php'"
powershell -Command "(Get-Content 'C:\xampp\htdocs\therighteousteachers\wp-config.php') -replace 'username_here', 'root' | Set-Content 'C:\xampp\htdocs\therighteousteachers\wp-config.php'"
powershell -Command "(Get-Content 'C:\xampp\htdocs\therighteousteachers\wp-config.php') -replace 'password_here', '' | Set-Content 'C:\xampp\htdocs\therighteousteachers\wp-config.php'"
echo WordPress configured successfully
echo.
echo Step 6: Installing WordPress...
echo -----------------------------
echo Please open your browser and go to http://localhost/therighteousteachers
echo Complete the WordPress installation with the following details:
echo - Site Title: The Righteous Teachers
echo - Username: admin
echo - Password: Choose a secure password
echo - Email: your-email@example.com
echo.
echo After completing the WordPress installation, press any key to continue...
pause >nul
echo.
echo Step 7: Importing existing content...
echo ----------------------------------
echo 1. Log in to your WordPress admin dashboard
echo 2. Go to Tools ^> Import ^> WordPress
echo 3. Install and activate the WordPress Importer plugin if prompted
echo 4. Upload the file: therighteousteachers.WordPress.2025-09-11.xml
echo 5. Map authors if needed and start the import
echo.
echo Press any key after completing the import...
pause >nul
echo.
echo ======================================================
echo    Local WordPress Setup Complete!
echo ======================================================
echo.
echo Your local WordPress development environment is now ready.
echo.
echo To access your site:
echo - Frontend: http://localhost/therighteousteachers
echo - Admin: http://localhost/therighteousteachers/wp-admin
echo.
echo For development workflow:
echo 1. Make changes locally first
echo 2. Test thoroughly
echo 3. Export content when ready for staging
echo 4. Import to staging environment
echo.
echo Press any key to exit...
pause >nul