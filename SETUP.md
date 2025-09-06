# BFBC2 Harbor Conquest Server with Bots - Setup Guide

## Overview
This repository contains a complete setup for running a Battlefield Bad Company 2 server on Windows 11, configured specifically for:
- **Map**: Harbor only
- **Game Mode**: Conquest Large (32 players)
- **Bots**: 24 AI bots with configurable difficulty
- **VU Compatible**: Visible in Venice Unleashed mod server browser

## Quick Start

### Prerequisites
1. **Windows 11** (64-bit)
2. **Administrator privileges** (for firewall configuration)
3. **BFBC2 server files** (see Installation section)
4. **Venice Unleashed mod** (recommended)

### Installation Steps

#### 1. Get BFBC2 Server Files
You need to obtain the BFBC2 server files from one of these sources:
- **Official EA/DICE server files** (if you have them)
- **Venice Unleashed mod** (recommended): https://veniceunleashed.net/
- **Community server packages**

#### 2. Extract Server Files
Extract the server files to the root directory:
```
bfbc2-server-with-bots/
├── BFBC2_Server.exe           # Main server executable
├── server/                    # Our configuration
│   ├── config/               # Server configuration files
│   ├── bots/                 # Bot AI configuration
│   ├── vu/                   # Venice Unleashed config
│   └── scripts/              # Startup scripts
├── maps/                     # Game maps
├── data/                     # Game data files
└── ...                       # Other server files
```

#### 3. Configure Server Settings
Edit these files to customize your server:

**`server/config/server.cfg`** - Main server settings:
- Change `sv_adminPassword` from "admin123" to something secure
- Adjust `sv_serverName` and description
- Modify bot count with `ai_maxBots` (default: 24)

**`server/config/admin.cfg`** - Admin accounts:
- Change admin passwords
- Add moderator accounts

#### 4. Start the Server

**Option A: Using Batch Script (Simple)**
```cmd
cd server/scripts
start_server.bat
```

**Option B: Using PowerShell (Advanced)**
```powershell
cd server/scripts
.\start_server.ps1
```

**Option C: Manual Start**
```cmd
BFBC2_Server.exe +exec server/config/server.cfg +exec server/config/admin.cfg +exec server/config/maplist.cfg
```

## Server Configuration

### Harbor Map Settings
- **Internal Map Name**: `Levels/MP_012`
- **Game Mode**: `ConquestLarge0`
- **Player Slots**: 32 total (8 recommended for humans + 24 bots)
- **Ticket Count**: 100 per team
- **Round Time**: Unlimited

### Bot Configuration
- **Count**: 24 bots (12 per team)
- **Difficulty**: Veteran (configurable)
- **Classes**: Balanced across all 4 classes
- **Vehicles**: Enabled for bots
- **Objectives**: High focus on capture points

### VU (Venice Unleashed) Features
- **Server Browser**: Visible in VU mod
- **Port**: 19567 (game) + 8080 (HTTP) + 47200 (RCON)
- **Authentication**: Guests allowed
- **Anti-cheat**: Enabled but lenient for bots

## Network Configuration

### Required Ports
Open these ports in your firewall and router:
- **19567** (TCP/UDP) - Game server
- **8080** (TCP) - VU HTTP interface
- **47200** (TCP) - RCON admin interface

### Automatic Firewall Setup
The startup scripts automatically configure Windows Firewall rules when run as administrator.

## Admin Commands

### In-Game Console Commands
```
admin.say <message>           # Send message to all players
admin.yell <message>          # Send urgent message
admin.kickPlayer <player>     # Kick a player
admin.banPlayer <player>      # Ban a player
admin.listPlayers            # List all connected players
admin.restartRound           # Restart current round
admin.changeMap <mapname>     # Change map (Harbor only)
```

### RCON Interface
Connect to `localhost:47200` with password `rcon123` (change this!) to send admin commands remotely.

## Troubleshooting

### Common Issues

**"Server executable not found"**
- Ensure `BFBC2_Server.exe` is in the root directory
- Download proper BFBC2 server files
- Consider using Venice Unleashed mod

**"Port already in use"**
- Change server port in `server.cfg`: `sv_port 19568`
- Ensure no other BFBC2 servers are running
- Check Windows Services for conflicting applications

**"Bots not spawning"**
- Verify `ai_enabled true` in server.cfg
- Check bot configuration in `server/bots/bot_config.cfg`
- Ensure minimum players: `sv_roundStartPlayerCount 1`

**"Server not visible in VU browser"**
- Check VU configuration in `server/vu/vu_config.cfg`
- Ensure `vu.publicServer true` and `vu.serverListing true`
- Verify network ports are open
- Check VU mod is properly installed

### Performance Optimization

**For Lower-End Hardware:**
```cfg
# In server.cfg
ai_maxBots 16              # Reduce bot count
sv_maxPlayers 24           # Reduce total players
sv_tickRate 30             # Lower tick rate
```

**For High-End Hardware:**
```cfg
# In server.cfg
ai_maxBots 30              # More bots
sv_maxPlayers 32           # Full capacity
sv_tickRate 60             # Higher tick rate
```

## File Structure
```
bfbc2-server-with-bots/
├── README.md
├── SETUP.md                  # This file
├── server/
│   ├── config/
│   │   ├── server.cfg        # Main server configuration
│   │   ├── admin.cfg         # Admin settings
│   │   └── maplist.cfg       # Map rotation (Harbor only)
│   ├── bots/
│   │   └── bot_config.cfg    # AI bot configuration
│   ├── vu/
│   │   └── vu_config.cfg     # Venice Unleashed settings
│   ├── scripts/
│   │   ├── start_server.bat  # Windows batch startup
│   │   └── start_server.ps1  # PowerShell startup
│   └── logs/                 # Server logs (created automatically)
└── [Server Files]            # BFBC2 server executable and data
```

## Security Notes

### Change Default Passwords
Before running your server publicly, change these default passwords:

```cfg
# In server/config/server.cfg
sv_adminPassword "your_secure_password_here"

# In server/config/admin.cfg
admin.addUser "admin" "your_admin_password" 100

# In server/vu/vu_config.cfg
vu.rconPassword "your_rcon_password"
```

### Firewall Configuration
The server requires several ports to be open. The startup scripts handle Windows Firewall automatically, but you may need to configure your router's port forwarding for public servers.

## Support

### Getting Server Files
- **Venice Unleashed**: https://veniceunleashed.net/ (recommended)
- **Community Forums**: Search for BFBC2 server files
- **Official Sources**: EA/DICE server packages (if available)

### Community Resources
- BFBC2 modding communities
- Venice Unleashed Discord/Forums
- Battlefield server hosting communities

## License
This configuration is provided as-is for community use. Ensure you have proper licenses for BFBC2 server files.