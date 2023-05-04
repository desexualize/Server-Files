local cfg = module("AQUAModules", "cfg/cfg_licenses")

local Tunnel = module("AQUA", "lib/Tunnel")
local Proxy = module("AQUA", "lib/Proxy")
AQUA = Proxy.getInterface("AQUA")
AQUAclient = Tunnel.getInterface("AQUA","AQUA")

RegisterNetEvent("AQUA:BuyLicense")
AddEventHandler("AQUA:BuyLicense", function(name)
    local user_id = AQUA.getUserId({source})

    if user_id ~= nil then
        for k, v in pairs(cfg.licenses) do
            if v.name == name then
                if AQUA.hasGroup({user_id, v.group}) == false then
                    if v.group == 'AdvancedRebel' and not AQUA.hasGroup({user_id, 'Rebel'}) then AQUAclient.notify(source,{"~d~You need to have Rebel License to be able to purchase this."}) return end
                    if AQUA.tryBankPayment({user_id, v.price}) then
                        AQUAclient.notify(source,{"~g~Bought "..v.name.." for £"..getMoneyStringFormatted(v.price)})
                        AQUAclient.playFrontendSound(source,{"Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"})
                        AQUA.addUserGroup({user_id, v.group})
                        webhook = "https://discord.com/api/webhooks/1059083806306467842/VRFkrnGpNI0-LIuQ4Q1a-mRYaeHQYh88Thvlyxsal-fG7ybNqL-XJM9sB-Uq0UkwOQ12"
                        PerformHttpRequest(webhook, function(err, text, headers) 
                        end, "POST", json.encode({username = "AQUA", embeds = {
                            {
                                ["color"] = "15158332",
                                ["title"] = "Purchase",
                                ["description"] = "**User Name:** "..GetPlayerName(source).."\n**User ID:** "..user_id.."\n**Purchased License:** "..v.name.. "\nPrice: " ..v.price,
                                ["footer"] = {
                                    ["text"] = "Time - "..os.date("%x %X %p"),
                                }
                        }}}), { ["Content-Type"] = "application/json" })
                    else
                        AQUAclient.notify(source,{"~d~You don't have enough money to buy "..v.name})
                        AQUAclient.playFrontendSound(source,{"Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"})
                    end
                else
                    AQUAclient.notify(source,{"~d~You already own "..v.name})
                end
            end
        end
    end
end)

RegisterNetEvent("AQUA:BuyIllegalLicense")
AddEventHandler("AQUA:BuyIllegalLicense", function(name)
    local user_id = AQUA.getUserId({source})

    if user_id ~= nil then
        for k, v in pairs(cfg.illegal) do
            if v.name == name then
                if AQUA.hasGroup({user_id, v.group}) == false then
                    if v.group == 'AdvancedRebel' and not AQUA.hasGroup({user_id, 'Rebel'}) then AQUAclient.notify(source,{"~d~You need to have Rebel License to be able to purchase this."}) return end
                    if AQUA.tryBankPayment({user_id, v.price}) then
                        AQUAclient.notify(source,{"~g~Bought "..v.name.." for £"..getMoneyStringFormatted(v.price)})
                        AQUAclient.playFrontendSound(source,{"Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"})
                        AQUA.addUserGroup({user_id, v.group})
                        webhook = "https://discord.com/api/webhooks/1059083806306467842/VRFkrnGpNI0-LIuQ4Q1a-mRYaeHQYh88Thvlyxsal-fG7ybNqL-XJM9sB-Uq0UkwOQ12"
                        PerformHttpRequest(webhook, function(err, text, headers) 
                        end, "POST", json.encode({username = "AQUA", embeds = {
                            {
                                ["color"] = "15158332",
                                ["title"] = "Purchase",
                                ["description"] = "**User Name:** "..GetPlayerName(source).."\n**User ID:** "..user_id.."\n**Purchased License:** "..v.name.. "\nPrice: " ..v.price,
                                ["footer"] = {
                                    ["text"] = "Time - "..os.date("%x %X %p"),
                                }
                        }}}), { ["Content-Type"] = "application/json" })
                    else
                        AQUAclient.notify(source,{"~d~You don't have enough money to buy "..v.name})
                        AQUAclient.playFrontendSound(source,{"Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"})
                    end
                else
                    AQUAclient.notify(source,{"~d~You already own "..v.name})
                end
            end
        end
    end
end)

