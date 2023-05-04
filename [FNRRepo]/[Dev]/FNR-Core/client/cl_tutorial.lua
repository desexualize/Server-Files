local InRangeGather = false
local InRangeProcess = false
local InRangeSell = false
local CanSeeMarker = false

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(500)
      if #(vec(-510.23022460938, -255.72303771973,35.607707977295+1 - 0.98) - GetEntityCoords(PlayerPedId())) < 100 then
      if not CanSeeMarker then
        CanSeeMarker = true
        Citizen.CreateThread(function()
          while CanSeeMarker do
            Citizen.Wait(0)
            DrawMarker(36,  tutorial.townhall.spawn.x,tutorial.townhall.spawn.y,tutorial.townhall.spawn.z+1 - 0.98, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 0, 255, 13, 150, true, true, 0, 0, 0, 0, 0)
          end
        end)
      end
    else
      CanSeeMarker = false
    end
  end
end)

local isInMenu = false
local currentAmmunition = nil
local taxiCooldown = false
Citizen.CreateThread(function() 
    while true do

            local v1 = vector3(tutorial.townhall.spawn.x,tutorial.townhall.spawn.y,tutorial.townhall.spawn.z)

            if isInMenu == false then

            if isInArea(v1, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to start tutorial ~y~(Starters only)')
                if IsControlJustPressed(0, 51) then
                  if taxiCooldown == false then
                    TriggerEvent("vrp:PlaySound", "starter") 
                  
                    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 8.0, 0.5))
                    veh = "mh700e63s21red" 
                    vehiclehash = GetHashKey(veh)
                    RequestModel(vehiclehash)
                    
                    Citizen.CreateThread(function() 
                        local waiting = 0
                        while not HasModelLoaded(vehiclehash) do
                            waiting = waiting + 100
                            Citizen.Wait(100)
                            if waiting > 5000 then
                                ShowNotification("~r~Could not load the vehicle model in time, a crash was prevented.")
                                break
                            end
                        end
                        local vehicle = CreateVehicle(vehiclehash, x, y, z, GetEntityHeading(PlayerPedId())+90, 1, 0)
                        SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
                        ShowNotification("~g~You should now drive to simeons to purchase your first car, a waypoint has been set for you.")
                        SetNewWaypoint(-43.21, -1109.9)
                      taxiCooldown = true
                      Wait(60000*5)
                      taxiCooldown = false
                   end)
                  end
                  if taxiCooldown == true then
                    notify('~r~You have to wait 5 minutes before you can call another taxi.')
                  end
                end
            end
            end
        Citizen.Wait(0)
    end
end)

function isInArea(v, dis) 
    
  if #(GetEntityCoords(PlayerPedId(-1)) - v) <= dis then  
      return true
  else 
      return false
  end
end

RegisterCommand("setlastvehicleon",function()
  local ak = GetVehiclePedIsIn(PlayerPedId(), true)
  if ak ~= 0 then
    SetVehicleEngineOn(ak, true, true)
  end
end)

function GetPlayerByEntityID(i)
	for _, id in ipairs(GetActivePlayers()) do
        if i == GetPlayerPed(id) then
            return id
        end
	end
	return nil
end

cpr_in_progress = false

RegisterNetEvent('FNR:cprAnim')
AddEventHandler('FNR:cprAnim', function(nplayer)
  if GetEntityHealth(GetPlayerPed(GetPlayerFromServerId(nplayer))) == 102 then
    if not cpr_in_progress then
      cpr_in_progress = true
      notify("~g~CPR in progress.")
      math.randomseed(GetGameTimer())
      cprChance = math.random(1,8)
      local ad = "missheistfbi3b_ig8_2"
      local ad2 = "cpr_loop_paramedic"
      RequestAnimDict(ad)
      RequestAnimDict(ad2)
      TaskPlayAnim(PlayerPedId(), ad, ad2, 8.0, 1.0, -1, 12, 0, 0, 0, 0 )
      Wait(12000)
      if cprChance == 1 then
        TriggerServerEvent("FNR:SendFixClient", nplayer)
        notify("~g~You have saved this person's life.")
      else
        notify("~r~You need to practice CPR more, please try again.")
      end
      Wait(2000)
      cpr_in_progress = false  
      ClearPedSecondaryTask(PlayerPedId())
    else
      notify("~r~You are already performing CPR.")
    end
  else
    notify("~r~You cannot perform CPR on this person.")
  end
end)