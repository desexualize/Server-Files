TriggerEvent('chat:addSuggestion','/dl','Manage your driving licence and book a test')
RMenu.Add('dvsa','main',RageUI.CreateMenu("","Driver & Vehicle Standards Agency", tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(), "banners", "dvsa"))
RMenu.Add('dvsa','licence',RageUI.CreateSubMenu(RMenu:Get('dvsa','main'),"","DVSA: ~b~Driving Licence", tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight()))
RMenu.Add('dvsa','tests',RageUI.CreateSubMenu(RMenu:Get('dvsa','main'),"","DVSA: ~b~Driving Tests", tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight()))
RMenu.Add('dvsa','alerts',RageUI.CreateSubMenu(RMenu:Get('dvsa','main'),"","DVSA: ~b~Alerts", tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight()))
local a={}
local b={}
local c={}
local d={}
local e={active=false,vehicle=0,handle=0,handle2=0}
local f=false
local g=false
local h=false
currentTest={active=false,ped=0,vehicle=0,parkingSpace=0,route=0,waypoint=0,blip=0,serious=0,minors=0,minorsReason={},seriousReason={},subtitle=""}
local i=module("cfg/cfg_dvsa")
tARMA.addMarker(i.test.reception.x,i.test.reception.y,i.test.reception.z-0.96,1.2,1.2,1.2,0,255,125,125,50,27,true,false,false,nil,nil,0.0,0.0,0.0)
local j=tARMA.addBlip(i.test.reception.x,i.test.reception.y,i.test.reception.z,523,47,"DVSA Test Centre",1.0,false)
local k=function()
    RageUI.ActuallyCloseAll()
    g=true
    RageUI.Visible(RMenu:Get('dvsa','licence'),false)
    RageUI.Visible(RMenu:Get('dvsa','tests'),false)
    RageUI.Visible(RMenu:Get('dvsa','alerts'),false)
    RageUI.Visible(RMenu:Get('dvsa','main'),true)
end
local l=function()
    RageUI.Visible(RMenu:Get('dvsa','main'),false)
    g=false
    RageUI.ActuallyCloseAll()
