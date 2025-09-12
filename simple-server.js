const http = require('http');
const fs = require('fs');
const path = require('path');
const url = require('url');

// Check if Node.js is available
console.log('Node.js version:', process.version);

// Define the port
const PORT = 8000;

// Look for WordPress directories
const wpDirs = [
    'C:/Users/tjd20.LAPTOP-PCMC2SUO/local-wordpress',
    'C:/Users/tjd20.LAPTOP-PCMC2SUO/wordpress',
    'C:/Users/tjd20.LAPTOP-PCMC2SUO/wordpress-local-test',
    '.'
];

let wpDir = '.';
for (const directory of wpDirs) {
    if (fs.existsSync(directory)) {
        // Check if it contains WordPress files
        if (fs.existsSync(path.join(directory, 'wp-config.php')) || 
            fs.existsSync(path.join(directory, 'wp-content')) || 
            fs.existsSync(path.join(directory, 'wp-includes'))) {
            wpDir = directory;
            break;
        }
    }
}

console.log(`Serving files from: ${wpDir}`);
process.chdir(wpDir);

// MIME types
const mimeTypes = {
    '.html': 'text/html',
    '.php': 'text/html', // We'll serve PHP files as HTML for simplicity
    '.css': 'text/css',
    '.js': 'text/javascript',
    '.json': 'application/json',
    '.png': 'image/png',
    '.jpg': 'image/jpeg',
    '.gif': 'image/gif',
    '.svg': 'image/svg+xml',
    '.ico': 'image/x-icon'
};

// Create the server
const server = http.createServer((req, res) => {
    const parsedUrl = url.parse(req.url);
    let pathname = `.${parsedUrl.pathname}`;
    
    // Handle directory requests
    if (pathname.endsWith('/')) {
        pathname += 'index.html';
    }
    
    // Handle PHP files (serve as static for testing)
    if (pathname.endsWith('.php')) {
        // For WordPress, we'll try to serve index.html instead
        pathname = pathname.replace('.php', '.html');
        if (!fs.existsSync(pathname)) {
            pathname = pathname.replace('.html', '/index.html');
        }
    }
    
    const ext = path.parse(pathname).ext;
    const map = mimeTypes[ext] || 'text/plain';
    
    fs.exists(pathname, (exist) => {
        if (!exist) {
            // File not found, send 404
            res.statusCode = 404;
            res.end(`File ${pathname} not found!`);
            return;
        }
        
        // If is a directory, then look for index.html
        if (fs.statSync(pathname).isDirectory()) {
            pathname += '/index.html';
        }
        
        // Read file from file system
        fs.readFile(pathname, (err, data) => {
            if (err) {
                res.statusCode = 500;
                res.end(`Error getting the file: ${err}.`);
            } else {
                // If the file is found, set Content-Type and send data
                res.setHeader('Content-type', map);
                res.end(data);
            }
        });
    });
});

// Start the server
server.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}/`);
    console.log('Press Ctrl+C to stop the server');
    
    // Try to open the browser
    try {
        const { exec } = require('child_process');
        exec(`start http://localhost:${PORT}`, (error) => {
            if (error) {
                console.log('Could not open browser automatically');
            }
        });
    } catch (e) {
        console.log('Could not open browser automatically');
    }
});

// Handle graceful shutdown
process.on('SIGINT', () => {
    console.log('\nServer stopped.');
    process.exit(0);
});