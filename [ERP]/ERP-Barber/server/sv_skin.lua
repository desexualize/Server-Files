local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")

RegisterNetEvent("ERP:saveFaceData")
AddEventHandler("ERP:saveFaceData", function(faceSaveData)
    local source = source
    local user_id = vRP.getUserId({source})
    vRP.setUData({user_id, "vRP:Face:Data", json.encode(faceSaveData)})
end)

RegisterNetEvent("ERP:changeHairStyle") --COULD BE USED FOR STAFFMODE 
AddEventHandler("ERP:changeHairStyle", function()
    local source = source
    local user_id = vRP.getUserId({source})

    vRP.getUData({user_id, "vRP:Face:Data", function(data)
        if data ~= nil then
            TriggerClientEvent("ERP:setHairstyle", source, json.decode(data))
        end
    end})
end)

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    SetTimeout(1000, function() 
        local source = source
        local user_id = vRP.getUserId({source})
        vRP.getUData({user_id, "vRP:Face:Data", function(data)
            if data ~= nil then
                TriggerClientEvent("ERP:setHairstyle", source, json.decode(data))
            end
        end})
    end)
end)