local a={[1]={name='St Thomas',coords=vector3(359,-607,1),style=RageUI.BadgeStyle.Heart},[2]={name='Legion',coords=vector3(200,-1000,1),style=RageUI.BadgeStyle.Star},[3]={name='Simeons',coords=vector3(-40,-1113,1),style=RageUI.BadgeStyle.Car},[4]={name='Job Centre',coords=vector3(-258,-977,1),style=RageUI.BadgeStyle.Card},[5]={name='Arena',coords=vector3(-250,-2031,1),style=RageUI.BadgeStyle.AQUA},[6]={name='Bennys',coords=vector3(-204,-1307,1),style=RageUI.BadgeStyle.Car},[7]={name='Bank of England',coords=vector3(228,213,1),style=RageUI.BadgeStyle.Cash},[8]={name='Santander',coords=vector3(316,-274,1),style=RageUI.BadgeStyle.Cash},[9]={name='Fleeca',coords=vector3(-2968,483,1),style=RageUI.BadgeStyle.Cash},[10]={name='Ranch',coords=vector3(1307,1104,1),style=RageUI.BadgeStyle.Car},[11]={name='Casino',coords=vector3(922,52,1),style=RageUI.BadgeStyle.Badbeat},[12]={name='Stage',coords=vector3(677,560,1),style=RageUI.BadgeStyle.Mask},[13]={name='Pier',coords=vector3(-1800,-1187,1),style=RageUI.BadgeStyle.BoatPickup},[14]={name='Sandy Air Field',coords=vector3(1771,3297,1),style=RageUI.BadgeStyle.Plane},[15]={name='Trevor\'s airfield',coords=vector3(2105,4795,1),style=RageUI.BadgeStyle.Plane},[16]={name='Vespucci PD',coords=vector3(-1069,-800,1),style=RageUI.BadgeStyle.Alert},[17]={name='Mission Row',coords=vector3(400,-1000,1),style=RageUI.BadgeStyle.Alert},[18]={name='Sandy PD',coords=vector3(1869,3696,1),style=RageUI.BadgeStyle.Alert},[19]={name='Sandy NHS',coords=vector3(1833,3661,1),style=RageUI.BadgeStyle.Heart},[20]={name='Paleto PD',coords=vector3(-477,6027,1),style=RageUI.BadgeStyle.Alert},[21]={name='Paleto NHS',coords=vector3(-256,6346,1),style=RageUI.BadgeStyle.Heart},[22]={name='Knife Store',coords=vector3(19,-1111,1),style=RageUI.BadgeStyle.Armour},[23]={name='Small Arms',coords=vector3(-1490,-199,1),style=RageUI.BadgeStyle.Gun},[24]={name='Large Arms',coords=vector3(-1100,4960,1),style=RageUI.BadgeStyle.Ammo},[25]={name='Rebel',coords=vector3(1474,6359,1),style=RageUI.BadgeStyle.Armour},[26]={name='Mineral Trader',coords=vector3(1220,-2993,1),style=RageUI.BadgeStyle.Cash},[27]={name='Gold Gather',coords=vector3(-609,2113,1),style=RageUI.BadgeStyle.GoldMedal},[28]={name='Gold Process',coords=vector3(2711,1520,1),style=RageUI.BadgeStyle.GoldMedal},[29]={name='Copper Gather',coords=vector3(1918,3289,1),style=RageUI.BadgeStyle.BronzeMedal},[30]={name='Copper Process',coords=vector3(864,2167,1),style=RageUI.BadgeStyle.BronzeMedal},[31]={name='Limestone Gather',coords=vector3(2957,2787,1),style=RageUI.BadgeStyle.Package},[32]={name='Limestone Process',coords=vector3(2682,2800,1),style=RageUI.BadgeStyle.Package},[33]={name='Weed Gather',coords=vector3(2218,5596,1),style=RageUI.BadgeStyle.Weed},[34]={name='Weed Process',coords=vector3(2844,4489,1),style=RageUI.BadgeStyle.Weed},[35]={name='Coke Gather',coords=vector3(1543,1724,1),style=RageUI.BadgeStyle.Coke},[36]={name='Coke Process',coords=vector3(345,3409,1),style=RageUI.BadgeStyle.Coke},[37]={name='Meth Gather',coords=vector3(1551,2151,1),style=RageUI.BadgeStyle.Meth},[38]={name='Meth Process',coords=vector3(1392,3603,1),style=RageUI.BadgeStyle.Meth},[39]={name='Weed Trader',coords=vector3(106,-1937,1),style=RageUI.BadgeStyle.Weed},[40]={name='Coke Trader',coords=vector3(88,-1298,1),style=RageUI.BadgeStyle.Coke},[41]={name='Meth Trader',coords=vector3(-553,5326,1),style=RageUI.BadgeStyle.Meth},[42]={name='Heroin Trader',coords=vector3(3580,3662,1),style=RageUI.BadgeStyle.Heroin}}
local b=module("cfg/garages");
local c={vector3(-337.0,-135.0,39.0),vector3(-1155.0,-2007.0,13.0),vector3(734.0,-1085.0,22.0),vector3(1177.0,2640.0,37.0),vector3(108.0,6624.0,31.0),vector3(538.0,-183.0,54.0),vector3(1774.0,3333.0,41.0),vector3(1143.0,-776.0,57.0),vector3(2508.0,4103.0,38.0),vector3(2006.0,3792.0,32.0),vector3(-1419.0,-450.0,36.0),vector3(268.0,-1810.0,27.0),vector3(-29.0,-1665.0,29.0),vector3(-212.0,-1378.0,31.0),vector3(258.0,2594.0,44.0),vector3(-32.0,-1090.0,26.0),vector3(903.0,3563.0,34.0),vector3(437.0,3568.0,38.0)}
local d={vector3(89.577018737793,2.16031360626221,68.322021484375),vector3(-526.497131347656,-1222.79455566406,18.4549674987793),vector3(-2072.48413085938,-317.190521240234,13.315972328186),vector3(-821.565551757813,-1081.90270996094,11.1324348449707),vector3(1686.74694824219,4815.8828125,42.0085678100586),vector3(-386.899444580078,6045.78466796875,31.5001239776611),vector3(1171.52319335938,2702.44897460938,38.1754684448242),vector3(1968.11157226563,3743.56860351563,32.3437271118164),vector3(2558.85815429688,351.045166015625,108.621520996094),vector3(1153.75634765625,-326.805023193359,69.2050704956055),vector3(-56.9172439575195,-1752.17590332031,29.4210166931152),vector3(-3241.02856445313,997.587158203125,12.5503988265991),vector3(-1827.1884765625,784.907104492188,138.302581787109),vector3(-1091.54748535156,2708.55786132813,18.9437484741211),vector3(112.45637512207,-819.25048828125,31.3392715454102),vector3(-256.173187255859,-716.031921386719,33.5202751159668),vector3(174.227737426758,6637.88623046875,31.5730476379395),vector3(-660.727661132813,-853.970336914063,24.484073638916),vector3(-2153.5690917969,5236.5961914063,18.779041290283),vector3(937.97979736328,-941.22381591797,44.411933898926),vector3(147.65927124023,-1035.607421875,29.343105316162),vector3(146.05894470215,-1035.1301269531,29.34481048584),vector3(-254.36019897461,-692.43688964844,33.609630584717),vector3(-258.83990478516,-723.43603515625,33.473651885986),vector3(1845.8720703125,2584.2048339844,45.672046661377),vector3(1095.6285400391,245.37515258789,-50.440719604492),vector3(1095.3305664063,243.84825134277,-50.440719604492),vector3(-1110.9267578125,-836.36138916016,19.001638412476),vector3(-1074.1479492188,-827.66925048828,19.036712646484),vector3(-1074.2746582031,-827.43896484375,27.036390304565),vector3(-577.13519287109,-194.84748840332,38.219650268555)}
local e={vector3(-350.655,-136.55,38.295),vector3(726.157,-1088.768,22.169),vector3(-1150.26,-1995.642,12.466),vector3(1174.701,2643.764,37.048),vector3(112.738,6624.644,31.072),vector3(-205.626,-1314.99,30.247),vector3(-74.88053894043,-1819.0004882813,26.958620071411),vector3(-1071.5559082031,-852.48406982422,4.8729567527771)}
local f={vector3(72.2545394897461,-1399.10229492188,29.3761386871338),vector3(449.81854248047,-993.30865478516,30.689584732056),vector3(-703.77685546875,-152.258544921875,37.4151458740234),vector3(-167.863754272461,-298.969482421875,39.7332878112793),vector3(428.694885253906,-800.1064453125,29.4911422729492),vector3(-829.413269042969,-1073.71032714844,11.3281078338623),vector3(-1193.42956542969,-772.262329101563,17.3244285583496),vector3(-1447.7978515625,-242.461242675781,49.8207931518555),vector3(11.6323690414429,6514.224609375,31.8778476715088),vector3(1696.29187011719,4829.3125,42.0631141662598),vector3(123.64656829834,-219.440338134766,54.5578384399414),vector3(618.093444824219,2759.62939453125,42.0881042480469),vector3(1190.55017089844,2713.44189453125,38.2226257324219),vector3(-3172.49682617188,1048.13330078125,20.8632030487061),vector3(-1108.44177246094,2708.92358398438,19.1078643798828),vector3(127.57326507568,-1038.4321289063,29.555480957031),vector3(-2152.7907714844,5231.9516601563,18.788805007935),vector3(210.32136535645,-1656.7593994141,29.803112030029),vector3(-455.61834716797,6012.7348632813,31.7164478302),vector3(629.93414306641,9.804479598999,44.394229888916),vector3(1439.3804931641,6331.80078125,23.954704284668),vector3(-1098.4307861328,-831.42083740234,14.282784461975)}
local g={["roths"]=vector3(-483,-347,1),["lifeinvader"]=vector3(-1045,-230,1),["refinery"]=vector3(1720,-1650,1),["lsia carpark"]=vector3(-819,-2011,1),["gov facility"]=vector3(2505,-384,1),["wind farm"]=vector3(2273,1700,1),["hippy camp"]=vector3(2347,2565,1),["you tool"]=vector3(2758,3468,1),["alien art"]=vector3(2469,3769,1),["plane grave"]=vector3(2413,3106,1),["skate park"]=vector3(762,-816,1),["scrapery"]=vector3(-399,-1722,1)}
local h={"Front Left","Front Right","Back Left","Back Right","Hood","Trunk","Second Trunk","Windows","Close All","Open All"}
local i={'Safe','Safe and Legal','Relaxed','Normal','Rushed','Offroad','Avoid Motorways','Avoid Offroad','Samurott Gypo Driving'}
local j={43,427,60,786603,1074528293,262716,537133628,524860,1076}
local k={vehicle=nil,adSpeed=1,autoDrive=false,limiterSpeed=1,limiter=false,predictedMax=nil,door=1,limitingVehicle=nil,currentLimit=nil,cruise=false,adMode=1}
local l=false
local m=false
local n=false
local o=false
local p=false
local q=0
local r=true
local s=false
local t=1
Citizen.CreateThread(function()
    while true do 
        if m and getPlayerVehicle()~=k.limitingVehicle then 
            m=false
            SetVehicleMaxSpeed(getPlayerVehicle(),k.predictedMax)
            predictedMax=nil
            notify("~d~Vehicle Changed, stopping limiter")
        end
        Wait(500)
    end 
end)
function convert(speed)
    return speed*10*0.44704-0.5 
