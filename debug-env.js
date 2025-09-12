// Debug environment variables
require('dotenv').config({ path: './mcp-wordpress-server/.env' });

console.log('Environment Variables Debug:');
console.log('==========================');
console.log('WORDPRESS_URL:', process.env.WORDPRESS_URL);
console.log('WORDPRESS_USERNAME:', process.env.WORDPRESS_USERNAME);
console.log('WORDPRESS_APP_PASSWORD:', process.env.WORDPRESS_APP_PASSWORD);
console.log('Password length:', process.env.WORDPRESS_APP_PASSWORD ? process.env.WORDPRESS_APP_PASSWORD.length : 'undefined');

// Check for hidden characters
if (process.env.WORDPRESS_APP_PASSWORD) {
    console.log('Password characters:');
    for (let i = 0; i < process.env.WORDPRESS_APP_PASSWORD.length; i++) {
        const char = process.env.WORDPRESS_APP_PASSWORD[i];
        console.log(`  [${i}]: '${char}' (code: ${char.charCodeAt(0)})`);
    }
}