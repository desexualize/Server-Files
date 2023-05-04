RMenu.Add("mainmenu","cinematic",RageUI.CreateMenu("", "", tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(), "new_editor", "r_editor_header"))
RMenu:Get("mainmenu", "cinematic"):SetSubtitle("~b~ARMA Cinematic Editor")
RMenu.Add("load_scene","cinematic",RageUI.CreateSubMenu(RMenu:Get("mainmenu", "cinematic"),"","",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight(),"new_editor","r_editor_header"))
RMenu:Get("load_scene", "cinematic"):SetSubtitle("~b~Load Scene")
RMenu.Add("scene_manager","cinematic",RageUI.CreateSubMenu(RMenu:Get("load_scene", "cinematic"),"","",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight(),"new_editor","r_editor_header"))
RMenu:Get("scene_manager", "cinematic"):SetSubtitle("~b~Scene Manager")
RMenu.Add("camera_manager","cinematic",RageUI.CreateSubMenu(RMenu:Get("scene_manager", "cinematic"),"","",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight(),"new_editor","r_editor_header"))
RMenu:Get("camera_manager", "cinematic"):SetSubtitle("~b~Camera Manager")
RMenu.Add("screeneffect_manager","cinematic",RageUI.CreateSubMenu(RMenu:Get("camera_manager", "cinematic"),"","",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight(),"new_editor","r_editor_header"))
RMenu:Get("screeneffect_manager", "cinematic"):SetSubtitle("~b~Screen Effect Manager")
RMenu.Add("timecycle_manager","cinematic",RageUI.CreateSubMenu(RMenu:Get("camera_manager", "cinematic"),"","",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight(),"new_editor","r_editor_header"))
RMenu:Get("timecycle_manager", "cinematic"):SetSubtitle("~b~Timecycle Effect Manager")
RMenu.Add("shake_manager","cinematic",RageUI.CreateSubMenu(RMenu:Get("camera_manager", "cinematic"),"","",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight(),"new_editor","r_editor_header"))
RMenu:Get("shake_manager", "cinematic"):SetSubtitle("~b~Shake Effect Manager")
RMenu.Add("add_camera","cinematic",RageUI.CreateSubMenu(RMenu:Get("camera_manager", "cinematic"),"","",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight(),"new_editor","r_editor_header"))
RMenu:Get("add_camera", "cinematic"):SetSubtitle("~b~Add Camera")
RMenu.Add("camera_focus_manager","cinematic",RageUI.CreateSubMenu(RMenu:Get("camera_manager", "cinematic"),"","",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight(),"new_editor","r_editor_header"))
RMenu:Get("camera_focus_manager", "cinematic"):SetSubtitle("~b~Camera Focus")
RMenu.Add("weather_time_manager","cinematic",RageUI.CreateSubMenu(RMenu:Get("mainmenu", "cinematic"),"","",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight(),"new_editor","r_editor_header"))
RMenu:Get("weather_time_manager", "cinematic"):SetSubtitle("~b~Time/Weather Manager")
RMenu.Add("dof_manager","cinematic",RageUI.CreateSubMenu(RMenu:Get("camera_manager", "cinematic"),"","",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight(),"new_editor","r_editor_header"))
RMenu:Get("dof_manager", "cinematic"):SetSubtitle("~b~Depth of Field Manager")

local function a(b)
    RageUI.ActuallyCloseAll()
    RageUI.Visible(RMenu:Get("mainmenu", "cinematic"), b)
