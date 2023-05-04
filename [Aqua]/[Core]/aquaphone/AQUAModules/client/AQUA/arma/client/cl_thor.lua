local function f(g)
    local h=GetActivePlayers()
    local i=-1
    local j=-1
    local k=PlayerPedId()
    local b=GetEntityCoords(k)
    for l,m in ipairs(h)do 
        local n=GetPlayerPed(m)
        if n~=k then 
            local o=GetEntityCoords(n)
            local p=#(o-b)
            if i==-1 or i>p then 
                j=m
                i=p 
            end 
        end 
    end
    if i~=-1 and i<=g then 
        return j 
    else 
        return nil 
    end 
end

RegisterNetEvent("ARMA:useTheForceTarget")
AddEventHandler("ARMA:useTheForceTarget",function()
    FreezeEntityPosition(PlayerPedId(),true)
    Wait(2500)
    tARMA.loadAnimDict("ragdoll@human")
    TaskPlayAnim(tARMA.getPlayerPed(),"ragdoll@human","electrocute",3.0,1.0,-1,01,0,0,0,0)
    Wait(5000)
    SetEntityHealth(tARMA.getPlayerPed(),0)
    FreezeEntityPosition(PlayerPedId(),false)
end)

RegisterNetEvent("ARMA:useTheForceSync")
AddEventHandler("ARMA:useTheForceSync",function(q,r,s)
    if#(q-GetEntityCoords(PlayerPedId()))<25.0 then 
        TriggerEvent("arma:PlaySound", "unlimitedpower")
        local s={}
        local a=0
        local diffVector=r-q
        for t=1,10,1 do 
            table.insert(s,q+vector3(diffVector.x/10*t,diffVector.y/10*t,diffVector.z/10*t))
        end
        local u={}
        for v,w in pairs(s)do 
            SetPtfxAssetNextCall("core")
            local c=StartParticleFxLoopedAtCoord("ent_dst_elec_crackle",w.x,w.y,w.z,0.0,0.0,0.0,1.2,false,false,false)
            table.insert(u,c)
        end
        while a<150 do 
            a=a+1
            for v,w in pairs(s)do 
                SetPtfxAssetNextCall("core")
                local c=StartParticleFxLoopedAtCoord("sp_foundry_sparks",w.x,w.y,w.z,90.0,0.0,0.0,0.3,false,false,false)
                SetPtfxAssetNextCall("core")
                local d=StartParticleFxLoopedAtCoord("ent_dst_elec_fire_sp",w.x,w.y,w.z,0.0,0.0,0.0,1.0,false,false,false)
                table.insert(u,c)
                table.insert(u,d)
            end
            Wait(50)
            for v,w in pairs(u)do 
                RemoveParticleFx(w)
            end 
        end 
    end 
end)

RegisterCommand("theforce",function()
    if tARMA.getUserId() == 1 then
        local j = f(10)
        if j then
            local A = GetPlayerServerId(j)
            if A ~= -1 then
                if not HasNamedPtfxAssetLoaded("core") then
                    RequestNamedPtfxAsset("core")
                    while not HasNamedPtfxAssetLoaded("core") do
                        Wait(0)
                    end
                end
                local a = 0
                local q = GetEntityCoords(PlayerPedId())
                local n = GetPlayerPed(j)
                local r = GetEntityCoords(n)
                local t = {}
                local s = r - q
                TriggerServerEvent("ARMA:theForceSync", A, q, r, s)
                for u = 1, 10, 1 do
                    table.insert(t, q + vector3(s.x / 10 * u, s.y / 10 * u, s.z / 10 * u))
                end
                TriggerEvent("arma:PlaySound", "unlimitedpower")
                FreezeEntityPosition(PlayerPedId(), true)
                tARMA.loadAnimDict("anim@amb@clubhouse@bar@drink@idle_a")
                TaskPlayAnim(tARMA.getPlayerPed(),"anim@amb@clubhouse@bar@drink@idle_a","idle_a_bartender",3.0,1.0,-1,01,0,0,0,0)
                RemoveAnimDict("anim@amb@clubhouse@bar@drink@idle_a")
                local v = {}
                for w, x in pairs(t) do
                    UseParticleFxAsset("core")
                    local c = StartParticleFxLoopedAtCoord("ent_dst_elec_crackle",x.x,x.y,x.z,0.0,0.0,0.0,1.2,false,false,false)
                    table.insert(v, c)
                end
                while a < 150 do
                    a = a + 1
                    for w, x in pairs(t) do
                        UseParticleFxAsset("core")
                        local c = StartParticleFxLoopedAtCoord("sp_foundry_sparks",x.x,x.y,x.z,90.0,0.0,0.0,0.3,false,false,false)
                        UseParticleFxAsset("core")
                        local d = StartParticleFxLoopedAtCoord("ent_dst_elec_fire_sp",x.x,x.y,x.z,0.0,0.0,0.0,1.0,false,false,false)
                        table.insert(v, c)
                        table.insert(v, d)
                    end
                    Wait(50)
                    for w, x in pairs(v) do
                        RemoveParticleFx(x)
                    end
                end
                RemoveNamedPtfxAsset("core")
                FreezeEntityPosition(PlayerPedId(), false)
                ClearPedTasks(PlayerPedId())
            else
               drawNativeNotification("~r~No one nearby to use the force on!")
            end
        else
            drawNativeNotification("~r~No one nearby to use the force on!")
        end
    end
end)
