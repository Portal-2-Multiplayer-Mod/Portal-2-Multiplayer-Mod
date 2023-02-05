import os
import json
import locale
from Scripts.BasicLogger import Log
import Scripts.GlobalVariables as GVars
import Scripts.DataSystem as DS

# █▀▀ █▀█ █▄░█ █▀▀ █ █▀▀   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀
# █▄▄ █▄█ █░▀█ █▀░ █ █▄█   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █░▀░█ ██▄ █░▀█ ░█░

defaultplayerarray = {"name": "New Player", "steamid": "0", "adminlevel": "0"}

def GetSysLang() -> str:
    sysDefaultLocale = locale.getdefaultlocale()[0]
    if sysDefaultLocale.split('_')[0].lower() == 'fr'.lower() :
        return 'Fran\u00e7ais'
    elif sysDefaultLocale.split('_')[0].lower() == 'zh'.lower():
        if sysDefaultLocale.split('_')[1].lower() == 'CN'.lower() \
        or sysDefaultLocale.split('_')[1].lower() == 'SG'.lower() \
        or sysDefaultLocale.split('_')[1].lower() == 'Hans'.lower():
            return 'SChinese'
        elif sysDefaultLocale.split('_')[1].lower() == 'TW'.lower() \
        or sysDefaultLocale.split('_')[1].lower() == 'HK'.lower() \
        or sysDefaultLocale.split('_')[1].lower() == 'MO'.lower() \
        or sysDefaultLocale.split('_')[1].lower() == 'Hant'.lower():
            return 'TChinese'
    else:
        return "English"

DefaultConfigFile = {
    "Discord-Rich-Presence":
        {
            "value": True,
            "menu": "launcher",
            "description": "Enable Discord Rich Presense For P2MM. This is needed for easy joinning for public servers.",
            "warning": "Please give around 15 seconds for the change to take effect.",
            "prompt": "",
        },

    "Auto-Umount":
        {
            "value": True,
            "menu": "launcher",
            "description": "Automatically unmounts the mod when the game is closed",
            "warning": "",
            "prompt": "",
        },

    "Launcher-SFX":
        {
            "value": True,
            "menu": "launcher",
            "description": "Makes the buttons play sound effects",
            "warning": "",
            "prompt": "Enable sound effects?",
        },

    "Launcher-Cubes":
        {
            "value": True,
            "menu": "launcher",
            "description": "Makes cubes rain in the background",
            "warning": "",
            "prompt": "Enable background cubes?",
        },

    "Portal2-Path":
        {
            "value": "undefined",
            "menu": "portal2",
            "description": "Path of the Portal 2 Folder",
            "warning": "",
            "prompt": "Enter the path to the Portal 2 folder",
        },
    
    "Custom-Launch-Options":
        {
            "value": "+map mp_coop_lobby_3",
            "menu": "portal2",
            "description": "Custom launch options for debugging or starting the server at a different map.",
            "warning": "Leave this to default if you don't know what it does!",
            "prompt": "Type any custom launch options you want.\nExample: \"+map 'mapname'\"",
        },

    "Server-Password":
        {
            "value": "",
            "menu": "portal2",
            "description": "Set a password for your P2MM server. This can be changed while the server is up.",
            "warning": "It is recommended to set this if you don't want unwanted visitors!",
            "prompt": "Type the password for your P2MM server.\nCharacters \"\'\", \"\\\", and \";\" are disallowed\nand will be automatically removed.",
        },

    "FastDL-Server-IP":
        {
            "value": "",
            "menu": "portal2",
            "description": "The local IP you want to use to host the FastDL HTTP Server.",
            "warning": "This is required if you want to use FastDL in P2MM!",
            "prompt": "The local IP you want to\nuse to host the FastDL HTTP Server.\nIt should be the same local\nIP you used to port foward Portal 2.",
        },

    "FastDL-Server-Port":
        {
            "value": "27016",
            "menu": "portal2",
            "description": "The port you want the FastDL HTTP Server to run on.",
            "warning": "This is required if you want to use FastDL in P2MM!",
            "prompt": "The port you want the\nFastDL HTTP Server to run on.\nIt's recommended to use 27016\nbut another open port should work.",
        },

    "Encrypt-Cvars":
        {
            "value": False,
            "menu": "portal2",
            "description": "Encrypts cvars such as \"restart_level\" and \"reset_all_progress\".",
            "warning": "Only use for public games! This may break some functionality.",
            "prompt": "Encrypt cvars?",
        },

    "Safe-Guard":
        {
            "value": False,
            "menu": "portal2",
            "description": "Encrypts vscript functions such as \"SendToConsole()\"",
            "warning": "Only use for public games! This may break some functionality.",
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
            "prompt": "If You See This Something Is Wrong",
        },
    
    "Active-Language":
        {
            "value": GetSysLang(),
            "menu": "",
            "description": "The language used in the P2MM Launcher.",
            "warning": "",
            "prompt": "",
        },

    "Dev-Mode":
        {
            "value": True, #REMEMBER TO CHANGE THIS WHEN RELEASING NEW VERSION!
            "menu": "dev",
            "description": "Makes the mod's files mount from src/ModFiles",
            "warning": "Only enable this if you know what you're doing!",
            "prompt": "",
        },

    "Data-System-Overide":
        {
            "value": True,
            "menu": "dev",
            "description": "Manually overide if the datasystem will operate next play session.",
            "warning": "Disabling this can cause your next play session to act weird. Leave on if you don't know what it does!",
            "prompt": "",
        },
    
    "Data-System-Debugging":
        {
            "value": False,
            "menu": "dev",
            "description": "Enables debug messaging for the Data System",
            "warning": "Leave this off if you wish to not clog up the logs!",
            "prompt": "",
        }
}

