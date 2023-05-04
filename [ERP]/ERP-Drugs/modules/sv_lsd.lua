function ElementDrugsSV.LSDGather()
  
    local user_id = vRP.getUserId({source})
    if user_id ~= nil and vRP.hasPermission({user_id, "lsd.job"}) then
      local amount = 5
      local item = 1.00
      local new_weight = vRP.getInventoryWeight({user_id})+(item*amount)
      if new_weight > vRP.getInventoryMaxWeight({user_id}) then
        vRPclient.notify(source,{"~r~Not enough space in inventory."})
      else
        vRP.giveInventoryItem({user_id, 'acid', 5, true})
      end
    else
      vRPclient.notify(source,{"~r~You do not have the correct license."})
    end
end

function ElementDrugsSV.CanProcessLSD()
    local user_id = vRP.getUserId({source})
    return vRP.hasPermission({user_id, "lsd.job"}), 
    vRP.getInventoryItemAmount({user_id, 'acid'}) >= 5
end


function ElementDrugsSV.ProcessLSD()
    local user_id = vRP.getUserId({source})
    if vRP.getInventoryItemAmount({user_id, 'acid'}) >= 5 then
      vRP.tryGetInventoryItem({user_id, 'acid', 5, false})
      vRP.giveInventoryItem({user_id, 'LSD', 1, false})
    end
end

function ElementDrugsSV.SellLSD(amount)
    local user_id = vRP.getUserId({source})
    if vRP.tryGetInventoryItem({user_id,'LSD', 1}) then

      local item = vRP.getInventoryItemAmount({user_id,'LSD'})
      local amount2 = amount

      if user_id ~= nil then
        if amount > amount2 then
          vRPclient.notify(source, {"~r~You do not have that much LSD."})
          return
        end
        
        local price = 30000 * tonumber(amount)

        vRP.giveMoney({user_id,price})

        vRPclient.notify(source, {"~g~Successfully sold " .. amount .. " LSD for £" .. price})


      end
    else
     vRPclient.notify(source, {"~r~You do not have any LSD."})
    end
end
