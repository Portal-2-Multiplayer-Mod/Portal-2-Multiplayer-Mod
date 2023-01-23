//*****************************************************
//====DEFAULT MODE====
//the original one, removes cutscenes and makes things less dumber
//*****************************************************


//unwanted dialogues
DIALOGUES <- [
  630,553, //intro1
  316,317,318, //intro3
  497, //bts1
  320, //bts3
  -3129,-3128,-1995,-1996,-1997,-1998,-1999,-2000,-2001,-2002, //portal_intro
  591, //finale4
]

function spTransitionListFix(){
  if(FIRST_MAP_WITH_POTATO_GUN!="sp_a3_end"){
    modlog("Fixing sp_transition_list...")
    FIRST_MAP_WITH_POTATO_GUN = "sp_a3_end"
    
    //TODO: fix the existing table instead.
    MapPlayOrder = [
      "sp_a1_intro1","sp_a1_intro2","sp_a1_intro3","sp_a1_intro4",
      "sp_a1_intro5","sp_a1_intro6","sp_a1_intro7","sp_a1_wakeup","@incinerator",

      "sp_a2_intro","sp_a2_laser_intro","sp_a2_laser_stairs","sp_a2_dual_lasers",
      "sp_a2_laser_over_goo","sp_a2_catapult_intro","sp_a2_trust_fling","sp_a2_pit_flings",
      "sp_a2_fizzler_intro","sp_a2_sphere_peek","sp_a2_ricochet","sp_a2_bridge_intro","sp_a2_bridge_the_gap",
      "sp_a2_turret_intro","sp_a2_laser_relays","sp_a2_turret_blocker","sp_a2_laser_vs_turret",
      "sp_a2_pull_the_rug","sp_a2_column_blocker","sp_a2_laser_chaining","sp_a2_triple_laser",

      "sp_a2_bts1","sp_a2_bts2","sp_a2_bts3","sp_a2_bts4","sp_a2_bts5","sp_a2_core",

      "@bottomless_pit","sp_a3_01","sp_a3_03","@test_dome_lift","sp_a3_jump_intro",
      "@test_dome_lift","sp_a3_bomb_flings","@test_dome_lift","sp_a3_crazy_box","@test_dome_lift","sp_a3_transition01",
      "@test_dome_lift","sp_a3_speed_ramp","@test_dome_lift","sp_a3_speed_flings","@test_dome_lift","sp_a3_portal_intro",
      "@hallway","sp_a3_end",

      "sp_a4_intro","sp_a4_tb_intro","sp_a4_tb_trust_drop","sp_a4_tb_wall_button","sp_a4_tb_polarity","sp_a4_tb_catch",
      "sp_a4_stop_the_box","sp_a4_laser_catapult","sp_a4_laser_platform","sp_a4_speed_tb_catch","sp_a4_jump_polarity",
      "sp_a4_finale1","@hallway","sp_a4_finale2","@hallway","sp_a4_finale3","@hallway","sp_a4_finale4"
    ]
  }
}

function SpeedrunModePrecache(){
  //loading glass window model replacement ("removing" prop_static model for celeste mode)
  smsm.PrecacheModel("models/props_destruction/glass_broken_128x128_d_copy.mdl", true);
  self.PrecacheSoundScript("music.itsaspeedrun");
}

function FixCelesteModeWindow(pos,ang){
  //spawning window replacement (celeste mode ugh)
  local window_fix = Entities.CreateByClassname("prop_dynamic");
  window_fix.SetModel("models/props_destruction/glass_broken_128x128_d_copy.mdl")
  window_fix.SetOrigin(pos);
  EntFireByHandle(window_fix, "AddOutput", "targetname celeste_window_fix", 0, null, null)
  EntFireByHandle(window_fix, "AddOutput", "solid 6", 0, null, null)
  window_fix.SetAngles(ang.x,ang.y,ang.z)
}

function SpeedrunModePostSpawn(){
  CHAPTER_TITLES = []
  spTransitionListFix()
}

