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

### Ten mod działa w pełni po stronie serwera. Tylko operator serwera musi uruchomić Portal 2 z zainstalowanym modem. Osoby dołączające do hosta powinny uruchomić standardową wersję Portal 2.

## Języki

[English](README.md) | [Español](README.es.md) | **_Polish_** | [简体中文](README.zh-CN.md) | [繁體中文](README.zh-TW.md) | [Italiano](README.it.md) | [Français] (README.fr.md)

# Funkcje moda

```
  - Maksymalna liczba graczy wynosząca 33
  - Etykiety z nazwami
  - Dostosowywanie kolorów graczy
  - Komendy czatu (!pomoc)
  - System administratora w grze
  - Pełne wsparcie dla trybu kooperacji
  - Pełne wsparcie dla trybu dla pojedynczego gracza (wymaga drobnych poprawek)
  - Pełne wsparcie dla mapy Super 8
  - Wewnętrzne wsparcie dla wybranych map warsztatowych
  - Szyfrowanie poleceń klienta wywoływanych przez aktywną klasę GameRules
  - Wsparcie dla systemów Linux, Windows 7 i nowszych
  - Możliwość włączania/wyłączania opcji gry i konfiguracji poprzez VScript oraz wtyczkę niestandardową
  - Wsparcie dla SAR (SourceAutoRecord) do speedrunów
```

# Instalacja i użytkowanie

**Przewodnik na Steamie dotyczący hostowania i dołączania do gry:**

- <https://steamcommunity.com/sharedfiles/filedetails/?id=2458260280>

**Najnowsza wersja:**

- <https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/releases/latest>

**Serwer Discord dla pomocy technicznej (UPRAWNIJ SIĘ DO CZYTANIA FAQ!!!), zgłaszania błędów lub po prostu rozmów:**

- <https://discord.gg/kW3nG6GKpF>


# Kompilacja

*Używamy Pythona 3.10 do uruchamiania*

**Zależności**
- pygame
- pyperclip
- requests
- steamid-converter

Mamy je również w pliku dla łatwej instalacji `pip install -r requirements.txt`

**Kompilacja**

We use `pyinstaller` and `AppImage` to make the executables!

### Windows:

For windows we only use [pyinstaller](https://pypi.org/project/pyinstaller/) to build the executable (if you know of better options please tell us)

```shell
pyinstaller "src/MainWindow.py" -F -i "src/GUI/images/p2mm64.ico" --noconsole --add-data "src/GUI;GUI" --add-data "src/ModFiles;ModFiles" --add-data "src/Languages;Languages"
```

### Linux:

For Linux We switched to using [AppImage](https://appimage.org/) and we made a tool to help with that, simply have docker installed and run `tools/build-docker.sh`.

But if you don't want to use AppImage / docker, you can still use pyinstaller like below:

```shell
pyinstaller "src/MainWindow.py" -F --add-data "src/GUI:GUI" --add-data "src/ModFiles:ModFiles" --add-data "src/Languages:Languages"
```

### Uwaga:

- Jeśli chcesz skopiować projekt i wydawać własne wersje, musisz zmienić zmienne na górze pliku `src/Scripts/Updater.py` na własne informacje


# Współtwórcy

Zawsze jesteśmy zadowoleni z każdej dodatkowej pomocy, którą możemy otrzymać w ramach tego projektu. Szczególnie poszukujemy biegłych programistów w języku Squirrel lub C++. Jeśli uważasz, że możesz pomóc, będzie to ogromna wartość!

# Autorzy

**Programiści:**

- kyleraykbs
- Bumpy
- Nanoman2525
- vista
- Wolƒe Strider Shoσter
- cabiste
- Orsell

**Współpracownicy:**

- wanderer (free bird)
- \n
- Luukex
- MeblIkea
- Luukex
- PieCreeper
- Areng