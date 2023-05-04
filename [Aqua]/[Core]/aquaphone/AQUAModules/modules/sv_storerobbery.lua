local Tunnel = module("AQUA", "lib/Tunnel")
local Proxy = module("AQUA", "lib/Proxy")

AQUA = Proxy.getInterface("AQUA")
AQUAclient = Tunnel.getInterface("AQUA","AQUA_bank")

local banks = {
	["Lindsay Circus"] = {
		position = { ['x'] = -705.94110107422, ['y'] = -915.48120117188, ['z'] = 18.215589523315 },	
		nameofbank = "Lindsay Circus LTD Gas Station",
		lastrobbed = 0
	},
	["Prosperity St"] = {
		position = { ['x'] = -1487.1322021484, ['y'] = -375.54638671875, ['z'] = 39.163433074951 },		
		nameofbank = "Prosperity St Robs Liquor",
		lastrobbed = 0
	},
	["Barbareno Road Great Ocean"] = {
		position = { ['x'] = -3241.7280273438, ['y'] = 999.95611572266, ['z'] = 11.830716133118 },		
		nameofbank = "Barbareno Road(Great Ocean) 24/7 Supermarket",
		lastrobbed = 0
	},
	["North Rockford Dr"] = {
		position = { ['x'] = -1828.9028320313, ['y'] = 798.63702392578, ['z'] = 137.18780517578 },		
		nameofbank = "North Rockford Dr LTD Gas Station",
		lastrobbed = 0
	},
	["Great Ocean Hway East"] = {
		position = { ['x'] = 1727.6282958984, ['y'] = 6414.7607421875, ['z'] = 34.037220001221 },		
		nameofbank = "Great Ocean Hway East 24/7 Supermarket",
		lastrobbed = 0
	},
	["Alhambra Dr Sandy"] = {
		position = { ['x'] = 1960.3529052734, ['y'] = 3739.4997558594, ['z'] = 31.343742370605 },		
		nameofbank = "Alhambra Dr Sandy 24/7 Supermarket",
		lastrobbed = 0
	},
	["Palomino Fwy Reststop"] = {
		position = { ['x'] = 2549.2858886719, ['y'] = 384.96740722656, ['z'] = 107.62294769287 },		
		nameofbank = "Palomino Fwy Reststop 24/7 Supermarket",
		lastrobbed = 0
	},
	["Clinton Ave"] = {
		position = { ['x'] = 372.36227416992, ['y'] = 325.90933227539, ['z'] = 102.56638336182 },		
		nameofbank = "Clinton Ave 24/7 Supermarket",
		lastrobbed = 0
	},
	["Grove St/Davis St"] = {
		position = { ['x'] = -47.860702514648, ['y'] = -1759.3477783203, ['z'] = 28.421016693115 },	
		nameofbank = "Grove St/Davis St LTD Gas Station",
		lastrobbed = 0
	},
	["Innocence Blvd"] = {
		position = { ['x'] = 24.360492706299, ['y'] = -1347.8098144531, ['z'] = 28.497026443481 },		
		nameofbank = "Innocence Blvd 24/7 Supermarket",
		lastrobbed = 0
	},
	["San Andreas Ave"] = {
		position = { ['x'] = -1220.7747802734, ['y'] = -915.93646240234, ['z'] = 10.326335906982 },	
		nameofbank = "San Andreas Ave Robs Liquor",
		lastrobbed = 0
	},
	["Route 68 Outside Sandy"] = {
		position = { ['x'] = 1169.2320556641, ['y'] = 2717.8083496094, ['z'] = 36.157665252686 },		
		nameofbank = "Route 68 Outside Sandy 24/7 Supermarket",
		lastrobbed = 0
	},
	["Great Ocean Hway"] = {
		position = { ['x'] = -2959.6359863281, ['y'] = 387.15356445313, ['z'] = 13.043292999268 },		
		nameofbank = "Great Ocean Hway Robs Liquor",
		lastrobbed = 0
	},
	["Inseno Rd Great Ocean"] = {
		position = { ['x'] = -3038.9475097656, ['y'] = 584.53924560547, ['z'] = 6.9089307785034 },		
		nameofbank = "Inseno Rd Great Ocean 24/7 Supermarket",
		lastrobbed = 0
	},	
	["Grapeseed Main St"] = {
		position = { ['x'] = 1707.8717041016, ['y'] = 4920.2475585938, ['z'] = 41.063678741455 },		
		nameofbank = "Grapeseed Main St 24/7 Supermarket",
		lastrobbed = 0
	},	
	["Algonquin Blvd"] = {
		position = { ['x'] = 1392.9791259766, ['y'] = 3606.5573730469, ['z'] = 33.980918884277 },		
		nameofbank = "Algonquin Blvd Ace Liquors",
		lastrobbed = 0
	},	
	["Panorama Dr"] = {
		position = { ['x'] = 1982.5057373047, ['y'] = 3053.4697265625, ['z'] = 46.215065002441 },		
		nameofbank = "Panorama Dr Yellow Jack Inn",
		lastrobbed = 0
	},	
	["Senora Fwy Sandy"] = {
		position = { ['x'] = 2678.1394042969, ['y'] = 3279.3344726563, ['z'] = 54.241130828857 },		
		nameofbank = "Senora Fwy Sandy 24/7 Supermarket",
		lastrobbed = 0
	},
	["Mirror Park Blvd"] = {
		position = { ['x'] = 1159.5697021484, ['y'] = -314.11761474609, ['z'] = 68.205139160156 },		
		nameofbank = "Mirror Park Blvd LTD Gas Station",
		lastrobbed = 0
	},	
	["El Rancho Blvd"] = {
		position = { ['x'] = 1134.2387695313, ['y'] = -982.76049804688, ['z'] = 45.415843963623 },		
		nameofbank = "El Rancho Blvd Robs Liquor",
		lastrobbed = 0
	}	
}

