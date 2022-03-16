// ███╗   ███╗ █████╗ ██████╗ ███╗  ██╗ █████╗ ███╗   ███╗███████╗
// ████╗ ████║██╔══██╗██╔══██╗████╗ ██║██╔══██╗████╗ ████║██╔════╝
// ██╔████╔██║███████║██████╔╝██╔██╗██║███████║██╔████╔██║█████╗
// ██║╚██╔╝██║██╔══██║██╔═══╝ ██║╚████║██╔══██║██║╚██╔╝██║██╔══╝
// ██║ ╚═╝ ██║██║  ██║██║     ██║ ╚███║██║  ██║██║ ╚═╝ ██║███████╗
// ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝  ╚══╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝

if (MinecraftMode) {
    function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
        if (MSInstantRun==true) {

        }

        if (MSPostPlayerSpawn==true) {
            local bruh = 0
            while (bruh < 500) {
                printl("bruh")
                bruh = bruh + 1
                local cblock = CreateProp("prop_dynamic", Vector(0, 0, 0), "models/props/metal_box.mdl", 0)
                // sp_a4_intro_custom_prop_102.SetAngles(60.0625, 61.093719482422, -158.37501525879)
                cblock.__KeyValueFromString("solid", "6")
                cblock.__KeyValueFromString("targetname", "minecraftblock" + bruh)
            }

            local ent = null
            while (ent = Entities.FindInSphere(ent, Vector(0, 0, 0), 2800)) {
                if (ent.GetClassname() != "player" && ent.GetClassname() != "worldspawn") {
                    //ent.Destroy()
                    printl("Destroyed " + ent.GetClassname())
                }
            }
        }

        if (MSLoop==true) {

        }
    }
}