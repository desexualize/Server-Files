
-- periodic player state update

local state_ready = false

AddEventHandler("playerSpawned",function() -- delay state recording
  Citizen.CreateThread(function()
    Citizen.Wait(2000)
    state_ready = true
  end)
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(vRPConfig.PlayerSavingTime)

    if IsPlayerPlaying(PlayerId()) and state_ready then
      local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
      vRPserver.updatePos({x,y,z})
      vRPserver.updateHealth({tvRP.getHealth()})
      vRPserver.updateArmour({GetPedArmour(PlayerPedId())})
      vRPserver.updateTimePlayed()
      vRPserver.updateWeapons({tvRP.getWeapons()})
      vRPserver.updateCustomization({tvRP.getCustomization()})
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(60000)
    vRPserver.UpdatePlayTime()
  end
end)

-- def
local weapon_types = {
  -- [Main]
  "WEAPON_AXE",
  "WEAPON_BASEBALLBAT",
  "WEAPON_BROOM",
  "WEAPON_DIAMONDSWORD",
  "WEAPON_SHANK",
  "WEAPON_SHOVEL",

  "WEAPON_M1911",
  "WEAPON_REVOLVER357",
  "WEAPON_UMP45",
  "WEAPON_ROOK",

  "WEAPON_AK47",
  "WEAPON_AK200",
  "WEAPON_UZI",
  "WEAPON_MOSIN",
  "WEAPON_SVD",
  "WEAPON_WINCHESTER12",
  
  "WEAPON_AK74KASHNAR",
  "WEAPON_M4A1",
  "WEAPON_SPAR16",
  "WEAPON_DEAGLE",
}

function tvRP.spawnAnim(a)
  ExecuteCommand("hideui")
  local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
  TriggerEvent("vrp:PlaySound", "gtaloadin")
  SetFocusPosAndVel(x,y,z+1000)
  local spawnCam3 = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA", x,y,z+1000, 0.0, 0.0, 0.0, 65.0, 0, 2)
  SetCamActive(spawnCam3, true)
  DestroyCam(spawnCam, 0)
  DestroyCam(spawnCam2, 0)
  RenderScriptCams(true, true, 0, 1, 0, 0)
  local spawnCam4 = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA", x,y,z, 0.0, 0.0, 0.0, 65.0, 0, 2)
  SetCamActiveWithInterp(spawnCam4, spawnCam3, 5000, 0, 0)
  Wait(2500)
  ClearFocus()
  Wait(2000)
  DestroyCam(spawnCam3)
  DestroyCam(spawnCam4)
  RenderScriptCams(false, true, 2000, 0, 0)
  TriggerScreenblurFadeOut(2000.0)
  ExecuteCommand("showui")
  tvRP.setCustomization(a)
end

local countdown = 30
RegisterNetEvent("showText")
AddEventHandler("showText", function()
  while true do
      countdown = countdown - 0.01
      bank_drawTxt(0.85, 1.40, 1.0,1.0,0.5, "Make your way down to the 'Drug House' Basement\n To Purchase Rebel Access.", 255, 17, 0, 255)
      if countdown <= 0 then 
        break
      end
      Citizen.Wait(1)
  end 
end)


function bank_drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
  SetTextFont(0)
  SetTextProportional(0)
  SetTextScale(scale, scale)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0,255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  if(outline)then
    SetTextOutline()
  end
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x - width/2, y - height/2 + 0.005)
end

function tvRP.getWeaponTypes()
  return weapon_types
end

function tvRP.getWeapons()
  local player = GetPlayerPed(-1)

  local ammo_types = {} -- remember ammo type to not duplicate ammo amount

  local weapons = {}
  for k,v in pairs(weapon_types) do
    local hash = GetHashKey(v)
    if HasPedGotWeapon(player,hash) then
      local weapon = {}
      weapons[v] = weapon

      local atype = Citizen.InvokeNative(0x7FEAD38B326B9F74, player, hash)
      if ammo_types[atype] == nil then
        ammo_types[atype] = true
        weapon.ammo = GetAmmoInPedWeapon(player,hash)
      else
        weapon.ammo = 0
      end
    end
  end

  return weapons
