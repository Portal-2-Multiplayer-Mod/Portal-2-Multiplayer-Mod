//Test script to test file creation via Source VScript
//This VScript will simply make a .txt simple text file with no contents

//This function is not called when the .nut is first started, should be triggered by a button in mp_coop_testroom
function test_file_create() {
    try {
        //This should make a txt file with read and write permission, testing still in progress
        test_file = file("test_file.txt","wb+");
        printl("file created succesfully")
        EntFire("@command_test_file", "command", "ent_create_portal_weighted_cube")
    } catch (e) {
        //this gets thrown if it fails to create the file
        throw e;
        printl("file failed to create")
    }
}

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