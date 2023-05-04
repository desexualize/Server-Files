local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "MPay")

RegisterServerEvent("ERP:SendPayment")
AddEventHandler('ERP:SendPayment', function(playerid, price)
    local source = source
    userid = vRP.getUserId({source})
    reciever = vRP.getUserSource({tonumber(playerid)})
    recieverid = vRP.getUserId({reciever})
    totalprice = price * 2
    
    if recieverid == nil then
        vRPclient.notify(source, {"~r~This ID does not exist/ is offline!"})
        TriggerClientEvent("ERP:PlaySound", source, 2)
    else

        if userid == recieverid then 
            vRPclient.notify(source, {"~r~Unable to send money to yourself!"})
            TriggerClientEvent("ERP:PlaySound", source, 2)
        else
    
            if vRP.tryBankPayment({userid, tonumber(price)}) then 

                vRPclient.notify(source, {"~g~Successfully transfered: ~w~£" .. totalprice .. " ~g~to ~w~" .. vRP.getPlayerName({reciever}) .. " ~r~ ~n~ ~n~[ID: ~w~" .. playerid .. " ~r~]"})
                TriggerClientEvent("ERP:PlaySound", source, 1)
                vRP.giveBankMoney({tonumber(playerid), tonumber(price)})

                vRPclient.notify(reciever, {"~g~You have recieved: ~w~£" .. totalprice .. "~g~ from ~w~".. vRP.getPlayerName({source}) .. " ~r~ ~n~ ~n~[ID: ~w~" .. userid .. " ~r~]"})
                TriggerClientEvent("ERP:PlaySound", reciever, 1)

                else 
                vRPclient.notify(source, {"~r~You do not have enough money complete transaction!"})
                TriggerClientEvent("ERP:PlaySound", source, 2)
            end
        end
    end
end)

