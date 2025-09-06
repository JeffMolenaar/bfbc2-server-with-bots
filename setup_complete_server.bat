@echo off
REM BFBC2 Complete Server Setup Script
REM Guides users through setting up a complete BFBC2 server with all required files

setlocal enabledelayedexpansion

echo ================================================
echo  BFBC2 Complete Server Setup - Version 1.0
echo ================================================
echo.
echo This script will guide you through setting up a complete
echo BFBC2 Harbor Conquest server with bots.
echo.

set ROOT_DIR=%~dp0
set SERVER_FILES_DIR=%ROOT_DIR%server_files
set DOWNLOADS_DIR=%ROOT_DIR%downloads

REM Check current installation status
echo [1/5] Checking current installation status...
echo.

set MISSING_COUNT=0
set HAS_BFBC2_EXE=0
set HAS_VU_EXE=0

if exist "%ROOT_DIR%BFBC2_Server.exe" (
    echo [OK] BFBC2_Server.exe found
    set HAS_BFBC2_EXE=1
) else (
    echo [MISSING] BFBC2_Server.exe
    set /a MISSING_COUNT+=1
)

if exist "%SERVER_FILES_DIR%\vu\VeniceUnleashed.exe" (
    echo [OK] Venice Unleashed executable found
    set HAS_VU_EXE=1
) else (
    echo [MISSING] Venice Unleashed executable (optional)
)

if exist "%SERVER_FILES_DIR%\maps\MP_012" (
    echo [OK] Harbor map files found
) else (
    echo [MISSING] Harbor map files
    set /a MISSING_COUNT+=1
)

echo.

if %MISSING_COUNT% EQU 0 (
    echo [SUCCESS] Server appears to be completely set up!
    echo.
    echo You can start your server using:
    echo   server\scripts\start_server.bat
    echo.
    pause
    exit /b 0
)

echo [INFO] Missing %MISSING_COUNT% required component(s)
echo Let's set up your complete BFBC2 server...
echo.

REM Guide user through server file acquisition
echo [2/5] Server Files Setup
echo ========================
echo.
echo You need BFBC2 server files to run the server.
echo.
echo OPTION 1 - Venice Unleashed (RECOMMENDED)
echo   + Enhanced features and active community
echo   + Better bot support
echo   + Modern server management
echo   + Download from: https://veniceunleashed.net/
echo.
echo OPTION 2 - Official BFBC2 Server Files
echo   + Original server files from EA/DICE
echo   + If you have access to official packages
echo.
echo OPTION 3 - Community Server Packages
echo   + Community-maintained server files
echo   + Ensure proper licensing
echo.

set /p CHOICE="Which option do you want to use? (1=VU, 2=Official, 3=Community, S=Skip): "

if /i "%CHOICE%"=="1" goto :setup_vu
if /i "%CHOICE%"=="2" goto :setup_official
if /i "%CHOICE%"=="3" goto :setup_community
if /i "%CHOICE%"=="s" goto :manual_setup
goto :invalid_choice

:setup_vu
echo.
echo [VU SETUP] Venice Unleashed Setup
echo =================================
echo.
echo 1. Open your web browser and go to: https://veniceunleashed.net/
echo 2. Download the latest Venice Unleashed release
echo 3. Extract the files to a temporary location
echo 4. Copy the following files to this server:
echo.
echo    COPY TO ROOT DIRECTORY:
echo    - BFBC2_Server.exe (or equivalent VU server executable)
echo.
echo    COPY TO server_files\vu\:
echo    - VeniceUnleashed.exe
echo    - All VU mod files and directories
echo.
echo    COPY TO server_files\maps\:
echo    - MP_012\ (Harbor map directory)
echo    - Any other map directories
echo.
echo    COPY TO server_files\data\:
echo    - Game data files and assets
echo.
pause
echo.
echo Press any key when you have copied all the files...
pause >nul
goto :verify_installation

:setup_official
echo.
echo [OFFICIAL SETUP] Official BFBC2 Server Files
echo ============================================
echo.
echo 1. Locate your official BFBC2 server package
echo 2. Extract the server files
echo 3. Copy the following files to this server:
echo.
echo    COPY TO ROOT DIRECTORY:
echo    - BFBC2_Server.exe
echo.
echo    COPY TO server_files\maps\:
echo    - MP_012\ (Harbor map directory)
echo    - Any other map directories you want
echo.
echo    COPY TO server_files\data\:
echo    - Game data files and assets
echo.
pause
echo.
echo Press any key when you have copied all the files...
pause >nul
goto :verify_installation

