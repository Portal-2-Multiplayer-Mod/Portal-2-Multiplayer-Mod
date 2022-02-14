// ██████╗██████╗             █████╗ ██████╗            ██████╗ ██╗   ██╗ █████╗ ██╗                ██╗      █████╗  ██████╗███████╗██████╗  ██████╗
//██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██╔══██╗██║   ██║██╔══██╗██║                ██║     ██╔══██╗██╔════╝██╔════╝██╔══██╗██╔════╝
//╚█████╗ ██████╔╝           ███████║  ███╔═╝           ██║  ██║██║   ██║███████║██║                ██║     ███████║╚█████╗ █████╗  ██████╔╝╚█████╗ 
// ╚═══██╗██╔═══╝            ██╔══██║██╔══╝             ██║  ██║██║   ██║██╔══██║██║                ██║     ██╔══██║ ╚═══██╗██╔══╝  ██╔══██╗ ╚═══██╗
//██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗██████╔╝╚██████╔╝██║  ██║███████╗██████████╗███████╗██║  ██║██████╔╝███████╗██║  ██║██████╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═════════╝╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝╚═════╝ 

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        GlobalSpawnClass.useautospawn <- true
        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)
        Entities.FindByName(null, "door_0-close_door_rl").Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(640, 224, 936), 1024).Destroy()
        Entities.FindByClassnameNearest("trigger_multiple", Vector(488, 216, 960), 1024).Destroy()
    }

    if (MSPostPlayerSpawn==true) {
        NewApertureStartElevatorFixes()
    }

    if (MSLoop==true) {
        // Make Wheatley look at nearest player
        local ClosestPlayerMain = Entities.FindByClassnameNearest("player", Entities.FindByName(null, "spherebot_1_bottom_swivel_1").GetOrigin(), 10000)
        EntFireByHandle(Entities.FindByName(null, "spherebot_1_bottom_swivel_1"), "SetTargetEntity", ClosestPlayerMain.GetName(), 0, null, null)

        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(1063, 210, 277), 50)) {
             
            SendToConsole("changelevel sp_a2_laser_over_goo")
        }
    }
}