function GivePortalGunStageOne() {
            SendToConsole("sv_cheats 1")
            SendToConsole("give weapon_portalgun")
}
function GivePortalGunStageTwo() {
            SendToConsole("sv_cheats 1")
            SendToConsole("give weapon_portalgun")
            SendToConsole("upgrade_portalgun")
}
function GivePortalGunStageThree() {
            SendToConsole("sv_cheats 1")
            SendToConsole("give weapon_portalgun")
            SendToConsole("upgrade_portalgun")
            SendToConsole("upgrade_potatogun")
}

MapName <- GetMapName()
MapNameSliced <- MapName.slice(0,5);
OnePortalMaps <- ["sp_a1_intro4", "sp_a1_intro5", "sp_a1_intro6", "sp_a1_intro7", "sp_a1_wakeup"]
TwoPortalMaps <- ["sp_a3_00", "sp_a3_01", "sp_a3_03", "sp_a3_jump_intro", "sp_a3_bomb_flings", "sp_a3_crazy_box", "sp_a3_transition01"]
ThreePortalMaps <- ["sp_a3_speed_ramp", "sp_a3_speed_flings", "sp_a3_portal_intro", "sp_a3_end", "", "", "", "", "", "", "", "", "", "", "", ]

try {
    if (GlobalRunScript == 0){
        printl("GaveUserGun")
    } else{
          SendToConsole("script_execute singleplayer")
    }
} catch(exception) {
    GlobalRunScript <- 50
    SendToConsole("script_execute singleplayer")
}

if (GlobalRunScript>=1) {
      local p = null;
      while (p = Entities.FindByClassname(p, "player")){
            printl(MapNameSliced)
            //oneportalgun
            foreach (value in OnePortalMaps) {
                  if (value == MapName) {
                        GivePortalGunStageOne()
                  }
            }
            //twoportalgun
            if (MapNameSliced == "sp_a2") {
                  GivePortalGunStageTwo()
            } else {
            foreach (value in TwoPortalMaps) {
                  if (value == MapName) {
                        GivePortalGunStageTwo()
                              }
                        }
                  }
            //potatos
            if (MapNameSliced == "sp_a4") {
                  GivePortalGunStageThree()
            } else {
            foreach (value in ThreePortalMaps) {
                  if (value == MapName) {
                        GivePortalGunStageThree()
                              }
                        }
                  }

            GlobalRunScript <- GlobalRunScript - 1
      }
}
if (GlobalRunScript==0) {
      SendToConsole("say Playing In Singleplayer                                          [Multiplayer Mod In: SP BugFix Mode]")
}