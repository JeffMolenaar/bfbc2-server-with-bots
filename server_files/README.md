# Server Files Directory

This directory is where you need to place the BFBC2 server executable and game files.

## Required Files

### Main Server Executable
- `BFBC2_Server.exe` - Place this in the root directory (`../BFBC2_Server.exe`)

### Game Data (in this directory)
- `data/` - Game data files and assets
- `maps/` - Map files including Harbor (MP_012)
- `mods/` - Any server modifications or bot AI files

### Venice Unleashed (Optional but Recommended)
- `vu/VeniceUnleashed.exe` - VU server executable
- `vu/` - VU mod files and configurations

## Where to Get These Files

### Option 1: Venice Unleashed (Recommended)
- Download from: https://veniceunleashed.net/
- Includes server files, enhanced features, and active community
- Better bot support and server management

### Option 2: Official BFBC2 Server Files
- If you have access to official EA/DICE server packages
- Legacy server files from official sources

### Option 3: Community Distributions
- Various community-maintained server packages
- Ensure legitimacy and proper licensing

## Installation

1. Download server files from one of the sources above
2. Extract `BFBC2_Server.exe` to the repository root directory
3. Extract game data to the appropriate subdirectories here
4. Run `verify_installation.bat` to check everything is correct
5. Use `server/scripts/start_server.bat` or `start_server.ps1` to launch

## Legal Notice

Ensure you have proper licenses for all BFBC2 server files. This repository only provides configuration and setup scripts - not the copyrighted game files themselves.