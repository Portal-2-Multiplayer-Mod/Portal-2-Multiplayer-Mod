# Its mario time fuckers!

from ast import While
import valve.rcon as rcon # pip install python-valve
import time
import PIL.Image as Image
import threading
import sys

address = ("10.0.0.190", 27015)
password = "a"
command = ""
server = rcon.RCON(address, password)
try:
    server.connect()
except:
    print("Failed to connect to server")
    sys.exit()
try:
    server.authenticate()
except:
    print("Authentication failed")
    sys.exit()

def send(cmd):
    output = server.execute(cmd)
    return output.text

coords = (0, 0)
fwdvec = (0, 0)
mousepos = (0, 0)
ConnectedToServer = True
MovePlayer = True
def Heartbeat():
    global MovePlayer
    global coords
    global fwdvec
    TimeSeinceLastHeartbeat = 0
    while True:
        out = send("script Heartbeat()")
        if out.strip() == "":
            TimeSeinceLastHeartbeat += 1
            if TimeSeinceLastHeartbeat > 10:
                print("Server is down")
                ConnectedToServer = False
                sys.exit(0)
        elif out.strip() == "1":
            TimeSeinceLastHeartbeat = 0
            out = send("script DumpData()")
            out = out.strip()
            out = out.split("\n")
            indx = -1
            for line in out:
                indx += 1
                out[indx] = line.split(":")
            print(out)
            coords = eval(out[0][1])
            coords = ((coords[0] - 5146) * -1, coords[1] - 3573)
            fwdvec = eval(out[1][1])
            fwdvec = ((fwdvec[0] * -1) * 100, (fwdvec[1]) * 100)
            send("script linex <- " + str((mousepos[0] * -1) + 5146))
            send("script liney <- " + str((mousepos[1] ) + 3573))
            if (MovePlayer):
                send("script UpdatePlayerPos()")
                MovePlayer = False
        time.sleep(0.01)
threading.Thread(target=Heartbeat).start()

# while True:
#     # replace the first number in the tuple with the x coord
#     print(coords)

# run = True
# while run:
#     lst = []

#     imagedir = "/home/kyle/Pictures/Screenshot_2022-06-09-47_424x121.png"
#     image = Image.open(imagedir)

#     scale = 2
#     send("script scale <- " + str(scale))

#     # scale it to 5% in size
#     image.thumbnail((image.size[0] // scale, image.size[1] // scale))
#     # go through every pixel and print it's RGB value
#     for x in range(image.size[0]):
#         for y in range(image.size[1]):
#             pixel = image.getpixel((x, y))

#             pxval = {
#                 "r": pixel[0],
#                 "g": pixel[1],
#                 "b": pixel[2],
#                 "x": x,
#                 "y": y
#             }
#             # send("script pixel(" + str(pxval["x"]) + "," + str(pxval["y"]) + "," + str(pxval["r"]) + "," + str(pxval["g"]) + "," + str(pxval["b"]) + ")")
#             lst.append("script pixel(" + str(pxval["x"]) + "," + str(pxval["y"]) + "," + str(pxval["r"]) + "," + str(pxval["g"]) + "," + str(pxval["b"]) + ")")

#     for i in lst:
#         threading.Thread(target=send, args=(i,)).start()
#         time.sleep(0.01)

#     # kill all the threads
#     sys.exit(0)

import pygame
prex = 0
prey = 0
x = 0
y = 0
window = pygame.display.set_mode((800, 600))
pygame.display.set_caption("KylePlaysGod")
while True:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            quit()

    window.fill((0, 0, 0))
    # # get the mouse position
    x, y = pygame.mouse.get_pos()
    mousepos = (x, y)
    pygame.draw.rect(window, (255, 0, 0), (coords[0] - 25, coords[1] - 25, 50, 50))
    

    pygame.draw.line(window, (255, 255, 0), (coords[0], coords[1]), (x, y), 1)
    pygame.draw.line(window, (255, 255, 255), (coords[0], coords[1]), ((coords[0]) + fwdvec[0], (coords[1]) + fwdvec[1]), 1)

    # # update the display
    pygame.display.update()

    # if the user clicks the mouse
    if pygame.mouse.get_pressed()[0]:
        MovePlayer = True

    # if x != prex or y != prey:
    #     prex = x
    #     prey = y
    #     # script pawns[0].update(x, y)
    #     def RCNS():
    #         server.execute("script pawns[0].x = " + str(x * -1))
    #         server.execute("script pawns[0].y = " + str(y))
    #     RCNS()