RMenu.Add('SettingsMenu', 'MainMenu', RageUI.CreateMenu("", "~b~Settings Menu", tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(), "banners","settings")) 
RMenu.Add("SettingsMenu", "graphicpresets", RageUI.CreateSubMenu(RMenu:Get("SettingsMenu", "MainMenu"), "", '~b~Graphics Presets',tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(),"banners","settings"))
RMenu.Add("SettingsMenu", "changediscord", RageUI.CreateSubMenu(RMenu:Get("SettingsMenu", "MainMenu"), "", '~b~Link Discord',tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(),"banners","settings"))
RMenu.Add("SettingsMenu", "killeffects", RageUI.CreateSubMenu(RMenu:Get("SettingsMenu", "MainMenu"), "", '~b~Kill Effects',tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(),"banners","settings"))
RMenu.Add("SettingsMenu", "bloodeffects", RageUI.CreateSubMenu(RMenu:Get("SettingsMenu", "MainMenu"), "", '~b~Blood Effects',tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(),"banners","settings"))
RMenu.Add("SettingsMenu", "weaponswhitelist", RageUI.CreateSubMenu(RMenu:Get("SettingsMenu", "MainMenu"), "", '~b~Custom Weapons Owned',tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(),"banners","settings"))
RMenu.Add("SettingsMenu", "generateaccesscode", RageUI.CreateSubMenu(RMenu:Get("SettingsMenu", "weaponswhitelist"), "", '~b~Generate Access Code',tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(),"banners","settings"))
RMenu.Add("SettingsMenu", "viewwhitelisted", RageUI.CreateSubMenu(RMenu:Get("SettingsMenu", "generateaccesscode"), "", '~b~View Whilelisted Users',tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(),"banners","settings"))
local a = module("cfg/cfg_settings")
local b = 0
local c = 0
local d = 0
local e = false
local g = false
local h = false
Citizen.CreateThread(function()
    local f = GetResourceKvpString("arma_diagonalweapons") or "false"
    if f == "false" then
        b = false
        TriggerEvent("ARMA:setVerticalWeapons")
    else
        b = true
        TriggerEvent("ARMA:setDiagonalWeapons")
    end
    local g = GetResourceKvpString("arma_frontars") or "false"
    if g == "false" then
        c = false
        TriggerEvent("ARMA:setBackAR")
    else
        c = true
        TriggerEvent("ARMA:setFrontAR")
    end
    local h = GetResourceKvpString("arma_hitmarkersounds") or "false"
    if h == "false" then
        d = false
        TriggerEvent("ARMA:hsSoundsOff")
    else
        d = true
        TriggerEvent("ARMA:hsSoundsOn")
    end
    local m = GetResourceKvpString("arma_hideeventannouncement") or "false"
    if m == "false" then
        g = false
    else
        g = true
    end
    local n = GetResourceKvpString("arma_healthpercentage") or "false"
    if n == "false" then
        h = false
    else
        h = true
    end
end)
function tARMA.setDiagonalWeaponSetting(i)
    SetResourceKvp("arma_diagonalweapons", tostring(i))
end
function tARMA.setFrontARSetting(i)
    SetResourceKvp("arma_frontars", tostring(i))
end
function tARMA.setHitMarkerSetting(i)
    SetResourceKvp("arma_hitmarkersounds", tostring(i))
end
function tARMA.setCODHitMarkerSetting(i)
    SetResourceKvp("arma_codhitmarkersounds", tostring(i))
end
function tARMA.setHideEventAnnouncementFlag(p)
    SetResourceKvp("arma_hideeventannouncement", tostring(p))
end
function tARMA.getHideEventAnnouncementFlag()
    return g
end
function tARMA.setShowHealthPercentageFlag(p)
    SetResourceKvp("arma_healthpercentage", tostring(p))
end
function tARMA.getShowHealthPercentageFlag()
    return h
end
local function j(k)
    RageUI.CloseAll()
    RageUI.Visible(RMenu:Get("SettingsMenu", "settings"), k)
end
local l = {
    {"50%", 0.5},
    {"60%", 0.6},
    {"70%", 0.7},
    {"80%", 0.8},
    {"90%", 0.9},
    {"100%", 1.0},
    {"150%", 1.5},
    {"200%", 2.0},
    {"1000%", 10.0}
}
local m = {"50%", "60%", "70%", "80%", "90%", "100%", "150%", "200%", "1000%"}
local n = 6
local o = {}
local p
local q
local r
local s
RegisterNetEvent("ARMA:gotCustomWeaponsOwned",function(t)
    print("gotCustomWeaponsOwned", dump(t))
    o = t
end)
RegisterNetEvent("ARMA:generatedAccessCode",function(u)
    print("got accessCode", u)
    r = u
end)
RegisterNetEvent("ARMA:getWhitelistedUsers",function(v)
    s = v
end)
local w = {}
local function x(y, z)
    return w[y.name .. z.name]