end
local m=function()
end
tARMA.createArea("dvsaTestCentre_",i.test.reception,1.5,6,k,l,m,{})
RegisterNetEvent("ARMA:dvsaData",function(n,o,p,q)
    h=true
    a=n
    b=o
    c=p
    d=q
    for r,s in pairs(i.peds)do 
        if not s.eup then 
            local t=vector3(s.coords.x,s.coords.y,s.coords.z-1.02)
            local ped=tARMA.createDynamicPed(s.model,t,s.heading,true,"mini@strip_club@idles@bouncer@base","base",30,false,nil)
        end 
    end
    tARMA.loadModel(i.models.camera)
    for r,s in pairs(i.cameras)do 
        i.cameras[r].prop=CreateObject(i.models.camera,s.coords.x,s.coords.y,s.coords.z,false,false,false)
        while not DoesEntityExist(i.cameras[r].prop)do 
            Wait(0)
        end
        PlaceObjectOnGroundProperly(i.cameras[r].prop)
        SetEntityHeading(i.cameras[r].prop,s.heading)
        FreezeEntityPosition(i.cameras[r].prop,true)
        i.cameras[r].flashed=false
        i.cameras[r].offSet=GetOffsetFromEntityInWorldCoords(i.cameras[r].prop,0.0,7.0,0.5)
        local u,v=GetGroundZFor_3dCoord(i.cameras[r].offSet.x,i.cameras[r].offSet.y,i.cameras[r].offSet.z,0)
        i.cameras[r].offSet=vector3(i.cameras[r].offSet.x,i.cameras[r].offSet.y,v+0.2)
    end 
end)
RegisterNetEvent("ARMA:updateDvsaData",function(n,o,p,q)
    if n~=nil then 
        a=n 
    end
    if o~=nil then 
        b=o 
    end
    if p~=nil then 
        c=p 
    end
    if q~=nil then 
        d=q 
    end 
end)
RegisterNetEvent("ARMA:dvsaMessage",function(w,x,y)
    tARMA.notifyPicture(i.images.dict,i.images.govLarge,y,w,x)
end)
RegisterNetEvent("ARMA:beginTestClient",function(z,A)
    if z then 
        TriggerServerEvent("ARMA:dvsaBucket",false)
        currentTest={active=false,ped=0,vehicle=0,parkingSpace=0,route=0,waypoint=0,blip=0,serious=0,minors=0,minorsReason={},seriousReason={},subtitle=""}
        currentTest.active=true
        currentTest.parkingSpace=A
        phoneToggled=false
        currentTest.serious=0
        currentTest.seriousIssued=false
        currentTest.minors=0
        Wait(1000)
        currentTest.vehicle=tARMA.spawnVehicle(i.test.modelName,i.test.parkingSpaces[A].coords.x,i.test.parkingSpaces[A].coords.y,i.test.parkingSpaces[A].coords.z,i.test.parkingSpaces[A].heading,true,true)
        FreezeEntityPosition(currentTest.vehicle,true)
        SetVehicleDirtLevel(currentTest.vehicle,0)
        SetVehicleRadioEnabled(currentTest.vehicle,false)
        cameraTransition(i.test.parkingSpaces[A].coords)
        local B=tARMA.loadModel(i.test.examinerModel)
        currentTest.ped=CreatePed(26,B,218.611,-1390.879,30.57727,321.37,false,true)
        while not DoesEntityExist(currentTest.ped)do 
            Wait(0)
        end
        SetEntityCanBeDamaged(currentTest.ped,0)
        SetPedAsEnemy(currentTest.ped,0)
        SetBlockingOfNonTemporaryEvents(currentTest.ped,1)
        SetPedCanRagdollFromPlayerImpact(currentTest.ped,0)
        TaskGoToEntity(currentTest.ped,currentTest.vehicle,10.0,2.0,5.0,false,false)
        TaskGoToCoordAnyMeans(ped,i.test.parkingSpaces[A].coords.x,i.test.parkingSpaces[A].coords.y,i.test.parkingSpaces[A].coords.z,6.0,false,false,786603,1.0)
        SetVehicleEngineOn(currentTest.vehicle,false,true,true)
        SetVehicleHasMutedSirens(currentTest.vehicle,true)
        SetVehicleLightsMode(currentTest.vehicle,0)
        Wait(9000)
        TriggerEvent("arma:PlaySound", "welcomedvsa")
        currentTest.subtitle="Hey! I'm ~y~Lloyd Shettle"
        tARMA.notifyPicture(i.images.dict,i.images.govLarge,"Your assigned examiner for the test is Lloyd.","DVSA","UK Government")
        tARMA.loadAnimDict("amb@medic@standing@tendtodead@base")
        TaskPlayAnim(currentTest.ped,"amb@medic@standing@tendtodead@base","base",8.0,0.0,-1,1,0,0,0,0)
        Wait(5000)
        currentTest.subtitle="I am a ~b~driving examiner~w~ for the ~b~DVSA"
        currentTest.subtitle="I'm just inspecting your vehicle"
        Wait(5000)
        currentTest.subtitle="Thanks for your patience, we'll start shortly"
        Wait(7000)
        currentTest.subtitle="Your vehicle is ~g~suitable ~w~for the test"
        Wait(5000)
        currentTest.subtitle="I will now enter the vehicle"
        ClearPedTasksImmediately(currentTest.ped)
        TaskEnterVehicle(currentTest.ped,currentTest.vehicle,10.0,0,5.0,0,0)
        Wait(4000)
        tARMA.notifyPicture(i.images.dict,i.images.govLarge,"You'll now be given information about the test, listen carefully","DVSA","UK Government")
        initialMoveOff()
    else 
        tARMA.notifyPicture(i.images.dict,i.images.govLarge,"We currently have no test availability, please try again shortly.","Callum","Driving Examiner")
        SetTimeout(20000,function()
            currentTest.requested=false 
        end)
    end 
end)
function initialMoveOff()
    TriggerEvent("arma:PlaySound", "testExplained")
    for r in pairs(i.notifications.testStartMessages)do 
        currentTest.subtitle=i.notifications.testStartMessages[r]
        Wait(4000)
    end
    currentTest.route=math.random(1,#(i.test.routes))
    SetVehicleEngineOn(currentTest.vehicle,true,true,false)
    FreezeEntityPosition(currentTest.vehicle,false)
    Wait(2000)
    currentTest.subtitle="~y~Move off ~w~when you are ready, carrying out good, all round observations"
    handleTestRoute()
end
function handleTestRoute()
    local C=false
    currentTest.blip=tARMA.addBlip(i.test.routes[currentTest.route][currentTest.waypoint+1].coords.x,i.test.routes[currentTest.route][currentTest.waypoint+1].coords.y,i.test.routes[currentTest.route][currentTest.waypoint+1].coords.z,0,38,"Waypoint",1.0,false)
    SetBlipRoute(currentTest.blip,true)
    SetBlipRouteColour(currentTest.blip,38)
    i.test.routes[currentTest.route][currentTest.waypoint+1].speeding=false
    currentTest.marker=tARMA.addMarker(i.test.routes[currentTest.route][currentTest.waypoint+1].coords.x,i.test.routes[currentTest.route][currentTest.waypoint+1].coords.y,i.test.routes[currentTest.route][currentTest.waypoint+1].coords.z,1.6,1.6,1.6,0,89,255,200,50,36,true,true)
    currentTest.subtitle="Follow the ~y~sat nav"
    Wait(2000)
    while currentTest.active do 
        if not C then 
            local D=i.images.speed30
            if i.test.routes[currentTest.route][currentTest.waypoint+1].limit==30.0 then 
                D=i.images.speed30 
            end
            if i.test.routes[currentTest.route][currentTest.waypoint+1].limit==40.0 then 
                D=i.images.speed40 
            end
            if i.test.routes[currentTest.route][currentTest.waypoint+1].limit==60.0 then 
                D=i.images.speed60 
            end
            if i.test.routes[currentTest.route][currentTest.waypoint+1].limit==70.0 then 
                D=i.images.speed70 
            end
            if not HasStreamedTextureDictLoaded(i.images.dict)then 
                RequestStreamedTextureDict(i.images.dict)
                while not HasStreamedTextureDictLoaded(i.images.dict)do 
                    Wait(0)
                end 
            end
            DrawSprite(i.images.dict,D,0.950,0.77,0.052,0.09,0.05,255,255,255,255)
            local E=#(tARMA.getPlayerCoords()-i.test.routes[currentTest.route][currentTest.waypoint+1].coords)
            local F=GetEntitySpeed(currentTest.vehicle)*2.236936
            if F>i.test.routes[currentTest.route][currentTest.waypoint+1].limit+19.0 then 
                if not i.test.routes[currentTest.route][currentTest.waypoint+1].speeding then 
                    issueMinor("Speeding")
                    i.test.routes[currentTest.route][currentTest.waypoint+1].speeding=true 
                else 
                    if F>i.test.routes[currentTest.route][currentTest.waypoint+1].limit+85.0 then 
                        issueSerious("Speeding")
                        TriggerEvent("arma:PlaySound", "slowDownOrTermination")
                        currentTest.subtitle="You ~r~must ~w~slow down, or risk the test being terminated immediately"
                        currentTest.subtitle="Follow the ~y~sat nav"
                    end 
                end 
            end
            if E<3.5 then 
                currentTest.waypoint=currentTest.waypoint+1
                if currentTest.waypoint>=#(i.test.routes[currentTest.route])then 
                    C=true
                    if currentTest.blip~=0 then 
                        tARMA.removeBlip(currentTest.blip)
                    end
                    if currentTest.marker~=0 then 
                        tARMA.removeMarker(currentTest.marker)
                    end
                    returnToTestCentre()
                else 
                    if currentTest.blip~=0 and currentTest.blip~=0 then 
                        tARMA.removeBlip(currentTest.blip)
                    end
                    currentTest.blip=tARMA.addBlip(i.test.routes[currentTest.route][currentTest.waypoint+1].coords.x,i.test.routes[currentTest.route][currentTest.waypoint+1].coords.y,i.test.routes[currentTest.route][currentTest.waypoint+1].coords.z,0,38,"Waypoint",1.0,false)
                    SetBlipRoute(currentTest.blip,true)
                    SetBlipRouteColour(currentTest.blip,38)
                    if currentTest.marker~=0 and currentTest.marker~=nil then 
                        tARMA.removeMarker(currentTest.marker)
                    end
                    currentTest.marker=tARMA.addMarker(i.test.routes[currentTest.route][currentTest.waypoint+1].coords.x,i.test.routes[currentTest.route][currentTest.waypoint+1].coords.y,i.test.routes[currentTest.route][currentTest.waypoint+1].coords.z,1.6,1.6,1.6,0,89,255,200,50,36,true,true)
                    i.test.routes[currentTest.route][currentTest.waypoint+1].speeding=false
                    Citizen.CreateThread(function()
                        i.test.routes[currentTest.route][currentTest.waypoint].action(currentTest)
                        currentTest.subtitle="Follow the ~y~sat nav"
                    end)
                end 
            end 
        end
        Wait(0)
    end 
end
function policeChase()
    TriggerEvent("arma:PlaySound", "policePursuitContinue")
    tARMA.notifyPicture(i.images.dict,i.images.govLarge,"You are required to ~b~move over ~w~to allow a police pursuit to continue.","DVSA","UK Government")
    currentTest.subtitle="Move ~y~over"
    local G='blista'
    tARMA.loadModel(G)
    local H=vector3(113.0901,-1226.426,37.60364)
    local I=tARMA.spawnVehicle(G,H,270.93,false,true)
    while not DoesEntityExist(I)do 
        Wait(0)
    end
    SetModelAsNoLongerNeeded(G)
    local J='a_f_y_business_02'
    tARMA.loadModel(J)
    local K=CreatePed(4,J,H,270.93,true)
    while not DoesEntityExist(K)do 
        Wait(0)
    end
    SetEntityInvincible(K,true)
    SetPedAlertness(K,0.0)
    TaskWarpPedIntoVehicle(K,I,-1)
    SetVehicleEngineOn(I,true,true,false)
    while not IsPedInVehicle(K,I)do 
        Wait(0)
    end
    local L=vector3(816.9495,-1216.404,45.8938)
    TaskVehicleDriveToCoord(K,I,L.x,L.y,L.z,60.0,1.0,G,786472,1.0,true)
    Wait(2000)
    local M='incidentsupportunit'
    if not IsModelValid(M)then 
        M='policet'
    end
    tARMA.loadModel(M)
    local N=tARMA.spawnVehicle(M,H,270.93,false,true)
    while not DoesEntityExist(N)do 
        Wait(0)
    end
    SetModelAsNoLongerNeeded(M)
    local O='s_m_y_airworker'
    tARMA.loadModel(O)
    local P=CreatePed(4,O,H,270.93,true)
    while not DoesEntityExist(P)do 
        Wait(0)
    end
    SetEntityInvincible(P,true)
    SetPedAlertness(P,0.0)
    TaskWarpPedIntoVehicle(P,N,-1)
    SetVehicleEngineOn(N,true,true,false)
    while not IsPedInVehicle(P,N)do 
        Wait(0)
    end
    local Q=GetSoundId()
    PlaySoundFromEntity(Q,"VEHICLES_HORNS_SIREN_1",N,0,0,0)
    TaskVehicleDriveToCoord(P,N,L.x,L.y,L.z,70.0,1.0,M,786472,1.0,true)
    Citizen.SetTimeout(30000,function()
        if DoesEntityExist(I)then 
            DeleteEntity(I)
        end
        if DoesEntityExist(K)then 
            DeleteEntity(K)
        end
        if DoesEntityExist(N)then 
            DeleteEntity(N)
        end
        if DoesEntityExist(P)then 
            DeleteEntity(P)
        end
        StopSound(Q)
        ReleaseSoundId(Q)
    end)
end
function returnToTestCentre()
    local R=GetVehicleEngineHealth(currentTest.vehicle)
    if R<700.0 then 
        issueSerious("Vehicle Collision")
    end
    local S=true
    if currentTest.serious>0 or currentTest.minors>15 or currentTest.seriousIssued then 
        S=false 
    end
    currentTest.blip=tARMA.addBlip(i.test.parkingSpaces[currentTest.parkingSpace].coords.x,i.test.parkingSpaces[currentTest.parkingSpace].coords.y,i.test.parkingSpaces[currentTest.parkingSpace].coords.z,0,81,"Waypoint",1.0,false)
    currentTest.marker=tARMA.addMarker(i.test.parkingSpaces[currentTest.parkingSpace].coords.x,i.test.parkingSpaces[currentTest.parkingSpace].coords.y,i.test.parkingSpaces[currentTest.parkingSpace].coords.z,1.2,1.2,1.2,0,255,125,125,50,0,true,true)
    SetBlipRoute(currentTest.blip,true)
    SetBlipRouteColour(currentTest.blip,38)
    TriggerEvent("arma:PlaySound", "newDestinationSet")
    currentTest.subtitle="I've set a ~y~new sat nav destination~w~, please follow it"
    Wait(4000)
    currentTest.subtitle="Follow the ~y~sat nav"
    local T=false
    while true do 
        local E=#(tARMA.getPlayerCoords()-i.test.parkingSpaces[currentTest.parkingSpace].coords)
        if E<15.0 then 
            currentTest.subtitle="Park up at the ~y~waypoint"
            break 
        end
        Wait(0)
    end
    finishTest(S)
end
function finishTest(S)
    currentTest.subtitle="Park up ~y~safely"
    while not GetEntitySpeed(currentTest.vehicle)==0.0 do 
        Wait(0)
    end
    Wait(6000)
    if not GetEntitySpeed(currentTest.vehicle)==0.0 then 
        while not GetEntitySpeed(currentTest.vehicle)==0.0 do 
            Wait(0)
        end 
    end
    Wait(3000)
    if not GetEntitySpeed(currentTest.vehicle)==0.0 then 
        while not GetEntitySpeed(currentTest.vehicle)==0.0 do 
            Wait(0)
        end 
    end
    useTablet()
    TriggerEvent("arma:PlaySound", "completePaperwork")
    currentTest.subtitle="Please wait whilst I finish my ~y~paperwork"
    SetVehicleEngineOn(vehicle,false,true,true)
    FreezeEntityPosition(currentTest.vehicle,true)
    Wait(10000)
    local U=""
    local V=""
    if S then 
        TriggerEvent("arma:PlaySound", "testPassed")
        tARMA.notifyPicture(i.images.dict,i.images.govLarge,"You ~b~passed your test with ~y~"..currentTest.minors.." ~w~minors","UK Government","DVSA")
        currentTest.subtitle="Congratulations, you have ~g~passed ~w~your driving test with ~y~"..currentTest.minors.." ~w~minors"
        Wait(6000)
        currentTest.subtitle="This is only the beginning to becoming a ~b~safe ~w~and ~b~confident driver"
        Wait(4000)
        TriggerEvent("arma:PlaySound", "testPassedGoodbye")
        currentTest.subtitle="I would like to add you drove very well and I wish you the best of luck in the future"
        Wait(4000)
        currentTest.subtitle="See you around!"
    else 
        TriggerEvent("arma:PlaySound", "testFailed")
        tARMA.notifyPicture(i.images.dict,i.images.govLarge,"Unfortunately you have ~r~failed your test","UK Government","DVSA")
        currentTest.subtitle="Unfortunately you have ~y~failed ~w~your driving test"
        Wait(6000)
        tARMA.notifyPicture(i.images.dict,i.images.govLarge,"Your ~r~serious ~w~faults were:","UK Government","DVSA")
        Wait(3000)
        TriggerEvent("arma:PlaySound", "seriousFaults")
        for r,s in pairs(currentTest.seriousReason)do 
            V=V..", "..currentTest.seriousReason[r]
            tARMA.notify("~r~Serious Fault~w~: "..currentTest.seriousReason[r])
            Wait(500)
        end
        tARMA.notifyPicture(i.images.dict,i.images.govLarge,"Your ~y~minor ~w~faults were:","UK Government","DVSA")
        Wait(3000)
        TriggerEvent("arma:PlaySound", "minorFaults")
        for r,s in pairs(currentTest.minorsReason)do 
            U=U..", "..currentTest.minorsReason[r]
            tARMA.notify("~y~Minor Fault~w~: "..currentTest.minorsReason[r])
            Wait(500)
        end
        Wait(4000)
        TriggerEvent("arma:PlaySound", "testFailedGoodbye")
        currentTest.subtitle="We do not fail a candidate lightly and we hope you have the ~b~determination ~w~to improve"
        Wait(4000)
        currentTest.subtitle="I wish you the best of luck in the future and I look forward to seeing you next time"
        Wait(4000)
        currentTest.subtitle="Goodbye!"
        Wait(4000)
    end
    Wait(5000)
    DeleteEntity(currentTest.vehicle)
    DeleteEntity(currentTest.ped)
    if tARMA.teleport~=nil then 
        tARMA.teleport(i.test.finishTestTpCoords.x,i.test.finishTestTpCoords.y,i.test.finishTestTpCoords.z)
    end
    Wait(3000)
    SetTimeout(20000,function()
        currentTest.requested=false 
    end)
    TriggerServerEvent("ARMA:dvsaBucket",true)
    if S then 
        TriggerServerEvent("ARMA:candidatePassed",currentTest.serious,currentTest.minors,U)
        currentTest.active=false 
    else 
        TriggerServerEvent("ARMA:candidateFailed",currentTest.serious,currentTest.minors,V,U)
        currentTest.active=false 
    end
    if currentTest.blip~=0 then 
        tARMA.removeBlip(currentTest.blip)
    end
    if currentTest.marker~=0 then 
        tARMA.removeMarker(currentTest.marker)
    end
    ClearGpsPlayerWaypoint()
end
function issueSerious(W)
    table.insert(currentTest.seriousReason,W)
    currentTest.seriousIssued=true
    currentTest.serious=currentTest.serious+1
    useTablet()
end
function issueMinor(W)
    table.insert(currentTest.minorsReason,W)
    currentTest.minors=currentTest.minors+1
    local X=0
    for r in pairs(currentTest.minorsReason)do 
        if currentTest.minorsReason[r]=="Speeding"then 
            X=X+1 
        end 
    end
    if X==4 then 
        issueSerious("Speeding")
    else 
        useTablet()
    end 
end
local phoneToggled=false
RegisterNetEvent("ARMA:phoneToggledDvsa",function()
    if currentTest.active then 
        if not phoneToggled then 
            issueSerious("Used mobile phone")
            phoneToggled=true 
        end 
    end 
end)
function pullUpOnRight()
    PlaySoundFrontend(-1,"Out_Of_Bounds_Timer","DLC_HEISTS_GENERAL_FRONTEND_SOUNDS",1)
    tARMA.notifyPicture(i.images.dict,i.images.govLarge,"Listen carefully for directions","Controlled Stop","DVSA")
    local T=false
    local Y=false
    TriggerEvent("arma:PlaySound", "controlledStop")
    currentTest.subtitle="We will soon carry out a ~b~controlled stop"
    Wait(4000)
    currentTest.subtitle="When it is safe to do so, ~y~pull up ~w~and park safely ~y~on the right hand side ~w~of the road."
    SetTimeout(20000,function()
        T=true 
    end)
    while not T do 
        if GetEntitySpeed(currentTest.vehicle)==0.0 then 
            Wait(2000)
            if GetEntitySpeed(currentTest.vehicle)==0.0 then 
                T=true
                break 
            else 
                currentTest.subtitle="Please pull up ~y~on the right"
            end 
        else 
            if T then 
                currentTest.subtitle="Thank you, please move off again when you are ready"
                Y=true
                issueSerious("Controlled Stop - Serious")
                break 
            end 
        end
        Wait(0)
    end
    Wait(2000)
    if not Y then 
        currentTest.subtitle="Thank you, please move off again when you are ready"
    else 
        currentTest.subtitle="Thank you, please move off again when you are ready"
    end
    TriggerEvent("arma:PlaySound", "moveOffWhenReady")
    Wait(2000)
    currentTest.subtitle="Follow the ~y~sat nav"
    useTablet()
end
function operateHeadlights()
    PlaySoundFrontend(-1,"Out_Of_Bounds_Timer","DLC_HEISTS_GENERAL_FRONTEND_SOUNDS",1)
    tARMA.notifyPicture(i.images.dict,i.images.govLarge,"Listen carefully for directions","Show Me Question","DVSA")
    currentTest.subtitle="I will now ask you one ~y~show me question ~w~while driving"
    TriggerEvent("arma:PlaySound", "askShowMeQuestion")
    Wait(6000)
    local T=false
    local Z=false
    TriggerEvent("arma:PlaySound", "operateMainBeamHeadlights")
    currentTest.subtitle="When it is ~y~safe ~w~to do so, show me how you'd ~y~operate the main beam headlights."
    tARMA.notifyPicture(i.images.dict,i.images.govLarge,"Turn on your headlights as requested","Show Me Question","DVSA")
    SetTimeout(20000,function()
        T=true 
    end)
    local _=false
    while not T do 
        local u,a0,a1=GetVehicleLightsState(currentTest.vehicle)
        if a1 then 
            _=true 
        end
        if a1 then 
            Wait(5000)
            T=true 
        end
        Wait(0)
    end
    if not _ then 
        issueMinor("Show Me - Headlights")
    end
    TriggerEvent("arma:PlaySound", "continueToFollow")
    currentTest.subtitle="Thank you, please continue to follow the sat nav"
    Wait(2000)
    tARMA.notifyPicture(i.images.dict,i.images.govLarge,"Thank you, the show me question is complete","Show Me Question","DVSA")
    currentTest.subtitle="Follow the ~y~sat nav"
end
function stopSignDetection()
    PlaySoundFrontend(-1,"Out_Of_Bounds_Timer","DLC_HEISTS_GENERAL_FRONTEND_SOUNDS",1)
    TriggerEvent("arma:PlaySound", "stopSign")
    tARMA.notifyPicture(i.images.dict,i.images.govLarge,"You are legally required to stop at this sign","Stop Sign","DVSA")
    local a2=false
    local a3=false
    Citizen.CreateThread(function()
        SetTimeout(15000,function()
            a2=true 
        end)
        while not a2 do 
            if GetEntitySpeed(currentTest.vehicle)<=1.0 then 
                a3=true
                a2=true 
            end
            Wait(0)
        end
        if not a3 then 
            issueSerious("Failed to yield for a stop sign")
        end 
    end)
end
function emergencyStop()
    PlaySoundFrontend(-1,"Out_Of_Bounds_Timer","DLC_HEISTS_GENERAL_FRONTEND_SOUNDS",1)
    TriggerEvent("arma:PlaySound", "emergencyStopIntroduction")
    tARMA.notifyPicture(i.images.dict,i.images.govLarge,"Listen carefully for directions","Test Instruction","DVSA")
    currentTest.subtitle="We will soon carry out an ~y~emergency stop~w~, I will give you a warning before you should stop"
    Wait(3000)
    currentTest.subtitle="You should have practiced this with your ~y~approved driving instructor"
    Wait(3000)
    currentTest.subtitle="When I say ~r~stop ~w~you should react as soon as possible"
    Wait(math.random(7000,15000))
    TriggerEvent("arma:PlaySound", "stopNowMessage")
    currentTest.subtitle="~r~STOP ~w~- Perform an emergency stop"
    tARMA.notifyPicture(i.images.dict,i.images.govLarge,"Perform an emergency stop immediately","STOP","DVSA")
    Wait(3000)
    if not GetEntitySpeed(currentTest.vehicle)==0.0 then 
        issueMinor("ES - Timing")
    else 
        currentTest.subtitle="~r~STOP ~w~- Remain stopped"
    end
    Wait(3000)
    if not GetEntitySpeed(currentTest.vehicle)==0.0 then 
        issueSerious("ES - Failed")
    end
    Wait(3000)
    TriggerEvent("arma:PlaySound", "moveOffWhenReady")
    currentTest.subtitle="Thank you, please continue to follow the sat nav"
    Wait(2000)
    currentTest.subtitle="Follow the ~y~sat nav"
    useTablet()
end
function useTablet()
    local B=tARMA.loadModel('prop_cs_tablet')
    currentTest.tabletHandle=CreateObject(B,0,0,0,true,true,true)
    AttachEntityToEntity(currentTest.tabletHandle,currentTest.ped,GetPedBoneIndex(currentTest.ped,57005),0.17,0.10,-0.13,24.0,180.0,180.0,true,true,false,true,1,true)
    RequestAnimDict("amb@world_human_seat_wall_tablet@female@base")
    while not HasAnimDictLoaded("amb@world_human_seat_wall_tablet@female@base")do 
        Wait(0)
    end
    TaskPlayAnim(currentTest.ped,"amb@world_human_seat_wall_tablet@female@base","base",8.0,1,-1,1,1.0,0,0,0)
    SetTimeout(9000,function()
        DeleteEntity(currentTest.tabletHandle)
        StopAnimTask(currentTest.ped,"amb@world_human_seat_wall_tablet@female@base","base",1.0)
    end)
end
function cameraTransition(t)
    NetworkOverrideClockTime(09,0,0)
    ExecuteCommand("hideui")
    local a4=GetRenderingCam()
    local ped=tARMA.getPlayerPed()
    FreezeEntityPosition(ped,true)
    local a5=tARMA.getPlayerCoords()
    SetFocusPosAndVel(239.4198,-1392.593,35.75024)
    local a6=CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA",239.4198,-1392.593,35.75024,0.0,0.0,0.0,65.0,0,2)
    PointCamAtCoord(a6,218.9802,-1390.47,30.57727)
    SetCamActive(a6,true)
    RenderScriptCams(true,true,0,1,0)
    currentTest.subtitle="This is the ~b~DVSA ~w~test centre. You'll finish your test here."
    drawNativeNotification()
    Wait(7000)
    local a7=CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA",218.7297,-1370.44,32.96997,0.0,0.0,0.0,65.0,0,2)
    PointCamAtCoord(a7,t.x,t.y,t.z)
    SetCamActiveWithInterp(a7,a6,10000,5,5)
    currentTest.subtitle="This is your vehicle in which you'll be ~b~examined~w~."
    Wait(10000)
    DestroyCam(a6,0)
    DestroyCam(a7,0)
    RenderScriptCams(false,true,3000,1,0)
    Wait(5000)
    ClearFocus()
    FreezeEntityPosition(ped,false)
    ExecuteCommand("showui")
    currentTest.subtitle="Please wait for the ~b~examiner~w~."
end

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('dvsa', 'main')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button("Driving Licence","View and manage your driving licence",{RightBadge=RageUI.BadgeStyle.Car},true,function(a8,a9,aa)
            end,RMenu:Get('dvsa','licence'))
            RageUI.Button("Driving Test History","View your previous driving tests",{RightBadge=RageUI.BadgeStyle.Car},true,function(a8,a9,aa)
            end,RMenu:Get('dvsa','tests'))
            RageUI.Button("DVSA Alerts","View alerts received from the DVSA",{RightBadge=RageUI.BadgeStyle.Car},true,function(a8,a9,aa)
            end,RMenu:Get('dvsa','alerts'))
            if g then 
                if not currentTest.active and not a.full and a.active then 
                    if not currentTest.requested then 
                        RageUI.Button("Begin driving test","Begin your driving test",{RightBadge=RageUI.BadgeStyle.Alert,RightLabel="£"..getMoneyStringFormatted(i.test.price)},true,function(a8,a9,aa)
                            if aa then 
                                if a.banned then 
                                    tARMA.notifyPicture(i.images.dict,i.images.govLarge,"Your licence has been suspended","UK Government","DVSA")
                                else 
                                    if not currentTest.requested then 
                                        TriggerServerEvent("ARMA:beginTest")
                                        currentTest.requested=true 
                                    end 
                                end
                                RageUI.ActuallyCloseAll()
                            end 
                        end)
                    else 
                        RageUI.Button("No tests available","Try again in a few minutes",{RightBadge=RageUI.BadgeStyle.Alert},true,function(a8,a9,aa)
                            if aa then 
                                tARMA.notifyPicture(i.images.dict,i.images.govLarge,"We have no tests available, please try again in a few minutes.","UK Government","Driving Test")
                            end 
                        end)
                    end 
                else 
                    if not currentTest.active and (a.full or a.active) then 
                        RageUI.Button("Surrender your licence","Surrender your driving licence to the DVSA",{RightBadge=RageUI.BadgeStyle.Alert},true,function(a8,a9,aa)
                            if aa then 
                                a.full=false
                                a.active=false
                                tARMA.notifyPicture(i.images.dict,i.images.govLarge,"You've surrendered your licence. Your points and offences will remain held.","UK Government","Licence Surrendered")
                                TriggerServerEvent("ARMA:surrenderLicence")
                            end 
                        end)
                    end 
                end 
            end 
        end) 
    end
    if RageUI.Visible(RMenu:Get('dvsa', 'licence')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            if a.full then 
                RageUI.Button("Licence Type:","This indiates if you hold a full licence",{RightLabel="Full",RightBadge=RageUI.BadgeStyle.Car},true,function(a8,a9,aa)
                    if aa then 
                        tARMA.notifyPicture(i.images.dict,i.images.govLarge,"Your licence is full. You have passed your driving test.","UK Government","DVSA")
                    end 
                end)
            else 
                if a.banned then 
                    RageUI.Button("Licence Type:","This indiates if you hold a full licence",{RightLabel="Suspended",RightBadge=RageUI.BadgeStyle.Alert},true,function(a8,a9,aa)
                        if aa then 
                            tARMA.notifyPicture(i.images.dict,i.images.govLarge,"Your licence has been suspended","UK Government","DVSA")
                        end 
                    end)
                else 
                    if a.active then 
                        RageUI.Button("Licence Type:","This indiates if you hold a full licence",{RightLabel="Provisional",RightBadge=RageUI.BadgeStyle.Alert},true,function(a8,a9,aa)
                            if aa then 
                                tARMA.notifyPicture(i.images.dict,i.images.govLarge,"Your licence is currently provisional, take a test at the DVSA test centre","UK Government","DVSA")
                            end 
                        end)
                    else 
                        RageUI.Button("Licence Type:","This indiates if you hold a full licence",{RightLabel="No licence",RightBadge=RageUI.BadgeStyle.Alert},true,function(a8,a9,aa)
                            if aa then 
                                tARMA.notifyPicture(i.images.dict,i.images.govLarge,"You do not hold a UK Driving licence.","UK Government","DVSA")
                            end 
                        end)
                        if not f then 
                            RageUI.Button("Apply for a provisional licence","Apply for a provisional licence",{RightBadge=RageUI.BadgeStyle.Car},true,function(a8,a9,aa)
                                if aa then 
                                    TriggerServerEvent("ARMA:activateLicence")
                                    f=true
                                    tARMA.notifyPicture(i.images.dict,i.images.govLarge,"We will process your application shortly. Thank you for submitting.","UK Government","DVSA")
                                end 
                            end)
                        end 
                    end 
                 end 
             end
            if a.active then 
                RageUI.Button("Penalty Points:","This indicates your amount of licence points",{RightLabel=a.points},true,function(a8,a9,aa)
                    if aa then 
                        tARMA.notifyPicture(i.images.dict,i.images.govLarge,"Your licence currently has "..a.points.." penalty points.","UK Government","DVSA")
                    end 
                end)
                RageUI.Button("Licence Number:","This indicates your licence number",{RightLabel=a.id},true,function(a8,a9,aa)
                    if aa then 
                        tARMA.notifyPicture(i.images.dict,i.images.govLarge,"Your licence number is "..a.id..", this is issued with your licence.","UK Government","DVSA")
                    end 
                end)
                RageUI.Button("Licence Issued:","This indicates the date and time of issue",{RightLabel=a.date},true,function(a8,a9,aa)
                    if aa then 
                        tARMA.notifyPicture(i.images.dict,i.images.govLarge,"Your licence was issued at "..a.date..".","UK Government","DVSA")
                    end 
                end)
                if next(b) then 
                    RageUI.Separator("DVSA - Licence Record")
                    for r,s in pairs(b)do 
                        RageUI.Button(s.offence,"Date: "..s.date.." | Type: "..s.type,{RightBadge=RageUI.BadgeStyle.Alert},true,function(a8,a9,aa)
                            if aa then 
                                tARMA.notifyPicture(i.images.dict,i.images.govLarge,"You were given "..s.points.." penalty points on "..s.date..".","UK Government","Offence: "..s.offence)
                            end 
                        end)
                    end 
                end 
            end 
        end) 
    end
    if RageUI.Visible(RMenu:Get('dvsa', 'tests')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            if c~=nil and next(c) then 
                for r,s in pairs(c)do 
                    local ac="~r~FAIL"
                    if s.pass then 
                        ac="~g~PASS"
                    end
                    RageUI.Button(s.date.." | Result: "..ac,"~r~Serious Faults~w~: "..s.serious.." | ~b~Minor Faults~w~: "..s.minor,{RightBadge=RageUI.BadgeStyle.Alert},true,function(a8,a9,aa)
                        if aa then 
                            tARMA.notifyPicture(i.images.dict,i.images.govLarge,"Your test result was a "..ac.." ~w~with ~b~"..s.serious.." ~w~serious faults and ~b~"..s.minor.." ~w~minor faults.","UK Government","Driving Test Result")
                            if s.minor~=nil and s.pass and s.minor>0 then 
                                tARMA.notifyPicture(i.images.dict,i.images.govLarge,"You received ~b~"..s.minor.." ~w~minors","UK Government","Driving Test Result")
                            elseif not s.pass then 
                                if s.seriousReason~=nil then 
                                    tARMA.notifyPicture(i.images.dict,i.images.govLarge,"Your serious faults were: ~b~"..s.seriousReason,"~w~UK Government","Driving Test Result")
                                end
                                if s.minor>0 then 
                                    if s.minorsReason~=nil then 
                                        tARMA.notifyPicture(i.images.dict,i.images.govLarge,"You received minors for ~b~"..s.minorsReason,"UK Government","Driving Test Result")
                                    end 
                                end 
                            end 
                        end 
                    end)
                end 
            end  
        end) 
    end
    if RageUI.Visible(RMenu:Get('dvsa', 'alerts')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            if next(d) then
                for r,s in pairs(d)do 
                    if s.date==nil then 
                        s.date=""
                    end
                    RageUI.Button(s.title.." "..s.date,"Press to read this message",{RightBadge=RageUI.BadgeStyle.Alert},true,function(a8,a9,aa)
                        if aa then 
                            tARMA.notifyPicture(i.images.dict,i.images.govLarge,s.message,"UK Government",s.title)
                        end 
                    end)
                end
            else
                RageUI.Separator('~r~There are no current DVSA alerts.')
            end
        end) 
    end
