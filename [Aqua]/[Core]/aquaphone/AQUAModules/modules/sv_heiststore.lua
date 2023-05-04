-- local cfg = module("AQUAModules", "cfg/cfg_stores")

-- local Tunnel = module("AQUA", "lib/Tunnel")
-- local Proxy = module("AQUA", "lib/Proxy")
-- AQUA = Proxy.getInterface("AQUA")
-- AQUAclient = Tunnel.getInterface("AQUA","AQUA")

-- RegisterNetEvent("AQUA:BuyHeistItem")
-- AddEventHandler("AQUA:BuyHeistItem", function(itemID, amount)
--     local user_id = AQUA.getUserId({source})

--     if user_id ~= nil then
--         for k, v in pairs(cfg.items) do
--             if itemID == v.itemID then
--                 if AQUA.tryPayment({user_id, v.price * amount}) then
--                     AQUA.giveInventoryItem({user_id, v.itemID, amount, true})
--                     AQUAclient.playFrontendSound(source,{"Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"})
--                 else
--                     AQUAclient.notify(source,{"~d~You don't have enough money!"})
--                 end
--             end
--         end
--     end
-- end)

-- RegisterNetEvent("AQUA:SellHeistItem")
-- AddEventHandler("AQUA:SellHeistItem", function(itemID, amount)
--     local user_id = AQUA.getUserId({source})

--     if user_id ~= nil then
--         for k, v in pairs(cfg.items) do
--             if itemID == v.itemID then
--                 if AQUA.tryGetInventoryItem({user_id,'jewellery', amount}) then
--                     local item = AQUA.getInventoryItemAmount({user_id,'jewellery'})
--                     local price = v.price * tonumber(amount)
--                     AQUA.giveMoney({user_id,price})
--                     AQUAclient.playFrontendSound(source,{"Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"})
--                 else
--                     AQUAclient.notify(source,{"~d~You don't have enough jewellery!"})
--                 end
--             end
--         end
--     end
-- end)