end
function autoDrive()
    local u=true
    Citizen.CreateThread(function()
        while k.autoDrive and u do 
            speed=k.adSpeed
            mode=j[k.adMode]
            local v=GetVehiclePedIsIn(getPlayerPed(),false)
            if v~=0 then 
                if IsWaypointActive()then 
                    if not l or speed~=q or mode~=flag then 
                        ClearPedTasks(getPlayerPed())
                        waypoint=GetBlipInfoIdCoord(GetFirstBlipInfoId(8))
                        l=true
                        local q=speed
                        local flag=mode
                        TaskVehicleDriveToCoord(getPlayerPed(),v,waypoint.x,waypoint.y,waypoint.z,convert(speed),1,GetHashKey(GetEntityModel(v)),flag,5,true)
                    end 
                else 
                    notify("~d~You do not have a waypoint set")
                    k.autoDrive=false 
                end 
            else 
                notify("~d~You are not in a vehicle!")
                k.autoDrive=false 
            end
            local w=GetIsVehicleEngineRunning(v)
            local inWater=IsEntityInWater(v)and not IsPedInAnyBoat(getPlayerPed())
            u=w and not inWater
            if not w then 
                notify('~d~AutoDrive automatically disabled because the engine is inactive')
                k.autoDrive=false 
            elseif inWater then 
                notify('~d~AutoDrive automatically disabled because you are in water')
                k.autoDrive=false 
            end
            Wait(100)
        end
        if not k.autoDrive then 
            ClearPedTasks(getPlayerPed())
            l=false
            o=false 
        end 
    end)
