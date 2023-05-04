CallManagerClient = {}
Tunnel.bindInterface("CallManager",CallManagerClient)
Proxy.addInterface("CallManager",CallManagerClient)
CallManagerServer = Tunnel.getInterface("CallManager","CallManager")
vRP = Proxy.getInterface("vRP")

local adminCalls = {}
local nhsCalls = {}
local pdCalls = {}

local savedCoords = true
local takenticket = false

local isPlayerNHS = false
local isPlayerPD = false

RMenu.Add('callmanager', 'main', RageUI.CreateMenu("", '~w~ERP Call Manager', 1300, 100, "callmanager", "callmanager"))
RMenu.Add("callmanager", "admin", RageUI.CreateSubMenu(RMenu:Get("callmanager", "main",  1300, 100)))
RMenu.Add("callmanager", "police", RageUI.CreateSubMenu(RMenu:Get("callmanager", "main",  1300, 100)))
RMenu.Add("callmanager", "nhs", RageUI.CreateSubMenu(RMenu:Get("callmanager", "main",  1300, 100)))
RMenu:Get('callmanager', 'main')

RageUI.CreateWhile(1.0, RMenu:Get('callmanager', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('callmanager', 'main'), true, false, true, function()  
        if isPlayerAdmin then
            RageUI.Button("Admin Tickets", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('callmanager', 'admin'))
        end
        if isPlayerPD then 
            RageUI.Button("Police Calls", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('callmanager', 'police')) 
        end
        if isPlayerNHS then
            RageUI.Button("NHS Calls", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('callmanager', 'nhs'))
        end
    end)
end)


RageUI.CreateWhile(1.0, RMenu:Get('callmanager', 'admin'), nil, function()
    RageUI.IsVisible(RMenu:Get('callmanager', 'admin'), true, false, true, function()  
        if adminCalls ~= nil then
            for k,v in pairs(adminCalls) do
                RageUI.Button(string.format("[ %s ] %s" .. "  :  " .. v[3], v[2], v[1]), "Press ~r~[ENTER] ~w~To accept  ~r~" .. v[1] .. "'s ~w~ticket!", {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        if v[2] == GetPlayerServerId(PlayerId()) then
                            notify("~r~You can't take your own Call!")
                        else
                            if not isInTicket then
                                    savedCoords = GetEntityCoords(PlayerPedId())
                            
                                    CallManagerServer.GetUpdatedCoords({v[2]}, function(targetCoords)
                                        SetEntityCoords(PlayerPedId(), targetCoords)
                                       notify("~g~You earned £15,000 for taking a staff ticket! ❤️")
                                       vRPclient.staffmode(source, {true})
                                        TriggerServerEvent("ERP:returnMe", v[1], v[2], v[3])
                                    
                                    
                                    
                                        -- [Ticket Webhook]
                                        -- [Godmode & Clothing]
                                    end)
                                
                                    takenticket = true
                                    isInTicket = true
                                    CallManagerServer.RemoveTicket({k, "admin"})
                            end
                        end
                    end
                end, RMenu:Get('callmanager', 'admin'))
            end
        end
    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get('callmanager', 'police'), nil, function()
    RageUI.IsVisible(RMenu:Get('callmanager', 'police'), true, false, true, function()  
        if pdCalls ~= nil then
            for k,v in pairs(pdCalls) do
                RageUI.Button(string.format("[ %s ] %s" .. "  :  " .. v[3], v[2], v[1]), "Press ~r~[ENTER] ~w~To accept  ~r~" .. v[1] .. "'s ~w~call!", {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                   
                            CallManagerServer.RemoveTicket({k, "pd"})
                            CallManagerServer.GetUpdatedCoords({v[2]}, function(targetCoords)
                                SetNewWaypoint(targetCoords.x, targetCoords.y)
                            end)
                        
                    end
                end, RMenu:Get('callmanager', 'police'))
            end
        end
    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get('callmanager', 'nhs'), nil, function()
    RageUI.IsVisible(RMenu:Get('callmanager', 'nhs'), true, false, true, function()  
        if nhsCalls ~= nil then
            for k,v in pairs(nhsCalls) do
                RageUI.Button(string.format("[ %s ] %s" .. "  :  " .. v[3], v[2], v[1]), "Press ~r~[ENTER] ~w~To accept  ~r~" .. v[1] .. "'s ~w~call!", {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        if v[2] == GetPlayerServerId(PlayerId()) then
                            notify("~r~You can't take your own Call!")
                        else
                            CallManagerServer.RemoveTicket({k, "nhs"})
                            CallManagerServer.GetUpdatedCoords({v[2]}, function(targetCoords)
                                SetNewWaypoint(targetCoords.x, targetCoords.y)
                            end)
                        end
                    end
                end, RMenu:Get('callmanager', 'nhs'))
            end
        end
    end)
end)

RegisterCommand("callmanager",function()
    CallManagerServer.GetPermissions({}, function(admin, pd, nhs)
        isPlayerAdmin = admin;
        isPlayerPD = pd;
        isPlayerNHS = nhs;
    end)
    CallManagerServer.GetTickets()
    RageUI.Visible(RMenu:Get('callmanager', 'main'), not RageUI.Visible(RMenu:Get('callmanager', 'main')))
end)

RegisterKeyMapping('callmanager', 'Open Call Manager', 'keyboard', 'GRAVE')

RegisterNetEvent('CallManager:Table')
AddEventHandler('CallManager:Table', function(call, call2, call3)
    adminCalls = call
    nhsCalls = call2
    pdCalls = call3
end)

function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification( false, false)
end

RegisterCommand("return", function()
    if takenticket then
        if savedCoords == nil then return notify("~r~Couldn't get Last Position") end
        SetEntityCoords(PlayerPedId(), savedCoords)
        notify("~g~Returned.")
        takenticket = false
        vRPclient.staffmode(source, {false})
        TriggerEvent("ERP:OMioDioMode",false)
        isInTicket = false
    else 
        notify('~r~You need to /return.')
    end
end)

function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end