end)

RegisterCommand("dl",function(ad,ae)
    RageUI.ActuallyCloseAll()
    RageUI.Visible(RMenu:Get('dvsa','licence'),false)
    RageUI.Visible(RMenu:Get('dvsa','tests'),false)
    RageUI.Visible(RMenu:Get('dvsa','alerts'),false)
    RageUI.Visible(RMenu:Get('dvsa','main'),true)
end)
Citizen.CreateThread(function()
    while true do 
        if currentTest.active then 
            DisableControlAction(0,75,true)
            DisableControlAction(27,75,true)
            if currentTest.subtitle~=""then 
                RageUI.Text({message=currentTest.subtitle})
            end 
        end
        if not a.full and not a.banned and not currentTest.active then 
            local vehicle=tARMA.getPlayerVehicle()
            if vehicle~=0 and GetPedInVehicleSeat(vehicle,-1)==tARMA.getPlayerPed()then 
                if not e.active then 
                    createPlate(vehicle)
                elseif not vehicle==e.vehicle then 
                    removePlate()
                    Wait(1000)
                    createPlate(vehicle)
                end 
            else 
                if e.active then 
                    removePlate()
                end 
            end 
        end
        Wait(100)
    end 
end)
local function af(vehicle,F,ag)
    if GetResourceState("els")=="started"then 
        if exports["els"]:DoesVehicleHaveConfig(vehicle)then 
            if exports["els"]:DoesVehicleHaveLightsEnabled(vehicle)then 
                return false 
            else 
                return F>230.0 
            end 
        end 
    end
    return F>ag 
