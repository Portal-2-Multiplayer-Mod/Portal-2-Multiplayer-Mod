import json
import os
import sys
import traceback
import time

import Scripts.BasicFunctions as BF
import Scripts.Configs as cfg
import Scripts.GlobalVariables as GVars
from Scripts.BasicLogger import Log

# Data System Terminology:
# Enabled: The data system has started successfully on the python scripts end
# Disabled: The data system didn't start successfully on the python scripts end
# Running: By default the data system is set to run with every play session, there is a option in the hidden menu that devs can use to disable it for testing purposes
# Not Running: The user has defined in the hidden menu setting they do not want the data system to run next play session or the system is disabled by a error which occured

# Verification Statuses:
# The point of these statuses is to tell users in the Datas menu the kind of compatibility it is with the p2mm mod
# Offical: This is an official map by Valve or by a p2mm dev member, it has been made or designed to work with p2mm and has been approved by someone on the p2mm dev team. No one outside the p2mm dev team should have status with a map they created.
# Verified: The map has been tested and verified by a p2mm dev to work with the p2mm mod.
# Playable: The map can be run with multiple players, but the map still has issues in certain parts or functionalities. Players should be able to complete the map from start to finish. Mainly minor bugs or glitches put it into this state until they have been resolved.
# Unplayable: A map can be marked with this if the p2mm breaks the map entirely, making it unplayable with the mod, or the map itself can not function as intended with more than the initial amount of players used to test the map.
# Not Tested: The map has yet to be tested by a p2mm dev. We can not guarantee this means the map will work.

# This is the default masterData.cfg structure
# This is used to check if the file is formatted correctly and if a new one needs to be created
defaultDataStructure = {
    "kicklist":[], # The kick list is a list that will be reset for every play session
    "banlist":[], # The ban list is a list that will persist every play session

    "Test Room": { # This will be removed later when what ever update involving this system is released
        "verificationStatus": "offical", # The maps status in the system
        "mapFileName": "mp_coop_testroom", # Specify the map .bsp file
        "mapsupportFile": "mp_coop_testroom", # Specify the map support .nut file if there is one
        "data": {
            "testdatasend": "notsent",
            "testdatarecieved": "notsent"
        }
    }
}

# Screenshot file names the DS will check for
datasystemscreenshots: list = [
    "datasystem-test", "datasystem-retrieve", 
    "datasystem-kick", "datasystem-ban", 
    "datasystem-setpasswordsuccess", "datasystem-setpasswordfailed", 
    "datasystem-nutsuccess", "datasystemcheck-nutfail"
]

presetKeys = {"kicklist", "banlist", "Test Room"}
mapValues = {"verificationStatus", "mapFileName", "mapSupportFile", "data"}

def DSLogging(message: str, debugging: str = "false", hasstarted: bool = False) -> None:
    if (debugging == "true") and hasstarted:
        Log("DS [DEBUG]: " + message)
        return
    elif (not hasstarted) and ((message.startswith("___") or message == "")):
        Log(message)
        return
    elif not hasstarted:
        Log("DS: " + message)
        return

