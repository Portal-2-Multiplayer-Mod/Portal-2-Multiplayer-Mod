import os

import Scripts.BasicFunctions as BF
import Scripts.GlobalVariables as GVars

def GetLastLog() -> str:
    logsPath = os.path.join(GVars.modPath, "Logs")
    logs = os.listdir(logsPath)
    logs.sort(reverse=True)
    return os.path.join (logsPath + "/" + logs[0])

def GetConsoleFile() -> str | None:
    path = BF.NormalizePath(GVars.configData['Portal2-Path']['value'] + "/portal2/console.log")
    if os.path.exists(path) and os.path.isfile(path):
        return path
    return None

# should we do any filtering? (the console.txt file saves the local ip on)
def WriteConsoleToLog() -> None:
    consoleFile = GetConsoleFile()
    if consoleFile == None:
        return
    
    logFile = GetLastLog()
    
    with open(logFile, "a") as log:
        log.write("# PORTAL 2 CONSOLE LOGS:\n\n")
        with open(consoleFile, "r") as console:
            log.write(FilterConsole(console.read()))
        log.write("\n\n# PORTAL 2 CONSOLE LOGS END.\n\n")
    
    # to avoid duplicates
    BF.DeleteFile(consoleFile)

def FilterConsole(text:str) -> str:
    return text