//an actual load
function SpeedrunModeLoad(){

  modlog("Speedrun mode started!")
  modlog("Fixing entities..")

  //remove shaking before anything happens
  EntFire("env_shake", "Kill")

  //well, that happens
  EntFire("@command", "Command", "mat_fullbright 0")

  //get rid of default hints, who needs them lmao
  local hint = null;
  while(hint=Entities.FindByClassname(hint,"env_instructor_hint"))EntFireByHandle(hint, "Kill", "", 0, null, null)

  switch(GetMapName()){
    case "sp_a1_intro1":
      //creating beginning cutscene out of original elements in glass chamber
      local ghostAnim = GetEntity("ghostAnim")
      ghostAnim.SetOrigin(Vector(-1190,4456,2724))
      ghostAnim.SetAngles(0,180,0)

      EntFire("good_morning_vcd", "Kill", 0)
      EntFire("enter_chamber_trigger", "Kill", 0)
      EntFire("glass_floor_brush", "Kill", 0)
      //GetPlayer().SetOrigin(Vector(-1232,4440,2770))
      GetPlayer().SetOrigin(Vector(-1335,4166,2945))
      
      DialogueMute_ForceFor(15);
      EntFire("@exit_door-testchamber_door", "Open")
      EntFire("@glados", "RunScriptCode", "GladosPlayVcd(\"PreHub01RelaxationVaultIntro01\")", 3)
      EntFire("@glados", "RunScriptCode", "GladosPlayVcd(\"PreHub01RelaxationVaultIntro04\")", 7.2)

      //keep saving active
      EntFire("@command", "Command", "map_wants_save_disable 0", 0)

      //remove door rng
      EntFire("exit_door_right_a00_wiggle", "Kill")

      //-1232 4400 2856.5
      local trigger = Entities.FindByClassnameNearest("trigger_once", Vector(-1232, 4400, 2856), 10)
      EntFireByHandle(trigger, "Kill", "", 0, null, null)
      EntFire("fog_intro_ride", "SetStartDist", 128)
      EntFire("fog_intro_ride", "SetEndDist", 2500)

      EntFire("radio", "AddOutput", "OnPlayerPickup "+self.GetName()+":RunScriptCode:IntroRadioPlay():0:1")

      if(false){ //developer feature - make wakeup anim faster
        GetPlayer().SetOrigin(Vector(-1190,4456,2724));
        EntFire("camera_intro","Kill")
        EntFire("cryo_fade_in_from_white", "Kill")
      }
      break
    case "sp_a1_intro2":
      //that one is not really needed since ele is already waiting, but im gonna leave it lol
      EntFire("Room_01-glados_congrats_trigger", "AddOutput" "OnTrigger departure_elevator-blocked_elevator_tube_anim:Trigger::0:1", 0.0)

      //making portals faster
      EntFire("orange_portal_activate_rl", "Trigger")
      EntFire("orange_portal_activate_rl", "Kill", 0, 3)

      EntFire("blue_1_portal_activate_rl", "Kill")
      EntFire("logic_make_blue_1", "AddOutput", "OnTrigger portal_blue_1:SetActivatedState:1:0.01:-1")
      EntFire("logic_make_blue_1", "AddOutput", "OnTrigger emitter_blue_1:Skin:1:0.01:-1")
      EntFire("logic_make_blue_1", "AddOutput", "OnTrigger shake_portal_spawn_room1a:StartShake::0.01:-1")

      EntFire("blue_2_portal_activate_rl", "Kill")
      EntFire("logic_make_blue_2", "AddOutput", "OnTrigger portal_blue_2:SetActivatedState:1:0.01:-1")
      EntFire("logic_make_blue_2", "AddOutput", "OnTrigger emitter_blue_2:Skin:1:0.01:-1")
      EntFire("logic_make_blue_2", "AddOutput", "OnTrigger shake_portal_spawn_room1a:StartShake::0.01:-1")

      EntFire("blue_3_portal_activate_rl", "Kill")
      EntFire("logic_make_blue_3", "AddOutput", "OnTrigger portal_blue_3:SetActivatedState:1:0.01:-1")
      EntFire("logic_make_blue_3", "AddOutput", "OnTrigger emitter_blue_3:Skin:1:0.01:-1")
      EntFire("logic_make_blue_3", "AddOutput", "OnTrigger shake_portal_spawn_room1a:StartShake::0.01:-1")
      break
    case "sp_a1_intro3":
      //same as above, completely unnecessary stuff, but oh well
      EntFire("departure_elevator-blocked_elevator_tube_anim", "Kill", 0)
      EntFire("departure_elevator-tube_blockage_01", "Kill", 0)
      EntFire("departure_elevator-tube_blockage_02", "Kill", 0)
      EntFire("departure_elevator-source_elevator_door_open_trigger", "AddOutput" "OnTrigger departure_elevator-elevator_arrive:Trigger::0:1", 0.0)

      //open doors faster
      EntFire("door_1", "Open")

      //kill wheatley because why not lets be hitler
      EntFire("spherebot_train_1_chassis_1", "KillHierarchy")

      //open end doors earlier
      EntFire("room_1_portal_deactivate_rl", "AddOutput", "OnTrigger door_3-door_open_relay:Trigger::0:1")

      //activate second portal faster
      EntFire("room_2_portal_activate_rl", "Kill")
      EntFire("room_1_portal_deactivate_rl", "AddOutput", "OnTrigger portal_orange_mtg:SetActivatedState:1:0:1")
      EntFire("room_1_portal_deactivate_rl", "AddOutput", "OnTrigger emitter_orange_mtg:Skin:2:0:1")
      EntFire("room_1_portal_deactivate_rl", "AddOutput", "OnTrigger room_2_portal_shake:StartShake::0:1")

      //dialogue fix
      //EntFire("glados_trigger", "Kill")
      

      break
    case "sp_a1_intro4":
      //open portal in third room earlier
      EntFire("section_2_trigger_portal_spawn_a2_rm3a", "AddOutput", "OnTrigger room_3_portal_activate_rl:Trigger::0:1")
      EntFire("section_2_trigger_portal_spawn_a2_rm3a", "AddOutput", "OnTrigger room_3_portal_activate_rl:Disable::1:1")

      //open last doors earlier
      EntFire("room_3_portal_activate_rl", "AddOutput", "OnTrigger door_2-door_open_relay:Trigger::2:1")

      //open portal in second room earlier
      EntFire("section_2_trigger_portal_spawn_a1_rm3a", "Kill")
      EntFire("fizzler1_disable_rl", "AddOutput", "OnTrigger section_2_portal_a1_rm3a:SetActivatedState:1:0:1")
      EntFire("fizzler1_disable_rl", "AddOutput", "OnTrigger section_2_portal_emitter_a1_rm3a:Skin:2:0:1")
      EntFire("fizzler1_disable_rl", "AddOutput", "OnTrigger section_2_shake_portal_spawn_a1_rm3a:StartShake::0:1")
      break
    case "sp_a1_intro5":
      //faster portal
      //EntFire("room_1_portal_activate_rl", "Trigger")
      //EntFire("room_1_portal_activate_rl", "Kill", 0, 30)
      //apparently not because bets is fat
      break
    case "sp_a1_intro6":
      //faster portal
      EntFire("room_1_fling_portal_activate_rl", "Trigger")
      EntFire("room_1_fling_portal_activate_rl", "Kill", 0 , 1)
      //i cant believe how much stuff is just sitting here, serving literally no purpose
      EntFire("departure_elevator-source_elevator_door_open_trigger", "Kill", 0)
      EntFire("success_trigger", "AddOutput", "OnTrigger departure_elevator-logic_source_elevator_door_open:Trigger::0:1",0)

      //make door 3 open faster
      EntFire("room_1_door_close_rl" "AddOutput", "OnTrigger room_2_entry_door-door_open_relay:Trigger::0:1")
      break
    case "sp_a1_intro7":
      //spawn portal earlier
      EntFire("relay_portab_spawn", "Trigger")
      EntFire("relay_portab_spawn", "Kill", 0, 2)

      //deleting wheatley from existence
      EntFire("spherebot_1_top_swivel_1", "KillHierarchy")
      EntFire("spherebot_train_1_chassis_1", "KillHierarchy")
      EntFire("spherebot_1_bottom_swivel_1", "KillHierarchy")
      EntFire("second_room_trigger", "AddOutput" "OnTrigger bts_panel_door-LR_heavydoor_open:Trigger::0:1")
      
      //leaving some doors open
      EntFire("offrails_airlock_door_1_open_rl", "Trigger")
      
      EntFire("transition_entry_door-open_door", "Trigger")
      EntFire("transition_entry_door-open_door", "Kill",0,1)

      //making transition trigger fire much faster
      EntFire("transition_trigger", "AddOutput" "OnStartTouch @transition_script:RunScriptCode:TransitionFromMap():0.5:1", 0.0)

      //bring back turret dialogues cuz ITS CUTeEE
      EntFire("sphere_filter", "Kill")
      break
    case "sp_a1_wakeup": 
      //HEKCING MESS, I DONT EVEN KNOW WHAT DOES WHAT, FORGOT TO COMMENT THIS AAAAAAAAGHGHH
      EntFire("@sphere", "Kill")
      EntFire("transition_entry_door-door_1", "SetPlaybackRate", 10)
      EntFire("@switch_door_open_rl", "Trigger", 0, 0.1)
      EntFire("@switch_door_open_rl", "Kill", 0, 0.4)
      //EntFire("training_door", "SetSpeed", 200)
      EntFire("training_door", "Kill") //just kill these fucking doors lmaof
      EntFire("dont_see_switch_vcd_trigger", "Enable", 0.0)
      EntFire("dont_see_switch_vcd_trigger", "AddOutput" "OnStartTouch basement_breakers_socket_relay:Trigger::0:1", 0.0)
      //EntFire("socket_powered_rl", "Trigger")
      //EntFire("socket_powered_rl", "Kill", 1)
      EntFire("playerproxy", "setdropenabled", 1, 0.01)
      EntFire("relay_hallway_fog_and_tonemap", "AddOutput", "OnTrigger training_door:Open::0:1")
      EntFire("basement_breakers_upper_blocker", "Kill")
      EntFire("basement_breaker_room_entry_trigger", "starttouch")
      EntFire("basement_breakers_entrance_door", "Open", 0, 1)
      //EntFire("aud_World.LightPowerOnLg", "Kill")
      EntFire("@FallingTrigger", "AddOutput", "OnStartTouch @music_piece_of_work:StopSound::0:1")
      EntFire("basement_breakers_prop_0", "SetAnimation", "breaker_shaft_open_hatch", 2)

      /* 
      //recreation of powerup initialization cutscene, but faster
      EntFire("do_not_touch_anything_trigger", "AddOutput" "OnTrigger basement_breakers_prop_0:SetAnimation:breaker_shaft_rotate_90:1:1", 0.0)
      EntFire("do_not_touch_anything_trigger", "AddOutput" "OnTrigger basement_bootup_wav:PlaySound::0:1", 0.0)
      EntFire("do_not_touch_anything_trigger", "AddOutput" "OnTrigger music_breakers_start:PlaySound::0:1", 0.0)
      EntFire("do_not_touch_anything_trigger", "AddOutput" "OnTrigger basement_malfunction_1_wav:PlaySound::0:1", 0.0)
      EntFire("do_not_touch_anything_trigger", "AddOutput" "OnTrigger breaker_train:MoveToPathNode:breaker_train_path_4:1.2:1",0.0)
      //EntFire("do_not_touch_anything_trigger", "AddOutput" "OnTrigger @glados:RunScriptCode:GladosPlayVcd(\"sp_a1_wakeupWakeupOops01\"):1.5:1",0.0)
      EntFire("do_not_touch_anything_trigger", "AddOutput" "OnTrigger basement_breakers_prop_rotate:PlaySound::1:1",0.0)
      //EntFire("do_not_touch_anything_trigger", "AddOutput" "OnTrigger @glados:RunScriptCode:GladosPlayVcd(\"sp_a1_wakeupWakeupOops03\"):6.3:1",0.0)
      EntFire("do_not_touch_anything_trigger", "AddOutput" "OnTrigger breaker_train:SetMaxSpeed:52:3.3:1", 0.0)
      EntFire("do_not_touch_anything_trigger", "AddOutput" "OnTrigger basement_breakers_up:Trigger::3.3:1", 0.0)
      EntFire("do_not_touch_anything_trigger", "AddOutput" "OnTrigger basement_breakers_cap_brush:Kill::4.3:1", 0.0)
      EntFire("do_not_touch_anything_trigger", "AddOutput" "OnTrigger shaft_blocker:Disable::4.3:1", 0.0)
      EntFire("do_not_touch_anything_trigger", "AddOutput" "OnTrigger basement_breakers_aperture_door:Open::5.3:1", 0.0)
      EntFire("do_not_touch_anything_trigger", "AddOutput" "OnTrigger platform_areaportal:Open::5.3:1", 0.0)
      //EntFire("do_not_touch_anything_trigger", "AddOutput" "OnTrigger glados_start:Trigger::13.3:1", 0.0)
      */

      EntFire("basement_breakers_start", "Disable") //disabling old cutscene
      /*
      //allow player to get to the incinerator on their own
      EntFire("do_not_touch_anything_trigger", "AddOutput" "OnTrigger basement_breakers_upper_blocker:Disable::1:1", 0.0)
      EntFire("do_not_touch_anything_trigger", "AddOutput" "OnTrigger relay_incinerator_open:Trigger::18:1", 0.0)
      */

      //making portal disappear before level transition
      EntFire("@transition_from_map", "AddOutput", "OnTrigger viewmodel:DisableDraw::0:1", 0.0)
      EntFire("@transition_from_map", "AddOutput", "OnTrigger weapon_portalgun:Kill::0:1", 0.0)
      
      //different ending (fall instead of)
      EntFire("breaker_train", "KillHierarchy")
      EntFire("do_not_touch_anything_trigger", "Kill")
      EntFire("basement_breakers_prop_0", "KillHierarchy")
      //8976 1088 -568
      EntFire("incinerator_entry_portal_1", "SetLocalOrigin", "8976 1088 -616")
      EntFire("incinerator_entry_portal_1", "SetPartner", "incinerator_entry_portal_2")
      EntFire("incinerator_entry_portal_1", "Open")

      //make beginning doors faster
      FasterVertDoor("transition_entry_door")

      break
    case "sp_a2_intro":
      //new spawn position
      EntFire("camera_ghostAnim", "Disable", 0, 0.1)
      EntFire("ghostAnim", "Kill", 0, 0.1)
      EntFire("@incinerator_entry_teleport", "Kill", 0)
      EntFire("relay_shake", "Trigger", null, 3)
      EntFire("ss_incinerator_fall", "FadeOut", 1, 3)
      EntFire("!player", "RunScriptCode", "GetPlayer().SetAbsOrigin(Vector(-2784, 603, -6780))", 0.1)
      EntFire("!player", "RunScriptCode", "GetPlayer().SetVelocity(Vector(0,0,-1100))", 0.1)
      EntFire("!player", "RunScriptCode", "GetPlayer().SetAngles(89, -90, 0)", 0.1)
      SendToConsole("fadein")
      //fix portal
      EntFire("robo_light_flicker_01","AddOutput","OnTrigger portalgun_button:Unlock::0:0.1")
      //fix ele
      EntFire("departure_elevator-blocked_elevator_tube_anim", "Kill", 0)
      EntFire("door_0-door_close_relay", "AddOutput", "OnTrigger departure_elevator-elevator_arrive:Trigger::0:1", 0)
      GivePlayerPortalgun()
      break
    case "sp_a2_laser_intro":
      EntFire("start", "Kill")
      //EntFire("@ball_launcher_door", "Open")
      EntFire("@ball_launcher_door", "KillHierarchy")
      EntFire("ball_catcher_door", "Open", 0, 0.5)
      EntFire("laser_emitter_wall_door", "Trigger")
      EntFire("laser_emitter_door_horizontal", "Open", 0, 0.5)
      EntFire("laser_catcher_side_mover", "KillHierarchy")
      EntFire("laser_catcher_door", "Close", 0, 1)
      EntFire("func_door", "SetSpeed", 1000)
      EntFire("lift_a", "SetSpeed", 200, 1.0)
      break
    case "sp_a2_dual_lasers":
      //make "Dual lasers floor non-cancer"
      EntFire("platform_door", "Close", 0.5)
      EntFire("rotating_wall_noportal_volume", "Kill")
      //also fire lasers because why not
      EntFire("env_portal_laser", "TurnOn")
      break
    case "sp_a2_laser_over_goo":
      local trigger = Entities.FindByClassnameNearest("trigger_once", Vector(4000, -2832, 96), 10)
      EntFireByHandle(trigger, "Kill", "", 0, null, null) //thanks PH-MLK for helping fix this crash
      EntFire("@glados", "RunScriptCode", "PuzzleStart()", 0)
      EntFire("InstanceAuto69-corridor_repair-corridor_repair", "Trigger", 2)
      EntFire("InstanceAuto69-corridor_repair-proxy", "Kill", 0)
      EntFire("InstanceAuto69-corridor_repair-blocking_door", "Kill", 0.3)
      EntFire("InstanceAuto69-corridor_repair-blocking_door_2", "Kill", 0.4)
      EntFire("entry_landing_close_relay", "Kill", 0.1)
      EntFire("entry_landing_open_relay", "Kill", 0.1)
      EntFire("door_1-door_open_relay", "Trigger", 0.2)
      break
    case "sp_a2_catapult_intro":
      EntFire("door_1-door_open_relay", "Trigger")
      EntFire("arrival_elevator-leaving_elevator_trigger", "AddOutput", "OnTrigger hallway_sim_go:Trigger::1:1", 0)
      EntFire("arrival_elevator-leaving_elevator_trigger", "AddOutput", "OnTrigger hallway_sim_go:Kill::1.1:1", 0)
      EntFire("hallway_sim_blocker", "Kill")
      EntFire("catapult_target_relay", "Trigger")
      break
    case "sp_a2_trust_fling":
      //hide panels at the beginning
      EntFire("wall_panel_1-repair_wall", "Kill", 0)
      EntFire("wall_panel_2-repair_wall", "Kill", 0)
      for(local i=1;i<=2;i++)for(local j=1;j<=8;j++){
        GetEntity("wall_panel_"+i+"-robo_powerup_corridor_0"+j+"bendy0"+i).SetModel("")
      }
      EntFire("entry_wall_panel_sound", "Kill", 0)
      EntFire("initial_arm_collision", "Kill", 0)

      //make catapults faster
      EntFire("flingroom_1_circular_catapult_1", "SetPlayerSpeed", "700")
      EntFire("flingroom_1_circular_catapult_1", "SetPhysicsSpeed", "700")

      EntFire("flingroom_1_circular_catapult_2", "SetPlayerSpeed", "700")
      EntFire("flingroom_1_circular_catapult_2", "SetPhysicsSpeed", "700")

      //button panel thingies
      EntFire("open_button_escape_panels", "Trigger", 0, 8)
      EntFire("close_button_escape_panels", "Kill", 0, 8)
      EntFire("open_button_escape_panels", "Kill", 0, 10)
      break
    case "sp_a2_pit_flings":
      EntFire("companion_cube_skin_trigger", "Kill", 0)
      EntFire("first_cube_dissolve", "Kill", 0)
      EntFire("relay_lift3_down", "Enable", 0)
      EntFire("relay_lift3_up", "Enable", 0)
      EntFire("start_platform_relay", "Trigger", 0)
      EntFire("@summon_elevator","Enable")
      EntFire("@summon_elevator","Trigger",0,0.1)
      break
    case "sp_a2_sphere_peek":
      EntFire("@trigger_this_to_fix_ceiling", "Trigger", 1)
      EntFire("@trigger_this_to_fix_catapult", "Trigger", 2)
      EntFire("landing_01-ramp_close", "AddOutput", "OnTrigger !self:Disable::1:1",0)
      EntFire("wall_replace_02_relay", "AddOutput", "OnTrigger landing_01-ramp_close:Trigger::0:1",0)

      EntFire("ramp_up_relay", "Trigger", 0, 1)
      EntFire("ramp_up_relay", "Kill", 0, 2)

      EntFire("landing_01-ramp_close", "Trigger")
      EntFire("landing_01-proxy", "Kill")

      EntFire("HACK_clip", "Kill", 0.1)
      break
    case "sp_a2_ricochet":
      EntFire("cube_retrieved_relay", "Trigger")
      EntFire("cube_retrieved_relay", "Kill", 0, 1)
      break
    case "sp_a2_bridge_intro":
      EntFire("departure_elevator-elevator_turret_wife", "Kill", 1)

      //sometimes I just wonder why I hate someone without apparent reason
      //anyway so fuck you bets
      EntFire("arrival_elevator-leaving_elevator_trigger", "AddOutput", "OnTrigger door_52-door_open_relay:Trigger::0:1")
      EntFire("floor_up_relay", "Trigger")
      EntFire("floor_up_relay", "Kill", 0, 0.1)
      break
    case "sp_a2_bridge_the_gap":
      //EntFire("trick_door_start_relay_3", "Disable", 0)
      //EntFire("start_wheatley_window_scene_relay", "Disable", 0)
      //EntFire("trick_door_start_relay_2", "AddOutput", "OnTrigger trick_door_open_relay:Trigger::5:0", 0)

      //remove doorskip
      local trigger = Entities.FindByClassnameNearest("trigger_once", Vector(-1074, -640, 1224), 100)
      EntFireByHandle(trigger, "Kill", "", 0, null, null)

      break
    case "sp_a2_turret_intro":
      EntFire("exit_airlock_door-open_door_slow", "Trigger")
      //EntFire("exit_door_relay_close", "AddOutput", "OnTrigger exit_airlock_door-open_door_slow:Trigger::0:1",0)
      EntFire("exit_airlock_door-open_door", "Disable", 0)
      break
    case "sp_a2_laser_relays":
      FasterVertDoor("exit_airlock_door");
      EntFire("exit_airlock_door-proxy", "Kill")
      EntFire("exit_airlock_door-open_door", "Trigger",0,0.2)
      EntFire("departure_elevator-elevator_turrets", "KillHierarchy")
      EntFire("departure_elevator-elevator_turrets_02", "KillHierarchy")
      EntFire("departure_elevator-elevator_turrets_03", "KillHierarchy")
      EntFire("lift_gate_close_rl", "AddOutput", "OnTrigger lift_trigger:Enable::0.5:1", 0)

      //fix the trigger
      local trigger = Entities.FindByClassnameNearest("trigger_once", Vector(1008, -704, -118), 100)
      EntFireByHandle(trigger, "SetLocalOrigin", "884 -704 -116", 0, null, null)

      break
    case "sp_a2_laser_vs_turret":
      //make turrets explode faster if portals are in right position and laser is activated
      EntFire("button_1_pressed", "AddOutput", "OnTrigger "+self.GetName()+":RunScriptCode:StartFastFakeExplosionsInLvT():0:-1", 0)
      EntFire("button_1_unpressed", "AddOutput", "OnTrigger "+self.GetName()+":RunScriptCode:EndFastFakeExplosionsInLvT():0:-1", 0)

      //remove all small turret parts (and stuff in BtS, because who walks there anyway)
      EntFire("npc_portal_turret_floor", "AddOutput", "OnExplode prop_physics:Kill::0.01:1")
      break;
    case "sp_a2_pull_the_rug":
      FixCelesteModeWindow(Vector(128, -649, 192), Vector(0,270,0));
      break;
    case "sp_a2_column_blocker":
      //Maybe-fixed Cube RNG (from Bets)
      local catapultNewTarget = Vector(896, 257, 245)
      GetEntity("catapult_target_1").SetOrigin(catapultNewTarget)  
      GetEntity("catapult_target_2").SetOrigin(catapultNewTarget)

      EntFire("blackout_teleport_player_to_surprise", "Kill", 0)
      EntFire("surprise_room_lightswitch_sound", "Kill", 0)
      EntFire("blackout_lights_off_fade", "Kill", 0)
      EntFire("surprise_room_lights_on", "Trigger", 0)
      EntFire("door_0-door_close_relay", "AddOutput" "OnTrigger surprise_room_door_relay:Trigger::0:1", 0.0)

      //dialogue
      EntFire("@glados", "RunScriptCode", "SceneTableLookup[-400] = SceneTable[SceneTableLookup[-400]].next")
      break
    case "sp_a2_triple_laser":

      break
    case "sp_a2_bts1":
      EntFire("chamber_door-door_open_relay", "Trigger")

      EntFire("@jailbreak_exit_trigger", "Enable",0)
      EntFire("jailbreak_chamber_lit-jailbreak_trigger","AddOutput","OnStartTouch @jailbreak_begin_logic:CancelPending::1:1")
      EntFire("jailbreak_chamber_lit-jailbreak_trigger","AddOutput","OnStartTouch jailbreak_chamber_unlit-jailbreak_peak_logic:Trigger::2:1")
      EntFire("jailbreak_chamber_lit-jailbreak_trigger","AddOutput","OnStartTouch @jailbreak_1st_wall_2_2_open_logic:Trigger::2:1")
      EntFire("jailbreak_chamber_lit-jailbreak_trigger","AddOutput","OnStartTouch @jailbreak_1st_wall_1_2_open_logic:Trigger::2:1")
      EntFire("jailbreak_chamber_lit-jailbreak_trigger","AddOutput","OnStartTouch @jailbreak_1st_wall_2_2_open_logic:Kill::2.1:1")
      EntFire("jailbreak_chamber_lit-jailbreak_trigger","AddOutput","OnStartTouch @jailbreak_1st_wall_1_2_open_logic:Kill::2.1:1")
      //EntFire("jailbreak_chamber_lit-jailbreak_trigger","AddOutput","OnStartTouch jailbreak_chamber_unlit-jailbreak_1st_wall_1_1_open_logic:Trigger::0:1")
      //EntFire("jailbreak_chamber_lit-jailbreak_trigger","AddOutput","OnStartTouch jailbreak_chamber_unlit-jailbreak_1st_wall_2_1_open_logic:Trigger::0:1")
      EntFire("@jailbreak_exit_trigger","AddOutput","OnStartTouch jailbreak_chamber_unlit-test_chamber_bridge:Enable::0:1")
      


      //player can miss post transition trigger in bts2, workaround
      //I think you don't need it anymore and it's just making the game slower, but i'm too lazy to test it lol
      //local telepos = GetEntity("@exit_teleport").GetOrigin();
      //EntFire("transition_trigger","AddOutput","OnStartTouch @command:Command:setpos_exact "+telepos.x+" "+telepos.y+" "+telepos.z+":0.5:1")
      
      //fix dialogue
      //EntFire("jailbreak_chamber_lit-jailbreak_trigger","AddOutput","OnStartTouch @glados:RunScriptCode:WheatleyGoGoGoNag():3:1")
      EntFire("@glados", "RunScriptCode", "delete JailbreakICanHearYou")
      EntFire("@glados", "RunScriptCode", "SceneTableLookup[498] = SceneTable[SceneTableLookup[498]].next")
      EntFire("jailbreak_chamber_lit-jailbreak_trigger","AddOutput","OnStartTouch @glados:RunScriptCode:nuke();GladosPlayVcd(498):1.5:1")
      
      //switch bridges, easiest solution to keep the "second" one opened
      local bridge1 = GetEntity("jailbreak_chamber_lit-test_chamber_bridge")
      local bridge2 = GetEntity("jailbreak_chamber_unlit-test_chamber_bridge")
      local bridge1pos = bridge1.GetOrigin()
      local bridge2pos = bridge2.GetOrigin()
      bridge1.SetOrigin(bridge2pos)
      bridge2.SetOrigin(bridge1pos)
      EntFire("jailbreak_chamber_lit-jailbreak_trigger","AddOutput","OnStartTouch jailbreak_chamber_lit-test_chamber_bridge:Enable::1:1")
      break
    case "sp_a2_bts2":
      EntFire("controlroom_gate_a_rotating", "AddOutput", "OnFullyClosed exit_elevator_move_relay:Trigger::0:1")
      EntFire("controlroom_gate_a_rotating", "AddOutput", "OnFullyClosed exit_elevator_move_relay:Disable::1:1")
      EntFire("controlroom_gate_a_rotating", "SetSpeed", 300)
      EntFire("controlroom_gate_b_rotating", "SetSpeed", 300)
      EntFire("exit_elevator_train", "SetMaxSpeed", 300, 1)
      EntFire("security_door_1_open", "Disable")
      EntFire("exit_security_door-open_door", "Trigger", 0, 0)
      
      EntFire("transition_trigger", "AddOutput", "OnStartTouch transition_noportal_volume:Activate::0:1")
      EntFire("transition_trigger", "AddOutput", "OnStartTouch @transition_script:RunScriptCode:TransitionFromMap():0.1:1")
      break
    case "sp_a2_bts3":

      EntFire("entry_airlock_door-door_1", "SetPlaybackRate", "5", 0.4)
      EntFire("entry_airlock_door-proxy", "Kill")
      EntFire("entry_airlock_door-open_door_malfunction","Trigger",0,0)
      EntFire("entry_canyon_clip", "Kill")
      EntFire("@sphere", "EnableFlashlight")
      EntFire("entry_canyon_powering_off_relay", "Disable")
      EntFire("lamp_physbox", "Kill")
      EntFire("swinging_light", "LightOff")
      EntFire("fog_factory", "SetEndDist", 7000)
      for(local i=1;i<=5;i++){
        EntFire("canyone_entrance_spot_"+i,"LightOff")
        EntFire("entry_canyon_paired_light_"+i,"TurnOff")
        EntFire("entry_canyon_paired_light_"+i+"_model", "Skin", 1)
      }

      EntFire("exit_airlock_door-open_door", "Trigger")
      EntFire("exit_airlock_door-open_door", "Kill",0,1)
      EntFire("exit_airlock_door-close_door_fast", "AddOutput", "OnTrigger @transition_script:RunScriptCode:TransitionFromMap():0:1")

      //better fog for better visibility
      //EntFire("env_fog_controller", "SetStartDist", 0, 0.5)
      //EntFire("env_fog_controller", "SetColor", "50 80 110", 0.2)
      break
    case "sp_a2_bts4":
      FasterVertDoor("entry_airlock_door")
      EntFire("entry_airlock_door-open_door", "Trigger",0,0.3)
      EntFire("entry_airlock_door-open_door", "Kill",0,1)

      

      //always spawn broken turrets
      EntFire("turret_conveyor_1_pre_switch_case", "Kill")
      EntFire("turret_conveyor_1_post_switch_case", "Kill")
      EntFire("turret_conveyor_1_production_switch", "AddOutput", "OnFalse turret_conveyor_1_turret_register:FireRegisteredAsActivator1::0:-1")
      EntFire("turret_conveyor_1_production_switch", "AddOutput", "OnTrue turret_conveyor_1_turret_register:FireRegisteredAsActivator3::0:-1")
      
      EntFire("switch_turret_acceptance_relay", "AddOutput", "OnTrigger factory_controlroom_exit_door_relay:Trigger::0:1");
      
      //CreateSceneEntity("scenes/npc/announcer/sp_sabotage_factory_line04.vcd") //template missing
      //CreateSceneEntity("scenes/npc/announcer/sp_sabotage_factory_line05.vcd") //new template accepted
      EntFire("exit_airlock_door-open_door", "Trigger")
      EntFire("exit_airlock_door-open_door", "Kill",0,1)
      EntFire("exit_airlock_door-close_door_fast", "AddOutput", "OnTrigger @transition_script:RunScriptCode:TransitionFromMap():0:1")

      local turretCode =
      "local i,v\n"+
      "foreach(i,v in TurretVoManager.vcds){\n"+
      "if(v.group[0]==97){v.secs=0;v.handle=null}\n"+ //if group is "announcer_template", the only one with A as 1st character, same as above
      "if(v.group[7]==116&&v.secs!=0.85)v.group=null\n"+ //if group is "defect_test", the only one with T as 8th character, hack to avoid using string in event script
      "}\n"//+"TurretVoManager.DoTemplate<-function(){return 0}"

      EntFire("turret_vo_manager", "RunScriptCode", turretCode, 0.1)

      break
    case "sp_a2_bts5":
      FasterVertDoor("exit_airlock_door")

      //make 2nd floor door open faster
      EntFire("security_door-open_door_slow", "Kill")
      EntFire("button_relay", "AddOutput", "OnTrigger security_door-open_door:Trigger::0:1")
      FasterVertDoor("security_door")

      EntFire("exit_airlock_door-proxy", "Kill")
      EntFire("exit_airlock_door-open_door", "Trigger",0,0.2)

      EntFire("airlock_door_01-proxy", "Kill")
      EntFire("airlock_door_01-open_door", "Trigger")
      EntFire("airlock_door_02-proxy", "Kill")
      EntFire("airlock_door_02-open_door", "Trigger")
      EntFire("airlock_door_01_areaportal", "Open")

      EntFire("exit_elevator_close_entrance_relay", "AddOutput", "OnTrigger lift:SetSpeed:250:0:1")
      //execute cutscene faster
      EntFire("tube_counter" "AddOutput", "OnHitMax destroy_tanks_relay:Trigger::0:1")
      EntFire("tube_counter" "AddOutput", "OnHitMax destroy_tanks_relay:Kill::1:1")
      EntFire("tube_counter" "AddOutput", "OnHitMax tank_destruction_rl:Trigger::0:1")
      EntFire("tube_counter" "AddOutput", "OnHitMax tube_counter:CancelPending::0:1")
      EntFire("tube_counter" "AddOutput", "OnHitMax full_tubes_animation_start_relays:Trigger::0:1")
      
      EntFire("tank_destruction_rl", "AddOutput", "OnTrigger tank_explosions_rl:Trigger::0:1")
      EntFire("tank_destruction_rl", "AddOutput", "OnTrigger exit_dialog_trigger:Enable::0:1")
      EntFire("tank_destruction_rl", "AddOutput", "OnTrigger @sphere:SetIdleSequence:sphere_damaged_tube_suck_idle:0:1")
      EntFire("tank_destruction_rl", "AddOutput", "OnTrigger pipe_connector:Break::0:1")
      EntFire("tank_destruction_rl", "AddOutput", "OnTrigger pipe_connector_secondary:Break::0:1")
      EntFire("tank_destruction_rl", "AddOutput", "OnTrigger collapse_start_relay:Trigger::0:1")
      EntFire("tank_destruction_rl", "AddOutput", "OnTrigger full_tubes_a*:Kill::0:1")
      EntFire("tank_destruction_rl", "AddOutput", "OnTrigger full_tubes_b*:Kill::0:1")
      EntFire("tank_destruction_rl", "AddOutput", "OnTrigger full_tubes_c*:Kill::0:1")
      EntFire("tank_destruction_rl", "AddOutput", "OnTrigger full_tubes_d*:Kill::0:1")
      EntFire("tank_destruction_rl", "AddOutput", "OnTrigger full_tubes_e*:EnableDraw::0:1")
      EntFire("tank_destruction_rl", "AddOutput", "OnTrigger full_tubes_e*:FireUser1::0:1")

      //make portalable surface spawn rate higher
      local spawnPointOffset = 192+64
      local waypoint1 = GetEntity("panelpath_5-track_3")
      local waypoint1pos = waypoint1.GetOrigin()
      waypoint1pos.z = 3536+spawnPointOffset
      waypoint1.SetOrigin(waypoint1pos)
      
      local waypoint2 = GetEntity("panelpath_4-track_3")
      local waypoint2pos = waypoint2.GetOrigin()
      waypoint2pos.y = -1472+spawnPointOffset
      waypoint2.SetOrigin(waypoint2pos)

      //make platforms drop faster:
      EntFire("button_relay", "AddOutput", "OnTrigger @laser_blocker_front:Kill::0:1")
      EntFire("button_relay", "AddOutput", "OnTrigger @laser_blocker:Kill::0:1")
      EntFire("button_relay", "AddOutput", "OnTrigger @command:Command:ent_fire side_1_panelpath_1-panel_1_top_const* kill:0:1")
      EntFire("button_relay", "AddOutput", "OnTrigger @command:Command:ent_fire side_1_panelpath_2-panel_1_top_const* kill:0:1")
      
      //fix ele
      //EntFire("lift_blocker", "Kill", 1)
      EntFire("exit_elevator_close_entrance_relay", "AddOutput", "OnTrigger lift_blocker:Kill::2.8:1")
      EntFire("controlroom_gate_b_rotating", "SetSpeed", 300)
      EntFire("controlroom_gate_a_rotating", "SetSpeed", 300)
      EntFire("exit_elevator_close_entrance_relay", "AddOutput", "OnTrigger controlroom_gate_a_rotating:Open::2.8:1")
      EntFire("exit_elevator_close_entrance_relay", "AddOutput", "OnTrigger controlroom_gate_b_rotating:Open::2.8:1")
      //local model = Entities.FindByClassnameWithin(null, "prop_dynamic", Vector(2885, 944, 3610), 1)
      //local model2 = Entities.FindByClassnameWithin(model, "prop_dynamic", Vector(2885, 944, 3610), 1)
      //EntFireByHandle(model2, "Kill", "", 1, null, null)

      break
    case "sp_a2_core":
      //blockAnnouncerDelay=-1
      //leave only interactive parts of cutscene (excluding ele)
      EntFire("teleport_dbg", "Kill")
      EntFire("debug_wheatley_spawn", "Trigger")
      
      //fixing trap
      EntFire("relaxation_vault_train", "KillHierarchy")
      EntFire("rv_trap_fake_door_anglesensor", "Kill")
      EntFire("rv_trap_fake_door_blocker_1", "Kill")
      EntFire("rv_trap_fake_door_blocker_2", "Kill")
      EntFire("rv_player_clip", "Kill")
      EntFire("rv_trap_fake_door", "AddOutput", "OnMotionEnabled !self:DisableMotion::0.01:1")
      EntFire("rv_trap_floor_open_rl", "Trigger")
      EntFire("global_ents_core-proxy", "AddOutput", "OnProxyRelay2 rv_path_start1:inpass::0:1")
      EntFire("global_ents_core-proxy", "AddOutput", "OnProxyRelay2 open_globe:Trigger::0:1")
      EntFire("global_ents_core-proxy", "AddOutput", "OnProxyRelay2 music_sp_a2_core_b3:PlaySound::0:1")
      EntFire("global_ents_core-proxy", "AddOutput", "OnProxyRelay2 glados_chamber_body:SetAnimation:glados_idle_agitated:0:1")
      EntFire("global_ents_core-proxy", "AddOutput", "OnProxyRelay2 music_sp_a2_core_b3:PlaySound::0:1")
      
      //custom socket actions
      EntFire("core_socketed_relay", "Disable")
      EntFire("socket_trigger", "AddOutput", "OnTrigger close_globe:Trigger::0:1")
      EntFire("socket_trigger", "AddOutput", "OnTrigger close_rv_gantry_entry_doors_rl:Trigger::0:1")
      EntFire("socket_trigger", "AddOutput", "OnTrigger prop_portal:Fizzle::0:1")
      EntFire("socket_trigger", "AddOutput", "OnTrigger open_stalemate_room_doors_relay:Trigger::0:1")
      EntFire("socket_trigger", "AddOutput", "OnTrigger @glados:RunScriptCode:GladosPlayVcd(\"-24_10\"):0:1")

      //stalemate button
      EntFire("button_press_relay", "AddOutput", "OnTrigger player_inside_stalemate_room_trigger:Kill::1:1")
      EntFire("button_press_relay", "AddOutput", "OnTrigger @glados:RunScriptCode:WheatleyCoreTransferStart():0:1")
      EntFire("button_press_relay", "AddOutput", "OnTrigger @glados:RunScriptCode:GladosPlayVcd(\"-4_05\"):0.95:1")
      EntFire("core_receptacle_vertical_mover_3", "SetSpeed", 50)
      EntFire("button_press_relay", "AddOutput", "OnTrigger core_receptacle_vertical_mover_3:Open::0.01:1")
      EntFire("button_press_relay", "AddOutput", "OnTrigger core_pit_player_clip:Kill::0.01:1")
      EntFire("button_press_relay", "AddOutput", "OnTrigger iris_door_core_pit:Close::0.01:1")
      EntFire("button_press_relay", "AddOutput", "OnTrigger @glados:RunScriptCode:PullGladosIntoPit():7.5:1")
      
      //ele
      EntFire("exit_elevator_train", "KillHierarchy")
      EntFire("button_press_relay", "AddOutput", "OnTrigger iris_door_elevator_pit:Open::1:1")
      EntFire("button_press_relay", "AddOutput", "OnTrigger escape_elevator_clip:Kill::1:1")
      EntFire("button_press_relay", "AddOutput", "OnTrigger elevator_pit_areaportal:Open::1:1")
      EntFire("elevator_door_player_clip", "Kill")
      EntFire("exit_elevator_lower_frame_mover", "KillHierarchy")
      
      //something
      EntFire("begin_wheatley_emergence_relay", "Kill")
      EntFire("button_press_relay", "AddOutput", "OnTrigger @glados:Kill::16:1")
      EntFire("button_press_relay", "AddOutput", "OnTrigger maintenance_pit_script:Kill::16:1")

      //ending trigger
      local trigger2 = Entities.FindByClassnameNearest("trigger_once", Vector(0, 304, -10438), 100)
      EntFireByHandle(trigger2, "SetLocalOrigin", "0 304 -2426", 1, null, null)
      break
    case "sp_a3_01":
      //beginning
      EntFire("knockout_start", "Kill")
      EntFire("knockout-bird", "KillHierarchy")
      EntFire("ambient_sp_a3_01_b2", "PlaySound", 0, 2)
      GetPlayer().SetAbsOrigin(Vector(-640, -1536, 7000))
      GetPlayer().SetVelocity(Vector(0,0,-1100))
      GetPlayer().SetAngles(89, 180, 0)
      EntFire("knockout-fadeout", "Fade")
      GivePlayerPortalgun()
      UpgradePlayerPortalgun()
      
      //doors
      EntFire("door_ominous_black_void", "Kill")
      EntFire("big_door_clipbrush", "Kill")
      EntFire("door_start", "Kill")
      //all stuff from door_start that I want
      EntFire("logic_branch_listener", "AddOutput", "OnAllTrue alarm_start:Trigger::0:1")
      EntFire("logic_branch_listener", "AddOutput", "OnAllTrue door_spotlight_1:TurnOff::0:1")
      EntFire("logic_branch_listener", "AddOutput", "OnAllTrue door_spotlight_2_fill:TurnOff::0:1")
      EntFire("logic_branch_listener", "AddOutput", "OnAllTrue ambient_sp_a3_01_b8:PlaySound::0:1")
      EntFire("logic_branch_listener", "AddOutput", "OnAllTrue ambient_sp_a3_01_b9_trigger:Enable::0:1")
      //EntFire("logic_branch_listener", "AddOutput", "OnAllTrue vault_door_sound_open:PlaySound::0:1")
      for(local i=0;i<7;i+=0.25)EntFire("logic_branch_listener", "AddOutput", "OnAllTrue door_shake:StartShake::"+i+":1")
      
      //(5536.000000, 4608.000000, 0.000000)
      //(5632,4608,-832)
      local doorscode = 
      "local pos = self.GetOrigin()\n" +
      "if(pos.z==0)pos.x = 5632\n" +
      "if(pos.z==0)pos.z = -832\n" +
      "if(pos.x>5536)pos.x-=2\n" +
      "else if(pos.z<0)pos.z+=5\n" +
      "self.SetOrigin(pos)\n"

      //EntFire("logic_branch_listener", "AddOutput", "OnAllTrue vault_door_prop:RunScriptCode:\"self.SetOrigin(Vector(5632,4608,-832))\":0:1")
      EntFire("vault_door_prop", "AddOutput", "OnUser4 vault_door_prop:RunScriptCode:"+doorscode+":0:-1")
      EntFire("vault_door_prop", "AddOutput", "OnUser4 vault_door_prop:FireUser4::0.001:-1")
      EntFire("logic_branch_listener", "AddOutput", "OnAllTrue vault_door_prop:FireUser4::0.1:1")
      EntFire("logic_branch_listener", "AddOutput", "OnAllTrue vault_door_prop:SetAnimation:vault_door_idle_open:0:1")
      
      
      //EntFire("logic_branch_listener", "AddOutput", "OnAllTrue vault_door_prop:DisableCollision::4:1")
      EntFire("logic_branch_listener", "AddOutput", "OnAllTrue alarm_stop:Trigger::7:1")
      for(local i=5;i<=8;i++) EntFire("logic_branch_listener", "AddOutput", "OnAllTrue platform_doors_"+i+":Open::8:1")
      EntFire("logic_branch_listener", "AddOutput", "OnAllTrue door_spotlight_1:TurnOn::7:1")
      EntFire("logic_branch_listener", "AddOutput", "OnAllTrue door_spotlight_2_fill:TurnOn::7:1")

      //Open ending doors right away
      EntFire("AutoInstance1-door_button", "Press")

      //put transition trigger closer
      local transition_trigger = Entities.FindByClassnameNearest("trigger_once", Vector(6016, 4496, -448), 10)
      EntFireByHandle(transition_trigger, "SetLocalOrigin", "5952 4496 -448", 0, null, null)

      //noone asked for it but it would be nice for this to be pressed already lol
      local lightslever = Entities.FindByClassnameNearest("func_button", Vector(3692, 4482, -370), 10)
      EntFire("AutoInstance1-circuit_breaker_lever_sound", "Kill")
      EntFireByHandle(lightslever, "Press", "", 0.1, null, null)

      break
    case "sp_a3_02":
      EntFire("finale_4_wrongwarp", "Activate")
      break
    case "sp_a3_03":
      EntFire("door1_button", "Press")

      EntFire("AutoInstance1-push_button_knob", "AddOutput", "OnIn powerup_door_trigger:Enable::0:1")
      EntFire("main_elevator_up_relay", "AddOutput", "OnTrigger main_elevator:SetMaxSpeed:300:0.01:-1")
      EntFire("pump_machine_relay", "AddOutput", "OnTrigger controlroom_gate_a_rotating:Open::0.01:1")
      EntFire("pump_machine_relay", "AddOutput", "OnTrigger controlroom_gate_b_rotating:Open::0.01:1")
      FastUndergroundTransition(null, 3)
      break
    case "sp_a3_jump_intro":
      EntFire("AutoInstance1-entrance_lift_prop", "Kill")
      EntFire("InstanceAuto12-entrance_lift_train", "SetSpeed", 200, 0.1)
      EntFire("InstanceAuto12-entrance_lift_train", "SetMaxSpeed", 200)
      EntFire("InstanceAuto12-entrance_lift_doortop_movelinear", "Open", 0, 2)
      EntFire("InstanceAuto12-entrance_lift_doorbottom_movelinear", "Open", 0, 2)
      local entsToMove = ["!player", "InstanceAuto12-entrance_lift_train", "@test_dome_lift_entry_teleport", "InstanceAuto12-entrance_lift_train_path_1", "InstanceAuto12-entrance_lift_train_path_2"]
      local movecode = 
      "local pos = self.GetOrigin()\n" +
      "if(pos.x < -8000)pos.x = -432\n" +
      "self.SetOrigin(pos)\n"
      foreach (index, ent in entsToMove){
        EntFire(ent,"RunScriptCode", movecode)
      }
      //safety teleport
      EntFire("InstanceAuto12-entrance_lift_train", "AddOutput", "OnStart !player:RunScriptCode:"+movecode+":0:1")
      FastUndergroundTransition(null, 24)

      //dialogue
      EntFire("@glados", "RunScriptCode", "GladosPlayVcd(-5053)", 3)
      break
    case "sp_a3_bomb_flings":
      //make bomb spawn rate much faster
      EntFire("trigger_to_drop", "Kill")
      EntFire("paint_bomb_maker", "AddOutput", "OnEntitySpawned paint_bomb_maker:ForceSpawn::0.25:-1")
      EntFire("paint_sprayer_button", "AddOutput", "OnPressed paint_bomb_maker:ForceSpawn::0:1")

      FastUndergroundTransition(8, 22)
      break
    case "sp_a3_crazy_box":

      //make bomb spawn rate much faster
      EntFire("paint_bomb_template", "ForceSpawn", 0, 0)

      //make heckign doors opened fuck you bets
      EntFire("AutoInstance2-door_open1", "Trigger")
      EntFire("AutoInstance2-door_open1", "Kill", 0, 0.1)

      FastUndergroundTransition(17, 21)
      break
    case "sp_a3_transition01":
      FastUndergroundTransition(2, -1)
      EntFire("exit_gate_clipbrush", "Kill")
      EntFire("sphere_entrance_lift_movelinear", "Open")
      EntFire("officedoor_4_trigger", "Kill")
      EntFire("potatos_prop", "Kill", "", 2)
      EntFire("officedoor_4", "SetAnimation", "close", 2);
      
      //remove triggers in office section
      local trigger1 = Entities.FindByClassnameNearest("trigger_once", Vector(-2878,450,-4512), 10)
      EntFireByHandle(trigger1, "Kill", "0", 0, null, null)
      local trigger2 = Entities.FindByClassnameNearest("trigger_once", Vector(-3240,576,-4464), 10)
      EntFireByHandle(trigger2, "Kill", "0", 0, null, null)

      //making doors faster
      EntFire("pump_machine_relay", "Kill")
      EntFire("pump_machine_counter", "AddOutput", "OnHitMax pumproom_door_top_trigger:Enable::0:1")
      EntFire("pump_machine_counter", "AddOutput", "OnHitMax pumproom_fizzlerdoor_prop:SetAnimation:open:0:1")
      EntFire("pump_machine_counter", "AddOutput", "OnHitMax pumproom_exterior_portalblocker:Kill::0:1")

      //open some doors
      EntFire("pumproom_door_bottom_button", "Press")
      EntFire("pumproom_door_top_button", "Press")
      
      FixCelesteModeWindow(Vector(-2621, 640, -4384), Vector(0,180,-90));
      break
    case "sp_a3_speed_ramp":
      FastUndergroundTransition(20, 14)


      //dialogue (also fuck you valve)
      local gladosbitch = Entities.FindByClassnameNearest("generic_actor", Vector(428, -2904, 338), 10)
      EntFireByHandle(gladosbitch, "Kill", "0", 0, null, null)

      local dialogueCode = 
      "foreach (idx,val in scenequeue){delete scenequeue[idx]}\n"+
      "SceneTable[SceneTableLookup[-5074]].next = SceneTable[SceneTable[SceneTableLookup[-5074]].next].next\n"+
      "SceneTable[SceneTable[SceneTable[SceneTableLookup[-5074]].next].next].next = null"
      EntFire("@glados", "RunScriptCode", dialogueCode, 1)
      EntFire("@cave", "RunScriptCode", dialogueCode, 1)
      break
    case "sp_a3_speed_flings":
      FastUndergroundTransition(6, 3)
      EntFire("paint_sprayer_speed", "Start")
      EntFire("paint_sprayer_bounce", "Start")
      EntFire("paint_bounce_timer", "Kill")
      EntFire("paint_speed_timer", "Kill")
      break
    case "sp_a3_portal_intro":
      FastUndergroundTransition(-1,null)
      EntFire("highdoor_door_upper", "Open")
      EntFire("highdoor_door_lower", "Open")  //Open area after super reportal
      EntFire("highdoor_areaportal", "Open")
      EntFire("sphere_entrance_lift_train", "SetMaxSpeed", "300")
      EntFire("sphere_entrance_lift_door_bottom", "AddOutput", "OnFullyClosed sphere_entrance_lift_train:StartForward::0:1")
      local poscode = 
      "local pos = self.GetOrigin()\n" +
      "pos.z += 1000\n" +
      "self.SetOrigin(pos)"
      EntFire("sphere_entrance_lift_door_bottom", "AddOutput", "OnFullyClosed !player:RunScriptCode:"+poscode+":1.5:1")
      EntFire("sphere_entrance_lift_door_bottom", "AddOutput", "OnFullyClosed sphere_entrance_lift_train:RunScriptCode:"+poscode+":1.5:1")
      
      EntFire("sphere_entrance_lift_train_path_2", "AddOutput", "OnPass sphere_entrance_lift_train_path_3:inpass::0:1")

      //open some doors
      EntFire("liftshaft_entrance_door-door_button", "Press")
      EntFire("liftshaft_exit_door_button", "Press")

      EntFire("sphere_entrance_lift_door_top", "Open")
      EntFire("sphere_entrance_lift_door_bottom", "Open")
      EntFire("damaged_sphere_door_4-door_open", "Trigger")
      EntFire("damaged_sphere_door_4-door_open", "Kill", 1)
      break
    case "sp_a3_end":
      //faster doors at the beginning
      EntFire("entrance_door_button", "Press")
      EntFire("entrance_door_prop", "SetAnimation", "open_idle", 0.3)
      EntFire("entrance_door_prop", "SetAnimation", "open_idle", 0.5)//just in case LMFAO

      //faster gel drop
      EntFire("paint_trickle_blue_1", "AddOutput", "OnUser1 paint_trickle_blue_1:FireUser1::0.2:-1")
      EntFire("paint_trickle_blue_1", "AddOutput", "OnUser1 paint_trickle_blue_1:Stop::0:-1")
      EntFire("paint_trickle_blue_1", "AddOutput", "OnUser1 paint_trickle_blue_1:Start::0.1:-1")
      EntFire("paint_trickle_blue_1", "FireUser1", 0, 0.5)

      //make vault doors opened
      EntFire("lightsout", "Kill")
      EntFire("lightsout_spotlights", "Kill")
      EntFire("lightsout_sound", "Kill")
      EntFire("vault_door_sound_open", "Kill")
      EntFire("big_door_open_relay", "Trigger")
      EntFire("departure_elevator-logic_source_elevator_door_open", "Enable", 0, 2.9)
      EntFire("departure_elevator-logic_source_elevator_door_open", "Trigger", 0, 3)
      EntFire("departure_elevator-source_elevator_door_open_trigger", "Kill", 0, 0)
      EntFire("pumproom_lift_tracktrain", "SetMaxSpeed", 250)

      //hopefully that fixes the shake thingy someone had
      //bruh like there are no reason for shaking to exist in this map anyway lol
      EntFire("env_shake", "Kill")

      EntFire("big_door_button", "Kill") //lmao
      break
    case "sp_a4_intro":

      EntFire("button_1_solved", "Kill")
      /* EntFire("wheatley_monitor1-coverpanel_bottom", "Close",0,1)
      EntFire("wheatley_monitor1-coverpanel_top", "Close",0,1)
      for(local i=1;i<=4;i++){
        EntFire("wheatley_monitor"+i+"-monitor_arm", "Kill")
      } */
      EntFire("catwalk_lift_door", "SetSpeed", 100)
      EntFire("catwalk_gate2_door_left", "SetSpeed", 300)
      EntFire("catwalk_gate2_door_right", "SetSpeed", 300)
      EntFire("entrance_door_counter", "Add", 1)
      EntFire("entrance_door_counter", "AddOutput", "OnHitMax @entrance_door1-door_open_relay:Trigger::0:1")
      EntFire("test_chamber1_platform", "SetMaxSpeed", 400)
      
      
      /* EntFire("wheatley_monitor5-monitor_glass", "Enable")
      EntFire("wheatley_monitor5-relay_disable_screen", "Trigger") */
      EntFire("test1_end_trigger", "AddOutput", "OnTrigger room2_wall_open:Trigger::0:1")
      EntFire("test2_end_trigger", "AddOutput", "OnTrigger @exit_door-door_open_relay:Trigger::0:1")
      break
    case "sp_a4_tb_wall_button":
      EntFire("wheatley_monitor-proxy", "Kill")
      EntFire("move_wall", "SetSpeed", 10000)
      EntFire("move_wall", "Open")
      EntFire("relay_chamber_rampup", "Kill")
      EntFire("relay_pre_chamber_move", "Kill")
      EntFire("sound_lights_on", "Kill")
      for(local i=1;i<=12;i++){
        EntFire("wallPanel_"+i, "Kill")
      }
      EntFire("tractorbeam_emitter", "Enable")
      EntFire("diag_tb_wall_button_start_yet", "AddOutput", "OnTrigger music_post_destruction:PlaySound::0:1")
      EntFire("shake_chamber_end", "Kill")
      break
    case "sp_a4_stop_the_box":
      EntFire("wheatley_monitor-proxy", "Kill")
      break
    case "sp_a4_laser_catapult":
      EntFire("wheatley_monitor_1-proxy", "Kill")
      break
    case "sp_a4_laser_platform":
      //make platform annoyingly fast YOURE WELCOME BAILEY
      local speed = 175;
      EntFire("laser_02_train", "SetMaxSpeed", speed)
      EntFire("laser_02_train_start_logic", "AddOutput", "OnTrigger laser_02_train:SetSpeedReal:"+speed+":0.01:-1");

      //make funnel faster
      EntFire("tbeam", "SetLinearForce", 1400.0)

      EntFire("wheatley_monitor_1-proxy", "Kill")

      //open panels faster
      EntFire("open_tb_catch_relay", "Trigger")
      EntFire("open_tb_catch_relay", "Kill", 0, 5)
      break
    case "sp_a4_speed_tb_catch":
      //EntFire("wheatley_monitor-proxy", "Kill")
      EntFire("departure_elevator-source_elevator_door_open_trigger", "kill")   //No Elevator repeat
      EntFire("shake_chamber", "Kill")
      EntFire("chamber_exit", "SetSpeed", 10000) //RAMMING SPEED
      EntFire("chamber_exit", "Open")
      EntFire("breakpanel_left_1", "Kill")
      EntFire("breakpanel_right_1", "Kill")
      EntFire("breakpanel3", "Kill")
      EntFire("breakpanel4", "Kill")
      EntFire("exit_door-door_open_relay", "Trigger")
      EntFire("start_ramp", "Trigger", 0, 1)

      EntFire("tb_catch_inner_door", "Open")

      EntFire("start_chamber_destruction", "Kill")

      //fix dialogue -4448_01
      EntFire("@glados", "RunScriptCode", "delete SceneTable[SceneTable[SceneTableLookup[-4448]].next].next")
      break
    case "sp_a4_jump_polarity":
      local trigger = Entities.FindByClassnameNearest("trigger_once", Vector(2336, -64, 192), 10)
      EntFireByHandle(trigger, "Kill", "0", 0, null, null)

      //stuff made by bets and blender - deleting door and make a new non-solid one
      local door = GetEntity("exit_door_to_elevator")
      local enddoortrigger = Entities.FindByClassnameNearest("trigger_once", Vector(2560.01, -4016, 432), 100)
      local ang = door.GetAngles()
      local pos = door.GetOrigin()
      EntFireByHandle(door, "Kill", "", 0, null, null)
      local d = Entities.CreateByClassname("prop_dynamic");
      d.SetModel("models/props/portal_door_combined.mdl")
      d.SetOrigin(pos)
      EntFireByHandle(d, "SetAnimation", "close", 0, null, null)
      EntFireByHandle(d, "AddOutput", "targetname d_fix", 0, null, null)
      EntFireByHandle(d, "AddOutput", "solid 0", 0, null, null)
      d.SetAngles(ang.x, ang.y, ang.z)
      EntFireByHandle(enddoortrigger, "AddOutput" "OnStartTouch d_fix:SetAnimation:Open", 0, null, null)
      
      EntFire("antechamber-paint_meSilly", "Start")
      EntFire("antechamber-paint_meSilly", "Stop", 0, 3)
      EntFire("antechamber_exit", "SetAnimation", "Open")
      break
    case "sp_a4_finale1":
      EntFire("final_door-open_door", "Trigger")
      EntFire("final_door-open_door", "Kill", 0, 0.1)

      EntFire("tbeam_crusher_delivery", "SetLinearForce", 1400.0)
      EntFire("paint_bomb_maker", "ForceSpawn", 0, 0.5)
      EntFire("paint_bomb_maker", "ForceSpawn", 0, 1.5)

      EntFire("areaportal_airlock_1", "Open")
      EntFire("liftshaft_airlock_exit-proxy", "Kill")
      EntFire("liftshaft_airlock_exit-open_door", "Trigger")
      //EntFire("backstop", "SetLocalOrigin", "-8952 -2008 -296")
      //EntFire("backstop", "Toggle", "", 0.1)
      //EntFire("backstop", "Toggle", "", 1.1)
      EntFire("backstop", "Kill")
      EntFire("relay_anvil", "AddOutput", "OnTrigger "+self.GetName()+":RunScriptCode:Finale1VeloBlock():0:1")


      local dialogueCode = 
      "SceneTable[SceneTable[SceneTableLookup[-4801]].next].next = "+
      "SceneTable[SceneTable[SceneTable[SceneTable[SceneTable[SceneTable[SceneTableLookup[-4801]].next].next].next].next].next].next\n"+
      "SceneTable[SceneTable[SceneTableLookup[-4801]].next].postdelay = 0.5"
      EntFire("@glados", "RunScriptCode", dialogueCode, 1)
      EntFire("@glados", "RunScriptCode", "nuke()", 8.5)
      break
    case "sp_a4_finale2":
      EntFire("relay_world_shudder", "Kill")
      EntFire("env_shake", "Kill")
      EntFire("shake_pipe_fall", "Kill")
      EntFire("sound_pipe_fall", "Kill")


      local trigger = Entities.FindByClassnameNearest("trigger_once", Vector(3194.35, 704, -146.12), 100)
      EntFireByHandle(trigger, "Kill", "0", 0, null, null)

      EntFire("a4_chamber_fx_a_1", "SetAnimation", "grind1")
      EntFire("a4_chamber_fx_a_1", "SetPlaybackRate", 10)
      EntFire("a4_chamber_fx_b_1", "SetAnimation", "grind1")
      EntFire("a4_chamber_fx_b_1", "SetPlaybackRate", 10)
      EntFire("a4_chamberArms_fx_a_1", "SetAnimation", "grind1")
      EntFire("a4_chamberArms_fx_a_1", "SetPlaybackRate", 10)
      EntFire("a4_armsWall_fx_A_1", "SetAnimation", "grind1")
      EntFire("a4_armsWall_fx_A_1", "SetPlaybackRate", 10)
      EntFire("walkway_breakpoint", "Wake", 0, 0.5)
      EntFire("ovelinear_chamber", "Open")
      EntFire("shake_chamber_move", "StartShake")
      EntFire("catwalk_snap_sfx", "PlaySound", 0, 0)
      EntFire("relay_chamber_stopped", "Trigger")

      EntFire("areaportal_airlock_1", "Open")
      EntFire("bts_door_1-open_door", "Trigger")
      EntFire("bts_door_1-open_door", "Kill", 0, 1)

      EntFire("areaportal_bts_door_2", "Open", 0, 0)
      EntFire("bts_door_2-open_door", "Trigger", 0)
      EntFire("bts_door_2-proxy", "Kill", 0, 0.1)

      local trigger2 = Entities.FindByClassnameNearest("trigger_once", Vector(-878.3, -1216.03, -448), 100)
      EntFireByHandle(trigger2, "SetLocalOrigin","3778.25 703.97 -96", 0, null, null)
      EntFireByHandle(trigger2, "AddOutput", "OnTrigger areaportal_bts_door_2:Open::3:1", 0, null, null)

      //TODO: sometimes these doors are not opening, so I increased wait time from 0.1 to 0.2, if that doesn't work: maually call faster animation
      FasterVertDoor("entrance_door", 0.1)
      //i cant even
      for(local i = 0;i<1;i+=0.2){
        EntFire("entrance_door-door_1", "SetAnimation", "vert_door_open_idle", i)
      }

      EntFire("exit_door-open_door", "Trigger")
      //EntFire("exit_door-open_door", "Kill",0,0.1)
      //fuck that idk the previous line didnt work
      local trigger2 = Entities.FindByClassnameNearest("trigger_once", Vector(-3145,-1301.94,-266), 100)
      EntFireByHandle(trigger2, "Kill","", 0, null, null)

      //open ambush doors
      EntFire("relay_turret_ambush", "AddOutput", "OnTrigger relay_open_door:Trigger::0:1")
      EntFire("relay_close_door", "Kill")

      //prevent catwalk thingy
      EntFire("walkway_push", "Kill")
      EntFire("relay_walkway_fall", "Kill")
      break
    case "sp_a4_finale3":
      FixCelesteModeWindow(Vector(-192, -2253, 256), Vector(0,90,180));

      EntFire("practice_bomb_timer", "disable")
      EntFire("bomb_divert_screw_rotator", "Start")
      EntFire("bomb_divert_vertical_door", "Open")
      EntFire("bomb_divert_big_rotate", "Open")
      EntFire("bomb_divert_bomb_timer", "Enable")
      EntFire("bomb_track_1_tube_sprite", "Color 255 9 9")
      EntFire("autoinstance1-button", "AddOutput", "OnPressed practice_bomb_timer:enable::0.1:1")
      EntFire("autoinstance1-button", "AddOutput", "OnPressed bomb_track_1_2:EnableAlternatePath::0:1")
      EntFire("autoinstance1-button", "AddOutput", "OnPressed bomb_track_1_2:EnableAlternatePath::0:1")
      EntFire("tractorbeam_emitter", "SetLinearForce", 1000.0)

      FasterVertDoor("door_lair")
      FasterVertDoor("entry_door", 0.3)
      //cant use my function because weird naming and entities and generally fuck you valve
      EntFire("start_speed_particles", "AddOutput", "OnTrigger airlock_door2:SetAnimation:vert_door_open_idle:0.1:-1")

      break
    case "sp_a4_finale4":
      //ele and hole opening faster
      local ent  = GetEntity("potatos_socket_insertion_relay")
      EntFireByHandle(ent, "AddOutput", "OnTrigger breakers_up:Trigger::0:1", 0, null, null)
      EntFireByHandle(ent, "AddOutput", "OnTrigger basement_breakers_platform:SetSpeed:1:0.1:1", 0, null, null)
      EntFireByHandle(ent, "AddOutput", "OnTrigger breaker_hatch_door:Open::3:1", 0, null, null)
      EntFireByHandle(ent, "AddOutput", "OnTrigger hatch_clip:Disable::3:1", 0, null, null)

      //dont open the hole twice
      EntFire("breakers_up", "Kill")


      EntFire("breaker_path2", "AddOutput", "OnPass wheatley_bomb_relay:trigger::0:1")

      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger paint_white_event_relay:Kill::0:1")

      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger wheatley_futbol_timer:Disable::0.1:1", 0.1)
      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger wheatley_futbol_relay:CancelPending::0.1:1", 0.1)
      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger paint_pipe_white_model:SetAnimation:pipe_explode_anim:0.1:1", 0.1)
      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger paint_pipe_white_intact_model:Disable::0.1:1", 0.1)
      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger wheatley_futbol_end_relay:CancelPending::0.1:1", 0.1)
      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger paint_pipe_white_model:Enable::0.1:1", 0.2)
      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger paint_pipe_white_intact_model:DisableCollision::0.1:1", 0.2)
      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger futbol_shoot_relay:CancelPending::0.1:1", 0.2)
      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger paint_white_sprayer_relay:Trigger::0.1:1", 0.2)
      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger wheatley_pipe_relay:Disable::0.1:1", 0.2)
      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger core_hit_trigger:Enable::0.1:1", 0.2)
      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger shake_white_paint_pipe_break:StartShake::0.1:1", 0.3)
      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger paint_pipe_white_sound:PlaySound::0.1:1", 0.3)
      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger light_dynamic_wheatley:TurnOff::0.1:1", 0.3)
      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger sound_paint_spray:PlaySound::0.1:1", 0.3)
      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger relay_paint_smear:Trigger::0.1:1", 0.3)
      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger wheatley_shadow_brush:Kill::0.1:1", 0.4)
      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger wheatley_shield:SetAnimation:anim10_liftAnim:1.1:1", 0.4)
      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger paint_white_panels_relay:trigger::1.6:1", 0.4)
      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger wheatley_lookat_player_relay:trigger::2.1:1", 0.4)
      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger shake_white_paint_pipe_break:StartShake::2.1:1", 0.4)
      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger sound_paint_spray:Volume:0:5.1:1", 0.4)
      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger sound_paint_spray:StopSound::5.1:1", 0.5)
      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger wheatley_shield:SetAnimation:anim11_lowerAnim:0.1:1", 0.5)
      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger wheatley_futbol_relay:trigger::2.6:1", 0.5)
      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger wheatley_futbol_timer:enable::2.6:1", 0.5)
      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger autosave0_relay:trigger::2.6:1", 0.5)
      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger background_fire3:start::2.6:1", 0.6)
      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger background_fire3_sound:playsound::2.6:1", 0.6)

      EntFire("paint_portal_trigger", "AddOutput", "OnTrigger @glados:RunScriptCode:GladosPlayVcd(593):0:1")
      //ent_fire wheatley_continue_1 trigger; ent_fire wheatley_futbol_guard_relay2 trigger

      //socket3_trigger/relay
      //wheatley_continue_3
      //wheatley_attack_path1

      //fire_relay
      //sprinkler_relay
      //sprinkler_relay_erase
      //stalemate_relay
      //stalemate_door

      EntFire("socket1_relay", "AddOutput", "OnTrigger wheatley_continue_1:Trigger::2:1")
      EntFire("socket1_relay", "AddOutput", "OnTrigger wheatley_futbol_guard_relay2:Trigger::4:1")

      EntFire("socket2_relay", "AddOutput", "OnTrigger wheatley_continue_2:Trigger::2:1")
      EntFire("socket2_relay", "AddOutput", "OnTrigger wheatley_futbol_guard_relay3:Trigger::4:1")

      EntFire("socket3_relay", "AddOutput", "OnTrigger fire_relay:Trigger::2:1")
      EntFire("socket3_relay", "AddOutput", "OnTrigger sprinkler_relay:Trigger::4:1")
      EntFire("socket3_relay", "AddOutput", "OnTrigger stalemate_relay:Trigger::10:1")
      EntFire("socket2_relay", "AddOutput", "OnTrigger @glados:RunScriptCode:sp_a4_finale4_set_thorn():5:1")

      //making rocks/debree/whatever this fucking is appear earlier
      EntFire("socket3_relay", "AddOutput", "OnTrigger wedge18-panel_bottom_model:Enable::0:1")
      EntFire("socket3_relay", "AddOutput", "OnTrigger wedge18-panel_bottom_model:SetAnimation:anim18:0:1")
      EntFire("socket3_relay", "AddOutput", "OnTrigger wedge18-panel_bottom:Kill::0:1")
      EntFire("socket3_relay", "AddOutput", "OnTrigger wedge18-panel_bottom_relay:Kill::0:1")

      //make core delivery faster
      EntFire("socket1_start_relay", "AddOutput", "OnTrigger claw_movelinear:SetSpeed:200:0:1", 2)
      EntFire("claw_movelinear", "AddOutput", "OnFullyOpen claw_drop_movelinear:SetSpeed:200:0:1", 2)
      EntFire("socket1_start_relay", "AddOutput", "OnTrigger @glados:RunScriptCode:GladosDeliverCore1();delete GladosDeliverCore1:0:1", 2)
      EntFire("sway_sfx_02", "Kill")

      EntFire("socket2_start_relay", "AddOutput", "OnTrigger core2_movelinear:Open::1.2:1", 2.1)
      EntFire("socket2_start_relay", "AddOutput", "OnTrigger core2_movelinear:SetSpeed:200:1.2:1", 2.1)
      EntFire("socket2_start_relay", "AddOutput", "OnTrigger @glados:RunScriptCode:GladosDeliverCore2();delete GladosDeliverCore2:1.2:1", 2.1)
      EntFire("socket2_start_relay", "AddOutput", "OnTrigger claw2:SetAnimation:swing:1.2:1", 2.1)
      EntFire("socket2_start_relay", "AddOutput", "OnTrigger @core02:SetIdleSequence:core02_pincher_idle:1.2:1", 2.1)
      EntFire("socket2_start_relay", "AddOutput", "OnTrigger core2_sprite:ShowSprite::1.3:1", 2.1)
      EntFire("socket2_start_relay", "AddOutput", "OnTrigger core2_break_sound:PlaySound::2.2:1", 2.1)
      EntFire("socket2_start_relay", "AddOutput", "OnTrigger core2_break_sound:PlaySound::2.2:1", 2.1)
      EntFire("socket2_start_relay", "AddOutput", "OnTrigger wedge2-proxy:OnProxyRelay2::2.2:1", 2.1)
      EntFire("socket2_start_relay", "AddOutput", "OnTrigger core2_start_relay:CancelPending::2.2:1", 2.1)

      EntFire("socket3_start_relay", "AddOutput", "OnTrigger claw3_movelinear:SetSpeed:200:2:1", 2.2)
      EntFire("socket3_start_relay", "AddOutput", "OnTrigger claw3_movelinear:Open::2:1", 2.2)
      EntFire("wedge11-panel_bottom_model", "Kill", 0, 2.2)
      EntFire("wedge11-panel_bottom", "Kill", 0, 2.2)

      //fix some dialogue
      local dialogFixCode = 
      "delete SceneTable[SceneTableLookup[633]].next\n" +
      "delete SceneTable[SceneTableLookup[634]].next\n" +
      "delete SceneTable[SceneTableLookup[593]].next\n" +
      "SceneTableLookup[599] = SceneTableLookup[600]\n" +
      "delete SceneTable[SceneTableLookup[600]].next\n" +
      "delete SceneTable[SceneTableLookup[597]].next\n" +
      "delete SceneTable[SceneTableLookup[598]].next\n" +
      "SceneTableLookup[-7400] = SceneTable[SceneTableLookup[-7400]].next\n" +
      "SceneTable[SceneTableLookup[-7400]].next = " + //jesus fucking christus
      "SceneTable[SceneTable[SceneTable[SceneTable[SceneTable[SceneTable[SceneTable[SceneTable[SceneTable[SceneTable[SceneTable[SceneTable[SceneTable[SceneTable[SceneTableLookup[-7400]].next].next].next].next].next].next].next].next].next].next].next].next].next].next"
      
      EntFire("@glados", "RunScriptCode", dialogFixCode)

      //better ending
      EntFire("ending_relay", "AddOutput", "OnTrigger stalemate_ending_relay:CancelPending::0:1")
      EntFire("moon_portal_detector", "AddOutput", "OnStartTouchPortal ceiling_relay:Kill::1:1")
      EntFire("ending_relay", "AddOutput", "OnTrigger ending_wheatley_model:SetAnimation:Ending_Wheatley_Part01:1:1")
      EntFire("ending_relay", "AddOutput", "OnTrigger ending_chassis_model:SetAnimation:Ending_GWheatley_SuckedOut:1:1")
      EntFire("ending_relay", "AddOutput", "OnTrigger ending_cable1_model:SetAnimation:Ending_shot1_cables:1:1")
      EntFire("ending_suction_relay", "AddOutput", "OnTrigger ending_relay:CancelPending::11:1")

      EntFire("stalemate_ending_relay", "AddOutput", "OnTrigger ceiling_relay:Trigger::4.5:1")
      EntFire("ceiling_relay", "AddOutput", "OnTrigger ending_vehicle:SetAnimation:Ending_Shoot_idle:3:1")
      EntFire("ceiling_relay", "AddOutput", "OnTrigger vehicle_shoot_relay:Trigger::3.5:1")
      EntFire("ceiling_relay", "AddOutput", "OnTrigger ending_vehicle:UseAttachmentEyes::3.5:1")
      EntFire("ceiling_relay", "AddOutput", "OnTrigger stalemate_ending_relay:CancelPending::4:1")

      EntFire("ending_relay", "AddOutput", "OnTrigger "+self.GetName()+":RunScriptCode:Finale4Anim(1):6.5:1")
      EntFire("ending_suction_relay", "AddOutput", "OnTrigger replace_fade:Fade::11:1")
      EntFire("ending_suction_relay", "AddOutput", "OnTrigger @command:Command:changelevel credits:16:1")
      break
  }

  //don't let the wheatley screen appear
  //EntFire("monitor1-proxy", "Kill")
  //EntFire("monitor2-proxy", "Kill")
  
  //activate departure ele faster
  //EntFire("departure_elevator-blocked_elevator_tube_anim", "AddOutput", "OnTrigger departure_elevator-elevator_arrive:Trigger::0:1", 0)
  //EntFire("departure_elevator-blocked_elevator_tube_anim", "AddOutput", "OnTrigger departure_elevator-elevator_arrive:Disable::1:1", 0)
  EntFire("departure_elevator-elevator_arrive", "Trigger", 0, 4)
  EntFire("departure_elevator-elevator_arrive", "Disable", 0, 8)
  EntFire("departure_elevator-logic_source_elevator_door_open", "Trigger", 0, 4)
  EntFire("departure_elevator-logic_source_elevator_door_open", "Disable", 0, 8)
  //kills all stuff falling through ele tube
  EntFire("departure_elevator-vac*", "Kill")
  //EntFire("departure_elevator-elevator_1_player_telepor", "Kill")
  ::TransitionFired <- 1

  //activate fast arrival
  EntFire("arrival_elevator-elevator_1", "SetMaxSpeed", 400)
  EntFire("arrival_elevator-elevator_1", "SetSpeed", 400)
  //EntFire("arrival_elevator-source_elevator_door_open_trigger", "AddOutput", "OnTrigger arrival_elevator-open:Trigger::0:1")
  //EntFire("arrival_elevator-source_elevator_door_open_trigger", "AddOutput", "OnTrigger arrival_elevator-open:Disable::0.1:1")
  EntFire("arrival_elevator-elevator_1", "AddOutput", "OnArrivedAtDestinationNode arrival_elevator-open:Trigger::0:1")
  EntFire("arrival_elevator-elevator_1", "AddOutput", "OnArrivedAtDestinationNode arrival_elevator-open:Disable::0.1:1")

  //open EVERY FUCKING door much faster
  EntFire("arrival_elevator-leaving_elevator_trigger", "AddOutput", "OnTrigger door_0-door_open_relay:Trigger::0:1")
  EntFire("arrival_elevator-leaving_elevator_trigger", "AddOutput", "OnTrigger @entry_door-door_open_relay:Trigger::0:1")
  EntFire("arrival_elevator-leaving_elevator_trigger", "AddOutput", "OnTrigger room_1_entry_door-door_open_relay:Trigger::0:1")
  //activate fast departure for "modern" elevators
  
  //AddOutput("departure_elevator-close", "OnTrigger", "FastTransition") //potential reason for laser over goo crash?
  EntFire("departure_elevator-close", "AddOutput", "OnTrigger departure_elevator-close:RunScriptCode:FastTransition():0:1");
  EntFire("departure_elevator-close", "AddOutput", "OnTrigger departure_elevator-signs_off:Disable::0.6:1")

  EntFire("departure_elevator-close", "AddOutput", "OnTrigger departure_elevator-signs_off:Trigger::0.5:1")
  EntFire("departure_elevator-close", "AddOutput", "OnTrigger departure_elevator-signs_off:Disable::0.6:1")
  EntFire("departure_elevator-close", "AddOutput", "OnTrigger departure_elevator-elevator_1:RunScriptCode:StartMoving():0.5:1")
  EntFire("departure_elevator-close", "AddOutput", "OnTrigger departure_elevator-floor_clip:Disable::0.5:1")
  
  //kill glados (metal bitch aint tell me what to do)

  // if(disableDialogue && blockAnnouncerDelay>=0){
  //   EntFire("@glados", "Kill", 0.0, blockAnnouncerDelay)
  //   EntFire("@cave", "Kill", 0.0, blockAnnouncerDelay)
  //   modlog("Dialogue deleted")
  // }

  //fog lol
  FogControl()
  //make sure fog works
  EntFire("p2mm_servercommand", "command", "p2mm_script FogControl()", 0.1)

  //remove all unwanted dialogues
  local sceneremoval = "";
  foreach(i,v in DIALOGUES){
    sceneremoval += "delete SceneTableLookup["+v+"]\n"
  }
  EntFire("@glados", "RunScriptCode", sceneremoval)

  //EntFire("@sphere", "AddOutput", "modelscale 2")
}


