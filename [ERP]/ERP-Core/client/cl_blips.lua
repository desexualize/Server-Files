local blipon = false
Blips = {}
RegisterCommand("blips", function()
  if not blipon then
    blipon = true
    Citizen.CreateThread(function()
      while blipon do
        if blipon then
          TriggerServerEvent("ERP:ENABLEBLIPS")
          Citizen.Wait(10000)
        end
      end
    end)
  else
    DeleteAllBlips()
    blipon = false
  end
end)

RegisterNetEvent("DeleteBlipsALL")
AddEventHandler("DeleteBlipsALL", function()
    DeleteAllBlips()
    blipon = false
end)

RegisterNetEvent("ERP:BLIPS")
AddEventHandler("ERP:BLIPS", function(cop,nhs)
  DeleteAllBlips()
  local LocalServerID = GetPlayerServerId(PlayerId())
  for PermID, Player in pairs(cop) do
    local PlayerID = tonumber(Player[2])
    if LocalServerID ~= PlayerID and GetPlayerPed(GetPlayerFromServerId(PlayerID)) ~= nil then
      local ClientID = GetPlayerFromServerId(PlayerID)
      local blipid = AddBlipForEntity(GetPlayerPed(ClientID))
      SetBlipSprite(blipid, 1)
      SetBlipColour(blipid, 3)
      SetBlipCategory(blipid, 2)
      SetBlipAsShortRange(blipid, false)
      Citizen.InvokeNative( 0x5FBCA48327B914DF, blipid, true )
      SetBlipNameToPlayerName(blipid, ClientID)
      Blips[#Blips + 1] = blipid
    end
  end
  for PermID, Player in pairs(nhs) do
    local PlayerID = tonumber(Player[2])
    if LocalServerID ~= PlayerID and GetPlayerPed(GetPlayerFromServerId(PlayerID)) ~= nil then
      local ClientID = GetPlayerFromServerId(PlayerID)
      local blipid = AddBlipForEntity(GetPlayerPed(ClientID))
      SetBlipSprite(blipid, 1)
      SetBlipColour(blipid, 2)
      SetBlipCategory(blipid, 2)
      SetBlipAsShortRange(blipid, false)
      Citizen.InvokeNative( 0x5FBCA48327B914DF, blipid, true )
      SetBlipNameToPlayerName(blipid, ClientID)
      Blips[#Blips + 1] = blipid
    end
  end
end)

function DeleteAllBlips()
  for i,v in pairs(Blips) do
    RemoveBlip(v)
  end
  Blips = {}
end
 