end
local function A(y)
    local B = false
    for C, z in pairs(y.presets) do
        if w[y.name .. z.name] then
            B = true
            w[y.name .. z.name] = nil
        end
    end
    if B then
        for D, E in pairs(y.default) do
            SetVisualSettingFloat(D, E)
        end
    end
end
local function F(z)
    for D, E in pairs(z.values) do
        SetVisualSettingFloat(D, E)
    end
end
local function G(y, z, H)
    A(y)
    if H then
        w[y.name .. z.name] = true
        F(z)
    end
    local I = json.encode(w)
    SetResourceKvp("arma_graphic_presets", I)
end
local J = {
    "0%",
    "5%",
    "10%",
    "15%",
    "20%",
    "25%",
    "30%",
    "35%",
    "40%",
    "45%",
    "50%",
    "55%",
    "60%",
    "65%",
    "70%",
    "75%",
    "80%",
    "85%",
    "90%",
    "95%",
    "100%"
}
local K = {
    0.0,
    0.05,
    0.1,
    0.15,
    0.2,
    0.25,
    0.3,
    0.35,
    0.4,
    0.45,
    0.5,
    0.55,
    0.6,
    0.65,
    0.7,
    0.75,
    0.8,
    0.85,
    0.9,
    0.95,
    1.0
}
local L = {
    "25%",
    "50%",
    "75%",
    "100%",
    "125%",
    "150%",
    "175%",
    "200%",
    "250%",
    "300%",
    "350%",
    "400%",
    "450%",
    "500%",
    "750%",
    "1000%"
}
local M = {0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 7.5, 10.0}
local N = {
    "0.1s",
    "0.2s",
    "0.3s",
    "0.4s",
    "0.5s",
    "0.6s",
    "0.7s",
    "0.8s",
    "0.9s",
    "1s",
    "1.25s",
    "1.5s",
    "1.75s",
    "2.0s"
}
local O = {100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1250, 1500, 1750, 2000}
local P = {
    "Disabled",
    "Fireworks",
    "Celebration",
    "Firework Burst",
    "Water Explosion",
    "Ramp Explosion",
    "Gas Explosion",
    "Electrical Spark",
    "Electrical Explosion",
    "Concrete Impact",
    "EMP 1",
    "EMP 2",
    "EMP 3",
    "Spike Mine",
    "Kinetic Mine",
    "Tar Mine",
    "Short Burst",
    "Fog Sphere",
    "Glass Smash",
    "Glass Drop",
    "Falling Leaves",
    "Wood Smash",
    "Train Smoke",
    "Money",
    "Confetti",
    "Marbles",
    "Sparkles"
}
local Q = {
    {"DISABLED", "DISABLED", 1.0},
    {"scr_indep_fireworks", "scr_indep_firework_shotburst", 0.2},
    {"scr_xs_celebration", "scr_xs_confetti_burst", 1.2},
    {"scr_rcpaparazzo1", "scr_mich4_firework_burst_spawn", 1.0},
    {"particle cut_finale1", "cs_finale1_car_explosion_surge_spawn", 1.0},
    {"des_fib_floor", "ent_ray_fbi5a_ramp_explosion", 1.0},
    {"des_gas_station", "ent_ray_paleto_gas_explosion", 0.5},
    {"core", "ent_dst_electrical", 1.0},
    {"core", "ent_sht_electrical_box", 1.0},
    {"des_vaultdoor", "ent_ray_pro1_concrete_impacts", 1.0},
    {"scr_xs_dr", "scr_xs_dr_emp", 1.0},
    {"scr_xs_props", "scr_xs_exp_mine_sf", 1.0},
    {"veh_xs_vehicle_mods", "exp_xs_mine_emp", 1.0},
    {"veh_xs_vehicle_mods", "exp_xs_mine_spike", 1.0},
    {"veh_xs_vehicle_mods", "exp_xs_mine_kinetic", 1.0},
    {"veh_xs_vehicle_mods", "exp_xs_mine_tar", 1.0},
    {"scr_stunts", "scr_stunts_shotburst", 1.0},
    {"scr_tplaces", "scr_tplaces_team_swap", 1.0},
    {"des_fib_glass", "ent_ray_fbi2_window_break", 1.0},
    {"des_fib_glass", "ent_ray_fbi2_glass_drop", 2.5},
    {"des_stilthouse", "ent_ray_fam3_falling_leaves", 1.0},
    {"des_stilthouse", "ent_ray_fam3_wood_frags", 1.0},
    {"des_train_crash", "ent_ray_train_smoke", 1.0},
    {"core", "ent_brk_banknotes", 2.0},
    {"core", "ent_dst_inflate_ball_clr", 1.0},
    {"core", "ent_dst_gen_gobstop", 1.0},
    {"core", "ent_sht_telegraph_pole", 1.0}
}
local R = {
    "Disabled",
    "BikerFilter",
    "CAMERA_BW",
    "drug_drive_blend01",
    "glasses_blue",
    "glasses_brown",
    "glasses_Darkblue",
    "glasses_green",
    "glasses_purple",
    "glasses_red",
    "helicamfirst",
    "hud_def_Trevor",
    "Kifflom",
    "LectroDark",
    "MP_corona_tournament_DOF",
    "MP_heli_cam",
    "mugShot",
    "NG_filmic02",
    "REDMIST_blend",
    "trevorspliff",
    "ufo",
    "underwater",
    "WATER_LAB",
    "WATER_militaryPOOP",
    "WATER_river",
    "WATER_salton"
}
local S = {
    lightning = false,
    pedFlash = false,
    pedFlashRGB = {11, 11, 11},
    pedFlashIntensity = 4,
    pedFlashTime = 1,
    screenFlash = false,
    screenFlashRGB = {11, 11, 11},
    screenFlashIntensity = 4,
    screenFlashTime = 1,
    particle = 1,
    timecycle = 1,
    timecycleTime = 1
}
local T = 0
local function U()
    local V = json.encode(S)
    SetResourceKvp("arma_kill_effects", V)
