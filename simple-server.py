#!/usr/bin/env python3
"""
Simple HTTP Server for testing WordPress files
This is a basic server for testing purposes only.
For full WordPress functionality, use XAMPP with Apache and MySQL.
"""

import http.server
import socketserver
import os
import webbrowser
import threading
import time

# Check if we're in the right directory
current_dir = os.getcwd()
print(f"Current directory: {current_dir}")

# Look for WordPress files
wp_dirs = [
    "C:\\Users\\tjd20.LAPTOP-PCMC2SUO\\local-wordpress",
    "C:\\Users\\tjd20.LAPTOP-PCMC2SUO\\wordpress",
    "C:\\Users\\tjd20.LAPTOP-PCMC2SUO\\wordpress-local-test",
    "."
]

# Find a directory with WordPress files
wp_dir = None
for directory in wp_dirs:
    if os.path.exists(directory):
        # Check if it contains WordPress files
        if os.path.exists(os.path.join(directory, "wp-config.php")) or \
           os.path.exists(os.path.join(directory, "wp-content")) or \
           os.path.exists(os.path.join(directory, "wp-includes")):
            wp_dir = directory
            break

if wp_dir:
    print(f"Found WordPress files in: {wp_dir}")
    os.chdir(wp_dir)
else:
    print("No WordPress installation found. Using current directory.")

PORT = 8000

class MyHttpRequestHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        # Handle WordPress-style URLs
        if self.path.endswith('/'):
            # Check for index files
            if os.path.exists('index.php'):
                self.path = '/index.php'
            elif os.path.exists('index.html'):
                self.path = '/index.html'
        
        # If no file extension, try .php first for WordPress
        if not '.' in self.path.split('/')[-1] and not self.path.endswith('/'):
            if os.path.exists(self.path + '.php'):
                self.path += '.php'
        
        return http.server.SimpleHTTPRequestHandler.do_GET(self)

Handler = MyHttpRequestHandler

try:
    with socketserver.TCPServer(("", PORT), Handler) as httpd:
        print(f"Server started at http://localhost:{PORT}")
        print("Press Ctrl+C to stop the server")
        
        # Open browser in a separate thread
        def open_browser():
            time.sleep(1)
            webbrowser.open(f'http://localhost:{PORT}')
        
        browser_thread = threading.Thread(target=open_browser)
        browser_thread.daemon = True
        browser_thread.start()
        
        # Start the server
        httpd.serve_forever()
        
except KeyboardInterrupt:
    print("\nServer stopped.")
except OSError as e:
    if "Address already in use" in str(e):
        print(f"Port {PORT} is already in use. Try a different port:")
        print(f"python simple-server.py 8001")
    else:
        print(f"Error starting server: {e}")
except Exception as e:
    print(f"Error: {e}")