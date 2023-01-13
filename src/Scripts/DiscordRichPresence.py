import pypresence

import Scripts.BasicFunctions as BF
from Scripts.BasicLogger import Log

DRP: tuple
discordActive: bool = False

# Setup for our Discord Rich Presence (DRP)
def startRichPresence() -> None:
    global DRP, discordActive
    Log("Starting Discord Rich Presence...")
    # First its needed to try and and define the Client ID for Rich Presence, this will also check if Discord is open but if not it will throw a exception
    # If it throws a exception it will just be noted that Discord is not active and will check if Discord is running or not again later in the code
    try:
        DRP = pypresence.Presence("1024425552066658465") # Set the Client ID for P2MM's Discord Rich Presence Application
        discordActive = True
    except:
        Log("Discord is not running or is not installed! Rich Presence will not be enabled!")
        discordActive = False
        return
    if BF.checkIfProcessRunning("Discord") and (discordActive):
        DRP.connect()
        DRP.update(state="Playing with the Portal 2 Multiplayer Mod!", large_image="https://cdn.discordapp.com/icons/839651379034193920/afd6c41c4cca707576f023a23f611de4.webp?size=96")
        Log("Rich Presence enabled...")

# DRP can only update every 15 seconds so in Main() in MainWindow this is called apon after 15 seconds
# It will update the rich presences information, currently all it does is check if Discord is still active or not and update info as needed
def updateRichPresence() -> None:
    global DRP, discordActive
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

# When the user clicks the Exit button or tries to close the launcher window, 
# the launcher will go through its exit routine which includes this as the very last thing
def shutdownRichPresence() -> None:
    global DRP, discordActive
    if BF.checkIfProcessRunning("Discord") and (discordActive):
        Log("Shutting down P2MM's Discord Rich Presence...")
        DRP.close()
        Log("Rich Presence for P2MM has been shutdown...")