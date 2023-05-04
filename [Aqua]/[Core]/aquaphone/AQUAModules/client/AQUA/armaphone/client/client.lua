--====================================================================================
-- #Author: Jonathan D @ Gannon
--====================================================================================

-- Configuration
local KeyToucheCloseEvent = {
  { code = 172, event = 'ArrowUp' },
  { code = 173, event = 'ArrowDown' },
  { code = 174, event = 'ArrowLeft' },
  { code = 175, event = 'ArrowRight' },
  { code = 176, event = 'Enter' },
  { code = 177, event = 'Backspace' },
}

local menuIsOpen = false
local contacts = {}
local messages = {}
local myPhoneNumber = ''
local isDead = false
local USE_RTC = false
local useMouse = false
local ignoreFocus = false
local takePhoto = false
local hasFocus = false
local TokoVoipID = nil
globalIsDND = false

local currentPlaySound = false
local soundDistanceMax = 8.0


--====================================================================================
--  Check si le joueurs poséde un téléphone
--  Callback true or false
--====================================================================================
function hasPhone (cb)
  cb(true)
end
--====================================================================================
--  Que faire si le joueurs veut ouvrir sont téléphone n'est qu'il en a pas ?
--====================================================================================
function ShowNoPhoneWarning ()
end


RegisterCommand("openphone", function()
  TriggerEvent("ARMA:phoneToggledDvsa")
  if GetEntityHealth(PlayerPedId()) <= 102 then return end
  if exports["arma"]:isHandcuffed() then return end
  if exports["arma"]:isPlayerInPrison() and not exports["arma"]:nearPrisonPayPhone() then return end
  if takePhoto ~= true then
      TogglePhone()
  end
  TriggerServerEvent('ARMA:getGarageFolders')
end)

RegisterKeyMapping('openphone', 'Open Phone', 'keyboard', 'k')

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(0)
      if not menuIsOpen and isDead then
          DisableControlAction(0, 311, true)
      end
      if takePhoto ~= true then
          if menuIsOpen == true then
              for _, value in ipairs(KeyToucheCloseEvent) do
                  if IsControlJustPressed(1, value.code) then
                      SendNUIMessage({keyUp = value.event})
                  end
              end
              if useMouse == true and hasFocus == ignoreFocus then
                local nuiFocus = not hasFocus
                SetNuiFocus(nuiFocus, nuiFocus)
                hasFocus = nuiFocus
              elseif useMouse == false and hasFocus == true then
                SetNuiFocus(false, false)
                hasFocus = false
              end
          else
              if hasFocus then
                  SetNuiFocus(false, false)
                  hasFocus = false
              end
          end
      end
  end
end)



--====================================================================================
--  Active ou Deactive une application (appName => config.json)
--====================================================================================
RegisterNetEvent('ARMA:setEnableApp')
AddEventHandler('ARMA:setEnableApp', function(appName, enable)
  SendNUIMessage({event = 'setEnableApp', appName = appName, enable = enable })
end)

--====================================================================================
--  Gestion des appels fixe
--====================================================================================
function startFixeCall (fixeNumber)
    local number = ''
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 10)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        number =  GetOnscreenKeyboardResult()
    end
    if number ~= '' then
        TriggerEvent('ARMA:autoCall', number, {
            useNumber = fixeNumber
        })
        PhonePlayCall(true)
    end
end

function TakeAppel (infoCall)
  TriggerEvent('ARMA:autoAcceptCall', infoCall)
end

RegisterNetEvent("ARMA:notifyFixePhoneChange")
AddEventHandler("ARMA:notifyFixePhoneChange", function(_PhoneInCall)
  PhoneInCall = _PhoneInCall
end)

--[[
  Affiche les imformations quant le joueurs est proche d'un fixe
--]]
function showFixePhoneHelper (coords)
  for number, data in pairs(Config.FixePhone) do
    local dist = GetDistanceBetweenCoords(
      data.coords.x, data.coords.y, data.coords.z,
      coords.x, coords.y, coords.z, 1)
    if dist <= 2.5 then
      BeginTextCommandDisplayHelp("STRING")
      AddTextComponentSubstringPlayerName(_U('use_fixed', data.name, number))
      EndTextCommandDisplayHelp(0, 0, 0, -1)
      if IsControlJustPressed(1, Config.KeyTakeCall) then
        startFixeCall(number)
      end
      break
    end
  end
