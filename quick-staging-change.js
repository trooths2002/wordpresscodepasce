const axios = require('axios');
require('dotenv').config({ path: './mcp-wordpress-server/.env' });

const WORDPRESS_URL = process.env.WORDPRESS_URL || '';
const WORDPRESS_USERNAME = process.env.WORDPRESS_USERNAME || '';
const WORDPRESS_APP_PASSWORD = process.env.WORDPRESS_APP_PASSWORD || '';

// Create authentication header for WordPress
const getAuthHeader = () => {
    if (!WORDPRESS_USERNAME || !WORDPRESS_APP_PASSWORD) {
        throw new Error('Missing WordPress credentials');
    }
    // Properly encode credentials with spaces
    const credentials = Buffer.from(`${WORDPRESS_USERNAME}:${WORDPRESS_APP_PASSWORD}`).toString('base64');
    return `Basic ${credentials}`;
};

// Create a new post
async function createTestPost() {
    try {
        console.log('Creating a test post on your staging site...');
        console.log(`Connecting to: ${WORDPRESS_URL}`);
        console.log(`Username: ${WORDPRESS_USERNAME}`);
        console.log(`Password length: ${WORDPRESS_APP_PASSWORD.length} characters`);
        
        const response = await axios({
            method: 'POST',
            url: `${WORDPRESS_URL}/wp-json/wp/v2/posts`,
            headers: {
                'Authorization': getAuthHeader(),
                'Content-Type': 'application/json',
            },
            data: {
                title: 'Test Post Created via CLI',
                content: '<p>This is a test post automatically created via the command-line interface. You can edit or delete this post through the WordPress admin.</p>',
                status: 'draft', // Start as draft so it doesn't immediately go live
                excerpt: 'A test post created through automation'
            },
            timeout: 15000
        });

        console.log('✅ Success! Test post created.');
        console.log(`   Post ID: ${response.data.id}`);
        console.log(`   Title: ${response.data.title.rendered}`);
        console.log(`   Status: ${response.data.status}`);
        console.log(`   View at: ${response.data.link}`);
        
        return response.data;
    } catch (error) {
        if (error.response && error.response.status === 401) {
            console.error('❌ Authentication failed. Please check your Application Password.');
            console.error('   Make sure you have the correct password in your .env file.');
            console.error('   The password should be in the format: xxxx xxxx xxxx xxxx xxxx xxxx');
        } else if (error.response && error.response.status === 403) {
            console.error('❌ Permission denied. Your user may not have permission to create posts.');
            console.error('   Try logging into the WordPress admin to verify your permissions.');
        } else {
            console.error('❌ Error creating post:', error.message);
            if (error.response) {
                console.error(`   Status: ${error.response.status}`);
                console.error(`   Message: ${JSON.stringify(error.response.data)}`);
            }
        }
        return null;
    }
}

// Run the function
createTestPost();