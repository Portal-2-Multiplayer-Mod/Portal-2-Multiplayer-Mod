import Scripts.GlobalVariables as GVars
import os
from Scripts.BasicLogger import Log

##############
# CONVERSION #
##############

# Converts paths to make sure they are read properly by the OS
def ConvertPath(path: str) -> str:
    if (GVars.iol) or (GVars.iosd):
        path = path.replace("\\", os.sep)
        path = path.replace("~", os.path.expanduser("~"))

    elif (GVars.iow):
        path = path.replace("/", os.sep)

    return path

# Deletes the folder using the OSes delete command
def DeleteFolder(path: str) -> None:
    if (GVars.iow):
        os.system("rmdir /s /q \"" + path + "\"")
    elif (GVars.iol) or (GVars.iosd):
        os.system("rm -rf \"" + path + "\"")

# Copies a folder using the OSes copy command
def CopyFolder(src: str, dst: str) -> str:
    if (GVars.iow):
        os.system("xcopy /E /H /C /I /Y \"" + src + "\" \"" + dst + "\"")
    elif (GVars.iol) or (GVars.iosd):
        os.system("cp -r \"" + src + "\" \"" + dst + "\"")
    return dst

# Copies a file using the OSes copy command
def CopyFile(src: str, dst: str) -> str:
    if (GVars.iow):
        os.system("copy \"" + src + "\" \"" + dst + "\"")
    elif (GVars.iol) or (GVars.iosd):
        os.system("cp \"" + src + "\" \"" + dst + "\"")
    return dst

# Moves a file using the OSes move command
def MoveFile(src: str, dst: str) -> str:
    if (GVars.iow):
        os.system("move \"" + src + "\" \"" + dst + "\"")
    elif (GVars.iol) or (GVars.iosd):
        os.system("mv \"" + src + "\" \"" + dst + "\"")
    return dst

# Used to grab Portal 2's game directory for the launcher if it hasn't been defined yet
# On Windows it will use the manifest file that is in the steamapps directory to detect Portal 2
def TryFindPortal2Path() -> str:
    # Should be default linux path for the game
    defpathlin = ConvertPath("~/.local/share/Steam/steamapps/common/Portal 2")

    if ((GVars.iol or GVars.iosd) and (os.path.isfile(defpathlin + "/portal2_linux"))):
        return defpathlin

    if (GVars.iow):
        import winreg
        try:
            hkey = winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE, "SOFTWARE\WOW6432Node\Valve\Steam")
            print(hkey)
            steam_path = winreg.QueryValueEx(hkey, "InstallPath")
            print(steam_path)
            manifestpath = steam_path[0] + ConvertPath("/steamapps/libraryfolders.vdf")
            print(manifestpath)
            if (os.path.isfile(manifestpath)):
                # read the manifest file
                manifest = open(manifestpath, "r", encoding="utf-8").readlines()
                paths = []

                for line in manifest:
                    line = line.strip()
                    # remove the quotes
                    line = line.replace("\"", "")
                    print(line)
                    if (line.startswith("path")):
                        line = line.replace("path", "")
                        line = line.strip()
                        paths.append(line)

                for path in paths:
                    print(path)
                    if (os.path.isdir(path + ConvertPath("/steamapps/common/Portal 2"))):
                        return path + ConvertPath("/steamapps/common/Portal 2")

        except Exception as e:
            Log("ERROR: " + str(e))

    return False