local m = module("AQUAVehicles", "cfg/cfg_garages")
m=m.garage_types


local allowedEntities = {-- Place all the Vehicles/Models you would like to be able to spawn here:
    -- DJ MENU
    [`ba_prop_battle_dj_stand`] = true,
    [`ba_prop_battle_club_speaker_large`] = true,
    [`prop_studio_light_01`] = true,
   
    --
    [`plane2`] = true,
    [`buzzard2`] = true,
    [`tug`] = true,
    [`bmx`] = true,
    [`prop_v_parachute`] = true,
    [`imp_prop_impexp_para_s`] = true,
    [`prop_ld_jerrycan_01`] = true,
    [`prop_amb_phone`] = true,
    [`ba_prop_battle_glowstick_01`] = true,
    [`ba_prop_battle_hobby_horse`] = true,
    [`p_amb_brolly_01`] = true,
    [`prop_notepad_01`] = true,
    [`prop_pencil_01`] = true,
    [`hei_prop_heist_box`] = true,
    [`prop_single_rose`] = true,
    [`prop_cs_ciggy_01`] = true,
    [`hei_heist_sh_bong_01`] = true,
    [`prop_ld_suitcase_01`] = true,
    [`prop_security_case_01`] = true,
    [`prop_police_id_board`] = true,
    [`p_amb_coffeecup_01`] = true,
    [`prop_drink_whisky`] = true,
    [`prop_amb_beer_bottle`] = true,
    [`prop_plastic_cup_02`] = true,
    [`prop_cs_burger_01`] = true,
    [`prop_sandwich_01`] = true,
    [`prop_ecola_can`] = true,
    [`prop_choc_ego`] = true,
    [`prop_drink_redwine`] = true,
    [`prop_champ_flute`] = true,
    [`prop_drink_champ`] = true,
    [`prop_cigar_02`] = true,
    [`prop_cigar_01`] = true,
    [`prop_acc_guitar_01`] = true,
    [`prop_el_guitar_01`] = true,
    [`prop_el_guitar_03`] = true,
    [`prop_cigar_02`] = true,
    [`prop_novel_01`] = true,
    [`prop_snow_flower_02`] = true,
    [`v_ilev_mr_rasberryclean`] = true,
    [`p_michael_backpack_s`] = true,
    [`p_amb_clipboard_01`] = true,
    [`prop_tourist_map_01`] = true,
    [`prop_beggers_sign_03`] = true,
    [`prop_anim_cash_pile_01`] = true,
    [`prop_pap_camera_01`] = true,
    [`ba_prop_battle_champ_open`] = true,
    [`p_cs_joint_02`] = true,
    [`prop_amb_ciggy_01`] = true,
    [`prop_ld_case_01`] = true,
    [`prop_cs_tablet`] = true,
    [`prop_npc_phone_02`] = true,
    [`prop_sponge_01`] = true,
    [`hei_prop_heist_drill`] = true,
    [`p_cargo_chute_s`] = true,
    [`prop_drop_crate_01_set2`] = true,
    [`p_parachute1_mp_s`] = true,
    [`p_parachute1_sp_s`] = true,
    [`sr_prop_specraces_para_s_01`] = true,
    [`lts_p_para_pilot2_sp_s`] = true,
    [`pil_p_para_pilot_sp_s`] = true,
    [`p_parachute1_s`] = true,
    [`prop_clamp`] = true,
    [`sr_prop_specraces_para_s`] = true,
    [`gr_prop_gr_para_s_01`] = true,
    [`xm_prop_x17_para_sp_s`] = true,
    [`p_cs_cuffs_02_s`] = true,
    [`p_parachute1_mp_dec`] = true,
    [`p_parachute1_s`] = true,
    [`p_parachute1_mp_s`] = true,
    [`p_parachute1_sp_dec`] = true,
    [`prop_roadcone01a`] = true,
    [`prop_roadcone02b`] = true,
    [`prop_gazebo_02`] = true,
    [`prop_worklight_03b`] = true,
    [`prop_barrier_work05`] = true,
    [`ba_prop_battle_barrier_02a`] = true,
    [`prop_mp_barrier_01`] = true,
    [`prop_mp_barrier_01b`] = true,
    [`prop_cs_hand_radio`] = true,
    [`prop_sacktruck_02b`] = true,
    [`prop_paper_bag_01`] = true,


    -- Shank
    [`w_me_shank`] = true,
    [`w_me_broom`] = true,
    [`w_me_dildo`] = true,
    [`w_me_toiletbrush`] = true,
    -- Large Arms
    [`w_sg_winchester`] = true,
    [`w_sb_VESPER`] = true,
    [`w_sb_mp7`] = true,
    [`w_sb_mp40`] = true,
    [`w_ar_goldak`] = true,
    [`w_ar_akm`] = true,
    [`w_ar_ak74`] = true,
    -- PD
    [`w_me_NIGHTSTICK`] = true,
    [`w_me_FLASHLIGHT`] = true,
    [`w_pi_GLOCK`] = true,
    [`w_pi_STUNGUN`] = true,
    [`w_sg_REMINGTON870`] = true,
    [`w_sb_MP5`] = true,
    [`w_sr_REMINGTON700`] = true,
    [`w_ar_PDMAQUA`] = true,
    [`w_ar_spar17`] = true,
    [`w_ar_PDHK416`] = true,
    [`w_sb_cq300`] = true,

    -- Rebel
    [`w_ar_akkal`] = true,
    [`w_ar_m16a1`] = true,
    [`w_ar_MXM`] = true,
    [`w_ar_m4a1`] = true,
    [`w_ar_mosin`] = true,
    [`w_ar_mxc`] = true,
    -- Advanced Rebel
    [`w_ar_SPAR16`] = true,
    [`w_ar_MK1EMR`] = true,
    [`w_sr_svd`] = true,
    -- Small Arms
    [`w_pi_m1911`] = true,
    [`w_pi_beretta`] = true,
    [`w_pi_PYTHON`] = true,
    [`w_sb_UMP45`] = true,
    -- Whitelisted Guns
    [`w_ar_SAGIRI`] = true,
    [`w_sb_scorpionblue`] = true,
    [`w_sb_blackicepeacekeeper`] = true,
    [`w_sb_DIAMONDMP5`] = true,
    [`w_ar_m4a4fire`] = true,
    [`w_ar_nerfmosin`] = true,
    [`w_sb_neonoirmac10`] = true,
    [`w_ar_blastxphantom`] = true,
    [`w_ar_grau556`] = true,
    [`w_ar_cherrymosin`] = true,
    [`w_pi_uspskillconfirmed`] = true,
    [`w_ar_hk416eft`] = true,
    [`w_sr_reaveroperator`] = true,
    [`w_sg_fortnitetacshotgun`] = true,
    [`w_sb_icevector`] = true,
    [`medievalsword`] = true,
    [`w_ar_primevandal`] = true,
    [`w_sb_umpv2neonoir`] = true,
    [`w_ar_rgxvandal`] = true,
    [`w_ar_novmosin`] = true,
    -- Whitelisted PD Guns
    [`w_ar_sa80`] = true,
    [`w_ar_m16a1pd`] = true,
    [`w_sb_mp9`] = true,
    [`w_me_vadesaber_lr`] = true,

    [`w_sr_l96a3`] = true,
    [`w_ar_m4sandstorm`] = true,
    [`w_ar_purplevandal`] = true,
    -- Devmenu
    [`a_f_m_beach_01`] = true,
    [`s_m_m_pilot_02`] = true,
}

