import json
import os
import sys
import traceback

import Scripts.BasicFunctions as BF
import Scripts.Configs as cfg
import Scripts.GlobalVariables as GVars
from Scripts.BasicLogger import Log

# Save System Terminology:
# Enabled: The save system has started successfully on the python scripts end
# Disabled: The save system didn't start successfully on the python scripts end
# Running: By default the save system is set to run with every play session, there is a option in the hidden menu that devs can use to disable it for testing purposes
# Not Running: The user has defined in the hidden menu setting they do not want the save system to run next play session or the system is disabled by a error which occured

# Verification Statuses:
# The point of these statuses is to tell users in the Saves menu the kind of compatibility it is with the p2mm mod
# Offical: This is an official map by Valve or by a p2mm dev member, it has been made or designed to work with p2mm and has been approved by someone on the p2mm dev team. No one outside the p2mm dev team should have status with a map they created.
# Verified: The map has been tested and verified by a p2mm dev to work with the p2mm mod.
# Playable: The map can be run with multiple players, but the map still has issues in certain parts or functionalities. Players should be able to complete the map from start to finish. Mainly minor bugs or glitches put it into this state until they have been resolved.
# Unplayable: A map can be marked with this if the p2mm breaks the map entirely, making it unplayable with the mod, or the map itself can not function as intended with more than the initial amount of players used to test the map.
# Not Tested: The map has yet to be tested by a p2mm dev. We can not guarantee this means the map will work.

# This is the default masterSave.cfg structure
# Will we use this to check if the file is formatted correctly and if a new one needs to be created
defaultSaveStructure = {
        "officalp2maps": { # Might remove this later if we don't need it

        },
        "officalp2mmmaps": {
            "Test Room": { # This will be removed later when what ever update involving this system is released
                "verificationStatus": "offical",
                "mapFileName": "mp_coop_testroom.bsp",
                "mapsupportFile": "mp_coop_testroom.nut",
                "data": {
                    "testdatasend": "notsent",
                    "testdatarecieved": "notsent"
                }
            }
        },
        "verifiedp2mmmaps": {

        },
        "unverifiedp2mmmaps": {

        }
}

presetCatagories = {"officalp2maps", "officalp2mmmaps", "verifiedp2mmmaps", "unverifiedp2mmmaps"}
mapKeys = {"verificationStatus", "mapFileName", "mapsupportFile", "data"}
saveSystemState: bool = True

def masterSaveStructureCheck(masterSavePath) -> None:
    Log("SS: Performing masterSave structure check...")
    if os.path.getsize(masterSavePath) == 0:
        Log("SS: File blank, adding masterSave structure...")
        json.dump(defaultSaveStructure, masterSavePath, indent=4)

    grabbedMasterSave = open(masterSavePath, "r", encoding="utf-8").read().strip()
    masterSave = json.loads(grabbedMasterSave)

    saveFile = masterSave.keys()
    errors = 0
    # Validate all the categories in presetCategories are correct in the masterSave file
    for category in saveFile:
        if category not in presetCatagories:
            Log(f"SS: The category [{category}] is invalid, removing it...")
            saveFile.pop(category)
            errors +=1

    # Validate all the keys in mapKeys for each are correct in the masterSave file
    #for property in saveFile[category]:
        # if property not in mapKeys:
            #if saveFile[category][property] != defaultSaveStructure[category][property]:
                #Log(f"SS: The value for [{category}][{property}] is invalid, fixing it...")
                #saveFile[category][property] = defaultSaveStructure[category][property]
                #errors +=1

    # Validate all the categories in presetCategories exist in the masterSave file
    for category in defaultSaveStructure.keys():
        if category not in saveFile:
            Log(f"The category [{category}] is missing, readding it...")
            saveFile[category] = defaultSaveStructure[category]
            errors +=1

    # Validate
    #for key in DefaultConfigFile:
        #for property in DefaultConfigFile[key]:
            #if property not in config[key]:
                #Log(f"The value for [{key}][{property}] is missing, fixing it...")
                #config[key][property] = DefaultConfigFile[key][property]
                #errors +=1

    if errors > 0:
        Log("SS: There are errors, we need to wipe the masterSave and make a new one...")
        createNewMasterSave()
    Log("SS: Structure check successfully performed!")

def createNewMasterSave() -> None:
    currentMasterSave = (GVars.configPath + "\masterSave.cfg")
    try:
        os.remove(currentMasterSave)
    except Exception as e:
        Log(f"The masterSave file already remove? {str(e)}")

    newMasterSave = open(GVars.configPath + GVars.nf + "masterSave.cfg", "w+", encoding="utf-8")
    json.dump(defaultSaveStructure, newMasterSave, indent=4)

    if os.path.exists(GVars.modPath + "\masterSave.cfg"):
        Log("SS: New masterSave.cfg created in p2mm directory...")
    else:
        raise masterSaveCreationError

