const fs = require('fs');
const path = require('path');

console.log('==============================================');
console.log('  The Righteous Teachers - Setup Verification');
console.log('==============================================');
console.log();

// Check if required files exist
const requiredFiles = [
  'wp-cli.phar',
  'therighteousteachers.WordPress.2025-09-11.xml',
  'mcp-wordpress-server/.env',
  'mcp-wordpress-server/.env.staging',
  'mcp-wordpress-server/.env.production'
];

console.log('Checking required files...');
let allFilesFound = true;

requiredFiles.forEach(file => {
  const fullPath = path.join(__dirname, file);
  if (fs.existsSync(fullPath)) {
    console.log(`✓ ${file} - Found`);
  } else {
    console.log(`✗ ${file} - Missing`);
    allFilesFound = false;
  }
});

console.log();

// Check if XAMPP is installed
console.log('Checking XAMPP installation...');
const xamppPath = 'C:\\xampp';
if (fs.existsSync(xamppPath)) {
  console.log('✓ XAMPP - Installed');
} else {
  console.log('✗ XAMPP - Not found (Install from XAMPP_INSTALLATION_GUIDE.md)');
}

console.log();

// Check if local WordPress directory exists
console.log('Checking local WordPress directory...');
const wordpressPath = 'C:\\xampp\\htdocs\\therighteousteachers';
if (fs.existsSync(wordpressPath)) {
  console.log('✓ Local WordPress directory - Found');
} else {
  console.log('⚠ Local WordPress directory - Not found (Will be created during setup)');
}

console.log();

// Check MCP server configuration
console.log('Checking MCP server configuration...');
const envPath = path.join(__dirname, 'mcp-wordpress-server', '.env');
if (fs.existsSync(envPath)) {
  const envContent = fs.readFileSync(envPath, 'utf8');
  if (envContent.includes('WORDPRESS_URL') && envContent.includes('WORDPRESS_USERNAME')) {
    console.log('✓ MCP server configuration - Found and appears valid');
  } else {
    console.log('⚠ MCP server configuration - Found but may be incomplete');
  }
} else {
  console.log('✗ MCP server configuration - Missing');
}

console.log();

// Summary
console.log('==============================================');
console.log('  Verification Summary');
console.log('==============================================');

if (allFilesFound) {
  console.log('✓ All required files are present');
} else {
  console.log('✗ Some required files are missing');
}

console.log();
console.log('Next steps:');
console.log('1. If XAMPP is not installed, install it using XAMPP_INSTALLATION_GUIDE.md');
console.log('2. Run start-local-dev.bat to begin the setup process');
console.log('3. Follow the automated setup wizard');
console.log();

console.log('For detailed instructions, see COMPLETE_LOCAL_SETUP_GUIDE.md');