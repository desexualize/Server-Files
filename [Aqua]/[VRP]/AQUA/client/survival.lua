local comaAnim = {}
in_coma = false
local coma_left = 30
local secondsTilBleedout = 30
local playerCanRespawn = false 
local calledNHS = false
local deathString = ""
local deathPosition
local notified = false
fullyComa = false

local comaAnim = {}
local DeathAnim = 50

Citizen.CreateThread(function()
  while true do 
    if IsDisabledControlJustPressed(0,38) then
      if playerCanRespawn and in_coma and secondsTilBleedout < 2 then
        TriggerServerEvent("AQUA:PoliceCheck")
        TriggerServerEvent("AQUA:RebelCheck")
        TriggerServerEvent("AQUA:VIPCheck")
        TriggerServerEvent("AQUA:getHouses")
        tAQUA.respawnPlayer()
        DoScreenFadeIn(900)
        TriggerEvent("AQUA:StartRespawnCam")
        TriggerEvent("AQUA:OpenRespawnMenu")
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

            AQUAserver.StoreWeaponsDead()
            AQUAserver.Coma()
            TriggerEvent('AQUA:IsInMoneyComa', true)
            TriggerServerEvent('AQUA:InComa')
            AQUAserver.MoneyDrop()
            TriggerEvent('AQUA:5Seconds')
            tAQUA.ejectVehicle()
            in_coma = true
            TriggerEvent("AQUA:PlaySound", tAQUA.getDeathSound())
            SendNUIMessage({action = in_coma})
            -- if GetActivePlayers() 
            if isPlayerInRedZone() then 
                secondsTilBleedout = 10
            end
            deathPosition = plyCoords
            local x,y,z = table.unpack(deathPosition)
            AQUAserver.updatePos({x,y,z})
            AQUAserver.updateHealth({0})
            Wait(250) --Need wait, otherwise will autorevive in next check
        end

        if DeathAnim <= 0  then --Been 10 seconds, proceed to play anim check 
            DeathAnim = 50 
            local entityDead = GetEntityHealth(GetPlayerPed(-1))
            while entityDead <= 100 do
                Wait(0)
                local x,y,z = tAQUA.getPosition()
                NetworkResurrectLocalPlayer(x, y, z, GetEntityHeading(GetPlayerPed(-1)), true, true, false)
                entityDead = GetEntityHealth(GetPlayerPed(-1))
                fullyComa = true
            end
            SetEntityHealth(GetPlayerPed(-1), 102)
            SetEntityInvincible(GetPlayerPed(-1),true)
            comaAnim = getRandomComaAnimation()
            if not HasAnimDictLoaded(comaAnim.dict) then
                RequestAnimDict(comaAnim.dict)
                while not HasAnimDictLoaded(comaAnim.dict) do
                    Wait(0)
                end
            end
            TaskPlayAnim(GetPlayerPed(-1), comaAnim.dict, comaAnim.anim, 3.0, 1.0, -1, 1, 0, 0, 0, 0 )
        end

        if health > cfg.coma_threshold and in_coma then --Revive check
            if IsEntityDead(GetPlayerPed(-1)) then
                local x,y,z = tAQUA.getPosition()
                NetworkResurrectLocalPlayer(x, y, z, GetEntityHeading(GetPlayerPed(-1)), true, true, false)
                Wait(0)
            end
        
            playerCanRespawn = false 
            --deathString = ""
            tAQUA.disableComa()
            DeathAnim = 50 

            SetEntityInvincible(GetPlayerPed(-1),false)
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
            local playerPed = PlayerPedId()
            if not IsEntityDead(playerPed) then
                if comaAnim.dict == nil then
                    comaAnim = getRandomComaAnimation()
                end
                if not IsEntityPlayingAnim(playerPed,comaAnim.dict,comaAnim.anim,3)  then
                    if comaAnim.dict ~= nil then
                        if not HasAnimDictLoaded(comaAnim.dict) then
                            RequestAnimDict(comaAnim.dict)
                            while not HasAnimDictLoaded(comaAnim.dict) do
                                Wait(0)
                            end
                        end
                        TaskPlayAnim(playerPed, comaAnim.dict, comaAnim.anim, 3.0, 1.0, -1, 1, 0, 0, 0, 0 )
                    end
                end
            end
            if GetEntityHealth(playerPed) > cfg.coma_threshold then 
                tAQUA.disableComa()
                if IsEntityDead(playerPed) then
                    local x,y,z = tAQUA.getPosition()
                    NetworkResurrectLocalPlayer(x, y, z, GetEntityHeading(GetPlayerPed(-1)),true, true, false)
                    Wait(0)
                end
                tAQUA.disableComa()
                DeathAnim = 50 
                deathString = ""
                SetEntityInvincible(playerPed,false)
                ClearPedSecondaryTask(playerPed) 
            end
        end
        Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do 
        if in_coma then
           
           
            DrawRect(0.494, 0.75, 1.125, 0.17, 0, 0, 0, 80, 0)
            DrawAdvancedText(0.607, 0.696, 0.005, 0.0028, 0.79, deathString, 238, 18, 32, 255, 7, 0)
          
            if secondsTilBleedout > 0 then
                
                DrawAdvancedTextOutline(0.605, 0.752, 0.005, 0.0040, 0.4, "Respawn available in ("..secondsTilBleedout.." seconds)", 255, 255, 255, 255, 7, 0)
            else
                
                playerCanRespawn = true
            
                DrawAdvancedTextOutline(0.605, 0.752, 0.005, 0.0040, 0.4, "Press [E] to respawn!", 255, 255, 255, 255, 7, 0)
            end
            DrawAdvancedTextOutline(0.605, 0.793, 0.005, 0.0028, 0.37, "You are bleeding out...", 255, 255, 255, 255, 6, 0)
            DisableControlAction(0,323,true)
            DisableControlAction(0,182,true)
            DisableControlAction(0,37,true)
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

Citizen.CreateThread(function()
    while DeathAnim <= 5 and DeathAnim >= 0 do
        Wait(1000)
        DeathAnim = DeathAnim - 1
    end
end) 

RegisterNetEvent("AQUA:5Seconds")
AddEventHandler("AQUA:5Seconds", function()
    DeathAnim = 5
    while DeathAnim <= 5 and DeathAnim >= 0 do
        Wait(1000)
        DeathAnim = DeathAnim - 1
    end
end)

function tAQUA.respawnPlayer()

    DoScreenFadeOut(1000)
    Wait(1000)
    DoScreenFadeIn(500)
    exports.spawnmanager:spawnPlayer()
    playerCanRespawn = false 
    deathString = ""
  
    
    local ped = GetPlayerPed(-1)
    tAQUA.reviveComa()
    tAQUA.ClearWeapons()
end


function tAQUA.disableComa()
    in_coma = false
end

function tAQUA.isInComa()
    return in_coma
end

RegisterNetEvent("AQUA:FixClient")
AddEventHandler("AQUA:FixClient", function()
    local resurrectspamm = true
    Citizen.CreateThread(function()
        while true do 
            Wait(0)
            if resurrectspamm == true then
                DoScreenFadeOut(500)
                Citizen.Wait(500)
                NetworkSetVoiceActive(true)
                SetPlayerTalkingOverride(PlayerId(), true)
                fullyComa = false
                notified = false
                local ped = PlayerPedId()
                local x,y,z = GetEntityCoords(ped)
                respawnedrecent = false 
                NetworkResurrectLocalPlayer(x, y, z, true, true, false)
                Citizen.Wait(0)
                calledNHS = false
                ClearPedTasksImmediately(PlayerPedId())
                resurrectspamm = false
                in_coma = false
                EnableControlAction(0, 73, true)
                tAQUA.stopScreenEffect(cfg.coma_effect)
            
                DoScreenFadeIn(500)
                Citizen.Wait(500)
            end 
        end
    end)
end)



function tAQUA.reviveComa()
    local ped = GetPlayerPed(-1)
    SetEntityInvincible(ped,false)
    tAQUA.setRagdoll(false)
    tAQUA.stopScreenEffect(cfg.coma_effect)
    SetEntityHealth(GetPlayerPed(-1), 200) 
end

-- kill the player if in coma
function tAQUA.killComa()
    if in_coma then
        coma_left = 0
    end
end

Citizen.CreateThread(function() -- disable health regen, conflicts with coma system
    while true do
        SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
        Wait(0)
    end
end)


AddEventHandler("AQUA:respawnButtonClicked",function(X, Y)
    if Y and Y > 0 then
        TriggerServerEvent("AQUA:takeAmount", Y)
    end
    local Z = p.spawnLocations[X].coords
    TriggerEvent("AQUA:playGTAIntro")
    tAQUA.ClearWeapons()
    if tAQUA.isHandcuffed() then
        TriggerEvent("AQUA:toggleHandcuffs", false)
    end
    SetEntityCoords(PlayerPedId(), Z)
    SetEntityVisible(PlayerPedId(), true, 0)
    SetPlayerControl(PlayerId(), true, 0)
    SetFocusPosAndVel(Z.x, Z.y, Z.z + 1000)
    DestroyCam(T)
    local _ = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA", Z.x, Z.y, Z.z + 1000.0, 0.0, 0.0, 0.0, 65.0, 0, 2)
    SetCamActive(_, true)
    RenderScriptCams(true, true, 0, true, false)
    SetCamParams(_, Z.x, Z.y, Z.z, 0.0, 0.0, 0.0, 65.0, 5000, 0, 0, 2)
    Wait(2500)
    ClearFocus()
    Wait(2000)
    FreezeEntityPosition(PlayerPedId(), false)
    DestroyCam(_)
    RenderScriptCams(false, true, 2000, false, false)
    TriggerScreenblurFadeOut(2000.0)
    ExecuteCommand("showui")
    ClearFocus()
end)


Citizen.CreateThread(function()
    local DeathReason, Killer, DeathCauseHash, Weapon

    while true do
        Citizen.Wait(0)
        if IsEntityDead(PlayerPedId()) then
            for k,v in pairs(WeaponNames) do
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
                elseif IsLMG(DeathCauseHash) then
                    DeathReason = 'gunned down'
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
                deathString = "You committed suicide"
            else
                local Id = TriggerServerCallback("AQUA:FetchKillerID", GetPlayerServerId(Killer))
                if Id then
                    deathString = "You Were Killed By " .. GetPlayerName(Killer) .. "(" ..Id.. ") With A " .. tostring(Weapon)
                else
                    deathString = "You Were Killed By " .. GetPlayerName(Killer) .. " With A " .. tostring(Weapon)
                end
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
    end
end)

function IsMelee(Weapon)
    local Weapons = {
        'WEAPON_NIGHTSTICK',
        "WEAPON_broom", 
        "WEAPON_dildo",
        "WEAPON_toiletbrush",
        "WEAPON_shank",
        "WEAPON_MEDSWORD",
        "WEAPON_SABERVADER",
    
    }
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
    local Weapons = {

    }
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsPistol(Weapon)
    local Weapons = {
        "WEAPON_m1911",
        "WEAPON_beretta",
        "WEAPON_TEC9",
        "WEAPON_hawk",
        "WEAPON_PYTHON",
        "WEAPON_GLOCK", -- PD Glock
        "WEAPON_USPSKILLCONFIRMED",
   

}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsSub(Weapon)
    local Weapons = {
        "WEAPON_mp5",
        "WEAPON_CQ300",
        'WEAPON_scorpianblue',
        'WEAPON_blackicepeacekeeper',
        "WEAPON_mac10",
        "WEAPON_vesper",
        "WEAPON_aks74u",
        "WEAPON_mp7",
        "WEAPON_mp40",
        "WEAPON_DIAMONDMP5",
        "WEAPON_TEC9",
        "WEAPON_UMP45",
        "WEAPON_NEONOIRMAC10",
        "WEAPON_ICEVECTOR",
        "WEAPON_UMPV2NEONOIR",
        "WEAPON_MP9PD",
    }
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsRifle(Weapon)
    local Weapons = {
        "WEAPON_GOLDAK",
        "WEAPON_SAGIRI",
        "WEAPON_akm",
        "WEAPON_AK200",
        "WEAPON_SPAR16",
        "WEAPON_MXM",
        "WEAPON_m4a1",
        "WEAPON_m16a1",
        "WEAPON_pp",
        "WEAPON_MK1EMR",
        "WEAPON_PDMCX",
        "WEAPON_PDHK416",
        "WEAPON_PDAR15",
        "WEAPON_SPAR17",
        "WEAPON_MXC",
        "WEAPON_BLASTXPHANTOM",
        "WEAPON_GRAU556",
        "WEAPON_M4SANDSTORM",
        "WEAPON_RUSTAK",
        "WEAPON_AK74",
        "WEAPON_PRIMEVANDAL",
        "WEAPON_SA80",
        "WEAPON_M16A1PD",
        "WEAPON_RGXVANDAL",
        "WEAPON_PURPLEVANDAL",
        "WEAPON_M4A4FIRE",
    }
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsLight(Weapon)
    local Weapons = {}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsShotgun(Weapon)
    local Weapons = {
        "WEAPON_winchester",
        "WEAPON_remington870",
        "WEAPON_FNTACSHOTGUN",
    }
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsLMG(Weapon)
    local Weapons = {}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsSniper(Weapon)
    local Weapons = {
        "WEAPON_REMINGTON700",
        "WEAPON_MOSIN",
        "WEAPON_NERFMOSIN",
        "WEAPON_SVD",
        "WEAPON_CHERRYMOSIN",
        "WEAPON_REAVEROP",
        "WEAPON_L96A3",
        "WEAPON_NOVMOSIN",
    }
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
    [tostring(GetHashKey('WEAPON_SMOKEGRENADE'))] = 'Tear Gas',
    [tostring(GetHashKey('WEAPON_BZGAS'))] = 'BZ Gas',
    [tostring(GetHashKey('WEAPON_MOLOTOV'))] = 'Molotov',
    [tostring(GetHashKey('WEAPON_FIREEXTINGUISHER'))] = 'Fire Extinguisher',
    [tostring(GetHashKey('WEAPON_PETROLCAN'))] = 'Jerry Can',
    [tostring(GetHashKey('WEAPON_RAMMED_BY_CAR'))] = 'Rammed by Car',
    [tostring(GetHashKey('WEAPON_FLAREGUN'))] = 'Flare Gun',
    [tostring(GetHashKey('WEAPON_FIRE'))] = 'Fire',
    [tostring(GetHashKey('WEAPON_RUN_OVER_BY_CAR'))] = 'Run over by Car',
    [tostring(GetHashKey('WEAPON_HIT_BY_WATER_CANNON'))] = 'Hit by Water Cannon',
    [tostring(GetHashKey('WEAPON_DROWNING_IN_VEHICLE'))] = 'Drowning in Vehicle',
    [tostring(GetHashKey('WEAPON_DROWNING'))] = 'Drowning',
    [tostring(GetHashKey('WEAPON_BARBED_WIRE'))] = 'Barbed Wire',
    [tostring(GetHashKey('WEAPON_VEHICLE_ROCKET'))] = 'Vehicle Rocket',
    [tostring(GetHashKey('VEHICLE_WEAPON_ROTORS'))] = 'Rotors',
    [tostring(GetHashKey('WEAPON_SNOWBALL'))] = 'Snowball',
    [tostring(GetHashKey("WEAPON_STUNGUN"))] = 'Tazer',
    [tostring(GetHashKey("WEAPON_NIGHTSTICK"))] = 'Baton',
    [tostring(GetHashKey("WEAPON_MOLOTOV"))] = 'Molotov',
    [tostring(GetHashKey("WEAPON_FIREEXTINGUISHER"))] = 'Fire Extinguisher',
    [tostring(GetHashKey("WEAPON_PETROLCAN"))] = 'Petrol Can',
    -- ADDON
    --[[ Shank ]]
    [tostring(GetHashKey("WEAPON_broom"))] = 'Broom',
    [tostring(GetHashKey("WEAPON_dildo"))]= 'Dildo',
    [tostring(GetHashKey("WEAPON_toiletbrush"))]= 'Toilet Brush',
    [tostring(GetHashKey("WEAPON_shank"))]= 'Shank',
    -- [Pistol]
    [tostring(GetHashKey("WEAPON_m1911"))]= 'M1911',
    [tostring(GetHashKey("WEAPON_beretta"))]= 'Beretta',
    [tostring(GetHashKey("WEAPON_hawk"))]= 'Hawk',
    [tostring(GetHashKey("WEAPON_PYTHON"))]= 'Python',
    [tostring(GetHashKey("WEAPON_TEC9"))]= 'Tec-9',
    [tostring(GetHashKey("WEAPON_USPSKILLCONFIRMED"))]= 'USPS Kill Confirmed',
    -- [SMG]
    [tostring(GetHashKey('WEAPON_scorpianblue'))]= 'Scorian Blue',
    [tostring(GetHashKey('WEAPON_blackicepeacekeeper'))]= 'Black Ice Peacekeeper',
    [tostring(GetHashKey('WEAPON_UMP45'))]= 'UMP-45',
    -- [PD]
    [tostring(GetHashKey("WEAPON_remington870"))] = 'Remington 870',
    [tostring(GetHashKey("WEAPON_mp5"))] = 'MP5',
    [tostring(GetHashKey("WEAPON_PDMCX"))] = 'SIG MXC',
    [tostring(GetHashKey("WEAPON_PDHK416"))] = 'HK416',
    [tostring(GetHashKey("WEAPON_REMINGTON700"))] = 'Remington 700',
    [tostring(GetHashKey("WEAPON_GLOCK"))] = 'Glock',
    [tostring(GetHashKey("WEAPON_STUNGUN"))] = 'Tazer',
    [tostring(GetHashKey("WEAPON_CQ300"))] = 'CQ300',
    [tostring(GetHashKey("WEAPON_SPAR17"))] = 'Spar 17',
    [tostring(GetHashKey("WEAPON_M4SANDSTORM"))] = 'M4 Sandstorm',
    [tostring(GetHashKey("WEAPON_AK74"))] = 'AK-74',
    -- [Rebel]
    [tostring(GetHashKey("WEAPON_mosin")) ]= 'Mosin Nagant',
    [tostring(GetHashKey("WEAPON_NERFMOSIN")) ]= 'NERF Mosin Nagant',
    [tostring(GetHashKey("WEAPON_CHERRYMOSIN")) ]= 'Cherry Blossom Mosin ',
    [tostring(GetHashKey("WEAPON_NOVMOSIN")) ]= 'No Vantiy Mosin',
    
    [tostring(GetHashKey("WEAPON_m4a1"))] = 'M4A1',
    [tostring(GetHashKey("WEAPON_m16a1"))] = 'M16A1',
    [tostring(GetHashKey("WEAPON_MK1EMR"))] = 'MK1-EMR',
    [tostring(GetHashKey("WEAPON_MXM"))] = 'MXM',
    [tostring(GetHashKey("WEAPON_MXC"))] = 'MXC',
    [tostring(GetHashKey("WEAPON_saige"))] = 'Saige',
    [tostring(GetHashKey("WEAPON_SVD"))] = 'SVD',
    [tostring(GetHashKey("WEAPON_AK200"))] = 'AK200',
    [tostring(GetHashKey("WEAPON_SPAR16"))] = 'Spar 16',
    -- [Light Arms]
    [tostring(GetHashKey("WEAPON_goldendeagle"))] = 'Golden Deagle',
    [tostring(GetHashKey("WEAPON_mac10"))] = 'MAC-19',
    [tostring(GetHashKey("WEAPON_olympia"))] = 'Olympia',
    [tostring(GetHashKey("WEAPON_usps"))] = 'USPS',
    -- [Large Arms]
    [tostring(GetHashKey("WEAPON_akm"))] = 'AKM',
    [tostring(GetHashKey("WEAPON_vesper"))] = 'Vesper',
    [tostring(GetHashKey("WEAPON_aks74u"))] = 'AK74U',
    [tostring(GetHashKey("WEAPON_mp7"))] = 'MP7',
    [tostring(GetHashKey("WEAPON_mp40"))] = 'MP40',
    [tostring(GetHashKey("WEAPON_winchester"))] = 'Winchester',
    [tostring(GetHashKey("WEAPON_SAGIRI"))] = 'Sagiri',
    [tostring(GetHashKey("WEAPON_DIAMONDMP5"))] = 'Diamond MP5',
    [tostring(GetHashKey("WEAPON_GOLDAK"))] = 'Golden AK',
    [tostring(GetHashKey("WEAPON_REAVEROP"))] = 'Reaver Operator',
    [tostring(GetHashKey("WEAPON_HKJAMO"))] = 'HK416 EFT',
    
    -- SAME AS REBEL ATM
    [tostring(GetHashKey("WEAPON_M4A4FIRE"))] = 'M4A4 Fire',
    [tostring(GetHashKey("WEAPON_PURPLEVANDAL"))] = 'Purple Vandal',
    
    [tostring(GetHashKey("WEAPON_PRIMEVANDAL"))] = 'Prime Vanval',
    [tostring(GetHashKey("WEAPON_UMPV2NEONOIR"))] = 'UMP V2 Neor Noir',
    [tostring(GetHashKey("WEAPON_NEONOIRMAC10"))] = 'Neo Noir MAC-10',
    [tostring(GetHashKey("WEAPON_BLASTXPHANTOM"))] = 'Blast-X Phantom',
    [tostring(GetHashKey("WEAPON_GRAU556"))] = 'Grau 5.56',
    [tostring(GetHashKey("WEAPON_RUSTAK"))] = 'Rust AK',
    [tostring(GetHashKey("WEAPON_FNTACSHOTGUN"))] = 'Fortnite Tactical Shotgun',
    [tostring(GetHashKey("WEAPON_ICEVECTOR"))] = 'Black Ice Vector',
    [tostring(GetHashKey("WEAPON_MEDSWORD"))] = 'Medieval Sword',
    [tostring(GetHashKey("WEAPON_SA80"))] = 'SA80',
    [tostring(GetHashKey("WEAPON_M16A1PD"))] = 'M16A1PD',
    [tostring(GetHashKey("WEAPON_RGXVANDAL"))] = 'RGX Vandal',
    [tostring(GetHashKey("WEAPON_MP9PD"))] = 'MP9',
    [tostring(GetHashKey("WEAPON_SABERVADER"))] = 'Darth Vader Light Saber',
    
}

