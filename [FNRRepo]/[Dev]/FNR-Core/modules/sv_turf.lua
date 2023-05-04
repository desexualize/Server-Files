local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "FNR")

local isPlayerInTurf = {}

local completedTurf = false

RegisterServerEvent('FNR:TooFar')
AddEventHandler('FNR:TooFar', function(isnTurf)

	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})

	if turfs[isnTurf] then
		local turf = turfs[isnTurf]
		if(isPlayerInTurf[source]) then
			TriggerClientEvent('FNR:OutOfZone', source)
			isPlayerInTurf[source] = nil

			TriggerClientEvent('chatMessage', -1, 'Turf Infomation │', {255, 255, 255}, "Turf capture failed at ^2" .. turf.nameofturf, "alert")
			TriggerClientEvent("turfTrue", -1, false)
			completedTurf = false
			TriggerClientEvent("doneIt", -1, false)
		end
	end

end)

RegisterServerEvent('FNR:PlayerDied')
AddEventHandler('FNR:PlayerDied', function(isnTurf)

	
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})

	if turfs[isnTurf] then
		local turf = turfs[isnTurf]
		if(isPlayerInTurf[source])then
			TriggerClientEvent('FNR:PlayerDied', source)
			isPlayerInTurf[source] = nil
			TriggerClientEvent('chatMessage', -1, 'Turf Infomation │', {255, 255, 255}, "Turf capture failed at ^2" .. turf.nameofturf, "alert")

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
				TriggerClientEvent('chatMessage', -1, 'Turf Infomation │', {255, 255, 255}, "^3" .. GetPlayerName(source) .. " ^0has changed Commision to ^2" .. com .. "% ^0at Large Arms", "alert")			  
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


RegisterServerEvent('FNR:rob')
AddEventHandler('FNR:rob', function(isnTurf)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})

	if vRP.hasPermission({user_id, 'pd.armory'}) then 
	  vRPclient.notify(player,{"~r~Police Officers can't cap turfs."})
	else

	  if turfs[isnTurf] then
		  local turf = turfs[isnTurf]

		if (os.time() - turf.lastisnTurfed) < 600 and turf.lastisnTurfed ~= 0 then
			vRPclient.notify(player,{"~r~This Turf has already been capped recently. Please wait another: ~w~" .. (600 - (os.time() - turf.lastisnTurfed)) .. " ~r~seconds."})

			return
		end

		
		TriggerClientEvent('chatMessage', -1, 'Turf Infomation │', {255, 255, 255}, "Turf capture started at ^2" .. turf.nameofturf, "alert")
			  completedTurf = false
			  TriggerClientEvent("turfTrue", -1, true)
			vRPclient.notify(player,{"~g~Defend the area for ~w~120 ~g~Seconds and the Turf is yours!"})
		  	TriggerClientEvent('FNR:TakenTurf', player, isnTurf)
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

			if turf.nameofturf == "Cocaine" then
				TriggerClientEvent("CocaineZone", -1)
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

						
			
						TriggerClientEvent('chatMessage', -1, 'Turf Infomation │', {255, 255, 255}, "Turf capture sucessful at ^2" .. turf.nameofturf .. "^0!", "alert")
						if turf.nameofturf == "Weed" then
						
					
							vRP.giveMoney({vRP.getUserId({savedSource}), 5000})
							vRPclient.notify(savedSource,{'~g~You have completed Turf. Here is £5,000!'})
							
							
						end

						if turf.nameofturf == "LSD" then
						
					
							vRP.giveMoney({vRP.getUserId({savedSource}), 20000})
							vRPclient.notify(savedSource,{'~g~You have completed Turf. Here is £20,000!'})
							
							
						end

						if turf.nameofturf == "Cocaine" then
						
					
							vRP.giveMoney({vRP.getUserId({savedSource}), 10000})
							vRPclient.notify(savedSource,{'~g~You have completed Turf. Here is £10,000!'})
							
							
						end

						if turf.nameofturf == "Heroin" then
						
					
							vRP.giveMoney({vRP.getUserId({savedSource}), 15000})
							vRPclient.notify(savedSource,{'~g~You have completed Turf. Here is £15,000!'})
							
							
						end
					 	TriggerClientEvent('FNR:TurfComplete', savedSource, turf.reward, turf.nameofturf)
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