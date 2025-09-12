# Local WordPress Staging Environment Setup

## Overview

This guide will help you set up a local WordPress staging environment on your Windows machine using the tools and resources already available in your project. This local staging site will allow you to test changes before applying them to your live site.

## Prerequisites

Based on your current setup, you already have:
- WP-CLI installed and configured (`wp.bat` and `wp-cli.phar`)
- WordPress content export (`therighteousteachers.WordPress.2025-09-11.xml`)
- PHP 8.4.11 installed at `C:\tools\php84`
- This project directory with all necessary documentation

## Recommended Approach: XAMPP (Intermediate Level)

Since you're on Windows and already have some technical setup, I recommend using XAMPP for your local staging environment.

### Step 1: Install XAMPP

1. **Download XAMPP**:
   - Visit: https://www.apachefriends.org/index.html
   - Download the Windows version
   - Run the installer as Administrator

2. **Select Components**:
   - Apache (Web Server)
   - MySQL (Database)
   - PHP (Programming Language)
   - phpMyAdmin (Database Management)
   - Keep default settings for other options

3. **Complete Installation**:
   - Choose installation directory: `C:\xampp`
   - Complete the installation wizard

### Step 2: Start XAMPP Services

1. **Open XAMPP Control Panel**
2. **Start Apache and MySQL**:
   - Click "Start" next to Apache
   - Click "Start" next to MySQL
   - Wait until both show green "Running" status

### Step 3: Set Up WordPress Directory

1. **Create Project Directory**:
   ```cmd
   mkdir C:\xampp\htdocs\therighteousteachers
   ```

2. **Download WordPress**:
   - Visit: https://wordpress.org/latest.zip
   - Download the latest WordPress package
   - Extract contents to: `C:\xampp\htdocs\therighteousteachers`

### Step 4: Create Database

1. **Access phpMyAdmin**:
   - Open browser and go to: http://localhost/phpmyadmin

2. **Create Database**:
   - Click "New" in the left sidebar
   - Database name: `therighteousteachers_staging`
   - Collation: `utf8mb4_unicode_ci`
   - Click "Create"

### Step 5: Configure WordPress

1. **Rename Configuration File**:
   - Navigate to: `C:\xampp\htdocs\therighteousteachers`
   - Rename `wp-config-sample.php` to `wp-config.php`

2. **Edit wp-config.php**:
   - Open with text editor
   - Update database settings:
     ```php
     define('DB_NAME', 'therighteousteachers_staging');
     define('DB_USER', 'root');
     define('DB_PASSWORD', '');
     define('DB_HOST', 'localhost');
     ```

3. **Add Security Keys**:
   - Visit: https://api.wordpress.org/secret-key/1.1/salt/
   - Copy and replace the security keys in wp-config.php

4. **Set WordPress URLs** (Add these lines):
   ```php
   define('WP_HOME', 'http://localhost/therighteousteachers');
   define('WP_SITEURL', 'http://localhost/therighteousteachers');
   ```

### Step 6: Install WordPress

1. **Run Installation**:
   - Open browser and go to: http://localhost/therighteousteachers
   - Complete the WordPress installation:
     - Site Title: "The Righteous Teachers - Local Staging"
     - Username: "admin"
     - Password: "secure_password123"
     - Email: "admin@localhost.local"
     - Click "Install WordPress"

### Step 7: Import Existing Content

1. **Access WordPress Admin**:
   - Go to: http://localhost/therighteousteachers/wp-admin
   - Log in with your credentials

2. **Install Importer Plugin**:
   - Go to Plugins → Add New
   - Search for "WordPress Importer"
   - Install and activate

3. **Import Content**:
   - Go to Tools → Import → WordPress
   - Click "Run Importer"
   - Upload: `therighteousteachers.WordPress.2025-09-11.xml`
   - Select "Import author" as new user
   - Click "Submit"

### Step 8: Import Theme and Plugins