end
Citizen.CreateThread(function()
    Wait(1000)
    while true do 
        local vehicle=tARMA.getPlayerVehicle()
        if vehicle~=0 and GetPedInVehicleSeat(vehicle,-1)==tARMA.getPlayerPed()then 
            local F=GetEntitySpeed(vehicle)*2.236936
            local t=tARMA.getPlayerCoords()
            if t~=nil then 
                for r,s in pairs(i.cameras)do 
                    if not s.flashed then 
                        local E=#(t-s.coords)
                        if E<15.0 then 
                            if af(vehicle,F,s.limit)then 
                                flashCamera(r)
                            end 
                        end 
                    end 
                end 
            end 
        end
        Wait(0)
    end 
end)
function speedCameraFlash(t,aj)
    for ak=1,2 do 
        local T=false
        Citizen.SetTimeout(450,function()
            T=true 
        end)
        while not T do 
            DrawSpotLight(t.x,t.y,t.z,aj.x,aj.y,aj.z,221,221,221,70.0,70.0,2.3,25.0,25.6)
            Wait(0)
        end
        Wait(100)
        ak=ak+1 
    end 
end
RegisterNetEvent("ARMA:speedCameraFlash",function(t,aj)
    for ak=1,2 do 
        local T=false
        Citizen.SetTimeout(450,function()
            T=true 
        end)
        while not T do 
            DrawSpotLight(t.x,t.y,t.z,aj.x,aj.y,aj.z,221,221,221,70.0,70.0,2.3,25.0,25.6)
            Wait(0)
        end
        Wait(100)
        ak=ak+1 
    end 
end)
function flashCamera(al)
    i.cameras[al].flashed=true
    local am=GetOffsetFromEntityInWorldCoords(i.cameras[al].prop,0.0,12.0,0.5)
    local u,v=GetGroundZFor_3dCoord(am.x,am.y,am.z,0)
    local an=vector3(am.x,am.y,v)-vector3(i.cameras[al].coords.x,i.cameras[al].coords.y,i.cameras[al].coords.z+3.0)
    TriggerServerEvent("ARMA:speedCameraFlashServer",math.ceil(GetEntitySpeed(GetVehiclePedIsIn(tARMA.getPlayerPed(), false))*2.2369))
    speedCameraFlash(i.cameras[al].coords,an)
    Citizen.SetTimeout(10000,function()
        i.cameras[al].flashed=false 
    end)
    PlaySoundFrontend(-1,"ScreenFlash","MissionFailedSounds",1)
    AnimpostfxPlay("FocusOut",0,false)
    Wait(2000)
    AnimpostfxStop("FocusOut")
