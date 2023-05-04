function RIVAL.createBlip(blip, sprite, color, label)
  SetBlipSprite(blip, sprite)
  SetBlipDisplay(blip, 4)
  SetBlipScale(blip, 0.9)
  SetBlipColour(blip, color)
  SetBlipAsShortRange(blip, true)
  AddTextEntry('MAPBLIP', label)
  BeginTextCommandSetBlipName('MAPBLIP')
  EndTextCommandSetBlipName(blip)
end

function RIVAL:getMinimapAnchor()
  local safezone = GetSafeZoneSize()
  local safezone_x = 1.0 / 20.0
  local safezone_y = 1.0 / 20.0
  local aspect_ratio = GetAspectRatio(0)
  local res_x, res_y = GetActiveScreenResolution()
  local xscale = 1.0 / res_x
  local yscale = 1.0 / res_y
  local Minimap = {}
  Minimap.width = xscale * (res_x / (4 * aspect_ratio))
  Minimap.height = yscale * (res_y / 5.674)
  Minimap.left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
  Minimap.bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
  Minimap.right_x = Minimap.left_x + Minimap.width
  Minimap.top_y = Minimap.bottom_y - Minimap.height
  Minimap.x = Minimap.left_x
  Minimap.y = Minimap.top_y
  Minimap.xunit = xscale
  Minimap.yunit = yscale

  return Minimap
end

function RIVAL:getGroundCoords(x, y)
  local foundGround = true
  local startZ = 1500
  local z = startZ

  while foundGround and z > 0 do
    local _foundGround, _z = GetGroundZFor_3dCoord(x + 0.0, y + 0.0, z - 1.0)
    if _foundGround then
      z = _z + 0.0
    end
    foundGround = _foundGround

    Wait(0)
  end

  if z == startZ then
    return
  end

  return z + 0.0
end
