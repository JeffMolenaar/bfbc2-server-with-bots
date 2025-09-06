@echo off
REM BFBC2 Server Startup Script for Windows 11
REM Harbor Conquest with Bots

echo ========================================
echo  BFBC2 Harbor Conquest Server with Bots
echo ========================================
echo.

REM Check if running as administrator
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Running with administrator privileges...
) else (
    echo WARNING: Not running as administrator
    echo Some features may not work properly
    echo.
)

REM Set server directory
set SERVER_DIR=%~dp0..
set CONFIG_DIR=%SERVER_DIR%\config
set LOG_DIR=%SERVER_DIR%\logs

echo Server Directory: %SERVER_DIR%
echo Config Directory: %CONFIG_DIR%
echo Log Directory: %LOG_DIR%
echo.

REM Create logs directory if it doesn't exist
if not exist "%LOG_DIR%" mkdir "%LOG_DIR%"

REM Check for required files
echo Checking required files...
if not exist "%CONFIG_DIR%\server.cfg" (
    echo ERROR: server.cfg not found!
    pause
    exit /b 1
)
if not exist "%CONFIG_DIR%\admin.cfg" (
    echo ERROR: admin.cfg not found!
    pause
    exit /b 1
)
echo All required configuration files found.
echo.

REM Display server information
echo Server Configuration:
echo - Map: Harbor (Conquest Mode)
echo - Max Players: 32 (8 human + 24 bots)
echo - VU Compatible: Yes
echo - Port: 19567
echo - Admin Password: admin123 (CHANGE THIS!)
echo.

REM Windows Firewall configuration
echo Configuring Windows Firewall...
netsh advfirewall firewall add rule name="BFBC2 Server Port 19567" dir=in action=allow protocol=TCP localport=19567 >nul 2>&1
netsh advfirewall firewall add rule name="BFBC2 Server Port 19567 UDP" dir=in action=allow protocol=UDP localport=19567 >nul 2>&1
netsh advfirewall firewall add rule name="BFBC2 VU HTTP Port 8080" dir=in action=allow protocol=TCP localport=8080 >nul 2>&1
netsh advfirewall firewall add rule name="BFBC2 RCON Port 47200" dir=in action=allow protocol=TCP localport=47200 >nul 2>&1
echo Firewall rules added.
echo.

REM Start the server
echo Starting BFBC2 Server...
echo Press Ctrl+C to stop the server
echo.

REM Check for server executable in multiple locations
if exist "%SERVER_DIR%\BFBC2_Server.exe" (
    cd /d "%SERVER_DIR%"
    "%SERVER_DIR%\BFBC2_Server.exe" +exec "%CONFIG_DIR%\server.cfg" +exec "%CONFIG_DIR%\admin.cfg" +exec "%CONFIG_DIR%\maplist.cfg" +exec "%SERVER_DIR%\bots\bot_config.cfg"
) else if exist "%SERVER_DIR%\server_files\vu\VeniceUnleashed.exe" (
    echo Found Venice Unleashed server, starting with VU...
    cd /d "%SERVER_DIR%"
    "%SERVER_DIR%\server_files\vu\VeniceUnleashed.exe" -server -config "%SERVER_DIR%\vu\vu_config.cfg"
) else (
    echo.
    echo ==========================================
    echo  SERVER EXECUTABLE NOT FOUND
    echo ==========================================
    echo.
    echo The BFBC2 server executable was not found.
    echo.
    echo QUICK SETUP:
    echo Run 'setup_complete_server.bat' for guided installation
    echo.
    echo MANUAL SETUP:
    echo Place the following files:
    echo - BFBC2_Server.exe in the root directory
    echo - Game files in server_files\ directory
    echo - Maps in server_files\maps\
    echo.
    echo DOWNLOAD SOURCES:
    echo - Venice Unleashed: https://veniceunleashed.net/
    echo - Official BFBC2 server files
    echo - Community server packages
    echo.
    echo See SETUP.md for detailed instructions.
    echo.
)

pause