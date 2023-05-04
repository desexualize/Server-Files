vRPclient = Tunnel.getInterface("vRP","vRP")

local user_id = 0

local foundMatch = false
local inSpectatorAdminMode = false
local players = {}
local playersNearby = {}
local searchPlayerGroups = {}
local selectedGroup
local Groups = {}
local povlist = ''
local SelectedPerm = nil
local hoveredPlayer = nil


admincfg = {}

admincfg.perm = "admin.tickets"
admincfg.IgnoreButtonPerms = false
admincfg.admins_cant_ban_admins = false

local tpLocationColour = '~b~'
local q = {tpLocationColour.."Legion", tpLocationColour.."Mission Row", tpLocationColour.."Sandy PD", tpLocationColour.."License Centre", tpLocationColour.."Airport", tpLocationColour.."Rebel Diner", tpLocationColour.."VIP Island", tpLocationColour.."St Thomas", tpLocationColour.."Casino"}
local r = {
    vector3(151.61740112305,-1035.05078125,29.339416503906),
    vector3(444.96252441406,-983.07598876953,30.689311981201),
    vector3(1839.3137207031, 3671.0014648438, 34.310436248779),
    vector3(-551.08221435547, -194.19259643555, 38.219661712646),
    vector3(-1142.0673828125, -2851.802734375, 13.94624710083),
    vector3(1588.3441162109, 6439.3696289063, 25.123600006104),
    vector3(-2172.2595214844, 5140.984375, 2.819997549057),
    vector3(364.86236572266,-590.99975585938,28.690246582031),
    vector3(923.24499511719,48.181098937988,81.106323242188),
}
local s = 1


--[[ {enabled -- true or false}, permission required ]]
admincfg.buttonsEnabled = {


    --[[ admin Menu ]]
    ["adminMenu"] = {true, "admin.tickets"},
    ["warn"] = {true, "admin.warn"},      
    ["showwarn"] = {true, "admin.showwarn"},
    ["ban"] = {true, "admin.ban"},
    ["unban"] = {true, "admin.unban"},
    ["kick"] = {true, "admin.kick"},
    ["revive"] = {true, "admin.revive"},
    ["TP2"] = {true, "admin.tp2player"},
    ["TP2ME"] = {true, "admin.summon"},
    ["FREEZE"] = {true, "admin.freeze"},
    ["spectate"] = {true, "admin.spectate"}, 
    ["SS"] = {true, "admin.screenshot"},
    ["slap"] = {true, "admin.slap"},
    ["armour"] = {true, "admin.special"},
    ["giveMoney"] = {true, "admin.givemoney"},
    ["addcar"] = {true, "admin.addcar"},

    --[[ Functions ]]
    ["tp2waypoint"] = {true, "admin.tp2waypoint"},
    ["tp2coords"] = {true, "admin.tp2coords"},
    ["removewarn"] = {true, "admin.removewarn"},
    ["spawnBmx"] = {true, "admin.spawnBmx"},
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

menuColour = '~b~'

RMenu.Add('adminmenu', 'main', RageUI.CreateMenu("", "~b~Admin Menu", 1300,100, "banners","adminmenu"))

RMenu.Add("adminmenu", "players", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main"), "", menuColour..'Admin Player Interaction Menu',1300,100,"banners","adminmenu"))
RMenu.Add("adminmenu", "closeplayers", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main"), "", menuColour..'Admin Player Interaction Menu',1300,100,"banners","adminmenu"))
RMenu.Add("adminmenu", "searchoptions", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main"), "", menuColour..'Admin Player Search Menu',1300,100,"banners","adminmenu"))

--[[ Functions ]]
RMenu.Add("adminmenu", "functions", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main"), "", menuColour..'Admin Functions Menu',1300,100,"banners","adminmenu"))
RMenu.Add("adminmenu", "entityfunctions", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main"), "", menuColour..'Entity Functions Menu',1300,100,"banners","adminmenu"))
RMenu.Add("adminmenu", "devfunctions", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main"), "", menuColour..'Dev Functions Menu',1300,100,"banners","adminmenu"))
RMenu.Add("adminmenu", "actypes", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "devfunctions"), "", menuColour..'AC Types',1300,100,"banners","adminmenu"))
--[[ End of Functions ]]

RMenu.Add("adminmenu", "submenu", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "players"), "", menuColour..'Admin Player Interaction Menu',1300,100,"banners","adminmenu"))
RMenu.Add("adminmenu", "searchname", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "searchoptions"), "", menuColour..'Admin Player Search Menu',1300,100,"banners","adminmenu"))
RMenu.Add("adminmenu", "searchtempid", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "searchoptions"), "", menuColour..'Admin Player Search Menu',1300,100,"banners","adminmenu"))
RMenu.Add("adminmenu", "searchpermid", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "searchoptions"), "", menuColour..'Admin Player Search Menu',1300,100,"banners","adminmenu"))
RMenu.Add("adminmenu", "warnsub", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "players"), "", menuColour..'Select Warn Reason',1300,100,"banners","adminmenu"))
RMenu.Add("adminmenu", "bansub", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "players"), "", menuColour..'Select Ban Reason',1300,100,"banners","adminmenu"))
RMenu.Add("adminmenu", "notesub", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "players"), "", menuColour..'Player Notes',1300,100,"banners","adminmenu"))

