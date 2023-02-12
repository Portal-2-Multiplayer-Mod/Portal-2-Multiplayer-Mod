"""This is a file to store all the global variables needed
    It's initiated only once when the mainwindow is created
"""
import os
import platform
import sys
import ctypes.wintypes
from datetime import datetime
import Scripts.Configs as cfg
from Scripts.BasicLogger import Log

# //////////////////////////////////////////#
# //#    Global Variables Declarations   #//#
# //////////////////////////////////////////#

# appStartDate is the dateTime when the launcher was started, this is used to name the logs
appStartDate: str
configsData: dict[str, dict[str, str]]
mainFolderPath: str  # Main mod folder
modFilesPath: str  # The ModFiles folder for the mod
configsFilePath: str  # Path defined for config files for the launcher
isWin: bool = False  # Windows system
isLinux: bool = False  # Linux system
isSteamDeck: bool = False  # steam deck (only used to add some customization)
resetConfig: bool = False
AfterFunction: None
isGameActive: bool = False


def init() -> None:
    global appStartDate, mainFolderPath, modFilesPath, configsFilePath, isWin, isLinux, isSteamDeck

    appStartDate = datetime.now().strftime('%Y-%m-%d %H-%M-%S')

    if (sys.platform == "win32"):
        isWin = True

        # Again thanks stackOverflow for this
        # This code allows us to get the document's folder on any windows pc with any language
        CSIDL_PERSONAL = 5       # My Documents
        SHGFP_TYPE_CURRENT = 0   # Get current, not default value

        buf = ctypes.create_unicode_buffer(ctypes.wintypes.MAX_PATH)
        ctypes.windll.shell32.SHGetFolderPathW(
            None, CSIDL_PERSONAL, None, SHGFP_TYPE_CURRENT, buf)

        mainFolderPath = buf.value + "/p2mm"
        modFilesPath = mainFolderPath + "/ModFiles/Portal 2/install_dlc"
        configsFilePath = mainFolderPath

    elif (sys.platform.startswith("linux")):

        isLinux = True

        if ("valve" in platform.release()):
            isSteamDeck = True

        # why does linux need to be different :uwaaah:
        mainFolderPath = os.path.expanduser("~") + "/.cache/p2mm"
        modFilesPath = mainFolderPath + "/ModFiles/Portal 2/install_dlc"
        configsFilePath = os.path.expanduser("~") + "/.config/p2mm"

    else:
        # Feel sad for the poor people who are running templeOS :)
        Log("This operating system is not supported!")
        Log("We only support Windows, Linux, and SteamOS 3.0 (Steam Deck) as of version 2.2.0!")
        quit()

    Log("Launcher variables:" +
        "" + str(appStartDate) +
        "" + str(mainFolderPath) +
        "" + str(modFilesPath) +
        "" + str(configsFilePath) +
        "" + str(isWin) +
        "" + str(isLinux))

    # Check if the modpath exists, if not create it
    if not os.path.exists(mainFolderPath):
        os.makedirs(mainFolderPath)
    if not os.path.exists(configsFilePath):
        os.makedirs(configsFilePath)


def LoadConfig() -> None:
    global configsData
    configsData = cfg.ImportConfig()
    Log("Config data loaded.")
