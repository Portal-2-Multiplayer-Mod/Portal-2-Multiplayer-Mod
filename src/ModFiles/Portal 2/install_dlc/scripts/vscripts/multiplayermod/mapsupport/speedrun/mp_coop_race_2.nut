try { IncludeScript("multiplayermod/mapsupport/standard/" + GetMapName()) } catch (exception) {}

// Speed up checkpoint airlock
EntFire("entry_airlock-coopman_airlock_success", "AddOutput", "OnChangeToAllTrue entry_airlock-airlock_exit_door_open_rl:Trigger::0.3")
EntFire("entry_airlock-airlock_exit_door_open_rl", "AddOutput", "OnTrigger entry_airlock-airlock_exit_door_open_rl:Disable")

// Speed up ending transition
Entities.FindByName(null, "rl_start_exit").Destroy()
Entities.CreateByClassname("logic_relay").__KeyValueFromString("targetname", "rl_start_exit")
EntFire("rl_start_exit", "AddOutput", "OnTrigger fade_out:Fade::0")
EntFire("rl_start_exit", "AddOutput", "OnTrigger template_movie_level_transition:ForceSpawn::0.5")
EntFire("rl_start_exit", "AddOutput", "OnTrigger transition_script:RunScriptCode:TransitionFromMap():1.25")