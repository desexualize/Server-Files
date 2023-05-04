RegisterNetEvent('whoIs')
AddEventHandler('whoIs', function(vehicle, price)
    local user_id = vRP.getUserId(source)
    local correctcar = false 
    local wrongprice = false 
    local player = source
    local user_id = vRP.getUserId(source)
    local playerName = GetPlayerName(source)   


 
        MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = vehicle}, function(pvehicle, affected)
            if #pvehicle > 0 then
                vRPclient.notify(player,{"~r~Vehicle already owned."})
            else

                if vRP.tryFullPayment(user_id, price) then
                vRP.getUserIdentity(user_id, function(identity)
                    MySQL.execute("vRP/add_vehicle", {user_id = user_id, vehicle = vehicle, registration = "P "..identity.registration})
                    webhook = "https://discord.com/api/webhooks/938627879657431082/a_nCu_Eslml-eUJRWA6dY4yufsQ3wICDcF9iJGRY4kwb8hbMnBHulX9KuuIb7KFdleBt"
                    PerformHttpRequest(webhook, function(err, text, headers) 
                    end, "POST", json.encode({username = "Galaxy Roleplay", embeds = {
                    {
                        ["color"] = "15158332",
                        ["title"] = "Showroom Purchase Log",
                        ["description"] = "Player Name: **"..playerName.."** \nPermID: **"..user_id.."** \nCar Purchased: **"..vehicle.."** \nPrice Paid: **£"..tostring(price).."** \nWrong Price?: **false** \nWrong Price?: **false**",
                        ["footer"] = {
                            ["text"] = "Time - "..os.date("%x %X %p"),
                        }
                        }
                    }}), { ["Content-Type"] = "application/json" })
                end)

                    vRPclient.notify(player,{"You paid ~r~£"..price.."~w~."})
                    vRPclient.notify(player,{"Go to any vehicle garage to pick up your vehicle."})
                    
                else
                    vRPclient.notify(player,{"~r~Not enough money."})
                end
            end
        end)
   
end)