end
local c = {
    "Default",
    "DeadlineNeon",
    "PPPurple",
    "PPOrange",
    "PPGreen",
    "InchPickup",
    "InchOrange",
    "MP_Bull_tost",
    "CrossLine",
    "ArenaWheelPurple",
    "SwitchHUDOut",
    "FocusIn",
    "FocusOut",
    "MinigameEndNeutral",
    "MinigameEndTrevor",
    "MinigameEndFranklin",
    "MinigameEndMichael",
    "MinigameTransitionOut",
    "MinigameTransitionIn",
    "SwitchShortNeutralIn",
    "SwitchShortFranklinIn",
    "SwitchShortTrevorIn",
    "SwitchShortMichaelIn",
    "SwitchOpenMichaelIn",
    "SwitchOpenFranklinIn",
    "SwitchOpenTrevorIn",
    "SwitchHUDMichaelOut",
    "SwitchHUDFranklinOut",
    "SwitchHUDTrevorOut",
    "SwitchShortFranklinMid",
    "SwitchShortMichaelMid",
    "SwitchShortTrevorMid",
    "DeathFailOut",
    "CamPushInNeutral",
    "CamPushInFranklin",
    "CamPushInMichael",
    "CamPushInTrevor",
    "SwitchOpenMichaelIn",
    "SwitchSceneFranklin",
    "SwitchSceneTrevor",
    "SwitchSceneMichael",
    "SwitchSceneNeutral",
    "MP_Celeb_Win",
    "MP_Celeb_Win_Out",
    "MP_Celeb_Lose",
    "MP_Celeb_Lose_Out",
    "DeathFailNeutralIn",
    "DeathFailMPDark",
    "DeathFailMPIn",
    "MP_Celeb_Preload_Fade",
    "PeyoteEndOut",
    "PeyoteEndIn",
    "PeyoteIn",
    "PeyoteOut",
    "MP_race_crash",
    "SuccessFranklin",
    "SuccessTrevor",
    "SuccessMichael",
    "DrugsMichaelAliensFightIn",
    "DrugsMichaelAliensFight",
    "DrugsMichaelAliensFightOut",
    "DrugsTrevorClownsFightIn",
    "DrugsTrevorClownsFight",
    "DrugsTrevorClownsFightOut",
    "HeistCelebPass",
    "HeistCelebPassBW",
    "HeistCelebEnd",
    "HeistCelebToast",
    "MenuMGHeistIn",
    "MenuMGTournamentIn",
    "MenuMGSelectionIn",
    "ChopVision",
    "DMT_flight_intro",
    "DMT_flight",
    "DrugsDrivingIn",
    "DrugsDrivingOut",
    "SwitchOpenNeutralFIB5",
    "HeistLocate",
    "MP_job_load",
    "RaceTurbo",
    "MP_intro_logo",
    "HeistTripSkipFade",
    "MenuMGHeistOut",
    "MP_corona_switch",
    "MenuMGSelectionTint",
    "SuccessNeutral",
    "ExplosionJosh3",
    "SniperOverlay",
    "RampageOut",
    "Rampage",
    "Dont_tazeme_bro",
    "DeathFailOut"
}
local d = {
    "None",
    "AP1_01_B_IntRefRange",
    "AP1_01_C_NoFog",
    "AirRaceBoost01",
    "AirRaceBoost02",
    "AmbientPUSH",
    "ArenaEMP",
    "ArenaEMP_Blend",
    "ArenaWheelPurple01",
    "ArenaWheelPurple02",
    "Bank_HLWD",
    "Barry1_Stoned",
    "BarryFadeOut",
    "BeastIntro01",
    "BeastIntro02",
    "BeastLaunch01",
    "BeastLaunch02",
    "BikerFilter",
    "BikerForm01",
    "BikerFormFlash",
    "Bikers",
    "BikersSPLASH",
    "BlackOut",
    "BleepYellow01",
    "BleepYellow02",
    "Bloom",
    "BloomLight",
    "BloomMid",
    "BombCam01",
    "BombCamFlash",
    "Broken_camera_fuzz",
    "BulletTimeDark",
    "BulletTimeLight",
    "CAMERA_BW",
    "CAMERA_secuirity",
    "CAMERA_secuirity_FUZZ",
    "CH3_06_water",
    "CHOP",
    "CS1_railwayB_tunnel",
    "CS3_rail_tunnel",
    "CUSTOM_streetlight",
    "Carpark_MP_exit",
    "CopsSPLASH",
    "CrossLine01",
    "CrossLine02",
    "DONT_overide_sunpos",
    "DRUG_2_drive",
    "DRUG_gas_huffin",
    "DeadlineNeon01",
    "DefaultColorCode",
    "Dont_tazeme_bro",
    "DrivingFocusDark",
    "DrivingFocusLight",
    "Drone_FishEye_Lens",
    "Drug_deadman",
    "Drug_deadman_blend",
    "Drunk",
    "EXTRA_bouncelight",
    "EXT_FULLAmbientmult_art",
    "ExplosionJosh",
    "FIB_5",
    "FIB_6",
    "FIB_A",
    "FIB_B",
    "FIB_interview",
    "FIB_interview_optimise",
    "FORdoron_delete",
    "FRANKLIN",
    "Facebook_NEW",
    "FinaleBank",
    "FinaleBankMid",
    "FinaleBankexit",
    "Forest",
    "FrankilinsHOUSEhills",
    "FranklinColorCode",
    "FranklinColorCodeBasic",
    "FranklinColorCodeBright",
    "FullAmbientmult_interior",
    "Glasses_BlackOut",
    "Hanger_INTmods",
    "Hicksbar",
    "HicksbarNEW",
    "Hint_cam",
    "IMpExt_Interior_02",
    "IMpExt_Interior_02_stair_cage",
    "INT_FULLAmbientmult_art",
    "INT_FULLAmbientmult_both",
    "INT_FullAmbientmult",
    "INT_NO_fogALPHA",
    "INT_NOdirectLight",
    "INT_NoAmbientmult",
    "INT_NoAmbientmult_art",
    "INT_NoAmbientmult_both",
    "INT_garage",
    "INT_mall",
    "INT_nowaterREF",
    "INT_posh_hairdresser",
    "INT_smshop",
    "INT_smshop_inMOD",
    "INT_smshop_indoor_bloom",
    "INT_smshop_outdoor_bloom",
    "INT_streetlighting",
    "INT_trailer_cinema",
    "ImpExp_Interior_01",
    "InchOrange01",
    "InchOrange02",
    "InchPickup01",
    "InchPickup02",
    "InchPurple01",
    "InchPurple02",
    "KT_underpass",
    "Kifflom",
    "LIGHTSreduceFALLOFF",
    "LODmult_HD_orphan_LOD_reduce",
    "LODmult_HD_orphan_reduce",
    "LODmult_LOD_reduce",
    "LODmult_SLOD1_reduce",
    "LODmult_SLOD2_reduce",
    "LODmult_SLOD3_reduce",
    "LODmult_global_reduce",
    "LODmult_global_reduce_NOHD",
    "LectroDark",
    "LectroLight",
    "LifeInvaderLOD",
    "LightPollutionHills",
    "LostTimeDark",
    "LostTimeFlash",
    "LostTimeLight",
    "METRO_Tunnels",
    "METRO_Tunnels_entrance",
    "METRO_platform",
    "MPApartHigh",
    "MPApartHigh_palnning",
    "MPApart_H_01",
    "MPApart_H_01_gym",
    "MP_Arena_VIP",
    "MP_Arena_theme_atlantis",
    "MP_Arena_theme_evening",
    "MP_Arena_theme_hell",
    "MP_Arena_theme_midday",
    "MP_Arena_theme_morning",
    "MP_Arena_theme_night",
    "MP_Arena_theme_saccharine",
    "MP_Arena_theme_sandstorm",
    "MP_Arena_theme_scifi_night",
    "MP_Arena_theme_storm",
    "MP_Arena_theme_toxic",
    "MP_Bull_tost",
    "MP_Bull_tost_blend",
    "MP_Garage_L",
    "MP_H_01_Bathroom",
    "MP_H_01_Bedroom",
    "MP_H_01_New",
    "MP_H_01_New_Bathroom",
    "MP_H_01_New_Bedroom",
    "MP_H_01_New_Study",
    "MP_H_01_Study",
    "MP_H_02",
    "MP_H_04",
    "MP_H_06",
    "MP_Killstreak",
    "MP_Killstreak_blend",
    "MP_Loser",
    "MP_Loser_blend",
    "MP_MedGarage",
    "MP_Powerplay",
    "MP_Powerplay_blend",
    "MP_Studio_Lo",
    "MP_corona_heist",
    "MP_corona_heist_BW",
    "MP_corona_heist_BW_night",
    "MP_corona_heist_DOF",
    "MP_corona_heist_blend",
    "MP_corona_heist_night",
    "MP_corona_heist_night_blend",
    "MP_corona_selection",
    "MP_corona_switch",
    "MP_corona_tournament",
    "MP_corona_tournament_DOF",
    "MP_death_grade",
    "MP_death_grade_blend01",
    "MP_death_grade_blend02",
    "MP_deathfail_night",
    "MP_heli_cam",
    "MP_intro_logo",
    "MP_job_end_night",
    "MP_job_load",
    "MP_job_load_01",
    "MP_job_load_02",
    "MP_job_lose",
    "MP_job_preload",
    "MP_job_preload_blend",
    "MP_job_preload_night",
    "MP_job_win",
    "MP_lowgarage",
    "MP_race_finish",
    "MP_select",
    "MichaelColorCode",
    "MichaelColorCodeBasic",
    "MichaelColorCodeBright",
    "MichaelsDarkroom",
    "MichaelsDirectional",
    "MichaelsNODirectional",
    "Mp_Stilts",
    "Mp_Stilts2",
    "Mp_Stilts2_bath",
    "Mp_Stilts_gym",
    "Mp_Stilts_gym2",
    "Mp_apart_mid",
    "Multipayer_spectatorCam",
    "NEW_abattoir",
    "NEW_jewel",
    "NEW_jewel_EXIT",
    "NEW_lesters",
    "NEW_ornate_bank",
    "NEW_ornate_bank_entrance",
    "NEW_ornate_bank_office",
    "NEW_ornate_bank_safe",
    "NEW_shrinksOffice",
    "NEW_station_unfinished",
    "NEW_trevorstrailer",
    "NEW_tunnels",
    "NEW_tunnels_ditch",
    "NEW_tunnels_hole",
    "NEW_yellowtunnels",
    "NG_blackout",
    "NG_deathfail_BW_base",
    "NG_deathfail_BW_blend01",
    "NG_deathfail_BW_blend02",
    "NG_filmic01",
    "NG_filmic02",
    "NG_filmic03",
    "NG_filmic04",
    "NG_filmic05",
    "NG_filmic06",
    "NG_filmic07",
    "NG_filmic08",
    "NG_filmic09",
    "NG_filmic10",
    "NG_filmic11",
    "NG_filmic12",
    "NG_filmic13",
    "NG_filmic14",
    "NG_filmic15",
    "NG_filmic16",
    "NG_filmic17",
    "NG_filmic18",
    "NG_filmic19",
    "NG_filmic20",
    "NG_filmic21",
    "NG_filmic22",
    "NG_filmic23",
    "NG_filmic24",
    "NG_filmic25",
    "NG_filmnoir_BW01",
    "NG_filmnoir_BW02",
    "NG_first",
    "NO_coronas",
    "NO_fog_alpha",
    "NO_streetAmbient",
    "NO_weather",
    "NOdirectLight",
    "NOrain",
    "NeutralColorCode",
    "NeutralColorCodeBasic",
    "NeutralColorCodeBright",
    "NeutralColorCodeLight",
    "NewMicheal",
    "NewMicheal_night",
    "NewMicheal_upstairs",
    "NewMichealgirly",
    "NewMichealstoilet",
    "NewMichealupstairs",
    "New_sewers",
    "NoAmbientmult",
    "NoAmbientmult_interior",
    "NoPedLight",
    "OrbitalCannon",
    "PERSHING_water_reflect",
    "PORT_heist_underwater",
    "PPFilter",
    "PPGreen01",
    "PPGreen02",
    "PPOrange01",
    "PPOrange02",
    "PPPink01",
    "PPPink02",
    "PPPurple01",
    "PPPurple02",
    "Paleto",
    "PennedInDark",
    "PennedInLight",
    "PlayerSwitchNeutralFlash",
    "PlayerSwitchPulse",
    "PoliceStation",
    "PoliceStationDark",
    "Prologue_shootout_opt",
    "REDMIST",
    "REDMIST_blend",
    "RaceTurboDark",
    "RaceTurboFlash",
    "RaceTurboLight",
    "ReduceDrawDistance",
    "ReduceDrawDistanceMAP",
    "ReduceDrawDistanceMission",
    "ReduceSSAO",
    "RemixDrone",
    "RemoteSniper",
    "SALTONSEA",
    "SAWMILL",
    "SP1_03_drawDistance",
    "STRIP_changing",
    "STRIP_nofog",
    "STRIP_office",
    "STRIP_stage",
    "SheriffStation",
    "Shop247",
    "Shop247_none",
    "SmugglerCheckpoint01",
    "SmugglerCheckpoint02",
    "SmugglerFlash",
    "Sniper",
    "StadLobby",
    "StreetLighting",
    "StreetLightingJunction",
    "StreetLightingtraffic",
    "StuntFastDark",
    "StuntFastLight",
    "StuntSlowDark",
    "StuntSlowLight",
    "TREVOR",
    "TUNNEL_green",
    "TUNNEL_green_ext",
    "TUNNEL_orange",
    "TUNNEL_orange_exterior",
    "TUNNEL_white",
    "TUNNEL_yellow",
    "TUNNEL_yellow_ext",
    "TinyGreen01",
    "TinyGreen02",
    "TinyPink01",
    "TinyPink02",
    "TinyRacerMoBlur",
    "TransformFlash",
    "TransformRaceFlash",
    "TrevorColorCode",
    "TrevorColorCodeBasic",
    "TrevorColorCodeBright",
    "Trevors_room",
    "Tunnel",
    "Tunnel_green1",
    "VAGOS_new_garage",
    "VAGOS_new_hangout",
    "VC_tunnel_entrance",
    "V_Abattoir_Cold",
    "V_CIA_Facility",
    "V_FIB_IT3",
    "V_FIB_IT3_alt",
    "V_FIB_IT3_alt5",
    "V_FIB_stairs",
    "V_Metro2",
    "V_Metro_station",
    "V_Office_smoke",
    "V_Office_smoke_Fire",
    "V_Office_smoke_ext",
    "V_Solomons",
    "V_recycle_dark",
    "V_recycle_light",
    "V_recycle_mainroom",
    "V_strip_nofog",
    "V_strip_office",
    "Vagos",
    "VagosSPLASH",
    "VolticBlur",
    "VolticFlash",
    "VolticGold",
    "WATER_lab_cooling",
    "WATER_CH2_06_01_03",
    "WATER_CH2_06_02",
    "WATER_CH2_06_04",
    "WATER_ID2_21",
    "WATER_REF_malibu",
    "WATER_RichmanStuntJump",
    "WATER_cove",
    "WATER_hills",
    "WATER_lab",
    "WATER_militaryPOOP",
    "WATER_muddy",
    "WATER_port",
    "WATER_refmap_high",
    "WATER_refmap_hollywoodlake",
    "WATER_refmap_low",
    "WATER_refmap_med",
    "WATER_refmap_off",
    "WATER_refmap_poolside",
    "WATER_refmap_silverlake",
    "WATER_refmap_venice",
    "WATER_refmap_verylow",
    "WATER_resevoir",
    "WATER_river",
    "WATER_salton",
    "WATER_salton_bottom",
    "WATER_shore",
    "WATER_silty",
    "WATER_silverlake",
    "WarpCheckpoint",
    "WeaponUpgrade",
    "WhiteOut",
    "baseTONEMAPPING",
    "blackNwhite",
    "buggy_shack",
    "buildingTOP",
    "cBank_back",
    "cBank_front",
    "canyon_mission",
    "carMOD_underpass",
    "carpark",
    "carpark_dt1_02",
    "carpark_dt1_03",
    "cashdepot",
    "cashdepotEMERGENCY",
    "ch2_tunnel_whitelight",
    "cinema",
    "cinema_001",
    "cops",
    "crane_cam",
    "crane_cam_cinematic",
    "damage",
    "default",
    "dont_tazeme_bro_b",
    "downtown_FIB_cascades_opt",
    "drug_drive_blend01",
    "drug_drive_blend02",
    "drug_flying_01",
    "drug_flying_02",
    "drug_flying_base",
    "drug_wobbly",
    "dying",
    "eatra_bouncelight_beach",
    "epsilion",
    "exile1_exit",
    "exile1_plane",
    "ext_int_extlight_large",
    "eyeINtheSKY",
    "facebook_serveroom",
    "fireDEPT",
    "fp_vig_black",
    "fp_vig_blue",
    "fp_vig_brown",
    "fp_vig_gray",
    "fp_vig_green",
    "fp_vig_red",
    "frankilnsAUNTS_SUNdir",
    "frankilnsAUNTS_new",
    "gallery_refmod",
    "garage",
    "gen_bank",
    "glasses_Darkblue",
    "glasses_Scuba",
    "glasses_VISOR",
    "glasses_black",
    "glasses_blue",
    "glasses_brown",
    "glasses_green",
    "glasses_orange",
    "glasses_pink",
    "glasses_purple",
    "glasses_red",
    "glasses_yellow",
    "gorge_reflection_gpu",
    "gorge_reflectionoffset",
    "gorge_reflectionoffset2",
    "graveyard_shootout",
    "grdlc_int_02",
    "grdlc_int_02_trailer_cave",
    "gunclub",
    "gunclubrange",
    "gunshop",
    "gunstore",
    "half_direct",
    "hangar_lightsmod",
    "heathaze",
    "heist_boat",
    "heist_boat_engineRoom",
    "heist_boat_norain",
    "heliGunCam",
    "helicamfirst",
    "hillstunnel",
    "hitped",
    "hud_def_Franklin",
    "hud_def_Michael",
    "hud_def_Trevor",
    "hud_def_blur",
    "hud_def_blur_switch",
    "hud_def_colorgrade",
    "hud_def_desat_Franklin",
    "hud_def_desat_Michael",
    "hud_def_desat_Neutral",
    "hud_def_desat_Trevor",
    "hud_def_desat_cold",
    "hud_def_desat_cold_kill",
    "hud_def_desat_switch",
    "hud_def_desatcrunch",
    "hud_def_flash",
    "hud_def_focus",
    "hud_def_lensdistortion",
    "hud_def_lensdistortion_subtle",
    "id1_11_tunnel",
    "impexp_interior_01_lift",
    "int_Barber1",
    "int_ClothesHi",
    "int_ControlTower_none",
    "int_ControlTower_small",
    "int_Farmhouse_none",
    "int_Farmhouse_small",
    "int_FranklinAunt_small",
    "int_GasStation",
    "int_Hospital2_DM",
    "int_Hospital_Blue",
    "int_Hospital_BlueB",
    "int_Hospital_DM",
    "int_Lost_none",
    "int_Lost_small",
    "int_amb_mult_large",
    "int_arena_01",
    "int_arena_Mod",
    "int_arena_Mod_garage",
    "int_arena_VIP",
    "int_carmod_small",
    "int_carrier_control",
    "int_carrier_control_2",
    "int_carrier_hanger",
    "int_carrier_rear",
    "int_carrier_stair",
    "int_carshowroom",
    "int_chopshop",
    "int_clean_extlight_large",
    "int_clean_extlight_none",
    "int_clean_extlight_small",
    "int_clotheslow_large",
    "int_cluckinfactory_none",
    "int_cluckinfactory_small",
    "int_dockcontrol_small",
    "int_extlght_sm_cntrst",
    "int_extlight_large",
    "int_extlight_large_fog",
    "int_extlight_none",
    "int_extlight_none_dark",
    "int_extlight_none_dark_fog",
    "int_extlight_none_fog",
    "int_extlight_small",
    "int_extlight_small_clipped",
    "int_extlight_small_fog",
    "int_hanger_none",
    "int_hanger_small",
    "int_hospital_dark",
    "int_hospital_small",
    "int_lesters",
    "int_methlab_small",
    "int_motelroom",
    "int_office_Lobby",
    "int_office_LobbyHall",
    "int_tattoo",
    "int_tattoo_B",
    "int_tunnel_none_dark",
    "interior_WATER_lighting",
    "introblue",
    "jewel_gas",
    "jewel_optim",
    "jewelry_entrance",
    "jewelry_entrance_INT",
    "jewelry_entrance_INT_fog",
    "lab_none",
    "lab_none_dark",
    "lab_none_dark_OVR",
    "lab_none_dark_fog",
    "lab_none_exit",
    "lab_none_exit_OVR",
    "li",
    "lightning",
    "lightning_cloud",
    "lightning_strong",
    "lightning_weak",
    "lightpolution",
    "lodscaler",
    "maxlodscaler",
    "metro",
    "micheal",
    "micheals_lightsOFF",
    "michealspliff",
    "michealspliff_blend",
    "michealspliff_blend02",
    "militarybase_nightlight",
    "mineshaft",
    "morebloom",
    "morgue_dark",
    "morgue_dark_ovr",
    "mp_battle_int01",
    "mp_battle_int01_dancefloor",
    "mp_battle_int01_dancefloor_OFF",
    "mp_battle_int01_entry",
    "mp_battle_int01_garage",
    "mp_battle_int01_office",
    "mp_battle_int02",
    "mp_battle_int03",
    "mp_battle_int03_tint1",
    "mp_battle_int03_tint2",
    "mp_battle_int03_tint3",
    "mp_battle_int03_tint4",
    "mp_battle_int03_tint5",
    "mp_battle_int03_tint6",
    "mp_battle_int03_tint7",
    "mp_battle_int03_tint8",
    "mp_battle_int03_tint9",
    "mp_bkr_int01_garage",
    "mp_bkr_int01_small_rooms",
    "mp_bkr_int01_transition",
    "mp_bkr_int02_garage",
    "mp_bkr_int02_hangout",
    "mp_bkr_int02_small_rooms",
    "mp_bkr_ware01",
    "mp_bkr_ware02_dry",
    "mp_bkr_ware02_standard",
    "mp_bkr_ware02_upgrade",
    "mp_bkr_ware03_basic",
    "mp_bkr_ware03_upgrade",
    "mp_bkr_ware04",
    "mp_bkr_ware05",
    "mp_exec_office_01",
    "mp_exec_office_02",
    "mp_exec_office_03",
    "mp_exec_office_03C",
    "mp_exec_office_03_blue",
    "mp_exec_office_04",
    "mp_exec_office_05",
    "mp_exec_office_06",
    "mp_exec_warehouse_01",
    "mp_gr_int01_black",
    "mp_gr_int01_grey",
    "mp_gr_int01_white",
    "mp_h_05",
    "mp_h_07",
    "mp_h_08",
    "mp_imx_intwaremed",
    "mp_imx_intwaremed_office",
    "mp_imx_mod_int_01",
    "mp_lad_day",
    "mp_lad_judgment",
    "mp_lad_night",
    "mp_nightshark_shield_fp",
    "mp_smg_int01_han",
    "mp_smg_int01_han_blue",
    "mp_smg_int01_han_red",
    "mp_smg_int01_han_yellow",
    "mp_x17dlc_base",
    "mp_x17dlc_base_dark",
    "mp_x17dlc_base_darkest",
    "mp_x17dlc_facility",
    "mp_x17dlc_facility2",
    "mp_x17dlc_facility_conference",
    "mp_x17dlc_in_sub",
    "mp_x17dlc_in_sub_no_reflection",
    "mp_x17dlc_int_01",
    "mp_x17dlc_int_01_tint1",
    "mp_x17dlc_int_01_tint2",
    "mp_x17dlc_int_01_tint3",
    "mp_x17dlc_int_01_tint4",
    "mp_x17dlc_int_01_tint5",
    "mp_x17dlc_int_01_tint6",
    "mp_x17dlc_int_01_tint7",
    "mp_x17dlc_int_01_tint8",
    "mp_x17dlc_int_01_tint9",
    "mp_x17dlc_int_02",
    "mp_x17dlc_int_02_hangar",
    "mp_x17dlc_int_02_outdoor_intro_camera",
    "mp_x17dlc_int_02_tint1",
    "mp_x17dlc_int_02_tint2",
    "mp_x17dlc_int_02_tint3",
    "mp_x17dlc_int_02_tint4",
    "mp_x17dlc_int_02_tint5",
    "mp_x17dlc_int_02_tint6",
    "mp_x17dlc_int_02_tint7",
    "mp_x17dlc_int_02_tint8",
    "mp_x17dlc_int_02_tint9",
    "mp_x17dlc_int_02_vehicle_avenger_camera",
    "mp_x17dlc_int_02_vehicle_workshop_camera",
    "mp_x17dlc_int_02_weapon_avenger_camera",
    "mp_x17dlc_int_silo",
    "mp_x17dlc_int_silo_escape",
    "mp_x17dlc_lab",
    "mp_x17dlc_lab_loading_bay",
    "mugShot",
    "mugShot_lineup",
    "multiplayer_ped_fight",
    "nervousRON_fog",
    "new_MP_Garage_L",
    "new_bank",
    "new_stripper_changing",
    "new_tunnels_entrance",
    "nextgen",
    "nightvision",
    "overwater",
    "paleto_nightlight",
    "paleto_opt",
    "phone_cam",
    "phone_cam1",
    "phone_cam10",
    "phone_cam11",
    "phone_cam12",
    "phone_cam13",
    "phone_cam2",
    "phone_cam3",
    "phone_cam3_REMOVED",
    "phone_cam4",
    "phone_cam5",
    "phone_cam6",
    "phone_cam7",
    "phone_cam8",
    "phone_cam8_REMOVED",
    "phone_cam9",
    "plane_inside_mode",
    "player_transition",
    "player_transition_no_scanlines",
    "player_transition_scanlines",
    "plaza_carpark",
    "polluted",
    "poolsidewaterreflection2",
    "powerplant_nightlight",
    "powerstation",
    "prison_nightlight",
    "projector",
    "prologue",
    "prologue_ending_fog",
    "prologue_ext_art_amb",
    "prologue_reflection_opt",
    "prologue_shootout",
    "pulse",
    "ranch",
    "reducelightingcost",
    "reducewaterREF",
    "refit",
    "reflection_correct_ambient",
    "resvoire_reflection",
    "rply_brightness",
    "rply_brightness_neg",
    "rply_contrast",
    "rply_contrast_neg",
    "rply_motionblur",
    "rply_saturation",
    "rply_saturation_neg",
    "rply_vignette",
    "rply_vignette_neg",
    "sandyshore_nightlight",
    "scanline_cam",
    "scanline_cam_cheap",
    "scope_zoom_in",
    "scope_zoom_out",
    "secret_camera",
    "services_nightlight",
    "shades_pink",
    "shades_yellow",
    "ship_explosion_underwater",
    "ship_lighting",
    "sleeping",
    "spectator1",
    "spectator10",
    "spectator2",
    "spectator3",
    "spectator4",
    "spectator5",
    "spectator6",
    "spectator7",
    "spectator8",
    "spectator9",
    "stc_coroners",
    "stc_deviant_bedroom",
    "stc_deviant_lounge",
    "stc_franklinsHouse",
    "stc_trevors",
    "stoned",
    "stoned_aliens",
    "stoned_cutscene",
    "stoned_monkeys",
    "subBASE_water_ref",
    "sunglasses",
    "superDARK",
    "switch_cam_1",
    "switch_cam_2",
    "telescope",
    "torpedo",
    "traffic_skycam",
    "trailer_explosion_optimise",
    "trevorspliff",
    "trevorspliff_blend",
    "trevorspliff_blend02",
    "tunnel_entrance",
    "tunnel_entrance_INT",
    "tunnel_id1_11",
    "ufo",
    "ufo_deathray",
    "underwater",
    "underwater_deep",
    "underwater_deep_clear",
    "v_abattoir",
    "v_bahama",
    "v_cashdepot",
    "v_dark",
    "v_foundry",
    "v_janitor",
    "v_jewel2",
    "v_metro",
    "v_michael",
    "v_michael_lounge",
    "v_recycle",
    "v_rockclub",
    "v_strip3",
    "v_strpchangerm",
    "v_sweat",
    "v_sweat_NoDirLight",
    "v_sweat_entrance",
    "v_torture",
    "vagos_extlight_small",
    "vehicle_subint",
    "venice_canal_tunnel",
    "vespucci_garage",
    "warehouse",
    "whitenightlighting",
    "winning_room",
    "yacht_DLC",
    "yell_tunnel_nodirect"
}
local e = 1
local f = {}
for g = 0.1, 2.00, 0.1 do
    table.insert(f, g)
