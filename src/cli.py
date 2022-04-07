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

#//# mount the multiplayer mod #//#
    if (WillMount):
        RG.MountMod()  # mount the mod
        RG.LaunchGame()  # launch the game
    else:
        RG.DeleteUnusedDlcs(cfg.FindInConfig(GVars.configData, "portal2path"))
        RG.UnpatchBinaries(cfg.FindInConfig(GVars.configData, "portal2path"))


if __name__ == "__main__":
    # RUN INIT
    Init()
