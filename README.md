<h1>
  <img src="https://github.com/OrsellGaming/Portal2-32PlayerMod-Orsell/blob/dev/P2MMP33Logo.png" alt="P2MMP33 Logo" width="200" align="left">
  <a href="https://discord.gg/nXRygGNxyK"><img src="https://img.shields.io/discord/839651379034193920?color=blue&label=Discord%20Users&style=for-the-badge" alt="Discord Shield Badge" align="right"></a>
  <br><a href="https://github.com/kyleraykbs/Portal2-32PlayerMod/releases/latest"><img src="https://img.shields.io/github/release-date/kyleraykbs/Portal2-32PlayerMod?color=red&label=Latest%20Release&style=for-the-badge" alt="Release Shield Badge" align="right"></a>
  <br><a href="https://github.com/kyleraykbs/Portal2-32PlayerMod/commits/main"><img src="https://img.shields.io/github/last-commit/kyleraykbs/Portal2-32PlayerMod?label=Last%20Commit&style=for-the-badge" alt="Commit Shield Badge" align="right"></a>
  <br><a href="https://github.com/kyleraykbs/Portal2-32PlayerMod/releases/latest"><img src="https://img.shields.io/github/downloads/kyleraykbs/Portal2-32PlayerMod/total?style=for-the-badge" alt="Download Count Shield Badge" align="right"></a>
  <br>
  <p align="right">PORTAL 2: MULTIPLAYER MOD</p>
</h1>

### Note: This mod is completely server-side. Only the host needs to run Portal 2 with the mod installed. People who join the host should run stock Portal 2.
## Mod features
```
  A maximum player cap of 33
  Player colors
  Chat commands
  Nametags
  Admin System in-game
  Full cooperative campaign support
  Full singleplayer campaign support (needs minor polishing)
  Full Super 8 map support
  Full cooperative Gelocity map support
  Encryption of cvars from clients
  Support for Linux and Windows 7-11
  Ground up VScript development environment
```

## Features Coming Eventually
- Player-specific colored portals (this one is going to take a lot of time to implement)
- A system for map makers to make maps compatiable with P2MM
- Steam Deck/Steam OS 3.0 support
- Discord API for easy invites
- More support for workshop maps

# Installation & use

Latest version (older versions not recommended):
- https://github.com/kyleraykbs/Portal2-32PlayerMod/releases/latest

**The Steam guide goes over everything you need to know in order to get the mod working, so be sure to read through it to prevent confusion.**
- https://steamcommunity.com/sharedfiles/filedetails/?id=2458260280

If you need help setting up this mod, or just want to chill with a great community filled with developers, feel free to join our Discord server!
- https://discord.gg/kW3nG6GKpF

# Contributions

If you want to contribute to this project you can do so in 3 ways:
- Help with the Launcher written in python and using pygame
- Help with the VScript (add support to workshop maps or optimize/clean current code)
- Localize the launcher with different languages. You can do this by creating a folder called `languages` in your p2mm folder and start creating JSON files in it for each different language. Here is the base English.json to work off of: [Base English.json Translation File](https://github.com/kyleraykbs/Portal2-32PlayerMod/blob/main/src/languages/English.json)

# How to build the executable
This is optional if you prefer not to use official release compilations.

### Dependencies
- pygame
- requests
- steamid-converter
- pyperclip

### Compilation
You will need `pyinstaller` in order to proceed.

- Windows: `pyinstaller src/MainWindow.py -F -i src/GUI/assets/images/p2mm64.ico --noconsole --add-data "src/GUI;GUI" --add-data "src/ModFiles;ModFiles" --add-data "src/languages;languages"`

- Linux: `pyinstaller "src/MainWindow.py" -F --add-data "src/GUI:GUI" --add-data "src/ModFiles:ModFiles" --add-data "src/languages:languages"`

**Note: If you would like to fork the project and make your own releases, you will need to change the variables at the top of `Updater.py`**

# Credits
**Head Developers**
- kyleraykbs *(Vscript, Singleplayer Support, Cooperative Support, Launcher, Exploit Finder)*
- Nanoman2525 *(Community Manager, Exploit Finder, Vscript, Singleplayer Support, Cooperative Support, VScript optimization)*
- Vista *(C++ Plugin, Reverse Engineering)*
- cabiste *(Launcher, Overall code optimization)*
- Bumpy *(Minor Vscript, Exploit Finder)*
- Wolƒe Strider Shoσter *(Singleplayer Support, Minor Vscript)*

**Team Members**
- QuantumCoded (Jeffrey)
- Orsell (AKA zwexit) *(Launcher Dev, VScript, Map Maker)*
- \n *(Test Subject (Under Gunpoint))*
- wanderer *(Exploit Finder, Dedicated Server Support, Reverse Engineering*)