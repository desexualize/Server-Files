local Proxy = module("AQUA", "lib/Proxy")
AQUA = Proxy.getInterface("AQUA")
local cfg = module("AQUAModules", "cfg/cfg_locks")

AddEventHandler("AQUA:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
		TriggerClientEvent('AQUA:load', source, cfglocks.list)
	end
end)

Citizen.CreateThread(function()
  Citizen.Wait(1000)
  TriggerClientEvent('AQUA:load', -1, cfglocks.list)
end)

RegisterServerEvent('AQUA:open')
AddEventHandler('AQUA:open', function(id)
	local user_id = AQUA.getUserId({source})
	local player = AQUA.getUserSource({user_id})
	if AQUA.hasPermission({user_id, "#"..cfglocks.list[id].key..".>0"}) or AQUA.hasPermission({user_id,cfglocks.list[id].permission}) then
		SetTimeout(100, function()
			cfglocks.list[id].locked = not cfglocks.list[id].locked
			TriggerClientEvent('AQUA:statusSend', (-1), id,cfglocks.list[id].locked)
			if cfglocks.list[id].pair ~= nil then
				local idsecond = cfglocks.list[id].pair
				cfglocks.list[idsecond].locked = cfglocks.list[id].locked
				TriggerClientEvent('AQUA:statusSend', (-1), idsecond,cfglocks.list[id].locked)
			end
			if cfglocks.list[id].locked then
				AQUAclient.notify(player, {"~w~You ~d~closed ~w~the door."})
            elseif not cfglocks.list[id].locked then
				AQUAclient.notify(player, {"~w~You ~g~opened ~w~the door."})
			end
		end)
	else
		if cfglocks.list[id].keyname ~= nil then
			AQUAclient.notify(player, {"~d~You are not clocked on!"})
		else
			AQUAclient.notify(player, {"~d~You are not police!"})
		end
	end
end)