
-- periodic player state update

local state_ready = false
AddEventHandler("playerSpawned",function() -- delay state recording
  state_ready = false
  
  Citizen.CreateThread(function()
    Citizen.Wait(30000)
    state_ready = true
  end)
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(AQUAConfig.PlayerSavingTime)
    if IsPlayerPlaying(PlayerId()) and state_ready then
        local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
        AQUAserver.updatePos({x,y,z})
        AQUAserver.updateHealth({tAQUA.getHealth()})
        AQUAserver.updateArmour({GetPedArmour(PlayerPedId())})
        AQUAserver.updateWeapons({tAQUA.getWeapons()})
        if dpdjob or tAQUA.isStaffedOn() then
        else
          AQUAserver.updateCustomization({tAQUA.getCustomization()})
        end
        TriggerServerEvent('AQUA:changeHairStyle')
        TriggerServerEvent('AQUA:ChangeTattoos')
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(30000)
    AQUAserver.UpdatePlayTime()
  end
end)

-- def
local weapon_types = {
  -- [Knives]
  "WEAPON_broom", 
  "WEAPON_dildo",
  "WEAPON_toiletbrush",
  "WEAPON_shank",
  -- [Pistol]
  "WEAPON_m1911",
  "WEAPON_beretta",
  "WEAPON_TEC9",
  "WEAPON_hawk",
  "WEAPON_PYTHON",
  "WEAPON_USPSKILLCONFIRMED",
  -- [SMG]
  'WEAPON_scorpianblue',
  'WEAPON_blackicepeacekeeper',
  "WEAPON_UMP45",
  -- [PD]
  -- "WEAPON_remington870",
  -- "WEAPON_mp5",
  -- "WEAPON_PDMCX",
  -- "WEAPON_PDHK416",
  -- "WEAPON_REMINGTON700",
  -- "WEAPON_GLOCK",
  -- "WEAPON_STUNGUN",
  -- "WEAPON_CQ300",
  -- "WEAPON_SPAR17",
  -- "WEAPON_M4SANDSTORM",

  -- [Rebel]
  "WEAPON_MOSIN",
  "WEAPON_m4a1",
  "WEAPON_m16a1",
  "WEAPON_pp",
  "WEAPON_MK1EMR",
  "WEAPON_MXM",
  "WEAPON_MXC",
  "WEAPON_saige",
  "WEAPON_SVD",
  "WEAPON_AK200",
  "WEAPON_SPAR16",
  -- [Light Arms]
  "WEAPON_goldendeagle",
  "WEAPON_mac10",
  "WEAPON_olympia", 
  "WEAPON_usps",
  -- [Large Arms]
  "WEAPON_akm",
  "WEAPON_vesper",
  "WEAPON_aks74u",
  "WEAPON_mp7",
  "WEAPON_mp40",
  "WEAPON_winchester",
  "WEAPON_SAGIRI",
  "WEAPON_DIAMONDMP5",
  "WEAPON_GOLDAK",
  "WEAPON_FNTACSHOTGUN",
  "WEAPON_AK74",
  -- SAME AS REBEL ATM
  "WEAPON_NERFMOSIN",
  "WEAPON_NEONOIRMAC10",
  "WEAPON_BLASTXPHANTOM",
  "WEAPON_GRAU556",
  "WEAPON_CHERRYMOSIN",
  "WEAPON_M4A4FIRE",
  "WEAPON_PURPLEVANDAL",
  "WEAPON_RUSTAK",
  "WEAPON_REAVEROP",
  "WEAPON_HKJAMO",
  "WEAPON_ICEVECTOR",
  "WEAPON_MEDSWORD",
  "WEAPON_UMPV2NEONOIR",
  "WEAPON_PRIMEVANDAL",
  "WEAPON_L96A3",
  "WEAPON_SA80",
  "WEAPON_M16A1PD",
  "WEAPON_RGXVANDAL",
  "WEAPON_MP9PD",
  "WEAPON_SABERVADER",
  "WEAPON_NOVMOSIN",
}

function tAQUA.getWeaponTypes()
  return weapon_types
end

function tAQUA.getWeapons()
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

function tAQUA.giveWeapons(weapons,clear_before)
  local player = GetPlayerPed(-1)

  -- give weapons to player

  if clear_before then
    RemoveAllPedWeapons(player,true)
  end

  for k,weapon in pairs(weapons) do
    local hash = GetHashKey(k)
    local ammo = weapon.ammo or 0
    tAQUA.allowWeapon(k)
    GiveWeaponToPed(player, hash, ammo, false)
  end
end

function tAQUA.giveWeaponAmmo(hash, amount)
  SetPedAmmo(PlayerPedId(), hash, amount)
end

-- PLAYER CUSTOMIZATION

-- parse part key (a ped part or a prop part)
-- return is_proppart, index
local function a(b)
  if type(b)=="string"and string.sub(b,1,1)=="p"then 
      return true,tonumber(string.sub(b,2))
  else return false,tonumber(b)
  end 
end;
function tAQUA.getDrawables(c)
  local d,e=a(c)
  if d then 
      return GetNumberOfPedPropDrawableVariations(PlayerPedId(),e)
  else 
      return GetNumberOfPedDrawableVariations(PlayerPedId(),e)
  end 
