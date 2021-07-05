Gui, Color, 000001
Gui, Add, Picture, w250 h-1 BackgroundTrans vT1, logo.png
Gui +LastFound +AlwaysOnTop +ToolWindow
WinSet, TransColor, 000001
Gui -Caption
Gui, Show
Menu, Tray, Icon, logo.ico
Random, randvar, 0, 2500
sleep %randvar%
Gui, destroy 


Gui, Add, Picture, x-8 y-1 w930 h530, background.png
Gui, Add, Button, x42 y39 w140 h70 +Border, Start Mod
; Gui, Add, Button, x42 y119 w140 h70 +Border, Reconfigure
Gui, Add, Button, x42 y119 w140 h70 +Border, Update
Gui, Add, Radio, x42 y200 w140 h30 +Border +Center, Windowed Mode
Gui, Add, Picture, x262 y49 w590 h420 +BackgroundTrans, How To Use.png
Gui, Show, x512 y233 h521 w904, Portal 2 Multiplayer Mod
Idle:
Return

ButtonReconfigure:
MsgBox, 4,, Would You Like To Edit The Config?
IfMsgBox Yes
    MsgBox You pressed Yes.
else
    goto idle
Gui, destroy 

GuiClose:
ExitApp