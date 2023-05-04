RegisterServerEvent('FNR:openCarDev')
AddEventHandler('FNR:openCarDev', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id ~= nil and vRP.hasPermission(user_id, "cardev.menu") then 
      vRPclient.openCarDev(source,{})
    end
end)

RegisterServerEvent('FNR:setCarDev')
AddEventHandler('FNR:setCarDev', function(status)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id ~= nil and vRP.hasPermission(user_id, "cardev.menu") then 
      if status then
        SetPlayerRoutingBucket(source, 10)
        TriggerClientEvent("FNR:SetPlayerBucket", source, 10)
      else
        SetPlayerRoutingBucket(source, 0)
        TriggerClientEvent("FNR:SetPlayerBucket", source, 0)
      end
    end
end)

RegisterServerEvent('FNR:takeCarScreenshot')
AddEventHandler('FNR:takeCarScreenshot', function()
    local source = source
    local user_id = vRP.getUserId(source)
    local name = GetPlayerName(source)
    if user_id ~= nil and vRP.hasPermission(user_id, "cardev.menu") then 
        exports["discord-screenshot"]:requestClientScreenshotUploadToDiscord(source,{username = "FNR Car Screenshots"},30000,function(error)
            if error then
                return print("^1ERROR: " .. error)
            end
        end)
    end   
end)

RegisterServerEvent("FNR:getCarDevDebug")
AddEventHandler("FNR:getCarDevDebug", function(text)
   local source = source
   local user_id = vRP.getUserId(source)
   local command = {
      {
        ["color"] = "16777215",
        ["title"] = "Requested by "..GetPlayerName(source).." Perm ID: "..user_id.."",
        ["description"] = text[1],
        ["footer"] = {
          ["text"] = "FNR - "..os.date("%X"),
          ["icon_url"] = "", -- LOGO
        }
      }
    }
    PerformHttpRequest("https://discord.com/api/webhooks/1071847040901992548/55J2lGwfN8iC75MGH5Oki0kHnRFZFumkh-Fr1tW1e8Qt9C0qp8CONN1xlxjvl8dEMGOz", function(err, text, headers) end, 'POST', json.encode({username = "vRP Staff Logs", embeds = command}), { ['Content-Type'] = 'application/json' })
end)