RegisterServerEvent("TP:Bronze")
AddEventHandler("TP:Bronze",function()
       local user_id = vRP.getUserId({source})
       local coords = GetEntityCoords(GetPlayerPed(source))
       local comparison = vector3(-538.66851806641,-215.06903076172,37.649791717529)
       if #(coords - comparison) > 20 then 
       print(GetPlayerName(source).." is trying to cheat")
       return
       end
       
       vRPclient.teleport(source, {2560.4877929688,2599.3364257813,38.074668884277})

end)

RegisterServerEvent("Galaxy:BronzeCheck")
AddEventHandler("Galaxy:BronzeCheck",function()
       local user_id = vRP.getUserId({source})
      
              TriggerClientEvent('Galaxy:BronzeChecked', source, true)

end)


RegisterServerEvent("TP:Silver")
AddEventHandler("TP:Silver",function()
       local user_id = vRP.getUserId({source})
       local coords = GetEntityCoords(GetPlayerPed(source))
       local comparison = vector3(-538.66851806641,-215.06903076172,37.649791717529)
       if #(coords - comparison) > 20 then 
       print(GetPlayerName(source).." is trying to cheat")
       return
       end
       if vRP.hasPermission({user_id, "silver.guns"}) then
       vRPclient.teleport(source, {2043.6337890625,3195.986328125,45.186485290527})
       else
       TriggerClientEvent('showNotification', source,"~b~".. "~r~You don't have permission to do")
       end
end)

RegisterServerEvent("TP:Gold")
AddEventHandler("TP:Gold",function()
       local user_id = vRP.getUserId({source})
       local coords = GetEntityCoords(GetPlayerPed(source))
       local comparison = vector3(-538.66851806641,-215.06903076172,37.649791717529)
       if #(coords - comparison) > 20 then 
       print(GetPlayerName(source).." is trying to cheat")
       return
       end
       if vRP.hasPermission({user_id, "gold.guns"}) then
       vRPclient.teleport(source, {1964.3797607422,4637.6372070313,40.8427734375})
       else
       TriggerClientEvent('showNotification', source,"~b~".. "~r~You don't have permission to do")
       end
end)

RegisterServerEvent("TP:Diamond")
AddEventHandler("TP:Diamond",function()
       local user_id = vRP.getUserId({source})
       local coords = GetEntityCoords(GetPlayerPed(source))
       local comparison = vector3(-538.66851806641,-215.06903076172,37.649791717529)
       if #(coords - comparison) > 20 then 
       print(GetPlayerName(source).." is trying to cheat")
       return
       end
       if vRP.hasPermission({user_id, "diamond.guns"}) then
       vRPclient.teleport(source, {2365.6042480469,3132.0512695313,48.208915710449})
       else
       TriggerClientEvent('showNotification', source,"~b~".. "~r~You don't have permission to do")
       end
end)

RegisterServerEvent("TP:Galaxy")
AddEventHandler("TP:Galaxy",function()
       local user_id = vRP.getUserId({source})
       local coords = GetEntityCoords(GetPlayerPed(source))
       local comparison = vector3(1500.7286376953,6327.51171875,24.082513809204)
       if #(coords - comparison) > 20 then 
       print(GetPlayerName(source).." is trying to cheat")
       return
       end
       if vRP.hasPermission({user_id, "diamond.guns"}) then
       vRPclient.teleport(source, {2365.6042480469,3132.0512695313,48.208915710449})
       else
       TriggerClientEvent('showNotification', source,"~b~".. "~r~You don't have permission to do")
       end
end)


RegisterServerEvent("Galaxy:SilverCheck")
AddEventHandler("Galaxy:SilverCheck",function()
       local user_id = vRP.getUserId({source})
       if vRP.hasPermission({user_id, "silver.guns"}) then
              TriggerClientEvent('Galaxy:SilverChecked', source, true)
       else
              TriggerClientEvent('Galaxy:SilverChecked', source, false)
       end
end)

RegisterServerEvent("Galaxy:GoldCheck")
AddEventHandler("Galaxy:GoldCheck",function()
       local user_id = vRP.getUserId({source})
       if vRP.hasPermission({user_id, "gold.guns"}) then
              TriggerClientEvent('Galaxy:GoldChecked', source, true)
       else
              TriggerClientEvent('Galaxy:GoldChecked', source, false)
       end
end)

RegisterServerEvent("Galaxy:DiamondCheck")
AddEventHandler("Galaxy:DiamondCheck",function()
       local user_id = vRP.getUserId({source})
       if vRP.hasPermission({user_id, "diamond.guns"}) then
              TriggerClientEvent('Galaxy:DiamondChecked', source, true)
       else
              TriggerClientEvent('Galaxy:DiamondChecked', source, false)
       end
end)

RegisterServerEvent("Galaxy:GalaxyRPCheck")
AddEventHandler("Galaxy:GalaxyRPCheck",function()
       local user_id = vRP.getUserId({source})
       if vRP.hasPermission({user_id, "Galaxy.guns"}) then
              TriggerClientEvent('Galaxy:GalaxyRPChecked', source, true)
       else
              TriggerClientEvent('Galaxy:GalaxyRPChecked', source, false)
       end
end)
