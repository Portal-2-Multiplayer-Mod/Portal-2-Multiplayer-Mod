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
    "Portal2-Path":
        {
            "value": "undefined",
            "menu": "launcher",
            "description": "Path of the Portal 2 Folder",
            "warning": "",
            "prompt": "Enter the path to the Portal 2 folder",
        },

    "Auto-Umount":
        {
            "value": "true",
            "menu": "launcher",
            "description": "Automatically unmounts the mod when the game is closed",
            "warning": "",
            "prompt": "",
        },

    "Launcher-SFX":
        {
            "value": "true",
            "menu": "launcher",
            "description": "Makes the buttons play sound effects",
            "warning": "",
            "prompt": "Enable sound effects?",
        },

    "Launcher-Cubes":
        {
            "value": "true",
            "menu": "launcher",
            "description": "Makes cubes rain in the background",
            "warning": "",
            "prompt": "Enable background cubes?",
        },

    "Server-Password":
        {
            "value": "",
            "menu": "portal2",
            "description": "Set a password for your P2MM server, this can be changed while the server is up but a level restart is required",
            "warning": "Its recommended to also set Public Server to false to have your server not on the Steam Servers",
            "prompt": "Please type the password for your P2MM server",
        },
    
    "Public-Server":
        {
            "value": "false",
            "menu": "portal2",
            "description": "Have your server display public on steam servers?",
            "warning": "Those with your IP Address will still be able to join. Set a password if you want a private server.",
            "prompt": "Have your server display public on steam servers?",
        },
    
    "Custom-Launch-Options":
        {
            "value": "+map mp_coop_lobby_3",
            "menu": "portal2",
            "description": "Type any custom launch options you want. Example (+map 'mapname').",
            "warning": "Leave this to default if you don't know what it does!",
            "prompt": "Custom launch options for debugging or starting the server at a different map",
        },

    "Encrypt-Cvars":
        {
            "value": "false",
            "menu": "portal2",
            "description": "Encrypts cvars such as \"restart_level\" and \"reset_all_progress\")",
            "warning": "(only use for public games) may break some functionality",
            "prompt": "Encrypt cvars?",
        },

    "Safe-Guard":
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

    "Dev-Mode":
        {
            "value": "false",
            "menu": "hidden",
            "description": "Makes the mod's files mount from src/ModFiles",
            "warning": "only enable this if you know what you're doing!",
            "prompt": "",
        },

    "Manual-Data-System-Overide":
        {
            "value": "true",
            "menu": "hidden",
            "description": "Manually overide if the server will operate next play session.",
            "warning": "Disabling this can cause your next play session to act weird. Leave on if you don't know what it does!",
            "prompt": "",
        },

    "Active-Language":
        {
            "value": GetSysLang(),
            "menu": "",
            "description": "the language of the p2mm client and not the game",
            "warning": "",
            "prompt": "",
        }
}

ImmutableKeys = {"value", "description", "warning", "prompt", "menu"}

# verifies the config file by making sure that the processed data has the same keys as the default
# if it doesn't then we'll transfer the values from the local config file to the default one and write the default one
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
def EditConfig(search: str, newvalue: str) -> None:
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

# why this is a seperate function that only has 2 lines?
# well it will make it easier to change the path in the future if we wished to, just change the return value and it will work fine
def FindConfigPath() -> str:
    Log("Finding config path...")
    # default config path should be here
    return GVars.configPath + GVars.nf + "configs.json"

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