end
function cruise()
    accelerating=false
    Citizen.CreateThread(function()
        cruiseVehicle=GetVehiclePedIsUsing(getPlayerPed())
        local x=GetEntitySpeed(cruiseVehicle)
        local u=true
        while k.cruise and IsPedInAnyVehicle(getPlayerPed(),false)and u do 
            while not accelerating and k.cruise and u do 
                if IsControlPressed(1,71)or IsControlPressed(1,72)or IsControlPressed(1,76)or GetVehicleCurrentGear(cruiseVehicle)==0 then 
                    accelerating=true
                    x=acceleratingToNewSpeed(cruiseVehicle)
                else 
                    SetVehicleForwardSpeed(cruiseVehicle,x)
                    SetVehicleOnGroundProperly(cruiseVehicle)
                end
                engineStatus=GetIsVehicleEngineRunning(cruiseVehicle)
                collision=HasEntityCollidedWithAnything(cruiseVehicle)
                inWater=IsEntityInWater(cruiseVehicle)and not IsPedInAnyBoat(getPlayerPed())
                u=engineStatus and not collision and not inWater
                Wait(10)
            end
            Wait(600)
        end
        if collision then 
            notify('~d~Cruise control automatically disabled because a collision was detected')
        elseif not engineStatus then 
            notify('~d~Cruise control automatically disabled because the engine was turned off')
        elseif inWater then 
            notify('~d~Cruise control automatically disabled because you are in water')
        end
        n=false
        k.cruise=false 
    end)
