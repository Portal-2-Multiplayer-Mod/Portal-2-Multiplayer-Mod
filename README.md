# **PORTAL 2 MULTIPLAYER MOD**

**Note: This mod is completely server-side. Only the host needs to run Portal 2 with the mod installed. People who join the host should run stock Portal 2.**

## Mod features
```
  Maximum player cap of 33
  Player colors
  Chat commands
  Nametags
  Admin System
  Full cooperative support
  Full singleplayer support (needs minor polishing)
  Full Gelocity support
  Encryption system
  Support for Linux and Windows 7-11
  Ground up VScript development enviornment
```

## Features Coming Eventually
- Player specific colored portals (this one gonna take a lot of time to implement)

# Installation & use

- Latest version released: https://github.com/kyleraykbs/Portal2-32PlayerMod/releases/latest

***The Steam guide goes over everything you need to know in order to get the mod working, so be sure to read through it to prevent confusion.***
- Steam guide: https://steamcommunity.com/sharedfiles/filedetails/?id=2458260280

*If you have* ***ANY*** *problems feel free to join our community we are happy to troubleshoot and fix any bugs*
- https://discord.gg/kW3nG6GKpF


# How to build
### Dependencies
- pygame
- requests
- steamid-converter
- pyperclip

### Compilation
*you need `pyinstaller` to compile the code*
Windows: `pyinstaller src/MainWindow.py -F -i src/GUI/assets/images/p2mm64.ico --noconsole --add-data "src/GUI;GUI" --add-data "src/FALLBACK;FALLBACK" --add-data "src/languages;languages"`
Linux: `pyinstaller "src/MainWindow.py" -F --add-data "src/GUI:GUI" --add-data "src/FALLBACK:FALLBACK" --add-data "src/languages:languages"`

**Note: if you want to fork the project and do your own releases you need to changes the variables at the top of `Udater.py` to your own information**


# Credits
**Founders**
- kyleraykbs *(Team Lead, Main Vscript Dev, Singleplayer Support, Launcher Dev, Exploit Finder, Minor Reverse Engineering)*
- Bumpy *(Minor Vscript, Exploit Finder)*

**Head Creators**
- Vista *(Main C++ Dev, Plugin Dev, Reverse Engineering)*
- Wolƒe Strider Shoσter *(Singleplayer Support, Vscript Dev)*
- cabiste *(Launcher Dev)*
- Nanoman2525 *(Community Manager, Exploit Finder, Minor Vscript)*

**Team Members**
- sear
- QuantumCoded (Jeffrey)
