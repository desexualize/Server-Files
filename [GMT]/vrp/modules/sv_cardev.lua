RegisterServerEvent('GMT:openCarDev')
AddEventHandler('GMT:openCarDev', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id ~= nil and vRP.hasPermission(user_id, "cardev.menu") then 
      TriggerClientEvent("GMT:CarDevMenu", source)
    end
end)

RegisterServerEvent('GMT:setCarDev')
AddEventHandler('GMT:setCarDev', function(status)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id ~= nil and vRP.hasPermission(user_id, "cardev.menu") then 
      if status then
        SetPlayerRoutingBucket(source, 10)
      else
        SetPlayerRoutingBucket(source, 0)
      end
    end
end)

RegisterServerEvent('GMT:takeCarScreenshot')
AddEventHandler('GMT:takeCarScreenshot', function()
    local source = source
    local user_id = vRP.getUserId(source)
    local name = GetPlayerName(source)
    if user_id ~= nil and vRP.hasPermission(user_id, "cardev.menu") then 
        exports["discord-screenshot"]:requestClientScreenshotUploadToDiscord(source,{username = "GMT Car Screenshots"},30000,function(error)
            if error then
                return print("^1ERROR: " .. error)
            end
        end)
    end   
end)