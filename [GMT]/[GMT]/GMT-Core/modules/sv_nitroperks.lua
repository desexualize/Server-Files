RegisterServerEvent('NitroPerks:craftmoped')
AddEventHandler('NitroPerks:craftmoped', function()
    local source = source
    local userid = vRP.getUserId({source})
    local name = GetPlayerName(source)
    exports["discord-roles2"]:isRolePresent(source,{cfgroles.boosterRole},function(hasRole)
        if hasRole == true then 
            Citizen.Wait(3500)
            print('~r~[NitroPerks]~b~ ' .. name .. ' has crafted a moped')
            TriggerClientEvent("NitroPerks:spawnmoped", source)
            TriggerEvent("NitroPerks:logtodiscord", userid, name)
        else
            TriggerClientEvent("GMT:PlaySound", source, 2)
            TriggerClientEvent("NitroPerks:notbooster", userid, name)
            print('~r~[NitroPerks]~b~ ' .. name .. ' tried triggering an event the cheating scum')
        end
    end)
end)


RegisterServerEvent("NitroPerks:logtodiscord")
AddEventHandler("NitroPerks:logtodiscord",function(userid, name)
    --local weaponname = weapon.gsub(weapon, "WEAPON_", "")
    local command = {
        {
            ["color"] = "3944703",
            ["title"] = "GMT Nitro Perk Logs",
            ["description"] = "",
            ["text"] = "GMT Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
            ["fields"] = {
                {
                    ["name"] = "User Name",
                    ["value"] = name,
                    ["inline"] = true
                },
                {
                    ["name"] = "User ID",
                    ["value"] = userid,
                    ["inline"] = true
                },
                {
                    ["name"] = "Event",
                    ["value"] = "Crafted a moped",
                    ["inline"] = true
                },
                

            }
        }
    }
    local webhook = "https://discord.com/api/webhooks/1003786571142680700/KPluP_-wKiSrbN8k6WNUsh9uw1dHIBjcQHd56JZPcw-ODJs529AqjFbKhc-YlzUlguUN"
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "GMT", embeds = command}), { ['Content-Type'] = 'application/json' })
end)