local a={}
local b=630.0
local c='prop_car_airbag'
local d=0
Citizen.CreateThread(function()
    while true do 
        local e=tARMA.getPlayerVehicle()
        if e~=0 and GetPedInVehicleSeat(e,-1)==tARMA.getPlayerPed()then 
            local f=GetVehicleEngineHealth(e)
            if f<=b and a[e]==nil then 
                local g=GetVehicleClass(e)
                if g~=8 and g~=16 and g~=15 and g~=13 then 
                    TriggerServerEvent("ARMA:playNuiSound","airbag",15.0,soundEventCode)
                    createAirbags(e)
                end 
            else 
                if a[e]==nil then 
                    d=GetPedArmour(tARMA.getPlayerPed())
                end 
            end 
        else 
            d=0 
        end
        for h,i in pairs(a)do 
            if not DoesEntityExist(i[1])then 
                if DoesEntityExist(i[2])then 
                    DeleteEntity(i[2])
                end
                if DoesEntityExist(i[3])then 
                    DeleteEntity(i[3])
                end
                a[h]=nil 
            end 
        end
        Wait(1000)
    end 
end)
function createAirbags(e)
    a[e]={e}
    local j=GetEntityBoneIndexByName(e,"seat_dside_f")
    local k=GetEntityBoneIndexByName(e,"seat_pside_f")
    tARMA.loadModel(c)
    local l=tARMA.getPlayerCoords()
    local m=CreateObject(c,l.x,l.y,l.z,false,false,false)
    local n=CreateObject(c,l.x,l.y,l.z,false,false,false)
    a[e][2]=m
    a[e][3]=n
    while not DoesEntityExist(m)or not DoesEntityExist(n)do 
        Wait(0)
    end
    SetModelAsNoLongerNeeded(c)
    AttachEntityToEntity(m,e,j,0.0,0.30,0.40,90.0,0.0,0.0,true,true,false,false,2,true)
    AttachEntityToEntity(n,e,k,0.0,0.40,0.40,90.0,0.0,0.0,true,true,false,false,2,true)
    if d>GetPedArmour(tARMA.getPlayerPed())then 
        tARMA.setArmour(d)
    end
    d=0
    SetTimeout(10000,function()
        if DoesEntityExist(m)then 
            DeleteEntity(m)
        end
        if DoesEntityExist(n)then 
            DeleteEntity(n)
        end 
    end)
end