1. **Copy Theme Files**:
   - Navigate to your live site's theme directory
   - Copy theme folder to: `C:\xampp\htdocs\therighteousteachers\wp-content\themes\`

2. **Copy Plugin Files**:
   - Navigate to your live site's plugin directory
   - Copy plugin folders to: `C:\xampp\htdocs\therighteousteachers\wp-content\plugins\`

3. **Activate Theme and Plugins**:
   - In WordPress admin, go to Appearance → Themes
   - Activate your theme
   - Go to Plugins → Installed Plugins
   - Activate necessary plugins

## Alternative Approach: Using WP-CLI (Advanced)

If you prefer command-line setup:

### Step 1: Create WordPress Installation

```cmd
cd C:\xampp\htdocs\therighteousteachers
wp core download
wp config create --dbname=therighteousteachers_staging --dbuser=root --dbpass= --dbhost=localhost
wp core install --url=http://localhost/therighteousteachers --title="The Righteous Teachers - Local Staging" --admin_user=admin --admin_password=secure_password123 --admin_email=admin@localhost.local
```

### Step 2: Import Content

```cmd
wp plugin install wordpress-importer --activate
wp import therighteousteachers.WordPress.2025-09-11.xml --authors=create
```

## Accessing Your Local Staging Site

Once setup is complete:

- **Frontend**: http://localhost/therighteousteachers
- **Admin Dashboard**: http://localhost/therighteousteachers/wp-admin
- **Database Management**: http://localhost/phpmyadmin

## Useful WP-CLI Commands for Local Development

```cmd
# Navigate to your WordPress directory
cd C:\xampp\htdocs\therighteousteachers

# Check WordPress status
wp core version

# Update WordPress core
wp core update

# List installed plugins
wp plugin list

# Update all plugins
wp plugin update --all

# List installed themes
wp theme list

# Create a new post
wp post create --post_title="Test Post" --post_content="This is a test post."

# Export database
wp db export staging-backup.sql

