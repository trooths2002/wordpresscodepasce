# PowerShell Script to Install XAMPP using Chocolatey
# For The Righteous Teachers Website Development

Write-Host "==============================================" -ForegroundColor Green
Write-Host "  XAMPP Installation via Chocolatey" -ForegroundColor Green
Write-Host "==============================================" -ForegroundColor Green
Write-Host ""

# Check if Chocolatey is installed
Write-Host "Checking if Chocolatey is installed..." -ForegroundColor Yellow
$chocoInstalled = $false
try {
    $chocoVersion = choco --version 2>$null
    if ($chocoVersion) {
        Write-Host "✓ Chocolatey version $chocoVersion is installed" -ForegroundColor Green
        $chocoInstalled = $true
    }
} catch {
    Write-Host "✗ Chocolatey is not installed" -ForegroundColor Red
}

if (-not $chocoInstalled) {
    Write-Host ""
    Write-Host "Installing Chocolatey..." -ForegroundColor Yellow
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    
    # Refresh environment variables
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    
    Write-Host "✓ Chocolatey installed successfully" -ForegroundColor Green
}

Write-Host ""
Write-Host "Installing XAMPP..." -ForegroundColor Yellow
try {
    choco install xampp -y
    Write-Host "✓ XAMPP installed successfully" -ForegroundColor Green
    Write-Host ""
    Write-Host "Starting XAMPP services..." -ForegroundColor Yellow
    Start-Process -FilePath "C:\xampp\xampp-control.exe" -PassThru
    Write-Host "✓ XAMPP Control Panel started" -ForegroundColor Green
} catch {
    Write-Host "✗ Failed to install XAMPP: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "==============================================" -ForegroundColor Green
Write-Host "  XAMPP Installation Complete!" -ForegroundColor Green
Write-Host "==============================================" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. In XAMPP Control Panel, start Apache and MySQL services" -ForegroundColor Cyan
Write-Host "2. Run start-local-dev.bat to continue WordPress setup" -ForegroundColor Cyan
Write-Host ""
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")