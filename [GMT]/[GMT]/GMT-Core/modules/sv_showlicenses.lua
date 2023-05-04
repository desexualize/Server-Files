local cfg = module("GMT-Core", "cfg/cfg_licenses")

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")

RegisterNetEvent("GMT:RequestLicenses")
AddEventHandler("GMT:RequestLicenses", function()
    local user_id = vRP.getUserId({source})
    local licenses = {}

    if user_id ~= nil then
        for k, v in pairs(cfg.licenses) do
            if vRP.hasGroup({user_id, v.group}) then
                table.insert(licenses, v.name)
            end
        end

        TriggerClientEvent("GMT:RecieveLicenses", source, licenses)
    end
end)