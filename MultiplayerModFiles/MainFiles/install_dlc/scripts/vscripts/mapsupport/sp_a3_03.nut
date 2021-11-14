// ██████╗██████╗             █████╗ ██████╗             █████╗ ██████╗
//██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██╔══██╗╚════██╗
//╚█████╗ ██████╔╝           ███████║ █████╔╝           ██║  ██║ █████╔╝
// ╚═══██╗██╔═══╝            ██╔══██║ ╚═══██╗           ██║  ██║ ╚═══██╗
//██████╔╝██║     ██████████╗██║  ██║██████╔╝██████████╗╚█████╔╝██████╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚═════╝ ╚═════════╝ ╚════╝ ╚═════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        Entities.FindByName(null, "pumproom_door_bottom_prop").__KeyValueFromString("targetname", "moja1")
        Entities.FindByName(null, "pumproom_door_bottom_portal").__KeyValueFromString("targetname", "moja2")
        // Here if we need to ent_fire something
        EntFireByHandle(Entities.FindByName(null, "pumproom_door_bottom_button"), "addoutput", "OnPressed moja1:SetAnimation:open", 1, null, null)
        EntFireByHandle(Entities.FindByName(null, "moja2"), "Open", "", 1, null, null)
        // Destroy objects
        Entities.FindByName(null, "fade_to_death-proxy").Destroy()
        Entities.FindByName(null, "lift_shaft_gate").Destroy()
        Entities.FindByName(null, "main_elevator_bottom_clipbrush").Destroy()
        Entities.FindByName(null, "silent_fizzler").Destroy()
        Entities.FindByName(null, "@transition_from_map").Destroy()
        Entities.FindByName(null, "powerup_door_trigger").Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(-6080, -2812, -5160), 20).Destroy()
        EntFireByHandle(Entities.FindByName(null, "AutoInstance1-push_button_knob"), "addoutput", "OnIn powerup_door_prop:SetAnimation:open", 3, null, null)
        EntFireByHandle(Entities.FindByName(null, "AutoInstance1-push_button_knob"), "addoutput", "OnIn powerup_door_sprite:ShowSprite", 3, null, null)
    }

    if (MSPostPlayerSpawn==true) {

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
                if (p.GetOrigin().z<=-5240) {
                    EntFireByHandle(p, "sethealth", "-20", 0, null, null)
                }
            }
            GooHurtTimerPred = Time()+1
        }

        local p = Entities.FindByClassnameNearest("player", Vector(-6400, -2832, -5127), 10)
        try {
            p.SetOrigin(Vector(-6400, -2832, -5160))
        } catch (exception) { }

        // Elevator changelevel
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(-3631, 1284, -2100), 100)) {
            SendToConsole("commentary 1")
            SendToConsole("changelevel sp_a3_jump_intro")
        }
    }
}