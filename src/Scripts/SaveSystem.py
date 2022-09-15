import json
import os
import sys

import Scripts.Configs as cfg
import Scripts.GlobalVariables as GVars
import Scripts.BasicFunctions as BF
from Scripts.BasicLogger import Log

defaultStructure = """
{
    "mapsaves": {
        "mp_coop_testroom": {
            "doorstate": "stuff"
        }
    }
}
"""

def init() -> bool:
    Log("Startng the save system...")
    if not os.path.exists(GVars.modPath + "/masterSave.json"):
        Log("No masterSave detected, creating a new one...")
        with open(GVars.modPath + "masterSave.json", "w") as masterSave:
            json.dump(defaultStructure, masterSave)
            if os.path.exists(GVars.modPath + "masterSave.json"):
                Log("New masterSave created in p2mm directory...")
            else:
                Log("Error! masterSave.json couldn't be created!")
    else:
        Log("masterSave retrieved!")
    # We must check that the savesystem-main.nut files exists
    # Without it it won't be transfered to the game and the SaveSystem can't operate
    #Log("Checking on our Squirrel file...")
    #if not os.path.exists(GVars.saveSystemNutPath):
    #    Log("FATAL! The savesystem-main.nut file has not been found in the modfiles!")
    #    Log("")





