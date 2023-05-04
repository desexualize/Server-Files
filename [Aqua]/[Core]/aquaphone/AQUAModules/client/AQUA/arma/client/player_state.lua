
local state_ready = false

AddEventHandler("playerSpawned",function() -- delay state recording
  state_ready = false
  Citizen.CreateThread(function()
    Citizen.Wait(2000)
    state_ready = true
  end)
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(3000)
    if IsPlayerPlaying(PlayerId()) and state_ready then
      ARMAserver.updateWeapons({tARMA.getWeapons()})
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(60000)
    ARMAserver.UpdatePlayTime()
  end
end)

local userdata = {}
Citizen.CreateThread(function()
    print("[ARMA] Loading cached user data.")
    userdata = json.decode(GetResourceKvpString("arma_userdata") or "{}")
    if type(userdata) ~= "table" then
      userdata = {}
        print("[ARMA] Loading cached user data - failed to load setting to default.")
    else
        print("[ARMA] Loading cached user data - loaded.")
    end
end)
function tARMA.updateCustomization(b)
    local c = tARMA.getCustomization()
    if c.modelhash ~= 0 and IsModelValid(c.modelhash) then
      userdata.customisation = c
      if b then
        SetResourceKvp("arma_userdata", json.encode(userdata))
      end
    end
end
function tARMA.updateHealth(b)
  userdata.health = GetEntityHealth(PlayerPedId())
  if b then
      SetResourceKvp("arma_userdata", json.encode(userdata))
  end
end
function tARMA.updateArmour(b)
  userdata.armour = GetPedArmour(PlayerPedId())
  if b then
      SetResourceKvp("arma_userdata", json.encode(userdata))
  end
end
local d = vector3(0.0, 0.0, 0.0)
function tARMA.updatePos(b)
    local e = GetEntityCoords(PlayerPedId())
    if e.z > -150.0 and #(e - d) > 15.0 then
        userdata.position = e
        if b then
            SetResourceKvp("arma_userdata", json.encode(userdata))
        end
    end
end
Citizen.CreateThread(function()
    Wait(30000)
    while true do
        Wait(5000)
        if not tARMA.isInHouse() and not inOrganHeist and not tARMA.isPlayerInRedZone() and not tARMA.isInSpectate() then
          tARMA.updatePos()
        end
        if not tARMA.isStaffedOn() and not customizationSaveDisabled and not spawning and not tARMA.isPlayerInAnimalForm() then
            tARMA.updateCustomization()
        end
        tARMA.updateHealth()
        tARMA.updateArmour()
        SetResourceKvp("arma_userdata", json.encode(userdata))
    end
end)

function tARMA.checkCustomization()
    local c = userdata.customisation
    if c == nil or c.modelhash == 0 or not IsModelValid(c.modelhash) then
        tARMA.setCustomization(getDefaultCustomization(), true, true)
    else
        tARMA.setCustomization(c, true, true)
    end
end

function getDefaultCustomization()
  local s = {}
  s = {}
  s.model = "mp_m_freemode_01"
  for t = 0, 19 do
      s[t] = {0, 0}
  end
  s[0] = {0, 0}
  s[1] = {0, 0}
  s[2] = {47, 0}
  s[3] = {5, 0}
  s[4] = {4, 0}
  s[5] = {0, 0}
  s[6] = {7, 0}
  s[7] = {51, 0}
  s[8] = {0, 240}
  s[9] = {0, 1}
  s[10] = {0, 0}
  s[11] = {5, 0}
  s[12] = {4, 0}
  s[15] = {0, 2}
  return s
end

function tARMA.spawnAnim(a)
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
    tARMA.checkCustomization()
    TriggerServerEvent('ARMA:changeHairstyle')
    TriggerServerEvent('ARMA:getPlayerTattoos')
    TriggerEvent("ARMA:playGTAIntro")
    DoScreenFadeIn(1000)
    ShutdownLoadingScreen()
    ShutdownLoadingScreenNui()
    if not tARMA.isDevMode() then
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
    print("[ARMA] cachedUserData.health", userdata.health)
    print("[ARMA] cachedUserData.armour", userdata.armour)
    SetEntityHealth(PlayerPedId(), userdata.health or 200)
    tARMA.setArmour(userdata.armour)
    SetEntityVisible(PlayerPedId(), true, false)
    FreezeEntityPosition(PlayerPedId(), false)
    if not tARMA.isDevMode() then
      Citizen.Wait(2000)
    end
    ExecuteCommand("showui")
  end
  spawning = false
end


AddEventHandler("ARMA:playGTAIntro",function()
  if not tARMA.isDevMode() then
      SendNUIMessage({transactionType = "gtaloadin"})
  end
end)