:setup_community
echo.
echo [COMMUNITY SETUP] Community Server Package
echo ==========================================
echo.
echo 1. Download a community BFBC2 server package
echo 2. Verify the source is legitimate and properly licensed
echo 3. Extract the server files
echo 4. Copy the following files to this server:
echo.
echo    COPY TO ROOT DIRECTORY:
echo    - BFBC2_Server.exe (or equivalent)
echo.
echo    COPY TO server_files\maps\:
echo    - MP_012\ (Harbor map directory)
echo    - Any other map directories
echo.
echo    COPY TO server_files\data\:
echo    - Game data files and assets
echo.
pause
echo.
echo Press any key when you have copied all the files...
pause >nul
goto :verify_installation

:manual_setup
echo.
echo [MANUAL SETUP] Manual File Placement
echo ====================================
echo.
echo Please manually place the required files:
echo.
echo 1. Place BFBC2_Server.exe in the root directory
echo 2. Place map files in server_files\maps\
echo 3. Place game data in server_files\data\
echo 4. (Optional) Place VU files in server_files\vu\
echo.
echo See server_files\README.md for detailed information.
echo.
pause
goto :verify_installation

:invalid_choice
echo Invalid choice. Please try again.
pause
goto :manual_setup

:verify_installation
echo.
echo [3/5] Verifying Installation
echo ============================
echo.

REM Clean up placeholder files if real files exist
if exist "%ROOT_DIR%BFBC2_Server.exe" (
    if exist "%ROOT_DIR%BFBC2_Server.exe.PLACEHOLDER" (
        echo Removing placeholder file...
        del "%ROOT_DIR%BFBC2_Server.exe.PLACEHOLDER"
    )
)

REM Run verification
call "%ROOT_DIR%verify_installation.bat"

echo.
echo [4/5] Security Configuration
echo ============================
echo.
echo IMPORTANT: Change default passwords before running publicly!
echo.
echo Default passwords that need to be changed:
echo - Admin password: admin123 (in server\config\server.cfg)
echo - RCON password: rcon123 (in server\config\admin.cfg)
echo.
set /p CHANGE_PASSWORDS="Do you want to change passwords now? (y/n): "

if /i "%CHANGE_PASSWORDS%"=="y" (
    echo.
    set /p NEW_ADMIN_PASS="Enter new admin password: "
    set /p NEW_RCON_PASS="Enter new RCON password: "
    
    REM Update server.cfg
    powershell -Command "(Get-Content '%ROOT_DIR%server\config\server.cfg') -replace 'sv_adminPassword \"admin123\"', 'sv_adminPassword \"!NEW_ADMIN_PASS!\"' | Set-Content '%ROOT_DIR%server\config\server.cfg'"
    
    REM Update admin.cfg  
    powershell -Command "(Get-Content '%ROOT_DIR%server\config\admin.cfg') -replace '\"admin123\"', '\"!NEW_ADMIN_PASS!\"' | Set-Content '%ROOT_DIR%server\config\admin.cfg'"
    
    REM Update VU config
    if exist "%ROOT_DIR%server\vu\vu_config.cfg" (
        powershell -Command "(Get-Content '%ROOT_DIR%server\vu\vu_config.cfg') -replace 'rcon123', '!NEW_RCON_PASS!' | Set-Content '%ROOT_DIR%server\vu\vu_config.cfg'"
    )
    
    echo.
    echo [OK] Passwords updated successfully!
) else (
    echo.
    echo [WARNING] Remember to change passwords before public use!
)

echo.
echo [5/5] Final Setup Complete
echo ==========================
echo.
echo Your BFBC2 Harbor Conquest server is now ready!
echo.
echo SERVER DETAILS:
echo - Server Name: BFBC2 Harbor Conquest with Bots
echo - Map: Harbor (Conquest Large)
echo - Max Players: 32 (8 human + 24 bots)
echo - Port: 19567
echo - Admin Port: 47200
echo.
echo TO START YOUR SERVER:
echo   Option 1: server\scripts\start_server.bat (simple)
echo   Option 2: server\scripts\start_server.ps1 (advanced)
echo.
echo TO MANAGE YOUR SERVER:
echo - Edit server\config\server.cfg for server settings
echo - Edit server\config\admin.cfg for admin accounts
echo - Edit server\bots\bot_config.cfg for bot behavior
echo.
echo NETWORK SETUP:
echo - Ensure ports 19567, 8080, and 47200 are open
echo - The startup script will configure Windows Firewall
echo.

set /p START_NOW="Do you want to start the server now? (y/n): "

if /i "%START_NOW%"=="y" (
    echo.
    echo Starting server...
    cd /d "%ROOT_DIR%server\scripts"
    call start_server.bat
) else (
    echo.
    echo Server setup complete! Start it anytime with:
    echo   server\scripts\start_server.bat
    echo.
)

echo.
echo Thank you for using BFBC2 Complete Server Setup!
pause