end
local h = {
    "DEATH_FAIL_IN_EFFECT_SHAKE",
    "DRUNK_SHAKE",
    "FAMILY5_DRUG_TRIP_SHAKE",
    "HAND_SHAKE",
    "JOLT_SHAKE",
    "LARGE_EXPLOSION_SHAKE",
    "MEDIUM_EXPLOSION_SHAKE",
    "SMALL_EXPLOSION_SHAKE",
    "ROAD_VIBRATION_SHAKE",
    "SKY_DIVING_SHAKE",
    "VIBRATE_SHAKE",
    "KILL_SHOT_SHAKE"
}
local i = {}
for g = 1, 135, 1 do
    table.insert(i, g)
end
local j = {"Static Camera", "Interpolation Camera"}
local k = {"Curved", "Smooth"}
local l = {["Smooth"] = 0, ["Curved"] = 5}
local m = {}
local n = ""
local o = false
local p = false
local q = 1
local r
local s
local t
local u = false
local v = ""
local w = 1
local x = 1
local y = ""
local z
local A = 1
local B = false
local C = {}
local D = 0
for g = 0, 23 do
    C[g] = g
end
local E = {}
for g = 0, 59 do
    E[g] = g
end
local F = 0
local G = {}
for g = 0, 59 do
    G[g] = g
