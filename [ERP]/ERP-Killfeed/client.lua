-- Configuration Options
local config = {
	prox_enabled = false,					-- Proximity Enabled
	prox_range = 100000,						-- Distance
	togglecommand = 'killfeed',	        	-- Toggle Kill Feed Command
	chatPrefix = '!',
}

-- Weapons Table
local weapons = {

	[GetHashKey("WEAPON_MOSIN")] = 'mosin',
	[GetHashKey("WEAPON_SVD")] = 'sniperr',


	[GetHashKey("WEAPON_AXE")] = 'melee',
	[GetHashKey("WEAPON_BASEBALLBAT")] = 'melee',
	[GetHashKey("WEAPON_BROOM")] = 'melee',
	[GetHashKey("WEAPON_DIAMONDSWORD")] = 'melee',
	[GetHashKey("WEAPON_SHANK")] = 'melee',
	[GetHashKey("WEAPON_SHOVEL")] = 'melee',

	[GetHashKey("WEAPON_M1911")] = 'pistol',
	[GetHashKey("WEAPON_REVOLVER357")] = 'pistol',
	[GetHashKey("WEAPON_ROOK")] = 'pistol',
	[GetHashKey("WEAPON_PYTHON")] = 'pistol',
	
	[GetHashKey("WEAPON_UZI")] = 'smgs',
	[GetHashKey("WEAPON_UMP45")] = 'smgs',

	[GetHashKey("WEAPON_AK47")] = 'aks',
	[GetHashKey("WEAPON_AK200")] = 'aks',
	[GetHashKey("WEAPON_SPAR16")] = 'aks',
	[GetHashKey("WEAPON_AK74KASHNAR")] = 'aks',
	[GetHashKey("WEAPON_M4A1")] = 'aks',

	[GetHashKey("WEAPON_WINCHESTER12")] = 'shotgun',
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
                if killer == killed then
					TriggerServerEvent('KillFeed:Died', killedCoords)
				else
					local KillerNetwork = NetworkGetPlayerIndexFromPed(killer)
					if KillerNetwork == "**Invalid**" or KillerNetwork == -1 then
						TriggerServerEvent('KillFeed:Died', killedCoords)
					else
						TriggerServerEvent('KillFeed:Killed', GetPlayerServerId(KillerNetwork), hashToWeapon(GetPedCauseOfDeath(killed)), killedCoords)
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
AddEventHandler('KillFeed:AnnounceKill', function(killed, killer, weapon, coords)
	if feedActive then
		if coords ~= nil and config.prox_enabled then
			local myLocation = GetEntityCoords(GetPlayerPed(PlayerId()))
			if #(myLocation - coords) < config.prox_range then
				SendNUIMessage({
					type = 'newKill',
					killer = killer,
					killed = killed,
					weapon = weapon,
				})
			end
		else
			SendNUIMessage({
				type = 'newKill',
				killer = killer,
				killed = killed,
				weapon = weapon,
			})
		end
	end
end)

RegisterNetEvent('KillFeed:AnnounceDeath')
AddEventHandler('KillFeed:AnnounceDeath', function(killed, coords)
	if feedActive then
		if coords ~= nil and config.prox_enabled then
			local myLocation = GetEntityCoords(GetPlayerPed(PlayerId()))
			if #(myLocation - coords) < config.prox_range then
				SendNUIMessage({
					type = 'newDeath',
					killed = killed,
				})
			end
		else
			SendNUIMessage({
				type = 'newDeath',
				killed = killed,
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

Citizen.CreateThread(function()
	RegisterCommand(config.togglecommand, function(source, args, raw)
		feedActive = not feedActive
		if feedActive then
			TriggerEvent("showNotify", "Kill feed is now ~g~Enabled~w~.")
		else
			TriggerEvent("showNotify", "Kill feed is now ~r~Disabled~w~.")
		end
	end)

end)

RegisterNetEvent('showNotify')
AddEventHandler('showNotify', function(notify)
	ShowAboveRadarMessage(notify)
end)

function ShowAboveRadarMessage(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0,1)
end