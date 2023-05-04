local function Get_Clocked_Faction()
    if tvRP.IsLFB() then
        return 'LFB'
    elseif tvRP.IsNHS() then
        return 'NHS'
    elseif tvRP.IsHMP() then
        return 'HMP'
    elseif tvRP.IsMPD() then
        return 'MPD'
    else
        return false
    end
end

local Callsigns = {
    ['LFB'] = {
        ['colour'] = {r = 221, g = 29, b = 29},
        ['callsign'] = nil,
    },

    ['NHS'] = {
        ['colour'] = {r = 31, g = 139, b = 76},
        ['callsign'] = nil,
    },

    ['HMP'] = {
        ['colour'] = {r = 103, g = 0, b = 255},
        ['callsign'] = nil,
    },

    ['MPD'] = {
        ['colour'] = {r = 30, g = 144, b = 255},
        ['callsign'] = nil,
    },
}

local Safe_Zone_Size = GetSafeZoneSize()
local function Draw_Screen_Text(r, g, b, client_callsign)
    SetTextFont(0)
    SetTextJustification(2)
    SetTextWrap(0.85, Safe_Zone_Size)
    SetTextScale(1.0, 0.4)
    SetTextColour(r, g, b, 255)
	SetTextOutline()
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(client_callsign)
    EndTextCommandDisplayText(0.92, 0.955)
end

local Started_Drawing_Callsigns = false
local Drawing_Callsigns = false

local function Start_Drawing_Callsigns()
    if Started_Drawing_Callsigns or Drawing_Callsigns then
        return
    end

    if Get_Clocked_Faction() then
        Started_Drawing_Callsigns = true
        Drawing_Callsigns = true

        Citizen.CreateThread(function()
            while Drawing_Callsigns do
                local clocked_faction = Get_Clocked_Faction()
                if clocked_faction then
                    local table_info = Callsigns[clocked_faction]
                    local callsign = table_info.callsign
                    if callsign then
                        local faction_colour = table_info.colour
                        local r = faction_colour.r
                        local g = faction_colour.g
                        local b = faction_colour.b

                        Draw_Screen_Text(r, g, b, callsign)
                    end
                else
                    break
                end

                Citizen.Wait(0)
            end
            Started_Drawing_Callsigns = false
            Drawing_Callsigns = false
        end)
    end
end

local request_cooldown = 15 * 60 
local cooldown_left = 0
RegisterCommand('callsign', function()
    if Started_Drawing_Callsigns then
        if cooldown_left > 0 then
            tvRP.notify(('~r~You must wait %s minutes before syncing callsigns'):format(('%0.2f'):format(cooldown_left / 60)))
        else
            TriggerServerEvent('Factions:Server:RequestCallsigns', true)
        end
    else
        tvRP.notify('~r~Callsigns are being synced please try again later')
    end
end)
TriggerEvent('chat:addSuggestion', '/callsign', 'Request a callsign sync to update your factional callsigns')

RegisterNetEvent('Factions:Client:ReceiveCallsigns')
AddEventHandler('Factions:Client:ReceiveCallsigns', function(received_callsigns, bool_value)
    for faction_name, nick_name in pairs(received_callsigns) do
        Callsigns[faction_name]['callsign'] = nick_name
    end

    if bool_value then
        tvRP.notify('~g~Callsigns Synced')
    end

    cooldown_left = request_cooldown
    if not Started_Drawing_Callsigns and not Drawing_Callsigns then
        Start_Drawing_Callsigns()
    end
end)

AddEventHandler('onResourceStart', function(resource_name)
    if resource_name == 'vrp' then
        if not Started_Drawing_Callsigns or not Drawing_Callsigns then
            Start_Drawing_Callsigns()
        end
    end
end)

AddEventHandler('onResourceStop', function(resource_name)
    if resource_name == 'vrp' then
        if Started_Drawing_Callsigns or Drawing_Callsigns then
            Started_Drawing_Callsigns = false
            Drawing_Callsigns = false
        end
    end
end)

RegisterNetEvent('Nova:Factions:Client:Clocked')
AddEventHandler('Nova:Factions:Client:Clocked', function()
    if Get_Clocked_Faction() then
        Start_Drawing_Callsigns()
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(2000)
    TriggerServerEvent('Factions:Server:RequestCallsigns')

    while true do
        Citizen.Wait(1000)
        if cooldown_left > 0 then
            cooldown_left = cooldown_left - 1
        end
        Safe_Zone_Size = GetSafeZoneSize()
    end
end)