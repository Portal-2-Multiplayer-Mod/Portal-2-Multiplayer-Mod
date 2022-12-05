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
# Will we use this to check if the file is formatted correctly and if a new one needs to be created
defaultDataStructure = {
    "kicklist":[], # The kick list is a list that will be reset for every play session
    "banlist":[], # The ban list is a list that will persist every play session

    "Test Room": { # This will be removed later when what ever update involving this system is released
        "verificationStatus": "offical", # The maps status in the system
        "mapFileName": "mp_coop_testroom", # Specify the map bsp file
        "mapsupportFile": "mp_coop_testroom", # Soecify the map support file if there is one
        "data": {
            "testdatasend": "notsent",
            "testdatarecieved": "notsent"
        }
    },

    "P2MM Lobby": {
        "verificationStatus": "offical",
        "mapFileName": "mp_coop_p2mmlobby",
        "mapsupportFile": "mp_coop_p2mmlobby",
        "data": {
            "introseq": "false"
        }
    }
}

presetKeys = {"kicklist", "banlist", "officalp2mmmaps", "verifiedp2mmmaps", "unverifiedp2mmmaps"}
mapValues = {"verificationStatus", "mapFileName", "mapSupportFile", "data"}
dataSystemState: bool = True
# ssFilesPath: str = GVars.configData["Portal2-Path"]["value"] + GVars.nf + "screenshots"

# Need to rework this function:
# Instead of just detecting errors, this needs to detect and fix the errors without making a new file.
# This will allow the other items that aren't in the file my default to stay intact.
def masterDataFileStructureCheck(configsPath) -> None:
    Log("DS: Performing masterDataFile structure check...")
    if os.path.getsize(configsPath) == 0:
        Log("DS: File blank, adding masterDataFile structure...")
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
    #     #Log("DS: There are errors, we need to wipe the masterDataFile and make a new one...")
    #     #createNewMasterData()
    # Log("DS: Structure check successfully performed!")

def createNewMasterData() -> None:
    currentMasterData = (GVars.configsPath + "\masterData.cfg")
    try:
        os.remove(currentMasterData)
    except Exception as e:
        Log(f"The masterDataFile file was already removed or some other error occured: {str(e)}")

    newMasterDataFile = open(GVars.configsPath + GVars.nf + "masterData.cfg", "w+", encoding="utf-8")
    json.dump(defaultDataStructure, newMasterDataFile, indent=4)

    if os.path.exists(GVars.modPath + GVars.nf + "masterData.cfg"):
        Log("DS: New masterData.cfg created in p2mm directory...")
    else:
        raise masterDataFileCreationError

