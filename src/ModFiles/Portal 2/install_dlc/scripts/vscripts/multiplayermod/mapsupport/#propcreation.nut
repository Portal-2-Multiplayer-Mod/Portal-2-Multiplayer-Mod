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

        PrecacheModel("props_motel/armchair.mdl")

        PrecacheModel("props_motel/smoke_detector01.mdl")

        PrecacheModel("props_motel/fridge.mdl")

        PrecacheModel("props_motel/pink_tablelamp.mdl")

        PrecacheModel("props_motel/closet_curtain01.mdl")

        PrecacheModel("props_motel/rotating_picture.mdl")

        PrecacheModel("props_motel/tall_round_table.mdl")

        PrecacheModel("props_motel/tv.mdl")

        PrecacheModel("props_motel/trimdesk_wall.mdl")

        PrecacheModel("props_motel/hotel_container_furniture03.mdl")

        PrecacheModel("props_motel/microwave.mdl")

        PrecacheModel("props_motel/wall_lamp.mdl")

        PrecacheModel("props_motel/bedside_table.mdl")

        PrecacheModel("props_office/desk_freestanding.mdl")

        PrecacheModel("props_office/tv_1970.mdl")

        PrecacheModel("props_office/whiteboard.mdl")

        PrecacheModel("props_office/whiteboard_coop.mdl")

        PrecacheModel("props_office/lab_display_standup.mdl")

        PrecacheModel("props_underground/elevator_enclosure.mdl")

        PrecacheModel("props_underground/distillery_tanks_small.mdl")

        PrecacheModel("props_underground/chair_lobby.mdl")

        PrecacheModel("props_underground/entrance_elevator.mdl")

        PrecacheModel("props_underground/door_bipart_frame_128_combined.mdl")

        PrecacheModel("props_underground/desk_lobby.mdl")

        PrecacheModel("props_underground/chair_folding_01.mdl")

        PrecacheModel("props_underground/chair_office_padded_1980.mdl")

        PrecacheModel("props_underground/pillar_cage.mdl")

        PrecacheModel("props_underground/underground_door_closed_lod1.mdl")

        PrecacheModel("props_underground/truss_32_256.mdl")

        PrecacheModel("props_underground/underground_floor_button.mdl")

        PrecacheModel("props_underground/underground_boxdropper_cage.mdl")

        PrecacheModel("props_underground/tube_paint_leak.mdl")

        PrecacheModel("car_int_dest/car_int_dest.mdl")

        PrecacheModel("props_bts/hanging_platform_b.mdl")

        PrecacheModel("props_bts/lab_pod_b.mdl")

        PrecacheModel("props_bts/vertical_small_piston_body.mdl")

        PrecacheModel("props_bts/vertical_small_piston_base.mdl")

        PrecacheModel("props_urban/telephone_pole002.mdl")

        PrecacheModel("props_urban/telephone_pole003.mdl")

        PrecacheModel("npcs/glados/glados_disc_base.mdl")

        PrecacheModel("props_lab/glados_chamber_lightpanels.mdl")

        PrecacheModel("npcs/glados/glados_ring_medium.mdl")

        PrecacheModel("npcs/glados/glados_wheatley_newbody.mdl")

        DoneCacheing <- true
  }


    if (CreateTime==true) {
        // Create Objects

        local mp_coop_lobby_3_custom_prop_257 = CreateProp("prop_dynamic", Vector(5011.6875, 3502.5944824219, -508.60208129883), "models/props_motel/armchair.mdl", 0)
        mp_coop_lobby_3_custom_prop_257.SetAngles(-0.49653694033623, -154.99290466309, 0.090956099331379)
        mp_coop_lobby_3_custom_prop_257.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_257.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_259 = CreateProp("prop_dynamic", Vector(5006.1079101563, 3629.2321777344, -508.57754516602), "models/props_motel/armchair.mdl", 0)
        mp_coop_lobby_3_custom_prop_259.SetAngles(-0.10151860117912, 150.84159851074, -0.51852416992188)
        mp_coop_lobby_3_custom_prop_259.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_259.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_261 = CreateProp("prop_dynamic", Vector(5097.5776367188, 3687.4870605469, -508.54922485352), "models/props_motel/armchair.mdl", 0)
        mp_coop_lobby_3_custom_prop_261.SetAngles(0.098633550107479, 104.49559783936, 0.0045187557116151)
        mp_coop_lobby_3_custom_prop_261.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_261.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_263 = CreateProp("prop_dynamic", Vector(5194.1879882813, 3698.9753417969, -508.58837890625), "models/props_motel/armchair.mdl", 0)
        mp_coop_lobby_3_custom_prop_263.SetAngles(-0.37336966395378, 77.125160217285, -0.20321655273438)
        mp_coop_lobby_3_custom_prop_263.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_263.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_265 = CreateProp("prop_dynamic", Vector(5184.9951171875, 3609.3735351563, -383.78820800781), "models/props_motel/smoke_detector01.mdl", 0)
        mp_coop_lobby_3_custom_prop_265.SetAngles(4.7535090175188e-07, -0.021117420867085, 0)
        mp_coop_lobby_3_custom_prop_265.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_265.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_267 = CreateProp("prop_dynamic", Vector(5223.4077148438, 3474.8022460938, -508.62036132813), "models/props_motel/fridge.mdl", 0)
        mp_coop_lobby_3_custom_prop_267.SetAngles(-0.17555300891399, -62.044471740723, -0.20001220703125)
        mp_coop_lobby_3_custom_prop_267.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_267.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_269 = CreateProp("prop_dynamic", Vector(5231.4614257813, 3571.0849609375, -466.56085205078), "models/props_motel/pink_tablelamp.mdl", 0)
        mp_coop_lobby_3_custom_prop_269.SetAngles(5.1035371539726e-14, -177.23361206055, 3.7145980513742e-06)
        mp_coop_lobby_3_custom_prop_269.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_269.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_270 = CreateProp("prop_dynamic", Vector(5109.6201171875, 3462.7553710938, -470.17736816406), "models/props_motel/closet_curtain01.mdl", 0)
        mp_coop_lobby_3_custom_prop_270.SetAngles(0.010738008655608, 1.2122988700867, 0.0083315502852201)
        mp_coop_lobby_3_custom_prop_270.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_270.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_272 = CreateProp("prop_dynamic", Vector(5047.2651367188, 3459.4931640625, -445.62130737305), "models/props_motel/rotating_picture.mdl", 0)
        mp_coop_lobby_3_custom_prop_272.SetAngles(-3.320953104527e-12, -90.000038146973, -2.0950942598574e-06)
        mp_coop_lobby_3_custom_prop_272.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_272.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_274 = CreateProp("prop_dynamic", Vector(5122.6186523438, 3584.7529296875, -508.60638427734), "models/props_motel/tall_round_table.mdl", 0)
        mp_coop_lobby_3_custom_prop_274.SetAngles(0.47404038906097, 119.48056793213, 0.77687060832977)
        mp_coop_lobby_3_custom_prop_274.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_274.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_276 = CreateProp("prop_dynamic", Vector(5244.0107421875, 3638.8391113281, -428.09030151367), "models/props_motel/tv.mdl", 0)
        mp_coop_lobby_3_custom_prop_276.SetAngles(-1.4357164762613e-11, -0.00020793594012503, -2.0959346329619e-06)
        mp_coop_lobby_3_custom_prop_276.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_276.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_278 = CreateProp("prop_dynamic", Vector(5241.1860351563, 3605.921875, -508.53622436523), "models/props_motel/trimdesk_wall.mdl", 0)
        mp_coop_lobby_3_custom_prop_278.SetAngles(0.22855341434479, 1.823633313179, 0.43648156523705)
        mp_coop_lobby_3_custom_prop_278.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_278.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_280 = CreateProp("prop_dynamic", Vector(5082.7709960938, 3682.3959960938, -508.59829711914), "models/props_motel/hotel_container_furniture03.mdl", 0)
        mp_coop_lobby_3_custom_prop_280.SetAngles(5.5397822507075e-07, 180, -1.5568800790788e-06)
        mp_coop_lobby_3_custom_prop_280.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_280.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_282 = CreateProp("prop_dynamic", Vector(5099.71484375, 3539.8173828125, -386.61880493164), "models/props_motel/smoke_detector01.mdl", 0)
        mp_coop_lobby_3_custom_prop_282.SetAngles(5.1801774675342e-11, 90.000595092773, 0)
        mp_coop_lobby_3_custom_prop_282.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_282.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_284 = CreateProp("prop_dynamic", Vector(5226.1000976563, 3625.162109375, -465.91015625), "models/props_motel/microwave.mdl", 0)
        mp_coop_lobby_3_custom_prop_284.SetAngles(-1.1806892201665e-14, 12.84631729126, 7.9168075899361e-06)
        mp_coop_lobby_3_custom_prop_284.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_284.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_286 = CreateProp("prop_dynamic", Vector(5174.4829101563, 3464.2966308594, -451.74954223633), "models/props_motel/wall_lamp.mdl", 0)
        mp_coop_lobby_3_custom_prop_286.SetAngles(4.5172960966462e-13, -90, -2.1010962427681e-06)
        mp_coop_lobby_3_custom_prop_286.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_286.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_288 = CreateProp("prop_dynamic", Vector(5146.3276367188, 3704.9406738281, -508.60430908203), "models/props_motel/bedside_table.mdl", 0)
        mp_coop_lobby_3_custom_prop_288.SetAngles(0.1255606263876, 90.166061401367, -0.097564697265625)
        mp_coop_lobby_3_custom_prop_288.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_288.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_289 = CreateProp("prop_dynamic", Vector(5286.3442382813, 3863.0441894531, -502.96496582031), "models/props_office/desk_freestanding.mdl", 0)
        mp_coop_lobby_3_custom_prop_289.SetAngles(-7.1353642994154e-09, -135, 0)
        mp_coop_lobby_3_custom_prop_289.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_289.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_290 = CreateProp("prop_dynamic", Vector(5122.291015625, 3588.2854003906, -473.36599731445), "models/props_office/tv_1970.mdl", 0)
        mp_coop_lobby_3_custom_prop_290.SetAngles(1.5666234856691e-13, -106.78383636475, 7.9168075899361e-06)
        mp_coop_lobby_3_custom_prop_290.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_290.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_291 = CreateProp("prop_dynamic", Vector(5449.7973632813, 3876.140625, -475.76379394531), "models/props_office/whiteboard.mdl", 0)
        mp_coop_lobby_3_custom_prop_291.SetAngles(-78.959693908691, -123.23107910156, -9.5823364257813)
        mp_coop_lobby_3_custom_prop_291.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_291.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_292 = CreateProp("prop_dynamic", Vector(5598.9389648438, 3894.7136230469, -452.16052246094), "models/props_office/whiteboard_coop.mdl", 0)
        mp_coop_lobby_3_custom_prop_292.SetAngles(-54.389652252197, -176.62394714355, -0.13845825195313)
        mp_coop_lobby_3_custom_prop_292.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_292.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_293 = CreateProp("prop_dynamic", Vector(5754.1088867188, 3929.4611816406, -388.87954711914), "models/props_office/lab_display_standup.mdl", 0)
        mp_coop_lobby_3_custom_prop_293.SetAngles(-47.230926513672, -90.957389831543, -9.7377624511719)
        mp_coop_lobby_3_custom_prop_293.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_293.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_294 = CreateProp("prop_dynamic", Vector(5885.7138671875, 4301.8618164063, -475.45272827148), "models/props_underground/elevator_enclosure.mdl", 0)
        mp_coop_lobby_3_custom_prop_294.SetAngles(4.5527815818787, -167.04455566406, -22.337646484375)
        mp_coop_lobby_3_custom_prop_294.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_294.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_295 = CreateProp("prop_dynamic", Vector(5622.4814453125, 4607.5, -249.21875), "models/props_underground/distillery_tanks_small.mdl", 0)
        mp_coop_lobby_3_custom_prop_295.SetAngles(-76.898796081543, -1.2314409104874e-05, 90.000015258789)
        mp_coop_lobby_3_custom_prop_295.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_295.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_296 = CreateProp("prop_dynamic", Vector(5367.6245117188, 4524.341796875, -259.47296142578), "models/props_underground/chair_lobby.mdl", 0)
        mp_coop_lobby_3_custom_prop_296.SetAngles(23.965255737305, 57.225124359131, 148.88334655762)
        mp_coop_lobby_3_custom_prop_296.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_296.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_297 = CreateProp("prop_dynamic", Vector(5985.6162109375, 4041.8571777344, -344.9055480957), "models/props_underground/entrance_elevator.mdl", 0)
        mp_coop_lobby_3_custom_prop_297.SetAngles(-57.635852813721, 106.67250823975, -4.4412231445313)
        mp_coop_lobby_3_custom_prop_297.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_297.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_298 = CreateProp("prop_dynamic", Vector(6025.3598632813, 3690.2587890625, -195.85893249512), "models/props_underground/door_bipart_frame_128_combined.mdl", 0)
        mp_coop_lobby_3_custom_prop_298.SetAngles(-60.856800079346, 60.805923461914, 12.061276435852)
        mp_coop_lobby_3_custom_prop_298.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_298.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_299 = CreateProp("prop_dynamic", Vector(5687.0786132813, 3532.6818847656, -192.88035583496), "models/props_underground/desk_lobby.mdl", 0)
        mp_coop_lobby_3_custom_prop_299.SetAngles(-2.3971837088597e-15, 38.018241882324, 7.9168066804414e-06)
        mp_coop_lobby_3_custom_prop_299.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_299.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_300 = CreateProp("prop_dynamic", Vector(5561.3125, 3437.5720214844, -189.2610168457), "models/props_underground/chair_folding_01.mdl", 0)
        mp_coop_lobby_3_custom_prop_300.SetAngles(-3.0025030991207e-14, 54.990810394287, 7.9168075899361e-06)
        mp_coop_lobby_3_custom_prop_300.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_300.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_301 = CreateProp("prop_dynamic", Vector(5522.9038085938, 3385.2531738281, -193.97674560547), "models/props_underground/chair_office_padded_1980.mdl", 0)
        mp_coop_lobby_3_custom_prop_301.SetAngles(3.1318131817277e-14, 106.18547058105, 0)
        mp_coop_lobby_3_custom_prop_301.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_301.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_302 = CreateProp("prop_dynamic", Vector(5456.4765625, 3350.4191894531, -185.17584228516), "models/props_underground/chair_lobby.mdl", 0)
        mp_coop_lobby_3_custom_prop_302.SetAngles(-5.9865153161809e-05, -77.451324462891, 180)
        mp_coop_lobby_3_custom_prop_302.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_302.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_303 = CreateProp("prop_dynamic", Vector(5186.4897460938, 3286.3334960938, -1027.8315429688), "models/props_underground/pillar_cage.mdl", 0)
        mp_coop_lobby_3_custom_prop_303.SetAngles(3.1522104127239e-14, 29.671562194824, 7.9168084994308e-06)
        mp_coop_lobby_3_custom_prop_303.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_303.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_305 = CreateProp("prop_dynamic", Vector(5212.1303710938, 3302.28125, -256.45645141602), "models/props_underground/underground_door_closed_lod1.mdl", 0)
        mp_coop_lobby_3_custom_prop_305.SetAngles(-89.980407714844, 176.77880859375, 180)
        mp_coop_lobby_3_custom_prop_305.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_305.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_307 = CreateProp("prop_dynamic", Vector(5249.3842773438, 3260.6186523438, -256.44427490234), "models/props_underground/underground_door_closed_lod1.mdl", 0)
        mp_coop_lobby_3_custom_prop_307.SetAngles(-89.963760375977, 110.70074462891, 180)
        mp_coop_lobby_3_custom_prop_307.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_307.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_308 = CreateProp("prop_dynamic", Vector(4982.4609375, 3072.9465332031, -250.49705505371), "models/props_underground/truss_32_256.mdl", 0)
        mp_coop_lobby_3_custom_prop_308.SetAngles(-81.964302062988, 51.30530166626, 36.399639129639)
        mp_coop_lobby_3_custom_prop_308.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_308.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_309 = CreateProp("prop_dynamic", Vector(4819.439453125, 3065.24609375, -245.56672668457), "models/props_underground/truss_32_256.mdl", 0)
        mp_coop_lobby_3_custom_prop_309.SetAngles(-84.894882202148, -2.2358276844025, -83.787902832031)
        mp_coop_lobby_3_custom_prop_309.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_309.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_310 = CreateProp("prop_dynamic", Vector(4586.5317382813, 3162.5078125, -281.28802490234), "models/props_underground/underground_floor_button.mdl", 0)
        mp_coop_lobby_3_custom_prop_310.SetAngles(0, 0, 0)
        mp_coop_lobby_3_custom_prop_310.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_310.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_311 = CreateProp("prop_dynamic", Vector(4293.1948242188, 3285.7875976563, -385.07440185547), "models/props_underground/underground_boxdropper_cage.mdl", 0)
        mp_coop_lobby_3_custom_prop_311.SetAngles(-4.2153899926234e-07, -3.9042602111294e-06, 0)
        mp_coop_lobby_3_custom_prop_311.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_311.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_312 = CreateProp("prop_dynamic", Vector(4293.1484375, 3181.6916503906, -329.94137573242), "models/props_underground/tube_paint_leak.mdl", 0)
        mp_coop_lobby_3_custom_prop_312.SetAngles(-1.3765758012596e-05, 0.00012088470248273, 2.4577628209954e-05)
        mp_coop_lobby_3_custom_prop_312.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_312.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_316 = CreateProp("prop_dynamic", Vector(4624.5, 3464.5336914063, 750.00408935547), "models/car_int_dest/car_int_dest.mdl", 0)
        mp_coop_lobby_3_custom_prop_316.SetAngles(5.8641398757286e-14, -88.08863067627, 5.8157024795946e-06)
        mp_coop_lobby_3_custom_prop_316.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_316.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_317 = CreateProp("prop_dynamic", Vector(4589.7836914063, 3371.4694824219, 736.42138671875), "models/props_bts/hanging_platform_b.mdl", 0)
        mp_coop_lobby_3_custom_prop_317.SetAngles(-0.00018438739061821, -89.999961853027, -0.00091552734375)
        mp_coop_lobby_3_custom_prop_317.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_317.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_318 = CreateProp("prop_dynamic", Vector(4644.2885742188, 3746.9187011719, 535.01776123047), "models/props_bts/lab_pod_b.mdl", 0)
        mp_coop_lobby_3_custom_prop_318.SetAngles(-0.11796709895134, -179.32249450684, -0.54833984375)
        mp_coop_lobby_3_custom_prop_318.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_318.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_319 = CreateProp("prop_dynamic", Vector(4633.9384765625, 3236.8703613281, 531.42474365234), "models/props_bts/lab_pod_b.mdl", 0)
        mp_coop_lobby_3_custom_prop_319.SetAngles(5.8604630481796e-08, 4.9589989430388e-06, -1.9052854440815e-06)
        mp_coop_lobby_3_custom_prop_319.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_319.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_320 = CreateProp("prop_dynamic", Vector(4584.748046875, 3836.2309570313, -844.16607666016), "models/props_bts/vertical_small_piston_body.mdl", 0)
        mp_coop_lobby_3_custom_prop_320.SetAngles(0.001642492134124, 3.6723034381866, -0.07733154296875)
        mp_coop_lobby_3_custom_prop_320.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_320.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_321 = CreateProp("prop_dynamic", Vector(4599.3125, 4159.7836914063, -904.63677978516), "models/props_bts/vertical_small_piston_body.mdl", 0)
        mp_coop_lobby_3_custom_prop_321.SetAngles(5.2015348002117e-14, -24.65821647644, 7.9168166848831e-06)
        mp_coop_lobby_3_custom_prop_321.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_321.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_322 = CreateProp("prop_dynamic", Vector(4759.0390625, 4418.4370117188, -986.43725585938), "models/props_bts/vertical_small_piston_body.mdl", 0)
        mp_coop_lobby_3_custom_prop_322.SetAngles(2.8190581921779e-13, -114.81666564941, 7.9168075899361e-06)
        mp_coop_lobby_3_custom_prop_322.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_322.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_323 = CreateProp("prop_dynamic", Vector(4938.9399414063, 4219.7416992188, -684.30218505859), "models/props_bts/vertical_small_piston_base.mdl", 0)
        mp_coop_lobby_3_custom_prop_323.SetAngles(7.1810569579611e-07, 1.1084609031677, 180)
        mp_coop_lobby_3_custom_prop_323.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_323.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_324 = CreateProp("prop_dynamic", Vector(5099.3696289063, 3894.4841308594, -511.32684326172), "models/props_urban/telephone_pole002.mdl", 0)
        mp_coop_lobby_3_custom_prop_324.SetAngles(-1.2917853593826, -78.794792175293, 1.2820138931274)
        mp_coop_lobby_3_custom_prop_324.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_324.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_325 = CreateProp("prop_dynamic", Vector(4784.5756835938, 3676.7990722656, -511.64712524414), "models/props_urban/telephone_pole002.mdl", 0)
        mp_coop_lobby_3_custom_prop_325.SetAngles(0.092705897986889, -150.49839782715, 0.019584244117141)
        mp_coop_lobby_3_custom_prop_325.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_325.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_326 = CreateProp("prop_dynamic", Vector(4427.58984375, 3690.8303222656, -511.54342651367), "models/props_urban/telephone_pole002.mdl", 0)
        mp_coop_lobby_3_custom_prop_326.SetAngles(-0.81194353103638, -170.90003967285, 0.023089719936252)
        mp_coop_lobby_3_custom_prop_326.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_326.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_327 = CreateProp("prop_dynamic", Vector(4166.8374023438, 3682.0637207031, -511.64083862305), "models/props_urban/telephone_pole002.mdl", 0)
        mp_coop_lobby_3_custom_prop_327.SetAngles(-0.58125507831573, -170.79605102539, 0)
        mp_coop_lobby_3_custom_prop_327.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_327.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_328 = CreateProp("prop_dynamic", Vector(5001.4794921875, 4415.158203125, -511.2639465332), "models/props_urban/telephone_pole003.mdl", 0)
        mp_coop_lobby_3_custom_prop_328.SetAngles(3.3775227069855, -122.57166290283, 0.37793523073196)
        mp_coop_lobby_3_custom_prop_328.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_328.__KeyValueFromString("targetname", "genericcustomprop")

  }


    if (LoopTime==true) {
        // Generated Teleports

    //  foreach (p in CreateTrigger("player", 6250.5971679688, 2941.2487792969, -850.17462158203, 3891.3664550781, 4681.6884765625, -900.08978271484)) {
    //      printl(p)
    //      p.SetVelocity(Vector(0,0,1000))
    //  }
    //  foreach (p in CreateTrigger("player", 4347.2573242188, 3235.3771972656, 771.96112060547, 4244.0380859375, 3338.3122558594, -505.74911499023)) {
    //      printl(p)
    //      p.SetVelocity(Vector(0,0,1000))
    //  }
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

//===============================//
//CREATE OBJECTS FOR sp_a1_intro1//
//===============================//

if (GetMapName() == "sp_a1_intro1") {
    if (CacheTime==true) {
        // Cache Objects

        PrecacheModel("props_bts/lab_pod_b_low.mdl")

        PrecacheModel("models/props_factory/factory_panel_portalable_128x128.mdl")

        PrecacheModel("models/props_factory/turret_factory_open/turret_factory_open.mdl")

        PrecacheModel("models/props_underground/underground_weighted_cube.mdl")

        DoneCacheing <- true
  }


    if (CreateTime==true) {
        // Create Objects

        local sp_a1_intro1_custom_prop_95 = CreateProp("prop_dynamic", Vector(-9469, -491, -3152), "models/container_ride/endstate_vcollide.mdl", 0)
        sp_a1_intro1_custom_prop_95.SetAngles(-6.8249382972717, -0.23543548583984, 0.75763827562332)
        sp_a1_intro1_custom_prop_95.__KeyValueFromString("solid", "6")
        sp_a1_intro1_custom_prop_95.__KeyValueFromString("targetname", "genericcustomprop")

        // Floor
        local sp_a1_intro1_custom_prop_96 = CreateProp("prop_dynamic", Vector(-5755, 1912, 11), "models/props_bts/lab_pod_b_low.mdl", 0)
        sp_a1_intro1_custom_prop_96.SetAngles(0, -90, 0)
        sp_a1_intro1_custom_prop_96.__KeyValueFromString("solid", "6")
        sp_a1_intro1_custom_prop_96.__KeyValueFromString("targetname", "genericcustomprop")
        //EntFireByHandle(sp_a1_intro1_custom_prop_96, "disabledraw", "", 0, null, null)

        // Right wall
        local sp_a1_intro1_custom_prop_97 = CreateProp("prop_dynamic", Vector(-5755, 1705, 176), "models/props_bts/lab_pod_b_low.mdl", 0)
        sp_a1_intro1_custom_prop_97.SetAngles(0, -90, 0)
        sp_a1_intro1_custom_prop_97.__KeyValueFromString("solid", "6")
        sp_a1_intro1_custom_prop_97.__KeyValueFromString("targetname", "genericcustomprop")
        //EntFireByHandle(sp_a1_intro1_custom_prop_97, "disabledraw", "", 0, null, null)

        // Left wall
        local sp_a1_intro1_custom_prop_98 = CreateProp("prop_dynamic", Vector(-5755, 2120, 176), "models/props_bts/lab_pod_b_low.mdl", 0)
        sp_a1_intro1_custom_prop_98.SetAngles(0, -90, 0)
        sp_a1_intro1_custom_prop_98.__KeyValueFromString("solid", "6")
        sp_a1_intro1_custom_prop_98.__KeyValueFromString("targetname", "genericcustomprop")
        //EntFireByHandle(sp_a1_intro1_custom_prop_98, "disabledraw", "", 0, null, null)

        // Front wall
        local sp_a1_intro1_custom_prop_99 = CreateProp("prop_dynamic", Vector(-5535, 1912, 282), "models/props_bts/lab_pod_b_low.mdl", 0)
        sp_a1_intro1_custom_prop_99.SetAngles(0, -90, -90)
        sp_a1_intro1_custom_prop_99.__KeyValueFromString("solid", "6")
        sp_a1_intro1_custom_prop_99.__KeyValueFromString("targetname", "genericcustomprop")
        //EntFireByHandle(sp_a1_intro1_custom_prop_99, "disabledraw", "", 0, null, null)

        // Ceiling
        local sp_a1_intro1_custom_prop_100 = CreateProp("prop_dynamic", Vector(-5755, 1912, 346), "models/props_bts/lab_pod_b_low.mdl", 0)
        sp_a1_intro1_custom_prop_100.SetAngles(0, -90, 0)
        sp_a1_intro1_custom_prop_100.__KeyValueFromString("solid", "6")
        sp_a1_intro1_custom_prop_100.__KeyValueFromString("targetname", "genericcustomprop")
        //EntFireByHandle(sp_a1_intro1_custom_prop_100, "disabledraw", "", 0, null, null)

        local sp_a1_intro1_custom_prop_101 = CreateProp("prop_physics", Vector(-5738.5913085938, 1436.5866699219, 371.41882324219), "models/props_factory/factory_panel_portalable_128x128.mdl", 0)
        sp_a1_intro1_custom_prop_101.SetAngles(-89.951835632324, 89.97346496582, 180)
        sp_a1_intro1_custom_prop_102.__KeyValueFromString("solid", "6")
        sp_a1_intro1_custom_prop_102.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a1_intro1_custom_prop_102 = CreateProp("prop_physics", Vector(-5897.6782226563, 1349.2406005859, 365.28759765625), "models/props_factory/turret_factory_open/turret_factory_open.mdl", 0)
        sp_a1_intro1_custom_prop_102.SetAngles(0.11501677334309, -179.95906066895, -0.040924072265625)
        sp_a1_intro1_custom_prop_102.__KeyValueFromString("solid", "6")
        sp_a1_intro1_custom_prop_102.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a1_intro1_custom_prop_103 = CreateProp("prop_physics", Vector(-5885.8984375, 1477.5599365234, 383.47760009766), "models/props_underground/underground_weighted_cube.mdl", 0)
        sp_a1_intro1_custom_prop_103.SetAngles(0.089073076844215, -179.96084594727, -0.08380126953125)
        sp_a1_intro1_custom_prop_103.__KeyValueFromString("solid", "6")
        sp_a1_intro1_custom_prop_103.__KeyValueFromString("targetname", "genericcustomprop")

  }


    if (LoopTime==true) {
        // Generated Teleports

  }
}

if (FutBolGamemode) {

//=====================================//
//CREATE OBJECTS FOR sp_a2_triple_laser//
//=====================================//

if (GetMapName() == "sp_a2_triple_laser") {
    if (CacheTime==true) {
        // Cache Objects

        PrecacheModel("props_lab/window_256.mdl")

        PrecacheModel("props/futbol_dispenser.mdl")

        PrecacheModel("props_lab/window_256_a.mdl")

        PrecacheModel("props_lab/window_64_a.mdl")

        PrecacheModel("props_office/sliding_door.mdl")

        PrecacheModel("props_lab/glass_observation_2.mdl")

        PrecacheModel("props_factory/factory_panel_metal_chopped_bottom_128x64.mdl")

        PrecacheModel("props/ball_button.mdl")

        PrecacheModel("props_lab/glass_observation_3.mdl")

        PrecacheModel("props_office/wall_column_128_int_corner.mdl")

        PrecacheModel("props_office/wall_column_384_ext.mdl")

        PrecacheModel("props_office/wall_door_frame_64a.mdl")

        PrecacheModel("props_factory/factory_panel_metal_chopped_top_128x128.mdl")

        DoneCacheing <- true
  }


    if (CreateTime==true) {
        // Create Objects

        local sp_a2_triple_laser_custom_prop_50 = CreateProp("prop_dynamic", Vector(7776.982421875, -5494.6748046875, -0.7366943359375), "models/props_lab/window_256.mdl", 0)
        sp_a2_triple_laser_custom_prop_50.SetAngles(-3.1268306086712e-12, -90, 1.52587890625e-05)
        sp_a2_triple_laser_custom_prop_50.__KeyValueFromString("solid", "6")
        sp_a2_triple_laser_custom_prop_50.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a2_triple_laser_custom_prop_51 = CreateProp("prop_dynamic", Vector(8321.517578125, -5664.0283203125, 89.195999145508), "models/props/futbol_dispenser.mdl", 0)
        sp_a2_triple_laser_custom_prop_51.SetAngles(-2.3402319663434e-15, 90, 180)
        sp_a2_triple_laser_custom_prop_51.__KeyValueFromString("solid", "6")
        sp_a2_triple_laser_custom_prop_51.__KeyValueFromString("targetname", "dispenser1")

        local sp_a2_triple_laser_custom_prop_52 = CreateProp("prop_dynamic", Vector(7777.3188476562, -5494.859375, 128.2112121582), "models/props_lab/window_256_a.mdl", 0)
        sp_a2_triple_laser_custom_prop_52.SetAngles(-1.1290127903754e-13, -90, 1.52587890625e-05)
        sp_a2_triple_laser_custom_prop_52.__KeyValueFromString("solid", "6")
        sp_a2_triple_laser_custom_prop_52.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a2_triple_laser_custom_prop_53 = CreateProp("prop_dynamic", Vector(7617.6953125, -5494.6791992188, -0.72720336914062), "models/props_lab/window_64_a.mdl", 0)
        sp_a2_triple_laser_custom_prop_53.SetAngles(7.5830328627378e-21, -90, 1.52587890625e-05)
        sp_a2_triple_laser_custom_prop_53.__KeyValueFromString("solid", "6")
        sp_a2_triple_laser_custom_prop_53.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a2_triple_laser_custom_prop_54 = CreateProp("prop_dynamic", Vector(7966.7475585938, -5490.5004882812, 0.73605346679688), "models/props_office/sliding_door.mdl", 0)
        sp_a2_triple_laser_custom_prop_54.SetAngles(7.5830328627378e-21, -90, 1.52587890625e-05)
        sp_a2_triple_laser_custom_prop_54.__KeyValueFromString("solid", "6")
        sp_a2_triple_laser_custom_prop_54.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a2_triple_laser_custom_prop_55 = CreateProp("prop_dynamic", Vector(7936.7827148438, -5490.70703125, 176.44068908691), "models/props_lab/glass_observation_2.mdl", 0)
        sp_a2_triple_laser_custom_prop_55.SetAngles(-2.132360975483e-15, -90, 1.52587890625e-05)
        sp_a2_triple_laser_custom_prop_55.__KeyValueFromString("solid", "6")
        sp_a2_triple_laser_custom_prop_55.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a2_triple_laser_custom_prop_56 = CreateProp("prop_dynamic", Vector(7449.6533203125, -5728.4458007812, 31.576444625854), "models/props_factory/factory_panel_metal_chopped_bottom_128x64.mdl", 0)
        sp_a2_triple_laser_custom_prop_56.SetAngles(-1.4705283431921e-13, -2.1982020825817e-06, 1.52587890625e-05)
        sp_a2_triple_laser_custom_prop_56.__KeyValueFromString("solid", "0")
        sp_a2_triple_laser_custom_prop_56.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a2_triple_laser_custom_prop_57 = CreateProp("prop_dynamic", Vector(7776.2314453125, -5664.142578125, 256.77786254883), "models/props/ball_button.mdl", 0)
        sp_a2_triple_laser_custom_prop_57.SetAngles(-1.8504917379241e-13, 179.99992370605, 180)
        sp_a2_triple_laser_custom_prop_57.__KeyValueFromString("solid", "6")
        sp_a2_triple_laser_custom_prop_57.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a2_triple_laser_custom_prop_58 = CreateProp("prop_dynamic", Vector(7773.8110351562, -5490.3608398438, 62.269149780273), "models/props_lab/glass_observation_3.mdl", 0)
        sp_a2_triple_laser_custom_prop_58.SetAngles(7.5830328627378e-21, -90, 1.52587890625e-05)
        sp_a2_triple_laser_custom_prop_58.__KeyValueFromString("solid", "6")
        sp_a2_triple_laser_custom_prop_58.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a2_triple_laser_custom_prop_59 = CreateProp("prop_dynamic", Vector(7776.7553710938, -5490.5380859375, 191.90145874023), "models/props_lab/glass_observation_3.mdl", 0)
        sp_a2_triple_laser_custom_prop_59.SetAngles(1.3484940703141e-13, -90, 0)
        sp_a2_triple_laser_custom_prop_59.__KeyValueFromString("solid", "6")
        sp_a2_triple_laser_custom_prop_59.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a2_triple_laser_custom_prop_60 = CreateProp("prop_dynamic", Vector(7936.7827148438, -5490.70703125, 304.44067382812), "models/props_lab/glass_observation_2.mdl", 0)
        sp_a2_triple_laser_custom_prop_60.SetAngles(-2.132360975483e-15, -90, 1.52587890625e-05)
        sp_a2_triple_laser_custom_prop_60.__KeyValueFromString("solid", "6")
        sp_a2_triple_laser_custom_prop_60.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a2_triple_laser_custom_prop_61 = CreateProp("prop_dynamic", Vector(7617.6245117188, -5493.8837890625, 128.40710449219), "models/props_lab/window_64_a.mdl", 0)
        sp_a2_triple_laser_custom_prop_61.SetAngles(7.5830328627378e-21, -90, 1.52587890625e-05)
        sp_a2_triple_laser_custom_prop_61.__KeyValueFromString("solid", "6")
        sp_a2_triple_laser_custom_prop_61.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a2_triple_laser_custom_prop_62 = CreateProp("prop_dynamic", Vector(7454.5869140625, -5727.9619140625, 89.567008972168), "models/props/futbol_dispenser.mdl", 0)
        sp_a2_triple_laser_custom_prop_62.SetAngles(6.225527315884e-10, -90, 180)
        sp_a2_triple_laser_custom_prop_62.__KeyValueFromString("solid", "6")
        sp_a2_triple_laser_custom_prop_62.__KeyValueFromString("targetname", "dispenser2")

        local sp_a2_triple_laser_custom_prop_63 = CreateProp("prop_dynamic", Vector(8031.8120117188, -5489.7236328125, 130.93634033203), "models/props_office/wall_column_128_int_corner.mdl", 0)
        sp_a2_triple_laser_custom_prop_63.SetAngles(-9.5416635204938e-15, 90, -90)
        sp_a2_triple_laser_custom_prop_63.__KeyValueFromString("solid", "6")
        sp_a2_triple_laser_custom_prop_63.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a2_triple_laser_custom_prop_64 = CreateProp("prop_dynamic", Vector(7521.6357421875, -5490.4560546875, 127.66311645508), "models/props_office/wall_column_384_ext.mdl", 0)
        sp_a2_triple_laser_custom_prop_64.SetAngles(-6.3611090136625e-14, -90, -90)
        sp_a2_triple_laser_custom_prop_64.__KeyValueFromString("solid", "6")
        sp_a2_triple_laser_custom_prop_64.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a2_triple_laser_custom_prop_65 = CreateProp("prop_dynamic", Vector(7906.7739257812, -5490.62109375, 0.77362060546875), "models/props_office/sliding_door.mdl", 0)
        sp_a2_triple_laser_custom_prop_65.SetAngles(-7.5830328627378e-21, 90, 1.52587890625e-05)
        sp_a2_triple_laser_custom_prop_65.__KeyValueFromString("solid", "6")
        sp_a2_triple_laser_custom_prop_65.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a2_triple_laser_custom_prop_66 = CreateProp("prop_dynamic", Vector(7936.8081054688, -5490.4643554688, -0.05926514044404), "models/props_office/wall_door_frame_64a.mdl", 0)
        sp_a2_triple_laser_custom_prop_66.SetAngles(-2.2793925291496e-36, -90, 0)
        sp_a2_triple_laser_custom_prop_66.__KeyValueFromString("solid", "6")
        sp_a2_triple_laser_custom_prop_66.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a2_triple_laser_custom_prop_67 = CreateProp("prop_dynamic", Vector(7937.1323242188, -5494.9916992188, 128.29275512695), "models/props_lab/window_64_a.mdl", 0)
        sp_a2_triple_laser_custom_prop_67.SetAngles(3.9563714517444e-17, -90, 1.52587890625e-05)
        sp_a2_triple_laser_custom_prop_67.__KeyValueFromString("solid", "6")
        sp_a2_triple_laser_custom_prop_67.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a2_triple_laser_custom_prop_68 = CreateProp("prop_dynamic", Vector(8031.8120117188, -5491.4736328125, 130.93634033203), "models/props_office/wall_column_128_int_corner.mdl", 0)
        sp_a2_triple_laser_custom_prop_68.SetAngles(-89.999961853027, -179.99995422363, 180)
        sp_a2_triple_laser_custom_prop_68.__KeyValueFromString("solid", "6")
        sp_a2_triple_laser_custom_prop_68.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a2_triple_laser_custom_prop_69 = CreateProp("prop_dynamic", Vector(8185.126953125, -5835.3701171875, 63.867156982422), "models/props_factory/factory_panel_metal_chopped_top_128x128.mdl", 0)
        sp_a2_triple_laser_custom_prop_69.SetAngles(1.8721375560915e-09, 120.41382598877, 1.52587890625e-05)
        sp_a2_triple_laser_custom_prop_69.__KeyValueFromString("solid", "0")
        sp_a2_triple_laser_custom_prop_69.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a2_triple_laser_custom_prop_70 = CreateProp("prop_dynamic", Vector(7521.6357421875, -5492.7055664062, 127.66311645508), "models/props_office/wall_column_384_ext.mdl", 0)
        sp_a2_triple_laser_custom_prop_70.SetAngles(5.0089556680177e-06, 89.999961853027, 90.000022888184)
        sp_a2_triple_laser_custom_prop_70.__KeyValueFromString("solid", "6")
        sp_a2_triple_laser_custom_prop_70.__KeyValueFromString("targetname", "genericcustomprop")

  }


    if (LoopTime==true) {
        // Generated Teleports

  }
}
}


if (CacheTime == true) {
  PrecacheModel("models/props/metal_box.mdl")
  DoneCacheing <- true
}

}