import Scripts.GlobalVariables as GVars
from Scripts.BasicLogger import Log, StartLog
import Scripts.RunGame as RG
import Scripts.Configs as cfg
import Scripts.Updater as up
import shutil
import sys
import os

# set current directory to the directory of this file
os.chdir(os.path.dirname(os.path.abspath(__file__)))
cwd = os.getcwd()

def UserAction():
    validinput = False
    global WillMount
    WillMount = True
    while (not validinput):
        ShouldMount = input("(?) Would you like to mount or unmount the mod? (Mount/Unmount) ")

        # if the user doesn't want to proceed they can can quit
        if (ShouldMount.upper() == "EXIT" or ShouldMount.upper() == "ABORT" or ShouldMount.upper() == "QUIT"):
            Log("Exiting...")
            quit()

        if (ShouldMount.upper() == "MOUNT" or ShouldMount.upper() == "M"):
            validinput = True
            Log("User input: " + ShouldMount)
            Log("Mounting the mod...")
        elif (ShouldMount.upper() == "UNMOUNT" or ShouldMount.upper() == "U"):
            validinput = True
            WillMount = False
            Log("User input: " + ShouldMount)
            Log("Unmounting the mod...")
        else:
            Log("Type in a valid option!")


def GetGamePath():
    folder = input("please enter the path to the game: ").strip()
    cfg.EditConfig("portal2path", folder)
    Log("Saved '" + folder + "' as the game path.")


def VerifyGamePath():
    Log("Verifying game path...")
    valid = False
    while valid == False:
        gamepath = GVars.configData["portal2path"]["value"]
        if ((os.path.exists(gamepath)) != True) or (os.path.exists(gamepath + "/portal2_dlc2") != True):
            Log("Game path is invalid!")
            GetGamePath()
        else:
            valid = True
            Log("Game path is valid!")


def CheckForUpdates():

    clientUpdate = up.CheckForNewClient()
    if clientUpdate["status"]:
        Log(clientUpdate["name"])
        Log(clientUpdate["message"])

        valid = False
        while not valid:
            update = input("type YES or NO to update")
            if (update.upper() == "YES") or (update.upper() == "Y"):
                valid = True
                if up.DownloadClient("cli") == False:
                    Log("there was an error while updating")
                    Log("please contact the developers")
            elif (update.upper() == "NO") or (update.upper() == "N"):
                valid = True


    if up.CheckForNewFiles():
        valid = False
        while not valid:
            Log("")
            update = input("there are new files do you want to update the mod? DO NOT UPDATE! IF YOU ARE NOT A DEVELOPER! (y/n) ")
            if (update.upper() == "YES") or (update.upper() == "Y"):
                valid = True
                up.DownloadNewFiles()
            elif (update.upper() == "NO") or (update.upper() == "N"):
                valid = True
                return False

def IsNew():

    if len(sys.argv) != 3:
        return

    if (sys.argv[1] != "updated") or (not os.path.exists(sys.argv[2])):
        return

    Log("this is first launch after update")

    Log("deleting old client...")
    os.remove(sys.argv[2])

    Log("renaming new client...")
    # only change the name between quotes to whatever you want the client to name itself
    os.rename(GVars.executable, sys.argv[2])

def OnStart():
    # Populate the global variables
    GVars.init()
    # To do the fancy log thing
    StartLog()
    # Load the configs (It's better to do it separately)
    GVars.LoadConfig()
    # checks if the client was launched from an older version
    IsNew()
    # only check for updates for normal users
    if GVars.configData["developer"]["value"] != True:
        CheckForUpdates()


def VerifyModFiles():
    modFilesPath = GVars.modPath + "/ModFiles/Portal 2/install_dlc"
    Log("searching for mod files in: "+modFilesPath)
    if (os.path.exists(modFilesPath)) and (os.path.exists(modFilesPath + "/32playermod.identifier")):
        Log("Mod files found")
        return True

    Log("Mod files not found")
    return False


def DEVMOUNT():
    try:
        # delete the old modfiles
        shutil.rmtree(GVars.modPath + "/ModFiles")
    except Exception as e:
        Log("folder doesn't exist: "+ GVars.modPath + "/ModFiles")
        Log(str(e))

    # copy the one in the current directory to the modpath
    shutil.copytree(cwd + "/ModFiles", GVars.modPath + "/ModFiles")

    Log("copied files to mod path")


def UseFallbacks():
    # copy the "FALLBACK" folder to the modpath "GVars.modPath + "/ModFiles""
    shutil.copytree(cwd + "/FALLBACK/ModFiles", GVars.modPath + "/ModFiles")


def Init():
    OnStart()
    Log("")
    Log("Initializing...")
    Log("")

    # Ask the user what they want before proceeding.
    UserAction()
    VerifyGamePath()
    Log("")

    gamepath = GVars.configData["portal2path"]["value"]

#//# Mount P2:MM #//#
    if (WillMount):

        if (GVars.configData["developer"]["value"] == True):
            Log("Dev mode active")
            DEVMOUNT()

        elif (VerifyModFiles() == False) and (CheckForUpdates() == False):
            Log("No mod files available \n will use the backup files")
            UseFallbacks()

        RG.MountMod(gamepath)
        RG.LaunchGame(gamepath)

    else:
        RG.DeleteUnusedDlcs(gamepath)
        RG.UnpatchBinaries(gamepath)
        Log("Unmounted the game successfully")

    # it's annoying to be asked to exit when you're debugging
    # but don't remove it, it's there so the user can read the output when the game closes
    if (GVars.configData["developer"]["value"] != True):
        input("Press enter to exit")


if __name__ == "__main__":
    # Run the program.
    Init()
