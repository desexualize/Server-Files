local DetectableTextures = {
    {txd = "HydroMenu", txt = "HydroMenuHeader", name = "HydroMenu"},
    {txd = "John", txt = "John2", name = "SugarMenu"},
    {txd = "darkside", txt = "logo", name = "Darkside"},
    {txd = "ISMMENU", txt = "ISMMENUHeader", name = "ISMMENU"},
    {txd = "dopatest", txt = "duiTex", name = "Copypaste Menu"},
    {txd = "fm", txt = "menu_bg", name = "Fallout Menu"},
    {txd = "wave", txt = "logo", name ="Wave"},
    {txd = "wave1", txt = "logo1", name = "Wave (alt.)"},
    {txd = "meow2", txt = "woof2", name ="Alokas66", x = 1000, y = 1000},
    {txd = "adb831a7fdd83d_Guest_d1e2a309ce7591dff86", txt = "adb831a7fdd83d_Guest_d1e2a309ce7591dff8Header6", name ="Guest Menu"},
    {txd = "hugev_gif_DSGUHSDGISDG", txt = "duiTex_DSIOGJSDG", name="HugeV Menu"},
    {txd = "MM", txt = "menu_bg", name="Metrix Mehtods"},
    {txd = "wm", txt = "wm2", name="WM Menu"},
    {txd = "NeekerMan", txt="NeekerMan1", name="Lumia Menu"},
    {txd = "Blood-X", txt="Blood-X", name="Blood-X Menu"},
    {txd = "Dopamine", txt="Dopameme", name="Dopamine Menu"},
    {txd = "Fallout", txt="FalloutMenu", name="Fallout Menu"},
    {txd = "Luxmenu", txt="Lux meme", name="LuxMenu"},
    {txd = "Reaper", txt="reaper", name="Reaper Menu"},
    {txd = "absoluteeulen", txt="Absolut", name="Absolut Menu"},
    {txd = "KekHack", txt="kekhack", name="KekHack Menu"},
    {txd = "Maestro", txt="maestro", name="Maestro Menu"},
    {txd = "SkidMenu", txt="skidmenu", name="Skid Menu"},
    {txd = "Brutan", txt="brutan", name="Brutan Menu"},
    {txd = "FiveSense", txt="fivesense", name="Fivesense Menu"},
    {txd = "NeekerMan", txt="NeekerMan1", name="Lumia Menu"},
    {txd = "Auttaja", txt="auttaja", name="Auttaja Menu"},
    {txd = "BartowMenu", txt="bartowmenu", name="Bartow Menu"},
    {txd = "Hoax", txt="hoaxmenu", name="Hoax Menu"},
    {txd = "FendinX", txt="fendin", name="Fendinx Menu"},
    {txd = "Hammenu", txt="Ham", name="Ham Menu"},
    {txd = "Lynxmenu", txt="Lynx", name="Lynx Menu"},
    {txd = "Oblivious", txt="oblivious", name="Oblivious Menu"},
    {txd = "malossimenuv", txt="malossimenu", name="Malossi Menu"},
    {txd = "memeeee", txt="Memeeee", name="Memeeee Menu"},
    {txd = "tiago", txt="Tiago", name="Tiago Menu"},
    {txd = "Hydramenu", txt="hydramenu", name="Hydra Menu"},
    {txd = "dopamine", txt="Swagamine", name="Dopamine"},
    {txd = "HydroMenu", txt="HydroMenuHeader", name="Hydro Menu"},
    {txd = "HydroMenu", txt="HydroMenuLogo", name="Hydro Menu"},
    {txd = "HydroMenu", txt="https://i.ibb.co/0GhPPL7/Hydro-New-Header.png", name="Hydro Menu"},
    {txd = "test", txt="Terror Menu", name="Terror Menu"},
    {txd = "lynxmenu", txt="lynxmenu", name="Lynx Menu"},
    {txd = "Maestro 2.3", txt="Maestro 2.3", name="Maestro Menu"},
    {txd = "ALIEN MENU", txt="ALIEN MENU", name="Alien Menu"},
    {txd = "~u~⚡️ALIEN MENU⚡️", txt="~u~⚡️ALIEN MENU⚡️", name="Alien Menu"}
}

