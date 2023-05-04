globalHideEmergencyCallUI=false
a=false
local b=1
local c=1
local d={}
local e={}
local f={}
local g=0.06
local h
local i=6
local function j()
    f={}
    f[1]={}
    c=1
    local k=0
    local l=0
    for m,n in pairs(d)do 
        if l%i==0 then
            k=k+1
            c=c+1
            l=0
            f[k]={}
            f[k]
            [l+1]=n 
        else
            f[k]
            [l+1]=n 
        end
        l=l+1 
    end 
end
local y2=false
local z2=nil
-- a = Is player in call manager menu
RegisterNetEvent("AQUA:AddCall")
AddEventHandler("AQUA:AddCall",function(o,p,q,r,s,t)
    -- o = unknown | possibly ticket id
    -- p = Player Name
    -- q = Player Id
    -- r = Player Coords
    -- s = Ticket Reason
    -- t = Ticket Type

    -- u = Time Since
    local u=0
    print(getStaffLevel())
    if t=="admin"and getStaffLevel() >= 1 then
        tAQUA.notify("~p~Admin ticket received.")
        PlaySound(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",0,0,1)
        local v=#(r-GetEntityCoords(GetPlayerPed(-1)))
        table.insert(d,{o,p,q,v,s,t,u})
        j()
        e[o]=r 
    elseif t=="met"and globalOnPoliceDuty then 
        AQUA.notify("~b~MET Police call received.")
        PlaySound(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",0,0,1)
        local v=#(r-GetEntityCoords(GetPlayerPed(-1)))
        table.insert(d,{o,p,q,v,s,t,u})
        j()
        e[o]=r
    --[[elseif t == "nhs" and globalNHSOnDuty then
        AQUA.notify("~b~NHS call received.")
        PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
        local v = #(r - GetEntityCoords(getPlayerPed()))
        table.insert(d, {o, p, q, v, s, t, u})
        j()
        e[o] = r
    elseif t == "lfb" and globalLFBOnDuty then
        AQUA.notify("~b~LFB call received.")
        PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
        local v = #(r - GetEntityCoords(getPlayerPed()))
        table.insert(d, {o, p, q, v, s, t, u})
        j()
        e[o] = r
    elseif t == "hmp" and globalOnPrisonDuty then
        AQUA.notify("~b~HMP call received.")
        PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
        local v = #(r - GetEntityCoords(getPlayerPed()))
        table.insert(d, {o, p, q, v, s, t, u})
        j()
        e[o] = r
    elseif t == "aa" and globalOnAADuty then
        AQUA.notify("~b~AA call received. (`) to open call manager!")
        PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
        local v = #(r - GetEntityCoords(getPlayerPed()))
        table.insert(d, {o, p, q, v, s, t, u})
        ]]
    end 
end)
RegisterNetEvent("AQUA:RemoveCall")
AddEventHandler("AQUA:RemoveCall",function(o)
    for m,n in pairs(d)do 
        if n[1]==o then 
            table.remove(d,m)
        end 
    end
    j()
end)
Citizen.CreateThread(function()
    while true do 
        if a then 
            SetScriptGfxDrawOrder(0.0)
            DrawRect(0.251, 0.528, 0.485, 0.056, 0, 0, 0, 150)
            SetScriptGfxDrawOrder(0.0)
            DrawRect(0.251, 0.559, 0.485, 0.0059999999999999, 0, 168, 255, 150)
            SetScriptGfxDrawOrder(0.0)
            DrawRect(0.251, 0.775, 0.485, 0.426, 0, 0, 0, 150)
            DrawAdvancedText(0.339,0.529,0.005,0.0028,0.51,AQUAConfig.ServerName.." Call Manager",255,255,255,255,7,0)
            local w=0
            local x,y,z=132,132,196
            if f[b]~=nil then 
                for A,n in ipairs(f[b])do 
                    local o,p,q,v,s,t,u=table.unpack(n)
                    DrawAdvancedText(0.458, 0.616 + w * g, 0.005, 0.0028, 0.4, s, 255, 255, 255, 255, 6, 0)
                    if t=="admin"then 
                        DrawAdvancedText(0.414,0.592 + w * g,0.005,0.0028,0.36,p .. " - ID: " .. q .. " - Distance " .. math.floor(v) .. "m - " .. u .. " mins ago",255,20,10,255,6,1)
                    elseif t=="met"then 
                        DrawAdvancedText(0.414,0.592 + w * g,0.005,0.0028,0.36,p .. " - ID: "..tostring(q).." - Distance "..math.floor(v).."m - "..u.." mins ago",0,50,255,255,6,1)
                    elseif t == "nhs" then
                        DrawAdvancedText(0.414,0.592 + w * g,0.005,0.0028,0.36,p .. " - ID: " .. q .. " - Distance " .. math.floor(v) .. "m - " .. u .. " mins ago",0,255,50,255,6,1)
                    elseif t == "lfb" then
                        DrawAdvancedText(0.414,0.592 + w * g,0.005,0.0028,0.36,p .. " - ID: " .. q .. " - Distance " .. math.floor(v) .. "m - " .. u .. " mins ago",255,140,0,255,6,1)
                    elseif t == "hmp" then
                        DrawAdvancedText(0.414,0.592 + w * g,0.005,0.0028,0.36,p .. " - ID: " .. q .. " - Distance " .. math.floor(v) .. "m - " .. u .. " mins ago",117,144,255,255,6,1)
                    elseif t == "aa" then
                        DrawAdvancedText(0.414,0.592 + w * g,0.005,0.0028,0.36,p .. " - ID: " .. q .. " - Distance " .. math.floor(v) .. "m - " .. u .. " mins ago",255,255,0,255,6,1)
                    end
                    if CursorInArea(0.2692,0.4723,0.5962+w*g,0.6305+w*g)then 
                        DrawRect(0.371,0.615+w*g,0.205,0.035,x,y,z,150)
                        if IsControlJustPressed(1,329)or IsDisabledControlJustPressed(1,329)then 
                            PlaySound(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",0,0,1)
                            h=o
                            if h~=nil then 
                                SetNewWaypoint(e[h].x,e[h].y)
                            end 
                        end 
                    elseif o==h then 
                        DrawRect(0.371, 0.615 + w * g, 0.205, 0.035, x, y, z, 150)
                    else
                        DrawRect(0.371, 0.615 + w * g, 0.205, 0.035, 0, 0, 0, 150)
                    end
                    w=w+1 
                end 
            end
            if CursorInArea(0.2557, 0.2916, 0.9444, 0.9759) then
                DrawRect(0.274, 0.961, 0.037, 0.032, x, y, z, 150)
                if IsControlJustPressed(1,329)or IsDisabledControlJustPressed(1,329)then 
                    PlaySound(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",0,0,1)
                    if d[h]~=nil then 
                        for m,n in pairs(d)do 
                            if n[1]==h then 
                                table.remove(d,m)
                            end 
                        end
                        j()
                    else 
                        local B=false
                        for m,n in pairs(d)do 
                            if not B then 
                                table.remove(d,m)
                                B=true 
                            end 
                        end
                        j()
                    end 
                end 
            else 
                DrawRect(0.274, 0.961, 0.037, 0.032, 0, 0, 0, 150)
            end
            if CursorInArea(0.3072, 0.3468, 0.9444, 0.9759) then
                DrawRect(0.328, 0.96, 0.04, 0.032, x, y, z, 150)
                if IsControlJustPressed(1,329)or IsDisabledControlJustPressed(1,329)then 
                    PlaySound(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",0,0,1)
                    if b<=1 then 
                        tAQUA.notify("~d~Lowest page reached")
                    else 
                        b=b-1 
                    end 
                end 
            else 
                DrawRect(0.328, 0.96, 0.04, 0.032, 0, 0, 0, 150)
            end
            if CursorInArea(0.3697, 0.4088, 0.9444, 0.9759) then
                DrawRect(0.39, 0.96, 0.04, 0.032, x, y, z, 150)
                if IsControlJustPressed(1,329)or IsDisabledControlJustPressed(1,329)then 
                    PlaySound(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",0,0,1)
                    if b>=c-1 then 
                        tAQUA.notify("~d~Max page reached")
                    else 
                        b=b+1 
                    end 
                end 
            else 
                DrawRect(0.39, 0.96, 0.04, 0.032, 0, 0, 0, 150)
            end
            if CursorInArea(0.4234, 0.4614, 0.9444, 0.9759) then
                DrawRect(0.444, 0.96, 0.037, 0.03, x, y, z, 150)
                if IsControlJustPressed(1,329)or IsDisabledControlJustPressed(1,329)then 
                    PlaySound(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",0,0,1)
                    if h~=nil then 
                        TriggerServerEvent("AQUA:AcceptCall",h)
                        y2=true
                        z2=GetEntityCoords(GetPlayerPed(-1))
                        a=not a
                        SetNewWaypoint(e[h].x,e[h].y)
                        TriggerEvent("AQUA:ToggleMoneyUI",true)
                        globalHideEmergencyCallUI=false
                        SetRadarBigmapEnabled(false,false)
                        setCursor(0)
                        inGuiAQUA=false
                        for m,n in pairs(globalBlips)do 
                            SetBlipAlpha(n,255)
                        end 
                    else 
                        local B=false
                        local C
                        for m,n in pairs(d)do 
                            if not B then 
                                C=n[1]
                                B=true 
                            end 
                        end
                        if C~=nil then 
                            TriggerServerEvent("AQUA:AcceptCall",C)
                            y2=true
                            z2=GetEntityCoords(GetPlayerPed(-1))
                            a=not a
                            SetNewWaypoint(e[C].x,e[C].y)
                            TriggerEvent("AQUA:ToggleMoneyUI",true)
                            globalHideEmergencyCallUI=false
                            SetRadarBigmapEnabled(false,false)
                            setCursor(0)
                            inGuiAQUA=false
                            for m,n in pairs(globalBlips)do 
                                SetBlipAlpha(n,255)
                            end 
                        else 
                            tAQUA.notify("~d~No calls available.")
                        end 
                    end 
                end 
            else 
                DrawRect(0.444,0.96,0.037,0.03,0,0,0,150)
            end
            DrawAdvancedText(0.453,0.964,0.005,0.0028,0.4,b.." / "..c-1,255,255,255,255,6,0)
            DrawAdvancedText(0.369,0.963,0.005,0.0028,0.4,"Deny (-)",255,0,0,255,4,0)
            DrawAdvancedText(0.423,0.963,0.005,0.0028,0.4,"Previous",255,255,255,255,4,0)
            DrawAdvancedText(0.485,0.963,0.005,0.0028,0.4,"Next",255,255,255,255,4,0)
            DrawAdvancedText(0.539,0.963,0.005,0.0028,0.4,"Accept (=)",12,255,26,255,4,0)
            if IsDisabledControlJustPressed(1,84)then 
                PlaySound(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",0,0,1)
                if d[h]~=nil then 
                    for m,n in pairs(d)do 
                        if n[1]==h then 
                            table.remove(d,m)
                        end 
                    end
                    j()
                else 
                    local 
                    B=false
                    for m,n in pairs(d)do 
                        if not B then 
                            table.remove(d,m)
                            B=true 
                        end 
                    end
                    j()
                end 
            end
            if IsDisabledControlJustPressed(1,83)then 
                PlaySound(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",0,0,1)
                if h~=nil then 
                    TriggerServerEvent("AQUA:AcceptCall",h)
                    y2=true
                    z2=GetEntityCoords(GetPlayerPed(-1))
                    a=not a
                    SetNewWaypoint(e[h].x,e[h].y)
                    TriggerEvent("AQUA:ToggleMoneyUI",true)
                    globalHideEmergencyCallUI=false
                    SetRadarBigmapEnabled(false,false)
                    setCursor(0)
                    inGuiAQUA=false
                    for m,n in pairs(globalBlips)do 
                        SetBlipAlpha(n,255)
                    end 
                else 
                    local B=false
                    local C
                    for m,n in pairs(d)do 
                        if not B then 
                            C=n[1]
                            B=true 
                        end 
                    end
                    if C~=nil then 
                        TriggerServerEvent("AQUA:AcceptCall",C)
                        y2=true
                        z2=GetEntityCoords(GetPlayerPed(-1))
                        a=not a
                        SetNewWaypoint(e[C].x,e[C].y)
                        TriggerEvent("AQUA:ToggleMoneyUI",true)
                        globalHideEmergencyCallUI=false
                        SetRadarBigmapEnabled(false,false)
                        setCursor(0)
                        inGuiAQUA=false
                        for m,n in pairs(globalBlips)do 
                            SetBlipAlpha(n,255)
                        end 
                    else 
                        tAQUA.notify("~d~No calls available.")
                    end 
                end 
            end 
        end
        if inGuiAQUA then
            DisableControlAction(0,1,true)
            DisableControlAction(0,2,true)
            DisableControlAction(0,25,true)
            DisableControlAction(0,106,true)
            DisableControlAction(0,24,true)
            DisableControlAction(0,140,true)
            DisableControlAction(0,141,true)
            DisableControlAction(0,142,true)
            DisableControlAction(0,257,true)
            DisableControlAction(0,263,true)
            DisableControlAction(0,264,true)
            DisableControlAction(0,12,true)
            DisableControlAction(0,14,true)
            DisableControlAction(0,15,true)
            DisableControlAction(0,16,true)
            DisableControlAction(0,17,true)
        end
        Wait(0)
    end 
end)

Citizen.CreateThread(function()
    while true do 
        if IsControlJustPressed(0,243)then 
            a=not a
            if not a then 
                TriggerEvent("AQUA:ToggleMoneyUI",true)
                globalHideEmergencyCallUI=false
                SetRadarBigmapEnabled(false,false)
                setCursor(0)
                inGuiAQUA=false
                for m,n in pairs(globalBlips)do 
                    SetBlipAlpha(n,255)
                end 
            else
                TriggerEvent("AQUA:ToggleMoneyUI",false)
                globalHideEmergencyCallUI=true
                SetRadarBigmapEnabled(true,true)
                setCursor(1)
                inGuiAQUA=true
                for m,n in pairs(globalBlips)do 
                    SetBlipAlpha(n,0)
                end 
            end 
        end
        Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do 
        for m,n in pairs(f)do 
            for D,E in pairs(n)do 
                E[7]=E[7]+1 
            end 
        end
        Wait(60000)
    end 
end)

function tAQUA.isInTicket()
    return y2
end

RegisterCommand("return",function(source)
    if tAQUA.isInTicket()then
        if z2~=nil then
            local x,y,z=table.unpack(z2)
            SetEntityCoords(GetPlayerPed(-1),x,y,z)
            z2=nil
        else
            tAQUA.notify("Couldnt get saved coords.")
        end
        TriggerEvent("AQUA:StartAdminTicket",false)
    else
        tAQUA.notify("You are not in a ticket.")
    end
end)
-- Probs not best way todo but fuck it :)
RegisterNetEvent("AQUA:CloseCallManager",function()
    a = false
end)

RegisterNetEvent("AQUA:StartAdminTicket",function(Status,PlayerName,PlayerId)
    if getStaffLevel() > 0 then
        TriggerEvent("AQUA:OMioDioMode",Status)
        Wait(500)
        y2=Status
        while tAQUA.isStaffedOn()and tAQUA.isInTicket()do
            if PlayerName~=nil and PlayerId~=nil then
                tAQUA.drawNativeText("~y~You've taken the ticket of "..PlayerName.."("..PlayerId..")")
                Wait(0)
            end
        end
    end
end)

GlobalStaffOn = false

function tAQUA.isStaffedOn()
    return GlobalStaffOn
end

RegisterCommand("staffon", function()
    if not tAQUA.isInTicket()then
        if GetEntityHealth(GetPlayerPed(-1)) <= 103 then
            TriggerEvent('AQUA:FixClient')
        end
        TriggerEvent("AQUA:OMioDioMode",true)
        TriggerEvent("AQUA:CloseCallManager",false)
    else
        tAQUA.notify("You are in a ticket, use /return.")
    end
end)

RegisterCommand("staffoff", function()
    if not tAQUA.isInTicket()then
        TriggerEvent("AQUA:OMioDioMode",false)
    else
        tAQUA.notify("You are in a ticket, use /return.")
    end
end)
local a2=nil;
local b2=nil;
RegisterNetEvent("AQUA:OMioDioMode")
AddEventHandler("AQUA:OMioDioMode",function(y)
    if getStaffLevel()>0 then 
        GlobalStaffOn=y;
        if tAQUA.isStaffedOn()==false then
            SetEntityInvincible(GetPlayerPed(-1),false)
            SetPlayerInvincible(PlayerId(),false)
            SetPedCanRagdoll(GetPlayerPed(-1),true)
            ClearPedBloodDamage(GetPlayerPed(-1))
            ResetPedVisibleDamage(GetPlayerPed(-1))
            ClearPedLastWeaponDamage(GetPlayerPed(-1))
            SetEntityProofs(GetPlayerPed(-1),false,false,false,false,false,false,false,false)
            SetEntityCanBeDamaged(GetPlayerPed(-1),true)
            tAQUA.setHealth(200)
            tAQUA.setCustomization(a2)
            tAQUA.giveWeapons(b2,false)
            a2=nil
            b2=nil
        elseif tAQUA.isStaffedOn()==true then
            a2=tAQUA.getCustomization()
            b2=tAQUA.getWeapons()
            gender = getModelGender()
            local z;
        
                if gender == "male" then
                    z="mp_m_freemode_01"
                    local A=loadModel(z)
                    setRedzoneTimerDisabled(true)
                    tAQUA.setCustomization({modelhash=A})
                    Wait(100)
                    local B=getPlayerPed()
                    SetPedComponentVariation(B,1,88,0,0) -- [Arms]
                    SetPedComponentVariation(B,6,146,0,0) -- [Legs]
                    SetPedComponentVariation(B,8,15,0,0) -- [Undershirt]
                    SetPedComponentVariation(B,11,295,0,00) -- [Jacket]
                    SetPedComponentVariation(B,6,138,2,00) -- [Shoes]
                end
        end 
    end
end)

function getModelGender()
    local hashSkinMale = GetHashKey("mp_m_freemode_01")
    local hashSkinFemale = GetHashKey("mp_f_freemode_01")
    if GetEntityModel(PlayerPedId()) == hashSkinMale then
        return "male"
    elseif GetEntityModel(PlayerPedId()) == hashSkinFemale then
        return "female"
    end
end