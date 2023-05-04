local a=false
function notify(JJJ)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(JJJ)
    DrawNotification(true,false)
end

function tARMA.GetClosestPlayer(ao)
    local ap=-1
    local aq=-1
    local ar=PlayerPedId()
    local as=GetEntityCoords(ar,0)
    for o,c in ipairs(GetActivePlayers())do 
        local at=GetPlayerPed(c)
        if at~=ar then 
            local au=GetEntityCoords(GetPlayerPed(c),0)
            local av=#(au-as)
            if ap==-1 or ap>av then 
                aq=c
                ap=av 
            end 
        end 
    end
    if ap<=ao then 
        return aq 
    else 
        return nil 
    end 
end

local mmm=true
function canAnim()
    return mmm
end
function setCanAnim(nnn)
    mmm=nnn
end

function loadModel(restest)
    local stest
    if type(restest)~="string"then 
        stest=restest
    else 
        stest=GetHashKey(restest)
    end
    if IsModelInCdimage(stest)then 
        if not HasModelLoaded(stest)then 
            RequestModel(stest)
            while not HasModelLoaded(stest)do 
                Wait(0)
            end 
        end
        return stest
    else 
        return nil 
    end 
end

function loadAnimDict(testt)
    if not HasAnimDictLoaded(testt)then 
        RequestAnimDict(testt)
        while not HasAnimDictLoaded(testt)do 
            Wait(0)
        end 
    end
    return testt 
end

local function c()
    if GetEntityHealth(PlayerPedId())<=102 then 
        notify("~r~You try to move but you remember you're dead")
        return true 
    elseif IsEntityDead(PlayerPedId())then 
        notify("~r~You try to move but you remember you're dead")
        return true 
    else 
        return false 
    end 
end
local function d()
    local e=tARMA.getPlayerPed()
	--if not IsPedInAnyVehicle(e, false) and (not IsPedSwimming(e)) and (not IsPedShooting(e)) and (not IsPedClimbing(e)) and (not IsPedCuffed(e)) and (not IsPedDiving(e)) and (not IsPedFalling(e)) and (not IsPedJumping(e)) and (not IsPedJumpingOutOfVehicle(e)) and IsPedOnFoot(e) and (not IsPedRunning(e)) and (not IsPedUsingAnyScenario(e)) and (not IsPedInParachuteFreeFall(e)) and (not isPlayerNearPrison()) then
	if not IsPedInAnyVehicle(e, false) and (not IsPedSwimming(e)) and (not IsPedShooting(e)) and (not IsPedClimbing(e)) and (not IsPedCuffed(e)) and (not IsPedDiving(e)) and (not IsPedFalling(e)) and (not IsPedJumping(e)) and (not IsPedJumpingOutOfVehicle(e)) and IsPedOnFoot(e) and (not IsPedRunning(e)) and (not IsPedUsingAnyScenario(e)) and (not IsPedInParachuteFreeFall(e)) then
        return true 
    else 
        return false 
    end 
end
RegisterCommand("bjgive",function(f,g)
    local i="oddjobs@towing"
    local k=PlayerPedId()
    if DoesEntityExist(k) and canAnim() and not IsEntityDead(k) and d() then 
        loadAnimDict(i)
        if IsEntityPlayingAnim(k,i,"f_blow_job_loop",3)then 
            TaskPlayAnim(k,i,"exit",8.0,1.0,-1,49,0,0,0,0)
            Wait(100)
            ClearPedSecondaryTask(PlayerPedId())
        else 
            TaskPlayAnim(k,i,"f_blow_job_loop",8.0,1.0,-1,01,0,0,0,0)
            Wait(5000)
            TaskPlayAnim(k,i,"exit",8.0,1.0,-1,49,0,0,0,0)
            Wait(100)
            ClearPedSecondaryTask(PlayerPedId())
        end 
    end 
end,false)


RegisterCommand("bjget",function(f,g)
    local i="oddjobs@towing"
    local k=PlayerPedId()
    if DoesEntityExist(k) and canAnim() and not IsEntityDead(k) and d()then 
        loadAnimDict(i)
        if IsEntityPlayingAnim(k,i,"m_blow_job_loop",3)then 
            TaskPlayAnim(k,i,"exit",8.0,1.0,-1,49,0,0,0,0)
            Wait(100)
            ClearPedSecondaryTask(PlayerPedId())
        else 
            TaskPlayAnim(k,i,"m_blow_job_loop",8.0,1.0,-1,01,0,0,0,0)
            Wait(5000)
            TaskPlayAnim(k,i,"exit",8.0,1.0,-1,49,0,0,0,0)
            Wait(100)
            ClearPedSecondaryTask(PlayerPedId())
        end 
    end 
end,false)
RegisterCommand("sexgive",function(f,g)
    local i="mini@prostitutes@sexlow_veh"
    local k=PlayerPedId()
    if DoesEntityExist(k) and canAnim() and not IsEntityDead(k) and d() then 
        loadAnimDict(i)
        if IsEntityPlayingAnim(k,i,"low_car_sex_loop_female",3)then 
            TaskPlayAnim(k,i,"exit",8.0,1.0,-1,49,0,0,0,0)Wait(100)ClearPedSecondaryTask(PlayerPedId())
        else 
            TaskPlayAnim(k,i,"low_car_sex_loop_female",8.0,1.0,-1,01,0,0,0,0)
            Wait(5000)
            TaskPlayAnim(k,i,"exit",8.0,1.0,-1,49,0,0,0,0)
            Wait(100)
            ClearPedSecondaryTask(PlayerPedId())
        end 
    end 
end,false)

RegisterCommand("sexget",function(f,g)
    local i="mini@prostitutes@sexlow_veh"
    local k=PlayerPedId()
    if DoesEntityExist(k)and canAnim()and not IsEntityDead(k)and d()then 
        loadAnimDict(i)
        if IsEntityPlayingAnim(k,i,"low_car_sex_loop_player",3)then 
            TaskPlayAnim(k,i,"exit",8.0,1.0,-1,49,0,0,0,0)
            Wait(100)
            ClearPedSecondaryTask(PlayerPedId())
        else 
            TaskPlayAnim(k,i,"low_car_sex_loop_player",8.0,1.0,-1,01,0,0,0,0)
            Wait(5000)
            TaskPlayAnim(k,i,"exit",8.0,1.0,-1,49,0,0,0,0)
            Wait(100)
            ClearPedSecondaryTask(PlayerPedId())
        end 
    end 
end,false)
local l={}
local function m()
    for n,o in pairs(l)do 
        DeleteObject(o)
    end 
