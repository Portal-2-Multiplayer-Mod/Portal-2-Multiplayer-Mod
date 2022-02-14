// ╔═╗╦═╗╔═╗╔═╗  ╔═╗╦═╗╔═╗╔═╗╔╦╗╦╔═╗╔╗╔  ╔═╗╔═╗╔╦╗╔═╗
// ╠═╝╠╦╝║ ║╠═╝  ║  ╠╦╝║╣ ╠═╣ ║ ║║ ║║║║  ║  ║ ║ ║║║╣
// ╩  ╩╚═╚═╝╩    ╚═╝╩╚═╚═╝╩ ╩ ╩ ╩╚═╝╝╚╝  ╚═╝╚═╝═╩╝╚═╝
// ╦╔╦╗╔═╗╔═╗╦═╗╔╦╗╔═╗╔╦╗  ╔═╗╦═╗╔═╗╔╦╗  ╔═╗╔╦╗╔═╗╔╦╗
// ║║║║╠═╝║ ║╠╦╝ ║ ║╣  ║║  ╠╣ ╠╦╝║ ║║║║  ║ ╦║║║║ ║ ║║
// ╩╩ ╩╩  ╚═╝╩╚═ ╩ ╚═╝═╩╝  ╚  ╩╚═╚═╝╩ ╩  ╚═╝╩ ╩╚═╝═╩╝

