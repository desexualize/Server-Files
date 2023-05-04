local a=false
local b=0
local c=0
local d=0
local e=module("cfg/cfg_cctv")
Citizen.CreateThread(function()
    while true do 
        local f=GetEntityCoords(PlayerPedId(),false)
        for g=1,#e.Locations do 
            local h=#(f-e.Locations[g].camBox.position)
            e.Locations[g].camBox.distance=h 
        end
        Wait(250)
    end 
end)
Citizen.CreateThread(function()
    while true do 
        for g=1,#e.Locations do 
            local h=e.Locations[g].camBox.distance
            if e.DebugMode then 
                local i=PlayerPedId()
                local f=GetEntityCoords(i,false)
                local j=GetEntityRotation(i,2)
                print("X: "..f.x.."Y: "..f.y.."Z: "..f.z.."H: "..j)
            end
            if h<=1.0 then 
                local k=e.Locations[g].camBox.label
                local l=e.Locations[g].camBox.position.x
                local m=e.Locations[g].camBox.position.y
                local n=e.Locations[g].camBox.position.z
                cctvDraw3DText(l,m,n,tostring("~o~[E]~w~ Use "..k.." Cameras"))
                if IsControlJustPressed(1,38)and d==0 and h<=1.2 then 
                    local o=e.Locations[g].cameras[1].x
                    local p=e.Locations[g].cameras[1].y
                    local q=e.Locations[g].cameras[1].z
                    local r=e.Locations[g].cameras[1].r
                    SetFocusArea(o,p,q,o,p,q)
                    ChangeSecurityCamera(o,p,q,r)
                    SendNUIMessage({type="enablecam",label=e.Locations[g].cameras[1].label,box=e.Locations[g].camBox.label})
                    b=g
                    c=1
                    FreezeEntityPosition(GetPlayerPed(PlayerId()),true)
                    DisablePlayerFiring(PlayerPedId(), true)
                end 
            end
            if d~=0 then 
                local s=CreateInstuctionScaleform("instructional_buttons")
                DrawScaleformMovieFullscreen(s,255,255,255,255,0)
                SetTimecycleModifier("scanline_cam_cheap")
                SetTimecycleModifierStrength(2.0)
                if e.HideRadar then 
                    DisplayRadar(false)
                end
                if IsControlJustPressed(1,194)then 
                    CloseSecurityCamera()
                    SendNUIMessage({type="disablecam"})
                    if e.HideRadar then 
                        DisplayRadar(true)
                    end 
                end
                if IsControlJustPressed(1,174)then 
                    local t
                    if c==1 then 
                        t=#e.Locations[b].cameras 
                    else 
                        t=c-1 
                    end
                    local u=e.Locations[b].cameras[t].x
                    local v=e.Locations[b].cameras[t].y
                    local w=e.Locations[b].cameras[t].z
                    local x=e.Locations[b].cameras[t].r
                    SetFocusArea(u,v,w,u,v,w)
                    SendNUIMessage({type="updatecam",label=e.Locations[b].cameras[t].label})
                    ChangeSecurityCamera(u,v,w,x)
                    c=t 
                end
                if IsControlJustPressed(1,175)then 
                    local t
                    if c==#e.Locations[b].cameras then 
                        t=1 
                    else 
                        t=c+1 
                    end
                    local u=e.Locations[b].cameras[t].x
                    local v=e.Locations[b].cameras[t].y
                    local w=e.Locations[b].cameras[t].z
                    local x=e.Locations[b].cameras[t].r
                    SetFocusArea(u,v,w,u,v,w)
                    SendNUIMessage({type="updatecam",label=e.Locations[b].cameras[t].label})
                    ChangeSecurityCamera(u,v,w,x)
                    c=t 
                end
                if e.Locations[b].cameras[c].canRotate then 
                    local y=GetCamRot(d,2)
                    if IsControlPressed(1,32)then 
                        if y.x<=0.0 then 
                            SetCamRot(d,y.x+0.7,0.0,y.z,2)
                        end 
                    end
                    if IsControlPressed(1,33)then 
                        if y.x>=-50.0 then 
                            SetCamRot(d,y.x-0.7,0.0,y.z,2)
                        end 
                    end
                    if IsControlPressed(1,34)then 
                        SetCamRot(d,y.x,0.0,y.z+0.7,2)
                    end
                    if IsControlPressed(1,35)then 
                        SetCamRot(d,y.x,0.0,y.z-0.7,2)
                    end 
                end 
            end 
        end
        Citizen.Wait(0)
    end 
end)
function ChangeSecurityCamera(z,A,B,C)
    if d~=0 then 
        DestroyCam(d,0)
        d=0 
    end
    local D=CreateCam("DEFAULT_SCRIPTED_CAMERA",1)
    SetCamCoord(D,z,A,B)
    SetCamRot(D,C.x,C.y,C.z,2)
    RenderScriptCams(1,0,0,1,1)
    Citizen.Wait(250)
    d=D 
end
function CloseSecurityCamera()
    DestroyCam(d,0)
    RenderScriptCams(0,0,1,1,1)
    d=0
    ClearTimecycleModifier("scanline_cam_cheap")
    SetFocusEntity(GetPlayerPed(PlayerId()))
    if e.HideRadar then 
        DisplayRadar(true)
    end
    FreezeEntityPosition(GetPlayerPed(PlayerId()),false)
    DisablePlayerFiring(PlayerPedId(), false)
end
function cctvDraw3DText(z,A,B,E)
    local F,G,H=World3dToScreen2d(z,A,B)
    local I=GetGameplayCamCoords()
    local h=#(vector3(I.x,I.y,I.z)-vector3(z,A,B))
    local J=1/h*2
    local K=1/GetGameplayCamFov()*100
    local J=J*K
    if F then 
        SetTextScale(0.0*J,0.35*J)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255,255,255,255)
        SetTextDropshadow(0,0,0,0,255)
        SetTextEdge(2,0,0,0,150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(E)
        DrawText(G,H)
    end 
end
function CreateInstuctionScaleform(L)
    local L=RequestScaleformMovie(L)
    while not HasScaleformMovieLoaded(L)do 
        Citizen.Wait(0)
    end
    PushScaleformMovieFunction(L,"CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(L,"SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(L,"SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    InstructionButton(GetControlInstructionalButton(1,175,true))
    InstructionButtonMessage("Go Forward")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(L,"SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    InstructionButton(GetControlInstructionalButton(1,194,true))
    InstructionButtonMessage("Close Camera")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(L,"SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(2)
    InstructionButton(GetControlInstructionalButton(1,174,true))
    InstructionButtonMessage("Go Back")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(L,"DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(L,"SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()
    return L 
end
function InstructionButton(M)
    N_0xe83a3e3557a56640(M)
end
function InstructionButtonMessage(E)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(E)
    EndTextCommandScaleformString()
end