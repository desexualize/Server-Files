RegisterNetEvent("NitroPerks:spawnmoped")
AddEventHandler("NitroPerks:spawnmoped",function()
    local mopedHash = GetHashKey("faggio")
    loadModel(mopedHash)
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local pedHeading = GetEntityHeading(ped)
    local moped = CreateVehicle(mopedHash, pedCoords, pedHeading, true, true)
    SetPedIntoVehicle(ped, moped, -1)
    notify("~r~[NitroPerks] ~b~You have spawned a moped")
end)

RegisterNetEvent("NitroPerks:notbooster")
AddEventHandler("NitroPerks:notbooster",function()
    notify("[~r~NitroPerks] ~b~You are not a nitro booster in discord.io/gmtuk")
end)


function loadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end
end


RegisterCommand('moped', function()
  ExecuteCommand("playanim")  
  TriggerServerEvent('NitroPerks:craftmoped')

end)

RegisterCommand("playanim", function()
  TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_HAMMERING', false, true)
end)


function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
      Wait(5)
    end
  end


  function Notify( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end