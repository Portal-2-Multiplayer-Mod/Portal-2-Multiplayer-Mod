import os
import json
from Scripts.BasicLogger import Log
import Scripts.GlobalVariables as GVars

# █▀▀ █▀█ █▄░█ █▀▀ █ █▀▀   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀
# █▄▄ █▄█ █░▀█ █▀░ █ █▄█   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █░▀░█ ██▄ █░▀█ ░█░

defaultplayerarray = {"name": "New Player", "steamid": "0", "adminlevel": "0"}

DefaultConfigFile = {
    "portal2path":
        {
            "value": "undefined",
            "menu": "launcher",
            "description": "Path to the Portal 2 Folder",
            "warning": "",
            "prompt": "Enter the path to the Portal 2 folder",
        },

    "developer":
        {
            "value": "false",
            "menu": "hidden",
            "description": "Makes the mods files mount from src/ModFiles",
            "warning": "",
            "prompt": "",
        },
    
    "CustomLaunchOptions":
        {
            "value": "+map mp_coop_lobby_3",
            "menu": "hidden",
            "description": "Please type your custom launch options. Example (+map 'mapname'). Leave blank to launch into menu.",
            "warning": "",
            "prompt": "Custom launch options for debugging.",
        },

    "LauncherSFX":
        {
            "value": "true",
            "menu": "launcher",
            "description": "Makes the buttons play sound effects",
            "warning": "",
            "prompt": "Enable sound effects?",
        },

    "LauncherCubes":
        {
            "value": "true",
            "menu": "launcher",
            "description": "Makes cubes rain in the background",
            "warning": "",
            "prompt": "Enable background cubes?",
        },

    "EncryptCvars":
        {
            "value": "false",
            "menu": "portal2",
            "description": "Encrypts cvars such as \"restart_level\" and \"reset_all_progress\")",
            "warning": "(only use for public games) may break some functionality",
            "prompt": "Encrypt cvars?",
        },

    "SafeGuard":
        {
            "value": "false",
            "menu": "portal2",
            "description": "Encrypts vscript functions such as \"SendToConsole(\"\")\"",
            "warning": "(only use for public games) may break some functionality",
            "prompt": "Encrypt specific vscript functions?",
        },

    "Players":
        {
            "value": [
                defaultplayerarray,
            ],
            "menu": "players",
            "description": "If You See This Something Is Wrong",
            "warning": "If You See This Something Is Wrong",
            "prompt": "If you see this something is wrong",
        },

    "AutoUnmount":
        {
            "value": "true",
            "menu": "launcher",
            "description": "Automatically unmounts the game when the game is closed",
            "warning": "",
            "prompt": "Encrypt specific vscript functions?",
        },
        
    "activeLanguage":
        {
            "value": "English",
            "menu": "launcher",
            "description": "The current language, it should respect the IETF language tag (check ISO 3166-1 for get "
                           "your language)",
        },
}

ImmutableKeys = ["description", "warning", "prompt", "menu"]

# verifies the config file by making sure that the processed data has the same keys as the default
# if it doesn't then we'll transfer the values from the local config file to the default one and write the default one
def VerifyConfigFileIntegrity(config):
    Log("=========================")
    Log("Validating config data...")
    copiedconfig = {
        **config,
    }
    # VALIDATE ALL THE KEYS ARE CORRECT
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
    # VALIDATE ALL THE KEYS EXIST
    for key in DefaultConfigFile:
        if key not in config:
            Log(f"The key [{key}] is missing, fixing it...")
            config[key] = DefaultConfigFile[key]
            WriteConfigFile(config)
    # VALIDATE THAT ALL THE KEYS HAVE ALL THE VALUES
    for key in DefaultConfigFile:
        for key2 in DefaultConfigFile[key]:
            if key2 not in config[key]:
                Log(f"The value for [{key}][{key2}] is missing, fixing it...")
                config[key][key2] = DefaultConfigFile[key][key2]
                WriteConfigFile(config)
    Log("=========================")

    
    
    # if the config keys are the same as the default then just return them
    return config


def ValidatePlayerKeys():
    Log("validating player keys...")
    try:
        indx = -1
        errs = 0
        player : dict
        for player in GVars.configData["Players"]["value"]:
            if player.keys() != defaultplayerarray.keys():
                indx += 1
                errs += 1
                tempPlayer = defaultplayerarray
                Log(f"found {str(errs)} key errors")
                print(f"local player keys = {player.keys()} \n saved player keys = {tempPlayer.keys()}")
                for key in tempPlayer.keys():
                    try:
                        tempPlayer[key] = player[key]
                    except Exception as e:
                        Log(str(e))
                GVars.configData["Players"]["value"][indx] = tempPlayer
            
        if errs > 0:
            WriteConfigFile(GVars.configData)
            
        Log("validated all keys!")

    except Exception as e:
        Log("ERROR: " + str(e))
        GVars.configData["Players"]["value"] = [defaultplayerarray]
        WriteConfigFile(GVars.configData)


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
    try:
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
    except Exception as e:
        Log(f"Error importing the config file: {str(e)}")
        WriteConfigFile(DefaultConfigFile)
        GVars.hadtoresetconfig = True
        return ImportConfig()
