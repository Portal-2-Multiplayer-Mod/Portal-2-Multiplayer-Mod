import os
import json
import locale
from Scripts.BasicLogger import Log
import Scripts.GlobalVariables as GVars

# █▀▀ █▀█ █▄░█ █▀▀ █ █▀▀   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀
# █▄▄ █▄█ █░▀█ █▀░ █ █▄█   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █░▀░█ ██▄ █░▀█ ░█░


def GetSysLang() -> str:
    sysDefaultLocale = locale.getdefaultlocale()[0]

    if sysDefaultLocale.split("_")[0].lower() == "fr":
        return "French"

    if sysDefaultLocale.split("_")[0].lower() == "zh":

        chineseType = sysDefaultLocale.split("_")[1].lower()

        if chineseType in ["cn", "sg", "hans"]:
            return "SChinese"

        if chineseType in ["hk", "mo", "hant"]:
            return "TChinese"

    return "English"


defaultPlayerArray = {"name": "New Player", "steamid": "0", "adminlevel": "0"}
subProperties = {"value", "description", "warning", "prompt", "menu"}

DefaultConfigFile = {

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
                defaultPlayerArray,
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
            "value": True,  # REMEMBER TO CHANGE THIS WHEN RELEASING NEW VERSION!
            "menu": "dev",
            "description": "Makes the mod's files mount from src/ModFiles",
            "warning": "Only enable this if you know what you're doing!",
            "prompt": "",
        }
}


def VerifyConfigsIntegrity(config: dict) -> dict:
    """Verifies that all the properties of the config file are similar to the default config.

    Parameters
    ----------
    config : dict
        The config file to verify.

    Returns
    -------
    dict
        Same config file if there's no errors or a fixed one.
    """

    Log("=========================")
    Log("Validating config data...")

    configKeysCopy = config.keys()
    errors = 0
    # VALIDATE ALL THE KEYS ARE CORRECT
    for key in configKeysCopy:
        if key not in DefaultConfigFile.keys():
            Log(f"Property [{key}] is invalid, deleting it...")
            config.pop(key)
            errors += 1
            continue

        # validate all the immutable values
        for property in config[key]:
            if property not in subProperties:
                if config[key][property] != DefaultConfigFile[key][property]:
                    Log(f"The value for [{key}][{property}] is invalid, fixing it...")
                    config[key][property] = DefaultConfigFile[key][property]
                    errors += 1

    # VALIDATE ALL THE KEYS EXIST
    for key in DefaultConfigFile.keys():
        if key not in config.keys():
            Log(f"Property [{key}] is missing, fixing it...")
            config[key] = DefaultConfigFile[key]
            errors += 1

    # VALIDATE THAT ALL THE KEYS HAVE ALL THE VALUES
    for key in DefaultConfigFile:
        for property in DefaultConfigFile[key]:
            if property not in config[key]:
                Log(f"The value for [{key}][{property}] is missing, fixing it...")
                config[key][property] = DefaultConfigFile[key][property]
                errors += 1

    Log("=========================")

    if errors > 0:
        WriteConfigFile(config)

    return config


def ValidatePlayerKeys() -> None:
    Log("validating player keys...")
    i = 0
    errors = 0
    player: dict

    try:
        for player in GVars.configsData["Players"]["value"]:
            if player.keys() != defaultPlayerArray.keys():
                errors += 1
                tempPlayer = defaultPlayerArray

                for key in tempPlayer.keys():
                    try:
                        tempPlayer[key] = player[key]
                    except Exception as e:
                        Log(str(e))

                GVars.configsData["Players"]["value"][i] = tempPlayer

            if errors > 0:
                Log(f"found {str(errors)} key errors in a player property")

            i += 1

        Log("Validated all players!")

    except Exception as e:
        Log("ERROR: " + str(e))
        errors +=1
        GVars.configsData["Players"]["value"] = [defaultPlayerArray]

    if errors > 0:
        WriteConfigFile(GVars.configsData)


def GetValue(property: str) -> str:
    return GVars.configsData[property]["value"]

def GetConfigList(search: str, val: str) -> list:
    lst = []
    for key in GVars.configsData:
        if GVars.configsData[key][search] == val:
            lst.append(key)
    return lst


def WriteConfigFile(configs: dict) -> None:
    filepath = GetConfigsPath()

    Log("Writing to file...")
    with open(filepath, "w", encoding="utf-8") as cfg:
        json.dump(configs, cfg, indent=4)


def EditConfig(property: str, newValue: any) -> None:
    """Updates the given propertie's value and writes to the config file

    Parameters
    ----------
    property : str
        The property name to update.

    newValue : any
        The new value can be anything that can be written to a json file.
    """

    GVars.configsData[property]["value"] = newValue
    Log(f"Changed Value of '{property}' to '{str(newValue)}'")
    WriteConfigFile(GVars.configsData)

def AddPlayer():
    Log("Adding blank player...")
    GVars.configsData["Players"]["value"].append(defaultPlayerArray)
    WriteConfigFile(GVars.configsData)

def EditPlayer(index: int, name: str = None, steamId: str = None, level: str = None):
    if name is not None:
        GVars.configsData["Players"]["value"][index]["name"] = name
    if steamId is not None:
        GVars.configsData["Players"]["value"][index]["steamid"] = steamId
    if level is not None:
        GVars.configsData["Players"]["value"][index]["adminlevel"] = level

    WriteConfigFile(GVars.configsData)


def DeletePlayer(index: int):
    GVars.configsData["Players"]["value"].pop(index)
    WriteConfigFile(GVars.configsData)


def GetConfigsPath() -> str:
    """Returns the configs' file path.

    Returns
    -------
    str
        The absolute path of the configs file.
    """

    # why is this it's own function you ask?
    # simply so we can change the file's path in one place easily

    Log("Getting configs' file path...")
    return GVars.configsFilePath + "/configs.json"

# to import the config data from the local config file
def ImportConfig() -> dict:
    Log("            __________Config Data Start__________")
    Log("Importing Config...")

    configpath = GetConfigsPath()

    try:
        # if the file doesn't exist then create it
        if not os.path.exists(configpath):
            raise Exception("Couldn't find config File!")

        # read all the lines in the config file
        config = open(configpath, "r", encoding="utf-8").read().strip()

        # if the file is empty then re-create it
        if len(config) == 0:
            raise Exception("Config File is empty!")

        # process the config file into useable data
        Log("")
        Log("Processing config...")

        processedconfig = json.loads(config)

        Log("")
        Log("Configs imported successfully!")
        # at last pass the data to the verify function to make sure everything is clean
        return VerifyConfigsIntegrity(processedconfig)

    except Exception as e:
        Log(f"Encountared an error while importing the config file: {str(e)}")
        WriteConfigFile(DefaultConfigFile)
        GVars.resetConfig = True
        return DefaultConfigFile