end

vRPclient = Proxy.getInterface("vRP")
function tvRP.giveWeapons(weapons,clear_before)
  local player = GetPlayerPed(-1)

  -- give weapons to player

  if clear_before then
    RemoveAllPedWeapons(player,true)
  end

  for k,weapon in pairs(weapons) do
    local hash = GetHashKey(k)
    local ammo = weapon.ammo or 0
    GiveWeaponToPed(player, hash, ammo, false)
  end
  return true
end

--[[
function tvRP.dropWeapon()
  SetPedDropsWeapon(GetPlayerPed(-1))
end
--]]

-- PLAYER CUSTOMIZATION

-- parse part key (a ped part or a prop part)
-- return is_proppart, index
local function parse_part(key)
  if type(key) == "string" and string.sub(key,1,1) == "p" then
    return true,tonumber(string.sub(key,2))
  else
    return false,tonumber(key)
  end
end

function tvRP.getDrawables(part)
  local isprop, index = parse_part(part)
  if isprop then
    return GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1),index)
  else
    return GetNumberOfPedDrawableVariations(GetPlayerPed(-1),index)
  end
end

function tvRP.getDrawableTextures(part,drawable)
  local isprop, index = parse_part(part)
  if isprop then
    return GetNumberOfPedPropTextureVariations(GetPlayerPed(-1),index,drawable)
  else
    return GetNumberOfPedTextureVariations(GetPlayerPed(-1),index,drawable)
  end
end

function tvRP.getCustomization()
  local ped = GetPlayerPed(-1)

  local custom = {}

  custom.modelhash = GetEntityModel(ped)

  -- ped parts
  for i=0,20 do -- index limit to 20
    custom[i] = {GetPedDrawableVariation(ped,i), GetPedTextureVariation(ped,i), GetPedPaletteVariation(ped,i)}
  end

  -- props
  for i=0,10 do -- index limit to 10
    custom["p"..i] = {GetPedPropIndex(ped,i), math.max(GetPedPropTextureIndex(ped,i),0)}
  end

  return custom
end

-- partial customization (only what is set is changed)
function tvRP.setCustomization(custom) -- indexed [drawable,texture,palette] components or props (p0...) plus .modelhash or .model
  local exit = TUNNEL_DELAYED() -- delay the return values

  Citizen.CreateThread(function() -- new thread
    if custom then
      local ped = GetPlayerPed(-1)
      local mhash = nil

      -- model
      if custom.modelhash ~= nil then
        mhash = custom.modelhash
      elseif custom.model ~= nil then
        mhash = GetHashKey(custom.model)
      end

      if mhash ~= nil then
        local i = 0
        while not HasModelLoaded(mhash) and i < 10000 do
          RequestModel(mhash)
          Citizen.Wait(10)
        end

        if HasModelLoaded(mhash) then
          -- changing player model remove weapons, so save it
          local weapons = tvRP.getWeapons()
          SetPlayerModel(PlayerId(), mhash)
          tvRP.giveWeapons(weapons,true)
          SetModelAsNoLongerNeeded(mhash)
        end
      end

      ped = GetPlayerPed(-1)

      -- parts
      for k,v in pairs(custom) do
        if k ~= "model" and k ~= "modelhash" then
          local isprop, index = parse_part(k)
          if isprop then
            if v[1] < 0 then
              ClearPedProp(ped,index)
            else
              SetPedPropIndex(ped,index,v[1],v[2],v[3] or 2)
            end
          else
            SetPedComponentVariation(ped,index,v[1],v[2],v[3] or 2)
          end
        end
      end
    end

    exit({})
  end)
end

-- fix invisible players by resetting customization every minutes
--[[
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(60000)
    if state_ready then
      local custom = tvRP.getCustomization()
      custom.model = nil
      custom.modelhash = nil
      tvRP.setCustomization(custom)
    end
  end
end)
--]]


