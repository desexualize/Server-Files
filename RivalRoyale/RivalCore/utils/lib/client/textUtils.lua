function Draw3DText(text, coords, scale, color)
  local r, g, b = table.unpack(color)
  local onScreen, x, y = GetScreenCoordFromWorldCoord(coords.x, coords.y, coords.z)

  if onScreen then
    SetTextScale(scale, scale)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(r, g, b, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    -- SetTextOutline()
    SetTextEntry('STRING')
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(x, y)
  end
end

function DrawSquadText(x, y, z, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)

  if onScreen then
    SetTextScale(0.4, 0.4)
    SetTextFont(Inter)
    -- SetTextProportional(1)
    -- SetTextDropshadow(0, 0, 0, 0, 55)
    -- SetTextEdge(2, 0, 0, 0, 150)
    -- SetTextDropShadow()
    SetTextColour(255, 255, 255, 255)
    -- SetTextOutline()

    -- SetTextColour(253, 255, 133, 255)

    SetTextEntry('STRING')
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
  end
end

function DrawReadyText(x, y, z, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)

  if onScreen then
    SetTextScale(0.3, 0.3)
    SetTextFont(Inter)

    if text == 'READY' then
      SetTextColour(253, 255, 133, 255)
    else
      SetTextColour(212, 212, 212, 255)
    end

    SetTextEntry('STRING')
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
  end
end

function DrawText2D(text, x, y, a)
  SetTextScale(0.25, 0.25)
  SetTextFont(0)
  SetTextColour(255, 255, 255, a)
  SetTextCentre(true)
  BeginTextCommandDisplayText('STRING')
  AddTextComponentSubstringPlayerName(text)
  EndTextCommandDisplayText(x, y)
  ClearDrawOrigin()
end

function DrawText2DTweenUp(text, x, y)
  local moveHeight, speed = 0.05, 0.2

  CreateThread(function()
    local height = y
    local total_ = height - (y - moveHeight)
    local total = height - (y - moveHeight)

    while height > y - moveHeight do
      DrawText2D(text, x, height, math.floor(255 * (total / total_)))
      height = height - 0.003 * speed
      total = total - 0.003 * speed
      Wait(0)
    end
  end)
end
