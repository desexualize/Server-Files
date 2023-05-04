
-- this module define some police tools and functions

local handcuffed = false
local cop = false

-- set player as cop (true or false)
function tvRP.setCop(flag)
  cop = flag
  SetPedAsCop(GetPlayerPed(-1),flag)
end

-- HANDCUFF

function tvRP.toggleHandcuff()
  handcuffed = not handcuffed

  SetEnableHandcuffs(GetPlayerPed(-1), handcuffed)
  if handcuffed then
    cuffs = CreateObject(GetHashKey("p_cs_cuffs_02_s"), GetEntityCoords(PlayerPedId(), true), true, true, true)
    AttachEntityToEntity(cuffs, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), -0.055, 0.06, 0.04, 265.0, 155.0, 80.0, true, false, false, false, 0, true)
    tvRP.playAnim(true,{{"mp_arresting","idle",1}},true)
  else
    DeleteEntity(cuffs)
    tvRP.stopAnim(true)
    SetPedStealthMovement(GetPlayerPed(-1),false,"") 
  end
end

function tvRP.setHandcuffed(flag)
  if handcuffed ~= flag then
    tvRP.toggleHandcuff()
  end
end

function tvRP.isHandcuffed()
  return handcuffed
end

-- (experimental, based on experimental getNearestVehicle)
function tvRP.putInNearestVehicleAsPassenger(radius)
  local veh = tvRP.getNearestVehicle(radius)

  if IsEntityAVehicle(veh) then
    for i=1,math.max(GetVehicleMaxNumberOfPassengers(veh),3) do
      if IsVehicleSeatFree(veh,i) then
        SetPedIntoVehicle(GetPlayerPed(-1),veh,i)
        return true
      end
    end
  end
  
  return false
end

function tvRP.putInNetVehicleAsPassenger(net_veh)
  local veh = NetworkGetEntityFromNetworkId(net_veh)
  if IsEntityAVehicle(veh) then
    for i=1,GetVehicleMaxNumberOfPassengers(veh) do
      if IsVehicleSeatFree(veh,i) then
        SetPedIntoVehicle(GetPlayerPed(-1),veh,i)
        return true
      end
    end
  end
end

function tvRP.putInVehiclePositionAsPassenger(x,y,z)
  local veh = tvRP.getVehicleAtPosition(x,y,z)
  if IsEntityAVehicle(veh) then
    for i=1,GetVehicleMaxNumberOfPassengers(veh) do
      if IsVehicleSeatFree(veh,i) then
        SetPedIntoVehicle(GetPlayerPed(-1),veh,i)
        return true
      end
    end
  end
end

-- keep handcuffed animation
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(15000)
    if handcuffed then
      tvRP.playAnim(true,{{"mp_arresting","idle",1}},true)
    end
  end
end)

-- force stealth movement while handcuffed (prevent use of fist and slow the player)
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    while not HasModelLoaded(GetHashKey("p_cs_cuffs_02_s")) do
      RequestModel(GetHashKey("p_cs_cuffs_02_s"))
      Citizen.Wait(100)
    end
    if handcuffed then
      SetPedStealthMovement(GetPlayerPed(-1),true,"")
      DisableControlAction(0,21,true) -- disable sprint
      DisableControlAction(0,24,true) -- disable attack
      DisableControlAction(0,25,true) -- disable aim
      DisableControlAction(0,47,true) -- disable weapon
      DisableControlAction(0,58,true) -- disable weapon
      DisableControlAction(0,263,true) -- disable melee
      DisableControlAction(0,264,true) -- disable melee
      DisableControlAction(0,257,true) -- disable melee
      DisableControlAction(0,140,true) -- disable melee
      DisableControlAction(0,141,true) -- disable melee
      DisableControlAction(0,142,true) -- disable melee
      DisableControlAction(0,143,true) -- disable melee
      DisableControlAction(0,75,true) -- disable exit vehicle
      DisableControlAction(27,75,true) -- disable exit vehicle
      DisableControlAction(0,114,true) -- f3 cancel
      DisableControlAction(0,120,true) -- hands up
      
      DisableControlAction(0,7,true) 
      DisableControlAction(0,80,true)  -- disable attack
      DisableControlAction(0,45,true) -- disable weapon
      DisableControlAction(0,257,true) -- disable punching / shooting
      DisableControlAction(0,69,true) -- disable punching / shooting
      DisableControlAction(0,135,true) -- disable punching / shooting
      DisableControlAction(0,142,true) -- disable punching / shooting
      DisableControlAction(0,144,true) -- disable punching / shooting
      DisableControlAction(0,131,true) -- disable running
      DisableControlAction(0,209,true) -- disable running
      DisableControlAction(0,254,true) -- disable running
      DisableControlAction(0,340,true) -- disable running
      DisableControlAction(0,352,true) -- disable running
      DisableControlAction(0,311,true) -- disable melee
      DisableControlAction(0,18,true) 
      DisableControlAction(0,55,true) 
      DisableControlAction(0,76,true) 
      DisableControlAction(0,102,true) 
      DisableControlAction(0,179,true) 
      DisableControlAction(0,203,true) 
      DisableControlAction(0,216,true) 
      DisableControlAction(0,255,true) 
      DisableControlAction(0,298,true) 
      DisableControlAction(0,321,true) 
      DisableControlAction(0,328,true) 
      DisableControlAction(0,353,true) 
      DisableControlAction(0,170,true) -- disable melee
      DisableControlAction(0,22,true)    
      DisableControlAction(0, 25, true)
      DisableControlAction(0, 140, true)
      DisableControlAction(1,323,true) -- disable x button
    end
  end
end)

-- JAIL

local jail = nil

-- jail the player in a no-top no-bottom cylinder 
function tvRP.jail(x,y,z,radius)
  tvRP.teleport(x,y,z) -- teleport to center
  jail = {x+0.0001,y+0.0001,z+0.0001,radius+0.0001}
end

-- unjail the player
function tvRP.unjail()
  jail = nil
end

function tvRP.isJailed()
  return jail ~= nil
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(5)
    if jail then
      local x,y,z = tvRP.getPosition()

      local dx = x-jail[1]
      local dy = y-jail[2]
      local dist = math.sqrt(dx*dx+dy*dy)

      if dist >= jail[4] then
        local ped = GetPlayerPed(-1)
        SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001) -- stop player

        -- normalize + push to the edge + add origin
        dx = dx/dist*jail[4]+jail[1]
        dy = dy/dist*jail[4]+jail[2]

        -- teleport player at the edge
        SetEntityCoordsNoOffset(ped,dx,dy,z,true,true,true)
      end
    end

  end
end)