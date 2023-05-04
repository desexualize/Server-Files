local a={active=false,spawnedDecks=false,coords=vector3(0,0,0),handles={}}
local b={volume=100}
local c={}
local d=0
local e=vector3(0.0,0.0,0.0)
local f=0
local g=false
local h=false
local i={}
local j={{"Big Cone","prop_roadcone01a"}}
RMenu.Add('MUSICMENU','main',RageUI.CreateMenu("Sound System","~d~DJ Mixer",1300,250))
RMenu.Add('MUSICMENU','admin',RageUI.CreateSubMenu(RMenu:Get("MUSICMENU","main"),"DJ Admin","~d~DJ Admin Menu",1300,250))
TriggerEvent('chat:addSuggestion','/play','Play a song on the DJ Mixer',{{name="URL",help="Video ID"}})
TriggerEvent('chat:addSuggestion','/djmenu','Toggle the DJ Mixer')
TriggerEvent('chat:addSuggestion','/djadmin','Administrate the use of the DJ Mixer')
RageUI.CreateWhile1(1.0,RMenu:Get('MUSICMENU','main'),nil,function()
    RageUI.IsVisible(RMenu:Get('MUSICMENU','main'),true,false,true,function()
        if not a.active then 
            if h then 
                RageUI.ButtonWithStyle("Start Session", "Start a new DJ Session", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then 
                        setupDj()
                    end 
                end)
            end 
        else 
            RageUI.SliderProgress("Song Volume",b.volume,100,"Select or update the song volume",{ProgressBackgroundColor={R=0,G=0,B=0,A=255},ProgressColor={R=0,G=117,B=194,A=255}},true,function(k,m,l,n)
                if m then 
                    if n~=b.volume then 
                        b.volume=n
                        if b.volume%10==0 then 
                            updateVolume()
                        end
                        drawNativeText("~d~DJ~w~: Volume Updated")
                    end 
                end
                b.volume=n 
            end)
            RageUI.ButtonWithStyle("Skip Ahead","Skip 20 seconds ahead",{},true,function(k,l,m)
                if m then 
                    skipDj(true)
                    drawNativeText("~d~DJ~w~: Song Skipped")
                end 
            end)
            RageUI.ButtonWithStyle("Skip Back","Skip 20 seconds back",{},true,function(k,l,m)
                if m then 
                    skipDj(false)
                    drawNativeText("~d~DJ~w~: Song Skipped")
                end 
            end)
            RageUI.ButtonWithStyle("Stop Song","Stop the current song",{},true,function(k,l,m)
                if m then 
                    stopDjSong()
                    drawNativeText("~d~DJ~w~: Song Stopped")
                end 
            end)
            RageUI.ButtonWithStyle("End Session","Stop the current DJ Session",{},true,function(k,l,m)
                if m then 
                    stopDj()
                    drawNativeText("~d~DJ~w~: Session Ended")
                end 
            end)
            RageUI.ButtonWithStyle("Help","Assistance message",{},true,function(k,l,m)
                if m then 
                    TriggerEvent("AQUA:showNotification",{text="The Video ID is the ID at the end of the YouTube URL after =",height="200px",width="auto",colour="#FFF",background="#32CD32",pos="bottom-right",icon="success"},5000)
                end 
            end)
        end 
    end,function()
    end)
    RageUI.IsVisible(RMenu:Get('MUSICMENU','admin'),true,false,true,function()
        if table.count(i)>0 then 
            for o,p in pairs(i)do 
                if i[o]~=nil then 
                    local distance = round2(#(getPlayerCoords()-p[2]),2)
                    RageUI.ButtonWithStyle("ID: "..p[3].." - Started: "..p[5].."","Name: "..p[4].." Distance Away: "..distance.." metres",{RightLabel="→→→"},true,function(k,l,m)
                        if m then 
                            TriggerServerEvent("AQUA:adminStopSong",p[1])
                            table.remove(i,o)
                        end 
                    end)
                end 
            end 
        end 
    end,function()
    end)
end)
function round2(q,r)
    return math.floor(q*math.pow(10,r)+0.5)/math.pow(10,r)
end

RegisterNetEvent("AQUA:playDjSong")
AddEventHandler("AQUA:playDjSong",function(s,coords,t,u)
    local v=getPlayerCoords()
    local w=#(coords-v)
    if w<30.0 then 
        SendNUIMessage({type='djPlay',song=s,volume=90})
        drawNativeText("~d~DJ "..u.."~w~: New Song playing")
        for o,p in pairs(c)do
            if p[1]==coords then 
                c[o]=nil 
            end 
        end
        c[t]={coords,s,true}
    else 
        c[t]={coords,s,false}
    end 
end)
RegisterNetEvent("AQUA:requestCurrentProgress")
AddEventHandler("AQUA:requestCurrentProgress",function(s,coords)
    if not g then 
        if specificSongPlaying(coords)then 
            d=s
            e=coords
            SendNUIMessage({type='requestProgress'})
        end 
    end 
end)
RegisterNetEvent("AQUA:toggleDjMenu")
AddEventHandler("AQUA:toggleDjMenu",function()
    RageUI.Visible(RMenu:Get('MUSICMENU','main'),true)
    h=true 
end)
RegisterNetEvent("AQUA:toggleDjAdminMenu")
AddEventHandler("AQUA:toggleDjAdminMenu",function(x)
    RageUI.Visible(RMenu:Get('MUSICMENU','admin'),true)
    i=x 
end)
RegisterNetEvent("AQUA:finaliseSong")
AddEventHandler("AQUA:finaliseSong",function(y)
    if a.active then 
        TriggerServerEvent("AQUA:playDjSongServer",y,a.coords)
    end 
end)
RegisterNetEvent("AQUA:updateDjVolume")
AddEventHandler("AQUA:updateDjVolume",function(coords,z)
    if specificSongPlaying(coords)then 
        SendNUIMessage({type='djVolume',volume=z})
    end 
end)
RegisterNetEvent("AQUA:stopSong")
AddEventHandler("AQUA:stopSong",function(coords)
    local A=false
    for o,p in pairs(c)do 
        if p[1]==coords then 
            A=true
            c[o]=nil 
        end 
    end
    if A then 
        SendNUIMessage({type='djStop'})
    end 
end)
RegisterNetEvent("AQUA:skipDj")
AddEventHandler("AQUA:skipDj",function(coords,B)
    if specificSongPlaying(coords)then 
        if B then 
            SendNUIMessage({type='djSkipAhead'})
        else 
            SendNUIMessage({type='djSkipBack'})
        end 
    end 
end)
function skipDj(B)
    if songPlaying()then 
        TriggerServerEvent("AQUA:skipServer",a.coords,B)
    end 
end
function setupDj()
    a.active=true
    a.coords=getPlayerCoords()
    a.spawnedDecks=true
    createDjObject(0.0,1.5,0.0,`ba_prop_battle_dj_stand`,0.0)
    createDjObject(-1.5,1.5,0.0,`ba_prop_battle_club_speaker_large`,180.0)
    createDjObject(1.5,1.5,0.0,`ba_prop_battle_club_speaker_large`,180.0)
    createDjObject(0.0,-1.2,0.0,`prop_studio_light_01`,180.0)
end
function createDjObject(C,D,E,F,G)
    local F=loadModel(F)
    coords=GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()),C,D,E)
    local H=CreateObject(F,coords.x,coords.y,coords.z,true,true,true)
    table.insert(a.handles,H)
    PlaceObjectOnGroundProperly(H)
    FreezeEntityPosition(H,true)
    local I=GetEntityHeading(GetPlayerPed(PlayerId()))
    SetEntityHeading(H,I+G)
