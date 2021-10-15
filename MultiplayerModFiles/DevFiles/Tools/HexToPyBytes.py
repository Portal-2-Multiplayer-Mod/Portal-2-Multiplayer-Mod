byteString = input("Input Bytes: ")
try:
    bytes = bytes.fromhex(byteString)
    print("")
    print("PyBytes: " + bytes)
    print("")
except:
    print("ERROR: INVALID BYTES")
    print("Please Input A String Simular To: a8 00 0f 84 f5 fc ff")
input("Press Enter To Exit")