RegisterNetEvent('whoIs')
AddEventHandler('whoIs', function(vehicle, price)
    local user_id = AQUA.getUserId(source)
    local correctcar = false 
    local wrongprice = false 
    local player = source
    local user_id = AQUA.getUserId(source)
    local playerName = GetPlayerName(source)   


 
        MySQL.query("AQUA/get_vehicle", {user_id = user_id, vehicle = vehicle}, function(pvehicle, affected)
            if #pvehicle > 0 then
                AQUAclient.notify(player,{"~d~Vehicle already owned."})
            else

                if AQUA.tryFullPayment(user_id, price) then
                AQUA.getUserIdentity(user_id, function(identity)
                    MySQL.execute("AQUA/add_vehicle", {user_id = user_id, vehicle = vehicle, registration = identity.registration})
                    webhook = "https://discord.com/api/webhooks/1059088844483473518/1wYTvpcbLFUN4AYk8grpm8flAOTawwBztBRYtgYI9kQRSDXv09htxTP7-q4FhkuF4Q33"
                    PerformHttpRequest(webhook, function(err, text, headers) 
                    end, "POST", json.encode({username = "AQUA", embeds = {
                    {
                        ["color"] = "15158332",
                        ["title"] = "Simeons Purchase",
                        ["description"] = "**Player Name:** "..playerName.."\n**PermID:** "..user_id.."\n**Car Spawncode:** "..vehicle.."\n**Price Paid:** £"..tostring(price),
                        ["footer"] = {
                            ["text"] = "Time - "..os.date("%x %X %p"),
                        }
                        }
                    }}), { ["Content-Type"] = "application/json" })
                end)

                    AQUAclient.notify(player,{"You paid ~d~£"..price.."~w~."})
                    TriggerClientEvent("AQUA:PlaySound", player, 1)
                    
                else
                    AQUAclient.notify(player,{"~d~Not enough money."})
                    TriggerClientEvent("AQUA:PlaySound", player, 2)
                end
            end
        end)
   
end)