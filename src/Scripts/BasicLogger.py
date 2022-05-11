from pathlib import Path
import Scripts.GlobalVariables as GVars

def Log(message):
    message = message.strip()
    # get the path of the mod launcher and make a floder inside it called "Logs"
    path = GVars.modPath + GVars.nf + "Logs"
    Path(path).mkdir(parents=True, exist_ok=True)
    
    # creates a log file and writes to it
        # if the file already exists it will append to it
    with open(path + GVars.nf + "Log-"+GVars.appStartDate+".log", "a", encoding="utf-8") as log:
        log.write(message + "\n")
        
    # Only write to the console if the message is not empty
    if len(message) > 0:
        print("(P2:MM): " + message)
    else:
        print("")
        
        
#////////////////////////////////////////#
#//# Cool text to start the log with  #//#
#////////////////////////////////////////#
def StartLog():
    Log("")
    Log("")
    Log("")
    Log("")
    Log("____________________NEW LAUNCH LOG " + GVars.appStartDate + "___________________")
    Log("")
    Log("")
    Log("")
    Log("██████╗░░█████╗░██████╗░████████╗░█████╗░██╗░░░░░░░░░██████╗░")
    Log("██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██║░░░░░░░░░╚════██╗")
    Log("██████╔╝██║░░██║██████╔╝░░░██║░░░███████║██║░░░░░░░░░░░███╔═╝")
    Log("██╔═══╝░██║░░██║██╔══██╗░░░██║░░░██╔══██║██║░░░░░░░░░██╔══╝░░")
    Log("██║░░░░░╚█████╔╝██║░░██║░░░██║░░░██║░░██║███████╗░░░░███████╗")
    Log("╚═╝░░░░░░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝╚══════╝░░░░╚══════╝")
    Log("")
    Log("███╗░░░███╗██████╗░░░░░███╗░░░███╗░█████╗░██████╗░")
    Log("████╗░████║██╔══██╗░░░░████╗░████║██╔══██╗██╔══██╗")
    Log("██╔████╔██║██████╔╝░░░░██╔████╔██║██║░░██║██║░░██║")
    Log("██║╚██╔╝██║██╔═══╝░░░░░██║╚██╔╝██║██║░░██║██║░░██║")
    Log("██║░╚═╝░██║██║░░░░░░░░░██║░╚═╝░██║╚█████╔╝██████╔╝")
    Log("")
    Log("")

    Log("______________________General Device Info______________________")
    if (GVars.iow):
        Log("")
        Log("Windows OS detected!")
    elif (GVars.iol):
        Log("")
        Log("Linux OS detected!")