end
local W = {head = 1, body = 1, arms = 1, legs = 1}
local function X()
    local Y = json.encode(W)
    SetResourceKvp("arma_blood_effects", Y)
end
Citizen.CreateThread(function()
    Citizen.Wait(1000)
    local I = GetResourceKvpString("arma_graphic_presets")
    if I and I ~= "" then
        w = json.decode(I) or {}
    end
    for C, y in pairs(a.presets) do
        for C, z in pairs(y.presets) do
            if x(y, z) then
                F(z)
            end
        end
    end
    local V = GetResourceKvpString("arma_kill_effects")
    if V and V ~= "" then
        local Z = json.decode(V)
        for _, H in pairs(Z) do
            if S[_] then
                S[_] = H
            end
        end
    end
    local Y = GetResourceKvpString("arma_blood_effects")
    if Y and Y ~= "" then
        local Z = json.decode(Y)
        for _, H in pairs(Z) do
            if W[_] then
                W[_] = H
            end
        end
    end
end)
RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('SettingsMenu', 'MainMenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if tARMA.isNewPlayer() then
                drawNativeNotification("Press ~INPUT_REPLAY_START_STOP_RECORDING_SECONDARY~ to toggle the Settings Menu.")
            end
            RageUI.List("Render Distance Modifier",m,n,"~g~Lowering this will increase your FPS!",{},true,function(a0, a1, a2, a3)
                n = a3
            end,function()end,nil)
            local function a4()
                TriggerEvent("ARMA:setDiagonalWeapons")
                b = true
                tARMA.setDiagonalWeaponSetting(b)
            end
            local function a5()
                TriggerEvent("ARMA:setVerticalWeapons")
                b = false
                tARMA.setDiagonalWeaponSetting(b)
            end
            RageUI.Checkbox("Enable Diagonal Weapons","~g~This changes the way weapons look on your back from vertical to diagonal.",b,{RightBadge = RageUI.CheckboxStyle.Car},function(a0, a2, a1, a6)
            end,a4,a5)
            RageUI.Checkbox("Enable Front Assault Rifles","~g~This changes the positioning of Assault Rifles from back to front.",c,{RightBadge = RageUI.CheckboxStyle.Car},function()
            end,
            function()
                TriggerEvent("ARMA:setFrontAR")
                c = true
                tARMA.setFrontARSetting(c)
            end,
            function()
                TriggerEvent("ARMA:setBackAR")
                c = false
                tARMA.setFrontARSetting(c)
            end)
            local function a4()
                TriggerEvent("ARMA:hsSoundsOn")
                d = true
                tARMA.setHitMarkerSetting(d)
                tARMA.notify("~y~Experimental Headshot sounds now set to " .. tostring(d))
            end
            local function a5()
                TriggerEvent("ARMA:hsSoundsOff")
                d = false
                tARMA.setHitMarkerSetting(d)
                tARMA.notify("~y~Experimental Headshot sounds now set to " .. tostring(d))
            end
            RageUI.Checkbox("Enable Experimental Hit Marker Sounds","~g~This adds 'hit marker' sounds when shooting another player, however it can be unreliable.",d,{RightBadge = RageUI.CheckboxStyle.Car},function(a0, a2, a1, a6)
            end,a4,a5)
            RageUI.ButtonWithStyle("Weapon Whitelists","Sell your custom weapon whitelists here.",{RightLabel = "→→→"},true,function(a0, a1, a2)
                if a2 then
                    r = nil
                    p = nil
                    q = nil
                    s = nil
                    TriggerServerEvent("ARMA:getCustomWeaponsOwned")
                end
            end,RMenu:Get("SettingsMenu", "weaponswhitelist"))
            -- RageUI.ButtonWithStyle("Store Inventory","View your store inventory here.",{RightLabel = "→→→"},true,function()
            -- end,RMenu:Get("store", "mainmenu"))
            RageUI.Checkbox("Streetnames","",tARMA.isStreetnamesEnabled(),{RightBadge = RageUI.CheckboxStyle.Car},function(a0, a2, a1, a6)
            end,
            function()
                tARMA.setStreetnamesEnabled(true)
            end,
            function()
                tARMA.setStreetnamesEnabled(false)
            end)
            RageUI.Checkbox("Compass","",tARMA.isCompassEnabled(),{RightBadge = RageUI.CheckboxStyle.Car},function(a0, a2, a1, a6)
            end,
            function()
                tARMA.setCompassEnabled(true)
            end,
            function()
                tARMA.setCompassEnabled(false)
            end)
            local function a4()
                tARMA.hideUI()
                hideUI = true
            end
            local function a5()
                tARMA.showUI()
                hideUI = false
            end
            RageUI.Checkbox("Hide UI","",hideUI,{RightBadge = RageUI.CheckboxStyle.Car},function(a0, a2, a1, a6)
            end,a4,a5)
            local function a4()
                tARMA.toggleBlackBars()
                e = true
            end
            local function a5()
                tARMA.toggleBlackBars()
                e = false
            end
            RageUI.Checkbox("Cinematic Black Bars","",e,{RightBadge = RageUI.CheckboxStyle.Car},function(a0, a2, a1, a6)
            end,a4,a5)
            RageUI.Checkbox("Show Health Percentage","Displays the health and armour percentage on the bars.",h,{},function()
            end,function()
                h = true
                tARMA.setShowHealthPercentageFlag(true)
            end,function()
                h = false
                tARMA.setShowHealthPercentageFlag(false)
            end)
            RageUI.Checkbox("Hide Event Announcements","Hides the big scaleform from displaying across your screen, will still announce in chat.",g,{},function()
            end,function()
                g = true
                tARMA.setHideEventAnnouncementFlag(true)
            end,function()
                g = false
                tARMA.setHideEventAnnouncementFlag(false)
            end)
            RageUI.ButtonWithStyle("Change Linked Discord","Begins the process of changing your linked Discord. Your linked discord is used to sync roles with the server.",{RightLabel = "→→→"},true,function(a0, a1, a2)
                if a2 then
                    TriggerServerEvent('ARMA:changeLinkedDiscord')
                end
            end)
            RageUI.ButtonWithStyle("Crosshair","Create a custom built-in crosshair here.",{RightLabel = "→→→"},true,function(a0, a1, a2)
            end,RMenu:Get("crosshair", "main"))
            RageUI.ButtonWithStyle("Scope Settings","Add a toggleable range finder when using sniper scopes.",{RightLabel = "→→→"},true,function(a0, a1, a2)
            end,RMenu:Get("scope", "main"))
            RageUI.ButtonWithStyle("Graphic Presets","View a list of preconfigured graphic settings.",{RightLabel = "→→→"},true,function()
            end,RMenu:Get("SettingsMenu", "graphicpresets"))
            RageUI.ButtonWithStyle("Kill Effects","Toggle effects that occur on killing a player.",{RightLabel = "→→→"},true,function()
            end,RMenu:Get("SettingsMenu", "killeffects"))
            RageUI.ButtonWithStyle("Blood Effects","Toggle effects that occur when damaging a player.",{RightLabel = "→→→"},true,function()
            end,RMenu:Get("SettingsMenu", "bloodeffects"))
        end)
    end
    if RageUI.Visible(RMenu:Get('SettingsMenu', 'changediscord')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.Separator('~g~A code has been messaged to the Discord account')
            RageUI.Separator('-----')
            RageUI.Separator('~y~If you have not received a message verify:')
            RageUI.Separator('~y~1. Your direct messages are open.')
            RageUI.Separator('~y~2. The account you provided was correct.')
            RageUI.Separator('-----')
            RageUI.ButtonWithStyle("Enter Code","",{RightLabel = "→→→"},true,function(a0, a1, a2)
                if a2 then
                    TriggerServerEvent('ARMA:enterDiscordCode')
                end
            end)
        end)
    end
    if RageUI.Visible(RMenu:Get('SettingsMenu', 'weaponswhitelist')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            for a7, a8 in pairs(o) do
                RageUI.ButtonWithStyle(a8,"",{RightLabel = "→→→"},true,function(a0, a1, a2)
                    if a2 then
                        p = a8
                        q = a7
                        s = nil
                    end
                end,RMenu:Get("SettingsMenu", "generateaccesscode"))
            end
            RageUI.Separator("~y~If you do not see your custom weapon here.")
            RageUI.Separator("~y~Please open a ticket on our support discord.")
        end)
    end
    if RageUI.Visible(RMenu:Get('SettingsMenu', 'generateaccesscode')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.Separator("~g~Weapon Whitelist for " .. p)
            RageUI.Separator("How it works:")
            RageUI.Separator("You generate an access code for the player who wishes")
            RageUI.Separator("to purchase your custom weapon whitelist, which they ")
            RageUI.Separator("then enter on the store to receive their automated")
            RageUI.Separator("weapon whitelist.")
            RageUI.ButtonWithStyle("Create access code","",{RightLabel = "→→→"},true,function(a0, a1, a2)
                if a2 then
                    local a9 = getGenericTextInput("User ID of player purchasing your weapon whitelist.")
                    if tonumber(a9) then
                        a9 = tonumber(a9)
                        if a9 > 0 then
                            print("selling", q, "to", a9)
                            TriggerServerEvent("ARMA:generateWeaponAccessCode", q, a9)
                        end
                    end
                end
            end)
            RageUI.ButtonWithStyle("View whitelisted users","",{RightLabel = "→→→"},true,function(a0, a1, a2)
                if a2 then
                    TriggerServerEvent("ARMA:requestWhitelistedUsers", q)
                end
            end,RMenu:Get("SettingsMenu", "viewwhitelisted"))
            if r then
                RageUI.Separator("~g~Access code generated: " .. r)
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('SettingsMenu', 'viewwhitelisted')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.Separator("~g~Whitelisted users for " .. p)
            if s == nil then
                RageUI.Separator("~r~Requesting whitelisted users...")
            else
                for aa, ab in pairs(s) do
                    RageUI.ButtonWithStyle("ID: " .. tostring(aa),"",{RightLabel = ab},true,function()
                    end)
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('SettingsMenu', 'graphicpresets')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            for C, y in pairs(a.presets) do
                RageUI.Separator(y.name)
                for C, z in pairs(y.presets) do
                    local ac = x(y, z)
                    RageUI.Checkbox(z.name,nil,ac,{},function(a0, a2, a1, a6)
                        if a6 ~= ac then
                            G(y, z, a6)
                        end
                    end,function()end,function()end)
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('SettingsMenu', 'killeffects')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.Checkbox("Create Lightning","",S.lightning,{},function(a0, a2, a1, a6)
                if a2 then
                    S.lightning = a6
                    U()
                end
            end)
            RageUI.Checkbox("Ped Flash","",S.pedFlash,{},function(a0, a2, a1, a6)
                if a2 then
                    S.pedFlash = a6
                    U()
                end
            end)
            if S.pedFlash then
                RageUI.List("Ped Flash Red",J,S.pedFlashRGB[1],"",{},S.pedFlash,function(a0, a1, a2, a3)
                    if a1 and S.pedFlashRGB[1] ~= a3 then
                        S.pedFlashRGB[1] = a3
                        U()
                    end
                end,function()end)
                RageUI.List("Ped Flash Green",J,S.pedFlashRGB[2],"",{},S.pedFlash,function(a0, a1, a2, a3)
                    if a1 and S.pedFlashRGB[2] ~= a3 then
                        S.pedFlashRGB[2] = a3
                        U()
                    end
                end,function()end)
                RageUI.List("Ped Flash Blue",J,S.pedFlashRGB[3],"",{},S.pedFlash,function(a0, a1, a2, a3)
                    if a1 and S.pedFlashRGB[3] ~= a3 then
                        S.pedFlashRGB[3] = a3
                        U()
                    end
                end,function()end)
                RageUI.List("Ped Flash Intensity",L,S.pedFlashIntensity,"",{},S.pedFlash,function(a0, a1, a2, a3)
                    if a1 and S.pedFlashIntensity ~= a3 then
                        S.pedFlashIntensity = a3
                        U()
                    end
                end,function()end)
                RageUI.List("Ped Flash Time",N,S.pedFlashTime,"",{},S.pedFlash,function(a0, a1, a2, a3)
                    if a1 and S.pedFlashTime ~= a3 then
                        S.pedFlashTime = a3
                        U()
                    end
                end,function()end)
            end
            RageUI.Checkbox("Screen Flash","",S.screenFlash,{},function(a0, a2, a1, a6)
                if a2 then
                    S.screenFlash = a6
                    U()
                end
            end)
            if S.screenFlash then
                RageUI.List("Screen Flash Red",J,S.screenFlashRGB[1],"",{},S.screenFlash,function(a0, a1, a2, a3)
                    if a1 and S.screenFlashRGB[1] ~= a3 then
                        S.screenFlashRGB[1] = a3
                        U()
                    end
                end,function()end)
                RageUI.List("Screen Flash Green",J,S.screenFlashRGB[2],"",{},S.screenFlash,function(a0, a1, a2, a3)
                        if a1 and S.screenFlashRGB[2] ~= a3 then
                            S.screenFlashRGB[2] = a3
                            U()
                        end
                    end,function()end)
                RageUI.List("Screen Flash Blue",J,S.screenFlashRGB[3],"",{},S.screenFlash,function(a0, a1, a2, a3)
                    if a1 and S.screenFlashRGB[3] ~= a3 then
                        S.screenFlashRGB[3] = a3
                        U()
                    end
                end,function()end)
                RageUI.List("Screen Flash Intensity",L,S.screenFlashIntensity,"",{},S.screenFlash,function(a0, a1, a2, a3)
                    if a1 and S.screenFlashIntensity ~= a3 then
                        S.screenFlashIntensity = a3
                        U()
                    end
                end,function()end)
                RageUI.List("Screen Flash Time",N,S.screenFlashTime,"",{},S.screenFlash,function(a0, a1, a2, a3)
                    if a1 and S.screenFlashTime ~= a3 then
                        S.screenFlashTime = a3
                        U()
                    end
                end,function()end)
            end
            RageUI.List("Timecycle Flash",R,S.timecycle,"",{},true,function(a0, a1, a2, a3)
                if a1 and S.timecycle ~= a3 then
                    S.timecycle = a3
                    U()
                end
            end,function()end)
            if S.timecycle ~= 1 then
                RageUI.List("Timecycle Flash Time",N,S.timecycleTime,"",{},true,function(a0, a1, a2, a3)
                    if a1 and S.timecycleTime ~= a3 then
                        S.timecycleTime = a3
                        U()
                    end
                end,function()end)
            end
            RageUI.List("~y~Particles~w~",P,S.particle,"",{},true,function(a0, a1, a2, a3)
                if a1 and S.particle ~= a3 then
                    if not tARMA.isPlusClub() and not tARMA.isPlatClub() then
                        notify("~y~You need to be a subscriber of ARMA Plus or ARMA Platinum to use this feature.")
                        notify("~y~Available @ store.armarp.co.uk")
                    end
                    S.particle = a3
                    U()
                end
            end,function()end)
            local ad = 0
            if S.lightning then
                ad = math.max(ad, 1000)
            end
            if S.pedFlash then
                ad = math.max(ad, O[S.pedFlashTime])
            end
            if S.screenFlash then
                ad = math.max(ad, O[S.screenFlashTime])
            end
            if S.timecycleTime ~= 1 then
                ad = math.max(ad, K[S.timecycleTime])
            end
            if S.particle ~= 1 then
                ad = math.max(ad, 1000)
            end
            if GetGameTimer() - T > ad + 1000 then
                tARMA.addKillEffect(PlayerPedId(), true)
                T = GetGameTimer()
            end
            DrawAdvancedTextNoOutline(0.59, 0.9, 0.005, 0.0028, 1.5, "PREVIEW", 255, 0, 0, 255, 2, 0)
        end)
    end
    if RageUI.Visible(RMenu:Get('SettingsMenu', 'bloodeffects')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.List("~y~Head",P,W.head,"Effect that displays when you hit the head.",{},true,function(a0, a1, a2, a3)
                if W.head ~= a3 then
                    if not tARMA.isPlusClub() and not tARMA.isPlatClub() then
                        notify("~y~You need to be a subscriber of ARMA Plus or ARMA Platinum to use this feature.")
                        notify("~y~Available @ store.armarp.co.uk")
                    end
                    W.head = a3
                    X()
                end
                if a2 then
                    tARMA.addBloodEffect("head", 0x796E, PlayerPedId())
                end
            end)
            RageUI.List("~y~Body",P,W.body,"Effect that displays when you hit the body.",{},true,function(a0, a1, a2, a3)
                if W.body ~= a3 then
                    if not tARMA.isPlusClub() and not tARMA.isPlatClub() then
                        notify("~y~You need to be a subscriber of ARMA Plus or ARMA Platinum to use this feature.")
                        notify("~y~Available @ store.armarp.co.uk")
                    end
                    W.body = a3
                    X()
                end
                if a2 then
                    tARMA.addBloodEffect("body", 0x0, PlayerPedId())
                end
            end)
            RageUI.List("~y~Arms",P,W.arms,"Effect that displays when you hit the arms.",{},true,function(a0, a1, a2, a3)
                if W.arms ~= a3 then
                    if not tARMA.isPlusClub() and not tARMA.isPlatClub() then
                        notify("~y~You need to be a subscriber of ARMA Plus or ARMA Platinum to use this feature.")
                        notify("~y~Available @ store.armarp.co.uk")
                    end
                    W.arms = a3
                    X()
                end
                if a2 then
                    tARMA.addBloodEffect("arms", 0xBB0, PlayerPedId())
                    tARMA.addBloodEffect("arms", 0x58B7, PlayerPedId())
                end
            end)
            RageUI.List("~y~Legs",P,W.legs,"Effect that displays when you hit the legs.",{},true,function(a0, a1, a2, a3)
                if W.legs ~= a3 then
                    if not tARMA.isPlusClub() and not tARMA.isPlatClub() then
                        notify("~y~You need to be a subscriber of ARMA Plus or ARMA Platinum to use this feature.")
                        notify("~y~Available @ store.armarp.co.uk")
                    end
                    W.legs = a3
                    X()
                end
                if a2 then
                    tARMA.addBloodEffect("legs", 0x3FCF, PlayerPedId())
                    tARMA.addBloodEffect("legs", 0xB3FE, PlayerPedId())
                end
            end)
        end)
    end
