local a={5,10,20,30,40,50,75,100,150,200,250}
local b={10,20,30,40,50,75,100,150,200}
local c={
    weapons={melee=false,throwable=false,pistol=false,shotgun=false,mg=false,smg=false,rifle=false,sniper=false,heavy=false},
    vehicles={speed=a[#a],disableTrolling=true,delete=false,car=false,helicopter=false,plane=false,boat=false,bicycle=false},
    disableDamage=false,blipGloballyVisible=true,radius=b[1]
}
local d={}
local e=false
local function f()
    local g=table.copy(c)
    g.position=tARMA.getPlayerCoords()
    g.radius=g.radius+0.0
    g.vehicles.speed=g.vehicles.speed+0.0
    TriggerServerEvent("ARMA:createRPZone",g)
end
function table.find(table, val)
    for k,v in pairs(table) do
        if v == val then return k end
    end
    return false
end
local function h()
    local i=nil
    local j=100.0
    local k=tARMA.getPlayerCoords()
    for l,g in pairs(d)do 
        local m=#(g.position-k)
        if m<j then 
            i=g.uuid
            j=m 
        end 
    end
    if i then 
        TriggerServerEvent("ARMA:removeRPZone",i)
    end 
end
local inRPZone = false
RMenu.Add("rpzones","mainmenu",RageUI.CreateMenu("","~b~Main Menu",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight(),"banners","admin"))
RMenu.Add("rpzones","weapons",RageUI.CreateSubMenu(RMenu:Get("rpzones","mainmenu"),"","~b~Weapons",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight(),"banners","admin"))
RMenu.Add("rpzones","vehicles",RageUI.CreateSubMenu(RMenu:Get("rpzones","mainmenu"),"","~b~Vehicles",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight(),"banners","admin"))

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('rpzones', 'mainmenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.ButtonWithStyle("Weapons","",{RightLabel="→→→"},true,function()
            end,RMenu:Get("rpzones","weapons"))
            RageUI.ButtonWithStyle("Vehicles","",{RightLabel="→→→"},true,function()
            end,RMenu:Get("rpzones","vehicles"))
            RageUI.Checkbox("Disable Damage",nil,c.disableDamage,{},function(l,l,l,n)
                c.disableDamage=n 
            end)
            RageUI.Checkbox("Display Zone Globally",nil,c.blipGloballyVisible,{},function(l,l,l,n)
                c.blipGloballyVisible=n 
            end)
            RageUI.List("Radius (m)",b,table.find(b,c.radius),nil,{},true,function(l,l,o,p)
                c.radius=b[p]
            end,function()
            end)
            RageUI.ButtonWithStyle("~g~Create Zone","",{RightLabel="→→→"},true,function(l,l,o)
                if o then 
                    f()
                end 
            end)
            RageUI.ButtonWithStyle("~r~Delete Closest Zone","",{RightLabel="→→→"},true,function(l,l,o)
                if o then 
                    h()
                end 
            end)
        end)
    end
    if RageUI.Visible(RMenu:Get('rpzones', 'weapons')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.Checkbox("Enable Melee",nil,c.weapons.melee,{},function(l,l,l,n)
                c.weapons.melee=n 
            end)
            RageUI.Checkbox("Enable Throwable",nil,c.weapons.throwable,{},function(l,l,l,n)
                c.weapons.throwable=n 
            end)
            RageUI.Checkbox("Enable Pistol",nil,c.weapons.pistol,{},function(l,l,l,n)
                c.weapons.pistol=n 
            end)
            RageUI.Checkbox("Enable Shotgun",nil,c.weapons.shotgun,{},function(l,l,l,n)
                c.weapons.shotgun=n 
            end)
            RageUI.Checkbox("Enable LMG",nil,c.weapons.mg,{},function(l,l,l,n)
                c.weapons.mg=n 
            end)
            RageUI.Checkbox("Enable SMG",nil,c.weapons.smg,{},function(l,l,l,n)
                c.weapons.smg=n 
            end)
            RageUI.Checkbox("Enable Rifle",nil,c.weapons.rifle,{},function(l,l,l,n)
                c.weapons.rifle=n 
            end)
            RageUI.Checkbox("Enable Sniper",nil,c.weapons.sniper,{},function(l,l,l,n)
                c.weapons.sniper=n 
            end)
            RageUI.Checkbox("Enable Heavy",nil,c.weapons.heavy,{},function(l,l,l,n)
                c.weapons.heavy=n 
            end)
        end)
    end
    if RageUI.Visible(RMenu:Get('rpzones', 'vehicles')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.List("Speed (mph)",a,table.find(a,c.vehicles.speed),nil,{},true,function(l,l,o,p)
                c.vehicles.speed=a[p]
            end,function()
            end)
            RageUI.Checkbox("Disable Trolling",nil,c.vehicles.disableTrolling,{},function(l,l,l,n)
                c.vehicles.disableTrolling=n 
            end)
            RageUI.Checkbox("Use Deletion",nil,c.vehicles.delete,{},function(l,l,l,n)
                c.vehicles.delete=n 
            end)
            local q=c.vehicles.delete and"Delete"or"Disable"
            RageUI.Checkbox(string.format("%s Car",q),nil,c.vehicles.car,{},function(l,l,l,n)
                c.vehicles.car=n 
            end)
            RageUI.Checkbox(string.format("%s Helicopter",q),nil,c.vehicles.helicopter,{},function(l,l,l,n)
                c.vehicles.helicopter=n 
            end)
            RageUI.Checkbox(string.format("%s Plane",q),nil,c.vehicles.plane,{},function(l,l,l,n)
                c.vehicles.plane=n 
            end)
            RageUI.Checkbox(string.format("%s Boat",q),nil,c.vehicles.boat,{},function(l,l,l,n)
                c.vehicles.boat=n 
            end)
            RageUI.Checkbox(string.format("%s Bicycle",q),nil,c.vehicles.bicycle,{},function(l,l,l,n)
                c.vehicles.bicycle=n 
            end)
        end)
    end
end)

