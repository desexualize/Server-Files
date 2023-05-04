local a=false
local b={}
local c={}
local d={
    [1]={pos=vector3(392.93579101563,-986.09350585938,29.536422729492),model='vw_prop_vw_colle_alien'},
    [2]={pos=vector3(247.11929321289,-578.48358154297,42.299430847168),model='vw_prop_vw_colle_prbubble'},
    [3]={pos=vector3(-336.10382080078,-640.97827148438,32.037563323975),model='vw_prop_vw_colle_pogo'},
    [4]={pos=vector3(-1184.8115234375,-906.0458984375,12.372309684753),model='vw_prop_vw_colle_rsrcomm'},
    [5]={pos=vector3(-1051.8314208984,-232.25430297852,43.020919799805),model='vw_prop_vw_colle_rsrgeneric'},
    [6]={pos=vector3(-538.68109130859,-193.47421264648,38.119552612305),model='vw_prop_vw_colle_alien'},
    [7]={pos=vector3(-930.13494873047,-2993.6242675781,19.789463043213),model='vw_prop_vw_colle_prbubble'},
    [8]={pos=vector3(1935.5562744141,3726.4650878906,32.188140869141),model='vw_prop_vw_colle_pogo'},
    [9]={pos=vector3(-717.65002441406,-913.67077636719,18.215608596802),model='vw_prop_vw_colle_rsrcomm'},
    [10]={pos=vector3(-284.27319335938,-1053.9976806641,26.654722213745),model='vw_prop_vw_colle_rsrgeneric'},
    [11]={pos=vector3(483.16397094727,-1339.3645019531,28.278081893921),model='vw_prop_vw_colle_pogo'},
    [12]={pos=vector3(-99.920829772949,-947.30096435547,28.229970932007),model='vw_prop_vw_colle_rsrgeneric'},
    [13]={pos=vector3(373.99819946289,-1606.9119873047,28.291959762573),model='vw_prop_vw_colle_alien'},
    [14]={pos=vector3(-587.09893798828,-1165.7362060547,21.178253173828),model='vw_prop_vw_colle_prbubble'},
    [15]={pos=vector3(-1626.2829589844,-1018.3368530273,12.155345916748),model='vw_prop_vw_colle_rsrcomm'},
    [16]={pos=vector3(-3132.431640625,1131.8603515625,19.680768966675),model='vw_prop_vw_colle_alien'},
    [17]={pos=vector3(-2562.8999023438,2317.546875,32.215717315674),model='vw_prop_vw_colle_rsrgeneric'},
    [18]={pos=vector3(230.39883422852,224.70484924316,104.54831695557),model='vw_prop_vw_colle_alien'},
    [19]={pos=vector3(905.97821044922,18.552291870117,78.375137329102),model='vw_prop_vw_colle_prbubble'},
    [20]={pos=vector3(1557.4967041016,860.82165527344,76.473602294922),model='vw_prop_vw_colle_alien'},
    [21]={pos=vector3(1848.5529785156,2587.6628417969,44.671993255615),model='vw_prop_vw_colle_alien'},
    [22]={pos=vector3(2302.3393554688,2981.6733398438,45.806644439697),model='vw_prop_vw_colle_prbubble'},
    [23]={pos=vector3(1742.3250732422,3302.8342285156,40.223453521729),model='vw_prop_vw_colle_pogo'},
    [24]={pos=vector3(350.86264038086,2619.9438476562,43.600082397461),model='vw_prop_vw_colle_rsrcomm'},
    [25]={pos=vector3(-747.77868652344,5545.8671875,32.485664367676),model='vw_prop_vw_colle_rsrgeneric'},
    [26]={pos=vector3(-442.49362182617,6017.1508789062,30.712348937988),model='vw_prop_vw_colle_alien'},
    [27]={pos=vector3(-245.95056152344,6327.4321289062,31.869472503662),model='vw_prop_vw_colle_prbubble'},
    [28]={pos=vector3(1577.0767822266,6455.2509765625,24.31717300415),model='vw_prop_vw_colle_pogo'},
    [29]={pos=vector3(2450.9826660156,4953.48828125,43.957180023193),model='vw_prop_vw_colle_rsrcomm'},
    [30]={pos=vector3(2492.4990234375,2812.8896484375,46.532741546631),model='vw_prop_vw_colle_rsrgeneric'},
    [31]={pos=vector3(-280.50592041016,-1916.3929443359,28.946022033691),model='vw_prop_vw_colle_pogo'},
    [32]={pos=vector3(-518.56939697266,-1792.3686523438,21.099979400635),model='vw_prop_vw_colle_rsrgeneric'},
    [33]={pos=vector3(-709.15539550781,-1397.8522949219,4.1502599716187),model='vw_prop_vw_colle_alien'},
    [34]={pos=vector3(-827.82318115234,-1087.1162109375,10.13264465332),model='vw_prop_vw_colle_prbubble'},
    [35]={pos=vector3(-935.89593505859,-1304.1628417969,4.0186438560486),model='vw_prop_vw_colle_rsrcomm'},
    [36]={pos=vector3(-1471.8054199219,-924.53765869141,9.113266944885),model='vw_prop_vw_colle_alien'},
    [37]={pos=vector3(-1663.7991943359,-537.11877441406,36.257522583008),model='vw_prop_vw_colle_rsrgeneric'},
    [38]={pos=vector3(-2158.3444824219,-416.31286621094,12.368584632874),model='vw_prop_vw_colle_alien'},
    [39]={pos=vector3(-2022.1680908203,-495.98376464844,10.743299484253),model='vw_prop_vw_colle_prbubble'},
    [40]={pos=vector3(-1094.8052978516,-507.29995727539,34.813873291016),model='vw_prop_vw_colle_alien'},
    [41]={pos=vector3(1068.6545410156,2992.6599121094,42.332332611084),model='vw_prop_vw_colle_alien'},
    [42]={pos=vector3(395.68112182617,3585.9650878906,32.292282104492),model='vw_prop_vw_colle_alien'},
    [43]={pos=vector3(503.8893737793,5599.2392578125,795.4970703125),model='vw_prop_vw_colle_alien'},
    [44]={pos=vector3(1465.5445556641,6349.1694335938,22.857103347778),model='vw_prop_vw_colle_alien'},
    [45]={pos=vector3(2111.3044433594,6019.9760742188,49.906005859375),model='vw_prop_vw_colle_alien'},
    [46]={pos=vector3(3456.9736328125,3765.58984375,29.533452987671),model='vw_prop_vw_colle_alien'},
    [47]={pos=vector3(-2291.5236816406,366.84359741211,174.6015625),model='vw_prop_vw_colle_alien'},
    [48]={pos=vector3(857.33612060547,532.96740722656,124.78028106689),model='vw_prop_vw_colle_alien'},
    [49]={pos=vector3(1215.8714599609,-279.23986816406,69.98380279541),model='vw_prop_vw_colle_alien'},
    [50]={pos=vector3(1170.8679199219,-1463.484375,33.888477325439),model='vw_prop_vw_colle_alien'}
}
local function e()
    tARMA.loadAnimDict("anim@mp_player_intcelebrationfemale@air_guitar")
    TaskPlayAnim(PlayerPedId(),"anim@mp_player_intcelebrationfemale@air_guitar","air_guitar",8.0,-8.0,-1,0,0.0,0,0,0)
