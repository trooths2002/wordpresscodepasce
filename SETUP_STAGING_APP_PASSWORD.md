# Setting Up Application Password for Staging Environment

## Steps to Create an Application Password

1. **Log in to your staging site admin**
   - Go to: https://therighteousteachers.org/mystaging01/wp-admin/
   - Use your WordPress admin credentials

2. **Navigate to your profile**
   - In the left sidebar, click on "Users"
   - Click on "Your Profile" or your username

3. **Scroll to Application Passwords section**
   - Scroll down to the bottom of the profile page
   - Look for the "Application Passwords" section

4. **Create a new Application Password**
   - Enter a name for the application: "MCP Staging CLI"
   - Click "Add New Application Password"
   - A new password will be generated and displayed

5. **Copy the Application Password**
   - **Important**: Copy the generated password immediately
   - This password will only be shown once
   - Store it securely

6. **Update your environment configuration**
   - Open the file: `mcp-wordpress-server/.env.staging`
   - Replace `your_actual_staging_application_password_here` with the copied password
   - Save the file

## Example Configuration

After setting up your Application Password, your `.env.staging` file should look like this:

```
# WordPress Staging Configuration
WORDPRESS_URL=https://therighteousteachers.org/mystaging01
WORDPRESS_USERNAME=shahid-ali
WORDPRESS_APP_PASSWORD=abcd1234EFGH5678
```

## Testing the Connection

After updating the configuration, test the connection:

```
node test-environment-connection.js
```

## Troubleshooting

If you still get connection errors:

1. **Verify the staging site URL**
   - Make sure you can access https://therighteousteachers.org/mystaging01 in your browser

2. **Check Application Password permissions**
   - Ensure your WordPress user has appropriate permissions

3. **Verify the Application Password format**
   - The password should be a series of letters and numbers, typically in groups separated by spaces

4. **Check for typos**
   - Ensure there are no extra spaces or characters in the password

## Security Notes

- Never share your Application Passwords
- Use descriptive names for each Application Password
- Regularly review and remove unused Application Passwords
- Consider creating separate Application Passwords for different tools