end

function PlaySoundJS (sound, volume)
  SendNUIMessage({ event = 'playSound', sound = sound, volume = volume })
end

function SetSoundVolumeJS (sound, volume)
  SendNUIMessage({ event = 'setSoundVolume', sound = sound, volume = volume})
end

function StopSoundJS (sound)
  SendNUIMessage({ event = 'stopSound', sound = sound})
end

RegisterNetEvent("ARMA:forceOpenPhone")
AddEventHandler("ARMA:forceOpenPhone", function(_myPhoneNumber)
  if menuIsOpen == false then
    TogglePhone()
  end
end)

--====================================================================================
--  Events
--====================================================================================
RegisterNetEvent("ARMA:myPhoneNumber")
AddEventHandler("ARMA:myPhoneNumber", function(_myPhoneNumber)
  myPhoneNumber = _myPhoneNumber
  SendNUIMessage({event = 'updateMyPhoneNumber', myPhoneNumber = myPhoneNumber})
end)

RegisterNetEvent("ARMA:contactList")
AddEventHandler("ARMA:contactList", function(_contacts)
  SendNUIMessage({event = 'updateContacts', contacts = _contacts})
  contacts = _contacts
end)

RegisterNetEvent("ARMA:allMessage")
AddEventHandler("ARMA:allMessage", function(allmessages)
  SendNUIMessage({event = 'updateMessages', messages = allmessages})
  messages = allmessages
end)


RegisterNetEvent("ARMA:receiveMessage")
AddEventHandler("ARMA:receiveMessage", function(message)
  if exports["arma"]:isHandcuffed() then return end
  if exports["arma"]:isPlayerInPrison() and not exports["arma"]:nearPrisonPayPhone() then return end
  SendNUIMessage({event = 'newMessage', message = message})
  table.insert(messages, message)
  if not globalIsDND then
    if message.owner == 0 then
      local text = "~o~New Message"
      if Config.ShowNumberNotification == true then
        text = string.format("~g~New message from %s", message.transmitter)
        for _,contact in pairs(contacts) do
          if contact.number == message.transmitter then
            text = string.format("~g~New message from ~g~%s", contact.display)
            break
          end
        end
      end
      BeginTextCommandThefeedPost("STRING")
      AddTextComponentSubstringPlayerName(text)
      EndTextCommandThefeedPostTicker(false, false)
      exports["arma"]:playSound("iphone_ping")
    end
  end
end)

function notify(msg)
    if not globalHideUi then
        BeginTextCommandThefeedPost("STRING")
        AddTextComponentSubstringPlayerName(msg)
        EndTextCommandThefeedPostTicker(true, false)
    end
end


--====================================================================================
--  Function client | Contacts
--====================================================================================
function addContact(display, num)
    TriggerServerEvent('ARMA:addContact', display, num)
end

function deleteContact(num)
    TriggerServerEvent('ARMA:deleteContact', num)
end
--====================================================================================
--  Function client | Messages
--====================================================================================
function sendMessage(num, message)
  TriggerServerEvent('ARMA:sendMessage', num, message)
end

function deleteMessage(msgId)
  print("msgId", msgId)
  TriggerServerEvent('ARMA:deleteMessage', msgId)
  for k, v in ipairs(messages) do
    if v.id == msgId then
      table.remove(messages, k)
      SendNUIMessage({event = 'updateMessages', messages = messages})
      return
    end
  end
end

function deleteMessageContact(num)
  TriggerServerEvent('ARMA:deleteMessageNumber', num)
end

function deleteAllMessage()
  TriggerServerEvent('ARMA:deleteAllMessage')
end

function setReadMessageNumber(num)
  TriggerServerEvent('ARMA:setReadMessageNumber', num)
  for k, v in ipairs(messages) do
    if v.transmitter == num then
      v.isRead = 1
    end
  end
end