end)

RegisterNetEvent('ARMA:OpenSettingsMenu')
AddEventHandler('ARMA:OpenSettingsMenu', function(admin)
    if not admin then
        RageUI.Visible(RMenu:Get("SettingsMenu", "MainMenu"), true)
    end
end)
RegisterCommand('opensettingsmenu',function()
    TriggerServerEvent('ARMA:OpenSettings')
end)
RegisterKeyMapping('opensettingsmenu', 'Opens the Settings menu', 'keyboard', 'F2')
Citizen.CreateThread(function()
    while true do
        OverrideLodscaleThisFrame(l[n][2])
        if not (tARMA.getStaffLevel() > 0) then
            if IsUsingKeyboard(2) and IsControlJustPressed(1, 289) then
                RageUI.Visible(RMenu:Get("SettingsMenu", "MainMenu"),not RageUI.Visible(RMenu:Get("SettingsMenu", "MainMenu")))
            end
        end
        Wait(0)
    end
end)
AddEventHandler("ARMA:enteredCity",function()end)
AddEventHandler("ARMA:leftCity",function()end)
local function af(ag)
    local ah = GetEntityCoords(ag, true)
    local ai = GetGameTimer()
    local aj = math.floor(K[S.pedFlashRGB[1]] * 255)
    local ak = math.floor(K[S.pedFlashRGB[2]] * 255)
    local al = math.floor(K[S.pedFlashRGB[3]] * 255)
    local am = M[S.pedFlashIntensity]
    local an = O[S.pedFlashTime]
    while GetGameTimer() - ai < an do
        local ao = (an - (GetGameTimer() - ai)) / an
        local ap = am * 25.0 * ao
        DrawLightWithRange(ah.x, ah.y, ah.z + 1.0, aj, ak, al, 50.0, ap)
        Citizen.Wait(0)
    end