end
function stopDj()
    if songPlaying()then 
        TriggerServerEvent("AQUA:stopSongServer",a.coords)
    end
    a.active=false
    a.spawnedDecks=false
    for o in pairs(a.handles)do 
        DeleteObject(a.handles[o])
    end
    a.handles={}
end
function stopDjSong()
    if songPlaying()then 
        TriggerServerEvent("AQUA:stopSongServer",a.coords)
    end 
end
function updateVolume()
    if songPlaying()then 
        TriggerServerEvent("AQUA:updateVolumeServer",a.coords,b.volume)
    end 
end
function specificSongPlaying(coords)
    local A=false
    for o,p in pairs(c)do 
        if p[1]==coords and p[3]then 
            A=true 
        end 
    end
    return A 
end
function songPlaying()
    local A=false
    for o,p in pairs(c)do 
        if p[1]==a.coords then 
            A=true 
        end 
    end
    return A 
end
function func_checkDjSongs(J)
    for o,p in pairs(c)do 
        if#(J.playerCoords-p[1])>45.0 then 
            c[o][3]=false
            SendNUIMessage({type='djStop'})
        else 
            if not c[o][3]then 
                g=true
                TriggerServerEvent('AQUA:requestCurrentProgressServer',o,p[1])
                c[o][3]=true 
            end 
        end 
    end 
end
createThreadOnTick(func_checkDjSongs)
RegisterNUICallback('returnProgress',function(K,L)
    if K.progress~=nil then 
        if K.progress~=0 then 
            TriggerServerEvent("AQUA:returnProgressServer",d,e,K.progress)
        end 
    end
    L('return')
end)
RegisterNetEvent("AQUA:returnProgress")
AddEventHandler("AQUA:returnProgress",function(s,coords,M,N)
    if g then 
        if specificSongPlaying(coords)then 
            c[s]=nil
            c[s]={coords,s,true}
            SendNUIMessage({type='djPlay',song=N,volume=90})
            Wait(1000)
            SendNUIMessage({type='skipTo',time=M})
            g=false 
        end 
    end 
end)