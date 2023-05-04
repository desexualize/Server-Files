Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

vRPhk = {}
Tunnel.bindInterface("vrp_hotkeys",vRPhk)
vRPserver = Tunnel.getInterface("vRP","vrp_hotkeys")
HKserver = Tunnel.getInterface("vrp_hotkeys","vrp_hotkeys")
vRP = Proxy.getInterface("vRP")
function tvRP.varyHealth(variation)
  local ped = GetPlayerPed(-1)
if variation == 200 then 
  TriggerEvent("Element:FixClient",ped)
  return
end
  local n = math.floor(GetEntityHealth(ped)+variation)
  SetEntityHealth(ped,n)
end

function tvRP.setArmour2(armour)
    Wait(3750)
    SetPedArmour(PlayerPedId(), armour)
end

function tvRP.getHealth()
  return GetEntityHealth(GetPlayerPed(-1))
end

function tvRP.setHealth(health)
  local n = math.floor(health)
  SetEntityHealth(GetPlayerPed(-1),n)
end

function tvRP.setFriendlyFire(flag)
  NetworkSetFriendlyFireOption(flag)
  SetCanAttackFriendly(GetPlayerPed(-1), flag, flag)
end




function anim(entity, dict, anim)
  RequestAnimDict(dict)
  while not HasAnimDictLoaded(dict) do
      Citizen.Wait(10)
  end
  TaskPlayAnim(entity, dict, anim, 4.0, -4.0, -1, 2, 4.0, 0, 0, 0)
end




local comaAnim = {}
local in_coma = false
local coma_left = 30
local secondsTilBleedout = 30
local playerCanRespawn = false 
local deathString = ""
local deathPosition

-- MAIN THREAD
RegisterNetEvent('random:animacion')
AddEventHandler('random:animacion', function()

  local ped = PlayerPedId()
  local animacionrandom  = math.random(1,50)
  local playerPed  = GetPlayerPed(-1)

	  loadanimdict('combat@damage@writhe')
	  loadanimdict('combat@damage@writheidle_a')
	  loadanimdict('combat@damage@writheidle_b')
	  loadanimdict('combat@damage@writheidle_c')
	  loadanimdict('combat@damage@rb_writhe')

  local lib1,anim1 ='combat@damage@writhe','writhe_loop'           --2500
  local lib2,anim2 ='combat@damage@writheidle_a','writhe_idle_a'   --13000
  local lib3,anim3 ='combat@damage@writheidle_b','writhe_idle_e'   --11166
  local lib4,anim4 ='combat@damage@writheidle_c','writhe_idle_g'   --8666
  local lib5,anim5 ='combat@damage@rb_writhe' ,'rb_writhe_loop'    --6500

		if animacionrandom  <= 10 then
		     TaskPlayAnim(playerPed,lib1,anim1, 8.0, 8.0, -1, 33, 0, 0, 0, 0)    

			elseif animacionrandom > 10 and  animacionrandom <= 20 then
			    TaskPlayAnim(playerPed,lib2,anim2, 8.0, 8.0, -1, 33, 0, 0, 0, 0)   

			elseif animacionrandom > 20 and  animacionrandom <= 30 then
			    TaskPlayAnim(playerPed,lib3,anim3, 8.0, 8.0, -1, 33, 0, 0, 0, 0)    

			elseif animacionrandom > 530 and  animacionrandom <= 40 then
			    TaskPlayAnim(playerPed,lib4,anim4, 8.0, 8.0, -1, 33, 0, 0, 0, 0)    

			elseif animacionrandom > 40 and  animacionrandom <= 50 then
			    TaskPlayAnim(playerPed,lib5,anim5, 8.0, 8.0, -1, 33, 0, 0, 0, 0)   
                
		end

end)

local comaAnim = {}
local in_coma = false
local coma_left = 500
local secondsTilBleedout = 30
local playerCanRespawn = false 
local deathString = ""
local deathPosition

