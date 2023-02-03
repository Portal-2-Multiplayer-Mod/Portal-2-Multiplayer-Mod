//---------------------------------------------------
//         *****!Do not edit this file!*****
//---------------------------------------------------
//   ______      _
//   |  _  \    | |
//   | | | |__ _| |_ __ _
//   | | | / _` | __/ _` |
//   | |/ / (_| | || (_| |
//   |___/ \__,_|\__\__,_|
//    _____           _
//   /  ___|         | |                _
//   \ `--. _   _ ___| |_ ___ _ __ ___ (_)
//    `--. \ | | / __| __/ _ \ '_ ` _ \
//   /\__/ / |_| \__ \ ||  __/ | | | | |_
//   \____/ \__, |___/\__\___|_| |_| |_(_)
//           __/ |
//          |___/
//---------------------------------------------------
// Purpose:
// Creates the functionality of our custom data
// system for maps that support it.
// Will not be avaliable for maps that don't use it.
// THIS SCRIPT IS STILL A WIP, ISSUES MIGHT OCCUR!
//---------------------------------------------------
//
// Data Systen Terminology:
// Enabled: The data system has started successfully on the python scripts end
// Disabled: The data system didn't start successfully on the python scripts end
// Running: By default the data system is set to run with every play session
// Not Running: The user has defined they do not want the data system to run next play session or the system is disabled

// .nut indictators the datasystem will look for when a check file is detected
dataFileIndicators = [
    "datasystem-kick-succeed.nut", "datasystem-kick-failed.nut",
    "datasystem-ban-succeed.nut", "datasystem-ban-failed.nut",
    "datasystem-password-succeed.nut", "datasystem-password-failed.nut",
    "datasysystem-setpassword.nut"]

function dataLoad(event, eventdata) {
    printlP2MM("Loading data retrieved from masterData...")
    local grabbedData = false
    try {
        EntFireByHandle(target, action, value, delay, activator, caller)("p2mm_servercommad", "script_execute(\"datasystemsaves/datasystem-\" + event + \"-\" + eventdata + ".nut"\""))
        grabbedData = true
    } catch (e) {
        printlP2MM("Loading the nut indicator failed... We are gonna try again one more time...")
        try {
            RunScriptFile("datasystemsaves/datasystem-" + event + "-" + eventdata + ".nut")
        } catch (e) {
            SendChatMessage("[DS ERROR] A error occured with the data system, check the console...")
            printlP2MM("Failed to grab data!")
            grabbedData = false
        }
    }
    if (grabbedData = true) {
        dataCheck()
    }
}

function requestMasterData(event, eventdata) {
    try {
        printlP2MM("Retrieving reuqested saved data from the launchers masterData...")
        SendToConsoleP2MM("screenshot datasystem-retrieve-" + event + "-" + eventdata + ".nut")
        dataLoad
    } catch (e) {
        SendChatMessage("[DS ERROR] A error occured with the data system, check the console...")
        printlP2MM("[DS ERROR] Failed to request data from the master save!")
    }
}

function dataSave(event, eventdata) {
    try {
        SendToConsoleP2MM("screenshot datasystem-" + event + "-" + eventdata)
        printlP2MM("datasystem-" + event + "-" + eventdata + " file created...")
    } catch (e) {
        SendChatMessage("[DS ERROR] A error occured with the data system, check the console...")
        printlP2MM("[DS ERROR] datasystem-" + event + "-" + eventdata + " failed to be created...")
        printlP2MM(e)
    }
}

function dataCheck() {
    local checkFile = false
    try {
        RunScriptFile("datasystemsaves/datasystem-datacheck.nut")
        checkFile = true
    } catch (e) {
        printlP2MM("Data System Check for finding a file was called but no file found...")
        return
    }
    if (checkFile = true) {
        foreach (selectedDataFile in dataFileIndicators) {
            try {
                RunScriptFile(selectedDataFile)
                dataFileFound = true
            } catch (e) {
                continue
            }
        }
        if (dataFileFound = true) {
            switch (selectedDataFile) {
                case "datasystem-kick-succeed.nut": dataSystemKick(returnstate=true); return;
                case "datasystem-kick-fail.nut": dataSystemKick(returnstate=false); return;
                case "datasystem-ban-succeed.nut": dataSystemBan(returnstate=true); return;
                case "datasystem-ban-fail.nut": dataSystemBan(returnstate=false); return;
                case "datasystem-password-succeed.nut": dataSystemPassword(returnstate=true); return;
                case "datasystem-password-fail.nut": dataSystemPassword(returnstate=false); return;
                case "datasystem-setpassword.nut": dataSystemSetPassword(); return;
            }
        } else {
            printlP2MM("Data System Check called but no file found...")
        }
    }
}