# This is our initialization function for the system, it will also act as the refresh function when the system requires a refresh
def dataSystemInitialization(refresh: bool = False, debugging: str = "false", hasstarted: bool = True) -> None:
    global dsSavesPath, ssFilesPath, locallscfg, localscfg, serverPassword, dataSystemState, firstStart, started, dsdebug
    dsSavesPath = GVars.configData["Portal2-Path"]["value"] + GVars.nf + "portal2" + GVars.nf + "scripts" + GVars.nf + "vscripts" + GVars.nf + "datasystemsaves"
    ssFilesPath = GVars.configData["Portal2-Path"]["value"] + GVars.nf + "portal2" + GVars.nf + "screenshots"
    locallscfg = GVars.modFilesPath + GVars.nf + "Portal 2" + GVars.nf + "install_dlc" + GVars.nf + "cfg" + GVars.nf + "listenserver.cfg"
    localscfg = GVars.modFilesPath + GVars.nf + "Portal 2" + GVars.nf + "install_dlc" + GVars.nf + "cfg" + GVars.nf + "server.cfg"
    serverPassword = GVars.configData["Server-Password"]["value"]
    dataSystemState = False
    firstStart = False
    dsdebug = debugging
    started = hasstarted
    try:
        DSLogging("", dsdebug, started)
        if refresh:
            DSLogging("__________Data System Refresh Start__________", dsdebug, started)
            if GVars.configData["Data-System-Overide"] == False:
                DSLogging("The Data System has been manually disabled, it will not refresh...", dsdebug, started)
                dataSystemState = False
                return
            DSLogging("Refreshing the data system...", dsdebug, started)
        else:
            Log("__________Data System Initialization Start__________")
            DSLogging("Initalizing the data system...", dsdebug, started)

        # We first need to check if the p2mm folder has been created
        # Normally it should exist, but in the wacky case something screws up and the previous scripts don't catch it, this will be a fail safe
        DSLogging("Checking file system integrity...", dsdebug, started)
        if not os.path.exists(GVars.modPath):
            Log("")
            Log(" __________!!!FATAL: DATA SYSTEM p2mmNotFoundError!!!__________")
            Log("FATAL DATA SYSTEM ERROR!!! The main p2mm directory couldn't be found!")
            Log("This shouldn't happen at all! If this happens again please reinstall the mod!")
            Log("If the issue persists then please let us know in our Discord!")
            Log("This error has to do with the data system so please ping Orsell (aka zwexit) in #mod-help in our discord.")
            Log("The launcher will be stopped...")
            Log("Below is the exception that resulted in this nonsense:\n" + traceback.format_exc())
            Log("__________!!!FATAL: DATA SYSTEM p2mmNotFoundError!!!__________")
            Log("")
            dataSystemState = False
            exit("p2mmNotFoundError")

        # Next check if the ModFiles are there and if the portal2 path has been defined
        # If they aren't the Data System will assume that this is the first time the person has started the launcher
        # Once the launcher is updated the initilization function will run again
        if (not os.path.exists(GVars.modFilesPath)) or (GVars.configData["Portal2-Path"]["value"] == "undefined"):
            raise firstStartWarning
        
        # We need to make sure that the datasystemsaves folder is in the portal2 folder's vscripts folder
        if not os.path.exists(dsSavesPath) and (GVars.configData["Portal2-Path"]["value"] != "undefined"):
            os.makedirs(dsSavesPath)

        DSLogging("File system is good...", dsdebug, started)

        # We need to remove any old screenshot file indicators that tells the data system information from Portal 2
        # We will also check if the Portal 2 directory was defined before 
        DSLogging("Checking for any old screenshot file indicators left over...", dsdebug, started)
        if not GVars.configData["Portal2-Path"]["value"] == "undefined":
            if not os.listdir(ssFilesPath) == []:
                DSLogging("Found screenshot files, determining if they belong to the DS and removing them...", dsdebug, started)
                for dataSystemIndicator in os.listdir(ssFilesPath):
                    if dataSystemIndicator.startswith("datasystem-"):
                        os.remove(ssFilesPath + GVars.nf + dataSystemIndicator)
                        DSLogging("Removed old screenshot file indicator " + dataSystemIndicator + "...", dsdebug, started)
        DSLogging("Finished checking for any old screenshot file indicators...", dsdebug, started)

        # If the masterDataFile config file doesn't exist, a new fresh one is created
        DSLogging("Checking our masterData.cfg file...", dsdebug, started)
        if (not os.path.exists(GVars.configsPath + GVars.nf + "masterData.cfg")) or (os.path.getsize(GVars.configsPath + GVars.nf + "masterData.cfg") == 0):
            DSLogging("No masterData.cfg detected, creating a new one...", dsdebug, started)
            createNewMasterData()
        else:
            DSLogging("masterData.cfg retrieved...", dsdebug, started)
            configsPath = (GVars.configsPath + GVars.nf + "masterData.cfg")
            masterDataFileStructureCheck(configsPath)

        # Now finally need to check if the datasystem.nut file exists, this should be downloaded when the launcher updates
        # If it's not there the Portal 2 will not be able to communicate with the launcher, the system will be disabled
        DSLogging("Checking on our main data system Squirrel file...", dsdebug, started)
        if not os.path.exists(GVars.p2mmScriptsPath + GVars.nf + "datasystem.nut"):
            raise dataSystemNutNotFoundError
        else:
            DSLogging("Our Squirrel file exists...", dsdebug, started)

    # If some miscelanous or unaccounted for error occurs this will throw, Orsell messed up something too if this happens :)
    # This for some reason this is getting executed along with the other exceptions, thats not suppose to happen and it needs to be fixed
    except Exception:
        Log("")
        Log("__________DATA SYSTEM ERROR!!!__________")
        Log("An unknown error that hasn't been accounted for in the development of this script has occured...")
        Log("This error has to do with the data system so please ping Orsell (aka zwexit) in #mod-help in our discord.")
        Log("He must have messed up something if this appears.")
        Log("To make sure nothing else errors the data system will be disabled...")
        Log("Below is the exception that resulted in this nonsense:\n" + traceback.format_exc())
        Log(" __________DATA SYSTEM ERROR!!!__________")
        Log("")
        dataSystemState = False

    # This will run only if the data system sucessfully initilized
    else:
        if refresh:
            DSLogging("The data system has refreshed sucessfully!", dsdebug, started)
        else:
            DSLogging("The data system has started sucessfully!", dsdebug, started)
        DSLogging("The system will be enabled for the next play session...", dsdebug, started)
        dataSystemState = True

    # Now  create the files needed for the datasystem.nut file to read when its called on later when a map loads
    finally:
            try:
                if GVars.configData["Portal2-Path"]["value"] != "undefined":
                    if (dataSystemState) and (not firstStart) and (GVars.configData["Data-System-Overide"]["value"] == "true"):
                        dataSystemInitSuccess = open(dsSavesPath + GVars.nf + "datasystem-enabled.nut", "x")
                        started = True
                    elif firstStart:
                        DSLogging("This is the launchers first start, will not be creating datasystem nut indicator...", dsdebug, started)
                        started = True
                    elif (not dataSystemState) and (not firstStart):
                        dataSystemInitFail = open(dsSavesPath + GVars.nf + "datasystem-disabled.nut", "x")
                        DSLogging("The data system encountered an error and it can't be enabled! Or it has been disabled in the Dev Menu.", dsdebug, started)
                        DSLogging("The system will be disabled for the next play session...", dsdebug, started)
                        started = True

            # If for some reason one of the indicators already exists it will pass
            except FileExistsError:
                pass

            # This exception should only occur if either the p2mm or Modfiles folder weren't found
            except FileNotFoundError:
                Log("")
                Log("__________DATA SYSTEM FileNotFoundError!!!__________")
                Log("The data system encountered an error and it can't be enabled!")
                Log("This was caused because either the p2mm or ModFiles folder wasn't found.")
                Log("The system will be disabled for the next play session...")
                Log("Below is the exception that resulted in this nonsense:\n" + traceback.format_exc())
                Log("__________DATA SYSTEM FileNotFoundError!!!__________")
                Log("")
                dataSystemState = False

            # This exception should only happen if Orsell messed something up :)
            # This seems to be get executed along side the FileNotFoundError exception, thats not suppose to happen and it needs to be fixed
            except:
                Log("")
                Log("__________DATA SYSTEM ERROR!!!__________")
                Log("An unknown error that hasn't been accounted for in the development of this script has occured...")
                Log("This error has to do with the data system so please ping Orsell (aka zwexit) in #mod-help in our discord.")
                Log("He must have messed up something if this appears.")
                Log("To make sure nothing else fricks up the data system will be disabled...")
                Log("Below is the exception that resulted in this nonsense:\n" + traceback.format_exc())
                Log("__________DATA SYSTEM ERROR!!!__________")
                Log("")
                dataSystemState = False
            finally:
                if refresh == True:
                    DSLogging("Data system has finished refreshing...", dsdebug, started)
                    DSLogging("__________Data System Refreshing End__________", dsdebug, started)
                else:
                    DSLogging("Data system has finished initalizing...", dsdebug, started)
                    Log("__________Data System Initialization End__________")