# This is our initialization function for the system, it will also act as the refresh function when the system requires a refresh
def saveSystemInitialization(refresh: bool) -> None:
    global saveSystemState
    saveSystemState = False
    try:
        Log("")
        if refresh == True:
            Log("            __________Save System Refresh Start__________")
            Log("SS: Refreshing the save system...")
        else:
            Log("            __________Save System Initialization Start__________")
            Log("SS: Initalizing the save system...")

        # We first need to check if the p2mm folder has been created
        # Normally it should exist, but in the wacky case something screws up and the previous scripts don't catch it, this will be a fail safe
        Log("SS: Checking file system integrity...")
        if not os.path.exists(GVars.modPath):
            raise fatalInitError

        # Next we check if the ModFiles are there
        # If they aren't we will assue that this is the first time the person has started the launcher
        # Once the launcher is updated the refreshSaveSystem function will run
        if not os.path.exists(GVars.modFilesPath):
            raise firstStartWarning
        Log("SS: File system is good...")

        # We need to remove any old .nut files that tell the save system if it started or not
        Log("SS: Removing any old .nut file indicators...")
        if os.path.exists(GVars.saveSystemPath + "\savesystem-enabled.nut"):
            os.remove(GVars.saveSystemPath + "\savesystem-enabled.nut")
        if os.path.exists(GVars.saveSystemPath + "\savesystem-disabled.nut"):
            os.remove(GVars.saveSystemPath + "\savesystem-disabled.nut")
        Log("SS: Removed old .nut file indicators...")

        # If the masterSave config file doesn't exist, we will ensure that a new fresh one is created
        Log("SS: Checking our masterSave.cfg file...")
        if (not os.path.exists(GVars.configPath + GVars.nf + "masterSave.cfg")) or (os.path.getsize(GVars.configPath + GVars.nf + "masterSave.cfg") == 0):
            Log("SS: No masterSave.cfg detected, creating a new one...")
            createNewMasterSave()
        else:
            Log("SS: masterSave.cfg retrieved!")
            masterSavePath = (GVars.configPath + GVars.nf + "masterSave.cfg")
            masterSaveStructureCheck(masterSavePath)

        # Now finally need to check if the savesystem-main.nut file exists, this should be downloaded when the launcher updates
        # If it's not there the system will not be able to communicate with Portal 2 and vice versa, the system will be disabled
        Log("SS: Checking on our main save system Squirrel file...")
        if not os.path.exists(GVars.saveSystemPath + GVars.nf + "savesystem-main.nut"):
            raise saveSystemNutNotFoundError
        else:
            Log("SS: Our Squirrel file exists!")


    # If some miscelanous or unaccounted for error occurs this will throw, Orsell fricked up something too if this happens :)
    except Exception as e:
        Log("")
        Log("            __________SAVE SYSTEM ERROR!!!__________")
        Log("An unknown error that hasn't been accounted for in the development of this script has occured...")
        Log("This error has to do with the save system so please ping Orsell (aka zwexit\) in #mod-help in our discord.")
        Log("He must have fricked up something if this appears.")
        Log("To make sure nothing else fricks up the save system will be disabled...")
        Log("Below is the exception that resulted in this nonsense:\n" + traceback.format_exc())
        Log("            __________SAVE SYSTEM ERROR!!!__________")
        Log("")
        saveSystemState = False

    # This will run only if the save system sucessfully initilized
    else:
        if refresh == True:
            Log("SS: The save system has refreshed sucessfully!")
        else:
            Log("SS: The save system has started sucessfully!")
        Log("SS: The system will be enabled for the next play session...")
        saveSystemState = True

    # Now we clean up the system and create the files needed for the savesystem-main.nut file to read when its called on later when a map loads
    finally:
        try:
            if (saveSystemState == True):
                with open(GVars.saveSystemPath + "\savesystem-enabled.nut", "x") as saveSystemInitSuccess:
                    saveSystemInitSuccess.write('printl("The save system started successfully!")')
                    saveSystemInitSuccess.close()
            else:
                with open(GVars.saveSystemPath + "\savesystem-disabled.nut", "x") as saveSystemInitFail:
                    saveSystemInitFail.write('printl("The save system did not start successfully...")')
                    saveSystemInitFail.close()
                Log("SS: The save system encountered an error and it can't be enabled!")
                Log("SS: The system will be disabled for the next play session...")

                saveSystemState = False

        # This exception should only occur is either the p2mm or Modfiles folder wasn't found
        except FileNotFoundError:
            Log("")
            Log("            __________SAVE SYSTEM FileNotFoundError!!!__________")
            Log("The save system encountered an error and it can't be enabled!")
            Log("This was caused because either the p2mm or ModFiles folder wasn't found.")
            Log("The system will be disabled for the next play session...")
            Log("Below is the exception that resulted in this nonsense:\n" + traceback.format_exc())
            Log("            __________SAVE SYSTEM FileNotFoundError!!!__________")
            Log("")
            saveSystemState = False

        # This exception should only happen if Orsell fricked something up :)
        except:
            Log("")
            Log("            __________SAVE SYSTEM ERROR!!!__________")
            Log("An unknown error that hasn't been accounted for in the development of this script has occured...")
            Log("This error has to do with the save system so please ping Orsell (aka zwexit\) in #mod-help in our discord.")
            Log("He must have fricked up something if this appears.")
            Log("To make sure nothing else fricks up the save system will be disabled...")
            Log("Below is the exception that resulted in this nonsense:\n" + traceback.format_exc())
            Log("            __________SAVE SYSTEM ERROR!!!__________")
            Log("")
            saveSystemState = False
        finally:
            if refresh == True:
                Log("SS: Save system has finished refreshing...")
                Log("            __________Save System Refreshing End__________")
            else:
                Log("SS: Save system has finished initalizing...")
                Log("            __________Save System Initialization End__________")
            Log("")
            # We will enable the saveSystemChecker so it will be ready to read any .dem files Portal 2
            # In the case saveSystemState is False, saveSystemChecker will wait to be enabled again when the system refreshes
            saveSystemChecker()