# Search and replace URLs (useful when moving sites)
wp search-replace 'http://localhost/therighteousteachers' 'https://therighteousteachers.org'
```

## Best Practices for Local Staging

### 1. Regular Backups
```cmd
wp db export backup-$(date +%Y%m%d).sql
```

### 2. Version Control
- Initialize Git repository in your WordPress directory
- Create `.gitignore` to exclude uploads, cache, and sensitive files
- Commit changes regularly

### 3. Testing Workflow
1. Make changes on local staging first
2. Test thoroughly
3. Export content or code changes
4. Apply to remote staging environment
5. Test again
6. Finally apply to production

### 4. Security Considerations
- Never use real user data in local development
- Change admin passwords regularly
- Disable search engine indexing:
  ```php
  define('DISALLOW_FILE_EDIT', true);
  define('WP_DEBUG', true);
  ```

## Troubleshooting Common Issues

### Database Connection Errors
- Ensure MySQL service is running in XAMPP
- Verify database name, username, and password in `wp-config.php`
- Check if port 3306 is being used by another application

### Permission Errors
- Ensure Apache has write permissions to WordPress directories
- Set proper file permissions:
  ```cmd
  # In PowerShell (as Administrator)
  icacls "C:\xampp\htdocs\therighteousteachers" /grant "Everyone:(OI)(CI)F" /T
  ```

### White Screen of Death
- Enable WP_DEBUG in `wp-config.php`:
  ```php
  define('WP_DEBUG', true);
  define('WP_DEBUG_DISPLAY', true);
  ```
- Check PHP error logs in XAMPP

### Import Issues
- Increase PHP memory limit in `php.ini`:
  ```ini
  memory_limit = 512M
  max_execution_time = 300
  upload_max_filesize = 64M
  post_max_size = 64M
  ```

## Next Steps

1. Complete the local staging setup using the method that works best for you
2. Import your existing content and verify it displays correctly
3. Test making changes locally before applying to remote staging
4. Establish a regular backup routine
5. Document your local development workflow

## Benefits of Local Staging

- **Speed**: No internet connection required for development
- **Safety**: Test changes without affecting live site
- **Privacy**: Work with sensitive data securely
- **Flexibility**: Experiment with different themes, plugins, and configurations
- **Offline Work**: Continue development even without internet access

Your local staging environment will be an exact copy of your live site where you can safely test any changes before implementing them on your production website.# Local WordPress Staging Environment Setup

## Overview

This guide will help you set up a local WordPress staging environment on your Windows machine using the tools and resources already available in your project. This local staging site will allow you to test changes before applying them to your live site.

## Prerequisites

Based on your current setup, you already have:
- WP-CLI installed and configured (`wp.bat` and `wp-cli.phar`)
- WordPress content export (`therighteousteachers.WordPress.2025-09-11.xml`)
- PHP 8.4.11 installed at `C:\tools\php84`
- This project directory with all necessary documentation

## Recommended Approach: XAMPP (Intermediate Level)

Since you're on Windows and already have some technical setup, I recommend using XAMPP for your local staging environment.

### Step 1: Install XAMPP

1. **Download XAMPP**:
   - Visit: https://www.apachefriends.org/index.html
   - Download the Windows version
   - Run the installer as Administrator

2. **Select Components**:
   - Apache (Web Server)
   - MySQL (Database)
   - PHP (Programming Language)
   - phpMyAdmin (Database Management)
   - Keep default settings for other options

3. **Complete Installation**:
   - Choose installation directory: `C:\xampp`
   - Complete the installation wizard

### Step 2: Start XAMPP Services

1. **Open XAMPP Control Panel**
2. **Start Apache and MySQL**:
   - Click "Start" next to Apache
   - Click "Start" next to MySQL
   - Wait until both show green "Running" status

### Step 3: Set Up WordPress Directory

1. **Create Project Directory**:
   ```cmd
   mkdir C:\xampp\htdocs\therighteousteachers
   ```

2. **Download WordPress**:
   - Visit: https://wordpress.org/latest.zip
   - Download the latest WordPress package
   - Extract contents to: `C:\xampp\htdocs\therighteousteachers`

### Step 4: Create Database

1. **Access phpMyAdmin**:
   - Open browser and go to: http://localhost/phpmyadmin

2. **Create Database**:
   - Click "New" in the left sidebar
   - Database name: `therighteousteachers_staging`
   - Collation: `utf8mb4_unicode_ci`
   - Click "Create"

### Step 5: Configure WordPress

1. **Rename Configuration File**:
   - Navigate to: `C:\xampp\htdocs\therighteousteachers`
   - Rename `wp-config-sample.php` to `wp-config.php`

2. **Edit wp-config.php**:
   - Open with text editor
   - Update database settings:
     ```php
     define('DB_NAME', 'therighteousteachers_staging');
     define('DB_USER', 'root');
     define('DB_PASSWORD', '');
     define('DB_HOST', 'localhost');
     ```

3. **Add Security Keys**:
   - Visit: https://api.wordpress.org/secret-key/1.1/salt/
   - Copy and replace the security keys in wp-config.php

4. **Set WordPress URLs** (Add these lines):
   ```php
   define('WP_HOME', 'http://localhost/therighteousteachers');
   define('WP_SITEURL', 'http://localhost/therighteousteachers');
   ```

### Step 6: Install WordPress

1. **Run Installation**:
   - Open browser and go to: http://localhost/therighteousteachers
   - Complete the WordPress installation:
     - Site Title: "The Righteous Teachers - Local Staging"
     - Username: "admin"
     - Password: "secure_password123"
     - Email: "admin@localhost.local"
     - Click "Install WordPress"

### Step 7: Import Existing Content

1. **Access WordPress Admin**:
   - Go to: http://localhost/therighteousteachers/wp-admin
   - Log in with your credentials

2. **Install Importer Plugin**:
   - Go to Plugins → Add New
   - Search for "WordPress Importer"
   - Install and activate

3. **Import Content**:
   - Go to Tools → Import → WordPress
   - Click "Run Importer"
   - Upload: `therighteousteachers.WordPress.2025-09-11.xml`
   - Select "Import author" as new user
   - Click "Submit"

### Step 8: Import Theme and Plugins

1. **Copy Theme Files**:
   - Navigate to your live site's theme directory
   - Copy theme folder to: `C:\xampp\htdocs\therighteousteachers\wp-content\themes\`

2. **Copy Plugin Files**:
   - Navigate to your live site's plugin directory
   - Copy plugin folders to: `C:\xampp\htdocs\therighteousteachers\wp-content\plugins\`

3. **Activate Theme and Plugins**:
   - In WordPress admin, go to Appearance → Themes
   - Activate your theme
   - Go to Plugins → Installed Plugins
   - Activate necessary plugins

## Alternative Approach: Using WP-CLI (Advanced)

If you prefer command-line setup:

### Step 1: Create WordPress Installation

```cmd
cd C:\xampp\htdocs\therighteousteachers
wp core download
wp config create --dbname=therighteousteachers_staging --dbuser=root --dbpass= --dbhost=localhost
wp core install --url=http://localhost/therighteousteachers --title="The Righteous Teachers - Local Staging" --admin_user=admin --admin_password=secure_password123 --admin_email=admin@localhost.local
```

### Step 2: Import Content

```cmd
wp plugin install wordpress-importer --activate
wp import therighteousteachers.WordPress.2025-09-11.xml --authors=create
```

## Accessing Your Local Staging Site

Once setup is complete:

- **Frontend**: http://localhost/therighteousteachers
- **Admin Dashboard**: http://localhost/therighteousteachers/wp-admin
- **Database Management**: http://localhost/phpmyadmin

## Useful WP-CLI Commands for Local Development

```cmd
# Navigate to your WordPress directory
cd C:\xampp\htdocs\therighteousteachers