end;
function tAQUA.getDrawableTextures(c,f)
  local d,e=a(c)
  if d then 
      return GetNumberOfPedPropTextureVariations(PlayerPedId(),e,f)
  else 
      return GetNumberOfPedTextureVariations(PlayerPedId(),e,f)
  end 
end;
function tAQUA.getCustomization()
  local g=PlayerPedId()
  local h={}
  h.modelhash=GetEntityModel(g)
  for i=0,20 do 
      h[i]={GetPedDrawableVariation(g,i),GetPedTextureVariation(g,i),GetPedPaletteVariation(g,i)}
  end;
  for i=0,10 do 
      h["p"..i]={GetPedPropIndex(g,i),math.max(GetPedPropTextureIndex(g,i),0)}
  end;
  return h 
end;
function tAQUA.setCustomization(h,j,k)
  if h then 
      local g=PlayerPedId()
      local l=nil;
      if h.modelhash~=nil then 
          l=h.modelhash 
      elseif h.model~=nil then 
          l=GetHashKey(h.model)
      end;
      local m=loadModel(l)
      local n=GetEntityModel(g)
      if m then 
          if n~=m or j then 
              local o=tAQUA.getWeapons()
              local p=GetEntityHealth(g)
              SetPlayerModel(PlayerId(),l)
              Wait(0)
              tAQUA.giveWeapons(o,true)
              if k==nil or k==false then 
                  tAQUA.setHealth(p)
              end;
              SetModelAsNoLongerNeeded(l)
              TriggerServerEvent("AQUA:reapplyFaceData")
              g=PlayerPedId()
          end;
          for q,r in pairs(h)do 
              if q~="model"and q~="modelhash"then 
                  if tonumber(q)then 
                      q=tonumber(q)
                  end;
                  local d,e=a(q)
                  if d then 
                      if r[1]<0 then 
                          ClearPedProp(g,e)
                      else 
                          SetPedPropIndex(g,e,r[1],r[2],r[3]or 2)
                      end 
                  else 
                      SetPedComponentVariation(g,e,r[1],r[2],r[3]or 2)
                  end 
              end 
          end 
      end 
  end 
end

RegisterNetEvent('checkAmmo')
AddEventHandler('checkAmmo', function()
    if IsPedArmed(PlayerPedId(), 4) then 
        TriggerServerEvent('sendAmmo', true)
    else
        TriggerServerEvent('sendAmmo', false)
    end
end)

function tAQUA.spawnAnim(a)
  if a ~= nil then
    DoScreenFadeOut(250)
    ExecuteCommand("hideui")
    local g = userdata.position or vector3(178.5132598877, -1007.5575561523, 29.329647064209)
    Wait(500)
    TriggerScreenblurFadeIn(100.0)
    RequestCollisionAtCoord(g.x, g.y, g.z)
    NewLoadSceneStartSphere(g.x, g.y, g.z, 100.0, 2)
    SetEntityCoordsNoOffset(PlayerPedId(), g.x, g.y, g.z, true, false, false)
    SetEntityVisible(PlayerPedId(), false, false)
    FreezeEntityPosition(PlayerPedId(), true)
    local h = GetGameTimer()
    while (not HaveAllStreamingRequestsCompleted(PlayerPedId()) or GetNumberOfStreamingRequests() > 0) and
        GetGameTimer() - h < 10000 do
        Wait(0)
        --print("Waiting for streaming requests to complete!")
    end
    NewLoadSceneStop()
    tAQUA.checkCustomization()
    TriggerServerEvent('AQUA:changeHairstyle')
    TriggerServerEvent('AQUA:getPlayerTattoos')
    TriggerEvent("AQUA:playGTAIntro")
    DoScreenFadeIn(1000)
    ShutdownLoadingScreen()
    ShutdownLoadingScreenNui()
    if not tAQUA.isDevMode() then
      SetFocusPosAndVel(g.x, g.y, g.z+1000)
      local spawnCam3 = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA", g.x, g.y, g.z+1000, 0.0, 0.0, 0.0, 65.0, 0, 2)
      SetCamActive(spawnCam3, true)
      RenderScriptCams(true, true, 0, 1, 0)
      local spawnCam4 = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA", g.x, g.y, g.z, 0.0, 0.0, 0.0, 65.0, 0, 2)
      SetCamActiveWithInterp(spawnCam4, spawnCam3, 5000, 0, 0)
      Wait(2500)
      ClearFocus()
      TriggerScreenblurFadeOut(2000.0)
      Wait(2000)
      DestroyCam(spawnCam3)
      DestroyCam(spawnCam4)
      RenderScriptCams(false, true, 2000, 0, 0)
    else
      TriggerScreenblurFadeOut(500.0)
    end
    print("[AQUA] cachedUserData.health", userdata.health)
    print("[AQUA] cachedUserData.armour", userdata.armour)
    SetEntityHealth(PlayerPedId(), userdata.health or 200)
    tAQUA.setArmour(userdata.armour)
    SetEntityVisible(PlayerPedId(), true, false)
    FreezeEntityPosition(PlayerPedId(), false)
    if not tAQUA.isDevMode() then
      Citizen.Wait(2000)
    end
    ExecuteCommand("showui")
  end
  spawning = false
end


AddEventHandler("AQUA:playGTAIntro",function()
  if not tAQUA.isDevMode() then
      SendNUIMessage({transactionType = "gtaloadin"})
  end
end)