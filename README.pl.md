<h1>
  <img src="Images/p2mm_logo.png" alt="p2mm_logo" width="200" align="left">
  <a href="https://discord.gg/nXRygGNxyK">
    <img src="https://img.shields.io/discord/839651379034193920?color=blue&label=Discord%20Users&style=for-the-badge" alt="Discord Shield Badge" align="right">
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
    <a href="https://github.com/kyleraykbs/Portal2-32PlayerMod/releases/latest">
      <img src="https://img.shields.io/github/downloads/kyleraykbs/Portal2-32PlayerMod/total?style=for-the-badge" alt="Download Count Shield Badge" align="right">
    </a>
  <br>
  <p align="left">Portal 2: Multiplayer Mod</p>
</h1>

### Ten mod jest po stronie serwera. Tylko host serwera musi zainstalować tego moda. Gracze dołączający do hosta powinni mieć niezmodyfikowaną wersje Portala 2.
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
- Wsparcie z Discord API żeby łatwiej zapraszać graczy do gry (Nie jest pewne czy my to dodamy)
- Więcej wsparcia dla map z Warsztatu

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
- requests
- steamid-converter
- pyperclip

Mamy też je pliku dla łatwej instalacji `pip install -r requirements.txt`

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
- Na Linux, upewnij się że masz pakiet tkinter `pacman -S tk`
- Jeżeli chcesz zforkować projekt i zrobić swoje włąsne wydania, musisz zmienić dane na górze pliku `src/Scripts/Updater.py` 


# Kontrybucje

We are always happy to take whatever additional help we can get for this project. Specifically, we are in need of proficient coders in Squirrel or C++. If you think you can spare a hand, it will go a long way!
Zawsze jesteśmy gotowi żeby otrymać jakąkolwiek pomoc dla tego projektu. Potrzebujemy programistów biegłch w Squirrel lub C++. Jeżeli możesz nam pomóc to będziemy wdźięczni!

# Deweloperzy i kontrybutorzy

**Deweloperzy:**
- kyleraykbs
- Bumpy
- Nanoman2525
- vista
- Wolƒe Strider Shoσter
- cabiste
- Orsell

**Kontrybutorzy:**
- wanderer (free bird)
- MeblIkea
- Luukex
- PieCreeper
- Areng
