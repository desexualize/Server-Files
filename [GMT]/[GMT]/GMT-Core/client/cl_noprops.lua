local a = module("GMT-Core", "cfg/cfg_noprops")
local b={}
local c={}
local d={}
local e={}
local f={}
local g=25
local h=25
local i=10
local j=1
local function k(l,m)
    if m then 
        local n=GetGameTimer()
        repeat 
            if GetGameTimer()-n>=2500 then 
                return false 
            end
            RequestStreamedTextureDict(l,false)
            Citizen.Wait(0)
        until HasStreamedTextureDictLoaded(l)
    else 
        SetStreamedTextureDictAsNoLongerNeeded(l)
    end
    return true 
end
local function q(r,s,t,u)
    return r~=t and r~=t/2 or s~=u and s~=u/2 
end
local function v(w)
    loadModel(w)
    local x=CreateObject(w,100.0,100.0,10.0,false,false,false)
    FreezeEntityPosition(x,true)
    SetModelAsNoLongerNeeded(w)
    Citizen.Wait(0)
    local y=StartExpensiveSynchronousShapeTestLosProbe(101.0,101.0,10.5,99.0,99.0,10.5,-1,0,4)
    local z,z,z,z,A=GetShapeTestResult(y)
    local B=x==A
    DeleteEntity(x)
    return B 
end
Citizen.CreateThread(function()
    Citizen.Wait(1000)
    for C,w in ipairs(a.models)do 
        local D=GetHashKey(w)
        if not IsModelInCdimage(D)then 
            table.insert(b,C)
        end 
    end
    if#b<g then 
        for C,w in pairs(a.requiredCollisions)do 
            local D=GetHashKey(w)
            if not v(D)then 
                table.insert(f,C)
            end 
        end 
    end
    if#b<g and#f<j then 
        local E=0
        for l,F in pairs(a.textures)do 
            while E>10 do 
                Citizen.Wait(0)
            end
            Citizen.CreateThreadNow(function()
                E=E+1
                if k(l,true)then 
                    for z,G in ipairs(F)do 
                        local H=G[1]
                        local t=G[2]
                        local u=G[3]
                        local I=GetTextureResolution(l,H)
                        local r=math.floor(I.x)
                        local s=math.floor(I.y)
                        if q(r,s,t,u)then 
                            local D=GetHashKey(string.format("%s.ytd/%s",l,H))
                            if r~=4 and s~=4 then 
                                if a.moddedTextures[l]then 
                                    local J=a.moddedTextures[l][H]
                                    if not J or q(r,s,J[1],J[2])then 
                                        table.insert(c,{D,r,s})
                                    end 
                                else 
                                    table.insert(c,{D,r,s})
                                end 
                            else 
                                table.insert(d,D)
                            end 
                        end 
                    end 
                else 
                    table.insert(e,GetHashKey(string.format("%s.ytd",l)))
                end
                k(l,false)
                E=E-1 
            end)
        end
        while E>0 do 
            Citizen.Wait(0)
        end 
    end
    if#b>g or#c>h or#d>i or#f>j then 
        TriggerServerEvent("GMT:alertNoProps",b,c,d,e,f)
    end
    collectgarbage()
end)
