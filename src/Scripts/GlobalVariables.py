# This is a file to store all the global variables needed
# It's initiated only once when the mainwindow is created
# Please don't tammper with it

import os
import sys
import platform
import ctypes.wintypes
from datetime import datetime
import Scripts.Configs as cfg
from Scripts.BasicLogger import Log

#//////////////////////////////////////////#
#//#    Global Variables Declarations   #//#
#//////////////////////////////////////////#

appStartDate: str # appStartDate is the dateTime when the launcher was started, this is used to name the logs
configData: dict[str, dict[str, str]]
modPath: str # Main mod folder
modFilesPath: str # The ModFiles folder for the mod
configsPath: str # Path defined for config files for the launcher
p2mmScriptsPath: str # Path defined for the multiplayermod scripts location of the mod
iow: bool = False # Windows system
iol: bool = False # Linux system
iosd: bool = False # Steam Deck/SteamOS 3.0 system
nf: str = os.sep # This way the logging won't break if someone runs the app on Mac
hadtoresetconfig: bool = False
executable: str = os.path.abspath(sys.executable)
translations: dict[str, str]
AfterFunction: None
gameActive: bool = False

def init() -> None:
    global appStartDate, modPath, modFilesPath, configsPath, p2mmScriptsPath, iow, iol, iosd, nf, translations

    appStartDate = datetime.now().strftime('%Y-%m-%d %H-%M-%S')

    if (sys.platform == "win32"):
        iow = True

        # Again thanks stackOverflow for this
        # This code allows us to get the document's folder on any windows pc with any language
        CSIDL_PERSONAL = 5       # My Documents
        SHGFP_TYPE_CURRENT = 0   # Get current, not default value

        buf = ctypes.create_unicode_buffer(ctypes.wintypes.MAX_PATH)
        ctypes.windll.shell32.SHGetFolderPathW(None, CSIDL_PERSONAL, None, SHGFP_TYPE_CURRENT, buf)

        # Set the modpath to the users documents folder
        modPath = buf.value + nf + "p2mm"
        modFilesPath = modPath + nf + "ModFiles\Portal 2\install_dlc"
        configsPath = modPath
        p2mmScriptsPath = modFilesPath + nf + "scripts\\vscripts\multiplayermod"
        Log("GVars paths for Windows:")
        Log(modPath + "\n" + modFilesPath + "\n" + configsPath + "\n" + p2mmScriptsPath)
    elif (sys.platform.startswith("linux")):
        # Both Linux and SteamOS 3.0 system platform names return as "linux"
        # We need to use the platform release name to differentiate a normal Linux 
        # distribution from SteamOS 3.0, SteamOS 3.0 includes "valve" in the release name
        if ("valve" in platform.release()):
            iosd = True
            # SteamOS 3.0 has some directories set to read-only, they can be fixed but it gets reset every update and it requires sudo
            # Because of this p2mm will be installed to the home\deck\Desktop directory instead of .cache and .config
            # For some reason also SteamOS 3.0's os.sep is "/" instead of the usual "\"
            modPath = os.path.expanduser("~") + nf + "Desktop/p2mm"
            modFilesPath = modPath + nf + "ModFiles/Portal 2/install_dlc"
            configsPath = modPath
            p2mmScriptsPath = modFilesPath + nf + "scripts/vscripts/multiplayermod"
            Log("GVars paths for Steam Deck/SteamOS 3.0:")
            Log(modPath + "\n" + modFilesPath + "\n" + configsPath + "\n" + p2mmScriptsPath)
        else:
            iol = True
            # Set the modpath the to the users .cache and .config directories in the home directory
            modPath = os.path.expanduser("~") + nf + ".cache\p2mm"
            modFilesPath = modPath + nf + "Modfiles\Portal 2\install_dlc"
            configsPath = os.path.expanduser("~") + nf + ".config\p2mm"
            p2mmScriptsPath = modFilesPath + nf + "scripts\\vscripts\multiplayermod"
            Log("GVars paths for Linux:")
            Log(modPath + "\n" + modFilesPath + "\n" + configsPath + "\n" + p2mmScriptsPath)
    else:
        # Feel sad for the poor people who are running templeOS :)
        Log("This operating system is not supported!")
        Log("We only support Windows, Linux, and SteamOS 3.0 (Steam Deck) as of version 2.2.0!")
        quit()

    # Check if the modpath exists, if not create it
    if not os.path.exists(modPath):
        os.makedirs(modPath)
    if not os.path.exists(configsPath):
        os.makedirs(configsPath)

def LoadConfig() -> None:
    global configData
    configData = cfg.ImportConfig()
    Log("Config data loaded.")
