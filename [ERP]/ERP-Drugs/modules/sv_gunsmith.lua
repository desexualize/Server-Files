
function ElementDrugsSV.DiamondGather()
  local user_id = vRP.getUserId({source})

  if user_id ~= nil and vRP.hasPermission({user_id, "diamond.job"}) then
    local amount = 5
    local item = 1.00
    local new_weight = vRP.getInventoryWeight({user_id})+(item*amount)

    if new_weight > vRP.getInventoryMaxWeight({user_id}) then
      vRPclient.notify(source,{"~r~Not enough space in inventory."})
    else
      vRP.giveInventoryItem({user_id, 'crystal', 5, true})
    end

  else
    vRPclient.notify(source,{"~r~You do not have the correct license."})
  end
end

function ElementDrugsSV.DiamondCanProcess()
  local user_id = vRP.getUserId({source})
  return vRP.hasPermission({user_id, "diamond.job"}),
  vRP.getInventoryItemAmount({user_id, 'crystal'}) >= 5
end

function ElementDrugsSV.DiamondDoneProcessing()
  local user_id = vRP.getUserId({source})
  if vRP.getInventoryItemAmount({user_id, 'crystal'}) >= 5 then
    vRP.tryGetInventoryItem({user_id, 'crystal', 5, false})
    vRP.giveInventoryItem({user_id, 'diamond', 1, false})
  end
end

function ElementDrugsSV.SellGunBody(amount)
 local user_id = vRP.getUserId({source})
 if vRP.tryGetInventoryItem({user_id,'diamond', 1}) then
   local item = vRP.getInventoryItemAmount({user_id,'diamond'})
   local amount2 = amount
   if user_id ~= nil  then
     if amount > amount2 then
       vRPclient.notify(source, {"~r~You do not have that much Diamond's."})
       return
     end
     local price = 10000 * tonumber(amount)
     vRP.giveMoney({user_id,price})
     vRPclient.notify(source, {"~g~Successfully sold " .. amount .. " Diamond for £" .. price})

   end
 end
end