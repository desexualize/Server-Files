local Tunnel = module("AQUA", "lib/Tunnel")
local Proxy = module("AQUA", "lib/Proxy")

AQUA = Proxy.getInterface("AQUA")
AQUAclient = Tunnel.getInterface("AQUA","AQUA")

RegisterNetEvent("TFC:saveFaceData")
AddEventHandler("TFC:saveFaceData", function(faceSaveData)
    local source = source
    local user_id = AQUA.getUserId({source})
    AQUA.setUData({user_id, "AQUA:Face:Data", json.encode(faceSaveData)})
    --AQUAclient.notify(source, {"~g~Your hairstyle has been saved."})

end)

RegisterNetEvent("TFC:changeHairStyle") --COULD BE USED FOR STAFFMODE AND STUFF XOTIIC IF U ARE WONDERING, JUST TRIGGER IT AND ITLL SET THE HARISTYLE, NO PARAMS
AddEventHandler("TFC:changeHairStyle", function()
    local source = source
    local user_id = AQUA.getUserId({source})

    AQUA.getUData({user_id, "AQUA:Face:Data", function(data)
        if data ~= nil then
            TriggerClientEvent("TFC:setHairstyle", source, json.decode(data))
        end
    end})
end)

AddEventHandler("AQUA:playerSpawn", function(user_id, source, first_spawn)
    SetTimeout(1000, function() 
        local source = source
        local user_id = AQUA.getUserId({source})
        AQUA.getUData({user_id, "AQUA:Face:Data", function(data)
            if data ~= nil then
                TriggerClientEvent("TFC:setHairstyle", source, json.decode(data))
            end
        end})
    end)
end)