function CreatePropsForLevel(CacheTime, CreateTime, LoopTime) {

//===================================//
//CREATE OBJECTS FOR mp_coop_rat_maze//
//===================================//

if (GetMapName() == "mp_coop_rat_maze") {
    if (CacheTime==true) {
        // Cache Objects

        PrecacheModel("props/reflection_cube.mdl")

        DoneCacheing <- true
  }


    if (CreateTime==true) {
        // Create Objects

        local mp_coop_rat_maze_custom_prop_48 = CreateProp("prop_physics", Vector(-177.24385070801, 83.552711486816, -621.53527832031), "models/props/reflection_cube.mdl", 0)
        mp_coop_rat_maze_custom_prop_48.SetAngles(-0.073955573141575, 75.476417541504, 179.88249206543)
        mp_coop_rat_maze_custom_prop_48.__KeyValueFromString("solid", "6")
        mp_coop_rat_maze_custom_prop_48.__KeyValueFromString("targetname", "genericcustomprop")

  }


    if (LoopTime==true) {
        // Generated Teleports

  }
}


//==================================//
//CREATE OBJECTS FOR sp_a3_crazy_box//
//==================================//

if (GetMapName() == "sp_a3_crazy_box") {
    if (CacheTime==true) {
        // Cache Objects

        PrecacheModel("props_bts/vactube_128_straight.mdl")

        PrecacheModel("props_underground/underground_boxdropper.mdl")

        PrecacheModel("props_underground/underground_boxdropper_cage.mdl")

        PrecacheModel("props_factory/factory_panel_metal_chopped_top_128x128.mdl")

        DoneCacheing <- true
  }


    if (CreateTime==true) {
        // Create Objects

        local sp_a3_crazy_box_custom_prop_9 = CreateProp("prop_dynamic", Vector(878.75024414062, -1112.2896728516, 2054.7436523438), "models/props_bts/vactube_128_straight.mdl", 0)
        sp_a3_crazy_box_custom_prop_9.SetAngles(2.7340308861312e-07, -179.99995422363, 90.000022888184)
        sp_a3_crazy_box_custom_prop_9.__KeyValueFromString("solid", "6")
        sp_a3_crazy_box_custom_prop_9.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a3_crazy_box_custom_prop_10 = CreateProp("prop_dynamic", Vector(878.75024414062, -1112.2896728516, 2566.7436523438), "models/props_bts/vactube_128_straight.mdl", 0)
        sp_a3_crazy_box_custom_prop_10.SetAngles(2.7340277597432e-07, -179.99989318848, 90.000030517578)
        sp_a3_crazy_box_custom_prop_10.__KeyValueFromString("solid", "6")
        sp_a3_crazy_box_custom_prop_10.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a3_crazy_box_custom_prop_11 = CreateProp("prop_dynamic", Vector(878.75024414062, -1112.2896728516, 2694.7436523438), "models/props_bts/vactube_128_straight.mdl", 0)
        sp_a3_crazy_box_custom_prop_11.SetAngles(2.7340274755261e-07, -179.99989318848, 90.000030517578)
        sp_a3_crazy_box_custom_prop_11.__KeyValueFromString("solid", "6")
        sp_a3_crazy_box_custom_prop_11.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a3_crazy_box_custom_prop_12 = CreateProp("prop_dynamic", Vector(878.75024414062, -1112.2896728516, 2182.7436523438), "models/props_bts/vactube_128_straight.mdl", 0)
        sp_a3_crazy_box_custom_prop_12.SetAngles(2.7340297492628e-07, -179.99989318848, 90.000030517578)
        sp_a3_crazy_box_custom_prop_12.__KeyValueFromString("solid", "6")
        sp_a3_crazy_box_custom_prop_12.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a3_crazy_box_custom_prop_13 = CreateProp("prop_dynamic", Vector(878.75024414062, -1112.2896728516, 2310.7436523438), "models/props_bts/vactube_128_straight.mdl", 0)
        sp_a3_crazy_box_custom_prop_13.SetAngles(2.7340294650458e-07, -179.99989318848, 90.000030517578)
        sp_a3_crazy_box_custom_prop_13.__KeyValueFromString("solid", "6")
        sp_a3_crazy_box_custom_prop_13.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a3_crazy_box_custom_prop_14 = CreateProp("prop_dynamic", Vector(878.75024414062, -1112.2896728516, 2438.7436523438), "models/props_bts/vactube_128_straight.mdl", 0)
        sp_a3_crazy_box_custom_prop_14.SetAngles(2.7340283281774e-07, -179.99989318848, 90.000030517578)
        sp_a3_crazy_box_custom_prop_14.__KeyValueFromString("solid", "6")
        sp_a3_crazy_box_custom_prop_14.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a3_crazy_box_custom_prop_15 = CreateProp("prop_dynamic", Vector(877.98041992188, -1112.2999023438, 1952.1126708984), "models/props_underground/underground_boxdropper.mdl", 0)
        sp_a3_crazy_box_custom_prop_15.SetAngles(0, 90, 0)
        sp_a3_crazy_box_custom_prop_15.__KeyValueFromString("solid", "6")
        sp_a3_crazy_box_custom_prop_15.__KeyValueFromString("targetname", "genericcustomprop_maindropper")

        local sp_a3_crazy_box_custom_prop_16 = CreateProp("prop_dynamic", Vector(877.94549560547, -1111.8862304688, 1951.9709472656), "models/props_underground/underground_boxdropper_cage.mdl", 0)
        sp_a3_crazy_box_custom_prop_16.SetAngles(-7.4231045998841e-20, 89.99989318848, 1.52587890625e-05)
        sp_a3_crazy_box_custom_prop_16.__KeyValueFromString("solid", "6")
        sp_a3_crazy_box_custom_prop_16.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a3_crazy_box_custom_prop_17 = CreateProp("prop_dynamic", Vector(878.23785400391, -1111.7216796875, 2049.7453613281), "models/props_factory/factory_panel_metal_chopped_top_128x128.mdl", 0)
        sp_a3_crazy_box_custom_prop_17.SetAngles(89.999992370605, 90, 180)
        sp_a3_crazy_box_custom_prop_17.__KeyValueFromString("solid", "0")
        sp_a3_crazy_box_custom_prop_17.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a3_crazy_box_custom_prop_17, "addoutput", "modelscale 0.8910000026226", 0, null, null)
        EntFireByHandle(sp_a3_crazy_box_custom_prop_17, "color", "0 0 0 255", 0, null, null)

  }


    if (LoopTime==true) {
        // Generated Teleports

  }
}

//==================================//
//CREATE OBJECTS FOR mp_coop_lobby_3//
//==================================//

