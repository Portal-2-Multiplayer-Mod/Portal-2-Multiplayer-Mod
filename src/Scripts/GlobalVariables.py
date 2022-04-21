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
    modPath = os.path.dirname(__main__.__file__)
    
    if (sys.platform == "win32"):
        iow = True
    elif (sys.platform.startswith("linux")):
        iol = True # and we don't even need this variable i'll probably delete it tomorrow
    else:
        # feel sad for the poor people who are running templeOS :(
        Log("This operating system is not supported!")
        Log("We only support Windows and Linux as of current.")
        quit()

def LoadConfig():   
    global configData
    configData = cfg.ImportConfig()
    Log("config data loaded")
