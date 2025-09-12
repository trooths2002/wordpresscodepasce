<?php
/**
 * Test connection to staging site
 *
 * ## OPTIONS
 *
 * [--format=<format>]
 * : Render output in a particular format.
 * ---
 * default: table
 * options:
 *   - table
 *   - json
 *   - csv
 *   - yaml
 *   - count
 * ---
 *
 * ## EXAMPLES
 *
 *     wp staging-test
 */

function wp_staging_test( $args, $assoc_args ) {
    // Load environment variables
    $env_file = __DIR__ . '/mcp-wordpress-server/.env';
    if (file_exists($env_file)) {
        $lines = file($env_file, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
        foreach ($lines as $line) {
            if (strpos($line, '=') !== false && strpos($line, '#') !== 0) {
                list($key, $value) = explode('=', $line, 2);
                $_ENV[trim($key)] = trim($value);
            }
        }
    }
    
    $wordpress_url = $_ENV['WORDPRESS_URL'] ?? '';
    $username = $_ENV['WORDPRESS_USERNAME'] ?? '';
    $app_password = $_ENV['WORDPRESS_APP_PASSWORD'] ?? '';
    
    if (empty($wordpress_url) || empty($username) || empty($app_password)) {
        WP_CLI::error('Missing environment variables. Please check your .env file.');
        return;
    }
    
    // Create authorization header
    $credentials = base64_encode("$username:$app_password");
    $auth_header = "Authorization: Basic $credentials";
    
    // Test connection
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, "$wordpress_url/wp-json/wp/v2/posts?per_page=1");
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'Content-Type: application/json',
        $auth_header
    ]);
    curl_setopt($ch, CURLOPT_TIMEOUT, 30);
    
    $response = curl_exec($ch);
    $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $error = curl_error($ch);
    curl_close($ch);
    
    if ($error) {
        WP_CLI::error("cURL Error: $error");
        return;
    }
    
    if ($http_code !== 200) {
        WP_CLI::error("HTTP Error: $http_code");
        return;
    }
    
    $posts = json_decode($response, true);
    
    if (json_last_error() !== JSON_ERROR_NONE) {
        WP_CLI::error('Invalid JSON response: ' . json_last_error_msg());
        return;
    }
    
    if (empty($posts)) {
        WP_CLI::success('Connected successfully, but no posts found.');
        return;
    }
    
    $post = $posts[0];
    WP_CLI::success('Connected successfully!');
    WP_CLI::line("Latest post: " . $post['title']['rendered']);
    WP_CLI::line("Post ID: " . $post['id']);
    WP_CLI::line("Post URL: " . $post['link']);
}

WP_CLI::add_command('staging-test', 'wp_staging_test');