end
local function aq()
    local ai = GetGameTimer()
    local aj = math.floor(K[S.screenFlashRGB[1]] * 255)
    local ak = math.floor(K[S.screenFlashRGB[2]] * 255)
    local al = math.floor(K[S.screenFlashRGB[3]] * 255)
    local am = M[S.screenFlashIntensity]
    local an = O[S.screenFlashTime]
    while GetGameTimer() - ai < an do
        local ao = (an - (GetGameTimer() - ai)) / an
        local ap = math.floor(25.5 * am * ao)
        DrawRect(0.0, 0.0, 2.0, 2.0, aj, ak, al, ap)
        Citizen.Wait(0)
    end
end
local function ar(ag)
    local ah = GetEntityCoords(ag, true)
    local as = Q[S.particle]
    tARMA.loadPtfx(as[1])
    UseParticleFxAsset(as[1])
    StartParticleFxNonLoopedAtCoord(as[2], ah.x, ah.y, ah.z, 0.0, 0.0, 0.0, as[3], false, false, false)
    RemoveNamedPtfxAsset(as[1])
end
local function at()
    local ai = GetGameTimer()
    local an = O[S.timecycleTime]
    SetTimecycleModifier(R[S.timecycle])
    while GetGameTimer() - ai < an do
        local ao = (an - (GetGameTimer() - ai)) / an
        SetTimecycleModifierStrength(1.0 * ao)
        Citizen.Wait(0)
    end
    ClearTimecycleModifier()
