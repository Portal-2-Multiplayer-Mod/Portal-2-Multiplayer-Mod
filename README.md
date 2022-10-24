# **Portal 2: Multiplayer Mod**

**Note: This mod is completely server-side. Only the host needs to run Portal 2 with the mod installed. People who join the host should run stock Portal 2.**

## Mod features
```
  Maximum player cap of 33
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
  VScript codebase from scratch
```

# Installation & use

- Latest version released: https://github.com/kyleraykbs/Portal2-32PlayerMod/releases/latest

***The Steam guide goes over everything you need to know in order to get the mod working, so be sure to read through it to prevent confusion.***
- Steam guide: https://steamcommunity.com/sharedfiles/filedetails/?id=2458260280

*If you need help setting up this mod, or just want to chill with a great community filled with developers, feel free to join our Discord server!*
- https://discord.gg/kW3nG6GKpF

# Contributions

If you want to contribute to this project you can do so in 3 ways:
1- Help with the Launcher written in python and using pygame
2- Help with the VScript (add support to workshop maps or optimize/clean current code)
3- Localize the launcher (you can do this by creating a folder `languages` in your p2mm folder and create json files in it, [base translation file](https://github.com/kyleraykbs/Portal2-32PlayerMod/blob/main/src/languages/English.json))

# How to build the executable
- This is optional if you prefer not to use official release compilations.

### Dependencies
- pygame
- requests
- steamid-converter
- pyperclip

### Compilation
*You will need `pyinstaller` in order to proceed.*

- Windows: `pyinstaller src/MainWindow.py -F -i src/GUI/assets/images/p2mm64.ico --noconsole --add-data "src/GUI;GUI" --add-data "src/FALLBACK;FALLBACK" --add-data "src/languages;languages"`

- Linux: `pyinstaller "src/MainWindow.py" -F --add-data "src/GUI:GUI" --add-data "src/FALLBACK:FALLBACK" --add-data "src/languages:languages"`

**Note: If would like to fork the project make your own releases, you need to change the variables at the top of `Updater.py`**


# Credits
**Head Developers**
- kyleraykbs *(Vscript, Singleplayer Support, Cooperative Support, Launcher, Exploit Finder)*
- Nanoman2525 *(Community Manager, Exploit Finder, Vscript, Singleplayer Support, Cooperative Support, Vscript optimization)*
- Vista *(C++ Plugin, Reverse Engineering)*
- cabiste *(Launcher, Overall code optimization)*
- Bumpy *(Minor Vscript, Exploit Finder)*
- Wolƒe Strider Shoσter *(Singleplayer Support, Minor Vscript)*

**Team Members**
- Orsell
- \n
- QuantumCoded (Jeffrey)