function SpeedrunModeUpdate(){
  if(LVT_BUTTON_ENABLED){
    FastFakeExplosionsInLvT();
  }
}



//nice function for handling all elevator events in underground section
function FastUndergroundTransition(idin, idout){
  if(idout){
    local elename = "InstanceAuto"+idout+"-exit_lift_doortop_movelinear"
    local elename2 = "InstanceAuto"+idout+"-exit_lift_train"
    local elename3 = "InstanceAuto"+idout+"-exit_lift_doorbottom_movelinear"
    if(idout<0){
      elename = "exit_lift_doortop_movelinear"
      elename2 = "exit_lift_train"
      elename3 = "exit_lift_doorbottom_movelinear"
    }
    EntFire(elename, "AddOutput", "OnFullyClosed "+elename2+":StartForward::0:1")
    EntFire(elename, "AddOutput", "OnFullyClosed @transition_script:RunScriptCode:TransitionReady():0:1")
    EntFire(elename, "AddOutput", "OnFullyClosed @transition_script:RunScriptCode:modlog(\"Fast transition will be executed in 1 second...\"):0:1")
    EntFire(elename, "AddOutput", "OnFullyClosed @transition_from_map:Trigger::1:1")
    EntFire(elename, "AddOutput", "OnFullyClosed @transition_with_survey:Trigger::1:1")
    EntFire(elename2, "SetMaxSpeed", 200)

    //make end eles already opened
    EntFire(elename, "Open")
    EntFire(elename3, "Open")
  }
  if(idin){
    local elename = "InstanceAuto"+idin+"-entrance_lift_train"
    local elename2 = "InstanceAuto"+idin+"-entrance_lift_train_path_2"
    if(idin<0){
      elename = "entrance_lift_train"
      elename2 = "entrance_lift_train_path_2"
    }
    EntFire(elename, "SetMaxSpeed", 200)
    EntFire(elename, "SetSpeed", 200, 0.1)
    EntFire(elename2, "inpass", 0, 1.1)
  }
  
}