# Check WordPress status
wp core version

# Update WordPress core
wp core update

# List installed plugins
wp plugin list

# Update all plugins
wp plugin update --all

# List installed themes
wp theme list

# Create a new post
wp post create --post_title="Test Post" --post_content="This is a test post."

# Export database
wp db export staging-backup.sql

# Search and replace URLs (useful when moving sites)
wp search-replace 'http://localhost/therighteousteachers' 'https://therighteousteachers.org'
```

## Best Practices for Local Staging

### 1. Regular Backups
```cmd
wp db export backup-$(date +%Y%m%d).sql
```

### 2. Version Control
- Initialize Git repository in your WordPress directory
- Create `.gitignore` to exclude uploads, cache, and sensitive files
- Commit changes regularly

### 3. Testing Workflow
1. Make changes on local staging first
2. Test thoroughly
3. Export content or code changes
4. Apply to remote staging environment
5. Test again
6. Finally apply to production

### 4. Security Considerations
- Never use real user data in local development
- Change admin passwords regularly
- Disable search engine indexing:
  ```php
  define('DISALLOW_FILE_EDIT', true);
  define('WP_DEBUG', true);
  ```

## Troubleshooting Common Issues

### Database Connection Errors
- Ensure MySQL service is running in XAMPP
- Verify database name, username, and password in `wp-config.php`
- Check if port 3306 is being used by another application

### Permission Errors
- Ensure Apache has write permissions to WordPress directories
- Set proper file permissions:
  ```cmd
  # In PowerShell (as Administrator)
  icacls "C:\xampp\htdocs\therighteousteachers" /grant "Everyone:(OI)(CI)F" /T
  ```

### White Screen of Death
- Enable WP_DEBUG in `wp-config.php`:
  ```php
  define('WP_DEBUG', true);
  define('WP_DEBUG_DISPLAY', true);
  ```
- Check PHP error logs in XAMPP

### Import Issues
- Increase PHP memory limit in `php.ini`:
  ```ini
  memory_limit = 512M
  max_execution_time = 300
  upload_max_filesize = 64M
  post_max_size = 64M
  ```

## Next Steps

1. Complete the local staging setup using the method that works best for you
2. Import your existing content and verify it displays correctly
3. Test making changes locally before applying to remote staging
4. Establish a regular backup routine
5. Document your local development workflow

## Benefits of Local Staging

- **Speed**: No internet connection required for development
- **Safety**: Test changes without affecting live site
- **Privacy**: Work with sensitive data securely
- **Flexibility**: Experiment with different themes, plugins, and configurations
- **Offline Work**: Continue development even without internet access

Your local staging environment will be an exact copy of your live site where you can safely test any changes before implementing them on your production website.