function dataSystemKick(returnstate, player) {
    if (returnstate = true) {
        SendChatMessage("[DS] " + FindPlayerClass(player).username + " has been kicked from the server...", null)
        printlP2MM("[DS] " + FindPlayerClass(player).username + " has been kicked from the server...")
    }

    if (returnstate = false) {
        SendChatMessage("[DS ERROR] Failed to kick player: " + FindPlayerClass(player).username, null)
        SendChatMessage("[DS ERROR] A error occured with the data system, check the console...")
        printlP2MM("[DS ERROR] The Python Data System returned an error when trying to kick: " + FindPlayerClass(player).username)
        printlP2MM("[DS ERROR] Check the Python console for the launcher...")
    }

    if (returnstate = null) {
        dataSave("kick", player)
        printlP2MM("Kick screenshot has been created for player: " + player)
    }
}

function dataSystemBan(returnstate, player) {
    if (returnstate = true) {
        SendChatMessage("[DS] " + FindPlayerClass(player).username + " has been banned from the server...", null)
        printlP2MM("[DS] " + FindPlayerClass(player).username + " has been banned from the server...")
    }

    if (returnstate = false) {
        SendChatMessage("[DS ERROR] Failed to ban player: " + FindPlayerClass(player).username, null)
        SendChatMessage("[DS ERROR] A error occured with the data system, check the console...")
        printlP2MM("[DS ERROR] The Python Data System returned an error when trying to ban: " + FindPlayerClass(player).username)
        printlP2MM("[DS ERROR] Check the Python console for the launcher...")
    }

    if (returnstate = null) {
        dataSave("ban", player)
        printlP2MM("[DS] Ban screenshot has been created for player: " + player)
    }
}

function dataSystemPassword(returnstate) {
    if (returnstate = true) {
        SendChatMessage("[DS] The server password has been successfully changed!", null)
        printlP2MM("[DS] The server password has been successfully changed!")
    }

    if (returnstate = false) {
        SendChatMessage("[DS ERROR] Failed to change the server password! Check the console!", null)
        printlP2MM("[DS ERROR] The Python Data System failed to change the server password! Check the both the launcher console!")
    }
}

function dataSystemSetPassword() {
    try {
        IncludeScript("datasystemsaves/datasystem-setpassword.nut")
        SendToConsoleP2MM("sv_password " + New_Password)
        SendToConsoleP2MM("screenshot datasystem-setpasswordsuccess")
        printlP2MM("The server password has been successfully changed!")
    } catch(e) {
        SendChatMessage("[DS ERROR] Failed to change server password! Check the both the Portal 2 and launcher console!", null)
        printlP2MM("[DS ERROR] Failed to change server password! Check the both the Portal 2 and launcher console!")
        SendToConsoleP2MM("screenshot datasystem-setpasswordfailed")
    }
}

/*
    Init for the data system
    We must check to make sure the python data system's is active or it won't work
    If it fails we'll tell mapspawn.nut that the data system isn't currently working on the map
*/
function dataSystemInit() {
    printlP2MM("Starting the data system!")
    //Makes a temporary screenshot file for our python data system to check
    SendToConsoleP2MM("screenshot datasystem-test")
    try {
        RunScriptFile("datasystemsavesdatasystem-pythonsuccess.nut")
        printlP2MM("Data Systen works! Will be avaliable for the map...")
        dataCheck <- true
        SendToConsoleP2MM("screenshot datasystem-nutsuccess")
    } catch (e){
        printlP2MM("First check detection failed, trying again...")
        printlP2MM(e)
        local datasystemcheckerrors = 0
        while (datasystemcheckerrors != 3) {
            try {
                RunScriptFile("datasystemsavesdatasystem-pythonsuccess.nut")
                break
            } catch (e){
                printlP2MM("Check detection failed, will try again...")
                printlP2MM(e)
                datasystemcheckerrors += 1
            }
        }

        if (datasystemcheckerrors = 3) {
            printlP2MM("Data Systen check detection failed after checking three times!")
            printlP2MM("The data system will not be avaliable for this map...")
            dataCheck <- false
            SendToConsoleP2MM("screenshot datasystemcheck-nutfail")
            datasystemcheckerrors = 0
        } else {
            printlP2MM("Data System works! Will be avaliable for the map...")
            dataCheck <- true
            SendToConsoleP2MM("screenshot datasystem-nutsuccess")
            datasystemcheckerrors = 0
        }
    }
}