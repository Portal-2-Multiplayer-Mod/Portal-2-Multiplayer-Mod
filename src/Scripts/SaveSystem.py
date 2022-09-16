import json
import os
import sys

import Scripts.Configs as cfg
import Scripts.GlobalVariables as GVars
import Scripts.BasicFunctions as BF
from Scripts.BasicLogger import Log

saveSystemEnabled: str

defaultSaveStructure = {
        "saveCheckTest": {
            "canWeRead?": "Yes we can!"
        },

        "officalp2maps": {

        },

        "officalp2mmmaps": {

        },

        "verifiedp2mmmaps": {

        },

        "unverifiedp2mmmaps": {

        }
    }

def init() -> None:
    global saveSystemEnabled
    Log("Startng the save system...")
    if not os.path.exists(GVars.modPath + "/masterSave.json"):
        Log("No masterSave detected, creating a new one...")
        with open(GVars.modPath + "/masterSave.json", "w") as masterSave:
            defaultStructure = json.dumps(defaultSaveStructure, indent=4)
            masterSave.write(defaultStructure)
            if os.path.exists(GVars.modPath + "/masterSave.json"):
                Log("New masterSave created in p2mm directory...")
                saveSystemInitContinue = True
            else:
                Log("")
                Log("ERROR! masterSave.json couldn't be created! The save system can't read and write save data without this file!")
                Log("Try and manually create this file in the p2mm directory if this keeps failing...")
                Log("Launcher will continue but the saveSystem will not be avaliable for the next play session...")
                Log("")
                saveSystemEnabled = translations["save-disabled"]
                saveSystemInitContinue = False
            masterSave.close()
    else:
        Log("masterSave retrieved!")

    # We must check that the savesystem-main.nut files exists
    # Without it it won't be transfered to the game and the SaveSystem can't communicate with the map
    Log("Checking on our main save system Squirrel file...")
    if (saveSystemContinue):
        if not os.path.exists(GVars.saveSystemNutPath + "/savesystem-main.nut"):
            Log("")
            Log("ERROR! The savesystem-main.nut file has not been found in the modfiles! The save system can't work without it!")
            Log("Try to update the launcher if you recieve this, file will be retrieved again...")
            Log("Launcher will continue but the saveSystem will not be avaliable for the next play session...")
            Log("")
            saveSystemEnabled = translations["save-disabled"]
            saveSystemInitContinue = False
        else:
            saveSystemEnabled = translations["save-enabled"]
            saveSystemInitContinue = True

    if (saveSystemContinue):
        with open(GVars.saveSystemNutPath + "/savesystem-running.nut") as saveSystemInitSuccess:
            saveSystemInitSuccess.write("printl('The save system started successfully!')")
            saveSystemInitSuccess.close()
    else:
        s
    Log("Save system has finished initalizing...")






