# XAMPP INSTALLATION GUIDE
## For The Righteous Teachers Website Development

---

## STEP 1: DOWNLOAD XAMPP

1. Open your web browser and go to: https://www.apachefriends.org/index.html
2. Click on the "Download" button for Windows
3. Save the installer file to your Downloads folder

---

## STEP 2: INSTALL XAMPP

### Option A: Graphical Installer (Recommended for beginners)
1. Locate the downloaded XAMPP installer file (e.g., `xampp-windows-x64-8.0.25-0-VS16-installer.exe`)
2. Right-click on the file and select "Run as administrator"
3. In the setup wizard:
   - Click "Next"
   - Select components to install:
     - ✅ Apache
     - ✅ MySQL
     - ✅ PHP
     - ✅ phpMyAdmin
     - (You can leave other components unchecked)
   - Click "Next"
   - Choose installation folder: `C:\xampp\`
   - Click "Next"
   - Select your language (English is fine)
   - Click "Next"
   - Uncheck "Do you want to start the Control Panel now?"
   - Click "Next"
   - Click "Finish"

### Option B: Command Line Installation (CLI Methods)
For automated or scripted installations, you can use several CLI methods:

1. **Direct PowerShell Download and Silent Install**:
   ```powershell
   Invoke-WebRequest -Uri "https://www.apachefriends.org/xampp-files/8.0.25/xampp-windows-x64-8.0.25-0-VS16-installer.exe" -OutFile "xampp-installer.exe"
   xampp-installer.exe --mode unattended
   ```

2. **Chocolatey Package Manager**:
   ```cmd
   choco install xampp -y
   ```

3. **WSL (Windows Subsystem for Linux)**:
   ```bash
   sudo apt update
   sudo apt install apache2 mysql-server php libapache2-mod-php php-mysql
   ```

For detailed CLI installation methods, see `XAMPP_CLI_INSTALLATION_GUIDE.md`

---

## STEP 3: START XAMPP SERVICES

1. Navigate to `C:\xampp\` and double-click on `xampp-control.exe`
2. In the XAMPP Control Panel:
   - Click the "Start" button next to "Apache"
   - Click the "Start" button next to "MySQL"
   - Wait until both services show a green "Running" status
   - Minimize the control panel (do not close it)

---

## STEP 4: VERIFY INSTALLATION

1. Open your web browser
2. Go to: http://localhost/
3. You should see the XAMPP welcome page
4. Click on "phpMyAdmin" in the top navigation bar
5. You should see the phpMyAdmin interface

---

## TROUBLESHOOTING

### If Apache won't start:
- Make sure no other programs are using port 80
- Try stopping Skype or other applications that might use port 80
- Change Apache port in config if needed

### If MySQL won't start:
- Make sure no other MySQL instances are running
- Check if port 3306 is being used by another program

### If you get Windows Firewall warnings:
- Click "Allow access" for both private and public networks

---

## NEXT STEPS

After completing XAMPP installation, you can proceed with:
1. Downloading and installing WordPress
2. Configuring WordPress with your database
3. Importing your existing site content
4. Setting up your development workflow

---

**Setup Manager**: Digital Manager
**Target Completion**: 
**Status**: Installation Guide Ready