RegisterNetEvent("ARMA:createRPZone",function(g)
    g.blip=AddBlipForRadius(g.position.x,g.position.y,g.position.z,g.radius)
    SetBlipColour(g.blip,27)
    SetBlipAlpha(g.blip,180)
    SetBlipDisplay(g.blip,g.blipGloballyVisible and 8 or 5)
    if g.vehicles.speed then 
        g.speedHandle=AddRoadNodeSpeedZone(g.position.x,g.position.y,g.position.z,g.radius,g.vehicles.speed*0.44704,false)
    end
    table.add(d,g)
end)
RegisterNetEvent("ARMA:removeRPZone",function(r)
    for s,g in pairs(d)do 
        if g.uuid==r then 
            RemoveBlip(g.blip)
            if g.vehicles.speed then 
                RemoveRoadNodeSpeedZone(g.speedHandle)
            end
            table.remove(d,s)
            break 
        end 
    end 
end)
local function t(g,u)
    local v=tARMA.getPlayerPed()
    local w=GetWeapontypeGroup(u)
    if not g.weapons.melee and w==GetHashKey('GROUP_MELEE')then 
        tARMA.setWeapon(v,'WEAPON_UNARMED')
    elseif not g.weapons.throwable and w==GetHashKey('GROUP_THROWN')then 
        tARMA.setWeapon(v,'WEAPON_UNARMED')
    elseif not g.weapons.pistol and w==GetHashKey('GROUP_PISTOL')then 
        tARMA.setWeapon(v,'WEAPON_UNARMED')
    elseif not g.weapons.shotgun and w==GetHashKey('GROUP_SHOTGUN')then 
        tARMA.setWeapon(v,'WEAPON_UNARMED')
    elseif not g.weapons.mg and w==GetHashKey('GROUP_MG')then 
        tARMA.setWeapon(v,'WEAPON_UNARMED')
    elseif not g.weapons.smg and w==GetHashKey('GROUP_SMG')then 
        tARMA.setWeapon(v,'WEAPON_UNARMED')
    elseif not g.weapons.rifle and w==GetHashKey('GROUP_RIFLE')then 
        tARMA.setWeapon(v,'WEAPON_UNARMED')
    elseif not g.weapons.sniper and w==GetHashKey('GROUP_SNIPER')then 
        tARMA.setWeapon(v,'WEAPON_UNARMED')
    elseif not g.weapons.heavy and w==GetHashKey('GROUP_HEAVY')then 
        tARMA.setWeapon(v,'WEAPON_UNARMED')
    end 