Citizen.CreateThread(function()
  while true do 
    if IsDisabledControlJustPressed(0,38) then
      if playerCanRespawn and in_coma and secondsTilBleedout < 2 then
        tvRP.respawnPlayer()
      end
      Wait(1000)
    end
    Wait(0)
  end
end)

Citizen.CreateThread(function() -- coma thread
    Wait(500)
    exports.spawnmanager:setAutoSpawn(false)
    while true do
        Wait(0)
        local ped = GetPlayerPed(-1)
        local health = GetEntityHealth(ped)
        if IsEntityDead(GetPlayerPed(-1)) and not in_coma then --Wait for death check
            pbCounter = 100
            local plyCoords = GetEntityCoords(GetPlayerPed(-1),true)
        
            tvRP.ejectVehicle()
            in_coma = true
            deathPosition = plyCoords
            local x,y,z = table.unpack(deathPosition)
            vRPserver.updatePos({x,y,z})
            vRPserver.updateHealth({0})
            vRPserver.Coma()
            vRPserver.StoreWeaponsDead()
       
            TriggerServerEvent('vRP:InComa')
            TriggerEvent('vRP:IsInMoneyComa', true)
            vRPserver.MoneyDrop()

            Wait(250) 
        end

        if health > cfg.coma_threshold and in_coma then --Revive check
            if IsEntityDead(GetPlayerPed(-1)) then
                local x,y,z = tvRP.getPosition()
                NetworkResurrectLocalPlayer(x, y, z, GetEntityHeading(GetPlayerPed(-1)), true, true, false)
                Wait(0)
            end
        
            playerCanRespawn = false 
            DeathString = ""
            tvRP.disableComa()

            SetEntityInvincible(GetPlayerPed(-1),false, 0)
            ClearPedSecondaryTask(GetPlayerPed(-1))
            Citizen.CreateThread(function()
                Wait(500)
                ClearPedSecondaryTask(GetPlayerPed(-1))
                ClearPedTasks(GetPlayerPed(-1))
            end)    
        end 

        local health = GetEntityHealth(GetPlayerPed(-1))
        if health <= cfg.coma_threshold and not in_coma then 
            SetEntityHealth(GetPlayerPed(-1),0)
            
        end
    end
end)


Citizen.CreateThread(function()
    while true do 
        if in_coma then
            else
                playerCanRespawn = true    
        end
        Wait(0)
    end 
end)

Citizen.CreateThread(function()
    while true do 
        if in_coma then
            secondsTilBleedout = secondsTilBleedout - 1
        end
        Wait(1000)
    end
end) 