local robbers = {}
reward = 0

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent('es_bank:toofar')
AddEventHandler('es_bank:toofar', function(robb)
	if(robbers[source])then
		TriggerClientEvent('es_bank:toofarlocal', source)
		robbers[source] = nil
        TriggerClientEvent('chatMessage', -1, 'Store Robbery │', {255, 255, 255}, "Robbery was cancelled at: ^5" .. banks[robb].nameofbank, "ooc")
	end
end)

RegisterServerEvent('es_bank:playerdied')
AddEventHandler('es_bank:playerdied', function(robb)
	if(robbers[source])then
		TriggerClientEvent('es_bank:playerdiedlocal', source)
		robbers[source] = nil
		TriggerClientEvent('chatMessage', -1, 'Store Robbery │', {255, 255, 255}, "Robbery was cancelled at: ^5" .. banks[robb].nameofbank, "ooc")
	end
end)

RegisterServerEvent('es_bank:rob')
AddEventHandler('es_bank:rob', function(robb)
	local user_id = AQUA.getUserId({source})
	local player = AQUA.getUserSource({user_id})
	local cops = AQUA.getUsersByPermission({"police.armoury"})
	if AQUA.hasPermission({user_id,"police.armoury"}) then
		AQUAclient.notify(player,{"~d~Police Officers can't rob stores."})
	else
		if #cops > 2 then
			if banks[robb] then
				local bank = banks[robb]

				if (os.time() - bank.lastrobbed) < 600 and bank.lastrobbed ~= 0 then
					TriggerClientEvent('chatMessage', player, 'Store Robbery │ ', {255, 255, 255}, "This store has already been robbed. You'll have to wait another: ^2" .. (1200 - (os.time() - bank.lastrobbed)) .. "^0 seconds.", "ooc")
					return
				end
				TriggerClientEvent('chatMessage', -1, 'Store Robbery │ ', {255, 255, 255}, "Robbery in progress at ^5" .. bank.nameofbank, "ooc")

				local source = source
				local index = #pdCalls + 1
				pdCalls[index] = {GetPlayerName(source), source, "~d~[Store Robbery]"}
				TriggerClientEvent('CallManager:Table', -1, adminTickets, nhsCalls, pdCalls)
				TriggerClientEvent('chatMessage', player, 'Store Robbery │ ', {255, 255, 255}, "You have started a robbery! If you leave the shop it will be cancelled!", "ooc")

				TriggerClientEvent('es_bank:currentlyrobbing', player, robb)
				banks[robb].lastrobbed = os.time()
				robbers[player] = robb
				local savedSource = player
				SetTimeout(180000, function()
					if(robbers[savedSource])then
						if(user_id)then
							AQUA.giveMoney({user_id, math.random(50000,100000)})
							TriggerClientEvent('chatMessage', -1, 'Store Robbery │ ', {255, 255, 255}, "Robbery is over at: ^5" .. bank.nameofbank .. "^0!", "ooc")
							TriggerClientEvent('es_bank:robberycomplete', savedSource)
						end
					end
				end)		
			end
		else
			AQUAclient.notify(player,{"~d~There are not enough Police online."})
		end 
	end    
end)


