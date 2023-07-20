from pathlib import Path
import os
import Scripts.GlobalVariables as GVars
import logging

def Log(message: str) -> None:
    message = message.strip()

    # Only write to the console if the message is not empty
    if len(message) > 0:
        logging.info("(P2:MM): " + message)
        print("(P2:MM): " + message)
    else:
        logging.info("")
        print("")

#///////////////////////////////////////////////#
#//# Setup logging for P2MM launcher session #//#
#///////////////////////////////////////////////#
def StartLog() -> None:

    log_path = os.path.join(GVars.modPath, "Logs")

    if not os.path.exists(log_path):
        os.mkdir(log_path)

    logger = logging.getLogger()
    logger.setLevel(logging.INFO)

    handler = logging.FileHandler(
        filename = os.path.join(log_path, f"Log-({GVars.appStartDate}).log"), # Log location
        mode= "w", # Mode to write to the log
        encoding = "utf-8", # Log encoding
    )
    logger.addHandler(handler)
    
    # Cool text to start the log with
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
    if (GVars.iow):
        Log("")
        Log("Windows OS detected!")
    elif (GVars.iol):
        Log("")
        Log("Linux OS: detected!")
    elif (GVars.iosd):
        Log("")
        Log("SteamOS 3.0: detected!")
