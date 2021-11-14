// ██████╗██████╗             █████╗ ██████╗            ██╗███╗  ██╗████████╗██████╗  █████╗ 
//██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗
//╚█████╗ ██████╔╝           ███████║  ███╔═╝           ██║██╔██╗██║   ██║   ██████╔╝██║  ██║
// ╚═══██╗██╔═══╝            ██╔══██║██╔══╝             ██║██║╚████║   ██║   ██╔══██╗██║  ██║
//██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝ 

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        Entities.FindByName(null, "incinerator_death_fade").Destroy()
        Entities.FindByName(null, "camera_ghostAnim").Destroy()
        Entities.FindByName(null, "door_0-close_door_rl").Destroy()
        Entities.FindByName(null, "incinerator_window_brush").Destroy()
        Entities.FindByName(null, "incinerator_portal").__KeyValueFromString("FadeStartDist", "1750")
        Entities.FindByName(null, "incinerator_portal").__KeyValueFromString("FadeDist", "1950")
        Entities.FindByName(null, "incinerator_portal").__KeyValueFromString("targetname", "incinerator_portal_custom")
        EntFire("@enable_arms", "trigger", "", 0, null)
        Entities.FindByName(null, "InstanceAuto13-dangle_ceiling-disable_arms").Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(2704, -1260, 112), 1024).Destroy()
    }

    if (MSPostPlayerSpawn==true) {
        printl("Ran")
        SpA2IntroViewcontrol <- Entities.CreateByClassname("point_viewcontrol_multiplayer")
        SpA2IntroViewcontrol.__KeyValueFromString("targetname", "SpA2IntroViewcontrol")
        SpA2IntroViewcontrol.__KeyValueFromString("target_team", "-1")
        SpA2IntroViewcontrol.SetOrigin(Entities.FindByName(null, "ghostAnim").GetOrigin())
        EntFire("SpA2IntroViewcontrol", "setparent", "ghostAnim", 0, null)
        EntFire("SpA2IntroViewcontrol", "setparentattachment", "attach_1", 0, null)
        EntFire("SpA2IntroViewcontrol", "enable", "", 0, null)
        EntFire("SpA2IntroViewcontrolTele", "disable", "", 20.75, null)
        EntFire("SpA2IntroViewcontrol", "addoutput", "targetname SpA2IntroViewcontrolTele", 0.25, null)
        EntFire("SpA2IntroViewcontrolTele", "addoutput", "targetname SpA2IntroViewcontrolDone", 20.80, null)
        self.PrecacheSoundScript("ScriptedSequence.IncineratorFall")
        local TempEnt = Entities.CreateByClassname("prop_dynamic")
        TempEnt.__KeyValueFromString("targetname", "TempEnt")
        EntFire("TempEnt", "addoutput", "targetname PlayFallSound", 0, null)
        EntFire("PlayFallSound", "kill", "", 0 + (TickSpeed * 2), null)
    }

    if (MSLoop==true) {

        if (Entities.FindByName(null, "PlayFallSound")) {
        Entities.FindByName(null, "blue").EmitSound("playonce\\scripted_sequences\\incinerator_fall_01.wav")
        }

        if (Entities.FindByName(null, "SpA2IntroViewcontrolTele")) {
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                p.SetOrigin(Vector(2704, -1260, 92))
            }
        }

        if (Entities.FindByName(null, "SpA2IntroViewcontrolDone")) {
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                p.SetOrigin(Vector(-3308, 536, -10737))
                p.SetAngles(0 0 0)
            }
            EntFire("SpA2IntroViewcontrolDone", "addoutput", "targetname SpA2IntroViewcontrolFinished", 0.15, null)
        }

        EntFire("shaft_areaportal_1", "open", "", 0, null)
        EntFire("shaft_areaportal_2", "open", "", 0, null)

        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(-736, 1594, -11038), 50)) {
            SendToConsole("commentary 1")
            SendToConsole("changelevel sp_a2_laser_intro")
        }

        // Remove the player's Portal Gun
        if (Entities.FindByName(null, "portalgun")) {
            local ent = null
            while (ent = Entities.FindByClassname(ent, "weapon_portalgun")) {
                ent.Destroy()
            }
        }

        // Give the player a Portal Gun
        if (!Entities.FindByName(null, "portalgun")) {
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                if (Entities.FindByName(null, "CustomPortalGun")) {
                } else {
                    PortalGunGiveContinue <- true
                    local ent = null
                    while (ent = Entities.FindByClassnameWithin(ent, "weapon_portalgun", p.GetOrigin(), 2)) {
                        PortalGunGiveContinue <- false
                    }
                    if (PortalGunGiveContinue==true) {
                    PortalGun <- Entities.CreateByClassname("weapon_portalgun")
                    PortalGun.__KeyValueFromString("StartingTeamNum", "0")
                    PortalGun.__KeyValueFromString("targetname", "CustomPortalGun")
                    PortalGun.SetOrigin(Vector(p.GetOrigin().x, p.GetOrigin().y, p.GetOrigin().z+20))
                    EntFireByHandle(PortalGun, "use", "", 0.25, p, p)
                    EntFireByHandle(PortalGun, "kill", "", 1.25, p, p)
                    }
                }
            }
        }
    }
}