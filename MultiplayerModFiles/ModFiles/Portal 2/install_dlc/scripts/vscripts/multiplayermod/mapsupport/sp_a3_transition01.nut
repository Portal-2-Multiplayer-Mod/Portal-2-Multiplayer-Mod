// ██████╗██████╗             █████╗ ██████╗            ████████╗██████╗  █████╗ ███╗  ██╗ ██████╗██╗████████╗██╗ █████╗ ███╗  ██╗ █████╗   ███╗
//██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ╚══██╔══╝██╔══██╗██╔══██╗████╗ ██║██╔════╝██║╚══██╔══╝██║██╔══██╗████╗ ██║██╔══██╗ ████║
//╚█████╗ ██████╔╝           ███████║ █████╔╝              ██║   ██████╔╝███████║██╔██╗██║╚█████╗ ██║   ██║   ██║██║  ██║██╔██╗██║██║  ██║██╔██║
// ╚═══██╗██╔═══╝            ██╔══██║ ╚═══██╗              ██║   ██╔══██╗██╔══██║██║╚████║ ╚═══██╗██║   ██║   ██║██║  ██║██║╚████║██║  ██║╚═╝██║
//██████╔╝██║     ██████████╗██║  ██║██████╔╝██████████╗   ██║   ██║  ██║██║  ██║██║ ╚███║██████╔╝██║   ██║   ██║╚█████╔╝██║ ╚███║╚█████╔╝███████╗
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚═════╝ ╚═════════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚══╝╚═════╝ ╚═╝   ╚═╝   ╚═╝ ╚════╝ ╚═╝  ╚══╝ ╚════╝ ╚══════╝

function StartPermaPotato() {
    PermaPotato = true
}

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        GlobalSpawnClass.useautospawn <- true
        // Make elevator start moving on level load
        EntFireByHandle(Entities.FindByName(null, "InstanceAuto2-entrance_lift_train"), "StartForward", "", 0, null, null)
        // Destroy / Edit objects
        Entities.FindByName(null, "fall_death_fade").Destroy()
        Entities.FindByName(null, "pumproom_door_bottom_trigger").Destroy()
        Entities.FindByName(null, "pumproom_door_top_prop").__KeyValueFromString("targetname", "moja1")
        Entities.FindByName(null, "pumproom_portal_top").__KeyValueFromString("targetname", "moja2")
        Entities.FindByName(null, "sphere_entrance_lift_movelinear").__KeyValueFromString("blockdamage", "10")
        // Here if we need to ent_fire something
        EntFireByHandle(Entities.FindByName(null, "pumproom_door_top_button"), "addoutput", "OnPressed moja1:SetAnimation:open", 1, null, null)
        EntFireByHandle(Entities.FindByName(null, "sphere_entrance_potatos_button"), "addoutput", "OnPressed p232servercommand:command:script StartPermaPotato()", 1, null, null)
        EntFireByHandle(Entities.FindByName(null, "moja2"), "Open", "", 1, null, null)
    }

    if (MSPostPlayerSpawn==true) {
        Entities.FindByName(null, "officedoor_4").__KeyValueFromString("targetname", "moja3")
    }

    if (MSOnPlayerJoin==true) {
        // Find all players
        local p = null
        while (p = Entities.FindByClassname(p, "player")) {
            EntFireByHandle(clientcommand, "Command", "r_flashlightbrightness 1", 0, p, p)
            EntFireByHandle(p, "setfogcontroller", "@environment_lake_fog", 0, null, null)
        }
    }

    if (MSLoop==true) {
        // Goo Damage Code
        try {
        if (GooHurtTimerPred) { printl()}
        } catch (exception) {
            GooHurtTimerPred <- 0
        }

        if (GooHurtTimerPred<=Time()) {
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                if (p.GetOrigin().z<=-6666) {
                    EntFireByHandle(p, "sethealth", "\"-100\"", 0, null, null)
                }
            }
            GooHurtTimerPred = Time()+1
        }

        // Elevator changelevel
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(-2048, -130, -3750), 100)) {
             
            SendToConsole("changelevel sp_a3_speed_ramp")
        }
    }
}