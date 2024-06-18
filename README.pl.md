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

### Ten mod działa w pełni po stronie serwera. Tylko operator serwera musi uruchomić Portal 2 z zainstalowanym modem. Osoby dołączające do hosta powinny uruchomić standardową wersję Portal 2.

## Języki

[English](README.md) | [Español](README.es.md) | **_Polish_** | [简体中文](README.zh-CN.md) | [繁體中文](README.zh-TW.md) | [Italiano](README.it.md) | [Français](README.fr.md) | [Português (Brasil)](README.pt_BR.md)

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
  - Wsparcie dla systemów Linux, Windows 10 i nowszych
  - Możliwość włączania/wyłączania opcji gry i konfiguracji poprzez VScript oraz wtyczkę niestandardową
  - Wsparcie dla SAR (SourceAutoRecord) do speedrunów
```

# Instalacja i Użycie

**Przewodniki na Wiki dotyczące konfiguracji P2:MM:**

- <https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/wiki>

**Najnowsza wersja:**

- <https://github.com/Portal-2-Multiplayer-Mod/Portal-2-Multiplayer-Mod/releases/latest>

**Serwer Discord dla pomocy technicznej (UPRAWNIJ SIĘ DO CZYTANIA FAQ!!!), zgłaszania błędów lub po prostu rozmów:**

- <https://discord.gg/kW3nG6GKpF>

# Budowanie Uruchamiacza

## Zależności

- Pythona 3.10
- pygame
- requests
- steamid-converter

Mamy je również w pliku dla łatwej instalacji: `pip install -r requirements.txt`

## Kompilacja

Używamy [`nuitka`](https://nuitka.net/), [`pyinstaller`](https://pypi.org/project/pyinstaller/), i [`AppImage`](https://appimage.org/) do tworzenia plików wykonywalnych.

### Windows:

Dla systemu Windows używamy `nuitka` do tworzenia naszych plików `.exe`. Chociaż kompilacja jest wolniejsza niż w przypadku `pyinstaller`, który był używany we wcześniejszych kompilacjach, zapewnia mniejszy rozmiar pliku wykonywalnego i nie uruchamia Windows Defender. `pyinstaller` powinien być używany tylko jako zapas, jeśli `nuitka` nie działa z jakiegoś powodu. Oba można zainstalować za pomocą `pip install`.

Poniżej znajduje się pełne polecenie terminala, którego używamy do kompilacji launchera, a poniżej znajduje się uproszczona wersja bez informacji o wersji i innych szczegółów:

```shell
python -m nuitka --onefile --windows-console-mode=disable --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages"  --windows-icon-from-ico="src/GUI/images/p2mm-icon.ico" --product-name="Portal 2: Multiplayer Mod Launcher" --file-description="The launcher for P2:MM." --product-version="INSERT VERSION HERE" --file-version="INSERT VERSION HERE" --copyright='© 2024 Portal 2: Multiplayer Mod Team' "src/MainWindow.py"
```

```shell
python -m nuitka --onefile --windows-console-mode=disable --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages"  --windows-icon-from-ico="src/GUI/images/p2mm-icon.ico" "src/MainWindow.py"
```

Poniżej znajduje się polecenie terminala do kompilacji przy użyciu `pyinstaller`:

```shell
pyinstaller "src/MainWindow.py" -F -i "src/GUI/images/p2mm-icon.ico" --noconsole --add-data "src/GUI;GUI" --add-data "src/Languages;Languages"
```

### Linux:

Dla systemu Linux przeszliśmy na używanie `AppImage` i stworzyliśmy narzędzie do pomocy w tym, wystarczy mieć zainstalowany `docker` i uruchomić `./tools/build-docker.sh` będąc w głównym katalogu.

_**UWAGA! Z jakiegoś powodu na niektórych dystrybucjach Linuxa, FUSE nie jest zainstalowany domyślnie, co jest potrzebne zarówno do kompilacji, jak i uruchamiania plików AppImage. Informacje o instalacji FUSE na twojej dystrybucji można znaleźć tutaj: [Wiki AppImageKit](https://github.com/AppImage/AppImageKit/wiki/FUSE)**_

Jeśli nie chcesz używać `AppImage/docker`, nadal możesz używać `pyinstaller`:

```shell
pyinstaller "src/MainWindow.py" -F --add-data "src/GUI:GUI" --add-data "src/Languages:Languages"
```

### Uwaga:

- Jeśli chcesz sklonować projekt i tworzyć własne wydania, musisz zmienić zmienne na początku pliku `src/Scripts/Updater.py` na swoje własne informacje oraz zaktualizować wartości w `AppImageBuilder.yml`, a także informacje w odpowiednich poleceniach kompilacji, takich jak `nuitka`.

# Współtwórcy

Portal 2: Multiplayer Mod wersja `2.3.0` będzie naszą ostateczną wersją, więc nie będziemy wprowadzać żadnych znaczących aktualizacji po jej pełnym wydaniu. Zanim to nastąpi, będziemy pracować nad drobnymi aktualizacjami prowadzącymi do pełnej wersji. Przyjmiemy wszelkie istotne zmiany lub funkcje dla P2:MM w tym okresie. Jednak po wydaniu nie będziemy wykonywać dużo pracy ani wprowadzać nowych wydań ogólnie. Jedynymi powodami, dla których moglibyśmy wydać nowe wydanie, byłyby, gdyby ktoś przyczynił się nowym tłumaczeniem, ulepszeniem obecnego tłumaczenia, jakąś inną drobną poprawką, której nie zauważyliśmy, lub plikiem wsparcia mapy dla mapy warsztatowej. Nawet po tym ostatecznym wydaniu, nadal możesz forkać, aby rozwijać naszą pracę! Upewnij się, że podajesz kredyt dla tego repozytorium!

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
- PieCreeper