end
local function x(y)
    DeleteEntity(y)
end
local function z(y)
    DisableControlAction(0,32,true)
    DisableControlAction(0,33,true)
    DisableControlAction(0,34,true)
    DisableControlAction(0,35,true)
    DisableControlAction(0,71,true)
    DisableControlAction(0,72,true)
    SetVehicleEngineOn(y,false,true,false)
end

local function A(g,y)
    if g.vehicles.disableTrolling then 
        DisableControlAction(0,86,true)
        DisableControlAction(0,101,true)
        DisableControlAction(0,102,true)
        DisableControlAction(0,103,true)
        DisableControlAction(0,350,true)
        DisableControlAction(0,351,true)
        DisableControlAction(0,352,true)
        DisableControlAction(0,353,true)
        if IsVehicleParachuteActive(y)then 
            SetVehicleForwardSpeed(y,0.0)
        end
        SetCargobobHookCanAttach(y,false)
        SetVehicleRocketBoostPercentage(y,0.0)
    end
    local B=g.vehicles.delete and x or z
    local C=GetEntityModel(y)
    if g.vehicles.helicopter and IsThisModelAHeli(C)then 
        B(y)
    elseif g.vehicles.plane and IsThisModelAPlane(C)then 
        B(y)
    elseif g.vehicles.boat and IsThisModelABoat(C)then 
        B(y)
    elseif g.vehicles.bicycle and IsThisModelABicycle(C)then 
        B(y)
    elseif g.vehicles.car and(IsThisModelACar(C)or IsThisModelABike(C))then 
        B(y)
    end 
end
local function D(E)
    local v=PlayerPedId()
    local F=PlayerId()
    SetEntityInvincible(v,E)
    SetPlayerInvincible(F,E)
    SetEntityProofs(v,E,E,E,E,E,E,E,E)
    SetEntityCanBeDamaged(v,not E)
    SetPedCanRagdoll(v,not E)
    SetPedCanRagdollFromPlayerImpact(v,not E)
    ClearPedBloodDamage(v)
    ResetPedVisibleDamage(v)
    ClearPedLastWeaponDamage(v)
    inRPZone = E
end
local function G(g)
    local l,u=GetCurrentPedWeapon(tARMA.getPlayerPed())
    if u~=0 then 
        t(g,u)
    end
    local y,H=tARMA.getPlayerVehicle()
    if y~=0 and H then 
        A(g,y)
    end
    if g.disableDamage then 
        D(true)
    end 
end

local function I()
    local J=false
    local K=tARMA.getPlayerCoords()
    for l,g in ipairs(d)do 
        if#(K-g.position)<g.radius then 
            J=true
            G(g)
            if not e then 
                TriggerEvent("ARMA:showNotification",
                {
                    text="You have entered an RP zone",
                    height="200px",
                    width="auto",
                    colour="#FFF",
                    background="#32CD32",
                    pos="bottom-right",
                    icon="success"
                },
                5000)            
                end
            e=true 
        end 
    end
    if e and not J then 
        TriggerEvent("ARMA:showNotification",
        {
            text="You have left the RP zone",
            height="60px",
            width="auto",
            colour="#FFF",
            background="#ff0000",
            pos="bottom-right",
            icon="bad"
        },
        5000)
        D(false)
        e=false 
    end 
end
tARMA.createThreadOnTick(I)

function tARMA.GetRPZoneInfo()
    local K=tARMA.getPlayerCoords()
    for l,g in ipairs(d)do 
        if#(K-g.position)<g.radius then
            return g
        end
    end
    return nil
end

function tARMA.getInRPZone()
   return inRPZone
end