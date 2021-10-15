pybyteString = input("Input PyBytes: ")
try:
    print(pybyteString)
    pybyteString = pybyteString[2:-1]
    pybyteString = bytes(pybyteString, 'utf-8')
    pyhex = pybyteString.hex()
    reghex = ' '.join([pyhex[i:i+2] for i in range(0, len(pyhex), 2)])
    print("")
    print("Hex: " + reghex)
    print("")
except:
    print("ERROR: INVALID PYBYTES")
    print("Please Input A: b'PYHEX' (A Binary String)")
input("Press Enter To Exit")