function DrawAdvancedTextt(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    
    SetTextEdge(1, 0, 0, 0, 255)
    
    
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end
function tvRP.respawnPlayer()
    
    exports.spawnmanager:spawnPlayer()
    playerCanRespawn = false 
    DeathString = ""
    secondsTilBleedout = 30
    
    local ped = GetPlayerPed(-1)
    tvRP.reviveComa()
end

function tvRP.disableComa()
    in_coma = false
end

function tvRP.isInComa()
    return in_coma
end

RegisterNetEvent("Element:FixClient")
AddEventHandler("Element:FixClient", function()
    local resurrectspamm = true
    Citizen.CreateThread(function()
        while true do 
            Wait(0)
            if resurrectspamm == true then 
                local ped = PlayerPedId()
                local x,y,z = GetEntityCoords(ped)
                respawnedrecent = false 
                NetworkResurrectLocalPlayer(x, y, z, true, true, false)
                Citizen.Wait(0)
                ClearPedTasksImmediately(PlayerPedId())
                resurrectspamm = false
                in_coma = false
                EnableControlAction(0, 73, true)
                tvRP.stopScreenEffect(cfg.coma_effect)
            end 
        end
    end)
end)

function tvRP.reviveComa()
    local ped = GetPlayerPed(-1)
    tvRP.setRagdoll(false)
    tvRP.stopScreenEffect(cfg.coma_effect)
    SetEntityHealth(GetPlayerPed(-1), 200) 
end

-- kill the player if in coma
function tvRP.killComa()
    if in_coma then
        coma_left = 0
    end
end

Citizen.CreateThread(function() -- disable health regen, conflicts with coma system
    while true do
        SetPlayerHealthRechargeMultiplier(PlayerId(), 1.0)
        Wait(0)
    end
end)


Citizen.CreateThread(function()
    local DeathReason, Killer, DeathCauseHash, Weapon

    while true do
        Citizen.Wait(0)
        if IsEntityDead(PlayerPedId()) then
            Citizen.Wait(500)
            local PedKiller = GetPedSourceOfDeath(PlayerPedId())
            DeathCauseHash = GetPedCauseOfDeath(PlayerPedId())
            Weapon = WeaponNames[tostring(DeathCauseHash)]

            if IsEntityAPed(PedKiller) and IsPedAPlayer(PedKiller) then
                Killer = NetworkGetPlayerIndexFromPed(PedKiller)
            elseif IsEntityAVehicle(PedKiller) and IsEntityAPed(GetPedInVehicleSeat(PedKiller, -1)) and IsPedAPlayer(GetPedInVehicleSeat(PedKiller, -1)) then
                Killer = NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(PedKiller, -1))
            end
            
            if (Killer == PlayerId()) then
                DeathReason = 'committed suicide'
            elseif (Killer == nil) then
                DeathReason = 'died'
            else
                if IsMelee(DeathCauseHash) then
                    DeathReason = 'murdered'
                elseif IsTorch(DeathCauseHash) then
                    DeathReason = 'torched'
                elseif IsKnife(DeathCauseHash) then
                    DeathReason = 'knifed'
                elseif IsPistol(DeathCauseHash) then
                    DeathReason = 'pistoled'
                elseif IsSub(DeathCauseHash) then
                    DeathReason = 'riddled'
                elseif IsRifle(DeathCauseHash) then
                    DeathReason = 'rifled'
                elseif IsLight(DeathCauseHash) then
                    DeathReason = 'machine gunned'
                elseif IsShotgun(DeathCauseHash) then
                    DeathReason = 'pulverized'
                elseif IsSniper(DeathCauseHash) then
                    DeathReason = 'sniped'
                elseif IsHeavy(DeathCauseHash) then
                    DeathReason = 'obliterated'
                elseif IsMinigun(DeathCauseHash) then
                    DeathReason = 'shredded'
                elseif IsBomb(DeathCauseHash) then
                    DeathReason = 'bombed'
                elseif IsVeh(DeathCauseHash) then
                    DeathReason = 'mowed over'
                elseif IsVK(DeathCauseHash) then
                    DeathReason = 'flattened'
                else
                    DeathReason = 'killed'
                end
            end
            
            if DeathReason == 'committed suicide' or DeathReason == 'died' then
                DeathString = string.upper("You committed suicide")
            else
                DeathString = string.upper("You were " .. DeathReason .. " by " .. GetPlayerName(Killer) .. " with a " .. tostring(Weapon))
            end
            Killer = nil
            DeathReason = nil
            DeathCauseHash = nil
            Weapon = nil
        end
        while IsEntityDead(PlayerPedId()) do
            Citizen.Wait(0)
        end
    end
end)

