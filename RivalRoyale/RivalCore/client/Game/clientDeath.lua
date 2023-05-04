DEATH_SCREEN = {}
DEATH_SCREEN.deathCam = 0
DEATH_SCREEN.boneHashes = {
  {40269, false},
  {28252, false},
  {45509, false},
  {61163, false},
  {10706, false},
  {65245, false},
  {57597, false},
  {51826, false},
  {24819, false},
  {14201, false},
  {18905, false},
  {39317, false},
  {31086, false},
}

local function randomizeOffset()
  return vector3(math.random(-1.0, 1.0), math.random(-1.0, 1.0), math.random(1.0, 2.0))
end

local function getRandomBone()
  local returnBone

  repeat
    local randomBone = DEATH_SCREEN.boneHashes[math.random(1, #DEATH_SCREEN.boneHashes)]

    if not randomBone[2] then
      returnBone = randomBone[1]
      DEATH_SCREEN.boneHashes[returnBone] = true
    end
  until returnBone ~= nil

  return returnBone
end

function DEATH_SCREEN:playDeathEffect()
  AnimpostfxStop('RaceTurbo')
  ClearTimecycleModifier()

  local playerPed = RIVAL.getPlayerPed()
  local coords = RIVAL.getPlayerPosition()
  DEATH_SCREEN.deathCam = CreateCameraWithParams('DEFAULT_SCRIPTED_CAMERA', vector3(0, 0, 0), 0.0, 0.0, 0.0, 65.0, 0, 2)

  RenderScriptCams(true, false, 0, true, true)
  SetCamActive(DEATH_SCREEN.deathCam, true)
  SetCamCoord(DEATH_SCREEN.deathCam, coords + randomizeOffset())
  PointCamAtPedBone(DEATH_SCREEN.deathCam, playerPed, 31086, 0.0, 0.0, 0.0, true)
  SetCamNearClip(DEATH_SCREEN.deathCam, 0.0)
  SetTransitionTimecycleModifier('BulletTimeDark', 2.0)
  SetTimeScale(0.22)

  CreateThread(function()
    AnimpostfxPlay('WeaponUpgrade', 750, false)
    local stage = 1

    while true do
      Wait(500)

      local pedBone = getRandomBone()
      stage = stage + 1

      SetCamCoord(DEATH_SCREEN.deathCam, RIVAL.getPlayerPosition() + randomizeOffset())
      PointCamAtPedBone(DEATH_SCREEN.deathCam, playerPed, pedBone, 0.0, 0.0, 0.0, true)

      if stage > 2 then
        break
      end
    end

    -- ClearTimecycleModifier()
    SetTimeScale(1.0)
    DestroyCam(DEATH_SCREEN.deathCam, true)
    RenderScriptCams(false, false, 0, false, false)
  end)
end