# This is our initialization function for the system, it will also act as the refresh function when the system requires a refresh
def dataSystemInitialization(refresh: bool) -> None:
    global dataSystemState
    dataSystemState = False
    firstStart = False
    try:
        Log("")
        if refresh == True:
            Log("            __________Data System Refresh Start__________")
            Log("DS: Refreshing the data system...")
        else:
            Log("            __________Data System Initialization Start__________")
            Log("DS: Initalizing the data system...")

        # We first need to check if the p2mm folder has been created
        # Normally it should exist, but in the wacky case something screws up and the previous scripts don't catch it, this will be a fail safe
        Log("DS: Checking file system integrity...")
        if not os.path.exists(GVars.modPath):
            raise fatalInitError

        # Next we check if the ModFiles are there
        # If they aren't we will assue that this is the first time the person has started the launcher
        # Once the launcher is updated the refreshDataSystem function will run
        if not os.path.exists(GVars.modFilesPath):
            raise firstStartWarning
        Log("DS: File system is good...")

        if not os.path.exists(GVars.p2mmScriptsPath + GVars.nf + "datasystemsaves"):
            os.makedirs(GVars.p2mmScriptsPath + GVars.nf + "datasystemsaves")
        print(os.path.exists(GVars.p2mmScriptsPath + GVars.nf + "datasystemsaves"))
        # We need to remove any old .nut files that tell the data system if it started or not
        Log("DS: Checking for any old .nut file indicators...")
        if not os.listdir(GVars.p2mmScriptsPath + GVars.nf + "datasystemsaves") == []:
            Log("DS: Found old .nut file indicators, removing...")
            for dataSystemIndicator in os.listdir(GVars.p2mmScriptsPath + GVars.nf + "datasystemsaves"):
                os.remove(GVars.p2mmScriptsPath + GVars.nf + "datasystemsaves" + GVars.nf + dataSystemIndicator)
            Log("DS: Removed old .nut file indicators...")
        Log("DS: Finished checking for any old .nut file indicators")

        # If the masterDataFile config file doesn't exist, we will ensure that a new fresh one is created
        Log("DS: Checking our masterData.cfg file...")
        if (not os.path.exists(GVars.configsPath + GVars.nf + "masterData.cfg")) or (os.path.getsize(GVars.configsPath + GVars.nf + "masterData.cfg") == 0):
            Log("DS: No masterData.cfg detected, creating a new one...")
            createNewMasterData()
        else:
            Log("DS: masterData.cfg retrieved...")
            configsPath = (GVars.configsPath + GVars.nf + "masterData.cfg")
            masterDataFileStructureCheck(configsPath)

        # Now finally need to check if the datasystem-main.nut file exists, this should be downloaded when the launcher updates
        # If it's not there the system will not be able to communicate with Portal 2 and vice versa, the system will be disabled
        Log("DS: Checking on our main data system Squirrel file...")
        if not os.path.exists(GVars.p2mmScriptsPath + GVars.nf + "datasystem.nut"):
            raise dataSystemNutNotFoundError
        else:
            Log("DS: Our Squirrel file exists...")

    # If some miscelanous or unaccounted for error occurs this will throw, Orsell fricked up something too if this happens :)
    # This for some reason this is getting executed along with the other exceptions, thats not suppose to happen and it needs to be fixed
    except Exception:
        Log("")
        Log("            __________DATA SYSTEM ERROR!!!__________")
        Log("An unknown error that hasn't been accounted for in the development of this script has occured...")
        Log("This error has to do with the data system so please ping Orsell (aka zwexit) in #mod-help in our discord.")
        Log("He must have fricked up something if this appears.")
        Log("To make sure nothing else errors the data system will be disabled...")
        Log("Below is the exception that resulted in this nonsense:\n" + traceback.format_exc())
        Log("            __________DATA SYSTEM ERROR!!!__________")
        Log("")
        dataSystemState = False

    # This will run only if the data system sucessfully initilized
    else:
        if refresh == True:
            Log("DS: The data system has refreshed sucessfully!")
        else:
            Log("DS: The data system has started sucessfully!")
        Log("DS: The system will be enabled for the next play session...")
        dataSystemState = True

    # Now we clean up the system and create the files needed for the datasystem-main.nut file to read when its called on later when a map loads
    finally:
        try:
            if (dataSystemState == True) and (firstStart == False) and (GVars.configData["(WIP)Data-System-Overide"]["value"] == "true"):
                dataSystemInitSuccess = open(GVars.p2mmScriptsPath + GVars.nf + "datasystemsaves" + GVars.nf + "datasystem-enabled.nut", "x")
            elif (dataSystemState == False) and (firstStart == True):
                Log("This is the launchers first start, will not be creating datasystem nut indicator...")
            elif (dataSystemState == False) and (firstStart == False):
                dataSystemInitFail = open(GVars.p2mmScriptsPath + GVars.nf + "datasystemsaves" + GVars.nf + "datasystem-disabled.nut", "x")
                Log("DS: The data system encountered an error and it can't be enabled! Or it has been disabled in the Dev Menu.")
                Log("DS: The system will be disabled for the next play session...")

        # This exception should only occur if either the p2mm or Modfiles folder wasn't found
        except FileNotFoundError:
            Log("")
            Log("            __________DATA SYSTEM FileNotFoundError!!!__________")
            Log("The data system encountered an error and it can't be enabled!")
            Log("This was caused because either the p2mm or ModFiles folder wasn't found.")
            Log("The system will be disabled for the next play session...")
            Log("Below is the exception that resulted in this nonsense:\n" + traceback.format_exc())
            Log("            __________DATA SYSTEM FileNotFoundError!!!__________")
            Log("")
            dataSystemState = False

        # This exception should only happen if Orsell fricked something up :)
        # This seems to be get executed along side the FileNotFoundError exception, thats not suppose to happen and it needs to be fixed
        except:
            Log("")
            Log("            __________DATA SYSTEM ERROR!!!__________")
            Log("An unknown error that hasn't been accounted for in the development of this script has occured...")
            Log("This error has to do with the data system so please ping Orsell (aka zwexit) in #mod-help in our discord.")
            Log("He must have fricked up something if this appears.")
            Log("To make sure nothing else fricks up the data system will be disabled...")
            Log("Below is the exception that resulted in this nonsense:\n" + traceback.format_exc())
            Log("            __________DATA SYSTEM ERROR!!!__________")
            Log("")
            dataSystemState = False
        finally:
            if refresh == True:
                Log("DS: Data system has finished refreshing...")
                Log("            __________Data System Refreshing End__________")
            else:
                Log("DS: Data system has finished initalizing...")
                Log("            __________Data System Initialization End__________")
            Log("")
            # We will enable the dataSystemChecker so it will be ready to read any .dem files Portal 2
            # In the case dataSystemState is False, dataSystemChecker will wait to be enabled again when the system refreshes
            # dataSystemChecker()