function tAQUA.varyHealth(variation)
    local ped = GetPlayerPed(-1)

    local n = math.floor(GetEntityHealth(ped)+variation)
    SetEntityHealth(ped,n)
end

function tAQUA.reviveHealth()
    local ped = GetPlayerPed(-1)
    if GetEntityHealth(ped) == 102 then
        SetEntityHealth(ped,200)
    end
end

function tAQUA.getHealth()
    return GetEntityHealth(GetPlayerPed(-1))
end

function tAQUA.getArmour()
    return GetPedArmour(GetPlayerPed(-1))
end

function tAQUA.setHealth(health)
    local n = math.floor(health)
    SetEntityHealth(GetPlayerPed(-1),n)
end

function tAQUA.setArmour(armour)
    SetPedArmour(PlayerPedId(), armour)
end

function tAQUA.setFriendlyFire(flag)
    local flag = true
    NetworkSetFriendlyFireOption(flag)
    SetCanAttackFriendly(GetPlayerPed(-1), flag, flag)
end

function tAQUA.setPolice(flag)
    local flag = false
    local player = PlayerId()
    SetPoliceIgnorePlayer(player, not flag)
    SetDispatchCopsForPlayer(player, flag)
end

function getRandomComaAnimation()
-- --death emotes
    randomComaAnimations = {
        {"combat@damage@writheidle_a","writhe_idle_a"},
        {"combat@damage@writheidle_a","writhe_idle_b"},
        {"combat@damage@writheidle_a","writhe_idle_c"},
        {"combat@damage@writheidle_b","writhe_idle_d"},
        {"combat@damage@writheidle_b","writhe_idle_e"},
        {"combat@damage@writheidle_b","writhe_idle_f"},
        {"combat@damage@writheidle_c","writhe_idle_g"},
        {"combat@damage@rb_writhe","rb_writhe_loop"},
        {"combat@damage@writhe","writhe_loop"},
    }


    comaAnimation = {}
    
    math.randomseed(GetGameTimer())
    num = math.random(1,#randomComaAnimations)
    num = math.random(1,#randomComaAnimations)
    num = math.random(1,#randomComaAnimations)
    
    dict,anim = table.unpack(randomComaAnimations[num])
    comaAnimation["dict"] = dict
    comaAnimation["anim"] = anim
    -- print("GETTING CCOMA ANIM")
    --comaAnimation["dict"] = "combat@damage@writheidle_a"
    --comaAnimation["anim"] = "writhe_idle_a"
    --randomize this :)
    return comaAnimation
end

function DrawAdvancedTextOutline(x,y ,w,h,sc, text, r,g,b,a,font,jus)
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

function tAQUA.getHealth()
    return GetEntityHealth(GetPlayerPed(-1))
  end