local otherVehicles = {
    [`taxi`] = true,
    [`cascadia2019`] = true,
}

AddEventHandler('entityCreating', function(entity)
    allowSpawn = false
    for k,v in pairs(m) do
        for a,l in pairs(v) do
            if (GetEntityModel(entity)) == GetHashKey(a) or otherVehicles[(GetEntityModel(entity))] or allowedEntities[(GetEntityModel(entity))] then
                allowSpawn = true
            end
        end
    end
    if not allowSpawn then
        CancelEvent()
    end
end)

-- 
-- Type #1 [Noclip]
-- Type #2 [Spawning Weapons]
-- Type #3 [Explosion Event]
-- Type #4 [Blacklisted Event]
-- Type #5 [Removing Weapons]

-- No-Clip Handler
RegisterServerEvent("AQUA:Type1")
AddEventHandler("AQUA:Type1", function()
    local user_id = AQUA.getUserId(source)
    local player = AQUA.getUserSource(user_id)
    local name = GetPlayerName(source)
    if not AQUA.hasPermission(user_id, "admin.noclip") then -- give this group to users you do want getting banned for No-Clipping
        if not table.includes(carrying, player) then
            TriggerClientEvent("chatMessage", -1, "^7^*[ Anticheat]", {180, 0, 0}, GetPlayerName(source) .. " ^7 Was Banned | Reason: Type #1", "alert")
            Wait(500)
            adminPermID = "AQUA"
            reason = "Cheating Type #1"
            AQUA.setBanned(user_id, true, "perm", reason, adminPermID)
            f10Ban(user_id, adminPermID, reason, "perm")
            AQUA.kick(player,"[AQUA] You have been permanently banned from AQUA.  \n\nReason: " .. reason .. "\n\nYou have been banned by: " .. adminPermID .. "\n\n [Your ID: " .. user_id .. "]") 
            local webhook = "https://discord.com/api/webhooks/1043331665264644096/xMeiIpKEyiqatYJO_gExfseyaluOa8sCbNfmNyBiLV0Q4Uh2KtGB6oKnIZgB7GEqgunK"
            local command = {
                {
                    ["color"] = "3944703",
                    ["title"] = " Anticheat Logs",
                    ["description"] = "",
                    ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                    ["fields"] = {
                        {
                            ["name"] = "Player Name",
                            ["value"] = name,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player TempID",
                            ["value"] = player,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player PermID",
                            ["value"] = user_id,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Anticheat Type",
                            ["value"] = "Type #1",
                            ["inline"] = true
                        }
                    }
                }
            }
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' })
        end
    end
end)


