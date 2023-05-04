function AQUAcfgdrugsServer.ScrapJobGather()
  
    local user_id = AQUA.getUserId({source})
    if user_id ~= nil and AQUA.hasPermission({user_id, "scrap.job"}) then
      local amount = 4
      local item = 1.00
      local new_weight = AQUA.getInventoryWeight({user_id})+(item*amount)
      if new_weight > AQUA.getInventoryMaxWeight({user_id}) then
        AQUAclient.notify(source,{"~d~Not enough space in inventory."})
      else
        AQUA.giveInventoryItem({user_id, 'scrap', 1, true})
      end
    else
      AQUAclient.notify(source,{"~d~You do not have the correct license."})
    end
end

function AQUAcfgdrugsServer.SellScrapJob(amount)
    local user_id = AQUA.getUserId({source})
    if AQUA.tryGetInventoryItem({user_id,'scrap', 1}) then

      local item = AQUA.getInventoryItemAmount({user_id,'scrap'})
      local amount2 = amount

      if user_id ~= nil  then
        if amount > amount2 then
          AQUAclient.notify(source, {"~d~You do not have that much ScrapJob."})
          return
        end
        
        local price = 1000 * tonumber(amount) * 2

        AQUA.giveMoney({user_id,price})

        AQUAclient.notify(source, {"~g~Successfully sold " .. amount .. " Scrap for £" .. price})


      end

    end
end