end
local p=false
RegisterCommand("notes",function(f,g)
    local i="missheistdockssetup1clipboard@base"
    local e=PlayerPedId()
    loadAnimDict(i)
    loadModel('prop_notepad_01')
    loadModel('prop_pencil_01')
    if DoesEntityExist(e)and canAnim()and not IsEntityDead(e)and d()then 
        m()
        if IsEntityPlayingAnim(e,i,"base",3)then 
            TaskPlayAnim(e,i,"exit",8.0,1.0,-1,49,0,0,0,0)
            Wait(100)
            ClearPedSecondaryTask(PlayerPedId())
        else 
            local q=GetEntityCoords(e)
            local prop=CreateObject('prop_notepad_01',q.x,q.y,q.z+0.2,true,true,true)
            table.insert(l,prop)
            local secondaryprop=CreateObject('prop_pencil_01',q.x,q.y,q.z+0.2,true,true,true)
            table.insert(l,secondaryprop)
            AttachEntityToEntity(prop,e,GetPedBoneIndex(e,18905),0.1,0.02,0.05,10.0,0.0,0.0,true,true,false,true,1,true)
            AttachEntityToEntity(secondaryprop,e,GetPedBoneIndex(e,58866),0.12,0.0,0.001,-150.0,0.0,0.0,true,true,false,true,1,true)
            TaskPlayAnim(e,i,"base",8.0,1.0,-1,49,0,0,0,0)
            Wait(100)
            while IsEntityPlayingAnim(e,i,"base",3)do 
                Wait(0)
            end
            print("END")
            m()
        end 
    end 
end,false)
RegisterCommand("facepalm", function(c, d)
	local e = "anim@mp_player_intupperface_palm"
	local f = tARMA.getPlayerPed()
	if DoesEntityExist(f) and (not IsEntityDead(f)) then
		loadAnimDict(e)
		if IsEntityPlayingAnim(f, e, "idle_a", 3) then
			TaskPlayAnim(f, e, "exit", 0, 0, -1, 49, 0, 0, 0, 0)
			Wait(100)
			ClearPedSecondaryTask(tARMA.getPlayerPed())
		else
			TaskPlayAnim(f, e, "idle_a", 0, 0, -1, 49, 0, 0, 0, 0)
			Wait(5000)
			TaskPlayAnim(f, e, "exit", 0, 0, -1, 49, 0, 0, 0, 0)
			Wait(100)
			ClearPedSecondaryTask(tARMA.getPlayerPed())
		end
	end
end, false)
RegisterCommand("umbrella",function(f,g)
    local i="amb@world_human_drinking@coffee@male@base"
    local k=PlayerPedId()
    local prop_name=prop_name or"p_amb_brolly_01"
    if DoesEntityExist(k)and canAnim()and not IsEntityDead(k)and d()then 
        loadAnimDict(i)
        if IsEntityPlayingAnim(k,i,"base",3)then 
            TaskPlayAnim(k,i,"exit",8.0,1.0,-1,49,0,0,0,0)
            Wait(100)
            DeleteObject(prop)
            ClearPedSecondaryTask(PlayerPedId())
        else 
            local r,s,t=table.unpack(GetEntityCoords(k))
            prop=CreateObject(GetHashKey(prop_name),r,s,t+0.2,true,true,true)
			DecorSetInt(prop, "ARMAACVeh", 955)
            AttachEntityToEntity(prop,k,GetPedBoneIndex(k,57005),0.15,0.005,-0.02,80.0,-20.0,175.0,true,true,false,true,1,true)
            TaskPlayAnim(k,i,"base",8.0,1.0,-1,49,0,0,0,0)
            Wait(500)
        end 
    end 
end,false)
RegisterCommand("bag",function(f,g)
    local k=PlayerPedId()
    if DoesEntityExist(k)and canAnim()and not IsEntityDead(k)and d()then 
		tARMA.allowWeapon("0x88C78EB7")
        GiveWeaponToPed(k,0x88C78EB7,1,false,true)
    end 
end,false)
RegisterCommand("bag2",function(f,g)
    local k=PlayerPedId()
    if DoesEntityExist(k)and canAnim()and not IsEntityDead(k)and d()then 
		tARMA.allowWeapon("0x01B79F17")
        GiveWeaponToPed(k,0x01B79F17,1,false,true)
    end 
end,false)
RegisterCommand("damn",function(f,g)
    local i="gestures@m@standing@casual"
    local k=PlayerPedId()
    if DoesEntityExist(k)and canAnim()and not IsEntityDead(k)and d()then 
        loadAnimDict(i)
        if IsEntityPlayingAnim(k,i,"gesture_damn",3)then 
            TaskPlayAnim(k,i,"exit",8.0,1.0,-1,49,0,0,0,0)
        else 
            TaskPlayAnim(k,i,"gesture_damn",8.0,1.0,-1,49,0,0,0,0)
        end 
    end 
end,false)
RegisterCommand("salute", function(c, d)
	local e = "anim@mp_player_intuppersalute"
	local f = tARMA.getPlayerPed()
	if DoesEntityExist(f) and (not IsEntityDead(f)) then
		loadAnimDict(e)
		if IsEntityPlayingAnim(f, e, "idle_a", 3) then
			TaskPlayAnim(f, e, "exit", 0, 0, -1, 49, 0, 0, 0, 0)
			Wait(600)
			ClearPedSecondaryTask(tARMA.getPlayerPed())
		else
			TaskPlayAnim(f, e, "idle_a", 0, 0, -1, 49, 0, 0, 0, 0)
			Wait(500)
		end
	end
end, false)
RegisterCommand("fail", function(f, g)
	local i = "random@car_thief@agitated@idle_a"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, "agitated_idle_a", 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 49, 0, 0, 0, 0)
		else
			TaskPlayAnim(k, i, "agitated_idle_a", 0, 0, -1, 49, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("sign1", function(f, g)
	local i = "mp_player_int_uppergang_sign_a"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, "mp_player_int_gang_sign_a", 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 49, 0, 0, 0, 0)
		else
			TaskPlayAnim(k, i, "mp_player_int_gang_sign_a", 0, 0, -1, 49, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("sign2", function(f, g)
	local i = "mp_player_int_uppergang_sign_b"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, "mp_player_int_gang_sign_b", 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 49, 0, 0, 0, 0)
		else
			TaskPlayAnim(k, i, "mp_player_int_gang_sign_b", 0, 0, -1, 49, 0, 0, 0, 0)
		end
	end
end, false)

RegisterCommand("finger", function(c, d)
	local e = "anim@mp_player_intselfiethe_bird"
	local f = tARMA.getPlayerPed()
	if DoesEntityExist(f) and (not IsEntityDead(f)) then
		loadAnimDict(e)
		if IsEntityPlayingAnim(f, e, "idle_a", 3) then
			TaskPlayAnim(f, e, "exit", 0, 0, -1, 49, 0, 0, 0, 0)
			Wait(100)
			ClearPedSecondaryTask(tARMA.getPlayerPed())
		else
			TaskPlayAnim(f, e, "idle_a", 0, 0, -1, 49, 0, 0, 0, 0)
			Wait(5000)
			TaskPlayAnim(f, e, "exit", 0, 0, -1, 49, 0, 0, 0, 0)
			Wait(100)
			ClearPedSecondaryTask(tARMA.getPlayerPed())
		end
	end
end, false)
RegisterCommand("finger2", function(c, d)
	local e = "anim@mp_player_intupperfinger"
	local f = tARMA.getPlayerPed()
	if DoesEntityExist(f) and (not IsEntityDead(f)) then
		loadAnimDict(e)
		if IsEntityPlayingAnim(f, e, "idle_a", 3) then
			TaskPlayAnim(f, e, "exit", 0, 0, -1, 49, 0, 0, 0, 0)
			Wait(100)
			ClearPedSecondaryTask(tARMA.getPlayerPed())
		else
			TaskPlayAnim(f, e, "idle_a", 0, 0, -1, 49, 0, 0, 0, 0)
			Wait(5000)
			TaskPlayAnim(f, e, "exit", 0, 0, -1, 49, 0, 0, 0, 0)
			Wait(100)
			ClearPedSecondaryTask(tARMA.getPlayerPed())
		end
	end
end, false)

RegisterCommand("fingerbum",function(c,d)
    local e="mp_player_int_upperarse_pick"
    local f=tARMA.getPlayerPed()
    if DoesEntityExist(f)and not IsEntityDead(f)then 
        loadAnimDict(e)
        if IsEntityPlayingAnim(f,e,"mp_player_int_arse_pick",3)then 
            TaskPlayAnim(f,e,"exit",8.0,1.0,-1,49,0,0,0,0)
            Wait(100)
            a=false
            notes=false 
        else 
            TaskPlayAnim(f,e,"mp_player_int_arse_pick",8.0,1.0,-1,49,0,0,0,0)
            Wait(500)
            notes=true
            a=true 
        end 
    end 
end,false)
RegisterCommand("touchself",function(f,g)
    local i="mp_player_int_uppergrab_crotch"
    local k=PlayerPedId()
    if DoesEntityExist(k)and canAnim()and not IsEntityDead(k)and d()then 
        loadAnimDict(i)
        if IsEntityPlayingAnim(k,i,"mp_player_int_grab_crotch",3)then 
            TaskPlayAnim(k,i,"exit",8.0,1.0,-1,49,0,0,0,0)
        else 
            TaskPlayAnim(k,i,"mp_player_int_grab_crotch",8.0,1.0,-1,49,0,0,0,0)
        end 
    end 
end,false)
RegisterCommand("wanker",function(f,g)
    local i="mp_player_intwank"
    local k=PlayerPedId()
    if DoesEntityExist(k)and canAnim()and not IsEntityDead(k)and d()then 
        loadAnimDict(i)
        if IsEntityPlayingAnim(k,i,"mp_player_int_wank",3)then 
            TaskPlayAnim(k,i,"exit",8.0,1.0,-1,49,0,0,0,0)
        else 
            TaskPlayAnim(k,i,"mp_player_int_wank",8.0,1.0,-1,49,0,0,0,0)
        end 
    end 
end,false)

globalSurrenderring=false
function surrender()
    local k=PlayerPedId()
    if DoesEntityExist(k)and canAnim()and not IsEntityDead(k)and d()then 
        loadAnimDict("random@arrests")
        loadAnimDict("random@arrests@busted")
        if IsEntityPlayingAnim(k,"random@arrests@busted","idle_a",3)then 
            globalSurrenderring=false
            TaskPlayAnim(k,"random@arrests@busted","exit",8.0,1.0,-1,2,0,0,0,0)
            surrendered=false
            Wait(3000)
            TaskPlayAnim(k,"random@arrests","kneeling_arrest_get_up",8.0,1.0,-1,128,0,0,0,0)
        else 
            globalSurrenderring=true
            TaskPlayAnim(k,"random@arrests","idle_2_hands_up",8.0,1.0,-1,2,0,0,0,0)
            Wait(4000)
            TaskPlayAnim(k,"random@arrests","kneeling_arrest_idle",8.0,1.0,-1,2,0,0,0,0)
            Wait(500)
            TaskPlayAnim(k,"random@arrests@busted","enter",8.0,1.0,-1,2,0,0,0,0)
            surrendered=true
            Wait(1000)
            TaskPlayAnim(k,"random@arrests@busted","idle_a",8.0,1.0,-1,9,0,0,0,0)
        end 
    end 
end

function tARMA.globalSurrenderring()
    return globalSurrenderring
end

local function u()
    local v=PlayerPedId()
    if surrendered or IsEntityPlayingAnim(v,'missminuteman_1ig_2','handsup_enter',3)or IsEntityPlayingAnim(v,"random@arrests","idle_2_hands_up",3)or IsEntityPlayingAnim(v,"random@arrests@busted","idle_a",3)then 
        return true 
    end
    return false 
end
local function w(r,s,x,y,z,A)
    local B=x*A/100
    local r=r-x*A/100/2-x/2
    DrawRect(r+B,s,B,y,z[1],z[2],z[3],z[4])
end
function isPlayerSurrendered()
    local C=GetGameTimer()
    while GetGameTimer()-C<=5000 and u()do 
        w(0.475,0.8,0.0690*2,0.0085*1.5,{255,47,27,255},(GetGameTimer()-C)/5000*100)
        Wait(0)
    end
    if GetGameTimer()-C>5000 then 
        return true 
    end
    return false 
end
local D

RegisterNetEvent("ARMA:startRobbingPlayer",function()
    D=GetGameTimer()
end)
RegisterNetEvent("ARMA:endRobbingPlayer",function()
    D=nil 
end)
Citizen.CreateThread(function()
    while true do 
        Wait(0)
        if surrendered then 
            DisableControlAction(1,140,true)
            DisableControlAction(1,141,true)
            DisableControlAction(1,142,true)
            DisableControlAction(0,21,true)
        end
        DisableControlAction(2,36,true)
        if D then 
            w(0.475,0.8,0.0690*2,0.0085*1.5,{255,47,27,255},(GetGameTimer()-D)/5000*100)
        end 
    end 
end)
RegisterCommand("k",function(f,g)
    surrender()
end,false)
RegisterCommand("surrender",function(f,g)
    surrender()
end,false)
RegisterCommand("peace",function(f,g)
    local k=PlayerPedId()
    local i="mp_player_int_upperpeace_sign"
    if DoesEntityExist(k)and canAnim()and not IsEntityDead(k)and d()then 
        loadAnimDict(i)
        if IsEntityPlayingAnim(k,i,"mp_player_int_peace_sign",3)then 
            TaskPlayAnim(k,i,"exit",8.0,1.0,-1,49,0,0,0,0)
        else 
            TaskPlayAnim(k,i,"mp_player_int_peace_sign",8.0,1.0,-1,49,0,0,0,0)
            Wait(10000)
            TaskPlayAnim(k,i,"exit",8.0,1.0,-1,49,0,0,0,0)
            Wait(1000)
            ClearPedSecondaryTask(PlayerPedId())
        end 
    end 
end,false)
RegisterCommand("holster", function(f, g)
	local k = PlayerPedId()
	local i = "move_m@intimidation@cop@unarmed"
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, "idle", 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 49, 0, 0, 0, 0)
		else
			TaskPlayAnim(k, i, "idle", 0, 0, -1, 49, 0, 0, 0, 0)
			Wait(10000)
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 49, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("guard", function(f, g)
	local k = PlayerPedId()
	local i = "rcmepsilonism8"
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, "base_carrier", 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 49, 0, 0, 0, 0)
		else
			TaskPlayAnim(k, i, "base_carrier", 0, 0, -1, 49, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("slowclap", function(f, g)
	local k = PlayerPedId()
	local i = "anim@mp_player_intcelebrationmale@slow_clap"
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
			loadAnimDict(i)
			if IsEntityPlayingAnim(k, i, "slow_clap", 3) then
				TaskPlayAnim(k, i, "exit", 0, 0, -1, 49, 0, 0, 0, 0)
				ClearPedSecondaryTask(k)
				Wait(100)
			else
				TaskPlayAnim(k, i, "slow_clap", 0, 0, -1, 49, 0, 0, 0, 0)
				Wait(500)
			end
		end
	end
end, false)
RegisterCommand("cheer", function(f, g)
	local k = PlayerPedId()
	local i = "amb@world_human_cheering@male_a"
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
			loadAnimDict(i)
			if IsEntityPlayingAnim(k, i, "base", 3) then
				TaskPlayAnim(k, i, "exit", 0, 0, -1, 49, 0, 0, 0, 0)
				ClearPedSecondaryTask(k)
				Wait(100)
			else
				TaskPlayAnim(k, i, "base", 0, 0, -1, 49, 0, 0, 0, 0)
				Wait(500)
			end
		end
	end
end, false)
RegisterCommand("lean", function(f, g)
	local k = PlayerPedId()
	local i = "amb@lo_res_idles@"
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, "world_human_lean_male_foot_up_lo_res_base", 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 33, 0, 0, 0, 0)
			Wait(100)
		else
			TaskPlayAnim(k, i, "world_human_lean_male_foot_up_lo_res_base", 0, 0, -1, 33, 0, 0, 0, 0)
			Wait(500)
		end
	end
end, false)
RegisterCommand("copcrowd", function(f, g)
	local k = PlayerPedId()
	local i = "amb@code_human_police_crowd_control@idle_a"
	local j = "idle_a"
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
			Wait(10000)
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		end
	end
end, false)
RegisterCommand("copcrowd2", function(f, g)
	local k = PlayerPedId()
	local i = "amb@code_human_police_crowd_control@idle_b"
	local j = "idle_d"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
			Wait(10000)
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		end
	end
end, false)
RegisterCommand("copidle", function(f, g)
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		if IsPedActiveInScenario(k) then
			ClearPedTasks(k)
		else
			TaskStartScenarioInPlace(k, "WORLD_HUMAN_COP_IDLES", 0, 1)
			Wait(60000)
			ClearPedTasks(k)
		end
	end
end, false)
local E = false
local F = "prop_parking_wand_01"
local G = nil
local H = false
local I = "hei_heist_sh_bong_01"
local J = nil
local K = false
local L = "prop_amb_phone"
local M = nil

RegisterCommand("picture",function(f,g)
    local k=PlayerPedId()
    local N=GetHashKey(L)
    RequestModel(N)
    local O=GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()),0.0,0.0,-5.0)
    local P=CreateObject(N,O.x,O.y,O.z,1,1,1)
    local i="amb@world_human_mobile_film_shocking@male@enter"
    local ad2="amb@world_human_mobile_film_shocking@male@base"
    local Q="amb@world_human_mobile_film_shocking@male@exit"
    local R="core"
    local S="ent_anim_paparazzi_flash"
    if DoesEntityExist(k)and not IsEntityDead(k)then 
        loadAnimDict(i)
        loadAnimDict(ad2)
        loadAnimDict(Q)
        RequestPtfxAsset(R)
        SetModelAsNoLongerNeeded(N)
        if K then 
            TaskPlayAnim(k,Q,"exit",8.0,1.0,-1,50,0,0,0,0)
            Wait(1840)
            DetachEntity(P)
            DeleteEntity(P)Wait(750)
            ClearPedSecondaryTask(PlayerPedId())
            K=false 
        else 
            Wait(500)
            SetNetworkIdExistsOnAllMachines(P,true)
            NetworkSetNetworkIdDynamic(P,true)
            SetNetworkIdCanMigrate(P,false)
            TaskPlayAnim(k,i,"enter",8.0,1.0,-1,50,0,0,0,0)
            Wait(1260)
            AttachEntityToEntity(P,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()),28422),-0.005,0.0,0.0,360.0,360.0,0.0,1,1,0,1,0,1)
            notify("Press ~r~[E]~w~ to take a picture!")
            K=true 
        end 
    end
    while K do 
        Wait(0)
        if IsControlJustPressed(0,38)then 
            notify("Click Click")
            Wait(500)
            UseParticleFxAssetNextCall(R)
            StartParticleFxNonLoopedOnEntity(S,P,0.0,0.1,0.0,0.0,0.0,0.0,2.0,0.0,0.0,0.0)
        end 
    end 