end
local H = 0
local I = {}
for g = 1, 300, 1 do
    I[g] = (g - 1) * 10 + 0.001
end
local J = 1
local K = 1
local L = 1
local M = 1
local N = {
    "EXTRASUNNY",
    "CLEAR",
    "NEUTRAL",
    "SMOG",
    "FOGGY",
    "OVERCAST",
    "CLOUDS",
    "CLEARING",
    "RAIN",
    "THUNDER",
    "SNOW",
    "BLIZZARD",
    "SNOWLIGHT",
    "XMAS",
    "HALLOWEEN"
}
local O = 1
Citizen.CreateThread(function()
    m = json.decode(GetResourceKvpString("arma_scenedata") or "{}")
end)
RegisterNetEvent("ARMA:openCinematicMenu",function()
    a(true)
end)
function tARMA.createCinematicScene(P)
    m[P] = {}
    SetResourceKvp("arma_scenedata", json.encode(m))
    tARMA.notify("~g~Scene created & saved.")
end
function tARMA.deleteCinematicScene(P)
    m[P] = nil
    SetResourceKvp("arma_scenedata", json.encode(m))
    tARMA.notify("~g~Scene deleted & saved.")
end
function tARMA.createCamera(P, Q)
    if #m[P] == 0 then
        Q.transition = 100
    end
    table.insert(m[P], Q)
    q = #m[P]
    if m[n][q].type == "Static Camera" then
        w = 1
    elseif m[n][q].type == "Interpolation Camera" then
        w = 2
    end
    if m[n][q].blending == 0 then
        x = 2
    elseif m[n][q].blending == 5 then
        x = 1
    end
    SetResourceKvp("arma_scenedata", json.encode(m))
    tARMA.notify("~g~Camera created & saved.")