function table.includes(table,p)
    for q,r in pairs(table)do 
        if r==p then 
            return true 
        end 
    end
    return false 
end

local BlacklistedEvents = { -- Place any events that you do not want running
    "esx:getSharedObject",
    "bank:transfer",
    "esx_ambulancejob:revive",
    "esx-qalle-jail:openJailMenu",
    "esx_jailer:wysylandoo",
    "esx_policejob:getarrested",
    "esx_society:openBossMenu",
    "esx:spawnVehicle",
    "esx_status:set",
    "HCheat:TempDisableDetection",
    "UnJP",
    "8321hiue89js",
    "adminmenu:allowall",
    "AdminMenu:giveBank",
    "AdminMenu:giveCash",
    "AdminMenu:giveDirtyMoney",
    "Tem2LPs5Para5dCyjuHm87y2catFkMpV",
    "esx_dmvschool:pay"
}

for i, eventName in ipairs(BlacklistedEvents) do
    RegisterNetEvent(eventName)
    AddEventHandler(eventName, function()
        local user_id = AQUA.getUserId(source)
        local player = AQUA.getUserSource(user_id)
        local name = GetPlayerName(source)

        TriggerClientEvent("chatMessage", -1, "^7^*[ Anticheat]", {180, 0, 0}, GetPlayerName(source) .. " ^7 Was Banned | Reason: Type #4", "alert")
        Wait(500)
        adminPermID = "AQUA"
        reason = "Cheating Type #4"
        AQUA.setBanned(user_id, true, "perm", reason, adminPermID)
        f10Ban(user_id, adminPermID, reason, "perm")
        AQUA.kick(player,"[AQUA] You have been permanently banned from AQUA.  \n\nReason: " .. reason .. "\n\nYou have been banned by: " .. adminPermID .. "\n\n [Your ID: " .. user_id .. "]") 
        local webhook = "https://discord.com/api/webhooks/1043331665264644096/xMeiIpKEyiqatYJO_gExfseyaluOa8sCbNfmNyBiLV0Q4Uh2KtGB6oKnIZgB7GEqgunK"
        local command = {
            {
                ["color"] = "3944703",
                ["title"] = " Anticheat Logs",
                ["description"] = "",
                ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                ["fields"] = {
                    {
                        ["name"] = "Player Name",
                        ["value"] = name,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Player TempID",
                        ["value"] = player,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Player PermID",
                        ["value"] = user_id,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Anticheat Type",
                        ["value"] = "Type #4",
                        ["inline"] = true
                    }
                }
            }
        }
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' })
    end)