end,false)
RegisterCommand("bong", function(f, g)
	local T = "anim@safehouse@bong"
	local U = "bong_stage1"
	local k = PlayerPedId()
	local V = GetHashKey(I)
	RequestModel(V)
	local O = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0, 0, -0)
	local W = CreateObject(V, O.x, O.y, O.z, 1, 1, 1)
	SetModelAsNoLongerNeeded(V)
	if DoesEntityExist(k) and (not IsEntityDead(k)) then
		loadAnimDict(T)
		if H then
			Wait(100)
			ClearPedSecondaryTask(PlayerPedId())
			DetachEntity(W)
			DeleteEntity(W)
			H = false
		else
			Wait(500)
			SetNetworkIdExistsOnAllMachines(W, true)
			NetworkSetNetworkIdDynamic(W, true)
			SetNetworkIdCanMigrate(W, false)
			AttachEntityToEntity(W, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 18905), 0, -0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 1)
			Wait(120)
			notify("Press ~r~[E]~w~ to take a toke!")
			H = true
		end
	end
	while H do
		Wait(0)
		local X = GetEntityCoords(k, true)
		local Y = GetEntityHeading(k)
		if IsControlJustPressed(0, 38) then
			TaskPlayAnimAdvanced(k, T, U, X.x, X.y, X.z, 0, 0, Y, 0, 0, 4000, 49, 0, 0, 0)
			Wait(100)
			notify("You take a huge rip!")
			Wait(7250)
			TaskPlayAnim(k, ad2, ad2a, 0, 0, -1, 49, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("ma", function(f, g)
	local T = "amb@world_human_car_park_attendant@male@base"
	local U = "base"
	local ad2 = "amb@world_human_drinking@beer@male@exit"
	local ad2a = "exit"
	local Z = GetHashKey(F)
	RequestModel(Z)
	local k = PlayerPedId()
	local O = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0, 0, -0)
	local _ = CreateObject(Z, O.x, O.y, O.z, 1, 1, 1)
	if DoesEntityExist(k) and (not IsEntityDead(k)) then
		loadAnimDict(T)
		loadAnimDict(ad2)
		SetModelAsNoLongerNeeded(Z)
		if E then
			Wait(100)
			ClearPedSecondaryTask(PlayerPedId())
			DetachEntity(_)
			DeleteEntity(_)
			E = false
		else
			Wait(500)
			SetNetworkIdExistsOnAllMachines(_, true)
			NetworkSetNetworkIdDynamic(_, true)
			SetNetworkIdCanMigrate(_, false)
			AttachEntityToEntity(_, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422), -0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 1)
			Wait(120)
			notify("Press ~r~[E]~w~ to wave the wand.")
			E = true
		end
	end
	while E do
		Wait(0)
		local a0 = {
			"Nothing to see here, lets move along.",
			"Keep it moving!",
			"Ugh, why did I pick traffic control..",
			"Lets go already!",
			"Will yinz hurry up!!"
		}
		local a1 = math.random(1, 5)
		if IsControlJustPressed(0, 38) then
			TaskPlayAnim(k, T, U, 0, 0, 5000, 49, 0, 0, 0, 0)
			Wait(100)
			notify(a0[a1])
		end
	end
