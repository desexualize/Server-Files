local a=true;
local b=false;
local c=false;
local d=false;
local e=false;
local f=nil;
local g=0;
local h=false;
local i={
    GetHashKey("WEAPON_GLOCK"),
    GetHashKey("WEAPON_STUNGUN"),
    GetHashKey("WEAPON_NIGHTSTICK"),
}

function ShowNativeNotify(j)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(j)
    DrawNotification(true,false)
end;

function checkfortimeout(k)
    if not d then 
        Citizen.CreateThread(function()
            d=true;
            g=k;
            while g>0 do 
                Wait(1000)
                ShowNativeNotify(string.format("~r~Your weapons have been holstered as you attempted to cancel the animation. Please wait %ss more.",k/1000))
                g=g-1000;
                b=true;
                a=true;
                f=nil 
            end;
            ShowNativeNotify("~g~Animation timeout complete.")b=false;d=false 
        end)
    end
end;

Citizen.CreateThread(function()
    while true do 
        local l=GetPlayerPed(-1)
        if GetVehiclePedIsTryingToEnter(l)~=0 or d then 
            SetCurrentPedWeapon(l,"WEAPON_UNARMED",true)
        end;if b then 
            DisablePlayerFiring(l,true)
        end;
        if c then 
            if IsControlJustPressed(0,73)then 
                local k=3500;c=false;
                if not(g>k)then g=k 
                end;
                checkfortimeout(k)
            end 
        end;
        if GetIsTaskActive(l,2)then 
            SetCurrentPedWeapon(l,"WEAPON_UNARMED",true)
            HudWeaponWheelIgnoreSelection()
            HudWeaponWheelIgnoreControlInput(true)
        else 
            HudWeaponWheelIgnoreControlInput(false)
        end;
        Wait(0)
    end 
end)

Citizen.CreateThread(function()
    while true do 
        local m=GetPlayerPed(-1)
        if not IsPedInAnyVehicle(m,true)then 
            if GetIsTaskActive(m,56)or IsPedInCover(m,1)and IsControlJustPressed(0,37)then 
                local n=GetSelectedPedWeapon(m)
                if n~="WEAPON_UNARMED"then 
                    if table.find(i,n)then 
                        h=true;
                        loadAnimDict("rcmjosh4")
                        loadAnimDict("reaction@intimidation@cop@unarmed")
                        c=true;
                        SetPedCurrentWeaponVisible(m,0,1,1,1)
                        TaskPlayAnim(m,"reaction@intimidation@cop@unarmed","intro",8.0,2.0,-1,50,2.0,0,0,0)
                        SetPedCurrentWeaponVisible(m,1,1,1,1)
                        Citizen.Wait(250)
                        TaskPlayAnim(m,"rcmjosh4","josh_leadout_cop2",8.0,2.0,-1,48,10,0,0,0)
                        Citizen.Wait(400)
                        ClearPedTasks(m)a=false;
                        if n=="WEAPON_STUNGUN"and GetPedDrawableVariation(m,7)==163 then 
                            SetPedComponentVariation(m,7,162,0,0)
                        elseif n=="WEAPON_GLOCK"and GetPedDrawableVariation(m,7)==132 then 
                            SetPedComponentVariation(m,7,136,0,0)
                        end;
                        if not d then 
                            a=false;
                            b=false;
                            c=false;
                            f=n 
                        end 
                    else 
                        c=true;
                        loadAnimDict("reaction@intimidation@1h")
                        TaskPlayAnim(m,"reaction@intimidation@1h","intro",8.0,2.0,1700,48,10,0,0,0)
                        SetPedCurrentWeaponVisible(m,0,1,1,1)
                        b=true;
                        Citizen.Wait(1300)
                        SetPedCurrentWeaponVisible(m,1,1,1,1)
                        Citizen.Wait(700)
                        ClearPedTasks(m)
                        EnableControlAction(0,25,true)
                        if not d then 
                            a=false;
                            b=false;
                            c=false;
                            f=GetSelectedPedWeapon(m)
                        end 
                    end 
                else if table.find(i,f)then 
                    loadAnimDict("rcmjosh4")
                    loadAnimDict("reaction@intimidation@cop@unarmed")
                    TaskPlayAnim(m,"rcmjosh4","josh_leadout_cop2",8.0,2.0,-1,48,10,0,0,0)
                    Citizen.Wait(500)
                    TaskPlayAnim(m,"reaction@intimidation@cop@unarmed","outro",8.0,2.0,-1,50,2.0,0,0,0)
                    Citizen.Wait(60)
                    ClearPedTasks(m)
                    a=true;
                    if h and GetPedDrawableVariation(m,7)==162 then 
                        SetPedComponentVariation(m,7,163,0,0)
                    elseif h and GetPedDrawableVariation(m,7)==136 then 
                        SetPedComponentVariation(m,7,132,0,0)
                    end 
                else 
                    loadAnimDict("reaction@intimidation@1h")TaskPlayAnim(m,"reaction@intimidation@1h","outro",8.0,2.0,1700,48,10,0,0,0)
                    b=true;
                    SetCurrentPedWeapon(m,GetHashKey(f),true)
                    Citizen.Wait(1300)
                    SetCurrentPedWeapon(m,"WEAPON_UNARMED",true)
                    Citizen.Wait(700)
                    ClearPedTasks(m)
                    a=true;
                    b=false;
                    f=nil 
                end;
                h=false 
            end 
        end 
    end;
    Wait(0)
end 
end)

function loadAnimDict(o)
    while not HasAnimDictLoaded(o)do 
        RequestAnimDict(o)Wait(0)
    end 
end;

function table.find(table,p)
    for q,r in pairs(table)do 
    if r==p 
        then return true 
        end 
    end;
    return false 
end