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

[English](README.md) | [Español](README.es.md) | **_Polish_** | [简体中文](README.zh-CN.md) | [繁體中文](README.zh-TW.md) | [Italiano](README.it.md) | [Français](README.fr.md) | [Português (Brasil)](README.pt_BR.md) | [Русский](README.ru.md) 

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

Używamy [`nuitka`](https://nuitka.net/) do kompilowania Launchera Portal 2: Multiplayer Mod. Oprócz tego używamy GitHub Actions do naszych plików wykonywalnych wersji. [`pyinstaller`](https://pypi.org/project/pyinstaller/) i [`AppImage`](https://appimage.org/) były pierwotnie używane, ale zostały wycofane na rzecz `nuitka`.

### Windows

Dla Windows używamy `nuitka` do tworzenia naszych plików `.exe`. Chociaż kompiluje się wolniej niż `pyinstaller`, który był używany we wcześniejszych wersjach, zapewnia mniejszy rozmiar pliku wykonywalnego. `nuitka` można zainstalować za pomocą `pip`.

Poniżej znajduje się pełne polecenie terminala, którego używamy w plikach wykonywalnych wersji, jest ono nieco inne niż to, które używa GitHub Actions, a poniżej znajduje się uproszczona wersja bez informacji o wersji i podobnych:

```shell
python -m nuitka --onefile --windows-console-mode=disable --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages"  --windows-icon-from-ico="src/GUI/images/p2mm-icon.ico" --product-name="Portal 2: Multiplayer Mod Launcher" --file-description="The launcher for P2:MM." --product-version="INSERT VERSION HERE" --file-version="INSERT VERSION HERE" --copyright='© 2024 Portal 2: Multiplayer Mod Team' "src/MainWindow.py"
```

```shell
python -m nuitka --onefile --windows-console-mode=disable --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages"  --windows-icon-from-ico="src/GUI/images/p2mm-icon.ico" "src/MainWindow.py"
```

### Linux

Tak jak w systemie Windows, do kompilowania plików wykonywalnych Linuxa używamy `nuitka`. Początkowo używano `pyinstallera`, później `Appimage`, ale ostatecznie zdecydowano się na `nuitka` ze względu na mały rozmiar pliku wykonywalnego.

Poniżej znajduje się polecenie terminala do kompilacji dla Linuxa przy użyciu `nuitka`:

```shell
python -m nuitka --onefile --noinclude-data-files="pygame/freesansbold.ttf" --include-data-dir="src/GUI"="GUI" --include-data-dir="src/Languages"="Languages" --linux-icon="src/GUI/images/p2mm-icon.ico" "src/MainWindow.py"
```

### Uwaga

- Jeśli chcesz sklonować projekt i tworzyć własne wydania, musisz zmienić zmienne na początku pliku `src/Scripts/Updater.py` na swoje własne informacje oraz zaktualizować wartości w `AppImageBuilder.yml`, a także informacje w odpowiednich poleceniach kompilacji, takich jak `nuitka`.

# Współtwórcy

Portal 2: Multiplayer Mod wersja `2.3.0` będzie naszą wersją ostateczną, więc nie będziemy robić żadnych znaczących aktualizacji po jej pełnym wydaniu. Zanim to nastąpi, będziemy pracować nad commitami w gałęzi `dev` przed doprowadzeniem do pełnej wersji. Będziemy akceptować wszelkie istotne zmiany lub funkcje dla P2:MM w tym okresie. Jednak po wydaniu nie będziemy robić wiele pracy ani wydawać żadnych nowych wersji ogólnie. Jedynymi powodami, dla których moglibyśmy wydać nową wersję, będą nowe tłumaczenia, ulepszenie obecnego tłumaczenia, inne drobne poprawki błędów, których nie zauważyliśmy, lub plik wsparcia mapy dla mapy warsztatowej. Nawet po tym ostatecznym wydaniu, nadal możesz zrobić fork, aby budować na podstawie naszej pracy! Upewnij się, że przyznajesz kredyt temu repozytorium!

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