ImmutableKeys = {"value", "description", "warning", "prompt", "menu"}

# verifies the config file by making sure that the processed data has the same keys as the default
# if it doesn't then the values are transfered from the local config file to the default one and write the default one
def VerifyConfigFileIntegrity(config: dict) -> dict:
    Log("=========================")
    Log("Validating config data...")

    copiedConfigKeys = config.keys()
    errors = 0
    # VALIDATE ALL THE KEYS ARE CORRECT
    for key in copiedConfigKeys:
        if key not in DefaultConfigFile.keys():
            Log(f"The key [{key}] is invalid, fixing it...")
            config.pop(key)
            errors +=1

        # validate all the immutable values
        for property in config[key]:
            if property not in ImmutableKeys:
                if config[key][property] != DefaultConfigFile[key][property]:
                    Log(f"The value for [{key}][{property}] is invalid, fixing it...")
                    config[key][property] = DefaultConfigFile[key][property]
                    errors +=1

    # VALIDATE ALL THE KEYS EXIST
    for key in DefaultConfigFile.keys():
        if key not in config.keys():
            Log(f"The key [{key}] is missing, fixing it...")
            config[key] = DefaultConfigFile[key]
            errors +=1

    # VALIDATE THAT ALL THE KEYS HAVE ALL THE VALUES
    for key in DefaultConfigFile:
        for property in DefaultConfigFile[key]:
            if property not in config[key]:
                Log(f"The value for [{key}][{property}] is missing, fixing it...")
                config[key][property] = DefaultConfigFile[key][property]
                errors +=1
    Log("=========================")

    if errors > 0:
        WriteConfigFile(config)

    # if the config keys are the same as the default then just return them
    return config


def ValidatePlayerKeys() -> None:
    Log("validating player keys...")
    try:
        indx = 0
        errs = 0
        player: dict
        for player in GVars.configData["Players"]["value"]:
            if player.keys() != defaultplayerarray.keys():
                errs += 1
                tempPlayer = defaultplayerarray
                print(f"local player keys = {player.keys()} \n saved player keys = {tempPlayer.keys()}")
                for key in tempPlayer.keys():
                    try:
                        tempPlayer[key] = player[key]
                    except Exception as e:
                        Log(str(e))
                GVars.configData["Players"]["value"][indx] = tempPlayer

            if errs > 0:
                Log(f"found {str(errs)} key errors in a player property")

            indx += 1

        if errs > 0:
            WriteConfigFile(GVars.configData)

        Log("validated all keys!")

    except Exception as e:
        Log("ERROR: " + str(e))
        GVars.configData["Players"]["value"] = [defaultplayerarray]
        WriteConfigFile(GVars.configData)


def GetConfigList(search: str, val: str) -> list:
    lst = []
    for key in GVars.configData:
        if GVars.configData[key][search] == val:
            lst.append(key)
    return lst

def WriteConfigFile(configs: dict) -> None:
    filepath = FindConfigPath()
    # just to make sure the file doesn't exist
    try:
        os.remove(filepath)
        Log("Deleted old file")
    except Exception as e:
        Log(f"Config file doesn't exist? {str(e)}")

    Log("Writing to file...")
    with open(filepath, "w", encoding="utf-8") as cfg:
        json.dump(configs, cfg, indent=4)

# since we already checked for the integrity of the config file earlier we don't need to re-read from it just change the value in the loaded file and write the whole thing back
def EditConfig(search: str, newvalue: any) -> None:
    GVars.configData[search]["value"] = newvalue
    WriteConfigFile(GVars.configData)

def EditPlayer(index: int, name: str = None, steamId: str = None, level: str = None):
    if name is not None:
        GVars.configData["Players"]["value"][index]["name"] = name
    if steamId is not None:
        GVars.configData["Players"]["value"][index]["steamid"] = steamId
    if level is not None:
        GVars.configData["Players"]["value"][index]["adminlevel"] = level

    WriteConfigFile(GVars.configData)

def DeletePlayer(index: int):
    GVars.configData["Players"]["value"].pop(index)
    WriteConfigFile(GVars.configData)

def FindConfigPath() -> str:
    Log("Finding config path...")
    # default config path should be here
    return GVars.configsPath + GVars.nf + "configs.cfg"

# to import the config data from the local config file
def ImportConfig() -> dict:
    try:
        Log("            __________Config Data Start__________")
        Log("Importing Config...")

        configpath = FindConfigPath()

        # if the file doesn't exist then create it
        if not os.path.exists(configpath):
            print("here")
            WriteConfigFile(DefaultConfigFile)

        # read all the lines in the config file
        config = open(configpath, "r", encoding="utf-8").read().strip()

        # if the file is empty then re-create it
        if len(config) == 0:
            print("here2")
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
        print("here3")
        GVars.hadtoresetconfig = True
        return ImportConfig()
