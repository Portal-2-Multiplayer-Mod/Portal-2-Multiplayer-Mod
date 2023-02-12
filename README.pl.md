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

### Ten mod jest w całości po stronie serwera. Tylko host serwera musi zainstalować tego moda. Gracze dołączający do hosta powinni mieć niezmodyfikowaną wersje Portala 2.

### Dziękujemy Krzyhau'owi za pożyczenie części kodu z Speedrun Mod

## Języki
English | [Español](README.es.md) | [Polski](README.pl.md) | [简体中文](README.zh-CN.md) | [繁體中文](README.zh-TW.md)

## Funkcje moda
```
   -Limit 33 graczy
  - Nametagi nazw graczy
  - Kolory dla graczy
  - Komendy Czatowe (!help)
  - System Admin wbudowany w grze
  - Pełne wsparcie na kampanie kooperacyjną
  - Pełne wsparcie na kampanie jednoosobową (potrzebuje małych dopracowań)
  - Pełne wspacie na mape Super 8
  - Pełne wsparcie na niektóre popularne mapy z Warsztatu
  - Encryption of client commands invoked through the active GameRules class (This mod is safe to use)
  - Szyfrowanie komend klienta przez aktywną klase GameRules (Ten mod jest bezpieczny w użyciu)
  - Wsparcie na Linux i Windows (7+)
  - togglable game options and config system exposed through VScript and a plugin (Not SourceAutoRecord)
  - przełączalne ustawienia gry i system konfiguracji ujawiony dzięki VScript i plugin (Nie SourceAutoRecord)
  - Natywne wsparcie dla zdedykowanych serwerów jeżeli ci się uda ci się je ustawić :)
```

## Funkcje do dodania
- Wparcie na Steam Deck/SteamOS 3.0
- Wsparcie z Discord API żeby łatwiej zapraszać graczy do gry
- Więcej wsparcia dla map z Warsztatu
- Wsparcie dla FastDL

# Instalacja i użycie

**Poradnik na Steam o instalacji i użyciu moda:**
- https://steamcommunity.com/sharedfiles/filedetails/?id=2458260280

**Najnowsza wersja:**
- https://github.com/kyleraykbs/Portal2-32PlayerMod/releases/latest

**Serwer na Discord dla pomocy technicznej, zgłoszeń błedów lub dla rozmów:**
- https://discord.gg/kW3nG6GKpF


# Zbudowanie z źródła

*Korzystamy z Python 3.10 dla launchera*

**Zależnośći**
- pygame
- pyperclip
- requests
- steamid-converter

Mamy je też w pliku dla łatwej instalacji `pip install -r requirements.txt`

**Kompilacja**

Korzystamy z `pyinstaller` żeby skompilować moda
- Windows:

```
pyinstaller "src/MainWindow.py" -F -i "src/GUI/assets/images/p2mm64.ico" --noconsole --add-data "src/GUI;GUI" --add-data "src/FALLBACK;FALLBACK" --add-data "src/languages;languages"
```

- Linux:

```
pyinstaller "src/MainWindow.py" -F --add-data "src/GUI:GUI" --add-data "src/FALLBACK:FALLBACK" --add-data "src/languages:languages"
```

*Notatki:*  
- Jeżeli chcesz zforkować projekt i zrobić swoje włąsne wydania, musisz zmienić dane na górze pliku `src/Scripts/Updater.py` 


# Kontrybucje

Zawsze jesteśmy gotowi żeby otrymać jakąkolwiek pomoc dla tego projektu. Potrzebujemy programistów biegłch w Squirrel lub C++. Jeżeli możesz nam pomóc to będziemy wdźięczni!

# Deweloperzy i kontrybutorzy

**Deweloperzy:**
- kyleraykbs
- Bumpy
- Nanoman2525
- vista
- Wolƒe Strider Shoσter
- cabiste
- zwexit (Orsell)

**Kontrybutorzy:**
- wanderer (free bird)
- \n
- Luukex
- MeblIkea
- Luukex
- PieCreeper
- Areng
- Krzyhau