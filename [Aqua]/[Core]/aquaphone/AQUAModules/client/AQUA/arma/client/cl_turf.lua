local a = 40
local b = {}
turfData = {
    {owned = false, gangOwner = "N/A", commission = 0},
    {owned = false, gangOwner = "N/A", commission = 0},
    {owned = false, gangOwner = "N/A", commission = 0},
    {owned = false, gangOwner = "N/A", commission = 0},
    {owned = false, gangOwner = "N/A", commission = 0},
    {owned = false, gangOwner = "N/A", commission = 0},
    {owned = false, gangOwner = "N/A", commission = 0}
}
local c = {}
local d = {}
local e = false
local f = false
local g = 300
local h = {
    {position = vector3(115.97058868408, -1953.0773925781, 20.7513256073), distance = 50.0},
    {position = vector3(133.54704284668, -1305.7708740234, 29.154886245728), distance = 50.0},
    {position = vector3(-555.00347900391, 5328.0615234375, 73.59969329834), distance = 50.0},
    {position = vector3(3575.822265625, 3650.548828125, 33.888591766357), distance = 170.0},
    {position = vector3(-1111.3946533203, 4936.908203125, 218.38539123535), distance = 170.0},
    {position = vector3(1302.1560058594, 4319.66015625, 38.221771240234), distance = 90.0},
    {position = vector3(2487.4445800781, -430.54281616211, 92.992835998535), distance = 120.0}
}
local i = {
    {position = vector3(120.21286010742, -1947.8337402344, 20.7513256073), commissionRate = 0}, -- weed
    {position = vector3(94.305938720704, -1293.9291992188, 29.268863677978), commissionRate = 0}, -- cocaine
    {position = vector3(-549.95635986328, 5326.3022460938, 73.697761535645), commissionRate = 0}, -- meth
    {position = vector3(3579.109375, 3649.7827148438, 33.888641357422), commissionRate = 0}, -- heroin
    {position = vector3(-1114.5859375, 4936.806640625, 218.38012695313), commissionRate = 0}, -- large arms
    {position = vector3(1299.7814941406, 4323.4409179688, 38.295063018799), commissionRate = 0}, -- lsd north
    {position = vector3(2485.3552246094, -427.7490234375, 92.992965698242), commissionRate = 0} -- lsd south
}
Citizen.CreateThread(function()
	local j = tARMA.addBlip(-552.90362548828, 5326.1733398438, 72.599586486816, 403, 3, "Meth Trader")
	local k = tARMA.addBlip(133.73462677002, -1305.0340576172, 29.268741607666, 403, 4, "Cocaine Trader")
	local l = tARMA.addBlip(103.47916412354, -1937.1091308594, 19.803705215454, 140, 2, "Weed Trader")
	local m = tARMA.addBlip(3569.8334960938, 3662.5893554688, 33.920593261718, 586, 1, "Heroin Trader")
	local n = tARMA.addBlip(-1118.4926757813, 4926.1889648438, 218.35691833496, 150, 1, "Large Arms Trader")
	local o = tARMA.addBlip(5065.6201171875, -4591.3857421875, 2.8652405738831, 150, 1, "Large Arms Trader")
	local p = tARMA.addBlip(1317.0300292969, 4309.8359375, 38.005485534668, 604, 8, "LSD North Trader", 1.0)
	local q = tARMA.addBlip(2485.7429199219, -430.13989257813, 92.992835998535, 604, 8, "LSD South Trader", 1.0)
	local r = {
		{
			title = "Weed Trader",
			type = "radius",
			colour = 2,
			id = 1,
			position = vector3(103.47916412354, -1937.1091308594, 19.803705215454),
			blipsize = 50.0
		},
		{
			title = "Cocaine Trader",
			type = "radius",
			colour = 4,
			id = 1,
			position = vector3(133.54704284668, -1305.7708740234, 28.154886245728),
			blipsize = 50.0
		},
		{
			title = "Meth Trader",
			type = "radius",
			colour = 3,
			id = 1,
			position = vector3(-552.90362548828, 5326.1733398438, 72.599586486816),
			blipsize = 50.0
		},
		{
			title = "Heroin Trader",
			type = "radius",
			colour = 1,
			id = 1,
			position = vector3(3545.048828125, 3724.0776367188, 36.64262008667),
			blipsize = 170.0
		},
		{
			title = "Large Arms Trader",
			type = "radius",
			colour = 1,
			id = 1,
			position = vector3(-1118.4926757813, 4926.1889648438, 218.35691833496),
			blipsize = 170.0
		},
        {
			title = "LSD North Trader",
			type = "radius",
			colour = 1,
			id = 1,
			position = vector3(1317.0300292969, 4309.8359375, 38.005485534668),
			blipsize = 90.0
		},
		{
			title = "LSD South Trader",
			type = "radius",
			colour = 1,
			id = 1,
			position = vector3(2539.0964355469, -376.51586914063, 92.986785888672),
			blipsize = 120.0
		},
	}
	for s, t in pairs(r) do
		local u
		if t.type == "radius" then
			u = AddBlipForRadius(t.position.x, t.position.y, t.position.z, t.blipsize)
		elseif t.type == "area" then
			u = AddBlipForArea(t.position.x, t.position.y, t.position.z, t.width, t.height)
			SetBlipRotation(u, 0.0)
			SetBlipSprite(u, 608)
		else
			error(string.format("Invalid type %s specified for %s zone", t.type, t.title))
		end
		c[s] = u
		SetBlipColour(u, t.colour)
		SetBlipAlpha(u, 180)
	end
end)
AddEventHandler("ARMA:onClientSpawn",function(v, w)
	if w then
		TriggerServerEvent("ARMA:refreshTurfOwnershipData")
		TriggerServerEvent("ARMA:requestDrugPriceUpdate")
	end
end)
RegisterNetEvent("ARMA:attackGangCapture",function(x, y)
	f = true
	a = y
	otherMembersStartGangCapture(x, y, h[x].position)
end)
RegisterNetEvent("ARMA:updateTurfOwner",function(x, z)
	turfData[x].gangOwner = z
end)
RegisterNetEvent("ARMA:defendGangCapture",function(x, y)
	a = y
	e = true
	for s, A in pairs(h) do
		if s == x then
			defendGangCapture(s, y, h[s].position.x, h[s].position.y, h[s].position.z)
		end
	end
end)
RegisterNetEvent("ARMA:turfDefenseInterrupt",function()
	e = false
end)
RegisterNetEvent("ARMA:initiateGangCaptureCheck",function(y, C)
	b[y] = C
end)
RegisterNetEvent("ARMA:gotTurfOwnershipData",function(D)
	for s, A in pairs(D) do
		i[s].commissionRate = D[s].commission
		turfData[s].owned = D[s].ownership
	end
end)

