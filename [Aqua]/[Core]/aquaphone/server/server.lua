RegisterNetEvent("AQUA:openPhone")
AddEventHandler("AQUA:openPhone", function()
  if GetEntityHealth(PlayerPedId()) <= 102 then return end
  if takePhoto ~= true then
      TogglePhone()
  end
  TriggerEvent('AQUA:getGarageFolders')
end)

  AddEventHandler("AQUA:startFixeCall", function(fixeNumber)
    local number = ''
    TriggerEvent("AQUA:displayOnscreenKeyboard", "FMMC_MPM_NA", "", "", "", "", "", 10)
    while (true) do
        Wait(0)
        local keyboardResult = nil
        TriggerEvent("AQUA:getOnscreenKeyboardResult", function(result)
            keyboardResult = result
        end)
        if keyboardResult then
            number = keyboardResult
            break
        end
    end
    if number ~= '' then
        TriggerEvent('AQUA:autoCall', number, {
            useNumber = fixeNumber
        })
        TriggerEvent("AQUA:phonePlayCall", true)
    end
end)

AddEventHandler("AQUA:takeAppel", function(infoCall)
  TriggerEvent('AQUA:autoAcceptCall', infoCall)
end)

RegisterNetEvent("AQUA:notifyFixePhoneChange")
AddEventHandler("AQUA:notifyFixePhoneChange", function(_PhoneInCall)
  PhoneInCall = _PhoneInCall
  TriggerClientEvent("AQUA:notifyFixePhoneChange", -1, PhoneInCall)
end)

-- Register the events to receive data from the client
RegisterNetEvent("AQUA:startFixeCall")
AddEventHandler("AQUA:startFixeCall", function(number)
  -- Perform the main action for starting a fixed call
  -- ...
end)

RegisterNetEvent("AQUA:togglePhone")
AddEventHandler("AQUA:togglePhone", function()
  -- Perform the main action for toggling the phone
  -- ...
end)

-- Send the data to the client
TriggerEvent("AQUA:myPhoneNumber", source, myPhoneNumber)
TriggerEvent("AQUA:contactList", source, contacts)
TriggerEvent("AQUA:allMessage", source, allmessages)

RegisterNetEvent("AQUA:addContact")
AddEventHandler("AQUA:addContact", function(display, num)
-- code to add a contact to the database
end)

RegisterNetEvent("AQUA:deleteContact")
AddEventHandler("AQUA:deleteContact", function(num)
-- code to delete a contact from the database
end)

RegisterNetEvent("AQUA:sendMessage")
AddEventHandler("AQUA:sendMessage", function(num, message)
-- code to send a message to a recipient
end)

RegisterNetEvent("AQUA:deleteMessage")
AddEventHandler("AQUA:deleteMessage", function(msgId)
-- code to delete a message from the database
end)

-- On the client side

-- Function to notify the user about a new message
function notify(msg)
   if not globalHideUi then
      BeginTextCommandThefeedPost("STRING")
      AddTextComponentSubstringPlayerName(msg)
      EndTextCommandThefeedPostTicker(true, false)
   end
end

-- Function to add a contact
function addContact(display, num)
   TriggerEvent('AQUA:addContact', display, num)
end

-- Function to delete a contact
function deleteContact(num)
   TriggerEvent('AQUA:deleteContact', num)
end

-- Function to send a message
function sendMessage(num, message)
   TriggerEvent('AQUA:sendMessage', num, message)
end

-- Function to delete a message
function deleteMessage(msgId)
   print("msgId", msgId)
   TriggerEvent('AQUA:deleteMessage', msgId)
end

function deleteMessageContact(num)
    TriggerEvent('AQUA:deleteMessageNumber', num)
  end
  
  function deleteAllMessage()
    TriggerEvent('AQUA:deleteAllMessage')
  end
  
  function setReadMessageNumber(num)
    TriggerEvent('AQUA:setReadMessageNumber', num)
  end
  
  function requestAllMessages()
    TriggerEvent('AQUA:requestAllMessages')
  end
  
  function requestAllContact()
    TriggerEvent('AQUA:requestAllContact')
  end
  
  local aminCall = false
local inCall = false

RegisterServerEvent("AQUA:waitingCall")
AddEventHandlerServer("AQUA:waitingCall", function(infoCall, initiator)
if initiator then
if inCall == false then
inCall = true
SetVoiceChannel(infoCall.id + 1)
SetTalkerProximity(0.0)
end
end
end)

RegisterServerEvent("AQUA:acceptCall")
AddEventHandlerServer("AQUA:acceptCall", function(infoCall, initiator)
if inCall == false then
inCall = true
SetVoiceChannel(infoCall.id + 1)
SetTalkerProximity(0.0)
end
end)

