from pathlib import Path
import Services.GlobalVariables as GVars


def Log(message: str) -> None:
    message = message.strip()
    # get the path of the mod launcher and make a floder inside it called "Logs"
    path = GVars.modPath + "/Logs"
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

# ////////////////////////////////////////#
# //# Cool text to start the log with  #//#
# ////////////////////////////////////////#


def StartLog() -> None:
    Log("")
    Log("")
    Log("")
    Log("")
    Log("____________________NEW LAUNCH LOG " +
        GVars.appStartDate + "___________________")
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
    Log("")
    if (GVars.iow):
        Log("Windows OS detected!")
    elif (GVars.iol):
        Log("Linux OS: detected!")
    elif (GVars.iosd):
        Log("SteamOS 3.0: detected!")

    Log("_______________________________________________________________")
