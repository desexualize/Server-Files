local user_id = 0
local foundMatch = false
local inSpectatorAdminMode = false
local players = {}
local searchPlayerGroups = {}
local selectedGroup
local Groups = {}
local povlist = false
local SelectedPerm = nil
local garageCategorySelected
local veh
local b = false
local q = {"Speed", "Drift", "Handling", "City", "Airport"}
local r = {
    vector3(2370.8, 2856.58, 40.46),
    vector3(974.58, -3006.6, 5.9),
    vector3(1894.57, 3823.71, 31.98),
    vector3(-482.63, -664.24, 32.74),
    vector3(-1728.25, -2894.99, 13.94)
}
local s = 1
local savedCoords = nil
local acbannedplayers = 0
local acadminname = ''
local acbannedplayerstable = {}
local acplayerstable = {}
local actypes = {}
local garageCategorySelected
local veh
local m = module("ERP-Veh", "cfg/cfg_garages")
m=m.garage_types
admincfg = {}

admincfg.perm = "admin.tickets"
admincfg.IgnoreButtonPerms = false
admincfg.admins_cant_ban_admins = false


--[[ {enabled -- true or false}, permission required ]]
admincfg.buttonsEnabled = {


    --[[ admin Menu ]]
    ["adminMenu"] = {true, "admin.tickets"},
    ["warn"] = {true, "admin.warn"},      
    ["showwarn"] = {true, "admin.showwarn"},
    ["ban"] = {true, "admin.ban"},
    ["kick"] = {true, "admin.kick"},
    ["nof10kick"] = {true, "admin.nof10kick"},
    ["revive"] = {true, "admin.revive"},
    ["TP2"] = {true, "admin.tp2player"},
    ["TP2ME"] = {true, "admin.summon"},
    ["FREEZE"] = {true, "admin.freeze"},
    ["spectate"] = {true, "admin.spectate"}, 
    ["SS"] = {true, "admin.screenshot"},
    ["slap"] = {true, "admin.slap"},
    ["giveMoney"] = {true, "admin.givemoney"},
    ["addcar"] = {true, "admin.addcar"},

    --[[ Functions ]]
    ["tp2waypoint"] = {true, "admin.tp2waypoint"},
    ["tp2coords"] = {true, "admin.tp2coords"},
    ["removewarn"] = {true, "admin.removewarn"},
    ["spawntaxi"] = {true, "admin.spawntaxi"},
    ["spawnGun"] = {true, "admin.spawnGun"},

    --[[ Add Groups ]]
    ["getgroups"] = {true, "group.add"},
    ["staffGroups"] = {true, "admin.staffAddGroups"},
    ["mpdGroups"] = {true, "admin.mpdAddGroups"},
    ["povGroups"] = {true, "admin.povAddGroups"},
    ["licenseGroups"] = {true, "admin.licenseAddGroups"},
    ["donoGroups"] = {true, "admin.donoAddGroups"},
    ["nhsGroups"] = {true, "admin.nhsAddGroups"},

    --[[ Vehicle Functions ]]
    ["vehFunctions"] = {true, "admin.vehmenu"},
    ["noClip"] = {true, "admin.noclip"},

    -- [[ Developer Functions ]]
    ["devMenu"] = {true, "dev.menu"},
}



RMenu.Add('adminmenu', 'main', RageUI.CreateMenu("", "ERP Admin Menu", 1300,100, "adminmenu","adminmenu"))
RMenu.Add("adminmenu", "players", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main")))
RMenu.Add("adminmenu", "searchoptions", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main")))
RMenu.Add("adminmenu", "settings", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main"),"","ERP Admin Menu", 1300, 100,"adminmenu","adminmenu"))
RMenu.Add("adminmenu", "crosshair", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main"),"","ERP Admin Menu", 1300, 100,"adminmenu","adminmenu"))
--[[ Functions ]]
RMenu.Add("adminmenu", "functions", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main")))
RMenu.Add("adminmenu", "generalfunctions", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main")))
RMenu.Add("adminmenu", "entityfunctions", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main")))
RMenu.Add("adminmenu", "vehiclefunctions", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main")))
RMenu.Add("adminmenu", "devfunctions", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main")))
--[[ End of Functions ]]

RMenu.Add("adminmenu", "submenu", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "players")))
RMenu.Add("adminmenu", "searchname", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "searchoptions")))
RMenu.Add("adminmenu", "searchtempid", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "searchoptions")))
RMenu.Add("adminmenu", "searchpermid", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "searchoptions")))
RMenu.Add("adminmenu", "teleportmenu", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "players")))
RMenu.Add("adminmenu", "warnsub", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "players")))
RMenu.Add("adminmenu", "bansub", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "players")))

