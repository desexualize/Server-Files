ARMAclient = Tunnel.getInterface("ARMA","ARMA")

local user_id = 0
local foundMatch = false
local inSpectatorAdminMode = false
local players = {}
local playersNearby = {}
local playersNearbyDistance = 250
local searchPlayerGroups = {}
local selectedGroup
local povlist = nil
local SelectedPerm = nil
local SelectedName = nil
local SelectedPlayerSource = nil
local hoveredPlayer = nil
local banreasons = {}
local selectedbans = {}
local Duration = 0
local BanMessage = "N/A"
local SeparatorMSG = {}
local BanPoints = 0
local g
local h = {}
local i = 1
local k = {}
local o = ''
local tt= ''
local a10
local requestedVideo = false

admincfg = {}

admincfg.perm = "admin.tickets"
admincfg.IgnoreButtonPerms = false
admincfg.admins_cant_ban_admins = false

local q = {"PD (Mission Row)", "PD (Sandy)", "PD (Paleto)", "City Hall", "Airport", "HMP", "Rebel Diner", "St Thomas", "Tutorial Spawn", "Simeons"}
local r = {
    vector3(446.72503662109, -982.44342041016, 30.68931579589),
    vector3(1839.3137207031, 3671.0014648438, 34.310436248779),
    vector3(-437.32931518555, 6021.2114257813, 31.490119934082),
    vector3(-551.08221435547, -194.19259643555, 38.219661712646),
    vector3(-1142.0673828125, -2851.802734375, 13.94624710083),
    vector3(1848.2724609375, 2586.7385253906, 45.671997070313),
    vector3(1588.3441162109, 6439.3696289063, 25.123600006104),
    vector3(283.37664794922, -579.45318603516, 43.219303131104),
    vector3(-1035.9499511719,-2734.6240234375,13.756628036499),
    vector3(-39.604099273682,-1111.8635253906,26.438835144043),
}
local s = 1
local communityPot = '0'

menuColour = '~b~'

