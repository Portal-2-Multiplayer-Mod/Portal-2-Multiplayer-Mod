// ╔═╗╦═╗╔═╗╔═╗  ╔═╗╦═╗╔═╗╔═╗╔╦╗╦╔═╗╔╗╔  ╔═╗╔═╗╔╦╗╔═╗
// ╠═╝╠╦╝║ ║╠═╝  ║  ╠╦╝║╣ ╠═╣ ║ ║║ ║║║║  ║  ║ ║ ║║║╣
// ╩  ╩╚═╚═╝╩    ╚═╝╩╚═╚═╝╩ ╩ ╩ ╩╚═╝╝╚╝  ╚═╝╚═╝═╩╝╚═╝
// ╦╔╦╗╔═╗╔═╗╦═╗╔╦╗╔═╗╔╦╗  ╔═╗╦═╗╔═╗╔╦╗  ╔═╗╔╦╗╔═╗╔╦╗
// ║║║║╠═╝║ ║╠╦╝ ║ ║╣  ║║  ╠╣ ╠╦╝║ ║║║║  ║ ╦║║║║ ║ ║║
// ╩╩ ╩╩  ╚═╝╩╚═ ╩ ╚═╝═╩╝  ╚  ╩╚═╚═╝╩ ╩  ╚═╝╩ ╩╚═╝═╩╝