--[[groups]]
RMenu.Add("adminmenu", "groups", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "submenu")))
RMenu.Add("adminmenu", "staffGroups", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups")))
RMenu.Add("adminmenu", "LicenseGroups", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups")))
RMenu.Add("adminmenu", "UserGroups", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups")))
RMenu.Add("adminmenu", "POVGroups", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups")))
RMenu.Add("adminmenu", "PoliceGroups", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups")))
RMenu.Add("adminmenu", "NHSGroups", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups")))
RMenu.Add("adminmenu", "addgroup", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups")))
RMenu.Add("adminmenu", "removegroup", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups")))

--[[Cardev]]
RMenu.Add('cardev', 'vehiclelist', RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main"), "", "Vehicle Spawner", 1300, 100, "adminmenu", "adminmenu"))
RMenu.Add('cardev', 'vehiclelistmain', RageUI.CreateSubMenu(RMenu:Get("cardev", "vehiclelist"), "", "Vehicle Spawner", 1300, 100, "adminmenu", "adminmenu"))
RMenu.Add('cardev', 'vehiclelistspawn', RageUI.CreateSubMenu(RMenu:Get("cardev", "vehiclelistmain"), "", "Vehicle Spawner", 1300, 100, "adminmenu", "adminmenu"))

--[[ AntiCheat ]]
menuColour = '~b~'
RMenu.Add('anticheat', 'main', RageUI.CreateMenu("", menuColour..'AntiCheat Menu',1300,100,"adminmenu","adminmenu"))
RMenu.Add("anticheat", "actypes", RageUI.CreateSubMenu(RMenu:Get("anticheat", "main"), "", menuColour..'AC Types',1300,100,"adminmenu","adminmenu"))
RMenu.Add("anticheat", "acbannedplayers", RageUI.CreateSubMenu(RMenu:Get("anticheat", "main"), "", menuColour..'AC Banned Players',1300,100,"adminmenu","adminmenu"))
RMenu.Add("anticheat", "acbanmenu", RageUI.CreateSubMenu(RMenu:Get("anticheat", "main"), "", menuColour..'AC Banned Player Submenu',1300,100,"adminmenu","adminmenu"))
RMenu.Add("anticheat", "acmanualbanlist", RageUI.CreateSubMenu(RMenu:Get("anticheat", "main"), "", menuColour..'AC Manual Ban',1300,100,"adminmenu","adminmenu"))
RMenu.Add("anticheat", "acmanualban", RageUI.CreateSubMenu(RMenu:Get("anticheat", "main"), "", menuColour..'Choose an AC Type to ban for',1300,100,"adminmenu","adminmenu"))
RMenu.Add("anticheat", "confirmacban", RageUI.CreateSubMenu(RMenu:Get("anticheat", "main"), "", menuColour..'Confirm AC Ban',1300,100,"adminmenu","adminmenu"))

RMenu:Get('adminmenu', 'main')

local getStaffGroupsGroupIds = {
	["founder"] = "Founder",
    ["opmanager"] = "Operations Manager",
    ["staffmanager"] = "Staff Manager",
    ["commanager"] = "Community Manager",
    ["headadmin"] = "Head Admin",
    ["senioradmin"] = "Senior Admin",
	["administrator"] = "Admin",
    ["dev"] = "Developer",
    ["srmoderator"] = "Senior Moderator",
	["moderator"] = "Moderator",
    ["supportteam"] = "Support Team",
    ["trialstaff"] = "Trial Staff",
}
local getUserGroupsGroupIds = {
    ["VIP"] = "VIP",
}
local getUserLicenseGroups = {
    ["Garbage Job"] = "Garbage Job License",
    ["Weed"] = "Weed License",
    ["Diamond"] = "Diamond License",
    ["Heroin"] = "Heroin License",
    ["LSD"] = "LSD License",
    ["Rebel"] = "Rebel License",
    ["largearms"] = "Large Arms License",
    ["LiteCoin"] = "Litecoin License",
    ["BitCoin"] = "Bitcoin License",
}
local getUserPOVGroups = {
    ["pov"] = "POV List",
}

local getUserPoliceGroups = {
    ["Commissioner"] = "Commissioner",
    ["Deputy Commissioner"] = "Deputy Commissioner",
    ["Assistant Commissioner"] = "Assistant Commissioner",
    ["Deputy Assistant Commissioner"] = "Deputy Assistant Commissioner",
    ["Commander"] = "Commander",
    ["Chief Superintendent"] = "Chief Superintendent",
    ["Superintendent"] = "Superintendent",
    ["Chief Inspector"] = "Chief Inspector",
    ["Inspector"] = "Inspector",
    ["Sergeant"] = "Sergeant",
    ["Special Police Constable"] = "Special Police Constable",
    ["Senior Police Constable"] = "Senior Police Constable",
    ["Police Constable"] = "Police Constable",
    ["PCSO"] = "PCSO",
    ["SCO-19"] = "SCO-19",
}

local getUserNHSGroups = {
    ["Head Chief Medical Officer"] = "Head Chief Medical Officer",
    ["Assistant Chief Medical Officer"] = "Assistant Chief Medical Officer",
    ["Deputy Chief Medical Officer"] = "Deputy Chief Medical Officer",
    ["Captain"] = "Captain",
    ["Consultant"] = "Consultant",
    ["Specialist"] = "Specialist",
    ["Senior Doctor"] = "Senior Doctor",
    ["Junior Doctor"] = "Junior Doctor",
    ["Critical Care Paramedic"] = "Critical Care Paramedic",
    ["Paramedic"] = "Paramedic",
    ["Trainee Paramedic"] = "Trainee Paramedic",
    ["nhs"] = "NHS Permissions"
}

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'main')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
        if admincfg.buttonsEnabled["adminMenu"][1] and buttons["adminMenu"] then
            RageUI.Button("All Players", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('adminmenu', 'players'))
        end
        if admincfg.buttonsEnabled["adminMenu"][1] and buttons["adminMenu"] then
            RageUI.Button("Search Functions", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('adminmenu', 'searchoptions'))
        end
        if admincfg.buttonsEnabled["adminMenu"][1] and buttons["adminMenu"] then
            RageUI.Button("Functions", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('adminmenu', 'functions'))
        end
        if admincfg.buttonsEnabled["adminMenu"][1] and buttons["adminMenu"] then
            RageUI.Button("Settings", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('adminmenu', 'settings'))
        end
    end)
end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'players')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()

        for k,v in pairs(players) do
            RageUI.Button("[" .. v[3] .. "] " .. v[1], "Name: " .. v[1] .. " Perm ID: " .. v[3] .. " Temp ID: " .. v[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SelectedPlayer = players[k]
                    SelectedPerm = v[3]
                end
            end, RMenu:Get('adminmenu', 'submenu'))
        end
    end)
end
end)

RMenu.Add('SettingsMenu', 'MainMenu', RageUI.CreateMenu("", "ERP Settings Menu", 1300,100,"settings","settings")) 
RMenu.Add('SettingsMenu', 'Crosshair', RageUI.CreateMenu("", "ERP Settings Menu", 1300,100,"settings","settings")) 


local statusr = "~r~[Off]"
local hitsounds = false

local statusc = "~r~[Off]"
local compass = false

local statusT = "~r~[Off]"
local autoequipchecked = true

local toggle = false

local df = {
    {"10%", 0.1},
    {"20%", 0.2},
    {"30%", 0.3},
    {"40%", 0.4},
    {"50%", 0.5},
    {"60%", 0.6},
    {"70%", 0.7},
    {"80%", 0.8},
    {"90%", 0.9},
    {"100%", 1.0},
    {"150%", 1.5},
    {"200%", 2.0},
    {"250%", 2.5},
    {"300%", 3.0},
    {"350%", 3.5},
    {"400%", 4.0},
    {"450%", 4.5},
    {"500%", 5.0},
    {"600%", 6.0},
    {"700%", 7.0},
    {"800%", 8.0},
    {"900%", 9.0},
    {"1000%", 10.0},
}

local d = {"10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%", "150%", "200%", "250%", "300%", "350%", "400%", "450%", "500%", "600%", "700%", "800%", "900%", "1000%"}
local dts = 9
local crosshairchecked = true

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('SettingsMenu', 'MainMenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button("Crosshair", "", {RightLabel = ""}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('SettingsMenu', 'Crosshair'))

            RageUI.Checkbox("Toggle Rust Hitsounds", nil, hitsoundchecked, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
                if (Selected) then
                    hitsoundchecked = not hitsoundchecked
                    if Checked then
                        TriggerEvent("ERP:triggerhssounds")
                        notify("~g~Hitsounds Enabled!")
                    else
                        TriggerEvent("ERP:triggerhssounds")
                        notify("~r~Hitsounds Disabled!")
                    end
                end
            end)

            RageUI.Checkbox("Toggle Compass", nil, compasschecked, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
                if (Selected) then
                    compasschecked = not compasschecked
                    if Checked then
                        ExecuteCommand("compass")
                        notify("~g~Compass Enabled!")
                    else
                        ExecuteCommand("compass")
                        notify("~r~Compass Disabled!")
                    end
                end
            end)

            RageUI.List("Modify Render Distance", d, dts, nil, {}, true, function(a,b,c,d)
                if c then
    
                end
    
                dts = d
            end)

            
       end)
    end

    if RageUI.Visible(RMenu:Get('SettingsMenu', 'Crosshair')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            
            RageUI.Checkbox("Toggle Crosshair", nil, crosshairchecked, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
                if (Selected) then
                    crosshairchecked = not crosshairchecked
                    if Checked then
                        TriggerEvent("cookcrosshair:active")
                    else
                        TriggerEvent("cookcrosshair:active")
                    end
                end
            end)
            RageUI.Button("Edit Crosshair", nil, "", true, function(Hovered, Active, Selected)
                if (Selected) then
                    ExecuteCommand("crossedit")
                end
            end)
            RageUI.Button("Reset Crosshair", nil, "", true, function(Hovered, Active, Selected)
                if (Selected) then
                    ExecuteCommand("crossreset")
                end
            end)
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'settings')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button("Crosshair", "", {RightLabel = ""}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('adminmenu', 'crosshair'))
            RageUI.Button("Toggle Rust Hit Sounds " .. statusr, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    if not hitsounds then 
                        statusr = "~g~[On]"
                        ExecuteCommand("hs")
                        hitsounds = true
                    else 
                        ExecuteCommand("hs")
                        statusr = "~r~[Off]"
                        hitsounds = false
                    end
                end
            end)
    
            RageUI.Button("Toggle Compass " .. statusc, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    if not compass then 
                        statusc = "~g~[On]"
                        ExecuteCommand("compass")
                        compass = true
                    else 
                        ExecuteCommand("compass")
                        statusc = "~r~[Off]"
                        compass = false
                    end
                end
            end)

            RageUI.List("Modify Render Distance", d, dts, nil, {}, true, function(a,b,c,d)
                if c then
    
                end
    
                dts = d
            end)


       end)
    end

    if RageUI.Visible(RMenu:Get('adminmenu', 'crosshair')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            
            RageUI.Checkbox("Toggle Crosshair", nil, crosshairchecked, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
                if (Selected) then
                    crosshairchecked = not crosshairchecked
                    if Checked then
                        ExecuteCommand("crosstoggle")
                    else
                        ExecuteCommand("crosstoggle")
                    end
                end
            end)
            RageUI.Button("Edit Crosshair", nil, "", true, function(Hovered, Active, Selected)
                if (Selected) then
                    ExecuteCommand("crossedit")
                end
            end)
            RageUI.Button("Reset Crosshair", nil, "", true, function(Hovered, Active, Selected)
                if (Selected) then
                    ExecuteCommand("crossreset")
                end
            end)
        end)
    end
end)

RegisterNetEvent('ERP:OpenSettingsMenu')
AddEventHandler('ERP:OpenSettingsMenu', function(admin)
    if not admin then
        RageUI.Visible(RMenu:Get("adminmenu", "main"), false)
        RageUI.Visible(RMenu:Get("SettingsMenu", "MainMenu"), true)
    else
    end
end)

RegisterCommand('opensettingsmenu',function()
    TriggerServerEvent('ERP:OpenSettings')
end)

RegisterKeyMapping('opensettingsmenu', 'Opens the Settings menu', 'keyboard', 'F2')

Citizen.CreateThread(function() 
    while true do
        Citizen.InvokeNative(0xA76359FC80B2438E, df[dts][2])      
                
        Citizen.Wait(0)
    end
end)


RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'searchoptions')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
        foundMatch = false
        RageUI.Button("Search by Name", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
        end, RMenu:Get('adminmenu', 'searchname'))
        
        RageUI.Button("Search by Perm ID", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
        end, RMenu:Get('adminmenu', 'searchpermid'))

        RageUI.Button("Search by Temp ID", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
        end, RMenu:Get('adminmenu', 'searchtempid'))
    end)
end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'functions')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()

        RageUI.Button("General Functions", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
        end, RMenu:Get('adminmenu', 'generalfunctions'))

        RageUI.Button("Entity Functions", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
        end, RMenu:Get('adminmenu', 'entityfunctions'))

        if admincfg.buttonsEnabled["vehFunctions"][1] and buttons["vehFunctions"] then
            RageUI.Button("Vehicle Functions", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('adminmenu', 'vehiclefunctions'))
        end

        if admincfg.buttonsEnabled["devMenu"][1] and buttons["devMenu"] then
            RageUI.Button("Developer Functions", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('adminmenu', 'devfunctions'))
        end

    end)