function tARMA.isPlayerInTurf()
    for E, F in pairs(h) do
        if #(tARMA.getPlayerCoords() - F.position) < F.distance then
            return true
        end
    end
    return false
end
Citizen.CreateThread(function()
	for B, G in pairs(h) do
		tARMA.addMarker(G.position.x,G.position.y,G.position.z,0.7,0.7,0.5,200,50,0,200,50,24,false,false,true)
	end
	for H, I in pairs(i) do
		tARMA.addMarker(I.position.x,I.position.y,I.position.z,0.7,0.7,0.5,0,50,200,200,50,30,false,false,true)
	end
end)
local J = -1
local K = GetGameTimer()
AddEventHandler("ARMA:onClientSpawn",function(v, w)
	if w then
		local L = function(M)
			PlaySound(-1, "Hit", "RESPAWN_SOUNDSET", 0, 0, 1)
			initializeTurfScaleform()
			J = M.turfId
		end
		local N = function(M)
			J = -1
		end
		local O = function(M)
			if IsControlJustPressed(1, 51) then
				if not PlayerIsInGang then
					tARMA.notify("~r~You need to be in a gang to capture a turf!")
				elseif not f then
					TriggerServerEvent("ARMA:refreshTurfOwnershipData")
					TriggerServerEvent("ARMA:checkTurfCapture", M.turfId)
				end
				Wait(10000)
			end
		end
		for B, P in pairs(h) do
			tARMA.createArea("turf_" .. B, P.position, 1.5, 6, L, N, O, {turfId = B})
		end
		local Q = function(M)
			if turfData[M.turfId].owned then
				PlaySound(-1, "Hit", "RESPAWN_SOUNDSET", 0, 0, 1)
				inGUIARMA = true
				setCursor(1)
				M.draw = true
			end
		end
		local R = function(M)
			inGUIARMA = false
			setCursor(0)
			M.draw = false
		end
		local S = function(M)
			if M.draw then
				local B = M.turfId
				DrawRect(0.484, 0.47, 0.185, 0.206, 0, 0, 0, 150)
				DrawRect(0.484, 0.348, 0.185, 0.036, 0, 0, 0, 150)
				DrawRect(0.484, 0.365, 0.185, -0.002, 255, 17, 23, 150)
				DrawAdvancedText(0.578, 0.349, 0.005, 0.0028, 0.437, "ARMA Trader Manager", 255, 255, 255, 255, 4, 0)
				DrawAdvancedText(0.578,0.414,0.005,0.0028,0.318,"a commission, you can set the commission rate here. Set it too ",255,255,255,255,4,0)
				if B == 5 then
					DrawAdvancedText(0.58,0.395,0.005,0.0028,0.318,"Everytime someone buys weapons at your owned gun dealer, you earn ",255,255,255,255,4,0)
				else
					DrawAdvancedText(0.58,0.395,0.005,0.0028,0.318,"Everytime someone sells drugs at your owned trader, you earn ",255,255,255,255,4,0)
				end
				DrawAdvancedText(0.586,0.432,0.005,0.0028,0.318,"and your turf may come under attack a lot, so be prepared.",255,255,255,255,4,0)
				DrawAdvancedText(0.5, 0.432, 0.005, 0.0028, 0.318, "high", 255, 255, 255, 255, 4, 0)
				DrawAdvancedText(0.568,0.476,0.005,0.0028,0.4,"Current Commission Rate: ",255,255,255,255,4,0)
				DrawAdvancedText(0.622,0.476,0.005,0.0028,0.4,tostring(turfData[M.turfId].commissionRate or 0),255,255,255,255,4,0)
				DrawRect(0.482, 0.526, 0.065, 0.046, traderManageRed, traderManageGreen, traderManageBlue, 150)
				DrawAdvancedText(0.578, 0.53, 0.005, 0.0028, 0.426, "Set New Rate", 255, 46, 71, 255, 4, 0)
				if CursorInArea(0.44, 0.51, 0.50, 0.55) then
					traderManageRed = 0
					traderManageGreen = 165
					traderManageBlue = 71
					if IsControlJustPressed(1, 329) or IsDisabledControlJustPressed(1, 329) then
						PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
						local T
						if B == 5 then
							T = getNewCommissionRate(10)
						else
							T = getNewCommissionRate(25)
						end
						if T ~= nil and tonumber(T) then
							T = math.floor(tonumber(T))
							if T <= 25 and T >= 0 then
								if B == 5 then
									if T > 10 then
										T = 10
									end
								end
								if GetGameTimer() > K + 30000 then
									K = GetGameTimer()
									turfData[M.turfId].commissionRate = T
									if B == 1 then
										TriggerServerEvent("ARMA:setNewWeedPrice", T)
									elseif B == 2 then
										TriggerServerEvent("ARMA:setNewCocainePrice", T)
									elseif B == 3 then
										TriggerServerEvent("ARMA:setNewMethPrice", T)
									elseif B == 4 then
										TriggerServerEvent("ARMA:setNewHeroinPrice", T)
									elseif B == 5 then
										TriggerServerEvent("ARMA:setNewLargeArmsCommission", T)
									elseif B == 6 then
										TriggerServerEvent("ARMA:setNewLSDNorthPrice", T)
									elseif B == 7 then
										TriggerServerEvent("ARMA:setNewLSDSouthPrice", T)
									end
								else
									tARMA.notify("~r~Rate limit, please wait 30s to change the commission.")
								end
							end
						end
					end
				else
					traderManageRed = 0
					traderManageGreen = 0
					traderManageBlue = 0
				end
			end
		end
		for B, G in pairs(i) do
			tARMA.createArea("turfmanager_" .. B, G.position, 1.5, 6, Q, R, S, {turfId = B, draw = false})
		end
	end
end)
RegisterNetEvent("ARMA:captureOwnershipReturned",function(B, U, V)
	if not U then
		startGangCapture(B, h[B].position, V)
	else
		tARMA.notify("~r~Turf already owned!")
	end
end)
function otherMembersStartGangCapture(x, y, W)
    if b[y] then
        f = true
        local timer = g
        Citizen.CreateThread(function()
			while timer ~= 0 do
				if not d[a] then
					timer = timer - 1
				else
					d[a] = true
				end
				Wait(1000)
			end
			if f then
				gangCaptureSuccess(x, y)
			end
			f = false
		end)
        Citizen.CreateThread(function()
			local tmpMarker = tARMA.addMarker(W.x, W.y, W.z - 10, 75, 75, 75, 0, 200, 0, 50, 1000)
			while f do
				local X = GetEntityCoords(tARMA.getPlayerPed(), false)
				local Y = #(X - W)
				if Y >= 37.5 then
					tARMA.notify("~r~Turf capture cancelled, you got too far!")
					f = false
					TriggerServerEvent("ARMA:gangDefenseLocationUpdate", y, "Attackers", true)
				elseif GetEntityHealth(tARMA.getPlayerPed()) <= 102 then
					tARMA.notify("~r~Turf capture failed, you died")
					f = false
					TriggerServerEvent("ARMA:gangDefenseLocationUpdate", y, "Attackers", true)
				end
				Wait(1000)
			end
			tARMA.removeMarker(tmpMarker)
		end)
        Citizen.CreateThread(function()
			while f do
				if not d[y] then
					DrawAdvancedText(0.931,0.954,0.005,0.0028,0.49,"Time remaining till capture: " .. timer .. " seconds!",23,255,141,255,7,0)
				else
					DrawAdvancedText(0.931,0.954,0.005,0.0028,0.49,"Capture blocked, kill enemies to continue timer.",255,23,141,255,7,0)
				end
				Wait(0)
			end
		end)
	end
