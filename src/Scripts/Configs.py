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


def FindConfigPath():
    Log("Finding Config Path...")
    configpath = GVars.modPath + GVars.nf + "configs.cfg"

    # if it doesn't exist, create it
    if not os.path.exists(configpath):
        Log("Config file not found, creating...")
        Log("")
        # create the config file
        configfile = open(configpath, "w", encoding="utf-8")
        # write the default config file
        for line in DefaultConfigFile:
            configfile.write(line + "\n")
        # close the file
        configfile.close()

    # return the config path
    return configpath


def EditConfig(search, newvalue):
    # gets the config path
    filepath = FindConfigPath()
    # opens the config file and read it's content
    cfgdata = open(filepath, "r", encoding="utf-8").readlines()
    # delete the file
    os.remove(filepath)
    # open the file
    cfg = open(filepath, "w", encoding="utf-8")

    # go through each line by index so we can see if there is a match
    for i in range(len(cfgdata)):
        line = cfgdata[i]
        # remove everything after the first #
        line = line.split("#")[0].strip()

        # if the line contains "=" then it's not empty
        # and if the is longer or equal to 3 characters then then clearly it has some data
        if ("=" in line and len(line) >= 3):
            # get everything to the left of the =
            leftline = line.split("=")[0].strip()
            # get everything to the right of the =
            rightline = line.split("=")[1].strip()
            # if the left side is the search, replace the right side with the new value
            if (leftline == search):
                Log("Replacing " + rightline + " with " + newvalue + " in config...")
                cfgdata[i] = search + " = " + newvalue + "\n"

    # write the file
    for line in cfgdata:
        cfg.write(line)

    # close the file
    cfg.close()
    GVars.LoadConfig()


def ImportConfig():
    Log("            __________Config Data Start__________")
    Log("Importing Config...")

    # get the config file and open it
    config = open(FindConfigPath(), "r", encoding="utf-8").readlines()

    # process the config file into useable data
    Log("Processing Config...")
    Log("")
    processedconfig = {}
    for line in config:
        # remove everything after the first #
        line = line.split("#")[0].strip()

        # if the line contains "=" then it's not empty 
        # and if the is longer or equal to 3 characters then then clearly it has some data 
        if ("=" in line and len(line)>=3):
            # get everything to the left of the = and clean it from whitespaces
            leftline = line.split("=")[0].strip()
            # get everything to the right of the = and clean it from whitespaces
            rightline = line.split("=")[1].strip()

            # if the left line is not empty then add it to the dictionary
            # if the right line is empty we can handle it later
            if (leftline != ""):
                processedconfig[leftline] = rightline
                Log("Line: " + line)

    Log("")
    Log("Config Imported!")
    return processedconfig