end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'generalfunctions')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()

            if admincfg.buttonsEnabled["tp2waypoint"][1] and buttons["tp2waypoint"] then
                RageUI.Button("Teleport to Waypoint", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local WaypointHandle = GetFirstBlipInfoId(8)
                        if DoesBlipExist(WaypointHandle) then
                            local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)
                            for height = 1, 1000 do
                                SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
                                local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)
                                if foundGround then
                                    SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
                                    break
                                end
                                Citizen.Wait(5)
                            end
                        else
                            notify("You do not have a waypoint set")
                        end
                    end
                end, RMenu:Get('adminmenu', 'generalfunctions'))
            end

            if admincfg.buttonsEnabled["spawntaxi"][1] and buttons["spawntaxi"] then
                RageUI.Button("Spawn taxi", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        SpawnVehicle('taxi')
                end
                end, RMenu:Get('adminmenu', 'generalfunctions'))
            end
            if admincfg.buttonsEnabled["noClip"][1] and buttons["noClip"] then
                RageUI.Button("Noclip Toggle","",{RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        tvRP.toggleNoclip({})
                    end
                end, RMenu:Get('adminmenu', 'generalfunctions'))
            end
            if admincfg.buttonsEnabled["removewarn"][1] and buttons["removewarn"] then
                RageUI.Button("Remove Warning", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local uid = GetPlayerServerId(PlayerId())
                        AddTextEntry('FMMC_MPM_NC', "Enter the Warning ID")
                        DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0);
                            Wait(0);
                        end
                        if (GetOnscreenKeyboardResult()) then
                            local result = GetOnscreenKeyboardResult()
                            if result then 
                                TriggerServerEvent('ERP:RemoveWarning', uid, result)
                            end
                        end
                    end
                end, RMenu:Get('adminmenu', 'generalfunctions'))
            end

            if admincfg.buttonsEnabled["ban"][1] and buttons["ban"] then
                RageUI.Button("Unban Player","",{RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local permid = getPermId()
                        TriggerServerEvent("ERP:Unban", permid)
                    end
                end)
            end

            if admincfg.buttonsEnabled["ban"][1] and buttons["ban"] then
                RageUI.Button("Offline Ban","",{RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local uid = GetPlayerServerId(PlayerId())
                        local permid = getPermId()
                        local banReason = KeyboardInput("Reason:", "", 100)
                        local banTime = KeyboardInput("Hours:", "", 20)
                        TriggerServerEvent('ERP:BanPlayer', uid, permid, banReason, tonumber(banTime))
                    end
                end)
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'entityfunctions')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()

            if admincfg.buttonsEnabled["spawntaxi"][1] and buttons["spawntaxi"] then
                RageUI.Button("Entity Cleanup", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('ERP:PropCleanup')
                    end
                end, RMenu:Get('adminmenu', 'entityfunctions'))
            end

            if admincfg.buttonsEnabled["spawntaxi"][1] and buttons["spawntaxi"] then
                RageUI.Button("Deattach Entity Cleanup", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('ERP:DeAttachEntity')
                    end
                end, RMenu:Get('adminmenu', 'entityfunctions'))
            end

            if admincfg.buttonsEnabled["spawntaxi"][1] and buttons["spawntaxi"] then
                RageUI.Button("Vehicle Cleanup", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('ERP:VehCleanup')
                    end
                end, RMenu:Get('adminmenu', 'entityfunctions'))
            end

            if admincfg.buttonsEnabled["spawntaxi"][1] and buttons["spawntaxi"] then
                RageUI.Button("Ped Cleanup", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('ERP:PedCleanup')
                    end
                end, RMenu:Get('adminmenu', 'entityfunctions'))
            end

            if admincfg.buttonsEnabled["spawntaxi"][1] and buttons["spawntaxi"] then
                RageUI.Button("All Cleanup", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('ERP:CleanAll')
                    end
                end, RMenu:Get('adminmenu', 'entityfunctions'))
            end

        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'vehiclefunctions')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()

            if admincfg.buttonsEnabled["vehFunctions"][1] and buttons["vehFunctions"] then
                RageUI.Button("Spawn Vehicle (Full Mods)", nil,{RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then
                        deleteVeh()
                        customvehicle = getcustomcarmsg()
                        spawnmaxupgraded(customvehicle)
                        ShowInfo("~g~" .. customvehicle ..  " Spawned")
                    end
                end, RMenu:Get('adminmenu', 'vehiclefunctions'))
            end

            if admincfg.buttonsEnabled["vehFunctions"][1] and buttons["vehFunctions"] then
                RageUI.Button("Spawn Vehicle (No Mods)", nil,{RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then
                        deleteVeh()
                        customvehicle = getcustomcarmsg()
                        spawncustomvehicle(customvehicle)
                        ShowInfo("~g~" .. customvehicle ..  " Spawned")
                    end
                end, RMenu:Get('adminmenu', 'vehiclefunctions'))
            end

            if admincfg.buttonsEnabled["vehFunctions"][1] and buttons["vehFunctions"] then
                RageUI.Button("Fix Vehicle", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then
                        fixvehicle()
                    end
                end, RMenu:Get('adminmenu', 'vehiclefunctions'))
            end

            if admincfg.buttonsEnabled["vehFunctions"][1] and buttons["vehFunctions"] then
                RageUI.Button("Delete Vehicle", nil,{RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then
                        deleteVeh()
                    end
                end, RMenu:Get('adminmenu', 'vehiclefunctions'))
            end

            if admincfg.buttonsEnabled["vehFunctions"][1] and buttons["vehFunctions"] then
                RageUI.Button("Open/Close Doors", nil,{RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then
                        DoorControl()
                    end
                end, RMenu:Get('adminmenu', 'vehiclefunctions'))
            end
            if admincfg.buttonsEnabled["vehFunctions"][1] and buttons["vehFunctions"] then
            RageUI.List("Teleport to ",q,s,nil,{},true,function(x, y, z, N)
                s = N
                if z then   
                    if IsPedInAnyVehicle(PlayerPedId(), true) then
                        ped = GetVehiclePedIsIn(PlayerPedId(), true)
                    else
                        ped = GetPlayerPed(-1)
                    end
                    SetEntityCoords(ped, vector3(r[s]), true,false,false,false)
                end
            end,function()
                end, RMenu:Get('adminmenu', 'vehiclefunctions'))
            end
            RageUI.Button("~b~[Vehicle List]",nil,{RightLabel=""},true,function(Hovered, Active, Selected) 
            end,RMenu:Get('cardev','vehiclelist'))
        end)
    end

end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('cardev', 'vehiclelist')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            if admincfg.buttonsEnabled["vehFunctions"][1] and buttons["vehFunctions"] then
                for k,v in pairs(m) do
                    RageUI.Button(k,nil,{RightLabel=""},true,function(Hovered, Active, Selected) 
                        if Selected then
                            garageCategorySelected=k
                        end
                    end,RMenu:Get('cardev','vehiclelistmain'))
                end
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('cardev', 'vehiclelistmain')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            if admincfg.buttonsEnabled["vehFunctions"][1] and buttons["vehFunctions"] then
                for k,v in pairs(m) do
                    if k == garageCategorySelected then
                        for a,l in pairs(v) do
                            if a ~= "_config" then
                                RageUI.Button(a,""..l[1].."",{RightLabel=""},true,function(Hovered, Active, Selected) 
                                    if Selected then
                                        veh=a
                                    end
                                end,RMenu:Get('cardev','vehiclelistspawn'))
                            end
                        end
                    end
            end
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('cardev', 'vehiclelistspawn')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            if admincfg.buttonsEnabled["vehFunctions"][1] and buttons["vehFunctions"] then
                RageUI.Button("Spawn Vehicle (No mods)", "", {RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then
                        deleteVeh()
                        spawncustomvehicle(veh)                               
                    end
                end)
            end
            if admincfg.buttonsEnabled["vehFunctions"][1] and buttons["vehFunctions"] then
                RageUI.Button("Spawn Vehicle (Full Mods)", "", {RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then
                        deleteVeh()
                        spawnmaxupgraded(veh)                  
                    end
                end)
            end
        end)
    end
end)


RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'devfunctions')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()

            if admincfg.buttonsEnabled["spawnGun"][1] and buttons["spawnGun"] then
                RageUI.Button("Spawn Weapon", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        AddTextEntry('FMMC_MPM_NC', "Enter the weapon hash!")
                        DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0);
                            Wait(0);
                        end
                        if (GetOnscreenKeyboardResult()) then
                            local result = GetOnscreenKeyboardResult()
                            if result then
                                Wait(500)
                                GiveWeaponToPed(PlayerPedId(),"WEAPON_" ..result, 250, false, true)
                                if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_" ..result) then 
                                    notify("~g~Successfuly spawned in weapon!")
                                else
    
                                    notify("~r~Failed to spawn in weapon!")
                                end
                            end
                        end
                    end
                end, RMenu:Get('adminmenu', 'devfunctions'))
            end

            if admincfg.buttonsEnabled["devMenu"][1] and buttons["devMenu"] then
                RageUI.Button("Get Coords", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('VRPDEV:GetCoords')
                    end
                end, RMenu:Get('adminmenu', 'devfunctions'))
            end

            if admincfg.buttonsEnabled["devMenu"][1] and buttons["devMenu"] then
                RageUI.Button("Teleport to Coords","",{RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("ERP:Tp2Coords")
                    end
                end, RMenu:Get('adminmenu', 'devfunctions'))
            end
            if admincfg.buttonsEnabled["devMenu"][1] and buttons["devMenu"] then
                RageUI.Button("Anticheat","",{RightLabel = "→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get('anticheat', 'main'))
            end

            if admincfg.buttonsEnabled["devMenu"][1] and buttons["devMenu"] then
                RageUI.Button("Give Money [Founders]","",{RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("ERP:GiveMoney2")
                    end
                end, RMenu:Get('adminmenu', 'devfunctions'))
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'searchpermid')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()

            if foundMatch == false then
                searchforPermID = KeyboardInput("Enter Perm ID", "", 10)
                if searchforPermID == nil then 
                    searchforPermID = ""
                end
            end

            for k, v in pairs(players) do
                foundMatch = true
                if string.find(v[3],searchforPermID) then
                    RageUI.Button("[" .. v[3] .. "] " .. v[1], "Name: " .. v[1] .. " Perm ID: " .. v[3] .. " Temp ID: " .. v[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SelectedPlayer = players[k]
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end
             end
            end)
        end
    end)

    RageUI.CreateWhile(1.0, true, function()
        if RageUI.Visible(RMenu:Get('adminmenu', 'searchtempid')) then
            RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()

                if foundMatch == false then
                    searchid = KeyboardInput("Enter Temp ID", "", 10)
                    if searchid == nil then 
                        searchid = ""
                    end
                end
    
                for k, v in pairs(players) do
                    foundMatch = true
                    if string.find(v[2], searchid) then
                        RageUI.Button("[" .. v[3] .. "] " .. v[1], "Name: " .. v[1] .. " Perm ID: " .. v[3] .. " Temp ID: " .. v[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                            if Selected then
                                SelectedPlayer = players[k]
                            end
                        end, RMenu:Get('adminmenu', 'submenu'))
                    end
                end
            end)
        end
    end)

        RageUI.CreateWhile(1.0, true, function()
            if RageUI.Visible(RMenu:Get('adminmenu', 'searchname')) then
                RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()

                    if foundMatch == false then
                        SearchName = KeyboardInput("Enter Name", "", 10)
                  
                    end

                    for k, v in pairs(players) do
                        foundMatch = true
                        if SearchName == string.upper(v[1]) then
                            RageUI.Button("[" .. v[3] .. "] " .. v[1], "Name: " .. v[1] .. " Perm ID: " .. v[3] .. " Temp ID: " .. v[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    SelectedPlayer = players[k]
                                end
                            end, RMenu:Get('adminmenu', 'submenu'))
                        end
                    end
                    
                end)
            end
        end)

    RageUI.CreateWhile(1.0, true, function()
        if RageUI.Visible(RMenu:Get('adminmenu', 'submenu')) then
            RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
                if admincfg.buttonsEnabled["ban"][1] and buttons["ban"] then
                        RageUI.Button("Ban Player", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                            if Selected then

                            end
                        end, RMenu:Get('adminmenu', 'bansub'))
                end
                    
                if admincfg.buttonsEnabled["kick"][1] and buttons["kick"] then
                    RageUI.Button("Kick Player", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local kickReason = KeyboardInput("Reason:", "", 100)
                            local uid = GetPlayerServerId(PlayerId())
                            TriggerServerEvent('ERP:KickPlayer', uid, SelectedPlayer[3], kickReason, SelectedPlayer[2])
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end

                if admincfg.buttonsEnabled["nof10kick"][1] and buttons["nof10kick"] then
                    RageUI.Button("No F10 Kick", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local kickReason = KeyboardInput("Reason:", "", 100)
                            local uid = GetPlayerServerId(PlayerId())
                            TriggerServerEvent('ERP:KickPlayerNoF10', uid, SelectedPlayer[3], kickReason)
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end

                if admincfg.buttonsEnabled["FREEZE"][1] and buttons["FREEZE"] then
                    RageUI.Button("Freeze Player", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local uid = GetPlayerServerId(PlayerId())
                            isFrozen = not isFrozen
                            TriggerServerEvent('ERP:FreezeSV', uid, SelectedPlayer[2], isFrozen)
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end

                if admincfg.buttonsEnabled["slap"][1] and buttons["slap"] then
                    RageUI.Button("Slap Player", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local uid = GetPlayerServerId(PlayerId())
                            TriggerServerEvent('ERP:SlapPlayer', uid, SelectedPlayer[2])
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end
                
                if admincfg.buttonsEnabled["addcar"][1] and buttons["addcar"] then
                    RageUI.Button("Add Vehicle To Garage", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            TriggerServerEvent('ERP:AddCar', SelectedPlayer[3], vehicle, vehicletype)
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end
                if admincfg.buttonsEnabled["revive"][1] and buttons["revive"] then
                    RageUI.Button("Revive Player", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local uid = GetPlayerServerId(PlayerId())
                            TriggerServerEvent('ERP:RevivePlayer', uid, SelectedPlayer[2])
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end

                if admincfg.buttonsEnabled["TP2"][1] and buttons["TP2"] then
                    RageUI.Button("Teleport Menu", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)end, RMenu:Get('adminmenu', 'teleportmenu'))
                end

                if admincfg.buttonsEnabled["spectate"][1] and buttons["spectate"] then
                    RageUI.Button("Spectate Player", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            --SetEntityCoords(PlayerPedId(), GetEntityCoords(SelectedPlayer[2]))
                            TriggerServerEvent('vRPAdmin:SpectatePlr', SelectedPlayer[3])
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end

                if admincfg.buttonsEnabled["getgroups"][1] and buttons["getgroups"] then
                    RageUI.Button("Get Groups","Get Users Groups",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            TriggerServerEvent("ERP:getGroups", SelectedPlayer[2], SelectedPlayer[3])
                        end
                    end,RMenu:Get("adminmenu", "groups"))
                end

                if admincfg.buttonsEnabled["showwarn"][1] and buttons["showwarn"] then
                    RageUI.Button("Show Player Warnings", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            ExecuteCommand("showwarnings " .. SelectedPlayer[3])
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end

                if admincfg.buttonsEnabled["warn"][1] and buttons["warn"] then
                    RageUI.Button("Warn Player", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then

                        end
                    end, RMenu:Get('adminmenu', 'warnsub'))
                end
            end)
        end
    end)

warningbankick = {
    {name = "Racism", desc = "Racism"},
    {name = "Toxicity", desc = "Toxicity"},
    {name = "Homophobia", desc = "Homophobia"},
    {name = "RDM", desc = "RDM"},
    {name = "Mass RDM", desc = "Mass RDM"},
    {name = "Cheating/ Modding", desc = "Cheating/ Modding"},
    {name = "Trolling", desc = "Trolling"},
    {name = "Meta Gaming", desc = "Meta Gaming"},
    {name = "Power Gaming", desc = "Power Gaming"},
    {name = "Fail RP", desc = "Fail RP"},
    {name = "NRTI", desc = "No Reason To Initiate"},
    {name = "VDM", desc = "VDM"},
    {name = "Mass VDM", desc = "Mass VDM"},
    {name = "Offensive Language", desc = "Offensive Language"},
    {name = "Severe Offensive Language", desc = "Severe Offensive Language"},
    {name = "Breaking Character", desc = "Breaking Character"},
    {name = "Combat Logging", desc = "Combat Logging"},
    {name = "Combat Storing", desc = "Combat Storing"},
    {name = "Exploiting", desc = "Exploiting"},
    {name = "Severe Exploiting", desc = "Severe Exploiting"},
    {name = "OOGT", desc = "Out of game transactions"},
    {name = "Spite Reporting", desc = "Spite Reporting"},
    {name = "Scamming", desc = "Scamming"},
    {name = "Wasting Admins Time", desc = "Wasting Admins Time"},
    {name = "FTVL", desc = "Failure to value life"},
    {name = "Sexual RP", desc = "Sexual RP"},
    {name = "Imperonation of a whitelisted faction", desc = "Imperonation of a whitelisted faction"},
    {name = "GTA Driving", desc = "Grand Theft Auto Driving"},
    {name = "NLR", desc = "New Life Rule"},
    {name = "NITRP", desc = "No Intention to roleplay"},
    {name = "Kidnapping", desc = "Kidnapping"},
    {name = "Whitelist Abuse", desc = "Whitelist Abuse"},
    {name = "Severe Whitelist Abuse", desc = "Severe Whitelist Abuse"},
    {name = "Cop Baiting", desc = "Cop Baiting"},
 
    --{name = "Police Kidnapping", desc = "Metropolitan Police Kidnapping"},

}

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'warnsub')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()

            if admincfg.buttonsEnabled["warn"][1] and buttons["warn"] then
                for i , p in pairs(warningbankick) do 
                    RageUI.Button("Warn "..p.name, p.desc, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                        if Selected then
                        
                            TriggerServerEvent("vrp:warnPlayer",SelectedPlayer[3],p.name)
                            notify(SelectedPlayer[3])
                            notify("~g~Warned Player for "..p.name)
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                 end
            end

        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'bansub')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()

            
            if admincfg.buttonsEnabled["ban"][1] and buttons["ban"] then
                RageUI.Button("[Custom Ban Message]", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
            
                        local uid  GetPlayerServerId(PlayerId())
         
                        local reason2 = KeyboardInput("Reason:", "", 20)

                        if reason2 == nil then 
                            RageUI.CloseAll()
                        end
                        if banTime == nil then 
                            RageUI.CloseAll()
                        end
                        
                        if reason2 then 
                            timeForBan = KeyboardInput("Hours:", "", 20)
                            TriggerServerEvent('ERP:BanPlayer', uid, SelectedPlayer[3], reason2, timeForBan)
                        end
                        
                    end
                end, RMenu:Get('adminmenu', 'submenu'))

                for i , p in pairs(warningbankick) do 
                    RageUI.Button(p.name, p.desc, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                        if Selected then
                            local uid = GetPlayerServerId(PlayerId())
                            local banTime = KeyboardInput("Hours:", "", 20)
                            TriggerServerEvent('ERP:BanPlayer', uid, SelectedPlayer[3], p.name, tonumber(banTime))
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                 end

            end

           
                

               


           

        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'teleportmenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            if admincfg.buttonsEnabled["TP2"][1] and buttons["TP2"] then
                RageUI.Button("Teleport to Player", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local newSource = GetPlayerServerId(PlayerId())
                        TriggerServerEvent('ERP:TeleportToPlayer', newSource, SelectedPlayer[2])
                    end
                end, RMenu:Get('adminmenu', 'teleportmenu'))
            end

            if admincfg.buttonsEnabled["TP2ME"][1] and buttons["TP2ME"] then
                RageUI.Button("Teleport Player To Me", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('vRPAdmin:Bring', SelectedPlayer[3])
                    end
                end, RMenu:Get('adminmenu', 'teleportmenu'))
            end

            if admincfg.buttonsEnabled["TP2ME"][1] and buttons["TP2ME"] then
                RageUI.Button("Teleport Player To Admin Island", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("ERP:Teleport2AdminIsland", SelectedPlayer[2])
                    end
                end, RMenu:Get('adminmenu', 'teleportmenu'))
            end

            if admincfg.buttonsEnabled["TP2ME"][1] and buttons["TP2ME"] then
                RageUI.Button("Return Player to Previous Location", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("ERP:returnplayer", SelectedPlayer[2])
                        
                    end
                end, RMenu:Get('adminmenu', 'teleportmenu'))
            end
 
                RageUI.Button("", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then
         
                    end
                end, RMenu:Get('adminmenu', 'teleportmenu'))

                if admincfg.buttonsEnabled["TP2ME"][1] and buttons["TP2ME"] then
                    RageUI.Button("Teleport Player Legion Bank", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            TriggerServerEvent("ERP:Teleport", SelectedPlayer[2], vector3(151.61740112305,-1035.05078125,29.339416503906))
                        end
                    end, RMenu:Get('adminmenu', 'teleportmenu'))
                end

                if admincfg.buttonsEnabled["TP2ME"][1] and buttons["TP2ME"] then
                    RageUI.Button("Teleport Player To City License Centre", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            TriggerServerEvent("ERP:Teleport", SelectedPlayer[2], vector3(-537.10968017578,-217.92503356934,37.64965057373 ))
                        end
                    end, RMenu:Get('adminmenu', 'teleportmenu'))
                end
                
                if admincfg.buttonsEnabled["TP2ME"][1] and buttons["TP2ME"] then
                    RageUI.Button("Teleport Player Rebel Diner", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            TriggerServerEvent("ERP:Teleport", SelectedPlayer[2], vector3(1581.6401367188,6445.6494140625,24.999206542969))
                        end
                    end, RMenu:Get('adminmenu', 'teleportmenu'))
                end
        
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'groups')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            if admincfg.buttonsEnabled["staffGroups"][1] and buttons["staffGroups"] then
                RageUI.Button("Staff Groups", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                    if (Hovered) then
        
                    end
                    if (Active) then
        
                    end
                    if (Selected) then
                        RMenu:Get("adminmenu", "groups"):SetTitle("")
                        RMenu:Get("adminmenu", "groups"):SetSubtitle("Staff Groups")
                    end
                end, RMenu:Get('adminmenu', 'staffGroups'))
            end
            if admincfg.buttonsEnabled["licenseGroups"][1] and buttons["licenseGroups"] then
                RageUI.Button("License Groups", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                    if (Hovered) then
        
                    end
                    if (Active) then
        
                    end
                    if (Selected) then
                        RMenu:Get("adminmenu", "groups"):SetTitle("")
                        RMenu:Get("adminmenu", "groups"):SetSubtitle("License Groups")
                    end
                end, RMenu:Get('adminmenu', 'LicenseGroups'))
            end
            if admincfg.buttonsEnabled["povGroups"][1] and buttons["povGroups"] then
                RageUI.Button("POV Groups", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                    if (Hovered) then

                    end
                    if (Active) then

                    end
                    if (Selected) then
                        RMenu:Get("adminmenu", "groups"):SetTitle("")
                        RMenu:Get("adminmenu", "groups"):SetSubtitle("POV Groups")
                    end
                end, RMenu:Get('adminmenu', 'POVGroups'))
            end
            if admincfg.buttonsEnabled["mpdGroups"][1] and buttons["mpdGroups"] then
                RageUI.Button("Police Groups", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                    if (Hovered) then

                    end
                    if (Active) then

                    end
                    if (Selected) then
                        RMenu:Get("adminmenu", "groups"):SetTitle("")
                        RMenu:Get("adminmenu", "groups"):SetSubtitle("POV Groups")
                    end
                end, RMenu:Get('adminmenu', 'PoliceGroups'))
            end
            if admincfg.buttonsEnabled["nhsGroups"][1] and buttons["nhsGroups"] then
                RageUI.Button("NHS Groups", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                    if (Hovered) then

                    end
                    if (Active) then

                    end
                    if (Selected) then
                        RMenu:Get("adminmenu", "groups"):SetTitle("")
                        RMenu:Get("adminmenu", "groups"):SetSubtitle("POV Groups")
                    end
                end, RMenu:Get('adminmenu', 'NHSGroups'))
            end
            if admincfg.buttonsEnabled["donoGroups"][1] and buttons["donoGroups"] then
                RageUI.Button("Donator Groups", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                    if (Hovered) then
        
                    end
                    if (Active) then
        
                    end
                    if (Selected) then
                        
                    end
                end, RMenu:Get('adminmenu', 'UserGroups'))
            end
        end) 
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'staffGroups')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            for k,v in pairs(getStaffGroupsGroupIds) do
                if searchPlayerGroups[k] ~= nil then
                    RageUI.Button("~g~"..v, "~g~User has this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RMenu:Get("adminmenu", "removegroup"):SetTitle("")
                            RMenu:Get("adminmenu", "removegroup"):SetSubtitle("Remove Group")
                            selectedGroup = k
                        end
                    end, RMenu:Get('adminmenu', 'removegroup'))
                else
                    RageUI.Button("~r~"..v, "~r~User does not have this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RMenu:Get("adminmenu", "addgroup"):SetTitle("")
                            RMenu:Get("adminmenu", "addgroup"):SetSubtitle("Add Group")
                            selectedGroup = k
                        end
                    end, RMenu:Get('adminmenu', 'addgroup'))
                end
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'PoliceGroups')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            for k,v in pairs(getUserPoliceGroups) do
                if searchPlayerGroups[k] ~= nil then
                    RageUI.Button("~g~"..v, "~g~User has this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RMenu:Get("adminmenu", "removegroup"):SetTitle("")
                            RMenu:Get("adminmenu", "removegroup"):SetSubtitle("Remove Group")
                            selectedGroup = k
                        end
                    end, RMenu:Get('adminmenu', 'removegroup'))
                else
                    RageUI.Button("~r~"..v, "~r~User does not have this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RMenu:Get("adminmenu", "addgroup"):SetTitle("")
                            RMenu:Get("adminmenu", "addgroup"):SetSubtitle("Add Group")
                            selectedGroup = k
                        end
                    end, RMenu:Get('adminmenu', 'addgroup'))
                end
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'UserGroups')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            for k,v in pairs(getUserGroupsGroupIds) do
                if searchPlayerGroups[k] ~= nil then
                    RageUI.Button("~g~"..v, "~g~User has this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RMenu:Get("adminmenu", "removegroup"):SetTitle("")
                            RMenu:Get("adminmenu", "removegroup"):SetSubtitle("Remove Group")
                            selectedGroup = k
                        end
                    end, RMenu:Get('adminmenu', 'removegroup'))
                else
                    RageUI.Button("~r~"..v, "~r~User does not have this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RMenu:Get("adminmenu", "addgroup"):SetTitle("")
                            RMenu:Get("adminmenu", "addgroup"):SetSubtitle("Add Group")
                            selectedGroup = k
                        end
                    end, RMenu:Get('adminmenu', 'addgroup'))
                end
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'LicenseGroups')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            for k,v in pairs(getUserLicenseGroups) do
                if searchPlayerGroups[k] ~= nil then
                    RageUI.Button("~g~"..v, "~g~User has this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RMenu:Get("adminmenu", "removegroup"):SetTitle("")
                            RMenu:Get("adminmenu", "removegroup"):SetSubtitle("Remove Group")
                            selectedGroup = k
                        end
                    end, RMenu:Get('adminmenu', 'removegroup'))
                else
                    RageUI.Button("~r~"..v, "~r~User does not have this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RMenu:Get("adminmenu", "addgroup"):SetTitle("")
                            RMenu:Get("adminmenu", "addgroup"):SetSubtitle("Add Group")
                            selectedGroup = k
                        end
                    end, RMenu:Get('adminmenu', 'addgroup'))
                end
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'POVGroups')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            for k,v in pairs(getUserPOVGroups) do
                if searchPlayerGroups[k] ~= nil then
                    RageUI.Button("~g~"..v, "~g~User has this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RMenu:Get("adminmenu", "removegroup"):SetTitle("")
                            RMenu:Get("adminmenu", "removegroup"):SetSubtitle("Remove Group")
                            selectedGroup = k
                        end
                    end, RMenu:Get('adminmenu', 'removegroup'))
                else
                    RageUI.Button("~r~"..v, "~r~User does not have this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RMenu:Get("adminmenu", "addgroup"):SetTitle("")
                            RMenu:Get("adminmenu", "addgroup"):SetSubtitle("Add Group")
                            selectedGroup = k
                        end
                    end, RMenu:Get('adminmenu', 'addgroup'))
                end
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'NHSGroups')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            for k,v in pairs(getUserNHSGroups) do
                if searchPlayerGroups[k] ~= nil then
                    RageUI.Button("~g~"..v, "~g~User has this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RMenu:Get("adminmenu", "removegroup"):SetTitle("")
                            RMenu:Get("adminmenu", "removegroup"):SetSubtitle("Remove Group")
                            selectedGroup = k
                        end
                    end, RMenu:Get('adminmenu', 'removegroup'))
                else
                    RageUI.Button("~r~"..v, "~r~User does not have this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RMenu:Get("adminmenu", "addgroup"):SetTitle("")
                            RMenu:Get("adminmenu", "addgroup"):SetSubtitle("Add Group")
                            selectedGroup = k
                        end
                    end, RMenu:Get('adminmenu', 'addgroup'))
                end
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'addgroup')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()

            RageUI.Button("Add this group to user", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent("ERP:addGroup",SelectedPerm,selectedGroup)
                end
            end, RMenu:Get('adminmenu', 'groups'))
            
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'removegroup')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()

            RageUI.Button("Remove user from group", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent("ERP:removeGroup",SelectedPerm,selectedGroup)
                end
            end, RMenu:Get('adminmenu', 'groups'))
            
        end)
    end
