import os
from Scripts.BasicLogger import Log
import Scripts.GlobalVariables as GVars

# █▀▀ █▀█ █▄░█ █▀▀ █ █▀▀   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀
# █▄▄ █▄█ █░▀█ █▀░ █ █▄█   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █░▀░█ ██▄ █░▀█ ░█░

DefaultConfigFile = [
    "# █▀▀ █▀█ █▄░█ █▀▀ █ █▀▀",
    "# █▄▄ █▄█ █░▀█ █▀░ █ █▄█",
    "",
    "cfgvariant = 16 # DO NOT CHANGE THIS NUMBER WILL AUTO-UPDATE",
    "",
    "#// Launcher //#",
    "",
    "#-----------------------------------",
    "UseProton = off",
    "#-----------------------------------",
    "portal2path = undefined",
    "#-----------------------------------",
    "",
    "#// Portal 2 //#",
    "",
    "#-----------------------------------",
    "UsePlugin = false # Set to true if you want to use the plugin",
    "#-----------------------------------",
    "DedicatedServer = false # Set to true if you want to run the server as a dedicated server (INDEV)",
    "#-----------------------------------",
    "RandomTurretModels = false # Set to true if you want to randomize the turret models",
    "#-----------------------------------",
    "RandomPortalSize = false # Set to true if you want to randomize the portal size",
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
        line = line.split("#")[0]
        # remove the newline
        line = line.replace("\n", "")

        # if the line stripped is not empty and has a =, continue
        if (line != "" and "=" in line):
            # get everything to the left of the =
            leftline = line.split("=")[0]
            # get everything to the right of the =
            rightline = line.split("=")[1]
            # remove every space and tab from the left side
            leftline = leftline.replace(" ", "")
            leftline = leftline.replace("\t", "")
            # remove every tab from the right side
            rightline = rightline.replace("\t", "")
            # strip left and right
            leftline = leftline.strip()
            rightline = rightline.strip()
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
        line = line.split("#")[0]
        # remove the newline
        line = line.strip()

        # if the line stripped is not empty and has a =, continue
        if (line != "" and "=" in line):
            # get everything to the left of the =
            leftline = line.split("=")[0].strip()
            # get everything to the right of the =
            rightline = line.split("=")[1].strip()

            # if the left line is not empty then add it to the dictionary
            # if the right line is empty we can handle it later
            if (leftline != ""):
                processedconfig[leftline] = rightline
                Log("Line: " + line)

    Log("")
    Log("Config Imported!")
    return processedconfig