# This is the checker that is started when the launcher confirms that the Data System is ready to go
# It will check for updates from the files Portal 2 will create read the name of the file then run the function that corresponds with the file
def dataSystemChecker():
    Log("DS: Data System Checker has been enabled...")
    while dataSystemState:
        if os.path.exists(gamepath + GVars.nf + "screenshots"):
            demdatas = os.listdir(demdataspath)
            for datasystemdems in demdatas:
                print(datasystemdems)
                demcount += 1
            print(demcount)

def setPassword(password) -> bool:
    if (dataSystemState == True) and (GVars.configData["(WIP)Data-System-Overide"]["value"] == "true"):
        passwordfile = open(GVars.p2mmScriptsPath + GVars.nf + "datasystem-setpassword-" + password + ".nut", )
    else:
        Button_OK = Gui.ButtonTemplate(
            translations["error_ok"], YesInput, (75, 200, 75))
        Gui.PopupBox("The Data System is currently disabled due to an error or has been disabled manually.\nPlease refresh using the 'Refresh Data System' button for the system to refresh then try again.", Button_OK)

def checkConfigChange():
    print("checking config")

# All the custom exceptions are defined here
class p2mmNotFoundError(Exception):
    def __init__(self):
        Log("")
        Log("            __________!!!FATAL: DATA SYSTEM p2mmNotFoundError!!!__________")
        Log("FATAL DATA SYSTEM ERROR!!! The main p2mm directory couldn't be found!")
        Log("This shouldn't happen at all! If this happens again please reinstall the mod!")
        Log("If the issue persists then please let us know in our discord!")
        Log("This error has to do with the data system so please ping Orsell (aka zwexit) in #mod-help in our discord.")
        Log("He must have fricked up something if this appears. Like this shouldn't be possible.")
        Log("The launcher will be stopped...")
        Log("Below is the exception that resulted in this nonsense:\n" + traceback.format_exc())
        Log("            __________!!!FATAL: DATA SYSTEM p2mmNotFoundError!!!__________")
        Log("")
        dataSystemState = False
        quit()

class firstStartWarning(Warning):
    def __init__(self):
        Log("")
        Log("            __________Warning: DATA SYSTEM firstStartWarning__________")
        Log("The ModFiles folder has not been found.")
        Log("We are assuming that this is the first time someone has launched the launcher.")
        Log("This folder is required for the data system to make its start check.")
        Log("The data system will start disabled but should be fixed when the launcher is updated...")
        Log("            __________Warning: DATA SYSTEM firstStartWarning__________")
        Log("")
        dataSystemState = False
        firstStart = True

class masterDataFileCreationError(Exception):
    def __init__(self):
        Log("")
        Log("            __________ERROR: DATA SYSTEM masterDataFileCreationError!!!__________")
        Log("masterDataFile.json couldn't be created! The data system can't read and write data data without this file!")
        Log("Try and manually create this file in the p2mm directory if this keeps failing...")
        Log("Launcher will continue but the data system will be disabled for the next play session or until a refresh confirms that the system is working...")
        Log("Below is the exception that resulted in this nonsense:\n" + traceback.format_exc())
        Log("            __________ERROR: DATA SYSTEM masterDataFileCreationError!!!__________")
        Log("")
        dataSystemState = False

class dataSystemNutNotFoundError(Exception):
    def __init__(self):
        Log("")
        Log("            __________ERROR: DATA SYSTEM dataSystemNutNotError!!!__________")
        Log("The datasystem-main.nut file has not been found in the ModFiles! The data system can't work without it!")
        Log("Try to update or reinstall the launcher if you recieve this, the file will be retrieved again...")
        Log("Launcher will continue but the data system will be disabled for the next play session...")
        Log("Below is the exception that resulted in this nonsense:\n" + traceback.format_exc())
        Log("            __________ERROR: DATA SYSTEM dataSystemNutNotError!!!__________")
        Log("")
        dataSystemState = False