-- [Cloned's Anticheat]

-- Categories:

-- [Armour Detection],
-- [Weapon Blacklist],

-- [Functions],


vRPClient = {}
Tunnel.bindInterface("Anticheat", vRPClient)
Proxy.addInterface("Anticheat", vRPClient)
vRPServer = Tunnel.getInterface("GRPAnticheat", "Anticheat")
vRP = Proxy.getInterface("vRP")


local isInCityZonee = false
Citizen.CreateThread(function()
    while true do 
        Wait(2000) -- we do not need to check every frame bad ops otherwise

        local ped = PlayerPedId()
        local player = PlayerId()
        local veh = GetVehiclePedIsIn(ped, false)
        local isInvincible = GetPlayerInvincible(player)
        if isInvincible and not isInTicket and not setDrawGreenZoneUI then
            TriggerServerEvent("GRP:anticheatBan", "Godmode/ Invincibility [Cheating]")
            if veh ~= false then
                TriggerServerEvent("GRP:anticheatBan", "Godmode/ Invincibility [Cheating]")
            end 
        end
    end
end)

Citizen.CreateThread(function()
    while true do 
        if GetPedArmour(PlayerPedId()) >= 96 then 
            SetPedArmour(PlayerPedId())
            TriggerServerEvent("GRP:anticheatBan", "Spawning in Armour [Cheating]")
        end
        Citizen.Wait(1000)
    end
end)

RegisterNetEvent("changeYo2")
AddEventHandler("changeYo2", function(bool)
  if bool then 
    isInCityZonee = true 
  else 
  isInCityZonee = false 
  end 
end)

Citizen.CreateThread(function()
    while true do 
 
        if GetUsingnightvision() then 
            TriggerServerEvent("GRP:anticheatBan", "Using Night Vision [Cheating]")
        end
      
        Citizen.Wait(500)
    end 
end)

--Citizen.CreateThread(function()
--    while true do 
--        
--        if GetUsingseethrough() then 
--            TriggerServerEvent("GRP:anticheatBan", "Thermal Vision [Cheating]")
--        end
--        
--        Citizen.Wait(500)
--    end 
--end)

Citizen.CreateThread(function()
	while true do
        if ac.weaponblacklist == true then

		    ACPedId = GetPlayerPed(-1)
		    if ACPedId then

		    	nothing, weapon = GetCurrentPedWeapon(ACPedId, true)

		    	if disableallweapons then
		    		RemoveAllPedWeapons(ACPedId, true)
		    	else
		    		if isWeaponBlacklisted(weapon) then

		    			

                        RemoveWeaponFromPed(ACPedId, weapon)
                        notify("~r~[Galaxy RP]: ~b~This weapon is blacklisted!")
                        TriggerServerEvent("GRP:anticheatBan", "Spawning in Weapon's [Cheating]")
                        -- [Ban Function Here]
		    		end
		    	end
		    end
        end
        Wait(100)
	end
end)

Citizen.CreateThread(function()
    while true do 
        if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_RAYPISTOL") then 
            DisablePlayerFiring(GetPlayerPed(-1), true)        
        end 
        Citizen.Wait(1)
    end 
end)

function isWeaponBlacklisted(model)
	for _, blacklistedWeapon in pairs(ac.weaponbl) do
		if model == GetHashKey(blacklistedWeapon) then
			return true
		end
	end

	return false
end

carblacklist = {
	'RHINO',
	'AKULA',
	'SAVAGE',
	'HUNTER',
	'BUZZARD',
	'ANNIHILATOR',
	'VALKYRIE',
	'HYDRA',
	'APC',
	'Trailersmall2',
	'Lazer',
	'oppressor',
	'mogul',
	'barrage',
	'Khanjali',
	'volatol',
	'chernobog',
	'avenger',
	'stromberg',
	'nightshark',
	'besra',
	'babushka ',
	'starling',
	'insurgent',
	'cargobob',
	'cargobob2',
	'cargobob3',
	'cargobob4',
	'caracara',
	'menacer',
    'scramjet',
    'oppressor2',
    'revolter',
    'viseris',
    'savestra',
    'thruster',
    'ardent',
    'dune3',
    'tampa3',
    'halftrack',
    'nokota',
    'strikeforce',
    'bombushka',
    'molotok',
    'pyro',
    'ruiner2',
    'limo2',
    'technical',
    'technical2',
    'technical3',
    'jb700w',
    'blazer5',
    'insurgent3',
	'boxville5',
	'bruiser',
    'bruiser2',
    'bruiser3',
    'brutus',
    'brutus2',
    'brutus3',
    'cerberus',
    'cerberus2',
    'cerberus3',
    'dominator4',
    'dominator5',
    'dominator6',
    'impaler2',
    'impaler3',
    'impaler4',
    'imperator',
    'imperator2',
    'imperator3',
    'issi4',
    'issi5',
    'issi6',
    'monster3',
    'monster4',
    'monster5',
    'scarab',
    'scarab2',
    'scarab3',
    'slamvan4',
    'slamvan5',
    'slamvan6',
    'zr380',
    'zr3802',
    'zr3803',
	'alphaz1',
	'avenger2',
	'blimp',
	'blimp2',
	'blimp3',
	'cargoplane',
	-- 'cuban800',
	'dodo',
	'duster',
	'howard',
	'jet',
	'luxor',
	'luxor2',
	'mammatus',
	'microlight',
	'miljet',
	'nimbus',
	'rogue',
	'seabreeze',
	'shamal',
	'stunt',
	'titan',
	'tula',
	'velum',
	'velum2',
	'vestra',
    'cargoplane',
}

Citizen.CreateThread(function()
    while true do
        Wait(1)

        playerPed = GetPlayerPed(-1)
        if playerPed then
            checkCar(GetVehiclePedIsIn(playerPed, false))
        end
    end
end)

function checkCar(car)
	if car then
		carModel = GetEntityModel(car)
		carName = GetDisplayNameFromVehicleModel(carModel)

		if isCarBlacklisted(carModel) then
			_DeleteEntity(car)
			notify("~r~[Galaxy RP]: ~b~This vehicle is blacklisted!")
		end
	end
end

function isCarBlacklisted(model)
	for _, blacklistedCar in pairs(carblacklist) do
		if model == GetHashKey(blacklistedCar) then
			return true
		end
	end

	return false
end

-- [Functions]

function isInArea(v, dis) 
    
    if #(GetEntityCoords(PlayerPedId(-1)) - v) <= dis then  
        return true
    else 
        return false
    end
end

function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end