end
function startGangCapture(x, W, y)
    if turfData[x].owned then
        tARMA.notify("~r~You already own this turf!")
        TriggerServerEvent("ARMA:failCaptureTurfOwned", x)
    else
        TriggerServerEvent("ARMA:initiateGangCapture", x, y)
        local timer = g
        while b[y] == nil do
            Wait(0)
        end
        if b[y] then
            f = true
            Citizen.CreateThread(function()
				while timer ~= 0 and f do
					if not d[y] then
						timer = timer - 1
					else
						d[y] = true
					end
					Wait(1000)
				end
				if f then
					gangCaptureSuccess(x, y)
				end
				f = false
			end)
            Citizen.CreateThread(function()
				tmpMarker = tARMA.addMarker(W.x, W.y, W.z - 10, 75, 75, 75, 0, 200, 0, 50, 1000)
				while f do
					local X = GetEntityCoords(tARMA.getPlayerPed(), false)
					local Y = #(X - W)
					if Y >= 37.5 then
						tARMA.notify("~r~Turf capture cancelled, you got too far!")
						f = false
						TriggerServerEvent("ARMA:gangDefenseLocationUpdate", y, "Attackers", true)
					elseif GetEntityHealth(tARMA.getPlayerPed()) <= 102 then
						tARMA.notify("~r~Turf capture failed, you died")
						f = false
						TriggerServerEvent("ARMA:gangDefenseLocationUpdate", y, "Attackers", true)
					end
					Wait(2000)
				end
				tARMA.removeMarker(tmpMarker)
			end)
            Citizen.CreateThread(function()
				while f do
					if not d[y] then
						DrawAdvancedText(0.931,0.954,0.005,0.0028,0.49,"Time remaining till capture: " .. timer .. " seconds!",23,255,141,255,7,0)
					else
						DrawAdvancedText(0.931,0.954,0.005,0.0028,0.49,"Capture blocked, kill enemies to continue timer.",255,23,141,255,7,0)
					end
					Wait(0)
				end
			end)
        end
    end
