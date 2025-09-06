# BFBC2 Server PowerShell Startup Script for Windows 11
# Harbor Conquest with Bots - Enhanced version with better error handling

param(
    [switch]$NoFirewall,
    [switch]$Verbose
)

# Ensure we're using PowerShell 5.1 or later
if ($PSVersionTable.PSVersion.Major -lt 5) {
    Write-Error "PowerShell 5.1 or later is required. Current version: $($PSVersionTable.PSVersion)"
    exit 1
}

# Function to write colored output
function Write-ColorOutput {
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    Write-Host $Message -ForegroundColor $Color
}

# Header
Clear-Host
Write-ColorOutput "========================================" "Cyan"
Write-ColorOutput " BFBC2 Harbor Conquest Server with Bots" "Yellow"
Write-ColorOutput "========================================" "Cyan"
Write-Host ""

# Check if running as administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

if ($isAdmin) {
    Write-ColorOutput "✓ Running with administrator privileges" "Green"
} else {
    Write-ColorOutput "⚠ WARNING: Not running as administrator" "Yellow"
    Write-ColorOutput "  Some features may not work properly" "Yellow"
}

# Set paths
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ServerDir = Join-Path $ScriptDir ".."
$ConfigDir = Join-Path $ServerDir "config"
$LogDir = Join-Path $ServerDir "logs"
$VUDir = Join-Path $ServerDir "vu"
$BotDir = Join-Path $ServerDir "bots"

Write-Host ""
Write-ColorOutput "Server Directories:" "Cyan"
Write-Host "  Server: $ServerDir"
Write-Host "  Config: $ConfigDir"
Write-Host "  Logs:   $LogDir"
Write-Host "  VU:     $VUDir"
Write-Host "  Bots:   $BotDir"

# Create logs directory if it doesn't exist
if (!(Test-Path $LogDir)) {
    New-Item -ItemType Directory -Path $LogDir -Force | Out-Null
    Write-ColorOutput "✓ Created logs directory" "Green"
}

# Check for required configuration files
Write-Host ""
Write-ColorOutput "Checking configuration files..." "Cyan"

$requiredFiles = @(
    @{ Path = (Join-Path $ConfigDir "server.cfg"); Name = "Server Configuration" },
    @{ Path = (Join-Path $ConfigDir "admin.cfg"); Name = "Admin Configuration" },
    @{ Path = (Join-Path $ConfigDir "maplist.cfg"); Name = "Map List Configuration" },
    @{ Path = (Join-Path $BotDir "bot_config.cfg"); Name = "Bot Configuration" },
    @{ Path = (Join-Path $VUDir "vu_config.cfg"); Name = "VU Configuration" }
)

$allFilesFound = $true
foreach ($file in $requiredFiles) {
    if (Test-Path $file.Path) {
        Write-ColorOutput "✓ $($file.Name) found" "Green"
    } else {
        Write-ColorOutput "✗ $($file.Name) missing: $($file.Path)" "Red"
        $allFilesFound = $false
    }
}

if (!$allFilesFound) {
    Write-ColorOutput "ERROR: Missing required configuration files!" "Red"
    Read-Host "Press Enter to exit"
    exit 1
}

# Display server configuration
Write-Host ""
Write-ColorOutput "Server Configuration:" "Cyan"
Write-Host "  Map:          Harbor (Conquest Large)"
Write-Host "  Max Players:  32 (8 human + 24 bots recommended)"
Write-Host "  Game Mode:    Conquest Large"
Write-Host "  VU Support:   Enabled"
Write-Host "  Server Port:  19567"
Write-Host "  HTTP Port:    8080 (VU)"
Write-Host "  RCON Port:    47200"
Write-ColorOutput "  Admin Pass:   admin123 (CHANGE THIS!)" "Yellow"

