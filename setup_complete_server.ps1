# BFBC2 Complete Server Setup Script (PowerShell)
# Guides users through setting up a complete BFBC2 server

param(
    [switch]$NoPrompt = $false
)

function Write-ColorOutput {
    param([string]$Text, [string]$Color = "White")
    
    $colors = @{
        "Red" = [ConsoleColor]::Red
        "Green" = [ConsoleColor]::Green
        "Yellow" = [ConsoleColor]::Yellow
        "Cyan" = [ConsoleColor]::Cyan
        "Blue" = [ConsoleColor]::Blue
        "Magenta" = [ConsoleColor]::Magenta
        "White" = [ConsoleColor]::White
    }
    
    if ($colors.ContainsKey($Color)) {
        Write-Host $Text -ForegroundColor $colors[$Color]
    } else {
        Write-Host $Text
    }
}

# Main setup function
function Start-CompleteServerSetup {
    Clear-Host
    
    Write-Host "================================================"
    Write-ColorOutput " BFBC2 Complete Server Setup - Version 1.0" "Cyan"
    Write-Host "================================================"
    Write-Host ""
    Write-Host "This script will guide you through setting up a complete"
    Write-Host "BFBC2 Harbor Conquest server with bots."
    Write-Host ""
    
    $rootDir = Split-Path -Parent $MyInvocation.MyCommand.Path
    $serverFilesDir = Join-Path $rootDir "server_files"
    $downloadsDir = Join-Path $rootDir "downloads"
    
    # Check current installation status
    Write-Host "[1/5] Checking current installation status..."
    Write-Host ""
    
    $missingCount = 0
    $hasBFBC2Exe = Test-Path (Join-Path $rootDir "BFBC2_Server.exe")
    $hasVUExe = Test-Path (Join-Path $serverFilesDir "vu\VeniceUnleashed.exe")
    $hasHarborMap = Test-Path (Join-Path $serverFilesDir "maps\MP_012")
    
    if ($hasBFBC2Exe) {
        Write-ColorOutput "[OK] BFBC2_Server.exe found" "Green"
    } else {
        Write-ColorOutput "[MISSING] BFBC2_Server.exe" "Red"
        $missingCount++
    }
    
    if ($hasVUExe) {
        Write-ColorOutput "[OK] Venice Unleashed executable found" "Green"
    } else {
        Write-ColorOutput "[MISSING] Venice Unleashed executable (optional)" "Yellow"
    }
    
    if ($hasHarborMap) {
        Write-ColorOutput "[OK] Harbor map files found" "Green"
    } else {
        Write-ColorOutput "[MISSING] Harbor map files" "Red"
        $missingCount++
    }
    
    Write-Host ""
    
    if ($missingCount -eq 0) {
        Write-ColorOutput "[SUCCESS] Server appears to be completely set up!" "Green"
        Write-Host ""
        Write-Host "You can start your server using:"
        Write-Host "  server\scripts\start_server.bat"
        Write-Host ""
        if (!$NoPrompt) { Read-Host "Press Enter to exit" }
        return
    }
    
    Write-ColorOutput "[INFO] Missing $missingCount required component(s)" "Yellow"
    Write-Host "Let's set up your complete BFBC2 server..."
    Write-Host ""
    
    # Guide through server file options
    Show-ServerFileOptions
    
    # Verify installation
    Write-Host ""
    Write-Host "[3/5] Verifying Installation"
    Write-Host "============================"
    Write-Host ""
    
    # Clean up placeholder files
    $placeholderFile = Join-Path $rootDir "BFBC2_Server.exe.PLACEHOLDER"
    if ((Test-Path (Join-Path $rootDir "BFBC2_Server.exe")) -and (Test-Path $placeholderFile)) {
        Write-Host "Removing placeholder file..."
        Remove-Item $placeholderFile -Force
    }
    
    # Security configuration
    Set-SecurityConfiguration $rootDir
    
    # Final setup
    Complete-FinalSetup $rootDir
}

function Show-ServerFileOptions {
    Write-Host "[2/5] Server Files Setup"
    Write-Host "========================"
    Write-Host ""
    Write-Host "You need BFBC2 server files to run the server."
    Write-Host ""
    Write-ColorOutput "OPTION 1 - Venice Unleashed (RECOMMENDED)" "Cyan"
    Write-Host "  + Enhanced features and active community"
    Write-Host "  + Better bot support"
    Write-Host "  + Modern server management"
    Write-Host "  + Download from: https://veniceunleashed.net/"
    Write-Host ""
    Write-ColorOutput "OPTION 2 - Official BFBC2 Server Files" "Cyan"
    Write-Host "  + Original server files from EA/DICE"
    Write-Host "  + If you have access to official packages"
    Write-Host ""
    Write-ColorOutput "OPTION 3 - Community Server Packages" "Cyan"
    Write-Host "  + Community-maintained server files"
    Write-Host "  + Ensure proper licensing"
    Write-Host ""
    
    if (!$NoPrompt) {
        $choice = Read-Host "Which option do you want to use? (1=VU, 2=Official, 3=Community, S=Skip)"
        
        switch ($choice.ToUpper()) {
            "1" { Show-VUSetupInstructions }
            "2" { Show-OfficialSetupInstructions }
            "3" { Show-CommunitySetupInstructions }
            "S" { Show-ManualSetupInstructions }
            default { Show-ManualSetupInstructions }
        }
    } else {
        Show-ManualSetupInstructions
    }
}