end)


RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('anticheat', 'main')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
			RageUI.Separator("Anticheat Duration: Lifetime", function() end)
			RageUI.Separator("Banned Players: " .. acbannedplayers, function() end)
			RageUI.Separator("Your Name: " ..acadminname, function() end)
			RageUI.Button("Banned Players","",{RightLabel = "→"}, true, function(Hovered, Active, Selected)
			end, RMenu:Get('anticheat', 'acbannedplayers'))
			RageUI.Button("Ban Types","",{RightLabel = "→"}, true, function(Hovered, Active, Selected)
			end, RMenu:Get('anticheat', 'actypes'))
			RageUI.Button("Manual Ban","",{RightLabel = "→"}, true, function(Hovered, Active, Selected)
			end, RMenu:Get('anticheat', 'acmanualbanlist')) 
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('anticheat', 'actypes')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
			RageUI.Separator("Anticheat Duration: Lifetime", function() end)
			RageUI.Separator("Banned Players: " .. acbannedplayers, function() end)
			RageUI.Separator("Your Name: " ..acadminname, function() end)
			for i, p in pairs(actypes) do
				RageUI.Button("Type #"..p.type, p.desc, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
				end, RMenu:Get('anticheat', 'anticheat'))
			end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('anticheat', 'acbannedplayers')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
			RageUI.Separator("Anticheat Duration: Lifetime", function() end)
			RageUI.Separator("Banned Players: " .. acbannedplayers, function() end)
			RageUI.Separator("Your Name: " ..acadminname, function() end)
			for k, v in pairs(acbannedplayerstable) do
				RageUI.Button("Ban ID: "..v[1].." Perm ID: "..v[2], "Username: "..v[3].." Reason: "..v[4], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
					if Selected then
						SelectedPlayer = acbannedplayerstable[k]
					end
				end, RMenu:Get('anticheat', 'acbanmenu'))
			end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('anticheat', 'acmanualbanlist')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
			RageUI.Separator("Anticheat Duration: Lifetime", function() end)
			RageUI.Separator("Banned Players: " .. acbannedplayers, function() end)
			RageUI.Separator("Your Name: " ..acadminname, function() end)
			for k, v in pairs(acplayerstable) do
				RageUI.Button(v[1] .." ["..v[2].."]", v[1] .. " PermID: " .. v[3] .. " TempID: " .. v[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
					if Selected then
						SelectedPlayer = players[k]
						SelectedPerm = v[3]
						SelectedName = v[1]
						SelectedPlayerSource = v[2]
					end
				end, RMenu:Get('anticheat', 'acmanualban'))
			end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('anticheat', 'acmanualban')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
			RageUI.Separator("Anticheat Duration: Lifetime", function() end)
			RageUI.Separator("Banned Players: " .. acbannedplayers, function() end)
			RageUI.Separator("Your Name: " ..acadminname, function() end)
			for i, p in pairs(actypes) do
				RageUI.Button("Type #"..p.type, p.desc, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
					if Selected then
						acbanType = p.type
					end
				end, RMenu:Get('anticheat', 'confirmacban'))
			end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('anticheat', 'confirmacban')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.Separator("~r~You are about to ban " ..SelectedName)
            RageUI.Separator("~w~For the following reasons:")
            RageUI.Separator('Cheating Type #'..acbanType)
            RageUI.Separator('Duration: Permanent')
            RageUI.Button("Confirm Ban", nil, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent("ERP:acBan", SelectedPerm, 'Type #'..acbanType, SelectedName, SelectedPlayerSource)
                    notify('~g~AC Banned ID: '..SelectedPerm)
                end
            end, RMenu:Get('anticheat', 'anticheat'))
            RageUI.Button("Cancel Ban", nil, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
            end, RMenu:Get('anticheat', 'anticheat'))
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('anticheat', 'acbanmenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
			RageUI.Separator("Anticheat Duration: Lifetime", function() end)
			RageUI.Separator("Banned Players: " .. acbannedplayers, function() end)
			RageUI.Separator("Your Name: " ..acadminname, function() end)
			RageUI.Button("Unban Player","Unban Selected User",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
				if Selected then 
					TriggerServerEvent('ERP:acUnban', SelectedPlayer[2])
				end
			end, RMenu:Get("anticheat", "acbannedplayers"))
			RageUI.Button("Check Warnings","Show F10 Warning Log",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
				if Selected then 
					ExecuteCommand("sw " .. SelectedPlayer[2])
				end
			end)
        end)
    end
end)

