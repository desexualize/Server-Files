function AQUAcfgdrugsServer.HeroinGather()
  
    local user_id = AQUA.getUserId({source})
    if user_id ~= nil and AQUA.hasPermission({user_id, "heroin.job"}) then
      local amount = 4
      local item = 1.00
      local new_weight = AQUA.getInventoryWeight({user_id})+(item*amount)
      if new_weight > AQUA.getInventoryMaxWeight({user_id}) then
        AQUAclient.notify(source,{"~d~Not enough space in inventory."})
      else
        AQUA.giveInventoryItem({user_id, 'opium', 4, true})
      end
    else
      AQUAclient.notify(source,{"~d~You do not have the correct license."})
    end
end

function AQUAcfgdrugsServer.CanProcessHeroin()
    local user_id = AQUA.getUserId({source})
    return AQUA.hasPermission({user_id, "heroin.job"}), 
    AQUA.getInventoryItemAmount({user_id, 'opium'}) >= 4
end


function AQUAcfgdrugsServer.ProcessHeroin()
    local user_id = AQUA.getUserId({source})
    if AQUA.getInventoryItemAmount({user_id, 'opium'}) >= 4 then
      AQUA.tryGetInventoryItem({user_id, 'opium', 4, false})
      AQUA.giveInventoryItem({user_id, 'heroin', 1, false})
    end
end

function AQUAcfgdrugsServer.SellHeroin(amount)
    local user_id = AQUA.getUserId({source})
    if AQUA.tryGetInventoryItem({user_id,'heroin', 1}) then


      local amount2 = amount

      if user_id ~= nil then
        if amount > amount2 then
          AQUAclient.notify(source, {"~d~You do not have that much heroin."})
          return
        end
        
        local price = 10000 * tonumber(amount) * 2


        AQUA.giveMoney({user_id,price})

        AQUAclient.notify(source, {"~g~Successfully sold " .. amount .. " heroin for £" .. price})


      end
    else
     AQUAclient.notify(source, {"~d~You do not have any heroin."})
    end
end
