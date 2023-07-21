# This is a file to store all the global variables needed
# It's initiated only once when the mainwindow is created
# Please don't tammper with it

import os
import sys
import platform
import ctypes.wintypes
import Scripts.Configs as CFG
from Scripts.BasicLogger import Log

#//////////////////////////////////////////#
#//#    Global Variables Declarations   #//#
#//////////////////////////////////////////#

configData: dict[str, dict[str, str]]
modPath: str # \p2mm
modFilesPath: str # \p2mm\Modfiles
configPath: str
iow: bool = False # Windows system
iol: bool = False # Linux system
iosd: bool = False # Steam Deck/Steam OS 3.0 system
hadtoresetconfig: bool = False
executable: str = os.path.abspath(sys.executable)
translations: dict[str, str]
AfterFunction: None

def init() -> None:
    global modPath, modFilesPath, configPath, iow, iol, iosd, nf, translations

    if (sys.platform == "win32"):
        iow = True

        # Again thanks stackOverflow for this
        # This code allows us to get the document's folder on any windows pc with any language
        CSIDL_PERSONAL = 5       # My Documents
        SHGFP_TYPE_CURRENT = 0   # Get current, not default value

        buf = ctypes.create_unicode_buffer(ctypes.wintypes.MAX_PATH)
        ctypes.windll.shell32.SHGetFolderPathW(None, CSIDL_PERSONAL, None, SHGFP_TYPE_CURRENT, buf)

        # Set the modpath to the users documents folder
        modPath = buf.value + os.sep + "p2mm"
        modFilesPath = buf.value + os.sep + "p2mm\\ModFiles"
        configPath = buf.value + os.sep + "p2mm"
    elif (sys.platform.startswith("linux")):
        # Both Linux and Steam Deck system platform names return as "linux"
        # We need to use the platform release name to differentiate a normal Linux distribution from Steam Decks one
        # Steam Deck uses SteamOS 3.0 which is built off Arch, includes "valve" in the platform release.
        if ("valve" in platform.release()):
            iosd = True
            # Steam OS 3.0 has some directories set to read-only
            # We are going to install p2mm to the home\Documents directory instead of .cache and .config because of this
            # We are also gonna keep stuff together like with the Windows paths, configs will be placed into the same directory as the ModFiles
            modPath = os.path.expanduser("~") + os.sep + "Documents/p2mm"
            modFilesPath = os.path.expanduser("~") + os.sep + "Documents/p2mm/Modfiles"
            configPath = os.path.expanduser("~") + os.sep + "Documents/p2mm"
        else:
            iol = True
            # Set the modpath the to the users .cache and .config directories in the home directory
            modPath = os.path.expanduser("~") + os.sep + ".cache/p2mm"
            modFilesPath = os.path.expanduser("~") + os.sep + ".cache/p2mm/Modfiles"
            configPath = os.path.expanduser("~") + os.sep + ".config/p2mm"
    else:
        # Feel sad for the poor people who are running templeOS :(
        Log("This operating system is not supported!")
        Log("We only support Windows, Linux, and Steam Deck as of current.")
        exit()

    # Check if the modpath exists, if not create it
    if not os.path.exists(modPath):
        os.makedirs(modPath)
    if not os.path.exists(configPath):
        os.makedirs(configPath)

def LoadConfig() -> None:
    global configData
    configData = CFG.ImportConfig()
    Log("Config data loaded.")
