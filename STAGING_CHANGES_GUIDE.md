# Making Changes to Your Staging Environment

## Current Status

Your staging environment at `https://therighteousteachers.org/mystaging01` is properly configured and accessible for read operations, but we're experiencing authentication issues for write operations.

## Troubleshooting Authentication Issues

### 1. Verify Application Password

The most common cause of authentication failures is an incorrect or expired Application Password:

1. **Log in to your staging admin**: https://therighteousteachers.org/mystaging01/wp-admin/
2. **Go to Users → Profile** (or Users → Your Profile)
3. **Scroll to "Application Passwords" section**
4. **Check if your existing password is still listed**
5. **If not, or if you're unsure, create a new one**:
   - Enter name: "MCP Staging CLI"
   - Click "Add New Application Password"
   - **Copy the generated password immediately** (it won't be shown again)

### 2. Update Environment Configuration

After creating a new Application Password:

1. Open `mcp-wordpress-server/.env.staging`
2. Replace the `WORDPRESS_APP_PASSWORD` value with the new password
3. Copy the same password to `mcp-wordpress-server/.env` (active environment)
4. Save both files

### 3. Verify Environment File Format

Make sure your environment file has the correct format:

```bash
# WordPress Staging Configuration
WORDPRESS_URL=https://therighteousteachers.org/mystaging01
WORDPRESS_USERNAME=shahid-ali
WORDPRESS_APP_PASSWORD=XXXX XXXX XXXX XXXX XXXX XXXX
```

Note: The Application Password consists of 6 groups of 4 characters separated by spaces.

## Alternative Methods for Making Changes

### Method 1: WordPress Admin Dashboard (Recommended)

The easiest and most reliable way to make changes:

1. **Access your staging admin**: https://therighteousteachers.org/mystaging01/wp-admin/
2. **Log in with your WordPress credentials**
3. **Make changes directly through the interface**:
   - Create/edit posts and pages
   - Manage themes and plugins
   - Update site settings
   - Add or modify users

### Method 2: WP-CLI (If you have SSH access to the server)

If you have direct access to your hosting server:

```bash
# Navigate to your WordPress installation
cd /path/to/your/staging/site

# Use WP-CLI commands
wp post list
wp post create --post_title="New Post" --post_content="Content here"
wp plugin update --all
```

### Method 3: Continue Troubleshooting CLI Authentication

To continue troubleshooting the authentication issue:

1. **Verify the Application Password format**:
   - It should be exactly 6 groups of 4 characters
   - Each group separated by a single space
   - No extra spaces at the beginning or end

2. **Test with a simple PHP script**:
   ```php
   <?php
   // Save this as test-simple-auth.php
   $username = 'shahid-ali';
   $password = 'YOUR_ACTUAL_PASSWORD_HERE'; // Replace with your actual password
   
   $credentials = base64_encode("$username:$password");
   echo "Authorization: Basic $credentials\n";
   ?>
   ```

3. **Use curl to test authentication**:
   ```bash
   curl -H "Authorization: Basic BASE64CREDENTIALS" https://therighteousteachers.org/mystaging01/wp-json/wp/v2/users/me
   ```

## Best Practices for Staging Changes

### 1. Always Test on Staging First
- Make all changes on staging before applying to production
- Verify functionality and appearance
- Test with different browsers and devices

### 2. Keep Detailed Records
- Document what changes you make and when
- Note any issues or observations
- Keep a changelog for complex updates

### 3. Regular Backups
- Before making significant changes, ensure you have a backup
- WPvivid should already be handling this for your staging site

### 4. User Permissions
- Ensure your user account has appropriate permissions for the changes you want to make
- For content creation: Author, Editor, or Administrator role
- For site management: Administrator role

## Common Tasks and How to Accomplish Them

### Creating Posts
**Via Admin Dashboard**:
1. Go to Posts → Add New
2. Enter title and content
3. Set categories, tags, and featured image
4. Choose status (Draft, Pending Review, Published)
5. Click Publish or Save Draft

**Via CLI** (once authentication is fixed):
```bash
node make-staging-changes.js create "Post Title" "Post content here" draft
```

### Updating Posts
**Via Admin Dashboard**:
1. Go to Posts → All Posts
2. Find the post you want to edit
3. Click Edit
4. Make your changes
5. Click Update

**Via CLI** (once authentication is fixed):
```bash
node make-staging-changes.js update 123 title="New Title" status=publish
```

### Managing Plugins
**Via Admin Dashboard**:
1. Go to Plugins → Installed Plugins
2. Activate/deactivate plugins as needed
3. For updates: Plugins → Update Plugins

### Managing Themes
**Via Admin Dashboard**:
1. Go to Appearance → Themes
2. Activate themes
3. Customize theme settings via Appearance → Customize

## Getting Help

If you continue to have issues:

1. **Check WordPress documentation**: https://developer.wordpress.org/rest-api/
2. **Review WPvivid documentation**: https://www.wpvivid.com/documentation/
3. **Verify your hosting provider's documentation** for any specific requirements
4. **Contact your hosting provider** if you suspect server-side issues

## Next Steps

1. Try creating a new Application Password and updating your environment files
2. Test authentication with the methods provided above
3. If successful, try creating a test post via CLI
4. If not, continue using the WordPress admin dashboard for changes

Remember: The WordPress admin dashboard is always a reliable method for making changes to your site, regardless of CLI authentication issues.