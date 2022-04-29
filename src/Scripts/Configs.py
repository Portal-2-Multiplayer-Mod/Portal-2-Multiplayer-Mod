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
    "developer = false",
    "#-----------------------------------",
    "",
    "#// Portal 2 //#",
    "",
    "#-----------------------------------",
    "Test = false",
    "#-----------------------------------",
]

# this is temporary until we agree on whether to add the fluff to the config file or not
DefaultConfigFile2 = {
    "cfgvariant": 18,
    "portal2path": "undefined",
    "Test": "false",
    "developer": "false"
}

# verifies the config file by making sure that the processed data has the same keys as the default 
# if it doesn't then we'll transfer the values from the local config file to the default one and write the default one
def VerifyConfigFileIntegrity(config):
    if len(config) != len(DefaultConfigFile2) or config.keys() != DefaultConfigFile2.keys():
        DefaultCopy = DefaultConfigFile2
        Log("Some config data is invalid, fixing it...")
        for key in DefaultCopy:
            try:
                DefaultCopy[key] = config[key]
            except:
                Log(f"The key [{key}] is missing from the local config file!")
        WriteConfigFile(DefaultCopy)
        return DefaultCopy
        
    # if the config keys are the same as the default then just return them
    else:
        return config

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
        for key in configs:
            cfg.write(key+" = "+str(configs[key]) + "\n")

# why this is a seperate function that only has 2 lines?
# well it will make it easier to change the path in the future if we wished to, just change the return value and it will work fine 
def FindConfigPath():
    Log("Finding config path...")
    # default config path should be here
    return GVars.modPath + GVars.nf + "configs.cfg"

# since we already checked for the integrity of the config file earlier we don't need to re-read from it just change the value in the loaded file and write the whole thing back
def EditConfig(search, newvalue):
    GVars.configData[search] = newvalue
    WriteConfigFile(GVars.configData)

# to import the config data from the local config file
def ImportConfig():
    Log("            __________Config Data Start__________")
    Log("Importing Config...")

    configpath = FindConfigPath()
    
    # if the file doesn't exist then create it
    if not os.path.exists(configpath):
        WriteConfigFile(DefaultConfigFile2)
        
    # read all the lines in the config file
    config = open(configpath, "r", encoding="utf-8").readlines()

    # if the file is empty then re-create it
    if len(config) == 0:
        WriteConfigFile(DefaultConfigFile2)
        
    # process the config file into useable data
    Log("Processing config...")
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
    Log("Configs imported successfully!")
    # at last pass the data to the verify function to make sure everything is clean
    return VerifyConfigFileIntegrity(processedconfig)