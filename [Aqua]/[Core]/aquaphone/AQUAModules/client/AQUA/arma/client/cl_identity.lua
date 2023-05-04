local b={vector3(-552.35083007813,-191.59149169922,38.21964263916)}
local c=false
local d=""
local j="N/A"
local k="N/A"
local i=0
local U=false
RMenu.Add("identity","main",RageUI.CreateMenu("","~b~City Hall",0,100,'banners', 'identity'))
RMenu.Add('identity','confirm',RageUI.CreateSubMenu(RMenu:Get('identity','main'),"","Confirm Identity"))
Citizen.CreateThread(function()
    if true then 
        local g=function()
            drawNativeNotification("Press ~INPUT_PICKUP~ to access the City Hall.")
            PlaySound(-1,"SELECT","HUD_MINI_GAME_SOUNDSET",0,0,1)
        end
        local h=function()
            RageUI.ActuallyCloseAll()
            RageUI.Visible(RMenu:Get("identity","main"),false)
            RageUI.Visible(RMenu:Get('identity','confirm'), false)
        end
        local i=function()
            if IsControlJustPressed(1,51)then 
                TriggerServerEvent('ARMA:getIdentity')
                RageUI.ActuallyCloseAll()
                RageUI.Visible(RMenu:Get("identity","main"),not RageUI.Visible(RMenu:Get("identity","main")))
            end 
        end
        for j,k in pairs(b)do 
            tARMA.createArea("identity_"..j,k,1.5,6,g,h,i)
            tARMA.addMarker(k.x,k.y,k.z-0.2,0.5,0.5,0.5,0,50,255,170,50,20,false,false,true)
        end 
    end 
end)

RegisterNetEvent("ARMA:gotCurrentIdentity")
AddEventHandler("ARMA:gotCurrentIdentity", function(firstname,lastname,age)
    j=firstname
    k=lastname
    i=age
end)

RegisterNetEvent("ARMA:gotNewIdentity")
AddEventHandler("ARMA:gotNewIdentity", function(firstname,lastname,age)
    newfirstname=firstname
    newlastname=lastname
    newage=age
    RageUI.Visible(RMenu:Get('identity', 'confirm'), true)
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('identity', 'main')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if j ~= "N/A" then
                RageUI.Separator("~b~Your current identity")
                RageUI.Separator("Firstname ~y~|~w~ "..j.."")
                RageUI.Separator("Lastname ~y~|~w~ "..k.."")
                RageUI.Separator("Age ~y~|~w~ "..i.."")
                RageUI.ButtonWithStyle("Change your Identity","£5000",{RightLabel="→→→"},true,function(l,m,n)
                    if n then 
                        RageUI.ActuallyCloseAll()
                        TriggerServerEvent('ARMA:getNewIdentity')
                    end 
                end)
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('identity', 'confirm')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.Separator("~b~Your new identity")
            RageUI.Separator("Firstname ~y~|~w~ "..newfirstname.."")
            RageUI.Separator("Lastname ~y~|~w~ "..newlastname.."")
            RageUI.Separator("Age ~y~|~w~ "..newage.."")
            RageUI.ButtonWithStyle("Yes","",{RightLabel="→→→"},true,function(j,k,l)
                if l then 
                    TriggerServerEvent("ARMA:ChangeIdentity", newfirstname, newlastname, tonumber(newage))
                    RageUI.ActuallyCloseAll()
                end 
            end,RMenu:Get("identity","confirm"))
            RageUI.ButtonWithStyle("No","",{RightLabel="→→→"},true,function(j,k,l)
            end,RMenu:Get("identity","main"))
        end)
    end
end)

local o = false
local function p(q)
    local r = GetPlayerFromServerId(q)
    if r == -1 then
        return "CHAR_BLOCKED", nil
    end
    local s = GetPlayerPed(r)
    if s == 0 then
        return "CHAR_BLOCKED", nil
    end
    local t = RegisterPedheadshotTransparent(s)
    local u = GetGameTimer()
    while not IsPedheadshotReady(t) do
        if GetGameTimer() - u > 2500 or not IsPedheadshotValid(t) then
            UnregisterPedheadshot(t)
            return "CHAR_BLOCKED", nil
        end
        Citizen.Wait(0)
    end
    return GetPedheadshotTxdString(t), t
end
-- v = their id
-- w = their license type
-- x = their first name
-- y = their last name
-- z = their date of birth
-- A = ?
-- B = license start
-- C = license expire
-- D = ?

RegisterNetEvent("ARMA:showIdentity",function(v, w, x, y, z, A, B, C, D)
    o = true
    RequestStreamedTextureDict("driving_licence")
    while not HasStreamedTextureDictLoaded("driving_licence") do
        Citizen.Wait(0)
    end
    local E, F = p(v)
    local G = w and "full" or "provisional"
    local H = tARMA.getFontId("Akrobat-ExtraLight")
    x = string.upper(x)
    y = string.upper(y)
    while o do
        DrawSprite("driving_licence", G, 0.15, 0.5, 0.3, 0.3, 0.0, 255, 255, 255, 255)
        DrawSprite(E, E, 0.05, 0.5, 0.07, 0.1, 0.0, 255, 255, 255, 255)
        DrawAdvancedTextNoOutline(0.2, 0.413, 0.005, 0.0028, 0.25, x, 70, 70, 71, 255, H, 1)
        DrawAdvancedTextNoOutline(0.2, 0.426, 0.005, 0.0028, 0.25, y, 70, 70, 71, 255, H, 1)
        DrawAdvancedTextNoOutline(0.2,0.456,0.005,0.0028,0.25,string.format("%s ENGLAND", z),70,70,71,255,H,1)
        DrawAdvancedTextNoOutline(0.2, 0.470, 0.005, 0.0028, 0.25, B, 70, 70, 71, 255, H, 1)
        DrawAdvancedTextNoOutline(0.2, 0.484, 0.005, 0.0028, 0.25, C, 70, 70, 71, 255, H, 1)
        DrawAdvancedTextNoOutline(0.2, 0.510, 0.005, 0.0028, 0.35, A, 70, 70, 71, 255, H, 1)
        for I, J in pairs(D) do
            DrawAdvancedTextNoOutline(0.2, 0.534 + I * 0.018, 0.005, 0.0028, 0.25, J, 70, 70, 71, 255, H, 1)
        end
        Citizen.Wait(0)
    end
    SetStreamedTextureDictAsNoLongerNeeded("driving_licence")
    if F then
        UnregisterPedheadshot(F)
    end
end)
RegisterNetEvent("ARMA:hideIdentity",function()
    o = false
end)
