local holstered = true
local disableFiring = false
local equipedWeapon = nil
local weaponlist = {
	"WEAPON_FLASHLIGHT",
	"WEAPON_MOLOTOV",
	"WEAPON_FIREEXTINGUISHER",
	"WEAPON_PETROLCAN",
	"WEAPON_FLARE",
	"WEAPON_KNUCKLE",
	"WEAPON_SNOWBALL",
	"WEAPON_BROOM",
	"WEAPON_BUTTERFLY",
	"WEAPON_CLEAVER",
	"WEAPON_CRICKETBAT",
	"WEAPON_SLEDGEHAMMER",
	"WEAPON_SHOVEL",
	"WEAPON_SHANK",
	"WEAPON_KITCHENKNIFE",
	"WEAPON_GUITAR",
	"WEAPON_FIREAXE",
	"WEAPON_DILDO",
	"WEAPON_HAMAXEHAM",
	"WEAPON_TOILETBRUSH",
	"WEAPON_TRAFFICSIGN",
	"WEAPON_WOODENBAT",
	"WEAPON_SWITCHBLADE",
	"WEAPON_BERETTA",
	"WEAPON_M1911",
	"WEAPON_PYTHON",
	"WEAPON_TEC9",
	"WEAPON_AK74",
	"WEAPON_MOSIN",
	"WEAPON_OLYMPIA",
	"WEAPON_UZI",
	"WEAPON_UMP45",
	"WEAPON_SNOWBALL",
	"WEAPON_MOLOTOV",
	"WEAPON_FIREEXTINGUISHER",
	"WEAPON_PETROLCAN",
	"WEAPON_MJLONIR",
	"WEAPON_AK74KASHNAR",
	"WEAPON_SPECCARBINE",
	"WEAPON_PUMPMK2",
	"WEAPON_416D",
	"WEAPON_FNX",
	"WEAPON_RAUDNIMP5",
	"WEAPON_KATANA",
	"WEAPON_GOLDENDEAGLE",
	"WEAPON_M4A1",
	"WEAPON_SIGMCX",
	"WEAPON_REMINGTON870",
	"WEAPON_G36K",
	"WEAPON_USAS",
	"WEAPON_PDW",
	"WEAPON_SMOKEGRENADE",
	"WEAPON_BZGAS",
	"WEAPON_MP5",
	"WEAPON_FNFAL",
	"WEAPON_AR15",
	"WEAPON_BARRET",
	"WEAPON_VECTOR",
	"WEAPON_HK45",
	"WEAPON_LVOAC",
	"WEAPON_HK416",
	"WEAPON_SCARL",
	"WEAPON_THOMPSON",
	"WEAPON_MAKAROV",
	"WEAPON_PROKO",
	"WEAPON_MAC11",
	"WEAPON_ACR",
	"WEAPON_MP7",
	"WEAPON_VECTOR",
	"WEAPON_416C",
	"WEAPON_PUN1911",
	"WEAPON_M249",
	"WEAPON_P226",
	"WEAPON_M110",
	"WEAPON_MP9",
	"WEAPON_FLASHBANG",
	"WEAPON_JAG",
	"WEAPON_CROWBAR",
	"WEAPON_AA12",
	"WEAPON_REV",
	"WEAPON_PPSH",
	"WEAPON_AUG",
	"WEAPON_M1935",
	"WEAPON_38A",
	"WEAPON_MPX",
	"WEAPON_ARX",
	"WEAPON_KUDA",
	"WEAPON_IWI",
	"WEAPON_A2",
	"WEAPON_MT",
	"WEAPON_M200",
	"WEAPON_HK",
	"WEAPON_P99",
	"WEAPON_UMP9",
	"WEAPON_IA2",
	"WEAPON_HKUSP",
	"WEAPON_SV",
	"WEAPON_TAC",
	"WEAPON_KICKASS",
	"WEAPON_BASEBALLBAT",
	"WEAPON_VESPER",
	"WEAPON_PPK",
	"WEAPON_AKM",
	"WEAPON_SVD",
	"WEAPON_WINCHESTER12",
	"WEAPON_NAILBAT",
	"WEAPON_P22",
	"WEAPON_AR18",
	"WEAPON_M110G",
	"WEAPON_TINT",
	"WEAPON_M8",
	"WEAPON_CRIM",
	"WEAPON_FIVE",
	"WEAPON_AK12",
	"WEAPON_SCA",
	"WEAPON_QBZ",
	"WEAPON_2077",
	"WEAPON_HK33",
	"WEAPON_AW",
	"WEAPON_CZ75",
	"WEAPON_AVENGERS",
	"WEAPON_SOCOM",
	"WEAPON_FAMAS",
	"WEAPON_SIG",
	"WEAPON_DL44",
	"WEAPON_BORA",
	"WEAPON_LONGSWORD",
	"WEAPON_NV4",
	"WEAPON_ACR1",
	"WEAPON_MR6",
	"WEAPON_FAL",
	"WEAPON_AXE",
	"WEAPON_BASEBALLBAT",
	"WEAPON_BROOM",
	"WEAPON_DIAMONDSWORD",
	"WEAPON_SHANK",
	"WEAPON_SHOVEL",
	"WEAPON_AK200",
	"WEAPON_AK47",
	"WEAPON_UZI",
	"WEAPON_AK74KASHNAR",
	"WEAPON_M4A1",
	"WEAPON_SPAR16",
	"WEAPON_SVD",
	"WEAPON_M1911",
	"WEAPON_REVOLVER357",
	"WEAPON_ROOK",
}

 Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
		if GetVehiclePedIsTryingToEnter(playerPed) ~= 0 then
			SetCurrentPedWeapon(playerPed,GetHashKey("WEAPON_UNARMED"),true)
		end
		if disableFiring then
			DisablePlayerFiring(playerPed,true)
		end
		Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped, true) then
			if GetIsTaskActive(ped, 56) then
				if GetSelectedPedWeapon(ped) ~= GetHashKey('WEAPON_UNARMED') then
					loadAnimDict("reaction@intimidation@1h")
					TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 8.0, 2.0, 1700, 48, 10, 0, 0, 0 )
					SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
					disableFiring = true
					Citizen.Wait(1300)
					SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
					Citizen.Wait(700)
					ClearPedTasks(ped)
					holstered = false
					disableFiring = false
					equipedWeapon = CurrentWeapon(ped)
				else
					loadAnimDict("reaction@intimidation@1h")
					TaskPlayAnim(ped, "reaction@intimidation@1h", "outro", 8.0, 2.0, 1700, 48, 10, 0, 0, 0 )
					disableFiring = true
					SetCurrentPedWeapon(ped, GetHashKey(equipedWeapon), true) -- This needs to recognize current weapon set it so it appears when holstering. Hex stuff /shrug
					Citizen.Wait(1300)
					SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)

					Citizen.Wait(700)
					ClearPedTasks(ped)
					holstered = true
					disableFiring = false
					equipedWeapon = nil
				end
			end
		end
		Wait(0)
	end
end)

function CurrentWeapon(ped)
	currentWeapon = GetSelectedPedWeapon(ped)
	for k,v in pairs(weaponlist) do
		if GetHashKey(v) == currentWeapon then
			return v
		end
	end
	return nil
end

function loadAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Wait(0)
	end
end

