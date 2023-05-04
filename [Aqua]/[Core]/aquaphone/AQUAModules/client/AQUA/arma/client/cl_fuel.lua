local a = module("cfg/cfg_fuel")
AddEventHandler("ARMA:onClientSpawn",function(D, E)
    if E then
		for b, c in pairs(a.stations) do
			tARMA.addBlip(c.x, c.y, c.z, 361, 4, "Petrol Station", 0.6)
		end
	end
end)
local d = false
local e = false
local f = 0.0
local g = 0.0
local h = 1000000
local i = false
function setVehicleFuel(j, k)
    if type(k) == "number" and k >= 0 and k <= 100 then
        SetVehicleFuelLevel(j, k + 0.0)
        DecorSetFloat(j, a.decor, GetVehicleFuelLevel(j))
    end
end
local function l(m, n)
    local o = 10 ^ (n or 0)
    return math.floor(m * o + 0.5) / o
end
local function p(j)
    return DecorGetFloat(j, a.decor)
end
local function q(j)
    if not DecorExistOn(j, a.decor) then
        setVehicleFuel(j, math.random(200, 800) / 10)
    elseif not i then
        setVehicleFuel(j, p(j))
        i = true
    end
    if GetIsVehicleEngineRunning(j) then
        local r = a.fuelUsage[l(GetVehicleCurrentRpm(j), 1)] or 1.0
        setVehicleFuel(j, GetVehicleFuelLevel(j) - r * (a.classes[GetVehicleClass(j)] or 1.0) / 10)
    end
end
Citizen.CreateThread(function()
	DecorRegister(a.decor, 1)
	while true do
		Citizen.Wait(1000)
		local s = PlayerPedId()
		if IsPedInAnyVehicle(s) then
			local j = GetVehiclePedIsIn(s)
			if GetPedInVehicleSeat(j, -1) == s then
				q(j)
			end
		else
			if i then
				i = false
			end
		end
	end
end)
local function t()
    local u = GetEntityCoords(PlayerPedId())
    local v = {}
    for b, w in ipairs(GetGamePool("CObject")) do
        local x = GetEntityModel(w)
        if a.pumpModels[x] then
            table.insert(v, w)
        end
    end
    local y = 0
    local z = 1000
    for A, B in pairs(v) do
        local C = #(u - GetEntityCoords(B))
        if C < z then
            z = C
            y = B
        end
    end
    return y, z
end
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(250)
		local y, z = t()
		if z < 2.5 then
			d = y
		elseif z < 10.0 then
			d = false
			Citizen.Wait(500)
		elseif z < 50.0 then
			d = false
			Citizen.Wait(2500)
		else
			d = false
			Citizen.Wait(5000)
		end
	end
end)

local function D(E, F, G, H)
    local I, J, K = GetScreenCoordFromWorldCoord(E, F, G)
    local L, M, N = table.unpack(GetFinalRenderedCamCoord())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    BeginTextCommandDisplayText("STRING")
    SetTextCentre(1)
    AddTextComponentSubstringPlayerName(H)
    EndTextCommandDisplayText(J, K)
