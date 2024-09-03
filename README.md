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

**_English_** | [Español](README.es.md) | [Polish](README.pl.md) | [简体中文](README.zh-CN.md) | [繁體中文](README.zh-TW.md) | [Italiano](README.it.md) | [Français](README.fr.md) | [Português (Brasil)](README.pt_BR.md) | [한국어 (Korean)](README.ko.md)

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

# Installation & Use

**Wiki guides on how setup P2:MM:**

- <https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/wiki>

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

We use [`nuitka`](https://nuitka.net/) to compile the Portal 2: Multiplayer Mod Launcher. Along side it we use GitHub Actions for our release executables. [`pyinstaller`](https://pypi.org/project/pyinstaller/) and [`AppImage`](https://appimage.org/) were originally originally used by have been deprecated in favor of `nuitka`.

### Windows

For Windows we use `nuitka` to create our `.exe` files. While slower to compile than `pyinstaller` which was used in older builds, it provides a smaller executable size. `nutka` is able to be installed using `pip`.

Below is the full terminal command we use in release executables, it's slightly different than what GitHub Actions uses, and below that is a stripped down version without version information and such:

```shell
python -m nuitka --onefile --windows-console-mode=disable --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages"  --windows-icon-from-ico="src/GUI/images/p2mm-icon.ico" --product-name="Portal 2: Multiplayer Mod Launcher" --file-description="The launcher for P2:MM." --product-version="INSERT VERSION HERE" --file-version="INSERT VERSION HERE" --copyright='© 2024 Portal 2: Multiplayer Mod Team' "src/MainWindow.py"
```

```shell
python -m nuitka --onefile --windows-console-mode=disable --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages"  --windows-icon-from-ico="src/GUI/images/p2mm-icon.ico" "src/MainWindow.py"
```

### Linux

Just like Windows, `nuitka` is used to compile the Linux executables. Originally `pyinstaller` was used, then `Appimage`, but settled with `nuitka` for the small executable size.

Below is the terminal command to compile for Linux using `nuitka`:

```shell
python -m nuitka --onefile --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages" --linux-icon="src/GUI/images/p2mm-icon.ico" "src/MainWindow.py"
```

### Notes

- If you want to fork the project and do your own releases you need to change the variables at the top of `src/Scripts/Updater.py` to your own information and update the values in `AppImageBuilder.yml` as well as information in respective compiling commands like with `nuitka`.

# Contributions

Portal 2: Multiplayer Mod version `2.3.0` will be our definitive version, so we won't make any significant updates after it is fully released. Before this happens, we will work on commits to the `dev` branch before leading to the full version. We will accept any substantial changes or features for P2:MM during this period. However, we will not be doing much work at all after release or make any new releases in general. The only reasons we would make a new release would be when someone contributes a new translation, an improvement of a current translation, some other minor bug fix we didn't catch, or a map support file for a workshop map. Even after this final release, you can still fork it to build off our work! Please make sure you give credit to this repository!

# Credits

**Developers:**

- kyleraykbs
- Bumpy
- Nanoman2525
- vista (NULLderef)
- Wolƒe Strider Shoσter
- cabiste
- Orsell

**Contributors:**

- wanderer (free bird)
- \n
- Luukex
- MeblIkea
- PieCreeper