function IsMelee(Weapon)
    local Weapons = {'WEAPON_UNARMED', 'WEAPON_CROWBAR', 'WEAPON_BAT', 'WEAPON_GOLFCLUB', 'WEAPON_HAMMER', 'WEAPON_NIGHTSTICK'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsTorch(Weapon)
    local Weapons = {'WEAPON_MOLOTOV'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsKnife(Weapon)
    local Weapons = {'WEAPON_DAGGER', 'WEAPON_KNIFE', 'WEAPON_SWITCHBLADE', 'WEAPON_HATCHET', 'WEAPON_BOTTLE', 'WEAPON_AXE', 'WEAPON_BASEBALLBAT', 'WEAPON_BROOM', 'WEAPON_DIAMONDSWORD', 'WEAPON_SHANK', 'WEAPON_SHOVEL'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsPistol(Weapon)
    local Weapons = {'WEAPON_SNSPISTOL', 'WEAPON_HEAVYPISTOL', 'WEAPON_VINTAGEPISTOL', 'WEAPON_PISTOL', 'WEAPON_APPISTOL', 'WEAPON_COMBATPISTOL', 'WEAPON_M1911', 'WEAPON_REVOLVER357', 'WEAPON_ROOK'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsSub(Weapon)
    local Weapons = {'WEAPON_MICROSMG', 'WEAPON_SMG', 'WEAPON_UZI', 'WEAPON_UMP45'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsRifle(Weapon)
    local Weapons = {'WEAPON_AK200', 'WEAPON_MOSIN', 'WEAPON_SCARL', 'WEAPON_CARBINERIFLE', 'WEAPON_MUSKET', 'WEAPON_ADVANCEDRIFLE', 'WEAPON_ASSAULTRIFLE', 'WEAPON_SPECIALCARBINE', 'WEAPON_COMPACTRIFLE', 'WEAPON_BULLPUPRIFLE', 'WEAPON_AK47', 'WEAPON_AK47KASHNAR', 'WEAPON_M4A1', 'WEAPON_SPAR16', 'WEAPON_SVD'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsLight(Weapon)
    local Weapons = {'WEAPON_MG', 'WEAPON_COMBATMG'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsShotgun(Weapon)
    local Weapons = {'WEAPON_BULLPUPSHOTGUN', 'WEAPON_ASSAULTSHOTGUN', 'WEAPON_DBSHOTGUN', 'WEAPON_PUMPSHOTGUN', 'WEAPON_HEAVYSHOTGUN', 'WEAPON_SAWNOFFSHOTGUN', 'WEAPON_WINCHESTER12'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsSniper(Weapon)
    local Weapons = {'WEAPON_MARKSMANRIFLE', 'WEAPON_SNIPERRIFLE', 'WEAPON_HEAVYSNIPER', 'WEAPON_ASSAULTSNIPER', 'WEAPON_REMOTESNIPER'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsHeavy(Weapon)
    local Weapons = {'WEAPON_GRENADELAUNCHER', 'WEAPON_RPG', 'WEAPON_FLAREGUN', 'WEAPON_HOMINGLAUNCHER', 'WEAPON_FIREWORK', 'VEHICLE_WEAPON_TANK'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsMinigun(Weapon)
    local Weapons = {'WEAPON_MINIGUN'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsBomb(Weapon)
    local Weapons = {'WEAPON_GRENADE', 'WEAPON_PROXMINE', 'WEAPON_EXPLOSION', 'WEAPON_STICKYBOMB'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsVeh(Weapon)
    local Weapons = {'VEHICLE_WEAPON_ROTORS'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsVK(Weapon)
    local Weapons = {'WEAPON_RUN_OVER_BY_CAR', 'WEAPON_RAMMED_BY_CAR'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end


WeaponNames = {
    [tostring(GetHashKey('WEAPON_UNARMED'))] = 'Fists',
    [tostring(GetHashKey('WEAPON_KNIFE'))] = 'Knife',
    [tostring(GetHashKey('WEAPON_NIGHTSTICK'))] = 'Nightstick',
    [tostring(GetHashKey('WEAPON_HAMMER'))] = 'Hammer',
    [tostring(GetHashKey('WEAPON_BAT'))] = 'Baseball Bat',
    [tostring(GetHashKey('WEAPON_GOLFCLUB'))] = 'Golf Club',
    [tostring(GetHashKey('WEAPON_CROWBAR'))] = 'Crowbar',
    [tostring(GetHashKey('WEAPON_PISTOL'))] = 'Pistol',
    [tostring(GetHashKey('WEAPON_COMBATPISTOL'))] = 'Combat Pistol',
    [tostring(GetHashKey('WEAPON_APPISTOL'))] = 'AP Pistol',
    [tostring(GetHashKey('WEAPON_PISTOL50'))] = 'Pistol .50',
    [tostring(GetHashKey('WEAPON_MICROSMG'))] = 'Micro SMG',
    [tostring(GetHashKey('WEAPON_SMG'))] = 'SMG',
    [tostring(GetHashKey('WEAPON_ASSAULTSMG'))] = 'Assault SMG',
    [tostring(GetHashKey('WEAPON_ASSAULTRIFLE'))] = 'Assault Rifle',
    [tostring(GetHashKey('WEAPON_CARBINERIFLE'))] = 'Carbine Rifle',
    [tostring(GetHashKey('WEAPON_ADVANCEDRIFLE'))] = 'Advanced Rifle',
    [tostring(GetHashKey('WEAPON_MG'))] = 'MG',
    [tostring(GetHashKey('WEAPON_COMBATMG'))] = 'Combat MG',
    [tostring(GetHashKey('WEAPON_PUMPSHOTGUN'))] = 'Pump Shotgun',
    [tostring(GetHashKey('WEAPON_SAWNOFFSHOTGUN'))] = 'Sawed-Off Shotgun',
    [tostring(GetHashKey('WEAPON_ASSAULTSHOTGUN'))] = 'Assault Shotgun',
    [tostring(GetHashKey('WEAPON_BULLPUPSHOTGUN'))] = 'Bullpup Shotgun',
    [tostring(GetHashKey('WEAPON_SNIPERRIFLE'))] = 'Sniper Rifle',
    [tostring(GetHashKey('WEAPON_HEAVYSNIPER'))] = 'Heavy Sniper',
    [tostring(GetHashKey('WEAPON_REMOTESNIPER'))] = 'Remote Sniper',
    [tostring(GetHashKey('WEAPON_GRENADELAUNCHER'))] = 'Grenade Launcher',
    [tostring(GetHashKey('WEAPON_GRENADELAUNCHER_SMOKE'))] = 'Smoke Grenade Launcher',
    [tostring(GetHashKey('WEAPON_RPG'))] = 'RPG',
    [tostring(GetHashKey('WEAPON_PASSENGER_ROCKET'))] = 'Passenger Rocket',
    [tostring(GetHashKey('WEAPON_AIRSTRIKE_ROCKET'))] = 'Airstrike Rocket',
    [tostring(GetHashKey('WEAPON_STINGER'))] = 'Stinger [Vehicle]',
    [tostring(GetHashKey('WEAPON_MINIGUN'))] = 'Minigun',
    [tostring(GetHashKey('WEAPON_GRENADE'))] = 'Grenade',
    [tostring(GetHashKey('WEAPON_STICKYBOMB'))] = 'Sticky Bomb',
    [tostring(GetHashKey('WEAPON_SMOKEGRENADE'))] = 'Tear Gas',
    [tostring(GetHashKey('WEAPON_BZGAS'))] = 'BZ Gas',
    [tostring(GetHashKey('WEAPON_MOLOTOV'))] = 'Molotov',
    [tostring(GetHashKey('WEAPON_FIREEXTINGUISHER'))] = 'Fire Extinguisher',
    [tostring(GetHashKey('WEAPON_PETROLCAN'))] = 'Jerry Can',
    [tostring(GetHashKey('OBJECT'))] = 'Object',
    [tostring(GetHashKey('WEAPON_BALL'))] = 'Ball',
    [tostring(GetHashKey('WEAPON_FLARE'))] = 'Flare',
    [tostring(GetHashKey('VEHICLE_WEAPON_TANK'))] = 'Tank Cannon',
    [tostring(GetHashKey('VEHICLE_WEAPON_SPACE_ROCKET'))] = 'Rockets',
    [tostring(GetHashKey('VEHICLE_WEAPON_PLAYER_LASER'))] = 'Laser',
    [tostring(GetHashKey('AMMO_RPG'))] = 'Rocket',
    [tostring(GetHashKey('AMMO_TANK'))] = 'Tank',
    [tostring(GetHashKey('AMMO_SPACE_ROCKET'))] = 'Rocket',
    [tostring(GetHashKey('AMMO_PLAYER_LASER'))] = 'Laser',
    [tostring(GetHashKey('AMMO_ENEMY_LASER'))] = 'Laser',
    [tostring(GetHashKey('WEAPON_RAMMED_BY_CAR'))] = 'Rammed by Car',
    [tostring(GetHashKey('WEAPON_BOTTLE'))] = 'Bottle',
    [tostring(GetHashKey('WEAPON_GUSENBERG'))] = 'Gusenberg Sweeper',
    [tostring(GetHashKey('WEAPON_SNSPISTOL'))] = 'SNS Pistol',
    [tostring(GetHashKey('WEAPON_VINTAGEPISTOL'))] = 'Vintage Pistol',
    [tostring(GetHashKey('WEAPON_FLAREGUN'))] = 'Flare Gun',
    [tostring(GetHashKey('WEAPON_HEAVYPISTOL'))] = 'Heavy Pistol',
    [tostring(GetHashKey('WEAPON_SPECIALCARBINE'))] = 'Special Carbine',
    [tostring(GetHashKey('WEAPON_MUSKET'))] = 'Musket',
    [tostring(GetHashKey('WEAPON_FIREWORK'))] = 'Firework Launcher',
    [tostring(GetHashKey('WEAPON_MARKSMANRIFLE'))] = 'Marksman Rifle',
    [tostring(GetHashKey('WEAPON_HEAVYSHOTGUN'))] = 'Heavy Shotgun',
    [tostring(GetHashKey('WEAPON_PROXMINE'))] = 'Proximity Mine',
    [tostring(GetHashKey('WEAPON_HOMINGLAUNCHER'))] = 'Homing Launcher',
    [tostring(GetHashKey('WEAPON_HATCHET'))] = 'Hatchet',
    [tostring(GetHashKey('WEAPON_COMBATPDW'))] = 'Combat PDW',
    [tostring(GetHashKey('WEAPON_KNUCKLE'))] = 'Knuckle Duster',
    [tostring(GetHashKey('WEAPON_MARKSMANPISTOL'))] = 'Marksman Pistol',
    [tostring(GetHashKey('WEAPON_MACHETE'))] = 'Machete',
    [tostring(GetHashKey('WEAPON_MACHINEPISTOL'))] = 'Machine Pistol',
    [tostring(GetHashKey('WEAPON_FLASHLIGHT'))] = 'Flashlight',
    [tostring(GetHashKey('WEAPON_DBSHOTGUN'))] = 'Double Barrel Shotgun',
    [tostring(GetHashKey('WEAPON_COMPACTRIFLE'))] = 'Compact Rifle',
    [tostring(GetHashKey('WEAPON_SWITCHBLADE'))] = 'Switchblade',
    [tostring(GetHashKey('WEAPON_REVOLVER'))] = 'Heavy Revolver',
    [tostring(GetHashKey('WEAPON_FIRE'))] = 'Fire',
    [tostring(GetHashKey('WEAPON_HELI_CRASH'))] = 'Heli Crash',
    [tostring(GetHashKey('WEAPON_RUN_OVER_BY_CAR'))] = 'Run over by Car',
    [tostring(GetHashKey('WEAPON_HIT_BY_WATER_CANNON'))] = 'Hit by Water Cannon',
    [tostring(GetHashKey('WEAPON_EXHAUSTION'))] = 'Exhaustion',
    [tostring(GetHashKey('WEAPON_EXPLOSION'))] = 'Explosion',
    [tostring(GetHashKey('WEAPON_ELECTRIC_FENCE'))] = 'Electric Fence',
    [tostring(GetHashKey('WEAPON_BLEEDING'))] = 'Bleeding',
    [tostring(GetHashKey('WEAPON_DROWNING_IN_VEHICLE'))] = 'Drowning in Vehicle',
    [tostring(GetHashKey('WEAPON_DROWNING'))] = 'Drowning',
    [tostring(GetHashKey('WEAPON_BARBED_WIRE'))] = 'Barbed Wire',
    [tostring(GetHashKey('WEAPON_VEHICLE_ROCKET'))] = 'Vehicle Rocket',
    [tostring(GetHashKey('WEAPON_BULLPUPRIFLE'))] = 'Bullpup Rifle',
    [tostring(GetHashKey('WEAPON_ASSAULTSNIPER'))] = 'Assault Sniper',
    [tostring(GetHashKey('VEHICLE_WEAPON_ROTORS'))] = 'Rotors',
    [tostring(GetHashKey('WEAPON_RAILGUN'))] = 'Railgun',
    [tostring(GetHashKey('WEAPON_AIR_DEFENCE_GUN'))] = 'Air Defence Gun',
    [tostring(GetHashKey('WEAPON_AUTOSHOTGUN'))] = 'Automatic Shotgun',
    [tostring(GetHashKey('WEAPON_BATTLEAXE'))] = 'Battle Axe',
    [tostring(GetHashKey('WEAPON_COMPACTLAUNCHER'))] = 'Compact Grenade Launcher',
    [tostring(GetHashKey('WEAPON_MINISMG'))] = 'Mini SMG',
    [tostring(GetHashKey('WEAPON_PIPEBOMB'))] = 'Pipebomb',
    [tostring(GetHashKey('WEAPON_POOLCUE'))] = 'Poolcue',
    [tostring(GetHashKey('WEAPON_WRENCH'))] = 'Wrench',
    [tostring(GetHashKey('WEAPON_SNOWBALL'))] = 'Snowball',
    [tostring(GetHashKey('WEAPON_ANIMAL'))] = 'Animal',
    [tostring(GetHashKey('WEAPON_COUGAR'))] = 'Cougar',
    [tostring(GetHashKey("WEAPON_STUNGUN"))] = 'Tazer',
    [tostring(GetHashKey("WEAPON_FLASHLIGHT"))] = 'Flashligh',
    [tostring(GetHashKey("WEAPON_NIGHTSTICK"))] = 'Baton',
    [tostring(GetHashKey("WEAPON_MOLOTOV"))] = 'Molotov',
    [tostring(GetHashKey("WEAPON_FIREEXTINGUISHER"))] = 'Fire Extinguisher',
    [tostring(GetHashKey("WEAPON_PETROLCAN"))] = 'Petrol Can',
    [tostring(GetHashKey("WEAPON_SCARL"))] = 'SCAR-L',
    [tostring(GetHashKey("WEAPON_CAPSHIELD"))] = 'Captain America Shield',
    [tostring(GetHashKey("WEAPON_BRIEFCASE_02"))] = 'Briefcase',
    [tostring(GetHashKey("WEAPON_SIGMCX"))] = 'Sigmcx',
    [tostring(GetHashKey("WEAPON_M1911"))] = 'M1911',
    [tostring(GetHashKey("WEAPON_PYTHON"))] = 'Python',
    [tostring(GetHashKey("WEAPON_AK47"))] = 'AK-47',
    [tostring(GetHashKey("WEAPON_ARX"))] = 'ARK',
    [tostring(GetHashKey("WEAPON_VAL"))] = 'Val',
    [tostring(GetHashKey("WEAPON_AUG"))] = 'Aug',
    [tostring(GetHashKey("WEAPON_DEAGLE"))] = 'Deagle',
    [tostring(GetHashKey("WEAPON_VOM"))] = 'Vom',
    [tostring(GetHashKey("WEAPON_VESPER"))] = 'Vesper',
    [tostring(GetHashKey("WEAPON_SV98"))] = 'SV98',
    [tostring(GetHashKey("WEAPON_REMINGTONR5"))] = 'Remington',
    [tostring(GetHashKey("WEAPON_REMINGTON870"))] = 'Remington',
    [tostring(GetHashKey("WEAPON_RE6RN"))] = 're6rn',
    [tostring(GetHashKey("WEAPON_MP40"))] = 'MP40',
    [tostring(GetHashKey("WEAPON_MOSIN"))] = 'Mosin',
    [tostring(GetHashKey("WEAPON_M203"))] = 'M203',
    [tostring(GetHashKey("WEAPON_SP1"))] = 'SP1',
    [tostring(GetHashKey("WEAPON_M16A4"))] = 'M16A4',
    [tostring(GetHashKey("WEAPON_M4A1"))] = 'M4A1',
    [tostring(GetHashKey("WEAPON_LVOAC"))] = 'LVOAC',
    [tostring(GetHashKey("WEAPON_QBZ"))] = 'QBZ',
    [tostring(GetHashKey("WEAPON_HK416"))] = 'HK-416',
    [tostring(GetHashKey("WEAPON_HK45"))] = 'HK-45',
    [tostring(GetHashKey("WEAPON_GLOCK17"))] = 'Glock',
    [tostring(GetHashKey("WEAPON_G36K"))] = 'G36K',
    [tostring(GetHashKey("WEAPON_FNX"))] = 'Fnx',
    [tostring(GetHashKey("WEAPON_Bora"))] = 'Bora',
    [tostring(GetHashKey("WEAPON_UZI"))] = 'UZI',
    [tostring(GetHashKey("WEAPON_AK200"))] = 'AK-200',
    [tostring(GetHashKey("WEAPON_AK47"))] = 'AK47',
    [tostring(GetHashKey("WEAPON_AK200"))] = 'AK200',
    [tostring(GetHashKey("WEAPON_UZI"))] = 'UZI',
    [tostring(GetHashKey("WEAPON_WINCHESTER12"))] = 'Winchester 12',
    [tostring(GetHashKey("WEAPON_AK74KASHNAR"))] = 'AK74 Kashnar',
    [tostring(GetHashKey("WEAPON_M4A1"))] = 'M4A1',
    [tostring(GetHashKey("WEAPON_SPAR16"))] = 'SPAR 16',
    [tostring(GetHashKey("WEAPON_SVD"))] = 'SVD',
    [tostring(GetHashKey("WEAPON_AXE"))] = 'Axe',
    [tostring(GetHashKey("WEAPON_BASEBALLBAT"))] = 'Baseball Bat',
    [tostring(GetHashKey("WEAPON_BROOM"))] = 'Broom',
    [tostring(GetHashKey("WEAPON_DIAMONDSWORD"))] = 'Diamond Sword',
    [tostring(GetHashKey("WEAPON_SHANK"))] = 'Shank',
    [tostring(GetHashKey("WEAPON_SHOVEL"))] = 'Shovel',
}


function tvRP.varyHealth(variation)
    local ped = GetPlayerPed(-1)

    local n = math.floor(GetEntityHealth(ped)+variation)
    SetEntityHealth(ped,n)
end

function tvRP.reviveHealth()
    local ped = GetPlayerPed(-1)
    if GetEntityHealth(ped) == 102 then
        SetEntityHealth(ped,200)
    end
end

function tvRP.getHealth()
    return GetEntityHealth(GetPlayerPed(-1))
end

function tvRP.getArmour()
    return GetPedArmour(GetPlayerPed(-1))
end

function tvRP.setHealth(health)
    local n = math.floor(health)
    SetEntityHealth(GetPlayerPed(-1),n)
end

local shouldHaveArmour = 0

function tvRP.setArmour(armour)
    local n = math.floor(armour)
end

Citizen.CreateThread(function()
    while true do
        local difference = tvRP.getArmour() - shouldHaveArmour
        if tvRP.getArmour() > shouldHaveArmour then
            tvRP.setArmour(0)
        end
        Wait(0)
    end
end)

function tvRP.setFriendlyFire(flag)
    NetworkSetFriendlyFireOption(flag)
    SetCanAttackFriendly(GetPlayerPed(-1), flag, flag)
end
