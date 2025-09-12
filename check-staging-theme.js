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
    const credentials = Buffer.from(`${WORDPRESS_USERNAME}:${WORDPRESS_APP_PASSWORD}`).toString('base64');
    return `Basic ${credentials}`;
};

// Get current theme information
async function getCurrentTheme() {
    try {
        console.log('Fetching current theme information...');
        
        const response = await axios({
            method: 'GET',
            url: `${WORDPRESS_URL}/wp-json/wp/v2/themes`,
            headers: {
                'Authorization': getAuthHeader(),
            },
            timeout: 10000
        });

        const activeTheme = response.data.find(theme => theme.status === 'active');
        
        if (activeTheme) {
            console.log('✅ Current Active Theme:');
            console.log(`   Name: ${activeTheme.name}`);
            console.log(`   Version: ${activeTheme.version}`);
            console.log(`   Description: ${activeTheme.description}`);
            console.log(`   Theme URI: ${activeTheme.theme_uri}`);
        } else {
            console.log('No active theme found.');
        }
        
        return activeTheme;
    } catch (error) {
        if (error.response && error.response.status === 401) {
            console.error('❌ Authentication failed. Cannot fetch theme information.');
        } else if (error.response && error.response.status === 403) {
            console.error('❌ Permission denied. Your user may not have permission to view themes.');
        } else {
            console.error('❌ Error fetching theme information:', error.message);
        }
        return null;
    }
}

// Get installed plugins
async function getInstalledPlugins() {
    try {
        console.log('\nFetching installed plugins...');
        
        const response = await axios({
            method: 'GET',
            url: `${WORDPRESS_URL}/wp-json/wp/v2/plugins`,
            headers: {
                'Authorization': getAuthHeader(),
            },
            timeout: 10000
        });

        console.log(`✅ Found ${response.data.length} plugins:`);
        response.data.forEach((plugin, index) => {
            const status = plugin.status === 'active' ? '✅ Active' : '❌ Inactive';
            console.log(`   ${index + 1}. ${plugin.name} (${status})`);
        });
        
        return response.data;
    } catch (error) {
        if (error.response && error.response.status === 401) {
            console.error('❌ Authentication failed. Cannot fetch plugin information.');
        } else if (error.response && error.response.status === 403) {
            console.error('❌ Permission denied. Your user may not have permission to view plugins.');
        } else {
            console.error('❌ Error fetching plugin information:', error.message);
        }
        return null;
    }
}

// Run the functions
async function main() {
    console.log('=== WordPress Staging Site Information ===\n');
    
    await getCurrentTheme();
    await getInstalledPlugins();
    
    console.log('\n=== Next Steps for Redesign ===');
    console.log('1. For theme changes: Access WordPress admin → Appearance → Themes');
    console.log('2. For customizer settings: Access WordPress admin → Appearance → Customize');
    console.log('3. For plugin additions: Access WordPress admin → Plugins → Add New');
    console.log('4. For complete redesign: Consider installing a new theme');
}

main().catch(console.error);