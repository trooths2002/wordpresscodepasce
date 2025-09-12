const fs = require('fs');
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

// List posts
async function listPosts() {
    try {
        console.log(`Fetching posts from: ${WORDPRESS_URL}`);
        
        const response = await axios({
            method: 'GET',
            url: `${WORDPRESS_URL}/wp-json/wp/v2/posts`,
            headers: {
                'Authorization': getAuthHeader(),
            },
            params: {
                per_page: 5,
                _embed: false
            },
            timeout: 10000
        });

        console.log(`Found ${response.data.length} posts:`);
        response.data.forEach((post, index) => {
            console.log(`${index + 1}. ${post.title.rendered} (ID: ${post.id})`);
        });
        
        return response.data;
    } catch (error) {
        console.error('Error fetching posts:', error.message);
        if (error.response) {
            console.error(`Status: ${error.response.status}`);
        }
        return [];
    }
}

// Get a specific post
async function getPost(postId) {
    try {
        console.log(`Fetching post ID ${postId} from: ${WORDPRESS_URL}`);
        
        const response = await axios({
            method: 'GET',
            url: `${WORDPRESS_URL}/wp-json/wp/v2/posts/${postId}`,
            headers: {
                'Authorization': getAuthHeader(),
            },
            timeout: 10000
        });

        console.log(`Post found: ${response.data.title.rendered}`);
        console.log(`Content preview: ${response.data.content.rendered.substring(0, 100)}...`);
        
        return response.data;
    } catch (error) {
        console.error('Error fetching post:', error.message);
        if (error.response) {
            console.error(`Status: ${error.response.status}`);
        }
        return null;
    }
}

// Create a new post
async function createPost(title, content, status = 'draft') {
    try {
        console.log(`Creating new post: ${title}`);
        
        const response = await axios({
            method: 'POST',
            url: `${WORDPRESS_URL}/wp-json/wp/v2/posts`,
            headers: {
                'Authorization': getAuthHeader(),
                'Content-Type': 'application/json',
            },
            data: {
                title,
                content,
                status
            },
            timeout: 15000
        });

        console.log(`Post created successfully with ID: ${response.data.id}`);
        console.log(`Status: ${response.data.status}`);
        
        return response.data;
    } catch (error) {
        console.error('Error creating post:', error.message);
        if (error.response) {
            console.error(`Status: ${error.response.status}`);
            console.error(`Error details: ${JSON.stringify(error.response.data)}`);
        }
        return null;
    }
}

// Update an existing post
async function updatePost(postId, updates) {
    try {
        console.log(`Updating post ID ${postId}`);
        
        const response = await axios({
            method: 'POST',
            url: `${WORDPRESS_URL}/wp-json/wp/v2/posts/${postId}`,
            headers: {
                'Authorization': getAuthHeader(),
                'Content-Type': 'application/json',
            },
            data: updates,
            timeout: 15000
        });

        console.log(`Post updated successfully`);
        console.log(`Title: ${response.data.title.rendered}`);
        console.log(`Status: ${response.data.status}`);
        
        return response.data;
    } catch (error) {
        console.error('Error updating post:', error.message);
        if (error.response) {
            console.error(`Status: ${error.response.status}`);
            console.error(`Error details: ${JSON.stringify(error.response.data)}`);
        }
        return null;
    }
}

// Main function to demonstrate usage
async function main() {
    console.log('=== WordPress Staging Site Management Tool ===\n');
    
    console.log('1. Listing recent posts:');
    const posts = await listPosts();
    
    if (posts.length > 0) {
        console.log('\n2. Getting details of the first post:');
        await getPost(posts[0].id);
    }
    
    console.log('\n3. Creating a test post:');
    const newPost = await createPost(
        'Test Post from CLI',
        'This is a test post created via the WordPress REST API using a CLI tool.',
        'draft'
    );
    
    if (newPost) {
        console.log('\n4. Updating the test post:');
        await updatePost(newPost.id, {
            title: 'Updated Test Post from CLI',
            content: 'This is an updated test post created via the WordPress REST API using a CLI tool.',
            status: 'draft'
        });
    }
    
    console.log('\n=== Management Tool Completed ===');
}

// Run the main function if this script is executed directly
if (require.main === module) {
    main().catch(console.error);
}

// Export functions for use in other scripts
module.exports = {
    listPosts,
    getPost,
    createPost,
    updatePost
};