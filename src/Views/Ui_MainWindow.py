# -*- coding: utf-8 -*-

################################################################################
## Form generated from reading UI file 'MainWindow.ui'
##
## Created by: Qt User Interface Compiler version 6.2.4
##
## WARNING! All changes made in this file will be lost when recompiling UI file!
################################################################################

from PySide6.QtCore import (QCoreApplication, QDate, QDateTime, QLocale,
    QMetaObject, QObject, QPoint, QRect,
    QSize, QTime, QUrl, Qt)
from PySide6.QtGui import (QAction, QBrush, QColor, QConicalGradient,
    QCursor, QFont, QFontDatabase, QGradient,
    QIcon, QImage, QKeySequence, QLinearGradient,
    QPainter, QPalette, QPixmap, QRadialGradient,
    QTransform)
from PySide6.QtWidgets import (QApplication, QCheckBox, QLabel, QMainWindow,
    QMenu, QMenuBar, QPushButton, QSizePolicy,
    QStatusBar, QWidget)

class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        if not MainWindow.objectName():
            MainWindow.setObjectName(u"MainWindow")
        MainWindow.resize(795, 524)
        icon = QIcon()
        icon.addFile(u"Resources/Images/MainWindowIcon.png", QSize(), QIcon.Normal, QIcon.Off)
        MainWindow.setWindowIcon(icon)
        MainWindow.setStyleSheet(u"font: 63 20pt \"Quicksand SemiBold\";\n"
"color: rgb(104, 150, 137);\n"
"background-color: rgb(11, 60, 73);")
        self.actionGuide = QAction(MainWindow)
        self.actionGuide.setObjectName(u"actionGuide")
        self.actionCheck_for_update = QAction(MainWindow)
        self.actionCheck_for_update.setObjectName(u"actionCheck_for_update")
        self.actionSettings = QAction(MainWindow)
        self.actionSettings.setObjectName(u"actionSettings")
        self.actionAbout = QAction(MainWindow)
        self.actionAbout.setObjectName(u"actionAbout")
        self.centralwidget = QWidget(MainWindow)
        self.centralwidget.setObjectName(u"centralwidget")
        self.Button_Play = QPushButton(self.centralwidget)
        self.Button_Play.setObjectName(u"Button_Play")
        self.Button_Play.setGeometry(QRect(10, 390, 141, 51))
        self.Button_Play.setStyleSheet(u"color: rgb(19, 231, 69);\n"
"font: 600 30pt \"Quicksand\";")
        self.Button_Play.setFlat(True)
        self.label = QLabel(self.centralwidget)
        self.label.setObjectName(u"label")
        self.label.setEnabled(True)
        self.label.setGeometry(QRect(0, 20, 100, 100))
        self.label.setPixmap(QPixmap(u"Resources/Images/logo.svg"))
        self.label.setScaledContents(True)
        self.label_2 = QLabel(self.centralwidget)
        self.label_2.setObjectName(u"label_2")
        self.label_2.setGeometry(QRect(10, 140, 121, 21))
        self.button_CopyIP = QPushButton(self.centralwidget)
        self.button_CopyIP.setObjectName(u"button_CopyIP")
        self.button_CopyIP.setGeometry(QRect(120, 130, 211, 41))
        sizePolicy = QSizePolicy(QSizePolicy.Minimum, QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.button_CopyIP.sizePolicy().hasHeightForWidth())
        self.button_CopyIP.setSizePolicy(sizePolicy)
        font = QFont()
        font.setPointSize(20)
        font.setBold(False)
        font.setItalic(False)
        font.setUnderline(True)
        font.setKerning(True)
        self.button_CopyIP.setFont(font)
        self.button_CopyIP.setLayoutDirection(Qt.RightToLeft)
        self.button_CopyIP.setAutoFillBackground(False)
        self.button_CopyIP.setStyleSheet(u"\n"
"text-decoration: underline;")
        icon1 = QIcon()
        icon1.addFile(u"Resources/Images/copy-icon.svg", QSize(), QIcon.Normal, QIcon.Off)
        self.button_CopyIP.setIcon(icon1)
        self.button_CopyIP.setCheckable(False)
        self.button_CopyIP.setFlat(True)
        self.label_3 = QLabel(self.centralwidget)
        self.label_3.setObjectName(u"label_3")
        self.label_3.setGeometry(QRect(10, 180, 231, 31))
        self.Button_DeveloperMode = QCheckBox(self.centralwidget)
        self.Button_DeveloperMode.setObjectName(u"Button_DeveloperMode")
        self.Button_DeveloperMode.setGeometry(QRect(230, 180, 21, 31))
        self.Button_DeveloperMode.setLayoutDirection(Qt.RightToLeft)
        self.Button_DeveloperMode.setTristate(False)
        self.Button_Guide = QPushButton(self.centralwidget)
        self.Button_Guide.setObjectName(u"Button_Guide")
        self.Button_Guide.setGeometry(QRect(720, 390, 71, 51))
        font1 = QFont()
        font1.setPointSize(30)
        font1.setBold(True)
        font1.setItalic(False)
        self.Button_Guide.setFont(font1)
        self.Button_Guide.setStyleSheet(u"color: rgb(19, 231, 69);\n"
"border-color: rgb(19, 231, 69);\n"
"font: 600 30pt \"Quicksand\";")
        self.Button_Guide.setIconSize(QSize(30, 30))
        self.Button_Guide.setFlat(True)
        self.Button_Discord = QPushButton(self.centralwidget)
        self.Button_Discord.setObjectName(u"Button_Discord")
        self.Button_Discord.setGeometry(QRect(630, 390, 71, 51))
        self.Button_Discord.setStyleSheet(u"color: rgb(19, 231, 69);\n"
"border-color: rgb(19, 231, 69);")
        icon2 = QIcon()
        icon2.addFile(u"Resources/Images/discord-icon.svg", QSize(), QIcon.Normal, QIcon.Off)
        self.Button_Discord.setIcon(icon2)
        self.Button_Discord.setIconSize(QSize(50, 50))
        self.Button_Discord.setFlat(True)
        MainWindow.setCentralWidget(self.centralwidget)
        self.menubar = QMenuBar(MainWindow)
        self.menubar.setObjectName(u"menubar")
        self.menubar.setGeometry(QRect(0, 0, 795, 40))
        self.menuSettings_2 = QMenu(self.menubar)
        self.menuSettings_2.setObjectName(u"menuSettings_2")
        self.menuHelp = QMenu(self.menubar)
        self.menuHelp.setObjectName(u"menuHelp")
        MainWindow.setMenuBar(self.menubar)
        self.statusbar = QStatusBar(MainWindow)
        self.statusbar.setObjectName(u"statusbar")
        MainWindow.setStatusBar(self.statusbar)

        self.menubar.addAction(self.menuSettings_2.menuAction())
        self.menubar.addAction(self.menuHelp.menuAction())
        self.menuSettings_2.addAction(self.actionSettings)
        self.menuHelp.addAction(self.actionGuide)
        self.menuHelp.addAction(self.actionCheck_for_update)
        self.menuHelp.addSeparator()
        self.menuHelp.addAction(self.actionAbout)

        self.retranslateUi(MainWindow)

        self.Button_Guide.setDefault(False)
        self.Button_Discord.setDefault(False)


        QMetaObject.connectSlotsByName(MainWindow)
    # setupUi

    def retranslateUi(self, MainWindow):
        MainWindow.setWindowTitle(QCoreApplication.translate("MainWindow", u"Portal 2: Multiplayer Mod", None))
        self.actionGuide.setText(QCoreApplication.translate("MainWindow", u"Guide", None))
