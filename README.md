# Created by ***kyleraykbs, Nanoman2525, Vista, Bumpy, & Wolƒe Strider Shoσter***
**Big thanks to our team members: ***Cabiste, sear, & Jeffrey*****

<u>**Note: This mod is completely server-side. Only the host needs to run Portal 2 with the mod installed. People who join the host should run stock Portal 2.**</u>

# v1.5 vs v2.0
**You may have noticed that there hasn't been a new release for the better half of a year**.

During this time, however, we have restructured the mod almost entirely to allow for better efficiency and more features collectively from 1,022 commits at this point in time. Because of this, the method of updating the mod that we expanded upon in the previous version (v1.5) is deprecated; It will be replaced with a newer, more flexible one.

Because of the amount of stability fixes and new features in the recent version of the mod, we have decided to rename it to version 2.0 rather than 1.6.
As it stands right now, version 1.5 is severely outdated, however, version 2.0 also has its issues with stability, as it is constantly being updated.

The pros and cons are listed below, though **we highly recommend upgrading to and sticking with the latest pre-release. (v2.0)**

***Version 1.5***
```
+ Easy to install
+ Gets the job done of having multiple players
+ User-friendly launcher
- Lacks many features
- Rushed codebase
- Existing features may be broken due to binary changes in recent Portal 2 updates
- Only supports the Windows OS
```

***Version 2.0***
```
+ Presents tons new features that were not in 1.5
+ Makes use of a custom plugin to bring about some of the features
+ Full Linux and Windows support
+ Rewritten codebase to allow for efficiency
+ Coded in a way to more likely work with future Portal 2 updates.
+ A lot more stability than v1.5
+ More organized file-structure
- Will take longer to install (requires that you install Python at this point in time)
- No pre-compiled launcher
- Some features may break as we update the pre-release.
- Not easy to set up
```


## Mod features (Already shipped in v1.5)
1. Maximum player cap of 33 (not 32!)
2. Elastic player collision
3. Custom player colors
4. Player join/disconnect messages
5. Patched some game breaking commands to prevent abuse from other players
6. Full cooperative campaign support
7. Support for Windows 11, 10, 8.1, 8, 7, Vista, and XP

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
  - v2.0 requires that you download the entire repository.

- Steam guide: https://steamcommunity.com/sharedfiles/filedetails/?id=2458260280
  - ***The Steam guide goes over everything you need to know in order to get the mod working, but just in case, we have also prepared supplementary videos if you get stuck.***

- Version 1.5 YouTube installation: https://www.youtube.com/watch?v=AOh6qela-uI
- Version 2.0 YouTube installation: https://www.youtube.com/watch?v=_Vsey2wPXSo


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

**Outputs to *"Build/MainWindow.#"**

# Discord

If you need help setting up this mod, or just want to chill with a great community filled with developers, feel free to join our Discord server!

https://discord.gg/kW3nG6GKpF
