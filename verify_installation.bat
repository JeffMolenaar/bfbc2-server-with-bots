@echo off
REM Quick Installation Verification Script
REM Checks if all required files are present for BFBC2 server

echo ============================================
echo  BFBC2 Server Installation Verification
echo ============================================
echo.

set ROOT_DIR=%~dp0
set ERROR_COUNT=0

echo Checking configuration files...
echo.

REM Check server configuration files
if exist "%ROOT_DIR%server\config\server.cfg" (
    echo [OK] Server configuration found
) else (
    echo [ERROR] Server configuration missing
    set /a ERROR_COUNT+=1
)

if exist "%ROOT_DIR%server\config\admin.cfg" (
    echo [OK] Admin configuration found
) else (
    echo [ERROR] Admin configuration missing
    set /a ERROR_COUNT+=1
)

if exist "%ROOT_DIR%server\config\maplist.cfg" (
    echo [OK] Map list configuration found
) else (
    echo [ERROR] Map list configuration missing
    set /a ERROR_COUNT+=1
)

if exist "%ROOT_DIR%server\bots\bot_config.cfg" (
    echo [OK] Bot configuration found
) else (
    echo [ERROR] Bot configuration missing
    set /a ERROR_COUNT+=1
)

if exist "%ROOT_DIR%server\vu\vu_config.cfg" (
    echo [OK] VU configuration found
) else (
    echo [ERROR] VU configuration missing
    set /a ERROR_COUNT+=1
)

echo.
echo Checking startup scripts...

if exist "%ROOT_DIR%server\scripts\start_server.bat" (
    echo [OK] Batch startup script found
) else (
    echo [ERROR] Batch startup script missing
    set /a ERROR_COUNT+=1
)

if exist "%ROOT_DIR%server\scripts\start_server.ps1" (
    echo [OK] PowerShell startup script found
) else (
    echo [ERROR] PowerShell startup script missing
    set /a ERROR_COUNT+=1
)

echo.
echo Checking for server executable...

if exist "%ROOT_DIR%BFBC2_Server.exe" (
    echo [OK] BFBC2 server executable found
) else (
    echo [MISSING] BFBC2_Server.exe not found
    echo         You need to obtain BFBC2 server files separately
    echo         See SETUP.md for download sources
)

if exist "%ROOT_DIR%vu\VeniceUnleashed.exe" (
    echo [OK] Venice Unleashed executable found
) else (
    echo [INFO] Venice Unleashed not found (optional)
    echo       Download from https://veniceunleashed.net/
)

echo.
echo ============================================

if %ERROR_COUNT% EQU 0 (
    echo [SUCCESS] All configuration files are present!
    echo.
    echo Your BFBC2 Harbor Conquest server is ready to configure.
    echo.
    echo Next steps:
    echo 1. Edit server/config/server.cfg to change passwords
    echo 2. Obtain BFBC2 server files ^(see SETUP.md^)
    echo 3. Run server/scripts/start_server.bat
    echo.
) else (
    echo [ERROR] %ERROR_COUNT% configuration file(s) missing!
    echo Please check the installation and try again.
    echo.
)

echo See SETUP.md for detailed instructions.
pause