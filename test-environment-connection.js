const axios = require('axios');
const fs = require('fs');
const path = require('path');

async function testEnvironment(envName, envPath) {
    console.log(`\n=== Testing ${envName} Environment ===`);
    
    // Check if .env file exists
    const fullPath = path.resolve(envPath);
    console.log(`Checking for .env file at: ${fullPath}`);
    
    if (!fs.existsSync(fullPath)) {
        console.log(`❌ ${envName} .env file not found`);
        return false;
    }
    
    // Load environment variables
    require('dotenv').config({ path: envPath });
    
    const WORDPRESS_URL = process.env.WORDPRESS_URL || '';
    const WORDPRESS_USERNAME = process.env.WORDPRESS_USERNAME || '';
    const WORDPRESS_APP_PASSWORD = process.env.WORDPRESS_APP_PASSWORD || '';
    
    console.log('Environment variables loaded:');
    console.log(`WORDPRESS_URL: ${WORDPRESS_URL}`);
    console.log(`WORDPRESS_USERNAME: ${WORDPRESS_USERNAME}`);
    console.log(`WORDPRESS_APP_PASSWORD set: ${!!WORDPRESS_APP_PASSWORD}`);
    
    if (!WORDPRESS_URL || !WORDPRESS_USERNAME || !WORDPRESS_APP_PASSWORD) {
        console.log(`❌ Missing required environment variables for ${envName}`);
        return false;
    }
    
    // Create authentication header
    const getAuthHeader = () => {
        const credentials = Buffer.from(`${WORDPRESS_USERNAME}:${WORDPRESS_APP_PASSWORD}`).toString('base64');
        return `Basic ${credentials}`;
    };
    
    try {
        console.log(`Testing connection to: ${WORDPRESS_URL}`);
        
        const response = await axios({
            method: 'GET',
            url: `${WORDPRESS_URL}/wp-json/wp/v2/posts`,
            headers: {
                'Authorization': getAuthHeader(),
            },
            params: {
                per_page: 1
            },
            timeout: 10000
        });
        
        console.log(`✅ Success! Status: ${response.status}`);
        console.log(`Found ${response.data.length} posts`);
        if (response.data.length > 0) {
            console.log(`Latest post: ${response.data[0].title.rendered}`);
        }
        
        return true;
    } catch (error) {
        console.log(`❌ Error connecting to ${envName}: ${error.message}`);
        if (error.response) {
            console.log(`Status: ${error.response.status}`);
            if (error.response.status === 401) {
                console.log('Hint: Check your Application Password');
            } else if (error.response.status === 403) {
                console.log('Hint: Check user permissions');
            }
        } else if (error.request) {
            console.log('Hint: Network issue or timeout - check the URL');
        }
        return false;
    }
}

async function main() {
    console.log('WordPress Environment Connection Tester');
    console.log('=====================================');
    
    // Test production environment
    const prodSuccess = await testEnvironment('Production', './mcp-wordpress-server/.env.production');
    
    // Test staging environment
    const stagingSuccess = await testEnvironment('Staging', './mcp-wordpress-server/.env.staging');
    
    console.log('\n=== Summary ===');
    console.log(`Production: ${prodSuccess ? '✅ Connected' : '❌ Connection Failed'}`);
    console.log(`Staging: ${stagingSuccess ? '✅ Connected' : '❌ Connection Failed'}`);
    
    if (!stagingSuccess) {
        console.log('\n💡 To fix staging connection issues:');
        console.log('1. Log in to your staging admin at https://therighteousteachers.org/mystaging01/wp-admin/');
        console.log('2. Go to Users → Profile');
        console.log('3. Scroll down to "Application Passwords"');
        console.log('4. Create a new Application Password named "MCP Staging CLI"');
        console.log('5. Copy the generated password');
        console.log('6. Update the .env.staging file with the new password');
    }
}

main().catch(console.error);