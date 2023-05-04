local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
local cfg = module("FNR-Core", "cfg/cfg_locks")

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
		TriggerClientEvent('vrp:load', source, cfglocks.list)
	end
end)

Citizen.CreateThread(function()
  Citizen.Wait(1000)
  TriggerClientEvent('vrp:load', -1, cfglocks.list)
end)

RegisterServerEvent('vrp:open')
AddEventHandler('vrp:open', function(id)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if vRP.hasPermission({user_id, "#"..cfglocks.list[id].key..".>0"}) or vRP.hasPermission({user_id,cfglocks.list[id].permission}) then
		SetTimeout(100, function()
			cfglocks.list[id].locked = not cfglocks.list[id].locked
			TriggerClientEvent('vrp:statusSend', (-1), id,cfglocks.list[id].locked)
			if cfglocks.list[id].pair ~= nil then
				local idsecond = cfglocks.list[id].pair
				cfglocks.list[idsecond].locked = cfglocks.list[id].locked
				TriggerClientEvent('vrp:statusSend', (-1), idsecond,cfglocks.list[id].locked)
			end
			if cfglocks.list[id].locked then
				vRPclient.notify(player, {"~w~You ~r~closed ~w~the door."})
            elseif not cfglocks.list[id].locked then
				vRPclient.notify(player, {"~w~You ~g~opened ~w~the door."})
			end
		end)
	else
		if cfglocks.list[id].keyname ~= nil then
			vRPclient.notify(player, {"~r~You are not clocked on!"})
		else
			vRPclient.notify(player, {"~r~You are not police!"})
		end
	end
end)