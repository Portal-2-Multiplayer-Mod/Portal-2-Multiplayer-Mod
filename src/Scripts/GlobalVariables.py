# this is a file to store all the global variables needed
# it's initiated only once when the mainwindow is created
# please don't temper with it

import os
import sys
import __main__
from datetime import datetime
import Scripts.Configs as cfg
from Scripts.BasicLogger import Log

#//////////////////////////////////////////#
#//#    Global Variables Declarations   #//#
#//////////////////////////////////////////#

# appStartDate is the dateTime when the launcher was started, this is used to name the logs
appStartDate = ""
configData = {}
modPath = ""
iow = False
iol = False
nf = os.sep # this way the logging won't break if someone runs the app on mac


def init():
    global appStartDate, modPath, iow, iol, nf
    
    appStartDate = datetime.now().strftime('%Y-%m-%d %H-%M-%S')
    
    if (sys.platform == "win32"):
        iow = True
    elif (sys.platform.startswith("linux")):
        iol = True
    else:
        # feel sad for the poor people who are running templeOS :(
        Log("This operating system is not supported!")
        Log("We only support Windows and Linux as of current.")
        quit()

    if (iol):
        # set the modpath the the users home directory
        modPath = os.path.expanduser("~") + nf + ".cache/p2mm"
    elif (iow):
        # set the modpath to the users documents folder
        modPath = os.path.expanduser("~") + nf + "Documents/p2mm"

    # check if the modpath exists, if not create it
    if not os.path.exists(modPath):
        os.makedirs(modPath)

def LoadConfig():   
    global configData
    configData = cfg.ImportConfig()
    Log("Config data loaded.")
