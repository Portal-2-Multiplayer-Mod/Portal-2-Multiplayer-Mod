SendToConsole("script_execute singleplayer")
try {
    if (GlobalRunScript == 0 ){
        printl("GaveUserGun")
    }
} catch(exception) {
    GlobalRunScript <- 50
}

if (GlobalRunScript>=1) {
      local p = null;
      while (p = Entities.FindByClassname(p, "player")){
            SendToConsole("sv_cheats 1")
            SendToConsole("give weapon_portalgun")
            SendToConsole("upgrade_portalgun")
            GlobalRunScript <- GlobalRunScript - 1
      }
}