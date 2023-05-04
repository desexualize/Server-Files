local Tunnel = module('AQUA', 'lib/Tunnel')
local Proxy = module('AQUA', 'lib/Proxy')
AQUA = Proxy.getInterface("AQUA")
AQUAclient = Tunnel.getInterface("AQUA", "PDClockon")

RegisterNetEvent("AQUA:Clockon")
AddEventHandler('AQUA:Clockon', function(group)
    local source = source
    userid = AQUA.getUserId({source})
    name = GetPlayerName(source)
    
 
    exports['AQUARoles']:isRolePresent(source, {cfgroles.pdRole} , function(hasRole, roles)
        if hasRole == true then 
            AQUA.addUserGroup({userid, group})
            TriggerClientEvent("AQUA:NotifyPlayer", source, "You have Clocked on as " ..group)
            hasPD = true

        local clockonEmbed = {
            {
                ["color"] = "16777215",
                ["title"] = name .. " has clocked on as a " .. group,
                ["description"] = "ID: " .. userid .. " / Name: " .. name .. " Clocked on as a **[" .. group .. "]**",
                ["footer"] = {
                  ["text"] = " - "..os.date("%X"),
                  ["icon_url"] = "https://media.discordapp.net/attachments/1014165521563914311/1038550242116784268/unknown.png",
                }
            }
        }
        PerformHttpRequest("https://discord.com/api/webhooks/1059082722989068428/7CSx9dgY4SRrxAdlP4V89iu4fTytfXYvlME2Vn90yh5Im9P3WuiCGgJRzjdIBpm96PKd", function(err, text, headers) end, "POST", json.encode({username = "Clock On Logs", embeds = clockonEmbed}), { ["Content-Type"] = "application/json" })
    else
        AQUAclient.notify(source,{"~d~You do not have permissions to clock on."})
         end
    end)
end)

RegisterNetEvent("removeGroups")
AddEventHandler("removeGroups", function()
    local source = source
    userid1 = AQUA.getUserId({source})
    local ped = GetPlayerPed(source)
    hasPD = false
    AQUA.removeUserGroup({userid1, "Special Constable"})
    AQUA.removeUserGroup({userid1, "Commissioner"})
    AQUA.removeUserGroup({userid1, "Deputy Commissioner"})
    AQUA.removeUserGroup({userid1, "Deputy Assistant Commissioner"})
    AQUA.removeUserGroup({userid1, "Commander"})
    AQUA.removeUserGroup({userid1, "Chief Superintendent"})
    AQUA.removeUserGroup({userid1, "Superintendent"})
    AQUA.removeUserGroup({userid1, "ChiefInspector"})
    AQUA.removeUserGroup({userid1, "Inspector"})
    AQUA.removeUserGroup({userid1, "Sergeant"})
    AQUA.removeUserGroup({userid1, "Senior Constable"})
    AQUA.removeUserGroup({userid1, "Police Constable"})
    AQUA.removeUserGroup({userid1, "PCSO"})


end)





