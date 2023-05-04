VENDOR = {}
VENDOR.vendorItems = {}
VENDOR.displayed = false
VENDOR.threadTick = 1000
VENDOR.lastPed = 0
VENDOR.pedModel = 'g_m_y_lost_02'
VENDOR.placements = SHARED_CONFIG.vendorCoords

function VENDOR:openMenu()
  NUI:redirect('/Vendor')
  NUI:toggleFocus(true)
  DisplayRadar(false)
  VENDOR.displayed = true
end

function VENDOR:closeMenu()
  NUI:redirect('/InGame')

  local anchor = RIVAL:getMinimapAnchor()
  local w, h = GetActiveScreenResolution()
  local data = TriggerServerCallback('RIVAL::fetchGameInfo')

  NUI:sendCommand('SET_GAME_INFO_ANCHOR', {width = anchor.width * w, x = anchor.x * w, y = anchor.y * h - (h / 30)})
  NUI:sendCommand('SET_GAME_INFO', {cash = data.cash, players = data.players, kills = data.kills})
  NUI:toggleFocus(false)
  DisplayRadar(true)
  VENDOR.displayed = false
  VENDOR.lastPed = 0

  PlayAmbientSpeech1(VENDOR.lastPed, 'GENERIC_BYE', 'SPEECH_PARAMS_STANDARD')
end

CreateThread(function()
  local pedModel = RIVAL:loadModel(VENDOR.pedModel)

  for coords, data in pairs(VENDOR.placements) do
    local ped = CreatePed(1, pedModel, coords, data.heading)
    local blip = AddBlipForCoord(coords)

    VENDOR.placements[coords].npc = ped
    SetEntityCanBeDamaged(ped, false)
    SetPedAsEnemy(ped, false)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskSetBlockingOfNonTemporaryEvents(ped, true)
    SetPedResetFlag(ped, 249, true)
    SetPedConfigFlag(ped, 185, true)
    SetPedConfigFlag(ped, 108, true)
    SetPedCanEvasiveDive(ped, false)
    SetPedCanRagdollFromPlayerImpact(ped, false)
    SetPedConfigFlag(ped, 208, true)

    Wait(1000)

    FreezeEntityPosition(ped, true)
    RIVAL.createBlip(blip, 150, 40, 'Vendor')
  end
end)

function VENDOR:getClosest()
  for coords, data in pairs(VENDOR.placements) do
    local dist = #(RIVAL.getPlayerPosition() - coords)

    if dist < 10.0 then
      return coords, data.npc, dist
    end
  end
end

function VENDOR:handleInteraction()
  while true do
    Wait(VENDOR.threadTick)

    local currentVendor, vendorPed, dist = VENDOR:getClosest()

    if currentVendor and vendorPed ~= 0 then
      VENDOR.threadTick = 0

      if dist < 2.0 then
        if not VENDOR.displayed then
          DrawHelpMsg('Press ~INPUT_CONTEXT~ to interact with ~y~Vendor.')

          if IsControlJustPressed(1, 51) then
            PlayAmbientSpeech1(vendorPed, 'GENERIC_HI', 'SPEECH_PARAMS_STANDARD')
            VENDOR.lastPed = vendorPed
            VENDOR:openMenu()
          end
        end
      end
    else
      VENDOR.threadTick = 1000
    end
  end
end

RegisterSafeNUICallback('RIVAL::exitVendor', VENDOR.closeMenu)

RegisterSafeNUICallback('RIVAL::tryPurchase', function(cart)
  if #cart > 0 then
    TriggerServerCallback('RIVAL::tryPurchase', cart)
    PlaySoundFrontend(-1, 'LOCAL_PLYR_CASH_COUNTER_COMPLETE', 'DLC_HEISTS_GENERAL_FRONTEND_SOUNDS')
    VENDOR:closeMenu()
  end
end)

RegisterNUICallback('RIVAL::requestVendorPrices', function(_, cb)
  cb(VENDOR.vendorItems)
end)

RegisterNUICallback('RIVAL::fetchCash', function(_, cb)
  local cash = TriggerServerCallback('RIVAL::fetchCash')
  cb(cash)
end)

CreateThread(function()
  for itemName, itemData in pairs(SHARED_CONFIG.inventoryItems) do
    VENDOR.vendorItems[itemName] = itemData.price * 2
  end
end)