end
RegisterNetEvent("ARMA:deletePlate",function(ao)
    local ap=tARMA.getObjectId(ao)
    if DoesEntityExist(ap)then 
        DeleteEntity(ap)
    end 
end)
function createPlate(vehicle)
    e.active=true
    e.vehicle=vehicle
    local B=tARMA.loadModel('prop_lplate')
    local t=tARMA.getPlayerCoords()
    e.handle=CreateObject(B,t.x,t.y,t.z,false,false,false)
    e.handle2=CreateObject(B,t.x,t.y,t.z,false,false,false)
    while not DoesEntityExist(e.handle)and not DoesEntityExist(e.handle2)do 
        Wait(0)
    end
    local aq=GetEntityBoneIndexByName(vehicle,"windscreen")
    AttachEntityToEntity(e.handle,vehicle,aq,0.0,0.3,-0.1,-25.0,0.0,180.0,true,true,false,true,0,true)
    local ar=GetEntityBoneIndexByName(vehicle,"windscreen_r")
    AttachEntityToEntity(e.handle2,vehicle,ar,0.0,0.2,-0.1,-10.0,0.0,0.0,true,true,false,true,0,true)
    tARMA.notifyPicture(i.images.dict,i.images.lPlate,i.notifications.lPlatesAdded,"DVSA","Licence Services")
    tARMA.notifyPicture(i.images.dict,i.images.lPlate,i.notifications.lPlatesAdded2,"DVSA","Licence Services")
