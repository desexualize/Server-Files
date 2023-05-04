STORM = {}
STORM.currentRadius = 0
STORM.moveTo = 0
STORM.minRadius = 0
STORM.canDamage = true
STORM.outside = false

function STORM:damagePlayer()
  while GAME.playing do
    Wait(200)

    -- Damages player
    if STORM.outside then
      AnimpostfxPlay('DMT_flight', 100)
      SetEntityHealth(RIVAL.getPlayerPed(), RIVAL.getPlayerHealth() - 1)
    end
  end
end

function STORM:createZone(zoneCoords)
  self.currentRadius = 1500.0
  self.moveTo = self.currentRadius - 200.0
  self.minRadius = 75.0
  self.red = 17

  CreateThread(self.damagePlayer)
  CreateThread(function()
    while GAME.playing do
      Wait(0)

      -- Player is outside storm
      self.outside = #(RIVAL.getPlayerPosition() - zoneCoords) * 1.9803 > self.currentRadius
      self.red = self.outside and 255 or 17

      DrawMarker(1, -- type
      zoneCoords.xy, zoneCoords.z - 100.0, -- coords
      0, -- dirX
      0, -- dirY
      0, -- dirZ
      0, -- rotX
      0, -- rotY
      0, -- rotZ
      self.currentRadius, -- scaleX
      self.currentRadius, -- scaleY
      self.currentRadius * 10, -- scaleZ
      self.red, -- red
      17, -- green
      17, -- blue
      100, -- alpha
      0, -- bobUpAndDown
      0, -- faceCamera
      0, -- p19
      0, -- rotate
      0, -- textureDict
      0, -- textureName
      0 -- drawOnEnts
      )
    end
  end)

  CreateThread(function()
    self.runThread = true
    while self.runThread do
      -- Shrinks zone every 2 min
      Wait(60 * 1000 * 2)

      CreateThread(function()
        self.moveTo = self.currentRadius - 200.0
        if self.minRadius >= self.currentRadius then
          self.runThread = false
        end

        while self.currentRadius > self.moveTo and self.runThread do
          Wait(10)

          self.currentRadius = self.currentRadius - 0.15
        end
      end)
    end
  end)
end

RegisterNetEvent('RIVAL::createStorm', function(zoneCoords)
  STORM:createZone(zoneCoords)
end)

