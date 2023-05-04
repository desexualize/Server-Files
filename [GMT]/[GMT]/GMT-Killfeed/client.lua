-- Configuration Options
local config = {
	prox_enabled = false,					-- Proximity Enabled
	prox_range = 100,						-- Distance
	togglecommand = 'killfeed',	        	-- Toggle Kill Feed Command
	chatPrefix = '!',
}

-- Weapons Table
local weapons = {
	[-1569615261] = 'Melee',
	[-1569615261] = 'death',
	-- Custom Ars
	[GetHashKey("WEAPON_MOSIN")] = 'mosin',
	[GetHashKey("WEAPON_NERFMOSIN")] = 'mosin',
	[GetHashKey("WEAPON_CHERRYMOSIN")] = 'mosin',
	[GetHashKey("WEAPON_NOVMOSIN")] = 'mosin',
	

    -- [Out Guns]
    [GetHashKey("WEAPON_shank")] = 'Melee',
    [GetHashKey("WEAPON_broom")] = 'Melee',
    [GetHashKey("WEAPON_dildo")] = 'Melee',
    [GetHashKey("WEAPON_toiletbrush")] = 'Melee',
	[GetHashKey("WEAPON_MEDSWORD")] = 'Melee',
	
	[GetHashKey("WEAPON_SABERVADER")] = 'Melee',

    [GetHashKey("WEAPON_glock")] = 'pistol',
    [GetHashKey("WEAPON_m1911")] = 'pistol',
    [GetHashKey("WEAPON_beretta")] = 'pistol',
    [GetHashKey("WEAPON_hawk")] = 'pistol',
    [GetHashKey("WEAPON_GLOCK")] = 'pistol',
    [GetHashKey("WEAPON_PYTHON")] = 'pistol',
    
    
    [GetHashKey("WEAPON_mp7")] = 'smgs',
	[GetHashKey("WEAPON_TEC9")] = 'smgs',
    [GetHashKey("WEAPON_mp40")] = 'smgs',
    [GetHashKey("WEAPON_vesper")] = 'smgs',
    [GetHashKey("WEAPON_mac10")] = 'smgs',
    [GetHashKey("WEAPON_mp5")] = 'smgs',
    [GetHashKey("WEAPON_CQ300")] = 'smgs',
    [GetHashKey("WEAPON_scorpianblue")] = 'smgs',
    [GetHashKey("WEAPON_blackicepeacekeeper")] = 'smgs',
    [GetHashKey("WEAPON_DIAMONDMP5")] = 'smgs',
	[GetHashKey("WEAPON_NEONOIRMAC10")] = 'smgs',
	[GetHashKey("WEAPON_ICEVECTOR")] = 'smgs',
	[GetHashKey("WEAPON_UMPV2NEONOIR")] = 'smgs',
	[GetHashKey("WEAPON_MP9PD")] = 'smgs',
	


    [GetHashKey("WEAPON_akm")] = 'aks',
    [GetHashKey("WEAPON_m4a1")] = 'aks',
    [GetHashKey("WEAPON_m16a1")] = 'aks',
    [GetHashKey("WEAPON_AK200")] = 'aks',
    [GetHashKey("WEAPON_PDHK416")]= 'aks',
    [GetHashKey("WEAPON_PDAR15")] = 'aks',
    [GetHashKey("WEAPON_PDMCX")] = 'aks',
	[GetHashKey("WEAPON_spar17")] = 'aks',
	[GetHashKey("WEAPON_spar16")] = 'aks',
    [GetHashKey("WEAPON_GOLDAK")] = 'aks',
	[GetHashKey("WEAPON_MXM")] = 'aks',
	[GetHashKey("WEAPON_MK1EMR")] = 'aks',
	[GetHashKey("WEAPON_BLASTXPHANTOM")] = 'aks',
    [GetHashKey("WEAPON_MXC")] = 'aks',
	[GetHashKey("WEAPON_GRAU556")] = 'aks',
	[GetHashKey("WEAPON_M4A4FIRE")] = 'aks',
	[GetHashKey("WEAPON_M4SANDSTORM")] = 'aks',
	[GetHashKey("WEAPON_RUSTAK")] = 'aks',
	[GetHashKey("WEAPON_AK74")] = 'aks',
	[GetHashKey("WEAPON_HKJAMO")] = 'aks',
	[GetHashKey("WEAPON_PRIMEVANDAL")] = 'aks',
	[GetHashKey("WEAPON_RGXVANDAL")] = 'aks',
	[GetHashKey("WEAPON_M16A1PD")] = 'aks',
	[GetHashKey("WEAPON_SA80")] = 'aks',
	
	
	
	
	
    [GetHashKey("WEAPON_winchester")] = 'shotgun',
	[GetHashKey("WEAPON_FNTACSHOTGUN")] = 'shotgun',
    [GetHashKey("WEAPON_olympia")] = 'shotgun',
    [GetHashKey("WEAPON_remington870")] = 'shotgun',


    [GetHashKey("WEAPON_SVD")] = 'sniperr',
    [GetHashKey("WEAPON_REMINGTON700")] = 'sniperr',
	[GetHashKey("WEAPON_REAVEROP")] = 'sniperr',
	[GetHashKey("WEAPON_L96A3")] = 'sniperr',
	
}

