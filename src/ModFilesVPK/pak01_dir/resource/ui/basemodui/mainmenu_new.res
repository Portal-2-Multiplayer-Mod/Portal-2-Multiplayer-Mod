"Resource/UI/MainMenu.res"
{
	"MainMenu"
	{
		"ControlName"				"Frame"
		"fieldName"					"MainMenu"
		"xpos"						"0"
		"ypos"						"0"
		"wide"						"f0"
		"tall"						"f0"
		"autoResize"				"0"
		"pinCorner"					"0"
		"visible"					"1"
		"enabled"					"1"
		"tabPosition"				"0"
		"PaintBackgroundType"		"0"
	}

//	"P2MMMainMenu"
//	{
//		"ControlName"					"Label"
//		"fieldName"						"P2MMMainMenu"
//		"font"							"NewGameChapter"
//		"fgcolor_override"				"255 255 255 255"
//		"xpos"							"70"
//		"ypos"							"200"	[$GAMECONSOLE]  
//		"ypos"							"178"	[!$GAMECONSOLE] 
//		"wide"							"400"
//		"tall"							"150"
//		"visible"						"1"
//		"enabled"						"1"
//		"tabPosition"					"0"
//		"wrap"							"1"
//		"labelText"						"Hi! Welcome to the main menu! The Portal 2: Multiplayer Mod can not start via the buttons on the main menu, so they have been removed. Don't worry! You can start up another play session with `+map mp_coop_lobby_3` (or +ss_map mp_coop_lobby_3 for splitscreen) in the Developer Console. You can also just click quit and exit out back to the launcher and start there."
//		"textAlignment"					"west"
//	}


	"BtnExtras" [!$GAMECONSOLE] //options postiion
	{
		"ControlName"				"BaseModHybridButton"
		"fieldName"					"BtnExtras"
		"xpos"						"88"	[$GAMECONSOLE && ($GAMECONSOLEWIDE && !$ANAMORPHIC)]
		"xpos"						"63"	[$GAMECONSOLE && (!$GAMECONSOLEWIDE || $ANAMORPHIC)]	
		"xpos"						"88"	[!$GAMECONSOLE && $WIN32WIDE]
		"xpos"						"63"	[!$GAMECONSOLE && !$WIN32WIDE]	
		"ypos"						"280"	[$GAMECONSOLE]  
		"ypos"						"258"	[!$GAMECONSOLE] 
		"wide"						"280"
		"tall"						"20"
		"autoResize"				"1"
		"pinCorner"					"0"
		"visible"					"1"
		"enabled"					"1"
		"tabPosition"				"0"
		"navUp"						"BtnEconUI"
		"navDown"					"BtnOptions"
		"labelText"					"Play Portal 2: Multiplayer Mod"
		"style"						"MainMenuButton"
		"command"					"Extras"
		"ActivationType"			"1"
	}


	"BtnOptions"
	{
		"ControlName"				"BaseModHybridButton"
		"fieldName"					"BtnOptions"
		"xpos"						"88"	[$GAMECONSOLE && ($GAMECONSOLEWIDE && !$ANAMORPHIC)]
		"xpos"						"63"	[$GAMECONSOLE && (!$GAMECONSOLEWIDE || $ANAMORPHIC)]	
		"xpos"						"88"	[!$GAMECONSOLE && $WIN32WIDE]
		"xpos"						"63"	[!$GAMECONSOLE && !$WIN32WIDE]	
		"ypos"						"330"	[$GAMECONSOLE]  
		"ypos"						"308"	[!$GAMECONSOLE]   
		"wide"						"220"
		"tall"						"20"
		"autoResize"				"1"
		"pinCorner"					"0"
		"visible"					"1"
		"enabled"					"1"
		"tabPosition"				"0"
		"navUp"						"BtnExtras"
		"navDown"					"BtnQuit"
		"labelText"					"#PORTAL2_MainMenu_Options"
		"style"						"MainMenuButton"
		"command"					"Options"
		"ActivationType"			"1"
	}
	
	"BtnQuit" [!$GAMECONSOLE]
	{
		"ControlName"				"BaseModHybridButton"
		"fieldName"					"BtnQuit"
		"xpos"						"88"	[$WIN32WIDE]
		"xpos"						"63"	[!$WIN32WIDE]	
		"ypos"						"360"	[$GAMECONSOLE]  
		"ypos"						"338"	[!$GAMECONSOLE]   
		"wide"						"220"
		"tall"						"20"
		"autoResize"				"1"
		"pinCorner"					"0"
		"visible"					"1"
		"enabled"					"1"
		"tabPosition"				"0"
		"navUp"						"BtnQuit"
		"navDown"					"BtnEconUI"
		"labelText"					"#PORTAL2_MainMenu_Quit"
		"style"						"MainMenuButton"
		"command"					"QuitGame"
		"ActivationType"			"1"
	}

	"BtnEconUI" [!$GAMECONSOLE]
	{
		"ControlName"				"BaseModHybridButton"
		"fieldName"					"BtnEconUI"
		"xpos"						"97"	[$WIN32WIDE]
		"xpos"						"72"	[!$WIN32WIDE]	
		"ypos"						"420"   
		"wide"						"220"
		"tall"						"20"
		"autoResize"				"1"
		"pinCorner"					"0"
		"visible"					"1"
		"enabled"					"1"
		"tabPosition"				"0"
		"navUp"						"BtnQuit"
		"navDown"					"BtnOptions"
		"labelText"					"#PORTAL2_MainMenu_Econ"
		"style"						"BitmapButton"
		"command"					"EconUI"
		"ActivationType"			"1"
		"bitmap_enabled"			"vgui/store/store_button"
		"bitmap_focus"				"vgui/store/store_button_focus_anim"
	}
}
