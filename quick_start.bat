@echo off
REM BFBC2 Server Quick Start - Shows status and next steps

echo ========================================
echo  BFBC2 Harbor Conquest Server Status
echo ========================================
echo.

set ROOT_DIR=%~dp0

echo SERVER STATUS CHECK:
echo.

REM Quick checks
if exist "%ROOT_DIR%BFBC2_Server.exe" (
    echo [✓] Server executable found - READY TO START
    echo.
    echo You can start your server now with:
    echo   server\scripts\start_server.bat
    echo.
    set /p START="Start server now? (y/n): "
    if /i "!START!"=="y" (
        cd /d "%ROOT_DIR%server\scripts"
        call start_server.bat
        exit /b 0
    )
) else (
    echo [✗] Server executable missing - NEEDS SETUP
    echo.
    echo NEXT STEPS:
    echo.
    echo Option 1 - Complete Guided Setup (RECOMMENDED):
    echo   setup_complete_server.bat
    echo.
    echo Option 2 - Manual Setup:
    echo   1. Get BFBC2 server files from:
    echo      • Venice Unleashed: https://veniceunleashed.net/
    echo      • Official EA/DICE server packages
    echo   2. Place BFBC2_Server.exe in this directory
    echo   3. Place game files in server_files\ subdirectories
    echo   4. Run verify_installation.bat to check
    echo.
    echo Option 3 - Read Documentation:
    echo   COMPLETE_SETUP_GUIDE.md
    echo.
    set /p SETUP="Run complete setup now? (y/n): "
    if /i "!SETUP!"=="y" (
        call setup_complete_server.bat
        exit /b 0
    )
)

echo.
echo OTHER OPTIONS:
echo   verify_installation.bat  - Check what's missing
echo   COMPLETE_SETUP_GUIDE.md  - Full documentation
echo   README.md                - Quick overview
echo.

pause