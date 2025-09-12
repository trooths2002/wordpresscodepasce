@echo off
cls
title The Righteous Teachers - Setup Verification
echo ==============================================
echo   The Righteous Teachers - Setup Verification
echo ==============================================
echo.

echo Checking required files...
echo ------------------------

if exist "wp-cli.phar" (
    echo ✓ wp-cli.phar - Found
) else (
    echo ✗ wp-cli.phar - Missing
)

if exist "therighteousteachers.WordPress.2025-09-11.xml" (
    echo ✓ therighteousteachers.WordPress.2025-09-11.xml - Found
) else (
    echo ✗ therighteousteachers.WordPress.2025-09-11.xml - Missing
)

if exist "mcp-wordpress-server\.env" (
    echo ✓ mcp-wordpress-server\.env - Found
) else (
    echo ✗ mcp-wordpress-server\.env - Missing
)

if exist "mcp-wordpress-server\.env.staging" (
    echo ✓ mcp-wordpress-server\.env.staging - Found
) else (
    echo ✗ mcp-wordpress-server\.env.staging - Missing
)

if exist "mcp-wordpress-server\.env.production" (
    echo ✓ mcp-wordpress-server\.env.production - Found
) else (
    echo ✗ mcp-wordpress-server\.env.production - Missing
)

echo.
echo Checking XAMPP installation...
echo ----------------------------
if exist "C:\xampp" (
    echo ✓ XAMPP - Installed
) else (
    echo ✗ XAMPP - Not found (Install from XAMPP_INSTALLATION_GUIDE.md)
)

echo.
echo Checking local WordPress directory...
echo ----------------------------------
if exist "C:\xampp\htdocs\therighteousteachers" (
    echo ✓ Local WordPress directory - Found
) else (
    echo ⚠ Local WordPress directory - Not found (Will be created during setup)
)

echo.
echo Checking MCP server configuration...
echo ---------------------------------
if exist "mcp-wordpress-server\.env" (
    echo ✓ MCP server configuration file - Found
    echo   (Verify contents manually in mcp-wordpress-server\.env)
) else (
    echo ✗ MCP server configuration file - Missing
)

echo.
echo ==============================================
echo   Verification Summary
echo ==============================================

echo.
echo Next steps:
echo 1. If XAMPP is not installed, install it using XAMPP_INSTALLATION_GUIDE.md
echo 2. Run start-local-dev.bat to begin the setup process
echo 3. Follow the automated setup wizard
echo.
echo For detailed instructions, see COMPLETE_LOCAL_SETUP_GUIDE.md
echo.
echo Press any key to exit...
pause >nul