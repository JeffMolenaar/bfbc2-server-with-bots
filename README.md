# BFBC2 Harbor Conquest Server with Bots

A complete Battlefield Bad Company 2 server setup for Windows 11, pre-configured for Harbor map Conquest mode with AI bots and Venice Unleashed compatibility.

## Features

🎮 **Harbor Conquest Only** - Dedicated Harbor map server in Conquest Large mode  
🤖 **24 AI Bots** - Intelligent bots with configurable difficulty and behavior  
🌐 **VU Compatible** - Visible in Venice Unleashed mod server browser  
⚙️ **Easy Setup** - Automated scripts for Windows 11 deployment  
🔧 **Fully Configured** - Ready-to-run configuration files included  

## Quick Start

1. **Clone this repository**
2. **Run verification**: `verify_installation.bat`
3. **Get BFBC2 server files** (see [SETUP.md](SETUP.md))
4. **Start server**: `server/scripts/start_server.bat`

## Server Specifications

| Setting | Value |
|---------|-------|
| **Map** | Harbor (MP_012) |
| **Game Mode** | Conquest Large |
| **Max Players** | 32 (8 human + 24 bots recommended) |
| **Bot Difficulty** | Veteran (configurable) |
| **Server Port** | 19567 |
| **VU Support** | Enabled |
| **Admin Access** | RCON + In-game commands |

## What's Included

### Configuration Files
- 🔧 **Server Configuration** (`server/config/server.cfg`) - Core server settings
- 👨‍💼 **Admin Configuration** (`server/config/admin.cfg`) - Admin accounts and permissions
- 🗺️ **Map List** (`server/config/maplist.cfg`) - Harbor-only rotation
- 🤖 **Bot Configuration** (`server/bots/bot_config.cfg`) - AI behavior and settings
- 🌐 **VU Configuration** (`server/vu/vu_config.cfg`) - Venice Unleashed integration

### Startup Scripts
- 📄 **Batch Script** (`server/scripts/start_server.bat`) - Simple Windows startup
- ⚡ **PowerShell Script** (`server/scripts/start_server.ps1`) - Advanced startup with error handling
- ✅ **Verification Script** (`verify_installation.bat`) - Check installation completeness

### Documentation
- 📖 **Setup Guide** ([SETUP.md](SETUP.md)) - Detailed installation and configuration
- 🚀 **Quick Start** (this file) - Fast deployment instructions

## Requirements

- **Windows 11** (64-bit)
- **BFBC2 Server Files** (obtain separately)
- **Administrator privileges** (for firewall configuration)
- **Venice Unleashed mod** (recommended)

## Getting Server Files

You need to obtain BFBC2 server files from one of these sources:

1. **Venice Unleashed** (recommended): https://veniceunleashed.net/
2. **Official EA/DICE server packages** (if available)
3. **Community server distributions**

Place the server executable as `BFBC2_Server.exe` in the root directory.

## Default Settings

⚠️ **IMPORTANT**: Change these default passwords before public deployment!

- **Admin Password**: `admin123`
- **RCON Password**: `rcon123`
- **Server Name**: "BFBC2 Harbor Conquest with Bots"

## Network Ports

The server uses these ports (automatically configured in Windows Firewall):

- **19567** (TCP/UDP) - Game server
- **8080** (TCP) - VU HTTP interface  
- **47200** (TCP) - RCON admin interface

## Troubleshooting

**Common Issues:**
- 🔧 **Server won't start**: Check if BFBC2_Server.exe exists
- 🌐 **Not visible in VU**: Verify network ports are open
- 🤖 **No bots spawning**: Check bot configuration and minimum player count

See [SETUP.md](SETUP.md) for detailed troubleshooting and configuration options.

## File Structure

```
bfbc2-server-with-bots/
├── 📄 README.md              # This file
├── 📖 SETUP.md               # Detailed setup guide
├── ✅ verify_installation.bat # Installation checker
├── 📁 server/
│   ├── 📁 config/            # Server configuration files
│   ├── 📁 bots/              # Bot AI configuration
│   ├── 📁 vu/                # Venice Unleashed settings
│   ├── 📁 scripts/           # Startup scripts
│   └── 📁 logs/              # Server logs (auto-created)
└── 🎮 [Server Files]         # BFBC2 executable & data (add these)
```

## License

This configuration package is provided as-is for community use. Ensure you have proper licenses for BFBC2 server files.

---

**Ready to deploy your Harbor Conquest server? Start with [SETUP.md](SETUP.md)!**