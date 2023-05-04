function ElementDrugsSV.WeedGather()
  
    local user_id = vRP.getUserId({source})
    if user_id ~= nil and vRP.hasPermission({user_id, "weed.job"}) then
      local amount = 5
      local item = 1.00
      local new_weight = vRP.getInventoryWeight({user_id})+(item*amount)
      if new_weight > vRP.getInventoryMaxWeight({user_id}) then
        vRPclient.notify(source,{"~r~Not enough space in inventory."})
      else
        vRP.giveInventoryItem({user_id, 'leef', 5, true})
      end
    else
      vRPclient.notify(source,{"~r~You do not have the correct license."})
    end
end

function ElementDrugsSV.CanProcessWeed()
    local user_id = vRP.getUserId({source})
    return vRP.hasPermission({user_id, "weed.job"}), 
    vRP.getInventoryItemAmount({user_id, 'leef'}) >= 5
end


function ElementDrugsSV.ProcessWeed()
    local user_id = vRP.getUserId({source})
    if vRP.getInventoryItemAmount({user_id, 'leef'}) >= 5 then
      vRP.tryGetInventoryItem({user_id, 'leef', 5, false})
      vRP.giveInventoryItem({user_id, 'weed2', 1, false})
    end
end

function ElementDrugsSV.SellWeed(amount)
    local user_id = vRP.getUserId({source})
    if vRP.tryGetInventoryItem({user_id,'weed2', 1}) then

      local item = vRP.getInventoryItemAmount({user_id,'weed2'})
      local amount2 = amount

      if user_id ~= nil  then
        if amount > amount2 then
          vRPclient.notify(source, {"~r~You do not have that much Weed."})
          return
        end
        
        local price = 5000 * tonumber(amount)

        vRP.giveMoney({user_id,price})

        vRPclient.notify(source, {"~g~Successfully sold " .. amount .. " Weed for £" .. price})


      end

    end
end
