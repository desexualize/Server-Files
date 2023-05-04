CallManagerClient = {}
Tunnel.bindInterface("CallManager",CallManagerClient)
Proxy.addInterface("CallManager",CallManagerClient)
CallManagerServer = Tunnel.getInterface("CallManager","CallManager")
vRP = Proxy.getInterface("vRP")

local adminCalls = {}
local nhsCalls = {}
local pdCalls = {}

local savedCoords = false
local ticketID = nil

isInTicket = false

local isPlayerNHS = false
local isPlayerPD = false
local isPlayerAdmin = false

local AdminTicketCooldown = false
local PDCallCooldown = false
local NHSCallCooldown = false

local permid = nil
local name = ''


RMenu.Add('callmanager', 'main', RageUI.CreateMenu("", '~r~FNR Call Manager', 1300, 50, "banners", "callmanager"))
RMenu.Add("callmanager", "admin", RageUI.CreateSubMenu(RMenu:Get("callmanager", "main",  1300, 50)))
RMenu.Add("callmanager", "adminsub", RageUI.CreateSubMenu(RMenu:Get("callmanager", "admin",  1300, 50)))
RMenu.Add("callmanager", "police", RageUI.CreateSubMenu(RMenu:Get("callmanager", "main",  1300, 50)))
RMenu.Add("callmanager", "nhs", RageUI.CreateSubMenu(RMenu:Get("callmanager", "main",  1300, 50)))
RMenu:Get('callmanager', 'main')

RageUI.CreateWhile(1.0, RMenu:Get('callmanager', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('callmanager', 'main'), true, false, true, function()  

        if isPlayerAdmin then
            RageUI.Button("Admin Tickets", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if (Hovered) then
                end
                if (Active) then
                end
                if (Selected) then
                end
            end, RMenu:Get('callmanager', 'admin'))
        end

        if isPlayerPD then 
            RageUI.Button("Police Calls", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if (Hovered) then
                end
                if (Active) then
                end
                if (Selected) then
                end
            end, RMenu:Get('callmanager', 'police'))
            
        end

        if isPlayerNHS then
            RageUI.Button("NHS Calls", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if (Hovered) then
                end
                if (Active) then
                end
                if (Selected) then
                end
            end, RMenu:Get('callmanager', 'nhs'))
        end

    end)
end)


