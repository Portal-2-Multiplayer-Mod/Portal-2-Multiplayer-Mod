// ██████╗██████╗             █████╗   ██╗██╗           ███████╗██╗███╗  ██╗ █████╗ ██╗     ███████╗██████╗ 
//██╔════╝██╔══██╗           ██╔══██╗ ██╔╝██║           ██╔════╝██║████╗ ██║██╔══██╗██║     ██╔════╝╚════██╗
//╚█████╗ ██████╔╝           ███████║██╔╝ ██║           █████╗  ██║██╔██╗██║███████║██║     █████╗   █████╔╝
// ╚═══██╗██╔═══╝            ██╔══██║███████║           ██╔══╝  ██║██║╚████║██╔══██║██║     ██╔══╝   ╚═══██╗
//██████╔╝██║     ██████████╗██║  ██║╚════██║██████████╗██║     ██║██║ ╚███║██║  ██║███████╗███████╗██████╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝     ╚═╝╚═════════╝╚═╝     ╚═╝╚═╝  ╚══╝╚═╝  ╚═╝╚══════╝╚══════╝╚═════╝ 

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    // Wheatley crusher glitch (Moja)
    if (MSInstantRun==true) {
        PermaPotato <- true
        Entities.FindByClassnameNearest("prop_dynamic", Vector(736, -1832, 185), 20).__KeyValueFromString("targetname", "moja1")
        Entities.FindByName(null, "airlock_door2").__KeyValueFromString("targetname", "moja2")
        Entities.FindByName(null, "airlock_door2_brush").__KeyValueFromString("targetname", "moja3")
        Entities.FindByName(null, "airlock_door2_areaportal").__KeyValueFromString("targetname", "moja4")
        Entities.FindByName(null, "practice_bomb_timer").__KeyValueFromString("targetname", "moja5")
        Entities.FindByName(null, "areaportal_1").__KeyValueFromString("targetname", "moja6")
        Entities.FindByName(null, "light_shadowed_02").__KeyValueFromString("targetname", "moja7")
        // Here if we need to ent_fire something
        EntFireByHandle(Entities.FindByName(null, "light_dynamic_2nd_office"), "TurnOn", "", 1, null, null)
        EntFireByHandle(Entities.FindByName(null, "global_ents-proxy"), "OnProxyRelay16", "", 1, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-32, -1032, 32), 20), "addoutput", "OnTrigger moja2:SetAnimation:vert_door_opening", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-32, -1032, 32), 20), "addoutput", "OnTrigger moja3:Disable", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-32, -1032, 32), 20), "addoutput", "OnTrigger moja4:Open", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "bomb_1_down_counter"), "addoutput", "OnHitMax moja5:Disable", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "bomb_1_button_relay"), "addoutput", "OnTrigger moja5:Disable", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "bomb_1_divert_down_relay"), "addoutput", "OnTrigger moja5:Enable::4.5", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "bomb_1_divert_up_relay"), "addoutput", "OnTrigger moja5:Enable::4.5", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "push_paint_platform"), "addoutput", "OnStartTouch moja7:TurnOn", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(-960, 416, -256), 20), "addoutput", "OnStartTouch moja7:TurnOn", 0, null, null)
        // Destroy objects
        Entities.FindByName(null, "death_fade").Destroy()
        Entities.FindByName(null, "door_lair-close_door_fast").Destroy()
        Entities.FindByName(null, "transition_trigger").Destroy()
        Entities.FindByClassnameNearest("logic_auto", Vector(720, -2048, 152), 20).Destroy()
    }

    if (MSPostPlayerSpawn==true) {
        EntFireByHandle(Entities.FindByName(null, "entry_door-proxy"), "OnProxyRelay1", "", 0, null, null)
    }

    if (MSLoop==true) {
        // Make Wheatley look at nearest player
        try {
            local ClosestPlayerMain = Entities.FindByClassnameNearest("player", Entities.FindByName(null, "wheatley_screen-screen_tank").GetOrigin(), 10000)
            EntFireByHandle(Entities.FindByName(null, "wheatley_screen-screen_tank"), "SetTargetEntity", ClosestPlayerMain.GetName(), 0, null, null)
        } catch(exception) {}

        // Make our own changelevel trigger
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(-616, 5376, 720), 200)) {
             
            SendToConsoleP232("changelevel sp_a4_finale4")
        }
    }
}