import Scripts.GlobalVariables as GVars
from Scripts.BasicLogger import Log, StartLog
import Scripts.RunGame as RG
import Scripts.Configs as cfg

def UserAction():
    validinput = False
    global WillMount
    WillMount = True
    while (not validinput):
        ShouldMount = input("(?) Would you like to mount or unmount the mod? (Mount/Unmount)")

        # if the user doesn't want to proceed they can can quit
        if (ShouldMount.upper() == "EXIT" or ShouldMount.upper() == "ABORT" or ShouldMount.upper() == "QUIT"):
            Log("Exiting")
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
    folder = input("please enter the path to the game:")
    cfg.EditConfig("portal2path", folder)
    Log("saved '" + folder + "' as the game path")

def OnStart():
    # populate the global variables
    GVars.init()
    # to do the fancy log thing
    StartLog()
    GVars.LoadConfig()
    

def Init():
    OnStart()
    Log("")
    Log("Initializing...")
    Log("")

    # ask the user what they want before proceeding
    UserAction()
    Log("")
    gamepath = cfg.FindInConfig(GVars.configData, "portal2path")
#//# mount the multiplayer mod #//#
    if (WillMount):
        # checks for the state of the mounting process
        mountState = ""
        # undefined -> the game path in the config file is either undefined or invalid
        # filesMissing -> the mod's files (ModFiles/Portal 2/install_dlc) are missing
        # true -> the mouting process completed successfully
        while mountState != True:
            mountState = RG.MountMod(gamepath)
            if mountState == "undefined":
                Log("game path is undefined/ invalid , would you like to select it?")
                GetGamePath()

            if mountState == "filesMissing":
                Log("the mod files are missing")
                return
            
        RG.LaunchGame(gamepath)  # launch the game
        
    else:
        RG.DeleteUnusedDlcs(gamepath)
        RG.UnpatchBinaries(gamepath)


if __name__ == "__main__":
    # RUN INIT
    Init()