end
function tARMA.modifyCamera(P, Q, R)
    m[P][R] = Q
    SetResourceKvp("arma_scenedata", json.encode(m))
    tARMA.notify("~g~Camera modified & saved.")
end
function tARMA.deleteCamera(P, S)
    table.remove(m[P], S)
    SetResourceKvp("arma_scenedata", json.encode(m))
    tARMA.notify("~g~Camera deleted & saved.")
end
function tARMA.modifyTransition(n, q, T)
    m[n][q].transition = tonumber(T)
    SetResourceKvp("arma_scenedata", json.encode(m))
    tARMA.notify("~g~Transition change saved.")
end
function tARMA.modifyCameraBlending(n, q, U)
    m[n][q].blending = l[U]
    SetResourceKvp("arma_scenedata", json.encode(m))
    tARMA.notify("~g~Camera Blending change saved.")
end
function tARMA.modifyScreeneffect(n, q, V)
    m[n][q].screeneffect = V
    SetResourceKvp("arma_scenedata", json.encode(m))
    tARMA.notify("~g~Screeneffect change saved.")
end
function tARMA.modifyTimecycleEffect(n, q, W)
    m[n][q].timecycleEffect = W
    SetResourceKvp("arma_scenedata", json.encode(m))
    tARMA.notify("~g~Timecycle Effect change saved.")
end
function tARMA.setTimecycleIntensity(n, q, f)
    m[n][q].timecycleIntensity = f
    SetResourceKvp("arma_scenedata", json.encode(m))
    tARMA.notify("~g~Timecycle intensity change saved.")
end
function tARMA.modifyShakeEffect(n, q, X)
    m[n][q].shake = X
    SetResourceKvp("arma_scenedata", json.encode(m))
    tARMA.notify("~g~Shake change saved.")
end
function tARMA.modifyCameraType(n, q, type)
    m[n][q].type = type
    SetResourceKvp("arma_scenedata", json.encode(m))
    tARMA.notify("~g~Camera type change saved.")
end
function tARMA.addCameraFocus(n, q, Y, Z)
    m[n][q].focusType = Y
    m[n][q].focusData = Z
    SetResourceKvp("arma_scenedata", json.encode(m))
    tARMA.notify("~g~Follow player change saved.")
