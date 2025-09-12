@echo off
cls
title Start WSL Environment
echo ========================================
echo    Start WSL Environment
echo ========================================
echo.
echo This script will start your WSL Ubuntu environment
echo and provide instructions for setting up WordPress
echo.

echo Starting Ubuntu WSL...
echo.
wsl -d Ubuntu
echo.
echo ========================================
echo    WSL Ubuntu Started
echo ========================================
echo.
echo To set up WordPress in WSL, run these commands:
echo.
echo 1. Update package list:
echo    sudo apt update
echo.
echo 2. Install required packages:
echo    sudo apt install apache2 mysql-server php libapache2-mod-php php-mysql unzip
echo.
echo 3. Start services:
echo    sudo service mysql start
echo    sudo service apache2 start
echo.
echo 4. Download WordPress:
echo    cd /tmp
echo    wget https://wordpress.org/latest.zip
echo    unzip latest.zip
echo    sudo mkdir -p /var/www/html/therighteousteachers
echo    sudo cp -r wordpress/* /var/www/html/therighteousteachers/
echo.
echo 5. Create database:
echo    mysql -u root -p -e "CREATE DATABASE therighteousteachers; CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'wppassword'; GRANT ALL PRIVILEGES ON therighteousteachers.* TO 'wpuser'@'localhost'; FLUSH PRIVILEGES;"
echo.
echo 6. Configure WordPress:
echo    sudo cp /var/www/html/therighteousteachers/wp-config-sample.php /var/www/html/therighteousteachers/wp-config.php
echo    sudo sed -i "s/database_name_here/therighteousteachers/g" /var/www/html/therighteousteachers/wp-config.php
echo    sudo sed -i "s/username_here/wpuser/g" /var/www/html/therighteousteachers/wp-config.php
echo    sudo sed -i "s/password_here/wppassword/g" /var/www/html/therighteousteachers/wp-config.php
echo.
echo 7. Set permissions:
echo    sudo chown -R www-data:www-data /var/www/html/therighteousteachers
echo    sudo chmod -R 755 /var/www/html/therighteousteachers
echo.
echo 8. Access your site at: http://localhost/therighteousteachers
echo.
echo Press any key to exit...
pause >nul