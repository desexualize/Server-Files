COMPASS = {}
COMPASS.directions = {north = -300, east = -400, south = -100, west = -200, other = -500}

function COMPASS:rangePercent(min, max, amt)
  return (((amt - min) * 400) / (max - min)) / 400
end

function COMPASS:lerp(min, max, amt)
  return (1 - amt) * min + amt * max
end

function COMPASS:calculateDirection(direction)
  if direction < 90 then
    return self:lerp(self.directions['north'], self.directions['east'], direction / 90)
  elseif direction < 180 then
    return self:lerp(self.directions['east'], self.directions['other'], self:rangePercent(90, 180, direction))
  elseif direction < 270 then
    return self:lerp(self.directions['south'], self.directions['west'], self:rangePercent(180, 270, direction))
  end

  return self:lerp(self.directions['west'], self.directions['north'], self:rangePercent(270, 360, direction))
end

function COMPASS:handleDirection()
  CreateThread(function()
    local cachedHeading = 0

    while GAME.playing do
      Wait(10)

      local entityHeading = GetEntityHeading(PlayerPedId())
      local camHeading = GetGameplayCamRelativeHeading()
      local heading = entityHeading < 0 and camHeading - entityHeading or camHeading + entityHeading

      if heading ~= cachedHeading then
        cachedHeading = heading

        NUI:sendCommand('SET_COMPASS_HEADING', math.floor(COMPASS:calculateDirection(-heading % 360)) + 140)
      end
    end
  end)
end