--[[group ]]
RMenu.Add("adminmenu", "groups", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "submenu"), "", menuColour..'Admin Groups Menu',1300,100,"banners","adminmenu"))
RMenu.Add("adminmenu", "staffGroups", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups"), "", menuColour..'Admin Groups Menu',1300,100,"banners","adminmenu"))
RMenu.Add("adminmenu", "LicenseGroups", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups"), "", menuColour..'Admin Groups Menu',1300,100,"banners","adminmenu"))
RMenu.Add("adminmenu", "UserGroups", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups"), "", menuColour..'Admin Groups Menu',1300,100,"banners","adminmenu"))
RMenu.Add("adminmenu", "POVGroups", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups"), "", menuColour..'Admin Groups Menu',1300,100,"banners","adminmenu"))
RMenu.Add("adminmenu", "PoliceGroups", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups"), "", menuColour..'Admin Groups Menu',1300,100,"banners","adminmenu"))
RMenu.Add("adminmenu", "NHSGroups", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups"), "", menuColour..'Admin Groups Menu',1300,100,"banners","adminmenu"))
RMenu.Add("adminmenu", "addgroup", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups"), "", menuColour..'Admin Groups Menu',1300,100,"banners","adminmenu"))
RMenu.Add("adminmenu", "removegroup", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups"), "", menuColour..'Admin Groups Menu',1300,100,"banners","adminmenu"))

RMenu:Get('adminmenu', 'main')

local getStaffGroupsGroupIds = {
	["founder"] = "Founder",
    ["operationsmanager"] = "Operations Manager",
    ["staffmanager"] = "Staff Manager",
    ["commanager"] = "Community Manager",
    ["headadmin"] = "Head Admin",
    ["senioradmin"] = "Senior Admin",
    ["administrator"] = "Admin",
    ["srmoderator"] = "Senior Moderator",
	["moderator"] = "Moderator",
    ["supportteam"] = "Support Team",
    ["trialstaff"] = "Trial Staff",
    ["cardev"] = "Car Developer",
}
local getUserGroupsGroupIds = {
    ["VIP"] = "VIP",
    ["recruit"] = "Recruit",
    ["soldier"] = "Soldier",
    ["warrior"] = "Warrior",
    ["diamond"] = "Diamond",
    --["GANGWHITELIST"] = "Whitelisted Gang",

}
local getUserLicenseGroups = {
    ["Scrap Job"] = "Scrap Job License",
    ["Weed"] = "Weed License",
    ["Cocaine"] = "Cocaine License",
    ["Heroin"] = "Heroin License",
    ["LSD"] = "LSD License",
    ["Rebel"] = "Rebel License",
    ["AdvancedRebel"] = "Advanced Rebel",
    ["Diamond"] = "Diamond License",
    ["Gang"] = "Gang License",
    ["HighRoller"] = "High Roller License",
    ["DJ"] = "DJ License",
}
local getUserPOVGroups = {
    ["pov"] = "POV List",
}

local getUserPoliceGroups = {
    ["Special Constable"] = "Special Constable",
    ["Commissioner"] = "Commissioner",
    ["Deputy Commissioner"] = "Deputy Commissioner",
    ["Assistant Commissioner"] = "Assistant Commissioner",
    ["Deputy Assistant Commissioner"] = "Deputy Assistant Commissioner",
    ["Commander"] = "Commander",
    ["Chief Superintendent"] = "Chief Superintendent",
    ["Superintendent"] = "Superintendent",
    ["ChiefInspector"] = "Chief Inspector",
    ["Inspector"] = "Inspector",
    ["Sergeant"] = "Sergeant",
    ["Senior Constable"] = "Senior Constable",
    ["Police Constable"] = "Police Constable",
    ["PCSO"] = "PCSO",
    --["Police"] = "Whitelist",
    --["pdlargearms"] = "Police Large Arms",
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
}

AddEventHandler("playerSpawned",function()
    local h = true
    if h then 
        TriggerServerEvent("GMT:requestAdminPerks")
    end 
end)

RegisterNetEvent('GMT:SendAdminPerks', function(a)
    Stafflevel = a 
    if getStaffLevel() > 0 then 
        print('[GMT] Your staff level is: ' ..Stafflevel)
   
    end
end)

function getStaffLevel()
    return Stafflevel
end
RegisterCommand('requeststafflevel', function(source, args, RawCommand)
    if getStaffLevel() > 4 then
        print('You requested all all staff perms to be checked')
        TriggerServerEvent("GMT:requestAdminPerks")
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'main')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
        hoveredPlayer = nil
        if admincfg.buttonsEnabled["adminMenu"][1] and buttons["adminMenu"] then
            RageUI.ButtonWithStyle("All Players", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('adminmenu', 'players'))
        end
        if admincfg.buttonsEnabled["adminMenu"][1] and buttons["adminMenu"] then
            RageUI.ButtonWithStyle("Nearby Players", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent("GMT:GetNearbyPlayers", 250)
                end
            end, RMenu:Get('adminmenu', 'closeplayers'))
        end
        if admincfg.buttonsEnabled["adminMenu"][1] and buttons["adminMenu"] then
            RageUI.ButtonWithStyle("Search Players", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('adminmenu', 'searchoptions'))
        end
        if admincfg.buttonsEnabled["adminMenu"][1] and buttons["adminMenu"] then
            RageUI.ButtonWithStyle("Functions", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('adminmenu', 'functions'))
        end
        if admincfg.buttonsEnabled["adminMenu"][1] and buttons["adminMenu"] then
            RageUI.ButtonWithStyle("Settings", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('SettingsMenu', 'MainMenu'))
        end
    end)
end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'players')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            for k, v in pairs(players) do
                RageUI.ButtonWithStyle(v[1] .." ["..v[3].."]", v[1] .. " ("..v[4].." hours) PermID: " .. v[3] .. " TempID: " .. v[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        SelectedPlayer = players[k]
                        SelectedPerm = v[3]
                        TriggerServerEvent("GMT:CheckPov",v[3])
                    end
                end, RMenu:Get('adminmenu', 'submenu'))
            end
        end)
    end

    if RageUI.Visible(RMenu:Get('adminmenu', 'closeplayers')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            if next(playersNearby) then
                for i, v in pairs(playersNearby) do
                    RageUI.ButtonWithStyle(v[1] .." ["..v[2].."]", v[1] .. " ("..v[4].." hours) PermID: " .. v[3] .. " TempID: " .. v[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            SelectedPlayer = playersNearby[i]
                            SelectedPerm = v[3]
                        end
                        if Active then 
                            hoveredPlayer = v[2]
                        end
                    end, RMenu:Get("adminmenu", "submenu"))
                end
            else
                RageUI.Separator("No players nearby!")
            end
        end)
    end
end)

RegisterNetEvent("GMT:ReturnNearbyPlayers")
AddEventHandler("GMT:ReturnNearbyPlayers", function(table)
    playersNearby = table
end)


RMenu.Add('SettingsMenu', 'MainMenu', RageUI.CreateMenu("", menuColour.."Settings Menu", 1300,100, "banners","setting")) 
RMenu.Add("SettingsMenu", "crosshairsettings", RageUI.CreateSubMenu(RMenu:Get("SettingsMenu", "MainMenu")))


local statusr = "~r~[Off]"
local hitsounds = false

local statusc = "~r~[Off]"
local compass = false

local statusT = "~r~[Off]"
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
local dts = 10


RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('SettingsMenu', 'MainMenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.List("Modify Render Distance", d, dts, "~y~Change Render Distance", {}, true, function(a,b,c,d)
                if c then -- Locals...
                end
                dts = d -- Locals ...
            end)

            RageUI.Checkbox("Compass", nil, compasschecked, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
                if (Selected) then
                    compasschecked = not compasschecked
                    ExecuteCommand("compass")
                end
            end)

            RageUI.Checkbox("Cinematic Bars", "~y~Roleplay Option!", blackbarschecked, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
                if (Selected) then
                    blackbarschecked = not blackbarschecked
                    ExecuteCommand("cinematic")
                end
            end)

            RageUI.Checkbox("Disable Hitsounds", nil, hitsoundchecked, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
                if (Selected) then
                    hitsoundchecked = not hitsoundchecked
                    TriggerEvent("hs:triggerSounds")
                end
            end)

            RageUI.Checkbox("Weapon Orientation", nil, wbchecked, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
                if (Selected) then
                    wbchecked = not wbchecked
                    TriggerEvent("weaponsonback:trigger")
                end
            end)

            RageUI.Checkbox("UI", "~y~Toggle GMT UI.", hudchecked, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
                if (Selected) then
                    hudchecked = not hudchecked
                    if Checked then
                        ExecuteCommand('hideui')
                      
                    else
                        ExecuteCommand('showui')
                      
                    end
                end
            end)

            RageUI.Checkbox("Streetnames", nil, streetnamechecked, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
                if (Selected) then
                    streetnamechecked = not streetnamechecked
                    if Checked then
                        ExecuteCommand('streetnames')
                      
                    else
                        ExecuteCommand('streetnames')
                       
                    end
                end
            end)

            RageUI.Button("~y~Crosshair Settings", "~y~Change your crosshair settings", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    
                end
            end, RMenu:Get('SettingsMenu', 'crosshairsettings'))
       end)
    end
end)


RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('SettingsMenu', 'crosshairsettings')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()


        RageUI.Checkbox("Enable Crosshair", nil, crosshairchecked, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
            if (Selected) then
                crosshairchecked = not crosshairchecked
                if Checked then
                    ExecuteCommand("cross")
                    notify("~g~Crosshair Enabled!")
                else
                    ExecuteCommand("cross")
                    notify("~r~Crosshair Disabled!")
                end
            end
        end)

        RageUI.ButtonWithStyle("Edit Crosshair", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if (Selected) then
                ExecuteCommand("crosse")
            end
        end)

        RageUI.ButtonWithStyle("Reset Crosshair", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if (Selected) then
                ExecuteCommand("crossr")
            end
        end)

    end)
end
end)


RegisterNetEvent('GMT:OpenSettingsMenu')
AddEventHandler('GMT:OpenSettingsMenu', function(admin)
    if not admin then
        RageUI.Visible(RMenu:Get("adminmenu", "main"), false)
        RageUI.Visible(RMenu:Get("SettingsMenu", "MainMenu"), true)
    end
end)

RegisterCommand('opensettingsmenu',function()
    TriggerServerEvent('GMT:OpenSettings')
end)

RegisterKeyMapping('opensettingsmenu', 'Opens the Settings menu', 'keyboard', 'F2')

Citizen.CreateThread(function() 
    while true do
        Citizen.InvokeNative(0xA76359FC80B2438E, df[dts][2])      
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if hoveredPlayer ~= nil then
            local hoveredPedCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(hoveredPlayer)))
            DrawMarker(2, hoveredPedCoords.x, hoveredPedCoords.y, hoveredPedCoords.z + 1.1,0.0,0.0,0.0,0.0,-180.0,0.0,0.4,0.4,0.4,255,255,0,125,false,true,2, false)
        end
    end
end)


RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'searchoptions')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
        foundMatch = false
        RageUI.ButtonWithStyle("Search by Name",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
        end, RMenu:Get('adminmenu', 'searchname'))
        
        RageUI.ButtonWithStyle("Search by Perm ID",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
        end, RMenu:Get('adminmenu', 'searchpermid'))

        RageUI.ButtonWithStyle("Search by Temp ID",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
        end, RMenu:Get('adminmenu', 'searchtempid'))
    end)
end
end)


RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'functions')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()

        --if admincfg.buttonsEnabled["devMenu"][1] and buttons["devMenu"] then
            if tvRP.isDeveloper(tvRP.getUserId()) then
            RageUI.ButtonWithStyle("Get Coords", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('GMT:GetCoords')
                end
            end, RMenu:Get('adminmenu', 'functions'))
        end

        if admincfg.buttonsEnabled["kick"][1] and buttons["kick"] then                        
            RageUI.ButtonWithStyle("Kick (No F10)", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('GMT:noF10Kick')
                end
            end, RMenu:Get('adminmenu', 'functions'))
        end

        if admincfg.buttonsEnabled["tp2waypoint"][1] and buttons["tp2waypoint"] then                        
            RageUI.List("Teleport to ",q,s,nil,{},true,function(x, y, z, N)
                s = N
                if z then
                    local uid = GetPlayerServerId(PlayerId())
                    TriggerServerEvent("GMT:Teleport", uid, vector3(r[s]))
                end
            end,
            function()end)
        end

       -- if admincfg.buttonsEnabled["devMenu"][1] and buttons["devMenu"] then
            if tvRP.isDeveloper(tvRP.getUserId()) then
            RageUI.ButtonWithStyle("TP To Coords",nil,{RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent("GMT:Tp2Coords")
                end
            end, RMenu:Get('adminmenu', 'functions'))
        end

        if admincfg.buttonsEnabled["ban"][1] and buttons["ban"] then
            RageUI.ButtonWithStyle("Offline Ban",nil,{RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    local uid = GetPlayerServerId(PlayerId())
                    TriggerServerEvent('GMT:offlineban', uid)
                end
            end)
        end

        if admincfg.buttonsEnabled["tp2waypoint"][1] and buttons["tp2waypoint"] then
            RageUI.ButtonWithStyle("TP To Waypoint", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
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
                        notify("~r~You do not have a waypoint set")
                    end
                end
            end, RMenu:Get('adminmenu', 'functions'))
        end

        if admincfg.buttonsEnabled["unban"][1] and buttons["unban"] then
            RageUI.ButtonWithStyle("Unban Player",nil,{RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent("GMT:Unban")
                end
            end)
        end

        if admincfg.buttonsEnabled["spawnBmx"][1] and buttons["spawnBmx"] then
            RageUI.ButtonWithStyle("Spawn Taxi", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnVehicle('taxi')
                end
            end, RMenu:Get('adminmenu', 'functions'))
        end

        if admincfg.buttonsEnabled["removewarn"][1] and buttons["removewarn"] then
            RageUI.ButtonWithStyle("Remove Warning", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    local uid = GetPlayerServerId(PlayerId())
                    TriggerServerEvent('GMT:RemoveWarning', uid, result)
                end
            end, RMenu:Get('adminmenu', 'functions'))
        end

        -- if admincfg.buttonsEnabled["getgroups"][1] and buttons["getgroups"] then
        --     RageUI.Button("Toggle Blips", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
        --         if Selected then
        --             TriggerServerEvent('GMT:checkBlips')
        --         end
        --     end, RMenu:Get('adminmenu', 'functions'))
        -- end

        if admincfg.buttonsEnabled["adminMenu"][1] and buttons["adminMenu"] then
            RageUI.ButtonWithStyle("~b~Entity Functions", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('adminmenu', 'entityfunctions'))
        end
        --if admincfg.buttonsEnabled["devMenu"][1] and buttons["devMenu"] then
            if tvRP.isDeveloper(tvRP.getUserId()) then
            RageUI.ButtonWithStyle("~b~Developer Functions", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('adminmenu', 'devfunctions'))
        end
    end)
end
end)


RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'entityfunctions')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()


            if admincfg.buttonsEnabled["unban"][1] and buttons["unban"] then
                RageUI.ButtonWithStyle("Vehicle Cleanup", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('GMT:VehCleanup')
                    end
                end, RMenu:Get('adminmenu', 'entityfunctions'))
            end

     

            if admincfg.buttonsEnabled["unban"][1] and buttons["unban"] then
                RageUI.ButtonWithStyle("Entity Cleanup",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('GMT:CleanAll')
                    end
                end, RMenu:Get('adminmenu', 'entityfunctions'))
            end

        end)
    end
