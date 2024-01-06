<h1>
  <img src="https://github.com/Portal-2-Multiplayer-Mod/P2MM-ART/blob/e56d8c209eb3f143bb0607dc1e59730e517ecca6/Banners/P2MMBannerREADME.png" alt="P2MMBannerREADME" width="500" height="300" align="left">
  <a href="https://discord.gg/nXRygGNxyK">
    <img src="https://img.shields.io/discord/839651379034193920?color=blue&label=Discord%20Users&style=for-the-badge&logo=discord&logoWidth=20" alt="Discord Shield Badge" align="right">
  </a>
  <br>
  <a href="https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/releases/latest">
    <img src="https://img.shields.io/github/release-date/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod?color=red&label=Latest%20Release&style=for-the-badge" alt="Release Shield Badge" align="right">
  </a>
  <br>
    <img src="https://img.shields.io/github/downloads/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/total?style=for-the-badge&label=TOTAL%20DOWNLOAD%20COUNT" alt="Download Count Shield Badge" align="right">
  </a>
  <br>
  <a href="https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/commits/main">
    <img src="https://img.shields.io/github/last-commit/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod?label=LAST%20COMMIT%20(MAIN)&style=for-the-badge" alt="Commit Shield Badge" align="right">
  </a>
  <br>
  <a href="https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/commits/finalcleanup">
    <img alt="GitHub last commit (branch)" src="https://img.shields.io/github/last-commit/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/finalcleanup?style=for-the-badge&label=LAST%20COMMIT%20(FINALCLEANUP)&color=%2334a5eb" align="right">
  </a>
  <br>
  <br>
  <br>
  <p align="right">PORTAL 2: MULTIPLAYER MOD</p>
</h1>

### This mod is completely server-side. Only the host needs to run Portal 2 with the mod installed. People who join the host should run stock Portal 2.

## Languages

**_English_** | [Español](README.es.md) | [Polish](README.pl.md) | [简体中文](README.zh-CN.md) | [繁體中文](README.zh-TW.md) | [Italiano](README.it.md) | [Français](README.fr.md)

## Mod features

```
  - A maximum player cap of 33
  - Name Tags
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
```

# Installation & use

**Steam guide on how to host and join a game:**

- <https://steamcommunity.com/sharedfiles/filedetails/?id=2458260280>

**Download the latest version:**

- <https://github.com/Portal-2-Multiplayer-Mod/Portal2-Multiplayer-Mod/releases/latest>

**Discord Server for technical help (MAKE SURE YOU READ THE FAQ!!!), bug report or to just chat:**

- <https://discord.gg/kW3nG6GKpF>

# Building the Launcher

## Dependencies

- Python 3.10
- pygame
- pyperclip
- requests
- steamid-converter

We also have them in a file for easy install; `pip install -r requirements.txt`

## Compilation

We use `pyinstaller` and `AppImage` to make the executables!

### Windows:

For windows we only use [pyinstaller](https://pypi.org/project/pyinstaller/) to build the executable (if you know of better options please tell us)

```shell
pyinstaller "src/MainWindow.py" -F -i "src/GUI/images/p2mm64.ico" --noconsole --add-data "src/GUI;GUI" --add-data "src/ModFiles;ModFiles" --add-data "src/Languages;Languages"
```

### Linux:

For Linux we switched to using [AppImage](https://appimage.org/) and we made a tool to help with that, simply have `docker` installed and run `./tools/build-docker.sh` while in the root directory.

***WARNING! For some reason on some Linux distributions, FUSE is not installed by default which is needed for both compiling and running AppImages. Information for installing FUSE on your distribution can be found here: [AppImageKit's Wiki](https://github.com/AppImage/AppImageKit/wiki/FUSE)***

If you don't want to use AppImage/docker, you can still use pyinstaller:

```shell
pyinstaller "src/MainWindow.py" -F --add-data "src/GUI:GUI" --add-data "src/ModFiles:ModFiles" --add-data "src/Languages:Languages"
```

### Notes:

- If you want to fork the project and do your own releases you need to change the variables at the top of `src/Scripts/Updater.py` to your own information and update the values in `AppImageBuilder.yml`

# Contributions

As of 2.2.0's release, all that will be accepted for contributions will be bug fixes, issues impacting use with the launcher and/or when running the mod in Portal 2, and translations for the launcher. Any major changes will be rejected as we are trying to make effort toward the 3.0 rewrite instead of continuing work on the 2.0 series. You are welcome though to help us out over on the [3.0 rewrite repository](https://github.com/Portal-2-Multiplayer-Mod/P2MM-Entanglement) though! There we are in need of Python and C++ programmers.

# Credits

**Developers:**

- kyleraykbs
- Bumpy
- Nanoman2525
- vista
- Wolƒe Strider Shoσter
- cabiste
- Orsell

**Contributors:**

- wanderer (free bird)
- \n
- Luukex
- MeblIkea
- PieCreeper
- Areng