RegisterNetEvent('ERP:SlapPlayer')
AddEventHandler('ERP:SlapPlayer', function()
    SetEntityHealth(PlayerPedId(), 0)
end)

FrozenPlayer = false

RegisterNetEvent('ERP:Freeze')
AddEventHandler('ERP:Freeze', function(isForzen)
    FrozenPlayer = isForzen
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if FrozenPlayer then
            FreezeEntityPosition(PlayerPedId(), true)
        else
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end)

RegisterNetEvent('ERP:Teleport')
AddEventHandler('ERP:Teleport', function(coords)
    SetEntityCoords(PlayerPedId(), coords)
end)

RegisterNetEvent('ERP:Teleport2Me2')
AddEventHandler('ERP:Teleport2Me2', function(target2)
    local coords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target2)))
    SetEntityCoords(PlayerPedId(), coords)
end)


RegisterNetEvent("ERP:SendPlayersInfo")
AddEventHandler("ERP:SendPlayersInfo",function(players_table, btns)
    players = players_table
    buttons = btns
    RageUI.Visible(RMenu:Get("adminmenu", "main"), not RageUI.Visible(RMenu:Get("adminmenu", "main")))
end)

local InSpectatorMode	= false
local TargetSpectate	= nil
local LastPosition		= nil
local polarAngleDeg		= 0;
local azimuthAngleDeg	= 90;
local radius			= -3.5;
local cam 				= nil
local PlayerDate		= {}
local ShowInfos			= false
local group

