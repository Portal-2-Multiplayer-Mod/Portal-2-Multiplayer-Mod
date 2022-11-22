import psutil
import pypresence

from Scripts.BasicLogger import Log

DRP = pypresence.Presence("1024425552066658465") # Set the Client ID for P2MM's Discord Rich Presence Application
discordActive: bool = False

def startRichPresence() -> None:
    global discordActive
    Log("Starting Discord Rich Presence!")
    if checkIfProcessRunning("Discord"):
        discordActive = True
        print(discordActive)
        DRP.connect()
        DRP.update(state="Playing with the Portal 2 Multiplayer Mod!", large_image="https://cdn.discordapp.com/icons/839651379034193920/afd6c41c4cca707576f023a23f611de4.webp?size=96")
        Log("Rich Presence enabled!")
    else:
        Log("Discord is not running or is not installed...")
        Log("Rich Presence will not be enabled!")

def updateRichPresence(count) -> None:
    global discordActive
    if discordActive == True:
        if checkIfProcessRunning("Discord"):
            DRP.update(state= str(count) + "" + "Playing with the Portal 2 Multiplayer Mod!", large_image="https://cdn.discordapp.com/icons/839651379034193920/afd6c41c4cca707576f023a23f611de4.webp?size=96")
        else:
            discordActive = False
            Log("Discord is not running anymore...")
            Log("Will update again when Discord is started again...")
    else:
        if checkIfProcessRunning("Discord"):
            discordActive = True
            Log("Discord detected! Starting Rich Presence!")
            DRP.update(state= str(count) + "" + "Playing with the Portal 2 Multiplayer Mod!", large_image="https://cdn.discordapp.com/icons/839651379034193920/afd6c41c4cca707576f023a23f611de4.webp?size=96")

def shutdownRichPresence() -> None:
    DRP.close()
    Log("Rich Presence for P2MM has been shutdown...")

def checkIfProcessRunning(processName) -> bool:
    for proc in psutil.process_iter():
        try:
            if processName.lower() in proc.name().lower():
                return True
        except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
            pass
    return False