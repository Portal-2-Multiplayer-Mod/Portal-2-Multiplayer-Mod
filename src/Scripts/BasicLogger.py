from pathlib import Path

import Scripts.GlobalVariables as GVars

def Log(message: str) -> None:
    message = message.strip()
    # get the path of the mod launcher and make a floder inside it called "Logs"
    path = GVars.mainFolderPath + "/Logs"
    Path(path).mkdir(parents=True, exist_ok=True)

    # creates a log file and writes to it
        # if the file already exists it will append to it
    with open(path + "/Log-"+GVars.appStartDate+".log", "a", encoding="utf-8") as log:
        log.write(message + "\n")

    # Only write to the console if the message is not empty
    if len(message) > 0:
        try:
            print("(P2:MM): " + message)
        except Exception as e:
            print(str(e))
    else:
        print("")

#////////////////////////////////////////#
#//# Cool text to start the log with  #//#
#////////////////////////////////////////#
def StartLog() -> None:
    Log("")
    Log("")
    Log("")
    Log("")
    Log("____________________NEW LAUNCH LOG " + GVars.appStartDate + "___________________")
    Log("")
    Log("")
    Log("")
    Log("██████╗░░█████╗░██████╗░████████╗░█████╗░██╗░░░░░░░░░░██████╗░")
    Log("██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██║░░░░░░░░░░╚════██╗")
    Log("██████╔╝██║░░██║██████╔╝░░░██║░░░███████║██║░░░░░░░░░░░░███╔═╝")
    Log("██╔═══╝░██║░░██║██╔══██╗░░░██║░░░██╔══██║██║░░░░░░░░░░██╔══╝░░")
    Log("██║░░░░░╚█████╔╝██║░░██║░░░██║░░░██║░░██║███████╗░░░░░███████╗")
    Log("╚═╝░░░░░░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝╚══════╝░░░░░╚══════╝")
    Log("")
    Log("░░░░░░███╗░░░███╗██████╗░░░░░███╗░░░███╗░█████╗░██████╗░░░░░░░")
    Log("░░░░░░████╗░████║██╔══██╗░░░░████╗░████║██╔══██╗██╔══██╗░░░░░░")
    Log("░░░░░░██╔████╔██║██████╔╝░░░░██╔████╔██║██║░░██║██║░░██║░░░░░░")
    Log("░░░░░░██║╚██╔╝██║██╔═══╝░░░░░██║╚██╔╝██║██║░░██║██║░░██║░░░░░░")
    Log("░░░░░░██║░╚═╝░██║██║░░░░░░░░░██║░╚═╝░██║╚█████╔╝██████╔╝░░░░░░")
    Log("░░░░░░╚═╝░░░░░╚═╝╚═╝░░░░░░░░░╚═╝░░░░░╚═╝░╚════╝░╚═════╝░░░░░░░")
    Log("")
    Log("")

    Log("______________________General Device Info______________________")
    if (GVars.isWin):
        Log("")
        Log("Windows OS detected!")
    elif (GVars.isLinux):
        Log("")
        Log("Linux OS: detected!")
    elif (GVars.isSteamDeck):
        Log("")
        Log("SteamOS 3.0: detected!")
