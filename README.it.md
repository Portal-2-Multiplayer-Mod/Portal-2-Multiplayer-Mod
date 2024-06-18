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

### Questa mod è completamente lato server. Solo l'host deve eseguire Portal 2 con la mod installata. Le persone che si uniscono all'host devono eseguire Portal 2 senza alcuna modifica.

## Lingue

[English](README.md) | [Español](README.es.md) | [Polish](README.pl.md) | [简体中文](README.zh-CN.md) | [繁體中文](README.zh-TW.md) | **_Italiano_** | [Français](README.fr.md) | [Português (Brasil)](README.pt_BR.md)

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
  - Supporto per Linux, Windows 10 e versioni successive
  - Opzioni di gioco attivabili e sistema di configurazione esposti tramite VScript e un plug-in personalizzato
  - Supporto per SAR (SourceAutoRecord) per lo speedrunning
```

# Installazione e Utilizzo

**Guide nel Wiki su come configurare P2:MM:**

- <https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/wiki>

**Scarica la versione più recente:**

- <https://github.com/Portal-2-Multiplayer-Mod/Portal2-Multiplayer-Mod/releases/latest>

**Discord Server per supporto tecnico (ASSICURATI DI LEGGERE LE DOMANDE FREQUENTI!!!), segnalazione di bug o semplicemente per chattare:**

- <https://discord.gg/kW3nG6GKpF>

# Costruzione del Lanciatore

## Dipendenze

- Python 3.10
- pygame
- requests
- steamid-converter

Li abbiamo anche in un unico file per una facile installazione: `pip install -r requirements.txt`

## Compilazione

Usiamo [`nuitka`](https://nuitka.net/), [`pyinstaller`](https://pypi.org/project/pyinstaller/), e [`AppImage`](https://appimage.org/) per creare gli eseguibili.

### Windows:

Per Windows usiamo `nuitka` per creare i nostri file `.exe`. Sebbene sia più lento da compilare rispetto a `pyinstaller` utilizzato nelle versioni precedenti, fornisce una dimensione dell'eseguibile più piccola e non fa scattare Windows Defender. `pyinstaller` dovrebbe essere utilizzato solo come backup se `nuitka` non funziona per qualche motivo. Entrambi possono essere installati usando `pip install`.

Di seguito è riportato il comando completo del terminale che utilizziamo per compilare il launcher, e di seguito una versione semplificata senza informazioni di versione e altri dettagli:

```shell
python -m nuitka --onefile --windows-console-mode=disable --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages"  --windows-icon-from-ico="src/GUI/images/p2mm-icon.ico" --product-name="Portal 2: Multiplayer Mod Launcher" --file-description="The launcher for P2:MM." --product-version="INSERT VERSION HERE" --file-version="INSERT VERSION HERE" --copyright='© 2024 Portal 2: Multiplayer Mod Team' "src/MainWindow.py"
```

```shell
python -m nuitka --onefile --windows-console-mode=disable --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages"  --windows-icon-from-ico="src/GUI/images/p2mm-icon.ico" "src/MainWindow.py"
```

Di seguito è riportato il comando di terminal per compilare utilizzando `pyinstaller`:

```shell
pyinstaller "src/MainWindow.py" -F -i "src/GUI/images/p2mm-icon.ico" --noconsole --add-data "src/GUI;GUI" --add-data "src/Languages;Languages"
```

### Linux:

Per Linux abbiamo iniziato a utilizzare `AppImage` e abbiamo creato uno strumento per aiutare con questo, basta avere `docker` installato ed eseguire `./tools/build-docker.sh` mentre ci si trova nella directory principale.

_**ATTENZIONE! Per qualche motivo, su alcune distribuzioni Linux, FUSE non è installato di default, il che è necessario sia per compilare che per eseguire AppImages. Le informazioni per installare FUSE sulla tua distribuzione possono essere trovate qui: [Wiki di AppImageKit](https://github.com/AppImage/AppImageKit/wiki/FUSE)**_

Se non vuoi usare `AppImage/docker`, puoi comunque usare `pyinstaller`:

```shell
pyinstaller "src/MainWindow.py" -F --add-data "src/GUI:GUI" --add-data "src/Languages:Languages"
```

### Appunti:

- Se vuoi fare il fork del progetto e rilasciare le tue versioni, devi cambiare le variabili nella parte superiore di `src/Scripts/Updater.py` con le tue informazioni e aggiornare i valori in `AppImageBuilder.yml` così come le informazioni nei rispettivi comandi di compilazione, come con `nuitka`.

# Contributions

Portal 2: Multiplayer Mod versione `2.3.0` sarà la nostra versione definitiva, quindi non faremo aggiornamenti significativi dopo il suo rilascio completo. Prima che ciò accada, lavoreremo su aggiornamenti minori che porteranno alla versione completa. Accetteremo qualsiasi modifica o funzionalità sostanziale per P2:MM durante questo periodo. Tuttavia, non faremo molto lavoro dopo il rilascio né faremo nuovi rilasci in generale. Le uniche ragioni per cui faremmo un nuovo rilascio sarebbero quando qualcuno contribuisce con una nuova traduzione, un miglioramento di una traduzione attuale, qualche altra correzione di bug minore che non abbiamo rilevato, o un file di supporto mappa per una mappa workshop. Anche dopo questo rilascio finale, puoi comunque fare un fork per costruire sul nostro lavoro! Assicurati di dare credito a questo repository!

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
