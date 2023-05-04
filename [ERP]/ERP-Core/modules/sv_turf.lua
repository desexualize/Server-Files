local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "ERPTurf")

local isPlayerInTurf = {}

local completedTurf = false

RegisterServerEvent('ERPTurf:TooFar')
AddEventHandler('ERPTurf:TooFar', function(isnTurf)

	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})

	if turfs[isnTurf] then
		local turf = turfs[isnTurf]
		if(isPlayerInTurf[source]) then
			TriggerClientEvent('ERPTurf:OutOfZone', source)
			isPlayerInTurf[source] = nil

			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> Turfs^7: ' .. "Turf capture sucessful at ^2" .."Turf capture failed at ^3" .. turf.nameofturf .. '</div>',
				args = { playerName, msg }
			  })
			TriggerClientEvent("turfTrue", -1, false)
			completedTurf = false
			TriggerClientEvent("doneIt", -1, false)
		end
	end

end)

RegisterServerEvent('ERPTurf:PlayerDied')
AddEventHandler('ERPTurf:PlayerDied', function(isnTurf)

	
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})

	if turfs[isnTurf] then
		local turf = turfs[isnTurf]
		if(isPlayerInTurf[source])then
			TriggerClientEvent('ERPTurf:PlayerDied', source)
			isPlayerInTurf[source] = nil
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> Turfs^7: ' .. "Turf capture sucessful at ^2" .."Turf capture failed at ^3" .. turf.nameofturf .. '</div>',
				args = { playerName, msg }
			  })

			TriggerClientEvent("turfTrue", -1, false)
			TriggerClientEvent("doneIt", -1, false)
			completedTurf = false
		end
	end
end)

RegisterNetEvent("changeCom")
AddEventHandler("changeCom", function(com)
	if completedTurf == true then
		if com <= 35 then
			if com >= 0 then
				TriggerClientEvent('chat:addMessage', -1, {
					template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> Turfs^7: ' .. "^3" .. GetPlayerName(source) .. " ^0has changed Commision to ^3" .. com .. "% ^0at Large Arms" .. '</div>',
					args = { playerName, msg }
				  })
			  
				vRPclient.notify(source,{"~g~You changed commision to ~w~" .. com .. "%~g~."})
				sendCom(com, source)
			end
		else
			vRPclient.notify(source,{"~r~You cannot go higher than 35%."})
		end
	else
		vRPclient.notify(source,{"~r~No!"})
	end
end)


RegisterServerEvent('ERPTurf:rob')
AddEventHandler('ERPTurf:rob', function(isnTurf)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})

	if vRP.hasGroup({user_id,"cop"}) then
	  vRPclient.notify(player,{"~r~Cops can't cap turfs."})
	else

	  if turfs[isnTurf] then
		  local turf = turfs[isnTurf]

		if (os.time() - turf.lastisnTurfed) < 150 and turf.lastisnTurfed ~= 0 then
			vRPclient.notify(player,{"~r~This Turf has already been capped recently. Please wait another: ~w~" .. (150 - (os.time() - turf.lastisnTurfed)) .. " ~r~seconds."})

			return
		end

		
			  TriggerClientEvent('chat:addMessage', -1, {
				template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> Turfs^7: ' .. "Turf capture started at ^3" .. turf.nameofturf .. " ^0by ^3 '" .. GetPlayerName(player) .. "'" .. '</div>',
				args = { playerName, msg }
			  })
			  completedTurf = false
			  TriggerClientEvent("turfTrue", -1, true)
			vRPclient.notify(player,{"~g~Defend the area for ~w~120 ~g~Seconds and the Turf is yours!"})
		  	TriggerClientEvent('ERPTurf:TakenTurf', player, isnTurf)
			  TriggerClientEvent("doneIt", -1, false)

				
			if turf.nameofturf == "Heroin" then
				TriggerClientEvent("HeroinZone", -1)
			end

			if turf.nameofturf == "LSD" then
				TriggerClientEvent("LSDZone", -1)
			end

			if turf.nameofturf == "Large Arms" then
				TriggerClientEvent("LargeArmsZone", -1)
			end

			if turf.nameofturf == "Weed" then
				TriggerClientEvent("WeedZone", -1)
			end
			  
		  	turfs[isnTurf].lastisnTurfed = os.time()
			  
		  	isPlayerInTurf[player] = isnTurf
		  	local savedSource = player
			
		  	SetTimeout(120 * 1000, function()
			  	if(isPlayerInTurf[savedSource]) then
					
				  	if(user_id) then

						
			
						  TriggerClientEvent('chat:addMessage', -1, {
							template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> Turfs^7: ' .. "Turf capture sucessful at ^2" .. turf.nameofturf .. "^0!" .. "'" .. '</div>',
							args = { playerName, msg }
						  })
						if turf.nameofturf == "Weed" then
						
					
							vRP.giveMoney({vRP.getUserId({savedSource}), 50000})
							vRPclient.notify(savedSource,{'~g~You have completed Turf. Here is £50,000!'})
							
						end
					 	TriggerClientEvent('ERPTurf:TurfComplete', savedSource, turf.reward, turf.nameofturf)
						 TriggerClientEvent("turfTrue", -1, false)
						 completedTurf = true
				  	end

			  	end
		  	end)		
	  	end
	end
end)

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end