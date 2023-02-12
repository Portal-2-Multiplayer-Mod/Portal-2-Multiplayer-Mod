# This is a file to store all the global variables needed
# It's initiated only once when the mainwindow is created
# Please don't tammper with it

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
configData: dict[str, dict[str, str]]
modPath: str  # Main mod folder
modFilesPath: str  # The ModFiles folder for the mod
configsPath: str  # Path defined for config files for the launcher
iow: bool = False  # Windows system
iol: bool = False  # Linux system
iosd: bool = False # steam deck (only used to add some customization)
hadtoresetconfig: bool = False
AfterFunction: None
gameActive: bool = False


def init() -> None:
    global appStartDate, modPath, modFilesPath, configsPath, iow, iol, iosd

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

        modPath = buf.value + "/p2mm"
        modFilesPath = modPath + "/ModFiles/Portal 2/install_dlc"
        configsPath = modPath

    elif (sys.platform.startswith("linux")):

        iol = True

        if ("valve" in platform.release()):
            iosd = True

        # why does linux need to be different :uwaaah:
        modPath = os.path.expanduser("~") + "/.cache/p2mm"
        modFilesPath = modPath + "/ModFiles/Portal 2/install_dlc"
        configsPath = os.path.expanduser("~") + "/.config/p2mm"

    else:
        # Feel sad for the poor people who are running templeOS :)
        Log("This operating system is not supported!")
        Log("We only support Windows, Linux, and SteamOS 3.0 (Steam Deck) as of version 2.2.0!")
        quit()

    Log("Launcher variables:"+
        "" + str(appStartDate) +
        "" + str(modPath) +
        "" + str(modFilesPath) +
        "" + str(configsPath) +
        "" + str(iow) +
        "" + str(iol))

    # Check if the modpath exists, if not create it
    if not os.path.exists(modPath):
        os.makedirs(modPath)
    if not os.path.exists(configsPath):
        os.makedirs(configsPath)


def LoadConfig() -> None:
    global configData
    configData = cfg.ImportConfig()
    Log("Config data loaded.")
