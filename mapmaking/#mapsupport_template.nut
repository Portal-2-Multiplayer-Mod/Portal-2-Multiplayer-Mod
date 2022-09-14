// ███╗   ███╗ █████╗ ██████╗ ███╗  ██╗ █████╗ ███╗   ███╗███████╗
// ████╗ ████║██╔══██╗██╔══██╗████╗ ██║██╔══██╗████╗ ████║██╔════╝
// ██╔████╔██║███████║██████╔╝██╔██╗██║███████║██╔████╔██║█████╗
// ██║╚██╔╝██║██╔══██║██╔═══╝ ██║╚████║██╔══██║██║╚██╔╝██║██╔══╝
// ██║ ╚═╝ ██║██║  ██║██║     ██║ ╚███║██║  ██║██║ ╚═╝ ██║███████╗
// ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝  ╚══╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn, MSOnSave, saveCheck) {
    saveSupport <- false //If your map supports our built-in save system, set this to true
    saveEvents = { //Place your save events for your map here, you can leave this blank if the above is false

    }

    if (MSInstantRun) {

    }

    if (MSLoop) {

    }

    if (MSPostPlayerSpawn) {

    }

    if (MSPostMapSpawn) {

    }

    if (MSOnPlayerJoin) {

    }

    if (MSOnDeath) {

    }

    if (MSOnRespawn) {

    }

    if (MSOnSaveLoad) {

    }

    if (MSOnSave) {
        if (supportSaves == true & saveCheck == true) {
            //Put save events here
        } else {
            printl("Tried to save progress but either saving isn't avaliable or saving isn't enabled in this map...")
            EntFire("p2mm_servercommand", "command", "say 'ERROR! FILE SAVING IS NOT AVALIABLE/ENABLED FOR THIS MAP!'")
            EntFire("p2mm_servercommand", "command", "say 'PROGRESS WAS NOT SAVED!!!'")
        }
    }
}