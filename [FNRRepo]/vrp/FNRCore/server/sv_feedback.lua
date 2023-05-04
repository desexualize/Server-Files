RegisterServerEvent("FNR:adminTicketFeedback")
AddEventHandler("FNR:adminTicketFeedback", function(AdminID, FeedBackType, Message)
    if AdminID == nil then
        return
    end
    local PlayerName = GetPlayerName(source)
    local AdminName = GetPlayerName(AdminID)
    local AdminPermID = vRP.getUserId(AdminID)
    local PlayerID = vRP.getUserId(source)
    print(AdminPermID)
    if FeedBackType == "good" then
        vRP.giveBankMoney(AdminPermID, 25000)
        vRPclient.notify(AdminID, {"~g~You have received £25000 for a good feedback."})
        vRPclient.notify(source, {"~g~You have given a Good feedback."})
    elseif FeedBackType == "neutral" then
        vRP.giveBankMoney(AdminPermID, 10000)
        vRPclient.notify(AdminID, {"~g~You have received £10000 for a good feedback."})
        vRPclient.notify(source, {"~y~You have given a Neutral feedback."})
    elseif FeedBackType == "bad" then
        vRP.giveBankMoney(AdminPermID, 5000)
        vRPclient.notify(AdminID, {"~g~You have received £5000 for a good feedback."})
        vRPclient.notify(source, {"~r~You have given a Bad feedback."})
    end
    local ticketembed = {
        {
            ["color"] = "16777215",
            ["title"] = "Admin Ticket Feedback",
            ["description"] = "**Admin ID: **" ..AdminPermID.. "\n**Perm ID: **" ..PlayerID.. "\n**FeedBack Type: **" ..FeedBackType.. "\n**Message: **" ..Message.. "\n\n**Created By WattSkill**",
            ["footer"] = {
            ["text"] = "FNR - "..os.date("%X"),
            ["icon_url"] = "",
            }
        }
    }
    PerformHttpRequest("https://discord.com/api/webhooks/1074075285139509300/EKBRUAMx6WH3nJHjAG1LM130YNuJUG4A07Vk-BOFMD6wLrZLLaz3bO2mbyq9WTiU37Ix", function(err, text, headers) end, "POST", json.encode({username = "Smiley Logs", embeds = ticketembed}), { ["Content-Type"] = "application/json" })

end)