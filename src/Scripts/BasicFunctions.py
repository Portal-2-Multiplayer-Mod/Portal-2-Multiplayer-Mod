import Scripts.GlobalVariables as GVars
import os
import psutil
from Scripts.BasicLogger import Log

##############
# CONVERSION #
##############


# Deletes the folder using the OSes delete command
def DeleteFolder(path: str) -> None:
    if (GVars.iow):
        os.system("rmdir /s /q \"" + path + "\"")
    elif (GVars.iol):
        os.system("rm -rf \"" + path + "\"")

# Copies a folder using the OSes copy command
def CopyFolder(src: str, dst: str) -> str:
    if (GVars.iow):
        os.system("xcopy /E /H /C /I /Y \"" + src + "\" \"" + dst + "\"")
    elif (GVars.iol):
        os.system("cp -r \"" + src + "\" \"" + dst + "\"")
    return dst

# Copies a file using the OSes copy command
def CopyFile(src: str, dst: str) -> str:
    if (GVars.iow):
        os.system("copy \"" + src + "\" \"" + dst + "\"")
    elif (GVars.iol):
        os.system("cp \"" + src + "\" \"" + dst + "\"")
    return dst

# Moves a file using the OSes move command
def MoveFile(src: str, dst: str) -> str:
    if (GVars.iow):
        os.system("move \"" + src + "\" \"" + dst + "\"")
    elif (GVars.iol):
        os.system("mv \"" + src + "\" \"" + dst + "\"")
    return dst

# Used to grab Portal 2's game directory for the launcher if it hasn't been defined yet
# On Windows it will use the manifest file that is in the steamapps directory to detect Portal 2
def TryFindPortal2Path() -> str:

    if GVars.iol:
        # Should be default linux path for the game
        defpathlin = os.path.expanduser("~") + "/.local/share/Steam/steamapps/common/Portal 2"

        if os.path.isfile(defpathlin + "/portal2_linux"):
            return defpathlin

    if (GVars.iow):
        import winreg
        try:
            hkey = winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE, "SOFTWARE\WOW6432Node\Valve\Steam")
            print(hkey)
            steam_path = winreg.QueryValueEx(hkey, "InstallPath")
            print(steam_path)
            manifestpath = steam_path[0] + "/steamapps/libraryfolders.vdf"
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
                    if (os.path.isdir(path + "/steamapps/common/Portal 2")):
                        return path + "/steamapps/common/Portal 2"

        except Exception as e:
            Log("ERROR: " + str(e))

    return False

# Allows to check if certain processes are running
def checkIfProcessRunning(processName) -> bool:
    for proc in psutil.process_iter():
        try:
            if processName.lower() in proc.name().lower():
                return True
        except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
            pass
    return False