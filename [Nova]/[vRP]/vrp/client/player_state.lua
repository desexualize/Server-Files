-- periodic player state update
local state_ready = false
AddEventHandler("playerSpawned",function() -- delay state recording
	Citizen.CreateThread(function()
		Citizen.Wait(2000)
		state_ready = true
	end)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(vRPConfig.PlayerSavingTime)

		if IsPlayerPlaying(PlayerId()) and state_ready then
			local client_ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(client_ped, true))
			vRPserver.updatePos({x,y,z})
			vRPserver.updateHealth({tvRP.getHealth()})
			vRPserver.updateArmour({GetPedArmour(client_ped)})
			vRPserver.updateTimePlayed()
			vRPserver.updateWeapons({tvRP.getWeapons()})
			vRPserver.updateCustomization({tvRP.getCustomization()})
		end
	end
end)

-- def
local weapon_types = {
	"WEAPON_KNIFE",
	"WEAPON_BAT",
	"WEAPON_HATCHET",
	"WEAPON_HAMMER",
	
	"WEAPON_M1911",
	"WEAPON_FNP",
	"WEAPON_PYTHON",
	
	"WEAPON_WINCHESTER12",
	"WEAPON_akkal",
	"WEAPON_PPSH",
	"WEAPON_SCARL",
	
	"WEAPON_CHUCKY",
	"WEAPON_AUG",
	"WEAPON_M16A4",
	"WEAPON_SCAR",
	"WEAPON_MOSIN",

	"WEAPON_SNIPERRIFLE",
	"WEAPON_ASSAULTRIFLE_MK2",

	-- Police Weapons
	'WEAPON_FLASHLIGHT',
	'WEAPON_NIGHTSTICK',
	'WEAPON_STUNGUN',
	"WEAPON_GLOCK17",
	'WEAPON_PUMPSHOTGUN',
	'WEAPON_SMOKEGRENADE',
	'WEAPON_MP5',
	'WEAPON_M4A1',
	'WEAPON_G36K',
	'WEAPON_MCX',

	-- LFB Weapons
	'WEAPON_FLAMETHROWER',
}

local countdown = 30
RegisterNetEvent("showText")
AddEventHandler("showText", function()
	while true do
		countdown = countdown - 0.01
		bank_drawTxt(0.85, 1.40, 1.0,1.0,0.5, "Make your way down to the 'Drug House' Basement\n To Purchase Rebel Access.", 255, 17, 0, 255)
		if countdown <= 0 then 
			break
		end
		Citizen.Wait(1)
	end 
end)

function bank_drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
	SetTextFont(0)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	if (outline) then
		SetTextOutline()
	end
	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x - width/2, y - height/2 + 0.005)
end

function tvRP.getWeaponTypes()
  	return weapon_types
end

function tvRP.getWeapons()
	local player = PlayerPedId()

	local ammo_types = {} -- remember ammo type to not duplicate ammo amount

	local weapons = {}
	for k, v in pairs(weapon_types) do
		local hash = GetHashKey(v)
		if HasPedGotWeapon(player, hash) then
			local weapon = {}
			weapons[v] = weapon

			local atype = GetPedAmmoTypeFromWeapon(player, hash)
			if ammo_types[atype] == nil then
				ammo_types[atype] = true
				weapon.ammo = GetAmmoInPedWeapon(player,hash)
			else
				weapon.ammo = 0
			end
		end
	end

	return weapons
end

vRPclient = Proxy.getInterface("vRP")
function tvRP.giveWeapons(weapons, clear_before)
	local player = PlayerPedId()

	-- give weapons to player
	if clear_before then
		RemoveAllPedWeapons(player, true)
	end

	for k, weapon in pairs(weapons) do
		local hash = GetHashKey(k)
		local ammo = weapon.ammo or 0

		vRPclient.allowWeapon({k, "-1"})
		GiveWeaponToPed(player, hash, ammo, false)
	end
	return true
end

--[[
function tvRP.dropWeapon()
  	SetPedDropsWeapon(PlayerPedId())
end
--]]

-- PLAYER CUSTOMIZATION

-- parse part key (a ped part or a prop part)
-- return is_proppart, index
local function parse_part(key)
	if type(key) == "string" and string.sub(key,1,1) == "p" then
		return true,tonumber(string.sub(key,2))
	else
		return false,tonumber(key)
	end
end

