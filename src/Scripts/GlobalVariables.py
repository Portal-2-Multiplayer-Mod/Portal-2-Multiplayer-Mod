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
modPath: str # \p2mm
modFilesPath: str # \p2mm\Modfiles
configPath: str
masterSavePath: str # Path defined for the masterSave.cfg file
saveSystemNutPath: str # Path defined for the savesystem directory
iow: bool = False # Windows system
iol: bool = False # Linux system
iosd: bool = False # Steam OS 3.0 system, mainly Steam Deck
nf: str = os.sep # This way the logging won't break if someone runs the app on mac
hadtoresetconfig: bool = False
executable: str = os.path.abspath(sys.executable)
translations: dict[str, str]
AfterFunction: None

def init() -> None:
    global appStartDate, modPath, modFilesPath, configPath, masterSavePath, saveSystemPath, iow, iol, iosd, nf, translations

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
        modFilesPath = buf.value + nf + "p2mm\ModFiles"
        configPath = buf.value + nf + "p2mm"
        saveSystemPath = buf.value + nf + "p2mm\ModFiles\Portal 2\install_dlc\scripts\\vscripts\multiplayermod\savesystem"
    elif (sys.platform.startswith("linux")):
        # Both Linux and SteamOS 3.0 system platforms are returned as "linux"
        # We need to use the platform release name to differentiate a normal Linux distribution from SteamOS 3.0, SteamOS 3.0 release ends with "neptune"
        if ("valve" in platform.release()):
            # We need to disables Steam OS 3.0's read-only flag, we will make sure of this everytime because after a update of the operating system this gets turned back on
            # Without this updates and patching the won't work because the system was flagged read-only
            os.system("sudo steamos-readonly disable")
            iosd = True
        else:
            iol = True
        # Set the modpath the users home directory
        modPath = os.path.expanduser("~") + nf + ".cache\p2mm"
        modFilesPath = os.path.expanduser("~") + nf + ".cache\p2mm\Modfiles"
        configPath = os.path.expanduser("~") + nf + ".config\p2mm"
        saveSystemPath = os.path.expanduser("~") + nf + ".cache\p2mm\ModFiles\Portal 2\install_dlc\scripts\\vscript\multiplayermod\savesystem"

    else:
        # Feel sad for the poor people who are running templeOS :(
        Log("This operating system is not supported!")
        Log("We only support Windows, Linux, and SteamOS 3.0 (Steam Deck) as of current.")
        quit()

    # Check if the modpath exists, if not create it
    if not os.path.exists(modPath):
        os.makedirs(modPath)
    if not os.path.exists(configPath):
        os.makedirs(configPath)

def LoadConfig() -> None:
    global configData
    configData = cfg.ImportConfig()
    Log("Config data loaded.")