function FasterVertDoor(prefabname, speed=0.1){
  EntFire(prefabname+"-open_door", "AddOutput", "OnTrigger "+prefabname+"-door_1:SetAnimation:vert_door_open_idle:"+speed+":-1")
  EntFire(prefabname+"-open_door", "AddOutput", "OnTrigger "+prefabname+"-door_1:SetAnimation:vert_door_open_idle:"+(speed+0.3)+":-1")//just in case LMFAO
}

function FastTransition(){
  //transition is always ready lol
  ::TransitionReady <- 1
  modlog("Fast transition will be executed in 1.5 seconds...");
  EntFire("@transition_from_map","Trigger","",1.5);
    EntFire("@transition_with_survey","Trigger","",1.5);
}



//LvT faster turret explosion sequence... fuck me

LVT_FAKEEXPLO_DONE <- false;
LVT_BUTTON_ENABLED <- false;
function StartFastFakeExplosionsInLvT(){
  if(!LVT_FAKEEXPLO_DONE){
    //self.ConnectOutput("OnUser1", "FastFakeExplosionsInLvT");
    //EntFire(self.GetName(), "FireUser1")
    LVT_BUTTON_ENABLED = true
    modlog("Testing LvT fast explosion...")
  }
}
function EndFastFakeExplosionsInLvT(){
  //self.DisconnectOutput("OnUser1", "FastFakeExplosionsInLvT");
  LVT_BUTTON_ENABLED = false
}
function FastFakeExplosionsInLvT(){
  if(!LVT_FAKEEXPLO_DONE){
    local portal1 = Entities.FindByClassnameNearest("prop_portal", Vector(288, -320, 280), 20)
    local portal2 = Entities.FindByClassnameNearest("prop_portal", Vector(64, 96, 260), 10)
    //make sure portals are in the correct spot. hopefully placement helpers are good enough so there are no weird cases.
    if(portal1 && portal2){
      //assuming turrets are in correct positions
      local turret1 = Entities.FindByClassnameNearest("npc_portal_turret_floor", Vector(288,-48,288), 50)
      local turret2 = Entities.FindByClassnameNearest("npc_portal_turret_floor", Vector(288, 80,288), 50)
      local turret3 = Entities.FindByClassnameNearest("npc_portal_turret_floor", Vector(288,208,288), 50)
      if(turret1)EntFireByHandle(turret1, "SelfDestructImmediately", "", 0.7, null, null)
      else if(turret2)EntFireByHandle(turret2, "SelfDestructImmediately", "", 0.7, null, null)
      else if(turret3)EntFireByHandle(turret3, "SelfDestructImmediately", "", 0.7, null, null)
      else LVT_FAKEEXPLO_DONE = true;
      //EntFire(self.getName(), "RunScriptCode", "FastFakeExplosionsInLvT()", 0.7)
    }
    EntFire(self.GetName(), "FireUser1", 0, 0.1)
  }else{
    LVT_BUTTON_ENABLED = false
  }
}