#if QT_CONFIG(statustip)
        self.actionGuide.setStatusTip(QCoreApplication.translate("MainWindow", u"opens the browser to show a guide on how to set up", None))
#endif // QT_CONFIG(statustip)
        self.actionCheck_for_update.setText(QCoreApplication.translate("MainWindow", u"Check for update", None))
#if QT_CONFIG(statustip)
        self.actionCheck_for_update.setStatusTip(QCoreApplication.translate("MainWindow", u"checks for updates for the mod", None))
#endif // QT_CONFIG(statustip)
        self.actionSettings.setText(QCoreApplication.translate("MainWindow", u"Settings", None))
#if QT_CONFIG(statustip)
        self.actionSettings.setStatusTip(QCoreApplication.translate("MainWindow", u"opens the settings menu", None))
#endif // QT_CONFIG(statustip)
        self.actionAbout.setText(QCoreApplication.translate("MainWindow", u"About", None))
        self.Button_Play.setText(QCoreApplication.translate("MainWindow", u"Play", None))
        self.label.setText("")
        self.label_2.setText(QCoreApplication.translate("MainWindow", u"Public IP:", None))
#if QT_CONFIG(tooltip)
        self.button_CopyIP.setToolTip("")
#endif // QT_CONFIG(tooltip)
        self.button_CopyIP.setText(QCoreApplication.translate("MainWindow", u"123.456.789.123", None))
        self.label_3.setText(QCoreApplication.translate("MainWindow", u"<html><head/><body><p><span style=\" font-weight:600; color:#da2c38;\">Developer Mode:</span></p></body></html>", None))
        self.Button_DeveloperMode.setText("")
        self.Button_Guide.setText(QCoreApplication.translate("MainWindow", u"?", None))
        self.Button_Discord.setText("")
        self.menuSettings_2.setTitle(QCoreApplication.translate("MainWindow", u"Options", None))
        self.menuHelp.setTitle(QCoreApplication.translate("MainWindow", u"Help", None))
    # retranslateUi

