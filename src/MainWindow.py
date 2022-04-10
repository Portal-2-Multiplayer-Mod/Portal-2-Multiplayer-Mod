# PySide libraries, needed for the gui
from PyQt5 import QtWidgets as qtw
from PyQt5 import QtCore as qtc
from PyQt5 import QtGui as qtg

# OUR modules 
from Views.Ui_MainWindow import Ui_MainWindow
import Scripts.GlobalVariables as GVars
from Scripts.BasicLogger import Log, StartLog
import Scripts.RunGame as RG
import Scripts.Configs as cfg

# other modules for better user experience
from requests import get
import webbrowser
import sys
#----------------------------------------------------------------


class MainUI(qtw.QMainWindow):
    def __init__(self,*args,**kwargs):
        super().__init__(*args,**kwargs)
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)
        
        # Binding click events
        self.ui.actionGuide.triggered.connect(lambda: self.OpenGuide())
        self.ui.Button_Guide.clicked.connect(lambda: self.OpenGuide())
        self.ui.Button_Play.clicked.connect(lambda: self.MountMod())
        self.ui.Button_Unmount.clicked.connect(lambda: self.UnmountMod())
        self.ui.Button_Discord.clicked.connect(lambda: self.DiscordInvite())
        self.ui.Button_CopyIP.clicked.connect(lambda: self.CopyIp())
        
        # this should be the custom toggle button but i didn't get it to work so i'm giving up for now 
        # self.toggle = qtw.QCheckBox()
        # self.ui.layout = qtw.QHBoxLayout(self)
        # self.ui.layout.addWidget(self.toggle, qtg.Qt.AlignCenter, qtg.Qt.AlignCenter)
        
    # opens the steam guide in the browser 
    def OpenGuide(self):
        guideURL = "https://steamcommunity.com/sharedfiles/filedetails/?id=2458260280"
        webbrowser.open(guideURL)
        Log("Opened the steam guide")

    # opens a fileDialog window to select the folder of the mod then saves it in the config file
    def GetGamePath(self):
        folder = str(qtw.QFileDialog.getExistingDirectory(self, "Select Directory"))
        cfg.EditConfig("portal2path", folder)
        Log("saved '"+ folder + "' as the game path")
        
    # a custom-ish error dialog 
    def ErrorBox(self, text):
        Log("Error: "+ text)
        dialog = qtw.QMessageBox.critical(
            self,
            "Error!",
            text,
            buttons= qtw.QMessageBox.Ok | qtw.QMessageBox.Cancel,
            defaultButton= qtw.QMessageBox.Ok,
        )
        return dialog
            
    # mounts the mod and starts the game
    def MountMod(self):
        # checks for the state of the mounting process
        mountState = ""
        # undefined -> the game path in the config file is either undefined or invalid 
        # filesMissing -> the mod's files (ModFiles/Portal 2/install_dlc) are missing
        # true -> the mouting process completed successfully
        while mountState != True:
            # gets the game path from the config file
            gamepath = GVars.configData["portal2path"]
            mountState = RG.MountMod(gamepath)
            if mountState == "undefined":
                response = self.ErrorBox("game path is undefined/ invalid , would you like to select it?")
                if response == qtw.QMessageBox.Ok:
                    Log("searching for game path")
                    self.GetGamePath()
                else:
                    Log("user canceled search")
                    return
                
            if mountState == "filesMissing":
                self.ErrorBox("the mod files are missing")
                return
        # if everything goes well then run the game
        RG.LaunchGame(gamepath)
        
    def UnmountMod(self):
        unmountState = ""
        while unmountState != True:
            gamepath = GVars.configData["portal2path"]
            unmountState = RG.DeleteUnusedDlcs(gamepath)
            if unmountState == "undefined":
                response = self.ErrorBox("game path is undefined/ invalid , would you like to select it?")
                if response == qtw.QMessageBox.Ok:
                    Log("searching for game path")
                    self.GetGamePath()
                else:
                    Log("user canceled search")
                    return
        RG.DeleteUnusedDlcs(gamepath)
        RG.UnpatchBinaries(gamepath)
        Log("unmount completed")
        
    # opens a discord invite in the browser
    def DiscordInvite(self):
        discordUrl = "https://discord.com/invite/kW3nG6GKpF"
        webbrowser.open(discordUrl)
        Log("Opened the discord invite")
        
    # gets the public ip of the user 
    # i need to make this async :>
    def GetIp(self):
        # this error handling is temporary i'll fix it later too trust me :)
        try:
            ip = get('https://api.ipify.org').text
            self.ui.Button_CopyIP.setText(ip)
            Log("Got the ip")
        except:
            self.ui.Button_CopyIP.setText("internet error")
            Log("no internet connection")
    
    # copies the public ip to the user's clipboard when they click on the ip
    def CopyIp(self):
        qtw.QApplication.clipboard().setText("connect "+self.ui.Button_CopyIP.text()+":27015")
        Log("coppied the ip")
      
# runs when the app starts to initialize some variables
# don't log anythin before the StartLog() method  
def OnStart():
    # populate the global variables
    GVars.init()
    # to do the fancy log thing
    StartLog()
    # load the config file into memmory
    GVars.LoadConfig()

if __name__ =='__main__':
    app = qtw.QApplication([])
    window = MainUI()
    
    OnStart()
    window.GetIp()
    
    window.show()
    sys.exit(app.exec_())