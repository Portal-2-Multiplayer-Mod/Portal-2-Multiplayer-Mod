//  ██████╗██████╗             █████╗ ██████╗            ██████╗ ████████╗ ██████╗██████╗
// ██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██╔══██╗╚══██╔══╝██╔════╝╚════██╗
// ╚█████╗ ██████╔╝           ███████║  ███╔═╝           ██████╦╝   ██║   ╚█████╗   ███╔═╝
//  ╚═══██╗██╔═══╝            ██╔══██║██╔══╝             ██╔══██╗   ██║    ╚═══██╗██╔══╝
// ██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗██████╦╝   ██║   ██████╔╝███████╗
// ╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝╚═════╝    ╚═╝   ╚═════╝ ╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Here if we need to ent_fire something
        //EntFireByHandle(Entities.FindByName(null, "NAME"), "ACTION", "VALUE", DELAYiny, ACTIVATOR, CALLER)
        // Destroy objects
        onscreendisplay69 <- Entities.CreateByClassname("game_text")
        Entities.FindByName(null, "player_clip").Destroy()
        Entities.FindByName(null, "player_died_relay").Destroy()
        Entities.FindByName(null, "transition_trigger").Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(1332, -250, 296), 100).__KeyValueFromString("targetname", "StartDeathEventMPMod")
        Entities.FindByClassnameNearest("trigger_once", Vector(2208, 1468, 304), 100).__KeyValueFromString("targetname", "EndDeathEventMPMod")
        Entities.FindByName(null, "pillar_fx_D_start_rl").Destroy()
        Entities.FindByName(null, "container_1_catwalk_hurt_1_rl").Destroy()
        Entities.FindByName(null, "catwalk_fx_E_1").__KeyValueFromString("targetname", "my mom")
        Entities.FindByName(null, "container_1_catwalk_hurt_2_floor").__KeyValueFromString("targetname", "my dad")
        OnlyOnceSp_A2_Bts2 <- true
        PreviousTimeSp_A2_Bts2 <- 0
        PreviousTimeSp_A2_Bts2Again <- 0
        NoPlayerMadeItOnlyOnceSp_A2_Bts2 <- true
        OnlyOnceSp_A2_Bts2AgainV2 <- true
        WheatleyPlayerLookSP_A2_BTS2 <- true
        DisableLookDisablerSP_A2_BTS2 <- false
    }

    if (MSPostPlayerSpawn) {
        local ent = null
        while (ent = Entities.FindByModel(ent, "models/anim_wp/room_transform/arm_exterior.mdl")) {
            //ent.__KeyValueFromString("HoldAnimation", "1")
            local ent2 = null
            while (ent2 = Entities.FindByClassnameWithin(ent2, "prop_dynamic", Vector(1490, -4311, 128), 300)) {
                if (ent == ent2) {
                    ent2.Destroy()
                }
            }
        }
    }

    if (MSLoop) {
        local p = null
        while (p = Entities.FindByClassnameWithin(p, "player", Vector(-1689.0235595703, -7900.8461914062, 6707.0034179688), 78.400001525879)) {
            DisableLookDisablerSP_A2_BTS2 <- true
        }

        if (!DisableLookDisablerSP_A2_BTS2) {
            // Make a custom trigger to disable player look
            WheatleyPlayerLookSP_A2_BTS2 <- true
            local p = null
            while (p = Entities.FindByClassnameWithin(p, "player", Vector(-1028.5295410156, -7103.0068359375, 6741.3315429688), 163.19999694824)) {
                WheatleyPlayerLookSP_A2_BTS2 <- false
            }
            local p = null
            while (p = Entities.FindByClassnameWithin(p, "player", Vector(-1028.5295410156, -7103.0068359375, 6741.3315429688), 163.19999694824)) {
                WheatleyPlayerLookSP_A2_BTS2 <- false
            }
            local p = null
            while (p = Entities.FindByClassnameWithin(p, "player", Vector(-1028.5295410156, -7103.0068359375, 6741.3315429688), 163.19999694824)) {
                WheatleyPlayerLookSP_A2_BTS2 <- false
            }
            local p = null
            while (p = Entities.FindByClassnameWithin(p, "player", Vector(-1403.9912109375, -7096.8754882812, 6690.7314453125), 163.19999694824)) {
                WheatleyPlayerLookSP_A2_BTS2 <- false
            }
            local p = null
            while (p = Entities.FindByClassnameWithin(p, "player", Vector(-1403.9912109375, -7096.8754882812, 6690.7314453125), 163.19999694824)) {
                WheatleyPlayerLookSP_A2_BTS2 <- false
            }
            local p = null
            while (p = Entities.FindByClassnameWithin(p, "player", Vector(-1403.9912109375, -7096.8754882812, 6690.7314453125), 163.19999694824)) {
                WheatleyPlayerLookSP_A2_BTS2 <- false
            }
            local p = null
            while (p = Entities.FindByClassnameWithin(p, "player", Vector(-1789.1419677734, -7122.5893554688, 6749.4721679688), 163.19999694824)) {
                WheatleyPlayerLookSP_A2_BTS2 <- false
            }
            local p = null
            while (p = Entities.FindByClassnameWithin(p, "player", Vector(-1789.1419677734, -7122.5893554688, 6749.4721679688), 163.19999694824)) {
                WheatleyPlayerLookSP_A2_BTS2 <- false
            }
            local p = null
            while (p = Entities.FindByClassnameWithin(p, "player", Vector(-1789.1419677734, -7122.5893554688, 6749.4721679688), 163.19999694824)) {
                WheatleyPlayerLookSP_A2_BTS2 <- false
            }
            local p = null
            while (p = Entities.FindByClassnameWithin(p, "player", Vector(-1788.701171875, -7474.5654296875, 6731.2202148438), 163.19999694824)) {
                WheatleyPlayerLookSP_A2_BTS2 <- false
            }
            local p = null
            while (p = Entities.FindByClassnameWithin(p, "player", Vector(-1788.701171875, -7474.5654296875, 6731.2202148438), 163.19999694824)) {
                WheatleyPlayerLookSP_A2_BTS2 <- false
            }
            local p = null
            while (p = Entities.FindByClassnameWithin(p, "player", Vector(-1788.701171875, -7474.5654296875, 6731.2202148438), 163.19999694824)) {
                WheatleyPlayerLookSP_A2_BTS2 <- false
            }
        }

        // if a player made it teleport everyone into the elevator
        local p = null
        while (p = Entities.FindByClassnameWithin(p, "player", Vector(2207.8967285156, 1452.6505126953, 264.08181762695), 40)) {
            if (OnlyOnceSp_A2_Bts2AgainV2) {
                local p = null
                while (p = Entities.FindByClassname(p, "player")) {
                    p.SetOrigin(Vector(2202, 1454, 303))
                    p.SetAngles(0, -90, 0)
                    p.SetVelocity(Vector(0, 0, 0))
                }
                OnlyOnceSp_A2_Bts2AgainV2 <- false
            }
        }

        // if no player made it, show a message and restart the level
        if (!Entities.FindByName(null, "StartDeathEventMPMod")) {
            if (OnlyOnceSp_A2_Bts2) {
                PreviousTimeSP_A2_BTS2 <- Time()
                OnlyOnceSp_A2_Bts2 <- false
            }
            if (PreviousTimeSP_A2_BTS2 + 31 <= Time()) {
                if (Entities.FindByName(null, "EndDeathEventMPMod")) {
                    if (NoPlayerMadeItOnlyOnceSp_A2_Bts2) {
                        printl("No Player Made It")
                        PreviousTimeSP_A2_BTS2Again <- Time()
                        // Create an on screen text message entity
                        onscreendisplay69.__KeyValueFromString("targetname", "p2mm_wait_for_players_textbts2")
                        onscreendisplay69.__KeyValueFromString("message", "Nobody Escaped...")
                        onscreendisplay69.__KeyValueFromString("holdtime", "3")
                        onscreendisplay69.__KeyValueFromString("fadeout", "2")
                        onscreendisplay69.__KeyValueFromString("fadein", "1.25")
                        onscreendisplay69.__KeyValueFromString("spawnflags", "1")
                        onscreendisplay69.__KeyValueFromString("color", "230 30 30")
                        onscreendisplay69.__KeyValueFromString("channel", "1")
                        onscreendisplay69.__KeyValueFromString("x", "0.425")
                        onscreendisplay69.__KeyValueFromString("y", "-0.2")

                        local envfade = Entities.CreateByClassname("env_fade")
                        envfade.__KeyValueFromString("duration", "5")
                        envfade.__KeyValueFromString("holdtime", "10")
                        envfade.__KeyValueFromString("ReverseFadeDuration", "0")
                        envfade.__KeyValueFromString("rendercolor", "0 0 0")
                        envfade.__KeyValueFromString("renderamt", "255")
                        envfade.__KeyValueFromString("targetname", "FadeyBoi")
                        DoEntFire("p2mm_wait_for_players_textbts2", "display", "", 0.1, null, null)
                        DoEntFire("FadeyBoi", "fade", "", 0.1, null, null)
                        if (GetDeveloperLevel()) {
                            printl("stuff=====================thing")
                        }
                        NoPlayerMadeItOnlyOnceSp_A2_Bts2 <- false
                        PreviousTimeSp_A2_Bts2Again <- Time()
                        Entities.FindByName(null, "EndDeathEventMPMod").__KeyValueFromString("targetname", "EndDeathEventMPModDisMain")
                    }
                }
            }
        }

        if (!NoPlayerMadeItOnlyOnceSp_A2_Bts2) {
            if (PreviousTimeSp_A2_Bts2Again + 6.75 <= Time()) {

                SendToConsoleP232("changelevel sp_a2_bts2")
                if (GetDeveloperLevel()) {
                    printl("stuff=====================")
                }
            }
        }


        // Make Wheatley look at nearest player
        if (WheatleyPlayerLookSP_A2_BTS2) {
            try {
                local ClosestPlayerMain = Entities.FindByClassnameNearest("player", Entities.FindByName(null, "spherebot_1_bottom_swivel_1").GetOrigin(), 10000)
                EntFireByHandle(Entities.FindByName(null, "spherebot_1_bottom_swivel_1"), "SetTargetEntity", ClosestPlayerMain.GetName(), 0, null, null)
            } catch(exception) {}
        }

        // Make our own changelevel trigger
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(2207, 1983, 689), 150)) {

            SendToConsoleP232("changelevel sp_a2_bts3")
        }

        // Fix the player's spawn position
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(825, -3756, 240), 25)) {
            p.SetOrigin(Vector(772, -3780, 64))
            p.SetAngles(0, -90, 0)
            p.SetVelocity(Vector(0, -90, 0))
        }
    }
}