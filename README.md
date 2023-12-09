<h1>
  <img src="https://cdn.discordapp.com/attachments/1073818580539424882/1073869966543179806/P2MMBannerREADME.png" alt="p2mmbanner_logo" width="500" height="300" align="left">
  <a href="https://discord.gg/nXRygGNxyK">
    <img src="https://img.shields.io/discord/839651379034193920?color=blue&label=Discord%20Users&style=for-the-badge&logo=discord&logoWidth=20" alt="Discord Shield Badge" align="right">
  </a>
  <br>
  <a href="https://github.com/kyleraykbs/Portal2-32PlayerMod/releases/latest">
    <img src="https://img.shields.io/github/release-date/kyleraykbs/Portal2-32PlayerMod?color=red&label=Latest%20Release&style=for-the-badge" alt="Release Shield Badge" align="right">
  </a>
  <br>
  <a href="https://github.com/kyleraykbs/Portal2-32PlayerMod/commits/main">
    <img src="https://img.shields.io/github/last-commit/kyleraykbs/Portal2-32PlayerMod?label=Last%20Commit&style=for-the-badge" alt="Commit Shield Badge" align="right">
  </a>
  <br>
    <a href="https://github.com/kyleraykbs/Portal2-32PlayerMod/releases/latest"><img src="https://img.shields.io/github/downloads/kyleraykbs/Portal2-32PlayerMod/total?style=for-the-badge" alt="Download Count Shield Badge" align="right">
  </a>
  <br>
  <br>
  <br>
  <p align="right">PORTAL 2: MULTIPLAYER MOD</p>
</h1>

***
DISCLAIMER!!!

Attualmente sia `main` che `dev` sono incasinati!
Se desideri contribuire, utilizza invece il ramo `finalcleanup` poiché ha un codice più pulito e più stabile.
Si prega inoltre di fare riferimento alle informazioni contenute nel README dei rami in quanto sono più aggiornati e sono anche in altre lingue.
***

### Questa mod è completamente lato server. Solo l'operatore del server deve eseguire Portal 2 con la mod installata. Le persone che si uniscono all'host devono eseguire Portal 2 senza alcuna modifica.
## Funzionalità della modalità
```
  - Un limite massimo di giocatori di 33
  - Targhette
  - Colori del lettore personalizzato
  - Comandi di chat (!help)
  - Comandi di amministrazione
  - Pieno supporto alla campagna cooperativa
  - Supporto completo per la campagna per giocatore singolo (richiede un piccolo miglioramento)
  - Pieno supporto per la mappa Super 8 Teaser
  - Supporto per alcune mappe selezionate di Steam Workshop
  - Crittografia dei comandi client richiamati tramite la classe GameRules attiva
  - Supporto per Linux, Windows 7 e versioni successive
  - Opzioni di gioco attivabili e sistema di configurazione esposti tramite VScript e un plug-in personalizzato
  - Supporto per SAR (SourceAutoRecord) per lo speedrunning
  - Supporto nativo per server dedicati se riesci a farne funzionare uno :)
```

## Funzionalità da aggiungere
- Supporto per Steam Deck/SteamOS 3.0
- API Discord per inviti facili
- Maggiore supporto per le mappe delle officine
- Supporto per FastDL

# Installazione e utilizzo

**Guida di Steam su come ospitare e partecipare a un gioco:**
- https://steamcommunity.com/sharedfiles/filedetails/?id=2458260280

**Ultima versione:**
- https://github.com/kyleraykbs/Portal2-32PlayerMod/releases/latest

**Discord Server per supporto tecnico (ASSICURATI DI LEGGERE LE DOMANDE FREQUENTI!!!), segnalazione di bug o semplicemente per chattare:**
- https://discord.gg/kW3nG6GKpF


# Costruire

*Usiamo Python 3.10 per il launcher*

**Dipendenzes**
- pygame
- pyperclip
- requests
- steamid-converter

Li abbiamo anche in un file per una facile installazione `pip install -r requirements.txt`

**Compilazione**

Usiamo `pyinstaller` per rendere l'eseguibile
- Windows:

```
pyinstaller "src/MainWindow.py" -F -i "src/GUI/assets/images/p2mm64.ico" --noconsole --add-data "src/GUI;GUI" --add-data "src/ModFiles;ModFiles" --add-data "src/languages;languages"
```

- Linux:

```
pyinstaller "src/MainWindow.py" -F --add-data "src/GUI:GUI" --add-data "src/ModFiles:ModFiles" --add-data "src/languages:languages"
```

*Nota:*  
- Se vuoi creare un fork del progetto ed eseguire le tue versioni, devi modificare le variabili nella parte superiore di `src/Scripts/Updater.py` con le tue informazioni


# Contributi

Siamo sempre felici di ricevere tutto l'aiuto aggiuntivo che possiamo ottenere per questo progetto. Nello specifico, abbiamo bisogno di programmatori esperti in Squirrel o C++. Se pensi di poter risparmiare una mano, farà molta strada!

# Crediti

**Sviluppatori/Sviluppatrici::**
- kyleraykbs
- Bumpy
- Nanoman2525
- vista
- Wolƒe Strider Shoσter
- cabiste
- zwexit (Orsell) 

**Contributrici/Contributori:**
- wanderer (free bird)
- \n
- Luukex
- MeblIkea
- Luukex
- PieCreeper
- Areng
