# Created by ***kyleraykbs, Nanoman2525, Vista, Bumpy, & Wolƒe Strider Shoσter***
**Big thanks to our team members: ***Cabiste, sear, & Jeffrey*****

<u>**Note: This mod is completely server-side. Only the host needs to run Portal 2 with the mod installed. People who join the host should run stock Portal 2.**</u>


## Planned features (Will be shipped in v2.0)
-   [ ] Full singleplayer campaign support (Almost finished, needs a lot more polishing)
-   [x] Nametags
-   [x] Support for Linux
-   [ ] Full support for the cooperative Gelocity workshop maps (Two of the three maps are finished)
-   [x] Chat commands
-   [x] Allow players to spawn in any map without breaking
-   [x] Make the launcher patch files on the spot for consistency and stability
-   [x] Allow the server to cache objects server-side without crashing
-   [x] OTA updates
-   [X] Encryption of game-breaking cvars to random characters on each game launch

## Features on the table
- Dedicated servers
- Sixense support
- Player specific colored portals

# Installation & use

- Latest version released: https://github.com/kyleraykbs/Portal2-32PlayerMod-Lite/releases/latest

- Steam guide: https://steamcommunity.com/sharedfiles/filedetails/?id=2458260280
  - ***The Steam guide goes over everything you need to know in order to get the mod working, but just in case, we have also prepared supplementary videos if you get stuck.***

# How to Build the Program for v2.0
**Prerequisites:**
1. Python3 is required to run.
2. The GUI launcher can only run on OSs supported by **[PyGame](https://www.pygame.org/wiki/about#:~:text=Truly%20portable.%20Supports,Child%20(OLPC)%20computer.)**
	- At the moment, we only support Windows and Linux, not MacOS users!

---

1. Set up virtual environment 
	- make the environment
    	- `Python3 -m venv env`
	- activate the environment
    	- Windows: `.\env\Scripts\activate.bat`
    	- Linux: `source ./env/bin/activate`


2. Install the global dependencies:
	- `pip install requests`


**Running the CLI version**
- Run `src/cli.py` 


**Running the GUI launcher:**

1. Install GUI dependencies 
	- `pip install pygame`


2. Run `src/MainWindow.py`


**How to make a beta distribution:**


1. Install the `pyinstaller` package `pip install pyinstaller`
2. Run pyinstaller either by adding Python's bin to your $PATH and running the following command
3. Run the following command:
	- LINUX:
`pyinstaller MainWindow.py -F --add-data GUI:GUI --add-data FALLBACK:FALLBACK`
	- WINDOWS:
`pyinstaller MainWindow.py -F -i GUI/assets/images/p2mm64.ico --noconsole --add-data "GUI;GUI" --add-data "FALLBACK;FALLBACK"`

*This will create a package for your OS that has all the GUI files inside of it*

**Outputs to "Dist/MainWindow.#"**

# Discord

If you need help setting up this mod, or just want to chill with a great community filled with developers, feel free to join our Discord server!

https://discord.gg/kW3nG6GKpF