function Finale1VeloBlock(){
  local p = GetPlayer().GetVelocity()
  GetPlayer().SetVelocity(Vector(-300,p.y,p.z))
}

function IntroRadioPlay(){
  local radio = GetEntity("radio");
  radio.EmitSound("music.itsaspeedrun");
  EntFire("@music_chamberexit", "StopSound")
  EntFire("@music_chamberexit", "StopSound", "", 2);
}

function Finale4Anim(frame){
  local v = GetEntity("ending_vehicle")
  local vpos = v.GetOrigin()
  
  vpos.z -= 5*1/((frame+50)/50.0)
  vpos.y += frame*0.05
  v.SetAbsOrigin(vpos)

  EntFire(self.GetName(), "RunScriptCode", "Finale4Anim("+(frame+1)+")", 0.001)
}


FUCKING_FOG_VALUES <- 
[
  {name="sp_a1_intro1",color1=64,color2=255,start=500.0,end=6000},
  {name="@environment_wheatly_state_02",color1=40,color2=255,start=128,end=1750},
  {name="fog_testchamber",color1=64,color2=18,start=128,end=5000},
  {name="environment_fog_neuro_1",color1=11,color2=255,start=1,end=2500},
  {name="@environment_lake_fog",color1=100,color2=255,start=0,end=10000},
  {name="@environment_wheatley_z_fog",color1=0,color2=255,start=10000,end=11000},
  {name="fog_factory",color1=22,color2=255,start=1,end=2000},
  {name="@environment_darkness_fog",color1=22,color2=255,start=1,end=2500},
  {name="@environment_destroyed_b_fog",color1=80,color2=255,start=128,end=5000},
  {name="@environment_act4_fog_01",color1=80,color2=255,start=128,end=2500},
  {name="@environment_fan_fog",color1=22,color2=255,start=128,end=3600},
  {name="@environment_glados_intro_fog",color1=63,color2=255,start=0,end=3500},
  {name="@environment_destroyed_fog",color1=80,color2=255,start=128,end=2500},
  {name="@environment_tuberide_fog",color1=170,color2=150,start=128,end=5500},
  {name="@environment_jailbreak_fog",color1=160,color2=255,start=128,end=4000},
  {name="pumproom_fog",color1=100,color2=255,start=700,end=10000},
  {name="fog_intro_ride",color1=120,color2=255,start=500,end=8000},
  {name="@environment_underground_fog",color1=37,color2=255,start=0,end=4500},
  {name="@environment_wheatley_tbeam_fog",color1=71,color2=255,start=128,end=5000},
  {name="@environment_darkness_1_fog",color1=11,color2=255,start=1,end=2500},
  {name="@environment_darkness_fog_2",color1=11,color2=255,start=1,end=2500},
  {name="fog_destroyed_chambers",color1=80,color2=255,start=0,end=2500},
  {name="environment_fog_neuro_2",color1=22,color2=255,start=1,end=2500},
  {name="@environment_act4_fog_02",color1=80,color2=255,start=128,end=3500},
  {name="@environment_bottomless_pit_falling_fog",color1=8,color2=50,start=0,end=3000},
  {name="environment_vista_fog",color1=25,color2=255,start=-500,end=1700},
  {name="@environment_bottomless_pit_fog",color1=100,color2=255,start=0,end=6000},
  {name="@environment_darkness_fog_3",color1=0,color2=255,start=1,end=2500},
  {name="fog_bts",color1=64,color2=18,start=1,end=5000},
  {name="@environment_act4_fog_03",color1=80,color2=255,start=64,end=6000},
  {name="@environment_red_state",color1=35,color2=255,start=128,end=2500},
  {name="@environment_darkness_fog_4",color1=0,color2=255,start=1,end=1000},
  {name="@environment_darkness_fog_5",color1=0,color2=255,start=1,end=768},
  {name="@environment_moonshot_1",color1=22,color2=255,start=10000,end=11000},
  {name="environment_fog_neuro_3",color1=35,color2=255,start=1,end=2500},
  {name="fog_controller",color1=100,color2=255,start=500,end=5000},
  {name="@environment_mines_fog",color1=100,color2=255,start=0,end=6000},
  {name="@environment_bts_fog",color1=141,color2=152,start=1,end=5000},
  {name="@environment_lake_b_fog",color1=100,color2=255,start=0,end=4500},
  {name="@environment_glados",color1=88,color2=255,start=128,end=1750},
  {name="@environment_wheatly_state_01",color1=203,color2=255,start=128,end=1750},
  {name="@environment_testchamber_fog",color1=64,color2=255,start=128,end=5000},
  {name="sp_a2_bts3",color1=100,color2=100,start=0,end=1000}
]

FOG_CONTROL_VALUES <- {r=0.4, g=0.8, b=1.3};

function FogControl(){
  //EntFire("env_fog_controller", "SetColorSecondary", "0 20 40")
  //EntFire("env_fog_controller", "SetColor", "30 60 90")
  //EntFire("env_fog_controller", "SetStartDist", "-50")

  foreach (i, fog in FUCKING_FOG_VALUES){
    local b = floor(fog.color1*FOG_CONTROL_VALUES.b);
    local g = floor(fog.color1*FOG_CONTROL_VALUES.g);
    local r = floor(fog.color1*FOG_CONTROL_VALUES.r);

    if(GetMapName()==fog.name){
      EntFire("env_fog_controller", "SetColor", r+" "+g+" "+b);
    }else{
      EntFire(fog.name, "SetColor", r+" "+g+" "+b);
    }
    
  }

}




AddModeFunctions("default", SpeedrunModePostSpawn, SpeedrunModeLoad, SpeedrunModeUpdate, SpeedrunModePrecache)
