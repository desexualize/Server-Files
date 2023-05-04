local cfg = module("FNR-Core", "cfg/cfg_licenses")

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")

RegisterNetEvent("FNR:BuyLicense")
AddEventHandler("FNR:BuyLicense", function(name)
    local user_id = vRP.getUserId({source})

    if user_id ~= nil then
        for k, v in pairs(cfg.licenses) do
            if v.name == name then
                if vRP.hasGroup({user_id, v.group}) == false then
                    if v.group == 'AdvancedRebel' and not vRP.hasGroup({user_id, 'Rebel'}) then vRPclient.notify(source,{"~r~You need to have Rebel License to be able to purchase this."}) return end
                    if vRP.tryBankPayment({user_id, v.price}) then
                        vRPclient.notify(source,{"~g~Bought "..v.name.." for £"..getMoneyStringFormatted(v.price)})
                        vRPclient.playFrontendSound(source,{"Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"})
                        vRP.addUserGroup({user_id, v.group})
                    else
                        vRPclient.notify(source,{"~r~You don't have enough money to buy "..v.name})
                        vRPclient.playFrontendSound(source,{"Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"})
                    end
                else
                    vRPclient.notify(source,{"~r~You already own "..v.name})
                end
            end
        end
    end
end)

RegisterNetEvent("FNR:RemoveLicense")
AddEventHandler("FNR:RemoveLicense", function(name)
    local user_id = vRP.getUserId({source})

    if user_id ~= nil then
        for k, v in pairs(cfg.licenses) do
            if v.name == name then
                if vRP.hasGroup({user_id, v.group}) then
                    vRP.removeUserGroup({user_id, "HighRoller"})
                    vRPclient.notify(source,{"~g~Removed "..v.name.." for £0"})
                    vRPclient.playFrontendSound(source,{"Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"})
                else
                    vRPclient.notify(source,{"~r~You do not own "..v.name.." License"})
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