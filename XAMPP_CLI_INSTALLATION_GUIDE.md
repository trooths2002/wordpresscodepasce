# XAMPP CLI INSTALLATION GUIDE
## Command Line Installation Methods for Windows

---

## OVERVIEW

This guide provides multiple methods to install XAMPP using command-line interfaces (CLI) on Windows systems. These methods are useful for automated deployments, scripted installations, or when you prefer command-line tools over graphical installers.

---

## METHOD 1: DIRECT DOWNLOAD AND SILENT INSTALLATION

### Using PowerShell to Download and Install

1. **Download XAMPP Installer:**
```powershell
Invoke-WebRequest -Uri "https://www.apachefriends.org/xampp-files/8.0.25/xampp-windows-x64-8.0.25-0-VS16-installer.exe" -OutFile "xampp-installer.exe"
```

2. **Silent Installation:**
```cmd
xampp-installer.exe --mode unattended
```

3. **Complete Script:**
```batch
@echo off
echo Downloading XAMPP...
powershell -Command "Invoke-WebRequest -Uri 'https://www.apachefriends.org/xampp-files/8.0.25/xampp-windows-x64-8.0.25-0-VS16-installer.exe' -OutFile 'xampp-installer.exe'"
echo Installing XAMPP silently...
xampp-installer.exe --mode unattended
echo Cleaning up...
del xampp-installer.exe
echo Installation complete!
```

### Available Silent Installation Parameters:
- `--mode unattended` - No user interaction required
- `--prefix C:\xampp` - Install to specific directory
- `--xampp_port_http 80` - Set Apache port
- `--xampp_port_https 443` - Set HTTPS port
- `--xampp_port_mysql 3306` - Set MySQL port

---

## METHOD 2: USING CHOCOLATEY

### Installing Chocolatey (if not already installed):
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

### Installing XAMPP:
```cmd
choco install xampp -y
```

### Additional Chocolatey Commands:
```cmd
# Upgrade XAMPP
choco upgrade xampp -y

# Uninstall XAMPP
choco uninstall xampp -y

# List XAMPP package info
choco info xampp
```

---

## METHOD 3: USING WINGET (WINDOWS PACKAGE MANAGER)

### Installing XAMPP:
```cmd
winget install -e --id XAMPP.XAMPP
```

### Additional Winget Commands:
```cmd
# Upgrade XAMPP
winget upgrade -e --id XAMPP.XAMPP

# Uninstall XAMPP
winget uninstall -e --id XAMPP.XAMPP

# Search for XAMPP
winget search xampp
```

---

## METHOD 4: USING WINDOWS SUBSYSTEM FOR LINUX (WSL)

### For Ubuntu/Debian-based WSL:
```bash
# Update package list
sudo apt update

# Install tasksel
sudo apt install tasksel

# Install LAMP stack (Linux, Apache, MySQL, PHP)
sudo tasksel install lamp-server

# Or install individual components
sudo apt install apache2
sudo apt install mysql-server
sudo apt install php libapache2-mod-php php-mysql
```

---

## AUTOMATED INSTALLATION SCRIPTS

### PowerShell Script (install-xampp-with-choco.ps1):
```powershell
# Check if Chocolatey is installed
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

# Install XAMPP
Write-Host "Installing XAMPP..."
choco install xampp -y
Write-Host "XAMPP installation complete!"
```

### Batch Script (install-xampp-silently.bat):
```batch
@echo off
echo Downloading XAMPP installer...
powershell -Command "Invoke-WebRequest -Uri 'https://www.apachefriends.org/xampp-files/8.0.25/xampp-windows-x64-8.0.25-0-VS16-installer.exe' -OutFile 'xampp-installer.exe'"
echo Installing XAMPP silently...
xampp-installer.exe --mode unattended
echo Cleaning up installer...
del xampp-installer.exe
echo XAMPP installation complete!
pause
```

---

## POST-INSTALLATION CONFIGURATION

### Starting Services via Command Line:
```cmd
# Start Apache service
net start Apache

# Start MySQL service
net start MySQL

# Or using XAMPP Control CLI
C:\xampp\xampp_start.exe
```

### Stopping Services via Command Line:
```cmd
# Stop Apache service
net stop Apache

# Stop MySQL service
net stop MySQL

# Or using XAMPP Control CLI
C:\xampp\xampp_stop.exe
```

---

## TROUBLESHOOTING

### Common Issues:

**1. "Access Denied" Errors:**
- Run Command Prompt or PowerShell as Administrator
- Ensure Windows Defender or antivirus isn't blocking installation

**2. "File Not Found" Errors:**
- Check internet connection
- Verify download URL is correct
- Ensure sufficient disk space

**3. Port Conflicts:**
- Change default ports during installation
- Stop conflicting services before installation

**4. Silent Installation Not Working:**
- Check installer version supports silent mode
- Verify command-line parameters are correct

---

## VERIFICATION

### Check Installation:
```cmd
# Check if XAMPP directory exists
dir C:\xampp

# Check if services are running
sc query Apache
sc query MySQL

# Check if ports are listening
netstat -an | findstr "80"
netstat -an | findstr "3306"
```

---

## SECURITY CONSIDERATIONS

1. **Always download from official sources**
2. **Verify installer checksums when available**
3. **Run services with minimal required privileges**
4. **Configure firewall rules appropriately**
5. **Keep XAMPP updated with security patches**

---

## NEXT STEPS

After installing XAMPP via CLI:

1. **Start XAMPP services:**
   - Run `C:\xampp\xampp-control.exe`
   - Start Apache and MySQL services

2. **Verify installation:**
   - Visit `http://localhost` in your browser
   - You should see the XAMPP welcome page

3. **Continue WordPress setup:**
   - Run `start-local-dev.bat`
   - Select "Automated WordPress Setup"

---

**Installation Guide**: CLI Methods for XAMPP
**Target System**: Windows 10/11
**Status**: Ready for Implementation