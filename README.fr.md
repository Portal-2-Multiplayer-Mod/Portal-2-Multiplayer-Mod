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
    <br>
    <p align="right">PORTAL 2:</p>
    <p align="right">MULTIPLAYER MOD</p>
</h1>

### Ce mod est uniquement pour le serveur. Seul l'hôte a besoin du mod installé et de le lancer. Les gens qui jouent n'ont pas besoin du mod.

## Langages

[English](README.md) | [Español](README.es.md) | [Polish](README.pl.md) | [简体中文](README.zh-CN.md) | [繁體中文](README.zh-TW.md) | [Italiano](README.it.md) | **_Français_** | [Português (Brasil)](README.pt_BR.md)

## Caractéristiques du mod

```
  - Un nombre de joueur maximal de 33
  - Nom des joueurs
  - Possibilité de changer la couleur du joueur
  - Commandes dans le chat (!help)
  - Système d'admnistration en jeu
  - Campagne cooperative totalement supportée
  - Campagne solo supportée (besoin d'un peu de polissage)
  - Map bonus "Super 8" supportée
  - Changemment de map (workshop compris) possible
  - Chiffrement des commandes client même si la classe GameRules est active
  - Sont supportés : Linux, Windows 10 et supérieur 
  - Options du jeu et configuration du système dans VScript et un plugin custom
  - SAR (SourceAudioRecord) pour le speedrun supporté
```

# Installation & Utilisation

**Guides du Wiki sur la configuration de P2:MM :**

- <https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/wiki>

**Télécharger la dernière version:**

- <https://github.com/Portal-2-Multiplayer-Mod/Portal2-Multiplayer-Mod/releases/latest>

**Serveur discord si besoin d'aide (SOYEZ SÛRS D'AVOIR LU LA FAQ!!!):**

- <https://discord.gg/kW3nG6GKpF>

# Construction du Lanceur

## Dépendances

- Python 3.10
- pygame
- requests
- steamid-converter

On a aussi un fichier pour une simple installation: `pip install -r requirements.txt`

## Compilation

Nous utilisons [`nuitka`](https://nuitka.net/), [`pyinstaller`](https://pypi.org/project/pyinstaller/), et [`AppImage`](https://appimage.org/) pour créer les exécutables.

### Windows:

Pour Windows, nous utilisons `nuitka` pour créer nos fichiers `.exe`. Bien qu'il soit plus lent à compiler que `pyinstaller` qui était utilisé dans les versions précédentes, il offre une taille d'exécutable plus petite et n'alerte pas Windows Defender. `pyinstaller` ne doit être utilisé qu'en cas de secours si `nuitka` ne fonctionne pas pour vous pour une raison quelconque. Les deux peuvent être installés en utilisant `pip install`.

Ci-dessous se trouve la commande terminal complète que nous utilisons pour compiler le lanceur, et en dessous une version simplifiée sans informations de version et autres détails :

```shell
python -m nuitka --onefile --windows-console-mode=disable --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages"  --windows-icon-from-ico="src/GUI/images/p2mm-icon.ico" --product-name="Portal 2: Multiplayer Mod Launcher" --file-description="The launcher for P2:MM." --product-version="INSERT VERSION HERE" --file-version="INSERT VERSION HERE" --copyright='© 2024 Portal 2: Multiplayer Mod Team' "src/MainWindow.py"
```

```shell
python -m nuitka --onefile --windows-console-mode=disable --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages"  --windows-icon-from-ico="src/GUI/images/p2mm-icon.ico" "src/MainWindow.py"
```

Voici la commande terminal pour compiler en utilisant `pyinstaller` :

```shell
pyinstaller "src/MainWindow.py" -F -i "src/GUI/images/p2mm-icon.ico" --noconsole --add-data "src/GUI;GUI" --add-data "src/Languages;Languages"
```

### Linux:

Pour Linux, nous avons basculé vers l'utilisation de `AppImage` et nous avons créé un outil pour aider à cela, il suffit d'avoir `docker` installé et d'exécuter `./tools/build-docker.sh` tout en étant dans le répertoire racine.

_**ATTENTION ! Pour une raison quelconque, sur certaines distributions Linux, FUSE n'est pas installé par défaut, ce qui est nécessaire à la fois pour la compilation et l'exécution des AppImages. Les informations pour installer FUSE sur votre distribution peuvent être trouvées ici : [Wiki de AppImageKit](https://github.com/AppImage/AppImageKit/wiki/FUSE)**_

Si vous ne souhaitez pas utiliser `AppImage/docker`, vous pouvez toujours utiliser `pyinstaller` :

```shell
pyinstaller "src/MainWindow.py" -F --add-data "src/GUI:GUI" --add-data "src/Languages:Languages"
```

### Notes:

- Si vous voulez forker le projet et faire vos propres versions, vous devez changer les variables en haut de `src/Scripts/Updater.py` avec vos propres informations et mettre à jour les valeurs dans `AppImageBuilder.yml` ainsi que les informations dans les commandes de compilation respectives, comme avec `nuitka`.

# P2:MM Plugin

Le Mod Multijoueur de Portal 2 utilise un plugin serveur Source Engine séparé afin de se connecter à Portal 2 pour patcher le jeu et permettre à certains systèmes de fonctionner de manière que VScript ne peut normalement pas le faire. Le plugin a été placé dans un dépôt séparé en raison de la nature du développement et de l'environnement de compilation des plugins Source Engine. Vous pouvez trouver son code source ici : <https://github.com/OrsellGaming/Portal-2-Multiplayer-Mod-Plugin>

# Contributions

Portal 2: Multiplayer Mod version `2.3.0` sera notre version définitive, donc nous ne ferons plus de mises à jour significatives après sa sortie complète. Avant que cela ne se produise, nous travaillerons sur des mises à jour mineures menant à la version complète. Nous accepterons tout changement ou fonctionnalité substantielle pour P2:MM pendant cette période. Cependant, nous ne ferons pas beaucoup de travail après la sortie ou de nouvelles sorties en général. Les seules raisons pour lesquelles nous ferions une nouvelle sortie seraient lorsqu'une personne contribue une nouvelle traduction, une amélioration d'une traduction actuelle, une autre correction mineure de bogue que nous n'avons pas détectée, ou un fichier de support de carte pour une carte d'atelier. Même après cette sortie finale, vous pouvez toujours le forker pour développer notre travail ! Assurez-vous de donner crédit à ce dépôt !

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