end, false)
RegisterCommand("dance1", function(f, g)
	local i = "anim@amb@nightclub@dancers@black_madonna_entourage@"
	local j = "li_dance_facedj_11_v1_male^1"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance2", function(f, g)
	local i = "anim@amb@nightclub@dancers@black_madonna_entourage@"
	local j = "hi_dance_facedj_09_v2_male^5"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance3", function(f, g)
	local i = "anim@amb@nightclub@dancers@black_madonna_entourage@"
	local j = "li_dance_facedj_15_v2_male^2"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance4", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local j = "mi_dance_prop_15_v1_male^1"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance5", function(f, g)
	local i = "anim@amb@nightclub@djs@dixon@"
	local j = "dixn_dance_a_dixon"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance6", function(f, g)
	local i = "anim@amb@nightclub@djs@solomun@"
	local j = "sol_trans_out_to_rt_a_sol"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance7", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_09_v1_female^1"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance8", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_09_v1_female^2"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance9", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_09_v1_female^3"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance10", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_09_v1_female^4"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance11", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_09_v1_female^5"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance12", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_09_v1_female^6"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance13", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_09_v1_male^1"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance14", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_09_v1_male^2"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance15", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_09_v1_male^3"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance16", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_09_v1_male^4"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance17", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_09_v1_male^5"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance18", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_09_v1_male^6"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance19", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_09_v2_female^1"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance20", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_09_v2_female^2"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance21", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_09_v2_female^3"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance22", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_09_v2_female^4"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance23", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_09_v2_female^5"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance24", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_09_v2_female^6"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance25", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_09_v2_male^1"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance26", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_09_v2_male^2"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance27", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_09_v2_male^3"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance28", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_09_v2_male^4"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance29", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_09_v2_male^5"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance30", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_09_v2_male^6"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance31", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_11_v1_female^1"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance32", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_11_v1_female^2"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance33", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_11_v1_female^3"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance34", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_11_v1_female^4"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance35", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_11_v1_female^5"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance36", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_11_v1_female^6"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance37", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_11_v1_male^1"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance38", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_11_v1_male^2"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance39", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_11_v1_male^3"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance40", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_11_v1_male^4"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance41", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_11_v1_male^5"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance42", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_11_v1_male^6"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance43", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_11_v2_female^1"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance44", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_11_v2_female^2"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance45", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_11_v2_female^3"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance46", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_11_v2_female^4"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance47", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_11_v2_female^5"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance48", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_11_v2_female^6"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance49", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_11_v2_male^1"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance50", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_11_v2_male^2"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance51", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_11_v2_male^3"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance52", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_11_v2_male^4"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance53", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_11_v2_male^5"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance54", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "hi_dance_facedj_11_v2_male^6"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance55", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "mi_dance_facedj_09_v1_female^1"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance56", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "mi_dance_facedj_09_v1_female^2"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance57", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "mi_dance_facedj_09_v1_female^3"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance58", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "mi_dance_facedj_09_v1_female^4"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance59", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "mi_dance_facedj_09_v1_female^5"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance60", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "mi_dance_facedj_09_v1_female^6"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance61", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "mi_dance_facedj_09_v1_male^1"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance62", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "mi_dance_facedj_09_v1_male^2"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance63", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "mi_dance_facedj_09_v1_male^3"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance64", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "mi_dance_facedj_09_v1_male^4"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance65", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "mi_dance_facedj_09_v1_male^5"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance66", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "mi_dance_facedj_09_v1_male^6"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance67", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "mi_dance_facedj_09_v2_female^1"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance68", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "mi_dance_facedj_09_v2_female^2"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance69", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "mi_dance_facedj_09_v2_female^3"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance70", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "mi_dance_facedj_09_v2_female^4"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance71", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "mi_dance_facedj_09_v2_female^5"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance72", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local j = "mi_dance_facedj_09_v2_female^6"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance73", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity"
	local j = "hi_dance_facedj_09_v1_female^1"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance74", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity"
	local j = "hi_dance_facedj_09_v1_female^2"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance75", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity"
	local j = "hi_dance_facedj_09_v1_female^3"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance74", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity"
	local j = "hi_dance_facedj_09_v1_female^4"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance75", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity"
	local j = "hi_dance_facedj_09_v1_female^5"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance76", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity"
	local j = "hi_dance_facedj_09_v1_female^6"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance77", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_low_intensity"
	local j = "trans_dance_crowd_li_to_hi_09_v1_male^1"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance78", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_low_intensity"
	local j = "trans_dance_crowd_li_to_hi_09_v1_male^2"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance79", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_low_intensity"
	local j = "trans_dance_crowd_li_to_hi_09_v1_male^3"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance80", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_low_intensity"
	local j = "trans_dance_crowd_li_to_hi_09_v1_male^4"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance81", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_low_intensity"
	local j = "trans_dance_crowd_li_to_hi_09_v1_male^5"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance82", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_low_intensity"
	local j = "trans_dance_crowd_li_to_hi_09_v1_male^6"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance83", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity"
	local j = "trans_dance_crowd_mi_to_hi_09_v1_male^1"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance84", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity"
	local j = "trans_dance_crowd_mi_to_hi_09_v1_male^2"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance85", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity"
	local j = "trans_dance_crowd_mi_to_hi_09_v1_male^3"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance86", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity"
	local j = "trans_dance_crowd_mi_to_hi_09_v1_male^4"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance87", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity"
	local j = "trans_dance_crowd_mi_to_hi_09_v1_male^5"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance88", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity"
	local j = "trans_dance_crowd_mi_to_hi_09_v1_male^6"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance89", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local j = "hi_dance_prop_09_v1_female^1"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance90", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local j = "hi_dance_prop_09_v1_female^2"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance91", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local j = "hi_dance_prop_09_v1_female^3"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance92", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local j = "hi_dance_prop_09_v1_female^4"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance93", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local j = "hi_dance_prop_09_v1_female^5"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance94", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local j = "hi_dance_prop_09_v1_female^6"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance95", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local j = "hi_dance_prop_09_v1_male^1"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance96", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local j = "hi_dance_prop_09_v1_male^2"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance97", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local j = "hi_dance_prop_09_v1_male^3"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance98", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local j = "hi_dance_prop_09_v1_male^4"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance99", function(f, g)
	local i = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local j = "hi_dance_prop_09_v1_male^5"
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
RegisterCommand("dance100", function(f, g)
	local i = ""
	local j = ""
	local k = PlayerPedId()
	if DoesEntityExist(k) and canAnim() and (not IsEntityDead(k)) and d() then
		loadAnimDict(i)
		if IsEntityPlayingAnim(k, i, j, 3) then
			TaskPlayAnim(k, i, "exit", 0, 0, -1, 1, 0, 0, 0, 0)
			ClearPedSecondaryTask(k)
		else
			TaskPlayAnim(k, i, j, 0, 0, -1, 1, 0, 0, 0, 0)
		end
	end
end, false)
Citizen.CreateThread(function()
    local a2=false
    while true do
        if (IsDisabledControlPressed(1,19) or IsControlPressed(1, 19)) and (IsDisabledControlPressed(1,63) or IsControlPressed(1, 63)) and d()and not sittingAtBlackjackTable then
            if not a2 and tARMA.globalNHSOnDuty() then 
                a2=true
                local a3="combat@drag_ped@"
                local a4="injured_drag_plyr"
                local a5="injured_drag_ped"
                local a6=0.48
                local a7=4103
                local y=0.0
                local a8=0.0
                local a9=30000
                controlFlagMe=33
                controlFlagTarget=33
                animFlagTarget=1
                detachFlag=1
                boneIndex=11816
                local aa=tARMA.GetClosestPlayer(3)
                if aa then 
                    local ab=GetPlayerServerId(aa)
                    if ab~=-1 then 
                        TriggerServerEvent("ARMA:animationSync",aa,a3,a4,a5,a6,a7,y,ab,a9,a8,controlFlagMe,controlFlagTarget,animFlagTarget,detachFlag,boneIndex)
                    end 
                end 
            else 
                a2=false
                DetachEntity(PlayerPedId())
                ClearPedSecondaryTask(PlayerPedId())
                local aa=tARMA.GetClosestPlayer(3)
                local ac=GetPlayerServerId(aa)
                if ac~=0 then 
                    TriggerServerEvent("ARMA:animationSyncStop",ac)
                end 
            end
            Wait(250)
        end
        Wait(0)
    end 
end)

RegisterNetEvent("ARMA:animationSyncClStop")
AddEventHandler("ARMA:animationSyncClStop",function()
    ClearPedSecondaryTask(PlayerPedId())
    DetachEntity(PlayerPedId())
end)
RegisterCommand("baseball",function(f,g)
    local a3="anim@arena@celeb@flat@paired@no_props@"
    local a4="baseball_a_player_a"
    local a5="baseball_a_player_b"
    local a6=1.1
    local a7=0.0
    local y=0.0
    local a9=30000
    local aa=tARMA.GetClosestPlayer(3)
    local ac=GetPlayerServerId(aa)
    if aa~=nil and not c()and GetEntityHealth(GetPlayerPed(aa))>102 and d()and canAnim()then 
        TriggerServerEvent("ARMA:animationSync",aa,a3,a4,a5,a6,a7,y,ac,a9)
        RequestAnimDict("anim@arena@celeb@flat@paired@no_props@")
        PlayFacialAnim(PlayerPedId(),"baseball_a_player_a_face","anim@arena@celeb@flat@paired@no_props@")
    end
end,false)
RegisterCommand("baseball2", function(f, g)
	local a3 = "anim@arena@celeb@flat@paired@no_props@"
	local a4 = "daps_b_player_a"
	local a5 = "daps_b_player_b"
	local a6 = 0
	local a7 = 0
	local y = 0
	local a9 = 30000
	local aa = tARMA.GetClosestPlayer(3)
	local ac = GetPlayerServerId(aa)
	if aa ~= nil and (not c()) and GetEntityHealth(GetPlayerPed(aa)) > 102 and d() and canAnim() then
		TriggerServerEvent("ARMA:animationSync", aa, a3, a4, a5, a6, a7, y, ac, a9)
	end
end, false)
RegisterCommand("baseball3", function(f, g)
	local a3 = "anim@arena@celeb@flat@paired@no_props@"
	local a4 = "did_you_see_a_player_a"
	local a5 = "did_you_see_a_player_b"
	local a6 = 0
	local a7 = 0
	local y = 0
	local a9 = 30000
	local aa = tARMA.GetClosestPlayer(3)
	local ac = GetPlayerServerId(aa)
	if aa ~= nil and (not c()) and GetEntityHealth(GetPlayerPed(aa)) > 102 and d() and canAnim() then
		TriggerServerEvent("ARMA:animationSync", aa, a3, a4, a5, a6, a7, y, ac, a9)
	end
end, false)
RegisterCommand("baseball4", function(f, g)
	local a3 = "anim@arena@celeb@flat@paired@no_props@"
	local a4 = "high_five_b_player_a"
	local a5 = "high_five_b_player_b"
	local a6 = 0
	local a7 = 0
	local y = 0
	local a9 = 30000
	local aa = tARMA.GetClosestPlayer(3)
	local ac = GetPlayerServerId(aa)
	if aa ~= nil and (not c()) and GetEntityHealth(GetPlayerPed(aa)) > 102 and d() and canAnim() then
		TriggerServerEvent("ARMA:animationSync", aa, a3, a4, a5, a6, a7, y, ac, a9)
	end
end, false)
RegisterCommand("baseball5", function(f, g)
	local a3 = "anim@arena@celeb@flat@paired@no_props@"
	local a4 = "high_five_c_player_a"
	local a5 = "high_five_c_player_b"
	local a6 = 0
	local a7 = -0
	local y = 0
	local a9 = 30000
	local aa = tARMA.GetClosestPlayer(3)
	local ac = GetPlayerServerId(aa)
	if aa ~= nil and (not c()) and GetEntityHealth(GetPlayerPed(aa)) > 102 and d() and canAnim() then
		TriggerServerEvent("ARMA:animationSync", aa, a3, a4, a5, a6, a7, y, ac, a9)
	end
end, false)
RegisterCommand("baseball6", function(f, g)
	local a3 = "anim@arena@celeb@flat@paired@no_props@"
	local a4 = "hype_a_player_a"
	local a5 = "hype_a_player_b"
	local a6 = 0
	local a7 = 0
	local y = 0
	local a9 = 30000
	local aa = tARMA.GetClosestPlayer(3)
	local ac = GetPlayerServerId(aa)
	if aa ~= nil and (not c()) and GetEntityHealth(GetPlayerPed(aa)) > 102 and d() and canAnim() then
		TriggerServerEvent("ARMA:animationSync", aa, a3, a4, a5, a6, a7, y, ac, a9)
	end
end, false)
RegisterCommand("baseball7", function(f, g)
	local a3 = "anim@arena@celeb@flat@paired@no_props@"
	local a4 = "laugh_a_player_a"
	local a5 = "laugh_a_player_b"
	local a6 = 0
	local a7 = 0
	local y = 0
	local a9 = 30000
	local aa = tARMA.GetClosestPlayer(3)
	local ac = GetPlayerServerId(aa)
	if aa ~= nil and (not c()) and GetEntityHealth(GetPlayerPed(aa)) > 102 and d() and canAnim() then
		TriggerServerEvent("ARMA:animationSync", aa, a3, a4, a5, a6, a7, y, ac, a9)
	end
end, false)
RegisterCommand("baseball8", function(f, g)
	local a3 = "anim@arena@celeb@flat@paired@no_props@"
	local a4 = "laugh_b_player_a"
	local a5 = "laugh_b_player_b"
	local a6 = 0
	local a7 = 0
	local y = 0
	local a9 = 30000
	local aa = tARMA.GetClosestPlayer(3)
	local ac = GetPlayerServerId(aa)
	if aa ~= nil and (not c()) and GetEntityHealth(GetPlayerPed(aa)) > 102 and d() and canAnim() then
		TriggerServerEvent("ARMA:animationSync", aa, a3, a4, a5, a6, a7, y, ac, a9)
	end
end, false)
RegisterCommand("baseball9", function(f, g)
	local a3 = "anim@arena@celeb@flat@paired@no_props@"
	local a4 = "piggyback_b_player_a"
	local a5 = "piggyback_b_player_b"
	local a6 = -0
	local a7 = 0
	local y = 0
	local a8 = 0
	local a9 = 100000
	controlFlagMe = 49
	controlFlagTarget = 1
	animFlagTarget = 1
	detachFlag = 0
	local aa = tARMA.GetClosestPlayer(3)
	local ac = GetPlayerServerId(aa)
	if aa ~= nil and (not c()) and GetEntityHealth(GetPlayerPed(aa)) > 102 and d() and canAnim() then
		TriggerServerEvent("ARMA:animationSync", aa, a3, a4, a5, a6, a7, y, ac, a9, a8, controlFlagMe, controlFlagTarget, animFlagTarget, detachFlag)
	end
end, false)
RegisterCommand("baseball10", function(f, g)
	local a3 = "anim@arena@celeb@flat@paired@no_props@"
	local a4 = "piggyback_c_player_a"
	local a5 = "piggyback_c_player_b"
	local a6 = -0
	local a7 = 0
	local y = 0
	local a8 = 0
	local a9 = 100000
	controlFlagMe = 1
	controlFlagTarget = 1
	animFlagTarget = 1
	local aa = tARMA.GetClosestPlayer(3)
	local ac = GetPlayerServerId(aa)
	if aa ~= nil and (not c()) and GetEntityHealth(GetPlayerPed(aa)) > 102 and d() and canAnim() then
		TriggerServerEvent("ARMA:animationSync", aa, a3, a4, a5, a6, a7, y, ac, a9, a8, controlFlagMe, controlFlagTarget, animFlagTarget, detachFlag)
	end
end, false)
RegisterCommand("baseball11", function(f, g)
	local a3 = "anim@arena@celeb@flat@paired@no_props@"
	local a4 = "the_bird_a_player_a"
	local a5 = "the_bird_a_player_b"
	local a6 = 0
	local a7 = 0
	local y = 0
	local a8 = 0
	local a9 = 30000
	local aa = tARMA.GetClosestPlayer(3)
	local ac = GetPlayerServerId(aa)
	if aa ~= nil and (not c()) and GetEntityHealth(GetPlayerPed(aa)) > 102 and d() and canAnim() then
		TriggerServerEvent("ARMA:animationSync", aa, a3, a4, a5, a6, a7, y, ac, a9)
	end
end, false)
RegisterCommand("celebrate", function(f, g)
	local a3 = "anim@arena@celeb@flat@paired@props@"
	local a4 = "cham_a_player_a"
	local a5 = "cham_a_player_b"
	local a6 = 0
	local a7 = 0
	local y = 0
	local a9 = 30000
	local aa = tARMA.GetClosestPlayer(3)
	local ac = GetPlayerServerId(aa)
	if aa ~= nil and (not c()) and GetEntityHealth(GetPlayerPed(aa)) > 102 and d() and canAnim() then
		TriggerServerEvent("ARMA:animationSync", aa, a3, a4, a5, a6, a7, y, ac, a9)
	end
end, false)
RegisterCommand("celebrate2", function(f, g)
	local a3 = "anim@arena@celeb@flat@paired@props@"
	local a4 = "cham_b_player_a"
	local a5 = "cham_b_player_b"
	local a6 = 0
	local a7 = 0
	local y = 0
	local a9 = 30000
	local aa = tARMA.GetClosestPlayer(3)
	local ac = GetPlayerServerId(aa)
	if aa ~= nil and (not c()) and GetEntityHealth(GetPlayerPed(aa)) > 102 and d() and canAnim() then
		TriggerServerEvent("ARMA:animationSync", aa, a3, a4, a5, a6, a7, y, ac, a9)
	end
end, false)
RegisterCommand("celebrate3", function(f, g)
	local a3 = "anim@arena@celeb@flat@paired@props@"
	local a4 = "cham_c_player_a"
	local a5 = "cham_c_player_b"
	local a6 = 0
	local a7 = 0
	local y = 0
	local a9 = 30000
	local aa = tARMA.GetClosestPlayer(3)
	local ac = GetPlayerServerId(aa)
	if aa ~= nil and (not c()) and GetEntityHealth(GetPlayerPed(aa)) > 102 and d() and canAnim() then
		TriggerServerEvent("ARMA:animationSync", aa, a3, a4, a5, a6, a7, y, ac, a9)
	end
end, false)
RegisterCommand("celebrate4", function(f, g)
	local a3 = "anim@arena@celeb@flat@paired@props@"
	local a4 = "cham_d_player_a"
	local a5 = "cham_d_player_b"
	local a6 = 0
	local a7 = 0
	local y = 0
	local a9 = 30000
	local aa = tARMA.GetClosestPlayer(3)
	local ac = GetPlayerServerId(aa)
	if aa ~= nil and (not c()) and GetEntityHealth(GetPlayerPed(aa)) > 102 and d() and canAnim() then
		TriggerServerEvent("ARMA:animationSync", aa, a3, a4, a5, a6, a7, y, ac, a9)
	end
end, false)
RegisterCommand("trophy", function(f, g)
	local a3 = "anim@arena@celeb@flat@paired@props@"
	local a4 = "trophy_a_player_a"
	local a5 = "trophy_a_player_b"
	local a6 = 0
	local a7 = 0
	local y = 0
	local a9 = 30000
	local aa = tARMA.GetClosestPlayer(3)
	local ac = GetPlayerServerId(aa)
	if aa ~= nil and (not c()) and GetEntityHealth(GetPlayerPed(aa)) > 102 and d() and canAnim() then
		TriggerServerEvent("ARMA:animationSync", aa, a3, a4, a5, a6, a7, y, ac, a9)
	end
end, false)
RegisterCommand("trophy2", function(f, g)
	local a3 = "anim@arena@celeb@flat@paired@props@"
	local a4 = "trophy_b_player_a"
	local a5 = "trophy_b_player_b"
	local a6 = 0
	local a7 = 0
	local y = 0
	local a9 = 30000
	local aa = tARMA.GetClosestPlayer(3)
	local ac = GetPlayerServerId(aa)
	if aa ~= nil and (not c()) and GetEntityHealth(GetPlayerPed(aa)) > 102 and d() and canAnim() then
		TriggerServerEvent("ARMA:animationSync", aa, a3, a4, a5, a6, a7, y, ac, a9)
	end
end, false)
RegisterCommand("trophy3", function(f, g)
	local a3 = "anim@arena@celeb@flat@paired@props@"
	local a4 = "trophy_c_player_a"
	local a5 = "trophy_c_player_b"
	local a6 = 0
	local a7 = 0
	local y = 0
	local a9 = 30000
	local aa = tARMA.GetClosestPlayer(3)
	local ac = GetPlayerServerId(aa)
	if aa ~= nil and (not c()) and GetEntityHealth(GetPlayerPed(aa)) > 102 and d() and canAnim() then
		TriggerServerEvent("ARMA:animationSync", aa, a3, a4, a5, a6, a7, y, ac, a9)
	end
end, false)
RegisterCommand("thumbsdown", function(f, g)
	local a3 = "anim@arena@celeb@flat@solo@no_props@"
	local a4 = "thumbs_down_a_player_a"
	local a5 = "thumbs_down_a_player_b"
	local a6 = 0
	local a7 = 0
	local y = 0
	local a9 = 30000
	local aa = tARMA.GetClosestPlayer(3)
	local ac = GetPlayerServerId(aa)
	if aa ~= nil and (not c()) and GetEntityHealth(GetPlayerPed(aa)) > 102 and d() and canAnim() then
		TriggerServerEvent("ARMA:animationSync", aa, a3, a4, a5, a6, a7, y, ac, a9)
	end
end, false)
RegisterCommand("angryclap", function(f, g)
	local a3 = "anim@arena@celeb@flat@solo@no_props@"
	local a4 = "angry_clap_a_player_a"
	local a5 = "angry_clap_a_player_a"
	local a6 = 0
	local a7 = 0
	local y = 0
	local a9 = 30000
	local aa = tARMA.GetClosestPlayer(3)
	local ac = GetPlayerServerId(aa)
	if aa ~= nil and (not c()) and GetEntityHealth(GetPlayerPed(aa)) > 102 and d() and canAnim() then
		TriggerServerEvent("ARMA:animationSync", aa, a3, a4, a5, a6, a7, y, ac, a9)
	end
end, false)
RegisterCommand("celebrate5", function(f, g)
	local a3 = "anim@arena@celeb@flat@solo@no_props@"
	local a4 = "jump_a_player_a"
	local a5 = "jump_a_player_a"
	local a6 = 0
	local a7 = 0
	local y = 0
	local a9 = 30000
	local aa = tARMA.GetClosestPlayer(3)
	local ac = GetPlayerServerId(aa)
	if aa ~= nil and (not c()) and GetEntityHealth(GetPlayerPed(aa)) > 102 and d() and canAnim() then
		TriggerServerEvent("ARMA:animationSync", aa, a3, a4, a5, a6, a7, y, ac, a9)
	end
end, false)
RegisterCommand("celebrate6", function(f, g)
	local a3 = "anim@arena@celeb@flat@solo@no_props@"
	local a4 = "jump_b_player_a"
	local a5 = "jump_b_player_a"
	local a6 = 0
	local a7 = 0
	local y = 0
	local a9 = 30000
	local aa = tARMA.GetClosestPlayer(3)
	local ac = GetPlayerServerId(aa)
	if aa ~= nil and (not c()) and GetEntityHealth(GetPlayerPed(aa)) > 102 and d() and canAnim() then
		TriggerServerEvent("ARMA:animationSync", aa, a3, a4, a5, a6, a7, y, ac, a9)
	end
end, false)
RegisterCommand("slapbum", function(f, g)
	local a3 = "misscarsteal2chad_goodbye"
	local a4 = "chad_dip_chad"
	local a5 = "chad_dip_girl"
	local a6 = 0
	local a7 = 0
	local y = 0
	local a9 = 30000
	local aa = tARMA.GetClosestPlayer(3)
	local ac = GetPlayerServerId(aa)
	if aa ~= nil and (not c()) and GetEntityHealth(GetPlayerPed(aa)) > 102 and d() and canAnim() then
		TriggerServerEvent("ARMA:animationSync", aa, a3, a4, a5, a6, a7, y, ac, a9)
	end
end, false)
RegisterCommand("celebrate7", function(f, g)
	local k = PlayerPedId()
	local a3 = "anim@arena@celeb@flat@solo@no_props@"
	local a4 = "jump_c_player_a"
	local a5 = "jump_c_player_a"
	local a6 = 0
	local a7 = 0
	local y = 0
	local a9 = 30000
	local aa = tARMA.GetClosestPlayer(3)
	local ac = GetPlayerServerId(aa)
	if aa ~= nil and (not c()) and GetEntityHealth(GetPlayerPed(aa)) > 102 and d() and canAnim() then
		TriggerServerEvent("ARMA:animationSync", aa, a3, a4, a5, a6, a7, y, ac, a9)
	end
end, false)
RegisterCommand("smug", function(f, g)
	local a3 = "anim@arena@celeb@flat@solo@no_props@"
	local a4 = "smug_a_player_a"
	local a5 = "smug_a_player_b"
	local a6 = 0
	local a7 = 0
	local y = 0
	local a9 = 30000
	local aa = tARMA.GetClosestPlayer(3)
	local ac = GetPlayerServerId(aa)
	if aa ~= nil and (not c()) and GetEntityHealth(GetPlayerPed(aa)) > 102 and d() and canAnim() then
		TriggerServerEvent("ARMA:animationSync", aa, a3, a4, a5, a6, a7, y, ac, a9)
	end
end, false)
RegisterCommand("backslap", function(f, g)
	local a3 = "anim@mp_player_intcelebrationpaired@f_f_backslap"
	local a4 = "backslap_left"
	local a5 = "backslap_right"
	local a6 = 0
	local a7 = 0
	local y = 0
	local a9 = 30000
	local aa = tARMA.GetClosestPlayer(3)
	local ac = GetPlayerServerId(aa)
	if aa ~= nil and (not c()) and GetEntityHealth(GetPlayerPed(aa)) > 102 and d() and canAnim() then
		TriggerServerEvent("ARMA:animationSync", aa, a3, a4, a5, a6, a7, y, ac, a9)
	end
end, false)
RegisterCommand("brohug", function(f, g)
	local a3 = "anim@mp_player_intcelebrationpaired@f_f_bro_hug"
	local a4 = "bro_hug_left"
	local a5 = "bro_hug_right"
	local a6 = 0
	local a7 = 0
	local y = 0
	local a8 = 0
	local a9 = 4000
	controlFlagMe = 0
	controlFlagTarget = 0
	animFlagTarget = 1
	detachFlag = 1
	local aa = tARMA.GetClosestPlayer(3)
	local ac = GetPlayerServerId(aa)
	if aa ~= nil and (not c()) and GetEntityHealth(GetPlayerPed(aa)) > 102 and d() and canAnim() then
		TriggerServerEvent("ARMA:animationSync", aa, a3, a4, a5, a6, a7, y, ac, a9, a8, controlFlagMe, controlFlagTarget, animFlagTarget, detachFlag)
	end
end, false)
RegisterCommand("ganghug", function(f, g)
	local a3 = "mp_ped_interaction"
	local a4 = "hugs_guy_b"
	local a5 = "hugs_guy_a"
	local a6 = 0
	local a7 = 0
	local y = 0
	local a9 = 3000
	local aa = tARMA.GetClosestPlayer(3)
	local ac = GetPlayerServerId(aa)
	if aa ~= nil and (not c()) and GetEntityHealth(GetPlayerPed(aa)) > 102 and d() and canAnim() then
		TriggerServerEvent("ARMA:animationSync", aa, a3, a4, a5, a6, a7, y, ac, a9)
	end
end, false)
RegisterCommand("cowering", function(f, g)
	local a3 = "anim@mp_player_intcelebrationpaired@f_f_cowering"
	local a4 = "cowering_left"
	local a5 = "cowering_right"
	local a6 = 0
	local a7 = 0
	local y = 0
	local a8 = 0
	local a9 = 18000
	controlFlagMe = 0
	controlFlagTarget = 0
	animFlagTarget = 1
	detachFlag = 0
	local aa = tARMA.GetClosestPlayer(3)
	local ac = GetPlayerServerId(aa)
	if aa ~= nil and (not c()) and GetEntityHealth(GetPlayerPed(aa)) > 102 and d() and canAnim() then
		TriggerServerEvent("ARMA:animationSync", aa, a3, a4, a5, a6, a7, y, ac, a9, a8, controlFlagMe, controlFlagTarget, animFlagTarget, detachFlag)
	end
end, false)

RegisterCommand("hug",function(f,g)
    local a3="mp_ped_interaction"
    local a4="kisses_guy_b"
    local a5="kisses_guy_b"
    local a6=1.10
    local a7=-0.1
    local y=0.0
    local a9=3000
    local aa=tARMA.GetClosestPlayer(3)
    local ac=GetPlayerServerId(aa)
	print(tostring(c()),tostring(d()),tostring(canAnim()),tostring(aa),tostring(ac))
    if aa~=nil and not c() and GetEntityHealth(GetPlayerPed(aa))>102 and d()and canAnim()then 
        TriggerServerEvent("ARMA:animationSync",aa,a3,a4,a5,a6,a7,y,ac,a9)
    end 
end,false)
RegisterCommand("kiss",function(f,g)
    local a3="mp_ped_interaction"
    local a4="kisses_guy_a"
    local a5="kisses_guy_a"
    local a6=1.325
    local a7=0.0
    local y=0.0
    local a9=10000
    local aa=tARMA.GetClosestPlayer(3)
    local ac=GetPlayerServerId(aa)
    if aa~=nil and not c()and GetEntityHealth(GetPlayerPed(aa))>102 and d()and canAnim()then 
        TriggerServerEvent("ARMA:animationSync",aa,a3,a4,a5,a6,a7,y,ac,a9)
    end 
end,false)
RegisterCommand("givetake",function(f,g)
    local a3="mp_common"
    local a4="givetake1_a"
    local a5="givetake1_a"
    local a6=0.8
    local a7=0.05
    local y=0.0
    local a9=3000
    local aa=tARMA.GetClosestPlayer(3)
    local ac=GetPlayerServerId(aa)
    if aa~=nil and not c()and GetEntityHealth(GetPlayerPed(aa))>102 and d()and canAnim()then 
        TriggerServerEvent("ARMA:animationSync",aa,a3,a4,a5,a6,a7,y,ac,a9)
    end 
end,false)
RegisterCommand("highfive",function(f,g)
    local a3="mp_ped_interaction"
    local a4="highfive_guy_a"
    local a5="highfive_guy_b"
    local a6=1.2
    local a7=-0.3
    local y=0.0
    local a9=3000
    local aa=tARMA.GetClosestPlayer(3)
    local ac=GetPlayerServerId(aa)
    if aa~=nil and not c()and GetEntityHealth(GetPlayerPed(aa))>102 and d()and canAnim()then 
        TriggerServerEvent("ARMA:animationSync",aa,a3,a4,a5,a6,a7,y,ac,a9)
    end 
end,false)
RegisterCommand("handshake",function(f,g)
    local a3="mp_ped_interaction"
    local a4="handshake_guy_a"
    local a5="handshake_guy_b"
    local a6=1.1
    local a7=-0.04
    local y=0.0
    local a9=3000
    local aa=tARMA.GetClosestPlayer(3)
    local ac=GetPlayerServerId(aa)
    if aa~=nil and not c()and GetEntityHealth(GetPlayerPed(aa))>102 and d()and canAnim()then 
        TriggerServerEvent("ARMA:animationSync",aa,a3,a4,a5,a6,a7,y,ac,a9)
    end 
end,false)
RegisterNetEvent("ARMA:animationSyncTarget")
AddEventHandler("ARMA:animationSyncTarget",function(ac,ad,ae,a6,a7,y,a9,a8,af,animFlagTarget,detachFlag,boneIndex)
    local e=PlayerPedId()
    local ag=GetPlayerPed(GetPlayerFromServerId(ac))
    RequestAnimDict(ad)
    while not HasAnimDictLoaded(ad)do 
        Citizen.Wait(10)
    end
    if a8==nil then 
        a8=180.0 
    end
    AttachEntityToEntity(PlayerPedId(),ag,boneIndex or 0,a7,a6,y,0.5,0.5,a8,false,false,false,false,2,false)
    Wait(500)
    if detachFlag==nil then 
        detachFlag=0 
    end
    if detachFlag==0 then 
        DetachEntity(PlayerPedId(),true,false)
    end
    if af==nil then 
        af=0 
    end
    TaskPlayAnim(e,ad,ae,8.0,-8.0,a9,af,0,false,false,false)
    Citizen.Wait(a9)
    DetachEntity(PlayerPedId(),true,false)
end)

RegisterNetEvent("ARMA:animationSyncMe")
AddEventHandler("ARMA:animationSyncMe",function(ad,ah,a9,af,ai)
    local e=PlayerPedId()
    RequestAnimDict(ad)
    while not HasAnimDictLoaded(ad)do 
        Citizen.Wait(10)
    end
    Wait(500)
    if af==nil then 
        af=0
    end
    TaskPlayAnim(e,ad,ah,8.0,-8.0,a9,af,0,false,false,false) 
end)

RegisterCommand("rope",function(f,g)
    local i="random@burial"
    local j="untie_ped"
    local k=PlayerPedId()
    if DoesEntityExist(k)and canAnim()and not IsEntityDead(k)and d()then 
        loadAnimDict(i)
        if IsEntityPlayingAnim(k,i,j,3)then 
            TaskPlayAnim(k,i,"exit",3.0,1.0,-1,01,0,0,0,0)
            ClearPedSecondaryTask(k)
        else 
            TaskPlayAnim(k,i,j,3.0,1.0,2000,1,0,0,0,0)
            Wait(2000)
            TaskPlayAnim(k,i,j,3.0,1.0,2000,1,0,0,0,0)
            Wait(2000)
            TaskPlayAnim(k,i,j,3.0,1.0,2000,1,0,0,0,0)
            Wait(2000)
            TaskPlayAnim(k,i,j,3.0,1.0,2000,1,0,0,0,0)
            Wait(2000)
            TaskPlayAnim(k,i,j,3.0,1.0,2000,1,0,0,0,0)
            Wait(2000)
            TaskPlayAnim(k,i,j,3.0,1.0,2000,1,0,0,0,0)
            Wait(2000)
            TaskPlayAnim(k,i,j,3.0,1.0,2000,1,0,0,0,0)
            Wait(2000)
            TaskPlayAnim(k,i,j,3.0,1.0,2000,1,0,0,0,0)
            Wait(2000)
            TaskPlayAnim(k,i,j,3.0,1.0,2000,1,0,0,0,0)
            Wait(2000)
            TaskPlayAnim(k,i,j,3.0,1.0,2000,1,0,0,0,0)
            Wait(2000)
            TaskPlayAnim(k,i,j,3.0,1.0,2000,1,0,0,0,0)
            Wait(2000)
            TaskPlayAnim(k,i,j,3.0,1.0,2000,1,0,0,0,0)
            Wait(2000)
            TaskPlayAnim(k,i,j,3.0,1.0,2000,1,0,0,0,0)
            Wait(2000)
            TaskPlayAnim(k,i,j,3.0,1.0,2000,1,0,0,0,0)
            Wait(2000)
            TaskPlayAnim(k,i,j,3.0,1.0,2000,1,0,0,0,0)
            Wait(2000)
            TaskPlayAnim(k,i,j,3.0,1.0,2000,1,0,0,0,0)
            Wait(2000)
            TaskPlayAnim(k,i,j,3.0,1.0,2000,1,0,0,0,0)
            Wait(2000)
            TaskPlayAnim(k,i,j,3.0,1.0,2000,1,0,0,0,0)
            Wait(2000)
            TaskPlayAnim(k,i,j,3.0,1.0,2000,1,0,0,0,0)
        end 
    end
    Wait(5000)
end,false)

Citizen.CreateThread(function()
    while true do 
        if a then 
            DisablePlayerFiring(PlayerId(),true)
        end
        Wait(0)
    end 
end)
exports("canAnim",function()
    return tARMA.canAnim()
end)


local ah = false
RegisterNetEvent("ARMA:startShavingPlayer",function(ai)
	local aj = GetPlayerFromServerId(ai)
	if aj == -1 then
		return
	end
	local ak = GetPlayerPed(aj)
	if ak == 0 then
		return
	end
	tARMA.loadAnimDict("misshair_shop@hair_dressers")
	tARMA.setCanAnim(false)
	local e = PlayerPedId()
	local al = GetOffsetFromEntityInWorldCoords(ak, -0.3, -0.2, 0.0)
	local am = GetEntityHeading(ak)
	SetEntityCoords(e, al.x, al.y, al.z - 1.0, true, false, false)
	SetEntityHeading(e, am)
	SetEntityNoCollisionEntity(e, ak, false)
	SetEntityNoCollisionEntity(ak, e, false)
	tARMA.loadModel("prop_clippers_01")
	local an = CreateObject("prop_clippers_01", al.x, al.y, al.z + 2.0, true, true, false)
	AttachEntityToEntity(an,e,GetPedBoneIndex(e, 6286),0.08,0.0,-0.025,0.0,180.0,-90.0,false,false,false,false,0,true)
	TaskPlayAnim(e, "misshair_shop@hair_dressers", "keeper_hair_cut_a", 8.0, 8.0, -1, 1, 1.0, false, false, false)
	local ao = math.floor(GetAnimDuration("misshair_shop@hair_dressers", "keeper_hair_cut_a") * 1000)
	Citizen.Wait(ao)
	TaskPlayAnim(e, "misshair_shop@hair_dressers", "keeper_hair_cut_b", 8.0, 8.0, -1, 1, 1.0, false, false, false)
	local ap = math.floor(GetAnimDuration("misshair_shop@hair_dressers", "keeper_hair_cut_b") * 1000)
	Citizen.Wait(ap)
	ClearPedTasks(e)
	SetEntityNoCollisionEntity(e, ak, true)
	SetEntityNoCollisionEntity(ak, e, true)
	DeleteEntity(an)
	tARMA.setCanAnim(true)
	RemoveAnimDict("misshair_shop@hair_dressers")
	SetModelAsNoLongerNeeded("prop_clippers_01")
end)

RegisterNetEvent("ARMA:startBeingShaved",function(aq)
	local ar = GetPlayerFromServerId(aq)
	if ar == -1 then
		return
	end
	local as = GetPlayerPed(ar)
	if as == 0 then
		return
	end
	tARMA.setCanAnim(false)
	i = false
	local e = PlayerPedId()
	FreezeEntityPosition(e, true)
	local at = GetGameTimer()
	while GetGameTimer() - at < 15500 do
		if not IsEntityPlayingAnim(e, "random@arrests@busted", "idle_a", 3) then
			TaskPlayAnim(e, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, false, false, false)
		end
		Citizen.Wait(0)
	end
	SetPedComponentVariation(e, 2, 0, 0, 0)
	FreezeEntityPosition(e, false)
	i = true
	tARMA.setCanAnim(true)
	ah = true
	Citizen.Wait(1800000)
	ah = false
end)

RegisterNetEvent("ARMA:playDelayedShave",function(au)
	local av = GetPlayerFromServerId(au)
	if av == -1 then
		return
	end
	local ab = GetPlayerPed(av)
	if ab == 0 then
		return
	end
	local aw = tARMA.getPlayerCoords()
	local ax = GetEntityCoords(ab, true)
	if #(aw - ax) < 15.0 then
		SendNUIMessage({transactionType = "shave"})
	end
end)

RegisterNetEvent("ARMA:setAsShaved",function(ay)
	ah = true
	Citizen.Wait(ay)
	ah = false
end)

local function az(aA)
    if ah and GetPedDrawableVariation(aA.playerPed, 2) ~= 0 then
        SetPedComponentVariation(aA.playerPed, 2, 0, 0, 0)
    end
end
tARMA.createThreadOnTick(az)
