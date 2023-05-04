-- Configuration Options
local config = {
	prox_enabled = false,					-- Proximity Enabled
	prox_range = 100,						-- Distance	-- Toggle Kill Feed Command
}

local toggledkf = true
local toggledkfdistance = true

-- Weapons Table
local weapons = {
	[-1569615261] = 'melee',
	[GetHashKey("WEAPON_SPAR17")] = 'aks',
	[GetHashKey("WEAPON_MXM")] = 'aks',
	[GetHashKey("WEAPON_MK1EMR")] = 'aks',
	[GetHashKey("WEAPON_UMP")] = 'smgs',
	[GetHashKey("WEAPON_MP5")] = 'smgs',
	[GetHashKey("WEAPON_UZI")] = 'smgs',
	[GetHashKey("WEAPON_SPAR16")] = 'aks',
	[GetHashKey("WEAPON_BATON")] = 'melee',
	[GetHashKey("WEAPON_BUTTERFLY")] = 'melee',
	[GetHashKey("WEAPON_SHANK")] = 'melee',
	[GetHashKey("WEAPON_TOILETBRUSH")] = 'melee',
	[GetHashKey("WEAPON_CRUTCH")] = 'melee',
	[GetHashKey("WEAPON_GUITAR")] = 'melee',
	[GetHashKey("WEAPON_KITCHEN")] = 'melee',
	[GetHashKey("WEAPON_KASHNAR")] = 'aks',
	[GetHashKey("WEAPON_AK200")] = 'aks',
	[GetHashKey("WEAPON_AK74")] = 'aks',
	[GetHashKey("WEAPON_PQ15")] = 'aks',
	[GetHashKey("WEAPON_SIGMCX")] = 'aks',
	[GetHashKey("WEAPON_G36K")] = 'aks',
	[GetHashKey("WEAPON_MOSIN")] = 'sniperr',
	[GetHashKey("WEAPON_REMINGTON870")] = 'mosin',
	[GetHashKey("WEAPON_WINCHESTER12")] = 'mosin',
	[GetHashKey("WEAPON_GLOCK17")] = 'pistol',
	[GetHashKey("WEAPON_M1911")] = 'pistol',
	[GetHashKey("WEAPON_MAKAROV")] = 'pistol',
	[GetHashKey("WEAPON_BARRET")] = 'sniperr',
	[GetHashKey("WEAPON_SVD")] = 'sniperr',
	[GetHashKey("WEAPON_LR300")] = 'aks',
	[GetHashKey("WEAPON_BARRET50")] = 'sniperr',
	[GetHashKey("WEAPON_MSR")] = 'sniperr',
	[GetHashKey("WEAPON_SV98")] = 'sniperr',
	[GetHashKey("WEAPON_M4A1SDECIMATOR")] = 'aks',
	[GetHashKey("WEAPON_M4A1SSAGIRIR")] = 'aks',
	[GetHashKey("WEAPON_CNDYRIFLE")] = 'aks',
	[GetHashKey("WEAPON_AUG")] = 'aks',
	[GetHashKey("WEAPON_GRAU")] = 'aks',
	[GetHashKey("WEAPON_VANDAL")] = 'aks',
	[GetHashKey("WEAPON_NV4")] = 'aks',
	[GetHashKey("WEAPON_HONEYBADGER")] = 'aks',
	[GetHashKey("WEAPON_HK418")] = 'aks',
	[GetHashKey("WEAPON_SCORPBLUE")] = 'smgs',
	[GetHashKey("WEAPON_PERFORATOR")] = 'melee',
	[GetHashKey("WEAPON_GUNGIRLDEAGLE")] = 'pistol',
	[GetHashKey("WEAPON_SAKURADEAGLE")] = 'pistol',
	[GetHashKey("WEAPON_PRINTSTREAMDEAGLE")] = 'pistol',
	[GetHashKey("WEAPON_KILLCONFIRMEDDEAGLE")] = 'pistol',
	[GetHashKey("WEAPON_TINT")] = 'pistol',
	[GetHashKey("WEAPON_ASIIMOVPISTOL")] = 'pistol',
	[GetHashKey("WEAPON_VOMFEUER")] = 'pistol',
	[GetHashKey("WEAPON_MIST")] = 'melee',
	[GetHashKey("WEAPON_M4A1SSAGIRI")] = 'aks',
	[GetHashKey("WEAPON_FNX45")] = 'pistol',
	[GetHashKey("WEAPON_FINN")] = 'pistol',
	[GetHashKey("WEAPON_CARB2")] = 'aks',
	[GetHashKey("WEAPON_MIST")] = 'melee',
	[GetHashKey("WEAPON_KARAMBIT")] = 'melee',
	[GetHashKey("WEAPON_PPSH")] = 'smgs',
	[GetHashKey("WEAPON_HAHA")] = 'smgs',
	[GetHashKey("WEAPON_HOWL")] = 'aks',
	[GetHashKey("WEAPON_GDEAGLE")] = 'pistol',
	[GetHashKey("WEAPON_PICK")] = 'melee',
	[GetHashKey("WEAPON_HOBBY")] = 'melee',
	[GetHashKey("WEAPON_LIGHTSABER")] = 'melee',
	[GetHashKey("WEAPON_KATANA")] = 'melee',
	[GetHashKey("WEAPON_SPHANTOM")] = 'aks',
	[GetHashKey("WEAPON_PAINTBALL1")] = 'pistol',
	[GetHashKey("WEAPON_PAINTBALL2")] = 'pistol',
	[GetHashKey("WEAPON_TIGER")] = 'melee',
	[GetHashKey("WEAPON_LEVIATHAN")] = 'melee',
	[GetHashKey("WEAPON_ADAGGER")] = 'melee',
	[GetHashKey("WEAPON_L96")] = 'sniperr',
	[GetHashKey("WEAPON_MP7A2")] = 'smgs',
	[GetHashKey("WEAPON_M107")] = 'sniperr',
	[GetHashKey("WEAPON_M4A1SNIGHTMARE")] = 'aks',
	[GetHashKey("WEAPON_PILUM")] = 'melee',
	[GetHashKey("WEAPON_HAYMAKER")] = 'mosin',
	[GetHashKey("WEAPON_USPSTORQUE")] = 'pistol', 
	[GetHashKey("WEAPON_REAVERVANDAL")] = 'aks',
	[GetHashKey("WEAPON_M4A1")] = 'aks',
	[GetHashKey("WEAPON_SCAR")] = 'aks',
	[GetHashKey("WEAPON_MP5A2")] = 'smgs',
	[GetHashKey("WEAPON_IRONWOLF")] = 'aks',
	[GetHashKey("WEAPON_LIQUIDCARBINE")] = 'aks',
	[GetHashKey("WEAPON_M82A2")] = 'sniperr',
	[GetHashKey("WEAPON_M82A3")] = 'sniperr',
	[GetHashKey("WEAPON_GUNGNIR")] = 'sniperr',
	[GetHashKey("WEAPON_BORA")] = 'sniperr',
	[GetHashKey("WEAPON_HADDESNIPER")] = 'sniperr',
	[GetHashKey("WEAPON_M98B")] = 'sniperr',
	[GetHashKey("WEAPON_M200")] = 'sniperr',
	[GetHashKey("WEAPON_ORSIST5000")] = 'sniperr',
	[GetHashKey("WEAPON_MSR2")] = 'sniperr',
	[GetHashKey("WEAPON_STAC")] = 'sniperr',
	[GetHashKey("WEAPON_RIFLEV2")] = 'aks',
	[GetHashKey("WEAPON_VAL")] = 'aks',
	[GetHashKey("WEAPON_M4A4HYBRID")] = 'aks',
	[GetHashKey("WEAPON_M4A4FIRE")] = 'aks',
	[GetHashKey("WEAPON_NERFBLASTER")] = 'aks',
	[GetHashKey("WEAPON_MX")] = 'aks',
	[GetHashKey("WEAPON_M60")] = 'aks',
	[GetHashKey("WEAPON_USAS12")] = 'sniperr',
	[GetHashKey("WEAPON_HKV2")] = 'aks',
	[GetHashKey("WEAPON_HK416")] = 'aks',
	[GetHashKey("WEAPON_FNFAL")] = 'aks',
	[GetHashKey("WEAPON_DRAGONAK")] = 'aks',
	[GetHashKey("WEAPON_MK18")] = 'aks', 
	[GetHashKey("WEAPON_M16A4")] = 'aks',
	[GetHashKey("WEAPON_M13")] = 'aks',
	[GetHashKey("WEAPON_RAINBOWLR300")] = 'aks',
	[GetHashKey("WEAPON_ICEDRAKE")] = 'aks',
	[GetHashKey("WEAPON_M203")] = 'aks',
	[GetHashKey("WEAPON_M4FBX")] = 'aks',
	[GetHashKey("WEAPON_M4")] = 'aks',
	[GetHashKey("WEAPON_M4A4NOIR")] = 'aks',
	[GetHashKey("WEAPON_M4A1SNEONOIR")] = 'aks',
	[GetHashKey("WEAPON_M4A1SPURPLE")] = 'aks',
	[GetHashKey("WEAPON_MK18V2")] = 'aks',
	[GetHashKey("WEAPON_PRIMEVANDAL")] = 'aks',
	[GetHashKey("WEAPON_ORIGINVANDAL")] = 'aks',
	[GetHashKey("WEAPON_REDTIGER")] = 'aks',
	[GetHashKey("WEAPON_SP1")] = 'aks',
	[GetHashKey("WEAPON_M4A4RIOT")] = 'aks',
	[GetHashKey("WEAPON_M4A4RETRO")] = 'aks',
	[GetHashKey("WEAPON_XM4TIGER")] = 'aks',
	[GetHashKey("WEAPON_A")] = 'aks',
	[GetHashKey("WEAPON_DIAMONDMP5")] = 'smgs',
	[GetHashKey("WEAPON_MTARGLOWC")] = 'smgs',
	[GetHashKey("WEAPON_MP5GLOW")] = 'smgs',
	[GetHashKey("WEAPON_MP5A3")] = 'smgs',
	[GetHashKey("WEAPON_MPXC")] = 'smgs',
	[GetHashKey("WEAPON_P90")] = 'smgs',
	[GetHashKey("WEAPON_P90V2")] = 'smgs',
	[GetHashKey("WEAPON_PRIMESPECTRE")] = 'smgs',
	[GetHashKey("WEAPON_SCORPEVOE")] = 'smgs',
	[GetHashKey("WEAPON_SINGULARITYSPECTRE")] = 'smgs',
	[GetHashKey("WEAPON_T5GLOW")] = 'smgs',
	[GetHashKey("WEAPON_VSS")] = 'smgs',
	[GetHashKey("WEAPON_VESPER")] = 'smgs',
	[GetHashKey("WEAPON_VESPERHYBRID")] = 'smgs',
	[GetHashKey("WEAPON_ARESSHRIKE")] = 'aks',
	[GetHashKey("WEAPON_FNMAG")] = 'aks',
	[GetHashKey("WEAPON_M60V2")] = 'aks',
	[GetHashKey("WEAPON_MK249")] = 'aks',
	[GetHashKey("WEAPON_DEADPOOLSHOTGUN")] = 'sniperr',
	[GetHashKey("WEAPON_HAYMAKERV2")] = 'sniperr',
	[GetHashKey("WEAPON_PUMPSHOTGUNMK2")] = 'sniperr',
	[GetHashKey("WEAPON_SPAS12")] = 'sniperr',
	[GetHashKey("WEAPON_RPK16")] = 'aks',
	[GetHashKey("WEAPON_AK47KITTYREVENGE")] = 'aks',
	[GetHashKey("WEAPON_L118A1")] = 'aks',
	[GetHashKey("WEAPON_MINIMIM249")] = 'sniperr',
	[GetHashKey("WEAPON_SR25")] = 'aks',
	[GetHashKey("WEAPON_ANIMESWORD")] = 'melee',
	[GetHashKey("WEAPON_wuxiafan")] = 'melee',
	[GetHashKey("WEAPON_ANIMEMAC10")] = 'smgs',
	[GetHashKey("WEAPON_DIAMONDSWORD")] = 'melee',
	[GetHashKey("WEAPON_GLITCHPOPOPERATOR")] = 'sniperr',
	[GetHashKey("WEAPON_RE6")] = 'aks',
	[GetHashKey("WEAPON_RE6RN")] = 'aks',
	[GetHashKey("WEAPON_RE6SNIPER")] = 'sniperr',
	[GetHashKey("WEAPON_M4A4NEVA")] = 'aks',
	[GetHashKey("WEAPON_AK74UV3")] = 'aks',
	[GetHashKey("WEAPON_SR25")] = 'aks',
	[GetHashKey("WEAPON_ANIMESWORD")] = 'melee',
	[GetHashKey("WEAPON_wuxiafan")] = 'melee',
	[GetHashKey("WEAPON_ANIMEMAC10")] = 'smgs',
	[GetHashKey("WEAPON_DIAMONDSWORD")] = 'melee',
	[GetHashKey("WEAPON_ODIN")] = 'aks',
	[GetHashKey("WEAPON_BLASTXPHANTOM")] = 'aks',
	[GetHashKey("WEAPON_M4A4DRAGONKING")] = 'aks',
	[GetHashKey("WEAPON_BAL27")] = 'aks',
	[GetHashKey("WEAPON_PURPLENIKEGRAU")] = 'aks',
	[GetHashKey("WEAPON_AKCQB")] = 'aks',
	[GetHashKey("WEAPON_HEADSTONEAUG")] = 'aks',
	[GetHashKey("WEAPON_FFAR")] = 'aks',
	[GetHashKey("WEAPON_PARAFALSOULREAPER")] = 'aks',
	[GetHashKey("WEAPON_ORIGINVANDALYELLOW")] = 'aks',	
	[GetHashKey("WEAPON_ACRCQB")] = 'smgs',
	[GetHashKey("WEAPON_AK74UGOKU")] = 'smgs',
	[GetHashKey("WEAPON_M249")] = 'aks',
	[GetHashKey("WEAPON_LVOA")] = 'aks',
	[GetHashKey("WEAPON_NERFMOSIN")] = 'sniperr',
	[GetHashKey("WEAPON_VITYAZ")] = 'smgs',
	[GetHashKey("WEAPON_VTSGLOW")] = 'pistol',
	[GetHashKey("WEAPON_GLITCHPOPPHANTOM")] = 'aks',
	[GetHashKey("WEAPON_TACGLOCK19")] = 'pistol',
	[GetHashKey("WEAPON_AWPMIKU")] = 'sniperr',
	[GetHashKey("WEAPON_HKMP5K")] = 'smgs',
	[GetHashKey("WEAPON_MODEL680")] = 'sniperr',
	[GetHashKey("WEAPON_SVDK")] = 'sniperr',
	[GetHashKey("WEAPON_G28")] = 'sniperr',
	[GetHashKey("WEAPON_FIVESEVEN")] = 'pistol',
	[GetHashKey("WEAPON_SIGSAUERP226R")] = 'pistol',
	[GetHashKey("WEAPON_COLTM16A2")] = 'aks',
	[GetHashKey("WEAPON_MWUZI")] = 'smgs',
	[GetHashKey("WEAPON_FX05")] = 'aks',
	[GetHashKey("WEAPON_TX15")] = 'aks',
	[GetHashKey("WEAPON_M14")] = 'sniperr',
	[GetHashKey("WEAPON_RPD")] = 'aks',
	[GetHashKey("WEAPON_FFARAUTOTOON")] = 'aks',
	[GetHashKey("WEAPON_SIG")] = 'smgs',
	[GetHashKey("WEAPON_GSCYTHE")] = 'melee',
	[GetHashKey("WEAPON_PK470")] = 'aks',
	[GetHashKey("WEAPON_IBAK")] = 'aks',
	[GetHashKey("WEAPON_ODINX")] = 'aks',
	[GetHashKey("WEAPON_HBRA3")] = 'aks',
	[GetHashKey("WEAPON_AN94")] = 'aks',
	[GetHashKey("WEAPON_HKMG4")] = 'aks',
	[GetHashKey("WEAPON_S75")] = 'sniperr',
	[GetHashKey("WEAPON_M77")] = 'sniperr',
	[GetHashKey("WEAPON_AR160")] = 'aks',
	[GetHashKey("WEAPON_M40A3")] = 'sniperr',
	[GetHashKey("WEAPON_ELDERVANDAL")] = 'aks',
	[GetHashKey("WEAPON_RGXVANDAL")] = 'aks',
	[GetHashKey("WEAPON_REAVEROPERATOR")] = 'sniperr',
	[GetHashKey("WEAPON_WARHEAD")] = 'sniperr',
	[GetHashKey("WEAPON_WARHEADAR")] = 'aks',
	[GetHashKey("WEAPON_STAC")] = 'sniperr',
	[GetHashKey("WEAPON_PHAN")] = 'aks',
	[GetHashKey("WEAPON_SOLBLUE")] = 'aks',
	[GetHashKey("WEAPON_HAWKM4")] = 'aks',
	[GetHashKey("WEAPON_REAVERVANDALWHITE")] = 'aks',
	[GetHashKey("WEAPON_M249PLAYMAKER")] = 'aks',
	[GetHashKey("WEAPON_XM177 ")] = 'aks',
	[GetHashKey("WEAPON_MK18CQBR")] = 'aks',
	[GetHashKey("WEAPON_M16A2")] = 'aks',
	[GetHashKey("WEAPON_MK18V2")] = 'aks',
	[GetHashKey("WEAPON_DEAGLE")] = 'pistol',
	[GetHashKey("WEAPON_IMPULSEAK47")] = 'aks',
	[GetHashKey("WEAPON_SAIGRY")] = 'aks',
	[GetHashKey("WEAPON_GLOWAUG")] = 'aks',
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
AddEventHandler('KillFeed:AnnounceKill', function(killed, killer, weapon, coords, killergroup, killedgroup, Distance)
	if feedActive then
		if coords ~= nil and config.prox_enabled then
			local myLocation = GetEntityCoords(GetPlayerPed(PlayerId()))
			if #(myLocation - coords) < config.prox_range then
				if not toggledfk then
					SendNUIMessage({
						type = 'newKill',
						killer = killer,
						killed = killed,
						weapon = weapon,
						killergroup = killergroup,
						killedgroup = killedgroup,
						container = "killContainer",
						distance = "", 
					})
				end
			end
		else
			--if killed == GetPlayerName(GetPlayerFromServerId(PlayerId())) or killer == GetPlayerName(GetPlayerFromServerId(PlayerId())) then
			if killed == GetPlayerName(PlayerId()) or killer == GetPlayerName(PlayerId()) then
				container = "selfkillcontainer"
			else
				container = "killContainer"
			end
			--print(Distance)
			local Distance1 = ""
			if toggledkfdistance then
				Distance1 = " ["..round(Distance).. "m]"
			else
				Distance1 = ""
			end

			if not toggledfk then
				SendNUIMessage({
					type = 'newKill',
					killer = killer,
					killed = killed,
					weapon = weapon,
					killergroup = killergroup,
					killedgroup = killedgroup,
					container = container,
					distance = Distance1, 
				})
			end
		end
	end
end)

function round(number)
    local _, decimals = math.modf(number)
    if decimals < 0.5 then return math.floor(number) end
    return math.ceil(number)
end

RegisterNetEvent('KillFeed:AnnounceDeath')
AddEventHandler('KillFeed:AnnounceDeath', function(killed, coords, group)
	if feedActive then
		local container = "killContainer"
		if coords ~= nil and config.prox_enabled then
			local myLocation = GetEntityCoords(GetPlayerPed(PlayerId()))
			if #(myLocation - coords) < config.prox_range then
				if not toggledfk then
					SendNUIMessage({
						type = 'newDeath',
						killed = killed,
						group = group,
						container = "killContainer",
					})
				end
			end
		else
			--if killed == GetPlayerName(GetPlayerFromServerId(PlayerId())) then
			if killed == GetPlayerName(PlayerId()) then
				container = "selfkillcontainer"
			else
				container = "killContainer"
			end
			if not toggledfk then
				SendNUIMessage({
					type = 'newDeath',
					killed = killed,
					group = group,
					container = container,
				})
			end
		end
	end
end)

RegisterNetEvent('Vrxith:Settings:Killfeed')
AddEventHandler('Vrxith:Settings:Killfeed', function(bool)
	toggledfk = bool

	if toggledfk then
    	--Notify("~y~Killfeed is now hidden.")
		TriggerEvent("Vrxith:Settings:Reset", "Killfeed", toggledfk)
	else
		--Notify("~y~Killfeed is now visible.")
		TriggerEvent("Vrxith:Settings:Reset", "Killfeed", toggledfk)
	end
end)

RegisterNetEvent('Vrxith:Settings:KillfeedDistance')
AddEventHandler('Vrxith:Settings:KillfeedDistance', function(bool)
	toggledkfdistance = bool
	if toggledkfdistance then
    	--Notify("~y~Killfeed Distance is now hidden.")
		TriggerEvent("Vrxith:Settings:Reset", "KillfeedDistance", toggledkfdistance)
	else
		--Notify("~y~Killfeed Distance is now visible.")
		TriggerEvent("Vrxith:Settings:Reset", "KillfeedDistance", toggledkfdistance)
	end
end)


function hashToWeapon(hash)
	if weapons[hash] ~= nil then
		return weapons[hash]
	else
		return 'weapon_unarmed'
	end
end

function AQUANotify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end