end
function defendGangCapture(x, a, Z, _, a0)
    Citizen.CreateThread(function()
		local timer = g
		while timer ~= 0 and e do
			if not d[a] then
				timer = timer - 1
			else
				d[a] = true
			end
			Wait(1000)
		end
		gangDefenseSuccess()
		e = false
	end)
    Citizen.CreateThread(function()
		while e do
			if not d[a] then
				DrawAdvancedText(0.931,0.954,0.005,0.0028,0.49,"Time remaining till capture: " .. timer .. " seconds!",23,255,141,255,7,0)
			else
				DrawAdvancedText(0.931,0.954,0.005,0.0028,0.49,"Capture blocked, kill enemies to continue timer.",255,23,141,255,7,0)
			end
			Wait(0)
		end
	end)
    Citizen.CreateThread(function()
		local tmpMarker = tARMA.addMarker(Z, _, a0 - 10, 75, 75, 75, 0, 200, 0, 50, 1000)
		while e do
			local X = GetEntityCoords(tARMA.getPlayerPed(), false)
			local Y = #(X - vector3(h[x].x, h[x].y, h[x].z))
			if Y < 37.5 and GetEntityHealth(tARMA.getPlayerPed()) > 102 then
				TriggerServerEvent("ARMA:gangDefenseLocationUpdate", a, "Defenders", true)
			elseif GetEntityHealth(tARMA.getPlayerPed()) > 102 then
				TriggerServerEvent("ARMA:gangDefenseLocationUpdate", a, "Defenders", false)
			elseif GetEntityHealth(tARMA.getPlayerPed()) <= 102 then
				tARMA.notify("~r~Turf defense failed, you died")
				e = false
				TriggerServerEvent("ARMA:gangDefenseLocationUpdate", a, "Defenders", false)
			else
				TriggerServerEvent("ARMA:gangDefenseLocationUpdate", a, "Defenders", false)
			end
			Wait(1000)
		end
		tARMA.removeMarker(tmpMarker)
	end)