function CreatePropsForLevel(CacheTime, CreateTime, LoopTime) {
//==================================//
//CREATE OBJECTS FOR mp_coop_lobby_3//
//==================================//

if (GetMapName() == "mp_coop_lobby_3") {
    if (CacheTime==true) {
        // Cache Objects

        CacheModel("car_int_dest/car_int_dest.mdl")

        CacheModel("props_bts/truss_1024.mdl")

        CacheModel("props_bts/hanging_walkway_32a.mdl")

        CacheModel("props_bts/hanging_walkway_64a.mdl")

        CacheModel("props_gameplay/push_button.mdl")

        CacheModel("a4_destruction/wallpanel_256_cdest.mdl")

        CacheModel("props_bts/lab_pod_b.mdl")

        CacheModel("props_bts/hanging_walkway_128c.mdl")

        CacheModel("props_gameplay/push_button_mp.mdl")

        CacheModel("anim_wp/tv_wallpanel.mdl")

        CacheModel("props_bts/hanging_walkway_512a.mdl")

        CacheModel("props_bts/push_button_stand.mdl")

        CacheModel("props_gameplay/industrial_elevator_a.mdl")

        CacheModel("props_bts/hanging_walkway_l.mdl")

        CacheModel("props_bts/hanging_walkway_end_a.mdl")

        CacheModel("props_bts/hanging_walkway_128a.mdl")

        CacheModel("a4_destruction/fin3_fgwallsmash_stat.mdl")

        DoneCacheing <- true
  }


    if (CreateTime==true) {
        // Create Objects

        local mp_coop_lobby_3_custom_prop_255 = CreateProp("prop_dynamic", Vector(2866.7993164062, 4066.0083007812, 218.56544494629), "models/car_int_dest/car_int_dest.mdl", 0)
        mp_coop_lobby_3_custom_prop_255.SetAngles(-4.9654488975648e-05, 90.007270812988, 0.00033569333027117)
        mp_coop_lobby_3_custom_prop_255.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_255.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_256 = CreateProp("prop_dynamic", Vector(4487.02734375, 3194.7600097656, 1002.3007202148), "models/props_bts/truss_1024.mdl", 0)
        mp_coop_lobby_3_custom_prop_256.SetAngles(-0.004768980666995, 90.00993347168, -89.979858398438)
        mp_coop_lobby_3_custom_prop_256.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_256.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_257 = CreateProp("prop_dynamic", Vector(4309.6845703125, 3848.9709472656, 934.87152099609), "models/props_bts/hanging_walkway_32a.mdl", 0)
        mp_coop_lobby_3_custom_prop_257.SetAngles(9.4053681943401e-13, -179.96661376953, 0)
        mp_coop_lobby_3_custom_prop_257.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_257.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_258 = CreateProp("prop_dynamic", Vector(4309.6938476562, 3801.0825195312, 934.97210693359), "models/props_bts/hanging_walkway_64a.mdl", 0)
        mp_coop_lobby_3_custom_prop_258.SetAngles(-4.9318552713951e-12, 0.0096746860072017, 1.52587890625e-05)
        mp_coop_lobby_3_custom_prop_258.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_258.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_260 = CreateProp("prop_dynamic", Vector(4341.2495117188, 3275.2766113281, -466.67553710938), "models/props_gameplay/push_button.mdl", 0)
        mp_coop_lobby_3_custom_prop_260.SetAngles(-1.7990032796789e-09, 179.97850036621, 1.5258788153005e-05)
        mp_coop_lobby_3_custom_prop_260.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_260.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_262 = CreateProp("prop_dynamic", Vector(4128.7666015625, 2912.6416015625, 415.11779785156), "models/a4_destruction/wallpanel_256_cdest.mdl", 0)
        mp_coop_lobby_3_custom_prop_262.SetAngles(-2.2409263777945e-08, 0.016794171184301, 45)
        mp_coop_lobby_3_custom_prop_262.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_262.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_263 = CreateProp("prop_dynamic", Vector(4486.3046875, 3194.9309082031, -1043.6989746094), "models/props_bts/truss_1024.mdl", 0)
        mp_coop_lobby_3_custom_prop_263.SetAngles(-0.0047962991520762, 90.00993347168, -89.979858398438)
        mp_coop_lobby_3_custom_prop_263.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_263.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_264 = CreateProp("prop_dynamic", Vector(2872.2102050781, 3923.1462402344, 7.1514129638672), "models/props_bts/lab_pod_b.mdl", 0)
        mp_coop_lobby_3_custom_prop_264.SetAngles(1.9663194683606e-12, -179.99996948242, -0.019866943359375)
        mp_coop_lobby_3_custom_prop_264.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_264.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_265 = CreateProp("prop_dynamic", Vector(4485.943359375, 3195.0163574219, -2066.6987304688), "models/props_bts/truss_1024.mdl", 0)
        mp_coop_lobby_3_custom_prop_265.SetAngles(-0.0047826394438744, 90.00993347168, -89.979858398438)
        mp_coop_lobby_3_custom_prop_265.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_265.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_266 = CreateProp("prop_dynamic", Vector(4310.0439453125, 3193.6982421875, 934.97027587891), "models/props_bts/hanging_walkway_128c.mdl", 0)
        mp_coop_lobby_3_custom_prop_266.SetAngles(0.00072680559242144, -0.017055712640285, -0.00103759765625)
        mp_coop_lobby_3_custom_prop_266.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_266.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_268 = CreateProp("prop_dynamic", Vector(4465.8095703125, 3194.2890625, -443.65258789062), "models/props_gameplay/push_button_mp.mdl", 0)
        mp_coop_lobby_3_custom_prop_268.SetAngles(-2.4264730917362e-14, 178.69076538086, 1.5258788153005e-05)
        mp_coop_lobby_3_custom_prop_268.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_268.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_270 = CreateProp("prop_dynamic", Vector(4128.7666015625, 2912.6416015625, 415.11779785156), "models/a4_destruction/wallpanel_256_cdest.mdl", 0)
        mp_coop_lobby_3_custom_prop_270.SetAngles(-2.3135738658198e-08, 0.016794174909592, 45)
        mp_coop_lobby_3_custom_prop_270.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_270.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_272 = CreateProp("prop_dynamic", Vector(4471.2680664062, 3994.3344726562, 999.09948730469), "models/anim_wp/tv_wallpanel.mdl", 0)
        mp_coop_lobby_3_custom_prop_272.SetAngles(-1.5076302428696e-09, 179.9821472168, 1.5258788153005e-05)
        mp_coop_lobby_3_custom_prop_272.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_272.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_273 = CreateProp("prop_dynamic", Vector(4437.2983398438, 3928.9345703125, 934.95794677734), "models/props_bts/hanging_walkway_512a.mdl", 0)
        mp_coop_lobby_3_custom_prop_273.SetAngles(-2.4592139880042e-07, -89.970275878906, -0.000244140625)
        mp_coop_lobby_3_custom_prop_273.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_273.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_274 = CreateProp("prop_dynamic", Vector(4341.0341796875, 3275.1962890625, -512.59912109375), "models/props_bts/push_button_stand.mdl", 0)
        mp_coop_lobby_3_custom_prop_274.SetAngles(-6.5250097830771e-16, 179.99348449707, 1.52587890625e-05)
        mp_coop_lobby_3_custom_prop_274.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_274.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_276 = CreateProp("prop_dynamic", Vector(4922.2041015625, 3995.0947265625, 999.88549804688), "models/anim_wp/tv_wallpanel.mdl", 0)
        mp_coop_lobby_3_custom_prop_276.SetAngles(-4.6967172243951e-16, -179.97393798828, 1.5258788153005e-05)
        mp_coop_lobby_3_custom_prop_276.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_276.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_277 = CreateProp("prop_dynamic", Vector(4486.666015625, 3194.8452148438, -20.699096679688), "models/props_bts/truss_1024.mdl", 0)
        mp_coop_lobby_3_custom_prop_277.SetAngles(-0.0047826394438744, 90.00993347168, -89.979858398438)
        mp_coop_lobby_3_custom_prop_277.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_277.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_278 = CreateProp("prop_dynamic", Vector(4410.1215820312, 3194.8745117188, 934.97875976562), "models/props_gameplay/industrial_elevator_a.mdl", 0)
        mp_coop_lobby_3_custom_prop_278.SetAngles(-1.8416527609588e-06, 179.9944152832, 1.52587890625e-05)
        mp_coop_lobby_3_custom_prop_278.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_278.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_279 = CreateProp("prop_dynamic", Vector(4309.6748046875, 3928.8771972656, 934.99975585938), "models/props_bts/hanging_walkway_l.mdl", 0)
        mp_coop_lobby_3_custom_prop_279.SetAngles(-9.3401462508257e-14, 0.016114430502057, 1.52587890625e-05)
        mp_coop_lobby_3_custom_prop_279.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_279.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_280 = CreateProp("prop_dynamic", Vector(5028.5341796875, 3929.1916503906, 934.89105224609), "models/props_bts/hanging_walkway_end_a.mdl", 0)
        mp_coop_lobby_3_custom_prop_280.SetAngles(4.0706882851495e-13, -90.013732910156, 1.52587890625e-05)
        mp_coop_lobby_3_custom_prop_280.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_280.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_282 = CreateProp("prop_dynamic", Vector(4703.1455078125, 3995.3076171875, 999.20190429688), "models/anim_wp/tv_wallpanel.mdl", 0)
        mp_coop_lobby_3_custom_prop_282.SetAngles(-1.5956304751725e-16, 179.9702911377, 1.5258786334016e-05)
        mp_coop_lobby_3_custom_prop_282.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_282.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_283 = CreateProp("prop_dynamic", Vector(4340.9370117188, 3255.1354980469, 935.63037109375), "models/props_bts/push_button_stand.mdl", 0)
        mp_coop_lobby_3_custom_prop_283.SetAngles(-6.0280481413847e-16, 179.99348449707, 1.52587890625e-05)
        mp_coop_lobby_3_custom_prop_283.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_283.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_284 = CreateProp("prop_dynamic", Vector(4309.9541015625, 3114.1899414062, 934.91418457031), "models/props_bts/hanging_walkway_end_a.mdl", 0)
        mp_coop_lobby_3_custom_prop_284.SetAngles(1.7533270693093e-06, 179.98181152344, -9.1552734375e-05)
        mp_coop_lobby_3_custom_prop_284.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_284.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_286 = CreateProp("prop_dynamic", Vector(4341.15234375, 3255.2158203125, 981.55395507812), "models/props_gameplay/push_button.mdl", 0)
        mp_coop_lobby_3_custom_prop_286.SetAngles(-1.7990031686566e-09, 179.97850036621, 1.5258788153005e-05)
        mp_coop_lobby_3_custom_prop_286.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_286.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_288 = CreateProp("prop_dynamic", Vector(4383.4516601562, 2913.0661621094, 415.83325195312), "models/a4_destruction/wallpanel_256_cdest.mdl", 0)
        mp_coop_lobby_3_custom_prop_288.SetAngles(4.8113383854798e-07, -0.019677247852087, 45.008220672607)
        mp_coop_lobby_3_custom_prop_288.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_288.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_289 = CreateProp("prop_dynamic", Vector(4409.509765625, 3194.5515136719, -511.90698242188), "models/props_gameplay/industrial_elevator_a.mdl", 0)
        mp_coop_lobby_3_custom_prop_289.SetAngles(0.00018374632054474, 179.98631286621, 0.0001220703125)
        mp_coop_lobby_3_custom_prop_289.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_289.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_290 = CreateProp("prop_dynamic", Vector(4948.9604492188, 3929.2145996094, 934.90234375), "models/props_bts/hanging_walkway_128a.mdl", 0)
        mp_coop_lobby_3_custom_prop_290.SetAngles(-4.0711238633723e-13, -89.999526977539, 1.52587890625e-05)
        mp_coop_lobby_3_custom_prop_290.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_290.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_292 = CreateProp("prop_dynamic", Vector(4383.4516601562, 2913.0661621094, 415.83325195312), "models/a4_destruction/wallpanel_256_cdest.mdl", 0)
        mp_coop_lobby_3_custom_prop_292.SetAngles(4.824202051168e-07, -0.019677247852087, 45.008220672607)
        mp_coop_lobby_3_custom_prop_292.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_292.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_294 = CreateProp("prop_dynamic", Vector(5058.416015625, 2553.0270996094, 235.8556060791), "models/a4_destruction/fin3_fgwallsmash_stat.mdl", 0)
        mp_coop_lobby_3_custom_prop_294.SetAngles(-4.1252001210523e-06, 179.90237426758, 90.019119262695)
        mp_coop_lobby_3_custom_prop_294.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_294.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_295 = CreateProp("prop_dynamic", Vector(4309.7124023438, 3705.7543945312, 934.62231445312), "models/props_bts/hanging_walkway_512a.mdl", 0)
        mp_coop_lobby_3_custom_prop_295.SetAngles(1.0406551176345e-08, -179.99993896484, -0.05859375)
        mp_coop_lobby_3_custom_prop_295.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_295.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_296 = CreateProp("prop_dynamic", Vector(2858.8579101562, 4243.7465820312, 7.7672576904297), "models/props_bts/lab_pod_b.mdl", 0)
        mp_coop_lobby_3_custom_prop_296.SetAngles(0.019562942907214, -0.00087143632117659, 0.10287475585938)
        mp_coop_lobby_3_custom_prop_296.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_296.__KeyValueFromString("targetname", "genericcustomprop")

  }


    if (LoopTime==true) {
        // Generated Teleports

  }
}

//=============================//
//CREATE OBJECTS FOR sp_a2_bts2//
//=============================//

if (GetMapName() == "sp_a2_bts2") {
    if (CacheTime==true) {
        // Cache Objects

        CacheModel("props_bts/hanging_walkway_128a.mdl")

        DoneCacheing <- true
  }


    if (CreateTime==true) {
        // Create Objects

        local sp_a2_bts2_custom_prop_144 = CreateProp("prop_dynamic", Vector(1210.9047851562, -3591.4580078125, 10.96333694458), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_144.SetAngles(-89.999946594238, -179.99993896484, 180)
        sp_a2_bts2_custom_prop_144.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_144.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_144, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_145 = CreateProp("prop_dynamic", Vector(1210.9046630859, -3463.4580078125, 10.96333694458), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_145.SetAngles(-89.999946594238, -179.99992370605, 180)
        sp_a2_bts2_custom_prop_145.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_145.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_145, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_146 = CreateProp("prop_dynamic", Vector(1407.3646240234, -3066.5859375, 10.300641059875), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_146.SetAngles(-89.979080200195, 90.006011962891, 180)
        sp_a2_bts2_custom_prop_146.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_146.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_146, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_147 = CreateProp("prop_dynamic", Vector(1733.7668457031, -3890.8125, 9.1990060806274), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_147.SetAngles(-89.999946594238, 9.5622635853942e-05, 180)
        sp_a2_bts2_custom_prop_147.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_147.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_147, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_148 = CreateProp("prop_dynamic", Vector(1732.4794921875, -3133.6625976562, 10.172374725342), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_148.SetAngles(-89.999984741211, 8.720429832465e-06, 180)
        sp_a2_bts2_custom_prop_148.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_148.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_148, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_149 = CreateProp("prop_dynamic", Vector(1210.9049072266, -3719.4580078125, 10.96333694458), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_149.SetAngles(-89.999946594238, -179.99995422363, 180)
        sp_a2_bts2_custom_prop_149.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_149.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_149, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_150 = CreateProp("prop_dynamic", Vector(1210.9050292969, -3847.4582519531, 10.96333694458), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_150.SetAngles(-89.999946594238, -179.99996948242, 180)
        sp_a2_bts2_custom_prop_150.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_150.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_150, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_151 = CreateProp("prop_dynamic", Vector(1210.9045410156, -3335.4580078125, 10.96333694458), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_151.SetAngles(-89.999946594238, -179.99990844727, 180)
        sp_a2_bts2_custom_prop_151.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_151.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_151, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_152 = CreateProp("prop_dynamic", Vector(1210.904296875, -3207.4577636719, 10.96333694458), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_152.SetAngles(-89.999946594238, -179.99989318848, 180)
        sp_a2_bts2_custom_prop_152.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_152.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_152, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_153 = CreateProp("prop_dynamic", Vector(1210.9040527344, -3079.4577636719, 10.96333694458), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_153.SetAngles(-89.999946594238, -179.99989318848, 180)
        sp_a2_bts2_custom_prop_153.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_153.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_153, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_154 = CreateProp("prop_dynamic", Vector(1279.3647460938, -3066.5993652344, 10.300641059875), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_154.SetAngles(-89.979103088379, 90.006004333496, 180)
        sp_a2_bts2_custom_prop_154.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_154.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_154, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_155 = CreateProp("prop_dynamic", Vector(2119.7722167969, -3195.4938964844, 12.396705627441), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_155.SetAngles(-89.999946594238, 89.999984741211, 180)
        sp_a2_bts2_custom_prop_155.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_155.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_155, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_156 = CreateProp("prop_dynamic", Vector(2244.1625976562, -3520.9521484375, 13.540298461914), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_156.SetAngles(-89.911918640137, -0.34657052159309, -179.76554870605)
        sp_a2_bts2_custom_prop_156.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_156.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_156, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_157 = CreateProp("prop_dynamic", Vector(1733.7669677734, -4018.8125, 9.1990060806274), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_157.SetAngles(-89.999954223633, 5.4641506721964e-05, 180)
        sp_a2_bts2_custom_prop_157.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_157.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_157, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_158 = CreateProp("prop_dynamic", Vector(1733.7672119141, -4146.8125, 9.1990060806274), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_158.SetAngles(-89.999946594238, 9.5622635853942e-05, 180)
        sp_a2_bts2_custom_prop_158.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_158.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_158, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_159 = CreateProp("prop_dynamic", Vector(2176.3408203125, -3588.1184082031, 10.380084037781), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_159.SetAngles(-89.999984741211, -89.999992370605, 180)
        sp_a2_bts2_custom_prop_159.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_159.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_159, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_160 = CreateProp("prop_dynamic", Vector(1733.7663574219, -3634.8125, 9.1990060806274), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_160.SetAngles(-89.999946594238, 0.00010928301344393, 180)
        sp_a2_bts2_custom_prop_160.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_160.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_160, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_161 = CreateProp("prop_dynamic", Vector(2244.4130859375, -3392.9523925781, 13.541104316711), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_161.SetAngles(-89.911918640137, -0.34657019376755, -179.76554870605)
        sp_a2_bts2_custom_prop_161.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_161.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_161, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_162 = CreateProp("prop_dynamic", Vector(2247.7722167969, -3195.4938964844, 12.396705627441), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_162.SetAngles(-89.999946594238, 89.999984741211, 180)
        sp_a2_bts2_custom_prop_162.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_162.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_162, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_163 = CreateProp("prop_dynamic", Vector(1663.3646240234, -3066.5588378906, 10.300641059875), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_163.SetAngles(-89.979080200195, 90.006042480469, 180)
        sp_a2_bts2_custom_prop_163.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_163.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_163, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_164 = CreateProp("prop_dynamic", Vector(1535.3646240234, -3066.572265625, 10.300641059875), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_164.SetAngles(-89.979080200195, 90.00602722168, 180)
        sp_a2_bts2_custom_prop_164.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_164.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_164, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_165 = CreateProp("prop_dynamic", Vector(1210.9050292969, -4103.4584960938, 10.96333694458), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_165.SetAngles(-89.999984741211, 180, 180)
        sp_a2_bts2_custom_prop_165.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_165.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_165, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_166 = CreateProp("prop_dynamic", Vector(1733.7666015625, -3762.8125, 9.1990060806274), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_166.SetAngles(-89.999946594238, 0.00010928301344393, 180)
        sp_a2_bts2_custom_prop_166.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_166.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_166, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_167 = CreateProp("prop_dynamic", Vector(1863.7722167969, -3195.4938964844, 12.396701812744), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_167.SetAngles(-89.999984741211, 89.999984741211, 180)
        sp_a2_bts2_custom_prop_167.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_167.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_167, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_168 = CreateProp("prop_dynamic", Vector(1210.9050292969, -3975.4584960938, 10.96333694458), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_168.SetAngles(-89.999954223633, -179.99998474121, 180)
        sp_a2_bts2_custom_prop_168.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_168.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_168, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_169 = CreateProp("prop_dynamic", Vector(1991.7722167969, -3195.4938964844, 12.396705627441), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_169.SetAngles(-89.999954223633, 89.999984741211, 180)
        sp_a2_bts2_custom_prop_169.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_169.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_169, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_170 = CreateProp("prop_dynamic", Vector(2244.6635742188, -3264.9526367188, 13.541909217834), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_170.SetAngles(-89.91194152832, -0.34656989574432, -179.76559448242)
        sp_a2_bts2_custom_prop_170.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_170.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_170, "disabledraw", "", 0, null, null)

  }


    if (LoopTime==true) {
        // Generated Teleports

  }
}
}