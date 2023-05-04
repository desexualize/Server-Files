RECOIL = {}
RECOIL.threadTick = 750
RECOIL.weaponRate = {
  [GetHashKey('WEAPON_RE6')] = 5.0,
  [GetHashKey('WEAPON_AR15')] = 0.3,
  [GetHashKey('WEAPON_SIG516')] = 0.25,
  [GetHashKey('WEAPON_GLOCK22')] = 0.1,
  [GetHashKey('WEAPON_MP9')] = 0.15,
  [GetHashKey('WEAPON_REMINGTON870')] = 0.4,
  [GetHashKey('WEAPON_MOSSBERG590')] = 0.2,
  [GetHashKey('WEAPON_M4W')] = 0.3,
  [GetHashKey('WEAPON_HONEYBADGER')] = 0.2,
}

function RECOIL:initialize()
  local playerPed = RIVAL.getPlayerPed()
  while GAME.playing do
    Wait(RECOIL.threadTick)

    local hasWeapon, weaponHash = GetCurrentPedWeapon(playerPed)
    if not hasWeapon then
      RECOIL.threadTick = 750
      return
    end

    RECOIL.threadTick = 0

    if IsPedShooting(playerPed) then
      local recoilRate = RECOIL.weaponRate[weaponHash]

      if recoilRate and recoilRate ~= 0 then
        tv = 0
        if GetFollowPedCamViewMode() ~= 4 then
          repeat
            Wait(0)
            local pitch = GetGameplayCamRelativePitch()
            local rf = tonumber(tostring(math.random(1, 3) .. '.0'))
            SetGameplayCamRelativePitch(pitch + 0.1, rf)
            tv = tv + rf
          until tv >= recoilRate
        else
          repeat
            Wait(0)
            local pitch = GetGameplayCamRelativePitch()

            if recoilRate > 0.1 then
              local rf = tonumber(tostring(math.random(5, 7) .. '.0'))
              SetGameplayCamRelativePitch(pitch + rf, 1.2)
              tv = tv + rf
            else
              SetGameplayCamRelativePitch(pitch + 0.016, 0.333)
              tv = tv + 0.1
            end
          until tv >= recoilRate
        end
      end
    end
  end
end