end
function acceleratingToNewSpeed(cruiseVehicle)
    while IsControlPressed(1,71)or IsControlPressed(1,72)or IsControlPressed(1,76)or GetVehicleCurrentGear(cruiseVehicle)==0 and IsPedInAnyVehicle(getPlayerPed(),false)do 
        Wait(100)
    end
    if not IsPedInAnyVehicle(getPlayerPed(),false)then 
        accelerating=false
        k.cruise=false 
    end
    accelerating=false
    local cruiseVehicle=GetVehiclePedIsUsing(getPlayerPed())
    return GetEntitySpeed(cruiseVehicle)
end
function limiter()
    Citizen.CreateThread(function()
        while k.limiter do 
            local y=getPlayerVehicle()
            local speed=k.limiterSpeed
            if y~=0 then 
                k.limitingVehicle=y
                m=true
                k.predictedMax=GetVehicleEstimatedMaxSpeed(y)
                if convert(speed)>k.predictedMax then 
                    SetVehicleMaxSpeed(y,k.predictedMax)
                    k.currentLimit=k.predictedMax 
                else 
                    SetVehicleMaxSpeed(y,convert(speed))
                    k.currentLimit=convert(speed)
                end 
            else 
                notify("~d~You are not in a vehicle!")
                k.limiter=false 
            end
            Wait(100)
        end
        SetVehicleMaxSpeed(k.limitingVehicle,k.predictedMax)
        p=false
        m=false 
    end)
end
function waypointNearest(z)
    local A=getPlayerPed()
    local B=GetEntityCoords(A)
    if z=="atm"then 
        array=d 
    elseif z=="mechanic"then 
        array=c 
    elseif z=="lsc"then 
        array=e 
    elseif z=="clothes"then 
        array=f 
    end
    local E=GetEntityCoords(getPlayerPed())
    local F=1000000
    for C=1,#array,1 do 
        local G=#(E-array[C])
        if G<F then 
            t=C 
        end 
    end
    SetNewWaypoint(array[t].x,array[t].y)
    Citizen.Wait(100)
