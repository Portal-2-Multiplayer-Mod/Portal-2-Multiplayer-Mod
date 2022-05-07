import os
from Scripts.BasicLogger import Log
import Scripts.GlobalVariables as GVars
import ast
import json

# █▀▀ █▀█ █▄░█ █▀▀ █ █▀▀   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀
# █▄▄ █▄█ █░▀█ █▀░ █ █▄█   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █░▀░█ ██▄ █░▀█ ░█░

DefaultConfigFile = {
    "cfgvariant":
        {
            "value" : 18,
            "menu" : "hidden",
            "description" : "DO NOT CHANGE THIS NUMBER WILL AUTO-UPDATE",
            "warning" : "IF YOU CHANGE THIS NUMBER YOU MAY LOSE YOUR CONFIG FILE!",
            "prompt" : "DONT CHANGE THIS VALUE",
        },

    "portal2path":
        {
            "value" : "undefined",
            "menu" : "launcher",
            "description" : "Path to the Portal 2 Folder",
            "warning" : "",
            "prompt" : "Enter the path to the Portal 2 folder",
        },

    "developer":
        {
            "value" : "false",
            "menu" : "launcher",
            "description" : "Makes the mods files mount from src/ModFiles",
            "warning" : "",
            "prompt" : "Enable developer mode?",
        },

    "LauncherSFX":
        {
            "value" : "true",
            "menu" : "launcher",
            "description" : "Makes the buttons play sound effects",
            "warning" : "",
            "prompt" : "Enable sound effects?",
        },

    "LauncherCubes":
        {
            "value" : "true",
            "menu" : "launcher",
            "description" : "Makes cubes rain in the background",
            "warning" : "",
            "prompt" : "Enable background cubes?",
        },

    "EncryptCvars":
        {
            "value" : "false",
            "menu" : "portal2",
            "description" : "Encrypts cvars such as \"restart_level\" and \"reset_all_progress\")", 
            "warning" : "(only use for public games) may break some functionality",
            "prompt" : "Encrypt cvars?",
        },
    
    "SafeGuard":
        {
            "value" : "false",
            "menu" : "portal2",
            "description" : "Encrypts vscript functions such as \"SendToConsole(\"\")\"", 
            "warning" : "(only use for public games) may break some functionality",
            "prompt" : "Encrypt specific vscript functions?",
        },
}

ImmutableKeys = ["description", "warning", "prompt", "menu"]

# verifies the config file by making sure that the processed data has the same keys as the default 
# if it doesn't then we'll transfer the values from the local config file to the default one and write the default one
def VerifyConfigFileIntegrity(config):
    # if len(config) != len(DefaultConfigFile) or config.keys() != DefaultConfigFile.keys():
    #     DefaultCopy = DefaultConfigFile
    #     Log("Some config data is invalid, fixing it...")
    #     for key in DefaultCopy:
    #         try:
    #             DefaultCopy[key] = config[key]
    #         except:
    #             Log(f"The key [{key}] is missing from the local config file!")
    #     WriteConfigFile(DefaultCopy)
    #     return DefaultCopy

    Log("=========================")
    Log("Validating config data...")
    copiedconfig = {
        **config,
    }
    ########################### VALIDATE ALL THE KEYS ARE CORRECT
    for key1 in copiedconfig:
        if key1 not in DefaultConfigFile:
            Log(f"The key [{key1}] is invalid, fixing it...")
            config.pop(key1)
            WriteConfigFile(config)
            continue

        for key2 in config[key1]:
            # validate all the immutable values
            if key2 in ImmutableKeys:
                if config[key1][key2] != DefaultConfigFile[key1][key2]:
                    Log(f"The value for [{key1}][{key2}] is invalid, fixing it...")
                    config[key1][key2] = DefaultConfigFile[key1][key2]
                    WriteConfigFile(config)
    ########################### VALIDATE ALL THE KEYS EXIST
    for key in DefaultConfigFile:
        if key not in config:
            Log(f"The key [{key}] is missing, fixing it...")
            config[key] = DefaultConfigFile[key]
            WriteConfigFile(config)
    Log("=========================")

    # if the config keys are the same as the default then just return them
    return config

def GetConfigList(search, val):
    lst = []
    for key in GVars.configData:
        if GVars.configData[key][search] == val:
            lst.append(key)
    return lst

def WriteConfigFile(configs):
    filepath = FindConfigPath()
    # just to make sure the file doesn't exist
    try:
        os.remove(filepath)
        Log("Deleted old file")
    except Exception as e:
        Log(f"Config file doesn't exist? {str(e)}")

    Log("Writing to file...")
    with open(filepath, "w", encoding="utf-8") as cfg:
        json.dump(configs, cfg)

# why this is a seperate function that only has 2 lines?
# well it will make it easier to change the path in the future if we wished to, just change the return value and it will work fine 
def FindConfigPath():
    Log("Finding config path...")
    # default config path should be here
    return GVars.configPath + GVars.nf + "configs.cfg"

# since we already checked for the integrity of the config file earlier we don't need to re-read from it just change the value in the loaded file and write the whole thing back
def EditConfig(search, newvalue):
    GVars.configData[search]["value"] = newvalue
    WriteConfigFile(GVars.configData)

# to import the config data from the local config file
def ImportConfig():
    # try:
        Log("            __________Config Data Start__________")
        Log("Importing Config...")

        configpath = FindConfigPath()

        # if the file doesn't exist then create it
        if not os.path.exists(configpath):
            WriteConfigFile(DefaultConfigFile)

        # read all the lines in the config file
        config = open(configpath, "r", encoding="utf-8").read().strip()

        # if the file is empty then re-create it
        if len(config) == 0:
            WriteConfigFile(DefaultConfigFile)

        # process the config file into useable data
        Log("Processing config...")
        Log("")
        processedconfig = json.loads(config)

        Log("")
        Log("Configs imported successfully!")
        # at last pass the data to the verify function to make sure everything is clean
        return VerifyConfigFileIntegrity(processedconfig)
    # except Exception as e:
    #     Log(f"Error importing config: {str(e)}")
        # Log("FAILED TO IMPORT CONFIGS!")
        # WriteConfigFile(DefaultConfigFile)
        # GVars.hadtoresetconfig = True
        # return ImportConfig()
