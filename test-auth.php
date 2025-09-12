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

echo "Testing authentication...\n";
echo "URL: $wordpress_url\n";
echo "Username: $username\n";
echo "Password: $app_password\n\n";

// Create authorization header
$credentials = base64_encode("$username:$app_password");
$auth_header = "Authorization: Basic $credentials";

echo "Authorization header: $auth_header\n\n";

// Test authentication by trying to get user info
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, "$wordpress_url/wp-json/wp/v2/users/me");
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_HTTPHEADER, [
    'Content-Type: application/json',
    $auth_header
]);
curl_setopt($ch, CURLOPT_TIMEOUT, 30);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);

$response = curl_exec($ch);
$http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
$error = curl_error($ch);
curl_close($ch);

echo "HTTP Status Code: $http_code\n";

if ($error) {
    die("cURL Error: $error\n");
}

if ($http_code === 200) {
    echo "✅ Authentication successful!\n";
    $user = json_decode($response, true);
    if ($user && isset($user['name'])) {
        echo "Authenticated as: " . $user['name'] . "\n";
    }
} else if ($http_code === 401) {
    echo "❌ Authentication failed (401 Unauthorized)\n";
    echo "This usually means the username or Application Password is incorrect.\n";
    echo "Please verify:\n";
    echo "1. The username is correct\n";
    echo "2. The Application Password is correct and hasn't expired\n";
    echo "3. The Application Password was created for this specific user\n";
} else if ($http_code === 403) {
    echo "❌ Access forbidden (403 Forbidden)\n";
    echo "The user exists but doesn't have permission to access this resource.\n";
} else {
    echo "Unexpected response. HTTP code: $http_code\n";
    echo "Response: $response\n";
}