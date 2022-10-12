# this is a file to store all the global variables needed
# it's initiated only once when the mainwindow is created
# please don't tammper with it

import os
import sys
import ctypes.wintypes
from datetime import datetime
import Scripts.Configs as cfg
from Scripts.BasicLogger import Log

#//////////////////////////////////////////#
#//#    Global Variables Declarations   #//#
#//////////////////////////////////////////#

# appStartDate is the dateTime when the launcher was started, this is used to name the logs
appStartDate: str
configData: dict[str, dict[str, str]]
modPath: str
configPath: str
saveSystemNutPath: str # Path defined for the savesystem-main.nut file
iow: bool = False
iol: bool = False
nf: str = os.sep # this way the logging won't break if someone runs the app on mac
hadtoresetconfig: bool = False
executable: str = os.path.abspath(sys.executable)
translations: dict[str, str]
AfterFunction: None

def init() -> None:
    global appStartDate, modPath, modFilesPath, iow, iol, nf, translations, configPath, saveSystemNutPath, saveSystemEnabled

    appStartDate = datetime.now().strftime('%Y-%m-%d %H-%M-%S')

    if (sys.platform == "win32"):
        iow = True

        # again thanks stackOverflow for this
        # this code allows us to get the document's folder on any windows pc with any language
        CSIDL_PERSONAL = 5       # My Documents
        SHGFP_TYPE_CURRENT = 0   # Get current, not default value

        buf = ctypes.create_unicode_buffer(ctypes.wintypes.MAX_PATH)
        ctypes.windll.shell32.SHGetFolderPathW(None, CSIDL_PERSONAL, None, SHGFP_TYPE_CURRENT, buf)

        # set the modpath to the users documents folder
        modPath = buf.value + nf + "p2mm"
        modFilesPath = buf.value + nf + "p2mm\ModFiles"
        configPath = buf.value + nf + "p2mm"
        saveSystemNutPath = buf.value + nf + "p2mm\ModFiles\Portal 2\install_dlc\scripts\\vscripts\multiplayermod\savesystem"
    elif (sys.platform.startswith("linux")):
        iol = True
        # set the modpath the the users home directory
        modPath = os.path.expanduser("~") + nf + ".cache\p2mm"
        modFilesPath = os.path.expanduser("~") + nf + ".cache\p2mm\Modfiles"
        configPath = os.path.expanduser("~") + nf + ".config\p2mm"
        saveSystemNutPath = os.path.expanduser("~") + nf + ".cache\p2mm\ModFiles\Portal 2\install_dlc\scripts\\vscript\multiplayermod\savesystem"
    else:
        # feel sad for the poor people who are running templeOS :(
        Log("This operating system is not supported!")
        Log("We only support Windows and Linux as of current.")
        quit()

    # check if the modpath exists, if not create it
    if not os.path.exists(modPath):
        os.makedirs(modPath)
    if not os.path.exists(configPath):
        os.makedirs(configPath)

def LoadConfig() -> None:
    global configData
    configData = cfg.ImportConfig()
    Log("Config data loaded.")
