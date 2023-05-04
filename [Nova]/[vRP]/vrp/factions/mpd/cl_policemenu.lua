RMenu.Add("NovaPoliceMenu", "main", RageUI.CreateMenu(nil, "~b~MET Police Menu", 1250, 100, 'policemenu', 'policemenu'))

local radius
local speed
local cuffed = false

RegisterCommand("pd", function()
    if not IsPedInAnyVehicle(PlayerPedId(), false) then
        TriggerServerEvent("Nova:OpenPoliceMenu")
    end
end)

RegisterNetEvent("Nova:PoliceMenuOpened")
AddEventHandler("Nova:PoliceMenuOpened", function()
    RageUI.Visible(RMenu:Get("NovaPoliceMenu", "main"), not RageUI.Visible(RMenu:Get("NovaPoliceMenu", "main")))
end)

other = nil
drag = false
playerStillDragged = false

RegisterNetEvent("Nova:DragPlayer")
AddEventHandler(
    "Nova:DragPlayer",
    function(pl)
        other = pl
        drag = not drag
    end
)

Citizen.CreateThread(
    function()
        while true do
            if drag and other ~= nil then
                local ped = GetPlayerPed(GetPlayerFromServerId(other))
                local myped = PlayerPedId()
                AttachEntityToEntity(
                    myped,
                    ped,
                    4103,
                    11816,
                    0.54,
                    0.04,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    false,
                    false,
                    false,
                    false,
                    2,
                    true
                )
                playerStillDragged = true
            else
                if (playerStillDragged) then
                    DetachEntity(PlayerPedId(), true, false)
                    playerStillDragged = false
                end
            end
            Citizen.Wait(0)
        end
    end
)

local frozen = false
local unfrozen = false
function tvRP.loadFreeze(notify, god, ghost)
    if not frozen then
        if notify then
            vRP.notify({"~r~You've been frozen."})
        end
        frozen = true
        invincible = god
        invisible = ghost
        unfrozen = false
    else
        if notify then
            vRP.notify({"~g~You've been unfrozen."})
        end
        unfrozen = true
        invincible = false
        invisible = false
    end
end

RegisterKeyMapping("pd", "Opens the PD menu", "keyboard", "U")

local isInJail = false
v5 = vector3(1779.7868652344, 2583.9130859375, 45.797805786133)
RegisterNetEvent("stopjail")
AddEventHandler(
    "stopjail",
    function(source)
        while true do
            if isInJail == true then
                if isInArea(v5, 20.4) then
                else
                    SetEntityCoords(PlayerPedId(), 1779.7868652344, 2583.9130859375, 45.797805786133)
                    vRP.notify({"~r~You have be teleported back to prison!"})
                end
            end
            Citizen.Wait(0)
        end
    end
)

RegisterNetEvent("returnTrue")
AddEventHandler(
    "returnTrue",
    function(source)
        isInJail = true
    end
)

RegisterNetEvent("returnFalse")
AddEventHandler(
    "returnFalse",
    function(source)
        isInJail = false
    end
)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get("NovaPoliceMenu", "main")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = true}, function()
            if not IsPedInAnyVehicle(PlayerPedId(), false) then
                RageUI.Button("Cuff Nearest Player", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("Nova:Handcuff")
                    end
                end)

                RageUI.Button("Drag Nearest Player", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("Nova:Drag")
                    end
                end)

                RageUI.Button("Search Nearest Player", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("Nova:SearchPlayer")
                    end
                end)

                RageUI.Button("Seize Items", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("Nova:SearchPlayer")
                    end
                end)

                RageUI.Button("Put Player in Vehicle", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("Nova:PutPlrInVeh")
                    end
                end)

                RageUI.Button("Remove Player From Vehicle", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("Nova:TakeOutOfVehicle")
                    end
                end)

                RageUI.Button("Fine Player", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("Nova:Fine")
                    end
                end)
                
                RageUI.Button("Jail Player", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("Nova:JailPlayer")
                    end
                end)

                RageUI.Button("Unjail Player", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("Nova:UnJailPlayer")
                    end
                end)
            end
        end)
    end
end)