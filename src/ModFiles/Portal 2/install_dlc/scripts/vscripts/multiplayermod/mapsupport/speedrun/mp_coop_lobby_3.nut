try { IncludeScript("multiplayermod/mapsupport/standard/" + GetMapName()) } catch (exception) {}

// Speed up course 1 map transition
Entities.CreateByClassname("logic_coop_manager").__KeyValueFromString("targetname", "track1-coopman_exit_level")
EntFire("track1-coopman_exit_level", "AddOutput", "OnChangeToAllTrue track1-template_movie_level_transition:ForceSpawn::0.5")
EntFire("track1-coopman_exit_level", "AddOutput", "OnChangeToAllTrue track1-gladosendoflevelrelay:Trigger::1")
EntFire("track1-rl_start_exit", "Disable")