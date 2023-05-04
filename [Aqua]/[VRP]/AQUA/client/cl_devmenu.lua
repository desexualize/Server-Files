RMenu.Add('DEVMENU', 'main', RageUI.CreateMenu("","Developer Menu",1300,100, "banners", "adminmenu"))
RMenu.Add('DEVMENU','cheatos',RageUI.CreateSubMenu(RMenu:Get('DEVMENU','main'),"","Dev Menu",1300,100))
RMenu.Add('DEVMENU','NativeSounds',RageUI.CreateSubMenu(RMenu:Get('DEVMENU','main'),"","CarDev Menu",1300,100))
RMenu.Add('DEVMENU','vehiclemenu',RageUI.CreateSubMenu(RMenu:Get('DEVMENU','main'),"","CarDev Menu",1300,100))
RMenu.Add('DEVMENU','vehiclelist',RageUI.CreateSubMenu(RMenu:Get('DEVMENU','vehiclemenu'),"","Vehicle List",1300,100))
RMenu.Add('DEVMENU','vehiclelistmain',RageUI.CreateSubMenu(RMenu:Get('DEVMENU','vehiclelist'),"","Vehicle List",1300,100))
RMenu.Add('DEVMENU','vehiclelistspawn',RageUI.CreateSubMenu(RMenu:Get('DEVMENU','vehiclelistmain'),"","Vehicle Spawn",1300,100))
local a = false
local b = false
local C = {}
local g = {
    {"Crash", "DLC_EXEC_ARC_MAC_SOUNDS", true},
    {"Crash_NPC", "DLC_EXEC_ARC_MAC_SOUNDS", true},
    {"Trail_1", "DLC_EXEC_ARC_MAC_SOUNDS", true},
    {"Trail_2", "DLC_EXEC_ARC_MAC_SOUNDS", true},
    {"Trail_3", "DLC_EXEC_ARC_MAC_SOUNDS", true},
    {"Trail_4", "DLC_EXEC_ARC_MAC_SOUNDS", true},
    {"Turn", "DLC_EXEC_ARC_MAC_SOUNDS", true},
    {"Turn_NPC", "DLC_EXEC_ARC_MAC_SOUNDS", true},
    {"Recharging_Loop", "DLC_AW_Machine_Gun_Ammo_Counter_Sounds", true},
    {"CHECKPOINT_MISSED", "HUD_MINI_GAME_SOUNDSET", true},
    {"CHECKPOINT_NORMAL", "HUD_MINI_GAME_SOUNDSET", true},
    {"hangar_doors_loop", "dlc_xm_facility_entry_exit_sounds", true},
    {"Recharging_Loop", "DLC_AW_Machine_Gun_Ammo_Counter_Sounds", true},
    {"Timer_10s", "GTAO_FM_Events_Soundset", false},
    {"10_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", true},
    {"10s", "MP_MISSION_COUNTDOWN_SOUNDSET", false},
    {"1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true},
    {"1st_Place_Gain", "DLC_Stunt_Race_Frontend_Sounds", true},
    {"1st_Place_Lose", "DLC_Stunt_Race_Frontend_Sounds", true},
    {"321", "DLC_EXEC_ARC_MAC_SOUNDS", true},
    {"3_2_1", "HUD_MINI_GAME_SOUNDSET", false},
    {"3_2_1", "HUD_MINI_GAME_SOUNDSET", true},
    {"3_2_1_NON_RACE", "HUD_MINI_GAME_SOUNDSET", true},
    {"5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", true},
    {"5_Second_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", false},
    {"5s", "MP_MISSION_COUNTDOWN_SOUNDSET", false},
    {"5S", "MP_MISSION_COUNTDOWN_SOUNDSET", false},
    {"5s_To_Event_Start_Countdown", "GTAO_FM_Events_Soundset", false},
    {"Accept_Ghosting_Mode", "RESPAWN_ONLINE_SOUNDSET", false},
    {"Activate_Trap", "DLC_AW_Trap_Controller_Sounds", true},
    {"Airhorn", "DLC_BTL_RB_Remix_Sounds", false},
    {"Airhorn", "DLC_TG_Running_Back_Sounds", false},
    {"Apt_Style_Purchase", "DLC_APT_Apartment_SoundSet", false},
    {"ARM_3_CAR_GLASS_CRASH", 0, true},
    {"ARM_3_PISTOL_COCK", 0, true},
    {"ARM_WRESTLING_WHOOSH_MASTER", 0, true},
    {"Armour_Off", "DLC_GR_Steal_Miniguns_Sounds", true},
    {"Armour_On", "DLC_GR_Steal_Miniguns_Sounds", true},
    {"ASSASSINATIONS_HOTEL_TIMER_COUNTDOWN", "ASSASSINATION_MULTI", true},
    {"ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", true},
    {"BACK", "DLC_EXEC_Warehouse_Upgrade_Bench_Sounds", true},
    {"BACK", "HUD_AMMO_SHOP_SOUNDSET", true},
    {"BACK", "HUD_FREEMODE_SOUNDSET", true},
    {"BACK", "HUD_FRONTEND_DEFAULT_SOUNDSET", false},
    {"BACK", "HUD_FRONTEND_DEFAULT_SOUNDSET", true},
    {"Back", "HUD_FRONTEND_DEFAULT_SOUNDSET", true},
    {"BACK", "HUD_FRONTEND_MP_SOUNDSET", true},
    {"Banshee2_Upgrade", "JA16_Super_Mod_Garage_Sounds", true},
    {"Barge_Door", "dlc_h4_Prep_FC_Sounds", true},
    {"Barge_Door_Glass", "dlc_h4_Prep_FC_Sounds", true},
    {"Barge_Door_Metal", "dlc_h4_Prep_FC_Sounds", true},
    {"Barge_Door_Metal_Bars", "dlc_h4_Prep_FC_Sounds", true},
    {"BASE_JUMP_PASSED", "HUD_AWARDS", true},
    {"Beat_Pulse_Default", "GTAO_Dancing_Sounds", false},
    {"Become_Attacker", "DLC_BTL_TP_Remix_Juggernaut_Player_Sounds", false},
    {"Become_Attacker", "DLC_IE_JN_Player_Sounds", false},
    {"Become_Hunted", "dlc_xm_sls_Sounds", true},
    {"Become_JN", "DLC_BTL_TP_Remix_Juggernaut_Player_Sounds", false},
    {"Become_JN", "DLC_IE_JN_Player_Sounds", false},
    {"Become_Slasher", "dlc_xm_sls_Sounds", true},
    {"Become_Target", "dlc_xm_hata_Sounds", false},
    {"Bed", "WastedSounds", true},
    {"Beep_Green", "DLC_HEIST_HACKING_SNAKE_SOUNDS", true},
    {"Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", true},
    {"Blue_Target_Explode", "dlc_xm_silo_laser_hack_sounds", true},
    {"BOATS_PLANES_HELIS_BOOM", "MP_LOBBY_SOUNDS", true},
    {"Bomb_Collect", "DLC_SR_TR_Bomb_Player_Sounds", true},
    {"Bomb_Collected", "DLC_AW_PTB_Sounds", false},
    {"bomb_deployed", "DLC_SM_Bomb_Bay_Bombs_Sounds", true},
    {"Bomb_Disarmed", "GTAO_Speed_Convoy_Soundset", false},
    {"Bomb_Passed", "DLC_AW_PTB_Sounds", false},
    {"bombs_empty", "DLC_SM_Bomb_Bay_Bombs_Sounds", true},
    {"boot_pop", "dlc_vw_body_disposal_sounds", true},
    {"Boss_Message_Orange", "GTAO_Biker_FM_Soundset", false},
    {"Boss_Message_Orange", "GTAO_Boss_Goons_FM_Soundset", false},
    {"Bounds_Timer_Pulse", "DLC_SM_VEHWA_Player_Sounds", false},
    {"Bounds_Timer_Reset", "DLC_SM_VEHWA_Player_Sounds", false},
    {"BULL_SHARK_TESTOSTERONE_END_MASTER", "", false},
    {"BULL_SHARK_TESTOSTERONE_START_MASTER", "", false},
    {"Bunker_Hatch", "GTAO_Script_Doors_Faded_Screen_Sounds", true},
    {"Bus_Schedule_Pickup", "DLC_PRISON_BREAK_HEIST_SOUNDS", false},
    {"Business_Restart", "DLC_Biker_Computer_Sounds", true},
    {"Business_Restart", "DLC_GR_Disruption_Logistics_Sounds", true},
    {"Business_Shutdown", "DLC_Biker_Computer_Sounds", true},
    {"Business_Shutdown", "DLC_GR_Disruption_Logistics_Sounds", true},
    {"BUTTON", "MP_PROPERTIES_ELEVATOR_DOORS", true},
    {"CAM_PAN_DARTS", "HUD_MINI_GAME_SOUNDSET", true},
    {"Camera_Shoot", "Phone_Soundset_Franklin", true},
    {"CANCEL", "DLC_EXEC_Warehouse_Upgrade_Bench_Sounds", true},
    {"Cancel", "GTAO_Exec_SecuroServ_Warehouse_PC_Sounds", true},
    {"CANCEL", "HUD_FREEMODE_SOUNDSET", true},
    {"CANCEL", "HUD_FRONTEND_CLOTHESSHOP_SOUNDSET", true},
    {"CANCEL", "HUD_FRONTEND_DEFAULT_SOUNDSET", false},
    {"CANCEL", "HUD_FRONTEND_DEFAULT_SOUNDSET", true},
    {"CANCEL", "HUD_LIQUOR_STORE_SOUNDSET", true},
    {"cannon_active", "dlc_xm_orbital_cannon_sounds", true},
    {"CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS", true},
    {"car_crushed", "dlc_vw_body_disposal_sounds", true},
    {"chaff_cooldown", "DLC_SM_Countermeasures_Sounds", true},
    {"chaff_empty", "DLC_SM_Countermeasures_Sounds", true},
    {"CHALLENGE_UNLOCKED", "HUD_AWARDS", true},
    {"Checkpoint", "DLC_AW_Frontend_Sounds", bVar0},
    {"Checkpoint", "DLC_Stunt_Race_Frontend_Sounds", bVar0},
    {"Checkpoint", "DLC_sum20_Open_Wheel_Racing_Sounds", bVar0},
    {"CHECKPOINT_AHEAD", "HUD_MINI_GAME_SOUNDSET", bVar0},
    {"Checkpoint_Beast_Hit", "FM_Events_Sasquatch_Sounds", false},
    {"CHECKPOINT_BEHIND", "HUD_MINI_GAME_SOUNDSET", bVar0},
    {"Checkpoint_Buzz", "DLC_AW_Frontend_Sounds", bVar0},
    {"Checkpoint_Cash_Hit", "GTAO_FM_Events_Soundset", false},
    {"Checkpoint_Finish", "DLC_AW_Frontend_Sounds", false},
    {"Checkpoint_Finish", "DLC_Stunt_Race_Frontend_Sounds", false},
    {"Checkpoint_Finish", "DLC_sum20_Open_Wheel_Racing_Sounds", false},
    {"Checkpoint_Hit", "GTAO_FM_Events_Soundset", false},
    {"Checkpoint_Lap", "DLC_AW_Frontend_Sounds", false},
    {"Checkpoint_Lap", "DLC_AW_Frontend_Sounds", true},
    {"Checkpoint_Lap", "DLC_Stunt_Race_Frontend_Sounds", false},
    {"Checkpoint_Lap", "DLC_Stunt_Race_Frontend_Sounds", true},
    {"Checkpoint_Lap", "DLC_sum20_Open_Wheel_Racing_Sounds", false},
    {"CHECKPOINT_MISSED", "HUD_MINI_GAME_SOUNDSET", false},
    {"CHECKPOINT_NORMAL", "HUD_MINI_GAME_SOUNDSET", bVar0},
    {"CHECKPOINT_NORMAL", "HUD_MINI_GAME_SOUNDSET", false},
    {"CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", false},
    {"Checkpoint_Teammate", "GTAO_Shepherd_Sounds", false},
    {"CHECKPOINT_UNDER_THE_BRIDGE", "HUD_MINI_GAME_SOUNDSET", false},
    {"Cheers", "DLC_TG_Running_Back_Sounds", false},
    {"Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", true},
    {"Click_Back", "DLC_Biker_Computer_Sounds", true},
    {"Click_Back", "DLC_H3_Arcade_Laptop_Sounds", true},
    {"Click_Back", "GTAO_SMG_Hangar_Computer_Sounds", true},
    {"CLICK_BACK", "WEB_NAVIGATION_SOUNDS_PHONE", true},
    {"Click_Cancel", "DLC_Biker_Computer_Sounds", true},
    {"Click_Fail", "DLC_Biker_Computer_Sounds", true},
    {"Click_Fail", "DLC_GR_Disruption_Logistics_Sounds", true},
    {"Click_Fail", "DLC_H3_Arcade_Laptop_Sounds", true},
    {"Click_Fail", "GTAO_SMG_Hangar_Computer_Sounds", true},
    {"Click_Fail", "WEB_NAVIGATION_SOUNDS_PHONE", true},
    {"Click_Link", "DLC_GR_Disruption_Logistics_Sounds", true},
    {"Click_Link", "DLC_H3_Arcade_Laptop_Sounds", true},
    {"Click_Link", "GTAO_SMG_Hangar_Computer_Sounds", true},
    {"Click_Special", " WEB_NAVIGATION_SOUNDS_PHONE", true},
    {"Click_Special", "DLC_Biker_Computer_Sounds", true},
    {"Click_Special", "DLC_GR_Disruption_Logistics_Sounds", true},
    {"Click_Special", "DLC_H3_Arcade_Laptop_Sounds", true},
    {"Click_Special", "GTAO_SMG_Hangar_Computer_Sounds", true},
    {"Click_Special", "WEB_NAVIGATION_SOUNDS_PHONE", true},
    {"Close", "DLC_H3_Tracker_App_Sounds", true},
    {"Closed", "DLC_APT_YACHT_DOOR_SOUNDS", true},
    {"CLOSED", "DLC_APT_YACHT_DOOR_SOUNDS", true},
    {"CLOSED", "MP_PROPERTIES_ELEVATOR_DOORS", true},
    {"CLOSING", "MP_PROPERTIES_ELEVATOR_DOORS", true},
    {"club_crowd_transition", "dlc_btl_club_open_transition_crowd_sounds", true},
    {"clue_complete_shard", "dlc_btl_fm_th_sounds", false},
    {"clue_complete_shard", "dlc_xm_fm_th_sounds", false},
    {"clue_seen", "dlc_ch_hidden_collectibles_sk_sounds", false},
    {"collect_chips_handed", "dlc_vw_tracking_chips_sounds", false},
    {"collect_part", "DLC_sum20_BB_Captured_Sounds", true},
    {"Collect_Pickup", "DLC_IE_PL_Player_Sounds", false},
    {"collect_water", "dlc_sum20_yacht_missions_ah_sounds", true},
    {"Condemned", "DLC_SM_CND_Player_Sounds", true},
    {"Confirm", "GTAO_Exec_SecuroServ_Warehouse_PC_Sounds", true},
    {"CONTINUE", "HUD_FRONTEND_DEFAULT_SOUNDSET", false},
    {"continue", "HUD_FRONTEND_DEFAULT_SOUNDSET", false},
    {"CONTINUE", "HUD_FRONTEND_DEFAULT_SOUNDSET", true},
    {"Continue_Accepted", "DLC_HEIST_PLANNING_BOARD_SOUNDS", true},
    {"Continue_Appears", "DLC_HEIST_PLANNING_BOARD_SOUNDS", true},
    {"Countdown_1", "DLC_AW_Frontend_Sounds", true},
    {"Countdown_1", "DLC_SR_TR_General_Sounds", true},
    {"Countdown_2", "DLC_AW_Frontend_Sounds", true},
    {"Countdown_2", "DLC_SR_TR_General_Sounds", true},
    {"Countdown_3", "DLC_AW_Frontend_Sounds", true},
    {"Countdown_3", "DLC_SR_TR_General_Sounds", true},
    {"Countdown_GO", "DLC_AW_Frontend_Sounds", true},
    {"Countdown_GO", "DLC_SR_TR_General_Sounds", true},
    {"Countdown_Timer_Bleep", "DLC_AW_Arena_Spin_Wheel_Game_Frontend_Sounds", true},
    {"Countdown_Timer_Bleep_Red", "DLC_AW_Arena_Spin_Wheel_Game_Frontend_Sounds", true},
    {"Counter_Tick", "DLC_Biker_Burn_Assets_Sounds", false},
    {"Crash", "DLC_HEIST_HACKING_SNAKE_SOUNDS", true},
    {"Crate_Destroy_Remote", "DLC_IE_Vip_Stockpile_Sounds", false},
    {"Crate_Pickup_Remote", "DLC_IE_Vip_Stockpile_Sounds", false},
    {"Crates_Blipped", "GTAO_Biker_Modes_Soundset", false},
    {"Crates_Blipped", "GTAO_Magnate_Boss_Modes_Soundset", false},
    {"Creator_Snap", "DLC_Stunt_Race_Frontend_Sounds", true},
    {"Criminal_Damage_High_Value", "GTAO_FM_Events_Soundset", false},
    {"Criminal_Damage_Kill_Player", "GTAO_FM_Events_Soundset", false},
    {"Criminal_Damage_Low_Value", "GTAO_FM_Events_Soundset", false},
    {"Crush", "DLC_H4_Submarine_Crush_Depth_Sounds", true},
    {"CUTSCENE_DIALOGUE_OVERRIDE_SOUND_01", 0, false},
    {"CUTSCENE_DIALOGUE_OVERRIDE_SOUND_02", 0, false},
    {"Cycle_Item", "DLC_Dmod_Prop_Editor_Sounds", false},
    {"DayBreak_Stinger", "DLC_Biker_LostAndDamned_Sounds", true},
    {"Degenatron_Logo", "DLC_EXEC_ARC_MAC_SOUNDS", true},
    {"Degenatron_Star", "DLC_EXEC_ARC_MAC_SOUNDS", true},
    {"DELETE", "HUD_DEATHMATCH_SOUNDSET", true},
    {"Delete_Placed_Prop", "DLC_Dmod_Prop_Editor_Sounds", false},
    {"Deliver", "In_And_Out_Attacker_Sounds", false},
    {"Deliver_Item", "GTAO_Biker_Modes_Soundset", false},
    {"Deliver_Item", "GTAO_Biker_Modes_Soundset", true},
    {"Deliver_Pick_Up", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS", true},
    {"DLC_VW_BET_MAX", "dlc_vw_table_games_frontend_sounds", true},
    {"DLC_VW_BET_UP", "dlc_vw_table_games_frontend_sounds", true},
    {"DLC_VW_CONTINUE", "dlc_vw_table_games_frontend_sounds", true},
    {"DLC_VW_ERROR_MAX", "dlc_vw_table_games_frontend_sounds", true},
    {"DLC_VW_RULES", "dlc_vw_table_games_frontend_sounds", true},
    {"DLC_VW_WIN_CHIPS", "dlc_vw_table_games_frontend_sounds", true},
    {"Door_Open", "DOCKS_HEIST_FINALE_2B_SOUNDS", true},
    {"Door_Open_Limit", "DLC_GR_Bunker_Door_Sounds", true},
    {"Door_Open_Limit", "DLC_SM_Hangar_Door_Sounds", true},
    {"Door_Open_Limit", "DLC_XM_Silo_Secret_Door_Sounds", true},
    {"download_complete", "DLC_BTL_Break_In_Sounds", true},
    {"download_start", "DLC_BTL_Break_In_Sounds", true},
    {"DPAD_WEAPON_SCROLL", "HUD_FRONTEND_DEFAULT_SOUNDSET", true},
    {"Drill_Pin_Break", "DLC_HEIST_FLEECA_SOUNDSET", true},
    {"Drop_Pickup", "DLC_IE_PL_Enemy_Sounds", false},
    {"Drop_Pickup", "DLC_IE_PL_Player_Sounds", false},
    {"Drop_Pickup", "DLC_IE_PL_Team_Sounds", false},
    {"Dropped", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS", true},
    {"Dropped", "In_And_Out_Attacker_Sounds", false},
    {"Dropped", "In_And_Out_Defender_Sounds", false},
    {"EDIT", "HUD_DEATHMATCH_SOUNDSET", true},
    {"emp_activate", "dlc_ch_heist_finale_sounds", true},
    {"EMP_vehicle_affected", "DLC_AW_EMP_Sounds", true},
    {"Empty_Fire_Fail", "DLC_AW_Machine_Gun_Ammo_Counter_Sounds", true},
    {"End_Squelch", "CB_RADIO_SFX", true},
    {"End_Zone_Flash", "DLC_BTL_RB_Remix_Sounds", true},
    {"Enemy_Deliver", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS", true},
    {"Enemy_Deliver", "In_And_Out_Defender_Sounds", false},
    {"Enemy_Killed_1p", "dlc_xm_hata_Sounds", false},
    {"Enemy_Killed_3p", "dlc_xm_hata_Sounds", false},
    {"Enemy_Pick_Up", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS", true},
    {"Enemy_Pick_Up", "In_And_Out_Defender_Sounds", false},
    {"Enter_1st", "GTAO_Biker_Modes_Soundset", false},
    {"Enter_1st", "GTAO_FM_Events_Soundset", false},
    {"Enter_1st", "GTAO_Magnate_Boss_Modes_Soundset", false},
    {"Enter_Area", "DLC_Lowrider_Relay_Race_Sounds", false},
    {"Enter_Capture_Zone", sVar0, false},
    {"Enter_On_Foot", "GTAO_ImpExp_Enter_Exit_Garage_Sounds", true},
    {"Enter_Zone", "DLC_Biker_SYG_Sounds", true},
    {"ERROR", "DLC_Biker_Mission_Wall_Sounds", true},
    {"ERROR", "DLC_EXEC_Warehouse_Upgrade_Bench_Sounds", true},
    {"Error", "GTAO_Exec_SecuroServ_Warehouse_PC_Sounds", true},
    {"ERROR", "HUD_AMMO_SHOP_SOUNDSET", true},
    {"ERROR", "HUD_FREEMODE_SOUNDSET", true},
    {"ERROR", "HUD_FRONTEND_CLOTHESSHOP_SOUNDSET", true},
    {"ERROR", "HUD_FRONTEND_DEFAULT_SOUNDSET", true},
    {"ERROR", "HUD_LIQUOR_STORE_SOUNDSET", true},
    {"Event_Message_Purple", "GTAO_FM_Events_Soundset", false},
    {"Event_Start_Text", "GTAO_FM_Events_Soundset", false},
    {"EXILE_3_TRAIN_BRAKE_PULL_MASTER", 0, true},
    {"EXILE_3_TRAIN_BRAKE_RELEASE_MASTER", 0, true},
    {"Exit", "DLC_Biker_Computer_Sounds", true},
    {"Exit", "DLC_GR_Disruption_Logistics_Sounds", true},
    {"Exit", "DLC_H3_Arcade_Laptop_Sounds", true},
    {"Exit", "GTAO_SMG_Hangar_Computer_Sounds", true},
    {"EXIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true},
    {"Faction3_Upgrade", "Low2_Super_Mod_Garage_Sounds", true},
    {"Fail", "dlc_xm_silo_laser_hack_sounds", true},
    {"Failure", "DLC_HEIST_HACKING_SNAKE_SOUNDS", true},
    {"FAKE_ARRIVE", "MP_PROPERTIES_ELEVATOR_DOORS", true},
    {"Falling_Crates", "EXILE_1", true},
    {"FAMILY_1_CAR_BREAKDOWN", "FAMILY1_BOAT", true},
    {"FAMILY_1_CAR_BREAKDOWN_ADDITIONAL", "FAMILY1_BOAT", true},
    {"Faster_Bar_Full", "RESPAWN_ONLINE_SOUNDSET", true},
    {"Faster_Click", "RESPAWN_ONLINE_SOUNDSET", true},
    {"FestiveGift", "Feed_Message_Sounds", false},
    {"Finish_Default", "DLC_AW_Frontend_Sounds", true},
    {"Finish_Win", "DLC_AW_Frontend_Sounds", true},
    {"FIRST_PLACE", "HUD_MINI_GAME_SOUNDSET", true},
    {"Flag_Collected", "DLC_SM_STPI_Enemy_Sounds", true},
    {"Flag_Collected", "DLC_SM_STPI_Player_Sounds", true},
    {"Flag_Delivered", "DLC_SM_STPI_Enemy_Sounds", true},
    {"Flag_Delivered", "DLC_SM_STPI_Player_Sounds", true},
    {"Flag_Dropped", "DLC_SM_STPI_Enemy_Sounds", true},
    {"Flag_Dropped", "DLC_SM_STPI_Player_Sounds", true},
    {"flares_empty", "DLC_SM_Countermeasures_Sounds", true},
    {"Flight_Unlock", "DLC_XM17_IAA_Deluxos_Sounds", true},
    {"FLYING_STREAM_END_INSTANT", "FAMILY_5_SOUNDS", true},
    {"Focus", "DLC_AW_Trap_Controller_Sounds", true},
    {"FocusIn", "HintCamSounds", true},
    {"FocusOut", "HintCamSounds", true},
    {"formation_active", "formation_flying_blips_soundset", false},
    {"formation_inactive", "formation_flying_blips_soundset", false},
    {"Friend_Deliver", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS", true},
    {"Friend_Pick_Up", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS", false},
    {"Friend_Pick_Up", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS", true},
    {"Friend_Pick_Up", "In_And_Out_Attacker_Sounds", false},
    {"Frontend_Beast_Fade_Screen", "FM_Events_Sasquatch_Sounds", false},
    {"Frontend_Beast_Freeze_Screen", "FM_Events_Sasquatch_Sounds", false},
    {"Frontend_Beast_Text_Hit", "FM_Events_Sasquatch_Sounds", false},
    {"Frontend_Beast_Transform_Back", "FM_Events_Sasquatch_Sounds", false},
    {"gadget_pistol_shard", "dlc_hei4_hidden_collectibles_sounds", true},
    {"Gain_Point", "dlc_xm_aqo_sounds", false},
    {"Garage_Door_Close", "GTAO_Script_Doors_Faded_Screen_Sounds", true},
    {"Garage_Door_Open", "GTAO_Script_Doors_Faded_Screen_Sounds", true},
    {"Generic_Door_Closed", "GTAO_Script_Doors_Sounds", true},
    {"Generic_Negative_Event", "GTAO_Biker_Modes_Soundset", true},
    {"Generic_Positive_Event", "GTAO_Biker_Modes_Soundset", true},
    {"Go", "DLC_EXEC_ARC_MAC_SOUNDS", true},
    {"GO", "HUD_MINI_GAME_SOUNDSET", false},
    {"GO", "HUD_MINI_GAME_SOUNDSET", true},
    {"GO_NON_RACE", "HUD_MINI_GAME_SOUNDSET", true},
    {"Go_To_Target", "DLC_AW_Trap_Controller_Sounds", true},
    {"Goal", "DLC_HEIST_HACKING_SNAKE_SOUNDS", true},
    {"Goal_Reached", "dlc_xm_aqo_sounds", false},
    {"Goggles_Update", "DLC_XM17_Silo_Pred_Sounds", true},
    {"GOLF_NEW_RECORD", "HUD_AWARDS", true},
    {"Goon_Paid_Small", "GTAO_Boss_Goons_FM_Soundset", false},
    {"Gun_Collect", "DLC_SR_TR_Gun_Player_Sounds", true},
    {"Hack_Complete", "DLC_IE_SVM_Voltic2_Hacking_Sounds", true},
    {"Hack_Complete", "dlc_xm_deluxos_hacking_Hacking_Sounds", true},
    {"Hack_Fail", "DLC_sum20_Business_Battle_AC_Sounds", true},
    {"Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", false},
    {"Hack_Start", "DLC_IE_SVM_Voltic2_Hacking_Sounds", true},
    {"Hack_Start", "dlc_xm_deluxos_hacking_Hacking_Sounds", true},
    {"Hack_Stop", "DLC_IE_SVM_Voltic2_Hacking_Sounds", true},
    {"Hack_Stop", "dlc_xm_deluxos_hacking_Hacking_Sounds", true},
    {"Hack_Success", "DLC_GR_Steal_Railguns_Sounds", true},
    {"Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true},
    {"Hack_Success", "DLC_sum20_Business_Battle_AC_Sounds", true},
    {"HACKING_CLICK", 0, true},
    {"HACKING_CLICK_BAD", 0, true},
    {"HACKING_CLICK_GOOD", 0, true},
    {"HACKING_FAILURE", 0, true},
    {"HACKING_MOVE_CURSOR", 0, true},
    {"HACKING_SUCCESS", 0, true},
    {"Hang_Up", "Phone_SoundSet_Michael", true},
    {"hangar_doors_close", "dlc_xm_facility_entry_exit_sounds", true},
    {"hangar_doors_limit", "dlc_xm_facility_entry_exit_sounds", true},
    {"hangar_doors_open", "dlc_xm_facility_entry_exit_sounds", true},
    {"health_lost", "DLC_sum20_Open_Wheel_Racing_Sounds", true},
    {"Highlight_Accept", "DLC_AW_Arena_Office_Planning_Wall_Sounds", true},
    {"Highlight_Accept", "DLC_Biker_Mission_Wall_Sounds", true},
    {"Highlight_Accept", "DLC_HEIST_PLANNING_BOARD_SOUNDS", true},
    {"Highlight_Back", "DLC_AW_Arena_Office_Planning_Wall_Sounds", true},
    {"Highlight_Back", "DLC_Biker_Mission_Wall_Sounds", true},
    {"Highlight_Cancel", "DLC_HEIST_PLANNING_BOARD_SOUNDS", true},
    {"Highlight_Error", "DLC_Biker_Mission_Wall_Sounds", true},
    {"Highlight_Error", "DLC_HEIST_PLANNING_BOARD_SOUNDS", true},
    {"Highlight_Move", "DLC_HEIST_PLANNING_BOARD_SOUNDS", true},
    {"Highlight_Move_Left_Right", "DLC_Biker_Mission_Wall_Sounds", true},
    {"Highlight_Move_Up_Down", "DLC_AW_Arena_Office_Planning_Wall_Sounds", true},
    {"Highlight_Move_Up_Down", "DLC_Biker_Mission_Wall_Sounds", true},
    {"Hit", "RESPAWN_ONLINE_SOUNDSET", true},
    {"Hit", "RESPAWN_SOUNDSET", false},
    {"Hit", "RESPAWN_SOUNDSET", true},
    {"Hit_1", "LONG_PLAYER_SWITCH_SOUNDS", false},
    {"Hit_1", "LONG_PLAYER_SWITCH_SOUNDS", true},
    {"Hit_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true},
    {"Hit_Mirror", "dlc_xm_silo_laser_hack_sounds", true},
    {"Hit_out", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true},
    {"Hit_Out", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true},
    {"HOORAY", "BARRY_02_SOUNDSET", true},
    {"HORDE_COOL_DOWN_TIMER", "HUD_FRONTEND_DEFAULT_SOUNDSET", true},
    {"Hover_Unlock", "DLC_XM17_IAA_Deluxos_Sounds", true},
    {"HUD_FREEMODE_CANCEL_MASTER", 0, true},
    {"Idcnput_Code_Enter_Correct_Final", "Safe_Minigame_Sounds", true},
    {"In_Range", "DLC_Biker_SL_Sounds", true},
    {"inactive_fire_fail", "dlc_xm_orbital_cannon_sounds", true},
    {"INFO", "HUD_FRONTEND_DEFAULT_SOUNDSET", true},
    {"Input_Code_Down", "Safe_Minigame_Sounds", true},
    {"Input_Code_Enter_Correct", "Safe_Minigame_Sounds", true},
    {"Input_Code_Enter_Wrong", "Safe_Minigame_Sounds", true},
    {"Input_Code_Up", "Safe_Minigame_Sounds", true},
    {"item_found", "dlc_btl_fm_th_sounds", false},
    {"item_found", "dlc_xm_fm_th_sounds", false},
    {"Kill_List_Counter", "GTAO_FM_Events_Soundset", false},
    {"killer_down", "dlc_ch_hidden_collectibles_sk_sounds", false},
    {"laser_pin_break", "dlc_ch_heist_finale_laser_drill_sounds", true},
    {"Launch", "DLC_H3_Tracker_App_Sounds", true},
    {"LEADER_BOARD", "HUD_FRONTEND_DEFAULT_SOUNDSET", true},
    {"Leave_Zone", "DLC_Biker_SYG_Sounds", true},
    {"Lester_Laugh_Phone", "DLC_HEIST_HACKING_SNAKE_SOUNDS", true},
    {"lights_on", "dlc_xm_stealavg_sounds", true},
    {"LIMIT", "DLC_APT_YACHT_DOOR_SOUNDS", true},
    {"LIMIT", "GTAO_APT_DOOR_DOWNSTAIRS_GENERIC_SOUNDS", true},
    {"LIMIT", "GTAO_APT_DOOR_DOWNSTAIRS_GLASS_SOUNDS", true},
    {"LIMIT", "GTAO_APT_DOOR_DOWNSTAIRS_WOOD_SOUNDS", true},
    {"LIMIT", "GTAO_APT_DOOR_ROOF_METAL_SOUNDS", true},
    {"Load_Scene", "DLC_Dmod_Prop_Editor_Sounds", false},
    {"LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", false},
    {"LOCAL_PLYR_CASH_COUNTER_INCREASE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", false},
    {"Log_In", "DLC_GR_MOC_Computer_Sounds", true},
    {"Login", "GTAO_Exec_SecuroServ_Warehouse_PC_Sounds", true},
    {"Logout", "DLC_GR_MOC_Computer_Sounds", true},
    {"Logout", "GTAO_Exec_SecuroServ_Computer_Sounds", true},
    {"LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", true},
    {"Lose_1st", "GTAO_Biker_Modes_Soundset", false},
    {"Lose_1st", "GTAO_FM_Events_Soundset", false},
    {"Lose_1st", "GTAO_Magnate_Boss_Modes_Soundset", false},
    {"Lose_First", "DLC_Biker_SL_Sounds", true},
    {"Lose_Powerup", "DLC_IE_VV_General_Sounds", true},
    {"LOSER", "CELEBRATION_SOUNDSET", true},
    {"LOSER", "HUD_AWARDS", true},
    {"Losing_Team_Shard", "DLC_Exec_TP_SoundSet", false},
    {"Lowrider_Upgrade", "Lowrider_Super_Mod_Garage_Sounds", true},
    {"Map_Roll_Down", "DLC_HEIST_PLANNING_BOARD_SOUNDS", true},
    {"Map_Roll_Up", "DLC_HEIST_PLANNING_BOARD_SOUNDS", true},
    {"Match_End", "DLC_Low2_Ibi_Sounds", false},
    {"Match_Start", "DLC_Low2_Ibi_Sounds", false},
    {"MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", true},
    {"Menu_Accept", "Phone_SoundSet_Default", true},
    {"menu_back", "dlc_xm_orbital_cannon_sounds", true},
    {"menu_reset", "dlc_xm_orbital_cannon_sounds", true},
    {"menu_select", "dlc_xm_orbital_cannon_sounds", true},
    {"menu_up_down", "dlc_xm_orbital_cannon_sounds", true},
    {"MICHAEL_LONG_SCREAM", "FAMILY_5_SOUNDS", true},
    {"Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", false},
    {"Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true},
    {"Mouse_Click", "GTAO_Exec_SecuroServ_Warehouse_PC_Sounds", true},
    {"movie_prop", "DLC_SUM20_HIDDEN_COLLECTIBLES", false},
    {"movie_prop_reward_cut_roar", "DLC_sum20_hidden_collectible_sounds", true},
    {"MP_5_SECOND_TIMER", "HUD_FRONTEND_DEFAULT_SOUNDSET", true},
    {"MP_AWARD", "HUD_FRONTEND_DEFAULT_SOUNDSET", false},
    {"MP_AWARD", "HUD_FRONTEND_DEFAULT_SOUNDSET", true},
    {"MP_Flash", "WastedSounds", true},
    {"MP_IDLE_KICK", "HUD_FRONTEND_DEFAULT_SOUNDSET", true},
    {"MP_IDLE_TIMER", "HUD_FRONTEND_DEFAULT_SOUNDSET", true},
    {"MP_Impact", "WastedSounds", true},
    {"MP_RANK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", false},
    {"MP_WAVE_COMPLETE", "HUD_FRONTEND_DEFAULT_SOUNDSET", true},
    {"Music_Game_Over", "DLC_EXEC_ARC_MAC_SOUNDS", true},
    {"Music_Win", "DLC_EXEC_ARC_MAC_SOUNDS", true},
    {"NAV", "HUD_AMMO_SHOP_SOUNDSET", true},
    {"Nav_Arrow_Ahead", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true},
    {"Nav_Arrow_Behind", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true},
    {"Nav_Arrow_Left", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true},
    {"Nav_Arrow_Right", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true},
    {"NAV_LEFT_RIGHT", "HUD_FREEMODE_SOUNDSET", true},
    {"NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false},
    {"NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true},
    {"NAV_UP_DOWN", "DLC_EXEC_Warehouse_Upgrade_Bench_Sounds", true},
    {"NAV_UP_DOWN", "HUD_FREEMODE_SOUNDSET", true},
    {"NAV_UP_DOWN", "HUD_FRONTEND_CLOTHESSHOP_SOUNDSET", true},
    {"NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", false},
    {"NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true},
    {"NAV_UP_DOWN", "HUD_LIQUOR_STORE_SOUNDSET", true},
    {"Navigate", "GTAO_Exec_SecuroServ_Computer_Sounds", true},
    {"Near_Miss_Counter_Reset", "GTAO_FM_Events_Soundset", false},
    {"NET_RACE_START_EVENT_MASTER", 0, true},
    {"Next_Level_Explosive", "DLC_Biker_KQ_Sounds", true},
    {"Next_Level_Generic", "DLC_Biker_KQ_Sounds", true},
    {"Next_Level_Gun", "DLC_Biker_KQ_Sounds", true},
    {"Next_Level_Melee", "DLC_Biker_KQ_Sounds", true},
    {"Next_Trap", "DLC_AW_Trap_Controller_Sounds", true},
    {"NightFall_Stinger", "DLC_Biker_LostAndDamned_Sounds", true},
    {"NO", "HUD_FRONTEND_DEFAULT_SOUNDSET", true},
    {"No_Longer_Target", "dlc_xm_hata_Sounds", false},
    {"Node_Release", "dlc_xm_silo_laser_hack_sounds", true},
    {"Node_Select", "dlc_xm_silo_laser_hack_sounds", true},
    {"Object_Collect_Player", "GTAO_FM_Events_Soundset", false},
    {"Object_Collect_Remote", "GTAO_FM_Events_Soundset", false},
    {"Object_Dropped_Remote", "GTAO_FM_Events_Soundset", false},
    {"Off_High", "MP_RADIO_SFX", true},
    {"Off_Low", "MP_RADIO_SFX", true},
    {"OK", "HUD_FRONTEND_DEFAULT_SOUNDSET", true},
    {"On_Call_Player_Join", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true},
    {"Oneshot_Final", "MP_MISSION_COUNTDOWN_SOUNDSET", false},
    {"OOB_Cancel", "GTAO_FM_Events_Soundset", false},
    {"OOB_Start", "GTAO_FM_Events_Soundset", false},
    {"OPENED", "MP_PROPERTIES_ELEVATOR_DOORS", true},
    {"OPENING", "MP_PROPERTIES_ELEVATOR_DOORS", true},
    {"Orientation_Fail", "DLC_Air_Race_Sounds_Player", bVar0},
    {"Orientation_Fail", "DLC_Air_Race_Sounds_Player", false},
    {"Orientation_Success", "DLC_Air_Race_Sounds_Player", bVar0},
    {"Orientation_Success", "DLC_Air_Race_Sounds_Player", false},
    {"Out_Of_Ammo", "DLC_AW_Machine_Gun_Ammo_Counter_Sounds", true},
    {"Out_Of_Area", "DLC_Lowrider_Relay_Race_Sounds", false},
    {"Out_Of_Range", "DLC_Biker_SL_Sounds", true},
    {"package_delivered_success", "DLC_GR_Generic_Mission_Sounds", true},
    {"package_delivered_success_remote", "DLC_GR_Generic_Mission_Sounds", true},
    {"Paper_Shuffle", "DLC_HEIST_PLANNING_BOARD_SOUNDS", true},
    {"Paper_Stick", "DLC_HEIST_PLANNING_BOARD_SOUNDS", true},
    {"Parcel_Vehicle_Lost", "GTAO_FM_Events_Soundset", false},
    {"Pass", "dlc_xm_silo_laser_hack_sounds", true},
    {"Payment_Non_Player", "DLC_HEISTS_GENERIC_SOUNDS", false},
    {"Payment_Player", "DLC_HEISTS_GENERIC_SOUNDS", false},
    {"Pen_Tick", "DLC_HEIST_PLANNING_BOARD_SOUNDS", true},
    {"Period_Start", "DLC_AW_BB_Sounds", true},
    {"Phone_Text_Arrive", "DLC_H4_MM_Sounds", true},
    {"PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", true},
    {"Pickup_Keyring", "dlc_h4_heist_finale_sounds_soundset", true},
    {"Pickup_Standard", "GTAO_Biker_Modes_Soundset", false},
    {"Pilot_Perspective_Fire", "DLC_H3_Drone_Tranq_Weapon_Sounds", true},
    {"Pin_Bad", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true},
    {"PIN_BUTTON", "ATM_SOUNDS", true},
    {"Pin_Centred", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true},
    {"Pin_Good", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true},
    {"Place_Gain", "DLC_Stunt_Race_Frontend_Sounds", true},
    {"Place_Lose", "DLC_Stunt_Race_Frontend_Sounds", true},
    {"Place_Prop_Fail", "DLC_Dmod_Prop_Editor_Sounds", false},
    {"Place_Prop_Success", "DLC_Dmod_Prop_Editor_Sounds", false},
    {"Player_Collect", "DLC_PILOT_MP_HUD_SOUNDS", false},
    {"Player_Enter_Line", "GTAO_FM_Cross_The_Line_Soundset", false},
    {"Player_Exit_Line", "GTAO_FM_Cross_The_Line_Soundset", false},
    {"Player_Pick_Up", "In_And_Out_Attacker_Sounds", false},
    {"playing_card", "dlc_vw_hidden_collectible_sounds", false},
    {"police_notification", "DLC_AS_VNT_Sounds", true},
    {"Popup_Cancel", "GTAO_Exec_SecuroServ_Computer_Sounds", true},
    {"Popup_Confirm_Fail", "GTAO_Exec_SecuroServ_Computer_Sounds", true},
    {"Popup_Confirm_Success", "GTAO_Exec_SecuroServ_Computer_Sounds", true},
    {"Power_Down", "DLC_HEIST_HACKING_SNAKE_SOUNDS", true},
    {"power_on", "dlc_ch_heist_finale_sounds", false},
    {"Pre_Screen_Stinger", "DLC_HEISTS_FAILED_SCREEN_SOUNDS", false},
    {"Pre_Screen_Stinger", "DLC_HEISTS_FINALE_SCREEN_SOUNDS", false},
    {"Pre_Screen_Stinger", "DLC_HEISTS_FINALE_SCREEN_SOUNDS", true},
    {"Pre_Screen_Stinger", "DLC_HEISTS_PREP_SCREEN_SOUNDS", false},
    {"Pre_Screen_Stinger", "DLC_HEISTS_PREP_SCREEN_SOUNDS", true},
    {"Previous_Trap", "DLC_AW_Trap_Controller_Sounds", true},
    {"PROPERTY_PURCHASE", "HUD_AWARDS", true},
    {"PURCHASE", "HUD_LIQUOR_STORE_SOUNDSET", true},
    {"Purchase_Upgrade", "DLC_EXEC_Warehouse_Upgrade_Bench_Sounds", true},
    {"PUSH", "DLC_APT_YACHT_DOOR_SOUNDS", true},
    {"PUSH", "GTAO_APT_DOOR_DOWNSTAIRS_GENERIC_SOUNDS", true},
    {"Push", "GTAO_APT_DOOR_DOWNSTAIRS_GENERIC_SOUNDS", true},
    {"PUSH", "GTAO_APT_DOOR_DOWNSTAIRS_GLASS_SOUNDS", true},
    {"PUSH", "GTAO_APT_DOOR_DOWNSTAIRS_WOOD_SOUNDS", true},
    {"PUSH", "GTAO_APT_DOOR_ROOF_METAL_SOUNDS", true},
    {"Put_Away", "Phone_SoundSet_Michael", true},
    {"R2_Boost", "DLC_Biker_SL_Sounds", true},
    {"RACE_PLACED", "HUD_AWARDS", true},
    {"Radar_Beast_Blip", "FM_Events_Sasquatch_Sounds", false},
    {"RANK_UP", "HUD_AWARDS", true},
    {"Rappel_Land", "GTAO_Rappel_Sounds", true},
    {"Rappel_Stop", "GTAO_Rappel_Sounds", true},
    {"rc_mines_empty", "DLC_AW_RCBandito_Mine_Sounds", true},
    {"Ready", "DLC_EXEC_ARC_MAC_SOUNDS", true},
    {"Recharged", "DLC_AW_Machine_Gun_Ammo_Counter_Sounds", true},
    {"Red_Target_Explode", "dlc_xm_silo_laser_hack_sounds", true},
    {"REMOTE_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", false},
    {"REMOTE_PLYR_CASH_COUNTER_INCREASE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", false},
    {"Remote_Sniper_Rifle_Fire", 0, true},
    {"Remove_Tracker", "DLC_IO_Warehouse_Mod_Garage_Sounds", true},
    {"Reset_Prop_Position", "DLC_Dmod_Prop_Editor_Sounds", false},
    {"Reset_Win", "DLC_SR_RS_Enemy_Sounds", true},
    {"Reset_Win", "DLC_SR_RS_Team_Sounds", true},
    {"Resurrected", "DLC_SR_RS_Enemy_Sounds", true},
    {"Resurrected", "DLC_SR_RS_Player_Sounds", true},
    {"Resurrected", "DLC_SR_RS_Team_Sounds", true},
    {"Retune_High", "MP_RADIO_SFX", true},
    {"Retune_Low", "MP_RADIO_SFX", true},
    {"ROBBERY_MONEY_TOTAL", "HUD_FRONTEND_CUSTOM_SOUNDSET", true},
    {"Rocket_Collect", "DLC_SR_TR_Rocket_Player_Sounds", true},
    {"Round_End", "DLC_BTL_SM_Remix_Soundset", false},
    {"Round_End", "DLC_LOW2_Sumo_Soundset", false},
    {"ROUND_ENDING_STINGER_CUSTOM", "CELEBRATION_SOUNDSET", false},
    {"Round_Start", "DLC_BTL_SM_Remix_Soundset", false},
    {"Round_Start", "DLC_LOW2_Sumo_Soundset", false},
    {"Round_Start_Blade", "POWER_PLAY_General_Soundset", true},
    {"Save_Scene", "DLC_Dmod_Prop_Editor_Sounds", false},
    {"Scope_Spot_POI", "GTAO_Heists_HUD_Sounds", false},
    {"Score", "DLC_Low2_Ibi_Sounds", false},
    {"Score_Down", "DLC_IE_PL_Enemy_Sounds", false},
    {"Score_Down", "DLC_IE_PL_Player_Sounds", false},
    {"Score_Down", "DLC_IE_PL_Team_Sounds", false},
    {"Score_Opponent", "DLC_Biker_KQ_Sounds", true},
    {"Score_Team", "DLC_Biker_KQ_Sounds", true},
    {"Score_Up", "DLC_IE_PL_Enemy_Sounds", false},
    {"Score_Up", "DLC_IE_PL_Player_Sounds", false},
    {"Score_Up", "DLC_IE_PL_Team_Sounds", false},
    {"SCREEN_FLASH", "CELEBRATION_SOUNDSET", true},
    {"ScreenFlash", "MissionFailedSounds", true},
    {"ScreenFlash", "WastedSounds", true},
    {"SELECT", "DLC_EXEC_Warehouse_Upgrade_Bench_Sounds", true},
    {"SELECT", "HUD_FREEMODE_SOUNDSET", true},
    {"SELECT", "HUD_FRONTEND_CLOTHESSHOP_SOUNDSET", true},
    {"SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false},
    {"SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true},
    {"SELECT", "HUD_FRONTEND_MP_SOUNDSET", false},
    {"SELECT", "HUD_FRONTEND_MP_SOUNDSET", true},
    {"SELECT", "HUD_LIQUOR_STORE_SOUNDSET", true},
    {"Select_Mission_Are_You_Sure", "DLC_GR_MOC_Computer_Sounds", true},
    {"Select_Mission_Cancel", "DLC_GR_MOC_Computer_Sounds", true},
    {"Select_Mission_Launch", "DLC_GR_MOC_Computer_Sounds", true},
    {"Select_Mission_Unavailable", "DLC_GR_MOC_Computer_Sounds", true},
    {"Select_Mission_Unavailable_OK", "DLC_GR_MOC_Computer_Sounds", true},
    {"Select_Placed_Prop", "DLC_Dmod_Prop_Editor_Sounds", false},
    {"Sell", "GTAO_Exec_SecuroServ_Computer_Sounds", true},
    {"Sell", "GTAO_Exec_SecuroServ_Warehouse_PC_Sounds", true},
    {"shard", "dlc_ch_hidden_collectibles_sj_sounds", false},
    {"shard", "dlc_vw_hidden_collectible_sounds", false},
    {"Shard_Disappear", "GTAO_Biker_FM_Shard_Sounds", false},
    {"Shard_Disappear", "GTAO_Boss_Goons_FM_Shard_Sounds", false},
    {"Shard_Disappear", "GTAO_FM_Events_Soundset", false},
    {"Short_Transition_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true},
    {"Short_Transition_Out", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true},
    {"shotgun_shard", "dlc_hei4_hidden_collectibles_sounds", true},
    {"Show_Overview_Menu", "GTAO_SMG_Hangar_Computer_Sounds", true},
    {"Show_Sell_Menu", "GTAO_SMG_Hangar_Computer_Sounds", true},
    {"Show_Source_Menu", "GTAO_SMG_Hangar_Computer_Sounds", true},
    {"Speech_Floor_1", "DLC_IE_Garage_Elevator_Sounds", true},
    {"Speech_Floor_2", "DLC_IE_Garage_Elevator_Sounds", true},
    {"Speech_Floor_3", "DLC_IE_Garage_Elevator_Sounds", true},
    {"Start", "DLC_AW_Frontend_Sounds", false},
    {"Start", "DLC_AW_Frontend_Sounds", true},
    {"Start", "DLC_HEIST_HACKING_SNAKE_SOUNDS", true},
    {"Start_Squelch", "CB_RADIO_SFX", true},
    {"Steal_Powerup", "DLC_IE_VV_General_Sounds", true},
    {"Success", "DLC_HEIST_HACKING_SNAKE_SOUNDS", true},
    {"SultanRS_Upgrade", "JA16_Super_Mod_Garage_Sounds", true},
    {"Super_Mod_Garage_Upgrade_Car_Default", 0, true},
    {"supermod_consumer", "Arena_Vehicle_Mod_Shop_Sounds", true},
    {"supermod_scifi", "Arena_Vehicle_Mod_Shop_Sounds", true},
    {"supermod_wasteland", "Arena_Vehicle_Mod_Shop_Sounds", true},
    {"Survival_Failed", "DLC_VW_AS_Sounds", true},
    {"Swap_Sides", "DLC_HALLOWEEN_FVJ_Sounds", false},
    {"SWING_SHUT", "GTAO_APT_DOOR_DOWNSTAIRS_GENERIC_SOUNDS", true},
    {"SWING_SHUT", "GTAO_APT_DOOR_DOWNSTAIRS_GLASS_SOUNDS", true},
    {"SWING_SHUT", "GTAO_APT_DOOR_DOWNSTAIRS_WOOD_SOUNDS", true},
    {"SWING_SHUT", "GTAO_APT_DOOR_ROOF_METAL_SOUNDS", true},
    {"tag_entity", "dlc_xm_heists_iaa_morgue_sounds", false},
    {"Take_First", "DLC_Biker_SL_Sounds", true},
    {"Target_Counter_Tick", "DLC_SM_Generic_Mission_Sounds", true},
    {"Team_Killed_1p", "dlc_xm_hata_Sounds", false},
    {"Team_Killed_3p", "dlc_xm_hata_Sounds", false},
    {"Teammate_Checkpoint", "DLC_Biker_SL_Sounds", true},
    {"TENNIS_POINT_WON", "HUD_AWARDS", true},
    {"TextHit", "WastedSounds", true},
    {"Thermal_Off", "CAR_STEAL_2_SOUNDSET", true},
    {"Thermal_On", "CAR_STEAL_2_SOUNDSET", true},
    {"TIME_LAPSE_MASTER", 0, true},
    {"TIMER_RADIAL_Pulse", "DLC_AS_TRP_Sounds", false},
    {"TIMER_RADIAL_Pulse", "DLC_BTL_SM_Remix_Soundset", false},
    {"TIMER_RADIAL_Reset", "DLC_AS_TRP_Sounds", false},
    {"TIMER_RADIAL_Reset", "DLC_BTL_SM_Remix_Soundset", false},
    {"TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", true},
    {"TOGGLE_ON", "HUD_FRONTEND_DEFAULT_SOUNDSET", false},
    {"TOGGLE_ON", "HUD_FRONTEND_DEFAULT_SOUNDSET", true},
    {"Traffic_Control_Fail", "BIG_SCORE_3A_SOUNDS", true},
    {"Traffic_Control_Fail_Blank", "BIG_SCORE_3A_SOUNDS", true},
    {"Traffic_Control_Light_Switch_Back", "BIG_SCORE_3A_SOUNDS", true},
    {"TRAFFIC_CONTROL_MOVE_CROSSHAIR", "BIG_SCORE_3A_SOUNDS", true},
    {"Transform_Local_Player", "DLC_Exec_TP_SoundSet", false},
    {"Transform_Loser_Local_Player", "DLC_Exec_TP_SoundSet", false},
    {"transform_oneshot", "dlc_xm_stromberg_sounds", true},
    {"Turn", "DLC_HEIST_HACKING_SNAKE_SOUNDS", true},
    {"tyre_health_warning", "DLC_sum20_Open_Wheel_Racing_Sounds", true},
    {"Uncondemned", "DLC_SM_CND_Player_Sounds", true},
    {"UNDER_THE_BRIDGE", "HUD_AWARDS", true},
    {"Use_Boost", "DLC_Biker_DL_Sounds", true},
    {"Use_Bunnyhop", "DLC_Biker_DL_Sounds", true},
    {"Use_Zoned", "DLC_Biker_DL_Sounds", true},
    {"Wasted", "DLC_IE_VV_General_Sounds", true},
    {"Wasted", "POWER_PLAY_General_Soundset", true},
    {"WAYPOINT_SET", "HUD_FRONTEND_DEFAULT_SOUNDSET", false},
    {"Weapon_Disabled", "DLC_SR_LG_Player_Sounds", true},
    {"Weapon_Enabled", "DLC_SR_LG_Player_Sounds", true},
    {"WEAPON_PURCHASE", "HUD_AMMO_SHOP_SOUNDSET", true},
    {"WEAPON_SELECT_ARMOR", "HUD_AMMO_SHOP_SOUNDSET", true},
    {"Weapon_Upgrade", "DLC_GR_Weapon_Upgrade_Soundset", true},
    {"Wheel_Spin_Start", "DLC_AW_Arena_Spin_Wheel_Game_Frontend_Sounds", true},
    {"Whistle", "DLC_TG_Running_Back_Sounds", false},
    {"Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", true},
    {"Whoosh_1s_R_to_L", "MP_LOBBY_SOUNDS", true},
    {"WIN", "HUD_AWARDS", true},
    {"WINNER", "CELEBRATION_SOUNDSET", true},
    {"Winning_Team_Shard", "DLC_Exec_TP_SoundSet", false},
    {"WOODEN_DOOR_CLOSED_AT", 0, false},
    {"WOODEN_DOOR_CLOSED_AT", 0, true},
    {"WOODEN_DOOR_CLOSING_AT", 0, false},
    {"WOODEN_DOOR_CLOSING_AT", 0, true},
    {"WOODEN_DOOR_OPEN_HANDLE_AT", 0, false},
    {"WOODEN_DOOR_OPEN_HANDLE_AT", 0, true},
    {"WOODEN_DOOR_OPEN_NO_HANDLE_AT", 0, true},
    {"YES", "HUD_FRONTEND_DEFAULT_SOUNDSET", true},
    {"Zone_Captured", "dlc_vw_koth_Sounds", false},
    {"Zone_Captured_Remote", "dlc_vw_koth_Sounds", false},
    {"Zone_Contested", "dlc_vw_koth_Sounds", false},
    {"Zone_Contested", "dlc_vw_koth_Sounds", false},
    {"Zone_Enemy_Capture", "dlc_vw_koth_Sounds", false},
    {"Zone_Enter", "dlc_vw_koth_Sounds", false},
    {"Zone_Held", "dlc_vw_koth_Sounds", false},
    {"Zone_Lost", "dlc_vw_koth_Sounds", false},
    {"Zoom_In", "DLC_HEIST_PLANNING_BOARD_SOUNDS", true},
    {"Zoom_Left", "DLC_HEIST_PLANNING_BOARD_SOUNDS", true},
    {"Zoom_Out", "DLC_HEIST_PLANNING_BOARD_SOUNDS", true},
    {"Zoom_Right", "DLC_HEIST_PLANNING_BOARD_SOUNDS", true},
    {"Off", "GTAO_Vision_Modes_SoundSet", false},
    {"Off", "GTAO_Vision_Modes_SoundSet", true},
    {"On", "GTAO_Vision_Modes_SoundSet", false},
    {"On", "GTAO_Vision_Modes_SoundSet", true},
    {"Switch", "GTAO_Vision_Modes_SoundSet", false},
    {"Switch", "GTAO_Vision_Modes_SoundSet", true},
    {"hangar_doors_loop", "dlc_xm_facility_entry_exit_sounds", true},
    {"elevator_descend_loop", "dlc_xm_facility_entry_exit_sounds", true},
    {"launch_power_up_loop", "dlc_xm_silo_finale_sounds", true},
    {"10S", "MP_MISSION_COUNTDOWN_SOUNDSET", false},
    {"Crates_Blipped", "GTAO_Biker_Modes_Soundset", false},
    {"Enemy_In_Zone", "DLC_Biker_SYG_Sounds", true},
    {"Background", "MP_CCTV_SOUNDSET", false},
    {"Pan", "MP_CCTV_SOUNDSET", false},
    {"Zoom", "MP_CCTV_SOUNDSET", false},
    {"Change_Cam", "MP_CCTV_SOUNDSET", false},
    {"elevator_descend_loop", "dlc_xm_IAA_Finale_sounds", true},
    {"Elevation_Loop", "DLC_Dmod_Prop_Editor_Sounds", false},
    {"Move_Loop", "DLC_Dmod_Prop_Editor_Sounds", false},
    {"Rotate_Loop", "DLC_Dmod_Prop_Editor_Sounds", false},
    {"Boss_Message_Orange", "GTAO_Biker_FM_Soundset", false},
    {"Crates_Blipped", "GTAO_Biker_Modes_Soundset", false},
    {"Drone_View", "DLC_GR_WVM_APC_Sounds", true},
    {"CLOSING", "MP_PROPERTIES_ELEVATOR_DOORS", true},
    {"OPENING", "MP_PROPERTIES_ELEVATOR_DOORS", true},
    {"laptop_download", "dlc_vw_heisters_sounds", true},
    {"HACKING_COUNTDOWN_IP_FIND", 0, true},
    {"HACKING_COUNTDOWN_CRACK_PASS", 0, true},
    {"Pin_Movement", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true},
    {"HACKING_COUNTDOWN_IP_FIND", 0, true},
    {"HACKING_COUNTDOWN_CRACK_PASS", 0, true},
    {"1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true},
    {"Hit_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true},
    {"HIT_OUT", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true},
    {"TIME_LAPSE_MASTER", 0, true},
    {"Short_Transition_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true},
    {"Pin_Movement", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true},
    {"HACKING_COUNTDOWN_IP_FIND", 0, true},
    {"HACKING_COUNTDOWN_CRACK_PASS", 0, true},
    {"OPENED", "DOOR_GARAGE", false},
    {"OPENING", "DOOR_GARAGE", false},
    {"Pin_Movement", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true},
    {"Rappel_Loop", "GTAO_Rappel_Sounds", true},
    {"Change_Cam", "MP_CCTV_SOUNDSET", true},
    {"DOOR_BUZZ", "MP_PLAYER_APARTMENT", true},
    {"Pan", "MP_CCTV_SOUNDSET", true},
    {"Zoom", "MP_CCTV_SOUNDSET", true},
    {"Background", "MP_CCTV_SOUNDSET", true},
    {"Change_Cam", "MP_CCTV_SOUNDSET", true},
    {"uw_ambience", 0, true},
    {"OOB_Timer_Dynamic", "GTAO_FM_Events_Soundset", false},
    {"Pin_Movement", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true},
    {"Signal_Loop", "DLC_H3_Tracker_App_Sounds", true},
    {"Pin_Movement", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true},
    {"Pin_Movement", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true},
    {"Fly_Loop", "dlc_xm_avngr_sounds", true},
    {"Hack_Loop", "dlc_xm_deluxos_hacking_Hacking_Sounds", true},
    {"Background_Hum", "DLC_XM_Vehicle_Interior_Security_Camera_Sounds", true},
    {"laptop_download_loop", "dlc_xm_heists_iaa_morgue_sounds", true},
    {"Out_of_Bounds", "MP_MISSION_COUNTDOWN_SOUNDSET", false},
    {"Hack_Loop", "DLC_IE_SVM_Voltic2_Hacking_Sounds", true},
    {"Change_Station_Loud", "Radio_Soundset", true},
    {"OOB_Timer_Dynamic", "GTAO_FM_Events_Soundset", false},
    {"EMP", "DLC_HALLOWEEN_FVJ_Sounds", false},
    {"EMP_Blast", "DLC_HEISTS_BIOLAB_FINALE_SOUNDS", false},
    {"10S", "MP_MISSION_COUNTDOWN_SOUNDSET", false},
    {"5S", "MP_MISSION_COUNTDOWN_SOUNDSET", false},
    {"Timer_10s", "DLC_TG_Dinner_Sounds", false},
    {"Timer_5s", "DLC_TG_Dinner_Sounds", false},
    {"Timer_To_Day", "DLC_Biker_LostAndDamned_Sounds", false},
    {"Timer_To_Night", "DLC_Biker_LostAndDamned_Sounds", false},
    {"Arming_Countdown", "GTAO_Speed_Convoy_Soundset", false},
    {"Slipstream_Follower", "DLC_Biker_SL_Sounds", false},
    {"SLIPSTREAM_MASTER", 0, false},
    {"Slipstream_Leader", "DLC_Biker_SL_Sounds", false},
    {"SLIPSTREAM_MASTER", 0, true},
    {"Get_Back_In_Vehicle", "MP_MISSION_COUNTDOWN_SOUNDSET", false},
    {"UW_Ambience", 0, true},
    {"Short_Transition_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true},
    {"Altitude_Warning", "EXILE_1", true},
    {"Near_Miss_Counter", "GTAO_FM_Events_Soundset", false},
    {"FBI_04_HEAT_C4_DOORS", 0, true},
    {"Out_of_Bounds", "MP_MISSION_COUNTDOWN_SOUNDSET", false},
    {"Camera_Hum", "BIG_SCORE_SETUP_SOUNDS", true},
    {"Camera_Zoom", "BIG_SCORE_SETUP_SOUNDS", true},
    {"10S", "MP_MISSION_COUNTDOWN_SOUNDSET", false},
    {"5S", "MP_MISSION_COUNTDOWN_SOUNDSET", false},
    {"Carrying", "DLC_Low2_Ibi_Sounds", false},
    {"All", "SHORT_PLAYER_SWITCH_SOUND_SET", true},
    {"Heli_Crash", "FBI_HEIST_FINALE_CHOPPER", true},
    {"Found_Target", "POLICE_CHOPPER_CAM_SOUNDS", true},
    {"Lost_Target", "POLICE_CHOPPER_CAM_SOUNDS", true},
    {"Microphone", "POLICE_CHOPPER_CAM_SOUNDS", true},
    {"Carrying", "DLC_Low2_Ibi_Sounds", false},
    {"Out_of_Bounds", "MP_MISSION_COUNTDOWN_SOUNDSET", false},
    {"Drone_View", "DLC_GR_WVM_APC_Sounds", true},
    {"OOB_Timer_Dynamic", "GTAO_FM_Events_Soundset", false},
    {"DOOR_BUZZ", "MP_PLAYER_APARTMENT", true},
    {"DOOR_Intercom_MASTER", 0, true},
    {"10s", "MP_MISSION_COUNTDOWN_SOUNDSET", false},
    {"Pickup_Briefcase", "GTAO_Biker_Modes_Soundset", false},
    {"Pickup_Briefcase", "GTAO_Magnate_Boss_Modes_Soundset", false},
    {"PICKUP_WEAPON_BALL", "HUD_FRONTEND_WEAPONS_PICKUPS_SOUNDSET", true},
    {"Countdown_To_Win", "DLC_IE_PL_Player_Sounds", false},
    {"Countdown_To_Win", "DLC_IE_PL_Team_Sounds", false},
    {"laptop_download_loop", "dlc_xm_heists_iaa_morgue_sounds", true},
    {"Hack_Loop", "DLC_IE_SVM_Voltic2_Hacking_Sounds", true},
    {"Hack_Loop", "dlc_xm_deluxos_hacking_Hacking_Sounds", true},
    {"HACKING_COUNTDOWN_IP_FIND", 0, true},
    {"HACKING_COUNTDOWN_CRACK_PASS", 0, true},
    {"Last_Alive", "DLC_SR_RS_Player_Sounds", true},
    {"Condemned_Heartbeat", "DLC_SM_CND_Player_Sounds", true},
    {"Pin_Movement", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true},
    {"10s", "MP_MISSION_COUNTDOWN_SOUNDSET", false},
    {"Elevator_Doors_Closing_Loop", "DLC_IE_Garage_Elevator_Sounds", true},
    {"Elevator_Doors_Opening_Loop", "DLC_IE_Garage_Elevator_Sounds", true},
    {"Garage_Door_Close_Loop", "GTAO_Script_Doors_Sounds", true},
    {"Garage_Door_Open_Loop", "GTAO_Script_Doors_Sounds", true},
    {"Speech_Going_Up", "DLC_IE_Garage_Elevator_Sounds", true},
    {"Background_Loop", "CB_RADIO_SFX", true},
    {"Change_Cam", "MP_CCTV_SOUNDSET", true},
    {"Generic_Alarm_Electronic_01", 0, true},
    {"HACKING_COUNTDOWN_IP_FIND", 0, true},
    {"HACKING_COUNTDOWN_CRACK_PASS", 0, true},
    {"UW_Ambience", 0, true},
    {"UW_Rebreather", 0, true},
    {"FBI_05_RAID_BREATH", 0, true},
    {"Short_Transition_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true},
    {"Short_Transition_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true},
    {"FBI_02_SNATCH_AND_GRAB_AMB_HELI", 0, true},
    {"Short_Transition_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true},
    {"Background", "MP_CCTV_SOUNDSET", false},
    {"Pan", "MP_CCTV_SOUNDSET", false},
    {"Zoom", "MP_CCTV_SOUNDSET", false},
    {"Change_Cam", "MP_CCTV_SOUNDSET", false},
    {"elevator_descend_loop", "dlc_xm_IAA_Finale_sounds", true},
    {"Out_of_Bounds", "MP_MISSION_COUNTDOWN_SOUNDSET", false},
    {"Out_of_Bounds_Explode", "MP_MISSION_COUNTDOWN_SOUNDSET", false},
    {"Hit_Out", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true},
    {"Short_Transition_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true},
    {"HACKING_COUNTDOWN_IP_FIND", 0, true},
    {"HACKING_COUNTDOWN_CRACK_PASS", 0, true},
    {"Altitude_Warning", "EXILE_1", true},
    {"Generic_Alarm_Fire_Electronic", 0, true},
    {"Background", "DLC_XM17_Facility_Strike_PC_Sounds", true},
    {"CHOP_CAM_A", 0, true},
    {"CHOP_CAM_B", 0, true},
    {"CHOP_CAM_C", 0, true},
    {"Pan", "MP_CCTV_SOUNDSET", true},
    {"HACKING_MOVE_CURSOR", 0, true},
    {"Zoom", "MP_CCTV_SOUNDSET", true},
    {"Change_Cam", "MP_CCTV_SOUNDSET", true},
    {"SAFE_DOOR_CLOSE", "SAFE_CRACK_SOUNDSET", true},
    {"SAFE_DOOR_OPEN", "SAFE_CRACK_SOUNDSET", true},
    {"TUMBLER_PIN_FALL", "SAFE_CRACK_SOUNDSET", true},
    {"TUMBLER_PIN_FALL_FINAL", "SAFE_CRACK_SOUNDSET", true},
    {"TUMBLER_RESET", "SAFE_CRACK_SOUNDSET", true},
    {"TUMBLER_TURN", "SAFE_CRACK_SOUNDSET", true},
    {"Background", "MP_CCTV_SOUNDSET", true},
    {"Background", "MP_CCTV_SOUNDSET", true},
    {"Change_Cam", "MP_CCTV_SOUNDSET", true},
    {"elevator_ascend_loop", "dlc_xm_facility_entry_exit_sounds", true},
    {"hangar_doors_loop", "dlc_xm_facility_entry_exit_sounds", true},
    {"CHECKPOINT_UNDER_THE_BRIDGE", "HUD_MINI_GAME_SOUNDSET", true},
    {"COLLECTED", "HUD_AWARDS", true},
    {"Exit_In_Vehicle", "GTAO_ImpExp_Enter_Exit_Garage_Sounds", true},
    {"Garage_Door_Close", "GTAO_Script_Doors_Faded_Screen_Sounds", true},
    {"GARAGE_DOOR_SCRIPTED_CLOSE", 0, true},
    {"GARAGE_DOOR_SCRIPTED_OPEN", 0, true},
    {"PEYOTE_COMPLETED", "HUD_AWARDS", true},
    {"SIGN_DESTROYED", "HUD_AWARDS", true},
    {"Lose_1st", "GTAO_Magnate_Boss_Modes_Soundset", false},
    {"Goon_Paid_Large", "GTAO_Boss_Goons_FM_Soundset", false},
    {"Enter_1st", "GTAO_Magnate_Boss_Modes_Soundset", false},
    {"COP_HELI_CAM_ZOOM", 0, true},
    {"COP_HELI_CAM_TURN", 0, true},
    {"Remote_Enemy_Enter_Line", "GTAO_FM_Cross_The_Line_Soundset", false},
    {"Remote_Friendly_Enter_Line", "GTAO_FM_Cross_The_Line_Soundset", false},
    {"COP_HELI_CAM_ZOOM", 0, true},
    {"COP_HELI_CAM_TURN", 0, true},
    {"Background", "dlc_xm_silo_laser_hack_sounds", true},
    {"Cursor_Move", "dlc_xm_silo_laser_hack_sounds", true},
    {"Blue_Target_Charge", "dlc_xm_silo_laser_hack_sounds", true},
    {"Red_Target_Charge", "dlc_xm_silo_laser_hack_sounds", true},
    {"Rotate_Mirror", "dlc_xm_silo_laser_hack_sounds", true},
    {"VULKAN_LOCK_ON_AMBER", 0, true},
    {"VULKAN_LOCK_ON_RED", 0, true},
    {"Turret_Camera_Hum_Loop", "DLC_BTL_Terrobyte_Turret_Sounds", true},
    {"Background", "dlc_xm_silo_laser_hack_sounds", true},
    {"Cursor_Move", "dlc_xm_silo_laser_hack_sounds", true},
    {"Blue_Target_Charge", "dlc_xm_silo_laser_hack_sounds", true},
    {"Red_Target_Charge", "dlc_xm_silo_laser_hack_sounds", true},
    {"Rotate_Mirror", "dlc_xm_silo_laser_hack_sounds", true},
    {"Pan", "MP_CCTV_SOUNDSET", true},
    {"Zoom", "MP_CCTV_SOUNDSET", true},
    {"Change_Cam", "MP_CCTV_SOUNDSET", true},
    {"Background", "MP_CCTV_SOUNDSET", true},
    {"LIMIT", "GTAO_APT_DOOR_DOWNSTAIRS_GENERIC_SOUNDS", true},
    {"LIMIT", "GTAO_APT_DOOR_DOWNSTAIRS_GLASS_SOUNDS", true},
    {"LIMIT", "GTAO_APT_DOOR_DOWNSTAIRS_WOOD_SOUNDS", true},
    {"LIMIT", "GTAO_APT_DOOR_ROOF_METAL_SOUNDS", true},
    {"PUSH", "GTAO_APT_DOOR_DOWNSTAIRS_GENERIC_SOUNDS", true},
    {"PUSH", "GTAO_APT_DOOR_DOWNSTAIRS_GLASS_SOUNDS", true},
    {"PUSH", "GTAO_APT_DOOR_DOWNSTAIRS_WOOD_SOUNDS", true},
    {"PUSH", "GTAO_APT_DOOR_ROOF_METAL_SOUNDS", true},
    {"WOODEN_DOOR_OPEN_NO_HANDLE_AT", 0, true},
    {"Altitude_Warning_Loop", "DLC_Exec_Fly_Low_Sounds", true},
    {"LIMIT", "DLC_APT_YACHT_DOOR_SOUNDS", true},
    {"LIMIT", "GTAO_APT_DOOR_DOWNSTAIRS_GLASS_SOUNDS", true},
    {"PUSH", "DLC_APT_YACHT_DOOR_SOUNDS", true},
    {"PUSH", "GTAO_APT_DOOR_DOWNSTAIRS_GLASS_SOUNDS", true},
    {"WOODEN_DOOR_OPEN_NO_HANDLE_AT", 0, true},
    {"Scanner_Loop", "DLC_BTL_Target_Pursuit_Sounds", true},
    {"Delivery_Screen_Fade", "DLC_Exec1_Buy_Sell_Sounds", false},
    {"Delivery_Screen_Fade_On_Foot", "DLC_Exec1_Buy_Sell_Sounds", false},
    {"TRAFFIC_CONTROL_BG_NOISE", "BIG_SCORE_3A_SOUNDS", true},
    {"TRAFFIC_CONTROL_CHANGE_CAM", "BIG_SCORE_3A_SOUNDS", true},
    {"TRAFFIC_CONTROL_TOGGLE_LIGHT", "BIG_SCORE_3A_SOUNDS", true},
    {"DISTANT_DOG_BARK", "CAR_STEAL_2_SOUNDSET", true},
    {"Elevator_Start", "DLC_IE_Garage_Elevator_Sounds", true},
    {"Elevator_Stop", "DLC_IE_Garage_Elevator_Sounds", true},
    {"Elevator_Ascending_Loop", "DLC_IE_Garage_Elevator_Sounds", true},
    {"Elevator_Descending_Loop", "DLC_IE_Garage_Elevator_Sounds", true},
    {"Speech_Floor_1", "DLC_IE_Garage_Elevator_Sounds", true},
    {"Speech_Floor_2", "DLC_IE_Garage_Elevator_Sounds", true},
    {"Speech_Floor_3", "DLC_IE_Garage_Elevator_Sounds", true},
    {"movie_prop_reward_cut_music", "DLC_sum20_hidden_collectible_sounds", true},
    {"VULKAN_LOCK_ON_AMBER", 0, true},
    {"VULKAN_LOCK_ON_RED", 0, true},
    {"Pan", "DLC_Arena_CCTV_SOUNDSET", true},
    {"Pan", "MP_CCTV_SOUNDSET", true},
    {"Blip_Pickup", "GTAO_Biker_Modes_Soundset", false},
    {"Enemy_Pickup_Briefcase", "GTAO_Biker_Modes_Soundset", false},
    {"pan_loop", "dlc_xm_orbital_cannon_sounds", true},
    {"Pickup_Briefcase", "GTAO_Biker_Modes_Soundset", false},
    {"Hit_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true},
    {"Camera_Move_Loop", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true},
    {"Hit_Out", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true},
    {"Background", "DLC_HEIST_HACKING_SNAKE_SOUNDS", true},
    {"cannon_activating_loop", "dlc_xm_orbital_cannon_sounds", true},
    {"cannon_charge_fire_loop", "dlc_xm_orbital_cannon_sounds", true},
    {"Change_Cam", "DLC_Arena_CCTV_SOUNDSET", true},
    {"Change_Cam", "MP_CCTV_SOUNDSET", true},
    {"Deliver_Item", "GTAO_Biker_Modes_Soundset", false},
    {"Background", "DLC_Arena_CCTV_SOUNDSET", true},
    {"Background", "MP_CCTV_SOUNDSET", true},
    {"background_loop", "dlc_xm_orbital_cannon_sounds", true},
    {"Change_Cam", "MP_CCTV_SOUNDSET", true},
    {"zoom_out_loop", "dlc_xm_orbital_cannon_sounds", true},
    {"zoom_out_loop", "dlc_xm_orbital_cannon_sounds", true},
    {"Trail_Custom", "DLC_HEIST_HACKING_SNAKE_SOUNDS", true},
    {"Scanner_Loop", "DLC_BTL_Target_Pursuit_Sounds", true},
    {"pan_loop", "dlc_xm_orbital_cannon_sounds", true},
    {"cannon_activating_loop", "dlc_xm_orbital_cannon_sounds", true},
    {"background_loop", "dlc_xm_orbital_cannon_sounds", true},
    {"Background", "DLC_EXEC_ARC_MAC_SOUNDS", true},
    {"zoom_out_loop", "dlc_xm_orbital_cannon_sounds", true},
    {"zoom_out_loop", "dlc_xm_orbital_cannon_sounds", true},
    {"Creaking_Loop", "DLC_H4_Submarine_Crush_Depth_Sounds", true},
    {"Warning_Alarm_Loop", "DLC_H4_Submarine_Crush_Depth_Sounds", true},
    {"Knuckle_Crack_Hard_Cel", "MP_SNACKS_SOUNDSET", true},
    {"Knuckle_Crack_Slap_Cel", "MP_SNACKS_SOUNDSET", true},
    {"Slow_Clap_Cel", "MP_SNACKS_SOUNDSET", true},
    {"COP_HELI_CAM_ZOOM", 0, true},
    {"COP_HELI_CAM_TURN", 0, true},
    {"COP_HELI_CAM_BLEEP", 0, true},
    {"COP_HELI_CAM_BACKGROUND", 0, true},
    {"COP_HELI_CAM_SCAN_PED_LOOP", 0, true},
    {"COP_HELI_CAM_SCAN_PED_SUCCESS", 0, true},
    {"COP_HELI_CAM_SCAN_PED_FAILURE", 0, true},
    {"COP_HELI_CAM_BLEEP_TOO_FAR", 0, true},
    {"Cancel", "DLC_EXEC_ARC_MAC_SOUNDS", true},
    {"cannon_charge_fire_loop", "dlc_xm_orbital_cannon_sounds", true},
    {"Insert_Coin", "DLC_EXEC_ARC_MAC_SOUNDS", true},
    {"Out_of_Bounds_Explode", "MP_MISSION_COUNTDOWN_SOUNDSET", false},
    {"Game_Over_Blink", "DLC_EXEC_ARC_MAC_SOUNDS", true},
    {"Nightvision_Loop", "GTAO_Vision_Modes_SoundSet", false},
    {"player_riding", "biker_formation_sounds", true},
    {"Thermal_Loop", "GTAO_Vision_Modes_SoundSet", false},
    {"Sink", "DLC_H4_Submarine_Sinking_Sounds", true},
    {"Return_To_Vehicle_Timer", "GTAO_FM_Events_Soundset", false},
    {"Slipstream", "DLC_Stunt_Race_Frontend_Sounds", true},
    {"Slipstream_Follower", "DLC_Biker_SL_Sounds", true},
    {"SLIPSTREAM_MASTER", 0, true},
    {"Slipstream_Leader", "DLC_Biker_SL_Sounds", true},
    {"Bomb_Countdown", "DLC_AW_PTB_Sounds", true},
    {"TIME_LAPSE_MASTER", 0, true}
}
local FastRun = false
local function k(l)
    local m = {}
    local n = GetGameTimer() / 200
    m.r = math.floor(math.sin(n * l + 0) * 127 + 128)
    m.g = math.floor(math.sin(n * l + 2) * 127 + 128)
    m.b = math.floor(math.sin(n * l + 4) * 127 + 128)
    return m
end

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('DEVMENU', 'main')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.Button("Create Test ped Female",nil,{},true,function(r, s, t)
                    if t then
                        local A = loadModel("a_f_m_beach_01")
                        local B = getPlayerCoords()
                        CreatePed(1, A, B.x, B.y, B.z, 0.0, true, true)
                    end
                end)
            RageUI.Button("Create Test ped Male",nil,{},true,function(r, s, t)
                    if t then
                        local A = loadModel("s_m_m_pilot_02")
                        local B = getPlayerCoords()
                        CreatePed(1, A, B.x, B.y, B.z, 0.0, true, true)
                    end
                end)
            RageUI.Button("Native Sounds",nil,{RightLabel="→→→"},true,function(Hovered, Active, Selected) 
            end,RMenu:Get('DEVMENU','NativeSounds'))
            RageUI.Button("Cardev Menu",nil,{RightLabel="→→→"},true,function(Hovered, Active, Selected) 
                if Selected then
                    tAQUA.openCarDev()
                end
            end)
            RageUI.Button("Cheats",nil,{RightLabel="→→→"},true,function(Hovered, Active, Selected) 
            end,RMenu:Get('DEVMENU','cheatos'))
            RageUI.Checkbox("Debug", "", Debugchecked, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
                if (Selected) then
                    Debugchecked = not Debugchecked
                    if Checked then
                        a = true
                    else
                        a = false
                    end
                end
            end)
        end)
    end
end)
RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('DEVMENU', 'cheatos')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
                RageUI.Checkbox("ESP","Buggy But better than 0", MagicChecked, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
                    if (Selected) then
                        MagicChecked = not MagicChecked
                        if Checked then
                            pwz = true
                        else
                            pwz = false
                        end
                    end
                end)
            RageUI.Checkbox("Fast Run", "", FastRunChecked, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
                if (Selected) then
                    FastRunChecked = not FastRunChecked
                    if Checked then
                        FastRun = true
                    else
                        FastRun = false
                    end
                end
            end)
            RageUI.Checkbox("Super Jump", "", SuperJumpChecked, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
                if (Selected) then
                    SuperJumpChecked = not SuperJumpChecked
                    if Checked then
                        SuperJump = true
                    else
                        SuperJump = false
                    end
                end
            end)
            RageUI.Checkbox("Thermal Vision", "", ThermalChecked, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
                if (Selected) then
                    ThermalChecked = not ThermalChecked
                    if Checked then
                        SetSeethrough(true)
                    else
                        SetSeethrough(false)
                    end
                end
            end)
            RageUI.Checkbox("Rainbow Vehicle", "", RainbowVehChecked, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
                if (Selected) then
                    RainbowVehChecked = not RainbowVehChecked
                    if Checked then
                        RainbowVeh = true
                    else
                        RainbowVeh = false
                    end
                end
            end)
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('DEVMENU', 'NativeSounds')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            for G, H in pairs(g) do
                RageUI.ButtonWithStyle(H[1],H[2],{},true,function(r, s, t)
                        if t then
                            StopSound(i)
                            ReleaseSoundId(i)
                            i = GetSoundId()
                            PlaySoundFrontend(i, H[1], H[2], H[3])
                        end
                    end)
            end
        end)
    end
end)

RegisterCommand('devmenu', function()
    TriggerServerEvent('AQUA:opendevmenu')
end)

function tAQUA.opendevelopermenu()
    RageUI.Visible(RMenu:Get('DEVMENU', 'main'), not RageUI.Visible(RMenu:Get('DEVMENU', 'main')))
end

local function ab(ac, X, Y)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(0.0, 0.4)
    SetTextDropshadow(1, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(ac)
    DrawText(X, Y)
end
local function d(e)
    local f = {}
    local h = GetGameTimer() / 200
    f.r = math.floor(math.sin(h * e + 0) * 127 + 128)
    f.g = math.floor(math.sin(h * e + 2) * 127 + 128)
    f.b = math.floor(math.sin(h * e + 4) * 127 + 128)
    return f
end
function DrawText3D(x,y,z, text, r,g,b)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local dist = #(vector3(px,py,pz)-vector3(x,y,z))
  
	local scale = (1/dist)*1.6
	local fov = (1/GetGameplayCamFov())*100
	local scale = scale*fov
  
	if onScreen then
		if not useCustomScale then
			SetTextScale(0.0*scale, 0.55*scale)
		else
			SetTextScale(0.0*scale, customScale)
		end
		SetTextFont(0)
		SetTextProportional(1)
		SetTextColour(r, g, b, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
	end
  end
Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if pwz then
                drawNativeText("~b~ESP Enabled", 255, 0, 0, 255, true)
                for i = 0, 128 do
                    if i ~= PlayerId(-1) and GetPlayerServerId(i) ~= 0 then
                        local a5 = d(1.0)
                        local cC = GetPlayerPed(i)
                        local cD, cE, cF = table.unpack(GetEntityCoords(PlayerPedId(-1)))
                        local x, y, z = table.unpack(GetEntityCoords(cC)) 
                        local cG = GetPlayerName(i) ..'\nDist: ' .. math.round(GetDistanceBetweenCoords(cD, cE, cF, x, y, z, true) .. "\nHealth:" .. GetEntityHealth(cC) .. "\nArmour:" .. GetPedArmour(cC), 1)
                        if IsPedInAnyVehicle(cC, true) then
                            local cH = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(cC))))
                            cG = cG .. '\nVeh: ' .. cH
                        end
                        DrawText3D(x, y, z - 1.0, cG, a5.r, a5.g, a5.b)
                        LineOneBegin = GetOffsetFromEntityInWorldCoords(cC, -0.3, -0.3, -0.9)
                        LineOneEnd = GetOffsetFromEntityInWorldCoords(cC, 0.3, -0.3, -0.9)
                        LineTwoBegin = GetOffsetFromEntityInWorldCoords(cC, 0.3, -0.3, -0.9)
                        LineTwoEnd = GetOffsetFromEntityInWorldCoords(cC, 0.3, 0.3, -0.9)
                        LineThreeBegin = GetOffsetFromEntityInWorldCoords(cC, 0.3, 0.3, -0.9)
                        LineThreeEnd = GetOffsetFromEntityInWorldCoords(cC, -0.3, 0.3, -0.9)
                        LineFourBegin = GetOffsetFromEntityInWorldCoords(cC, -0.3, -0.3, -0.9)
                        TLineOneBegin = GetOffsetFromEntityInWorldCoords(cC, -0.3, -0.3, 0.8)
                        TLineOneEnd = GetOffsetFromEntityInWorldCoords(cC, 0.3, -0.3, 0.8)
                        TLineTwoBegin = GetOffsetFromEntityInWorldCoords(cC, 0.3, -0.3, 0.8)
                        TLineTwoEnd = GetOffsetFromEntityInWorldCoords(cC, 0.3, 0.3, 0.8)
                        TLineThreeBegin = GetOffsetFromEntityInWorldCoords(cC, 0.3, 0.3, 0.8)
                        TLineThreeEnd = GetOffsetFromEntityInWorldCoords(cC, -0.3, 0.3, 0.8)
                        TLineFourBegin = GetOffsetFromEntityInWorldCoords(cC, -0.3, -0.3, 0.8)
                        ConnectorOneBegin = GetOffsetFromEntityInWorldCoords(cC, -0.3, 0.3, 0.8)
                        ConnectorOneEnd = GetOffsetFromEntityInWorldCoords(cC, -0.3, 0.3, -0.9)
                        ConnectorTwoBegin = GetOffsetFromEntityInWorldCoords(cC, 0.3, 0.3, 0.8)
                        ConnectorTwoEnd = GetOffsetFromEntityInWorldCoords(cC, 0.3, 0.3, -0.9)
                        ConnectorThreeBegin = GetOffsetFromEntityInWorldCoords(cC, -0.3, -0.3, 0.8)
                        ConnectorThreeEnd = GetOffsetFromEntityInWorldCoords(cC, -0.3, -0.3, -0.9)
                        ConnectorFourBegin = GetOffsetFromEntityInWorldCoords(cC, 0.3, -0.3, 0.8)
                        ConnectorFourEnd = GetOffsetFromEntityInWorldCoords(cC, 0.3, -0.3, -0.9)
                        DrawLine(LineOneBegin.x,LineOneBegin.y,LineOneBegin.z,LineOneEnd.x,LineOneEnd.y,LineOneEnd.z,a5.r,a5.g,a5.b,255)
                        DrawLine(LineTwoBegin.x,LineTwoBegin.y,LineTwoBegin.z,LineTwoEnd.x,LineTwoEnd.y,LineTwoEnd.z,a5.r,a5.g,a5.b,255)
                        DrawLine(LineThreeBegin.x,LineThreeBegin.y,LineThreeBegin.z,LineThreeEnd.x,LineThreeEnd.y,LineThreeEnd.z,a5.r,a5.g,a5.b,255)
                        DrawLine(LineThreeEnd.x,LineThreeEnd.y,LineThreeEnd.z,LineFourBegin.x,LineFourBegin.y,LineFourBegin.z,a5.r,a5.g,a5.b,255)
                        DrawLine(TLineOneBegin.x,TLineOneBegin.y,TLineOneBegin.z,TLineOneEnd.x,TLineOneEnd.y,TLineOneEnd.z,a5.r,a5.g,a5.b,255)
                        DrawLine(TLineTwoBegin.x,TLineTwoBegin.y,TLineTwoBegin.z,TLineTwoEnd.x,TLineTwoEnd.y,TLineTwoEnd.z,a5.r,a5.g,a5.b,255)
                        DrawLine(TLineThreeBegin.x,TLineThreeBegin.y,TLineThreeBegin.z,TLineThreeEnd.x,TLineThreeEnd.y,TLineThreeEnd.z,a5.r,a5.g,a5.b,255)
                        DrawLine(TLineThreeEnd.x,TLineThreeEnd.y,TLineThreeEnd.z,TLineFourBegin.x,TLineFourBegin.y,TLineFourBegin.z,a5.r,a5.g,a5.b,255)
                        DrawLine(ConnectorOneBegin.x,ConnectorOneBegin.y,ConnectorOneBegin.z,ConnectorOneEnd.x,ConnectorOneEnd.y,ConnectorOneEnd.z,a5.r,a5.g,a5.b,255)
                        DrawLine(ConnectorTwoBegin.x,ConnectorTwoBegin.y,ConnectorTwoBegin.z,ConnectorTwoEnd.x,ConnectorTwoEnd.y,ConnectorTwoEnd.z,a5.r,a5.g,a5.b,255)
                        DrawLine(ConnectorThreeBegin.x,ConnectorThreeBegin.y,ConnectorThreeBegin.z,ConnectorThreeEnd.x,ConnectorThreeEnd.y,ConnectorThreeEnd.z,a5.r,a5.g,a5.b,255)
                        DrawLine(ConnectorFourBegin.x,ConnectorFourBegin.y,ConnectorFourBegin.z,ConnectorFourEnd.x,ConnectorFourEnd.y,ConnectorFourEnd.z,a5.r,a5.g,a5.b,255)
                        DrawLine(cD, cE, cF, x, y, z, a5.r, a5.g, a5.b, 255)
                    end
                end
            end
            if a then
                local ad = IsPedInAnyVehicle(PlayerPedId()) and GetVehiclePedIsIn(PlayerPedId(), false) or PlayerPedId()
                local X, Y, Z = table.unpack(GetEntityCoords(ad, true))
                roundx = tonumber(string.format("%.2f", X))
                roundy = tonumber(string.format("%.2f", Y))
                roundz = tonumber(string.format("%.2f", Z))
                ab("~d~X:~s~ " .. roundx, 0.32, 0.00)
                ab("~d~Y:~s~ " .. roundy, 0.38, 0.00)
                ab("~d~Z:~s~ " .. roundz, 0.445, 0.00)
                heading = GetEntityHeading(ad)
                roundh = tonumber(string.format("%.2f", heading))
                ab("~d~H:~s~ " .. roundh, 0.50, 0.00)
                local ae, af, ag = table.unpack(GetEntityRotation(PlayerPedId(), 1))
                ab("~d~RX:~s~ " .. tonumber(string.format("%.2f", ae)), 0.38, 0.03)
                ab("~d~RY:~s~ " .. tonumber(string.format("%.2f", af)), 0.44, 0.03)
                ab("~d~RZ:~s~ " .. tonumber(string.format("%.2f", ag)), 0.495, 0.03)
                speed = GetEntitySpeed(PlayerPedId())
                rounds = tonumber(string.format("%.2f", speed))
                ab("~d~Player Speed: ~s~" .. rounds, 0.40, 0.92)
                health = GetEntityHealth(PlayerPedId())
                ab("~d~Player Health: ~s~" .. health, 0.40, 0.95)
                camRotX = GetGameplayCamRot().x
                ab("~d~CR X: ~s~" .. tonumber(string.format("%.2f", camRotX)), 0.36, 0.88)
                camRotY = GetGameplayCamRot().y
                ab("~d~CR Y: ~s~" .. tonumber(string.format("%.2f", camRotY)), 0.44, 0.88)
                camRotZ = GetGameplayCamRot().z
                ab("~d~CR Z: ~s~" .. tonumber(string.format("%.2f", camRotZ)), 0.51, 0.88)
                veheng = GetVehicleEngineHealth(GetVehiclePedIsUsing(PlayerPedId()))
                vehbody = GetVehicleBodyHealth(GetVehiclePedIsUsing(PlayerPedId()))
                if IsPedInAnyVehicle(PlayerPedId(), 1) then
                    vehenground = tonumber(string.format("%.2f", veheng))
                    vehbodround = tonumber(string.format("%.2f", vehbody))
                    ab("~d~Engine Health: ~s~" .. vehenground, 0.015, 0.76)
                    ab("~d~Body Health: ~s~" .. vehbodround, 0.015, 0.73)
                    ab("~d~Vehicle Fuel: ~s~" ..tonumber(string.format("%.2f", GetVehicleFuelLevel(GetVehiclePedIsUsing(PlayerPedId())))),0.015,0.70)
                end
            end
            if FastRun then
                SetRunSprintMultiplierForPlayer(PlayerId(-1), 2.49) 
                SetPedMoveRateOverride(GetPlayerPed(-1), 2.15)
            else
                SetRunSprintMultiplierForPlayer(PlayerId(-1), 1.0) 
                SetPedMoveRateOverride(GetPlayerPed(-1), 1.0)
            end
            if RainbowVeh then
                local dq = k(1.0)
                SetVehicleCustomPrimaryColour(GetVehiclePedIsUsing(PlayerPedId(-1)), dq.r, dq.g, dq.b)
                SetVehicleCustomSecondaryColour(GetVehiclePedIsUsing(PlayerPedId(-1)), dq.r, dq.g, dq.b)
            end
            if SuperJump then
                SetSuperJumpThisFrame(PlayerId())
            end
        end
    end)