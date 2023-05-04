local robbing = false
local bank = ""
local secondsRemaining = 0

function bank_DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function bank_drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

local banks = {
	["Lindsay Circus"] = {
		position = { ['x'] = -708.30255126953, ['y'] = -904.09454345703, ['z'] = 19.215612411499 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Lindsay Circus LTD Gas Station",
		lastrobbed = 0
	},
	["Prosperity St"] = {
		position = { ['x'] = -1479.2109375, ['y'] = -374.54257202148, ['z'] = 39.163242340088 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Prosperity St Robs Liquor",
		lastrobbed = 0
	},
	["Barbareno Road Great Ocean"] = {
		position = { ['x'] = -3248.1918945312, ['y'] = 1007.1194458008, ['z'] = 12.830711364746 }, 
		reward = 100 + math.random(800,1500),
		nameofbank = "Barbareno Road(Great Ocean) 24/7 Supermarket",
		lastrobbed = 0
	},
	["North Rockford Dr"] = {
		position = { ['x'] = -1828.9028320313, ['y'] = 798.63702392578, ['z'] = 137.18780517578+1},
		reward = 100 + math.random(800,1500),
		nameofbank = "North Rockford Dr LTD Gas Station",
		lastrobbed = 0
	},
	["Great Ocean Hway East"] = {
		position = { ['x'] = 1734.6267089844, ['y'] = 6420.4545898438, ['z'] = 35.037261962891}, 
		reward = 100 + math.random(800,1500),
		nameofbank = "Great Ocean Hway East 24/7 Supermarket",
		lastrobbed = 0
	},
	["Alhambra Dr Sandy"] = {
		position = { ['x'] = 1959.2900390625, ['y'] = 3748.7607421875, ['z'] = 32.343788146973}, 
		reward = 100 + math.random(800,1500),
		nameofbank = "Alhambra Dr Sandy 24/7 Supermarket",
		lastrobbed = 0
	},
	["Palomino Fwy Reststop"] = {
		position = { ['x'] = 2549.2858886719, ['y'] = 384.96740722656, ['z'] = 107.62294769287+1 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Palomino Fwy Reststop 24/7 Supermarket",
		lastrobbed = 0
	},
	["Clinton Ave"] = {
		position = { ['x'] = 378.09167480469, ['y'] = 333.21795654297, ['z'] = 103.56644439697 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Clinton Ave 24/7 Supermarket",
		lastrobbed = 0
	},
	["Grove St/Davis St"] = {
		position = { ['x'] = -43.362739562988, ['y'] = -1748.4748535156, ['z'] = 29.421018600464 },  
		reward = 100 + math.random(800,1500),
		nameofbank = "Grove St/Davis St LTD Gas Station",
		lastrobbed = 0
	},
	["Innocence Blvd"] = {
		position = { ['x'] = 28.211944580078, ['y'] = -1339.3952636719, ['z'] = 29.497043609619 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Innocence Blvd 24/7 Supermarket",
		lastrobbed = 0
	},
	["San Andreas Ave"] = {
		position = { ['x'] = -1220.7747802734, ['y'] = -915.93646240234, ['z'] = 10.326335906982+1 },
		reward = 100 + math.random(800,1500),
		nameofbank = "San Andreas Ave Robs Liquor",
		lastrobbed = 0
	},
	["Route 68 Outside Sandy"] = {
		position = { ['x'] = 1169.2320556641, ['y'] = 2717.8083496094, ['z'] = 36.157665252686+1 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Route 68 Outside Sandy 24/7 Supermarket",
		lastrobbed = 0
	},
	["Great Ocean Hway"] = {
		position = { ['x'] = -2959.6359863281, ['y'] = 387.15356445313, ['z'] = 13.043292999268+1 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Great Ocean Hway Robs Liquor",
		lastrobbed = 0
	},
	["Inseno Rd Great Ocean"] = {
		position = { ['x'] = -3047.5261230469, ['y'] = 585.70452880859, ['z'] = 7.9089307785034 }, 
		reward = 100 + math.random(800,1500),
		nameofbank = "Inseno Rd Great Ocean 24/7 Supermarket",
		lastrobbed = 0
	},	
	["Grapeseed Main St"] = {
		position = { ['x'] = 1707.8717041016, ['y'] = 4920.2475585938, ['z'] = 41.063678741455+1 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Grapeseed Main St 24/7 Supermarket",
		lastrobbed = 0
	},	
	["Algonquin Blvd"] = {
		position = { ['x'] = 1394.0030517578, ['y'] = 3609.3815917969, ['z'] = 34.980934143066 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Algonquin Blvd Ace Liquors",
		lastrobbed = 0
	},	
	["Panorama Dr"] = {
		position = { ['x'] = 1993.7019042969, ['y'] = 3050.3120117188, ['z'] = 47.215267181396 }, 
		reward = 100 + math.random(800,1500),
		nameofbank = "Panorama Dr Yellow Jack Inn",
		lastrobbed = 0
	},	
	["Senora Fwy Sandy"] = {
		position = { ['x'] = 2673.0397949219, ['y'] = 3286.4714355469, ['z'] = 55.241188049316 }, 
		reward = 100 + math.random(800,1500),
		nameofbank = "Senora Fwy Sandy 24/7 Supermarket",
		lastrobbed = 0
	},
	["Mirror Park Blvd"] = {
		position = { ['x'] = 1159.5697021484, ['y'] = -314.11761474609, ['z'] = 68.205139160156+1 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Mirror Park Blvd LTD Gas Station",
		lastrobbed = 0
	},	
	["El Rancho Blvd"] = {
		position = { ['x'] = 1126.8146972656, ['y'] = -980.38244628906, ['z'] = 45.415775299072 }, 
		reward = 100 + math.random(800,1500),
		nameofbank = "El Rancho Blvd Robs Liquor",
		lastrobbed = 0
	}	
}


RegisterNetEvent('es_bank:currentlyrobbing')
AddEventHandler('es_bank:currentlyrobbing', function(robb)
	robbing = true
	bank = robb
	secondsRemaining = 180
end)

RegisterNetEvent('es_bank:toofarlocal')
AddEventHandler('es_bank:toofarlocal', function(robb)
	robbing = false
	notify("The robbery was cancelled, you will receive nothing.")
	robbingName = ""
	secondsRemaining = 0
	incircle = false
end)

RegisterNetEvent('es_bank:playerdiedlocal')
AddEventHandler('es_bank:playerdiedlocal', function(robb)
	robbing = false
	notify("The robbery was cancelled, you died!.")
	robbingName = ""
	secondsRemaining = 0
	incircle = false
end)


RegisterNetEvent('es_bank:robberycomplete')
AddEventHandler('es_bank:robberycomplete', function(reward)
	robbing = false
	notify("Robbery done, you received:^2" .. reward)
	bank = ""
	secondsRemaining = 0
	incircle = false
end)

Citizen.CreateThread(function()
	while true do
		if robbing then
			Citizen.Wait(1000)
			if(secondsRemaining > 0)then
				secondsRemaining = secondsRemaining - 1
			end
		end

		Citizen.Wait(0)
	end
end)


incircle = false

Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(banks)do
			local pos2 = v.position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				if not robbing then
					DrawMarker(2, v.position.x, v.position.y, v.position.z, 0, 0, 0, 0, 0, 0, 0.4, 0.4, 0.4, 230, 0, 0, 150, true, true, 0, 0, 0, 0, 0)
					
					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 2)then
						if (incircle == false) then
							bank_DisplayHelpText("Press ~INPUT_CONTEXT~ to rob shop!")
						end
						incircle = true
						if(IsControlJustReleased(1, 51))then
							if IsPedArmed(PlayerPedId(), 4) then
								TriggerServerEvent('es_bank:rob', k)
							else
								notify("~r~You need to be armed to rob the store!")
							end
						end
					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 2)then
						incircle = false
					end
				end
			end
		end

		if robbing then

			
			bank_drawTxt(0.92, 1.44, 1.0,1.0,0.5, "Robbing store: ~r~" .. secondsRemaining .. "~w~ seconds remaining", 255, 255, 255, 255)
			
			local pos2 = banks[bank].position
			local ped = GetPlayerPed(-1)
			
            if IsEntityDead(ped) then
			TriggerServerEvent('es_bank:playerdied', bank)
			elseif (Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 15)then
				TriggerServerEvent('es_bank:toofar', bank)
			end
		end

		Citizen.Wait(0)
	end
end)
