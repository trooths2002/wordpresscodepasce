# PowerShell Script to Automate WordPress Setup
# For The Righteous Teachers Website Development

Write-Host "=============================================="
Write-Host "  The Righteous Teachers - WordPress Setup"
Write-Host "=============================================="
Write-Host ""

# Check if XAMPP is installed
Write-Host "Checking if XAMPP is installed..."
if (Test-Path "C:\xampp") {
    Write-Host "XAMPP is installed"
} else {
    Write-Host "XAMPP is not installed"
    Write-Host "Please install XAMPP first using the installation guide."
    exit
}

# Create WordPress directory
Write-Host "Creating WordPress directory..."
$wordpressPath = "C:\xampp\htdocs\therighteousteachers"
if (!(Test-Path $wordpressPath)) {
    New-Item -ItemType Directory -Path $wordpressPath
    Write-Host "Created directory: $wordpressPath"
} else {
    Write-Host "Directory already exists: $wordpressPath"
}

Write-Host ""
Write-Host "=============================================="
Write-Host "  WordPress Directory Setup Complete!"
Write-Host "=============================================="
Write-Host ""
Write-Host "Next steps:"
Write-Host "1. Download WordPress from https://wordpress.org/latest.zip"
Write-Host "2. Extract to $wordpressPath"
Write-Host "3. Start XAMPP Control Panel"
Write-Host "4. Ensure Apache and MySQL services are running"
Write-Host "5. Open phpMyAdmin at http://localhost/phpmyadmin"
Write-Host "6. Create a database named 'therighteousteachers'"
Write-Host "7. Run WordPress installation at http://localhost/therighteousteachers"