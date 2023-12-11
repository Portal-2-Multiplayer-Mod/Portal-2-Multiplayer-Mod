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
  <a href="https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/releases/latest">
    <img src="https://img.shields.io/github/downloads/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/total?style=for-the-badge&label=LATEST%20RELEASE%20DOWNLOADS" alt="Download Count Shield Badge" align="right">
  </a>
  <br>
  <a href="https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/commits/main">
    <img src="https://img.shields.io/github/last-commit/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod?label=LAST%20COMMIT%20(MAIN)&style=for-the-badge" alt="Commit Shield Badge" align="right">
  </a>
  <br>
  <a href="https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/commits/finalcleanup">
    <img alt="GitHub last commit (branch)" src="https://img.shields.io/github/last-commit/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/finalcleanup?style=for-the-badge&label=LAST%20COMMIT%20(DEV)&color=%2334a5eb" align="right">
  </a>
  <br>
  <br>
  <br>
  <p align="right">PORTAL 2: MULTIPLAYER MOD</p>
</h1>

### Ce mod est uniquement pour le serveur. Seul l'hôte a besoin du mod installé et de le lancer. Les gens qui jouent n'ont pas besoin du mod.

## Langages

[English](README.md) | [Español](README.es.md) | [Polish](README.pl.md) | [简体中文](README.zh-CN.md) | [繁體中文](README.zh-TW.md) | [Italiano](README.it.md) | **_Français_**

## Caractéristiques du mod

```
  - Un nombre de joueur maximal de 33
  - Nom des joueurs
  - Possibilité de changer la couleur du joueur
  - Commandes dans le chat (!help)
  - Système d'admnistration en jeu
  - Campagne cooperative totalement supportée
  - Campagne solo supportée (needs minor polishing)
  - Map bonus "Super 8" supportée
  - Changemment de map (workshop compris) possible
  - Chiffrement des commandes client même si la classe GameRules est active
  - Linux, Windows 7 et au-dessus sont supportés 
  - Options du jeu et configuration du système dans VScript et un plugin custom
  - SAR (SourceAudioRecord) pour le speedrun supporté
```

# Installation et utilisation 

**Guide steam sur comment rejoindre et héberger une partie:**

- <https://steamcommunity.com/sharedfiles/filedetails/?id=2458260280>

**Télécharger la dernière version:**

- <https://github.com/Portal-2-Multiplayer-Mod/Portal2-Multiplayer-Mod/releases/latest>

**Serveur discord si besoin d'aide (SOYEZ SÛRS D'AVOIR LU LA FAQ!!!):**

- <https://discord.gg/kW3nG6GKpF>

# Build

_On utilise Python 3.10 pour le lanceur_

## Dépendances 

- pygame
- pyperclip
- requests
- steamid-converter

On a aussi un fichier pour une simple installaion; `pip install -r requirements.txt`

## Compilation

On utilise `pyinstaller` et `AppImage` pour créer les executables!

### Windows:

Pour Windows on utilise uniquement [pyinstaller](https://pypi.org/project/pyinstaller/) pour créer l'exécuatble (Si vous connaissez de meilleures options, dites-le nous)

```shell
pyinstaller "src/MainWindow.py" -F -i "src/GUI/images/p2mm64.ico" --noconsole --add-data "src/GUI;GUI" --add-data "src/ModFiles;ModFiles" --add-data "src/Languages;Languages"
```

### Linux:

Pour Linux, on a changé pour utiliser [AppImage](https://appimage.org/) et nous avons fait un outil pour aider, possèdez juste docker installé et exécutez-le `tools/build-docker.sh`.

Mais si vous ne voulez pas utiliser AppImage/docker, vous pouvez toujours utiliser pyinstaller :

```shell
pyinstaller "src/MainWindow.py" -F --add-data "src/GUI:GUI" --add-data "src/ModFiles:ModFiles" --add-data "src/Languages:Languages"
```

### Notes:

- Si vous voulez fork le projet et faire vos propres mises à jour, vous devez changer les variables au dessus de `src/Scripts/Updater.py` et y mettre vos informations et mettre à jour les valeurs dans `AppImageBuilder.yml`

# Contributions

On est toujours ravis d'avoir quelconque aide sur le projet. Spécifiquement, on a besoin de codeurs compétent en Squirrel et C++. Si vous pensez pouvoir nous aider, n'hésitez surtout pas !

# Crédits

**Développeurs:**

- kyleraykbs
- Bumpy
- Nanoman2525
- vista
- Wolƒe Strider Shoσter
- cabiste
- Orsell

**Contributeurs:**

- wanderer (free bird)
- \n
- Luukex
- MeblIkea
- PieCreeper
- Areng