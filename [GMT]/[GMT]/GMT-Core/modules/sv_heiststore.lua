-- local cfg = module("GMT-Core", "cfg/cfg_stores")

-- local Tunnel = module("vrp", "lib/Tunnel")
-- local Proxy = module("vrp", "lib/Proxy")
-- vRP = Proxy.getInterface("vRP")
-- vRPclient = Tunnel.getInterface("vRP","vRP")

-- RegisterNetEvent("GMT:BuyHeistItem")
-- AddEventHandler("GMT:BuyHeistItem", function(itemID, amount)
--     local user_id = vRP.getUserId({source})

--     if user_id ~= nil then
--         for k, v in pairs(cfg.items) do
--             if itemID == v.itemID then
--                 if vRP.tryPayment({user_id, v.price * amount}) then
--                     vRP.giveInventoryItem({user_id, v.itemID, amount, true})
--                     vRPclient.playFrontendSound(source,{"Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"})
--                 else
--                     vRPclient.notify(source,{"~r~You don't have enough money!"})
--                 end
--             end
--         end
--     end
-- end)

-- RegisterNetEvent("GMT:SellHeistItem")
-- AddEventHandler("GMT:SellHeistItem", function(itemID, amount)
--     local user_id = vRP.getUserId({source})

--     if user_id ~= nil then
--         for k, v in pairs(cfg.items) do
--             if itemID == v.itemID then
--                 if vRP.tryGetInventoryItem({user_id,'jewellery', amount}) then
--                     local item = vRP.getInventoryItemAmount({user_id,'jewellery'})
--                     local price = v.price * tonumber(amount)
--                     vRP.giveMoney({user_id,price})
--                     vRPclient.playFrontendSound(source,{"Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"})
--                 else
--                     vRPclient.notify(source,{"~r~You don't have enough jewellery!"})
--                 end
--             end
--         end
--     end
-- end)