end
RMenu.Add('vehicle_menu','main',RageUI.CreateMenu("Vehicle","",0,100))
RMenu:Get('vehicle_menu','main'):SetSubtitle("~d~VEHICLE OPTIONS")
RMenu.Add('vehicle_menu','locations',RageUI.CreateSubMenu(RMenu:Get('vehicle_menu','main'),"GPS","~d~LOCATIONS",nil,nil))
RageUI.CreateWhile1(1.0,RMenu:Get('vehicle_menu','main'),nil,function()
    RageUI.IsVisible(RMenu:Get('vehicle_menu','main'),true,true,true,function()
        RageUI.ButtonWithStyle("Quick GPS","Easily Navigate to any POI!",{RightLabel="→→→"},true,function(H,I,J)
            if J then 
            end 
        end,RMenu:Get('vehicle_menu','locations'))
        RageUI.ButtonWithStyle("Toggle Door Lock","Select to toggle between doors locked and unlocked",{RightLabel=""},true,function(H,I,J)
            if J then 
                local K=getPlayerVehicle()
                if K~=0 then 
                    if GetVehicleDoorLockStatus(K)~=2 then 
                        SetVehicleDoorsLocked(K,2)
                        notify("~w~Doors are now ~d~Locked")
                    else 
                        SetVehicleDoorsLocked(K,0)
                        notify("~w~Doors are now ~g~Unlocked")
                    end 
                end 
            end 
        end)
        RageUI.List("Toggle Door",h,k.door,"Select the door you want to toggle open/closed.",{},true,function(H,I,J,L)
            if J then 
                local K=getPlayerVehicle()
                if K~=0 then 
                    local M=L-1
                    if L==10 then
                        for i = 0, 10 do
                            SetVehicleDoorOpen(K,i,false,false)
                            notify("~d~Opened ~w~all doors.")
                        end
                    elseif L==9 then 
                        SetVehicleDoorsShut(K,false)
                        notify("~d~Closed ~w~all doors.")
                    elseif L==8 then 
                        if r then 
                            r=false
                            RollDownWindow(K,0)
                            RollDownWindow(K,1)
                            notify("Rolled windows ~d~Down")
                        else 
                            r=true
                            RollUpWindow(K,0)
                            RollUpWindow(K,1)
                            notify("Rolled windows ~g~Up")
                        end 
                    elseif IsVehicleDoorDamaged(K,M)then 
                        notify("~d~Cannot shut this door when the door is damaged")
                    elseif GetVehicleDoorAngleRatio(K,M)==0 then 
                        SetVehicleDoorOpen(K,M,false,false)
                        notify(string.format("The ~d~%s ~w~door is now ~g~Open",h[L]))
                    else 
                        SetVehicleDoorShut(K,M,false)
                        notify(string.format("The ~d~%s ~w~door is now ~d~Closed",h[L]))
                    end 
                end 
            end
            k.door=L 
        end,function()
        end,nil)
        RageUI.Checkbox("Activate Speed Limiter","Select to turn on Speed Limiter",k.limiter,{Style=RageUI.CheckboxStyle.Tick},function(H,J,I,N)
            if J then 
                if k.limiter then 
                    RageUI.Text({message=string.format("~w~Speed Limiter is currently ~g~~h~Active")})
                    k.autoDrive=false
                    k.cruise=false
                    if not p then 
                        local speed=GetEntitySpeed(getPlayerVehicle())
                        if convert(speed)<10.0 then 
                            p=true
                            limiter()
                        else 
                            p=false
                            notify("~d~Alert~w~: Please slow down to enable the speed limiter.")
                        end 
                    end 
                else 
                    RageUI.Text({message=string.format("~w~Speed Limiter is currently ~d~~h~Inactive")})
                end 
            end
            k.limiter=N 
        end)
        RageUI.SliderProgress("Speed Limiter",k.limiterSpeed,25,"Select the speed you wish to limit your vehicle to.",{ProgressBackgroundColor={R=0,G=0,B=0,A=255},ProgressColor={R=0,G=117,B=194,A=255}},true,function(H,J,I,L)
            if J then 
                if L~=k.limiterSpeed then 
                    k.limiterSpeed=L
                    RageUI.Text({message=string.format("Setting Limiter Speed to: ~d~%s ~w~mph",k.limiterSpeed*10)})
                end 
            end 
        end)
        RageUI.ButtonWithStyle("Toggle Engine","Select to toggle current vehicle engine on/off",{RightBadge=RageUI.BadgeStyle.Key},true,function(H,I,J)
            if J then 
                local K=getPlayerVehicle()
                if GetIsVehicleEngineRunning(K)then 
                    if K~=0 then 
                        SetVehicleEngineOn(K,false,true,true)
                        notify("You've turned the ignition into the ~d~off ~w~position.")
                    end 
                else 
                    if K then 
                        SetVehicleEngineOn(K,true,false,true)
                        notify("You've turned the ignition to the ~g~on ~w~position.")
                    end 
                end 
            end 
        end)
    end,function()
    end)
    RageUI.IsVisible(RMenu:Get('vehicle_menu','locations'),true,true,true,function()
        RageUI.ButtonWithStyle("Nearest ATM","Waypoint the nearest ATM",{RightLabel=""},true,function(H,I,J)
            if J then 
                waypointNearest("atm")
            end 
        end)
        RageUI.ButtonWithStyle("Nearest Mechanic","Waypoint the nearest Mechanic",{RightLabel=""},true,function(H,I,J)
            if J then 
                waypointNearest("mechanic")
            end 
        end)
        RageUI.ButtonWithStyle("Nearest Modshop","Waypoint the nearest Vehicle Modification Shop",{RightLabel=""},true,function(H,I,J)
            if J then 
                waypointNearest("lsc")
            end 
        end)
        RageUI.ButtonWithStyle("Nearest Clothing Store","Waypoint the nearest Clothing Store",{RightLabel=""},true,function(H,I,J)
            if J then 
                waypointNearest("clothes")
            end 
        end)
        for O,P in ipairs(a)do 
            RageUI.ButtonWithStyle(tostring(P.name),string.format("Waypoint to %s",P.name),{RightLabel=""},true,function(H,I,J)
                if J then 
                    SetNewWaypoint(P.coords.x,P.coords.y)
                end 
            end)
        end
        RageUI.ButtonWithStyle("Custom Location","Input a text location",{RightLabel=""},true,function(H,I,J)
            if J then 
                AddTextEntry("FMMC_MPM_NA","Enter location code:")
                DisplayOnscreenKeyboard(6,"FMMC_MPM_NA","","","","","",30)
                local s=true
                while s do 
                    HideHudAndRadarThisFrame()
                    if UpdateOnscreenKeyboard()==3 then 
                        s=false 
                    elseif UpdateOnscreenKeyboard()==1 then 
                        local Q=GetOnscreenKeyboardResult()
                        if string.len(Q)>0 then 
                            argString=Q
                            s=false
                            if argString==""or argString==" "then 
                                notify("~d~Input something")
                            end
                            argString=argString:lower()
                            if g[argString]then 
                                local R=g[argString]
                                SetNewWaypoint(R.x,R.y)
                                notify("Set Waypoint to ~g~"..argString)
                            else 
                                notify("~d~Place was not found.")
                            end 
                        else 
                            AddTextEntry("FMMC_MPM_NA","Enter location code:")
                            DisplayOnscreenKeyboard(false,"FMMC_MPM_NA","","","","","",30)
                        end 
                    elseif UpdateOnscreenKeyboard()==2 then 
                        s=false 
                    end
                    Wait(0)
                end 
            end 
        end)
    end,function()
    end)
end)
local function S()
    if IsControlJustPressed(1,244)then 
        if IsPedInAnyVehicle(getPlayerPed(),false)or RageUI.Visible(RMenu:Get("vehicle_menu","main"))then 
            RageUI.CloseAll()
            RageUI.Visible(RMenu:Get('vehicle_menu','main'),not RageUI.Visible(RMenu:Get("vehicle_menu","main")))
        else 
            notify("~d~You are not in a vehicle!")
        end 
    end 
end
createThreadOnTick(S)