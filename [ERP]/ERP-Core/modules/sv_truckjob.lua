local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")

local usersInTruckJob = {}

RegisterNetEvent('ERP:startTruckJob')
AddEventHandler('ERP:startTruckJob', function()
    local source = source
    local user_id = vRP.getUserId({source})
    if user_id ~= nil then
        if not usersInTruckJob[user_id] then
            usersInTruckJob[user_id] = true
        else
            vRPclient.notify(source, {"~r~You're already in a job!"})
        end
    end
    print(usersInTruckJob)
end)

RegisterNetEvent('ERP:finishTruckJob')
AddEventHandler('ERP:finishTruckJob', function(jobname)
    local source = source
    local user_id = vRP.getUserId({source})
    if user_id ~= nil then
        if usersInTruckJob[user_id] then
            usersInTruckJob[user_id] = false
            for k, v in pairs(truckjob.locations) do 
                if v.name == jobname then
                    vRP.giveBankMoney({user_id, v.pay})
                end
            end
        else
            vRPclient.notify(source, {"~r~You're not in a job!"})
        end
    end
    print(usersInTruckJob)
end)