# Need to rework this function:
# Instead of just detecting errors, this needs to detect and fix the errors without making a new file.
# This will allow the other items that aren't in the file by default to stay intact.
# If the file is truely messed up and the python cant interact with it properly it will be reset to default.
def masterDataFileStructureCheck(configsPath) -> None:
    DSLogging("Performing masterDataFile structure check...", dsdebug, started)
    if os.path.getsize(configsPath) == 0:
        DSLogging("File blank, adding masterDataFile structure...", dsdebug, started)
        json.dump(defaultDataStructure, configsPath, indent=4)

    # grabbedMasterData = open(configsPath, "r", encoding="utf-8").read().strip()
    # masterDataFile = json.loads(grabbedMasterData)

    # dataFileKeys = masterDataFile.keys()
    # #dateFileKeyValues = dataFileKeys[key]
    # errors = 0
    # # Validate all the categories in presetCategories are correct in the masterDataFile file
    # for keys in masterDataFile:
    #     if keys not in presetKeys:
    #         Log(f"DS: The category [{key}] is invalid, removing it...")
    #         dataFileKeys.pop(key)
    #         errors +=1

    # # Validate all the keys in mapKeys for each are correct in the masterDataFile file
    # #for values in dataFileKeys[key]:
    #     #if value not in mapValues:
    #         #if dataFile[key][values] != defaultDataStructure[key][values]:
    #             #Log(f"DS: The value for [{key}][{values}] is invalid, fixing it...")
    #             #dataFile[key][values] = defaultDataStructure[key][values]
    #             #errors +=1

    # # Validate all the categories in presetCategories exist in the masterDataFile file
    # for key in defaultDataStructure.keys():
    #     if key not in dataFileKeys:
    #         Log(f"DS: The category [{key}] is missing, readding it...")
    #         dataFileKeys[key] = defaultDataStructure[key]
    #         errors +=1

    # # Validate
    # #for key in DefaultConfigFile:
    #     #for property in DefaultConfigFile[key]:
    #         #if property not in config[key]:
    #             #Log(f"The value for [{key}][{property}] is missing, fixing it...")
    #             #config[key][property] = DefaultConfigFile[key][property]
    #             #errors +=1

    # if errors > 0:
    #     Log(f"DS: There are errors, {errors} error(s) was detected.")
    #     #Log("DS: There are errors, need to wipe the masterDataFile and make a new one...")
    #     #createNewMasterData()
    # Log("DS: Structure check successfully performed!")

