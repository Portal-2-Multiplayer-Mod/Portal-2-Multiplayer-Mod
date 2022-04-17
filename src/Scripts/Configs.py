import os
from Scripts.BasicLogger import Log
import Scripts.GlobalVariables as GVars

# █▀▀ █▀█ █▄░█ █▀▀ █ █▀▀   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀
# █▄▄ █▄█ █░▀█ █▀░ █ █▄█   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █░▀░█ ██▄ █░▀█ ░█░

DefaultConfigFile = [
    "# █▀▀ █▀█ █▄░█ █▀▀ █ █▀▀",
    "# █▄▄ █▄█ █░▀█ █▀░ █ █▄█",
    "",
    "cfgvariant = 18 # DO NOT CHANGE THIS NUMBER WILL AUTO-UPDATE",
    "",
    "#// Launcher //#",
    "",
    "#-----------------------------------",
    "portal2path = undefined",
    "#-----------------------------------",
    "",
    "#// Portal 2 //#",
    "",
    "#-----------------------------------",
    "Test = false",
    "#-----------------------------------",
]

DefaultConfigFile2 = {
    "cfgvariant": 18,
    "portal2path": "undefined",
    "Test": "false"
}

def VerifyConfigFileIntegrity(config):
    if len(config) != len(DefaultConfigFile2) or config.keys() != DefaultConfigFile2.keys():
        DefaultCopy = DefaultConfigFile2
        Log("some config data is invalid, fixing it...")
        for key in DefaultCopy:
            try:
                DefaultCopy[key] = config[key]
            except:
                Log(f"the key [{key}] is missing from the local config file")
        Log("writting to file...")
        WriteConfigFile(DefaultCopy)
        return DefaultCopy
        
    # if the config keys are the same as the default then just return
    else:
        return config

def WriteConfigFile(configs):
    filepath = FindConfigPath()
    # just to make sure the file doesn't exist
    try:
        os.remove(filepath)
    except:
        Log("doesn't matter")
        
    cfg = open(filepath, "w", encoding="utf-8")

    for key in configs:
        cfg.write(key+" = "+configs[key] + "\n")

    cfg.close()

def FindConfigPath():
    Log("Finding Config Path...")
    # default config path should be here
    return GVars.modPath + GVars.nf + "configs.cfg"

def EditConfig(search, newvalue):
    GVars.configData[search] = newvalue
    WriteConfigFile(GVars.configData)
    GVars.LoadConfig()


def ImportConfig():
    Log("            __________Config Data Start__________")
    Log("Importing Config...")

    configpath = FindConfigPath()
    # if the file doesn't exist then create it
    if not os.path.exists(configpath):
        WriteConfigFile(DefaultConfigFile2)
        
    # get the config file and open it
    config = open(configpath, "r", encoding="utf-8").readlines()

    # if the file is empty then also re-create it
    if len(config) == 0:
        WriteConfigFile(DefaultConfigFile2)
        
    # process the config file into useable data
    Log("Processing Config...")
    Log("")
    processedconfig = {}
    for line in config:
        # remove everything after the first #
        line = line.split("#")[0].strip()

        # if the line contains "=" then it's not empty 
        # and if the is longer or equal to 3 characters then clearly it has some data 
        if ("=" in line and len(line)>=3):
            # get everything to the left of the = and clean it from whitespaces
            leftline = line.split("=")[0].strip()
            # get everything to the right of the = and clean it from whitespaces
            rightline = line.split("=")[1].strip()

            # if the left line is not empty then add it to the dictionary
            # if the right line is empty we can handle it later
            if (leftline != ""):
                processedconfig[leftline] = rightline
                Log("Imported: " + line)

    Log("")
    Log("Configs Imported!")
    return VerifyConfigFileIntegrity(processedconfig)