def saveSystemChecker():
    Log("")

# All the custom exceptions are defined here
class p2mmNotFoundError(Exception):
    def __init__(self):
        Log("")
        Log("            __________!!!FATAL: SAVE SYSTEM p2mmNotFoundError!!!__________")
        Log("FATAL SAVE SYSTEM ERROR!!! The main p2mm directory couldn't be found!")
        Log("This shouldn't happen at all! If this happens again please reinstall the mod!")
        Log("If the issue persists then please let us know in our discord!")
        Log("This error has to do with the save system so please ping Orsell (aka zwexit\) in #mod-help in our discord.")
        Log("He must have fricked up something if this appears. Like this shouldn't be possible.")
        Log("The launcher has been stopped...")
        Log("Below is the exception that resulted in this nonsense:\n" + traceback.format_exc())
        Log("            __________!!!FATAL: SAVE SYSTEM p2mmNotFoundError!!!__________")
        Log("")
        saveSystemState = False
        quit()

class firstStartError(Exception):
    def __init__(self):
        Log("")
        Log("            __________Warning: SAVE SYSTEM firstStartWarning__________")
        Log("The ModFiles folder has not been found.")
        Log("We are assuming that this is the first time someone has launched the launcher.")
        Log("This folder is required for the save system to make its start check.")
        Log("The save system will start disabled but should be fixed when the launcher is updated...")
        Log("            __________Warning: SAVE SYSTEM firstStartWarning__________")
        Log("")
        saveSystemState = False

class masterSaveCreationError(Exception):
    def __init__(self):
        Log("")
        Log("            __________ERROR: SAVE SYSTEM masterSaveCreationError!!!__________")
        Log("masterSave.json couldn't be created! The save system can't read and write save data without this file!")
        Log("Try and manually create this file in the p2mm directory if this keeps failing...")
        Log("Launcher will continue but the save system will be disabled for the next play session or until a refresh confirms that the system is working...")
        Log("Below is the exception that resulted in this nonsense:\n" + traceback.format_exc())
        Log("            __________ERROR: SAVE SYSTEM masterSaveCreationError!!!__________")
        Log("")
        saveSystemState = False

class saveSystemNutNotFoundError(Exception):
    def __init__(self):
        Log("")
        Log("            __________ERROR: SAVE SYSTEM saveSystemNutNotError!!!__________")
        Log("The savesystem-main.nut file has not been found in the ModFiles! The save system can't work without it!")
        Log("Try to update or reinstall the launcher if you recieve this, the file will be retrieved again...")
        Log("Launcher will continue but the save system will be disabled for the next play session...")
        Log("Below is the exception that resulted in this nonsense:\n" + traceback.format_exc())
        Log("            __________ERROR: SAVE SYSTEM saveSystemNutNotError!!!__________")
        Log("")
        saveSystemState = False