end
function tARMA.setCameraFov(n, q)
    m[n][q].fov = i[A]
    SetResourceKvp("arma_scenedata", json.encode(m))
    tARMA.notify("~g~FOV change saved.")
end
local function _(R, a0)
    if a0.position == nil then
        m[n][R].position = GetEntityCoords(PlayerPedId())
    end
    if a0.rotation == nil then
        m[n][R].rotation = GetGameplayCamRot(0)
    end
    if a0.transition == nil then
        m[n][R].transition = 5000
    end
    if a0.type == nil then
        m[n][R].type = v
    end
    if a0.screeneffect == nil then
        m[n][R].screeneffect = ""
    end
    if a0.timecycleEffect == nil then
        m[n][R].timecycleEffect = ""
    end
    if a0.timecycleIntensity == nil then
        m[n][R].timecycleIntensity = 1.0
    end
    if a0.focusType == nil then
        m[n][R].focusType = ""
    end
    if a0.focusData == nil then
        m[n][R].focusData = 0
    end
    if a0.shake == nil then
        m[n][R].shake = ""
    end
    if a0.fov == nil then
        m[n][R].fov = 65.0
    end
end

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('mainmenu', 'cinematic')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.ButtonWithStyle("Create Scene","",{RightLabel = "→→→"},true,function(a1, a2, a3)
                if a3 then
                    local P = getSearchField("Scene Name")
                    if P ~= "" then
                        tARMA.createCinematicScene(P)
                    end
                end
            end,RMenu:Get("mainmenu", "cinematic"))
            RageUI.ButtonWithStyle("Load Scene","",{RightLabel = "→→→"},true,function(a1, a2, a3)
            end,RMenu:Get("load_scene", "cinematic"))
            RageUI.ButtonWithStyle("Weather/Time Editor","",{RightLabel = "→→→"},true,function(a1, a2, a3)
            end,RMenu:Get("weather_time_manager", "cinematic"))
            RageUI.ButtonWithStyle("Delete Scene","",{RightLabel = "→→→"},true,function(a1, a2, a3)
                if a3 then
                    local P = getSearchField("Scene Name")
                    if P ~= "" then
                        tARMA.deleteCinematicScene(P)
                    end
                end
            end,RMenu:Get("mainmenu", "cinematic"))
            local function a4()
                ExecuteCommand("hideui")
                u = true
            end
            local function a5()
                ExecuteCommand("showui")
                u = false
            end
            RageUI.Checkbox("Hide UI","",u,{RightBadge = RageUI.CheckboxStyle.Car},function(a1, a3, a2, a6)
            end,a4,a5)
        end)
    end
    if RageUI.Visible(RMenu:Get('load_scene', 'cinematic')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            for P, a7 in pairs(m) do
                RageUI.ButtonWithStyle(P,"",{RightLabel = "→→→"},true,function(a1, a2, a3)
                    if a3 then
                        n = P
                    end
                end,RMenu:Get("scene_manager", "cinematic"))
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('scene_manager', 'cinematic')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.BackspaceMenuCallback(function()
                previewingCamera = nil
                unpreviewFromCamera()
            end)
            RageUI.ButtonWithStyle("Play Scene","",{RightLabel = "→→→"},true,function(a1, a2, a3)
                if a2 then
                    previewingCamera = nil
                    unpreviewFromCamera()
                end
                if a3 then
                    a(false)
                    renderCinematicScene(n)
                end
            end,RMenu:Get("scene_manager", "cinematic"))
            RageUI.ButtonWithStyle("[Add Camera]","",{RightLabel = "→→→"},true,function(a1, a2, a3)
                if a2 then
                    previewingCamera = nil
                    unpreviewFromCamera()
                end
                if a3 then
                end
            end,RMenu:Get("add_camera", "cinematic"))
            if type(m[n]) == "table" then
                for R, a0 in pairs(m[n]) do
                    _(R, a0)
                    RageUI.ButtonWithStyle("Camera " .. R,"",{RightLabel = "→→→"},true,function(a1, a2, a3)
                        if a2 then
                            previewingCamera = R
                            if not DoesCamExist(r) then
                                print("Creating cam because it doesn't exist")
                                r = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
                                SetCamActive(r, true)
                                RenderScriptCams(true, true, 500, 1, 0)
                            end
                        end
                        if a3 then
                            q = R
                            if m[n][q].type == "Static Camera" then
                                w = 1
                            elseif m[n][q].type == "Interpolation Camera" then
                                w = 2
                            end
                            if m[n][q].blending == 0 then
                                x = 2
                            elseif m[n][q].blending == 5 then
                                x = 1
                            end
                        end
                    end,RMenu:Get("camera_manager", "cinematic"))
                end
            else
                print("failed, loaded scene was not a table?")
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('camera_manager', 'cinematic')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.BackspaceMenuCallback(function()
                previewingCamera = nil
                unpreviewFromCamera()
            end)
            if q and m[n][q] then
                RMenu:Get("camera_manager", "cinematic"):SetSubtitle("~b~" .. m[n][q].type)
                RageUI.ButtonWithStyle("~b~Transition: " .. m[n][q].transition .. "ms","",{RightLabel = "→→→"},true,function(a1, a2, a3)
                    if a3 then
                        local T = getSearchField("Transition(in ms):")
                        if tonumber(T) then
                            tARMA.modifyTransition(n, q, T)
                        else
                            tARMA.notify("~r~Failed to change transition time.")
                        end
                    end
                end,RMenu:Get("camera_manager", "cinematic"))
                RageUI.ButtonWithStyle("Move Camera","",{RightLabel = "→→→"},true,function(a1, a2, a3)
                    if a3 then
                        if not o and not p then
                            previewingCamera = nil
                            t = GetEntityCoords(PlayerPedId())
                            unpreviewFromCamera()
                            tARMA.toggleNoclip()
                            p = q
                        end
                    end
                end,RMenu:Get("camera_manager", "cinematic"))
                RageUI.List("Camera Type:",j,w,"",{},true,function(a1, a2, a3, a8)
                    if a8 ~= w then
                        w = a8
                        tARMA.modifyCameraType(n, q, j[w])
                    end
                end,function()end,nil)
                RageUI.List("Camera Blending:",k,x,"",{},true,function(a1, a2, a3, a8)
                    if a8 ~= x then
                        x = a8
                        tARMA.modifyCameraBlending(n, q, k[x])
                    end
                end,function()end,nil)
                RageUI.ButtonWithStyle("Select Camera Focus","",{RightLabel = "→→→"},true,function(a1, a2, a3)
                end,RMenu:Get("camera_focus_manager", "cinematic"))
                RageUI.ButtonWithStyle("Screen Effect: " .. (m[n][q].screeneffect or "N/A"),"",{RightLabel = "→→→"},true,function(a1, a2, a3)
                end,RMenu:Get("screeneffect_manager", "cinematic"))
                RageUI.List("Timecycle Intensity",f,e,"",{},true,function(a1, a2, a3, a8)
                    RageUI.BackspaceMenuCallback(function()
                        ClearTimecycleModifier()
                    end)
                    if a8 ~= e then
                        e = a8
                        if m[n][q].timecycleEffect ~= "" then
                            SetTimecycleModifier(m[n][q].timecycleEffect)
                            SetTimecycleModifierStrength(m[n][q].timecycleIntensity)
                            tARMA.setTimecycleIntensity(n, q, f[e])
                        end
                    end
                end,function()end,nil)
                RageUI.ButtonWithStyle("Timecycle Effect: " .. (m[n][q].timecycleEffect or "N/A"),"",{RightLabel = "→→→"},true,function(a1, a2, a3)
                end,RMenu:Get("timecycle_manager", "cinematic"))
                RageUI.ButtonWithStyle("Shake Effect: " .. (m[n][q].shake or "N/A"),"",{RightLabel = "→→→"},true,function(a1, a2, a3)
                end,RMenu:Get("shake_manager", "cinematic"))
                RageUI.List("Field of View (FOV)",i,A,"",{},true,function(a1, a2, a3, a8)
                    if a8 ~= A then
                        A = a8
                        tARMA.setCameraFov(n, q)
                    end
                end,function()end,nil)
                RageUI.ButtonWithStyle("Remove Camera","",{RightLabel = "→→→"},true,function(a1, a2, a3)
                    if a3 then
                        tARMA.deleteCamera(n, q)
                        previewingCamera = nil
                        unpreviewFromCamera()
                        q = nil
                    end
                end,RMenu:Get("camera_manager", "cinematic"))
            else
                RageUI.Separator("~r~No Camera ID selected.")
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('add_camera', 'cinematic')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.BackspaceMenuCallback(function()
            end)
            RageUI.ButtonWithStyle("Add Static Camera","",{RightLabel = "→→→"},true,function(a1, a2, a3)
                if a3 then
                    if o then
                        notify("~r~Can not add a camera whilst you are adding a camera.")
                        return
                    end
                    previewingCamera = nil
                    t = GetEntityCoords(PlayerPedId())
                    unpreviewFromCamera()
                    tARMA.toggleNoclip()
                    o = true
                    v = "Static Camera"
                end
            end,RMenu:Get("camera_manager", "cinematic"))
            RageUI.ButtonWithStyle("Add Interpolation Camera","",{RightLabel = "→→→"},true,function(a1, a2, a3)
                if a3 then
                    if o then
                        notify("~r~Can not add a camera whilst you are adding a camera.")
                        return
                    end
                    previewingCamera = nil
                    t = GetEntityCoords(PlayerPedId())
                    unpreviewFromCamera()
                    tARMA.toggleNoclip()
                    o = true
                    v = "Interpolation Camera"
                end
            end,RMenu:Get("camera_manager", "cinematic"))
        end)
    end
    if RageUI.Visible(RMenu:Get('screeneffect_manager', 'cinematic')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.BackspaceMenuCallback(function()
                AnimpostfxStopAll()
            end)
            for g = 1, #c do
                RageUI.ButtonWithStyle(c[g],"",{RightLabel = "→→→"},true,function(a1, a2, a3)
                    if a2 then
                        AnimpostfxStopAll()
                        if c[g] ~= "Default" then
                            AnimpostfxPlay(c[g], 5000, false)
                        end
                    end
                    if a3 then
                        tARMA.modifyScreeneffect(n, q, c[g])
                    end
                end,RMenu:Get("camera_manager", "cinematic"))
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('timecycle_manager', 'cinematic')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.BackspaceMenuCallback(function()
                ClearTimecycleModifier()
            end)
            for g = 1, #d do
                RageUI.ButtonWithStyle(d[g],"",{RightLabel = "→→→"},true,function(a1, a2, a3)
                    if a2 then
                        ClearTimecycleModifier()
                        if d[g] ~= "Default" then
                            SetTimecycleModifier(d[g])
                        end
                    end
                    if a3 then
                        tARMA.modifyTimecycleEffect(n, q, d[g])
                    end
                end,RMenu:Get("camera_manager", "cinematic"))
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('shake_manager', 'cinematic')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.BackspaceMenuCallback(function()
                AnimpostfxStopAll()
            end)
            for g = 1, #h do
                RageUI.ButtonWithStyle(h[g],"",{RightLabel = "→→→"},true,function(a1, a2, a3)
                    if a2 then
                        if y == "" or y ~= h[g] then
                            y = h[g]
                            SetTimeout(
                                25000,
                                function()
                                    y = ""
                                end
                            )
                            ShakeCam(GetRenderingCam(), h[g], 1.0)
                        end
                    end
                    if a3 then
                        tARMA.modifyShakeEffect(n, q, h[g])
                    end
                end,RMenu:Get("camera_manager", "cinematic"))
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('camera_focus_manager', 'cinematic')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.BackspaceMenuCallback(function()
                AnimpostfxStopAll()
            end)
            RageUI.Separator("~b~Currently pointed at: " .. m[n][q].focusType .. " : " .. m[n][q].focusData)
            RageUI.ButtonWithStyle("Player","",{RightLabel = "→→→"},true,function(a1, a2, a3)
                if a3 then
                    local a9 = getSearchField("Temp ID:")
                    if a9 ~= "" then
                        tARMA.addCameraFocus(n, q, "player", a9)
                    end
                end
            end,RMenu:Get("camera_manager", "cinematic"))
            RageUI.ButtonWithStyle("Coordinates","",{RightLabel = "→→→"},true,function(a1, a2, a3)
                if a3 then
                    tARMA.clientPrompt("Enter coordinates:","",function(aa)
                        local ab = {}
                        for ac in string.gmatch(
                            aa:gsub('" y="', ","):gsub('" z="', ",") or "0,0,0",
                            "[^,]+"
                        ) do
                            table.insert(ab, tonumber(ac))
                        end
                        if aa == "" then
                            return
                        end
                        local ad, ae, af = 0, 0, 0
                        if ab[1] ~= nil then
                            ad = ab[1]
                        end
                        if ab[2] ~= nil then
                            ae = ab[2]
                        end
                        if ab[3] ~= nil then
                            af = ab[3]
                        end
                        tARMA.addCameraFocus(n, q, "coord", vector3(ad, ae, af))
                    end)
                end
            end,RMenu:Get("camera_manager", "cinematic"))
        end)
    end
    if RageUI.Visible(RMenu:Get('dof_manager', 'cinematic')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.BackspaceMenuCallback(function()
            end)
            RageUI.Separator("~g~These settings require some fiddling to get the desired result.")
            RageUI.List("Near Plane Out",I,J,"",{},true,function(a1, a2, a3, a8)
                if a8 ~= J then
                    J = a8
                    SetHidofOverride(1, 1, I[J], I[K], I[L], I[M])
                end
            end,function()end,nil)
            RageUI.List("Near Plane In",I,K,"",{},true,function(a1, a2, a3, a8)
                if a8 ~= K then
                    K = a8
                    SetHidofOverride(1, 1, I[J], I[K], I[L], I[M])
                end
            end,function()end,nil)
            RageUI.List("Far Plane Out",I,L,"",{},true,function(a1, a2, a3, a8)
                if a8 ~= L then
                    L = a8
                    SetHidofOverride(1, 1, I[J], I[K], I[L], I[M])
                end
            end,function()end,nil)
            RageUI.List("Far Plane In",I,M,"",{},true,function(a1, a2, a3, a8)
                if a8 ~= M then
                    M = a8
                    SetHidofOverride(1, 1, I[J], I[K], I[L], I[M])
                end
            end,function()end,nil)
        end)
    end
    if RageUI.Visible(RMenu:Get('weather_time_manager', 'cinematic')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.BackspaceMenuCallback(function()
            end)
            local function a4()
                B = true
                tARMA.overrideTime(C[D], E[F], G[H])
            end
            local function a5()
                B = false
                tARMA.cancelOverrideTimeWeather()
            end
            RageUI.Checkbox("Override Weather/Time","",B,{RightBadge = RageUI.CheckboxStyle.Car},function(a1, a3, a2, a6)
                B = a6
            end,a4,a5)
            RageUI.List("Hours",C,D,"",{},true,function(a1, a2, a3, a8)
                if a8 ~= D then
                    D = a8
                    if B then
                        tARMA.overrideTime(C[D], E[F], G[H])
                    end
                end
            end,function()end,nil)
            RageUI.List("Minutes",E,F,"",{},true,function(a1, a2, a3, a8)
                if a8 ~= F then
                    F = a8
                    if B then
                        tARMA.overrideTime(C[D], E[F], G[H])
                    end
                end
            end,function()end,nil)
            RageUI.List("Seconds",G,H,"",{},true,function(a1, a2, a3, a8)
                if a8 ~= H then
                    H = a8
                    if B then
                        tARMA.overrideTime(C[D], E[F], G[H])
                    end
                end
            end,function()end,nil)
            RageUI.List("Weather",N,O,"",{},true,function(a1, a2, a3, a8)
                if a8 ~= O then
                    O = a8
                    if B then
                        tARMA.setWeather(N[O])
                    end
                end
            end,function()end,nil)
        end)
    end
