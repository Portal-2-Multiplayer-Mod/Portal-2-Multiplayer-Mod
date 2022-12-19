//
// _____  _____         _____  _____  _____  _____         _____  _____  _____  _____  _____  _____  _____  _____
// |     ||  _  |       |     ||     ||     ||  _  |       |_   _||   __||   __||_   _|| __  ||     ||     ||     |
// | | | ||   __|       |   --||  |  ||  |  ||   __|         | |  |   __||__   |  | |  |    -||  |  ||  |  || | | |
// |_|_|_||__|    _____ |_____||_____||_____||__|    _____   |_|  |_____||_____|  |_|  |__|__||_____||_____||_|_|_|
//               |_____|                            |_____|

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn, MSOnSave) {
    if (MSInstantRun) {
        supportsSaves <- false // If your map supports our built-in save system, set this to true
        saveEvents <- { // Place your save events for your map here

        }
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

    // Move this to whereever it needs to be called in the native MS functions.
    // Use a global variable to sort out these conditions (INDEV)
    // if (MSOnSave) {
    //     if (supportSaves && saveCheck) {
    //         // Put save events here
    //     } else {
    //         printlP2MM("(P2:MM): Tried to save progress but either saving isn't avaliable or saving isn't enabled in this map...")
    //         EntFire("p2mm_servercommand", "command", "say 'ERROR! FILE SAVING IS NOT AVALIABLE/ENABLED FOR THIS MAP!'")
    //         EntFire("p2mm_servercommand", "command", "say 'PROGRESS WAS NOT SAVED!!!'")
    //     }
    // }
}

// This should be triggered by a button in mp_coop_testroom
function test_file_create() {
    try {
        // This should make a .dem file with read and write permission, testing still in progress
        EntFire("@command_test_file", "command", "_record SAVE/test_nut")
        EntFire("@command_test_file", "command", "stop")
        printlP2MM("(P2:MM): File created succesfully.")
        EntFire("@command_test_file", "command", "ent_create_portal_weighted_cube")
    }   catch (e) {
        // This gets thrown if it fails to create the file
        printlP2MM("(P2:MM): File failed to create.")
        throw e
    }
}
