local Tunnel = module('AQUA', 'lib/Tunnel')
local Proxy = module('AQUA', 'lib/Proxy')
AQUA = Proxy.getInterface("AQUA")

local usersInTruckJob = {}

RegisterNetEvent('AQUA:startTruckJob')
AddEventHandler('AQUA:startTruckJob', function()
    local source = source
    local user_id = AQUA.getUserId({source})
    if user_id ~= nil then
        if not usersInTruckJob[user_id] then
            usersInTruckJob[user_id] = true
        else
            AQUAclient.notify(source, {"~d~You're already in a job!"})
        end
    end
    print(usersInTruckJob)
end)

RegisterNetEvent('AQUA:finishTruckJob')
AddEventHandler('AQUA:finishTruckJob', function(jobname)
    local source = source
    local user_id = AQUA.getUserId({source})
    if user_id ~= nil then
        if usersInTruckJob[user_id] then
            usersInTruckJob[user_id] = false
            for k, v in pairs(truckjob.locations) do 
                if v.name == jobname then
                    AQUA.giveBankMoney({user_id, v.pay})
                end
            end
        else
            AQUAclient.notify(source, {"~d~You're not in a job!"})
        end
    end
    print(usersInTruckJob)
end)