import json
import os
import sys

import Scripts.Configs as cfg
import Scripts.GlobalVariables as GVars
import Scripts.BasicFunctions as BF
from Scripts.BasicLogger import Log

defaultJSONStructure = {
    "mapsaves": {
        "mp_coop_testroom": {
            "doorstate": "stuff"
        }
    }
}

def init() -> None:
    Log("Startng the save system...")
    os.chdir(GVars.masterSaveJSONPath)
    if not os.path.exists("masterSave.json"):
        with open("masterSave.json", "w+") as masterSaveJSON:
            json.dump(defaultJSONStructure, masterSaveJSON)