RageUI.CreateWhile(1.0, RMenu:Get('callmanager', 'admin'), nil, function()
    RageUI.IsVisible(RMenu:Get('callmanager', 'admin'), true, false, true, function()  
        if #adminCalls == 0 then 
            RageUI.Separator("~b~There are no tickets right now.")
        end
        if adminCalls ~= nil then
            for k,v in pairs(adminCalls) do
                RageUI.Button(string.format("[ %s ] %s" .. "  :  " .. v[3], v[2], v[1]), nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                    
                       
                        ticketID = k
                    end
                end, RMenu:Get('callmanager', 'adminsub'))
            end
        end
    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get('callmanager', 'adminsub'), nil, function()
    RageUI.IsVisible(RMenu:Get('callmanager', 'adminsub'), true, false, true, function()  
        RageUI.Button("~g~Accept", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
            if (Selected) then
                for k,v in pairs(adminCalls) do
                    if k == ticketID then
                        if v[2] == GetPlayerServerId(PlayerId()) then
                            notify("~r~You can't take your own ticket.")
                        else
                            savedCoords86856856 = GetEntityCoords(PlayerPedId())
                            CallManagerServer.GetUpdatedCoords({v[2]}, function(targetCoords)
                                DoScreenFadeOut(1000)
                                NetworkFadeOutEntity(PlayerPedId(), true, false)
                                Wait(1000)
                                SetEntityCoords(PlayerPedId(), targetCoords)
                                NetworkFadeInEntity(PlayerPedId(), 0)
                                DoScreenFadeIn(1000)
                                notify("~g~You earned £15,000 for being cute!")
                                TriggerServerEvent("FNR:GiveTicketMoney", v[1], v[2], v[3], true)

                            end)
                            CallManagerServer.RemoveTicket({k, "admin"})
                            name = v[1]
                            isInTicket = true
                            TriggerServerEvent('FNR:getTempFromPerm',v[2])
                        end
                    end
                end
            end
        end, RMenu:Get('callmanager', 'admin'))

        RageUI.Button("~r~Deny", "~r~WARNING THIS WILL DENY THE TICKET FOR ALL ADMINS!", {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
            if (Selected) then
                CallManagerServer.RemoveTicket({ticketID, "admin"})
            end
        end, RMenu:Get('callmanager', 'admin'))
    end)
end)


RageUI.CreateWhile(1.0, RMenu:Get('callmanager', 'police'), nil, function()
    RageUI.IsVisible(RMenu:Get('callmanager', 'police'), true, false, true, function()  
        if #pdCalls == 0 then 
            RageUI.Separator("~b~There are no tickets right now.")
        end
        if pdCalls ~= nil then
            for k,v in pairs(pdCalls) do
                RageUI.Button(string.format("[ %s ] %s" .. "  :  " .. v[3], v[2], v[1]), "Press ~r~[ENTER] ~w~To accept  ~r~" .. v[1] .. "'s ~w~call!", {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        if v[2] == GetPlayerServerId(PlayerId()) then
                            notify("~r~You can't take your own call.")
                        else
                            CallManagerServer.RemoveTicket({k, "pd"})
                            CallManagerServer.GetUpdatedCoords({v[2]}, function(targetCoords)
                                SetNewWaypoint(targetCoords.x, targetCoords.y)
                            end)
                        end
                    end
                end, RMenu:Get('callmanager', 'police'))
            end
        end
    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get('callmanager', 'nhs'), nil, function()
    RageUI.IsVisible(RMenu:Get('callmanager', 'nhs'), true, false, true, function()  
        if #nhsCalls == 0 then 
            RageUI.Separator("~b~There are no tickets right now.")
        end
        if nhsCalls ~= nil then
            for k,v in pairs(nhsCalls) do
                RageUI.Button(string.format("[ %s ] %s" .. "  :  " .. v[3], v[2], v[1]), "Press ~r~[ENTER] ~w~To accept  ~r~" .. v[1] .. "'s ~w~call!", {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        if v[2] == GetPlayerServerId(PlayerId()) then
                            notify("~r~You can't take your own call.")
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

Citizen.CreateThread(function()

    while (true) do
        Citizen.Wait(0)
        if IsControlJustPressed(1, callmanager.Key) then
            CallManagerServer.GetPermissions({}, function(admin, pd, nhs)
                isPlayerAdmin = admin;
                isPlayerPD = pd;
                isPlayerNHS = nhs;
            end)
            CallManagerServer.GetTickets()
            RageUI.Visible(RMenu:Get('callmanager', 'main'), not RageUI.Visible(RMenu:Get('callmanager', 'main')))
        end

      
    end
end)

RegisterNetEvent('CallManager:Table')
AddEventHandler('CallManager:Table', function(call, call2, call3, name )
    adminCalls = call
    nhsCalls = call2
    pdCalls = call3
end)


RegisterCommand("return", function()
    if isInTicket then
        if savedCoords86856856 == nil then return notify("~r~Couldn't get your last position") end
        DoScreenFadeOut(1000)
        NetworkFadeOutEntity(PlayerPedId(), true, false)
        Wait(1000)
        SetEntityCoords(PlayerPedId(), savedCoords86856856)
        NetworkFadeInEntity(PlayerPedId(), 0)
        DoScreenFadeIn(1000)
        notify("~g~Returned to position.")
        TriggerEvent("FNR:vehicleMenu",false,false)
        isInTicket = false
        if permid ~= nil then
            TriggerServerEvent('FNR:AdminReturned', permid)
            permid = nil
        end
    end
end)

RegisterCommand("TestUserReturn", function(source, args , rawCommand)
    TriggerServerEvent("FNR:AdminReturned", 1)
end)

RegisterNetEvent("staffon")
AddEventHandler("staffon", function(isInTicket)

    TriggerEvent("FNR:vehicleMenu", true, isInTicket)
    if GetEntityHealth(GetPlayerPed(-1)) <= 103 then
    TriggerEvent('FNR:FixClient')
    end
end)

RegisterNetEvent("staffoff")
AddEventHandler("staffoff", function()
    isInTicket = false
    TriggerEvent("FNR:vehicleMenu", false, isInTicket) 
end)

RegisterNetEvent('FNR:AdminTicketCooldown')
AddEventHandler('FNR:AdminTicketCooldown', function(source, Reason)
    if AdminTicketCooldown == false then
        TriggerServerEvent('FNR:sendAdminTicket', source, Reason)
        AdminTicketCooldown = true
        Wait(60000*5)
        AdminTicketCooldown = false
    end
    if AdminTicketCooldown == true then
        notify("~r~You must wait 5 minutes between each ticket.") 
    end
end)

RegisterNetEvent('FNR:PDCallCooldown')
AddEventHandler('FNR:PDCallCooldown', function(source, Reason)
    if PDCallCooldown == false then
        TriggerServerEvent('FNR:sendPDCall', source, Reason)
        PDCallCooldown = true
        Wait(60000*2)
        PDCallCooldown = false
    end
    if PDCallCooldown == true then
        notify("~r~You must wait 2 minutes between each police call.") 
    end
end)

RegisterNetEvent('FNR:NHSCallCooldown')
AddEventHandler('FNR:NHSCallCooldown', function(source, Reason)
    if NHSCallCooldown == false then
        TriggerServerEvent('FNR:sendNHSCall', source, Reason)
        NHSCallCooldown = true
        Wait(60000*2)
        NHSCallCooldown = false
    end
    if NHSCallCooldown == true then
        notify("~r~You must wait 2 minutes between each NHS call.") 
    end
end)

function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end

RegisterNetEvent('FNR:PLAYTICKETRECIEVED')
AddEventHandler('FNR:PLAYTICKETRECIEVED', function(source)
    PlaySoundFrontend(-1, "Apt_Style_Purchase", "DLC_APT_Apartment_SoundSet", 0)
end)

RegisterNetEvent('FNR:sendPermID')
AddEventHandler('FNR:sendPermID', function(permid)
    permid = permid
    while isInTicket do
        inRedzone = false
        Wait(0)
        if permid ~= nil then
            drawNativeText("~y~You've taken the ticket of " ..name.. "("..permid..")", 255, 0, 0, 255, true)   
        else
            notify('~r~This person has logged off.')
            permid = nil
        end
    end
end)