end
local function f(g,h)
    AddTextEntry('instructionalText',g)
    SetFloatingHelpTextWorldPosition(1,h)
    SetFloatingHelpTextStyle(1,1,2,-1,3,0)
    BeginTextCommandDisplayHelp('instructionalText')
    AddTextComponentSubstringPlayerName(g)
    EndTextCommandDisplayHelp(2,false,false,-1)
end
local function i()
    local j=0
    for k in pairs(c)do 
        j=j+1 
    end
    if j==0 then 
        a=true
        SetResourceKvpInt("ARMA_quests_completedall",1)
        TriggerServerEvent("ARMA:claimQuestReward") -- this needs to be done for adding plat days
    end
    return a 
end
local function l()
    hasCompletedAllQuestsInt=GetResourceKvpInt("ARMA_quests_completedall")
    if not hasCompletedAllQuestsInt then 
        SetResourceKvpInt("ARMA_quests_completedall",0)
    end
    if hasCompletedAllQuestsInt==0 then 
        for m=1,50 do 
            local n=GetResourceKvpInt("ARMA_quests_q"..m.."_status")
            if not n then 
                SetResourceKvpInt("ARMA_quests_q"..m.."_status",0)
                n=0 
            end
            if n==0 then 
                c[m]=true 
            end 
        end 
    else a=true 
    end 
end
local function o(p)
    c[p]=nil
    SetResourceKvpInt("ARMA_quests_q"..p.."_status",1)
    i()
    TriggerServerEvent("ARMA:setQuestCompleted")