end

RegisterServerEvent("AQUA:Type2") -- Player Spawned Weapon!
AddEventHandler("AQUA:Type2", function()
	local user_id = AQUA.getUserId(source)
	local player = AQUA.getUserSource(user_id)
	local name = GetPlayerName(source)

    TriggerClientEvent("chatMessage", -1, "^7^*[ Anticheat]", {180, 0, 0}, GetPlayerName(source) .. " ^7 Was Banned | Reason: Type #2", "alert")
    Wait(500)
    adminPermID = "AQUA"
    reason = "Cheating Type #2"
     AQUA.setBanned(user_id, true, "perm", reason, adminPermID)
     f10Ban(user_id, adminPermID, reason, "perm")
     AQUA.kick(player,"[AQUA] You have been permanently banned from AQUA.  \n\nReason: " .. reason .. "\n\nYou have been banned by: " .. adminPermID .. "\n\n [Your ID: " .. user_id .. "]") 

    local webhook = "https://discord.com/api/webhooks/1043331665264644096/xMeiIpKEyiqatYJO_gExfseyaluOa8sCbNfmNyBiLV0Q4Uh2KtGB6oKnIZgB7GEqgunK"
    local command = {
        {
            ["color"] = "3944703",
            ["title"] = " Anticheat Logs",
            ["description"] = "",
            ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
            ["fields"] = {
                {
                    ["name"] = "Player Name",
                    ["value"] = name,
                    ["inline"] = true
                },
                {
                    ["name"] = "Player TempID",
                    ["value"] = player,
                    ["inline"] = true
                },
                {
                    ["name"] = "Player PermID",
                    ["value"] = user_id,
                    ["inline"] = true
                },
                {
                    ["name"] = "Anticheat Type",
                    ["value"] = "Type #2",
                    ["inline"] = true
                }
            }
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' })
end)

local BlockedExplosions = {0, 1, 2, 4, 5, 25, 32, 33, 35, 35, 36, 37, 38, 45}

AddEventHandler('explosionEvent', function(source, ev)
    local user_id = AQUA.getUserId(source)
    local player = AQUA.getUserSource(user_id)
    local name = GetPlayerName(source)
    for k, v in ipairs(BlockedExplosions) do 
        if ev.explosionType == v then
            ev.damagescale = 0.0

            CancelEvent()

            TriggerClientEvent("chatMessage", -1, "^7^*[ Anticheat]", {180, 0, 0}, GetPlayerName(source) .. " ^7 Was Banned | Reason: Type #3", "alert")
            Wait(500)
            adminPermID = "AQUA"
            reason = "Cheating Type #3"
            AQUA.setBanned(user_id, true, "perm", reason, adminPermID)
            f10Ban(user_id, adminPermID, reason, "perm")
            AQUA.kick(player,"[AQUA] You have been permanently banned from AQUA.  \n\nReason: " .. reason .. "\n\nYou have been banned by: " .. adminPermID .. "\n\n [Your ID: " .. user_id .. "]") 

            local webhook = "https://discord.com/api/webhooks/1043331665264644096/xMeiIpKEyiqatYJO_gExfseyaluOa8sCbNfmNyBiLV0Q4Uh2KtGB6oKnIZgB7GEqgunK"
            local command = {
                {
                    ["color"] = "3944703",
                    ["title"] = " Anticheat Logs",
                    ["description"] = "",
                    ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                    ["fields"] = {
                        {
                            ["name"] = "Player Name",
                            ["value"] = name,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player TempID",
                            ["value"] = player,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player PermID",
                            ["value"] = user_id,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Anticheat Type",
                            ["value"] = "Type #3",
                            ["inline"] = true
                        }
                    }
                }
            }
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' })
        
    end
    end
end)



local WAPcrashes = {
    "GTA5.exe!sub_14145A40C (0x34)",
    "gta-streaming-five.dll!std::basic_string<char,std::char_traits<char>,std::allocator<char> >::_Reallocate_for (0x265)",
    "scripthookv.dll!nativeCall (0x379)",
    "0xf2afb40b",
    "GTA5.exe!sub_1405DB148 (0xfe)",
    "ros-patches-five.dll!SetLauncherWaitCB::__l2::<lambda>::operator() (0x126)",
    "d3d11.dll!??0?$C10and11View@UID3D11RenderTargetView1@@UID3D10RenderTargetView@@@@QEAA@AEBUSD3D11LayeredViewCreationArgs@@AEBVCSubresourceSubset@@W4ED3D11DeviceChildType@@@Z (0xec)",
    "0xf1d93de2",
    "dxgi.dll!?CreateProxyWindowImpl@ProxyWindow@@AEAAJAEBUCreationParams@1@@Z (0x25c)",
    "citizen-resources-client.dll!Concurrency::details::_ExceptionHolder::~_ExceptionHolder (0x1d)"
}



AddEventHandler("playerDropped", function(reason)
    local source = source
    local name = GetPlayerName(source)
    local user_id = AQUA.getUserId(source)
    AQUA.getUserIdByIdentifiers(GetPlayerIdentifiers(source), function(u)
        for i,v in pairs(WAPcrashes) do
            if string.match(reason, v) then
                local webhook = "https://discord.com/api/webhooks/1043331665264644096/xMeiIpKEyiqatYJO_gExfseyaluOa8sCbNfmNyBiLV0Q4Uh2KtGB6oKnIZgB7GEqgunK"
                local command = {
                    {
                        ["color"] = "3944703",
                        ["title"] = " Anticheat Logs",
                        ["description"] = "",
                        ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                        ["fields"] = {
                            {
                                ["name"] = "Player Name",
                                ["value"] = name,
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Player TempID",
                                ["value"] = player,
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Player PermID",
                                ["value"] = user_id,
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Anticheat Type",
                                ["value"] = "Type #9",
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Info",
                                ["value"] = "Player has been kicked for WAP crash",
                                ["inline"] = true
                            }
                        }
                    }
                }
                PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' })
                Wait(300)
                TriggerClientEvent("chatMessage", -1, "^7^*[ Anticheat]", {180, 0, 0}, GetPlayerName(source) .. " ^7 Was Banned | Reason: Type #9", "alert")
                Wait(100)
                adminPermID = "AQUA"
                reason = "Cheating Type #9"
                AQUA.setBanned(user_id, true, "perm", reason, adminPermID)
                f10Ban(user_id, adminPermID, reason, "perm")
            end 
        end
    end)
end)

AddEventHandler("removeWeaponEvent", function(sender, data)
    CancelEvent()
end)

AddEventHandler("giveWeaponEvent", function(source)
    CancelEvent()
    Wait(500)
    TriggerEvent("AQUA:Type9")
end)

AddEventHandler("removeAllWeaponsEvent", function(sender, data)
    CancelEvent()
end)

AddEventHandler("clearPedTasksEvent", function(source, data)
    CancelEvent()
end)

AddEventHandler("startProjectileEvent", function(source, data)
    CancelEvent()
end)

AddEventHandler("vehicleComponentControlEvent", function(source, data)
    CancelEvent()
end)

RegisterServerEvent("AQUA:Type5") -- Player Spawned Weapon!
AddEventHandler("AQUA:Type5", function()
	local user_id = AQUA.getUserId(source)
	local player = AQUA.getUserSource(user_id)
	local name = GetPlayerName(source)

    TriggerClientEvent("chatMessage", -1, "^7^*[ Anticheat]", {180, 0, 0}, GetPlayerName(source) .. " ^7 Was Banned | Reason: Type #5", "alert")
    Wait(500)
    adminPermID = "AQUA"
    reason = "Cheating Type #5"
    AQUA.setBanned(user_id, true, "perm", reason, adminPermID)
    f10Ban(user_id, adminPermID, reason, "perm")
    AQUA.kick(player,"[AQUA] You have been permanently banned from AQUA.  \n\nReason: " .. reason .. "\n\nYou have been banned by: " .. adminPermID .. "\n\n [Your ID: " .. user_id .. "]") 
    local webhook = "https://discord.com/api/webhooks/1043331665264644096/xMeiIpKEyiqatYJO_gExfseyaluOa8sCbNfmNyBiLV0Q4Uh2KtGB6oKnIZgB7GEqgunK"
    local command = {
        {
            ["color"] = "3944703",
            ["title"] = " Anticheat Logs",
            ["description"] = "",
            ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
            ["fields"] = {
                {
                    ["name"] = "Player Name",
                    ["value"] = name,
                    ["inline"] = true
                },
                {
                    ["name"] = "Player TempID",
                    ["value"] = player,
                    ["inline"] = true
                },
                {
                    ["name"] = "Player PermID",
                    ["value"] = user_id,
                    ["inline"] = true
                },
                {
                    ["name"] = "Anticheat Type",
                    ["value"] = "Type #5",
                    ["inline"] = true
                }
            }
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent("AQUA:Type6") -- Player Spawned Weapon!
AddEventHandler("AQUA:Type6", function()
	local user_id = AQUA.getUserId(source)
	local player = AQUA.getUserSource(user_id)
	local name = GetPlayerName(source)

    TriggerClientEvent("chatMessage", -1, "^7^*[ Anticheat]", {180, 0, 0}, GetPlayerName(source) .. " ^7 Was Banned | Reason: Type #6", "alert")
    Wait(500)
    adminPermID = "AQUA"
    reason = "Cheating Type #6"
    AQUA.setBanned(user_id, true, "perm", reason, adminPermID)
    f10Ban(user_id, adminPermID, reason, "perm")
    AQUA.kick(player,"[AQUA] You have been permanently banned from AQUA.  \n\nReason: " .. reason .. "\n\nYou have been banned by: " .. adminPermID .. "\n\n [Your ID: " .. user_id .. "]") 
    local webhook = "https://discord.com/api/webhooks/1043331665264644096/xMeiIpKEyiqatYJO_gExfseyaluOa8sCbNfmNyBiLV0Q4Uh2KtGB6oKnIZgB7GEqgunK"
    local command = {
        {
            ["color"] = "3944703",
            ["title"] = " Anticheat Logs",
            ["description"] = "",
            ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
            ["fields"] = {
                {
                    ["name"] = "Player Name",
                    ["value"] = name,
                    ["inline"] = true
                },
                {
                    ["name"] = "Player TempID",
                    ["value"] = player,
                    ["inline"] = true
                },
                {
                    ["name"] = "Player PermID",
                    ["value"] = user_id,
                    ["inline"] = true
                },
                {
                    ["name"] = "Anticheat Type",
                    ["value"] = "Type #6",
                    ["inline"] = true
                }
            }
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' })
end)
RegisterServerEvent("AQUA:Type7") -- Player Spawned Weapon!
AddEventHandler("AQUA:Type7", function()
	local user_id = AQUA.getUserId(source)
	local player = AQUA.getUserSource(user_id)
	local name = GetPlayerName(source)

    TriggerClientEvent("chatMessage", -1, "^7^*[ Anticheat]", {180, 0, 0}, GetPlayerName(source) .. " ^7 Was Banned | Reason: Type #7", "alert")
    Wait(500)
    adminPermID = "AQUA"
    reason = "Cheating Type #7"
    AQUA.setBanned(user_id, true, "perm", reason, adminPermID)
    f10Ban(user_id, adminPermID, reason, "perm")
    AQUA.kick(player,"[AQUA] You have been permanently banned from AQUA.  \n\nReason: " .. reason .. "\n\nYou have been banned by: " .. adminPermID .. "\n\n [Your ID: " .. user_id .. "]") 
    local webhook = "https://discord.com/api/webhooks/1043331665264644096/xMeiIpKEyiqatYJO_gExfseyaluOa8sCbNfmNyBiLV0Q4Uh2KtGB6oKnIZgB7GEqgunK"
    local command = {
        {
            ["color"] = "3944703",
            ["title"] = " Anticheat Logs",
            ["description"] = "",
            ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
            ["fields"] = {
                {
                    ["name"] = "Player Name",
                    ["value"] = name,
                    ["inline"] = true
                },
                {
                    ["name"] = "Player TempID",
                    ["value"] = player,
                    ["inline"] = true
                },
                {
                    ["name"] = "Player PermID",
                    ["value"] = user_id,
                    ["inline"] = true
                },
                {
                    ["name"] = "Anticheat Type",
                    ["value"] = "Type #7",
                    ["inline"] = true
                }
            }
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' })
end)
RegisterServerEvent("AQUA:Type8") -- Player Spawned Weapon!
AddEventHandler("AQUA:Type8", function()
	local user_id = AQUA.getUserId(source)
	local player = AQUA.getUserSource(user_id)
	local name = GetPlayerName(source)

    TriggerClientEvent("chatMessage", -1, "^7^*[ Anticheat]", {180, 0, 0}, GetPlayerName(source) .. " ^7 Was Banned | Reason: Type #8", "alert")
    Wait(500)
    adminPermID = "AQUA"
    reason = "Cheating Type #8"
    AQUA.setBanned(user_id, true, "perm", reason, adminPermID)
    f10Ban(user_id, adminPermID, reason, "perm")
    AQUA.kick(player,"[AQUA] You have been permanently banned from AQUA. \n\nReason: " .. reason .. "\n\nYou have been banned by: " .. adminPermID .. "\n\n [Your ID: " .. user_id .. "]") 
    local webhook = "https://discord.com/api/webhooks/1043331665264644096/xMeiIpKEyiqatYJO_gExfseyaluOa8sCbNfmNyBiLV0Q4Uh2KtGB6oKnIZgB7GEqgunK"
    local command = {
        {
            ["color"] = "3944703",
            ["title"] = " Anticheat Logs",
            ["description"] = "",
            ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
            ["fields"] = {
                {
                    ["name"] = "Player Name",
                    ["value"] = name,
                    ["inline"] = true
                },
                {
                    ["name"] = "Player TempID",
                    ["value"] = player,
                    ["inline"] = true
                },
                {
                    ["name"] = "Player PermID",
                    ["value"] = user_id,
                    ["inline"] = true
                },
                {
                    ["name"] = "Anticheat Type",
                    ["value"] = "Type #8",
                    ["inline"] = true
                }
            }
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent("AQUA:Type9") -- Triggering Events
AddEventHandler("AQUA:Type9", function()
	local user_id = AQUA.getUserId(source)
	local player = AQUA.getUserSource(user_id)
	local name = GetPlayerName(source)

    --TriggerClientEvent("chatMessage", -1, "^7^*[ Anticheat]", {180, 0, 0}, GetPlayerName(source) .. " ^7 Was Banned | Reason: Type #9", "alert")
    Wait(500)
    adminPermID = "AQUA"
    reason = "Cheating Type #9"
    AQUA.setBanned(user_id, true, "perm", reason, adminPermID)
    f10Ban(user_id, adminPermID, reason, "perm")
    AQUA.kick(player,"[AQUA] You have been permanently banned from AQUA.  \n\nReason: " .. reason .. "\n\nYou have been banned by: " .. adminPermID .. "\n\n [Your ID: " .. user_id .. "]") 

    local webhook = "https://discord.com/api/webhooks/1043331665264644096/xMeiIpKEyiqatYJO_gExfseyaluOa8sCbNfmNyBiLV0Q4Uh2KtGB6oKnIZgB7GEqgunK"
    local command = {
        {
            ["color"] = "3944703",
            ["title"] = " Anticheat Logs",
            ["description"] = "",
            ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
            ["fields"] = {
                {
                    ["name"] = "Player Name",
                    ["value"] = name,
                    ["inline"] = true
                },
                {
                    ["name"] = "Player TempID",
                    ["value"] = player,
                    ["inline"] = true
                },
                {
                    ["name"] = "Player PermID",
                    ["value"] = user_id,
                    ["inline"] = true
                },
                {
                    ["name"] = "Anticheat Type",
                    ["value"] = "Type #2",
                    ["inline"] = true
                }
            }
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' })
end)