end)


function unpreviewFromCamera()
    if r then
        DestroyCam(r, 0)
        RenderScriptCams(0, 0, 1, 1, 1)
    end
    ClearFocus()
end
Citizen.CreateThread(function()
    DecorRegister("cinematicMode", 2)
    while true do
        local ag = PlayerPedId()
        if B then
            if z == nil and not globalHideUi then
                drawNativeText("~r~CINEMATIC MODE ENABLED")
            end
            if not DecorExistOn(ag, "cinematicMode") then
                DecorSetBool(ag, "cinematicMode", true)
            end
        end
        if (o or p) and noclipActive and tARMA.getPlayerVehicle() ~= 0 then
            tARMA.notify("~r~You may not noclip when in a vehicle.")
            tARMA.toggleNoclip()
        end
        if o and noclipActive then
            drawNativeText("~g~Press [SPACEBAR] to confirm camera placement.")
            if IsControlJustPressed(0, 22) then
                local Q = {
                    position = GetEntityCoords(ag),
                    rotation = GetGameplayCamRot(0),
                    transition = 5000,
                    type = v,
                    screeneffect = "",
                    timecycleEffect = "",
                    timecycleIntensity = 1.0,
                    focusType = "",
                    focusData = 0,
                    shake = "",
                    fov = 65.0
                }
                tARMA.createCamera(n, Q)
                tARMA.toggleNoclip()
                o = false
                SetEntityCoords(PlayerPedId(), t)
            end
        end
        if p and noclipActive then
            drawNativeText("~g~Press [SPACEBAR] to confirm camera placement.")
            if IsControlJustPressed(0, 22) then
                local Q = {
                    position = GetEntityCoords(ag),
                    rotation = GetGameplayCamRot(0),
                    transition = m[n][p].transition,
                    type = m[n][p].type,
                    screeneffect = m[n][p].screeneffect,
                    timecycleEffect = m[n][p].timecycleEffect,
                    timecycleIntensity = m[n][p].timecycleIntensity,
                    focusType = m[n][p].focusType,
                    focusData = m[n][p].focusData,
                    shake = m[n][p].shake,
                    fov = m[n][p].fov or 65.0
                }
                tARMA.modifyCamera(n, Q, p)
                tARMA.toggleNoclip()
                p = false
                SetEntityCoords(PlayerPedId(), t)
            end
        end
        if previewingCamera ~= nil then
            local a0 = m[n][previewingCamera]
            SetFocusPosAndVel(a0.position.x, a0.position.y, a0.position.z)
            SetCamCoord(r, a0.position.x, a0.position.y, a0.position.z)
            SetCamRot(r, a0.rotation.x, a0.rotation.y, a0.rotation.z)
            SetCamFov(r, (a0.fov or 65.0) + 0.001)
        end
        if z ~= nil then
            local ah = GetCamCoord(z)
            SetFocusPosAndVel(ah.x, ah.y, ah.z)
        end
        Wait(0)
    end
end)
function renderCinematicScene(P)
    Citizen.CreateThread(function()
        clearNativeText()
        if s then
            DestroyCam(s, 0)
            RenderScriptCams(0, 0, 1, 1, 1)
        end
        if not DoesCamExist(s) then
            s = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
            SetCamActive(s, true)
            RenderScriptCams(true, true, 0, 1, 0)
        end
        print("initiating render")
        local ai
        for R, a0 in pairs(m[P]) do
            z = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA",a0.position.x,a0.position.y,a0.position.z,a0.rotation.x,a0.rotation.y,a0.rotation.z,(a0.fov or 65.0) + 0.001,0,2)
            if a0.type == "Static Camera" then
                SetCamActive(z, true)
            elseif a0.type == "Interpolation Camera" then
                SetCamActiveWithInterp(z, ai, a0.transition, a0.blending or 5, a0.blending or 5)
            end
            if a0.focusType ~= "" then
                if a0.focusType == "player" then
                    local aj = GetPlayerPed(a0.focusData)
                    if aj then
                        PointCamAtEntity(z, aj, 1, 1, 1, true)
                    else
                        print("[ARMA Cinematic] Failed to point cam at player, could not get entity.")
                    end
                elseif a0.focusType == "coord" then
                    PointCamAtCoord(z, a0.focusData.x, a0.focusData.y, a0.focusData.z)
                end
            end
            if a0.shake ~= "" then
                ShakeCam(z, a0.shake, 1.0)
            end
            if a0.screeneffect ~= "Default" and a0.screeneffect ~= "" then
                AnimpostfxPlay(a0.screeneffect, a0.transition, false)
            end
            if a0.timecycleEffect ~= "Default" and a0.timecycleEffect ~= "" then
                SetTimecycleModifier(a0.timecycleEffect)
                SetTimecycleModifierStrength(a0.timecycleIntensity)
            end
            ai = z
            Wait(a0.transition)
            AnimpostfxStopAll()
            ClearTimecycleModifier()
        end
        DestroyCam(z, 0)
        RenderScriptCams(0, 0, 1, 1, 1)
        z = nil
        DestroyCam(ai, 0)
        RenderScriptCams(0, 0, 1, 1, 1)
        ClearFocus()
    end)
