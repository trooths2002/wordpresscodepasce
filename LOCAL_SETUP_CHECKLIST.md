# LOCAL WORDPRESS SETUP CHECKLIST

## Prerequisites
- [ ] Download XAMPP from https://www.apachefriends.org/index.html
- [ ] Install XAMPP with default settings
- [ ] Start Apache and MySQL services in XAMPP Control Panel

## WordPress Installation
- [ ] Create directory: `C:\xampp\htdocs\therighteousteachers`
- [ ] Download WordPress from https://wordpress.org/latest.zip
- [ ] Extract WordPress files to `C:\xampp\htdocs\therighteousteachers`
- [ ] Create database named `therighteousteachers` in phpMyAdmin
- [ ] Configure `wp-config.php` with database details:
  - DB_NAME: `therighteousteachers`
  - DB_USER: `root`
  - DB_PASSWORD: `` (empty)
  - DB_HOST: `localhost`
- [ ] Run WordPress installation at http://localhost/therighteousteachers

## Content Import
- [ ] Log in to WordPress admin
- [ ] Go to Tools > Import > WordPress
- [ ] Install WordPress Importer plugin if needed
- [ ] Upload `therighteousteachers.WordPress.2025-09-11.xml`
- [ ] Map authors and complete import

## Environment Configuration
- [ ] Copy theme files to `wp-content/themes/`
- [ ] Copy plugin files to `wp-content/plugins/`
- [ ] Activate theme and plugins
- [ ] Test site functionality

## Verification
- [ ] Verify all pages load correctly
- [ ] Check navigation menus
- [ ] Test contact forms (if any)
- [ ] Verify media files display properly
- [ ] Test admin functionality

## Development Workflow Setup
- [ ] Initialize Git repository in project folder
- [ ] Create `.gitignore` file for WordPress
- [ ] Set up remote repository (GitHub, GitLab, etc.)
- [ ] Document initial site structure
- [ ] Create backup strategy

---

**Setup Manager**: Digital Manager
**Target Completion**: 
**Status**: In Progress