function Show-VUSetupInstructions {
    Write-Host ""
    Write-ColorOutput "[VU SETUP] Venice Unleashed Setup" "Cyan"
    Write-Host "================================="
    Write-Host ""
    Write-Host "1. Open your web browser and go to: https://veniceunleashed.net/"
    Write-Host "2. Download the latest Venice Unleashed release"
    Write-Host "3. Extract the files to a temporary location"
    Write-Host "4. Copy the following files to this server:"
    Write-Host ""
    Write-ColorOutput "   COPY TO ROOT DIRECTORY:" "Yellow"
    Write-Host "   - BFBC2_Server.exe (or equivalent VU server executable)"
    Write-Host ""
    Write-ColorOutput "   COPY TO server_files\vu\:" "Yellow"
    Write-Host "   - VeniceUnleashed.exe"
    Write-Host "   - All VU mod files and directories"
    Write-Host ""
    Write-ColorOutput "   COPY TO server_files\maps\:" "Yellow"
    Write-Host "   - MP_012\ (Harbor map directory)"
    Write-Host "   - Any other map directories"
    Write-Host ""
    Write-ColorOutput "   COPY TO server_files\data\:" "Yellow"
    Write-Host "   - Game data files and assets"
    Write-Host ""
    if (!$NoPrompt) {
        Read-Host "Press Enter when you have copied all the files"
    }
}

function Show-OfficialSetupInstructions {
    Write-Host ""
    Write-ColorOutput "[OFFICIAL SETUP] Official BFBC2 Server Files" "Cyan"
    Write-Host "============================================"
    Write-Host ""
    Write-Host "1. Locate your official BFBC2 server package"
    Write-Host "2. Extract the server files"
    Write-Host "3. Copy the following files to this server:"
    Write-Host ""
    Write-ColorOutput "   COPY TO ROOT DIRECTORY:" "Yellow"
    Write-Host "   - BFBC2_Server.exe"
    Write-Host ""
    Write-ColorOutput "   COPY TO server_files\maps\:" "Yellow"
    Write-Host "   - MP_012\ (Harbor map directory)"
    Write-Host "   - Any other map directories you want"
    Write-Host ""
    Write-ColorOutput "   COPY TO server_files\data\:" "Yellow"
    Write-Host "   - Game data files and assets"
    Write-Host ""
    if (!$NoPrompt) {
        Read-Host "Press Enter when you have copied all the files"
    }
}

function Show-CommunitySetupInstructions {
    Write-Host ""
    Write-ColorOutput "[COMMUNITY SETUP] Community Server Package" "Cyan"
    Write-Host "=========================================="
    Write-Host ""
    Write-Host "1. Download a community BFBC2 server package"
    Write-Host "2. Verify the source is legitimate and properly licensed"
    Write-Host "3. Extract the server files"
    Write-Host "4. Copy the following files to this server:"
    Write-Host ""
    Write-ColorOutput "   COPY TO ROOT DIRECTORY:" "Yellow"
    Write-Host "   - BFBC2_Server.exe (or equivalent)"
    Write-Host ""
    Write-ColorOutput "   COPY TO server_files\maps\:" "Yellow"  
    Write-Host "   - MP_012\ (Harbor map directory)"
    Write-Host "   - Any other map directories"
    Write-Host ""
    Write-ColorOutput "   COPY TO server_files\data\:" "Yellow"
    Write-Host "   - Game data files and assets"
    Write-Host ""
    if (!$NoPrompt) {
        Read-Host "Press Enter when you have copied all the files"
    }
}

function Show-ManualSetupInstructions {
    Write-Host ""
    Write-ColorOutput "[MANUAL SETUP] Manual File Placement" "Cyan"
    Write-Host "===================================="
    Write-Host ""
    Write-Host "Please manually place the required files:"
    Write-Host ""
    Write-Host "1. Place BFBC2_Server.exe in the root directory"
    Write-Host "2. Place map files in server_files\maps\"
    Write-Host "3. Place game data in server_files\data\"
    Write-Host "4. (Optional) Place VU files in server_files\vu\"
    Write-Host ""
    Write-Host "See server_files\README.md for detailed information."
    Write-Host ""
    if (!$NoPrompt) {
        Read-Host "Press Enter to continue"
    }
}

