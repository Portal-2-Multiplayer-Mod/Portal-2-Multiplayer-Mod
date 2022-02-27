// ██████╗██████╗             █████╗ ██████╗            ██╗      █████╗  ██████╗███████╗██████╗             █████╗ ██╗   ██╗███████╗██████╗             ██████╗  █████╗  █████╗ 
//██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██║     ██╔══██╗██╔════╝██╔════╝██╔══██╗           ██╔══██╗██║   ██║██╔════╝██╔══██╗           ██╔════╝ ██╔══██╗██╔══██╗
//╚█████╗ ██████╔╝           ███████║  ███╔═╝           ██║     ███████║╚█████╗ █████╗  ██████╔╝           ██║  ██║╚██╗ ██╔╝█████╗  ██████╔╝           ██║  ██╗ ██║  ██║██║  ██║
// ╚═══██╗██╔═══╝            ██╔══██║██╔══╝             ██║     ██╔══██║ ╚═══██╗██╔══╝  ██╔══██╗           ██║  ██║ ╚████╔╝ ██╔══╝  ██╔══██╗           ██║  ╚██╗██║  ██║██║  ██║
//██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗███████╗██║  ██║██████╔╝███████╗██║  ██║██████████╗╚█████╔╝  ╚██╔╝  ███████╗██║  ██║██████████╗╚██████╔╝╚█████╔╝╚█████╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝╚═════════╝ ╚════╝    ╚═╝   ╚══════╝╚═╝  ╚═╝╚═════════╝ ╚═════╝  ╚════╝  ╚════╝ 

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        GlobalSpawnClass.useautospawn <- true
        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)
        Entities.FindByName(null, "@repair_wall_kill_all").Destroy()
        Entities.FindByName(null, "door_1-close_door_rl").Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(2552, -1056, 142.82), 1024).Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(2432, -1056, 72), 1024).Destroy()
    }

    if (MSPostPlayerSpawn==true) {
        NewApertureStartElevatorFixes()
        // Entities.FindByName(null, "wall_panel_2-robo_powerup_corridor_01bendy02").__KeyValueFromString("targetname", "P232_Wall_Panel_2-Robo_Powerup_Corridor_01_override")
        // Entities.FindByName(null, "wall_panel_2-robo_powerup_corridor_02bendy02").__KeyValueFromString("targetname", "P232_Wall_Panel_2-Robo_Powerup_Corridor_02_override")
        // Entities.FindByName(null, "wall_panel_2-robo_powerup_corridor_03bendy02").__KeyValueFromString("targetname", "P232_Wall_Panel_2-Robo_Powerup_Corridor_03_override")
        // Entities.FindByName(null, "wall_panel_2-robo_powerup_corridor_04bendy02").__KeyValueFromString("targetname", "P232_Wall_Panel_2-Robo_Powerup_Corridor_04_override")
        // Entities.FindByName(null, "wall_panel_2-robo_powerup_corridor_05bendy02").__KeyValueFromString("targetname", "P232_Wall_Panel_2-Robo_Powerup_Corridor_05_override")
        // Entities.FindByName(null, "wall_panel_2-robo_powerup_corridor_06bendy02").__KeyValueFromString("targetname", "P232_Wall_Panel_2-Robo_Powerup_Corridor_06_override")
        // Entities.FindByName(null, "wall_panel_2-robo_powerup_corridor_07bendy02").__KeyValueFromString("targetname", "P232_Wall_Panel_2-Robo_Powerup_Corridor_07_override")
        // Entities.FindByName(null, "wall_panel_2-robo_powerup_corridor_08bendy02").__KeyValueFromString("targetname", "P232_Wall_Panel_2-Robo_Powerup_Corridor_08_override")
    }

    if (MSLoop==true) {
        // Elevator changelevel
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(2008, -1055, -328), 50)) {
             
            SendToConsole("changelevel sp_a2_catapult_intro")
        }
    }
}