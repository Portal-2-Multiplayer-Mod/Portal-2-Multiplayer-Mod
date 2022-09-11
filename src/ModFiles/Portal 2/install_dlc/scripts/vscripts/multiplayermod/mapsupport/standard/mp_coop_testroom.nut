// __  ___    ____           ______   ____    ____     ____          ______    ______   _____  ______    ____    ____    ____     __  ___
// /  |/  /   / __ \         / ____/  / __ \  / __ \   / __ \        /_  __/   / ____/  / ___/ /_  __/   / __ \  / __ \  / __ \   /  |/  /
// / /|_/ /   / /_/ /        / /      / / / / / / / /  / /_/ /         / /     / __/     \__ \   / /     / /_/ / / / / / / / / /  / /|_/ /
// / /  / /   / ____/        / /___   / /_/ / / /_/ /  / ____/         / /     / /___    ___/ /  / /     / _, _/ / /_/ / / /_/ /  / /  / /
// /_/  /_/   /_/       ______\____/   \____/  \____/  /_/       ______/_/     /_____/   /____/  /_/     /_/ |_|  \____/  \____/  /_/  /_/
//                     /_____/                                  /_____/

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        printl("MP_COOP_TESTROOM.NUT LOADED")
    }

    if (MSLoop) {

    }

    if (MSPostPlayerSpawn) {
        EntFire("@command_test_file", "command", "ent_create_portal_weighted_cube")
    }

    if (MSPostMapSpawn) {
        /*
        This next part should load with mapspawn.nut, if the .nut loads it will spawn a sphere
        Else it will either send to the console it failed
        */
        try {
            SendToConsoleP232("ent_create_portal_weighted_sphere")
            printl("Sphere made")
        } catch (e) {
            // A fallback is used if SendToConsoleP232 doesn't work properly
            throw e;
            try {
                printl("EntFire failed, using fallback command")
                EntFire("@command_test_file", "command", "ent_create_portal_weighted_sphere")
                printl("Sphere made via fallback")
            } catch (e) {
                //This should only happen if everything fricks up
                printl("FATAL!!! COMMANDS FAILED!!! NUT LOADED BUT BOTH SPHERE CREATIONS FAILED!")
                throw e;
            }
        }
    }

    if (MSOnPlayerJoin) {

    }

    if (MSOnDeath) {

    }

    if (MSOnRespawn) {

    }
    //Test script to test file creation via Source VScript
    //This VScript will simply make a .txt simple text with no contents
    //This function is not called when the .nut is first started, should be triggered by a button in mp_coop_testroom
    function test_file_test() {
        try {
            //This should make a txt file with read and write permission, testing still in progress
            //test_file = file("test_file.txt","wb+")
            printl("file created succesfully")
            EntFire("@command_test_file", "command", "ent_create_portal_weighted_cube")
        } catch (e) {
            //this gets thrown if it fails to create the file
            throw e;
            printl("file failed to create")
        }
    }
}
