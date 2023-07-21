import os
import logging
from datetime import datetime
from pathlib import Path
import Scripts.GlobalVariables as GVars

# Used to Log messages to the log file
def Log(message: str) -> None:
    if len(message) > 0:
        logging.info("(P2:MM): " + message)
        print("(P2:MM): " + message)
    else:
        logging.info("")
        print("")

# Setup logging for P2MM launcher session
def StartLog() -> None:
    log_path = os.path.join(GVars.modPath, "Logs")

    Path(log_path).mkdir(parents=True, exist_ok=True)

    logger = logging.getLogger()
    logger.setLevel(logging.INFO)

    log_file = os.path.join(log_path, f"Log-({datetime.now().strftime('%Y-%m-%d %H-%M-%S')}).log")
    handler = logging.FileHandler(filename=log_file, mode="w", encoding="utf-8")
    logger.addHandler(handler)

    log_banner = """
    ____________________NEW LAUNCH LOG {timestamp}___________________

    ██████╗░░█████╗░██████╗░████████╗░█████╗░██╗░░░░░░░░░░██████╗░
    ██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██║░░░░░░░░░░╚════██╗
    ██████╔╝██║░░██║██████╔╝░░░██║░░░███████║██║░░░░░░░░░░░░███╔═╝
    ██╔═══╝░██║░░██║██╔══██╗░░░██║░░░██╔══██║██║░░░░░░░░░░██╔══╝░░
    ██║░░░░░╚█████╔╝██║░░██║░░░██║░░░██║░░██║███████╗░░░░░███████╗
    ╚═╝░░░░░░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝╚══════╝░░░░░╚══════╝
    
    ░░░░░░███╗░░░███╗██████╗░░░░░███╗░░░███╗░█████╗░██████╗░░░░░░░
    ░░░░░░████╗░████║██╔══██╗░░░░████╗░████║██╔══██╗██╔══██╗░░░░░░
    ░░░░░░██╔████╔██║██████╔╝░░░░██╔████╔██║██║░░██║██║░░██║░░░░░░
    ░░░░░░██║╚██╔╝██║██╔═══╝░░░░░██║╚██╔╝██║██║░░██║██║░░██║░░░░░░
    ░░░░░░██║░╚═╝░██║██║░░░░░░░░░██║░╚═╝░██║╚█████╔╝██████╔╝░░░░░░
    ░░░░░░╚═╝░░░░░╚═╝╚═╝░░░░░░░░░╚═╝░░░░░╚═╝░╚════╝░╚═════╝░░░░░░░
    """.format(timestamp=datetime.now().strftime('%Y-%m-%d %H-%M-%S'))

    Log(log_banner)

    if GVars.iow:
        Log("Windows OS detected!")
    elif GVars.iol:
        Log("Linux OS: detected!")
    elif GVars.iosd:
        Log("Steam Deck: detected!")
