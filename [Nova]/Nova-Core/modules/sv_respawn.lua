RegisterServerEvent("TP:Bronze")
AddEventHandler(
       "TP:Bronze",
       function()
              local user_id = vRP.getUserId({source})
              local coords = GetEntityCoords(GetPlayerPed(source))
              local comparison = vector3(-538.66851806641, -215.06903076172, 37.649791717529)
              if #(coords - comparison) > 20 then
                     print(GetPlayerName(source) .. " is trying to cheat")
                     return
              end

              vRPclient.teleport(source, {2560.4877929688, 2599.3364257813, 38.074668884277})
       end
)

RegisterServerEvent("Nova:BronzeCheck")
AddEventHandler(
       "Nova:BronzeCheck",
       function()
              local user_id = vRP.getUserId({source})

              TriggerClientEvent("Nova:BronzeChecked", source, true)
       end
)

RegisterServerEvent("TP:Silver")
AddEventHandler(
       "TP:Silver",
       function()
              local user_id = vRP.getUserId({source})
              local coords = GetEntityCoords(GetPlayerPed(source))
              local comparison = vector3(-538.66851806641, -215.06903076172, 37.649791717529)
              if #(coords - comparison) > 20 then
                     print(GetPlayerName(source) .. " is trying to cheat")
                     return
              end
              if vRP.hasPermission({user_id, "silver.guns"}) then
                     vRPclient.teleport(source, {2043.6337890625, 3195.986328125, 45.186485290527})
              else
                     TriggerClientEvent("showNotification", source, "~b~" .. "~r~You don't have permission to do")
              end
       end
)

RegisterServerEvent("TP:Gold")
AddEventHandler(
       "TP:Gold",
       function()
              local user_id = vRP.getUserId({source})
              local coords = GetEntityCoords(GetPlayerPed(source))
              local comparison = vector3(-538.66851806641, -215.06903076172, 37.649791717529)
              if #(coords - comparison) > 20 then
                     print(GetPlayerName(source) .. " is trying to cheat")
                     return
              end
              if vRP.hasPermission({user_id, "gold.guns"}) then
                     vRPclient.teleport(source, {1964.3797607422, 4637.6372070313, 40.8427734375})
              else
                     TriggerClientEvent("showNotification", source, "~b~" .. "~r~You don't have permission to do")
              end
       end
)

RegisterServerEvent("TP:Diamond")
AddEventHandler(
       "TP:Diamond",
       function()
              local user_id = vRP.getUserId({source})
              local coords = GetEntityCoords(GetPlayerPed(source))
              local comparison = vector3(-538.66851806641, -215.06903076172, 37.649791717529)
              if #(coords - comparison) > 20 then
                     print(GetPlayerName(source) .. " is trying to cheat")
                     return
              end
              if vRP.hasPermission({user_id, "diamond.guns"}) then
                     vRPclient.teleport(source, {2365.6042480469, 3132.0512695313, 48.208915710449})
              else
                     TriggerClientEvent("showNotification", source, "~b~" .. "~r~You don't have permission to do")
              end
       end
)

RegisterServerEvent("TP:Nova")
AddEventHandler("TP:Nova", function()
	local user_id = vRP.getUserId({source})
	local coords = GetEntityCoords(GetPlayerPed(source))
	local comparison = vector3(1500.7286376953, 6327.51171875, 24.082513809204)
	if #(coords - comparison) > 20 then
		print(GetPlayerName(source) .. " is trying to cheat")
		return
	end
	
	if vRP.hasPermission({user_id, "diamond.guns"}) then
		vRPclient.teleport(source, {2365.6042480469, 3132.0512695313, 48.208915710449})
	else
		TriggerClientEvent("showNotification", source, "~b~" .. "~r~You don't have permission to do")
	end
end)

RegisterServerEvent("Nova:SilverCheck")
AddEventHandler("Nova:SilverCheck", function()
	local user_id = vRP.getUserId({source})
	if vRP.hasPermission({user_id, "silver.guns"}) then
		TriggerClientEvent("Nova:SilverChecked", source, true)
	else
		TriggerClientEvent("Nova:SilverChecked", source, false)
	end
end)

RegisterServerEvent("Nova:GoldCheck")
AddEventHandler("Nova:GoldCheck", function()
	local user_id = vRP.getUserId({source})
	if vRP.hasPermission({user_id, "gold.guns"}) then
		TriggerClientEvent("Nova:GoldChecked", source, true)
	else
		TriggerClientEvent("Nova:GoldChecked", source, false)
	end
end)

RegisterServerEvent("Nova:DiamondCheck")
AddEventHandler("Nova:DiamondCheck", function()
	local user_id = vRP.getUserId({source})
	if vRP.hasPermission({user_id, "diamond.guns"}) then
		TriggerClientEvent("Nova:DiamondChecked", source, true)
	else
		TriggerClientEvent("Nova:DiamondChecked", source, false)
	end
end)

RegisterServerEvent("Nova:RoleplayCheck")
AddEventHandler("Nova:RoleplayCheckk", function()
	local user_id = vRP.getUserId({source})
	if vRP.hasPermission({user_id, "Nova.guns"}) then
		TriggerClientEvent("Nova:RoleplayChecked", source, true)
	else
		TriggerClientEvent("Nova:RoleplayChecked", source, false)
	end
end)