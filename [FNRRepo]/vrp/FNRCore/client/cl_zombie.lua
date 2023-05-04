local entitys = {}
local propsZombie = {}
local onZombie = true
local Models = {"a_m_m_trampbeac_01","a_m_y_acult_01","a_m_m_polynesian_01","a_m_m_skidrow_01","a_m_y_genstreet_01","a_m_y_genstreet_02","a_m_y_methhead_01","a_m_y_stlat_01","a_m_y_stwhi_02","s_m_y_blackops_02","s_m_m_marine_01","s_m_m_security_01","s_m_y_autopsy_01","s_m_y_chef_01","s_m_y_marine_01","s_m_y_prisoner_01","ig_ramp_hic","a_m_m_beach_01","a_m_o_acult_01","a_m_o_soucent_02","cs_brad","cs_old_man1a","s_f_y_factory_01","s_m_y_factory_01","s_m_m_scientist_01","s_m_m_snowcop_01","u_m_m_prolsec_01","u_m_o_filmnoir","a_f_m_fatwhite_01","csb_prologuedriver","s_m_y_marine_02","ig_johnnyklebitz","ig_rashcosvki","u_f_y_corpse_01","u_m_y_corpse_01","u_m_y_zombie_01","s_m_y_prismuscl_01","csb_anita","g_m_m_chemwork_01","g_m_y_famca_01","g_m_y_lost_02","g_m_y_lost_03","mp_f_cardesign_01","mp_f_cocaine_01","mp_f_weed_01","mp_f_deadhooker","s_f_y_sheriff_01","s_f_y_casino_01","s_m_m_fibsec_01","s_m_m_armoured_02","s_m_y_fireman_01","hc_driver","u_m_y_babyd","a_m_m_fatlatin_01"}
local walks = {"move_m@drunk@verydrunk","move_m@drunk@moderatedrunk","move_m@drunk@a","move_lester_CaneUp","move_characters@orleans@core@","move_m@injured",}
local soundZombie = {"GENERIC_CURSE_HIGH","GENERIC_CURSE_MED","GENERIC_HI","GENERIC_INSULT_HIGH","GENERIC_INSULT_MED","GENERIC_THANKS"}
local soundAttackZombie = {"GENERIC_SHOCKED_HIGH","GENERIC_SHOCKED_MED",}
local m_explodingVehicles = {}
totalmoney = 0
totalkill = 0
Citizen.CreateThread(function()
	while true do
		local wait = 5000
        if tvRP.getPlayerBucket() == 40 then
		if #entitys < 150 and not IsPedInAnyVehicle(GetPlayerPed(-1)) then
			if onZombie and not isInArea(4679.9487304688,-4571.4799804688,19.30534362793, 100.0) then 
				local pPed = PlayerPedId()
				x, y, z = table.unpack(GetEntityCoords(pPed, true))
				EntityModel1 = Models[math.random(1, #Models)]
				EntityModel = string.upper(EntityModel1)
				RequestModel(GetHashKey(EntityModel))
				while not HasModelLoaded(GetHashKey(EntityModel)) or not HasCollisionForModelLoaded(GetHashKey(EntityModel)) do
					Wait(1)
				end
				local posX = x
				local posY = y
				local posZ = GetPlaceZ(GetEntityCoords(pPed))

				repeat
					Wait(1)

					posX = x + math.random(-100, 100)
					posY = y + math.random(-100, 100)

					playerX, playerY = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
					if posX > playerX - 70 and posX < playerX + 70 or posY > playerY - 70 and posY < playerY + 70 then
						canSpawn = false
						break
					else
						canSpawn = true
					end
				until canSpawn

				if math.abs(GetEntityCoords(pPed).z - posZ) < 10.0 --[[and not GetPlayer().InVehicle and not IsZoneSafe(GetPlayer().Pos, 50)]] then
                print("Spawned Zombie")
                entity = CreatePed(4, GetHashKey(EntityModel), posX, posY, posZ, 0.0, false, false)
					SetModelAsNoLongerNeeded(GetHashKey(EntityModel))
					walk = walks[math.random(1, #walks)]	
					RequestAnimSet(walk)
					while not HasAnimSetLoaded(walk) do
						Citizen.Wait(1)
					end

					SetBlockingOfNonTemporaryEvents(entity, true)
					SetPedPathCanUseClimbovers(entity, true)
					SetPedAccuracy(entity, 25)
					SetPedFleeAttributes(entity, 0, 0)
					SetPedEnableWeaponBlocking(entity, true)
					SetPedDiesInWater(entity, false)
					SetPedDiesWhenInjured(entity, false)
					SetPedIsDrunk(entity, true)
					DisablePedPainAudio(entity, true)
					SetPedCanPlayGestureAnims(entity, false)
					SetPedCanPlayAmbientAnims(entity, false)
					SetPedPathCanUseLadders(entity, false)
					SetPedSuffersCriticalHits(entity, true)
					SetPedConfigFlag(entity, 400, true)
					TaskWanderStandard(entity, 1.0, 10)
					SetPedKeepTask(entity, true)
					SetEntityLodDist(entity, 70)
					SetPedMovementClipset(entity, walk, 1.0)
					SetPedCanEvasiveDive(entity, false)
					SetPedAlertness(entity, 3)
					SetPedCombatAttributes(entity, 0, false)
					SetPedCombatAttributes(entity, 1, false)
					SetPedCombatAttributes(entity, 2, false)
					SetPedCombatAttributes(entity, 16, true)
					SetPedCombatAttributes(entity, 46, true)
					SetPedCombatAttributes(entity, 1424, false)
					SetPedCombatMovement(entity, 3)
					SetPedDefaultComponentVariation(entity)
					ApplyPedDamagePack(entity, "TD_SHOTGUN_FRONT_KILL", 0.0, 1.0)
					ApplyPedDamagePack(entity, "Burnt_Ped_Head_Torso", 0.0, 1.0)
					ApplyPedDamagePack(entity, "BigRunOverByVehicle", 0.0, 1.0)
					ApplyPedDamagePack(entity, "BigHitByVehicle", 0.0, 1.0)
					SetPedRelationshipGroupDefaultHash(entity, GetHashKey("Zombies"))
					SetPedRelationshipGroupHash(entity, GetHashKey("Zombies"))
					SetAmbientVoiceName(entity, "kerry")

					propsZombie = false

					if EntityModel1 == "a_m_m_fatlatin_01" then
						table.insert(entitys, { peds = entity, props = propsZombie, walk = walk, boss = true})
					else
						table.insert(entitys, { peds = entity, props = propsZombie, walk = walk, boss = false})
					end
				end
			end	

			for i, entity in pairs(entitys) do
				if isInArea(4679.9487304688,-4571.4799804688,19.30534362793, 50.0) then 
						SetEntityAsNoLongerNeeded(entity.peds)
						DeleteEntity(entity.peds)
						table.remove(entitys, i)
				end
				if not entity.peds then
					SetEntityAsNoLongerNeeded(entity.peds)
					DeleteEntity(entity.peds)
					table.remove(entitys, i)

                else
					local playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
					local pedX, pedY, pedZ = table.unpack(GetEntityCoords(entity.peds, true))	
						
					if pedX < playerX - 120 or pedX > playerX + 120 or pedY < playerY - 120 or pedY > playerY + 120 then
						local model = GetEntityModel(entity.peds)
						SetEntityAsNoLongerNeeded(entity.peds)
						SetModelAsNoLongerNeeded(model)
						DeleteEntity(entity.peds)
						table.remove(entitys, i)
					end
				end
				if IsEntityInWater(entity.peds) then
					local pedX, pedY, pedZ = table.unpack(GetEntityCoords(entity.peds, true))	
					SetEntityCoordsNoOffset(entity.peds, pedX, pedY, pedZ + 10)
				end
			end
		end
    end
		Wait(wait)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1500)
		local pPed = GetPlayerPed(-1)
		local pPos = GetEntityCoords(pPed)
    if tvRP.getPlayerBucket() == 40 then
		for i, entity in pairs(entitys) do

			if isInArea(4679.9487304688,-4571.4799804688,19.30534362793, 50.0) then 
				SetEntityAsNoLongerNeeded(entity.peds)
				DeleteEntity(entity.peds)
				table.remove(entitys, i)
			end

			local soundZombieUse = soundZombie[math.random(1, #soundZombie)]
								
			local playerX, playerY, playerZ = table.unpack(pPos)
			local distance = GetDistanceBetweenCoords(pPos, GetEntityCoords(entity.peds), true)
			local distLim = 125.0 or 60.0
			if not isInArea(4679.9487304688,-4571.4799804688,19.30534362793, 50.0) then 
				if distance <= distLim then
					PlayAmbientSpeech1(entity.peds, soundZombieUse, "SPEECH_PARAMS_STANDARD")
					TaskGoToEntity(entity.peds, pPed, -1, 0.0, 2.0 and 2.2 or 1.2, 1073741824, 0) -- 2.0
					TaskLookAtEntity(entity.peds, pPed, -1, 2048, 3)
					SetPedMovementClipset(entity.peds, entity.walk, 1.0)
				end
			end
		end
    end
	end
end)

Citizen.CreateThread(function()
	local PlayerPed = GetPlayerPed(-1)
    while true do
		local wait = 500
        if tvRP.getPlayerBucket() == 40 then
		for i, entity in pairs(entitys) do
			if entity.boss then 
				local health = GetEntityHealth(entity.peds)
				local newHealth = health + 1000
				if health + newHealth <= 1500 then 
					SetEntityHealth(entity.peds, newHealth)
				end
			end

			if onZombie then 
				playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
				pedX, pedY, pedZ = table.unpack(GetEntityCoords(entity.peds, true))

				if IsPedDeadOrDying(entity.peds, 1) == 1 then
				else
					if(Vdist(playerX, playerY, playerZ, pedX, pedY, pedZ) < 1.5) then
						wait = 50
						if IsPedRagdoll(entity.peds, 1) ~= 1 then
							wait = 25
							if not IsPedGettingUp(entity.peds) and HasEntityClearLosToEntityInFront(entity.peds, GetPlayerPed(-1)) --[[and not GetPlayer():Get('Camouflage', true)]] then
								wait = 1
								TaskWanderStandard(entity.peds, 1.0, 10)

								local attackAnimation = { "rcmbarry", "bar_1_attack_michael_wins_aln" }
								local soundAttackZombieUse = soundAttackZombie[math.random(1, #soundAttackZombie)]
								
								PlayAmbientSpeech1(entity.peds, soundAttackZombie, "SPEECH_PARAMS_STANDARD")
								RequestAnimDict("rcmbarry")
								TaskPlayAnim(entity.peds,attackAnimation[1], attackAnimation[2],1.0, 1.0, 500, 9, 1.0, 0, 0, 0)
								local playerPed = PlayerPedId()

								if IsPedInAnyVehicle(PlayerPed) then
									local veh = GetVehiclePedIsUsing(Player)
									local vehicleModel = GetEntityModel(veh)

									if IsThisModelABicycle(vehicleModel) or IsThisModelABike(vehicleModel) or IsThisModelAQuadbike(vehicleModel) then
										SetPedToRagdoll(playerPed, 0, 0, 0, 1, 1, 0)
									else
										local offSet = GetOffsetFromEntityGivenWorldCoords(veh, GetEntityCoords(entity.peds))
										SetVehicleDamage(veh, offSet.x, offSet.y, 0.2, 200.0, 100.0, true)
										if GetVehicleEngineHealth(veh) > -4000 then
											SetVehicleEngineHealth(veh, GetVehicleEngineHealth(veh) - 10.0)
										end
						
										if GetVehicleEngineHealth(veh) <= -4000 and GetVehicleBodyHealth(veh) <= 0.0 then
											TaskLeaveVehicle(playerPed, veh, 4160)
						
											if not m_explodingVehicles[veh] then
												m_explodingVehicles[veh] = true
												SetTimeout(6000, function()
													m_explodingVehicles[veh] = nil
												end)
											end
										end
						
										if GetVehicleBodyHealth(veh) > 0.0 then
											SetVehicleBodyHealth(veh, GetVehicleBodyHealth(veh) - 10.0)
										end
									end
								end

								if not IsPedInAnyVehicle(PlayerPed) and not tvRP.isInComa() then
									ApplyDamageToPed(playerPed, math.random(3, 7), true)
								end
								SetPedMovementClipset(entity.peds, entity.walk, 0.7)
								Wait(1000)	
							end
						end
					end
				end
			end
		end
    end
		Citizen.Wait(wait)
    end
end)

Citizen.CreateThread(function()
    local PlayerPed = GetPlayerPed(-1)
    while true do
        local wait = 1000
        if tvRP.getPlayerBucket() == 40 then
        if IsPedArmed(PlayerPed, 7) then 
            wait = 1
            if IsPedShooting(PlayerPed) then
                local hitted, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
                if hitted then
                    if (IsEntityAPed(entity) and IsPedAPlayer(entity)) then
                        Wait(100)
                    end
                end
            end
        end
		if IsEntityDead(PlayerPedId()) then
			DeleteZombie()
		end
    end
        Wait(wait)
    end
end)

-- Looting


Citizen.CreateThread(function()
    while true do
        local wait = 500
        if tvRP.getPlayerBucket() == 40 then
        for i, entity in pairs(entitys) do
                playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
                pedX, pedY, pedZ = table.unpack(GetEntityCoords(entity.peds, true))
                if IsPedDeadOrDying(entity.peds, 1) == 1 then
                    wait = 5
                        playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
                        pedX, pedY, pedZ = table.unpack(GetEntityCoords(entity.peds, true))	
                        if not IsPedInAnyVehicle(PlayerPedId(), false) then
                            if(Vdist(playerX, playerY, playerZ, pedX, pedY, pedZ) < 2.1) then
                                wait = 1
                                DrawText3D(pedX,pedY,pedZ + 0.2, "~w~Press [E] to Loot", 0.8, 4)
                                if IsControlJustReleased(1, 51) then
                                    if DoesEntityExist(GetPlayerPed(-1)) then
                                        local Boost 		= 1
                                        local BoostItem		= 1
                                        local ItemDrop 		= 90
                                        local MoneyDrop		= 0
                                        local randomChance 	= math.random(1, 100)


								
                                        onMoney 	= math.random(1000,3000)*Boost
                                        print("Random Chance: " ..randomChance*BoostItem)
                                        print("Item: " ..ItemDrop)
                                        print("Money: " ..MoneyDrop)
                                        if randomChance*BoostItem >= MoneyDrop then
											totalmoney = totalmoney + onMoney
											TriggerServerEvent("FNR:Zombie", onMoney)
                                        elseif randomChance*BoostItem >= ItemDrop then
                                            TriggerServerEvent("FNR:ZombieItem", true)
                                        end
										totalkill = totalkill + 1
                                        local model = GetEntityModel(entity.peds)
                                        SetEntityAsNoLongerNeeded(entity.peds)
                                        SetModelAsNoLongerNeeded(model)
                                        ClearAreaOfObjects(GetEntityCoords(entity.peds), 3.0, 2)
                                        DeleteEntity(entity.peds)
                                        table.remove(entitys, i)
                                    end
                                end
                            end
                        end
                end
            end
        end
        Citizen.Wait(wait)
    end
end)

Citizen.CreateThread(function()
    local zombieped = GetHashKey("u_m_y_zombie_01") --  u_m_m_streetart_01
    RequestModel(zombieped)
    while not HasModelLoaded(zombieped) do
        Wait(0)
    end
  
    RequestAnimDict("mini@strip_club@idles@bouncer@base")
    while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
      Wait(1)
    end
  
    local zombieentity = CreatePed(26,zombieped,-428.94323730469,1582.9350585938,356.86343383789-1.0,10,false,true)
    makeEntityFaceEntity(zombieentity, vector3(-425.30227661133,1581.0850830078,356.49624633789))
    SetModelAsNoLongerNeeded(zombieped)
    SetEntityCanBeDamaged(zombieentity, 0)
    SetPedAsEnemy(zombieentity, 0)   
    SetBlockingOfNonTemporaryEvents(zombieentity, 1)
    SetPedResetFlag(zombieentity, 249, 1)
    SetPedConfigFlag(zombieentity, 185, true)
    SetPedConfigFlag(zombieentity, 108, true)
    SetEntityInvincible(zombieentity, true)
    SetEntityCanBeDamaged(zombieentity, false)
    SetPedCanEvasiveDive(zombieentity, 0)
    SetPedCanRagdollFromPlayerImpact(zombieentity, 0)
    SetPedConfigFlag(zombieentity, 208, true)       
    FreezeEntityPosition(zombieentity, true)
    TaskPlayAnim(zombieentity,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)  


	local survialped = GetHashKey("csb_mweather") --  u_m_m_streetart_01
    RequestModel(survialped)
    while not HasModelLoaded(survialped) do
        Wait(0)
    end
  
    RequestAnimDict("mini@strip_club@idles@bouncer@base")
    while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
      Wait(1)
    end
  
    local survialentity = CreatePed(26,survialped,4455.9418945312,-4481.7319335938,4.2155494689941-1.0,10,false,true)
    makeEntityFaceEntity(survialentity, vector3(4457.287109375,-4485.15625,4.2110023498535))
    SetModelAsNoLongerNeeded(survialped)
    SetEntityCanBeDamaged(survialentity, 0)
    SetPedAsEnemy(survialentity, 0)   
    SetBlockingOfNonTemporaryEvents(survialentity, 1)
    SetPedResetFlag(survialentity, 249, 1)
    SetPedConfigFlag(survialentity, 185, true)
    SetPedConfigFlag(survialentity, 108, true)
    SetEntityInvincible(survialentity, true)
    SetEntityCanBeDamaged(survialentity, false)
    SetPedCanEvasiveDive(survialentity, 0)
    SetPedCanRagdollFromPlayerImpact(survialentity, 0)
    SetPedConfigFlag(survialentity, 208, true)       
    FreezeEntityPosition(survialentity, true)
    TaskPlayAnim(survialentity,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)  

end)

Citizen.CreateThread(function() 
    while true do
        local v1 = vector3(-428.42050170898,1582.8555908203,356.8083190918)
		local v2 = vector3(4456.2392578125,-4482.4125976562,4.2150435447693)
            if isInArea(v1, 1.4) then 
                DrawHelpMsg('Press ~INPUT_VEH_HORN~ to enter')
                if IsControlJustPressed(0, 51) then
                    TriggerServerEvent("FNR:CheckZombieTeleport")
                end
            end
			if isInArea(v2, 1.4) then 
                DrawHelpMsg('Press ~INPUT_VEH_HORN~ to enter')
                if IsControlJustPressed(0, 51) then
					TriggerServerEvent("FNR:LogZombieExit", totalkill, totalmoney)
                    TriggerServerEvent("FNR:CheckZombieExit")
                end
            end
        Citizen.Wait(0)
    end
end)

RegisterNetEvent("FNR:ZombieTeleport")
AddEventHandler("FNR:ZombieTeleport", function()
    if not a then
        a = true
        CreateThread(function()
            GiveWeaponToPed(PlayerPedId(), "GADGET_PARACHUTE")
			GiveWeaponToPed(PlayerPedId(), "WEAPON_SABERVADER")
            DoScreenFadeOut(3000)
			ExecuteCommand("hideui")
            while not IsScreenFadedOut() do
                Wait(0)
            end
			TriggerEvent("vrp:PlaySound", "purge")
			Wait(4000)
            SetEntityCoords(GetPlayerPed(-1), 4823.0229492188,-5095.31640625,19.980527877808 + 300.0)
            DoScreenFadeIn(3000)
			ExecuteCommand("showui")
            Wait(2000)
			tvRP.notify("You have been given lightsaber for your protection")
            SetPlayerInvincible(GetPlayerPed(-1), true)
            SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, false, 0, false)
            while true do
                if a then
                    if IsPedInParachuteFreeFall(GetPlayerPed(-1)) and not HasEntityCollidedWithAnything(GetPlayerPed(-1)) then
                        ApplyForceToEntity(GetPlayerPed(-1),true,0.0,200.0,2.5,0.0,0.0,0.0,false,true,false,false,false,true)
                    else
                        a = false
                    end
                else
                    break
                end
                Wait(0)
            end
            Wait(3000)
            SetPlayerInvincible(GetPlayerPed(-1), false)
            SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, 0, false)
        end)
    end
end)

InZombieZone = false
Citizen.CreateThread(function() 
    while true do
		if tvRP.getPlayerBucket() == 40 then
		DrawGTATimerBar("~g~Money:", "£" ..getMoneyStringFormatted(totalmoney), 1)
		DrawGTATimerBar("~y~Zombie's Killed:", totalkill, 2)
		InZombieZone = true
		else
		InZombieZone = false
		end
		Citizen.Wait(0)
    end
end)

-- Timer

function DrawGTATimerBar(a0, K, a1, a2, a3, a4)
    local a5 = 0.115
    local a6 = -0.01
    local a7 = 0.038
    local a8 = 0.015
    local a9 = 0.005
    local a4 = a4 or 0.4
    local a2 = a2 or 0.5
    local aa = -0.04
    local ab = 0.014
    local ac = GetSafeZoneSize()
    local ad = ab + ac - a5 + a5 / 2
    local ae = aa + ac - a7 + a7 / 2 - (a1 - 1) * (a7 + a9)
    DrawSprite("timerbars", "all_black_bg", ad, ae, a5, 0.038, 0, 0, 0, 0, 128)
    DrawGTAText(a0, ac - 0.18 + 0.080, ae - a8, a4)
    DrawGTAText(string.upper(K), ac - a6 + (a3 or 0), ae - 0.0175, a2, true, a5 / 2)
end

function DrawGTAText(a, b, c, j, z, A)
    SetTextFont(0)
    SetTextScale(j, j)
    SetTextColour(254, 254, 254, 255)
    if z then
        SetTextWrap(b - A, b)
        SetTextRightJustify(true)
    end
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(a)
    EndTextCommandDisplayText(b, c)
end

--- Functons 

function isInArea(v, dis) 
	if #(GetEntityCoords(PlayerPedId(-1)) - v) <= dis then  
		return true
	else 
		return false
	end
  end

DeleteZombie = function()
	for i=1, #entitys, 1 do 
		SetEntityAsNoLongerNeeded(entitys[i].peds)
		DeleteEntity(entitys[i].peds)
	end
	for k, entity in pairs(entitys) do 
		SetEntityAsNoLongerNeeded(entity.peds)
		DeleteEntity(entity.peds)
		table.remove(entitys, k)
	end
end

DrawText3D = function(x, y, z, text)
	SetTextScale(0.35, 0.45)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(0,179,255, 215)
	SetTextEntry("STRING")
	SetTextCentre(true)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z, 0)
	DrawText(0.0, 0.0)
	local factor = (string.len(text)) / 370
	ClearDrawOrigin()
end

function isInArea(v, dis)
    if #(GetEntityCoords(PlayerPedId(-1)) - v) <= dis then  
        return true
    else 
        return false
    end
  end
function GetPlaceZ(RlZo)
    local SUn = RlZo.z
    local Ib4, fjV1G2 = GetGroundZCoordWithOffsets(RlZo.x, RlZo.y, SUn)
    local Do = GetGameTimer()
    while not Ib4 do
        SUn = SUn + 10.0
        Ib4, fjV1G2 = GetGroundZCoordWithOffsets(RlZo.x, RlZo.y, SUn)
        Wait(0)
        if GetGameTimer() - Do > 2000 then
            break
        end
    end
    return fjV1G2
end

RegisterCommand("TestFNRZombie", function(source, args, raw)
    TriggerServerEvent("FNR:EnterZombie")
end)

RegisterNetEvent("FNR:LeavingZone")
AddEventHandler("FNR:LeavingZone", function()
	if HasPedGotWeapon(PlayerPedId(), "WEAPON_SABERVADER", false) then
		RemoveWeaponFromPed(PlayerPedId(), "WEAPON_SABERVADER")
	end
	DoScreenFadeOut(3000)
	while not IsScreenFadedOut() do
		Wait(0)
	end
	totalkill = 0
	totalmoney = 0
    DeleteZombie()
	SetEntityCoords(PlayerPedId(), 158.3018951416,-1067.4635009766,29.192378997803)
	DoScreenFadeIn(2000)
	Wait(2000)
end)

function makeEntityFaceEntity(entity1, coords)
    local p1 = GetEntityCoords(entity1, true)
    local p2 = coords

    local dx = p2.x - p1.x
    local dy = p2.y - p1.y

    local heading = GetHeadingFromVector_2d(dx, dy)
    SetEntityHeading(entity1,heading)
end