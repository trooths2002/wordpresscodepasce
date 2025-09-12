# Local WordPress Staging - Quick Start Guide

## Fastest Way to Set Up Local Staging

This guide provides the quickest path to getting a local WordPress staging environment running on your Windows machine.

## Prerequisites Check

✅ You already have:
- PHP installed at `C:\tools\php84`
- WP-CLI tools (`wp.bat` and `wp-cli.phar`)
- WordPress content export (`therighteousteachers.WordPress.2025-09-11.xml`)

## Quick Setup Steps

### 1. Install XAMPP (10-15 minutes)
1. Download from: https://www.apachefriends.org/index.html
2. Install with default settings
3. Start Apache and MySQL services

### 2. Set Up WordPress Directory (2 minutes)
```cmd
mkdir C:\xampp\htdocs\therighteousteachers
```

### 3. Download WordPress (2 minutes)
1. Visit: https://wordpress.org/latest.zip
2. Extract to: `C:\xampp\htdocs\therighteousteachers`

### 4. Create Database (1 minute)
1. Go to: http://localhost/phpmyadmin
2. Click "New"
3. Name: `therighteousteachers_staging`
4. Click "Create"

### 5. Configure WordPress (3 minutes)
1. Rename `wp-config-sample.php` to `wp-config.php`
2. Edit with these settings:
   ```php
   define('DB_NAME', 'therighteousteachers_staging');
   define('DB_USER', 'root');
   define('DB_PASSWORD', '');
   define('DB_HOST', 'localhost');
   
   // Add these for local development
   define('WP_HOME', 'http://localhost/therighteousteachers');
   define('WP_SITEURL', 'http://localhost/therighteousteachers');
   ```

### 6. Install WordPress (2 minutes)
1. Visit: http://localhost/therighteousteachers
2. Complete installation with:
   - Site Title: "The Righteous Teachers - Local"
   - Username: "admin"
   - Password: "secure_password123"
   - Email: "admin@localhost.local"

### 7. Import Your Content (5 minutes)
1. Log in to admin: http://localhost/therighteousteachers/wp-admin
2. Go to Plugins → Add New
3. Search for "WordPress Importer"
4. Install and activate
5. Go to Tools → Import → WordPress
6. Upload: `therighteousteachers.WordPress.2025-09-11.xml`
7. Import with authors

## Total Time: ~30 minutes

## Access Your Local Staging Site

- **Frontend**: http://localhost/therighteousteachers
- **Admin**: http://localhost/therighteousteachers/wp-admin
- **Database**: http://localhost/phpmyadmin

## Quick WP-CLI Commands (Useful for Development)

```cmd
# Navigate to your WordPress directory
cd C:\xampp\htdocs\therighteousteachers

# Check if WordPress is working
wp core version

# Create a test post
wp post create --post_title="Local Test Post" --post_content="Created locally!"

# List recent posts
wp post list --format=table

# Update all plugins
wp plugin update --all

# Export database
wp db export local-backup.sql
```

## Benefits of This Setup

✅ **Fast development** - No internet required
✅ **Safe testing** - Changes won't affect live site
✅ **Full control** - Install any theme or plugin
✅ **Offline work** - Develop without internet
✅ **Easy backup** - Quick database exports

## Next Steps After Setup

1. Test creating/editing posts
2. Try installing a new theme
3. Experiment with plugins
4. Practice importing/exporting content
5. Set up version control (Git)

## Troubleshooting Quick Fixes

### If site won't load:
- Check if Apache and MySQL are running in XAMPP
- Verify database name in `wp-config.php`

### If import fails:
- Increase PHP limits in XAMPP's `php.ini`:
  ```ini
  memory_limit = 512M
  max_execution_time = 300
  ```

### If permissions issues:
- In PowerShell (as Administrator):
  ```cmd
  icacls "C:\xampp\htdocs\therighteousteachers" /grant "Everyone:(OI)(CI)F" /T
  ```

## Pro Tips

1. **Bookmark these URLs** for quick access
2. **Create a desktop shortcut** to your local site
3. **Set up regular backups** with WP-CLI
4. **Use different browsers** to test your site
5. **Document changes** you make for reference

Your local staging environment is now ready for safe development and testing!