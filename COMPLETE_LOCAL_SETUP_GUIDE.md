# COMPLETE LOCAL WORDPRESS DEVELOPMENT SETUP GUIDE
## For The Righteous Teachers Website

---

## OVERVIEW

This guide provides step-by-step instructions for setting up a complete local WordPress development environment for The Righteous Teachers website. This environment will mirror your staging site and allow you to safely test all changes before deploying to production.

---

## PREREQUISITES

Before beginning, ensure you have:
- Windows 10/11 (64-bit)
- Administrator privileges on your computer
- Internet connection for downloads
- At least 20GB free disk space

---

## STEP 1: UNDERSTAND YOUR CURRENT SETUP

You currently have:
- A staging environment configured at: https://therighteousteachers.org/mystaging01
- WordPress export file: `therighteousteachers.WordPress.2025-09-11.xml`
- WP-CLI installed and working
- MCP WordPress server configured with staging credentials

---

## STEP 2: CHOOSE YOUR SETUP METHOD

### Option A: Automated Setup (Recommended)
Run the automated setup script:
```
start-local-dev.bat
```
Then select "Automated WordPress Setup (Requires XAMPP)"

### Option B: Manual Setup
Follow the detailed steps in this guide

---

## STEP 3: INSTALL XAMPP

1. Run the XAMPP installation guide:
   ```
   XAMPP_INSTALLATION_GUIDE.md
   ```

2. Or manually:
   - Visit https://www.apachefriends.org/index.html
   - Download the Windows version
   - Run as Administrator
   - Select components: Apache, MySQL, PHP, phpMyAdmin
   - Install to default location (C:\xampp)

---

## STEP 4: START XAMPP SERVICES

1. Open XAMPP Control Panel (`C:\xampp\xampp-control.exe`)
2. Start Apache service
3. Start MySQL service
4. Both should show green "Running" status

---

## STEP 5: SET UP WORDPRESS

### Automated Method:
Run the PowerShell script:
```
automate-wordpress-setup.ps1
```

### Manual Method:
1. Create directory: `C:\xampp\htdocs\therighteousteachers`
2. Download WordPress: https://wordpress.org/latest.zip
3. Extract to the directory above
4. Create database in phpMyAdmin:
   - Visit http://localhost/phpmyadmin
   - Click "New"
   - Name: `therighteousteachers`
   - Click "Create"
5. Configure WordPress:
   - Rename `wp-config-sample.php` to `wp-config.php`
   - Edit with:
     - DB_NAME: `therighteousteachers`
     - DB_USER: `root`
     - DB_PASSWORD: `` (empty)
     - DB_HOST: `localhost`

---

## STEP 6: INSTALL WORDPRESS

1. Visit: http://localhost/therighteousteachers
2. Complete installation with:
   - Site Title: "The Righteous Teachers"
   - Username: "admin"
   - Password: Choose a secure password
   - Email: your-email@example.com

---

## STEP 7: IMPORT EXISTING CONTENT

1. Log in to WordPress admin: http://localhost/therighteousteachers/wp-admin
2. Go to Tools > Import > WordPress
3. Install WordPress Importer plugin if prompted
4. Upload: `therighteousteachers.WordPress.2025-09-11.xml`
5. Map authors and complete import

---

## STEP 8: CONFIGURE DEVELOPMENT ENVIRONMENT

### Set up environment switching:
1. Use staging: `mcp-wordpress-server\use-staging.bat`
2. Use production: `mcp-wordpress-server\use-production.bat`

### Verify MCP server connection:
1. Ensure `.env` file in `mcp-wordpress-server` has correct staging credentials
2. Test connection with: `test-staging-connection.js`

---

## STEP 9: DEVELOPMENT WORKFLOW

### Local Development Process:
1. Make changes in your local environment first
2. Test thoroughly on http://localhost/therighteousteachers
3. Export content when ready for staging
4. Import to staging environment
5. Test on staging
6. Deploy to production

### Content Management:
- Use WP-CLI for bulk operations
- Use MCP tools for API interactions
- Use WordPress admin for content creation

---

## STEP 10: ONGOING MAINTENANCE

### Daily Tasks:
- Check for WordPress updates
- Review error logs
- Verify backup integrity

### Weekly Tasks:
- Update themes and plugins
- Optimize database
- Review security settings

### Monthly Tasks:
- Full site backup
- Performance optimization
- Security audit

---

## TROUBLESHOOTING

### Common Issues:

**Apache won't start:**
- Check if another program is using port 80
- Try stopping Skype or other applications
- Change Apache port in config if needed

**MySQL won't start:**
- Ensure no other MySQL instances are running
- Check if port 3306 is being used

**WordPress shows database connection error:**
- Verify database name in wp-config.php
- Ensure MySQL service is running
- Check database user privileges

**Import fails:**
- Increase PHP memory limit
- Check file upload size limits
- Try importing in smaller chunks

---

## USEFUL COMMANDS AND TOOLS

### WP-CLI Commands:
```bash
# Check WordPress status
wp core version

# Import content
wp import therighteousteachers.WordPress.2025-09-11.xml --authors=create

# Update plugins
wp plugin update --all

# Export database
wp db export backup.sql
```

### MCP Tools:
- `list_posts` - List WordPress posts
- `get_post` - Get specific post
- `create_post` - Create new post
- `update_post` - Update existing post

---

## FILES CREATED FOR YOUR USE

1. `setup-local-environment.bat` - Step-by-step setup guide
2. `LOCAL_SETUP_CHECKLIST.md` - Progress tracking checklist
3. `XAMPP_INSTALLATION_GUIDE.md` - Detailed XAMPP installation
4. `automate-wordpress-setup.ps1` - Automated WordPress setup
5. `start-local-dev.bat` - Main setup launcher (updated with automated option)

---

## NEXT STEPS

1. Run `start-local-dev.bat` and choose your setup method
2. Complete XAMPP installation
3. Set up WordPress locally
4. Import your existing content
5. Test the staging connection
6. Begin making local changes

---

**Setup Manager**: Digital Manager
**Target Completion**: 
**Status**: Guide Complete - Ready for Implementation