Citizen.CreateThread(function()   -- No-Clip Thread this then goes to the server side and Bans.
    Wait(1000)
    local oldPos = GetEntityCoords(PlayerPedId())
    while true do
        local playerPed = PlayerPedId()
        local newPos = GetEntityCoords(playerPed)

        local dist = #(oldPos-newPos)
        oldPos = newPos
        if dist > 6 and not IsPedFalling(playerPed) and not IsPedInParachuteFreeFall(playerPed) then
            if not IsPedInAnyVehicle(playerPed, 1) then
                speedWarnings = speedWarnings + 1
                if speedWarnings > 20 then
                    TriggerServerEvent("ERPAC:Type1")
                    speedWarnings = 0
                end
            end
        end
        Wait(100)
    end
end)

Citizen.CreateThread(function()
    while true do
        speedWarnings = 0
        Wait(60000)
    end
end)
-- No-Clip

WeaponBL={
	"WEAPON_BAT",
	"WEAPON_MACHETE",
	"WEAPON_SWITCHBLADE",
	"WEAPON_POOLCUE",
	"WEAPON_DAGGER",
	"WEAPON_CROWBAR",
	"WEAPON_KNIFE",
	"WEAPON_KNUCKLE", 
	"WEAPON_HAMMER", 
	"WEAPON_GOLFCLUB",
	"WEAPON_BOTTLE", 
	"WEAPON_HATCHET", 
	"WEAPON_PROXMINE", 
	"WEAPON_BZGAS", 
	"WEAPON_SMOKEGRENADE", 
	"WEAPON_MOLOTOV", 
	"WEAPON_FIREEXTINGUISHER", 
	"WEAPON_HAZARDCAN", 
	"WEAPON_SNOWBALL", 
	"WEAPON_FLARE", 
	"WEAPON_BALL", 
	"WEAPON_REVOLVER", 
	"WEAPON_PIPEWRENCH",
	"WEAPON_PISTOL", 
	"WEAPON_PISTOL_MK2", 
	"WEAPON_COMBATPISTOL", 
	"WEAPON_APPISTOL",  
	"WEAPON_SNSPISTOL", 
	"WEAPON_HEAVYPISTOL", 
	"WEAPON_VINTAGEPISTOL", 
	"WEAPON_FLAREGUN",
	"WEAPON_MARKSMANPISTOL", 
	"WEAPON_MICROSMG", 
	"WEAPON_MINISMG", 
	"WEAPON_SMG",
	"WEAPON_SMG_MK2", 
	"WEAPON_ASSAULTSMG", 
	"WEAPON_MG",
	"WEAPON_COMBATMG",
	"WEAPON_COMBATMG_MK2",
	"WEAPON_COMBATPDW",
	"WEAPON_GUSENBERG", 
	"WEAPON_MACHINEPISTOL",
	"WEAPON_ASSAULTRIFLE", 
	"WEAPON_ASSAULTRIFLE_MK2", 
	"WEAPON_CARBINERIFLE", 
	"WEAPON_CARBINERIFLE_MK2", 
	"WEAPON_ADVANCEDRIFLE", 
	"WEAPON_SPECIALCARBINE",
	"WEAPON_BULLPUPRIFLE", 
	"WEAPON_COMPACTRIFLE",
	"WEAPON_PUMPSHOTGUN", 
	"WEAPON_SWEEPERSHOTGUN",
	"WEAPON_SAWNOFFSHOTGUN", 
	"WEAPON_BULLPUPSHOTGUN", 
	"WEAPON_ASSAULTSHOTGUN",  
	"WEAPON_HEAVYSHOTGUN", 
	"WEAPON_DBSHOTGUN", 
	"WEAPON_SNIPERRIFLE", 
	"WEAPON_HEAVYSNIPER", 
	"WEAPON_HEAVYSNIPER_MK2", 
	"WEAPON_MARKSMANRIFLE", 
	"WEAPON_GRENADELAUNCHER", 
	"WEAPON_GRENADELAUNCHER_SMOKE", 
	"WEAPON_RPG", 
	"WEAPON_MINIGUN", 
	"WEAPON_FIREWORK", 
	"WEAPON_RAILGUN", 
	"WEAPON_HOMINGLAUNCHER", 
	"WEAPON_GRENADE", 
	"WEAPON_STICKYBOMB", 
	"WEAPON_COMPACTLAUNCHER", 
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_REVOLVER_MK2", 
	"WEAPON_DOUBLEACTION",
	"WEAPON_SPECIALCARBINE_MK2", 
	"WEAPON_BULLPUPRIFLE_MK2",
	"WEAPON_PUMPSHOTGUN_MK2",
	"WEAPON_MARKSMANRIFLE_MK2", 
	"WEAPON_RAYPISTOL", 
	"WEAPON_RAYCARBINE", 
	"WEAPON_RAYMINIGUN",
	"WEAPON_DIGISCANNER", 
	"WEAPON_NAVYREVOLVER", 
	"WEAPON_CERAMICPISTOL", 
	"WEAPON_STONE_HATCHET",
	"WEAPON_PIPEBOMB", 
	"WEAPON_PASSENGER_ROCKET",
	"WEAPON_MUSKET",
}

