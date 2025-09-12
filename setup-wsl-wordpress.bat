@echo off
cls
title WSL WordPress Setup for Low Disk Space
echo ========================================
echo    WSL WordPress Setup for Low Disk Space
echo ========================================
echo.
echo This script will help you set up WordPress development using WSL
echo which requires minimal additional disk space compared to XAMPP.
echo.

echo Checking if WSL is available...
wsl --version >nul 2>&1
if %errorlevel% == 0 (
    echo ✓ WSL is available
) else (
    echo ✗ WSL is not available
    echo.
    echo Please enable WSL feature:
    echo 1. Open PowerShell as Administrator
    echo 2. Run: wsl --install
    echo 3. Restart your computer
    echo 4. Run this script again
    echo.
    pause
    exit /b
)

echo.
echo Checking if Ubuntu is installed...
wsl -l >nul 2>&1
if %errorlevel% == 0 (
    echo ✓ Ubuntu is installed
) else (
    echo ✗ Ubuntu is not installed
    echo.
    echo Please install Ubuntu from Microsoft Store:
    echo 1. Open Microsoft Store
    echo 2. Search for "Ubuntu"
    echo 3. Install "Ubuntu" (latest version)
    echo 4. Launch it once to complete setup
    echo 5. Run this script again
    echo.
    pause
    exit /b
)

echo.
echo ========================================
echo    WSL WordPress Setup
echo ========================================
echo.
echo This will set up a lightweight WordPress development environment
echo using WSL with minimal disk space requirements.
echo.

choice /c YN /m "Do you want to continue with WSL WordPress setup"
if errorlevel 2 goto :cancel

echo.
echo Starting WSL Ubuntu and setting up WordPress environment...
echo This may take a few minutes...
echo.

echo 1. Updating package list...
wsl -d Ubuntu -e sh -c "sudo apt update"

echo.
echo 2. Installing lightweight web server and database...
wsl -d Ubuntu -e sh -c "sudo apt install -y lighttpd mysql-server php-cgi php-mysql unzip"

echo.
echo 3. Starting services...
wsl -d Ubuntu -e sh -c "sudo service mysql start"
wsl -d Ubuntu -e sh -c "sudo service lighttpd start"

echo.
echo 4. Downloading WordPress...
wsl -d Ubuntu -e sh -c "cd /tmp && wget https://wordpress.org/latest.zip && unzip latest.zip"

echo.
echo 5. Setting up WordPress directory...
wsl -d Ubuntu -e sh -c "sudo mkdir -p /var/www/html/therighteousteachers"
wsl -d Ubuntu -e sh -c "sudo cp -r /tmp/wordpress/* /var/www/html/therighteousteachers/"

echo.
echo 6. Creating database...
wsl -d Ubuntu -e sh -c "mysql -u root -e \"CREATE DATABASE therighteousteachers; CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'wppassword'; GRANT ALL PRIVILEGES ON therighteousteachers.* TO 'wpuser'@'localhost'; FLUSH PRIVILEGES;\""

echo.
echo 7. Configuring WordPress...
wsl -d Ubuntu -e sh -c "sudo cp /var/www/html/therighteousteachers/wp-config-sample.php /var/www/html/therighteousteachers/wp-config.php"
wsl -d Ubuntu -e sh -c "sudo sed -i \"s/database_name_here/therighteousteachers/g\" /var/www/html/therighteousteachers/wp-config.php"
wsl -d Ubuntu -e sh -c "sudo sed -i \"s/username_here/wpuser/g\" /var/www/html/therighteousteachers/wp-config.php"
wsl -d Ubuntu -e sh -c "sudo sed -i \"s/password_here/wppassword/g\" /var/www/html/therighteousteachers/wp-config.php"

echo.
echo 8. Setting permissions...
wsl -d Ubuntu -e sh -c "sudo chown -R www-data:www-data /var/www/html/therighteousteachers"
wsl -d Ubuntu -e sh -c "sudo chmod -R 755 /var/www/html/therighteousteachers"

echo.
echo ========================================
echo    Setup Complete!
echo ========================================
echo.
echo Your WordPress development environment is ready!
echo.
echo Access your site at: http://localhost/therighteousteachers
echo.
echo To manage your WordPress installation:
echo 1. Start WSL: wsl -d Ubuntu
echo 2. Start services: sudo service mysql start ^&^& sudo service lighttpd start
echo 3. Access files at: /var/www/html/therighteousteachers
echo.
echo For database management, you can install phpMyAdmin in WSL:
echo wsl -d Ubuntu -e sh -c "sudo apt install phpmyadmin"
echo.
echo Press any key to exit...
pause >nul
exit /b

:cancel
echo.
echo Setup cancelled.
echo.
echo You can:
echo 1. Free up disk space and try XAMPP installation
echo 2. Try cloud-based development environments
echo 3. Run this script again when ready
echo.
echo Press any key to exit...
pause >nul
exit /b