function requestAllMessages()
  TriggerServerEvent('ARMA:requestAllMessages')
end

function requestAllContact()
  TriggerServerEvent('ARMA:requestAllContact')
end



--====================================================================================
--  Function client | Appels
--====================================================================================
local aminCall = false
local inCall = false

RegisterNetEvent("ARMA:waitingCall")
AddEventHandler("ARMA:waitingCall", function(infoCall, initiator)
    if exports["arma"]:isHandcuffed() then return end
    if exports["arma"]:isPlayerInPrison() and not exports["arma"]:nearPrisonPayPhone() then return end
    if initiator or (not initiator and not globalIsDND) then
        SendNUIMessage({event = 'waitingCall', infoCall = infoCall, initiator = initiator})
        if menuIsOpen == false then
            TogglePhone(false)
        end
        if initiator == true then
            PhonePlayCall()
        end
    end
end)

RegisterNetEvent("ARMA:onClientSpawn")
AddEventHandler("ARMA:onClientSpawn", function(user_id, first_spawn)
    if first_spawn then
        SendNUIMessage({event="ask_dnd"})
    end
end)

RegisterNetEvent("ARMA:acceptCall")
AddEventHandler("ARMA:acceptCall", function(infoCall, initiator)
  if exports["arma"]:isHandcuffed() then return end
  if exports["arma"]:isPlayerInPrison() and not exports["arma"]:nearPrisonPayPhone() then return end
  if inCall == false and USE_RTC == false then
    inCall = true
    if Config.UseMumbleVoIP then
      exports["pma-voice"]:setCallChannel(infoCall.id+1)
    elseif Config.UseTokoVoIP then
      exports.tokovoip_script:addPlayerToRadio(infoCall.id + 120)
      TokoVoipID = infoCall.id + 120
    else
      NetworkSetVoiceChannel(infoCall.id + 1)
      NetworkSetTalkerProximity(0.0)
    end
  end
  if menuIsOpen == false then
    TogglePhone()
  end
  PhonePlayCall()
  SendNUIMessage({event = 'acceptCall', infoCall = infoCall, initiator = initiator})
end)

RegisterNetEvent("ARMA:rejectCall")
AddEventHandler("ARMA:rejectCall", function(infoCall)
  if inCall == true then
    inCall = false
    PhonePlayText()
    if Config.UseMumbleVoIP then
      exports["pma-voice"]:setCallChannel(0)
    elseif Config.UseTokoVoIP then
      exports.tokovoip_script:removePlayerFromRadio(TokoVoipID)
      TokoVoipID = nil
    else
      NetworkClearVoiceChannel()
      NetworkSetTalkerProximity(2.5)
    end
  end
  SendNUIMessage({event = 'rejectCall', infoCall = infoCall})
  exports["arma"]:playSound("hangup")
end)


RegisterNetEvent("ARMA:sendCallHistory")
AddEventHandler("ARMA:sendCallHistory", function(historique)
  SendNUIMessage({event = 'historiqueCall', historique = historique})
end)


function startCall (phone_number, rtcOffer, extraData)
  if rtcOffer == nil then
    rtcOffer = ''
  end
  TriggerServerEvent('ARMA:startCall', phone_number, rtcOffer, extraData)
end

function acceptCall (infoCall, rtcAnswer)
  TriggerServerEvent('ARMA:acceptCall', infoCall, rtcAnswer)
end

function rejectCall(infoCall)
  TriggerServerEvent('ARMA:rejectCall', infoCall)
end

function ignoreCall(infoCall)
  TriggerServerEvent('ARMA:ignoreCall', infoCall)
end

function requestHistoriqueCall()
  TriggerServerEvent('ARMA:getHistoriqueCall')
end

function appelsDeleteHistorique (num)
  TriggerServerEvent('ARMA:appelsDeleteHistorique', num)
end

function appelsDeleteAllHistorique ()
  TriggerServerEvent('ARMA:appelsDeleteAllHistorique')
end


--====================================================================================
--  Event NUI - Appels
--====================================================================================

