# █ █▀▄▀█ █▀█ █▀█ █▀█ ▀█▀ █▀   ▄█▄   █░█ ▄▀█ █▀█ █ █▄▄ █░░ █▀▀ █▀
# █ █░▀░█ █▀▀ █▄█ █▀▄ ░█░ ▄█   ░▀░   ▀▄▀ █▀█ █▀▄ █ █▄█ █▄▄ ██▄ ▄█

from http.client import LineTooLong
import os


#/////////////////////////////////////////////////////////////////#
#//# detect if we are on windows (by default, we are on Linux) #//#
#/////////////////////////////////////////////////////////////////#

iow = False
# nt is the windows os
if os.name == 'nt':
    print("")
    print("(P2:MM) Windows OS detected!")
    iow = True
else:
    print("")
    print("(P2:MM) Linux OS detected!")



#///////////////////////////////#
#//# get the local user path #//#
#///////////////////////////////#

if (iow):
    homefolder = os.environ['USERPROFILE']
else:
    homefolder = os.path.expanduser("~")

print("(P2:MM) Home Folder: " + homefolder)

print("")


# █▀█ ▄▀█ ▀█▀ █░█   █▀▄ █▀▀ ▀█▀ █▀▀ █▀▀ ▀█▀ █▀█ █▀█
# █▀▀ █▀█ ░█░ █▀█   █▄▀ ██▄ ░█░ ██▄ █▄▄ ░█░ █▄█ █▀▄



# █▀▀ █ █░░ █▀▀   █▀▄▀█ █▀█ █░█ █▄░█ ▀█▀ █▀▀ █▀█
# █▀░ █ █▄▄ ██▄   █░▀░█ █▄█ █▄█ █░▀█ ░█░ ██▄ █▀▄



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
    print("(P2:MM) Finding Config Path...")
    # the config file should be in documents or .config
    if (iow):
        configpath = homefolder + "\\documents\\multiplayermod.conf"
    else:
        configpath = homefolder + "/.config/multiplayermod.conf"

    # if it doesn't exist, create it
    if not os.path.exists(configpath):
        print("(P2:MM) Config file not found, creating...")
        print("")
        # create the config file
        configfile = open(configpath, "w")
        # write the default config file
        for line in DefaultConfigFile:
            configfile.write(line + "\n")
        # close the file
        configfile.close()
    
    # return the config path
    return configpath
        

def ImportConfig():
    print("(P2:MM) Importing Config...")

    # get the config file and open it
    configpath = FindConfigPath()
    configfile = open(configpath, "r")
    config = configfile.readlines()
    configfile.close()


    # process the config file into useable data
    print("(P2:MM) Processing Config...")
    print("")
    print("FILE========================")
    processedconfig = []
    for line in config:
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
            # recombine the two sides with a =
            line = leftline + "=" + rightline

            # if the line is not empty, add it to the processed config
            if (line != ""):
                processedconfig.append(line)
                print("Line:" + line)
    print("FILE END====================")
    print("")


# █ █▄░█ █ ▀█▀
# █ █░▀█ █ ░█░

def Init():
    print("(P2:MM) Initializing...")
    print("")
    # import the config
    configfile = ImportConfig()




# RUN INIT
Init()