end)


RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'devfunctions')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()

            if tvRP.isDeveloper(tvRP.getUserId()) then
                RageUI.ButtonWithStyle("Spawn Weapon",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('GMT:Giveweapon')
                    end
                end, RMenu:Get('adminmenu', 'devfunctions'))
            end

            if tvRP.isDeveloper(tvRP.getUserId()) then
                RageUI.ButtonWithStyle("Reset Rewards",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('GMT:resetRedeem')
                    end
                end, RMenu:Get('adminmenu', 'devfunctions'))
            end
    
            if tvRP.isDeveloper(tvRP.getUserId()) then
                RageUI.ButtonWithStyle("Add Car",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('GMT:AddCar')
                    end
                end, RMenu:Get('adminmenu', 'devfunctions'))
            end
    
            if admincfg.buttonsEnabled["tp2waypoint"][1] and buttons["tp2waypoint"] then
                RageUI.ButtonWithStyle("Cancel Rent",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('admin:cancelRent')
                    end
                end, RMenu:Get('adminmenu', 'devfunctions'))
            end

            --if admincfg.buttonsEnabled["devMenu"][1] and buttons["devMenu"] then
                if tvRP.isDeveloper(tvRP.getUserId()) then
                RageUI.ButtonWithStyle("~g~Give Cash",nil,{RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("GMT:GiveMoneyMenu")
                    end
                end, RMenu:Get('adminmenu', 'devfunctions'))
            end

          --  if admincfg.buttonsEnabled["devMenu"][1] and buttons["devMenu"] then
                if tvRP.isDeveloper(tvRP.getUserId()) then
                RageUI.ButtonWithStyle("AC Types",nil,{RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                    end
                end, RMenu:Get('adminmenu', 'actypes'))
            end          
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'searchpermid')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()

            if foundMatch == false then
                searchforPermID = KeyboardInput("Enter Perm ID", "", 10)
                if searchforPermID == nil then 
                    searchforPermID = ""
                end
            end

            for k, v in pairs(players) do
                foundMatch = true
                if string.find(v[3],searchforPermID) then
                    RageUI.ButtonWithStyle("[" .. v[3] .. "] " .. v[1], "Name: " .. v[1] .. " Perm ID: " .. v[3] .. " Temp ID: " .. v[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
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
            RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()

                if foundMatch == false then
                    searchid = KeyboardInput("Enter Temp ID", "", 10)
                    if searchid == nil then 
                        searchid = ""
                    end
                end
    
                for k, v in pairs(players) do
                    foundMatch = true
                    if string.find(v[2], searchid) then
                        RageUI.ButtonWithStyle("[" .. v[3] .. "] " .. v[1], "Name: " .. v[1] .. " Perm ID: " .. v[3] .. " Temp ID: " .. v[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
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
                RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()

                    if foundMatch == false then
                        SearchName = KeyboardInput("Enter Name", "", 10)
                        if SearchName == nil then 
                            SearchName = ""
                        end
                    end

                    for k, v in pairs(players) do
                        foundMatch = true
                        if string.find(string.lower(v[1]), string.lower(SearchName)) then
                            RageUI.ButtonWithStyle("[" .. v[3] .. "] " .. v[1], "Name: " .. v[1] .. " Perm ID: " .. v[3] .. " Temp ID: " .. v[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
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
            RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
                hoveredPlayer = nil
                RageUI.Separator("~y~Player must provide POV on request: "..povlist)
                if admincfg.buttonsEnabled["spectate"][1] and buttons["spectate"] then
                    RageUI.ButtonWithStyle("Player Notes", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            TriggerServerEvent('GMT:getNotes', uid, SelectedPlayer[3])
                        end
                    end, RMenu:Get('adminmenu', 'notesub'))
                end 
               
                if admincfg.buttonsEnabled["kick"][1] and buttons["kick"] then
                    RageUI.ButtonWithStyle("Kick Player", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local uid = GetPlayerServerId(PlayerId())
                            TriggerServerEvent('GMT:KickPlayer', uid, SelectedPlayer[3], kickReason, SelectedPlayer[2])
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end

                if admincfg.buttonsEnabled["ban"][1] and buttons["ban"] then
                    RageUI.ButtonWithStyle("Ban Player", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                        end
                    end, RMenu:Get('adminmenu', 'bansub'))
                end

                if admincfg.buttonsEnabled["spectate"][1] and buttons["spectate"] then
                    RageUI.ButtonWithStyle("Spectate Player", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            inRedZone = false
                            TriggerServerEvent('GMT:SpectatePlayer', SelectedPlayer[3])
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end

                if admincfg.buttonsEnabled["revive"][1] and buttons["revive"] then
                    RageUI.ButtonWithStyle("Revive", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local uid = GetPlayerServerId(PlayerId())
                            TriggerServerEvent('GMT:RevivePlayer', uid, SelectedPlayer[2])
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end
                
                if admincfg.buttonsEnabled["TP2"][1] and buttons["TP2"] then
                    RageUI.ButtonWithStyle("Teleport to Player", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local newSource = GetPlayerServerId(PlayerId())
                            TriggerServerEvent('GMT:TeleportToPlayer', newSource, SelectedPlayer[2])
                            inTP2P = true
                            inTP2P2 = true
                            
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end

                if admincfg.buttonsEnabled["TP2ME"][1] and buttons["TP2ME"] then
                    RageUI.ButtonWithStyle("Teleport Player to Me", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            TriggerServerEvent('GMT:BringPlayer', SelectedPlayer[3])
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end

                if admincfg.buttonsEnabled["TP2ME"][1] and buttons["TP2ME"] then
                    RageUI.ButtonWithStyle("Teleport to Admin Zone", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            inRedZone = false
                            savedCoordsBeforeAdminZone = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(SelectedPlayer[2])))
                            TriggerServerEvent("GMT:Teleport2AdminIsland", SelectedPlayer[2])
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end

                if admincfg.buttonsEnabled["TP2ME"][1] and buttons["TP2ME"] then
                    RageUI.ButtonWithStyle("Teleport Back from Admin Zone", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            TriggerServerEvent("GMT:TeleportBackFromAdminZone", SelectedPlayer[2], savedCoordsBeforeAdminZone)
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end

                if admincfg.buttonsEnabled["TP2ME"][1] and buttons["TP2ME"] then
                    RageUI.ButtonWithStyle("Teleport to Legion", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            TriggerServerEvent("GMT:Teleport", SelectedPlayer[2], vector3(151.61740112305,-1035.05078125,29.339416503906))
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end

                if admincfg.buttonsEnabled["FREEZE"][1] and buttons["FREEZE"] then
                    RageUI.ButtonWithStyle("Freeze", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local uid = GetPlayerServerId(PlayerId())
                            isFrozen = not isFrozen
                            TriggerServerEvent('GMT:FreezeSV', uid, SelectedPlayer[2], isFrozen)
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end

                if admincfg.buttonsEnabled["slap"][1] and buttons["slap"] then
                    RageUI.ButtonWithStyle("Slap Player", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local uid = GetPlayerServerId(PlayerId())
                            TriggerServerEvent('GMT:SlapPlayer', uid, SelectedPlayer[2])
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end

                if admincfg.buttonsEnabled["unban"][1] and buttons["unban"] then
                    RageUI.ButtonWithStyle("Force Clock Off", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local uid = GetPlayerServerId(PlayerId())
                            TriggerServerEvent("GMT:ForceClockOff", uid, SelectedPlayer[3])
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end
                if admincfg.buttonsEnabled["tp2waypoint"][1] and buttons["tp2waypoint"] then                        
                    RageUI.List("Teleport to ",q,s,nil,{},true,function(x, y, z, N)
                        s = N
                        if z then
                            local uid = GetPlayerServerId(PlayerId())
                            TriggerServerEvent("GMT:Teleport", SelectedPlayer[2], vector3(r[s]))
                        end
                    end,
                    function()end)
                end

                if admincfg.buttonsEnabled["showwarn"][1] and buttons["showwarn"] then
                    RageUI.ButtonWithStyle("Open F10 Warning Log", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            ExecuteCommand("sw " .. SelectedPlayer[3])
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end

                if admincfg.buttonsEnabled["SS"][1] and buttons["SS"] then
                    RageUI.ButtonWithStyle("Take Screenshot",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local uid = GetPlayerServerId(PlayerId())
                            TriggerServerEvent('GMT:RequestScreenshot', uid , SelectedPlayer[2])
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end

                if admincfg.buttonsEnabled["getgroups"][1] and buttons["getgroups"] then
                    RageUI.ButtonWithStyle("See Groups", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            TriggerServerEvent("GMT:GetGroups", SelectedPlayer[2], SelectedPlayer[3])
                        end
                    end,RMenu:Get("adminmenu", "groups"))
                end
                
            end)
        end
    end)

    RageUI.CreateWhile(1.0, true, function()
        if RageUI.Visible(RMenu:Get('adminmenu', 'notesub')) then
            RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
                if f == nil then
                    RageUI.Separator("~b~Player notes: Loading...")
                elseif #f == 0 then
                    RageUI.Separator("~b~There are no player notes to display.")
                else
                    RageUI.Separator("~b~Player notes:")
                    for K = 1, #f do
                        RageUI.Separator("~g~#"..f[K].note_id.." ~w~" .. f[K].text .. " - "..f[K].admin_name.. "("..f[K].admin_id..")")
                    end
                end
                if admincfg.buttonsEnabled["warn"][1] and buttons["warn"] then
                    RageUI.ButtonWithStyle("Add To Notes:", nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if Selected then
                            TriggerServerEvent('GMT:addNote', uid, SelectedPlayer[2])
                        end
                    end)
                    RageUI.ButtonWithStyle("Remove Note", nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if Selected then
                            local uid = GetPlayerServerId(PlayerId())
                            TriggerServerEvent('GMT:removeNote', uid, SelectedPlayer[2])
                        end
                    end)
                end
            end)
        end
    end)
    
RegisterNetEvent('GMT:ReturnPov')
AddEventHandler('GMT:ReturnPov', function(pov)
    if pov then 
        povlist = '~g~true' 
    else
        povlist = '~r~false'
    end
end)

RegisterNetEvent("GMT:sendNotes",function(a7)
    a7 = json.decode(a7)
    if a7 == nil then
        f = {}
    else
        f = a7
    end
end)

RegisterNetEvent("GMT:updateNotes",function(admin, player)
    TriggerServerEvent('GMT:getNotes', admin, player)
end)

actypes = {
    {
        type = 1,
        desc = 'Noclip'
    },
    {
        type = 2,
        desc = 'Spawning Weapons'
    },
    {
        type = 3,
        desc = 'Explosion Event'
    },
    {
        type = 4,
        desc = 'Blacklisted Event'
    },
    {
        type = 5,
        desc = 'Removing Weapons'
    },
    {
        type = 6,
        desc = 'Infinite Ammo'
    },
    {
        type = 7,
        desc = 'God Mode'
    },
    {
        type = 8,
        desc = 'Infinite Combat Roll'
    },
    {
        type = 8,
        desc = 'Blacklisted Crash Message'
    },
}

warningbankick = {
    {
        id = "trolling",
        name = "1.0 Trolling",
        desc = "1st Offense: 24hr\n2nd Offense: 48hr\n3rd Offense: 72hr",
        selected = false
    },
    {
        id = "trollingminor",
        name = "1.0 Trolling (Minor)",
        desc = "1st Offense: 2hr\n2nd Offense: 12hr\n3rd Offense: 24hr",
        selected = false
    },
    {
        id = "metagaming",
        name = "1.1 Metagaming",
        desc = "1st Offense: 24hr\n2nd Offense: 48hr\n3rd Offense: 72hr",
        selected = false
    },
    {
        id = "powergaming",
        name = "1.2 Power Gaming ",
        desc = "1st Offense: 24hr\n2nd Offense: 48hr\n3rd Offense: 72hr",
        selected = false
    },
    {
        id = "failrp",
        name = "1.3 Fail RP",
        desc = "1st Offense: 24hr\n2nd Offense: 48hr\n3rd Offense: 72hr",
        selected = false
    },
    {id = "rdm", name = "1.4 RDM", desc = "1st Offense: 24hr\n2nd Offense: 48hr\n3rd Offense: 72hr", selected = false},
    {
        id = "massrdm",
        name = "1.4.1 Mass RDM",
        desc = "1st Offense: Permanent\n2nd Offense: N/A\n3rd Offense: N/A",
        selected = false
    },
    {
        id = "nrti",
        name = "1.5 No Reason to Initiate (NRTI) ",
        desc = "1st Offense: 24hr\n2nd Offense: 48hr\n3rd Offense: 72hr",
        selected = false
    },
    {id = "vdm", name = "1.6 VDM", desc = "1st Offense: 24hr\n2nd Offense: 48hr\n3rd Offense: 72hr", selected = false},
    {
        id = "massvdm",
        name = "1.6.1 Mass VDM",
        desc = "1st Offense: Permanent\n2nd Offense: N/A\n3rd Offense: N/A",
        selected = false
    },
    {
        id = "offlanguageminor",
        name = "1.7 Offensive Language/Toxicity (Minor)",
        desc = "1st Offense: 2hr\n2nd Offense: 24hr\n3rd Offense: 72hr",
        selected = false
    },
    {
        id = "offlanguagestandard",
        name = "1.7 Offensive Language/Toxicity (Standard)",
        desc = "1st Offense: 48hr\n2nd Offense: 72hr\n3rd Offense: 168hr",
        selected = false
    },
    {
        id = "offlanguagesevere",
        name = "1.7 Offensive Language/Toxicity (Severe)",
        desc = "1st Offense: Permanent\n2nd Offense: N/A\n3rd Offense: N/A",
        selected = false
    },
    {
        id = "breakrp",
        name = "1.8 Breaking Character",
        desc = "1st Offense: 12hr\n2nd Offense: 24hr\n3rd Offense: 48hr",
        selected = false
    },
    {
        id = "combatlog",
        name = "1.9 Combat logging",
        desc = "1st Offense: 24hr\n2nd Offense: 48hr\n3rd Offense: 72hr",
        selected = false
    },
    {
        id = "combatstore",
        name = "1.10 Combat storing",
        desc = "1st Offense: 24hr\n2nd Offense: 48hr\n3rd Offense: 72hr",
        selected = false
    },
    {
        id = "exploitingstandard",
        name = "1.11 Exploiting (Standard)",
        desc = "1st Offense: 24hr\n2nd 48hr\n3rd 168hr",
        selected = false
    },
    {
        id = "exploitingsevere",
        name = "1.11 Exploiting (Severe)",
        desc = "1st Offense: 168hr\n2nd Permanent\n3rd N/A",
        selected = false
    },
    {
        id = "oogt",
        name = "1.12 Out of game transactions (OOGT)",
        desc = "1st Offense: Permanent\n2nd Offense: N/A\n3rd Offense: N/A",
        selected = false
    },
    {
        id = "spitereport",
        name = "1.13 Spite Reports ",
        desc = "1st Offense: 24hr\n2nd Offense: 48hr\n3rd Offense: 168hr",
        selected = false
    },
    {
        id = "scamming",
        name = "1.14 Scamming",
        desc = "1st Offense: Permanent\n2nd Offense: N/A\n3rd Offense: N/A",
        selected = false
    },
    {
        id = "loans",
        name = "1.15 Loans",
        desc = "1st Offense: 48hr\n2nd Offense: 168hr\n3rd Offense: Permanent",
        selected = false
    },
    {
        id = "wastingadmintime",
        name = "1.16 Wasting Admin Time",
        desc = "1st Offense: 2hr\n2nd Offense: 12hr\n3rd Offense: 24hr",
        selected = false
    },
    {
        id = "ftvl",
        name = "2.1 Value of Life",
        desc = "1st Offense: 24hr\n2nd Offense: 48hr\n3rd Offense: 72hr",
        selected = false
    },
    {
        id = "sexualrp",
        name = "2.2 Sexual RP",
        desc = "1st Offense: 168hr\n2nd Offense: Permanent\n3rd N/A",
        selected = false
    },
    {
        id = "terrorrp",
        name = "2.3 Terrorist RP",
        desc = "1st Offense: 168hr\n2nd Offense: Permanent\n3rd N/A",
        selected = false
    },
    {
        id = "impwhitelisted",
        name = "2.4 Impersonation of Whitelisted Factions",
        desc = "1st Offense: 12hr\n2nd Offense: 24hr\n3rd Offense: 48hr",
        selected = false
    },
    {
        id = "gtadriving",
        name = "2.5 GTA Online Driving",
        desc = "1st Offense: 24hr\n2nd Offense: 48hr\n3rd Offense: 72hr",
        selected = false
    },
    {id = "nlr", name = "2.6 NLR", desc = "1st Offense: 24hr\n2nd Offense: 48hr\n3rd Offense: 72hr", selected = false},
    {
        id = "badrp",
        name = "2.7 Bad RP",
        desc = "1st Offense: 24hr\n2nd Offense: 48hr\n3rd Offense: 72hr",
        selected = false
    },
    {
        id = "kidnapping",
        name = "2.8 Kidnapping",
        desc = "1st Offense: 12hr\n2nd Offense: 24hr\n3rd Offense: 48hr",
        selected = false
    },
    {
        id = "stealingems",
        name = "3.0 Theft of Emergency Vehicles",
        desc = "1st Offense: 12hr\n2nd Offense: 24hr\n3rd Offense: 48hr",
        selected = false
    },
    {
        id = "whitelistabusestandard",
        name = "3.1 Whitelist Abuse",
        desc = "1st Offense: 24hr\n2nd Offense: 72hr\n3rd 168hr",
        selected = false
    },
    {
        id = "whitelistabusesevere",
        name = "3.1 Whitelist Abuse",
        desc = "1st Offense: 168hr\n2nd Offense: Permanent\n3rd N/A",
        selected = false
    },
    {
        id = "copbaiting",
        name = "3.2 Cop Baiting",
        desc = "1st Offense: 12hr\n2nd Offense: 24hr\n3rd Offense: 48hr",
        selected = false
    },
    {
        id = "pdkidnapping",
        name = "3.3 PD Kidnapping",
        desc = "1st Offense: 12hr\n2nd Offense: 24hr\n3rd Offense: 48hr",
        selected = false
    },
    {
        id = "unrealisticrevival",
        name = "3.4 Unrealistic Revival",
        desc = "1st Offense: 12hr\n2nd Offense: 24hr\n3rd Offense: 48hr",
        selected = false
    },
    {
        id = "interjectingrp",
        name = "3.5 Interjection of RP",
        desc = "1st Offense: 24hr\n2nd Offense: 48hr\n3rd Offense: 72hr",
        selected = false
    },
    {
        id = "combatrev",
        name = "3.6 Combat Reviving",
        desc = "1st Offense: 12hr\n2nd Offense: 24hr\n3rd Offense: 48hr",
        selected = false
    },
    {
        id = "gangcap",
        name = "3.7 Gang Cap",
        desc = "1st Offense: 24hr\n2nd Offense: 72hr\n3rd Offense: 168h",
        selected = false
    },
    {
        id = "maxgang",
        name = "3.8 Max Gang Numbers",
        desc = "1st Offense: 24hr\n2nd Offense: 72hr\n3rd Offense: 168h",
        selected = false
    },
    {
        id = "gangalliance",
        name = "3.9 Gang Alliance",
        desc = "1st Offense: 24hr\n2nd Offense: 48hr\n3rd Offense: 72hr",
        selected = false
    },
    {
        id = "impgang",
        name = "3.10 Impersonation of Gangs",
        desc = "1st Offense: 12hr\n2nd Offense: 24hr\n3rd Offense: 48hr",
        selected = false
    },
    {
        id = "gzstealing",
        name = "4.1 Stealing Vehicles in Greenzone",
        desc = "1st Offense: 2hr\n2nd Offense: 12hr\n3rd Offense: 24hr",
        selected = false
    },
    {
        id = "gzillegal",
        name = "4.2 Selling Illegal Items in Greenzone",
        desc = "1st Offense: 12hr\n2nd Offense: 24hr\n3rd Offense: 48hr",
        selected = false
    },
    {
        id = "gzretretreating",
        name = "4.3 Greenzone Retreating ",
        desc = "1st Offense: 24hr\n2nd Offense: 48hr\n3rd Offense: 72hr",
        selected = false
    },
    {
        id = "rzhostage",
        name = "4.5 Taking Hostage into Redzone",
        desc = "1st Offense: 24hr\n2nd Offense: 48hr\n3rd Offense: 72hr",
        selected = false
    },
    {
        id = "rzretreating",
        name = "4.6 Redzone Retreating",
        desc = "1st Offense: 24hr\n2nd Offense: 48hr\n3rd Offense: 72hr",
        selected = false
    },
    {
        id = "advert",
        name = "1.1 Advertising",
        desc = "1st Offense: Permanent\n2nd Offense: N/A\n3rd Offense: N/A",
        selected = false
    },
    {
        id = "bullying",
        name = "1.2 Bullying",
        desc = "1st Offense: Permanent\n2nd Offense: N/A\n3rd Offense: N/A",
        selected = false
    },
    {
        id = "impersonationrule",
        name = "1.3 Impersonation",
        desc = "1st Offense: Permanent\n2nd Offense: N/A\n3rd Offense: N/A",
        selected = false
    },
    {
        id = "language",
        name = "1.4 Language",
        desc = "1st Offense: Permanent\n2nd Offense: N/A\n3rd Offense: N/A",
        selected = false
    },
    {
        id = "discrim",
        name = "1.5 Discrimination ",
        desc = "1st Offense: Permanent\n2nd Offense: N/A\n3rd Offense: N/A",
        selected = false
    },
    {
        id = "attacks",
        name = "1.6 Malicious Attacks ",
        desc = "1st Offense: Permanent\n2nd Offense: N/A\n3rd Offense: N/A",
        selected = false
    },
    {
        id = "PIIstandard",
        name = "1.7 PII (Personally Identifiable Information)(Standard)",
        desc = "1st Offense: 168hr\n2nd Offense: Permanent\n3rd Offense: N/A",
        selected = false
    },
    {
        id = "PIIsevere",
        name = "1.7 PII (Personally Identifiable Information)(Severe)",
        desc = "1st Offense: Permanent\n2nd Offense: N/A\n3rd Offense: N/A",
        selected = false
    },
    {
        id = "chargeback",
        name = "1.8 Chargeback",
        desc = "1st Offense: Permanent\n2nd Offense: N/A\n3rd Offense: N/A",
        selected = false
    },
    {
        id = "discretion",
        name = "1.9 Staff Discretion",
        desc = "1st Offense: Permanent\n2nd Offense: N/A\n3rd Offense: N/A",
        selected = false
    },
    {
        id = "cheating",
        name = "1.10 Cheating",
        desc = "1st Offense: Permanent\n2nd Offense: N/A\n3rd Offense: N/A",
        selected = false
    },
    {
        id = "banevading",
        name = "1.11 Ban Evading",
        desc = "1st Offense: Permanent\n2nd Offense: N/A\n3rd Offense: N/A",
        selected = false
    },
    {
        id = "fivemcheats",
        name = "1.12 Withholding/Storing FiveM Cheats",
        desc = "1st Offense: Permanent\n2nd Offense: N/A\n3rd Offense: N/A",
        selected = false
    },
    {
        id = "altaccount",
        name = "1.13 Multi-Accounting",
        desc = "1st Offense: Permanent\n2nd Offense: N/A\n3rd Offense: N/A",
        selected = false
    },
    {
        id = "association",
        name = "1.14 Association with External Modifications",
        desc = "1st Offense: Permanent\n2nd Offense: N/A\n3rd Offense: N/A",
        selected = false
    },
    {
        id = "pov",
        name = "1.15 Failure to provide POV ",
        desc = "1st Offense: 2hr\n2nd Offense: Permanent\n3rd Offense: N/A",
        selected = false
    },
    {
        id = "withholdinginfostandard",
        name = "1.16 Withholding Information From Staff (Standard)",
        desc = "1st Offense: 48hr\n2nd Offense: 72hr\n3rd Offense: 168hr",
        selected = false
    },
    {
        id = "withholdinginfosevere",
        name = "1.16 Withholding Information From Staff (Severe)",
        desc = "1st Offense: Permanent\n2nd Offense: N/A\n3rd Offense: N/A",
        selected = false
    },
    {
        id = "blackmail",
        name = "1.17 Blackmailing",
        desc = "1st Offense: Permanent\n2nd Offense: N/A\n3rd Offense: N/A",
        selected = false
    },

    {
        id = "comban",
        name = "Community Ban",
        desc = "1st Offense: Permanent\n2nd Offense: N/A\n3rd Offense: N/A",
        selected = false
    },
}


RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'bansub')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()

            
            if admincfg.buttonsEnabled["ban"][1] and buttons["ban"] then
                RageUI.Button("~g~[Custom Ban Message]", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)            
                        if Selected then
                            local uid = GetPlayerServerId(PlayerId())
                            TriggerServerEvent('GMT:CustomBan', uid, SelectedPlayer[3])
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                        

                for i , p in pairs(warningbankick) do 
                    RageUI.Button(p.name, p.desc, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                        if Selected then
                            local uid = GetPlayerServerId(PlayerId())
                            TriggerServerEvent('GMT:BanPlayer', uid, SelectedPlayer[3], p.name)
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                 end

            end

        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'actypes')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            for i, p in pairs(actypes) do
                RageUI.Separator('~r~['..p.type..']~s~ '..p.desc) 
            end
        end)
    end
end)

            
-- RegisterCommand("return", function()
--     if inTP2P then
--         if savedCoords1 == nil then return notify("~r~Couldn't get Last Position") end
--         DoScreenFadeOut(1000)
--         NetworkFadeOutEntity(PlayerPedId(), true, false)
--         Wait(1000)
--         SetEntityCoords(PlayerPedId(), savedCoords1)
--         NetworkFadeInEntity(PlayerPedId(), 0)
--         DoScreenFadeIn(1000)
--         notify("~g~Returned to position.")
--         inTP2P = false
--         TriggerEvent("GMT:vehicleMenu",false, false)
--     end
-- end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'groups')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if admincfg.buttonsEnabled["staffGroups"][1] and buttons["staffGroups"] then
                RageUI.Button("Staff Groups",nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
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
                RageUI.Button("License Groups",nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
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
                RageUI.Button("POV Groups",nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
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
                RageUI.Button("~b~Police Groups",nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
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
                RageUI.Button("~g~NHS Groups",nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
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
                RageUI.Button("Donator Groups",nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
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
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
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
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
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
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
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
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
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
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
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
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
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
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()

            RageUI.Button("Add this group to user",nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent("GMT:AddGroup",SelectedPerm,selectedGroup)
                end
            end, RMenu:Get('adminmenu', 'groups'))
            
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'removegroup')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()

            RageUI.Button("Remove user from group",nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent("GMT:RemoveGroup",SelectedPerm,selectedGroup)
                end
            end, RMenu:Get('adminmenu', 'groups'))
            
        end)
    end
end)

RegisterNetEvent('GMT:SlapPlayer')
AddEventHandler('GMT:SlapPlayer', function()
    SetEntityHealth(PlayerPedId(), 0)
end)

FrozenPlayer = false

RegisterNetEvent('GMT:Freeze')
AddEventHandler('GMT:Freeze', function(isFrozen)
    FrozenPlayer = isFrozen
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if FrozenPlayer then
            FreezeEntityPosition(PlayerPedId(), true)
            DisableControlAction(0,24,true) -- disable attack
            DisableControlAction(0,25,true) -- disable aim
            DisableControlAction(0,47,true) -- disable weapon
            DisableControlAction(0,58,true) -- disable weapon
            DisableControlAction(0,263,true) -- disable melee
            DisableControlAction(0,264,true) -- disable melee
            DisableControlAction(0,257,true) -- disable melee
            DisableControlAction(0,140,true) -- disable melee
            DisableControlAction(0,141,true) -- disable melee
            DisableControlAction(0,142,true) -- disable melee
            DisableControlAction(0,143,true) -- disable melee

            SetEntityInvincible(GetPlayerPed(-1), true)
			SetPlayerInvincible(PlayerId(), true)
			SetPedCanRagdoll(GetPlayerPed(-1), false)
			ClearPedBloodDamage(GetPlayerPed(-1))
			ResetPedVisibleDamage(GetPlayerPed(-1))
			ClearPedLastWeaponDamage(GetPlayerPed(-1))
			SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
			SetEntityCanBeDamaged(GetPlayerPed(-1), false)			
        elseif not FrozenPlayer and not staffMode and not noclip then
            FreezeEntityPosition(PlayerPedId(), false)
            SetPedCanRagdoll(GetPlayerPed(-1), true)
            ClearPedBloodDamage(GetPlayerPed(-1))
            ResetPedVisibleDamage(GetPlayerPed(-1))
            ClearPedLastWeaponDamage(GetPlayerPed(-1))
        end
    end
end)

RegisterNetEvent('GMT:Teleport')
AddEventHandler('GMT:Teleport', function(coords)
    SetEntityCoords(PlayerPedId(), coords)
end)

RegisterNetEvent('GMT:Teleport2Me2')
AddEventHandler('GMT:Teleport2Me2', function(target2)
    local coords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target2)))
    SetEntityCoords(PlayerPedId(), coords)
end)


RegisterNetEvent("GMT:SendPlayerInfo")
AddEventHandler("GMT:SendPlayerInfo",function(players_table, btns)
    players = players_table
    buttons = btns
    RageUI.Visible(RMenu:Get("adminmenu", "main"), not RageUI.Visible(RMenu:Get("adminmenu", "main")))
end)

RegisterNetEvent("GMT:allowWeaponSpawn")
AddEventHandler("GMT:allowWeaponSpawn",function(spawncode)
    if admincfg.buttonsEnabled["spawnGun"][1] and buttons["spawnGun"] then
        tvRP.allowWeapon(spawncode)
        GiveWeaponToPed(PlayerPedId(), GetHashKey(spawncode), 250, false, false,0)
        notify("~g~Successfully spawned ~b~"..spawncode)
    end
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



function StopSpectatePlayer()
    inRedZone = false
    InSpectatorMode = false
    TargetSpectate  = nil
    local playerPed = PlayerPedId()
    SetCamActive(cam,  false)
    DestroyCam(cam, true)
    RenderScriptCams(false, false, 0, true, true)
    SetEntityVisible(playerPed, true)
    SetEntityCollision(playerPed, true, true)
    FreezeEntityPosition(playePed, false)
    setRedzoneTimerDisabled(false)
    if savedCoords ~= vec3(0,0,1) then SetEntityCoords(PlayerPedId(), savedCoords) else SetEntityCoords(PlayerPedId(), 3537.363, 3721.82, 36.467) end
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

RegisterNetEvent("GMT:GotGroups")
AddEventHandler("GMT:GotGroups",function(gotGroups)
    searchPlayerGroups = gotGroups
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

RegisterNetEvent('GMT:NotifyPlayer')
AddEventHandler('GMT:NotifyPlayer', function(string)
    notify('~g~' .. string)
end)

RegisterCommand('openadminmenu',function()
    TriggerServerEvent("GMT:GetPlayerData")
    TriggerServerEvent("GMT:GetNearbyPlayerData")
end)

RegisterKeyMapping('openadminmenu', 'Opens the Admin menu', 'keyboard', 'F2')

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
		blockinput = false 
		return result 
	else
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

RegisterNetEvent("GMT:TPCoords")
AddEventHandler("GMT:TPCoords", function(coords)
    SetEntityCoordsNoOffset(GetPlayerPed(-1), coords.x, coords.y, coords.z, false, false, false)
end)

RegisterNetEvent("GMT:EntityWipe")
AddEventHandler("GMT:EntityWipe", function(id)
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

function bank_drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

local Spectating = false;
local LastCoords = nil;
RegisterNetEvent('GMT:Spectate')
AddEventHandler('GMT:Spectate', function(plr,tpcoords)
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
        setRedzoneTimerDisabled(true)
        tvRP.notify('~g~Spectating Player.')

        while Spectating do
            local targetArmour = GetPedArmour(targetPed)
            local targetHealth = GetEntityHealth(targetPed)
            local targetplayerName = GetPlayerName(GetPlayerFromServerId(plr))
            local targetSpeedMph = GetEntitySpeed(targetPed) * 2.236936
            local targetvehiclehealth = GetEntityHealth(GetVehiclePedIsIn(targetPed, false))
            local targetWeapon = GetSelectedPedWeapon(targetPed)
            local targetWeaponAmmoCount = GetAmmoInPedWeapon(targetPed, targetWeapon)

            DrawAdvancedText(0.320, 0.850, 0.025, 0.0048, 0.5, "Health: "..targetHealth, 51, 153, 255, 200, 6, 0)
            DrawAdvancedText(0.320, 0.828, 0.025, 0.0048, 0.5, "Armour: "..targetArmour, 51, 153, 255, 200, 6, 0)
            --DrawAdvancedText(0.320, 0.806, 0.025, 0.0048, 0.5, "Ammo: "..(targetWeaponAmmoCount or "N/A"), 51, 153, 255, 200, 6, 0)
            --DrawAdvancedText(0.320, 0.784, 0.025, 0.0048, 0.5, "Vehicle Health: "..targetvehiclehealth, 51, 153, 255, 200, 6, 0)
            DrawAdvancedText(0.320, 0.806, 0.025, 0.0048, 0.5, "Vehicle Health: "..targetvehiclehealth, 51, 153, 255, 200, 6, 0)

            bank_drawTxt(0.90, 1.4, 1.0, 1.0, 0.4, "You are currently spectating "..targetplayerName, 51, 153, 255, 200)
            if IsPedSittingInAnyVehicle(targetPed) then
               DrawAdvancedText(0.320, 0.784, 0.025, 0.0048, 0.5, "Speed: "..math.floor(targetSpeedMph), 51, 153, 255, 200, 6, 0)
            end	
            Wait(0)
        end
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
