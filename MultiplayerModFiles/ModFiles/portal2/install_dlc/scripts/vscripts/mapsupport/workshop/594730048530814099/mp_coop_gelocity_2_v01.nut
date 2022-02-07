// ███╗   ███╗ █████╗ ██████╗ ███╗  ██╗ █████╗ ███╗   ███╗███████╗
// ████╗ ████║██╔══██╗██╔══██╗████╗ ██║██╔══██╗████╗ ████║██╔════╝
// ██╔████╔██║███████║██████╔╝██╔██╗██║███████║██╔████╔██║█████╗
// ██║╚██╔╝██║██╔══██║██╔═══╝ ██║╚████║██╔══██║██║╚██╔╝██║██╔══╝
// ██║ ╚═╝ ██║██║  ██║██║     ██║ ╚███║██║  ██║██║ ╚═╝ ██║███████╗
// ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝  ╚══╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        
        // Delete uneccessary entities
        RemoveAllClassname("light_spot")
        RemoveAllClassname("beam_spotlight")
        RemoveAllClassname("logic_auto", 5)
        //keyframe_rope
        RemoveAllClassname("keyframe_rope")

        // Destroy death field sound effects
        Entities.FindByName(null, "death_field_sound_1").Destroy()
        Entities.FindByName(null, "death_field_sound_1_1").Destroy()
        Entities.FindByName(null, "death_field_sound_2").Destroy()
        Entities.FindByName(null, "death_field_sound_2_1").Destroy()
        Entities.FindByName(null, "death_field_sound_3").Destroy()
        Entities.FindByName(null, "death_field_sound_3_1").Destroy()
    }

    if (MSPostPlayerSpawn==true) {

    }

    if (MSLoop==true) {

    }
}