def createNewMasterData() -> None:
    currentMasterData = (GVars.configsPath + GVars.nf + "masterData.cfg")
    try:
        os.remove(currentMasterData)
    except Exception as e:
        DSLogging(f"The masterDataFile file was already removed or some other error occured: {str(e)}", dsdebug, started)

    newMasterDataFile = open(GVars.configsPath + GVars.nf + "masterData.cfg", "w+", encoding="utf-8")
    json.dump(defaultDataStructure, newMasterDataFile, indent=4)

    if os.path.exists(GVars.modPath + GVars.nf + "masterData.cfg"):
        DSLogging("DS: New masterData.cfg created in p2mm directory...", dsdebug, started)
    else:
        raise masterDataFileCreationError

def updatePassword(newpassword: str) -> bool:
    try:
        if firstStart or (GVars.configData["Portal2-Path"]["value"] == "undefined"):
            return
        if newpassword == None:
            newpassword = serverPassword
        with open(dsSavesPath + GVars.nf + "datasystem-setpassword.nut", "w", encoding="utf-8") as passwordfile:
            passwordfile.write(f"New_Password <- \"{newpassword}\"")
            passwordfile.close()
        # with open(locallscfg, "w", encoding="utf-8") as listencfg:
        #     #print("adding to local listenserver cfg")
        #     listencfg.close()
        # with open(localscfg, "w", encoding="utf-8") as servercfg:
        #     #print("adding to local server cfg")
        #     servercfg.close()
        checkfile = open(dsSavesPath + GVars.nf + "datasystem-datacheck.nut", "x", encoding="utf-8")
        checkfile.close()
        Log("DS: Previous Password: " + GVars.configData["Server-Password"]["value"])
        cfg.EditConfig("Server-Password", newpassword)
        Log("DS: New Password: " + GVars.configData["Server-Password"]["value"])
        return True
    except FileExistsError:
        pass
    except Exception as error:
        Log("DS: Failed to update password, exception:\n" + traceback.format_exc())
        return False