local feedActive = true
local isDead = false
Citizen.CreateThread(function()
    while true do
		local killed = GetPlayerPed(PlayerId())
		local killedCoords = GetEntityCoords(killed)
		if IsEntityDead(killed) and not isDead then
            local killer = GetPedKiller(killed)
            if killer ~= 0 then
				local killerCoords = GetEntityCoords(killer)
                if killer == killed then
					TriggerServerEvent('KillFeed:Died', killedCoords)
				else
					local KillerNetwork = NetworkGetPlayerIndexFromPed(killer)
					if KillerNetwork == "**Invalid**" or KillerNetwork == -1 then
						TriggerServerEvent('KillFeed:Died', killedCoords)
					
					else
						TriggerServerEvent('KillFeed:Killed', GetPlayerServerId(KillerNetwork), hashToWeapon(GetPedCauseOfDeath(killed)), killedCoords, killerCoords, weapon_hash)
					end
                end
            else
				TriggerServerEvent('KillFeed:Died', killedCoords)
            end
            isDead = true
        end
		if not IsEntityDead(killed) then
			isDead = false
		end
        Citizen.Wait(50)
    end
end)

RegisterNetEvent('KillFeed:AnnounceKill')
AddEventHandler('KillFeed:AnnounceKill', function(killed, killer, weapon, distance, coords, killerGroup, killedGroup)
	if feedActive then
		if killed == GetPlayerName(PlayerId()) or killer == GetPlayerName(PlayerId()) then
			style = "killContainerOwn"
		else
			style = "killContainer"
		end

		if coords ~= nil and config.prox_enabled then
			local myLocation = GetEntityCoords(GetPlayerPed(PlayerId()))
			if #(myLocation - coords) < config.prox_range then
				SendNUIMessage({
					type = 'newKill',
					killer = killer,
					killed = killed,
					weapon = weapon,
					distance = distance,
					style = style,
					killerGroup = killerGroup,
					killedGroup = killedGroup,
				})
			end
		else
			SendNUIMessage({
				type = 'newKill',
				killer = killer,
				killed = killed,
				weapon = weapon,
				distance = distance,
				style = style,
				killerGroup = killerGroup,
				killedGroup = killedGroup,
			})
		end
	end
end)

RegisterNetEvent('KillFeed:AnnounceDeath')
AddEventHandler('KillFeed:AnnounceDeath', function(killed, coords, killedGroup)
	if feedActive then
		if killed == GetPlayerName(PlayerId()) or killer == GetPlayerName(PlayerId()) then
			style = "killContainerOwn"
		else
			style = "killContainer"
		end

		if coords ~= nil and config.prox_enabled then
			local myLocation = GetEntityCoords(GetPlayerPed(PlayerId()))
			if #(myLocation - coords) < config.prox_range then
				SendNUIMessage({
					type = 'newDeath',
					killed = killed,
					style = style,
					killedGroup = killedGroup,
				})
			end
		else
			SendNUIMessage({
				type = 'newDeath',
				killed = killed,
				style = style,
				killedGroup = killedGroup,
			})
		end
	end
end)

function hashToWeapon(hash)
	if weapons[hash] ~= nil then
		return weapons[hash]
	else
		return 'weapon_unarmed'
	end
end

RegisterNetEvent('showNotify')
AddEventHandler('showNotify', function(notify)
	ShowAboveRadarMessage(notify)
end)

function ShowAboveRadarMessage(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0,1)
end
