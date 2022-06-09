# Its mario time fuckers!

from ast import While
import valve.rcon as rcon # pip install python-valve
import time
import PIL.Image as Image
import threading
import sys

address = ("10.0.0.190", 27015)
password = ""
command = ""
server = rcon.RCON(address, password)
server.connect()
server.authenticate()

def send(cmd):
    print(cmd)
    server.execute(cmd)

run = True
while run:
    lst = []

    imagedir = "/home/kyle/Pictures/Screenshot_2022-06-09-43_204x246.png"
    image = Image.open(imagedir)

    scale = 2
    send("script scale <- " + str(scale))

    # scale it to 5% in size
    image.thumbnail((image.size[0] // scale, image.size[1] // scale))
    # go through every pixel and print it's RGB value
    for x in range(image.size[0]):
        for y in range(image.size[1]):
            pixel = image.getpixel((x, y))

            pxval = {
                "r": pixel[0],
                "g": pixel[1],
                "b": pixel[2],
                "x": x,
                "y": y
            }
            # send("script pixel(" + str(pxval["x"]) + "," + str(pxval["y"]) + "," + str(pxval["r"]) + "," + str(pxval["g"]) + "," + str(pxval["b"]) + ")")
            lst.append("script pixel(" + str(pxval["x"]) + "," + str(pxval["y"]) + "," + str(pxval["r"]) + "," + str(pxval["g"]) + "," + str(pxval["b"]) + ")")

    for i in lst:
        threading.Thread(target=send, args=(i,)).start()
        time.sleep(0.01)

    # kill all the threads
    sys.exit(0)

# import pygame
# prex = 0
# prey = 0
# x = 0
# y = 0
# window = pygame.display.set_mode((800, 600))
# pygame.display.set_caption("KylePlaysGod")
# while True:
#     for event in pygame.event.get():
#         if event.type == pygame.QUIT:
#             pygame.quit()
#             quit()

#     window.fill((0, 0, 0))
#     # get the mouse position
#     x, y = pygame.mouse.get_pos()
#     # draw a red square in the middle of the mouse
#     # pygame.draw.rect(window, (255, 0, 0), (x - 25, y - 25, 50, 50))
#     # update the display
#     pygame.display.update()

#     if x != prex or y != prey:
#         prex = x
#         prey = y
#         # script pawns[0].update(x, y)
#         def RCNS():
#             server.execute("script pawns[0].x = " + str(x * -1))
#             server.execute("script pawns[0].y = " + str(y))
#         RCNS()