# Configure Windows Firewall
if (!$NoFirewall -and $isAdmin) {
    Write-Host ""
    Write-ColorOutput "Configuring Windows Firewall..." "Cyan"
    
    $firewallRules = @(
        @{ Name = "BFBC2 Server TCP 19567"; Port = 19567; Protocol = "TCP" },
        @{ Name = "BFBC2 Server UDP 19567"; Port = 19567; Protocol = "UDP" },
        @{ Name = "BFBC2 VU HTTP 8080"; Port = 8080; Protocol = "TCP" },
        @{ Name = "BFBC2 RCON 47200"; Port = 47200; Protocol = "TCP" }
    )
    
    foreach ($rule in $firewallRules) {
        try {
            # Remove existing rule if it exists
            Remove-NetFirewallRule -DisplayName $rule.Name -ErrorAction SilentlyContinue
            
            # Add new rule
            New-NetFirewallRule -DisplayName $rule.Name -Direction Inbound -Action Allow -Protocol $rule.Protocol -LocalPort $rule.Port | Out-Null
            Write-ColorOutput "✓ Added firewall rule: $($rule.Name)" "Green"
        } catch {
            Write-ColorOutput "⚠ Failed to add firewall rule: $($rule.Name)" "Yellow"
        }
    }
} elseif (!$NoFirewall) {
    Write-ColorOutput "⚠ Skipping firewall configuration (not running as admin)" "Yellow"
}

# Check for server executable
Write-Host ""
Write-ColorOutput "Checking for server executable..." "Cyan"

$serverExe = Join-Path $ServerDir "BFBC2_Server.exe"
$vuServerExe = Join-Path $ServerDir "server_files\vu\VeniceUnleashed.exe"
$vuServerExeOld = Join-Path $ServerDir "vu\VeniceUnleashed.exe"

if (Test-Path $serverExe) {
    Write-ColorOutput "✓ BFBC2 server executable found" "Green"
    $useVU = $false
} elseif (Test-Path $vuServerExe) {
    Write-ColorOutput "✓ Venice Unleashed executable found (new location)" "Green"
    $useVU = $true
} elseif (Test-Path $vuServerExeOld) {
    Write-ColorOutput "✓ Venice Unleashed executable found (legacy location)" "Green"
    $vuServerExe = $vuServerExeOld
    $useVU = $true
} else {
    Write-Host ""
    Write-ColorOutput "===========================================" "Red"
    Write-ColorOutput " SERVER EXECUTABLE NOT FOUND" "Red"
    Write-ColorOutput "===========================================" "Red"
    Write-Host ""
    Write-ColorOutput "No server executable found. Please run setup:" "Yellow"
    Write-Host ""
    Write-ColorOutput "QUICK SETUP:" "Cyan"
    Write-Host "  • Run 'setup_complete_server.bat' for guided installation"
    Write-Host ""
    Write-ColorOutput "MANUAL SETUP:" "Cyan"
    Write-Host "  • BFBC2 server files (BFBC2_Server.exe)"
    Write-Host "  • Game maps and assets (in server_files/maps/)"
    Write-Host "  • Game data files (in server_files/data/)"
    Write-Host "  • Venice Unleashed mod (optional, in server_files/vu/)"
    Write-Host ""
    Write-ColorOutput "Download sources:" "Cyan"
    Write-Host "  • Venice Unleashed: https://veniceunleashed.net/"
    Write-Host "  • Official BFBC2 server files"
    Write-Host "  • Community server packages"
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

# Start the server
Write-Host ""
Write-ColorOutput "Starting BFBC2 Server..." "Green"
Write-ColorOutput "Press Ctrl+C to stop the server" "Yellow"
Write-Host ""

try {
    Set-Location $ServerDir
    
    if ($useVU) {
        # Start with Venice Unleashed
        & $vuServerExe -server -config (Join-Path $VUDir "vu_config.cfg")
    } else {
        # Start with standard BFBC2 server
        $args = @(
            "+exec", (Join-Path $ConfigDir "server.cfg"),
            "+exec", (Join-Path $ConfigDir "admin.cfg"), 
            "+exec", (Join-Path $ConfigDir "maplist.cfg"),
            "+exec", (Join-Path $BotDir "bot_config.cfg")
        )
        & $serverExe $args
    }
} catch {
    Write-ColorOutput "ERROR: Failed to start server" "Red"
    Write-ColorOutput $_.Exception.Message "Red"
    Read-Host "Press Enter to exit"
    exit 1
}