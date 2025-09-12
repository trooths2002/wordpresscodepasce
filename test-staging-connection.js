// Add some debug output
console.log('Starting test script...');

const fs = require('fs');
const path = require('path');

// Check if .env file exists
const envPath = './mcp-wordpress-server/.env';
console.log('Checking for .env file at:', path.resolve(envPath));
console.log('.env file exists:', fs.existsSync(envPath));

// Load environment variables
require('dotenv').config({ path: './mcp-wordpress-server/.env' });

const WORDPRESS_URL = process.env.WORDPRESS_URL || '';
const WORDPRESS_USERNAME = process.env.WORDPRESS_USERNAME || '';
const WORDPRESS_APP_PASSWORD = process.env.WORDPRESS_APP_PASSWORD || '';

console.log('Environment variables loaded:');
console.log('WORDPRESS_URL:', WORDPRESS_URL);
console.log('WORDPRESS_USERNAME:', WORDPRESS_USERNAME);
console.log('WORDPRESS_APP_PASSWORD set:', !!WORDPRESS_APP_PASSWORD);

// Create authentication header for WordPress
const getAuthHeader = () => {
    if (!WORDPRESS_USERNAME || !WORDPRESS_APP_PASSWORD) {
        console.error('Missing WordPress credentials');
        return null;
    }
    const credentials = Buffer.from(`${WORDPRESS_USERNAME}:${WORDPRESS_APP_PASSWORD}`).toString('base64');
    return `Basic ${credentials}`;
};

async function testConnection() {
    try {
        console.log(`Testing connection to: ${WORDPRESS_URL}`);
        
        const authHeader = getAuthHeader();
        if (!authHeader) {
            console.error('Cannot create auth header - missing credentials');
            return;
        }
        
        const axios = require('axios');
        
        // Add timeout
        const response = await axios({
            method: 'GET',
            url: `${WORDPRESS_URL}/wp-json/wp/v2/posts`,
            headers: {
                'Authorization': authHeader,
            },
            params: {
                per_page: 1
            },
            timeout: 10000 // 10 second timeout
        });

        console.log(`Success! Status: ${response.status}`);
        console.log(`Found ${response.data.length} posts`);
        if (response.data.length > 0) {
            console.log(`Latest post: ${response.data[0].title.rendered}`);
        }
    } catch (error) {
        console.error('Error connecting to WordPress:', error.message);
        if (error.response) {
            console.error(`Status: ${error.response.status}`);
            console.error(`Response: ${JSON.stringify(error.response.data)}`);
        } else if (error.request) {
            console.error('No response received - network issue or timeout');
        }
    }
    
    console.log('Test completed');
}

testConnection();