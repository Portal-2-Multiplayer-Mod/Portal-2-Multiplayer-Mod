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
nf = ""


def init():
    global appStartDate, modPath, iow, iol, nf
    
    appStartDate = datetime.now().strftime('%Y-%m-%d %H-%M-%S')
    modPath = os.path.dirname(__main__.__file__)
    
    if (sys.platform == "win32"):
        nf = "\\"
        iow = True
    elif (sys.platform.startswith("linux")):
        iol = True
        nf = "/"
    else:
        # feel sad for the poor people who are running templeOS :(
        Log("This operating system is not supported!")
        Log("We only support Windows and Linux as of current.")
        quit()

def LoadConfig():   
    global configData
    configData = cfg.ImportConfig()
    Log("config data loaded")