local function polar3DToWorld3D(entityPosition, radius, polarAngleDeg, azimuthAngleDeg)

    local polarAngleRad   = polarAngleDeg   * math.pi / 180.0
	local azimuthAngleRad = azimuthAngleDeg * math.pi / 180.0

	local pos = {
		x = entityPosition.x + radius * (math.sin(azimuthAngleRad) * math.cos(polarAngleRad)),
		y = entityPosition.y - radius * (math.sin(azimuthAngleRad) * math.sin(polarAngleRad)),
		z = entityPosition.z - radius * math.cos(azimuthAngleRad)
	}

	return pos
end


RegisterNetEvent('ERP:SpectateClient')
AddEventHandler('ERP:SpectateClient', function(target)
    TargetSpectate = target
    SpectatePlayer()
end)


function StopSpectatePlayer()

    InSpectatorMode = false
    TargetSpectate  = nil
    local playerPed = PlayerPedId()
    SetCamActive(cam,  false)
    DestroyCam(cam, true)
    RenderScriptCams(false, false, 0, true, true)
    SetEntityVisible(playerPed, true)
    SetEntityCollision(playerPed, true, true)
    FreezeEntityPosition(playePed, false)
    if savedCoords ~= vec3(0,0,1) then SetEntityCoords(PlayerPedId(), savedCoords) else SetEntityCoords(PlayerPedId(), 3537.363, 3721.82, 36.467) end
