import pypresence

import Scripts.BasicFunctions as BF
from Scripts.BasicLogger import Log

DRP = pypresence.Presence("1024425552066658465") # Set the Client ID for P2MM's Discord Rich Presence Application
discordActive: bool = False

def startRichPresence() -> None:
    global discordActive
    Log("Starting Discord Rich Presence!")
    if BF.checkIfProcessRunning("Discord"):
        discordActive = True
        DRP.connect()
        DRP.update(state="Playing with the Portal 2 Multiplayer Mod!", large_image="https://cdn.discordapp.com/icons/839651379034193920/afd6c41c4cca707576f023a23f611de4.webp?size=96")
        Log("Rich Presence enabled!")
    else:
        Log("Discord is not running or is not installed...")
        Log("Rich Presence will not be enabled!")

def updateRichPresence(count) -> None:
    global discordActive
    if discordActive == True:
        if BF.checkIfProcessRunning("Discord"):
            DRP.update(state= "Playing with the Portal 2 Multiplayer Mod!", large_image="https://cdn.discordapp.com/icons/839651379034193920/afd6c41c4cca707576f023a23f611de4.webp?size=96")
        else:
            discordActive = False
            Log("Discord is not running anymore...")
            Log("Will update again when Discord is started again...")
    else:
        if BF.checkIfProcessRunning("Discord"):
            discordActive = True
            Log("Discord detected! Starting Rich Presence!")
            DRP.update(state= "Playing with the Portal 2 Multiplayer Mod!", large_image="https://cdn.discordapp.com/icons/839651379034193920/afd6c41c4cca707576f023a23f611de4.webp?size=96")

def shutdownRichPresence() -> None:
    DRP.close()
    Log("Rich Presence for P2MM has been shutdown...")