RegisterNUICallback('startCall', function (data, cb)
  --exports["arma"]:debugLog("attempting to call:", data.numero)
  startCall(data.numero, data.rtcOffer, data.extraData)
  cb()
end)

RegisterNUICallback('acceptCall', function (data, cb)
  acceptCall(data.infoCall, data.rtcAnswer)
  cb()
end)
RegisterNUICallback('rejectCall', function (data, cb)
  rejectCall(data.infoCall)
  cb()
end)

RegisterNUICallback('ignoreCall', function (data, cb)
  ignoreCall(data.infoCall)
  cb()
end)
RegisterNUICallback('dnd', function (data, cb)
    --exports["arma"]:debugLog("GOT NUI CALLBACK FOR DND", data.dnd)

    if data.dnd == "true" or data.dnd == true then
        data.dnd = true
    else
        data.dnd = false
    end

    globalIsDND = data.dnd
    cb()
end)

RegisterNUICallback('notififyUseRTC', function (use, cb)
  USE_RTC = use
  if USE_RTC == true and inCall == true then
    inCall = false
    NetworkClearVoiceChannel()
    if Config.UseTokoVoIP then
      exports.tokovoip_script:removePlayerFromRadio(TokoVoipID)
      TokoVoipID = nil
    else
      NetworkSetTalkerProximity(2.5)
    end
  end
  cb()
end)


RegisterNUICallback('onCandidates', function (data, cb)
  TriggerServerEvent('ARMA:candidates', data.id, data.candidates)
  cb()
end)

RegisterNetEvent("ARMA:candidates")
AddEventHandler("ARMA:candidates", function(candidates)
  SendNUIMessage({event = 'candidatesAvailable', candidates = candidates})
end)



RegisterNetEvent('ARMA:autoCall')
AddEventHandler('ARMA:autoCall', function(number, extraData)
  if number ~= nil then
    SendNUIMessage({ event = "autoStartCall", number = number, extraData = extraData})
  end
end)

RegisterNetEvent('ARMA:autoCallNumber')
AddEventHandler('ARMA:autoCallNumber', function(data)
  TriggerEvent('ARMA:autoCall', data.number)
end)

RegisterNetEvent('ARMA:autoAcceptCall')
AddEventHandler('ARMA:autoAcceptCall', function(infoCall)
  SendNUIMessage({ event = "autoAcceptCall", infoCall = infoCall})
end)

--====================================================================================
--  Gestion des evenements NUI
--====================================================================================
RegisterNUICallback('log', function(data, cb)
  print(data)
  cb()
end)
RegisterNUICallback('focus', function(data, cb)
  cb()
end)
RegisterNUICallback('blur', function(data, cb)
  cb()
end)
RegisterNUICallback('reponseText', function(data, cb)
    local limit = data.limit or 255
    local text = data.text or ''
    local ask = data.ask or "Enter:"
    exports["arma"]:prompt(ask, text, function(text)
        cb(json.encode({text = text}))
    end)
end)
--====================================================================================
--  Event - Messages
--====================================================================================
RegisterNUICallback('getMessages', function(data, cb)
  cb(json.encode(messages))
end)
RegisterNUICallback('sendMessage', function(data, cb)
  if data.message == '%pos%' then
    local myPos = GetEntityCoords(PlayerPedId())
    data.message = 'GPS: ' .. myPos.x .. ', ' .. myPos.y
  end
  TriggerServerEvent('ARMA:sendMessage', data.phoneNumber, data.message)
end)
RegisterNUICallback('deleteMessage', function(data, cb)
  deleteMessage(data.id)
  cb()
end)
RegisterNUICallback('deleteMessageNumber', function (data, cb)
  deleteMessageContact(data.number)
  cb()
end)
RegisterNUICallback('deleteAllMessage', function (data, cb)
  deleteAllMessage()
  cb()
end)
RegisterNUICallback('setReadMessageNumber', function (data, cb)
  setReadMessageNumber(data.number)
  cb()
end)
--====================================================================================
--  Event - Contacts
--====================================================================================
RegisterNUICallback('addContact', function(data, cb)
  print(json.encode(data))
  TriggerServerEvent('ARMA:addContact', data.display, data.phoneNumber)
end)
RegisterNUICallback('updateContact', function(data, cb)
  TriggerServerEvent('ARMA:updateContact', data.id, data.display, data.phoneNumber)
end)
RegisterNUICallback('deleteContact', function(data, cb)
  TriggerServerEvent('ARMA:deleteContact', data.id)
end)
RegisterNUICallback('getContacts', function(data, cb)
  cb(json.encode(contacts))
end)
RegisterNUICallback('setGPS', function(data, cb)
  SetNewWaypoint(tonumber(data.x), tonumber(data.y))
  cb()
end)

