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
            console.log(`${index + 1}. ${post.title.rendered} (ID: ${post.id}, Status: ${post.status})`);
        });
        
        return response.data;
    } catch (error) {
        console.error('Error fetching posts:', error.message);
        return [];
    }
}

// Create a new post
async function createPost(title, content, status = 'draft') {
    try {
        console.log(`Creating new post: "${title}"`);
        
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

        console.log(`✅ Post created successfully!`);
        console.log(`   ID: ${response.data.id}`);
        console.log(`   Title: ${response.data.title.rendered}`);
        console.log(`   Status: ${response.data.status}`);
        console.log(`   URL: ${response.data.link}`);
        
        return response.data;
    } catch (error) {
        console.error('❌ Error creating post:', error.message);
        if (error.response) {
            console.error(`   Status: ${error.response.status}`);
            console.error(`   Message: ${error.response.data.message || 'No additional message'}`);
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

        console.log(`✅ Post updated successfully!`);
        console.log(`   Title: ${response.data.title.rendered}`);
        console.log(`   Status: ${response.data.status}`);
        
        return response.data;
    } catch (error) {
        console.error('❌ Error updating post:', error.message);
        if (error.response) {
            console.error(`   Status: ${error.response.status}`);
            console.error(`   Message: ${error.response.data.message || 'No additional message'}`);
        }
        return null;
    }
}

// Delete a post
async function deletePost(postId) {
    try {
        console.log(`Deleting post ID ${postId}`);
        
        const response = await axios({
            method: 'DELETE',
            url: `${WORDPRESS_URL}/wp-json/wp/v2/posts/${postId}`,
            headers: {
                'Authorization': getAuthHeader(),
            },
            params: {
                force: true // Permanently delete
            },
            timeout: 15000
        });

        console.log(`✅ Post deleted successfully!`);
        return response.data;
    } catch (error) {
        console.error('❌ Error deleting post:', error.message);
        if (error.response) {
            console.error(`   Status: ${error.response.status}`);
            console.error(`   Message: ${error.response.data.message || 'No additional message'}`);
        }
        return null;
    }
}

// Main function to demonstrate usage
async function main() {
    console.log('=== WordPress Staging Site Change Management ===\n');
    
    // Show current posts
    console.log('1. Current posts in staging:');
    const posts = await listPosts();
    
    // Example: Create a new test post
    console.log('\n2. Creating a test post:');
    const newPost = await createPost(
        'Test Post from CLI Script',
        '<p>This is a test post created via the CLI script. You can edit this content as needed.</p>',
        'draft' // Start as draft, can be published later
    );
    
    if (newPost) {
        // Example: Update the test post
        console.log('\n3. Updating the test post:');
        await updatePost(newPost.id, {
            title: 'Updated Test Post from CLI Script',
            content: '<p>This is an updated test post created via the CLI script. The content has been modified.</p>',
            status: 'draft'
        });
        
        // Example: Publish the post
        console.log('\n4. Publishing the test post:');
        await updatePost(newPost.id, {
            status: 'publish'
        });
        
        console.log('\n5. Final post list:');
        await listPosts();
    }
    
    console.log('\n=== Change Management Completed ===');
    console.log('\nNext steps:');
    console.log('- Check your staging site to see the new post');
    console.log('- You can run this script again to create more posts');
    console.log('- Modify the script to perform different actions');
}

// Run specific actions based on command line arguments
async function runAction() {
    const args = process.argv.slice(2);
    
    if (args.length === 0) {
        // Run the full demo
        await main();
        return;
    }
    
    const action = args[0];
    
    switch (action) {
        case 'list':
            await listPosts();
            break;
            
        case 'create':
            if (args.length >= 3) {
                const title = args[1];
                const content = args[2];
                const status = args[3] || 'draft';
                await createPost(title, content, status);
            } else {
                console.log('Usage: node make-staging-changes.js create "Title" "Content" [status]');
            }
            break;
            
        case 'update':
            if (args.length >= 3) {
                const postId = parseInt(args[1]);
                const updates = {};
                
                // Parse updates from remaining arguments
                for (let i = 2; i < args.length; i++) {
                    const [key, value] = args[i].split('=');
                    if (key && value) {
                        updates[key] = value;
                    }
                }
                
                if (Object.keys(updates).length > 0) {
                    await updatePost(postId, updates);
                } else {
                    console.log('No updates provided');
                }
            } else {
                console.log('Usage: node make-staging-changes.js update postId key1=value1 key2=value2');
            }
            break;
            
        default:
            console.log('Available actions: list, create, update');
            console.log('Run without arguments for full demo');
    }
}

// Run the script
if (require.main === module) {
    runAction().catch(console.error);
}

// Export functions for use in other scripts
module.exports = {
    listPosts,
    createPost,
    updatePost,
    deletePost
};