function openGui()
    SetNuiFocus(false)
    SendNUIMessage({openNUI=true})
end
function closeGui()
    SetNuiFocus(false)
    SendNUIMessage({openNUI=false})
end

local P=0
local Q=0
RegisterNetEvent("ARMA:placeHeadBag")
AddEventHandler("ARMA:placeHeadBag",function()
    Q=Q+1
    if Q%2~=0 then 
        local R=tARMA.getPlayerPed()
        P=CreateObject('prop_money_bag_01',0,0,0,true,true,true)
        AttachEntityToEntity(P,R,GetPedBoneIndex(R,12844),0.2,0.04,0,0,270.0,60.0,true,true,false,true,1,true)
        openGui()
    else 
        DeleteEntity(P)
        closeGui()
    end 
end)