RegisterNetEvent('PlaneCutscene')
AddEventHandler('PlaneCutscene', function()
    PrepareMusicEvent("FM_INTRO_START")
	  TriggerMusicEvent("FM_INTRO_START")

         local plyrId = PlayerPedId()
         -----------------------------------------------
         RequestCutscene("MP_INTRO_CONCAT", 8)
         while not HasCutsceneLoaded() do 
            Wait(10) 
         end
         DoScreenFadeIn(250)
         SetCutsceneEntityStreamingFlags('MP_Male_Character', 0, 1) 
         local female = RegisterEntityForCutscene(0,"MP_Female_Character",3,0,64)
         RegisterEntityForCutscene(PlayerPedId(), 'MP_Male_Character', 0, GetEntityModel(PlayerPedId()), 64)
         GetEntityIndexOfCutsceneEntity('MP_Female_Character', GetHashKey(GetEntityModel('MP_Female_Character')))
  
    --     -----------------------------------------------
         SetCutsceneEntityStreamingFlags("MP_Plane_Passenger_1", 0, 1)
         SetCutsceneEntityStreamingFlags("MP_Plane_Passenger_2", 0, 1)
         SetCutsceneEntityStreamingFlags("MP_Plane_Passenger_3", 0, 1)
         SetCutsceneEntityStreamingFlags("MP_Plane_Passenger_4", 0, 1)
         SetCutsceneEntityStreamingFlags("MP_Plane_Passenger_5", 0, 1)
         SetCutsceneEntityStreamingFlags("MP_Plane_Passenger_6", 0, 1)
         SetCutsceneEntityStreamingFlags("MP_Plane_Passenger_7", 0, 1)
         RegisterEntityForCutscene(0, 'MP_Plane_Passenger_1', 3, GetHashKey('mp_f_freemode_01'), 0)
         RegisterEntityForCutscene(0, 'MP_Plane_Passenger_2', 3, GetHashKey('mp_f_freemode_01'), 0)
         RegisterEntityForCutscene(0, 'MP_Plane_Passenger_3', 3, GetHashKey('mp_f_freemode_01'), 0)
         RegisterEntityForCutscene(0, 'MP_Plane_Passenger_4', 3, GetHashKey('mp_f_freemode_01'), 0)
         RegisterEntityForCutscene(0, 'MP_Plane_Passenger_5', 3, GetHashKey('mp_f_freemode_01'), 0)
         RegisterEntityForCutscene(0, 'MP_Plane_Passenger_6', 3, GetHashKey('mp_f_freemode_01'), 0)
         RegisterEntityForCutscene(0, 'MP_Plane_Passenger_7', 3, GetHashKey('mp_f_freemode_01'), 0)
         RegisterEntityForCutscene(0, 'MP_Plane_Passenger_1', 3, GetHashKey('mp_m_freemode_01'), 0)
         RegisterEntityForCutscene(0, 'MP_Plane_Passenger_2', 3, GetHashKey('mp_m_freemode_01'), 0)
         RegisterEntityForCutscene(0, 'MP_Plane_Passenger_3', 3, GetHashKey('mp_m_freemode_01'), 0)
         RegisterEntityForCutscene(0, 'MP_Plane_Passenger_4', 3, GetHashKey('mp_m_freemode_01'), 0)
         RegisterEntityForCutscene(0, 'MP_Plane_Passenger_5', 3, GetHashKey('mp_m_freemode_01'), 0)
         RegisterEntityForCutscene(0, 'MP_Plane_Passenger_6', 3, GetHashKey('mp_m_freemode_01'), 0)
         RegisterEntityForCutscene(0, 'MP_Plane_Passenger_7', 3, GetHashKey('mp_m_freemode_01'), 0)
         NewLoadSceneStartSphere(-1212.79, -1673.52, 7, 1000, 0)
         -----------------------------------------------
         StartCutscene(4)
    
          Wait(20000)
         StopCutsceneImmediately()
         DoScreenFadeOut(90)
         SetEntityCoordsNoOffset(PlayerPedId(), 3094.8723144531,-4703.50390625,24.261253356934, 0)
        SetEntityHeading(PlayerPedId(), 330.40)
        Wait(4000)
        PrepareMusicEvent("AC_STOP")
	    TriggerMusicEvent("AC_STOP")
        DoScreenFadeIn(500)

end)