end
function tARMA.addKillEffect(au, av)
    if S.lightning then
        ForceLightningFlash()
    end
    if S.pedFlash then
        Citizen.CreateThreadNow(function()
            af(au)
        end)
    end
    if S.screenFlash then
        Citizen.CreateThreadNow(function()
            aq()
        end)
    end
    if S.particle ~= 1 and (tARMA.isPlatClub() or av) then
        Citizen.CreateThreadNow(function()
            ar(au)
        end)
    end
    if S.timecycle ~= 1 then
        Citizen.CreateThreadNow(function()
            at()
        end)
    end
end
function tARMA.addBloodEffect(aw, ax, ag)
    local ay = W[aw]
    if ay > 1 then
        local as = Q[ay]
        tARMA.loadPtfx(as[1])
        UseParticleFxAsset(as[1])
        StartParticleFxNonLoopedOnPedBone(as[2], ag, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, ax, as[3], false, false, false)
        RemoveNamedPtfxAsset(as[1])
    end
end
AddEventHandler("ARMA:onPlayerKilledPed",function(az)
    tARMA.addKillEffect(az, false)
end)
local aA = {
    [0x0] = "body",
    [0x2E28] = "body",
    [0xE39F] = "legs",
    [0xF9BB] = "legs",
    [0x3779] = "legs",
    [0x83C] = "legs",
    [0xCA72] = "legs",
    [0x9000] = "legs",
    [0xCC4D] = "legs",
    [0x512D] = "legs",
    [0xE0FD] = "body",
    [0x5C01] = "body",
    [0x60F0] = "body",
    [0x60F1] = "body",
    [0x60F2] = "body",
    [0xFCD9] = "body",
    [0xB1C5] = "arms",
    [0xEEEB] = "arms",
    [0x49D9] = "arms",
    [0x67F2] = "arms",
    [0xFF9] = "arms",
    [0xFFA] = "arms",
    [0x67F3] = "arms",
    [0x1049] = "arms",
    [0x104A] = "arms",
    [0x67F4] = "arms",
    [0x1059] = "arms",
    [0x105A] = "arms",
    [0x67F5] = "arms",
    [0x1029] = "arms",
    [0x102A] = "arms",
    [0x67F6] = "arms",
    [0x1039] = "arms",
    [0x103A] = "arms",
    [0x29D2] = "arms",
    [0x9D4D] = "arms",
    [0x6E5C] = "arms",
    [0xDEAD] = "arms",
    [0xE5F2] = "arms",
    [0xFA10] = "arms",
    [0xFA11] = "arms",
    [0xE5F3] = "arms",
    [0xFA60] = "arms",
    [0xFA61] = "arms",
    [0xE5F4] = "arms",
    [0xFA70] = "arms",
    [0xFA71] = "arms",
    [0xE5F5] = "arms",
    [0xFA40] = "arms",
    [0xFA41] = "arms",
    [0xE5F6] = "arms",
    [0xFA50] = "arms",
    [0xFA51] = "arms",
    [0x9995] = "head",
    [0x796E] = "head",
    [0x5FD4] = "head",
    [0xD003] = "body",
    [0x45FC] = "body",
    [0x1D6B] = "legs",
    [0xB23F] = "legs"
}
AddEventHandler("ARMA:onPlayerDamagePed",function(az)
    if not tARMA.isPlusClub() and not tARMA.isPlatClub() then
        return
    end
    local aB, ax = GetPedLastDamageBone(az, 0)
    if aB then
        local aC = GetPedBoneIndex(az, ax)
        local aD = GetWorldPositionOfEntityBone(az, aC)
        local aE = aA[ax]
        if not aE then
            local aF = GetWorldPositionOfEntityBone(az, GetPedBoneIndex(az, 0x9995))
            local aG = GetWorldPositionOfEntityBone(az, GetPedBoneIndex(az, 0x2E28))
            if aD.z >= aF.z - 0.01 then
                aE = "head"
            elseif aD.z < aG.z then
                aE = "legs"
            else
                local aH = GetEntityCoords(az, true)
                local aI = #(aH.xy - aD.xy)
                if aI > 0.075 then
                    aE = "arms"
                else
                    aE = "body"
                end
            end
        end
        tARMA.addBloodEffect(aE, ax, az)
    end
end)

RegisterNetEvent("ARMA:gotDiscord")
AddEventHandler("ARMA:gotDiscord",function()
    RageUI.Visible(RMenu:Get('SettingsMenu', 'changediscord'), true)
end)