function Set-SecurityConfiguration {
    param([string]$RootDir)
    
    Write-Host ""
    Write-Host "[4/5] Security Configuration"
    Write-Host "============================"
    Write-Host ""
    Write-ColorOutput "IMPORTANT: Change default passwords before running publicly!" "Yellow"
    Write-Host ""
    Write-Host "Default passwords that need to be changed:"
    Write-Host "- Admin password: admin123 (in server\config\server.cfg)"
    Write-Host "- RCON password: rcon123 (in server\config\admin.cfg)"
    Write-Host ""
    
    if (!$NoPrompt) {
        $changePasswords = Read-Host "Do you want to change passwords now? (y/n)"
        
        if ($changePasswords.ToUpper() -eq "Y") {
            $newAdminPass = Read-Host "Enter new admin password"
            $newRconPass = Read-Host "Enter new RCON password"
            
            try {
                # Update server.cfg
                $serverCfgPath = Join-Path $RootDir "server\config\server.cfg"
                if (Test-Path $serverCfgPath) {
                    (Get-Content $serverCfgPath) -replace 'sv_adminPassword "admin123"', "sv_adminPassword `"$newAdminPass`"" | Set-Content $serverCfgPath
                }
                
                # Update admin.cfg
                $adminCfgPath = Join-Path $RootDir "server\config\admin.cfg"
                if (Test-Path $adminCfgPath) {
                    (Get-Content $adminCfgPath) -replace '"admin123"', "`"$newAdminPass`"" | Set-Content $adminCfgPath
                }
                
                # Update VU config
                $vuCfgPath = Join-Path $RootDir "server\vu\vu_config.cfg"
                if (Test-Path $vuCfgPath) {
                    (Get-Content $vuCfgPath) -replace 'rcon123', $newRconPass | Set-Content $vuCfgPath
                }
                
                Write-Host ""
                Write-ColorOutput "[OK] Passwords updated successfully!" "Green"
            } catch {
                Write-ColorOutput "[ERROR] Failed to update passwords: $($_.Exception.Message)" "Red"
            }
        } else {
            Write-Host ""
            Write-ColorOutput "[WARNING] Remember to change passwords before public use!" "Yellow"
        }
    }
}

function Complete-FinalSetup {
    param([string]$RootDir)
    
    Write-Host ""
    Write-Host "[5/5] Final Setup Complete"
    Write-Host "=========================="
    Write-Host ""
    Write-ColorOutput "Your BFBC2 Harbor Conquest server is now ready!" "Green"
    Write-Host ""
    Write-Host "SERVER DETAILS:"
    Write-Host "- Server Name: BFBC2 Harbor Conquest with Bots"
    Write-Host "- Map: Harbor (Conquest Large)"
    Write-Host "- Max Players: 32 (8 human + 24 bots)"
    Write-Host "- Port: 19567"
    Write-Host "- Admin Port: 47200"
    Write-Host ""
    Write-Host "TO START YOUR SERVER:"
    Write-Host "  Option 1: server\scripts\start_server.bat (simple)"
    Write-Host "  Option 2: server\scripts\start_server.ps1 (advanced)"
    Write-Host ""
    Write-Host "TO MANAGE YOUR SERVER:"
    Write-Host "- Edit server\config\server.cfg for server settings"
    Write-Host "- Edit server\config\admin.cfg for admin accounts"
    Write-Host "- Edit server\bots\bot_config.cfg for bot behavior"
    Write-Host ""
    Write-Host "NETWORK SETUP:"
    Write-Host "- Ensure ports 19567, 8080, and 47200 are open"
    Write-Host "- The startup script will configure Windows Firewall"
    Write-Host ""
    
    if (!$NoPrompt) {
        $startNow = Read-Host "Do you want to start the server now? (y/n)"
        
        if ($startNow.ToUpper() -eq "Y") {
            Write-Host ""
            Write-Host "Starting server..."
            $startScript = Join-Path $RootDir "server\scripts\start_server.bat"
            if (Test-Path $startScript) {
                Start-Process -FilePath $startScript -WorkingDirectory (Split-Path $startScript)
            } else {
                Write-ColorOutput "[ERROR] Start script not found" "Red"
            }
        } else {
            Write-Host ""
            Write-Host "Server setup complete! Start it anytime with:"
            Write-Host "  server\scripts\start_server.bat"
            Write-Host ""
        }
    }
    
    Write-Host ""
    Write-ColorOutput "Thank you for using BFBC2 Complete Server Setup!" "Cyan"
    if (!$NoPrompt) {
        Read-Host "Press Enter to exit"
    }
}

# Run the setup
Start-CompleteServerSetup