# Goes through all the configs the Data System
# checking and performing actions to correct any if necessary
def configCheck() -> str:
    returns: list = []
    # These characters can screw up the system or cause execution of other commands on the server
    disallowedpasswordchars: list = ["\\", ";", "\'"]
    DSLogging("Checking configs...", dsdebug, started)

    # if (not dataSystemState) or (not GVars.configData["Data-System-Overide"]["value"]):
    #     return "false"
    
    # Password config check
    
    DSLogging("Current Password: " + serverPassword, dsdebug, started)
    disallowedcharfound = False
    
    if any(disallowedchar in serverPassword for disallowedchar in disallowedpasswordchars):
        DSLogging(f"Found disallowed characters in password: \"{disallowedchar}\"! Fixing!", dsdebug, started)
        fixedpassword = serverPassword.replace(disallowedchar, "")
        if not updatePassword(fixedpassword):
            Log("__________DATA SYSTEM ERROR!!!__________")
            Log("The Data System couldn't correct the password!")
            Log("This is problem with the Data System and needs to fixed!")
            Log("Please contact Orsell (aka zwexit) in our Discord!")
            Log("He messed up something and need to fix it!")
            Log("__________DATA SYSTEM ERROR!!!__________")
            returns.append("passwordcorrectionerror")
        else:
            returns.append("passwordcorrected")
    else:
        if not updatePassword(serverPassword):
            returns.append("passwordupdateerror")
    DSLogging("Finished checking configs...", dsdebug, started)
    return returns

# Called to check for any screen shot indicators
#def dataSystemIndicatorCheck() -> None:

# Cleans up any screenshot indicators after being read
#def returnCleanUp() -> None:

def cleanUpFolders() -> None:
    Log("DS: Removing Data System folders and files...")
    if os.path.exists(dsSavesPath):
        BF.DeleteFolder(dsSavesPath)
    
    Log("DS: Checking for any old screenshot file indicators left over...")
    if (not GVars.configData["Portal2-Path"]["value"] == "undefined") and (os.path.exists(ssFilesPath)):
        if not os.listdir(ssFilesPath) == []:
            Log("DS: Found screenshot files, determining if they belong to the DS and removing them...")
            for dataSystemIndicator in os.listdir(ssFilesPath):
                if dataSystemIndicator.startswith("datasystem-"):
                    os.remove(ssFilesPath + GVars.nf + dataSystemIndicator)
                    Log("DS: Removed old screenshot file indicator " + dataSystemIndicator + "...")
    Log("DS: Finished checking for any old screenshot file indicators...")

# All the custom exceptions are defined here
class firstStartWarning(Warning):
    def __init__(self):
        Log("")
        Log("__________Warning: DATA SYSTEM firstStartWarning__________")
        Log("The ModFiles folder has not been found.")
        Log("We are assuming that this is the first time someone has launched the launcher.")
        Log("This folder is required for the data system to make its start check.")
        Log("The data system will start disabled but should be fixed when the launcher is updated...")
        Log("__________Warning: DATA SYSTEM firstStartWarning__________")
        Log("")
        dataSystemState = False
        firstStart = True

class masterDataFileCreationError(Exception):
    def __init__(self):
        Log("")
        Log("__________ERROR: DATA SYSTEM masterDataFileCreationError!!!__________")
        Log("masterDataFile.json couldn't be created! The data system can't read and write data data without this file!")
        Log("Try and manually create this file in the p2mm directory if this keeps failing...")
        Log("Launcher will continue but the data system will be disabled for the next play session or until a refresh confirms that the system is working...")
        Log("Below is the exception that resulted in this nonsense:\n" + traceback.format_exc())
        Log("__________ERROR: DATA SYSTEM masterDataFileCreationError!!!__________")
        Log("")
        dataSystemState = False

class dataSystemNutNotFoundError(Exception):
    def __init__(self):
        Log("")
        Log("__________ERROR: DATA SYSTEM dataSystemNutNotError!!!__________")
        Log("The datasystem-main.nut file has not been found in the ModFiles! The data system can't work without it!")
        Log("Try to update or reinstall the launcher if you recieve this, the file will be retrieved again...")
        Log("Launcher will continue but the data system will be disabled for the next play session...")
        Log("Below is the exception that resulted in this nonsense:\n" + traceback.format_exc())
        Log("__________ERROR: DATA SYSTEM dataSystemNutNotError!!!__________")
        Log("")
        dataSystemState = False