Citizen.CreateThread(function()
		while true do
		Citizen.Wait(500)
		for _,theWeapon in ipairs(WeaponBL) do
			Wait(1)
			if HasPedGotWeapon(PlayerPedId(),GetHashKey(theWeapon),false) == 1 then
			RemoveAllPedWeapons(PlayerPedId(),false)
			TriggerServerEvent("ERPAC:Type2", theWeapon )
			end
		end
		end
	end)
-- Weapon
Citizen.CreateThread(function()
    while true do 
        Wait(250)
        local PlayerPed = PlayerPedId()
        local Player = PlayerId()
        local Armour = GetPedArmour(PlayerPed)
        local Health = GetEntityHealth(PlayerPed)
        local Coords = GetEntityCoords(PlayerPed)
        local Invisible = IsEntityVisible(PlayerPed)
        local godmoding = GetPlayerInvincible_2(Player)
        local ammo = GetAmmoInPedWeapon(PlayerPed, GetSelectedPedWeapon(PlayerPed))
        local _, infiniteroll = StatGetInt(GetHashKey("mp0_shooting_ability"), true)

            if infiniteroll > 100 then
                TriggerServerEvent("ERPAC:Type8")  
                break;
            end

            if IsPedShooting(PlayerPed) and ammo == 250 and not HasPedGotWeapon(PlayerPedId(),GetHashKey("WEAPON_STUNGUN"),false) then
                RemoveAllPedWeapons(PlayerPedId(), false)
                TriggerServerEvent("ERPAC:Type5")  
                break;
            end

            if ammo > 250 and not HasPedGotWeapon(PlayerPedId(),GetHashKey("WEAPON_STUNGUN"),false) and not HasPedGotWeapon(PlayerPedId(),-1569615261,false) then
                RemoveAllPedWeapons(PlayerPedId(), false)
                TriggerServerEvent("ERPAC:Type6")
                break;
            end
			-- -1569615261
            -- if godmoding == 1 then
            --     TriggerServerEvent("ERPAC:Type7")  
            -- break;
        --end
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2000)

		for i, data in pairs(DetectableTextures) do
			if data.x and data.y then
				if GetTextureResolution(data.txd, data.txt).x == data.x and GetTextureResolution(data.txd, data.txt).y == data.y then
					TriggerServerEvent("ERPAC:Type10", "Lua Menu detected: " ..data.name)
				end
			else 
				if GetTextureResolution(data.txd, data.txt).x ~= 4.0 then
					TriggerServerEvent("ERPAC:Type10", "Lua Menu detected: " ..data.name)
				end
			end
		end
	end
end)