function tvRP.getDrawables(part)
	local isprop, index = parse_part(part)
	if isprop then
		return GetNumberOfPedPropDrawableVariations(PlayerPedId(), index)
	else
		return GetNumberOfPedDrawableVariations(PlayerPedId(), index)
	end
end

function tvRP.getDrawableTextures(part,drawable)
	local isprop, index = parse_part(part)
	if isprop then
		return GetNumberOfPedPropTextureVariations(PlayerPedId(), index, drawable)
	else
		return GetNumberOfPedTextureVariations(PlayerPedId(), index, drawable)
	end
end

function tvRP.getCustomization()
	local ped = PlayerPedId()

	local custom = {}

	custom.modelhash = GetEntityModel(ped)

	-- ped parts
	for i= 0, 20 do -- index limit to 20
		custom[i] = {GetPedDrawableVariation(ped,i), GetPedTextureVariation(ped,i), GetPedPaletteVariation(ped,i)}
	end

	-- props
	for i= 0, 10 do -- index limit to 10
		custom["p"..i] = {GetPedPropIndex(ped,i), math.max(GetPedPropTextureIndex(ped,i),0)}
	end

	return custom
end

-- partial customization (only what is set is changed)
function tvRP.setCustomization(custom) -- indexed [drawable,texture,palette] components or props (p0...) plus .modelhash or .model
  local exit = TUNNEL_DELAYED() -- delay the return values

	Citizen.CreateThread(function() -- new thread
		if custom then
			local ped = PlayerPedId()
			local mhash = nil

			-- model
			if custom.modelhash ~= nil then
				mhash = custom.modelhash
			elseif custom.model ~= nil then
				mhash = GetHashKey(custom.model)
			end

			if mhash ~= nil then
				local i = 0
				while not HasModelLoaded(mhash) and i < 10000 do
					RequestModel(mhash)
					Citizen.Wait(10)
				end

				if HasModelLoaded(mhash) then
					-- changing player model remove weapons, so save it
					local weapons = tvRP.getWeapons()
					SetPlayerModel(PlayerId(), mhash)
					tvRP.giveWeapons(weapons,true)
					SetModelAsNoLongerNeeded(mhash)
				end
			end

			ped = PlayerPedId()

			-- parts
			for k, v in pairs(custom) do
				if k ~= "model" and k ~= "modelhash" then
					local isprop, index = parse_part(k)
					if isprop then
						if v[1] < 0 then
							ClearPedProp(ped,index)
						else
							SetPedPropIndex(ped,index,v[1],v[2],v[3] or 2)
						end
					else
						SetPedComponentVariation(ped,index,v[1],v[2],v[3] or 2)
					end
				end
			end
		end

		exit({})
	end)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		vRPserver.UpdatePlayTime()
	end
end)