end
local ak = -1
RegisterCommand("setlastvehicleon",function()
    local ag = PlayerPedId()
    if not IsPedInAnyVehicle(ag, true) and not IsControlPressed(0, 23) then
        local al = GetVehiclePedIsIn(ag, true)
        if al ~= 0 then
            SetVehicleEngineOn(al, true, true)
            ak = al
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local al, am = tARMA.getPlayerVehicle()
        if al ~= 0 and al == ak and am then
            SetVehicleEngineOn(al, false, true, true)
            ak = -1
        end
        local an = GetEntityAttachedTo(PlayerPedId())
        if an ~= 0 and IsEntityAPed(an) and IsPedAPlayer(an) and not IsEntityVisible(an) then
            local ao = NetworkGetPlayerIndexFromPed(an)
            if ao ~= -1 then
                local ap = GetPlayerServerId(ao)
                if ap > 0 then
                    if not tARMA.clientGetPlayerIsStaff(tARMA.clientGetUserIdFromSource(ap)) then
                        SetEntityVisible(PlayerPedId(), true, true)
                        DetachEntity(PlayerPedId(), true, true)
                    end
                end
            end
        end
        Citizen.Wait(1000)
    end
end)

function getSearchField(a6)
    AddTextEntry("FMMC_MPM_NA", "Search by " .. a6)
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Search by " .. a6, "", "", "", "", 30)
    while UpdateOnscreenKeyboard() == 0 do
        DisableAllControlActions(0)
        Wait(0)
    end
    if GetOnscreenKeyboardResult() then
        local a7 = GetOnscreenKeyboardResult()
        if a7 then
            return a7
        else
            return ""
        end
    end
    return ""
end