local a={"xn_h4_islandx_terrain_01_slod","xn_h4_islandx_terrain_02_slod","xn_h4_islandx_terrain_04_slod","xn_h4_islandx_terrain_05_slod","xn_h4_islandx_terrain_06_slod"}
local b={"xn_ap1_lod","xn_apa_ch2_lod","xn_apa_ch2_lod2","xn_apa_ch2_lod3","xn_apa_ch2_lod4","xn_apa_ss1_lod","xn_bh1_lod","xn_bkr_id1_lod","xn_ch1_lod","xn_ch2_lod","xn_ch2_lod2","xn_ch2_lod3","xn_ch2_lod4","xn_ch3_lod","xn_cs1_lod","xn_cs1_lod2","xn_cs1_lod3","xn_cs2_lod","xn_cs2_lod2","xn_cs3_lod","xn_cs4_lod","xn_cs5_lod","xn_cs6_lod","xn_dt1_lod","xn_hei_ap1_lod","xn_hei_bh1_lod","xn_hei_ch1_lod","xn_hei_ch2_lod","xn_hei_ch2_lod2","xn_hei_ch2_lod3","xn_hei_ch2_lod4","xn_hei_ch3_lod","xn_hei_cs1_lod","xn_hei_cs1_lod2","xn_hei_cs1_lod3","xn_hei_cs2_lod","xn_hei_cs2_lod2","xn_hei_cs3_lod","xn_hei_cs4_lod","xn_hei_cs6_lod","xn_hei_dt1_lod","xn_hei_hw1_lod","xn_hei_id1_lod","xn_hei_id2_lod","xn_hei_kt1_lod","xn_hei_po1_lod","xn_hei_sc1_lod","xn_hei_sm_lod","xn_hei_ss1_lod","xn_hei_vb_lod","xn_hw1_lod","xn_id1_lod","xn_id2_lod","xn_kt1_lod","xn_lr_cs4_lod","xn_lr_cs6_lod","xn_lr_id1_lod","xn_lr_sc1_lod","xn_po1_lod","xn_sc1_lod","xn_sm_lod","xn_sp1_lod","xn_ss1_lod","xn_vb_lod"}
local c=false
function TogglePerico()
    if c then 
        DisableCayoPerico(false)
    else 
        EnableCayoPerico(false)
    end
    Wait(1000)
    DoScreenFadeIn(2000)
    c=not c
    TriggerEvent("IsInCayoPerico",c)
    TriggerServerEvent("IsInCayoPerico",c)
end
function EnableCayoPerico(d)
    SetIslandHopperEnabled('HeistIsland',true)
    SetToggleMinimapHeistIsland(true)
    SetAiGlobalPathNodesType(true)
    Citizen.InvokeNative(0x53797676AD34A9AA,false)
    SetScenarioGroupEnabled('Heist_Island_Peds',true)
    SetAudioFlag('PlayerOnDLCHeist4Island',true)
    SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Zones',true,true)
    SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Disabled_Zones',false,true)
    for e,f in ipairs(b)do 
        RequestIpl(f)
    end
    for e,f in ipairs(a)do 
        RemoveIpl(f)
    end
    if d then 
        c=true
        TriggerEvent("IsInCayoPerico",true)
        TriggerServerEvent("IsInCayoPerico",true)
    end 
end
function DisableCayoPerico(d)
    SetIslandHopperEnabled('HeistIsland',false)
    SetToggleMinimapHeistIsland(false)
    SetAiGlobalPathNodesType(false)
    Citizen.InvokeNative(0x53797676AD34A9AA,true)
    SetScenarioGroupEnabled('Heist_Island_Peds',false)
    SetAudioFlag('PlayerOnDLCHeist4Island',false)
    SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Zones',false,false)
    SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Disabled_Zones',true,false)
    for e,f in ipairs(a)do 
        RequestIpl(f)
    end
    for e,f in ipairs(b)do 
        RemoveIpl(f)
    end
    if d then 
        c=false
        TriggerEvent("IsInCayoPerico",false)
        TriggerServerEvent("IsInCayoPerico",false)
    end 
end
Citizen.CreateThread(function()
    tAQUA.createArea("cayo_island",vector3(5218.9399414062,-5393.2563476562,67.318588256836),2142.0,1400.0,function()
        TogglePerico()
    end,function()
        TogglePerico()
    end,function()
    end)
end)
RegisterNetEvent('EnableCayoPerico')
AddEventHandler('EnableCayoPerico',function()
    EnableCayoPerico(true)
end)
RegisterNetEvent('DisableCayoPerico')
AddEventHandler('DisableCayoPerico',function()
    DisableCayoPerico(true)
end)