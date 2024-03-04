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


### This mod is completely server-side. Only the host needs to run Portal 2 with the mod installed. People who join the host should run stock Portal 2.

## Languages

**_English_** | [Español](README.es.md) | [Polish](README.pl.md) | [简体中文](README.zh-CN.md) | [繁體中文](README.zh-TW.md) | [Italiano](README.it.md) | [Français](README.fr.md) | [Português (Brasil)](README.pt_BR.md)

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
  - Support for Linux, Windows 10 and above
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
- requests
- steamid-converter

We also have them in a file for easy install: `pip install -r requirements.txt`

## Compilation

We use `pyinstaller` and `AppImage` to make the executables!

### Windows:

For windows we only use [pyinstaller](https://pypi.org/project/pyinstaller/) to build the executable (if you know of better options please tell us).

```shell
pyinstaller "src/MainWindow.py" -F -i "src/GUI/images/p2mm64.ico" --noconsole --add-data "src/GUI;GUI" --add-data "src/Languages;Languages"
```

### Linux:

For Linux we switched to using [AppImage](https://appimage.org/) and we made a tool to help with that, simply have `docker` installed and run `./tools/build-docker.sh` while in the root directory.

***WARNING! For some reason on some Linux distributions, FUSE is not installed by default which is needed for both compiling and running AppImages. Information for installing FUSE on your distribution can be found here: [AppImageKit's Wiki](https://github.com/AppImage/AppImageKit/wiki/FUSE)***

If you don't want to use AppImage/docker, you can still use pyinstaller:

```shell
pyinstaller "src/MainWindow.py" -F --add-data "src/GUI:GUI" --add-data "src/Languages:Languages"
```

### Notes:

- If you want to fork the project and do your own releases you need to change the variables at the top of `src/Scripts/Updater.py` to your own information and update the values in `AppImageBuilder.yml`

# Contributions

Portal 2: Multiplayer Mod version `2.2.0` will be our definitive version, so we won't make any significant updates after it is fully released. Before this happens, we will work on minor updates leading to the full version. We will accept any substantial changes or features for P2:MM during this period. However, we will not accept any more significant changes after the full release. The only reasons we would make a new release would be when someone contributes a new translation, an improvement of a current translation, some other minor bug fix we didn't catch, or a map support file for a workshop map. We will only make another release under those circumstances and will no longer accept anything significant into this repository. However, you can still fork it to build off our work! Please make sure you give credit to this repository!

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