end

function SpectatePlayer()
    savedCoords = GetEntityCoords(PlayerPedId())
    SetEntityCoords(PlayerPedId(), Coords)
    InSpectatorMode = true
    local playerPed = PlayerPedId()
    SetEntityCollision(playerPed, false, false)
    SetEntityVisible(playerPed, false)
    FreezeEntityPosition(playePed, true)
    Citizen.CreateThread(function()

        if not DoesCamExist(cam) then
            cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        end

        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, true)

    end, TargetSpectate)
    RequestCollisionAtCoord(NetworkGetPlayerCoords(GetPlayerFromServerId(tonumber(TargetSpectate))))
end

Citizen.CreateThread(function()
    while (true) do
        Wait(0)
        if InSpectatorMode then
            DrawHelpMsg("Press ~INPUT_CONTEXT~ to Stop Spectating")
            if IsControlJustPressed(1, 51) then
                StopSpectatePlayer()
            end
        end
    end
end)

RegisterNetEvent("ERP:gotgroups")
AddEventHandler("ERP:gotgroups",function(gotGroups)
    searchPlayerGroups = gotGroups
end)

Citizen.CreateThread(function()
    while (true) do
        Wait(0)
        if InSpectatorMode then
        
			local targetPlayerId = GetPlayerFromServerId(tonumber(TargetSpectate))
			local playerPed	  = GetPlayerPed(-1)
			local targetPed	  = GetPlayerPed(targetPlayerId)
            local coords	 =  NetworkGetPlayerCoords(GetPlayerFromServerId(tonumber(TargetSpectate)))
            
            Draw2DText(0.22, 0.90, 'Health: ~g~' .. GetEntityHealth(targetPed) .. " / " .. GetEntityMaxHealth(targetPed), 0.65) 
            Draw2DText(0.22, 0.86, 'Armor: ~b~' .. GetPedArmour(targetPed) .. " / " .. GetPlayerMaxArmour(targetPlayerId), 0.65)
			for i=0, 32, 1 do
				if i ~= PlayerId() then
					local otherPlayerPed = GetPlayerPed(i)
					SetEntityNoCollisionEntity(playerPed,  otherPlayerPed,  true)
					SetEntityVisible(playerPed, false)
				end
			end

			if IsControlPressed(2, 241) then
				radius = radius + 2.0;
			end

			if IsControlPressed(2, 242) then
				radius = radius - 2.0;
			end

			if radius > -1 then
				radius = -1
			end

			local xMagnitude = GetDisabledControlNormal(0, 1);
			local yMagnitude = GetDisabledControlNormal(0, 2);

			polarAngleDeg = polarAngleDeg + xMagnitude * 10;

			if polarAngleDeg >= 360 then
				polarAngleDeg = 0
			end

			azimuthAngleDeg = azimuthAngleDeg + yMagnitude * 10;

			if azimuthAngleDeg >= 360 then
				azimuthAngleDeg = 0;
			end

			local nextCamLocation = polar3DToWorld3D(coords, radius, polarAngleDeg, azimuthAngleDeg)

            SetCamCoord(cam,  nextCamLocation.x,  nextCamLocation.y,  nextCamLocation.z)
            PointCamAtEntity(cam,  targetPed)
			SetEntityCoords(playerPed, coords.x, coords.y, coords.z + 10)
        end
    end
end)

function Draw2DText(x, y, text, scale)
    SetTextFont(4)
    SetTextProportional(7)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
  end

RegisterCommand('openadminmenu',function()
    TriggerServerEvent("ERP:GetPlayerData")
	TriggerServerEvent("ERP:getAnticheatData")
end)

RegisterNetEvent("ERP:sendAnticheatData")
AddEventHandler("ERP:sendAnticheatData", function(admin_name, totalbannedplayers, bannedplayers, playerstable, types)
    acbannedplayerstable = bannedplayers
    acbannedplayers = totalbannedplayers
    acadminname = admin_name
	actypes = types
	acplayerstable = playerstable
end)

RegisterKeyMapping('openadminmenu', 'Opens the Admin menu', 'keyboard', 'F2')
RegisterKeyMapping('noclip', 'Noclip for the admin menu', 'keyboard', 'F1')

function DrawHelpMsg(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true 
    
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() 
		Citizen.Wait(500) 
		blockinput = false 
		return result 
	else
		Citizen.Wait(500)
		blockinput = false 
		return nil 
	end
end

function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end

function SpawnVehicle(VehicleName)
	local hash = GetHashKey(VehicleName)
	RequestModel(hash)
	local i = 0
	while not HasModelLoaded(hash) and i < 50 do
		Citizen.Wait(10)
		i = i + 1
	end
    if i >= 50 then
        return
	end
	local Ped = PlayerPedId()
	local Vehicle = CreateVehicle(hash, GetEntityCoords(Ped), GetEntityHeading(Ped), true, 0)
    i = 0
	while not DoesEntityExist(Vehicle) and i < 50 do
		Citizen.Wait(10)
		i = i + 1
	end
	if i >= 50 then
		return
	end
    SetPedIntoVehicle(Ped, Vehicle, -1)
    SetModelAsNoLongerNeeded(hash)
end

function getWarningUserID()
AddTextEntry('FMMC_MPM_NA', "Enter ID of the player you want to warn?")
DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Enter ID of the player you want to warn?", "1", "", "", "", 30)
while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0);
    Wait(0);
end
if (GetOnscreenKeyboardResult()) then
    local result = GetOnscreenKeyboardResult()
    if result then
        return result
    end
end
return false
end

function getWarningUserMsg()
AddTextEntry('FMMC_MPM_NA', "Enter warning message")
DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Enter warning message", "", "", "", "", 30)
while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0);
    Wait(0);
end
if (GetOnscreenKeyboardResult()) then
    local result = GetOnscreenKeyboardResult()
    if result then
        return result
    end
end
return false
end

RegisterNetEvent("ERP:TPCoords")
AddEventHandler("ERP:TPCoords", function(coords)
    SetEntityCoordsNoOffset(GetPlayerPed(-1), coords.x, coords.y, coords.z, false, false, false)
end)

function getPermId()
	AddTextEntry('FMMC_MPM_NA', "Enter Perm ID")
	DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Enter Perm ID", "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
		if result then
			return result
		end
    end
	return false
