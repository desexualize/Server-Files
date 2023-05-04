local function drawRct(x, y, Width, height, r, g, b, a)
  DrawRect(x + Width / 2, y + height / 2, Width, height, r, g, b, a, 0)
end

local function GetMinimapAnchor()
  local safezone = GetSafeZoneSize()
  local safezone_x = 1.0 / 20.0
  local safezone_y = 1.0 / 20.0
  local aspect_ratio = GetAspectRatio(0)
  local res_x, res_y = GetActiveScreenResolution()
  local xscale = 1.0 / res_x
  local yscale = 1.0 / res_y
  local Minimap = {}
  Minimap.Width = xscale * (res_x / (4 * aspect_ratio))
  Minimap.height = yscale * (res_y / 5.674)
  Minimap.Left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
  Minimap.Bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
  Minimap.right_x = Minimap.Left_x + Minimap.Width
  Minimap.top_y = Minimap.Bottom_y - Minimap.height
  Minimap.x = Minimap.Left_x
  Minimap.y = Minimap.top_y
  Minimap.xunit = xscale
  Minimap.yunit = yscale
  return Minimap
end

function GAME:handleHealth()
  local playerPed = RIVAL.getPlayerPed()
  DisplayRadar(true)

  while GAME.playing or GAME.waiting do
    Wait(0)

    local UI = GetMinimapAnchor()
    local HP = (RIVAL.getPlayerHealth() - 100) / 100.0
    if HP < 0 then
      HP = 0.0
    end

    if HP == 0.99 then
      HP = 1.0
    end

    local Armour = GetPedArmour(playerPed) / 100.0
    if Armour > 1.0 then
      Armour = 1.0
    end

    drawRct(UI.Left_x + 0.001, UI.Bottom_y - 0.014, UI.Width - 0.002, 0.01, 0, 0, 0, 127)
    drawRct(UI.Left_x + 0.001, UI.Bottom_y - 0.014, (UI.Width - 0.002) * Armour, 0.01, 255, 255, 255, 255)
    drawRct(UI.Left_x + 0.001, UI.Bottom_y - 0.001, UI.Width - 0.002, 0.01, 0, 0, 0, 127)
    drawRct(UI.Left_x + 0.001, UI.Bottom_y - 0.001, (UI.Width - 0.002) * HP, 0.01, 253, 255, 133, 255)

    DontTiltMinimapThisFrame()
  end
end
