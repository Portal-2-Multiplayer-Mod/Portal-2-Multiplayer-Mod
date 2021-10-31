Dim strSteamInstallPath as String = My.Computer.Registry.GetValue(
    "HKEY_LOCAL_MACHINE\SOFTWARE\Valve\Steam", "InstallPath", Nothing)

MsgBox("The install path is " & strSteamInstallPath)