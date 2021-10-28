# make a gui to launch the game

import os
import tkinter as tk


class GUILauncher(tk.Frame):
    def __init__(self, master=None):
        tk.Frame.__init__(self, master)
        self.grid()
        self.createWidgets()

    def createWidgets(self):
        self.quitButton = tk.Button(self, text='Quit', command=self.quit)
        self.quitButton.grid()

        self.launchButton = tk.Button(self, text='Launch', command=self.launch)
        self.launchButton.grid()

    def launch(self):
        os.system('python3 MultiplayerModFiles/MultiplayerGame.py')

#show the gui
root = tk.Tk()
root.title('Multiplayer Mod Launcher')
root.geometry('300x100')
app = GUILauncher(master=root)
app.mainloop()