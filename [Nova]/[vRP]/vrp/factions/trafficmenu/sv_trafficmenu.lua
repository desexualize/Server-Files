local Current_Zone_ID = 0
local Active_Speed_Zones = {}

local Webhooks = {
    ['LFB'] = 'https://discord.com/api/webhooks/1020062554380304465/LejXT0evUwowyAlzVIJcQl18hP2UzkQoHf6d3V4OfPGXDuIne2gWOqkL7js2hvqS6tKH',
    ['NHS'] = 'https://discord.com/api/webhooks/1020062798140686356/AOMdSAz84O6DeHBvumQ7ztGTjUEth2YyW0joO8sr11K6NbhZiEbPPCj8HrgjE_GX0fDL',
    ['HMP'] = 'https://discord.com/api/webhooks/1020062696768540722/YVf62SYcyvnnXWD277l78ienrHavZ9Pg38uf4D0b4nO0w1FNiQADTpUrrJEaLTf5zqPL',
    ['MPD'] = 'https://discord.com/api/webhooks/1020062901739995206/lpEmvjG2VHC-KvSoYV2C2oxniqjWtKwOi8vi5VNQGai0Bo1s4kerW8f4b78VNXPvKTNl',
}

RegisterNetEvent('Nova:Server:GetActiveSpeedZones')
AddEventHandler('Nova:Server:GetActiveSpeedZones', function()
    local source = source
    if Current_Zone_ID > 0 then
        TriggerClientEvent('Nova:Client:GetActiveSpeedZones', source, Active_Speed_Zones)
    end
end)

RegisterServerEvent("Nova:Server:AddSpeedZone")
AddEventHandler("Nova:Server:AddSpeedZone", function(x, y, z, radius, speed, message, faction_name, street_name)
    Current_Zone_ID = Current_Zone_ID + 1
    Active_Speed_Zones[Current_Zone_ID] = {
        zone_x = x, zone_y = y, zone_z = z,
        zone_radius = radius, zone_speed = speed
    }

    TriggerClientEvent("Nova:Client:AddSpeedZone", -1, Current_Zone_ID, x, y, z, radius, speed)
    TriggerClientEvent("chatMessage", -1, '[Traffic Announcement]:', {255, 255, 255}, message, 'alert')

    local source = source
    local user_id = vRP.getUserId(source)
    local user_name = GetPlayerName(source)
    local user_discord_id = exports['Discord-Groups']:Get_Client_Discord_ID(source)
    
    local embed_discord
    if user_discord_id then
        embed_discord = ('<@%s>'):format(user_discord_id)
    else
        embed_discord = 'Not Available'
    end
    
    local speed_embed = {
        ['title'] = 'Nova Zone Logs',
        ['color'] = exports['vrp']:Get_Faction_Embed_Colour(faction_name),
        ['fields'] = {
            {
                ['name'] = 'User ID',
                ['value'] = user_id,
                ['inline'] = false
            },
            {
                ['name'] = 'User Name',
                ['value'] = user_name,
                ['inline'] = false
            },
            {
                ['name'] = 'Discord',
                ['value'] = embed_discord,
                ['inline'] = false
            },
            {
                ['name'] = 'Zone Speed',
                ['value'] = ('%s MPH'):format(speed),
                ['inline'] = false
            },
            {
                ['name'] = 'Zone Radius',
                ['value'] = ('%s Metres'):format(radius),
                ['inline'] = false
            },
            {
                ['name'] = 'Street Name',
                ['value'] = street_name,
                ['inline'] = false
            },
            {
                ['name'] = 'Coordinates',
                ['value'] = ('X: %s\nY: %s\nZ: %s'):format(x, y, z),
                ['inline'] = false
            },
        },
        ['footer'] = {
            ['text'] = os.date('%d/%m/%Y - %H:%M:%S')
        }
    }

    local speed_webhook = Webhooks[faction_name]
    PerformHttpRequest(speed_webhook, function(err, text, headers)
    end, "POST", json.encode({embeds = {speed_embed}}), {["Content-Type"] = "application/json"})
end)

RegisterServerEvent("Nova:Server:RemoveSpeedZone")
AddEventHandler("Nova:Server:RemoveSpeedZone", function(zone_id)
    Active_Speed_Zones[zone_id] = nil
    TriggerClientEvent("Nova:Client:RemoveSpeedZone", -1, zone_id)
end)