<h1>
  <img src="https://github.com/Portal-2-Multiplayer-Mod/P2MM-ART/blob/e56d8c209eb3f143bb0607dc1e59730e517ecca6/Banners/P2MMBannerREADME.png?raw=true" alt="P2MMBannerREADME" width="472" height="290" align="left">
  <a href="https://discord.gg/nXRygGNxyK" target="_blank">
      <img src="https://img.shields.io/discord/839651379034193920?color=blue&label=Discord%20Users&style=for-the-badge&logo=discord&logoWidth=20"
              alt="Discord Shield Badge" style="margin-bottom: 10px;" align="right">
  </a>
  <br>
  <a href="https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/releases/latest">
      <img src="https://img.shields.io/github/release-date/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod?color=red&label=Latest%20Release&style=for-the-badge"
              alt="Release Shield Badge" style="margin-bottom: 10px;" align="right">
  </a>
  <br>
  <img src="https://img.shields.io/github/downloads/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/total?style=for-the-badge&label=TOTAL%20DOWNLOAD%20COUNT"
          alt="Download Count Shield Badge" style="margin-bottom: 10px;" align="right">
  </a>
  <br>
  <a href="https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/commits/main">
      <img src="https://img.shields.io/github/last-commit/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod?label=LAST%20COMMIT%20(MAIN)&style=for-the-badge"
              alt="Commit Shield Badge" style="margin-bottom: 10px;" align="right">
  </a>
  <br>
  <a href="https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/commits/dev">
      <img src="https://img.shields.io/github/last-commit/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/dev?style=for-the-badge&label=LAST%20COMMIT%20(DEV)&color=%2334a5eb"
              alt="GitHub last commit (branch)" align="right">
  </a>
  <br>
  <p align="right">PORTAL 2:</p>
  <p align="right">MULTIPLAYER MOD</p>
</h1>

***
WARNING!!!

Currently the `main` branch is messed up!
If you wish to contribute, please use the `dev` branch instead as that has more cleaned up and more stable code.
Also please refer to information in that branches README as those are more updated and are also in other languages.
***

### This mod is completely server-side. Only the host needs to run Portal 2 with the mod installed. People who join the host should run stock Portal 2.

## Mod features

```
  - A maximum player cap of 33
  - Nametags
  - Custom Player colors
  - Chat commands (!help)
  - In-game Admin system
  - Full cooperative campaign support
  - Full singleplayer campaign support (needs minor polishing)
  - Full Super 8 map support
  - In-house map support for select workshop maps
  - Encryption of client commands invoked through the active GameRules class
  - Support for Linux, Windows 7 and above
  - Togglable game options and config system exposed through VScript and a custom plugin
  - Support for SAR (SourceAutoRecord) for speedrunning
  - Native support for dedicated servers if you manage to get one working :)
```

## Features to be added

- Steam Deck/SteamOS 3.0 support
- Discord API for easy invites
- More support for workshop maps
- FastDL Support

# Installation & use

**Steam guide on how to host and join a game:**
- https://steamcommunity.com/sharedfiles/filedetails/?id=2458260280

**Latest version:**
- https://github.com/kyleraykbs/Portal2-32PlayerMod/releases/latest

**Discord Server for technical help (MAKE SURE YOU READ THE FAQ!!!), bug report or to just chat:**
- https://discord.gg/kW3nG6GKpF


# Build

*We use Python 3.10 for the launcher*

**Dependencies**
- pygame
- pyperclip
- requests
- steamid-converter

We also have them in a file for easy install `pip install -r requirements.txt`

**Compilation**

We use `pyinstaller` to make the executable
- Windows:

```
pyinstaller "src/MainWindow.py" -F -i "src/GUI/assets/images/p2mm64.ico" --noconsole --add-data "src/GUI;GUI" --add-data "src/ModFiles;ModFiles" --add-data "src/languages;languages"
```

- Linux:

```
pyinstaller "src/MainWindow.py" -F --add-data "src/GUI:GUI" --add-data "src/ModFiles:ModFiles" --add-data "src/languages:languages"
```

*Note:*  
- If you want to fork the project and do your own releases you need to changes the variables at the top of `src/Scripts/Updater.py` to your own information


# Contributions

We are always happy to take whatever additional help we can get for this project. Specifically, we are in need of proficient coders in Squirrel or C++. If you think you can spare a hand, it will go a long way!

# Credits

**Developers:**

- kyleraykbs
- Bumpy
- Nanoman2525
- vista
- Wolƒe Strider Shoσter
- cabiste
- Orsell9

**Contributors:**

- wanderer (free bird)
- \n
- Luukex
- MeblIkea
- Luukex
- PieCreeper
- Areng
