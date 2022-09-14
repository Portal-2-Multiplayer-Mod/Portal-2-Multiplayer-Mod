//
// _____  _____         _____  _____  _____  _____         _____  _____  _____  _____  _____  _____  _____  _____
// |     ||  _  |       |     ||     ||     ||  _  |       |_   _||   __||   __||_   _|| __  ||     ||     ||     |
// | | | ||   __|       |   --||  |  ||  |  ||   __|         | |  |   __||__   |  | |  |    -||  |  ||  |  || | | |
// |_|_|_||__|    _____ |_____||_____||_____||__|    _____   |_|  |_____||_____|  |_|  |__|__||_____||_____||_|_|_|
//               |_____|                            |_____|

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn, MSOnSave) {
    supportsSaves <- false //If your map supports our built-in save system, set this to true
    saveEvents = { //Place your save events for your map here

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

    //This should be triggered by a button in mp_coop_testroom
    function test_file_create() {
        try {
            //This should make a .dem file with read and write permission, testing still in progress
            EntFire("@command_test_file", "command", "_record SAVE/test_nut")
            EntFire("@command_test_file", "command", "stop")
            printl("file created succesfully")
            EntFire("@command_test_file", "command", "ent_create_portal_weighted_cube")
        }   catch (e) {
            //this gets thrown if it fails to create the file
            printl("file failed to create")
            throw e
        }
    }
}
