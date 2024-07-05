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

Nous utilisons [`nuitka`](https://nuitka.net/) pour compiler le lanceur de Portal 2: Multiplayer Mod. En parallèle, nous utilisons GitHub Actions pour nos exécutables de sortie. [`pyinstaller`](https://pypi.org/project/pyinstaller/) et [`AppImage`](https://appimage.org/) étaient à l'origine utilisés mais ont été abandonnés au profit de `nuitka`.

### Windows:

Pour Windows, nous utilisons `nuitka` pour créer nos fichiers `.exe`. Bien qu'il soit plus lent à compiler que `pyinstaller` qui était utilisé dans les versions précédentes, il offre une taille d'exécutable plus petite et n'alerte pas Windows Defender. `pyinstaller` ne doit être utilisé qu'en cas de secours si `nuitka` ne fonctionne pas pour vous pour une raison quelconque. Les deux peuvent être installés en utilisant `pip install`.

Ci-dessous se trouve la commande de terminal complète que nous utilisons dans les exécutables de sortie, elle est légèrement différente de celle utilisée par GitHub Actions, et en dessous se trouve une version simplifiée sans les informations de version et autres :

```shell
python -m nuitka --onefile --windows-console-mode=disable --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages"  --windows-icon-from-ico="src/GUI/images/p2mm-icon.ico" --product-name="Portal 2: Multiplayer Mod Launcher" --file-description="The launcher for P2:MM." --product-version="INSERT VERSION HERE" --file-version="INSERT VERSION HERE" --copyright='© 2024 Portal 2: Multiplayer Mod Team' "src/MainWindow.py"
```

```shell
python -m nuitka --onefile --windows-console-mode=disable --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages"  --windows-icon-from-ico="src/GUI/images/p2mm-icon.ico" "src/MainWindow.py"
```

Voici la commande de terminal pour compiler en utilisant `pyinstaller` comme solution de secours si `nuitka` ne fonctionne pas :

```shell
pyinstaller "src/MainWindow.py" -F -i "src/GUI/images/p2mm-icon.ico" --noconsole --add-data "src/GUI;GUI" --add-data "src/Languages;Languages"
```

### Linux:

Tout comme sous Windows, `nuitka` est utilisé pour compiler les exécutables Linux. À l'origine, `pyinstaller` était utilisé, puis `Appimage`, mais nous avons opté pour `nuitka` en raison de la petite taille de l'exécutable.

Voici la commande de terminal pour compiler pour Linux en utilisant `nuitka` :

```shell
python -m nuitka --onefile --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages --linux-icon="src/GUI/images/p2mm-icon.ico"
```

### Notes:

- Si vous voulez forker le projet et faire vos propres versions, vous devez changer les variables en haut de `src/Scripts/Updater.py` avec vos propres informations et mettre à jour les valeurs dans `AppImageBuilder.yml` ainsi que les informations dans les commandes de compilation respectives, comme avec `nuitka`.

# Contributions

Portal 2: Multiplayer Mod version `2.3.0` sera notre version définitive, donc nous ne ferons pas de mises à jour significatives après sa sortie complète. Avant que cela n'arrive, nous travaillerons sur des commits dans la branche `dev` avant de mener à la version complète. Nous accepterons tout changement ou toute fonctionnalité substantielle pour P2:MM pendant cette période. Cependant, nous ne ferons pas beaucoup de travail après la sortie ni ne ferons de nouvelles versions en général. Les seules raisons pour lesquelles nous ferions une nouvelle version seraient lorsque quelqu'un contribue une nouvelle traduction, une amélioration d'une traduction actuelle, une autre correction de bug mineur que nous n'avons pas détectée, ou un fichier de support de carte pour une carte de l'atelier. Même après cette version finale, vous pouvez toujours faire un fork pour construire à partir de notre travail ! Veuillez vous assurer de donner crédit à ce dépôt !

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
