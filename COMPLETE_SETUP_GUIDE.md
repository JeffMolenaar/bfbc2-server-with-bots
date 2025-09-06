# Complete BFBC2 Server Setup Guide

This guide provides step-by-step instructions for setting up a complete BFBC2 Harbor Conquest server with all required files.

## Option 1: Automated Setup (Recommended)

Run the complete setup script for guided installation:

```cmd
setup_complete_server.bat
```

This script will:
- Check current installation status  
- Guide you through obtaining server files
- Set up proper directory structure
- Configure security settings
- Verify everything is working

## Option 2: Manual Setup

### Step 1: Get Server Files

You need BFBC2 server files from one of these sources:

#### Venice Unleashed (Recommended)
- Download from: https://veniceunleashed.net/
- Provides enhanced features and active community
- Better bot support and server management
- Extract files and copy:
  - `BFBC2_Server.exe` → root directory
  - `VeniceUnleashed.exe` → `server_files/vu/`
  - Map files → `server_files/maps/`
  - Game data → `server_files/data/`

#### Official BFBC2 Server Files
- If you have official EA/DICE server packages
- Extract and copy:
  - `BFBC2_Server.exe` → root directory  
  - Map files → `server_files/maps/`
  - Game data → `server_files/data/`

### Step 2: Verify Installation

```cmd
verify_installation.bat
```

This will check that all required files are present.

### Step 3: Configure Security

Edit these files to change default passwords:
- `server/config/server.cfg` - Change `sv_adminPassword`
- `server/config/admin.cfg` - Change admin passwords
- `server/vu/vu_config.cfg` - Change RCON password

### Step 4: Start Server

```cmd
server/scripts/start_server.bat
```

## Directory Structure After Setup

```
bfbc2-server-with-bots/
├── BFBC2_Server.exe          # Main server executable
├── setup_complete_server.bat # Complete setup guide
├── verify_installation.bat   # Installation checker
├── server/
│   ├── config/              # Server configuration
│   ├── bots/                # Bot AI configuration  
│   ├── vu/                  # Venice Unleashed config
│   ├── scripts/             # Startup scripts
│   └── logs/                # Server logs (auto-created)
├── server_files/
│   ├── maps/                # Game maps including Harbor
│   ├── data/                # Game data files
│   ├── vu/                  # Venice Unleashed files
│   └── mods/                # Server modifications
└── downloads/               # Temporary download storage
```

## Network Configuration

The server uses these ports (automatically configured):
- **19567** (TCP/UDP) - Game server
- **8080** (TCP) - VU HTTP interface
- **47200** (TCP) - RCON admin interface

Ensure these ports are open in your firewall and router.

## Server Management

### Starting the Server
- Simple: `server/scripts/start_server.bat`
- Advanced: `server/scripts/start_server.ps1`

### Configuration Files
- `server/config/server.cfg` - Main server settings
- `server/config/admin.cfg` - Admin accounts
- `server/config/maplist.cfg` - Map rotation
- `server/bots/bot_config.cfg` - Bot behavior

### Admin Commands
Connect to the server and use:
- `/admin password` - Log in as admin
- `/kick player` - Kick a player
- `/ban player` - Ban a player
- `/say message` - Server announcement

## Troubleshooting

### Server Won't Start
1. Run `verify_installation.bat`
2. Check that `BFBC2_Server.exe` exists
3. Verify all required files are present
4. Check the logs in `server/logs/`

### Not Visible in Server Browser
1. Check firewall settings
2. Verify port forwarding on router
3. Ensure VU configuration is correct
4. Check network connectivity

### Bots Not Spawning
1. Verify minimum player count is met
2. Check bot configuration settings
3. Ensure bot AI files are present
4. Review bot_config.cfg settings

## Legal Notice

This setup guide is for configuring BFBC2 servers. You must obtain the actual game files legally:
- Purchase from official sources
- Download from Venice Unleashed (community mod)
- Use only properly licensed server files

This repository provides configuration and setup tools only, not copyrighted game content.