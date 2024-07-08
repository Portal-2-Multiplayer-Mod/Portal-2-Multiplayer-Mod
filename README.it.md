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

Usiamo [`nuitka`](https://nuitka.net/) per compilare il Launcher di Portal 2: Multiplayer Mod. Insieme a questo, usiamo GitHub Actions per i nostri eseguibili di rilascio. [`pyinstaller`](https://pypi.org/project/pyinstaller/) e [`AppImage`](https://appimage.org/) erano originariamente utilizzati ma sono stati deprecati a favore di `nuitka`.

### Windows

Per Windows usiamo `nuitka` per creare i nostri file `.exe`. Sebbene sia più lento da compilare rispetto a `pyinstaller` che veniva utilizzato nelle versioni precedenti, fornisce una dimensione dell'eseguibile più piccola. `nuitka` può essere installato usando `pip`.

Di seguito è riportato il comando di terminale completo che utilizziamo negli eseguibili di rilascio, è leggermente diverso da quello utilizzato da GitHub Actions, e di seguito una versione ridotta senza informazioni sulla versione e simili:

```shell
python -m nuitka --onefile --windows-console-mode=disable --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages"  --windows-icon-from-ico="src/GUI/images/p2mm-icon.ico" --product-name="Portal 2: Multiplayer Mod Launcher" --file-description="The launcher for P2:MM." --product-version="INSERT VERSION HERE" --file-version="INSERT VERSION HERE" --copyright='© 2024 Portal 2: Multiplayer Mod Team' "src/MainWindow.py"
```

```shell
python -m nuitka --onefile --windows-console-mode=disable --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages"  --windows-icon-from-ico="src/GUI/images/p2mm-icon.ico" "src/MainWindow.py"
```

### Linux

Proprio come su Windows, `nuitka` è utilizzato per compilare gli eseguibili Linux. Originariamente si utilizzava `pyinstaller`, poi `Appimage`, ma si è scelto `nuitka` per le dimensioni ridotte dell'eseguibile.

Di seguito il comando di terminale per compilare per Linux usando `nuitka`:

```shell
python -m nuitka --onefile --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages" --linux-icon="src/GUI/images/p2mm-icon.ico" "src/MainWindow.py"
```

### Appunti

- Se vuoi fare il fork del progetto e rilasciare le tue versioni, devi cambiare le variabili nella parte superiore di `src/Scripts/Updater.py` con le tue informazioni e aggiornare i valori in `AppImageBuilder.yml` così come le informazioni nei rispettivi comandi di compilazione, come con `nuitka`.

# P2:MM Plugin

Il Mod Multigiocatore di Portal 2 utilizza un plugin separato del server Source Engine per agganciarsi a Portal 2 e patchare il gioco, consentendo a determinati sistemi di funzionare in modi che normalmente VScript non può fare. Il plugin è stato inserito in un repository separato a causa della natura dello sviluppo e dell'ambiente di compilazione dei plugin di Source Engine. Puoi trovare il suo codice sorgente qui: <https://github.com/OrsellGaming/Portal-2-Multiplayer-Mod-Plugin>

# Contributions

Portal 2: Multiplayer Mod versione `2.3.0` sarà la nostra versione definitiva, quindi non faremo aggiornamenti significativi dopo il rilascio completo. Prima che ciò accada, lavoreremo sui commit nel ramo `dev` prima di arrivare alla versione completa. Accetteremo qualsiasi cambiamento o funzionalità sostanziale per P2:MM durante questo periodo. Tuttavia, non faremo molto lavoro dopo il rilascio né faremo nuove versioni in generale. Le uniche ragioni per cui faremmo una nuova versione sarebbero quando qualcuno contribuisce con una nuova traduzione, un miglioramento di una traduzione attuale, un'altra correzione di bug minore che non abbiamo individuato, o un file di supporto mappa per una mappa di workshop. Anche dopo questa versione finale, puoi ancora fare un fork per costruire sul nostro lavoro! Assicurati di dare credito a questo repository!

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
