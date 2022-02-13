// ███╗   ███╗██████╗             █████╗  █████╗  █████╗ ██████╗             █████╗ ██████╗ ███████╗██████╗ ██╗████████╗ ██████╗
// ████╗ ████║██╔══██╗           ██╔══██╗██╔══██╗██╔══██╗██╔══██╗           ██╔══██╗██╔══██╗██╔════╝██╔══██╗██║╚══██╔══╝██╔════╝
// ██╔████╔██║██████╔╝           ██║  ╚═╝██║  ██║██║  ██║██████╔╝           ██║  ╚═╝██████╔╝█████╗  ██║  ██║██║   ██║   ╚█████╗
// ██║╚██╔╝██║██╔═══╝            ██║  ██╗██║  ██║██║  ██║██╔═══╝            ██║  ██╗██╔══██╗██╔══╝  ██║  ██║██║   ██║    ╚═══██╗
// ██║ ╚═╝ ██║██║     ██████████╗╚█████╔╝╚█████╔╝╚█████╔╝██║     ██████████╗╚█████╔╝██║  ██║███████╗██████╔╝██║   ██║   ██████╔╝
// ╚═╝     ╚═╝╚═╝     ╚═════════╝ ╚════╝  ╚════╝  ╚════╝ ╚═╝     ╚═════════╝ ╚════╝ ╚═╝  ╚═╝╚══════╝╚═════╝ ╚═╝   ╚═╝   ╚═════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        // Remove selected pods
        function CreditsRemovePod() {
            try {
                local ent = null
                while (ent = Entities.FindByNameNearest("chamber*", Vector(-64, 217, 72), 100)) {
                    ent.Destroy()
                }
            } catch(exeption) { }

            try {
                while (ent = Entities.FindByNameNearest("bubbles*", Vector(-64, 217, 72), 100)) {
                    ent.Destroy()
                }
            } catch(exeption) { }
        }

    // Fix void camera glitch
    function FixCreditsCameras() {
        // Disable useless cameras
        EntFireByHandle(Entities.FindByName(null, "camera_SP"), "disable", "", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "camera_O"), "disable", "", 0, null, null)

        // Reload main camera with new params
        Entities.FindByName(null, "camera").__KeyValueFromString("target_team", "-1")
        EntFireByHandle(Entities.FindByName(null, "camera"), "disable", "", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "camera"), "enable", "", 0, null, null)
    }

    // Replace females with P-bodys
    function CreditsSetModelPB(ent) {
        FixCreditsCameras()

        // Count how many credits come on screen to change to humans
        MPMCredits <- MPMCredits + 1

        // Preset animation
        local RandomAnimation = RandomInt(0, CRAnimationTypesPB)

        // Remove pod if needed
        HasRemovedPod <- 0
        foreach (anim in NOTubeAnimsPB) {
            if (AnimationsPB[RandomAnimation] == anim && HasRemovedPod == 0) {
                HasRemovedPod <- 1
                CreditsRemovePod()
            }
        }

        // Set model
        ent.SetModel("models/player/eggbot/eggbot.mdl")

        // Set color
        EntFireByHandle(ent, "Color", (RandomInt(0, 255) + " " + RandomInt(0, 255) + " " + RandomInt(0, 255)), 0, null, null)

        // Set position
        ent.SetOrigin(Vector(0, 0, 7.5))

        // Set animation
        EntFireByHandle(ent, "setanimation", AnimationsPB[RandomAnimation], 0, null, null)
    }

    // Replace males with Atlases
    function CreditsSetModelAL(ent) {
        FixCreditsCameras()

        // Count how many credits come on screen to change to humans
        MPMCredits <- MPMCredits + 1

        // Preset animation
        local RandomAnimation = RandomInt(0, CRAnimationTypesAL)

        // Set model
        ent.SetModel("models/player/ballbot/ballbot.mdl")

        // Set color
        EntFireByHandle(ent, "Color", (RandomInt(0, 255) + " " + RandomInt(0, 255) + " " + RandomInt(0, 255)), 0, null, null)

        // Set position
        ent.SetOrigin(Vector(-10, 0, 25.5))

        // Set animation
        EntFireByHandle(ent, "setanimation", AnimationsAL[RandomAnimation], 0, null, null)

        // Remove pod if needed
        HasRemovedPod <- 0
        foreach (anim in NOTubeAnimsAL) {
            if (AnimationsAL[RandomAnimation] == anim && HasRemovedPod == 0) {
                HasRemovedPod <- 1
                CreditsRemovePod()
                ent.SetOrigin(Vector(0, 0, 7.5))
            }
        }
    }

    // Set credits animations
        // P-body animations
        AnimationsPB <- ["taunt_laugh", "taunt_teamhug_idle", "noGun_crouch_idle", "taunt_face_palm", "taunt_selfspin", "taunt_pretzelwave", "noGun_airwalk", "noGun_airwalk", "portalgun_drowning", "layer_taunt_noGun_small_wave", "taunt_highFive_idle"]

        // Atlas animations
        AnimationsAL <- ["taunt_laugh", "taunt_laugh", "taunt_teamhug_initiate", "taunt_teamhug_noShow", "ballbot_taunt_rps_shake", "taunt_basketball2", "taunt_headspin", "taunt_facepalm", "taunt_shrug", "layer_taunt_trickfire_handstand", "portalgun_jump_spring", "portalgun_thrash_fall", "noGun_crouch_idle", "noGun_airwalk", "noGun_airwalk"]

        // P-body animations out of tube
        NOTubeAnimsPB <- ["taunt_laugh", "taunt_teamhug_idle", "noGun_crouch_idle", "taunt_face_palm", "taunt_selfspin", "taunt_pretzelwave", "layer_taunt_noGun_small_wave", "taunt_highFive_idle"]

        // Atlas animations out of tube
        NOTubeAnimsAL <- ["taunt_laugh", "taunt_laugh", "taunt_teamhug_initiate", "taunt_teamhug_noShow", "ballbot_taunt_rps_shake", "taunt_basketball2", "taunt_headspin", "taunt_facepalm", "taunt_shrug", "layer_taunt_trickfire_handstand", "noGun_crouch_idle"]

        // Credit run counter
        MPMCredits <- 0

        // Set the amount of P-body animations
        CRAnimationTypesPB <- -1
        foreach (value in AnimationsPB) {
            CRAnimationTypesPB <- CRAnimationTypesPB + 1
        }

        // Set the amount of Atlas animations
        CRAnimationTypesAL <- -1
        foreach (value in AnimationsAL) {
            CRAnimationTypesAL <- CRAnimationTypesAL + 1
        }

        // Set the amount of credits
        MPModCreditNumber <- -1
        foreach (value in MPMCoopCreditNames) {
            MPModCreditNumber <- MPModCreditNumber + 1
        }

        // Mount list of credits to credits
        foreach (Name in MPMCoopCreditNames) {
            AddCoopCreditsName(Name)
        }
    }

    if (MSPostPlayerSpawn==true) {

    }

    if (MSLoop==true) {
        // If mod credits aren't finished change humans to robots
        if (MPMCredits <= MPModCreditNumber) {
            // Change males to Atlases
            local ent = null
            while (ent = Entities.FindByModel(ent, "models/props_underground/stasis_chamber_male.mdl")) {
                CreditsSetModelAL(ent)
            }

            local ent = null
            while (ent = Entities.FindByModel(ent, "models/props_underground/stasis_chamber_male01.mdl")) {
                CreditsSetModelAL(ent)
            }

            local ent = null
            while (ent = Entities.FindByModel(ent, "models/props_underground/stasis_chamber_male_02.mdl")) {
                CreditsSetModelAL(ent)
            }

            // Change females to P-bodys
            local ent = null
            while (ent = Entities.FindByModel(ent, "models/props_underground/stasis_chamber_female_01.mdl")) {
                CreditsSetModelPB(ent)
            }

            local ent = null
            while (ent = Entities.FindByModel(ent, "models/props_underground/stasis_chamber_female_02.mdl")) {
                CreditsSetModelPB(ent)
            }

            local ent = null
            while (ent = Entities.FindByModel(ent, "models/props_underground/stasis_chamber_female_03.mdl")) {
                CreditsSetModelPB(ent)
            }
        }
    }
}