-- Add security for event (leuit#0100)
RegisterNUICallback('callEvent', function(data, cb)
  local eventName = data.eventName or ''
  if string.match(eventName, 'gcphone') then
    if data.data ~= nil then
      TriggerEvent(data.eventName, data.data)
    else
      TriggerEvent(data.eventName)
    end
  else
    print('Event not allowed')
  end
  cb()
end)
RegisterNUICallback('useMouse', function(um, cb)
  useMouse = um
end)
RegisterNUICallback('deleteALL', function(data, cb)
  TriggerServerEvent('ARMA:deleteALL')
  cb()
end)

function TogglePhone(anim)
  --exports["arma"]:debugLog("Toggling arma Phone.")
  if anim == nil then anim = true end
  menuIsOpen = not menuIsOpen
  SendNUIMessage({show = menuIsOpen})
  if menuIsOpen == true then
    if anim then
      PhonePlayIn()
    end
    TriggerEvent('ARMA:setMenuStatus', true)
  else
    if anim then
      PhonePlayOut()
    end
    TriggerEvent('ARMA:setMenuStatus', false)
  end
end

RegisterNUICallback('faketakePhoto', function(data, cb)
    notify("~g~Press UP ARROW to change to selfie mode. ENTER to take picture. BACKSPACE to cancel.")
    CreateMobilePhone(1)
    CellCamActivate(true, true)
    takePhoto = true
    Citizen.Wait(0)
    TogglePhone()
    if hasFocus == true then
      SetNuiFocus(false, false)
      hasFocus = false
    end
    while takePhoto do
      Citizen.Wait(0)

      if IsControlJustPressed(1, 27) then -- Toogle Mode
        frontCam = not frontCam
        CellFrontCamActivate(frontCam)
      elseif IsControlJustPressed(1, 177) then -- CANCEL
        DestroyMobilePhone()
        CellCamActivate(false, false)
        cb(json.encode({ url = nil }))
        takePhoto = false
        break
      elseif IsControlJustPressed(0, 191) then -- TAKE.. PIC
          print(json.encode(data))
          exports['screenshot-basic']:requestScreenshotUpload('https://cmgstudios.net/upld/upload.php', 'files[]', function(data)
              local resp = json.decode(data)
              DestroyMobilePhone()
              CellCamActivate(false, false)
              exports["arma"]:prompt("CTRL + A, CTRL + C to copy link to image", data)
              cb(json.encode({ url = data }))
              TogglePhone()
              takePhoto = false
          end)
      end
      HideHudComponentThisFrame(7)
      HideHudComponentThisFrame(8)
      HideHudComponentThisFrame(9)
      HideHudComponentThisFrame(6)
      HideHudComponentThisFrame(19)
      HideHudAndRadarThisFrame()
    end
    Citizen.Wait(1000)
    PhonePlayAnim('text', false, true)
end)

RegisterNUICallback('closePhone', function(data, cb)
  menuIsOpen = false
  TriggerEvent('ARMA:setMenuStatus', false)
  SetNuiFocus(false, false)
  SendNUIMessage({show = false})
  PhonePlayOut()
  SetBigmapActive(0,0)
  cb()
end)

RegisterNUICallback("setFocus", function(data, cb)
    SetNuiFocus(data.focus)
    cb(json.encode(data.focus))
end)




----------------------------------
---------- GESTION APPEL ---------
----------------------------------
RegisterNUICallback('appelsDeleteHistorique', function (data, cb)
  appelsDeleteHistorique(data.numero)
  cb()
end)
RegisterNUICallback('appelsDeleteAllHistorique', function (data, cb)
  appelsDeleteAllHistorique(data.infoCall)
  cb()
end)


----------------------------------
---------- GESTION VIA WEBRTC ----
----------------------------------
AddEventHandler('onClientResourceStart', function(res)
  DoScreenFadeIn(300)
  if res == "armaphone" then
    TriggerServerEvent('ARMA:allUpdate')
    -- Try again in 2 minutes (Recovers bugged phone numbers)
    Citizen.Wait(120000)
    TriggerServerEvent('ARMA:allUpdate')
  end
end)


RegisterNUICallback('setIgnoreFocus', function (data, cb)
  ignoreFocus = data.ignoreFocus
  cb()
end)

RegisterNUICallback('takePhoto', function(data, cb)
  CreateMobilePhone(1)
  CellCamActivate(true, true)
  takePhoto = true
  Citizen.Wait(0)
  if hasFocus == true then
    SetNuiFocus(false, false)
    hasFocus = false
  end
  while takePhoto do
    Citizen.Wait(0)

    if IsControlJustPressed(1, 27) then -- Toogle Mode
      frontCam = not frontCam
      CellFrontCamActivate(frontCam)
    elseif IsControlJustPressed(1, 177) then -- CANCEL
      DestroyMobilePhone()
      CellCamActivate(false, false)
      cb(json.encode({ url = nil }))
      takePhoto = false
      break
    elseif IsControlJustPressed(0, 191) then -- TAKE.. PIC
        print(json.encode(data))
        exports['screenshot-basic']:requestScreenshotUpload('https://cmgstudios.net/upld/upload.php', 'files[]', function(data)
            local resp = json.decode(data)
            DestroyMobilePhone()
            CellCamActivate(false, false)
            cb(json.encode({ url = data }))
            takePhoto = false
        end)
    end
    HideHudComponentThisFrame(7)
    HideHudComponentThisFrame(8)
    HideHudComponentThisFrame(9)
    HideHudComponentThisFrame(6)
    HideHudComponentThisFrame(19)
    HideHudAndRadarThisFrame()
  end
  Citizen.Wait(1000)
  PhonePlayAnim('text', false, true)
end)

RegisterNUICallback("block_number", function(data)
    local number = data.number
    TriggerServerEvent("ARMA:blockNumber", number)
end)
RegisterNUICallback("unblock_number", function(data)
    local number = data.number
    TriggerServerEvent("ARMA:unBlockNumber", number)
end)

RegisterNetEvent("ARMA:setVehicleFolders", function(folders)
    SendNUIMessage({
        event = "SetFolders",
        folders = folders or {}
    })
end)

RegisterNUICallback("valet_spawn", function(data)
  local playerCoords = GetEntityCoords(PlayerPedId())
  local bool, _,  outHeading= GetNthClosestVehicleNode(playerCoords.x,playerCoords.y,playerCoords.z,nil,8,8,8,8,8,8)
  local _, outPos, _ = GetNthClosestVehicleNode(playerCoords.x,playerCoords.y,playerCoords.z,15)

  local boolTarget, _,  outHeadingTarget= GetClosestVehicleNodeWithHeading(playerCoords.x,playerCoords.y,playerCoords.z,nil,8,8,8,8,8,8)
  local _, outPosTarget, _ = GetPointOnRoadSide(playerCoords.x,playerCoords.y,playerCoords.z,0.0)

  if tostring(outPosTarget) ~= "vector3(0, 0, 0)" and tostring(outPos) ~= "vector3(0, 0, 0)" then
      TriggerServerEvent("ARMA:valetSpawnVehicle", data.spawncode)
  else
      notify("~r~No suitable location for valet.")
      TriggerEvent("ARMA:johnnyCantMakeIt")
  end
end)

local json_data = [[{
    initiator: false,
    id: 5,
    transmitter_src: 5,
    // transmitter_num: '###-####',
    transmitter_num: '336-4557',
    receiver_src: undefined,
    // receiver_num: '336-4557',
    receiver_num: '###-####',
    is_valid: 0,
    is_accepts: 0,
    hidden: 0
  }]]