local cfg = module("FNR-Core", "cfg/cfg_licenses")

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")

RegisterNetEvent("FNR:RequestLicenses")
AddEventHandler("FNR:RequestLicenses", function()
    local user_id = vRP.getUserId({source})
    local licenses = {}

    if user_id ~= nil then
        for k, v in pairs(cfg.licenses) do
            if vRP.hasGroup({user_id, v.group}) then
                table.insert(licenses, v.name)
            end
        end

        TriggerClientEvent("FNR:RecieveLicenses", source, licenses)
    end
end)