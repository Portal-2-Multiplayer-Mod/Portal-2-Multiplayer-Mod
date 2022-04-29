import Scripts.GlobalVariables as GVars
import shutil
import os

##############
# CONVERSION #
##############

def ConvertPath(path):
    if (GVars.iol):
        path = path.replace("\\", GVars.nf)
        path = path.replace("/", GVars.nf)
        path = path.replace("~", os.path.expanduser("~"))
        return path
    elif (GVars.iow):
        path = path.replace("\\", GVars.nf)
        path = path.replace("/", GVars.nf)
        return path