<h1>
  <img src="https://github.com/Portal-2-Multiplayer-Mod/P2MM-ART/blob/e56d8c209eb3f143bb0607dc1e59730e517ecca6/Banners/P2MMBannerREADME.png?raw=true" alt="P2MMBannerREADME" width="500" height="290" align="left">
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
  <a href="https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/commits/finalcleanup">
      <img src="https://img.shields.io/github/last-commit/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/finalcleanup?style=for-the-badge&label=LAST%20COMMIT%20(FINALCLEANUP)&color=%2334a5eb"
              alt="GitHub last commit (branch)" align="right">
  </a>
  <br>
  <p align="right">PORTAL 2:</p>
  <p align="right">MULTIPLAYER MOD</p>
</h1>

### Questa mod è completamente lato server. Solo l'host deve eseguire Portal 2 con la mod installata. Le persone che si uniscono all'host devono eseguire Portal 2 senza alcuna modifica.

## Lingue

[English](README.md) | [Español](README.es.md) | [Polish](README.pl.md) | [简体中文](README.zh-CN.md) | [繁體中文](README.zh-TW.md) | **_Italiano_** | [Français](README.fr.md)

## Caratteristiche P2MM

```
  - Un limite massimo di giocatori di 33
  - Targhette con nome
  - Colori del giocatore personalizzati
  - Comandi di chat (!help)
  - Sistema amministratore integrato
  - Pieno sostegno alla campagna cooperativa
  - Supporto completo per la campagna per giocatore singolo (richiede un piccolo miglioramento)
  - Pieno supporto per la mappa teaser Super 8
  - Supporto per mappe selezionate di Steam Workshop
  - Crittografia dei comandi client richiamati tramite la classe GameRules attiva
  - Supporto per Linux, Windows 7 e versioni successive
  - Opzioni di gioco attivabili e sistema di configurazione esposti tramite VScript e un plug-in personalizzato
  - Supporto per SAR (SourceAutoRecord) per lo speedrunning
```

# Installazione e utilizzo

**Guida di Steam su come ospitare e partecipare a un gioco:**

- <https://steamcommunity.com/sharedfiles/filedetails/?id=2458260280>

**Scarica la versione più recente:**

- <https://github.com/Portal-2-Multiplayer-Mod/Portal2-Multiplayer-Mod/releases/latest>

**Discord Server per supporto tecnico (ASSICURATI DI LEGGERE LE DOMANDE FREQUENTI!!!), segnalazione di bug o semplicemente per chattare:**

- <https://discord.gg/kW3nG6GKpF>

# Costruzione del Lanciatore

## Dipendenze

- Python 3.10
- pygame
- pyperclip
- requests
- steamid-converter

Li abbiamo anche in un unico file per una facile installazione; `pip install -r requirements.txt`

## Compilazione

Usiamo `pyinstaller` e `AppImage` per creare gli eseguibili!

### Windows:

FPer Windows utilizziamo solo [pyinstaller](https://pypi.org/project/pyinstaller/) per creare l'eseguibile (se conosci opzioni migliori, faccelo sapere).

```shell
pyinstaller "src/MainWindow.py" -F -i "src/GUI/images/p2mm64.ico" --noconsole --add-data "src/GUI;GUI" --add-data "src/ModFiles;ModFiles" --add-data "src/Languages;Languages"
```

### Linux:

Per Linux abbiamo fatto il passaggio a utilizzare [AppImage](https://appimage.org/) e abbiamo creato uno strumento per aiutare con ciò, basta avere `docker` installato ed eseguire `./tools/build-docker.sh` mentre ci si trova nella directory principale.

***AVVISO! Per qualche motivo su alcune distribuzioni Linux, FUSE non è installato di default, il che è necessario sia per la compilazione che per l'esecuzione di AppImages. Le informazioni per l'installazione di FUSE sulla tua distribuzione sono disponibili qui: [Wiki di AppImageKit](https://github.com/AppImage/AppImageKit/wiki/FUSE)***

Se non vuoi usare AppImage/Docker, puoi comunque usare pyinstaller:

```shell
pyinstaller "src/MainWindow.py" -F --add-data "src/GUI:GUI" --add-data "src/ModFiles:ModFiles" --add-data "src/Languages:Languages"
```

### Appunti:

- Se vuoi creare un fork del progetto ed eseguire le tue versioni, devi modificare le variabili nella parte superiore di `src/Scripts/Updater.py` con le tue informazioni e aggiornare i valori in `AppImageBuilder.yml`

# Contributions

A partire dalla versione 2.2.0, saranno accettate solo correzioni di bug, problemi che influiscono sull'uso del launcher e/o durante l'esecuzione della mod in Portal 2 e traduzioni per il launcher. Qualsiasi modifica importante verrà rifiutata poiché stiamo cercando di riscrivere la versione 3.0 invece di continuare a lavorare sulla serie 2.0. Tuttavia, siete i benvenuti se ci aiutate con il [3.0 rewrite repository](https://github.com/Portal-2-Multiplayer-Mod/P2MM-Entanglement)! Lì abbiamo bisogno di programmatori in Python e C++.

# Crediti

**Sviluppatori/Sviluppatrici:**

- kyleraykbs
- Bumpy
- Nanoman2525
- vista
- Wolƒe Strider Shoσter
- cabiste
- Orsell

**Contributori:/Contributrici:**

- wanderer (free bird)
- \n
- Luukex
- MeblIkea
- PieCreeper
- Areng