end
RegisterNetEvent("ARMA:setBlockedStatus",function(y, a1)
	d[y] = a1
end)
RegisterNetEvent("ARMA:gangDefenseSuccess",function()
	e = false
end)
function gangCaptureSuccess(x, a)
    turfData[x].owned = true
    TriggerServerEvent("ARMA:gangCaptureSuccess", a)
end
function gangDefenseSuccess()
    TriggerServerEvent("ARMA:gangDefenseSuccess", a)
end
function getNewCommissionRate(a2)
    AddTextEntry("FMMC_MPM_NA", "Enter new commission rate(0-" .. tostring(a2) .. "%) (Only enter a number, no %): ")
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "10", "", "", "", 30)
    while UpdateOnscreenKeyboard() == 0 do
        DisableAllControlActions(0)
        Wait(0)
    end
    if GetOnscreenKeyboardResult() then
        local a3 = GetOnscreenKeyboardResult()
        return a3
    end
    return nil
end
function initializeTurfScaleform()
    Citizen.CreateThread(function()
		function Initialize(scaleform)
			local scaleform = RequestScaleformMovie(scaleform)
			while not HasScaleformMovieLoaded(scaleform) do
				Citizen.Wait(0)
			end
			BeginScaleformMovieMethod(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
			ScaleformMovieMethodAddParamTextureNameString("~g~Press E to capture this turf!")
			EndScaleformMovieMethod()
			return scaleform
		end
		scaleform = Initialize("mp_big_message_freemode")
		while J ~= -1 do
			local a4 = 0.5
			local a5 = 0.35
			local a6 = 1.0
			local a7 = a6
			DrawScaleformMovie(scaleform, a4, a5, a6, a7)
			Wait(0)
		end
	end)
end