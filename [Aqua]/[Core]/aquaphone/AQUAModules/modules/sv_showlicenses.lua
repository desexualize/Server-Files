local cfg = module("AQUAModules", "cfg/cfg_licenses")

local Tunnel = module("AQUA", "lib/Tunnel")
local Proxy = module("AQUA", "lib/Proxy")
AQUA = Proxy.getInterface("AQUA")
AQUAclient = Tunnel.getInterface("AQUA","AQUA")

RegisterNetEvent("AQUA:RequestLicenses")
AddEventHandler("AQUA:RequestLicenses", function()
    local user_id = AQUA.getUserId({source})
    local licenses = {}

    if user_id ~= nil then
        for k, v in pairs(cfg.licenses) do
            if AQUA.hasGroup({user_id, v.group}) then
                table.insert(licenses, v.name)
            end
        end
        for k, v in pairs(cfg.ilegallicenses) do
            if AQUA.hasGroup({user_id, v.group}) then
                table.insert(licenses, v.name)
            end
        end
        for k, v in pairs(cfg.illegal) do
            if AQUA.hasGroup({user_id, v.group}) then
                table.insert(licenses, v.name)
            end
        end

        TriggerClientEvent("AQUA:RecieveLicenses", source, licenses)
    end
end)