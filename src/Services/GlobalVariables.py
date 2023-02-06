# This is a file to store all the global variables needed
# It's initiated only once when the MainWindow is created
# Please don't tamper with it unless you know what you're doing

import os
import sys
import platform
import ctypes.wintypes
from datetime import datetime
from Services.BasicLogger import Log
import Services.Configs as cfg

#!##########################################
#!##    Global Variables Declarations   #!##
#!##########################################

# the dateTime when the launcher was started, this is used to name the logs
appStartDate: str
configData: dict[str, dict[str, str]]
modPath: str  # Main mod folder
modFilesPath: str  # The Mod Files folder
configsPath: str  # Path defined for config files
p2mmScriptsPath: str  # Path defined for the multiplayermod scripts location of the mod
iow: bool = False  # Is On Windows
iol: bool = False  # Is On Linux
iosd: bool = False  # Is On SteamDeck
hadToResetConfig: bool = False
executable: str = os.path.abspath(sys.executable)
translations: dict[str, str]
AfterFunction: None
gameIsActive: bool = False


def init() -> None:
    global appStartDate, modPath, modFilesPath, configsPath, p2mmScriptsPath, iow, iol, iosd, translations

    appStartDate = datetime.now().strftime('%Y-%m-%d %H-%M-%S')

    if (sys.platform == "win32"):
        iow = True

        # Again thanks stackOverflow for this
        # This code allows us to get the document's folder on any windows pc with any language
        CSIDL_PERSONAL = 5       # My Documents
        SHGFP_TYPE_CURRENT = 0   # Get current, not default value

        buf = ctypes.create_unicode_buffer(ctypes.wintypes.MAX_PATH)
        ctypes.windll.shell32.SHGetFolderPathW(
            None, CSIDL_PERSONAL, None, SHGFP_TYPE_CURRENT, buf)

        # Set the modpath to the users documents folder
        modPath = buf.value + "/p2mm"

    elif (sys.platform.startswith("linux")):
        # Both Linux and SteamOS 3.0 system platform names return as "linux"
        # We need to use the platform release name to differentiate a normal Linux
        # distribution from SteamOS 3.0, SteamOS 3.0 includes "valve" in the release name
        if ("valve" in platform.release()):
            iosd = True

        iol = True

        modPath = os.path.expanduser("~") + "/Documents/p2mm"

    else:
        # Feel sad for the poor people who are running templeOS :)
        Log("This operating system is not supported!")
        Log("We only support Windows, Linux, and SteamOS 3.0 (Steam Deck) as of version 2.2.0!")
        quit()

    configsPath = modPath
    modFilesPath = modPath + "/ModFiles/Portal 2/install_dlc"
    p2mmScriptsPath = modFilesPath + "/scripts/vscripts/multiplayermod"

    Log("GVars paths:")
    Log(modPath + "\n" + modFilesPath + "\n" +
        configsPath + "\n" + p2mmScriptsPath)

    # Check if the modpath exists, if not create it
    if not os.path.exists(configsPath):
        os.makedirs(configsPath)
    if not os.path.exists(modPath):
        os.makedirs(modPath)


def LoadConfig() -> None:
    global configData
    configData = cfg.ImportConfig()
    Log("Config data loaded.")