RMenu.Add('adminmenu', 'main', RageUI.CreateMenu("", "~b~Admin Menu", tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(), "banners", "admin"))
RMenu.Add("adminmenu", "players", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main"), "", menuColour..'Admin Player Interaction Menu',tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(),"banners","admin"))
RMenu.Add("adminmenu", "closeplayers", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main"), "", menuColour..'Admin Player Interaction Menu',tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(),"banners","admin"))
RMenu.Add("adminmenu", "searchoptions", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main"), "", menuColour..'Admin Player Search Menu',tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(),"banners","admin"))
RMenu.Add("adminmenu", "functions", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main"), "", menuColour..'Admin Functions Menu',tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(),"banners","admin"))
RMenu.Add("adminmenu", "devfunctions", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main"), "", menuColour..'Dev Functions Menu',tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(),"banners","admin"))
RMenu.Add("adminmenu", "communitypot", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "functions"), "", menuColour..'Community Pot',tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(),"banners", "communitypot"))
RMenu.Add("adminmenu", "moneymenu", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "functions"), "", menuColour..'Money Menu',tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(),"banners", "admin"))
RMenu.Add("adminmenu", "submenu", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "players"), "", menuColour..'Admin Player Interaction Menu',tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(),"banners", "admin"))
RMenu.Add("adminmenu", "searchname", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "searchoptions"), "", menuColour..'Admin Player Search Menu',tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(),"banners", "admin"))
RMenu.Add("adminmenu", "searchtempid", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "searchoptions"), "", menuColour..'Admin Player Search Menu',tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(),"banners", "admin"))
RMenu.Add("adminmenu", "searchpermid", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "searchoptions"), "", menuColour..'Admin Player Search Menu',tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(),"banners", "admin"))
RMenu.Add("adminmenu", "searchhistory", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "searchoptions"), "", menuColour..'Admin Player Search Menu',tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(),"banners", "admin"))
RMenu.Add("adminmenu", "notespreviewban", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "players"), "", menuColour..'Player Notes',tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(),"banners", "admin"))
RMenu.Add("adminmenu", "banselection", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "notespreviewban"), "", menuColour..'Ban Menu ~w~- ~o~[Tab] to search bans',tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(),"banners", "admin"))
RMenu.Add("adminmenu", "generatedban", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "banselection"), "", menuColour..'Ban Menu',tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(),"banners", "admin"))
RMenu.Add("adminmenu", "notesub", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "players"), "", menuColour..'Player Notes',tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(),"banners", "admin"))
RMenu.Add("adminmenu", "groups", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "submenu"), "", menuColour..'Admin Groups Menu ~w~- ~o~[Tab] to search groups',tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(),"banners", "admin"))
RMenu.Add("adminmenu", "addgroup", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups"), "", menuColour..'Admin Groups Menu',tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(),"banners", "admin"))
RMenu.Add("adminmenu", "removegroup", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups"), "", menuColour..'Admin Groups Menu',tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(),"banners", "admin"))
RMenu:Get('adminmenu', 'main')

local groups = {
	["Founder"] = "Founder",
    ["Staff Manager"] = "Staff Manager",
    ["Community Manager"] = "Community Manager",
    ["Head Admin"] = "Head Admin",
    ["Senior Admin"] = "Senior Admin",
	["Admin"] = "Admin",
    ["Senior Mod"] = "Senior Moderator",
	["Moderator"] = "Moderator",
    ["Support Team"] = "Support Team",
    ["Trial Staff"] = "Trial Staff",
    ["cardev"] = "Car Developer",
    ["Supporter"] = "Supporter",
    ["Premium"] = "Premium",
    ["Supreme"] = "Supreme",
    ["Kingpin"] = "Kingpin",
    ["Rainmaker"] = "Rainmaker",
    ["Baller"] = "Baller",
    ["pov"] = "POV List",
    ["Copper"] = "Copper License",
    ["Weed"] = "Weed License",
    ["Limestone"] = "Limestone License",
    ["Gang"] = "Gang License",
    ["Cocaine"] = "Cocaine License",
    ["Meth"] = "Meth License",
    ["Heroin"] = "Heroin License",
    ["LSD"] = "LSD License",
    ["Rebel"] = "Rebel License",
    ["AdvancedRebel"] = "Advanced Rebel License",
    ["Gold"] = "Gold License",
    ["Diamond"] = "Diamond License",
    ["DJ"] = "DJ License",
    ["PilotLicense"] = "Pilot License",
    ["polblips"] = "Long Range Emergency Blips",
    ["Highroller"] = "Highrollers License",
    ["TutorialDone"] = "Completed Tutorial",
    ["Royal Mail Driver"] = "Royal Mail Driver",
    ["Bus Driver"] = "Bus Driver",
    ["Deliveroo"] = "Deliveroo",
    ["Scuba Diver"] = "Scuba Diver",
    ["G4S Driver"] = "G4S Driver",
    ["Taco Seller"] = "Taco Seller",
    ["Burger Shot Cook"] = "Burger Shot Cook",
    ["Cinematic"] = "Cinematic Menu",
}


RegisterNetEvent("ARMA:ReturnNearbyPlayers")
AddEventHandler("ARMA:ReturnNearbyPlayers", function(table)
    playersNearby = table
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if hoveredPlayer ~= nil then
            local playerCoords = GetEntityCoords(tARMA.getPlayerPed())
            if tARMA.isInSpectate() then
                playerCoords = GetFinalRenderedCamCoord()
            end
            TriggerServerEvent("ARMA:GetNearbyPlayers", playerCoords, 250)
            Citizen.Wait(1000)
        end
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
    if tARMA.getStaffLevel() >= 1 then
        if RageUI.Visible(RMenu:Get('adminmenu', 'main')) then
            RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
                hoveredPlayer = nil
                selectedbans = {}
                for k, v in pairs(banreasons) do
                    v.itemchecked = false
                end
                RageUI.ButtonWithStyle("All Players", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get('adminmenu', 'players'))
                RageUI.ButtonWithStyle("Nearby Players", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local playerCoords = GetEntityCoords(tARMA.getPlayerPed())
                        if tARMA.isInSpectate() then
                            playerCoords = GetFinalRenderedCamCoord()
                        end
                        TriggerServerEvent("ARMA:GetNearbyPlayers", playerCoords, 250)
                    end
                end, RMenu:Get('adminmenu', 'closeplayers'))
                RageUI.ButtonWithStyle("Search Players", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get('adminmenu', 'searchoptions'))
                RageUI.ButtonWithStyle("Functions", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get('adminmenu', 'functions'))
                RageUI.ButtonWithStyle("Settings", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get('SettingsMenu', 'MainMenu'))
            end)
        end
    end
    if RageUI.Visible(RMenu:Get('adminmenu', 'players')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            for k, v in pairs(players) do
                if not tARMA.isUserHidden(v[3]) then
                    RageUI.ButtonWithStyle(v[1] .." ["..v[2].."]", v[1] .. " ("..v[4].." hours) PermID: " .. v[3] .. " TempID: " .. v[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SelectedPlayer = players[k]
                            SelectedPerm = v[3]
                            TriggerServerEvent("ARMA:CheckPov",v[3])
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('adminmenu', 'closeplayers')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if next(playersNearby) then
                for i, v in pairs(playersNearby) do
                    if not tARMA.isUserHidden(v[3]) then
                        RageUI.ButtonWithStyle(v[1] .." ["..v[2].."]", v[1] .. " ("..v[4].." hours) PermID: " .. v[3] .. " TempID: " .. v[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                            if Selected then 
                                SelectedPlayer = playersNearby[i]
                                SelectedPerm = v[3]
                                TriggerServerEvent("ARMA:CheckPov",v[3])
                            end
                            if Active then 
                                hoveredPlayer = v[2]
                            end
                        end, RMenu:Get("adminmenu", "submenu"))
                    end
                end
            else
                RageUI.Separator("No players nearby!")
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('adminmenu', 'searchoptions')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            foundMatch = false
            RageUI.ButtonWithStyle("Search by Name", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('adminmenu', 'searchname'))
            RageUI.ButtonWithStyle("Search by Perm ID", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('adminmenu', 'searchpermid'))
            RageUI.ButtonWithStyle("Search by Temp ID", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('adminmenu', 'searchtempid'))
            RageUI.ButtonWithStyle("Search History", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('adminmenu', 'searchhistory'))
        end)
    end
    if RageUI.Visible(RMenu:Get('adminmenu', 'functions')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if tARMA.getStaffLevel() >= 1 then
                RageUI.ButtonWithStyle("Get Coords", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('ARMA:GetCoords')
                    end
                end)                 
                RageUI.List("Teleport",q,s,"",{},true,function(x, y, z, N)
                    s = N
                    if z then
                        tARMA.teleport2(vector3(r[s]), true)
                    end
                end,
                function()end)
            end
            if tARMA.getStaffLevel() >= 5 then
                RageUI.ButtonWithStyle("TP To Coords","",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("ARMA:Tp2Coords")
                    end
                end)
            end
            if tARMA.getStaffLevel() >= 2 then
                RageUI.ButtonWithStyle("Offline Ban","",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        tARMA.clientPrompt("Perm ID:","",function(a)
                            banningPermID = a
                            banningName = 'ID: ' .. banningPermID
                            o = nil
                            selectedbans = {}
                            for k, v in pairs(banreasons) do
                                v.itemchecked = false
                            end
                            TriggerServerEvent('ARMA:getNotes', banningPermID)
                        end)
                    end
                end, RMenu:Get('adminmenu', 'notespreviewban'))
            end
            if tARMA.getStaffLevel() >= 5 then
                RageUI.ButtonWithStyle("TP To Waypoint", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
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
                            tARMA.notify("~r~You do not have a waypoint set")
                        end
                    end
                end)
            end
            if tARMA.getStaffLevel() >= 5 then
                RageUI.ButtonWithStyle("Unban","",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("ARMA:Unban")
                    end
                end)
            end
            if tARMA.getStaffLevel() >= 3 then
                RageUI.ButtonWithStyle("Spawn Taxi", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local A = GetEntityCoords(tARMA.getPlayerPed())
                        tARMA.spawnVehicle("taxi",A.x,A.y,A.z,GetEntityHeading(tARMA.getPlayerPed()),true,true,true)
                    end
                end)
            end
            if tARMA.getStaffLevel() >= 5 then
                RageUI.ButtonWithStyle("Revive All Nearby", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local D = tARMA.getPlayerCoords()
                        for E, S in pairs(GetActivePlayers()) do
                            local T = GetPlayerServerId(S)
                            local M = GetPlayerPed(S)
                            if T ~= -1 and M ~= 0 then
                                local U = GetEntityCoords(M, true)
                                if #(D - U) < 50.0 then
                                    local V = tARMA.clientGetUserIdFromSource(T)
                                    if V > 0 then
                                        TriggerServerEvent('ARMA:RevivePlayer', GetPlayerServerId(PlayerId()), V, true)
                                    end
                                end
                            end
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Remove Warning","",{RightLabel="→→→"},true,function(Hovered, Active, Selected)
                    if Selected then
                        AddTextEntry('FMMC_MPM_NC', "Enter the Warning ID")
                        DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0);
                            Wait(0);
                        end
                        if (GetOnscreenKeyboardResult()) then
                            local result = GetOnscreenKeyboardResult()
                            if result then 
                                TriggerServerEvent('ARMA:RemoveWarning', result)
                            end
                        end
                    end
                end)
            end 
            if tARMA.getStaffLevel() >= 6 then
                local P=""
                if tARMA.hasStaffBlips() then 
                    P="~r~Turn off blips"
                else 
                    P="~g~Turn on blips"
                end
                RageUI.ButtonWithStyle("Toggle Blips", P, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        tARMA.staffBlips(not tARMA.hasStaffBlips())
                    end
                end)
                RageUI.ButtonWithStyle("Community Pot Menu","",{RightLabel="→→→"},true,function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("ARMA:getCommunityPotAmount")
                    end
                end,RMenu:Get('adminmenu','communitypot'))
                RageUI.ButtonWithStyle("RP Zones","",{RightLabel="→→→"},true,function(Hovered, Active, Selected)
                end,RMenu:Get("rpzones","mainmenu"))
            end  
            if tARMA.getStaffLevel() >= 10 then
                RageUI.ButtonWithStyle("Give Money","",{RightLabel="→→→"},true,function(Hovered, Active, Selected)
                end,RMenu:Get('adminmenu','moneymenu'))
                RageUI.ButtonWithStyle("Add Car", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('ARMA:AddCar')
                    end
                end, RMenu:Get('adminmenu', 'functions'))
                RageUI.Checkbox("Set Globally Hidden","",tARMA.isLocalPlayerHidden(),{},function()
                end,function()
                    TriggerServerEvent("ARMA:setUserHidden", true)
                end,function()
                    TriggerServerEvent("ARMA:setUserHidden", false)
                end)
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('adminmenu', 'moneymenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if a10 ~= nil and sn ~= nil and sc ~= nil and sb ~= nil and sw ~= nil and sch ~= nil then
                RageUI.Separator("Name: ~b~"..sn)
                RageUI.Separator("PermID: ~b~"..a10)
                RageUI.Separator("TempID: ~b~"..sc)
                RageUI.Separator("Bank Balance: ~b~£"..sb)
                RageUI.Separator("Cash Balance: ~b~£"..sw)
                RageUI.Separator("Casino Chips: ~b~"..sch)
                RageUI.Separator("")
                RageUI.ButtonWithStyle("Bank Balance ~g~+",nil,{RightLabel="→→→"},true,function(w,x,y)
                    if y then
                        tARMA.clientPrompt("Amount:","",function(j)
                            if tonumber(j) then
                                TriggerServerEvent('ARMA:ManagePlayerBank',a10,j,"Increase")
                            else
                                tARMA.notify("~r~Invalid Amount")
                            end
                        end)
                    end
                end)
                RageUI.ButtonWithStyle("Bank Balance ~r~-",nil,{RightLabel="→→→"},true,function(w,x,y)
                    if y then
                        tARMA.clientPrompt("Amount:","",function(j)
                            if tonumber(j) then
                                TriggerServerEvent('ARMA:ManagePlayerBank',a10,j,"Decrease")
                            else
                                tARMA.notify("~r~Invalid Amount")
                            end
                        end)
                    end
                end)
                RageUI.ButtonWithStyle("Cash Balance ~g~+~w~",nil,{RightLabel="→→→"},true,function(w,x,y)
                    if y then
                        tARMA.clientPrompt("Amount:","",function(l)
                            if tonumber(l) then
                                TriggerServerEvent('ARMA:ManagePlayerCash',a10,l,"Increase")
                            else
                                tARMA.notify("~r~Invalid Amount")
                            end
                        end)
                    end
                end)
                RageUI.ButtonWithStyle("Cash Balance ~r~-",nil,{RightLabel="→→→"},true,function(w,x,y)
                    if y then
                        tARMA.clientPrompt("Amount:","",function(l)
                            if tonumber(l) then
                                TriggerServerEvent('ARMA:ManagePlayerCash',a10,l,"Decrease")
                            else
                                tARMA.notify("~r~Invalid Amount")
                            end
                        end)
                    end
                end)
                RageUI.ButtonWithStyle("Casino Chips ~g~+",nil,{RightLabel="→→→"},true,function(w,x,y)
                    if y then
                        tARMA.clientPrompt("Amount:","",function(l)
                            if tonumber(l) then
                                TriggerServerEvent('ARMA:ManagePlayerChips',a10,l,"Increase")
                            else
                                tARMA.notify("~r~Invalid Amount")
                            end
                        end)
                    end
                end)
                RageUI.ButtonWithStyle("Casino Chips ~r~-",nil,{RightLabel="→→→"},true,function(w,x,y)
                    if y then
                        tARMA.clientPrompt("Amount:","",function(l)
                            if tonumber(l) then
                                TriggerServerEvent('ARMA:ManagePlayerChips',a10,l,"Decrease")
                            else
                                tARMA.notify("~r~Invalid Amount")
                            end
                        end)
                    end
                end)
            end
            RageUI.ButtonWithStyle("Choose PermID",nil, { RightLabel = "→→→" }, true, function(w,x,y)
                if y then
                    tARMA.clientPrompt("PermID:","",function(j)
                        if tonumber(j) then
                            a10 = tonumber(j)
                            tARMA.notify("~g~PermID Set To "..j)
                            TriggerServerEvent('ARMA:getUserinformation',a10)
                        else
                            tARMA.notify("~r~Invalid PermID")
                            a10 = nil
                        end
                    end)
                end
            end, RMenu:Get('adminmenu', 'moneymenu'))
        end)
    end
    if RageUI.Visible(RMenu:Get('adminmenu', 'communitypot')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.Separator("Community Pot Balance: ~g~£"..getMoneyStringFormatted(communityPot))
            RageUI.ButtonWithStyle("Deposit","",{RightLabel="→→→"},true,function(e,f,g)
                if g then 
                    tARMA.clientPrompt("Enter Amount:","",function(d)
                        if tonumber(d)then 
                            TriggerServerEvent("ARMA:tryDepositCommunityPot",d)
                        else 
                            tARMA.notify("~r~Invalid amount.")
                        end 
                    end)
                end 
            end)
            RageUI.ButtonWithStyle("Withdraw","",{RightLabel="→→→"},true,function(e,f,g)
                if g then 
                    tARMA.clientPrompt("Enter Amount:","",function(d)
                        if tonumber(d)then 
                            TriggerServerEvent("ARMA:tryWithdrawCommunityPot",d)
                        else 
                            tARMA.notify("~r~Invalid amount.")
                        end 
                    end)
                end 
            end)
        end)
    end
    if RageUI.Visible(RMenu:Get('adminmenu', 'devfunctions')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if tARMA.isDev() or tARMA.getStaffLevel() >= 10 then
                RageUI.ButtonWithStyle("Spawn Weapon", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('ARMA:Giveweapon')
                    end
                end, RMenu:Get('adminmenu', 'devfunctions'))
                RageUI.ButtonWithStyle("Give Weapon", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('ARMA:GiveWeaponToPlayer')
                    end
                end, RMenu:Get('adminmenu', 'devfunctions'))
                RageUI.ButtonWithStyle("Armour", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        tARMA.setArmour(100)
                    end
                end, RMenu:Get('adminmenu', 'devfunctions'))
            end        
        end)
    end
    if RageUI.Visible(RMenu:Get('adminmenu', 'searchpermid')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if foundMatch == false then
                searchforPermID = tARMA.KeyboardInput("Enter Perm ID", "", 10)
                if searchforPermID == nil then 
                    searchforPermID = ""
                end
            end
            for k, v in pairs(players) do
                foundMatch = true
                if string.find(v[3],searchforPermID) then
                    if not tARMA.isUserHidden(v[3]) then
                        RageUI.ButtonWithStyle(v[1] .." ["..v[2].."]", v[1] .. " ("..v[4].." hours) PermID: " .. v[3] .. " TempID: " .. v[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                            if Selected then
                                SelectedPlayer = players[k]
                                TriggerServerEvent("ARMA:CheckPov",v[3])
                                g = v[3]
                                h[i] = g
                                i = i + 1
                            end
                        end, RMenu:Get('adminmenu', 'submenu'))
                    end
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('adminmenu', 'searchtempid')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if foundMatch == false then
                searchid = tARMA.KeyboardInput("Enter Temp ID", "", 10)
                if searchid == nil then 
                    searchid = ""
                end
            end
            for k, v in pairs(players) do
                foundMatch = true
                if string.find(v[2], searchid) then
                    if not tARMA.isUserHidden(v[3]) then
                        RageUI.ButtonWithStyle(v[1] .." ["..v[2].."]", v[1] .. " ("..v[4].." hours) PermID: " .. v[3] .. " TempID: " .. v[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                            if Selected then
                                SelectedPlayer = players[k]
                                TriggerServerEvent("ARMA:CheckPov",v[3])
                                g = v[2]
                                h[i] = g
                                i = i + 1
                            end
                        end, RMenu:Get('adminmenu', 'submenu'))
                    end
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('adminmenu', 'searchname')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if foundMatch == false then
                SearchName = tARMA.KeyboardInput("Enter Name", "", 10)
                if SearchName == nil then 
                    SearchName = ""
                end
            end
            for k, v in pairs(players) do
                foundMatch = true
                if string.find(string.lower(v[1]), string.lower(SearchName)) then
                    if not tARMA.isUserHidden(v[3]) then
                        RageUI.ButtonWithStyle(v[1] .." ["..v[2].."]", v[1] .. " ("..v[4].." hours) PermID: " .. v[3] .. " TempID: " .. v[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                            if Selected then
                                SelectedPlayer = players[k]
                                TriggerServerEvent("ARMA:CheckPov",v[3])
                                g = v[1]
                                h[i] = g
                                i = i + 1
                            end
                        end, RMenu:Get('adminmenu', 'submenu'))
                    end
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('adminmenu', 'searchhistory')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            for k, v in pairs(players) do
                if i > 1 then
                    for K = #h, #h - 10, -1 do
                        if h[K] then
                            if tonumber(h[K]) == v[3] or tonumber(h[K]) == v[2] or h[K] == v[1] then
                                RageUI.ButtonWithStyle("[" .. v[3] .. "] " .. v[1], v[1] .. " Perm ID: " .. v[3] .. " Temp ID: " .. v[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                                    if Selected then
                                        SelectedPlayer = players[k]
                                        TriggerServerEvent("ARMA:CheckPov",v[3])
                                    end
                                end, RMenu:Get('adminmenu', 'submenu'))
                            end
                        end
                    end
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('adminmenu', 'submenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            hoveredPlayer = nil
            if tARMA.isUserHidden(SelectedPlayer[3]) then
                RageUI.ActuallyCloseAll()
            end
            if povlist == nil then
                RageUI.Separator("~y~Player must provide POV on request: Loading...")
            elseif povlist == true then
                RageUI.Separator("~y~Player must provide POV on request: ~g~true")
            elseif povlist == false then
                RageUI.Separator("~y~Player must provide POV on request: ~r~false")
            end
            if tARMA.getStaffLevel() >= 1 then
                RageUI.ButtonWithStyle("Player Notes", SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('ARMA:getNotes', SelectedPlayer[3])
                    end
                end, RMenu:Get('adminmenu', 'notesub'))
                RageUI.ButtonWithStyle("Kick Player", SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local uid = GetPlayerServerId(PlayerId())
                        TriggerServerEvent('ARMA:KickPlayer', uid, SelectedPlayer[3], SelectedPlayer[2])
                    end
                end, RMenu:Get('adminmenu', 'submenu'))
            end
            if tARMA.getStaffLevel() >= 2 then
                RageUI.ButtonWithStyle("Ban Player", SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        banningPermID = SelectedPlayer[3]
                        banningName = SelectedPlayer[1]
                        o = nil
                        TriggerServerEvent('ARMA:getNotes', SelectedPlayer[3])
                        selectedbans = {}
                        for k, v in pairs(banreasons) do
                            v.itemchecked = false
                        end
                    end
                end, RMenu:Get('adminmenu', 'notespreviewban'))
                RageUI.ButtonWithStyle("Spectate Player", SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        if tonumber(SelectedPlayer[2]) ~= GetPlayerServerId(PlayerId()) then
                            if not tARMA.isInSpectate() then
                                inRedZone = false
                                TriggerServerEvent("ARMA:spectatePlayer", SelectedPlayer[3])
                                inSpectatorAdminMode = true
                                RageUI.Text({message = string.format("~r~Press [E] to stop spectating.")})
                            else
                                tARMA.notify("~r~You are already spectating a player.")
                            end
                        else
                            tARMA.notify("~r~You cannot spectate yourself.")
                        end
                    end
                end, RMenu:Get('adminmenu', 'submenu'))
            end
            if tARMA.getStaffLevel() >= 3 then
                RageUI.ButtonWithStyle("Revive", SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local uid = GetPlayerServerId(PlayerId())
                        TriggerServerEvent('ARMA:RevivePlayer', uid, SelectedPlayer[3])
                    end
                end, RMenu:Get('adminmenu', 'submenu'))
            end
            if tARMA.getStaffLevel() >= 1 then
                RageUI.ButtonWithStyle("Teleport to Player", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local newSource = GetPlayerServerId(PlayerId())
                        TriggerServerEvent('ARMA:TeleportToPlayer', newSource, SelectedPlayer[2])
                    end
                end, RMenu:Get('adminmenu', 'submenu'))
                RageUI.ButtonWithStyle("Teleport Player to Me", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('ARMA:BringPlayer', SelectedPlayer[2])
                    end
                end, RMenu:Get('adminmenu', 'submenu'))
                RageUI.ButtonWithStyle("Teleport to Admin Zone", SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        inRedZone = false
                        savedCoordsBeforeAdminZone = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(SelectedPlayer[2])))
                        TriggerServerEvent("ARMA:Teleport2AdminIsland", SelectedPlayer[2])
                    end
                end, RMenu:Get('adminmenu', 'submenu'))
                RageUI.ButtonWithStyle("Teleport Back from Admin Zone", SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("ARMA:TeleportBackFromAdminZone", SelectedPlayer[2], savedCoordsBeforeAdminZone)
                    end
                end, RMenu:Get('adminmenu', 'submenu'))
                RageUI.ButtonWithStyle("Teleport to Legion", SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("ARMA:Teleport2Legion", SelectedPlayer[2])
                    end
                end, RMenu:Get('adminmenu', 'submenu'))
                RageUI.ButtonWithStyle("Freeze", SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local uid = GetPlayerServerId(PlayerId())
                        isFrozen = not isFrozen
                        TriggerServerEvent('ARMA:FreezeSV', uid, SelectedPlayer[2], isFrozen)
                    end
                end, RMenu:Get('adminmenu', 'submenu'))
            end
            if tARMA.getStaffLevel() >= 5 then
                RageUI.ButtonWithStyle("Slap Player", SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local uid = GetPlayerServerId(PlayerId())
                        TriggerServerEvent('ARMA:SlapPlayer', uid, SelectedPlayer[2])
                    end
                end, RMenu:Get('adminmenu', 'submenu'))
                RageUI.ButtonWithStyle("Force Clock Off", SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('ARMA:ForceClockOff', SelectedPlayer[2])
                    end
                end, RMenu:Get('adminmenu', 'submenu'))
            end
            if tARMA.getStaffLevel() >= 1 then
                RageUI.ButtonWithStyle("Open F10 Warning Log", SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        ExecuteCommand("sw " .. SelectedPlayer[3])
                    end
                end, RMenu:Get('adminmenu', 'submenu'))
            end
            if tARMA.getStaffLevel() >= 2 then
                RageUI.ButtonWithStyle("Take Screenshot", SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local uid = GetPlayerServerId(PlayerId())
                        TriggerServerEvent('ARMA:RequestScreenshot', uid , SelectedPlayer[2])
                    end
                end, RMenu:Get('adminmenu', 'submenu'))
                RageUI.Button("Take Video", SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], requestedVideo and {RightLabel = ""} or {RightLabel = "→→→"}, not requestedVideo, function(Hovered, Active, Selected)
                    if Selected then
                        local uid = GetPlayerServerId(PlayerId())
                        TriggerServerEvent('ARMA:RequestVideo', uid, SelectedPlayer[2])
                        requestedVideo = true
                        SetTimeout(15000, function()
                            requestedVideo = false
                        end)
                    end
                end, RMenu:Get('adminmenu', 'submenu'))
            end
            if tARMA.getStaffLevel() >= 6 then
                RageUI.ButtonWithStyle("Request Account Info", SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("ARMA:requestAccountInfosv", SelectedPlayer[3])
                    end
                end,RMenu:Get("adminmenu", "submenu"))
                RageUI.ButtonWithStyle("See Groups", SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("ARMA:GetGroups", SelectedPlayer[3])
                        tt=''
                    end
                end,RMenu:Get("adminmenu", "groups"))
            end
            if tARMA.getStaffLevel() >= 12 then
                RageUI.ButtonWithStyle("Commit Godly Wrath on Player","",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("ARMA:zapPlayer", SelectedPlayer[2])
                    end
                end,RMenu:Get("adminmenu", "submenu"))
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('adminmenu', 'notespreviewban')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if tARMA.getStaffLevel() >= 2 then
                if noteslist == nil then
                    RageUI.Separator("~o~Player notes: Loading...")
                elseif #noteslist == 0 then
                    RageUI.Separator("~o~There are no player notes to display.")
                else
                    RageUI.Separator("~o~Player notes:")
                    for _ = 1, #noteslist do
                        RageUI.Separator("~o~ID: " .. noteslist[_].id .. " " .. noteslist[_].note .. " (" .. noteslist[_].author .. ")")
                    end
                end
                RageUI.ButtonWithStyle("Continue to Ban", nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                end, RMenu:Get('adminmenu', 'banselection'))
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('adminmenu', 'banselection')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if tARMA.getStaffLevel() >= 2 then
                if IsControlJustPressed(0, 37) then
                    tARMA.clientPrompt("Search for: ","",function(O)
                        if O ~= "" then
                            o = string.lower(O)
                        else
                            o = nil
                        end
                    end)
                end
                for k, v in pairs(banreasons) do
                    local function SelectedTrue()
                        selectedbans[v.id] = true
                    end
                    local function SelectedFalse()
                        selectedbans[v.id] = nil
                    end
                    if o == nil or string.match(string.lower(v.id), o) or string.match(string.lower(v.name), o) then
                        RageUI.Checkbox(v.name, v.bandescription, v.itemchecked, { RightBadge = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
                            if Selected then
                                if v.itemchecked then
                                    SelectedTrue()
                                end
                                if not v.itemchecked then
                                    SelectedFalse()
                                end
                            end
                            v.itemchecked = Checked
                        end)
                    end
                end
                RageUI.ButtonWithStyle("Confirm Ban", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("ARMA:GenerateBan", banningPermID, selectedbans)
                    end
                end, RMenu:Get('adminmenu', 'generatedban'))
        
                RageUI.ButtonWithStyle("Cancel Ban", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        selectedbans = {}
                        for k, v in pairs(banreasons) do
                            v.itemchecked = false
                        end
                        RageUI.ActuallyCloseAll()
                    end
                end)
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('adminmenu', 'generatedban')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if tARMA.getStaffLevel() >= 2 then
                if next(selectedbans) then
                    if BanMessage == "N/A" then
                        RageUI.Separator("~g~Generating ban info, please wait...")
                    else
                        RageUI.Separator("~r~You are about to ban " ..banningName, function() end)
                        RageUI.Separator("For the following reason(s):", function() end)
                        for k,v in pairs(SeparatorMsg) do
                            RageUI.Separator(v, function() end)
                        end
                        local U=false
                        if Duration == -1 then
                            U=true
                        end
                        RageUI.Separator("~w~Total Length: "..(U and "Permanent" or Duration.." hrs"))
                        RageUI.ButtonWithStyle("Cancel", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                            if Selected then
                                selectedbans = {}
                                for k, v in pairs(banreasons) do
                                    v.itemchecked = false
                                end
                                RageUI.ActuallyCloseAll()
                            end
                        end)
                        RageUI.ButtonWithStyle("Confirm", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                            if Selected then
                                TriggerServerEvent("ARMA:BanPlayer", banningPermID, Duration, BanMessage, BanPoints)
                            end
                        end)
                    end
                else
                    RageUI.Separator("~r~You must select at least one ban reason.", function() end)
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('adminmenu', 'notesub')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if noteslist == nil then
                RageUI.Separator("~o~Player notes: Loading...")
            elseif #noteslist == 0 then
                RageUI.Separator("~o~There are no player notes to display.")
            else
                RageUI.Separator("~o~Player notes:")
                for _ = 1, #noteslist do
                    RageUI.Separator("~o~ID: " .. noteslist[_].id .. " " .. noteslist[_].note .. " (" .. noteslist[_].author .. ")")
                end
            end
            if tARMA.getStaffLevel() >= 1 then
                RageUI.ButtonWithStyle("Add To Notes:", SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                    if Selected then
                        tARMA.clientPrompt("Add To Notes: ","",function(a7)
                            if a7 ~= "" then
                                if #noteslist ~= 0 then
                                    noteslist[#noteslist + 1] = {id = #noteslist + 1, note = a7, author = tARMA.getUserId()}
                                else
                                    noteslist = {{id = 1, note = a7, author = tARMA.getUserId()}}
                                end
                                TriggerServerEvent("ARMA:updatePlayerNotes", SelectedPlayer[3], noteslist)
                            end
                        end)
                    end
                end)
                RageUI.ButtonWithStyle("Remove Note", nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                    if Selected then
                        tARMA.clientPrompt("Type the ID of the note","",function(a7)
                            if a7 ~= "" then
                                a7 = tonumber(a7)
                                local a8 = {}
                                local a9 = false
                                for _ = 1, #noteslist do
                                    if noteslist[_].id == a7 then
                                        for aa = 1, #noteslist do
                                            if aa ~= _ then
                                                a8[#a8 + 1] = {
                                                    id = #a8 + 1,
                                                    note = noteslist[aa].note,
                                                    author = noteslist[aa].author
                                                }
                                            end
                                        end
                                        a9 = true
                                        break
                                    end
                                end
                                if a9 == true then
                                    if #a8 == 0 then
                                        a8 = nil
                                        noteslist = {}
                                    else
                                        noteslist = a8
                                    end
                                    TriggerServerEvent("ARMA:updatePlayerNotes", SelectedPlayer[3], a8)
                                end
                            end
                        end)
                    end
                end)
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('adminmenu', 'groups')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if tARMA.getStaffLevel() >= 7 then
                if IsControlJustPressed(0, 37) then
                    tARMA.clientPrompt("Search for: ","",function(S)
                        tt=string.lower(S)
                    end)
                end
                for k,S in pairs(groups) do
                    if tt=="" or string.find(string.lower(S),string.lower(tt)) then
                        if searchPlayerGroups[k] then
                            RageUI.ButtonWithStyle("~g~"..S,"~g~User has this group.",{RightLabel="→→→"},true,function(x,y,z)
                                if z then 
                                    selectedGroup = k
                                end 
                            end,RMenu:Get('adminmenu','removegroup'))
                        else 
                            RageUI.ButtonWithStyle("~r~"..S,"~r~User does not have this group.",{RightLabel="→→→"},true,function(x,y,z)
                                if z then 
                                    selectedGroup = k
                                end 
                            end,RMenu:Get('adminmenu','addgroup'))
                        end 
                    end
                end
            end
        end) 
    end
    if RageUI.Visible(RMenu:Get('adminmenu', 'addgroup')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.ButtonWithStyle("Add this group to user", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent("ARMA:AddGroup",SelectedPerm,selectedGroup)
                end
            end, RMenu:Get('adminmenu', 'groups'))
        end)
    end
    if RageUI.Visible(RMenu:Get('adminmenu', 'removegroup')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.ButtonWithStyle("Remove user from group", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent("ARMA:RemoveGroup",SelectedPerm,selectedGroup)
                end
            end, RMenu:Get('adminmenu', 'groups')) 
        end)
    end
end)

RegisterCommand("cleanup", function()
    TriggerServerEvent('ARMA:CleanAll')
end)

RegisterNetEvent('ARMA:SlapPlayer')
AddEventHandler('ARMA:SlapPlayer', function()
    SetEntityHealth(PlayerPedId(), 0)
end)


frozen = false
RegisterNetEvent("ARMA:Freeze",function()
    local Q = tARMA.getPlayerPed()
    if IsPedSittingInAnyVehicle(Q) then
        local ak = GetVehiclePedIsIn(Q, false)
        TaskLeaveVehicle(Q, ak, 4160)
    end
    if not frozen then
        FreezeEntityPosition(Q, true)
        frozen = true
        while frozen do
            tARMA.setWeapon(Q, "WEAPON_UNARMED", true)
            Wait(0)
        end
    else
        FreezeEntityPosition(Q, false)
        frozen = false
    end
end)


RegisterNetEvent("ARMA:sendNotes",function(a7)
    a7 = json.decode(a7)
    if a7 == nil then
        noteslist = {}
    else
        noteslist = a7
    end
end)

RegisterNetEvent('ARMA:ReturnPov')
AddEventHandler('ARMA:ReturnPov', function(pov)
    povlist = pov
end)

RegisterNetEvent("ARMA:GotGroups")
AddEventHandler("ARMA:GotGroups",function(gotGroups)
    searchPlayerGroups = gotGroups
end)

RegisterNetEvent("ARMA:getPlayersInfo")
AddEventHandler("ARMA:getPlayersInfo", function(BB, preasons)
    players = BB
    banreasons = preasons
    RageUI.Visible(RMenu:Get("adminmenu", "main"), not RageUI.Visible(RMenu:Get("adminmenu", "main")))
end)

RegisterNetEvent("ARMA:RecieveBanPlayerData")
AddEventHandler("ARMA:RecieveBanPlayerData",function(BanDuration, CollectedBanMessage, SepMSG, points)
    Duration = BanDuration
    BanMessage = CollectedBanMessage
    SeparatorMsg = SepMSG
    BanPoints = points
    RageUI.Visible(RMenu:Get('adminmenu', 'generatedban'), true)
end)

RegisterNetEvent("ARMA:receivedUserInformation")
AddEventHandler("ARMA:receivedUserInformation", function(us,un,ub,uw,uc)
    if us == nil or un == nil or ub == nil or uw == nil or uc == nil then
        a10 = nil
        tARMA.notify("Player does not exist.")
        return
    end
    sc=us
    sn=un
    sb=getMoneyStringFormatted(ub)
    sw=getMoneyStringFormatted(uw)
    sch=getMoneyStringFormatted(uc)
end)

RegisterNetEvent("ARMA:gotCommunityPotAmount",function(d)
    communityPot=tostring(d)
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

RegisterNetEvent('ARMA:OpenAdminMenu')
AddEventHandler('ARMA:OpenAdminMenu', function(admin)
    if admin then
        TriggerServerEvent('ARMA:GetPlayerData')
        TriggerServerEvent("ARMA:GetNearbyPlayerData")
        TriggerServerEvent("ARMA:getAdminLevel")
    end
end)

RegisterCommand('devmenu',function()
    if tARMA.isDev() then
        RageUI.Visible(RMenu:Get("adminmenu", "devfunctions"), not RageUI.Visible(RMenu:Get("adminmenu", "devfunctions")))
    end
end)

function DrawHelpMsg(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

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

function func_checkSpectatorMode()
    if inSpectatorAdminMode then
        if IsControlJustPressed(0, 51) then
            inSpectatorAdminMode = false
            TriggerServerEvent("ARMA:stopSpectatePlayer")
        end
    end
end
tARMA.createThreadOnTick(func_checkSpectatorMode)


RegisterNetEvent("ARMA:takeClientScreenshotAndUpload",function(url)
    local url = url -- need a custom uploader whenever
    exports["screenshot-basic"]:requestScreenshotUpload(url,"files[]",function(ab)
    end)
end)

RegisterNetEvent("ARMA:takeClientVideoAndUpload",function(url)
    local url = url  -- need a custom uploader whenever
    exports["screenshot-basic"]:requestVideoUpload(url,"files[]",{headers = {}, isVideo = true, isManual = true, encoding = "mp4"},function(ac)
    end)
end)

local an = 0
local function ao()
    local ap = GetResourceState("screenshot-basic")
    if ap == "started" then
        exports["screenshot-basic"]:requestKeepAlive(function(aq)
            if not aq then
                an = GetGameTimer()
            end
        end)
    end
    if GetGameTimer() - an > 60000 then
        TriggerServerEvent("ARMA:acType16")
    end
end
AddEventHandler("ARMA:onClientSpawn",function(C, D)
    if D then
        an = GetGameTimer()
        while true do
            ao()
            Citizen.Wait(5000)
        end
    end
end)