function AQUAcfgdrugsServer.LSDGather()
  
    local user_id = AQUA.getUserId({source})
    if user_id ~= nil and AQUA.hasPermission({user_id, "lsd.job"}) then
      local amount = 4
      local item = 1.00
      local new_weight = AQUA.getInventoryWeight({user_id})+(item*amount)
      if new_weight > AQUA.getInventoryMaxWeight({user_id}) then
        AQUAclient.notify(source,{"~d~Not enough space in inventory."})
      else
        AQUA.giveInventoryItem({user_id, 'acid', 4, true})
      end
    else
      AQUAclient.notify(source,{"~d~You do not have the correct license."})
    end
end

function AQUAcfgdrugsServer.CanProcessLSD()
    local user_id = AQUA.getUserId({source})
    return AQUA.hasPermission({user_id, "lsd.job"}), 
    AQUA.getInventoryItemAmount({user_id, 'acid'}) >= 4
end


function AQUAcfgdrugsServer.ProcessLSD()
    local user_id = AQUA.getUserId({source})
    if AQUA.getInventoryItemAmount({user_id, 'acid'}) >= 4 then
      AQUA.tryGetInventoryItem({user_id, 'acid', 4, false})
      AQUA.giveInventoryItem({user_id, 'LSD', 1, false})
    end
end

function AQUAcfgdrugsServer.SellLSD(amount)
    local user_id = AQUA.getUserId({source})
    if AQUA.tryGetInventoryItem({user_id,'LSD', 1}) then

      local item = AQUA.getInventoryItemAmount({user_id,'LSD'})
      local amount2 = amount

      if user_id ~= nil then
        if amount > amount2 then
          AQUAclient.notify(source, {"~d~You do not have that much LSD."})
          return
        end
        
        local price = 65000 * tonumber(amount) *2

        AQUA.giveMoney({user_id,price}) 

        AQUAclient.notify(source, {"~g~Successfully sold " .. amount .. " LSD for £" .. price})


      end
    else
     AQUAclient.notify(source, {"~d~You do not have any LSD."})
    end
end