RegisterNetEvent("AQUA:RemoveLicense")
AddEventHandler("AQUA:RemoveLicense", function(name)
    local user_id = AQUA.getUserId({source})

    if user_id ~= nil then
        for k, v in pairs(cfg.licenses) do
            if v.name == name then
                if AQUA.hasGroup({user_id, v.group}) then
                    AQUA.removeUserGroup({user_id, "HighRoller"})
                    AQUA.giveBankMoney({user_id, 5000000})
                    AQUAclient.notify(source,{"~g~Removed "..v.name.." for £5,000,000"})
                    AQUAclient.playFrontendSound(source,{"Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"})
                    webhook = "https://discord.com/api/webhooks/1059083806306467842/VRFkrnGpNI0-LIuQ4Q1a-mRYaeHQYh88Thvlyxsal-fG7ybNqL-XJM9sB-Uq0UkwOQ12"
                    PerformHttpRequest(webhook, function(err, text, headers) 
                    end, "POST", json.encode({username = "AQUA", embeds = {
                        {
                            ["color"] = "15158332",
                            ["title"] = "Refund",
                            ["description"] = "**User Name:** "..GetPlayerName(source).."\n**User ID:** "..user_id.."\n**Refunded License:** "..v.name,
                            ["footer"] = {
                                ["text"] = "Time - "..os.date("%x %X %p"),
                            }
                    }}}), { ["Content-Type"] = "application/json" })
                else
                    AQUAclient.notify(source,{"~d~You do not own "..v.name.." License"})
                end
            end
        end
    end
end)
RegisterNetEvent("AQUA:RemoveLicensecenter")
AddEventHandler("AQUA:RemoveLicensecenter", function(name)
    local user_id = AQUA.getUserId({source})

    if user_id ~= nil then
        for k, v in pairs(cfg.refundlicenese) do
            if v.name == name then
                if AQUA.hasGroup({user_id, v.group}) then
                    AQUA.removeUserGroup({user_id, v.group })
                    AQUA.giveBankMoney({user_id, v.refund})
                    AQUAclient.notify(source,{"~g~Removed "..v.name.." for £"..getMoneyStringFormatted(v.refund)})
                    AQUAclient.playFrontendSound(source,{"Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"})
                    webhook = "https://discord.com/api/webhooks/1059083806306467842/VRFkrnGpNI0-LIuQ4Q1a-mRYaeHQYh88Thvlyxsal-fG7ybNqL-XJM9sB-Uq0UkwOQ12"
                    PerformHttpRequest(webhook, function(err, text, headers) 
                    end, "POST", json.encode({username = "AQUA", embeds = {
                        {
                            ["color"] = "15158332",
                            ["title"] = "Refunds",
                            ["description"] = "**User Name:** "..GetPlayerName(source).."\n**User ID:** "..user_id.."\n**Refunded License:** "..v.name,
                            ["footer"] = {
                                ["text"] = "Time - "..os.date("%x %X %p"),
                            }
                    }}}), { ["Content-Type"] = "application/json" })
                else
                    AQUAclient.notify(source,{"~d~You do not own "..v.name.." License"})
                end
            end
        end
    end
end)

function getMoneyStringFormatted(cashString)
	local i, j, minus, int, fraction = tostring(cashString):find('([-]?)(%d+)([.]?%d*)')
	int = int:reverse():gsub("(%d%d%d)", "%1,")
	return minus .. int:reverse():gsub("^,", "") .. fraction 
end