RegisterServerEvent("AQUA:rejectCall")
AddEventHandlerServer("AQUA:rejectCall", function(infoCall)
if inCall == true then
inCall = false
ClearVoiceChannel()
SetTalkerProximity(2.5)
end
exports["AQUA"]:playSound("hangup")
end)

RegisterServerEvent("AQUA:sendCallHistory")
AddEventHandlerServer("AQUA:sendCallHistory", function(historique)
-- This event does not need to be handled on the server
end)

function startCall (phone_number, rtcOffer, extraData)
    if rtcOffer == nil then
      rtcOffer = ''
    end
    TriggerEvent('AQUA:startCall', phone_number, rtcOffer, extraData)
  end
  
  function acceptCall (infoCall, rtcAnswer)
    TriggerEvent('AQUA:acceptCall', infoCall, rtcAnswer)
  end
  
  function rejectCall(infoCall)
    TriggerEvent('AQUA:rejectCall', infoCall)
  end
  
  function ignoreCall(infoCall)
    TriggerEvent('AQUA:ignoreCall', infoCall)
  end
  
  function requestHistoriqueCall()
    TriggerEvent('AQUA:getHistoriqueCall')
  end
  
  function appelsDeleteHistorique (num)
    TriggerEvent('AQUA:appelsDeleteHistorique', num)
  end
  
  function appelsDeleteAllHistorique ()
    TriggerEvent('AQUA:appelsDeleteAllHistorique')
  end

  RegisterNUICallback('onCandidates', function (data, cb)
    TriggerEvent('AQUA:candidates', data.id, data.candidates)
    cb()
  end)
  
  RegisterNetEvent("AQUA:candidates")
  AddEventHandler("AQUA:candidates", function(candidates)
    SendNUIMessage({event = 'candidatesAvailable', candidates = candidates})
  end)
  
  
  
  RegisterNetEvent('AQUA:autoCall')
  AddEventHandler('AQUA:autoCall', function(number, extraData)
    if number ~= nil then
      SendNUIMessage({ event = "autoStartCall", number = number, extraData = extraData})
    end
  end)
  
  RegisterNetEvent('AQUA:autoCallNumber')
  AddEventHandler('AQUA:autoCallNumber', function(data)
    TriggerEvent('AQUA:autoCall', data.number)
  end)
  
  RegisterNetEvent('AQUA:autoAcceptCall')
  AddEventHandler('AQUA:autoAcceptCall', function(infoCall)
    SendNUIMessage({ event = "autoAcceptCall", infoCall = infoCall})
  end)
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
      exports["AQUA"]:prompt(ask, text, function(text)
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
    TriggerEvent('AQUA:sendMessage', data.phoneNumber, data.message)
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
    TriggerEvent('AQUA:addContact', data.display, data.phoneNumber)
  end)
  RegisterNUICallback('updateContact', function(data, cb)
    TriggerEvent('AQUA:updateContact', data.id, data.display, data.phoneNumber)
  end)
  RegisterNUICallback('deleteContact', function(data, cb)
    TriggerEvent('AQUA:deleteContact', data.id)
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
    TriggerEvent('AQUA:deleteALL')
    cb()
  end)
  
  function TogglePhone(anim)
    if anim == nil then anim = true end
    menuIsOpen = not menuIsOpen
    SendNUIMessage({show = menuIsOpen})
    if menuIsOpen == true then
      if anim then
        PhonePlayIn()
      end
      TriggerEvent('AQUA:setMenuStatus', true)
    else
      if anim then
        PhonePlayOut()
      end
      TriggerEvent('AQUA:setMenuStatus', false)
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
                exports["AQUA"]:prompt("CTRL + A, CTRL + C to copy link to image", data)
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
    TriggerEvent('AQUA:setMenuStatus', false)
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
    if res == "AQUAphone" then
      TriggerEvent('AQUA:allUpdate')
      -- Try again in 2 minutes (Recovers bugged phone numbers)
      Citizen.Wait(120000)
      TriggerEvent('AQUA:allUpdate')
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
      TriggerEvent("AQUA:blockNumber", number)
  end)
  RegisterNUICallback("unblock_number", function(data)
      local number = data.number
      TriggerEvent("AQUA:unBlockNumber", number)
  end)
  
  RegisterNetEvent("AQUA:setVehicleFolders", function(folders)
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
        TriggerEvent("AQUA:valetSpawnVehicle", data.spawncode)
    else
        notify("~r~No suitable location for valet.")
        TriggerEvent("AQUA:johnnyCantMakeIt")
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