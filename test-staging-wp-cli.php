<?php
// Load environment variables
$env_file = __DIR__ . '/mcp-wordpress-server/.env';
if (!file_exists($env_file)) {
    die("Environment file not found: $env_file\n");
}

$lines = file($env_file, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
$env_vars = [];
foreach ($lines as $line) {
    if (strpos($line, '=') !== false && strpos($line, '#') !== 0) {
        list($key, $value) = explode('=', $line, 2);
        $env_vars[trim($key)] = trim($value);
    }
}

$wordpress_url = $env_vars['WORDPRESS_URL'] ?? '';
$username = $env_vars['WORDPRESS_USERNAME'] ?? '';
$app_password = $env_vars['WORDPRESS_APP_PASSWORD'] ?? '';

if (empty($wordpress_url) || empty($username) || empty($app_password)) {
    die("Missing environment variables. Please check your .env file.\n");
}

echo "Testing connection to: $wordpress_url\n";
echo "Username: $username\n";

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
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); // Only for testing, should be true in production

$response = curl_exec($ch);
$http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
$error = curl_error($ch);
curl_close($ch);

if ($error) {
    die("cURL Error: $error\n");
}

echo "HTTP Status Code: $http_code\n";

if ($http_code !== 200) {
    die("Failed to connect to WordPress REST API\n");
}

$posts = json_decode($response, true);

if (json_last_error() !== JSON_ERROR_NONE) {
    die('Invalid JSON response: ' . json_last_error_msg() . "\n");
}

if (empty($posts)) {
    echo "Connected successfully, but no posts found.\n";
    exit(0);
}

$post = $posts[0];
echo "Connected successfully!\n";
echo "Latest post: " . $post['title']['rendered'] . "\n";
echo "Post ID: " . $post['id'] . "\n";
echo "Post URL: " . $post['link'] . "\n";