end
local function q()
    local j=50
    for k in pairs(c)do 
        j=j-1 
    end
    return j 
end
local function r(s,t,u)
    local v=RequestScaleformMovie("mp_big_message_freemode")
    while not HasScaleformMovieLoaded(v)do 
        Wait(0)
    end
    Citizen.CreateThread(function()
        local m=0
        while m<u do 
            Wait(0)
            BeginScaleformMovieMethod(v,"SHOW_SHARD_WASTED_MP_MESSAGE")
            ScaleformMovieMethodAddParamTextureNameString(s)
            ScaleformMovieMethodAddParamTextureNameString(t)
            ScaleformMovieMethodAddParamInt(5)
            EndScaleformMovieMethod()
            DrawScaleformMovieFullscreen(v,255,255,255,255)
            m=m+1 
        end 
    end)
end
Citizen.CreateThread(function()
    l()
    Wait(2500)
    for w,k in pairs(c)do 
        undiscoveredQ=d[w]
        local x=function(y)
            if not b[y.undiscoveredQID]then 
                if not DoesEntityExist(b[y.undiscoveredQID])then 
                    b[y.undiscoveredQID]=CreateObject(y.undiscoveredQ.model,y.undiscoveredQ.pos.x,y.undiscoveredQ.pos.y,y.undiscoveredQ.pos.z,false,true,false)
                    FreezeEntityPosition(b[y.undiscoveredQID],true)
                    SetEntityAlpha(b[y.undiscoveredQID],210)
                    SetEntityCollision(b[y.undiscoveredQID],false)
                end 
            end 
        end
        local z=function()
            DeleteObject(b[w])
            b[w]=nil
        end
        local A=function(y)
            if c[y.undiscoveredQID]then 
                DrawLightWithRangeAndShadow(y.undiscoveredQ.pos.x,y.undiscoveredQ.pos.y,y.undiscoveredQ.pos.z,52,235,55,30.0,0.5,1.0)
            end 
        end
        tARMA.createArea("quests_prop_id_"..w,undiscoveredQ.pos,100.0,6,x,z,A,{undiscoveredQID=w,undiscoveredQ=undiscoveredQ})
        local B=function()
        end
        local C=function()
        end
        local A=function(y)
            local D=vector3(y.undiscoveredQ.pos.x,y.undiscoveredQ.pos.y,y.undiscoveredQ.pos.z+0.2)
            if c[y.undiscoveredQID]then 
                f("Press [E] to collect.",D)
            end
            if IsControlJustReleased(0,38)then 
                o(y.undiscoveredQID)
                DeleteEntity(b[y.undiscoveredQID])
                e()
                if q()~=50 then 
                    r("Collected ~y~"..q().."/50","Collect them all to win a prize!",600)
                    PlaySoundFrontend(-1,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS",1)
                    ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE",1.0)
                    AnimpostfxPlay("SuccessMichael",0,0)
                    Wait(4000)
                    DoScreenFadeOut(1000)
                    Wait(1000)
                    AnimpostfxStop("SuccessMichael")
                    StopGameplayCamShaking(true)
                    DoScreenFadeIn(2000)
                    tARMA.removeArea("quests_prop_id_"..y.undiscoveredQID)
                    tARMA.removeArea("quests_text_id_"..y.undiscoveredQID)
                else 
                    r("~g~+7 Days ARMA Club Platinum","You collected them all!",600)
                    PlaySoundFrontend(-1,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS",1)
                    ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE",1.0)
                    AnimpostfxPlay("DMT_flight",0,0)
                    Wait(4000)
                    DoScreenFadeOut(1000)
                    Wait(1000)
                    AnimpostfxStop("DMT_flight")
                    StopGameplayCamShaking(true)
                    DoScreenFadeIn(2000)
                end 
            end 
        end
        tARMA.createArea("quests_text_id_"..w,undiscoveredQ.pos,2.0,6,B,C,A,{undiscoveredQ=undiscoveredQ,undiscoveredQID=w})
    end 
end)
Citizen.CreateThread(function()
    Wait(5000)
    while true do 
        Citizen.Wait(0)
        for E,k in pairs(b)do 
            if DoesEntityExist(b[E])then 
                SetEntityHeading(b[E],GetEntityHeading(b[E])+1%360)
            end 
        end 
    end 
end)
RegisterCommand("collectiblesremaining",function()
    local F=table.count(c)
    r("~y~You have "..F.." collectibles remaining.","Collect them all to win a prize!",200)
    i()
end)