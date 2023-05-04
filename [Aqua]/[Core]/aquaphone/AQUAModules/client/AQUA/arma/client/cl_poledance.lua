local a={
    enabled=true,locations={
        {coords=vector3(112.60, -1286.76, 28.56),number='1'},{coords=vector3(102.24, -1290.54, 29.26),number='2'},{coords=vector3(104.18, -1293.94, 29.26),number='3'},{coords=vector3(215.0162701416,-1654.5923339844,29.762783203125),number='1'}
    }
}
local b=false
local d=false
local e=function(f,g,h)
    local i,j,k=World3dToScreen2d(f.x,f.y,f.z)
    local l,m,n=table.unpack(GetGameplayCamCoords())
    SetTextScale(h,h)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255,255,255,215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(g)
    DrawText(j,k)
    local o=string.len(g)/370
    DrawRect(j,k+0.0125,0.015+o,0.03,41,41,41,125)
end
Citizen.CreateThread(function()
    if true then 
        for r,s in pairs(a.locations)do 
            local function t()
            end
            local function u()
                d=false 
            end
            local function v(w)
                local x=a.locations[w.poleId].number
                if not d then 
                    e(s.coords,'[~r~E~w~] Poledance',0.35)
                    if IsControlJustReleased(0,51)then 
                        tARMA.loadAnimDict('mini@strip_club@pole_dance@pole_dance'..x)
                        local y=NetworkCreateSynchronisedScene(s.coords,vector3(0.0,0.0,0.0),2,false,false,1065353216,0,1.3)
                        if s.coords == vector3(215.0162701416,-1654.5923339844,29.762783203125) then
                            SendNUIMessage({transactionType="fireman"})
                        end
                        NetworkAddPedToSynchronisedScene(tARMA.getPlayerPed(),y,'mini@strip_club@pole_dance@pole_dance'..x,'pd_dance_0'..x,1.5,-4.0,1,1,1148846080,0)
                        NetworkStartSynchronisedScene(y)
                        d=true 
                    end 
                end 
            end
            tARMA.createArea("poledance_"..r,s.coords,2.25,6,t,u,v,{poleId=r})
        end 
    end 
end)