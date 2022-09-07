//Test script to test file creation via Source VScript
//This VScript will simply make a .txt simple text

function test_file_test() {
    try {
        local test_file = file("test_file.txt", w+);
        printl("file created succesfully");
    } catch (exception) {
        printl("file failed to create");
    }

    
}
    




