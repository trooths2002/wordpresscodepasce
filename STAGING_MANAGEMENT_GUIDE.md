# Staging Site Management Guide

## Overview

This guide explains how to manage your WordPress staging site at `https://therighteousteachers.org/mystaging01` using both the admin console and command-line tools.

## Accessing Your Staging Site

### Web Admin Console
- **Frontend URL**: https://therighteousteachers.org/mystaging01
- **Admin URL**: https://therighteousteachers.org/mystaging01/wp-admin/
- **Username**: shahid-ali (or your WordPress admin username)
- **Password**: Your WordPress admin password

### Command-Line Interface (CLI)
You can manage your staging site using the WordPress REST API through custom scripts.

## Setting Up Application Password for CLI Access

To use CLI tools with your staging site, you need to create an Application Password:

1. Log in to your staging site admin: https://therighteousteachers.org/mystaging01/wp-admin/
2. Go to Users → Profile (or Users → Your Profile)
3. Scroll down to the "Application Passwords" section
4. Enter a name for the application (e.g., "MCP Staging CLI")
5. Click "Add New Application Password"
6. Copy the generated password
7. Update your `.env.staging` file with this Application Password:

```
# WordPress Staging Configuration
WORDPRESS_URL=https://therighteousteachers.org/mystaging01
WORDPRESS_USERNAME=shahid-ali
WORDPRESS_APP_PASSWORD=your_generated_application_password_here
```

## Switching Between Environments

### To use staging environment:
```
cd mcp-wordpress-server
.\use-staging.bat
```

### To use production environment:
```
cd mcp-wordpress-server
.\use-production.bat
```

## Using CLI Management Scripts

After setting up the Application Password, you can use the provided management scripts:

### List recent posts:
```
node staging-management.js
```

### Custom operations:
You can also use the exported functions in your own scripts:

```javascript
const { listPosts, getPost, createPost, updatePost } = require('./staging-management');

// Example usage
async function myCustomFunction() {
  const posts = await listPosts();
  if (posts.length > 0) {
    const post = await getPost(posts[0].id);
    // Do something with the post
  }
}
```

## Common Management Tasks

### Creating Posts
When creating posts via CLI, you can specify:
- Title
- Content
- Status (draft, publish, pending, etc.)

### Updating Posts
You can update any post field including:
- Title
- Content
- Excerpt
- Status
- Categories and tags

### Media Management
You can upload media files to your staging site using the REST API.

## Best Practices

1. **Always test on staging first**: Make all changes on your staging site before applying them to production
2. **Use descriptive names**: When creating Application Passwords, use descriptive names to identify their purpose
3. **Keep passwords secure**: Never commit Application Passwords to version control
4. **Regular cleanup**: Remove unused Application Passwords periodically
5. **Monitor changes**: Keep track of what changes are made through CLI vs. admin console

## Troubleshooting

### Authentication Errors (401)
- Verify your Application Password is correct
- Ensure the username has appropriate permissions
- Check that the staging site URL is correct

### Connection Errors
- Verify the staging site is accessible
- Check your internet connection
- Ensure WordPress REST API is enabled

### Permission Errors (403)
- Check that your user account has the necessary permissions
- Consider creating a dedicated user for CLI operations with minimal required permissions

## Additional Resources

- WordPress REST API Handbook: https://developer.wordpress.org/rest-api/
- WPvivid Staging Documentation: https://www.wpvivid.com/documentation/staging/