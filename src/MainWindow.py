# PySide libraries, needed for the gui
from PySide6 import QtWidgets as qtw
from PySide6 import QtCore as qtc
from PySide6 import QtGui as qtg

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

# for tests
import tests.a as a
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
        self.ui.Button_Discord.clicked.connect(lambda: self.DiscordInvite())
        self.ui.button_CopyIP.clicked.connect(lambda: self.CopyIp())
        
        # this should be the custom toggle button but i didn't get it to work so i'm giving up for now 
        # self.toggle = qtw.QCheckBox()
        # self.ui.layout = qtw.QHBoxLayout(self)
        # self.ui.layout.addWidget(self.toggle, qtg.Qt.AlignCenter, qtg.Qt.AlignCenter)
        
    def OpenGuide(self):
        guideURL = "https://steamcommunity.com/sharedfiles/filedetails/?id=2458260280"
        webbrowser.open(guideURL)
        Log("Opened the steam guide")

    def GetGamePath(self):
        folder = str(qtw.QFileDialog.getExistingDirectory(self, "Select Directory"))
        cfg.EditConfig("portal2path", folder)
        
        
    def ErrorBox(self, text):
        Log(text)
        dialog = qtw.QMessageBox.critical(
            self,
            "Path not found!",
            text,
            buttons= qtw.QMessageBox.Ok | qtw.QMessageBox.Cancel,
            defaultButton= qtw.QMessageBox.Ok,
        )
        return dialog
            
    # mounts the mod when the user clicks on the play button
    def MountMod(self):
        # if the game path is not valid/defined the MounMod method will return undefined 
        # if it does loop until the user gives a valid path or aborts by cancelling on the error message
        while RG.MountMod() == "undefined":
            response = self.ErrorBox("game path is undefined, would you like to select it?")
            if response == qtw.QMessageBox.Ok:
                Log("searching for game path")
            else:
                Log("user canceled search")
                return
            self.GetGamePath()
            
        # if the mod files are missing it will display an error and quit the mounting process
        # we can use this to downlaod the files from github later on
        if RG.MountMod() == "filesMissing":
            self.ErrorBox("the mod files are missing")
            return
        
        RG.LaunchGame()
        
    def DiscordInvite(self):
        discordUrl = "https://discord.com/invite/kW3nG6GKpF"
        webbrowser.open(discordUrl)
        Log("Opened the discord invite")
        
    # i need to make this async
    def GetIp(self):
        # this error handling is temporary i'll fix it later too trust me :)
        try:
            ip = get('https://api.ipify.org').text
            self.ui.button_CopyIP.setText(ip)
            Log("Got the ip")
        except:
            self.ui.button_CopyIP.setText("internet error")
            Log("no internet connection")
    
    def CopyIp(self):
        qtw.QApplication.clipboard().setText("connect "+self.ui.button_CopyIP.text()+":27015")
        Log("coppied the ip")
    
        
def OnStart():
    # populate the global variables
    GVars.init()
    # to do the fancy log thing
    StartLog()
    GVars.LoadConfig()

if __name__ =='__main__':
    app = qtw.QApplication([])
    window = MainUI()
    
    OnStart()
    window.GetIp()
    
    window.show()
    sys.exit(app.exec())