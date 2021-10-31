import os

iow = False
if os.name == 'nt':
    print("(System should be running Windows)")
    iow = True
else:
    print("(System should be running Linux)")

CheckingPath = ""

if (iow):
    print("(System is running Windows)")

    import winreg as wr

    aKey = r"SOFTWARE\\Valve\\Steam"
    print(aKey)
    aReg = wr.ConnectRegistry(None, wr.HKEY_LOCAL_MACHINE)
    print(aReg)

    print(r"*** Reading from %s ***" % aKey)

    aKey = wr.OpenKey(aReg, aKey)
    for i in range(1024):
        try:
            asubkey_name = wr.EnumKey(aKey, i)
            asubkey = wr.OpenKey(aKey, asubkey_name)
            val = wr.QueryValueEx(asubkey, "InstallPath")
            print("STEAMPATH:" + val)
        except EnvironmentError:
            break

    owd = val


    # open libraryfolders.vdf
    with open(owd + "\libraryfolders.vdf", "r") as f:
        s = f.readlines()

        # ittarate through the lines
        for line in s:
            line = line.replace(" ", "")
            listyboi = line.split()
            line = "".join(listyboi)
            print(line)
            if line.startswith('"path"'):
                CheckingPath = line[6:]
                CheckingPath = CheckingPath.replace('"', "")
                print("VAR SET" + CheckingPath)
            if (line.startswith('"620"')):
                print("FOUND GAME")
                FinalPath = CheckingPath + "\\steamapps\\common\\Portal 2"
                print(FinalPath)
                break

print("DONE")