RegisterNetEvent('PlaneCutscene')
AddEventHandler('PlaneCutscene', function()
    PrepareMusicEvent("FM_INTRO_START")
	TriggerMusicEvent("FM_INTRO_START")

	local plyrId = PlayerPedId()
	-----------------------------------------------
	RequestCutscene("MP_INTRO_CONCAT", 8)
	while not HasCutsceneLoaded() do 
	Wait(10) 
	end
	DoScreenFadeIn(250)
	SetCutsceneEntityStreamingFlags('MP_Male_Character', 0, 1) 
	local female = RegisterEntityForCutscene(0,"MP_Female_Character",3,0,64)
	RegisterEntityForCutscene(plyrId, 'MP_Male_Character', 0, GetEntityModel(plyrId), 64)
	GetEntityIndexOfCutsceneEntity('MP_Female_Character', GetHashKey(GetEntityModel('MP_Female_Character')))

 	---------------------------------------------------------
	SetCutsceneEntityStreamingFlags("MP_Plane_Passenger_1", 0, 1)
	SetCutsceneEntityStreamingFlags("MP_Plane_Passenger_2", 0, 1)
	SetCutsceneEntityStreamingFlags("MP_Plane_Passenger_3", 0, 1)
	SetCutsceneEntityStreamingFlags("MP_Plane_Passenger_4", 0, 1)
	SetCutsceneEntityStreamingFlags("MP_Plane_Passenger_5", 0, 1)
	SetCutsceneEntityStreamingFlags("MP_Plane_Passenger_6", 0, 1)
	SetCutsceneEntityStreamingFlags("MP_Plane_Passenger_7", 0, 1)
	RegisterEntityForCutscene(0, 'MP_Plane_Passenger_1', 3, GetHashKey('mp_f_freemode_01'), 0)
	RegisterEntityForCutscene(0, 'MP_Plane_Passenger_2', 3, GetHashKey('mp_f_freemode_01'), 0)
	RegisterEntityForCutscene(0, 'MP_Plane_Passenger_3', 3, GetHashKey('mp_f_freemode_01'), 0)
	RegisterEntityForCutscene(0, 'MP_Plane_Passenger_4', 3, GetHashKey('mp_f_freemode_01'), 0)
	RegisterEntityForCutscene(0, 'MP_Plane_Passenger_5', 3, GetHashKey('mp_f_freemode_01'), 0)
	RegisterEntityForCutscene(0, 'MP_Plane_Passenger_6', 3, GetHashKey('mp_f_freemode_01'), 0)
	RegisterEntityForCutscene(0, 'MP_Plane_Passenger_7', 3, GetHashKey('mp_f_freemode_01'), 0)
	RegisterEntityForCutscene(0, 'MP_Plane_Passenger_1', 3, GetHashKey('mp_m_freemode_01'), 0)
	RegisterEntityForCutscene(0, 'MP_Plane_Passenger_2', 3, GetHashKey('mp_m_freemode_01'), 0)
	RegisterEntityForCutscene(0, 'MP_Plane_Passenger_3', 3, GetHashKey('mp_m_freemode_01'), 0)
	RegisterEntityForCutscene(0, 'MP_Plane_Passenger_4', 3, GetHashKey('mp_m_freemode_01'), 0)
	RegisterEntityForCutscene(0, 'MP_Plane_Passenger_5', 3, GetHashKey('mp_m_freemode_01'), 0)
	RegisterEntityForCutscene(0, 'MP_Plane_Passenger_6', 3, GetHashKey('mp_m_freemode_01'), 0)
	RegisterEntityForCutscene(0, 'MP_Plane_Passenger_7', 3, GetHashKey('mp_m_freemode_01'), 0)
	NewLoadSceneStartSphere(-1212.79, -1673.52, 7, 1000, 0)
	-----------------------------------------------
	StartCutscene(4)

	Wait(20000)
	StopCutsceneImmediately()
	DoScreenFadeOut(90)
	SetEntityCoordsNoOffset(plyrId, 3094.8723144531,-4703.50390625,24.261253356934, 0)

	SetEntityHeading(plyrId, 330.40)
	Wait(4000)
	PrepareMusicEvent("AC_STOP")
	TriggerMusicEvent("AC_STOP")
	DoScreenFadeIn(500)
end)

function tvRP.spawnAnim(clothing, coords)
	RequestCollisionAtCoord(coords.x, coords.y, coords.z)

	SetEntityInvincible(PlayerPedId(), true)
	SetEntityCoordsNoOffset(PlayerPedId(), coords.x, coords.y, coords.z, true, false, false)
	SetEntityVisible(PlayerPedId(), false, false)
	FreezeEntityPosition(PlayerPedId(), true)

	local initial_time = GetGameTimer()
	while (not HaveAllStreamingRequestsCompleted(PlayerPedId()) or GetNumberOfStreamingRequests() > 0) and GetGameTimer() - initial_time < 10000 do
		Citizen.Wait(0)
	end
	TriggerEvent("Nova:PlaySound", "gtaloadin")
	
	SetFocusPosAndVel(coords.x, coords.y, coords.z + 1000)
	local spawnCam1 = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA", coords.x, coords.y, coords.z + 1000, 0.0, 0.0, 0.0, 65.0, 0, 2)
	SetCamActive(spawnCam1, true)
	RenderScriptCams(true, true, 0, 1, 0, 0)

	local spawnCam2 = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA", coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 65.0, 0, 2)
	SetCamActiveWithInterp(spawnCam2, spawnCam1, 5000, 0, 0)

	Citizen.Wait(2500)
	ClearFocus()
	Citizen.Wait(2000)

	DestroyCam(spawnCam1)
	DestroyCam(spawnCam2)

	RenderScriptCams(false, true, 2000, 0, 0)
	TriggerScreenblurFadeOut(2000.0)
	SetEntityInvincible(PlayerPedId(), false)
	SetEntityVisible(PlayerPedId(), true, false)
	FreezeEntityPosition(PlayerPedId(), false)

	tvRP.setCustomization(clothing)
end