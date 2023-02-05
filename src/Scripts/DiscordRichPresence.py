import requests
import json
import pypresence

import Scripts.GlobalVariables as GVars
import Scripts.BasicFunctions as BF
from Scripts.BasicLogger import Log
import Scripts.RunGame as RG
import Scripts.Updater as UP

DRPHandle: tuple = None
discordActive: bool = False
gameActive: bool = False

# Get the public ip of the user, this will be used for the join button for DRP
def getPublicIP() -> str:
    if not UP.haveInternet():
        Log("DRP [ERROR]: User isn't connected to the internet!")
        return

    endpoint = "https://ipinfo.io/json"
    response = requests.get(endpoint, verify = True)

    if response.status_code != 200:
        Log("DRP [ERROR]: Error getting Public IP of user!")
        Log("DRP [ERROR]: Status Code: " + response.status_code)
        return "Status:", response.status_code, "Problem with the request."

    data = response.json()
    return data['ip']

# Setup for our Discord Rich Presence (DRP)
def startRichPresence() -> None:
    Log("")
    global DRPHandle, discordActive

    # First check if the user wants DRP to be enabled
    if not GVars.configData["Discord-Rich-Presence"]["value"]:
        Log("DRP: User doesnt want Discord Rich Presence to be enabled, will not start!")
        Log("")
        DRPHandle = None
        discordActive = False
        return

    # Next check if the user is connected to the internet, Discord needs internet and DRP needs internet
    if not UP.haveInternet():
        Log("DRP [ERROR]: User isn't connected to the internet!")
        Log("")
        discordActive = False
        return

    Log("DRP: Starting Discord Rich Presence...")

    # Try to define the Client ID for Rich Presence, this will also check if Discord is open but if not it will throw a exception
    # If it throws a exception it will just be noted that Discord is not active and will check if Discord is running or not again later in the code
    try:
        DRPHandle = pypresence.Presence("1024425552066658465") # Set the Client ID for P2MM's Discord Rich Presence Application
        discordActive = True
    except:
        Log("DRP: Discord is not running or is not installed! Rich Presence will not be enabled!")
        Log("")
        DRPHandle = None
        discordActive = False
        return
    if BF.checkIfProcessRunning("Discord") and (discordActive):
        DRPHandle.connect()
        DRPHandle.update(state="In the Launcher Menu!",
        large_image="https://cdn.discordapp.com/icons/839651379034193920/afd6c41c4cca707576f023a23f611de4.webp?size=96")
        Log("DRP: Rich Presence started...")
    Log("")

# DRP can only update every 15 seconds, so Main() in MainWindow is called apon every 15 seconds
# It will go through and check if Discord is still active, if the user wants DRP, or if they have internet
# If not it will make sure to close the DRP connection and say in the console that DRP is now inactive
def updateRichPresenceCheck() -> None:
    global DRPHandle, discordActive

    if not GVars.configData["Discord-Rich-Presence"]["value"]:
        if DRPHandle != None:
            DRPHandle.close()
        discordActive = False
        return

    if not UP.haveInternet():
        Log("DRP [ERROR]: User isn't connected to the internet!")
        discordActive = False
        return
    
    if (BF.checkIfProcessRunning("Discord")) and (discordActive):
        updateRichPresenceRoutine()
    elif (BF.checkIfProcessRunning("Discord")) and (not discordActive):
        DRPHandle = pypresence.Presence("1024425552066658465")
        DRPHandle.connect()
        updateRichPresenceRoutine()
        Log("Discord Detected! Started Rich Presence...")
        discordActive = True
    elif (not BF.checkIfProcessRunning("Discord")) and (discordActive):
        DRPHandle.close()
        Log("Discord is not running, Rich Presence connection closed...")
        Log("Will update again when Discord is started again...")
        discordActive = False
    elif (not BF.checkIfProcessRunning("Discord")) and (not discordActive):
        pass

# This checks if the game is running 
def updateRichPresenceRoutine() -> None:
    global DRPHandle, discordActive

    if not GVars.configData["Discord-Rich-Presence"]["value"]:
        DRPHandle.close()
        discordActive = False
        return

    if not UP.haveInternet():
        discordActive = False
        return

    publicIP = getPublicIP()
    if (GVars.configData["Server-Password"]["value"] == "") and GVars.gameActive:
        DRPHandle.update(
            state="Playing with P2:MM!", 
            large_image="https://cdn.discordapp.com/icons/839651379034193920/afd6c41c4cca707576f023a23f611de4.webp?size=96",
            buttons=[{"label": "Join P2MM Play Session", "url": "steam://connect/" + publicIP + ":27015"}])
    elif (GVars.configData["Server-Password"]["value"] != "") and GVars.gameActive:
        DRPHandle.update(state="Playing with P2:MM!", 
        large_image="https://cdn.discordapp.com/icons/839651379034193920/afd6c41c4cca707576f023a23f611de4.webp?size=96")
    elif not GVars.gameActive:
        DRPHandle.update(state="In the Launcher Menu!", 
        large_image="https://cdn.discordapp.com/icons/839651379034193920/afd6c41c4cca707576f023a23f611de4.webp?size=96")

# When the user clicks the Exit button or tries to close the launcher window, 
# the launcher will go through its exit routine which includes this as the very last thing.
def shutdownRichPresence() -> None:
    global DRPHandle, discordActive

    if not GVars.configData["Discord-Rich-Presence"]["value"]:
        return

    if BF.checkIfProcessRunning("Discord") and (discordActive):
        Log("DRP: Shutting down P2MM's Discord Rich Presence...")
        DRPHandle.close()
        Log("DRP: Rich Presence for P2MM has been shutdown...")