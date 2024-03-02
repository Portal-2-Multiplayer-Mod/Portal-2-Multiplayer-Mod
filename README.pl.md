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

# Instalacja i użytkowanie

**Przewodnik na Steamie dotyczący hostowania i dołączania do gry:**

- <https://steamcommunity.com/sharedfiles/filedetails/?id=2458260280>

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

Mamy je również w pliku dla łatwej instalacji `pip install -r requirements.txt`

## Kompilacja

Używamy `pyinstaller` i `AppImage` do tworzenia plików wykonywalnych!

### Windows:

W systemie Windows używamy tylko [pyinstaller] (https://pypi.org/project/pyinstaller/) do zbudowania pliku wykonywalnego (jeśli znasz lepsze opcje, powiedz nam).

```shell
pyinstaller "src/MainWindow.py" -F -i "src/GUI/images/p2mm64.ico" --noconsole --add-data "src/GUI;GUI" --add-data "src/Languages;Languages"
```

### Linux:

Dla systemu Linux przeszliśmy na korzystanie z [AppImage](https://appimage.org/) i stworzyliśmy narzędzie, które pomaga w tym procesie, wystarczy mieć zainstalowane `docker` i uruchomić `./tools/build-docker.sh`, będąc w głównym katalogu.

***OSTRZEŻENIE! Z jakiegoś powodu w niektórych dystrybucjach Linuksa FUSE nie jest domyślnie instalowany, co jest potrzebne zarówno do kompilacji, jak i uruchamiania AppImages. Informacje dotyczące instalacji FUSE w dystrybucji można znaleźć tutaj: [AppImageKit's Wiki](https://github.com/AppImage/AppImageKit/wiki/FUSE)***

Jeśli nie chcesz używać AppImage/Docker, nadal możesz używać pyinstaller:

```shell
pyinstaller "src/MainWindow.py" -F --add-data "src/GUI:GUI" --add-data "src/Languages:Languages"
```

### Uwaga:

- Jeśli chcesz skopiować projekt i wydawać własne wersje, musisz zmienić zmienne na górze pliku `src/Scripts/Updater.py` na własne informacje

# Współtwórcy

Portal 2: Multiplayer Mod w wersji `2.2.0` będzie naszą ostateczną wersją, więc nie będziemy wprowadzać żadnych znaczących aktualizacji po jej pełnym wydaniu. Zanim to nastąpi, będziemy pracować nad drobnymi aktualizacjami prowadzącymi do pełnej wersji. Zaakceptujemy wszelkie istotne zmiany lub funkcje dla P2:MM w tym okresie. Nie będziemy jednak akceptować żadnych bardziej znaczących zmian po wydaniu pełnej wersji. Jedynym powodem, dla którego moglibyśmy wydać nową wersję, byłoby dostarczenie przez kogoś nowego tłumaczenia, ulepszenia obecnego tłumaczenia, innej drobnej poprawki błędu, której nie wychwyciliśmy, lub pliku wsparcia dla mapy warsztatowej. Kolejną wersję wydamy tylko w takich okolicznościach i nie będziemy już akceptować niczego znaczącego w tym repozytorium. Wciąż jednak możesz je rozwidlić, by wykorzystać naszą pracę! Upewnij się, że podałeś nazwę tego repozytorium!

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
- Areng