end

RegisterNetEvent("ERP:EntityWipe")
AddEventHandler("ERP:EntityWipe", function(id)
    Citizen.CreateThread(function() 
        for k,v in pairs(GetAllEnumerators()) do 
            local enum = v
            for entity in enum() do 
                local owner = NetworkGetEntityOwner(entity)
                local playerID = GetPlayerServerId(owner)
                NetworkDelete(entity)
            end
        end
    end)
end)

local Spectating = false;
local LastCoords = nil;
RegisterNetEvent('vRPAdmin:Spectate')
AddEventHandler('vRPAdmin:Spectate', function(plr,tpcoords)
    local playerPed = PlayerPedId()
    local targetPed = GetPlayerPed(GetPlayerFromServerId(plr))
    if not Spectating then
        LastCoords = GetEntityCoords(playerPed) 
        if tpcoords then 
            SetEntityCoords(playerPed, tpcoords - 10.0)
        end
        Wait(300)
        targetPed = GetPlayerPed(GetPlayerFromServerId(plr))
        if targetPed == playerPed then tvRP.notify('~r~I mean you cannot spectate yourself...') return end
		NetworkSetInSpectatorMode(true, targetPed)
        SetEntityCollision(playerPed, false, false)
        SetEntityVisible(playerPed, false, 0)
		SetEveryoneIgnorePlayer(playerPed, true)	
        Spectating = true
        
        tvRP.notify('~g~Spectating Player.')
    else 
        NetworkSetInSpectatorMode(false, targetPed)
        SetEntityVisible(playerPed, true, 0)
		SetEveryoneIgnorePlayer(playerPed, false)
		
		SetEntityCollision(playerPed, true, true)
        Spectating = false;
        SetEntityCoords(playerPed, LastCoords)
        tvRP.notify('~r~Stopped Spectating Player.')
    end 
end)

RegisterNetEvent("ERP:NP")
AddEventHandler("ERP:NP", function()
    tvRP.toggleNoclip({})
end)

-- Functions --

function ShowInfo(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(0,1)
end

-- Spawn Veh --
function deleteVeh()
    local ped = GetPlayerPed(-1)
    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then 
        local pos = GetEntityCoords(ped)

		if (IsPedSittingInAnyVehicle(ped)) then 
			local handle = GetVehiclePedIsIn(ped, false)
			NetworkRequestControlOfEntity(handle)
			SetEntityHealth(handle, 100)
			SetEntityAsMissionEntity(handle, true, true)
			SetEntityAsNoLongerNeeded(handle)
			DeleteEntity(handle)
            ShowInfo("The vehicle you were in has been deleted.")
        end
    end
end

function maxupgradeveh()
    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
    SetVehicleOnGroundProperly(veh)
    SetEntityInvincible(veh, false)
    SetVehicleModKit(veh, 0)
    SetVehicleMod(veh, 11, 2, false)
    SetVehicleMod(veh, 13, 2, false)
    SetVehicleMod(veh, 12, 2, false)
    SetVehicleMod(veh, 15, 3, false)
end

function spawncustomvehicle(customvehicle)
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 8.0, 0.5))
    local color = "~y~"
    local color2 = "~r~"
    local ped = GetPlayerPed(-1)
    if DoesEntityExist(ped) then
        vehiclehash = GetHashKey(customvehicle)
        RequestModel(vehiclehash)
        Citizen.CreateThread(function() 
            local waiting = 0
            while not HasModelLoaded(vehiclehash) do
                waiting = waiting + 100
                Citizen.Wait(100)
                if waiting > 5000 then
                    ShowInfo(color2 .."Could not load model in time. Crash was prevented.")
                    break
                end
            end
            local spawnedVeh = CreateVehicle(vehiclehash, x, y, z, GetEntityHeading(PlayerPedId())+90, 1, 0)
            SetPedIntoVehicle(PlayerPedId(), spawnedVeh, -1)
            SetVehicleDirtLevel(spawnedVeh, 0.0)
        end)
        Wait(1000)
        return true
end
return false
end

function spawnmaxupgraded(customvehicle)
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 8.0, 0.5))
    local color = "~y~"
    local color2 = "~r~"
    local ped = GetPlayerPed(-1)
    if DoesEntityExist(ped) then
        vehiclehash = GetHashKey(customvehicle)
        RequestModel(vehiclehash)
        Citizen.CreateThread(function() 
            local waiting = 0
            while not HasModelLoaded(vehiclehash) do
                waiting = waiting + 100
                Citizen.Wait(100)
                if waiting > 5000 then
                    ShowInfo(color2 .."Could not load model in time. Crash was prevented.")
                    break
                end
            end
            local spawnedVeh = CreateVehicle(vehiclehash, x, y, z, GetEntityHeading(PlayerPedId())+90, 1, 0)
            SetPedIntoVehicle(PlayerPedId(), spawnedVeh, -1)
            SetVehicleOnGroundProperly(spawnedVeh)
            SetVehicleDirtLevel(spawnedVeh, 0.0)
            SetEntityInvincible(spawnedVeh, false)
            SetVehicleModKit(spawnedVeh, 0)
            SetVehicleMod(spawnedVeh, 11, 3, false)
            SetVehicleMod(spawnedVeh, 13, 2, false)
            SetVehicleMod(spawnedVeh, 12, 2, false)
            SetVehicleMod(spawnedVeh, 15, 3, false)
            ToggleVehicleMod(spawnedVeh, 18, true)
        end)
        Wait(1000)
        return true
end
return false
end

-- End of Vehicle Spawner --
-- Message Input --

function getcustomcarmsg()
	AddTextEntry('FMMC_MPM_NA', "Enter Spawn Code")
	DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Enter Spawn Code", "", "", "", "", 100)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
		if result then
			return result
		end
    end
	return false
end

function getvehicletype()
	AddTextEntry('FMMC_MPM_NA', "Enter Vehicle Type (simeon,vip,import,baller,managment,founder)")
	DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Enter Vehicle Type (simeon,vip,import,baller,managment,founder)", "", "", "", "", 100)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
		if result then
			return result
		end
    end
	return false
end



-- End of Message Input

function teleportToWaypoint()
	local targetPed = GetPlayerPed(-1)
	local targetVeh = GetVehiclePedIsUsing(targetPed)
	if(IsPedInAnyVehicle(targetPed))then
		targetPed = targetVeh
    end

	if(not IsWaypointActive())then
		return
	end

	local waypointBlip = GetFirstBlipInfoId(8) -- 8 = waypoint Id
	local x,y,z = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, waypointBlip, Citizen.ResultAsVector())) 

	-- ensure entity teleports above the ground
	local ground
	local groundFound = false
	local groundCheckHeights = {100.0, 150.0, 50.0, 0.0, 200.0, 250.0, 300.0, 350.0, 400.0,450.0, 500.0, 550.0, 600.0, 650.0, 700.0, 750.0, 800.0}

	for i,height in ipairs(groundCheckHeights) do
		SetEntityCoordsNoOffset(targetPed, x,y,height, 0, 0, 1)
		Wait(10)

		ground,z = GetGroundZFor_3dCoord(x,y,height)
		if(ground) then
			z = z + 3
			groundFound = true
			break;
		end
	end

	if(not groundFound)then
		z = 1000
		GiveDelayedWeaponToPed(PlayerPedId(), 0xFBAB5776, 1, 0) -- parachute
	end

	SetEntityCoordsNoOffset(targetPed, x,y,z, 0, 0, 1)
end

function fixvehicle()
    local player = PlayerPedId()
    local veh = GetVehiclePedIsIn(player, false)
    if IsPedSittingInVehicle(player, veh) then
    SetVehicleEngineHealth(veh, 9999)
    SetVehiclePetrolTankHealth(veh, 9999)
    SetVehicleFixed(veh)
    ShowInfo("~g~Vehicle Fixed")
    else
    ShowInfo("~r~Not in Vehicle")
    end
end

function DoorControl()
    local player = GetPlayerPed(-1)
    vehicle = GetVehiclePedIsIn(player,true)
    local isopen = GetVehicleDoorAngleRatio(vehicle,0) and GetVehicleDoorAngleRatio(vehicle,1) and GetVehicleDoorAngleRatio(vehicle,2) and GetVehicleDoorAngleRatio(vehicle,3)

    if (isopen == 0) then
        SetVehicleDoorOpen(vehicle,0,0,0)
        SetVehicleDoorOpen(vehicle,1,0,0)
        SetVehicleDoorOpen(vehicle,2,0,0)
        SetVehicleDoorOpen(vehicle,3,0,0)
        else
        SetVehicleDoorShut(vehicle,0,0)
        SetVehicleDoorShut(vehicle,1,0)
        SetVehicleDoorShut(vehicle,2,0)
        SetVehicleDoorShut(vehicle,3,0)
        end
    end