if (GetMapName() == "mp_coop_lobby_3") {
    if (CacheTime==true) {
        // Cache Objects

        PrecacheModel("car_int_dest/car_int_dest.mdl")

        PrecacheModel("props_bts/truss_1024.mdl")

        PrecacheModel("props_bts/hanging_walkway_32a.mdl")

        PrecacheModel("props_bts/hanging_walkway_64a.mdl")

        PrecacheModel("props_gameplay/push_button.mdl")

        PrecacheModel("a4_destruction/wallpanel_256_cdest.mdl")

        PrecacheModel("props_bts/lab_pod_b.mdl")

        PrecacheModel("props_bts/hanging_walkway_128c.mdl")

        PrecacheModel("props_gameplay/push_button_mp.mdl")

        PrecacheModel("anim_wp/tv_wallpanel.mdl")

        PrecacheModel("props_bts/hanging_walkway_512a.mdl")

        PrecacheModel("props_bts/push_button_stand.mdl")

        PrecacheModel("props_gameplay/industrial_elevator_a.mdl")

        PrecacheModel("props_bts/hanging_walkway_l.mdl")

        PrecacheModel("props_bts/hanging_walkway_end_a.mdl")

        PrecacheModel("props_bts/hanging_walkway_128a.mdl")

        PrecacheModel("a4_destruction/fin3_fgwallsmash_stat.mdl")

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

        PrecacheModel("props_bts/hanging_walkway_128a.mdl")

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

//==============================//
//CREATE OBJECTS FOR sp_a4_intro//
//==============================//

if (GetMapName() == "sp_a4_intro") {
    if (CacheTime==true) {
        // Cache Objects

        PrecacheModel("props_backstage/vacum_flange_a.mdl")

        PrecacheModel("props_bts/vactube_90deg_04.mdl")

        PrecacheModel("props_bts/vactube_connector.mdl")

        PrecacheModel("props_backstage/item_dropper_static_open.mdl")

        PrecacheModel("props_bts/vactube_90deg_03.mdl")

        PrecacheModel("props_bts/vactube_128_straight.mdl")

        PrecacheModel("props_bts/vactube_90deg_06.mdl")

        DoneCacheing <- true
  }


    if (CreateTime==true) {
        // Create Objects

        local sp_a4_intro_custom_prop_85 = CreateProp("prop_dynamic", Vector(-495.125, -642.375, 1143.5625), "models/props_backstage/vacum_flange_a.mdl", 0)
        sp_a4_intro_custom_prop_85.SetAngles(59.6875, 60.718757629395, 111.28124237061)
        sp_a4_intro_custom_prop_85.__KeyValueFromString("solid", "0")
        sp_a4_intro_custom_prop_85.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a4_intro_custom_prop_86 = CreateProp("prop_dynamic", Vector(-774.5625, -253.6876373291, 1026.40625), "models/props_bts/vactube_90deg_04.mdl", 0)
        sp_a4_intro_custom_prop_86.SetAngles(63.843761444092, -159.71875, 66.0625)
        sp_a4_intro_custom_prop_86.__KeyValueFromString("solid", "6")
        sp_a4_intro_custom_prop_86.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a4_intro_custom_prop_88 = CreateProp("prop_dynamic", Vector(-339.96875, -349.03125, 616.875), "models/props_bts/vactube_connector.mdl", 0)
        sp_a4_intro_custom_prop_88.SetAngles(-5.25093264514e-06, -20.968757629395, 119.24993896484)
        sp_a4_intro_custom_prop_88.__KeyValueFromString("solid", "6")
        sp_a4_intro_custom_prop_88.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a4_intro_custom_prop_89 = CreateProp("prop_dynamic", Vector(-320.39205932617, -297.9621887207, 518.37902832031), "models/props_backstage/vacum_flange_a.mdl", 0)
        sp_a4_intro_custom_prop_89.SetAngles(0.162034496665, -21.449562072754, -60.187835693359)
        sp_a4_intro_custom_prop_89.__KeyValueFromString("solid", "0")
        sp_a4_intro_custom_prop_89.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a4_intro_custom_prop_90 = CreateProp("prop_dynamic", Vector(-762.59375, -616.3125, 1082.21875), "models/props_backstage/vacum_flange_a.mdl", 0)
        sp_a4_intro_custom_prop_90.SetAngles(58.374984741211, 59.843753814697, -159.5)
        sp_a4_intro_custom_prop_90.__KeyValueFromString("solid", "0")
        sp_a4_intro_custom_prop_90.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a4_intro_custom_prop_92 = CreateProp("prop_dynamic", Vector(-782.25, -262.78125, 1031.75), "models/props_bts/vactube_connector.mdl", 0)
        sp_a4_intro_custom_prop_92.SetAngles(63.312507629395, -159.18748474121, 65.53125)
        sp_a4_intro_custom_prop_92.__KeyValueFromString("solid", "6")
        sp_a4_intro_custom_prop_92.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a4_intro_custom_prop_94 = CreateProp("prop_dynamic", Vector(-304.09375, -255.03125, 437.96875), "models/props_backstage/item_dropper.mdl", 0)
        sp_a4_intro_custom_prop_94.SetAngles(3.4029681046377e-06, -21.125003814697, 29.531248092651)
        sp_a4_intro_custom_prop_94.__KeyValueFromString("solid", "6")
        sp_a4_intro_custom_prop_94.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a4_intro_custom_prop_95 = CreateProp("prop_dynamic", Vector(-536.125, -270.625, 897.96875), "models/props_bts/vactube_90deg_03.mdl", 0)
        sp_a4_intro_custom_prop_95.SetAngles(61.15625, -171.15625, 146.25)
        sp_a4_intro_custom_prop_95.__KeyValueFromString("solid", "6")
        sp_a4_intro_custom_prop_95.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a4_intro_custom_prop_97 = CreateProp("prop_dynamic", Vector(-825.71868896484, -508.4375, 1093.5), "models/props_bts/vactube_connector.mdl", 0)
        sp_a4_intro_custom_prop_97.SetAngles(-61.281230926514, 21.156240463257, 172.25)
        sp_a4_intro_custom_prop_97.__KeyValueFromString("solid", "6")
        sp_a4_intro_custom_prop_97.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a4_intro_custom_prop_98 = CreateProp("prop_dynamic", Vector(-315.875, -286.06256103516, 495.71878051758), "models/props_bts/vactube_128_straight.mdl", 0)
        sp_a4_intro_custom_prop_98.SetAngles(0, -21, 119.28125)
        sp_a4_intro_custom_prop_98.__KeyValueFromString("solid", "6")
        sp_a4_intro_custom_prop_98.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a4_intro_custom_prop_99 = CreateProp("prop_dynamic", Vector(-504.5, -649.34381103516, 1137.59375), "models/props_bts/vactube_90deg_06.mdl", 0)
        sp_a4_intro_custom_prop_99.SetAngles(59.968746185303, 61.000003814697, 111.5625)
        sp_a4_intro_custom_prop_99.__KeyValueFromString("solid", "6")
        sp_a4_intro_custom_prop_99.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a4_intro_custom_prop_100 = CreateProp("prop_dynamic", Vector(-338.125, -344.03137207031, 606.37512207031), "models/props_bts/vactube_90deg_04.mdl", 0)
        sp_a4_intro_custom_prop_100.SetAngles(-23.937503814697, 32.062507629395, 107.03125)
        sp_a4_intro_custom_prop_100.__KeyValueFromString("solid", "6")
        sp_a4_intro_custom_prop_100.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a4_intro_custom_prop_101 = CreateProp("prop_dynamic", Vector(-534.65625, -272.0625, 897.93743896484), "models/props_backstage/vacum_flange_a.mdl", 0)
        sp_a4_intro_custom_prop_101.SetAngles(60.71875, -170.71875, 146.25)
        sp_a4_intro_custom_prop_101.__KeyValueFromString("solid", "0")
        sp_a4_intro_custom_prop_101.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a4_intro_custom_prop_102 = CreateProp("prop_dynamic", Vector(-767.5, -610.53131103516, 1084), "models/props_bts/vactube_90deg_03.mdl", 0)
        sp_a4_intro_custom_prop_102.SetAngles(60.0625, 61.093719482422, -158.37501525879)
        sp_a4_intro_custom_prop_102.__KeyValueFromString("solid", "6")
        sp_a4_intro_custom_prop_102.__KeyValueFromString("targetname", "genericcustomprop")

  }


    if (LoopTime==true) {
        // Generated Teleports

  }
}
}