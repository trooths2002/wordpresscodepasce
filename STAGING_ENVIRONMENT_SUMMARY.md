# Staging Environment Summary

## Current Setup

You have a staging site created with WPvivid at:
- **Frontend URL**: https://therighteousteachers.org/mystaging01
- **Admin URL**: https://therighteousteachers.org/mystaging01/wp-admin/
- **Created**: Sep-12-2025
- **Database**: u395058660_okWFB
- **Table Prefix**: wpvividstg01_

## Management Options

### 1. Web Admin Console
- **Best for**: Content creation, visual changes, plugin management
- **Access**: Through web browser at the admin URL
- **Advantages**: User-friendly interface, immediate visual feedback
- **Limitations**: Manual process, harder to automate

### 2. Command-Line Interface (CLI)
- **Best for**: Automated tasks, batch operations, scripting
- **Access**: Through terminal/command prompt using custom scripts
- **Advantages**: Automation, consistency, integration with development workflows
- **Limitations**: Requires setup, steeper learning curve

## Environment Configuration Files

Located in `mcp-wordpress-server/` directory:

1. **.env.production** - Configuration for live site
2. **.env.staging** - Configuration for staging site
3. **.env** - Currently active environment (should match one of the above)

## Switching Between Environments

Use the provided batch scripts:

### To switch to staging:
```
cd mcp-wordpress-server
.\use-staging.bat
```

### To switch to production:
```
cd mcp-wordpress-server
.\use-production.bat
```

## Required Setup Steps

### For CLI Access to Staging:

1. **Create Application Password**:
   - Log in to staging admin
   - Go to Users → Profile
   - Scroll to "Application Passwords"
   - Create new password named "MCP Staging CLI"
   - Copy the generated password

2. **Update Configuration**:
   - Edit `mcp-wordpress-server/.env.staging`
   - Replace placeholder with actual Application Password
   - Save the file

3. **Test Connection**:
   ```
   node test-environment-connection.js
   ```

## Available Management Tools

### Custom Scripts:
- `staging-management.js` - Comprehensive management functions
- `test-environment-connection.js` - Connection testing
- `test-staging-connection.js` - Simple staging connection test

### Functions Available:
- List posts
- Get post details
- Create new posts
- Update existing posts
- (More functions can be added as needed)

## Best Practices

1. **Always test on staging first**
   - Make changes on staging before applying to production
   - Verify functionality and appearance

2. **Use appropriate tools for tasks**
   - Web admin for content creation and visual changes
   - CLI for automated or repetitive tasks

3. **Keep environments synchronized**
   - Regularly update staging with production content
   - Use WPvivid's built-in synchronization features

4. **Document changes**
   - Keep track of what changes were made where
   - Note whether changes were made via admin or CLI

## Next Steps

1. Set up Application Password for staging CLI access
2. Test connection to staging environment
3. Experiment with management scripts
4. Familiarize yourself with both admin and CLI workflows
5. Begin testing changes on staging before applying to production

## Support Resources

- WPvivid Documentation: https://www.wpvivid.com/documentation/
- WordPress REST API Handbook: https://developer.wordpress.org/rest-api/
- Local project documentation in this directory