end
function makeVehicleCrash(as,J,H,L,at)
    tARMA.loadModel(as)
    local I=tARMA.spawnVehicle(as,H,at,true,true)
    while not DoesEntityExist(I)do 
        Wait(0)
    end
    SetModelAsNoLongerNeeded(as)
    tARMA.loadModel(J)
    local K=CreatePed(4,J,H,at,false)
    while not DoesEntityExist(K)do 
        Wait(0)
    end
    SetEntityInvincible(K,true)
    SetPedAlertness(K,0.0)
    TaskWarpPedIntoVehicle(K,I,-1)
    SetVehicleEngineOn(I,true,true,false)
    while not IsPedInVehicle(K,I)do 
        Wait(0)
    end
    TaskVehicleDriveToCoord(K,I,L.x,L.y,L.z,30.0,1.0,as,786472,1.0,true)
    Citizen.SetTimeout(20000,function()
        if DoesEntityExist(I)then 
            DeleteEntity(I)
        end
        if DoesEntityExist(K)then 
            DeleteEntity(K)
        end 
    end)
end
function removePlate()
    e.active=false
    if DoesEntityExist(e.handle)then 
        NetworkRequestControlOfEntity(e.handle)
        while not NetworkHasControlOfEntity(e.handle)do 
            Wait(0)
        end
        DeleteEntity(e.handle)
    end
    if DoesEntityExist(e.handle2)then 
        NetworkRequestControlOfEntity(e.handle2)
        while not NetworkHasControlOfEntity(e.handle2)do 
            Wait(0)
        end
        DeleteEntity(e.handle2)
    end 
end
function convertSpeed(F)
    return F*2.236936 
end