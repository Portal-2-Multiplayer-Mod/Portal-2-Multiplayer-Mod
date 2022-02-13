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
        
def FindInConfig(cfg, search):
    # go through each line
    for line in cfg:
        # check if the line (left side of the =) is the one we want
        if line.split("=")[0].strip() == search:
            print("(P2:MM) Found " + search + " in config!")
            # return the right side of the line
            return line.split("=")[1].strip()
    # if we didn't find it, return undefined
    print("(P2:MM) " + search + " not found in config!")

def EditConfig(filepath, search, newvalue):
    # open the file
    cfg = open(filepath, "r")
    # read the file
    cfgdata = cfg.readlines()
    # close the file
    cfg.close()
    # delete the file
    os.remove(filepath)
    # open the file
    cfg = open(filepath, "w")

    
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
                print("(P2:MM) Replacing " + rightline + " with " + newvalue + " in config...")
                cfgdata[i] = search + " = " + newvalue + "\n"

    # write the file
    for line in cfgdata:
        cfg.write(line)

    # close the file
    cfg.close()

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
    print("Config Data========================")
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

    print("Config Data End====================")
    print("")
    print("(P2:MM) Config Imported!")
    return processedconfig
    


# █ █▄░█ █ ▀█▀
# █ █░▀█ █ ░█░

def Init():
    print("(P2:MM) Initializing...")
    print("")

#//# import the config #//#
    configdata = ImportConfig()
    configpath = FindConfigPath()
    print("")

#//# get the portal 2 path #//#
    # setup a name for the default dlc2 (so we can make sure we get the right path later)
    if (iow):
        valvedlc = "\\portal2_dlc2"
    else:
        valvedlc = "/portal2_dlc2"

    print("(P2:MM) Checking for Portal 2 Path...")
    portal2path = FindInConfig(configdata, "portal2path")
    
    # if we don't have a path, find it
    if (portal2path == "undefined"):
        print("(P2:MM) Portal 2 Path not predefined!")
        print("(P2:MM) Finding Portal 2 Path...")
        # as a last resort, ask the user to find the path
        hasfoundcorrectpath = False
        while hasfoundcorrectpath == False:
            print("")
            portal2path = input("Enter the path to your Portal 2 installation: ")

            # double check that the path is valid
            if (os.path.exists(portal2path) and os.path.exists(portal2path + valvedlc)):
                # if it does stop the loop
                print("(P2:MM) Portal 2 Path found!")
                hasfoundcorrectpath = True
            else:
                print("(P2:MM) Invalid Path!")
                print("(P2:MM) Please try again!")
                hasfoundcorrectpath = False

        # write the path to the config
        print("(P2:MM) Writing Portal 2 Path to Config...")
        EditConfig(configpath, "portal2path", portal2path)

    # if we still don't have a path, we can't continue
    if (portal2path == "undefined"):
        print("(P2:MM) [Error] Portal 2 Path not found! Launch cannot continue!")
        exit()

    # double check that the path is valid
    if (os.path.exists(portal2path) and os.path.exists(portal2path + valvedlc)):
        print("(P2:MM) Portal 2 Path found And Is Correct!")
    else:
        print("(P2:MM) [Error] Invalid Path!")
        print("(P2:MM) [Error] Launch cannot continue!")
        exit()




# RUN INIT
Init()