end
AddEventHandler("fuel:startFuelUpTick",function(y, s, j)
	f = GetVehicleFuelLevel(j)
	while e do
		Citizen.Wait(500)
		local O = DecorGetFloat(j, a.decor)
		local P = math.random(10, 20) / 10.0
		local Q = P * 10
		if not y then
			if GetAmmoInPedWeapon(s, 883325847) - P * 100 >= 0 then
				f = O + P
				SetPedAmmo(s, 883325847, math.floor(GetAmmoInPedWeapon(s, 883325847) - P * 100))
			else
				e = false
			end
		else
			f = O + P
		end
		if f > 100.0 then
			f = 100.0
			e = false
		end
		g = g + Q
		if h >= g then
			setVehicleFuel(j, f)
		else
			e = false
		end
	end
	if y then
		TriggerServerEvent("ARMA:takeAmount", math.floor(g))
	end
	local G = GetEntityModel(j)
	local H = tARMA.getVehicleIdFromHash(G)
	if H then
		local I = GetFuel(j)
		TriggerServerEvent("ARMA:updateFuel", H, math.floor(I * 1000) / 1000)
	end
	g = 0.0
end)
AddEventHandler("fuel:refuelFromPump",function(y, s, j)
	TaskTurnPedToFaceEntity(s, j, 1000)
	Citizen.Wait(1000)
	SetCurrentPedWeapon(s, -1569615261, true)
	tARMA.loadAnimDict("timetable@gardener@filling_can")
	TaskPlayAnim(s, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
	TriggerEvent("fuel:startFuelUpTick", y, s, j)
	while e do
		Citizen.Wait(1)
		for A, B in pairs(a.disabledKeys) do
			DisableControlAction(0, B)
		end
		local R = GetEntityCoords(j)
		if y then
			local S = GetEntityCoords(y)
			local T = ""
			T = "\n" .. a.translations.TotalCost .. ": ~g~£" .. l(g, 1)
			D(S.x, S.y, S.z + 1.2, a.translations.CancelFuelingPump .. T)
			D(R.x, R.y, R.z + 0.5, l(f, 1) .. "%")
		else
			D(R.x,R.y,R.z + 0.5,a.translations.CancelFuelingJerryCan .."\nGas can: ~g~" ..l(GetAmmoInPedWeapon(s, 883325847) / 4500 * 100, 1) .. "% | Vehicle: " .. l(f, 1) .. "%")
		end
		if not IsEntityPlayingAnim(s, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 3) then
			TaskPlayAnim(s, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
		end
		if IsControlJustReleased(0, 38) or DoesEntityExist(GetPedInVehicleSeat(j, -1)) or d and GetEntityHealth(y) <= 0 then
			e = false
		end
	end
	ClearPedTasks(s)
	RemoveAnimDict("timetable@gardener@filling_can")
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local s = PlayerPedId()
		if not e and (d and GetEntityHealth(d) > 0 or GetSelectedPedWeapon(s) == 883325847 and not d) then
			if IsPedInAnyVehicle(s) and GetPedInVehicleSeat(GetVehiclePedIsIn(s), -1) == s then
				local U = GetEntityCoords(d)
				D(U.x, U.y, U.z + 1.2, a.translations.ExitVehicle)
			else
				local j = GetPlayersLastVehicle()
				local R = GetEntityCoords(j)
				if DoesEntityExist(j) and #(GetEntityCoords(s) - R) < 2.5 then
					if not DoesEntityExist(GetPedInVehicleSeat(j, -1)) then
						local S = GetEntityCoords(d)
						local V = true
						if GetSelectedPedWeapon(s) == 883325847 then
							S = R
							if GetAmmoInPedWeapon(s, 883325847) < 100 then
								V = false
							end
						end
						if GetVehicleFuelLevel(j) < 95 and V then
							if h > 0 then
								D(S.x, S.y, S.z + 1.2, a.translations.EToRefuel)
								if IsControlJustReleased(0, 38) then
									e = true
									TriggerEvent("fuel:refuelFromPump", d, s, j)
									tARMA.loadAnimDict("timetable@gardener@filling_can")
								end
							else
								D(S.x, S.y, S.z + 1.2, a.translations.NotEnoughCash)
							end
						elseif not V then
							D(S.x, S.y, S.z + 1.2, a.translations.JerryCanEmpty)
						else
							D(S.x, S.y, S.z + 1.2, a.translations.FullTank)
						end
					end
				elseif d then
					local S = GetEntityCoords(d)
					if h >= a.jerryCanCost then
						if not HasPedGotWeapon(s, 883325847) then
							D(S.x, S.y, S.z + 1.2, a.translations.PurchaseJerryCan)
							if IsControlJustReleased(0, 38) then
								tARMA.allowWeapon("883325847")
								GiveWeaponToPed(s, 883325847, 4500, false, true)
								TriggerServerEvent("ARMA:takeAmount", a.jerryCanCost)
								h = 50000
							end
						else
							local W = l(a.fuelCost * (1 - GetAmmoInPedWeapon(s, 883325847) / 4500))
							if W > 0 then
								D(S.x, S.y, S.z + 1.2, a.translations.RefillJerryCan .. W)
								if IsControlJustReleased(0, 38) then
									TriggerServerEvent("ARMA:takeAmount", math.floor(W))
									SetPedAmmo(s, 883325847, 4500)
								end
							else
								D(S.x, S.y, S.z + 1.2, a.translations.JerryCanFull)
							end
						end
					else
						D(S.x, S.y, S.z + 1.2, a.translations.NotEnoughCash)
					end
				else
					Citizen.Wait(250)
				end
			end
		else
			Citizen.Wait(250)
		end
	end
end)
Citizen.CreateThread(function()
	RequestStreamedTextureDict("regplates")
	while not HasStreamedTextureDictLoaded("regplates") do
		Citizen.Wait(1)
	end
	AddReplaceTexture("vehshare", "plate01", "regplates", "plate01")
	AddReplaceTexture("vehshare", "plate01_n", "regplates", "plate01_n")
	AddReplaceTexture("vehshare", "plate02", "regplates", "plate02")
	AddReplaceTexture("vehshare", "plate02_n", "regplates", "plate02_n")
	AddReplaceTexture("vehshare", "plate03", "regplates", "plate03")
	AddReplaceTexture("vehshare", "plate03_n", "regplates", "plate03_n")
	AddReplaceTexture("vehshare", "plate04", "regplates", "plate04")
	AddReplaceTexture("vehshare", "plate04_n", "regplates", "plate04_n")
	AddReplaceTexture("vehshare", "plate05", "regplates", "plate05")
	AddReplaceTexture("vehshare", "plate05_n", "regplates", "plate05_n")
end)
