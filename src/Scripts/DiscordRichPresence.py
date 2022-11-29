import pypresence

import Scripts.BasicFunctions as BF
from Scripts.BasicLogger import Log

DRP: tuple
discordActive: bool = False

def startRichPresence() -> None:
    global DRP
    global discordActive
    Log("Starting Discord Rich Presence...")
    # We need to try and and define the Client ID, this will also check if Discord is open but if not it will throw a exception
    # We need to ignore it since we have a better way to check if Discord is running or not
    try:
        discordActive = True
        DRP = pypresence.Presence("1024425552066658465") # Set the Client ID for P2MM's Discord Rich Presence Application
    except:
        discordActive = False
    if BF.checkIfProcessRunning("Discord") and (discordActive):
        DRP.connect()
        DRP.update(state="Playing with the Portal 2 Multiplayer Mod!", large_image="https://cdn.discordapp.com/icons/839651379034193920/afd6c41c4cca707576f023a23f611de4.webp?size=96")
        Log("Rich Presence enabled...")
    else:
        Log("Discord is not running or is not installed!")
        Log("Rich Presence will not be enabled!")

def updateRichPresence() -> None:
    global DRP
    global discordActive
    if (BF.checkIfProcessRunning("Discord")) and (discordActive):
        DRP.update(state="Playing with the Portal 2 Multiplayer Mod!", large_image="https://cdn.discordapp.com/icons/839651379034193920/afd6c41c4cca707576f023a23f611de4.webp?size=96")
    elif (BF.checkIfProcessRunning("Discord")) and (not discordActive):
        discordActive = True
        DRP = pypresence.Presence("1024425552066658465")
        DRP.connect()
        DRP.update(state="Playing with the Portal 2 Multiplayer Mod!", large_image="https://cdn.discordapp.com/icons/839651379034193920/afd6c41c4cca707576f023a23f611de4.webp?size=96")
        Log("Discord Detected! Started Rich Presence...")
    elif (not BF.checkIfProcessRunning("Discord")) and (discordActive):
        discordActive = False
        DRP.close()
        Log("Discord is not running, Rich Presence connection closed...")
        Log("Will update again when Discord is started again...")
    elif (not BF.checkIfProcessRunning("Discord")) and (not discordActive):
        pass

def shutdownRichPresence() -> None:
    global DRP
    if BF.checkIfProcessRunning("Discord"):
        Log("Shutting down P2MM's Discord Rich Presence...")
        DRP.close()
        Log("Rich Presence for P2MM has been shutdown...")