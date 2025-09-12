# MANUAL XAMPP INSTALLATION GUIDE
## Step-by-Step Instructions for The Righteous Teachers Website

---

## OVERVIEW

This guide provides detailed instructions for manually downloading and installing XAMPP on Windows systems. This method is recommended when automated installation methods encounter issues.

---

## STEP 1: DOWNLOAD XAMPP

1. **Open your web browser** and navigate to:
   ```
   https://www.apachefriends.org/index.html
   ```

2. **Click the "Download" button** for Windows

3. **Save the installer file** to your Downloads folder:
   - File name will be similar to: `xampp-windows-x64-8.0.25-0-VS16-installer.exe`
   - File size is approximately 150-200 MB

---

## STEP 2: PREPARATION

1. **Close all unnecessary programs** to prevent conflicts during installation

2. **Temporarily disable antivirus software** (if possible) as it may interfere with installation

3. **Ensure you have sufficient disk space**:
   - Minimum: 1 GB free space
   - Recommended: 2 GB free space

---

## STEP 3: RUN INSTALLER AS ADMINISTRATOR

1. **Locate the downloaded installer** in your Downloads folder

2. **Right-click on the installer file** and select "Run as administrator"

3. **User Account Control Prompt**:
   - Click "Yes" to allow the installer to make changes to your device

---

## STEP 4: INSTALLATION WIZARD

### Welcome Screen
- Click "Next" to continue

### Select Components
Select the following components (ensure these are checked):
- ✅ Apache
- ✅ MySQL
- ✅ PHP
- ✅ phpMyAdmin

You may leave other components unchecked unless you have specific requirements.

### Select Installation Folder
- Keep the default location: `C:\xampp\`
- Click "Next"

### Select Language
- Choose your preferred language (English is recommended)
- Click "Next"

### Bitnami for XAMPP
- Uncheck "Learn more about Bitnami for XAMPP"
- Click "Next"

### Ready to Install
- Review your selections
- Click "Next" to begin installation

---

## STEP 5: COMPLETION

### Installation Progress
- Wait for the installation to complete (5-10 minutes)
- Do not interrupt the process

### Setup Complete
- Uncheck "Do you want to start the Control Panel now?"
- Click "Finish"

---

## STEP 6: VERIFY INSTALLATION

1. **Navigate to the XAMPP folder**:
   ```
   C:\xampp\
   ```

2. **Double-click on `xampp-control.exe`** to launch the Control Panel

3. **Verify components**:
   - You should see Apache, MySQL, and other services listed
   - All services should show "Stopped" status initially

---

## STEP 7: START SERVICES

1. **In XAMPP Control Panel**:
   - Click the "Start" button next to "Apache"
   - Click the "Start" button next to "MySQL"
   - Wait for both services to show green "Running" status

2. **Verify services are running**:
   - Apache should show port 80 (http) and 443 (https)
   - MySQL should show port 3306

---

## STEP 8: TEST INSTALLATION

1. **Open your web browser** and navigate to:
   ```
   http://localhost/
   ```

2. **You should see the XAMPP welcome page** with:
   - XAMPP logo
   - Welcome message
   - Links to documentation and tools

3. **Test phpMyAdmin**:
   - Click on "phpMyAdmin" in the navigation menu
   - You should see the phpMyAdmin interface

---

## TROUBLESHOOTING

### Common Issues and Solutions:

**1. "Access Denied" or Permission Errors:**
- Always run installer and XAMPP Control Panel as Administrator
- Right-click and select "Run as administrator"

**2. Port Conflicts:**
- If Apache fails to start, another program may be using port 80
- Common culprits: Skype, IIS, other web servers
- Solution: Change Apache ports in config or stop conflicting services

**3. Services Won't Start:**
- Check Windows Event Viewer for detailed error information
- Ensure no antivirus is blocking the services
- Try restarting your computer

**4. Missing Control Panel:**
- Verify installation completed successfully
- Check if XAMPP folder exists at `C:\xampp\`
- Reinstall if necessary

**5. Firewall Warnings:**
- Allow Apache and MySQL through Windows Firewall
- Click "Allow access" for both private and public networks

---

## NEXT STEPS

After successfully installing and starting XAMPP:

1. **Run `start-local-dev.bat`** from your WordPress CLI directory

2. **Select "Automated WordPress Setup"** to continue with WordPress configuration

3. **Follow the prompts** to set up your local WordPress environment

---

## ALTERNATIVE INSTALLATION LOCATIONS

If you cannot install to `C:\xampp\`, you can choose an alternative location:

1. **During installation**, when prompted for installation folder:
   - Click "Browse"
   - Select an alternative location with sufficient space
   - Examples:
     - `D:\xampp\`
     - `C:\Program Files\xampp\`
     - `C:\Users\[YourUsername]\xampp\`

2. **Update paths in scripts** if using non-default location:
   - WordPress directory: `[XAMPP_PATH]\htdocs\therighteousteachers`
   - phpMyAdmin: `http://localhost:[PORT]/phpmyadmin`

---

## SECURITY CONSIDERATIONS

1. **Development Only**: XAMPP is intended for development purposes only
2. **Firewall**: Configure Windows Firewall to allow Apache and MySQL
3. **Remote Access**: By default, XAMPP is configured for local access only
4. **Passwords**: Default MySQL root password is empty - change for production

---

**Installation Guide**: Manual XAMPP Installation
**Target System**: Windows 10/11
**Status**: Ready for Implementation